# Formation Read (`soccer.shape.formation-read.v1`)
## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `soccer.shape.formation-read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven, see section 6) |
| Authors / date | Swoon'd course design (soccer) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |
## 2. Course & lesson links

- `courseId`: `soccer`
- Unit `formations-and-shape`, lesson `shape-04`: difficulty 2 default, name-shape mode
- Unit `formations-and-shape`, lesson `shape-07`: difficulty 4 default, find-the-pocket mode
- CDS Interaction plan row: `Name that shape and half-space finding (sim) | formation-numbers, in-out-possession-shape, compactness, half-spaces, between-the-lines` (`docs/courses/soccer/CDS.md` section 12).
- Manifest entry: `docs/courses/soccer/manifest.json` -> `unitySimulations[]` (`soccer.shape.formation-read.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `back-four`, `defensive-midfielder`, `striker`.
## 3. Learning objective(s) & concepts taught

- **Learner-facing objective:** You can watch a team move and say what shape it is in and out of possession, then find the pocket of space a creator should receive in.

| conceptId | term | After this the learner can... |
|---|---|---|
| formation-numbers | Reading formations | Read a formation by counting the lines from back to front. |
| in-out-possession-shape | In and out of possession | See that the shape changes with and without the ball. |
| compactness | Compactness | Judge whether the lines are close enough. |
| half-spaces | Half-spaces | Tap the half-space between full-back and centre-back. |
| between-the-lines | Between the lines | Tap the pocket between defence and midfield. |
| passing-lanes | Passing lanes | See which lane a pocket opens. |

**Out of scope:** Tactical schools and history (taught natively), player roles beyond position labels, opposition-specific game plans.
## 4. Why Unity (tier justification)

| Rubric signal | Answer |
|---|---|
| Spatial reasoning | Yes: a formation is a pattern in space; pockets are gaps between lines. |
| Movement over time | Yes: the shape differs by phase; static diagrams show one frame only. |
| Physics / camera perspective | Partial: a top-down view with line overlays makes the rows visible. |
| Timing in a scene | No: the decision is untimed at L1-2. |
| Native fallback | `hotspot-tap` on a static 4-3-3 diagram (used in shape-01) teaches the numbers but cannot show a team changing shape. |

Native lessons `shape-01` to `shape-03` teach the numbers with hotspot-tap and term-match. What only a moving scene shows is that teams have two shapes and that a pocket exists only relative to moving lines. Tier A is justified for the dynamic read.
## 5. Player fantasy & core loop

**Fantasy:** You are the analyst in the gantry, tracing lines on a top-down feed.

1. Prompt card: "What shape are they in?" or "Where's the pocket?"
2. Playing: ten dots (plus the keeper) move through possession and out-of-possession phases.
3. Decision: name-shape mode: pick the formation chip; find-the-pocket mode: tap the pocket on the pitch.
4. Executing: rows are drawn over the players (name-shape) or the ball is played into the pocket (find-the-pocket).
5. Freeze and Explain: the correct rows/pocket in gold; the rose selection outlined.
6. Line to say out loud: e.g. "They look like a 4-3-3, but build in a 3-2-5."

Session length target: about 3 minutes; 3 rounds by default (`scenarioCount` 3-9).
## 6. Scene & entities

- **Environment:** `soccer_pitch` (procedural: line markings, goals, six-yard box, penalty area, centre circle; grass in two-tone `court` stripes). Coordinates: metres, origin at the centre spot, `x` across the pitch (-34..34), `z` along it towards the attacking goal (-52.5..52.5).
- **Camera presets:** `top-down` (all states), `broadcast-side` for replay of a pocket pass.

| id | Game Kit primitive / sport module | role | key parameters |
|---|---|---|---|
| home_01..10 | `Character` (Team A) | outfield players | position per phase from scenario; kit numbers hidden at L3+ |
| gk_01 | `Character` | keeper | fixed |
| ball_01 | `Ball` | possession marker | moves with phase |
| rows | `Path` overlay | formation lines | drawn at Explain |
| pocketZone_* | `Zone` | half-space / between-lines pockets | shape from scenario |
| chips | `Target` (screen-space) | formation chips | 3-4 options |
| decision | `DecisionPoint` | single-select or tap-on-pitch |  |
| explain | `Explanation` |  | callouts |

**Reused:** `Character`, `Ball`, `Path`, `Zone`, `Target`, `DecisionPoint`, `Explanation`, `Highlight`, `CameraRig`, `Score`, `Replay`.

**New (needs justification and reuse plan):** `FormationRows` overlay (derives rows by clustering z within 3 m) and `SoccerPitch`; both reusable.

**Initial layout (top-down, attacking goal at the top):**

```
   home in possession (4-3-3 -> 3-2-5)
        S
   W         W
      8    8
        6
   FB  CB  CB  FB
  [ 4-3-3 ] [ 4-2-3-1 ] [ 3-5-2 ]
```
## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Tap formation chip | Select a shape | chip >= 56 x 44 pt | chip outlined rose |
| Tap pitch (pocket mode) | Select a point | tolerance radius 4 m at L1, 2 m at L5 | rose ring on the tapped point |
| Tap Confirm | Submit | button >= 56 pt | freeze resumes |
| Long-press a player (L1-2) | Show the row he belongs to | hold 300 ms | hint recorded |

- **Tap-only alternative scheme** (`TouchController.SetScheme(TapOnly)`): all controls are taps; the long-press hint is a Hint button.
- **Orientation / safe area:** portrait; Unity honours `runtime.safeAreaInsets`; HUD sits inside the safe area, controls in the lower 40 percent for thumb reach.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation dialog, permission prompts, lesson chrome. The Unity close (X) affordance emits `requestExit(user-quit)`; native confirms.
## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit condition / next |
|---|---|---|---|
| Loading | `launch` received | Validate contract, `simulationId`, `configuration` (section 10); load `scenarioSetId`; build the pitch from code | Assets ready: emit `ready`; invalid: `error CONFIG_INVALID`; asset missing: `error ASSET_LOAD_FAILED` |
| Intro | `ready` sent | One-line prompt card (What shape are they in?); camera to establishing preset; 2 s | Auto or tap-to-skip -> Playing |
| Playing | Round `i` starts (emit `progress` = i/N) | the team runs through an in-possession phase (8 s) and an out-of-possession phase (6 s) from scenario keyframes | Decision moment reached -> Decision |
| Decision | Trigger frame reached | Time slows to 0.15x then `DecisionPoint` opens; name-shape mode: pick formation chips (in and out of possession from L3); pocket mode: tap the pocket | Choice made or `timeLimit` expires -> Executing |
| Executing | Decision recorded | Play resumes at 1x showing the consequence of the choice (rows are drawn (name-shape) or the ball is played to the pocket (pocket mode)); round outcome recorded in `Score` | Consequence resolved -> Freeze |
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
| Mode | name-shape | name-shape | name-shape (in + out) | pocket | pocket |
| Chip options | 3 | 4 | 4 | n/a | n/a |
| Kit numbers visible | yes | yes | no | no | no |
| Rows hint | always | on request | 1 use | no | no |
| Pocket tap radius (m) | n/a | n/a | n/a | 3.5 | 2.0 |
| Decision time limit (s) | none | none | 20 | 15 | 10 |
| Shape families | 4-4-2, 4-3-3 | +4-2-3-1 | +3-5-2 | +3-4-3 in poss. | all |
| Scenario pool tag | `flat` | `flat`,`phase` | `+phase` | `pocket` | `+hard` |

Level 1 is passable by a true beginner: 3 chips, visible numbers and permanent row hints. **Defaults:** `shape-04` at difficulty 2; `shape-07` at difficulty 4.
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
        "shape-starter",
        "shape-phases",
        "shape-pockets"
      ],
      "default": "shape-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 3,
      "maximum": 9,
      "default": 3
    },
    "mode": {
      "type": "string",
      "enum": [
        "name-shape",
        "find-the-pocket"
      ],
      "default": "name-shape"
    },
    "askOutOfPossession": {
      "type": "boolean",
      "default": false
    },
    "showRowHints": {
      "type": "boolean",
      "default": true
    }
  },
  "additionalProperties": false
}
```

**Valid example:**

```json
{
  "seed": 11,
  "scenarioSetId": "shape-starter",
  "scenarioCount": 3,
  "mode": "name-shape",
  "askOutOfPossession": false,
  "showRowHints": true
}
```

Any value outside the ranges, an unknown `scenarioSetId`, or `scenarioCount` greater than the set size yields `error CONFIG_INVALID` (`recoverable=false`). Unknown extra keys are ignored by the bridge rules, but this schema sets `additionalProperties: false` so authoring typos are caught in CI.
## 11. Scenario data set

Format: JSON per `scenarioSetId`. Sets: `shape-starter` (6), `shape-phases` (6), `shape-pockets` (6). Total authored: 18; minimum for 9 rounds is 9 (met). Positions are metres per section 6; `inPoss` and `outPoss` are ten [x,z] pairs; `formation` labels are the answers. Deterministic per seed.

### sh-001 Flat 4-4-2

```json
{
  "scenarioId": "sh-001",
  "mode": "name-shape",
  "inPoss": {
    "formation": "4-4-2",
    "players": [
      [
        -24,
        -8
      ],
      [
        -8,
        -8
      ],
      [
        8,
        -8
      ],
      [
        24,
        -8
      ],
      [
        -26,
        6
      ],
      [
        -9,
        6
      ],
      [
        9,
        6
      ],
      [
        26,
        6
      ],
      [
        -8,
        22
      ],
      [
        8,
        22
      ]
    ]
  },
  "outPoss": {
    "formation": "4-4-2",
    "players": [
      [
        -24,
        -22
      ],
      [
        -8,
        -22
      ],
      [
        8,
        -22
      ],
      [
        24,
        -22
      ],
      [
        -26,
        -10
      ],
      [
        -9,
        -10
      ],
      [
        9,
        -10
      ],
      [
        26,
        -10
      ],
      [
        -8,
        2
      ],
      [
        8,
        2
      ]
    ]
  },
  "options": [
    "4-3-3",
    "4-4-2",
    "4-2-3-1"
  ],
  "correct": {
    "inPoss": "4-4-2",
    "outPoss": "4-4-2"
  },
  "teaches": [
    "formation-numbers",
    "compactness"
  ],
  "tags": [
    "flat"
  ]
}
```

### sh-002 4-3-3 that drops to 4-5-1

```json
{
  "scenarioId": "sh-002",
  "mode": "name-shape",
  "inPoss": {
    "formation": "4-3-3",
    "players": [
      [
        -25,
        -6
      ],
      [
        -9,
        -6
      ],
      [
        9,
        -6
      ],
      [
        25,
        -6
      ],
      [
        0,
        4
      ],
      [
        -14,
        14
      ],
      [
        14,
        14
      ],
      [
        -28,
        28
      ],
      [
        28,
        28
      ],
      [
        0,
        32
      ]
    ]
  },
  "outPoss": {
    "formation": "4-5-1",
    "players": [
      [
        -25,
        -20
      ],
      [
        -9,
        -20
      ],
      [
        9,
        -20
      ],
      [
        25,
        -20
      ],
      [
        -27,
        -8
      ],
      [
        -14,
        -8
      ],
      [
        0,
        -8
      ],
      [
        14,
        -8
      ],
      [
        27,
        -8
      ],
      [
        0,
        4
      ]
    ]
  },
  "options": [
    "4-3-3",
    "4-5-1",
    "4-4-2",
    "3-5-2"
  ],
  "correct": {
    "inPoss": "4-3-3",
    "outPoss": "4-5-1"
  },
  "teaches": [
    "in-out-possession-shape",
    "formation-numbers"
  ],
  "tags": [
    "phase"
  ]
}
```

### sh-003 Pocket vs a low block

```json
{
  "scenarioId": "sh-003",
  "mode": "find-the-pocket",
  "ball": [
    -10,
    10
  ],
  "defence": {
    "formation": "4-4-2",
    "players": [
      [
        -24,
        42
      ],
      [
        -8,
        42
      ],
      [
        8,
        42
      ],
      [
        24,
        42
      ],
      [
        -26,
        32
      ],
      [
        -9,
        32
      ],
      [
        9,
        32
      ],
      [
        26,
        32
      ],
      [
        -8,
        22
      ],
      [
        8,
        22
      ]
    ]
  },
  "pockets": [
    {
      "id": "half-left",
      "type": "half-space",
      "rect": {
        "x": [
          -16,
          -9
        ],
        "z": [
          33,
          41
        ]
      },
      "correct": true
    },
    {
      "id": "between-lines",
      "type": "between-the-lines",
      "rect": {
        "x": [
          -6,
          6
        ],
        "z": [
          33,
          41
        ]
      },
      "correct": true
    },
    {
      "id": "wide-left",
      "type": "wide",
      "rect": {
        "x": [
          -34,
          -27
        ],
        "z": [
          33,
          41
        ]
      },
      "correct": false
    }
  ],
  "acceptedPocketIds": [
    "half-left",
    "between-lines"
  ],
  "teaches": [
    "half-spaces",
    "between-the-lines"
  ],
  "tags": [
    "pocket"
  ]
}
```

**All scenarios (summary):**

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| sh-004 | 4-2-3-1 out of possession becomes 4-4-1-1 | 4-2-3-1 in; 4-4-2 out (rows drawn) | in-out-possession-shape | phase |
| sh-005 | 3-5-2 with wing-backs pushed high | 3-5-2 in possession; 5-3-2 out | formation-numbers | phase |
| sh-006 | Full-backs invert into midfield while attacking | 4-3-3 out, 3-2-5 in | in-out-possession-shape | phase |
| sh-007 | Pocket vs 4-2-3-1 medium block: right half-space open | half-right | half-spaces | pocket |
| sh-008 | Pocket vs 4-4-2 flat: between the lines | between-lines | between-the-lines | pocket |
| sh-009 | Compactness check: lines 32 m apart | Not compact (gap > 25 m) | compactness | hard |
| sh-010 | Back three vs front three: the wide channel is open | wide-left | half-spaces | hard |

**Generation rules for scenarios beyond the authored set:** Generate a formation by taking a template (line depths and lateral spread) and adding jitter of up to 1.5 m per player; out-of-possession shapes are derived by dropping lines by 12-18 m and narrowing by 15 percent. Correct labels come from `FormationRows` (row clustering within 3 m of z), never hand-typed for generated scenarios. Pockets are rectangles between clustered rows (between-lines) or the channels x in [+/-16, +/-9] (half-spaces).
## 12. Freeze / explain moments

| Trigger | What freezes / camera | Callouts | Title (<= 6 words) | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|
| Correct: name shape | Freeze; top-down | Rows drawn gold through the four/three/two clusters; numbers along the left edge | Count the lines | Count each line from back to front: four defenders, four midfielders, two strikers is a 4-4-2. The rows tell you the shape, not the shirts. | "Four at the back, four in midfield, two up top." |
| Wrong: ignored phase | Slow-mo replay; top-down | Two overlays: in-possession rows (gold) and out-of-possession rows (muted) | Shapes change with the ball | With the ball it's a 4-3-3; without it the wingers drop and it becomes a 4-5-1. Teams have a shape for each phase. | "They look like a 4-3-3, but they defend in a 4-5-1." |
| Correct: pocket | Broadcast replay of the pass into the pocket | Gold pocket rectangle; rows and gap arrows | Found the pocket | Between the lines is where a turning creator hurts you: too far from the defence to be tracked, too far forward for midfield to close. | "He got the ball between the lines and turned." |
| Wrong: wide, not half-space | Freeze; top-down | Selected point rose; correct half-space gold | Wide is safe, not dangerous | The touchline isn't a threat. The half-space lets a player face goal with options on both sides. | "The half-space is where the danger is." |
| Wrong: not compact | Freeze; top-down | Gap bracket in rose | Too far apart | When the back line and the midfield line stand more than about 25 metres apart, there's a whole pocket to play in. Compact lines squeeze it out. | "They're not compact, that's why the ten had time." |

All copy is Swoon'd voice: cheeky coach, short sentences, never mean, never about the crush. Titles for the outcome are prefixed by the app-level banner "Nice read." (correct) or "Not quite." (wrong); the sim shows the title below as the card title. Never rely on colour alone (pair with the banner text, icon and the shape/pattern second channel).
## 13. Scoring & mastery signals

- **Round score:** name-shape: 100 if all asked shapes are right (in, and out from L3); 50 if one of two right; 0 otherwise. Pocket: 100 if the tap lies inside an accepted pocket (within the tolerance radius), 50 if within 2x tolerance of one, else 0. **Accuracy:** rounds scoring 100 / rounds.
**Mistake -> conceptId mapping:**

| mistake | conceptId | description text |
|---|---|---|
| Miscounted rows (wrong shape) | formation-numbers | Named the wrong formation. |
| Ignored the phase change | in-out-possession-shape | Missed the out-of-possession shape. |
| Tapped wide instead of half-space | half-spaces | Chose the wide lane instead of the half-space. |
| Tapped in front of the block | between-the-lines | Missed the pocket between lines. |
| Judged lines compact when not | compactness | Misjudged compactness. |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; hints used halve positive deltas at native):

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct shape | formation-numbers | +0.20 | Named the formation. |
| Correct out-of-possession shape | in-out-possession-shape | +0.20 | Named both phases. |
| Correct half-space pocket | half-spaces | +0.20 | Found the half-space. |
| Correct between-lines pocket | between-the-lines | +0.20 | Found the pocket. |
| Correct compactness call | compactness | +0.15 | Judged the gap correctly. |
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
- **VoiceOver/TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson: `shape-01` to `shape-03` (hotspot-tap, term-match) plus `shape-05` (multiple-choice/say-this).
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
| Pitch, row overlays, pocket rectangles | procedural | original | ~2k tris | hatch patterns for colour-blind mode |
| Players (capsule figures) | procedural | original | ~600 tris each |  |
| Scenario JSON | data | original | < 150 KB | 18 scenarios |
| Fonts | external | Instrument Serif and Geist (OFL) subset | < 300 KB |  |

