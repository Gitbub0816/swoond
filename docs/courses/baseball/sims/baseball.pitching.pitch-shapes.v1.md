# Reading the Pitch (`baseball.pitching.pitch-shapes.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `baseball.pitching.pitch-shapes.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (flight model is code; scenarios are data) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `baseball`; `unitId` `pitching` (lesson `pit-03`); optionally reused in `modern-rules` (lesson `mod-04`, `zone` scenarios, difficulty 3).
- CDS row: section 12, "`pit-03`: Reading the pitch". Manifest: `unitySimulations[2]`.
- Prerequisite concepts (or the native primer `pit-01`/`pit-02` first): `four-seam-fastball`, `slider`, `curveball`, `velocity`, `strike-zone`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can tell a fastball from a slider, a curveball and a changeup by how it flies, and you can see why a pitch is a strike or a ball for the batter's height."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `pitch-movement` | Pitch movement | Describe break as gravity plus spin, not magic. |
| `tunneling` | Tunneling | Say two pitches look the same for the first 20 feet, then part ways. |
| `velocity` | Velocity | See a 10 mph gap as the changeup's whole job. |
| `changeup` | Changeup | Recognise the slower speed and arm-side fade. |
| `splitter` | Splitter | Recognise the late drop with low spin. |
| `pitch-mix` | Pitch mix | Know pitchers use a mix to keep hitters guessing. |
| `abs-zone` | ABS zone | See the zone as a box scaled to the batter's height (about 27 percent to 53.5 percent of height) [verify at release]. |
| `abs-challenge` | ABS challenge | Decide when to challenge within two seconds. |

- **Out of scope:** grips, mechanics, sabermetric pitch values, pitch design, sign stealing.

## 4. Why Unity (tier justification)
- **Signals:** *physics* (gravity, spin-induced movement, drag), *camera perspective* (the batter's-eye and catcher's views are what make pitches deceptive), *movement over time* (early flight versus late break).
- **Closest native:** `visual-id` on original pitch art and `multiple-choice` ("which pitch drops most?"). They teach names and typical shapes; they cannot show that a slider and a fastball are indistinguishable until about 20 feet from the plate, or a strike-zone box growing with the batter's height.
- **Fallback:** native lesson `pit-03-native`: 3 `visual-id` items (side-on flight arcs), 2 `estimate-slider` (velocity difference, drop in inches), 2 `hotspot-tap` (tap the strike-zone box for a tall vs short batter).
- Justification: strong for the flight concept; weaker for the ABS challenge alone (open question 1).

## 5. Player fantasy & core loop
- **Fantasy:** "You are the hitter with 0.4 seconds to read what is coming and, if you are the catcher, one shot to challenge a call."
- **One mechanic: read the flight, make one call.** Scenario kind `type`: name the pitch. Scenario kind `zone`: keep the call or challenge it.
- **Loop:**
  1. Intro card (count, batter, pitcher, maybe the previous pitch).
  2. Pitch released from the `batter-eye` (kind `type`) or `catcher-cam` (kind `zone`) camera; the ball is visible to the tunnel point, about 24 ft before the plate.
  3. **Decision:** (`type`) tap the pitch name; (`zone`) tap Keep or Challenge within the window.
  4. Reveal: the flight completes in slow motion; break is drawn against a gravity-only ghost path; zone box and pitch dot appear (zone kind).
  5. Freeze/explain with title, body and say-this.
- **Session length:** about 3 minutes, 3 rounds (mixed set: two `type`, one `zone`).

