# Break the Press: Forecheck Read (`hockey.tactics.forecheck-read.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `hockey.tactics.forecheck-read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (definition file optional: this sim is scenario-data driven, see section 11) |
| Authors / date | Swoon'd content team (Claude), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `hockey`. Units and lessons that launch this sim: unit `systems-tactics` lesson `tac-forecheck-read`.
- CDS row: `docs/courses/hockey/CDS.md` section 12, family `forecheck-read`.
- Manifest entry: `docs/courses/hockey/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered`, otherwise the lesson shows a native primer first): `forecheck`, `breakout`, `zones` (native lesson `tac-forecheck` first).

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can look at how a team is forechecking and choose the safest way to break the puck out of your own end.
| conceptId | term | after the sim the learner can... |
|---|---|---|
| forecheck | Forecheck | identify 1-2-2, 2-1-2 and left-wing-lock shapes and where they leave space |
| breakout | Breakout | choose between boards, reverse, middle and chip based on where pressure is |
| backcheck | Backcheck | see why the forwards' back-pressure matters after a failed breakout |
| neutral-zone-trap | Neutral-zone trap | recognize the passive setup that makes the breakout easy but the zone entry hard |

- **Out of scope:** Neutral-zone play after the breakout, and offensive forechecking as a player. The learner only chooses the breakout pass.

## 4. Why Unity (tier justification)
Rubric answers: (1) **Spatial reasoning and movement:** a forecheck is a shape of five skaters moving; the right breakout is the pass whose lane the shape cannot reach in time. (2) **Reading a dynamic scene:** the learner must read where pressure is, not recall a rule. (3) **Camera perspective:** the top-down view shows lanes and gaps at once. The closest native types are `hotspot-tap` (tap the open teammate on a static diagram) and `visual-id` (name the shape). Those teach names and are used in `tac-forecheck`; they cannot show how quickly a forechecker closes a lane, which is why the choice needs motion.

## 5. Player fantasy & core loop
**Fantasy:** You are the defenseman with the puck behind your own net and a forechecker closing in.

1. **Prompt:** "Pressure's coming. Where does the puck go?"
2. **Playing:** defenseman retrieves the puck behind the net; the forecheck shape (1-2-2, 2-1-2, lock) closes in for 1.5-2 s at 0.6x.
3. **One decisive interaction:** tap one of four breakout options: **Up the boards**, **Reverse**, **Middle**, **Chip**.
4. **Execute:** the pass plays out; the forecheckers' interception paths are shown.
5. **Freeze / explain:** freeze at the pass; forechecker reach lines drawn from each forechecker; safe lanes gold, unsafe rose dashed; card explains.
6. **Say this:** e.g. "They took the boards, so we reversed it."

Session target: about 3 minutes, 3 rounds by default (`configuration.rounds`), drawn from the scenario pool in section 11.

## 6. Scene & entities
- **Environment:** `hockey_rink_defensive_zone (new registry key: own zone plus neutral zone, top-down)`. **Camera presets:** `top-down` (default), `broadcast-side` (execute), `chase-high` for the replay.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| D1 | Character (playerDefense) | puck carrier behind the net | (-95, 10) ft |
| D2 | Character (playerDefense) | partner defenseman | (-90, -20) |
| W_S, W_W | Character (playerWing) | strong-side and weak-side wingers | (-72, 36), (-66, -36) |
| C | Character (playerCenter) | support forward | (-66, 2) |
| F1..F5 | Character (opponent) | forecheckers (three forwards, two defense) | positions per scenario, speed 24 ft/s |
| puck | Ball | the puck | 55 ft/s pass, 70 ft/s chip |
| reachLines | Path + Highlight | forechecker reach for explain | gold / rose |
| decisionBar | DecisionPoint + 4 Targets | breakout choices | 4 targets over the receivers, 56 pt buttons in tap-only mode |

