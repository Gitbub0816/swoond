# Offside Line Read (`soccer.offside.line-read.v1`)
## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `soccer.offside.line-read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven, see section 6) |
| Authors / date | Swoon'd course design (soccer) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |
## 2. Course & lesson links

- `courseId`: `soccer`
- Unit `offside-and-var`, lesson `offside-04`: difficulty 2 default, positions and body parts
- Unit `offside-and-var`, lesson `offside-07`: difficulty 4 default, active play, deflection vs deliberate play, restarts
- CDS Interaction plan row: `Offside line reading (sim) | offside-position, level-is-onside, offside-body-parts, active-play, deliberate-play` (`docs/courses/soccer/CDS.md` section 12).
- Manifest entry: `docs/courses/soccer/manifest.json` -> `unitySimulations[]` (`soccer.offside.line-read.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `goal`, `out-of-play`, `foul`.
## 3. Learning objective(s) & concepts taught

- **Learner-facing objective:** You can freeze a pass in your head and tell who is offside, who is level, and who is not involved, without being fooled by an arm or a toenail.

| conceptId | term | After this the learner can... |
|---|---|---|
| offside-position | Offside position | Say who is nearer the goal line than both the ball and the second-last opponent at the moment of the pass. |
| level-is-onside | Level is onside | Call a level attacker onside and explain why. |
| offside-body-parts | Body parts for offside | Ignore arms and hands; use head, body and feet. |
| offside-offence | Offside offence | Tell a position from an offence. |
| active-play | Involved in active play | Say when an offside-positioned attacker is not involved. |
| deliberate-play | Deliberate play | Separate a defender's deliberate touch from a deflection. |
| no-offside-restarts | No offside from restarts | Recognise goal kicks, throw-ins and corners cannot be offside. |

**Out of scope:** Semi-automated tracking technology internals, the referee's signalling, the offside trap (taught in `soccer.defending.line-height.v1`) and the debate over rule changes.
## 4. Why Unity (tier justification)

| Rubric signal | Answer |
|---|---|
| Spatial reasoning | Yes: offside is a relationship between the positions of attackers, defenders and ball at one instant. |
| Movement over time | Yes: runs and the pass timing decide who is offside; the learner must pick the exact frame. |
| Physics / camera perspective | Yes: a top-down line versus a broadcast angle shows why parallax fools fans. |
| Timing in a scene | Yes: the pass frame is dynamic. |
| Native fallback | `binary-call` on a static diagram and `hotspot-tap` teach the definition but lose the moving-frame skill and parallax. |

A native binary-call can teach the definition, and we use it in lessons offside-01 to offside-03. It cannot make the learner watch runs unfold, pick the moment of the pass, or see a line rendered from two camera angles, which is exactly where fans and referees disagree. Tier A is justified for the read-the-frame skill only.
## 5. Player fantasy & core loop

**Fantasy:** You are the assistant referee on the touchline, one eye on the last defender, one eye on the ball.

1. Prompt card: "Freeze the pass. Who's offside?" (12 words or fewer).
2. Playing: attackers make runs, a midfielder strikes a pass.
3. Decision: at the frame of ball contact the sim freezes; the learner taps every attacker they think is in an offside position (or Nobody), then taps Confirm.
4. Executing (L3+): a second question for each tapped attacker: Involved / Not involved.
5. Freeze and Explain: the offside line and body-part markers are drawn; the correct answer pulses gold.
6. Line to say out loud: e.g. "Level is onside."

Session length target: about 3 minutes; 3 rounds by default (`scenarioCount` 3-9).
## 6. Scene & entities

- **Environment:** `soccer_pitch` (procedural: line markings, goals, six-yard box, penalty area, centre circle; grass in two-tone `court` stripes). Coordinates: metres, origin at the centre spot, `x` across the pitch (-34..34), `z` along it towards the attacking goal (-52.5..52.5).
- **Camera presets:** `broadcast-side` (Playing, replay), `top-down` (Decision, Explain), `line-cam` (parallel to the goal line, Explain L4-5 to show parallax).

| id | Game Kit primitive / sport module | role | key parameters |
|---|---|---|---|
| attacker_01..05 | `Character` (role attacker) | attackers | team Team A, `x`,`z`, per-body-part z (head, torso, feet, arm), run path |
| defender_01..05 | `Character` (role defender) | defenders | team Team B, `x`,`z`, holds a line or steps |
| keeper_01 | `Character` (role keeper) | last line | `z` near goal line unless `keeperUp=true` |
| passer_01 | `Character` | player striking the ball | `x`,`z`, `strikeAtSeconds` |
| ball_01 | `Ball` | pass | start, target, `Throw(target, arcHeight, flight)` |
| offsideLine | `Zone` + `Path` | teaching overlay | z of second-last defender's scoring body part; shows at Explain |
| markers | `Target` | tappable attacker rings | `IsCorrect`, `ConceptId` |
| decision | `DecisionPoint` | multi-select | options = attackers + Nobody |
| explain | `Explanation` |  | callouts |

**Reused:** `Character`, `Ball`, `Path`, `Zone`, `Target`, `DecisionPoint`, `Explanation`, `Highlight`, `SlowMotion`, `CameraRig`, `TouchController`, `Score`, `Replay`, `Hint`.

**New (needs justification and reuse plan):** `OffsideLine` overlay (Football module cousin: `Swoond.Sports.Soccer.OffsideLine`) plus `SoccerPitch` environment builder: both reusable by the line-height sim.

**Initial layout (top-down, attacking goal at the top):**

```
        goal
   ---------------
   |    D4  D5   |   <- defenders hold the line (z = 34.5)
   |  A9 (offside?) |
   |   A10  A11   |   <- attackers
   |       ball   |
   |   passer      |
   ---------------
```
## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Tap attacker ring | Toggle selection of an attacker | ring diameter >= 56 pt (44 pt min) | ring fills rose; selection haptic soft tap |
| Tap Nobody | Select no one | button >= 56 pt | button fills rose |
| Tap Confirm | Submit | button >= 56 pt | freeze resumes |
| Tap Involved / Not involved | L3+ second question | 2 buttons >= 56 pt | chosen button outlined rose |
| Long-press attacker (L1-2) | Show mini offside line hint | hold 300 ms | hint recorded (`Hint`) |

- **Tap-only alternative scheme** (`TouchController.SetScheme(TapOnly)`): all gestures are already taps; the long-press hint becomes a persistent Hint button in the corner.
- **Orientation / safe area:** portrait; Unity honours `runtime.safeAreaInsets`; HUD sits inside the safe area, controls in the lower 40 percent for thumb reach.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation dialog, permission prompts, lesson chrome. The Unity close (X) affordance emits `requestExit(user-quit)`; native confirms.
## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit condition / next |
|---|---|---|---|
| Loading | `launch` received | Validate contract, `simulationId`, `configuration` (section 10); load `scenarioSetId`; build the pitch from code | Assets ready: emit `ready`; invalid: `error CONFIG_INVALID`; asset missing: `error ASSET_LOAD_FAILED` |
| Intro | `ready` sent | One-line prompt card (Freeze the pass. Who's offside?); camera to establishing preset; 2 s | Auto or tap-to-skip -> Playing |
| Playing | Round `i` starts (emit `progress` = i/N) | Attackers run, the passer strikes the ball; the scenario's `strikeAtSeconds` is used | Decision moment reached -> Decision |
| Decision | Trigger frame reached | Time slows to 0.15x then `DecisionPoint` opens; options are attackers plus Nobody; `TimeLimit` from difficulty | Choice made or `timeLimit` expires -> Executing |
| Executing | Decision recorded | Play resumes at 1x showing the consequence of the choice (the ball reaches its target and the assistant flag goes up or stays down); round outcome recorded in `Score` | Consequence resolved -> Freeze |
| Freeze | Consequence resolved | `SlowMotion.Freeze()` (250 ms ease, or hard cut in reduced motion); dim non-focal entities 35 percent; gold pulse on the correct element | -> Explain |
| Explain | Freeze complete | `Explanation` card with callouts appears one at a time (section 12); optional `Replay` in slow-mo; emit `checkpoint` `round-i` | Tap Continue -> next round or Summary |
| Summary | Last round explained | Numerals count up 600 ms; per-round pips; one say-this line; no confetti | -> Done |
| Done | Summary dismissed | Emit exactly one `result` (validates against `simulation-result.schema.json`), then `requestExit(completed)` | Native dismisses Unity |
| Paused | `pause` command | Freeze sim time, timers, audio; do not advance `DecisionPoint.TimeLimit` | `resume` -> previous state |
| Aborted | `abort` or Unity X | Stop; emit `result` with `aborted=true`, `abortReason`, partial `outcomes`, `xpEarned=0`; then `requestExit` | Native dismisses Unity |

**Bridge events per state:** `ready` (end of Loading), `progress` (start of each round, max 4/s), `checkpoint` (end of each Explain), `result` then `requestExit` (Done/Aborted). `pause`/`resume`/`abort` are handled in any state.
## 9. Difficulty levels 1-5

| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Decision time limit (s) | none | 12 | 8 | 6 | 4 |
| Attackers in scene | 2 | 3 | 4 | 5 | 5 |
| Margin between line and body part (m) | 1.5 | 0.8 | 0.4 | 0.2 | 0.1 |
| Mini-line hint available | yes (auto) | yes (long-press) | yes (1 use) | no | no |
| Line-cam parallax explain | no | no | optional | yes | yes |
| Active-play second question | no | no | yes | yes | yes |
| Restart / deflection scenarios | no | goal-kick, throw-in | yes | yes | yes |
| Scenario pool tag | `basic` | `basic`,`bodyparts` | `+active` | `+deflection` | `all` |

Level 1 is passable by a true beginner: 2 attackers, a 1.5 m margin and an automatic mini-line. **Defaults:** lesson `offside-04` launches at difficulty 2; lesson `offside-07` at difficulty 4.
## 10. Configuration schema

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "type": "object",
  "properties": {
    "seed": {
      "type": "integer",
      "minimum": 0
    },
    "scenarioSetId": {
      "type": "string",
      "enum": [
        "offside-starter",
        "offside-active-play",
        "offside-var-room"
      ],
      "default": "offside-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 3,
      "maximum": 9,
      "default": 3
    },
    "showLineHint": {
      "type": "boolean",
      "default": true
    },
    "cameraMode": {
      "type": "string",
      "enum": [
        "auto",
        "top-down",
        "broadcast"
      ],
      "default": "auto"
    },
    "includeActivePlay": {
      "type": "boolean",
      "default": false
    },
    "includeRestarts": {
      "type": "boolean",
      "default": false
    }
  },
  "additionalProperties": false
}
```

**Valid example:**

```json
{
  "seed": 42,
  "scenarioSetId": "offside-starter",
  "scenarioCount": 3,
  "showLineHint": true,
  "includeActivePlay": false,
  "includeRestarts": false
}
```

Any value outside the ranges, an unknown `scenarioSetId`, or `scenarioCount` greater than the set size yields `error CONFIG_INVALID` (`recoverable=false`). Unknown extra keys are ignored by the bridge rules, but this schema sets `additionalProperties: false` so authoring typos are caught in CI.
## 11. Scenario data set

Format: JSON, one file per `scenarioSetId` under the sim's Addressables bundle (`Scenarios/<setId>.json`). Sets: `offside-starter` (10 scenarios), `offside-active-play` (10), `offside-var-room` (8). Total authored: 28, and N = rounds x 3 minimum is 9 (met). Selection is deterministic per seed. Coordinates in metres as defined in section 6; `bodyParts` are `z` values of the furthest-forward scoring part (head/torso/feet) and the arm for the trap; `lineZ` is derived (second-last defender's body part).

