import SwiftUI

/// Toggle chip: 40 pt tall, 16 pt horizontal padding. Off: `stroke-strong` border. On: `accent` border,
/// `accent-tint` fill, light rose text.
struct Chip: View {
    var title: String
    var isOn: Bool
    var action: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        Button {
            Haptics.shared.selection()
            action()
        } label: {
            Text(title)
                .font(SWFont.ui(13, weight: .medium, relativeTo: .footnote))
                .foregroundStyle(isOn ? Color.sw.chipText : Color.sw.chipTextOff)
                .lineLimit(1)
                .padding(.horizontal, SWSpace.s16)
                .frame(minHeight: SWSize.chip)
                .background(Capsule().fill(isOn ? Color.sw.accentTint : .clear))
                .overlay(Capsule().strokeBorder(isOn ? Color.sw.accent : Color.sw.strokeStrong, lineWidth: 1))
                .contentShape(Capsule())
        }
        .buttonStyle(.plain)
        .animation(reduceMotion ? nil : .swTap, value: isOn)
        .accessibilityAddTraits(isOn ? .isSelected : [])
    }
}

#Preview("Chips") {
    FlowLayout {
        Chip(title: "Hockey", isOn: true) {}
        Chip(title: "NASCAR", isOn: true) {}
        Chip(title: "Pickleball", isOn: false) {}
        Chip(title: "Video games", isOn: false) {}
    }
    .padding().background(Color.sw.bg)
}
