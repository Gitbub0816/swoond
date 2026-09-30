import Foundation

// MARK: fill-the-gap

/// All gaps correct = correct (v1). Standard +10 / -1 heart.
public struct FillTheGapEngine: ExerciseSession {
    public enum Segment: Sendable, Equatable { case text(String), gap(id: String) }

    public let payload: FillTheGapPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .fillTheGap }

    public init(payload: FillTheGapPayload, conceptIds: [ConceptID] = []) throws {
        let ids = Set(payload.gaps.map(\.id))
        guard !payload.gaps.isEmpty, ids.count == payload.gaps.count else { throw ExerciseError.invalidPayload("gaps must have unique ids") }
        for g in payload.gaps {
            guard g.options.contains(g.correct) else { throw ExerciseError.invalidPayload("gap \(g.id): correct not among options") }
            guard payload.template.contains("{{\(g.id)}}") else { throw ExerciseError.invalidPayload("template lacks {{\(g.id)}}") }
        }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    /// Template split into text and gap segments, for rendering ("blank 1 of 2").
    public var segments: [Segment] {
        var out: [Segment] = []
        var rest = Substring(payload.template)
        while let open = rest.range(of: "{{"), let close = rest[open.upperBound...].range(of: "}}") {
            if open.lowerBound > rest.startIndex { out.append(.text(String(rest[rest.startIndex..<open.lowerBound]))) }
            out.append(.gap(id: String(rest[open.upperBound..<close.lowerBound])))
            rest = rest[close.upperBound...]
        }
        if !rest.isEmpty { out.append(.text(String(rest))) }
        return out
    }

    /// The sentence with the given (or correct) answers filled in.
    public func filledSentence(with answers: [String: String]? = nil) -> String {
        segments.map {
            switch $0 {
            case .text(let t): return t
            case .gap(let id): return answers?[id] ?? payload.gaps.first { $0.id == id }?.correct ?? ""
            }
        }.joined()
    }

    @discardableResult
    public mutating func submit(answers: [String: String]) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        for g in payload.gaps {
            guard let a = answers[g.id] else { throw ExerciseError.invalidAnswer("missing answer for gap \(g.id)") }
            guard g.options.contains(a) else { throw ExerciseError.invalidAnswer("gap \(g.id): \(a) is not an option") }
        }
        let correct = payload.gaps.allSatisfy { answers[$0.id] == $0.correct }   // v1: all-or-nothing
        let e = ExerciseEvaluation.standard(.fillTheGap, correct: correct, explanation: payload.explanation, notes: [filledSentence()], conceptIds: conceptIds)
        evaluation = e
        return e
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        guard case .gaps(let a) = answer else { throw ExerciseError.unsupportedAnswer(expected: ".gaps") }
        return .finished(try submit(answers: a))
    }
}

// MARK: estimate-slider

/// within `full` = 100 (+10); within `partial` = 50 (+5); else 0 (-1 heart).
public struct EstimateSliderEngine: ExerciseSession {
    public let payload: EstimateSliderPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .estimateSlider }

    public init(payload: EstimateSliderPayload, conceptIds: [ConceptID] = []) throws {
        guard payload.max > payload.min, payload.step > 0 else { throw ExerciseError.invalidPayload("bad slider range") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    /// Snap to the slider step and clamp into range.
    public func snapped(_ v: Double) -> Double {
        let clamped = Swift.min(payload.max, Swift.max(payload.min, v))
        let steps = ((clamped - payload.min) / payload.step).rounded()
        return Swift.min(payload.max, payload.min + steps * payload.step)
    }

    @discardableResult
    public mutating func submit(value: Double) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        guard value.isFinite else { throw ExerciseError.invalidAnswer("non-finite value") }
        let v = snapped(value)
        let diff = abs(v - payload.correctValue)
        let score: Int, xp: Int, hearts: Int, fraction: Double
        if diff <= payload.tolerance.full { (score, xp, hearts, fraction) = (100, XPValues.correctAnswer, 0, 1) }
        else if diff <= payload.tolerance.partial { (score, xp, hearts, fraction) = (50, XPValues.halfCredit, 0, 0.5) }
        else { (score, xp, hearts, fraction) = (0, 0, 1, 0) }
        let full = score == 100
        let e = ExerciseEvaluation(activityType: .estimateSlider, isCorrect: full, score: score, xp: xp, heartsLost: hearts,
                                   explanation: full ? payload.explanation.correct : payload.explanation.incorrect,
                                   sayThisLine: payload.explanation.sayThisLine,
                                   notes: ["Answer: \(Self.format(payload.correctValue)) \(payload.unit); you said \(Self.format(v))"],
                                   conceptIds: conceptIds, masteryFraction: fraction)
        evaluation = e
        return e
    }

    static func format(_ d: Double) -> String { d == d.rounded() ? String(Int(d)) : String(d) }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        guard case .value(let v) = answer else { throw ExerciseError.unsupportedAnswer(expected: ".value") }
        return .finished(try submit(value: v))
    }
}

