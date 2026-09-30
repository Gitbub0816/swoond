# Route Lab (`football.routes.build.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `football.routes.build.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition not used (scenario-data driven) |
| Authors / date | Claude Code (content agent) / 2026-09-30 |
| Changelog | 1.0.0: first spec |

## 2. Course & lesson links
- `courseId`: `american-football`. Unit `offense-basics`, lesson `route-lab-05` (default difficulty 2). Also reused by review lesson cards in `always-on-review` (difficulty 2-3).
- CDS Interaction plan row U2. Manifest: `unitySimulations[]` entry `football.routes.build.v1`.
- Prerequisites (mastered, else native primer): `route-tree`, `wide-receiver`, `formation`. Lesson `routes-04` (native term-match/visual-id) comes first.
- Native accessibility fallback lesson: `route-lab-05-fallback` (sequence-order and hotspot-tap: "put the break at the right depth" on a static diagram).

## 3. Learning objective(s) & concepts taught
- Objective: "You can draw a route the way a receiver runs it: the right depth, the right cut, and the right name."

| conceptId | term | After this the learner can... |
|---|---|---|
| `route-tree` | Route tree | Place routes on the tree by depth and cut angle. |
| `slant-route` | Slant | Draw a short 45-degree inside cut after 3 yards. |
| `out-route` | Out | Draw an 8-10 yard stem and a 90-degree cut to the sideline. |
| `curl-route` | Curl | Draw a 10-12 yard stem and a turn back to the quarterback. |
| `post-route` | Post | Draw a 12-yard stem and a 45-degree cut to the goalposts. |
| `go-route` | Go | Draw a straight vertical. |
| `quarterback-progression` | (light touch at L4-5) | Say why a route is chosen against a coverage. |

Scope limit: no route names beyond the tree (no option routes, no scramble rules), no blocking, no ball flight. Dig, corner, hitch and comeback appear at level 3 or higher and credit `route-tree` only (they have no Playbook entry of their own).

## 4. Why Unity (tier justification)
- **Spatial reasoning (yes):** routes are geometry: depth in yards and cut in degrees. Building the path with your finger and watching the receiver run it (and a defender react) teaches the shape better than a name. Route names are often confused ("Is that a corner or a post?") because both cut at 45 degrees; the difference is the direction relative to the sideline, visible only spatially.
- **Movement over time (yes):** the run phase shows the break point and the defender's reaction, which produce separation.
- **Native alternative:** `visual-id` (static route diagram to name) and `hotspot-tap` (tap where the break occurs) cover recognition, and are used in `routes-04`. They cannot teach construction, or the effect of depth on separation. Weakest of the five sims: if playtests show no learning gain over `visual-id` plus `hotspot-tap`, downgrade to native (recorded in open questions).

## 5. Player fantasy & core loop
- Fantasy: "You are the offensive coordinator drawing the play on a whiteboard, and then watching it work."
- Loop (3 rounds, about 3 minutes):
  1. **Prompt**: "Draw a post." (levels 1-3) or "3rd and 8 against Cover 3. Get 8 yards." (levels 4-5).
  2. **Decisive interaction**: drag the depth handle to set the stem, then swing the cut handle to set the angle. Tap "Run it".
  3. **Execute**: receiver runs it; one defender reacts.
  4. **Freeze / explain**: top-down freeze with your route in rose, the correct route in gold, and the classified name of what you drew.
  5. **Say-this line**.

