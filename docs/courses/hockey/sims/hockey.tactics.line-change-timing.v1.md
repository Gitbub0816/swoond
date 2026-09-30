# Change on the Fly: Line Change Timing (`hockey.tactics.line-change-timing.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `hockey.tactics.line-change-timing.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (definition file optional: this sim is scenario-data driven, see section 11) |
| Authors / date | Swoon'd content team (Claude), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `hockey`. Units and lessons that launch this sim: unit `game-on-ice` lesson `game-line-changes`; unit `the-debates` lesson `eye-last-change`.
- CDS row: `docs/courses/hockey/CDS.md` section 12, family `line-change-timing`.
- Manifest entry: `docs/courses/hockey/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered`, otherwise the lesson shows a native primer first): `line-change`, `too-many-men` and `icing` primers (native lessons `game-line-changes` is the launcher; `rules-icing-basics` before difficulty 3).

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can see when it is safe to change lines, when it is not allowed, and why coaches get frustrated with a bad change.
| conceptId | term | after the sim the learner can... |
|---|---|---|
| line-change | Line change | pick a safe moment to change, given the puck, the bench distance and tired legs |
| too-many-men | Too many men on the ice | hop over the boards only when the outgoing skater is close enough to the bench |
| icing | Icing | remember that the team that iced cannot change |
| last-change | Last change and line matching | understand why the home coach cares about the change at a faceoff |

- **Out of scope:** Choosing which line to send (covered natively in `eye-last-change`), defensive pairs, goalie changes.

## 4. Why Unity (tier justification)
Rubric answers: (1) **Timing in a scene:** the learner has a continuous window and the right answer depends on when things happen relative to the puck. (2) **Movement over time and space:** skaters need seconds to reach the bench; how far the bench is (long change) and where the puck is decide the risk. (3) **Reading a dynamic scene:** rushes, clears and turnovers appear on screen. A native `timing-tap` bar is a 1D marker with no puck, no bench and no risk, so it can teach 'timing' but not *what* to time against. `decision-scenario` can list facts about puck and bench but cannot show that a change started at the wrong moment produces a breakaway 3 s later.

## 5. Player fantasy & core loop
**Fantasy:** You are the bench boss with one word to say: "change!"

1. **Prompt:** "Tired legs. When do you send the next line?"
2. **Playing:** broadcast-side camera on a 12-second play window; a shift-clock chip above the on-ice line climbs toward tired.
3. **One decisive interaction:** tap **Change** at the moment you think it is safe (or **Hold** if a change is not allowed).
4. **Execute:** outgoing skaters head to the bench (near = 3 s, far/long change = 7.5 s); at difficulty 3+ you also tap **Hop** when they are close enough.
5. **Freeze / explain:** the timeline strip shows safe (gold) and risky (rose) windows and where your tap landed; card explains.
6. **Say this:** e.g. "They got caught on a long change."

Session target: about 3 minutes, 3 rounds by default (`configuration.rounds`), drawn from the scenario pool in section 11.

## 6. Scene & entities
- **Environment:** `hockey_rink_bench_side (new registry key: full rink with a bench along the near boards and a door at center ice)`. **Camera presets:** `broadcast-side` (play), `top-down` (explain), `bench-cam` (new: low view of the bench door for Hop timing).

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| forwards_on | Character x3 (playerForward) | on-ice line (tired) | shiftSec 38-58 |
| forwards_bench | Character x3 | next line at the door | hop when triggered |
| opponents | Character x5 (opponent) | attack in the timeline | scripted |
| puck | Ball | the puck | scripted possession |
| bench | Zone | bench with door | door at x=0; hop range radius 10 ft |
| shiftClock | Objective (`ShiftFatigueObjective`) | fatigue level 0..1 | full at fatigueDeadlineSec |
| timelineStrip | Highlight overlay | explain: windows | gold/rose bands |
| decisionBar | DecisionPoint + Targets | Change / Hold / Hop | 56 pt buttons |

- **Reused primitives:** Character, Ball, Zone, Path, CameraRig, TouchController, DecisionPoint, Hint, Explanation, Objective, Score, Replay, SlowMotion, Highlight, Rng, ScenarioSet.
- **Diagram (initial layout):**

