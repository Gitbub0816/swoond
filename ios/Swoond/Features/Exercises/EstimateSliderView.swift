import SwiftUI
import SwoondCore

/// estimate-slider: a big serif number over a slider. After locking in, the answer shows as a gold marker.
struct EstimateSliderView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: EstimateSliderEngine
    @State private var value: Double
    @State private var evaluation: ExerciseEvaluation?

    init(engine: EstimateSliderEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        _value = State(initialValue: engine.snapped((engine.payload.min + engine.payload.max) / 2))
        _engine = State(initialValue: engine)
    }

    private var payload: EstimateSliderPayload { engine.payload }

    var body: some View {
        ExerciseScaffold(
            prompt: payload.prompt, evaluation: evaluation, coordinator: coordinator,
            action: ExerciseAction(title: "Lock it in", perform: lockIn)
        ) {
            VStack(spacing: SWSpace.s20) {
                VStack(spacing: SWSpace.s4) {
                    Text(format(value)).font(SWText.numeral(52)).foregroundStyle(Color.sw.ink).contentTransition(.numericText())
                    Text(payload.unit).font(SWText.caption).foregroundStyle(Color.sw.ink3)
                }
                .frame(maxWidth: .infinity)
                .accessibilityElement(children: .ignore)
                .accessibilityLabel("Your estimate")
                .accessibilityValue("\(format(value)) \(payload.unit)")

                if evaluation == nil {
                    VStack(spacing: SWSpace.s6) {
                        Slider(value: $value, in: payload.min...payload.max, step: payload.step)
                            .tint(Color.sw.accent)
                            .accessibilityLabel("Estimate")
                            .accessibilityValue("\(format(value)) \(payload.unit)")
                        HStack {
                            Text("\(format(payload.min)) \(payload.unit)"); Spacer(); Text("\(format(payload.max)) \(payload.unit)")
                        }
                        .font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                    }
                } else {
                    revealedTrack
                }
            }
        }
    }

    /// Track with your guess (ring) and the answer (gold diamond); both labelled so color is not the only cue.
    private var revealedTrack: some View {
        VStack(spacing: SWSpace.s8) {
            GeometryReader { proxy in
                let w = proxy.size.width
                ZStack(alignment: .leading) {
                    Capsule().fill(Color.sw.track).frame(height: 6).offset(y: 0)
                    Circle().strokeBorder(Color.sw.accent, lineWidth: 3).background(Circle().fill(Color.sw.bgDeep))
                        .frame(width: 20, height: 20).position(x: w * fraction(value), y: 15)
                    Rectangle().fill(Color.sw.reward).frame(width: 14, height: 14).rotationEffect(.degrees(45))
                        .position(x: w * fraction(payload.correctValue), y: 15)
                }
                .frame(height: 30)
            }
            .frame(height: 30)
            HStack {
                Label("You: \(format(value))", systemImage: "circle").foregroundStyle(Color.sw.accentSoft)
                Spacer()
                Label("Answer: \(format(payload.correctValue)) \(payload.unit)", systemImage: "diamond.fill").foregroundStyle(Color.sw.reward)
            }
            .font(SWText.captionSmall)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("You said \(format(value)) \(payload.unit). The answer is \(format(payload.correctValue)) \(payload.unit).")
    }

    private func fraction(_ v: Double) -> Double { max(0, min(1, (v - payload.min) / (payload.max - payload.min))) }

    private func format(_ v: Double) -> String {
        v == v.rounded() ? String(Int(v)) : String(format: "%.1f", v)
    }

    private func lockIn() {
        guard evaluation == nil, let result = try? engine.submit(value: value) else { return }
        evaluation = result
        coordinator.submit(.value(value))
    }
}

#Preview("Estimate slider") {
    ExercisePreview { c in EstimateSliderView(engine: PreviewData.estimateSlider(), coordinator: c) }
}
