import SwiftUI
import UIKit

/// Type scale (DESIGN_SPEC section 4). Instrument Serif (display; regular + italic) and Geist (UI; 400/500/600),
/// both SIL OFL and bundled in `Resources/Fonts`. If a font failed to register the layer falls back to the system
/// serif / sans (never Inter/Roboto on purpose), scaled with `UIFontMetrics`.
///
/// Geist ships as one variable font (family "Geist", axis `wght`); weights are selected with `.weight(_:)`.
enum SWFont {
    static let serifRegular = "InstrumentSerif-Regular"
    static let serifItalic = "InstrumentSerif-Italic"
    static let sansFamily = "Geist"

    /// True when the bundled fonts registered (they are declared in `UIAppFonts`).
    static var serifAvailable: Bool { UIFont(name: serifRegular, size: 12) != nil }
    static var sansAvailable: Bool { UIFont(name: sansFamily, size: 12) != nil }

    /// Instrument Serif. Display XL 52, L 40-46, M 30-34, S 20-26, numerals 30-52. Scales with Dynamic Type.
    static func display(_ size: CGFloat, italic: Bool = false, relativeTo style: Font.TextStyle = .title) -> Font {
        if serifAvailable { return .custom(italic ? serifItalic : serifRegular, size: size, relativeTo: style) }
        let base = fallback(size: size, weight: .regular, design: .serif, style: style)
        return italic ? base.italic() : base
    }

    /// Geist. Body L 15-16 (500-600), Body 14 (400), Caption 12-13 (400), Eyebrow 11 (uppercase).
    static func ui(_ size: CGFloat, weight: Font.Weight = .regular, relativeTo style: Font.TextStyle = .body) -> Font {
        if sansAvailable { return .custom(sansFamily, size: size, relativeTo: style).weight(weight) }
        return fallback(size: size, weight: weight, design: .default, style: style)
    }

    private static func fallback(size: CGFloat, weight: Font.Weight, design: Font.Design, style: Font.TextStyle) -> Font {
        let scaled = UIFontMetrics(forTextStyle: style.uiStyle).scaledValue(for: size)
        return .system(size: scaled, weight: weight, design: design)
    }
}

extension Font.TextStyle {
    fileprivate var uiStyle: UIFont.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title1
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption: return .caption1
        case .caption2: return .caption2
        default: return .body
        }
    }
}

/// Named styles so screens read like the spec.
enum SWText {
    static func displayXL(italic: Bool = false) -> Font { SWFont.display(52, italic: italic, relativeTo: .largeTitle) }
    static func displayL(_ size: CGFloat = 40, italic: Bool = false) -> Font { SWFont.display(size, italic: italic, relativeTo: .largeTitle) }
    static func displayM(_ size: CGFloat = 32, italic: Bool = false) -> Font { SWFont.display(size, italic: italic, relativeTo: .title) }
    static func displayS(_ size: CGFloat = 22, italic: Bool = false) -> Font { SWFont.display(size, italic: italic, relativeTo: .title3) }
    static func numeral(_ size: CGFloat = 30) -> Font { SWFont.display(size, relativeTo: .title) }
    static var bodyL: Font { SWFont.ui(15, weight: .semibold, relativeTo: .body) }
    static var bodyLMedium: Font { SWFont.ui(15, weight: .medium, relativeTo: .body) }
    static var body: Font { SWFont.ui(14, relativeTo: .callout) }
    static var caption: Font { SWFont.ui(13, relativeTo: .footnote) }
    static var captionSmall: Font { SWFont.ui(12, relativeTo: .footnote) }
    static var eyebrow: Font { SWFont.ui(11, weight: .medium, relativeTo: .caption) }
    static var button: Font { SWFont.ui(16, weight: .semibold, relativeTo: .body) }
}

extension View {
    /// Display serif with an optional CSS-style line height (Instrument Serif's natural line box is about 1.2).
    func swDisplay(_ size: CGFloat, italic: Bool = false, lineHeight: CGFloat = 1.05, relativeTo style: Font.TextStyle = .title) -> some View {
        font(SWFont.display(size, italic: italic, relativeTo: style)).lineSpacing((lineHeight - 1.2) * size)
    }

    /// Geist UI text.
    func swUI(_ size: CGFloat, weight: Font.Weight = .regular, relativeTo style: Font.TextStyle = .body) -> some View {
        font(SWFont.ui(size, weight: weight, relativeTo: style))
    }
}

extension Text {
    /// Serif line where one or two words are set in italic accent, e.g. `What's *Maya* into?` (the person's name is
    /// always italic in headlines). Built with string interpolation, not `+`, which is deprecated on recent SDKs.
    static func emphasized(_ before: String, _ emphasis: String, _ after: String = "", size: CGFloat,
                           color: Color = Color.sw.accent) -> Text {
        let em = Text(verbatim: emphasis).font(SWFont.display(size, italic: true)).foregroundStyle(color)
        return Text("\(before)\(em)\(after)")
    }
}
