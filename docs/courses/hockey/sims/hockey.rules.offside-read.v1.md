# Be the Linesman: Offside Read (`hockey.rules.offside-read.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `hockey.rules.offside-read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (definition file optional: this sim is scenario-data driven, see section 11) |
| Authors / date | Swoon'd content team (Claude), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `hockey`. Units and lessons that launch this sim: unit `rules-of-play` lesson `rules-offside-call`.
- CDS row: `docs/courses/hockey/CDS.md` section 12, family `offside-read`.
- Manifest entry: `docs/courses/hockey/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered`, otherwise the lesson shows a native primer first): `offside` primer (native lesson `rules-offside-line`), `zones`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can watch a zone entry at full speed and call it: offside, onside, or play on, and say why in one sentence.
| conceptId | term | after the sim the learner can... |
|---|---|---|
| offside | Offside | call a normal entry correctly by looking at skates versus the puck and the blue line's leading edge |
| delayed-offside | Delayed offside and tag-up | tell when to keep play alive and when the missed tag-up should end it |
| coaches-challenge | Coach's challenge and video review | judge an entry from the blue-line camera the way a reviewer does |
| zones | Offensive, neutral, defensive zone | know that the zone is decided by where the puck fully is, not where the players think they are |

- **Out of scope:** Goalie interference, icing and the details of challenge budgets (timeouts). Only the offside entry rule and delayed offside are taught.

## 4. Why Unity (tier justification)
Rubric answers: (1) **Movement in space over time:** offside is defined by the relationship of two moving skates and a moving puck to a line, at an instant. (2) **Camera perspective is the concept:** from the broadcast angle the entry looks fine; from the blue-line camera you can see the skates are over. Switching camera at the freeze is the lesson. (3) **Timing in a scene:** the learner must decide at speed, as a linesman does. The closest native type, `binary-call` on a still diagram, can show the rule but cannot show the instant, the motion or the perspective change, and the misconception ("he was not involved in the play") only breaks when the learner sees the frozen moment. A `visual-id` still would let the learner guess from a picture; the sim makes them commit before the reveal.

## 5. Player fantasy & core loop
**Fantasy:** You are the linesman at the blue line with one hand on the whistle.

1. **Prompt:** a one-line card, e.g. "Watch the entry. Whistle or play on?"
2. **Playing:** a rush develops in the neutral zone from the broadcast-side camera; time slows to 0.5x as the puck nears the blue line.
3. **One decisive interaction:** tap **Whistle** (offside) or **Play on**; at difficulty 3+ a third button **Arm up (delayed)** appears.
4. **Execute:** the play resolves (whistle blows, or the attack continues).
5. **Freeze / explain:** the exact frame freezes; camera cuts to the blue-line camera; the leading edge glows gold, skates and puck are outlined; a copy card explains.
6. **Say this:** one line you could say to a fan, e.g. "Both skates were over before the puck."

Session target: about 3 minutes, 3 rounds by default (`configuration.rounds`), drawn from the scenario pool in section 11.

## 6. Scene & entities
- **Environment:** `hockey_rink_zone_entry (new registry key: neutral zone plus offensive zone, blue line drawn to scale with a visible 12-inch width)`. **Camera presets:** `broadcast-side` (play), `blueline-cam` (low, along the blue line, freeze), `top-down` (explain overview), `first-person` not used.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| rink | Swoond.Sports.Hockey.Rink (new module) | play surface | 200x85 ft, corners radius 28 ft, blue line center at x=+/-25 ft from center |
| blueLine | Zone (thin rectangle) | the line under judgment | x in [24.5, 25.5] ft; leading edge x=25.5 |
| offZone | Zone | offensive zone | x > 25.5 ft |
| puck | Ball | the puck | diameter 0.25 ft, height 0.083 ft; speed 40-90 ft/s |
| carrier | Character (role: attacker) | puck carrier or passer | skating speed 22-30 ft/s; has Feet (left/right blade spans) |
| att_1..att_3 | Character (role: attacker) | teammates entering | jersey solid rose-tinted neutral; numbers 11, 17, 19 |
| def_1..def_2 | Character (role: defender) | retreating defenders | striped jerseys; numbers 4, 6 |
| decisionBar | DecisionPoint + Target x2-3 | Whistle / Play on / Arm up | Targets are native-styled Unity UI buttons, 56 pt tall |
| entryProbe | Objective (new subtype `LineCrossingObjective`) | evaluates rule at each frame | reports firstSkateTime, bothSkatesTime, puckFullyOverTime |
| explainCard | Explanation | freeze copy | Title <= 6 words, body <= 45 words |

