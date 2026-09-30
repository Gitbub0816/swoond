import Foundation

/// Mirrors docs/contracts/curriculum/v1/curriculum.schema.json.

public enum Layer: String, Codable, Sendable, CaseIterable, Hashable {
    case foundations
    case intermediate
    case enthusiast
    /// Contract 1.2: units that exist for one branch only (set the unit `branchId` too).
    case branch
    case currentSeason = "current-season"
    case conversation
    case review
}

public enum ActivityType: String, Codable, Sendable, CaseIterable, Hashable {
    case multipleChoice = "multiple-choice"
    case binaryCall = "binary-call"
    case termMatch = "term-match"
    case sequenceOrder = "sequence-order"
    case visualId = "visual-id"
    case decisionScenario = "decision-scenario"
    case talkTrack = "talk-track"
    case timingTap = "timing-tap"
    case sayThis = "say-this"
    case fillTheGap = "fill-the-gap"
    case listeningId = "listening-id"
    case estimateSlider = "estimate-slider"
    case hotspotTap = "hotspot-tap"
    case unitySim = "unity-sim"

    public var isNative: Bool { self != .unitySim }
}

public struct Concept: Codable, Sendable, Hashable, Identifiable {
    public var id: ConceptID
    public var term: String
    public var definition: String
    public var exampleLine: String
    public var tier: Layer?
    public var relatedConceptIds: [ConceptID]?
    public var aliases: [String]?
}

/// Payload of a `unity-sim` activity.
public struct UnitySimPayload: Codable, Sendable, Hashable {
    public var simulationId: String
    public var simulationVersion: String
    public var difficulty: Int
    public var configuration: [String: JSONValue]?

    public init(simulationId: String, simulationVersion: String, difficulty: Int, configuration: [String: JSONValue]? = nil) {
        self.simulationId = simulationId
        self.simulationVersion = simulationVersion
        self.difficulty = difficulty
        self.configuration = configuration
    }
}

public struct Activity: Codable, Sendable, Hashable, Identifiable {
    public var id: ActivityID
    public var type: ActivityType
    public var conceptIds: [ConceptID]
    /// Raw payload; validated/decoded per `type` (see `ExerciseSessionFactory`, `simulationPayload`).
    public var payload: JSONValue
    /// Contract 1.2: shown only when the person's branch matches; `nil` = shared by every branch.
    public var branchId: BranchID?
    public var reviewEligible: Bool?
    /// XP override; default from XP rules.
    public var xp: Int?

    public init(id: ActivityID, type: ActivityType, conceptIds: [ConceptID], payload: JSONValue, branchId: BranchID? = nil, reviewEligible: Bool? = nil, xp: Int? = nil) {
        self.id = id
        self.type = type
        self.conceptIds = conceptIds
        self.payload = payload
        self.branchId = branchId
        self.reviewEligible = reviewEligible
        self.xp = xp
    }

    /// Schema default is `true`.
    public var isReviewEligible: Bool { reviewEligible ?? true }

    public func simulationPayload() throws -> UnitySimPayload {
        guard type == .unitySim else { throw ContentError.wrongActivityType(expected: .unitySim, actual: type) }
        return try payload.decode(UnitySimPayload.self)
    }
}

public struct Lesson: Codable, Sendable, Hashable, Identifiable {
    public var id: LessonID
    public var title: String
    public var objective: String
    public var estimatedMinutes: Int?
    public var conceptIds: [ConceptID]
    /// Contract 1.2: per-lesson live-data hook (refines the unit hook).
    public var live: LiveHook?
    public var activities: [Activity]

    public init(id: LessonID, title: String, objective: String, estimatedMinutes: Int? = nil, conceptIds: [ConceptID], live: LiveHook? = nil, activities: [Activity]) {
        self.id = id
        self.title = title
        self.objective = objective
        self.estimatedMinutes = estimatedMinutes
        self.conceptIds = conceptIds
        self.live = live
        self.activities = activities
    }

    /// Activities visible to a person's branch: shared (no `branchId`) or matching.
    public func activities(forBranch branchId: BranchID?) -> [Activity] {
        activities.filter { $0.branchId == nil || $0.branchId == branchId }
    }
}

public struct LiveHook: Codable, Sendable, Hashable {
    public var dataKind: String?
    public var refreshHint: String?
    public var adapterKey: String?

    public init(dataKind: String? = nil, refreshHint: String? = nil, adapterKey: String? = nil) {
        self.dataKind = dataKind
        self.refreshHint = refreshHint
        self.adapterKey = adapterKey
    }
}

/// Contract 1.2: root `branches[]` entry, a facts container for branch-specific data (e.g. F1 team facts).
public struct BranchFacts: Codable, Sendable, Hashable, Identifiable {
    public var id: BranchID
    public var displayName: String?
    public var facts: [String: JSONValue]
    /// ISO date (`yyyy-MM-dd`) the facts were last verified.
    public var lastVerified: String?
    public var sources: [String]?

