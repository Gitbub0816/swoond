# Depth of Field Lab (`photo.focus.depth-of-field.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `photo.focus.depth-of-field.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (scenario-driven) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `photography`; `unitId` `focus-and-depth` (lesson `foc-04`, primary, difficulty 2); `branch-portrait` (`port-03`, difficulty 3, eyes and isolation set); `branch-wildlife` (`wild-05`, difficulty 3, bird and background set).
- CDS row: section 12, "`foc-04`, `port-03`, `wild-05`: depth of field". Manifest: `unitySimulations[1]`.
- Prerequisite concepts: `aperture`, `f-number`, `focal-length`, `autofocus-modes`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can choose aperture, focus point and lens to make the background melt away, or to keep everyone sharp, and say why."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `depth-of-field` | Depth of field | Predict whether a zone will look sharp from aperture, distance and lens. |
| `aperture` | Aperture | Say a wider aperture (small f-number) gives a thinner slice of sharpness and more blur. |
| `focus-distance` | Focus distance | Place focus on the right thing; know that closer focus makes the sharp slice thinner. |
| `subject-isolation` | Subject isolation | Separate a subject from its background with distance, lens and aperture together. |
| `hyperfocal` | Hyperfocal focus | Focus so near and infinity are both acceptably sharp. |
| `bokeh` | Bokeh | See that blur discs grow with lens length and aperture width and with background distance. |
| `diffraction` | Diffraction | Know that very small apertures soften the whole picture. |
| `zone-focusing` | Zone focusing | Prefocus and stop down to cover a range. |

- **Should NOT need to learn here:** the circle-of-confusion formula (shown as a "blur size" bar, never as algebra), lens optical design, exposure (a note says "exposure is handled; the sim holds brightness constant").

## 4. Why Unity (tier justification)
- **Signals:** *spatial reasoning* (positions of foreground, subject and background along the lens axis), *camera perspective* (moving the camera and changing lens changes framing, parallax and blur together) and *live cause-and-effect* over four to five interacting variables.
- **Closest native:** `visual-id` on authored image pairs and `estimate-slider` ("how wide is the sharp zone?"). Depth of field depends on aperture (9 stops), focal length (6), camera distance, focus point and background distance; a native grid of authored images is combinatorially huge (at least 300 images per scene). A native 2D layered-blur composite works only for a fixed camera and fails when the learner moves the camera (which is the point of the lesson: with framing held constant, longer lens plus more distance changes blur). The Unity scene computes blur from the same analytic formula the lesson teaches and renders discs, so background lights become real bokeh circles.
- **Native fallback `foc-04-native`:** 4 `visual-id` (which frame used the wider aperture; who is sharp), 3 `estimate-slider` (sharp zone in centimetres for a described setup; hyperfocal distance), 2 `hotspot-tap` on a distance-scale diagram (tap the sharp zone), on authored pairs exported from this sim (`original-swoond`).
- **Justification: strong**, second only to compression.

## 5. Player fantasy & core loop
- **Fantasy:** "You are behind the lens. You decide what is crisp and what dissolves."
- **Core loop:**
  1. Brief card ("Make the wall behind her disappear"), with a **sharp-zone bar** (side-on distance scale; actors as ticks) visible according to difficulty.
  2. Learner sets **aperture** (a dial of f-stops), **focal length** (detent chips), **focus** (tap an actor in the live view, or turn the focus ring), and, where allowed, **camera distance** (dolly). By default the sim holds the subject size constant (framing lock; turning the lens changes distance automatically, as a photographer would).
  3. Learner taps **Shoot** (the decisive interaction).
  4. Execute: evaluation; shutter blink.
  5. Freeze: the frame is shown with a "blur map" toggle (false-colour of blur size) and the sharp-zone bar; explanation; line to say.
- **Session:** about 3 minutes, 3 rounds (default), up to 6.

