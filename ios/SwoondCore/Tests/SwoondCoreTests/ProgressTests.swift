import Foundation
import Testing
@testable import SwoondCore

private let utc = Fixtures.utc
private func d(_ y: Int, _ m: Int, _ day: Int, _ h: Int = 12, _ min: Int = 0, tz: TimeZone = Fixtures.utc) -> Date { Fixtures.date(y, m, day, h, min, tz: tz) }

@Suite("DayKey")
struct DayKeyTests {
    @Test func epochDayRoundTrip() {
        for e in [-800, -1, 0, 1, 59, 60, 365, 11_016, 20_000, 29_000] {
            #expect(DayKey(epochDay: e).epochDay == e)
        }
        #expect(DayKey(year: 1970, month: 1, day: 1).epochDay == 0)
        #expect(DayKey(year: 2000, month: 3, day: 1).epochDay == 11_017)
    }
    @Test func arithmeticAcrossMonthsAndLeapYears() {
        #expect(DayKey(year: 2028, month: 2, day: 28).adding(days: 1) == DayKey(year: 2028, month: 2, day: 29))
        #expect(DayKey(year: 2027, month: 2, day: 28).adding(days: 1) == DayKey(year: 2027, month: 3, day: 1))
        #expect(DayKey(year: 2026, month: 12, day: 31).adding(days: 1) == DayKey(year: 2027, month: 1, day: 1))
        #expect(DayKey(year: 2026, month: 10, day: 1).days(since: DayKey(year: 2026, month: 9, day: 30)) == 1)
    }
    @Test func weekStartIsMonday() {
        // 2026-09-30 is a Wednesday; its Monday is 2026-09-28.
        #expect(DayKey(year: 2026, month: 9, day: 30).weekStart == DayKey(year: 2026, month: 9, day: 28))
        #expect(DayKey(year: 2026, month: 9, day: 28).weekStart == DayKey(year: 2026, month: 9, day: 28))
        #expect(DayKey(year: 2026, month: 10, day: 4).weekStart == DayKey(year: 2026, month: 9, day: 28))   // Sunday
        #expect(DayKey(year: 2026, month: 10, day: 5).weekStart == DayKey(year: 2026, month: 10, day: 5))
    }
    @Test func timeZoneDecidesTheDay() {
        let instant = d(2026, 9, 30, 23, 30, tz: Fixtures.newYork)   // 03:30 UTC Oct 1
        #expect(DayKey(date: instant, timeZone: Fixtures.newYork) == DayKey(year: 2026, month: 9, day: 30))
        #expect(DayKey(date: instant, timeZone: utc) == DayKey(year: 2026, month: 10, day: 1))
        #expect(DayKey(date: instant, timeZone: Fixtures.tokyo) == DayKey(year: 2026, month: 10, day: 1))
    }
}

@Suite("XP, levels, streak")
struct XPStreakTests {
    @Test func levelCurve() {
        #expect(LevelCurve.level(forXP: 0) == 1)
        #expect(LevelCurve.level(forXP: 99) == 1)
        #expect(LevelCurve.level(forXP: 100) == 2)
        #expect(LevelCurve.level(forXP: 299) == 2)
        #expect(LevelCurve.level(forXP: 300) == 3)
        #expect(LevelCurve.progress(forXP: 200) == 0.5)
    }

    @Test func addXPLevelsUp() {
        var s = LearnerState()
        let a = s.addXP(90, now: d(2026, 9, 30), timeZone: utc)
        #expect(!a.leveledUp && a.totalXP == 90)
        let b = s.addXP(10, now: d(2026, 9, 30), timeZone: utc)
        #expect(b.leveledUp && b.level == 2 && s.level == 2)
    }

    @Test func zeroXPDoesNotStartStreak() {
        var s = LearnerState()
        s.addXP(0, now: d(2026, 9, 30), timeZone: utc)
        #expect(s.streak.current == 0 && s.streak.lastActiveDay == nil)
    }

    @Test func firstXPStartsStreakAtOneAndSameDayDoesNotDoubleCount() {
        var s = LearnerState()
        let a = s.addXP(10, now: d(2026, 9, 30, 8), timeZone: utc)
        #expect(a.streak == 1 && a.streakIncreased)
        let b = s.addXP(10, now: d(2026, 9, 30, 20), timeZone: utc)
        #expect(b.streak == 1 && !b.streakIncreased)
    }

