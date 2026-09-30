# Aim Assist, Felt (`games.controls.aim-assist.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `games.controls.aim-assist.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft (playtest gate before approval, see section 4 and section 23) |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven; scenarios are data) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `video-games`; `unitId`: `mechanics-you-feel`; `lessonId`s: `mech-02` (primary, default difficulty 2) and `shoot-01` (unit `branch-shooters`, branch `shooters`, default difficulty 3).
- CDS row: section 12, "Aim assist, felt" and the Unity decision record.
- Manifest entry: `docs/courses/video-games/manifest.json` -> `unitySimulations[0]`.
- Native alternative lessons: `mech-02-alt` (accessibility and downgrade path; no XP penalty).
- Prerequisite concepts (must be `mastered`, else a native primer is shown): `analog-stick`, `kbm`, `sensitivity`, `deadzone`.

## 3. Learning objective(s) & concepts taught
- **Learner objective:** "You can feel why a thumbstick is harder to aim than a mouse, and you can name what each kind of aim assist actually does."
- Concepts:

| conceptId | Term | After this the learner can... |
|---|---|---|
| `stick-vs-mouse` | Stick vs mouse | Say that a stick sets how fast the crosshair moves while a mouse (or direct drag) sets where it is, so a stick is worse at tracking a moving target. |
| `aim-assist` | Aim assist | Say that aim assist is a designed help that compensates for stick input, and that the debate is about how strong it should be. |
| `aim-friction` | Friction (slowdown) | Recognise that the crosshair slows when it passes over a target. |
| `aim-magnetism` | Magnetism (sticky pull) | Recognise that the crosshair is pulled toward a nearby target when you are steering. |
| `rotational-assist` | Rotational assist | Recognise that the crosshair moves along with a moving target even when you barely steer. |
| `lock-on-targeting` | Lock-on | Recognise that lock-on removes the aiming task and is a different thing from aim assist. |
- **Out of scope:** real controller ergonomics, mouse precision, per-game tuning numbers, competitive fairness verdicts (that is `deb-02`), sensitivity settings in real games, hitscan vs projectile, recoil.

## 4. Why Unity (tier justification)
Full record: CDS section 12, "Unity decision record". Summary against the rubric (CLAUDE.md section 4):
- **Signals met:** movement over time in space (a strafing target), timing in a scene (tracking error accumulates), and a continuous closed loop between input mapping and outcome. The concept *is* the loop: rate control (stick) vs position control (direct) against a moving target, and how each assist changes the loop.
- **Closest native types:** `hotspot-tap` on a diagram of reticle and target, `sequence-order` of what happens each frame, `timing-tap` (1D), `say-this`. They show the result of the loop; none makes the learner *be* the controller. A native SwiftUI tracking canvas would be a fake game, forbidden as a native copy of a Tier A sim.
- **Honest weaknesses:** a touch screen is not a thumbstick (we compare rate vs position mapping on one device, not hardware feel); motor input excludes some learners (watch mode plus `mech-02-alt`); one lesson's worth of concept.
- **Verdict:** justified but conditional. **Downgrade rule:** if a 20+ novice playtest against `mech-02-alt` shows less than an 8-point lead on a one-week concept check for `stick-vs-mouse` and the four assist concepts, downgrade to native and archive this spec (no Astra work). Until then this is `spec-draft`, built last (ROADMAP: after phase 5, alongside the hiking sim).

## 5. Player fantasy & core loop
- **Fantasy:** You are at the practice range with a slippery target, finding out why your friend swears she needs the assist.
- **Core loop (per session, 3 rounds by default):**
  1. Prompt card (Intro): "Track the target. Keep the crosshair on it."
  2. Round 1 **Direct**: one-finger relative drag moves the crosshair (mouse-like). 15 s.
  3. Round 2 **Stick**: a virtual stick sets crosshair *speed*. Same target motion family. 15 s. Then a reflection decision (3 chips): "Why was that harder?"
  4. Round 3 **Stick + hidden assist**: the stick plus one assist (friction, magnetism, rotational or lock-on). 15 s. Then the classification decision: "What was helping you?" (chips, 2 to 4 by difficulty).
  5. Execute: reveal the assist and score the choice.
  6. Freeze/explain: replay with a **trace overlay** (input speed vs crosshair speed) and an **assist vector** arrow; explanation card and a "say this" line.
  - Rounds 4-6 (optional, `roundCount` up to 6) repeat round 3 with the remaining assist types.
- **Session length:** about 3 minutes for 3 rounds (18 s x 3 plus explain moments); watch mode about 2 minutes.

