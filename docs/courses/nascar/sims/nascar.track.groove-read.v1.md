# Find the Groove (`nascar.track.groove-read.v1`)

## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `nascar.track.groove-read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven: definition file `nascar.track.groove-read.v1.definition.json` composed from Game Kit primitives) |
| Authors / date | Swoon'd curriculum design (Claude) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `nascar`; `unitId`: `tracks-air`; `lessonId`: `tracks-05` (also usable as a review activity from `perpetual-review`).
- CDS row: `docs/courses/nascar/CDS.md` section 12, row "Banking, grooves and rubber (sim)".
- Manifest entry: `docs/courses/nascar/manifest.json` -> `unitySimulations[]` (simulationId `nascar.track.groove-read.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `track-types`, `short-track`, `intermediate-track`, `superspeedway` (from `tracks-01..03`).

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can look at a track's banking, rubber and traffic and say which lane a driver wants, and why it is not always the shortest way around.

| conceptId | term | After the sim the learner can... |
|---|---|---|
| racing-groove | Groove (racing line) | Name low, middle and high grooves and choose one for the situation. |
| banking | Banking | Explain that steep banking lets higher, longer lanes be fast. |
| rubbering-in | Rubbering in | Explain that laid-down rubber can move the fast groove during a race. |
| flat-track | Flat track | Explain that on flat tracks the short way around wins. |
| dirty-air | Dirty air | See that following a car in your groove costs speed, so leaving its lane can pay. |

**Out of scope:** Exact lap times, real track-specific groove knowledge beyond the stylized scenarios, tire compounds and weather. Lap times are relative; only deltas are shown.

## 4. Why Unity (tier justification)
**Rubric answer.** Spatial reasoning and camera perspective are the concept: banking, rubber marks and lane length are properties of the track surface that only make sense as a shape you can see from above and from behind the car. The learner reads a top-down overlay (angle, dark rubber strips, a car ahead) and then watches three ghost cars run the same laps in different lanes, so "the fastest lane" is discovered through movement over time, not asserted.

**Closest native type and why it teaches worse:** `hotspot-tap` on a static track diagram can ask "tap the fast groove" and is used in `tracks-05` alongside the sim for recognition. It cannot show three lanes racing each other, the lap-time delta accumulating, or how rubber and banking trade off against path length. `visual-id` of track types (native, `tracks-10`) teaches shape recognition, not why lanes matter.

## 5. Player fantasy & core loop
**Fantasy:** You are the driver stepping onto a track for the first time in a race: where do you put the car?

1. **Prompt:** banner "Which lane is fastest right now?"
2. **Read:** a slow top-down flyover shows the banking angle, rubber (dark strips) and any car ahead.
3. **One decisive interaction:** tap Low, Middle or High before the timer (if any) ends.
4. **Execute:** your car and two ghost cars run two laps at 8x, one in each lane; lap-time deltas tick.
5. **Freeze / explain:** freeze at the line with three times; callouts explain the winner; **a line you could say out loud:** "He ran the high groove because the rubber was up there."

**Session length:** about 3 minutes, 3 rounds (default). Maximum 240 s of play; `runtime.maxDurationMs` from native is authoritative.

## 6. Scene & entities
- **Environment (registry key):** `oval_intermediate` (plus `oval_short_banked` and `oval_flat` variants; superspeedway scenario uses `oval_superspeedway`)
- **Camera presets:** `top-down` for the flyover and Decision, `chase-high` for the run (blend 0.4 s), `broadcast-side` for the Freeze. Reduced motion: cuts only.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| player_car | `Vehicle` | player | runs `RacingLine` in the chosen lane; number 12 (rose ring) |
| ghost_low, ghost_mid, ghost_high | `Vehicle` (translucent) | comparison | one per lane; the learner's lane is the player car; the other two are ghosts with a gray dotted ring |
| track | `Track` + `RacingLine` | world | three lane splines (low, middle, high) with length factors 1.000 / 1.012 / 1.024; banking angle label |
| rubber_overlay | `Zone` heat overlay (dark strips) | overlay | intensity by scenario `rubber[]` 0..1 |
| lead_car | `Vehicle` | event (optional) | car ahead in one lane; dirty-air cone drawn behind it |
| lane_bands | `Zone` + `Target` x3 | selectable | tap bands across the track cross-section |
| timing_board | `Timing` | overlay | three lap-time deltas in Display S serif after Execute |
| replay | `Replay` | review | records the two laps; slow-mo 0.5x from `top-down` |

**Reused primitives:** `Vehicle`, `Track`, `RacingLine`, `Path`, `Zone`, `Target`, `DecisionPoint`, `Timing`, `Highlight`, `Explanation`, `Score`, `Replay`, `SlowMotion`, `CameraRig`, `Hint`, `TouchController`.

**New / extended primitives:** `RubberMap` (Track overlay data: 0..1 per lane, drawn as dark strips; reusable for F1 rubbering-in and cycling road surface). Environment keys `oval_short_banked`, `oval_flat`.

```
  banking 26 degrees  (label)          wall
  high   |==========================|
  middle |=====  rubber strip  =====|   <- dark strip = rubber
  low    |==========================|
  [ LOW ]  [ MIDDLE ]  [ HIGH ]   tap a lane
  ghosts: three cars run two laps; times: low +0.85 s | mid 0.00 | high +0.17
```

## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Choose lane | Tap Low, Middle or High band on the track cross-section | >= 88 x 200 pt each | Band fills rose; camera blends to chase-high |
| Inspect | Tap a strip or car to read rubber % or gap | >= 44 pt | Popover 2 s (free) |
| Hint | Tap Hint pill | 44 pt | Colors bands by speed (heat overlay) for 3 s (counts as a hint) |
| Pause | Top-right icon | 44 x 44 pt | Requests pause from native |

- **Accessible tap-only scheme (`ControlScheme.TapOnly`):** Three pill buttons (`Low`, `Middle`, `High`, 56 pt) replace band taps; inspect opens a list of facts (banking angle, rubber per lane, car ahead) instead of popovers.
- **Safe area & orientation:** portrait. All controls sit inside `runtime.safeAreaInsets` plus 16 pt; the bottom 88 pt is reserved for the primary control so it never collides with the home indicator.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation, XP totals, streaks and lesson navigation (native). Unity draws only the in-scene HUD and overlays.

## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit / bridge events |
|---|---|---|---|
| Loading | `launch` received and validated | Build world from code, load scenario set, verify `configuration`; on failure emit `error CONFIG_INVALID` / `ASSET_LOAD_FAILED` | World ready -> emit `ready` -> Intro |
| Intro | After `ready` | `top-down` flyover 3 s; banner "Read the track before you choose." | Tap Start (or auto after 6 s) -> Playing |
| Playing | Round begins | Flyover continues (loopable) with labels; inspection available; countdown if limited | Decision trigger -> Decision; time limit -> Freeze (timeout outcome). Emits `progress` (max 4/s) |
| Decision | Decision trigger reached | Time at 0.25x; lane bands active; timer ring if limited | Choice made or time limit -> Executing. Emits `checkpoint` `round-<n>-decision` |
| Executing | Choice locked | Three cars run two laps at 8x; lap-time deltas accumulate; the learner's lane is marked with a rose ring | Outcome resolved -> Freeze |
| Freeze | Outcome resolved | `SlowMotion.Freeze` (250 ms ease; hard cut in reduced motion); dim non-focal entities 35%; gold pulse on the correct element then rose outline on the learner's choice if different | After highlight sequence -> Explain |
| Explain | Freeze complete | `Explanation.Present` correct or incorrect copy (section 12); learner taps Continue; optional Replay at 0.25x-0.5x (`Replay.Play`) | Continue -> next round (Playing) or Summary after round 3 |
| Summary | All rounds done | Result beat: score numerals count up 600 ms; per-round outcome chips; one "say this" line from the best moment | Tap Done -> Done. Emits `result` then `requestExit` |
| Done | After `result` sent | Unity idle; awaits native unload | Native unloads Unity |
| Paused | `pause` command or app backgrounded | Time scale 0, audio ducked, input disabled, timers frozen (no timeout while paused) | `resume` -> restores previous state and time scale |
| Aborted | `abort` command or fatal error | Stop immediately, build partial `result` (`completed:false, aborted:true`, `abortReason`), 0 XP | Emit `result` then `requestExit` |

**Bridge event order:** `ready` -> `progress`* (throttled) -> `checkpoint`* (at each Decision and each Explain) -> exactly one `result` -> `requestExit`. `Pause` and `Abort` never emit a second `result`.

## 9. Difficulty levels 1-5

| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Lanes selectable | 2 (low, high) | 3 | 3 | 3 | 3 |
| Rubber overlay | strong strips + % label | strong strips | subtle strips | subtle, no labels | hidden (inspect only) |
| Banking angle label | yes | yes | yes | on inspect | on inspect |
| Decision time limit (s) | none | none | 12 | 9 | 7 |
| Hints (`Hint` uses) | unlimited | 3 | 2 | 1 | 0 |
| Dirty-air (car ahead) scenarios | no | yes | yes | yes | yes |
| Scenario pool tags | gr-01, gr-02 | gr-01..gr-04 | gr-01..gr-07 | gr-03..gr-09 | gr-05..gr-09 |

**Default level for lesson `tracks-05`: 2.** Level 1 is passable by a true beginner using hints alone. Level 1 keeps only the two obvious lanes so the first contrast is short-way-around vs banked-and-high.

## 10. Configuration schema
Fragment for `LaunchRequest.configuration` (`additionalProperties:false`; invalid configuration yields `error CONFIG_INVALID`).

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "LaunchRequest.configuration",
  "type": "object",
  "properties": {
    "seed": {
      "type": "integer",
      "minimum": 0,
      "maximum": 2147483647,
      "description": "Deterministic seed. Omitted: derived from sessionId."
    },
    "scenarioSetId": {
      "type": "string",
      "enum": [
        "nascar-groove-read-core-1"
      ],
      "default": "nascar-groove-read-core-1"
    },
    "roundCount": {
      "type": "integer",
      "minimum": 1,
      "maximum": 5,
      "default": 3
    },
    "assetRoot": {
      "type": "string",
      "description": "Optional local path announced by native for Addressables bundles."
    },
    "showRubber": {
      "type": "boolean",
      "default": true
    },
    "controlScheme": {
      "type": "string",
      "enum": [
        "bands",
        "tap-only"
      ],
      "default": "bands"
    }
  },
  "additionalProperties": false
}
```

Valid example:

```json
{
  "seed": 2026,
  "scenarioSetId": "nascar-groove-read-core-1",
  "roundCount": 3,
  "showRubber": true,
  "controlScheme": "bands"
}
```

## 11. Scenario data set
Set `nascar-groove-read-core-1`: **9 scenarios**, file `scenarios/nascar-groove-read-core-1.json`. **Lap model (deterministic):** lane i in {0 low, 1 middle, 2 high}; path length factors L = [1.000, 1.012, 1.024]; speed factor v_i = 1 + bank x i + 0.06 x rubber_i - 0.03 (if a car ahead is in lane i); lap time T_i = baseLap x L_i / v_i. Verdict: best = lowest T; acceptable = within 0.15 s of best; poor otherwise. Only deltas are shown to the learner.

| scenarioId | setup | best lane (lap-time deltas) | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| gr-01 | Flat and fast down low: Phoenix-like flat oval (about 1 mile); banking gain 0.004 per lane step; rubber (low/mid/high) [0.6, 0.3, 0.0] | low (low +0.000 s, middle +0.674 s, high +1.367 s) | flat-track | L1-3 |
| gr-02 | Bristol banking, middle groove: Bristol-like high-banked half-mile (26 degrees); banking gain 0.030 per lane step; rubber (low/mid/high) [0.2, 0.9, 0.4] | middle (low +0.846 s, middle +0.000 s, high +0.172 s) | banking | L1-3 |
| gr-03 | Rubber lives up top: Darlington-like egg-shaped oval, late in the race; banking gain 0.012 per lane step; rubber (low/mid/high) [0.0, 0.2, 1.0] | high (low +1.605 s, middle +1.265 s, high +0.000 s) | rubbering-in | L2-4 |
| gr-04 | Stuck in dirty air: Kansas-like intermediate, chasing the leader in the middle lane; banking gain 0.012 per lane step; rubber (low/mid/high) [0.3, 0.7, 0.3]; car ahead in middle lane | low (low +0.000 s, middle +0.176 s, high +0.012 s) | dirty-air | L2-4 |
| gr-05 | Early race: rubber not there yet: Las Vegas-like intermediate, lap 20; banking gain 0.010 per lane step; rubber (low/mid/high) [0.5, 0.2, 0.0] | low (low +0.000 s, middle +0.580 s, high +0.991 s) | racing-groove | L3-5 |
| gr-06 | Steep and clean up top: Talladega-like superspeedway banking, no traffic; banking gain 0.020 per lane step; rubber (low/mid/high) [0.4, 0.4, 0.4] | high (low +0.680 s, middle +0.333 s, high +0.000 s) | banking | L3-5 |
| gr-07 | Rubber vs traffic: Bristol-like short track, car ahead low; banking gain 0.030 per lane step; rubber (low/mid/high) [0.9, 0.3, 0.1]; car ahead in low lane | high (low +0.247 s, middle +0.078 s, high +0.000 s) | dirty-air | L3-5 |
| gr-08 | Roval infield line: Charlotte Roval-like: choose the line through the banked final turn; banking gain 0.006 per lane step; rubber (low/mid/high) [0.5, 0.3, 0.1] | low (low +0.000 s, middle +0.557 s, high +1.121 s) | racing-groove | L4-5 |
| gr-09 | Track changes after a caution: Kansas-like intermediate, after a long caution cooled the track; banking gain 0.012 per lane step; rubber (low/mid/high) [0.3, 0.9, 0.1] | middle (low +0.973 s, middle +0.000 s, high +1.323 s) | rubbering-in | L4-5 |

**Fully written scenarios:**

**gr-01 (Flat and fast down low):** Phoenix-like flat oval (about 1 mile). Little banking: the short way around wins. Base lap 27.0 s, banking gain 0.004 per lane step, rubber [0.6, 0.3, 0.0]. low: speed factor 1.036, lap 26.062 s (best, +0.000 s). middle: speed factor 1.022, lap 26.736 s (poor, +0.674 s). high: speed factor 1.008, lap 27.429 s (poor, +1.367 s).

**gr-02 (Bristol banking, middle groove):** Bristol-like high-banked half-mile (26 degrees). Steep banking makes higher lanes fast, and rubber makes the middle groove sticky. Base lap 15.5 s, banking gain 0.030 per lane step, rubber [0.2, 0.9, 0.4]. low: speed factor 1.012, lap 15.316 s (poor, +0.846 s). middle: speed factor 1.084, lap 14.470 s (best, +0.000 s). high: speed factor 1.084, lap 14.642 s (poor, +0.172 s).

**gr-03 (Rubber lives up top):** Darlington-like egg-shaped oval, late in the race. Twenty-plus hours of rubber built a high groove against the wall. Base lap 29.0 s, banking gain 0.012 per lane step, rubber [0.0, 0.2, 1.0]. low: speed factor 1.000, lap 29.000 s (poor, +1.605 s). middle: speed factor 1.024, lap 28.660 s (poor, +1.265 s). high: speed factor 1.084, lap 27.395 s (best, +0.000 s).

Other scenarios use `{scenarioId, environment, baseLap, bank, rubber[3], dirtyLane|null, note, conceptId, tags}`; `correct` is derived from the model at load time and asserted. Track names in the UI are generic ("high-banked short track"), not real track branding.

## 12. Freeze / explain moments
Copy limits enforced by review: Title <= 6 words, body <= 45 words. Voice: cheeky coach, warm, a little flirty, never condescending; the learner is doing this for someone they care about.

### Explain 1: Flat means short
- **Trigger:** Execute ends in a flat/mostly-flat scenario (gr-01, gr-05, gr-08)
- **What freezes:** Three cars at the line
- **Camera:** `top-down`
- **Callouts:** Gold path for the low lane; length labels 1.000 / 1.012 / 1.024; banking angle label "1 degree"
- **Correct outcome copy**
  - Title: Nice read. Short way wins.
  - Body: On a flat track, higher lanes give no extra speed, so the shortest path around wins. That is why the bottom lane is king at places like Phoenix.
  - Say this: "It is flat, so everybody wants the bottom."
- **Incorrect outcome copy**
  - Title: Not quite. Longer is slower.
  - Body: Without banking to help, a higher lane is just a longer trip. The bottom lane wins unless rubber or traffic says otherwise. Check the banking label.
  - Say this: "He took the long way around."

### Explain 2: Banking helps
- **Trigger:** Execute ends in a steep-banking scenario (gr-02, gr-06, gr-07)
- **What freezes:** Cars on the banking with a g-force bar
- **Camera:** `chase-high` low then `top-down`
- **Callouts:** Gold arrow up the banking; "BANKING = SPEED" label; length labels vs speed factors
- **Correct outcome copy**
  - Title: Nice read. Banking pays.
  - Body: Steep banking lets cars carry more speed in the corners, so a higher lane can win despite being longer. Add sticky rubber and it is hard to beat.
  - Say this: "The banking makes the high lane fast."
- **Incorrect outcome copy**
  - Title: Not quite. Look up the banking.
  - Body: On a steep track, lanes higher up turn faster corners. The bottom lane is shorter but slower there. Read the banking angle before you decide.
  - Say this: "He ignored the banking."

### Explain 3: Rubber
- **Trigger:** Execute ends in a rubber-driven scenario (gr-03, gr-05, gr-09)
- **What freezes:** Rubber strips lit gold
- **Camera:** `top-down`
- **Callouts:** Gold strips on the fast groove; dotted rose outline on your lane; label "RUBBERED IN"
- **Correct outcome copy**
  - Title: Nice read. Follow the rubber.
  - Body: Tires lay rubber as the race runs, and a rubbered lane grips better. The fast groove often moves as the race goes on. Drivers watch where it builds.
  - Say this: "He found the rubber up high."
- **Incorrect outcome copy**
  - Title: Not quite. Rubber moves.
  - Body: The grippiest lane was the one with rubber laid down. Early in a race it can be low, later high. Look for the dark strips before you choose.
  - Say this: "The groove moved and he missed it."

### Explain 4: Traffic in your groove
- **Trigger:** Execute ends in a dirty-air scenario (gr-04, gr-07)
- **What freezes:** Car ahead with the turbulence cone
- **Camera:** `chase-high`
- **Callouts:** Rose cone behind the leader; gold path around it; label "DIRTY AIR -3%"
- **Correct outcome copy**
  - Title: Nice read. Avoid the wake.
  - Body: A car ahead in your lane kicks up messy air that steals front grip. Moving to a clear lane costs distance but can win it back. Sometimes the best groove is an open one.
  - Say this: "He moved out of the dirty air."
- **Incorrect outcome copy**
  - Title: Not quite. That lane was busy.
  - Body: You picked a lane with a car in it and drove into its wake. Your front tires lost grip and you slowed. Clear air is worth a slightly longer line.
  - Say this: "He got stuck in dirty air."


## 13. Scoring & mastery signals
**Score (0-100):** mean of round scores. Round score = 100 if best lane, 60 if acceptable, 0 if poor; -5 per Hint used. **Accuracy** = rounds with score >= 60 / rounds. **Outcome ids:** `groove-flat`, `groove-banked`, `groove-rubber`, `groove-traffic`.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text |
|---|---|---|
| Chose a high lane on a flat track | flat-track | Took the long way when banking gave no help |
| Chose the low lane on a steep-banked track without rubber advantage | banking | Ignored the banking |
| Ignored the rubber strip (gr-03, gr-05, gr-09) | rubbering-in | Chose a lane without rubber |
| Chose the lane with a car ahead (gr-04, gr-07) | dirty-air | Drove into dirty air |
| Chose a lane with no reasoning signal (any poor result) | racing-groove | Did not read the groove |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; native applies its own +0.20/-0.15 exercise scale separately and halves gain when hints were used)

