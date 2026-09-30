# Read the Wall (`climbing.bouldering.problem-read.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `climbing.bouldering.problem-read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.x` (built against `1.0.0`). Not sim-definition data-driven: scenarios are data, the wall builder is new Game Kit code. |
| Authors / date | Climbing course design agent (Claude), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `climbing`. CDS row: `docs/courses/climbing/CDS.md` section 12, "Read the Wall (Tier A)".
- Manifest entry: `docs/courses/climbing/manifest.json` -> `unitySimulations[]`.

| unitId | lessonId | scenarioSetId | default difficulty |
|---|---|---|---|
| `reading-the-wall` | `rw-06` (Tilt the wall) | `wall-angles` | 1 |
| `reading-the-wall` | `rw-07` (Holds from every side) | `hold-faces` | 2 |
| `branch-bouldering` | `bb-03` (Read the whole problem) | `whole-problem` | 3 |
| `perpetual-review` | `pr-02` (Read the wall again) | `mixed-refresher` | learner-adaptive (2-4) |

- Prerequisite concepts: `hold-jug`, `hold-crimp`, `hold-sloper` should be `mastered` (native `rw-01`); otherwise `rw-06` shows a 30-second native primer first.
- Accessible native path (the sim is not fully screen-reader accessible): lesson `rw-08` "Wall reading without the 3D view" (hotspot-tap, multiple-choice, term-match and sequence-order on static procedural diagrams).

## 3. Learning objective(s) & concepts taught
- Learner-facing objective: "You can look at a climbing wall and read it: how steep it is, what shape each feature is, which way a hold faces, and where a problem starts, finishes and gets hard."
- This is **spectator literacy**. The learner reads a wall the way a friend at the gym does; nobody is shown climbing.

| conceptId | term | After this the learner can... |
|---|---|---|
| `wall-slab` | Slab | Recognize a wall that leans back from vertical |
| `wall-vertical` | Vertical wall | Recognize a wall at 90 degrees |
| `wall-overhang` | Overhang | Recognize a wall leaning out and say it loads the arms |
| `wall-roof` | Roof | Recognize a near-horizontal ceiling section |
| `arete` | Arete | Tell an outside corner from an inside corner |
| `dihedral` | Dihedral | Tell an inside corner from an outside corner |
| `volume` | Volume | Spot a large bolted-on shape and what it adds |
| `hold-sidepull` | Sidepull | Name a hold by which way it faces |
| `hold-undercling` | Undercling | Name a hold pulled from underneath |
| `hold-gaston` | Gaston | Name a hold pressed outward |
| `start-holds` | Start and finish holds | Find a problem's marked start and finish |
| `crux` | Crux | Point to where a problem looks hardest, and say why climbers say "usually" |
| `feature-reading` | Reading the wall | Take a moment to read before anything else |
| `top-out` | Top out | Recognize a finish over the top |
| `route-tape-colors` | Hold color and tape | Pick the holds that belong to one problem |

- Out of scope: how to climb, body position, footwork, how to fall, spotting, pads, belaying, ropes, gear, grades as numbers. No climber avatar, no movement simulation, no "best beta" grading. No real gym or brand.

## 4. Why Unity (tier justification)
Rubric (CLAUDE.md section 4), answered rigorously and skeptically:
- **Camera perspective is the concept.** Wall angle and hold orientation are 3D facts. A slab and an overhang can look alike in a front photo; an arete and a dihedral differ only in depth; whether a hold is a sidepull, undercling or gaston depends on which way it faces in space. Orbiting the camera is exactly how a person decodes this at the gym.
- **Closest native types and why they fall short.** `hotspot-tap` on a side-profile diagram teaches angle names (lessons `rw-05`, `rw-08`), and `visual-id` covers a hold from its best angle. Neither lets the learner discover the ambiguity that comes from one angle, which is the core insight.
- **What is NOT justification.** Movement, physics and timing are not used: there is no body simulation, because simulating a climber would teach technique, which this course refuses to do (CLAUDE.md section 3; course safety rule). No fall, no rope, no landing.
- **Verdict: justified but the thinnest Tier A case in the catalog.** It stays to one sim, four lessons, about 3 minutes each, with a complete native fallback. If Astra capacity is constrained, it is the first Tier A to cut; the course works with `rw-06`, `rw-07`, `bb-03`, `pr-02` replaced by hotspot-tap and multiple-choice (estimated quality loss: moderate on hold orientation, small elsewhere).

