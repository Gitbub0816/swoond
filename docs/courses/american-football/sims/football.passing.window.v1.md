# Throwing Window (`football.passing.window.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `football.passing.window.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition not used (scenario-data driven) |
| Authors / date | Claude Code (content agent) / 2026-09-30 |
| Changelog | 1.0.0: first spec |

## 2. Course & lesson links
- `courseId`: `american-football`. Unit `play-craft`, lesson `throw-window-06` (default difficulty 2). Reused in `always-on-review` (difficulty 3) and as an optional bonus card in `conversation-lab` lessons about quarterback play.
- CDS Interaction plan row U5. Manifest `unitySimulations[]` entry `football.passing.window.v1`.
- Prerequisites: `quarterback`, `route-tree`, `cover-2`, `cover-3`, `man-coverage`. Lessons `route-lab-05`, `coverage-04` come first.
- Native accessibility fallback lesson: `throw-window-06-fallback` (hotspot-tap: "tap where the ball should arrive" on still frames with a ghost route).

## 3. Learning objective(s) & concepts taught
- Objective: "You can see why a quarterback throws to where a receiver is going, not where he is."

| conceptId | term | After this the learner can... |
|---|---|---|
| `passing-window` | Passing window | Say that the gap between defenders is a moving target that closes in tenths of a second. |
| `anticipation-throw` | Anticipation throw | Recognize a throw released before the receiver breaks. |
| `back-shoulder-throw` | Back-shoulder throw | Explain placing the ball away from a trailing defender. |
| `yards-after-catch` | Yards after catch | Say why a ball in stride gains extra yards. |
| `interception` | Interception | Say why a badly placed throw becomes a turnover. |
| `go-route`, `out-route`, `curl-route`, `slant-route` | Routes | See how each route sets a different throw. |

Scope limit: no throwing mechanics, no reading progression (see `coverage-04`), no pressure, no scoring plays (throws end at the catch).

## 4. Why Unity (tier justification)
- **Physics (yes):** ball flight time (about 1.4 s deep, 0.5 s short) and receiver speed produce the lead. The concept is physical: the ball takes time to arrive.
- **Timing in a scene (yes):** the window opens and closes as the receiver breaks and the defender reacts. Anticipation, the core of a good quarterback, is timing you can see.
- **Camera perspective (yes):** a behind-the-QB view versus top-down freeze shows both the throwing lane and the arrival.
- **Native alternative:** `timing-tap` covers a one-dimensional bar (not the geometry of lead and defender); `estimate-slider` could ask "how far ahead"; `hotspot-tap` could ask where the ball goes on a static diagram. All are worse because they remove motion, which is the whole point. Justified.

## 5. Player fantasy & core loop
- Fantasy: "You are the quarterback, and the ball takes time to arrive."
- Loop (3 rounds, about 3 minutes):
  1. **Prompt**: route and situation ("Go route down the left sideline. Corner is on his hip.").
  2. **Playing**: the receiver runs; defender reacts; 1-2 s.
  3. **One decisive interaction**: at the freeze moment (time at 5 percent), the window shows; tap where the ball should land (level 1-3: one of 3-4 candidate spots; level 4-5: any spot).
  4. **Execute**: ball thrown (real flight); receiver and defender continue.
  5. **Freeze / explain**: the catch point frozen from top-down; ghost of the ideal path; the copy.
  6. **Say-this line**.

## 6. Scene & entities
- Environment `football_field`; camera `behind-qb-high` for play, `top-down` for freeze/explain, `broadcast-side` for replay.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `qb` | `Quarterback` | you | (0,-5) |
| `wr` | `Receiver` | the target | route path, speed 8.0 yd/s |
| `def_1`, `def_2` | `Defender` | trailing or underneath | reach radius 0.9 yd, speed 8.0 yd/s |
| `ball` | `Ball` | thrown; flight from `Ball.Throw` | speed 24 yd/s, arc auto |
| `window` | `Zone` | teaching lens: where the receiver can be caught | translucent gold lens |
| `spot_*` | `Target` | candidate landing spots (levels 1-3) | ring >= 44 pt |
| `free_tap` | `TouchController` | free tap landing (levels 4-5) | snap 0.5 yd, tolerance |
| `ghost_route` | `Path` | ghost of future route | gold dashed |
| `catch_eval` | `Pass` (Football module) | deterministic throw evaluation | see below |
| `Objective: complete_pass` | `Objective` | success = catch in stride | |

