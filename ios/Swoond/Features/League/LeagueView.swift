import SwiftUI
import SwoondCore

@MainActor
@Observable
final class LeagueViewModel {
    private(set) var snapshot: LeagueSnapshot?

    func load(model: AppModel) async {
        let env = model.env
        let weekly = (try? await env.engine.weeklyXP()) ?? 0
        let now = await env.engine.now()
        let name = model.settings.learnerName ?? "You"
        snapshot = LeagueBoard.snapshot(learnerName: name, learnerWeeklyXP: weekly, now: now, timeZone: env.timeZone)
    }
}

/// League (design 3c): weekly XP race, the top 5 promote. Rivals are placeholders until a social backend exists.
struct LeagueView: View {
    @Environment(AppModel.self) private var model
    @State private var vm = LeagueViewModel()

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if let league = vm.snapshot {
                    crest(league)
                    VStack(spacing: SWSpace.s6) {
                        ForEach(league.entries) { entry in row(entry, cutoff: league.promotionCutoff) }
                    }
                    .padding(.horizontal, SWSpace.cardGutter).padding(.top, SWSpace.s20)
                    Text("Rivals are placeholders for now. Friends and real leagues are coming.")
                        .font(SWText.captionSmall).foregroundStyle(Color.sw.ink5).multilineTextAlignment(.center)
                        .padding(.horizontal, SWSpace.s24).padding(.top, SWSpace.s16)
                }
            }
            .padding(.top, SWSpace.s14)
            .padding(.bottom, SWSize.tabBarClearance)
        }
        .scrollBounceBehavior(.basedOnSize)
        .swBackground()
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.hidden, for: .navigationBar)
        .task(id: model.learner) { await vm.load(model: model) }
    }

    private func crest(_ league: LeagueSnapshot) -> some View {
        VStack(spacing: SWSpace.s4) {
            Text("C")
                .font(SWFont.display(26, italic: true, relativeTo: .title2)).foregroundStyle(Color.sw.reward)
                .frame(width: 64, height: 64).overlay(Circle().strokeBorder(Color.sw.reward, lineWidth: 1.5))
                .accessibilityHidden(true)
            Text(league.name).swDisplay(34, lineHeight: 1.05, relativeTo: .largeTitle).foregroundStyle(Color.sw.ink).padding(.top, SWSpace.s8)
                .accessibilityAddTraits(.isHeader)
            Text("Top \(league.promotionCutoff) move up to \(league.nextTierName) \u{B7} \(league.daysLeft) \(league.daysLeft == 1 ? "day" : "days") left")
                .font(SWText.caption).foregroundStyle(Color.sw.ink3).multilineTextAlignment(.center)
        }
        .padding(.horizontal, SWSpace.textGutter)
    }

    private func row(_ entry: LeagueEntry, cutoff: Int) -> some View {
        let promoted = entry.rank <= cutoff
        return HStack(spacing: SWSpace.s12) {
            Text("\(entry.rank)").font(SWText.numeral(20)).foregroundStyle(promoted ? Color.sw.reward : Color.sw.ink5).frame(width: 26, alignment: .leading)
            Avatar(initial: entry.name, size: 34)
            Text(entry.name).font(SWFont.ui(15, weight: .medium)).foregroundStyle(Color.sw.ink).frame(maxWidth: .infinity, alignment: .leading)
            Text("\(entry.weeklyXP) XP").font(SWFont.ui(14)).foregroundStyle(Color.sw.ink3)
        }
        .padding(.horizontal, SWSpace.s14).padding(.vertical, SWSpace.s10)
        .frame(minHeight: SWSize.minTarget)
        .background(RoundedRectangle(cornerRadius: 16, style: .continuous).fill(entry.isLearner ? Color.sw.accentTint : .clear))
        .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous).strokeBorder(entry.isLearner ? Color.sw.accent.opacity(0.35) : .clear, lineWidth: 1))
        .overlay(alignment: .bottom) {
            if entry.rank == cutoff && !entry.isLearner {
                DashedLine().stroke(Color.sw.reward.opacity(0.35), style: StrokeStyle(lineWidth: 1, dash: [4, 3])).frame(height: 1)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Rank \(entry.rank), \(entry.isLearner ? "you" : entry.name), \(entry.weeklyXP) XP\(promoted ? ", moves up" : "")")
    }
}

private struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return p
    }
}

#Preview("League") {
    PreviewHost { _ in NavigationStack { LeagueView() } }
}
