# Compression Lab (`photo.lens.compression-lab.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `photo.lens.compression-lab.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (scenario-driven, not a sim-definition file at v1) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `photography`; `unitId` `cameras-and-lenses` (lesson `cam-06`, primary), `branch-portrait` (`port-01`, difficulty 3, portrait scenario set), `review-loop` (`rev-02`, difficulty 2, mixed).
- CDS row: section 12, "`cam-06`, `port-01`, `rev-02`: compression and field of view". Manifest: `unitySimulations[0]`.
- Prerequisite concepts (mastered, or the lesson shows a primer first): `focal-length`, `field-of-view`, `sensor-size`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can make a subject the same size with a wide lens up close or a long lens far away, and say what changes: the background, and the face."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `perspective-compression` | Perspective compression | Say that distant things look bigger and closer together when the camera is farther away, no matter the lens; a long lens is just how you stay in frame. |
| `subject-distance` | Camera-to-subject distance | Relate distance to background size and to how a face looks. |
| `wide-angle-distortion` | Wide-angle distortion | Explain why a close wide shot enlarges noses and stretches edges, and pick a lens and distance to avoid it. |
| `focal-length` | Focal length | Choose a focal length for a look and a space constraint. |
| `field-of-view` | Field of view | Read how much of the scene fits at a focal length; know that wide lenses show more. |

- **Should NOT need to learn here:** aperture, depth of field, sensor-size maths, crop factor (shown as a read-only "equivalent on your camera" chip only), lens design.

## 4. Why Unity (tier justification)
- **Signals (CLAUDE.md rubric):** *camera perspective is the concept* and *the learner must move something in a scene and watch the scene respond continuously*. The insight (compression follows camera position, not lens) is invisible in a still image because each still has one position and one lens baked in.
- **Closest native exercises:** `estimate-slider` ("how big will the mountain look?") and `visual-id` on authored pairs ("which was shot from farther away?"). They show a *result* but not the trade: walk back AND zoom in, subject stays put, background swells. A native 2D layered composite can scale planes but cannot render the nose-to-ear depth ratio of a real 3D face or respond to a learner-set target and constraint (a tiny room, a cliff edge).
- **Why not more sims for this concept:** one mechanic only (dolly + zoom under a framing lock). Static rules stay native (`cam-04`, `cam-05` estimate-sliders; the fallback below).
- **Native fallback lesson `cam-06-native`:** 4 `visual-id` (which shot was taken from farther away; which looks flatter) + 3 `estimate-slider` (subject distance for a given lens and framing, background size ratio) + 2 `binary-call`, on authored image pairs exported from this sim's scenes (license `original-swoond`). Complete on its own; used for accessibility and if the sim is unavailable.
- **Justification: strong.**

## 5. Player fantasy & core loop
- **Fantasy:** "You are holding the camera. The client wants a look. You have a zoom ring and legs."
- **Core loop:**
  1. Brief card: the look ("Make the mountain loom behind her"), a ghost frame showing how big the subject must be, and any limit (room wall, cliff edge, reach).
  2. Learner drags the **dolly** (camera walks toward or away from the subject) and turns the **zoom ring** (focal length, 14 to 200 mm with detents at 14, 24, 35, 50, 85, 135, 200). Frame updates live. **Auto-dolly** (a toggle) keeps the subject size fixed as the ring turns, so the learner *sees* only the background change.
  3. Learner taps **Shoot** (one decisive interaction).
  4. Execute: the shot is evaluated (framing, look, distortion, reach); the shutter blink.
  5. Freeze: an overlay compares the learner's frame to a "wrong-way" frame (same subject size from the opposite choice) with numbers (distance, focal length, background size), then the explanation and a line to say.
- **Session:** about 3 minutes, 3 rounds (default), up to 6.

