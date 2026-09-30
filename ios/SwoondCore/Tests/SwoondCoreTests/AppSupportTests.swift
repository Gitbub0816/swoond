import Foundation
import Testing
@testable import SwoondCore

@Suite("InterestCatalog")
struct InterestCatalogTests {
    @Test func hasTwentyLaunchInterestsWithUniqueIds() {
        #expect(InterestCatalog.launch.count == 20)
        #expect(Set(InterestCatalog.launch.map(\.id)).count == 20)
    }
    @Test func normalizeStripsApostrophesAndSpaces() {
        for q in ["Swoon'd", "Swoon\u{2019}d", "Swoon d", "swoond", "SWOOND"] { #expect(InterestCatalog.normalize(q) == "swoond") }
    }
    @Test func searchMatchesPrefixAndKebabIds() {
        #expect(InterestCatalog.search("video").map(\.id) == ["video-games"])
        #expect(InterestCatalog.search("k pop").map(\.id) == ["k-pop"])
        #expect(InterestCatalog.search("").count == 20)
    }
    @Test func displayNameFallsBackToPrettyKebab() {
        #expect(InterestCatalog.displayName(for: "hockey") == "Hockey")
        #expect(InterestCatalog.displayName(for: "board-games") == "Board games")
        #expect(InterestCatalog.monogram(for: "board-games") == "Bo")
    }
}

@Suite("OnboardingDraft")
struct OnboardingDraftTests {
    @Test func cannotAdvanceWithoutNameOrInterests() {
        var d = OnboardingDraft()
        #expect(!d.canAdvance)
        d.name = "  Maya "
        #expect(d.canAdvance && d.trimmedName == "Maya")
        #expect(d.advance() && d.step == .interests)
        #expect(!d.canAdvance && !d.advance())
        d.toggle("hockey")
        #expect(d.advance() && d.step == .plan)
        d.back()
        #expect(d.step == .interests)
    }
    @Test func toggleAndSelectionLabel() {
        var d = OnboardingDraft()
        #expect(d.selectionLabel == "Pick at least one")
        d.toggle("hockey"); #expect(d.selectionLabel == "1 interest selected")
        d.toggle("nascar"); #expect(d.selectionLabel == "2 interests selected")
        d.setMain("nascar"); d.toggle("nascar")
        #expect(d.mainInterestId == nil)
    }
    @Test func makePersonMarksMainInterest() {
        var d = OnboardingDraft()
        d.name = "Maya"; d.relationship = .friend
        d.toggle("hockey"); d.toggle("nascar"); d.setMain("nascar")
        let p = d.makePerson(id: "p1", createdAt: Date(timeIntervalSince1970: 0))
        #expect(p.displayName == "Maya" && p.relationship == .friend)
        #expect(p.interests.map(\.courseId) == ["hockey", "nascar"])
        #expect(p.interests.map(\.isMainInterest) == [false, true])
    }
    @Test func defaultMainIsFirstSelection() {
        var d = OnboardingDraft()
        d.name = "Sam"; d.toggle("golf"); d.toggle("wine")
        #expect(d.makePerson().interests.map(\.isMainInterest) == [true, false])
    }
}

@Suite("Playbook")
struct PlaybookTests {
    private func curriculum() -> Curriculum {
        Curriculum(courseId: "hockey", concepts: [
            Concept(id: "power-play", term: "Power play", definition: "One team has more skaters.", exampleLine: "x", tier: nil, relatedConceptIds: nil, aliases: nil),
            Concept(id: "icing", term: "Icing", definition: "Shooting the puck past the far goal line.", exampleLine: "y", tier: nil, relatedConceptIds: nil, aliases: ["no touch"]),
        ], units: [])
    }
    @Test func statusOrderingAndFiltering() {
        var m = CourseMastery(courseId: "hockey")
        var pp = ConceptMastery(); pp.value = 0.9; pp.peak = 0.9; pp.attempts = 3
        m.concepts["power-play"] = pp
        let entries = PlaybookIndex.entries(curricula: [curriculum()], mastery: ["hockey": m], now: Date())
        #expect(entries.map(\.concept.id) == ["power-play", "icing"])
        #expect(entries.map(\.status) == [.mastered, .new])
        #expect(PlaybookIndex.learnedCount(entries) == 1)
        #expect(PlaybookIndex.filter(entries, query: "no  touch", courseId: nil).map(\.concept.id) == ["icing"])
        #expect(PlaybookIndex.filter(entries, query: "", courseId: "nascar").isEmpty)
        #expect(PlaybookIndex.entries(curricula: [curriculum()], mastery: [:], now: Date(), includeNew: false).isEmpty)
    }
}

@Suite("League, badges, challenge, copy, notifications")
struct SocialTests {
    @Test func leagueRanksLearnerAndComputesGap() {
        let s = LeagueBoard.snapshot(learnerName: "Alex", learnerWeeklyXP: 540, now: Fixtures.date(2026, 9, 30), timeZone: Fixtures.utc)
        #expect(s.entries.count == 8)
        #expect(s.learnerRank == 3)
        #expect(s.xpBehindNextAbove == 45 && s.nameAboveLearner == "Sam")
        #expect(s.daysLeft == 5)   // Wednesday: 7 - 2
    }
    @Test func badgesUnlockFromStats() {
        #expect(BadgeCatalog.unlockedIds(for: LearnerStats()).isEmpty)
        let ids = BadgeCatalog.unlockedIds(for: LearnerStats(streak: 7, totalXP: 1200, level: 5, gamesPlayed: 6, conceptsMastered: 5, talkTracksDone: 1))
        #expect(ids.isSuperset(of: ["first-date", "pit-crew", "streak-7", "smooth-talker", "level-5", "thousand", "kitchen-cop"]))
        #expect(BadgeCatalog.all.count == 12)
    }
    @Test func challengeResolution() {
        let c = FriendChallenge.sample
        #expect(c.scoreLine == "4 / 5 in 38s")
        #expect(c.resolve(yourCorrect: 5, yourSeconds: 90) == .won)
        #expect(c.resolve(yourCorrect: 4, yourSeconds: 30) == .won)
        #expect(c.resolve(yourCorrect: 4, yourSeconds: 40) == .lost)
        #expect(c.resolve(yourCorrect: 4, yourSeconds: 38) == .tied)
        #expect(c.prizeXP == 80)
    }
    @Test func commonGroundCopy() {
        #expect(CommonGroundCopy.line(forPercent: 38) == "Enough to survive a first date.")
        #expect(CommonGroundCopy.line(forPercent: 100) == "You can genuinely hang.")
        #expect(CommonGroundCopy.resultsHeadline(accuracy: 0.95).emphasis == "hang.")
    }
    @Test func discreetNotificationsNeverContainName() {
        let d = NotificationComposer.dailyReminder(personName: "Maya", discreet: true)
        #expect(d.body == "Your daily game is ready" && !d.body.contains("Maya") && !d.title.contains("Maya"))
        #expect(NotificationComposer.dailyReminder(personName: "Maya", discreet: false).body.contains("Maya"))
        #expect(NotificationComposer.dailyReminder(personName: nil, discreet: false).body == "Your daily game is ready")
    }
    @Test func purchaseMock() async {
        let s = MockPurchaseService()
        #expect(await s.plans().count == 2)
        #expect(await s.restore() == .failed("Nothing to restore yet."))
        #expect(await s.purchase(.yearly) == .purchased)
        #expect(await s.hasEntitlement())
    }
    @Test func liveCompanionBuildsSnapshot() async throws {
        let snap = try await LiveCompanion.snapshot(courseId: "american-football", personalization: ["team": "Philadelphia Eagles"], provider: MockLiveDataProvider())
        let s = try #require(snap)
        #expect(s.favoriteIsHome && s.homeName == "Philadelphia Eagles" && s.moments.count == 2)
    }
}

@Suite("Seed content pack")
struct SeedContentTests {
    static let seedRoot = Fixtures.repoRoot.appendingPathComponent("ios/Swoond/Resources/ContentPacks")

