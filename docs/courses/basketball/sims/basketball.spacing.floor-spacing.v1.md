# Floor Spacing: Open the Lane (`basketball.spacing.floor-spacing.v1`)

> Spec for Astra (Unity). Authored by Swoon'd curriculum design for the Basketball course. Follows `docs/astra/SIM_SPEC_TEMPLATE.md`; section numbers are stable.

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `basketball.spacing.floor-spacing.v1` |
| simulationVersion | `1.0.0` (major 1 equals `.v1` in the id) |
| Spec status | draft |
| Contract versions | Bridge `1.0.x` (`docs/contracts/unity-bridge/v1/`); sim-definition `1.x` (scenario-data driven; no custom definition file required for v1) |
| Authors / date | Swoon'd curriculum design (Claude Code) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `basketball`; `unitId`: `offense`, `film-room`; `lessonId`s: `off-01`, `flm-01` (`off-01` at difficulty 1-3; `flm-01` revisits at difficulty 4-5).
- CDS: `docs/courses/basketball/CDS.md`, section 12 Interaction plan, row "Spacing: put the shooters where the lane opens".
- Manifest entry: `docs/courses/basketball/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `court-lines`, `three-point-line`, `paint-key`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can place teammates so the defense has to choose between stopping the drive and guarding a shooter, and you can say why the floor is wide.
| conceptId | term | after this the learner can |
|---|---|---|
| `floor-spacing` | Floor spacing | Place teammates on spots that keep defenders honest and lanes clear. |
| `gravity` | Gravity | Explain that a shooter pulls a defender out even without the ball. |
| `corner-three` | Corner three | Recognize the corner as the best spot to park a shooter. |
| `driving-lane` | Driving lane | Say why a big or non-shooter standing in the lane clogs it. |
| `drive-and-kick` | Drive and kick | Predict that help on a drive leaves a shooter open. |
| `weak-side` | Weak side | Identify the side of the floor away from the ball and why defenders leave it. |

- **Out of scope:** Shot making percentages, screen actions, offensive sets and defensive schemes are not taught here. Defenders are simple: they follow their man and help only when their man is not a threat.

## 4. Why Unity (tier justification)
- **Rubric answer:** spatial reasoning and movement over time are the concept. Spacing is meaningless as a static picture; the lesson is what the five defenders do after you place the players.
- **What Unity adds:** defenders visibly step off shooters, collapse into the lane or stay home, and the learner sees the layup or the kick-out that follows. A top-down camera makes distances readable, and a slow-motion freeze shows the exact help gap.
- **Closest native type and why it teaches worse:** `hotspot-tap` shows where a shooter stands but cannot show consequences; `decision-scenario` gives text facts but not the geometry. Both would let the learner guess without seeing why the lane closes.
- **Verdict:** keep as Tier A. The native primer lessons (`hotspot-tap` court spots, `estimate-slider` points per shot) prepare the vocabulary.

## 5. Player fantasy & core loop
- **Fantasy:** You are the coach with the whiteboard: put four teammates on the floor and watch the defense break because of where you put them.
- **Core loop** (prompt -> one decisive interaction -> execute -> freeze/explain -> line you could say out loud):
  1. **Prompt:** serif line "Give your ball handler room." plus four role chips: Shooter, Finisher (big), Non-shooter, Elite shooter.
  2. **Decision:** place every teammate on one of 8 highlighted spots (see section 7); tap "Run it".
  3. **Execute:** the ball handler drives at the rim; defenders react per the resolver (section 11); 3-4 seconds.
  4. **Freeze:** the sim freezes on the outcome (layup, kick-out three or stuffed drive) with help gaps drawn in feet.
  5. **Explain and say:** a two-callout explanation plus a "say this" line; next round.
- **Session length:** About 3 minutes: 3 rounds, about 50 s each (placement about 25 s, execution and explain about 25 s).

## 6. Scene & entities
- **Environment:** `basketball_half_court` (procedural half court: floor, lane paint, arc, hoop). New registry key (see 6.1).
- **Camera presets:** `top-down-half-court` for placement (FOV 50, height so the whole half court fits portrait); `broadcast-baseline` (behind the baseline, high) for Execute; `top-down-half-court` for Freeze.
- **Court coordinates (all sims):** feet, origin at the rim center, +y toward half court, +x to the viewer's right when looking from the baseline toward half court. Baseline y = -5.25, half-court line y = 41.75, sidelines x = +/-25, lane x = +/-8 (free-throw line y = 13.75), restricted-area arc radius 4, three-point arc radius 23.75 with corner lines at x = +/-22 up to y = 8.75 (NBA dimensions; college/WNBA arc 22.146 ft can be selected via `configuration.league` where noted).
| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| ball_handler | `Character` (role player), `Ball` | Drives from `bhStart` to the rim | speed 18 ft/s; path straight to rim center |
| mate_1..mate_4 | `Character` + `BasketballPlayerRole` (new) | Learner-placed teammates | `roleTag` (shooter, finisher, non-shooter), `shootThreat` 0/1, `finishThreat` 0/1, `elite` 0/1 |
| def_0..def_4 | `Character` (defender) | Man-to-man defenders; `def_0` guards the ball handler | state `stayHome` or `sag`; sag target = 4 ft off man toward the rim; speed 14 ft/s |
| spot_1..spot_8 | `Target` + `Zone` (radius 3 ft) | Placement slots: corner-l, corner-r, wing-l, wing-r, dunker-l, dunker-r, elbow-l, elbow-r | coordinates in the table below; states available / taken / recommended |
| drive_lane | `Zone` (corridor) | Path from ball handler to rim, half-width 8.5 ft | overlay only; used by the resolver |
| hint | `Hint` | Highlights valid spots for the selected role (levels 1-3) | uses counted in `telemetry.hintsUsed` |
| decision | `DecisionPoint` | "Run it" confirmation | no time limit at L1-3 |
| camera | `CameraRig` | Presets above | reduced motion: cuts |
| score | `Score` | Outcomes, mistakes, mastery signals | see section 13 |

- **Reused vs new:** Reused: `Character`, `Ball`, `Target`, `Zone`, `Path`, `CameraRig`, `TouchController`, `DecisionPoint`, `Hint`, `Explanation`, `Objective`, `Score`, `Replay`, `SlowMotion`, `Highlight`. New: the `Swoond.Sports.Basketball` module (`Court`, `Spot` registry, `PlayerRole`) and `SlotPlacement` interaction. Justification: every basketball sim in this course needs the same court and role tags, so the module is built once here and reused by the other five sims.
- **Layout diagram:**
```
             half-court line (y = 41.75)
   -25 ----------------------------------- +25
    |                                        |
    |     [wing-l]     (BH top)    [wing-r]  |   arc (23.75 ft)
    |                                        |
    |   [elbow-l]  --- FT line ---  [elbow-r]|   y = 13.75
    |        |        lane         |         |
    |[corner-l]   [dunker-l] o [dunker-r] [corner-r]
    ------------------ baseline ------------
   spots: corner (+/-22, 1.5) wing (+/-17, 19) dunker (+/-9, 0.5) elbow (+/-8, 13.75); BH at top (0, 26)
