import Foundation

/// User-facing preferences (design 3h). Persisted as JSON in `UserDefaults` by the app.
public struct AppSettings: Codable, Sendable, Equatable {
    public enum Appearance: String, Codable, Sendable, CaseIterable, Hashable {
        case dark, light, system
        public var title: String {
            switch self { case .dark: return "Dark"; case .light: return "Light"; case .system: return "System" }
        }
    }

    public var appearance: Appearance
    /// Discreet mode (default ON): notifications never contain a Person's name.
    public var discreetMode: Bool
    public var dailyReminder: Bool
    /// Local hour, 0...23 (default 20 = 8 PM).
    public var reminderHour: Int
    public var soundsAndHaptics: Bool
    public var activePersonId: PersonID?
    /// What the learner calls themselves on Profile (optional).
    public var learnerName: String?
    /// First launch, for "Joined March".
    public var joinedAt: Date?

    public init(appearance: Appearance = .dark, discreetMode: Bool = true, dailyReminder: Bool = true, reminderHour: Int = 20,
                soundsAndHaptics: Bool = true, activePersonId: PersonID? = nil,
                learnerName: String? = nil, joinedAt: Date? = nil) {
        self.appearance = appearance
        self.discreetMode = discreetMode
        self.dailyReminder = dailyReminder
        self.reminderHour = min(23, max(0, reminderHour))
        self.soundsAndHaptics = soundsAndHaptics
        self.activePersonId = activePersonId
        self.learnerName = learnerName
        self.joinedAt = joinedAt
    }

    /// "8:00 PM".
    public var reminderTimeLabel: String {
        let h = reminderHour % 12 == 0 ? 12 : reminderHour % 12
        return "\(h):00 \(reminderHour < 12 ? "AM" : "PM")"
    }
}

public protocol SettingsStore: Sendable {
    func load() -> AppSettings
    func save(_ settings: AppSettings)
}

/// `UserDefaults`-backed store (JSON under one key). `UserDefaults` is thread-safe.
public struct UserDefaultsSettingsStore: SettingsStore {
    // UserDefaults is thread-safe; it is Sendable on Apple platforms but not in swift-corelibs-foundation (Linux).
    nonisolated(unsafe) private let defaults: UserDefaults
    private let key: String
    public init(defaults: UserDefaults = .standard, key: String = "swoond.settings.v1") { self.defaults = defaults; self.key = key }

    public func load() -> AppSettings {
        guard let data = defaults.data(forKey: key), let s = try? JSONDecoder().decode(AppSettings.self, from: data) else { return AppSettings() }
        return s
    }
    public func save(_ settings: AppSettings) {
        if let data = try? JSONEncoder().encode(settings) { defaults.set(data, forKey: key) }
    }
}

/// In-memory store for tests and previews.
public final class InMemorySettingsStore: SettingsStore, @unchecked Sendable {   // guarded by `lock`
    private let lock = NSLock()
    private var value: AppSettings
    public init(_ initial: AppSettings = AppSettings()) { value = initial }
    public func load() -> AppSettings { lock.lock(); defer { lock.unlock() }; return value }
    public func save(_ settings: AppSettings) { lock.lock(); value = settings; lock.unlock() }
}

/// Seam for local notifications (the app implements it with `UNUserNotificationCenter`).
public protocol ReminderScheduling: Sendable {
    /// Ask for permission; returns whether notifications are allowed.
    func requestAuthorization() async -> Bool
    /// Replace any scheduled daily reminder with one at `hour` (local time).
    func scheduleDaily(hour: Int, content: NotificationContent) async
    func cancelDaily() async
}

public actor MockReminderScheduler: ReminderScheduling {
    public private(set) var scheduled: (hour: Int, content: NotificationContent)?
    public init() {}
    public func requestAuthorization() async -> Bool { true }
    public func scheduleDaily(hour: Int, content: NotificationContent) async { scheduled = (hour, content) }
    public func cancelDaily() async { scheduled = nil }
}