    @Test func consecutiveDaysIncrement() {
        var s = LearnerState()
        for day in 28...30 { s.addXP(10, now: d(2026, 9, day), timeZone: utc) }
        #expect(s.streak.current == 3 && s.streak.longest == 3)
    }

    @Test func gapResetsToOneOnNextXP() {
        var s = LearnerState()
        s.addXP(10, now: d(2026, 9, 28), timeZone: utc)
        s.addXP(10, now: d(2026, 9, 29), timeZone: utc)
        s.addXP(10, now: d(2026, 10, 2), timeZone: utc)   // missed Sept 30 and Oct 1
        #expect(s.streak.current == 1 && s.streak.longest == 2)
    }

    @Test func displayedStreakResetsAfterAMissedDay() {
        var s = LearnerState()
        s.addXP(10, now: d(2026, 9, 28), timeZone: utc)
        s.addXP(10, now: d(2026, 9, 29), timeZone: utc)
        #expect(s.currentStreak(now: d(2026, 9, 29, 23, 59), timeZone: utc) == 2)
        #expect(s.currentStreak(now: d(2026, 9, 30, 12), timeZone: utc) == 2)    // yesterday still counts, day not over
        #expect(s.currentStreak(now: d(2026, 10, 1, 0, 1), timeZone: utc) == 0)  // a full day passed with no XP
    }

    @Test func streakUsesLocalCalendarDayNotElapsedHours() {
        var s = LearnerState()
        // 23:50 and 00:10 local (20 minutes apart) are different calendar days.
        s.addXP(10, now: d(2026, 9, 30, 23, 50, tz: Fixtures.newYork), timeZone: Fixtures.newYork)
        s.addXP(10, now: d(2026, 10, 1, 0, 10, tz: Fixtures.newYork), timeZone: Fixtures.newYork)
        #expect(s.streak.current == 2)
    }

    @Test func streakAcrossDSTTransition() {
        // US DST ended 2026-11-01. Days 10/31, 11/1, 11/2 are still three consecutive local days.
        var s = LearnerState()
        for (m, day) in [(10, 31), (11, 1), (11, 2)] { s.addXP(10, now: d(2026, m, day, 9, tz: Fixtures.newYork), timeZone: Fixtures.newYork) }
        #expect(s.streak.current == 3)
    }

    @Test func weeklyXPAccumulatesAndRolls() {
        var s = LearnerState()
        s.addXP(10, now: d(2026, 9, 28), timeZone: utc)   // Monday
        s.addXP(20, now: d(2026, 10, 4), timeZone: utc)   // Sunday, same week
        #expect(s.weeklyXP(now: d(2026, 10, 4), timeZone: utc) == 30)
        s.addXP(5, now: d(2026, 10, 5), timeZone: utc)    // next Monday
        #expect(s.weeklyXP(now: d(2026, 10, 5), timeZone: utc) == 5)
        #expect(s.weeklyXP(now: d(2026, 10, 12), timeZone: utc) == 0)   // stale week reads as 0
        #expect(s.totalXP == 35)
    }
}

@Suite("Hearts")
struct HeartsTests {
    private let t0 = d(2026, 9, 30, 8)

    @Test func startsFullAtFive() {
        let s = LearnerState()
        #expect(s.hearts == 5 && s.heartsStatus(now: t0).current == 5 && s.heartsStatus(now: t0).nextHeartAt == nil)
    }

    @Test func loseHeartStartsRegenClock() {
        var s = LearnerState()
        s.loseHearts(1, now: t0)
        #expect(s.hearts == 4 && s.heartRegenAnchor == t0)
        #expect(s.heartsStatus(now: t0).nextHeartAt == t0.addingTimeInterval(4 * 3600))
    }

    @Test func regensOneHeartPerFourHours() {
        var s = LearnerState()
        s.loseHearts(3, now: t0)
        #expect(s.heartsStatus(now: t0.addingTimeInterval(4 * 3600 - 1)).current == 2)
        #expect(s.heartsStatus(now: t0.addingTimeInterval(4 * 3600)).current == 3)
        #expect(s.heartsStatus(now: t0.addingTimeInterval(9 * 3600)).current == 4)
        #expect(s.heartsStatus(now: t0.addingTimeInterval(100 * 3600)).current == 5)
    }

