import Foundation
import Testing
@testable import SwoondCore

private func example(_ name: String) throws -> JSONValue { try Fixtures.value(Fixtures.exerciseExamples.appendingPathComponent("\(name).example.json")) }
private func payload<T: Decodable>(_ name: String, _ t: T.Type = T.self) throws -> T { try example(name).decode(T.self) }

@Suite("multiple-choice")
struct MultipleChoiceTests {
    @Test func correctAnswerScoresXP() throws {
        var e = try MultipleChoiceEngine(payload: payload("multiple-choice"), conceptIds: ["downs"])
        let ev = try e.submit(selected: ["b"])
        #expect(ev.isCorrect && ev.xp == 10 && ev.heartsLost == 0 && ev.score == 100 && ev.title == "Nice read.")
        #expect(ev.conceptIds == ["downs"])
        #expect(ev.sayThisLine == "They should have gone for it on fourth down.")
        #expect(e.evaluation == ev)
    }

    @Test func wrongAnswerCostsHeart() throws {
        var e = try MultipleChoiceEngine(payload: payload("multiple-choice"))
        let ev = try e.submit(selected: ["a"])
        #expect(!ev.isCorrect && ev.xp == 0 && ev.heartsLost == 1 && ev.title == "Not quite.")
        #expect(ev.explanation.hasPrefix("It is four downs"))
    }

    @Test func cannotSubmitTwice() throws {
        var e = try MultipleChoiceEngine(payload: payload("multiple-choice"))
        _ = try e.submit(selected: ["b"])
        #expect(throws: ExerciseError.alreadyFinished) { try e.submit(selected: ["b"]) }
    }

    @Test func singleChoiceRequiresExactlyOne() throws {
        var e = try MultipleChoiceEngine(payload: payload("multiple-choice"))
        #expect(throws: ExerciseError.self) { try e.submit(selected: ["a", "b"]) }
        #expect(throws: ExerciseError.self) { try e.submit(selected: []) }
        #expect(throws: ExerciseError.self) { try e.submit(selected: ["zzz"]) }
        #expect(e.evaluation == nil)
    }

    @Test func multiSelectNeedsExactSetNoPartialCredit() throws {
        var p: MultipleChoicePayload = try payload("multiple-choice")
        p.allowMultiple = true; p.correctOptionIds = ["a", "b"]
        var partial = try MultipleChoiceEngine(payload: p)
        #expect(try partial.submit(selected: ["a"]).isCorrect == false)
        var full = try MultipleChoiceEngine(payload: p)
        #expect(try full.submit(selected: ["b", "a"]).isCorrect)
        var extra = try MultipleChoiceEngine(payload: p)
        #expect(try extra.submit(selected: ["a", "b", "c"]).isCorrect == false)
    }

    @Test func shuffleRespectsFlagAndSeed() throws {
        var p: MultipleChoicePayload = try payload("multiple-choice")
        p.shuffle = false
        var g = SeededGenerator(seed: 1)
        #expect(try MultipleChoiceEngine(payload: p).displayOrder(using: &g).map(\.id) == ["a", "b", "c"])
        p.shuffle = true
        var g1 = SeededGenerator(seed: 42), g2 = SeededGenerator(seed: 42)
        let e = try MultipleChoiceEngine(payload: p)
        #expect(e.displayOrder(using: &g1).map(\.id) == e.displayOrder(using: &g2).map(\.id))
    }

    @Test func genericSubmitDispatch() throws {
        var e = try MultipleChoiceEngine(payload: payload("multiple-choice"))
        #expect(throws: ExerciseError.self) { try e.submit(.value(1)) }
        #expect(try e.submit(.choices(["b"])).evaluation?.isCorrect == true)
    }

    @Test func invalidPayloadRejected() throws {
        var p: MultipleChoicePayload = try payload("multiple-choice")
        p.correctOptionIds = ["nope"]
        #expect(throws: ExerciseError.self) { try MultipleChoiceEngine(payload: p) }
    }
}