```

### 6.1 Game Kit additions requested
- **`Swoond.Sports.Basketball` module** (first use here; reused by all Basketball sims): `Court` procedural builder for half and full court with named spots, feet-based coordinates and league variants (`nba`, `wnba`, `college` arc radius); `PlayerRole` component (roleTag, shootThreat, finishThreat, elite); `BasketballSpots` registry (ids in section 6 tables).
- **`SlotPlacement`** in `TouchController`: tap-to-select then tap-to-place, or drag-and-snap (magnet radius 60 pt), undo by tapping a placed player. Reusable for future formation-placement sims (football, soccer).
- **`Highlight` distance-ring variant:** a line between two entities with a live distance label in feet (help gap). Reusable for pickleball kitchen and soccer offside.
- **Registry keys:** environment `basketball_half_court`, `basketball_full_court`; objective type `place_and_resolve`; demonstrate type `help_gap_overlay`; actions `end_round`, `next_scenario` (existing).

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Select teammate | Tap the player or its role chip | mate_i | 56 pt chip, >= 44 pt player ring | Ring pulse, soft tap haptic |
| Place teammate | Tap a highlighted spot (or drag the selected player; snaps within 60 pt) | spot_j | >= 44 pt (spot radius 3 ft rendered >= 44 pt) | Player slides to the spot, spot turns `taken` |
| Undo placement | Tap a placed teammate | mate_i | >= 44 pt | Player returns to the bench, spot frees |
| Run it | Tap the accent pill | decision | 56 pt | Locks placement, starts Executing |
| Hint | Tap the lightbulb | hint | 44 pt | Gold glow on valid spots for the selected role |
| Exit | Tap X (native confirms) | requestExit | 44 pt | `requestExit user-quit` |

- **Accessible alternative (tap-only):** The default scheme already works with taps only (select then place). Dragging is an optional shortcut; when the tap-only scheme is on, drag is disabled and spot taps are enlarged to a 52 pt minimum.
- **Orientation / safe area:** portrait; interactive targets stay above the bottom safe-area inset and clear of the top `runtime.safeAreaInsets.top` plus 12 pt; landscape is not supported in v1.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation ("Leave game?"), permission prompts, lesson chrome. Unity may draw an X that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate `contractVersion`, `simulationId`, `configuration`; load scenario JSON and build the world from code; apply theme and accessibility flags. | Scene built -> Intro; failure -> `error` (CONFIG_INVALID / ASSET_LOAD_FAILED) | `ready` (with `gameKitVersion`, `loadTimeMs`) |
| Intro | World built | Prompt card (one line, serif) and a 1.2 s establishing shot. Show the ball handler at `bhStart`, the four bench chips and the 8 spots dimmed. | Tap "Go" or auto after 3 s -> Playing | `progress` 0.0 |
| Playing | Intro finished | Round `i` of `n` begins. Prompt card shows the role chips and the scenario line. | Decision window opens -> Decision | `progress` (throttled <= 4/s) |
| Decision | Decision window open | DecisionPoint slows or holds the sim. The learner places all four teammates; "Run it" enables only when all four are placed. | Choice locked or limit hit (counts as no answer = incorrect) -> Executing | none |
| Executing | Choice locked | Sim plays out deterministically for 2-5 s. Ball handler drives; defenders resolve to `stayHome` or `sag` per the resolver; the ball goes to the rim or kicks to the open shooter. | Outcome determined -> Freeze | none |
| Freeze | Outcome determined | Time scale eases to 0 over 250 ms (hard cut under reduced motion); scene dims 35% except focal entities. Help gaps are drawn as distance rings; the open shooter or open lane is ringed gold; the choice is ringed rose. | Focal highlight done -> Explain | `checkpoint` (round id) |
| Explain | Freeze complete | Callouts appear one at a time (250 ms each), then the copy card and the say-this line. Two callouts: what the defense did and why (gravity), then the copy card. | Tap Continue -> Playing (next round) or Summary | none |
| Summary | Last round explained | Score numerals count up over 600 ms; three outcome pips; the one line to say out loud. | Auto after 4 s or tap -> Done | `progress` 1.0 |
| Done | Summary finished | Build `SimulationResult`; emit result then request exit. | Unity idle | `result`, then `requestExit` (`completed`) |
| Paused | Native `pause` | Stop sim time, timers, audio and haptics; keep the frame. | `resume` -> previous state | none |
| Aborted | Native `abort` or X confirmed | Stop immediately; build a partial result. | Emit result -> exit | `result` (`aborted=true`), `requestExit` |

Pause/abort: native `pause` freezes sim time, timers and audio in any state and resumes exactly; `abort` moves to Aborted from any state and emits one result with `aborted=true`.

## 9. Difficulty levels 1-5
| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Ball handler start | top | top | top | wing (auto) | wing (auto) |
| Teammate profiles | 3 shooters + 1 finisher | 2S+1F+1 non-shooter | elite / two bigs | mixed, wing start | one non-shooter, wing start |
| Placement hint | valid spots glow gold | role reminder text | 1 free hint | hints cost 1 (halve mastery) | no hints |
| Help preview before "Run it" | sag arrows shown | sag arrows shown | off | off | off |
| Placement time limit | none | none | none | 40 s | 25 s |
| Scenario pool tags | L1 | L1-2 | L2-3 | L4 | L5 |
| Success threshold | layup or kick-out | layup or kick-out | layup or kick-out | layup or kick-out | layup or kick-out |

- **Default difficulty for the lesson:** 2 for `off-01`; 4 for `flm-01`. Level 1 is passable by a true beginner with hints (hint text and highlights always on).

## 10. Configuration schema
`LaunchRequest.configuration` (draft 2020-12). Invalid configuration yields `error CONFIG_INVALID`.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "basketball.spacing.floor-spacing.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": {
      "type": "integer",
      "minimum": 0,
      "description": "Deterministic seed for scenario order."
    },
    "scenarioSetId": {
      "type": "string",
      "enum": [
        "spacing-starter",
        "spacing-advanced"
      ],
      "default": "spacing-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 1,
      "maximum": 9,
      "default": 3
    },
    "showHints": {
      "type": "boolean",
      "default": true
    },
    "bhStart": {
      "type": "string",
      "enum": [
        "auto",
        "top",
        "wing-l",
        "wing-r"
      ],
      "default": "auto"
    },
    "placementTimeLimitSec": {
      "type": "integer",
      "minimum": 0,
      "maximum": 60,
      "default": 0,
      "description": "0 = no limit."
    },
    "league": {
      "type": "string",
      "enum": [
        "nba",
        "wnba",
        "college"
      ],
      "default": "nba",
      "description": "Selects arc radius only."
    },
    "assetRoot": {
      "type": "string"
    }
  }
}
```