    @Test func syncKeepsPartialProgressTowardTheNextHeart() {
        var s = LearnerState()
        s.loseHearts(3, now: t0)
        s.syncHearts(now: t0.addingTimeInterval(5 * 3600))   // +1 heart, 1h into the next interval
        #expect(s.hearts == 3)
        #expect(s.heartsStatus(now: t0.addingTimeInterval(5 * 3600)).nextHeartAt == t0.addingTimeInterval(8 * 3600))
    }

    @Test func regenStopsAtMaxAndClearsAnchor() {
        var s = LearnerState()
        s.loseHearts(1, now: t0)
        s.syncHearts(now: t0.addingTimeInterval(50 * 3600))
        #expect(s.hearts == 5 && s.heartRegenAnchor == nil)
    }

    @Test func losingMoreDoesNotResetTheClock() {
        var s = LearnerState()
        s.loseHearts(1, now: t0)
        s.loseHearts(1, now: t0.addingTimeInterval(3600))
        #expect(s.hearts == 3 && s.heartRegenAnchor == t0)
    }

    @Test func floorsAtZeroAndReportsEmpty() {
        var s = LearnerState()
        s.loseHearts(9, now: t0)
        #expect(s.hearts == 0 && s.heartsStatus(now: t0).isEmpty)
    }

    @Test func premiumIsUnlimited() {
        var s = LearnerState()
        s.isPremium = true
        s.loseHearts(3, now: t0)
        #expect(s.hearts == 5)
        let st = s.heartsStatus(now: t0)
        #expect(st.isUnlimited && !st.isEmpty)
    }

    @Test func practiceEarnsAHeart() {
        var s = LearnerState()
        s.loseHearts(5, now: t0)
        s.earnHeart(now: t0)
        #expect(s.hearts == 1)
        for _ in 0..<10 { s.earnHeart(now: t0) }
        #expect(s.hearts == 5 && s.heartRegenAnchor == nil)
    }
}

@Suite("Mastery and Leitner")
struct MasteryTests {
    private let policy = ReviewPolicy(intervalsDays: [1, 3, 7, 14, 30, 60], masteryThreshold: 0.8, decayAfterDays: 45)
    private let t0 = d(2026, 9, 1)

    private func correct(_ id: String = "downs", _ delta: Double = 0.2) -> [ConceptEvidence] { [ConceptEvidence(conceptId: id, delta: delta, correct: true)] }
    private func wrong(_ id: String = "downs") -> [ConceptEvidence] { [ConceptEvidence(conceptId: id, delta: -0.15, correct: false)] }

    @Test func firstCorrectPlacesInBoxZero() {
        var m = CourseMastery(courseId: "c")
        m.apply(correct(), activityId: "a", now: t0, policy: policy)
        let c = m.concepts["downs"]!
        #expect(c.box == 0 && c.dueAt == t0.addingTimeInterval(86_400) && c.value == 0.2 && c.attempts == 1 && c.lastActivityId == "a")
    }

    @Test func correctReviewAdvancesBox() {
        var m = CourseMastery(courseId: "c")
        m.apply(correct(), activityId: "a", now: t0, policy: policy)
        let t1 = t0.addingTimeInterval(86_400)
        m.apply(correct(), activityId: "a", now: t1, policy: policy)
        #expect(m.concepts["downs"]!.box == 1 && m.concepts["downs"]!.dueAt == t1.addingTimeInterval(3 * 86_400))
        let t2 = t1.addingTimeInterval(3 * 86_400)
        m.apply(correct(), activityId: "a", now: t2, policy: policy)
        #expect(m.concepts["downs"]!.box == 2 && m.concepts["downs"]!.dueAt == t2.addingTimeInterval(7 * 86_400))
    }

    @Test func correctBeforeDueDoesNotAdvance() {
        var m = CourseMastery(courseId: "c")
        m.apply(correct(), activityId: "a", now: t0, policy: policy)
        m.apply(correct(), activityId: "a", now: t0.addingTimeInterval(3600), policy: policy)
        #expect(m.concepts["downs"]!.box == 0 && m.concepts["downs"]!.dueAt == t0.addingTimeInterval(86_400))
    }

