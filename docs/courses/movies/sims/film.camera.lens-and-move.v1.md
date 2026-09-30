# Zoom or Walk? (`film.camera.lens-and-move.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `film.camera.lens-and-move.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.x` (built against `1.0.0`); sim-definition `1.x` (scenarios are data; the lens model is new Game Kit code, not a pure data sim) |
| Authors / date | Movies course design agent (Sonnet), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `movies`. CDS row: `docs/courses/movies/CDS.md` section 12, "Lens and move (Tier A)".
- Manifest entry: `docs/courses/movies/manifest.json` -> `unitySimulations[]`.
- Launching lessons (each passes a `scenarioSetId` and default `difficulty`):

| unitId | lessonId | scenarioSetId | default difficulty |
|---|---|---|---|
| `reading-the-frame` | `fr-04` (Lenses and focus) | `lens-basics` | 1 |
| `motion-cut-and-sound` | `mc-01` (Moving the camera) | `camera-moves` | 2 |
| `motion-cut-and-sound` | `mc-02` (The dolly zoom) | `dolly-zoom` | 3 |
| `reel-review` | `rv-03` (Camera moves refresher) | `mixed-refresher` | learner-adaptive (2-4) |

- Prerequisite concepts: `shot-sizes` and `camera-angles` should be `mastered` (taught natively in `fr-01`, `fr-02`); otherwise `fr-04` shows a 30-second native primer first (native side).
- Accessible native path for the same concepts (this sim is not fully screen-reader accessible): lesson set `fr-04n` "Lenses without the scene" (`multiple-choice` + `visual-id` on original pre-rendered technique cards + `binary-call`) and `mc-01n` "Camera moves without the scene". These are alternates for `fr-04` / `mc-01` / `mc-02`, not extra units.

## 3. Learning objective(s) & concepts taught
- Learner-facing objective: "You can tell whether a shot got bigger because the camera moved or because the lens changed, and you can say what a long or wide lens does to the space in a picture."
- Concepts (all must exist in the movies curriculum `concepts[]`):

| conceptId | term | After this the learner can... |
|---|---|---|
| `focal-length` | Focal length | Say a longer lens magnifies and narrows the view; a shorter one widens it |
| `perspective-compression` | Compression | Say that with the subject held the same size, a long lens (camera farther back) makes the background look bigger and closer; a wide lens (camera closer) makes it look smaller and farther |
| `depth-of-field` | Depth of field | Say a longer lens (or bigger aperture) blurs the background more, isolating the subject |
| `deep-focus` | Deep focus | Say wide lenses keep near and far in focus |
| `camera-movement` | Camera movement | Tell a rotation (pan, tilt) from a movement through space (dolly, track, crane) |
| `dolly-shot` | Dolly shot | Say near objects shift faster than far ones (parallax) when the camera itself moves |
| `dolly-vs-zoom` | Dolly vs zoom | Tell a physical move from a lens change by watching whether near and far things change together |
| `dolly-zoom` | Dolly zoom | Say it holds the subject size while the background swells or falls away |

- Not taught here: exposure/aperture maths, sensor sizes, cinematography kit brand names, the story use of every move (that is native `mc-01` text), how to shoot one. No real films or frames appear.

## 4. Why Unity (tier justification)
Rubric (CLAUDE.md section 4):
- **Camera perspective is the concept.** A lens and a camera position are two independent things that both change "how big" a subject looks. Only a live camera over a fixed 3D scene separates them: the learner sees the subject stay the same size while the background changes (compression), and sees a dolly reveal parallax that a zoom cannot. This is exactly the "physics/camera perspective is the concept: Unity" row.
- **Movement in space.** Pan (rotation, no parallax), track (translation, parallax), crane (vertical translation) are only distinguishable by watching a scene change over time.
- **Why not native.** Closest native types: `visual-id` and `hotspot-tap` on static images. They teach *names* (used in `fr-01`, `fr-02`) but a still cannot show change over time, and real stills from films are unlicensed (spec section 40, rule 10). Pre-rendered before/after pairs would work for one fixed scene but cannot vary by seed, cannot let the learner change focal length live, and would need a rendered image asset pipeline; `timing-tap` is a 1D bar and irrelevant. The native fallback (`fr-04n`, `mc-01n`) uses pre-rendered original technique cards for accessibility and review.
- Verdict: justified for one sim used in four lessons; a weaker case than a court sim but strong for a subject with no visible game. Kept to a single mechanic (choose from options, then watch the camera prove it).

