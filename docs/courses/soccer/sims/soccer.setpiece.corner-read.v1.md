# Corner Read (`soccer.setpiece.corner-read.v1`)
## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `soccer.setpiece.corner-read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven, see section 6) |
| Authors / date | Swoon'd course design (soccer) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |
## 2. Course & lesson links

- `courseId`: `soccer`
- Unit `set-pieces`, lesson `setpiece-03`: difficulty 2 default, zone and swing choice
- Unit `set-pieces`, lesson `setpiece-06`: difficulty 4 default, short corner and second ball
- CDS Interaction plan row: `Read the corner (sim) | corner-routine, zonal-man-marking, set-piece-marking, near-far-post, short-corner, second-ball` (`docs/courses/soccer/CDS.md` section 12).
- Manifest entry: `docs/courses/soccer/manifest.json` -> `unitySimulations[]` (`soccer.setpiece.corner-read.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `corner-kick`, `penalty-kick`, `pitch-markings`.
## 3. Learning objective(s) & concepts taught

- **Learner-facing objective:** You can look at how a team defends a corner and pick where the delivery should go, and understand why the routine works.

| conceptId | term | After this the learner can... |
|---|---|---|
| corner-routine | Corner routine | Say what a routine is and read where runners start. |
| zonal-man-marking | Zonal vs man marking | Recognise the marking system from positions. |
| set-piece-marking | Set-piece marking systems | Spot the gap left by each system, including hybrid. |
| near-far-post | Near post and far post | Pick the correct post for a run or flick. |
| short-corner | Short corner | Recognise when a short corner beats a set defence. |
| second-ball | Second ball | Anticipate where the second ball drops. |

**Out of scope:** Free-kick and penalty technique (native lessons), kicking technique, referee positioning at corners.
## 4. Why Unity (tier justification)

| Rubric signal | Answer |
|---|---|
| Spatial reasoning | Yes: open space and marking assignments are spatial. |
| Movement over time | Yes: runs, screens and ball flight only make sense in motion. |
| Physics / camera perspective | Yes: ball flight, swing and dip; the far-post side is only clear from above. |
| Timing in a scene | Partial: the run-up is scripted; the learner decides before the kick. |
| Native fallback | `hotspot-tap` on a static diagram can teach post names; it cannot show a delivery beating a marker, swing or a second ball. |

`hotspot-tap` and `binary-call` teach the post names (lesson `setpiece-01`, `setpiece-02`). What needs a scene is why the delivery goes where it goes: the runners move, markers follow or don't, and the ball's path is a curve. Tier A is justified.
## 5. Player fantasy & core loop

**Fantasy:** You are the set-piece coach on the touchline with one whiteboard and one corner to take.

1. Prompt card: "Where does this corner go?"
2. Playing: both teams line up; the marking system is visible from positions (and a label at L1-2).
3. Decision: tap a delivery zone (near post, six-yard, penalty spot, far post, edge, short) and choose swing (In or Out).
4. Executing: the taker runs up; the ball flies; the attackers run; the sim resolves goal, header wide, cleared or won second ball.
5. Freeze and Explain: the gap in the defence in gold; your zone rose-outlined.
6. Line to say out loud: e.g. "They left the penalty spot open."

Session length target: about 3 minutes; 3 rounds by default (`scenarioCount` 3-9).
## 6. Scene & entities

- **Environment:** `soccer_pitch` (procedural: line markings, goals, six-yard box, penalty area, centre circle; grass in two-tone `court` stripes). Coordinates: metres, origin at the centre spot, `x` across the pitch (-34..34), `z` along it towards the attacking goal (-52.5..52.5).
- **Camera presets:** `top-down-tilted` (Playing/Decision), `behind-goal` (Executing), `top-down` (Explain).

| id | Game Kit primitive / sport module | role | key parameters |
|---|---|---|---|
| taker_01 | `Character` | corner taker | position (34, 52.5) or mirrored |
| att_01..05 | `Character` (Team A) | attackers | start positions and run `Path`s |
| def_01..07 | `Character` (Team B) | defenders (zonal, man or hybrid) | assignment: zone id or att id |
| keeper_01 | `Character` | goalkeeper | starting position; claim radius |
| ball_01 | `Ball` | delivery | `Throw(target, arcHeight, flight)`, swing |
| zones_* | `Zone` | delivery zones NP/SIX/PEN/FP/EDGE/SHORT | rect per section 11 |
| swingChips | `Target` (screen-space) | In / Out | two buttons |
| decision | `DecisionPoint` | zone tap + swing |  |
| explain | `Explanation` |  | callouts |

**Reused:** `Character`, `Ball`, `Path`, `Zone`, `Target`, `DecisionPoint`, `Explanation`, `CameraRig`, `Replay`, `SlowMotion`, `Score`, `ScriptedSequence` (requested by the pressing sim).

**New (needs justification and reuse plan):** `CornerResolver` (pure function that resolves a delivery against marking data) and a `Swing` parameter on `Ball.Throw` (curved flight).

**Initial layout (top-down, attacking goal at the top):**

```
  goal (top)   NP  SIX  FP
      G [ x x x x x ]
   zonal arc  o o o o
       PEN
   ------- EDGE ------
            T  <- taker (corner, right)
```
## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Tap zone | Select a delivery zone | zone >= 56 x 56 pt (expanded hit padding) | zone outlined rose |
| Tap In / Out | Select swing | chip >= 56 x 44 pt | chip outlined rose |
| Tap Confirm | Submit | button >= 56 pt | taker begins run-up |
| Long-press defender (L1-2) | Show marking assignment lines | hold 300 ms | hint recorded |

- **Tap-only alternative scheme** (`TouchController.SetScheme(TapOnly)`): all controls are taps.
- **Orientation / safe area:** portrait; Unity honours `runtime.safeAreaInsets`; HUD sits inside the safe area, controls in the lower 40 percent for thumb reach.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation dialog, permission prompts, lesson chrome. The Unity close (X) affordance emits `requestExit(user-quit)`; native confirms.
## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit condition / next |
|---|---|---|---|
| Loading | `launch` received | Validate contract, `simulationId`, `configuration` (section 10); load `scenarioSetId`; build the pitch from code | Assets ready: emit `ready`; invalid: `error CONFIG_INVALID`; asset missing: `error ASSET_LOAD_FAILED` |
| Intro | `ready` sent | One-line prompt card (Where does this corner go?); camera to establishing preset; 2 s | Auto or tap-to-skip -> Playing |
| Playing | Round `i` starts (emit `progress` = i/N) | both teams line up and the marking system is shown by lines and labels from difficulty 1-2 | Decision moment reached -> Decision |
| Decision | Trigger frame reached | Time slows to 0.15x then `DecisionPoint` opens; tap a zone and choose swing | Choice made or `timeLimit` expires -> Executing |
| Executing | Decision recorded | Play resumes at 1x showing the consequence of the choice (the ball is kicked with the chosen swing and the resolver decides who wins it); round outcome recorded in `Score` | Consequence resolved -> Freeze |
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
| Marking label shown | yes | yes | no | no | no |
| Open-zone shading hint | always | on request | 1 use | no | no |
| Attackers / defenders | 4 / 6 | 5 / 7 | 6 / 8 | 6 / 9 | 6 / 10 |
| Marking systems | zonal | zonal, man | +hybrid | +hybrid, decoys | all |
| Short corner option | hidden | hidden | hidden | visible | visible |
| Second-ball round share | 0 | 0 | 0 | 20 percent | 30 percent |
| Decision time limit (s) | none | none | 15 | 12 | 10 |
| Scenario pool tag | `zonal` | `zonal`,`man` | `+hybrid` | `+short`,`second-ball` | `all` |

Level 1 is passable by a true beginner: only zonal defences, an always-on open-zone shading and a clear label. **Defaults:** `setpiece-03` at difficulty 2; `setpiece-06` at difficulty 4.
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
        "corner-starter",
        "corner-advanced"
      ],
      "default": "corner-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 3,
      "maximum": 9,
      "default": 3
    },
    "cornerSide": {
      "type": "string",
      "enum": [
        "auto",
        "left",
        "right"
      ],
      "default": "auto"
    },
    "showOpenZoneHint": {
      "type": "boolean",
      "default": true
    },
    "allowShortCorner": {
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
  "seed": 21,
  "scenarioSetId": "corner-starter",
  "scenarioCount": 3,
  "cornerSide": "right",
  "showOpenZoneHint": true,
  "allowShortCorner": false
}
```

Any value outside the ranges, an unknown `scenarioSetId`, or `scenarioCount` greater than the set size yields `error CONFIG_INVALID` (`recoverable=false`). Unknown extra keys are ignored by the bridge rules, but this schema sets `additionalProperties: false` so authoring typos are caught in CI.
## 11. Scenario data set

Format: JSON per `scenarioSetId`. Sets: `corner-starter` (8), `corner-advanced` (8). Total authored: 16; minimum for 3 rounds x 3 is 9 (met). Coordinates per section 6 for a corner from the right (taker at x=34, z=52.5); left corners are mirrored (x -> -x). Zones (metres, `[xMin,xMax]`,`[zMin,zMax]`): NP `[1.5,5.5]x[47,52.5]`, SIX `[-1.5,1.5]x[46.5,50.5]`, PEN `[-3,3]x[39.5,45.5]`, FP `[-8,-2.5]x[45,51]`, EDGE `[-8,8]x[34,39.5]`, SHORT `[28,32]x[44,50]`. `load` = defenders within 3 m of the zone centre. Conventional swing mapping: NP and SIX inswing; PEN, FP, EDGE outswing.

### c-001 Zonal arc, empty penalty spot

```json
{
  "scenarioId": "c-001",
  "system": "zonal",
  "defenders": [
    [
      -3,
      49.5
    ],
    [
      -1,
      49.5
    ],
    [
      1,
      49.5
    ],
    [
      3,
      49.5
    ],
    [
      2.5,
      51.8
    ],
    [
      -2.5,
      51.8
    ],
    [
      6,
      46
    ]
  ],
  "keeper": [
    0,
    51
  ],
  "attackers": [
    {
      "id": "A9",
      "start": [
        0,
        42
      ]
    },
    {
      "id": "A5",
      "start": [
        -4,
        44
      ]
    },
    {
      "id": "A4",
      "start": [
        4,
        43
      ]
    },
    {
      "id": "A7",
      "start": [
        -8,
        38
      ]
    }
  ],
  "load": {
    "NP": 2,
    "SIX": 3,
    "PEN": 0,
    "FP": 1,
    "EDGE": 0,
    "SHORT": 0
  },
  "correct": {
    "zone": "PEN",
    "swing": "out"
  },
  "outcome": "header-on-target",
  "teaches": [
    "zonal-man-marking",
    "corner-routine"
  ],
  "tags": [
    "zonal"
  ]
}
```

### c-002 Man-marking, near-post dummy

```json
{
  "scenarioId": "c-002",
  "system": "man",
  "defenders": [
    [
      0,
      42.5
    ],
    [
      -4,
      44.5
    ],
    [
      4,
      43.5
    ],
    [
      -8,
      38.5
    ],
    [
      2.4,
      50.8
    ],
    [
      -2.4,
      50.8
    ]
  ],
  "keeper": [
    0,
    51
  ],
  "attackers": [
    {
      "id": "A9",
      "start": [
        0,
        42
      ],
      "run": [
        [
          0,
          44
        ],
        [
          3,
          48
        ]
      ]
    },
    {
      "id": "A5",
      "start": [
        -4,
        44
      ]
    },
    {
      "id": "A4",
      "start": [
        4,
        43
      ]
    },
    {
      "id": "A7",
      "start": [
        -8,
        38
      ]
    }
  ],
  "load": {
    "NP": 1,
    "SIX": 1,
    "PEN": 2,
    "FP": 1,
    "EDGE": 1,
    "SHORT": 0
  },
  "correct": {
    "zone": "NP",
    "swing": "in"
  },
  "outcome": "flick-on-goal",
  "teaches": [
    "set-piece-marking",
    "near-far-post"
  ],
  "tags": [
    "man"
  ]
}
```

### c-003 Hybrid with an unmarked taker (short corner)

```json
{
  "scenarioId": "c-003",
  "system": "hybrid",
  "defenders": [
    [
      -3,
      49.5
    ],
    [
      0,
      49.5
    ],
    [
      3,
      49.5
    ],
    [
      0,
      42.5
    ],
    [
      -4,
      44.5
    ],
    [
      4,
      43.5
    ],
    [
      2.4,
      50.8
    ],
    [
      -2.4,
      50.8
    ]
  ],
  "keeper": [
    0,
    51
  ],
  "attackers": [
    {
      "id": "A9",
      "start": [
        0,
        42
      ]
    },
    {
      "id": "A5",
      "start": [
        -4,
        44
      ]
    },
    {
      "id": "A4",
      "start": [
        4,
        43
      ]
    },
    {
      "id": "A8",
      "start": [
        30,
        47
      ],
      "note": "short option"
    }
  ],
  "load": {
    "NP": 2,
    "SIX": 3,
    "PEN": 2,
    "FP": 2,
    "EDGE": 0,
    "SHORT": 0
  },
  "correct": {
    "zone": "SHORT",
    "swing": "none"
  },
  "outcome": "cross-from-new-angle",
  "teaches": [
    "short-corner",
    "set-piece-marking"
  ],
  "tags": [
    "short"
  ]
}
```

**All scenarios (summary):**

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| c-004 | Zonal defence, keeper stuck to the line: far post open | FP, out | near-far-post | zonal |
| c-005 | Man-marking with a block by A5 on the near-post marker | NP, in | set-piece-marking | man |
| c-006 | Hybrid with two men on the posts and free penalty-spot arrival | PEN, out | corner-routine | hybrid |
| c-007 | Clearance falls to the edge: second ball | EDGE | second-ball | second-ball |
| c-008 | Decoy: three attackers sprint to the near post; far-post runner free | FP, out | corner-routine | decoy |
| c-009 | Tall keeper commanding six-yard box | EDGE or PEN, out | corner-routine | hard |
| c-010 | Short corner beats a static zonal arc | SHORT | short-corner | short |

**Generation rules for scenarios beyond the authored set:** Sample a marking system (zonal / man / hybrid), place defenders from a template per system, jitter positions by up to 0.5 m and compute `load` per zone with `CornerResolver.Load`. The correct zone is the lowest-`load` zone that also has an attacker reaching it (`CornerResolver.Reach`); ties are broken by the conventional priority NP, PEN, FP, SIX, EDGE. Reject scenarios with more than one tied zone at equal priority so the answer is unique.
## 12. Freeze / explain moments

| Trigger | What freezes / camera | Callouts | Title (<= 6 words) | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|
| Correct: open zone | Freeze at contact; behind-goal | Gold zone shading; marker lines; ball curve | Found the gap | Nobody was guarding the penalty spot. The zonal arc protects the six-yard box, so an outswinger to the space wins the header. | "They left the penalty spot open." |
| Wrong: crowded zone | Freeze; top-down | Crowded zone hatched; gap gold | Too crowded | You aimed at the most defended zone. Zonal players guard space, so the ball has to land where they aren't. | "Zonal marking guards space, so attack the gap." |
| Correct: near-post flick | Slow-mo replay; behind-goal | Marker lines; dummy run arrow | The dummy worked | The near-post runner drags his marker out and the flick finds the far-post runner. That's a routine, not luck. | "That's a rehearsed near-post flick." |
| Wrong swing | Freeze; top-down | Ball curve comparison gold vs rose | Right zone, wrong curve | Right area. But an inswinger to the penalty spot drifts into the keeper's arms; an outswinger drifts away from him. | "Outswinger to the spot keeps it away from the keeper." |
| Correct: short corner | Broadcast replay | Gold new-angle arrow; marker pulled out | Short corner wins | Short corners change the angle and pull a marker out of the box. The cross comes in from somewhere they haven't set for. | "Short corner, changed the angle." |

All copy is Swoon'd voice: cheeky coach, short sentences, never mean, never about the crush. Titles for the outcome are prefixed by the app-level banner "Nice read." (correct) or "Not quite." (wrong); the sim shows the title below as the card title. Never rely on colour alone (pair with the banner text, icon and the shape/pattern second channel).
## 13. Scoring & mastery signals

- **Round score:** 100 if zone and swing both match `correct`; 50 if the zone matches but swing is wrong, or an equal-`load` alternative zone was chosen; 0 otherwise. Second-ball rounds: 100 inside the correct zone, 50 within 4 m, else 0. **Accuracy:** rounds scoring 100 / rounds.
**Mistake -> conceptId mapping:**

| mistake | conceptId | description text |
|---|---|---|
| Chose the most defended zone | set-piece-marking | Delivered into a crowded zone. |
| Right zone, wrong swing | near-far-post | Picked the wrong swing for the target. |
| Ignored the short corner | short-corner | Missed a short corner that changed the angle. |
| Missed the second ball zone | second-ball | Missed where the second ball drops. |
| Misread zonal vs man | zonal-man-marking | Misread the marking system. |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; hints used halve positive deltas at native):

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct zone against zonal | zonal-man-marking | +0.20 | Attacked the space against a zonal system. |
| Correct zone against man marking | set-piece-marking | +0.20 | Used a dummy run against man marking. |
| Correct swing | near-far-post | +0.15 | Chose in or out correctly. |
| Correct short corner | short-corner | +0.20 | Chose the short option. |
| Correct second ball | second-ball | +0.20 | Found the second-ball zone. |
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
- **VoiceOver/TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson: `setpiece-01` and `setpiece-02` (hotspot-tap, multiple-choice, term-match) teach the posts and swing.
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
| Pitch and box, goals, net (procedural) | procedural | original | ~3k tris | 6-yard, penalty box, arc |
| Players | procedural | original | ~600 tris each | up to 16 on screen |
| Zone overlays | procedural | original | meshes |  |
| Scenario JSON | data | original | < 150 KB | 16 scenarios |
| Fonts | external | Instrument Serif and Geist (OFL) subset | < 300 KB |  |

