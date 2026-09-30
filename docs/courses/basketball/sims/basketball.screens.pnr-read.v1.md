# Pick-and-Roll Read (`basketball.screens.pnr-read.v1`)

> Spec for Astra (Unity). Authored by Swoon'd curriculum design for the Basketball course. Follows `docs/astra/SIM_SPEC_TEMPLATE.md`; section numbers are stable.

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `basketball.screens.pnr-read.v1` |
| simulationVersion | `1.0.0` (major 1 equals `.v1` in the id) |
| Spec status | draft |
| Contract versions | Bridge `1.0.x` (`docs/contracts/unity-bridge/v1/`); sim-definition `1.x` (scenario-data driven; no custom definition file required for v1) |
| Authors / date | Swoon'd curriculum design (Claude Code) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `basketball`; `unitId`: `actions`, `film-room`; `lessonId`s: `act-03`, `flm-03` (`act-03` at difficulty 1-3; `flm-03` at difficulty 4-5).
- CDS: `docs/courses/basketball/CDS.md`, section 12 Interaction plan, row "Ball-screen coverage read: choose the best action against what the defense does".
- Manifest entry: `docs/courses/basketball/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `pick-and-roll`, `screener`, `ball-handler`, `drop-coverage`, `switch`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can watch a ball screen, name what the defense is doing (drop, hedge, blitz, switch or ice) and pick the action it gives up.
| conceptId | term | after this the learner can |
|---|---|---|
| `pick-and-roll` | Pick-and-roll | Follow the screen, the handler and the screener as one play. |
| `drop-coverage` | Drop coverage | Recognize the big sinking and pick the pull-up. |
| `hedge-show` | Hedge / show | Recognize the big stepping out and attack before he recovers. |
| `blitz-trap` | Blitz / trap | Recognize the double team and release to the screener. |
| `switch` | Switch | Recognize the swap and hunt the mismatch. |
| `ice-coverage` | Ice | Recognize the sideline push and decline the screen. |
| `coverage-reading` | Coverage reading | Name the coverage from the defenders' first two steps. |
| `short-roll` | Short roll | Explain why the screener catches the ball at the free-throw line vs a trap. |
| `pocket-pass` | Pocket pass | Recognize a pass to the screener through the gap. |
| `reject-the-screen` | Reject the screen | Explain why a handler declines the screen against ice. |
| `mismatch` | Mismatch | Say why a big on a guard, or a guard on a big, is a target. |

- **Out of scope:** Advanced coverages (top-lock, tag, scram, peel switches), weak-side rotations and shot-making percentages are out of scope; those are `flm-03` native follow-ups. The defense is scripted per coverage and is not adaptive.

## 4. Why Unity (tier justification)
- **Rubric answer:** reading a dynamic scene and timing in a scene. A coverage exists only in the way two defenders move over about a second; a static diagram removes exactly the cue the learner must read (how far the screener's defender drops, whether the second defender steps out).
- **Camera perspective:** the broadcast-baseline view and a slow-motion decision window reproduce what a fan sees on TV, so the learner builds the recognition they will use with a real game on.
- **Closest native types:** `decision-scenario` (fact sheet) and `multiple-choice` (name the coverage) can teach vocabulary, but they hand the answer over as text ("the big is dropping"). The skill is noticing it from movement, which only a moving scene can train.
- **Verdict:** Tier A. Native `term-match` (coverages) and `sequence-order` (pick-and-roll steps) prepare the vocabulary in `act-01` and `act-02`.

## 5. Player fantasy & core loop
- **Fantasy:** You are the point guard with the whole floor in front of you: read the screen, read the defense, make the play.
- **Core loop** (prompt -> one decisive interaction -> execute -> freeze/explain -> line you could say out loud):
  1. **Prompt:** serif line "Read the screen." A pick-and-roll starts: handler at the top, screener sets the screen, the two defenders react (0-1.4 s of real play).
  2. **Slow motion:** the scene drops to 0.25x and the decision window opens; at difficulty 4-5 the learner first taps the coverage name.
  3. **Decision:** tap one of up to five actions: pull-up, attack the gap, pass to the screener, attack the mismatch, reject and swing.
  4. **Execute and freeze:** the chosen action plays for 2-3 s; freeze on the payoff (open shot, contested shot, blocked drive).
  5. **Explain and say:** coverage name, what it gives up, and one line to say out loud.
- **Session length:** About 3 minutes: 3 rounds; each round is about 15 s of play, 10 s of decision and 20 s of explain.

## 6. Scene & entities
- **Environment:** `basketball_half_court`; camera left/right variants mirrored by `side`.
- **Camera presets:** `broadcast-baseline` (default, behind the baseline, FOV 55); `top-down-half-court` (freeze and replay); `broadcast-side` (optional replay at level 4-5).
- **Court coordinates (all sims):** feet, origin at the rim center, +y toward half court, +x to the viewer's right when looking from the baseline toward half court. Baseline y = -5.25, half-court line y = 41.75, sidelines x = +/-25, lane x = +/-8 (free-throw line y = 13.75), restricted-area arc radius 4, three-point arc radius 23.75 with corner lines at x = +/-22 up to y = 8.75 (NBA dimensions; college/WNBA arc 22.146 ft can be selected via `configuration.league` where noted).
| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| ball_handler | `Character` | Offense guard using the screen | profile driver-guard or shooter-guard |
| screener | `Character` + `PlayerRole` | Big who sets the screen and then rolls or pops | type roller (attacks the rim) or popper (steps out) |
| off_1..off_3 | `Character` | Weak-side teammates (corner, wing, opposite corner) | stand at corner-l, wing-r, corner-r; `shootThreat` 1 |
| d_ball | `Character` (defender) | Guards the ball handler; goes over the screen or trails | speed 15 ft/s |
| d_screen | `Character` (defender) | Guards the screener; performs the coverage | coverage path from data (drop, hedge, blitz, switch, ice) |
| d_weak_1..3 | `Character` (defender) | Stay home on shooters; one tags the roller in later levels | stay-home radius 3 ft |
| screen | `Zone` | Screen contact point and zone for the "level of the screen" cue | position (3, 25) mirrored by `side` |
| actions | `Target` x5 + `DecisionPoint` | The five action buttons | ids pull-up, attack-gap, short-roll-pass, attack-mismatch, reject-swing |
| call_chips | `Target` x5 | Coverage name chips (levels 4-5) | labels Drop, Hedge, Blitz, Switch, Ice |
| cues | `Highlight` + `Hint` | Cue arrows (level 2-3) and gold glow (level 1) | uses counted in `hintsUsed` |
| camera / slowmo | `CameraRig`, `SlowMotion` | Presets; 0.25x window | reduced motion: cuts and a still-frame pair |

- **Reused vs new:** Reused: `Character`, `Ball`, `Target`, `Zone`, `Path`, `CameraRig`, `TouchController`, `DecisionPoint`, `Hint`, `Explanation`, `Score`, `Replay`, `SlowMotion`, `Highlight`, and the Basketball module from `basketball.spacing.floor-spacing.v1`. New: `Swoond.Sports.Basketball.Coverage` (data-driven ball-screen coverage choreography) and `ScreenAction` (handler + screener choreography). Both reusable for future handoff and pindown sims.
- **Layout diagram:**
```
   half court (y = 41.75)
        [off-2 wing-r]      [BH] top (0,28)
                     (screen) o(3,25)  <- screener
   [d_screen] follows the coverage path
        [off-1 corner-l]                [off-3 corner-r]
   --------------------- rim (0,0) ----------------------
   coverage cues: DROP  = d_screen at (2,17)   HEDGE = d_screen at (1,27)
                  BLITZ = d_screen + d_ball within 3 ft of BH   SWITCH = swap   ICE = d_ball on the high side
