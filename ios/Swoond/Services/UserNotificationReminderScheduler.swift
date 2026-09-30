import Foundation
import SwoondCore
import UserNotifications

/// Daily reminder via local notifications. Copy comes from Core's `NotificationComposer` (discreet by default).
struct UserNotificationReminderScheduler: ReminderScheduling {
    private static let identifier = "app.swoond.daily-reminder"

    func requestAuthorization() async -> Bool {
        (try? await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])) ?? false
    }

    func scheduleDaily(hour: Int, content: NotificationContent) async {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [Self.identifier])
        let body = UNMutableNotificationContent()
        body.title = content.title
        body.body = content.body
        body.sound = .default
        var when = DateComponents()
        when.hour = hour
        when.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: when, repeats: true)
        try? await center.add(UNNotificationRequest(identifier: Self.identifier, content: body, trigger: trigger))
    }

    func cancelDaily() async {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [Self.identifier])
    }
}
