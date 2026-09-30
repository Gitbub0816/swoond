import Foundation
import Observation
import SwoondCore

/// Games hub state: every lesson ("game") for the active person's interests, plus review and a pending challenge.
@MainActor
@Observable
final class GamesViewModel {
    enum Status: Equatable { case available, completed, locked }

    struct GameRow: Identifiable, Equatable {
        var id: String { "\(courseId)/\(lessonId)" }
        var courseId: CourseID
        var unitId: UnitID
        var lessonId: LessonID
        var title: String
        var objective: String
        var minutes: Int
        var typesLabel: String
        var status: Status
        var hasSimulation: Bool
    }

    struct Section: Identifiable, Equatable {
        var id: CourseID
        var name: String
        var rows: [GameRow]
    }

    private(set) var sections: [Section] = []
    private(set) var reviewCount = 0
    private(set) var reviewCourseId: CourseID?
    private(set) var challenge: FriendChallenge?
    private(set) var isLoaded = false

    func load(model: AppModel) async {
        guard let person = model.activePerson else { sections = []; isLoaded = true; return }
        let env = model.env
        var built: [Section] = []
        var reviews = 0
        var reviewCourse: CourseID?
        for interest in person.interests {
            let id = interest.courseId
            guard let curriculum = try? await env.content.curriculum(courseId: id, locale: env.locale),
                  let progress = try? await env.engine.courseProgress(personId: person.id, courseId: id) else { continue }
            var rows: [GameRow] = []
            for unit in LessonPlanner.orderedUnits(curriculum, branchId: interest.branchId) {
                let unlocked = LessonPlanner.isUnlocked(unit, in: curriculum, progress: progress)
                for lesson in unit.lessons {
                    let types = lesson.activities.map(\.type).reduce(into: [ActivityType]()) { if !$0.contains($1) { $0.append($1) } }
                    rows.append(GameRow(
                        courseId: id, unitId: unit.id, lessonId: lesson.id, title: lesson.title, objective: lesson.objective,
                        minutes: lesson.estimatedMinutes ?? 3, typesLabel: types.prefix(3).map(\.displayName).joined(separator: " \u{B7} "),
                        status: progress.isLessonComplete(lesson.id) ? .completed : (unlocked ? .available : .locked),
                        hasSimulation: types.contains(.unitySim)))
                }
            }
            built.append(Section(id: id, name: model.interestName(id), rows: rows))
            if let mastery = try? await env.engine.mastery(courseId: id) {
                let due = LessonPlanner.dueReviews(in: curriculum, mastery: mastery, now: await env.engine.now())
                if !due.isEmpty && reviewCourse == nil { reviews = due.count; reviewCourse = id }
            }
        }
        sections = built
        reviewCount = reviews
        reviewCourseId = reviewCourse
        challenge = (try? await env.challenges.pendingChallenge()).flatMap { $0 }
        isLoaded = true
    }
}
