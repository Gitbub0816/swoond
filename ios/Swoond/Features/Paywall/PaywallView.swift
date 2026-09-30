import SwiftUI
import SwoondCore

/// Swoon'd+ paywall (design 3g). Shown from Settings, when hearts run out, or for a locked interest.
/// Prices are placeholders until StoreKit products are configured.
struct PaywallView: View {
    var context: PaywallContext
    @Environment(AppModel.self) private var model
    @State private var vm = PaywallViewModel()

    private static let benefits = [
        "Unlimited hearts, no waiting",
        "All 20+ interests and every game",
        "Advanced Talk Tracks and date prep",
        "Live companion for every game",
        "Multiple crushes (we don\u{2019}t judge)",
    ]

    private var subtitle: String {
        switch context {
        case .settings: return "Everything they love, without limits."
        case .heartsEmpty: return "Out of hearts? Go unlimited and keep playing."
        case .lockedInterest: return "Unlock every interest, every game."
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Spacer()
                CloseButton { model.dismissFullScreen() }
            }
            .padding(.trailing, SWSpace.s12)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Wordmark(size: 46, premium: true)
                    Text(subtitle)
                        .font(SWFont.ui(15)).foregroundStyle(Color.sw.ink2).lineSpacing(3)
                        .padding(.top, SWSpace.s10)
                    VStack(alignment: .leading, spacing: SWSpace.s14) {
                        ForEach(Self.benefits, id: \.self) { benefit in
                            HStack(alignment: .firstTextBaseline, spacing: SWSpace.s12) {
                                Image(systemName: "checkmark").font(.system(size: 13, weight: .bold)).foregroundStyle(Color.sw.reward)
                                    .accessibilityHidden(true)
                                Text(benefit).font(SWFont.ui(15)).foregroundStyle(Color.sw.ink)
                            }
                            .accessibilityElement(children: .combine)
                        }
                    }
                    .padding(.top, SWSpace.s22)
                }
                .padding(.horizontal, 26)
                .frame(maxWidth: .infinity, alignment: .leading)

                VStack(spacing: SWSpace.s10) {
                    ForEach(vm.plans) { plan in planRow(plan) }
                }
                .padding(.horizontal, SWSpace.cardGutter)
                .padding(.top, SWSpace.s24)
                .padding(.bottom, SWSpace.s16)
            }
            .scrollBounceBehavior(.basedOnSize)

            VStack(spacing: SWSpace.s10) {
                if let message = vm.message {
                    Text(message).font(SWText.captionSmall).foregroundStyle(Color.sw.accentSoft).multilineTextAlignment(.center)
                }
                GoldButton(vm.isWorking ? "Just a moment\u{2026}" : "Start 7-day free trial") {
                    Task { await vm.purchase(model: model) }
                }
                .disabled(vm.isWorking)
                HStack(spacing: SWSpace.s4) {
                    Text("Cancel anytime \u{B7}").foregroundStyle(Color.sw.ink5)
                    Button("Restore purchase") { Task { await vm.restore(model: model) } }
                        .foregroundStyle(Color.sw.ink4)
                }
                .font(SWFont.ui(11, relativeTo: .caption))
                .frame(minHeight: SWSize.minTarget - 8)
            }
            .padding(.horizontal, SWSpace.s16)
            .padding(.bottom, SWSize.ctaBottom)
        }
        .background(Color.sw.rewardGlow.ignoresSafeArea())
        .swBackground()
        .task { await vm.load(model: model) }
        .onChange(of: vm.didUnlock) { _, unlocked in if unlocked { model.dismissFullScreen() } }
    }

    private func planRow(_ plan: SubscriptionPlan) -> some View {
        let isOn = vm.selected == plan.period
        return Button {
            Haptics.shared.selection()
            vm.selected = plan.period
        } label: {
            HStack(spacing: SWSpace.s14) {
                Circle().strokeBorder(isOn ? Color.sw.reward : Color.sw.ink5, lineWidth: 1.5).frame(width: 20, height: 20)
                    .overlay(Circle().fill(isOn ? Color.sw.reward : .clear).frame(width: 10, height: 10))
                VStack(alignment: .leading, spacing: 2) {
                    Text(plan.title).font(SWFont.ui(15, weight: .semibold)).foregroundStyle(Color.sw.ink)
                    Text(plan.subtitle).font(SWText.captionSmall).foregroundStyle(Color.sw.ink3)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text(plan.priceText).font(SWFont.ui(15, weight: .semibold)).foregroundStyle(Color.sw.ink)
                    if let badge = plan.badge { Text(badge).font(SWText.captionSmall).foregroundStyle(Color.sw.reward) }
                }
            }
            .padding(.horizontal, SWSpace.s18).padding(.vertical, SWSpace.s16)
            .frame(minHeight: SWSize.minTarget)
            .background(RoundedRectangle(cornerRadius: SWRadius.card, style: .continuous).fill(isOn ? Color.sw.rewardTint : Color.sw.surface))
            .overlay(RoundedRectangle(cornerRadius: SWRadius.card, style: .continuous)
                .strokeBorder(isOn ? Color.sw.reward : Color.sw.strokeStrong, lineWidth: 1.5))
        }
        .buttonStyle(.plain)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("\(plan.title), \(plan.subtitle), \(plan.priceText)\(plan.badge.map { ", \($0)" } ?? "")")
        .accessibilityAddTraits(isOn ? .isSelected : [])
    }
}

/// Out-of-hearts sheet (design README): "Wait 4h", "Practice to earn one", "Go unlimited".
struct HeartsSheet: View {
    var nextHeartAt: Date?
    var onWait: () -> Void
    var onPractice: () -> Void
    var onUnlimited: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: SWSpace.s16) {
            Eyebrow("Out of hearts", color: Color.sw.accentSoft)
            Text("Take a breath.")
                .swDisplay(34, lineHeight: 1.05, relativeTo: .largeTitle).foregroundStyle(Color.sw.ink)
            Text(waitLine).font(SWText.body).foregroundStyle(Color.sw.ink3).lineSpacing(3)
            VStack(spacing: SWSpace.s10) {
                GoldButton("Go unlimited", action: onUnlimited)
                SecondaryButton("Practice to earn one", action: onPractice)
                SecondaryButton("Wait 4h", action: onWait)
            }
            .padding(.top, SWSpace.s8)
        }
        .padding(.horizontal, SWSpace.s24)
        .padding(.top, SWSpace.s28)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var waitLine: String {
        guard let nextHeartAt else { return "A heart comes back every 4 hours." }
        let seconds = max(0, nextHeartAt.timeIntervalSinceNow)
        let hours = Int(seconds) / 3600, minutes = (Int(seconds) % 3600) / 60
        return "Your next heart arrives in \(hours)h \(minutes)m. Or earn one back with a quick practice round."
    }
}

#Preview("Paywall") {
    PreviewHost { _ in PaywallView(context: .settings) }
}

#Preview("Paywall (hearts)") {
    PreviewHost { _ in PaywallView(context: .heartsEmpty) }
}

#Preview("Hearts sheet") {
    HeartsSheet(nextHeartAt: Date().addingTimeInterval(3 * 3600), onWait: {}, onPractice: {}, onUnlimited: {})
        .swBackground(Color.sw.surface)
}
