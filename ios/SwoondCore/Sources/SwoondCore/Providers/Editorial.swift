import Foundation

/// A Daily Bite: one current-context nugget in Swoon'd's own words, linking to the publisher (spec section 11).
/// Publisher article text is never copied.
public struct DailyBite: Codable, Sendable, Hashable, Identifiable {
    public var id: String
    public var courseId: CourseID
    public var headline: String
    public var whyItMatters: String
    public var sayThisToday: String
    public var sourceURL: URL
    public var publisher: String
    public var publishedAt: Date?
    public var conceptIds: [ConceptID]

    public init(id: String, courseId: CourseID, headline: String, whyItMatters: String, sayThisToday: String,
                sourceURL: URL, publisher: String, publishedAt: Date? = nil, conceptIds: [ConceptID] = []) {
        self.id = id; self.courseId = courseId; self.headline = headline; self.whyItMatters = whyItMatters
        self.sayThisToday = sayThisToday; self.sourceURL = sourceURL; self.publisher = publisher
        self.publishedAt = publishedAt; self.conceptIds = conceptIds
    }
}

public protocol EditorialProvider: Sendable {
    /// Today's bite for a course, personalized when possible (nil = nothing today).
    func dailyBite(courseId: CourseID, personalization: [String: String], on day: DayKey) async throws -> DailyBite?
    func topics(courseId: CourseID, personalization: [String: String]) async throws -> [DailyBite]
}

public struct MockEditorialProvider: EditorialProvider {
    public var bites: [DailyBite]
    public var failure: (any Error)?

    public init(bites: [DailyBite] = MockEditorialProvider.samples, failure: (any Error)? = nil) { self.bites = bites; self.failure = failure }

    public func dailyBite(courseId: CourseID, personalization: [String: String], on day: DayKey) async throws -> DailyBite? {
        if let failure { throw failure }
        let mine = bites.filter { $0.courseId == courseId }
        guard !mine.isEmpty else { return nil }
        return mine[((day.epochDay % mine.count) + mine.count) % mine.count]   // stable rotation per day
    }

    public func topics(courseId: CourseID, personalization: [String: String]) async throws -> [DailyBite] {
        if let failure { throw failure }
        return bites.filter { $0.courseId == courseId }
    }

    public static let samples: [DailyBite] = [
        DailyBite(id: "bite-af-1", courseId: "american-football", headline: "Eagles lose their starting left tackle for the season",
                  whyItMatters: "The left tackle protects a right-handed quarterback's blind side, so losing one changes how the whole offense can pass.",
                  sayThisToday: "Who steps in at left tackle? That blind side matters.", sourceURL: URL(string: "https://example.com/eagles-left-tackle")!,
                  publisher: "Example Sports", conceptIds: ["quarterback"]),
        DailyBite(id: "bite-af-2", courseId: "american-football", headline: "A coach goes for it on fourth down twice in one half",
                  whyItMatters: "Going for it on fourth down is a gamble: keep the ball and momentum, or hand the other team good field position.",
                  sayThisToday: "Two fourth-down tries, that is an aggressive coach.", sourceURL: URL(string: "https://example.com/fourth-down")!,
                  publisher: "Example Sports", conceptIds: ["downs"]),
    ]
}