- **Reused primitives:** Ball, Character, Zone, Path, CameraRig, TouchController, DecisionPoint, Hint, Explanation, Objective, Score, Replay, SlowMotion, Highlight, ThemeService, AccessibilityService, Rng, ScenarioSet.
- **Diagram (initial layout):**

```
            NEUTRAL ZONE           | blue line |     OFFENSIVE ZONE
  x=-25 ... 0 ... 24.5                | 24.5-25.5 |  25.5 ... 89 (goal line)
        [D1]      ( )>>> puck (x=18)  |           |
     [W1] -> (both skates near line)  |           |     [def_1]   [def_2]
      [C] carrier                      |           |
   viewer: broadcast-side; on freeze -> blueline-cam looking along the line
```

### Game Kit additions requested
| Addition | Why it is needed | Reuse plan |
|---|---|---|
| `Swoond.Sports.Hockey` module: `Rink` (dimensions, zones, lines as data), `Puck` (a Ball preset), `SkaterMotion` | No hockey module exists; every hockey sim needs the rink geometry | All six hockey sims |
| `Character.Feet` (left/right blade spans in world x/z) and `FootContact` events | Offside is decided by blade positions, not the body | Icing (dot line), line change (boards), any line-based rule in other sports (tennis line calls) |
| `LineCrossingObjective` (Objective subtype: reports per-entity first/complete crossing times against a Zone edge) | Turns the rule into a testable time comparison | Icing (goal line, dot line), soccer offside later |
| `CameraRig` preset `blueline-cam` (low, along a line, FOV 40) | Perspective is the concept | Any line-call sim |

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Whistle | tap button, lower-left | 56 pt tall, min 44 pt | button depresses 80 ms; whistle sfx; light haptic on confirm |
| Play on | tap button, lower-right | 56 pt tall | same |
| Arm up (delayed) | tap button, lower-center (difficulty >= 3) | 56 pt tall | raised-arm icon on the linesman avatar |
| Hint | tap lightbulb top-right | 44 pt | shows the leading-edge line before the entry (costs 5 points) |
| Skip explain wait | tap anywhere on the card after 1.5 s | full card | fast-forward text |

