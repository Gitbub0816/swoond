import Foundation
import Observation
import SwoondCore

/// Root UI state (`@Observable`, main actor). Owns the people list, active person, settings and the learner
/// snapshot; everything else lives in Core or in per-screen view models.
@MainActor
@Observable
final class AppModel {
    enum Phase: Equatable { case loading, onboarding, ready }

    struct HeartsInfo: Equatable {
        var current = 5
        var max = 5
        var isUnlimited = false
        var nextHeartAt: Date?
        var isEmpty: Bool { !isUnlimited && current == 0 }
    }

    struct LearnerSnapshot: Equatable {
        var streak = 0
        var hearts = HeartsInfo()
        var totalXP = 0
        var level = 1
        var weeklyXP = 0
        var isPremium = false
    }

    let env: AppEnvironment

    private(set) var phase: Phase = .loading
    private(set) var people: [Person] = []
    private(set) var courses: [CourseSummary] = []
    private(set) var learner = LearnerSnapshot()
    private(set) var settings: AppSettings

    var selectedTab: AppTab = .learn
    var fullScreen: FullScreenRoute?
    var isPresentingAddPerson = false

    private var hasBootstrapped = false

    init(env: AppEnvironment) {
        self.env = env
        self.settings = env.settingsStore.load()
        Haptics.shared.isEnabled = settings.soundsAndHaptics
    }

    // MARK: Derived

    var activePerson: Person? {
        if let id = settings.activePersonId, let p = people.first(where: { $0.id == id }) { return p }
        return people.first(where: \.isActive) ?? people.first
    }

    func hasContent(courseId: CourseID) -> Bool { courses.contains { $0.courseId == courseId } }

    func interestName(_ courseId: CourseID) -> String {
        courses.first(where: { $0.courseId == courseId })?.displayName ?? InterestCatalog.displayName(for: courseId)
    }

    // MARK: Lifecycle

    func bootstrap() async {
        guard !hasBootstrapped else { return }
        hasBootstrapped = true
        courses = (try? await env.content.courseIndex()) ?? []
        people = (try? await env.personRepository.people()) ?? []
        await refreshLearner()
        phase = people.isEmpty ? .onboarding : .ready
        await syncReminders(requestPermission: false)
    }

    func refreshLearner() async {
        guard let state = try? await env.engine.learnerState() else { return }
        let now = await env.engine.now()
        let hearts = state.heartsStatus(now: now, rules: env.engine.rules)
        learner = LearnerSnapshot(
            streak: state.currentStreak(now: now, timeZone: env.timeZone),
            hearts: HeartsInfo(current: hearts.current, max: hearts.max, isUnlimited: hearts.isUnlimited, nextHeartAt: hearts.nextHeartAt),
            totalXP: state.totalXP,
            level: state.level,
            weeklyXP: state.weeklyXP(now: now, timeZone: env.timeZone),
            isPremium: state.isPremium)
    }

    // MARK: People

    /// Finish onboarding (first run) or add another person.
    func addPerson(from draft: OnboardingDraft) async {
        let person = draft.makePerson(createdAt: await env.engine.now())
        try? await env.personRepository.save(person)
        people = (try? await env.personRepository.people()) ?? people + [person]
        setActivePerson(person.id)
        phase = .ready
        isPresentingAddPerson = false
        selectedTab = .learn
        await syncReminders(requestPermission: true)
    }

    func setActivePerson(_ id: PersonID) {
        updateSettings { $0.activePersonId = id }
    }

    func deletePerson(_ id: PersonID) async {
        try? await env.personRepository.delete(personId: id)
        people = (try? await env.personRepository.people()) ?? people.filter { $0.id != id }
        if settings.activePersonId == id { updateSettings { $0.activePersonId = people.first?.id } }
        if people.isEmpty { phase = .onboarding }
    }

    // MARK: Settings

    func updateSettings(_ change: (inout AppSettings) -> Void) {
        var next = settings
        change(&next)
        guard next != settings else { return }
        let reminderChanged = next.dailyReminder != settings.dailyReminder || next.reminderHour != settings.reminderHour || next.discreetMode != settings.discreetMode
        settings = next
        env.settingsStore.save(next)
        Haptics.shared.isEnabled = next.soundsAndHaptics
        if reminderChanged { Task { await syncReminders(requestPermission: true) } }
    }

    /// Schedule or cancel the daily reminder. Copy is composed by Core, so Discreet mode never leaks a name.
    func syncReminders(requestPermission: Bool) async {
        guard settings.dailyReminder else { await env.reminders.cancelDaily(); return }
        if requestPermission { guard await env.reminders.requestAuthorization() else { return } }
        let content = NotificationComposer.dailyReminder(personName: activePerson?.displayName, discreet: settings.discreetMode)
        await env.reminders.scheduleDaily(hour: settings.reminderHour, content: content)
    }

    // MARK: Premium

    func setPremium(_ premium: Bool) async {
        try? await env.engine.setPremium(premium)
        await refreshLearner()
    }

    // MARK: Presentation

    func play(_ launch: GameLaunch) { fullScreen = .game(launch) }
    func showPaywall(_ context: PaywallContext) { fullScreen = .paywall(context) }
    func dismissFullScreen() { fullScreen = nil }
}