## 6. Scene & entities
- Environment `football_field` (procedural), camera `top-down` (receiver at the bottom third, 12 yd of width, 26 yd of depth); `broadcast-side` for replay.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `rx` | `Receiver` | the receiver you route | alignment by scenario, speed 8.0 yd/s |
| `qb` | `Quarterback` | static, visible for context | (0,-5) |
| `def_1` | `Defender` | reacts to the route | `press`, `off-man`, `zone-hook`, `zone-deep-third`, `zone-flat` |
| `def_2` | `Defender` | optional (deep safety) | scenarios 10-12 |
| `handle_stem` | `Target` (draggable) | sets depth | snaps to 1 yd |
| `handle_cut` | `Target` (draggable) | sets cut angle | snaps to 15 degrees |
| `route_you` | `Path` (rose) | your route | Path.Draw rose |
| `route_ref` | `Path` (gold) | reference route | shown at explain |
| `ruler` | `Zone` strips every 5 yd | depth reference | translucent |
| `PathEditor` | new primitive (see below) | drag-editing of a two-segment path | |
| `RouteClassifier` | `Swoond.Sports.Football` | maps (depth, angle) to route name | data table section 11 |

Game Kit additions requested: **`PathEditor`** (TouchController + Path): draggable waypoints with snap-to-grid, angle snapping, min/max length and accessible stepper alternative. Reuse plan: golf shot shape (aim points), racing-line editor (NASCAR/F1 units), hiking route planning demos. **`RouteClassifier`** is a football-module class, not a kit primitive.

Layout (top-down, `X` = receiver, `D` = defender, `Q` = quarterback):
```
 (deep)
          |
   ruler  |    <- handle_stem drags up this line
   5 yd --|
          X  D
          Q
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Set depth | Drag `handle_stem` up/down (snaps per yard; label shows yards) | vertical line above receiver | handle 56 pt | tick haptic every yard |
| Set cut | Drag `handle_cut` around `handle_stem` (snaps 15 degrees; label shows "45 in") | arc | handle 56 pt | tick haptic every snap |
| Run it | Tap pill | bottom | 56 pt | soft tap |
| Hint | Tap "Show ghost" | shows the target zone for 2 s | 44 pt | hint used |
| **Tap-only scheme** (accessibility / alternative) | Depth stepper (- / +) and six cut chips: Straight, In 45, In 90, Out 45, Out 90, Back | chips row | 44 pt | selected chip rose |

The tap-only scheme is fully equivalent and is enabled by `inputScheme: "chips"`, or automatically when Switch Control or VoiceOver is on. Portrait only; safe areas honored. Native draws hearts, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Bridge events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build scene | Intro | `ready` |
| Intro | ready | Prompt card, receiver at alignment, ruler fades in | first touch or Start | `progress` 0 |
| Playing (Build) | Intro done | Learner edits handles; live route preview drawn in rose with the depth and angle labels | tap Run it | none |
| Decision | Run it | Route locked, DecisionPoint committed | Executing | none |
| Executing | Locked | Receiver runs the route (2.0-3.5 s), defender reacts, separation meter | route ends | none |
| Freeze | Route ends | Freeze; camera to top-down; gold reference route drawn | 400 ms | none |
| Explain | Freeze | Classified name, separation number, copy card | Continue | `checkpoint` |
| Summary | All rounds done | Score card | Done | none |
| Done | Done | Emit result | end | `result`, `requestExit` |
| Paused / Aborted | native commands | Freeze timers; abort emits `aborted=true`, xp 0 | end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Prompt type | named route | named route | named route | situation (any route) | situation (any route) |
| Route pool | slant, out, go | + curl, post | + hitch, dig, corner, comeback | 8 routes | 8 routes |
| Depth tolerance (yd) | 2.5 | 2.0 | 1.5 | n/a (sim measures) | n/a |
| Angle tolerance (deg) | 25 | 20 | 15 | n/a | n/a |
| Ghost target zone shown | always | on hint | on hint | off | off |
| Hints per session | unlimited | 3 | 2 | 1 | 0 |
| Snap assist | depth and angle | depth and angle | depth | depth | none |
| Defender behavior | off-man, no reaction | reacts lightly | reacts | reacts (zone types) | reacts (mixed) |
| Time limit per build | none | none | 45 s | 30 s | 20 s |
Level 1 is passable by a true beginner (wide tolerance, ghost zone, only three routes). Default for `route-lab-05`: 2.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "football.routes.build.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0 },
    "scenarioSetId": { "type": "string", "enum": ["routes-starter", "routes-full", "routes-situations"], "default": "routes-starter" },
    "scenarioCount": { "type": "integer", "minimum": 1, "maximum": 5, "default": 3 },
    "routeFamilies": {
      "type": "array", "uniqueItems": true, "minItems": 1,
      "items": { "type": "string", "enum": ["slant", "hitch", "out", "curl", "dig", "post", "corner", "comeback", "go"] }
    },
    "inputScheme": { "type": "string", "enum": ["drag", "chips"], "default": "drag" },
    "showGhost": { "type": "boolean" },
    "depthToleranceYd": { "type": "number", "minimum": 0.5, "maximum": 4 },
    "angleToleranceDeg": { "type": "number", "minimum": 5, "maximum": 40 },
    "buildTimeLimitSec": { "type": ["number", "null"], "minimum": 10, "maximum": 120 }
  }
}
```
Valid example: `{ "scenarioSetId": "routes-starter", "scenarioCount": 3, "routeFamilies": ["slant", "out", "post", "curl"], "inputScheme": "drag" }`. Invalid config: `error CONFIG_INVALID`.

