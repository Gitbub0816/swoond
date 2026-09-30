import SwiftUI
import SwoondCore

/// Results (design 2f): eyebrow, "You can now *hang*.", three stats, lines you've unlocked, league position,
/// Share and Continue. Numerals count up over 600 ms; no confetti, the finish comes from type and gold.
struct ResultsView: View {
    var results: ResultsModel
    var onContinue: () -> Void

    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var xpShown: Double = 0
    @State private var accuracyShown: Double = 0
    @State private var groundShown: Double = 0

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 0) {
                    hero
                    stats
                    linesCard
                    if let outcome = results.challengeOutcome { challengeRow(outcome) }
                    leagueRow
                    if results.leveledUp { levelUpRow }
                }
                .padding(.bottom, SWSpace.s24)
            }
            .scrollBounceBehavior(.basedOnSize)
            actions
        }
        .background(Color.sw.accentGlow.ignoresSafeArea())
        .onAppear(perform: countUp)
    }

    // MARK: Sections

    private var hero: some View {
        VStack(spacing: SWSpace.s14) {
            Eyebrow(results.eyebrow, color: Color.sw.accentSoft)
                .multilineTextAlignment(.center)
            Text.emphasized(results.headlineLead + " ", results.headlineEmphasis, size: 52)
                .font(SWFont.display(52, relativeTo: .largeTitle))
                .lineSpacing(-8)
                .foregroundStyle(Color.sw.ink)
                .multilineTextAlignment(.center)
                .accessibilityAddTraits(.isHeader)
            Text(results.commonGroundDelta > 0
                 ? "Common ground with \(results.personName) went up."
                 : "Common ground with \(results.personName) held steady.")
                .font(SWText.body).foregroundStyle(Color.sw.ink3).multilineTextAlignment(.center)
        }
        .padding(.horizontal, SWSpace.s28)
        .padding(.top, SWSpace.s32)
    }

    private var stats: some View {
        HStack(spacing: SWSpace.s8) {
            statTile(CountUpText(value: xpShown) { "+\($0)" }, label: "XP", style: .translucent)
            statTile(CountUpText(value: accuracyShown) { "\($0)%" }, label: "accuracy", style: .translucent)
            statTile(CountUpText(value: groundShown) { $0 >= 0 ? "+\($0)" : "\($0)" }, label: "common ground", style: .reward)
        }
        .padding(.horizontal, SWSpace.textGutter)
        .padding(.top, SWSpace.s24)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(results.xpEarned) XP, \(results.accuracyPercent) percent accuracy, common ground \(results.commonGroundDelta >= 0 ? "up" : "down") \(abs(results.commonGroundDelta))")
    }

    private func statTile(_ value: CountUpText, label: String, style: StatTile.Style) -> some View {
        VStack(spacing: 2) {
            value
                .font(SWText.numeral(30))
                .foregroundStyle(style == .reward ? Color.sw.reward : Color.sw.ink)
                .minimumScaleFactor(0.6).lineLimit(1)
            Text(label).font(SWFont.ui(11, relativeTo: .caption)).foregroundStyle(style == .reward ? Color.sw.reward : Color.sw.ink4)
        }
        .padding(.vertical, 14).padding(.horizontal, 10)
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: SWRadius.row, style: .continuous).fill(style == .reward ? Color.sw.rewardTint : Color.sw.ink.opacity(0.05)))
    }

    @ViewBuilder
    private var linesCard: some View {
        if !results.unlockedLines.isEmpty {
            VStack(alignment: .leading, spacing: SWSpace.s12) {
                Eyebrow("Lines you\u{2019}ve unlocked")
                ForEach(Array(results.unlockedLines.enumerated()), id: \.offset) { i, line in
                    Text("\u{201C}\(line)\u{201D}")
                        .font(SWText.displayS(19)).lineSpacing(2)
                        .foregroundStyle(i == 0 ? Color.sw.ink : (i == 1 ? Color.sw.ink2 : Color.sw.ink4))
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(SWSpace.s18)
            .frame(maxWidth: .infinity, alignment: .leading)
            .swCard(radius: SWRadius.cardLarge)
            .padding(.horizontal, SWSpace.textGutter)
            .padding(.top, SWSpace.s22)
        }
    }

    @ViewBuilder
    private var leagueRow: some View {
        if let rank = results.leagueRank {
            HStack(spacing: SWSpace.s12) {
                Text("\(rank)")
                    .font(SWFont.display(18, italic: true, relativeTo: .headline)).foregroundStyle(Color.sw.reward)
                    .frame(width: 36, height: 36).overlay(Circle().strokeBorder(Color.sw.reward, lineWidth: 1.5))
                VStack(alignment: .leading, spacing: 1) {
                    Text("\(ordinal(rank)) in Crushing League").font(SWFont.ui(13, weight: .semibold)).foregroundStyle(Color.sw.ink)
                    if let gap = results.leagueGapText { Text(gap).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4) }
                }
                Spacer()
            }
            .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
            .background(RoundedRectangle(cornerRadius: SWRadius.row, style: .continuous).fill(Color.sw.ink.opacity(0.04)))
            .padding(.horizontal, SWSpace.textGutter)
            .padding(.top, SWSpace.s14)
            .accessibilityElement(children: .combine)
        }
    }

    private func challengeRow(_ outcome: ResultsModel.ChallengeOutcome) -> some View {
        let text: String
        switch outcome.status {
        case .won: text = "You beat \(outcome.opponent). +\(outcome.prizeXP) XP."
        case .lost: text = "\(outcome.opponent) took this one. Rematch soon."
        case .tied: text = "Dead heat with \(outcome.opponent)."
        default: text = "Challenge against \(outcome.opponent)."
        }
        return HStack(spacing: SWSpace.s12) {
            Image(systemName: "flag.checkered").foregroundStyle(Color.sw.reward).accessibilityHidden(true)
            Text(text).font(SWFont.ui(13, weight: .semibold)).foregroundStyle(Color.sw.ink)
            Spacer()
        }
        .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
        .background(RoundedRectangle(cornerRadius: SWRadius.row, style: .continuous).fill(Color.sw.rewardTint))
        .padding(.horizontal, SWSpace.textGutter)
        .padding(.top, SWSpace.s14)
    }

    private var levelUpRow: some View {
        HStack(spacing: SWSpace.s12) {
            Image(systemName: "arrow.up.circle").foregroundStyle(Color.sw.reward).accessibilityHidden(true)
            Text("Level up. Look at you.").font(SWFont.ui(13, weight: .semibold)).foregroundStyle(Color.sw.ink)
            Spacer()
        }
        .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
        .background(RoundedRectangle(cornerRadius: SWRadius.row, style: .continuous).fill(Color.sw.rewardTint))
        .padding(.horizontal, SWSpace.textGutter)
        .padding(.top, SWSpace.s14)
    }

    private var actions: some View {
        HStack(spacing: SWSpace.s10) {
            // Sharing never includes the person's name (Discreet mode).
            ShareLink(item: "I\u{2019}m getting into something new with Swoon\u{2019}d.") {
                Text("Share")
            }
            .buttonStyle(.swSecondary)
            .frame(maxWidth: .infinity)
            PrimaryButton("Continue", action: onContinue)
                .frame(maxWidth: .infinity)
                .layoutPriority(1)
        }
        .padding(.horizontal, SWSpace.textGutter)
        .padding(.bottom, SWSize.ctaBottom)
        .padding(.top, SWSpace.s8)
    }

    // MARK: Helpers

    private func countUp() {
        let apply = {
            xpShown = Double(results.xpEarned)
            accuracyShown = Double(results.accuracyPercent)
            groundShown = Double(results.commonGroundDelta)
        }
        if reduceMotion { apply() } else { withAnimation(.swoond(0.6)) { apply() } }
        Haptics.shared.success()
    }

    private func ordinal(_ n: Int) -> String {
        let mod100 = n % 100
        if (11...13).contains(mod100) { return "\(n)th" }
        switch n % 10 {
        case 1: return "\(n)st"
        case 2: return "\(n)nd"
        case 3: return "\(n)rd"
        default: return "\(n)th"
        }
    }
}

/// A number that animates between values (counts up when its `value` is animated).
struct CountUpText: View, Animatable {
    var value: Double
    var format: (Int) -> String

    var animatableData: Double {
        get { value }
        set { value = newValue }
    }

    init(value: Double, format: @escaping (Int) -> String) {
        self.value = value
        self.format = format
    }

    var body: some View { Text(format(Int(value.rounded()))) }
}

#Preview("Results") {
    ResultsView(results: PreviewData.resultsModel, onContinue: {})
        .swBackground()
}

#Preview("Results (challenge won, light)") {
    var model = PreviewData.resultsModel
    model.challengeOutcome = .init(opponent: "Jordan", status: .won, prizeXP: 80)
    model.leveledUp = true
    return ResultsView(results: model, onContinue: {})
        .swBackground()
        .preferredColorScheme(.light)
}