## 6. Scene & entities
- **Environment:** `photo_stage` (procedural key; new, requested): a flat ground plane, a subject platform with a stylized figure or object, and a swappable **backdrop rig** at configurable distance (`backdrop` presets: `trees`, `wall-door`, `mountain-range`, `lamp-row`, `room-interior`, `ridge-layers`). Sky and ground are flat colours (no photographic textures).
- **Cameras:** `photo-rig` (the learner's camera; a Unity Physical Camera with sensor 36 x 24 mm, orientation per scenario), `overview` (top-down mini-map inset showing camera, subject, backdrop and frustum; the core "space" picture), `compare` (side-by-side after Shoot).
- **Entity table:**

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `stage` | `photo_stage` environment (new) | Ground, backdrop rig | backdrop kind, distance b (m), feature height B (m) |
| `subject` | `Character` (stylized bust or full figure) or `PhysicsObject` prop | The thing to frame | height h (m), face-depth offsets (nose 0.10 m ahead, ears 0.08 m behind) |
| `bgFeature` | procedural mesh | Mountain, trees, lamp posts, room wall | height B (m), distance b (m), count (lamps) |
| `cam` | `PhysicalCamera` (new; wraps Unity Physical Camera) | Learner's camera | F 14-200 mm, sensor mm, s (m), fixed height 1.5 m |
| `dolly` | `TouchController` drag + `Path` (camera track) | Camera position along the axis | s in [sMin, sMax]; snap ticks every 0.5 m |
| `zoomRing` | `TouchController` (radial drag or stepper) | Focal length | detents; continuous between |
| `ghostFrame` | `Highlight` overlay | Target subject height in frame | f target +- tolerance band |
| `overview` | `CameraRig` preset `top-down` | Mini-map | frustum wedge, distance labels via `DistanceRing` (GK-13) |
| `limits` | `Zone` | Room walls, cliff line, reach limit | drawn as a line on the mini-map |
| `look` | `Objective` (`frame_look`, sim-local) | Evaluates the shot | tolerances in section 11 |
| `explain`, `score`, `hint`, `replay` | kit | | |

- **Reused:** `CameraRig`, `Zone`, `Target`, `DecisionPoint`, `Highlight`, `Explanation`, `Score`, `Hint`, GK-13 `DistanceRing`, GK-19 camera presets (`top-down`, `side-on-tilted`).
- **New:** `photo_stage` environment; `PhysicalCamera` (focal length, sensor, exact field-of-view and thin-lens magnification maths; shared by all three photo sims); `Objective` type `frame_look` (sim-local). Reuse plan: `PhysicalCamera` and `photo_stage` are shared with `photo.focus.depth-of-field.v1` and `photo.light.direction-lab.v1`; a future cinematography or drone-shot course would reuse them.
- **Layout (portrait):**
```
+-----------------------+
|   brief card          |
+-----------------------+
|  live frame           |  <- camera view, ghost frame in gold
|  (top 55%)            |
+-----------------------+
|  mini-map (top-down)  |  <- camera, subject, backdrop, frustum
+-----------------------+
| [Dolly ----o---]      |
| ( zoom ring 14..200 ) |
| [Auto-dolly] [Shoot]  |
+-----------------------+
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Dolly | Drag horizontally, or tap +/- 0.5 m steppers | Dolly slider (or steppers) | slider thumb >= 44 pt; steppers 44 x 44 pt | Live frame and mini-map update; tick haptic each 0.5 m |
| Zoom | Drag the ring, or tap detent chips (14, 24, 35, 50, 85, 135, 200) | Zoom ring | ring >= 64 pt; chips 44 x 56 pt | Live frame; current mm numeral (Numeral serif) |
| Auto-dolly | Tap toggle | Chip | 44 x 88 pt | Toggle rose when on; subject size stays inside the ghost frame |
| Hint | Tap | "Hint" chip (levels 1 to 3) | 44 x 80 pt | Shows the feasible zoom range as a gold arc on the ring |
| Shoot | Tap | Primary pill | 56 pt | Shutter blink; light haptic |
| Next | Tap | Primary pill | 56 pt | |
- **Tap-only alternative (accessibility, always available):** steppers and detent chips replace drags; every value is spoken and shown as text.
- Portrait orientation; live frame top 55%. Native draws hearts, paywall and exit confirmation.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config; build stage; load scenarios | Ready/error | `ready` |
| Intro | ready | Brief card for round 1; ghost frame shown | Playing | `progress` |
| Playing | intro | Learner adjusts dolly and zoom; live metrics computed (not all shown) | Shoot tapped | none |
| Decision | Shoot | DecisionPoint records the final s, F and toggles; latency measured | Executing | none |
| Executing | decision | Shutter blink; evaluation (section 11 rules) | Freeze | none |
| Freeze | result | Time eases to 0; compare view: learner's frame vs "other way" frame; numerals count up | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card; optional "Show the other way" toggle | Next | `checkpoint round-N` |
| Summary | last round | Score count-up; three take-aways | Done | `progress 1.0` |
| Done | summary | `result`, `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze; on abort emit partial result | resume/end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Auto-dolly available | on by default | available | available | available, off by default | off |
| Ghost frame tolerance (subject fraction +-) | 0.10 | 0.08 | 0.06 | 0.05 | 0.04 |
| Live numeric readouts (s, F, background ratio) | all | all | s and F | F only | none |
| Feasible-zoom arc (hint) | drawn | on hint | on hint | on hint | none |
| Constraints per scenario | 1 (framing) | 1-2 | 2 | 3 | 3 plus a two-shot task |
| Two-shot (dolly zoom) scenarios | 0 | 0 | 1 of 3 | 1 of 3 | 2 of 3 |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Scenario pool tags | `basic` | `basic` | + `face` | + `space` | + `two-shot` |
- Default for `cam-06`: 2; `port-01`: 3; `rev-02`: 2 (config). L1 is passable by a true beginner with hints.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "photo.lens.compression-lab.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["compression-starter", "compression-portrait", "compression-mixed"], "default": "compression-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "autoDollyDefault": { "type": ["boolean", "null"], "default": null, "description": "Null = decided by difficulty." },
    "showReadouts": { "type": ["boolean", "null"], "default": null, "description": "Null = decided by difficulty." },
    "lensSet": { "type": "string", "enum": ["zoom-14-200", "phone-24-48-120"], "default": "zoom-14-200" },
    "orientation": { "type": "string", "enum": ["portrait", "landscape"], "default": "portrait" }
  }
}
```
Valid: `{ "seed": 7, "scenarioSetId": "compression-starter", "scenarioCount": 3 }`. Invalid configuration yields `CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/compression-lab-v1.json`, bundle `sim-photo-compression`. Sets: `compression-starter` = tags `basic`; `compression-portrait` = `face`; `compression-mixed` = all. Deterministic per seed (order and mirrored layout only; physics has no randomness).
- **N = 12 scenarios** (rounds x 4). Shape:
```json
{ "scenarioId": "cs-01", "subject": { "kind": "head", "heightM": 0.30, "depthNoseM": 0.10, "depthEarM": 0.08 },
  "backdrop": { "kind": "wall-door", "distanceM": 3.0, "featureHeightM": 2.4 },
  "frameHeightMm": 36, "target": { "subjectFraction": 0.55 },
  "limits": { "sMin": 0.5, "sMax": 6.0, "fMin": 14, "fMax": 200 },
  "look": { "distortionMax": 1.15 }, "tags": ["face"], "teaches": ["wide-angle-distortion", "subject-distance"] }
