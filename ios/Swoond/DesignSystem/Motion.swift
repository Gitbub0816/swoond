import SwiftUI

/// Motion tokens (DESIGN_SPEC section 7): easing `cubic-bezier(.2,.8,.2,1)`; 150 ms taps, 250 ms panels, 400 ms pieces.
extension Animation {
    static func swoond(_ duration: Double = 0.25) -> Animation { .timingCurve(0.2, 0.8, 0.2, 1, duration: duration) }
    static var swTap: Animation { .swoond(0.15) }
    static var swPanel: Animation { .swoond(0.25) }
    static var swPiece: Animation { .swoond(0.4) }
}

extension View {
    /// Animates `value` changes with the Swoon'd curve, or not at all under Reduce Motion (state changes then
    /// appear as cross-fades where the view uses `.transition(.opacity)`).
    func swAnimation<V: Equatable>(_ animation: Animation = .swPanel, value: V, reduceMotion: Bool) -> some View {
        self.animation(reduceMotion ? nil : animation, value: value)
    }
}

/// A 6 pt horizontal shake for wrong answers. Drive it by incrementing `shakes`.
struct ShakeEffect: GeometryEffect {
    var travel: CGFloat = 6
    var shakes: CGFloat
    var animatableData: CGFloat {
        get { shakes }
        set { shakes = newValue }
    }
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX: travel * sin(shakes * .pi * 2), y: 0))
    }
}
