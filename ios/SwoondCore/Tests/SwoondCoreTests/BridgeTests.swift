import Foundation
import Testing
@testable import SwoondCore

private func launchExample() throws -> LaunchRequest {
    try JSONDecoder().decode(LaunchRequest.self, from: Fixtures.data(Fixtures.bridgeExamples.appendingPathComponent("football-coverage-read-launch.json")))
}
private func resultExample() throws -> SimulationResult {
    try JSONDecoder().decode(SimulationResult.self, from: Fixtures.data(Fixtures.bridgeExamples.appendingPathComponent("football-coverage-read-result.json")))
}
private func context(_ req: LaunchRequest, xp: Int? = nil, budget: Int = 40, hearts: Int? = nil, unlimited: Bool = false, known: Set<String>? = nil) -> SimulationApplicationContext {
    SimulationApplicationContext(sessionId: req.sessionId, simulationId: req.simulationId, activityId: "act", activityXP: xp, lessonXPBudget: budget,
                                 heartsRemainingAtLaunch: hearts ?? req.runtime.heartsRemaining, unlimitedHearts: unlimited, knownConceptIds: known)
}

@Suite("SimulationResultMapper (D-009 clamping)")
struct ResultMapperTests {
    @Test func passesThroughAWellBehavedResult() throws {
        let req = try launchExample(), res = try resultExample()
        let m = try SimulationResultMapper.map(res, context: context(req))
        #expect(m.outcome.xp == 40)
        #expect(m.outcome.heartsLost == 1)
        #expect(m.outcome.correct)
        #expect(m.outcome.score == 82)
        #expect(m.adjustments.isEmpty)
        let byId = Dictionary(uniqueKeysWithValues: m.outcome.conceptEvidence.map { ($0.conceptId, $0) })
        #expect(byId["cover-3"]?.delta == 0.25 && byId["cover-3"]?.correct == true)
        #expect(byId["cover-2"]?.delta == -0.1 && byId["cover-2"]?.correct == false)
    }

    @Test func clampsXPToActivityOverride() throws {
        let req = try launchExample()
        var res = try resultExample(); res.xpEarned = 500
        let m = try SimulationResultMapper.map(res, context: context(req, xp: 25))
        #expect(m.outcome.xp == 25)
        #expect(m.adjustments.contains { $0.contains("xpEarned") })
    }

    @Test func clampsXPToLessonBudgetWhenNoOverride() throws {
        let req = try launchExample()
        var res = try resultExample(); res.xpEarned = 9999
        #expect(try SimulationResultMapper.map(res, context: context(req, budget: 60)).outcome.xp == 60)
    }

    @Test func clampsHeartsToRemaining() throws {
        let req = try launchExample()
        var res = try resultExample(); res.heartsLost = 9
        let m = try SimulationResultMapper.map(res, context: context(req, hearts: 2))
        #expect(m.outcome.heartsLost == 2)
    }

    @Test func unlimitedHeartsAreNotClamped() throws {
        let req = try launchExample()
        var res = try resultExample(); res.heartsLost = 9
        #expect(try SimulationResultMapper.map(res, context: context(req, hearts: 0, unlimited: true)).outcome.heartsLost == 9)
    }

    @Test func clampsScoreAndMasteryDeltas() throws {
        let req = try launchExample()
        var res = try resultExample()
        res.score = 400
        res.masterySignals = [.init(conceptId: "cover-3", delta: 1.0, evidence: "x"), .init(conceptId: "cover-2", delta: -5, evidence: "y")]
        let m = try SimulationResultMapper.map(res, context: context(req))
        #expect(m.outcome.score == 100)
        let d = Dictionary(uniqueKeysWithValues: m.outcome.conceptEvidence.map { ($0.conceptId, $0.delta) })
        #expect(d["cover-3"] == 0.40)      // per-session gain cap
        #expect(d["cover-2"] == -1.0)
    }

    @Test func aggregatesRepeatedSignalsThenCaps() throws {
        let req = try launchExample()
        var res = try resultExample()
        res.masterySignals = [.init(conceptId: "cover-3", delta: 0.3, evidence: "a"), .init(conceptId: "cover-3", delta: 0.3, evidence: "b"),
                              .init(conceptId: "downs", delta: 0.1, evidence: "c"), .init(conceptId: "downs", delta: -0.2, evidence: "d")]
        let m = try SimulationResultMapper.map(res, context: context(req))
        let d = Dictionary(uniqueKeysWithValues: m.outcome.conceptEvidence.map { ($0.conceptId, $0.delta) })
        #expect(d["cover-3"] == 0.40)
        #expect(abs((d["downs"] ?? 0) - (-0.1)) < 1e-9)
    }

    @Test func ignoresUnknownConceptIds() throws {
        let req = try launchExample(), res = try resultExample()
        let m = try SimulationResultMapper.map(res, context: context(req, known: ["cover-3"]))
        #expect(m.outcome.conceptEvidence.map(\.conceptId) == ["cover-3"])
        #expect(Set(m.ignoredConceptIds) == ["zone-vs-man", "cover-2"])
    }

    @Test func abortedResultsAwardNothing() throws {
        let req = try launchExample()
        var res = try resultExample()
        res.completed = false; res.aborted = true; res.abortReason = .userQuit
        let m = try SimulationResultMapper.map(res, context: context(req))
        #expect(m.outcome.xp == 0 && m.outcome.heartsLost == 0 && m.outcome.conceptEvidence.isEmpty && !m.outcome.correct)
    }

