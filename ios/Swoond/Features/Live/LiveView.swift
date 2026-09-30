import SwiftUI
import SwoondCore

@MainActor
@Observable
final class LiveViewModel {
    private(set) var snapshot: LiveSnapshot?
    private(set) var courseName = ""
    private(set) var isLoaded = false
    private(set) var failed = false

    func load(model: AppModel) async {
        guard let person = model.activePerson else { snapshot = nil; isLoaded = true; return }
        // Main interest first.
        let ordered = person.interests.filter(\.isMainInterest) + person.interests.filter { !$0.isMainInterest }
        for interest in ordered {
            let result = try? await LiveCompanion.snapshot(courseId: interest.courseId, personalization: interest.personalization, provider: model.env.live)
            if let snap = result {
                snapshot = snap
                courseName = model.interestName(interest.courseId)
                failed = false
                isLoaded = true
                return
            }
        }
        snapshot = nil
        isLoaded = true
    }
}

/// Live companion (design 3a): the score, one line to say right now, and a plain-English play-by-play.
struct LiveView: View {
    @Environment(AppModel.self) private var model
    @State private var vm = LiveViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if let snap = vm.snapshot {
                    scoreCard(snap)
                    sayThisCard(snap)
                    Eyebrow("What just happened")
                        .padding(.horizontal, SWSpace.textGutter).padding(.top, 20).padding(.bottom, SWSpace.s8)
                    VStack(spacing: SWSpace.s8) {
                        ForEach(snap.moments) { moment in momentCard(moment) }
                    }
                    .padding(.horizontal, SWSpace.cardGutter)
                    Text("Play-by-play is sample data in this build.")
                        .font(SWText.captionSmall).foregroundStyle(Color.sw.ink5)
                        .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s16)
                } else if vm.isLoaded {
                    ScreenTitle(title: "Live", subtitle: "Nothing on right now.")
                        .padding(.horizontal, SWSpace.textGutter).padding(.top, SWSpace.s8)
                    MessageCard(title: "No live games", message: "When something they follow is on, we\u{2019}ll translate it into plain English here.",
                                systemImage: "dot.radiowaves.left.and.right")
                        .padding(.horizontal, SWSpace.cardGutter).padding(.top, SWSpace.s16)
                }
            }
            .padding(.top, SWSpace.s8)
            .padding(.bottom, SWSize.tabBarClearance)
        }
        .scrollBounceBehavior(.basedOnSize)
        .swBackground()
        .toolbar(.hidden, for: .navigationBar)
        .task(id: model.activePerson?.id) { await vm.load(model: model) }
    }

    private func scoreCard(_ snap: LiveSnapshot) -> some View {
        VStack(spacing: SWSpace.s14) {
            HStack {
                HStack(spacing: SWSpace.s6) {
                    if snap.isLive { Circle().fill(Color.sw.accent).frame(width: 7, height: 7).accessibilityHidden(true) }
                    Text(snap.isLive ? "Live \u{B7} \(vm.courseName)" : "\(snap.competition) \u{B7} \(vm.courseName)")
                }
                .font(SWText.eyebrow).tracking(1.54).textCase(.uppercase).foregroundStyle(Color.sw.accentSoft)
                Spacer()
                Text(snap.periodLabel).font(SWText.eyebrow).tracking(1.54).textCase(.uppercase).foregroundStyle(Color.sw.ink4)
            }
            HStack(alignment: .center) {
                teamLabel(snap.homeName, isFavorite: snap.favoriteIsHome, alignment: .leading)
                Spacer(minLength: SWSpace.s8)
                Text("\(snap.homeScore) \(Text(verbatim: "\u{2013}").foregroundStyle(Color.sw.ink5)) \(snap.awayScore)")
                    .font(SWFont.display(52, relativeTo: .largeTitle)).foregroundStyle(Color.sw.ink)
                    .minimumScaleFactor(0.6).lineLimit(1)
                Spacer(minLength: SWSpace.s8)
                teamLabel(snap.awayName, isFavorite: snap.favoriteIsAway, alignment: .trailing)
            }
        }
        .padding(.horizontal, 20).padding(.vertical, SWSpace.s18)
        .swCard(radius: SWRadius.hero)
        .padding(.horizontal, SWSpace.cardGutter)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(snap.isLive ? "Live" : snap.periodLabel). \(snap.homeName) \(snap.homeScore), \(snap.awayName) \(snap.awayScore). \(snap.periodLabel)")
    }

    private func teamLabel(_ name: String, isFavorite: Bool, alignment: HorizontalAlignment) -> some View {
        VStack(alignment: alignment, spacing: 2) {
            Text(name).font(SWText.caption).foregroundStyle(Color.sw.ink3).lineLimit(2)
            if isFavorite, let person = model.activePerson {
                Text("\(person.displayName)\u{2019}s team").font(SWFont.ui(11, relativeTo: .caption)).foregroundStyle(Color.sw.accentSoft)
            }
        }
        .frame(maxWidth: 96, alignment: alignment == .leading ? .leading : .trailing)
    }

    private func sayThisCard(_ snap: LiveSnapshot) -> some View {
        VStack(alignment: .leading, spacing: SWSpace.s6) {
            Eyebrow("Say this now", color: Color.sw.accentSoft)
            Text(snap.sayThisNow).font(SWText.displayS(22)).lineSpacing(2).foregroundStyle(Color.sw.ink)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, SWSpace.s18).padding(.vertical, SWSpace.s16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .swHeroCard(radius: SWRadius.cardLarge)
        .padding(.horizontal, SWSpace.cardGutter)
        .padding(.top, SWSpace.s14)
    }

    private func momentCard(_ moment: LiveMoment) -> some View {
        VStack(alignment: .leading, spacing: SWSpace.s4) {
            HStack {
                Text(moment.label).foregroundStyle(moment.isHighlighted ? Color.sw.reward : Color.sw.ink4)
                Spacer()
                Text(moment.clock).foregroundStyle(Color.sw.ink4)
            }
            .font(SWText.captionSmall)
            Text(moment.headline).font(SWFont.ui(15, weight: .semibold)).foregroundStyle(Color.sw.ink).padding(.top, 2)
            Text(moment.explanation).font(SWText.caption).lineSpacing(3).foregroundStyle(Color.sw.ink3).fixedSize(horizontal: false, vertical: true)
        }
        .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .swCard(radius: SWRadius.row)
        .accessibilityElement(children: .combine)
    }
}

#Preview("Live") {
    PreviewHost { _ in NavigationStack { LiveView() } }
}