@Suite("binary-call, visual-id, listening-id")
struct SimpleChoiceTests {
    @Test func binaryCall() throws {
        var right = try BinaryCallEngine(payload: payload("binary-call"))
        let ev = try right.submit(choiceId: "volley")
        #expect(ev.isCorrect && ev.xp == 10 && ev.notes == ["Rule: Kitchen rule"])
        var wrong = try BinaryCallEngine(payload: payload("binary-call"))
        let w = try wrong.submit(choiceId: "bounce")
        #expect(!w.isCorrect && w.heartsLost == 1)
        #expect(throws: ExerciseError.self) { try wrong.submit(choiceId: "volley") }
    }

    @Test func visualIDIncludesCues() throws {
        var e = try VisualIDEngine(payload: payload("visual-id"))
        let ev = try e.submit(optionId: "a")
        #expect(ev.isCorrect && ev.notes.contains("Sloping fastback roof"))
        var w = try VisualIDEngine(payload: payload("visual-id"))
        #expect(try w.submit(optionId: "c").heartsLost == 1)
        var bad = try VisualIDEngine(payload: payload("visual-id"))
        #expect(throws: ExerciseError.self) { try bad.submit(optionId: "zzz") }
    }

    @Test func listeningIDCorrectWrongAndNotes() throws {
        var e = try ListeningIDEngine(payload: payload("listening-id"))
        let ev = try e.submit(optionId: "a")
        #expect(ev.isCorrect && ev.notes.contains("Listen for: Nasal tone") && ev.notes.contains { $0.hasPrefix("Audio:") })
        var w = try ListeningIDEngine(payload: payload("listening-id"))
        #expect(try w.submit(optionId: "b").heartsLost == 1)
    }

    @Test func listeningIDPlayCounter() throws {
        var e = try ListeningIDEngine(payload: payload("listening-id"))
        #expect(e.maxPlays == 3)
        let plays = [e.recordPlay(), e.recordPlay(), e.recordPlay(), e.recordPlay()]
        #expect(plays == [true, true, true, false])
        #expect(e.playsRemaining == 0)
    }

    @Test func listeningIDSkipIsFree() throws {
        var e = try ListeningIDEngine(payload: payload("listening-id"))
        let ev = try e.skip()
        #expect(ev.skipped && ev.xp == 0 && ev.heartsLost == 0 && ev.masteryFraction == nil)
        #expect(ev.outcome(activityId: "x").conceptEvidence.isEmpty)
        var viaGeneric = try ListeningIDEngine(payload: payload("listening-id"))
        #expect(try viaGeneric.submit(.skip).evaluation?.skipped == true)
    }
}

@Suite("term-match")
struct TermMatchTests {
    private func engine() throws -> TermMatchEngine { try TermMatchEngine(payload: payload("term-match"), conceptIds: ["quarterback"]) }
    private let qb = "Runs the offense and throws the ball", cb = "Covers wide receivers", k = "Kicks field goals and extra points"

    @Test func perfectRun() throws {
        var e = try engine()
        #expect(try e.submit(termId: "qb", definition: qb) == .inProgress(StepFeedback(isCorrect: true, message: "Matched.", meter: 1)))
        _ = try e.submit(termId: "cb", definition: cb)
        let fin = try e.submit(termId: "k", definition: k)
        let ev = try #require(fin.evaluation)
        #expect(ev.isCorrect && ev.score == 100 && ev.xp == 10 && ev.heartsLost == 0)
    }

    @Test func oneWrongAttemptStillFullXPNoHeart() throws {
        var e = try engine()
        #expect(try e.submit(termId: "qb", definition: cb).evaluation == nil)
        _ = try e.submit(termId: "qb", definition: qb)
        _ = try e.submit(termId: "cb", definition: cb)
        let ev = try #require(try e.submit(termId: "k", definition: k).evaluation)
        #expect(ev.xp == 10 && ev.heartsLost == 0 && ev.isCorrect)
        #expect(ev.score == 67)   // 2 of 3 on the first attempt
    }

    @Test func twoWrongAttemptsHalfXPAndOneHeart() throws {
        var e = try engine()
        _ = try e.submit(termId: "qb", definition: cb)
        _ = try e.submit(termId: "qb", definition: k)
        #expect(e.wrongAttempts == 2 && e.wrongAttempts(forTerm: "qb") == 2)
        _ = try e.submit(termId: "qb", definition: qb)
        _ = try e.submit(termId: "cb", definition: cb)
        let ev = try #require(try e.submit(termId: "k", definition: k).evaluation)
        #expect(ev.xp == 5 && ev.heartsLost == 1 && !ev.isCorrect)
    }

