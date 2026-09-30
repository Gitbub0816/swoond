import Foundation

/// Everything the mapper needs to know about the launch to clamp a result (D-009).
public struct SimulationApplicationContext: Sendable, Equatable {
    public var sessionId: String
    public var simulationId: String
    public var activityId: ActivityID?
    /// `activity.xp` override.
    public var activityXP: Int?
    /// Fallback budget when the activity has no `xp`.
    public var lessonXPBudget: Int
    public var heartsRemainingAtLaunch: Int
    public var unlimitedHearts: Bool
    /// If non-nil, mastery signals for other ids are ignored.
    public var knownConceptIds: Set<ConceptID>?

    public init(sessionId: String, simulationId: String, activityId: ActivityID? = nil, activityXP: Int? = nil,
                lessonXPBudget: Int = ProgressRules.default.defaultLessonXPBudget, heartsRemainingAtLaunch: Int,
                unlimitedHearts: Bool = false, knownConceptIds: Set<ConceptID>? = nil) {
        self.sessionId = sessionId
        self.simulationId = simulationId
        self.activityId = activityId
        self.activityXP = activityXP
        self.lessonXPBudget = lessonXPBudget
        self.heartsRemainingAtLaunch = heartsRemainingAtLaunch
        self.unlimitedHearts = unlimitedHearts
        self.knownConceptIds = knownConceptIds
    }

    public init(request: LaunchRequest, activity: Activity? = nil, curriculum: Curriculum? = nil,
                lessonXPBudget: Int = ProgressRules.default.defaultLessonXPBudget) {
        self.init(sessionId: request.sessionId, simulationId: request.simulationId, activityId: activity?.id, activityXP: activity?.xp,
                  lessonXPBudget: lessonXPBudget, heartsRemainingAtLaunch: request.runtime.heartsRemaining,
                  unlimitedHearts: request.runtime.unlimitedHearts ?? false,
                  knownConceptIds: curriculum.map { Set($0.concepts.map(\.id)) })
    }
}

public struct MappedSimulation: Sendable, Equatable {
    public var outcome: ExerciseOutcome
    /// Human-readable notes on what was clamped/ignored (for telemetry).
    public var adjustments: [String]
    public var ignoredConceptIds: [ConceptID]
}

/// Validates a Unity-proposed `SimulationResult` and turns it into the single currency
/// the progress engine understands (`ExerciseOutcome`). Unity proposes; native is authoritative.
public enum SimulationResultMapper {
    public static func map(_ result: SimulationResult, context: SimulationApplicationContext, rules: ProgressRules = .default) throws -> MappedSimulation {
        guard BridgeContract.isSupported(result.contractVersion) else { throw BridgeError.contractUnsupported(result.contractVersion) }
        guard result.sessionId == context.sessionId else { throw BridgeError.sessionMismatch(expected: context.sessionId, actual: result.sessionId) }
        guard result.simulationId == context.simulationId else { throw BridgeError.simulationMismatch(expected: context.simulationId, actual: result.simulationId) }
        if result.completed && result.aborted { throw BridgeError.inconsistentResult("completed and aborted are mutually exclusive") }
        if result.aborted && result.abortReason == nil { throw BridgeError.inconsistentResult("aborted result requires abortReason") }

        var notes: [String] = []
        let score = clamp(result.score, 0, 100, "score", &notes)

        // Aborted sessions: no XP, no hearts, no mastery (never punish crashes/quits; 0 XP per the lifecycle).
        if result.aborted {
            if result.xpEarned != 0 || result.heartsLost != 0 || !result.masterySignals.isEmpty { notes.append("aborted result: XP, hearts and mastery signals discarded") }
            let outcome = ExerciseOutcome(activityId: context.activityId, source: .simulation, correct: false, score: score, xp: 0, heartsLost: 0, conceptEvidence: [])
            return MappedSimulation(outcome: outcome, adjustments: notes, ignoredConceptIds: [])
        }

        let budget = max(0, context.activityXP ?? context.lessonXPBudget)
        let xp = clamp(result.xpEarned, 0, budget, "xpEarned", &notes)
        var hearts = max(0, result.heartsLost)
        if !context.unlimitedHearts {
            let capped = min(hearts, max(0, context.heartsRemainingAtLaunch))
            if capped != hearts { notes.append("heartsLost \(hearts) clamped to \(capped)") }
            hearts = capped
        }

        // Mastery: sum deltas per concept (each clamped to -1...1), cap positive gain per session.
        var order: [ConceptID] = []
        var sums: [ConceptID: Double] = [:]
        var ignored: [ConceptID] = []
        for s in result.masterySignals {
            if let known = context.knownConceptIds, !known.contains(s.conceptId) {
                if !ignored.contains(s.conceptId) { ignored.append(s.conceptId) }
                continue
            }
            if sums[s.conceptId] == nil { order.append(s.conceptId) }
            sums[s.conceptId, default: 0] += min(1, max(-1, s.delta))
        }
        var evidence: [ConceptEvidence] = []
        for id in order {
            var d = min(1, max(-1, sums[id] ?? 0))
            if d > rules.simulationSessionConceptGainCap {
                notes.append("mastery gain for \(id) capped at \(rules.simulationSessionConceptGainCap)")
                d = rules.simulationSessionConceptGainCap
            }
            evidence.append(ConceptEvidence(conceptId: id, delta: d, correct: d > 0 ? true : (d < 0 ? false : nil)))
        }
        let correct = result.completed && score >= 60
        let outcome = ExerciseOutcome(activityId: context.activityId, source: .simulation, correct: correct, score: score, xp: xp, heartsLost: hearts, conceptEvidence: evidence)
        return MappedSimulation(outcome: outcome, adjustments: notes, ignoredConceptIds: ignored)
    }

    private static func clamp(_ v: Int, _ lo: Int, _ hi: Int, _ name: String, _ notes: inout [String]) -> Int {
        let c = min(hi, max(lo, v))
        if c != v { notes.append("\(name) \(v) clamped to \(c)") }
        return c
    }
}