```

### 6.1 Game Kit additions requested
- **`Swoond.Sports.Basketball.Coverage`:** ball-screen coverage as data (drop, hedge, blitz, switch, ice), each a keyframed path for `d_screen` and `d_ball` with named cue frames; accepts `side` (mirror) and `screenerType`.
- **`ScreenAction`:** choreographs handler, screener and screen contact with timings (signal 0.0 s, screen contact 0.9 s, coverage commit 1.0-1.6 s, decision window 1.4 s).
- **`SlowMotion` decision window:** hold at 0.25x for up to `decisionTimeLimitSec` real seconds and expose remaining time (already in kit; requests a visible ring timer style).
- **Registry keys:** objective type `read_and_choose`; demonstrate type `coverage_cue`.

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose action | Tap one of the action buttons (arc at bottom, one thumb) | actions | 56 pt each | Button fills rose; light haptic |
| Call the coverage (L4-5) | Tap a coverage chip before the actions unlock | call_chips | 56 pt each | Chip locks; correct/incorrect shown after Explain |
| Hint | Tap the lightbulb | hint | 44 pt | Cue arrow appears on the screener's defender |
| Replay (Summary) | Tap "Watch again" | Replay | 56 pt | Slow-motion replay of the last round (native may relaunch) |
| Exit | Tap X | requestExit | 44 pt | `requestExit user-quit` |

- **Accessible alternative (tap-only):** All inputs are single taps. No drags, holds or swipes exist in this sim; the timer (levels 3-5) has an optional "extend time" accessibility flag from `learnerContext.accessibility` that doubles `decisionTimeLimitSec`.
- **Orientation / safe area:** portrait; interactive targets stay above the bottom safe-area inset and clear of the top `runtime.safeAreaInsets.top` plus 12 pt; landscape is not supported in v1.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation ("Leave game?"), permission prompts, lesson chrome. Unity may draw an X that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate `contractVersion`, `simulationId`, `configuration`; load scenario JSON and build the world from code; apply theme and accessibility flags. | Scene built -> Intro; failure -> `error` (CONFIG_INVALID / ASSET_LOAD_FAILED) | `ready` (with `gameKitVersion`, `loadTimeMs`) |
| Intro | World built | Prompt card (one line, serif) and a 1.2 s establishing shot. Show the handler with the ball, screener approaching, defense in man alignment. | Tap "Go" or auto after 3 s -> Playing | `progress` 0.0 |
| Playing | Intro finished | Round `i` of `n` begins. Handler signals; screener sets the screen; defenders commit to the coverage. | Decision window opens -> Decision | `progress` (throttled <= 4/s) |
| Decision | Decision window open | DecisionPoint slows or holds the sim. Slow motion 0.25x; action buttons enable (and call chips first at L4-5); ring timer if a limit is set. | Choice locked or limit hit (counts as no answer = incorrect) -> Executing | none |
| Executing | Choice locked | Sim plays out deterministically for 2-5 s. The chosen action plays (pull-up shot, drive, pocket pass, isolation drive, or reject and swing). | Outcome determined -> Freeze | none |
| Freeze | Outcome determined | Time scale eases to 0 over 250 ms (hard cut under reduced motion); scene dims 35% except focal entities. Ball handler and both screen defenders in focus; the open space is shaded gold. | Focal highlight done -> Explain | `checkpoint` (round id) |
| Explain | Freeze complete | Callouts appear one at a time (250 ms each), then the copy card and the say-this line. Card names the coverage, then says what it gave up. | Tap Continue -> Playing (next round) or Summary | none |
| Summary | Last round explained | Score numerals count up over 600 ms; three outcome pips; the one line to say out loud. | Auto after 4 s or tap -> Done | `progress` 1.0 |
| Done | Summary finished | Build `SimulationResult`; emit result then request exit. | Unity idle | `result`, then `requestExit` (`completed`) |
| Paused | Native `pause` | Stop sim time, timers, audio and haptics; keep the frame. | `resume` -> previous state | none |
| Aborted | Native `abort` or X confirmed | Stop immediately; build a partial result. | Emit result -> exit | `result` (`aborted=true`), `requestExit` |

Pause/abort: native `pause` freezes sim time, timers and audio in any state and resumes exactly; `abort` moves to Aborted from any state and emits one result with `aborted=true`.

## 9. Difficulty levels 1-5
| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Coverage families in pool | drop, hedge | drop, hedge, switch | + blitz | all five | all five, mixed with late switch |
| Options shown | 3 | 4 | 5 | 5 | 5 |
| Cue support | coverage name shown + gold glow on best | cue arrows on d_screen | subtle arrow (hint only) | none | none |
| Call the coverage first | no | no | no | yes | yes |
| Decision window (real seconds at 0.25x) | no limit | 8 | 6 | 5 | 3 |
| Screener type | roller | roller | mixed | mixed | mixed |
| Scenario pool tags | L1 | L1-2 | L2-3 | L4 | L5 |

- **Default difficulty for the lesson:** 2 for `act-03`; 4 for `flm-03`. Level 1 is passable by a true beginner with hints (hint text and highlights always on).

## 10. Configuration schema
`LaunchRequest.configuration` (draft 2020-12). Invalid configuration yields `error CONFIG_INVALID`.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "basketball.screens.pnr-read.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": {
      "type": "integer",
      "minimum": 0
    },
    "scenarioSetId": {
      "type": "string",
      "enum": [
        "pnr-starter",
        "pnr-advanced"
      ],
      "default": "pnr-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 1,
      "maximum": 12,
      "default": 3
    },
    "coverageFamilies": {
      "type": "array",
      "uniqueItems": true,
      "minItems": 1,
      "items": {
        "type": "string",
        "enum": [
          "drop",
          "hedge",
          "blitz",
          "switch",
          "ice"
        ]
      },
      "default": [
        "drop",
        "hedge",
        "switch"
      ]
    },
    "showCoverageLabel": {
      "type": "boolean",
      "default": true
    },
    "requireCoverageCall": {
      "type": "boolean",
      "default": false
    },
    "decisionTimeLimitSec": {
      "type": "integer",
      "minimum": 0,
      "maximum": 12,
      "default": 0,
      "description": "Real seconds inside the 0.25x window; 0 = no limit."
    },
    "screenerType": {
      "type": "string",
      "enum": [
        "roller",
        "popper",
        "mixed"
      ],
      "default": "roller"
    },
    "assetRoot": {
      "type": "string"
    }
  }
}
```

