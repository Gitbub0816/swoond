import Foundation

/// Mirrors docs/contracts/course-manifest/v1/course-manifest.schema.json.
/// Enumerations the schema declares but that grow over time (family, status, kinds...) are kept as
/// strings so a newer content pack never fails to decode; `ActivityType` is a real enum.
public struct CourseManifest: Codable, Sendable, Hashable {
    public struct Branch: Codable, Sendable, Hashable {
        public var id: BranchID
        public var displayName: String
        public var description: String?
        public var personalizationDimension: String?
    }
    public struct FoundationalModule: Codable, Sendable, Hashable {
        public var id: UnitID
        public var title: String
        public var summary: String?
    }
    public struct UnitySimulation: Codable, Sendable, Hashable {
        public var simulationId: String
        public var specPath: String
        public var status: String
        public var lessonIds: [LessonID]?
    }
    public struct NativeExercise: Codable, Sendable, Hashable {
        public var exerciseType: ActivityType
        public var specPath: String
        public var estimatedCount: Int?
    }
    public struct DynamicData: Codable, Sendable, Hashable {
        public var kind: String
        public var providerCandidates: [String]
        public var refreshFrequency: String
        public var notes: String?
    }
    public struct Editorial: Codable, Sendable, Hashable {
        public var approach: String
        public var sources: [String]?
        public var topicsWeExplain: [String]?
        public var copyrightPolicy: String?
    }
    public struct ConversationScenarios: Codable, Sendable, Hashable {
        public var count: Int
        public var path: String
    }
    public struct MasteryModel: Codable, Sendable, Hashable {
        public var type: String
        public var passThreshold: Double
        public var usefulCompetenceStatement: String?
    }
    public struct LicensingConstraint: Codable, Sendable, Hashable {
        public var area: String
        public var constraint: String
    }
    public struct RelatedCourse: Codable, Sendable, Hashable {
        public var courseId: CourseID
        public var relationship: String
    }

    public var contractVersion: String
    public var courseId: CourseID
    public var displayName: String
    public var category: String
    public var family: String
    public var status: String
    public var wave: Int
    public var simulationPrefix: String
    public var branches: [Branch]
    public var curriculumVersion: String
    public var foundationalModules: [FoundationalModule]
    public var interactionTypes: [ActivityType]
    public var unitySimulations: [UnitySimulation]
    public var nativeExercises: [NativeExercise]
    public var dynamicData: [DynamicData]
    public var editorial: Editorial
    public var personalizationDimensions: [String]
    public var conversationScenarios: ConversationScenarios
    public var masteryModel: MasteryModel
    public var licensingConstraints: [LicensingConstraint]
    public var safetyConstraints: [String]
    public var relatedCourses: [RelatedCourse]

    public var summary: CourseSummary {
        CourseSummary(courseId: courseId, displayName: displayName, category: category, family: family,
                      wave: wave, status: status, branches: branches.map { CourseSummary.BranchSummary(id: $0.id, displayName: $0.displayName) })
    }
}

/// Lightweight row for course browsing.
public struct CourseSummary: Codable, Sendable, Hashable, Identifiable {
    public struct BranchSummary: Codable, Sendable, Hashable { public var id: BranchID; public var displayName: String }
    public var courseId: CourseID
    public var displayName: String
    public var category: String
    public var family: String
    public var wave: Int
    public var status: String
    public var branches: [BranchSummary]
    public var id: CourseID { courseId }
}
