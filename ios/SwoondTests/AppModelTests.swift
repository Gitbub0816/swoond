import Foundation
import SwoondCore
import Testing
@testable import Swoond

@MainActor
@Suite("AppModel")
struct AppModelTests {
    @Test func firstRunGoesToOnboardingThenReady() async {
        let model = AppModel(env: .preview(people: []))
        await model.bootstrap()
        #expect(model.phase == .onboarding)

        var draft = OnboardingDraft()
        draft.name = "Maya"
        draft.toggle("hockey")
        await model.addPerson(from: draft)

        #expect(model.phase == .ready)
        #expect(model.activePerson?.displayName == "Maya")
        #expect(model.people.count == 1)
        #expect(model.activePerson?.interests.first?.isMainInterest == true)
    }

    @Test func bundledSeedContentIsAvailable() async {
        let model = AppModel(env: .preview())
        await model.bootstrap()
        let ids = Set(model.courses.map(\.courseId))
        #expect(ids.isSuperset(of: ["hockey", "nascar", "pickleball"]))
        #expect(model.interestName("hockey") == "Hockey")
        #expect(model.interestName("video-games") == "Video games")   // no content, catalog name
        #expect(!model.hasContent(courseId: "video-games"))
    }

    @Test func settingsPersistAndDriveHaptics() async {
        let model = AppModel(env: .preview())
        await model.bootstrap()
        model.updateSettings { $0.appearance = .light; $0.soundsAndHaptics = false }
        #expect(model.env.settingsStore.load().appearance == .light)
        #expect(Haptics.shared.isEnabled == false)
        model.settings.soundsAndHaptics = true
        #expect(Haptics.shared.isEnabled)
        #expect(model.settings.appearance.colorScheme == .light)
    }

    @Test func discreetModeIsOnByDefault() {
        #expect(AppSettings().discreetMode)
        #expect(AppSettings().appearance == .dark)
    }

    @Test func switchingPersonUpdatesActivePerson() async {
        let model = AppModel(env: .preview())
        await model.bootstrap()
        model.setActivePerson(PreviewData.jordan.id)
        #expect(model.activePerson?.displayName == "Jordan")
    }
}

@MainActor
@Suite("Home and Games view models")
struct HomeGamesViewModelTests {
    private func readyModel() async -> AppModel {
        let model = AppModel(env: .preview())
        await model.bootstrap()
        await PreviewSeeder.seedProgress(model.env)
        return model
    }

    @Test func homeShowsActivePersonInterestsAndTodaysGame() async {
        let model = await readyModel()
        let vm = HomeViewModel()
        await vm.load(model: model)
        #expect(vm.rows.map(\.id) == ["hockey", "nascar", "pickleball", "video-games"])   // main first
        #expect(vm.rows.first?.isMain == true)
        #expect(vm.rows.last?.hasContent == false)
        #expect(vm.hero != nil)
        #expect(vm.commonGround > 0 && vm.commonGround < 1)
        #expect(!vm.commonGroundLine.isEmpty)
    }

    @Test func gamesHubListsLessonsWithStatus() async {
        let model = await readyModel()
        let vm = GamesViewModel()
        await vm.load(model: model)
        let hockey = vm.sections.first { $0.id == "hockey" }
        #expect(hockey?.rows.map(\.lessonId) == ["rink-01", "rink-02"])
        #expect(hockey?.rows.first?.status == .completed)   // seeded as done
        #expect(vm.sections.count == 3)
    }

    @Test func talkTracksUnlockWhenTheirUnitIsDone() async throws {
        let model = await readyModel()
        let vm = TalkViewModel()
        await vm.load(model: model)
        #expect(vm.tracks.count == 1 && vm.tracks[0].isUnlocked == false && vm.tracks[0].unlockHint != nil)

        var progress = CourseProgress(personId: PreviewData.maya.id, courseId: "hockey")
        for l in ["rink-01", "rink-02"] { progress.lessonResults[l] = .init(completedAt: Date(), correctCount: 3, totalCount: 3, xpEarned: 70) }
        try await model.env.engine.save(progress)
        await vm.load(model: model)
        #expect(vm.tracks[0].isUnlocked)
    }

    @Test func playbookSearchAndFilter() async {
        let model = await readyModel()
        let vm = PlaybookViewModel()
        await vm.load(model: model)
        #expect(vm.entries.count >= 15)
        #expect(vm.interests.map(\.id) == ["hockey", "nascar", "pickleball"])
        vm.query = "power  play"
        #expect(vm.visible.map(\.concept.id) == ["power-play"])
        vm.query = ""
        vm.courseFilter = "nascar"
        #expect(vm.visible.allSatisfy { $0.courseId == "nascar" })
        #expect(vm.entries.first?.status == .mastered)   // seeded power play
    }

    @Test func leagueRanksTheLearner() async {
        let model = await readyModel()
        let vm = LeagueViewModel()
        await vm.load(model: model)
        #expect(vm.snapshot?.entries.count == 8)
        #expect(vm.snapshot?.learnerRank != nil)
    }
}

