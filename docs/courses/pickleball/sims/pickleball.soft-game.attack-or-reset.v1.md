# Attack or Reset (`pickleball.soft-game.attack-or-reset.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `pickleball.soft-game.attack-or-reset.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `pickleball`; `unitId` `soft-game`; `lessonId`s `soft-03` (primary), `soft-07` (difficulty 3-4 replay, "when to speed up").
- CDS row: section 12, "`soft-03`, `soft-07`: Attack or reset". Manifest: `unitySimulations[3]`.
- Prerequisite concepts: `dink`, `soft-game`, `net-height`, `kitchen-nvz`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can look at a ball in a dink rally and tell whether it is high enough to attack, low enough that you should reset, or long enough to let go."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `attackable-ball` | Attackable ball | Say a ball above net height at contact can be attacked; below net height cannot without risk. |
| `reset` | Reset | Choose a soft shot to neutralise a fast or low ball. |
| `speed-up` | Speed-up | Know when a speed-up is a good idea (ball is high, opponent is out of position). |
| `pop-up` | Pop-up | Recognise a high floating dink as a gift. |
| `counter-attack` | Counter-attack | Recognise a fast ball at your feet and choose to block/reset, not trade shots. |
| `dink` | Dink | See the dink as the default patient shot. |
| `block` | Block | Relate a reset to absorbing pace. |
- **Out of scope:** stroke mechanics, placement of the attack, spin, scoring.

## 4. Why Unity (tier justification)
- **Signals:** *reading a dynamic scene* (ball height relative to net at the bounce apex), *timing in a scene* (a short decision window), *camera perspective* (low side-on view where net height is a visible horizontal line).
- **Closest native:** `binary-call` (Attack / Reset with a still diagram) and `decision-scenario` (facts: "ball height: 1.1 m"). Both hand the answer to the learner as a number; the skill is *seeing* the ball above or below the net line in motion. A still diagram cannot build that perception.
- **Fallback:** native lesson `soft-03-native`: 4 `binary-call` items with side-view stills annotated with a net line, plus 2 `decision-scenario`.
- Justification strong.

