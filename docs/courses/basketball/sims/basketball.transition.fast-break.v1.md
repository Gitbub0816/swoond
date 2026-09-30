# Fast Break: Numbers Game (`basketball.transition.fast-break.v1`)

> Spec for Astra (Unity). Authored by Swoon'd curriculum design for the Basketball course. Follows `docs/astra/SIM_SPEC_TEMPLATE.md`; section numbers are stable.

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `basketball.transition.fast-break.v1` |
| simulationVersion | `1.0.0` (major 1 equals `.v1` in the id) |
| Spec status | draft |
| Contract versions | Bridge `1.0.x` (`docs/contracts/unity-bridge/v1/`); sim-definition `1.x` (scenario-data driven; no custom definition file required for v1) |
| Authors / date | Swoon'd curriculum design (Claude Code) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `basketball`; `unitId`: `defense`; `lessonId`s: `def-07` (single lesson; revisit from the Playbook at difficulty 4).
- CDS: `docs/courses/basketball/CDS.md`, section 12 Interaction plan, row "Fast break: read the numbers and the defender, then decide".
- Manifest entry: `docs/courses/basketball/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `transition-basics`, `fast-break`, `possession-flow`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can lead a fast break, read which defender committed, and pick the pass, drive or shot that the numbers give you.
| conceptId | term | after this the learner can |
|---|---|---|
| `fast-break` | Fast break | Recognize a break and why it scores easily. |
| `numbers-advantage` | Numbers advantage | Count 2-on-1, 3-on-2 and 4-on-3 and say why it matters. |
| `transition-defense` | Transition defense | Explain why getting back matters and what a lone defender can do. |
| `trailer` | Trailer | Recognize the extra player arriving late behind the ball. |
| `take-foul` | Take foul | Say why a defender grabs the ball handler to stop the break. |

- **Out of scope:** Half-court offense, screening and defensive rotations are covered elsewhere. Take fouls are explained in the lesson text; the sim resolves all rounds without a foul.

## 4. Why Unity (tier justification)
- **Rubric answer:** movement over time in a space and timing in a scene. A break is a moving count (2-on-1, 3-on-2) whose answer depends on a defender's commitment at a specific moment.
- **What Unity adds:** the learner sees the defenders commit in real time and chooses at the decision line, with the numbers advantage drawn on the floor. Slow motion turns a half-second read into a decision.
- **Closest native type and why it teaches worse:** `binary-call` cannot show motion; `timing-tap` covers only a 1D bar; `decision-scenario` hides the moment the defender commits.
- **Verdict:** Tier A. Native `multiple-choice` and `binary-call` (take foul rules) prepare the lesson.

## 5. Player fantasy & core loop
- **Fantasy:** You are the point guard leading the break with the crowd on its feet: three players, two defenders, one decision.
- **Core loop** (prompt -> one decisive interaction -> execute -> freeze/explain -> line you could say out loud):
  1. **Prompt:** serif line "Three on two. What do you do?" The rebound is secured and the break starts (0-0.9 s).
  2. **Slow motion:** at the decision line (top of the arc) the scene drops to 0.25x, the numbers tag appears, and the defenders commit.
  3. **Decision:** tap an action: pass left, pass right, attack the rim, pull up, or (level 4-5) pass to the trailer.
  4. **Execute and freeze:** the action plays for 2 s; freeze on the finish.
  5. **Explain and say:** what the defender took away and what the numbers gave you.
- **Session length:** About 3 minutes: 3 rounds; each round is about 5 s of play, 5-8 s of decision and 20 s of explain.

## 6. Scene & entities
- **Environment:** `basketball_full_court` (procedural full court, only the frontcourt half is rendered in detail).
- **Camera presets:** `chase-high` (behind and above the ball handler, default), `top-down-half-court` (freeze/replay). Reduced motion: cuts.
- **Court coordinates (all sims):** feet, origin at the rim center, +y toward half court, +x to the viewer's right when looking from the baseline toward half court. Baseline y = -5.25, half-court line y = 41.75, sidelines x = +/-25, lane x = +/-8 (free-throw line y = 13.75), restricted-area arc radius 4, three-point arc radius 23.75 with corner lines at x = +/-22 up to y = 8.75 (NBA dimensions; college/WNBA arc 22.146 ft can be selected via `configuration.league` where noted).
| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| ball_handler | `Character` + `Ball` | Learner-led ball handler, center lane | speed 20 ft/s to the decision line |
| wing_l / wing_r | `Character` | Teammates in the side lanes, running at 20 ft/s | lane x = +/-15 ft |
| trailer | `Character` | Extra player arriving late (4v3 only) | arrives at (0,26) at t = 1.6 s |
| d_top | `Character` (defender) | Top defender, at the free-throw line | commit direction (left/right/center/back) from scenario |
| d_rim | `Character` (defender) | Rim defender | stays at (0,3) except in 2v1 |
| d_wing | `Character` (defender) | Third defender in 4v3 | covers a wing |
| lanes | `Zone` x3 | Three transition lanes, overlay | x ranges (-25..-8), (-8..8), (8..25) |
| decision_line | `Zone` | Line at y = 24 where the decision opens | overlay line |
| actions | `Target` x5 + `DecisionPoint` | pass-left, pass-right, attack-rim, pull-up-three, pass-trailer | 56 pt |
| numbers_tag | `Highlight` | "3 vs 2" tag | gold |
| camera / slowmo | `CameraRig`, `SlowMotion` | As above |  |

- **Reused vs new:** Reused: `Character`, `Ball`, `Target`, `Zone`, `Path`, `CameraRig`, `TouchController`, `DecisionPoint`, `Hint`, `Explanation`, `Score`, `Replay`, `SlowMotion`, `Highlight`, and the Basketball module from the spacing sim. New: `basketball_full_court` (already requested in the spacing spec) and a scripted `BreakDefender` behavior (commit directions) in the Basketball module.
- **Layout diagram:**
```
     full court (only the frontcourt half detailed)
   wing_l (-15,y)          ball_handler (0,y)          wing_r (15,y)   ->  running toward the rim
                     trailer arrives at (0,26)   [4v3 only]
   ---- decision line y = 24 ----
           d_top (0,16)  commits: left | right | center | back
                     d_rim (0,3)
   -------------------------- rim ---------------------------
