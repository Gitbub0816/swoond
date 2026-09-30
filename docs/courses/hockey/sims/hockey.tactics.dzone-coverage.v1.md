# Who Has the Point? Defensive-Zone Coverage (`hockey.tactics.dzone-coverage.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `hockey.tactics.dzone-coverage.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (definition file optional: this sim is scenario-data driven, see section 11) |
| Authors / date | Swoon'd content team (Claude), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `hockey`. Units and lessons that launch this sim: unit `systems-tactics` lesson `tac-dzone-coverage`.
- CDS row: `docs/courses/hockey/CDS.md` section 12, family `dzone-coverage`.
- Manifest entry: `docs/courses/hockey/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered`, otherwise the lesson shows a native primer first): `dzone-coverage`, `slot`, `zones` (native lessons `tac-slot-screens` and `tac-forecheck` first).

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can see who is open in the defensive zone and say which defender should have picked him up, in man coverage or in a zone.
| conceptId | term | after the sim the learner can... |
|---|---|---|
| dzone-coverage | Defensive-zone coverage | apply man, zone and collapse coverage to find who owns an open attacker |
| pk-formations | Penalty kill formations | see how a box plus one covers the high slot |
| slot | Slot and high-danger area | know that the slot and net-front come first |
| goalie-interference | Goalie interference | notice that the net-front battle is where contact rules matter (context only) |

- **Out of scope:** Individual stick skills, faceoff plays, and goalie positioning. The learner only names the defender who should cover.

