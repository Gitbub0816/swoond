# Line Height (`soccer.defending.line-height.v1`)
## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `soccer.defending.line-height.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven, see section 6) |
| Authors / date | Swoon'd course design (soccer) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |
## 2. Course & lesson links

- `courseId`: `soccer`
- Unit `attack-and-defence`, lesson `attack-07`: difficulty 2 default
- CDS Interaction plan row: `Line height (sim) | high-line, offside-trap, compactness, low-block, counter-press` (`docs/courses/soccer/CDS.md` section 12).
- Manifest entry: `docs/courses/soccer/manifest.json` -> `unitySimulations[]` (`soccer.defending.line-height.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `back-four`, `offside-position`, `compactness`.
## 3. Learning objective(s) & concepts taught

- **Learner-facing objective:** You can set a defensive line's height as the ball carrier is pressed or freed: step up to squeeze and spring the offside trap, drop when a runner has room behind.

| conceptId | term | After this the learner can... |
|---|---|---|
| high-line | High defensive line | Explain the trade-off: squeezed space against space behind. |
| offside-trap | Offside trap | Time a step-up to catch a runner offside. |
| compactness | Compactness | Keep the gap between defence and midfield small. |
| low-block | Low block | Know when to drop deep instead. |
| counter-press | Counter-press | Connect a fast step-up to winning the ball back. |

**Out of scope:** Marking, tackling, keeper behaviour, and the long-form debate over defensive style.
## 4. Why Unity (tier justification)

| Rubric signal | Answer |
|---|---|
| Spatial reasoning | Yes: the height of the line against the runner's position is the concept. |
| Movement over time | Yes: pressure on the ball and runner timing change what is right, second by second. |
| Physics / camera perspective | Yes: a top-down view shows the space behind the line. |
| Timing in a scene | Yes: step-up must match the pass frame. |
| Native fallback | `decision-scenario` gives static facts; `timing-tap` gives a bar. Neither shows the line squeezing or a runner getting behind. |

A high line is only 'high' relative to the pressure on the ball and the runner's start. This is continuous control in a moving scene. Native exercises can name the trade-off (lesson `attack-06`, `attack-08`) but cannot make the learner feel it. Tier A is justified.
## 5. Player fantasy & core loop

**Fantasy:** You are the centre-back running the line, one arm up, one eye on the ball.

1. Prompt card: "Set the line. Squeeze or drop."
2. Playing: a ball carrier in midfield is pressed and released; an attacker may start a run.
3. Decision (continuous): set the line height with a vertical drag (or Drop/Hold/Step buttons in tap-only) at any time.
4. Executing: the through ball is played (or not); the sim resolves trap sprung, held shape, beaten over the top or gap too big.
5. Freeze and Explain: the line height, the runner and the space shown; ideal band in gold.
6. Line to say out loud: e.g. "They hold a really high line, so one ball over the top hurts."

Session length target: about 3 minutes; 3 rounds by default (`scenarioCount` 3-9).
## 6. Scene & entities

- **Environment:** `soccer_pitch` (procedural: line markings, goals, six-yard box, penalty area, centre circle; grass in two-tone `court` stripes). Coordinates: metres, origin at the centre spot, `x` across the pitch (-34..34), `z` along it towards the attacking goal (-52.5..52.5).
- **Camera presets:** `side-on-tilted` (Playing/Executing), `top-down` (Explain).

| id | Game Kit primitive / sport module | role | key parameters |
|---|---|---|---|
| line_01..04 | `Character` (defenders) | back four moving as one unit | height `h` metres from own goal line |
| midLine_01..04 | `Character` | midfield line | height `m(t)` from scenario |
| carrier_01 | `Character` | opposition ball carrier | pressure `P(t)` from scenario |
| runner_01 | `Character` | attacker starting a run | start `zR`, speed |
| ball_01 | `Ball` | through ball at strike | `Throw` |
| lineHandle | `Target` (screen-space) | vertical drag handle | range 15-50 m |
| band | `Zone` | ideal height band (hint) | shown L1-2 |
| decision | `DecisionPoint` (continuous) | records line height over time |  |
| explain | `Explanation` |  | callouts |

**Reused:** `Character`, `Ball`, `Path`, `Zone`, `Highlight`, `DecisionPoint`, `Explanation`, `CameraRig`, `SlowMotion`, `Replay`, `Score`, `Objective`, `OffsideLine` (from the offside sim).

**New (needs justification and reuse plan):** `LineController` (moves a group of characters as a line with easing; reusable for any line-based sim) and continuous mode for `DecisionPoint` (also requested by the pressing sim).

**Initial layout (top-down, attacking goal at the top):**

```
   opp goal (top)
   runner R -----> (behind line?)
   ----- defensive line h ----- <- drag me
   ----- midfield line -----
   carrier C (pressed?)
   own goal (bottom)
```
## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Drag handle | Vertical drag sets line height h (15-50 m) | handle >= 56 pt | line eases to target at 6 m/s max |
| Tap Drop / Hold / Step up (tap-only) | Set h to 22 / 34 / 44 m | 3 buttons >= 56 pt | line eases |
| Tap Continue | Advance in Explain | button >= 56 pt | cross-fade |

- **Tap-only alternative scheme** (`TouchController.SetScheme(TapOnly)`): Drop / Hold / Step up buttons replace the drag; the ideal band still shows at L1-2.
- **Orientation / safe area:** portrait; Unity honours `runtime.safeAreaInsets`; HUD sits inside the safe area, controls in the lower 40 percent for thumb reach.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation dialog, permission prompts, lesson chrome. The Unity close (X) affordance emits `requestExit(user-quit)`; native confirms.
## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit condition / next |
|---|---|---|---|
| Loading | `launch` received | Validate contract, `simulationId`, `configuration` (section 10); load `scenarioSetId`; build the pitch from code | Assets ready: emit `ready`; invalid: `error CONFIG_INVALID`; asset missing: `error ASSET_LOAD_FAILED` |
| Intro | `ready` sent | One-line prompt card (Set the line. Squeeze or drop.); camera to establishing preset; 2 s | Auto or tap-to-skip -> Playing |
| Playing | Round `i` starts (emit `progress` = i/N) | the carrier holds the ball; pressure and runner data play from the scenario timeline | Decision moment reached -> Decision |
| Decision | Trigger frame reached | Time slows to 0.15x then `DecisionPoint` opens; the line height is adjustable at any time; the height at the strike frame and average compactness are scored | Choice made or `timeLimit` expires -> Executing |
| Executing | Decision recorded | Play resumes at 1x showing the consequence of the choice (the through ball is played (if the carrier is free) and the runner and line resolve the outcome); round outcome recorded in `Score` | Consequence resolved -> Freeze |
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
| Control scheme | 3 buttons | 3 buttons | drag | drag | drag |
| Ideal band shown | yes | yes | no | no | no |
| Line easing speed (m/s) | 3 | 4 | 5 | 6 | 6 |
| Runner speed (m/s) | 6.5 | 7.0 | 7.8 | 8.5 | 9.0 |
| Trap timing window around strike (s) | +/-0.60 | +/-0.45 | +/-0.35 | +/-0.25 | +/-0.20 |
| Pressure changes per round | 1 | 1 | 2 | 2 | 3 |
| Scenario pool tag | `pressed`,`free` | `pressed`,`free` | `+release` | `+decoy-run` | `all` |

Level 1 is passable by a true beginner: three buttons, the ideal band on screen and a slow runner. **Defaults:** lesson `attack-07` launches at difficulty 2.
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
        "line-starter",
        "line-advanced"
      ],
      "default": "line-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 3,
      "maximum": 9,
      "default": 3
    },
    "controlScheme": {
      "type": "string",
      "enum": [
        "auto",
        "drag",
        "buttons"
      ],
      "default": "auto"
    },
    "showIdealBand": {
      "type": "boolean",
      "default": true
    },
    "roundSeconds": {
      "type": "integer",
      "minimum": 6,
      "maximum": 14,
      "default": 9
    }
  },
  "additionalProperties": false
}
```

**Valid example:**

```json
{
  "seed": 33,
  "scenarioSetId": "line-starter",
  "scenarioCount": 3,
  "controlScheme": "buttons",
  "showIdealBand": true,
  "roundSeconds": 9
}
```

Any value outside the ranges, an unknown `scenarioSetId`, or `scenarioCount` greater than the set size yields `error CONFIG_INVALID` (`recoverable=false`). Unknown extra keys are ignored by the bridge rules, but this schema sets `additionalProperties: false` so authoring typos are caught in CI.
## 11. Scenario data set

Format: JSON per `scenarioSetId`. Sets: `line-starter` (8), `line-advanced` (8). Total authored: 16; minimum for 3 rounds x 3 is 9 (met). Heights `h`, `m`, `zR` are metres measured from the defenders' own goal line (a runner is offside at the strike frame if `zR_at_strike` is less than `h_at_strike`, i.e. nearer the defenders' goal than the line). Resolution rule (deterministic): if the carrier is pressed at strike no through ball is played; the round succeeds when `h >= 38` for at least 60 percent of the round and the gap `h`-`m` stays within 25 m; otherwise `gap-too-big` if `h <= 25` for more than 40 percent. If the carrier is free at strike: `trap-sprung` if the runner is offside at strike (h_at_strike > zR) and the step was inside the timing window; `held-shape` if the runner is onside and `h_at_strike <= 30`; `beaten-over-top` if the runner is onside and `h_at_strike > 30`.