`Pass.Evaluate(spot)`: flight time f = dist(QB, spot) / 24 + 0.15 s arc; arrival t = tFreeze + f; receiver position p_r(t) from route path; defender position p_d(t) from track. Outcome: `intercepted` if |spot − p_d(t)| < 0.9 and |spot − p_r(t)| > 0.9 (or defender closer to spot by 0.5 yd); `complete-stride` if |spot − p_r(t)| <= 0.5 and defender distance > 0.9; `complete-reach` if |spot − p_r(t)| <= 1.0 and defender > 0.9; `underthrown` if the spot is behind p_r(t) by > 1.0 along the path; `overthrown` if beyond by > 1.0; `pass-breakup` if the defender is within 0.9 of the spot. Deterministic. New primitives: none.

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose spot (L1-3) | Tap a ring | `Target` | ring >= 44 pt | ring rose |
| Choose spot (L4-5) | Tap the field | field (snaps to 0.5 yd) | tolerance ring drawn under thumb, >= 44 pt | crosshair rose |
| Hint | "Show window" | window lens 2 s | 44 pt | hint used |
| Replay | "Watch again" | `Replay` | 44 pt | |
Tap-only. Portrait. Native draws hearts, exit, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate, build | Intro | `ready` |
| Intro | ready | Prompt card, formation, ghost route (L1-2) | Start | `progress` 0 |
| Playing | Start | Receiver and defender run to `tFreeze` (0.35-1.6 s) | reaches freeze time | none |
| Decision | `tFreeze` | SlowMotion 0.05; rings or free tap; timer (L3+) | tap or timeout | none |
| Executing | Spot chosen | `Pass.Evaluate`; ball flight in slow-mo 0.5x | catch or miss | none |
| Freeze | Resolved | Freeze at the catch point; top-down | 400 ms | none |
| Explain | Freeze | Ghost ideal path, lead arrow, copy | Continue | `checkpoint` |
| Summary | Last round | Score card | Done | none |
| Done | Done | `result`, `requestExit` | end | |
| Paused / Aborted | native | standard | end | |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Input | 3 rings | 4 rings | 4 rings | free tap (tol 1.5 yd) | free tap (tol 1.0 yd) |
| Window lens | always | on hint | on hint | on hint | off |
| Ghost route | always | always | on hint | off | off |
| Defender | none (no contest) | trailing | trailing + underneath | trailing + underneath | two defenders |
| Freeze timing | after break | before break | before break | before break | before break |
| Timer | none | none | 10 s | 8 s | 6 s |
| Hints per session | unlimited | 2 | 2 | 1 | 0 |
| Scenario tags | `deep`, `slant` | + `out`, `curl` | + `anticipation` | + `back-shoulder`, `underneath` | all |
Level 1 is passable by a true beginner: one obvious lead, no defender to beat. Default `throw-window-06` = 2.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "football.passing.window.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0 },
    "scenarioSetId": { "type": "string", "enum": ["window-starter", "window-anticipation", "window-contested"], "default": "window-starter" },
    "scenarioCount": { "type": "integer", "minimum": 1, "maximum": 5, "default": 3 },
    "inputMode": { "type": "string", "enum": ["rings", "free-tap"] },
    "ringCount": { "type": "integer", "minimum": 3, "maximum": 5 },
    "toleranceYd": { "type": "number", "minimum": 0.5, "maximum": 3 },
    "showWindow": { "type": "boolean" },
    "showGhostRoute": { "type": "boolean" },
    "decisionTimeLimitSec": { "type": ["number", "null"], "minimum": 3, "maximum": 30 },
    "hintBudget": { "type": "integer", "minimum": 0, "maximum": 10 },
    "ballSpeedYdPerSec": { "type": "number", "minimum": 18, "maximum": 30, "default": 24 }
  }
}
```
Valid: `{ "scenarioSetId": "window-starter", "scenarioCount": 3, "inputMode": "rings", "ringCount": 4, "showWindow": false }`. Invalid: `CONFIG_INVALID`.

## 11. Scenario data set
Format `Assets/Sims/Football/Window/scenarios/<set>.json`. **Minimum count: 12** (rounds x 3 = 9): `window-starter` (pw-01 to pw-04), `window-anticipation` (pw-05 to pw-08), `window-contested` (pw-09 to pw-12). Each scenario: `route` (timed waypoints), `defenders[]` tracks, `tFreeze`, `candidates[]` (ring positions with expected outcome), `idealSpot`, `conceptId`, `tags`. Deterministic per seed for order and mirroring; positions are fixed data. Coordinates in yards (x lateral, y downfield).

| scenarioId | Setup | Correct decision | conceptId | Tags |
|---|---|---|---|---|
| `pw-01-go-lead` | Go route left, corner trailing 1 yd behind. | Land 11 yd ahead of freeze position, outside shoulder. | `go-route` | deep |
| `pw-02-slant-early` | Slant vs off man; freeze before the cut. | Ball to the break point, inside, in front of receiver. | `slant-route` | slant, anticipation |
| `pw-03-out-anticipate` | Out route at 10 yd; freeze before the break. | Ball to the sideline shoulder, away from the corner. | `out-route` | out, anticipation |
| `pw-04-curl-timing` | Curl at 11 yd; ball must arrive as he turns. | Land on his chest at the turn (0.2 s after the break). | `curl-route` | curl |
| `pw-05-back-shoulder` | Deep sideline, corner in phase (hip to hip). | Ball low and to the back shoulder (outside, 1 yd short). | `back-shoulder-throw` | back-shoulder |
| `pw-06-over-underneath` | Crossing route with a linebacker underneath; arc needed. | Ball over the linebacker, ahead of the crosser. | `passing-window` | underneath |
| `pw-07-seam-window` | Seam route between two safeties; window opens for 0.4 s. | Ball at the window centre at t=1.9 s. | `passing-window` | anticipation |
| `pw-08-yac` | Slant with open field ahead; ball in stride gains yards after catch. | Lead 1.5 yd ahead, in stride. | `yards-after-catch` | slant |
| `pw-09-corner-over` | Corner route in Cover 2; safety over the top. | Ball to the sideline hole, high arc. | `passing-window` | contested |
| `pw-10-two-defenders` | Curl with hook defender and trailing corner. | Ball away from both, to the back of the hook. | `passing-window` | contested |
| `pw-11-late-throw` | Out route thrown late: corner jumps it. | Do not throw to the shoulder near the corner (interception); the choice is the outside spot. | `interception` | contested |
| `pw-12-comeback` | Comeback route 16 yd; freeze before turn. | Ball to the sideline as he turns. | `anticipation-throw` | anticipation |

Fully written, first three:
- **pw-01**: `wr` from (-15,0), speed 8.0 yd/s, vertical along x=-15 easing to x=-16.5 by y=24. Defender `def_1` (`cb_l`) from (-15,1), trails 1.0 yd behind and 0.6 yd inside. `tFreeze` = 1.6 s: `wr` at (-15.4,12.8). Candidates: `A behind` (-15.4,14.0) -> `underthrown` (both players run past; ball lands short); `B on him` (-15.6,16.0) -> `underthrown`; `C ideal` (-16.0,25.1) -> distance from QB 34.0 yd, flight 34.0/24 + 0.15 = 1.57 s, arrival t=3.17 s when `wr` is at (-16.0,25.1): `complete-stride`; `D far` (-16.5,32.0) -> `overthrown`. Correct: C. Explain key `lead-deep`.
- **pw-02**: `wr_slot` from (-7,0): stem to (-7,3) at t=0.45 s, then 45 degrees inside at 8.0 yd/s. `def_1` (`cb_l`) from (-7,6), 1.0 yd outside shade, 0.35 s reaction delay. `tFreeze` = 0.35 s (before the break). Candidates: `A on him` (-7,2.7) -> `underthrown` (he has cut), `B ideal` (-5.0,5.1) -> `complete-stride` (flight 0.61 s, arrival 0.96 s), `C far` (-2.0,8.5) -> `overthrown`, `D outside` (-8.0,4.0) -> `intercepted` by `cb_l`. Correct: B. Explain key `slant-early`.
- **pw-03**: `wr_z` from (15,0): stem to (15,10) at t=1.25 s, out to +x at 8.0 yd/s. `def_1` (`cb_r`) from (15,7), reaction 0.3 s, plays inside-shade at x=20.5 at arrival. `tFreeze` = 1.05 s. Candidates: `A on him` (15.0,10.0) -> `intercepted`, `B inside` (19.0,10.0) -> `intercepted`, `C ideal` (22.2,10.0) -> `complete-stride` (flight 1.1 s, arrival 2.15 s), `D far` (25.5,10.0) -> `overthrown`. Correct: C. Explain key `anticipate-out`.
Scenarios 04-12 follow the same schema. Data test: for every scenario exactly one candidate is `complete-stride`, ideal spot verified by `Pass.Evaluate`, and the wrong candidates have distinct outcomes (underthrown, overthrown, intercepted, pass-breakup) so the explain can name them. Free-tap levels use `Pass.Evaluate` on the tap point.

## 12. Freeze / explain moments
Trigger: after each throw. Freeze: at catch or miss. Camera: top-down (cut if reduced motion). Callouts: gold ghost of the receiver's path with a dot at the arrival point, rose line from QB to chosen spot, a bracket labelled "window", the defender's reach circle in `accentTint`. Copy card below ({outcomeWord} is `behind him`, `over his head`, or `picked off`).

| explainKey | Outcome | Title | Body | Say this |
|---|---|---|---|---|
| `lead-deep` | correct | Threw it where he's going. | A deep ball takes about a second and a half to land. The receiver keeps running, so you aim ahead of him, on the outside away from the corner. Perfect lead. | "He led him perfectly down the sideline." |
| `lead-deep` | incorrect | The ball landed {outcomeWord}. | The ball takes time to arrive and the receiver does not stop. Aim where he will be, not where he is. Try a spot further ahead. | "You have to lead the receiver." |
| `slant-early` | correct | Thrown before he cut. | A slant has a tiny window. The quarterback throws as the receiver plants, so the ball arrives when he turns. Timing beats arm strength. | "That's an anticipation throw on the slant." |
| `slant-early` | incorrect | Too late. He'd already cut. | The receiver cuts inside before the ball arrives. You need to release to the spot where he will be, before he gets there. | "On a slant, throw it before he breaks." |
| `anticipate-out` | correct | Ball to the sideline shoulder. | The out route breaks away from the defender. The throw goes to the outside shoulder before the break, so only the receiver can reach it. | "He threw it before the break, to the outside." |
| `anticipate-out` | incorrect | The corner got there. | The defender sits inside and the ball landed {outcomeWord}. Place it on the sideline shoulder, away from him, and release earlier. | "Put it where only your guy can get it." |
| `curl-timing` | correct | Ball meets him at the turn. | On a curl the receiver stops and faces you. The ball has to arrive as he turns, not before. That is timing, not just accuracy. | "It hit him right at the turn." |
| `curl-timing` | incorrect | Early or late? Both hurt. | Throw early and the receiver has not turned; throw late and the linebacker closes. Aim to arrive at the moment he faces you. | "A curl is about timing." |
| `back-shoulder` | correct | Away from the corner. | With the defender hip to hip, a ball over the top helps him. A low ball on the back shoulder makes the receiver stop and catch it, and the defender cannot. | "It was a back-shoulder throw." |
| `back-shoulder` | incorrect | Over the top helped him. | When the corner is in phase, a deep ball goes to him or to nobody. The back shoulder is the safest spot: only the receiver can turn back for it. | "Back shoulder beats tight coverage." |
| `over-underneath` | correct | Over the linebacker. | An underneath defender can break up a flat throw. A higher arc gets over his hands and lands in front of the crosser. | "He got it over the linebacker." |
| `over-underneath` | incorrect | The linebacker got a hand on it. | The underneath defender has long arms and a lane. A higher throw or a different spot makes the window bigger. | "Throw over the underneath guys." |
| `yac` | correct | In stride. Extra yards. | A ball in front of the receiver keeps him running, so he gains yards after the catch. A ball behind him makes him stop. | "That throw gave him yards after the catch." |
| `yac` | incorrect | He had to stop. | When the ball is behind the receiver he slows down to catch it. The defenders close in and he gets no extra yards. | "A good throw leads him." |
| `window-general` | correct | Nice. You found the window. | The window is the space where the ball can arrive when the defender cannot. It closes in tenths of a second, so timing is everything. | "The window closed fast, and he hit it." |
| `window-general` | incorrect | The window closed. | Windows are small and moving. Watch the defender's hips and the receiver's break, then aim where both will be. | "The window only lasts a split second." |

## 13. Scoring & mastery signals
- Round score: `complete-stride` = 100; `complete-reach` = 70; `underthrown` or `overthrown` = 25; `pass-breakup` = 10; `intercepted` = 0. Hint -10. Session score = round(mean). Accuracy = rounds with `complete-stride` or `complete-reach` / rounds.
- Outcome ids `round-1..3`; `value` = evaluation outcome string.

| mistake | conceptId | description |
|---|---|---|
| Threw to where the receiver was | `passing-window` | Aimed at his current spot, not his arrival spot. |
| Threw too late on a break | `anticipation-throw` | Waited for the break before releasing. |
| Ball in the defender's zone | `interception` | Placed the ball where the defender could reach it. |
| Over the top against a trailing corner | `back-shoulder-throw` | Overthrew a receiver with a defender in phase. |
| Behind receiver | `yards-after-catch` | Behind him, so no yards after catch. |
| Lead too short on deep route | `go-route` | Underthrew a deep ball. |

| event | conceptId | delta | evidence |
|---|---|---|---|
| Ideal spot, no hint | scenario concept | +0.25 | "Placed the ball in stride." |
| Ideal spot, hint used | scenario concept | +0.10 | same |
| `complete-stride` on an anticipation scenario | `anticipation-throw` | +0.20 | "Threw before the break." |
| `complete-stride` on back-shoulder | `back-shoulder-throw` | +0.20 | "Placed the ball away from the defender." |
| Interception | `interception` | -0.10 | "Threw into the defender's reach." |
| Any miss | `passing-window` | -0.10 | "Missed the window." |
| `complete-stride` | `yards-after-catch` | +0.10 | "Ball in stride." |
Caps: +0.40 / -0.20 per concept per session.

## 14. XP & hearts
`xpEarned` = 10 per completed pass (stride or reach) + 40 for finishing. `heartsLost` = 1 if 2 or more of 3 rounds ended in an interception or pass-breakup, or all three incomplete; else 0. Max 1. `replayAvailable` = true after any round.

## 15. Failure states
| Case | Learner sees | Result | Hearts |
|---|---|---|---|
| Miss / interception | Play continues in slow-mo (ball lands or defender picks it), explain with the ghost ideal | round failed | session rule |
| Timer ended (L3+) | Auto-throw to the nearest ring (or centre of window at L4-5), then explain | as scored | session rule |
| Session failed | "Timing is a feel thing. One more go?" and native Try again | `completed=true`, low score | if rule met |
| Abort / asset / config | standard | | 0 |

## 16. Accessibility
Reduced motion: no camera blend, slow-mo becomes hold frame, ball flight at 1x, no shake. Color-blind: rings numbered 1-4 and shaped (circle, square, diamond, triangle) in addition to color; window lens hatched; ideal spot marked with a star glyph in explain. Text scale honored. Tap-only. VoiceOver: native fallback `throw-window-06-fallback`.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Release | whoosh | soft tap | 0.5 |
| Complete | gold chime + catch pop | light success | 0.7 |
| Miss | thud | warning | 0.5 |
| Interception | crowd groan | warning | 0.5 |

## 18. Art & asset list
| asset | procedural / external | source & license | size | notes |
|---|---|---|---|---|
| Field, characters (<= 5), ball | procedural | own | < 0.5 MB | |
| Overlays | procedural | own | 0 | |
| Fonts/audio | OFL / original | `original-swoond` | < 2 MB | |
Bundle `sim-football-passing-window`, < 4 MB.

## 19. Performance budget
Defaults; tighter: <= 6 characters, <= 40 draw calls, memory <= 100 MB, `ready` <= 1.2 s.

## 20. Telemetry
`hintsUsed`, `decisionLatencyMsMean`, `leadErrorYdMean`, `interceptions`, `scenarioIds`, `inputMode`.

## 21. Acceptance criteria (testable)
1. AC-1: With seed 5, difficulty 2, 3 rounds: exactly 3 outcomes.
2. AC-2: `Pass.Evaluate` returns the authored outcome for every candidate of every scenario (EditMode).
3. AC-3: Exactly one `complete-stride` candidate per scenario.
4. AC-4: Determinism by seed and inputs (including physics: ball flight identical, fixed timestep).
5. AC-5: Free-tap at L4 applies 1.5 yd tolerance snapping (EditMode).
6. AC-6: Result validates; bridge conformance.
7. AC-7: Copy limits (`{outcomeWord}` counts as one word).
8. AC-8: Reduced motion: no blends.
9. AC-9: Touch targets >= 44 pt.
10. AC-10: Hearts rule.
11. AC-11: Perf on iPhone 13-class: p5 >= 50 fps, memory <= 100 MB.
12. AC-12: Invalid config gives `CONFIG_INVALID`.
13. AC-13: No personal fields in logs.
14. AC-14: Slow-mo scale during Decision is 0.05 (0 under reduced motion, freeze frame).

## 22. Test plan
| AC | Type | Test |
|---|---|---|
| AC-1, AC-4 | PlayMode | `Window_FullRun_Seed5_Deterministic` |
| AC-2, AC-3 | EditMode | `Scenarios_PassEvaluate_MatchesData` |
| AC-5 | EditMode | `FreeTap_SnapAndTolerance` |
| AC-6 | EditMode | `Bridge_Conformance` |
| AC-7 | EditMode | `Explanations_CopyLimits` |
| AC-8 | PlayMode | `ReducedMotion_NoBlend` |
| AC-9 | PlayMode | `TouchTargets_MinSize` |
| AC-10 | EditMode | `Hearts_Rule` |
| AC-11 | Perf | `Perf_iPhone13_Window` |
| AC-12 | EditMode | `Config_Invalid` |
| AC-13 | EditMode | `Privacy_NoPersonalFields` |
| AC-14 | PlayMode | `SlowMotion_Scale` |
Plus scripted-tap PlayMode runs for each input mode and pause/resume/abort.

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Auto arc height vs an explicit arc toggle for underneath defenders? | Astra/Product | No |
| 2 | Are 24 yd/s ball speed and 0.15 s arc delay right for teaching (real speed is higher)? Tune for feel. | Astra | No |
| 3 | Free tap precision on small phones; consider a magnifier. | Astra | No |
