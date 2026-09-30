import Foundation

/// Codable types exactly matching docs/contracts/unity-bridge/v1 (contract 1.0.0).
public enum BridgeContract {
    public static let currentVersion = "1.0.0"
    public static let supportedMajor = 1
    public static let defaultReadyTimeoutMs = 8000
    public static let backgroundedTooLongSeconds = 120

    /// True if `version` is `1.x.y`.
    public static func isSupported(_ version: String) -> Bool {
        let parts = version.split(separator: ".")
        guard parts.count == 3, parts.allSatisfy({ Int($0) != nil }) else { return false }
        return Int(parts[0]) == supportedMajor
    }
}

// MARK: LaunchRequest

public struct LaunchRequest: Codable, Sendable, Hashable {
    public struct Runtime: Codable, Sendable, Hashable {
        public struct SafeAreaInsets: Codable, Sendable, Hashable {
            public var top: Double?
            public var bottom: Double?
            public var left: Double?
            public var right: Double?
            public init(top: Double? = nil, bottom: Double? = nil, left: Double? = nil, right: Double? = nil) {
                self.top = top; self.bottom = bottom; self.left = left; self.right = right
            }
        }
        public var maxDurationMs: Int
        public var heartsRemaining: Int
        public var unlimitedHearts: Bool?
        public var resumeState: JSONValue?
        public var safeAreaInsets: SafeAreaInsets?
        public var debug: Bool?

        public init(maxDurationMs: Int = 600_000, heartsRemaining: Int, unlimitedHearts: Bool? = nil,
                    resumeState: JSONValue? = nil, safeAreaInsets: SafeAreaInsets? = nil, debug: Bool? = nil) {
            self.maxDurationMs = maxDurationMs
            self.heartsRemaining = heartsRemaining
            self.unlimitedHearts = unlimitedHearts
            self.resumeState = resumeState
            self.safeAreaInsets = safeAreaInsets
            self.debug = debug
        }
    }

    public struct LearnerContext: Codable, Sendable, Hashable {
        /// DISPLAY ONLY. Never log, never put in telemetry.
        public var personName: String?
        public var relationship: Relationship?
        public var personalization: [String: JSONValue]?
        public var masteredConcepts: [ConceptID]
        public var weakConcepts: [ConceptID]
        public var accessibility: AccessibilityPreferences

        public init(personName: String? = nil, relationship: Relationship? = nil, personalization: [String: JSONValue]? = nil,
                    masteredConcepts: [ConceptID] = [], weakConcepts: [ConceptID] = [],
                    accessibility: AccessibilityPreferences = .init()) {
            self.personName = personName
            self.relationship = relationship
            self.personalization = personalization
            self.masteredConcepts = masteredConcepts
            self.weakConcepts = weakConcepts
            self.accessibility = accessibility
        }
    }

    public struct Theme: Codable, Sendable, Hashable {
        public enum ColorScheme: String, Codable, Sendable { case dark, light }
        public struct Colors: Codable, Sendable, Hashable {
            public var bg, bgDeep, surface, surface2, stroke, strokeStrong: String
            public var ink, ink2, ink3: String
            public var ink4, ink5: String?
            public var accent, accentSoft, accentTint, onAccent: String
            public var reward, rewardTint, court: String

            public init(bg: String, bgDeep: String, surface: String, surface2: String, stroke: String, strokeStrong: String,
                        ink: String, ink2: String, ink3: String, ink4: String? = nil, ink5: String? = nil,
                        accent: String, accentSoft: String, accentTint: String, onAccent: String,
                        reward: String, rewardTint: String, court: String) {
                self.bg = bg; self.bgDeep = bgDeep; self.surface = surface; self.surface2 = surface2
                self.stroke = stroke; self.strokeStrong = strokeStrong; self.ink = ink; self.ink2 = ink2; self.ink3 = ink3
                self.ink4 = ink4; self.ink5 = ink5; self.accent = accent; self.accentSoft = accentSoft
                self.accentTint = accentTint; self.onAccent = onAccent; self.reward = reward; self.rewardTint = rewardTint; self.court = court
            }
        }
        public struct Fonts: Codable, Sendable, Hashable {
            public var display: String
            public var ui: String
            public init(display: String = "Instrument Serif", ui: String = "Geist") { self.display = display; self.ui = ui }
        }
        public var colorScheme: ColorScheme
        public var colors: Colors
        public var fonts: Fonts