    @Test func wrongDropsTwoBoxesFloorZero() {
        var m = CourseMastery(courseId: "c")
        var now = t0
        for _ in 0..<5 { m.apply(correct(), activityId: "a", now: now, policy: policy); now = m.concepts["downs"]!.dueAt! }
        #expect(m.concepts["downs"]!.box == 4)
        m.apply(wrong(), activityId: "a", now: now, policy: policy)
        #expect(m.concepts["downs"]!.box == 2 && m.concepts["downs"]!.dueAt == now.addingTimeInterval(7 * 86_400))
        m.apply(wrong(), activityId: "a", now: now, policy: policy)
        #expect(m.concepts["downs"]!.box == 0)
        m.apply(wrong(), activityId: "a", now: now, policy: policy)
        #expect(m.concepts["downs"]!.box == 0)
    }

    @Test func boxCapsAtLastInterval() {
        var m = CourseMastery(courseId: "c")
        var now = t0
        for _ in 0..<12 { m.apply(correct(), activityId: "a", now: now, policy: policy); now = m.concepts["downs"]!.dueAt! }
        #expect(m.concepts["downs"]!.box == 5)
    }

    @Test func firstAnswerWrongStillSchedulesReview() {
        var m = CourseMastery(courseId: "c")
        m.apply(wrong(), activityId: "a", now: t0, policy: policy)
        #expect(m.concepts["downs"]!.box == 0 && m.concepts["downs"]!.dueAt != nil && m.concepts["downs"]!.value == 0)
    }

    @Test func valueIsClamped() {
        var m = CourseMastery(courseId: "c")
        m.apply(correct("x", 5), activityId: nil, now: t0, policy: policy)
        #expect(m.concepts["x"]!.value == 1)
        m.apply(wrong("x") + [ConceptEvidence(conceptId: "y", delta: -1, correct: false)], activityId: nil, now: t0, policy: policy)
        #expect(m.concepts["y"]!.value == 0)
    }

    @Test func nilCorrectnessDoesNotSchedule() {
        var m = CourseMastery(courseId: "c")
        m.apply([ConceptEvidence(conceptId: "z", delta: 0.1, correct: nil)], activityId: nil, now: t0, policy: policy)
        #expect(m.concepts["z"]!.box == nil && m.concepts["z"]!.dueAt == nil)
    }

    @Test func statusLabelsAndThreshold() {
        var m = CourseMastery(courseId: "c")
        #expect(m.status("downs", now: t0, policy: policy) == .new)
        m.apply(correct(), activityId: nil, now: t0, policy: policy)
        #expect(m.status("downs", now: t0, policy: policy) == .learning)
        m.apply(correct("downs", 0.6), activityId: nil, now: t0, policy: policy)
        #expect(m.status("downs", now: t0, policy: policy) == .mastered)   // 0.8 >= 0.8
    }

    @Test func newlyMasteredReportedOnce() {
        var m = CourseMastery(courseId: "c")
        let first = m.apply(correct("downs", 0.85), activityId: nil, now: t0, policy: policy)
        #expect(first[0].newlyMastered)
        let second = m.apply(correct("downs", 0.05), activityId: nil, now: t0, policy: policy)
        #expect(!second[0].newlyMastered)
    }

    @Test func decayAfterInactivityWithFloor() {
        var m = CourseMastery(courseId: "c")
        m.apply(correct("downs", 0.9), activityId: nil, now: t0, policy: policy)
        let c = m.concepts["downs"]!
        #expect(c.effectiveValue(now: t0.addingTimeInterval(45 * 86_400), decayAfterDays: 45) == 0.9)   // not yet
        let at60 = c.effectiveValue(now: t0.addingTimeInterval(60 * 86_400), decayAfterDays: 45)
        #expect(abs(at60 - (0.9 - 0.6)) < 1e-9 || abs(at60 - 0.45) < 1e-9)    // 0.9 - 0.01*60 = 0.30, floored at 0.45
        #expect(abs(at60 - 0.45) < 1e-9)
        #expect(m.status("downs", now: t0.addingTimeInterval(60 * 86_400), policy: policy) == .learning)
        #expect(c.effectiveValue(now: t0.addingTimeInterval(1000 * 86_400), decayAfterDays: nil) == 0.9)
    }

