import Foundation

/// A calendar day in some time zone, independent of DST. Streaks and weekly leagues are computed on these.
public struct DayKey: Codable, Sendable, Hashable, Comparable {
    public var year: Int
    public var month: Int
    public var day: Int

    public init(year: Int, month: Int, day: Int) { self.year = year; self.month = month; self.day = day }

    public init(date: Date, timeZone: TimeZone) {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = timeZone
        let c = cal.dateComponents([.year, .month, .day], from: date)
        self.init(year: c.year ?? 1970, month: c.month ?? 1, day: c.day ?? 1)
    }

    /// Days since 1970-01-01 (proleptic Gregorian; Howard Hinnant's algorithm).
    public var epochDay: Int {
        let y = month <= 2 ? year - 1 : year
        let era = (y >= 0 ? y : y - 399) / 400
        let yoe = y - era * 400
        let mp = (month + 9) % 12
        let doy = (153 * mp + 2) / 5 + day - 1
        let doe = yoe * 365 + yoe / 4 - yoe / 100 + doy
        return era * 146_097 + doe - 719_468
    }

    public init(epochDay z0: Int) {
        let z = z0 + 719_468
        let era = (z >= 0 ? z : z - 146_096) / 146_097
        let doe = z - era * 146_097
        let yoe = (doe - doe / 1460 + doe / 36_524 - doe / 146_096) / 365
        let y = yoe + era * 400
        let doy = doe - (365 * yoe + yoe / 4 - yoe / 100)
        let mp = (5 * doy + 2) / 153
        let d = doy - (153 * mp + 2) / 5 + 1
        let m = mp < 10 ? mp + 3 : mp - 9
        self.init(year: m <= 2 ? y + 1 : y, month: m, day: d)
    }

    public func adding(days: Int) -> DayKey { DayKey(epochDay: epochDay + days) }
    public func days(since other: DayKey) -> Int { epochDay - other.epochDay }

    /// Monday of this day's week (ISO week start).
    public var weekStart: DayKey {
        let e = epochDay
        let mondayIndex = ((e + 3) % 7 + 7) % 7   // 1970-01-01 was a Thursday
        return DayKey(epochDay: e - mondayIndex)
    }

    public static func < (a: DayKey, b: DayKey) -> Bool { a.epochDay < b.epochDay }

    public var isoString: String { String(format: "%04d-%02d-%02d", year, month, day) }
}
