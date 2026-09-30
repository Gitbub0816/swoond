import Foundation

public enum ExerciseError: Error, Sendable, Equatable {
    case alreadyFinished
    case invalidPayload(String)
    case invalidAnswer(String)
    case unsupportedAnswer(expected: String)
}

/// What a learner submits. Each engine accepts the cases that make sense for its type.
public enum ExerciseAnswer: Sendable, Equatable {
    /// multiple-choice, binary-call, visual-id, listening-id, say-this, decision-scenario, hotspot (by id): option ids.
    case choices([String])
    /// hotspot-tap: normalized (0...1) tap point.
    case point(x: Double, y: Double)
    /// term-match: one pairing attempt (term id, definition text).
    case pairing(termId: String, definition: String)
    /// sequence-order: item ids in the learner's order.
    case order([String])
    /// fill-the-gap: gap id -> chosen option.
    case gaps([String: String])
    /// estimate-slider.
    case value(Double)
    /// talk-track: chosen reply id.
    case reply(String)
    /// timing-tap: marker position (0...100) at tap.
    case markerPosition(Double)
    /// timing-tap: seconds since the round's sweep began (injected time).
    case elapsed(seconds: Double)
    /// listening-id: learner cannot hear audio; no XP, no heart loss.
    case skip
}

/// Result of grading, in the shape the feedback panel and the progress engine need.
public struct ExerciseEvaluation: Sendable, Equatable, Codable {
    public var activityType: ActivityType
    public var isCorrect: Bool
    /// 0...100.
    public var score: Int
    public var xp: Int
    public var heartsLost: Int
    /// "Nice read." / "Not quite."
    public var title: String
    public var explanation: String
    public var sayThisLine: String?
    /// Extra teaching lines (per-option explanations, cues, per-step "why").
    public var notes: [String]
    public var conceptIds: [ConceptID]
    /// 0...1 blend for the mastery delta; nil = no mastery effect (skips).
    public var masteryFraction: Double?
    /// True when the +40 finished-game XP is already inside `xp` (talk-track, timing-tap).
    public var includesCompletionBonus: Bool
    public var skipped: Bool

    public init(activityType: ActivityType, isCorrect: Bool, score: Int, xp: Int, heartsLost: Int, title: String? = nil,
                explanation: String, sayThisLine: String? = nil, notes: [String] = [], conceptIds: [ConceptID] = [],
                masteryFraction: Double?? = nil, includesCompletionBonus: Bool = false, skipped: Bool = false) {
        self.activityType = activityType
        self.isCorrect = isCorrect
        self.score = score
        self.xp = xp
        self.heartsLost = heartsLost
        self.title = title ?? (isCorrect ? "Nice read." : "Not quite.")
        self.explanation = explanation
        self.sayThisLine = sayThisLine
        self.notes = notes
        self.conceptIds = conceptIds
        switch masteryFraction {
        case .none: self.masteryFraction = isCorrect ? 1 : 0
        case .some(let f): self.masteryFraction = f
        }
        self.includesCompletionBonus = includesCompletionBonus
        self.skipped = skipped
    }

    /// The standard right/wrong grading: +10 or -1 heart.
    static func standard(_ type: ActivityType, correct: Bool, explanation e: ExerciseExplanation, notes: [String] = [], conceptIds: [ConceptID]) -> ExerciseEvaluation {
        ExerciseEvaluation(activityType: type, isCorrect: correct, score: correct ? 100 : 0, xp: correct ? XPValues.correctAnswer : 0,
                           heartsLost: correct ? 0 : 1, explanation: correct ? e.correct : e.incorrect, sayThisLine: e.sayThisLine,
                           notes: notes, conceptIds: conceptIds)
    }
}

/// In-progress feedback for multi-step exercises (term-match attempt, talk-track reply, timing round).
public struct StepFeedback: Sendable, Equatable {
    public var isCorrect: Bool?
    public var message: String?
    public var coachNote: String?
    /// Talk-track "Smooth" meter (0...100) or the round score.
    public var meter: Double?
    public init(isCorrect: Bool? = nil, message: String? = nil, coachNote: String? = nil, meter: Double? = nil) {
        self.isCorrect = isCorrect; self.message = message; self.coachNote = coachNote; self.meter = meter
    }
}

public enum ExerciseStepResult: Sendable, Equatable {
    case inProgress(StepFeedback)
    case finished(ExerciseEvaluation)

    public var evaluation: ExerciseEvaluation? { if case .finished(let e) = self { return e }; return nil }
}

/// State machine for one native exercise. Value type: the UI holds it in state and calls `submit`.
public protocol ExerciseSession: Sendable {
    var activityType: ActivityType { get }
    var conceptIds: [ConceptID] { get }
    /// Set once finished.
    var evaluation: ExerciseEvaluation? { get }
    mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult
}

extension ExerciseSession {
    public var isFinished: Bool { evaluation != nil }
}

/// Deterministic shuffling for display order (option order is shuffled unless `shuffle:false`).
public struct SeededGenerator: RandomNumberGenerator, Sendable {
    private var state: UInt64
    public init(seed: UInt64) { state = seed }
    public mutating func next() -> UInt64 {
        state &+= 0x9E37_79B9_7F4A_7C15
        var z = state
        z = (z ^ (z >> 30)) &* 0xBF58_476D_1CE4_E5B9
        z = (z ^ (z >> 27)) &* 0x94D0_49BB_1331_11EB
        return z ^ (z >> 31)
    }
}

/// Builds the right engine for a curriculum activity.
public enum ExerciseSessionFactory {
    public static func make(for activity: Activity) throws -> any ExerciseSession {
        do { return try make(type: activity.type, payload: activity.payload, conceptIds: activity.conceptIds) }
        catch let e as ContentError { throw e }
        catch let e as ExerciseError { throw e }
        catch { throw ContentError.invalidPayload(activityId: activity.id, reason: "\(error)") }
    }

    public static func make(type: ActivityType, payload: JSONValue, conceptIds: [ConceptID]) throws -> any ExerciseSession {
        switch type {
        case .multipleChoice: return try MultipleChoiceEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .binaryCall: return try BinaryCallEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .termMatch: return try TermMatchEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .sequenceOrder: return try SequenceOrderEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .visualId: return try VisualIDEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .decisionScenario: return try DecisionScenarioEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .talkTrack: return try TalkTrackEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .timingTap: return try TimingTapEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .sayThis: return try SayThisEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .fillTheGap: return try FillTheGapEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .listeningId: return try ListeningIDEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .estimateSlider: return try EstimateSliderEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .hotspotTap: return try HotspotTapEngine(payload: payload.decode(), conceptIds: conceptIds)
        case .unitySim: throw ContentError.wrongActivityType(expected: .multipleChoice, actual: .unitySim)
        }
    }
}
