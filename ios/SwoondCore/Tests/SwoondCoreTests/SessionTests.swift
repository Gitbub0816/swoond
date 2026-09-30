import Foundation
import Testing
@testable import SwoondCore

private struct Harness {
    let clock: ManualClock
    let engine: ProgressEngine
    let repo: InMemoryProgressRepository
    let session: LearningSession

    init(start: Date = Fixtures.date(2026, 9, 30, 9), editorial: (any EditorialProvider)? = MockEditorialProvider()) throws {
        clock = ManualClock(start)
        (engine, repo) = Fixtures.engine(clock: clock)
        session = LearningSession(person: Fixtures.sarah, interest: Fixtures.sarah.interests[0], content: try Fixtures.repo(), engine: engine, editorial: editorial)
    }

    /// Correct answers for the sample curriculum's activities, by activity id.
    static func correctAnswer(_ id: String) -> ExerciseAnswer {
        switch id {
        case "downs-01-mc": return .choices(["b"])
        case "downs-01-gap": return .gaps(["down": "fourth", "yards": "10"])
        case "clock-01-est": return .value(60)
        case "positions-01-match": return .choices([])   // handled separately
        case "coverage-04-hot": return .point(x: 0.62, y: 0.3)
        case "talk-secondary-say": return .choices(["a", "c"])
        default: return .choices([])
        }
    }

    func completeTermMatch() async throws {
        for (t, def) in [("qb", "Runs the offense and throws the ball"), ("cb", "Covers wide receivers"), ("k", "Kicks field goals and extra points")] {
            _ = try await session.submit(.pairing(termId: t, definition: def))
        }
    }

    /// Play a whole lesson perfectly and finish it.
    func playPerfectly(unit: String, lesson: String) async throws -> SessionSummary {
        var p: ActivityPresentation? = try await session.startLesson(unitId: unit, lessonId: lesson)
        while let cur = p {
            switch cur.kind {
            case .native:
                if cur.activity.id == "positions-01-match" { try await completeTermMatch() }
                else { _ = try await session.submit(Self.correctAnswer(cur.activity.id)) }
            case .simulation:
                let req = try await session.launchRequest()
                let result = try await MockSimulationHost(clock: clock).launch(req)
                _ = try await session.applySimulation(result: result, request: req)
            }
            p = try await session.advance()
        }
        return try await session.finish()
    }
}

@Suite("LessonPlanner")
struct LessonPlannerTests {
    @Test func firstLessonOfFirstUnit() throws {
        let c = try Fixtures.curriculum()
        let n = LessonPlanner.nextLesson(in: c, progress: CourseProgress(personId: "p", courseId: "american-football"), branchId: "nfl")
        #expect(n?.unitId == "the-basics" && n?.lesson.id == "downs-01" && n?.layer == .foundations)
    }

    @Test func prerequisiteGatesNextUnit() throws {
        let c = try Fixtures.curriculum()
        var p = CourseProgress(personId: "p", courseId: "american-football")
        let defense = c.unit("defense-basics")!
        #expect(!LessonPlanner.isUnlocked(defense, in: c, progress: p))
        for l in c.unit("the-basics")!.lessons { p.lessonResults[l.id] = .init(completedAt: Date(timeIntervalSince1970: 0), correctCount: 1, totalCount: 1, xpEarned: 0) }
        #expect(LessonPlanner.isUnlocked(defense, in: c, progress: p))
        #expect(LessonPlanner.nextLesson(in: c, progress: p, branchId: nil)?.lesson.id == "coverage-04")
    }

    @Test func courseCompleteYieldsNil() throws {
        let c = try Fixtures.curriculum()
        var p = CourseProgress(personId: "p", courseId: "x")
        for (_, l) in c.allLessons { p.lessonResults[l.id] = .init(completedAt: Date(timeIntervalSince1970: 0), correctCount: 0, totalCount: 0, xpEarned: 0) }
        #expect(LessonPlanner.nextLesson(in: c, progress: p, branchId: nil) == nil)
        #expect(p.fractionComplete(in: c, branchId: nil) == 1)
    }

    @Test func branchFilteringHidesOtherBranchUnits() throws {
        var c = try Fixtures.curriculum()
        c.units[0].branchId = "college-football"
        let p = CourseProgress(personId: "p", courseId: "x")
        #expect(LessonPlanner.orderedUnits(c, branchId: "nfl").map(\.id) == ["defense-basics"])
        #expect(LessonPlanner.orderedUnits(c, branchId: "college-football").map(\.id) == ["the-basics", "defense-basics"])
        #expect(p.fractionComplete(in: c, branchId: "nfl") == 0)
    }