Valid example:

```json
{
  "seed": 7,
  "scenarioSetId": "pnr-starter",
  "scenarioCount": 3,
  "coverageFamilies": [
    "drop",
    "hedge",
    "switch"
  ],
  "showCoverageLabel": true,
  "requireCoverageCall": false,
  "decisionTimeLimitSec": 8,
  "screenerType": "roller"
}
```

## 11. Scenario data set
Each scenario is a **coverage** plus variation dimensions: ball handler profile (`driver-guard` / `shooter-guard`), screener type (`roller` / `popper`), `side` (left / right; mirrors the scene). The choreography for each coverage is in the `Coverage` module data; scenarios only choose parameters. `pnr-starter` = pnr-01..pnr-07; `pnr-advanced` = pnr-05..pnr-12.

**Scenario count:** at least **12** authored scenarios (3 rounds x 3 minimum for replay variety), stored as `Scenarios/pnr.json` (JSON, versioned with the sim). Selection is deterministic per `configuration.seed`.

**Verdict table (authoritative):** each coverage has one best action, at most one acceptable action, and poor actions.

| coverage | best (score 100) | acceptable (60) | poor (0) | why |
|---|---|---|---|---|
| drop | `pull-up` | `reject-swing` | `attack-gap`, `short-roll-pass`, `attack-mismatch` | Big sinks to the paint; space above the screen is open. |
| hedge | `attack-gap` | `short-roll-pass` | `pull-up`, `reject-swing`, `attack-mismatch` | Big steps out then recovers; turn the corner before he gets back. |
| blitz | `short-roll-pass` | `reject-swing` | `pull-up`, `attack-gap`, `attack-mismatch` | Two defenders trap the ball; the screener is open behind them (4-on-3). |
| switch | `attack-mismatch` | `pull-up` | `short-roll-pass`, `attack-gap`, `reject-swing` | Defenders swap; hunt the mismatch. |
| ice | `reject-swing` | none | `pull-up`, `attack-gap`, `short-roll-pass`, `attack-mismatch` | Guard blocks the screen side; decline the screen and move the ball. |

