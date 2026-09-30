import Foundation

/// The single currency the progress engine understands. Native exercises and Unity results both map to it.
public struct ExerciseOutcome: Sendable, Equatable {
    public enum Source: String, Sendable, Codable { case native, simulation, dailyBite, session }
    public var activityId: ActivityID?
    public var source: Source
    public var correct: Bool
    /// 0...100.
    public var score: Int
    public var xp: Int
    public var heartsLost: Int
    public var conceptEvidence: [ConceptEvidence]

    public init(activityId: ActivityID? = nil, source: Source = .native, correct: Bool, score: Int, xp: Int, heartsLost: Int,
                conceptEvidence: [ConceptEvidence] = []) {
        self.activityId = activityId
        self.source = source
        self.correct = correct
        self.score = score
        self.xp = xp
        self.heartsLost = heartsLost
        self.conceptEvidence = conceptEvidence
    }
}

extension ExerciseEvaluation {
    /// Mastery delta per concept for a native exercise (ARCHITECTURE 6.1): correct +0.20, wrong -0.15;
    /// a fractional result blends the two; a hint halves any positive gain.
    public static func masteryDelta(fraction: Double, hintUsed: Bool, rules: ProgressRules = .default) -> Double {
        let f = min(1, max(0, fraction))
        var d = rules.correctMasteryGain * f - rules.wrongMasteryLoss * (1 - f)
        if hintUsed && d > 0 { d *= rules.hintGainMultiplier }
        return d
    }

    public func outcome(activityId: ActivityID?, hintUsed: Bool = false, rules: ProgressRules = .default) -> ExerciseOutcome {
        var evidence: [ConceptEvidence] = []
        if let f = masteryFraction {
            let d = Self.masteryDelta(fraction: f, hintUsed: hintUsed, rules: rules)
            evidence = conceptIds.map { ConceptEvidence(conceptId: $0, delta: d, correct: isCorrect) }
        }
        return ExerciseOutcome(activityId: activityId, source: .native, correct: isCorrect, score: score, xp: xp,
                               heartsLost: heartsLost, conceptEvidence: evidence)
    }
}
