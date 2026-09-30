# Find the Seam: Power Play Spacing (`hockey.special-teams.power-play-spacing.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `hockey.special-teams.power-play-spacing.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (definition file optional: this sim is scenario-data driven, see section 11) |
| Authors / date | Swoon'd content team (Claude), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `hockey`. Units and lessons that launch this sim: unit `systems-tactics` lesson `tac-pp-seams`; unit `the-debates` lesson `eye-pp-story`.
- CDS row: `docs/courses/hockey/CDS.md` section 12, family `pp-seam`.
- Manifest entry: `docs/courses/hockey/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered`, otherwise the lesson shows a native primer first): `power-play`, `penalty-kill`, `pp-formations` primer (native lesson `tac-pp-formations`).

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can look at a power play setup against a penalty kill shape, see where the seam is, and pick the right pass.

| conceptId | term | after the sim the learner can... |
|---|---|---|
| pp-formations | Power play formations | recognize 1-3-1 and umbrella and know what job each spot has |
| pk-formations | Penalty kill formations | see how a box or diamond leaves and closes lanes |
| one-timer | One-timer | know why the flank is the shooting spot and why the pass must be clean |
| slot | Slot and high-danger area | prefer the pass that leads to a shot from the slot |
| screen-tip | Screen and tip | explain why a shot from the point works with a net-front screen |

- **Out of scope:** Faceoff plays, zone entries and penalty-kill clearing. Individual shooting skill is not modeled; every clean lane is a good shot.

## 4. Why Unity (tier justification)
Rubric answers: (1) **Spatial reasoning:** spacing is the whole concept: where five attackers stand relative to four killers and which lane is open. (2) **Movement over time:** the killers shift as the puck moves; a still image hides the shifting that creates the seam. (3) **Camera perspective:** the top-down view makes lane geometry readable. The closest native types are `hotspot-tap` (static: tap the open man) and `visual-id` (name the formation). Those teach the vocabulary (and are used for `tac-pp-formations`), but not *why* a lane opens when the box moves, which is the concept and requires watching the shape shift before the decision.

## 5. Player fantasy & core loop
**Fantasy:** You are the quarterback of the power play, patient enough to move the puck until the seam opens.

1. **Prompt:** "Find the open shot."
2. **Playing:** top-down view of the offensive zone; the puck circulates by scripted passes for 3-5 s while the box (or diamond) shifts.
3. **One decisive interaction:** at the freeze, tap the teammate who should get the puck (or **Shoot** / **Reset** in higher levels).
4. **Execute:** the pass and shot play out; the result shows chance quality.
5. **Freeze / explain:** lanes are drawn (gold = open, dashed rose = blocked), the seam highlighted; card explains.
6. **Say this:** e.g. "They collapsed on the strong side, so the weak flank was open."

Session target: about 3 minutes, 3 rounds by default (`configuration.rounds`), drawn from the scenario pool in section 11.

## 6. Scene & entities
- **Environment:** `hockey_rink_offensive_zone (new registry key: offensive zone, top-down)`. **Camera presets:** `top-down` (default), `broadcast-side` (execute, short), `blueline-cam` unused.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| P | Character (role: playerPoint) | point man with the puck at start | position from scenario |
| F_L, F_R | Character (playerFlank) | circle shooters | x 54-60, /y/ 22-28 |
| B | Character (playerBumper) | middle high slot | x 58-66 |
| N | Character (playerNetfront) | net-front | x 78-84 |
| hi1, hi2, lo1, lo2 | Character (opponent) | penalty killers in box/diamond | striped jerseys |
| puck | Ball | the puck | passes at 60-70 ft/s |
| lane_* | Path + Highlight | pass lanes for explain | gold/dashed |
| decisionBar | DecisionPoint + Targets | 5 player targets + Shoot/Reset | 44 pt targets over characters |
| seamZone | Zone | the open region for explain | polygon |

- **Reused primitives:** Ball, Character, Zone, Path, CameraRig, TouchController, DecisionPoint, Target, Hint, Explanation, Objective, Score, Replay, SlowMotion, Highlight, Rng, ScenarioSet.
- **Diagram (initial layout):**