Valid example:

```json
{
  "seed": 42,
  "scenarioSetId": "spacing-starter",
  "scenarioCount": 3,
  "showHints": true,
  "bhStart": "auto",
  "placementTimeLimitSec": 0,
  "league": "nba"
}
```

## 11. Scenario data set
Scenario = a ball handler start, four teammate profiles and a fixed defense (man-to-man). The outcome is computed by a deterministic **resolver** (below), not by random shot making. Set `spacing-starter` = scenarios 01-05 and 09; `spacing-advanced` = 04-09.

**Scenario count:** at least **9** authored scenarios (3 rounds x 3 minimum for replay variety), stored as `Scenarios/spacing.json` (JSON, versioned with the sim). Selection is deterministic per `configuration.seed`.

**Resolver (reference model; Astra implements with Game Kit primitives and must match its outcomes):**

1. Let `drive_path` be the segment from the ball handler start to the rim center (0,0).
2. For each teammate placed at spot `p`: if the distance from `p` to `drive_path` is <= 8.5 ft, the teammate is **in-path** and adds 1 helper (his defender stands in the lane).
3. Otherwise: on an arc spot (corner, wing, top) his defender **stays home** iff `shootThreat=1`, else he **sags** (adds 1 helper). On a dunker spot his defender stays home iff `finishThreat=1`, else sags (adds 1 helper).
4. **Clump:** each pair of players (ball handler included) closer than 12 ft adds 1 helper.
5. **Elite shooter:** if an `elite` teammate stands on an arc spot and is not in-path, subtract 1 helper (his defender cannot leave, and a second defender must shade him). Never below 0.
6. Outcome: `helpers = 0` -> **layup** (lane open); `helpers = 1` and at least one `shootThreat=1` teammate on an arc spot -> **kick-out** (help arrives, the open shooter gets the ball); otherwise **stuffed**.
7. Success = layup or kick-out. Score per round: layup 100, kick-out 85, stuffed 0.