### l-001 Pressed carrier: step up

```json
{
  "scenarioId": "l-001",
  "seconds": 9,
  "timeline": [
    {
      "t": 0,
      "pressure": 1,
      "mid": 42
    },
    {
      "t": 6,
      "pressure": 1,
      "mid": 44
    }
  ],
  "runner": null,
  "strike": null,
  "expected": {
    "outcome": "held-shape",
    "rule": "h>=38 for >=60 percent of the round; gap <= 25"
  },
  "teaches": [
    "high-line",
    "compactness"
  ],
  "tags": [
    "pressed"
  ]
}
```

### l-002 Free carrier, fast runner: drop or trap

```json
{
  "scenarioId": "l-002",
  "seconds": 9,
  "timeline": [
    {
      "t": 0,
      "pressure": 0,
      "mid": 38
    }
  ],
  "runner": {
    "start": {
      "t": 2.0,
      "zR": 34
    },
    "speed": 9.0
  },
  "strike": {
    "t": 4.0,
    "zRAtStrike": 34
  },
  "expected": {
    "accept": [
      {
        "outcome": "held-shape",
        "condition": "h_at_strike<=28"
      },
      {
        "outcome": "trap-sprung",
        "condition": "h_at_strike>34 and step inside window"
      }
    ],
    "reject": "beaten-over-top when 30<h_at_strike<=34"
  },
  "teaches": [
    "high-line",
    "offside-trap"
  ],
  "tags": [
    "free"
  ]
}
```

