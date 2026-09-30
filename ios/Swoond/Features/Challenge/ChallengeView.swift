import SwiftUI
import SwoondCore

/// Friend challenge (design 3e): head to head on the same questions. Accepting starts a game for that interest;
/// Results resolves it (higher score wins, faster time breaks a tie; the winner gets +80 XP).
struct ChallengeView: View {
    var challenge: FriendChallenge
    @Environment(AppModel.self) private var model
    @State private var message: String?
    @State private var isStarting = false

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: SWSpace.s12) {
                        Eyebrow("Challenge received", color: Color.sw.accentSoft)
                        Text.emphasized("\(challenge.fromName) thinks they know ", challenge.interestName.lowercased(), " better.", size: 40)
                            .font(SWFont.display(40, relativeTo: .largeTitle))
                            .foregroundStyle(Color.sw.ink)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .accessibilityAddTraits(.isHeader)
                    }
                    .padding(.horizontal, SWSpace.s24).padding(.top, SWSpace.s32)

                    HStack(alignment: .center, spacing: SWSpace.s10) {
                        fighter(name: "You", level: model.learner.level, initial: model.settings.learnerName ?? "You", ring: false)
                        Text("vs").font(SWFont.display(28, italic: true, relativeTo: .title2)).foregroundStyle(Color.sw.ink5)
                        fighter(name: challenge.fromName, level: challenge.fromLevel, initial: challenge.fromName, ring: true)
                    }
                    .padding(.horizontal, SWSpace.s24).padding(.top, SWSpace.s28)
                    .accessibilityElement(children: .combine)

                    VStack(spacing: SWSpace.s10) {
                        detail("Format", challenge.formatLine)
                        detail("\(challenge.fromName)\u{2019}s score", challenge.scoreLine)
                        detail("Winner gets", "+\(challenge.prizeXP) XP", valueColor: Color.sw.reward)
                    }
                    .padding(SWSpace.s18)
                    .swCard(radius: SWRadius.card)
                    .padding(.horizontal, SWSpace.cardGutter).padding(.top, SWSpace.s28)

                    if let message {
                        Text(message).font(SWText.caption).foregroundStyle(Color.sw.accentSoft).multilineTextAlignment(.center)
                            .padding(.horizontal, SWSpace.s24).padding(.top, SWSpace.s16)
                    }
                }
            }
            .scrollBounceBehavior(.basedOnSize)

            VStack(spacing: SWSpace.s10) {
                GameButton(isStarting ? "Setting up\u{2026}" : "Accept challenge") { Task { await accept() } }.disabled(isStarting)
                SecondaryButton("Not now") { model.dismissFullScreen() }
            }
            .padding(.horizontal, SWSpace.s20)
            .padding(.bottom, SWSize.ctaBottom)
        }
        .background(Color.sw.accentGlow.ignoresSafeArea())
        .swBackground()
    }

    private func fighter(name: String, level: Int, initial: String, ring: Bool) -> some View {
        VStack(spacing: SWSpace.s8) {
            Avatar(initial: initial, size: 76, style: ring ? .ring : .plain)
            Text(name).font(SWFont.ui(14, weight: .semibold)).foregroundStyle(Color.sw.ink)
            Text("Lvl \(level)").font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
        }
        .frame(maxWidth: .infinity)
    }

    private func detail(_ label: String, _ value: String, valueColor: Color = Color.sw.ink) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(label).font(SWText.body).foregroundStyle(Color.sw.ink3)
            Spacer(minLength: SWSpace.s12)
            Text(value).font(SWText.body).foregroundStyle(valueColor).multilineTextAlignment(.trailing)
        }
        .accessibilityElement(children: .combine)
    }

    /// Starts the first playable lesson of the challenge's interest and hands the challenge to the session.
    private func accept() async {
        guard let person = model.activePerson else { return }
        isStarting = true
        defer { isStarting = false }
        let env = model.env
        let interest = person.interest(for: challenge.courseId) ?? PersonInterest(courseId: challenge.courseId)
        guard let curriculum = try? await env.content.curriculum(courseId: challenge.courseId, locale: env.locale) else {
            message = "We don\u{2019}t have \(challenge.interestName.lowercased()) games on this phone yet. Ask \(challenge.fromName) for a rematch soon."
            return
        }
        let progress = (try? await env.engine.courseProgress(personId: person.id, courseId: challenge.courseId))
            ?? CourseProgress(personId: person.id, courseId: challenge.courseId)
        // Prefer the next unfinished lesson; otherwise replay the first one.
        let target = LessonPlanner.nextLesson(in: curriculum, progress: progress, branchId: interest.branchId).map { ($0.unitId, $0.lesson.id) }
            ?? curriculum.allLessons.first.map { ($0.unit.id, $0.lesson.id) }
        guard let (unitId, lessonId) = target else {
            message = "There\u{2019}s nothing to play in that interest yet."
            return
        }
        var launch = GameLaunch(personId: person.id, courseId: challenge.courseId, kind: .lesson(unitId: unitId, lessonId: lessonId))
        launch.challenge = challenge
        model.play(launch)
    }
}

#Preview("Challenge") {
    PreviewHost { _ in ChallengeView(challenge: .sample) }
}