```
  blue line                                             goal line
     |    P(30,12)                                          |
     |        \                   F_L(56,26)                |
     |         \  hi1 hi2         B(62,0)     lo1 lo2      | N
     |          \                                            |
     |                            F_R(56,-26)               |
  (top of screen = +y)         penalty killers in a box (striped)
```

### Game Kit additions requested
| Addition | Why it is needed | Reuse plan |
|---|---|---|
| `Swoond.Sports.Hockey` `Rink`, `Puck` | Shared hockey module | All hockey sims |
| `LaneEvaluator` (segment-to-point clearance for pass lanes with a configurable reach) | Deterministic 'is the lane open' used for explain lines and checking | Football coverage, basketball passing lanes, soccer passing sims |
| `FormationSet` (data-driven positions for named shapes with shift rules) | PP and PK shapes are data | Football formations, basketball offenses |
| `Character` preset `stickReach` field | Reach determines block radius | Any defender-lane sim |

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Teammate target | tap the character (hit circle radius 44 pt at least) | 44 pt min | rose ring appears; light tap haptic |
| Shoot | tap button (difficulty >= 3; only valid for the puck holder) | 56 pt | button depress |
| Reset (pass back) | tap button (difficulty >= 3) | 56 pt | arrow to point man |
| Hint | tap lightbulb | 44 pt | draws the killers' reach circles (5.5 ft) and the lanes (costs 5 points) |

- **Tap-only alternative scheme:** Everything is a tap on a character or a button; no drags. Targets can also be chosen from a bottom list of five named buttons ("Point", "Left flank", "Right flank", "Bumper", "Net-front") in accessibility mode.
- **Orientation / safe area:** portrait. All buttons live inside `runtime.safeAreaInsets`; the decision bar sits 28-34 pt above the bottom inset.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation (`requestExit` with `user-quit`; native shows "Leave game?"), XP/streak UI, lesson chrome.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate contract, simulationId, configuration; build rink and characters from code; load scenario set | `ready` sent -> Intro (invalid config -> `error CONFIG_INVALID`) | `ready` |
| Intro | Ready acknowledged | One-line objective card (Display S serif), 1.5 s; camera settles on the opening preset. Shows a 1-3-1 diagram with role labels. | Auto -> Playing (first round) | `progress` 0.0 |
| Playing | Round starts | Top-down; the puck moves P -> flank -> point along the scripted circulation while the box shifts toward the puck side (or the diamond pressures). Time scale 0.8x at lower levels. | Decision point reached -> Decision | `progress` (<= 4 per second) |
| Decision | Decision point reached | Sim freezes at the scenario's `decisionAt`; five player rings appear (plus Shoot/Reset at difficulty >= 3). A timer bar shows at difficulty >= 4. | Input or time limit -> Executing | none |
| Executing | Decision recorded | The chosen pass plays at 0.5x; the shot chance is evaluated from the lane and the shooter position; a save/goal animation is skipped (only a chance label appears: "Great look" / "Blocked" / "Intercepted"). | Outcome resolved -> Freeze | none |
| Freeze | Outcome resolved | Freeze on the pass or the block; camera stays top-down; open lanes drawn gold, blocked lanes dashed rose with the blocking killer ringed. | 1.2 s (0.4 s with reduced motion) -> Explain | none |
| Explain | Freeze complete | Copy card slides up; the seam zone shades in gold; a "Show shifts" replay chip plays the killers' movement at 0.5x. Tap "Next play" (or auto after 12 s at difficulty 4-5) advances. | Rounds left -> Playing; else -> Summary | `checkpoint` (round id) |
| Summary | All rounds done | Score card: score, accuracy, per-round chips, one "say this" line from the weakest concept; native shows XP | Continue tapped -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` (Score.Build(true)) | `result` then `requestExit` (`completed`) | `result`, `requestExit` |
| Paused | `pause` received | Freeze sim time, timers, audio; dim overlay | `resume` -> previous state | none |
| Aborted | `abort` received or fatal error | Stop immediately; Score.Build(false) with partial outcomes | `result` (aborted=true) then `requestExit` | `result`, `requestExit` |

Pause/resume: on `pause` the state machine freezes simulation time, timers (including decision windows), audio and haptic loops; `resume` continues the same frame. Abort: emit `result` with `aborted=true`, `abortReason`, partial `outcomes`, `xpEarned: 0`, then `requestExit`.

## 9. Difficulty levels 1-5
| Parameter | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Scenario tags | `basic` (clear correct lane) | `basic`,`weak-side` | +`bumper`,`reset` | +`aggressive`,`5v3` | all |
| Options offered | 5 players | 5 players | 5 + Shoot + Reset | 5 + Shoot + Reset | 5 + Shoot + Reset |
| Lane overlay before decision | full | points only | no | no | no |
| Circulation time before freeze (s) | 2 | 3 | 4 | 4 | 5 |
| Decision window (ms, 0 = untimed) | 0 | 0 | 0 | 6000 | 4000 |
| Hints | 2 | 1 | 1 | 0 | 0 |
| Killer shifting | none (static) | slow | normal | fast | fast + fake shifts |

Level 1 is passable by a true beginner: one lane is obviously open and lanes are drawn. **Default for `tac-pp-seams` is 2; `eye-pp-story` uses 3.**

## 10. Configuration schema
`LaunchRequest.configuration` fragment (draft 2020-12). Invalid configuration yields `error CONFIG_INVALID` (recoverable=false).

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "type": "object",
  "properties": {
    "seed": {
      "type": "integer",
      "minimum": 0,
      "description": "Optional. Same seed and inputs give an identical run."
    },
    "scenarioSetId": {
      "type": "string",
      "description": "Which pool to draw from.",
      "enum": [
        "pp-starter",
        "pp-advanced"
      ]
    },
    "rounds": {
      "type": "integer",
      "minimum": 3,
      "maximum": 6,
      "default": 3,
      "description": "Number of rounds in the session."
    },
    "ppFormation": {
      "type": "string",
      "enum": [
        "1-3-1",
        "umbrella",
        "overload"
      ],
      "default": "1-3-1"
    },
    "pkFormation": {
      "type": "string",
      "enum": [
        "box",
        "diamond",
        "aggressive-box",
        "triangle"
      ],
      "default": "box"
    },
    "manpower": {
      "type": "string",
      "enum": [
        "5v4",
        "5v3"
      ],
      "default": "5v4"
    },
    "allowShootReset": {
      "type": "boolean",
      "default": false
    },
    "showLanes": {
      "type": "boolean",
      "default": true
    },
    "decisionWindowMs": {
      "type": "integer",
      "minimum": 0,
      "maximum": 8000,
      "default": 0
    }
  },
  "required": [
    "scenarioSetId"
  ],
  "additionalProperties": false
}
```