    @Test func decayMaterializedBeforeApplyingNewEvidence() {
        var m = CourseMastery(courseId: "c")
        m.apply(correct("downs", 0.9), activityId: nil, now: t0, policy: policy)
        m.apply(correct("downs", 0.1), activityId: nil, now: t0.addingTimeInterval(60 * 86_400), policy: policy)
        #expect(abs(m.concepts["downs"]!.value - 0.55) < 1e-9)   // 0.45 (decayed floor) + 0.1
        #expect(m.concepts["downs"]!.peak == 0.9)
    }

    @Test func dueAndWeakLists() {
        var m = CourseMastery(courseId: "c")
        m.apply(correct("a"), activityId: nil, now: t0, policy: policy)
        m.apply(correct("b", 0.9), activityId: nil, now: t0.addingTimeInterval(3600), policy: policy)
        #expect(m.dueConceptIds(now: t0.addingTimeInterval(3600)).isEmpty)
        #expect(m.dueConceptIds(now: t0.addingTimeInterval(86_400 + 60)) == ["a"])
        #expect(m.dueConceptIds(now: t0.addingTimeInterval(3 * 86_400)) == ["a", "b"])   // most overdue first
        #expect(m.weakConceptIds(now: t0, policy: policy) == ["a"])
        #expect(m.masteredConceptIds(now: t0, policy: policy) == ["b"])
    }
}

@Suite("ProgressEngine")
struct ProgressEngineTests {
    private let policy = ReviewPolicy()

    @Test func appliesXPHeartsAndMasteryTogether() async throws {
        let clock = ManualClock(d(2026, 9, 30, 10))
        let (engine, repo) = Fixtures.engine(clock: clock)
        let outcome = ExerciseOutcome(activityId: "a", correct: false, score: 0, xp: 0, heartsLost: 1,
                                      conceptEvidence: [.init(conceptId: "downs", delta: -0.15, correct: false)])
        let u = try await engine.apply(outcome, courseId: "c", policy: policy)
        #expect(u.heartsLost == 1 && u.hearts.current == 4 && u.xpAward == nil)
        #expect(try await repo.learnerState().hearts == 4)
        #expect(try await repo.mastery(courseId: "c").concepts["downs"]?.attempts == 1)
    }

    @Test func xpStartsStreakThroughEngine() async throws {
        let clock = ManualClock(d(2026, 9, 30))
        let (engine, _) = Fixtures.engine(clock: clock)
        let o = ExerciseOutcome(correct: true, score: 100, xp: 10, heartsLost: 0)
        let a = try await engine.apply(o, courseId: "c", policy: policy)
        #expect(a.xpGained == 10 && a.xpAward?.streak == 1)
        clock.advance(days: 1)
        let b = try await engine.apply(o, courseId: "c", policy: policy)
        #expect(b.xpAward?.streak == 2)
        clock.advance(days: 3)
        #expect(try await engine.currentStreak() == 0)
    }

    @Test func engineUsesInjectedTimeZoneForStreakDays() async throws {
        let instant = d(2026, 9, 30, 23, 30, tz: Fixtures.newYork)
        let clock = ManualClock(instant)
        let (engine, _) = Fixtures.engine(clock: clock, tz: Fixtures.newYork)
        _ = try await engine.awardXP(10)
        clock.advance(by: 3600)   // 00:30 local next day
        _ = try await engine.awardXP(10)
        #expect(try await engine.currentStreak() == 2)
    }

    @Test func heartsRegenerateViaClock() async throws {
        let clock = ManualClock(d(2026, 9, 30, 10))
        let (engine, _) = Fixtures.engine(clock: clock)
        _ = try await engine.apply(ExerciseOutcome(correct: false, score: 0, xp: 0, heartsLost: 2), courseId: "c", policy: policy)
        #expect(try await engine.hearts().current == 3)
        clock.advance(by: 4 * 3600)
        #expect(try await engine.hearts().current == 4)
        #expect(try await engine.learnerState().hearts == 4)
    }

    @Test func premiumIgnoresHeartLoss() async throws {
        let clock = ManualClock(d(2026, 9, 30))
        let (engine, _) = Fixtures.engine(clock: clock)
        try await engine.setPremium(true)
        let u = try await engine.apply(ExerciseOutcome(correct: false, score: 0, xp: 0, heartsLost: 3), courseId: "c", policy: policy)
        #expect(u.heartsLost == 0 && u.hearts.isUnlimited)
    }