Coverage cue definitions (frames after screen contact at t = 0.9 s): **drop** - `d_screen` retreats to (2,17) by t = 1.4 s, `d_ball` trails the handler; **hedge** - `d_screen` steps to (1,27) level with the handler by t = 1.2 s, then recovers by t = 2.0 s; **blitz** - `d_screen` and `d_ball` are both within 3 ft of the handler by t = 1.3 s; **switch** - the two defenders swap men by t = 1.2 s with a "switch" call icon; **ice** - `d_ball` stands on the high side of the handler (screen side) before contact, `d_screen` sits at (2,20).

| scenarioId | coverage | ball handler | screener | side | difficulty | cue note |
|---|---|---|---|---|---|---|
| pnr-01 | drop | driver-guard | roller | left | L1 | Cue: big 6 ft below the screen |
| pnr-02 | hedge | driver-guard | roller | right | L1 | Cue: big steps out level with the ball |
| pnr-03 | switch | shooter-guard | popper | left | L2 | Cue: both defenders point and swap |
| pnr-04 | drop | shooter-guard | popper | right | L2 | Mirror of 01 with a popper |
| pnr-05 | blitz | driver-guard | roller | left | L3 | Cue: two defenders converge on the ball |
| pnr-06 | ice | driver-guard | roller | right | L3 | Cue: guard on the high side pushes baseline |
| pnr-07 | hedge | shooter-guard | popper | left | L3 | Hedge with a popper: pass to the pop |
| pnr-08 | switch | driver-guard | roller | right | L4 | Switch onto a slower big |
| pnr-09 | blitz | shooter-guard | popper | left | L4 | Blitz with a popping screener |
| pnr-10 | ice | shooter-guard | popper | left | L5 | Ice on a shooter guard |
| pnr-11 | drop | driver-guard | roller | left | L5 | Drop with a low-wall helper (harder cue) |
| pnr-12 | switch | shooter-guard | roller | right | L5 | Late switch after the screen contact |

**Fully written first three**

1. **`pnr-01`** - prompt "Read the screen." Handler: driver-guard; screener: roller; side left; coverage **drop**. Play: screen at (3,25); `d_screen` sinks to (2,17). Best: `pull-up` (the shot is open by 5 ft; result "open jumper"). Acceptable: none. Poor examples: `attack-gap` (blocked by the sunk big, result "drive stopped at the free-throw line"), `short-roll-pass` ("pass covered by the drop big").
2. **`pnr-02`** - handler driver-guard; screener roller; side right; coverage **hedge**. `d_screen` steps out to (1,27), then recovers. Best: `attack-gap` (turn the corner before he recovers; result "downhill, foul or layup"). Acceptable: `short-roll-pass` (the roller catches at the free-throw line in a 4-on-3). Poor: `pull-up` (hand in his face).
3. **`pnr-03`** - handler shooter-guard; screener popper; side left; coverage **switch**. Defenders swap; the big now guards the guard. Best: `attack-mismatch` (isolate and drive past the slower big; result "blow-by"). Acceptable: `pull-up` (space to shoot over a big who stays back). Poor: `short-roll-pass` (the popper is now guarded by a guard who is closer).

