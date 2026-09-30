# Pressing Trigger Call (`soccer.pressing.trigger-call.v1`)
## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `soccer.pressing.trigger-call.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven, see section 6) |
| Authors / date | Swoon'd course design (soccer) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |
## 2. Course & lesson links

- `courseId`: `soccer`
- Unit `attack-and-defence`, lesson `attack-05`: difficulty 2 default; hold-scenarios enabled from difficulty 3
- CDS Interaction plan row: `Pressing triggers (sim) | pressing, pressing-trigger, high-press, mid-block, pressing-traps` (`docs/courses/soccer/CDS.md` section 12).
- Manifest entry: `docs/courses/soccer/manifest.json` -> `unitySimulations[]` (`soccer.pressing.trigger-call.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `build-up`, `formation-numbers`, `out-of-play`.
## 3. Learning objective(s) & concepts taught

- **Learner-facing objective:** You can spot the moment a team should press (a back pass, a heavy touch, a pass to the touchline) and, just as importantly, the moments to hold.

| conceptId | term | After this the learner can... |
|---|---|---|
| pressing | Pressing | Explain that pressing is a coordinated closing-down, not one player chasing. |
| pressing-trigger | Pressing trigger | Name the cues that start a press and call the press within the window. |
| high-press | High press | See how a well-timed press wins the ball high. |
| mid-block | Mid-block | Know when to hold shape instead of pressing. |
| pressing-traps | Pressing traps | See how leaving one pass open lures the ball into a trap. |

**Out of scope:** Counter-pressing after turnovers (taught in the same unit via native lessons), PPDA and other pressing data, and full-team tactical systems.
## 4. Why Unity (tier justification)

| Rubric signal | Answer |
|---|---|
| Spatial reasoning | Yes: cover shadows, distances to the ball and passing lanes decide whether a press works. |
| Movement over time | Yes: a trigger exists only for a second or two; the learner must see the ball, the touch and the body shape unfold. |
| Physics / camera perspective | Partial: a high top-down view shows the shape of the press. |
| Timing in a scene | Yes: call the press inside a moving window while ignoring decoys. |
| Native fallback | `timing-tap` gives a 1D bar (no scene); `decision-scenario` gives static facts. Neither teaches recognising a trigger in motion. |

Pressing is a timing-and-spatial skill: the trigger is a moving event. `timing-tap` can train reaction to a bar but not the recognition of a back pass or a heavy touch inside a scene, and `decision-scenario` cannot show the collapse of a press that starts a second late. Tier A is justified.
## 5. Player fantasy & core loop

**Fantasy:** You are the pressing captain, one shout away from making the whole team jump.

1. Prompt card: "Spot the trigger. Call the press."
2. Playing: the opposition builds from the back while your team holds a ghost press shape.
3. Decision (continuous): a big PRESS button is live for the whole sequence; tap it only at a trigger; the sequence auto-ends at the halfway line or after 12 s.
4. Executing: the team presses on the tap; the sim resolves the win, the forced long ball, or the broken press.
5. Freeze and Explain: highlight the trigger, the cover shadow and the gap left by an early call.
6. Line to say out loud: e.g. "The back pass was the trigger."

Session length target: about 3 minutes; 3 rounds by default (`scenarioCount` 3-9).
## 6. Scene & entities

- **Environment:** `soccer_pitch` (procedural: line markings, goals, six-yard box, penalty area, centre circle; grass in two-tone `court` stripes). Coordinates: metres, origin at the centre spot, `x` across the pitch (-34..34), `z` along it towards the attacking goal (-52.5..52.5).
- **Camera presets:** `top-down-tilted` (Playing), `broadcast-side` (Executing), `top-down` (Explain).

| id | Game Kit primitive / sport module | role | key parameters |
|---|---|---|---|
| opp_01..10 | `Character` (role attacker, Team B) | opposition building from the back | scripted keyframes from scenario |
| home_01..10 | `Character` (Team A) | your pressing team | ghost shape from `pressShape`; press paths from `Path` |
| ball_01 | `Ball` |  | keyframed carry/pass; `Landed` event |
| triggerRing | `Highlight` | trigger cue (hint only) | shown only when `showTriggerHints` |
| coverShadow | `Zone` | the passing lane blocked by the pressing player | cone geometry |
| pressButton | `Target` (screen-space) | PRESS button | enabled during Playing |
| decision | `DecisionPoint` (continuous mode) | records tap time vs windows |  |
| explain | `Explanation` |  | callouts |

**Reused:** `Character`, `Ball`, `Path`, `Zone`, `Highlight`, `DecisionPoint`, `Explanation`, `SlowMotion`, `CameraRig`, `Replay`, `Score`, `Objective`.

**New (needs justification and reuse plan):** `ScriptedSequence` (deterministic keyframed choreography of players and ball) and `TimedWindowObjective` (success if an input arrives inside a window); both reusable by the corner and overload sims.

**Initial layout (top-down, attacking goal at the top):**

```
   opp goal-line (top)
      GK
   CB    CB    <- opposition build-up
  LB  6   8  RB

   home ghost press shape (4-4-2)
   S  S
   M  M  M  M
        [ PRESS ]
```
## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Tap PRESS | One tap during Playing | button >= 72 x 72 pt, lower third | button flashes rose; team jumps |
| Tap Continue | Advance in Explain | button >= 56 pt | cross-fade |
| Long-press ball (L1-2) | Show the next trigger ring | hold 300 ms | hint recorded |

- **Tap-only alternative scheme** (`TouchController.SetScheme(TapOnly)`): every control is already a tap; a Hint button replaces the long-press.
- **Orientation / safe area:** portrait; Unity honours `runtime.safeAreaInsets`; HUD sits inside the safe area, controls in the lower 40 percent for thumb reach.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation dialog, permission prompts, lesson chrome. The Unity close (X) affordance emits `requestExit(user-quit)`; native confirms.
## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit condition / next |
|---|---|---|---|
| Loading | `launch` received | Validate contract, `simulationId`, `configuration` (section 10); load `scenarioSetId`; build the pitch from code | Assets ready: emit `ready`; invalid: `error CONFIG_INVALID`; asset missing: `error ASSET_LOAD_FAILED` |
| Intro | `ready` sent | One-line prompt card (Spot the trigger. Call the press.); camera to establishing preset; 2 s | Auto or tap-to-skip -> Playing |
| Playing | Round `i` starts (emit `progress` = i/N) | the scripted opposition build-up runs for `sequenceSeconds` while the ghost press shape holds | Decision moment reached -> Decision |
| Decision | Trigger frame reached | Time slows to 0.15x then `DecisionPoint` opens; the PRESS button is live throughout; a tap is scored against the scenario's trigger windows | Choice made or `timeLimit` expires -> Executing |
| Executing | Decision recorded | Play resumes at 1x showing the consequence of the choice (the home team presses (or does not) and the sequence resolves as won ball, forced long ball or broken press); round outcome recorded in `Score` | Consequence resolved -> Freeze |
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
| Trigger window length (s) | 1.8 | 1.4 | 1.1 | 0.9 | 0.7 |
| Trigger hint ring | always | on request | 1 use | no | no |
| Decoy movements | 0 | 1 | 2 | 2 | 3 |
| Hold scenarios (no trigger) share | 0 percent | 0 percent | 20 percent | 25 percent | 33 percent |
| Late-grace window after trigger (s) | 1.0 | 0.8 | 0.6 | 0.4 | 0.3 |
| Opposition shape | 4-3-3 | 4-3-3 | 4-2-3-1 | 3-4-3 | mixed |
| Scenario pool tag | `obvious` | `obvious`,`decoy` | `+hold` | `+trap` | `all` |

Level 1 is passable by a true beginner: a 1.8 s window, an always-on trigger ring and no decoys. **Defaults:** lesson `attack-05` launches at difficulty 2.
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
        "press-starter",
        "press-mixed"
      ],
      "default": "press-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 3,
      "maximum": 9,
      "default": 3
    },
    "pressShape": {
      "type": "string",
      "enum": [
        "4-4-2",
        "4-3-3",
        "4-2-3-1"
      ],
      "default": "4-4-2"
    },
    "showTriggerHints": {
      "type": "boolean",
      "default": true
    },
    "includeHoldScenarios": {
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
  "seed": 7,
  "scenarioSetId": "press-starter",
  "scenarioCount": 3,
  "pressShape": "4-4-2",
  "showTriggerHints": true,
  "includeHoldScenarios": false
}
```

Any value outside the ranges, an unknown `scenarioSetId`, or `scenarioCount` greater than the set size yields `error CONFIG_INVALID` (`recoverable=false`). Unknown extra keys are ignored by the bridge rules, but this schema sets `additionalProperties: false` so authoring typos are caught in CI.
## 11. Scenario data set

Format: JSON per `scenarioSetId` (`Scenarios/<setId>.json`). Sets: `press-starter` (8), `press-mixed` (8). Total authored: 16; minimum for 3 rounds x 3 is 9 (met). Each scenario is a keyframed sequence (`t` in seconds, positions in metres per section 6). `triggers[]` lists the valid press windows; an empty list marks a hold scenario. Deterministic per seed.

### p-001 Back pass to the keeper

```json
{
  "scenarioId": "p-001",
  "sequenceSeconds": 9,
  "oppShape": "4-3-3",
  "events": [
    {
      "t": 0.0,
      "ball": [
        0,
        -44
      ],
      "holder": "CB1"
    },
    {
      "t": 2.0,
      "ball": [
        -14,
        -40
      ],
      "holder": "CB2"
    },
    {
      "t": 3.4,
      "ball": [
        -22,
        -30
      ],
      "holder": "LB",
      "note": "LB receives on the touchline, facing forward"
    },
    {
      "t": 4.2,
      "ball": [
        -22,
        -30
      ],
      "holder": "LB",
      "note": "LB checks, no forward option"
    },
    {
      "t": 4.6,
      "ball": [
        -10,
        -42
      ],
      "holder": "CB2",
      "note": "back pass"
    }
  ],
  "triggers": [
    {
      "type": "back-pass",
      "t0": 4.6,
      "t1": 6.4
    }
  ],
  "resolution": {
    "pressOnTrigger": "won-ball-high",
    "pressEarly": "broken-press",
    "noPress": "safe-reset"
  },
  "teaches": [
    "pressing-trigger",
    "high-press"
  ],
  "tags": [
    "obvious"
  ]
}
```

### p-002 Heavy touch

```json
{
  "scenarioId": "p-002",
  "sequenceSeconds": 8,
  "oppShape": "4-3-3",
  "events": [
    {
      "t": 0.0,
      "ball": [
        0,
        -40
      ],
      "holder": "CB1"
    },
    {
      "t": 1.5,
      "ball": [
        6,
        -26
      ],
      "holder": "DM",
      "note": "DM receives on the half-turn"
    },
    {
      "t": 2.6,
      "ball": [
        9,
        -22
      ],
      "holder": "DM",
      "note": "heavy touch: ball drifts 3 m from his feet"
    }
  ],
  "triggers": [
    {
      "type": "heavy-touch",
      "t0": 2.6,
      "t1": 4.0
    }
  ],
  "resolution": {
    "pressOnTrigger": "won-ball-high",
    "pressEarly": "broken-press",
    "noPress": "recovered-touch"
  },
  "teaches": [
    "pressing-trigger",
    "pressing"
  ],
  "tags": [
    "obvious"
  ]
}
```

### p-003 Calm pivot: hold

```json
{
  "scenarioId": "p-003",
  "sequenceSeconds": 10,
  "oppShape": "4-2-3-1",
  "events": [
    {
      "t": 0.0,
      "ball": [
        0,
        -42
      ],
      "holder": "GK"
    },
    {
      "t": 2.0,
      "ball": [
        -8,
        -34
      ],
      "holder": "CB1"
    },
    {
      "t": 4.0,
      "ball": [
        -2,
        -24
      ],
      "holder": "DM",
      "note": "DM receives open-bodied with a passing lane both sides"
    },
    {
      "t": 6.0,
      "ball": [
        8,
        -14
      ],
      "holder": "AM",
      "note": "pass through the half-space"
    }
  ],
  "triggers": [],
  "resolution": {
    "pressOnTrigger": "n/a",
    "pressEarly": "broken-press",
    "noPress": "held-shape"
  },
  "teaches": [
    "mid-block",
    "pressing-trigger"
  ],
  "tags": [
    "hold"
  ]
}
```

**All scenarios (summary):**

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| p-004 | Pass to full-back on the touchline, closed body | Press (touchline trap trigger) | pressing-traps | trap |
| p-005 | Centre-back receives on weaker foot facing own goal | Press | pressing-trigger | obvious |
| p-006 | Slow lofted pass drops from the keeper | Press as ball drops | pressing-trigger | obvious |
| p-007 | Decoy: keeper rolls out then plays sideways with no danger | Hold | mid-block | decoy |
| p-008 | Two decoy jogs then a real bad touch at t=5.1 | Press at 5.1 | pressing-trigger | decoy |
| p-009 | Opposition switches to a back three with a free man | Hold; mid-block | mid-block | hold |
| p-010 | Back pass but home team's striker is offside-ish out of position | Press only if striker can reach; window closes at t=6.0 | pressing | mixed |

**Generation rules for scenarios beyond the authored set:** Compose scenarios from the trigger catalogue (`back-pass`, `heavy-touch`, `touchline-pass-closed-body`, `weak-foot-facing-goal`, `lofted-drop`) and 0-3 decoy events (a checked run, a look-up, a sideways pass); trigger window = the difficulty's window length starting at the cue frame; hold scenarios use only decoys. Generated scenarios must pass `ValidateWindows` (no overlapping windows, cue at least 1.0 s after start).
## 12. Freeze / explain moments

| Trigger | What freezes / camera | Callouts | Title (<= 6 words) | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|
| Correct press | Freeze at ball won; top-down | Gold ring on trigger cue; cover-shadow cone from nearest presser; arrows for the team's jump | The trigger was the moment | The back pass told the whole team to jump: the receiver has no good option, the cover shadow blocks the way out and the ball's won high. | "The back pass was the trigger." |
| Wrong: too early | Freeze at broken press; broadcast | Gap zone hatched; rose ring on early presser | Too early, gaps everywhere | Pressing without a cue leaves gaps between your lines. They played through the space and your team is beaten. Wait for the cue, then everyone goes. | "You press together or not at all." |
| Wrong: missed | Freeze at trigger frame; top-down | Gold ring on cue; timeline bar with missed window | The window closed | The cue was there for about a second. Miss it and the receiver settles and finds a pass. Spot the cue and call it fast. | "Press on the back pass, not after it." |
| Correct: hold | Freeze at held shape; top-down | Compact block outlined gold; open half-space marked | Patience is pressing too | No trigger meant no press. Staying compact in a mid-block keeps the half-spaces closed and waits for a mistake. | "You don't press every pass." |
| Wrong: pressed a calm build-up | Freeze at broken press; broadcast | Gap in the half-space hatched | Nothing to press yet | The receiver was open with options on both sides. Pressing there just opens the door. Hold your shape until a real cue appears. | "Pressing with no trigger just drags you out of shape." |

All copy is Swoon'd voice: cheeky coach, short sentences, never mean, never about the crush. Titles for the outcome are prefixed by the app-level banner "Nice read." (correct) or "Not quite." (wrong); the sim shows the title below as the card title. Never rely on colour alone (pair with the banner text, icon and the shape/pattern second channel).
## 13. Scoring & mastery signals

- **Round score:** trigger round: 100 if PRESS inside the window; 50 if within the late-grace window; 0 if early, late beyond grace, or no press. Hold round: 100 if no press; 0 if pressed. **Session score:** mean, rounded. **Accuracy:** rounds scoring 100 / rounds.
- **Outcome ids:** `round-1`..`round-N`; `value` = tap time relative to the window start (ms), or null.
**Mistake -> conceptId mapping:**

| mistake | conceptId | description text |
|---|---|---|
| PRESS before the window (early) | pressing-trigger | Pressed before there was a trigger. |
| No press during a window (missed) | pressing-trigger | Missed the trigger window. |
| Pressed during a hold scenario | mid-block | Pressed a calm build-up. |
| Fell for a decoy | pressing-traps | Pressed on a decoy movement. |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; hints used halve positive deltas at native):

