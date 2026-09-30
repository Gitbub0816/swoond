# Shot Shape: Face and Path (`golf.ball-flight.shot-shape.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `golf.ball-flight.shot-shape.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (definition is hand-coded, not data-driven, at v1) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `golf`; `unitId` `clubs-and-swings`; `lessonId` `club-05` ("Where the ball goes").
- CDS row: section 12, "`club-05`: Shot shape (face and path)".
- Manifest: `docs/courses/golf/manifest.json` -> `unitySimulations[0]`.
- Prerequisite concepts (else a native primer shows first): `loft`, `carry-distance`, `swing-phases`. A learner who has not mastered them sees a 3-card primer (a native `multiple-choice` set) before launch.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can explain why a golf ball curves: the clubface mostly sets where it starts, and the gap between face and path sets how much it bends."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `swing-path` | Swing path | Say which way the club is travelling at impact (in-to-out, out-to-in, straight). |
| `clubface-angle` | Face angle | Say where the face points at impact relative to the target. |
| `face-to-path` | Face-to-path | Explain that the gap between face and path creates the curve. |
| `start-line` | Start line | Explain that the starting direction follows mostly the face (about 75 to 85 percent), a little the path. |
| `draw` | Draw | Recognise a gentle curve toward the golfer's trailing side (right-to-left for a right-hander). |
| `fade` | Fade | Recognise a gentle curve to the other side (left-to-right for a right-hander). |
| `slice` | Slice | Recognise a big, unplanned curve away from the trailing side and know the usual cause (face open to path). |
| `hook` | Hook | Recognise the big curve the other way (face closed to path). |
| `push-pull` | Push and pull | Recognise a straight ball that starts off-line (face and path aligned but both pointing away from the target). |
| `wind-effect` | Wind drift | Adjust aim for a crosswind (levels 4 and 5 only). |
- **Out of scope:** spin axis maths, dynamic loft, attack angle, gear effects, launch numbers (`gear-04`), fixing a real swing (Swoon'd teaches understanding, not lessons), left-hander swing differences beyond mirroring.

## 4. Why Unity (tier justification)
- **Signals:** *physics* (the ball's flight: start line then curve) and *camera perspective* (behind the ball for the start line, top-down at the freeze to see curve as separation from the start line). The concept is a cause-and-effect relationship between two continuous inputs (face, path) and a curved output.
- **Closest native:** `hotspot-tap` or `binary-call` on a static flight diagram teaches the *names* of shapes and which side each curves, and is used in the native fallback. It cannot let the learner change two dials and watch the curve grow and shrink; the "aha" (face sets the start, the gap sets the bend) only comes from manipulating and seeing.
- **Weak alternative rejected:** a native slider pair with a static diagram would need a redrawn image on every input; that is a small physics scene in disguise and a worse teacher than Unity's ball flight.
- **Fallback:** native lesson `club-05-native`: three `hotspot-tap` (tap the ball path that is a fade, a hook, a push) on procedural top-down diagrams, two `binary-call` ("Face open to path: slice or hook?") and one `multiple-choice` with a "say this" line.
- Retained. Justification: strong (physics + perspective + manipulation).

## 5. Player fantasy & core loop
- **Fantasy:** "You are the coach at the range, with two dials: where the face points and where the club travels."
- **Loop:**
  1. Prompt: the goal card (for example "Hit a fade into the right side of the fairway").
  2. Decision: set the two dials (path, face) or, in name-the-shape rounds, watch the shot and choose its name.
  3. Execute: the swing plays and the ball flies (about 3 seconds, time-compressed).
  4. Freeze at landing: top-down view showing start line (dotted) and curve (arrow) and where it landed.
  5. Explain: title, body, "say this" line.
- **Session:** about 3 minutes, 3 rounds by default (configurable 3-6). One mechanic: face and path.

## 6. Scene & entities
- **Environment:** proposed key `golf_hole` (procedural fairway strip, 60 yd wide, 300 yd long, yardage arcs every 50 yd, trees and water as low-poly hazards). **Cameras:** `chase-high` behind the golfer (default), `top-down` (freeze and explain), `broadcast-side` (optional replay).
- **Units/coords:** world in meters; spec numbers in yards (1 yd = 0.9144 m). Origin at the ball; +z down-range toward the target; +x to the right of the target line for a right-hander. Left-hander mode mirrors x (and swaps the words "draw"/"fade", "in-to-out"/"out-to-in" in copy).

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `hole` | `Golf` env `golf_hole` (Swoond.Sports.Golf) | Fairway strip, yardage arcs, hazards | width 60 yd; tree line and water zones per scenario |
| `golfer` | `Character` | Stylised golfer with a full-swing animation | 1.75 m; `AnimState` swing-full; rose ring |
| `ball` | `Ball` (with GK-7 `Swing` curved-flight parameter) | The shot | radius 0.021 m; apex per club; flight time 3.0 s time-compressed |
| `clubHud` | `Highlight` overlay (2D) | Top-down clubhead diagram with path arrow (rose) and face bar (gold) | shows degrees; text labels "PATH" and "FACE" |
| `pathDial`, `faceDial` | `Target` x2 with continuous value | Draggable dials or steppers | range per level; hit >= 64 pt |
| `startLine` | `Path` + `Highlight` | Dotted line from ball along the start direction (shown at freeze) | rose dotted |
| `curveArrow` | `Path` + `Highlight` | Arrow from the start line to the landing point (the curve) | gold |
| `targetZone` | `Zone` (circle) | Target landing area | radius per level; gold outline on reveal |
| `hazards` | `Zone` x N | Trees, water (rose tint) | per scenario |
| `wind` | `Highlight` overlay + pennant prop | Crosswind arrow and mph label (levels 4-5) | mph and direction |
| `labelChips` | `DecisionPoint` (chip selector, GK-3) | Name-the-shape options | 6 chips: draw, fade, slice, hook, push, pull |
| `explain`, `score`, `replay`, `hints` | `Explanation`, `Score`, `Replay`, `Hint` | as per kit | |
- **New primitives:** none generic. Requests the `Golf` module and `golf_hole` environment (shared with the other golf sims), a `FlightModel` (pure function: face, path, club, wind to start angle, curve and landing offset; sim-local, promote if tennis/pickleball serve sims want it), and reuse of GK-7 `Ball.Throw` `Swing`.
- **Layout:**
```
                  target zone (radius r)
                       (o)
   trees | . . . . . . . . . . . . . | water
   ------------------------------------------ (fairway 60 yd wide)
                         ^
                      golfer + ball (chase-high camera behind)
   clubHud (bottom):  path arrow  /  face bar   [ - 1 + ]  [ - 1 + ]
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Set path | Drag the rose arrow on the clubhead HUD left/right, or tap - / + | `pathDial` | 64 pt handle; steppers 56 pt | Degrees label updates; haptic tick per degree |
| Set face | Drag the gold bar, or tap - / + | `faceDial` | 64 pt handle; steppers 56 pt | Degrees label; tick |
| Swing | Tap "Swing" (primary pill) | button | 56 pt | Swing animation |
| Name the shape | Tap a chip | `labelChips` | 56 pt each | Chip solid; light tick |
| Hint | Tap "Hint" | button | 44 pt | Ghost preview or text |
| Next | Tap | Primary pill | 56 pt | |
- **Tap-only scheme:** `controlScheme: "steppers"` uses the - / + buttons only; nothing requires a drag.
- **Portrait**, safe-area insets respected, dials in the bottom third.
- **Not drawn by Unity:** hearts, paywall, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build the hole, load scenario set | Ready or error | `ready` |
| Intro | ready | Goal card (mode, target, hazards, wind) | Playing | `progress` |
| Playing | after intro | Learner sets dials (make/fix modes) or watches a demo swing (name mode); hints available | Decision | none |
| Decision | Swing tapped or demo ends | Inputs locked; in name mode the chips appear after the flight | Executing | none |
| Executing | Swing | Deterministic flight from `FlightModel`; ball curves late; camera follows | Landing | none |
| Freeze | Landing | Time eases to 0 (250 ms); camera `top-down`; start line and curve arrow drawn; target gold | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | Card (section 12); "watch again" slow-mo replay (optional) | Next | `checkpoint round-N` |
| Summary | last round | Score numerals | Done | `progress 1.0` |
| Done | summary | Send `result` then `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze time; partial result with `aborted true`, `xpEarned 0` | resume / end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Dial range (degrees, each of face and path) | +-4 | +-5 | +-6 | +-8 | +-8 |
| Dial step | 1 | 1 | 1 | 0.5 | 0.5 |
| Ghost preview | full flight | start line only | none | none | none |
| Target radius (yd) | 14 | 11 | 9 | 8 | 7 |
| Crosswind (mph) | 0 | 0 | 0 | up to 5 | up to 10 |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Mode pool | make-shape | make-shape, name-shape | + fix-it | all | all |
| Label chips | 4 (draw, fade, slice, hook) | 4 | 6 | 6 | 6 |
| Time limit (per decision, s) | none | none | none | 30 | 20 |
- Default for `club-05`: **2**. L1 passable by a true beginner: preview flight shown, dial range +-4, big target, no wind.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "golf.ball-flight.shot-shape.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["shape-starter", "shape-mixed", "shape-fixes"], "default": "shape-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "handedness": { "type": "string", "enum": ["right", "left"], "default": "right" },
    "controlScheme": { "type": "string", "enum": ["dials", "steppers"], "default": "dials" },
    "showGhostPreview": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." },
    "decisionTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 10, "maximum": 60, "default": null, "description": "null = difficulty default." },
    "displayUnits": { "type": "string", "enum": ["yards", "meters"], "default": "yards" }
  }
}
```
Valid example: `{ "seed": 11, "scenarioSetId": "shape-starter", "scenarioCount": 3, "handedness": "right", "controlScheme": "dials" }`. Invalid configuration yields `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Scenarios/shape-v1.json` (bundle `sim-golf-shape`). Sets: `shape-starter` = `make-shape` + `name-shape` (sf-01 to sf-08); `shape-fixes` = `fix-it` + wind (sf-09 to sf-12); `shape-mixed` = all 12. Deterministic by seed: the seed picks scenario order and, in name-shape rounds, the demo camera side. The physics is analytic, so no noise unless a scenario sets `noise`.
- **N = 12 scenarios** (rounds 3 x 4).
- **Reference flight model (normative; pure function, unit-tested with fixtures).** Inputs: `club` (`driver` or `iron`), `carry` (yd), `face` and `path` (degrees, positive = right of target for a right-hander), `windMph` (positive = from the left, pushing the ball right).
  - `faceWeight` = 0.75 (driver), 0.85 (iron). `k` = 0.030 (driver), 0.022 (iron) yd of curve per degree of face-to-path per yd of carry.
  - `startAngle = faceWeight * face + (1 - faceWeight) * path` (degrees).
  - `faceToPath = face - path` (degrees; positive curves right).
  - `landingX = carry * tan(startAngle) + k * faceToPath * carry + windMph * 0.0025 * carry` (yd, positive = right).
  - Shape names from `faceToPath`: |value| < 0.5 = "straight" (if |startAngle| >= 2 degrees it is a "push" (right) or "pull" (left)); 0.5 to 3.0 = "fade" (positive) or "draw" (negative); above 3.0 = "slice" (positive) or "hook" (negative). Left-hander: mirror x and sign.
  - Visual trajectory: `x(s) = s * carry * tan(startAngle) + s^2 * (k * faceToPath * carry)`, `z(s) = s * carry`, `s` in [0,1]; the curve is drawn late because real curve grows late. Apex height 32 yd (driver), 30 yd (iron).
  - These values are illustrative and simplified (Swoon'd teaching model); Astra keeps the function pure and testable; an SME (S-06 style pass) reviews before approval.
- **Scenario shape:**
```json
{ "scenarioId": "sf-01", "mode": "make-shape", "club": "driver", "carry": 240,
  "target": { "x": 15, "radius": 9 }, "hazards": ["trees-left"], "windMph": 0,
  "reference": { "face": 1, "path": -1, "landingX": 16.5 }, "teaches": ["face-to-path", "fade"], "tags": ["make", "fade"] }