## 6. Scene & entities
- **Environment:** `baseball_field` (mound, plate, batter's box only; the rest is dimmed), cameras `batter-eye`, `catcher-cam`, `side-on` (explain), `orbit` (replay).
- **Coordinates:** feet; origin home plate; y toward the mound; release point about 54 ft from the plate (60.5 ft rubber minus extension 6.5 ft), height 5.8 ft (per scenario); x positive toward first base. Plate width 17 in.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `pitcher` | `Character` | Delivers the pitch (animation only) | throwing hand |
| `batter` | `Character` | Height matters in `zone` kind | height in inches (e.g. 66, 72, 78) |
| `ball` | `Ball` with `PitchFlight` (new) | The pitch | release speed (mph), spin cue, induced vertical break (in), horizontal break (in, arm-side positive), release point |
| `gravityGhost` | `Ball` (ghost) | Same release and speed with no spin; shows what gravity alone does | dashed |
| `tunnel` | `Zone` | Marker at 23.8 ft from the plate (tunnel point) | hatched |
| `zoneBox` | `StrikeZoneOverlay` (new) | ABS zone rectangle scaled to the batter | bottom 0.27 h, top 0.535 h, width 17 in (plus ball radius 1.45 in) |
| `chips` | `Target` x4 to x8 | Pitch names (kind `type`) | 56 pt tall |
| `keep`, `challenge` | `Target` x2 | Kind `zone` choices | 64 pt |
| `window` | `SlowMotion.Window(realSeconds)` (GK-4) | Timed decision (zone: 2 s) | |
| `breakPlot` | `TraceChart` (GK-16) | Break versus a fastball baseline in inches | |
| `explain`, `score`, `hints`, `replay`, `highlight` | as kit | | |

- **New primitives:** `PitchFlight` (Ball flight from release speed, spin-induced acceleration `a` such that displacement at the plate equals the scenario's induced vertical break and horizontal break, gravity, mild drag to plate time = 54 ft / (0.92 x speed)); `StrikeZoneOverlay` (batter-height ABS frame). Both are baseball-only and reusable for softball; `PitchFlight` is a specialization of GK-7 (`Ball.Throw` `Swing`).
- **Typical arsenal used by the scenario generator** (teaching averages; not player data [verify against Baseball Savant pitch-arsenal averages for 2026 before approving]):

| Pitch | Speed (mph) | Spin (rpm) | Induced vertical break (in) | Horizontal break (in; arm-side +) | Cue |
|---|---|---|---|---|---|
| Four-seam | 94 | 2300 | +16 | +8 | Ball looks like a clean disc; "rises" (falls less than gravity) |
| Sinker | 93 | 2150 | +8 | +15 | Runs arm-side and drops |
| Cutter | 89 | 2400 | +10 | -2 | Tiny glove-side move late |
| Slider | 86 | 2450 | +2 | -6 | Dot on the ball; late glove-side bite |
| Sweeper | 84 | 2500 | 0 | -15 | Wide glove-side sweep |
| Curveball | 80 | 2600 | -10 | -6 | Topspin stripes; big drop |
| Changeup | 85 | 1800 | +7 | +14 | Same arm speed, slower ball, arm-side fade |
| Splitter | 87 | 1400 | +3 | +9 | Late drop, low spin |

- **Layout (side view):**
```
 release 54 ft ------- tunnel 23.8 ft ---- plate
    o------------------.....--------------|  (all pitches look alike to here)
                       then they separate
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Name the pitch | Tap | Pitch chip | >= 56 x 90 pt | Selected gets `accent` outline |
| Keep / Challenge | Tap | Two pills | >= 64 x 110 pt | Selected outlined; Challenge shows a helmet-tap icon |
| Hint | Tap chip | Shows speed readout and spin cue | 44 pt | Highlight |
| Watch again | Tap | Explain card | 44 pt | Orbit replay |
- **Tap-only:** yes; no drags. Portrait; chips in the bottom 30 percent.
- **Not in Unity:** hearts, paywall, exit confirmation.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config; build field, ball, overlays; load scenarios | Ready/error | `ready` |
| Intro | ready | Scenario card 1.5 s | Playing | `progress` |
| Playing | intro | Pitch released; visible to the tunnel point (kind `type`), or full flight (kind `zone`) | Decision | none |
| Decision | tunnel reached (`type`) or ball crosses (`zone`) | Time slows; chips; window; hints | Reveal | none |
| Reveal | choice made | Flight completes in slow motion; ghost path; zone box and dot (`zone`) | Freeze | none |
| Freeze | reveal done | Freeze on `side-on`; break plot; callouts | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card; "Watch again" orbit | Next/Summary | `checkpoint round-N` |
| Summary | last round | Score, mistakes | Done | `progress 1.0` |
| Done | summary | `result` then `requestExit` | end | `result`, `requestExit` |
| Paused/Aborted | native | Freeze; partial `result` `xpEarned 0` | | `result`, `requestExit` |

**Flight model (reference, deterministic):** position at time `t` (0 to `T`): `p(t) = release + v0_avg * t along y + 0.5 * (g + a_spin) * t^2` where `g = -32.17 ft/s^2` and `a_spin` is chosen so that at `T` the displacement from the gravity-only path is exactly (`hb`, `ivb`) in inches. `T` = `54 / (0.92 * v0 * 1.4667)` seconds (about 0.42 s at 94 mph, 0.50 s at 80 mph).

**ABS zone rule (simplified, for the `zone` kind):** strike if any part of the ball (radius 1.45 in) overlaps the rectangle: x within +-8.5 in of plate center, z between `0.27 h` and `0.535 h` at the plate's midpoint depth (8.5 in from the front) [verify at release; the 2026 system uses a batter-height-based zone and a two-dimensional plane].

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| `type` chips | 3 (fastball, breaking ball, changeup) | 4 (four-seam, slider, curveball, changeup) | 5 (+ sinker) | 8 | 8 |
| Speed readout during flight | shown | shown | shown | hidden | hidden |
| Spin cue on ball | large | large | small | small | none |
| Zone frame visible before the call (`zone`) | yes | yes | no | no | no |
| Decision window (s, real) | none | none | 4 (`type`) / 3 (`zone`) | 3 / 2 | 2 / 2 |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Scenario pool | `ps-easy` | `ps-easy` | + `ps-mix` | + `ps-hard` | all |
- Default for `pit-03`: 2. Level 1 is passable by a beginner: three chips with the speed readout and cue, and the zone frame shown.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "baseball.pitching.pitch-shapes.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["ps-types", "ps-zone", "ps-mixed"], "default": "ps-mixed" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "showSpeedReadout": { "type": ["boolean", "null"], "default": null },
    "showZoneFrame": { "type": ["boolean", "null"], "default": null },
    "decisionWindowSeconds": { "type": ["number", "null"], "minimum": 1, "maximum": 20, "default": null },
    "throwingHand": { "type": "string", "enum": ["R", "L", "mixed"], "default": "mixed" }
  }
}
```
Valid example: `{ "seed": 3, "scenarioSetId": "ps-mixed", "scenarioCount": 3 }`. Invalid configuration yields `CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/pitch-shapes-v1.json` (bundle `sim-baseball-pitch-shapes`). Deterministic per seed (pool order, hand mirroring).
- **N = 12 scenarios** (8 kind `type`, 4 kind `zone`). Shape:
```json
{ "scenarioId": "ps-s01", "kind": "type", "pitch": "four-seam", "speedMph": 95, "ivbIn": 17, "hbIn": 8,
  "release": { "x": -1.8, "z": 5.9, "yFromPlate": 54 }, "hand": "R", "count": "1-1",
  "options": ["four-seam", "slider", "curveball", "changeup"], "best": "four-seam", "acceptable": [], "poor": ["slider", "curveball", "changeup"],
  "teaches": ["pitch-movement", "velocity"], "tags": ["ps-easy"] }
```
- **Scenarios:**

| scenarioId | Kind | Pitch data / setup | best (acceptable) | Teaches | Tags |
|---|---|---|---|---|---|
| `ps-s01` | type | Four-seam 95 mph, IVB +17, HB +8, 1-1 count | Four-seam (none) | `pitch-movement`, `velocity` | ps-easy |
| `ps-s02` | type | Curveball 79 mph, IVB -11, HB -6, 0-2 count; big drop from the release arc | Curveball | `pitch-movement` | ps-easy |
| `ps-s03` | type | Changeup 84 mph after a 95 mph fastball on the previous pitch; IVB +7, HB +14 | Changeup | `changeup`, `tunneling`, `velocity` | ps-easy |
| `ps-s04` | type | Slider 86 mph, IVB +2, HB -6 with a dot on the ball; late glove-side bite | Slider | `pitch-movement`, `pitch-mix` | ps-mix |
| `ps-s05` | type | Sweeper 84 mph, IVB 0, HB -16; wide arc | Slider (acceptable: name it "sweeper" at L4-5 only) | `pitch-movement` | ps-hard |
| `ps-s06` | type | Sinker 93 mph, IVB +7, HB +16 (runs arm-side) | Sinker (four-seam poor: less drop than gravity-only says) | `pitch-movement` | ps-mix |
| `ps-s07` | type | Cutter 90 mph, IVB +10, HB -2 (small late move) | Cutter (slider acceptable) | `pitch-mix` | ps-hard |
| `ps-s08` | type | Splitter 87 mph, IVB +3, HB +9, late drop, low spin | Splitter (changeup acceptable) | `splitter` | ps-hard |
| `ps-s09` | zone | Batter 66 in tall; pitch center at x 0 in, z 37.6 in; called ball; 3-2 count (keep) | Keep | `abs-zone`, `strike-zone` | ps-mix |
| `ps-s10` | zone | Batter 78 in tall; pitch center x 0, z 42.6 in; called ball; zone top 41.7 in (challenge) | Challenge | `abs-zone`, `abs-challenge` | ps-mix |
| `ps-s11` | zone | Batter 72 in tall; pitch center x 6.0 in, z 30 in; called strike (keep) | Keep | `abs-zone` | ps-easy |
| `ps-s12` | zone | Batter 72 in tall; pitch center x 0, z 17.0 in; called strike; zone bottom 19.4 in (challenge) | Challenge | `abs-challenge`, `abs-zone` | ps-hard |

- The first three (`ps-s01` to `ps-s03`) are fully specified above (JSON for `ps-s01`; parameters and copy for the others). Others follow the same shape; for `zone` scenarios `batterHeightIn`, `pitchXIn`, `pitchZIn`, `umpireCall` and `count` replace the pitch fields and the oracle is the ABS rule above (checked in an EditMode test with 20 fixtures).
- **Generation rule:** pick a pitch from the arsenal table, add noise +-1 mph, +-1 in break (seeded), choose `options` by difficulty, `best` is the true type; for `zone`, choose `pitchZIn` at `0.535 h` or `0.27 h` +-(1 to 3 in) and `umpireCall` at random; `best` is Challenge when the call disagrees with the ABS rule by at least 1 in.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|---|
| `x-type-good-fb` | Four-seam named correctly | Break plot: +17 in vs gravity ghost | Correct | Nice read. Rides high. | It fell far less than gravity alone would drop it. Hitters call that "rise," but it is spin fighting gravity. Fast and straight is the fastball. | "That fastball had rise on it." |
| `x-type-good-ch` | Changeup named correctly | Speed gap 95 vs 84; tunnel marker | Correct | Nice read. Same look, slower. | For the first 24 feet it looked just like the fastball, then it slowed and faded. A 10 mph gap is the changeup's whole job. | "Great changeup; he had no idea it was slow." |
| `x-type-good-cu` | Curveball named correctly | Drop -11 in; topspin stripes | Correct | Nice read. Big drop. | Topspin pulled the ball down harder than gravity. The break is late, which is why hitters chase it. | "He buried that curveball." |
| `x-type-slider-curve` | Slider vs curveball confusion | Two break plots side by side | Incorrect | Not quite. Slider bites sideways. | A slider breaks sideways and only a little down at higher speed; a curveball drops big and slower. Look at the direction of the break. | "Slider is sideways, curve is down." |
| `x-type-fb-sinker` | Four-seam vs sinker confusion | Break plot with arm-side run | Incorrect | Not quite. That one ran. | A sinker runs toward the arm side and drops; a four-seamer stays on line and holds its height. The horizontal run gives it away. | "That was a sinker, it ran in on him." |
| `x-type-fb-ch` | Changeup called a fastball | Speed readout and tunnel marker | Incorrect | Not quite. Look at the speed. | It looked like a fastball until the last few feet. The tell is the speed: about 10 mph slower. Pitchers build a hitter's timing, then break it. | "That was a changeup, the speed gave it away." |
| `x-zone-keep-good` | Keep when the call was correct | Zone box scaled to the batter; dot outside | Correct | Nice read. Call stood. | The pitch missed the zone for this batter: the box is scaled to his height. Keeping saves the challenge for a better moment. | "Good call to hold the challenge." |
| `x-zone-challenge-good` | Challenge when the call was wrong | Dot inside the box | Correct | Nice read. Overturned. | The ball touched the zone by {gap} inches. A challenge costs nothing if you win; a batter's height changes the box. | "Challenge, it clipped the zone." |
| `x-zone-challenge-bad` | Challenge on a correct call | Dot far outside | Incorrect | Not quite. Call was right. | It missed by {gap} inches. A lost challenge is gone for the game. Save it for close calls with real stakes. | "It was too far off to challenge." |
| `x-zone-keep-bad` | Keep when a challenge would win | Dot inside box | Incorrect | Not quite. Missed a win. | It was a strike by {gap} inches. With a two-second window you must decide fast; close calls near the box edge are the ones to challenge. | "I should have challenged that." |
| `x-timeout` | Window expired | Result shown | Timeout | Time's up. Let's look. | You have two seconds to challenge in a real game. Look at the box, then the ball; decide quickly. | "You've only got two seconds." |

## 13. Scoring & mastery signals
- **Round points (0..1):** `decisionScore` (best 1.0, acceptable 0.6, poor 0.0) times `windowFactor` (1.0 inside the window; 0.5 on timeout).
- **accuracy** = rounds with `decisionScore >= 0.6` divided by rounds. **Outcome id** `round-N`, success if points >= 0.6, `label` = chosen pitch or `keep`/`challenge`.
- **Mistake -> conceptId:**

| Mistake | conceptId | Description |
|---|---|---|
| Slider vs curveball | `pitch-movement` | Confused sideways break with a big drop. |
| Changeup named fastball | `velocity` | Missed the speed gap. |
| Missed tunnel | `tunneling` | Did not notice the pitches look alike early. |
| Sinker vs four-seam | `pitch-movement` | Missed arm-side run. |
| Challenge a correct call | `abs-challenge` | Spent a challenge on a clear call. |
| Keep a wrong call | `abs-zone` | Did not judge the zone for this batter's height. |
- **Mastery signals:** correct `type` -> `pitch-movement` +0.15; changeup correct -> `changeup` +0.20 and `velocity` +0.10; correct after seeing the previous pitch -> `tunneling` +0.15; correct splitter -> `splitter` +0.20; correct `zone` decision -> `abs-zone` +0.20 and `abs-challenge` +0.15; correct pitch mix awareness (any two different types correct) -> `pitch-mix` +0.10; mistakes -0.15; per-concept per-session cap +-0.30; hints halve positives.
- **Result mapping:** `outcomes[]`, `mistakes[]`, `masterySignals[]`, `score` 0-100 = mean(points) x 100.

## 14. XP & hearts
+10 per successful round, +40 finishing; native clamps. `heartsLost` 1 if accuracy < 0.34, max 1. `replayAvailable` true.

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain with break plot | success false, mistake | none |
| Failed session | "Pitches are hard to read. That is the point. Watch the ghost once more." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Reveal then explain (points x 0.5) | `timeout` label | none |
| Abort/backgrounded | Native; partial result | `aborted`, `xpEarned 0` | none |
| Asset/config error | Native error sheet | `error` | none |

## 16. Accessibility
- **Reduced motion:** no camera orbit (cuts between `batter-eye`, `side-on`, `catcher-cam`); slow-motion replay replaced by a step-through of five stills along the path.
- **Haptics:** honor `hapticsEnabled`. **Color-blind:** pitches encoded by line style (solid/dashed/dotted) plus label; zone box outlined with a pattern; the gravity ghost is dashed and labelled.
- **Text scale:** honored. **Tap-only:** yes.
- **VoiceOver/TalkBack:** limited in Unity; native fallback `pit-03-native` (visual-id and estimate-slider items with full text alternatives).

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Release | Soft whoosh | none |
| Pitch arrives | Glove pop (louder for faster pitches) | soft tap |
| Choose | Soft tick | soft tap |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
| Challenge overturned | Rising two-note chime | light success |

## 18. Art & asset list
| Asset | Procedural or external | License | Budget |
|---|---|---|---|
| Mound, plate, batter's box | Procedural | `original-swoond` | < 1.5k tris |
| Pitcher, batter (three heights), catcher | Procedural capsule figures | `original-swoond` | < 2.5k tris each |
| Ball with seam/dot cue texture | Procedural (small tileable pattern) | `original-swoond` | 1 texture <= 256 KB |
| Zone box, tunnel marker, break plot | Unity UI / lines | `original-swoond` | n/a |
| Audio | Synthesised | `original-swoond` | <= 1 MB |
Addressables bundle `sim-baseball-pitch-shapes`, <= 5 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md`; tighter: memory < 110 MB; cold launch < 2 s; slow-motion at 60 fps (no 30 fps replays).

## 20. Telemetry
Standard diagnostics plus `hintsUsed`, `decisionLatencyMsMedian`, `challengeCount`, `keepCount`, `typeAccuracyByPitch`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 3, difficulty 2, 3 rounds: exactly 3 `outcomes`, identical across runs.
2. **AC-2:** `PitchFlight` reproduces each scenario's IVB and HB at the plate within 0.5 in and the plate time within 0.01 s.
3. **AC-3:** For 20 fixtures the ABS zone oracle returns the expected strike/ball (including plate edge, ball radius, height scaling).
4. **AC-4:** `ready` within 2 s; exactly one schema-valid `result`; `requestExit` follows.
5. **AC-5:** Pause freezes physics and timers; abort yields `aborted=true`, `xpEarned=0`.
6. **AC-6:** Explain copy: title <= 6 words and body <= 45 words after placeholder substitution.
7. **AC-7:** Reduced-motion path has no orbit sweeps; a tap-only run completes.
8. **AC-8:** Invalid configuration yields `CONFIG_INVALID`.
9. **AC-9:** Perf p5 >= 50 fps and memory < 110 MB on iPhone 13-class.
10. **AC-10:** Mastery signals capped at +-0.30 per concept per session.
11. **AC-11:** The gravity ghost path equals the model with `ivb = hb = 0` for every scenario.

## 22. Test plan
- **EditMode:** `PitchFlight` math, ABS zone oracle, generation rule, scoring, config validation, determinism, copy lint, result schema.
- **PlayMode:** scene builds from code, tap-only full run, freeze/explain, pause/abort, reduced motion.
- **Perf:** iPhone 13-class.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_PitchShapes` |
| AC-2, AC-11 | EditMode | `PitchFlight_Fixture`, `Gravity_Ghost` |
| AC-3 | EditMode | `Abs_Zone_Oracle` |
| AC-4, AC-5 | PlayMode | `Launch_Result`, `Pause_Abort` |
| AC-6 | EditMode | `Copy_Lint` |
| AC-7 | PlayMode | `ReducedMotion_TapOnly` |
| AC-8 | EditMode | `Config_Invalid` |
| AC-9 | Perf | `Perf_iPhone13` |
| AC-10 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is the `zone` kind worth keeping in this sim, or should ABS stay native (`hotspot-tap` + `binary-call` in `mod-04`, `mod-05`) and this sim be types-only? Playtest. | Claude / Product | No |
| 2 | Add `PitchFlight` and `StrikeZoneOverlay` (baseball-only) and the camera presets `batter-eye`, `catcher-cam`, `orbit`. | Astra | Yes |
| 3 | SME check of the typical-arsenal averages and the simplified ABS rule (plane depth, ball-radius overlap, height measurement rules) against the 2026 MLB ABS documentation. | Product / SME | Yes for `spec-approved` |
| 4 | Confirm whether the catcher can challenge in the same way as the batter and pitcher for the simulated fantasy (2026 rule: batter, pitcher, catcher; not managers) [verify]. | Content | No |

### Game Kit additions requested
- `PitchFlight` (specialization of GK-7 `Ball.Throw` `Swing`: spin-induced acceleration, drag, plate-time), `StrikeZoneOverlay`, camera presets `batter-eye`, `catcher-cam`, `orbit` (extending GK-19), `TraceChart` break-plot style (GK-16), `SlowMotion.Window` (GK-4).
- `BaseballField` module (shared with the other two baseball sims).
