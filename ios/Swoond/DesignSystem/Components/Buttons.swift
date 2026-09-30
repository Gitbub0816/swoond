import SwiftUI

/// Button styles (DESIGN_SPEC section 6). One filled accent button per screen.
///  - `PrimaryButtonStyle`: `ink` fill, `bg` text, 56 pt pill.
///  - `GameButtonStyle`: `accent` fill, `on-accent` text, 58 pt pill.
///  - `GoldButtonStyle`: `reward` fill, 58 pt pill (premium).
///  - `SecondaryButtonStyle`: transparent, 1 pt `stroke-strong`, 50 pt pill.
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        SWFilledButtonBody(configuration: configuration, fill: Color.sw.ink, text: Color.sw.bg, height: SWSize.primaryButton, border: nil)
    }
}

struct GameButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        SWFilledButtonBody(configuration: configuration, fill: Color.sw.accent, text: Color.sw.onAccent, height: SWSize.gameButton, border: nil)
    }
}

struct GoldButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        SWFilledButtonBody(configuration: configuration, fill: Color.sw.reward, text: Color.sw.onReward, height: SWSize.gameButton, border: nil)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        SWFilledButtonBody(configuration: configuration, fill: .clear, text: Color.sw.ink, height: SWSize.secondaryButton,
                           border: Color.sw.strokeStrong, font: SWFont.ui(15, weight: .medium))
    }
}

private struct SWFilledButtonBody: View {
    let configuration: ButtonStyle.Configuration
    let fill: Color
    let text: Color
    let height: CGFloat
    let border: Color?
    var font: Font = SWFont.ui(16, weight: .semibold)

    @Environment(\.isEnabled) private var isEnabled
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        configuration.label
            .font(font)
            .foregroundStyle(text)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity, minHeight: height)
            .padding(.horizontal, SWSpace.s16)
            .background(Capsule().fill(fill))
            .overlay { if let border { Capsule().strokeBorder(border, lineWidth: 1) } }
            .opacity(isEnabled ? (configuration.isPressed ? 0.85 : 1) : 0.4)
            .scaleEffect(configuration.isPressed && !reduceMotion ? 0.98 : 1)
            .animation(reduceMotion ? nil : .swTap, value: configuration.isPressed)
            .contentShape(Capsule())
    }
}

extension ButtonStyle where Self == PrimaryButtonStyle {
    static var swPrimary: PrimaryButtonStyle { PrimaryButtonStyle() }
}
extension ButtonStyle where Self == GameButtonStyle {
    static var swGame: GameButtonStyle { GameButtonStyle() }
}
extension ButtonStyle where Self == GoldButtonStyle {
    static var swGold: GoldButtonStyle { GoldButtonStyle() }
}
extension ButtonStyle where Self == SecondaryButtonStyle {
    static var swSecondary: SecondaryButtonStyle { SecondaryButtonStyle() }
}

/// Convenience wrappers so call sites read `PrimaryButton("Continue") { ... }`.
struct PrimaryButton: View {
    var title: String
    var action: () -> Void
    init(_ title: String, action: @escaping () -> Void) { self.title = title; self.action = action }
    var body: some View { Button(action: action) { Text(title) }.buttonStyle(.swPrimary) }
}

struct GameButton: View {
    var title: String
    var action: () -> Void
    init(_ title: String, action: @escaping () -> Void) { self.title = title; self.action = action }
    var body: some View { Button(action: action) { Text(title) }.buttonStyle(.swGame) }
}

struct GoldButton: View {
    var title: String
    var action: () -> Void
    init(_ title: String, action: @escaping () -> Void) { self.title = title; self.action = action }
    var body: some View { Button(action: action) { Text(title) }.buttonStyle(.swGold) }
}

struct SecondaryButton: View {
    var title: String
    var action: () -> Void
    init(_ title: String, action: @escaping () -> Void) { self.title = title; self.action = action }
    var body: some View { Button(action: action) { Text(title) }.buttonStyle(.swSecondary) }
}

/// The small accent "Play" pill on the hero card (not a full-width button).
struct PlayPill: View {
    var title = "Play"
    var body: some View {
        Text(title)
            .font(SWFont.ui(14, weight: .semibold))
            .foregroundStyle(Color.sw.onAccent)
            .padding(.vertical, 10)
            .padding(.horizontal, SWSpace.s18)
            .background(Capsule().fill(Color.sw.accent))
    }
}

#Preview("Buttons") {
    VStack(spacing: 12) {
        PrimaryButton("Build my plan") {}
        GameButton("Start stop") {}
        GoldButton("Start 7-day free trial") {}
        SecondaryButton("Not now") {}
        PrimaryButton("Disabled") {}.disabled(true)
        PlayPill()
    }
    .padding()
    .background(Color.sw.bg)
}