```
- **Scenarios** (landing values are from the reference model above; `x` positive = right; the learner succeeds when the landing point is within the target radius, or, for name-shape, chooses the right label; partial credit rules in section 13):

| scenarioId | Setup | Correct decision/outcome | Teaches | Difficulty tags |
|---|---|---|---|---|
| `sf-01` | Make: driver, carry 240. Trees down the left. Target: right-center of the fairway, x = +15, radius 9. | Reference face +1, path -1 (faceToPath +2, start +0.5 degrees), landing +16.5: a gentle fade. Any dial pair whose landing is within 9 of +15 succeeds. | `face-to-path`, `fade` | make, fade, L1+ |
| `sf-02` | Make: driver, carry 240. Water right. Target: left-center, x = -15, radius 9. | Reference face -1, path +1 (faceToPath -2), landing -16.5: a gentle draw. | `face-to-path`, `draw` | make, draw, L1+ |
| `sf-03` | Make: 7-iron, carry 150. Flag in the middle, target x = 0, radius 6. | Reference face 0, path 0, landing 0: straight. Also face -1, path -2 lands +0.3. | `start-line`, `face-to-path` | make, straight, L1+ |
| `sf-04` | Name: driver 240 with face +3, path -3 (faceToPath +6, start +1.5 degrees). Landing +49.5: starts near the target, bends far right. | "Slice." | `slice`, `face-to-path` | name, slice, L2+ |
| `sf-05` | Name: driver 240 with face -5, path +1 (faceToPath -6, start -3.5). Landing -57.9. | "Hook." | `hook`, `face-to-path` | name, hook, L2+ |
| `sf-06` | Name: driver 240 with face +4, path +4 (faceToPath 0, start +4 degrees). Landing +16.8, a straight ball off-line. | "Push" (right, no curve). | `push-pull`, `start-line` | name, push, L3+ |
| `sf-07` | Name: driver 240 with face -4, path -4 (faceToPath 0, start -4). Landing -16.8. | "Pull". | `push-pull`, `start-line` | name, pull, L3+ |
| `sf-08` | Name: 7-iron 150 with face +2, path -2 (faceToPath +4, start +1.4). Landing +16.9. | "Slice" (faceToPath above 3.0), an iron slice. | `slice`, `face-to-path` | name, slice, iron, L3+ |
| `sf-09` | Fix: driver 240. Current face +3, path -3 (the sf-04 slice), landing +49.5. Fairway edge at x = +/-22. Change ONE dial by up to 4 degrees so it finishes on the fairway. | Success set: face to 0 (landing +18.5), face to -1 (+8.1), path to +2 (+18.7). Path to 0 fails (+31). Face closing is the gentlest fix. | `face-to-path`, `slice` | fix, L3+ |
| `sf-10` | Make with wind: driver 240, 10 mph from the left (drift +6 yd). Target x = 0, radius 8. | Reference face -1, path -1 (straight, start -1 degree, landing +1.8). Also face 0, path +1 lands -0.2. | `wind-effect`, `start-line` | make, wind, L4+ |
| `sf-11` | Make: driver 240, a dogleg left with trees blocking the straight line. Target x = -28, radius 9. | Reference face -3, path 0 (faceToPath -3, landing -31); face -4, path -2 lands -29.1. | `draw`, `hook`, `face-to-path` | make, draw, L3+ |
| `sf-12` | Fix: 7-iron 150. Face +2, path -2 (slice, +16.9). Green is 30 yd wide: land within 15 of center. Change one dial by up to 3 degrees. | Success: face to -1 (landing +0.3 with path -2 pairing) or path to 0 (face +2, faceToPath +2, landing +11.1). | `face-to-path`, `slice` | fix, iron, L3+ |
- **Rules to generate more:** pick a club and carry from {driver 220-260, 7-iron 130-160}; pick a target lateral offset x in [-30, +30] and radius per level; compute the success set from the reference function over the dial grid; require at least 5 distinct successful pairs in range so the round is never a lottery. Name-shape scenarios use a random (face, path) with |faceToPath| distribution across straight/fade-draw/slice-hook.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-make` | Landing inside the target | Gold target ring; dotted start line; gold curve arrow | Correct | Nice read. That's the shape. | The face set the starting direction and the gap between face and path bent it. You changed both dials on purpose, and it finished where you wanted. | "The face sets the start, the gap sets the bend." |
| `x-near` | Landing within 1.5 x radius | Target ring rose-dashed; landing marker | Partial | Close. One dial off. | You were near. Check the start line first: that is mostly the face. Then adjust the gap between face and path for the bend. | "Fix the start line first, then the curve." |
| `x-miss` | Landing outside 1.5 x radius | Start line and curve drawn; target gold | Incorrect | Not quite. Look at the gap. | The ball starts where the face points, then bends with the gap between face and path. Yours started right and bent far more. Close the face a little. | "It's the face-to-path gap that makes it curve." |
| `x-name-right` | Correct label chosen | Chip gold; start line and curve arrow | Correct | Nice read. You named it. | A big bend from an open face is a slice; a big bend the other way is a hook. Small bends are a fade or draw. You read the gap. | "That's a slice: face open to the path." |
| `x-name-close` | Draw vs hook (or fade vs slice) confused | Both chip labels shown; faceToPath number | Partial | Right way, wrong size. | You got the direction. Size is the gap: a few degrees is a fade or draw, a lot is a slice or hook. It's a scale, not two boxes. | "Same direction, bigger gap: that's a slice." |
| `x-name-wrong` | Wrong direction or push/pull mistaken for curve | Start line highlighted; note "no curve" for push | Incorrect | Not quite. Start or bend? | A push starts right and stays straight. A slice starts near the target and bends right. Ask: did it change direction in the air, or start off-line? | "It started off-line but never bent: a push." |
| `x-fix-right` | Fix inside fairway | Before and after paths overlaid | Correct | Nice read. Smaller gap. | Closing the face (or swinging more in-to-out) shrinks the gap, so the bend shrinks with it. Face fixes are usually the gentlest first move. | "Close the gap between face and path." |
| `x-fix-wrong` | Fix still off the fairway | Both paths overlaid; gap number | Incorrect | Not quite. Gap still wide. | The gap is still big, so the ball still bends far. Path alone, moved a little, may leave the face wide open to it. Try closing the face. | "Still open to the path, so it still slices." |
| `x-wind` | Wind scenario resolved | Wind arrow; drift arrow | Correct | Nice read. You allowed for wind. | The wind pushed the ball right by about six yards, so you started it left. Good players aim into a crosswind and let it bring the ball back. | "Aim into the wind and let it carry it back." |
| `x-timeout` | Decision timer expired | Auto-swing with current dials | Timeout | Time's up. Try again. | Time ran out and the swing used your last dials. That is a fine moment to check the start line against the target. | "Check the start line before the swing." |