| event | conceptId | delta | evidence text |
|---|---|---|---|
| `groove-flat` success | flat-track | +0.20 | Chose the short way on a flat track |
| `groove-banked` success | banking | +0.20 | Used the banking |
| `groove-rubber` success | rubbering-in | +0.20 | Followed the rubber |
| `groove-traffic` success | dirty-air | +0.20 | Avoided the wake |
| Any successful round | racing-groove | +0.10 | Read the groove correctly |
| Failed round | racing-groove | -0.10 | Wrong lane |

**Mapping to `SimulationResult`:** each round yields one `outcomes[]` entry (`id` = outcome id, `success`, `label`, `value`); each mistake yields `mistakes[]` `{conceptId, description, at}` (`at` = ms since launch); `masterySignals[]` entries use the table above; `score` = formula above rounded to integer; `accuracy` = successful rounds / rounds played (0..1).

## 14. XP & hearts
- `xpEarned` proposal: 10 per successful round, +40 when all 3 rounds are played (`completed:true`), +10 bonus when score >= 90. Max 80. Native clamps to the lesson XP budget.
- `heartsLost`: 1 if the session score < 40 (max 1 per session); 0 otherwise. Never lose a heart for abort, timeout caused by backgrounding, or errors. `unlimitedHearts` learners still report the same value; native ignores it.
- `replayAvailable`: `true` after the first completed round (Replay has recorded data); `false` if aborted before Explain or if Replay memory budget was hit. 