## 5. Player fantasy & core loop
- **Fantasy:** "You are at the kitchen line in a dink war. This one bounces up. Do you pounce or stay patient?"
- **Loop:**
  1. Intro: rally in progress (the opponent's dink is on its way).
  2. Ball arrives and bounces; time slows to 0.3x (SlowMotion) for a **window** (L1 4 s real time, L5 1.5 s).
  3. Decision: **Attack**, **Reset**, or **Let it go** (DecisionPoint, 3 options).
  4. Execute: the chosen shot plays out deterministically; the opponent responds with a rule-based reaction.
  5. Freeze on the result frame; overlay shows net line, ball height at contact; explanation; say-this.
- **Session:** about 3 minutes, 3 rounds (configurable 3-6; default at `soft-07` is 5).

## 6. Scene & entities
- **Environment:** `pickleball_court`; camera `broadcast-side` low (default), `top-down` (explain optional), `first-person` (L1 optional? not used).
- **Coords:** meters; origin net center; learner on z<0 at the kitchen line (`you` at z=-2.4); opponents at z=+2.4.

| id | Primitive | Role | Key parameters |
|---|---|---|---|
| `court` | `Court` module | Court | as CDS |
| `you` | `Character` | Learner's player (rose ring) | at kitchen line; `AnimState` ready/dink/speedup/block |
| `partner` | `Character` | Passive partner | rose ring thin |
| `opp1`, `opp2` | `Character` | Opponents at their kitchen line | reaction time 0.30 s; reach 1.0 m |
| `ball` | `Ball` | Rally ball | dt 1/120; restitution 0.65; drag 0.10 s^-1 |
| `netLine` | `Path` (horizontal overlay) | Net-height line extended across the court at y=0.914 m | gold; visible per difficulty |
| `heightTag` | overlay | Live "0.62 m" numeral above ball at apex | Numeral serif; L1 only |
| `actions` | `Target` x3 | Attack / Reset / Let it go | `conceptId` per action |
| `decision` | `DecisionPoint` | The choice | `TimeLimit` = window (real seconds) |
| `slowmo` | `SlowMotion` | 0.3x during the window | reduced motion: hold instead of ramp |
| `explain`, `score`, `hints`, `replay` | kit | | |
- **New primitives:** none. Uses `Ball`, `DecisionPoint`, `SlowMotion`, `Path`, `Highlight`. Requests the shared `Court` module and env key.
- **Layout (side view):**
```
      ball
   ___o___ ---------------- gold net line (0.914 m) ----
  you |               |net|            opp at kitchen line
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose | Tap | Attack / Reset / Let it go pills (56 pt tall each, stacked bottom) | >= 56 x 200 pt | Selected pill `accent` outline; light tick |
| Hint | Tap | "Hint" chip (levels 1-3) | 44 x 80 pt | Net line pulses; ball height numeral appears |
| Next | Tap | Primary pill | 56 pt | |
- **Tap-only by design** (no drag needed). Portrait; court in top 60%, pills bottom.
- Native draws hearts/paywall/exit.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config; build court; load scenarios | Ready/error | `ready` |
| Intro | ready | Rally set-up; "Their dink is coming." | Playing | `progress` |
| Playing | intro | Opponent's ball flies and bounces on your side | At bounce, Decision | none |
| Decision | bounce | Slow-mo window; 3 options; timer bar | Choice or timeout (timeout = auto Reset, flagged) | none |
| Executing | choice | Shot executes; opponent reaction rules (below) | Result frame | none |
| Freeze | result | Freeze; net line and height overlay; scene dims | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card; optional "watch again" slow-mo | Next | `checkpoint round-N` |
| Summary | last | Score count-up | Done | `progress 1.0` |
| Done | summary | `result`, `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze time incl. the window timer / partial result | resume/end | `result`, `requestExit` |

**Reaction rules (deterministic):**
- Attack when `contactHeight >= 0.95 m` and an opponent is out of position (`openTarget=true`): point won (ball at feet, 0.4 m ahead of opp foot).
- Attack when `contactHeight >= 0.95 m` and `openTarget=false`: opponent blocks; rally continues (neutral).
- Attack when `contactHeight < 0.95 m`: ball goes into the net if `< 0.75 m`; if 0.75-0.95 it pops up and the opponent smashes (`pop-up` given to them).
- Reset when the incoming ball is fast at your feet (`pace >= 12 m/s`): neutral, opponent resets; reset succeeds.
- Reset when the ball was attackable (`>= 1.1 m`): neutral but "missed chance" flagged (acceptable, 0.6).
- Let it go when the ball lands beyond baseline/sideline (`landsOut=true`): opponent's mistake; point won.
- Let it go on an in-ball: point lost.
- Attack on a `landsOut=true` ball: wasted; no harm if let alone. (Outcome: poor.)

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Decision window (real s) | 4.0 | 3.5 | 3.0 | 2.5 | 1.5 |
| Net line overlay | on | on | on | flash at bounce | off |
| Ball height numeral | yes | no | no | no | no |
| Options offered | Attack, Reset | Attack, Reset | 3 | 3 | 3 |
| Scenario tags | `clear` | `clear` | + `pace` | + `borderline` | + `posture` |
| Borderline balls (0.75-0.95 m) | 0 | 0 | 0 | 1 of 5 | 2 of 5 |
| Opponent posture cue (out-of-position visible) | n/a | yes | yes | yes | subtle |
| Hints | 3 | 2 | 1 | 0 | 0 |
- Default for `soft-03`: 2; for `soft-07`: 3-4 (config). L1 passable by a beginner with hints (net line, numeral).

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "pickleball.soft-game.attack-or-reset.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["soft-game-starter", "soft-game-speedup", "soft-game-mixed"], "default": "soft-game-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "showRouteHints": { "type": "boolean", "default": true, "description": "Show net line/height numeral (gated by difficulty)." },
    "decisionWindowSeconds": { "type": ["number", "null"], "minimum": 1, "maximum": 6, "default": null },
    "includeLetItGo": { "type": ["boolean", "null"], "default": null }
  }
}
```
Valid: `{ "seed": 3, "scenarioSetId": "soft-game-starter", "scenarioCount": 3 }`. Invalid -> `CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/attack-or-reset-v1.json`, bundle `sim-pickleball-attack-reset`. Sets: `soft-game-starter` = tags `clear`; `soft-game-speedup` = `clear`,`pace`,`borderline`; `soft-game-mixed` = all. Deterministic per seed (order, x-mirror).
- **N = 15 scenarios.** Shape:
```json
{ "scenarioId": "ar-s01", "incoming": { "type": "dink", "bounceXZ": [0.6, -1.6], "contactHeight": 0.42, "paceMps": 4.0, "landsOut": false },
  "opponents": { "opp1": [-1.2, 2.4], "opp2": [1.4, 2.4], "openTarget": false },
  "best": "reset", "acceptable": [], "poor": ["attack", "let-go"], "teaches": "reset", "tags": ["clear"] }
