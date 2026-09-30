import Foundation

/// Seam between the learning flow and Unity. The app implements it over `BridgeTransport`/UnityFramework;
/// tests and previews use `MockSimulationHost`. Native never recomputes a sim (CLAUDE.md section 3).
public protocol SimulationHost: Sendable {
    /// Bridge events (ready, progress, checkpoint, result, requestExit ...) as they arrive.
    var events: AsyncStream<BridgeEvent> { get }
    /// Launch a sim and await its (single) result. Throws `BridgeError` for unrecoverable errors.
    func launch(_ request: LaunchRequest) async throws -> SimulationResult
    func pause(reason: PausePayload.Reason) async
    func resume() async
    func abort(reason: AbortPayload.Reason) async
}

/// A `SimulationHost` that returns a plausible result without Unity.
public actor MockSimulationHost: SimulationHost {
    public enum Behavior: Sendable, Equatable {
        case completes
        case aborts(SimulationAbortReason)
        case fails(BridgeErrorCode, recoverable: Bool)
    }

    public nonisolated let events: AsyncStream<BridgeEvent>
    private let continuation: AsyncStream<BridgeEvent>.Continuation
    private let clock: any SwoondClock
    private var behavior: Behavior
    private var latencyNanoseconds: UInt64
    private var seq = 0
    private var abortRequested: AbortPayload.Reason?
    public private(set) var launchedRequests: [LaunchRequest] = []
    public private(set) var isPaused = false

    public init(behavior: Behavior = .completes, latencyNanoseconds: UInt64 = 0, clock: any SwoondClock = SystemClock()) {
        let (stream, cont) = AsyncStream<BridgeEvent>.makeStream(bufferingPolicy: .unbounded)
        self.events = stream
        self.continuation = cont
        self.behavior = behavior
        self.latencyNanoseconds = latencyNanoseconds
        self.clock = clock
    }

    public func setBehavior(_ behavior: Behavior) { self.behavior = behavior }

    public func launch(_ request: LaunchRequest) async throws -> SimulationResult {
        launchedRequests.append(request)
        abortRequested = nil
        seq = 0
        guard BridgeContract.isSupported(request.contractVersion) else {
            try emit(.error, request, BridgeErrorPayload(code: .contractUnsupported, message: "Unsupported contract \(request.contractVersion)", recoverable: false))
            throw BridgeError.contractUnsupported(request.contractVersion)
        }
        if case .fails(let code, let recoverable) = behavior {
            try emit(.error, request, BridgeErrorPayload(code: code, message: "Mock failure", recoverable: recoverable))
            throw BridgeError.unity(code: code, message: "Mock failure", recoverable: recoverable)
        }
        try emit(.ready, request, ReadyPayload(unityVersion: "6000.3.24f1", gameKitVersion: "1.0.0", simulationId: request.simulationId,
                                               simulationVersion: request.simulationVersion, loadTimeMs: 100))
        try emit(.progress, request, ProgressPayload(fraction: 0.5, stage: .playing, roundIndex: 1, roundCount: 3))
        if latencyNanoseconds > 0 { try? await Task.sleep(nanoseconds: latencyNanoseconds) }

        var result: SimulationResult
        if case .aborts(let reason) = behavior {
            result = .synthesizedAborted(for: request, reason: reason, durationMs: 1000)
        } else if abortRequested != nil {
            result = .synthesizedAborted(for: request, reason: .nativeAbort, durationMs: 1000)
        } else {
            result = Self.plausibleResult(for: request)
        }
        try emit(.result, request, result)
        try emit(.requestExit, request, RequestExitPayload(reason: result.aborted ? .userQuit : .completed))
        return result
    }

    public func pause(reason: PausePayload.Reason) async { isPaused = true }
    public func resume() async { isPaused = false }
    public func abort(reason: AbortPayload.Reason) async { abortRequested = reason }

    /// 3 rounds (or `configuration.scenarioCount`), two right, signals on the learner's weak concepts.
    static func plausibleResult(for request: LaunchRequest) -> SimulationResult {
        let rounds = max(1, request.configuration["scenarioCount"]?.intValue ?? 3)
        let successes = max(0, rounds - max(1, rounds / 3))
        let outcomes = (0..<rounds).map { SimulationResult.Outcome(id: "round-\($0 + 1)", success: $0 < successes) }
        let concepts = request.learnerContext.weakConcepts.isEmpty ? request.learnerContext.masteredConcepts : request.learnerContext.weakConcepts
        let signals = concepts.prefix(2).map { SimulationResult.MasterySignal(conceptId: $0, delta: 0.15, evidence: "Mock: read the scene correctly.") }
        let accuracy = Double(successes) / Double(rounds)
        return SimulationResult(
            sessionId: request.sessionId, simulationId: request.simulationId, simulationVersion: request.simulationVersion,
            completed: true, aborted: false, durationMs: 90_000, score: Int((accuracy * 100).rounded()), accuracy: accuracy,
            outcomes: outcomes, masterySignals: Array(signals), xpEarned: 40, heartsLost: rounds - successes > 1 ? 1 : 0, replayAvailable: true,
            telemetry: .init(avgFps: 60, loadTimeMs: 100, unityVersion: "6000.3.24f1", gameKitVersion: "1.0.0"))
    }

    private func emit<P: Encodable>(_ type: BridgeMessageType, _ request: LaunchRequest, _ payload: P) throws {
        let ms = Int64(clock.now().timeIntervalSince1970 * 1000)
        let event = try BridgeEvent.make(type: type, sessionId: request.sessionId, seq: seq, timestampMs: ms, payload: payload)
        seq += 1
        continuation.yield(event)
    }
}