## 15. Failure states

| Case | What the learner sees | Result / event fields | Hearts |
|---|---|---|---|
| Failed round | Round outcome `success:false`, Explain with the incorrect copy, then Continue | outcome recorded; mistake + negative signal | Only via session rule (score < 40) |
| Failed session (score < 40) | Summary shows the constructive line "Rough one. Worth a rematch." and a Try again prompt (native) | `completed:true`, low score | 1 heart |
| Timeout (decision limit) | Decision auto-resolves as "no choice", Explain shows the correct answer | outcome `success:false`, mistake `timeout`-tagged in the description | No extra loss |
| Abort (user quits) | Native exit confirmation; Unity stops | `completed:false, aborted:true, abortReason:user-quit`, 0 XP, partial outcomes kept | No |
| Backgrounded | Auto-pause; resume restores state | If away > `runtime.maxDurationMs` native aborts: `backgrounded-too-long` | No |
| Asset missing | Native shows retry sheet | `error ASSET_LOAD_FAILED recoverable:true`; no result | No |
| Invalid config | Native skips activity with a friendly message | `error CONFIG_INVALID recoverable:false`; no result | No |

Failure always ends in an Explain moment, never a dead end. After every round all three lap times are shown so a wrong lane is never a mystery.

## 16. Accessibility
- **Reduced motion:** hard cuts instead of camera sweeps and dolly; no screen shake; freeze is instant; pulsing rings become static rings; overlay animations off.
- **Haptics off:** every haptic cue in section 17 has a visual and (if sound is on) audio equivalent.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): every color meaning has a second channel: shape and pattern (striped fill = wrong, dotted ring = correct, solid ring = selected) and car numbers on every vehicle. Lane bands have patterns (solid low, diagonal middle, dotted high); ghost cars are labeled with lane letters.
- **Text scale:** overlay text scales with `textScale` 0.8-3.0; callout cards reflow and scroll if needed; body >= 13 pt at scale 1.
- **Tap-only alternative:** see section 7.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson provided: ``tracks-05` native `hotspot-tap` set (tap the fast groove on annotated diagrams) plus `tracks-10` `visual-id`` (a designed native exercise on the same concepts, not a port of this sim).