### l-003 Pressure released mid-play

```json
{
  "scenarioId": "l-003",
  "seconds": 9,
  "timeline": [
    {
      "t": 0,
      "pressure": 1,
      "mid": 44
    },
    {
      "t": 2.5,
      "pressure": 0,
      "mid": 40
    }
  ],
  "runner": {
    "start": {
      "t": 3.0,
      "zR": 36
    },
    "speed": 8.0
  },
  "strike": {
    "t": 4.5,
    "zRAtStrike": 36
  },
  "expected": {
    "accept": [
      {
        "outcome": "held-shape",
        "condition": "h_at_strike<=28"
      },
      {
        "outcome": "trap-sprung",
        "condition": "h_at_strike>36 and step inside window"
      }
    ]
  },
  "teaches": [
    "counter-press",
    "high-line"
  ],
  "tags": [
    "release"
  ]
}
```

**All scenarios (summary):**

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| l-004 | Pressed, then released; runner offside-position at strike | Trap or drop | offside-trap | release |
| l-005 | Free carrier, slow runner | Hold or step up safely | high-line | free |
| l-006 | Free carrier, two runners; one decoy | Drop unless step-up is exact | offside-trap | decoy-run |
| l-007 | Pressed carrier, opposition midfield stuck high | Step up (compact) | compactness | pressed |
| l-008 | Pressed then a long ball anyway (hopeful) | Hold high; keeper collects | high-line | pressed |
| l-009 | Line too deep: gap to midfield 30 m | Step up | compactness | hard |
| l-010 | Counter-press wins the ball at step-up | Step up with the press | counter-press | hard |