```

### 6.1 Game Kit additions requested
- **`BreakDefender` behavior:** scripted commit states (shade-left, shade-right, step-to-ball, stay-back) with a commit time and speed 14 ft/s; deterministic; reusable for other transition drills.
- **`basketball_full_court` environment** (requested in the spacing spec).
- **Registry keys:** objective type `choose_at_line`; actions `next_scenario` (existing).

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose action | Tap one action button (bottom arc) | actions | 56 pt | Button fills rose; light haptic |
| Hint | Tap the lightbulb | hint | 44 pt | Gold arrow on the best action (L1) or a cue arrow on the committed defender |
| Exit | Tap X | requestExit | 44 pt | `requestExit user-quit` |

- **Accessible alternative (tap-only):** The default scheme is tap-only. The decision limit at L5 can be doubled by the accessibility flag.
- **Orientation / safe area:** portrait; interactive targets stay above the bottom safe-area inset and clear of the top `runtime.safeAreaInsets.top` plus 12 pt; landscape is not supported in v1.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation ("Leave game?"), permission prompts, lesson chrome. Unity may draw an X that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate `contractVersion`, `simulationId`, `configuration`; load scenario JSON and build the world from code; apply theme and accessibility flags. | Scene built -> Intro; failure -> `error` (CONFIG_INVALID / ASSET_LOAD_FAILED) | `ready` (with `gameKitVersion`, `loadTimeMs`) |
| Intro | World built | Prompt card (one line, serif) and a 1.2 s establishing shot. Show the court, the three lanes and the ball handler at the rebound point. | Tap "Go" or auto after 3 s -> Playing | `progress` 0.0 |
| Playing | Intro finished | Round `i` of `n` begins. The break runs from half court to the decision line (about 0.9 s). | Decision window opens -> Decision | `progress` (throttled <= 4/s) |
| Decision | Decision window open | DecisionPoint slows or holds the sim. Slow motion 0.25x at the decision line; the defenders' commit animation plays inside the window; action buttons enable after the commit starts (or immediately at L1). | Choice locked or limit hit (counts as no answer = incorrect) -> Executing | none |
| Executing | Choice locked | Sim plays out deterministically for 2-5 s. The chosen action plays out (pass and finish, drive, or shot). | Outcome determined -> Freeze | none |
| Freeze | Outcome determined | Time scale eases to 0 over 250 ms (hard cut under reduced motion); scene dims 35% except focal entities. Freeze on the finish with lane arrows and the extra-man tag. | Focal highlight done -> Explain | `checkpoint` (round id) |
| Explain | Freeze complete | Callouts appear one at a time (250 ms each), then the copy card and the say-this line. Callouts: the numbers, the defender's commit, then the copy. | Tap Continue -> Playing (next round) or Summary | none |
| Summary | Last round explained | Score numerals count up over 600 ms; three outcome pips; the one line to say out loud. | Auto after 4 s or tap -> Done | `progress` 1.0 |
| Done | Summary finished | Build `SimulationResult`; emit result then request exit. | Unity idle | `result`, then `requestExit` (`completed`) |
| Paused | Native `pause` | Stop sim time, timers, audio and haptics; keep the frame. | `resume` -> previous state | none |
| Aborted | Native `abort` or X confirmed | Stop immediately; build a partial result. | Emit result -> exit | `result` (`aborted=true`), `requestExit` |

Pause/abort: native `pause` freezes sim time, timers and audio in any state and resumes exactly; `abort` moves to Aborted from any state and emits one result with `aborted=true`.

## 9. Difficulty levels 1-5
| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Numbers | 2 vs 1 | 3 vs 2 | 3 vs 2 | 4 vs 3 | 4 vs 3 |
| Cue support | gold arrow on best action | arrow on the committed defender | arrow after 1 s | none | none |
| Commit timing | before the window | at window start | delayed 0.6 s | delayed 0.6 s | delayed 0.6 s |
| Options | pass, attack | pass-left, pass-right, attack | + pull-up | + pass-trailer | + pass-trailer |
| Decision limit (real seconds at 0.25x) | none | none | 8 | 6 | 2 |
| Scenario pool tags | L1 | L2 | L3 | L4 | L5 |

- **Default difficulty for the lesson:** 2. Level 1 is passable by a true beginner with hints (hint text and highlights always on).

## 10. Configuration schema
`LaunchRequest.configuration` (draft 2020-12). Invalid configuration yields `error CONFIG_INVALID`.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "basketball.transition.fast-break.v1 configuration",
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
        "break-starter",
        "break-advanced"
      ],
      "default": "break-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 1,
      "maximum": 9,
      "default": 3
    },
    "numbers": {
      "type": "string",
      "enum": [
        "auto",
        "2v1",
        "3v2",
        "4v3"
      ],
      "default": "auto"
    },
    "showShadeCue": {
      "type": "boolean",
      "default": true
    },
    "decisionTimeLimitSec": {
      "type": "integer",
      "minimum": 0,
      "maximum": 12,
      "default": 0,
      "description": "Real seconds inside the 0.25x window; 0 = none."
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
  "seed": 9,
  "scenarioSetId": "break-starter",
  "scenarioCount": 3,
  "numbers": "auto",
  "showShadeCue": true,
  "decisionTimeLimitSec": 0
}
```

