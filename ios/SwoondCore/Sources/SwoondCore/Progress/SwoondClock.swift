import Foundation

/// All time in Core flows through this protocol so tests are deterministic.
public protocol SwoondClock: Sendable {
    func now() -> Date
}

public struct SystemClock: SwoondClock {
    public init() {}
    public func now() -> Date { Date() }
}

/// A clock frozen at a date.
public struct FixedClock: SwoondClock {
    public var date: Date
    public init(_ date: Date) { self.date = date }
    public func now() -> Date { date }
}

/// A mutable, thread-safe clock for tests and previews.
public final class ManualClock: SwoondClock, @unchecked Sendable {
    private let lock = NSLock()
    private var current: Date
    public init(_ start: Date) { current = start }
    public func now() -> Date { lock.lock(); defer { lock.unlock() }; return current }
    public func set(_ date: Date) { lock.lock(); current = date; lock.unlock() }
    public func advance(by interval: TimeInterval) { lock.lock(); current = current.addingTimeInterval(interval); lock.unlock() }
    public func advance(days: Int) { advance(by: Double(days) * 86_400) }
}
