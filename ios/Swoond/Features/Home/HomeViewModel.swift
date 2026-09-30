import Foundation
import Observation
import SwoondCore

/// Home / Learn state for the active person: common ground, today's game, their interests.
@MainActor
@Observable
final class HomeViewModel {
    struct InterestRow: Identifiable, Equatable {
        var id: CourseID
        var name: String
        var monogram: String
        var fraction: Double
        var isMain: Bool
        var hasContent: Bool
        var nextLesson: GameLaunch.Kind?
        var percent: Int { Int((fraction * 100).rounded()) }
    }

    struct Hero: Equatable {
        var courseId: CourseID
        var eyebrow: String
        var title: String
        var subtitle: String
        var footer: String
        var kind: GameLaunch.Kind
    }

    private(set) var rows: [InterestRow] = []
    private(set) var commonGround: Double = 0
    private(set) var hero: Hero?
    private(set) var dailyBite: DailyBite?
    private(set) var reviewCount = 0
    private(set) var isLoaded = false

    var commonGroundPercent: Int { CommonGround.percent(commonGround) }
    var commonGroundLine: String { CommonGroundCopy.line(forPercent: commonGroundPercent) }

    func load(model: AppModel) async {
        guard let person = model.activePerson else {
            rows = []; hero = nil; dailyBite = nil; reviewCount = 0; commonGround = 0; isLoaded = true
            return
        }
        let env = model.env
        let now = await env.engine.now()
        // Main interest first, then the rest in the order they were picked.
        let ordered = person.interests.filter(\.isMainInterest) + person.interests.filter { !$0.isMainInterest }

        var built: [InterestRow] = []
        var coverages: [CourseID: Double] = [:]
        var heroInterest: PersonInterest?
        for interest in ordered {
            let id = interest.courseId
            var row = InterestRow(id: id, name: model.interestName(id), monogram: InterestCatalog.monogram(for: id),
                                  fraction: 0, isMain: interest.isMainInterest, hasContent: false, nextLesson: nil)
            if let curriculum = try? await env.content.curriculum(courseId: id, locale: env.locale),
               let mastery = try? await env.engine.mastery(courseId: id),
               let progress = try? await env.engine.courseProgress(personId: person.id, courseId: id) {
                let cov = CommonGround.coverage(curriculum: curriculum, mastery: mastery, branchId: interest.branchId, now: now)
                coverages[id] = cov
                row.fraction = cov
                row.hasContent = true
                if let next = LessonPlanner.nextLesson(in: curriculum, progress: progress, branchId: interest.branchId) {
                    row.nextLesson = .lesson(unitId: next.unitId, lessonId: next.lesson.id)
                }
                if heroInterest == nil { heroInterest = interest }
            }
            built.append(row)
        }
        rows = built
        commonGround = CommonGround.score(for: person, coverages: coverages)
        await loadHero(for: heroInterest, person: person, model: model)
        isLoaded = true
    }

    private func loadHero(for interest: PersonInterest?, person: Person, model: AppModel) async {
        hero = nil; dailyBite = nil; reviewCount = 0
        guard let interest else { return }
        let session = model.env.makeSession(person: person, interest: interest)
        guard let plan = try? await session.plan() else { return }
        let name = model.interestName(interest.courseId)
        reviewCount = plan.reviews.count
        if !plan.dailyBiteCompleted { dailyBite = plan.dailyBite }
        if let next = plan.nextLesson {
            let minutes = next.lesson.estimatedMinutes ?? 3
            hero = Hero(courseId: interest.courseId, eyebrow: "Today\u{2019}s game \u{B7} \(name)", title: next.lesson.title,
                        subtitle: next.lesson.objective, footer: "\(minutes) min \u{B7} +\(XPValues.finishedGame) XP",
                        kind: .lesson(unitId: next.unitId, lessonId: next.lesson.id))
        } else if !plan.reviews.isEmpty {
            hero = Hero(courseId: interest.courseId, eyebrow: "Review \u{B7} \(name)", title: "Keep it fresh.",
                        subtitle: "\(plan.reviews.count) \(plan.reviews.count == 1 ? "term is" : "terms are") due for a quick review.",
                        footer: "3 min \u{B7} +\(XPValues.finishedGame) XP", kind: .review)
        }
    }
}
