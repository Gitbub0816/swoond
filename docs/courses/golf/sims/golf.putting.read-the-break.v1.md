# Putting: Read the Break (`golf.putting.read-the-break.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `golf.putting.read-the-break.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (hand-coded at v1) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `golf`; `unitId` `short-game-and-putting`; `lessonId` `short-03` ("Reading a green").
- CDS row: section 12, "`short-03`: Read the break".
- Manifest: `docs/courses/golf/manifest.json` -> `unitySimulations[1]`.
- Prerequisite concepts (else a native primer first): `putting-line-speed`, `lag-putt`. Primer: a 3-card native set on line and speed.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can read which way a putt breaks, aim at a spot on the high side, and see why a firmer putt breaks less."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `break` | Break | Say how much and which way a putt curves and why. |
| `fall-line` | Fall line | Point to the direction water would run from the ball (the steepest downhill). |
| `green-speed-stimp` | Green speed | Explain that a faster green (higher Stimp) breaks more and needs a softer stroke. |
| `aim-point` | Aim point | Pick a spot on the high side of the hole to start the ball at, instead of aiming at the cup. |
| `putting-line-speed` | Line and speed | Say that pace changes the line: firm putts break less, dying putts break more. |
| `lag-putt` | Lag putt | Judge pace on a long putt so it finishes in the tap-in zone. |
| `three-putt` | Three-putt | Say why long putts with poor pace lead to three-putts. |
- **Out of scope:** grain, stroke mechanics, putter fitting, AimPoint-style methods and any named proprietary green-reading system, reading from a plumb bob, and reading a real green from photos.

## 4. Why Unity (tier justification)
- **Signals:** *3D terrain* (slope is a 3D surface), *physics* (a ball rolling and curving under gravity with friction), and *camera perspective* (orbit low to see the slope against the horizon, top-down to see the line).
- **Closest native:** `hotspot-tap` on a contour diagram or a `decision-scenario` fact sheet ("2% slope, falls left"). It teaches the vocabulary and where the high side is. It cannot teach "more speed means less break" or how much to play, because those need a rolling ball responding to two continuous inputs; a text answer would be a fact, not a feel.
- **Second consumer of the Terrain module (GK-20)** after `hiking.navigation.topo-terrain.v1`; this makes the Terrain investment reusable (`docs/astra/ROADMAP.md` suggested golf as the second consumer).
- **Fallback:** native lesson `short-03-native`: three `hotspot-tap` on procedural contour diagrams (tap the high side, tap the fall line), two `binary-call` ("Aim left or right of the hole?"), one `estimate-slider` (how far past should it finish, in inches).
- Retained. Justification: strong.

## 5. Player fantasy & core loop
- **Fantasy:** "You are standing over a putt with all the time in the world to read it."
- **Loop:**
  1. Prompt: the situation card (distance, green speed, slope note at low levels).
  2. Read: orbit the camera, toggle contours and flow arrows (per level); optional practice putts at L4-5.
  3. Decision: place the aim marker and set pace.
  4. Execute: the ball rolls under the shared roll model.
  5. Freeze at rest or in the cup: gold ideal line versus your line; explain; line you could say out loud.
- **Session:** about 3 minutes, 3 rounds by default (3-6).

