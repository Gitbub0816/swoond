import SwiftUI
import UIKit

// Color tokens from docs/design/DESIGN_SPEC.md section 3. Asset-free: each token is a dynamic `UIColor`
// that resolves to the dark or light value from the current trait collection, so `preferredColorScheme`
// (Settings > Appearance) and `.environment(\.colorScheme, .dark)` (Daily Bite always renders dark) both work.

extension UIColor {
    /// 0xRRGGBB plus alpha.
    convenience init(rgb: UInt32, alpha: Double = 1) {
        self.init(red: CGFloat((rgb >> 16) & 0xFF) / 255, green: CGFloat((rgb >> 8) & 0xFF) / 255,
                  blue: CGFloat(rgb & 0xFF) / 255, alpha: CGFloat(alpha))
    }

    /// Dark/light dynamic color. Dark is the default appearance, so anything that is not `.light` resolves dark.
    static func swDynamic(dark: UInt32, darkAlpha: Double = 1, light: UInt32, lightAlpha: Double = 1) -> UIColor {
        UIColor { traits in
            traits.userInterfaceStyle == .light ? UIColor(rgb: light, alpha: lightAlpha) : UIColor(rgb: dark, alpha: darkAlpha)
        }
    }
}

/// UIKit-side tokens (tab bar appearance, etc.). `Color.sw` wraps these.
enum SWUIColor {
    static var bg: UIColor { .swDynamic(dark: 0x111014, light: 0xF7F3EC) }
    static var bgDeep: UIColor { .swDynamic(dark: 0x0D0C10, light: 0xEFE9DF) }
    static var surface: UIColor { .swDynamic(dark: 0x1A191F, light: 0xFFFFFF) }
    static var surface2: UIColor { .swDynamic(dark: 0x26242B, light: 0xEDE7DD) }
    static var stroke: UIColor { .swDynamic(dark: 0xFFFFFF, darkAlpha: 0.07, light: 0x141016, lightAlpha: 0.08) }
    static var strokeStrong: UIColor { .swDynamic(dark: 0xFFFFFF, darkAlpha: 0.14, light: 0x141016, lightAlpha: 0.16) }
    static var ink: UIColor { .swDynamic(dark: 0xF3EEE6, light: 0x17151A) }
    static var ink2: UIColor { .swDynamic(dark: 0xC9BFC4, light: 0x4A434C) }
    static var ink3: UIColor { .swDynamic(dark: 0xA9A3AD, light: 0x6B646E) }
    static var ink4: UIColor { .swDynamic(dark: 0x8D8791, light: 0x857E88) }
    static var ink5: UIColor { .swDynamic(dark: 0x6F6A74, light: 0xA39DA6) }
    static var accent: UIColor { .swDynamic(dark: 0xFF6F86, light: 0xD93F5E) }
    static var accentSoft: UIColor { .swDynamic(dark: 0xFF9AAB, light: 0xB8324F) }
    static var accentTint: UIColor { .swDynamic(dark: 0xFF6F86, darkAlpha: 0.14, light: 0xD93F5E, lightAlpha: 0.10) }
    static var onAccent: UIColor { .swDynamic(dark: 0x1A0E12, light: 0xFFFFFF) }
    static var reward: UIColor { .swDynamic(dark: 0xE8C07A, light: 0xA87A1E) }
    static var rewardTint: UIColor { .swDynamic(dark: 0xE8C07A, darkAlpha: 0.14, light: 0xA87A1E, lightAlpha: 0.10) }
    static var court: UIColor { .swDynamic(dark: 0x1D2A27, light: 0xD9E6DF) }
}

/// SwiftUI color tokens. Usage: `Color.sw.surface`. Computed (not stored) so nothing needs to be `Sendable`.
struct SwoondColors {
    var bg: Color { Color(uiColor: SWUIColor.bg) }
    var bgDeep: Color { Color(uiColor: SWUIColor.bgDeep) }
    var surface: Color { Color(uiColor: SWUIColor.surface) }
    var surface2: Color { Color(uiColor: SWUIColor.surface2) }
    var stroke: Color { Color(uiColor: SWUIColor.stroke) }
    var strokeStrong: Color { Color(uiColor: SWUIColor.strokeStrong) }
    var ink: Color { Color(uiColor: SWUIColor.ink) }
    var ink2: Color { Color(uiColor: SWUIColor.ink2) }
    var ink3: Color { Color(uiColor: SWUIColor.ink3) }
    var ink4: Color { Color(uiColor: SWUIColor.ink4) }
    var ink5: Color { Color(uiColor: SWUIColor.ink5) }
    var accent: Color { Color(uiColor: SWUIColor.accent) }
    var accentSoft: Color { Color(uiColor: SWUIColor.accentSoft) }
    var accentTint: Color { Color(uiColor: SWUIColor.accentTint) }
    var onAccent: Color { Color(uiColor: SWUIColor.onAccent) }
    var reward: Color { Color(uiColor: SWUIColor.reward) }
    var rewardTint: Color { Color(uiColor: SWUIColor.rewardTint) }
    var court: Color { Color(uiColor: SWUIColor.court) }