### off-001 Clear offside

```json
{
  "scenarioId": "off-001",
  "restart": "open-play",
  "ball": {
    "start": [
      0,
      15
    ],
    "target": [
      6,
      38
    ]
  },
  "strikeAtSeconds": 3.2,
  "attackers": [
    {
      "id": "A9",
      "x": 6,
      "z": 38.0,
      "bodyParts": {
        "head": 38.4,
        "torso": 38.0,
        "feet": 37.6,
        "arm": 38.6
      },
      "receives": true
    },
    {
      "id": "A11",
      "x": -20,
      "z": 33.0,
      "bodyParts": {
        "head": 33.2,
        "torso": 33.0,
        "feet": 32.7,
        "arm": 33.4
      }
    }
  ],
  "defenders": [
    {
      "id": "D4",
      "x": 4,
      "z": 34.5
    },
    {
      "id": "D5",
      "x": -8,
      "z": 34.4
    }
  ],
  "keeper": {
    "z": 51.5
  },
  "expected": {
    "offside": [
      "A9"
    ],
    "involved": [
      "A9"
    ],
    "outcome": "flag"
  },
  "teaches": [
    "offside-position",
    "offside-offence"
  ],
  "tags": [
    "basic"
  ]
}
```

### off-002 Level is onside

```json
{
  "scenarioId": "off-002",
  "restart": "open-play",
  "ball": {
    "start": [
      -5,
      10
    ],
    "target": [
      8,
      30
    ]
  },
  "strikeAtSeconds": 3.0,
  "attackers": [
    {
      "id": "A10",
      "x": 8,
      "z": 30.0,
      "bodyParts": {
        "head": 30.0,
        "torso": 30.0,
        "feet": 30.0,
        "arm": 30.1
      },
      "receives": true
    }
  ],
  "defenders": [
    {
      "id": "D5",
      "x": 10,
      "z": 30.0
    },
    {
      "id": "D4",
      "x": -6,
      "z": 30.2
    }
  ],
  "keeper": {
    "z": 51.5
  },
  "expected": {
    "offside": [],
    "outcome": "play-on"
  },
  "teaches": [
    "level-is-onside"
  ],
  "tags": [
    "basic"
  ]
}
```

