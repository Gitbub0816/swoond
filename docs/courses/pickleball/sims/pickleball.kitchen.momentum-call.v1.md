# Kitchen Momentum Call (`pickleball.kitchen.momentum-call.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `pickleball.kitchen.momentum-call.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven; scenarios are data) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `pickleball`; `unitId`: `the-kitchen`; `lessonId`s: `kit-05` (primary), `review-03` (difficulty 4-5 boss review, unit `review-loop`).
- CDS row: section 12, "`kit-05`, `review-03`: Kitchen momentum call".
- Manifest entry: `docs/courses/pickleball/manifest.json` -> `unitySimulations[0]`.
- Prerequisite concepts (must be `mastered`, else the lesson shows a native primer first): `kitchen-nvz`, `kitchen-line`, `volley`, `volley-in-kitchen-fault`.

## 3. Learning objective(s) & concepts taught
- **Learner objective:** "You can watch a volley near the kitchen and call it legal or a fault, including the sneaky ones where the fault happens *after* the hit."
- Concepts:

| conceptId | Term | After this the learner can... |
|---|---|---|
| `kitchen-momentum` | Momentum rule | Say a volley is a fault if momentum carries you (or your paddle) into the kitchen, even after the ball is dead. |
| `volley-in-kitchen-fault` | Volley in the kitchen | Call a fault when a volley is struck while standing in the zone. |
| `kitchen-line-is-kitchen` | The line is kitchen | Call a fault for a toe on the line at contact. |
| `bounce-in-kitchen-ok` | Bounce, then step in | Call legal when a bounced ball is played from inside the zone. |
| `paddle-over-kitchen-ok` | Reach over | Call legal when feet are outside and only the paddle reaches over. |
| `leave-kitchen-before-volley` | Exit first | Call a fault when the next ball is volleyed before the player has left the zone. |
| `erne` | Erne | Recognise the legal Erne (airborne outside the zone, lands outside) and the illegal one (lands in). |
| `volley` | Volley | Identify a volley: ball struck before it bounces. |
- **Out of scope:** scoring, serve rules, strategy, other faults (double bounce, out balls), any ball-striking skill.

## 4. Why Unity (tier justification)
- **Rubric signals met:** *movement over time* (the fault is defined by where the feet are at contact and where the body goes after) and *camera perspective* (a low side-on view shows foot vs line; a top-down view shows the path). Timing in a scene: the same clip can be legal or a fault depending on one frame.
- **Closest native type:** `binary-call` (static diagram with markers, choices "Fault / Legal"). It teaches the *static* rule well and is used in `kit-03`/`kit-04`. It cannot show a body continuing to travel after contact, a paddle tip tapping the zone, or an airborne Erne. Those "after" moments are exactly where beginners are wrong and where the arguments at the courts happen.
- **Fallback:** a native lesson `kit-05-native` (binary-call series + a sequence-order "frames" exercise) is provided as the accessibility/failure fallback, not a port.
- Justification is strong; Unity retained.

## 5. Player fantasy & core loop
- **Fantasy:** You are the sharp-eyed friend at the next court who knows exactly when to say "Fault!" and can explain why.
- **Core loop (per round):**
  1. Prompt card: "Watch the volley. Fault or legal?" (Intro)
  2. Clip plays at 1x from a side-on broadcast camera: ball arrives, the rose-ringed player volleys, the body continues for 1.2 s after contact. A small "You can replay once" chip is shown at levels 1-2.
  3. Decision: two large buttons, **Legal** and **Fault** (DecisionPoint). At difficulty >= 4 a time limit applies.
  4. Execute: the sim reveals whether the call was right with a gold ring on the deciding frame.
  5. Freeze/explain: slow-mo replay (0.25x) from side and top-down, zone shaded, foot ring and momentum arrow drawn, explanation card, and a "say this" line.
- **Session length:** about 3 minutes, 3 rounds by default (configurable 3-6).