## 5. Player fantasy & core loop
- Fantasy: "You are the camera operator on a small film set, and you get to see what your choice does."
- Core loop (one mechanic: **predict the camera, then watch it prove it**), 3 rounds by default:
  1. **Prompt:** a low-poly street set appears in a film-frame viewport with a one-line question and 2-4 chips (Display M serif, 12 words or fewer). Two kinds: *identify* ("What did the camera just do?" - the sim first plays a 3 s shot) or *choose* ("Make the crowd feel packed" - the learner picks a lens).
  2. **One decisive interaction:** tap one chip.
  3. **Execute:** for *choose*, the sim re-frames the same subject at the chosen lens (camera slides to keep the subject the same size) so the background visibly changes; for *identify*, the sim replays the move in slow motion with a small top-down inset showing the camera, its view cone and, if enabled, two measurement bars (subject size, background size).
  4. **Freeze/explain:** time freezes; gold pulse on the true measurement, rose outline on the learner's pick if different; one callout card.
  5. **Line you could say out loud** (serif, in quotes), then Next.
- Session length: about 3 minutes (3 rounds x 50-60 s). `scenarioCount` configurable 1-6.

## 6. Scene & entities
- **Environment key:** `film_set_street` (NEW, procedural): a straight street 60 m long; ground plane with chalk depth marks every 5 m; buildings, lamp posts, parked boxes and a mountain-like backdrop block at fixed distances behind the subject; one directional light, no photographic textures.
- **Camera presets used:** `film-frame` (the main view: the "film camera" with adjustable focal length and a 2.39:1 letterbox; the letterbox is drawn in the UI, not a real aspect switch), `top-down-inset` (a 30% width picture-in-picture, orthographic, showing camera and view cone), both via `CameraRig` with reduced-motion cuts.
- **Lens model (spec, normative).** Reference sensor width `S = 36 mm`. For a camera at distance `d` (m) from an object of width `w` (m) and focal length `f` (mm), the object's screen width as a fraction of frame width is `size = (f/1000 * w) / (d * S/1000) = f*w/(d*S)`. Horizontal field of view `fov = 2*atan(S/(2f))`. Subject at distance `d_s`; a background object `Δ` metres behind the subject is at `d_b = d_s + Δ`. Held-subject invariant: choosing focal length `f` sets the camera distance so `f/d_s = k` (constant `k` per scenario); then the background/subject size ratio is `r = d_s/(d_s + Δ)` and rises with `d_s` (longer lens, farther camera). Blur (depth-of-field visual): circle-of-confusion on sensor `c = (f^2 / (N * (d_s - f/1000))) * |d_b - d_s| / d_b` in mm units with `N = 2.8` fixed, mapped to a blur radius (px) by `blurPx = clamp(c * 900, 0, 24)`; shown only when `blurOverlay` is true. All computed with float32, deterministic.

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `filmCam` | `FilmCamera` (NEW, `Swoond.Film`) on `CameraRig` | The lens and camera rig | `focalMm` 18-300, `sensorMm` 36, `distanceM`, `fov`, aperture N fixed 2.8; methods `SetFocal(mm)`, `HoldSubjectSize(k)`, `Dolly(dz)`, `Pan(deg)`, `Tilt(deg)`, `Crane(dy)`, `Track(dx)`; deterministic |
| `subject` | `Character` | The person being filmed | stylized capsule figure, 1.7 m, role `player`-neutral (no rose ring; a gold outline in Explain) |
| `bg` | `Zone`-free props (`PhysicsObject`-less) | Background markers: lamp post (1 m wide), building block (6 m), backdrop wall (20 m) | `distanceBehindSubjectM` per scenario |
| `viewCone` | `ConeOverlay` (GK-15) | Frustum cone in the inset | angle from `fov`, rose fill 12% |
| `measure` | `MeasureBars` (NEW, sim-local; promote if photography needs it) | Subject-size bar and background-size bar with numeric ratio | shown by difficulty |
| `chips` | `DecisionPoint` screen-space chips (GK-3) | 2-4 answer chips >= 44 pt | option ids from scenario |
| `slowmo` | `SlowMotion`, `Replay` | 0.5x replay of the move | ease 250 ms |
| `hint` | `Hint` | Progressive help | see difficulty table |
| `explain` | `Explanation`, `Highlight` | Freeze/explain | section 12 |
| `score` | `Score` | Result builder | section 13 |

- New primitives: `FilmCamera` (reusable by `photography`: exposure and lens lessons; and any future film or camera lesson), `film_set_street` env key. Justified in "Game Kit additions requested".
- Initial layout (portrait):

```
+---------------------------+
| eyebrow: ROUND 1 OF 3     |
| "What did the camera do?" |
| +-----------------------+ |
| |  [film frame 2.39:1]  | |
| |   lamp  (subject) bldg| |
| +-----------------------+ |
| [inset: camera + cone]    |
| [ Zoom in ][ Dolly in ]   |
| [ Dolly zoom ][ Pan ]     |
|      (hint)  (replay)     |
+---------------------------+
```

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Choose an answer | Tap a chip | >= 44 pt tall, full-width in portrait | Chip fills rose; soft-tap haptic |
| Replay | Tap "Replay" chip (identify rounds) | 44 x 44 pt | Chip shows remaining replays |
| Hint | Tap lightbulb-line icon | 44 x 44 pt | Progressive: (1) show inset, (2) show measurement bars, (3) dim wrong options |
| Continue | Native-style pill drawn by Unity ("Next") | 56 pt tall | Primary style |