        public init(colorScheme: ColorScheme, colors: Colors, fonts: Fonts = .init()) {
            self.colorScheme = colorScheme; self.colors = colors; self.fonts = fonts
        }

        /// Resolved DESIGN_SPEC tokens (dark).
        public static let dark = Theme(colorScheme: .dark, colors: .init(
            bg: "#111014", bgDeep: "#0D0C10", surface: "#1A191F", surface2: "#26242B", stroke: "#FFFFFF12", strokeStrong: "#FFFFFF24",
            ink: "#F3EEE6", ink2: "#C9BFC4", ink3: "#A9A3AD", ink4: "#8D8791", ink5: "#6F6A74",
            accent: "#FF6F86", accentSoft: "#FF9AAB", accentTint: "#FF6F8624", onAccent: "#1A0E12",
            reward: "#E8C07A", rewardTint: "#E8C07A24", court: "#1D2A27"))

        /// Resolved DESIGN_SPEC tokens (light).
        public static let light = Theme(colorScheme: .light, colors: .init(
            bg: "#F7F3EC", bgDeep: "#EFE9DF", surface: "#FFFFFF", surface2: "#EDE7DD", stroke: "#14101614", strokeStrong: "#14101629",
            ink: "#17151A", ink2: "#4A434C", ink3: "#6B646E",
            accent: "#D93F5E", accentSoft: "#B8324F", accentTint: "#D93F5E1A", onAccent: "#FFFFFF",
            reward: "#A87A1E", rewardTint: "#A87A1E1A", court: "#D9E6DF"))
    }

    public var contractVersion: String
    public var sessionId: String
    public var simulationId: String
    public var simulationVersion: String
    public var courseId: CourseID
    public var unitId: UnitID
    public var lessonId: LessonID
    public var difficulty: Int
    public var locale: String
    public var configuration: [String: JSONValue]
    public var learnerContext: LearnerContext
    public var theme: Theme
    public var runtime: Runtime

    public init(contractVersion: String = BridgeContract.currentVersion, sessionId: String = UUID().uuidString.lowercased(),
                simulationId: String, simulationVersion: String, courseId: CourseID, unitId: UnitID, lessonId: LessonID,
                difficulty: Int, locale: String = "en-US", configuration: [String: JSONValue] = [:],
                learnerContext: LearnerContext, theme: Theme, runtime: Runtime) {
        self.contractVersion = contractVersion
        self.sessionId = sessionId
        self.simulationId = simulationId
        self.simulationVersion = simulationVersion
        self.courseId = courseId
        self.unitId = unitId
        self.lessonId = lessonId
        self.difficulty = difficulty
        self.locale = locale
        self.configuration = configuration
        self.learnerContext = learnerContext
        self.theme = theme
        self.runtime = runtime
    }
}

// MARK: SimulationResult

public enum SimulationAbortReason: String, Codable, Sendable, Hashable {
    case userQuit = "user-quit"
    case nativeAbort = "native-abort"
    case timeout
    case error
    case backgroundedTooLong = "backgrounded-too-long"
}

public struct SimulationResult: Codable, Sendable, Hashable {
    public struct Outcome: Codable, Sendable, Hashable {
        public var id: String
        public var success: Bool
        public var label: String?
        public var value: JSONValue?
        public init(id: String, success: Bool, label: String? = nil, value: JSONValue? = nil) {
            self.id = id; self.success = success; self.label = label; self.value = value
        }
    }
    public struct Mistake: Codable, Sendable, Hashable {
        public var conceptId: ConceptID
        public var description: String
        public var at: Int
        public init(conceptId: ConceptID, description: String, at: Int) {
            self.conceptId = conceptId; self.description = description; self.at = at
        }
    }
    public struct MasterySignal: Codable, Sendable, Hashable {
        public var conceptId: ConceptID
        public var delta: Double
        public var evidence: String
        public init(conceptId: ConceptID, delta: Double, evidence: String) {
            self.conceptId = conceptId; self.delta = delta; self.evidence = evidence
        }
    }
    public struct Telemetry: Codable, Sendable, Hashable {
        public var avgFps: Double?
        public var p5Fps: Double?
        public var loadTimeMs: Int?
        public var peakMemoryMb: Double?
        public var unityVersion: String?
        public var gameKitVersion: String?
        public init(avgFps: Double? = nil, p5Fps: Double? = nil, loadTimeMs: Int? = nil, peakMemoryMb: Double? = nil,
                    unityVersion: String? = nil, gameKitVersion: String? = nil) {
            self.avgFps = avgFps; self.p5Fps = p5Fps; self.loadTimeMs = loadTimeMs; self.peakMemoryMb = peakMemoryMb
            self.unityVersion = unityVersion; self.gameKitVersion = gameKitVersion
        }
    }