## 6. Scene & entities
- **Environment key:** `pickleball_court` (procedural: court surface `court` color, lines, net, kitchen zone). New environment key requested (see Game Kit additions).
- **Camera presets:** `broadcast-side` (low, side-on at the kitchen line, FOV 50, default), `top-down` (for the path overlay), `first-person` unused.
- **Units:** meters. Origin at net center; x across (-3.05..3.05), z along the court (-6.705..6.705), net at z=0; the learner's team is on z<0. Kitchen near side: z in [-2.134, 0]; kitchen line at z=-2.134.

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `court` | `Court` (Swoond.Sports.Pickleball; reserved name in GAME_KIT section 2) | Lines, net, kitchen `Zone` | dims above; `kitchenDepth` 2.134 |
| `kitchenZone` | `Zone` | Kitchen region overlay | `rewardTint` when the correct decisive frame is revealed; `accentTint` for fault emphasis |
| `kitchenLine` | `Zone` (thin) | The line itself (counts as kitchen) | width 0.038 m (1.5 in) |
| `player` | `Character` | The volleyer (rose ring) | height 1.75 m; `AnimState`: ready, volley-forehand, volley-backhand, jump, recover |
| `opponent` | `Character` | Off-screen striker; only the ball origin | Muted style |
| `ball` | `Ball` | The volley ball | Wiffle-style low-poly, diameter 0.074 m; deterministic flight |
| `contactMarker` | `Highlight` | Ring at contact frame, gold when revealed | pulse 1 Hz (static under reduced motion) |
| `footRings` | `Highlight` x2 | Ring under each foot at contact | color + shape (solid circle = outside, diamond = on/in) |
| `momentumArrow` | `Path` | Drawn from contact position along afterPath | gold if the path enters the zone, rose otherwise |
| `decision` | `DecisionPoint` | Legal / Fault | 2 options, optional `TimeLimit` |
| `explain` | `Explanation` | Freeze card | Title, body, say-this |
| `replay` | `Replay` + `SlowMotion` | Slow-mo replay at 0.25x | pitch-shifted or muted audio |
| `hints` | `Hint` | Level 1-3: pre-shaded zone, "watch the feet" arrow | recorded per use |
| `score` | `Score` | Results | see section 13 |