- **Tap-only scheme** is the default (no drag needed). Forced additions when `reducedMotion`: move replays play as 3-frame stills (start, middle, end) instead of continuous motion.
- Portrait only. Safe-area insets from `runtime.safeAreaInsets`; interactive elements stay 16 pt inside.
- **Not drawn by Unity:** exit confirmation (native "Leave game?"), hearts sheet, paywall, XP counter, lesson header.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received and valid | Validate config; build set from seed; build `FilmCamera`; theme fonts | success -> Intro; failure -> Aborted (`error`) | `ready` (with `gameKitVersion`), `error` (`CONFIG_INVALID`, `SIMULATION_UNKNOWN`) on failure |
| Intro | Loaded | Establishing shot; eyebrow "ROUND 1 OF N"; one-line teach card for the round kind (skippable) | Tap "Start" or 3 s auto | none |
| Playing | Intro done / Next tapped | Show prompt and chips; identify rounds first play the 3 s shot (1 s under reduced motion stills); start timer if configured | chip tapped -> Decision; timer expiry -> Decision(timeout) | `progress` (round/total) |
| Decision | Chip tapped or timeout | Lock input; record choice, latency, hints, replays | -> Executing | none |
| Executing | Decision recorded | Slow replay of the true move, or lens re-frame for the chosen lens; bars animate (<= 4 s; 1 s cut under reduced motion) | complete -> Freeze | none |
| Freeze | Executing done | Time ease to 0 (250 ms; hard cut if reduced motion); dim 35%; gold pulse on the true measurement, rose outline on wrong pick | 400 ms -> Explain | none |
| Explain | Freeze done | Callout card + "say this" line; optional 0.5x replay | "Next" -> Playing or Summary | `checkpoint` (roundId) |
| Summary | Last round explained | Numerals count up (600 ms), one gold line, concepts practised | "Done" -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` | send result | `result`, then `requestExit` (`completed`) |
| Paused | native `pause` | Stop timers, audio, motion; overlay hidden | native `resume` | none |
| Aborted | native `abort`, error or timeout | Stop; partial result (`aborted=true`, `abortReason`), xpEarned 0 | send result | `result`, then `requestExit` |

Exit affordance: an X drawn by Unity emits `requestExit` (`user-quit`); native shows "Leave game?" and replies `abort` if confirmed.

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Options per round | 2 | 2 | 3 | 3 | 4 |
| Measurement bars (`showMeasurements`) | numeric + bars | bars | bars | off | off |
| Blur overlay for focus scenarios | on | on | off | off | off |
| Top-down inset | always | always | on hint | on hint | off |
| Replays | 3 | 2 | 1 | 1 | 0 |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Decision time limit (s) | none | none | none | 20 | 12 |
| Move speed (x) | 0.75 | 1.0 | 1.0 | 1.25 | 1.5 |
| Scenario pool tags | `basic` | `basic` | `basic`,`mixed` | + `subtle` | + `subtle`,`combo` |
| Lens chips (choose rounds) | 24 / 200 | 24 / 85 / 200 | 24 / 50 / 85 / 200 | 18 / 24 / 35 / 50 / 85 / 135 / 200 (shows 4) | same, shows 4 with 2 near-answers |
- Default difficulty: `fr-04` 1, `mc-01` 2, `mc-02` 3, `rv-03` 2-4 by mastery. Level 1 is passable by a true beginner with hints.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "film.camera.lens-and-move.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["lens-basics", "camera-moves", "dolly-zoom", "mixed-refresher"], "default": "lens-basics" },
    "scenarioCount": { "type": "integer", "minimum": 1, "maximum": 6, "default": 3 },
    "showMeasurements": { "type": ["boolean", "null"], "default": null, "description": "null = by difficulty." },
    "blurOverlay": { "type": ["boolean", "null"], "default": null, "description": "null = by difficulty." },
    "replaysOverride": { "type": ["integer", "null"], "minimum": 0, "maximum": 5, "default": null },
    "decisionTimeLimitSeconds": { "type": ["number", "null"], "minimum": 5, "maximum": 60, "default": null }
  }
}
```
Valid: `{ "seed": 12, "scenarioSetId": "camera-moves", "scenarioCount": 3 }`. Invalid configuration -> `error CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/lens-and-move-v1.json`, Addressables bundle `sim-film-lens-and-move`. Four sets of 6 scenarios. **N = 24** (>= rounds x 3 per set: 6 per set for a 3-round session). Deterministic per seed (order, subject side, background prop arrangement within the stated distances).
- Shape:
```json
{
  "scenarioId": "cm-01",
  "kind": "identify-move",
  "setup": { "subjectDistanceM": 6.0, "focalMm": 35, "subjectWidthM": 0.5,
    "background": [ { "id": "lamp", "behindSubjectM": 3, "widthM": 0.3 }, { "id": "building", "behindSubjectM": 18, "widthM": 8 } ] },
  "move": { "type": "dolly-in", "dz": -3.0, "durationS": 3.0, "focalStart": 35, "focalEnd": 35 },
  "options": ["dolly-in", "zoom-in", "pan-right"],
  "best": "dolly-in", "acceptable": [], "teaches": "dolly-vs-zoom", "tags": ["basic"]
}
```
- `move.type` values: `dolly-in`, `dolly-out`, `zoom-in`, `zoom-out`, `pan-left|right`, `tilt-up|down`, `track-left|right`, `crane-up`, `handheld`, `dolly-zoom-out-in` (dolly out while zooming in: background swells), `dolly-zoom-in-out` (dolly in while zooming out: background falls away). `choose-lens` scenarios use `goal` and `options` of focal lengths, with the held-subject invariant.
- **Scenarios (24):**

