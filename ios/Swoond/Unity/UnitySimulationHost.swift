// Unity-as-a-Library host for Tier A simulations (docs/contracts/unity-bridge/v1/README.md).
//
// This whole file only compiles when Astra's `UnityFramework.framework` is linked (see the commented dependency in
// project.yml). Without it `SimulationHostFactory.default` falls back to `MockSimulationHost` and the game shell shows
// the "Simulation coming soon" placeholder, so the app builds and plays without Unity.
//
// Contract v1 transport (bridge README section 1), followed exactly:
//   native -> Unity : one UTF-8 JSON envelope per call to `SwoondBridge.Receive(string json)`. Native sends it with
//                     `UnityFramework.sendMessageToGO(withName: "SwoondBridge", functionName: "Receive", message:)`, so the
//                     Unity scene must contain a GameObject named `SwoondBridge` with a `Receive(string)` method.
//   Unity -> native : Unity calls `SwoondBridge.Send(string json)`, which forwards to the Objective-C `NativeCallProxy`
//                     (`FrameworkLibAPI.registerAPIforNativeCalls`). ASSUMPTION to agree with Astra: `NativeCallsProtocol`
//                     declares `-(void)onUnityMessage:(NSString *)json`, which `UnityRuntime.onUnityMessage(_:)` implements.
// Lifecycle (bridge README section 2): load lazily -> `launch` -> wait for `ready` (8 s) -> `progress`/`checkpoint`* ->
// exactly one `result` -> `requestExit` -> unload. Native is authoritative: `LearningSession.applySimulation` validates
// and clamps the result; this file never recomputes a simulation.
#if canImport(UnityFramework)
import MachO
import SwiftUI
import SwoondCore
import UIKit
import UnityFramework

// MARK: - Runtime (main actor): owns UnityFramework and the Objective-C callbacks

#if arch(arm64) || arch(x86_64)
private typealias MachHeader = mach_header_64
#else
private typealias MachHeader = mach_header
#endif

@MainActor
final class UnityRuntime: NSObject, UnityFrameworkListener, NativeCallsProtocol {
    static let shared = UnityRuntime()

    private var framework: UnityFramework?
    /// Messages from Unity, in arrival order. Set by `UnitySimulationHost`.
    nonisolated(unsafe) var inbound: AsyncStream<String>.Continuation?

    /// Load and start the embedded Unity runtime the first time a simulation is launched. Nil if it cannot load.
    func prepare() -> UnityFramework? {
        if let framework { return framework }
        let path = Bundle.main.bundlePath + "/Frameworks/UnityFramework.framework"
        guard let bundle = Bundle(path: path) else { return nil }
        if !bundle.isLoaded { bundle.load() }
        guard let ufw = (bundle.principalClass as? UnityFramework.Type)?.getInstance() else { return nil }
        if ufw.appController() == nil {
            let header = UnsafeMutablePointer<MachHeader>.allocate(capacity: 1)
            header.pointee = _mh_execute_header
            ufw.setExecuteHeader(header)
        }
        ufw.setDataBundleId("com.unity3d.framework")
        ufw.register(self)
        FrameworkLibAPI.registerAPIforNativeCalls(self)
        ufw.runEmbedded(withArgc: CommandLine.argc, argv: CommandLine.unsafeArgv, appLaunchOpts: nil)
        framework = ufw
        return ufw
    }

    /// `SwoondBridge.Receive(string json)`.
    func send(_ json: String) {
        framework?.sendMessageToGO(withName: "SwoondBridge", functionName: "Receive", message: json)
    }

    /// The view controller to embed while a simulation runs.
    var viewController: UIViewController? { framework?.appController()?.rootViewController }

    func pauseUnity(_ paused: Bool) { framework?.pause(paused) }

    /// After `result` + `requestExit`: release Unity memory (native baseline).
    func unload() {
        framework?.unloadApplication()
        framework = nil
    }

    // NativeCallsProtocol: Unity -> native. Called on the main thread; preserve order via the inbound stream.
    nonisolated func onUnityMessage(_ json: String) {
        inbound?.yield(json)
    }