Spot coordinates (ft): corner-l (-22,1.5), corner-r (22,1.5), wing-l (-17,19), wing-r (17,19), dunker-l (-9,0.5), dunker-r (9,0.5), elbow-l (-8,13.75), elbow-r (8,13.75); ball handler `top` (0,26). Roles: S = shooter (`shootThreat`), F = finisher, E = elite shooter, - = neither.

| scenarioId | ball handler | teammates | best outcome | one canonical solution | placements that succeed (brute force over all 1,680 / 840) | teaches | difficulty tags |
|---|---|---|---|---|---|---|---|
| spacing-01 | `top` | shooter-a(S), shooter-b(S), shooter-c(S), big-finisher(F) | layup | shooter-a->corner-l, shooter-b->corner-r, shooter-c->wing-l, big-finisher->dunker-l | 228 of 1680 (13.6%) | Tutorial: three shooters and a finisher | L1 |
| spacing-02 | `top` | shooter-a(S), shooter-b(S), big-finisher(F), non-shooter(-) | kick-out | shooter-a->corner-l, shooter-b->corner-r, big-finisher->dunker-l, non-shooter->wing-l | 96 of 1680 (5.7%) | One non-shooter costs you a helper | L1-2 |
| spacing-03 | `top` | shooter-a(S), shooter-b(S), shooter-c(S), non-shooter(-) | kick-out | shooter-a->corner-l, shooter-b->corner-r, shooter-c->wing-l, non-shooter->wing-r | 84 of 1680 (5.0%) | Hide the non-shooter; keep shooters on the arc | L2 |
| spacing-04 | `top` | elite-shooter(SE), shooter-b(S), non-shooter-a(-), non-shooter-b(-) | kick-out | elite-shooter->corner-l, shooter-b->corner-r, non-shooter-a->wing-l, non-shooter-b->wing-r | 220 of 1680 (13.1%) | An elite shooter buys you a second non-shooter | L3 |
| spacing-05 | `top` | shooter-a(S), big-a(F), big-b(F), non-shooter(-) | kick-out | shooter-a->corner-l, big-a->dunker-l, big-b->dunker-r, non-shooter->corner-r | 36 of 1680 (2.1%) | Two bigs: dunker spots, one shooter | L3 |
| spacing-06 | `wing-l` | shooter-a(S), shooter-b(S), big-finisher(F), non-shooter(-) | kick-out | shooter-a->corner-l, shooter-b->corner-r, big-finisher->dunker-r, non-shooter->wing-r | 18 of 840 (2.1%) | Drive from the wing: the lane changes | L4 |
| spacing-07 | `wing-r` | shooter-a(S), shooter-b(S), shooter-c(S), big-finisher(F) | layup | shooter-a->corner-l, shooter-b->corner-r, shooter-c->wing-l, big-finisher->dunker-l | 54 of 840 (6.4%) | Mirror: drive from the right wing | L4 |
| spacing-08 | `wing-l` | shooter-a(S), shooter-b(S), shooter-c(S), non-shooter(-) | kick-out | shooter-a->corner-l, shooter-b->corner-r, shooter-c->wing-r, non-shooter->dunker-l | 12 of 840 (1.4%) | Wing drive with one non-shooter | L5 |
| spacing-09 | `top` | shooter-a(S), shooter-b(S), big-a(F), big-b(F) | layup | shooter-a->corner-l, shooter-b->corner-r, big-a->dunker-l, big-b->dunker-r | 192 of 1680 (11.4%) | Two bigs, two shooters: the classic pairing | L2-3 |