Valid example:

```json
{
  "seed": 11,
  "scenarioSetId": "pp-starter",
  "rounds": 3,
  "ppFormation": "1-3-1",
  "pkFormation": "box",
  "manpower": "5v4",
  "allowShootReset": false,
  "showLanes": true,
  "decisionWindowMs": 0
}
```

## 11. Scenario data set
Scenario JSON gives all attacker and killer positions at the freeze plus the correct action; the pass and shot animation are derived. Coordinates are rink feet in the offensive zone (origin center ice, +x toward the goal at x=89, y across; +y is top of screen). The evaluator uses `laneClearanceFt` = minimum distance from any killer to the pass segment; a lane is open when clearance > 5.5 ft. **Pool size N = 10** (rounds x 3 minimum is 9). Scenarios ship as `pp-starter.json / pp-advanced.json` inside the sim's Addressables bundle (JSON, array of scenario objects). Selection is deterministic per `seed`: shuffle with `Rng(seed)`, filter by the difficulty tags in section 9, take `rounds` scenarios, never repeating a `teaches` concept back-to-back if avoidable.

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| PP-01 | 1-3-1 vs box shifted to the puck side; weak flank open | Pass to right flank F_R | pp-formations | basic, weak-side |
| PP-02 | 1-3-1 vs centered box; puck on the left flank; bumper lane clear | Pass to bumper B | slot | basic, bumper |
| PP-03 | Umbrella vs diamond; point man holds the puck; diamond's low man leaves the net-front | Pass to net-front N for a tip | screen-tip | basic |
| PP-04 | 1-3-1 vs aggressive diamond; killer rushes the point; flank is open | Quick pass to left flank before pressure arrives | one-timer | aggressive |
| PP-05 | 5-on-3, two killers in a triangle; cross-seam pass to the back-door player | Pass to net-front N (far post) | pp-formations | 5v3 |
| PP-06 | Umbrella vs passive box; the net-front screens the goalie | Shoot from the point | screen-tip | reset, shoot |
| PP-07 | Overload on the strong side; killers collapse; the weak-side flank is uncovered but far | Pass to weak-side flank | pp-formations | weak-side, aggressive |
| PP-08 | 1-3-1 vs aggressive box; all forward lanes blocked | Reset to the point P | pk-formations | reset, aggressive |
| PP-09 | Diamond kill; killer over-commits at the top; bumper is behind him | Pass to bumper B | pk-formations | bumper |
| PP-10 | Umbrella; the box collapses to the slot; the flank shooter is now unguarded | Pass to right flank for the one-timer | one-timer | basic, weak-side |

