import Foundation

public struct StreakState: Codable, Sendable, Equatable {
    public var current: Int = 0
    public var longest: Int = 0
    /// Local calendar day of the last XP earned.
    public var lastActiveDay: DayKey?
    public init() {}
}

public struct WeeklyXP: Codable, Sendable, Equatable {
    public var weekStart: DayKey
    public var xp: Int
}

public struct HeartsStatus: Sendable, Equatable {
    public var current: Int
    public var max: Int
    public var isUnlimited: Bool
    /// When the next heart arrives (nil at max / unlimited).
    public var nextHeartAt: Date?
    public var isEmpty: Bool { !isUnlimited && current == 0 }
}

public struct XPAward: Sendable, Equatable {
    public var amount: Int
    public var totalXP: Int
    public var previousLevel: Int
    public var level: Int
    public var streak: Int
    public var streakIncreased: Bool
    public var leveledUp: Bool { level > previousLevel }
}

/// Learner-wide progression state (XP, hearts, streak, premium). Persisted by `ProgressRepository`.
public struct LearnerState: Codable, Sendable, Equatable {
    public var schemaVersion = 1
    public var totalXP = 0
    public var hearts: Int
    /// Start of the current regeneration interval; nil when at max.
    public var heartRegenAnchor: Date?
    /// Swoon'd+ : unlimited hearts.
    public var isPremium = false
    public var streak = StreakState()
    public var weekly: WeeklyXP?

    public init(rules: ProgressRules = .default) { hearts = rules.maxHearts }

    public var level: Int { LevelCurve.level(forXP: totalXP) }

    // MARK: Hearts

    /// Credit regenerated hearts up to `now`.
    public mutating func syncHearts(now: Date, rules: ProgressRules = .default) {
        if isPremium { return }
        hearts = min(hearts, rules.maxHearts)
        guard hearts < rules.maxHearts, let anchor = heartRegenAnchor else {
            if hearts >= rules.maxHearts { heartRegenAnchor = nil }
            return
        }
        let gained = Int(now.timeIntervalSince(anchor) / rules.heartRegenInterval)
        guard gained > 0 else { return }
        hearts = min(rules.maxHearts, hearts + gained)
        heartRegenAnchor = hearts >= rules.maxHearts ? nil : anchor.addingTimeInterval(Double(gained) * rules.heartRegenInterval)
    }

    public mutating func loseHearts(_ n: Int, now: Date, rules: ProgressRules = .default) {
        guard n > 0, !isPremium else { return }
        syncHearts(now: now, rules: rules)
        let wasFull = hearts >= rules.maxHearts
        hearts = max(0, hearts - n)
        if wasFull && hearts < rules.maxHearts { heartRegenAnchor = now }
    }

    /// "Practice to earn one" (hearts sheet).
    public mutating func earnHeart(now: Date, rules: ProgressRules = .default) {
        syncHearts(now: now, rules: rules)
        hearts = min(rules.maxHearts, hearts + 1)
        if hearts >= rules.maxHearts { heartRegenAnchor = nil }
    }

    /// Read-only view (does not mutate).
    public func heartsStatus(now: Date, rules: ProgressRules = .default) -> HeartsStatus {
        if isPremium { return HeartsStatus(current: rules.maxHearts, max: rules.maxHearts, isUnlimited: true, nextHeartAt: nil) }
        var copy = self
        copy.syncHearts(now: now, rules: rules)
        let next: Date? = copy.hearts < rules.maxHearts ? copy.heartRegenAnchor?.addingTimeInterval(rules.heartRegenInterval) : nil
        return HeartsStatus(current: copy.hearts, max: rules.maxHearts, isUnlimited: false, nextHeartAt: next)
    }

    // MARK: XP and streak

    /// Streak: increments on the first XP earned each local calendar day; resets if a whole day passes with no XP.
    @discardableResult
    public mutating func addXP(_ amount: Int, now: Date, timeZone: TimeZone) -> XPAward {
        let previousLevel = level
        guard amount > 0 else {
            return XPAward(amount: 0, totalXP: totalXP, previousLevel: previousLevel, level: previousLevel,
                           streak: currentStreak(now: now, timeZone: timeZone), streakIncreased: false)
        }
        totalXP += amount
        let today = DayKey(date: now, timeZone: timeZone)
        var increased = false
        if streak.lastActiveDay != today {
            if let last = streak.lastActiveDay, today.days(since: last) == 1 { streak.current += 1 } else { streak.current = 1 }
            streak.lastActiveDay = today
            streak.longest = max(streak.longest, streak.current)
            increased = true
        }
        let week = today.weekStart
        if var w = weekly, w.weekStart == week { w.xp += amount; weekly = w } else { weekly = WeeklyXP(weekStart: week, xp: amount) }
        return XPAward(amount: amount, totalXP: totalXP, previousLevel: previousLevel, level: level,
                       streak: streak.current, streakIncreased: increased)
    }

    /// The streak as it should be displayed now (0 if a full day was missed).
    public func currentStreak(now: Date, timeZone: TimeZone) -> Int {
        guard let last = streak.lastActiveDay else { return 0 }
        let today = DayKey(date: now, timeZone: timeZone)
        return today.days(since: last) <= 1 ? streak.current : 0
    }

    /// XP earned this league week (0 if the stored week is stale).
    public func weeklyXP(now: Date, timeZone: TimeZone) -> Int {
        guard let w = weekly, w.weekStart == DayKey(date: now, timeZone: timeZone).weekStart else { return 0 }
        return w.xp
    }
}