- **Reused primitives:** Ball, Character, Path, Zone, CameraRig, TouchController, DecisionPoint, Target, Hint, Explanation, Objective, Score, Replay, SlowMotion, Highlight, Rng, ScenarioSet.
- **Diagram (initial layout):**

```
  own goal line
     | (D1) behind net           F1 (pressure)
     |        (D2)                    F2   F3      <- forecheck shape (1-2-2 here)
     |   [W_S] up the wall
     |        [C]                                      F4      F5  (blue line)
     |   [W_W] far wall
  target options: boards-up -> W_S | reverse -> D2 | middle -> C | chip -> W_W
```

### Game Kit additions requested
| Addition | Why it is needed | Reuse plan |
|---|---|---|
| `Swoond.Sports.Hockey` `Rink`, `Puck`, `FormationSet` | Shared | All hockey sims |
| `InterceptionEvaluator` (time-to-reach a lane for pursuers with speed) | Deterministic safe/unsafe classification | Football coverage, soccer pressing, basketball closeouts |
| `Character.PursuitPath` (chase along a straight line at speed with reaction delay 0.2 s) | Forechecker motion | Any pursuit sim (racing pass attempts) |

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Up the boards | tap the strong-side winger (or button) | 44 pt min circle | rose ring; soft tap haptic |
| Reverse | tap the partner defenseman | 44 pt min | same |
| Middle | tap the center | 44 pt min | same |
| Chip | tap the far winger | 44 pt min | same |
| Hint | tap lightbulb | 44 pt | shows forechecker reach lines (costs 5 points) |

- **Tap-only alternative scheme:** Options are also four labelled buttons at the bottom ("Boards", "Reverse", "Middle", "Chip"); no drags anywhere.
- **Orientation / safe area:** portrait. All buttons live inside `runtime.safeAreaInsets`; the decision bar sits 28-34 pt above the bottom inset.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation (`requestExit` with `user-quit`; native shows "Leave game?"), XP/streak UI, lesson chrome.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate contract, simulationId, configuration; build rink and characters from code; load scenario set | `ready` sent -> Intro (invalid config -> `error CONFIG_INVALID`) | `ready` |
| Intro | Ready acknowledged | One-line objective card (Display S serif), 1.5 s; camera settles on the opening preset. Shows the four options as icons. | Auto -> Playing (first round) | `progress` 0.0 |
| Playing | Round starts | Camera top-down; D1 picks up the puck behind the net; forecheckers accelerate for 1.5-2.0 s at 0.6x, then the sim freezes at the scenario's `decisionAt`. | Decision point reached -> Decision | `progress` (<= 4 per second) |
| Decision | Decision point reached | Four targets appear with their labels; a timer bar shows at difficulty >= 4. | Input or time limit -> Executing | none |
| Executing | Decision recorded | The chosen pass travels at its speed; forecheckers continue on their pursuit paths; interception is resolved by the evaluator. | Outcome resolved -> Freeze | none |
| Freeze | Outcome resolved | Freeze at the first moment a pursuer reaches the lane (unsafe) or at the reception (safe). Reach lines from each forechecker are drawn. | 1.2 s (0.4 s with reduced motion) -> Explain | none |
| Explain | Freeze complete | Copy card slides up; "Why the others didn't work" chips highlight each other option's blocker. Tap "Next play" (or auto after 12 s at difficulty 4-5) advances. | Rounds left -> Playing; else -> Summary | `checkpoint` (round id) |
| Summary | All rounds done | Score card: score, accuracy, per-round chips, one "say this" line from the weakest concept; native shows XP | Continue tapped -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` (Score.Build(true)) | `result` then `requestExit` (`completed`) | `result`, `requestExit` |
| Paused | `pause` received | Freeze sim time, timers, audio; dim overlay | `resume` -> previous state | none |
| Aborted | `abort` received or fatal error | Stop immediately; Score.Build(false) with partial outcomes | `result` (aborted=true) then `requestExit` | `result`, `requestExit` |

Pause/resume: on `pause` the state machine freezes simulation time, timers (including decision windows), audio and haptic loops; `resume` continues the same frame. Abort: emit `result` with `aborted=true`, `abortReason`, partial `outcomes`, `xpEarned: 0`, then `requestExit`.

## 9. Difficulty levels 1-5
| Parameter | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Scenario tags | `passive`, `1-2-2` | +`2-1-2` | +`lock` | +`pinch` | all |
| Forecheck speed (ft/s) | 20 | 22 | 24 | 25 | 26 |
| Reach lines shown before decision | yes | no | no | no | no |
| Options | 2 (boards, middle) | 4 | 4 | 4 | 4 |
| Decision window (ms) | 0 | 0 | 0 | 5000 | 3500 |
| Hints | 2 | 1 | 1 | 0 | 0 |
| Margin rule (min /threat - required/ ft) | 8 | 5 | 3 | 3 | 3 |

Level 1 offers only the two most distinct options and shows reach lines; level 3 is the full model. **Default for `tac-forecheck-read` is 2.**

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
        "forecheck-starter",
        "forecheck-advanced"
      ]
    },
    "rounds": {
      "type": "integer",
      "minimum": 3,
      "maximum": 6,
      "default": 3,
      "description": "Number of rounds in the session."
    },
    "forecheck": {
      "type": "string",
      "enum": [
        "1-2-2",
        "2-1-2",
        "left-wing-lock",
        "passive"
      ],
      "description": "Optional: force one shape (otherwise mixed by scenarioSetId)."
    },
    "forecheckSpeedFps": {
      "type": "number",
      "minimum": 18,
      "maximum": 28,
      "default": 24
    },
    "showReachLines": {
      "type": "boolean",
      "default": false
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
  "seed": 3,
  "scenarioSetId": "forecheck-starter",
  "rounds": 3,
  "forecheck": "1-2-2",
  "forecheckSpeedFps": 22,
  "showReachLines": true,
  "decisionWindowMs": 0
}
```

