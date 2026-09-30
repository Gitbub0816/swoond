import SwiftUI

/// 3-4 pt bar: rounded `ink` fill on a `rgba(ink, .08)` track.
struct SWProgressBar: View {
    var value: Double
    var height: CGFloat = 4
    var fill: Color = Color.sw.ink

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule().fill(Color.sw.track)
                Capsule().fill(fill).frame(width: max(0, min(1, value)) * proxy.size.width)
            }
        }
        .frame(height: height)
        .animation(reduceMotion ? nil : .swPanel, value: value)
        .accessibilityElement(children: .ignore)
        .accessibilityValue("\(Int((max(0, min(1, value)) * 100).rounded())) percent")
    }
}

/// The 3-step onboarding / story progress segments.
struct SegmentedProgress: View {
    var count: Int
    var filled: Int
    var spacing: CGFloat = 6
    var onColor: Color = Color.sw.ink
    var offColor: Color = Color.sw.ink.opacity(0.15)

    var body: some View {
        HStack(spacing: spacing) {
            ForEach(0..<count, id: \.self) { i in
                Capsule().fill(i < filled ? onColor : offColor).frame(height: 3)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Step \(filled) of \(count)")
    }
}

#Preview("Progress") {
    VStack(spacing: 16) {
        SWProgressBar(value: 0.62)
        SegmentedProgress(count: 3, filled: 2)
    }
    .padding().background(Color.sw.bg)
}
