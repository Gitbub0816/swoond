# Read It and Go (`baseball.baserunning.read-and-go.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `baseball.baserunning.read-and-go.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (logic is code plus a scenario data file; not a pure sim-definition) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `baseball`; `unitId` `on-the-bases` (lesson `base-06`) and `review-loop` (lesson `rev-03`, difficulty 4).
- CDS row: section 12, "`base-06`, `rev-03`: Read it and go". Manifest: `docs/courses/baseball/manifest.json` -> `unitySimulations[0]`.
- Prerequisite concepts (must be `mastered` or the lesson shows the native primer `base-05` first): `safe`, `force-play`, `tag-play`, `tag-up`, `sacrifice-fly`, `advance`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can tell when a runner should go and when he should hold, by comparing how fast he can run with how fast the throw can get there."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `send-or-hold` | Send or hold | Explain the decision as a race between runner and throw. |
| `tag-up` | Tag up | Say the runner must wait for the catch, then run; and see why a shallow fly is a hold. |
| `sacrifice-fly` | Sacrifice fly | Recognise a deep fly that scores a runner from third. |
| `two-outs-running` | Two outs, run on contact | Know that with two outs the runner goes on anything, and the coach is more aggressive. |
| `third-base-coach` | Third-base coach | Know that this coach's windmill or stop sign is the decision, and why. |
| `read-and-go` | Read the ball | Use depth, arm and speed together in a single glance. |
| `advance` | Advance | See advancing as an opt-in risk, not automatic. |

- **Out of scope:** stealing, leading off, pickoffs, the mechanics of sliding, appeals, and the rules for interference or obstruction (native lessons).

## 4. Why Unity (tier justification)
- **Signals:** *movement over time* (a runner and a throw crossing a diamond) and *timing in a scene* (the throw is decisive within about half a second) and *reading a dynamic scene* (fielder depth, arm, speed).
- **Closest native:** `decision-scenario` with a facts table (outs, ball depth, arm grade) and `binary-call` on a diagram. They teach the heuristic ("with less than two outs, tag on a deep fly") but a learner cannot *feel* that the throw arrived 0.2 s ahead of the slide, which is why this concept is called "reading" and not "memorising".
- **Fallback:** native lesson `base-06-native`: 4 `decision-scenario` items with a timeline facts table (runner time versus throw time) plus 2 `hotspot-tap` items (where does the ball get fielded).
- Justification: strong for the movement-race concept; the static rules remain native.

## 5. Player fantasy & core loop
- **Fantasy:** "You are the third-base coach. The ball drops, the runner is rounding, and the whole ballpark is waiting for you to windmill or stop."
- **Loop:**
  1. Intro: scenario card (runner, outs, ball, arm) and a 1.5 s establishing shot.
  2. Ball is hit (deterministic); camera follows the ball then the runner.
  3. **Decision** (one decisive interaction): at the decision moment tap **GO** or **HOLD** (fly ball scenarios: **TAG** or **STAY**), inside a timed window (GK-4).
  4. Execute: runner runs or holds; fielders throw; a ghost runner shows the option not taken (dashed).
  5. Freeze at the play: timeline bars (runner time versus ball time) and callouts; explain; "say this" line.
- **Session length:** about 3 minutes, 3 rounds by default.

## 6. Scene & entities
- **Environment:** `baseball_field` (procedural; see Game Kit additions), camera presets `broadcast-high-behind`, `oblique-low` (GK-19), `top-down` for explain, `chase-high` for the run.
- **Coordinate convention (feet, shared with native diagrams):** origin home plate; x across (third-base side negative, first-base side positive); y toward center field; bases 90 ft apart: 1B (63.64, 63.64), 2B (0, 127.28), 3B (-63.64, 63.64); pitcher's mound (0, 60.5).

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `field` | `BaseballField` module | Environment: infield, outfield grass, warning track, foul lines, bases | dimensions as above; fence 330 ft (lines) to 400 ft (center) generic |
| `runner` | `Character` (rose ring) | Runner the learner is coaching | speed grade (`slow` 25, `avg` 27, `fast` 29 ft/s effective running; tag-up start 25/28/30 ft/s); reaction 0.15 s on contact, 0.15 s after the catch on a tag-up |
| `coach` | `Character` | Third-base coach (animation only) | windmill / stop-sign animations |
| `fielder` | `Character` (muted) | The fielder who plays the ball | arm grade `weak` 110, `avg` 125, `strong` 140 ft/s; transfer 0.65 s; relay when the throw is over 280 ft |
| `relay` | `Character` (muted) | Cutoff man (when needed) | at 50 percent of the throw line; +0.5 s |
| `catcherOrBase` | `Character` | Receiver at the target base | tag time 0.25 s |
| `ball` | `Ball` | Batted ball then throw | deterministic PhysicsObject at fixed 1/120 s |
| `go`, `hold` | `Target` x2 | Decision buttons (GO / HOLD or TAG / STAY) | 64 pt |
| `race` | `RaceEvaluator` (GK-9) | Computes runner vs ball arrival at the target | margin in seconds |
| `decision`, `window` | `DecisionPoint` + `SlowMotion.Window(realSeconds)` (GK-4) | Timed decision | window from difficulty |
| `timeline` | `TraceChart`-style bars (GK-16 / GK-17) | Two bars: runner time, ball time, plus the margin tick | numerals in Numeral serif |
| `ghost` | `Character` (dashed outline) | Alternate outcome | shows what the other choice would have done |
| `explain`, `score`, `hints`, `replay`, `slowmo`, `highlight` | as kit | | |

