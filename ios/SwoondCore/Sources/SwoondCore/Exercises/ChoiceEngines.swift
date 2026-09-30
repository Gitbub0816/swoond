import Foundation

private func requireChoices(_ a: ExerciseAnswer) throws -> [String] {
    guard case .choices(let ids) = a else { throw ExerciseError.unsupportedAnswer(expected: ".choices") }
    return ids
}

// MARK: multiple-choice

/// Correct if the selected set equals `correctOptionIds` (no partial credit in v1). +10 / -1 heart.
public struct MultipleChoiceEngine: ExerciseSession {
    public let payload: MultipleChoicePayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .multipleChoice }

    public init(payload: MultipleChoicePayload, conceptIds: [ConceptID] = []) throws {
        guard payload.options.count >= 2 else { throw ExerciseError.invalidPayload("needs at least 2 options") }
        let ids = Set(payload.options.map(\.id))
        guard !payload.correctOptionIds.isEmpty, Set(payload.correctOptionIds).isSubset(of: ids) else { throw ExerciseError.invalidPayload("correctOptionIds must reference options") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    public var allowsMultiple: Bool { payload.allowMultiple ?? false }

    /// Options in display order: shuffled unless `shuffle == false`.
    public func displayOrder<G: RandomNumberGenerator>(using g: inout G) -> [TextOption] {
        (payload.shuffle ?? true) ? payload.options.shuffled(using: &g) : payload.options
    }

    @discardableResult
    public mutating func submit(selected: [String]) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        let set = Set(selected)
        guard !set.isEmpty, set.isSubset(of: Set(payload.options.map(\.id))) else { throw ExerciseError.invalidAnswer("unknown or empty selection") }
        if !allowsMultiple && set.count != 1 { throw ExerciseError.invalidAnswer("single choice requires exactly one option") }
        let correct = set == Set(payload.correctOptionIds)
        let notes = payload.options.filter { set.contains($0.id) }.compactMap(\.explanation)
        let e = ExerciseEvaluation.standard(.multipleChoice, correct: correct, explanation: payload.explanation, notes: notes, conceptIds: conceptIds)
        evaluation = e
        return e
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult { .finished(try submit(selected: requireChoices(answer))) }
}

// MARK: binary-call

public struct BinaryCallEngine: ExerciseSession {
    public let payload: BinaryCallPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .binaryCall }

    public init(payload: BinaryCallPayload, conceptIds: [ConceptID] = []) throws {
        guard payload.choices.count >= 2, payload.choices.contains(where: { $0.id == payload.correctChoiceId }) else { throw ExerciseError.invalidPayload("correctChoiceId must reference a choice") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    @discardableResult
    public mutating func submit(choiceId: String) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        guard payload.choices.contains(where: { $0.id == choiceId }) else { throw ExerciseError.invalidAnswer("unknown choice") }
        let e = ExerciseEvaluation.standard(.binaryCall, correct: choiceId == payload.correctChoiceId, explanation: payload.explanation,
                                            notes: payload.ruleTag.map { ["Rule: \($0)"] } ?? [], conceptIds: conceptIds)
        evaluation = e
        return e
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        guard let id = try requireChoices(answer).first else { throw ExerciseError.invalidAnswer("empty selection") }
        return .finished(try submit(choiceId: id))
    }
}

// MARK: visual-id

public struct VisualIDEngine: ExerciseSession {
    public let payload: VisualIDPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .visualId }

    public init(payload: VisualIDPayload, conceptIds: [ConceptID] = []) throws {
        guard payload.options.count >= 2, payload.options.contains(where: { $0.id == payload.correctOptionId }) else { throw ExerciseError.invalidPayload("correctOptionId must reference an option") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    @discardableResult
    public mutating func submit(optionId: String) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        guard let chosen = payload.options.first(where: { $0.id == optionId }) else { throw ExerciseError.invalidAnswer("unknown option") }
        var notes = payload.cues ?? []
        if let x = chosen.explanation { notes.append(x) }
        let e = ExerciseEvaluation.standard(.visualId, correct: optionId == payload.correctOptionId, explanation: payload.explanation, notes: notes, conceptIds: conceptIds)
        evaluation = e
        return e
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        guard let id = try requireChoices(answer).first else { throw ExerciseError.invalidAnswer("empty selection") }
        return .finished(try submit(optionId: id))
    }
}

// MARK: listening-id

/// Right/wrong, plus a play counter (`maxPlays`, default 3) and a Skip that awards no XP and costs no heart.
public struct ListeningIDEngine: ExerciseSession {
    public let payload: ListeningIDPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public private(set) var playsUsed = 0
    public var activityType: ActivityType { .listeningId }

    public init(payload: ListeningIDPayload, conceptIds: [ConceptID] = []) throws {
        guard payload.options.count >= 2, payload.options.contains(where: { $0.id == payload.correctOptionId }) else { throw ExerciseError.invalidPayload("correctOptionId must reference an option") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    public var maxPlays: Int { payload.audio.maxPlays ?? 3 }
    public var playsRemaining: Int { max(0, maxPlays - playsUsed) }

    /// Returns false when no plays are left.
    @discardableResult
    public mutating func recordPlay() -> Bool {
        guard playsUsed < maxPlays else { return false }
        playsUsed += 1
        return true
    }

    @discardableResult
    public mutating func submit(optionId: String) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        guard let chosen = payload.options.first(where: { $0.id == optionId }) else { throw ExerciseError.invalidAnswer("unknown option") }
        var notes = (payload.listenFor ?? []).map { "Listen for: \($0)" }
        notes.append("Audio: \(payload.audio.description)")
        if let x = chosen.explanation { notes.append(x) }
        let e = ExerciseEvaluation.standard(.listeningId, correct: optionId == payload.correctOptionId, explanation: payload.explanation, notes: notes, conceptIds: conceptIds)
        evaluation = e
        return e
    }

    @discardableResult
    public mutating func skip() throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        let e = ExerciseEvaluation(activityType: .listeningId, isCorrect: false, score: 0, xp: 0, heartsLost: 0, title: "Skipped.",
                                   explanation: payload.audio.description, notes: (payload.listenFor ?? []).map { "Listen for: \($0)" },
                                   conceptIds: conceptIds, masteryFraction: .some(nil), skipped: true)
        evaluation = e
        return e
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        if case .skip = answer { return .finished(try skip()) }
        guard let id = try requireChoices(answer).first else { throw ExerciseError.invalidAnswer("empty selection") }
        return .finished(try submit(optionId: id))
    }
}

// MARK: say-this

/// F-measure of selected vs correct set; >= 0.75 counts as correct (+10); below 0.5 costs a heart.
public struct SayThisEngine: ExerciseSession {
    public static let correctThreshold = 0.75
    public static let heartThreshold = 0.5

    public let payload: SayThisPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .sayThis }

    public init(payload: SayThisPayload, conceptIds: [ConceptID] = []) throws {
        guard payload.options.count >= 2, payload.options.contains(where: \.isCorrect) else { throw ExerciseError.invalidPayload("needs at least one correct option") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    public static func fMeasure(selected: Set<String>, correct: Set<String>) -> Double {
        guard !selected.isEmpty, !correct.isEmpty else { return 0 }
        let tp = Double(selected.intersection(correct).count)
        if tp == 0 { return 0 }
        let precision = tp / Double(selected.count), recall = tp / Double(correct.count)
        return 2 * precision * recall / (precision + recall)
    }

    @discardableResult
    public mutating func submit(selected: [String]) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        let set = Set(selected)
        guard !set.isEmpty, set.isSubset(of: Set(payload.options.map(\.id))) else { throw ExerciseError.invalidAnswer("unknown or empty selection") }
        let correctSet = Set(payload.options.filter(\.isCorrect).map(\.id))
        let f = Self.fMeasure(selected: set, correct: correctSet)
        let correct = f >= Self.correctThreshold
        var notes = [payload.translation]
        notes += payload.followUps.map { "\($0.line) (\($0.why))" }
        notes += payload.options.filter { set.contains($0.id) }.compactMap(\.explanation)
        if let n = payload.noFakeExpertNote { notes.append(n) }
        let e = ExerciseEvaluation(
            activityType: .sayThis, isCorrect: correct, score: Int((f * 100).rounded()),
            xp: correct ? XPValues.correctAnswer : 0, heartsLost: f < Self.heartThreshold ? 1 : 0,
            explanation: payload.translation, sayThisLine: payload.followUps.first?.line, notes: notes, conceptIds: conceptIds,
            masteryFraction: correct ? 1 : f)
        evaluation = e
        return e
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult { .finished(try submit(selected: requireChoices(answer))) }
}

// MARK: decision-scenario

/// best = 100 (+10), acceptable = 50 (+5, no heart), poor = 0 (-1 heart).
public struct DecisionScenarioEngine: ExerciseSession {
    public let payload: DecisionScenarioPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .decisionScenario }

    public init(payload: DecisionScenarioPayload, conceptIds: [ConceptID] = []) throws {
        guard payload.options.count >= 2 else { throw ExerciseError.invalidPayload("needs at least 2 options") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    @discardableResult
    public mutating func submit(optionId: String) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        guard let o = payload.options.first(where: { $0.id == optionId }) else { throw ExerciseError.invalidAnswer("unknown option") }
        let score: Int, xp: Int, hearts: Int, fraction: Double
        switch o.verdict {
        case .best: (score, xp, hearts, fraction) = (100, XPValues.correctAnswer, 0, 1)
        case .acceptable: (score, xp, hearts, fraction) = (50, XPValues.halfCredit, 0, 0.5)
        case .poor: (score, xp, hearts, fraction) = (0, 0, 1, 0)
        }
        var notes = o.considerations
        notes.append(payload.expertNote)
        if let s = payload.safetyNote { notes.append(s) }
        let e = ExerciseEvaluation(activityType: .decisionScenario, isCorrect: o.verdict == .best, score: score, xp: xp, heartsLost: hearts,
                                   explanation: o.consequence, sayThisLine: payload.sayThisLine, notes: notes, conceptIds: conceptIds, masteryFraction: fraction)
        evaluation = e
        return e
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        guard let id = try requireChoices(answer).first else { throw ExerciseError.invalidAnswer("empty selection") }
        return .finished(try submit(optionId: id))
    }
}