    @Test func unitsOrderedByOrderField() throws {
        var c = try Fixtures.curriculum()
        c.units[0].order = 5
        c.units[1].order = 1
        #expect(LessonPlanner.orderedUnits(c, branchId: nil).map(\.id) == ["defense-basics", "the-basics"])
    }

    @Test func reviewsPickEligibleActivityAndPreferAnotherThanLast() throws {
        let c = try Fixtures.curriculum()
        var m = CourseMastery(courseId: "american-football")
        let t0 = Fixtures.date(2026, 9, 1)
        // "downs" has two eligible activities: downs-01-mc and downs-01-gap.
        m.apply([.init(conceptId: "downs", delta: 0.2, correct: true)], activityId: "downs-01-mc", now: t0, policy: c.reviewPolicy)
        let due = t0.addingTimeInterval(2 * 86_400)
        let r = LessonPlanner.dueReviews(in: c, mastery: m, now: due)
        #expect(r.count == 1 && r[0].conceptId == "downs" && r[0].activity.id == "downs-01-gap")
        #expect(LessonPlanner.dueReviews(in: c, mastery: m, now: t0).isEmpty)
    }

    @Test func reviewsSkipUnityActivitiesAndDisallowedTypes() throws {
        let c = try Fixtures.curriculum()
        var m = CourseMastery(courseId: "x")
        let t0 = Fixtures.date(2026, 9, 1)
        // cover-3 is only taught by the unity-sim -> nothing to review natively.
        // strong-safety is only taught by hotspot-tap, which is not in reviewActivityTypes.
        m.apply([.init(conceptId: "cover-3", delta: 0.2, correct: true), .init(conceptId: "strong-safety", delta: 0.2, correct: true)], activityId: nil, now: t0, policy: c.reviewPolicy)
        #expect(LessonPlanner.dueReviews(in: c, mastery: m, now: t0.addingTimeInterval(5 * 86_400)).isEmpty)
    }

    @Test func reviewsHonorMaxItems() throws {
        var c = try Fixtures.curriculum()
        c.reviewPolicy.maxItemsPerSession = 3
        c.reviewPolicy.reviewActivityTypes = nil
        var m = CourseMastery(courseId: "x")
        let t0 = Fixtures.date(2026, 9, 1)
        m.apply(["downs", "game-clock", "quarterback", "secondary", "strong-safety"].map { .init(conceptId: $0, delta: 0.2, correct: true) }, activityId: nil, now: t0, policy: c.reviewPolicy)
        #expect(LessonPlanner.dueReviews(in: c, mastery: m, now: t0.addingTimeInterval(5 * 86_400)).count == 3)
    }
}

@Suite("LearningSession")
struct LearningSessionTests {
    @Test func freshPlanStartsAtFirstLessonWithBite() async throws {
        let h = try Harness()
        let plan = try await h.session.plan()
        #expect(plan.nextLesson?.lesson.id == "downs-01")
        #expect(plan.reviews.isEmpty && plan.commonGround == 0 && plan.streak == 0)
        #expect(plan.hearts.current == 5 && plan.level == 1)
        #expect(plan.dailyBite != nil && !plan.dailyBiteCompleted)
        #expect(plan.day == DayKey(year: 2026, month: 9, day: 30))
    }

    @Test func planWithoutEditorialHasNoBite() async throws {
        let h = try Harness(editorial: nil)
        #expect(try await h.session.plan().dailyBite == nil)
    }

    @Test func editorialFailureDoesNotBreakThePlan() async throws {
        struct Boom: Error {}
        let h = try Harness(editorial: MockEditorialProvider(failure: Boom()))
        let plan = try await h.session.plan()
        #expect(plan.dailyBite == nil && plan.nextLesson != nil)
    }

    @Test func perfectLessonAwardsXPAndCompletes() async throws {
        let h = try Harness()
        let s = try await h.playPerfectly(unit: "the-basics", lesson: "downs-01")
        // 2 correct answers (+10 each) + 40 finished-game bonus.
        #expect(s.correctCount == 2 && s.answeredCount == 2 && s.completionBonus == 40 && s.xpEarned == 60)
        #expect(s.lessonCompleted && s.streak == 1)
        let state = try await h.repo.learnerState()
        #expect(state.totalXP == 60 && state.hearts == 5)
        let plan = try await h.session.plan()
        #expect(plan.nextLesson?.lesson.id == "clock-01" && plan.streak == 1)
    }