Fully written scenarios (canonical data format; the rest follow the same shape):

**PP-01 `weak-side-open` (tags: basic, weak-side)**

```json
{
  "scenarioId": "PP-01",
  "title": "Weak side is wide open",
  "manpower": "5v4",
  "ppFormation": "1-3-1",
  "pkFormation": "box (shifted strong side)",
  "puckHolder": "P",
  "attackers": {
    "P": {
      "x": 30,
      "y": 12
    },
    "F_L": {
      "x": 56,
      "y": 26
    },
    "F_R": {
      "x": 56,
      "y": -26
    },
    "B": {
      "x": 62,
      "y": 0
    },
    "N": {
      "x": 82,
      "y": -2
    }
  },
  "penaltyKillers": {
    "hi1": {
      "x": 48,
      "y": 16
    },
    "hi2": {
      "x": 48,
      "y": 2
    },
    "lo1": {
      "x": 72,
      "y": 16
    },
    "lo2": {
      "x": 72,
      "y": 2
    }
  },
  "options": [
    {
      "target": "F_L",
      "laneClearanceFt": 5.0,
      "passLengthFt": 29.5,
      "laneOpen": false
    },
    {
      "target": "F_R",
      "laneClearanceFt": 9.2,
      "passLengthFt": 46.0,
      "laneOpen": true
    },
    {
      "target": "B",
      "laneClearanceFt": 3.0,
      "passLengthFt": 34.2,
      "laneOpen": false
    },
    {
      "target": "N",
      "laneClearanceFt": 1.3,
      "passLengthFt": 53.9,
      "laneOpen": false
    }
  ],
  "correct": "F_R",
  "why": "Box shifted to the puck side; only the weak flank has a clear lane and a one-timer angle.",
  "copyKey": "pp-seam",
  "teaches": "pp-formations"
}
```

**PP-02 `bumper-open` (tags: basic, bumper)**

```json
{
  "scenarioId": "PP-02",
  "title": "Bumper in the middle of the box",
  "manpower": "5v4",
  "ppFormation": "1-3-1",
  "pkFormation": "box (centered)",
  "puckHolder": "F_L",
  "attackers": {
    "P": {
      "x": 30,
      "y": 12
    },
    "F_L": {
      "x": 56,
      "y": 26
    },
    "F_R": {
      "x": 56,
      "y": -26
    },
    "B": {
      "x": 62,
      "y": 0
    },
    "N": {
      "x": 82,
      "y": -2
    }
  },
  "penaltyKillers": {
    "hi1": {
      "x": 50,
      "y": 12
    },
    "hi2": {
      "x": 50,
      "y": -12
    },
    "lo1": {
      "x": 72,
      "y": 12
    },
    "lo2": {
      "x": 72,
      "y": -12
    }
  },
  "options": [
    {
      "target": "P",
      "laneClearanceFt": 9.5,
      "passLengthFt": 29.5,
      "laneOpen": true
    },
    {
      "target": "F_R",
      "laneClearanceFt": 6.0,
      "passLengthFt": 52.0,
      "laneOpen": true
    },
    {
      "target": "B",
      "laneClearanceFt": 9.0,
      "passLengthFt": 26.7,
      "laneOpen": true
    },
    {
      "target": "N",
      "laneClearanceFt": 2.2,
      "passLengthFt": 38.2,
      "laneOpen": false
    }
  ],
  "correct": "B",
  "why": "Short lane into the slot, clear of all four killers; cross-ice pass is longer and the net-front lane is blocked.",
  "copyKey": "pp-seam",
  "teaches": "pp-formations"
}
```

**PP-08 `reset-not-force` (tags: reset, aggressive)**