### off-003 Arm ahead, body behind

```json
{
  "scenarioId": "off-003",
  "restart": "open-play",
  "ball": {
    "start": [
      10,
      12
    ],
    "target": [
      -3,
      29.5
    ]
  },
  "strikeAtSeconds": 3.4,
  "attackers": [
    {
      "id": "A7",
      "x": -3,
      "z": 29.5,
      "bodyParts": {
        "head": 29.7,
        "torso": 29.6,
        "feet": 29.5,
        "arm": 30.4
      },
      "receives": true
    }
  ],
  "defenders": [
    {
      "id": "D3",
      "x": -1,
      "z": 29.9
    },
    {
      "id": "D5",
      "x": 9,
      "z": 29.9
    }
  ],
  "keeper": {
    "z": 51.5
  },
  "expected": {
    "offside": [],
    "outcome": "play-on",
    "note": "arm is ahead of the line but arms do not count"
  },
  "teaches": [
    "offside-body-parts"
  ],
  "tags": [
    "bodyparts"
  ]
}
```

**All scenarios (summary):**

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| off-004 | Attacker A11 offside on far side, pass goes to onside A9 who scores | A11 offside position; not involved -> goal stands | active-play | active |
| off-005 | Shot deflects off a defender to an attacker who was ahead | Still offside (deflection) | deliberate-play | deflection |
| off-006 | Defender deliberately heads back, attacker ahead scores | Onside (deliberate play resets) | deliberate-play | deflection |
| off-007 | Goal kick to an attacker ahead of everyone | Onside | no-offside-restarts | restart |
| off-008 | Throw-in received ahead of last defender | Onside | no-offside-restarts | restart |
| off-009 | Attacker behind the ball but ahead of the last defender receives a pass from a teammate ahead | Onside (behind the ball) | offside-position | basic |
| off-010 | Keeper sweeping outside his box; attacker level with the last outfield defender (the second-last opponent) | Onside (level with the second-last opponent) | level-is-onside | var-room |

