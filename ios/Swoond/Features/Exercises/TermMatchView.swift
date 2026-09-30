import SwiftUI
import SwoondCore

/// term-match: tap a term, then its definition. Matched pairs lock with a gold outline and a check.
/// Two wrong attempts on a term cost a heart (Core decides; this view only reports attempts).
struct TermMatchView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: TermMatchEngine
    @State private var definitions: [String]
    @State private var selectedTerm: String?
    @State private var wrongDefinition: String?
    @State private var shakes: CGFloat = 0
    @State private var message: String?
    @State private var evaluation: ExerciseEvaluation?

    @Environment(\.dynamicTypeSize) private var typeSize
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    init(engine: TermMatchEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        var generator = SeededGenerator(stableSeed: coordinator.activityId)
        _definitions = State(initialValue: engine.definitionOptions(using: &generator))
        _engine = State(initialValue: engine)
    }

    private var pairs: [TermMatchPayload.Pair] { engine.payload.pairs }

    var body: some View {
        ExerciseScaffold(prompt: engine.payload.prompt, evaluation: evaluation, coordinator: coordinator) {
            VStack(alignment: .leading, spacing: SWSpace.s12) {
                Text(hint).font(SWText.caption).foregroundStyle(Color.sw.ink3)
                    .accessibilityLabel(hint)
                if typeSize.isAccessibilitySize {
                    VStack(spacing: SWSpace.s10) { termsColumn; definitionsColumn }
                } else {
                    HStack(alignment: .top, spacing: SWSpace.s10) { termsColumn; definitionsColumn }
                }
            }
            .modifier(ShakeEffect(shakes: shakes))
        }
    }

    private var hint: String {
        if let message { return message }
        return selectedTerm == nil ? "Tap a term, then its meaning." : "Now tap what it means."
    }

    private var termsColumn: some View {
        VStack(spacing: SWSpace.s8) {
            ForEach(pairs) { pair in
                cell(pair.term, style: .term, state: termState(pair)) { selectTerm(pair.id) }
            }
        }
    }

    private var definitionsColumn: some View {
        VStack(spacing: SWSpace.s8) {
            ForEach(definitions, id: \.self) { definition in
                cell(definition, style: .definition, state: definitionState(definition)) { pick(definition) }
            }
        }
    }

    // MARK: State

    private enum CellStyle { case term, definition }
    private enum CellState { case idle, selected, matched, wrong, disabled }

    private func termState(_ pair: TermMatchPayload.Pair) -> CellState {
        if engine.matchedTermIds.contains(pair.id) { return .matched }
        return pair.id == selectedTerm ? .selected : .idle
    }

    private func definitionState(_ definition: String) -> CellState {
        let matched = pairs.contains { engine.matchedTermIds.contains($0.id) && $0.definition == definition }
        if matched { return .matched }
        return definition == wrongDefinition ? .wrong : .idle
    }

    private func cell(_ text: String, style: CellStyle, state: CellState, action: @escaping () -> Void) -> some View {
        Button {
            Haptics.shared.selection()
            action()
        } label: {
            HStack(spacing: SWSpace.s8) {
                Text(text)
                    .font(style == .term ? SWFont.ui(15, weight: .semibold) : SWFont.ui(13))
                    .foregroundStyle(Color.sw.ink)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                if state == .matched { Image(systemName: "checkmark.circle.fill").foregroundStyle(Color.sw.reward).accessibilityHidden(true) }
                if state == .wrong { Image(systemName: "xmark.circle.fill").foregroundStyle(Color.sw.accent).accessibilityHidden(true) }
            }
            .padding(.horizontal, SWSpace.s12)
            .padding(.vertical, SWSpace.s10)
            .frame(maxWidth: .infinity, minHeight: 56)
            .background(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(state == .selected || state == .wrong ? Color.sw.accentTint : (state == .matched ? Color.sw.rewardTint : Color.sw.surface)))
            .overlay(RoundedRectangle(cornerRadius: 16, style: .continuous)
                .strokeBorder(state == .selected || state == .wrong ? Color.sw.accent : (state == .matched ? Color.sw.reward : Color.sw.strokeStrong),
                              lineWidth: state == .idle ? 1 : 1.5))
        }
        .buttonStyle(.plain)
        .disabled(state == .matched || evaluation != nil)
        .accessibilityLabel(text + (state == .matched ? ", matched" : ""))
        .accessibilityAddTraits(state == .selected ? .isSelected : [])
    }

    // MARK: Actions

    private func selectTerm(_ id: String) {
        guard evaluation == nil else { return }
        selectedTerm = id
        message = nil
    }

    private func pick(_ definition: String) {
        guard evaluation == nil, let termId = selectedTerm else { message = "Tap a term first."; return }
        guard let step = try? engine.submit(termId: termId, definition: definition) else { return }
        coordinator.submit(.pairing(termId: termId, definition: definition))
        selectedTerm = nil
        switch step {
        case .inProgress(let feedback):
            message = feedback.message
            if feedback.isCorrect == true {
                Haptics.shared.success()
            } else {
                Haptics.shared.warning()
                wrongDefinition = definition
                if !reduceMotion { withAnimation(.linear(duration: 0.3)) { shakes += 3 } }
                Task {
                    try? await Task.sleep(for: .milliseconds(700))
                    if wrongDefinition == definition { wrongDefinition = nil }
                }
            }
        case .finished(let result):
            message = nil
            evaluation = result
        }
    }
}

#Preview("Term match") {
    ExercisePreview { c in TermMatchView(engine: PreviewData.termMatch(), coordinator: c) }
}