```json
{
  "scenarioId": "PP-08",
  "title": "Reset beats the fancy pass",
  "manpower": "5v4",
  "ppFormation": "1-3-1",
  "pkFormation": "aggressive box (pressure on puck)",
  "puckHolder": "F_L",
  "attackers": {
    "P": {
      "x": 30,
      "y": 12
    },
    "F_L": {
      "x": 56,
      "y": 26
    },
    "F_R": {
      "x": 56,
      "y": -26
    },
    "B": {
      "x": 62,
      "y": 0
    },
    "N": {
      "x": 82,
      "y": -2
    }
  },
  "penaltyKillers": {
    "hi1": {
      "x": 53,
      "y": 16
    },
    "hi2": {
      "x": 50,
      "y": -4
    },
    "lo1": {
      "x": 70,
      "y": 10
    },
    "lo2": {
      "x": 72,
      "y": -10
    }
  },
  "options": [
    {
      "target": "P",
      "laneClearanceFt": 7.4,
      "passLengthFt": 29.5,
      "laneOpen": true
    },
    {
      "target": "F_R",
      "laneClearanceFt": 3.0,
      "passLengthFt": 52.0,
      "laneOpen": false
    },
    {
      "target": "B",
      "laneClearanceFt": 5.2,
      "passLengthFt": 26.7,
      "laneOpen": false
    },
    {
      "target": "N",
      "laneClearanceFt": 0.6,
      "passLengthFt": 38.2,
      "laneOpen": false
    }
  ],
  "correct": "P",
  "why": "Pressure closes every lane in front; a reset to the point is the only clean pass and moves the killers again.",
  "copyKey": "pp-reset",
  "teaches": "pp-formations"
}
```

Remaining scenarios use the same shape. Generation rules: every scenario has exactly one option with `laneOpen=true` and the best chance quality, or (reset scenarios) exactly one clean option; distractors have `laneClearanceFt <= 5.5` or pass length > 48 ft (slow cross-ice pass, flagged `slow`). Killer and attacker positions vary +/-2 ft with the seed but options' open/blocked status must not change (data lint over 50 seeded jitters).

## 12. Freeze / explain moments
Copy is keyed by `copyKey`; every string satisfies title <= 6 words, body <= 45 words.

**pp-seam**
- Trigger: Correct pass to the open seam (PP-01, 02, 03, 07, 09, 10)
- What freezes: Puck mid-pass
- Camera: `top-down`
- Callouts: Open lane in gold; blocked lanes dashed rose; killers ringed with reach circles; seam zone shaded
- Correct outcome: Title "Nice read.". Body: "The killers shifted toward the puck, so the far side opened up. Moving the puck across the box before they recover creates the clean look. That is the whole power play." Say this: "They overloaded one side, so the weak flank was open."
- Incorrect outcome: Title "Not quite.". Body: "That lane was blocked: a killer's stick covers it. Look for the lane with nobody near it, usually on the side the killers left." Say this: "They overloaded one side, so the weak flank was open."

**pp-oneTimer**
- Trigger: One-timer scenarios (PP-04, 10)
- What freezes: The moment the pass reaches the flank shooter
- Camera: `broadcast-side`
- Callouts: Gold shot cone from the shooter; killer's reach circle
- Correct outcome: Title "Nice read.". Body: "A quick pass to the flank gives a one-timer before the goalie can slide over. The shot is the pass. Fast passing beats fast killers." Say this: "Get it to the flank fast for a one-timer."
- Incorrect outcome: Title "Not quite.". Body: "Holding the puck let the killer close the lane. A fast pass to the flank makes the shooter's job easy." Say this: "Get it to the flank fast for a one-timer."

**pp-reset**
- Trigger: Reset scenario (PP-08)
- What freezes: Pass back to the point
- Camera: `top-down`
- Callouts: All forward lanes dashed rose; the reset lane gold
- Correct outcome: Title "Nice read.". Body: "Every forward lane was covered, so you reset. Passing back to the point keeps possession and makes the killers move again. Patient power plays score more." Say this: "They took away the middle, so we reset."
- Incorrect outcome: Title "Not quite.". Body: "Forcing it into traffic gave the puck away. When every forward lane is blocked, reset to the point and try again." Say this: "They took away the middle, so we reset."