**Fully written first three**

1. **`spacing-01`** - prompt: "Three shooters and a big. Where do they go?" Setup: ball handler at top; `shooter-a/b/c` (S), `big-finisher` (F). Correct idea: shooters on corner and wing spots, big at a dunker spot. Canonical: shooters at corner-l, corner-r, wing-l; big at dunker-l -> 0 helpers -> **layup**. Hint text (L1): "Shooters like the arc. Bigs like the dunker spot." Common wrong placement: big at an elbow (in-path, adds a helper) -> **kick-out** at best.
2. **`spacing-02`** - prompt: "One teammate cannot shoot. Hide him." Setup: two shooters, `big-finisher`, `non-shooter`. The non-shooter always adds one helper (his defender sags), so the best possible outcome is **kick-out**; the learner must keep both shooters on the arc so a shooter is open. Canonical: shooters at corner-l and corner-r, big at dunker-l, non-shooter at wing-l. Teaching beat: the defender guarding the non-shooter leaves him to help, so the kick-out goes to the corner.
3. **`spacing-03`** - prompt: "Three shooters, one who cannot. Now where?" Setup: three shooters and a non-shooter, ball handler at top. Any placement with the non-shooter on an arc spot or a dunker spot yields one helper; putting him at an elbow creates an in-path helper plus possibly a clump. Canonical: non-shooter at wing-r, shooters at corner-l, corner-r, wing-l -> **kick-out** (the non-shooter's defender sags into the lane and a corner shooter is left open).

**Scenarios 04-09** are generated from the table above with the same fields (`bhStart`, four teammate profiles, `hintText`, `explainKey`). Generation rules for more: (a) at most one elite shooter; (b) at most two non-shooters and only when an elite shooter is present; (c) require at least one succeeding placement (brute force in EditMode); (d) tag difficulty by succeeding-placement share: > 10% = L1-2, 3-10% = L3-4, < 3% = L5. Scenarios are deterministic per seed: order = seeded shuffle of the pool filtered by difficulty tag.

## 12. Freeze / explain moments
Copy rules: title <= 6 words, body <= 45 words, optional say-this line in quotes. Voice: cheeky coach, warm, a little flirty, never condescending, never about the crush.

### 12.1 Result freeze (lane open or kick-out)
- **Trigger:** Outcome determined after Executing.
- **What freezes:** Ball handler and the ball at the point of decision (drive stopped 6 ft from the rim, or the kick-out pass in the air).
- **Camera:** `top-down-half-court`, slow push-in (cut under reduced motion).
- **Callouts:** Distance rings show each defender-to-man gap in feet (rose ring on the placed player, gold ring on the open shooter or the open lane); "Helper" tag on the defender who left his man.
- **Correct outcome copy** - Title: "The defense had to choose." | Body: "Your shooters made the defense pick: stay home or help. Every helper leaves someone open. That is why we say spacing: the space is the play." | Say this: "Their spacing is so good the lane is just open."
- **Incorrect outcome copy** - Title: "Too crowded to breathe." | Body: "Someone sitting near the lane brought a defender with him, so help arrived early. Move that player to the arc or the dunker spot and the lane clears." | Say this: "Wait, is the lane clogged? Why is nobody on the perimeter?"

### 12.2 Gravity callout
- **Trigger:** Kick-out or stay-home is shown (helpers <= 1).
- **What freezes:** The defender who stays home beside a shooter, at the moment the drive commits.
- **Camera:** `broadcast-baseline` close on the shooter and his defender.
- **Callouts:** Gold arrow from the shooter to his defender labelled "Stuck"; dashed rose line for the help path.
- **Correct outcome copy** - Title: "That is gravity." | Body: "A shooter pulls a defender toward him even without the ball. That defender cannot help, so the drive gets easier. Fans call this gravity, and it is why great shooters matter." | Say this: "He has so much gravity the defense just can't leave him."
- **Incorrect outcome copy** - Title: "No shooter, no pull." | Body: "A player who cannot shoot does not pull a defender out. His defender ignores him and helps on the drive, and your shooter has to make up for it. Keep one or two shooters where they count." | Say this: "Their non-shooter lets the defense ignore him."

### 12.3 Summary line
- **Trigger:** All rounds explained.
- **What freezes:** Not frozen: Summary screen.
- **Camera:** Static top-down still of the last placement.
- **Callouts:** Three outcome pips (gold = success, ring = miss) with spot names.
- **Correct outcome copy** - Title: "You spaced the floor." | Body: "You put shooters on the arc, bigs by the rim and gave every drive an answer. That is the whole idea behind modern offense, and it is the first thing worth noticing in any game." | Say this: "Watch the corners. Whenever he drives, somebody's open."
- **Incorrect outcome copy** - Title: "Run it back." | Body: "The floor needs a shooter on the arc and a body near the rim. Keep non-shooters away from the lane and try again. It clicks fast." | Say this: "Where do the shooters usually stand?"

## 13. Scoring & mastery signals
- **Score formula (0-100):** Round score: layup = 100, kick-out = 85, stuffed = 0 (no answer = 0). Session score = round(mean of round scores).
- **Accuracy:** Rounds with outcome layup or kick-out divided by rounds played.
- **Outcome ids:** `round-1`..`round-N` with `label` of the form "Layup: lane open" / "Kick-out to corner" / "Stuffed: crowded lane" and `value` = `layup` | `kick-out` | `stuffed`.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (<= 240 chars) |
|---|---|---|
| A non-shooter is placed on an elbow or in-path spot | `driving-lane` | Placed a player who cannot shoot in the lane, so his defender clogged the drive. |
| Two players placed within 12 ft of each other | `floor-spacing` | Bunched two players together, which let one defender help and still cover both. |
| Shooter placed at a dunker or elbow spot | `gravity` | Used a shooter near the rim where he does not pull a defender out. |
| No shooter left on an arc spot | `drive-and-kick` | Left no shooter on the arc, so the drive had no kick-out option. |
| Corner left empty when a shooter is available | `corner-three` | Skipped the corner, the shortest three, when a shooter was available to stand there. |

**Mastery signals** (per-session caps: +0.4 / -0.3 per concept per session; total absolute delta <= 1.2.)

| event | conceptId | delta (-1..1) | evidence text |
|---|---|---|---|
| Layup outcome | `floor-spacing` | 0.25 | Placement left no helper: the lane was open. |
| Layup or kick-out outcome | `driving-lane` | 0.15 | Kept the lane clear of teammates. |
| Kick-out outcome | `drive-and-kick` | 0.2 | Help arrived and the open shooter got the ball. |
| Shooter held a defender (stayHome) on an arc spot | `gravity` | 0.2 | Shooter on the arc kept his defender home. |
| Shooter placed in a corner | `corner-three` | 0.1 | Used a corner for a shooter. |
| Stuffed outcome | `floor-spacing` | -0.15 | Placement produced two or more helpers. |
| Non-shooter in-path | `driving-lane` | -0.1 | A non-shooter clogged the lane. |

**Mapping to `SimulationResult`:** Round results -> `outcomes[]` (ids above); each mistake row triggered in a round -> `mistakes[]` with `at` = active ms; each signal row triggered -> `masterySignals[]`; `score`, `accuracy` per above; `xpEarned`, `heartsLost` per section 14.

## 14. XP & hearts
- **`xpEarned` proposal:** +10 per successful round, +40 for finishing all rounds (native clamps to the lesson XP budget); hint use does not reduce XP but native halves mastery gain when `telemetry.hintsUsed > 0`. Bonus: none.
- **`heartsLost`:** 1 if fewer than half the rounds succeed at difficulty >= 2; otherwise 0; never more than 1 per session; 0 at difficulty 1. Aborted, timeout or error sessions lose no hearts.
- **`replayAvailable`:** `true` after Summary when at least one round was recorded (Replay primitive); native may show a "Watch again" affordance that relaunches with the same seed at no XP.

## 15. Failure states
| Situation | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round | Explain moment for the incorrect outcome with the correct answer highlighted gold; then next round | `outcomes[i].success=false`, `mistakes[]` entry, negative `masterySignals` | Counts toward the session rule above |
| Failed session (fewer than half rounds correct) | Summary with the line "We'll run it back." and one "Try again" (native) plus lesson primer offer | `completed=true`, low `score`, `xpEarned` = successes x 10 only | Max 1 |
| Timeout (`runtime.maxDurationMs`) | Native aborts; Unity shows a short freeze card | `aborted=true`, `abortReason=timeout`, partial `outcomes`, `xpEarned=0` | 0 |
| Abort / user quit | Native "Leave game?" then close | `aborted=true`, `abortReason=user-quit` or `native-abort`, partial `outcomes` | 0 |
| Backgrounded > 120 s | Native aborts on return | `abortReason=backgrounded-too-long` | 0 |
| Asset missing | Native retry sheet | `error ASSET_LOAD_FAILED`, `recoverable=true` | 0 |
| Invalid configuration | Native friendly error and skip | `error CONFIG_INVALID`, `recoverable=false` | 0 |
| Round timeout (`placementTimeLimitSec` > 0) | Timer hits 0: teammates not yet placed auto-place on their worst remaining spots and the round runs | `outcomes[i].success=false` unless the auto placement succeeds; mistake entry `timeout` | Counts toward the session rule |

Failure always teaches: every failed round ends in an explain moment; there is no dead-end screen.

## 16. Accessibility
- **Reduced motion:** Freeze is a hard cut (no ease); camera moves become cuts; no shake; pulsing rings become static rings; slow-motion replay is replaced by paired stills (before/after) with the same callouts.
- **Haptics off:** all cues fall back to on-screen text/shape only.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): team colors differ in luminance and every color meaning has a second channel: teammate roles use shapes (shooter = ring, finisher = square, non-shooter = triangle) plus letters S / F / N on jerseys; defenders are hollow, offense filled; spot states use icon glyphs (check, plus).
- **Text scale:** overlay text follows `textScale` up to 2.0; callout cards reflow and scroll if needed; explanation copy is never truncated.
- **Tap-only:** The default scheme already works with taps only (select then place). Dragging is an optional shortcut; when the tap-only scheme is on, drag is disabled and spot taps are enlarged to a 52 pt minimum.
- **VoiceOver / TalkBack:** Unity content has limited screen-reader support. Accessible native fallback lesson (a designed exercise, not a port): `spacing-native-primer` = a `hotspot-tap` set (tap the corner, wing, dunker, elbow) followed by a `decision-scenario` ("Where should your non-shooter stand and why?"). It teaches the same idea without the animation.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Scene ready | soft ball-bounce tick | none | -18 dB |
| Decision window opens | low chime | soft tap | -16 dB |
| Correct outcome | warm two-note rise | light success | -14 dB |
| Incorrect outcome | muted thud | warning | -14 dB |
| Freeze | soft whoosh, pitch drop | soft tap | -16 dB |
| Player placed on a spot | soft snap | soft tap | -18 dB |
| Kick-out pass | crisp pass whoosh | none | -16 dB |
| Summary numerals | quiet tick per count step | none | -22 dB |

