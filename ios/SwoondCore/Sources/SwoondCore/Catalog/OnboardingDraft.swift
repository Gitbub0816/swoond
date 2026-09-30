import Foundation

/// Onboarding state machine: who -> interests -> plan (design README screen 2a: step N of 3).
public struct OnboardingDraft: Sendable, Equatable {
    public enum Step: Int, Sendable, CaseIterable { case person = 0, interests, plan }

    public var step: Step = .person
    public var name = ""
    public var relationship: Relationship = .crush
    /// Selected course ids in tap order.
    public var selectedCourseIds: [CourseID] = []
    /// The person's "main interest" (weight 2 in Common Ground).
    public var mainInterestId: CourseID?

    public init() {}

    public var trimmedName: String { name.trimmingCharacters(in: .whitespacesAndNewlines) }
    public var stepNumber: Int { step.rawValue + 1 }
    public static let stepCount = 3

    public var canAdvance: Bool {
        switch step {
        case .person: return !trimmedName.isEmpty
        case .interests: return !selectedCourseIds.isEmpty
        case .plan: return true
        }
    }

    public var selectionLabel: String {
        switch selectedCourseIds.count {
        case 0: return "Pick at least one"
        case 1: return "1 interest selected"
        case let n: return "\(n) interests selected"
        }
    }

    public mutating func toggle(_ courseId: CourseID) {
        if let i = selectedCourseIds.firstIndex(of: courseId) {
            selectedCourseIds.remove(at: i)
            if mainInterestId == courseId { mainInterestId = nil }
        } else {
            selectedCourseIds.append(courseId)
        }
    }

    public func isSelected(_ courseId: CourseID) -> Bool { selectedCourseIds.contains(courseId) }

    public mutating func setMain(_ courseId: CourseID?) {
        guard courseId == nil || selectedCourseIds.contains(courseId ?? "") else { return }
        mainInterestId = courseId
    }

    /// Advance if allowed. Returns false at the last step (the caller then builds the person).
    @discardableResult
    public mutating func advance() -> Bool {
        guard canAdvance, let next = Step(rawValue: step.rawValue + 1) else { return false }
        step = next
        return true
    }

    public mutating func back() {
        if let prev = Step(rawValue: step.rawValue - 1) { step = prev }
    }

    /// Build the `Person`. Without an explicit main interest the first selection is main.
    public func makePerson(id: PersonID = UUID().uuidString, createdAt: Date = Date()) -> Person {
        let main = mainInterestId ?? selectedCourseIds.first
        let interests = selectedCourseIds.map { PersonInterest(courseId: $0, isMainInterest: $0 == main) }
        return Person(id: id, displayName: trimmedName, relationship: relationship, interests: interests, createdAt: createdAt, isActive: true)
    }
}