- **New primitives:** `BaseballField` (sport module), `BaseRunner` (Character preset with sprint model: reaction, acceleration curve, turn cost 0.1 s per base rounded), and the standard `RaceEvaluator`/`SlowMotion.Window` already requested (GK-9, GK-4). Reuse plan: `BaseballField` for the other two baseball sims; `BaseRunner` for any future softball sim.
- **Layout (top-down):**
```
 y=+330                    [CF]                    <- deep fly scenarios
          [LF]                        [RF]
                     [2B]
  3B(-63.6,63.6)   .--------.   1B(63.6,63.6)
                 (0,60.5) mound
                    home (0,0)
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Decide | Tap | **GO** or **HOLD** pill (bottom, side by side) | >= 64 x 110 pt each | Selected gets `accent` outline; haptic soft tap |
| Hint | Tap "Hint" chip | Shows the timeline preview (difficulty 1-3) | 44 pt | Highlight fielder arm and runner speed |
| Watch again | Tap | Explain card | 44 pt | Slow-mo replay from `oblique-low` |
- **Tap-only:** every control is a tap; there are no drags. Portrait; controls in the bottom 30 percent, field in the top 70 percent.
- **Not in Unity:** hearts, paywall, exit confirmation, XP display.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate configuration, build field and characters, load scenarios | Ready or error | `ready` |
| Intro | ready | Situation card, 1.5 s | Playing | `progress` |
| Playing | intro | Ball is hit; ball flight and runner run (or holds at base on a fly ball) until the decision moment | Decision | none |
| Decision | decision moment | Time slows (`SlowMotion.Window`); GO / HOLD available for `windowSeconds`; timeout auto-picks HOLD | Executing | none |
| Executing | choice made | Play resolves under the oracle model; ghost shows the other outcome; ball arrives at the base | Freeze at the play | none |
| Freeze | play resolved | Time freezes; camera `top-down`; timeline bars appear | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card with title, body, say-this; "Watch again" | Next round or Summary | `checkpoint round-N` |
| Summary | last round | Score count-up, mistakes recap | Done | `progress 1.0` |
| Done | summary | `result` then `requestExit(completed)` | end | `result`, `requestExit` |
| Paused / Aborted | native `pause` / `abort` | Freeze timers and physics; abort emits a partial result with `xpEarned 0` | resume or end | `result`, `requestExit` |

**Decision moment:** ground-ball scenarios: the instant the fielder gains control of the ball. Fly-ball scenarios: the instant the fielder catches the ball (TAG or STAY). The decision window uses real seconds (see section 9).

**Oracle model (deterministic; reference for tests):**
- `runnerTime` = `reaction + runDistance / v + 0.1 * turns`; on a fly ball `runDistance` = 90 ft, `reaction` = 0.15 s from the catch, `v` = tag-up speed of the grade; on a ground ball `reaction` = 0.15 s from contact and `runDistance` = 180 ft minus the lead (15 ft at second, 12 ft at first).
- `ballTime` (from the same clock start) = `fieldTime` (ground ball only; seconds after contact when the ball is fielded) + `throwTime` + 0.25 s tag time; on a fly ball the clock starts at the catch, so `fieldTime` = 0.
- `throwTime` = `0.65 + d / armSpeed * 1.1` for `d <= 280 ft`, else `0.65 + (d/2)/armSpeed*1.1 + 0.5 + (d/2)/armSpeed*1.1`.
- `margin` = `ballTime - runnerTime` (positive means the runner is safe by that many seconds).
- `sendThreshold` (seconds): 0 outs `+0.5`, 1 out `+0.3`, 2 outs `-0.1` (with two outs any out ends the inning, so risking the runner costs little; with no outs, an out at the plate throws away a scoring chance).
- Classification: `GO best` if `margin >= threshold + 0.15`; `HOLD best` if `margin <= threshold - 0.15`; otherwise `close` (both acceptable, the better guess is the one nearer the threshold).
- The oracle is the source of truth for scoring and for the timeline bars; the visual simulation animates the oracle's times (educational clarity over realism).

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Timeline preview (bars shown before deciding) | full | full | ghost tick only | none | none |
| Fielder and runner labels ("Arm: strong", "Runner: fast") | yes | yes | yes | no | no |
| Decision window (real seconds; time slowed to 0.25) | none (no limit) | none | 8 | 5 | 3 |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Close scenarios (`close` class) in the pool | no | no | 1 | 2 | 3 |
| Fly-ball scenarios share | 40% | 40% | 50% | 50% | 50% |
| Scenario tags | `easy` | `easy` | + `outs-matter` | + `close` | all |
- Default for `base-06`: 2. `rev-03`: 4. Level 1 is passable by a beginner: obvious outcomes, labels and full timeline preview.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "baseball.baserunning.read-and-go.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["rg-starter", "rg-outs-matter", "rg-close-calls"], "default": "rg-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "showTimelinePreview": { "type": ["boolean", "null"], "default": null, "description": "Overrides the difficulty default when not null." },
    "decisionWindowSeconds": { "type": ["integer", "null"], "minimum": 2, "maximum": 20, "default": null },
    "controlScheme": { "type": "string", "enum": ["pills"], "default": "pills" }
  }
}
```
Valid example: `{ "seed": 42, "scenarioSetId": "rg-starter", "scenarioCount": 3 }`. Invalid configuration yields `error CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/read-and-go-v1.json` (bundle `sim-baseball-read-and-go`). Deterministic per seed (order, mirror x for left/right, tiny visual variations that do not change times).
- **N = 12 scenarios** (3 rounds x 4 for replay variety). Shape:
```json
{ "scenarioId": "rg-s01", "kind": "fly", "runnerOn": "third", "outs": 0, "runnerSpeed": "avg",
  "fielder": { "role": "RF", "xy": [70, 265], "arm": "weak", "fieldTime": 0 },
  "target": "home", "lead": 0, "turns": 0,
  "oracle": { "runnerTime": 3.36, "ballTime": 3.64, "margin": 0.28, "threshold": 0.5, "class": "hold" },
  "best": "hold", "acceptable": [], "poor": ["go"], "teaches": ["tag-up", "send-or-hold"], "tags": ["easy"] }
```
- **Scenarios** (times in seconds from the model in section 8; margin = ballTime - runnerTime):