## 5. Player fantasy & core loop
- Fantasy: "You are the friend who looks at a wall and actually sees it."
- Core loop (one mechanic: **orbit, then call it**), 3 rounds by default:
  1. **Prompt:** a procedural wall with one highlighted element and a one-line question (Display M serif, 12 words or fewer) and 2 to 4 tappable answer chips.
  2. **One decisive interaction:** orbit or tap view presets to look, then tap an answer (or tap the holds the prompt asks for).
  3. **Execute:** camera eases to the side-on or a telling view, the highlighted element pulses rose, then the truth reveals.
  4. **Freeze/explain:** gold outline on the truth; callout card; "say this" line.
  5. **Line you could say out loud** (serif, in quotes), then Next.
- Session length: about 3 minutes (3 rounds x 50-60 s). `rounds` configurable 1-5.

## 6. Scene & entities
- **Environment key:** `climbing_wall` (NEW, procedural). A `WallBuilder` composes a boulder wall from `WallPanel`s (each with an angle in degrees from vertical), `Volume`s (boxes, wedges, pyramids), and `HoldShape`s from a small library (jug, crimp, sloper, pinch, pocket, sidepull, undercling, gaston). A padded floor and a neutral back wall give scale. No people, no logos, no posters.
- **Camera presets:** `orbit-wall` (free orbit, pitch -10 to +60, yaw +/- 75 degrees around the wall, distance 0.8-1.5x), `side-on`, `front-on`, `three-quarter`, `top-down` (extends GK-19 `CameraRig` presets). Reduced motion: presets cut, free orbit remains user-driven.

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `wall` | `WallBuilder` (NEW) + `WallPanel` (NEW) | The wall | panels[], angle -20 to 110 degrees |
| `volumes` | `Volume` (NEW, `Zone` variant) | Bolted features | shape, size, pose |
| `holds` | `HoldShape` (NEW) + `Target` | Holds; tappable | type, pose (facing vector), colour, tag |
| `tape` | `Highlight` | Outlines holds of one problem | colour id + shape second channel |
| `chips` | `DecisionPoint` | Answer chips (single choice) | 2-4 |
| `start-select` | `DecisionPoint` multi-select mode (GK-3) | Choose start holds | 1-2 |
| `views` | `CameraRig` | Orbit and presets | see above |
| `angle-gauge` | `Highlight` (NEW overlay `AngleGauge`) | Degrees from vertical at reveal | optional |
| `hint`, `explain`, `score` | `Hint`, `Explanation`, `Score` | Standard | sections 12-13 |

- New primitives (reusable by golf course reading, skate/skiing terrain, architecture and any "read a 3D shape" lesson): `WallBuilder`, `WallPanel`, `Volume`, `HoldShape`, `AngleGauge`. Everything else reuses Game Kit and GK-3, GK-12, GK-19.
- Layout (portrait, three-quarter view):

```
+---------------------------+
| ROUND 1 OF 3              |
| "Which wall leans out?"   |
|      __                   |
|    _/  \___ (A) slab      |
|   |  [B] vertical         |
|   |__ [C] overhang        |
| [Front][Side][Top] orbit  |
| [ Hint ]                  |
+---------------------------+
```

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Look around | One-finger drag orbits (yaw +/- 75, pitch -10..60) | full scene | Smooth, inertia off under reduced motion |
| Zoom | Two-finger pinch (0.8-1.5x) | n/a | Reset chip |
| Jump to view | View chips Front / Side / Top / 3/4 | 44 x 44 pt | Camera eases (cuts under reduced motion) |
| Choose answer | Tap a chip (or a hold Target) | >= 44 pt; hold hit area is inflated to 44 pt | Rose fill; soft haptic |
| Hint | Lightbulb-line icon | 44 x 44 pt | Progressive: (1) dim distractors, (2) auto-select the telling view, (3) show an angle gauge |
| Continue | Pill drawn by Unity ("Next") | 56 pt tall | Primary style |