## 11. Scenario data set
A scenario chooses a **verdict type** (below) and a mirror. Defender commit directions, positions and timings come from the verdict type. `break-starter` = fb-01..fb-06; `break-advanced` = fb-05..fb-09.

**Scenario count:** at least **9** authored scenarios (3 rounds x 3 minimum for replay variety), stored as `Scenarios/break.json` (JSON, versioned with the sim). Selection is deterministic per `configuration.seed`.

**Verdict table (authoritative):**

| verdict type | what the defense does | best (100) | acceptable (60) | poor (0) | teaches |
|---|---|---|---|---|---|
| 2v1-commit-ball | 2 vs 1: the defender steps up to the ball | `pass-wing` | none | attack-rim, pull-up-three | Draw him, then pass: the wing is now alone. |
| 2v1-cover-wing | 2 vs 1: the defender shades to the wing | `attack-rim` | pull-up-three | pass-wing | He took away the pass, so the rim is open. |
| 3v2-top-shades-left | 3 vs 2: top defender shades left | `pass-right` | attack-rim | pass-left, pull-up-three | The right wing lane is open behind him. |
| 3v2-top-shades-right | 3 vs 2: top defender shades right | `pass-left` | attack-rim | pass-right, pull-up-three | Mirror image. |
| 3v2-two-back | 3 vs 2: both defenders back at the rim | `pull-up-three` | pass-left, pass-right | attack-rim | Two back means the perimeter is open. Take the shot or slow down. |
| 4v3-trailer-open | 4 vs 3: top and wing defenders committed; the trailer is open | `pass-trailer` | pass-left or pass-right (whichever wing is open) | attack-rim, pull-up-three | More offense than defense: the extra man arrives late and open. |

