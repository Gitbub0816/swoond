import Foundation
import SwoondCore

/// Dependency container. Everything the app needs, behind Core protocols, wired in one place.
///
/// Phase 1 (ARCHITECTURE section 4): bundled JSON content, on-device JSON persistence in Application Support,
/// mock live/editorial providers, StoreKit 2 behind `PurchaseService`, Unity behind `SimulationHost`.
struct AppEnvironment: Sendable {
    var content: any ContentRepository
    var progressRepository: any ProgressRepository
    var personRepository: any PersonRepository
    var engine: ProgressEngine
    var live: any LiveDataProvider
    var editorial: any EditorialProvider
    var challenges: any ChallengeProvider
    var purchases: any PurchaseService
    var settingsStore: any SettingsStore
    var reminders: any ReminderScheduling
    var clock: any SwoondClock
    var timeZone: TimeZone
    var locale: String
    var simulationHosts: SimulationHostFactory

    /// A `LearningSession` for one person + interest (an actor; owns the current lesson queue).
    func makeSession(person: Person, interest: PersonInterest, timingMode: TimingTapEngine.AccessibilityMode = .standard) -> LearningSession {
        LearningSession(person: person, interest: interest, content: content, engine: engine, editorial: editorial,
                        locale: locale, timingMode: timingMode)
    }

    // MARK: Live

    static func live() -> AppEnvironment {
        let directory = applicationSupportDirectory()
        let clock = SystemClock()
        let progress = FileProgressRepository(directory: directory)
        let timeZone = TimeZone.current
        return AppEnvironment(
            content: ContentBootstrap.repository(),
            progressRepository: progress,
            personRepository: FilePersonRepository(directory: directory),
            engine: ProgressEngine(repository: progress, clock: clock, timeZone: timeZone),
            live: MockLiveDataProvider(),
            editorial: MockEditorialProvider(),
            challenges: MockChallengeProvider(),
            purchases: StoreKitPurchaseService(),
            settingsStore: UserDefaultsSettingsStore(),
            reminders: UserNotificationReminderScheduler(),
            clock: clock,
            timeZone: timeZone,
            locale: Locale.current.identifier.replacingOccurrences(of: "_", with: "-"),
            simulationHosts: .default)
    }

    private static func applicationSupportDirectory() -> URL {
        let fm = FileManager.default
        let base = (try? fm.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)) ?? fm.temporaryDirectory
        return base.appendingPathComponent("Swoond", isDirectory: true)
    }

    // MARK: Preview / test

    /// In-memory everything, bundled content, mock services. Used by `#Preview` and unit tests.
    static func preview(people: [Person] = PreviewData.people, state: LearnerState = PreviewData.learnerState(),
                        settings: AppSettings = AppSettings(), content: (any ContentRepository)? = nil,
                        clock: any SwoondClock = SystemClock()) -> AppEnvironment {
        let progress = InMemoryProgressRepository(initialState: state)
        let timeZone = TimeZone.current
        return AppEnvironment(
            content: content ?? ContentBootstrap.repository(),
            progressRepository: progress,
            personRepository: InMemoryPersonRepository(people),
            engine: ProgressEngine(repository: progress, clock: clock, timeZone: timeZone),
            live: MockLiveDataProvider(),
            editorial: MockEditorialProvider(),
            challenges: MockChallengeProvider(),
            purchases: MockPurchaseService(),
            settingsStore: InMemorySettingsStore(settings),
            reminders: MockReminderScheduler(),
            clock: clock,
            timeZone: timeZone,
            locale: "en-US",
            simulationHosts: SimulationHostFactory(isUnityBacked: false, make: { MockSimulationHost() }))
    }
}

/// Chooses the simulation host: the real Unity-as-a-Library host when `UnityFramework` is linked, otherwise the mock
/// (and the "Simulation coming soon" placeholder, `isUnityBacked == false`).
struct SimulationHostFactory: Sendable {
    var isUnityBacked: Bool
    var make: @Sendable () -> any SimulationHost

    static var `default`: SimulationHostFactory {
        #if canImport(UnityFramework)
        return SimulationHostFactory(isUnityBacked: true, make: { UnitySimulationHost.shared })
        #else
        return SimulationHostFactory(isUnityBacked: false, make: { MockSimulationHost() })
        #endif
    }
}