**Scenarios 04-12** follow the table; generation rules for more: (a) alternate side each scenario; (b) never repeat the same coverage twice in a row; (c) at difficulty <= 2 use roller only; (d) pair each coverage with a driver-guard once and a shooter-guard once across the pool; (e) deterministic per seed by seeded shuffle of the pool within the difficulty tag.

## 12. Freeze / explain moments
Copy rules: title <= 6 words, body <= 45 words, optional say-this line in quotes. Voice: cheeky coach, warm, a little flirty, never condescending, never about the crush.

### 12.1 Coverage: Drop
- **Trigger:** Outcome of the chosen action is determined.
- **What freezes:** The ball handler at the decision point (big 6 ft below the screen).
- **Camera:** `broadcast-baseline` high, then `top-down-half-court` (cut under reduced motion).
- **Callouts:** Gold ring and arrow on the best target; rose ring on the learner's choice; a card with the coverage name in eyebrow style; the screener's defender ringed.
- **Correct outcome copy** - Title: "Drop: take the open shot." | Body: "The big dropped to protect the rim, which leaves space above the screen. A guard who can shoot takes that space. Teams that live in drop are daring you to make that shot." | Say this: "They're in drop, so he takes the pull-up."
- **Incorrect outcome copy** - Title: "Into the big's wall." | Body: "The big sank to guard the paint, so driving or passing to the roller runs straight into him. The gift is the open shot above the screen. Take what the defense gives." | Say this: "Are they in drop? Why is he driving into the big?"

### 12.2 Coverage: Hedge
- **Trigger:** Outcome of the chosen action is determined.
- **What freezes:** The ball handler at the decision point (big level with the ball).
- **Camera:** `broadcast-baseline` high, then `top-down-half-court` (cut under reduced motion).
- **Callouts:** Gold ring and arrow on the best target; rose ring on the learner's choice; a card with the coverage name in eyebrow style; the screener's defender ringed.
- **Correct outcome copy** - Title: "Hedge: turn the corner." | Body: "The big stepped out to slow you, then had to run back. That gap lets you turn the corner and go downhill before he recovers. Good handlers attack it fast." | Say this: "That's a hedge. He got downhill before the big got back."
- **Incorrect outcome copy** - Title: "Too slow for the hedge." | Body: "The big stepped out and jumped into your face, so the jumper was contested. The window is short: attack the moment he steps out, before he recovers to the screener." | Say this: "He hedged, so the pull-up was contested."

### 12.3 Coverage: Blitz
- **Trigger:** Outcome of the chosen action is determined.
- **What freezes:** The ball handler at the decision point (two defenders on the ball).
- **Camera:** `broadcast-baseline` high, then `top-down-half-court` (cut under reduced motion).
- **Callouts:** Gold ring and arrow on the best target; rose ring on the learner's choice; a card with the coverage name in eyebrow style; the screener's defender ringed.
- **Correct outcome copy** - Title: "Blitz: release to the screener." | Body: "Two defenders trapped the ball, so a teammate is open. The screener, behind the trap at the free-throw line, is the release. Move the ball before the trap closes." | Say this: "They blitzed him, so the big is open on the short roll."
- **Incorrect outcome copy** - Title: "Trapped. Get it out." | Body: "The double team took your space. Holding the ball or shooting through two defenders is how turnovers happen. Pass to the screener; the defense is a man short behind the trap." | Say this: "When they blitz, where does the ball go?"

### 12.4 Coverage: Switch
- **Trigger:** Outcome of the chosen action is determined.
- **What freezes:** The ball handler at the decision point (defenders swapped).
- **Camera:** `broadcast-baseline` high, then `top-down-half-court` (cut under reduced motion).
- **Callouts:** Gold ring and arrow on the best target; rose ring on the learner's choice; a card with the coverage name in eyebrow style; the screener's defender ringed.
- **Correct outcome copy** - Title: "Switch: hunt the mismatch." | Body: "After the swap, the wrong defender is on you. Attack the one who cannot keep up, whether that is a big on a guard or a guard on a big. Offenses call that hunting." | Say this: "They switched, so now he's hunting the mismatch."
- **Incorrect outcome copy** - Title: "You gave the mismatch away." | Body: "The switch put the slow defender on you, which was the opening. Shooting or passing wastes it. Take the mismatch on the dribble while the defense scrambles." | Say this: "He had a big on him. Why didn't he just attack?"

### 12.5 Coverage: Ice
- **Trigger:** Outcome of the chosen action is determined.
- **What freezes:** The ball handler at the decision point (guard on the high side).
- **Camera:** `broadcast-baseline` high, then `top-down-half-court` (cut under reduced motion).
- **Callouts:** Gold ring and arrow on the best target; rose ring on the learner's choice; a card with the coverage name in eyebrow style; the screener's defender ringed.
- **Correct outcome copy** - Title: "Ice: decline the screen." | Body: "The guard is blocking the screen side, sending you toward the sideline. Turn down the screen and swing the ball. Ice works because it takes away the middle. Move it and make them move." | Say this: "That's ice. He rejected the screen and swung it."
- **Incorrect outcome copy** - Title: "Pushed to the sideline." | Body: "Ice sends you to the sideline, where the big is waiting to help. Using the screen anyway walks into a trap. Reject it and move the ball to a teammate." | Say this: "Why did he use the screen if they were icing it?"