**Generation rules for scenarios beyond the authored set:** Sample base templates with random offsets. For each template produce `n` variants: choose margin = the difficulty's margin +/- 25 percent, a random side (mirror x), a random runner count (2-5) and jitter defender lines by up to 0.3 m. Reject a variant when its margin is below the difficulty's minimum or when the expected label would change unintentionally. The expected label is computed by the pure function `EvaluateOffside(scenario)` (EditMode tested), never stored by hand for generated scenarios.
## 12. Freeze / explain moments

| Trigger | What freezes / camera | Callouts | Title (<= 6 words) | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|
| Correct: offside call | Freeze at pass frame; top-down | Gold line at last defender; rose ring on attacker; distance arrow | Ahead of the line | At the moment of the pass, his feet were nearer the goal line than the last defender and the ball. That's an offside position. | "He was ahead of the last defender when the ball left." |
| Correct: level | Freeze; top-down | Two rings aligned on the line; bracket 'level' | Level is onside | He's exactly level with the defender, so he's onside. The attacker gets the benefit of the doubt when it is that close. | "Level is onside." |
| Wrong: arm ahead | Freeze; line-cam | Arm outlined muted; head/torso/feet outlined gold | Arms don't count | His arm was over the line, but head, body and feet were behind. Only those count, so he's onside. Sneaky, I know. | "Arms don't count for offside." |
| Wrong: not involved | Replay slow-mo | Attacker ringed rose with a dashed 'not involved' ring; ball path gold | Position isn't an offence | He was offside, but he didn't touch the ball or block anyone. Being in the position isn't an offence; getting involved is. | "He was in an offside position, but not involved." |
| Wrong: deflection | Freeze; top-down | Arrow from defender's foot; label 'deflection' | Deflection isn't deliberate | The defender's touch was a block, not a deliberate play, so it doesn't reset offside. It's still an offside offence. | "That was a deflection, not a deliberate play." |
| Wrong: restart | Freeze; broadcast | Ball at goal-kick spot, label 'No offside here' | No offside from restarts | You can't be offside straight from a goal kick, throw-in or corner. Stand where you like. | "You can't be offside from a goal kick." |
| Timeout | Freeze; top-down | Line drawn for you | Out of time | No worries. Here's the line. Take your time next round; the pass frame is all that matters. | "Look at the frame the ball is kicked." |