```
- **Maths (all deterministic, pure functions; `PhysicalCamera`):** frame height H (36 mm portrait, 24 mm landscape). Subject fraction f = (F x h / (s - F/1000)) / H, with F in mm, s and h in metres. Background fraction g = (F x B / (D - F/1000)) / H with D = s + b. Background size ratio R = (s - F/1000) / (s + b - F/1000) (1 = same scale as subject; smaller = background looks smaller and farther). Face distortion ratio = (s + depthEar) / (s - depthNose) (1.00 is flat; 1.20 is a visibly enlarged nose). Vertical field of view = 2 x atan(H / (2F)); horizontal edge-stretch flag when F < 18 mm (horizontal FOV over about 90 degrees on the 36 mm side).
- **Evaluation of Shoot:** pass if all hold: |f - target| <= tolerance(difficulty); look constraint(s) satisfied; s within [sMin, sMax] (the Zone); F within range; distortion <= `distortionMax` when set; edge-stretch flag false when `noEdgeStretch` is set.
- **Scenarios (all with computed feasible windows, sub-fraction target and `limits` as shown):**

| scenarioId | Setup | Look constraint | Feasible focal window (mm) | Teaches | Tags |
|---|---|---|---|---|---|
| `cs-01` | Head-and-shoulders (h 0.30 m), door wall 3 m behind, s 0.5 to 6 m, f 0.55 | distortion <= 1.15 | 81 to 200 (s 1.3 to 3.2 m) | `wide-angle-distortion`, `subject-distance` | face |
| `cs-02` | Full figure (h 1.7 m), mountain (B 600 m) 8 km behind, f 0.60, s 1 to 60 m | mountain fraction g >= 0.30 | 145 to 200 (s 11.5 to 16 m) | `perspective-compression`, `focal-length` | basic |
| `cs-03` | Group width 3.0 m in a small room, landscape, f 0.90 of the 24 mm side, s <= 3.4 m | no edge stretch (F >= 18) | 18 to 24 (s 2.5 to 3.4 m) | `field-of-view`, `focal-length` | space |
| `cs-04` | Two-shot dolly zoom: A is fixed at 24 mm; B must keep f 0.50 (+-tol) with the tree wall 25 m behind | g(B) / g(A) >= 2.5 | 72 to 200 (s 6.8 to 19 m) | `perspective-compression`, `subject-distance` | two-shot |
| `cs-05` | Product h 0.12 m (front-to-back 0.06 m), shelf 1.2 m behind, s 0.3 to 1.5, f 0.70 | distortion <= 1.10 | 110 to 200 (s 0.63 to 1.15 m) | `wide-angle-distortion` | face |
| `cs-06` | Lamp posts (h 5 m, five posts 10 m apart, so the farthest is 40 m behind the nearest), f 0.50 on the nearest | nearest-to-farthest size ratio >= 0.50 ("packed") | 144 to 200 (s 40 to 56 m) | `perspective-compression` | basic |
| `cs-07` | Same lamp row, f 0.50 | nearest-to-farthest size ratio <= 0.25 ("deep") | 14 to 47 (s 3.9 to 13 m) | `perspective-compression`, `field-of-view` | basic |
| `cs-08` | Room interior, width 4.2 m across the 36 mm side, standing in the doorway s <= 3.0 m, f 0.95 | no edge stretch | 18 to 24 (s 2.2 to 2.95 m) | `field-of-view` | space |
| `cs-09` | Choose-the-frame: two frames of the same face at the same size, A 24 mm at 0.45 m and B 85 mm at 1.8 m; pick the wide close-up | `choose_target` | n/a | `wide-angle-distortion` | face |
| `cs-10` | Dog head (h 0.25 m; snout 0.06 m ahead, ears 0.04 m behind), s 0.3 to 3, f 0.60 | distortion <= 1.15 | 58 to 200 (s 0.73 to 2.5 m) | `wide-angle-distortion`, `subject-distance` | face |
| `cs-11` | Phone lenses only (24, 48, 120 mm equivalent): head-and-shoulders (h 0.35 m), f 0.55, s 0.5 to 4 | distortion <= 1.20 | 120 only (48 mm fails at s 0.9 m, ratio 1.23) | `wide-angle-distortion`, `focal-length` | face |
| `cs-12` | Reverse dolly zoom: A fixed at 135 mm; B keeps f 0.50 with tree wall 25 m behind | g(B) / g(A) <= 0.35 | 18 to 35 (s 1.7 to 3.3 m) | `perspective-compression`, `field-of-view` | two-shot |
- **Generation rule (for more scenarios):** pick subject h and target f; choose a look (background fraction range, size-ratio range, or distortion cap) and limits; solve F from s = F x h / (f x H) + F/1000 over the F range; require a feasible window whose Fmax / Fmin is at least 1.3 (or that spans at least one detent) at L1 to L3 (narrower allowed at L4 to L5); no scenario may have its window depend on hitting an exact number.

## 12. Freeze / explain moments
Voice: cheeky coach, never mean. Titles <= 6 words; bodies <= 45 words.

| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-good-tele` | Passed with F >= 85 on a `face` or compression scenario | Compare view: learner frame vs a 24 mm frame at the same subject size; numerals for distance | Correct | Nice read. Stand back. | Same size on her, different everything else. From farther away the background grows and her face flattens. The long lens did not squash anything; your feet did the work. | "It's not the lens that compresses, it's how far back you stand." |
| `x-good-wide-space` | Passed on a `space` scenario | Mini-map with wall line; frustum wedge | Correct | Nice read. Wide for tight rooms. | When you cannot back up, a wider lens is how you fit everyone. Just stay off 14 mm faces near the edges, where things stretch. | "I went wide because the room ran out." |
| `x-good-dollyzoom` | Passed a two-shot | Two frames side by side, subject same size, background changed | Correct | Nice read. That is the dolly zoom. | You kept her size and changed only where you stood and how far you zoomed. The background swelled (or shrank). Film directors use this for a queasy "vertigo" feeling. | "That's a dolly zoom. Same subject, different world behind." |
| `x-bad-wide-face` | Failed by distortion (s too small) | Nose-to-ear numeral (for example 1.45) and a flat 85 mm comparison | Incorrect | Not quite. Too close, too wide. | At this distance the nose is much closer to the lens than the ears, so it looks bigger. Step back and zoom in for the same framing and everything sits properly. | "Wide and close makes noses big. Back up." |
| `x-bad-frame` | Failed by framing (subject size outside band) | Ghost frame gold vs learner's subject height rose | Incorrect | Not quite. The frame was off. | The brief needed her about this size. Zoom and distance both change size; use one, then the other. Turning on Auto-dolly holds her size while you play. | "Size is zoom and distance together." |
| `x-bad-background` | Failed by background look | Background fraction numeral vs target | Incorrect | Not quite. Wrong background. | Background size is set by distance, not zoom alone. To make the mountain loom, walk back and zoom in; to make it small, come in close and go wide. | "Walk back, zoom in: the mountain grows." |
| `x-bad-reach` | Failed by limit (out of room) | Limit line on mini-map | Incorrect | Not quite. You ran out of room. | This spot only lets you back up so far. Once you hit the wall, a longer lens will not save the framing; go wider. | "The room decided the lens." |
| `x-choose-good` | `cs-09` correct | Two frames with nose-ear numerals | Correct | Nice read. That's the wide one. | Bigger nose, stretched edges and more background: the close wide-angle shot. The 85 mm frame is calmer because it was taken from farther away. | "That one was shot close with a wide lens." |
| `x-choose-bad` | `cs-09` incorrect | Same | Incorrect | Not quite. Look at the nose. | Wide and close exaggerates whatever is nearest the lens, so the bigger nose gives it away. The calmer frame is the longer lens from farther back. | "Look at the nose to spot the wide shot." |
| `x-timeout` | Round timer expired (L5 only, optional) | Auto Shoot at current state | Timeout | Time's up. Let's look. | We took the shot as you had it. The explanation shows what would have worked. | "Distance and zoom, together." |

