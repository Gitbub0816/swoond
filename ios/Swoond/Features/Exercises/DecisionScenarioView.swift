import SwiftUI
import SwoondCore

/// decision-scenario: a fact sheet, 2-4 actions, then the consequence and "what an experienced person weighs".
struct DecisionScenarioView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: DecisionScenarioEngine
    @State private var chosen: String?
    @State private var evaluation: ExerciseEvaluation?

    init(engine: DecisionScenarioEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        _engine = State(initialValue: engine)
    }

    private var payload: DecisionScenarioPayload { engine.payload }
    private var chosenOption: DecisionScenarioPayload.Option? { payload.options.first { $0.id == chosen } }

    var body: some View {
        ExerciseScaffold(prompt: payload.prompt, evaluation: evaluation, coordinator: coordinator) {
            VStack(spacing: SWSpace.s12) {
                factSheet
                ForEach(Array(payload.options.enumerated()), id: \.element.id) { index, option in
                    OptionRow(text: option.label, state: state(option), position: (index + 1, payload.options.count)) { choose(option.id) }
                        .disabled(evaluation != nil)
                }
            }
        } after: {
            consequence
        }
    }

    private var factSheet: some View {
        VStack(alignment: .leading, spacing: SWSpace.s10) {
            if let narrative = payload.situation.narrative {
                Text(narrative).font(SWText.body).foregroundStyle(Color.sw.ink2).fixedSize(horizontal: false, vertical: true)
            }
            ForEach(Array(payload.situation.facts.enumerated()), id: \.offset) { _, fact in
                let isWarning = fact.emphasis == .warning
                HStack(alignment: .firstTextBaseline, spacing: SWSpace.s8) {
                    if isWarning {
                        Image(systemName: "exclamationmark.triangle.fill").foregroundStyle(Color.sw.accentSoft).imageScale(.small).accessibilityHidden(true)
                    }
                    Text(fact.label).font(SWText.body).foregroundStyle(isWarning ? Color.sw.accentSoft : Color.sw.ink3)
                    Spacer(minLength: SWSpace.s8)
                    Text(fact.value).font(SWFont.ui(14, weight: .medium)).foregroundStyle(isWarning ? Color.sw.accentSoft : Color.sw.ink)
                        .multilineTextAlignment(.trailing)
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(isWarning ? "Warning: \(fact.label), \(fact.value)" : "\(fact.label), \(fact.value)")
            }
        }
        .padding(SWSpace.s16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .swCard(radius: SWRadius.card)
    }

    @ViewBuilder
    private var consequence: some View {
        if let option = chosenOption {
            VStack(alignment: .leading, spacing: SWSpace.s10) {
                Eyebrow(verdictLabel(option.verdict), color: option.verdict == .poor ? Color.sw.accentSoft : Color.sw.reward)
                Text(option.consequence).font(SWText.body).foregroundStyle(Color.sw.ink2).fixedSize(horizontal: false, vertical: true)
                ForEach(option.considerations, id: \.self) { c in
                    Label(c, systemImage: "circle.fill")
                        .labelStyle(BulletLabelStyle())
                        .font(SWText.caption).foregroundStyle(Color.sw.ink3)
                }
                Text(payload.expertNote)
                    .font(SWText.displayS(19, italic: true)).foregroundStyle(Color.sw.ink)
                    .fixedSize(horizontal: false, vertical: true).padding(.top, SWSpace.s4)
                if let safety = payload.safetyNote {
                    Text(safety).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4).fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(SWSpace.s16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .swCard(radius: SWRadius.card)
        }
    }

    private func verdictLabel(_ v: DecisionScenarioPayload.Verdict) -> String {
        switch v { case .best: return "Best call"; case .acceptable: return "Acceptable call"; case .poor: return "Poor call" }
    }

    private func state(_ option: DecisionScenarioPayload.Option) -> OptionRow.RowState {
        guard evaluation != nil else { return .idle }
        if option.id == chosen { return option.verdict == .poor ? .wrong : .correct }
        return option.verdict == .best ? .correct : .dimmed
    }

    private func choose(_ id: String) {
        guard evaluation == nil, let result = try? engine.submit(optionId: id) else { return }
        chosen = id
        evaluation = result
        coordinator.submit(.choices([id]))
    }
}

/// Small filled bullet.
struct BulletLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .firstTextBaseline, spacing: SWSpace.s8) {
            configuration.icon.font(.system(size: 4)).accessibilityHidden(true)
            configuration.title
        }
    }
}

#Preview("Decision scenario") {
    ExercisePreview { c in DecisionScenarioView(engine: PreviewData.decisionScenario(), coordinator: c) }
}
