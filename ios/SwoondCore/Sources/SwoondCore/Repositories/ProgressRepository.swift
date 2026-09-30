import Foundation

public protocol ProgressRepository: Sendable {
    func progress(personId: PersonID, courseId: CourseID) async throws -> CourseProgress
    func save(_ progress: CourseProgress) async throws
    func learnerState() async throws -> LearnerState
    func save(_ state: LearnerState) async throws
    /// Concept mastery per learner and course.
    func mastery(courseId: CourseID) async throws -> CourseMastery
    func save(_ mastery: CourseMastery) async throws
}

public protocol PersonRepository: Sendable {
    func people() async throws -> [Person]
    func save(_ person: Person) async throws
    func delete(personId: PersonID) async throws
}

public actor InMemoryProgressRepository: ProgressRepository {
    private var progressByKey: [String: CourseProgress] = [:]
    private var state: LearnerState
    private var masteryByCourse: [CourseID: CourseMastery] = [:]

    public init(initialState: LearnerState = LearnerState()) { state = initialState }

    public func progress(personId: PersonID, courseId: CourseID) async throws -> CourseProgress {
        progressByKey["\(personId)|\(courseId)"] ?? CourseProgress(personId: personId, courseId: courseId)
    }
    public func save(_ progress: CourseProgress) async throws { progressByKey["\(progress.personId)|\(progress.courseId)"] = progress }
    public func learnerState() async throws -> LearnerState { state }
    public func save(_ state: LearnerState) async throws { self.state = state }
    public func mastery(courseId: CourseID) async throws -> CourseMastery { masteryByCourse[courseId] ?? CourseMastery(courseId: courseId) }
    public func save(_ mastery: CourseMastery) async throws { masteryByCourse[mastery.courseId] = mastery }
}

public actor InMemoryPersonRepository: PersonRepository {
    private var store: [PersonID: Person] = [:]
    private var order: [PersonID] = []
    public init(_ initial: [Person] = []) { for p in initial { store[p.id] = p; order.append(p.id) } }
    public func people() async throws -> [Person] { order.compactMap { store[$0] } }
    public func save(_ person: Person) async throws {
        if store[person.id] == nil { order.append(person.id) }
        store[person.id] = person
    }
    public func delete(personId: PersonID) async throws { store[personId] = nil; order.removeAll { $0 == personId } }
}

/// On-device JSON files with atomic writes (ARCHITECTURE section 9):
/// `learner.json`, `progress-<personId>-<courseId>.json`, `mastery-<courseId>.json`.
public actor FileProgressRepository: ProgressRepository {
    private let directory: URL
    private let fm = FileManager.default

    public init(directory: URL) { self.directory = directory }

    public func progress(personId: PersonID, courseId: CourseID) async throws -> CourseProgress {
        try read(CourseProgress.self, "progress-\(Self.safe(personId))-\(Self.safe(courseId)).json") ?? CourseProgress(personId: personId, courseId: courseId)
    }
    public func save(_ progress: CourseProgress) async throws {
        try write(progress, "progress-\(Self.safe(progress.personId))-\(Self.safe(progress.courseId)).json")
    }
    public func learnerState() async throws -> LearnerState { try read(LearnerState.self, "learner.json") ?? LearnerState() }
    public func save(_ state: LearnerState) async throws { try write(state, "learner.json") }
    public func mastery(courseId: CourseID) async throws -> CourseMastery {
        try read(CourseMastery.self, "mastery-\(Self.safe(courseId)).json") ?? CourseMastery(courseId: courseId)
    }
    public func save(_ mastery: CourseMastery) async throws { try write(mastery, "mastery-\(Self.safe(mastery.courseId)).json") }

    private func read<T: Decodable>(_ type: T.Type, _ name: String) throws -> T? {
        let url = directory.appendingPathComponent(name)
        guard fm.fileExists(atPath: url.path) else { return nil }
        return try JSONStore.decoder.decode(T.self, from: Data(contentsOf: url))
    }
    private func write<T: Encodable>(_ value: T, _ name: String) throws {
        try fm.createDirectory(at: directory, withIntermediateDirectories: true)
        try JSONStore.encoder.encode(value).write(to: directory.appendingPathComponent(name), options: .atomic)
    }
    static func safe(_ s: String) -> String {
        String(s.unicodeScalars.map { CharacterSet.alphanumerics.contains($0) || $0 == "-" || $0 == "_" ? Character($0) : "_" })
    }
}

public actor FilePersonRepository: PersonRepository {
    private let url: URL
    public init(directory: URL) { url = directory.appendingPathComponent("people.json") }

    public func people() async throws -> [Person] { try load() }
    public func save(_ person: Person) async throws {
        var all = try load()
        if let i = all.firstIndex(where: { $0.id == person.id }) { all[i] = person } else { all.append(person) }
        try store(all)
    }
    public func delete(personId: PersonID) async throws { try store(try load().filter { $0.id != personId }) }

    private func load() throws -> [Person] {
        guard FileManager.default.fileExists(atPath: url.path) else { return [] }
        return try JSONStore.decoder.decode([Person].self, from: Data(contentsOf: url))
    }
    private func store(_ people: [Person]) throws {
        try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        try JSONStore.encoder.encode(people).write(to: url, options: .atomic)
    }
}

enum JSONStore {
    static var encoder: JSONEncoder {
        let e = JSONEncoder()
        e.outputFormatting = [.prettyPrinted, .sortedKeys]
        e.dateEncodingStrategy = .iso8601
        return e
    }
    static var decoder: JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601
        return d
    }
}