```
- **Scenarios:**

| scenarioId | Setup (contact height, notes) | Best / acceptable / poor | Teaches | Tags |
|---|---|---|---|---|
| `ar-s01` | Normal dink, contact 0.42 m. | Reset (soft dink back) / none / Attack, Let go | `dink`, `reset` | clear |
| `ar-s02` | Pop-up, contact 1.25 m, opp1 out wide (openTarget). | Attack / Reset / Let go | `pop-up`, `attackable-ball` | clear |
| `ar-s03` | Dink lands 0.3 m wide of the sideline (landsOut). | Let go / none / Attack, Reset | `dink` (line calls) | clear |
| `ar-s04` | Fast ball at feet, pace 13 m/s, contact 0.35 m (opponent speed-up). | Reset (block) / none / Attack | `counter-attack`, `block` | pace |
| `ar-s05` | Pop-up, contact 1.10 m, openTarget=false (both opps at line, tight). | Attack / Reset / Let go | `speed-up` | clear |
| `ar-s06` | Dink contact 0.60 m. | Reset / none / Attack | `reset` | clear |
| `ar-s07` | Floaty dink 1.05 m, opp2 leaning back. | Attack / Reset | `attackable-ball` | clear |
| `ar-s08` | Fast ball, pace 14 m/s, but high at 1.20 m. | Attack (counter) / Reset | `counter-attack` | pace |
| `ar-s09` | Contact 0.88 m, borderline; opp1 stuck at midcourt (openTarget). | Attack / Reset (acceptable) | `speed-up` | borderline |
| `ar-s10` | Contact 0.85 m, borderline, opponents tight. | Reset / Attack (acceptable-but-risky) | `reset` | borderline |
| `ar-s11` | Dink 0.30 m at the kitchen line. | Reset / none | `dink` | clear |
| `ar-s12` | Ball lands out long past baseline (a lob-dink misjudged by them). | Let go / none / Attack | `dink` | clear |
| `ar-s13` | Speed-up at chest 1.30 m from opponent (you are not ready). | Attack (counter volley) / Reset | `counter-attack` | pace |
| `ar-s14` | Contact 0.70 m, opponent posture: hands low, weight back (posture cue). | Reset / Attack (poor) | `reset` | posture |
| `ar-s15` | Contact 1.15 m, opponents shifted to one side (posture cue). | Attack to the open side / Reset | `speed-up` | posture |
- Generation rule: contactHeight in [0.25, 1.35]; `best` = attack if height >= 0.95 and (`openTarget` or height >= 1.15); reset if height <= 0.75; let-go if `landsOut`; borderline 0.75-0.95: acceptable both.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-attack-good` | Attack on attackable ball | Gold net line; ball above it; contact numeral | Correct | Nice read. Above the net. | The ball was above net height when you reached it, so you could hit down at their feet. That is what "attackable" means. | "That ball was attackable, so I went for it." |
| `x-attack-net` | Attack on low ball into net | Ball below net line; net contact | Incorrect | Not quite. Too low. | The ball was below net height. Hitting hard from down there means going into the net or popping it up. Patience wins those. | "I had to reset that. It was below the net." |
| `x-attack-pop` | Attack on borderline ball, pop-up | Ball slightly below line; opponent smash | Incorrect | Not quite. Pop-up. | The ball was too close to net height. Your speed-up floated up and they smashed it. If it is borderline, stay patient. | "I popped it up. I should have waited." |
| `x-reset-good` | Reset on low or fast ball | Soft ball over net; opp reset | Correct | Nice read. Stay patient. | Low ball, or a fast one at your feet: absorb it and drop it softly into the kitchen. Nobody wins by trading shots from down there. | "That was a reset, not a winner." |
| `x-reset-missed` | Reset on very high ball | Ball far above net; gold net line | Acceptable | Fine, but a gift. | The ball floated way above the net. A soft reply is safe, but that was a chance to end the point. Spot the ones that sit up. | "It was a pop-up. I could have attacked." |
| `x-letgo-good` | Let go of out ball | Ball lands out; line highlight | Correct | Nice read. Out. | It was going out. Letting it go wins the point. Patience is a skill, and so is watching where it lands. | "I let it go. It was long." |
| `x-letgo-bad` | Let go of in ball | Ball lands in | Incorrect | Not quite. That was in. | The ball landed in, and lines count as in. When it is close, play it. | "Lines are in, so I should have hit it." |
| `x-attack-out` | Attack on out ball | Ball lands out | Incorrect | Not quite. Wasted swing. | The ball was long anyway. You would have won the point by letting it go. Watch where it will land before you commit. | "I should have let that go." |
| `x-block-good` | Counter with block on fast ball | Ball paddle; pace numeral | Correct | Nice read. Soft hands. | A fast ball at your feet is a counter-attack. Soft hands turn it into a slow ball. You do not have to hit back as hard. | "I blocked it back soft." |
| `x-timeout` | Window expired | Auto reset | Timeout | Time's up. Slowly now. | The window closed, so we reset for you. Next time look at where the ball is compared to the gold line. | "Height versus the net line decides it." |

