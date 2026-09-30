# Contour Flyover (`hiking.navigation.topo-terrain.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `hiking.navigation.topo-terrain.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.x` (built against `1.0.0`); sim-definition `1.x` (not data-driven end to end: scenarios are data, the terrain/overlay systems are new Game Kit code) |
| Authors / date | Hiking course design agent (Claude), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `hiking`. CDS row: `docs/courses/hiking/CDS.md` section 12, "Contour Flyover (Tier A)".
- Manifest entry: `docs/courses/hiking/manifest.json` -> `unitySimulations[]`.
- Launching lessons (each passes a different `scenarioSetId` and default `difficulty`):

| unitId | lessonId | scenarioSetId | default difficulty |
|---|---|---|---|
| `navigation` | `nv-03` (Contours come alive) | `steepness-and-cliffs` | 1 |
| `navigation` | `nv-04` (Ridges, saddles, valleys) | `landforms` | 2 |
| `navigation` | `nv-08` (Handrails and catching features) | `plan-a-line` | 2 |
| `alpine-and-high-country` | `ah-05` (Reading a high route) | `high-route` | 3 |
| `perpetual-review` | `rv-03` (Map reading refresher) | `mixed-refresher` | learner-adaptive (2-4) |

- Prerequisite concepts: `contour-line` and `contour-interval` should be `mastered` (taught natively in `nv-02`); otherwise `nv-03` shows a 30-second native primer first (native side; not Unity).
- Accessible native path for the same concepts (this sim is not fully screen-reader accessible): lesson `nv-05` "Landforms without the flyover" (hotspot-tap + multiple-choice on static procedural diagrams).

## 3. Learning objective(s) & concepts taught
- Learner-facing objective: "You can look at a flat topo map and *see* the hill: steep or gentle, ridge or valley, cliff or pass."
- Concepts (all must exist in the hiking curriculum `concepts[]`):

| conceptId | term | After this the learner can... |
|---|---|---|
| `contour-line` | Contour line | Say that a line joins equal elevations and that tight lines mean steep ground |
| `contour-interval` | Contour interval | Use the interval to estimate climbing along a leg by counting lines |
| `index-contour` | Index contour | Use bold labeled lines to tell which way is uphill |
| `cliff-contours` | Cliff contours | Spot merged/near-touching contours as a cliff band to avoid |
| `ridgeline` | Ridge and spur | Recognize downhill-pointing bulges as ridges/spurs |
| `saddle` | Saddle | Find the pass between two high points from an hourglass shape |
| `drainage` | Drainage | Recognize uphill-pointing Vs as valleys where water runs |
| `handrail` | Handrail | Choose a linear feature to follow (creek, ridge, road) |
| `catching-feature` | Catching feature | Pick the feature that tells you that you overshot |
| `exposure` | Exposure | Connect tight contours beside a route with a steep drop |

- Out of scope: compass/bearing work, declination, map scale calculations, GPS use, route finding on real named terrain, snow/avalanche terrain. No real place names; no claim that the sim trains real navigation or safety skills.

## 4. Why Unity (tier justification)
Rubric (CLAUDE.md section 4):
- **Camera perspective is the concept.** A topo map is a 2D encoding of a 3D surface. The learning event is the correspondence: contour spacing lifts into slope, contour bends become ridges and valleys. The core mechanic, a camera that tilts from top-down (map) to oblique (terrain) while the same contour lines drape over a real mesh, cannot be conveyed by a static image and is what an instructor at a sand table or a 3D viewer does.
- **Spatial reasoning and movement in space.** A hiker marker walks the chosen line while an elevation profile draws below it; water droplets run downhill to reveal drainages; line-of-sight rays reveal what a viewpoint can see. These are dynamic scenes whose truth is computed from a heightfield.
- **Why not native.** Closest native types: `hotspot-tap` on a static diagram (teaches recognition, not the 2D<->3D mapping) and `multiple-choice`. Those are used for the accessible fallback lesson `nv-05` and for spaced review of terms. A native fake would need pre-rendered image pairs (limited to authored maps, no seeds/variety, no live viewshed or flow). Building a real-time terrain renderer natively would duplicate Game Kit territory (CLAUDE.md section 3).
- Verdict: justified; kept to exactly one sim used in five lessons, with everything else in the course native. Rejected Unity candidates (weather build-up, river crossing physics, daylight math) are recorded in CDS section 5.

## 5. Player fantasy & core loop
- Fantasy: "You are a hiker with a map who can lift the paper off the page and see the land."
- Core loop, one mechanic (**predict from the map, verify in 3D**), 3 rounds by default:
  1. **Prompt:** map appears top-down with a one-line question and 2-4 tappable Targets. (Display M serif, 12 words or fewer.)
  2. **One decisive interaction:** tap one Target (optionally after a "peek" that tilts the camera briefly, gated by difficulty).
  3. **Execute:** camera eases from top-down to oblique (1.2 s), contours drape on the terrain, a hiker marker walks the tapped line (or water flows / sight rays fire, per scenario kind); elevation profile draws.
  4. **Freeze/explain:** time freezes on the reveal; gold pulse on the truth, rose outline on the learner's pick if different; one callout card, then the "say this" line.
  5. **Line you could say out loud** (serif, in quotes), then Next.