All copy is Swoon'd voice: cheeky coach, short sentences, never mean, never about the crush. Titles for the outcome are prefixed by the app-level banner "Nice read." (correct) or "Not quite." (wrong); the sim shows the title below as the card title. Never rely on colour alone (pair with the banner text, icon and the shape/pattern second channel).
## 13. Scoring & mastery signals

- **Round score:** 100 if the selected set equals the expected set (and at L3+ each active-play answer is right); 50 if the offside set is right but the active-play answer is wrong, or exactly one attacker is missed or added; 0 otherwise. **Session score:** mean of rounds, rounded. **Accuracy:** rounds scoring 100 / rounds.
- **Outcome ids:** `round-1`..`round-N`.
**Mistake -> conceptId mapping:**

| mistake | conceptId | description text |
|---|---|---|
| Called an onside attacker offside (level) | level-is-onside | Called a level attacker offside. |
| Called an onside attacker offside (arm) | offside-body-parts | Counted an arm as offside. |
| Missed an offside attacker | offside-position | Missed an attacker ahead of the last defender. |
| Flagged a not-involved attacker | active-play | Called an uninvolved offside position an offence. |
| Ignored the deflection rule | deliberate-play | Treated a deflection as a reset. |
| Flagged at a restart | no-offside-restarts | Called offside from a goal kick or throw-in. |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; hints used halve positive deltas at native):

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct round, offside-position scenario | offside-position | +0.20 | Called a clear offside correctly. |
| Correct round, level scenario | level-is-onside | +0.20 | Called level as onside. |
| Correct body-part scenario | offside-body-parts | +0.20 | Ignored the arm. |
| Correct active-play answer | active-play | +0.20 | Said not involved. |
| Correct deflection/deliberate scenario | deliberate-play | +0.20 | Split deflection from deliberate. |
| Correct restart scenario | no-offside-restarts | +0.15 | Recognised a restart. |
| Any mistake row | (mapped concept) | -0.15 | Mistake description text. |

**Mapping to `SimulationResult`:** `outcomes[]` = one entry per round (`id` = `round-N`, `success`, `label` = scenario id, `value` = decision latency ms); `mistakes[]` = one entry per mistake row above with `at` = active ms; `masterySignals[]` = the table above; `score` = mean round score; `accuracy` = correct rounds / rounds; `replayAvailable` = true after any completed round.
## 14. XP & hearts

- `xpEarned` proposal: +10 per correct round (+5 per partial) +40 for finishing all rounds; +10 bonus if `accuracy` = 1 and no hints. Native clamps to the lesson's XP budget.
- `heartsLost`: 1 if fewer than 34 percent of rounds are correct (session failed), otherwise 0; never more than 1 per session; 0 on abort, timeout or error.
- `replayAvailable`: true once at least one round has been explained (the `Replay` primitive holds the last 3 rounds); false on early abort before the first Freeze.
## 15. Failure states

