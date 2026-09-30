import Foundation
import Testing
@testable import SwoondCore

private let splitExample = Fixtures.docs("contracts/curriculum/v1/examples/split/american-football/curriculum")

/// `<root>/american-football/{manifest.json, curriculum/{course.json, units/*.json}}` copied from the split example.
private func makeSplitRoot() throws -> (root: URL, curriculum: URL) {
    let root = Fixtures.tempDir()
    let course = root.appendingPathComponent("american-football")
    try FileManager.default.createDirectory(at: course, withIntermediateDirectories: true)
    try FileManager.default.copyItem(at: Fixtures.manifestURL, to: course.appendingPathComponent("manifest.json"))
    let cur = course.appendingPathComponent("curriculum")
    try FileManager.default.copyItem(at: splitExample, to: cur)
    return (root, cur)
}

private func editJSON(_ url: URL, _ change: (inout [String: Any]) -> Void) throws {
    var obj = try JSONSerialization.jsonObject(with: Data(contentsOf: url)) as! [String: Any]
    change(&obj)
    try JSONSerialization.data(withJSONObject: obj).write(to: url)
}

@Suite("Split curriculum layout (contract 1.1)")
struct SplitContentTests {
    @Test func splitMergesToSameCurriculumAsSingleFile() async throws {
        let (root, _) = try makeSplitRoot()
        defer { try? FileManager.default.removeItem(at: root) }
        let split = try await BundledContentRepository(rootDirectory: root).curriculum(courseId: "american-football", locale: "en-US")
        let single = try Fixtures.curriculum()
        #expect(split.units == single.units)
        #expect(split.talkTracks == single.talkTracks)
        #expect(split.reviewPolicy == single.reviewPolicy)
        #expect(Set(split.concepts.map(\.id)) == Set(single.concepts.map(\.id)))
        #expect(split.concepts.count == single.concepts.count)
        #expect(ContentValidator.validate(split).isEmpty)
    }

    @Test func unitsFollowUnitOrder() async throws {
        let (root, cur) = try makeSplitRoot()
        defer { try? FileManager.default.removeItem(at: root) }
        try editJSON(cur.appendingPathComponent("course.json")) { $0["unitOrder"] = (($0["unitOrder"] as! [String]).reversed() as [String]) }
        let c = try await BundledContentRepository(rootDirectory: root).curriculum(courseId: "american-football", locale: "en-US")
        let expected = Array(try Fixtures.curriculum().units.map(\.id).reversed())
        #expect(c.units.map(\.id) == expected)
    }

    @Test func unitOrderMustMatchUnitFiles() async throws {
        let (root, cur) = try makeSplitRoot()
        defer { try? FileManager.default.removeItem(at: root) }
        try editJSON(cur.appendingPathComponent("course.json")) { $0["unitOrder"] = ["ghost-unit"] }
        let repo = try BundledContentRepository(rootDirectory: root)
        await #expect(throws: SplitCurriculumError.self) { try await repo.curriculum(courseId: "american-football", locale: "en-US") }
    }

    @Test func duplicateConceptAcrossFilesIsRejected() async throws {
        let (root, cur) = try makeSplitRoot()
        defer { try? FileManager.default.removeItem(at: root) }
        let rootObj = try JSONSerialization.jsonObject(with: Data(contentsOf: cur.appendingPathComponent("course.json"))) as! [String: Any]
        let first = (rootObj["concepts"] as! [[String: Any]])[0]
        let unitFile = try Fixtures.jsonFiles(in: cur.appendingPathComponent("units")).last!
        try editJSON(unitFile) { $0["concepts"] = [first] }
        let repo = try BundledContentRepository(rootDirectory: root)
        await #expect(throws: SplitCurriculumError.duplicateConceptId(first["id"] as! String, file: "defense-basics")) {
            try await repo.curriculum(courseId: "american-football", locale: "en-US")
        }
    }

    @Test func singleFileLayoutStillLoads() async throws {
        let repo = BundledContentRepository(locations: [.init(manifestURL: Fixtures.manifestURL, curriculumURLs: [Fixtures.curriculumURL])])
        #expect(try await repo.curriculum(courseId: "american-football", locale: "en-US").units.count == 2)
    }
}