| event | conceptId | delta | evidence text |
|---|---|---|---|
| Correct trigger press | pressing-trigger | +0.20 | Pressed inside the window. |
| Correct trigger press on a high-press scenario | high-press | +0.15 | Won the ball high. |
| Correct hold | mid-block | +0.20 | Held shape without a trigger. |
| Ignored decoy correctly | pressing-traps | +0.10 | Did not press on a decoy. |
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
- **VoiceOver/TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson: `attack-06` (term-match and multiple-choice on the blocks) plus a `timing-tap` reaction drill, so the concept can be learned without Unity.
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
| Pitch, ghost press shape, cones | procedural | original | ~3k tris, 0 textures | cover shadow as a translucent mesh |
| Players (capsule figures) | procedural | original | ~600 tris each | two kits with patterns |
| Scenario JSON | data | original | < 150 KB | 16 scenarios |
| Fonts | external | Instrument Serif and Geist (OFL) subset | < 300 KB |  |

Overlay styling per `docs/astra/ART_DIRECTION.md` section 4: rose = you/act, gold = earned/correct, zones translucent with `strokeStrong` borders, callouts on `surface` cards with 20 px radius. **Addressables bundle:** `sims-soccer-pressing-trigger-call` expected <= 6 MB (scenario JSON + fonts subset; no external textures).
## 19. Performance budget

Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (p5 >= 50 fps), < 150 MB resident, cold launch < 2 s, per-sim download <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state <= fair over 3 minutes. **Tighter for this sim:** At most 21 characters on screen; keyframe playback must not allocate per frame.
## 20. Telemetry

