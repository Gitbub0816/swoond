import SwiftUI

/// Segmented control: 14 outer radius, 10 inner, `surface-2` selected segment (Settings > Appearance).
struct SWSegmentedControl<Value: Hashable>: View {
    var options: [(value: Value, title: String)]
    @Binding var selection: Value

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        HStack(spacing: 4) {
            ForEach(options.indices, id: \.self) { i in
                let option = options[i]
                let isOn = option.value == selection
                Button {
                    Haptics.shared.selection()
                    selection = option.value
                } label: {
                    Text(option.title)
                        .font(SWFont.ui(14, weight: .medium))
                        .foregroundStyle(isOn ? Color.sw.ink : Color.sw.ink4)
                        .frame(maxWidth: .infinity, minHeight: 38)
                        .background(RoundedRectangle(cornerRadius: SWRadius.segmentInner, style: .continuous).fill(isOn ? Color.sw.surface2 : .clear))
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityAddTraits(isOn ? .isSelected : [])
            }
        }
        .padding(4)
        .swCard(radius: SWRadius.segmentOuter, border: .clear)
        .animation(reduceMotion ? nil : .swTap, value: selection)
    }
}

#Preview("Segmented") {
    @Previewable @State var pick = "Dark"
    return SWSegmentedControl(options: [(value: "Dark", title: "Dark"), (value: "Light", title: "Light"), (value: "System", title: "System")],
                              selection: $pick)
        .padding().background(Color.sw.bg)
}
