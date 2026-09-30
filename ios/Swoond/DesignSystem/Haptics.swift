import UIKit

/// Haptics helper. Respects Settings > Sounds & haptics (`isEnabled`, kept in sync by `AppModel`).
/// Correct = light success, wrong = warning (DESIGN_SPEC section 7).
@MainActor
final class Haptics {
    static let shared = Haptics()
    var isEnabled = true

    private init() {}

    func success() { guard isEnabled else { return }; UINotificationFeedbackGenerator().notificationOccurred(.success) }
    func warning() { guard isEnabled else { return }; UINotificationFeedbackGenerator().notificationOccurred(.warning) }
    func error() { guard isEnabled else { return }; UINotificationFeedbackGenerator().notificationOccurred(.error) }
    func selection() { guard isEnabled else { return }; UISelectionFeedbackGenerator().selectionChanged() }
    /// Light tap, e.g. the timing-tap marker.
    func tick() { guard isEnabled else { return }; UIImpactFeedbackGenerator(style: .light).impactOccurred() }
    func firm() { guard isEnabled else { return }; UIImpactFeedbackGenerator(style: .medium).impactOccurred() }
}