| Situation | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round | Explain moment with the wrong choice in rose outline and the right one in gold, plus the standard copy | `outcomes[i].success=false`, mistake + negative signal | No (counts toward session) |
| Failed session (< 34 percent correct) | Summary with a warm 'try again' line and the concept to revisit | `completed=true`, `accuracy < 0.34` | 1 lost |
| Decision timeout | Round resolves as 'no call'; explain moment shows what a good call was; never a dead-end | `success=false`, mistake tagged `timeout` | No extra |
| Aborted (user X) | Native confirmation; Unity exits | `aborted=true`, `abortReason=user-quit`, `xpEarned=0` | No |
| Backgrounded > 120 s | Native aborts; Unity exits | `abortReason=backgrounded-too-long` | No |
| Asset missing | Native re-downloads and relaunches | `error ASSET_LOAD_FAILED` (recoverable) | No |
| Invalid config | Native skips the activity | `error CONFIG_INVALID` (non-recoverable) | No |
## 16. Accessibility

- **Reduced motion:** freeze is a hard cut, slow-mo replay is replaced by a still sequence of 3 key frames, camera cuts instead of sweeps, no screen shake, pulses become static rings.
- **Haptics off:** all feedback is visual/audio only.
- **Colour-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): team kits differ by luminance and by pattern (stripes vs solid) plus a shirt number; correct/wrong pair with a tick/cross icon and the banner text; zones use hatching in addition to tint.
- **Text scale:** all overlay text follows `textScale` (up to 2.0); explain cards reflow; minimum 13 pt (11 pt eyebrow only).
- **Tap-only scheme:** see section 7; no drag is required anywhere.
- **VoiceOver/TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson: `offside-01`..`offside-03` (binary-call and hotspot-tap) cover the same concepts; the CDS names `offside-native-fallback` as the accessible route when Unity is unavailable.
## 17. Audio & haptics

| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Round start | soft whistle blip | none | -18 dB |
| Decision open | low tick | soft tap | -20 dB |
| Correct | warm two-note chime | light success | -16 dB |
| Wrong | dull muted thud | warning | -18 dB |
| Freeze | short muffled whoosh | soft tap | -20 dB |
| Summary numerals | tick per 10 points | none | -24 dB |
| Crowd bed | quiet stadium murmur (loop) | none | -30 dB |

All cues honour `soundEnabled` and `hapticsEnabled`. No music.
## 18. Art & asset list

| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Pitch, lines, goals | procedural | original | ~2k tris, 0 textures | two-tone stripes |
| Players (capsule figures with shirt numbers) | procedural | original | ~600 tris each | kit patterns for colour-blind mode |
| Offside line overlay | procedural | original | line renderer | gold, animated dash only if motion allowed |
| Scenario JSON | data | original | < 200 KB | 28 scenarios |
| Fonts | external | Instrument Serif and Geist (OFL) subset | < 300 KB |  |

Overlay styling per `docs/astra/ART_DIRECTION.md` section 4: rose = you/act, gold = earned/correct, zones translucent with `strokeStrong` borders, callouts on `surface` cards with 20 px radius. **Addressables bundle:** `sims-soccer-offside-line-read` expected <= 6 MB (scenario JSON + fonts subset; no external textures).
## 19. Performance budget

Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (p5 >= 50 fps), < 150 MB resident, cold launch < 2 s, per-sim download <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state <= fair over 3 minutes. **Tighter for this sim:** At most 12 characters on screen (<= 8k triangles); replay buffer <= 12 MB.
## 20. Telemetry

`telemetry` carries only diagnostics: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `decisionLatencyMs` (median), `hintsUsed`, `timeouts`, `scenarioIds`. No personal data (`personName`, `relationship`), no free text, no device identifiers.
## 21. Acceptance criteria (testable)