**Generation rules for scenarios beyond the authored set:** Compose scenarios from a timeline of pressure states (0/1) with 1-3 change points, a mid-line trajectory in [36,46] and an optional runner (start time 1.5-4 s, `zR` 30-38, speed by difficulty). The expected outcome is computed by `LineResolver.Resolve(scenario, heightSamples)` using the rules in this section; reject scenarios with no valid accepted outcome or with more than three accepted outcome classes.
## 12. Freeze / explain moments

| Trigger | What freezes / camera | Callouts | Title (<= 6 words) | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|
| Correct: step up (pressed) | Freeze at end; top-down | Gold band; compact gap bracket; runner far behind | Squeeze when pressed | The carrier had no time to look up, so the line stepped up and squeezed the space. Compact lines and a hurried ball go together. | "You squeeze when the ball's under pressure." |
| Correct: trap sprung | Slow-mo replay; side-on | Gold offside line at strike; runner ring | Trap sprung | Line stepped up as the ball was struck. The runner was ahead of it and flagged. That's an offside trap, and it needs everyone at once. | "That's the offside trap." |
| Wrong: beaten over the top | Freeze at runner through; side-on | Space behind the line shaded; runner ring rose | Space behind you | A high line with a free passer and a runner gives him the space behind. Either drop before the ball is played, or step up on the strike. | "High line, one ball over the top." |
| Correct: dropped | Freeze; top-down | Gold low band; space behind the line small | Drop when it's free | The carrier had time and the runner had pace, so dropping kept the space behind small. Not every ball should be squeezed. | "You don't hold a high line for a free passer." |
| Wrong: gap too big | Freeze; top-down | Gap bracket in rose, 30 m | Too deep, too far apart | When the line sits deep and the midfield stays high, there's a hole between them. Keep the lines within about 25 metres. | "They weren't compact, there was a hole in the middle." |

All copy is Swoon'd voice: cheeky coach, short sentences, never mean, never about the crush. Titles for the outcome are prefixed by the app-level banner "Nice read." (correct) or "Not quite." (wrong); the sim shows the title below as the card title. Never rely on colour alone (pair with the banner text, icon and the shape/pattern second channel).
## 13. Scoring & mastery signals

- **Round score:** 100 for `trap-sprung` or `held-shape` matching an accepted outcome; 50 for `held-shape` when a trap was available and the line stayed at least 30 m from the runner's start; 0 for `beaten-over-top` or `gap-too-big`. **Accuracy:** rounds scoring 100 / rounds.
**Mistake -> conceptId mapping:**

| mistake | conceptId | description text |
|---|---|---|
| Beaten over the top | high-line | Held a high line while a free passer had a runner. |
| Stepped up too late | offside-trap | Missed the trap timing window. |
| Gap too big | compactness | Line and midfield too far apart. |
| Never dropped when free | low-block | Never dropped when the carrier was free. |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; hints used halve positive deltas at native):

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Trap sprung | offside-trap | +0.20 | Stepped up on the strike. |
| Correct high line when pressed | high-line | +0.20 | Squeezed when pressed. |
| Correct compactness | compactness | +0.15 | Kept the gap within 25 m. |
| Correct drop when free | low-block | +0.15 | Dropped when the carrier was free. |
| Counter-press scenario success | counter-press | +0.15 | Stepped up with the press. |
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
- **VoiceOver/TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson: `attack-06` and `attack-08` (term-match, decision-scenario, multiple-choice) present the same trade-off as static cases.
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
| Pitch (procedural) | procedural | original | ~2k tris | side-on and top-down |
| Players | procedural | original | ~600 tris each | up to 14 |
| Offside line, band, gap bracket | procedural | original | line renderers |  |
| Scenario JSON | data | original | < 100 KB | 16 scenarios |
| Fonts | external | Instrument Serif and Geist (OFL) subset | < 300 KB |  |