- **Tap-only alternative:** the view chips and answer chips cover every round without orbiting. A learner who never drags can finish.
- Safe area, portrait only. Not drawn by Unity: paywall, hearts sheet, exit confirmation (native).

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received and valid | Validate config; build wall from scenario; theme fonts | success -> Intro; failure -> Aborted (`error`) | `ready` (with `gameKitVersion`), `error` on failure |
| Intro | Loaded | Wall turns 20 degrees to show it is 3D; eyebrow "ROUND 1 OF N"; teach card (skippable) | Tap "Start" or 3 s auto | none |
| Playing | Intro done / Next tapped | Show prompt and chips; orbit and view chips enabled; hint enabled | Answer tapped -> Decision; timer expiry -> Decision(timeout) | `progress` |
| Decision | Answer tapped or timeout | Lock input; record choice, views used, hints, latency | -> Executing | none |
| Executing | Decision recorded | Camera eases to the telling view (<= 1.2 s, cut under reduced motion); highlighted element pulses | complete -> Freeze | none |
| Freeze | Executing done | Dim 35%; gold outline on truth, rose outline on wrong pick | 400 ms -> Explain | none |
| Explain | Freeze done | Callout card + say-this line | "Next" -> Playing or Summary | `checkpoint` (roundId) |
| Summary | Last round explained | Numerals count up (600 ms), one gold line, concepts practiced | "Done" -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` | send result | `result`, then `requestExit` (`completed`) |
| Paused | native `pause` | Stop timers and camera inertia | native `resume` | none |
| Aborted | native `abort`, error or timeout | Stop; partial result (`aborted=true`, `abortReason`), `xpEarned` 0 | send result | `result`, then `requestExit` |

Exit affordance: an X drawn by Unity emits `requestExit` (`user-quit`); native shows "Leave game?" and replies `abort` if confirmed.

## 9. Difficulty levels 1-5
| Level | Round kinds in pool | Orbit needed to answer | Distractors | Hints | Decision timer | Wall complexity | Default for |
|---|---|---|---|---|---|---|---|
| 1 | K1 angle | No (side-on shown) | 2 | 3 | 0 (off) | 1 panel | `rw-06` |
| 2 | K1, K2, K3 (easy holds) | Helpful | 3 | 3 | 0 | 2 panels, 1 volume | `rw-07` |
| 3 | K2, K3, K4 | Needed | 3 | 2 | 0 | 3 panels, 2 volumes, 12 holds | `bb-03` |
| 4 | K3, K4, K5, K6 | Needed | 3 | 1 | 0 | 3 panels, 3 volumes, 20 holds | review |
| 5 | all kinds | Needed; hold types from odd angles | 4 | 0 | 0 | 4 panels, 4 volumes, 28 holds | review (high mastery) |

There is **never** a decision timer: nothing here is a reaction game and the course forbids speed pressure on safety-adjacent material. Level 1 is passable by a true beginner with hints.

## 10. Configuration schema
`LaunchRequest.configuration` (fields override the difficulty table when present; invalid -> `error CONFIG_INVALID`).

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://schemas.swoond.app/sims/climbing.bouldering.problem-read.v1.configuration.json",
  "title": "climbing.bouldering.problem-read.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647, "description": "Deterministic seed for scenario order and hold colours. Default: derived from sessionId." },
    "scenarioSetId": { "type": "string", "enum": ["wall-angles", "hold-faces", "whole-problem", "mixed-refresher"], "default": "wall-angles" },
    "rounds": { "type": "integer", "minimum": 1, "maximum": 5, "default": 3 },
    "difficulty": { "type": "integer", "minimum": 1, "maximum": 5, "description": "Overrides the lesson default." },
    "allowOrbit": { "type": "boolean", "description": "False forces preset-chip-only control. Default true." },
    "showAngleGauge": { "type": "boolean", "description": "Show degrees from vertical on reveal. Default from difficulty table (levels 1-3)." },
    "assetRoot": { "type": "string", "description": "Optional local path for the Addressables bundle root (bridge README section 5)." }
  }
}
```