| scenarioId | Setup | runnerTime / ballTime / margin / threshold | best (acceptable) | Teaches | Tags |
|---|---|---|---|---|---|
| `rg-s01` | Runner on 3rd, 0 outs; fly to right-center (70, 265); RF weak arm; avg runner | 3.36 / 3.64 / +0.28 / +0.50 | Stay (Tag is poor) | `tag-up`, `send-or-hold` | outs-matter |
| `rg-s02` | Runner on 3rd, 1 out; shallow fly to left (-95, 175); LF avg arm | 3.36 / 2.65 / -0.71 / +0.30 | Stay | `tag-up`, `send-or-hold` | easy |
| `rg-s03` | Runner on 3rd, 1 out; deep fly to center (10, 330); CF strong arm (relay) | 3.36 / 3.99 / +0.63 / +0.30 | Tag | `sacrifice-fly`, `tag-up` | easy |
| `rg-s04` | Runner on 3rd, 0 outs; deep fly to left-center (-30, 300); LF weak arm; fast runner | 3.15 / 4.41 / +1.26 / +0.50 | Tag | `sacrifice-fly` | easy |
| `rg-s05` | Runner on 2nd, 1 out; single to left (-110, 205) fielded at 3.0 s; LF weak arm | 6.36 / 6.23 / -0.13 / +0.30 | Hold | `send-or-hold`, `third-base-coach` | outs-matter |
| `rg-s06` | Runner on 2nd, 2 outs; single to center (0, 235) fielded at 3.2 s; CF avg arm | 6.36 / 6.17 / -0.19 / -0.10 | Close: Go (acceptable), Hold (acceptable) | `two-outs-running`, `send-or-hold` | close |
| `rg-s07` | Runner on 2nd, 2 outs; single to left (-100, 215) fielded at 3.0 s; LF strong arm; slow runner | 6.85 / 5.76 / -1.09 / -0.10 | Hold | `send-or-hold`, `read-and-go` | easy |
| `rg-s08` | Runner on 1st, 0 outs; single to right (95, 215) fielded at 3.4 s; RF weak arm; go to third | 6.47 / 6.49 / +0.02 / +0.50 | Hold at second | `advance`, `send-or-hold` | outs-matter |
| `rg-s09` | Runner on 1st, 1 out; single to left (-95, 215) fielded at 3.4 s; LF weak arm; fast runner; go to third | 6.04 / 5.85 / -0.20 / +0.30 | Hold | `advance`, `read-and-go` | close |
| `rg-s10` | Runner on 2nd, 0 outs; double in the gap (130, 290) fielded at 3.6 s; CF avg arm (relay) | 6.36 / 7.80 / +1.44 / +0.50 | Go | `send-or-hold`, `third-base-coach` | easy |
| `rg-s11` | Runner on 2nd, 2 outs; single to left-center (-120, 240) fielded at 3.2 s; avg arm | 6.36 / 6.46 / +0.10 / -0.10 | Go | `two-outs-running` | outs-matter |
| `rg-s12` | Runner on 2nd, 1 out; slow runner; ball to the right-center gap (125, 270) fielded at 3.6 s; avg arm | 6.85 / 7.62 / +0.77 / +0.30 | Go | `read-and-go`, `send-or-hold` | easy |