All cues honor `learnerContext.accessibility.soundEnabled` and `hapticsEnabled`. No music. No commentary voice.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Half-court (floor, lines, lane paint, arc, hoop, backboard) | procedural | generated in code; original | < 3k tris; solid colors; 0 textures | `court` token from theme; lines as thin quads |
| Players (offense / defense) | procedural | capsule-bodied stylized figures generated in code; original | < 1.2k tris each; solid colors; no textures | Jersey number and role ring as second channel; defenders desaturated |
| Ball | procedural | original | < 600 tris | Orange in both themes (pieces keep own colors) |
| Spot glyphs and role shapes | procedural | original | quads | Distinct shapes for the role second channel |
| Overlays (rings, zones, arrows, callout cards) | procedural | original | quads / TMP | Rose = you/act, gold = correct/taught (ART_DIRECTION.md section 4) |
| Fonts | external (bundled) | Instrument Serif and Geist, OFL | TMP font assets | From `theme.fonts`; do not hard-code |

- **Addressables bundle:** `basketball.spacing.floor-spacing.v1` v1.0.0, expected size < 6 MB compressed (scenario JSON, TMP fonts, audio cues).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (5th-percentile frame >= 50 fps), peak resident memory < 150 MB, cold launch to `ready` < 2 s (< 4 s first framework load), bundle <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state not above "fair" after 3 minutes. Tighter limits for this sim: 11 characters and one ball on screen; <= 30k triangles; placement UI renders at 60 fps with the top-down camera.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters: `hintsUsed`, `placementLatencyMs` (per round), `undoCount`, `roundsCompleted`. No names, no relationship, no free text, no device identifiers.