// MARK: hotspot-tap

/// Right/wrong: tap inside any correct hotspot. Standard +10 / -1 heart.
public struct HotspotTapEngine: ExerciseSession {
    public let payload: HotspotTapPayload
    public let conceptIds: [ConceptID]
    /// Extra normalized slop added to every hotspot so 44 pt targets stay tappable on small diagrams.
    public let tapSlop: Double
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .hotspotTap }

    public init(payload: HotspotTapPayload, conceptIds: [ConceptID] = [], tapSlop: Double = 0) throws {
        guard payload.diagram.asset != nil || payload.diagram.diagramId != nil else { throw ExerciseError.invalidPayload("diagram needs asset or diagramId") }
        let ids = Set(payload.hotspots.map(\.id))
        guard payload.hotspots.count >= 2, !payload.correctHotspotIds.isEmpty, Set(payload.correctHotspotIds).isSubset(of: ids) else { throw ExerciseError.invalidPayload("correctHotspotIds must reference hotspots") }
        self.payload = payload
        self.conceptIds = conceptIds
        self.tapSlop = tapSlop
    }

    /// Hit test in normalized coordinates. Circle radii are fractions of the diagram *width*, so the y distance is
    /// scaled by the aspect ratio (width / height, default 1).
    public static func contains(_ shape: HotspotShape, x: Double, y: Double, aspectRatio: Double = 1, slop: Double = 0) -> Bool {
        switch shape {
        case .circle(let cx, let cy, let r):
            let dx = x - cx, dy = (y - cy) / aspectRatio
            return (dx * dx + dy * dy).squareRoot() <= r + slop
        case .rect(let rx, let ry, let w, let h):
            return x >= rx - slop && x <= rx + w + slop && y >= ry - slop && y <= ry + h + slop
        }
    }

    /// The hotspot under a point; the smallest-area (or first) when several overlap.
    public func hotspot(atX x: Double, y: Double) -> HotspotTapPayload.Hotspot? {
        let ar = payload.diagram.aspectRatio ?? 1
        return payload.hotspots.first { Self.contains($0.shape, x: x, y: y, aspectRatio: ar, slop: tapSlop) }
    }

    @discardableResult
    public mutating func submit(hotspotId: String?) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        if let id = hotspotId, !payload.hotspots.contains(where: { $0.id == id }) { throw ExerciseError.invalidAnswer("unknown hotspot") }
        let correct = hotspotId.map(payload.correctHotspotIds.contains) ?? false
        let labels = payload.hotspots.filter { payload.correctHotspotIds.contains($0.id) }.map(\.label)
        let e = ExerciseEvaluation.standard(.hotspotTap, correct: correct, explanation: payload.explanation,
                                            notes: labels.map { "Correct: \($0)" }, conceptIds: conceptIds)
        evaluation = e
        return e
    }

    @discardableResult
    public mutating func submit(x: Double, y: Double) throws -> ExerciseEvaluation {
        try submit(hotspotId: hotspot(atX: x, y: y)?.id)
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        switch answer {
        case .point(let x, let y): return .finished(try submit(x: x, y: y))
        case .choices(let ids):
            guard let id = ids.first else { throw ExerciseError.invalidAnswer("empty selection") }
            return .finished(try submit(hotspotId: id))
        default: throw ExerciseError.unsupportedAnswer(expected: ".point or .choices")
        }
    }
}

