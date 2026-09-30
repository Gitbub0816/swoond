import Foundation
import Observation
import SwoondCore
import UIKit

/// What the Results screen shows (design 2f).
struct ResultsModel: Equatable {
    struct ChallengeOutcome: Equatable {
        var opponent: String
        var status: ChallengeStatus
        var prizeXP: Int
    }

    var eyebrow: String
    var headlineLead: String
    var headlineEmphasis: String
    var personName: String
    var xpEarned: Int
    var accuracyPercent: Int
    /// Common ground change in points (e.g. +14).
    var commonGroundDelta: Int
    var unlockedLines: [String]
    var leagueRank: Int?
    var leagueGapText: String?
    var leveledUp: Bool
    var streak: Int
    var challengeOutcome: ChallengeOutcome?
}

/// Drives one play session: builds a `LearningSession`, mirrors each answer into it, tracks hearts/XP, launches
/// simulations through the `SimulationHost` seam and produces the results model. All rules live in SwoondCore.
@MainActor
@Observable
final class GameSessionViewModel {
    enum Phase {
        case loading
        case playing
        case heartsEmpty
        case results(ResultsModel)
        case failed(String)
    }

    struct SimulationState {
        var request: LaunchRequest?
        var objective: String?
        var isRunning = false
        var finishedSummary: String?
        var errorMessage: String?
    }

    let launch: GameLaunch
    private(set) var phase: Phase = .loading
    private(set) var presentation: ActivityPresentation?
    private(set) var hearts = AppModel.HeartsInfo()
    private(set) var runningXP = 0
    private(set) var simulation = SimulationState()
    private(set) var practiceMessage: String?
    var showHeartsSheet = false

    let interestName: String
    var personName: String { person?.displayName ?? "" }
    var isLastActivity: Bool { presentation.map { $0.position >= $0.total } ?? true }

    private let model: AppModel
    private let person: Person?
    private let interest: PersonInterest?
    private let session: LearningSession?
    private let startedAt: Date
    private var scores: [Int] = []
    private var lines: [String] = []
    private var pending: Task<Void, Never>?
    private var heartsEmptyAfterAnswer = false
    private var commonGroundBefore = 0.0
    private var lessonObjective: String?

    init(launch: GameLaunch, model: AppModel) {
        self.launch = launch
        self.model = model
        let person = model.people.first { $0.id == launch.personId }
        let interest = person?.interest(for: launch.courseId) ?? PersonInterest(courseId: launch.courseId)
        self.person = person
        self.interest = interest
        self.interestName = model.interestName(launch.courseId)
        self.startedAt = Date()
        // Reduce Motion (or Switch Control) plays timing-tap in the slow, wider-zone mode (CATALOG section 8).
        let reduceMotion = UIAccessibility.isReduceMotionEnabled || UIAccessibility.isSwitchControlRunning
        if let person {
            self.session = model.env.makeSession(person: person, interest: interest, timingMode: reduceMotion ? .tapToStopSlow : .standard)
        } else {
            self.session = nil
        }
    }

    // MARK: Start

    func start() async {
        guard let session, let person else { phase = .failed("We couldn\u{2019}t find that person. Head back and try again."); return }
        await refreshHearts()
        if hearts.isEmpty && !launch.earnsHeart { phase = .heartsEmpty; showHeartsSheet = true; return }
        commonGroundBefore = await CommonGround.scoreTolerant(for: person, content: model.env.content, engine: model.env.engine, locale: model.env.locale)
        do {
            let first: ActivityPresentation
            switch launch.kind {
            case .lesson(let unitId, let lessonId):
                first = try await session.startLesson(unitId: unitId, lessonId: lessonId)
                lessonObjective = try await session.curriculum().lesson(unitId: unitId, lessonId: lessonId)?.objective
            case .review:
                first = try await session.startReview()
            case .talkTrack(let trackId):
                first = try await session.startTalkTrack(trackId: trackId)
            }
            presentation = first
            phase = .playing
        } catch {
            phase = .failed(Self.friendly(error))
        }
    }

    // MARK: Native answers

    /// Called by exercise views with every answer they applied to their own engine copy. The same answer is applied to
    /// the `LearningSession`'s copy (deterministic engines), which persists XP, hearts and mastery.
    func record(_ answer: ExerciseAnswer) {
        guard let session else { return }
        let previous = pending
        pending = Task { [weak self] in
            await previous?.value
            do {
                let result = try await session.submit(answer)
                guard let self else { return }
                if case .finished(let evaluation) = result.step {
                    self.noteFinished(evaluation, update: result.update)
                }
            } catch {
                // An answer the session rejects (already finished, wrong shape) is a programming error, not a user error.
                assertionFailure("Session rejected answer: \(error)")
            }
        }
    }

