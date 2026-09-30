import SwiftUI
import UIKit

/// Tab bar styling per DESIGN_SPEC section 5: 92% opaque `bg`, top `stroke` hairline, the active tab in `ink` at
/// weight 600 and inactive tabs in `ink-5`. Applied once at launch (`SwoondApp`).
enum TabBarStyling {
    @MainActor
    static func apply() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = SWUIColor.bg.withAlphaComponent(0.92)
        appearance.shadowColor = SWUIColor.stroke

        let normal = UITabBarItemAppearance()
        let font = UIFont(name: SWFont.sansFamily, size: 11) ?? UIFont.systemFont(ofSize: 11)
        let semibold = UIFont.systemFont(ofSize: 11, weight: .semibold)
        normal.normal.iconColor = SWUIColor.ink5
        normal.normal.titleTextAttributes = [.foregroundColor: SWUIColor.ink5, .font: font]
        normal.selected.iconColor = SWUIColor.ink
        normal.selected.titleTextAttributes = [.foregroundColor: SWUIColor.ink, .font: semibold]
        appearance.stackedLayoutAppearance = normal
        appearance.inlineLayoutAppearance = normal
        appearance.compactInlineLayoutAppearance = normal

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().tintColor = SWUIColor.ink
        UITabBar.appearance().unselectedItemTintColor = SWUIColor.ink5
    }
}
