# Drive Layout in a Corner (`cars.handling.drive-layout.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `cars.handling.drive-layout.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven; scenarios are data) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `cars`; `unitId`: `handling-and-chassis` (primary, lesson `hc-04`) and `review-loop` (boss review `rv-03`, difficulty 4).
- CDS row: section 12, "Drive layout in a corner". Manifest: `docs/courses/cars/manifest.json` -> `unitySimulations[0]`.
- Prerequisite concepts (must be `mastered`, else a native primer shows first): `fwd`, `rwd`, `awd`, `tires-grip` (from `dt-05`, `hc-01`).
- Native fallback lesson: `hc-04-native` (three `binary-call` items on a static path diagram plus a `sequence-order` "what happens as she lifts").

## 3. Learning objective(s) & concepts taught
- **Learner objective:** "You can look at a car, a corner and what the driver does, and say whether it will run wide, hold its line or step its tail out, and why."
- Concepts:

| conceptId | Term | After this the learner can... |
|---|---|---|
| `understeer` | Understeer / "it pushes" | Say the front tires ran out of grip first, so the car goes wide. |
| `oversteer` | Oversteer / "the tail steps out" | Say the rear tires ran out of grip first, so the car rotates. |
| `drive-layout-handling` | Drive layout and behavior | Predict the tendency of FWD, RWD, mid-engine and AWD cars under power. |
| `weight-transfer` | Weight transfer | Say braking loads the front and unloads the rear, and lifting does a milder version. |
| `traction-limit` | The grip budget | Say each tire has one grip budget shared between turning and pushing/braking. |
| `fwd`, `rwd`, `awd` | Drive layouts | Say which axle is driven and what it costs in a corner. |
- **Out of scope:** how to drive fast, correcting a slide, lap times, tire compounds, setup tuning, electronic aids (traction/stability control are mentioned once as "not shown").

## 4. Why Unity (tier justification)
- **Rubric signals met:** movement over time in space (the path *is* the answer); physics is the concept (a shared grip budget per axle, weight transfer, driven axle); camera perspective (top-down with ghost paths shows "wide" vs "rotated" in one frame).
- **Closest native type:** `binary-call` on a static path diagram, or `multiple-choice` with arrow images. It teaches the labels but not the cause: the same corner and the same throttle give FWD, RWD and AWD different paths, and lift or brake moves weight. Learners who only see labels misuse them ("it oversteers" for a wide line). A native exercise also cannot show the *live grip meters* per axle crossing 100%.
- **Fallback:** native lesson `hc-04-native` (accessibility and failure fallback, not a port).
- Justification is strong; Unity retained. If a playtest shows the native version teaches as well (CDS open question 7), downgrade to native and cancel this sim.

## 5. Player fantasy & core loop
- **Fantasy:** You are the friend in the passenger seat who can tell what the car is about to do before it does.
- **Core loop (per round):**
  1. Prompt card: "She gets on the gas mid-corner. Where does it go?" (Intro; text varies by event).
  2. Top-down view of a corner with the car at the entry, a small spec chip (layout, surface) and three faint **ghost paths**: *holds its line*, *runs wide*, *tail steps out*.
  3. Decision: tap the ghost path you think the car will follow (`DecisionPoint`, 3 targets). At levels 4-5 a reason chip step follows.
  4. Execute: the car drives the corner; two **grip meters** (front, rear) fill live; the one that crosses 100% flashes.
  5. Freeze/explain: freeze at the moment a meter crosses 100% (or at the apex if neither does), slow-mo replay with slip arrows, explanation card, and a line you could say out loud.
- **Session length:** about 3 minutes, 3 rounds by default (configurable 3-5).