## 21. Acceptance criteria (testable)
- **AC-1:** Resolver: for every scenario in `spacing.json`, the resolver returns the documented `best outcome` for the canonical solution and at least one succeeding placement exists.
- **AC-2:** Resolver: scenario `spacing-02` with the non-shooter placed on `elbow-r` returns `stuffed` and emits mistake `driving-lane`.
- **AC-3:** With seed 42, difficulty 2 and `scenarioCount` 3, the sim emits exactly 3 `outcomes`.
- **AC-4:** "Run it" is disabled until all four teammates are placed; tapping a placed teammate frees the spot.
- **AC-5:** Placement time limit: at level 5 the round runs automatically at 25 s with unplaced teammates auto-placed and a `timeout` mistake recorded.
- **Launch and ready:** With this sim's example configuration, Unity emits `ready` within 2000 ms of receiving `launch`, and exactly one `result` that validates against `simulation-result.schema.json`, followed by `requestExit`.
- **Pause/resume:** After `pause`, no sim time, timers or objective progress advance for 5 s; after `resume` the state continues exactly. `durationMs` excludes paused time.
- **Abort:** `abort` at any state yields a result with `aborted=true`, `completed=false`, the matching `abortReason` and partial `outcomes` within 1000 ms; `xpEarned=0`, `heartsLost=0`.
- **Determinism:** With the same `seed`, `scenarioSetId` and scripted inputs, two runs produce identical `outcomes`, `mistakes` and `masterySignals`.
- **Config validation:** A configuration violating the section 10 schema (unknown key, out-of-range value) produces `error CONFIG_INVALID`; `{}` is valid and uses defaults.
- **Result maths:** `score` is an integer 0-100, `accuracy` in [0,1], every `conceptId` in `mistakes[]` and `masterySignals[]` is listed in section 3, and per-session caps in section 13 are never exceeded.
- **Reduced motion:** With `reducedMotion=true`: Freeze is a hard cut (0 ms ease), no camera sweeps or shake occur, and pulsing rings are static.
- **Tap-only completion:** A full session completes using only single taps (no drags or holds) with the tap-only scheme.
- **Color-blind channel:** For each `colorBlindMode`, every color-coded element also carries the second channel from section 16 (shape, pattern or number), verified by a scene audit.
- **Copy length:** All explain titles are <= 6 words and bodies <= 45 words (asserted from the scenario/copy data).
- **Performance:** On iPhone 13-class: >= 60 fps sustained, 5th-percentile frame >= 50 fps, peak memory < 150 MB, cold launch to `ready` < 2 s, <= 150 draw calls, <= 60k tris on screen.
- **Privacy:** No log line, telemetry field or file contains `personName` or `relationship`.

