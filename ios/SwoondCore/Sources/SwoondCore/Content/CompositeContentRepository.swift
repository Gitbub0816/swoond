import Foundation

/// Merges several content repositories (e.g. the full `content/courses` bundle plus a small preview seed).
/// Earlier repositories win when two provide the same course id.
public struct CompositeContentRepository: ContentRepository {
    public var repositories: [any ContentRepository]
    public init(_ repositories: [any ContentRepository]) { self.repositories = repositories }

    public func courseIndex() async throws -> [CourseSummary] {
        var seen = Set<CourseID>()
        var out: [CourseSummary] = []
        for r in repositories {
            for s in (try? await r.courseIndex()) ?? [] where seen.insert(s.courseId).inserted { out.append(s) }
        }
        return out
    }

    public func manifest(courseId: CourseID) async throws -> CourseManifest {
        for r in repositories { if let m = try? await r.manifest(courseId: courseId) { return m } }
        throw ContentError.courseNotFound(courseId)
    }

    public func curriculum(courseId: CourseID, locale: String) async throws -> Curriculum {
        for r in repositories { if let c = try? await r.curriculum(courseId: courseId, locale: locale) { return c } }
        throw ContentError.courseNotFound(courseId)
    }
}
