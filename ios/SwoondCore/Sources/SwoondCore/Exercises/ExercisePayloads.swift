import Foundation

/// Codable payloads matching docs/contracts/native-exercises/v1/<type>.schema.json exactly.

public struct ExerciseExplanation: Codable, Sendable, Hashable {
    public var correct: String
    public var incorrect: String
    public var sayThisLine: String?
    public init(correct: String, incorrect: String, sayThisLine: String? = nil) {
        self.correct = correct; self.incorrect = incorrect; self.sayThisLine = sayThisLine
    }
}

public struct TextOption: Codable, Sendable, Hashable, Identifiable {
    public var id: String
    public var text: String
    public var explanation: String?
    public init(id: String, text: String, explanation: String? = nil) { self.id = id; self.text = text; self.explanation = explanation }
}

public struct MultipleChoicePayload: Codable, Sendable, Hashable {
    public var prompt: String
    public var options: [TextOption]
    public var correctOptionIds: [String]
    public var allowMultiple: Bool?
    public var shuffle: Bool?
    public var explanation: ExerciseExplanation
    public init(prompt: String, options: [TextOption], correctOptionIds: [String], allowMultiple: Bool? = nil, shuffle: Bool? = nil, explanation: ExerciseExplanation) {
        self.prompt = prompt; self.options = options; self.correctOptionIds = correctOptionIds
        self.allowMultiple = allowMultiple; self.shuffle = shuffle; self.explanation = explanation
    }
}

public struct BinaryCallPayload: Codable, Sendable, Hashable {
    public struct Scene: Codable, Sendable, Hashable {
        public enum Kind: String, Codable, Sendable { case courtDiagram = "court-diagram", fieldDiagram = "field-diagram", image, none }
        public struct Marker: Codable, Sendable, Hashable {
            public enum Role: String, Codable, Sendable { case player, ball, opponent, target }
            public var role: Role
            public var x: Double
            public var y: Double
        }
        public var kind: Kind
        public var diagramId: String?
        public var markers: [Marker]?
        public var image: String?
        public var alt: String
    }
    public struct Choice: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var label: String
        public init(id: String, label: String) { self.id = id; self.label = label }
    }
    public var prompt: String
    public var scene: Scene
    public var choices: [Choice]
    public var correctChoiceId: String
    public var explanation: ExerciseExplanation
    public var ruleTag: String?
}

public struct TermMatchPayload: Codable, Sendable, Hashable {
    public struct Pair: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var term: String
        public var definition: String
        public init(id: String, term: String, definition: String) { self.id = id; self.term = term; self.definition = definition }
    }
    public struct Explanation: Codable, Sendable, Hashable {
        public var summary: String
        public var sayThisLine: String?
    }
    public var prompt: String
    public var pairs: [Pair]
    public var distractorDefinitions: [String]?
    public var explanation: Explanation
}

public struct SequenceOrderPayload: Codable, Sendable, Hashable {
    public struct Item: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var text: String
        public var why: String?
        public init(id: String, text: String, why: String? = nil) { self.id = id; self.text = text; self.why = why }
    }
    public var prompt: String
    /// Authored in correct order.
    public var items: [Item]
    public var partialCredit: Bool?
    public var explanation: ExerciseExplanation
}

public struct VisualIDPayload: Codable, Sendable, Hashable {
    public struct Image: Codable, Sendable, Hashable {
        public var asset: String
        public var alt: String
        public var license: String
        public var attribution: String?
    }
    public struct Option: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var text: String
        public var explanation: String?
        public var image: String?
    }
    public var prompt: String
    public var image: Image
    public var options: [Option]
    public var correctOptionId: String
    public var explanation: ExerciseExplanation
    public var cues: [String]?
}

public struct DecisionScenarioPayload: Codable, Sendable, Hashable {
    public struct Situation: Codable, Sendable, Hashable {
        public struct Fact: Codable, Sendable, Hashable {
            public enum Emphasis: String, Codable, Sendable { case none, warning }
            public var label: String
            public var value: String
            public var emphasis: Emphasis?
        }
        public var narrative: String?
        public var facts: [Fact]
    }
    public enum Verdict: String, Codable, Sendable { case best, acceptable, poor }
    public struct Option: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var label: String
        public var verdict: Verdict
        public var consequence: String
        public var considerations: [String]
    }
    public var prompt: String
    public var situation: Situation
    public var options: [Option]
    public var expertNote: String
    public var sayThisLine: String?
    public var safetyNote: String?
}

public struct TalkTrackPayload: Codable, Sendable, Hashable {
    public struct Reply: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var text: String
        public var smoothDelta: Int
        public var theirResponse: String
        public var coachNote: String
    }
    public struct Exchange: Codable, Sendable, Hashable {
        public var theirMessage: String
        public var replies: [Reply]
    }
    public var title: String
    public var setting: String?
    public var startingSmooth: Int?
    public var exchanges: [Exchange]
    public var closingNote: String?
}