```
   far boards
   +---------------------------------------------------+
   |   opponents ... puck ...  our forwards (tired)    |
   +---------------------------[ door ]-----------------+   <- near boards / our bench
                 next line waits at the door
   timeline strip: |-safe-|--threat--|--safe--|   [tap marker]
```

### Game Kit additions requested
| Addition | Why it is needed | Reuse plan |
|---|---|---|
| `Swoond.Sports.Hockey` `Rink`, `Puck`, `Bench` (zone with door) | Shared | All hockey sims |
| `ShiftFatigueObjective` (fatigue gauge and visible tired animation) | Fatigue is the reason to change | Basketball substitutions, soccer stamina |
| `TimelineStrip` overlay (safe/risk bands for a time axis) | Shows the right timing after the fact | Any timing-in-scene sim, racing pit windows |
| `CameraRig` preset `bench-cam` | Hop timing | - |

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Change | tap button, lower-right | 56 pt | outgoing line turns rose and heads to the bench |
| Hold | tap button, lower-left (only when a change is not allowed) | 56 pt | lock icon on the bench |
| Hop (difficulty >= 3) | tap button, lower-center; enabled after Change | 56 pt | button ring turns gold when the outgoing skater is within 10 ft |
| Hint | tap lightbulb | 44 pt | shows the threat window bands on the timeline (costs 5 points) |

- **Tap-only alternative scheme:** All taps. The 12-second window can be slowed to 0.5x; with `manualHop=false` the hop is automatic.
- **Orientation / safe area:** portrait. All buttons live inside `runtime.safeAreaInsets`; the decision bar sits 28-34 pt above the bottom inset.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation (`requestExit` with `user-quit`; native shows "Leave game?"), XP/streak UI, lesson chrome.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate contract, simulationId, configuration; build rink and characters from code; load scenario set | `ready` sent -> Intro (invalid config -> `error CONFIG_INVALID`) | `ready` |
| Intro | Ready acknowledged | One-line objective card (Display S serif), 1.5 s; camera settles on the opening preset. Shows a bench door and a 10-foot ring. | Auto -> Playing (first round) | `progress` 0.0 |
| Playing | Round starts | 12 s play window at 1x (0.7x at difficulty 1-2); shift clock climbs; play follows the scenario timeline. | Decision point reached -> Decision | `progress` (<= 4 per second) |
| Decision | Decision point reached | Continuous: **Change** is available throughout; timer is the window itself (no separate timer). | Input or time limit -> Executing | none |
| Executing | Decision recorded | On tap, the outgoing line skates to the bench (3.0 s near or 7.5 s far). Outgoing skaters are exposed for that duration. At difficulty 3+ the learner then taps Hop; early hop is a too-many-men penalty (2:00 bench minor), late hop is a slow change. | Outcome resolved -> Freeze | none |
| Freeze | Outcome resolved | Time freezes at the end of the exposure window or at the first risk event during it (rush, shot, whistle); tap marker is drawn on the timeline strip. | 1.2 s (0.4 s with reduced motion) -> Explain | none |
| Explain | Freeze complete | Copy card and timeline strip slide up; "Replay the change" chip replays from `bench-cam` at 0.5x. Tap "Next play" (or auto after 12 s at difficulty 4-5) advances. | Rounds left -> Playing; else -> Summary | `checkpoint` (round id) |
| Summary | All rounds done | Score card: score, accuracy, per-round chips, one "say this" line from the weakest concept; native shows XP | Continue tapped -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` (Score.Build(true)) | `result` then `requestExit` (`completed`) | `result`, `requestExit` |
| Paused | `pause` received | Freeze sim time, timers, audio; dim overlay | `resume` -> previous state | none |
| Aborted | `abort` received or fatal error | Stop immediately; Score.Build(false) with partial outcomes | `result` (aborted=true) then `requestExit` | `result`, `requestExit` |

Pause/resume: on `pause` the state machine freezes simulation time, timers (including decision windows), audio and haptic loops; `resume` continues the same frame. Abort: emit `result` with `aborted=true`, `abortReason`, partial `outcomes`, `xpEarned: 0`, then `requestExit`.

## 9. Difficulty levels 1-5
| Parameter | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Play speed (x) | 0.7 | 0.7 | 1.0 | 1.0 | 1.0 |
| Scenario tags | `safe` | +`rush` | +`long-change`,`icing` | +`hop`,`pk` | all |
| Timeline strip visible during play | yes | no | no | no | no |
| Hop timing required | no | no | yes | yes | yes |
| Fatigue deadline (s into window) | late | mid | mid | early | early |
| Hints | 2 | 1 | 1 | 0 | 0 |
| Hop tolerance (ft) | auto | auto | 10 | 10 | 10 |

Level 1 shows the risk bands and needs no hop; a true beginner passes with hints. **Default for `game-line-changes` is 1; `eye-last-change` uses 3.**

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
        "linechange-starter",
        "linechange-advanced"
      ]
    },
    "rounds": {
      "type": "integer",
      "minimum": 3,
      "maximum": 6,
      "default": 3,
      "description": "Number of rounds in the session."
    },
    "benchSide": {
      "type": "string",
      "enum": [
        "near",
        "far"
      ],
      "default": "near",
      "description": "Near = 3.0 s change duration; far/long change = 7.5 s."
    },
    "windowSec": {
      "type": "number",
      "minimum": 8,
      "maximum": 20,
      "default": 12
    },
    "manualHop": {
      "type": "boolean",
      "default": false
    },
    "showTimeline": {
      "type": "boolean",
      "default": true
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
  "seed": 5,
  "scenarioSetId": "linechange-starter",
  "rounds": 3,
  "benchSide": "near",
  "windowSec": 12,
  "manualHop": false,
  "showTimeline": true,
  "playbackSpeed": 0.7
}
```