Timeline (seconds of sim time): ball handler crosses half court at t = 0; reaches the decision line (y = 24) at t = 0.9 s; the window opens at 0.9 s (0.25x); `d_top` commit starts at 0.9 s (or 1.5 s for delayed), completes 0.5 s later; `trailer` arrives at (0,26) at t = 1.6 s. Positions: `d_top` starts (0,16), `d_rim` (0,3), `d_wing` (12,12) on the side opposite the open wing, or as data says.

| scenarioId | verdict type | numbers | ball handler side | difficulty | cue note |
|---|---|---|---|---|---|
| fb-01 | 2v1-commit-ball | 2v1 | right | L1 | Cue: defender stands in front of the ball handler |
| fb-02 | 2v1-cover-wing | 2v1 | left | L1 | Cue: defender leans toward the wing |
| fb-03 | 3v2-top-shades-left | 3v2 | center | L2 | Cue arrow on the top defender |
| fb-04 | 3v2-top-shades-right | 3v2 | center | L2 | Mirror of fb-03 |
| fb-05 | 3v2-two-back | 3v2 | center | L3 | Both defenders at or below the free-throw line |
| fb-06 | 3v2-top-shades-left | 3v2 | center | L3 | Delayed commit: the shade starts at t = 0.6 s of the window |
| fb-07 | 4v3-trailer-open | 4v3 | center | L4 | Trailer arrives at the top of the arc |
| fb-08 | 4v3-trailer-open | 4v3 | center | L4 | Mirror of fb-07 |
| fb-09 | 3v2-two-back | 3v2 | center | L5 | Two back with a shooter on each wing; decision limit 2 s |

**Fully written first three**

1. **`fb-01`** - prompt "Two on one. What do you do?" Ball handler center, one wing on the right lane, one defender at the free-throw line who steps up to the ball. Best: `pass-wing` (the wing finishes with a dunk or layup). Poor: `attack-rim` ("the defender stands in front and takes a charge or blocks"). Hint (L1): "He is guarding the ball. Who is alone?"
2. **`fb-02`** - same numbers; the defender shades to the wing. Best: `attack-rim` (layup). Acceptable: `pull-up-three` (open by 6 ft). Poor: `pass-wing` (the pass is picked off or contested). Teaching beat: whoever the defender takes away, do the other thing.
3. **`fb-03`** - prompt "Three on two. Who is open?" `d_top` shades left, `d_rim` stays. Best: `pass-right` (2-on-1 with the wing finishing). Acceptable: `attack-rim` (a difficult finish against `d_rim`). Poor: `pass-left` (into the shade), `pull-up-three`. The arrow on `d_top` is visible at L2.

**Scenarios 04-09** follow the table. Generation rules for more: (a) numbers = the verdict type's numbers; (b) mirror every second scenario; (c) never more than two 3v2 in a row; (d) deterministic per seed by seeded shuffle of the pool by difficulty tag; (e) `pass-trailer` appears only in 4v3 scenarios.