## 17. Audio & haptics

| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Round start | Soft engine idle swell (0.5 s) | Soft tap | -18 dB |
| Correct outcome | Warm two-note chime | Light success | -12 dB |
| Incorrect outcome | Low single tone | Warning | -12 dB |
| Freeze | Low-pass filter over ambient, 250 ms | Soft tap | -15 dB |
| Callout appears | Short paper tick | None | -20 dB |
| Summary numerals | Soft tick per 10 points | None | -22 dB |

All cues honor `soundEnabled` and `hapticsEnabled`. No music. Engine ambience is synthesized (procedural), never a licensed recording.

## 18. Art & asset list

| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| stock-car-lowpoly (x3 LOD0, 1 lead LOD1) | procedural | original-swoond | ~3k / 1.2k tris | fictional numbers |
| Track variants (intermediate, banked short, flat, superspeedway segment) | procedural spline meshes | original | ~8k tris each | banking as shading and geometry |
| Rubber strips, lane bands, turbulence cone | procedural overlays | original | - | pattern + color |
| Sound cues | synthesized | original-swoond | < 0.6 MB |  |

Addressables bundle: `sim-nascar-track-groove-read-v1` (expected size <= 8 MB compressed). Overlay styling per `docs/astra/ART_DIRECTION.md` sections 4-5. Vehicle liveries are fictional (no real team paint schemes, sponsors or logos); car numbers are generic.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps sustained on iPhone 13-class (5th percentile >= 50 fps), < 150 MB peak resident memory, cold launch < 2 s to `ready`, bundle <= 25 MB, <= 150 draw calls, <= 60k triangles on screen, <= 15 materials, textures <= 8 MB VRAM, audio <= 3 MB. **Tighter per-sim limits:** <= 4 vehicles on screen; 8x fast-forward uses scripted splines with constant fixed timestep; no per-frame allocations in the timing board.

