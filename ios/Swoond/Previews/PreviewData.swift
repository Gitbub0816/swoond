import Foundation
import SwiftUI
import SwoondCore

/// Seeded data for `#Preview`s and view-model tests. Force-`try` is acceptable here: a failure means the embedded
/// example is stale, and the preview crashing is the loudest way to say so.
enum PreviewData {
    static let maya = Person(
        id: "preview-maya", displayName: "Maya", relationship: .crush,
        interests: [
            PersonInterest(courseId: "hockey", personalization: ["team": "Edmonton Oilers"], isMainInterest: true),
            PersonInterest(courseId: "nascar"),
            PersonInterest(courseId: "pickleball"),
            PersonInterest(courseId: "video-games"),
        ],
        createdAt: Date(timeIntervalSince1970: 1_780_000_000))

    static let jordan = Person(id: "preview-jordan", displayName: "Jordan", relationship: .friend,
                               interests: [PersonInterest(courseId: "pickleball", isMainInterest: true)],
                               createdAt: Date(timeIntervalSince1970: 1_780_100_000), isActive: false)

    static var people: [Person] { [maya, jordan] }

    /// 12-day streak, 3,480 XP, 540 XP this week, 5 hearts.
    static func learnerState(now: Date = Date()) -> LearnerState {
        var s = LearnerState()
        s.totalXP = 2940
        s.addXP(540, now: now, timeZone: .current)
        s.streak.current = 12
        s.streak.longest = 12
        return s
    }

    static func decode<T: Decodable>(_ json: String, as type: T.Type = T.self) -> T {
        do { return try JSONDecoder().decode(T.self, from: Data(json.utf8)) }
        catch { fatalError("Preview payload no longer decodes as \(T.self): \(error)") }
    }

    private static func make<E>(_ build: () throws -> E) -> E {
        do { return try build() } catch { fatalError("Preview engine failed: \(error)") }
    }

    // MARK: Engines (from the authored contract examples)