Overlay styling per `docs/astra/ART_DIRECTION.md` section 4: rose = you/act, gold = earned/correct, zones translucent with `strokeStrong` borders, callouts on `surface` cards with 20 px radius. **Addressables bundle:** `sims-soccer-defending-line-height` expected <= 6 MB (scenario JSON + fonts subset; no external textures).
## 19. Performance budget

Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (p5 >= 50 fps), < 150 MB resident, cold launch < 2 s, per-sim download <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state <= fair over 3 minutes. **Tighter for this sim:** At most 14 characters on screen; line easing is computed per frame without allocation.
## 20. Telemetry

`telemetry` carries only diagnostics: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hAtStrike`, `stepInWindow` (bool), `avgGapM`, `timeAboveBandS`. No personal data (`personName`, `relationship`), no free text, no device identifiers.
## 21. Acceptance criteria (testable)

- **AC-1:** With seed 33, difficulty 2, `scenarioCount` 3 the sim emits 3 `outcomes`.
- **AC-2:** In `l-002`, a scripted `h_at_strike` of 40 (step inside the window) yields `trap-sprung` and success; 32 yields `beaten-over-top`; 26 yields `held-shape`.
- **AC-3:** In `l-001`, holding `h=40` throughout yields success; holding `h=24` yields `gap-too-big` and a `compactness` mistake.
- **AC-4:** The drag handle clamps `h` to [15, 50] and the line moves no faster than the difficulty's easing speed (+/- 5 percent).
- **AC-5:** With `controlScheme=buttons`, Drop/Hold/Step up set `h` to 22/34/44 m.
- **AC-6:** Bridge conformance: given `docs/contracts/unity-bridge/v1/examples/*-launch.json`-style input for this sim, Unity emits `ready`, at least one `progress`, one `checkpoint` per round, exactly one `result` and then `requestExit`; the result validates against `simulation-result.schema.json`.
- **AC-7:** Determinism: with the same `seed`, `difficulty` and `scenarioSetId`, two runs with identical scripted inputs produce identical `outcomes[]`, `score` and `masterySignals[]`.
- **AC-8:** Invalid configuration (out-of-range value, unknown `scenarioSetId`) yields `error CONFIG_INVALID` within 500 ms and no `result`.
- **AC-9:** Pause stops sim time and the decision timer; after 30 s paused and `resume`, the decision time remaining is unchanged (+/- 50 ms).
- **AC-10:** Abort at any state produces exactly one `result` with `aborted=true`, `completed=false`, the matching `abortReason` and `xpEarned=0` within 1 s.
- **AC-11:** Accessibility: with `reducedMotion=true` no camera sweep or slow-motion ramp is used and Freeze is a hard cut; with `colorBlindMode` set, every colour-coded element has a second channel (icon or pattern).
- **AC-12:** Copy limits: every explanation title is <= 6 words and every body <= 45 words (checked by an EditMode test over the scenario data).
- **AC-13:** Budgets: p5 fps >= 50, peak memory < 150 MB, cold launch to `ready` < 2 s on iPhone 13-class.
## 22. Test plan

- **EditMode:** `LineResolver.Resolve` for every authored scenario and scripted height profiles; pressure timeline parsing; outcome class uniqueness. Config validation against the section 10 schema; result schema validity; scoring maths; determinism by seed; copy-length limits.
- **PlayMode:** scene builds from code; full run with scripted inputs (one correct, one wrong, one timeout); freeze/explain sequence; pause/resume/abort; reduced-motion path; tap-only scheme.
- **Perf:** measured 3-minute run on an iPhone 13-class device; report fps, memory and thermal state.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Outcomes_Count_Seed33 |
| AC-2 | EditMode | LineResolver_L002 |
| AC-3 | EditMode | LineResolver_L001 |
| AC-4 | PlayMode | Handle_Clamp_And_Speed |
| AC-5 | PlayMode | Buttons_Heights |
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
| 1 | Is the 30 m beaten-over-the-top threshold acceptable, or should it depend on runner speed? | Astra | No |
| 2 | Should the keeper's sweeping be visible? | Product | No |
| 3 | Confirm accepted outcome classes in scenarios where both trap and drop are valid. | Product | No |

## Game Kit additions requested

- `LineController` (moves a line of characters with easing to a target height).
- `LineResolver` (deterministic resolution against timeline scenarios).
- Continuous mode on `DecisionPoint` (shared with the pressing sim).
- `side-on-tilted` camera preset on `CameraRig`.