### 12.6 Summary line
- **Trigger:** All rounds explained.
- **What freezes:** Not frozen: Summary screen.
- **Camera:** Static broadcast-baseline still.
- **Callouts:** Five coverage chips; the ones you read correctly glow gold.
- **Correct outcome copy** - Title: "You read the defense." | Body: "You saw what the defense gave up and took it. That is what commentators mean by reading the coverage. The screen is the same; the answer changes with the defense." | Say this: "What coverage are they in? That's why he pulled up."
- **Incorrect outcome copy** - Title: "Watch the big." | Body: "Start with the screener's defender: does he drop, step out, trap or swap? His first two steps name the coverage. Try it again and watch him first." | Say this: "What is the big doing on this screen?"

## 13. Scoring & mastery signals
- **Score formula (0-100):** Action score per round: best 100, acceptable 60, poor 0 (no answer = 0). At levels 4-5 the round score = 0.8 x action score + 0.2 x (100 if the coverage call was correct else 0). Session score = round(mean of round scores).
- **Accuracy:** Rounds where the action was `best` divided by rounds played.
- **Outcome ids:** `round-1`..`round-N` (`label` e.g. "Read drop: pull-up"), `value` = coverage id; at levels 4-5 also `call-1`..`call-N` with `success` = call correct and `value` = the coverage the learner named.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (<= 240 chars) |
|---|---|---|
| Drove or passed into a dropping big | `drop-coverage` | Attacked the paint against drop coverage instead of taking the open jumper above the screen. |
| Pulled up against a hedge | `hedge-show` | Shot into the big who stepped out instead of turning the corner. |
| Shot or held the ball against a blitz | `blitz-trap` | Stayed in the trap instead of releasing to the screener. |
| Passed or shot after a switch instead of attacking the mismatch | `switch` | Wasted the switch: the mismatch was there to attack. |
| Used the screen against ice | `ice-coverage` | Used the screen into an ice coverage instead of rejecting it. |
| Named the wrong coverage (L4-5) | `coverage-reading` | Called the coverage incorrectly from the screener's defender. |

**Mastery signals** (per-session caps: +0.4 / -0.3 per concept per session; total absolute delta <= 1.4.)

| event | conceptId | delta (-1..1) | evidence text |
|---|---|---|---|
| Best action vs drop | `drop-coverage` | 0.25 | Took the pull-up space against the sunk big. |
| Best action vs hedge | `hedge-show` | 0.25 | Attacked before the hedger recovered. |
| Best action vs blitz | `blitz-trap` | 0.25 | Released to the screener behind the trap. |
| Best action vs switch | `switch` | 0.25 | Hunted the mismatch. |
| Best action vs ice | `ice-coverage` | 0.25 | Rejected the screen. |
| Correct coverage call | `coverage-reading` | 0.2 | Named the coverage from the first two steps. |
| Best action (any) with pass to screener | `short-roll` | 0.15 | Found the short roll against pressure. |
| Best action (any) | `pick-and-roll` | 0.1 | Read the pick-and-roll to the right action. |
| Poor action | `mismatch` | -0.05 | Did not attack a clear mismatch (switch rounds only). |

**Mapping to `SimulationResult`:** Rounds -> `outcomes[]` (and `call-i` at L4-5); mistake rows -> `mistakes[]` with `at`; signal rows -> `masterySignals[]`; `score` and `accuracy` per above; `xpEarned`/`heartsLost` per section 14.

## 14. XP & hearts
- **`xpEarned` proposal:** +10 per successful round, +40 for finishing all rounds (native clamps to the lesson XP budget); hint use does not reduce XP but native halves mastery gain when `telemetry.hintsUsed > 0`. Bonus: +5 (native clamps) if all coverage calls are correct at level 4-5.
- **`heartsLost`:** 1 if fewer than half the rounds succeed at difficulty >= 2; otherwise 0; never more than 1 per session; 0 at difficulty 1. Aborted, timeout or error sessions lose no hearts.
- **`replayAvailable`:** `true` after Summary when at least one round was recorded (Replay primitive); native may show a "Watch again" affordance that relaunches with the same seed at no XP.

