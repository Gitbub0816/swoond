import Foundation

/// Swoon'd-owned normalized live-data models (spec section 32). Provider DTOs never appear here.

public struct Fixture: Codable, Sendable, Hashable, Identifiable {
    public enum Status: String, Codable, Sendable { case scheduled, live, final, postponed }
    public var id: String
    public var competition: String
    public var homeName: String
    public var awayName: String
    public var startsAt: Date
    public var status: Status
    public var homeScore: Int?
    public var awayScore: Int?
    public var venue: String?

    public init(id: String, competition: String, homeName: String, awayName: String, startsAt: Date, status: Status,
                homeScore: Int? = nil, awayScore: Int? = nil, venue: String? = nil) {
        self.id = id; self.competition = competition; self.homeName = homeName; self.awayName = awayName
        self.startsAt = startsAt; self.status = status; self.homeScore = homeScore; self.awayScore = awayScore; self.venue = venue
    }

    public func involves(_ name: String) -> Bool {
        let n = name.lowercased()
        return homeName.lowercased() == n || awayName.lowercased() == n
    }
}

public struct StandingRow: Codable, Sendable, Hashable {
    public var rank: Int
    public var name: String
    public var played: Int
    public var wins: Int
    public var losses: Int
    public var draws: Int?
    public var points: Double?
    public init(rank: Int, name: String, played: Int, wins: Int, losses: Int, draws: Int? = nil, points: Double? = nil) {
        self.rank = rank; self.name = name; self.played = played; self.wins = wins; self.losses = losses; self.draws = draws; self.points = points
    }
}

public struct Standings: Codable, Sendable, Hashable {
    public var competition: String
    public var group: String?
    public var rows: [StandingRow]
    public init(competition: String, group: String? = nil, rows: [StandingRow]) { self.competition = competition; self.group = group; self.rows = rows }
}

/// Everything a course's live layer needs in one normalized bundle.
public struct LiveContext: Codable, Sendable, Hashable {
    public var courseId: CourseID
    public var generatedAt: Date
    public var recentResults: [Fixture]
    public var upcoming: [Fixture]
    public var standings: [Standings]
    /// Required attribution string for the data provider, if any.
    public var attribution: String?
    public init(courseId: CourseID, generatedAt: Date, recentResults: [Fixture] = [], upcoming: [Fixture] = [], standings: [Standings] = [], attribution: String? = nil) {
        self.courseId = courseId; self.generatedAt = generatedAt; self.recentResults = recentResults
        self.upcoming = upcoming; self.standings = standings; self.attribution = attribution
    }
}

public protocol LiveDataProvider: Sendable {
    /// Finished and in-progress games.
    func scores(courseId: CourseID, personalization: [String: String]) async throws -> [Fixture]
    /// Upcoming fixtures.
    func schedule(courseId: CourseID, personalization: [String: String]) async throws -> [Fixture]
    func standings(courseId: CourseID, personalization: [String: String]) async throws -> [Standings]
}

extension LiveDataProvider {
    public func liveContext(courseId: CourseID, personalization: [String: String], now: Date) async throws -> LiveContext {
        async let s = scores(courseId: courseId, personalization: personalization)
        async let u = schedule(courseId: courseId, personalization: personalization)
        async let t = standings(courseId: courseId, personalization: personalization)
        return try await LiveContext(courseId: courseId, generatedAt: now, recentResults: s, upcoming: u, standings: t)
    }
}

/// Fixture-backed provider (phase 1: "Fixture JSON"). If personalization contains `team`, results are filtered to that team.
public struct MockLiveDataProvider: LiveDataProvider {
    public var results: [Fixture]
    public var upcoming: [Fixture]
    public var tables: [Standings]
    public var failure: (any Error)?

    public init(results: [Fixture] = MockLiveDataProvider.sampleResults, upcoming: [Fixture] = MockLiveDataProvider.sampleUpcoming,
                tables: [Standings] = MockLiveDataProvider.sampleStandings, failure: (any Error)? = nil) {
        self.results = results; self.upcoming = upcoming; self.tables = tables; self.failure = failure
    }

    public func scores(courseId: CourseID, personalization: [String: String]) async throws -> [Fixture] {
        if let failure { throw failure }
        return filter(results, personalization)
    }
    public func schedule(courseId: CourseID, personalization: [String: String]) async throws -> [Fixture] {
        if let failure { throw failure }
        return filter(upcoming, personalization).sorted { $0.startsAt < $1.startsAt }
    }
    public func standings(courseId: CourseID, personalization: [String: String]) async throws -> [Standings] {
        if let failure { throw failure }
        return tables
    }

    private func filter(_ f: [Fixture], _ p: [String: String]) -> [Fixture] {
        guard let team = p["team"] else { return f }
        let mine = f.filter { $0.involves(team) }
        return mine.isEmpty ? f : mine
    }

    public static let sampleResults: [Fixture] = [
        Fixture(id: "r1", competition: "NFL", homeName: "Philadelphia Eagles", awayName: "Dallas Cowboys", startsAt: Date(timeIntervalSince1970: 1_790_000_000), status: .final, homeScore: 27, awayScore: 20),
        Fixture(id: "r2", competition: "NFL", homeName: "Kansas City Chiefs", awayName: "Denver Broncos", startsAt: Date(timeIntervalSince1970: 1_790_003_600), status: .final, homeScore: 31, awayScore: 17),
    ]
    public static let sampleUpcoming: [Fixture] = [
        Fixture(id: "u1", competition: "NFL", homeName: "New York Giants", awayName: "Philadelphia Eagles", startsAt: Date(timeIntervalSince1970: 1_790_600_000), status: .scheduled),
        Fixture(id: "u2", competition: "NFL", homeName: "Green Bay Packers", awayName: "Chicago Bears", startsAt: Date(timeIntervalSince1970: 1_790_610_000), status: .scheduled),
    ]
    public static let sampleStandings: [Standings] = [
        Standings(competition: "NFL", group: "NFC East", rows: [
            StandingRow(rank: 1, name: "Philadelphia Eagles", played: 10, wins: 8, losses: 2),
            StandingRow(rank: 2, name: "Dallas Cowboys", played: 10, wins: 6, losses: 4),
            StandingRow(rank: 3, name: "New York Giants", played: 10, wins: 3, losses: 7),
        ]),
    ]
}