`telemetry` carries only diagnostics: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `tapLatencyMs` (median, relative to window start), `earlyTaps`, `missedWindows`, `hintsUsed`. No personal data (`personName`, `relationship`), no free text, no device identifiers.
## 21. Acceptance criteria (testable)

- **AC-1:** With seed 7, difficulty 2, `scenarioCount` 3 the sim emits 3 `outcomes`.
- **AC-2:** A PRESS tap at trigger window start + 0.5 s in `p-001` yields `success=true`, a `pressing-trigger` +0.20 signal and resolution `won-ball-high`.
- **AC-3:** A PRESS tap at t=3.0 s in `p-001` (before the window) yields `success=false`, mistake `pressing-trigger` and resolution `broken-press`.
- **AC-4:** In hold scenario `p-003`, no tap yields `success=true` and a tap at any time yields a `mid-block` mistake.
- **AC-5:** At difficulty 5 the window length is 0.7 s (+/- 20 ms) and the late-grace is 0.3 s.
- **AC-6:** Bridge conformance: given `docs/contracts/unity-bridge/v1/examples/*-launch.json`-style input for this sim, Unity emits `ready`, at least one `progress`, one `checkpoint` per round, exactly one `result` and then `requestExit`; the result validates against `simulation-result.schema.json`.
- **AC-7:** Determinism: with the same `seed`, `difficulty` and `scenarioSetId`, two runs with identical scripted inputs produce identical `outcomes[]`, `score` and `masterySignals[]`.
- **AC-8:** Invalid configuration (out-of-range value, unknown `scenarioSetId`) yields `error CONFIG_INVALID` within 500 ms and no `result`.
- **AC-9:** Pause stops sim time and the decision timer; after 30 s paused and `resume`, the decision time remaining is unchanged (+/- 50 ms).
- **AC-10:** Abort at any state produces exactly one `result` with `aborted=true`, `completed=false`, the matching `abortReason` and `xpEarned=0` within 1 s.
- **AC-11:** Accessibility: with `reducedMotion=true` no camera sweep or slow-motion ramp is used and Freeze is a hard cut; with `colorBlindMode` set, every colour-coded element has a second channel (icon or pattern).
- **AC-12:** Copy limits: every explanation title is <= 6 words and every body <= 45 words (checked by an EditMode test over the scenario data).
- **AC-13:** Budgets: p5 fps >= 50, peak memory < 150 MB, cold launch to `ready` < 2 s on iPhone 13-class.
## 22. Test plan

