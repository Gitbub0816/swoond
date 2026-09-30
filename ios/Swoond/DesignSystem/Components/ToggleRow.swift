import SwiftUI

/// 46 x 28 track, `accent` when on, 22 pt knob (DESIGN_SPEC section 6). Real `Toggle` semantics for VoiceOver.
struct SWToggleStyle: ToggleStyle {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    func makeBody(configuration: Configuration) -> some View {
        Button {
            Haptics.shared.selection()
            configuration.isOn.toggle()
        } label: {
            HStack(spacing: SWSpace.s12) {
                configuration.label
                Spacer(minLength: SWSpace.s8)
                ZStack(alignment: configuration.isOn ? .trailing : .leading) {
                    Capsule().fill(configuration.isOn ? Color.sw.accent : Color.sw.toggleOff)
                    Circle().fill(Color.sw.toggleKnob).frame(width: 22, height: 22).padding(3)
                }
                .frame(width: 46, height: 28)
                .animation(reduceMotion ? nil : .swTap, value: configuration.isOn)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .combine)
        .accessibilityAddTraits(.isToggle)
        .accessibilityValue(configuration.isOn ? "On" : "Off")
    }
}

/// A settings row: title + subtitle and a toggle.
struct ToggleRow: View {
    var title: String
    var subtitle: String?
    @Binding var isOn: Bool

    var body: some View {
        Toggle(isOn: $isOn) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title).font(SWFont.ui(15)).foregroundStyle(Color.sw.ink)
                if let subtitle {
                    Text(subtitle).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .toggleStyle(SWToggleStyle())
        .padding(.horizontal, SWSpace.s16)
        .padding(.vertical, SWSpace.s14)
        .frame(minHeight: SWSize.minTarget)
    }
}

#Preview("Toggle rows") {
    @Previewable @State var a = true
    @Previewable @State var b = false
    return VStack(spacing: 0) {
        ToggleRow(title: "Discreet mode", subtitle: "Hides their name in notifications and previews", isOn: $a)
        Divider().overlay(Color.sw.stroke)
        ToggleRow(title: "Sounds and haptics", subtitle: "Feedback when you answer", isOn: $b)
    }
    .swCard()
    .padding().background(Color.sw.bg)
}