- Session length: about 3 minutes (3 rounds x 50-60 s). `rounds` configurable 1-5.

## 6. Scene & entities
- **Environment key:** `terrain_heightfield` (NEW, procedural). A 129 x 129 vertex grid (32,768 triangles) generated from a `TerrainRecipe` (seeded noise + named stamps) covering an extent of `extentMiles` (default 1.5 x 1.5 miles). Map and terrain are the **same mesh**; the "map" is a top-down orthographic-to-perspective blend with a contour shader (no separate 2D asset).
- **Camera presets used:** `top-down` (map), `oblique-low` (35 degrees, terrain reveal), `chase-high` (behind hiker), `first-person` (eye height, viewshed scenario), all via `CameraRig` with reduced-motion cuts.

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `terrain` | `TerrainMesh` (NEW) + `Heightfield` (NEW) | The land | recipe, vertical exaggeration 1.0 (1.5 in explain shots), 129 x 129 |
| `contours` | `ContourOverlay` (NEW; shader-based) | Contour lines | interval ft/m, index every 5th, label density, line width 1.5-2.5 dp |
| `slope-tint` | `SlopeShader` (NEW; optional) | Grade color ramp with pattern second channel | only in reveal and difficulty 1-2 legends |
| `hiker` | `Character` | Walks the learner's tapped line | speed 1.0 map-units/s, role `player`, rose ring |
| `legs` / `routes` | `Path` | Candidate lines (A/B/C) | polyline in map space, labeled by letter |
| `targets` | `Target` | Selectable pins/legs/regions | `IsCorrect`, `ConceptId`, ring >= 44 pt |
| `zones` | `Zone` | Cliff band, lake, road, summit disks | translucent fill, label eyebrow |
| `water` | `PhysicsObject` (fixed step, gradient-descent) | Droplets flowing downhill (drainage rounds) | 24 droplets, seeded, 4 s run |
| `sight` | `Viewshed` (NEW) | Line-of-sight rays / lit cells | 64 rays, 2 m eye height |
| `profile` | `ProfileChart` (NEW, screen-space overlay) | Elevation profile of the chosen line | axis in ft/m, 3 dp smoothing |
| `decision` | `DecisionPoint` | The single choice per round | time limit per difficulty |
| `hint` | `Hint` | 3-step help | see difficulty table |
| `explain` | `Explanation`, `Highlight`, `SlowMotion` | Freeze/explain | per section 12 |
| `score` | `Score` | Result builder | section 13 |