    @Test func manyWrongAttemptsStillCostAtMostOneHeart() throws {
        var e = try engine()
        for _ in 0..<6 { _ = try e.submit(termId: "qb", definition: cb) }
        _ = try e.submit(termId: "qb", definition: qb)
        _ = try e.submit(termId: "cb", definition: cb)
        #expect(try e.submit(termId: "k", definition: k).evaluation?.heartsLost == 1)
    }

    @Test func invalidInput() throws {
        var e = try engine()
        #expect(throws: ExerciseError.self) { try e.submit(termId: "nope", definition: self.qb) }
        #expect(throws: ExerciseError.self) { try e.submit(termId: "qb", definition: "not a definition") }
        _ = try e.submit(termId: "qb", definition: qb)
        #expect(throws: ExerciseError.self) { try e.submit(termId: "qb", definition: self.qb) }
    }

    @Test func distractorsAreValidButWrong() throws {
        var p: TermMatchPayload = try payload("term-match")
        p.distractorDefinitions = ["Blows the whistle"]
        var e = try TermMatchEngine(payload: p)
        #expect(try e.submit(termId: "qb", definition: "Blows the whistle").evaluation == nil)
        #expect(e.wrongAttempts == 1)
        var g = SeededGenerator(seed: 7)
        #expect(Set(e.definitionOptions(using: &g)).count == 4)
    }
}

@Suite("sequence-order")
struct SequenceOrderTests {
    private let correct = ["wedge", "center", "throw", "trim", "bisque"]

    @Test func lcs() {
        #expect(SequenceOrderEngine.lcsLength(["a", "b", "c"], ["a", "b", "c"]) == 3)
        #expect(SequenceOrderEngine.lcsLength(["c", "b", "a"], ["a", "b", "c"]) == 1)
        #expect(SequenceOrderEngine.lcsLength([], ["a"]) == 0)
        #expect(SequenceOrderEngine.lcsLength(["b", "a", "c", "d"], ["a", "b", "c", "d"]) == 3)
    }

    @Test func perfect() throws {
        var e = try SequenceOrderEngine(payload: payload("sequence-order"))
        let ev = try e.submit(order: correct)
        #expect(ev.isCorrect && ev.score == 100 && ev.xp == 10 && ev.heartsLost == 0)
        #expect(ev.notes.first == "1. Wedge the clay (Removes air bubbles that can explode in the kiln.)")
    }

    @Test func mostlyRightGetsHalfXPNoHeart() throws {
        var e = try SequenceOrderEngine(payload: payload("sequence-order"))
        // swap first two: LCS = 4/5 = 80%
        let ev = try e.submit(order: ["center", "wedge", "throw", "trim", "bisque"])
        #expect(!ev.isCorrect && ev.score == 80 && ev.xp == 5 && ev.heartsLost == 0)
    }

    @Test func mostlyWrongLosesHeart() throws {
        var e = try SequenceOrderEngine(payload: payload("sequence-order"))
        let ev = try e.submit(order: correct.reversed())   // LCS 1/5 = 20%
        #expect(ev.score == 20 && ev.xp == 0 && ev.heartsLost == 1)
    }

    @Test func noPartialCreditMode() throws {
        var p: SequenceOrderPayload = try payload("sequence-order")
        p.partialCredit = false
        var e = try SequenceOrderEngine(payload: p)
        let ev = try e.submit(order: ["center", "wedge", "throw", "trim", "bisque"])
        #expect(ev.score == 0 && ev.xp == 0)
    }

    @Test func validatesPermutation() throws {
        var e = try SequenceOrderEngine(payload: payload("sequence-order"))
        #expect(throws: ExerciseError.self) { try e.submit(order: ["wedge"]) }
        #expect(throws: ExerciseError.self) { try e.submit(order: ["wedge", "wedge", "throw", "trim", "bisque"]) }
    }