Overlay styling per `docs/astra/ART_DIRECTION.md` section 4: rose = you/act, gold = earned/correct, zones translucent with `strokeStrong` borders, callouts on `surface` cards with 20 px radius. **Addressables bundle:** `sims-soccer-setpiece-corner-read` expected <= 6 MB (scenario JSON + fonts subset; no external textures).
## 19. Performance budget

Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (p5 >= 50 fps), < 150 MB resident, cold launch < 2 s, per-sim download <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state <= fair over 3 minutes. **Tighter for this sim:** At most 16 characters on screen; ball flight uses a fixed timestep (0.02 s).
## 20. Telemetry

`telemetry` carries only diagnostics: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `decisionLatencyMs`, `zoneChosen` (enum), `swingChosen`, `hintsUsed`. No personal data (`personName`, `relationship`), no free text, no device identifiers.
## 21. Acceptance criteria (testable)

- **AC-1:** With seed 21, difficulty 2, `scenarioCount` 3 the sim emits 3 `outcomes`.
- **AC-2:** `CornerResolver.Load(c-001)` returns PEN=0 and `correct` is PEN/out; choosing NP/in yields `success=false` and a `set-piece-marking` mistake.
- **AC-3:** Choosing PEN/in in `c-001` yields score 50 (zone right, swing wrong) and a `near-far-post` mistake.
- **AC-4:** With `allowShortCorner=false` the SHORT zone is not selectable at difficulty 2; at difficulty 4 it is selectable.
- **AC-5:** Left-corner scenarios are exact mirrors: the resolver returns the mirrored zone for the mirrored input.
- **AC-6:** Bridge conformance: given `docs/contracts/unity-bridge/v1/examples/*-launch.json`-style input for this sim, Unity emits `ready`, at least one `progress`, one `checkpoint` per round, exactly one `result` and then `requestExit`; the result validates against `simulation-result.schema.json`.
- **AC-7:** Determinism: with the same `seed`, `difficulty` and `scenarioSetId`, two runs with identical scripted inputs produce identical `outcomes[]`, `score` and `masterySignals[]`.
- **AC-8:** Invalid configuration (out-of-range value, unknown `scenarioSetId`) yields `error CONFIG_INVALID` within 500 ms and no `result`.
- **AC-9:** Pause stops sim time and the decision timer; after 30 s paused and `resume`, the decision time remaining is unchanged (+/- 50 ms).
- **AC-10:** Abort at any state produces exactly one `result` with `aborted=true`, `completed=false`, the matching `abortReason` and `xpEarned=0` within 1 s.
- **AC-11:** Accessibility: with `reducedMotion=true` no camera sweep or slow-motion ramp is used and Freeze is a hard cut; with `colorBlindMode` set, every colour-coded element has a second channel (icon or pattern).
- **AC-12:** Copy limits: every explanation title is <= 6 words and every body <= 45 words (checked by an EditMode test over the scenario data).
- **AC-13:** Budgets: p5 fps >= 50, peak memory < 150 MB, cold launch to `ready` < 2 s on iPhone 13-class.
## 22. Test plan

