import SwiftUI

/// Card surface: `surface` fill, `stroke` border, light-mode-only shadow (DESIGN_SPEC section 3).
struct CardBackground: ViewModifier {
    var radius: CGFloat = SWRadius.card
    var fill: Color = Color.sw.surface
    var border: Color = Color.sw.stroke

    @Environment(\.colorScheme) private var scheme

    func body(content: Content) -> some View {
        content
            .background(RoundedRectangle(cornerRadius: radius, style: .continuous).fill(fill))
            .overlay(RoundedRectangle(cornerRadius: radius, style: .continuous).strokeBorder(border, lineWidth: 1))
            .shadow(color: scheme == .light ? Color.black.opacity(0.06) : .clear, radius: 1, x: 0, y: 1)
    }
}

extension View {
    func swCard(radius: CGFloat = SWRadius.card, fill: Color = Color.sw.surface, border: Color = Color.sw.stroke) -> some View {
        modifier(CardBackground(radius: radius, fill: fill, border: border))
    }

    /// Featured `hero-grad` card with the rose border.
    func swHeroCard(radius: CGFloat = SWRadius.hero) -> some View {
        background(RoundedRectangle(cornerRadius: radius, style: .continuous).fill(Color.sw.heroGradient))
            .overlay(RoundedRectangle(cornerRadius: radius, style: .continuous).strokeBorder(Color.sw.heroBorder, lineWidth: 1))
    }

    /// Screen background token.
    func swBackground(_ color: Color = Color.sw.bg) -> some View {
        background(color.ignoresSafeArea())
    }
}

/// Padded card container.
struct Card<Content: View>: View {
    var radius: CGFloat = SWRadius.card
    var padding = EdgeInsets(top: 16, leading: 18, bottom: 16, trailing: 18)
    @ViewBuilder var content: () -> Content

    var body: some View {
        content()
            .padding(padding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .swCard(radius: radius)
    }
}

#Preview("Card") {
    Card {
        VStack(alignment: .leading, spacing: 4) {
            Text("Power play").font(SWText.displayS(26))
            Text("One team has more skaters because the other took a penalty.").font(SWText.body).foregroundStyle(Color.sw.ink2)
        }
    }
    .padding()
    .background(Color.sw.bg)
}