    @Test func initialOrderIsNeverTheAnswer() throws {
        let e = try SequenceOrderEngine(payload: payload("sequence-order"))
        for seed in 0..<20 as Range<UInt64> {
            var g = SeededGenerator(seed: seed)
            #expect(e.initialOrder(using: &g).map(\.id) != correct)
        }
    }
}

@Suite("decision-scenario")
struct DecisionScenarioTests {
    @Test func best() throws {
        var e = try DecisionScenarioEngine(payload: payload("decision-scenario"))
        let ev = try e.submit(optionId: "turnaround")
        #expect(ev.isCorrect && ev.score == 100 && ev.xp == 10 && ev.heartsLost == 0 && ev.masteryFraction == 1)
        #expect(ev.notes.contains { $0.contains("learning scenario") })   // safety note always surfaced
    }
    @Test func acceptable() throws {
        var e = try DecisionScenarioEngine(payload: payload("decision-scenario"))
        let ev = try e.submit(optionId: "alternate")
        #expect(!ev.isCorrect && ev.score == 50 && ev.xp == 5 && ev.heartsLost == 0 && ev.masteryFraction == 0.5)
    }
    @Test func poor() throws {
        var e = try DecisionScenarioEngine(payload: payload("decision-scenario"))
        let ev = try e.submit(optionId: "continue")
        #expect(ev.score == 0 && ev.xp == 0 && ev.heartsLost == 1)
        #expect(ev.explanation.hasPrefix("You reach the summit"))
    }
}

@Suite("talk-track")
struct TalkTrackTests {
    private func twoExchange(_ deltas: [[Int]], start: Int? = nil) throws -> TalkTrackEngine {
        let exchanges = deltas.map { ds in
            TalkTrackPayload.Exchange(theirMessage: "m", replies: ds.enumerated().map { .init(id: "r\($0.offset)", text: "t", smoothDelta: $0.element, theirResponse: "resp\($0.offset)", coachNote: "coach\($0.offset)") })
        }
        return try TalkTrackEngine(payload: TalkTrackPayload(title: "t", setting: nil, startingSmooth: start, exchanges: exchanges, closingNote: "close"))
    }

    @Test func exampleGoodReplyFinishesAsSuccess() throws {
        var e = try TalkTrackEngine(payload: payload("talk-track"), conceptIds: ["x"])
        #expect(e.smooth == 50 && e.currentExchange?.theirMessage.hasPrefix("OT winner") == true)
        let ev = try #require(try e.submit(replyId: "a").evaluation)
        #expect(e.smooth == 80)
        #expect(ev.isCorrect && ev.xp == 50 && ev.heartsLost == 0 && ev.includesCompletionBonus)   // 40 + 10 bonus (>= 80)
        #expect(ev.explanation == "A power play is a two-minute man advantage after a penalty.")
    }

    @Test func exampleBadReplyFails() throws {
        var e = try TalkTrackEngine(payload: payload("talk-track"))
        let ev = try #require(try e.submit(replyId: "b").evaluation)
        #expect(e.smooth == 30 && !ev.isCorrect && ev.xp == 40 && ev.heartsLost == 0)
    }

    @Test func multiStepFeedbackAndMeter() throws {
        var e = try twoExchange([[10, -5], [20, 0]])
        let step = try e.submit(replyId: "r0")
        #expect(step == .inProgress(StepFeedback(isCorrect: true, message: "resp0", coachNote: "coach0", meter: 60)))
        #expect(e.exchangeIndex == 1)
        let fin = try #require(try e.submit(replyId: "r1").evaluation)
        #expect(e.smooth == 60 && fin.isCorrect && fin.xp == 40)   // exactly 60 = success, no bonus
    }

    @Test func smoothIsClamped() throws {
        var e = try twoExchange([[30, -20], [30, -20]], start: 90)
        _ = try e.submit(replyId: "r0")
        #expect(e.smooth == 100)
        var low = try twoExchange([[-20, 0], [-20, 0]], start: 10)
        _ = try low.submit(replyId: "r0")
        #expect(low.smooth == 0)
    }