## 11. Scenario data set
Format: `Assets/Sims/Football/Routes/scenarios/<set>.json`. **Minimum count: 12** (rounds x 3 = 9; 12 shipped): `routes-starter` (rb-01 to rb-06), `routes-full` (rb-07 to rb-09 plus repeats with different alignments), `routes-situations` (rb-10 to rb-12). Angle convention: 0 = straight upfield, positive = toward the sideline, negative = toward the middle, 180 = back to the quarterback. Deterministic per seed (order); alignment mirrored left or right by seed. Route reference table (`RouteClassifier`):

| route | stem depth (yd) | cut (deg) | break length (yd) | concept |
|---|---|---|---|---|
| slant | 3 | -45 | 8 | `slant-route` |
| hitch | 6 | 180 | 1 | `route-tree` |
| out | 9 | +90 | 8 | `out-route` |
| curl | 11 | 180 (slightly inside) | 2 | `curl-route` |
| dig | 12 | -90 | 10 | `route-tree` |
| post | 12 | -45 | 12 | `post-route` |
| corner | 12 | +45 | 12 | `route-tree` |
| comeback | 16 | +150 | 3 | `route-tree` |
| go | 30 | 0 | 0 | `go-route` |

| scenarioId | Setup | Correct decision | conceptId | Tags |
|---|---|---|---|---|
| `rb-01-slant` | Left slot at (-7,0); defender `def_1` off-man 6 yd deep, shaded outside. Prompt: "Draw a slant." | depth 3 +/- tol, cut -45 +/- tol | `slant-route` | starter |
| `rb-02-out` | Split end at (-15,0), off-man corner at (-15,7). "Draw an out." | depth 9, cut +90 | `out-route` | starter |
| `rb-03-go` | Split end at (15,0), press corner at (15,1). "Draw a go." | depth >= 24, cut 0 (+/- 10) | `go-route` | starter |
| `rb-04-curl` | Right slot (8,0), hook defender at (5,8) zone. "Draw a curl." | depth 11, cut 180 (+/- 25) | `curl-route` | starter |
| `rb-05-post` | Left end (-14,0), single-high safety (0,13). "Draw a post." | depth 12, cut -45 | `post-route` | starter |
| `rb-06-hitch` | Right end (15,0), off corner at (15,8). "Draw a hitch." | depth 6, cut 180 | `route-tree` | full |
| `rb-07-dig` | Slot (-7,0), zone defenders at hook. "Draw a dig." | depth 12, cut -90 | `route-tree` | full |
| `rb-08-corner` | End (14,0), two-high safeties. "Draw a corner." | depth 12, cut +45 | `route-tree` | full |
| `rb-09-comeback` | End (-15,0), corner bailing. "Draw a comeback." | depth 16, cut +150 | `route-tree` | full |
| `rb-10-cover3-need8` | 3rd and 8, Cover 3 (corners deep at y=17, hooks at y=9, flat defender at (10,4)). Get a first down. | any route resolving with `separation >= 2.0` and gain >= 8; best is curl or dig at 9-11 yd | `curl-route` | situation |
| `rb-11-cover2-sideline` | 2nd and 6, Cover 2; corner squats at (15,5), safeties at (+-9,12). | any route landing in the sideline hole at 12+ yd (corner or out-and-up) with separation >= 2.0 | `route-tree` | situation |
| `rb-12-press-man-quick` | 3rd and 4, press man, no safety (blitz). | quick route reaching 4 yd inside 1.2 s (slant) | `slant-route` | situation |

