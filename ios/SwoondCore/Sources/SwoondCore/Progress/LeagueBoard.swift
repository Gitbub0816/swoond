import Foundation

/// Weekly league standings for display (design 3c). Rivals are placeholders until a social backend exists.
public struct LeagueSnapshot: Sendable, Equatable {
    public var name: String
    public var nextTierName: String
    /// Top N move up.
    public var promotionCutoff: Int
    public var daysLeft: Int
    public var entries: [LeagueEntry]

    public var learnerRank: Int? { League.learnerRank(in: entries) }

    /// XP the learner needs to pass the entry directly above them (nil when first or unranked).
    public var xpBehindNextAbove: Int? {
        guard let i = entries.firstIndex(where: \.isLearner), i > 0 else { return nil }
        return entries[i - 1].weeklyXP - entries[i].weeklyXP
    }

    public var nameAboveLearner: String? {
        guard let i = entries.firstIndex(where: \.isLearner), i > 0 else { return nil }
        return entries[i - 1].name
    }
}

public enum LeagueBoard {
    public static let defaultRivals: [(name: String, weeklyXP: Int)] = [
        ("Jordan", 620), ("Sam", 585), ("Priya", 470), ("Theo", 455), ("Mina", 310), ("Kai", 290), ("Lena", 210),
    ]

    public static func snapshot(learnerName: String, learnerWeeklyXP: Int, rivals: [(name: String, weeklyXP: Int)] = defaultRivals,
                                now: Date, timeZone: TimeZone = .current) -> LeagueSnapshot {
        var rows: [(id: String, name: String, weeklyXP: Int, isLearner: Bool)] = rivals.map { ($0.name.lowercased(), $0.name, $0.weeklyXP, false) }
        rows.append(("you", learnerName, learnerWeeklyXP, true))
        let today = DayKey(date: now, timeZone: timeZone)
        let daysLeft = max(1, 7 - today.days(since: today.weekStart))
        return LeagueSnapshot(name: "Crushing League", nextTierName: "Smitten", promotionCutoff: 5, daysLeft: daysLeft, entries: League.ranked(rows))
    }
}