    @Test func rejectsUnknownReplyAndSubmitAfterEnd() throws {
        var e = try twoExchange([[1, 2]])
        #expect(throws: ExerciseError.self) { try e.submit(replyId: "zzz") }
        _ = try e.submit(replyId: "r0")
        #expect(throws: ExerciseError.alreadyFinished) { try e.submit(replyId: "r0") }
    }

    @Test func neverCostsHearts() throws {
        var e = try twoExchange([[-20, -20]], start: 0)
        #expect(try e.submit(replyId: "r0").evaluation?.heartsLost == 0)
    }
}

@Suite("timing-tap")
struct TimingTapTests {
    @Test func scoringFormula() {
        let hit = TimingTapEngine.score(markerPct: 60, zoneStart: 58, zoneEnd: 74)
        #expect(hit.hit && hit.off == 0 && hit.score == 100)
        let edge = TimingTapEngine.score(markerPct: 58, zoneStart: 58, zoneEnd: 74)
        #expect(edge.hit)
        let miss = TimingTapEngine.score(markerPct: 50, zoneStart: 58, zoneEnd: 74)   // off = 8 -> 60 - 24 = 36
        #expect(!miss.hit && miss.off == 8 && miss.score == 36)
        let far = TimingTapEngine.score(markerPct: 2, zoneStart: 58, zoneEnd: 74)
        #expect(far.score == 0)
        let above = TimingTapEngine.score(markerPct: 80, zoneStart: 58, zoneEnd: 74)   // off 6 -> 42
        #expect(above.score == 42)
    }

    @Test func markerIsATriangleWave() {
        #expect(TimingTapEngine.markerPct(elapsedSeconds: 0, sweepSeconds: 2) == 0)
        #expect(TimingTapEngine.markerPct(elapsedSeconds: 1, sweepSeconds: 2) == 50)
        #expect(TimingTapEngine.markerPct(elapsedSeconds: 2, sweepSeconds: 2) == 100)
        #expect(TimingTapEngine.markerPct(elapsedSeconds: 3, sweepSeconds: 2) == 50)
        #expect(TimingTapEngine.markerPct(elapsedSeconds: 4, sweepSeconds: 2) == 0)
        #expect(TimingTapEngine.markerPct(elapsedSeconds: 5, sweepSeconds: 2) == 50)
        #expect(TimingTapEngine.markerPct(elapsedSeconds: -1, sweepSeconds: 2) == 50)
    }

    @Test func allHitsThreeRounds() throws {
        var e = try TimingTapEngine(payload: payload("timing-tap"), conceptIds: ["pit"])
        // Example rounds: zones 58-74 @1.6s, 64-76 @1.3s, 70-79 @1.1s. Marker = elapsed/sweep*100 on the up-sweep.
        #expect(try e.submit(elapsedSeconds: 1.6 * 0.66).evaluation == nil)
        #expect(e.currentRoundIndex == 1)
        #expect(try e.submit(elapsedSeconds: 1.3 * 0.70).evaluation == nil)
        let ev = try #require(try e.submit(elapsedSeconds: 1.1 * 0.75).evaluation)
        #expect(ev.score == 100 && ev.isCorrect && ev.xp == 3 * 10 + 40 && ev.heartsLost == 0 && ev.includesCompletionBonus)
        let allHit = e.results.allSatisfy { $0.hit }
        #expect(allHit)
    }

    @Test func missedRoundsAndHeart() throws {
        var e = try TimingTapEngine(payload: payload("timing-tap"))
        _ = try e.submit(markerPct: 10)    // off 48 -> 0 (< 40 => heart)
        _ = try e.submit(markerPct: 70)    // hit
        let ev = try #require(try e.submit(markerPct: 75).evaluation)   // hit
        #expect(e.results.map(\.score) == [0, 100, 100])
        #expect(ev.score == 67 && ev.xp == 2 * 10 + 40 && ev.heartsLost == 1)
    }

    @Test func nearMissDoesNotCostHeart() throws {
        var e = try TimingTapEngine(payload: payload("timing-tap"))
        _ = try e.submit(markerPct: 55)    // off 3 -> 51 (>= 40)
        _ = try e.submit(markerPct: 70)
        let ev = try #require(try e.submit(markerPct: 75).evaluation)
        #expect(ev.heartsLost == 0 && ev.xp == 2 * 10 + 40)
        #expect(e.results[0].score == 51)
        #expect(abs(e.results[0].clockSeconds - (11.2 + 3 * 0.12)) < 1e-9)
    }