    public init(id: BranchID, displayName: String? = nil, facts: [String: JSONValue] = [:], lastVerified: String? = nil, sources: [String]? = nil) {
        self.id = id
        self.displayName = displayName
        self.facts = facts
        self.lastVerified = lastVerified
        self.sources = sources
    }
}

public struct Unit: Codable, Sendable, Hashable, Identifiable {
    public var id: UnitID
    public var title: String
    public var summary: String?
    public var layer: Layer
    public var order: Int?
    public var prerequisiteUnitIds: [UnitID]?
    public var branchId: BranchID?
    public var personalizationSlots: [String]?
    public var live: LiveHook?
    public var lessons: [Lesson]

    public init(id: UnitID, title: String, summary: String? = nil, layer: Layer, order: Int? = nil,
                prerequisiteUnitIds: [UnitID]? = nil, branchId: BranchID? = nil, personalizationSlots: [String]? = nil,
                live: LiveHook? = nil, lessons: [Lesson]) {
        self.id = id
        self.title = title
        self.summary = summary
        self.layer = layer
        self.order = order
        self.prerequisiteUnitIds = prerequisiteUnitIds
        self.branchId = branchId
        self.personalizationSlots = personalizationSlots
        self.live = live
        self.lessons = lessons
    }
}

public struct TalkTrack: Codable, Sendable, Hashable, Identifiable {
    public var id: String
    public var title: String
    public var unlockedByUnitId: UnitID?
    public var conceptIds: [ConceptID]
    /// `talk-track` exercise payload.
    public var payload: JSONValue

    public func exercisePayload() throws -> TalkTrackPayload { try payload.decode(TalkTrackPayload.self) }
}

public enum ReviewAlgorithm: String, Codable, Sendable, Hashable {
    case leitnerBoxesV1 = "leitner-boxes-v1"
}

public struct ReviewPolicy: Codable, Sendable, Hashable {
    public var algorithm: ReviewAlgorithm
    public var intervalsDays: [Int]
    public var maxItemsPerSession: Int
    public var masteryThreshold: Double
    public var decayAfterDays: Int?
    public var reviewActivityTypes: [ActivityType]?

    public init(algorithm: ReviewAlgorithm = .leitnerBoxesV1, intervalsDays: [Int] = [1, 3, 7, 14, 30, 60],
                maxItemsPerSession: Int = 10, masteryThreshold: Double = 0.8, decayAfterDays: Int? = 45,
                reviewActivityTypes: [ActivityType]? = nil) {
        self.algorithm = algorithm
        self.intervalsDays = intervalsDays
        self.maxItemsPerSession = maxItemsPerSession
        self.masteryThreshold = masteryThreshold
        self.decayAfterDays = decayAfterDays
        self.reviewActivityTypes = reviewActivityTypes
    }
}

public struct Curriculum: Codable, Sendable, Hashable {
    public var contractVersion: String
    public var courseId: CourseID
    public var curriculumVersion: String
    public var locale: String
    public var concepts: [Concept]
    public var units: [Unit]
    /// Contract 1.2: branch-specific facts container.
    public var branches: [BranchFacts]?
    public var talkTracks: [TalkTrack]?
    public var reviewPolicy: ReviewPolicy

    public init(contractVersion: String = "1.0.0", courseId: CourseID, curriculumVersion: String = "0.1.0", locale: String = "en-US",
                concepts: [Concept], units: [Unit], branches: [BranchFacts]? = nil, talkTracks: [TalkTrack]? = nil, reviewPolicy: ReviewPolicy = .init()) {
        self.contractVersion = contractVersion
        self.courseId = courseId
        self.curriculumVersion = curriculumVersion
        self.locale = locale
        self.concepts = concepts
        self.units = units
        self.branches = branches
        self.talkTracks = talkTracks
        self.reviewPolicy = reviewPolicy
    }

    public func concept(_ id: ConceptID) -> Concept? { concepts.first { $0.id == id } }
    public func unit(_ id: UnitID) -> Unit? { units.first { $0.id == id } }
    public func lesson(unitId: UnitID, lessonId: LessonID) -> Lesson? {
        unit(unitId)?.lessons.first { $0.id == lessonId }
    }
    public var allLessons: [(unit: Unit, lesson: Lesson)] {
        units.flatMap { u in u.lessons.map { (u, $0) } }
    }
    public var allActivities: [Activity] { units.flatMap { $0.lessons.flatMap { $0.activities } } }

    /// Facts for one branch, if the course declares any.
    public func branchFacts(_ id: BranchID) -> BranchFacts? { branches?.first { $0.id == id } }

    /// Units visible to a person's branch selection: no `branchId`, or matching.
    public func units(forBranch branchId: BranchID?) -> [Unit] {
        units.filter { $0.branchId == nil || $0.branchId == branchId }
    }
}

public enum ContentError: Error, Sendable, Equatable {
    case courseNotFound(CourseID)
    case curriculumNotFound(CourseID)
    case fileMissing(String)
    case wrongActivityType(expected: ActivityType, actual: ActivityType)
    case invalidPayload(activityId: String, reason: String)
}
