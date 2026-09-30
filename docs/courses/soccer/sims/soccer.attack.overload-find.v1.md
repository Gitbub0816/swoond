# Find the Free Man (`soccer.attack.overload-find.v1`)
## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `soccer.attack.overload-find.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven, see section 6) |
| Authors / date | Swoon'd course design (soccer) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |
## 2. Course & lesson links

- `courseId`: `soccer`
- Unit `attack-and-defence`, lesson `attack-03`: difficulty 2 default
- CDS Interaction plan row: `Find the overload (sim) | overload, passing-lanes, third-man-run, switch-of-play, triangles` (`docs/courses/soccer/CDS.md` section 12).
- Manifest entry: `docs/courses/soccer/manifest.json` -> `unitySimulations[]` (`soccer.attack.overload-find.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `passing-lanes`, `triangles`, `build-up`.
## 3. Learning objective(s) & concepts taught

- **Learner-facing objective:** You can find the free teammate in a crowded situation: the man the overload frees, the third-man run, or the switch to the weak side.

| conceptId | term | After this the learner can... |
|---|---|---|
| overload | Overload | Recognise when your team has an extra player and where the free man is. |
| passing-lanes | Passing lanes | Tell an open lane from a blocked one at a glance. |
| third-man-run | Third-man run | Spot the pass that sets up a runner. |
| switch-of-play | Switch of play | Choose the switch when one flank is crowded. |
| triangles | Triangles | See how triangles keep an option alive. |

**Out of scope:** Shooting decisions, dribbling, defensive positioning (see the line-height sim), and full-team build-up patterns.
## 4. Why Unity (tier justification)

| Rubric signal | Answer |
|---|---|
| Spatial reasoning | Yes: free men and lanes are geometry. |
| Movement over time | Yes: defenders shift as the ball moves and lanes open and close. |
| Physics / camera perspective | Yes: a top-down view shows lanes and cover shadows that a broadcast view hides. |
| Timing in a scene | Partial: a short decision window under pressure. |
| Native fallback | `hotspot-tap` or `binary-call` on a static diagram identifies a free player but cannot show lanes closing as defenders move. |

A static diagram shows one moment; the skill is reading how the moment is changing. `decision-scenario` can list facts but loses lane geometry. Tier A is justified.
## 5. Player fantasy & core loop

**Fantasy:** You are the midfielder with the ball, three seconds and a view from above.

1. Prompt card: "Find the free man."
2. Playing: your team moves the ball into a local overload or a crowded flank; the defence shifts.
3. Decision: at the freeze frame, tap the teammate to pass to (or the switch target); a pass lane preview shows only at L1-2.
4. Executing: the pass is played and the receiver follows up (a layoff to a runner in third-man cases).
5. Freeze and Explain: the free man and lane in gold; your choice in rose.
6. Line to say out loud: e.g. "They overloaded the left and switched."

Session length target: about 3 minutes; 3 rounds by default (`scenarioCount` 3-9).
## 6. Scene & entities

- **Environment:** `soccer_pitch` (procedural: line markings, goals, six-yard box, penalty area, centre circle; grass in two-tone `court` stripes). Coordinates: metres, origin at the centre spot, `x` across the pitch (-34..34), `z` along it towards the attacking goal (-52.5..52.5).
- **Camera presets:** `top-down-tilted` (Playing/Decision), `broadcast-side` (Executing), `top-down` (Explain).

| id | Game Kit primitive / sport module | role | key parameters |
|---|---|---|---|
| carrier_01 | `Character` | learner's ball carrier | start position, facing |
| mate_01..05 | `Character` (Team A) | teammates | positions per scenario; runs as `Path` |
| opp_01..05 | `Character` (Team B) | defenders | positions; marking assignment; shift `Path` |
| ball_01 | `Ball` |  | at carrier |
| lanes | `Path` overlay | pass lanes from carrier to each teammate | open / blocked colour and pattern |
| targets | `Target` | tappable teammates | `IsCorrect`, `ConceptId` |
| decision | `DecisionPoint` | single-select | time-limited at L3+ |
| explain | `Explanation` |  | callouts |

**Reused:** `Character`, `Ball`, `Path`, `Target`, `DecisionPoint`, `Explanation`, `CameraRig`, `Highlight`, `Score`, `Replay`, `ScriptedSequence`, `CoverShadow`.

**New (needs justification and reuse plan):** `LaneEvaluator` (pure function: lane clearance, marker distance, free-man detection); reusable by the pressing sim.

**Initial layout (top-down, attacking goal at the top):**

```
     opp goal
   T3   
    D3   T2  D2
  T1  D1
       C  <- ball carrier
              T5 (weak side)
```
## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Tap teammate | Select the pass target | ring >= 56 pt | ring outlined rose; lane highlights |
| Tap Confirm | Submit | button >= 56 pt | pass played |
| Long-press teammate (L1-2) | Preview lane | hold 300 ms | hint recorded |

- **Tap-only alternative scheme** (`TouchController.SetScheme(TapOnly)`): all controls are taps.
- **Orientation / safe area:** portrait; Unity honours `runtime.safeAreaInsets`; HUD sits inside the safe area, controls in the lower 40 percent for thumb reach.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation dialog, permission prompts, lesson chrome. The Unity close (X) affordance emits `requestExit(user-quit)`; native confirms.
## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit condition / next |
|---|---|---|---|
| Loading | `launch` received | Validate contract, `simulationId`, `configuration` (section 10); load `scenarioSetId`; build the pitch from code | Assets ready: emit `ready`; invalid: `error CONFIG_INVALID`; asset missing: `error ASSET_LOAD_FAILED` |
| Intro | `ready` sent | One-line prompt card (Find the free man.); camera to establishing preset; 2 s | Auto or tap-to-skip -> Playing |
| Playing | Round `i` starts (emit `progress` = i/N) | the scripted move builds a local overload while defenders shift | Decision moment reached -> Decision |
| Decision | Trigger frame reached | Time slows to 0.15x then `DecisionPoint` opens; tap the teammate you pass to; lane previews show at L1-2 | Choice made or `timeLimit` expires -> Executing |
| Executing | Decision recorded | Play resumes at 1x showing the consequence of the choice (the pass is played; a layoff and run follow in third-man cases); round outcome recorded in `Score` | Consequence resolved -> Freeze |
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
| Lane preview | always | on request | 1 use | no | no |
| Teammates / defenders in scene | 3 / 2 | 4 / 3 | 5 / 4 | 5 / 5 | 6 / 5 |
| Decision time limit (s) | none | none | 8 | 6 | 4 |
| Free-man margin (m from nearest defender) | 5 | 4 | 3.2 | 2.6 | 2.2 |
| Types | free-man | free-man | +third-man | +switch | all |
| Defender shift speed (m/s) | 1.5 | 2.0 | 2.5 | 3.0 | 3.5 |
| Scenario pool tag | `free-man` | `free-man` | `+third-man` | `+switch` | `all` |

Level 1 is passable by a true beginner: 3 v 2, always-on lane preview and no time limit. **Defaults:** lesson `attack-03` launches at difficulty 2.
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
        "overload-starter",
        "overload-advanced"
      ],
      "default": "overload-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 3,
      "maximum": 9,
      "default": 3
    },
    "showLanePreview": {
      "type": "boolean",
      "default": true
    },
    "includeSwitch": {
      "type": "boolean",
      "default": false
    },
    "includeThirdMan": {
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
  "seed": 5,
  "scenarioSetId": "overload-starter",
  "scenarioCount": 3,
  "showLanePreview": true,
  "includeSwitch": false,
  "includeThirdMan": false
}
```

Any value outside the ranges, an unknown `scenarioSetId`, or `scenarioCount` greater than the set size yields `error CONFIG_INVALID` (`recoverable=false`). Unknown extra keys are ignored by the bridge rules, but this schema sets `additionalProperties: false` so authoring typos are caught in CI.
## 11. Scenario data set

Format: JSON per `scenarioSetId`. Sets: `overload-starter` (8), `overload-advanced` (8). Total authored: 16; minimum for 3 rounds x 3 is 9 (met). Positions per section 6 at the freeze frame; `expected` is verified by `LaneEvaluator` (a lane is clear when no defender is within 2.0 m of the segment; a player is free when the nearest defender is at least the difficulty's margin away).

### o-001 Free man in a 4 v 3

```json
{
  "scenarioId": "o-001",
  "type": "free-man",
  "carrier": [
    -20,
    10
  ],
  "mates": [
    {
      "id": "T1",
      "pos": [
        -26,
        16
      ]
    },
    {
      "id": "T2",
      "pos": [
        -14,
        18
      ]
    },
    {
      "id": "T3",
      "pos": [
        -22,
        26
      ]
    }
  ],
  "defenders": [
    {
      "id": "D1",
      "pos": [
        -25,
        17
      ],
      "marks": "T1"
    },
    {
      "id": "D2",
      "pos": [
        -16,
        19.5
      ],
      "marks": "T2"
    },
    {
      "id": "D3",
      "pos": [
        -14,
        25
      ],
      "marks": "none"
    }
  ],
  "expected": {
    "target": "T3",
    "laneClear": true,
    "nearestDefenderM": 7.9
  },
  "teaches": [
    "overload",
    "passing-lanes"
  ],
  "tags": [
    "free-man"
  ]
}
```

### o-002 Crowded left: switch

```json
{
  "scenarioId": "o-002",
  "type": "switch",
  "carrier": [
    -22,
    14
  ],
  "mates": [
    {
      "id": "T1",
      "pos": [
        -26,
        20
      ]
    },
    {
      "id": "T2",
      "pos": [
        -16,
        20
      ]
    },
    {
      "id": "T5",
      "pos": [
        28,
        18
      ]
    }
  ],
  "defenders": [
    {
      "id": "D1",
      "pos": [
        -25,
        21
      ],
      "marks": "T1"
    },
    {
      "id": "D2",
      "pos": [
        -17,
        21
      ],
      "marks": "T2"
    },
    {
      "id": "D3",
      "pos": [
        -20,
        18
      ],
      "marks": "carrier"
    },
    {
      "id": "D4",
      "pos": [
        -12,
        15
      ],
      "marks": "none"
    }
  ],
  "expected": {
    "target": "T5",
    "laneClear": true,
    "nearestDefenderM": 19.4
  },
  "teaches": [
    "switch-of-play",
    "overload"
  ],
  "tags": [
    "switch"
  ]
}
```

### o-003 Third-man layoff

```json
{
  "scenarioId": "o-003",
  "type": "third-man",
  "carrier": [
    0,
    8
  ],
  "mates": [
    {
      "id": "T2",
      "pos": [
        -8,
        14
      ],
      "role": "bounce"
    },
    {
      "id": "T3",
      "pos": [
        -18,
        24
      ],
      "role": "runner",
      "run": [
        [
          -18,
          24
        ],
        [
          -12,
          34
        ]
      ]
    },
    {
      "id": "T1",
      "pos": [
        6,
        22
      ]
    }
  ],
  "defenders": [
    {
      "id": "D1",
      "pos": [
        3,
        20
      ],
      "marks": "T1"
    },
    {
      "id": "D2",
      "pos": [
        -2,
        12
      ],
      "marks": "carrier"
    },
    {
      "id": "D3",
      "pos": [
        -14,
        26
      ],
      "marks": "T3"
    }
  ],
  "expected": {
    "target": "T2",
    "then": "T3",
    "laneClear": true,
    "note": "T1 is marked; T3 is not reachable direct; bounce to T2 releases T3"
  },
  "teaches": [
    "third-man-run",
    "triangles"
  ],
  "tags": [
    "third-man"
  ]
}
```

**All scenarios (summary):**

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| o-004 | 3 v 2 on the right, overlap available | overlapping full-back | overload | free-man |
| o-005 | Free man behind a defender's cover shadow (lane blocked) | Take the second option | passing-lanes | free-man |
| o-006 | Both flanks crowded; central six free | Pass to the six | overload | free-man |
| o-007 | Switch when the far winger is marked tightly | Choose the free full-back instead of the winger | switch-of-play | switch |
| o-008 | Triangle: carrier, 8, 10 with a runner | Play to the 8 for a one-two | triangles | third-man |
| o-009 | Decoy: nearest teammate looks free but has his lane blocked | Reject the decoy | passing-lanes | decoy |
| o-010 | 5 v 4 with a hidden free man behind the ball | Recycle backward | overload | hard |

**Generation rules for scenarios beyond the authored set:** Generate defenders by placing them near each marked teammate (0.8-2.0 m) and leaving one teammate with a nearest-defender distance >= the difficulty's margin; for `switch` place 3-4 defenders within 6 m of the carrier and one teammate >= 15 m away on the weak side; for `third-man` mark the direct forward target and leave a bounce player whose layoff lane to a runner is clear. `LaneEvaluator` computes `expected`; scenarios where more than one target is equally valid are rejected.
## 12. Freeze / explain moments

| Trigger | What freezes / camera | Callouts | Title (<= 6 words) | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|
| Correct: free man | Freeze at the pass; top-down | Gold lane and ring on the free man; defenders' cover shadows | The extra man is free | Three defenders had to mark four attackers. The man nobody marks is the free one. Find him and play the pass. | "Four attackers, three defenders, someone's free." |
| Wrong: marked man | Freeze; top-down | Rose ring on chosen mate; marker line drawn | He was covered | That teammate had a defender right on him. A pass there wins you nothing. Look for the player with space around him. | "You always look for the free man." |
| Correct: switch | Replay broadcast; long pass arc | Gold arc across the pitch; overloaded side hatched | Change the side | All the defenders leaned left. One long pass, and the weak side has space and time. | "They overloaded the left and switched." |
| Correct: third man | Replay top-down; layoff arrow | Gold path carrier-bounce-runner | The third man wins | The direct pass was covered, so the bounce to the 8 released a runner behind the marker. The move is the point, not the pass. | "That's a third-man run." |
| Wrong: blocked lane | Freeze; top-down | Lane crossed by a defender in rose | Lane was closed | A defender stood right on that lane, so the pass gets cut out. An open teammate isn't enough. You need an open lane too. | "He was free but the lane was shut." |

All copy is Swoon'd voice: cheeky coach, short sentences, never mean, never about the crush. Titles for the outcome are prefixed by the app-level banner "Nice read." (correct) or "Not quite." (wrong); the sim shows the title below as the card title. Never rely on colour alone (pair with the banner text, icon and the shape/pattern second channel).
## 13. Scoring & mastery signals

- **Round score:** 100 if the selected target equals `expected.target`; 50 if the target is a valid second-best (clear lane and margin but not the best according to `LaneEvaluator`); 0 otherwise. **Accuracy:** rounds scoring 100 / rounds.
**Mistake -> conceptId mapping:**

| mistake | conceptId | description text |
|---|---|---|
| Passed to a marked teammate | overload | Passed to a marked teammate instead of the free man. |
| Passed into a closed lane | passing-lanes | Passed into a blocked lane. |
| Missed the switch | switch-of-play | Stayed on the crowded side. |
| Missed the third-man option | third-man-run | Played direct into a marker. |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; hints used halve positive deltas at native):

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct free-man round | overload | +0.20 | Found the free man. |
| Correct lane read | passing-lanes | +0.20 | Chose an open lane. |
| Correct switch | switch-of-play | +0.20 | Switched play. |
| Correct third-man | third-man-run | +0.20 | Chose the bounce to the runner. |
| Correct triangle round | triangles | +0.15 | Used a triangle. |
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
- **VoiceOver/TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson: `attack-04` and `shape-08` (term-match, multiple-choice, say-this) teach the same vocabulary.
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
| Pitch (procedural) | procedural | original | ~2k tris | zone stripes |
| Players | procedural | original | ~600 tris each | up to 12 |
| Lane and cover-shadow overlays | procedural | original | line renderers |  |
| Scenario JSON | data | original | < 150 KB | 16 scenarios |
| Fonts | external | Instrument Serif and Geist (OFL) subset | < 300 KB |  |

Overlay styling per `docs/astra/ART_DIRECTION.md` section 4: rose = you/act, gold = earned/correct, zones translucent with `strokeStrong` borders, callouts on `surface` cards with 20 px radius. **Addressables bundle:** `sims-soccer-attack-overload-find` expected <= 6 MB (scenario JSON + fonts subset; no external textures).
## 19. Performance budget

Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (p5 >= 50 fps), < 150 MB resident, cold launch < 2 s, per-sim download <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state <= fair over 3 minutes. **Tighter for this sim:** At most 12 characters on screen.
## 20. Telemetry

`telemetry` carries only diagnostics: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `decisionLatencyMs`, `targetChosen` (role), `hintsUsed`, `type`. No personal data (`personName`, `relationship`), no free text, no device identifiers.
## 21. Acceptance criteria (testable)

- **AC-1:** With seed 5, difficulty 2, `scenarioCount` 3 the sim emits 3 `outcomes`.
- **AC-2:** `LaneEvaluator(o-001)` returns free player `T3` with a clear lane; choosing `T1` yields `success=false` and an `overload` mistake.
- **AC-3:** In `o-002`, choosing `T5` scores 100 only when `includeSwitch=true` or difficulty >= 4; otherwise the scenario is excluded from the pool.
- **AC-4:** In `o-003`, choosing `T2` scores 100 and triggers the layoff animation to `T3`.
- **AC-5:** Lane preview is visible at difficulty 1 without input and absent at difficulty 4.
- **AC-6:** Bridge conformance: given `docs/contracts/unity-bridge/v1/examples/*-launch.json`-style input for this sim, Unity emits `ready`, at least one `progress`, one `checkpoint` per round, exactly one `result` and then `requestExit`; the result validates against `simulation-result.schema.json`.
- **AC-7:** Determinism: with the same `seed`, `difficulty` and `scenarioSetId`, two runs with identical scripted inputs produce identical `outcomes[]`, `score` and `masterySignals[]`.
- **AC-8:** Invalid configuration (out-of-range value, unknown `scenarioSetId`) yields `error CONFIG_INVALID` within 500 ms and no `result`.
- **AC-9:** Pause stops sim time and the decision timer; after 30 s paused and `resume`, the decision time remaining is unchanged (+/- 50 ms).
- **AC-10:** Abort at any state produces exactly one `result` with `aborted=true`, `completed=false`, the matching `abortReason` and `xpEarned=0` within 1 s.
- **AC-11:** Accessibility: with `reducedMotion=true` no camera sweep or slow-motion ramp is used and Freeze is a hard cut; with `colorBlindMode` set, every colour-coded element has a second channel (icon or pattern).
- **AC-12:** Copy limits: every explanation title is <= 6 words and every body <= 45 words (checked by an EditMode test over the scenario data).
- **AC-13:** Budgets: p5 fps >= 50, peak memory < 150 MB, cold launch to `ready` < 2 s on iPhone 13-class.
## 22. Test plan

- **EditMode:** `LaneEvaluator` on all authored scenarios; free-man margin per difficulty; uniqueness of the best target. Config validation against the section 10 schema; result schema validity; scoring maths; determinism by seed; copy-length limits.
- **PlayMode:** scene builds from code; full run with scripted inputs (one correct, one wrong, one timeout); freeze/explain sequence; pause/resume/abort; reduced-motion path; tap-only scheme.
- **Perf:** measured 3-minute run on an iPhone 13-class device; report fps, memory and thermal state.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Outcomes_Count_Seed5 |
| AC-2 | EditMode | LaneEvaluator_O001 |
| AC-3 | EditMode | Pool_Filtering_Switch |
| AC-4 | PlayMode | ThirdMan_Layoff |
| AC-5 | PlayMode | LanePreview_ByDifficulty |
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
| 1 | Should defenders' shift animation be scripted or use a simple steering rule? | Astra | No |
| 2 | Do we want to show marker lines at L4-5 or hide them? | Product | No |
| 3 | Playtest whether 4 s at L5 feels fair. | Astra | No |

## Game Kit additions requested

- `LaneEvaluator` (pure function for lane clearance and free-man detection).
- Reuse of `ScriptedSequence` and `CoverShadow` from the pressing sim.