## 6. Scene & entities
- **Environment key:** `aim_range` (new, procedural): a dark flat backdrop on the `court` color family with a faint grid and a range wall; no scenery. Single fixed camera `range-front` (orthographic-like, FOV 40) so the playfield maps 1:1 to screen space. Reduced motion has no camera motion at all.
- **Units:** "vw" = the playfield's width. Playfield x in [-0.5, 0.5], y in [-0.375, 0.375] (aspect 4:3, rendered in the top 62% of a portrait screen). Target radius `R` (see section 9).

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `range` | `WorldBuilder` + `aim_range` env | Backdrop and grid | procedural; grid line 1 px |
| `target` | `Target` (moving) with `Path` motion functions | The moving thing to track | radius R; path family from scenario; deterministic by seed |
| `reticle` | `Highlight` (ring) | The crosshair | radius 0.02 vw; ring + centre dot (shape channel) |
| `aimModel` | `Swoond.Controls.ReticleAim` (new, pure) | Maps input to reticle motion; hosts `Direct`, `RateStick`, `AimAssist` variants | see section 10 |
| `stick` | `TouchController` scheme `virtual-stick` (existing) | Rate input | base radius 64 pt (128 pt diameter), deadzone applied by `aimModel` |
| `pad` | `TouchController` scheme `drag-relative` (new tiny scheme) | Direct input | relative delta x gain |
| `lockBtn` | `TouchController` button | Lock-on trigger | 64 x 64 pt; toast "Nothing to lock" when the round has no lock-on |
| `tracker` | `TrackingObjective` (new objective type `track_target`) | Time-on-target and mean error | success = ToT >= 0.05 (participation) |
| `decision` | `DecisionPoint` (multi-choice chips, GK-3) | Reflection and classification | 2-4 chips |
| `trace` | `TraceChart` (GK-16) `speed_trace` + `value_ribbon` | Freeze overlay: input speed vs reticle speed; error ribbon | two series, target-motion marks |
| `assistArrow` | `Path.Draw` | Per-frame assist vector during replay | rose (assist) vs muted (input) |
| `replay` | `Replay` + `SlowMotion` | 0.5x replay with overlays | deterministic |
| `hints` | `Hint` | Level 1-2 ring shows assist zone | recorded per use |
| `score` | `Score` | Result | section 13 |
- **Reuse vs new:** reuses `Target`, `Path`, `Highlight`, `DecisionPoint` (GK-3), `TraceChart` (GK-16), `Replay`, `SlowMotion`, `Hint`, `Score`, `TouchController`. **New:** `Swoond.Controls` module (`ReticleAim` pure functions and assist variants), objective `track_target` (`TrackingObjective`), TouchController scheme `drag-relative`, environment key `aim_range`. Reuse plan: `Swoond.Controls` also serves a future steering-assist sim (racing) and any "input mapping" lesson; `TrackingObjective` also fits camera-tracking, golf and cycling line following.
- **Initial layout (portrait):**
```
+--------------------------------------+
|  range wall / grid  (playfield 4:3)  |
|        (o) target -->                |
|   (+) reticle                        |
+--------------------------------------+
| [Lock]              ( stick base )   |   round 2+ ; round 1 shows a pad hint
| round 2 of 3       Tracking 62%      |
+--------------------------------------+
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Direct aim (round 1) | One-finger relative drag | Anywhere in the lower 38% pad area | pad >= 200 x 120 pt | Reticle moves by finger delta x gain; light tick on round start |
| Stick (rounds 2+) | Touch-and-hold, drag within the base | Virtual stick at the lower right | base 128 pt diameter | Thumb dot; reticle *velocity* follows deflection (section 10) |
| Lock (rounds with a Lock button) | Tap | Lock button, lower left | 64 x 64 pt | If a lock-on assist exists: ring snaps; else toast "Nothing to lock" and a soft tap |
| Decision chips | Tap | Chips (2-4) | >= 56 x 140 pt each | `accent` outline; light tick |
| Next / Replay | Tap | Pill buttons | 56 pt tall | Standard |
- **Tap-only alternative:** **Watch mode** (`watchMode: true`, also auto-enabled by native when `accessibility.reducedMotion` or switch control is on): a deterministic bot performs each round (`DirectBot`, `StickBot`, `StickBot+assist`) with slightly human-like imperfection while the learner only makes the reflection and classification taps. Full mastery credit for decisions; the tracking outcome is not scored.
- **Safe area / orientation:** portrait; overlays honor `runtime.safeAreaInsets`; the playfield is centered in the top 62%.
- **Not drawn by Unity:** hearts sheet, paywall, exit confirmation, XP animation (native). Unity draws only the in-sim X that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate config; build range from code; load scenario set | Ready, or `error` (`CONFIG_INVALID`, `ASSET_LOAD_FAILED`) | `ready` |
| Intro | After ready | Prompt card "Track the target. Keep the crosshair on it." (1.5 s) | Playing (round 1) | `progress 0.0` |
| Playing | Round starts | 3 s "Get ready" (target holds, then moves), then 12-15 s tracking; live ToT readout | Round timer ends | none |
| Decision | Round 2 end: reflection; round 3+ end: classification | `DecisionPoint` chips; timer at difficulty >= 4 | Choice made or timeout (wrong) | none |
| Executing | Choice made | Reveal: assist name and a gold/rose ring on the chip | 0.8 s later Freeze | none |
| Freeze | Executing done | `SlowMotion.Freeze`; dim 35%; overlay trace | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | 0.5x replay with input/reticle trace and the assist vector; card; scrubbable | Learner taps Next | `checkpoint round-N` |
| Summary | Last round explained | Score numerals; recap of the three ideas | Done | `progress 1.0` |
| Done | Summary shown | Build `SimulationResult`; send `result`; `requestExit(completed)` | End | `result`, `requestExit` |
| Paused | Native `pause` | Freeze sim time, audio, timers | `resume` -> previous state | none |
| Aborted | Native `abort` or in-sim X | Stop; result `aborted=true`, partial outcomes, `xpEarned=0` | End | `result`, `requestExit` |
Round 1 has no decision; its Explain card shows the numbers. The reflection in round 2 is `Decision` type `reflect`; rounds 3+ are `classify`.

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Target speed multiplier | 0.6 | 0.8 | 1.0 | 1.2 | 1.4 |
| Target radius `R` (vw) | 0.07 | 0.06 | 0.05 | 0.045 | 0.04 |
| Stick deadzone | 0.10 | 0.12 | 0.15 | 0.18 | 0.20 |
| Assist strength multiplier | 1.25 | 1.0 | 1.0 | 0.8 | 0.6 |
| Assist zone ring visible | yes | yes | no | no | no |
| Classification chips | 2 | 3 | 4 | 4 | 4 |
| Round tracking length (s) | 12 | 15 | 15 | 15 | 15 |
| Classification time limit (s) | none | none | none | 10 | 6 |
| Trace overlay shown before decision | yes | yes | no | no | no |
| Hints available | 2 | 2 | 1 | 0 | 0 |
| Scenario pool tags | `slow` | `slow` | `slow`,`mid` | `mid`,`fast` | all |
- **Default for `mech-02`:** difficulty 2. **`shoot-01`:** 3. Level 1 is passable by a true beginner with hints (large target, strong assist, visible zone ring, chips reduced to 2, the trace shown before deciding).

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "games.controls.aim-assist.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["aim-starter", "aim-shooter-review", "aim-all"], "default": "aim-starter" },
    "roundCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "watchMode": { "type": "boolean", "default": false, "description": "Bot performs tracking; learner only decides. Native forces true for accessibility flags." },
    "showAssistZone": { "type": ["boolean", "null"], "default": null, "description": "null uses the difficulty table." },
    "trackSeconds": { "type": ["integer", "null"], "minimum": 8, "maximum": 20, "default": null, "description": "Overrides the difficulty default when set." },
    "classificationTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 3, "maximum": 30, "default": null },
    "allowedAssists": { "type": "array", "items": { "type": "string", "enum": ["friction", "magnetism", "rotational", "lock-on"] }, "minItems": 1, "uniqueItems": true, "default": ["friction", "magnetism", "rotational", "lock-on"] }
  }
}
```
Valid example:
```json
{ "seed": 42, "scenarioSetId": "aim-starter", "roundCount": 3, "watchMode": false }
```
Invalid configuration (unknown key, out-of-range, unknown `scenarioSetId`, empty `allowedAssists`) -> `error CONFIG_INVALID` (recoverable=false).