## 13. Scoring & mastery signals
- **Round points:** 1.0 if all constraints pass; 0.6 if only the look passes but framing is within 1.5x tolerance (acceptable); 0.0 otherwise. Each hint -0.1 (floor 0.4 for a pass). Two-shot scenarios score on both shots (mean).
- **accuracy** = rounds with points >= 0.6 / rounds. **Outcome success** = points >= 0.6.
- **Mistake -> conceptId:**

| Mistake | conceptId | Description |
|---|---|---|
| Face distortion over the cap | `wide-angle-distortion` | Shot a face too close with a wide lens. |
| Framing outside tolerance | `subject-distance` | Did not balance zoom and distance to hold the subject size. |
| Background look missed | `perspective-compression` | Expected zoom alone, not distance, to change the background. |
| Hit a limit | `focal-length` | Chose a lens that did not fit the space. |
| Field-of-view constraint missed (edge stretch, room) | `field-of-view` | Picked a focal length that shows too little or stretches the edges. |
| `choose_target` wrong | `wide-angle-distortion` | Could not tell the wide close-up from the long-lens frame. |
- **Mastery signals:** pass on a `face` scenario -> `wide-angle-distortion` +0.20, `subject-distance` +0.10; pass on `basic` compression scenario -> `perspective-compression` +0.20; pass on `two-shot` -> `perspective-compression` +0.20, `subject-distance` +0.15; pass on `space` -> `field-of-view` +0.20, `focal-length` +0.10; mistakes -0.15 to the mapped concept; caps +-0.30 per concept per session; hints halve positives (native applies).
- **Result mapping:** `outcomes[]` (`round-N`, success, label = scenarioId, `value` = `{F, s}`), `mistakes[]`, `masterySignals[]`.