## 12. Freeze / explain moments
Copy rules: title <= 6 words, body <= 45 words, optional say-this line in quotes. Voice: cheeky coach, warm, a little flirty, never condescending, never about the crush.

### 12.1 Pass to the open lane
- **Trigger:** Outcome determined.
- **What freezes:** The frame the ball reaches the rim area or the pass is caught; the defenders' committed directions shown as arrows.
- **Camera:** `top-down-half-court`, then `chase-high` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Gold arrow to the best option, rose arrow for the learner's choice; "Extra man" tag on the advantage; the committed defender ringed.
- **Correct outcome copy** - Title: "Two on one: pass." | Body: "The defender committed to the ball, so the wing was left alone. Draw the defender, then pass. The extra man is only useful if you make the defense pick." | Say this: "He drew the defender and hit the wing. Textbook."
- **Incorrect outcome copy** - Title: "He took that away." | Body: "The defender stood where your pass needed to go, so the pass or the drive ran into him. Read where the defender is committing and do the opposite." | Say this: "Which side did the defender commit to?"

### 12.2 Attack the rim
- **Trigger:** Outcome determined.
- **What freezes:** The frame the ball reaches the rim area or the pass is caught; the defenders' committed directions shown as arrows.
- **Camera:** `top-down-half-court`, then `chase-high` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Gold arrow to the best option, rose arrow for the learner's choice; "Extra man" tag on the advantage; the committed defender ringed.
- **Correct outcome copy** - Title: "Attack the open rim." | Body: "The defender shaded to the wing, so the rim was open. When the pass is covered, go score. A break is only about taking what the defender gives up." | Say this: "He covered the pass, so the driver just went to the rim."
- **Incorrect outcome copy** - Title: "Too much traffic." | Body: "The defender was back in the lane, so attacking ran into the rim protector. With two or three back, the good shot is at the arc, not at the rim. Read the depth, not just the count." | Say this: "They had two back. Why did he drive?"

### 12.3 Take the open three
- **Trigger:** Outcome determined.
- **What freezes:** The frame the ball reaches the rim area or the pass is caught; the defenders' committed directions shown as arrows.
- **Camera:** `top-down-half-court`, then `chase-high` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Gold arrow to the best option, rose arrow for the learner's choice; "Extra man" tag on the advantage; the committed defender ringed.
- **Correct outcome copy** - Title: "Two back: take the three." | Body: "Both defenders sagged to the paint, which leaves the arc open. A pull-up three is worth the space. Sometimes the best fast-break decision is to slow down and shoot." | Say this: "They stayed back, so he took the open three."
- **Incorrect outcome copy** - Title: "The three was not open." | Body: "A defender was already on you or in the lane, so the shot was contested. A break is the time for the easy bucket. If there is space, take it. If not, pass or attack." | Say this: "Was that three actually open?"

### 12.4 Trailer
- **Trigger:** Outcome determined.
- **What freezes:** The frame the ball reaches the rim area or the pass is caught; the defenders' committed directions shown as arrows.
- **Camera:** `top-down-half-court`, then `chase-high` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Gold arrow to the best option, rose arrow for the learner's choice; "Extra man" tag on the advantage; the committed defender ringed.
- **Correct outcome copy** - Title: "The trailer is the extra man." | Body: "With four against three, someone always arrives late and open. The trailer at the top of the arc gets the ball as the defense collapses. That is the extra pass that beats the recovery." | Say this: "The trailer got the open three off the break."
- **Incorrect outcome copy** - Title: "Look behind you." | Body: "Four against three means one of your teammates is trailing the play, and the defense forgot him. You forced a shot while he was open at the arc. Check the trailer first." | Say this: "Where is the fourth guy on the break?"

### 12.5 Summary line
- **Trigger:** All rounds explained.
- **What freezes:** Not frozen: Summary screen.
- **Camera:** Top-down still of the last break.
- **Callouts:** Three rounds with the number and the defender commit.
- **Correct outcome copy** - Title: "You read the break." | Body: "You counted the numbers, read the defender and made him wrong. That is what makes a fast break so hard to defend. Look for the one who commits." | Say this: "That is a 3-on-2. Who did the defender take away?"
- **Incorrect outcome copy** - Title: "Count, then read." | Body: "On a break, first count the numbers, then look at the top defender: which way is he leaning? Do the other thing. Try again and watch him first." | Say this: "How many defenders are back, and who are they guarding?"