- **Tap-only alternative scheme:** All inputs are already taps; no drags or holds anywhere. A "Slow play" toggle in the summary and pre-round card sets playback to 0.4x at any difficulty.
- **Orientation / safe area:** portrait. All buttons live inside `runtime.safeAreaInsets`; the decision bar sits 28-34 pt above the bottom inset.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation (`requestExit` with `user-quit`; native shows "Leave game?"), XP/streak UI, lesson chrome.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate contract, simulationId, configuration; build rink and characters from code; load scenario set | `ready` sent -> Intro (invalid config -> `error CONFIG_INVALID`) | `ready` |
| Intro | Ready acknowledged | One-line objective card (Display S serif), 1.5 s; camera settles on the opening preset. Shows a static blue line diagram with the words "leading edge". | Auto -> Playing (first round) | `progress` 0.0 |
| Playing | Round starts | Broadcast-side camera follows the rush; SlowMotion ramps to 0.5x over 0.6 s before the puck reaches x=+18 ft; scenario timeline is deterministic. | Decision point reached -> Decision | `progress` (<= 4 per second) |
| Decision | Decision point reached | At the scenario's decision instant (just before the puck's first crossing, or at the touch for tag-up scenarios) the sim pauses and shows 2-3 buttons; timer bar only at difficulty >= 3. | Input or time limit -> Executing | none |
| Executing | Decision recorded | Resume at 0.5x: correct-call plays out (whistle blows and players glide to a stop, or play on continues for 1.5 s). | Outcome resolved -> Freeze | none |
| Freeze | Outcome resolved | At the frame of interest (both skates over / puck fully over) time freezes; camera cuts to `blueline-cam`; leading edge glows gold; skates and puck outlined (rose ring per skate over, gold check on puck when fully over). | 1.2 s (0.4 s with reduced motion) -> Explain | none |
| Explain | Freeze complete | Copy card from section 12 slides up (250 ms); a "See it again" replay chip plays the entry at 0.25x from the blueline-cam. Tap "Next play" (or auto after 12 s at difficulty 4-5) advances. | Rounds left -> Playing; else -> Summary | `checkpoint` (round id) |
| Summary | All rounds done | Score card: score, accuracy, per-round chips, one "say this" line from the weakest concept; native shows XP | Continue tapped -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` (Score.Build(true)) | `result` then `requestExit` (`completed`) | `result`, `requestExit` |
| Paused | `pause` received | Freeze sim time, timers, audio; dim overlay | `resume` -> previous state | none |
| Aborted | `abort` received or fatal error | Stop immediately; Score.Build(false) with partial outcomes | `result` (aborted=true) then `requestExit` | `result`, `requestExit` |

Pause/resume: on `pause` the state machine freezes simulation time, timers (including decision windows), audio and haptic loops; `resume` continues the same frame. Abort: emit `result` with `aborted=true`, `abortReason`, partial `outcomes`, `xpEarned: 0`, then `requestExit`.

## 9. Difficulty levels 1-5
| Parameter | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Playback speed (x) | 0.4 | 0.5 | 0.6 | 0.7 | 0.8 |
| Decision window (ms, 0 = untimed) | 0 | 0 | 4500 | 3000 | 2000 |
| Buttons | 2 | 2 | 3 | 3 | 3 |
| Attackers on screen | 2 | 3 | 3 | 3 | 4 |
| Leading-edge overlay before decision | yes | yes | no | no | no |
| Hints available | 2 | 1 | 1 | 0 | 0 |
| Scenario pool tags | `basic` | `basic`,`skate-line` | +`delayed` | +`review` | all tags |
| Auto-advance explain | never | never | never | 12 s | 12 s |

Level 1 is passable by a true beginner using the overlay and two hints. **Default level for lesson `rules-offside-call` is 2**; `rules-delayed-offside` launches at 3.

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
        "offside-starter",
        "offside-advanced"
      ]
    },
    "rounds": {
      "type": "integer",
      "minimum": 3,
      "maximum": 6,
      "default": 3,
      "description": "Number of rounds in the session."
    },
    "showLeadingEdge": {
      "type": "boolean",
      "default": true,
      "description": "Overlay the leading edge before the decision. Forced by difficulty when omitted."
    },
    "allowDelayed": {
      "type": "boolean",
      "default": false,
      "description": "Include delayed-offside scenarios and the third button."
    },
    "decisionWindowMs": {
      "type": "integer",
      "minimum": 0,
      "maximum": 8000,
      "default": 0,
      "description": "0 = untimed."
    },
    "playbackSpeed": {
      "type": "number",
      "minimum": 0.3,
      "maximum": 1.0,
      "default": 0.5
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
  "seed": 42,
  "scenarioSetId": "offside-starter",
  "rounds": 3,
  "showLeadingEdge": true,
  "allowDelayed": false,
  "decisionWindowMs": 0,
  "playbackSpeed": 0.5
}
```