    // UnityFrameworkListener
    nonisolated func unityDidUnload(_ notification: Notification!) {}
    nonisolated func unityDidQuit(_ notification: Notification!) {}
}

// MARK: - Host

/// `SimulationHost` over Unity-as-a-Library.
actor UnitySimulationHost: SimulationHost {
    static let shared = UnitySimulationHost()

    nonisolated let events: AsyncStream<BridgeEvent>
    private let eventContinuation: AsyncStream<BridgeEvent>.Continuation
    private let inboundStream: AsyncStream<String>
    private let inboundContinuation: AsyncStream<String>.Continuation

    private var request: LaunchRequest?
    private var waiter: CheckedContinuation<SimulationResult, any Error>?
    private var nextSeq = 0
    private var lastReceivedSeq = -1
    private var isReady = false
    private var startedAt = Date()
    private var timers: [Task<Void, Never>] = []
    private var consumer: Task<Void, Never>?

    init() {
        let (eventStream, eventCont) = AsyncStream<BridgeEvent>.makeStream(bufferingPolicy: .unbounded)
        let (inStream, inCont) = AsyncStream<String>.makeStream(bufferingPolicy: .unbounded)
        self.events = eventStream
        self.eventContinuation = eventCont
        self.inboundStream = inStream
        self.inboundContinuation = inCont
    }

    // MARK: SimulationHost

    func launch(_ request: LaunchRequest) async throws -> SimulationResult {
        guard self.request == nil else { throw BridgeError.unity(code: .internalError, message: "A simulation is already running", recoverable: false) }
        guard BridgeContract.isSupported(request.contractVersion) else { throw BridgeError.contractUnsupported(request.contractVersion) }
        self.request = request
        nextSeq = 0
        lastReceivedSeq = -1
        isReady = false
        startedAt = Date()

        // Load Unity lazily; native-only sessions never touch it.
        let inbound = inboundContinuation
        let loaded = await MainActor.run { () -> Bool in
            UnityRuntime.shared.inbound = inbound
            return UnityRuntime.shared.prepare() != nil
        }
        guard loaded else {
            self.request = nil
            throw BridgeError.unity(code: .internalError, message: "UnityFramework is not available", recoverable: false)
        }
        startConsumer()

        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<SimulationResult, any Error>) in
            waiter = continuation
            armTimers(for: request)
            Task { await self.transmit(.launch, request) }
        }
    }

    func pause(reason: PausePayload.Reason) async {
        guard request != nil else { return }
        await transmit(.pause, PausePayload(reason: reason))
    }

    func resume() async {
        guard request != nil else { return }
        await transmit(.resume, [String: String]())
    }

    func abort(reason: AbortPayload.Reason) async {
        guard let request else { return }
        await transmit(.abort, AbortPayload(reason: reason))
        // No `result` within 5 s after `abort`: synthesize an aborted result (0 XP) and unload (bridge README section 3).
        let abortReason = Self.simulationReason(reason)
        schedule(after: .seconds(5)) { await self.finish(with: .success(.synthesizedAborted(for: request, reason: abortReason, durationMs: self.elapsedMs))) }
    }

    // MARK: Inbound

    private func startConsumer() {
        guard consumer == nil else { return }
        let stream = inboundStream
        consumer = Task { [weak self] in
            for await json in stream { await self?.receive(json) }
        }
    }

    private func receive(_ json: String) async {
        guard let request else { return }
        let event: BridgeEvent
        do { event = try JSONDecoder().decode(BridgeEvent.self, from: Data(json.utf8)) }
        catch { return }   // malformed or schema-invalid: log and ignore (a malformed `result` is handled by the result timer)
        guard event.direction == .unityToNative, event.isDirectionConsistent, event.sessionId == request.sessionId else { return }
        if event.seq <= lastReceivedSeq { return }   // duplicates ignored; a gap is a non-fatal warning
        lastReceivedSeq = event.seq
        eventContinuation.yield(event)

        switch event.type {
        case .ready:
            isReady = true
            timers.first?.cancel()
        case .result:
            if let result = try? event.simulationResult() {
                await finish(with: .success(result))
            } else {
                await finish(with: .failure(BridgeError.unity(code: .internalError, message: "Malformed result", recoverable: false)))
            }
        case .error:
            if let payload = try? event.error() {
                await finish(with: .failure(BridgeError.unity(code: payload.code, message: payload.message, recoverable: payload.recoverable)))
            }
        case .requestExit:
            // Unity-drawn exit affordance during play: native replies with abort (bridge README section 2, step 7).
            if let payload = try? event.requestExit(), payload.reason == .userQuit { await abort(reason: .userQuit) }
        case .progress, .checkpoint, .launch, .pause, .resume, .abort:
            break
        }
    }

    // MARK: Outbound and timers

    private func transmit<P: Encodable>(_ type: BridgeMessageType, _ payload: P) async {
        guard let request else { return }
        let ms = Int64(Date().timeIntervalSince1970 * 1000)
        guard let envelope = try? BridgeEvent.make(type: type, sessionId: request.sessionId, seq: nextSeq, timestampMs: ms, payload: payload),
              let data = try? JSONEncoder().encode(envelope), let json = String(data: data, encoding: .utf8) else { return }
        nextSeq += 1
        await MainActor.run { UnityRuntime.shared.send(json) }
    }

    private var elapsedMs: Int { Int(Date().timeIntervalSince(startedAt) * 1000) }

    /// `ready` within 8 s (else abort, unload, recoverable error, no hearts lost) and the session's max duration.
    private func armTimers(for request: LaunchRequest) {
        timers.forEach { $0.cancel() }
        let readyTimer = Task { [weak self] in
            try? await Task.sleep(for: .milliseconds(BridgeContract.defaultReadyTimeoutMs))
            guard !Task.isCancelled else { return }
            await self?.readyTimedOut()
        }
        let durationTimer = Task { [weak self] in
            try? await Task.sleep(for: .milliseconds(request.runtime.maxDurationMs))
            guard !Task.isCancelled else { return }
            await self?.maxDurationReached()
        }
        timers = [readyTimer, durationTimer]
    }

    private func readyTimedOut() async {
        guard request != nil, !isReady else { return }
        await transmit(.abort, AbortPayload(reason: .timeout))
        await finish(with: .failure(BridgeError.unity(code: .internalError, message: "The simulation did not start in time", recoverable: true)))
    }

    private func maxDurationReached() async {
        guard let request else { return }
        await transmit(.abort, AbortPayload(reason: .timeout))
        // If no `result` arrives within 3 s, synthesize one locally.
        schedule(after: .seconds(3)) { await self.finish(with: .success(.synthesizedAborted(for: request, reason: .timeout, durationMs: self.elapsedMs))) }
    }

    private func schedule(after delay: Duration, _ body: @escaping @Sendable () async -> Void) {
        timers.append(Task {
            try? await Task.sleep(for: delay)
            guard !Task.isCancelled else { return }
            await body()
        })
    }

    private func finish(with outcome: Result<SimulationResult, any Error>) async {
        guard let waiter else { return }
        self.waiter = nil
        timers.forEach { $0.cancel() }
        timers = []
        request = nil
        await MainActor.run { UnityRuntime.shared.unload() }
        waiter.resume(with: outcome)
    }

    private static func simulationReason(_ r: AbortPayload.Reason) -> SimulationAbortReason {
        switch r {
        case .userQuit: return .userQuit
        case .timeout: return .timeout
        case .backgroundedTooLong: return .backgroundedTooLong
        case .memoryPressure: return .error
        case .nativeError: return .nativeAbort
        }
    }
}

// MARK: - SwiftUI

/// Hosts Unity's root view controller full screen while a simulation runs (spec section 21: immersive transition).
struct UnityHostView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        UnityRuntime.shared.viewController ?? UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
#endif
