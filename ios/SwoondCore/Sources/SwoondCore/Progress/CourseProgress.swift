import Foundation

/// Per (person, course) progress: units/lessons completed and Daily Bite state. Mastery is separate (`CourseMastery`).
public struct CourseProgress: Codable, Sendable, Equatable {
    public struct LessonResult: Codable, Sendable, Equatable {
        public var completedAt: Date
        public var correctCount: Int
        public var totalCount: Int
        public var xpEarned: Int
    }
    public var schemaVersion = 1
    public var personId: PersonID
    public var courseId: CourseID
    public var lessonResults: [LessonID: LessonResult] = [:]
    public var lastDailyBiteDay: DayKey?
    public var lastActivityAt: Date?

    public init(personId: PersonID, courseId: CourseID) { self.personId = personId; self.courseId = courseId }

    public func isLessonComplete(_ id: LessonID) -> Bool { lessonResults[id] != nil }

    public func isUnitComplete(_ unit: Unit) -> Bool { unit.lessons.allSatisfy { isLessonComplete($0.id) } }

    /// Fraction of lessons complete in the units visible to `branchId`.
    public func fractionComplete(in curriculum: Curriculum, branchId: BranchID?) -> Double {
        let lessons = curriculum.units(forBranch: branchId).flatMap(\.lessons)
        guard !lessons.isEmpty else { return 0 }
        return Double(lessons.filter { isLessonComplete($0.id) }.count) / Double(lessons.count)
    }
}
