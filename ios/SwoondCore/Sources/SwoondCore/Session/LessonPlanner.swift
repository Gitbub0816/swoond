import Foundation

public struct PlannedLesson: Sendable, Equatable {
    public var unitId: UnitID
    public var unitTitle: String
    public var layer: Layer
    public var lesson: Lesson
}

public struct PlannedReview: Sendable, Equatable {
    public var conceptId: ConceptID
    public var activity: Activity
    public var dueAt: Date
}

/// Pure planning logic: what to learn next and what is due for review.
public enum LessonPlanner {
    /// Units for the branch, in authored order (`order`, then array position).
    public static func orderedUnits(_ c: Curriculum, branchId: BranchID?) -> [Unit] {
        let indexed = c.units.enumerated().filter { $0.element.branchId == nil || $0.element.branchId == branchId }
        return indexed.sorted { a, b in
            let ao = a.element.order ?? a.offset, bo = b.element.order ?? b.offset
            return ao == bo ? a.offset < b.offset : ao < bo
        }.map(\.element)
    }

    /// A unit is unlocked when every prerequisite unit (visible to the branch) is fully complete.
    public static func isUnlocked(_ unit: Unit, in c: Curriculum, progress: CourseProgress) -> Bool {
        (unit.prerequisiteUnitIds ?? []).allSatisfy { pid in
            guard let p = c.unit(pid) else { return true }   // unknown prerequisite is a content error, not a lock
            return progress.isUnitComplete(p)
        }
    }

    public static func nextLesson(in c: Curriculum, progress: CourseProgress, branchId: BranchID?) -> PlannedLesson? {
        for u in orderedUnits(c, branchId: branchId) where isUnlocked(u, in: c, progress: progress) {
            if let l = u.lessons.first(where: { !progress.isLessonComplete($0.id) }) {
                return PlannedLesson(unitId: u.id, unitTitle: u.title, layer: u.layer, lesson: l)
            }
        }
        return nil
    }

    /// Due concepts (most overdue first, up to `maxItemsPerSession`), each paired with a review-eligible native
    /// activity of an allowed type, preferring one not used last time.
    public static func dueReviews(in c: Curriculum, mastery: CourseMastery, now: Date) -> [PlannedReview] {
        let policy = c.reviewPolicy
        let allowed = policy.reviewActivityTypes.map(Set.init)
        let candidates = c.allActivities.filter { $0.type.isNative && $0.type != .talkTrack && $0.isReviewEligible && (allowed?.contains($0.type) ?? true) }
        var used = Set<ActivityID>()
        var out: [PlannedReview] = []
        for cid in mastery.dueConceptIds(now: now) {
            if out.count >= policy.maxItemsPerSession { break }
            let pool = candidates.filter { $0.conceptIds.contains(cid) && !used.contains($0.id) }
            guard !pool.isEmpty else { continue }
            let last = mastery.concepts[cid]?.lastActivityId
            let pick = pool.first { $0.id != last } ?? pool[0]
            used.insert(pick.id)
            out.append(PlannedReview(conceptId: cid, activity: pick, dueAt: mastery.concepts[cid]?.dueAt ?? now))
        }
        return out
    }
}