## 11. Scenario data set
Each scenario is a 12-second timeline of risk states, bench distance, fatigue deadline and a set of best/acceptable tap windows. A tap at time t is **best** when [t, t + changeDurationSec] overlaps no `threat` interval and t <= fatigueDeadlineSec; **acceptable** when safe but late (tired legs); **failed** otherwise. When `changeAllowed=false`, the only correct action is Hold. **Pool size N = 10** (rounds x 3 minimum is 9). Scenarios ship as `linechange-starter.json / linechange-advanced.json` inside the sim's Addressables bundle (JSON, array of scenario objects). Selection is deterministic per `seed`: shuffle with `Rng(seed)`, filter by the difficulty tags in section 9, take `rounds` scenarios, never repeating a `teaches` concept back-to-back if avoidable.

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| LC-01 | Period 1, near bench (3 s change). We cycle in their zone, then a turnover rush comes at 6 s | Change at 0-3 s or 8-9 s | line-change | safe |
| LC-02 | Period 2, long change (7.5 s). Odd-man rush against from 2 to 6 s | Wait, change from 6 s on | line-change | long-change, rush |
| LC-03 | We just iced the puck | Hold: no change allowed | icing | icing |
| LC-04 | Opponent iced; we are on a 4-second whistle | Change now: they can't | icing | icing |
| LC-05 | Puck cleared to neutral zone, shift at 65 s, no threat until 8 s | Change now (tired) | line-change | safe |
| LC-06 | Our 3-on-2 rush is in progress | Hold; do not change mid-rush | line-change | rush |
| LC-07 | Penalty kill: puck cleared to the far end, shorthanded | Change now (clear) | penalty-kill | pk |
| LC-08 | Power play begins; new unit at the door; puck already in the zone | Change now (best window in first 2 s) | power-play | pk |
| LC-09 | Hop timing: outgoing skater at 14 ft from the door when the incoming line is ready | Wait for 10 ft before hopping | too-many-men | hop |
| LC-10 | Whistle in period 3, away team must change first; opponent has last change | Change now: dead puck | last-change | safe |

Fully written scenarios (canonical data format; the rest follow the same shape):

**LC-01 `change-while-we-have-it` (tags: safe)**