    public var contractVersion: String
    public var sessionId: String
    public var simulationId: String
    public var simulationVersion: String
    public var completed: Bool
    public var aborted: Bool
    public var abortReason: SimulationAbortReason?
    public var durationMs: Int
    public var score: Int
    public var accuracy: Double
    public var outcomes: [Outcome]
    public var mistakes: [Mistake]
    public var masterySignals: [MasterySignal]
    public var xpEarned: Int
    public var heartsLost: Int
    public var replayAvailable: Bool
    public var telemetry: Telemetry?

    public init(contractVersion: String = BridgeContract.currentVersion, sessionId: String, simulationId: String, simulationVersion: String,
                completed: Bool, aborted: Bool, abortReason: SimulationAbortReason? = nil, durationMs: Int, score: Int, accuracy: Double,
                outcomes: [Outcome] = [], mistakes: [Mistake] = [], masterySignals: [MasterySignal] = [], xpEarned: Int, heartsLost: Int,
                replayAvailable: Bool = false, telemetry: Telemetry? = nil) {
        self.contractVersion = contractVersion
        self.sessionId = sessionId
        self.simulationId = simulationId
        self.simulationVersion = simulationVersion
        self.completed = completed
        self.aborted = aborted
        self.abortReason = abortReason
        self.durationMs = durationMs
        self.score = score
        self.accuracy = accuracy
        self.outcomes = outcomes
        self.mistakes = mistakes
        self.masterySignals = masterySignals
        self.xpEarned = xpEarned
        self.heartsLost = heartsLost
        self.replayAvailable = replayAvailable
        self.telemetry = telemetry
    }

    /// Synthesized locally when Unity never sends a result (timeout / crash): 0 XP, no hearts lost.
    public static func synthesizedAborted(for request: LaunchRequest, reason: SimulationAbortReason, durationMs: Int = 0) -> SimulationResult {
        SimulationResult(sessionId: request.sessionId, simulationId: request.simulationId, simulationVersion: request.simulationVersion,
                         completed: false, aborted: true, abortReason: reason, durationMs: durationMs, score: 0, accuracy: 0,
                         xpEarned: 0, heartsLost: 0, replayAvailable: false)
    }
}

// MARK: Envelope

public enum BridgeDirection: String, Codable, Sendable, Hashable {
    case nativeToUnity = "native-to-unity"
    case unityToNative = "unity-to-native"
}

public enum BridgeMessageType: String, Codable, Sendable, Hashable, CaseIterable {
    case launch, pause, resume, abort
    case ready, progress, checkpoint, result, error, requestExit

    public var direction: BridgeDirection {
        switch self {
        case .launch, .pause, .resume, .abort: return .nativeToUnity
        default: return .unityToNative
        }
    }
}

public struct BridgeEvent: Codable, Sendable, Hashable {
    public var contractVersion: String
    public var direction: BridgeDirection
    public var sessionId: String
    public var seq: Int
    public var timestampMs: Int64
    public var type: BridgeMessageType
    public var payload: JSONValue

    public init(contractVersion: String = BridgeContract.currentVersion, direction: BridgeDirection, sessionId: String, seq: Int,
                timestampMs: Int64, type: BridgeMessageType, payload: JSONValue) {
        self.contractVersion = contractVersion
        self.direction = direction
        self.sessionId = sessionId
        self.seq = seq
        self.timestampMs = timestampMs
        self.type = type
        self.payload = payload
    }

    /// Build an envelope with an Encodable payload; direction is derived from the type.
    public static func make<P: Encodable>(type: BridgeMessageType, sessionId: String, seq: Int, timestampMs: Int64, payload: P) throws -> BridgeEvent {
        BridgeEvent(direction: type.direction, sessionId: sessionId, seq: seq, timestampMs: timestampMs, type: type, payload: try JSONValue.from(payload))
    }

    /// Envelope invariant from the schema: the type must match the direction.
    public var isDirectionConsistent: Bool { type.direction == direction }