Overlay styling per `docs/astra/ART_DIRECTION.md` section 4: rose = you/act, gold = earned/correct, zones translucent with `strokeStrong` borders, callouts on `surface` cards with 20 px radius. **Addressables bundle:** `sims-soccer-shape-formation-read` expected <= 6 MB (scenario JSON + fonts subset; no external textures).
## 19. Performance budget

Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (p5 >= 50 fps), < 150 MB resident, cold launch < 2 s, per-sim download <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state <= fair over 3 minutes. **Tighter for this sim:** At most 11 characters on screen; overlays via line renderers only.
## 20. Telemetry

`telemetry` carries only diagnostics: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `decisionLatencyMs`, `hintsUsed`, `mode`, `wrongShapeCount`. No personal data (`personName`, `relationship`), no free text, no device identifiers.
## 21. Acceptance criteria (testable)

- **AC-1:** With seed 11, difficulty 2, `scenarioCount` 3 in name-shape mode the sim emits 3 `outcomes`.
- **AC-2:** `FormationRows(sh-001.inPoss)` returns rows [4,4,2]; `sh-002.outPoss` returns [4,5,1].
- **AC-3:** In pocket mode, a tap at (-12, 36) in `sh-003` scores 100; a tap at (-30, 36) scores 0 and records a `half-spaces` mistake.
- **AC-4:** At difficulty 3 the out-of-possession question is asked in name-shape mode and `askOutOfPossession` is forced true.
- **AC-5:** Kit numbers are hidden at difficulty 3 and above.
- **AC-6:** Bridge conformance: given `docs/contracts/unity-bridge/v1/examples/*-launch.json`-style input for this sim, Unity emits `ready`, at least one `progress`, one `checkpoint` per round, exactly one `result` and then `requestExit`; the result validates against `simulation-result.schema.json`.
- **AC-7:** Determinism: with the same `seed`, `difficulty` and `scenarioSetId`, two runs with identical scripted inputs produce identical `outcomes[]`, `score` and `masterySignals[]`.
- **AC-8:** Invalid configuration (out-of-range value, unknown `scenarioSetId`) yields `error CONFIG_INVALID` within 500 ms and no `result`.
- **AC-9:** Pause stops sim time and the decision timer; after 30 s paused and `resume`, the decision time remaining is unchanged (+/- 50 ms).
- **AC-10:** Abort at any state produces exactly one `result` with `aborted=true`, `completed=false`, the matching `abortReason` and `xpEarned=0` within 1 s.
- **AC-11:** Accessibility: with `reducedMotion=true` no camera sweep or slow-motion ramp is used and Freeze is a hard cut; with `colorBlindMode` set, every colour-coded element has a second channel (icon or pattern).
- **AC-12:** Copy limits: every explanation title is <= 6 words and every body <= 45 words (checked by an EditMode test over the scenario data).
- **AC-13:** Budgets: p5 fps >= 50, peak memory < 150 MB, cold launch to `ready` < 2 s on iPhone 13-class.
## 22. Test plan