## 6. Scene & entities
- **Environment:** `terrain_heightfield` (GK-20) configured as a green: a 16 yd x 12 yd oval, hole cut at the scenario position, fringe ring. **Cameras:** `oblique-low` (default read view; user can orbit 60 degrees), `top-down` (aim and freeze), `chase-high` (behind the ball for the start line).
- **Units/coords:** meters; origin at the ball; +y toward the hole; +x to the right; spec numbers in feet and inches.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `green` | `Heightfield` + `TerrainMesh` (GK-20) with named stamps `tilt`, `tilt-split` | The putting surface | 129 x 129 grid; slope from scenario stamps; vertical exaggeration 8x for display only |
| `contours` | `ContourOverlay` | Contour lines and index lines | interval 0.5 in (0.0127 m); every 4th an index line |
| `flow` | `Highlight` demonstrate type `water_flow` | Flow arrows showing downhill | density per level |
| `slopeShade` | `SlopeShader` | Subtle grade tint with hatching second channel | on at L1-3 |
| `ball` | `Ball` (physics preset `putt`) | The putt | radius 0.021 m; rolling model in section 11 |
| `hole` | `Zone` (circle) + cup mesh | The cup | radius 0.054 m (2.125 in) |
| `aimMarker` | `Target` (free placement on green) | Start-line point | rose ring; draggable; hit >= 64 pt |
| `paceSlider` | `Target` continuous | Pace in feet of roll on a flat green | range 4-40 ft; tick at hole distance |
| `line` | `Path` + `Highlight` | Predicted line (L1 only), actual line, ideal line | rose (yours), gold (ideal) |
| `golfer` | `Character` | Putting stance, decorative | `AnimState` putt |
| `explain`, `score`, `replay`, `hints` | `Explanation`, `Score`, `Replay`, `Hint` | as per kit | |
- **New primitives:** none generic. Requests the `Golf` module (`RollModel`, green stamps), `golf_green` preset built on GK-20 (`tilt`, `tilt-split` stamps), and confirms GK-20 `ContourOverlay` interval control and `water_flow`.
- **Layout:**
```
      top-down aim view
        [ hole ]                 flow arrows -->  (falls left)
          .                      contours ~~~~
          .   start line
          .  /
         (ball)          pace slider: |----o------------| 4..40 ft
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Orbit the read camera | One-finger drag on the scene | camera | n/a | Smooth orbit, limited to 60 degrees; disabled in reduced-motion (preset buttons instead) |
| Toggle overlays | Tap chips "Contours", "Flow" | chips | 44 pt | Overlay fades in |
| Place aim marker | Tap or drag on the green | `aimMarker` | 64 pt handle | Dotted preview line at L1; offset label in inches at the hole |
| Set pace | Drag the slider, or - / + | `paceSlider` | 64 pt handle; buttons 56 pt | Value label; tick at the hole distance |
| Practice putt | Tap "Practice" (L4-5, max 2) | button | 44 pt | Ball rolls, no score |
| Putt | Tap "Putt" (primary pill) | button | 56 pt | Stroke animation |
| Next | Tap | Primary pill | 56 pt | |
- **Tap-only scheme:** `controlScheme: "steppers"`: the aim is set with - / + steppers in 2-inch steps (labelled "left / right of the hole at the hole") and pace with 1-ft steps; camera uses preset buttons (Read, Top, Behind).
- **Portrait**, safe-area insets respected; controls in the bottom third.
- **Not drawn by Unity:** hearts, paywall, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build the green from stamps, load scenario set | Ready or error | `ready` |
| Intro | ready | Situation card (distance, green speed at L1-3, goal) | Read | `progress` |
| Read | after intro | Camera orbit, overlays, practice putts (L4-5) | Decision | none |
| Decision | Putt tapped | Inputs locked | Executing | none |
| Executing | Putt | Deterministic roll at fixed dt 1/240 until rest or capture | Freeze | none |
| Freeze | Rest or holed | Time eases to 0 (250 ms); camera `top-down`; your line rose, ideal line gold | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | Card (section 12); optional slow-mo replay | Next | `checkpoint round-N` |
| Summary | last round | Score numerals | Done | `progress 1.0` |
| Done | summary | `result` then `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze time; partial result `aborted true`, `xpEarned 0` | resume / end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Flow arrows | dense | medium | off | off | off |
| Contours | on | on | on (index only) | on (index only) | off |
| Slope label (percent, direction) | shown | shown | tilt gauge only | off | off |
| Predicted line preview | yes | no | no | no | no |
| Green speed shown | yes | yes | yes | hidden (feel it in practice) | hidden |
| Practice putts | n/a | n/a | n/a | 2 | 2 |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Distance range (ft) | 6-12 | 8-15 | 8-20 | 10-25 | 10-30 |
| Scenario pool | straight, single tilt | + uphill/downhill | + combined slopes | + speed variants | + double break, lag |
| Decision time limit (s) | none | none | none | none | 45 |
- Default for `short-03`: **2**. L1 passable by a true beginner: flow arrows, slope label, predicted line, short putts, generous success band.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "golf.putting.read-the-break.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["putt-starter", "putt-slopes", "putt-speed", "putt-mixed"], "default": "putt-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "controlScheme": { "type": "string", "enum": ["drag", "steppers"], "default": "drag" },
    "showFlowArrows": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." },
    "showContours": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." },
    "practicePutts": { "type": ["integer", "null"], "minimum": 0, "maximum": 3, "default": null, "description": "null = difficulty default." },
    "displayUnits": { "type": "string", "enum": ["feet", "meters"], "default": "feet" }
  }
}
```
Valid example: `{ "seed": 5, "scenarioSetId": "putt-starter", "scenarioCount": 3, "controlScheme": "drag" }`. Invalid configuration yields `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Scenarios/putt-v1.json` (bundle `sim-golf-putt`). Sets: `putt-starter` = pt-01 to pt-04; `putt-slopes` = pt-02, pt-03, pt-04, pt-05, pt-06, pt-12, pt-13; `putt-speed` = pt-02, pt-07, pt-08, pt-09, pt-11, pt-10; `putt-mixed` = all 13. Deterministic by seed (order only; physics is deterministic).
- **N = 13 scenarios** (rounds 3 x 4 = 12 minimum).
- **Reference roll model (normative; pure function, unit-tested with fixtures).** Constants: `g` = 9.81 m/s^2; `stimpReleaseSpeed` = 1.83 m/s; cup radius 0.054 m.
  - Friction deceleration `a_f = 1.83^2 / (2 * stimpFt * 0.3048)` m/s^2 (Stimp 10 gives 0.549; Stimp 8 gives 0.687; Stimp 13 gives 0.423).
  - Slope acceleration `a_s = (5/7) * g * s` in the downhill direction (`s` = rise over run, small-angle approximation; 2% means 0.02).
  - State update at fixed dt 1/240: `v += (a_s - a_f * v/|v|) dt`; position += v dt; stop when speed < 0.02 m/s.
  - Capture: when the ball's path crosses the cup circle, it drops if speed <= `1.6 - 1.1 * (d / 0.054)` m/s where `d` is the closest distance to the cup center during the crossing; otherwise it "lips out" (no deflection modelled) and keeps rolling.
  - "Pace" is the learner-facing feet of roll on a flat green at that launch speed: `paceFt = v0^2 / (2 * a_f) / 0.3048`.
  - **Golden reference values** below were computed by this model (a checked-in golden generator writes them to fixtures; the numbers are non-normative until the generator runs). The reference solution aims so the ball, if it misses, finishes 17 inches past the cup (the common "capture pace" rule of thumb). `aim` is the lateral offset from the cup at the cup's distance of the start line (negative = left).
- **Scenario shape:**
```json
{ "scenarioId": "pt-02", "goal": "make", "distanceFt": 12, "stimp": 10,
  "terrain": [ { "type": "tilt", "downhillPct": 0, "crossPct": -2 } ],
  "reference": { "aimInches": 13.8, "paceFtFlat": 13.4, "launchSpeedMps": 2.12 },
  "teaches": ["break", "aim-point", "fall-line"], "tags": ["single-tilt", "L1+"] }