## 6. Scene & entities
- **Environment key:** `corner_topdown` (new procedural key: a 60 m by 40 m tarmac patch with a constant-radius corner, track edges and cones; surface tint by `surface`: dry, wet, snow pattern). Requested below; can be built on the `terrain_heightfield`-free flat `Track` preset.
- **Camera presets:** `top-down` (default, FOV 50, height auto-fit to corner), `chase-high` (used at Explain for 1.0 s), `side-on` unused.
- **Units:** meters; corner center at origin; car enters heading +x at (-R, -12) for a right-hand corner; mirrored randomly by seed (`mirror`), which never changes the outcome.

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `car` | `Vehicle` (racing tuning, arcade) driven by `LayoutHandlingModel` (sim-local) | The learner-watched car | `layout`, mass-normalized; body length 4.4 m; rose ring |
| `ghostPaths` x3 | `Path` + `Highlight` (Muted) | Choice targets | `holds`, `push`, `oversteer`; dashed under reduced motion is solid |
| `paths.options` | `Target` x3 | Tap targets, each carries `conceptId` | `understeer`, `oversteer`, `traction-limit` |
| `gripMeters` | `Highlight` variant (two arcs at the axles) + HUD bars | Live friction-circle usage `uf`, `ur` | 100% mark line; over-100 = shape change (double-line) and pulse |
| `slipArrows` | `SlipArrows` (Racing module, GAME_KIT 5.2) | Shows direction each axle is sliding | Reused; requested by `nascar.tight` |
| `weightBars` | `Highlight` + `Zone` | Static/dynamic load bars front and rear | Explain only |
| `corner` | `Zone` + `Path` | Constant-radius line and edges | `radiusM` from scenario |
| `decision` | `DecisionPoint` | Path choice | 3 options, optional time limit |
| `explain` | `Explanation` | Freeze card | Title, body, say-this |
| `replay` | `Replay` + `SlowMotion` | 0.25x replay | Camera `chase-high` |
| `hints` | `Hint` | Level 1-3 help | Recorded per use |
| `score` | `Score` | Results | Section 13 |