// MARK: sequence-order

/// Score = fraction of items in correct position, LCS-based. < 60% costs a heart; 100% = +10, >= 60% = +5.
public struct SequenceOrderEngine: ExerciseSession {
    public let payload: SequenceOrderPayload
    public let conceptIds: [ConceptID]
    public private(set) var evaluation: ExerciseEvaluation?
    public var activityType: ActivityType { .sequenceOrder }

    public init(payload: SequenceOrderPayload, conceptIds: [ConceptID] = []) throws {
        guard payload.items.count >= 2, Set(payload.items.map(\.id)).count == payload.items.count else { throw ExerciseError.invalidPayload("items must be >= 2 with unique ids") }
        self.payload = payload
        self.conceptIds = conceptIds
    }

    public var correctOrder: [String] { payload.items.map(\.id) }

    /// Items shown to the learner: deterministic shuffle that is guaranteed not to equal the answer.
    public func initialOrder<G: RandomNumberGenerator>(using g: inout G) -> [SequenceOrderPayload.Item] {
        var items = payload.items
        for _ in 0..<8 {
            items.shuffle(using: &g)
            if items.map(\.id) != correctOrder { return items }
        }
        return Array(payload.items.reversed())
    }

    public static func lcsLength(_ a: [String], _ b: [String]) -> Int {
        guard !a.isEmpty, !b.isEmpty else { return 0 }
        var prev = [Int](repeating: 0, count: b.count + 1)
        for x in a {
            var cur = [Int](repeating: 0, count: b.count + 1)
            for (j, y) in b.enumerated() { cur[j + 1] = x == y ? prev[j] + 1 : Swift.max(prev[j + 1], cur[j]) }
            prev = cur
        }
        return prev[b.count]
    }

    @discardableResult
    public mutating func submit(order: [String]) throws -> ExerciseEvaluation {
        guard evaluation == nil else { throw ExerciseError.alreadyFinished }
        guard Set(order) == Set(correctOrder), order.count == correctOrder.count else { throw ExerciseError.invalidAnswer("order must contain every item exactly once") }
        let partial = payload.partialCredit ?? true
        let fraction = Double(Self.lcsLength(order, correctOrder)) / Double(correctOrder.count)
        let perfect = order == correctOrder
        let score = perfect ? 100 : (partial ? Int((fraction * 100).rounded(.down)) : 0)
        let xp = perfect ? XPValues.correctAnswer : (partial && fraction >= 0.6 ? XPValues.halfCredit : 0)
        let hearts = fraction < 0.6 ? 1 : 0
        let notes = payload.items.enumerated().map { "\($0.offset + 1). \($0.element.text)" + ($0.element.why.map { " (\($0))" } ?? "") }
        let e = ExerciseEvaluation(activityType: .sequenceOrder, isCorrect: perfect, score: score, xp: xp, heartsLost: hearts,
                                   explanation: perfect ? payload.explanation.correct : payload.explanation.incorrect,
                                   sayThisLine: payload.explanation.sayThisLine, notes: notes, conceptIds: conceptIds,
                                   masteryFraction: perfect ? 1 : (partial ? fraction : 0))
        evaluation = e
        return e
    }

    public mutating func submit(_ answer: ExerciseAnswer) throws -> ExerciseStepResult {
        guard case .order(let o) = answer else { throw ExerciseError.unsupportedAnswer(expected: ".order") }
        return .finished(try submit(order: o))
    }
}