## 15. Failure states
| Situation | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round | Explain moment for the incorrect outcome with the correct answer highlighted gold; then next round | `outcomes[i].success=false`, `mistakes[]` entry, negative `masterySignals` | Counts toward the session rule above |
| Failed session (fewer than half rounds correct) | Summary with the line "We'll run it back." and one "Try again" (native) plus lesson primer offer | `completed=true`, low `score`, `xpEarned` = successes x 10 only | Max 1 |
| Timeout (`runtime.maxDurationMs`) | Native aborts; Unity shows a short freeze card | `aborted=true`, `abortReason=timeout`, partial `outcomes`, `xpEarned=0` | 0 |
| Abort / user quit | Native "Leave game?" then close | `aborted=true`, `abortReason=user-quit` or `native-abort`, partial `outcomes` | 0 |
| Backgrounded > 120 s | Native aborts on return | `abortReason=backgrounded-too-long` | 0 |
| Asset missing | Native retry sheet | `error ASSET_LOAD_FAILED`, `recoverable=true` | 0 |
| Invalid configuration | Native friendly error and skip | `error CONFIG_INVALID`, `recoverable=false` | 0 |
| Decision window expires | The buttons lock and the sim runs the default "hold the ball" action, which is `poor` in every coverage | `outcomes[i].success=false`, mistake for the coverage | Counts toward the session rule |

Failure always teaches: every failed round ends in an explain moment; there is no dead-end screen.

## 16. Accessibility
- **Reduced motion:** Freeze is a hard cut (no ease); camera moves become cuts; no shake; pulsing rings become static rings; slow-motion replay is replaced by paired stills (before/after) with the same callouts.
- **Haptics off:** all cues fall back to on-screen text/shape only.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): team colors differ in luminance and every color meaning has a second channel: action buttons use icons and text labels (not color); defenders are marked with hollow rings and a short letter (B = ball defender, S = screen defender); best target ring is a gold double ring, the learner's choice a rose single ring.
- **Text scale:** overlay text follows `textScale` up to 2.0; callout cards reflow and scroll if needed; explanation copy is never truncated.
- **Tap-only:** All inputs are single taps. No drags, holds or swipes exist in this sim; the timer (levels 3-5) has an optional "extend time" accessibility flag from `learnerContext.accessibility` that doubles `decisionTimeLimitSec`.
- **VoiceOver / TalkBack:** Unity content has limited screen-reader support. Accessible native fallback lesson (a designed exercise, not a port): `pnr-native-decisions`: three `decision-scenario` items ("Your guard sees a big dropping to the free-throw line. What do you do?") with the same verdict table as text, plus a `term-match` of the five coverages.
- Decision windows honor the "extend time" flag (doubles `decisionTimeLimitSec`).

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Scene ready | soft ball-bounce tick | none | -18 dB |
| Decision window opens | low chime | soft tap | -16 dB |
| Correct outcome | warm two-note rise | light success | -14 dB |
| Incorrect outcome | muted thud | warning | -14 dB |
| Freeze | soft whoosh, pitch drop | soft tap | -16 dB |
| Screen contact | soft thud | soft tap | -18 dB |
| Slow-motion window opens | low pitch drop | none | -16 dB |
| Summary numerals | quiet tick per count step | none | -22 dB |

All cues honor `learnerContext.accessibility.soundEnabled` and `hapticsEnabled`. No music. No commentary voice.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Half-court (floor, lines, lane paint, arc, hoop, backboard) | procedural | generated in code; original | < 3k tris; solid colors; 0 textures | `court` token from theme; lines as thin quads |
| Players (offense / defense) | procedural | capsule-bodied stylized figures generated in code; original | < 1.2k tris each; solid colors; no textures | Jersey number and role ring as second channel; defenders desaturated |
| Ball | procedural | original | < 600 tris | Orange in both themes (pieces keep own colors) |
| Coverage cue arrows and labels | procedural | original | quads / TMP | Eyebrow style labels |
| Overlays (rings, zones, arrows, callout cards) | procedural | original | quads / TMP | Rose = you/act, gold = correct/taught (ART_DIRECTION.md section 4) |
| Fonts | external (bundled) | Instrument Serif and Geist, OFL | TMP font assets | From `theme.fonts`; do not hard-code |

- **Addressables bundle:** `basketball.screens.pnr-read.v1` v1.0.0, expected size < 7 MB compressed (scenario JSON, TMP fonts, audio cues).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (5th-percentile frame >= 50 fps), peak resident memory < 150 MB, cold launch to `ready` < 2 s (< 4 s first framework load), bundle <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state not above "fair" after 3 minutes. Tighter limits for this sim: 10 characters, one ball; slow motion must not drop below 60 fps; coverage paths are precomputed keyframes (no runtime pathfinding).

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters: `hintsUsed`, `decisionLatencyMs` (per round), `coverageCallCorrectCount`, `timeouts`. No names, no relationship, no free text, no device identifiers.