Full detail, first three: 
- **rb-01**: receiver `rx(-7,0)` slot; `def_1(-7,6)`, off-man, mirrors the receiver with a 0.35 s reaction delay and slight outside shade (x-1.0). Correct route: stem to (-7,3), cut to (-1, 9). Separation at end for the correct route: 2.4 yd (the defender is shaded outside so the inside cut wins). If the learner draws depth 6, the sim classifies a "hitch or curl" hybrid (flagged "not a slant").
- **rb-02**: `rx(-15,0)`, `def_1(-15,7)`. Correct: stem to (-15,9), cut to (-23,9) toward the sideline (the field edge is at x=-26.7). Separation for a correct out: 2.8 yd.
- **rb-03**: `rx(15,0)`, press `def_1(15,1)`. Correct: stem to y >= 24. The defender runs with the receiver; the sim shows that there is no break and the win is speed and timing (separation 1.0 yd, informational only).

Generation rule for more scenarios: choose a route from the table; alignment from {split-end, slot, tight}; mirror by seed; defender behavior from {off-man, press, zone hook, zone flat} weighted by difficulty. Every generated scenario must satisfy: the correct route produces separation >= 1.8 yd against that defender (EditMode data test).

## 12. Freeze / explain moments
Trigger: after each run. Freeze the receiver at the end of the route. Camera: top-down (cut). Callouts: gold reference route with a dot at the break, rose route you drew, a callout showing "Depth 9 yd / Cut 90 out" and the classified name ("You drew: a curl"). Copy: Title <= 6 words, body <= 45 words, say-this.

| explainKey | Outcome | Title | Body | Say this |
|---|---|---|---|---|
| `slant` | correct | Quick cut. Clean slant. | A slant is three steps upfield, then a sharp 45-degree cut across the middle. It beats a defender who is shaded outside and gets the ball out fast. You built it. | "That's just a quick slant." |
| `slant` | incorrect | That is a {name}. | A slant breaks early, about three yards, and diagonally inside. Yours broke {depthWord}, so it looks like a {name}. Shorten the stem and try again. | "A slant is a quick inside cut." |
| `out` | correct | Nine and out. | An out runs about nine yards upfield then cuts flat to the sideline. It is a throw that stops the clock when the receiver gets out of bounds. | "They ran an out to stop the clock." |
| `out` | incorrect | That is a {name}. | An out cuts straight toward the sideline at about nine yards, at a right angle. A diagonal cut becomes a corner; going inside makes it a dig. | "An out goes to the sideline." |
| `go` | correct | All gas. That is a go. | A go route is a straight sprint. No breaks, just speed. It works as a deep shot or to pull safeties away from other routes. | "He's just running a go." |
| `go` | incorrect | Go means no cut. | A go route never breaks. Any cut turns it into something else. Send him straight and deep. | "A go is a straight line." |
| `curl` | correct | Sit down. That is a curl. | A curl runs about 11 yards, then turns back toward the quarterback to sit in the gap between zone defenders. Easy target for the quarterback. | "The curl found the soft spot." |
| `curl` | incorrect | Turn back to the passer. | A curl finishes facing the quarterback. If the receiver keeps going, it becomes a dig or a post. Stop and settle in the gap. | "A curl is a stop and turn back." |
| `post` | correct | Post: deep to the posts. | A post runs about 12 yards, then angles toward the goalposts. It attacks the middle of a single-high defense. | "The post cuts toward the goalposts." |
| `post` | incorrect | That is a {name}. | A post cuts at 45 degrees toward the middle of the field. Cut toward the sideline instead and you drew a corner. | "Post goes inside, corner goes outside." |
| `situation-hit` | correct | You beat the coverage. | You found a spot where nobody was guarding and reached the yardage needed. That is the whole point of route design. | "He found the soft spot in their zone." |
| `situation-miss` | incorrect | Close, but covered. | The defender got a hand on your route or you stopped short of the marker. Look for the gap between defenders and go past the yardage. | "Get past the sticks and find the gap." |

