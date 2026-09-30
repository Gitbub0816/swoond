import SwiftUI

/// Profile badge: serif monogram in a 52 pt ring. Locked badges render at 40% with a grey ring.
struct BadgeTile: View {
    var name: String
    var monogram: String
    var isUnlocked: Bool

    var body: some View {
        VStack(spacing: SWSpace.s8) {
            Text(verbatim: monogram)
                .font(SWFont.display(22, italic: true, relativeTo: .title3))
                .foregroundStyle(ring)
                .frame(width: 52, height: 52)
                .overlay(Circle().strokeBorder(ring, lineWidth: 1.5))
            Text(name)
                .font(SWFont.ui(12, relativeTo: .caption))
                .foregroundStyle(Color.sw.ink)
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .padding(.top, SWSpace.s16)
        .padding(.bottom, SWSpace.s12)
        .padding(.horizontal, SWSpace.s8)
        .frame(maxWidth: .infinity)
        .swCard(radius: SWRadius.card, border: .clear)
        .opacity(isUnlocked ? 1 : 0.4)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(name), \(isUnlocked ? "unlocked" : "locked")")
    }

    private var ring: Color { isUnlocked ? Color.sw.reward : Color.sw.ink5 }
}

#Preview("Badges") {
    HStack {
        BadgeTile(name: "First Date", monogram: "F", isUnlocked: true)
        BadgeTile(name: "Hat Trick", monogram: "H", isUnlocked: false)
    }
    .padding().background(Color.sw.bg)
}