    @Test func slowModeWidensZoneAndSlowsSweep() throws {
        let e = try TimingTapEngine(payload: payload("timing-tap"), mode: .tapToStopSlow)
        let r0 = e.rounds[0]   // 58-74: center 66, half 8 -> 12
        #expect(abs(r0.zoneStartPct - 54) < 1e-9 && abs(r0.zoneEndPct - 78) < 1e-9)
        #expect(abs(r0.sweepSeconds - 2.4) < 1e-9)
        var s = e
        #expect(try s.submit(markerPct: 55).evaluation == nil)
        #expect(s.results[0].hit)   // would be a miss in standard mode
    }

    @Test func slowModeClampsZoneToBar() throws {
        var p: TimingTapPayload = try payload("timing-tap")
        p.rounds = [.init(zoneStartPct: 90, zoneEndPct: 100, sweepSeconds: 1)]
        let e = try TimingTapEngine(payload: p, mode: .tapToStopSlow)
        #expect(e.rounds[0].zoneEndPct == 100 && e.rounds[0].zoneStartPct < 90)
    }

    @Test func finishedEngineRejectsMoreTaps() throws {
        var p: TimingTapPayload = try payload("timing-tap")
        p.rounds = [p.rounds[0]]
        var e = try TimingTapEngine(payload: p)
        _ = try e.submit(markerPct: 60)
        #expect(throws: ExerciseError.alreadyFinished) { try e.submit(markerPct: 60) }
    }

    @Test func genericAnswerAPI() throws {
        var p: TimingTapPayload = try payload("timing-tap")
        p.rounds = [p.rounds[0]]
        var e = try TimingTapEngine(payload: p)
        #expect(throws: ExerciseError.self) { try e.submit(.choices(["a"])) }
        #expect(try e.submit(.elapsed(seconds: 1.0)).evaluation != nil)   // marker 62.5 -> hit
    }
}

@Suite("say-this")
struct SayThisTests {
    @Test func fMeasure() {
        #expect(SayThisEngine.fMeasure(selected: ["a", "c"], correct: ["a", "c"]) == 1)
        #expect(SayThisEngine.fMeasure(selected: ["a"], correct: ["a", "c"]) > 0.66 && SayThisEngine.fMeasure(selected: ["a"], correct: ["a", "c"]) < 0.67)
        #expect(SayThisEngine.fMeasure(selected: ["b"], correct: ["a", "c"]) == 0)
        #expect(SayThisEngine.fMeasure(selected: [], correct: ["a"]) == 0)
    }

    @Test func fullSetIsCorrect() throws {
        var e = try SayThisEngine(payload: payload("say-this"))
        let ev = try e.submit(selected: ["a", "c"])
        #expect(ev.isCorrect && ev.score == 100 && ev.xp == 10 && ev.heartsLost == 0)
        #expect(ev.explanation.hasPrefix("The players defending"))
    }

    @Test func halfRightIsBelowThresholdButNoHeart() throws {
        var e = try SayThisEngine(payload: payload("say-this"))
        // selected {a}: precision 1, recall .5, F = .667: not correct (< .75), not below .5
        let ev = try e.submit(selected: ["a"])
        #expect(!ev.isCorrect && ev.xp == 0 && ev.heartsLost == 0 && ev.score == 67)
    }

    @Test func mostlyWrongLosesHeart() throws {
        var e = try SayThisEngine(payload: payload("say-this"))
        let ev = try e.submit(selected: ["b", "d"])
        #expect(ev.score == 0 && ev.heartsLost == 1)
        var mixed = try SayThisEngine(payload: payload("say-this"))
        // {a, b, d}: precision 1/3, recall .5 -> F = .4 < .5
        #expect(try mixed.submit(selected: ["a", "b", "d"]).heartsLost == 1)
    }