    @Test func seedPacksDecodeAndValidate() async throws {
        let repo = try BundledContentRepository(rootDirectory: Self.seedRoot)
        let index = try await repo.courseIndex()
        #expect(Set(index.map(\.courseId)) == ["nascar", "pickleball", "hockey"])
        for s in index {
            let m = try await repo.manifest(courseId: s.courseId)
            let c = try await repo.curriculum(courseId: s.courseId, locale: "en-US")
            let issues = ContentValidator.validate(c) + ContentValidator.validate(manifest: m, curriculum: c)
            #expect(issues.filter { $0.severity == .error }.isEmpty, "\(s.courseId): \(issues)")
            #expect(!c.allActivities.isEmpty)
        }
    }

    @Test func compositeRepositoryMergesAndPrefersFirst() async throws {
        let seed = try BundledContentRepository(rootDirectory: Self.seedRoot)
        let sample = StaticContentRepository(manifests: [try Fixtures.manifest()], curricula: [try Fixtures.curriculum()])
        let repo = CompositeContentRepository([sample, seed])
        #expect(try await repo.courseIndex().count == 4)
        #expect(try await repo.curriculum(courseId: "hockey", locale: "en-US").courseId == "hockey")
        await #expect(throws: ContentError.courseNotFound("nope")) { try await repo.manifest(courseId: "nope") }
    }