    // Derived tokens used by specific components in the prototype.

    /// Progress track: `rgba(ink, .08)`.
    var track: Color { Color(uiColor: .swDynamic(dark: 0xFFFFFF, darkAlpha: 0.08, light: 0x141016, lightAlpha: 0.08)) }
    /// Neutral pill fill (hearts): `rgba(255,255,255,.07)`.
    var pillFill: Color { Color(uiColor: .swDynamic(dark: 0xFFFFFF, darkAlpha: 0.07, light: 0x141016, lightAlpha: 0.06)) }
    /// Selected chip text ("light rose text" in dark; the darker accent in light).
    var chipText: Color { Color(uiColor: .swDynamic(dark: 0xFFD3DA, light: 0xB8324F)) }
    /// Unselected chip text.
    var chipTextOff: Color { Color(uiColor: .swDynamic(dark: 0xD8D2D6, light: 0x4A434C)) }
    /// Their chat bubble (`#1F1E24` in dark).
    var bubbleTheirs: Color { Color(uiColor: .swDynamic(dark: 0x1F1E24, light: 0xEDE7DD)) }
    /// Toggle track when off.
    var toggleOff: Color { Color(uiColor: .swDynamic(dark: 0x34323A, light: 0xD5CEC4)) }
    /// Toggle knob.
    var toggleKnob: Color { Color(uiColor: .swDynamic(dark: 0xF3EEE6, light: 0xFFFFFF)) }
    /// Text on a gold (reward) fill.
    var onReward: Color { Color(uiColor: .swDynamic(dark: 0x1A140A, light: 0xFFFFFF)) }
    /// Rose border on hero cards (`accent` at .22).
    var heroBorder: Color { Color(uiColor: .swDynamic(dark: 0xFF6F86, darkAlpha: 0.22, light: 0xD93F5E, lightAlpha: 0.22)) }

    /// `hero-grad`: `#2A1820 -> #1A1419` at 160 degrees (dark), `#FBE4E8 -> #FFFFFF` (light).
    var heroGradient: LinearGradient {
        LinearGradient(colors: [Color(uiColor: .swDynamic(dark: 0x2A1820, light: 0xFBE4E8)),
                                Color(uiColor: .swDynamic(dark: 0x1A1419, light: 0xFFFFFF))],
                       startPoint: UnitPoint(x: 0.33, y: 0), endPoint: UnitPoint(x: 0.67, y: 1))
    }

    /// The faint rose radial glow behind Results and Challenge (accent at 15% or less).
    var accentGlow: RadialGradient {
        RadialGradient(colors: [Color(uiColor: .swDynamic(dark: 0xFF6F86, darkAlpha: 0.15, light: 0xD93F5E, lightAlpha: 0.10)), .clear],
                       center: .top, startRadius: 0, endRadius: 420)
    }

    /// The gold radial glow behind the paywall (reward at 15% or less).
    var rewardGlow: RadialGradient {
        RadialGradient(colors: [Color(uiColor: .swDynamic(dark: 0xE8C07A, darkAlpha: 0.15, light: 0xA87A1E, lightAlpha: 0.10)), .clear],
                       center: .top, startRadius: 0, endRadius: 380)
    }

    /// Scrim used over photos in both modes.
    var photoScrim: LinearGradient {
        LinearGradient(stops: [.init(color: Color(red: 17 / 255, green: 16 / 255, blue: 20 / 255, opacity: 0.6), location: 0),
                               .init(color: Color(red: 17 / 255, green: 16 / 255, blue: 20 / 255, opacity: 0), location: 0.2),
                               .init(color: Color(red: 17 / 255, green: 16 / 255, blue: 20 / 255, opacity: 0.3), location: 0.45),
                               .init(color: Color(red: 17 / 255, green: 16 / 255, blue: 20), location: 0.7)],
                       startPoint: .top, endPoint: .bottom)
    }
}

extension Color {
    /// Swoon'd design tokens: `Color.sw.bg`, `Color.sw.accent`, ...
    static var sw: SwoondColors { SwoondColors() }
}
