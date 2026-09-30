import Foundation

public struct NotificationContent: Sendable, Equatable {
    public var title: String
    public var body: String
    public init(title: String, body: String) { self.title = title; self.body = body }
}

/// The single place notification copy is composed (ARCHITECTURE section 5). In discreet mode (default ON)
/// the copy never contains a Person's name.
public enum NotificationComposer {
    public static let appName = "Swoon\u{2019}d"

    public static func dailyReminder(personName: String?, discreet: Bool) -> NotificationContent {
        let name = personName?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        if discreet || name.isEmpty { return NotificationContent(title: appName, body: "Your daily game is ready") }
        return NotificationContent(title: appName, body: "Your daily game for \(name) is ready")
    }

    public static func heartsRefilled(discreet: Bool) -> NotificationContent {
        NotificationContent(title: appName, body: "Your hearts are back. Ready to play?")
    }
}