    @Test func rejectsWrongSessionSimulationAndContract() throws {
        let req = try launchExample()
        var a = try resultExample(); a.sessionId = "other"
        #expect(throws: BridgeError.self) { try SimulationResultMapper.map(a, context: context(req)) }
        var b = try resultExample(); b.simulationId = "racing.drafting.pack.v1"
        #expect(throws: BridgeError.self) { try SimulationResultMapper.map(b, context: context(req)) }
        var c = try resultExample(); c.contractVersion = "2.0.0"
        #expect(throws: BridgeError.contractUnsupported("2.0.0")) { try SimulationResultMapper.map(c, context: context(req)) }
    }

    @Test func rejectsInconsistentFlags() throws {
        let req = try launchExample()
        var a = try resultExample(); a.aborted = true; a.abortReason = .timeout
        #expect(throws: BridgeError.self) { try SimulationResultMapper.map(a, context: context(req)) }
        var b = try resultExample(); b.completed = false; b.aborted = true; b.abortReason = nil
        #expect(throws: BridgeError.self) { try SimulationResultMapper.map(b, context: context(req)) }
    }

    @Test func synthesizedAbortedResultIsFree() throws {
        let req = try launchExample()
        let r = SimulationResult.synthesizedAborted(for: req, reason: .timeout)
        let m = try SimulationResultMapper.map(r, context: context(req))
        #expect(r.aborted && !r.completed && m.outcome.xp == 0 && m.outcome.heartsLost == 0)
    }

    @Test func lowScoreIsNotCorrect() throws {
        let req = try launchExample()
        var res = try resultExample(); res.score = 40
        #expect(try SimulationResultMapper.map(res, context: context(req)).outcome.correct == false)
    }
}

@Suite("MockSimulationHost")
struct MockSimulationHostTests {
    @Test func returnsPlausibleResultAndEmitsEvents() async throws {
        let req = try launchExample()
        let host = MockSimulationHost(clock: FixedClock(Date(timeIntervalSince1970: 1_790_000_000)))
        let result = try await host.launch(req)
        #expect(result.sessionId == req.sessionId && result.simulationId == req.simulationId)
        #expect(result.completed && !result.aborted && result.outcomes.count == 3)
        #expect(result.masterySignals.map(\.conceptId) == ["cover-2", "zone-vs-man"])
        var types: [BridgeMessageType] = []
        var seqs: [Int] = []
        var it = host.events.makeAsyncIterator()
        for _ in 0..<4 { if let e = await it.next() { types.append(e.type); seqs.append(e.seq); #expect(e.direction == .unityToNative && e.sessionId == req.sessionId) } }
        #expect(types == [.ready, .progress, .result, .requestExit])
        #expect(seqs == [0, 1, 2, 3])
    }

    @Test func resultEventPayloadDecodesToTheReturnedResult() async throws {
        let req = try launchExample()
        let host = MockSimulationHost()
        let result = try await host.launch(req)
        var it = host.events.makeAsyncIterator()
        var found: SimulationResult?
        for _ in 0..<4 { if let e = await it.next(), e.type == .result { found = try e.simulationResult() } }
        #expect(found == result)
    }

    @Test func resultIsAppliedCleanlyByTheMapper() async throws {
        let req = try launchExample()
        let result = try await MockSimulationHost().launch(req)
        let m = try SimulationResultMapper.map(result, context: context(req))
        #expect(m.adjustments.isEmpty)
    }

    @Test func abortingBehaviorProducesAbortedResult() async throws {
        let host = MockSimulationHost(behavior: .aborts(.userQuit))
        let r = try await host.launch(try launchExample())
        #expect(r.aborted && r.abortReason == .userQuit && r.xpEarned == 0)
    }

    @Test func failureBehaviorThrowsBridgeError() async throws {
        let host = MockSimulationHost(behavior: .fails(.assetLoadFailed, recoverable: true))
        await #expect(throws: BridgeError.unity(code: .assetLoadFailed, message: "Mock failure", recoverable: true)) { try await host.launch(try launchExample()) }
    }

    @Test func rejectsUnsupportedContractMajor() async throws {
        var req = try launchExample(); req.contractVersion = "2.0.0"
        let host = MockSimulationHost()
        await #expect(throws: BridgeError.contractUnsupported("2.0.0")) { try await host.launch(req) }
    }

    @Test func recordsLaunchesAndPauseState() async throws {
        let host = MockSimulationHost()
        _ = try await host.launch(try launchExample())
        #expect(await host.launchedRequests.count == 1)
        await host.pause(reason: .user)
        #expect(await host.isPaused)
        await host.resume()
        #expect(await host.isPaused == false)
    }
}

@Suite("Bridge envelope")
struct EnvelopeTests {
    @Test func makeDerivesDirectionAndRoundTrips() throws {
        let e = try BridgeEvent.make(type: .abort, sessionId: "s", seq: 3, timestampMs: 5, payload: AbortPayload(reason: .timeout))
        #expect(e.direction == .nativeToUnity && e.isDirectionConsistent)
        let back = try JSONDecoder().decode(BridgeEvent.self, from: JSONEncoder().encode(e))
        #expect(try back.abort().reason == .timeout)
    }

    @Test func wrongTypedAccessThrows() throws {
        let e = try BridgeEvent.make(type: .resume, sessionId: "s", seq: 0, timestampMs: 0, payload: JSONValue.object([:]))
        #expect(throws: BridgeError.unexpectedType(expected: .result, actual: .resume)) { try e.simulationResult() }
    }

    @Test func mismatchedDirectionIsDetected() {
        let e = BridgeEvent(direction: .nativeToUnity, sessionId: "s", seq: 0, timestampMs: 0, type: .result, payload: .object([:]))
        #expect(!e.isDirectionConsistent)
    }

    @Test func errorPayloadCodes() throws {
        let p = try json(#"{"code":"CONFIG_INVALID","message":"bad","recoverable":false}"#).decode(BridgeErrorPayload.self)
        #expect(p.code == .configInvalid && !p.recoverable)
    }
}