## 6. Scene & entities
- **Environment:** `photo_stage` (shared, new): ground plane and a **depth rig** placing up to four actors along the camera axis at scenario-defined distances; the background is a wall (`wall`), a hedge with point lights (`city-lights`), a mountain silhouette at infinity (`vista`), or a cluttered desk (`clutter`).
- **Cameras:** `photo-rig` (learner), `side-on` (a distance-scale side view used in the explain step), `overview` (top-down mini-map).
- **Entity table:**

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `stage` | `photo_stage` | Ground, backdrop | backdrop kind |
| `actors[]` | `Character` / props | Things at distances u_i | role tag (`subject`, `eye-near`, `eye-far`, `front`, `back`, `lights`), id, u_i |
| `cam` | `PhysicalCamera` (shared, new) | Learner camera | F, N, focus s, sensor preset, framing lock |
| `dof` | `DepthOfFieldPass` (new) | Post pass computing blur per pixel analytically and rendering discs | c0 by sensor preset; half-resolution; 24-tap disc |
| `apertureDial` | `TouchController` (discrete dial) | Aperture | stops 1.4 to 22 (sets offered per difficulty) |
| `focusTap` | `Target` per actor | Focus selection | selects s = u_i |
| `focusRing` | `TouchController` | Continuous focus | 0.3 m to infinity |
| `dofBar` | `TraceChart` variant `dof_scale` (GK-16) | Distance scale with sharp band | ticks, near/far limits, hyperfocal |
| `zone` | `Zone` | Sharp zone (near..far) drawn on the mini-map | translucent gold |
| `goal` | `Objective` (`dof_goal`, sim-local) | Evaluate isolate / include / hyperfocal / zone / eyes / sweet-spot | see section 11 |
| `explain`, `score`, `hint`, `replay` | kit | | |
- **Reused:** GK-16 `TraceChart`, GK-13 `DistanceRing`, GK-12 `choose_target` for focus tapping, GK-19 presets (`side-on-tilted`, `top-down`), `Highlight`, `Explanation`, `Score`, `Hint`, `Zone`.
- **New:** `DepthOfFieldPass` (custom URP renderer feature, analytic CoC), `PhysicalCamera` and `photo_stage` (shared with the other two photo sims), objective `dof_goal`; demonstrate type `dof_scale`. Justification: Unity's stock depth-of-field volume does not expose circle-of-confusion in learner-facing units, and its model differs by mode; a custom analytic pass keeps the lesson maths and the picture identical (testable, AC-3). Reuse plan: any future macro, product-photo or cinematography lesson.
- **Layout (portrait):**
```
+-------------------------+
| brief card              |
+-------------------------+
|   live frame            |
|   (top 50%)             |
+-------------------------+
| sharp-zone bar (side)   |   subject tick, background tick, gold band
+-------------------------+
| ( f/1.4 ... f/22 dial ) |
| [24][35][50][85][135]   |
| [Focus: tap actor/ring] |
|            [ Shoot ]    |
+-------------------------+
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Aperture | Drag dial or tap +/- stepper | Dial | dial >= 64 pt; steppers 44 x 44 | Blur updates live; click haptic per stop |
| Focal length | Tap chips | Chip row | 44 x 56 pt each | Framing lock moves the camera; live |
| Focus | Tap an actor in the live view, or drag the ring | Actor `Target` (>= 44 pt halo) or ring | 44 pt | Focus reticle snaps; bar tick turns rose |
| Framing lock | Tap toggle | Chip | 44 x 88 | Off lets the learner dolly |
| Dolly (lock off) | Drag slider or steppers | Slider | 44 pt | Mini-map updates |
| Blur map (freeze) | Tap toggle | Chip | 44 x 88 | False colour with shape hatching |
| Hint | Tap | Chip (levels 1 to 3) | 44 x 80 | Highlights the sharp band or the needed change |
| Shoot / Next | Tap | Primary pill | 56 pt | |
- **Tap-only alternative:** steppers, chips and actor tap-focus replace the dial and ring drags; continuous focus ring offered as stepper (10 cm steps).
- Portrait. Native draws hearts, paywall, exit confirmation.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config; build stage; compile blur pass; load scenarios | Ready/error | `ready` |
| Intro | ready | Brief card; bar shown per difficulty | Playing | `progress` |
| Playing | intro | Learner sets N, F, focus (and s when unlocked); blur live | Shoot | none |
| Decision | Shoot | Record settings and latency | Executing | none |
| Executing | decision | Evaluation (section 11); blink | Freeze | none |
| Freeze | result | Ease to 0; blur map toggle; sharp-zone bar with limits; numerals count | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card; optional "what one change fixes it" preview | Next | `checkpoint round-N` |
| Summary | last | Score count-up | Done | `progress 1.0` |
| Done | summary | `result`, `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze; partial result on abort | resume/end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Apertures offered | 1.4, 2.8, 5.6, 11 | 1.4 to 16 (7 stops) | 1.4 to 22 (9 stops) | 9 stops | 9 stops |
| Focal lengths offered | 2 | 3 | 5 | 6 | 6 |
| Sharp-zone bar | live, labelled | live | live, unlabelled | on hint | off |
| Blur numerals ("blur x") | yes | yes | freeze only | freeze only | freeze only |
| Focus method | tap only | tap only | tap or ring | ring | ring |
| Framing lock | on (locked) | on | on, toggle | toggle | off |
| Objective types in pool | `isolate` | + `include` | + `eyes`, `hyperfocal` | + `zone`, `sweet-spot` | + `include-and-isolate`, `phone` |
| Diffraction and softness modelled | no | no | note only | scored | scored |
| Hints | 3 | 2 | 1 | 0 | 0 |
- Default for `foc-04`: 2; `port-03`: 3; `wild-05`: 3 (config).

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "photo.focus.depth-of-field.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["dof-starter", "dof-portrait", "dof-wildlife", "dof-mixed"], "default": "dof-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "sensorPreset": { "type": "string", "enum": ["full-frame", "aps-c", "micro-four-thirds", "phone"], "default": "full-frame" },
    "framingLock": { "type": ["boolean", "null"], "default": null, "description": "Null = decided by difficulty." },
    "showSharpZoneBar": { "type": ["boolean", "null"], "default": null, "description": "Null = decided by difficulty." },
    "modelSoftness": { "type": ["boolean", "null"], "default": null, "description": "Apply wide-open and diffraction softness in scoring. Null = decided by difficulty." }
  }
}
```
Valid: `{ "seed": 11, "scenarioSetId": "dof-starter", "scenarioCount": 3, "sensorPreset": "full-frame" }`. Invalid configuration yields `CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/dof-v1.json`, bundle `sim-photo-dof`. Sets: `dof-starter` = tags `basic`; `dof-portrait` = `face`; `dof-wildlife` = `bird`, `basic`; `dof-mixed` = all. Deterministic per seed (order and mirrored layout).
- **N = 12 scenarios.** Shape:
```json
{ "scenarioId": "ds-01", "sensor": "full-frame",
  "actors": [ { "id": "subject", "role": "subject", "distanceModel": "cameraToSubject" }, { "id": "wall", "role": "back", "behindSubjectM": 1.5 } ],
  "framing": { "lock": true, "subjectHeightM": 0.30, "targetFraction": 0.55, "frameHeightMm": 36 },
  "camera": { "sRange": [0.6, 8.0], "fOptions": [50, 85, 135, 200] },
  "goal": { "type": "isolate", "subjectSharp": true, "backgroundBlurRatioMin": 12 },
  "tags": ["face"], "teaches": ["subject-isolation", "aperture"] }
