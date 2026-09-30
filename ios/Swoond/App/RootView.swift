import SwiftUI
import SwoondCore

/// Onboarding -> tabs. Modal flows are full-screen covers over the whole app.
struct RootView: View {
    @Environment(AppModel.self) private var model
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        @Bindable var model = model
        ZStack {
            Color.sw.bg.ignoresSafeArea()
            switch model.phase {
            case .loading:
                Wordmark(size: 46)
                    .transition(.opacity)
            case .onboarding:
                OnboardingView(mode: .firstRun)
                    .transition(.opacity)
            case .ready:
                MainTabView()
                    .transition(.opacity)
            }
        }
        .animation(reduceMotion ? nil : .swPanel, value: model.phase)
        .task { await model.bootstrap() }
        .fullScreenCover(item: $model.fullScreen) { route in
            FullScreenRouteView(route: route)
                .environment(model)
        }
        .sheet(isPresented: $model.isPresentingAddPerson) {
            OnboardingView(mode: .addPerson)
                .environment(model)
        }
    }
}

/// Resolves a `FullScreenRoute` to its screen.
struct FullScreenRouteView: View {
    var route: FullScreenRoute
    @Environment(AppModel.self) private var model

    var body: some View {
        switch route {
        case .game(let launch):
            GameShellView(launch: launch)
        case .dailyBite(let courseId):
            DailyBiteView(courseId: courseId)
        case .challenge(let challenge):
            ChallengeView(challenge: challenge)
        case .paywall(let context):
            PaywallView(context: context)
        }
    }
}

struct MainTabView: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        @Bindable var model = model
        TabView(selection: $model.selectedTab) {
            Tab(AppTab.learn.title, systemImage: AppTab.learn.systemImage, value: AppTab.learn) { LearnTab() }
            Tab(AppTab.games.title, systemImage: AppTab.games.systemImage, value: AppTab.games) { GamesTab() }
            Tab(AppTab.talk.title, systemImage: AppTab.talk.systemImage, value: AppTab.talk) { TalkTab() }
            Tab(AppTab.live.title, systemImage: AppTab.live.systemImage, value: AppTab.live) { LiveTab() }
            Tab(AppTab.me.title, systemImage: AppTab.me.systemImage, value: AppTab.me) { MeTab() }
        }
        .tint(Color.sw.ink)
    }
}

/// Learn = Home + Playbook.
struct LearnTab: View {
    @State private var path: [LearnRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: LearnRoute.self) { route in
                    switch route {
                    case .playbook: PlaybookView()
                    }
                }
        }
    }
}

struct GamesTab: View {
    var body: some View { NavigationStack { GamesHubView() } }
}

struct TalkTab: View {
    var body: some View { NavigationStack { TalkView() } }
}

struct LiveTab: View {
    var body: some View { NavigationStack { LiveView() } }
}

/// Me = Profile, League, Settings.
struct MeTab: View {
    @State private var path: [MeRoute] = []

    var body: some View {
        NavigationStack(path: $path) {
            ProfileView(path: $path)
                .navigationDestination(for: MeRoute.self) { route in
                    switch route {
                    case .league: LeagueView()
                    case .settings: SettingsView(path: $path)
                    case .people: PeopleListView()
                    }
                }
        }
    }
}

#Preview("Root (ready)") {
    PreviewHost { _ in RootView() }
}
