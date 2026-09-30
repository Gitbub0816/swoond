import Foundation
import Testing
@testable import SwoondCore

@Suite("Contract conformance: unity-bridge v1 examples")
struct BridgeContractTests {
    static let files: [URL] = (try? Fixtures.jsonFiles(in: Fixtures.bridgeExamples)) ?? []

    @Test func examplesDirectoryIsNotEmpty() {
        #expect(Self.files.count >= 5)
    }

    @Test(arguments: BridgeContractTests.files)
    func decodesAndRoundTrips(_ url: URL) throws {
        let name = url.lastPathComponent
        let data = try Fixtures.data(url)
        let original = try Fixtures.value(url)
        if name.hasSuffix("-launch.json") {
            let v = try JSONDecoder().decode(LaunchRequest.self, from: data)
            let again = try JSONDecoder().decode(LaunchRequest.self, from: JSONEncoder().encode(v))
            #expect(v == again)
            #expect(BridgeContract.isSupported(v.contractVersion))
        } else if name.hasSuffix("-result.json") {
            let v = try JSONDecoder().decode(SimulationResult.self, from: data)
            let again = try JSONDecoder().decode(SimulationResult.self, from: JSONEncoder().encode(v))
            #expect(v == again)
        } else if name.hasPrefix("msg-") {
            let v = try JSONDecoder().decode(BridgeEvent.self, from: data)
            let again = try JSONDecoder().decode(BridgeEvent.self, from: JSONEncoder().encode(v))
            #expect(v == again)
            #expect(v.isDirectionConsistent)
            // The envelope re-encodes to exactly the authored JSON.
            #expect(try JSONValue.from(v) == original)
            switch v.type {
            case .launch: _ = try v.launchRequest()
            case .result: _ = try v.simulationResult()
            case .ready: _ = try v.ready()
            case .progress: _ = try v.progress()
            case .checkpoint: _ = try v.checkpoint()
            case .error: _ = try v.error()
            case .requestExit: _ = try v.requestExit()
            case .pause: _ = try v.pause()
            case .abort: _ = try v.abort()
            case .resume: break
            }
        } else {
            Issue.record("Unrecognized bridge example \(name): add it to the conformance test")
        }
    }

    @Test func launchRequestReencodesToTheAuthoredJSON() throws {
        let url = Fixtures.bridgeExamples.appendingPathComponent("football-coverage-read-launch.json")
        let v = try JSONDecoder().decode(LaunchRequest.self, from: Fixtures.data(url))
        var expected = try Fixtures.value(url)
        // The example spells out `resumeState: null`; Swift omits nil optionals (semantically identical for the schema).
        if case .object(var o) = expected, case .object(var rt)? = o["runtime"] {
            rt["resumeState"] = nil
            o["runtime"] = .object(rt)
            expected = .object(o)
        }
        #expect(try JSONValue.from(v) == expected)
    }

    @Test func resultReencodesToTheAuthoredJSON() throws {
        let url = Fixtures.bridgeExamples.appendingPathComponent("football-coverage-read-result.json")
        let v = try JSONDecoder().decode(SimulationResult.self, from: Fixtures.data(url))
        #expect(try JSONValue.from(v) == Fixtures.value(url))
        #expect(v.score == 82 && v.outcomes.count == 3 && v.masterySignals.count == 3)
    }

    @Test func launchExampleFields() throws {
        let v = try JSONDecoder().decode(LaunchRequest.self, from: Fixtures.data(Fixtures.bridgeExamples.appendingPathComponent("football-coverage-read-launch.json")))
        #expect(v.simulationId == "football.coverage.read.v1")
        #expect(v.learnerContext.relationship == .crush)
        #expect(v.learnerContext.personalization?["favoriteTeam"] == .string("Philadelphia Eagles"))
        #expect(v.configuration["scenarioCount"]?.intValue == 3)
        #expect(v.theme.colors.accent == "#FF6F86")
        #expect(v.runtime.heartsRemaining == 5)
    }

    @Test func unknownPropertiesAreIgnored() throws {
        var obj = try Fixtures.value(Fixtures.bridgeExamples.appendingPathComponent("football-coverage-read-result.json"))
        if case .object(var o) = obj { o["futureField"] = "x"; obj = .object(o) }
        let data = try JSONEncoder().encode(obj)
        #expect(throws: Never.self) { _ = try JSONDecoder().decode(SimulationResult.self, from: data) }
    }

