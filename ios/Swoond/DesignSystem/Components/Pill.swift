import SwiftUI

/// Small status pill: streak (gold) and hearts (neutral). 13/600 text, 6/11 padding.
struct Pill: View {
    enum Style { case reward, neutral, accent }

    var text: String
    var systemImage: String?
    var style: Style = .neutral

    var body: some View {
        HStack(spacing: 5) {
            if let systemImage {
                Image(systemName: systemImage).imageScale(.small).accessibilityHidden(true)
            }
            Text(text)
        }
        .font(SWFont.ui(13, weight: .semibold, relativeTo: .footnote))
        .foregroundStyle(foreground)
        .padding(.vertical, SWSpace.s6)
        .padding(.horizontal, 11)
        .background(Capsule().fill(fill))
    }

    private var foreground: Color {
        switch style {
        case .reward: return Color.sw.reward
        case .neutral: return Color.sw.ink
        case .accent: return Color.sw.accentSoft
        }
    }

    private var fill: Color {
        switch style {
        case .reward: return Color.sw.rewardTint
        case .neutral: return Color.sw.pillFill
        case .accent: return Color.sw.accentTint
        }
    }
}

/// The two Home header pills.
struct StreakPill: View {
    var days: Int
    var body: some View {
        Pill(text: "\(days) day streak", style: .reward)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("\(days) day streak")
    }
}

struct HeartsPill: View {
    var hearts: Int
    var isUnlimited = false
    var body: some View {
        Pill(text: isUnlimited ? "\u{221E}" : "\(hearts)", systemImage: "heart.fill", style: .neutral)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(isUnlimited ? "Unlimited hearts" : "\(hearts) hearts")
    }
}

#Preview("Pills") {
    HStack { StreakPill(days: 12); HeartsPill(hearts: 5); HeartsPill(hearts: 5, isUnlimited: true) }
        .padding().background(Color.sw.bg)
}