## 14. XP & hearts
+10 per successful round, +40 for finishing (native clamps to lesson budget). `heartsLost` = 1 if accuracy < 0.34, max 1 per session. `replayAvailable` true (re-run the compare view).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain card with the "other way" frame | outcome false, mistake recorded | none |
| Failed session | "This one needs a new eye. Have another go." | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout (L5 optional) | Auto shoot plus explain | flagged | none |
| Abort / backgrounded | native | `aborted`, xp 0 | none |
| Asset / config error | native error with the native fallback offered | `error` | none |

## 16. Accessibility
- **Reduced motion:** the freeze is a hard cut; no camera sweeps; shutter blink replaced by a 1 frame flash cross-fade; the compare view appears without slide.
- **Haptics:** honour `hapticsEnabled`.
- **Colour-blind:** frame guides use shape and label ("TARGET SIZE"), rose vs gold also differ by dashed vs solid; the mini-map uses distinct icons for camera, subject, backdrop; no red/green.
- **Text scale:** honoured; all numerals in Numeral serif with units.
- **Tap-only:** yes (steppers and detent chips).
- **VoiceOver / TalkBack:** Unity content is limited: every control has a label and a spoken value, but the *image* is not accessible. Native fallback `cam-06-native` (authored pairs with full `alt` text and numeric readouts) is the accessible equivalent and is offered from the sim's intro screen.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Dolly tick (0.5 m) | Soft wooden tick | tick |
| Zoom detent | Barrel click | light tap |
| Shoot | Original synthesised shutter | light tap |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
| Freeze | Low hush | soft tap |
All honour `soundEnabled` and `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural or external | Source & license | Budget | Notes |
|---|---|---|---|---|
| Stage, ground, sky | Procedural | `original-swoond` | < 2k tris | Flat colours |
| Subject figure, head bust, dog, product | Procedural low-poly | `original-swoond` | < 3k tris each | Face has nose and ear depth for the distortion cue |
| Backdrops (trees, wall-door, mountain, lamp row, room, ridges) | Procedural | `original-swoond` | < 4k tris each | Mountain is a stylised silhouette mesh |
| Overlays (ghost frame, mini-map, arcs, numerals) | Procedural | n/a | n/a | Art direction section 4 |
| Audio | Synthesised | `original-swoond` | <= 1 MB | |
Bundle `sim-photo-compression`, <= 6 MB.

## 19. Performance budget
Defaults apply (60 fps, < 150 MB); tighter: memory < 110 MB; no post-processing depth-of-field in this sim; cold launch < 2 s; draw calls <= 100.

## 20. Telemetry
Standard plus `hintsUsed`, `decisionLatencyMsMedian`, `autoDollyUsed` (bool), `dollyMovesPerRound`, `zoomMovesPerRound`, `limitHits`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 7, difficulty 2, 3 rounds: exactly 3 `outcomes`; deterministic across runs.
2. **AC-2:** `PhysicalCamera.SubjectFraction(F, s, h, H)` matches the table maths to +-0.005 for all 12 scenarios' feasible-window endpoints (golden fixtures).
3. **AC-3:** The evaluator returns pass for the feasible-window endpoints and fail for one step outside, for each scenario (fixtures).
4. **AC-4:** Unity Physical Camera vertical field of view equals 2 x atan(H / (2F)) +-0.1 degrees for each detent.
5. **AC-5:** With Auto-dolly on, subject fraction stays within +-0.01 of target while F sweeps 14 to 200.
6. **AC-6:** Face distortion ratio matches the formula at s in {0.5, 0.8, 1.0, 1.3, 2, 3} m to +-0.005 (values 1.45, 1.26, 1.20, 1.15, 1.09, 1.06).
7. **AC-7:** `ready` < 2 s; exactly one schema-valid `result`; `requestExit` after.
8. **AC-8:** Abort yields `aborted=true`, xp 0, partial outcomes.
9. **AC-9:** Invalid config yields `CONFIG_INVALID`; `lensSet` `phone-24-48-120` restricts F to the three detents.
10. **AC-10:** Copy lint: titles <= 6 words, bodies <= 45 words, no emoji, all `Say this` lines in quotes.
11. **AC-11:** Reduced-motion path: no sweeps, no shake; second-channel guides present (colour-blind snapshot test).
12. **AC-12:** Perf p5 >= 50 fps; memory < 110 MB on iPhone 13-class.
13. **AC-13:** Mastery deltas respect +-0.30 per concept cap.

## 22. Test plan
- **EditMode:** `PhysicalCamera` maths, evaluator fixtures per scenario, feasible-window solver, config validation, scoring, seed determinism, copy lint, result schema validity.
- **PlayMode:** scene builds from code; scripted run (set s and F to a feasible pair, Shoot); freeze and explain sequence; pause/resume/abort; reduced motion; auto-dolly hold.
- **Perf:** iPhone 13-class measured run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Compression` |
| AC-2, AC-3, AC-6 | EditMode | `PhysicalCamera_Fixtures`, `Evaluator_Fixtures`, `FaceDistortion_Fixtures` |
| AC-4, AC-5 | PlayMode | `Fov_Detents`, `AutoDolly_Hold` |
| AC-7, AC-8 | PlayMode | `Launch_Result`, `Abort_Result` |
| AC-9 | EditMode | `Config_Invalid`, `LensSet_Phone` |
| AC-10 | EditMode | `Copy_Lint` |
| AC-11 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-12 | Perf | `Perf_iPhone13` |
| AC-13 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | `PhysicalCamera`, `photo_stage`, `frame_look` objective: accept as new kit items (shared by all three photo sims)? | Astra | Yes |
| 2 | The face distortion ratio uses a simple nose/ear depth model; is that plausible enough for an SME (portrait photographer) review before approval? | Product / SME | No |
| 3 | Should L1 default to Auto-dolly on, or to off with a hint? Proposed: on. | Product | No |
| 4 | Stylised head: how to make nose and ear depth legible without caricature? | Astra | No |
| 5 | Show "equivalent on your camera" (crop factor) chip, driven by `equipment` personalization? Proposed: read-only chip only when the native app supplies a sensor size. | Claude / Product | No |

### Game Kit additions requested
- **`PhysicalCamera`** (new, shared): focal length, sensor size, orientation, exact vertical/horizontal FOV, thin-lens subject and background fractions; wraps Unity's Physical Camera; proposed **GK-21**.
- **`photo_stage` environment key** with backdrop rig presets; proposed registry addition.
- **`frame_look` objective type** (sim-local unless reused); alias for a `choose_target`-style evaluation on `cs-09` (GK-12).
- Reuse: GK-13 `DistanceRing` (distance labels), GK-19 `CameraRig` presets (`top-down`, `side-on-tilted`).