**pp-screen**
- Trigger: Point shot with a screen (PP-03, 06)
- What freezes: Shot leaving the stick
- Camera: `broadcast-side`
- Callouts: Goalie's line of sight highlighted; net-front player ringed gold
- Correct outcome: Title "Nice read.". Body: "A shot from the point works when a teammate screens the goalie. He can't see it. Tips and rebounds are the goals from there." Say this: "Shoot from the point with a screen in front."
- Incorrect outcome: Title "Not quite.". Body: "A shot from the point without a screen is easy to stop. Look for the player standing in front of the goalie." Say this: "Shoot from the point with a screen in front."

**pp-5v3**
- Trigger: 5-on-3 scenario (PP-05)
- What freezes: Cross-seam pass
- Camera: `top-down`
- Callouts: The two killers highlighted; the open far post gold
- Correct outcome: Title "Nice read.". Body: "With two killers they can't cover everyone. A cross-seam pass to the far post forces one killer to guess. Two men down means one always gets open." Say this: "It's a five-on-three, so someone's always open."
- Incorrect outcome: Title "Not quite.". Body: "Two killers can't cover the whole zone. Find the far post: a pass across the seam makes them move and leaves a gap." Say this: "It's a five-on-three, so someone's always open."

## 13. Scoring & mastery signals
- **Round score:** 1.0 for the best option; 0.5 for a second-best safe option (lane open but lower quality, or a reset when a shot was open); 0 for a blocked lane.
- **Score (0-100):** `round(mean(roundScore) * 100)`, minus `5` per hint used (floor 0). **Accuracy:** correct rounds / rounds played. **Outcome ids:** `round-1`..`round-N`, `success` = round fully correct, `label` = scenario title, `value` = scenarioId.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (in `mistakes[].description`) |
|---|---|---|
| Passed into a blocked lane | pk-formations | A killer's stick reached the pass lane, so the puck was intercepted. |
| Forced a cross-ice pass | pp-formations | The long cross pass gave the killers time to recover. |
| Held for too long | one-timer | The lane closed while the puck waited. |
| Shot without a screen | screen-tip | The shot from the point had no screen, so the goalie saw it. |
| Missed the slot chance | slot | A clean lane into the slot was open and a lower-value pass was chosen. |

**Mastery signals**

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Best option chosen | pp-formations | +0.20 | Found the seam against the killers' shape. |
| Best option in an aggressive kill | pk-formations | +0.20 | Beat an aggressive penalty kill. |
| Correct bumper/slot pass | slot | +0.20 | Passed to the high-danger slot. |
| Correct flank one-timer | one-timer | +0.20 | Set up the one-timer. |
| Correct point shot with screen | screen-tip | +0.20 | Used the screen. |
| Blocked-lane pass | pk-formations | -0.15 | Passed into a blocked lane. |
| Forced pass when reset was right | pp-formations | -0.10 | Did not reset when everything was covered. |

Per-session caps: +0.30 and -0.20 per conceptId; a hint used halves that round's positive delta (Hint primitive records `UsedCount`). Signals are emitted once per round at Freeze exit. `mistakes[].at` = ms since play start (excludes paused time).

**SimulationResult mapping:** `outcomes[]` one per round; `mistakes[]` one per wrong decision; `masterySignals[]` per table above; `score`, `accuracy`, `durationMs` as defined; `replayAvailable=true` (Replay primitive keeps the last round of each scenario).

## 14. XP & hearts
- **xpEarned proposal:** `10 x correctRounds + (completed ? 40 : 0)`, capped at 70. Native clamps to the lesson XP budget (D-009).
- **heartsLost:** 1 if `accuracy < 0.34` (fewer than one correct round in three), otherwise 0. Maximum 1 per session. Unlimited-hearts learners (`runtime.unlimitedHearts`) report the same number; native ignores it.
- **replayAvailable:** true after any completed session; replay is a review tool, awards no XP and never changes the stored result.

