import SwiftUI
import SwoondCore

/// Full-screen game host (presented as a cover over the tab bar). Hosts the native exercise views and the
/// simulation screen, tracks hearts/progress, and ends in Results. All rules come from `LearningSession` in Core.
struct GameShellView: View {
    var launch: GameLaunch
    @Environment(AppModel.self) private var model
    @State private var vm: GameSessionViewModel?

    var body: some View {
        ZStack {
            Color.sw.bgDeep.ignoresSafeArea()
            if let vm {
                GameShellContent(vm: vm)
            } else {
                ProgressView().tint(Color.sw.ink3)
            }
        }
        .task {
            guard vm == nil else { return }
            let created = GameSessionViewModel(launch: launch, model: model)
            vm = created
            await created.start()
        }
    }
}

private struct GameShellContent: View {
    @Bindable var vm: GameSessionViewModel
    @Environment(AppModel.self) private var model
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var confirmLeave = false

    var body: some View {
        Group {
            switch vm.phase {
            case .loading:
                ProgressView().tint(Color.sw.ink3)
            case .playing:
                playing
            case .heartsEmpty:
                Color.clear
            case .results(let results):
                ResultsView(results: results) { finish() }
                    .transition(.opacity)
            case .failed(let message):
                failed(message)
            }
        }
        .animation(reduceMotion ? nil : .swPanel, value: phaseKey)
        .sheet(isPresented: $vm.showHeartsSheet) {
            HeartsSheet(
                nextHeartAt: model.learner.hearts.nextHeartAt,
                onWait: { vm.waitForHeart() },
                onPractice: { vm.practiceToEarnHeart() },
                onUnlimited: { vm.goUnlimited() })
            .presentationDetents([.height(420)])
            .presentationBackground(Color.sw.surface)
        }
        .confirmationDialog("Leave this game?", isPresented: $confirmLeave, titleVisibility: .visible) {
            Button("Leave", role: .destructive) { model.dismissFullScreen() }
            Button("Keep playing", role: .cancel) {}
        } message: {
            Text("Answers you\u{2019}ve already given still count.")
        }
    }

    /// A stable value so the cross-fade animation fires on phase changes.
    private var phaseKey: Int {
        switch vm.phase {
        case .loading: return 0
        case .playing: return 1
        case .heartsEmpty: return 2
        case .results: return 3
        case .failed: return 4
        }
    }

    private func finish() {
        model.selectedTab = .learn
        model.dismissFullScreen()
    }

    // MARK: Playing

    private var playing: some View {
        VStack(spacing: 0) {
            header
            if let p = vm.presentation {
                switch p.kind {
                case .native(let session):
                    NativeExerciseView(session: session, coordinator: coordinator(for: p))
                        .id(p.activity.id)
                        .transition(.opacity)
                case .simulation(let payload):
                    SimulationScreen(vm: vm, payload: payload)
                        .id(p.activity.id)
                        .transition(.opacity)
                }
            }
        }
    }

    private func coordinator(for p: ActivityPresentation) -> ExerciseCoordinator {
        ExerciseCoordinator(
            activityId: p.activity.id, personName: vm.personName, interestName: vm.interestName,
            isLast: p.position >= p.total,
            submit: { vm.record($0) },
            next: { Task { await vm.next() } })
    }

    private var header: some View {
        HStack(spacing: SWSpace.s12) {
            CloseButton(label: "Leave game") { confirmLeave = true }
            if let p = vm.presentation {
                SWProgressBar(value: Double(p.position - 1) / Double(max(1, p.total)))
                    .accessibilityLabel("Question \(p.position) of \(p.total)")
            } else {
                Spacer()
            }
            HeartsPill(hearts: vm.hearts.current, isUnlimited: vm.hearts.isUnlimited)
        }
        .padding(.leading, SWSpace.s8)
        .padding(.trailing, SWSpace.s22)
        .padding(.top, SWSpace.s4)
    }

    private func failed(_ message: String) -> some View {
        VStack(spacing: SWSpace.s20) {
            Spacer()
            MessageCard(title: "Hold on", message: message, systemImage: "exclamationmark.triangle")
            SecondaryButton("Back") { model.dismissFullScreen() }
            Spacer()
        }
        .padding(.horizontal, SWSpace.s24)
    }
}

#Preview("Game shell (hockey lesson)") {
    PreviewHost { model in
        GameShellView(launch: GameLaunch(personId: PreviewData.maya.id, courseId: "hockey", kind: .lesson(unitId: "rink-basics", lessonId: "rink-01")))
    }
}

#Preview("Game shell (pit stop)") {
    PreviewHost { model in
        GameShellView(launch: GameLaunch(personId: PreviewData.maya.id, courseId: "nascar", kind: .lesson(unitId: "pit-lane", lessonId: "pit-stop-01")))
    }
}
