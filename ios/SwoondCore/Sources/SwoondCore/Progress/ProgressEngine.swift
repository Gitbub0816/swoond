import Foundation

public struct ProgressUpdate: Sendable, Equatable {
    public var xpAward: XPAward?
    public var heartsLost: Int
    public var hearts: HeartsStatus
    public var masteryChanges: [MasteryChange]
    public var newlyMastered: [ConceptID] { masteryChanges.filter(\.newlyMastered).map(\.conceptId) }
    public var xpGained: Int { xpAward?.amount ?? 0 }
}

/// Applies outcomes to persisted learner state. All time comes from the injected `SwoondClock`/`TimeZone`.
public actor ProgressEngine {
    private let repository: any ProgressRepository
    private let clock: any SwoondClock
    private let timeZone: TimeZone
    public nonisolated let rules: ProgressRules

    public init(repository: any ProgressRepository, clock: any SwoondClock = SystemClock(), timeZone: TimeZone = .current,
                rules: ProgressRules = .default) {
        self.repository = repository
        self.clock = clock
        self.timeZone = timeZone
        self.rules = rules
    }

    // MARK: Reads

    /// Learner state with regenerated hearts credited (persisted if it changed).
    public func learnerState() async throws -> LearnerState {
        var s = try await repository.learnerState()
        let before = s
        s.syncHearts(now: clock.now(), rules: rules)
        if s != before { try await repository.save(s) }
        return s
    }

    public func hearts() async throws -> HeartsStatus {
        try await repository.learnerState().heartsStatus(now: clock.now(), rules: rules)
    }

    public func currentStreak() async throws -> Int {
        try await repository.learnerState().currentStreak(now: clock.now(), timeZone: timeZone)
    }

    public func weeklyXP() async throws -> Int {
        try await repository.learnerState().weeklyXP(now: clock.now(), timeZone: timeZone)
    }

    public func mastery(courseId: CourseID) async throws -> CourseMastery { try await repository.mastery(courseId: courseId) }

    public func courseProgress(personId: PersonID, courseId: CourseID) async throws -> CourseProgress {
        try await repository.progress(personId: personId, courseId: courseId)
    }

    public var timeZoneValue: TimeZone { timeZone }

    public func today() -> DayKey { DayKey(date: clock.now(), timeZone: timeZone) }
    public func now() -> Date { clock.now() }

    // MARK: Writes

    /// Apply one outcome: XP (+ streak), hearts, mastery and Leitner scheduling.
    @discardableResult
    public func apply(_ outcome: ExerciseOutcome, courseId: CourseID, policy: ReviewPolicy) async throws -> ProgressUpdate {
        let now = clock.now()
        var state = try await repository.learnerState()
        state.syncHearts(now: now, rules: rules)
        let award = outcome.xp > 0 ? state.addXP(outcome.xp, now: now, timeZone: timeZone) : nil
        state.loseHearts(outcome.heartsLost, now: now, rules: rules)
        try await repository.save(state)

        var changes: [MasteryChange] = []
        if !outcome.conceptEvidence.isEmpty {
            var m = try await repository.mastery(courseId: courseId)
            changes = m.apply(outcome.conceptEvidence, activityId: outcome.activityId, now: now, policy: policy, rules: rules)
            try await repository.save(m)
        }
        return ProgressUpdate(xpAward: award, heartsLost: state.isPremium ? 0 : outcome.heartsLost,
                              hearts: state.heartsStatus(now: now, rules: rules), masteryChanges: changes)
    }

    @discardableResult
    public func awardXP(_ amount: Int) async throws -> XPAward {
        var state = try await repository.learnerState()
        let award = state.addXP(amount, now: clock.now(), timeZone: timeZone)
        try await repository.save(state)
        return award
    }

    public func earnHeart() async throws {
        var s = try await repository.learnerState()
        s.earnHeart(now: clock.now(), rules: rules)
        try await repository.save(s)
    }

    public func setPremium(_ premium: Bool) async throws {
        var s = try await repository.learnerState()
        s.isPremium = premium
        try await repository.save(s)
    }

    public func save(_ progress: CourseProgress) async throws { try await repository.save(progress) }
}