- **Reused vs new:** all primitives reused. **New (requested under "Game Kit additions requested"):** the `Court` sport module (pickleball) with `Kitchen` zone geometry, and a `pickleball_court` environment key. Reuse plan: the same module serves the other four pickleball sims and future tennis/padel sims.
- **Initial layout (side view, learner's side left of the net):**
```
        z=-2.134 (kitchen line)   z=0 (net)
  ---------|=========KITCHEN========|  net
  player o<-- feet outside/on/in       ball ---->
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Call | Tap | **Legal** / **Fault** pill buttons (bottom, 56 pt tall, full width halves) | >= 56 x 140 pt | Selected button gets `accent` outline; light haptic tick |
| Replay clip | Tap | "Replay" chip (levels 1-2, once per round) | 44 x 88 pt | Clip restarts at 1x |
| Scrub (optional hint) | Drag | Timeline bar under the clip, visible only in Explain | 44 pt tall | Frame-accurate scrub with foot rings |
| Next | Tap | "Next" primary during Summary/Explain | 56 pt | Pill button (native design language, drawn in Unity overlay) |
- **Tap-only alternative:** all interactions above are taps except scrub, which has "step back / step forward" frame buttons (44 pt).
- **Safe area / orientation:** portrait; overlay respects `runtime.safeAreaInsets`; camera frames the court centered in the top 60% of the screen, buttons in the bottom.
- **Not drawn by Unity:** hearts sheet, paywall, exit confirmation, XP animation (native). Unity draws only the in-sim "X" that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate config; build court and characters from code; load scenario set | Ready or `error` (`CONFIG_INVALID`, `ASSET_LOAD_FAILED`) | `ready` (with versions, load time) |
| Intro | After ready | Prompt card ("Watch the volley. Fault or legal?"); 1.5 s | Playing | `progress 0.0` |
| Playing | Round starts | Clip plays at 1x; camera `broadcast-side` | Clip ends (about 4 s) | none |
| Decision | Clip ended | `DecisionPoint` shown; timer if configured | Call made or timeout (counts as wrong, `timeout` flag) | none |
| Executing | Call made | Gold ring on deciding frame, correct/incorrect title | 0.8 s later Freeze | none |
| Freeze | Executing done | `SlowMotion.Freeze`; scene dims 35%; camera to `top-down` for 0.6 s then back | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | Slow-mo replay 0.25x with overlays; card with title/body/say-this; scrub enabled | Learner taps Next | `checkpoint round-N` |
| Summary | Last round explained | Score numerals count up (600 ms); mistakes recap with concept names | Done | `progress 1.0` |
| Done | Summary shown | Build `SimulationResult`; send `result`; then `requestExit(completed)` | End | `result`, `requestExit` |
| Paused | Native `pause` | Freeze sim time, audio, timers; do not advance the decision timer | `resume` -> previous state | (none) |
| Aborted | Native `abort` or in-sim X | Stop; result with `aborted=true`, partial outcomes, `xpEarned=0` | End | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Clip speed | 0.75x | 1.0x | 1.0x | 1.0x | 1.25x |
| Decision time limit (s) | none | none | 12 | 8 | 5 |
| Kitchen zone pre-shaded | yes | yes | yes | no (flash 1 s at start) | no |
| Foot rings during clip | yes | yes | no | no | no |
| Replay chip allowed | yes (1) | yes (1) | no | no | no |
| Hints available | 2 | 1 | 1 | 0 | 0 |
| Scenario pool tags | `basic` | `basic`,`line` | `line`,`momentum` | `momentum`,`paddle`,`erne` | all incl. `two-shot` |
| Distractor near-misses (legal look-alikes) | 0 | 1 of 3 | 1 of 3 | 2 of 3 | 2 of 3 |
| Reason step required | no | no | no | yes | yes |
- **Default for `kit-05`:** difficulty 2. **`review-03` default:** 4. Level 1 is passable by a true beginner with hints (pre-shaded zone, foot rings, slow clip).
- **Reason step (L4-5):** after the call, pick one reason chip from three (e.g. "Toe on the line", "Momentum carried her in", "Nothing wrong"); wrong reason is scored as a partial mistake (section 13).

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "pickleball.kitchen.momentum-call.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["kitchen-starter", "kitchen-momentum-focus", "kitchen-mixed"], "default": "kitchen-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "showRouteHints": { "type": "boolean", "default": true, "description": "Pre-shade the kitchen and draw foot rings (also gated by difficulty)." },
    "decisionTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 3, "maximum": 30, "default": null, "description": "Overrides the difficulty default when set; null uses the difficulty table." },
    "requireReasonStep": { "type": ["boolean", "null"], "default": null, "description": "null = use difficulty default." },
    "cameraPreset": { "type": "string", "enum": ["broadcast-side", "top-down"], "default": "broadcast-side" }
  }
}
```
Valid example:
```json
{ "seed": 42, "scenarioSetId": "kitchen-starter", "scenarioCount": 3, "showRouteHints": true }
```
Invalid configuration (unknown key, out-of-range, unknown `scenarioSetId`) -> `error CONFIG_INVALID` (recoverable=false).

## 11. Scenario data set
- **Format:** `Scenarios/kitchen-momentum-v1.json` (Addressables, bundle `sim-pickleball-kitchen-momentum`), array of scenarios; sets select by tag: `kitchen-starter` = tags `basic`,`line`; `kitchen-momentum-focus` = `momentum`,`paddle`; `kitchen-mixed` = all. Deterministic per seed: the seed shuffles order within the difficulty's tag pool and swaps left/right mirror (x -> -x) for variety (mirroring does not change correctness).
- **Count:** N = **12 scenarios** (>= rounds x 3 = 9 with default 3 rounds; 12 gives 4 replay variety draws). Generation rule: each scenario is defined by feet at contact, ball type (volley/bounce), after-path and paddle path; more can be generated by perturbing offsets within +-0.15 m while preserving the correct call.
- **Scenario JSON shape:**
```json
{
  "scenarioId": "kit-s01-outside-clean",
  "ball": { "from": [0.8, 1.2, 4.5], "contact": [0.4, 0.95, -2.6], "bounceBeforeContact": false },
  "player": { "startXZ": [0.2, -3.6], "feetAtContact": { "left": [0.25, -2.85], "right": [0.55, -2.95] }, "afterPath": [[0.0, 0.4, -2.9], [0.6, 0.35, -3.2], [1.2, 0.3, -3.4]], "airborne": false },
  "expected": { "call": "legal", "reasonId": "outside-and-stable", "conceptId": "volley" },
  "tags": ["basic"]
}
```
- **Scenarios:**

| scenarioId | Setup | Correct call | Teaches conceptId | Tags |
|---|---|---|---|---|
| `kit-s01-outside-clean` | Volley from 0.35 m behind the line, steps back after. | Legal | `volley` | basic |
| `kit-s02-toe-on-line` | Volley with right toe on the line (z=-2.134), otherwise balanced. | Fault | `kitchen-line-is-kitchen` | basic, line |
| `kit-s03-momentum-carry` | Volley from 0.2 m behind the line, lunging; after contact right foot lands 0.3 m inside. | Fault | `kitchen-momentum` | momentum |
| `kit-s04-bounce-then-in` | Ball bounces at z=-1.0; player steps in and dinks after the bounce. | Legal | `bounce-in-kitchen-ok` | basic |
| `kit-s05-reach-over` | Feet 0.3 m outside the line; paddle reaches over the zone to volley a high ball at z=-1.4. | Legal | `paddle-over-kitchen-ok` | paddle |
| `kit-s06-stay-in-and-volley` | Player in kitchen after a bounce shot, next ball arrives; volleys without leaving. | Fault | `leave-kitchen-before-volley` | two-shot |
| `kit-s07-erne-legal` | Player runs outside the sideline (x=-3.4), jumps and volleys airborne beside the zone, lands outside (x=-3.3). | Legal | `erne` | erne |
| `kit-s08-erne-lands-in` | Same jump but lands inside the kitchen (x=-2.6, z=-1.6). | Fault | `kitchen-momentum` | erne, momentum |
| `kit-s09-paddle-tap` | Volley from behind the line; follow-through taps paddle tip on the kitchen surface. | Fault | `kitchen-momentum` | paddle, momentum |
| `kit-s10-line-bounce-then-in` | Ball bounces on the kitchen line (in); player stands in the zone and hits it after the bounce. | Legal | `bounce-in-kitchen-ok` | line |
| `kit-s11-hop-back` | Player volleys, momentum toward the line, hops back and stops with both feet 0.1 m outside. | Legal | `kitchen-momentum` | momentum (near-miss) |
| `kit-s12-both-toes-line` | Volley, then stops with the front toe exactly on the line. | Fault | `kitchen-line-is-kitchen` | line, momentum |

The rest may be summarized by the generation rule above; the first three are fully specified in the JSON shape (s01 above; s02 = same with `right: [0.55, -2.134]`, expected fault; s03 = s01 with `afterPath` `[[0.0,0.4,-2.4],[0.4,0.5,-1.9],[0.9,0.5,-1.6]]`, expected fault, reason `momentum-carried-in`).

## 12. Freeze / explain moments
Title <= 6 words; body <= 45 words; say-this optional.

| id | Trigger | Freeze frame & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-legal-clean` | s01, correct | Contact frame; feet rings solid; kitchen shaded gold | Correct | Nice read. Clean volley. | Both feet were outside the zone when you hit it, and you stayed out. Volleys are fine anywhere behind the kitchen line. That is the whole rule. | "Good volley, and she stayed out of the kitchen." |
| `x-legal-clean-wrong` | s01, wrong call | Same, rose outline on your Fault choice | Incorrect | Not quite. That was legal. | Both feet stayed behind the line the whole time. Volleying from outside the kitchen is allowed. Only standing in it, or touching it, ruins the shot. | "That volley was fine; feet were outside." |
| `x-line` | s02/s12, correct | Foot ring becomes diamond on the line; line glows | Correct | Nice read. Toe counts. | The kitchen line belongs to the kitchen. A toe on it during a volley is a fault, even if the rest of you is outside. | "Her toe was on the line. That's a kitchen fault." |
| `x-line-wrong` | s02/s12, wrong | Same with rose ring | Incorrect | Not quite. The line counts. | The line is part of the kitchen. If any part of you touches it while volleying, it is a fault. Look at the toe, not the hips. | "The line is kitchen. Toe on it is a fault." |
| `x-momentum` | s03/s09/s08, correct | Momentum arrow gold into zone; time scrub at the touch frame | Correct | Nice read. Sneaky momentum. | The volley was legal at contact. Then momentum carried her in. That is still a fault, even after the ball is dead. Hit, then stop yourself outside. | "Momentum carried her into the kitchen. Fault." |
| `x-momentum-wrong` | s03/s09/s08, wrong | Arrow shown; rose outline | Incorrect | Not quite. Watch afterward. | The hit was fine, but she kept travelling and landed in the kitchen. Faults can happen after contact. Keep watching until she has fully stopped. | "It's the follow-through that got her." |
| `x-bounce-in` | s04/s10, correct | Ball bounce marker; player in zone gold | Correct | Nice read. Bounce, then enter. | You can stand in the kitchen to hit a ball that has already bounced. The rule only bans volleys there. | "It bounced first, so she could step in." |
| `x-bounce-in-wrong` | s04/s10, wrong | Bounce marker highlighted | Incorrect | Not quite. It bounced first. | The ball bounced before she hit it, so it was not a volley. You are allowed in the kitchen for those. Look for the bounce dot. | "It bounced, so it wasn't a volley." |
| `x-reach` | s05, correct | Paddle over zone gold; feet rings outside | Correct | Nice read. Reach is fine. | Only her paddle was over the kitchen. Her feet stayed outside, so the volley is legal. The rule is about where you stand, not where your paddle goes. | "Paddle over is fine. Feet were outside." |
| `x-reach-wrong` | s05, wrong | Same | Incorrect | Not quite. Feet are the test. | Her feet were outside the kitchen. Reaching over with the paddle is legal. Check the feet, then the line. | "Feet outside means the reach is legal." |
| `x-stay-in` | s06, correct | Two-shot replay; first bounce shot, second volley in zone | Correct | Nice read. Exit first. | She was already in the kitchen for the bounced ball, then volleyed the next one without leaving. To volley, step out first. | "She has to leave before she volleys again." |
| `x-stay-in-wrong` | s06, wrong | Same | Incorrect | Not quite. She stayed in. | Entering after a bounce is fine. But the next volley must be hit from outside. She stayed in and volleyed, which is a fault. | "You can go in for a bounce, then get out." |
| `x-erne-legal` | s07, correct | Top-down path outside the sideline | Correct | Nice read. Legal Erne. | Jumping from outside the zone, volleying in the air and landing outside is legal. That is the Erne. | "That Erne was legal. She never touched the kitchen." |
| `x-erne-legal-wrong` | s07, wrong | Same | Incorrect | Not quite. That Erne worked. | She left the ground outside the kitchen, hit in the air and landed outside. Nothing touched the zone, so it stands. | "Erne is legal if she lands outside." |
| `x-hop` | s11, correct | Toes 0.1 m short; ring solid | Correct | Nice read. Close, not touching. | She stopped just short. Close calls are legal until something touches the zone. Judge by contact, not by nearness. | "She stopped short. No fault." |
| `x-hop-wrong` | s11, wrong | Same | Incorrect | Not quite. She stopped. | Her feet never touched the kitchen. Coming close is not a fault. Only touching is. | "Nothing touched the zone, so no fault." |
| `x-timeout` | Decision timeout | Clip loops in slow-mo | Timeout | Time's up. Let's look. | You ran out of time, which happens. Watch the feet and the follow-through, then we will replay it slowly. | "Take a beat, watch the feet." |

- Callout order (Art direction): 1) gold pulse on the deciding element (400 ms), 2) rose outline on the learner's choice if different, 3) callouts one at a time (250 ms each), 4) say-this line last.
- Camera: `broadcast-side` for foot/line; brief `top-down` for the path scenarios (s03, s07, s08, s09).

## 13. Scoring & mastery signals
- **Round outcome id:** `round-N`; success = correct call (and, at L4-5, correct reason for full credit).
- **Score (0-100):** `round(100 * (sum of round points) / roundCount)`, round points: 1.0 for correct call (+ correct reason at L4-5), 0.6 for correct call with wrong reason (L4-5 only), 0.0 wrong/timeout; hints used: -0.1 each (min 0.4 for correct rounds).
- **accuracy** = correct calls / rounds.
- **Mistake -> conceptId mapping:**

| Mistake | conceptId | Description text |
|---|---|---|
| Called legal when toe on line | `kitchen-line-is-kitchen` | Missed that a toe on the kitchen line counts as being in the kitchen. |
| Called legal on momentum carry | `kitchen-momentum` | Missed a fault that happened after the volley because momentum carried the player in. |
| Called fault on a bounce-then-enter | `bounce-in-kitchen-ok` | Called a fault when the ball had already bounced. |
| Called fault on paddle reach with feet outside | `paddle-over-kitchen-ok` | Confused a paddle reach with standing in the kitchen. |
| Called legal on stay-in-and-volley | `leave-kitchen-before-volley` | Missed that the player volleyed without leaving the kitchen first. |
| Called fault on legal Erne | `erne` | Thought a legal Erne was a fault. |
| Called legal on Erne landing in | `kitchen-momentum` | Missed that landing in the kitchen after an Erne is a fault. |
| Called fault on clean volley | `volley` | Called a fault on a clean volley from outside. |

- **Mastery signals:** `event | conceptId | delta | evidence`:
  - correct on `kit-s02`/`s12` -> `kitchen-line-is-kitchen` +0.20 "Spotted the toe on the line."
  - correct on `s03`/`s08`/`s09` -> `kitchen-momentum` +0.25 "Called the fault that happened after the hit."
  - correct on `s04`/`s10` -> `bounce-in-kitchen-ok` +0.20 "Knew a bounced ball can be played from inside."
  - correct on `s05` -> `paddle-over-kitchen-ok` +0.20; `s06` -> `leave-kitchen-before-volley` +0.20; `s07` -> `erne` +0.20; `s01`/`s11` -> `volley` / `kitchen-momentum` +0.10.
  - wrong -> the corresponding concept -0.15 (per table above).
  - hints used halve positive deltas (native applies; Unity reports `hintsUsed` in telemetry and outcome `value`).
  - **Per-session caps:** at most +0.30 and -0.30 per concept per session.
- **Mapping to `SimulationResult`:** `outcomes[]` = one per round (`id round-N`, `success`, `label` "Called {scenarioId} correctly/incorrectly", `value` = the correct call string); `mistakes[]` = one per wrong call with conceptId, text from table, `at` = active ms; `masterySignals[]` as above; `score`, `accuracy`, `durationMs`.

## 14. XP & hearts
- **`xpEarned` proposal:** +10 per correct round, +40 for finishing all rounds (native clamps to lesson budget). Aborted: 0.
- **`heartsLost`:** 1 if accuracy < 0.34 (fewer than one third correct), else 0; max 1 per session.
- **`replayAvailable`:** true (Replay of the last completed session's rounds is supported through `Replay` records; native shows "Play again").

## 15. Failure states
| Situation | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round (wrong call) | Explain moment with slow-mo, "Not quite." | outcome `success=false`, mistake logged | none per round |
| Failed session (accuracy < 0.34) | Summary: "Rough set. That one is tricky, and it is the one everyone argues about." + "Try again" | `completed=true`, `heartsLost=1` | -1 |
| Decision timeout | "Time's up. Let's look." + Explain | outcome false, mistake with `timeout` flagged in description | none extra |
| Abort (X, native abort, backgrounded > 120 s) | Native handles confirmation | `aborted=true`, `abortReason`, partial outcomes, `xpEarned=0` | none |
| Asset missing | Native error sheet from `error ASSET_LOAD_FAILED` (recoverable) | none | none |
| Invalid config | Native error, activity skipped | `error CONFIG_INVALID` | none |
Failure always ends in an explain moment and a suggested next step ("Watch the replay again").

## 16. Accessibility
- **Reduced motion:** hard cut to freeze; no camera sweeps (cuts between presets); slow-mo replay stays (it is the teaching content) but shortens the sweep to a cut; no shake; static rings.
- **Haptics:** honor `hapticsEnabled`; off = no haptics, visual/audio only.
- **Color-blind modes:** every color meaning has a second channel: foot rings = circle (outside) vs diamond (on/in); zone has diagonal hatch; correct = gold ring plus check glyph; wrong = rose ring plus X glyph.
- **Text scale:** overlays honor `textScale` up to 2.0; card body reflows; buttons grow.
- **Tap-only:** yes (section 7); frame stepper replaces scrub.
- **VoiceOver / TalkBack:** Unity content is limited; provide the accessible native fallback lesson **`kit-05-native`** (binary-call series with textual descriptions of the frames: "Right foot touches the line at contact") when `accessibility.reducedMotion`/screen reader is detected by native; no XP penalty.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Ball contact (clip) | Paddle "pop" | none | 0.6 |
| Decision made | Soft tick | light tap | 0.4 |
| Correct | Warm two-note chime | light success | 0.5 |
| Wrong | Low soft thud | warning | 0.4 |
| Freeze | Low whoosh, pitch drop | soft tap | 0.4 |
| Replay 0.25x | Pitch-shifted or muted (spec choice: muted) | none | 0 |
All honor `soundEnabled` and `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural / external | Source & license | Budget | Notes |
|---|---|---|---|---|
| Court surface, lines, net, kitchen | Procedural | generated, `original-swoond` | < 2k tris | `court` theme color |
| Characters (player, opponent) | Procedural capsule-bodied low-poly | generated | < 3k tris each | jersey number; rose ring for player |
| Ball, paddle | Procedural | generated | < 500 tris | ball has 26 visible holes |
| Overlays (zone, arrows, rings, callouts) | Procedural (shader/UI) | generated | n/a | per ART_DIRECTION section 4 |
| Sounds | External original foley (or synthesised) | Swoon'd, `original-swoond` | <= 1 MB | |
| Fonts | TextMeshPro assets from Instrument Serif and Geist (OFL) | shared | shared | |
- **Addressables bundle:** `sim-pickleball-kitchen-momentum`, expected size <= 6 MB (scenarios + audio).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps (p5 >= 50), memory < 150 MB, cold launch < 2 s to `ready`, bundle <= 25 MB (target 6 MB), draw calls <= 150, on-screen tris <= 60k (target < 15k), textures <= 8 MB VRAM. Tighter: peak memory < 110 MB; 3-minute session must stay at thermal "nominal/fair".

## 20. Telemetry
`telemetry` includes: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `decisionLatencyMsMedian`, `replayChipUsed`, `timeouts`, `scenarioIds` (ids only), `difficulty`. No personal data; never `personName`/`relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** With seed 42, difficulty 2, `scenarioCount` 3, the sim emits exactly 3 `outcomes`, and the same scenarios in the same order on a second run.
2. **AC-2:** Each scenario's `expected.call` matches the rule evaluator run over its `feetAtContact`, `afterPath` and paddle path (EditMode oracle test, all 12 scenarios plus 100 perturbed variants).
3. **AC-3:** Mirroring x does not change the evaluator result.
4. **AC-4:** `ready` is emitted in < 2 s after `launch` (editor-simulated device).
5. **AC-5:** The `result` validates against `simulation-result.schema.json`; `simulationId` and `simulationVersion` match; exactly one `result` is sent; `requestExit` follows.
6. **AC-6:** All copy strings satisfy: title <= 6 words, body <= 45 words.
7. **AC-7:** Every explain moment has correct and incorrect variants.
8. **AC-8:** `pause` freezes the decision timer; `resume` continues; paused time excluded from `durationMs`.
9. **AC-9:** `abort` yields `aborted=true`, matching `abortReason`, `xpEarned=0`.
10. **AC-10:** With `reducedMotion=true` no camera sweep or shake occurs (asserted by camera-transform sampling).
11. **AC-11:** With `colorBlindMode=protanopia|deuteranopia|tritanopia` every color-coded element also has its shape/pattern channel (visual snapshot test).
12. **AC-12:** Tap-only scheme completes a full session without drag input.
13. **AC-13:** Invalid configuration (out-of-range `scenarioCount`, unknown key) yields `error CONFIG_INVALID`.
14. **AC-14:** 60 fps p5 >= 50 fps and peak memory < 110 MB on iPhone 13-class over a 3-round run.
15. **AC-15:** mastery signals respect per-session caps of +-0.30 per concept.
16. **AC-16:** Level 4-5 reason-step scoring: correct call + wrong reason scores 0.6.

## 22. Test plan
- **EditMode:** rule evaluator (`KitchenRule.Evaluate(feet, afterPath, paddlePath, bounced, airborne)`), config validation vs schema, result schema validity, scoring maths, determinism by seed, copy-length lint.
- **PlayMode:** scene builds from code; full scripted run (3 rounds) via a test `TouchController`; freeze/explain sequence; pause/resume/abort; reduced-motion path; colour-blind snapshot.
- **Perf:** measured 3-round run on iPhone 13-class.

| AC id | Test type | Test name |
|---|---|---|
| AC-1 | EditMode | `SeedDeterminism_Kitchen` |
| AC-2, AC-3 | EditMode | `RuleOracle_AllScenarios`, `Mirror_Invariant` |
| AC-4 | PlayMode | `ColdLaunch_Under2s` |
| AC-5 | EditMode | `Result_SchemaValid` |
| AC-6, AC-7 | EditMode | `Copy_Lint` |
| AC-8, AC-9 | PlayMode | `Pause_Resume`, `Abort_Result` |
| AC-10 | PlayMode | `ReducedMotion_NoSweep` |
| AC-11 | PlayMode | `ColorBlind_SecondChannel` |
| AC-12 | PlayMode | `TapOnly_FullRun` |
| AC-13 | EditMode | `Config_Invalid` |
| AC-14 | Perf | `Perf_iPhone13` |
| AC-15, AC-16 | EditMode | `Mastery_Caps`, `ReasonStep_Scoring` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Add the `Court` sport module (pickleball) and `pickleball_court` environment key (Game Kit additions requested below). | Astra | Yes |
| 2 | Kitchen rule wording re "momentum after the ball is dead": confirm against the 2026 rulebook text before final copy. | Claude (content) | No |
| 3 | Prefer muted slow-mo audio or pitch-shifted? Default muted. | Astra | No |
| 4 | Foley for paddle pop: original recording or synthesis? | Product | No |

### Game Kit additions requested
- **`Court` module for pickleball** (`Swoond.Sports.Pickleball`): court dimensions, `Kitchen` zone, line width, `BounceRule` (reserved in GAME_KIT section 2). Justification: shared by all five pickleball sims and future tennis/padel/badminton.
- **`pickleball_court` environment key** (procedural).
- **`KitchenRule` evaluator** (sport-specific, within the module): pure function used by tests and the scenario oracle.
