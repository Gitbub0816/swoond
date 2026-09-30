import Foundation

/// Cheeky-coach copy for the Common Ground ring (DESIGN_SPEC section 2). Never about the person, never manipulative.
public enum CommonGroundCopy {
    public static func line(forPercent percent: Int) -> String {
        switch percent {
        case ..<10: return "Everyone starts somewhere."
        case 10..<25: return "You can nod along, knowingly."
        case 25..<50: return "Enough to survive a first date."
        case 50..<75: return "You can hold your own."
        default: return "You can genuinely hang."
        }
    }

    /// Results headline pair: the plain part and the italic-accent word ("You can now" + "hang").
    public static func resultsHeadline(accuracy: Double) -> (lead: String, emphasis: String) {
        switch accuracy {
        case 0.9...: return ("You can now", "hang.")
        case 0.6..<0.9: return ("You're getting", "there.")
        default: return ("Good", "start.")
        }
    }
}
