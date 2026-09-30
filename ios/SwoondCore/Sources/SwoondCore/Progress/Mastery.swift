import Foundation

public enum MasteryStatus: String, Codable, Sendable { case new = "New", learning = "Learning", mastered = "Mastered" }

/// One piece of evidence about one concept, already expressed as a mastery delta.
public struct ConceptEvidence: Sendable, Equatable, Codable {
    public var conceptId: ConceptID
    public var delta: Double
    /// Drives the Leitner box: true = correct, false = wrong, nil = no scheduling effect.
    public var correct: Bool?
    public init(conceptId: ConceptID, delta: Double, correct: Bool?) { self.conceptId = conceptId; self.delta = delta; self.correct = correct }
}

public struct MasteryChange: Sendable, Equatable {
    public var conceptId: ConceptID
    public var oldValue: Double
    public var newValue: Double
    public var newlyMastered: Bool
    public var box: Int?
    public var dueAt: Date?
}

public struct ConceptMastery: Codable, Sendable, Equatable {
    public var value: Double = 0
    public var peak: Double = 0
    public var attempts: Int = 0
    public var correctCount: Int = 0
    /// Leitner box; nil until scheduled.
    public var box: Int?
    public var dueAt: Date?
    public var lastSeenAt: Date?
    public var lastActivityId: ActivityID?
    public init() {}

    /// Mastery after decay: if not seen for more than `decayAfterDays`, loses `decayPerDay` per day since,
    /// floored at `decayFloorFactor` x peak.
    public func effectiveValue(now: Date, decayAfterDays: Int?, rules: ProgressRules = .default) -> Double {
        guard let decayAfterDays, let seen = lastSeenAt else { return value }
        let days = now.timeIntervalSince(seen) / 86_400
        guard days > Double(decayAfterDays) else { return value }
        let decayed = value - rules.decayPerDay * days
        return min(value, max(decayed, rules.decayFloorFactor * peak))
    }
}

/// Mastery for one course, per learner (not per person; ARCHITECTURE section 5).
public struct CourseMastery: Codable, Sendable, Equatable {
    public var schemaVersion = 1
    public var courseId: CourseID
    public var concepts: [ConceptID: ConceptMastery] = [:]

    public init(courseId: CourseID) { self.courseId = courseId }

    public func status(_ id: ConceptID, now: Date, policy: ReviewPolicy, rules: ProgressRules = .default) -> MasteryStatus {
        guard let m = concepts[id], m.attempts > 0 else { return .new }
        return m.effectiveValue(now: now, decayAfterDays: policy.decayAfterDays, rules: rules) >= policy.masteryThreshold ? .mastered : .learning
    }

    public func value(_ id: ConceptID, now: Date, policy: ReviewPolicy, rules: ProgressRules = .default) -> Double {
        concepts[id]?.effectiveValue(now: now, decayAfterDays: policy.decayAfterDays, rules: rules) ?? 0
    }

    public func masteredConceptIds(now: Date, policy: ReviewPolicy) -> [ConceptID] {
        concepts.keys.sorted().filter { status($0, now: now, policy: policy) == .mastered }
    }

    /// Concepts that were attempted and are still below threshold, weakest first.
    public func weakConceptIds(now: Date, policy: ReviewPolicy) -> [ConceptID] {
        var rows: [(id: ConceptID, value: Double)] = []
        for (id, m) in concepts where m.attempts > 0 {
            let v = m.effectiveValue(now: now, decayAfterDays: policy.decayAfterDays)
            if v < policy.masteryThreshold { rows.append((id, v)) }
        }
        rows.sort { $0.value == $1.value ? $0.id < $1.id : $0.value < $1.value }
        return rows.map { $0.id }
    }

    /// Concepts whose Leitner `dueAt` has passed, most overdue first.
    public func dueConceptIds(now: Date) -> [ConceptID] {
        var rows: [(id: ConceptID, due: Date)] = []
        for (id, m) in concepts {
            if let due = m.dueAt, due <= now { rows.append((id, due)) }
        }
        rows.sort { $0.due == $1.due ? $0.id < $1.id : $0.due < $1.due }
        return rows.map { $0.id }
    }

    /// Apply evidence: decay is materialized, the delta added and clamped to 0...1, and the Leitner box updated.
    ///
    /// Leitner (`leitner-boxes-v1`): first correct -> box 0; a correct answer on a *due* concept -> box + 1;
    /// a correct answer before it is due leaves the box alone (learning it twice in one day is not a review);
    /// wrong -> box = max(0, box - 2). A wrong answer on an unscheduled concept schedules it in box 0
    /// (small deviation so weak concepts come back).
    @discardableResult
    public mutating func apply(_ evidence: [ConceptEvidence], activityId: ActivityID?, now: Date, policy: ReviewPolicy,
                               rules: ProgressRules = .default) -> [MasteryChange] {
        var changes: [MasteryChange] = []
        let intervals = policy.intervalsDays.isEmpty ? [1] : policy.intervalsDays
        for e in evidence {
            var m = concepts[e.conceptId] ?? ConceptMastery()
            let effective = m.effectiveValue(now: now, decayAfterDays: policy.decayAfterDays, rules: rules)
            let wasMastered = m.attempts > 0 && effective >= policy.masteryThreshold
            let old = effective
            let new = min(1, max(0, effective + e.delta))
            m.value = new
            m.peak = max(m.peak, new)
            m.attempts += 1
            m.lastSeenAt = now
            if let a = activityId { m.lastActivityId = a }
            if let correct = e.correct {
                if correct {
                    m.correctCount += 1
                    if let box = m.box {
                        if let due = m.dueAt, due <= now {
                            let nb = min(box + 1, intervals.count - 1)
                            m.box = nb
                            m.dueAt = now.addingTimeInterval(Double(intervals[nb]) * 86_400)
                        }
                    } else {
                        m.box = 0
                        m.dueAt = now.addingTimeInterval(Double(intervals[0]) * 86_400)
                    }
                } else {
                    let nb = max(0, (m.box ?? 2) - 2)
                    m.box = nb
                    m.dueAt = now.addingTimeInterval(Double(intervals[min(nb, intervals.count - 1)]) * 86_400)
                }
            }
            concepts[e.conceptId] = m
            changes.append(MasteryChange(conceptId: e.conceptId, oldValue: old, newValue: new,
                                         newlyMastered: !wasMastered && new >= policy.masteryThreshold, box: m.box, dueAt: m.dueAt))
        }
        return changes
    }
}