## 20. Telemetry
Diagnostics only, in `result.telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters `hintsUsed`, `decisionLatencyMs`, `laneChosen`, `inspectCount`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** Lap model: gr-01 lap deltas low 0.000, middle +0.674, high +1.367 s (+/-0.005) and best = low.
2. **AC-2:** gr-02: best = middle (14.470 s), high +0.172 (poor), low +0.846 (poor).
3. **AC-3:** gr-04: with dirty-air in the middle lane the low lane is best and high is acceptable (+0.012 s).
4. **AC-4:** Load-time consistency: authored `correct` equals model-derived verdicts for all scenarios.
5. **AC-5:** Level 1 presents only the low and high bands; level 5 hides rubber strips until inspected.
6. **AC-6:** Execute runs two laps for all three cars within 10 s wall-clock and the timing board shows deltas from the model.
7. **AC-7:** Bridge conformance: given every `launch` example in `docs/contracts/unity-bridge/v1/examples/` (with `simulationId` swapped) the sim emits `ready`, >= 1 `progress`, one `result` valid against `simulation-result.schema.json`, then `requestExit`.
8. **AC-8:** Determinism: with the same `seed`, difficulty and scripted inputs two runs produce identical `outcomes[]`, `score` and scenario order.
9. **AC-9:** Invalid configuration (unknown key, out-of-range value) yields `error CONFIG_INVALID` within 500 ms and no scene load.
10. **AC-10:** With seed 42, difficulty 2 and default config the sim plays exactly 3 rounds and `result.outcomes` has exactly 3 entries.
11. **AC-11:** All explain copy: title <= 6 words, body <= 45 words, say-this line <= 120 characters; every conceptId used exists in the curriculum `concepts[]`.
12. **AC-12:** Reduced motion: no camera sweeps, no shake, freeze is a hard cut; flow still completes.
13. **AC-13:** Color-blind mode: every correct/incorrect marker has a non-color channel (pattern/shape) in a screenshot diff per mode.
14. **AC-14:** Pause/resume: pausing for 30 s mid-round then resuming continues from the same state with no timeout fired; abort emits a single result with `aborted:true`.
15. **AC-15:** Privacy: no log line, telemetry key or persisted file contains `personName` or `relationship` values.
16. **AC-16:** Budgets on iPhone 13-class: avg fps >= 58, p5 >= 50, peak memory < 150 MB, cold launch < 2 s.

## 22. Test plan
- **EditMode:** Lap model for all nine scenarios, verdict thresholds, hint scoring, score maths, config validation, determinism, result schema.
- **PlayMode:** Scene build for track variants; scripted runs at levels 1, 3, 5; flyover and inspect; freeze/explain; pause/resume/abort; tap-only; reduced motion; color-blind screenshots.
- **Perf:** 3 consecutive full runs at difficulty 5 on an iPhone 13-class device; record fps, memory, thermal state (must not exceed "fair").

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | LapModel_gr01 |
| AC-2 | EditMode | LapModel_gr02 |
| AC-3 | EditMode | LapModel_gr04 |
| AC-4 | EditMode | Scenario_CorrectMatchesModel |
| AC-5 | PlayMode | Difficulty_LaneAndOverlay |
| AC-6 | PlayMode | Execute_TimingBoard |
| AC-7 | EditMode | BridgeConformance_ResultValidatesAgainstSchema |
| AC-8 | EditMode | Determinism_SameSeedSameResult |
| AC-9 | EditMode | Config_InvalidRejected |
| AC-10 | PlayMode | FullRun_ThreeOutcomes |
| AC-11 | EditMode | Copy_LengthsAndConceptIds |
| AC-12 | PlayMode | ReducedMotion_NoSweeps |
| AC-13 | PlayMode | ColorBlind_SecondChannel |
| AC-14 | PlayMode | PauseResumeAbort |
| AC-15 | EditMode | Privacy_NoPersonData |
| AC-16 | Perf | PerfBudget_IPhone13 |

## 23. Open questions

| # | Question | Owner (Claude / Astra / Product) | Blocking? |
|---|---|---|---|
| 1 | Stylized constants (path factors, 0.06 rubber, 0.03 dirty-air) need SME plausibility check. | Product / Claude | No |
| 2 | Confirm `RubberMap` belongs in the Track primitive rather than a sim-local overlay. | Astra | No |
| 3 | Do we show real track names in the UI (trademark/licensing) or generic descriptors? Proposal: generic descriptors only. | Product | No |

## Game Kit additions requested
- `RubberMap` (Track overlay): per-lane intensity array drawn as dark strips; reusable for F1 and cycling.
- Environment keys `oval_short_banked`, `oval_flat`.