## 4. Why Unity (tier justification)
Rubric answers: (1) **Spatial reasoning and movement:** coverage is about where players are in zones and how those zones move with the puck. (2) **Reading a dynamic scene:** the open man appears after a cycle; the learner has to see him move. (3) **Camera perspective:** top-down shows zones and assignments; the broadcast view hides the empty slot. Closest native types: `hotspot-tap` (tap a zone on a diagram) and `term-match` (name the coverage). Those teach the labels and zone map (used in `tac-dzone-coverage`'s primer), but not the cause of a breakdown, which only appears when players move.

## 5. Player fantasy & core loop
**Fantasy:** You are the assistant coach watching the video and pointing at the guy who lost his man.

1. **Prompt:** "Somebody's open. Whose fault?"
2. **Playing:** top-down replay of an offensive-zone cycle in our defensive end (5 s) with a coverage label (man, zone or collapse).
3. **One decisive interaction:** at the freeze, tap the defender who should have covered the open attacker.
4. **Execute:** a short replay shows the correct defender rotating and closing the lane (or the goal if you chose wrong).
5. **Freeze / explain:** zone rectangles or man-assignment lines appear, the open attacker glows, the owner is ringed gold; card explains.
6. **Say this:** e.g. "The center left the slot, so he was wide open."

Session target: about 3 minutes, 3 rounds by default (`configuration.rounds`), drawn from the scenario pool in section 11.

## 6. Scene & entities
- **Environment:** `hockey_rink_defensive_zone (shared with the forecheck sim)`. **Camera presets:** `top-down` (default), `broadcast-side` (replay), `chase-high` optional.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| D_S, D_W | Character (playerDefense) | strong-side and weak-side defensemen | positions per scenario |
| C | Character (playerCenter) | center; owns the slot (Z3) | - |
| W_S, W_W | Character (playerWing) | half-wall and point coverage | - |
| A_P, A_H, A_S, A_N, A_W | Character (opponent) | attackers: puck carrier, half-wall, point, net-front, weak-side | striped jerseys |
| puck | Ball | the puck | moves in cycle |
| zoneRects | Zone x5 | zone map overlay | Z1-Z5 as data |
| assignLines | Path + Highlight | man assignments | dashed lines |
| decisionBar | DecisionPoint + 5 Targets | tap a defender | 44 pt targets |

- **Reused primitives:** Character, Ball, Zone, Path, CameraRig, TouchController, DecisionPoint, Target, Hint, Explanation, Objective, Score, Replay, SlowMotion, Highlight, Rng, ScenarioSet.
- **Diagram (initial layout):**

```
  goal line x=-89                                     blue line x=-25
   |  Z1 strong low (D_S)  |  Z4 strong wall/point (W_S)
   |  Z3 slot (C)          |
   |  Z2 weak low (D_W)    |  Z5 weak point (W_W)
   coverage label: ZONE | MAN | COLLAPSE | BOX+1
```

### Game Kit additions requested
| Addition | Why it is needed | Reuse plan |
|---|---|---|
| `Swoond.Sports.Hockey` `Rink`, `Puck`, `FormationSet` | Shared | All hockey sims |
| `CoverageModel` (zone map + man assignment tables + collapse/box rules as data) | Coverage responsibilities are data, not code | Football coverage sim, basketball defense |
| `ResponsibilityOverlay` (zone rectangles and assignment lines drawn on the surface) | Explain visuals | Football coverage, soccer marking |

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Defender target | tap a defender (circle radius >= 44 pt) | 44 pt | rose ring; soft tap haptic |
| Coverage label chip | tap to see the zone map (Hint) | 44 pt | shows zones or assignments, costs 5 points |
| Replay chip | tap after explain | 44 pt | replays at 0.5x |

- **Tap-only alternative scheme:** Tap-only; defenders can also be picked from a list of five named buttons ("Strong D", "Weak D", "Center", "Strong wing", "Weak wing").
- **Orientation / safe area:** portrait. All buttons live inside `runtime.safeAreaInsets`; the decision bar sits 28-34 pt above the bottom inset.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation (`requestExit` with `user-quit`; native shows "Leave game?"), XP/streak UI, lesson chrome.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate contract, simulationId, configuration; build rink and characters from code; load scenario set | `ready` sent -> Intro (invalid config -> `error CONFIG_INVALID`) | `ready` |
| Intro | Ready acknowledged | One-line objective card (Display S serif), 1.5 s; camera settles on the opening preset. Shows the five-zone map. | Auto -> Playing (first round) | `progress` 0.0 |
| Playing | Round starts | Top-down cycle plays at 0.7x; a label says ZONE / MAN / COLLAPSE / BOX+1; the puck moves along the boards while attackers rotate. | Decision point reached -> Decision | `progress` (<= 4 per second) |
| Decision | Decision point reached | Sim freezes when an attacker becomes open in a dangerous area (slot, back door or point); five defender targets appear; timer bar at difficulty >= 4. | Input or time limit -> Executing | none |
| Executing | Decision recorded | Replay of the next 2 s with the chosen defender rotating to cover (or not), ending in a shot chance label. | Outcome resolved -> Freeze | none |
| Freeze | Outcome resolved | Freeze at the shot; zone rectangles or assignment lines fade in; the open attacker glows; the correct owner is ringed gold; a rose ring marks who was asked if wrong. | 1.2 s (0.4 s with reduced motion) -> Explain | none |
| Explain | Freeze complete | Copy card slides up; a "Replay with correct cover" chip is available. Tap "Next play" (or auto after 12 s at difficulty 4-5) advances. | Rounds left -> Playing; else -> Summary | `checkpoint` (round id) |
| Summary | All rounds done | Score card: score, accuracy, per-round chips, one "say this" line from the weakest concept; native shows XP | Continue tapped -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` (Score.Build(true)) | `result` then `requestExit` (`completed`) | `result`, `requestExit` |
| Paused | `pause` received | Freeze sim time, timers, audio; dim overlay | `resume` -> previous state | none |
| Aborted | `abort` received or fatal error | Stop immediately; Score.Build(false) with partial outcomes | `result` (aborted=true) then `requestExit` | `result`, `requestExit` |

Pause/resume: on `pause` the state machine freezes simulation time, timers (including decision windows), audio and haptic loops; `resume` continues the same frame. Abort: emit `result` with `aborted=true`, `abortReason`, partial `outcomes`, `xpEarned: 0`, then `requestExit`.

## 9. Difficulty levels 1-5
| Parameter | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Scheme in scenario | zone only | zone, man | +collapse | +box+1 | all, with switches |
| Zone map visible during play | yes | yes | no | no | no |
| Number of attackers shown | 4 | 5 | 5 | 5 | 5 |
| Assignment lines visible (man) | yes | yes | no | no | no |
| Decision window (ms) | 0 | 0 | 0 | 6000 | 4000 |
| Hints | 2 | 1 | 1 | 0 | 0 |
| Play speed (x) | 0.6 | 0.7 | 0.8 | 1.0 | 1.0 |

Level 1 is passable by a true beginner: the zone map is always visible. **Default for `tac-dzone-coverage` is 2.**

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
        "dzone-starter",
        "dzone-advanced"
      ]
    },
    "rounds": {
      "type": "integer",
      "minimum": 3,
      "maximum": 6,
      "default": 3,
      "description": "Number of rounds in the session."
    },
    "scheme": {
      "type": "string",
      "enum": [
        "zone",
        "man",
        "collapse",
        "box-plus-one",
        "mixed"
      ],
      "default": "mixed"
    },
    "showZoneMap": {
      "type": "boolean",
      "default": true
    },
    "showAssignments": {
      "type": "boolean",
      "default": true
    },
    "decisionWindowMs": {
      "type": "integer",
      "minimum": 0,
      "maximum": 8000,
      "default": 0
    },
    "playbackSpeed": {
      "type": "number",
      "minimum": 0.5,
      "maximum": 1.0,
      "default": 0.7
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
  "seed": 9,
  "scenarioSetId": "dzone-starter",
  "rounds": 3,
  "scheme": "zone",
  "showZoneMap": true,
  "showAssignments": true,
  "decisionWindowMs": 0,
  "playbackSpeed": 0.7
}
```

## 11. Scenario data set
Scenarios give all player positions at the freeze, the scheme, the open attacker and the responsible defender. The teaching model is simplified on purpose: a five-zone map for zone coverage, assignment tables for man, and a nearest-defender-to-net-front rule for collapse. Coordinates: rink feet, defensive zone, goal line at x=-89, +y = top of screen. Zone map: Z1 strong low x[-100,-70] y[10,42.5] (D_S); Z2 weak low x[-100,-70] y[-42.5,-10] (D_W); Z3 slot x[-89,-55] y[-10,10] (C); Z4 strong wall/point x[-70,-45] y[10,42.5] (W_S); Z5 weak point x[-70,-45] y[-42.5,-10] (W_W). **Pool size N = 10** (rounds x 3 minimum is 9). Scenarios ship as `dzone-starter.json / dzone-advanced.json` inside the sim's Addressables bundle (JSON, array of scenario objects). Selection is deterministic per `seed`: shuffle with `Rng(seed)`, filter by the difficulty tags in section 9, take `rounds` scenarios, never repeating a `teaches` concept back-to-back if avoidable.

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| DZ-01 | Zone: weak-side attacker in Z2 while D_W drifted to the middle | D_W | dzone-coverage | zone |
| DZ-02 | Zone: attacker in the slot (Z3); the center got pulled to the corner | C | dzone-coverage | zone |
| DZ-03 | Zone: attacker on the strong-side point (Z4); W_S watched the puck | W_S | dzone-coverage | zone |
| DZ-04 | Man: A_S (assigned to W_W) is at the point; W_W stopped following | W_W | dzone-coverage | man |
| DZ-05 | Man: cycle switch - two defenders crossed; the nearest defender must take the open man | the nearest defender | dzone-coverage | man, switch |
| DZ-06 | Collapse: puck low; attacker at the back post while everyone is on the puck | D_W (net-front box-out) | slot | collapse |
| DZ-07 | Box+1 (penalty kill): high-slot attacker uncovered; the +1 forward must step up | W_S (the +1) | pk-formations | box+1 |
| DZ-08 | Zone overload: two attackers low strong side; the center must support low | C | dzone-coverage | zone, overload |
| DZ-09 | Ball-watching: attacker sneaks behind D_W while he looks at the puck | D_W | dzone-coverage | zone |
| DZ-10 | Point rotation: strong-side point man rotates down; the point is empty | W_S (hand off to W_W) | dzone-coverage | zone, rotation |

Fully written scenarios (canonical data format; the rest follow the same shape):

**DZ-01 `weak-side-drift` (tags: zone)**

```json
{
  "scenarioId": "DZ-01",
  "title": "Back-door on the weak side",
  "scheme": "zone",
  "puck": {
    "carrier": "A_P",
    "x": -93,
    "y": 30
  },
  "attackers": {
    "A_P": {
      "x": -93,
      "y": 30
    },
    "A_H": {
      "x": -60,
      "y": 30
    },
    "A_S": {
      "x": -45,
      "y": 12
    },
    "A_N": {
      "x": -82,
      "y": 4
    },
    "A_W": {
      "x": -80,
      "y": -24
    }
  },
  "defenders": {
    "D_S": {
      "x": -84,
      "y": 22
    },
    "D_W": {
      "x": -80,
      "y": -2
    },
    "C": {
      "x": -70,
      "y": 0
    },
    "W_S": {
      "x": -58,
      "y": 26
    },
    "W_W": {
      "x": -58,
      "y": -26
    }
  },
  "openAttacker": "A_W",
  "correctDefender": "D_W",
  "rule": "Zone: the weak-side low zone (Z2) belongs to D_W; he drifted to the middle watching the puck.",
  "copyKey": "dz-zone",
  "teaches": "dzone-coverage",
  "zoneOfOpenAttacker": "Z2"
}
```

**DZ-02 `empty-slot` (tags: zone)**

```json
{
  "scenarioId": "DZ-02",
  "title": "Nobody has the slot",
  "scheme": "zone",
  "puck": {
    "carrier": "A_H",
    "x": -58,
    "y": 34
  },
  "attackers": {
    "A_P": {
      "x": -93,
      "y": 30
    },
    "A_H": {
      "x": -58,
      "y": 34
    },
    "A_S": {
      "x": -50,
      "y": -8
    },
    "A_N": {
      "x": -72,
      "y": 4
    },
    "A_W": {
      "x": -80,
      "y": -24
    }
  },
  "defenders": {
    "D_S": {
      "x": -84,
      "y": 22
    },
    "D_W": {
      "x": -84,
      "y": -20
    },
    "C": {
      "x": -82,
      "y": 20
    },
    "W_S": {
      "x": -58,
      "y": 26
    },
    "W_W": {
      "x": -58,
      "y": -26
    }
  },
  "openAttacker": "A_N",
  "correctDefender": "C",
  "rule": "Zone: the slot (Z3) belongs to the center; he was pulled down to the corner and left the middle empty.",
  "copyKey": "dz-zone",
  "teaches": "dzone-coverage",
  "zoneOfOpenAttacker": "Z3"
}
```

**DZ-04 `follow-your-man` (tags: man)**

```json
{
  "scenarioId": "DZ-04",
  "title": "Man coverage: he is your guy",
  "scheme": "man",
  "puck": {
    "carrier": "A_P",
    "x": -93,
    "y": 30
  },
  "attackers": {
    "A_P": {
      "x": -93,
      "y": 30
    },
    "A_H": {
      "x": -60,
      "y": 30
    },
    "A_S": {
      "x": -50,
      "y": -14
    },
    "A_N": {
      "x": -82,
      "y": 4
    },
    "A_W": {
      "x": -80,
      "y": -24
    }
  },
  "defenders": {
    "D_S": {
      "x": -84,
      "y": 22
    },
    "D_W": {
      "x": -84,
      "y": -20
    },
    "C": {
      "x": -70,
      "y": 0
    },
    "W_S": {
      "x": -58,
      "y": 26
    },
    "W_W": {
      "x": -58,
      "y": -26
    }
  },
  "openAttacker": "A_S",
  "correctDefender": "W_W",
  "rule": "Man: each defender owns one attacker wherever he goes; A_S is W_W's man, so W_W must follow him to the point.",
  "copyKey": "dz-man",
  "teaches": "dzone-coverage",
  "assignments": {
    "D_S": "A_P",
    "D_W": "A_W",
    "C": "A_N",
    "W_S": "A_H",
    "W_W": "A_S"
  }
}
```

Remaining scenarios follow the same shape. Lint: for zone scenarios the open attacker lies inside exactly one zone rectangle whose owner equals `correctDefender` (>= 3 ft from any edge); for man scenarios `assignments` is complete and the open attacker is the assignment of `correctDefender`; for switch/collapse/box+1 the `rule` field names the rule used. Positions vary +/-2 ft with the seed without breaking the lint (checked for seeds 0-99).

## 12. Freeze / explain moments
Copy is keyed by `copyKey`; every string satisfies title <= 6 words, body <= 45 words.

**dz-zone**
- Trigger: Zone scenarios (DZ-01, 02, 03, 08, 09, 10)
- What freezes: The shot from the open attacker
- Camera: `top-down` then `broadcast-side`
- Callouts: Zone rectangles fade in; the open attacker glows; the owner gets a gold ring; the empty zone hatched
- Correct outcome: Title "Nice read.". Body: "In a zone you own an area, not a man. The attacker was in his area, so he was the one to cover. If everyone drifts to the puck, someone shoots alone." Say this: "He left his zone and the slot was wide open."
- Incorrect outcome: Title "Not quite.". Body: "That defender's zone was elsewhere. In a zone each player owns an area: find which one the open attacker stood in, and that player owned him." Say this: "He left his zone and the slot was wide open."

**dz-man**
- Trigger: Man scenarios (DZ-04, 05)
- What freezes: The open attacker's shot
- Camera: `top-down`
- Callouts: Dashed assignment lines; the broken line highlighted rose; the correct defender ringed gold
- Correct outcome: Title "Nice read.". Body: "In man coverage your guy is your job, wherever he goes. When he slid to the point, his defender had to follow. Switches only happen when you talk about them." Say this: "That's his man. He has to follow him."
- Incorrect outcome: Title "Not quite.". Body: "Each defender owns one attacker in man coverage. Follow the dashed line: the open man was somebody's guy." Say this: "That's his man. He has to follow him."

**dz-collapse**
- Trigger: Collapse scenario (DZ-06)
- What freezes: Rebound in front
- Camera: `top-down`
- Callouts: Net-front zone shaded; the attacker at the back post; the defender's box-out arrow
- Correct outcome: Title "Nice read.". Body: "When the puck is low the defense collapses toward the net and the net-front comes first. Boxing out the back-post attacker stops the rebound. Shots from the point are the trade." Say this: "They collapsed on the net and boxed him out."
- Incorrect outcome: Title "Not quite.". Body: "Someone has to box out the net-front. Collapsing means protect the slot and the net first, and give up the outside shot." Say this: "They collapsed on the net and boxed him out."

**dz-box**
- Trigger: Box+1 scenario (DZ-07)
- What freezes: The high-slot shot
- Camera: `top-down`
- Callouts: Box corners marked; the +1 forward ringed
- Correct outcome: Title "Nice read.". Body: "The box protects the slot and the extra forward, the plus-one, steps up to take the high man. Otherwise the middle of the ice is a gift." Say this: "The plus-one should have taken the high man."
- Incorrect outcome: Title "Not quite.". Body: "A box has four killers. The fifth player, the plus-one, has to step out and cover the high slot." Say this: "The plus-one should have taken the high man."

**dz-wrong-shot**
- Trigger: Shot chance after a wrong pick
- What freezes: Shot leaving the stick
- Camera: `broadcast-side`
- Callouts: Open attacker in gold; the goalie's angle drawn
- Correct outcome: Title "Nice read.". Body: "Good cover: the shot never came clean. That is what coverage is for: nobody gets a free look at the slot." Say this: "He was wide open in the slot."
- Incorrect outcome: Title "Not quite.". Body: "Wrong defender, wide-open shot. The right one was ringed in gold. Try the zone map hint next time." Say this: "He was wide open in the slot."

## 13. Scoring & mastery signals
- **Round score:** 1.0 for the responsible defender; 0.5 for a defender who could also have covered in the scenario's `acceptableDefenders` list (used in switch and overload); 0 otherwise.
- **Score (0-100):** `round(mean(roundScore) * 100)`, minus `5` per hint used (floor 0). **Accuracy:** correct rounds / rounds played. **Outcome ids:** `round-1`..`round-N`, `success` = round fully correct, `label` = scenario title, `value` = scenarioId.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (in `mistakes[].description`) |
|---|---|---|
| Blamed the wrong zone owner | dzone-coverage | The open attacker was in another defender's zone. |
| Missed the man assignment | dzone-coverage | In man coverage each defender follows his man. |
| Ignored the net-front | slot | Net-front and slot come first when the puck is low. |
| Did not step up the plus-one | pk-formations | The extra forward in a box covers the high slot. |

**Mastery signals**

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct owner in a zone | dzone-coverage | +0.20 | Named the defender who owned the zone. |
| Correct man assignment | dzone-coverage | +0.20 | Followed the man assignment. |
| Correct collapse pick | slot | +0.20 | Protected the net-front first. |
| Correct plus-one pick | pk-formations | +0.20 | Knew the plus-one covers the high slot. |
| Wrong defender | dzone-coverage | -0.15 | Misidentified who owned the open attacker. |

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
| Decision timeout (levels 3-5) | Card: "The shot went in while you were deciding. Coaches hate that too." then explain. | Round marked failed, mistake tagged `timeout` | No |
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
- **Tap-only:** Tap-only; defenders can also be picked from a list of five named buttons ("Strong D", "Weak D", "Center", "Strong wing", "Weak wing").
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Accessible native fallback lesson: **`tac-dzone-coverage` primer set: native `hotspot-tap` on the zone map and `term-match` for coverage names** (a separate, designed native exercise set; not a port).
- Zones are labelled with text (Z1-Z5 plus the position name) and hatch patterns, not color only.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Decision available | soft stick tap on ice | none | -18 dB |
| Correct call | short rising two-note chime (original) | light success | -14 dB |
| Incorrect call | muted low thud | warning (single) | -16 dB |
| Freeze | crowd ambience ducks 80%, ice hiss | none | -20 dB |
| Shot | original stick slap | warning (single) if the shot is scored | -15 dB |
| Summary | two-note resolve | light success if score >= 60 | -14 dB |

All sounds respect `soundEnabled`; all haptics respect `hapticsEnabled`. Ambient crowd is a looped procedural noise bed, no recorded broadcast audio.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Defensive zone | procedural | original | ~2k tris | - |
| 10 characters | procedural | original | ~600 tris each | striped/solid, numbers |
| Zone rectangles, assignment lines | procedural | original | small | - |
| Audio | synthesized | original-swoond | < 1 MB | - |

- **Overlay styling:** per `docs/astra/ART_DIRECTION.md`: rose = you/act, gold = earned/correct, dim everything not being explained, one focal idea per frame. Rink markings are procedural; NHL and team logos are never used (jerseys are generic stripes/solids with numbers).
- **Addressables bundle:** `sim.hockey.tactics.dzone-coverage.v1` , expected about 3 MB compressed (<= 25 MB budget).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply and are not loosened: 60 fps on iPhone 13-class (p5 >= 50), peak Unity memory < 150 MB, cold launch to `ready` < 2 s (4 s first load), bundle <= 25 MB, draw calls <= 150, <= 60k on-screen triangles, <= 15 materials, textures <= 8 MB VRAM, thermal state not above "fair" over a 3-minute session.
Tighter per-sim limits: Zone overlays use one mesh per zone with a shared material.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus counters:
| key | meaning |
|---|---|
| hintsUsed | total Hint uses |
| decisionLatencyMsAvg | mean time from Decision open to input |
| scenarioIds | comma-joined scenario ids played (no free text) |
| schemeCounts | counts of zone/man/collapse/box scenarios played |
| hintZoneMapViews | times the zone map was viewed |

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
- **AC-10 (zone lint):** For every zone scenario the open attacker is inside exactly one zone rectangle, at least 3 ft from any edge, and its owner equals `correctDefender`.
- **AC-11 (man lint):** For every man scenario `assignments` covers all five defenders and `assignments[correctDefender] == openAttacker`.
- **AC-12 (schemes by level):** Difficulty 1 draws only zone scenarios; difficulty 3 includes collapse; difficulty 4 includes box+1.
- **AC-13 (jitter):** For seeds 0-99 the lint in AC-10 and AC-11 still passes.
- **AC-14 (zone map hint):** The hint shows all five zones and costs exactly 5 points.

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
| AC-10 | EditMode | ZoneScenarios_Lint |
| AC-11 | EditMode | ManScenarios_Lint |
| AC-12 | PlayMode | SchemesByDifficulty |
| AC-13 | EditMode | Scenarios_StableUnderJitter |
| AC-14 | PlayMode | Hint_ZoneMapAndCost |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | The five-zone map is a teaching simplification; is that acceptable, or should Astra draw a more realistic 'strong-side D' rotation? | Claude (content), coach reviewer | No |
| 2 | Collapse rule: 'nearest defender to net-front' vs a named role; confirm wording | Claude (content) | No |
| 3 | Should replay show a goal when the wrong defender is picked? | Product | No |
| 4 | Switch scenario needs `acceptableDefenders`: OK to author with two acceptable names? | Claude / Astra | No |