    @Test func extraWrongPickPullsBelowCorrect() throws {
        var e = try SayThisEngine(payload: payload("say-this"))
        // {a, c, b}: precision 2/3, recall 1 -> F = .8 >= .75 still correct
        #expect(try e.submit(selected: ["a", "c", "b"]).isCorrect)
        var e2 = try SayThisEngine(payload: payload("say-this"))
        // all four: precision .5, recall 1 -> F = .667 -> not correct
        #expect(try e2.submit(selected: ["a", "b", "c", "d"]).isCorrect == false)
    }
}

@Suite("fill-the-gap")
struct FillTheGapTests {
    @Test func segmentsAndSentence() throws {
        let e = try FillTheGapEngine(payload: payload("fill-the-gap"))
        #expect(e.segments == [.text("On "), .gap(id: "down"), .text(", the offense must gain "), .gap(id: "yards"), .text(" yards for a new set of downs.")])
        #expect(e.filledSentence() == "On fourth, the offense must gain 10 yards for a new set of downs.")
        #expect(e.filledSentence(with: ["down": "first"]).hasPrefix("On first,"))
    }

    @Test func allCorrect() throws {
        var e = try FillTheGapEngine(payload: payload("fill-the-gap"))
        let ev = try e.submit(answers: ["down": "fourth", "yards": "10"])
        #expect(ev.isCorrect && ev.xp == 10 && ev.score == 100)
    }

    @Test func oneWrongIsWrong() throws {
        var e = try FillTheGapEngine(payload: payload("fill-the-gap"))
        let ev = try e.submit(answers: ["down": "fourth", "yards": "5"])
        #expect(!ev.isCorrect && ev.heartsLost == 1 && ev.score == 0)
    }

    @Test func validatesAnswers() throws {
        var e = try FillTheGapEngine(payload: payload("fill-the-gap"))
        #expect(throws: ExerciseError.self) { try e.submit(answers: ["down": "fourth"]) }
        #expect(throws: ExerciseError.self) { try e.submit(answers: ["down": "third", "yards": "10"]) }
    }

    @Test func rejectsTemplateWithoutToken() throws {
        var p: FillTheGapPayload = try payload("fill-the-gap")
        p.template = "No tokens here"
        #expect(throws: ExerciseError.self) { try FillTheGapEngine(payload: p) }
    }
}

@Suite("estimate-slider")
struct EstimateSliderTests {
    private func run(_ v: Double) throws -> ExerciseEvaluation {
        var e = try EstimateSliderEngine(payload: payload("estimate-slider"))
        return try e.submit(value: v)
    }