- **Reused vs new:** all Game Kit primitives reused; `SlipArrows` from Racing. **New:** `LayoutHandlingModel` (sim-local pure function, section 11), environment key `corner_topdown`, and (optional) `GripMeter` highlight variant. Reuse plan: the `LayoutHandlingModel` and `GripMeter` also serve a possible future snow-driving or trail-braking sim and NASCAR `tight`/`loose` handling scenes.
- **Initial layout:**
```
      apex
   .-------.
  /  ghost  \    R = radiusM
 |  paths x3 |
  \         /
   '-car->-'   grip meters: F [====|  ]   R [==   |]
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose path | Tap | One of three ghost paths (or the labeled chip under it) | >= 56 x 120 pt chips | Selected ghost gets `accent` outline; light haptic tick |
| Reason chip (L4-5) | Tap | Three chips: "Front ran out of grip", "Rear ran out of grip", "Nothing runs out" | >= 44 x 120 pt | `accent` outline |
| Hint | Tap | "Hint" chip | 44 x 88 pt | Shows the grip meters live at 40% speed |
| Next | Tap | Primary pill at Explain/Summary | 56 pt | Pill |
- **Tap-only alternative:** all interactions are taps; no drag or gesture is required.
- **Safe area / orientation:** portrait; the corner occupies the top 65% of the screen, chips the bottom.
- **Not drawn by Unity:** hearts sheet, paywall, exit confirmation, XP animation (native). Unity draws only the in-sim X that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate config; build the corner and car from code; load the scenario set | Ready or `error` (`CONFIG_INVALID`, `ASSET_LOAD_FAILED`) | `ready` |
| Intro | After ready | Prompt card 1.5 s; spec chip (layout, surface) | Playing | `progress 0.0` |
| Playing | Round starts | Car idles at the entry; ghost paths draw in | Decision | none |
| Decision | Ghost paths shown | `DecisionPoint` (timer if configured); reason step at L4-5 | Choice made or timeout (wrong, `timeout` flag) | none |
| Executing | Choice made | Car drives the corner with the model; meters fill | Freeze event or corner exit | none |
| Freeze | Meter crosses 100% (or apex) | `SlowMotion.Freeze`; dim 35%; the saturated axle highlighted | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | 0.25x replay from `chase-high`, then card | Learner taps Next | `checkpoint round-N` |
| Summary | Last round explained | Score numerals count up 600 ms; mistakes recap | Done | `progress 1.0` |
| Done | Summary shown | Build `SimulationResult`; send `result`; `requestExit(completed)` | End | `result`, `requestExit` |
| Paused | Native `pause` | Freeze time, audio, timers | `resume` -> previous state | none |
| Aborted | Native `abort` or in-sim X | Stop; result `aborted=true`, `xpEarned=0` | End | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Scenario tags allowed | `basic` | `basic`,`power` | `basic`,`power`,`lift`,`snow` | `power`,`lift`,`brake`,`layout` | all incl. `advanced` |
| Ghost paths shown | all 3 | all 3 | all 3 | all 3, unlabeled | 3, unlabeled, order shuffled |
| Grip meters visible during approach | yes (static) | yes | no | no | no |
| Decision time limit (s) | none | none | 15 | 10 | 6 |
| Hints available | 2 | 1 | 1 | 0 | 0 |
| Reason step required | no | no | no | yes | yes |
| Layout chip shown | yes | yes | yes | yes | no (learner reads the silhouette) |
| Distractor near-miss (holds vs push margin) | wide margins (>= 0.25) | >= 0.15 | >= 0.10 | >= 0.06 | >= 0.05 |
- **Default for `hc-04`:** difficulty 2. **`rv-03` default:** 4. Level 1 is passable by a true beginner with hints (meters visible before the choice, layout chip, wide margins).

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "cars.handling.drive-layout.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "description": "Deterministic RNG seed (scenario order and mirror)." },
    "scenarioSetId": { "type": "string", "enum": ["drive-layout-core"], "default": "drive-layout-core" },
    "difficulty": { "type": "integer", "minimum": 1, "maximum": 5, "default": 2 },
    "rounds": { "type": "integer", "minimum": 3, "maximum": 5, "default": 3 },
    "tags": { "type": "array", "items": { "type": "string", "enum": ["basic", "power", "lift", "brake", "snow", "layout", "advanced"] }, "uniqueItems": true, "description": "Optional override of the tag pool; defaults come from difficulty." },
    "showModelNumbers": { "type": "boolean", "default": false, "description": "Shows numeric grip percentages in the meters (accessibility aid)." }
  }
}
```
Valid example: `{ "seed": 42, "scenarioSetId": "drive-layout-core", "difficulty": 2, "rounds": 3 }`. An unknown key, enum value or out-of-range number yields `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Assets/Sims/cars/drive-layout-core.json`, 13 scenarios (>= rounds 3 x 3 = 9; N = 13). Deterministic per seed (order and `mirror`).
- **Model (stylized, pure function `LayoutHandlingModel.Evaluate`, not a vehicle simulator).** For the *steady part of the corner* plus one *event*:
  - `ay = v^2 / (R * g)` (g = 9.81 m/s^2), expressed in g.
  - Layout constants: static front weight fraction `wf` FWD 0.60, RWD 0.52, AWD 0.56, MR 0.42; driven share (front, rear): FWD (1,0), RWD (0,1), AWD (0.4,0.6), MR (0,1). Surface `mu`: dry 1.0, wet 0.6, snow 0.3.
  - Event longitudinal acceleration `ax` (g): `steady` 0; `power` +0.5 x `powerFraction` (force on the driven axles by share); `lift` -0.25 (engine braking on the driven axles only); `brake` -0.5 (front 70%, rear 30%).
  - Load per axle (fractions of weight): `Nf = wf - 0.18*ax`, `Nr = (1-wf) + 0.18*ax`.
  - Lateral force per axle (weight fractions): `Fy_f = ay * wf`, `Fy_r = ay * (1-wf)` (neutral baseline).
  - Grip use per axle: `u = sqrt(Fy^2 + Fx^2) / (mu * N)`; the axle is saturated when `u > 1`.
  - Outcome: both `u <= 1` -> `holds`; else the larger `u` decides: front -> `push`, rear -> `oversteer`.
  - Paths: `holds` follows radius R; `push` runs wide by `0.6 * (uf - 1) * R` at the exit (clamped to 12 m); `oversteer` rotates with yaw error `25 deg * (ur - 1)` (clamped 40 deg) and a tighter line; visual only, the outcome is decided by `u`.
  - **Golden values** below are computed with these formulas; per convention (GAME_KIT racing) they are non-normative until Astra's golden generator reproduces them, and every scenario keeps each relevant `u` at least 0.05 from 1.0 unless noted.