    @Test func messageTypeDirections() {
        for t in [BridgeMessageType.launch, .pause, .resume, .abort] { #expect(t.direction == .nativeToUnity) }
        for t in [BridgeMessageType.ready, .progress, .checkpoint, .result, .error, .requestExit] { #expect(t.direction == .unityToNative) }
    }

    @Test func contractVersionSupport() {
        #expect(BridgeContract.isSupported("1.0.0"))
        #expect(BridgeContract.isSupported("1.7.3"))
        #expect(!BridgeContract.isSupported("2.0.0"))
        #expect(!BridgeContract.isSupported("1.0"))
        #expect(!BridgeContract.isSupported("garbage"))
    }
}

@Suite("Contract conformance: curriculum, manifest, native exercises")
struct ContentContractTests {
    static let exerciseFiles: [URL] = (try? Fixtures.jsonFiles(in: Fixtures.exerciseExamples)) ?? []

    @Test func curriculumExampleDecodesAndMirrorsSchemaExactly() throws {
        let c = try Fixtures.curriculum()
        #expect(c.courseId == "american-football")
        #expect(c.units.count == 2)
        #expect(c.concepts.count == 6)
        #expect(c.reviewPolicy.intervalsDays == [1, 3, 7, 14, 30, 60])
        #expect(c.reviewPolicy.reviewActivityTypes?.contains(.termMatch) == true)
        // Typed model -> JSON must equal the authored file (no dropped or invented fields).
        #expect(try JSONValue.from(c) == Fixtures.value(Fixtures.curriculumURL))
    }

    @Test func manifestExampleDecodesAndMirrorsSchemaExactly() throws {
        let m = try Fixtures.manifest()
        #expect(m.courseId == "american-football")
        #expect(m.simulationPrefix == "football")
        #expect(m.interactionTypes.contains(.unitySim))
        #expect(m.masteryModel.passThreshold == 0.8)
        #expect(m.branches.map(\.id) == ["nfl", "college-football"])
        #expect(try JSONValue.from(m) == Fixtures.value(Fixtures.manifestURL))
    }

    @Test func exampleSetCoversEveryNativeType() {
        let names = Set(Self.exerciseFiles.map { $0.lastPathComponent.replacingOccurrences(of: ".example.json", with: "") })
        let native = Set(ActivityType.allCases.filter(\.isNative).map(\.rawValue))
        #expect(native == names)
    }

    @Test(arguments: ContentContractTests.exerciseFiles)
    func exercisePayloadDecodesBuildsEngineAndMirrorsSchema(_ url: URL) throws {
        let typeName = url.lastPathComponent.replacingOccurrences(of: ".example.json", with: "")
        let type = try #require(ActivityType(rawValue: typeName))
        let payload = try Fixtures.value(url)
        // Engine construction decodes the typed payload and validates it.
        let session = try ExerciseSessionFactory.make(type: type, payload: payload, conceptIds: ["c"])
        #expect(session.activityType == type)
        // Typed payload re-encodes to exactly the authored JSON.
        let typed: any Encodable = try Self.decodeTyped(type, payload)
        #expect(try JSONValue.from(typed) == payload)
    }

    static func decodeTyped(_ type: ActivityType, _ p: JSONValue) throws -> any Encodable {
        switch type {
        case .multipleChoice: return try p.decode(MultipleChoicePayload.self)
        case .binaryCall: return try p.decode(BinaryCallPayload.self)
        case .termMatch: return try p.decode(TermMatchPayload.self)
        case .sequenceOrder: return try p.decode(SequenceOrderPayload.self)
        case .visualId: return try p.decode(VisualIDPayload.self)
        case .decisionScenario: return try p.decode(DecisionScenarioPayload.self)
        case .talkTrack: return try p.decode(TalkTrackPayload.self)
        case .timingTap: return try p.decode(TimingTapPayload.self)
        case .sayThis: return try p.decode(SayThisPayload.self)
        case .fillTheGap: return try p.decode(FillTheGapPayload.self)
        case .listeningId: return try p.decode(ListeningIDPayload.self)
        case .estimateSlider: return try p.decode(EstimateSliderPayload.self)
        case .hotspotTap: return try p.decode(HotspotTapPayload.self)
        case .unitySim: return try p.decode(UnitySimPayload.self)
        }
    }

    @Test func layersAndActivityTypesMatchSchemaEnums() {
        #expect(Layer.allCases.map(\.rawValue) == ["foundations", "intermediate", "enthusiast", "branch", "current-season", "conversation", "review"])
        #expect(ActivityType.allCases.count == 14)
    }

    @Test func relationshipRawValuesMatchBridgeEnum() {
        #expect(Relationship.allCases.map(\.rawValue) == ["crush", "dating-partner", "spouse", "friend", "family-member", "parent", "child", "coworker", "other"])
    }
}

@Suite("JSONValue")
struct JSONValueTests {
    @Test func roundTripsAllKinds() throws {
        let v = json(#"{"a":1,"b":[true,null,"x",2.5],"c":{"d":"e"}}"#)
        let again = try JSONDecoder().decode(JSONValue.self, from: JSONEncoder().encode(v))
        #expect(v == again)
        #expect(v["a"]?.intValue == 1)
        #expect(v["b"]?.arrayValue?.count == 4)
        #expect(v["c"]?["d"]?.stringValue == "e")
        #expect(v["b"]?.arrayValue?[1].isNull == true)
    }

    @Test func boolIsNotNumber() {
        #expect(json("true").boolValue == true)
        #expect(json("true").doubleValue == nil)
        #expect(json("1").boolValue == nil)
    }

    @Test func intValueRejectsFractions() {
        #expect(json("2.5").intValue == nil)
        #expect(json("3").intValue == 3)
    }

    @Test func encodeDecodeBridgeToTypes() throws {
        let p = ProgressPayload(fraction: 0.5, stage: .playing)
        let v = try JSONValue.from(p)
        #expect(try v.decode(ProgressPayload.self) == p)
    }
}
