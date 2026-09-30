import Foundation

/// "Common ground" with a person: how much of what they care about the learner can now genuinely engage with.
/// Per interest = mean over the concepts taught in the visible units of `min(1, mastery / threshold)`.
/// Person score = weighted mean over interests (main interest weight 2). Result is 0...1.
public enum CommonGround {
    public static func coverage(curriculum: Curriculum, mastery: CourseMastery, branchId: BranchID?, now: Date) -> Double {
        var ids = Set<ConceptID>()
        for u in curriculum.units(forBranch: branchId) {
            for l in u.lessons { ids.formUnion(l.conceptIds); for a in l.activities { ids.formUnion(a.conceptIds) } }
        }
        ids = ids.filter { curriculum.concept($0) != nil }
        guard !ids.isEmpty else { return 0 }
        let policy = curriculum.reviewPolicy
        let threshold = max(0.0001, policy.masteryThreshold)
        let total = ids.reduce(0.0) { $0 + min(1, mastery.value($1, now: now, policy: policy) / threshold) }
        return total / Double(ids.count)
    }

    /// Weighted average of per-interest coverages (`coverages[courseId]`; missing = 0).
    public static func score(for person: Person, coverages: [CourseID: Double]) -> Double {
        guard !person.interests.isEmpty else { return 0 }
        let totalWeight = person.interests.reduce(0.0) { $0 + $1.weight }
        let sum = person.interests.reduce(0.0) { $0 + $1.weight * min(1, max(0, coverages[$1.courseId] ?? 0)) }
        return sum / totalWeight
    }

    public static func percent(_ score: Double) -> Int { Int((score * 100).rounded()) }

    /// Like `score(for:content:engine:locale:)` but a course whose content is not installed counts as 0 instead of throwing.
    public static func scoreTolerant(for person: Person, content: any ContentRepository, engine: ProgressEngine, locale: String = "en-US") async -> Double {
        var cov: [CourseID: Double] = [:]
        let now = await engine.now()
        for i in person.interests {
            guard let c = try? await content.curriculum(courseId: i.courseId, locale: locale),
                  let m = try? await engine.mastery(courseId: i.courseId) else { continue }
            cov[i.courseId] = coverage(curriculum: c, mastery: m, branchId: i.branchId, now: now)
        }
        return score(for: person, coverages: cov)
    }

    /// Convenience that loads curricula and mastery.
    public static func score(for person: Person, content: any ContentRepository, engine: ProgressEngine, locale: String = "en-US") async throws -> Double {
        var cov: [CourseID: Double] = [:]
        let now = await engine.now()
        for i in person.interests {
            let c = try await content.curriculum(courseId: i.courseId, locale: locale)
            let m = try await engine.mastery(courseId: i.courseId)
            cov[i.courseId] = coverage(curriculum: c, mastery: m, branchId: i.branchId, now: now)
        }
        return score(for: person, coverages: cov)
    }
}

/// League: weekly XP ranking (week = ISO Monday start, in the learner's time zone).
public struct LeagueEntry: Sendable, Equatable, Identifiable {
    public var id: String
    public var name: String
    public var weeklyXP: Int
    public var isLearner: Bool
    public var rank: Int
}

public enum League {
    /// Rank by weekly XP descending; ties broken by name, then id (stable, deterministic). Ranks are 1-based, ties share no rank.
    public static func ranked(_ entries: [(id: String, name: String, weeklyXP: Int, isLearner: Bool)]) -> [LeagueEntry] {
        entries.sorted { a, b in
            if a.weeklyXP != b.weeklyXP { return a.weeklyXP > b.weeklyXP }
            if a.name != b.name { return a.name < b.name }
            return a.id < b.id
        }.enumerated().map { LeagueEntry(id: $1.id, name: $1.name, weeklyXP: $1.weeklyXP, isLearner: $1.isLearner, rank: $0 + 1) }
    }

    public static func learnerRank(in entries: [LeagueEntry]) -> Int? { entries.first(where: \.isLearner)?.rank }
}