## 11. Scenario data set
Each scenario provides D1, teammates and five forecheckers at the freeze plus the evaluator inputs. A pass is **safe** when the minimum distance from any forechecker to the pass segment exceeds `requiredClearanceFt = 24 ft/s x passTime` (pass speed 55 ft/s, chip 70 ft/s). The correct option is the safe one with the greatest forward `advanceFt`, ties broken by the shorter pass. Coordinates: rink feet, origin center ice, +x toward the opponent's goal. **Pool size N = 9** (rounds x 3 minimum is 9). Scenarios ship as `forecheck-starter.json / forecheck-advanced.json` inside the sim's Addressables bundle (JSON, array of scenario objects). Selection is deterministic per `seed`: shuffle with `Rng(seed)`, filter by the difficulty tags in section 9, take `rounds` scenarios, never repeating a `teaches` concept back-to-back if avoidable.

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| FC-01 | 1-2-2: F1 pressures on the strong side, F2 and F3 sit mid-zone on the wall and middle | Reverse | forecheck | 1-2-2 |
| FC-02 | 2-1-2: F1 and F2 deep, F3 high in the middle | Up the boards | breakout | 2-1-2 |
| FC-03 | Left-wing lock: F2 sits on the strong wall, F3 in the middle; weak wing free | Chip to the weak wing | forecheck | lock |
| FC-04 | Passive 1-4: nobody pressures the puck | Middle | neutral-zone-trap | passive |
| FC-05 | 1-2-2 wide: F2 steps to the wall, F3 covers the middle | Reverse | breakout | 1-2-2 |
| FC-06 | Late forechecker: F1 is still at the blue line; wingers covered but middle open | Middle | breakout | passive |
| FC-07 | 2-1-2 pinch: F1 blocks the wall, F3 sits on center | Reverse | forecheck | pinch |
| FC-08 | 1-2-2 with F1 cutting off behind the net: reverse and wall blocked, middle clear | Middle | backcheck | pinch |
| FC-09 | 1-3-1 neutral-zone setup with F1 at the top: middle blocked, wall clear | Up the boards | neutral-zone-trap | passive |

