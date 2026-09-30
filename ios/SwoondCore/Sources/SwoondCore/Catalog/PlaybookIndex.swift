import Foundation

/// One Playbook card: a concept the learner has met (or could meet) with its mastery status.
public struct PlaybookEntry: Sendable, Hashable, Identifiable {
    public var id: String
    public var courseId: CourseID
    public var courseName: String
    public var concept: Concept
    public var status: MasteryStatus
    public init(courseId: CourseID, courseName: String, concept: Concept, status: MasteryStatus) {
        self.id = "\(courseId)/\(concept.id)"
        self.courseId = courseId
        self.courseName = courseName
        self.concept = concept
        self.status = status
    }
}

/// Glossary of every term across the learner's courses, with search and interest filtering.
public enum PlaybookIndex {
    /// Build entries for the given curricula. Sorted Mastered, Learning, New; then alphabetical by term.
    /// `branchIds` maps a course to the person's branch (contract 1.2): concepts taught only by other branches are left out.
    public static func entries(curricula: [Curriculum], courseNames: [CourseID: String] = [:], mastery: [CourseID: CourseMastery],
                               now: Date, includeNew: Bool = true, branchIds: [CourseID: BranchID] = [:]) -> [PlaybookEntry] {
        var out: [PlaybookEntry] = []
        for c in curricula {
            let m = mastery[c.courseId] ?? CourseMastery(courseId: c.courseId)
            let name = courseNames[c.courseId] ?? InterestCatalog.displayName(for: c.courseId)
            for concept in c.concepts(forBranch: branchIds[c.courseId]) {
                let status = m.status(concept.id, now: now, policy: c.reviewPolicy)
                if status == .new && !includeNew { continue }
                out.append(PlaybookEntry(courseId: c.courseId, courseName: name, concept: concept, status: status))
            }
        }
        return out.sorted {
            let a = rank($0.status), b = rank($1.status)
            return a == b ? $0.concept.term.localizedCaseInsensitiveCompare($1.concept.term) == .orderedAscending : a < b
        }
    }

    private static func rank(_ s: MasteryStatus) -> Int {
        switch s { case .mastered: return 0; case .learning: return 1; case .new: return 2 }
    }

    /// Filter by interest and by a normalized search query (matches term, aliases and definition).
    public static func filter(_ entries: [PlaybookEntry], query: String, courseId: CourseID?) -> [PlaybookEntry] {
        let q = InterestCatalog.normalize(query)
        return entries.filter { e in
            if let courseId, e.courseId != courseId { return false }
            guard !q.isEmpty else { return true }
            if InterestCatalog.normalize(e.concept.term).contains(q) { return true }
            if (e.concept.aliases ?? []).contains(where: { InterestCatalog.normalize($0).contains(q) }) { return true }
            return InterestCatalog.normalize(e.concept.definition).contains(q)
        }
    }

    /// Terms the learner has started on (Learning or Mastered).
    public static func learnedCount(_ entries: [PlaybookEntry]) -> Int { entries.filter { $0.status != .new }.count }
}

extension Curriculum {
    /// Concepts relevant to a branch: everything except concepts taught only by other branches' units or activities.
    /// (Concepts no unit references stay visible: they are glossary-only.)
    public func concepts(forBranch branchId: BranchID?) -> [Concept] {
        var everywhere = Set<ConceptID>(), visible = Set<ConceptID>()
        for u in units {
            for l in u.lessons {
                everywhere.formUnion(l.conceptIds)
                for a in l.activities { everywhere.formUnion(a.conceptIds) }
            }
        }
        for u in units(forBranch: branchId) {
            for l in u.lessons {
                visible.formUnion(l.conceptIds)
                for a in l.activities(forBranch: branchId) { visible.formUnion(a.conceptIds) }
            }
        }
        let hidden = everywhere.subtracting(visible)
        return concepts.filter { !hidden.contains($0.id) }
    }
}