    @Test func timingModeReachesTheEngine() throws {
        let c = try Fixtures.curriculum()
        let a = Activity(id: "t", type: .timingTap, conceptIds: [], payload: json(#"{"prompt":"p","theme":{"label":"Pit stop"},"rounds":[{"zoneStartPct":40,"zoneEndPct":60,"sweepSeconds":1}],"explanation":{"correct":"c","incorrect":"i"}}"#))
        _ = c
        let slow = try #require(try ExerciseSessionFactory.make(for: a, timingMode: .tapToStopSlow) as? TimingTapEngine)
        #expect(slow.rounds[0].sweepSeconds == 1.5)
        let std = try #require(try ExerciseSessionFactory.make(for: a) as? TimingTapEngine)
        #expect(std.rounds[0].sweepSeconds == 1)
    }

    @Test func stableSeedShufflesIdentically() {
        var g1 = SeededGenerator(stableSeed: "activity-1"), g2 = SeededGenerator(stableSeed: "activity-1")
        #expect(Array(1...10).shuffled(using: &g1) == Array(1...10).shuffled(using: &g2))
    }
}

@Suite("Settings and talk-track sessions")
struct SettingsAndTalkTests {
    @Test func settingsDefaultsAndRoundTrip() {
        let d = UserDefaults(suiteName: "swoond-test-\(UUID().uuidString)")!
        let store = UserDefaultsSettingsStore(defaults: d)
        var s = store.load()
        #expect(s.appearance == .dark && s.discreetMode && s.dailyReminder && s.reminderHour == 20 && s.reminderTimeLabel == "8:00 PM")
        s.appearance = .system; s.discreetMode = false; s.reminderHour = 0
        store.save(s)
        #expect(store.load() == s && store.load().reminderTimeLabel == "12:00 AM")
        #expect(InMemorySettingsStore(s).load() == s)
    }

    @Test func reminderSchedulerMock() async {
        let m = MockReminderScheduler()
        await m.scheduleDaily(hour: 20, content: NotificationComposer.dailyReminder(personName: "Maya", discreet: true))
        #expect(await m.scheduled?.hour == 20)
        await m.cancelDaily()
        #expect(await m.scheduled == nil)
    }

    @Test func startsATalkTrackAndFinishesWithXP() async throws {
        let repo = try BundledContentRepository(rootDirectory: SeedContentTests.seedRoot)
        let clock = ManualClock(Fixtures.date(2026, 9, 30, 9))
        let (engine, _) = Fixtures.engine(clock: clock)
        let person = Person(id: "maya", displayName: "Maya", relationship: .crush, interests: [PersonInterest(courseId: "hockey", isMainInterest: true)])
        let session = LearningSession(person: person, interest: person.interests[0], content: repo, engine: engine)
        // Locked until the unit that unlocks it is complete.
        await #expect(throws: SessionError.lessonLocked) { _ = try await session.startTalkTrack(trackId: "hockey-night") }
        var progress = CourseProgress(personId: "maya", courseId: "hockey")
        for l in ["rink-01", "rink-02"] { progress.lessonResults[l] = .init(completedAt: clock.now(), correctCount: 3, totalCount: 3, xpEarned: 40) }
        try await engine.save(progress)
        let p = try await session.startTalkTrack(trackId: "hockey-night")
        #expect(p.activity.type == .talkTrack && p.total == 1)
        _ = try await session.submit(.reply("c"))
        let r = try await session.submit(.reply("a"))
        #expect(r.step.evaluation?.isCorrect == true && r.update?.xpGained == 50)   // 40 + 10 bonus (smooth 110 -> 100)
        let summary = try await session.finish()
        #expect(summary.completionBonus == 0 && summary.xpEarned == 50)
    }

    @Test func tolerantCommonGroundIgnoresMissingCourses() async throws {
        let repo = try BundledContentRepository(rootDirectory: SeedContentTests.seedRoot)
        let (engine, _) = Fixtures.engine(clock: ManualClock(Fixtures.date(2026, 9, 30)))
        let person = Person(id: "m", displayName: "M", relationship: .friend, interests: [PersonInterest(courseId: "hockey"), PersonInterest(courseId: "not-installed")])
        #expect(await CommonGround.scoreTolerant(for: person, content: repo, engine: engine) == 0)
    }
}

@Suite("Settings compatibility")
struct SettingsCompatibilityTests {
    @Test func decodesSettingsSavedBeforeProfileFieldsExisted() throws {
        let old = #"{"appearance":"light","discreetMode":true,"dailyReminder":false,"reminderHour":9,"soundsAndHaptics":true}"#
        let s = try JSONDecoder().decode(AppSettings.self, from: Data(old.utf8))
        #expect(s.appearance == .light && s.learnerName == nil && s.joinedAt == nil && s.reminderHour == 9)
    }
    @Test func activityDisplayNamesAreDefinedForEveryType() {
        for t in ActivityType.allCases { #expect(!t.displayName.isEmpty) }
    }
}

@Suite("Branch visibility (contract 1.2)")
struct BranchVisibilityTests {
    private func branched() -> Curriculum {
        func concept(_ id: String) -> Concept { Concept(id: id, term: id, definition: "d", exampleLine: "e", tier: nil, relatedConceptIds: nil, aliases: nil) }
        func act(_ id: String, _ cids: [String], branch: String?) -> Activity {
            Activity(id: id, type: .multipleChoice, conceptIds: cids, payload: json(#"{"prompt":"p","options":[{"id":"a","text":"A"},{"id":"b","text":"B"}],"correctOptionIds":["a"],"explanation":{"correct":"c","incorrect":"i"}}"#), branchId: branch)
        }
        let shared = Lesson(id: "l1", title: "L1", objective: "o", conceptIds: ["base"], activities: [act("a-shared", ["base"], branch: nil), act("a-nfl", ["nfl-only"], branch: "nfl"), act("a-college", ["college-only"], branch: "college")])
        let nflUnit = Unit(id: "u-nfl", title: "NFL", layer: .branch, branchId: "nfl", lessons: [Lesson(id: "l-nfl", title: "N", objective: "o", conceptIds: ["nfl-unit"], activities: [act("a-nfl-unit", ["nfl-unit"], branch: nil)])])
        return Curriculum(courseId: "football", concepts: ["base", "nfl-only", "college-only", "nfl-unit", "glossary"].map(concept),
                          units: [Unit(id: "u1", title: "U1", layer: .foundations, lessons: [shared]), nflUnit])
    }

    @Test func lessonActivitiesFilterByBranch() {
        let lesson = branched().units[0].lessons[0]
        #expect(lesson.activities(forBranch: "nfl").map(\.id) == ["a-shared", "a-nfl"])
        #expect(lesson.activities(forBranch: nil).map(\.id) == ["a-shared"])
    }

    @Test func conceptsFollowTheBranch() {
        let c = branched()
        #expect(Set(c.concepts(forBranch: "nfl").map(\.id)) == ["base", "nfl-only", "nfl-unit", "glossary"])
        #expect(Set(c.concepts(forBranch: "college").map(\.id)) == ["base", "college-only", "glossary"])
    }

    @Test func sessionPlaysOnlyVisibleActivities() async throws {
        let c = branched()
        let repo = StaticContentRepository(curricula: [c])
        let (engine, _) = Fixtures.engine(clock: ManualClock(Fixtures.date(2026, 9, 30)))
        let person = Person(id: "p", displayName: "P", relationship: .friend, interests: [PersonInterest(courseId: "football", branchId: "college")])
        let session = LearningSession(person: person, interest: person.interests[0], content: repo, engine: engine)
        let p = try await session.startLesson(unitId: "u1", lessonId: "l1")
        #expect(p.total == 2)   // shared + college
    }

    @Test func playbookHidesOtherBranchConcepts() {
        let entries = PlaybookIndex.entries(curricula: [branched()], mastery: [:], now: Date(), branchIds: ["football": "college"])
        #expect(!entries.map(\.concept.id).contains("nfl-only") && entries.map(\.concept.id).contains("college-only"))
    }
}
