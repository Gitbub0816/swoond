import SwiftUI
import SwoondCore

/// say-this: "What is she talking about?" A quote card, multi-select concept chips, then the translation and 1-3
/// follow-up lines you could actually say (with "why it works"). Never coaches faking expertise.
struct SayThisView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: SayThisEngine
    @State private var options: [SayThisPayload.Option]
    @State private var selected: Set<String> = []
    @State private var evaluation: ExerciseEvaluation?

    init(engine: SayThisEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        var generator = SeededGenerator(stableSeed: coordinator.activityId)
        _options = State(initialValue: engine.payload.options.shuffled(using: &generator))
        _engine = State(initialValue: engine)
    }

    private var payload: SayThisPayload { engine.payload }

    var body: some View {
        ExerciseScaffold(
            eyebrow: "Decode it", prompt: payload.question ?? "What are they talking about?", promptSize: 26,
            evaluation: evaluation, coordinator: coordinator,
            action: ExerciseAction(title: "Check", isEnabled: !selected.isEmpty, perform: check)
        ) {
            VStack(alignment: .leading, spacing: SWSpace.s14) {
                quoteCard
                Text("Pick everything that fits.").font(SWText.caption).foregroundStyle(Color.sw.ink3)
                FlowLayout(spacing: SWSpace.s8, lineSpacing: SWSpace.s8) {
                    ForEach(options) { option in chip(option) }
                }
            }
        } after: {
            followUps
        }
    }

    private var quoteCard: some View {
        VStack(alignment: .leading, spacing: SWSpace.s8) {
            Text(payload.statement.speaker).font(SWText.displayS(18, italic: true)).foregroundStyle(Color.sw.accentSoft)
            Text("\u{201C}\(payload.statement.text.trimmingQuotes)\u{201D}")
                .font(SWText.displayS(24)).lineSpacing(3)
                .foregroundStyle(Color.sw.ink)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(SWSpace.s18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .swCard(radius: SWRadius.cardLarge)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(payload.statement.speaker) says: \(payload.statement.text)")
    }

    @ViewBuilder
    private func chip(_ option: SayThisPayload.Option) -> some View {
        if evaluation == nil {
            Chip(title: option.text, isOn: selected.contains(option.id)) {
                if selected.contains(option.id) { selected.remove(option.id) } else { selected.insert(option.id) }
            }
        } else {
            let picked = selected.contains(option.id)
            let right = option.isCorrect
            HStack(spacing: SWSpace.s6) {
                if right { Image(systemName: "checkmark").imageScale(.small).accessibilityHidden(true) }
                else if picked { Image(systemName: "xmark").imageScale(.small).accessibilityHidden(true) }
                Text(option.text)
            }
            .font(SWFont.ui(13, weight: .medium, relativeTo: .footnote))
            .foregroundStyle(right ? Color.sw.reward : (picked ? Color.sw.accentSoft : Color.sw.ink4))
            .padding(.horizontal, SWSpace.s16)
            .frame(minHeight: SWSize.chip)
            .background(Capsule().fill(right ? Color.sw.rewardTint : (picked ? Color.sw.accentTint : .clear)))
            .overlay(Capsule().strokeBorder(right ? Color.sw.reward : (picked ? Color.sw.accent : Color.sw.strokeStrong), lineWidth: 1))
            .accessibilityElement(children: .ignore)
            .accessibilityLabel(option.text + (right ? ", correct" : picked ? ", not this one" : ""))
        }
    }

    private var followUps: some View {
        VStack(alignment: .leading, spacing: SWSpace.s14) {
            VStack(alignment: .leading, spacing: SWSpace.s6) {
                Eyebrow("What they meant")
                Text(payload.translation).font(SWText.body).foregroundStyle(Color.sw.ink2).fixedSize(horizontal: false, vertical: true)
            }
            if !payload.followUps.isEmpty {
                Eyebrow("You could say")
                ForEach(Array(payload.followUps.prefix(3).enumerated()), id: \.offset) { _, f in
                    VStack(alignment: .leading, spacing: SWSpace.s4) {
                        Text("\u{201C}\(f.line.trimmingQuotes)\u{201D}").font(SWText.displayS(21)).foregroundStyle(Color.sw.ink)
                            .fixedSize(horizontal: false, vertical: true)
                        Text("Why it works: \(f.why)").font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            if let note = payload.noFakeExpertNote {
                Text(note).font(SWText.captionSmall).foregroundStyle(Color.sw.ink4).fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(SWSpace.s16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .swCard(radius: SWRadius.card)
    }

    private func check() {
        let ids = options.map(\.id).filter { selected.contains($0) }
        guard !ids.isEmpty, evaluation == nil, let result = try? engine.submit(selected: ids) else { return }
        evaluation = result
        coordinator.submit(.choices(ids))
    }
}

#Preview("Say this") {
    ExercisePreview { c in SayThisView(engine: PreviewData.sayThis(), coordinator: c) }
}
