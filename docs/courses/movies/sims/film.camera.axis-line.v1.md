# Stay on Your Side (`film.camera.axis-line.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `film.camera.axis-line.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.x` (built against `1.0.0`); sim-definition `1.x` (scenarios are data; rule engine is a pure function) |
| Authors / date | Movies course design agent (Sonnet), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `movies`. CDS row: `docs/courses/movies/CDS.md` section 12, "The axis line (Tier A)".
- Manifest entry: `docs/courses/movies/manifest.json` -> `unitySimulations[]`.
- Launching lessons:

| unitId | lessonId | scenarioSetId | default difficulty |
|---|---|---|---|
| `motion-cut-and-sound` | `mc-04` (The 180-degree rule) | `axis-basics` | 1 |
| `reel-review` | `rv-03` (Camera moves refresher) | `axis-mixed` | learner-adaptive (2-4) |

- Prerequisite concepts: `cut-types`, `shot-reverse-shot` (native `mc-03`) should be `mastered`; otherwise `mc-04` shows a 30-second native primer.
- Accessible native path (this sim is not fully screen-reader accessible): lesson set `mc-04n` "The axis line, on paper": `binary-call` on a top-down diagram (procedural, `original-swoond`), `hotspot-tap` on camera positions, and a `sequence-order`/`multiple-choice` on the crossing methods. It is an alternate for `mc-04`, not an extra unit.

## 3. Learning objective(s) & concepts taught
- Learner-facing objective: "You can pick camera positions that keep a conversation oriented, and you can spot the cut that breaks it."
- Concepts (all must exist in the movies curriculum `concepts[]`):

| conceptId | term | After this the learner can... |
|---|---|---|
| `180-degree-rule` | 180-degree rule | Say cameras stay on one side of the imaginary line between two subjects so left and right stay consistent |
| `screen-direction` | Screen direction | Say which way a character looks or moves across the frame and that it should not flip on a cut |
| `eyeline-match` | Eyeline match | Say the next shot must place what a character looks at on the side they looked |
| `shot-reverse-shot` | Shot / reverse shot | Say the two alternate over-the-shoulder shots are taken from the same side of the line |
| `continuity-editing` | Continuity editing | Name three ways to cross the line without disorienting the audience (neutral shot, move across, character move) |

- Not taught here: the 30-degree rule and jump cuts (`mc-05`), triangle/master-scene coverage names, rule-breaking for effect in real films (native `mc-05` and `cinephile-talk` mention it; this sim keeps to the rule), how to shoot it. No real film frames appear.

## 4. Why Unity (tier justification)
Rubric (CLAUDE.md section 4):
- **Spatial reasoning + camera perspective.** The rule is about *where a camera sits in a room* and *what the audience sees when two shots are cut together*. The learning event is the disorientation: after the cut, both characters look the same way on screen. That needs a scene projected through two different cameras and a played cut.
- **Movement over time.** In advanced rounds the characters walk and the imaginary line moves; the learner must re-read the room.
- **Why not native.** Closest native: `binary-call` on a static top-down diagram (used for `mc-04n` and review), and `hotspot-tap` on camera positions. Those teach the geometry (which side is legal) but cannot *show* the flipped screen direction, which is the reason the rule exists; real film frames are unlicensed (spec section 40). Native remains the fallback and the review format.
- Verdict: a moderately strong case. It is the weaker of the two movies sims; if playtest shows no learning gain over `binary-call` plus a 3-panel diagram, downgrade (CDS open question 2).

## 5. Player fantasy & core loop
- Fantasy: "You are the director placing the second camera on a two-person scene, and the cut plays right in front of you."
- Core loop (one mechanic: **choose the next camera, then watch the cut**), 3 rounds by default:
  1. **Prompt:** a top-down room and a film-frame view from Camera 1 (two characters talking; the axis line is a gold dashed line on the top-down inset when shown). One line, <= 12 words: "Where does camera 2 go?"
  2. **One decisive interaction:** tap one of 3-5 numbered camera positions on the inset (or the matching chip below).
  3. **Execute:** a split view plays the cut: Shot 1 (Camera 1) then Shot 2 (chosen camera), with on-screen arrows for each visible character's look direction (screen-left or screen-right) and a "left/right check" tick or cross.
  4. **Freeze/explain:** time freezes on the cut; gold pulse on the legal side, rose outline on the pick if different; one callout card.
  5. **Line you could say out loud** (serif, in quotes), then Next.