### Model definitions (normative for the EditMode oracle)
Fixed timestep `dt = 1/60 s`. Reticle position `p` and target position `t` in vw; `e = |p - t|`.
- **Direct:** `p += g * dfinger` with `g = 1.0` (playfield vw per screen-width of finger travel), clamped to the playfield.
- **Stick:** deflection `s` in [0,1]; `d' = clamp((s - dz) / (1 - dz), 0, 1)`; commanded speed `v = vmax * d'^1.6`, `vmax = 0.9 vw/s`, direction of the stick; actual velocity is a first-order lag toward the command (time constant 0.08 s).
- **Assist variants (only with Stick), strength multiplier `k` from the difficulty table (times a default strength):**
  - *friction:* if `e < 2R`, reticle speed multiplier `m = 1 - 0.5k * (1 - e/(2R))` (minimum 0.5 at `k=1`, e=0).
  - *magnetism:* if `e < 2.5R` and `s > 0.05`, add `(t - p) * (1.2k) * dt`.
  - *rotational:* if `e < 2.5R`, add `t_velocity * (0.6k) * dt` (applies even at `s = 0`).
  - *lock-on:* on Lock tap with `e < 0.25` the lock engages; `p` eases toward `t` with rate 8/s (`p += (t - p)(1 - exp(-8dt))`); break when `s > 0.8` for 0.25 s or on a second tap.