## 11. Scenario data set
Scenarios are hand-authored timelines (positions sampled at 60 Hz are generated from keyframes, so files stay small). Coordinates are rink feet: origin center ice, +x toward the attacked goal, y across (+y = top of screen in the broadcast camera). **Pool size N = 12** (rounds x 3 minimum is 9). Scenarios ship as `offside-starter.json / offside-advanced.json` inside the sim's Addressables bundle (JSON, array of scenario objects). Selection is deterministic per `seed`: shuffle with `Rng(seed)`, filter by the difficulty tags in section 9, take `rounds` scenarios, never repeating a `teaches` concept back-to-back if avoidable.

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| OFF-01 | 3-on-2 carry-in; carrier and puck enter together, puck stays ahead of his skates | Play on | offside | basic |
| OFF-02 | Defense pass from x=10 to a winger whose two skates are already over the line | Whistle | offside | basic |
| OFF-03 | Winger's front skate over, back skate still touching the line when the puck crosses | Play on | offside | basic, skate-line |
| OFF-04 | Puck is shot into the zone; all attackers are behind the line at release, then chase | Play on | offside | basic |
| OFF-05 | Winger early, but the defenseman is carrying the puck out; linesman arm goes up | Arm up (delayed) | delayed-offside | delayed |
| OFF-06 | Same winger fails to tag up and touches the puck in the zone | Whistle at the touch | delayed-offside | delayed |
| OFF-07 | Puck is cleared out of the zone completely, then re-enters with teammates who were in the zone earlier | Play on (new entry) | zones | delayed |
| OFF-08 | Airborne skate: front skate over the line in the air, back skate over, neither touching the line | Whistle | offside | skate-line |
| OFF-09 | Puck half over the line when an attacker's skates are completely over | Whistle | offside | skate-line |
| OFF-10 | Third attacker 30 ft from the puck is over early; the play goes to another teammate | Whistle (involvement does not matter) | offside | basic |
| OFF-11 | Goal scored 10 s after an entry; coach challenges; watch the entry from the blueline-cam | Offside, no goal | coaches-challenge | review |
| OFF-12 | Goal scored after a clean entry; the challenge fails | Good goal | coaches-challenge | review |

Fully written scenarios (canonical data format; the rest follow the same shape):

**OFF-02 `d-pass-early-winger` (tags: basic)**

```json
{
  "scenarioId": "OFF-02",
  "title": "Early winger",
  "teaches": [
    "offside"
  ],
  "correct": "whistle",
  "keyframes": {
    "puck": [
      {
        "t": 0.0,
        "x": 10.0,
        "y": -6.0
      },
      {
        "t": 1.0,
        "x": 21.0,
        "y": -8.0
      },
      {
        "t": 1.42,
        "x": 25.7,
        "y": -9.0
      }
    ],
    "att_1": {
      "skatesAt": [
        {
          "t": 1.1,
          "L": {
            "trail": 25.9,
            "lead": 26.9
          },
          "R": {
            "trail": 26.6,
            "lead": 27.6
          },
          "y": -9.5
        }
      ]
    },
    "def_1": {
      "x": 38.0,
      "y": -4.0
    }
  },
  "events": {
    "bothSkatesOverAt": 1.1,
    "puckFullyOverAt": 1.42
  },
  "decisionAt": 1.15,
  "freezeAt": 1.42,
  "copyKey": "offside-correct-whistle"
}
```

**OFF-03 `skate-on-the-line` (tags: basic, skate-line)**

```json
{
  "scenarioId": "OFF-03",
  "title": "Toe on the line",
  "teaches": [
    "offside"
  ],
  "correct": "play-on",
  "keyframes": {
    "puck": [
      {
        "t": 0.0,
        "x": 8.0,
        "y": 5.0
      },
      {
        "t": 1.2,
        "x": 22.0,
        "y": 6.0
      },
      {
        "t": 1.55,
        "x": 25.8,
        "y": 6.5
      }
    ],
    "att_1": {
      "skatesAt": [
        {
          "t": 1.45,
          "L": {
            "trail": 24.9,
            "lead": 25.9
          },
          "R": {
            "trail": 26.4,
            "lead": 27.4
          },
          "y": 7.0
        }
      ]
    }
  },
  "events": {
    "bothSkatesOverAt": null,
    "puckFullyOverAt": 1.55,
    "lineContact": "L touches blue line"
  },
  "decisionAt": 1.35,
  "freezeAt": 1.55,
  "copyKey": "offside-onside-line"
}
```

**OFF-05 `delayed-arm-up` (tags: delayed)**