- The first three (`rg-s01` to `rg-s03`) are fully written above in the JSON shape (s01) and table rows; the rest are generated from the same fields. **Generation rule for additional scenarios:** pick outs, runner grade, fielder position (radius 175 to 330 ft from home), arm grade and `fieldTime` (3.0 to 3.6 s for ground balls); compute the oracle; keep only scenarios whose class is `go` or `hold` with |margin - threshold| >= 0.15 for L1-L2, and any class for L4-L5.
- **Numbers are non-normative until the golden generator runs:** Astra ships a checked-in generator that recomputes the oracle and writes the fixture (convention from GAME_KIT, section 2 Racing). The baseball constants (speed grades, arm speeds) are reasonable teaching values, not tracking data [verify with an SME; Statcast sprint speed averages about 27 ft/s].

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|---|
| `x-go-good` | GO with margin >= threshold + 0.15 | Runner at plate; timeline shows runner bar shorter | Correct | Nice read. Safe by a step. | The runner needed {runnerTime} seconds; the throw needed {ballTime}. That gap is what a coach reads in one glance: arm, depth, speed. Send him. | "Great send. The throw had no chance." |
| `x-go-out` | GO with margin <= threshold - 0.15 | Tag at the plate; ghost shows holding | Incorrect | Not quite. Thrown out. | The throw beat him by {abs(margin)} seconds. A strong arm and a shallow ball mean stop sign. Holding would have kept the runner alive. | "He got thrown out at the plate; I should have held." |
| `x-hold-good` | HOLD with margin <= threshold - 0.15 | Ghost runner out at the plate | Correct | Nice read. Good stop sign. | The throw was faster than the runner. Holding kept the inning alive. A runner at third with less than two outs is worth a lot. | "Smart hold. Too risky against that arm." |
| `x-hold-missed` | HOLD with margin >= threshold + 0.15 | Ghost runner scores easily | Incorrect | Not quite. Free run left. | He would have scored easily: the throw was late by {margin} seconds. Weak arms and deep balls mean go. Holding costs runs. | "He could have scored. That was a free run." |
| `x-close-either` | Class `close` (either choice) | Both bars nearly equal | Acceptable | Coin flip. Both fine. | This one was too close to call: the runner and throw were within {abs(margin - threshold)} seconds of the cutoff. Coaches take more risk with two outs and less with none. | "It was a tough call, close either way." |
| `x-tag-good` | TAG when best | Runner tags at the catch | Correct | Nice read. Tagging paid off. | He waited for the catch, then ran. The ball was deep enough for the throw to lose the race. That is a sacrifice fly. | "Deep fly, he tagged, easy sac fly." |
| `x-tag-early` | TAG on a shallow fly | Throw beats runner | Incorrect | Not quite. Too shallow. | A shallow catch gives the fielder a short throw. The runner must wait for the catch and then run 90 feet; the throw wins. Stay. | "You can't tag on a shallow fly." |
| `x-timeout` | Decision timer expired | Auto-HOLD; shows the timeline | Timeout | Time's up. Let's look. | The clock ran out, so the coach held the runner. Read the arm, the depth and the outs, then decide. | "Read the arm first, then the depth." |

