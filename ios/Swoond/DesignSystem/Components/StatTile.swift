import SwiftUI

/// Big serif number over an 11 pt label (Profile stats, Results stats).
struct StatTile: View {
    enum Style { case surface, translucent, reward }

    var value: String
    var label: String
    var style: Style = .surface
    var centered = false

    var body: some View {
        VStack(alignment: centered ? .center : .leading, spacing: 2) {
            Text(value)
                .font(SWText.numeral(30))
                .foregroundStyle(style == .reward ? Color.sw.reward : Color.sw.ink)
                .minimumScaleFactor(0.6)
                .lineLimit(1)
            Text(label)
                .font(SWFont.ui(11, relativeTo: .caption))
                .foregroundStyle(style == .reward ? Color.sw.reward : Color.sw.ink4)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, style == .surface ? 12 : 10)
        .frame(maxWidth: .infinity, alignment: centered ? .center : .leading)
        .background(RoundedRectangle(cornerRadius: SWRadius.row, style: .continuous).fill(fill))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(value) \(label)")
    }

    private var fill: Color {
        switch style {
        case .surface: return Color.sw.surface
        case .translucent: return Color.sw.ink.opacity(0.05)
        case .reward: return Color.sw.rewardTint
        }
    }
}

#Preview("Stat tiles") {
    HStack(spacing: 8) {
        StatTile(value: "12", label: "day streak", style: .reward)
        StatTile(value: "3,480", label: "total XP")
        StatTile(value: "46", label: "games played")
    }
    .padding().background(Color.sw.bg)
}
