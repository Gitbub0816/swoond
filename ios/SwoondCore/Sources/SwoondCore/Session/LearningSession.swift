import Foundation

public struct DailyPlan: Sendable, Equatable {
    public var personId: PersonID
    public var courseId: CourseID
    public var day: DayKey
    /// Next lesson to learn (nil when the course is finished).
    public var nextLesson: PlannedLesson?
    /// Concepts due for spaced review, each with a chosen activity.
    public var reviews: [PlannedReview]
    /// Today's bite (nil if none or already completed).
    public var dailyBite: DailyBite?
    public var dailyBiteCompleted: Bool
    /// Common ground with this person, 0...1.
    public var commonGround: Double
    public var streak: Int
    public var hearts: HeartsStatus
    public var level: Int
}

public enum SessionError: Error, Sendable, Equatable {
    case noActiveSession
    case lessonNotFound
    case lessonLocked
    case nothingToReview
    case wrongActivityKind
    case notFinished
    case simulationMismatch
}

/// What the UI renders for the current step.
public struct ActivityPresentation: Sendable {
    public enum Kind: Sendable {
        case native(any ExerciseSession)
        case simulation(UnitySimPayload)
    }
    public var activity: Activity
    /// 1-based.
    public var position: Int
    public var total: Int
    public var isReview: Bool
    public var kind: Kind
}

public struct SubmitResult: Sendable {
    public var step: ExerciseStepResult
    /// Present once the exercise finished and was applied.
    public var update: ProgressUpdate?
}

public struct SessionSummary: Sendable, Equatable {
    public var xpEarned: Int
    public var completionBonus: Int
    public var correctCount: Int
    public var answeredCount: Int
    public var lessonCompleted: Bool
    public var newlyMastered: [ConceptID]
    public var leveledUp: Bool
    public var streak: Int
    public var hearts: HeartsStatus
}

/// Environment the app supplies for sim launches.
public struct LaunchEnvironment: Sendable {
    public var theme: LaunchRequest.Theme
    public var accessibility: AccessibilityPreferences
    public var locale: String
    public var safeAreaInsets: LaunchRequest.Runtime.SafeAreaInsets?
    public var maxDurationMs: Int
    public init(theme: LaunchRequest.Theme = .dark, accessibility: AccessibilityPreferences = .init(), locale: String = "en-US",
                safeAreaInsets: LaunchRequest.Runtime.SafeAreaInsets? = nil, maxDurationMs: Int = 600_000) {
        self.theme = theme; self.accessibility = accessibility; self.locale = locale; self.safeAreaInsets = safeAreaInsets; self.maxDurationMs = maxDurationMs
    }
}