## 13. Scoring & mastery signals
- **Score formula (0-100):** Round score: best 100, acceptable 60, poor 0 (no answer = 0). Session score = round(mean).
- **Accuracy:** Rounds with the best action divided by rounds played.
- **Outcome ids:** `round-1`..`round-N` (`label` e.g. "3v2: passed away from the shade"), `value` = the action id chosen.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (<= 240 chars) |
|---|---|---|
| Passed into the defender's shade | `numbers-advantage` | Passed to the side the top defender covered instead of the open side. |
| Drove into a back-stacked defense | `transition-defense` | Attacked the rim against two defenders back instead of taking the open three. |
| Forced a shot when the trailer was open | `trailer` | Ignored the trailing teammate in a 4-on-3. |
| Passed when the lone defender covered the wing (2v1) | `fast-break` | Passed into the defender who was covering the wing instead of scoring. |
| No decision before the limit | `fast-break` | Did not decide in time; the break was lost. |

**Mastery signals** (per-session caps: +0.4 / -0.3 per concept per session; total absolute delta <= 1.2.)

| event | conceptId | delta (-1..1) | evidence text |
|---|---|---|---|
| Best action in 2v1 | `numbers-advantage` | 0.25 | Read the 2-on-1 correctly. |
| Best action in 3v2 | `numbers-advantage` | 0.25 | Passed away from the committed defender. |
| Best action in two-back scenario | `transition-defense` | 0.2 | Recognized that a stacked back line gives up the arc. |
| Best action pass-trailer | `trailer` | 0.25 | Found the trailer. |
| Any best action | `fast-break` | 0.1 | Finished the break correctly. |
| Poor action | `numbers-advantage` | -0.1 | Wasted the numbers advantage. |

**Mapping to `SimulationResult`:** Rounds -> `outcomes[]`; mistakes -> `mistakes[]` with `at`; signals -> `masterySignals[]`.

## 14. XP & hearts
- **`xpEarned` proposal:** +10 per successful round, +40 for finishing all rounds (native clamps to the lesson XP budget); hint use does not reduce XP but native halves mastery gain when `telemetry.hintsUsed > 0`. Bonus: none.
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
| Decision window expires | The break stalls; the defense recovers and the round ends as a missed break | `outcomes[i].success=false`; mistake `fast-break` | Counts toward the session rule |

Failure always teaches: every failed round ends in an explain moment; there is no dead-end screen.

## 16. Accessibility
- **Reduced motion:** Freeze is a hard cut (no ease); camera moves become cuts; no shake; pulsing rings become static rings; slow-motion replay is replaced by paired stills (before/after) with the same callouts.
- **Haptics off:** all cues fall back to on-screen text/shape only.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): team colors differ in luminance and every color meaning has a second channel: lanes use dashed vs solid lines and labels L/M/R; defenders are hollow rings with commit arrows; the numbers tag is text ("3 vs 2"); action buttons have icons and text.
- **Text scale:** overlay text follows `textScale` up to 2.0; callout cards reflow and scroll if needed; explanation copy is never truncated.
- **Tap-only:** The default scheme is tap-only. The decision limit at L5 can be doubled by the accessibility flag.
- **VoiceOver / TalkBack:** Unity content has limited screen-reader support. Accessible native fallback lesson (a designed exercise, not a port): `break-native`: three `decision-scenario` items ("3 vs 2, top defender leaning left") with the same verdict table as text, and a `multiple-choice` on the number counts.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Scene ready | soft ball-bounce tick | none | -18 dB |
| Decision window opens | low chime | soft tap | -16 dB |
| Correct outcome | warm two-note rise | light success | -14 dB |
| Incorrect outcome | muted thud | warning | -14 dB |
| Freeze | soft whoosh, pitch drop | soft tap | -16 dB |
| Ball reaches the decision line | quick dribble roll | none | -18 dB |
| Pass completed | crisp pass whoosh | none | -16 dB |
| Summary numerals | quiet tick per count step | none | -22 dB |