## 22. Test plan
- **EditMode:** Resolver truth table over all scenarios and all 1,680/840 placements against the brute-force counts in section 11; config schema validation and defaults; scoring maths and caps; determinism by seed; result schema validity; copy length checks.
- **PlayMode:** Scene builds from code (court, 11 characters); scripted full run (place four teammates, Run it, Freeze, Explain, Summary, result); pause/resume; abort; reduced-motion path; tap-only run; color-blind audit.
- **Perf:** a measured 3-round run on an iPhone 13-class device with a recorded fps/memory/thermal report attached to the PR.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Resolver_CanonicalSolutions |
| AC-2 | EditMode | Resolver_InPathIsStuffed |
| AC-3 | PlayMode | Run_ThreeRounds_Seed42 |
| AC-4 | PlayMode | Placement_RunItGating |
| AC-5 | PlayMode | Placement_TimeLimit |
| Launch and ready | PlayMode | BridgeConformance_ReadyResultExit |
| Pause/resume | PlayMode | PauseResume_NoTimeAdvance |
| Abort | PlayMode | Abort_PartialResult |
| Determinism | EditMode | Determinism_SameSeedSameResult |
| Config validation | EditMode | Config_ValidationAndDefaults |
| Result maths | EditMode | Result_SchemaAndCaps |
| Reduced motion | PlayMode | ReducedMotion_NoEaseNoShake |
| Tap-only completion | PlayMode | TapOnly_FullRun |
| Color-blind channel | EditMode | ColorBlind_SecondChannelAudit |
| Copy length | EditMode | Copy_LengthLimits |
| Performance | Perf | Perf_iPhone13Report |
| Privacy | EditMode | Privacy_NoPersonalData |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Do we let learners choose the shooter roles themselves (drag role chips) at level 5? | Product | No |
| 2 | Does the college/WNBA arc (22.146 ft) change any spot coordinates in v1 (planned: arc radius only)? | Astra | No |
| 3 | Basketball SME to confirm the resolver rules read as truthful teaching (help vs stay home) | Product | No |
| 4 | Confirm the final tuning constants (speeds, timing windows) with Basketball SME review before Astra locks them. | Product | No |
| 5 | Should the sim honor `theme.colorScheme=light` with the same overlay tokens (planned: yes, per ART_DIRECTION)? | Astra | No |
| 6 | Is a native accessible fallback lesson approved for VoiceOver users (named in section 16)? | Claude | No |