```json
{
  "scenarioId": "LC-01",
  "title": "Change while we have the puck",
  "period": 1,
  "benchSide": "near",
  "changeDurationSec": 3.0,
  "changeAllowed": true,
  "windowSec": 12.0,
  "onIce": {
    "forwards": [
      {
        "id": "F_1",
        "shiftSec": 38
      },
      {
        "id": "F_2",
        "shiftSec": 40
      },
      {
        "id": "F_3",
        "shiftSec": 39
      }
    ],
    "defense": "unchanged"
  },
  "timeline": [
    {
      "from": 0.0,
      "to": 6.0,
      "state": "o-zone-possession",
      "risk": "none"
    },
    {
      "from": 6.0,
      "to": 8.0,
      "state": "turnover-then-rush-against",
      "risk": "threat"
    },
    {
      "from": 8.0,
      "to": 12.0,
      "state": "puck-cleared-neutral",
      "risk": "none"
    }
  ],
  "fatigueDeadlineSec": 9.0,
  "best": {
    "windowsSec": [
      [
        0.0,
        3.0
      ],
      [
        8.0,
        9.0
      ]
    ]
  },
  "acceptable": {
    "windowsSec": [
      [
        9.0,
        12.0
      ]
    ]
  },
  "teaches": [
    "line-change"
  ],
  "copyKey": "lc-safe"
}
```

**LC-02 `long-change` (tags: long-change, rush)**

```json
{
  "scenarioId": "LC-02",
  "title": "The long change",
  "period": 2,
  "benchSide": "far",
  "changeDurationSec": 7.5,
  "changeAllowed": true,
  "windowSec": 12.0,
  "onIce": {
    "forwards": [
      {
        "id": "F_1",
        "shiftSec": 52
      },
      {
        "id": "F_2",
        "shiftSec": 49
      },
      {
        "id": "F_3",
        "shiftSec": 55
      }
    ],
    "defense": "unchanged"
  },
  "timeline": [
    {
      "from": 0.0,
      "to": 2.0,
      "state": "d-zone-opponent-possession",
      "risk": "none"
    },
    {
      "from": 2.0,
      "to": 6.0,
      "state": "odd-man-rush-against",
      "risk": "threat"
    },
    {
      "from": 6.0,
      "to": 12.0,
      "state": "cleared-then-o-zone",
      "risk": "none"
    }
  ],
  "fatigueDeadlineSec": 13.0,
  "best": {
    "windowsSec": [
      [
        6.0,
        12.0
      ]
    ]
  },
  "acceptable": {
    "windowsSec": []
  },
  "teaches": [
    "line-change"
  ],
  "copyKey": "lc-long-change",
  "note": "Any tap at t < 6.0 overlaps the threat window because 7.5 s of exposure starts at the tap."
}
```

**LC-03 `no-change-after-icing` (tags: icing)**

```json
{
  "scenarioId": "LC-03",
  "title": "We iced it",
  "period": 1,
  "benchSide": "near",
  "changeDurationSec": 3.0,
  "changeAllowed": false,
  "changeBlockedReason": "icing",
  "windowSec": 12.0,
  "onIce": {
    "forwards": [
      {
        "id": "F_1",
        "shiftSec": 57
      },
      {
        "id": "F_2",
        "shiftSec": 55
      },
      {
        "id": "F_3",
        "shiftSec": 58
      }
    ],
    "defense": "unchanged"
  },
  "timeline": [
    {
      "from": 0.0,
      "to": 12.0,
      "state": "faceoff-in-own-zone-after-icing",
      "risk": "none"
    }
  ],
  "fatigueDeadlineSec": null,
  "best": {
    "windowsSec": []
  },
  "correctAction": "hold",
  "teaches": [
    "icing",
    "line-change"
  ],
  "copyKey": "lc-icing-block"
}
```

The remaining scenarios use the same shape (`timeline`, `best.windowsSec`, `acceptable.windowsSec`, `changeAllowed`). Lint: best windows computed by the reference evaluator must equal the authored ones; every best window is at least 1.0 s wide; `threat` intervals are at least 2.0 s wide; opponents' shot events during the exposure window are deterministic per seed but never change safe/unsafe classification.

## 12. Freeze / explain moments
Copy is keyed by `copyKey`; every string satisfies title <= 6 words, body <= 45 words.

**lc-safe**
- Trigger: Change at a safe moment (LC-01, 05, 10)
- What freezes: Bench door as the new line hops
- Camera: `bench-cam` then `top-down`
- Callouts: Timeline strip: your tap in a gold band; the rest of the strip visible
- Correct outcome: Title "Nice read.". Body: "You changed while the puck was deep in their end. Nothing could punish it before the new line got set. Great changes are invisible." Say this: "Change when the puck is deep in their end."
- Incorrect outcome: Title "Not quite.". Body: "You changed into trouble: the puck came back before your line was set. Wait until the puck is deep, or the clear is made." Say this: "Change when the puck is deep in their end."