- **AC-1:** With seed 42, difficulty 2, `scenarioCount` 3 the sim emits exactly 3 `outcomes` and 3 `checkpoint`s.
- **AC-2:** `EvaluateOffside(off-002)` returns no offside attackers; `EvaluateOffside(off-003)` returns none because the arm is ignored; `EvaluateOffside(off-001)` returns `[A9]`.
- **AC-3:** At difficulty 1 the auto mini-line appears without input; at difficulty 4 no hint button exists.
- **AC-4:** With `includeActivePlay=true`, an offside-positioned attacker who does not receive the ball and does not obstruct yields `success=true` only when `Not involved` is chosen.
- **AC-5:** At difficulty 5 the decision `TimeLimit` is 4.0 s (+/- 50 ms) and expiry records a `timeout` mistake.
- **AC-6:** Bridge conformance: given `docs/contracts/unity-bridge/v1/examples/*-launch.json`-style input for this sim, Unity emits `ready`, at least one `progress`, one `checkpoint` per round, exactly one `result` and then `requestExit`; the result validates against `simulation-result.schema.json`.
- **AC-7:** Determinism: with the same `seed`, `difficulty` and `scenarioSetId`, two runs with identical scripted inputs produce identical `outcomes[]`, `score` and `masterySignals[]`.
- **AC-8:** Invalid configuration (out-of-range value, unknown `scenarioSetId`) yields `error CONFIG_INVALID` within 500 ms and no `result`.
- **AC-9:** Pause stops sim time and the decision timer; after 30 s paused and `resume`, the decision time remaining is unchanged (+/- 50 ms).
- **AC-10:** Abort at any state produces exactly one `result` with `aborted=true`, `completed=false`, the matching `abortReason` and `xpEarned=0` within 1 s.
- **AC-11:** Accessibility: with `reducedMotion=true` no camera sweep or slow-motion ramp is used and Freeze is a hard cut; with `colorBlindMode` set, every colour-coded element has a second channel (icon or pattern).
- **AC-12:** Copy limits: every explanation title is <= 6 words and every body <= 45 words (checked by an EditMode test over the scenario data).
- **AC-13:** Budgets: p5 fps >= 50, peak memory < 150 MB, cold launch to `ready` < 2 s on iPhone 13-class.
## 22. Test plan

- **EditMode:** `EvaluateOffside` for every authored scenario; margin generation bounds; deflection vs deliberate classification. Config validation against the section 10 schema; result schema validity; scoring maths; determinism by seed; copy-length limits.
- **PlayMode:** scene builds from code; full run with scripted inputs (one correct, one wrong, one timeout); freeze/explain sequence; pause/resume/abort; reduced-motion path; tap-only scheme.
- **Perf:** measured 3-minute run on an iPhone 13-class device; report fps, memory and thermal state.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Outcomes_Count_Seed42 |
| AC-2 | EditMode | EvaluateOffside_KnownScenarios |
| AC-3 | PlayMode | Hint_Availability_ByDifficulty |
| AC-4 | EditMode | ActivePlay_Scoring |
| AC-5 | PlayMode | Timeout_Difficulty5 |
| AC-6 | EditMode | BridgeConformance_LaunchToResult |
| AC-7 | EditMode | Determinism_SameSeed |
| AC-8 | EditMode | Config_Invalid_ReturnsError |
| AC-9 | PlayMode | PauseResume_KeepsDecisionTime |
| AC-10 | PlayMode | Abort_EmitsAbortedResult |
| AC-11 | PlayMode | ReducedMotion_And_ColorBlind |
| AC-12 | EditMode | CopyLimits_AllScenarios |
| AC-13 | Perf | Perf_iPhone13_3min |

## 23. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Should the semi-automated offside animation style (skeleton) be replicated in explain? | Product | No |
| 2 | Confirm offside law wording is current for 2026/27 before release. | Claude | No |
| 3 | Does Astra want line-cam parallax at L3 or only L4-5? | Astra | No |

## Game Kit additions requested

- `Swoond.Sports.Soccer.SoccerPitch` (environment builder: markings, goals, stripe pattern, coordinate helpers).
- `Swoond.Sports.Soccer.OffsideLine` (overlay + `EvaluateOffside` pure function).
- `LineCam` camera preset (side-on, parallel to the goal line) on `CameraRig`.
- Multi-select mode on `DecisionPoint` (options + Nobody).
All four are reused by `soccer.defending.line-height.v1` and `soccer.shape.formation-read.v1`.