public struct TimingTapPayload: Codable, Sendable, Hashable {
    public struct Theme: Codable, Sendable, Hashable {
        public enum ResultUnit: String, Codable, Sendable { case seconds, points }
        public var label: String
        public var resultUnit: ResultUnit?
    }
    public struct Round: Codable, Sendable, Hashable {
        public var zoneStartPct: Double
        public var zoneEndPct: Double
        public var sweepSeconds: Double
        public init(zoneStartPct: Double, zoneEndPct: Double, sweepSeconds: Double) {
            self.zoneStartPct = zoneStartPct; self.zoneEndPct = zoneEndPct; self.sweepSeconds = sweepSeconds
        }
    }
    public enum AccessibilityAlternative: String, Codable, Sendable { case tapToStopSlow = "tap-to-stop-slow", holdAndRelease = "hold-and-release" }
    public var prompt: String
    public var theme: Theme
    public var rounds: [Round]
    public var explanation: ExerciseExplanation
    public var accessibilityAlternative: AccessibilityAlternative?
}

public struct SayThisPayload: Codable, Sendable, Hashable {
    public struct Statement: Codable, Sendable, Hashable { public var speaker: String; public var text: String }
    public struct Option: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var text: String
        public var explanation: String?
        public var isCorrect: Bool
    }
    public struct FollowUp: Codable, Sendable, Hashable { public var line: String; public var why: String }
    public var statement: Statement
    public var question: String?
    public var options: [Option]
    public var translation: String
    public var followUps: [FollowUp]
    public var noFakeExpertNote: String?
}

public struct FillTheGapPayload: Codable, Sendable, Hashable {
    public struct Gap: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var options: [String]
        public var correct: String
    }
    public var prompt: String
    /// Contains `{{gapId}}` tokens.
    public var template: String
    public var gaps: [Gap]
    public var explanation: ExerciseExplanation
}

public struct ListeningIDPayload: Codable, Sendable, Hashable {
    public struct Audio: Codable, Sendable, Hashable {
        public var asset: String
        public var durationMs: Int
        public var license: String
        public var attribution: String?
        public var description: String
        public var maxPlays: Int?
    }
    public var prompt: String
    public var audio: Audio
    public var options: [TextOption]
    public var correctOptionId: String
    public var explanation: ExerciseExplanation
    public var listenFor: [String]?
}

public struct EstimateSliderPayload: Codable, Sendable, Hashable {
    public struct Tolerance: Codable, Sendable, Hashable { public var full: Double; public var partial: Double }
    public var prompt: String
    public var unit: String
    public var min: Double
    public var max: Double
    public var step: Double
    public var correctValue: Double
    public var tolerance: Tolerance
    public var explanation: ExerciseExplanation
}

public enum HotspotShape: Codable, Sendable, Hashable {
    case circle(cx: Double, cy: Double, r: Double)
    case rect(x: Double, y: Double, w: Double, h: Double)

    enum CodingKeys: String, CodingKey { case kind, cx, cy, r, x, y, w, h }

    public init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: CodingKeys.self)
        switch try c.decode(String.self, forKey: .kind) {
        case "circle": self = .circle(cx: try c.decode(Double.self, forKey: .cx), cy: try c.decode(Double.self, forKey: .cy), r: try c.decode(Double.self, forKey: .r))
        case "rect": self = .rect(x: try c.decode(Double.self, forKey: .x), y: try c.decode(Double.self, forKey: .y), w: try c.decode(Double.self, forKey: .w), h: try c.decode(Double.self, forKey: .h))
        case let k: throw DecodingError.dataCorruptedError(forKey: .kind, in: c, debugDescription: "Unknown hotspot shape \(k)")
        }
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .circle(let cx, let cy, let r):
            try c.encode("circle", forKey: .kind); try c.encode(cx, forKey: .cx); try c.encode(cy, forKey: .cy); try c.encode(r, forKey: .r)
        case .rect(let x, let y, let w, let h):
            try c.encode("rect", forKey: .kind); try c.encode(x, forKey: .x); try c.encode(y, forKey: .y); try c.encode(w, forKey: .w); try c.encode(h, forKey: .h)
        }
    }
}

public struct HotspotTapPayload: Codable, Sendable, Hashable {
    public struct Diagram: Codable, Sendable, Hashable {
        public var asset: String?
        public var diagramId: String?
        public var aspectRatio: Double?
        public var alt: String
    }
    public struct Hotspot: Codable, Sendable, Hashable, Identifiable {
        public var id: String
        public var label: String
        public var shape: HotspotShape
    }
    public var prompt: String
    public var diagram: Diagram
    public var hotspots: [Hotspot]
    public var correctHotspotIds: [String]
    public var explanation: ExerciseExplanation
}