## 13. Scoring & mastery signals
- Round score (levels 1-3): both depth and angle within tolerance = 100; one within = 50; none = 0; hint = -10. Levels 4-5: 100 if `separation >= 2.0` and gain >= needed; 50 if either; 0 if neither. Session score = round(mean). Accuracy = fraction of rounds with 100.
- Outcome ids `round-1..3`; `value` = classified route name.

| mistake | conceptId | description |
|---|---|---|
| Wrong depth (< tolerance) on a named route | route's concept | Cut at the wrong depth for a {route}. |
| Wrong angle | route's concept | Cut at the wrong angle for a {route}. |
| Drew a different route | `route-tree` | Confused {a} with {b}. |
| Situation: stopped short | `curl-route` or `route-tree` | Did not reach the first-down marker. |
| Situation: covered | `route-tree` | Did not find the soft spot. |

| event | conceptId | delta | evidence |
|---|---|---|---|
| Correct named route, no hint | route concept | +0.25 | "Built a {route} at the right depth and cut." |
| Correct with hint | route concept | +0.10 | same |
| Correct situation route | `route-tree` | +0.20 | "Built a route that beat {coverage}." |
| Confused two routes | `route-tree` | -0.10 | "Confused {a} and {b}." |
| Wrong depth or angle | route concept | -0.10 | "Off on {depth or angle}." |
Caps: +0.40 and -0.20 per concept per session.

## 14. XP & hearts
- `xpEarned` = 10 per round scoring >= 50, +40 for finishing (native clamps to the lesson budget).
- `heartsLost` = 1 if mean round score < 40, else 0. Max 1.
- `replayAvailable` = true after any run.

## 15. Failure states
| Case | Learner sees | Result | Hearts |
|---|---|---|---|
| Wrong route | Explain card naming what they drew | round failed | session rule |
| Build timeout (L3+) | Route auto-runs with what is on screen | as scored | session rule |
| Session mean < 40 | Kind summary and "Try again" | `completed=true`, low score | 1 |
| Abort / background too long | Native abort | `aborted=true`, xp 0 | 0 |
| Asset missing / invalid config | `error ASSET_LOAD_FAILED` / `CONFIG_INVALID` | none | 0 |
Failure always ends in an explain moment.

## 16. Accessibility
Reduced motion: no camera blend, no handle wiggle; route preview is drawn without dash animation; run phase plays at 1x (no slow-mo). Haptics: ticks off when disabled. Color-blind: rose route is solid with round end caps; gold reference route is dashed with an arrowhead and a star marker at the break; separation shown as a number, not a color. Text scale: labels reflow. Tap-only: `chips` scheme (default when Switch Control/VoiceOver is on). VoiceOver: chips are labelled ("Depth 9 yards", "Cut: out 90"). Native fallback lesson: `route-lab-05-fallback`.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Handle snap | soft tick | selection tick | 0.3 |
| Run it | whistle | soft tap | 0.5 |
| Correct | gold chime | light success | 0.7 |
| Wrong | dull thud | warning | 0.5 |

