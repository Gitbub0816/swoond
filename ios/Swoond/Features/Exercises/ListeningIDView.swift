import AVFoundation
import SwiftUI
import SwoondCore

/// Plays a bundled clip. Main-actor; the clip's duration drives the "playing" state (no delegate needed).
@MainActor
@Observable
final class ClipPlayer {
    private(set) var isAvailable = false
    private(set) var isPlaying = false
    private var player: AVAudioPlayer?
    private var stopTask: Task<Void, Never>?

    func load(asset: String) {
        guard let url = AssetLocator.url(for: asset), let p = try? AVAudioPlayer(contentsOf: url) else { isAvailable = false; return }
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        p.prepareToPlay()
        player = p
        isAvailable = true
    }

    func play() {
        guard let player else { return }
        stopTask?.cancel()
        player.currentTime = 0
        player.play()
        isPlaying = true
        let duration = player.duration
        stopTask = Task { [weak self] in
            try? await Task.sleep(for: .seconds(duration))
            if !Task.isCancelled { self?.isPlaying = false }
        }
    }

    func stop() {
        stopTask?.cancel()
        player?.stop()
        isPlaying = false
    }
}

/// listening-id: recognize a sound. Big play button, a plays counter (`maxPlays`), options, a text alternative,
/// and Skip (no XP, no heart lost) for learners who cannot hear audio.
struct ListeningIDView: View {
    let coordinator: ExerciseCoordinator
    @State private var engine: ListeningIDEngine
    @State private var options: [TextOption]
    @State private var selected: String?
    @State private var evaluation: ExerciseEvaluation?
    @State private var showDescription = false
    @State private var player = ClipPlayer()

    init(engine: ListeningIDEngine, coordinator: ExerciseCoordinator) {
        self.coordinator = coordinator
        var generator = SeededGenerator(stableSeed: coordinator.activityId)
        _options = State(initialValue: engine.payload.options.shuffled(using: &generator))
        _engine = State(initialValue: engine)
    }

    private var payload: ListeningIDPayload { engine.payload }

    var body: some View {
        ExerciseScaffold(
            prompt: payload.prompt, evaluation: evaluation, coordinator: coordinator,
            action: ExerciseAction(title: "Check", isEnabled: selected != nil, perform: check)
        ) {
            VStack(spacing: SWSpace.s14) {
                playerCard
                ForEach(Array(options.enumerated()), id: \.element.id) { index, option in
                    OptionRow(text: option.text, state: state(option.id), position: (index + 1, options.count)) {
                        if evaluation == nil { selected = option.id }
                    }
                    .disabled(evaluation != nil)
                }
                if evaluation == nil {
                    Button("I can\u{2019}t hear audio right now. Skip") { skip() }
                        .font(SWText.caption).foregroundStyle(Color.sw.ink3)
                        .frame(minHeight: SWSize.minTarget)
                }
            }
        }
        .task { player.load(asset: payload.audio.asset) }
        .onDisappear { player.stop() }
    }

    private var playerCard: some View {
        VStack(spacing: SWSpace.s12) {
            HStack(spacing: SWSpace.s16) {
                Button {
                    guard engine.recordPlay() else { return }
                    Haptics.shared.tick()
                    player.play()
                } label: {
                    Image(systemName: player.isPlaying ? "speaker.wave.2.fill" : "play.fill")
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(Color.sw.onAccent)
                        .frame(width: 72, height: 72)
                        .background(Circle().fill(Color.sw.accent))
                }
                .disabled(engine.playsRemaining == 0 || !player.isAvailable)
                .opacity(engine.playsRemaining == 0 || !player.isAvailable ? 0.4 : 1)
                .accessibilityLabel("Play clip")
                .accessibilityHint("\(engine.playsRemaining) plays left")
                waveform.frame(maxWidth: .infinity).frame(height: 44)
            }
            HStack {
                Text(player.isAvailable ? "\(engine.playsRemaining) of \(engine.maxPlays) plays left" : "Audio isn\u{2019}t bundled in this build")
                    .font(SWText.captionSmall).foregroundStyle(Color.sw.ink4)
                Spacer()
                Button(showDescription ? "Hide text version" : "Show text version") { showDescription.toggle() }
                    .font(SWText.captionSmall).foregroundStyle(Color.sw.accentSoft)
                    .frame(minHeight: SWSize.minTarget)
            }
            if showDescription || evaluation != nil {
                Text(payload.audio.description).font(SWText.caption).foregroundStyle(Color.sw.ink2)
                    .frame(maxWidth: .infinity, alignment: .leading).fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(SWSpace.s16)
        .swCard(radius: SWRadius.cardLarge)
    }

    private var waveform: some View {
        HStack(spacing: 3) {
            ForEach(0..<32, id: \.self) { i in
                let h = 0.25 + 0.75 * abs(sin(Double(i) * 0.7) * cos(Double(i) * 0.31))
                Capsule().fill(player.isPlaying ? Color.sw.accent : Color.sw.ink5).frame(height: 44 * h)
            }
        }
        .accessibilityHidden(true)
    }

    private func state(_ id: String) -> OptionRow.RowState {
        guard evaluation != nil else { return selected == id ? .selected : .idle }
        if id == payload.correctOptionId { return .correct }
        return selected == id ? .wrong : .dimmed
    }

    private func check() {
        guard let selected, evaluation == nil, let result = try? engine.submit(optionId: selected) else { return }
        var withCues = result
        if let cues = payload.listenFor, !cues.isEmpty { withCues.notes.append("Listen for: " + cues.joined(separator: ", ")) }
        player.stop()
        evaluation = withCues
        coordinator.submit(.choices([selected]))
    }

    private func skip() {
        guard evaluation == nil, let result = try? engine.skip() else { return }
        player.stop()
        evaluation = result
        coordinator.submit(.skip)
    }
}

#Preview("Listening ID") {
    ExercisePreview { c in ListeningIDView(engine: PreviewData.listeningID(), coordinator: c) }
}