Fully written scenarios (canonical data format; the rest follow the same shape):

**FC-01 `reverse-it` (tags: 1-2-2)**

```json
{
  "scenarioId": "FC-01",
  "title": "Reverse it",
  "forecheck": "1-2-2",
  "puckHolder": {
    "id": "D1",
    "x": -95,
    "y": 10
  },
  "teammates": {
    "D2": {
      "x": -90,
      "y": -20
    },
    "W_S": {
      "x": -72,
      "y": 36
    },
    "C": {
      "x": -66,
      "y": 2
    },
    "W_W": {
      "x": -66,
      "y": -36
    }
  },
  "forecheckers": {
    "F1": {
      "x": -80,
      "y": 20
    },
    "F2": {
      "x": -58,
      "y": 26
    },
    "F3": {
      "x": -58,
      "y": -4
    },
    "F4": {
      "x": -30,
      "y": 20
    },
    "F5": {
      "x": -52,
      "y": -30
    }
  },
  "options": [
    {
      "option": "boards-up",
      "target": "W_S",
      "passLengthFt": 34.7,
      "threatDistFt": 4.6,
      "requiredClearanceFt": 15.1,
      "safe": false,
      "advanceFt": 23
    },
    {
      "option": "reverse",
      "target": "D2",
      "passLengthFt": 30.4,
      "threatDistFt": 18.0,
      "requiredClearanceFt": 13.3,
      "safe": true,
      "advanceFt": 5
    },
    {
      "option": "middle",
      "target": "C",
      "passLengthFt": 30.1,
      "threatDistFt": 10.0,
      "requiredClearanceFt": 13.1,
      "safe": false,
      "advanceFt": 29
    },
    {
      "option": "chip",
      "target": "W_W",
      "passLengthFt": 54.4,
      "threatDistFt": 15.2,
      "requiredClearanceFt": 18.6,
      "safe": false,
      "advanceFt": 29
    }
  ],
  "correct": "reverse",
  "copyKey": "fc-reverse",
  "teaches": [
    "forecheck",
    "breakout"
  ]
}
```

**FC-02 `up-the-boards` (tags: 2-1-2)**

```json
{
  "scenarioId": "FC-02",
  "title": "Up the boards",
  "forecheck": "2-1-2",
  "puckHolder": {
    "id": "D1",
    "x": -95,
    "y": 10
  },
  "teammates": {
    "D2": {
      "x": -90,
      "y": -20
    },
    "W_S": {
      "x": -72,
      "y": 36
    },
    "C": {
      "x": -66,
      "y": 2
    },
    "W_W": {
      "x": -66,
      "y": -36
    }
  },
  "forecheckers": {
    "F1": {
      "x": -82,
      "y": -4
    },
    "F2": {
      "x": -84,
      "y": -10
    },
    "F3": {
      "x": -54,
      "y": 0
    },
    "F4": {
      "x": -30,
      "y": 22
    },
    "F5": {
      "x": -30,
      "y": -22
    }
  },
  "options": [
    {
      "option": "boards-up",
      "target": "W_S",
      "passLengthFt": 34.7,
      "threatDistFt": 19.1,
      "requiredClearanceFt": 15.1,
      "safe": true,
      "advanceFt": 23
    },
    {
      "option": "reverse",
      "target": "D2",
      "passLengthFt": 30.4,
      "threatDistFt": 7.6,
      "requiredClearanceFt": 13.3,
      "safe": false,
      "advanceFt": 5
    },
    {
      "option": "middle",
      "target": "C",
      "passLengthFt": 30.1,
      "threatDistFt": 10.0,
      "requiredClearanceFt": 13.1,
      "safe": false,
      "advanceFt": 29
    },
    {
      "option": "chip",
      "target": "W_W",
      "passLengthFt": 54.4,
      "threatDistFt": 1.4,
      "requiredClearanceFt": 18.6,
      "safe": false,
      "advanceFt": 29
    }
  ],
  "correct": "boards-up",
  "copyKey": "fc-boards",
  "teaches": [
    "forecheck",
    "breakout"
  ]
}
```