    @Test func mistakesCostHeartsAndMasteryButLessonStillCompletes() async throws {
        let h = try Harness()
        var p: ActivityPresentation? = try await h.session.startLesson(unitId: "the-basics", lessonId: "downs-01")
        var first = true
        while p != nil {
            let answer: ExerciseAnswer = first ? .choices(["a"]) : .gaps(["down": "first", "yards": "5"])
            first = false
            let r = try await h.session.submit(answer)
            #expect(r.update?.heartsLost == 1)
            p = try await h.session.advance()
        }
        let s = try await h.session.finish()
        #expect(s.correctCount == 0 && s.xpEarned == 40 && s.hearts.current == 3)
        let m = try await h.repo.mastery(courseId: "american-football")
        #expect(m.concepts["downs"]!.value == 0 && m.concepts["downs"]!.attempts == 2)
    }

    @Test func termMatchStepsThroughSession() async throws {
        let h = try Harness()
        _ = try await h.session.startLesson(unitId: "the-basics", lessonId: "positions-01")
        let wrong = try await h.session.submit(.pairing(termId: "qb", definition: "Covers wide receivers"))
        if case .inProgress = wrong.step {} else { Issue.record("expected in-progress") }
        #expect(wrong.update == nil)
        _ = try await h.session.submit(.pairing(termId: "qb", definition: "Runs the offense and throws the ball"))
        _ = try await h.session.submit(.pairing(termId: "cb", definition: "Covers wide receivers"))
        let fin = try await h.session.submit(.pairing(termId: "k", definition: "Kicks field goals and extra points"))
        #expect(fin.step.evaluation?.xp == 10 && fin.update?.xpGained == 10)
    }

    @Test func cannotAdvanceOrFinishEarly() async throws {
        let h = try Harness()
        _ = try await h.session.startLesson(unitId: "the-basics", lessonId: "downs-01")
        await #expect(throws: SessionError.notFinished) { try await h.session.advance() }
        await #expect(throws: SessionError.notFinished) { try await h.session.finish() }
        _ = try await h.session.submit(.choices(["b"]))
        _ = try await h.session.advance()
        await #expect(throws: SessionError.notFinished) { try await h.session.finish() }
    }

    @Test func doubleSubmitRejected() async throws {
        let h = try Harness()
        _ = try await h.session.startLesson(unitId: "the-basics", lessonId: "downs-01")
        _ = try await h.session.submit(.choices(["b"]))
        await #expect(throws: ExerciseError.alreadyFinished) { try await h.session.submit(.choices(["b"])) }
    }

    @Test func lockedAndMissingLessonsThrow() async throws {
        let h = try Harness()
        await #expect(throws: SessionError.lessonLocked) { try await h.session.startLesson(unitId: "defense-basics", lessonId: "coverage-04") }
        await #expect(throws: SessionError.lessonNotFound) { try await h.session.startLesson(unitId: "the-basics", lessonId: "nope") }
        await #expect(throws: SessionError.noActiveSession) { try await h.session.submit(.choices(["a"])) }
    }

    @Test func hintHalvesMasteryGain() async throws {
        let h = try Harness()
        _ = try await h.session.startLesson(unitId: "the-basics", lessonId: "downs-01")
        _ = try await h.session.submit(.choices(["b"]), hintUsed: true)
        let m = try await h.repo.mastery(courseId: "american-football")
        #expect(abs(m.concepts["downs"]!.value - 0.10) < 1e-9)
    }

    @Test func talkTrackBonusIsNotDoubleCounted() async throws {
        // A lesson whose only activity is a talk-track (completion bonus already inside its XP).
        var c = try Fixtures.curriculum()
        let talk = try #require(c.talkTracks?.first)
        c.units[0].lessons = [Lesson(id: "talk-lesson", title: "t", objective: "You can chat", conceptIds: ["downs"],
                                     activities: [Activity(id: "talk-act", type: .talkTrack, conceptIds: ["downs"], payload: talk.payload)])]
        let clock = ManualClock(Fixtures.date(2026, 9, 30))
        let (engine, _) = Fixtures.engine(clock: clock)
        let session = LearningSession(person: Fixtures.sarah, interest: Fixtures.sarah.interests[0],
                                      content: StaticContentRepository(curricula: [c]), engine: engine)
        _ = try await session.startLesson(unitId: "the-basics", lessonId: "talk-lesson")
        let r = try await session.submit(.reply("a"))
        #expect(r.step.evaluation?.xp == 50)
        let s = try await session.finish()
        #expect(s.completionBonus == 0 && s.xpEarned == 50)
    }

