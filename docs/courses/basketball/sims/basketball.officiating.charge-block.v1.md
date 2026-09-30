# Whistle Booth: Charge or Block (`basketball.officiating.charge-block.v1`)

> Spec for Astra (Unity). Authored by Swoon'd curriculum design for the Basketball course. Follows `docs/astra/SIM_SPEC_TEMPLATE.md`; section numbers are stable.

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `basketball.officiating.charge-block.v1` |
| simulationVersion | `1.0.0` (major 1 equals `.v1` in the id) |
| Spec status | draft |
| Contract versions | Bridge `1.0.x` (`docs/contracts/unity-bridge/v1/`); sim-definition `1.x` (scenario-data driven; no custom definition file required for v1) |
| Authors / date | Swoon'd curriculum design (Claude Code) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `basketball`; `unitId`: `rules`; `lessonId`s: `rul-06` (single lesson; replayable from the Playbook at difficulty 3).
- CDS: `docs/courses/basketball/CDS.md`, section 12 Interaction plan, row "Charge or block: replay from three angles and make the call".
- Manifest entry: `docs/courses/basketball/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `personal-foul`, `restricted-area-arc`, `shooting-foul`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can watch a collision from the right angle, check where the defender is and whether he was set, and make the call the way a referee would.
| conceptId | term | after this the learner can |
|---|---|---|
| `charge` | Charge | Recognize an offensive foul on a driver who runs into a set defender. |
| `blocking-foul` | Blocking foul | Recognize a defender who was not set or moved into the driver. |
| `restricted-area-rule` | Restricted-area rule | Explain that a help defender in the arc cannot draw a charge. |
| `legal-guarding-position` | Legal guarding position | Check facing, both feet on the floor and set before contact. |
| `verticality` | Verticality | Explain that a defender jumping straight up is protected. |

- **Out of scope:** Flagrant/technical calls, hand checks, offensive fouls away from the ball, and NBA vs college differences in the play-on judgement are out of scope. The sim uses NBA rules; arc distance is the same in the NBA, WNBA and NCAA (4 ft).

## 4. Why Unity (tier justification)
- **Rubric answer:** camera perspective and movement in space are the concept. Whether a defender is inside the arc is visible from the baseline; whether his feet were set before contact is visible from the sideline; the frame of contact lasts a fraction of a second.
- **What Unity adds:** a scrubbable slow-motion replay from three cameras, with foot markers and the arc drawn, lets the learner do what a real crew and a replay center do: find the frame and check the conditions.
- **Closest native type and why it teaches worse:** `binary-call` on a static diagram (used in the lesson to prime the rules) has no time axis, so it cannot show "set before contact"; `visual-id` can show a signal but not the play. The judgement is the timing of the feet relative to the driver.
- **Verdict:** Tier A. Native `binary-call` x3 and `hotspot-tap` (restricted area) cover the rule vocabulary in the same lesson.

## 5. Player fantasy & core loop
- **Fantasy:** You are the replay official with a slow-motion booth: find the frame, check the feet, make the call.
- **Core loop** (prompt -> one decisive interaction -> execute -> freeze/explain -> line you could say out loud):
  1. **Prompt:** serif line "Charge, block, or play on?" and the first clip begins to loop from a default angle.
  2. **Inspect (optional):** scrub the timeline, step frame by frame, switch camera (baseline, sideline, overhead) and, at low difficulty, use the overlays.
  3. **Decision:** tap Charge, Block or Play on.
  4. **Freeze:** the sim locks on the frame of contact with feet and arc marked, then the call is revealed as the referee signal.
  5. **Explain and say:** which condition decided it (position, feet, arc, vertical) and a line to say out loud.
- **Session length:** About 3 minutes: 3 rounds; each round has a 2.4 s clip (contact at t = 1.2 s) that the learner can loop and scrub; average inspection about 25 s.

## 6. Scene & entities
- **Environment:** `basketball_half_court`; lighting flat, no crowd. Restricted-area arc drawn as a thin gold line.
- **Camera presets:** `broadcast-baseline` (behind the baseline, low: arc and lateral position), `broadcast-side` (sideline at the free-throw line: feet and motion), `top-down-half-court` (overhead: both). Each with a 1.0 s blend (cut under reduced motion).
- **Court coordinates (all sims):** feet, origin at the rim center, +y toward half court, +x to the viewer's right when looking from the baseline toward half court. Baseline y = -5.25, half-court line y = 41.75, sidelines x = +/-25, lane x = +/-8 (free-throw line y = 13.75), restricted-area arc radius 4, three-point arc radius 23.75 with corner lines at x = +/-22 up to y = 8.75 (NBA dimensions; college/WNBA arc 22.146 ft can be selected via `configuration.league` where noted).
| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| driver | `Character` (role player) + jersey number | Offensive player driving to the rim | path from scenario keyframes; speed 16-19 ft/s |
| defender_primary / defender_secondary | `Character` (defender) | The player whose position is judged (role set by scenario) | feet keyframes L/R with `grounded` flags |
| ball | `Ball` | Ball with the driver | dribble or gather keyframe |
| arc | `Zone` (restricted area, radius 4 ft) | Overlay and the "feet inside" test | `ContainsFoot` (new) on line-inclusive basis |
| foot_markers | `Highlight` (foot variant, new) | Gold = set and grounded; hollow = moving or airborne | shape + color |
| timeline | `Replay` + scrubber (new) | Seek, step, loop; the frame of contact is marked with a tick | 0.1 s steps; 0.25x/0.5x/1x |
| calls | `Target` x3 | Charge / Block / Play on buttons | 56 pt |
| referee | `Character` (signal pose) | Shows the call's signal at reveal (blocking = hand on hip; charge = offensive foul signal; play on = arms sweep) | pose only, no likeness |
| camera | `CameraRig` | Three presets | reduced motion: cuts |

- **Reused vs new:** Reused: `Character`, `Ball`, `Zone`, `CameraRig`, `Replay`, `SlowMotion`, `Highlight`, `Explanation`, `Score`, `Hint`, `TouchController`, `DecisionPoint`, and the Basketball module from `basketball.spacing.floor-spacing.v1`. New: `Replay` seek/step and a scrubber control; `Zone.ContainsFoot`; foot markers on `Character`. All reusable for pickleball kitchen faults and soccer offside replays.
- **Layout diagram:**
```
   baseline view                     sideline view (feet)               overhead
        rim                         driver ->  o/ \                     ( ) arc r = 4 ft
     ( arc 4 ft )                              |  |  <- defender feet    o defender
       def o                                   ----- floor                --> driver path
   contact at t = 1.2 s, clip length 2.4 s