```
- **Scenarios** (`crossPct` positive = the green falls to the right; `downhillPct` positive = downhill toward the hole, negative = uphill):

| scenarioId | Setup | Correct decision/outcome | Teaches | Difficulty tags |
|---|---|---|---|---|
| `pt-01` | Make: 8 ft, Stimp 10, flat (no tilt). | Aim at the hole (0 in), pace about 9.4 ft of flat roll (launch 1.78 m/s). | `putting-line-speed`, `aim-point` | flat, L1+ |
| `pt-02` | Make: 12 ft, Stimp 10, tilt crossPct -2 (falls left, 2 percent). | Aim 13.8 in right of the cup; pace 13.4 ft (launch 2.12 m/s). The high side is the aim point. | `break`, `fall-line`, `aim-point` | single-tilt, L1+ |
| `pt-03` | Make: 15 ft, Stimp 10, uphill 3 percent (downhillPct -3), no cross slope. | Aim 0 in (straight); pace 22.7 ft (launch 2.76 m/s): uphill needs more pace, no break. | `putting-line-speed`, `break` | uphill, L2+ |
| `pt-04` | Make: 20 ft, Stimp 11, downhill 2 and crossPct +2 (falls right). | Aim 40.1 in left of the cup; pace 15.5 ft (launch 2.18 m/s). | `break`, `aim-point`, `green-speed-stimp` | combined, L3+ |
| `pt-05` | Make: 10 ft, Stimp 12, crossPct +4 (falls right, a steep tilt). | Aim 28.6 in left; pace 11.5 ft (launch 1.79 m/s). | `break`, `green-speed-stimp` | steep, fast, L3+ |
| `pt-06` | Make: 20 ft, Stimp 10, double break: crossPct -2 for the first half, +2 for the second. | Aim 3.0 in right (breaks cancel); pace 21.3 ft (launch 2.67 m/s). | `break`, `fall-line` | double, L5 |
| `pt-07` | Speed: 10 ft, Stimp 10, crossPct -2. | Aim 11.0 in right; pace 11.4 ft (launch 1.96 m/s). Same slope as pt-02, shorter putt, less break. | `break`, `putting-line-speed` | speed, L3+ |
| `pt-08` | Speed: 12 ft, Stimp 8 (slow), crossPct -2. | Aim 10.9 in right; pace 13.4 ft (launch 2.37 m/s). Slow green, less break, harder stroke. | `green-speed-stimp`, `break` | speed, slow, L4+ |
| `pt-09` | Speed: 12 ft, Stimp 13 (fast), crossPct -2. | Aim 18.1 in right; pace 13.4 ft (launch 1.86 m/s). Fast green, more break, softer stroke. | `green-speed-stimp`, `break` | speed, fast, L4+ |
| `pt-10` | Lag: 25 ft, Stimp 10, flat. Goal `lag`: finish within 3 ft of the cup. | Aim 0; pace 26.4 ft (launch 2.98 m/s) ends about 17 in past. Anything finishing within 3 ft is full credit. | `lag-putt`, `three-putt` | lag, L4+ |
| `pt-11` | Make: 6 ft, Stimp 11, downhill 2 percent, no cross slope. | Aim 0; pace only 5.3 ft of flat roll (launch 1.28 m/s): downhill putts need very little pace. | `putting-line-speed`, `three-putt` | downhill, short, L3+ |
| `pt-12` | Make: 15 ft, Stimp 10, S-curve: crossPct +1 for the first half, -2 for the second. | Aim 2.5 in right; pace 16.3 ft (launch 2.34 m/s). The second half decides. | `break`, `fall-line` | double, L5 |
| `pt-13` | Make: 15 ft, Stimp 10, uphill 2 and crossPct +3 (falls right). | Aim 21.4 in left; pace 20.7 ft (launch 2.63 m/s). | `break`, `aim-point` | combined, uphill, L3+ |
- **Pace sensitivity (for the explain copy and a fixture):** on pt-02 with the reference launch, a putt that would finish 36 in past needs 11.2 in of aim (firmer, less break); the reference 17 in past needs 13.8 in; a putt that dies at the cup needs roughly 50 in of aim and is unstable (very small pace changes swing it), which is why dying putts are risky.
- **Rules to generate more:** choose distance from the level range, Stimp from {8, 9, 10, 11, 12, 13}, a tilt with |cross| up to 4 percent and |downhill| up to 3 percent, or a split; compute the reference by solving pace (17 in past) then bisection on the start angle; require a success band of at least 1.6 in of aim at the reference pace; reject scenarios whose band is narrower.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-holed` | Ball drops | Gold line and cup ring; flow arrows | Correct | Nice read. It's in. | You started it on the high side and let the slope bring it back. Good pace let it fall in instead of skimming by. | "I played it out to the right and let it feed in." |
| `x-close` | Finish within 2 ft (make goal) | Rose line; gold ideal; distance label | Partial | Close. Tap-in range. | Your read was near. It missed on the low side or a touch of pace. Stay on the high side and keep the pace steady. | "Missed on the low side; I'll play more break." |
| `x-low` | Missed on the low side (below the hole) | Rose line crosses under the cup; gold line above | Incorrect | Not quite. Low side. | It broke more than you allowed. Water runs downhill, so start the ball above the hole and let gravity do the rest. | "Always miss on the high side." |
| `x-high` | Missed on the high side | Rose line passes above the cup | Incorrect | Not quite. Too much aim. | You played more break than the slope gave. Trust the fall line: read the water flow and aim a little closer to the cup. | "I over-read it; the slope was gentler." |
| `x-short` | Finished short of the cup | Rose line stops short; distance label | Incorrect | Not quite. Left it short. | It never got there. A putt that stops short cannot go in. Aim to finish about a foot or so past the cup. | "Never up, never in." |
| `x-long` | Finished 4 ft or more past | Rose line runs long | Incorrect | Not quite. Too firm. | Too much pace made the next putt a nervous one and gave the slope less time to work. Aim to finish a foot or two past. | "Too hard; that's how you three-putt." |
| `x-speed-break` | Speed scenarios (pt-07, pt-08, pt-09) resolved | Gold and rose lines with aim numbers | Correct or Incorrect | More speed, less break. | Firmer putts hold their line longer; slower putts curve more. That is also why fast greens ask for a softer stroke and more aim. | "Firm putts break less." |
| `x-uphill` | Uphill or downhill scenarios resolved | Slope arrow; pace numbers | Correct or Incorrect | Uphill needs more pace. | Uphill putts stop sooner, so they need more pace; downhill putts run, so they need much less. Straight slopes add no break. | "Uphill, hit it; downhill, feather it." |
| `x-lag` | Lag scenario within 3 ft | Circle at 3 ft; finish position | Correct | Nice lag. Tap-in zone. | You did not try to hole it; you gave it a fair chance and a safe second putt. That is how you avoid three-putts. | "Lag it close, then tap in." |
| `x-timeout` | Timer expired | Auto-putt with current aim | Timeout | Time's up. Try again. | Time ran out and the putt used your last aim and pace. That is a fine moment to check the fall line. | "Read the slope first, then the pace." |