```json
{
  "scenarioId": "OFF-05",
  "title": "Arm up, don't blow",
  "teaches": [
    "delayed-offside"
  ],
  "correct": "arm-up",
  "keyframes": {
    "puck": [
      {
        "t": 0.0,
        "x": 30.0,
        "y": 0.0
      },
      {
        "t": 1.0,
        "x": 33.0,
        "y": 10.0
      }
    ],
    "att_2": {
      "skatesAt": [
        {
          "t": 0.4,
          "L": {
            "trail": 27.0,
            "lead": 28.0
          },
          "R": {
            "trail": 27.3,
            "lead": 28.3
          },
          "y": -12.0
        }
      ]
    },
    "def_1": {
      "hasPuck": true,
      "from": {
        "x": 40.0,
        "y": 5.0
      },
      "to": {
        "x": 30.0,
        "y": 12.0
      }
    }
  },
  "events": {
    "defenderControlsPuck": 0.9,
    "tagUpAt": 2.2
  },
  "decisionAt": 0.95,
  "freezeAt": 2.2,
  "copyKey": "delayed-correct"
}
```

Remaining scenarios (OFF-01, 04, 06-12) follow the same keyframe format. Generation rules for future scenarios: (a) every scenario declares `events.bothSkatesOverAt`, `events.puckFullyOverAt` (or null) and a `correct` action; (b) margins between the compared values are >= 0.08 s or >= 0.4 ft so the call is unambiguous at 60 Hz; (c) each scenario includes `copyKey` mapping to section 12. Scenarios are deterministic; only jersey numbers and attacker lane offsets (+/-3 ft) vary with the seed.

## 12. Freeze / explain moments
Copy pools below are keyed by `copyKey`. Every string satisfies title <= 6 words, body <= 45 words.

**offside-correct-whistle**
- Trigger: Whistle call on an offside entry (OFF-02, 08, 09, 10)
- What freezes: All players and puck at the instant the puck fully crosses
- Camera: Cut to `blueline-cam`, then a 0.25x replay chip
- Callouts: Leading edge of the blue line glows gold; both skates ringed rose with a "over" tag; puck shown behind the line
- Correct outcome: Title "Nice read.". Body: "Both skates were fully over the line before the puck was. Offside is about where the blades are, not how involved he is." Say this: "Both skates were over before the puck. Offside."
- Incorrect outcome: Title "Not quite.". Body: "You let it go, but both blades were past the line before the puck got there. Offside does not care whether he touches the play." Say this: "Both skates were over before the puck. Offside."

**offside-onside-line**
- Trigger: Play-on call on a skate-touching-the-line entry (OFF-03)
- What freezes: Frame of the puck fully crossing
- Camera: `blueline-cam` zoomed to the trailing skate
- Callouts: Trailing skate glows gold where it touches the line; a check badge says "on the line"
- Correct outcome: Title "Nice read.". Body: "One skate still touches the line, so he is onside. It takes both skates completely over to be offside. Close ones go to the player." Say this: "One skate on the line keeps him onside."
- Incorrect outcome: Title "Not quite.". Body: "That heel is still on the line. A skate touching the blue line keeps him onside, even when the other one is over." Say this: "One skate on the line keeps him onside."

**offside-carry-in**
- Trigger: Play-on on a clean carry-in (OFF-01, 04, 07)
- What freezes: The puck crossing
- Camera: `top-down` then `blueline-cam`
- Callouts: Puck highlighted gold and a line showing it ahead of every skate
- Correct outcome: Title "Nice read.". Body: "The puck crossed first, so everyone behind it is fine. Carrying or shooting the puck in keeps the whole team onside." Say this: "The puck went in first, so it's a good entry."
- Incorrect outcome: Title "Not quite.". Body: "The puck went over the line before any attacker was completely over it. That is a legal entry, so play on." Say this: "The puck went in first, so it's a good entry."