- **EditMode:** `FormationRows` clustering for all authored formations; pocket rectangle containment and tolerance; label generation for generated scenarios. Config validation against the section 10 schema; result schema validity; scoring maths; determinism by seed; copy-length limits.
- **PlayMode:** scene builds from code; full run with scripted inputs (one correct, one wrong, one timeout); freeze/explain sequence; pause/resume/abort; reduced-motion path; tap-only scheme.
- **Perf:** measured 3-minute run on an iPhone 13-class device; report fps, memory and thermal state.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Outcomes_Count_Seed11 |
| AC-2 | EditMode | FormationRows_KnownScenarios |
| AC-3 | EditMode | Pocket_Tap_Scoring |
| AC-4 | PlayMode | Difficulty3_AsksOutPossession |
| AC-5 | PlayMode | KitNumbers_Hidden_L3 |
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
| 1 | Is a keeper always drawn even though formations are counted for the ten outfielders? | Product | No |
| 2 | Should shape names show in UK or US style (e.g. 'holding midfielder' vs 'defensive midfielder')? | Product | No |
| 3 | Playtest the pocket tolerance at L4-5. | Astra | No |

## Game Kit additions requested

- `Swoond.Sports.Soccer.FormationRows` (row clustering, formation label derivation).
- `SoccerPitch` (shared with the offside sim).
- Screen-space chip selector on `DecisionPoint`.
