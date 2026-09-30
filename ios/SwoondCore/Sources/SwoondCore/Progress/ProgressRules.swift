import Foundation

/// XP values from DESIGN_SPEC section 8 / ARCHITECTURE section 7.
public enum XPValues {
    public static let correctAnswer = 10
    public static let halfCredit = 5
    public static let finishedGame = 40
    public static let dailyBite = 10
    public static let challengeWin = 80
}

/// Tunable numbers for progression, defaulting to the documented values.
public struct ProgressRules: Sendable, Equatable {
    public var maxHearts = 5
    /// +1 heart per 4 hours while below max (assumption, ARCHITECTURE section 12).
    public var heartRegenInterval: TimeInterval = 4 * 3600
    public var correctMasteryGain = 0.20
    public var wrongMasteryLoss = 0.15
    public var hintGainMultiplier = 0.5
    /// Native caps any single sim session's per-concept gain.
    public var simulationSessionConceptGainCap = 0.40
    public var decayPerDay = 0.01
    /// Decay never takes mastery below this fraction of the concept's peak.
    public var decayFloorFactor = 0.5
    /// Used when a `unity-sim` activity carries no `xp` override.
    public var defaultLessonXPBudget = 40

    public init() {}
    public static let `default` = ProgressRules()
}

/// Level curve. Not specified in the design; assumption: level n starts at 50*n*(n-1) XP
/// (L2 = 100, L3 = 300, L4 = 600 ...). Recorded in ARCHITECTURE open questions.
public enum LevelCurve {
    public static func xpRequired(forLevel level: Int) -> Int { 50 * max(1, level) * (max(1, level) - 1) }

    public static func level(forXP xp: Int) -> Int {
        var n = 1
        while xpRequired(forLevel: n + 1) <= xp { n += 1 }
        return n
    }

    /// 0...1 progress within the current level.
    public static func progress(forXP xp: Int) -> Double {
        let l = level(forXP: xp)
        let lo = xpRequired(forLevel: l), hi = xpRequired(forLevel: l + 1)
        return Double(xp - lo) / Double(hi - lo)
    }
}