## 13. Scoring & mastery signals
- **Round points:** 1.0 correct (landing inside radius, correct label, or fix on the fairway); 0.6 partial (within 1.5 x radius; size-confused label); 0 otherwise; hint penalty -0.1 each (floor 0.4 for successes).
- **Score (0-100):** `round(100 * mean(roundPoints))`. **accuracy** = rounds fully correct / rounds.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Landing far off the start line (face ignored) | `start-line` | Started the ball in the wrong direction (face wrong). |
| Curve direction wrong | `face-to-path` | Bent the ball the wrong way (gap sign wrong). |
| Draw vs hook or fade vs slice confused | `slice` / `hook` | Confused a gentle bend with a big one. |
| Push or pull named as a curve | `push-pull` | Said the ball curved when it started off-line. |
| Fix that leaves the gap wide | `face-to-path` | Changed the wrong dial or too little. |
| Ignored wind | `wind-effect` | Did not offset for a crosswind. |
- **Mastery signals:** correct make -> `face-to-path` +0.15, `start-line` +0.10, plus the shape concept (`draw`/`fade`) +0.10; correct name -> the named concept +0.15; push/pull correct -> `push-pull` +0.20; correct fix -> `face-to-path` +0.15; wind correct -> `wind-effect` +0.15; mistakes -0.15 to the mapped concept. Per-session caps +-0.30 per concept; hints halve positives (native).
- **Result mapping:** `outcomes[]` per round (`id` `round-N`, `success`, `label`, `value` = `{ "shape": "...", "landingX": ... }`); `mistakes[]`; `masterySignals[]`.

