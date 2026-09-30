import Foundation
@testable import SwoondCore

enum Fixtures {
    /// /home/user/swoond (tests live at ios/SwoondCore/Tests/SwoondCoreTests/<file>).
    static let repoRoot: URL = {
        var u = URL(fileURLWithPath: #filePath)
        for _ in 0..<5 { u.deleteLastPathComponent() }
        return u
    }()
    static func docs(_ relative: String) -> URL { repoRoot.appendingPathComponent("docs").appendingPathComponent(relative) }

    static let bridgeExamples = docs("contracts/unity-bridge/v1/examples")
    static let exerciseExamples = docs("contracts/native-exercises/v1/examples")
    static let curriculumURL = docs("contracts/curriculum/v1/examples/american-football-sample.json")
    static let manifestURL = docs("contracts/course-manifest/v1/examples/american-football-sample.json")

    static func jsonFiles(in dir: URL) throws -> [URL] {
        try FileManager.default.contentsOfDirectory(at: dir, includingPropertiesForKeys: nil)
            .filter { $0.pathExtension == "json" }.sorted { $0.lastPathComponent < $1.lastPathComponent }
    }
    static func data(_ url: URL) throws -> Data { try Data(contentsOf: url) }
    static func value(_ url: URL) throws -> JSONValue { try JSONDecoder().decode(JSONValue.self, from: data(url)) }

    static func curriculum() throws -> Curriculum { try JSONDecoder().decode(Curriculum.self, from: data(curriculumURL)) }
    static func manifest() throws -> CourseManifest { try JSONDecoder().decode(CourseManifest.self, from: data(manifestURL)) }

    static let utc = TimeZone(identifier: "UTC")!
    static let newYork = TimeZone(identifier: "America/New_York")!
    static let tokyo = TimeZone(identifier: "Asia/Tokyo")!

    /// A moment in a time zone.
    static func date(_ y: Int, _ m: Int, _ d: Int, _ h: Int = 12, _ min: Int = 0, tz: TimeZone = utc) -> Date {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = tz
        return cal.date(from: DateComponents(year: y, month: m, day: d, hour: h, minute: min))!
    }

    static let sarah = Person(id: "sarah", displayName: "Sarah", relationship: .crush,
                              interests: [PersonInterest(courseId: "american-football", branchId: "nfl", personalization: ["team": "Philadelphia Eagles"], isMainInterest: true)])

    static func repo() throws -> StaticContentRepository {
        StaticContentRepository(manifests: [try manifest()], curricula: [try curriculum()])
    }

    static func engine(clock: any Clock, tz: TimeZone = utc, state: LearnerState = LearnerState()) -> (ProgressEngine, InMemoryProgressRepository) {
        let repo = InMemoryProgressRepository(initialState: state)
        return (ProgressEngine(repository: repo, clock: clock, timeZone: tz), repo)
    }

    static func tempDir() -> URL {
        let u = FileManager.default.temporaryDirectory.appendingPathComponent("swoondcore-tests-\(UUID().uuidString)")
        try? FileManager.default.createDirectory(at: u, withIntermediateDirectories: true)
        return u
    }
}

/// Build a payload from a JSON string.
func json(_ s: String) -> JSONValue { try! JSONDecoder().decode(JSONValue.self, from: Data(s.utf8)) }
