import SwiftUI

/// Spacing scale (DESIGN_SPEC section 5): 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28, 32.
enum SWSpace {
    static let s4: CGFloat = 4
    static let s6: CGFloat = 6
    static let s8: CGFloat = 8
    static let s10: CGFloat = 10
    static let s12: CGFloat = 12
    static let s14: CGFloat = 14
    static let s16: CGFloat = 16
    static let s18: CGFloat = 18
    static let s20: CGFloat = 20
    static let s22: CGFloat = 22
    static let s24: CGFloat = 24
    static let s28: CGFloat = 28
    static let s32: CGFloat = 32

    /// Gutter for cards.
    static let cardGutter: CGFloat = 16
    /// Gutter for text blocks (22-24).
    static let textGutter: CGFloat = 22
}

/// Radii (DESIGN_SPEC section 5).
enum SWRadius {
    static let pill: CGFloat = 999
    static let input: CGFloat = 14
    static let row: CGFloat = 18
    static let card: CGFloat = 20
    static let cardLarge: CGFloat = 22
    static let hero: CGFloat = 26
    static let segmentOuter: CGFloat = 14
    static let segmentInner: CGFloat = 10
}

/// Sizes (DESIGN_SPEC sections 5 and 6).
enum SWSize {
    static let minTarget: CGFloat = 44
    static let primaryButton: CGFloat = 56
    static let gameButton: CGFloat = 58
    static let secondaryButton: CGFloat = 50
    static let chip: CGFloat = 40
    static let tabBar: CGFloat = 82
    /// Extra room to keep scrolling content clear of the tab bar.
    static let tabBarClearance: CGFloat = 24
    /// Distance of a pinned CTA above the bottom safe area (28-34).
    static let ctaBottom: CGFloat = 28
    static let bubbleMaxWidth: CGFloat = 260
}
