# Race to the Dot: Icing Call (`hockey.rules.icing-call.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `hockey.rules.icing-call.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (definition file optional: this sim is scenario-data driven, see section 11) |
| Authors / date | Swoon'd content team (Claude), 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `hockey`. Units and lessons that launch this sim: unit `rules-of-play` lesson `rules-icing-race`.
- CDS row: `docs/courses/hockey/CDS.md` section 12, family `icing-call`.
- Manifest entry: `docs/courses/hockey/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered`, otherwise the lesson shows a native primer first): `icing` primer (native lesson `rules-icing-basics`), `zones`, `rink-layout`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can watch a puck fly down the ice and a footrace start, and say whether the linesman blows it dead for icing or waves it off.

| conceptId | term | after the sim the learner can... |
|---|---|---|
| icing | Icing | recognize when a shot from behind the red line across the far goal line is icing and when an exception applies |
| hybrid-icing | Hybrid icing | judge the race to the end-zone faceoff dot line |
| penalty-kill | Penalty kill | know that a shorthanded team may ice the puck freely |
| line-change | Line change | remember that the team that iced cannot change |

- **Out of scope:** Touch-up icing variants beyond a labelled option, offside, and line-change tactics (covered by other sims).

## 4. Why Unity (tier justification)
Rubric answers: (1) **Movement in space:** hybrid icing is a footrace judged at a line the players have not reached yet; the learner has to predict it from speeds and positions. (2) **Camera perspective:** the high-behind camera shows the gap between two skaters and the dot line, which a diagram cannot express. (3) **Timing:** the call is made while the puck is still in flight. A native `binary-call` on a diagram can teach the definition of icing and its exceptions (and does, in `rules-icing-basics` and `rules-icing-exceptions`), but not the race judgment; that is why only the race is in Unity.

## 5. Player fantasy & core loop
**Fantasy:** You are the linesman skating down the boards, whistle ready, with a split second to decide.

1. **Prompt:** "Puck's gone the length of the ice. Icing?"
2. **Playing:** a player fires the puck from his own end; the puck slides down the ice, two skaters begin a race.
3. **One decisive interaction:** tap **Icing (whistle)** or **Wave it off** before the leader reaches the faceoff dot line (the sim freezes at the hash marks at difficulty 1-2, runs live at 4-5).
4. **Execute:** whistle and stoppage, or play on.
5. **Freeze / explain:** freeze at the dot line; a gold line marks the dot line; skater speeds shown as arrows; card explains.
6. **Say this:** e.g. "Their guy was going to get there first, so icing."

Session target: about 3 minutes, 3 rounds by default (`configuration.rounds`), drawn from the scenario pool in section 11.

## 6. Scene & entities
- **Environment:** `hockey_rink_full (new registry key: full ice, lines and dot line marker as an imaginary overlay)`. **Camera presets:** `broadcast-high-behind` (new preset behind the shooting team, elevated), `top-down` (freeze), `blueline-cam` reused for the goal line.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| rink | Swoond.Sports.Hockey.Rink | play surface | full 200x85 ft; imaginary dot line at x = goalLine - 20 ft (the faceoff dots) |
| shooter | Character (role: player) | player who shoots the puck | from x in [-100, 0] |
| puck | Ball | the puck | speed 60-95 ft/s, friction 0.985/frame |
| chaser | Character (attacker of the ice, team that shot) | races to touch/reach | speed 24-31 ft/s |
| retriever | Character (defender, opposing team) | races to the dots | speed 24-31 ft/s |
| dotLine | Zone (line) | hybrid icing decision line | x = +/- 69 ft (end-zone dot centers) |
| decisionBar | DecisionPoint + 2 Targets | Icing / Wave off | 56 pt buttons |
| raceObjective | Objective (`LineCrossingObjective`) | determines who reaches dotLine first | reports arrival times |
| speedArrows | Highlight | speed overlays | length proportional to speed |

- **Reused primitives:** Ball, Character, Zone, Path, CameraRig, TouchController, DecisionPoint, Hint, Explanation, Objective, Score, Replay, SlowMotion, Highlight, ThemeService, AccessibilityService, Rng, ScenarioSet.
- **Diagram (initial layout):**