## 13. Scoring & mastery signals
- **Round points:** best 1.0, acceptable 0.6, poor 0.0; hint -0.1 each (floor 0.4 for best).
- **accuracy** = rounds with points >= 0.6 / rounds. **Outcome success** = points >= 0.6.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Attacked ball below net height | `attackable-ball` | Attacked a ball that was below net height. |
| Reset on a very high ball | `pop-up` | Missed a pop-up that could be attacked. |
| Attacked a fast ball at feet | `counter-attack` | Traded speed with a ball that needed a soft block. |
| Attacked or hit an out ball | `dink` | Hit a ball that was going out. |
| Let an in ball go | `soft-game` | Let a live ball go instead of playing it. |
| Speed-up when not ready | `speed-up` | Sped up without an opening. |
- **Mastery signals:** correct attack -> `attackable-ball` +0.20, `speed-up` +0.15; correct reset on low -> `reset` +0.20; correct block vs pace -> `counter-attack` +0.20, `block` +0.10; correct let-go -> `soft-game` +0.10; recognised pop-up (attack on 1.10+) -> `pop-up` +0.20; mistakes -0.15 to mapped concept; caps +-0.30/concept; hints halve positives (native).
- **Result mapping:** outcomes (`round-N`, success, label, `value` = action chosen), mistakes, masterySignals.

## 14. XP & hearts
+10 per successful round, +40 finishing; native clamps. `heartsLost` 1 if accuracy < 0.34, max 1. `replayAvailable` true.

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain with net line | outcome false, mistake | none |
| Failed session | "Reading height is a new eye. Give it another go." | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto reset + explain | flagged | none |
| Abort/backgrounded | native | `aborted`, xp 0 | none |
| Asset/config error | native error | `error` | none |

