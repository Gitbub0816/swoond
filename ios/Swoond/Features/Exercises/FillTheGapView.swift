import SwiftUI
import SwoondCore

/// fill-the-gap: a serif sentence with inline gap chips. Tap a gap, then choose an option.
struct FillTheGapView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: FillTheGapEngine
    @State private var answers: [String: String] = [:]
    @State private var activeGap: String?
    @State private var evaluation: ExerciseEvaluation?

    private enum Token { case word(String), gap(id: String, suffix: String) }

    init(engine: FillTheGapEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        _engine = State(initialValue: engine)
        _activeGap = State(initialValue: engine.payload.gaps.first?.id)
    }

    private var gaps: [FillTheGapPayload.Gap] { engine.payload.gaps }
    private var allFilled: Bool { gaps.allSatisfy { answers[$0.id] != nil } }

    var body: some View {
        ExerciseScaffold(
            prompt: engine.payload.prompt, promptSize: 24, evaluation: evaluation, coordinator: coordinator,
            action: ExerciseAction(title: "Check", isEnabled: allFilled, perform: check)
        ) {
            VStack(alignment: .leading, spacing: SWSpace.s20) {
                FlowLayout(spacing: 6, lineSpacing: SWSpace.s12) {
                    ForEach(Array(tokens.enumerated()), id: \.offset) { _, token in
                        switch token {
                        case .word(let w): Text(w).font(SWText.displayS(26)).foregroundStyle(Color.sw.ink)
                        case .gap(let id, let suffix): gapChip(id: id, suffix: suffix)
                        }
                    }
                }
                .padding(SWSpace.s18)
                .frame(maxWidth: .infinity, alignment: .leading)
                .swCard(radius: SWRadius.cardLarge)

                if evaluation == nil, let id = activeGap, let gap = gaps.first(where: { $0.id == id }) {
                    VStack(alignment: .leading, spacing: SWSpace.s8) {
                        Eyebrow("Blank \((gaps.firstIndex { $0.id == id } ?? 0) + 1) of \(gaps.count)")
                        FlowLayout(spacing: SWSpace.s8, lineSpacing: SWSpace.s8) {
                            ForEach(gap.options, id: \.self) { option in
                                Chip(title: option, isOn: answers[id] == option) { fill(id, option) }
                            }
                        }
                    }
                }
            }
        }
    }

    /// The template as words and gap chips. Punctuation right after a gap stays attached to it.
    private var tokens: [Token] {
        var out: [Token] = []
        var afterGap = false
        for segment in engine.segments {
            switch segment {
            case .text(let text):
                var rest = Substring(text)
                if afterGap, let first = rest.first, !first.isWhitespace, case .gap(let id, let suffix)? = out.last {
                    let end = rest.firstIndex(where: \.isWhitespace) ?? rest.endIndex
                    out[out.count - 1] = .gap(id: id, suffix: suffix + rest[..<end])
                    rest = rest[end...]
                }
                out += rest.split(whereSeparator: \.isWhitespace).map { Token.word(String($0)) }
                afterGap = false
            case .gap(let id):
                out.append(.gap(id: id, suffix: ""))
                afterGap = true
            }
        }
        return out
    }

    private func gapChip(id: String, suffix: String) -> some View {
        let index = (gaps.firstIndex { $0.id == id } ?? 0) + 1
        let answer = answers[id]
        let correct = gaps.first { $0.id == id }?.correct
        let isActive = activeGap == id && evaluation == nil
        let result: Bool? = evaluation == nil ? nil : (answer == correct)
        let tone: AnswerTone = result == true ? .right : (result == false ? .wrong : (isActive || answer != nil ? .selected : .neutral))
        let showTint = result != nil || isActive
        return HStack(spacing: 0) {
            Button {
                guard evaluation == nil else { return }
                Haptics.shared.selection()
                activeGap = id
            } label: {
                HStack(spacing: SWSpace.s4) {
                    Text(answer ?? "\u{2007}\u{2007}\u{2007}\u{2007}\u{2007}")
                        .font(SWText.displayS(24)).foregroundStyle(answer == nil ? Color.sw.ink5 : Color.sw.ink)
                    if result == true { Image(systemName: "checkmark").font(.system(size: 12, weight: .bold)).foregroundStyle(Color.sw.reward) }
                    if result == false { Image(systemName: "xmark").font(.system(size: 12, weight: .bold)).foregroundStyle(Color.sw.accent) }
                }
                .padding(.horizontal, SWSpace.s12).padding(.vertical, SWSpace.s4)
                .frame(minWidth: 72, minHeight: SWSize.minTarget - 8)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(showTint ? tone.fill : Color.clear))
                .overlay(RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .strokeBorder(tone.border, style: StrokeStyle(lineWidth: 1.5, dash: answer == nil ? [4, 3] : [])))
            }
            .buttonStyle(.plain)
            if !suffix.isEmpty { Text(suffix).font(SWText.displayS(26)).foregroundStyle(Color.sw.ink) }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Blank \(index) of \(gaps.count), \(answer ?? "empty")" + (result == true ? ", correct" : result == false ? ", incorrect" : ""))
        .accessibilityHint(evaluation == nil ? "Choose an answer for this blank" : "")
    }

    private func fill(_ id: String, _ option: String) {
        answers[id] = option
        if let next = gaps.first(where: { answers[$0.id] == nil }) { activeGap = next.id }
    }

    private func check() {
        guard evaluation == nil, allFilled, let result = try? engine.submit(answers: answers) else { return }
        evaluation = result
        coordinator.submit(.gaps(answers))
    }
}

#Preview("Fill the gap") {
    ExercisePreview { c in FillTheGapView(engine: PreviewData.fillTheGap(), coordinator: c) }
}