- Session length: about 3 minutes (3 rounds x 50-60 s). `scenarioCount` configurable 1-6.

## 6. Scene & entities
- **Environment key:** `film_set_room` (NEW, procedural): a 10 x 10 m room with a table, two chairs (or an open floor), four walls (one removable for the top-down view), one directional light. Coordinates: x to the right, z "north" in the top-down inset; unit metres.
- **Camera presets:** `film-frame` (2.39:1 letterbox drawn in UI; FOV 40 degrees horizontal), `top-down-inset` (orthographic, 40% width), `split-cut` (two `film-frame` viewports side by side). All via `CameraRig` with reduced-motion cuts.
- **Rule engine (normative, pure function).** Characters `A` and `B` at positions `pA`, `pB` at the cut moment. `line side` of point `P`: `side(P) = sign((pB.x - pA.x) * (P.z - pA.z) - (pB.z - pA.z) * (P.x - pA.x))`. A candidate camera `C` is **legal** iff `side(C) == side(C_prev)` (the previous shot's camera) and `|side| != 0` (a camera exactly on the line is a `neutral` candidate: legal only in `cross-legally` rounds). Screen look direction of a character `X` facing unit vector `fX` seen by a camera with right vector `r`: `lookDir = sign(dot(r, fX))` (`+1` = screen-right). A cut is **consistent** iff every character visible in both shots has the same `lookDir`. For `eyeline` rounds the glance has a world direction `g` (unit vector from the character to the object `O`); an object-shot candidate matches iff `dot(normalize(target - pos), g) >= 0.5` (it looks the way the character looked, within 60 degrees), which is what makes the object appear where the audience believes it is. Minimum separation: all candidates are placed >= 45 degrees around the subject from Camera 1 (no jump-cut risk; the 30-degree rule is out of scope).

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `filmCam1`, `filmCamN` | `FilmCamera` (from `film.camera.lens-and-move.v1`, `Swoond.Film`) | Camera 1 and candidate cameras | position, target, focal 35 mm fixed |
| `charA`, `charB` | `Character` | The two speakers | stylized figures, facing vectors; optional walk `Path` in `moving` rounds |
| `axisLine` | `Zone`-line overlay via `Highlight` (gold dashed) | The imaginary line | recomputed each round; can be hidden |
| `camTargets` | `Target` | Selectable camera rings on the inset | ring >= 44 pt, `IsCorrect` per scenario |
| `lookArrows` | `Highlight` (arrow) | On-screen look direction indicators | gold = consistent, rose = flipped |
| `splitCut` | `CameraRig` preset `split-cut` (NEW preset, GK-19 family) | Shows Shot 1 and Shot 2 | swipe-free, auto-play 2 s each |
| `decision` | `DecisionPoint` (screen-space chips alternative, GK-3) | The single choice per round | option ids |
| `hint` | `Hint` | Progressive help | see difficulty |
| `explain` | `Explanation`, `SlowMotion`, `Replay` | Freeze/explain | section 12 |
| `score` | `Score` | Result builder | section 13 |
| `rules` | `AxisRules` (NEW, `Swoond.Film`, pure) | `Side`, `IsLegal`, `LookDir`, `IsConsistentCut`, `EyelineMatches` | as above |

- New primitives: `AxisRules` (pure, testable; also reusable by `sports` broadcast-camera lessons and film courses), env key `film_set_room`, camera preset `split-cut`. See "Game Kit additions requested".
- Initial layout (portrait):

```
+---------------------------+
| eyebrow: ROUND 1 OF 3     |
| "Where does camera 2 go?" |
| +---- camera 1 view ----+ |
| |  A ->          <- B   | |
| +-----------------------+ |
| [inset]   2   3           |
|   . A - - - B .  (line)   |
|      1 (cam1)   4         |
| [ Camera 2 ][ Camera 3 ]  |
| [ Camera 4 ]  (hint)      |
+---------------------------+
```

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Choose a camera | Tap a numbered ring on the inset, or the matching chip below | ring >= 44 pt; chip >= 44 pt tall | Ring fills rose; soft-tap haptic |
| Hint | Tap lightbulb-line icon | 44 x 44 pt | Progressive: (1) show the line, (2) shade the legal side, (3) dim illegal cameras |
| Replay the cut | "Replay" chip in Explain | 44 x 44 pt | Cut replays at 0.5x (stills under reduced motion) |
| Continue | Native-style pill drawn by Unity ("Next") | 56 pt tall | Primary style |

- **Tap-only scheme** is the default (chips are always shown under the inset). No drag.
- Portrait only. Safe-area insets from `runtime.safeAreaInsets`; interactive elements stay 16 pt inside.
- **Not drawn by Unity:** exit confirmation, hearts sheet, paywall, XP counter, lesson header.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received and valid | Validate config; build room and characters from the first scenario; theme fonts | success -> Intro; failure -> Aborted (`error`) | `ready`, `error` (`CONFIG_INVALID`, `SIMULATION_UNKNOWN`) |
| Intro | Loaded | Top-down pan-in; eyebrow "ROUND 1 OF N"; one-line teach card ("Two people talking. Cameras stay on one side.") skippable | "Start" or 3 s auto | none |
| Playing | Intro done / Next tapped | Show Camera 1 view, inset with candidates; `moving` rounds first play the walk (3 s; a still under reduced motion); timer if configured | ring/chip tapped -> Decision; timeout -> Decision | `progress` |
| Decision | Tap or timeout | Lock input; record choice, latency, hints | -> Executing | none |
| Executing | Decision recorded | Play the cut in `split-cut`: Shot 1, then Shot 2; arrows animate (<= 4 s; stills under reduced motion) | complete -> Freeze | none |
| Freeze | Executing done | Time ease to 0 (250 ms; hard cut if reduced motion); dim 35%; gold pulse on legal side, rose outline on pick | 400 ms -> Explain | none |
| Explain | Freeze done | Callout card + say-this; optional 0.5x replay | "Next" -> Playing or Summary | `checkpoint` (roundId) |
| Summary | Last round explained | Numerals count up (600 ms), one gold line | "Done" -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` | send result | `result`, `requestExit` (`completed`) |
| Paused | native `pause` | Stop timers, motion, audio | native `resume` | none |
| Aborted | `abort`, error, timeout | Partial result (`aborted=true`, reason, xp 0) | send result | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Candidate cameras | 3 | 3 | 4 | 4 | 5 |
| Axis line shown | always | always | on hint | on hint | off |
| Legal side shaded | on | off | off | off | off |
| Round kinds allowed | `place-camera` | + `eyeline` | + `moving` | + `cross-legally` | all, incl. near-line |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Replays of the cut | 3 | 2 | 2 | 1 | 1 |
| Decision time limit (s) | none | none | none | 20 | 12 |
| Near-line candidates (within 0.8 m of the line) | 0 | 0 | 0 | 1 | 2 |
| Scenario pool tags | `basic` | `basic`,`eyeline` | + `moving` | + `crossing` | + `subtle` |
- Default difficulty: `mc-04` 1; `rv-03` 2-4 by mastery. Level 1 is passable by a true beginner with hints.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "film.camera.axis-line.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["axis-basics", "axis-moving", "axis-crossing", "axis-mixed"], "default": "axis-basics" },
    "scenarioCount": { "type": "integer", "minimum": 1, "maximum": 6, "default": 3 },
    "showAxisLine": { "type": ["boolean", "null"], "default": null, "description": "null = by difficulty." },
    "replaysOverride": { "type": ["integer", "null"], "minimum": 0, "maximum": 5, "default": null },
    "decisionTimeLimitSeconds": { "type": ["number", "null"], "minimum": 5, "maximum": 60, "default": null }
  }
}
```
Valid: `{ "seed": 7, "scenarioSetId": "axis-basics", "scenarioCount": 3 }`. Invalid -> `error CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/axis-line-v1.json`, Addressables bundle `sim-film-axis-line`. Sets: `axis-basics` (6), `axis-moving` (4), `axis-crossing` (3), `axis-mixed` (3 additional, plus draws from the others). **N = 16** (>= rounds x 3). Deterministic per seed (order; left-right mirror of the whole room; candidate ring order).
- Shape:
```json
{
  "scenarioId": "ab-01", "kind": "place-camera",
  "prompt": "Where does camera 2 go?",
  "characters": { "A": { "pos": [-1.0, 0.0], "facing": [1.0, 0.0] }, "B": { "pos": [1.0, 0.0], "facing": [-1.0, 0.0] } },
  "camera1": { "pos": [0.0, -4.0], "target": [0.0, 0.0] },
  "candidates": [
    { "id": "c2", "pos": [-2.5, -2.0], "target": [1.0, 0.0] },
    { "id": "c3", "pos": [2.5, 2.0], "target": [-1.0, 0.0] },
    { "id": "c4", "pos": [0.0, 4.0], "target": [0.0, 0.0] }
  ],
  "best": ["c2"], "acceptable": [], "teaches": "180-degree-rule", "tags": ["basic"]
}
```
`best`/`acceptable` are checked against the rule engine at load (test AC-4), never trusted blindly.
- **Scenarios (16):**

| scenarioId | Kind | Setup | Best / acceptable / poor | Teaches | Tags |
|---|---|---|---|---|---|
| `ab-01` | place-camera | A (-1,0) faces east, B (1,0) faces west; cam1 (0,-4). Candidates: c2 (-2.5,-2) over A's shoulder at B, c3 (2.5,2) across the line at A, c4 (0,4) reverse master | c2 / none / c3, c4 | `180-degree-rule` | basic |
| `ab-02` | place-camera | Same room mirrored; candidates: c2 (2.5,-2) over B's shoulder at A, c3 (-2.5,2), c4 (2.5,2) | c2 / none / c3, c4 | `shot-reverse-shot` | basic |
| `ab-03` | place-camera | Cam1 above the line (0,4) this time; candidates c2 (-2.5,2), c3 (2.5,-2), c4 (2.5,2) | c2 and c4 (both legal) / none / c3 | `180-degree-rule` | basic |
| `ab-04` | eyeline | A (-1,0) faces east; in Shot 1 (cam1 (0,-4)) A glances screen-left at a door at (-5,-1) (world direction west). Candidates for the door shot: c2 pos (-1.5,-1) target (-5,-1); c3 pos (-7,-1) target (-1,-1) (from the door side, looking back east); c4 pos (-2,-2.5) target (-5,-1) | c2, c4 / none / c3 | `eyeline-match` | eyeline |
| `ab-05` | eyeline | B (1,0) faces west; B glances screen-right at a window at (5,-1) (world direction east). Candidates: c2 pos (1.5,-1) target (5,-1); c3 pos (7,-1) target (1,-1); c4 pos (2,-2.5) target (5,-1) | c2, c4 / none / c3 | `eyeline-match`, `screen-direction` | eyeline |
| `ab-06` | place-camera | Cam1 at (3,-3) (a corner angle); A, B as in `ab-01`. Candidates: c2 (-3,-3) legal; c3 (-3,3) across; c4 (3,3) across; c5 (0,-5) legal (45 degrees from cam1) | c2, c5 / none / c3, c4 | `180-degree-rule` | basic |
| `am-01` | moving | B walks from (1,0) to (-1,2) (axis becomes vertical x=-1); cam1 (0,-4) now on the right side; candidates c2 (1.5,1) legal, c3 (-4,1) across, c4 (0,5) legal | c2, c4 / none / c3 | `180-degree-rule`, `continuity-editing` | moving |
| `am-02` | moving | A walks around the table from (-1,0) to (0,-2); B stays; axis rotates; cam1 (0,-5) | side test with new line | `180-degree-rule` | moving |
| `am-03` | moving | Both walk in parallel to the north (walk-and-talk); axis stays vertical x-separation | cameras ahead of them legal | `screen-direction` | moving |
| `am-04` | moving | Characters swap seats (crossing paths on screen); cam1 unchanged | new line same side test | `continuity-editing` | moving |
| `ac-01` | cross-legally | "You must show the other side. Smoothest way?" options: plain cut across (poor), shot on the line first (best), track across in-shot (acceptable), flip Shot 2 in editing (poor) | neutral shot best / track across acceptable | `continuity-editing` | crossing |
| `ac-02` | cross-legally | Characters move so the line resets mid-shot; options: keep old side (acceptable), take new side (best), cut straight across (poor) | new side | `continuity-editing`, `180-degree-rule` | crossing |
| `ac-03` | cross-legally | Show a POV from inside the scene; neutral over-the-table shot | neutral shot | `continuity-editing` | crossing |
| `ax-01` | place-camera | Near-line candidates (z = -0.4 and +0.4); cam1 (0,-4) | z=-0.4 legal | `180-degree-rule` | subtle |
| `ax-02` | eyeline | A (-1,0) glances at an object at (3,3) (world direction (0.8,0.6)); candidates c2 pos (0,0) target (3,3), c3 pos (5,4) target (-1,0), c4 pos (1,-1) target (3,3), c5 pos (0,4) target (-3,3) | c2, c4 / none / c3, c5 | `eyeline-match` | subtle |
| `ax-03` | moving | Line rotates 90 degrees; near-line candidate | new-side candidate | `screen-direction` | subtle |

- **First three fully written:** `ab-01` (above), and:
```json
[
  { "scenarioId": "ab-02", "kind": "place-camera", "prompt": "Where does camera 2 go?",
    "characters": { "A": { "pos": [-1.0, 0.0], "facing": [1.0, 0.0] }, "B": { "pos": [1.0, 0.0], "facing": [-1.0, 0.0] } },
    "camera1": { "pos": [0.0, -4.0], "target": [0.0, 0.0] },
    "candidates": [
      { "id": "c2", "pos": [2.5, -2.0], "target": [-1.0, 0.0] },
      { "id": "c3", "pos": [-2.5, 2.0], "target": [1.0, 0.0] },
      { "id": "c4", "pos": [2.5, 2.0], "target": [-1.0, 0.0] }
    ],
    "best": ["c2"], "acceptable": [], "teaches": "shot-reverse-shot", "tags": ["basic"] },
  { "scenarioId": "ab-03", "kind": "place-camera", "prompt": "Where does camera 2 go?",
    "characters": { "A": { "pos": [-1.0, 0.0], "facing": [1.0, 0.0] }, "B": { "pos": [1.0, 0.0], "facing": [-1.0, 0.0] } },
    "camera1": { "pos": [0.0, 4.0], "target": [0.0, 0.0] },
    "candidates": [
      { "id": "c2", "pos": [-2.5, 2.0], "target": [1.0, 0.0] },
      { "id": "c3", "pos": [2.5, -2.0], "target": [-1.0, 0.0] },
      { "id": "c4", "pos": [2.5, 2.0], "target": [-1.0, 0.0] }
    ],
    "best": ["c2", "c4"], "acceptable": [], "teaches": "180-degree-rule", "tags": ["basic"] }
]
```
  Note on `ab-03`: two candidates are legal; the UI accepts either as `best`, and a legal pick that is not `best` would be `acceptable`.
- **Generation rules** for further scenarios: characters within 3 m; cam1 3-5 m from the midpoint; candidates at distance 2-4 m from the midpoint and >= 45 degrees around from cam1; at least one legal and one illegal candidate; near-line candidates at |z offset| 0.3-0.8 m only at difficulty >= 4; `best` is computed by the rule engine, not authored by hand (authored `best` is a test oracle).

## 12. Freeze / explain moments
Voice: cheeky coach, short sentences. Title <= 6 words, body <= 45 words.

| Id | Trigger | What freezes | Camera | Callouts | Correct title | Correct body | Incorrect title | Incorrect body | Say this |
|---|---|---|---|---|---|---|---|---|---|
| `E-LEGAL` | legal camera chosen (place-camera) | The cut, both shots side by side | `split-cut` + inset | Gold arrows: A looks right, B looks left in both shots; legal side shaded | "Same side, same screen." | "Both cameras stay on one side of the imaginary line between them. So she keeps looking screen-right and he screen-left. Your eyes never have to re-orient. That is the 180-degree rule." | "You crossed the line." | "The new camera sits on the far side of the line between them. Now both seem to look the same way, as if one turned their back. The audience loses the map. Try the shaded side." | "Stay on one side of the line and the room stays readable." |
| `E-EYELINE` | eyeline round | The cut | `split-cut` | Glance arrow in Shot 1, object position in Shot 2 | "Their look lands." | "She glances screen-left, so what she sees must appear where we believe she looked. Place the next shot so the object sits on that side. The look feels answered." | "The look doesn't land." | "She looked screen-left, but the object appears on the other side. It seems to float, or she seems to look past it. Match her look: same side of the frame." | "Match their look and we believe they saw it." |
| `E-MOVING` | moving round | Mid-walk, line redrawn | inset | New line in gold, old line ghosted | "The line moved." | "When people move, the line between them moves too. Redraw it from where they stand now, keep the side the audience last saw, and place the camera there. The rule follows the actors." | "Old line, new room." | "You used the line from before they moved. Redraw it between where they stand now. The last shot's camera decides which side is safe. Try again on the shaded side." | "The line goes where they go." |
| `E-CROSS` | cross-legally round | The three legal crossings shown | `split-cut` | Neutral shot on the line; track across arrow; character-move arrow | "Smart way across." | "You can cross the line with a shot placed on it, a camera move that crosses in view, or a character move that resets it. Each shows the audience the new side. Both worlds stay connected." | "That cut jars." | "A plain cut across the line flips left and right with no warning. Show them the new side first: a shot on the line, a visible camera move, or a character move. Then cut." | "Give the audience a bridge to the other side." |

- Wrong-pick sequence: gold pulse on the legal candidate (400 ms), rose outline on the learner's ring, callout card, then the say-this line.

## 13. Scoring & mastery signals
- Round outcome ids `round-1`.. Each: `best` = 1.0, `acceptable` = 0.5, else 0. `score = round(100 * sum/rounds) - min(15, 5 * hintsUsed)`, clamp 0-100; `accuracy` = `best` rounds / rounds.
- **Mistake -> conceptId mapping:**

| Mistake | conceptId | Description text |
|---|---|---|
| Camera on the far side of the line | `180-degree-rule` | "Placed the next camera across the line." |
| Cut flips a character's screen direction | `screen-direction` | "Left and right flipped across the cut." |
| Object on the wrong side after a glance | `eyeline-match` | "Placed what she looked at on the wrong side." |
| Used the old line after characters moved | `continuity-editing` | "Ignored that moving actors move the line." |
| Chooses a plain cut to cross | `continuity-editing` | "Crossed the line with no bridge shot." |
| Pairs same-side shots incorrectly as reverse | `shot-reverse-shot` | "Chose a reverse angle from the wrong side." |

- **Mastery signals:** correct first try +0.20 on the scenario's `teaches` concept; with hints +0.10; acceptable +0.05; wrong -0.15; per-session cap +0.40 and -0.30 per concept; `screen-direction` gets +0.05 on any consistent cut.
- Mapping to `SimulationResult`: `outcomes[]` per round (`value` = latency ms); `mistakes[]` per table; `masterySignals[]` as above.

## 14. XP & hearts
- `xpEarned` proposal: 10 per `best` round + 5 per `acceptable` + 40 for finishing (native clamps).
- `heartsLost`: 1 if `accuracy < 0.5` (max 1/session); none on abort; timeouts count as wrong rounds.
- `replayAvailable`: true after completion.

## 15. Failure states
| Failure | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Wrong round | Explain with incorrect copy; cut replays | `success=false`, mistake logged | counted at session end |
| Failed session (`accuracy < 0.5`) | "Two more tries and you'll feel the line." plus the hardest round replayed | `completed=true`, score low, heartsLost 1 | -1 |
| Timeout | Round wrong; correct shown | mistake "Ran out of time" | as wrong round |
| Abort | Native "Leave game?" | `aborted=true`, xp 0 | 0 |
| Backgrounded too long | Paused then aborted | `abortReason: backgrounded-too-long` | 0 |
| Asset missing | Error card + link to `mc-04n` | `error`, aborted result | 0 |
| Invalid config | Native falls back to `mc-04n` | `error CONFIG_INVALID` | 0 |
Failure always ends on an explain card.

## 16. Accessibility
- **Reduced motion:** walks and cuts play as stills (start/end plus arrows); no shake; hard-cut freeze.
- **Haptics off:** silent; visual cues remain.
- **Color-blind modes:** legal side shaded with hatch pattern (not color alone); arrows have a shape (filled arrowhead for "consistent", open for "flipped") plus text labels "Consistent" / "Flipped".
- **Text scale:** overlay text scales to 3x; chips stack; inset caption text is duplicated in chips.
- **Tap-only:** default.
- **Screen reader:** the room geometry is not readable live. Native fallback `mc-04n` (top-down diagram with `alt` text: "Camera 1 south of the line; camera 3 north of the line", `binary-call` "Same side or across?", `hotspot-tap`). Chips carry text such as "Camera 2, same side as camera 1, over her shoulder".
- **Photosensitivity:** no flashing; cut transitions are hard cuts with no strobing (max 1 cut per 500 ms).

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Ring/chip tap | soft click | soft tap | low |
| Cut plays | tiny "clack" (film slate, original) | none | low |
| Correct reveal | warm chime (original) | light success | medium |
| Wrong reveal | muted low tone | warning | low |
| Freeze | soft thud | soft tap | low |
Honour `soundEnabled`, `hapticsEnabled`. All audio original (`original-swoond`).

## 18. Art & asset list
| Asset | Procedural or external | Source & license | Size | Notes |
|---|---|---|---|---|
| Room, table, chairs, walls | Procedural | Astra, `original-swoond` | <= 6k tris | Flat colours from `theme` |
| Two stylized characters (capsule figures, distinct silhouettes plus name tags A/B) | Procedural | Astra | <= 1k tris each | No likeness of real people; no famous-film costumes or props |
| Camera icons, axis line, arrows, callouts | UI procedural | Astra | - | Instrument Serif + Geist |
| Sound cues | Original synth | Swoon'd | < 1 MB | Section 17 |
| Film stills, posters, clips | **None** | - | - | Never used |
Addressables bundle `sim-film-axis-line`, target <= 5 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps (5th percentile >= 50) on iPhone 13-class, < 150 MB, cold launch < 2 s, bundle <= 25 MB (this sim <= 5 MB), <= 150 draw calls, <= 60k triangles (this sim <= 12k). Split view renders two cameras at half resolution each.

## 20. Telemetry
`telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `gameKitVersion`, plus `hintsUsed`, `replaysUsed`, `decisionLatencyMsMedian`, `scenarioSetId`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. AC-1: With seed 42, difficulty 1, `axis-basics`, `scenarioCount` 3, the sim emits exactly 3 `outcomes` and a schema-valid result.
2. AC-2: `AxisRules.Side` returns the expected sign for 12 fixed point/line triples, including exactly-on-line (0).
3. AC-3: `IsLegal(C, Cprev, A, B)` matches the table for all candidates in `ab-01` to `ab-03`.
4. AC-4: For every scenario, the authored `best`/`acceptable` sets equal the rule engine's computed sets (oracle test).
5. AC-5: `LookDir` computed for A and B in Shot 1 and Shot 2 flips exactly for candidates on the far side (all scenarios).
6. AC-6: `EyelineMatches` is true for the authored eyeline `best` candidates and false for others.
7. AC-7: In `moving` rounds the axis is recomputed from the positions at the cut moment (test with `am-01`).
8. AC-8: Same seed and inputs reproduce identical scenario order and results; mirror transform preserves legality.
9. AC-9: Invalid config (`scenarioSetId: "x"`) yields `error CONFIG_INVALID`.
10. AC-10: Bridge conformance against `docs/contracts/unity-bridge/v1/examples/`.
11. AC-11: Explain copy lengths: title <= 6 words, body <= 45 words.
12. AC-12: Reduced motion: no continuous motion; stills used; no shake.
13. AC-13: All rings and chips >= 44 pt at text scale 1.0 and 3.0; ring separation >= 44 pt (no overlaps).
14. AC-14: Cold launch < 2 s; p5 fps >= 50 (perf).
15. AC-15: Mistake and mastery mapping matches section 13 in a scripted run.

## 22. Test plan
- **EditMode:** `AxisRules` pure functions (AC-2 to AC-7), oracle check of all scenarios (AC-4), determinism and mirror (AC-8), config validation (AC-9), result schema, copy lint (AC-11), scoring (AC-15).
- **PlayMode:** room builds from code; scripted full run per set; cut plays and arrows correct; moving round redraws the line; pause/resume/abort; reduced-motion; layout at text scale 3.0.
- **Perf:** iPhone 13-class run.

| AC | Test type | Test name |
|---|---|---|
| AC-1 | EditMode | `Result_ThreeRounds_SchemaValid` |
| AC-2 | EditMode | `Axis_Side_Signs` |
| AC-3 | EditMode | `Axis_IsLegal_BasicScenarios` |
| AC-4 | EditMode | `Scenarios_Best_MatchesRuleEngine` |
| AC-5 | EditMode | `Axis_LookDir_FlipsAcrossLine` |
| AC-6 | EditMode | `Axis_Eyeline_Matches` |
| AC-7 | PlayMode | `Moving_Round_RecomputesLine` |
| AC-8 | EditMode | `Determinism_And_Mirror` |
| AC-9 | EditMode | `Config_Invalid_ErrorsCleanly` |
| AC-10 | EditMode | `Bridge_Conformance_Examples` |
| AC-11 | EditMode | `Copy_Lengths_WithinLimits` |
| AC-12 | PlayMode | `ReducedMotion_UsesStills` |
| AC-13 | PlayMode | `HitTargets_MinSize_NoOverlap` |
| AC-14 | Perf | `Perf_Launch_And_Fps` |
| AC-15 | EditMode | `Scoring_MistakeMapping_Matches` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is this clearly better than native `binary-call` plus a 3-panel diagram? Playtest first; downgrade if not. | Product / Astra | No |
| 2 | Should the tutorial mention that filmmakers sometimes break the rule on purpose (native `mc-05` covers it)? | Product | No |
| 3 | The `neutral` candidate exactly on the line: is `0.05 m` off the line acceptable as "on" for hit testing? | Astra | No |
| 4 | Confirm the characters' look-direction rule (`lookDir` from facing vectors) is enough for `eyeline` rounds without gaze-target modelling. | Astra | No |

## Game Kit additions requested
- **`Swoond.Film` module:** `AxisRules` (pure functions `Side`, `IsLegal`, `LookDir`, `IsConsistentCut`, `EyelineMatches`), env key `film_set_room`, camera preset `split-cut` (two-viewport cut view; GK-19 family). Shares `FilmCamera` with `film.camera.lens-and-move.v1`.
- Reuse: `Character`, `Target`, `Highlight`, `Hint`, `Explanation`, `SlowMotion`, `Replay`, `Score`, screen-space chip `DecisionPoint` (GK-3), `Path` for walking.
- Registry keys: environment `film_set_room`; camera presets `split-cut`, `film-frame`, `top-down-inset`.
