import Foundation

public protocol ContentRepository: Sendable {
    func courseIndex() async throws -> [CourseSummary]
    func manifest(courseId: CourseID) async throws -> CourseManifest
    func curriculum(courseId: CourseID, locale: String) async throws -> Curriculum
}

/// Loads course manifests and curriculum JSON from disk.
///
/// Standard layout (mirrors `content/courses/<id>/` and `docs/courses/<id>/`):
/// ```
/// <root>/<courseId>/manifest.json
/// <root>/<courseId>/curriculum/*.json      (one file per locale; or curriculum.json)
/// ```
/// Contract 1.1 split layout: `curriculum/course.json` (root with `unitOrder`) plus
/// `curriculum/units/<NN>-<unit-id>.json`; it is merged into one `Curriculum` (see `SplitCurriculum`).
/// For flat sample folders use `init(locations:)`.
public struct BundledContentRepository: ContentRepository {
    public struct Location: Sendable, Hashable {
        public var manifestURL: URL
        public var curriculumURLs: [URL]
        public init(manifestURL: URL, curriculumURLs: [URL]) { self.manifestURL = manifestURL; self.curriculumURLs = curriculumURLs }
    }

    private let locations: [Location]

    public init(locations: [Location]) { self.locations = locations }

    /// Discover `<root>/<courseId>/manifest.json` folders.
    public init(rootDirectory: URL) throws {
        let fm = FileManager.default
        let dirs = try fm.contentsOfDirectory(at: rootDirectory, includingPropertiesForKeys: [.isDirectoryKey])
            .filter { (try? $0.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }
        var found: [Location] = []
        for d in dirs {
            let manifest = d.appendingPathComponent("manifest.json")
            guard fm.fileExists(atPath: manifest.path) else { continue }
            var curricula: [URL] = []
            let sub = d.appendingPathComponent("curriculum")
            let splitRoot = sub.appendingPathComponent(SplitCurriculum.rootFileName)
            if fm.fileExists(atPath: splitRoot.path) {
                curricula.append(splitRoot) // split layout: unit files are read by the merge, never listed on their own
            } else if let files = try? fm.contentsOfDirectory(at: sub, includingPropertiesForKeys: nil) {
                curricula += files.filter { $0.pathExtension == "json" }.sorted { $0.lastPathComponent < $1.lastPathComponent }
            }
            let single = d.appendingPathComponent("curriculum.json")
            if fm.fileExists(atPath: single.path) { curricula.append(single) }
            found.append(Location(manifestURL: manifest, curriculumURLs: curricula))
        }
        self.locations = found
    }

    public func courseIndex() async throws -> [CourseSummary] {
        try locations.map { try Self.loadManifest($0.manifestURL).summary }
    }

    public func manifest(courseId: CourseID) async throws -> CourseManifest {
        for loc in locations {
            let m = try Self.loadManifest(loc.manifestURL)
            if m.courseId == courseId { return m }
        }
        throw ContentError.courseNotFound(courseId)
    }

    public func curriculum(courseId: CourseID, locale: String) async throws -> Curriculum {
        for loc in locations {
            let m = try Self.loadManifest(loc.manifestURL)
            guard m.courseId == courseId else { continue }
            let all = try loc.curriculumURLs.map { try Self.loadCurriculum($0) }.filter { $0.courseId == courseId }
            guard !all.isEmpty else { throw ContentError.curriculumNotFound(courseId) }
            return Self.best(all, for: locale)
        }
        throw ContentError.courseNotFound(courseId)
    }

    /// Exact locale, then same language, then first.
    static func best(_ all: [Curriculum], for locale: String) -> Curriculum {
        let want = locale.lowercased()
        if let exact = all.first(where: { $0.locale.lowercased() == want }) { return exact }
        let lang = want.split(separator: "-").first.map(String.init) ?? want
        if let same = all.first(where: { $0.locale.lowercased().split(separator: "-").first.map(String.init) == lang }) { return same }
        return all[0]
    }

    static func loadManifest(_ url: URL) throws -> CourseManifest { try load(CourseManifest.self, url) }
    /// Loads a single-file (v1.0) curriculum, or merges a split (v1.1) one when `url` is its `course.json` root.
    static func loadCurriculum(_ url: URL) throws -> Curriculum {
        guard FileManager.default.fileExists(atPath: url.path) else { throw ContentError.fileMissing(url.path) }
        let data = try Data(contentsOf: url)
        if SplitCurriculum.isRoot(data) { return try SplitCurriculum.load(rootURL: url, rootData: data) }
        return try JSONDecoder().decode(Curriculum.self, from: data)
    }

    private static func load<T: Decodable>(_ type: T.Type, _ url: URL) throws -> T {
        guard FileManager.default.fileExists(atPath: url.path) else { throw ContentError.fileMissing(url.path) }
        return try JSONDecoder().decode(T.self, from: Data(contentsOf: url))
    }
}

/// In-memory repository for tests and previews.
public struct StaticContentRepository: ContentRepository {
    public var manifests: [CourseManifest]
    public var curricula: [Curriculum]
    public init(manifests: [CourseManifest] = [], curricula: [Curriculum]) { self.manifests = manifests; self.curricula = curricula }

    public func courseIndex() async throws -> [CourseSummary] { manifests.map(\.summary) }
    public func manifest(courseId: CourseID) async throws -> CourseManifest {
        guard let m = manifests.first(where: { $0.courseId == courseId }) else { throw ContentError.courseNotFound(courseId) }
        return m
    }
    public func curriculum(courseId: CourseID, locale: String) async throws -> Curriculum {
        let all = curricula.filter { $0.courseId == courseId }
        guard !all.isEmpty else { throw ContentError.courseNotFound(courseId) }
        return BundledContentRepository.best(all, for: locale)
    }
}