    @Test func dailyBiteAwardsOncePerDay() async throws {
        let h = try Harness()
        let first = try await h.session.completeDailyBite()
        #expect(first?.amount == 10)
        #expect(try await h.session.completeDailyBite() == nil)
        let plan = try await h.session.plan()
        #expect(plan.dailyBiteCompleted && plan.dailyBite == nil)
        h.clock.advance(days: 1)
        #expect(try await h.session.completeDailyBite()?.amount == 10)
        #expect(try await h.engine.currentStreak() == 2)
    }

    @Test func reviewSessionFlowSchedulesAndAwards() async throws {
        let h = try Harness()
        _ = try await h.playPerfectly(unit: "the-basics", lesson: "downs-01")
        // Nothing due yet.
        await #expect(throws: SessionError.nothingToReview) { try await h.session.startReview() }
        h.clock.advance(days: 2)
        let plan = try await h.session.plan()
        #expect(plan.reviews.map(\.conceptId) == ["downs"])
        var p: ActivityPresentation? = try await h.session.startReview()
        #expect(p?.isReview == true && p?.total == 1)
        let id = try #require(p?.activity.id)
        _ = try await h.session.submit(Harness.correctAnswer(id))
        p = try await h.session.advance()
        #expect(p == nil)
        let s = try await h.session.finish()
        #expect(s.xpEarned == 50 && !s.lessonCompleted)   // +10 correct, +40 finished review
        let m = try await h.repo.mastery(courseId: "american-football")
        #expect(m.concepts["downs"]!.box == 1)   // advanced because it was due
    }

    @Test func nativeSkipDoesNotPenalize() async throws {
        let h = try Harness()
        _ = try await h.session.startLesson(unitId: "the-basics", lessonId: "clock-01")
        try await h.session.skipCurrent()
        #expect(try await h.session.advance() == nil)
        let s = try await h.session.finish()
        #expect(s.xpEarned == 0 && s.answeredCount == 0 && s.hearts.current == 5 && s.lessonCompleted)
    }
}

@Suite("LearningSession with Unity sims")
struct SimulationSessionTests {
    private func unlockDefense(_ h: Harness) async throws {
        for l in ["downs-01", "clock-01", "positions-01"] { _ = try await h.playPerfectly(unit: "the-basics", lesson: l) }
    }

    @Test func launchRequestReflectsLearnerState() async throws {
        let h = try Harness()
        try await unlockDefense(h)
        _ = try await h.session.startLesson(unitId: "defense-basics", lessonId: "coverage-04")
        _ = try await h.session.submit(.point(x: 0.4, y: 0.2))     // wrong hotspot: -1 heart
        _ = try await h.session.advance()
        let req = try await h.session.launchRequest(environment: LaunchEnvironment(theme: .light, locale: "en-US"))
        #expect(req.simulationId == "football.coverage.read.v1" && req.simulationVersion == "1.0.0" && req.difficulty == 2)
        #expect(req.courseId == "american-football" && req.unitId == "defense-basics" && req.lessonId == "coverage-04")
        #expect(req.runtime.heartsRemaining == 4 && req.runtime.unlimitedHearts == nil)
        #expect(req.configuration["scenarioCount"]?.intValue == 3)
        #expect(req.learnerContext.personName == "Sarah" && req.learnerContext.relationship == .crush)
        #expect(req.learnerContext.personalization?["team"] == .string("Philadelphia Eagles"))
        #expect(req.learnerContext.masteredConcepts.isEmpty)
        #expect(req.learnerContext.weakConcepts.first == "strong-safety")   // lowest mastery first
        #expect(Set(req.learnerContext.weakConcepts) == ["strong-safety", "downs", "game-clock", "quarterback"])
        #expect(req.theme.colorScheme == .light)
        // Encodes to schema-shaped JSON and back.
        #expect(try JSONDecoder().decode(LaunchRequest.self, from: JSONEncoder().encode(req)) == req)
    }

    @Test func simulationResultIsClampedAndApplied() async throws {
        let h = try Harness()
        try await unlockDefense(h)
        _ = try await h.session.startLesson(unitId: "defense-basics", lessonId: "coverage-04")
        _ = try await h.session.submit(.point(x: 0.62, y: 0.3))
        _ = try await h.session.advance()
        let req = try await h.session.launchRequest()
        var result = try await MockSimulationHost(clock: h.clock).launch(req)
        result.xpEarned = 5000
        result.heartsLost = 50
        result.masterySignals = [.init(conceptId: "cover-3", delta: 0.9, evidence: "e"), .init(conceptId: "made-up", delta: 0.5, evidence: "e")]
        let xpBefore = try await h.repo.learnerState().totalXP
        let (mapped, update) = try await h.session.applySimulation(result: result, request: req)
        #expect(mapped.outcome.xp == 40 && update.xpGained == 40)                        // clamped to the lesson budget
        #expect(update.heartsLost == 5 && update.hearts.current == 0)                    // clamped to hearts at launch
        #expect(mapped.ignoredConceptIds == ["made-up"])
        #expect(try await h.repo.learnerState().totalXP == xpBefore + 40)
        let m = try await h.repo.mastery(courseId: "american-football")
        #expect(m.concepts["cover-3"]!.value == 0.4 && m.concepts["made-up"] == nil)     // per-session cap
    }