## 13. Scoring & mastery signals
- **Round points (0..1):** `0.8 * decisionScore + 0.2 * timely`; `decisionScore` = 1.0 best, 0.6 acceptable, 0.0 poor; `timely` = 1 if the decision was made inside the window (always 1 when there is no window).
- **accuracy** = rounds with `decisionScore >= 0.6` divided by rounds. **Outcome id** `round-N`, `success` = points >= 0.7, `value` = the choice.
- **Mistake -> conceptId:**

| Mistake | conceptId | Description |
|---|---|---|
| GO on a shallow fly | `tag-up` | Tried to score on a shallow fly with a strong throw waiting. |
| GO into a strong arm | `send-or-hold` | Sent the runner into a throw that beat him. |
| HOLD with a weak arm and deep ball | `send-or-hold` | Held a runner who would have scored easily. |
| HOLD with two outs on a close play | `two-outs-running` | Did not send with two outs on a play that could score. |
| STAY on a deep fly | `sacrifice-fly` | Did not tag on a deep fly with less than two outs. |
| Ignored the runner's speed | `read-and-go` | Chose the same as for an average runner despite a slow or fast one. |
- **Mastery signals:** correct decision -> `send-or-hold` +0.20; correct fly-ball choice -> `tag-up` +0.20; correct deep-fly TAG -> `sacrifice-fly` +0.20; correct decision at two outs -> `two-outs-running` +0.20; correct decision when `arm` and `runnerSpeed` disagree -> `read-and-go` +0.15; first-time correct `third-base-coach` context +0.10; mistakes -0.15 to mapped concept; caps +-0.30 per concept per session; hints halve positives (native).
- **Result mapping:** `outcomes[]` (per round), `mistakes[]`, `masterySignals[]`, `score` 0-100 = mean(points) x 100.

## 14. XP & hearts
`xpEarned` proposal: +10 per successful round (points >= 0.7), +40 finishing; native clamps to the lesson budget. `heartsLost`: 1 if accuracy < 0.34, max 1. `replayAvailable` true.

## 15. Failure states
| Situation | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round | Explain with timeline and the ghost of the other choice | outcome `success` false, mistake | none |
| Failed session (accuracy < 0.34) | "That is a real skill. Watch the timeline once more." Try again | `heartsLost` 1 | -1 |
| Timeout | Auto-HOLD then explain (a wrong hold is scored as poor only if HOLD was poor) | outcome recorded with `timeout` label | none |
| Abort / backgrounded | Native handles; Unity emits `result` with `aborted` | `xpEarned 0` | none |
| Asset missing / config invalid | Native error sheet | `error` event (`ASSET_MISSING` or `CONFIG_INVALID`) | none |

## 16. Accessibility
- **Reduced motion:** no camera sweeps (hard cuts between `oblique-low` and `top-down`); slow-motion replaced by four stills of the play (catch, throw, runner, tag); no shake.
- **Haptics:** honor `hapticsEnabled`. **Color-blind:** runner bar is solid, ball bar dashed; GO is a filled pill with a check mark, HOLD an outlined pill with a stop-hand icon; ghost is dashed with a numeral label.
- **Text scale:** honored; cards reflow. **Tap-only:** yes.
- **VoiceOver/TalkBack:** Unity content is limited; the accessible alternative is the native lesson `base-06-native` (decision-scenario set with the timeline expressed as facts: "Runner: 6.4 s. Throw: 6.2 s."). The sim announces the situation card text and the result.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Bat crack | Original bat-on-ball crack (synth) | none |
| Glove pop / catch | Soft thud | soft tap |
| Decision made | Soft tick | soft tap |
| Safe | Warm chime | light success |
| Out | Low thud | warning |
| Freeze | Low whoosh | soft tap |
| Crowd bed | Very low crowd loop (mutable) | none |
All honor `soundEnabled` and `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural or external | Source & license | Budget | Notes |
|---|---|---|---|---|
| Field, mound, bases, lines, fence | Procedural | `original-swoond` | < 3k tris | Neutral colours; no team branding |
| Nine fielders, runner, coach | Procedural capsule figures | `original-swoond` | < 2.5k tris each | Jersey numbers; role rings |
| Ball, bat (cosmetic) | Procedural | `original-swoond` | < 500 tris | |
| Overlays (timeline bars, ghost, callouts) | Unity UI | `original-swoond` | n/a | Per ART_DIRECTION section 4 |
| Audio | Synthesised / in-house | `original-swoond` | <= 1.5 MB | |
Addressables bundle `sim-baseball-read-and-go`, <= 6 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md`; tighter: 12 characters + ball < 25k tris on screen; memory < 130 MB; cold launch < 2 s from `launch` to `ready`.

