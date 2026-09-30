import Foundation

public struct Badge: Sendable, Hashable, Identifiable {
    public var id: String
    public var name: String
    /// Serif monogram placeholder (design README: could become illustrated medallions later).
    public var monogram: String
    public var detail: String
    public init(id: String, name: String, monogram: String, detail: String) { self.id = id; self.name = name; self.monogram = monogram; self.detail = detail }
}

/// Numbers the badge rules look at.
public struct LearnerStats: Sendable, Equatable {
    public var streak: Int
    public var longestStreak: Int
    public var totalXP: Int
    public var level: Int
    public var gamesPlayed: Int
    public var conceptsMastered: Int
    public var conceptsMet: Int
    public var talkTracksDone: Int
    public var challengesWon: Int
    public var interests: Int

    public init(streak: Int = 0, longestStreak: Int = 0, totalXP: Int = 0, level: Int = 1, gamesPlayed: Int = 0, conceptsMastered: Int = 0,
                conceptsMet: Int = 0, talkTracksDone: Int = 0, challengesWon: Int = 0, interests: Int = 0) {
        self.streak = streak; self.longestStreak = longestStreak; self.totalXP = totalXP; self.level = level; self.gamesPlayed = gamesPlayed
        self.conceptsMastered = conceptsMastered; self.conceptsMet = conceptsMet; self.talkTracksDone = talkTracksDone
        self.challengesWon = challengesWon; self.interests = interests
    }
}

public enum BadgeCatalog {
    public static let all: [Badge] = [
        Badge(id: "first-date", name: "First Date", monogram: "F", detail: "Finish your first game."),
        Badge(id: "rink-rat", name: "Rink Rat", monogram: "R", detail: "Master 3 terms."),
        Badge(id: "pit-crew", name: "Pit Crew", monogram: "P", detail: "Play 5 games."),
        Badge(id: "streak-7", name: "7 Day Streak", monogram: "7", detail: "Play 7 days in a row."),
        Badge(id: "smooth-talker", name: "Smooth Talker", monogram: "S", detail: "Finish a Talk Track."),
        Badge(id: "hat-trick", name: "Hat Trick", monogram: "H", detail: "Master 3 terms in one interest."),
        Badge(id: "kitchen-cop", name: "Kitchen Cop", monogram: "K", detail: "Master 5 terms."),
        Badge(id: "well-rounded", name: "Well Rounded", monogram: "W", detail: "Learn for 3 different interests."),
        Badge(id: "level-5", name: "Level 5", monogram: "5", detail: "Reach level 5."),
        Badge(id: "head-to-head", name: "Head to Head", monogram: "V", detail: "Win a friend challenge."),
        Badge(id: "thousand", name: "1,000 XP", monogram: "M", detail: "Earn 1,000 XP."),
        Badge(id: "streak-30", name: "30 Day Streak", monogram: "30", detail: "Play 30 days in a row."),
    ]

    public static func unlockedIds(for s: LearnerStats) -> Set<String> {
        var ids = Set<String>()
        if s.gamesPlayed >= 1 { ids.insert("first-date") }
        if s.conceptsMastered >= 3 { ids.insert("rink-rat"); ids.insert("hat-trick") }
        if s.gamesPlayed >= 5 { ids.insert("pit-crew") }
        if s.longestStreak >= 7 || s.streak >= 7 { ids.insert("streak-7") }
        if s.talkTracksDone >= 1 { ids.insert("smooth-talker") }
        if s.conceptsMastered >= 5 { ids.insert("kitchen-cop") }
        if s.interests >= 3 { ids.insert("well-rounded") }
        if s.level >= 5 { ids.insert("level-5") }
        if s.challengesWon >= 1 { ids.insert("head-to-head") }
        if s.totalXP >= 1000 { ids.insert("thousand") }
        if s.longestStreak >= 30 || s.streak >= 30 { ids.insert("streak-30") }
        return ids
    }
}