- Scenario table (`uf`/`ur` = golden grip use; all correct choices are unique):

| scenarioId | setup | correct decision | golden values | tags |
|---|---|---|---|---|
| `sc-01` | FWD, wet, R=50 m, v=11 m/s, event `power` p=0.9 | `push` | uf=1.521, ur=0.342, ay=0.247 g | basic,power |
| `sc-02` | RWD, wet, R=50 m, v=11 m/s, event `power` p=0.9 | `oversteer` | uf=0.487, ur=1.382, ay=0.247 g | basic,power |
| `sc-03` | AWD, wet, R=50 m, v=11 m/s, event `power` p=0.9 | `holds` | uf=0.789, ur=0.931, ay=0.247 g | basic,power |
| `sc-04` | RWD, dry, R=50 m, v=20.5 m/s, event `lift` | `oversteer` | uf=0.789, ur=1.106, ay=0.857 g | lift |
| `sc-05` | FWD, dry, R=50 m, v=19.8 m/s, event `lift` | `holds` | uf=0.838, ur=0.901, ay=0.799 g | lift |
| `sc-06` | FWD, dry, R=50 m, v=19.8 m/s, event `brake` | `oversteer` | uf=0.86, ur=1.139, ay=0.799 g | brake |
| `sc-07` | FWD, dry, R=50 m, v=18.5 m/s, event `power` p=0.9 | `push` | uf=1.184, ur=0.58, ay=0.698 g | basic,power |
| `sc-08` | MR, wet, R=50 m, v=14 m/s, event `power` p=0.9 | `oversteer` | uf=0.825, ur=1.276, ay=0.4 g | power,layout |
| `sc-09` | FWD, snow, R=40 m, v=6 m/s, event `power` p=0.5 | `push` | uf=1.537, ur=0.275, ay=0.092 g | snow |
| `sc-10` | RWD, snow, R=40 m, v=6 m/s, event `power` p=0.5 | `oversteer` | uf=0.335, ur=1.612, ay=0.092 g | snow |
| `sc-11` | AWD, dry, R=50 m, v=18.5 m/s, event `power` p=0.9 | `holds` | uf=0.898, ur=0.785, ay=0.698 g | basic,power |
| `sc-12` | AWD, dry, R=50 m, v=19.8 m/s, event `brake` | `oversteer` | uf=0.874, ur=1.092, ay=0.799 g | brake |
| `sc-13` | AWD, snow, R=40 m, v=6 m/s, event `power` p=0.5 | `oversteer` | uf=0.728, ur=1.068, ay=0.092 g | snow,advanced |
- First three fully written:
  - **sc-01 (`traction-fwd-push`)** Layout FWD, wet, corner radius 50 m, entry 11 m/s (about 40 km/h). Event: driver gets on the gas hard mid-corner (`power`, p = 0.9). Correct: *runs wide* (`push`). Teaches `understeer`, `fwd`, `traction-limit`. Tags basic, power.
  - **sc-02 (`rwd-power-oversteer`)** Same corner, same speed, same throttle, layout RWD. Correct: *tail steps out* (`oversteer`). Teaches `oversteer`, `rwd`, `drive-layout-handling`. The paired sc-01/sc-02/sc-03 are the "same corner, three drivetrains" set and may be played in sequence in `hc-04` level 1-2.
  - **sc-03 (`awd-holds`)** Same corner, AWD. Correct: *holds its line*. Teaches `awd`: power is shared over four tires so no one axle spends its whole budget. The explain copy adds "AWD helps you get going, not you get around", pointing to sc-13.
- Generation rules for future scenarios: choose layout, surface, R in [30, 80] m, v so `ay` in [0.05, 1.0] g, event and p; run `Evaluate`; accept only if margins hold, the outcome is unique, and all three ghost paths are distinguishable (at least 2 m apart at the exit).

## 12. Freeze / explain moments
Voice: cheeky coach, short sentences. Titles <= 6 words, bodies <= 45 words.