## 13. Scoring & mastery signals
- **Round points (goal `make`):** 1.0 holed; 0.7 finish within 2 ft; 0.4 within 4 ft; 0 otherwise. **Goal `lag`:** 1.0 within 3 ft; 0.5 within 6 ft; 0 otherwise. Hint penalty -0.1 each (floor 0.4 for holed).
- **Score (0-100):** `round(100 * mean(roundPoints))`. **accuracy** = rounds with points >= 0.7 / rounds.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Aim on the wrong side (low side) | `fall-line` | Aimed downhill instead of uphill of the cup. |
| Too little aim (missed low) | `break` | Did not play enough break. |
| Too much aim (missed high) | `break` | Played too much break. |
| Aimed at the cup on a sloped putt | `aim-point` | Ignored the slope and aimed straight. |
| Finished short | `putting-line-speed` | Pace too soft. |
| Finished 4 ft or more past | `putting-line-speed` | Pace too firm; risk of a three-putt. |
| Speed scenario misjudged (ignored Stimp) | `green-speed-stimp` | Did not adjust for green speed. |
| Lag finished more than 6 ft away | `lag-putt` | Poor distance control on a long putt (`three-putt` risk). |
- **Mastery signals:** holed -> `break` +0.15, `aim-point` +0.15, `putting-line-speed` +0.10; correct speed scenario -> `green-speed-stimp` +0.20; correct lag -> `lag-putt` +0.20, `three-putt` +0.10; correct fall-line (aim on the high side) -> `fall-line` +0.15; mistakes -0.15 to the mapped concept. Caps +-0.30 per concept per session; hints halve positives (native).
- **Result mapping:** `outcomes[]` per round (`id` `round-N`, `success`, `label`, `value` = `{ "finishInches": ..., "holed": true|false, "aimInches": ..., "paceFt": ... }`); `mistakes[]`; `masterySignals[]`.

