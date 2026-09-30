import SwiftUI
import SwoondCore

/// The full-screen simulation step (spec section 21: Unity is an immersive, full-screen transition; native resumes with
/// the result). Wired to the `SimulationHost` seam:
///  - Unity linked (`canImport(UnityFramework)`): the host runs the sim and this screen shows the Unity view.
///  - otherwise: a "Simulation coming soon" placeholder that still shows the lesson objective from the launch
///    payload, with a no-penalty Skip (and, in DEBUG, a mock run that exercises the result pipeline).
struct SimulationScreen: View {
    var vm: GameSessionViewModel
    var payload: UnitySimPayload

    @Environment(AppModel.self) private var model
    @Environment(\.colorScheme) private var scheme

    private var launchEnvironment: LaunchEnvironment {
        GameSessionViewModel.launchEnvironment(scheme: scheme == .light ? .light : .dark, settings: model.settings)
    }

    var body: some View {
        Group {
            if model.env.simulationHosts.isUnityBacked && vm.simulation.errorMessage == nil && vm.simulation.finishedSummary == nil {
                SimulationRunningView()
            } else {
                SimulationPlaceholderView(
                    payload: payload, request: vm.simulation.request, objective: vm.simulation.objective,
                    isRunning: vm.simulation.isRunning, finishedSummary: vm.simulation.finishedSummary, errorMessage: vm.simulation.errorMessage,
                    canRunMock: !model.env.simulationHosts.isUnityBacked,
                    runMock: { Task { await vm.runSimulation(environment: launchEnvironment, host: MockSimulationHost()) } },
                    skip: { Task { await vm.skipSimulation() } },
                    next: { Task { await vm.next() } })
            }
        }
        .task {
            await vm.prepareSimulation(environment: launchEnvironment)
            if model.env.simulationHosts.isUnityBacked {
                await vm.runSimulation(environment: launchEnvironment, host: model.env.simulationHosts.make())
            }
        }
    }
}

/// Shown while a real Unity simulation owns the screen.
private struct SimulationRunningView: View {
    var body: some View {
        ZStack {
            Color.sw.bgDeep.ignoresSafeArea()
            #if canImport(UnityFramework)
            UnityHostView().ignoresSafeArea()
            #else
            ProgressView("Loading simulation").tint(Color.sw.ink3)
            #endif
        }
    }
}

/// "Simulation coming soon" placeholder. Pure view: everything comes in as values so it previews easily.
struct SimulationPlaceholderView: View {
    var payload: UnitySimPayload
    var request: LaunchRequest?
    var objective: String?
    var isRunning = false
    var finishedSummary: String?
    var errorMessage: String?
    var canRunMock = true
    var runMock: () -> Void = {}
    var skip: () -> Void = {}
    var next: () -> Void = {}

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                VStack(alignment: .leading, spacing: SWSpace.s16) {
                    Eyebrow(finishedSummary == nil ? "Simulation" : "Simulation complete", color: Color.sw.accentSoft)
                    Text(finishedSummary == nil ? "Simulation coming soon." : "Nice run.")
                        .swDisplay(40, lineHeight: 1, relativeTo: .largeTitle)
                        .foregroundStyle(Color.sw.ink)
                        .accessibilityAddTraits(.isHeader)
                    if let finishedSummary {
                        Text(finishedSummary).font(SWText.bodyL).foregroundStyle(Color.sw.reward)
                    } else {
                        Text("This lesson has a hands-on simulation. It isn\u{2019}t in this build yet, so you can skip it without losing a heart.")
                            .font(SWText.body).foregroundStyle(Color.sw.ink3).lineSpacing(3).fixedSize(horizontal: false, vertical: true)
                    }

                    VStack(alignment: .leading, spacing: SWSpace.s8) {
                        Eyebrow("The objective")
                        Text(objective ?? "Learn it by doing.")
                            .font(SWText.displayS(24)).lineSpacing(3).foregroundStyle(Color.sw.ink)
                            .fixedSize(horizontal: false, vertical: true)
                        FlowLayout(spacing: SWSpace.s8, lineSpacing: SWSpace.s8) {
                            detail("Difficulty \(payload.difficulty)")
                            if let count = (request?.configuration ?? payload.configuration ?? [:])["scenarioCount"]?.intValue {
                                detail("\(count) scenarios")
                            }
                            detail(payload.simulationId)
                        }
                    }
                    .padding(SWSpace.s18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .swCard(radius: SWRadius.cardLarge)

                    if let errorMessage {
                        MessageCard(title: "That didn\u{2019}t work", message: errorMessage, systemImage: "exclamationmark.triangle")
                    }
                }
                .padding(.horizontal, SWSpace.s24)
                .padding(.top, SWSpace.s28)
                .padding(.bottom, SWSpace.s24)
            }
            .scrollBounceBehavior(.basedOnSize)

            VStack(spacing: SWSpace.s10) {
                if finishedSummary != nil {
                    PrimaryButton("Continue", action: next)
                } else {
                    #if DEBUG
                    if canRunMock {
                        GameButton(isRunning ? "Running\u{2026}" : "Run mock simulation", action: runMock).disabled(isRunning)
                    }
                    #endif
                    SecondaryButton("Skip for now", action: skip).disabled(isRunning)
                }
            }
            .padding(.horizontal, SWSpace.s20)
            .padding(.bottom, SWSize.ctaBottom)
        }
    }

    private func detail(_ text: String) -> some View {
        Text(text)
            .font(SWText.captionSmall).foregroundStyle(Color.sw.ink3)
            .padding(.horizontal, SWSpace.s12).padding(.vertical, SWSpace.s6)
            .overlay(Capsule().strokeBorder(Color.sw.strokeStrong, lineWidth: 1))
    }
}

#Preview("Simulation placeholder") {
    SimulationPlaceholderView(
        payload: UnitySimPayload(simulationId: "football.coverage.read.v1", simulationVersion: "1.0.0", difficulty: 2, configuration: ["scenarioCount": 3]),
        request: nil, objective: "You can spot a three-deep zone.")
        .swBackground(Color.sw.bgDeep)
}