**lc-long-change**
- Trigger: Long change (LC-02)
- What freezes: Exposure window start and the rush arrival
- Camera: `top-down`
- Callouts: 7.5 s exposure bar; rush arrow; door far from the play
- Correct outcome: Title "Nice read.". Body: "In the second period your bench is far from your own zone. You waited out the rush and changed after the clear. The long change punishes changes at the wrong time." Say this: "They got caught on the long change."
- Incorrect outcome: Title "Not quite.". Body: "With a long change your skaters need 7.5 seconds to get off. The rush arrived while they were on the way. Wait for the clear." Say this: "They got caught on the long change."

**lc-icing-block**
- Trigger: Icing restriction (LC-03) and its mirror (LC-04)
- What freezes: Bench door
- Camera: `bench-cam`
- Callouts: Lock icon on the door; tired skaters' fatigue bar
- Correct outcome: Title "Nice read.". Body: "The team that iced can't change. Their tired line stays out for the faceoff. It is the whole punishment for icing." Say this: "They iced it, so they're stuck out there."
- Incorrect outcome: Title "Not quite.". Body: "After icing you can't change. Send the new line anyway and it is too many men. The other team, though, can change freely." Say this: "They iced it, so they're stuck out there."

**lc-too-many-men**
- Trigger: Early hop or LC-09
- What freezes: The hop frame
- Camera: `bench-cam`
- Callouts: 10 ft ring around the door; skater distance number
- Correct outcome: Title "Nice read.". Body: "You waited for the outgoing skater to get within ten feet of the door. The change was clean. Too early and it is a bench minor." Say this: "Too many men. That change was early."
- Incorrect outcome: Title "Not quite.". Body: "The new line hopped while the old one was still too far from the door. That is too many men: two minutes shorthanded." Say this: "Too many men. That change was early."

**lc-tired**
- Trigger: Late change (tired legs)
- What freezes: The shot or scoring chance against
- Camera: `broadcast-side`
- Callouts: Fatigue bar red; skaters slow
- Correct outcome: Title "Nice read.". Body: "You changed before the legs went. Fresh skaters keep the puck in their end and the shifts short. Forty-five seconds is plenty." Say this: "The legs went, so the goal went in."
- Incorrect outcome: Title "Not quite.". Body: "Your line was tired and got beat. Long shifts lose battles. Change earlier, even when the puck is not perfectly placed." Say this: "The legs went, so the goal went in."

## 13. Scoring & mastery signals
- **Round score:** 1.0 for a tap in a best window (or Hold when required); 0.5 for a safe but late change or an early hop that is corrected; 0 for exposure during a threat, a change when not allowed, or too many men.
- **Score (0-100):** `round(mean(roundScore) * 100)`, minus `5` per hint used (floor 0). **Accuracy:** correct rounds / rounds played. **Outcome ids:** `round-1`..`round-N`, `success` = round fully correct, `label` = scenario title, `value` = scenarioId.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (in `mistakes[].description`) |
|---|---|---|
| Changed into a rush | line-change | The change started right before an attack, and the new line was not set. |
| Waited until the legs died | line-change | The shift ran too long and the line was tired. |
| Changed after icing | icing | The team that iced cannot change. |
| Hopped too early | too-many-men | Outgoing skater was farther than ten feet from the bench. |
| Did not use the free change | last-change | The opponent iced or a whistle blew; a free change was available. |

