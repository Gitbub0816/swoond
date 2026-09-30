import SwiftUI
import SwoondCore

@main
struct SwoondApp: App {
    @State private var model: AppModel

    init() {
        TabBarStyling.apply()
        // Unit tests run hosted in the app; keep them off the real on-device store.
        let isTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
        _model = State(initialValue: AppModel(env: isTesting ? .preview() : .live()))
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(model)
                .preferredColorScheme(model.settings.appearance.colorScheme)
                .tint(Color.sw.accent)
        }
    }
}

extension AppSettings.Appearance {
    /// `nil` follows the system.
    var colorScheme: ColorScheme? {
        switch self {
        case .dark: return .dark
        case .light: return .light
        case .system: return nil
        }
    }
}