```

### 6.1 Game Kit additions requested
- **`Replay.Seek(t)`, `Replay.Step(dt)`, loop range and speed:** scrub and frame-step deterministic recorded keyframes (reusable in any replay-based lesson).
- **`Zone.ContainsFoot(footPos)`** (line-inclusive) and **foot markers** on `Character` (grounded / airborne / moving states) with a shape second channel.
- **`ReplayScrubber` UI control:** timeline with a contact tick, 44 pt thumb, step buttons, speed toggle.
- **Registry keys:** objective type `judge_frame`; demonstrate type `foot_contact_overlay`; actions `seek_contact_frame`.

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Scrub | Drag the timeline thumb (or tap step buttons) | timeline | 44 pt thumb; 44 pt step buttons | Frame updates; contact tick snaps |
| Camera | Tap a camera chip (Baseline / Side / Overhead) | camera | 44 pt | Cut/blend to preset |
| Speed | Tap 1x / 0.5x / 0.25x | timeline | 44 pt | Loop speed changes |
| Make the call | Tap Charge, Block or Play on | calls | 56 pt | Locks the call; freeze |
| Overlay toggle (L3) | Tap the eye icon | foot_markers, arc | 44 pt | Shows or hides overlays |
| Exit | Tap X | requestExit | 44 pt | `requestExit user-quit` |

- **Accessible alternative (tap-only):** Scrubbing has a tap-only alternative: "Previous / Next frame" and "Jump to contact" buttons (44 pt). No drag is required in the tap-only scheme.
- **Orientation / safe area:** portrait; interactive targets stay above the bottom safe-area inset and clear of the top `runtime.safeAreaInsets.top` plus 12 pt; landscape is not supported in v1.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation ("Leave game?"), permission prompts, lesson chrome. Unity may draw an X that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate `contractVersion`, `simulationId`, `configuration`; load scenario JSON and build the world from code; apply theme and accessibility flags. | Scene built -> Intro; failure -> `error` (CONFIG_INVALID / ASSET_LOAD_FAILED) | `ready` (with `gameKitVersion`, `loadTimeMs`) |
| Intro | World built | Prompt card (one line, serif) and a 1.2 s establishing shot. Show the arc line and three camera chips on a paused first frame. | Tap "Go" or auto after 3 s -> Playing | `progress` 0.0 |
| Playing | Intro finished | Round `i` of `n` begins. The clip loops automatically until the learner decides; inspection tools are available. | Decision window opens -> Decision | `progress` (throttled <= 4/s) |
| Decision | Decision window open | DecisionPoint slows or holds the sim. The three call buttons are always enabled after the first loop (or immediately at L3+); optional time limit at L5. | Choice locked or limit hit (counts as no answer = incorrect) -> Executing | none |
| Executing | Choice locked | Sim plays out deterministically for 2-5 s. The referee reveals the call signal and the clip plays once more from the contact frame at 0.5x. | Outcome determined -> Freeze | none |
| Freeze | Outcome determined | Time scale eases to 0 over 250 ms (hard cut under reduced motion); scene dims 35% except focal entities. Freeze on the frame of contact with foot markers and the arc shown regardless of difficulty. | Focal highlight done -> Explain | `checkpoint` (round id) |
| Explain | Freeze complete | Callouts appear one at a time (250 ms each), then the copy card and the say-this line. Card names the deciding condition, then the rule in one line. | Tap Continue -> Playing (next round) or Summary | none |
| Summary | Last round explained | Score numerals count up over 600 ms; three outcome pips; the one line to say out loud. | Auto after 4 s or tap -> Done | `progress` 1.0 |
| Done | Summary finished | Build `SimulationResult`; emit result then request exit. | Unity idle | `result`, then `requestExit` (`completed`) |
| Paused | Native `pause` | Stop sim time, timers, audio and haptics; keep the frame. | `resume` -> previous state | none |
| Aborted | Native `abort` or X confirmed | Stop immediately; build a partial result. | Emit result -> exit | `result` (`aborted=true`), `requestExit` |

Pause/abort: native `pause` freezes sim time, timers and audio in any state and resumes exactly; `abort` moves to Aborted from any state and emits one result with `aborted=true`.

## 9. Difficulty levels 1-5
| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Overlays (foot markers, arc) | on + narrated labels | on | toggle (default on) | off (toggle unlocks after answering) | off, no toggle |
| Cameras available | sideline + baseline | all three | all three | all three | all three |
| Scrub / step | auto-pauses at contact | scrub allowed | scrub allowed | scrub allowed | 1 replay at 0.5x, no scrub |
| Options | Charge / Block | Charge / Block / Play on | 3 | 3 | 3 |
| Decision limit | none | none | none | 30 s | 15 s |
| Scenario pool tags | L1 | L1-2 | L2-3 | L3-4 | L4-5 |

- **Default difficulty for the lesson:** 3. Level 1 is passable by a true beginner with hints (hint text and highlights always on).

## 10. Configuration schema
`LaunchRequest.configuration` (draft 2020-12). Invalid configuration yields `error CONFIG_INVALID`.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "basketball.officiating.charge-block.v1 configuration",
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
        "charge-block-starter",
        "charge-block-advanced"
      ],
      "default": "charge-block-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 1,
      "maximum": 12,
      "default": 3
    },
    "overlays": {
      "type": "string",
      "enum": [
        "auto",
        "toggle",
        "off"
      ],
      "default": "auto",
      "description": "auto = follow difficulty."
    },
    "allowScrub": {
      "type": "boolean",
      "default": true
    },
    "cameras": {
      "type": "array",
      "uniqueItems": true,
      "minItems": 1,
      "items": {
        "type": "string",
        "enum": [
          "baseline",
          "sideline",
          "overhead"
        ]
      },
      "default": [
        "baseline",
        "sideline",
        "overhead"
      ]
    },
    "decisionTimeLimitSec": {
      "type": "integer",
      "minimum": 0,
      "maximum": 60,
      "default": 0
    },
    "league": {
      "type": "string",
      "enum": [
        "nba",
        "wnba",
        "college"
      ],
      "default": "nba"
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
  "seed": 12,
  "scenarioSetId": "charge-block-starter",
  "scenarioCount": 3,
  "overlays": "auto",
  "allowScrub": true,
  "cameras": [
    "baseline",
    "sideline",
    "overhead"
  ],
  "decisionTimeLimitSec": 0,
  "league": "nba"
}
```