- **EditMode:** `CornerResolver.Load` and `Reach` on every authored scenario; uniqueness of the correct zone; mirror invariance; ball-flight determinism under a fixed timestep. Config validation against the section 10 schema; result schema validity; scoring maths; determinism by seed; copy-length limits.
- **PlayMode:** scene builds from code; full run with scripted inputs (one correct, one wrong, one timeout); freeze/explain sequence; pause/resume/abort; reduced-motion path; tap-only scheme.
- **Perf:** measured 3-minute run on an iPhone 13-class device; report fps, memory and thermal state.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Outcomes_Count_Seed21 |
| AC-2 | EditMode | Resolver_C001 |
| AC-3 | EditMode | Resolver_PartialCredit |
| AC-4 | PlayMode | ShortCorner_Visibility |
| AC-5 | EditMode | Resolver_Mirror |
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
| 1 | Should the resolver simulate a full header contest, or is a rule-based outcome enough for v1? | Astra | No |
| 2 | Are corners from the left needed at launch, or only mirrored automatically? | Product | No |
| 3 | Do we want a goal-celebration beat or keep results type-only? | Product | No |

## Game Kit additions requested

- `CornerResolver` (deterministic marking/zone resolver, testable pure function).
- Curved-flight `Swing` parameter on `Ball.Throw`.
- Reuse of `ScriptedSequence` and screen-space chips.