    @Test func newlyMasteredSurfaced() async throws {
        let clock = ManualClock(d(2026, 9, 30))
        let (engine, _) = Fixtures.engine(clock: clock)
        let u = try await engine.apply(ExerciseOutcome(correct: true, score: 100, xp: 10, heartsLost: 0,
                                                       conceptEvidence: [.init(conceptId: "downs", delta: 0.9, correct: true)]), courseId: "c", policy: policy)
        #expect(u.newlyMastered == ["downs"])
    }

    @Test func earnHeartAndWeeklyXP() async throws {
        let clock = ManualClock(d(2026, 9, 30))
        let (engine, _) = Fixtures.engine(clock: clock)
        _ = try await engine.apply(ExerciseOutcome(correct: false, score: 0, xp: 0, heartsLost: 5), courseId: "c", policy: policy)
        try await engine.earnHeart()
        #expect(try await engine.hearts().current == 1)
        _ = try await engine.awardXP(25)
        #expect(try await engine.weeklyXP() == 25)
    }
}

@Suite("Common ground and league")
struct CommonGroundTests {
    @Test func coverageIsMasteryOverThresholdAveraged() throws {
        let c = try Fixtures.curriculum()
        let now = d(2026, 9, 30)
        var m = CourseMastery(courseId: "american-football")
        #expect(CommonGround.coverage(curriculum: c, mastery: m, branchId: "nfl", now: now) == 0)
        // 6 concepts taught. Master one fully, another to half of threshold.
        m.apply([.init(conceptId: "downs", delta: 1.0, correct: true), .init(conceptId: "quarterback", delta: 0.4, correct: true)], activityId: nil, now: now, policy: c.reviewPolicy)
        let cov = CommonGround.coverage(curriculum: c, mastery: m, branchId: "nfl", now: now)
        #expect(abs(cov - (1.0 + 0.5) / 6) < 1e-9)
    }

    @Test func personScoreWeightsMainInterestDouble() {
        let p = Person(displayName: "P", relationship: .friend, interests: [
            PersonInterest(courseId: "a", isMainInterest: true),
            PersonInterest(courseId: "b"),
        ])
        let s = CommonGround.score(for: p, coverages: ["a": 0.9, "b": 0.0])
        #expect(abs(s - 0.6) < 1e-9)   // (2*0.9 + 1*0) / 3
        #expect(CommonGround.percent(s) == 60)
    }

    @Test func personWithNoInterestsIsZero() {
        #expect(CommonGround.score(for: Person(displayName: "X", relationship: .other), coverages: [:]) == 0)
    }

    @Test func missingCoverageCountsAsZero() {
        let p = Person(displayName: "P", relationship: .friend, interests: [PersonInterest(courseId: "a"), PersonInterest(courseId: "b")])
        #expect(CommonGround.score(for: p, coverages: ["a": 1.0]) == 0.5)
    }

    @Test func asyncServiceMatchesManualCalculation() async throws {
        let clock = ManualClock(d(2026, 9, 30))
        let (engine, _) = Fixtures.engine(clock: clock)
        _ = try await engine.apply(ExerciseOutcome(correct: true, score: 100, xp: 10, heartsLost: 0,
                                                   conceptEvidence: [.init(conceptId: "downs", delta: 1.0, correct: true)]),
                                   courseId: "american-football", policy: try Fixtures.curriculum().reviewPolicy)
        let s = try await CommonGround.score(for: Fixtures.sarah, content: Fixtures.repo(), engine: engine)
        #expect(abs(s - 1.0 / 6) < 1e-9)
    }

    @Test func leagueRanksByWeeklyXPWithStableTies() {
        let ranked = League.ranked([
            (id: "1", name: "Zed", weeklyXP: 50, isLearner: false),
            (id: "2", name: "Me", weeklyXP: 120, isLearner: true),
            (id: "3", name: "Amy", weeklyXP: 50, isLearner: false),
            (id: "4", name: "Bob", weeklyXP: 10, isLearner: false),
        ])
        #expect(ranked.map(\.name) == ["Me", "Amy", "Zed", "Bob"])
        #expect(ranked.map(\.rank) == [1, 2, 3, 4])
        #expect(League.learnerRank(in: ranked) == 1)
    }

    @Test func leagueWithNoLearnerHasNoRank() {
        #expect(League.learnerRank(in: League.ranked([(id: "1", name: "A", weeklyXP: 1, isLearner: false)])) == nil)
    }
}
