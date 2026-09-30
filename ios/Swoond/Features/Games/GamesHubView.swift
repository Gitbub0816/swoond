import SwiftUI
import SwoondCore

/// Games tab: every game (lesson) for the active person's interests, review, and friend challenges.
struct GamesHubView: View {
    @Environment(AppModel.self) private var model
    @State private var vm = GamesViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SWSpace.s16) {
                ScreenTitle(title: "Games", subtitle: "Each one takes about 3 minutes.")
                    .padding(.horizontal, SWSpace.textGutter)

                if let challenge = vm.challenge { challengeCard(challenge) }
                if vm.reviewCount > 0, let courseId = vm.reviewCourseId, let person = model.activePerson { reviewCard(courseId: courseId, person: person) }

                if vm.sections.isEmpty && vm.isLoaded {
                    MessageCard(title: "No games yet", message: "Pick some interests and we\u{2019}ll fill this up.")
                        .padding(.horizontal, SWSpace.cardGutter)
                }
                ForEach(vm.sections) { section in
                    VStack(alignment: .leading, spacing: SWSpace.s10) {
                        Eyebrow(section.name).padding(.horizontal, SWSpace.textGutter)
                        VStack(spacing: SWSpace.s8) {
                            ForEach(section.rows) { row in gameRow(row) }
                        }
                        .padding(.horizontal, SWSpace.cardGutter)
                    }
                }
            }
            .padding(.top, SWSpace.s8)
            .padding(.bottom, SWSize.tabBarClearance)
        }
        .scrollBounceBehavior(.basedOnSize)
        .swBackground()
        .toolbar(.hidden, for: .navigationBar)
        .task(id: model.activePerson?.id) { await vm.load(model: model) }
        .task(id: model.learner) { await vm.load(model: model) }
    }

    private func gameRow(_ row: GamesViewModel.GameRow) -> some View {
        Button {
            guard let person = model.activePerson else { return }
            model.play(GameLaunch(personId: person.id, courseId: row.courseId, kind: .lesson(unitId: row.unitId, lessonId: row.lessonId)))
        } label: {
            HStack(spacing: SWSpace.s14) {
                VStack(alignment: .leading, spacing: SWSpace.s4) {
                    Text(row.title).font(SWText.bodyL).foregroundStyle(Color.sw.ink).multilineTextAlignment(.leading)
                    Text(row.objective).font(SWText.captionSmall).foregroundStyle(Color.sw.ink3).multilineTextAlignment(.leading)
                    Text("\(row.minutes) min \u{B7} +\(XPValues.finishedGame) XP \u{B7} \(row.typesLabel)")
                        .font(SWFont.ui(11, relativeTo: .caption)).foregroundStyle(Color.sw.ink4).multilineTextAlignment(.leading)
                }
                Spacer(minLength: SWSpace.s8)
                statusIcon(row.status)
            }
            .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
            .frame(maxWidth: .infinity, minHeight: SWSize.minTarget, alignment: .leading)
            .swCard(radius: SWRadius.row)
            .opacity(row.status == .locked ? 0.55 : 1)
        }
        .buttonStyle(.plain)
        .disabled(row.status == .locked)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(row.title). \(row.objective). \(row.minutes) minutes. \(statusText(row.status))")
    }

    @ViewBuilder
    private func statusIcon(_ status: GamesViewModel.Status) -> some View {
        switch status {
        case .available: Image(systemName: "play.fill").foregroundStyle(Color.sw.accent).accessibilityHidden(true)
        case .completed: Image(systemName: "checkmark.circle.fill").foregroundStyle(Color.sw.reward).accessibilityHidden(true)
        case .locked: Image(systemName: "lock.fill").foregroundStyle(Color.sw.ink5).accessibilityHidden(true)
        }
    }

    private func statusText(_ status: GamesViewModel.Status) -> String {
        switch status { case .available: return "Ready to play"; case .completed: return "Completed"; case .locked: return "Locked until you finish the earlier lessons" }
    }

    private func reviewCard(courseId: CourseID, person: Person) -> some View {
        Button {
            model.play(GameLaunch(personId: person.id, courseId: courseId, kind: .review))
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: SWSpace.s4) {
                    Eyebrow("Review", color: Color.sw.reward)
                    Text("\(vm.reviewCount) \(vm.reviewCount == 1 ? "term is" : "terms are") due").font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                    Text("A quick round keeps them fresh.").font(SWText.captionSmall).foregroundStyle(Color.sw.ink3)
                }
                Spacer()
                Image(systemName: "chevron.right").font(.system(size: 13, weight: .semibold)).foregroundStyle(Color.sw.ink5)
            }
            .padding(.horizontal, SWSpace.s18).padding(.vertical, SWSpace.s14)
            .swCard(radius: SWRadius.row)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, SWSpace.cardGutter)
    }

    private func challengeCard(_ challenge: FriendChallenge) -> some View {
        Button {
            model.fullScreen = .challenge(challenge)
        } label: {
            HStack(spacing: SWSpace.s12) {
                Avatar(initial: challenge.fromName, size: 40, style: .ring)
                VStack(alignment: .leading, spacing: 2) {
                    Eyebrow("Challenge received", color: Color.sw.accentSoft)
                    Text("\(challenge.fromName) thinks they know \(challenge.interestName.lowercased()) better.")
                        .font(SWText.bodyL).foregroundStyle(Color.sw.ink).multilineTextAlignment(.leading)
                }
                Spacer(minLength: 0)
            }
            .padding(.horizontal, SWSpace.s18).padding(.vertical, SWSpace.s14)
            .swHeroCard(radius: SWRadius.card)
        }
        .buttonStyle(.plain)
        .padding(.horizontal, SWSpace.cardGutter)
    }
}

#Preview("Games") {
    PreviewHost { _ in NavigationStack { GamesHubView() } }
}
