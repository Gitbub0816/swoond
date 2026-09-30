import Foundation

/// Relationship between the learner and a Person (product spec section 2). Raw values match
/// the unity-bridge `learnerContext.relationship` enum.
public enum Relationship: String, Codable, Sendable, CaseIterable, Hashable {
    case crush
    case datingPartner = "dating-partner"
    case spouse
    case friend
    case familyMember = "family-member"
    case parent
    case child
    case coworker
    case other
}

/// One interest a Person has: Person -> Interest -> Branch -> Personalization.
public struct PersonInterest: Codable, Sendable, Hashable {
    public var courseId: CourseID
    public var branchId: BranchID?
    /// Course-defined dimensions, e.g. `["team": "Philadelphia Eagles"]`.
    public var personalization: [String: String]
    /// A "main interest" counts double in Common Ground (ARCHITECTURE section 5).
    public var isMainInterest: Bool

    public init(courseId: CourseID, branchId: BranchID? = nil, personalization: [String: String] = [:], isMainInterest: Bool = false) {
        self.courseId = courseId
        self.branchId = branchId
        self.personalization = personalization
        self.isMainInterest = isMainInterest
    }

    public var weight: Double { isMainInterest ? 2 : 1 }
}

/// The primary object of the product.
public struct Person: Codable, Sendable, Hashable, Identifiable {
    public var id: PersonID
    public var displayName: String
    public var relationship: Relationship
    public var interests: [PersonInterest]
    public var createdAt: Date
    public var isActive: Bool

    public init(id: PersonID = UUID().uuidString, displayName: String, relationship: Relationship,
                interests: [PersonInterest] = [], createdAt: Date = Date(timeIntervalSince1970: 0), isActive: Bool = true) {
        self.id = id
        self.displayName = displayName
        self.relationship = relationship
        self.interests = interests
        self.createdAt = createdAt
        self.isActive = isActive
    }

    public var name: String { displayName }

    public func interest(for courseId: CourseID) -> PersonInterest? {
        interests.first { $0.courseId == courseId }
    }
}

public enum ColorBlindMode: String, Codable, Sendable, CaseIterable {
    case none, protanopia, deuteranopia, tritanopia
}

/// Accessibility flags the native app provides and Unity honors (bridge `learnerContext.accessibility`).
public struct AccessibilityPreferences: Codable, Sendable, Hashable {
    public var reducedMotion: Bool
    public var hapticsEnabled: Bool
    public var soundEnabled: Bool
    public var colorBlindMode: ColorBlindMode
    public var textScale: Double

    public init(reducedMotion: Bool = false, hapticsEnabled: Bool = true, soundEnabled: Bool = true,
                colorBlindMode: ColorBlindMode = .none, textScale: Double = 1.0) {
        self.reducedMotion = reducedMotion
        self.hapticsEnabled = hapticsEnabled
        self.soundEnabled = soundEnabled
        self.colorBlindMode = colorBlindMode
        self.textScale = textScale
    }

    enum CodingKeys: String, CodingKey { case reducedMotion, hapticsEnabled, soundEnabled, colorBlindMode, textScale }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        reducedMotion = try c.decode(Bool.self, forKey: .reducedMotion)
        hapticsEnabled = try c.decode(Bool.self, forKey: .hapticsEnabled)
        soundEnabled = try c.decodeIfPresent(Bool.self, forKey: .soundEnabled) ?? true
        colorBlindMode = try c.decode(ColorBlindMode.self, forKey: .colorBlindMode)
        textScale = try c.decode(Double.self, forKey: .textScale)
    }
}

/// The learner (the app's user). Progression numbers (XP, hearts, streak) live in `LearnerState`.
public struct LearnerProfile: Codable, Sendable, Hashable {
    public var id: String
    public var displayName: String?
    public var locale: String
    public var accessibility: AccessibilityPreferences
    /// Discreet mode (default ON): notifications never contain a Person's name.
    public var discreetMode: Bool
    /// Local hour (0-23) for the daily reminder, default 20 (8 PM).
    public var reminderHour: Int

    public init(id: String = UUID().uuidString, displayName: String? = nil, locale: String = "en-US",
                accessibility: AccessibilityPreferences = .init(), discreetMode: Bool = true, reminderHour: Int = 20) {
        self.id = id
        self.displayName = displayName
        self.locale = locale
        self.accessibility = accessibility
        self.discreetMode = discreetMode
        self.reminderHour = reminderHour
    }
}
