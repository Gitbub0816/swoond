import Foundation

public struct ContentIssue: Sendable, Equatable, CustomStringConvertible {
    public enum Severity: String, Sendable { case error, warning }
    public var severity: Severity
    public var path: String
    public var message: String
    public var description: String { "[\(severity.rawValue)] \(path): \(message)" }
}

/// Native-side sanity checks (the authoritative validation is `tools/validate` in CI): unique ids, concept and
/// prerequisite references, and that every native payload decodes into its exercise type.
public enum ContentValidator {
    public static func validate(_ c: Curriculum) -> [ContentIssue] {
        var issues: [ContentIssue] = []
        func err(_ p: String, _ m: String) { issues.append(ContentIssue(severity: .error, path: p, message: m)) }

        let conceptIds = Set(c.concepts.map(\.id))
        if conceptIds.count != c.concepts.count { err("concepts", "duplicate concept ids") }
        for concept in c.concepts { for r in concept.relatedConceptIds ?? [] where !conceptIds.contains(r) { err("concepts.\(concept.id)", "unknown related concept \(r)") } }

        let unitIds = Set(c.units.map(\.id))
        if unitIds.count != c.units.count { err("units", "duplicate unit ids") }
        var lessonIds = Set<String>(), activityIds = Set<String>()
        for u in c.units {
            for p in u.prerequisiteUnitIds ?? [] where !unitIds.contains(p) { err("units.\(u.id)", "unknown prerequisite unit \(p)") }
            for l in u.lessons {
                let lp = "units.\(u.id).lessons.\(l.id)"
                if !lessonIds.insert(l.id).inserted { err(lp, "duplicate lesson id") }
                for cid in l.conceptIds where !conceptIds.contains(cid) { err(lp, "unknown concept \(cid)") }
                for a in l.activities {
                    let ap = "\(lp).activities.\(a.id)"
                    if !activityIds.insert(a.id).inserted { err(ap, "duplicate activity id") }
                    for cid in a.conceptIds where !conceptIds.contains(cid) { err(ap, "unknown concept \(cid)") }
                    if a.type == .unitySim {
                        do { _ = try a.simulationPayload() } catch { err(ap, "invalid unity-sim payload: \(error)") }
                    } else {
                        do { _ = try ExerciseSessionFactory.make(for: a) } catch { err(ap, "payload does not decode as \(a.type.rawValue): \(error)") }
                    }
                }
            }
        }
        for t in c.talkTracks ?? [] {
            if let u = t.unlockedByUnitId, !unitIds.contains(u) { err("talkTracks.\(t.id)", "unknown unlockedByUnitId \(u)") }
            for cid in t.conceptIds where !conceptIds.contains(cid) { err("talkTracks.\(t.id)", "unknown concept \(cid)") }
            do { _ = try t.exercisePayload() } catch { err("talkTracks.\(t.id)", "payload does not decode as talk-track: \(error)") }
        }
        if c.reviewPolicy.intervalsDays != c.reviewPolicy.intervalsDays.sorted() { err("reviewPolicy.intervalsDays", "must be ascending") }
        return issues
    }

    /// Manifest/curriculum cross-check: foundational module ids are unit ids, versions and courseIds agree.
    public static func validate(manifest m: CourseManifest, curriculum c: Curriculum) -> [ContentIssue] {
        var issues: [ContentIssue] = []
        if m.courseId != c.courseId { issues.append(.init(severity: .error, path: "courseId", message: "manifest \(m.courseId) != curriculum \(c.courseId)")) }
        if m.curriculumVersion != c.curriculumVersion { issues.append(.init(severity: .warning, path: "curriculumVersion", message: "manifest \(m.curriculumVersion) != curriculum \(c.curriculumVersion)")) }
        let unitIds = Set(c.units.map(\.id))
        for f in m.foundationalModules where !unitIds.contains(f.id) {
            issues.append(.init(severity: .error, path: "foundationalModules.\(f.id)", message: "no such unit in curriculum"))
        }
        return issues
    }
}