## 21. Acceptance criteria (testable)
- **AC-1:** Verdict table: for each of the five coverages, the sim scores the action set exactly as in section 11 (best 100, acceptable 60, poor 0).
- **AC-2:** With seed 7, difficulty 2, `scenarioCount` 3, the sim emits exactly 3 `outcomes` and never repeats a coverage back to back.
- **AC-3:** Decision window: time scale is 0.25 (+/- 0.02) while the action buttons are enabled and returns to 1.0 in Executing.
- **AC-4:** Coverage cue frames: for each coverage the `d_screen` and `d_ball` positions at the cue times in section 11 are within 1.0 ft.
- **AC-5:** At level 4-5 the action buttons are disabled until a coverage chip is tapped, and a `call-i` outcome is emitted per round.
- **AC-6:** Mirroring: with `side=right` all x coordinates are negated and results are identical to `side=left`.
- **Launch and ready:** With this sim's example configuration, Unity emits `ready` within 2000 ms of receiving `launch`, and exactly one `result` that validates against `simulation-result.schema.json`, followed by `requestExit`.
- **Pause/resume:** After `pause`, no sim time, timers or objective progress advance for 5 s; after `resume` the state continues exactly. `durationMs` excludes paused time.
- **Abort:** `abort` at any state yields a result with `aborted=true`, `completed=false`, the matching `abortReason` and partial `outcomes` within 1000 ms; `xpEarned=0`, `heartsLost=0`.
- **Determinism:** With the same `seed`, `scenarioSetId` and scripted inputs, two runs produce identical `outcomes`, `mistakes` and `masterySignals`.
- **Config validation:** A configuration violating the section 10 schema (unknown key, out-of-range value) produces `error CONFIG_INVALID`; `{}` is valid and uses defaults.
- **Result maths:** `score` is an integer 0-100, `accuracy` in [0,1], every `conceptId` in `mistakes[]` and `masterySignals[]` is listed in section 3, and per-session caps in section 13 are never exceeded.
- **Reduced motion:** With `reducedMotion=true`: Freeze is a hard cut (0 ms ease), no camera sweeps or shake occur, and pulsing rings are static.
- **Tap-only completion:** A full session completes using only single taps (no drags or holds) with the tap-only scheme.
- **Color-blind channel:** For each `colorBlindMode`, every color-coded element also carries the second channel from section 16 (shape, pattern or number), verified by a scene audit.
- **Copy length:** All explain titles are <= 6 words and bodies <= 45 words (asserted from the scenario/copy data).
- **Performance:** On iPhone 13-class: >= 60 fps sustained, 5th-percentile frame >= 50 fps, peak memory < 150 MB, cold launch to `ready` < 2 s, <= 150 draw calls, <= 60k tris on screen.
- **Privacy:** No log line, telemetry field or file contains `personName` or `relationship`.

## 22. Test plan
- **EditMode:** Verdict truth table (5 coverages x 5 actions); scenario pool constraints (no repeats, pairing rules); config validation; scoring maths (with and without call weight); determinism by seed; mirroring; copy length.
- **PlayMode:** Scene builds from code; scripted run with best actions for a drop and a blitz round; cue-frame audit for all five coverages; slow-motion window; timeout path; pause/resume; abort; reduced-motion still-frame pair; tap-only run.
- **Perf:** a measured 3-round run on an iPhone 13-class device with a recorded fps/memory/thermal report attached to the PR.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Verdict_TruthTable |
| AC-2 | PlayMode | Run_ThreeRounds_NoRepeats |
| AC-3 | PlayMode | SlowMotion_DecisionWindow |
| AC-4 | PlayMode | Coverage_CueFrames |
| AC-5 | PlayMode | CoverageCall_Gating |
| AC-6 | EditMode | Mirroring_SymmetricResults |
| Launch and ready | PlayMode | BridgeConformance_ReadyResultExit |
| Pause/resume | PlayMode | PauseResume_NoTimeAdvance |
| Abort | PlayMode | Abort_PartialResult |
| Determinism | EditMode | Determinism_SameSeedSameResult |
| Config validation | EditMode | Config_ValidationAndDefaults |
| Result maths | EditMode | Result_SchemaAndCaps |
| Reduced motion | PlayMode | ReducedMotion_NoEaseNoShake |
| Tap-only completion | PlayMode | TapOnly_FullRun |
| Color-blind channel | EditMode | ColorBlind_SecondChannelAudit |
| Copy length | EditMode | Copy_LengthLimits |
| Performance | Perf | Perf_iPhone13Report |
| Privacy | EditMode | Privacy_NoPersonalData |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Basketball SME to confirm the verdict table (especially hedge acceptable = short-roll-pass, ice acceptable = none) | Product | No |
| 2 | Should popper screeners get their own action label ("pass to the pop") or keep `short-roll-pass` with a dynamic label? | Claude | No |
| 3 | Do we add a "read the weak side" second decision at level 5 in v2? | Product | No |
| 4 | Confirm the final tuning constants (speeds, timing windows) with Basketball SME review before Astra locks them. | Product | No |
| 5 | Should the sim honor `theme.colorScheme=light` with the same overlay tokens (planned: yes, per ART_DIRECTION)? | Astra | No |
| 6 | Is a native accessible fallback lesson approved for VoiceOver users (named in section 16)? | Claude | No |
