import SwiftUI

/// The Common Ground meter: a conic ring, 104 pt outside and 88 pt inside, filled in `accent` (DESIGN_SPEC section 6).
struct CommonGroundRing: View {
    /// 0...1
    var fraction: Double
    var size: CGFloat = 104

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    private var percent: Int { Int((max(0, min(1, fraction)) * 100).rounded()) }
    private var lineWidth: CGFloat { size * 8 / 104 }

    var body: some View {
        ZStack {
            Circle().stroke(Color.sw.track, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: max(0, min(1, fraction)))
                .stroke(Color.sw.accent, style: StrokeStyle(lineWidth: lineWidth, lineCap: .butt))
                .rotationEffect(.degrees(-90))
            Text("\(percent)\(Text(verbatim: "%").font(SWFont.display(size * 18 / 104)))")
                .font(SWFont.display(size * 34 / 104, relativeTo: .title))
                .foregroundStyle(Color.sw.ink)
                .contentTransition(.numericText())
        }
        .padding(lineWidth / 2)
        .frame(width: size, height: size)
        .animation(reduceMotion ? nil : .swoond(0.6), value: fraction)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Common ground")
        .accessibilityValue("\(percent) percent")
    }
}

#Preview("Ring") {
    HStack(spacing: 24) {
        CommonGroundRing(fraction: 0.38)
        CommonGroundRing(fraction: 0.9, size: 64)
    }
    .padding().background(Color.sw.bg)
}
