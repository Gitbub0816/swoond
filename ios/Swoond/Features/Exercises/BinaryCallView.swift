import SwiftUI
import SwoondCore

/// binary-call: a two-way judgment on a court diagram (design 2d "Pickleball Kitchen"). Tap a choice to answer.
struct BinaryCallView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: BinaryCallEngine
    @State private var chosen: String?
    @State private var evaluation: ExerciseEvaluation?

    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(engine: BinaryCallEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        _engine = State(initialValue: engine)
    }

    private var payload: BinaryCallPayload { engine.payload }

    var body: some View {
        ExerciseScaffold(
            eyebrow: payload.ruleTag ?? "Make the call", prompt: payload.prompt, evaluation: evaluation, coordinator: coordinator,
            continueTitle: coordinator.isLast ? "Finish" : "Next rally"
        ) {
            VStack(spacing: SWSpace.s16) {
                courtCard
                HStack(spacing: SWSpace.s10) {
                    ForEach(payload.choices) { choice in
                        choiceButton(choice)
                    }
                }
            }
        }
    }

    // MARK: Court

    private var courtCard: some View {
        GeometryReader { proxy in
            let size = proxy.size
            ZStack {
                DiagramBackground(style: DiagramBackground.style(kind: payload.scene.kind, diagramId: payload.scene.diagramId))
                ForEach(Array((payload.scene.markers ?? []).enumerated()), id: \.offset) { _, marker in
                    DiagramMarker(role: marker.role)
                        .position(position(of: marker, in: size))
                        .animation(reduceMotion ? nil : .swPiece, value: evaluation != nil)
                }
                if payload.scene.markers?.contains(where: { $0.role == .player }) == true {
                    Text("you").font(.system(size: 10)).foregroundStyle(Color.sw.ink3)
                        .position(x: 24, y: size.height - 14)
                }
            }
        }
        .frame(height: 280)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(payload.scene.alt)
        .accessibilityAddTraits(.isImage)
    }

    /// After answering, the ball travels to the player (design: ball lands where you stand).
    private func position(of marker: BinaryCallPayload.Scene.Marker, in size: CGSize) -> CGPoint {
        var x = marker.x, y = marker.y
        if marker.role == .ball, evaluation != nil,
           let player = payload.scene.markers?.first(where: { $0.role == .player }) {
            x = player.x; y = player.y - 0.04
        }
        return CGPoint(x: x * size.width, y: y * size.height)
    }

    // MARK: Choices

    private func choiceButton(_ choice: BinaryCallPayload.Choice) -> some View {
        let state = rowState(choice.id)
        let tone: AnswerTone = state == .correct ? .right : (state == .wrong ? .wrong : .neutral)
        return Button {
            answer(choice.id)
        } label: {
            HStack(spacing: SWSpace.s8) {
                if state == .correct { Image(systemName: "checkmark.circle.fill").foregroundStyle(Color.sw.reward).accessibilityHidden(true) }
                if state == .wrong { Image(systemName: "xmark.circle.fill").foregroundStyle(Color.sw.accent).accessibilityHidden(true) }
                Text(choice.label).font(SWText.button).foregroundStyle(Color.sw.ink).multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, minHeight: 64)
            .padding(.horizontal, SWSpace.s8)
            .background(RoundedRectangle(cornerRadius: SWRadius.card, style: .continuous).fill(tone.fill))
            .overlay(RoundedRectangle(cornerRadius: SWRadius.card, style: .continuous).strokeBorder(tone.border, lineWidth: tone.lineWidth))
            .opacity(state == .dimmed ? 0.55 : 1)
        }
        .buttonStyle(.plain)
        .disabled(evaluation != nil)
        .accessibilityLabel(choice.label + suffix(for: state))
    }

    private func suffix(for state: OptionRow.RowState) -> String {
        switch state {
        case .correct: return ", correct answer"
        case .wrong: return ", your answer, incorrect"
        default: return ""
        }
    }

    private func rowState(_ id: String) -> OptionRow.RowState {
        guard evaluation != nil else { return .idle }
        if id == payload.correctChoiceId { return .correct }
        return id == chosen ? .wrong : .dimmed
    }

    private func answer(_ id: String) {
        guard evaluation == nil, let result = try? engine.submit(choiceId: id) else { return }
        chosen = id
        evaluation = result
        coordinator.submit(.choices([id]))
    }
}

#Preview("Binary call (pickleball)") {
    ExercisePreview { c in BinaryCallView(engine: PreviewData.binaryCall(), coordinator: c) }
}