## 15. Failure states
| Situation | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round (wrong call) | Explain moment with the incorrect copy, the correct moment replayed once from the explain camera, then "Next play" | `outcomes[i].success=false`, one mistake, negative signal | No (session rule only) |
| Failed session (<1 correct of 3) | Summary card: "Rough shift. Want the slow version?" plus Try again (native) and the primer lesson link | `completed=true`, `accuracy<0.34`, `score` as computed | -1 |
| Decision timeout (levels 3-5) | Card: "The clock ran out and the killers reset. Try the wide lane next." then explain. | Round marked failed, mistake tagged `timeout` | No |
| Abort / user quit | Native confirmation; on confirm Unity stops | `aborted=true`, `abortReason`, `xpEarned=0` | No |
| Backgrounded > 120 s | Native aborts (`backgrounded-too-long`) | `aborted=true` | No |
| Asset missing | Friendly retry sheet (native) | `error ASSET_LOAD_FAILED`, recoverable | No |
| Invalid configuration | Skip activity (native), no penalty | `error CONFIG_INVALID` | No |

Every failed round still ends in an explain moment; there is no dead end.

## 16. Accessibility
- **Reduced motion:** camera cuts replace dolly and sweeps; slow-motion ramps become a straight cut to the frozen frame; no shake; highlight pulses become static outlines.
- **Haptics off:** all cues below become visual only; nothing depends on haptics.
- **Color-blind modes:** rose/gold are never the only channel. Team A wears solid jerseys with a **number**; team B wears **striped** jerseys with a number. Highlights use shape as well as color: rose = ring, gold = check-mark badge, muted = dashed outline.
- **Text scale:** overlay copy honors `textScale` up to 2.0 (cards grow vertically, body scrolls if needed; the decision buttons never truncate).
- **Tap-only:** Everything is a tap on a character or a button; no drags. Targets can also be chosen from a bottom list of five named buttons ("Point", "Left flank", "Right flank", "Bumper", "Net-front") in accessibility mode.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Accessible native fallback lesson: **`tac-pp-formations` (native `visual-id` and `hotspot-tap` with a written seam explanation)** (a separate, designed native exercise set; not a port).
- Lane state is drawn with line style (solid vs dashed) and labelled with a short word ("open"/"blocked") in high-contrast text.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Decision available | soft stick tap on ice | none | -18 dB |
| Correct call | short rising two-note chime (original) | light success | -14 dB |
| Incorrect call | muted low thud | warning (single) | -16 dB |
| Freeze | crowd ambience ducks 80%, ice hiss | none | -20 dB |
| Pass and shot | original crisp stick-on-puck tap | soft tap | -15 dB |
| Summary | two-note resolve | light success if score >= 60 | -14 dB |

All sounds respect `soundEnabled`; all haptics respect `hapticsEnabled`. Ambient crowd is a looped procedural noise bed, no recorded broadcast audio.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Offensive zone | procedural | original | ~2k tris | lines to scale |
| 10 characters | procedural | original | ~600 tris each | striped/solid, numbers |
| Puck, lane meshes, reach circles | procedural | original | small | alpha 0.35 overlays |
| Audio | synthesized | original-swoond | < 1 MB | - |

- **Overlay styling:** per `docs/astra/ART_DIRECTION.md`: rose = you/act, gold = earned/correct, dim everything not being explained, one focal idea per frame. Rink markings are procedural; NHL and team logos are never used (jerseys are generic stripes/solids with numbers).
- **Addressables bundle:** `sim.hockey.special-teams.power-play-spacing.v1` , expected about 3 MB compressed (<= 25 MB budget).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply and are not loosened: 60 fps on iPhone 13-class (p5 >= 50), peak Unity memory < 150 MB, cold launch to `ready` < 2 s (4 s first load), bundle <= 25 MB, draw calls <= 150, <= 60k on-screen triangles, <= 15 materials, textures <= 8 MB VRAM, thermal state not above "fair" over a 3-minute session.
Tighter per-sim limits: Lane evaluation (10 lines x 4 killers) < 0.1 ms per frame; overlays via batched line renderers.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus counters:
| key | meaning |
|---|---|
| hintsUsed | total Hint uses |
| decisionLatencyMsAvg | mean time from Decision open to input |
| scenarioIds | comma-joined scenario ids played (no free text) |
| laneClearanceChosenFtAvg | clearance of the chosen lane on average |
| resetChosen | count of reset choices |

Never include `personName`, `relationship`, device identifiers or free text.