| scenarioId | Kind | Setup and what plays | Best / acceptable | Teaches | Tags |
|---|---|---|---|---|---|
| `lb-01` | choose-lens | Goal "Make the crowd feel packed"; subject 1.7 m figure; buildings 20 m behind | 200 mm / 85 mm | `perspective-compression` | basic |
| `lb-02` | choose-lens | Goal "Make the hallway feel long and empty" (backdrop 30 m) | 24 mm / 35 mm | `focal-length` | basic |
| `lb-03` | choose-lens | Goal "Isolate her from a busy street"; blur overlay on | 85 mm / 200 mm | `depth-of-field` | basic |
| `lb-04` | identify-move | 3 s zoom-in 35 to 85 mm; camera fixed | zoom-in / none | `dolly-vs-zoom` | basic |
| `lb-05` | choose-lens | Goal "Keep the puppy and the mountain both sharp" | 24 mm / 35 mm | `deep-focus` | basic |
| `lb-06` | choose-lens | Goal "A natural, unstretched close face" | 50 mm / 85 mm | `focal-length` | basic |
| `cm-01` | identify-move | Dolly-in 3 m; lamp grows faster than building | dolly-in / none | `dolly-vs-zoom` | basic |
| `cm-02` | identify-move | Pan-right 25 degrees; no parallax; camera fixed | pan-right / none | `camera-movement` | basic |
| `cm-03` | identify-move | Track-left 4 m, parallax visible, subject follows | track-left / none | `camera-movement`, `dolly-shot` | basic |
| `cm-04` | identify-move | Crane-up 2.5 m over a fence; camera rises | crane-up / tilt-up | `camera-movement` | mixed |
| `cm-05` | identify-move | Handheld: micro-shake, fixed lens | handheld / none | `camera-movement` | subtle |
| `cm-06` | identify-move | Zoom-out 85 to 35 mm; everything shrinks together | zoom-out / dolly-out | `dolly-vs-zoom` | mixed |
| `dz-01` | identify-move | Dolly out 3 m while zooming 35 to 70 mm; subject constant, background swells | dolly-zoom-out-in / zoom-in, dolly-out | `dolly-zoom` | mixed |
| `dz-02` | identify-move | Same as dz-01, seed variant, bars shown | dolly-zoom-out-in / none | `dolly-zoom` | basic |
| `dz-03` | choose-move | Goal "She realises something terrible: the world lurches" | dolly-zoom-out-in / dolly-in | `dolly-zoom` | mixed |
| `dz-04` | identify-move | Dolly in while zooming 70 to 35 mm; subject constant, background shrinks and falls away | dolly-zoom-in-out / zoom-out | `dolly-zoom` | subtle |
| `dz-05` | choose-move | Goal "The room seems to stretch away from him" | dolly-zoom-in-out / dolly-out | `dolly-zoom`, `perspective-compression` | subtle |
| `dz-06` | identify-move | Fast dolly out with zoom in, four options incl. dolly-out, zoom-in, dolly-zoom-in-out | dolly-zoom-out-in / none | `dolly-zoom` | combo |
| `mr-01` | identify-move | Zoom-in 50 to 100 mm | zoom-in / none | `dolly-vs-zoom` | basic |
| `mr-02` | identify-move | Dolly-in with parallax | dolly-in / none | `dolly-shot` | basic |
| `mr-03` | identify-move | Tilt-up 20 degrees | tilt-up / crane-up | `camera-movement` | mixed |
| `mr-04` | choose-lens | Goal "Crush two people together across a street" | 200 mm / 135 mm | `perspective-compression` | mixed |
| `mr-05` | identify-move | Dolly out + zoom in | dolly-zoom-out-in / dolly-out | `dolly-zoom` | subtle |
| `mr-06` | choose-lens | Goal "Isolate her, sharp face and soft street" | 85 mm / 135 mm | `depth-of-field` | subtle |