**FC-04 `no-pressure` (tags: passive)**

```json
{
  "scenarioId": "FC-04",
  "title": "No pressure, go up the middle",
  "forecheck": "passive 1-4",
  "puckHolder": {
    "id": "D1",
    "x": -95,
    "y": 10
  },
  "teammates": {
    "D2": {
      "x": -90,
      "y": -20
    },
    "W_S": {
      "x": -72,
      "y": 36
    },
    "C": {
      "x": -66,
      "y": 2
    },
    "W_W": {
      "x": -66,
      "y": -36
    }
  },
  "forecheckers": {
    "F1": {
      "x": -45,
      "y": 10
    },
    "F2": {
      "x": -30,
      "y": 30
    },
    "F3": {
      "x": -30,
      "y": 10
    },
    "F4": {
      "x": -30,
      "y": -10
    },
    "F5": {
      "x": -30,
      "y": -30
    }
  },
  "options": [
    {
      "option": "boards-up",
      "target": "W_S",
      "passLengthFt": 34.7,
      "threatDistFt": 37.4,
      "requiredClearanceFt": 15.1,
      "safe": true,
      "advanceFt": 23
    },
    {
      "option": "reverse",
      "target": "D2",
      "passLengthFt": 30.4,
      "threatDistFt": 49.3,
      "requiredClearanceFt": 13.3,
      "safe": true,
      "advanceFt": 5
    },
    {
      "option": "middle",
      "target": "C",
      "passLengthFt": 30.1,
      "threatDistFt": 22.5,
      "requiredClearanceFt": 13.1,
      "safe": true,
      "advanceFt": 29
    },
    {
      "option": "chip",
      "target": "W_W",
      "passLengthFt": 54.4,
      "threatDistFt": 36.5,
      "requiredClearanceFt": 18.6,
      "safe": true,
      "advanceFt": 29
    }
  ],
  "correct": "middle",
  "copyKey": "fc-middle",
  "teaches": [
    "breakout"
  ]
}
```

Remaining scenarios are stored in the same shape and were computed by the reference evaluator (any change to the evaluator requires regenerating `options`). Lint rules: exactly one option is best; every option's `|threatDistFt - requiredClearanceFt| >= 3.0` ft (so the call is not ambiguous) at difficulty >= 3 and >= 5 ft at difficulty 2; positions vary +/-2 ft with the seed but the lint must still pass for every seed 0-99.

## 12. Freeze / explain moments
Copy is keyed by `copyKey`; every string satisfies title <= 6 words, body <= 45 words.

**fc-reverse**
- Trigger: Correct reverse (FC-01, 05, 07)
- What freezes: Pass to D2 in flight
- Camera: `top-down`
- Callouts: Forechecker reach lines: rose on the wall and middle, gold on the reverse lane; 'weak side open' tag
- Correct outcome: Title "Nice read.". Body: "The forecheck loaded one side, so the reverse to your partner is free. It shifts the pressure and starts a clean breakout. Reverses beat forwards who over-commit." Say this: "They loaded the strong side, so we reversed it."
- Incorrect outcome: Title "Not quite.". Body: "That option ran straight into a forechecker's reach. The far side was open: reversing the puck to your partner gets it out of trouble." Say this: "They loaded the strong side, so we reversed it."

**fc-boards**
- Trigger: Correct up-the-boards pass (FC-02, 09)
- What freezes: Puck reaching the winger
- Camera: `top-down`
- Callouts: Wall lane gold; the two rose blockers on the middle and reverse lanes
- Correct outcome: Title "Nice read.". Body: "The forecheck left the wall alone. A simple pass up the boards gets it out and gains ice. Not every breakout needs to be fancy." Say this: "The wall was open, so we just went up the boards."
- Incorrect outcome: Title "Not quite.". Body: "The wall was open and you didn't take it. The middle was jammed and the reverse was covered: the boards were the safe way out." Say this: "The wall was open, so we just went up the boards."