**delayed-offside**
- Trigger: Arm-up or tag-up scenarios (OFF-05, OFF-06)
- What freezes: Moment the winger touches the blue line or the puck
- Camera: `top-down`
- Callouts: Early winger ringed rose; blue line flashes when he tags up; defender's puck highlighted
- Correct outcome: Title "Nice read.". Body: "The defense has the puck, so play continues with the arm up. If the attackers clear the zone by touching the blue line, no whistle. If one touches the puck first, whistle." Say this: "Arm up, so it's a delayed offside."
- Incorrect outcome: Title "Not quite.". Body: "Blowing it right away takes the defense's possession away. The arm goes up and play continues until the attackers tag up or touch the puck." Say this: "Arm up, so it's a delayed offside."

**challenge-review**
- Trigger: Goal challenge (OFF-11, OFF-12)
- What freezes: Entry frame from the replay
- Camera: `blueline-cam` at 0.25x, then `top-down`
- Callouts: Same overlay as the whistle call, plus a "video review" tag
- Correct outcome: Title "Nice read.". Body: "Reviewers use the entry frame: skates against the blue line, puck against the line. Here the call is clear, so it stands. A failed challenge costs the coach a timeout." Say this: "They challenged the entry and the call stood."
- Incorrect outcome: Title "Not quite.". Body: "Review looks at the moment of entry, not the goal. Check both skates and the puck at that one frame before you decide." Say this: "They challenged the entry and the call stood."

## 13. Scoring & mastery signals
- **Round score:** 1.0 for the correct action; 0.5 for calling offside on a delayed-offside scenario or blowing the whistle before the touch on a tag-up scenario (right idea, wrong timing); 0 otherwise.
- **Score (0-100):** `round(mean(roundScore) * 100)`, minus `5` per hint used (floor 0). **Accuracy:** correct rounds / rounds played. **Outcome ids:** `round-1`..`round-N`, `success` = round fully correct, `label` = scenario title, `value` = scenarioId.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (in `mistakes[].description`) |
|---|---|---|
| Whistled a legal entry | offside | You blew the whistle while a skate was still on the blue line or the puck went in first. |
| Played on an offside entry | offside | Both skates were completely over the blue line before the puck fully crossed. |
| Whistled instead of arm up | delayed-offside | The defense had the puck, so it should have been a delayed offside. |
| Missed the tag-up touch | delayed-offside | The winger touched the puck without clearing the zone. |
| Wrong challenge outcome | coaches-challenge | The entry frame decides a review, not the goal itself. |
| Thought puck re-entry stayed offside | zones | Once the puck fully leaves the zone the offside is wiped. |

**Mastery signals**

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct call on a basic entry | offside | +0.20 | Correctly judged skates against the blue line. |
| Correct call on a skate-on-line scenario | offside | +0.25 | Recognized that a skate on the line is onside. |
| Wrong call on any offside scenario | offside | -0.15 | Misjudged an entry against the blue line. |
| Correct arm-up | delayed-offside | +0.25 | Kept play alive for a delayed offside. |
| Whistle instead of arm-up / missed touch | delayed-offside | -0.15 | Mishandled a delayed offside. |
| Correct review call | coaches-challenge | +0.20 | Judged the entry from the review angle. |
| Correct puck-cleared call | zones | +0.15 | Knew a cleared puck resets offside. |

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
| Decision timeout (levels 3-5) | Card: "Clock ran out. The play went on without you." then the explain moment for the scenario. | Round marked failed, mistake tagged `timeout` | No |
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
- **Tap-only:** All inputs are already taps; no drags or holds anywhere. A "Slow play" toggle in the summary and pre-round card sets playback to 0.4x at any difficulty.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Accessible native fallback lesson: **`rules-offside-line` (native `visual-id` + `binary-call` on frozen entry stills with a written 'leading edge' explanation)** (a separate, designed native exercise set; not a port).
- Playback can be slowed to 0.4x for everyone; color is never the only signal for skate position (ring vs badge shapes).

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Decision available | soft stick tap on ice | none | -18 dB |
| Correct call | short rising two-note chime (original) | light success | -14 dB |
| Incorrect call | muted low thud | warning (single) | -16 dB |
| Freeze | crowd ambience ducks 80%, ice hiss | none | -20 dB |
| Whistle | original short pea-whistle (synthesized) | light on confirm | -15 dB |
| Summary | two-note resolve | light success if score >= 60 | -14 dB |