All cues honor `learnerContext.accessibility.soundEnabled` and `hapticsEnabled`. No music. No commentary voice.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Half-court (floor, lines, lane paint, arc, hoop, backboard) | procedural | generated in code; original | < 3k tris; solid colors; 0 textures | `court` token from theme; lines as thin quads |
| Players (offense / defense) | procedural | capsule-bodied stylized figures generated in code; original | < 1.2k tris each; solid colors; no textures | Jersey number and role ring as second channel; defenders desaturated |
| Ball | procedural | original | < 600 tris | Orange in both themes (pieces keep own colors) |
| Lane overlays and numbers tag | procedural | original | quads / TMP | Dashed lines for the lane second channel |
| Overlays (rings, zones, arrows, callout cards) | procedural | original | quads / TMP | Rose = you/act, gold = correct/taught (ART_DIRECTION.md section 4) |
| Fonts | external (bundled) | Instrument Serif and Geist, OFL | TMP font assets | From `theme.fonts`; do not hard-code |

- **Addressables bundle:** `basketball.transition.fast-break.v1` v1.0.0, expected size < 6 MB compressed (scenario JSON, TMP fonts, audio cues).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (5th-percentile frame >= 50 fps), peak resident memory < 150 MB, cold launch to `ready` < 2 s (< 4 s first framework load), bundle <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state not above "fair" after 3 minutes. Tighter limits for this sim: 8 characters and one ball on screen at 4v3; slow motion holds 60 fps.

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters: `hintsUsed`, `decisionLatencyMs` (per round), `timeouts`, `numbersFaced`. No names, no relationship, no free text, no device identifiers.

## 21. Acceptance criteria (testable)
- **AC-1:** Verdict table: for each verdict type the sim scores every action exactly as in section 11.
- **AC-2:** Timeline: the ball handler reaches y = 24 at t = 0.9 s (+/- 0.05), the window opens then, and `d_top` completes its commit 0.5 s later (or 1.1 s for delayed).
- **AC-3:** With seed 9, difficulty 2, `scenarioCount` 3, the sim emits exactly 3 `outcomes`; no verdict type repeats more than twice in a row.
- **AC-4:** `pass-trailer` is offered only when `numbers` is 4v3.
- **AC-5:** Mirroring: with `mirror=true` all x coordinates are negated and results match the unmirrored scenario with left/right actions swapped.
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
- **EditMode:** Verdict truth table for six verdict types; option availability by numbers; mirroring; scoring maths; determinism by seed; config validation; copy length.
- **PlayMode:** Scene builds; scripted run through a 2v1, 3v2 and 4v3; timeline audit at the decision line; timeout path; reduced-motion stills; tap-only run; pause/resume; abort.
- **Perf:** a measured 3-round run on an iPhone 13-class device with a recorded fps/memory/thermal report attached to the PR.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Verdict_TruthTable |
| AC-2 | PlayMode | Timeline_DecisionLine |
| AC-3 | PlayMode | Run_ThreeRounds_Seed9 |
| AC-4 | EditMode | Options_TrailerOnly4v3 |
| AC-5 | EditMode | Mirroring_SwapsLeftRight |
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
| 1 | Basketball SME to confirm 3v2-two-back best = pull-up-three (vs. a slow-down pass to the wing) | Product | No |
| 2 | Do we add a take-foul round in v2 (the defender grabs the ball handler)? | Product | No |
| 3 | Full-court environment cost: is a half-court render with a fade-out acceptable for the backcourt? | Astra | No |
| 4 | Confirm the final tuning constants (speeds, timing windows) with Basketball SME review before Astra locks them. | Product | No |
| 5 | Should the sim honor `theme.colorScheme=light` with the same overlay tokens (planned: yes, per ART_DIRECTION)? | Astra | No |
| 6 | Is a native accessible fallback lesson approved for VoiceOver users (named in section 16)? | Claude | No |