**fc-middle**
- Trigger: Correct middle pass (FC-04, 06, 08)
- What freezes: Puck reaching the center
- Camera: `top-down`
- Callouts: Middle lane gold; forechecker reach circles small and far
- Correct outcome: Title "Nice read.". Body: "No one was near the middle lane. A pass to the center gains the most ice and starts the rush. Take what the forecheck gives you." Say this: "Up the middle. Nobody was there."
- Incorrect outcome: Title "Not quite.". Body: "The middle was clear and the safer-looking pass gave up ice. When nobody pressures the lane, use it." Say this: "Up the middle. Nobody was there."

**fc-chip**
- Trigger: Correct chip (FC-03)
- What freezes: Puck banked off the glass
- Camera: `broadcast-side`
- Callouts: Bank line and far-wall lane gold; the wall and middle blocked
- Correct outcome: Title "Nice read.". Body: "The wall and middle were locked. Chipping the puck off the far boards gets it past the pressure to your winger. It is the escape hatch." Say this: "They locked the wall, so we chipped it out."
- Incorrect outcome: Title "Not quite.". Body: "Every short lane was covered. A chip along the far wall was the way past the pressure." Say this: "They locked the wall, so we chipped it out."

**fc-intercept**
- Trigger: Any unsafe pass (interception)
- What freezes: Forechecker touching the puck
- Camera: `chase-high` replay
- Callouts: The interceptor ringed rose; reach line drawn to the lane
- Correct outcome: Title "Nice read.". Body: "Clean exit: none of the forecheckers could touch it. That is how a breakout turns into a rush the other way." Say this: "That giveaway turned into a chance."
- Incorrect outcome: Title "Not quite.". Body: "That pass went through a forechecker's reach and got picked off. In your own end that is a scoring chance against." Say this: "That giveaway turned into a chance."

## 13. Scoring & mastery signals
- **Round score:** 1.0 for the best option; 0.5 for another safe option (safe but gains less ice); 0 for an unsafe option.
- **Score (0-100):** `round(mean(roundScore) * 100)`, minus `5` per hint used (floor 0). **Accuracy:** correct rounds / rounds played. **Outcome ids:** `round-1`..`round-N`, `success` = round fully correct, `label` = scenario title, `value` = scenarioId.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (in `mistakes[].description`) |
|---|---|---|
| Passed into forechecker reach | forecheck | A forechecker could reach the lane before the puck. |
| Picked a safe but slow option | breakout | A safe pass with more ice was available. |
| Reversed into a pinch | breakout | The reverse lane was covered by a pinching forechecker. |
| Chipped when the wall was open | breakout | The wall was free and simpler. |
| Ignored the neutral-zone setup | neutral-zone-trap | A passive setup gives you the middle, but it gets harder at the blue line. |

**Mastery signals**

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Best option chosen | breakout | +0.20 | Chose the right breakout for the pressure. |
| Best option vs 1-2-2 / 2-1-2 / lock | forecheck | +0.20 | Read the forecheck shape correctly. |
| Safe option but not best | breakout | +0.05 | Safe exit, but left ice on the table. |
| Unsafe pass | forecheck | -0.15 | Passed into a forechecker's reach. |
| Correct pass vs passive setup | neutral-zone-trap | +0.15 | Used the space a passive setup gives. |
| Correct pass after cut-off (FC-08) | backcheck | +0.10 | Understood how pressure changes the exit. |

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
| Decision timeout (levels 3-5) | Card: "Pressure got there first. It does that." then explain. | Round marked failed, mistake tagged `timeout` | No |
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
- **Tap-only:** Options are also four labelled buttons at the bottom ("Boards", "Reverse", "Middle", "Chip"); no drags anywhere.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Accessible native fallback lesson: **`tac-forecheck` (native `term-match` and `visual-id` on forecheck shape diagrams)** (a separate, designed native exercise set; not a port).
- Receivers are numbered and have named labels; the four options are large buttons in tap-only mode.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Decision available | soft stick tap on ice | none | -18 dB |
| Correct call | short rising two-note chime (original) | light success | -14 dB |
| Incorrect call | muted low thud | warning (single) | -16 dB |
| Freeze | crowd ambience ducks 80%, ice hiss | none | -20 dB |
| Pass and hit-the-glass | original stick tap, boards thump for the chip | soft tap | -15 dB |
| Summary | two-note resolve | light success if score >= 60 | -14 dB |