    /// Typed payload accessors (throw if the type does not match).
    public func launchRequest() throws -> LaunchRequest { try decodePayload(.launch) }
    public func simulationResult() throws -> SimulationResult { try decodePayload(.result) }
    public func ready() throws -> ReadyPayload { try decodePayload(.ready) }
    public func progress() throws -> ProgressPayload { try decodePayload(.progress) }
    public func checkpoint() throws -> CheckpointPayload { try decodePayload(.checkpoint) }
    public func error() throws -> BridgeErrorPayload { try decodePayload(.error) }
    public func requestExit() throws -> RequestExitPayload { try decodePayload(.requestExit) }
    public func pause() throws -> PausePayload { try decodePayload(.pause) }
    public func abort() throws -> AbortPayload { try decodePayload(.abort) }

    private func decodePayload<T: Decodable>(_ expected: BridgeMessageType) throws -> T {
        guard type == expected else { throw BridgeError.unexpectedType(expected: expected, actual: type) }
        return try payload.decode(T.self)
    }
}

public struct ReadyPayload: Codable, Sendable, Hashable {
    public var unityVersion: String
    public var gameKitVersion: String
    public var simulationId: String
    public var simulationVersion: String
    public var supportedContractVersions: [String]
    public var loadTimeMs: Int?
    public init(unityVersion: String, gameKitVersion: String, simulationId: String, simulationVersion: String,
                supportedContractVersions: [String] = [BridgeContract.currentVersion], loadTimeMs: Int? = nil) {
        self.unityVersion = unityVersion; self.gameKitVersion = gameKitVersion; self.simulationId = simulationId
        self.simulationVersion = simulationVersion; self.supportedContractVersions = supportedContractVersions; self.loadTimeMs = loadTimeMs
    }
}

public struct ProgressPayload: Codable, Sendable, Hashable {
    public enum Stage: String, Codable, Sendable { case loading, playing, explaining, summarizing }
    public var fraction: Double
    public var stage: Stage?
    public var roundIndex: Int?
    public var roundCount: Int?
    public init(fraction: Double, stage: Stage? = nil, roundIndex: Int? = nil, roundCount: Int? = nil) {
        self.fraction = fraction; self.stage = stage; self.roundIndex = roundIndex; self.roundCount = roundCount
    }
}

public struct CheckpointPayload: Codable, Sendable, Hashable {
    public var checkpointId: String
    public var roundIndex: Int?
    public var scoreSoFar: Int?
    public var heartsLostSoFar: Int?
    public var resumeState: JSONValue?
}

public enum BridgeErrorCode: String, Codable, Sendable, Hashable {
    case contractUnsupported = "CONTRACT_UNSUPPORTED"
    case simulationUnknown = "SIMULATION_UNKNOWN"
    case simulationVersionUnsupported = "SIMULATION_VERSION_UNSUPPORTED"
    case configInvalid = "CONFIG_INVALID"
    case assetLoadFailed = "ASSET_LOAD_FAILED"
    case outOfMemory = "OUT_OF_MEMORY"
    case internalError = "INTERNAL_ERROR"
}

public struct BridgeErrorPayload: Codable, Sendable, Hashable {
    public var code: BridgeErrorCode
    public var message: String
    public var recoverable: Bool
    public var detail: JSONValue?
    public init(code: BridgeErrorCode, message: String, recoverable: Bool, detail: JSONValue? = nil) {
        self.code = code; self.message = message; self.recoverable = recoverable; self.detail = detail
    }
}

public struct RequestExitPayload: Codable, Sendable, Hashable {
    public enum Reason: String, Codable, Sendable { case completed, userQuit = "user-quit", needsNativeUI = "needs-native-ui", fatal }
    public var reason: Reason
    public init(reason: Reason) { self.reason = reason }
}

public struct PausePayload: Codable, Sendable, Hashable {
    public enum Reason: String, Codable, Sendable { case appBackgrounded = "app-backgrounded", interruption, nativeOverlay = "native-overlay", user }
    public var reason: Reason
    public init(reason: Reason) { self.reason = reason }
}

public struct AbortPayload: Codable, Sendable, Hashable {
    public enum Reason: String, Codable, Sendable {
        case userQuit = "user-quit", timeout, backgroundedTooLong = "backgrounded-too-long"
        case memoryPressure = "memory-pressure", nativeError = "native-error"
    }
    public var reason: Reason
    public init(reason: Reason) { self.reason = reason }
}

public enum BridgeError: Error, Sendable, Equatable {
    case unexpectedType(expected: BridgeMessageType, actual: BridgeMessageType)
    case contractUnsupported(String)
    case sessionMismatch(expected: String, actual: String)
    case simulationMismatch(expected: String, actual: String)
    case inconsistentResult(String)
    case unity(code: BridgeErrorCode, message: String, recoverable: Bool)
    case aborted
}