    private func noteFinished(_ evaluation: ExerciseEvaluation, update: ProgressUpdate?) {
        scores.append(evaluation.score)
        if let line = evaluation.sayThisLine?.trimmingQuotes, !line.isEmpty, !lines.contains(line) { lines.append(line) }
        if let update {
            runningXP += update.xpGained
            hearts = AppModel.HeartsInfo(current: update.hearts.current, max: update.hearts.max, isUnlimited: update.hearts.isUnlimited,
                                         nextHeartAt: update.hearts.nextHeartAt)
            if update.hearts.isEmpty { heartsEmptyAfterAnswer = true }
        }
        Task { await model.refreshLearner() }
    }

    /// Continue: advance to the next activity, or finish. Waits for the last answer to be applied first.
    func next() async {
        await pending?.value
        simulation = SimulationState()
        if heartsEmptyAfterAnswer && !isLastActivity {
            heartsEmptyAfterAnswer = false
            showHeartsSheet = true
            return
        }
        do {
            guard let session else { return }
            if let p = try await session.advance() {
                presentation = p
            } else {
                await finish()
            }
        } catch {
            phase = .failed(Self.friendly(error))
        }
    }

    // MARK: Simulations (Unity seam)

    /// Builds the launch request so the placeholder can show the objective and configuration.
    func prepareSimulation(environment: LaunchEnvironment) async {
        guard let session, simulation.request == nil else { return }
        do {
            let request = try await session.launchRequest(environment: environment)
            simulation.request = request
            simulation.objective = lessonObjective
        } catch {
            simulation.errorMessage = Self.friendly(error)
        }
    }

    /// Launch the sim on the host and apply its (clamped) result. With `MockSimulationHost` this returns a plausible
    /// result immediately, which is how DEBUG builds exercise the whole pipeline without Unity.
    func runSimulation(environment: LaunchEnvironment, host: any SimulationHost) async {
        guard let session else { return }
        simulation.isRunning = true
        simulation.errorMessage = nil
        defer { simulation.isRunning = false }
        do {
            let request: LaunchRequest
            if let existing = simulation.request { request = existing } else { request = try await session.launchRequest(environment: environment) }
            simulation.request = request
            let result = try await host.launch(request)
            let applied = try await session.applySimulation(result: result, request: request)
            scores.append(applied.mapped.outcome.score)
            runningXP += applied.update.xpGained
            hearts = AppModel.HeartsInfo(current: applied.update.hearts.current, max: applied.update.hearts.max,
                                         isUnlimited: applied.update.hearts.isUnlimited, nextHeartAt: applied.update.hearts.nextHeartAt)
            simulation.finishedSummary = result.aborted ? "Simulation ended early. No hearts lost." : "+\(applied.update.xpGained) XP"
            await model.refreshLearner()
        } catch {
            simulation.errorMessage = Self.friendly(error)
        }
    }

    /// Skip a simulation without penalty (Unity missing or failed).
    func skipSimulation() async {
        guard let session else { return }
        try? await session.skipCurrent()
        await next()
    }

    // MARK: Hearts sheet

    func waitForHeart() { showHeartsSheet = false; model.dismissFullScreen() }

    func practiceToEarnHeart() {
        var practice = GameLaunch(personId: launch.personId, courseId: launch.courseId, kind: .review)
        practice.earnsHeart = true
        showHeartsSheet = false
        model.play(practice)
    }

    func goUnlimited() {
        showHeartsSheet = false
        model.showPaywall(.heartsEmpty)
    }

    // MARK: Finish