| Trigger | Correct copy | Incorrect copy |
|---|---|---|
| `push` outcome (front saturates) | **Title:** "It ran wide." **Body:** "The front tires do the steering and the pulling. Ask for both at once and they run out of grip first, so the car goes wide. That's understeer, or 'it pushes'." **Say this:** "It's a front-driver, so it pushes when you get on the gas." | **Title:** "Not quite. It pushed." **Body:** "You picked another path. Watch the front meter hit 100% first. Front tires steer and drive, and they ran out. That's understeer." **Say this:** "Front meter pegged first, so it goes wide." |
| `oversteer` outcome, power (rear saturates) | **Title:** "The tail stepped out." **Body:** "In a rear-driver the rear tires push the car and hold it steady. Power plus cornering spends their whole grip budget. The tail lets go. That's oversteer." **Say this:** "Rear-wheel drive on the gas, so the back steps out." | **Title:** "Not quite. Tail out." **Body:** "The rear meter hit 100% first. Rear tires were pushing and holding the corner. That's oversteer, not understeer." |
| `oversteer` outcome, lift or brake | **Title:** "Weight moved forward." **Body:** "Lift or brake and weight shifts to the front, off the rear. Less load means less grip, so the rear runs out first. That is why lifting mid-corner can rotate a car." **Say this:** "Lifting moved weight off the rear." | **Title:** "Not quite. Weight shifted." **Body:** "Braking loads the front and unloads the rear. The rear ran out of grip first. Braking in a corner rotates the car." |
| `holds` outcome | **Title:** "Nice, it held." **Body:** "Neither axle used up its grip. AWD shares the push over four tires, so the budget lasts. It helps you accelerate, not turn tighter." **Say this:** "AWD gets you going. Grip gets you around." | **Title:** "Not quite. It held." **Body:** "Neither meter hit 100%. Power and cornering both had room. Don't assume a car slides just because you're on the gas." |
| `push` in snow (sc-09) | **Title:** "Snow shrinks the budget." **Body:** "Snow gives a third of dry grip. A front-driver spends it fast: pull and turn at once and it goes wide. Ease off and it comes back." | (as `push`, plus "snow" line) |
| sc-13 (AWD snow) | **Title:** "AWD is not magic." **Body:** "AWD sends drive to the rear, too, so on ice the rear can let go. More driven tires means better start, not more cornering grip." | **Title:** "Not quite. AWD slid." **Body:** "The rear meter passed 100%. AWD helps traction, not the grip you have in the corner." |
| Reason step (L4-5), reason correct | **Title:** "Right reason, too." **Body:** "You named the axle that ran out. That's what turns a guess into understanding." | **Title:** "Right path, wrong why." **Body:** "You picked the path, but the axle that ran out was the other one. Read the meters next time." |

Camera: top-down freeze with the saturated axle ringed gold; slip arrows on the sliding axle; callout cards appear one at a time (250 ms each), say-this last. Reduced motion: hard cuts, no camera sweeps.

## 13. Scoring & mastery signals
- **Score (0-100):** per round 100 if the path and (L4-5) reason are correct; 60 if the path is right but the reason is wrong; 0 otherwise; minus 10 per hint used (min 0). Session score = mean. Accuracy = correct paths / rounds.
- **Outcome ids:** `round-N-correct`, `round-N-wrong`, `round-N-timeout`.
- **Mistake -> conceptId mapping:**

| mistake | conceptId | description text |
|---|---|---|
| Chose `oversteer` when `push` was right | `understeer` | "Called a wide line an oversteer. The front ran out first." |
| Chose `push` when `oversteer` was right | `oversteer` | "Called a tail-out an understeer. The rear ran out first." |
| Chose slide when `holds` was right | `drive-layout-handling` | "Assumed a slide when neither axle ran out." |
| Chose `holds` when a slide was right (power event) | `traction-limit` | "Forgot that turning and pushing share one grip budget." |
| Wrong on `lift` or `brake` scenario | `weight-transfer` | "Missed that lift or braking moves weight off the rear." |
| Wrong on AWD scenario | `awd` | "Thought AWD cannot slide." |
| Wrong reason step | `traction-limit` | "Named the wrong axle as the one that ran out." |