- **Metrics:** `tot` = fraction of frames with `e <= R`; `meanErr` = mean `e`; `assistContribution(t)` = the per-frame delta added by the assist (arrow overlay).
- Target paths (`t(τ)`, τ seconds from start, phase `φ` from the seed): `strafe-slow` x = 0.32 sin(2π·0.12τ+φ), y = 0.05 (peak speed 0.24 vw/s); `orbit` circle radius 0.18 at 0.9 rad/s (speed 0.16 vw/s); `stop-and-go` x-velocity alternates 0 (0.5 s) / 0.40 (0.8 s), reflecting at ±0.38; `zigzag` x = 0.30 sin(2π·0.15τ+φ), y = 0.12 triangle(0.5 Hz) (peak ~0.28 vw/s); `strafe-burst` piecewise constant ±0.35 vw/s, direction flips at intervals drawn from [0.6, 1.4] s, reflecting at ±0.38. All scaled by the difficulty speed multiplier.
- All constants are **normative tuning values** to be confirmed by a golden generator that runs `ProportionalBot` (reaction 0.2 s, gain 4) against each scheme and path and writes reference `tot` values to fixtures; spec values are non-normative until the generator runs (same convention as F1 optimiser sims).

## 11. Scenario data set
- **Format:** `Scenarios/aim-assist-v1.json` (Addressables bundle `sim-games-aim-assist`), array of scenarios; each is a `(path, assist)` pair used for rounds 1-3 (same family and speed, seeded phase offsets for R1/R2/R3). Sets select by tag: `aim-starter` = tags `slow`; `aim-shooter-review` = `mid`,`fast`; `aim-all` = all. Deterministic per seed: the seed shuffles order within the difficulty's pool and sets phase offsets.
- **Count:** N = **12 scenarios** (>= rounds x 3 = 9 at default; 12 gives replay variety). Generation rule: pair each of the 4 assist types with 3 paths; extra scenarios may vary path parameters by +-10% while keeping the assist type (and therefore the correct answer).
- **Scenario JSON shape:**
```json
{
  "scenarioId": "aim-s01-friction-strafe-slow",
  "path": { "family": "strafe-slow", "speedMult": 1.0 },
  "assist": { "type": "friction", "strength": 1.0 },
  "expected": { "assist": "friction", "reflect": "stick-sets-speed", "conceptId": "aim-friction" },
  "tags": ["slow"]
}
```
- **Scenarios:**

| scenarioId | Setup (path / assist) | Correct classification | Teaches conceptId | Difficulty tags |
|---|---|---|---|---|
| `aim-s01-friction-strafe-slow` | strafe-slow; friction: slows the crosshair within 2R of the target | Slowdown (friction) | `aim-friction` | slow |
| `aim-s02-friction-orbit` | orbit; friction | Slowdown (friction) | `aim-friction` | slow |
| `aim-s03-friction-stop-go` | stop-and-go; friction | Slowdown (friction) | `aim-friction` | slow |
| `aim-s04-magnetism-strafe-slow` | strafe-slow; magnetism pulls toward the target while steering | Sticky pull (magnetism) | `aim-magnetism` | slow |
| `aim-s05-magnetism-zigzag` | zigzag; magnetism | Sticky pull (magnetism) | `aim-magnetism` | mid |
| `aim-s06-magnetism-strafe-burst` | strafe-burst; magnetism | Sticky pull (magnetism) | `aim-magnetism` | fast |
| `aim-s07-rotational-strafe-slow` | strafe-slow; rotational carries the crosshair with the target | Follows the target (rotational) | `rotational-assist` | slow |
| `aim-s08-rotational-orbit` | orbit; rotational | Follows the target (rotational) | `rotational-assist` | slow |
| `aim-s09-rotational-strafe-burst` | strafe-burst; rotational | Follows the target (rotational) | `rotational-assist` | fast |
| `aim-s10-lockon-strafe-burst` | strafe-burst; lock-on via the Lock button | Lock-on (not aim assist) | `lock-on-targeting` | fast |
| `aim-s11-lockon-zigzag` | zigzag; lock-on | Lock-on (not aim assist) | `lock-on-targeting` | mid |
| `aim-s12-lockon-orbit` | orbit; lock-on | Lock-on (not aim assist) | `lock-on-targeting` | slow |