    @Test func exact() throws {
        let ev = try run(60)
        #expect(ev.isCorrect && ev.score == 100 && ev.xp == 10 && ev.heartsLost == 0)
    }
    @Test func withinFullTolerance() throws { #expect(try run(65).score == 100); #expect(try run(55).score == 100) }
    @Test func withinPartial() throws {
        let ev = try run(75)
        #expect(ev.score == 50 && ev.xp == 5 && ev.heartsLost == 0 && !ev.isCorrect)
    }
    @Test func outside() throws {
        let ev = try run(100)
        #expect(ev.score == 0 && ev.xp == 0 && ev.heartsLost == 1)
    }
    @Test func snapsToStepAndClamps() throws {
        let e = try EstimateSliderEngine(payload: payload("estimate-slider"))
        #expect(e.snapped(62.4) == 60)
        #expect(e.snapped(63) == 65)
        #expect(e.snapped(-10) == 30)
        #expect(e.snapped(1000) == 120)
    }
    @Test func rejectsNonFinite() throws {
        var e = try EstimateSliderEngine(payload: payload("estimate-slider"))
        #expect(throws: ExerciseError.self) { try e.submit(value: .nan) }
    }
}

@Suite("hotspot-tap")
struct HotspotTests {
    @Test func circleHitTest() {
        let c = HotspotShape.circle(cx: 0.5, cy: 0.5, r: 0.1)
        #expect(HotspotTapEngine.contains(c, x: 0.5, y: 0.5))
        #expect(HotspotTapEngine.contains(c, x: 0.59, y: 0.5))
        #expect(!HotspotTapEngine.contains(c, x: 0.7, y: 0.5))
        // Radius is a fraction of width: on a 2:1 diagram a 0.15 vertical offset is only 0.075 in width units.
        #expect(HotspotTapEngine.contains(c, x: 0.5, y: 0.65, aspectRatio: 2))
        #expect(!HotspotTapEngine.contains(c, x: 0.5, y: 0.65, aspectRatio: 1))
    }
    @Test func rectHitTestAndSlop() {
        let r = HotspotShape.rect(x: 0.2, y: 0.2, w: 0.2, h: 0.1)
        #expect(HotspotTapEngine.contains(r, x: 0.3, y: 0.25))
        #expect(!HotspotTapEngine.contains(r, x: 0.45, y: 0.25))
        #expect(HotspotTapEngine.contains(r, x: 0.45, y: 0.25, slop: 0.06))
    }
    @Test func tapCorrectHotspot() throws {
        var e = try HotspotTapEngine(payload: payload("hotspot-tap"))
        let ev = try e.submit(x: 0.62, y: 0.3)
        #expect(ev.isCorrect && ev.xp == 10 && ev.notes == ["Correct: Strong safety"])
    }
    @Test func tapWrongHotspotOrEmptySpace() throws {
        var w = try HotspotTapEngine(payload: payload("hotspot-tap"))
        #expect(try w.submit(x: 0.4, y: 0.2).heartsLost == 1)
        var empty = try HotspotTapEngine(payload: payload("hotspot-tap"))
        #expect(try empty.submit(x: 0.95, y: 0.95).isCorrect == false)
    }
    @Test func accessibilityListSelectionById() throws {
        var e = try HotspotTapEngine(payload: payload("hotspot-tap"))
        #expect(try e.submit(.choices(["ss"])).evaluation?.isCorrect == true)
    }
    @Test func tapSlopMakesNearTapsHit() throws {
        var e = try HotspotTapEngine(payload: payload("hotspot-tap"), tapSlop: 0.05)
        #expect(try e.submit(x: 0.62 + 0.09, y: 0.3).isCorrect)   // 0.09 away, r 0.06 + 0.05 slop
    }
}

@Suite("Exercise factory and outcome mapping")
struct ExerciseFactoryTests {
    @Test func factoryBuildsFromActivity() throws {
        let c = try Fixtures.curriculum()
        for a in c.allActivities where a.type != .unitySim {
            let s = try ExerciseSessionFactory.make(for: a)
            #expect(s.activityType == a.type && s.conceptIds == a.conceptIds)
        }
    }

    @Test func factoryRejectsBadPayload() {
        let a = Activity(id: "x", type: .multipleChoice, conceptIds: ["c"], payload: json(#"{"prompt":"p"}"#))
        #expect(throws: (any Error).self) { try ExerciseSessionFactory.make(for: a) }
    }

    @Test func masteryDeltaRules() {
        #expect(ExerciseEvaluation.masteryDelta(fraction: 1, hintUsed: false) == 0.20)
        #expect(ExerciseEvaluation.masteryDelta(fraction: 0, hintUsed: false) == -0.15)
        #expect(ExerciseEvaluation.masteryDelta(fraction: 1, hintUsed: true) == 0.10)   // hint halves gains
        #expect(ExerciseEvaluation.masteryDelta(fraction: 0, hintUsed: true) == -0.15)  // but not losses
        #expect(abs(ExerciseEvaluation.masteryDelta(fraction: 0.5, hintUsed: false) - 0.025) < 1e-12)
    }

    @Test func outcomeCarriesEvidencePerConcept() throws {
        var e = try MultipleChoiceEngine(payload: payload("multiple-choice"), conceptIds: ["downs", "game-clock"])
        let ev = try e.submit(selected: ["b"])
        let o = ev.outcome(activityId: "a1")
        #expect(o.xp == 10 && o.correct && o.conceptEvidence.count == 2)
        #expect(o.conceptEvidence.allSatisfy { $0.delta == 0.20 && $0.correct == true })
    }

    @Test func seededGeneratorIsDeterministic() {
        var a = SeededGenerator(seed: 5), b = SeededGenerator(seed: 5)
        #expect((0..<5).map { _ in a.next() } == (0..<5).map { _ in b.next() })
    }
}