    private func finish() async {
        guard let session, let person else { return }
        do {
            let summary = try await session.finish()
            if launch.earnsHeart { try? await model.env.engine.earnHeart() }
            let after = await CommonGround.scoreTolerant(for: person, content: model.env.content, engine: model.env.engine, locale: model.env.locale)
            let accuracy = scores.isEmpty ? 0 : Double(scores.reduce(0, +)) / Double(scores.count) / 100
            let headline = CommonGroundCopy.resultsHeadline(accuracy: accuracy)

            let weekly = (try? await model.env.engine.weeklyXP()) ?? 0
            let league = LeagueBoard.snapshot(learnerName: "You", learnerWeeklyXP: weekly, now: await model.env.engine.now(), timeZone: model.env.timeZone)

            var outcome: ResultsModel.ChallengeOutcome?
            var challengeXP = 0
            if let challenge = launch.challenge {
                let seconds = max(1, Int(Date().timeIntervalSince(startedAt)))
                let status = challenge.resolve(yourCorrect: summary.correctCount, yourSeconds: seconds)
                if status == .won {
                    _ = try? await model.env.engine.awardXP(challenge.prizeXP)
                    challengeXP = challenge.prizeXP
                }
                outcome = .init(opponent: challenge.fromName, status: status, prizeXP: challenge.prizeXP)
            }

            let results = ResultsModel(
                eyebrow: await eyebrow(summary: summary),
                headlineLead: headline.lead, headlineEmphasis: headline.emphasis, personName: person.displayName,
                xpEarned: summary.xpEarned + challengeXP, accuracyPercent: Int((accuracy * 100).rounded()),
                commonGroundDelta: Int(((after - commonGroundBefore) * 100).rounded()),
                unlockedLines: Array(lines.prefix(3)),
                leagueRank: league.learnerRank,
                leagueGapText: league.xpBehindNextAbove.flatMap { gap in league.nameAboveLearner.map { "\(gap) XP behind \($0)" } },
                leveledUp: summary.leveledUp, streak: summary.streak, challengeOutcome: outcome)
            await model.refreshLearner()
            phase = .results(results)
        } catch {
            phase = .failed(Self.friendly(error))
        }
    }

    private func eyebrow(summary: SessionSummary) async -> String {
        switch launch.kind {
        case .lesson(let unitId, _):
            if let session, let curriculum = try? await session.curriculum(), let unit = curriculum.unit(unitId),
               let progress = try? await model.env.engine.courseProgress(personId: launch.personId, courseId: launch.courseId),
               progress.isUnitComplete(unit) {
                return "Unit complete \u{B7} \(interestName)"
            }
            return "Lesson complete \u{B7} \(interestName)"
        case .review: return "Review complete \u{B7} \(interestName)"
        case .talkTrack: return "Talk Track complete \u{B7} \(interestName)"
        }
    }

    // MARK: Helpers

    /// A LaunchEnvironment for the current appearance and accessibility settings.
    static func launchEnvironment(scheme: LaunchRequest.Theme.ColorScheme, settings: AppSettings) -> LaunchEnvironment {
        let theme: LaunchRequest.Theme = scheme == .light ? .light : .dark
        let accessibility = AccessibilityPreferences(reducedMotion: UIAccessibility.isReduceMotionEnabled,
                                                     hapticsEnabled: settings.soundsAndHaptics, soundEnabled: settings.soundsAndHaptics,
                                                     colorBlindMode: .none, textScale: 1)
        var insets: LaunchRequest.Runtime.SafeAreaInsets?
        if let window = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).first {
            let i = window.safeAreaInsets
            insets = .init(top: Double(i.top), bottom: Double(i.bottom), left: Double(i.left), right: Double(i.right))
        }
        return LaunchEnvironment(theme: theme, accessibility: accessibility, locale: "en-US", safeAreaInsets: insets)
    }

    static func friendly(_ error: any Error) -> String {
        switch error {
        case let e as SessionError:
            switch e {
            case .lessonLocked: return "That one isn\u{2019}t unlocked yet. Finish the earlier lessons first."
            case .lessonNotFound: return "We couldn\u{2019}t find that lesson."
            case .nothingToReview: return "Nothing is due for review right now. Nice."
            default: return "Something went sideways with that session. Give it another go."
            }
        case let e as ContentError:
            switch e {
            case .courseNotFound, .curriculumNotFound: return "This course isn\u{2019}t on your phone yet. More games are on the way."
            default: return "One of the questions in this lesson is broken. We\u{2019}ve skipped it."
            }
        case let e as BridgeError:
            switch e {
            case .unity(_, _, let recoverable): return recoverable ? "The simulation hiccuped. Try again." : "This simulation can\u{2019}t run right now. You can skip it without losing anything."
            case .contractUnsupported: return "This simulation needs a newer version of the app."
            default: return "The simulation didn\u{2019}t finish. No hearts lost."
            }
        default:
            return "Something went sideways. Give it another go."
        }
    }
}