- **First three fully written** (`lb-01`, `lb-02`, `cm-01`):
```json
[
  { "scenarioId": "lb-01", "kind": "choose-lens",
    "goal": "Make the crowd feel packed",
    "setup": { "subjectDistanceM": 4.0, "focalMm": 35, "subjectWidthM": 0.5, "holdSubject": true,
      "background": [ { "id": "crowd-block", "behindSubjectM": 12, "widthM": 6 }, { "id": "building", "behindSubjectM": 25, "widthM": 10 } ] },
    "options": ["24", "200"], "best": "200", "acceptable": ["85"], "teaches": "perspective-compression", "tags": ["basic"] },
  { "scenarioId": "lb-02", "kind": "choose-lens",
    "goal": "Make the hallway feel long and empty",
    "setup": { "subjectDistanceM": 5.0, "focalMm": 50, "subjectWidthM": 0.5, "holdSubject": true,
      "background": [ { "id": "far-wall", "behindSubjectM": 30, "widthM": 8 } ] },
    "options": ["24", "200"], "best": "24", "acceptable": ["35"], "teaches": "focal-length", "tags": ["basic"] },
  { "scenarioId": "cm-01", "kind": "identify-move",
    "setup": { "subjectDistanceM": 6.0, "focalMm": 35, "subjectWidthM": 0.5,
      "background": [ { "id": "lamp", "behindSubjectM": 3, "widthM": 0.3 }, { "id": "building", "behindSubjectM": 18, "widthM": 8 } ] },
    "move": { "type": "dolly-in", "dz": -3.0, "durationS": 3.0, "focalStart": 35, "focalEnd": 35 },
    "options": ["dolly-in", "zoom-in"], "best": "dolly-in", "acceptable": [], "teaches": "dolly-vs-zoom", "tags": ["basic"] }
]
```
- Generation rules for extra scenarios: subject distance 3-8 m; `behindSubjectM` 3-30 m; choose-lens `best` is the option whose `r = d_s/(d_s+Δ)` (recomputed for the held-subject invariant at that focal length) is closest to the goal band (packed: `r >= 0.6`; empty/deep: `r <= 0.25`); blur goals require `blurPx >= 8` at the best option and `<= 3` at the wide option. Validation test asserts every scenario's `best` satisfies these, so authoring cannot drift.

## 12. Freeze / explain moments
Voice: cheeky coach, short sentences (DESIGN_SPEC section 2). Title <= 6 words, body <= 45 words.

