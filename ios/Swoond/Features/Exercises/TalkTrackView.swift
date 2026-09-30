import SwiftUI
import SwoondCore

/// talk-track: practice the actual conversation (design 2e). Their message, three replies, the "Smooth" meter and a
/// serif gold coach note. No hearts; conversation practice is forgiving.
struct TalkTrackView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: TalkTrackEngine
    @State private var awaitingContinue = false
    @State private var evaluation: ExerciseEvaluation?

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(engine: TalkTrackEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        _engine = State(initialValue: engine)
    }

    private var name: String { coordinator.personName ?? "Them" }

    var body: some View {
        VStack(spacing: 0) {
            header
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: SWSpace.s10) {
                        if let setting = engine.payload.setting {
                            Text(setting).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4).padding(.bottom, SWSpace.s4)
                        }
                        ForEach(Array(engine.history.enumerated()), id: \.offset) { _, turn in
                            bubble(turn.theirMessage, mine: false)
                            bubble(turn.reply.text, mine: true)
                            bubble(turn.reply.theirResponse, mine: false)
                        }
                        if let exchange = engine.currentExchange, !awaitingContinue {
                            bubble(exchange.theirMessage, mine: false)
                        }
                        if let note = engine.history.last?.reply.coachNote, awaitingContinue || evaluation != nil {
                            coachNote(note).id("note")
                        }
                        if let evaluation {
                            resultCard(evaluation).id("result")
                        }
                        Color.clear.frame(height: 1).id("bottom")
                    }
                    .padding(.horizontal, SWSpace.s18)
                    .padding(.top, SWSpace.s18)
                    .padding(.bottom, SWSpace.s16)
                }
                .scrollBounceBehavior(.basedOnSize)
                .onChange(of: engine.history.count) { _, _ in scroll(proxy) }
                .onChange(of: awaitingContinue) { _, _ in scroll(proxy) }
                .onChange(of: evaluation) { _, _ in scroll(proxy) }
            }
        }
        .safeAreaInset(edge: .bottom, spacing: 0) { footer }
    }

    private func scroll(_ proxy: ScrollViewProxy) {
        withAnimation(reduceMotion ? nil : .swPanel) { proxy.scrollTo("bottom", anchor: .bottom) }
    }

    // MARK: Pieces

    private var header: some View {
        HStack(spacing: SWSpace.s12) {
            Avatar(initial: name, size: 40, style: .person)
            VStack(alignment: .leading, spacing: 2) {
                Text(name).font(SWText.bodyL).foregroundStyle(Color.sw.ink)
                Text("Talk Track \u{B7} \(coordinator.interestName)").font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 0) {
                Text("SMOOTH").font(.system(size: 10, weight: .medium)).tracking(1.4).foregroundStyle(Color.sw.ink4)
                Text("\(engine.smooth)")
                    .font(SWText.numeral(24)).foregroundStyle(Color.sw.reward)
                    .contentTransition(.numericText())
                    .animation(reduceMotion ? nil : .swPanel, value: engine.smooth)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Smooth meter")
            .accessibilityValue("\(engine.smooth) out of 100")
        }
        .padding(.horizontal, SWSpace.textGutter)
        .padding(.bottom, SWSpace.s14)
        .padding(.top, SWSpace.s6)
        .overlay(alignment: .bottom) { Rectangle().fill(Color.sw.stroke).frame(height: 1) }
    }

    private func bubble(_ text: String, mine: Bool) -> some View {
        Text(text)
            .font(SWFont.ui(15, relativeTo: .body)).lineSpacing(2)
            .foregroundStyle(mine ? Color.sw.onAccent : Color.sw.ink)
            .padding(.horizontal, 15).padding(.vertical, 11)
            .background(
                UnevenRoundedRectangle(topLeadingRadius: 20, bottomLeadingRadius: mine ? 20 : 6,
                                       bottomTrailingRadius: mine ? 6 : 20, topTrailingRadius: 20, style: .continuous)
                    .fill(mine ? Color.sw.accent : Color.sw.bubbleTheirs))
            .frame(maxWidth: SWSize.bubbleMaxWidth, alignment: mine ? .trailing : .leading)
            .frame(maxWidth: .infinity, alignment: mine ? .trailing : .leading)
            .transition(.opacity)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel((mine ? "You said: " : "\(name) said: ") + text)
    }

    private func coachNote(_ text: String) -> some View {
        Text(text)
            .font(SWText.displayS(16, italic: true)).lineSpacing(3)
            .multilineTextAlignment(.center)
            .foregroundStyle(Color.sw.reward)
            .frame(maxWidth: 290)
            .padding(.vertical, SWSpace.s6)
            .frame(maxWidth: .infinity)
            .accessibilityLabel("Coach note: \(text)")
    }

    private func resultCard(_ e: ExerciseEvaluation) -> some View {
        VStack(alignment: .leading, spacing: SWSpace.s6) {
            Text(e.isCorrect ? "Smooth. You held the conversation." : "Not your smoothest.")
                .font(SWFont.ui(15, weight: .semibold)).foregroundStyle(Color.sw.ink)
            Text("Smooth finished at \(engine.smooth) out of 100. \(e.explanation)")
                .font(SWText.caption).foregroundStyle(Color.sw.ink2).fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(SWSpace.s16)
        .background(RoundedRectangle(cornerRadius: SWRadius.row, style: .continuous).fill(e.isCorrect ? Color.sw.rewardTint : Color.sw.accentTint))
        .padding(.top, SWSpace.s8)
        .accessibilityElement(children: .combine)
    }

    // MARK: Footer

    @ViewBuilder
    private var footer: some View {
        VStack(spacing: SWSpace.s8) {
            if evaluation != nil {
                PrimaryButton(coordinator.nextTitle) { coordinator.next() }
            } else if awaitingContinue {
                PrimaryButton("Keep chatting") { awaitingContinue = false }
            } else if let exchange = engine.currentExchange {
                Eyebrow("Your move").frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, SWSpace.s4)
                ForEach(exchange.replies) { reply in
                    Button { send(reply) } label: {
                        Text(reply.text)
                            .font(SWFont.ui(14)).lineSpacing(2)
                            .foregroundStyle(Color.sw.ink)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, SWSpace.s16).padding(.vertical, SWSpace.s14)
                            .frame(minHeight: SWSize.minTarget)
                            .swCard(radius: SWRadius.row, border: Color.sw.strokeStrong)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("Reply: \(reply.text)")
                }
            }
        }
        .padding(.horizontal, SWSpace.s16)
        .padding(.top, SWSpace.s10)
        .padding(.bottom, SWSize.ctaBottom)
        .background(Color.sw.bgDeep.opacity(0.94))
    }

    private func send(_ reply: TalkTrackPayload.Reply) {
        guard evaluation == nil, let step = try? engine.submit(replyId: reply.id) else { return }
        coordinator.submit(.reply(reply.id))
        Haptics.shared.selection()
        switch step {
        case .inProgress: awaitingContinue = true
        case .finished(let result): evaluation = result
        }
    }
}

#Preview("Talk track") {
    ExercisePreview { c in TalkTrackView(engine: PreviewData.talkTrack(), coordinator: c) }
}