All sounds respect `soundEnabled`; all haptics respect `hapticsEnabled`. Ambient crowd is a looped procedural noise bed, no recorded broadcast audio.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Defensive zone | procedural | original | ~2k tris | lines to scale |
| 11 characters | procedural | original | ~600 tris each | striped/solid jerseys with numbers |
| Puck, reach lines | procedural | original | small | - |
| Audio | synthesized | original-swoond | < 1 MB | - |

- **Overlay styling:** per `docs/astra/ART_DIRECTION.md`: rose = you/act, gold = earned/correct, dim everything not being explained, one focal idea per frame. Rink markings are procedural; NHL and team logos are never used (jerseys are generic stripes/solids with numbers).
- **Addressables bundle:** `sim.hockey.tactics.forecheck-read.v1` , expected about 3 MB compressed (<= 25 MB budget).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply and are not loosened: 60 fps on iPhone 13-class (p5 >= 50), peak Unity memory < 150 MB, cold launch to `ready` < 2 s (4 s first load), bundle <= 25 MB, draw calls <= 150, <= 60k on-screen triangles, <= 15 materials, textures <= 8 MB VRAM, thermal state not above "fair" over a 3-minute session.
Tighter per-sim limits: 11 characters, pursuit evaluation < 0.2 ms per frame; replay recording under 5 MB memory.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus counters:
| key | meaning |
|---|---|
| hintsUsed | total Hint uses |
| decisionLatencyMsAvg | mean time from Decision open to input |
| scenarioIds | comma-joined scenario ids played (no free text) |
| optionChosenCounts | counts per option (boards/reverse/middle/chip) |
| unsafePassCount | number of unsafe passes |

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
- **AC-10 (evaluator):** For every scenario `InterceptionEvaluator` returns `safe` and `advanceFt` identical to the authored options, and exactly one option is best.
- **AC-11 (margin lint):** No scenario option has `|threatDistFt - requiredClearanceFt| < 3.0`, for seeds 0-99.
- **AC-12 (options by level):** At difficulty 1 only two options are enabled; at 2+ four options are enabled.
- **AC-13 (interception replay):** An unsafe pass always ends with a forechecker touching the puck within 1.2 s of the pass.
- **AC-14 (hint):** The hint draws reach lines for all five forecheckers and costs exactly 5 points.

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
| AC-10 | EditMode | InterceptionEvaluator_MatchesAuthoredOptions |
| AC-11 | EditMode | ScenarioLint_Margins |
| AC-12 | PlayMode | OptionsByDifficulty |
| AC-13 | PlayMode | UnsafePass_ResultsInInterception |
| AC-14 | PlayMode | Hint_ReachLinesAndCost |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Are the four breakout options the right set, or should 'wheel' (skate it out) be added? | Claude (content), coach reviewer | No |
| 2 | Forechecker speed 24 ft/s and reaction delay: confirm they look natural in slow motion | Astra | No |
| 3 | Should chip use a distinct glass-bank animation or a simple arc? | Astra | No |
| 4 | Names 'left-wing lock' and '2-1-2': verify wording with a hockey reviewer before locking copy | Claude (content) | No |
