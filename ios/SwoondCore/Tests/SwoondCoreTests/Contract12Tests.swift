import Foundation
import Testing
@testable import SwoondCore

private let branchExample = Fixtures.docs("contracts/curriculum/v1/examples/basketball-branches-1.2.json")

@Suite("Curriculum contract 1.2: branch layer, activity branchId, lesson live, root branches[]")
struct Contract12Tests {
    private func load() throws -> Curriculum {
        try JSONDecoder().decode(Curriculum.self, from: Fixtures.data(branchExample))
    }

    @Test func exampleDecodesAndRoundTrips() throws {
        let c = try load()
        #expect(c.contractVersion == "1.2.0")
        let again = try JSONDecoder().decode(Curriculum.self, from: JSONEncoder().encode(c))
        #expect(c == again)
    }

    @Test func branchLayerAndUnitBranchId() throws {
        let c = try load()
        let college = try #require(c.unit("branch-college"))
        #expect(college.layer == .branch && college.branchId == "college")
        #expect(c.units(forBranch: "nba").map(\.id) == ["the-game", "the-live-season"])
        #expect(c.units(forBranch: "college").map(\.id) == ["the-game", "branch-college", "the-live-season"])
    }

    @Test func activityBranchIdFiltersWithinASharedLesson() throws {
        let c = try load()
        let lesson = try #require(c.lesson(unitId: "the-game", lessonId: "clocks-01"))
        #expect(lesson.activities.count == 2)
        #expect(lesson.activities(forBranch: "nba").map(\.id) == ["clocks-01-mc"])
        #expect(lesson.activities(forBranch: "college").map(\.id) == ["clocks-01-mc-college"])
        #expect(lesson.activities(forBranch: nil).isEmpty)
    }

    @Test func activitiesWithoutBranchIdAreShared() throws {
        let c = try load()
        let lesson = try #require(c.lesson(unitId: "branch-college", lessonId: "college-01"))
        #expect(lesson.activities.allSatisfy { $0.branchId == nil })
        #expect(lesson.activities(forBranch: "nba").count == lesson.activities.count)
    }

    @Test func lessonAndUnitLiveHooks() throws {
        let c = try load()
        let unit = try #require(c.unit("the-live-season"))
        #expect(unit.live?.adapterKey == "live.standings")
        let lesson = try #require(unit.lessons.first)
        #expect(lesson.live == LiveHook(dataKind: "standings", refreshHint: "daily", adapterKey: "live.standings.playin"))
        #expect(c.unit("the-game")?.lessons.first?.live == nil)
    }

    @Test func rootBranchesFactsContainer() throws {
        let c = try load()
        #expect(c.branches?.map(\.id) == ["nba", "college"])
        let nba = try #require(c.branchFacts("nba"))
        #expect(nba.displayName == "NBA" && nba.lastVerified == "2026-09-30")
        #expect(nba.facts["shotClockSeconds"]?.intValue == 24)
        #expect(nba.facts["periods"]?["count"]?.intValue == 4)
        #expect(nba.facts["defaultBranch"]?.boolValue == true)
        #expect(c.branchFacts("wnba") == nil)
    }

    @Test func oneDotZeroCurriculumStillDecodesWithNoNewFields() throws {
        let c = try Fixtures.curriculum()
        #expect(c.branches == nil)
        #expect(c.allActivities.allSatisfy { $0.branchId == nil })
        #expect(c.allLessons.allSatisfy { $0.lesson.live == nil })
    }

    @Test func splitRootCarriesBranchesIntoTheMergedCurriculum() async throws {
        let root = Fixtures.tempDir()
        defer { try? FileManager.default.removeItem(at: root) }
        let course = root.appendingPathComponent("american-football")
        try FileManager.default.createDirectory(at: course, withIntermediateDirectories: true)
        try FileManager.default.copyItem(at: Fixtures.manifestURL, to: course.appendingPathComponent("manifest.json"))
        let cur = course.appendingPathComponent("curriculum")
        try FileManager.default.copyItem(at: Fixtures.docs("contracts/curriculum/v1/examples/split/american-football/curriculum"), to: cur)
        let rootURL = cur.appendingPathComponent("course.json")
        var obj = try #require(try JSONSerialization.jsonObject(with: Data(contentsOf: rootURL)) as? [String: Any])
        obj["contractVersion"] = "1.2.0"
        obj["branches"] = [["id": "nfl", "displayName": "NFL", "facts": ["conference": "NFC"], "lastVerified": "2026-09-30"]]
        try JSONSerialization.data(withJSONObject: obj).write(to: rootURL)
        let c = try await BundledContentRepository(rootDirectory: root).curriculum(courseId: "american-football", locale: "en-US")
        #expect(c.branchFacts("nfl")?.facts["conference"]?.stringValue == "NFC")
    }
}