/// Orchestrates learning for one person + interest: builds today's plan, runs activities, applies results.
public actor LearningSession {
    private struct Item { var activity: Activity; var unitId: UnitID?; var lessonId: LessonID?; var isReview: Bool }

    private let person: Person
    private let interest: PersonInterest
    private let content: any ContentRepository
    private let engine: ProgressEngine
    private let editorial: (any EditorialProvider)?
    private let locale: String
    private let timingMode: TimingTapEngine.AccessibilityMode

    private var curriculumCache: Curriculum?
    private var queue: [Item] = []
    private var index = 0
    private var current: (any ExerciseSession)?
    private var currentDone = false
    private var isReviewSession = false
    private var lessonRef: (unitId: UnitID, lessonId: LessonID)?
    private var xpTotal = 0
    private var correct = 0
    private var answered = 0
    private var bonusIncluded = false
    private var mastered: [ConceptID] = []
    private var leveledUp = false
    private var finishedCalled = false

    public init(person: Person, interest: PersonInterest, content: any ContentRepository, engine: ProgressEngine,
                editorial: (any EditorialProvider)? = nil, locale: String = "en-US",
                timingMode: TimingTapEngine.AccessibilityMode = .standard) {
        self.person = person
        self.interest = interest
        self.content = content
        self.engine = engine
        self.editorial = editorial
        self.locale = locale
        self.timingMode = timingMode
    }

    public func curriculum() async throws -> Curriculum {
        if let c = curriculumCache { return c }
        let c = try await content.curriculum(courseId: interest.courseId, locale: locale)
        curriculumCache = c
        return c
    }

    // MARK: Plan

    public func plan() async throws -> DailyPlan {
        let c = try await curriculum()
        let now = await engine.now()
        let progress = try await engine.courseProgress(personId: person.id, courseId: interest.courseId)
        let mastery = try await engine.mastery(courseId: interest.courseId)
        let state = try await engine.learnerState()
        let today = await engine.today()
        var bite: DailyBite?
        let done = progress.lastDailyBiteDay == today
        if !done, let editorial {
            bite = try? await editorial.dailyBite(courseId: interest.courseId, personalization: interest.personalization, on: today)
        }
        let cov = CommonGround.coverage(curriculum: c, mastery: mastery, branchId: interest.branchId, now: now)
        return DailyPlan(
            personId: person.id, courseId: interest.courseId, day: today,
            nextLesson: LessonPlanner.nextLesson(in: c, progress: progress, branchId: interest.branchId),
            reviews: LessonPlanner.dueReviews(in: c, mastery: mastery, now: now),
            dailyBite: bite, dailyBiteCompleted: done,
            commonGround: cov, streak: state.currentStreak(now: now, timeZone: await engine.timeZoneValue),
            hearts: state.heartsStatus(now: now, rules: engine.rules), level: state.level)
    }

    /// Common ground with the person across all their interests.
    public func commonGround() async throws -> Double {
        try await CommonGround.score(for: person, content: content, engine: engine, locale: locale)
    }

    public func completeDailyBite() async throws -> XPAward? {
        let today = await engine.today()
        var progress = try await engine.courseProgress(personId: person.id, courseId: interest.courseId)
        guard progress.lastDailyBiteDay != today else { return nil }
        let award = try await engine.awardXP(XPValues.dailyBite)
        progress.lastDailyBiteDay = today
        progress.lastActivityAt = await engine.now()
        try await engine.save(progress)
        return award
    }

    // MARK: Run

    public func startLesson(unitId: UnitID, lessonId: LessonID) async throws -> ActivityPresentation {
        let c = try await curriculum()
        guard let unit = c.unit(unitId), let lesson = unit.lessons.first(where: { $0.id == lessonId }) else { throw SessionError.lessonNotFound }
        let progress = try await engine.courseProgress(personId: person.id, courseId: interest.courseId)
        guard LessonPlanner.isUnlocked(unit, in: c, progress: progress) else { throw SessionError.lessonLocked }
        reset()
        lessonRef = (unitId, lessonId)
        queue = lesson.activities.map { Item(activity: $0, unitId: unitId, lessonId: lessonId, isReview: false) }
        return try present()
    }

    /// Practice a Talk Track on its own (Talk tab). The track's payload becomes a single `talk-track` activity.
    public func startTalkTrack(trackId: String) async throws -> ActivityPresentation {
        let c = try await curriculum()
        guard let track = c.talkTracks?.first(where: { $0.id == trackId }) else { throw SessionError.lessonNotFound }
        let progress = try await engine.courseProgress(personId: person.id, courseId: interest.courseId)
        guard LessonPlanner.isTalkTrackUnlocked(track, in: c, progress: progress) else { throw SessionError.lessonLocked }
        reset()
        let activity = Activity(id: "talk-\(track.id)", type: .talkTrack, conceptIds: track.conceptIds, payload: track.payload, reviewEligible: false)
        queue = [Item(activity: activity, unitId: track.unlockedByUnitId, lessonId: nil, isReview: false)]
        return try present()
    }

    /// Start a review session from due concepts (default: today's plan).
    public func startReview(_ items: [PlannedReview]? = nil) async throws -> ActivityPresentation {
        let planned: [PlannedReview]
        if let items { planned = items } else { planned = try await plan().reviews }
        guard !planned.isEmpty else { throw SessionError.nothingToReview }
        reset()
        isReviewSession = true
        queue = planned.map { Item(activity: $0.activity, unitId: nil, lessonId: nil, isReview: true) }
        return try present()
    }

    public func currentPresentation() throws -> ActivityPresentation {
        guard !queue.isEmpty else { throw SessionError.noActiveSession }
        return try makePresentation()
    }

    /// Submit an answer to the current native exercise; applies XP/hearts/mastery when it finishes.
    public func submit(_ answer: ExerciseAnswer, hintUsed: Bool = false) async throws -> SubmitResult {
        guard !queue.isEmpty, index < queue.count else { throw SessionError.noActiveSession }
        guard var session = current else { throw SessionError.wrongActivityKind }
        guard !currentDone else { throw ExerciseError.alreadyFinished }
        let step = try session.submit(answer)
        current = session
        guard case .finished(let eval) = step else { return SubmitResult(step: step, update: nil) }
        currentDone = true
        let item = queue[index]
        let c = try await curriculum()
        let update = try await engine.apply(eval.outcome(activityId: item.activity.id, hintUsed: hintUsed, rules: engine.rules), courseId: interest.courseId, policy: c.reviewPolicy)
        record(update: update, correct: eval.isCorrect, bonus: eval.includesCompletionBonus)
        return SubmitResult(step: step, update: update)
    }

    /// Build the bridge `LaunchRequest` for the current `unity-sim` activity.
    public func launchRequest(environment: LaunchEnvironment = .init(), sessionId: String = UUID().uuidString.lowercased()) async throws -> LaunchRequest {
        guard !queue.isEmpty, index < queue.count else { throw SessionError.noActiveSession }
        let item = queue[index]
        let payload = try item.activity.simulationPayload()
        let c = try await curriculum()
        let now = await engine.now()
        let mastery = try await engine.mastery(courseId: interest.courseId)
        let state = try await engine.learnerState()
        let config = payload.configuration ?? [:]
        let personalization = interest.personalization.mapValues { JSONValue.string($0) }
        let ctx = LaunchRequest.LearnerContext(
            personName: person.displayName, relationship: person.relationship,
            personalization: personalization.isEmpty ? nil : personalization,
            masteredConcepts: mastery.masteredConceptIds(now: now, policy: c.reviewPolicy),
            weakConcepts: mastery.weakConceptIds(now: now, policy: c.reviewPolicy),
            accessibility: environment.accessibility)
        return LaunchRequest(
            sessionId: sessionId, simulationId: payload.simulationId, simulationVersion: payload.simulationVersion,
            courseId: interest.courseId, unitId: item.unitId ?? "review", lessonId: item.lessonId ?? "review",
            difficulty: payload.difficulty, locale: environment.locale, configuration: config, learnerContext: ctx, theme: environment.theme,
            runtime: .init(maxDurationMs: environment.maxDurationMs, heartsRemaining: state.heartsStatus(now: now, rules: engine.rules).current,
                           unlimitedHearts: state.isPremium ? true : nil, safeAreaInsets: environment.safeAreaInsets))
    }

    /// Validate, clamp and apply a Unity result for the current `unity-sim` activity.
    public func applySimulation(result: SimulationResult, request: LaunchRequest) async throws -> (mapped: MappedSimulation, update: ProgressUpdate) {
        guard !queue.isEmpty, index < queue.count else { throw SessionError.noActiveSession }
        let item = queue[index]
        guard item.activity.type == .unitySim else { throw SessionError.wrongActivityKind }
        guard !currentDone else { throw ExerciseError.alreadyFinished }
        let c = try await curriculum()
        let ctx = SimulationApplicationContext(request: request, activity: item.activity, curriculum: c, lessonXPBudget: engine.rules.defaultLessonXPBudget)
        let mapped = try SimulationResultMapper.map(result, context: ctx, rules: engine.rules)
        let update = try await engine.apply(mapped.outcome, courseId: interest.courseId, policy: c.reviewPolicy)
        currentDone = true
        record(update: update, correct: mapped.outcome.correct, bonus: false)
        return (mapped, update)
    }

    /// Give up on the current activity without penalty (e.g. Unity failed to load, audio not audible).
    public func skipCurrent() throws {
        guard !queue.isEmpty, index < queue.count else { throw SessionError.noActiveSession }
        currentDone = true
    }

    /// Move to the next activity; nil when the queue is exhausted (call `finish()`).
    public func advance() throws -> ActivityPresentation? {
        guard !queue.isEmpty else { throw SessionError.noActiveSession }
        guard currentDone else { throw SessionError.notFinished }
        index += 1
        guard index < queue.count else { return nil }
        return try present()
    }

    /// Close the session: +40 finished-game XP (unless an activity already granted it), mark the lesson complete.
    public func finish() async throws -> SessionSummary {
        guard !queue.isEmpty, !finishedCalled else { throw SessionError.noActiveSession }
        guard index >= queue.count - 1, currentDone else { throw SessionError.notFinished }
        finishedCalled = true
        var bonus = 0
        var streak = try await engine.currentStreak()
        if answered > 0 && !bonusIncluded {
            let award = try await engine.awardXP(XPValues.finishedGame)
            bonus = XPValues.finishedGame
            xpTotal += bonus
            leveledUp = leveledUp || award.leveledUp
            streak = award.streak
        }
        var lessonDone = false
        if let ref = lessonRef {
            var progress = try await engine.courseProgress(personId: person.id, courseId: interest.courseId)
            let now = await engine.now()
            progress.lessonResults[ref.lessonId] = CourseProgress.LessonResult(completedAt: now, correctCount: correct, totalCount: queue.count, xpEarned: xpTotal)
            progress.lastActivityAt = now
            try await engine.save(progress)
            lessonDone = true
        }
        let hearts = try await engine.hearts()
        return SessionSummary(xpEarned: xpTotal, completionBonus: bonus, correctCount: correct, answeredCount: answered,
                              lessonCompleted: lessonDone, newlyMastered: mastered, leveledUp: leveledUp, streak: streak, hearts: hearts)
    }

    // MARK: Internals

    private func reset() {
        queue = []; index = 0; current = nil; currentDone = false; isReviewSession = false; lessonRef = nil
        xpTotal = 0; correct = 0; answered = 0; bonusIncluded = false; mastered = []; leveledUp = false; finishedCalled = false
    }

    private func present() throws -> ActivityPresentation {
        currentDone = false
        current = nil
        return try makePresentation()
    }

    private func makePresentation() throws -> ActivityPresentation {
        let item = queue[index]
        let kind: ActivityPresentation.Kind
        if item.activity.type == .unitySim {
            kind = .simulation(try item.activity.simulationPayload())
        } else {
            if current == nil { current = try ExerciseSessionFactory.make(for: item.activity, timingMode: timingMode) }
            kind = .native(current!)
        }
        return ActivityPresentation(activity: item.activity, position: index + 1, total: queue.count, isReview: item.isReview, kind: kind)
    }

    private func record(update: ProgressUpdate, correct ok: Bool, bonus: Bool) {
        answered += 1
        if ok { correct += 1 }
        xpTotal += update.xpGained
        if bonus { bonusIncluded = true }
        mastered += update.newlyMastered
        if update.xpAward?.leveledUp == true { leveledUp = true }
    }
}