**Mastery signals**

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Best-window change | line-change | +0.20 | Changed at a safe moment. |
| Hold after icing | icing | +0.20 | Knew the icing team can't change. |
| Clean hop | too-many-men | +0.20 | Waited until the skater was within ten feet. |
| Change into a rush | line-change | -0.15 | Changed into a threat. |
| Too many men | too-many-men | -0.20 | Hopped early. |
| Free change used (LC-04, 10) | last-change | +0.10 | Used the dead-puck or opponent-icing change. |

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
| Decision timeout (levels 3-5) | Card: "Twelve seconds went by and the line never left. Legs: gone." then explain (round scored 0 unless Hold was correct). | Round marked failed, mistake tagged `timeout` | No |
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
- **Tap-only:** All taps. The 12-second window can be slowed to 0.5x; with `manualHop=false` the hop is automatic.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Accessible native fallback lesson: **`game-line-changes` companion set: native `binary-call` and `decision-scenario` ("Change or hold?" with a written timeline)** (a separate, designed native exercise set; not a port).
- A visible countdown of the window and an audio tick every second (optional) help players who cannot track the puck; the timeline strip labels every band with text.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Decision available | soft stick tap on ice | none | -18 dB |
| Correct call | short rising two-note chime (original) | light success | -14 dB |
| Incorrect call | muted low thud | warning (single) | -16 dB |
| Freeze | crowd ambience ducks 80%, ice hiss | none | -20 dB |
| Bench door | original wooden door thud and skate hiss | light tap at hop | -15 dB |
| Summary | two-note resolve | light success if score >= 60 | -14 dB |

All sounds respect `soundEnabled`; all haptics respect `hapticsEnabled`. Ambient crowd is a looped procedural noise bed, no recorded broadcast audio.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Rink with bench | procedural | original | ~2.5k tris | - |
| 11 characters (6 forwards, 5 opponents) | procedural | original | ~600 tris each | numbers, tired animation |
| Bench, door, timeline strip | procedural | original | small | - |
| Audio | synthesized | original-swoond | < 1 MB | - |

- **Overlay styling:** per `docs/astra/ART_DIRECTION.md`: rose = you/act, gold = earned/correct, dim everything not being explained, one focal idea per frame. Rink markings are procedural; NHL and team logos are never used (jerseys are generic stripes/solids with numbers).
- **Addressables bundle:** `sim.hockey.tactics.line-change-timing.v1` , expected about 3 MB compressed (<= 25 MB budget).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply and are not loosened: 60 fps on iPhone 13-class (p5 >= 50), peak Unity memory < 150 MB, cold launch to `ready` < 2 s (4 s first load), bundle <= 25 MB, draw calls <= 150, <= 60k on-screen triangles, <= 15 materials, textures <= 8 MB VRAM, thermal state not above "fair" over a 3-minute session.
Tighter per-sim limits: Fatigue animation via shader parameter only (no extra draw calls); bench-cam swap < 100 ms.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus counters:
| key | meaning |
|---|---|
| hintsUsed | total Hint uses |
| decisionLatencyMsAvg | mean time from Decision open to input |
| scenarioIds | comma-joined scenario ids played (no free text) |
| tapTimeSecAvg | mean tap time in the window |
| tooManyMenCount | early hops |

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
- **AC-10 (evaluator):** For every scenario the reference evaluator returns `best` and `acceptable` windows equal to the authored ones.
- **AC-11 (hold rule):** With `changeAllowed=false` a Change tap always scores 0 and records mistake `icing`; a session-length Hold scores 1.0.
- **AC-12 (hop rule):** At difficulty >= 3, Hop with the nearest outgoing skater farther than 10.0 ft records `too-many-men` and scores 0.
- **AC-13 (exposure):** A tap at time t is unsafe iff [t, t + changeDurationSec] overlaps any `threat` interval (property test over t in 0..12 at 0.1 s).
- **AC-14 (timeline strip):** The explain moment always shows the tap marker and the best windows.

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
| AC-10 | EditMode | LineChange_EvaluatorMatchesAuthored |
| AC-11 | PlayMode | Icing_HoldRule |
| AC-12 | PlayMode | Hop_TenFootRule |
| AC-13 | EditMode | Exposure_PropertyTest |
| AC-14 | PlayMode | Explain_ShowsTimelineStrip |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Forwards-only changes: is it acceptable that defense pairs are not modeled? | Claude (content) | No |
| 2 | Confirm the current NHL wording for the ten-foot rule (Rule 71) and whether the PWHL uses the same | Claude (content) | No |
| 3 | Does a failed change during the power play need a separate result outcome id? | Claude / Astra | No |
| 4 | 12-second window on a 3-minute session: should it be 3 rounds of 12 s plus explains, or longer windows at higher levels? | Product | No |