- **Mastery signals** (cap +/-0.30 per concept per session):

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct `push` | `understeer` | +0.15 | "Predicted the front would run out first." |
| Correct `oversteer` power | `oversteer` | +0.15 | "Predicted the rear letting go on power." |
| Correct `oversteer` lift/brake | `weight-transfer` | +0.15 | "Predicted rotation from moved weight." |
| Correct `holds` AWD | `awd` | +0.10 | "Read that shared drive keeps the budget." |
| Correct any | `drive-layout-handling` | +0.10 | "Matched layout to behavior." |
| Correct reason | `traction-limit` | +0.10 | "Named the saturated axle." |
| Wrong (see mistakes) | mapped concept | -0.10 | mistake text |
| Hint used | any | halves positive deltas | "Used a hint." |
- **`SimulationResult` mapping:** `outcomes[]` from outcome ids; `mistakes[]` from the table; `masterySignals[]` from the table; `score`, `accuracy`, `hintsUsed` in `telemetry`.

## 14. XP & hearts
- `xpEarned` proposal: +10 per correct round, +40 for finishing; native clamps to the lesson budget.
- `heartsLost`: 1 if two or more rounds are wrong; max 1 per session.
- `replayAvailable`: true unless aborted.

## 15. Failure states
| Case | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Wrong round | Explain moment with correct path | `round-N-wrong`, mistake | Per section 14 |
| Timeout | "Time." then the answer explained | `round-N-timeout`, `timeout` flag, counts wrong | Per section 14 |
| Failed session (<= 1 round correct) | Summary with recap and "Try again" | `completed=true`, low score | 1 heart |
| Abort / backgrounded > 30 s | Native exit handling | `aborted=true`, `xpEarned=0` | 0 |
| Asset missing | Error screen, native fallback lesson offered | `error ASSET_LOAD_FAILED` | 0 |
| Invalid config | Error, native fallback offered | `error CONFIG_INVALID` | 0 |
Failure always ends in an explain moment; nothing dead-ends.

## 16. Accessibility
- **Reduced motion:** hard cuts; no camera sweeps or shake; ghost paths solid rather than animated dash; meters snap instead of easing.
- **Haptics off:** all feedback also visual and audio.
- **Color-blind:** the three ghost paths differ by pattern (solid, dotted, dashed) and by label; meters use a shape change (double line) when over 100%; rose/gold are never the only cue.
- **Text scale:** overlays honor `textScale`; cards reflow.
- **Tap-only:** the whole sim is tap-only.
- **VoiceOver/TalkBack:** Unity content is limited; the chips are exposed with labels (path names, meter values when `showModelNumbers`), but the animation is not. The accessible alternative is native lesson `hc-04-native`.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Path chosen | Soft tap | Light tick |
| Correct | Warm two-note | Light success |
| Wrong | Low soft thud | Warning |
| Meter crosses 100% | Tire-scrub squeal (original synth, low volume) | Soft tap |
| Freeze | Whoosh-down | Soft tap |
All honor `soundEnabled` and `hapticsEnabled`. No music.

## 18. Art & asset list
| asset | procedural or external | source & license | size | notes |
|---|---|---|---|---|
| Corner and surface patterns | Procedural | Astra, `original-swoond` | n/a | Snow = hatch pattern |
| Car models (FWD/RWD/AWD/MR silhouettes) | Procedural low-poly, generic (not a real model) | Astra, `original-swoond` | < 2,000 tris each | Layout indicated by chip and drive-wheel markers; no brand cues |
| Overlays, meters, arrows | Procedural | Astra | n/a | Per ART_DIRECTION section 4 |
| Audio (tire scrub, cues) | Synthesized | In-house, `original-swoond` | < 300 KB total | |
Addressables bundle `cars-handling-drive-layout`, expected < 2 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps on iPhone 13-class, memory < 150 MB, cold launch < 2 s. Per-sim: < 40k triangles, < 60 draw calls, bundle < 2 MB, deterministic fixed-step physics at 60 Hz.