## 20. Telemetry
Standard diagnostics (fps, load, memory) plus `hintsUsed`, `decisionLatencyMsMedian`, `goCount`, `holdCount`, `timeoutCount`, `difficulty`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 42, difficulty 2, 3 rounds: exactly 3 `outcomes`, identical across runs.
2. **AC-2:** For all 12 scenarios the oracle classification equals the table (`best`, `acceptable`, `poor`) within +-0.01 s tolerance on times.
3. **AC-3:** The oracle formulas reproduce the fixture `runnerTime`, `ballTime`, `margin` for all 12 scenarios within 0.01 s.
4. **AC-4:** Changing only `outs` from 0 to 2 changes the classification for `rg-s01` (hold at 0 outs, go at 2 outs) or the threshold used, as tabled.
5. **AC-5:** `ready` within 2 s of `launch`; exactly one schema-valid `result`; `requestExit` follows.
6. **AC-6:** Pause freezes physics and the decision timer; abort yields `aborted=true`, `xpEarned=0`.
7. **AC-7:** Explain copy: title <= 6 words, body <= 45 words after placeholder substitution; every outcome has copy.
8. **AC-8:** Reduced-motion path contains no camera sweeps; a tap-only full run completes.
9. **AC-9:** Invalid configuration yields `CONFIG_INVALID`.
10. **AC-10:** Perf: p5 frame >= 50 fps, memory < 130 MB on iPhone 13-class.
11. **AC-11:** Mastery signals capped at +-0.30 per concept per session.
12. **AC-12:** Ghost runner outcome equals the oracle result of the unchosen action for every scenario.

## 22. Test plan
- **EditMode:** oracle math (`runnerTime`, `throwTime`, relay branch), classification, config validation, scoring, seed determinism, result schema validity, copy lint, mastery caps.
- **PlayMode:** scene builds from code, full scripted run (tap-only), freeze/explain sequence, pause/resume/abort, reduced-motion path, ghost runner.
- **Perf:** measured run on iPhone 13-class.

| AC | Test type | Test name |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_ReadAndGo` |
| AC-2, AC-3 | EditMode | `Oracle_Fixture_Matches` |
| AC-4 | EditMode | `Outs_Change_Threshold` |
| AC-5, AC-6 | PlayMode | `Launch_Result`, `Pause_Abort` |
| AC-7 | EditMode | `Copy_Lint` |
| AC-8 | PlayMode | `ReducedMotion_TapOnly` |
| AC-9 | EditMode | `Config_Invalid` |
| AC-10 | Perf | `Perf_iPhone13` |
| AC-11 | EditMode | `Mastery_Caps` |
| AC-12 | PlayMode | `Ghost_Matches_Oracle` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Add `BaseballField` module, `baseball_field` environment, `BaseRunner` preset and generator-based oracle fixtures. | Astra | Yes |
| 2 | Baseball SME check on constants (runner speeds, arm speeds, transfer time, send thresholds by outs). | Product / SME | Yes for `spec-approved` |
| 3 | Should first-to-third scenarios (`rg-s08`, `rg-s09`) target third base with the coach's send only for runners from second? Current model includes both; confirm they teach the same idea. | Claude | No |
| 4 | The 0-outs threshold (+0.5 s) is deliberately conservative; confirm with an SME that the message "do not make the first out at the plate with no outs" is the right teaching line. | SME | No |

### Game Kit additions requested
- `BaseballField` module, environment key `baseball_field` (shared by all three baseball sims); `BaseRunner` Character preset with sprint model.
- GK-4 (`SlowMotion.Window`) and GK-9 (`RaceEvaluator`) reused; GK-16/GK-17 style bars for the timeline; GK-19 camera presets `broadcast-high-behind`, `oblique-low`.
- Demonstrate type `runner_vs_throw_timeline` (proposed): two bars and a margin tick; sim-local until a second sim needs it.
