import Foundation

/// One selectable interest (a launch course) with its display name and serif monogram.
public struct InterestOption: Sendable, Hashable, Identifiable, Codable {
    public var id: CourseID
    public var name: String
    /// Two-letter monogram shown in the design's interest rows ("Hk", "Vg").
    public var monogram: String
    public init(id: CourseID, name: String, monogram: String) { self.id = id; self.name = name; self.monogram = monogram }
}

/// The 20 launch interests (DESIGN_SPEC section 9), mapped to course ids.
public enum InterestCatalog {
    public static let launch: [InterestOption] = [
        InterestOption(id: "american-football", name: "Football", monogram: "Fb"),
        InterestOption(id: "hockey", name: "Hockey", monogram: "Hk"),
        InterestOption(id: "nascar", name: "NASCAR", monogram: "Na"),
        InterestOption(id: "pickleball", name: "Pickleball", monogram: "Pb"),
        InterestOption(id: "video-games", name: "Video games", monogram: "Vg"),
        InterestOption(id: "basketball", name: "Basketball", monogram: "Bb"),
        InterestOption(id: "soccer", name: "Soccer", monogram: "Sc"),
        InterestOption(id: "formula-1", name: "F1", monogram: "F1"),
        InterestOption(id: "tennis", name: "Tennis", monogram: "Tn"),
        InterestOption(id: "golf", name: "Golf", monogram: "Gf"),
        InterestOption(id: "baseball", name: "Baseball", monogram: "Bs"),
        InterestOption(id: "anime", name: "Anime", monogram: "An"),
        InterestOption(id: "k-pop", name: "K-pop", monogram: "Kp"),
        InterestOption(id: "climbing", name: "Climbing", monogram: "Cl"),
        InterestOption(id: "wine", name: "Wine", monogram: "Wn"),
        InterestOption(id: "fashion", name: "Fashion", monogram: "Fs"),
        InterestOption(id: "skincare", name: "Skincare", monogram: "Sk"),
        InterestOption(id: "coffee", name: "Coffee", monogram: "Cf"),
        InterestOption(id: "horror-films", name: "Horror films", monogram: "Hf"),
        InterestOption(id: "hiking", name: "Hiking", monogram: "Hg"),
    ]

    public static func option(for courseId: CourseID) -> InterestOption? { launch.first { $0.id == courseId } }

    /// Display name for a course id; unknown ids are prettified from kebab-case ("video-games" -> "Video games").
    public static func displayName(for courseId: CourseID) -> String {
        if let o = option(for: courseId) { return o.name }
        let words = courseId.split(separator: "-").map(String.init)
        guard let first = words.first else { return courseId }
        return ([first.prefix(1).uppercased() + first.dropFirst()] + words.dropFirst()).joined(separator: " ")
    }

    public static func monogram(for courseId: CourseID) -> String {
        if let o = option(for: courseId) { return o.monogram }
        let name = displayName(for: courseId)
        return String(name.prefix(1)).uppercased() + String(name.dropFirst().prefix(1)).lowercased()
    }

    /// In-app search normalization (DESIGN_SPEC section 1): strip apostrophes (straight and curly), hyphens and whitespace, lowercase.
    /// "Swoon'd", "Swoon\u{2019}d", "Swoon d" and "swoond" all normalize to "swoond".
    public static func normalize(_ query: String) -> String {
        let drop: Set<Character> = ["'", "\u{2019}", "\u{2018}", "`", "-"]
        return query.lowercased().filter { !drop.contains($0) && !$0.isWhitespace }
    }

    public static func search(_ query: String, in options: [InterestOption] = launch) -> [InterestOption] {
        let q = normalize(query)
        guard !q.isEmpty else { return options }
        return options.filter { normalize($0.name).contains(q) || normalize($0.id).contains(q) }
    }
}

extension Relationship {
    /// Learner-facing label.
    public var displayName: String {
        switch self {
        case .crush: return "Crush"
        case .datingPartner: return "Partner"
        case .spouse: return "Spouse"
        case .friend: return "Friend"
        case .familyMember: return "Family"
        case .parent: return "Parent"
        case .child: return "Child"
        case .coworker: return "Coworker"
        case .other: return "Someone else"
        }
    }
}