First three fully specified in the JSON shape above (s01 shown; s02 = `path.family` `orbit`, expected assist `friction`; s03 = `path.family` `stop-and-go`, expected `friction`). All 12 follow the same shape with the row's values. Chip labels (native copy strings):
- Chips (max 4): "Slows you down near the target" (friction), "Pulls you toward the target" (magnetism), "Moves with the target for you" (rotational), "Locks on so you stop aiming" (lock-on). At L1-2 chips are reduced to the correct one plus distractors: L1 = 2 chips, L2 = 3.
- Reflection chips (round 2): "A stick sets speed, not position" (correct), "The target sped up" (wrong), "The screen lagged" (wrong).

## 12. Freeze / explain moments
Title <= 6 words; body <= 45 words; say-this optional. `{tot1}`, `{tot2}` are the round percentages.

| id | Trigger | Freeze frame & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-direct` | End of R1 | Trace: reticle follows finger 1:1; target ribbon shows error | Info | Direct aim: position control. | You set where the crosshair is, like a mouse. Small hand move, small crosshair move. You kept it on target {tot1}% of the time. That is why mouse players call this precise. | "A mouse sets position. That is why it feels precise." |
| `x-stick-correct` | R2 reflection correct | Two-series trace: input speed vs reticle speed (identical); ribbon error larger than R1 | Correct | Nice read. Stick sets speed. | The stick tells the crosshair how fast to move, not where to be. Chasing a moving target means constant speeding up and slowing down. You managed {tot2}%. That gap is why aim assist exists. | "A stick sets speed, not position. Tracking is harder." |
| `x-stick-wrong` | R2 reflection wrong | Same trace, rose outline on the chip | Incorrect | Not quite. Look at the trace. | The target moved the same way. What changed is the control: the stick steers speed, so you have to correct constantly. Watch the input line chase the target line. | "It's the control: a stick steers speed." |
| `x-friction-correct` | Friction, right | Vector arrows point *against* input while the reticle is near the target; speeds diverge only near the target | Correct | Nice read. Friction slows you. | Near the target the crosshair slows even though you push the same amount. That is friction: it stops you overshooting. Fans call it slowdown. | "That's friction. It slows your crosshair near a target." |
| `x-friction-wrong` | Friction, wrong | Same, rose outline | Incorrect | Not quite. The crosshair slowed. | Your input stayed the same but the crosshair moved less near the target. That is friction, also called slowdown. It helps you stop on the target instead of sliding past. | "Friction slows the crosshair near a target." |
| `x-magnet-correct` | Magnetism, right | Arrows point *toward* the target centre while input is small | Correct | Nice read. Magnetism pulls. | While you were steering, the crosshair was tugged toward the target. That sticky pull is magnetism. Fans call it sticky aim. | "That's magnetism. It pulls you toward the target." |
| `x-magnet-wrong` | Magnetism, wrong | Same | Incorrect | Not quite. It pulled you. | You did not steer that far, yet the crosshair drifted toward the target. That is magnetism, the sticky pull. Friction only slows you; it never pulls. | "Magnetism tugs the crosshair toward a target." |
| `x-rot-correct` | Rotational, right | Arrows parallel to the target's motion; reticle moves with tiny input | Correct | Nice read. It carries you along. | The crosshair kept moving with the target even when you barely moved the stick. That is rotational assist: the game adds the target's own motion for you. Controller fans argue about how strong it is. | "That's rotational assist. It follows the target." |
| `x-rot-wrong` | Rotational, wrong | Same | Incorrect | Not quite. It followed the target. | The crosshair moved with the target's motion even with almost no input. That is rotational assist, not a pull toward the middle. It matches the target's direction of travel. | "Rotational assist moves with the target." |
| `x-lock-correct` | Lock-on, right | Error line flat at zero; Lock tap marked | Correct | Nice read. Lock-on is different. | You tapped Lock and the crosshair stuck to the target. That is lock-on targeting: you stop aiming. It is not the same as aim assist, which only helps while you aim. | "Lock-on isn't aim assist. It replaces aiming." |
| `x-lock-wrong` | Lock-on, wrong | Same | Incorrect | Not quite. That was lock-on. | The crosshair followed the target because you locked on. Lock-on takes over the aiming job, while aim assist only bends your own aim. Different tools, different debates. | "Lock-on takes the aim off your hands." |
| `x-timeout` | Classification timeout | Replay loops | Timeout | Time's up. Let's look. | You ran out of time, which happens. Watch the arrows in the replay: slowing, pulling, following or locking. Each one leaves a different fingerprint. | "Slowing, pulling, following, locking: four kinds." |
| `x-summary` | End | Three-panel recap | Info | What to say next time. | A stick sets speed; a mouse sets position. Aim assist bends the stick's aim. It is designed help, and the argument is about strength. | "I get why people argue about aim assist." |
- Callout order (ART_DIRECTION): gold pulse on the deciding element, rose outline on the learner's choice if different, callouts one at a time (250 ms each), say-this last. Camera: `range-front` only.

## 13. Scoring & mastery signals
- **Round outcomes:** `round-1` (participation), `round-2` (reflection), `round-3`..`round-6` (classification). `success` = participation or correct choice.
- **Score (0-100):** `round(100 * points / roundCount)`; round points: R1 1.0 for participation (`tot >= 0.05`; watch mode counts automatically); R2 1.0 for the correct reflection; R3+ 1.0 for the correct assist, minus 0.1 per hint used (min 0.4 for correct rounds). **Tracking performance never affects the score.**
- **accuracy** = correct decisions / decisions (R2 plus classification rounds).
- **Mistake -> conceptId mapping:**

| Mistake | conceptId | Description text |
|---|---|---|
| Wrong reflection at R2 | `stick-vs-mouse` | Missed that a stick sets crosshair speed while direct aim sets position. |
| Called another assist when it was friction | `aim-friction` | Missed that the slowdown near the target is friction. |
| Called another assist when it was magnetism | `aim-magnetism` | Missed that the sticky pull toward the target is magnetism. |
| Called another assist when it was rotational | `rotational-assist` | Missed that the crosshair following the target's motion is rotational assist. |
| Called another assist when it was lock-on | `lock-on-targeting` | Missed that lock-on replaces aiming rather than assisting it. |
| Called lock-on on a passive assist | `aim-assist` | Confused a passive assist with lock-on. |
- **Mastery signals:** `event | conceptId | delta | evidence`:
  - R2 reflection correct -> `stick-vs-mouse` +0.25 "Explained why a stick is harder to track with."
  - Classification correct -> the assist's concept +0.20 "Named the assist by what it did."
  - Any assisted round completed with correct classification -> `aim-assist` +0.15 "Told designed help from lock-on."
  - Wrong -> the mistake's concept -0.15.
  - Watch mode: same deltas (decisions only) but `stick-vs-mouse` +0.15 at R2 (learner did not feel it).
  - Hints used halve positive deltas (native applies; sim reports `hintsUsed`).
  - **Per-session caps:** +0.30 and -0.30 per concept.
- **Mapping to `SimulationResult`:** `outcomes[]` one per round (`id round-N`, `success`, `label` "Round N: {scheme}", `value` = `tot` rounded to 2 dp); `mistakes[]` per wrong decision with conceptId, text from the table, `at` = active ms; `masterySignals[]`; `score`, `accuracy`, `durationMs`.

## 14. XP & hearts
- **`xpEarned` proposal:** +10 per correct decision round (native clamps to the lesson budget), +40 for finishing all rounds; aborted 0; watch mode identical.
- **`heartsLost`:** 1 if accuracy < 0.34, else 0; max 1 per session (participation alone never loses hearts).
- **`replayAvailable`:** true.

## 15. Failure states
| Situation | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Wrong decision | Explain moment with trace and "Not quite." | outcome `success=false`, mistake logged | none per round |
| Failed session (accuracy < 0.34) | "Rough set. Aim assist is confusing; that's why people argue about it." + Try again / Watch mode suggestion | `completed=true`, `heartsLost=1` | -1 |
| Learner cannot track (`tot` < 0.05 in a round) | Auto-offer "Try Watch mode?" chip after the round; round still counts as participated at 0.05 (no penalty) | outcome `success=true`, `value` low | none |
| Decision timeout | "Time's up. Let's look." + Explain | outcome false, mistake with timeout flag | none extra |
| Abort (X, native abort, backgrounded > 120 s) | Native confirmation | `aborted=true`, `abortReason`, partial outcomes, `xpEarned=0` | none |
| Asset missing | Native error sheet from `ASSET_LOAD_FAILED` | none | none |
| Invalid config | Native error; activity skipped | `error CONFIG_INVALID` | none |
Failure always ends in an explain moment or a native suggestion of `mech-02-alt`.

## 16. Accessibility
- **Reduced motion:** no camera motion exists; target speed stays (it is the content) but **watch mode auto-enables** and target motion in explain replays uses the 0.5x replay without sweeps; no shake; static rings.
- **Motor accessibility:** watch mode (bot) gives full learning value; native alternative lesson **`mech-02-alt`** (hotspot-tap, sequence-order, multiple-choice, say-this, timing-tap) is offered whenever native detects a screen reader, switch control, or the learner chooses it; no XP penalty.
- **Photosensitivity:** no flashes above 3 Hz; pulses are 1 Hz.
- **Colour-blind modes:** every colour meaning has a second channel: reticle = ring plus centre dot; target = filled disc with an outline; assist arrows = rose plus dashed line; chips show text and glyph; correct = gold ring plus check; wrong = rose ring plus X.
- **Text scale:** overlays honor `textScale` up to 2.0; chips grow and reflow.
- **Haptics:** honor `hapticsEnabled`; nothing depends on haptics.
- **VoiceOver / TalkBack:** Unity content is limited; the accessible native fallback lesson is `mech-02-alt`.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Round start | Soft "ready" tick (original synth) | light tap | 0.4 |
| On target (ToT edge, at most 2 Hz) | Faint tone | none | 0.2 |
| Lock engages | Low click | soft tap | 0.4 |
| Decision made | Soft tick | light tap | 0.4 |
| Correct | Warm two-note chime | light success | 0.5 |
| Wrong | Low soft thud | warning | 0.4 |
| Freeze | Low whoosh, pitch drop | soft tap | 0.4 |
All honor `soundEnabled` and `hapticsEnabled`. All audio is original synthesized (`original-swoond`); no game audio.

## 18. Art & asset list
| Asset | Procedural or external | Source & license | Budget | Notes |
|---|---|---|---|---|
| Range backdrop, grid | Procedural | generated, `original-swoond` | < 500 tris | on `court` colour family |
| Target disc with outline | Procedural | generated | < 200 tris | never resembles a specific game's enemy |
| Reticle ring and dot, stick base and thumb, Lock button | Procedural UI | generated | n/a | ART_DIRECTION overlay style |
| Trace chart, assist arrows, ribbons | Procedural (`TraceChart`, `Path.Draw`) | generated | n/a | dashed second channel |
| Sounds | Original synthesized | in-house, `original-swoond` | <= 300 KB | |
| Fonts | Instrument Serif and Geist TMP assets (OFL) | shared | shared | |
- **Addressables bundle:** `sim-games-aim-assist`, expected size <= 2 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps (p5 >= 50), memory < 150 MB, cold launch < 2 s to `ready`, bundle <= 25 MB (target 2 MB), draw calls <= 150 (target < 40), tris < 5k. Tighter: peak memory < 90 MB; the model update must cost < 0.3 ms per frame (pure arithmetic); no thermal rise beyond nominal/fair over 3 minutes.

## 20. Telemetry
`telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `watchMode`, `totByRound` (numbers), `decisionLatencyMsMedian`, `scenarioIds` (ids only), `difficulty`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** With seed 42, difficulty 2, `roundCount` 3 the sim emits exactly 3 `outcomes`, and the same scenarios and phase offsets in the same order on a second run.
2. **AC-2:** For every scenario the model oracle (section 10 definitions) reproduces the `expected.assist` fingerprint: friction shows `speedRatio < 0.8` within `2R`; magnetism shows a positive radial delta while `s > 0.05`; rotational shows a delta parallel to target velocity at `s = 0`; lock-on reaches `e <= 0.01 vw` within 0.6 s of engagement.
3. **AC-3:** With `ProportionalBot` (reaction 0.2 s, gain 4) mean `tot` satisfies Direct > Stick and Stick + assist >= Stick for every scenario (EditMode golden test; fixture written by the generator).
4. **AC-4:** `ready` is emitted in < 2 s after `launch`.
5. **AC-5:** The `result` validates against `simulation-result.schema.json`; `simulationId` and version match; exactly one `result` is sent; `requestExit` follows.
6. **AC-6:** All copy strings satisfy: title <= 6 words, body <= 45 words.
7. **AC-7:** Every explain moment has correct and incorrect variants (`x-direct`, `x-summary` and `x-timeout` excepted).
8. **AC-8:** `pause` freezes round timers and the target; `resume` continues; paused time excluded from `durationMs`.
9. **AC-9:** `abort` yields `aborted=true`, matching `abortReason`, `xpEarned=0`.
10. **AC-10:** With `reducedMotion=true`, watch mode is on and no camera or UI sweep occurs.
11. **AC-11:** With `colorBlindMode` set, every colour-coded element has its second channel (visual snapshot test).
12. **AC-12:** `watchMode: true` completes a session with tap-only input (chips only).
13. **AC-13:** Invalid configuration (unknown key, `roundCount` 2, empty `allowedAssists`) yields `error CONFIG_INVALID`.
14. **AC-14:** 60 fps p5 >= 50 fps and peak memory < 90 MB on iPhone 13-class over a 3-round run.
15. **AC-15:** Mastery signals respect the +-0.30 per-concept per-session caps; tracking performance never changes `score`.
16. **AC-16:** No chip label contains the assist's giveaway word ("friction", "magnetism", "rotational") before the Explain state.