## 14. XP & hearts
- `xpEarned` proposal: +10 per fully correct round, +5 per partial, +40 for finishing; native clamps to the lesson budget.
- `heartsLost` = 1 if accuracy < 0.34, else 0; max 1 per session.
- `replayAvailable` true (deterministic re-run via seed).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain card for the outcome | outcome false + mistake | none |
| Failed session | "Shot shape is a knack. Two more goes and the gap will make sense." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto-swing, explain (`x-timeout`) | see `x-timeout` | none |
| Abort/backgrounded | Native flow | `aborted true`, `xpEarned 0` | none |
| Asset missing / invalid config | Native error sheet | `error` events (`CONFIG_INVALID`) | none |
Always ends in an explain moment.

## 16. Accessibility
- **Reduced motion:** no camera sweeps; the freeze is a hard cut; the ghost preview is a static dotted line; no shake.
- **Haptics:** `hapticsEnabled` respected; dial ticks skipped when off.
- **Color-blind:** path arrow and face bar differ by shape (arrow vs bar) and text label; target is a ring with hatch; landing is a filled circle (in) or an X (out).
- **Text scale** honored; the goal card reflows.
- **Tap-only:** `controlScheme: "steppers"` completes everything with taps.
- **VoiceOver:** Unity content is limited; the native fallback lesson `club-05-native` is provided and awards the same concept credit.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Dial change | Soft tick | light tick per degree |
| Swing | Club whoosh | soft tap |
| Strike | Original "thock" (synthesised) | soft tap |
| Landing | Turf thud | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
All honor `soundEnabled` / `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural? | Source/license | Budget |
|---|---|---|---|
| Fairway strip, yardage arcs, trees, water | Procedural | `original-swoond` | < 4k tris |
| Golfer | Procedural | `original-swoond` | < 3k tris |
| Ball, club | Procedural | `original-swoond` | < 500 tris |
| Overlays (HUD, arrows, zones) | Procedural | n/a | n/a |
| Audio | Original synthesis | `original-swoond` | <= 1 MB |
Bundle `sim-golf-shape`, <= 5 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md` apply. Tighter: flight is analytic (no per-frame physics); memory < 100 MB; cold launch < 2 s; draw calls <= 100.

