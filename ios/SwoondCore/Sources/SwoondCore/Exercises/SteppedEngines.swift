import Foundation

// MARK: term-match

/// Tap a term, then a definition. Score = pairs matched on the first attempt / total.
/// Hearts: -1 (max one per exercise) once there are 2 wrong attempts. XP: +10 if <= 1 wrong attempt, else +5.
public struct TermMatchEngine: ExerciseSession {
    public let payload: TermMatchPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public private(set) var matchedTermIds: Set<String> = []
    public private(set) var wrongAttempts = 0
    private var wrongByTerm: [String: Int] = [:]
    private var firstTryCorrect = 0
    public var activityType: ActivityType { .termMatch }

    public init(payload: TermMatchPayload, conceptIds: [ConceptID] = []) throws {
        guard payload.pairs.count >= 2, Set(payload.pairs.map(\.id)).count == payload.pairs.count else { throw ExerciseError.invalidPayload("pairs must be >= 2 with unique ids") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    /// All definitions shown (pairs + distractors), shuffled deterministically.
    public func definitionOptions<G: RandomNumberGenerator>(using g: inout G) -> [String] {
        (payload.pairs.map(\.definition) + (payload.distractorDefinitions ?? [])).shuffled(using: &g)
    }

    public func wrongAttempts(forTerm id: String) -> Int { wrongByTerm[id] ?? 0 }

    public mutating func submit(termId: String, definition: String) throws -> ExerciseStepResult {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        guard let pair = payload.pairs.first(where: { $0.id == termId }) else { throw ExerciseError.invalidAnswer("unknown term") }
        guard !matchedTermIds.contains(termId) else { throw ExerciseError.invalidAnswer("term already matched") }
        guard payload.pairs.contains(where: { $0.definition == definition }) || (payload.distractorDefinitions ?? []).contains(definition) else {
            throw ExerciseError.invalidAnswer("unknown definition")
        }
        if pair.definition != definition {
            wrongAttempts += 1
            wrongByTerm[termId, default: 0] += 1
            return .inProgress(StepFeedback(isCorrect: false, message: "Not that one.", meter: Double(matchedTermIds.count)))
        }
        if wrongByTerm[termId, default: 0] == 0 { firstTryCorrect += 1 }
        matchedTermIds.insert(termId)
        guard matchedTermIds.count == payload.pairs.count else {
            return .inProgress(StepFeedback(isCorrect: true, message: "Matched.", meter: Double(matchedTermIds.count)))
        }
        let total = payload.pairs.count
        let fraction = Double(firstTryCorrect) / Double(total)
        let clean = wrongAttempts <= 1
        let e = ExerciseEvaluation(activityType: .termMatch, isCorrect: clean, score: Int((fraction * 100).rounded()),
                                   xp: clean ? XPValues.correctAnswer : XPValues.halfCredit, heartsLost: wrongAttempts >= 2 ? 1 : 0,
                                   explanation: payload.explanation.summary, sayThisLine: payload.explanation.sayThisLine,
                                   notes: payload.pairs.map { "\($0.term): \($0.definition)" }, conceptIds: conceptIds, masteryFraction: fraction)
        evaluation = e
        return .finished(e)
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        guard case .pairing(let t, let d) = answer else { throw ExerciseError.unsupportedAnswer(expected: ".pairing") }
        return try submit(termId: t, definition: d)
    }
}

// MARK: talk-track

/// Conversation practice: no hearts. Smooth = clamp(start + sum of deltas, 0, 100); success at >= 60.
/// XP +40 on completion, +10 bonus if Smooth >= 80.
public struct TalkTrackEngine: ExerciseSession {
    public static let successThreshold = 60
    public static let bonusThreshold = 80

    public struct Turn: Sendable, Equatable {
        public var theirMessage: String
        public var reply: TalkTrackPayload.Reply
        public var smoothAfter: Int
    }

    public let payload: TalkTrackPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public private(set) var exchangeIndex = 0
    public private(set) var smooth: Int
    public private(set) var history: [Turn] = []
    public var activityType: ActivityType { .talkTrack }

    public init(payload: TalkTrackPayload, conceptIds: [ConceptID] = []) throws {
        guard !payload.exchanges.isEmpty, payload.exchanges.allSatisfy({ $0.replies.count >= 2 }) else { throw ExerciseError.invalidPayload("each exchange needs >= 2 replies") }
        self.payload = payload
        self.conceptIds = conceptIds
        self.smooth = min(100, max(0, payload.startingSmooth ?? 50))
    }

    public var currentExchange: TalkTrackPayload.Exchange? {
        evaluation == nil && exchangeIndex < payload.exchanges.count ? payload.exchanges[exchangeIndex] : nil
    }

    public mutating func submit(replyId: String) throws -> ExerciseStepResult {
        guard evaluation == nil, let ex = currentExchange else { throw ExerciseError.alreadyFinished }
        guard let reply = ex.replies.first(where: { $0.id == replyId }) else { throw ExerciseError.invalidAnswer("unknown reply") }
        smooth = min(100, max(0, smooth + reply.smoothDelta))
        history.append(Turn(theirMessage: ex.theirMessage, reply: reply, smoothAfter: smooth))
        exchangeIndex += 1
        guard exchangeIndex >= payload.exchanges.count else {
            return .inProgress(StepFeedback(isCorrect: reply.smoothDelta > 0, message: reply.theirResponse, coachNote: reply.coachNote, meter: Double(smooth)))
        }
        let success = smooth >= Self.successThreshold
        let e = ExerciseEvaluation(
            activityType: .talkTrack, isCorrect: success, score: smooth,
            xp: XPValues.finishedGame + (smooth >= Self.bonusThreshold ? XPValues.dailyBite : 0), heartsLost: 0,
            explanation: payload.closingNote ?? reply.coachNote, notes: history.map(\.reply.coachNote), conceptIds: conceptIds,
            masteryFraction: Double(smooth) / 100, includesCompletionBonus: true)
        evaluation = e
        return .finished(e)
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        guard case .reply(let id) = answer else { throw ExerciseError.unsupportedAnswer(expected: ".reply") }
        return try submit(replyId: id)
    }
}

// MARK: timing-tap

/// 1D timing bar. All time values are injected (`elapsedSeconds` or a marker position), so scoring is deterministic.
///
/// Hit (marker inside the zone) = 100. Miss = max(0, 60 - off*3), `off` = percentage-point distance to the nearest zone edge.
/// Pit-stop clock = 11.2 + off*0.12 s. Session score = mean of rounds. +10 per hit round, +40 on finishing.
/// One heart lost (at most) if any round scored < 40.
public struct TimingTapEngine: ExerciseSession {
    public enum AccessibilityMode: String, Sendable, Equatable { case standard, tapToStopSlow, holdAndRelease }

    public struct RoundResult: Sendable, Equatable {
        public var index: Int
        public var markerPct: Double
        public var hit: Bool
        /// Percentage points from the nearest zone edge (0 for a hit).
        public var offPct: Double
        public var score: Int
        /// `11.2 + off*0.12`.
        public var clockSeconds: Double
    }

    public static let slowZoneScale = 1.5
    public static let slowSweepScale = 1.5

    public let payload: TimingTapPayload
    public let conceptIds: [ConceptID]
    public let mode: AccessibilityMode
    /// Rounds as played (zone widened / sweep slowed in `tapToStopSlow`).
    public let rounds: [TimingTapPayload.Round]
    public private(set) var evaluation: ExerciseEvaluation?
    public private(set) var results: [RoundResult] = []
    public var activityType: ActivityType { .timingTap }

    public init(payload: TimingTapPayload, conceptIds: [ConceptID] = [], mode: AccessibilityMode = .standard) throws {
        guard !payload.rounds.isEmpty else { throw ExerciseError.invalidPayload("needs rounds") }
        for r in payload.rounds where !(r.zoneStartPct < r.zoneEndPct && r.sweepSeconds > 0) { throw ExerciseError.invalidPayload("bad round") }
        self.payload = payload
        self.conceptIds = conceptIds
        self.mode = mode
        self.rounds = mode == .tapToStopSlow ? payload.rounds.map(Self.slowed) : payload.rounds
    }

    static func slowed(_ r: TimingTapPayload.Round) -> TimingTapPayload.Round {
        let center = (r.zoneStartPct + r.zoneEndPct) / 2, half = (r.zoneEndPct - r.zoneStartPct) / 2 * slowZoneScale
        return .init(zoneStartPct: max(0, center - half), zoneEndPct: min(100, center + half), sweepSeconds: r.sweepSeconds * slowSweepScale)
    }

    public var currentRoundIndex: Int { results.count }
    public var currentRound: TimingTapPayload.Round? { evaluation == nil && results.count < rounds.count ? rounds[results.count] : nil }

    /// Triangle-wave marker position (0...100): 0 -> 100 in `sweepSeconds`, then back.
    public static func markerPct(elapsedSeconds t: Double, sweepSeconds: Double) -> Double {
        guard sweepSeconds > 0, t.isFinite else { return 0 }
        let period = 2 * sweepSeconds
        var p = t.truncatingRemainder(dividingBy: period)
        if p < 0 { p += period }
        return (p <= sweepSeconds ? p / sweepSeconds : (period - p) / sweepSeconds) * 100
    }

    public static func score(markerPct m: Double, zoneStart: Double, zoneEnd: Double) -> (hit: Bool, off: Double, score: Int) {
        if m >= zoneStart && m <= zoneEnd { return (true, 0, 100) }
        let off = m < zoneStart ? zoneStart - m : m - zoneEnd
        return (false, off, Int(max(0, 60 - off * 3).rounded()))
    }

    public mutating func submit(markerPct m: Double) throws -> ExerciseStepResult {
        guard evaluation == nil, let round = currentRound else { throw ExerciseError.alreadyFinished }
        guard m.isFinite else { throw ExerciseError.invalidAnswer("non-finite position") }
        let pos = min(100, max(0, m))
        let s = Self.score(markerPct: pos, zoneStart: round.zoneStartPct, zoneEnd: round.zoneEndPct)
        let r = RoundResult(index: results.count, markerPct: pos, hit: s.hit, offPct: s.off, score: s.score, clockSeconds: 11.2 + s.off * 0.12)
        results.append(r)
        guard results.count == rounds.count else {
            return .inProgress(StepFeedback(isCorrect: r.hit, message: nil, meter: Double(r.score)))
        }
        let hits = results.filter(\.hit).count
        let mean = Double(results.reduce(0) { $0 + $1.score }) / Double(results.count)
        let e = ExerciseEvaluation(
            activityType: .timingTap, isCorrect: mean >= 60, score: Int(mean.rounded()),
            xp: hits * XPValues.correctAnswer + XPValues.finishedGame, heartsLost: results.contains { $0.score < 40 } ? 1 : 0,
            explanation: mean >= 60 ? payload.explanation.correct : payload.explanation.incorrect, sayThisLine: payload.explanation.sayThisLine,
            notes: results.map { $0.hit ? "Round \($0.index + 1): hit" : "Round \($0.index + 1): off by \(Int($0.offPct.rounded())) points" },
            conceptIds: conceptIds, masteryFraction: mean / 100, includesCompletionBonus: true)
        evaluation = e
        return .finished(e)
    }

    /// Tap at `seconds` after the round's sweep started (injected time).
    public mutating func submit(elapsedSeconds seconds: Double) throws -> ExerciseStepResult {
        guard let round = currentRound else { throw ExerciseError.alreadyFinished }
        return try submit(markerPct: Self.markerPct(elapsedSeconds: seconds, sweepSeconds: round.sweepSeconds))
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        switch answer {
        case .markerPosition(let m): return try submit(markerPct: m)
        case .elapsed(let s): return try submit(elapsedSeconds: s)
        default: throw ExerciseError.unsupportedAnswer(expected: ".markerPosition or .elapsed")
        }
    }
}