## 22. Test plan
- **EditMode:** `ReticleAim` model oracle, config validation against the schema, result schema validity, scoring maths, determinism by seed, copy-length lint, `ProportionalBot` golden fixtures.
- **PlayMode:** scene builds from code; full scripted run via a test `TouchController` (Direct drag, stick, Lock tap); freeze/explain sequence; pause/resume/abort; watch mode; reduced-motion path; colour-blind snapshot.
- **Perf:** measured 3-round run on iPhone 13-class.

| AC id | Test type | Test name |
|---|---|---|
| AC-1 | EditMode | `SeedDeterminism_Aim` |
| AC-2 | EditMode | `AssistFingerprint_AllScenarios` |
| AC-3 | EditMode | `Bot_Ordering_Golden` |
| AC-4 | PlayMode | `ColdLaunch_Under2s` |
| AC-5 | EditMode | `Result_SchemaValid` |
| AC-6, AC-7 | EditMode | `Copy_Lint` |
| AC-8, AC-9 | PlayMode | `Pause_Resume`, `Abort_Result` |
| AC-10 | PlayMode | `ReducedMotion_WatchMode` |
| AC-11 | PlayMode | `ColorBlind_SecondChannel` |
| AC-12 | PlayMode | `WatchMode_TapOnly` |
| AC-13 | EditMode | `Config_Invalid` |
| AC-14 | Perf | `Perf_iPhone13` |
| AC-15 | EditMode | `Mastery_Caps`, `Score_IgnoresTracking` |
| AC-16 | EditMode | `Chips_NoGiveaway` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Playtest vs `mech-02-alt` (20+ novices, one-week concept check, 8-point lead) before approval; downgrade to native if it fails. | Product / Claude | Yes (approval) |
| 2 | Confirm normative constants (`vmax`, curve exponent, assist strengths) with the golden generator and a quick human feel-pass; tune so R2 is clearly harder than R1 for a novice. | Astra | No |
| 3 | Is `drag-relative` acceptable as a new `TouchController` scheme or should it be `slot-placement`-style? | Astra | No |
| 4 | Reuse `maintain_proximity` (screen-space variant) instead of adding `track_target`? Prefer adding `track_target` as an alias. | Astra | No |
| 5 | Audio: synthesized cues or a tiny commissioned set? | Product | No |
| 6 | Real controller support on iOS (GameController framework) as an optional input for players who have one; out of scope for v1. | Product | No |

### Game Kit additions requested
- **`Swoond.Controls` module** (new): `ReticleAim` pure functions and variants `Direct`, `RateStick` (deadzone, response curve, ramp), `AimAssist.{Friction, Magnetism, Rotational, LockOn}`; used by the EditMode oracle and the runtime. Reusable by a steering-assist racing sim and other input-mapping lessons.
- **Objective `track_target` / `TrackingObjective`** (time-on-target, mean error, per-frame error series); reusable for camera-tracking, golf and cycling line-following.
- **TouchController scheme `drag-relative`** (relative delta drag with gain). `virtual-stick` already exists.
- **Environment key `aim_range`** (procedural).
- Reuse (no new request): `Target`, `Path`, `Highlight`, `DecisionPoint` chips (GK-3), `TraceChart` `speed_trace` and `value_ribbon` (GK-16; two-series variant requested if not already covered), `Replay`, `SlowMotion`, `Hint`, `Score`.