## 11. Scenario data set
A scenario is a parameter set; clips are generated procedurally from the parameters by a deterministic choreographer (no hand animation): driver path, defender start, set time, feet keyframes at 30 fps for 2.4 s with contact at 1.2 s. `charge-block-starter` = cb-01..cb-07; `charge-block-advanced` = cb-04..cb-12.

**Scenario count:** at least **12** authored scenarios (3 rounds x 3 minimum for replay variety), stored as `Scenarios/charge-block.json` (JSON, versioned with the sim). Selection is deterministic per `configuration.seed`.

**Rule engine (reference; Astra implements exactly this):**

1. `contact = incidental` -> **play on**.
2. Defender is vertical (airborne straight up) and the offense initiates torso contact -> **charge** (verticality; applies even inside the arc).
3. Defender is a **secondary** defender with any foot inside or on the restricted-area arc (4 ft radius) and not vertical -> a charge cannot be called: **block** if he moved (lateral-slide, backpedal, or forward-lunge) into the driver, else **play on**.
4. Defender **set before** contact (facing, both feet on the floor, set before the offense's upward motion or gather) and moving only laterally or backward, and the offense initiates -> **charge**.
5. Otherwise (not set, moving forward into the driver, or the defender initiates the contact) -> **block**.

Parameter columns: `role` primary/secondary, `inArc`, `setBefore`, `motion`, `vertical`, `contact`, `initiator`.

| scenarioId | role | in arc | set before contact | motion | vertical | contact | initiator | correct call | keyAngle | difficulty | teaches |
|---|---|---|---|---|---|---|---|---|---|---|---|
| cb-01 | primary | no | yes | still | no | torso | offense | `charge` | sideline | L1 | A textbook charge: set and still before contact |
| cb-02 | primary | yes | yes | still | no | torso | offense | `charge` | baseline | L1 | The primary defender may draw a charge even in the arc |
| cb-03 | secondary | yes | yes | still | no | torso | offense | `play-on` | baseline | L2 | Help defender in the arc: no charge can be called |
| cb-04 | secondary | yes | no | forward-lunge | no | torso | defense | `block` | overhead | L2 | Sliding into the driver inside the arc: blocking |
| cb-05 | primary | no | no | forward-lunge | no | torso | defense | `block` | sideline | L2 | Moving into the driver's path: blocking |
| cb-06 | primary | no | yes | lateral-slide | no | torso | offense | `charge` | sideline | L3 | Sliding sideways with feet on the floor is still legal |
| cb-07 | primary | no | yes | still | no | incidental | offense | `play-on` | sideline | L3 | Hand touch only: play on |
| cb-08 | secondary | no | yes | still | no | torso | offense | `charge` | overhead | L3 | Help defender set just outside the arc: charge |
| cb-09 | secondary | no | no | lateral-slide | no | torso | defense | `block` | sideline | L4 | Arrived a step late: blocking |
| cb-10 | secondary | yes | no | still | yes | torso | offense | `charge` | sideline | L4 | Straight-up jump: the verticality exception applies |
| cb-11 | primary | no | yes | backpedal | no | torso | offense | `charge` | baseline | L5 | Backpedaling to keep position is legal |
| cb-12 | primary | no | no | lateral-slide | no | torso | defense | `block` | sideline | L5 | Late by a foot: feet not set before contact |

**Fully written first three**

1. **`cb-01`** - prompt "Charge, block, or play on?" Setup: primary defender at (0,8) facing the driver, both feet planted 0.6 s before contact; driver dribbles at 17 ft/s along x = 0 and lowers a shoulder into the defender's chest at t = 1.2 s. Correct: **charge**. Inspection cues: the foot markers turn gold at t = 0.6 s ("set"), the arc is not involved. Wrong answer **block** -> mistake `legal-guarding-position`.
2. **`cb-02`** - Setup: primary defender at (0,2.5), inside the arc, feet planted 0.5 s before contact; driver same as above. Correct: **charge**. The lesson: the primary defender can draw a charge under the basket; the arc rule applies to help defenders. Wrong answer **play on** -> mistake `restricted-area-rule`.
3. **`cb-03`** - Setup: driver drives past his own man; secondary defender at (1,3), inside the arc, feet planted; contact at t = 1.2 s with the driver running into his chest. Correct: **play on** (no charge). The baseline camera shows the arc line under the defender's feet. Wrong answer **charge** -> mistake `restricted-area-rule`.

**Scenarios 04-12** follow the table. Generation rules for more: (a) every scenario must be decidable from at least one camera (`keyAngle`), and no scenario may require judging a hand or arm; (b) at most two scenarios with the same correct call in a row; (c) at least one scenario per rule step above (1-5); (d) deterministic per seed by seeded shuffle of the pool by difficulty tag. Calls not covered by the engine (flopping, off-ball screens) are excluded.

## 12. Freeze / explain moments
Copy rules: title <= 6 words, body <= 45 words, optional say-this line in quotes. Voice: cheeky coach, warm, a little flirty, never condescending, never about the crush.

### 12.1 Charge call
- **Trigger:** Reveal after the learner or the answer key shows Charge.
- **What freezes:** The frame of contact (t = contact time), with both defender feet visible.
- **Camera:** The best-angle preset for the scenario (`keyAngle`), then a slow 0.25x replay; cuts under reduced motion.
- **Callouts:** Gold foot markers with a "Set 0.6 s early" tag; the driver's path as a rose line; a gold ring at the point of contact.
- **Correct outcome copy** - Title: "Charge: he was set." | Body: "The defender was facing the driver with both feet planted before contact, so the driver ran into him. That is a charge on the offense. Set first, then contact: that order decides it." | Say this: "Was he set before contact? Then it's a charge."
- **Incorrect outcome copy** - Title: "He was there first." | Body: "The defender got both feet down and stayed put before contact, so the driver ran him over. That is a charge, not a block. Check the feet before you blow the whistle." | Say this: "Did he have both feet down before the contact?"

### 12.2 Blocking foul
- **Trigger:** Reveal after the answer key shows Block.
- **What freezes:** The frame of contact (t = contact time), with both defender feet visible.
- **Camera:** The best-angle preset for the scenario (`keyAngle`), then a slow 0.25x replay; cuts under reduced motion.
- **Callouts:** Hollow foot markers with a "Moving" tag at contact; a rose arrow showing the defender's motion into the path.
- **Correct outcome copy** - Title: "Block: he moved into him." | Body: "The defender was still moving or slid into the driver's path at contact, so he was not set. That is a blocking foul on the defense. Late by a step is late." | Say this: "He didn't get set in time, so it's a block."
- **Incorrect outcome copy** - Title: "He was late." | Body: "Watch the feet: the defender was still moving into the driver at contact, so it was a block on him, not a charge. Not set before contact means not a charge." | Say this: "He was still moving, so that can't be a charge."

### 12.3 Restricted-area rule
- **Trigger:** Reveal on scenarios cb-03, cb-04 and cb-10.
- **What freezes:** The frame of contact (t = contact time), with both defender feet visible.
- **Camera:** The best-angle preset for the scenario (`keyAngle`), then a slow 0.25x replay; cuts under reduced motion.
- **Callouts:** The arc line pulses gold; a gold ring on the defender's foot inside it; the tag "Help defender" or "On the ball".
- **Correct outcome copy** - Title: "Arc rule: no charge here." | Body: "A help defender standing in the arc cannot draw a charge. The line under the rim is there to stop crashes at the basket. The primary defender can draw one; the help defender cannot." | Say this: "He was in the restricted area, so no charge."
- **Incorrect outcome copy** - Title: "Check the arc first." | Body: "The defender's feet were inside the arc, so a charge could not be called on a driver running into a help defender. The one exception is a defender jumping straight up." | Say this: "Was he in the restricted area?"

### 12.4 Play on
- **Trigger:** Reveal after the answer key shows Play on.
- **What freezes:** The frame of contact (t = contact time), with both defender feet visible.
- **Camera:** The best-angle preset for the scenario (`keyAngle`), then a slow 0.25x replay; cuts under reduced motion.
- **Callouts:** A thin gold outline on the contact area; a caption "Incidental".
- **Correct outcome copy** - Title: "Play on: nothing to call." | Body: "Contact happened, but it did not change the play or the defender cannot be charged here. Not every bump is a foul, and refs let good defense and hard drives play." | Say this: "That was just incidental contact."
- **Incorrect outcome copy** - Title: "Not every bump is a foul." | Body: "A whistle needs contact that matters: the driver was stopped or the defender moved illegally. Here it did neither. Fans complain about this one every night." | Say this: "Was that really enough contact to call?"

### 12.5 Summary line
- **Trigger:** All rounds explained.
- **What freezes:** Not frozen: Summary screen.
- **Camera:** Overhead still with the arc.
- **Callouts:** Three rounds with their deciding condition (Set, Arc, Moving).
- **Correct outcome copy** - Title: "You made the call." | Body: "You checked three things: was he set, was he in the arc, who moved into whom. That is exactly the replay checklist. Fans argue about it because the frame is so small." | Say this: "Set feet, arc, then who moved. That's the whole thing."
- **Incorrect outcome copy** - Title: "Freeze the frame." | Body: "Find the frame of contact and ask three things: were his feet set before that frame, was he in the arc, and who moved into whom? The answer is almost always in the feet." | Say this: "What do the refs check for a charge?"

## 13. Scoring & mastery signals
- **Score formula (0-100):** Round score: correct call = 100; play on when the answer was block or charge (missed a call) = 20; charge when block (wrong side) = 0; any other wrong call = 0. Session score = round(mean).
- **Accuracy:** Rounds with the correct call divided by rounds played.
- **Outcome ids:** `round-1`..`round-N` (`label` e.g. "Charge: set before contact", "Block: moving"), `value` = `charge` | `block` | `play-on` (the learner's call).

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (<= 240 chars) |
|---|---|---|
| Called a charge on a secondary defender inside the arc | `restricted-area-rule` | Called a charge on a help defender standing in the restricted area. |
| Called a charge on a defender who was not set | `legal-guarding-position` | Called a charge although the defender was still moving or late at contact. |
| Called a block on a defender who was set | `charge` | Called a block although the defender was set before contact. |
| Called a block or charge on a straight-up jump | `verticality` | Ignored that a defender jumping vertically is protected. |
| Called a foul on incidental contact | `blocking-foul` | Whistled contact that did not change the play. |

**Mastery signals** (per-session caps: +0.4 / -0.3 per concept per session; total absolute delta <= 1.2.)

| event | conceptId | delta (-1..1) | evidence text |
|---|---|---|---|
| Correct call, rule step 4 | `legal-guarding-position` | 0.25 | Checked set feet before contact. |
| Correct call, rule step 3 | `restricted-area-rule` | 0.3 | Recognized the arc rule for a help defender. |
| Correct call, rule step 4 (charge) | `charge` | 0.2 | Made the charge call correctly. |
| Correct call, rule step 5 (block) | `blocking-foul` | 0.2 | Recognized a defender moving into the path. |
| Correct call, rule step 2 | `verticality` | 0.25 | Recognized the vertical defender. |
| Wrong call, any | `legal-guarding-position` | -0.1 | Missed the set-feet check. |

**Mapping to `SimulationResult`:** Rounds -> `outcomes[]`; mistakes -> `mistakes[]` with `at`; signal rows -> `masterySignals[]`; `score`, `accuracy` per above.

## 14. XP & hearts
- **`xpEarned` proposal:** +10 per successful round, +40 for finishing all rounds (native clamps to the lesson XP budget); hint use does not reduce XP but native halves mastery gain when `telemetry.hintsUsed > 0`. Bonus: none. `heartsLost` is 0 when the learner used the overlay on every wrong round at difficulty 1-2 (a rule-learning safeguard).
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
| Decision limit reached (L4-5) | Buttons lock; "no call" counts as play on | `outcomes[i].success=false` | Counts toward the session rule |

Failure always teaches: every failed round ends in an explain moment; there is no dead-end screen.

## 16. Accessibility
- **Reduced motion:** Freeze is a hard cut (no ease); camera moves become cuts; no shake; pulsing rings become static rings; slow-motion replay is replaced by paired stills (before/after) with the same callouts.
- **Haptics off:** all cues fall back to on-screen text/shape only.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): team colors differ in luminance and every color meaning has a second channel: set/moving feet use a filled vs hollow marker plus a text tag; the arc uses a solid vs dashed line; the three calls use different icons (whistle-up, hand-on-hip, arms-sweep) and text labels.
- **Text scale:** overlay text follows `textScale` up to 2.0; callout cards reflow and scroll if needed; explanation copy is never truncated.
- **Tap-only:** Scrubbing has a tap-only alternative: "Previous / Next frame" and "Jump to contact" buttons (44 pt). No drag is required in the tap-only scheme.
- **VoiceOver / TalkBack:** Unity content has limited screen-reader support. Accessible native fallback lesson (a designed exercise, not a port): `charge-block-native`: a `binary-call` set (three charge/no-charge diagrams with markers for defender position and feet described in the explanation), a `hotspot-tap` for the restricted area, and a `decision-scenario` on the checklist.
- The scrubber has stepped values announced in text ("frame 12 of 72").

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Scene ready | soft ball-bounce tick | none | -18 dB |
| Decision window opens | low chime | soft tap | -16 dB |
| Correct outcome | warm two-note rise | light success | -14 dB |
| Incorrect outcome | muted thud | warning | -14 dB |
| Freeze | soft whoosh, pitch drop | soft tap | -16 dB |
| Contact frame | soft thud | soft tap | -18 dB |
| Call reveal (whistle) | short whistle (original synth, no licensed sample) | warning if incorrect | -16 dB |
| Summary numerals | quiet tick per count step | none | -22 dB |

All cues honor `learnerContext.accessibility.soundEnabled` and `hapticsEnabled`. No music. No commentary voice.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Half-court (floor, lines, lane paint, arc, hoop, backboard) | procedural | generated in code; original | < 3k tris; solid colors; 0 textures | `court` token from theme; lines as thin quads |
| Players (offense / defense) | procedural | capsule-bodied stylized figures generated in code; original | < 1.2k tris each; solid colors; no textures | Jersey number and role ring as second channel; defenders desaturated |
| Ball | procedural | original | < 600 tris | Orange in both themes (pieces keep own colors) |
| Referee signal poses (3) | procedural | original stylized poses in code | < 800 tris | No likeness of real officials |
| Overlays (rings, zones, arrows, callout cards) | procedural | original | quads / TMP | Rose = you/act, gold = correct/taught (ART_DIRECTION.md section 4) |
| Fonts | external (bundled) | Instrument Serif and Geist, OFL | TMP font assets | From `theme.fonts`; do not hard-code |

- **Addressables bundle:** `basketball.officiating.charge-block.v1` v1.0.0, expected size < 6 MB compressed (scenario JSON, TMP fonts, audio cues).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (5th-percentile frame >= 50 fps), peak resident memory < 150 MB, cold launch to `ready` < 2 s (< 4 s first framework load), bundle <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state not above "fair" after 3 minutes. Tighter limits for this sim: Replay seek must land on the requested frame in < 50 ms; 3 characters on screen; deterministic keyframes at 30 fps interpolated to 60.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters: `scrubCount`, `cameraSwitches`, `overlayToggles`, `timeToDecisionMs` (per round). No names, no relationship, no free text, no device identifiers.

## 21. Acceptance criteria (testable)
- **AC-1:** Rule engine: for every scenario in `charge-block.json` the engine returns the `correct call` in the section 11 table, and every rule step (1-5) is hit by at least one scenario.
- **AC-2:** Clip determinism: for each scenario the frame of contact is at t = 1.2 s (+/- 1 frame) and foot positions match the parameters (set/not set, in/out of arc).
- **AC-3:** `Replay.Seek(t)` lands within 1 frame of the requested time in < 50 ms and never re-simulates differently (same frame hash on repeat).
- **AC-4:** With overlays `off`, no foot marker or arc highlight is visible until Freeze; with `auto` at difficulty 1 both are visible from the first frame.
- **AC-5:** With seed 12, difficulty 3, `scenarioCount` 3: exactly 3 `outcomes`; no two consecutive scenarios share the same correct call more than twice.
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
- **EditMode:** Rule engine truth table over all 12 scenarios and over the full parameter grid (all combinations produce exactly one call); clip generator determinism; config validation; scoring maths; copy length.
- **PlayMode:** Scene builds; scripted run with scrubbing to contact and each of the three calls; camera switching; overlay behaviour by difficulty; reduced-motion stills; tap-only run; pause/resume; abort.
- **Perf:** a measured 3-round run on an iPhone 13-class device with a recorded fps/memory/thermal report attached to the PR.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | RuleEngine_TruthTable |
| AC-2 | EditMode | Clip_ContactFrameAndFeet |
| AC-3 | PlayMode | Replay_SeekDeterministic |
| AC-4 | PlayMode | Overlays_ByDifficulty |
| AC-5 | PlayMode | Run_ThreeRounds_Seed12 |
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
| 1 | Referee SME review of the rule engine for step 3 (secondary defender in arc, stationary: play on vs block) | Product | Yes, before spec approval |
| 2 | College and WNBA differences in the play-on judgement (config `league` currently affects nothing but the arc, which is 4 ft in all leagues) | Product | No |
| 3 | Do we show the on-court official signal for "charge" (offensive foul) exactly as in the rulebook, or a neutral icon? | Claude | No |
| 4 | Confirm the final tuning constants (speeds, timing windows) with Basketball SME review before Astra locks them. | Product | No |
| 5 | Should the sim honor `theme.colorScheme=light` with the same overlay tokens (planned: yes, per ART_DIRECTION)? | Astra | No |
| 6 | Is a native accessible fallback lesson approved for VoiceOver users (named in section 16)? | Claude | No |