```
- **Maths (pure functions, `PhysicalCamera` / `DepthOfFieldPass`):** blur diameter on the sensor for an object at distance u with focus at s: c(u) = F^2 / (N x (s x 1000 - F)) x |u - s| / u (mm; s and u in metres, F in mm; for u at infinity, c = F^2 / (N x (s x 1000 - F))). Acceptable blur c0 by sensor: full-frame 0.030 mm, APS-C 0.020, Micro Four Thirds 0.015, phone 0.008. "Sharp" means c <= c0. **Blur ratio** = c / c0. Hyperfocal H = F^2 / (N x c0) + F (mm). Near limit = s(H - F) / (H + s - 2F); far limit = s(H - F) / (H - s), infinity when s >= H. Under framing lock the camera distance is s_cam = F x h / (f x frameHeight) + F/1000 (metres), so lens changes move the camera. Wide-open and diffraction softness (used when `modelSoftness`): lens sharpness factor by stop = f/1.4 0.80, f/2 0.90, f/2.8 0.96, f/4 1.00, f/5.6 1.00, f/8 1.00, f/11 0.94, f/16 0.86, f/22 0.74.
- **Goal types:** `isolate` (subject sharp; each background actor blur ratio >= K), `include` (all listed actors sharp), `include-and-isolate` (listed actors sharp; background blur ratio >= K), `eyes` (both eyes, 0.08 m apart in depth, sharp), `hyperfocal` (near actor and infinity sharp, N <= 16 else diffraction flag), `zone` (a distance range sharp), `sweet-spot` (sharp and lens factor >= 0.99), `bokeh-discs` (background lights' disc diameter over frame height >= 0.012), `phone` (blur ratio >= K by getting close, or using portrait mode).
- **Scenarios and computed feasible windows (from the reference model; used as golden fixtures):**

| scenarioId | Setup | Goal | Feasible (F mm: f-numbers passing; s if locked) | Teaches | Tags |
|---|---|---|---|---|---|
| `ds-01` | Head (h 0.30 m, f 0.55, locked), wall 1.5 m behind, full-frame | `isolate` K >= 12 | 50: f/1.4 to 5.6 (s 0.81 m); 85: to f/8 (1.37 m); 135: to f/8 (2.18 m); 200: to f/11 (3.23 m) | `subject-isolation`, `aperture` | face |
| `ds-02` | Three people at c-1, c, c+1 with c = 3 m, camera fixed, F options 24, 35, 50, 85 | `include` | 24: focus 3 m at f/4 or smaller; 35: focus 3 m at f/8 or smaller; 50: f/16 focus 3 m; 85: no setting works | `depth-of-field`, `focus-distance` | basic |
| `ds-03` | Flower at 1.0 m and mountain at infinity, F 24, 35, 50, focus ring | `hyperfocal` | 24: f/11 to f/22, focus about 1.8 m (H = 1.77 m at f/11); 35: f/22 only, focus about 2.0 m; 50: none | `hyperfocal`, `diffraction` | basic |
| `ds-04` | Three-quarter face: near eye at s, far eye 0.08 m behind (locked, head h 0.30 m, f 0.55) | `eyes` | Focus between the eyes: f/5.6 and smaller at every F; focus on the near eye: f/11 and smaller | `depth-of-field`, `aperture` | face |
| `ds-05` | Street: cover 2.5 to 6.0 m, camera fixed, F 24, 35, 50, focus ring | `zone` | 24: f/2.8 (focus 3.5 m) or smaller; 35: f/5.6 (focus 3.5 m) or smaller; 50: f/11 (focus 3.5 m) or smaller | `zone-focusing`, `depth-of-field` | basic |
| `ds-06` | Bird at 12 m, branch 1 m in front, background 25 m behind the bird, F 135 or 200 | `isolate`, K >= 3 on both | 200: f/1.4 to f/2.8; 135: f/1.4 only | `subject-isolation`, `bokeh` | bird |
| `ds-07` | Product (depth 0.06 m) on a cluttered desk with clutter 0.8 m behind; locked h 0.15 m, f 0.60 | `include-and-isolate`, K >= 8 | 85 and 135: f/16 and f/22 (f/22 flagged for diffraction) | `depth-of-field`, `diffraction` | basic |
| `ds-08` | Phone (sensor `phone`, F 6.9 mm, f/1.8): subject at s, background 4.5 m behind | `phone` K >= 6 | Get to about 0.5 m or closer (blur ratio 6.0 at 0.5 m); or tap Portrait mode (acceptable) | `subject-isolation`, `depth-of-field` | basic |
| `ds-09` | Two people 0.35 m apart in depth; camera 1.5 to 3 m; F 35, 50, 85 | `include` | e.g. 35 at 2 m: f/2.8 or smaller; 85 at 1.5 m: only f/22; farther is easier | `depth-of-field`, `focus-distance` | face |
| `ds-10` | Rock at 3 m and mountain at infinity, F 24, 35, 50 | `hyperfocal` | 24: f/4 to f/22 (focus about 4.9 to 5 m at f/4); 35: f/8 to f/22; 50: f/16 to f/22 (f/22 flagged) | `hyperfocal`, `diffraction` | basic |
| `ds-11` | A flat picture on a wall, all at 2 m, F 50 | `sweet-spot` (`modelSoftness` forced on) | Best f/4, f/5.6, f/8; acceptable f/2.8, f/11; poor f/1.4, f/16, f/22 | `aperture`, `diffraction` | basic |
| `ds-12` | Full figure (h 1.7 m, f 0.60, locked), city lights 30 m behind, F 85, 135, 200 | `bokeh-discs` disc >= 0.012 of frame height | 85: f/1.4 to f/2 (s 6.8 m); 135: f/1.4 to f/2.8 (10.8 m); 200: f/1.4 to f/2.8 (15.9 m) | `bokeh`, `aperture` | basic |
- **Generation rule:** pick a goal; solve feasible windows with the maths above over the offered F and N grid; require at least two passing (F, N) combinations at L1 to L3; no window may depend on an exact focus distance finer than 0.1 m.

## 12. Freeze / explain moments
Voice: cheeky coach, never mean. Titles <= 6 words; bodies <= 45 words.

| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-isolate-good` | `isolate` passed | Blur map: subject cool, background hot; sharp-zone bar with subject inside, wall outside | Correct | Nice read. Sharp here, soft there. | The sharp slice was thin and sat on her. The wall was outside it, so it dissolved. Wider aperture, longer lens and a farther background all thin the slice or melt the wall. | "Wide open and a long lens melts the background." |
| `x-isolate-bad` | `isolate` failed (background too sharp) | Bar: wall tick inside the gold band | Incorrect | Not quite. The wall is still sharp. | The wall stayed inside the sharp slice. Open the aperture, use a longer lens, or move her farther from it. Any one of those helps. | "The background was inside the sharp zone." |
| `x-focus-miss` | Subject not sharp (focus on wrong actor) | Reticle on the wrong tick; subject blur numeral | Incorrect | Not quite. Focus landed elsewhere. | The sharp slice sits where you focus. You focused on something else, so she is soft. Tap her, or the eye, before you shoot. | "Focus goes where you put it, not where you look." |
| `x-include-good` | `include` passed | Bar: all ticks inside band; near and far limits | Correct | Nice read. Everyone inside. | Stopping down or going wider widened the sharp slice, and focusing near the middle put both ends inside. That is how you keep a group crisp. | "Stop down and focus in the middle for groups." |
| `x-include-bad` | `include` failed | Bar with a tick outside; near and far limits labelled | Incorrect | Not quite. Someone fell out. | One person sat outside the sharp slice. Stop down, use a wider lens, or step back. Focus a little in from the nearest person, not on them. | "Someone was outside the sharp zone." |
| `x-eyes-good` | `eyes` passed | Both eye ticks in band | Correct | Nice read. Both eyes crisp. | With her face turned, one eye is farther back. Stopping down a few stops or focusing between the eyes kept both inside the slice. | "I stopped down so both eyes were sharp." |
| `x-eyes-bad` | `eyes` failed | Far-eye tick outside | Incorrect | Not quite. One eye is soft. | The far eye fell outside a razor-thin slice. Focus on the near eye and stop down, or turn her so both eyes are the same distance from you. | "Turn her face or stop down: eyes need to match." |
| `x-hyper-good` | `hyperfocal` passed | Bar: near limit at the flower, far at infinity | Correct | Nice read. Near to infinity. | Focusing at the hyperfocal distance makes everything from half that distance to infinity acceptably sharp. Wide lens plus a mid aperture does the job. | "I focused at the hyperfocal distance." |
| `x-hyper-bad` | `hyperfocal` failed | Bar with flower or mountain outside | Incorrect | Not quite. Something is soft. | The flower or the mountains sat outside the sharp slice. Go wider, stop down to about f/11, and focus a little past the flower. | "Wide lens, f/11, focus a bit past the near thing." |
| `x-diff` | Passed only at f/22 | Note bar with softness factor | Acceptable | Fine, but that costs sharpness. | Very small apertures scatter light and soften the whole picture, so the sharp zone is wide but nothing is truly crisp. Prefer about f/8 to f/11 where you can. | "f/22 is deep but a bit soft." |
| `x-sweet` | `sweet-spot` best | Chart of sharpness vs stop | Correct | Nice read. The sweet spot. | Lenses are usually sharpest a couple of stops down from wide open and before diffraction bites. For a flat subject you do not need depth, so pick the crispest stop. | "Wide open isn't the sharpest; f/5.6 to f/8 often is." |
| `x-bokeh` | `bokeh-discs` passed | Zoomed lights as soft discs | Correct | Nice read. Big soft discs. | Point lights blur into discs. Longer lens plus wider aperture makes each disc bigger. That is why night portraits with a fast telephoto glow. | "Long lens, wide aperture: big bokeh circles." |
| `x-phone` | `phone` passed by moving close | Bar with blur numerals for the small sensor | Correct | Nice read. Close makes blur. | A phone sensor is tiny, so its background is nearly always sharp. Moving close to the subject is the physical trick; portrait mode fakes it with a depth map and software blur. | "Phone blur needs closeness, or software." |
| `x-phone-mode` | Portrait mode used | Same, with "computed blur" tag | Acceptable | Fine, but that blur is computed. | Portrait mode estimates depth and blurs it in software. It is convenient, but edges around hair can go wrong, and it is not the same as a big sensor and lens. | "Portrait mode fakes it with software." |
| `x-timeout` | L5 optional timer | Auto Shoot | Timeout | Time's up. Let's look. | We shot it as you had it. The explanation shows what would have worked. | "Aperture, focus and distance together." |