    static func multipleChoice() -> MultipleChoiceEngine {
        make { try MultipleChoiceEngine(payload: decode(PreviewPayloads.multipleChoice), conceptIds: ["downs"]) }
    }
    static func multipleChoiceMulti() -> MultipleChoiceEngine {
        var p: MultipleChoicePayload = decode(PreviewPayloads.multipleChoice)
        p.allowMultiple = true
        p.correctOptionIds = ["a", "b"]
        return make { try MultipleChoiceEngine(payload: p, conceptIds: ["downs"]) }
    }
    static func binaryCall() -> BinaryCallEngine {
        make { try BinaryCallEngine(payload: decode(PreviewPayloads.binaryCall), conceptIds: ["kitchen"]) }
    }
    static func termMatch() -> TermMatchEngine {
        make { try TermMatchEngine(payload: decode(PreviewPayloads.termMatch), conceptIds: ["qb"]) }
    }
    static func sequenceOrder() -> SequenceOrderEngine {
        make { try SequenceOrderEngine(payload: decode(PreviewPayloads.sequenceOrder), conceptIds: ["pottery"]) }
    }
    static func visualID() -> VisualIDEngine {
        make { try VisualIDEngine(payload: decode(PreviewPayloads.visualID), conceptIds: ["porsche"]) }
    }
    static func decisionScenario() -> DecisionScenarioEngine {
        make { try DecisionScenarioEngine(payload: decode(PreviewPayloads.decisionScenario), conceptIds: ["turnaround"]) }
    }
    static func talkTrack() -> TalkTrackEngine {
        var p: TalkTrackPayload = decode(PreviewPayloads.talkTrack)
        // The example has one exchange; add the design's second so the flow shows "Keep chatting".
        let second: TalkTrackPayload.Exchange = decode(#"{"theirMessage":"If they win tonight I'm going to be unbearable tomorrow","replies":[{"id":"a","text":"Want to watch the next one together?","smoothDelta":30,"theirResponse":"...yes?? Thursday","coachNote":"That's the whole point of this app. Well played."},{"id":"b","text":"Cool","smoothDelta":-10,"theirResponse":"wow ok","coachNote":"One word. Brutal."}]}"#)
        p.exchanges.append(second)
        return make { try TalkTrackEngine(payload: p, conceptIds: ["power-play"]) }
    }
    static func timingTap(mode: TimingTapEngine.AccessibilityMode = .standard) -> TimingTapEngine {
        make { try TimingTapEngine(payload: decode(PreviewPayloads.timingTap), conceptIds: ["pit-stop"], mode: mode) }
    }
    static func sayThis() -> SayThisEngine {
        make { try SayThisEngine(payload: decode(PreviewPayloads.sayThis), conceptIds: ["secondary"]) }
    }
    static func fillTheGap() -> FillTheGapEngine {
        make { try FillTheGapEngine(payload: decode(PreviewPayloads.fillTheGap), conceptIds: ["downs"]) }
    }
    static func listeningID() -> ListeningIDEngine {
        make { try ListeningIDEngine(payload: decode(PreviewPayloads.listeningID), conceptIds: ["oboe"]) }
    }
    static func estimateSlider() -> EstimateSliderEngine {
        make { try EstimateSliderEngine(payload: decode(PreviewPayloads.estimateSlider), conceptIds: ["game-clock"]) }
    }
    static func hotspotTap() -> HotspotTapEngine {
        make { try HotspotTapEngine(payload: decode(PreviewPayloads.hotspotTap), conceptIds: ["strong-safety"], tapSlop: 0.02) }
    }

    // MARK: Screen models

    static let dailyBite = DailyBite(
        id: "preview-bite", courseId: "nascar", headline: "Photo finish at Talladega: won by 0.006 seconds.",
        whyItMatters: "Superspeedways let cars draft in tight packs, so finishes this close happen here more than anywhere else.",
        sayThisToday: "Did you see Talladega? Six thousandths of a second.",
        sourceURL: URL(string: "https://example.com/talladega")!, publisher: "Example Sports", conceptIds: ["draft"])

    static var resultsModel: ResultsModel {
        ResultsModel(
            eyebrow: "Unit complete \u{B7} Hockey", headlineLead: "You can now", headlineEmphasis: "hang.", personName: "Maya",
            xpEarned: 120, accuracyPercent: 92, commonGroundDelta: 14,
            unlockedLines: ["That power play goal changed the game.", "Was that offside? It looked close.", "Who's your favorite player to watch?"],
            leagueRank: 3, leagueGapText: "40 XP behind Jordan", leveledUp: false, streak: 12, challengeOutcome: nil)
    }
}

/// Seeds the in-memory repositories with some mastery and completed lessons.
enum PreviewSeeder {
    static func seedProgress(_ env: AppEnvironment) async {
        let now = await env.engine.now()
        var hockey = CourseMastery(courseId: "hockey")
        hockey.concepts["power-play"] = concept(0.9, attempts: 4, now: now)
        hockey.concepts["icing"] = concept(0.5, attempts: 2, now: now)
        try? await env.progressRepository.save(hockey)
        var nascar = CourseMastery(courseId: "nascar")
        nascar.concepts["pit-stop"] = concept(0.4, attempts: 1, now: now)
        try? await env.progressRepository.save(nascar)
        var progress = CourseProgress(personId: PreviewData.maya.id, courseId: "hockey")
        progress.lessonResults["rink-01"] = .init(completedAt: now, correctCount: 3, totalCount: 3, xpEarned: 70)
        try? await env.progressRepository.save(progress)
    }

    private static func concept(_ value: Double, attempts: Int, now: Date) -> ConceptMastery {
        var c = ConceptMastery()
        c.value = value
        c.peak = value
        c.attempts = attempts
        c.correctCount = attempts
        c.lastSeenAt = now
        return c
    }
}

/// Wraps a preview in the app environment with seeded data.
struct PreviewHost<Content: View>: View {
    @State private var model: AppModel
    private let content: (AppModel) -> Content

    init(people: [Person] = PreviewData.people, settings: AppSettings = AppSettings(), @ViewBuilder content: @escaping (AppModel) -> Content) {
        var s = settings
        s.activePersonId = people.first?.id
        _model = State(initialValue: AppModel(env: .preview(people: people, settings: s)))
        self.content = content
    }

    var body: some View {
        content(model)
            .environment(model)
            .preferredColorScheme(model.settings.appearance.colorScheme)
            .tint(Color.sw.accent)
            .task {
                await PreviewSeeder.seedProgress(model.env)
                await model.bootstrap()
            }
    }
}

/// Preview wrapper for exercise views: full-screen game background plus a no-op coordinator.
struct ExercisePreview<Content: View>: View {
    var isLast = false
    @ViewBuilder var content: (ExerciseCoordinator) -> Content

    var body: some View {
        content(ExerciseCoordinator(activityId: "preview", personName: "Maya", interestName: "Hockey", isLast: isLast, submit: { _ in }, next: {}))
            .swBackground(Color.sw.bgDeep)
    }
}
