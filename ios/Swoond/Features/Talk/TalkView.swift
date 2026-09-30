import SwiftUI
import SwoondCore

/// Talk tab: conversation practice. Talk Tracks unlock as the unit that teaches their vocabulary is finished.
@MainActor
@Observable
final class TalkViewModel {
    struct TrackRow: Identifiable, Equatable {
        var id: String { "\(courseId)/\(trackId)" }
        var courseId: CourseID
        var trackId: String
        var title: String
        var interestName: String
        var isUnlocked: Bool
        var unlockHint: String?
    }

    private(set) var tracks: [TrackRow] = []
    private(set) var isLoaded = false

    func load(model: AppModel) async {
        guard let person = model.activePerson else { tracks = []; isLoaded = true; return }
        let env = model.env
        var rows: [TrackRow] = []
        for interest in person.interests {
            let id = interest.courseId
            guard let curriculum = try? await env.content.curriculum(courseId: id, locale: env.locale),
                  let progress = try? await env.engine.courseProgress(personId: person.id, courseId: id) else { continue }
            for track in curriculum.talkTracks ?? [] {
                let unlocked = LessonPlanner.isTalkTrackUnlocked(track, in: curriculum, progress: progress)
                let unitTitle = track.unlockedByUnitId.flatMap { curriculum.unit($0)?.title }
                rows.append(TrackRow(courseId: id, trackId: track.id, title: track.title, interestName: model.interestName(id),
                                     isUnlocked: unlocked, unlockHint: unlocked ? nil : unitTitle.map { "Finish \u{201C}\($0)\u{201D} to unlock" }))
            }
        }
        tracks = rows
        isLoaded = true
    }
}

struct TalkView: View {
    @Environment(AppModel.self) private var model
    @State private var vm = TalkViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: SWSpace.s16) {
                ScreenTitle(title: "Talk", subtitle: subtitle)
                    .padding(.horizontal, SWSpace.textGutter)
                if vm.tracks.isEmpty && vm.isLoaded {
                    MessageCard(title: "Talk Tracks unlock as you learn",
                                message: "Play a game and your first conversation opens up. Practice the words before you need them.", systemImage: "bubble.left.and.bubble.right")
                        .padding(.horizontal, SWSpace.cardGutter)
                }
                VStack(spacing: SWSpace.s8) {
                    ForEach(vm.tracks) { row in trackRow(row) }
                }
                .padding(.horizontal, SWSpace.cardGutter)
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

    private var subtitle: String {
        guard let name = model.activePerson?.displayName else { return "Practice the actual conversation." }
        return "Practice the conversation with \(name)."
    }

    private func trackRow(_ row: TalkViewModel.TrackRow) -> some View {
        Button {
            guard let person = model.activePerson else { return }
            model.play(GameLaunch(personId: person.id, courseId: row.courseId, kind: .talkTrack(trackId: row.trackId)))
        } label: {
            HStack(spacing: SWSpace.s14) {
                Avatar(initial: model.activePerson?.displayName ?? "?", size: 40, style: .person)
                VStack(alignment: .leading, spacing: 2) {
                    Text(row.title).font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                    Text(row.unlockHint ?? "Talk Track \u{B7} \(row.interestName)").font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                }
                Spacer()
                Image(systemName: row.isUnlocked ? "chevron.right" : "lock.fill")
                    .font(.system(size: 13, weight: .semibold)).foregroundStyle(Color.sw.ink5).accessibilityHidden(true)
            }
            .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s12)
            .frame(minHeight: SWSize.minTarget)
            .swCard(radius: SWRadius.row)
            .opacity(row.isUnlocked ? 1 : 0.6)
        }
        .buttonStyle(.plain)
        .disabled(!row.isUnlocked)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(row.title), \(row.interestName). \(row.isUnlocked ? "Ready" : (row.unlockHint ?? "Locked"))")
    }
}

#Preview("Talk") {
    PreviewHost { _ in NavigationStack { TalkView() } }
}