```
  own goal                red line (center)                    far goal line
   |  [shooter] (puck)  ------------>-------------------------> |  dot line (x=69)
   |   [chaser] ~~~~>            ....gap....      <~~~~ [retriever]
   camera: high, behind the shooter's team; freeze = top-down on the dot line
```

### Game Kit additions requested
| Addition | Why it is needed | Reuse plan |
|---|---|---|
| `Swoond.Sports.Hockey` `Rink` + `Puck` (shared) | Shared hockey geometry | All hockey sims |
| `LineCrossingObjective` (shared, see offside sim) | Race to a line | Offside, soccer/tennis later |
| `RaceEvaluator` helper (compares two Paths' arrival times at a Zone) | Deterministic 'who gets there first' with margin | Racing course (pit-lane line), basketball fast breaks |
| `CameraRig` preset `broadcast-high-behind` | Best view of a long-ice race | Any long-field race sim |

## 7. Controls (touch)
| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Icing | tap button, lower-left | 56 pt tall | depress 80 ms; whistle |
| Wave it off | tap button, lower-right | 56 pt tall | arms-crossed icon on the linesman |
| Hint | tap lightbulb | 44 pt | draws the dot line and the two arrival times as numbers (costs 5 points) |

- **Tap-only alternative scheme:** Inputs are taps only. A "Slow play" toggle sets playback speed to 0.4x. Timed windows can be disabled (untimed) for the accessibility profile.
- **Orientation / safe area:** portrait. All buttons live inside `runtime.safeAreaInsets`; the decision bar sits 28-34 pt above the bottom inset.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation (`requestExit` with `user-quit`; native shows "Leave game?"), XP/streak UI, lesson chrome.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate contract, simulationId, configuration; build rink and characters from code; load scenario set | `ready` sent -> Intro (invalid config -> `error CONFIG_INVALID`) | `ready` |
| Intro | Ready acknowledged | One-line objective card (Display S serif), 1.5 s; camera settles on the opening preset. Shows the rink with the dot line labelled "where the race is judged". | Auto -> Playing (first round) | `progress` 0.0 |
| Playing | Round starts | Camera behind the shooter's team; puck released; two skaters accelerate along scripted speed curves; SlowMotion 0.6x at difficulty 1-3. | Decision point reached -> Decision | `progress` (<= 4 per second) |
| Decision | Decision point reached | Difficulty 1-2: sim freezes 1.0 s after release with speed arrows shown. Difficulty 3-5: play continues live; the learner has a decision window (see section 9) before the earlier arrival at the dot line. | Input or time limit -> Executing | none |
| Executing | Decision recorded | Whistle blows and skaters coast, or play on continues for 1.5 s into a puck battle. | Outcome resolved -> Freeze | none |
| Freeze | Outcome resolved | Time freezes at the moment the earlier skater reaches the dot line; gold line on the dot line; arrival times shown as small numerals. | 1.2 s (0.4 s with reduced motion) -> Explain | none |
| Explain | Freeze complete | Copy card slides up; replay chip shows top-down at 0.5x. Tap "Next play" (or auto after 12 s at difficulty 4-5) advances. | Rounds left -> Playing; else -> Summary | `checkpoint` (round id) |
| Summary | All rounds done | Score card: score, accuracy, per-round chips, one "say this" line from the weakest concept; native shows XP | Continue tapped -> Done | none |
| Done | Summary dismissed | Build `SimulationResult` (Score.Build(true)) | `result` then `requestExit` (`completed`) | `result`, `requestExit` |
| Paused | `pause` received | Freeze sim time, timers, audio; dim overlay | `resume` -> previous state | none |
| Aborted | `abort` received or fatal error | Stop immediately; Score.Build(false) with partial outcomes | `result` (aborted=true) then `requestExit` | `result`, `requestExit` |

Pause/resume: on `pause` the state machine freezes simulation time, timers (including decision windows), audio and haptic loops; `resume` continues the same frame. Abort: emit `result` with `aborted=true`, `abortReason`, partial `outcomes`, `xpEarned: 0`, then `requestExit`.

## 9. Difficulty levels 1-5
| Parameter | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| Speed gap between skaters (ft/s) | 6 (obvious) | 4 | 2.5 | 1.5 | 1.0 |
| Decision timing | frozen at release + 1.0 s | frozen at release + 0.6 s | live, 4.5 s window | live, 3.0 s | live, 2.0 s |
| Speed arrows | yes | yes | no | no | no |
| Exceptions in pool | no | no | +shorthanded | +touched, +goal | all |
| Playback speed (x) | 0.6 | 0.6 | 0.7 | 0.8 | 1.0 |
| Hints | 2 | 1 | 1 | 0 | 0 |
| Ruleset option | hybrid | hybrid | hybrid | +touch-up label | +touch-up label |

Ties (gap < 0.3 ft/s equivalent) never appear. **Default level for lesson `rules-icing-race` is 2.**

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
        "icing-starter",
        "icing-advanced"
      ]
    },
    "rounds": {
      "type": "integer",
      "minimum": 3,
      "maximum": 6,
      "default": 3,
      "description": "Number of rounds in the session."
    },
    "ruleset": {
      "type": "string",
      "enum": [
        "hybrid",
        "touch-up"
      ],
      "default": "hybrid"
    },
    "decisionWindowMs": {
      "type": "integer",
      "minimum": 0,
      "maximum": 6000,
      "default": 0
    },
    "playbackSpeed": {
      "type": "number",
      "minimum": 0.4,
      "maximum": 1.0,
      "default": 0.6
    },
    "showSpeedArrows": {
      "type": "boolean",
      "default": true
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
  "seed": 7,
  "scenarioSetId": "icing-starter",
  "rounds": 3,
  "ruleset": "hybrid",
  "decisionWindowMs": 0,
  "playbackSpeed": 0.6,
  "showSpeedArrows": true
}
```

## 11. Scenario data set
Each scenario defines shooter position, puck speed, chaser and retriever start positions and speed curves, game state (manpower), and any touches. Coordinates in rink feet as in the offside sim. **Pool size N = 12** (rounds x 3 minimum is 9). Scenarios ship as `icing-starter.json / icing-advanced.json` inside the sim's Addressables bundle (JSON, array of scenario objects). Selection is deterministic per `seed`: shuffle with `Rng(seed)`, filter by the difficulty tags in section 9, take `rounds` scenarios, never repeating a `teaches` concept back-to-back if avoidable.

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| ICE-01 | 5-on-5. Puck from own blue line. Retriever 12 ft ahead of the chaser at the dot line | Icing | hybrid-icing | basic |
| ICE-02 | 5-on-5. Chaser is 9 ft ahead of retriever at the dot line | Wave it off | hybrid-icing | basic |
| ICE-03 | Shooting team is shorthanded (4-on-5) and dumps it from its own zone | Wave it off (no icing) | penalty-kill | exception |
| ICE-04 | Power-play team (5-on-4) shoots from the red line; retriever ahead | Icing | icing | exception |
| ICE-05 | Puck is shot from just over the red line (on the far side) | Wave it off (not from behind center) | icing | basic |
| ICE-06 | A teammate deflects the puck in the neutral zone before it crosses the goal line | Wave it off | icing | exception |
| ICE-07 | Puck goes across the goal line, retriever ahead; after the whistle the icing team wants to change | Icing, and the team cannot change | line-change | basic |
| ICE-08 | Puck heading into the net | Wave it off (goal) | icing | exception |
| ICE-09 | Close race that swings: chaser gains 4 ft in the last 30 ft | Wave it off (chaser wins the dot line) | hybrid-icing | hard |
| ICE-10 | Goalie starts to leave the crease to play the puck | Wave it off | icing | exception |
| ICE-11 | Puck touched by the defending team at the blue line before the goal line | Wave it off | icing | exception |
| ICE-12 | Touch-up ruleset variant: retriever ahead but has not touched the puck yet (labelled option) | Wave it off until touched, then icing | icing | touch-up |

Fully written scenarios (canonical data format; the rest follow the same shape):

**ICE-01 `clear-icing` (tags: basic)**

```json
{
  "scenarioId": "ICE-01",
  "title": "Icing, clean",
  "manpower": "5v5",
  "rule": "hybrid",
  "teaches": [
    "hybrid-icing",
    "icing"
  ],
  "correct": "icing",
  "puck": {
    "release": {
      "x": -24.0,
      "y": 10.0
    },
    "speedFps": 78.0,
    "crossesGoalLineAt": 1.55
  },
  "chaser": {
    "team": "shooter",
    "start": {
      "x": -30.0,
      "y": 8.0
    },
    "speedFps": 26.0
  },
  "retriever": {
    "team": "opponent",
    "start": {
      "x": 48.0,
      "y": -6.0
    },
    "speedFps": 27.0
  },
  "events": {
    "retrieverAtDotLine": 1.35,
    "chaserAtDotLine": 2.6
  },
  "decisionAt": 1.0,
  "copyKey": "icing-correct"
}
```

**ICE-02 `chaser-wins` (tags: basic)**

```json
{
  "scenarioId": "ICE-02",
  "title": "Chaser first",
  "manpower": "5v5",
  "rule": "hybrid",
  "teaches": [
    "hybrid-icing"
  ],
  "correct": "wave-off",
  "puck": {
    "release": {
      "x": -20.0,
      "y": -12.0
    },
    "speedFps": 74.0,
    "crossesGoalLineAt": 1.65
  },
  "chaser": {
    "team": "shooter",
    "start": {
      "x": 25.0,
      "y": -10.0
    },
    "speedFps": 29.0
  },
  "retriever": {
    "team": "opponent",
    "start": {
      "x": 72.0,
      "y": 6.0
    },
    "speedFps": 25.0
  },
  "events": {
    "chaserAtDotLine": 1.55,
    "retrieverAtDotLine": 2.2
  },
  "decisionAt": 1.0,
  "copyKey": "icing-waved"
}
```

**ICE-03 `shorthanded-ice` (tags: exception)**

```json
{
  "scenarioId": "ICE-03",
  "title": "Free to ice",
  "manpower": "4v5",
  "rule": "hybrid",
  "teaches": [
    "penalty-kill",
    "icing"
  ],
  "correct": "wave-off",
  "puck": {
    "release": {
      "x": -70.0,
      "y": 0.0
    },
    "speedFps": 85.0,
    "crossesGoalLineAt": 2.3
  },
  "chaser": {
    "team": "shooter",
    "start": {
      "x": -60.0,
      "y": 5.0
    },
    "speedFps": 26.0
  },
  "retriever": {
    "team": "opponent",
    "start": {
      "x": 55.0,
      "y": -8.0
    },
    "speedFps": 27.0
  },
  "events": {
    "retrieverAtDotLine": 1.05,
    "chaserAtDotLine": 3.4
  },
  "decisionAt": 1.0,
  "copyKey": "icing-shorthanded"
}
```

Remaining scenarios follow the same shape. Rules for new ones: the arrival-time gap at the dot line is >= 0.25 s (unambiguous); each exception scenario sets `exception` (`shorthanded`, `deflected`, `goal`, `from-far-side`, `touched`, `goalie`); `copyKey` maps to section 12. Only jersey numbers, y offsets (+/-4 ft) and small speed jitter (+/-0.5 ft/s, never crossing the 0.25 s gap rule) vary with the seed.

## 12. Freeze / explain moments
Copy pools are keyed by `copyKey`; every string satisfies title <= 6 words, body <= 45 words.

**icing-correct**
- Trigger: Icing call on a clean race (ICE-01, 04, 07)
- What freezes: Both skaters at the dot line
- Camera: `top-down`
- Callouts: Gold dot line; retriever ringed with a check badge; times "1.35 s" and "2.60 s"
- Correct outcome: Title "Nice read.". Body: "Their skater gets to the dot line first, so the linesman whistles it dead. The shooting team can't change and takes the faceoff in its own end. Tired legs, ouch." Say this: "Their guy wins the race to the dots. That's icing."
- Incorrect outcome: Title "Not quite.". Body: "The other skater would reach the dot line first, so that is icing. Waving it off would let a free puck race turn into a collision on the boards." Say this: "Their guy wins the race to the dots. That's icing."

**icing-waved**
- Trigger: Wave-off on a chaser-wins race (ICE-02, 09)
- What freezes: Chaser reaching the dot line
- Camera: `top-down`
- Callouts: Chaser highlighted gold with check badge; retriever behind by the gap shown in feet
- Correct outcome: Title "Nice read.". Body: "The chasing skater is ahead at the dot line, so no icing. Play continues into a battle for the puck. Hybrid icing lets the leader keep the race honest." Say this: "He got there first, so no icing."
- Incorrect outcome: Title "Not quite.". Body: "The shooting team's skater is ahead at the dots, so icing is waved off. Blowing the whistle early takes away a fair race." Say this: "He got there first, so no icing."

**icing-shorthanded**
- Trigger: Exception scenarios (ICE-03, 05, 06, 08, 10, 11)
- What freezes: The moment the exception occurs (manpower banner, red-line position, deflection, or net)
- Camera: `top-down`, then `blueline-cam`
- Callouts: Exception tag pinned to the exact spot: a "4v5" banner, a red-line marker, a deflection ring, or the net
- Correct outcome: Title "Nice read.". Body: "Exception spotted. Shorthanded teams may clear the puck the length of the ice. A shot from the far side of center, a touch, or a goal also means no icing." Say this: "They're shorthanded, so it's not icing."
- Incorrect outcome: Title "Not quite.". Body: "That was one of the exceptions. A shorthanded team, a shot from the far side of center, a deflection or a goal all stop icing from being called." Say this: "They're shorthanded, so it's not icing."

**icing-nochange**
- Trigger: After an icing call (ICE-07)
- What freezes: Faceoff setup
- Camera: `top-down` on the icing team's bench
- Callouts: Bench door with a lock icon; the on-ice line shows a fatigue bar
- Correct outcome: Title "Nice read.". Body: "After icing the offending team can't change players. Their tired line stays on for the faceoff in their own end. That is the whole punishment." Say this: "They iced it, so they can't change."
- Incorrect outcome: Title "Not quite.". Body: "The team that iced the puck can't change lines. That is the real cost: tired skaters stay out for the faceoff in their own zone." Say this: "They iced it, so they can't change."

## 13. Scoring & mastery signals
- **Round score:** 1.0 for the correct call; 0.5 when the learner picks the right outcome but only after the window is 75% used (right idea, slow); 0 otherwise.
- **Score (0-100):** `round(mean(roundScore) * 100)`, minus `5` per hint used (floor 0). **Accuracy:** correct rounds / rounds played. **Outcome ids:** `round-1`..`round-N`, `success` = round fully correct, `label` = scenario title, `value` = scenarioId.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (in `mistakes[].description`) |
|---|---|---|
| Whistled a race the chaser wins | hybrid-icing | The shooting team's skater reached the dot line first, so icing is waved off. |
| Waved off a clear icing | icing | The retriever reached the dot line first, so hybrid icing applies. |
| Called icing on a shorthanded team | penalty-kill | A team that is shorthanded may ice the puck without a penalty. |
| Called icing on an exception | icing | A deflection, a shot from the far side of center, or a goal cancels icing. |
| Forgot the changes restriction | line-change | The team that iced may not change players before the faceoff. |

**Mastery signals**

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct race call | hybrid-icing | +0.20 | Judged the race to the dot line correctly. |
| Correct exception call | icing | +0.20 | Spotted an exception to icing. |
| Correct shorthanded wave-off | penalty-kill | +0.20 | Knew a shorthanded team can ice freely. |
| Correct no-change answer | line-change | +0.15 | Remembered the icing team cannot change. |
| Wrong race call | hybrid-icing | -0.15 | Misjudged who reaches the dot line first. |
| Wrong exception call | icing | -0.15 | Missed an icing exception. |

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
| Decision timeout (levels 3-5) | Card: "The puck slid by and you froze. Happens to linesmen too." then explain. | Round marked failed, mistake tagged `timeout` | No |
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
- **Tap-only:** Inputs are taps only. A "Slow play" toggle sets playback speed to 0.4x. Timed windows can be disabled (untimed) for the accessibility profile.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Accessible native fallback lesson: **`rules-icing-basics` and `rules-icing-exceptions` (native `binary-call` and `decision-scenario` on diagrams)** (a separate, designed native exercise set; not a port).
- Timed windows can be turned off (`decisionWindowMs: 0`); speed arrows are shapes with a numeric label.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Decision available | soft stick tap on ice | none | -18 dB |
| Correct call | short rising two-note chime (original) | light success | -14 dB |
| Incorrect call | muted low thud | warning (single) | -16 dB |
| Freeze | crowd ambience ducks 80%, ice hiss | none | -20 dB |
| Whistle and stoppage | original pea-whistle plus a soft skate-scrape | warning (single) on a wrong call, light success on correct | -15 dB |
| Summary | two-note resolve | light success if score >= 60 | -14 dB |

All sounds respect `soundEnabled`; all haptics respect `hapticsEnabled`. Ambient crowd is a looped procedural noise bed, no recorded broadcast audio.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Full rink | procedural | original | ~3k tris | dot line overlay only in explain |
| Characters (shooter, chaser, retriever, linesman) | procedural | original | ~800 tris each | numbered striped/solid jerseys |
| Puck and overlays | procedural | original | small | arrows are line meshes |
| Audio | synthesized | original-swoond | < 1 MB | - |

- **Overlay styling:** per `docs/astra/ART_DIRECTION.md`: rose = you/act, gold = earned/correct, dim everything not being explained, one focal idea per frame. Rink markings are procedural; NHL and team logos are never used (jerseys are generic stripes/solids with numbers).
- **Addressables bundle:** `sim.hockey.rules.icing-call.v1` , expected about 3 MB compressed (<= 25 MB budget).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply and are not loosened: 60 fps on iPhone 13-class (p5 >= 50), peak Unity memory < 150 MB, cold launch to `ready` < 2 s (4 s first load), bundle <= 25 MB, draw calls <= 150, <= 60k on-screen triangles, <= 15 materials, textures <= 8 MB VRAM, thermal state not above "fair" over a 3-minute session.
Tighter per-sim limits: Long-distance camera pan must keep draw calls < 100; race evaluator < 0.2 ms per frame.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus counters:
| key | meaning |
|---|---|
| hintsUsed | total Hint uses |
| decisionLatencyMsAvg | mean time from Decision open to input |
| scenarioIds | comma-joined scenario ids played (no free text) |
| raceGapMsAvg | mean arrival-time gap of the scenarios played |
| windowUsedPct | average share of the decision window used |

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
- **AC-10 (race evaluator):** For every scenario, `RaceEvaluator` returns arrival times matching the authored `events` within 50 ms.
- **AC-11 (exceptions):** The pool contains at least one scenario for each exception (shorthanded, deflected, goal, from-far-side, touched, goalie) and each is marked `correct: wave-off`.
- **AC-12 (no ties):** No scenario has an arrival-time gap below 0.25 s (data lint).
- **AC-13 (change rule):** After a correct icing call in ICE-07 the bench door shows the lock state and no Change input exists.
- **AC-14 (ruleset label):** The `touch-up` scenario is only drawn when `configuration.ruleset = "touch-up"`.

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
| AC-10 | EditMode | RaceEvaluator_MatchesAuthoredTimes |
| AC-11 | EditMode | ScenarioPool_CoversAllExceptions |
| AC-12 | EditMode | ScenarioLint_NoTies |
| AC-13 | PlayMode | Icing_LocksBenchAfterCall |
| AC-14 | EditMode | Ruleset_TouchUpOnlyWhenConfigured |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Confirm NHL Rule 81 wording for hybrid icing ties and the position that decides the race (dot line vs actual reach) before locking ICE-09 | Claude (content), Product | Yes for ICE-09 |
| 2 | Which leagues use hybrid vs touch-up icing (NHL, PWHL, IIHF for 2026-27)? Ruleset option is generic until verified | Claude (content) | No |
| 3 | Should the goalie exception (ICE-10) be kept? Verify current rule text | Claude (content) | No |
| 4 | Camera preset `broadcast-high-behind` acceptable for portrait framing of a 200 ft rink? | Astra | No |