| Id | Trigger | What freezes | Camera | Callouts | Correct title | Correct body | Incorrect title | Incorrect body | Say this |
|---|---|---|---|---|---|---|---|---|---|
| `E-ZOOM` | zoom-in / zoom-out identified | End of move | `film-frame` + inset | Bars: subject and background grew together (gold) | "That was a zoom." | "The camera never moved. The lens changed, so everything grew together, near and far alike. Nothing slid against anything else. That flat, magnified look is a zoom." | "Not quite. Watch the background." | "Ask what moved. If near and far things grew together, the lens changed. That is a zoom. If near things grew faster, the camera itself moved. Replay it and compare the lamp with the building." | "It's a zoom. The whole picture just swelled." |
| `E-DOLLY` | dolly-in / dolly-out | End of move | `film-frame` + inset | Lamp bar grows faster than building bar; cone slides forward | "That was a dolly." | "The camera physically travelled. Near things grew faster than far things, so the background seemed to slide behind the subject. That shift is parallax, and it makes a dolly feel like moving through space." | "Not quite. Compare near and far." | "Zooms change everything at once. A dolly changes near things faster than far ones. Did the lamp shift against the building? Then the camera moved. Watch again." | "That's a dolly. You can feel us walking in." |
| `E-DOLLYZOOM` | dolly-zoom either direction | Mid-move, subject box locked | `film-frame` + inset | Subject bar flat (gold), background bar rising or falling; cone widening as camera retreats | "The dolly zoom." | "The camera moves one way while the lens zooms the other, so the subject stays the same size. The background swells or falls away behind them. The room seems to lurch. Hitchcock made it famous in Vertigo." | "Not quite. Watch the subject." | "In a dolly zoom the subject stays the same size while the background changes. In a plain zoom, the subject grows. In a plain dolly, near things outgrow far ones. Check the subject bar." | "That's the Vertigo shot: the room lurches, she doesn't." |
| `E-LONG` | choose-lens, long lens correct | After re-frame | Both lens views side by side | Background bar larger at 200 mm | "Long lens, stacked space." | "A longer lens needs the camera farther back for the same framing. From far away, things behind the subject look bigger and closer. Space feels stacked and crowded." | "Not quite. Which lens crowds?" | "With the subject the same size, a long lens squeezes the background closer. A wide lens pushes it away. For a packed feeling, go long. Compare the building in both frames." | "The long lens squeezes the street together." |
| `E-WIDE` | choose-lens, wide lens correct | After re-frame | Both lens views | Background bar smaller at 24 mm | "Wide lens, stretched space." | "A wide lens works up close. Near things loom, distant things shrink, and rooms feel deep and empty. Up close, a wide lens also exaggerates faces." | "Not quite. Which lens deepens?" | "A wide lens makes distant things look small and far. That gives a long empty hallway. A long lens would shrink the distance. Compare the far wall in both frames." | "Wide lens: the hallway goes on forever." |
| `E-FOCUS` | choose-lens with blur | After re-frame | Blur overlay on | Blur radius on background (rose ring) | "Long lens, softer background." | "At the same aperture, a longer lens blurs what is behind the subject more. That isolates them. Filmmakers use it to say: look only at this person. Wide lenses keep more in focus." | "Not quite. Check the blur." | "Blur grows with a longer lens and a distant background. For an isolated face, pick the longer option. For everything sharp, pick the wide one. Look at the blur ring." | "Long lens, soft street, sharp face." |
| `E-PAN` | pan / tilt identified | End of move | `film-frame` + inset | Bars flat; no parallax between lamp and building | "That was a pan." | "The camera turned on the spot, like a head turning. Nothing shifted between near and far objects, because the camera did not travel. A move through space would shift them." | "Not quite. Did it travel?" | "A pan or tilt is a rotation from one spot. Near and far things do not shift against each other. If they did, the camera travelled. Watch the lamp and building together." | "It's a pan. The camera just turns its head." |
| `E-TRACK` | track / crane identified | End of move | `film-frame` + inset | Parallax arrows on lamp and building; cone slides sideways or up | "That was a tracking shot." | "The camera travelled beside or above the action. Near objects swept past faster than far ones, which is parallax. A track slides sideways; a crane rises. Neither is a pan." | "Not quite. Did the camera travel?" | "Pans turn in place. Tracks and cranes travel, so near things sweep past faster than far ones. You saw that shift. Look at the inset: the camera slid, it did not swivel." | "That's a track. The camera travels with them." |
| `E-HANDHELD` | handheld identified | End of move | `film-frame` | Jitter trace on the frame | "That was handheld." | "The camera is carried by a person, so it wobbles slightly. It feels close and urgent, like being there. A Steadicam smooths that out; a dolly on rails removes it." | "Not quite. Look for wobble." | "Handheld shows small, irregular wobble. A dolly is smooth. A Steadicam is smooth but floats. Replay the shot and watch the horizon line for tiny movement." | "Handheld: it feels like we're right there." |

- Wrong-pick sequence: gold pulse on the true measurement (400 ms), rose outline on the learner's chip, then the callout card, then the say-this line.
- Every explain moment offers a 0.5x replay (not under reduced motion; stills instead).

## 13. Scoring & mastery signals
- Round outcome ids: `round-1`, `round-2`, ... Each: `best` = 1.0, `acceptable` = 0.5, else 0. `score = round(100 * sum(roundPoints)/rounds) - min(15, 5 * hintsUsed)`, clamped 0-100. `accuracy` = rounds judged `best` / rounds.
- **Mistake -> conceptId mapping:**

| Mistake | conceptId | Description text |
|---|---|---|
| Calls a zoom a dolly | `dolly-vs-zoom` | "Called a lens change a camera move." |
| Calls a dolly a zoom | `dolly-shot` | "Missed parallax: near things moved faster than far ones." |
| Calls a track or crane a pan | `camera-movement` | "Confused a camera that travels with one that only turns." |
| Calls a dolly zoom a plain zoom or dolly | `dolly-zoom` | "Missed that the subject stayed the same size." |
| Picks a wide lens for a packed feeling (or reverse) | `perspective-compression` | "Chose the lens that spreads space when the goal was crowded space (or the reverse)." |
| Picks the wrong lens for an isolated face | `depth-of-field` | "Chose a lens that keeps the background sharp." |
| Picks a long lens for everything sharp | `deep-focus` | "Chose a lens that isolates rather than keeps everything in focus." |
| Wrong lens for a natural face | `focal-length` | "Chose an extreme lens for a natural look." |

