import Foundation
import SwoondCore

/// Finds bundled content packs. Two folder references can be in the app bundle (see `project.yml`):
///  - `courses/`: the full authored packs from the repo's `content/courses` (optional; absent until content ships),
///  - `ContentPacks/`: a small original preview seed (nascar, pickleball, hockey) so the app is playable without it.
/// Both use `<courseId>/manifest.json` + `<courseId>/curriculum/*.json`. Earlier roots win on the same course id.
enum ContentBootstrap {
    static let folderNames = ["courses", "ContentPacks"]

    static func repository(bundle: Bundle = .main) -> any ContentRepository {
        var repos: [any ContentRepository] = []
        for name in folderNames {
            guard let root = bundle.url(forResource: name, withExtension: nil),
                  let repo = try? BundledContentRepository(rootDirectory: root) else { continue }
            repos.append(repo)
        }
        return CompositeContentRepository(repos)
    }

    /// Directories that may hold `<courseId>/assets/...` (images, audio) for exercises.
    static func assetRoots(bundle: Bundle = .main) -> [URL] {
        folderNames.compactMap { bundle.url(forResource: $0, withExtension: nil) }
    }
}

/// Resolves an exercise asset path (`images/cars/porsche.jpg`) inside the bundled packs.
enum AssetLocator {
    static func url(for asset: String, courseId: CourseID? = nil, bundle: Bundle = .main) -> URL? {
        let fm = FileManager.default
        for root in ContentBootstrap.assetRoots(bundle: bundle) {
            var courseDirs: [URL] = []
            if let courseId { courseDirs = [root.appendingPathComponent(courseId)] }
            else { courseDirs = (try? fm.contentsOfDirectory(at: root, includingPropertiesForKeys: nil)) ?? [] }
            for dir in courseDirs {
                let candidate = dir.appendingPathComponent("assets").appendingPathComponent(asset)
                if fm.fileExists(atPath: candidate.path) { return candidate }
            }
        }
        let direct = bundle.resourceURL?.appendingPathComponent(asset)
        if let direct, fm.fileExists(atPath: direct.path) { return direct }
        return nil
    }
}