- **EditMode:** `TimedWindowObjective` evaluation for all authored scenarios; `ValidateWindows`; scoring for early, late-grace, missed and hold cases. Config validation against the section 10 schema; result schema validity; scoring maths; determinism by seed; copy-length limits.
- **PlayMode:** scene builds from code; full run with scripted inputs (one correct, one wrong, one timeout); freeze/explain sequence; pause/resume/abort; reduced-motion path; tap-only scheme.
- **Perf:** measured 3-minute run on an iPhone 13-class device; report fps, memory and thermal state.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Outcomes_Count_Seed7 |
| AC-2 | EditMode | Window_Hit_P001 |
| AC-3 | EditMode | Window_Early_P001 |
| AC-4 | EditMode | Hold_Scenario_P003 |
| AC-5 | EditMode | Difficulty5_Windows |
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
| 1 | Should the ghost press shape be user-selectable, or fixed per lesson? | Product | No |
| 2 | Confirm the 12 s auto-end feels right in playtests. | Astra | No |
| 3 | Can `ScriptedSequence` share tooling with the overload sim? | Astra | No |

## Game Kit additions requested

- `ScriptedSequence` (deterministic keyframed choreography for players and ball; scenario-driven).
- `TimedWindowObjective` (input-inside-window objective; reports latency).
- `CoverShadow` overlay (cone geometry behind a presser).
- Continuous mode for `DecisionPoint` (button live during Playing, no freeze).
Reusable by `soccer.setpiece.corner-read.v1` and `soccer.attack.overload-find.v1`.