## 14. XP & hearts
- `xpEarned` proposal: +10 per round with points >= 0.7, +5 for 0.4, +40 for finishing; native clamps.
- `heartsLost` = 1 if accuracy < 0.34, else 0; max 1.
- `replayAvailable` true (deterministic).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Missed putt | Explain card (`x-low`, `x-high`, `x-short`, `x-long`) | outcome false + mistake | none |
| Failed session | "Reading greens takes reps. Two more and the slope will start talking." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto-putt, explain | see `x-timeout` | none |
| Abort/backgrounded | Native flow | `aborted true`, `xpEarned 0` | none |
| Asset missing / invalid config | Native error sheet | `error` events (`CONFIG_INVALID`) | none |
Always ends in an explain moment.

## 16. Accessibility
- **Reduced motion:** no camera orbit sweeps (preset buttons cut instantly); the freeze is a hard cut; flow arrows are static; the ball roll is not slowed by easing; no shake.
- **Haptics:** `hapticsEnabled` respected; pace ticks skipped when off.
- **Color-blind:** slope shading has a hatch second channel; ideal line is gold and dashed, yours is rose and solid; the cup has a ring; result markers use circle vs X.
- **Text scale** honored; card reflows.
- **Tap-only:** `controlScheme: "steppers"` completes everything with taps.
- **VoiceOver:** Unity is limited; the native fallback lesson `short-03-native` gives the same concept credit.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Aim place | Soft tick | light tick |
| Putt strike | Original soft "tock" (synthesised) | soft tap |
| Roll | Low rolling hiss scaled by speed | none |
| Cup drop | Original ball-in-cup rattle | light success |
| Miss | Soft thud | warning |
All honor `soundEnabled` / `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural? | Source/license | Budget |
|---|---|---|---|
| Green mesh, fringe, cup | Procedural (GK-20) | `original-swoond` | < 17k tris (129 x 129 grid) |
| Contour and flow overlays | Procedural | n/a | n/a |
| Ball, putter, golfer | Procedural | `original-swoond` | < 4k tris |
| Audio | Original synthesis | `original-swoond` | <= 1 MB |
Bundle `sim-golf-putt`, <= 6 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md` apply. Tighter: roll physics at fixed dt 1/240 within 1.5 ms per frame; one ball; memory < 120 MB (terrain grid); cold launch < 2 s; draw calls <= 120.