@MainActor
@Suite("GameSessionViewModel")
struct GameSessionViewModelTests {
    private func hockeyLesson(_ model: AppModel) -> GameLaunch {
        GameLaunch(personId: PreviewData.maya.id, courseId: "hockey", kind: .lesson(unitId: "rink-basics", lessonId: "rink-01"))
    }

    @Test func playsALessonToResults() async throws {
        let model = AppModel(env: .preview())
        await model.bootstrap()
        let vm = GameSessionViewModel(launch: hockeyLesson(model), model: model)
        await vm.start()
        guard case .playing = vm.phase else { Issue.record("expected playing, got \(vm.phase)"); return }
        #expect(vm.presentation?.total == 3)

        // 1. term-match: three correct pairings.
        for (term, definition) in [("pp", "One team has an extra skater"), ("ic", "Puck shot past the far goal line; play stops"), ("ht", "Three goals by one player")] {
            vm.record(.pairing(termId: term, definition: definition))
        }
        await vm.next()
        // 2. say-this, 3. sequence-order
        #expect(vm.presentation?.activity.id == "rink-01-say")
        vm.record(.choices(["a", "c"]))
        await vm.next()
        #expect(vm.presentation?.activity.id == "rink-01-seq")
        #expect(vm.isLastActivity)
        vm.record(.order(["shoot", "cross", "whistle", "face"]))
        await vm.next()

        guard case .results(let results) = vm.phase else { Issue.record("expected results, got \(vm.phase)"); return }
        #expect(results.xpEarned == 70)          // 3 x 10 + 40 finished game
        #expect(results.accuracyPercent == 100)
        #expect(results.headlineEmphasis == "hang.")
        #expect(!results.unlockedLines.isEmpty)
        #expect(results.leagueRank != nil)
        #expect(model.learner.totalXP >= 70)
    }

    @Test func wrongAnswerCostsAHeart() async throws {
        let model = AppModel(env: .preview())
        await model.bootstrap()
        let vm = GameSessionViewModel(launch: GameLaunch(personId: PreviewData.maya.id, courseId: "nascar", kind: .lesson(unitId: "pit-lane", lessonId: "flags-01")), model: model)
        await vm.start()
        #expect(vm.presentation?.activity.id == "flags-01-est")
        vm.record(.value(9))   // far from 5
        await vm.next()
        #expect(vm.hearts.current == 4)
    }

    @Test func emptyHeartsBlockPlayAndOfferTheSheet() async {
        var state = LearnerState()
        state.hearts = 0
        state.heartRegenAnchor = Date()
        let model = AppModel(env: .preview(state: state))
        await model.bootstrap()
        let vm = GameSessionViewModel(launch: hockeyLesson(model), model: model)
        await vm.start()
        guard case .heartsEmpty = vm.phase else { Issue.record("expected heartsEmpty, got \(vm.phase)"); return }
        #expect(vm.showHeartsSheet)
    }

    @Test func unknownPersonFailsGracefully() async {
        let model = AppModel(env: .preview())
        await model.bootstrap()
        let vm = GameSessionViewModel(launch: GameLaunch(personId: "nobody", courseId: "hockey", kind: .review), model: model)
        await vm.start()
        guard case .failed = vm.phase else { Issue.record("expected failed"); return }
    }

    @Test func friendlyErrorsAreHumanReadable() {
        #expect(GameSessionViewModel.friendly(SessionError.lessonLocked).contains("unlocked"))
        #expect(GameSessionViewModel.friendly(ContentError.courseNotFound("x")).contains("isn\u{2019}t on your phone"))
        #expect(GameSessionViewModel.friendly(BridgeError.aborted).contains("No hearts lost"))
    }
}

@MainActor
@Suite("Design system and previews")
struct DesignSystemTests {
    @Test func embeddedPreviewPayloadsStillBuildEngines() {
        _ = PreviewData.multipleChoice(); _ = PreviewData.binaryCall(); _ = PreviewData.termMatch(); _ = PreviewData.sequenceOrder()
        _ = PreviewData.visualID(); _ = PreviewData.decisionScenario(); _ = PreviewData.talkTrack(); _ = PreviewData.timingTap()
        _ = PreviewData.sayThis(); _ = PreviewData.fillTheGap(); _ = PreviewData.listeningID(); _ = PreviewData.estimateSlider()
        _ = PreviewData.hotspotTap()
    }

    @Test func diagramStyleFollowsHints() {
        #expect(DiagramBackground.style(kind: .courtDiagram, diagramId: "pickleball-court") == .pickleball)
        #expect(DiagramBackground.style(kind: nil, diagramId: "football-formation-cover-3") == .field)
        #expect(DiagramBackground.style(kind: nil, diagramId: nil) == .plain)
    }

    @Test func quotesAreTrimmedBeforeTheUIAddsItsOwn() {
        #expect("\u{201C}Hello\u{201D}".trimmingQuotes == "Hello")
        #expect("\"Hi there\"".trimmingQuotes == "Hi there")
    }
}
