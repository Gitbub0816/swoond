import SwiftUI

/// Round avatar with a serif initial. `.person` uses the rose-to-gold gradient from the design (Talk Track header,
/// Settings); `.plain` is `surface-2`; `.ring` adds a rose ring (challenger).
struct Avatar: View {
    enum Style { case plain, person, ring }

    var initial: String
    var size: CGFloat = 40
    var style: Style = .plain

    var body: some View {
        ZStack {
            switch style {
            case .person:
                Circle().fill(LinearGradient(colors: [Color(uiColor: SWUIColor.accent), Color(uiColor: SWUIColor.reward)],
                                             startPoint: .topLeading, endPoint: .bottomTrailing))
            case .plain, .ring:
                Circle().fill(Color.sw.surface2)
            }
            if style == .ring { Circle().strokeBorder(Color.sw.accent, lineWidth: 1.5) }
            Text(verbatim: String(initial.prefix(1)).uppercased())
                .font(SWFont.display(size * 0.45, relativeTo: .title2))
                .foregroundStyle(style == .person ? Color.sw.onAccent : Color.sw.ink)
        }
        .frame(width: size, height: size)
        .accessibilityHidden(true)
    }
}

#Preview("Avatars") {
    HStack(spacing: 16) {
        Avatar(initial: "A", size: 72)
        Avatar(initial: "M", size: 40, style: .person)
        Avatar(initial: "J", size: 76, style: .ring)
    }
    .padding().background(Color.sw.bg)
}