    @Test func activityXPOverrideWins() async throws {
        var c = try Fixtures.curriculum()
        c.units[0].lessons = [c.units[1].lessons[0]]   // lesson with hotspot + sim, no prerequisites in the way
        c.units[0].prerequisiteUnitIds = nil
        c.units[0].lessons[0].activities = [Activity(id: "sim-only", type: .unitySim, conceptIds: ["cover-3"],
                                                    payload: try JSONValue.from(UnitySimPayload(simulationId: "football.coverage.read.v1", simulationVersion: "1.0.0", difficulty: 1)), xp: 15)]
        let clock = ManualClock(Fixtures.date(2026, 9, 30))
        let (engine, _) = Fixtures.engine(clock: clock)
        let session = LearningSession(person: Fixtures.sarah, interest: Fixtures.sarah.interests[0], content: StaticContentRepository(curricula: [c]), engine: engine)
        _ = try await session.startLesson(unitId: "the-basics", lessonId: "coverage-04")
        let req = try await session.launchRequest()
        let result = try await MockSimulationHost().launch(req)
        let (mapped, _) = try await session.applySimulation(result: result, request: req)
        #expect(mapped.outcome.xp == 15)
    }

    @Test func abortedSimulationIsFreeAndLessonCanContinue() async throws {
        let h = try Harness()
        try await unlockDefense(h)
        _ = try await h.session.startLesson(unitId: "defense-basics", lessonId: "coverage-04")
        _ = try await h.session.submit(.point(x: 0.62, y: 0.3))
        _ = try await h.session.advance()
        let req = try await h.session.launchRequest()
        let aborted = SimulationResult.synthesizedAborted(for: req, reason: .timeout)
        let (mapped, update) = try await h.session.applySimulation(result: aborted, request: req)
        #expect(mapped.outcome.xp == 0 && update.heartsLost == 0 && update.hearts.current == 5)
        #expect(try await h.session.advance() == nil)
        #expect(try await h.session.finish().lessonCompleted)
    }

    @Test func mismatchedResultIsRejected() async throws {
        let h = try Harness()
        try await unlockDefense(h)
        _ = try await h.session.startLesson(unitId: "defense-basics", lessonId: "coverage-04")
        _ = try await h.session.submit(.point(x: 0.62, y: 0.3))
        _ = try await h.session.advance()
        let req = try await h.session.launchRequest()
        var result = try await MockSimulationHost().launch(req)
        result.sessionId = "some-other-session"
        await #expect(throws: BridgeError.self) { try await h.session.applySimulation(result: result, request: req) }
    }

    @Test func premiumLaunchesWithUnlimitedHearts() async throws {
        let h = try Harness()
        try await h.engine.setPremium(true)
        try await unlockDefense(h)
        _ = try await h.session.startLesson(unitId: "defense-basics", lessonId: "coverage-04")
        _ = try await h.session.submit(.point(x: 0.62, y: 0.3))
        _ = try await h.session.advance()
        let req = try await h.session.launchRequest()
        #expect(req.runtime.unlimitedHearts == true && req.runtime.heartsRemaining == 5)
    }

    @Test func launchRequestForNativeActivityThrows() async throws {
        let h = try Harness()
        _ = try await h.session.startLesson(unitId: "the-basics", lessonId: "downs-01")
        await #expect(throws: ContentError.self) { try await h.session.launchRequest() }
    }

    @Test func fullCurriculumPlaythroughReachesCourseEnd() async throws {
        let h = try Harness()
        try await unlockDefense(h)
        _ = try await h.playPerfectly(unit: "defense-basics", lesson: "coverage-04")
        _ = try await h.playPerfectly(unit: "defense-basics", lesson: "talk-secondary")
        let plan = try await h.session.plan()
        #expect(plan.nextLesson == nil)
        #expect(plan.commonGround > 0.3)
        #expect(try await h.session.commonGround() == plan.commonGround)
        #expect(plan.level >= 2)
    }
}