## 13. Scoring & mastery signals
- **Round points:** 1.0 if the goal passes (and, when `modelSoftness`, best-band factor); 0.6 acceptable (goal passes but flagged for diffraction or wide-open softness); 0.0 otherwise. Hint -0.1 each (floor 0.4 for a pass). `phone` with portrait mode = 0.6.
- **accuracy** = rounds with points >= 0.6 / rounds. **Outcome success** = points >= 0.6.
- **Mistake -> conceptId:**

| Mistake | conceptId | Description |
|---|---|---|
| Subject soft (wrong focus) | `focus-distance` | Focused on the wrong thing. |
| Background too sharp for `isolate` | `subject-isolation` | Did not separate the background. |
| Someone outside the sharp zone (`include`, `eyes`, `zone`) | `depth-of-field` | Sharp zone did not cover the subjects. |
| Near or far thing soft for `hyperfocal` | `hyperfocal` | Focus and aperture did not cover near to infinity. |
| Passed only at f/22 or wide open on `sweet-spot` | `diffraction` | Ignored softness at the extremes. |
| Bokeh discs too small | `bokeh` | Did not use longer lens or wider aperture. |
| Zone missed | `zone-focusing` | Prefocus did not cover the range. |
| Wide aperture chosen for a group | `aperture` | Aperture did not match the depth needed. |
- **Mastery signals:** `isolate` pass -> `subject-isolation` +0.20, `aperture` +0.10; `include` pass -> `depth-of-field` +0.20, `focus-distance` +0.10; `eyes` pass -> `depth-of-field` +0.20; `hyperfocal` pass -> `hyperfocal` +0.20, `diffraction` +0.05; `zone` pass -> `zone-focusing` +0.20; `sweet-spot` best -> `aperture` +0.10, `diffraction` +0.15; `bokeh-discs` pass -> `bokeh` +0.20; mistakes -0.15 to mapped concept; cap +-0.30 per concept per session; hints halve positives (native).
- **Result mapping:** `outcomes[]` (`round-N`, success, label = scenarioId, `value` = `{F, N, s, focusActor}`), `mistakes[]`, `masterySignals[]`.

