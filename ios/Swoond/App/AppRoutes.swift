import Foundation
import SwoondCore

/// The five tabs (DESIGN_SPEC section 5): Learn, Games, Talk, Live, Me.
enum AppTab: String, CaseIterable, Hashable, Identifiable {
    case learn, games, talk, live, me
    var id: String { rawValue }

    var title: String {
        switch self {
        case .learn: return "Learn"
        case .games: return "Games"
        case .talk: return "Talk"
        case .live: return "Live"
        case .me: return "Me"
        }
    }

    /// SF Symbols in the system's regular weight (the design asks for thin line icons).
    var systemImage: String {
        switch self {
        case .learn: return "book"
        case .games: return "gamecontroller"
        case .talk: return "bubble.left.and.bubble.right"
        case .live: return "dot.radiowaves.left.and.right"
        case .me: return "person.crop.circle"
        }
    }
}

/// What a game session should play.
struct GameLaunch: Identifiable, Hashable {
    enum Kind: Hashable {
        case lesson(unitId: UnitID, lessonId: LessonID)
        case review
        case talkTrack(trackId: String)
    }

    let id = UUID()
    var personId: PersonID
    var courseId: CourseID
    var kind: Kind
    /// Set when the session is the answer to a friend challenge.
    var challenge: FriendChallenge?
    /// "Practice to earn one" from the hearts sheet: finishing the session earns a heart.
    var earnsHeart = false
}

enum PaywallContext: Hashable {
    case settings, heartsEmpty, lockedInterest
}

/// Full-screen covers presented over the tab bar (modal flows, ARCHITECTURE section 10).
enum FullScreenRoute: Identifiable {
    case game(GameLaunch)
    case dailyBite(courseId: CourseID)
    case challenge(FriendChallenge)
    case paywall(PaywallContext)

    var id: String {
        switch self {
        case .game(let g): return "game-\(g.id.uuidString)"
        case .dailyBite(let c): return "bite-\(c)"
        case .challenge(let c): return "challenge-\(c.id)"
        case .paywall(let c): return "paywall-\(c)"
        }
    }
}

/// Typed `NavigationStack` routes per tab.
enum LearnRoute: Hashable {
    case playbook
}

enum MeRoute: Hashable {
    case league
    case settings
    case people
}
