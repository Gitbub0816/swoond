import Foundation
import Testing
@testable import SwoondCore

@Suite("Bundled content pack (content/courses)")
struct BundledPackTests {
    @Test func everyIncludedCourseDecodesWithFullLessons() async throws {
        let root = Fixtures.repoRoot.appendingPathComponent("content/courses")
        guard FileManager.default.fileExists(atPath: root.path) else { return } // pack not generated: skip
        let repo = try BundledContentRepository(rootDirectory: root)
        let index = try await repo.courseIndex()
        #expect(!index.isEmpty)
        for s in index {
            _ = try await repo.manifest(courseId: s.courseId)
            let cur = try await repo.curriculum(courseId: s.courseId, locale: "en-US")
            #expect(!cur.units.isEmpty, "\(s.courseId) has no units")
            for u in cur.units { for l in u.lessons {
                #expect(l.activities.count >= 4, "\(s.courseId)/\(l.id) has \(l.activities.count) activities")
            } }
        }
    }
}
