import SwiftUI
import SwoondCore

@MainActor
@Observable
final class DailyBiteViewModel {
    private(set) var bite: DailyBite?
    private(set) var isLoaded = false
    private(set) var isCompleting = false

    func load(courseId: CourseID, model: AppModel) async {
        guard let person = model.activePerson else { isLoaded = true; return }
        let env = model.env
        let interest = person.interest(for: courseId) ?? PersonInterest(courseId: courseId)
        let today = await env.engine.today()
        bite = try? await env.editorial.dailyBite(courseId: courseId, personalization: interest.personalization, on: today)
        isLoaded = true
    }

    /// "Got it": +10 XP once per day per interest, through `LearningSession`.
    func complete(courseId: CourseID, model: AppModel) async {
        guard let person = model.activePerson, !isCompleting else { return }
        isCompleting = true
        let interest = person.interest(for: courseId) ?? PersonInterest(courseId: courseId)
        let session = model.env.makeSession(person: person, interest: interest)
        _ = try? await session.completeDailyBite()
        await model.refreshLearner()
        model.dismissFullScreen()
    }
}

/// Daily bite (design 3f): a 30-second story and one line to use. Always renders dark (DESIGN_SPEC section 3).
/// Editorial rule: we explain in our own words and link to the publisher; we never copy article text.
struct DailyBiteView: View {
    var courseId: CourseID
    @Environment(AppModel.self) private var model
    @State private var vm = DailyBiteViewModel()

    var body: some View {
        ZStack {
            Color.sw.bg.ignoresSafeArea()
            // A licensed photo goes here (design: full-bleed photo); the striped placeholder stands in until one is licensed.
            StripedPlaceholder(label: "[ full-bleed photo ]").ignoresSafeArea().accessibilityHidden(true)
            Color.sw.photoScrim.ignoresSafeArea()

            VStack(spacing: 0) {
                SegmentedProgress(count: 3, filled: 1, spacing: 4, onColor: Color.sw.ink, offColor: Color.white.opacity(0.3))
                    .padding(.horizontal, SWSpace.s16).padding(.top, SWSpace.s8)
                HStack {
                    Text("Daily bite \u{B7} \(model.interestName(courseId))").font(SWText.caption).foregroundStyle(Color.sw.ink2)
                    Spacer()
                    CloseButton { model.dismissFullScreen() }
                }
                .padding(.leading, SWSpace.s20).padding(.trailing, SWSpace.s4)

                if let bite = vm.bite {
                    content(bite)
                } else if vm.isLoaded {
                    Spacer()
                    MessageCard(title: "Nothing new today", message: "Check back tomorrow for a fresh story.")
                        .padding(.horizontal, SWSpace.s24)
                    Spacer()
                } else {
                    Spacer()
                }
            }
        }
        .environment(\.colorScheme, .dark)
        .preferredColorScheme(.dark)
        .task { await vm.load(courseId: courseId, model: model) }
    }

    private func content(_ bite: DailyBite) -> some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: SWSpace.s14) {
                    Spacer(minLength: 120)
                    Text(bite.headline).swDisplay(40, lineHeight: 1.02, relativeTo: .largeTitle).foregroundStyle(Color.sw.ink)
                        .fixedSize(horizontal: false, vertical: true)
                        .accessibilityAddTraits(.isHeader)
                    Text(bite.whyItMatters).font(SWFont.ui(15)).lineSpacing(5).foregroundStyle(Color.sw.ink2)
                        .fixedSize(horizontal: false, vertical: true)
                    VStack(alignment: .leading, spacing: SWSpace.s6) {
                        Eyebrow("Say this today", color: Color.sw.accentSoft)
                        Text("\u{201C}\(bite.sayThisToday.trimmingQuotes)\u{201D}").font(SWText.displayS(20)).lineSpacing(3).foregroundStyle(Color.sw.ink)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, SWSpace.s18).padding(.vertical, SWSpace.s16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: SWRadius.card, style: .continuous).fill(Color.sw.accent.opacity(0.12)))
                    .overlay(RoundedRectangle(cornerRadius: SWRadius.card, style: .continuous).strokeBorder(Color.sw.accent.opacity(0.3), lineWidth: 1))
                    Link(destination: bite.sourceURL) {
                        Label("Read more at \(bite.publisher)", systemImage: "arrow.up.right")
                            .font(SWText.captionSmall).foregroundStyle(Color.sw.ink3)
                            .frame(minHeight: SWSize.minTarget - 8)
                    }
                    PrimaryButton("Got it \u{B7} +\(XPValues.dailyBite) XP") { Task { await vm.complete(courseId: courseId, model: model) } }
                        .disabled(vm.isCompleting)
                }
                .padding(.horizontal, SWSpace.s24)
                .padding(.bottom, SWSpace.s28)
                .frame(minHeight: proxy.size.height)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview("Daily bite") {
    PreviewHost { _ in DailyBiteView(courseId: "nascar") }
}