## 16. Accessibility
- **Reduced motion:** the slow-mo ramp is replaced by an instant hold at the bounce; no camera sweeps; no shake.
- **Haptics:** honor `hapticsEnabled`.
- **Color-blind:** net line is a dashed gold line with a text label "NET HEIGHT"; ball above/below indicated with an arrow glyph (up/down); no red/green.
- **Text scale:** honored.
- **Tap-only:** yes.
- **VoiceOver:** Unity limited; native fallback `soft-03-native` provided.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Bounce | Pop-tick | none |
| Window opens | Soft rising tone | soft tap |
| Choose | Tick | light tap |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |

## 18. Art & asset list
| Asset | Procedural | License | Budget |
|---|---|---|---|
| Court/net/zones | Procedural | `original-swoond` | < 2k tris |
| Four characters | Procedural | `original-swoond` | < 3k tris each |
| Ball | Procedural | `original-swoond` | < 300 tris |
| Overlays (net line, numerals) | Procedural | n/a | n/a |
| Audio | Original | `original-swoond` | <= 1 MB |
Bundle `sim-pickleball-attack-reset`, <= 5 MB.

## 19. Performance budget
Defaults apply; tighter: memory < 110 MB; slow-mo must not drop fps; cold launch < 2 s.

## 20. Telemetry
Standard plus `hintsUsed`, `decisionLatencyMsMedian`, `windowTimeouts`, `actionsChosen` (counts), `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 3, difficulty 2, 3 rounds -> exactly 3 outcomes, deterministic.
2. **AC-2:** The action classifier returns the tabled best/acceptable/poor for all 15 scenarios and each action.
3. **AC-3:** The net line is rendered at y = 0.914 m (+- 0.005) in all camera presets (geometry test).
4. **AC-4:** Contact height at the decision moment equals scenario `contactHeight` (+- 0.03 m) in the simulated flight.
5. **AC-5:** The decision window lasts exactly the configured real seconds (+-0.1 s) regardless of time scale; pause excludes it.
6. **AC-6:** Reaction rules produce the tabled results (fixtures for each of the 8 branches).
7. **AC-7:** `ready` < 2 s; one schema-valid `result`; `requestExit` after.
8. **AC-8:** Abort -> `aborted=true`, xp 0.
9. **AC-9:** Copy lint passes.
10. **AC-10:** Reduced motion path: no slow-mo ramp, no sweeps; color-blind second channel present.
11. **AC-11:** Invalid config -> `CONFIG_INVALID`.
12. **AC-12:** Perf p5 >= 50 fps; memory < 110 MB (iPhone 13-class).
13. **AC-13:** Mastery caps +-0.30 per concept.

## 22. Test plan
- **EditMode:** classifier, reaction rules, height geometry, window timing (fake clock), seed determinism, scoring, config validation, copy lint, result schema.
- **PlayMode:** scripted run, freeze/explain, pause/abort, reduced motion, colour-blind snapshot.
- **Perf:** iPhone 13-class.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Soft` |
| AC-2, AC-6 | EditMode | `Classifier_Fixtures`, `ReactionRules_Fixtures` |
| AC-3, AC-4 | PlayMode | `NetLine_Geometry`, `ContactHeight_Match` |
| AC-5 | EditMode | `Window_Timing_FakeClock` |
| AC-7, AC-8 | PlayMode | `Launch_Result`, `Abort_Result` |
| AC-9 | EditMode | `Copy_Lint` |
| AC-10 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-11 | EditMode | `Config_Invalid` |
| AC-12 | Perf | `Perf_iPhone13` |
| AC-13 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Shared `Court` module and env key. | Astra | Yes |
| 2 | Is 0.95 m the right "attackable" threshold for the sim? Proposed: net 0.914 m + 0.04 margin; teach the idea (above the net at contact), not the number. | Product/Claude | No |
| 3 | Should `Let it go` appear at all at L1-2? Proposed: not before L3 (config `includeLetItGo`). | Product | No |
| 4 | Opponent "posture cue" art: what does a hands-low, weight-back stance look like in procedural characters? | Astra | No |

### Game Kit additions requested
- Shared `Court` module + `pickleball_court`.
- `SlowMotion.Window(realSeconds)` helper: slows time-scale but measures the decision timer in real time. (Small reusable utility; football coverage reads can use it.)