## 20. Telemetry
`avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `decisionLatencyMsMedian`, `controlScheme`, `modesPlayed`, `shapesNamedCorrectly`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** With seed 11, difficulty 2, 3 rounds, the sim emits exactly 3 `outcomes`; repeating gives identical results.
2. **AC-2:** `FlightModel` matches the fixture table for all 12 scenarios' reference dials (landing values in section 11, tolerance 0.1 yd).
3. **AC-3:** Shape naming: fixtures for faceToPath of 0, 0.4, 0.5, 2, 3, 3.1, -3.1, and push/pull cases return the specified labels.
4. **AC-4:** Success-set generation: for every generated scenario, at least 5 distinct dial pairs succeed (property test over 500 seeds).
5. **AC-5:** Left-hander mode mirrors x and labels; landing distances equal in magnitude for mirrored inputs.
6. **AC-6:** Wind offset: 10 mph gives +6.0 yd at carry 240 (fixture).
7. **AC-7:** `ready` < 2 s; `result` schema-valid; exactly one result.
8. **AC-8:** `steppers` scheme completes a run with no drag events.
9. **AC-9:** Pause/resume freezes the flight and the timer; abort yields `aborted=true`.
10. **AC-10:** Copy lint: titles <= 6 words, bodies <= 45 words, all outcomes have copy.
11. **AC-11:** Reduced motion path has no camera sweeps; color-blind second channel present.
12. **AC-12:** Invalid config yields `CONFIG_INVALID`.
13. **AC-13:** Perf: p5 >= 50 fps, memory < 100 MB on iPhone 13-class.
14. **AC-14:** Mastery signal caps +-0.30 per concept.

## 22. Test plan
- **EditMode:** `FlightModel` fixtures, shape naming, success-set property test, mirror test, config validation, scoring, seed determinism, copy lint, result schema.
- **PlayMode:** scene builds from code; scripted dial and stepper runs; freeze/explain sequence; pause/abort; reduced motion; colour-blind snapshot.
- **Perf:** iPhone 13-class 3-round run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Shape` |
| AC-2 | EditMode | `FlightModel_Fixtures` |
| AC-3 | EditMode | `ShapeNaming_Fixtures` |
| AC-4 | EditMode | `SuccessSet_Property` |
| AC-5 | EditMode | `Mirror_LeftHander` |
| AC-6 | EditMode | `Wind_Offset` |
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
| 1 | Add the `Golf` module, `golf_hole` environment and `FlightModel`; reuse GK-7 `Ball.Throw` `Swing` and GK-3 chip selector. | Astra | Yes |
| 2 | SME (PGA professional) check of the simplified face/path model (weights 0.75/0.85 and k values); the model is a teaching approximation. | Product | Yes for approval |
| 3 | Should the second club (iron) and `wind` be part of v1 or v1.1? Proposed: v1 as specified (sf-03, sf-08, sf-10, sf-12). | Claude/Astra | No |
| 4 | Left-hander mirrored copy: confirm wording ("draw"/"fade" swap by golfer side). | Claude | No |

### Game Kit additions requested
- `Golf` module (Swoond.Sports.Golf) with `golf_hole` environment key, shared by all four golf sims (see the other three specs).
- `FlightModel` (sim-local pure function; reuse if a golf-shot, tennis or pickleball-serve sim needs it).
- GK-7 `Ball.Throw` `Swing` (curved flight); GK-3 chip selector; GK-19 `chase-high` and `top-down` presets (already listed).