Valid example:
```json
{ "seed": 42, "scenarioSetId": "hold-faces", "rounds": 3, "difficulty": 2, "allowOrbit": true }
```

## 11. Scenario data set
Scenarios are authored data (`scenarios/*.json`, about 4 KB each), deterministic per seed. Each has a wall recipe (panels, volumes, holds with facing vectors), a prompt, answer chips and the oracle answer. **N = 14 scenarios (rounds x 3 = 9 minimum for replay variety, plus a spare set).**

Round kinds: K1 `angle-id` (name a panel's angle), K2 `feature-id` (arete vs dihedral vs volume vs roof), K3 `hold-face` (name a hold by facing), K4 `problem-anatomy` (tap the start holds and the finish hold), K5 `find-crux` (tap where the problem looks hardest), K6 `which-problem` (tap all holds of one colour and shape set).

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| `ang-01` | One panel at +20 degrees leaning back; side-on shown | "Slab" | `wall-slab` | K1, L1 |
| `ang-02` | One panel at -30 degrees leaning out; front-on first | "Overhang" (orbit shows it) | `wall-overhang` | K1, L1 |
| `ang-03` | Three panels at 0, -30 and -90 degrees; highlight the third | "Roof" | `wall-roof` | K1, L2 |
| `ang-04` | One panel at 0 degrees, small holds | "Vertical" | `wall-vertical` | K1, L1 |
| `feat-01` | Two wall faces meeting outward; highlight the corner | "Arete" | `arete` | K2, L2 |
| `feat-02` | Two wall faces meeting inward; highlight the corner | "Dihedral" | `dihedral` | K2, L2 |
| `feat-03` | A large wedge bolted to a flat panel | "Volume" | `volume` | K2, L3 |
| `face-01` | Highlighted hold faces up at the viewer from the side wall | "Sidepull" (only obvious from the side view) | `hold-sidepull` | K3, L2 |
| `face-02` | Highlighted hold has an open slot facing down | "Undercling" | `hold-undercling` | K3, L3 |
| `face-03` | Highlighted hold faces outward with a flat back edge | "Gaston" | `hold-gaston` | K3, L4 |
| `prob-01` | Green holds on a 3-panel wall; two tagged start holds low, one finish hold high | Tap the two start holds and the top hold | `start-holds`, `top-out` | K4, L3 |
| `crux-01` | Problem on a 2-panel wall: vertical start, then the panel tips to -30 degrees with smaller, farther-apart holds | Tap the hold at the change of angle | `crux` | K5, L4 |
| `crux-02` | Problem on a flat wall whose last two holds are far apart and small | Tap the gap before the finish | `crux` | K5, L4 |
| `prob-02` | Same wall; two colours interleaved; "tap the red problem" | The red set | `route-tape-colors` | K6, L3 |

First three fully written:

**`ang-01`.** Wall: one panel, angle +20 degrees (leaning back), 12 medium jugs. Prompt: "Which name fits this wall?" Chips: Slab, Vertical, Overhang. Oracle: Slab. Explain trigger on answer. Hint 1 dims Overhang; hint 2 jumps to side-on; hint 3 shows "20 degrees back" gauge.

**`ang-02`.** Wall: one panel, -30 degrees (leaning out), 10 jugs and 4 crimps. Front-on view shows a flat rectangle; side-on shows the lean. Prompt: "Is this wall leaning in or out?" Chips: Slab, Vertical, Overhang. Oracle: Overhang. Explain: "From the front it looks flat. From the side, it leans out. That is why climbers look at walls from more than one spot."

**`ang-03`.** Wall: three panels (0, -30, -90 degrees) stacked so the last hangs over the floor. Highlight panel 3. Prompt: "What is the highlighted section?" Chips: Roof, Overhang, Slab. Oracle: Roof.

Generation rules for variety: the three wall angle values for K1 are drawn from {+20, 0, -20, -30, -45, -90} with a minimum 20 degree spread between distractors; hold colours come from the six-colour palette with a shape second channel; `seed` shuffles scenario order and mirrors left/right.

## 12. Freeze / explain moments
Copy rules: title <= 6 words, body <= 45 words, optional say-this line in quotes.

| Trigger | Freeze | Camera | Callout | Title | Body | Say this |
|---|---|---|---|---|---|---|
| K1 correct | Dim 35% | Side-on | AngleGauge on the panel | Nice read. | That panel leans back from vertical, so it is a slab. Slabs lean away, so your feet carry more of you than your arms. | "That's a slab. It's all feet." |
| K1 incorrect | Dim 35% | Side-on | Gauge on the truth, rose outline on the pick | Not quite. | Look at it from the side. This one leans out past vertical, so it is an overhang, and your arms carry more of you. | "It looks flat from the front. The side view gives it away." |
| K2 correct | Dim | Top-down | Corner outlined | Nice read. | Outside corner means arete, like a building's edge. Inside corner means dihedral, like an open book. | "That's an arete. I like an arete." |
| K2 incorrect | Dim | Top-down | Both corners outlined with labels | Not quite. | From above you can see which way the corner points. Out is an arete. In is a dihedral. | "Outside corner is an arete." |
| K3 correct | Dim | Close on the hold | Facing arrow drawn | Nice read. | The hold's face points away from the camera in a way that only shows from the side. Which way it faces decides what kind it is. | "It's a sidepull. You'd pull it from the side." |
| K3 incorrect | Dim | Close | Facing arrow on the truth | Not quite. | Orbit and look at which way the hold opens. It is the opening and its direction that name it, not how big it looks. | "Hold names are about the direction, not the size." |
| K4 correct | Dim | Front-on | Tagged holds glow gold | Nice read. | Start holds are tagged, usually low. The finish hold is marked near the top. Every problem tells you where it begins and ends. | "Find the start tags first." |
| K4 incorrect | Dim | Front-on | Tags highlighted | Not quite. | Look for the tags near the bottom and the marked hold at the top. Colour alone does not tell you the start. | "The tags tell you where to start." |
| K5 correct | Dim | Side-on | Crux zone glows | Nice read. | The hard part is usually where the wall steepens and holds get smaller or farther apart. Climbers say usually, because only the person on the wall really knows. | "That looks like the crux. Only she'd know." |
| K5 incorrect | Dim | Side-on | Crux zone | Not quite. | Look for where the wall gets steeper or the holds thin out. That is often where a problem gets hard. | "Where does it steepen?" |
| K6 correct | Dim | Front-on | Problem set glows | Nice read. | Gyms mark a problem by colour or tape. You follow one colour; the others belong to other climbs. | "Follow your colour." |
| K6 incorrect | Dim | Front-on | Both sets labelled | Not quite. | Holds of one colour make one problem. The others are a different problem on the same wall. | "One colour, one problem." |

Summary gold line: "You can read a wall. Now you can ask her what she sees."

## 13. Scoring & mastery signals
- **Round score (0-100):** correct = `max(40, 100 - 20*hintsUsed)`; incorrect = 0; K4 partial (start holds right but finish wrong, or the reverse) = 50.
- **Session `score`:** mean of round scores (rounded). **`accuracy`:** correct rounds / rounds.
- **Outcome ids:** `round-<n>-<kind>` with `success`, `label` (scenarioId), `value` (roundScore).

| Mistake | conceptId | Description text |
|---|---|---|
| Called an overhang a slab or vertical | `wall-overhang` | Judged angle from one view. |
| Called a slab vertical | `wall-slab` | Missed the lean back. |
| Called a roof an overhang | `wall-roof` | Missed the near-horizontal panel. |
| Mixed arete and dihedral | `arete` / `dihedral` | Confused outside and inside corners. |
| Missed the volume | `volume` | Did not see the bolted shape. |
| Named a sidepull wrongly | `hold-sidepull` | Named the hold by size, not facing. |
| Named an undercling wrongly | `hold-undercling` | Missed the downward facing. |
| Named a gaston wrongly | `hold-gaston` | Missed the outward press. |
| Wrong start or finish | `start-holds` | Missed the tags. |
| Wrong crux | `crux` | Did not find the steepest or thinnest part. |
| Wrong colour set | `route-tape-colors` | Followed the wrong colour. |

| Mastery signal event | conceptId | delta | Evidence text |
|---|---|---|---|
| Correct, no hint | scenario concept | +0.20 | "Read the wall correctly with no help." |
| Correct after 1 hint | scenario concept | +0.10 | "Read the wall with one hint." |
| Correct after 2+ hints | scenario concept | +0.05 | "Needed hints to read the wall." |
| Incorrect | mistake concept | -0.15 | "Misread the wall in <scenarioId>." |

Caps per session: +0.40 and -0.30 per concept. `outcomes[]` = one per round; `mistakes[]` = `{conceptId, description, at: roundIndex}`; `masterySignals[]` per table; `score` and `accuracy` as defined; `telemetry.hintsUsed`.

## 14. XP & hearts
- `xpEarned`: +10 per correct round, +40 if the session completes (native clamps to the lesson budget); 0 when aborted.
- `heartsLost`: 1 if accuracy < 0.5 (2 or more of 3 rounds wrong); never more than 1 per session. Hints never cost hearts.
- `replayAvailable`: `true` after Done (deterministic by seed). Replay is free.

## 15. Failure states
| Case | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round | Not-quite card with the answer highlighted; Next | `outcomes[i].success=false`, mistake, mastery -0.15 | No (session rule only) |
| Failed session (accuracy < 0.5) | Summary: "Rough read. Walls look different from the side." plus retry via native | `completed=true`, low `score`; `heartsLost=1` | Yes, max 1 |
| Abort (user quit, backgrounded > 120 s) | Native handles UI | `aborted=true`, `abortReason`, `xpEarned=0` | No |
| Asset missing | Native "Try again" | `error ASSET_LOAD_FAILED` recoverable | No |
| Invalid config | Native error and skip option | `error CONFIG_INVALID` | No |
| Low memory / crash | Native offers resume from last `checkpoint` | none | No |

Every failure path passes through an Explain moment; no dead ends. No timeout state exists (no timer).

## 16. Accessibility
- Reduced motion: camera eases become cuts, no inertia, no pulsing (static outline change instead).
- Haptics off honors `hapticsEnabled`.
- Colour-blind modes: each hold colour pairs with a shape mark (triangle, circle, square, diamond, star, bar); gold/rose outlines pair with a thicker dashed style for the wrong pick.
- Text scale follows native; chips grow, they do not truncate (2-line wrap).
- Tap-only control: view chips and answer chips cover every round (section 7).
- VoiceOver/TalkBack: limited in Unity. **Accessible native fallback lesson: `rw-08`** "Wall reading without the 3D view" (hotspot-tap on side profiles, term-match on holds, sequence-order of angles). Native auto-routes learners with VoiceOver to `rw-08` and credits the same conceptIds.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Answer tapped | Soft tick | Light | 0.4 |
| Correct reveal | Two-note rising chime | Light success | 0.5 |
| Incorrect reveal | Low single note | Soft tap | 0.3 |
| Next / Done | Soft tick | none | 0.3 |

All honor `soundEnabled` and `hapticsEnabled`. No music.

## 18. Art & asset list
| Asset | Procedural or external | Source & license | Size | Notes |
|---|---|---|---|---|
| Wall panels, volumes | Procedural | `original-swoond` | < 2k tris | Flat shaded, quiet colour |
| Hold library (8 shapes) | Procedural (lofted profiles) | `original-swoond` | < 300 tris each | No photographic textures |
| Floor pad, back wall | Procedural | `original-swoond` | trivial | Neutral, no branding |
| Overlay styling | Native tokens from `theme` | n/a | n/a | Rose = you, gold = earned |
| Fonts | Native-supplied | OFL (Instrument Serif, Geist) | n/a | Via `theme` |

No human figure, no photographic gym imagery, no brand holds or logos. Addressables bundle `climbing-problem-read` (target < 8 MB).

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps on iPhone 13 class, memory < 150 MB, cold launch < 2 s. Tighter: scene < 25k triangles, < 60 draw calls with GPU instancing for holds, bundle < 8 MB.

## 20. Telemetry
`telemetry`: `fps` (p50, p5), `loadMs`, `peakMemoryMb`, `hintsUsed`, `viewsUsed` (count of orbit or chip changes), `decisionLatencyMs` (per round). No personal data, no Person name or relationship.

## 21. Acceptance criteria (testable)
- AC-1: With seed 42, difficulty 1 and `wall-angles`, the sim emits exactly 3 `outcomes`.
- AC-2: Same seed and config produce the same scenario order and hold colours (determinism).
- AC-3: `ready`, `progress` per round, `checkpoint` per Explain, `result` and `requestExit` are emitted in order and validate against the bridge schemas.
- AC-4: Invalid config (`rounds` 9) yields `error CONFIG_INVALID` and no scene.
- AC-5: The scene contains no entity of type Character (no human figure).
- AC-6: Every round is answerable using only the view chips and answer chips (tap-only).
- AC-7: Explain copy: titles <= 6 words, bodies <= 45 words, say-this lines <= 12 words.
- AC-8: No timer exists; `decisionTimerSeconds` is not a config field.
- AC-9: Reduced motion: no camera sweep longer than 0 ms; outlines do not pulse.
- AC-10: Budget: >= 55 fps p5 on iPhone 13-class, memory < 150 MB, cold launch < 2 s, bundle < 8 MB.
- AC-11: Every hold colour has a distinct shape mark in colour-blind mode.
- AC-12: Mastery signals stay within per-session caps.

## 22. Test plan
- **EditMode:** scenario oracle correctness (each scenario's answer matches its wall data: angle bands, facing vectors, corner sign); config validation; result schema validity; scoring maths; determinism by seed.
- **PlayMode:** scene builds from code; full run with scripted taps; freeze/explain sequence; pause/resume/abort; reduced-motion path; tap-only path.
- **Perf:** measured run on iPhone 13-class.

| AC id | Test type | Test name |
|---|---|---|
| AC-1, AC-2 | EditMode | `ScenarioOrder_IsDeterministic` |
| AC-3 | PlayMode | `Bridge_EventOrder_ValidatesSchemas` |
| AC-4 | EditMode | `Config_Invalid_ReturnsConfigInvalid` |
| AC-5 | PlayMode | `Scene_HasNoCharacter` |
| AC-6 | PlayMode | `TapOnly_CompletesAllKinds` |
| AC-7 | EditMode | `ExplainCopy_LengthLimits` |
| AC-8 | EditMode | `Config_NoTimerField` |
| AC-9 | PlayMode | `ReducedMotion_NoSweeps` |
| AC-10 | Perf | `Perf_iPhone13_Budget` |
| AC-11 | PlayMode | `ColourBlind_ShapeMarks` |
| AC-12 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is a 3D read of a wall worth a Tier A slot versus the native fallback, given Astra capacity? (this spec argues yes narrowly; cut-first candidate) | Product / Astra | No |
| 2 | Should `WallBuilder` and `HoldShape` be promoted to a Game Kit module (`Swoond.Climbing`) for future climbing sims? | Astra | No |
| 3 | Does "where the crux usually is" as an authored heuristic need SME review (a certified route setter)? | Claude / SME | Before approval |
| 4 | Camera preset `orbit-wall` as a GK-19 family member, or sim-local? | Astra | No |

## Game Kit additions requested
- `WallBuilder`, `WallPanel`, `Volume`, `HoldShape`, `AngleGauge` (new; one-sim use today, reusable for golf green reading, skiing terrain, architecture and sculpture "read a 3D shape" lessons). Environment key `climbing_wall`.
- Camera preset `orbit-wall` (family of GK-19).
- Uses GK-3 (multi-select `DecisionPoint` for start holds) and GK-12 (`choose_target`).