- New primitives justified in section "Game Kit additions requested" (below, end of section 23's companion list) are reusable by camping, climbing and any future mapped-terrain course (golf course reading, ski, trail running, geology).
- Initial layout (portrait, top-down):

```
+---------------------------+
| eyebrow: ROUND 1 OF 3     |
| "Which leg is steepest?"  |
|                           |
|   . ' - . _ contour rings |
|  (A)---o    o---(B)       |
|        \  camp /          |
|         (C)               |
|  [compass rose N^]        |
| [ Peek ]   (hint, level)  |
+---------------------------+
```

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Choose an answer | Tap a Target (leg, pin, region) | ring >= 44 pt; leg hit area is a 44 pt-wide capsule along the path | Ring fills rose; haptic soft tap |
| Peek | Tap "Peek" chip; camera tilts to oblique for 2 s, then returns | 44 x 44 pt | Chip shows remaining peeks |
| Hint | Tap lightbulb-line icon | 44 x 44 pt | Progressive: (1) dim distractors, (2) show contour-spacing bracket, (3) show slope tint |
| Continue | Native-style pill drawn by Unity ("Next") | 56 pt tall | Primary style |
| Orbit (optional) | Drag one finger during Explain to orbit +/- 30 degrees; two-finger pinch to zoom 0.8-1.5x | n/a | Reset button at 44 pt |

- **Tap-only scheme** (`ControlScheme.TapOnly`, forced when Switch Control/AssistiveTouch detected or `reducedMotion`): no orbit/pinch; Peek and Explain use preset cuts; Targets become a vertical list of large buttons below the map (A, B, C ...) in addition to on-map rings.
- Portrait only. Safe-area insets from `runtime.safeAreaInsets`; interactive elements stay 16 pt inside.
- **Not drawn by Unity:** exit confirmation (native "Leave game?"), hearts sheet, paywall, XP counter, lesson header.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received and valid | Validate config; build Heightfield from seed; build mesh, overlays; theme fonts | success -> Intro; failure -> Aborted (`error`) | `ready` (with `gameKitVersion`), `error` on failure |
| Intro | Loaded | Top-down pan-in; eyebrow "ROUND 1 OF N"; one-line teach card for the first round kind (skippable) | Tap "Start" or 3 s auto | none |
| Playing | Intro done / Next tapped | Show prompt and Targets; enable Peek/Hint; start decision timer if configured | Target tapped -> Decision; timer expiry -> Decision(timeout) | `progress` (round/total) |
| Decision | Target tapped or timeout | Lock input; record choice, latency, hints, peeks | -> Executing | none |
| Executing | Decision recorded | Camera to `oblique-low`; hiker walks / water flows / rays fire; profile draws (<= 4 s; 1 s cut under reduced motion) | complete -> Freeze | none |
| Freeze | Executing done | Time ease to 0 (250 ms; hard cut if reduced motion); dim 35%; gold pulse on truth, rose outline on wrong pick | 400 ms -> Explain | none |
| Explain | Freeze done | Callout card(s) + "say this" line; optional 0.5x replay of the reveal | "Next" -> Playing (next round) or Summary | `checkpoint` (roundId) |
| Summary | Last round explained | Numerals count up (600 ms), one gold line, concepts practiced | "Done" -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` | send result | `result`, then `requestExit` (`completed`) |
| Paused | native `pause` | Stop timers, audio, water/hiker motion; overlay hidden | native `resume` | none |
| Aborted | native `abort`, error, or timeout | Stop; build partial result (`aborted=true`, `abortReason`), xpEarned 0 | send result | `result`, then `requestExit` |

Exit affordance: an X drawn by Unity emits `requestExit` (`user-quit`); native shows "Leave game?" and replies `abort` if confirmed.

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Candidate Targets per round | 2 | 3 | 3 | 4 | 4 |
| Contour interval (ft) | 40 | 40 | 40 | 20 | 20 |
| Index contours labeled | every 5th, all labeled | every 5th, all labeled | every 5th, half labeled | every 5th, 1 label per ring | labels only at map edge |
| Slope tint on map before answer | On | On | Off | Off | Off |
| Peeks available per round | unlimited | 2 | 1 | 0 | 0 |
| Hints available | 3 (progressive) | 3 | 2 | 1 | 0 |
| Decision timer | none | none | 45 s | 30 s | 20 s |
| Terrain complexity (octaves / distractor micro-features) | 2 / 0 | 3 / 1 | 4 / 2 | 5 / 3 | 5 / 4 |
| Map orientation | north up | north up | north up | north up | rotated (random 0-359, north arrow shown) |
| Scenario pool tags | `basic` | `basic`,`mid` | `mid` | `mid`,`hard` | `hard`,`review` |
| Kinds per session | 1 kind x 3 | 2 kinds | 3 kinds | 3 kinds | 3 kinds mixed |

- Level 1 is passable by a true beginner: two Targets, the answer is visually obvious once the slope tint is read, hints spell out "close lines = steep".
- Lessons default per section 2; native may raise/lower by learner performance (`difficulty` in launch).

## 10. Configuration schema
`LaunchRequest.configuration` (fields override the difficulty table when present; invalid -> `error CONFIG_INVALID`).

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://schemas.swoond.app/sims/hiking.navigation.topo-terrain.v1.configuration.json",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647, "description": "Deterministic seed for terrain and scenario order. Default: derived from sessionId." },
    "scenarioSetId": { "type": "string", "enum": ["steepness-and-cliffs", "landforms", "plan-a-line", "high-route", "mixed-refresher"], "default": "steepness-and-cliffs" },
    "rounds": { "type": "integer", "minimum": 1, "maximum": 5, "default": 3 },
    "units": { "type": "string", "enum": ["ft", "m"], "default": "ft" },
    "contourInterval": { "type": "integer", "enum": [10, 20, 40, 80], "description": "In `units`. Default from difficulty table." },
    "showIndexLabels": { "type": "string", "enum": ["all", "half", "one-per-ring", "edge"], "description": "Default from difficulty table." },
    "allowPeek": { "type": "boolean", "description": "Default from difficulty table." },
    "decisionTimerSeconds": { "type": "integer", "minimum": 0, "maximum": 60, "description": "0 disables. Default from difficulty table." },
    "mapRotationDeg": { "type": "integer", "minimum": 0, "maximum": 359, "description": "Default 0 except difficulty 5 (seeded random)." },
    "extentMiles": { "type": "number", "minimum": 0.5, "maximum": 3.0, "default": 1.5 },
    "assetRoot": { "type": "string", "description": "Optional local path for Addressables bundle root (bridge README section 5)." }
  }
}
```

Valid example:
```json
{ "seed": 42, "scenarioSetId": "landforms", "rounds": 3, "units": "ft", "contourInterval": 40, "allowPeek": true }
```

## 11. Scenario data set
- Format: `scenarios/<scenarioSetId>.json` shipped in the sim bundle; each scenario has `scenarioId`, `kind`, `terrainRecipe`, `targets`, `truth`, `conceptId`, `tags`, `explainKey`. Deterministic per seed (seed picks scenario order and small terrain noise; the authored stamps are fixed so the truth is stable).
- Terrain recipe primitives: `base {elevationFt, noise{octaves, amplitudeFt, wavelengthMi}}`, `stamp {type: peak|ridge|spur|bowl|drainage|cliffband|plateau|lake|road, cx, cy, ..., heightFt}`, all in normalized map space 0..1 (extent `extentMiles`).
- Rounds x 3 = 9 minimum; **14 scenarios authored** (>= 9): 3 fully written, 11 summarized. Every kind has at least 2 scenarios.

### Fully written
**S-01 `steep-leg-01`** (kind K1 steepest-leg; concept `contour-line`; tags `basic`)
- Setup: base 4,000 ft, gentle noise (amp 30 ft). Camp at (0.5, 0.5). Three legs, each 0.35 map units long (~2,772 ft at 1.5 mi extent): **A** north over a broad spur (climb ~170 ft, ~6%), **B** east up a headwall (stamp `peak` at (0.92,0.5), height +800 ft, radius 0.2; climb ~800 ft, ~29%), **C** west contouring along a bench (climb ~90 ft, ~3%). Interval 40 ft -> A crosses ~4 lines, B ~20, C ~2.
- Question: "Which leg is steepest?" Targets: A, B, C (L1: A, B only... pool picks 2 legs for L1: B and C).
- Correct: B. Mistakes: choose A -> `contour-line` "Picked the longer-looking leg, not the tighter contours"; choose C -> `contour-interval`.
- Reveal: hiker walks the chosen leg; profile shows grade %.

**S-02 `cliff-band-01`** (kind K2 cliff-avoid; concept `cliff-contours`; tags `basic`)
- Setup: base 5,200 ft; lake zone at top center (0.5, 0.12). Trailhead at (0.5, 0.9). `cliffband` stamp across y = 0.5 from x = 0.1 to x = 0.62, drop 220 ft over 0.02 map units (~160 ft horizontal): contours merge to one thick line. A gap at x = 0.72-0.9 is a gentle ramp.
- Question: "Which straight line avoids the cliff?" Targets: L1 (x = 0.25), L2 (x = 0.5), L3 (x = 0.8).
- Correct: L3. Mistake choose L1/L2 -> `cliff-contours` "Walked into merged contours".
- Reveal: hiker on L2 stops at the brink (shown as gold ring on the merged lines); 3D shows a wall. If correct, hiker walks L3 up the ramp.

**S-03 `drainage-01`** (kind K3 ridge-or-drainage; concept `drainage`; tags `basic`)
- Setup: base 6,000 ft, a central valley stamp `drainage` running from (0.5, 0.2) high to (0.5, 0.9) low, flanked by two ridges (`ridge` stamps at x = 0.25 and 0.75). Pins: P1 at (0.5, 0.55) valley axis, P2 at (0.25, 0.5) ridge crest, P3 at (0.75, 0.5) ridge crest.
- Question: "Where would water collect and flow?" Targets: P1, P2, P3.
- Correct: P1. Mistake P2/P3 -> `ridgeline` "Ridge crests shed water; they do not gather it".
- Reveal: 24 droplets spawn at each pin; those at P2/P3 roll off into the valley; P1's droplets follow the V.

### Summarized (rules for the generator)
| scenarioId | kind | setup summary | correct decision | concept | tags |
|---|---|---|---|---|---|
| `saddle-01` | K4 saddle | Two summits (6,420 / 6,380 ft) joined by a ridge; three crossing pins: true saddle (5,900), false shoulder (6,150), spur col | The lowest crossing | `saddle` | basic |
| `viewshed-01` | K5 viewshed | Lake behind a spur; three viewpoints at equal elevation; only one has line of sight | Viewpoint with clear LOS (rays lit) | `contour-line` | mid |
| `least-climb-01` | K6 route-least-climb | Two routes A to B: over a hump (gain ~620 ft) vs contouring detour (gain ~180 ft, +0.4 mi) | Detour (fewer contours crossed) | `contour-interval` | mid |
| `uphill-01` | K7 uphill-direction | Hiker at labeled 5,200 ft; index labels 5,400 / 5,600 / 5,800 rise to the NE | Walk NE | `index-contour` | basic |
| `catch-road-01` | K9 catch-the-road | Plateau descending west to a road; a creek (handrail) runs to the road | Tap the road as the catching feature | `catching-feature` | mid |
| `handrail-01` | K9 handrail | Confusing forest; pick the linear feature to follow to a trailhead | The creek/drainage | `handrail` | mid |
| `high-route-01` | K10 high-route | Ridge with a cliff band on the north face and a saddle bypass south | Saddle bypass avoiding merged contours | `exposure` | hard |
| `drainage-02` | K3 | Rotated map (L5), spur vs drainage lookalike | The Vs pointing uphill | `drainage` | hard |
| `steep-leg-02` | K1 | Interval 80 ft, index labels, four legs, two look similar | Leg with most crossings per length | `contour-interval` | mid |
| `saddle-02` | K4 | Three-peak cluster, two candidate cols | The lower col | `saddle` | mid |
| `viewshed-02` | K5 | Viewpoint on a bench vs on a spur | LOS check | `ridgeline` | hard |
| `cliff-02` | K2 | L5 rotated, cliffs on two sides | The ramp gap | `cliff-contours` | hard |
| `spur-01` | K3 variant | Spur bulge vs drainage V | The ridge bulge (question flips: "Which pin is on a spur?") | `ridgeline` | mid |
| `ridge-walk-01` | K10 | Choose the line that stays on the ridge crest between two peaks | Ridge crest, not the slope | `ridgeline` | mid |

## 12. Freeze / explain moments
Voice: cheeky coach; warm, a little flirty (never about the crush); one joke per screen. Title <= 6 words, body <= 45 words.

**Intro card (once per session):** Title "Lift the paper off the map." Body: "Contours are ground, drawn flat. Pick your answer, then watch the land stand up. Some lines are steep. Some are gentle. All of them are talking." (28 words)

| Kind | Outcome | Title | Body (<= 45 words) | Say this |
|---|---|---|---|---|
| K1 steepest-leg | Correct | Nice read. Tight lines. | Tight contours mean lots of climbing in a short distance. Leg B crosses 20 lines while the others cross a handful. The map was telling you the hill was steep. | "Those contours are jammed together, so it's going to be steep." |
| K1 | Incorrect | Not quite. Count the lines. | Leg length can fool you. Count how many contour lines each leg crosses. Every line is another forty feet. Leg B crosses the most, so it climbs the most. | "It's shorter, but count the lines, that's the real climb." |
| K2 cliff-avoid | Correct | Nice read. Merged means cliff. | Contours merging into one thick line mean the ground drops almost straight down. You found the gap where the lines spread out again. That is where a real trail would go. | "The lines merge there, so that's a cliff. I'd take the ramp." |
| K2 | Incorrect | Not quite. That wall is real. | When contour lines pile into one, the ground is nearly vertical. Your line meets it head on. Look for where the lines spread apart. That is the walkable way through. | "Those lines touch, don't go straight at that." |
| K3 ridge-or-drainage | Correct | Nice read. Vs point uphill. | Water gathers where contours V upstream. That is a drainage. Ridges bulge the other way and shed water. Follow the V and you find the creek. | "That V points uphill, so it's a drainage." |
| K3 | Incorrect | Not quite. Ridges shed water. | A ridge crest is the high ground, so water rolls off it. Look for lines that bend up toward higher ground. That is where water collects. | "Ridges shed water. Valleys collect it." |
| K4 saddle | Correct | Nice read. The low pass. | A saddle is the low point on a ridge between two peaks. On the map it pinches like an hourglass. Trails cross there because it is the easiest way over. | "The trail crosses at the saddle, the low point." |
| K4 | Incorrect | Not quite. Find the lowest crossing. | That crossing sits higher than the hourglass between the peaks. A saddle is the lowest point on the connecting ridge. Check each pin's elevation. | "It's a saddle if it's the low spot between two highs." |
| K5 viewshed | Correct | Nice read. Clear line of sight. | From that spot, nothing higher blocks the view. The spur behind the others hides the lake. Contours show what rises between you and the lake. | "From there you can see the lake, nothing's in the way." |
| K5 | Incorrect | Not quite. The spur blocks it. | A ridge or spur between you and the lake hides it. Follow the contours from your spot to the lake: if they climb and drop again, the view is blocked. | "Something higher is in the way, you can't see it from there." |
| K6 least-climb | Correct | Nice read. Fewer lines, less climb. | The detour is longer but crosses far fewer contours, so it climbs less. Sometimes the shortest line is the hardest. Count the lines. | "It's longer, but it climbs less. Worth it." |
| K6 | Incorrect | Not quite. Short is not easy. | The direct line goes over a hump and crosses many contours. The detour is longer but nearly level. Total climb, not distance, is what tires you. | "Shortest isn't easiest. Check the gain." |
| K7 uphill-direction | Correct | Nice read. Numbers rise. | Bold index lines show elevation. They climb toward the northeast, so uphill is northeast. Read the labels and you know which way is up. | "The numbers go up that way, so that's uphill." |
| K7 | Incorrect | Not quite. Read the labels. | The bold lines carry elevations. Find your line, then the next one: the larger number is uphill. Your pick heads toward lower numbers. | "Follow the numbers up." |
| K9 catch/handrail | Correct | Nice read. A backstop. | A road or river across your route is a catching feature: hit it and you know you overshot. A creek to follow is a handrail. Both keep you oriented. | "The road is my backstop, if I hit it I've gone too far." |
| K9 | Incorrect | Not quite. Look for the stopper. | You want something big and unmistakable that crosses your route. The road does that. A single tree does not. | "I need something I can't miss that says stop." |
| K10 high-route | Correct | Nice read. Safe line. | The saddle bypass avoids the merged contours on the north face, so you never stand at the top of a wall. Lower and gentler wins. | "I'd take the saddle. That north face is cliffs." |
| K10 | Incorrect | Not quite. Mind the drop. | Your line keeps you beside merged contours. That means steep ground beside you, which is exposure. A gentler line exists over the saddle. | "There's a big drop on that side, not for me." |

**Summary card:** Title "Now you can read the land." Body: "You looked at a flat map and pictured a hill. That is exactly what she does at the trailhead. Ask her what she sees next." (26 words) with concept chips.

## 13. Scoring & mastery signals
- **Round score (0-100):** correct = `max(40, 100 - 20*hintsUsed - 10*peeksUsed_if_difficulty>=3)`; incorrect = 0, except ranked kinds (K1, K4, K6) where the second-best option scores 30. Timeout = incorrect.
- **Session `score`:** mean of round scores (rounded). **`accuracy`:** correct rounds / rounds.
- **Outcome ids:** `round-<n>-<kind>` with `success`, `label` (scenarioId), `value` (roundScore).

| Mistake | conceptId | Description text |
|---|---|---|
| Chose longer-looking leg over tighter contours | `contour-line` | Judged steepness by length, not contour spacing. |
| Misjudged climb by ignoring interval | `contour-interval` | Did not use the interval to compare climb. |
| Read uphill wrong from labels | `index-contour` | Read labeled contours in the wrong direction. |
| Walked into merged contours | `cliff-contours` | Chose a line that meets a cliff band. |
| Picked a ridge as a water collector or vice versa | `ridgeline` / `drainage` | Confused ridge bulges with drainage Vs. |
| Chose a false saddle or shoulder | `saddle` | Did not find the lowest crossing. |
| Chose a viewpoint with blocked sight | `ridgeline` | Missed the rise between viewpoint and lake. |
| Picked the wrong catching feature | `catching-feature` | Chose a feature that does not stop overshoot. |
| Picked the wrong handrail | `handrail` | Chose a feature that leads elsewhere. |
| Chose an exposed line on a high route | `exposure` | Chose a line beside a cliff band. |

| Mastery signal event | conceptId | delta | Evidence text |
|---|---|---|---|
| Correct, no hint | scenario concept | +0.20 | "Read the contours correctly with no help." |
| Correct after 1 hint | scenario concept | +0.10 | "Read the contours with one hint." |
| Correct after 2+ hints | scenario concept | +0.05 | "Needed hints to read the contours." |
| Incorrect | mistake concept | -0.15 | "Misread the contours in <scenarioId>." |
| Second-best on a ranked kind | scenario concept | +0.02 | "Close, chose the second-best option." |

Caps per session: +0.40 and -0.30 per concept. Native applies its own clamp and halves gains on hinted rounds; the sim also reports hint count in `telemetry.hintsUsed`.

Mapping: `outcomes[]` = one per round; `mistakes[]` = `{conceptId, description, at: roundIndex}` per wrong round; `masterySignals[]` per table above; `score`, `accuracy` as defined.

## 14. XP & hearts
- `xpEarned` proposal: +10 per correct round, +40 if the session completes (native clamps to the lesson budget); 0 when aborted.
- `heartsLost`: 1 if accuracy < 0.5 (2 or more of 3 rounds wrong); never more than 1 per session. Hint use never costs hearts.
- `replayAvailable`: `true` after Done (Replay records inputs and camera; deterministic by seed). Replay is free.

## 15. Failure states
| Case | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round | Not-quite explain card with the correct answer highlighted; Next | `outcomes[i].success=false`, mistake + mastery -0.15 | No (session rule only) |
| Failed session (accuracy < 0.5) | Summary: "Rough day. The map will still be here." plus retry via native | `completed=true`, low `score`; `heartsLost=1` | Yes, max 1 |
| Decision timeout | Timer ring empties; same as a wrong answer; explain shows the answer | as failed round | No |
| Abort (user quit, backgrounded > 120 s) | Native handles UI | `aborted=true`, `abortReason`, `xpEarned=0` | No |
| Asset missing | Native "Try again" | `error ASSET_LOAD_FAILED` recoverable | No |
| Invalid config | Native error and skip option | `error CONFIG_INVALID` | No |
| Low-memory / crash | Native detects; offers resume from last `checkpoint` | none | No |

Every failure path passes through an Explain moment (no dead ends).

## 16. Accessibility
- **Reduced motion:** camera tilts become cuts (top-down -> oblique in one frame); hiker teleports along the line in 3 steps; water droplets shown as static arrows; no pulsing rings (static ring); freeze is a hard cut.
- **Haptics off:** all cues silent-visual only.
- **Color-blind modes:** correct vs chosen never rely on gold/rose alone: correct = gold ring plus check glyph; learner's wrong pick = rose ring plus X glyph; legs labeled A/B/C with distinct line dash patterns (solid, dashed, dotted); slope tint ramp has a hatching second channel.
- **Text scale:** all overlay text scales up to 3.0 (cards reflow; the map shrinks vertically to keep Targets >= 44 pt).
- **Tap-only alternative:** see section 7.
- **VoiceOver/TalkBack:** Unity content is limited. Provide native accessible fallback lesson **`nv-05` "Landforms without the flyover"** (hotspot-tap + multiple-choice on described static diagrams). Targets expose accessible labels ("Leg A, north, crossing about 4 contour lines") through the AccessibilityService when the platform supports it; at minimum the prompt and outcome are announced via native.
- Never rely on sound; audio is optional.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Target tap | Soft tick | Soft tap | 0.4 |
| Reveal starts | Low airy whoosh (short) | none | 0.3 |
| Correct | Two-note warm chime | Light success | 0.5 |
| Incorrect | Single soft low note | Warning | 0.4 |
| Freeze | Muted swell | Soft tap | 0.3 |
| Timer last 5 s | Quiet tick | none | 0.2 |

All honor `soundEnabled` and `hapticsEnabled`; no music required.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Terrain mesh | Procedural | Code | 32,768 tris; no textures | 129 x 129 grid |
| Contour lines | Procedural shader | Code | 0 | `frac(height/interval)`, index every 5th thicker |
| Slope tint | Procedural shader | Code | small ramp texture (64 x 1) | with hatching for CB |
| Hiker | Game Kit `Character` low-poly | In-house Game Kit | < 1.5k tris | rose ring |
| Zones (lake, road, cliff) | Procedural overlays | Code | quads | translucent |
| Compass rose | Procedural / vector | In-house | 256 x 256 | north arrow |
| Fonts | TMP from Instrument Serif and Geist | OFL | ~1 MB | bundled |

- Overlay styling per ART_DIRECTION: rose = learner's pick, gold = the truth, dimmed distractors 35%. Background `bgDeep`; terrain base tinted with `court` (dark) or light `court`; no photographic textures; light: one directional light with soft rim.
- No external assets; no real map data or real place names (keeps licensing clean; USGS-inspired styling only).
- Addressables bundle: `hiking.navigation.topo-terrain.v1` expected <= 3 MB (scenario JSON + shader variants).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (p5 >= 50), memory < 150 MB, cold launch < 2 s to `ready`, draw calls <= 150, <= 60k tris on screen, <= 15 materials, bundle <= 25 MB. Tighter for this sim: memory < 110 MB, one terrain mesh built in <= 250 ms on device (budget for `Loading`), viewshed rays <= 64 per query and computed in <= 8 ms, no per-frame allocations during Executing.

## 20. Telemetry
`telemetry` (no personal data): `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters: `hintsUsed`, `peeksUsed`, `decisionLatencyMs` (median), `timeouts`, `terrainBuildMs`, `scenarioIds` (array of ids, non-personal). Never `personName`/`relationship`.

## 21. Acceptance criteria (testable)
- AC-1: With seed 42, difficulty 1, `steepness-and-cliffs`, the sim emits exactly 3 `outcomes` and the same scenario order on every run.
- AC-2: Terrain built from a fixed seed is byte-identical across runs (hash of the height array equal).
- AC-3: `ready` is emitted within 2 s of `launch` (4 s including first framework load) on the reference device.
- AC-4: The result validates against `simulation-result.schema.json` for completed, aborted (each `abortReason`) and error paths.
- AC-5: For K1 scenarios, the marked correct Target is the leg with the greatest mean grade computed from the heightfield (never hand-authored inconsistently); a generator test asserts this for all S-01..S-14 truths.
- AC-6: For K2, the correct line never crosses a cell with slope > 45 degrees; all incorrect lines cross at least one.
- AC-7: For K5, viewshed truth equals a brute-force LOS reference on the same heightfield for 100 random points.
- AC-8: Every interactive Target has a hit area >= 44 x 44 pt at textScale 1.0 and 3.0.
- AC-9: Under `reducedMotion=true` there are no camera tweens > 0 frames and no looping animations; Executing completes in <= 1 s.
- AC-10: Explain copy: every title <= 6 words, every body <= 45 words, every "say this" <= 160 chars (checked over all copy keys).
- AC-11: Pause stops the water/hiker/timer; `durationMs` excludes paused time (tolerance 100 ms).
- AC-12: Abort at any state yields exactly one result with `aborted=true`, `completed=false`, `xpEarned=0`.
- AC-13: Invalid configuration (unknown key, `rounds=9`, bad enum) yields `error CONFIG_INVALID` and no result.
- AC-14: Difficulty 1-5 parameters match section 9 exactly (data-driven test).
- AC-15: With `colorBlindMode` != none, correct/incorrect outcomes are distinguishable by glyph and pattern (screenshot assertion for glyph objects).
- AC-16: No network calls occur (test with blocked networking).
- AC-17: Peak memory < 110 MB and p5 fps >= 50 in a scripted 3-round run on iPhone 13-class.
- AC-18: `personName` and `relationship` never appear in logs or telemetry (grep test).
- AC-19: Mastery signals stay within per-session caps and reference only conceptIds in section 3.
- AC-20: Replay reproduces identical outcome ids and hiker path for the same seed and inputs.

## 22. Test plan
- **EditMode:** heightfield determinism (AC-2); contour extraction correctness; grade computation (AC-5, AC-6); viewshed vs brute force (AC-7); scenario generator invariants (AC-1, AC-5); config validation (AC-13); scoring maths and caps (AC-19); copy length checks (AC-10); difficulty table (AC-14); result schema validity (AC-4).
- **PlayMode:** scene builds from code; scripted full 3-round run per scenario set; freeze/explain sequence order (gold pulse, rose outline, callout, say-this); pause/resume/abort (AC-11, AC-12); reduced-motion path (AC-9); tap-only scheme (AC-8); colorblind screenshots (AC-15); replay (AC-20).
- **Perf:** measured run on iPhone 13-class (AC-3, AC-17).

| AC id | Test type | Test name |
|---|---|---|
| AC-1 | EditMode | `Scenario_Order_IsDeterministicBySeed` |
| AC-2 | EditMode | `Heightfield_Hash_StableForSeed` |
| AC-3 | Perf | `Launch_ToReady_UnderBudget` |
| AC-4 | EditMode | `Result_ValidatesAgainstSchema_AllPaths` |
| AC-5 | EditMode | `K1_CorrectLeg_MatchesMeanGrade` |
| AC-6 | EditMode | `K2_CorrectLine_AvoidsCliffCells` |
| AC-7 | EditMode | `Viewshed_MatchesBruteForce` |
| AC-8 | PlayMode | `Targets_MeetMinHitSize_AtTextScales` |
| AC-9 | PlayMode | `ReducedMotion_NoTweensNoLoops` |
| AC-10 | EditMode | `Copy_LengthLimits` |
| AC-11 | PlayMode | `Pause_StopsTimersAndExcludesDuration` |
| AC-12 | PlayMode | `Abort_EmitsSingleAbortedResult` |
| AC-13 | EditMode | `Config_Invalid_YieldsConfigInvalid` |
| AC-14 | EditMode | `Difficulty_Table_Conforms` |
| AC-15 | PlayMode | `ColorBlind_GlyphsPresent` |
| AC-16 | PlayMode | `NoNetworkCalls` |
| AC-17 | Perf | `Memory_And_Fps_Budget_3Rounds` |
| AC-18 | EditMode | `Privacy_NoPersonalDataInLogs` |
| AC-19 | EditMode | `MasterySignals_WithinCapsAndConceptSet` |
| AC-20 | PlayMode | `Replay_IsDeterministic` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Can `Viewshed`, `ContourOverlay`, `Heightfield`/`TerrainMesh`, `SlopeShader`, `ProfileChart` be accepted as reusable Game Kit primitives (listed below)? | Astra | Yes for build |
| 2 | Should the `rv-03` review use `learnerContext.weakConcepts` to weight scenario choice inside Unity, or should native pass an explicit `scenarioSetId` weighting? (Proposed: native sends `scenarioSetId: mixed-refresher`; Unity weights by `weakConcepts`.) | Claude / Astra | No |
| 3 | Vertical exaggeration 1.0 vs 1.5 default in reveal shots: needs a look test on device. | Astra | No |
| 4 | Localized units: `units: m` copy for metric locales (copy uses ft in body text). | Product / Claude | No |
| 5 | The bridge README's planned CI check of `configuration` against this fragment (section 10) once the validator extension exists. | Claude | No |

### Game Kit additions requested
| New primitive | Responsibility | Reuse plan |
|---|---|---|
| `Heightfield` + `TerrainMesh` | Deterministic seeded heightfield (noise + named stamps), sampling, grade/aspect, and mesh builder (129 x 129, LOD-free). | Camping (campsite selection), Climbing (approach maps), Golf (green reading), Geology/skiing courses |
| `ContourOverlay` | Shader/marching-squares contour lines with interval, index lines and label placement; usable flat or draped. | Any map-based lesson |
| `SlopeShader` | Grade color ramp with hatching second channel (color-blind safe). | Skiing, trail running, golf |
| `Viewshed` | Line-of-sight rays and lit-cell viewshed from an eye point on a `Heightfield`. | Camping (view/camera placement), photography scouting |
| `ProfileChart` | Screen-space elevation profile of a `Path` over a `Heightfield`, with grade labels. | Cycling, running, any route course |
| Registry keys | environment `terrain_heightfield`; entity kinds `TerrainMesh`, `ContourOverlay`; objective types `choose_correct_target`; demonstrate types `terrain_lift`, `water_flow`, `viewshed`, `elevation_profile`; camera presets `oblique-low`. | Sim-definition registry (GAME_KIT.md section 3) |