## 21. Acceptance criteria (testable)
- **AC-1 (determinism):** With seed 42, difficulty 2 and `rounds=3` the sim selects the same three scenarioIds and emits exactly 3 `outcomes` on every run.
- **AC-2 (bridge lifecycle):** Given `examples/football-coverage-read-launch.json` adapted to this simulationId, the sim emits `ready` within 2000 ms, at least one `checkpoint` per round, exactly one `result` and then `requestExit`; the result validates against `simulation-result.schema.json`.
- **AC-3 (config):** Every invalid configuration (unknown key, `rounds` out of range, unknown `scenarioSetId`) yields `error CONFIG_INVALID` and no `ready`.
- **AC-4 (pause/abort):** While paused for 30 s, `durationMs` grows by 0 and no decision timer advances; `abort` yields a result with `aborted=true` and `xpEarned=0` within 1000 ms.
- **AC-5 (explain):** Every round ends with exactly one Explain moment; title <= 6 words and body <= 45 words for every string in the copy table (checked by an EditMode test over all scenario data).
- **AC-6 (mapping):** Every wrong decision yields a `mistakes[]` entry whose `conceptId` exists in the scenario's `teaches` list and a negative `masterySignals` delta for that concept.
- **AC-7 (privacy):** With `personName="Test"` the string "Test" never appears in any emitted message, log line or telemetry field.
- **AC-8 (accessibility):** With `reducedMotion=true` no camera translation exceeds one frame (cuts only); with each `colorBlindMode` the correct/incorrect highlight remains distinguishable by shape (asserted by checking the highlight style ids).
- **AC-9 (performance):** On iPhone 13-class hardware a 3-round session holds avg fps >= 58, p5 >= 50, peak memory < 150 MB, cold launch < 2 s.
- **AC-10 (lane evaluator):** For every scenario `LaneEvaluator` returns `laneClearanceFt` matching the authored options within 0.1 ft, and exactly one option is marked best.
- **AC-11 (jitter safe):** Under 50 seeded position jitters (+/-2 ft) per scenario the open/blocked flag of every option never changes.
- **AC-12 (options by level):** At difficulty 1-2 no Shoot/Reset buttons exist; at 3+ they exist and the puck holder is required for Shoot.
- **AC-13 (chance result):** Passing to a blocked lane always produces `Intercepted`; passing to the best option produces `Great look`.
- **AC-14 (reach circles):** The Hint shows a 5.5 ft reach circle around each killer and costs exactly 5 points.

## 22. Test plan
- **EditMode:** scenario data schema and copy-length lint; rule evaluators (see sim-specific tests); scoring maths; determinism by seed; result-schema validity; configuration schema validation.
- **PlayMode:** scene builds from code with no scene assets; scripted full run (all-correct, all-wrong, mixed); freeze/explain sequence; pause/resume; abort; reduced-motion path; color-blind highlight styles.
- **Perf:** measured run on iPhone 13-class with the Unity Profiler and the standard telemetry counters; results attached to the PR.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | ScenarioSelection_IsDeterministicForSeed |
| AC-2 | PlayMode | Bridge_FullLifecycle_ProducesValidResult |
| AC-3 | EditMode | Config_InvalidInputs_ReturnConfigInvalid |
| AC-4 | PlayMode | PauseAbort_FreezesTimeAndReturnsAborted |
| AC-5 | EditMode | ExplainCopy_LengthLimits |
| AC-6 | EditMode | Scoring_MistakeAndSignalMapping |
| AC-7 | EditMode | Privacy_NoPersonNameInOutput |
| AC-8 | PlayMode | Accessibility_ReducedMotionAndColorBlind |
| AC-9 | Perf | Perf_ThreeRoundSession_iPhone13 |
| AC-10 | EditMode | LaneEvaluator_MatchesAuthoredData |
| AC-11 | EditMode | Scenarios_StableUnderJitter |
| AC-12 | PlayMode | OptionsByDifficulty |
| AC-13 | PlayMode | PassResults_MatchLaneState |
| AC-14 | PlayMode | Hint_ShowsReachCirclesAndCostsFive |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Reach radius 5.5 ft: confirm it reads well on screen at portrait scale | Astra | No |
| 2 | Should the shot outcome (goal/save) be shown or only 'chance quality'? | Product | No |
| 3 | Umbrella and overload shapes: verify shape naming with a coach before approving copy | Claude (content) | No |
| 4 | Zone width in portrait: crop to x 20-95 ft? | Astra | No |
