import SwiftUI
import SwoondCore

/// visual-id: recognize something by sight. Image card (radius 20), text options; `cues` appear in the feedback.
struct VisualIDView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: VisualIDEngine
    @State private var options: [VisualIDPayload.Option]
    @State private var selected: String?
    @State private var evaluation: ExerciseEvaluation?

    init(engine: VisualIDEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        var generator = SeededGenerator(stableSeed: coordinator.activityId)
        _options = State(initialValue: engine.payload.options.shuffled(using: &generator))
        _engine = State(initialValue: engine)
    }

    private var payload: VisualIDPayload { engine.payload }

    var body: some View {
        ExerciseScaffold(
            prompt: payload.prompt, evaluation: evaluation, coordinator: coordinator,
            action: ExerciseAction(title: "Check", isEnabled: selected != nil, perform: check)
        ) {
            VStack(spacing: SWSpace.s12) {
                AssetImage(asset: payload.image.asset, alt: payload.image.alt)
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: SWRadius.card, style: .continuous))
                    .overlay(RoundedRectangle(cornerRadius: SWRadius.card, style: .continuous).strokeBorder(Color.sw.stroke, lineWidth: 1))
                if let attribution = payload.image.attribution {
                    Text(attribution).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    OptionRow(text: option.text, state: state(option.id), position: (index + 1, options.count)) {
                        if evaluation == nil { selected = option.id }
                    }
                    .disabled(evaluation != nil)
                }
            }
        }
    }

    private func state(_ id: String) -> OptionRow.RowState {
        guard evaluation != nil else { return selected == id ? .selected : .idle }
        if id == payload.correctOptionId { return .correct }
        return selected == id ? .wrong : .dimmed
    }

    private func check() {
        guard let selected, evaluation == nil, let result = try? engine.submit(optionId: selected) else { return }
        // Cues teach how to tell it apart; show them with the explanation.
        var withCues = result
        if let cues = payload.cues, !cues.isEmpty { withCues.notes.append("Look for: " + cues.joined(separator: ", ")) }
        evaluation = withCues
        coordinator.submit(.choices([selected]))
    }
}

#Preview("Visual ID") {
    ExercisePreview { c in VisualIDView(engine: PreviewData.visualID(), coordinator: c) }
}