## 18. Art & asset list
| asset | procedural / external | source & license | size | notes |
|---|---|---|---|---|
| Field, ruler | procedural | own | 0 | top-down |
| Receiver, defenders, QB | procedural capsules | own | < 0.5 MB | role rings |
| Route lines and handles | procedural | own | 0 | rose/gold |
| Fonts | bundled OFL | Instrument Serif, Geist | < 1 MB | |
| Audio | original | `original-swoond` | < 1 MB | |
Bundle `sim-football-routes-build`, < 4 MB.

## 19. Performance budget
Defaults apply. Tighter: <= 4 characters on screen (plus optional safeties), <= 40 draw calls, peak memory <= 100 MB, `ready` <= 1.2 s.

## 20. Telemetry
`hintsUsed`, `buildTimeMsMean`, `depthErrorYdMean`, `angleErrorDegMean`, `scenarioIds`, `inputScheme`.

## 21. Acceptance criteria (testable)
1. AC-1: With seed 7, difficulty 2, `scenarioCount` 3, the sim emits exactly 3 outcomes.
2. AC-2: `RouteClassifier` classifies each entry of the route table to its own name at tolerance 10 percent (EditMode).
3. AC-3: Dragging `handle_stem` snaps to whole yards (EditMode/PlayMode).
4. AC-4: The chips scheme reaches every reference route in two taps or fewer.
5. AC-5: Every scenario's correct route produces separation >= 1.8 yd against its defender (data test).
6. AC-6: Deterministic: same seed and scripted inputs give byte-identical results (excluding `sessionId`, `durationMs`, telemetry).
7. AC-7: Copy limits: titles <= 6 words, bodies <= 45 words (data test, templates count with `{name}` counted as one word).
8. AC-8: Bridge conformance: launch parse, result validates against schema, pause/resume/abort correct.
9. AC-9: Reduced-motion: no camera blend.
10. AC-10: Touch targets >= 44 pt.
11. AC-11: Hearts rule (mean < 40).
12. AC-12: Perf on iPhone 13-class: p5 >= 50 fps, memory <= 100 MB.
13. AC-13: Invalid config emits `CONFIG_INVALID`.
14. AC-14: No personal fields in telemetry or logs.

## 22. Test plan
| AC | Type | Test |
|---|---|---|
| AC-1, AC-6 | PlayMode | `RouteLab_Run_Seed7_Deterministic` |
| AC-2 | EditMode | `RouteClassifier_ReferenceTable` |
| AC-3 | EditMode | `PathEditor_SnapsToGrid` |
| AC-4 | EditMode | `Chips_ReachAllRoutes` |
| AC-5 | EditMode | `Scenarios_CorrectRoute_HasSeparation` |
| AC-7 | EditMode | `Explanations_CopyLimits` |
| AC-8 | EditMode/PlayMode | `Bridge_Conformance` |
| AC-9 | PlayMode | `ReducedMotion_NoBlend` |
| AC-10 | PlayMode | `TouchTargets_MinSize` |
| AC-11 | EditMode | `Hearts_Rule` |
| AC-12 | Perf | `Perf_iPhone13_RouteLab` |
| AC-13 | EditMode | `Config_Invalid` |
| AC-14 | EditMode | `Privacy_NoPersonalFields` |
Plus EditMode scoring maths, PlayMode full run with scripted drags, freeze/explain, pause/resume/abort.

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is drag-to-build clearly better than native visual-id plus hotspot-tap? Run a playtest before investing; else downgrade. | Product | No |
| 2 | Are 15 degree snaps right for touch, or should angles snap to the six named cuts at level 1-2? | Astra | No |
| 3 | Should `PathEditor` be added to the Game Kit v1.x? | Astra | Yes for this sim |