- **Mastery signals:** correct-first-try round +0.20 on the round's `teaches` concept (evidence "Correct with 0 hints"); correct with hints +0.10; acceptable +0.05; wrong -0.15; hint-assisted never above +0.10; per-session cap +0.40 and -0.30 per concept. `focal-length` also gets +0.05 on any correct `choose-lens` round.
- Mapping to `SimulationResult`: `outcomes[]` one entry per round (`id`, `success`, `label` e.g. "dolly-in identified", `value` = latency ms); `mistakes[]` per table with `at`; `masterySignals[]` as above; `score`, `accuracy` as above.

## 14. XP & hearts
- `xpEarned` proposal: 10 per `best` round + 5 per `acceptable` + 40 for finishing (native clamps to the lesson budget); hints do not reduce XP (score reflects them).
- `heartsLost`: 1 if `accuracy < 0.5` (at most 1 per session); never on abort; timeouts count as wrong rounds.
- `replayAvailable`: true after a completed session (the last round's move can be replayed natively as a card); false if aborted.

## 15. Failure states
| Failure | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Wrong round | Explain moment with the incorrect copy; move replays | outcome `success=false`, mistake logged | counted at session end |
| Failed session (`accuracy < 0.5`) | Summary: "Two more looks and you'll see it." plus a replay of the hardest round | `completed=true`, score low, heartsLost 1 | -1 |
| Decision timeout | Round marked wrong; explain shows correct | mistake with description "Ran out of time" | as wrong round |
| Abort (user quit / native) | Native "Leave game?" | `aborted=true`, `abortReason`, xp 0 | 0 |
| Backgrounded > timeout | Paused then aborted | `abortReason: backgrounded-too-long` | 0 |
| Asset missing | Error card: "Couldn't load the set. Try the native lesson." + `fr-04n` link | `error` event then result with `aborted=true, abortReason: error` | 0 |
| Invalid config | Native shows friendly fallback to the native lesson | `error CONFIG_INVALID` | 0 |
Failure always ends on an explain card, never a dead end.

## 16. Accessibility
- **Reduced motion:** camera moves replay as three stills with arrows (start, mid, end); no shake for handheld (shown as a jitter icon plus the caption); freeze is a hard cut; slow-mo off.
- **Haptics off:** all haptics silent; cues remain visual.
- **Color-blind modes:** measurement bars use pattern (solid vs hatched) plus labels "Subject", "Background"; chips use text; gold/rose have shape second channel (star vs ring).
- **Text scale:** all overlay text scales up to 3x; chips reflow to full-width stacked; the inset hides at text scale > 2 (bars remain).
- **Tap-only:** default.
- **Screen reader:** Unity content has limited VoiceOver support; the chips and prompt are exposed as accessibility elements, but the camera motion is not describable live. Provide the native fallback lessons `fr-04n` and `mc-01n` (also used as `mc-02` alternate), authored with `multiple-choice`, `visual-id` (original pre-rendered technique cards with `alt` text describing subject size and background size) and `binary-call`.
- **Photosensitivity:** no flashing above 3 Hz; handheld jitter amplitude <= 1.5% of frame width, 6 Hz maximum band-limited.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Chip tap | soft click | soft tap | low |
| Camera move start | quiet servo whoosh (original) | none | low |
| Correct reveal | warm two-note chime (original) | light success | medium |
| Wrong reveal | muted low tone (original) | warning | low |
| Freeze | soft thud | soft tap | low |
All honour `soundEnabled` and `hapticsEnabled`. No music. All audio is original (`original-swoond`).

## 18. Art & asset list
| Asset | Procedural or external | Source & license | Size | Notes |
|---|---|---|---|---|
| Street set (ground, buildings, lamp posts, boxes, backdrop) | Procedural | Astra, `original-swoond` | <= 8k tris | Flat colours from `theme`, depth chalk marks |
| Subject figure | Procedural (capsule Character) | Astra | < 1k tris | No likeness of any real person |
| Film-frame letterbox, bars, chips, callouts | UI (procedural) | Astra | - | Instrument Serif + Geist |
| Sound cues | Original synth | Swoon'd | < 1 MB | Spec section 17 |
| Film stills, posters, clips | **None** | - | - | Never used |
Addressables bundle: `sim-film-lens-and-move`, target <= 6 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (5th percentile >= 50), < 150 MB memory, cold launch < 2 s, bundle <= 25 MB (this sim: <= 6 MB), <= 150 draw calls, <= 60k triangles (this sim: <= 15k). Tighter: no real-time blur post-process heavier than a single-pass box blur on the background layer only.

## 20. Telemetry
`telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `gameKitVersion`, plus `hintsUsed`, `replaysUsed`, `decisionLatencyMsMedian`, `scenarioSetId`, `difficulty`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. AC-1: With seed 42, difficulty 1, `lens-basics`, `scenarioCount` 3, the sim emits exactly 3 `outcomes` and a schema-valid `SimulationResult`.
2. AC-2: `size = f*w/(d*S)` matches the rendered subject width within 1% for 10 fixed `(f, d, w)` triples.
3. AC-3: For every choose-lens scenario the held-subject invariant keeps subject screen width within 1% across all options.
4. AC-4: For every choose-lens scenario the authored `best` satisfies the generation rule (section 11) computed from the lens model.
5. AC-5: For a dolly-in, the near prop's size ratio (end/start) exceeds the far prop's; for a zoom, the ratios are equal within 1%.
6. AC-6: For a pan, no parallax: pixel offset ratio between near and far props is 1.0 within 1%.
7. AC-7: For `dolly-zoom-out-in`, subject width stays within 2% of start while background width increases by at least 15%.
8. AC-8: Same seed and inputs reproduce identical scenario order and results.
9. AC-9: Invalid configuration (`scenarioCount` 9) yields `error CONFIG_INVALID` and no crash.
10. AC-10: Bridge conformance: the sim reads every example in `docs/contracts/unity-bridge/v1/examples/`, emits `ready`, `progress`, `checkpoint`, exactly one `result`, `requestExit`.
11. AC-11: Explain copy: every title <= 6 words and body <= 45 words (automated on the spec table).
12. AC-12: With `reducedMotion` true no continuous camera motion plays; three stills are used and no shake.
13. AC-13: Every chip and Next button has a hit area >= 44 pt at text scale 1.0 and 3.0.
14. AC-14: Cold launch < 2 s and 5th percentile fps >= 50 on the reference device (perf run).
15. AC-15: Mistake and mastery mapping match section 13 for a scripted wrong-then-right run.

## 22. Test plan
- **EditMode:** lens-model formulas (AC-2 to AC-4), blur formula, scoring maths, config validation (AC-9), determinism (AC-8), result schema validity, copy-length lint (AC-11).
- **PlayMode:** scene builds from code; scripted full run per set; move plays (AC-5 to AC-7); freeze/explain; pause/resume/abort; reduced-motion path (AC-12); layout at text scale 3.0 (AC-13).
- **Perf:** measured run on iPhone 13-class (AC-14).

| AC | Test type | Test name |
|---|---|---|
| AC-1 | EditMode | `Result_ThreeRounds_SchemaValid` |
| AC-2 | EditMode | `Lens_ScreenSize_MatchesFormula` |
| AC-3 | EditMode | `Lens_HoldSubject_Invariant` |
| AC-4 | EditMode | `Scenarios_Best_SatisfiesGenerationRule` |
| AC-5 | PlayMode | `Move_DollyVsZoom_ParallaxRatios` |
| AC-6 | PlayMode | `Move_Pan_NoParallax` |
| AC-7 | PlayMode | `Move_DollyZoom_SubjectConstant` |
| AC-8 | EditMode | `Determinism_SameSeed_SameRun` |
| AC-9 | EditMode | `Config_Invalid_ErrorsCleanly` |
| AC-10 | EditMode | `Bridge_Conformance_Examples` |
| AC-11 | EditMode | `Copy_Lengths_WithinLimits` |
| AC-12 | PlayMode | `ReducedMotion_UsesStills` |
| AC-13 | PlayMode | `HitTargets_MinSize` |
| AC-14 | Perf | `Perf_Launch_And_Fps` |
| AC-15 | EditMode | `Scoring_MistakeMapping_Matches` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is a live-lens sim clearly better than pre-rendered before/after technique cards in native `visual-id`? Playtest; downgrade if not. | Product / Astra | No |
| 2 | Reference sensor 36 mm and fixed N = 2.8: acceptable simplification (educational, not photometric)? | Product | No |
| 3 | Should `FilmCamera` live in a shared `Swoond.Film` module reused by the `photography` course? | Astra | No |
| 4 | Original audio cues: synthesise vs commission (L-11 style). | Product | No |

## Game Kit additions requested
- **`Swoond.Film` module (NEW):** `FilmCamera` (focal length, sensor width, `HoldSubjectSize`, `Dolly`, `Pan`, `Tilt`, `Crane`, `Track`, deterministic), `film_set_street` environment key. Reusable by `film.camera.axis-line.v1` (same module) and by `photography`.
- Reuse existing: `CameraRig` (preset `film-frame` new, `top-down-inset` new = GK-19 family), `ConeOverlay` (GK-15), screen-space chip `DecisionPoint` (GK-3), `Hint`, `Explanation`, `Highlight`, `SlowMotion`, `Replay`, `Score`.
- Sim-local: `MeasureBars` (promote if photography needs an exposure meter overlay).
- Registry keys: environment `film_set_street`; camera presets `film-frame`, `top-down-inset`.
