import SwiftUI
import SwoondCore

/// timing-tap: a marker sweeps a 44 pt bar and you tap when it is inside the gold zone (design 2c "Pit Stop").
///
/// Rendering: a `TimelineView(.animation)` drives a `Canvas`, so the marker updates every display frame (120 Hz on
/// ProMotion; `CADisableMinimumFrameDurationOnPhone` is set in Info.plist). Position comes from the injected clock
/// via `TimingTapEngine.markerPct`, so scoring stays deterministic in Core. Metal is not required; a Metal marker
/// trail/glow is an optional visual upgrade (CATALOG section 8).
struct TimingTapView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: TimingTapEngine
    @State private var phase: Phase = .idle
    @State private var roundStart = Date()
    @State private var lastResult: TimingTapEngine.RoundResult?
    @State private var evaluation: ExerciseEvaluation?

    private enum Phase { case idle, running, stopped }

    init(engine: TimingTapEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        _engine = State(initialValue: engine)
    }

    private var payload: TimingTapPayload { engine.payload }
    private var isPitStop: Bool { payload.theme.label.lowercased().contains("pit") }
    private var usesSeconds: Bool { (payload.theme.resultUnit ?? .seconds) == .seconds }
    private var totalRounds: Int { engine.rounds.count }
    private var points: Int { engine.results.reduce(0) { $0 + $1.score } }

    /// The zone on screen: the round being played, or the one just played while its result is showing.
    private var shownRound: TimingTapPayload.Round {
        let i = phase == .stopped ? max(0, engine.results.count - 1) : engine.results.count
        return engine.rounds[min(i, totalRounds - 1)]
    }

    private var displayedRoundNumber: Int { min(totalRounds, phase == .stopped ? engine.results.count : engine.results.count + 1) }

    var body: some View {
        ExerciseScaffold(
            eyebrow: "\(payload.theme.label) \u{B7} Round \(displayedRoundNumber)/\(totalRounds)", prompt: payload.prompt,
            evaluation: evaluation, coordinator: coordinator,
            action: ExerciseAction(title: buttonTitle, perform: buttonAction)
        ) {
            VStack(spacing: SWSpace.s20) {
                HStack {
                    Spacer()
                    Text("\(points) pts").font(SWFont.ui(13, weight: .medium)).foregroundStyle(Color.sw.reward)
                        .accessibilityLabel("\(points) points")
                }
                readoutCard
                VStack(spacing: SWSpace.s6) {
                    bar
                    HStack {
                        Text("too early"); Spacer()
                        Text("clean").foregroundStyle(Color.sw.reward); Spacer()
                        Text("too late")
                    }
                    .font(SWFont.ui(11, relativeTo: .caption)).foregroundStyle(Color.sw.ink5)
                    .accessibilityHidden(true)
                }
                Text(message).font(SWText.body).foregroundStyle(Color.sw.ink2).lineSpacing(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minHeight: 44, alignment: .topLeading)
            }
        }
    }

    // MARK: Pieces

    private var readoutText: String {
        if let r = lastResult, phase == .stopped { return usesSeconds ? String(format: "%.1fs", r.clockSeconds) : "\(r.score)" }
        if phase == .running { return "\u{2026}" }
        return usesSeconds ? "12.0s" : "\u{2014}"
    }

    private var readoutCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: SWRadius.hero, style: .continuous).fill(Color.sw.surface)
            RoundedRectangle(cornerRadius: SWRadius.hero, style: .continuous).strokeBorder(Color.sw.stroke, lineWidth: 1)
            if isPitStop { carDiagram }
            Text(readoutText)
                .font(SWFont.display(44, italic: true, relativeTo: .largeTitle))
                .foregroundStyle(Color.sw.ink)
                .contentTransition(.numericText())
            VStack { Spacer(); HStack { Text(isPitStop ? "crew time" : payload.theme.label).font(SWFont.ui(11, relativeTo: .caption)).foregroundStyle(Color.sw.ink4); Spacer() } }
                .padding(.leading, SWSpace.s16).padding(.bottom, SWSpace.s14)
        }
        .frame(height: 250)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(phase == .stopped ? "Result \(readoutText)" : "Timing readout")
    }

    /// Overhead car with four tires that turn gold as rounds complete.
    private var carDiagram: some View {
        GeometryReader { proxy in
            let w = proxy.size.width, h = proxy.size.height
            let goldTires = Int((Double(engine.results.count) * 4 / 3).rounded())
            ZStack {
                Rectangle().fill(Color.sw.stroke).frame(height: 1).position(x: w / 2, y: h / 2)
                UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 22, bottomTrailingRadius: 22, topTrailingRadius: 30, style: .continuous)
                    .fill(LinearGradient(colors: [Color.sw.surface2, Color.sw.surface], startPoint: .top, endPoint: .bottom))
                    .overlay(UnevenRoundedRectangle(topLeadingRadius: 30, bottomLeadingRadius: 22, bottomTrailingRadius: 22, topTrailingRadius: 30, style: .continuous)
                        .strokeBorder(Color.sw.strokeStrong, lineWidth: 1))
                    .frame(width: 92, height: 160)
                    .position(x: w / 2, y: h / 2)
                ForEach(Array([(0.26, 0.22), (0.74, 0.22), (0.26, 0.78), (0.74, 0.78)].enumerated()), id: \.offset) { i, p in
                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                        .fill(i < goldTires ? Color.sw.reward : Color.sw.surface2)
                        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).strokeBorder(Color.sw.strokeStrong, lineWidth: 1))
                        .frame(width: 28, height: 44)
                        .position(x: w * p.0, y: h * p.1)
                }
            }
        }
        .accessibilityHidden(true)
    }

    private var bar: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let zone = shownRound
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 14, style: .continuous).fill(Color.sw.track)
                ZStack(alignment: .leading) {
                    Rectangle().fill(Color.sw.reward.opacity(0.28))
                    HStack { Rectangle().fill(Color.sw.reward).frame(width: 1); Spacer(); Rectangle().fill(Color.sw.reward).frame(width: 1) }
                }
                .frame(width: width * (zone.zoneEndPct - zone.zoneStartPct) / 100)
                .offset(x: width * zone.zoneStartPct / 100)
                TimelineView(.animation(minimumInterval: nil, paused: phase != .running)) { timeline in
                    // Compute the position here (main actor) and let the Canvas capture only the number.
                    let pct = markerPct(at: timeline.date)
                    Canvas { context, size in
                        let x = size.width * pct / 100
                        let rect = CGRect(x: x - 2, y: 4, width: 4, height: size.height - 8)
                        var glow = context
                        glow.addFilter(.shadow(color: Color.sw.ink.opacity(0.6), radius: 6))
                        glow.fill(Path(roundedRect: rect, cornerRadius: 4), with: .color(Color.sw.ink))
                    }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        }
        .frame(height: 44)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Timing bar")
        .accessibilityValue(phase == .running ? "Marker moving. Tap to stop." : "Stopped")
    }

    private func markerPct(at date: Date) -> Double {
        switch phase {
        case .running:
            let sweep = shownRound.sweepSeconds
            return TimingTapEngine.markerPct(elapsedSeconds: date.timeIntervalSince(roundStart), sweepSeconds: sweep)
        case .stopped: return lastResult?.markerPct ?? 0
        case .idle: return 0
        }
    }

    // MARK: Copy

    private var message: String {
        switch phase {
        case .idle: return "Tap when the marker hits the gold zone."
        case .running: return "Wait for it\u{2026}"
        case .stopped:
            guard let r = lastResult else { return "" }
            if r.hit { return isPitStop ? "Clean stop. A tenth of a second here can gain a car multiple spots on track." : "Right in the zone." }
            let off = Int(r.offPct.rounded())
            return isPitStop
                ? "Loose lug nut energy. \(String(format: "%.1f", r.clockSeconds))s. The car behind you just drove past."
                : "Off by \(off) \(off == 1 ? "point" : "points")."
        }
    }

    private var buttonTitle: String {
        switch phase {
        case .idle: return engine.results.isEmpty ? "Start stop" : "Start round"
        case .running: return "Tap!"
        case .stopped: return "Next round"
        }
    }

    private func buttonAction() {
        switch phase {
        case .idle: start()
        case .running: stop()
        case .stopped: start()
        }
    }

    private func start() {
        lastResult = nil
        roundStart = Date()
        phase = .running
    }

    private func stop() {
        let elapsed = Date().timeIntervalSince(roundStart)
        Haptics.shared.tick()
        guard let step = try? engine.submit(elapsedSeconds: elapsed) else { return }
        coordinator.submit(.elapsed(seconds: elapsed))
        lastResult = engine.results.last
        phase = .stopped
        if case .finished(let result) = step { evaluation = result }
    }
}

#Preview("Timing tap (pit stop)") {
    ExercisePreview { c in TimingTapView(engine: PreviewData.timingTap(), coordinator: c) }
}

#Preview("Timing tap (slow mode)") {
    ExercisePreview { c in TimingTapView(engine: PreviewData.timingTap(mode: .tapToStopSlow), coordinator: c) }
}