## 20. Telemetry
Standard diagnostics (fps, load ms, memory) plus `hintsUsed`, `decisionLatencyMs` per round, `reasonStepUsed`, `scenarioIds`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
- **AC-1:** With seed 42 and difficulty 2 the sim emits exactly 3 `outcomes`.
- **AC-2:** For every scenario, `LayoutHandlingModel.Evaluate` reproduces the golden outcome and `uf`/`ur` within 0.005.
- **AC-3:** Every scenario has an unambiguous outcome: no `u` within 0.05 of 1.0 that determines the class (sc-13 at 0.068 is the tightest).
- **AC-4:** The same seed yields the same scenario order and identical results; `mirror` never changes the outcome.
- **AC-5:** The three ghost paths end at least 2 m apart for every scenario.
- **AC-6:** Invalid configuration (e.g. `rounds: 9`, unknown key) yields `error CONFIG_INVALID` before any scene loads.
- **AC-7:** Bridge conformance: `ready`, `progress`, `checkpoint`, `result`, `requestExit` match the `unity-bridge` v1 examples.
- **AC-8:** `xpEarned <= lesson budget` and `heartsLost <= 1`.
- **AC-9:** Every explanation title <= 6 words and body <= 45 words (test on the data set).
- **AC-10:** With `reducedMotion` there is no camera sweep or shake in Freeze/Explain.
- **AC-11:** Every color meaning has a second channel (pattern, shape or label).
- **AC-12:** Cold launch < 2 s and memory < 150 MB on iPhone 13-class.
- **AC-13:** Abort emits `result` with `aborted=true`, `xpEarned=0`.
- **AC-14:** Hint use halves positive mastery deltas and is recorded.

## 22. Test plan
- **EditMode:** `LayoutHandlingModel` golden fixtures; scenario-set validation (margins, uniqueness, path separation); config validation; result schema validity; scoring maths; determinism by seed.
- **PlayMode:** scene builds from code; full run with scripted taps; freeze/explain sequence; pause/resume/abort; reduced-motion path; timeout path.
- **Perf:** measured run on iPhone 13-class.

| AC | Test type | Test name |
|---|---|---|
| AC-1 | PlayMode | `FullRun_Seed42_Level2_Emits3Outcomes` |
| AC-2 | EditMode | `Model_Golden_MatchesAllScenarios` |
| AC-3 | EditMode | `ScenarioSet_MarginsAtLeast005` |
| AC-4 | EditMode | `Seed_Determinism_AndMirrorInvariant` |
| AC-5 | EditMode | `GhostPaths_SeparationAtExit` |
| AC-6 | EditMode | `Config_Invalid_ReturnsConfigInvalid` |
| AC-7 | EditMode | `Bridge_Conformance_AgainstExamples` |
| AC-8 | EditMode | `Xp_Hearts_Clamps` |
| AC-9 | EditMode | `Copy_Length_Limits` |
| AC-10 | PlayMode | `ReducedMotion_NoSweeps` |
| AC-11 | PlayMode | `ColorBlind_SecondChannel` |
| AC-12 | Perf | `Perf_iPhone13_Budget` |
| AC-13 | PlayMode | `Abort_EmitsAbortedResult` |
| AC-14 | EditMode | `Hint_HalvesPositiveDeltas` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is the stylized friction-circle model (section 11) acceptable to an automotive SME as directionally correct (e.g. FWD lift-off is stable; braking mid-corner rotates every layout)? Golden values are non-normative until the generator runs. | Claude / SME | No, before `spec-approved` |
| 2 | New environment key `corner_topdown` and `GripMeter` highlight variant: build in the Racing module or sim-local? | Astra | No |
| 3 | Should hc-04 be a sim at all, or native (see CDS question 7)? Proposal: playtest with the native fallback and keep the sim only if it wins. | Product / Astra | No |
| 4 | Confirm that the generic silhouette (no real model) is preferred over a real car model for the vehicle mesh. | Product | No |
| 5 | Does the Racing module's `SlipArrows` API fit a top-down non-racing car without `HandlingBalance`? | Astra | No |
