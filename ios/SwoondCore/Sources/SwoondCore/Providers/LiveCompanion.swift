import Foundation

/// One play-by-play item translated into plain English (design 3a "What just happened").
public struct LiveMoment: Sendable, Hashable, Identifiable {
    public var id: String
    public var label: String
    public var clock: String
    public var headline: String
    public var explanation: String
    /// Highlighted in gold (the person's team is involved).
    public var isHighlighted: Bool
    public init(id: String, label: String, clock: String, headline: String, explanation: String, isHighlighted: Bool = false) {
        self.id = id; self.label = label; self.clock = clock; self.headline = headline; self.explanation = explanation; self.isHighlighted = isHighlighted
    }
}

/// Everything the Live tab renders.
public struct LiveSnapshot: Sendable, Equatable {
    public var courseId: CourseID
    public var competition: String
    public var periodLabel: String
    public var homeName: String
    public var awayName: String
    public var homeScore: Int
    public var awayScore: Int
    /// The name of the team the person cares about, if known.
    public var favoriteTeam: String?
    public var sayThisNow: String
    public var moments: [LiveMoment]
    public var isLive: Bool

    public var favoriteIsHome: Bool { favoriteTeam.map { $0.lowercased() == homeName.lowercased() } ?? false }
    public var favoriteIsAway: Bool { favoriteTeam.map { $0.lowercased() == awayName.lowercased() } ?? false }
}

/// Builds a `LiveSnapshot` from normalized `LiveDataProvider` fixtures. Play-by-play interpretation is a phase-1 mock
/// (authored templates); real per-course interpretation arrives with live adapters (ARCHITECTURE section 6.3).
public enum LiveCompanion {
    public static func snapshot(courseId: CourseID, personalization: [String: String], provider: any LiveDataProvider) async throws -> LiveSnapshot? {
        let results = try await provider.scores(courseId: courseId, personalization: personalization)
        let upcoming = try await provider.schedule(courseId: courseId, personalization: personalization)
        guard let f = results.first(where: { $0.status == .live }) ?? results.first ?? upcoming.first else { return nil }
        let team = personalization["team"]
        return LiveSnapshot(
            courseId: courseId, competition: f.competition, periodLabel: periodLabel(f), homeName: f.homeName, awayName: f.awayName,
            homeScore: f.homeScore ?? 0, awayScore: f.awayScore ?? 0, favoriteTeam: team,
            sayThisNow: sayThisLine(for: f, team: team), moments: momentsMock(for: f, team: team), isLive: f.status == .live)
    }

    static func periodLabel(_ f: Fixture) -> String {
        switch f.status {
        case .live: return "3rd \u{B7} 12:41"
        case .final: return "Final"
        case .scheduled: return "Upcoming"
        case .postponed: return "Postponed"
        }
    }

    static func sayThisLine(for f: Fixture, team: String?) -> String {
        let hs = f.homeScore ?? 0, aw = f.awayScore ?? 0
        if hs == aw { return "\u{201C}Tie game. Whoever scores next has all the momentum.\u{201D}" }
        let leader = hs > aw ? f.homeName : f.awayName
        let trailer = hs > aw ? f.awayName : f.homeName
        return "\u{201C}If \(leader) hold this lead, \(trailer) are done.\u{201D}"
    }

    static func momentsMock(for f: Fixture, team: String?) -> [LiveMoment] {
        [
            LiveMoment(id: "m1", label: "Penalty \u{B7} \(f.homeName)", clock: "12:58", headline: "Tripping, 2 minutes",
                       explanation: "\(f.homeName) play one skater short until 10:58. The crowd will be tense.", isHighlighted: true),
            LiveMoment(id: "m2", label: "Icing", clock: "14:20", headline: "Faceoff back in their zone",
                       explanation: "Shooting the puck the length of the ice to kill time isn't allowed."),
        ]
    }
}