## 20. Telemetry
`avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `practicePuttsUsed`, `aimErrorInchesMedian`, `paceErrorFtMedian`, `controlScheme`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** With seed 5, difficulty 2, 3 rounds, exactly 3 `outcomes`; repeating gives identical outcomes.
2. **AC-2:** Roll model fixtures: for the 13 scenarios' reference aim and launch speed, the ball is holed (or, for pt-10, finishes within 3 ft), and finishes 17 in past when the cup is removed (tolerance 2 in).
3. **AC-3:** Friction check: on a flat Stimp 10 green a 1.83 m/s roll travels 10 ft +/- 0.2 ft.
4. **AC-4:** Capture rule fixtures: a ball crossing the cup center at 1.5 m/s drops; at 1.7 m/s it lips out; a ball 0.05 m off center drops only at 0.6 m/s or less.
5. **AC-5:** Pace sensitivity fixture (pt-02): reference aim for 36 in past is 11.2 in +/- 1.0; for 17 in past is 13.8 in +/- 1.0.
6. **AC-6:** Generated scenarios keep a success band >= 1.6 in of aim at reference pace (property test over 300 seeds).
7. **AC-7:** `ready` < 2 s; `result` schema-valid; exactly one result.
8. **AC-8:** Steppers scheme completes a run with no drag or orbit gestures.
9. **AC-9:** Pause/resume freezes the roll and timer; abort yields `aborted=true`.
10. **AC-10:** Copy lint: titles <= 6 words, bodies <= 45 words, all outcomes have copy.
11. **AC-11:** Reduced motion has no camera sweeps; color-blind second channel present.
12. **AC-12:** Invalid config yields `CONFIG_INVALID`.
13. **AC-13:** Perf: p5 >= 50 fps, memory < 120 MB on iPhone 13-class.
14. **AC-14:** Mastery signal caps +-0.30 per concept.

## 22. Test plan
- **EditMode:** roll model fixtures, capture rule, pace sensitivity, scenario generation property test, config validation, scoring, seed determinism, copy lint, result schema.
- **PlayMode:** scene builds from code; scripted drag and stepper runs; practice putts; freeze/explain; pause/abort; reduced motion; colour-blind snapshot.
- **Perf:** iPhone 13-class 3-round run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Putt` |
| AC-2, AC-3 | EditMode | `RollModel_Fixtures`, `Friction_Stimp10` |
| AC-4 | EditMode | `CupCapture_Fixtures` |
| AC-5 | EditMode | `PaceSensitivity_pt02` |
| AC-6 | EditMode | `ScenarioBand_Property` |
| AC-7 | PlayMode | `ColdLaunch_Result_Schema` |
| AC-8 | PlayMode | `Steppers_FullRun` |
| AC-9 | PlayMode | `Pause_Abort` |
| AC-10 | EditMode | `Copy_Lint` |
| AC-11 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-12 | EditMode | `Config_Invalid` |
| AC-13 | Perf | `Perf_iPhone13` |
| AC-14 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Golf module: `RollModel`, green stamps (`tilt`, `tilt-split`) on GK-20; confirm `ContourOverlay` supports a 0.5 in interval and `water_flow` arrows on a heightfield. | Astra | Yes |
| 2 | SME (PGA professional or teaching pro) check of the roll model constants and the 17-in pace convention. | Product | Yes for approval |
| 3 | Do we need lip-out deflection (physics) or is "keeps rolling" enough for v1? Proposed: enough for v1. | Claude/Astra | No |
| 4 | Sequence with the Terrain module: this sim depends on GK-20 shipping for hiking first or in parallel (ROADMAP phase for GK-20). | Astra/Product | Yes for build order |

### Game Kit additions requested
- `Golf` module (Swoond.Sports.Golf): `RollModel` (pure function), green presets on the GK-20 Terrain module (`tilt`, `tilt-split` stamps); `golf_green` preset.
- GK-20 confirmations: `ContourOverlay` fine interval, `water_flow` demonstrate type on a small heightfield, `SlopeShader` hatch channel.
- GK-19 `oblique-low` preset (already requested by hiking).
