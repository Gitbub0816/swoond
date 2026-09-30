import SwiftUI
import SwoondCore

/// multiple-choice: option rows (surface, radius 16, 56 pt); selected row gets an accent border and tint.
struct MultipleChoiceView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: MultipleChoiceEngine
    @State private var options: [TextOption]
    @State private var selected: Set<String> = []
    @State private var evaluation: ExerciseEvaluation?

    init(engine: MultipleChoiceEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        var generator = SeededGenerator(stableSeed: coordinator.activityId)
        _options = State(initialValue: engine.displayOrder(using: &generator))
        _engine = State(initialValue: engine)
    }

    var body: some View {
        ExerciseScaffold(
            prompt: engine.payload.prompt, evaluation: evaluation, coordinator: coordinator,
            action: ExerciseAction(title: "Check", isEnabled: !selected.isEmpty, perform: check)
        ) {
            VStack(spacing: SWSpace.s10) {
                if engine.allowsMultiple {
                    Text("Select all that apply").font(SWText.caption).foregroundStyle(Color.sw.ink3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    OptionRow(text: option.text, state: state(for: option.id), position: (index + 1, options.count),
                              isMultiSelect: engine.allowsMultiple) { toggle(option.id) }
                        .disabled(evaluation != nil)
                }
            }
        }
    }

    private func state(for id: String) -> OptionRow.RowState {
        guard evaluation != nil else { return selected.contains(id) ? .selected : .idle }
        if engine.payload.correctOptionIds.contains(id) { return .correct }
        return selected.contains(id) ? .wrong : .dimmed
    }

    private func toggle(_ id: String) {
        guard evaluation == nil else { return }
        if engine.allowsMultiple {
            if selected.contains(id) { selected.remove(id) } else { selected.insert(id) }
        } else {
            selected = [id]
        }
    }

    private func check() {
        let ids = options.map(\.id).filter { selected.contains($0) }
        guard !ids.isEmpty, let result = try? engine.submit(selected: ids) else { return }
        evaluation = result
        coordinator.submit(.choices(ids))
    }
}

#Preview("Multiple choice") {
    ExercisePreview { c in MultipleChoiceView(engine: PreviewData.multipleChoice(), coordinator: c) }
}

#Preview("Multiple choice (multi-select)") {
    ExercisePreview { c in MultipleChoiceView(engine: PreviewData.multipleChoiceMulti(), coordinator: c) }
}