## 14. XP & hearts
+10 per successful round, +40 for finishing (native clamps). `heartsLost` = 1 if accuracy < 0.34, max 1. `replayAvailable` true (re-open the blur map for the last round).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain card with the sharp-zone bar and the one change that fixes it | outcome false, mistake | none |
| Failed session | "Depth takes practice. Another go?" | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout (L5 optional) | Auto shoot plus explain | flagged | none |
| Abort / backgrounded | native | `aborted`, xp 0 | none |
| Asset / shader compile error (blur pass unsupported) | Native error and the native fallback lesson offered automatically | `error` | none |

## 16. Accessibility
- **Reduced motion:** freeze is a hard cut; no dolly sweeps when the framing lock moves the camera (jump cut instead); the blink is a one-frame flash.
- **Haptics:** honour `hapticsEnabled`.
- **Colour-blind:** blur map uses a two-channel scheme (colour plus hatching density: sharp = no hatching, blurry = dense hatch); ticks use distinct shapes (subject circle, background square, near eye triangle); rose vs gold also solid vs dashed; no red/green.
- **Text scale:** honoured.
- **Tap-only:** yes.
- **VoiceOver / TalkBack:** the live frame is not accessible; every control is labelled with spoken values ("aperture f/2.8, focal length 85 millimetres, focus on subject at 1.4 metres"), and the explain step reads the sharp-zone limits in words. Native fallback `foc-04-native` is the accessible equivalent, offered from the intro.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Aperture stop | Click | tick |
| Focus lock | Two-tone confirm | light tap |
| Shoot | Original synthesised shutter | light tap |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
| Freeze | Low hush | soft tap |
All honour `soundEnabled` and `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural or external | Source & license | Budget | Notes |
|---|---|---|---|---|
| Stage, ground, backdrops (wall, hedge with lights, vista, desk clutter) | Procedural | `original-swoond` | < 4k tris each | Point lights are emissive quads to get clean discs |
| Actors (figures, head, bird, branch, product) | Procedural low-poly | `original-swoond` | < 3k tris each | Bird is a stylised silhouette mesh |
| Blur pass shaders | Code | n/a | half-resolution, 24 taps | Must hold 60 fps on iPhone 13-class |
| Overlays (sharp-zone bar, blur map, reticle) | Procedural | n/a | n/a | Art direction section 4 |
| Audio | Synthesised | `original-swoond` | <= 1 MB | |
Bundle `sim-photo-dof`, <= 8 MB.

## 19. Performance budget
Defaults apply; tighter: memory < 130 MB; the blur pass <= 3 ms on iPhone 13-class at half resolution; draw calls <= 120; cold launch < 2 s; if the pass exceeds budget on a low-end device, drop taps to 12 and report `blurQuality: low` in telemetry.

## 20. Telemetry
Standard plus `hintsUsed`, `decisionLatencyMsMedian`, `stopsChanged`, `focusChanges`, `framingLockToggled`, `blurPassMsP95`, `blurQuality`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 11, difficulty 2, 3 rounds: exactly 3 `outcomes`; deterministic.
2. **AC-2:** The maths (`c(u)`, `H`, near and far limits) match golden fixtures to +-0.5% for 30 (F, N, s) triples, including infinity.
3. **AC-3:** The rendered blur pass matches the analytic blur diameter to within 15% at three depths for three (F, N, s) settings (measured on a test chart in a PlayMode render test).
4. **AC-4:** Each scenario's evaluator returns pass exactly for the tabled feasible windows and fail for one stop outside (fixtures for `ds-01` to `ds-12`).
5. **AC-5:** Under framing lock, changing F holds the subject fraction within +-0.01 of target.
6. **AC-6:** The sharp-zone bar's near and far limits equal the maths (+-1 cm within 3 m).
7. **AC-7:** `ready` < 2 s; one schema-valid `result`; `requestExit` after.
8. **AC-8:** Abort yields `aborted=true`, xp 0.
9. **AC-9:** Invalid config yields `CONFIG_INVALID`; `sensorPreset` changes c0 as tabled.
10. **AC-10:** Copy lint: titles <= 6 words; bodies <= 45 words; no emoji; say-this in quotes.
11. **AC-11:** Reduced-motion and colour-blind snapshots pass (hatching channel present).
12. **AC-12:** Perf p5 >= 50 fps and blur pass <= 3 ms p95 on iPhone 13-class; memory < 130 MB.
13. **AC-13:** Mastery caps respected; hint halving applied natively.

## 22. Test plan
- **EditMode:** blur maths fixtures, evaluator fixtures, framing-lock solver, sensor presets, scoring, determinism, config validation, copy lint, result schema.
- **PlayMode:** scene builds from code; scripted run for each goal type; render-based blur comparison (AC-3); freeze and explain; pause/abort; reduced motion.
- **Perf:** iPhone 13-class measured run; blur-pass GPU time capture.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Dof` |
| AC-2, AC-4, AC-6 | EditMode | `Coc_Fixtures`, `Evaluator_Fixtures`, `SharpZone_Limits` |
| AC-3, AC-5 | PlayMode | `BlurPass_MatchesAnalytic`, `FramingLock_Hold` |
| AC-7, AC-8 | PlayMode | `Launch_Result`, `Abort_Result` |
| AC-9 | EditMode | `Config_Invalid`, `SensorPreset_C0` |
| AC-10 | EditMode | `Copy_Lint` |
| AC-11 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-12 | Perf | `Perf_iPhone13`, `BlurPass_GpuMs` |
| AC-13 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is a custom analytic `DepthOfFieldPass` acceptable versus Unity's built-in depth-of-field volume? Proposed custom (test AC-3 needs the analytic link). | Astra | Yes |
| 2 | The 0.030 mm blur criterion is a viewing convention; teach "sharp enough for typical viewing", not a law. Approve the sensor-preset values? | Product / SME | No |
| 3 | Should `ds-08` show a Portrait-mode toggle at all (it teaches a fake)? Proposed yes, scored acceptable. | Product | No |
| 4 | Is 12 taps of disc blur enough on older devices? Fallback: half-res, 12 taps. | Astra | No |
| 5 | A "focus stacking" scenario (macro) is out of scope for v1; consider `.v2`. | Product | No |

### Game Kit additions requested
- **`DepthOfFieldPass`** (new): analytic circle-of-confusion blur with disc bokeh; proposed **GK-22**.
- **`PhysicalCamera`** and **`photo_stage`** (shared with the other photo sims; see `photo.lens.compression-lab.v1` section 23).
- **`dof_goal` objective** and **`dof_scale` demonstrate type** (a `TraceChart` variant, GK-16).
- Reuse: GK-12 `choose_target` (tap-to-focus), GK-13 `DistanceRing`, GK-19 camera presets.
