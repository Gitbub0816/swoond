import SwiftUI
import SwoondCore

@MainActor
@Observable
final class ProfileViewModel {
    private(set) var stats = LearnerStats()
    private(set) var gamesPlayed = 0
    private(set) var unlocked: Set<String> = []

    func load(model: AppModel) async {
        let env = model.env
        let now = await env.engine.now()
        var games = 0, mastered = 0, met = 0, talks = 0
        var seenCourses = Set<CourseID>()
        for person in model.people {
            for interest in person.interests {
                let id = interest.courseId
                if let progress = try? await env.engine.courseProgress(personId: person.id, courseId: id) { games += progress.lessonResults.count }
                guard seenCourses.insert(id).inserted else { continue }
                guard let curriculum = try? await env.content.curriculum(courseId: id, locale: env.locale),
                      let mastery = try? await env.engine.mastery(courseId: id) else { continue }
                mastered += mastery.masteredConceptIds(now: now, policy: curriculum.reviewPolicy).count
                met += mastery.concepts.values.filter { $0.attempts > 0 }.count
                // Talk Tracks finished = completed lessons that contain a talk-track activity (any person).
                let talkLessons = Set(curriculum.allLessons.filter { $0.lesson.activities.contains { $0.type == .talkTrack } }.map(\.lesson.id))
                for person2 in model.people {
                    if let p = try? await env.engine.courseProgress(personId: person2.id, courseId: id) {
                        talks += talkLessons.filter { p.isLessonComplete($0) }.count
                    }
                }
            }
        }
        let learner = model.learner
        stats = LearnerStats(streak: learner.streak, longestStreak: learner.longestStreak, totalXP: learner.totalXP, level: learner.level,
                             gamesPlayed: games, conceptsMastered: mastered, conceptsMet: met, talkTracksDone: talks,
                             challengesWon: 0, interests: seenCourses.count)
        gamesPlayed = games
        unlocked = BadgeCatalog.unlockedIds(for: stats)
    }
}

/// Me tab root (design 3d): avatar, name, level, three stats, badges. League and Settings hang off this screen.
struct ProfileView: View {
    @Binding var path: [MeRoute]
    @Environment(AppModel.self) private var model
    @State private var vm = ProfileViewModel()
    @State private var isEditingName = false
    @State private var draftName = ""

    private var displayName: String { model.settings.learnerName ?? "You" }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                header
                statsRow
                SectionHeader(title: "Badges", trailing: "\(vm.unlocked.count) / \(BadgeCatalog.all.count)")
                    .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s24).padding(.bottom, SWSpace.s12)
                badgeGrid
                links
            }
            .padding(.top, SWSpace.s10)
            .padding(.bottom, SWSize.tabBarClearance)
        }
        .scrollBounceBehavior(.basedOnSize)
        .swBackground()
        .toolbar(.hidden, for: .navigationBar)
        .task(id: model.learner) { await vm.load(model: model) }
        .alert("What should we call you?", isPresented: $isEditingName) {
            TextField("Your name", text: $draftName)
            Button("Save") {
                let trimmed = draftName.trimmingCharacters(in: .whitespacesAndNewlines)
                model.updateSettings { $0.learnerName = trimmed.isEmpty ? nil : trimmed }
            }
            Button("Cancel", role: .cancel) {}
        }
    }

    private var header: some View {
        HStack(spacing: SWSpace.s16) {
            Avatar(initial: displayName, size: 72)
            VStack(alignment: .leading, spacing: SWSpace.s6) {
                Text(displayName).swDisplay(30, lineHeight: 1, relativeTo: .title).foregroundStyle(Color.sw.ink).lineLimit(1)
                Text("Level \(model.learner.level)\(joinedText)").font(SWText.caption).foregroundStyle(Color.sw.ink3)
            }
            Spacer()
            Button("Edit") {
                draftName = model.settings.learnerName ?? ""
                isEditingName = true
            }
            .font(SWText.caption).foregroundStyle(Color.sw.ink3)
            .frame(minWidth: SWSize.minTarget, minHeight: SWSize.minTarget)
        }
        .padding(.horizontal, SWSpace.textGutter)
    }

    private var joinedText: String {
        guard let joined = model.settings.joinedAt else { return "" }
        return " \u{B7} Joined \(joined.formatted(.dateTime.month(.wide)))"
    }

    private var statsRow: some View {
        HStack(spacing: SWSpace.s8) {
            StatTile(value: "\(model.learner.streak)", label: "day streak", style: .reward)
            StatTile(value: model.learner.totalXP.formatted(), label: "total XP")
            StatTile(value: "\(vm.gamesPlayed)", label: "games played")
        }
        .padding(.horizontal, SWSpace.cardGutter).padding(.top, SWSpace.s22)
    }

    private var badgeGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: SWSpace.s10), count: 3), spacing: SWSpace.s10) {
            ForEach(BadgeCatalog.all) { badge in
                BadgeTile(name: badge.name, monogram: badge.monogram, isUnlocked: vm.unlocked.contains(badge.id))
            }
        }
        .padding(.horizontal, SWSpace.cardGutter)
    }

    private var links: some View {
        VStack(spacing: 0) {
            link("League", detail: "Weekly XP race", route: .league)
            Divider().overlay(Color.sw.stroke)
            link("Settings", detail: "People, appearance, reminders", route: .settings)
        }
        .swCard(radius: SWRadius.card)
        .padding(.horizontal, SWSpace.cardGutter).padding(.top, SWSpace.s24)
    }

    private func link(_ title: String, detail: String, route: MeRoute) -> some View {
        Button { path.append(route) } label: {
            ChevronRow {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title).font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                    Text(detail).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview("Profile") {
    PreviewHost { _ in NavigationStack { ProfileView(path: .constant([])) } }
}