All sounds respect `soundEnabled`; all haptics respect `hapticsEnabled`. Ambient crowd is a looped procedural noise bed, no recorded broadcast audio.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Rink surface, lines, faceoff circles | procedural | original | 0 textures; ~1.5k tris | dynamic line width from data |
| Characters (4 attackers, 2 defenders, linesman) | procedural capsule figures with blade meshes | original | ~800 tris each | striped vs solid jerseys, numbers as text meshes |
| Puck | procedural | original | 200 tris | emissive rim when highlighted |
| Whistle / ice / crowd audio | procedural or original synthesized | original-swoond | < 1.5 MB total | no recorded broadcast audio |
| Glass/boards | procedural | original | < 1k tris | no ads, no logos |

- **Overlay styling:** per `docs/astra/ART_DIRECTION.md`: rose = you/act, gold = earned/correct, dim everything not being explained, one focal idea per frame. Rink markings are procedural; NHL and team logos are never used (jerseys are generic stripes/solids with numbers).
- **Addressables bundle:** `sim.hockey.rules.offside-read.v1` , expected about 3 MB compressed (<= 25 MB budget).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply and are not loosened: 60 fps on iPhone 13-class (p5 >= 50), peak Unity memory < 150 MB, cold launch to `ready` < 2 s (4 s first load), bundle <= 25 MB, draw calls <= 150, <= 60k on-screen triangles, <= 15 materials, textures <= 8 MB VRAM, thermal state not above "fair" over a 3-minute session.
Tighter per-sim limits: Rink and 7 characters must stay under 25k triangles; blueline-cam transition < 100 ms; per-frame offside evaluation < 0.3 ms.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus counters:
| key | meaning |
|---|---|
| hintsUsed | total Hint uses |
| decisionLatencyMsAvg | mean time from Decision open to input |
| scenarioIds | comma-joined scenario ids played (no free text) |
| entryEvaluationsPerRound | number of frames the LineCrossingObjective evaluated |
| cameraSwitches | number of camera preset changes |

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
- **AC-10 (rule engine):** For every scenario in the pool, `LineCrossingObjective` computes `bothSkatesOverAt` and `puckFullyOverAt` matching the values authored in the scenario JSON within 1 frame (16.7 ms).
- **AC-11 (skate on line):** Given trail = 25.4 ft for one skate and the other over, the evaluator returns onside; with trail = 25.6 ft for both it returns offside (boundary test on the leading edge at 25.5).
- **AC-12 (delayed offside):** In OFF-05, choosing Whistle scores 0.5 and records mistake `delayed-offside`; choosing Arm up scores 1.0 and requires the tag-up event to occur before the round ends.
- **AC-13 (difficulty):** At difficulty 1 the decision timer is absent; at difficulty 3 the timer bar is present and the third button is enabled.
- **AC-14 (camera):** Every round's Freeze uses `blueline-cam`; with `reducedMotion` the switch is a cut.

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
| AC-10 | EditMode | LineCrossing_MatchesAuthoredEventTimes |
| AC-11 | EditMode | LineCrossing_LeadingEdgeBoundary |
| AC-12 | PlayMode | DelayedOffside_ArmUpAndTagUpFlow |
| AC-13 | PlayMode | Difficulty_TogglesTimerAndButtons |
| AC-14 | PlayMode | Freeze_UsesBluelineCam |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Airborne-skate rule (OFF-08): confirm the exact NHL wording (Rule 83) and whether the PWHL/IIHF use the same interpretation before content is locked | Claude (content), Product | Yes for OFF-08 only |
| 2 | Should the linesman avatar appear on screen, or only the buttons? | Astra / Product | No |
| 3 | Limit of the NHL offside challenge (possession-continuity condition): the exact 'no clear break in possession' wording to use in OFF-11 copy | Claude (content) | No |
| 4 | Is 0.25x replay chip acceptable on iPhone 13 (record + replay memory)? | Astra | No |
