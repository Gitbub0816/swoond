import Foundation

public enum SplitCurriculumError: Error, Sendable, Equatable {
    case unitOrderMismatch(missingFiles: [String], unlistedUnits: [String])
    case duplicateConceptId(String, file: String)
    case duplicateUnitId(String, file: String)
    case courseIdMismatch(file: String, expected: String, actual: String)
}

/// Contract 1.1 split layout: `curriculum/course.json` (root) + `curriculum/units/<NN>-<unit-id>.json`.
/// The root carries course-wide data and `unitOrder`; each unit file carries one `Unit` and optional unit-local
/// `concepts`. Merging yields the same `Curriculum` a v1.0 single file would (units in `unitOrder`, concepts = root
/// then unit-local in unit order). Additive: files without `unitOrder` are v1.0 single-file curricula.
enum SplitCurriculum {
    static let rootFileName = "course.json"

    private struct Root: Decodable {
        var contractVersion: String
        var courseId: CourseID
        var curriculumVersion: String
        var locale: String?
        var concepts: [Concept]?
        var talkTracks: [TalkTrack]?
        var reviewPolicy: ReviewPolicy
        var unitOrder: [UnitID]
    }

    private struct UnitFile: Decodable {
        var contractVersion: String
        var courseId: CourseID
        var concepts: [Concept]?
        var unit: Unit
    }

    static func isRoot(_ data: Data) -> Bool {
        guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else { return false }
        return obj["unitOrder"] != nil
    }

    static func load(rootURL: URL, rootData: Data) throws -> Curriculum {
        let root = try JSONDecoder().decode(Root.self, from: rootData)
        let unitsDir = rootURL.deletingLastPathComponent().appendingPathComponent("units")
        let files = ((try? FileManager.default.contentsOfDirectory(at: unitsDir, includingPropertiesForKeys: nil)) ?? [])
            .filter { $0.pathExtension == "json" }
            .sorted { $0.lastPathComponent < $1.lastPathComponent }

        var byId: [UnitID: UnitFile] = [:]
        for f in files {
            let uf = try JSONDecoder().decode(UnitFile.self, from: Data(contentsOf: f))
            guard uf.courseId == root.courseId else {
                throw SplitCurriculumError.courseIdMismatch(file: f.lastPathComponent, expected: root.courseId, actual: uf.courseId)
            }
            guard byId[uf.unit.id] == nil else { throw SplitCurriculumError.duplicateUnitId(uf.unit.id, file: f.lastPathComponent) }
            byId[uf.unit.id] = uf
        }
        let missing = root.unitOrder.filter { byId[$0] == nil }
        let unlisted = byId.keys.filter { !root.unitOrder.contains($0) }.sorted()
        guard missing.isEmpty, unlisted.isEmpty else {
            throw SplitCurriculumError.unitOrderMismatch(missingFiles: missing, unlistedUnits: unlisted)
        }

        var concepts = root.concepts ?? []
        var seen = Set(concepts.map(\.id))
        for id in root.unitOrder {
            for c in byId[id]!.concepts ?? [] {
                guard seen.insert(c.id).inserted else { throw SplitCurriculumError.duplicateConceptId(c.id, file: "\(id)") }
                concepts.append(c)
            }
        }
        return Curriculum(contractVersion: root.contractVersion, courseId: root.courseId, curriculumVersion: root.curriculumVersion,
                          locale: root.locale ?? "en-US", concepts: concepts, units: root.unitOrder.map { byId[$0]!.unit },
                          talkTracks: root.talkTracks, reviewPolicy: root.reviewPolicy)
    }
}
