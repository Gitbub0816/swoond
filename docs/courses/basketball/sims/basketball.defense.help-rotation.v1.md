# Help Defense: Who Rotates? (`basketball.defense.help-rotation.v1`)

> Spec for Astra (Unity). Authored by Swoon'd curriculum design for the Basketball course. Follows `docs/astra/SIM_SPEC_TEMPLATE.md`; section numbers are stable.

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `basketball.defense.help-rotation.v1` |
| simulationVersion | `1.0.0` (major 1 equals `.v1` in the id) |
| Spec status | draft |
| Contract versions | Bridge `1.0.x` (`docs/contracts/unity-bridge/v1/`); sim-definition `1.x` (scenario-data driven; no custom definition file required for v1) |
| Authors / date | Swoon'd curriculum design (Claude Code) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `basketball`; `unitId`: `defense`; `lessonId`s: `def-02` (single lesson; revisit from the Playbook at difficulty 4).
- CDS: `docs/courses/basketball/CDS.md`, section 12 Interaction plan, row "Help defense: pick the helper and watch the rotation".
- Manifest entry: `docs/courses/basketball/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `man-to-man`, `on-ball-defense`, `closeout`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can see a drive beat its defender, pick which teammate should help, and explain why leaving the weakest shooter open is the right trade.
| conceptId | term | after this the learner can |
|---|---|---|
| `help-defense` | Help defense | Explain that a defender leaves his man to stop a drive. |
| `the-nail` | The nail | Point to the free-throw-line spot where the help defender waits. |
| `rotation` | Rotation | Describe the chain of defenders sliding after help leaves. |
| `x-out` | X-out | Recognize the defender who covers the man the helper left. |
| `low-man` | Low man | Recognize the defender nearest the rim on the weak side. |
| `closeout` | Closeout | Explain the sprint to the open shooter after the pass. |

- **Out of scope:** Zone defense, post double-teams and ball-screen coverages are separate sims. The defense in this sim is man-to-man with a single beaten defender.

## 4. Why Unity (tier justification)
- **Rubric answer:** movement in space and a dynamic decision. A rotation is four defenders sliding in sequence; the learner has to see the beaten defender, the drive path and the shooters at the same time.
- **What Unity adds:** the stunt, the pass and the closeout play out, so the learner sees why help from the wrong man leaves a great shooter open. The distance rings turn "he was open" into "he was 14 feet away".
- **Closest native type and why it teaches worse:** `hotspot-tap` (tap the nail) teaches the location; `decision-scenario` (text facts) hides the geometry. Neither shows the consequence of the choice.
- **Verdict:** Tier A. Native `hotspot-tap` (the nail) and `multiple-choice` prime the words in the same lesson.

## 5. Player fantasy & core loop
- **Fantasy:** You are the defensive coach yelling one word at the huddle: "Help!" and choosing who.
- **Core loop** (prompt -> one decisive interaction -> execute -> freeze/explain -> line you could say out loud):
  1. **Prompt:** serif line "He beat his man. Who helps?" A drive begins and the ball defender is beaten (1.0 s).
  2. **Slow motion:** the drive slows to 0.25x at the decision point; shooter tags (S / A / N) hover on the four other defenders' men.
  3. **Decision:** tap the defender who should help (single tap).
  4. **Execute:** the helper steps in and stops the drive, the drive kicks to the open man, and the x-out and closeout play.
  5. **Freeze and explain:** freeze on the open man with distance rings; the copy names the role (nail, low man, weak-side help) and the trade.
- **Session length:** About 3 minutes: 3 rounds; each round has about 8 s of play, a 6-10 s decision and 20 s of explain.

## 6. Scene & entities
- **Environment:** `basketball_half_court`
- **Camera presets:** `top-down-half-court` (default), `broadcast-baseline` (replay).
- **Court coordinates (all sims):** feet, origin at the rim center, +y toward half court, +x to the viewer's right when looking from the baseline toward half court. Baseline y = -5.25, half-court line y = 41.75, sidelines x = +/-25, lane x = +/-8 (free-throw line y = 13.75), restricted-area arc radius 4, three-point arc radius 23.75 with corner lines at x = +/-22 up to y = 8.75 (NBA dimensions; college/WNBA arc 22.146 ft can be selected via `configuration.league` where noted).
| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| driver | `Character` (offense) | Drives from the start spot along `middle` or `baseline` | speed 18 ft/s; path to rim |
| ball_defender | `Character` (defender) | Beaten defender, trailing 4 ft behind the driver | trail time 0.8 s |
| mate_A..mate_D | `Character` + `PlayerRole` | Four offensive teammates with shooter quality `shooter` / `avg` / `non` | positions per scenario from spot ids |
| def_A..def_D | `Character` (defender), `Target` | Selectable help candidates; each guards the like-lettered teammate | home = man position moved 3 ft toward the rim; ring 44 pt |
| intercept | `Zone` | Point the helper must reach (middle: (0,6); baseline: (+/-6,3)) | ring overlay |
| decision | `DecisionPoint` | Single tap on a defender | no limit at L1-3 |
| tags | `Highlight` (badge variant) | Shooter quality tags (S / A / N) with shapes | hidden behind a scouting card at L4-5 |
| rotation | `Objective` | Runs the x-out and closeout after help | see section 11 |
| camera / slowmo | `CameraRig`, `SlowMotion` | As above | reduced motion: cuts |

- **Reused vs new:** Reused: `Character`, `Ball`, `Target`, `Zone`, `Path`, `CameraRig`, `TouchController`, `DecisionPoint`, `Hint`, `Explanation`, `Score`, `Replay`, `SlowMotion`, `Highlight`, `Objective`, and the Basketball module from `basketball.spacing.floor-spacing.v1`. New: none; the `Highlight` distance ring requested in the spacing sim is reused.
- **Layout diagram:**
```
   half court
        [mate_A wing-l]      driver (top)     [mate_B wing-r]
            def_A          ball_defender (beaten)   def_B
   [mate_C corner-l]  [nail]  intercept (0,6)  [mate_D dunker-r]
   ----------------------- rim ---------------------
   tags: S = shooter, A = average, N = non-shooter (shape badges)
```

### 6.1 Game Kit additions requested
- **No new primitives beyond section 6.1 of `basketball.spacing.floor-spacing.v1`** (distance-ring `Highlight` and `PlayerRole`).
- **Objective type `rotate_and_close`:** after a help decision, choose the x-out defender (nearest non-helper to the open man by path length) and run the closeout with a defined speed; reusable for zone rotations.
- **Registry keys:** demonstrate type `help_gap_overlay` (from the spacing sim); action `next_scenario` (existing).

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose the helper | Tap a defender (ring pulses) | def_A..def_D | >= 44 pt ring (rendered 52 pt) | Ring turns rose; light haptic |
| Scouting card (L4-5) | Tap the clipboard icon | tags | 44 pt | Shows S/A/N tags for 2 s; counts as a hint |
| Hint | Tap the lightbulb | hint | 44 pt | Gold ring on the best helper (L1) or on the nearest non-shooter (L2-3) |
| Exit | Tap X | requestExit | 44 pt | `requestExit user-quit` |

- **Accessible alternative (tap-only):** The default scheme is tap-only. At L5 the decision limit can be extended by the accessibility flag.
- **Orientation / safe area:** portrait; interactive targets stay above the bottom safe-area inset and clear of the top `runtime.safeAreaInsets.top` plus 12 pt; landscape is not supported in v1.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation ("Leave game?"), permission prompts, lesson chrome. Unity may draw an X that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate `contractVersion`, `simulationId`, `configuration`; load scenario JSON and build the world from code; apply theme and accessibility flags. | Scene built -> Intro; failure -> `error` (CONFIG_INVALID / ASSET_LOAD_FAILED) | `ready` (with `gameKitVersion`, `loadTimeMs`) |
| Intro | World built | Prompt card (one line, serif) and a 1.2 s establishing shot. Show the half court with the driver at the start spot and the four defender rings dimmed. | Tap "Go" or auto after 3 s -> Playing | `progress` 0.0 |
| Playing | Intro finished | Round `i` of `n` begins. Drive starts; the ball defender trails; at t = 1.0 s the driver is at the decision point. | Decision window opens -> Decision | `progress` (throttled <= 4/s) |
| Decision | Decision window open | DecisionPoint slows or holds the sim. Slow motion 0.25x; the four defenders become tappable; timer ring if a limit is set. | Choice locked or limit hit (counts as no answer = incorrect) -> Executing | none |
| Executing | Choice locked | Sim plays out deterministically for 2-5 s. The chosen helper sprints to the intercept point; the driver stops or passes; the x-out and closeout run. | Outcome determined -> Freeze | none |
| Freeze | Outcome determined | Time scale eases to 0 over 250 ms (hard cut under reduced motion); scene dims 35% except focal entities. Freeze on the open man with distance rings. | Focal highlight done -> Explain | `checkpoint` (round id) |
| Explain | Freeze complete | Callouts appear one at a time (250 ms each), then the copy card and the say-this line. Callouts: the helper's role, the man he left, then the copy. | Tap Continue -> Playing (next round) or Summary | none |
| Summary | Last round explained | Score numerals count up over 600 ms; three outcome pips; the one line to say out loud. | Auto after 4 s or tap -> Done | `progress` 1.0 |
| Done | Summary finished | Build `SimulationResult`; emit result then request exit. | Unity idle | `result`, then `requestExit` (`completed`) |
| Paused | Native `pause` | Stop sim time, timers, audio and haptics; keep the frame. | `resume` -> previous state | none |
| Aborted | Native `abort` or X confirmed | Stop immediately; build a partial result. | Emit result -> exit | `result` (`aborted=true`), `requestExit` |

Pause/abort: native `pause` freezes sim time, timers and audio in any state and resumes exactly; `abort` moves to Aborted from any state and emits one result with `aborted=true`.

## 9. Difficulty levels 1-5
| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Shooter tags visible | yes | yes | yes | scouting card only | scouting card only |
| Gold hint ring | on the best helper | on the nearest non-shooter | 1 free hint | hints cost 1 | none |
| Drive type | middle | middle + baseline | mixed | mixed | baseline-heavy |
| Decision limit (real seconds at 0.25x) | none | none | 8 | 6 | 4 |
| Scenario pool tags | L1 | L1-2 | L2-3 | L3-4 | L5 |
| Helper role labels shown pre-decision | yes | yes | no | no | no |

- **Default difficulty for the lesson:** 2. Level 1 is passable by a true beginner with hints (hint text and highlights always on).

## 10. Configuration schema
`LaunchRequest.configuration` (draft 2020-12). Invalid configuration yields `error CONFIG_INVALID`.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "basketball.defense.help-rotation.v1 configuration",
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
        "help-starter",
        "help-advanced"
      ],
      "default": "help-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 1,
      "maximum": 9,
      "default": 3
    },
    "showShooterTags": {
      "type": "boolean",
      "default": true
    },
    "showRoleLabels": {
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
  "seed": 5,
  "scenarioSetId": "help-starter",
  "scenarioCount": 3,
  "showShooterTags": true,
  "showRoleLabels": true,
  "decisionTimeLimitSec": 0
}
```

## 11. Scenario data set
A scenario is a drive (start spot, direction) and four teammates (spot, shooter quality). Defenders start at `home` (man position moved 3 ft toward the rim). The **verdict model** below assigns best/acceptable/poor to each help candidate; the animation follows the verdict.

**Scenario count:** at least **9** authored scenarios (3 rounds x 3 minimum for replay variety), stored as `Scenarios/help.json` (JSON, versioned with the sim). Selection is deterministic per `configuration.seed`.

**Verdict model (reference; scenario data stores the resulting verdicts explicitly):**

1. `intercept` = (0,6) for a `middle` drive; (-6,3) for a baseline drive from the left side of the floor, (6,3) from the right.
2. For each candidate defender `d`: `cost(d) = distance(home(d), intercept) + penalty(man)` with penalty **shooter = 10 ft, average = 5 ft, non-shooter = 0 ft**. (The ball defender is not a candidate.)
3. **best** = minimum cost; **acceptable** = cost within 8 ft of the best; **poor** = otherwise.
4. Outcomes: **best** -> helper stops the drive, the pass goes to the weakest available man, the x-out arrives in time (score 100); **acceptable** -> drive stopped, a decent shooter is open but the closeout arrives (score 60, contested shot); **poor** -> drive stopped but the man left open is a shooter with no time to close out (open three, score 0). No answer = poor.
5. **Role label** shown in the explanation: helper's man at a dunker spot -> "low man"; at an elbow or top -> "the nail"; otherwise -> "weak-side help".

Spots (ft): corner-l (-22,1.5), corner-r (22,1.5), wing-l (-17,19), wing-r (17,19), dunker-l (-9,0.5), dunker-r (9,0.5), elbow-l (-8,13.75), elbow-r (8,13.75), top (0,26).

| scenarioId | driver start | drive | teammates (spot, quality) | best helper | acceptable | poor | difficulty | teaches |
|---|---|---|---|---|---|---|---|---|
| help-01 | `top` | middle | A@wing-l(shooter), B@wing-r(non), C@corner-l(shooter), D@dunker-r(avg) | D@dunker-r (low man) | B | A, C | L1 | Help from the closest defender whose man is not a shooter |
| help-02 | `top` | middle | A@wing-l(shooter), B@wing-r(shooter), C@corner-r(non), D@elbow-l(avg) | D@elbow-l (the nail) | C | A, B | L1 | The nail: the elbow defender steps in |
| help-03 | `wing-l` | baseline | A@wing-r(shooter), B@corner-r(shooter), C@dunker-r(non), D@top(avg) | C@dunker-r (low man) | none | D, A, B | L2 | Baseline drive: the low man helps |
| help-04 | `wing-r` | baseline | A@wing-l(shooter), B@corner-l(avg), C@dunker-l(non), D@top(shooter) | C@dunker-l (low man) | none | B, D, A | L2 | Mirror: baseline drive to the right |
| help-05 | `wing-l` | middle | A@top(shooter), B@wing-r(non), C@corner-r(shooter), D@dunker-l(avg) | D@dunker-l (low man) | B | A, C | L3 | Middle drive from the wing |
| help-06 | `top` | middle | A@wing-l(non), B@wing-r(shooter), C@corner-l(shooter), D@corner-r(shooter) | A@wing-l (weak-side help) | none | B, C, D | L3 | Only one non-shooter: he is the helper |
| help-07 | `wing-r` | middle | A@top(avg), B@wing-l(shooter), C@corner-l(shooter), D@dunker-l(non) | D@dunker-l (low man) | none | A, B, C | L4 | Weak-side dunker, non-shooter: low man |
| help-08 | `wing-l` | baseline | A@top(shooter), B@wing-r(avg), C@corner-r(shooter), D@dunker-r(non) | D@dunker-r (low man) | none | B, A, C | L4 | Baseline drive, non-shooter at the dunker spot |
| help-09 | `top` | middle | A@wing-l(avg), B@wing-r(avg), C@corner-l(shooter), D@corner-r(non) | D@corner-r (weak-side help) | A, B | C | L5 | Two average shooters and one non-shooter far away |

**Fully written first three**

1. **`help-01`** - prompt "He beat his man. Who helps?" Driver from the top, middle drive. A: wing-l shooter, B: wing-r non-shooter, C: corner-l shooter, D: dunker-r average. Costs: D 13.3 (best, low man), B 18.5 (acceptable), A 28.5 and C 29.6 (poor). Play: def_D leaves the dunker-r man and meets the driver at (0,6); the driver kicks to D's man, def_B rotates over as the x-out and closes out. Result: "contested three" (score 100 for the best help). Hint text (L1): "Help from the man who is least dangerous."
2. **`help-02`** - Driver from the top, middle drive. A: wing-l shooter, B: wing-r shooter, C: corner-r non-shooter, D: elbow-l average. D is the nail (13.3 best), C acceptable (19.6), A/B poor (28.5). Teaching beat: the nail defender is closest to the drive path and his man is an average shooter, so he helps and the x-out closes.
3. **`help-03`** - Driver from wing-l, baseline drive. A: wing-r shooter, B: corner-r shooter, C: dunker-r non-shooter, D: top average. C is the low man (12.3, best); D is poor (25.9, 13.6 above the best); A and B are poor (35.1). Teaching beat: baseline drives are stopped by the low man, and the non-shooter he leaves is the man the defense is happy to leave open.

**Scenarios 04-09** follow the table. Generation rules for more: (a) exactly four teammates; (b) at least one teammate of each quality except when a scenario is tagged L5; (c) at least one candidate must be **best** and no two candidates may tie on cost; (d) mirror scenarios by negating x; (e) deterministic per seed by seeded shuffle of the pool by difficulty tag.

## 12. Freeze / explain moments
Copy rules: title <= 6 words, body <= 45 words, optional say-this line in quotes. Voice: cheeky coach, warm, a little flirty, never condescending, never about the crush.

### 12.1 Help from the nail
- **Trigger:** Outcome determined after the rotation animates.
- **What freezes:** The frame the helper arrives at the drive and the open man is ringed; The nail defender is highlighted.
- **Camera:** `top-down-half-court`, then `broadcast-baseline` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Gold ring on the best helper; rose ring on the learner's helper; dashed line from the helper to his man; distance ring in feet to the open shooter.
- **Correct outcome copy** - Title: "That is the nail." | Body: "The defender at the free-throw line is closest to the drive and guards a player who cannot punish him. He steps in, the next defender slides over, and the open man is the one you are happiest to leave." | Say this: "He helped from the nail and the x-out covered."
- **Incorrect outcome copy** - Title: "You left a shooter." | Body: "Your helper came from a man who can shoot, so the drive kicked to a wide-open three. Help should come from the closest defender whose man is least dangerous. Check who you are leaving." | Say this: "Who was open when he helped?"

### 12.2 Low man
- **Trigger:** Outcome determined after the rotation animates.
- **What freezes:** The frame the helper arrives at the drive and the open man is ringed; The weak-side dunker defender is highlighted.
- **Camera:** `top-down-half-court`, then `broadcast-baseline` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Gold ring on the best helper; rose ring on the learner's helper; dashed line from the helper to his man; distance ring in feet to the open shooter.
- **Correct outcome copy** - Title: "Low man helps." | Body: "On a baseline or middle drive the low man is nearest the rim and his man is not a threat from there. He steps up and the others rotate behind him. That is help defense in one motion." | Say this: "The low man helped and they rotated behind him."
- **Incorrect outcome copy** - Title: "Wrong man left." | Body: "The low man is normally the best help because he is close to the rim. Helping from further away or from a shooter left an open shot. Pick the closest safe help." | Say this: "Wasn't there someone closer who could help?"

### 12.3 Weak-side help
- **Trigger:** Outcome determined after the rotation animates.
- **What freezes:** The frame the helper arrives at the drive and the open man is ringed; A weak-side wing or corner defender is highlighted (only when he is the best helper).
- **Camera:** `top-down-half-court`, then `broadcast-baseline` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Gold ring on the best helper; rose ring on the learner's helper; dashed line from the helper to his man; distance ring in feet to the open shooter.
- **Correct outcome copy** - Title: "Help from a weak man." | Body: "Nobody closer was safe to leave, so the defender guarding your weakest shooter came over. Defenses always leave the worst shooter open first. That is the deal every help rotation makes." | Say this: "They left the worst shooter open on purpose."
- **Incorrect outcome copy** - Title: "Too far, too risky." | Body: "Your helper was either too far to arrive in time or guarding a shooter. Look for the closest defender whose man is the least dangerous. If nobody qualifies, the weakest shooter goes." | Say this: "Who is the least dangerous man to leave?"

### 12.4 Summary line
- **Trigger:** All rounds explained.
- **What freezes:** Not frozen: Summary screen.
- **Camera:** Top-down still of the last rotation.
- **Callouts:** Three rounds with the helper role you chose.
- **Correct outcome copy** - Title: "You picked the helpers." | Body: "You helped from the safest man three times in a row. That is the entire logic of help defense: someone is going to be open, so choose who. Watch the x-out next time." | Say this: "He helped off the worst shooter. Smart."
- **Incorrect outcome copy** - Title: "Choose who to leave open." | Body: "Help defense is a trade: leave the least dangerous man open. Look for the closest defender whose man cannot shoot, then trust the x-out. Try again and check the tags first." | Say this: "Which man are they willing to leave open?"

## 13. Scoring & mastery signals
- **Score formula (0-100):** Round score: best 100, acceptable 60, poor 0 (no answer = 0). Session score = round(mean).
- **Accuracy:** Rounds with the best helper divided by rounds played.
- **Outcome ids:** `round-1`..`round-N` (`label` e.g. "Low man helped", "Left a shooter open"), `value` = helper role (`the-nail`, `low-man`, `weak-side-help`) or `poor`.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (<= 240 chars) |
|---|---|---|
| Helped from a shooter's defender | `help-defense` | Sent the defender guarding a shooter to help, leaving a shooter open. |
| Helped from the far weak side when a closer safe helper existed | `rotation` | Sent a distant helper when a closer safe defender was available. |
| No help chosen | `help-defense` | Did not send help on the drive. |
| Ignored the low man on a baseline drive | `low-man` | Passed over the low man on a baseline drive. |
| Ignored the nail on a middle drive | `the-nail` | Passed over the nail defender on a middle drive. |

**Mastery signals** (per-session caps: +0.4 / -0.3 per concept per session; total absolute delta <= 1.2.)

| event | conceptId | delta (-1..1) | evidence text |
|---|---|---|---|
| Best helper, role nail | `the-nail` | 0.25 | Chose the nail defender. |
| Best helper, role low man | `low-man` | 0.25 | Chose the low man. |
| Best helper (any) | `help-defense` | 0.2 | Helped from the safest man. |
| Best or acceptable (any) | `rotation` | 0.1 | Sent a helper who could be covered by an x-out. |
| Best helper with x-out completed | `x-out` | 0.15 | X-out covered the man left open. |
| Best helper, closeout arrives | `closeout` | 0.1 | The closeout arrived in time. |
| Poor helper | `help-defense` | -0.15 | Left a shooter open. |

**Mapping to `SimulationResult`:** Rounds -> `outcomes[]`; mistakes -> `mistakes[]` with `at`; signals -> `masterySignals[]`; `score`, `accuracy` per above.

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
| Decision limit expires (L3-5) | The default "no help" plays: the driver scores a layup | `outcomes[i].success=false`, mistake `help-defense` (no help) | Counts toward the session rule |

Failure always teaches: every failed round ends in an explain moment; there is no dead-end screen.

## 16. Accessibility
- **Reduced motion:** Freeze is a hard cut (no ease); camera moves become cuts; no shake; pulsing rings become static rings; slow-motion replay is replaced by paired stills (before/after) with the same callouts.
- **Haptics off:** all cues fall back to on-screen text/shape only.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): team colors differ in luminance and every color meaning has a second channel: shooter tags use shape and letter (circle S, square A, triangle N); defenders are hollow rings with a letter; best helper is a gold double ring, the learner's choice a rose single ring, poor result a dashed ring.
- **Text scale:** overlay text follows `textScale` up to 2.0; callout cards reflow and scroll if needed; explanation copy is never truncated.
- **Tap-only:** The default scheme is tap-only. At L5 the decision limit can be extended by the accessibility flag.
- **VoiceOver / TalkBack:** Unity content has limited screen-reader support. Accessible native fallback lesson (a designed exercise, not a port): `help-native`: a `hotspot-tap` (tap the nail), then a `decision-scenario` with a fact sheet of four defenders (position, man quality) and best/acceptable/poor verdicts as text.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Scene ready | soft ball-bounce tick | none | -18 dB |
| Decision window opens | low chime | soft tap | -16 dB |
| Correct outcome | warm two-note rise | light success | -14 dB |
| Incorrect outcome | muted thud | warning | -14 dB |
| Freeze | soft whoosh, pitch drop | soft tap | -16 dB |
| Helper steps in | quick shoe squeak (original synth) | soft tap | -18 dB |
| Kick-out pass | crisp pass whoosh | none | -16 dB |
| Summary numerals | quiet tick per count step | none | -22 dB |

All cues honor `learnerContext.accessibility.soundEnabled` and `hapticsEnabled`. No music. No commentary voice.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Half-court (floor, lines, lane paint, arc, hoop, backboard) | procedural | generated in code; original | < 3k tris; solid colors; 0 textures | `court` token from theme; lines as thin quads |
| Players (offense / defense) | procedural | capsule-bodied stylized figures generated in code; original | < 1.2k tris each; solid colors; no textures | Jersey number and role ring as second channel; defenders desaturated |
| Ball | procedural | original | < 600 tris | Orange in both themes (pieces keep own colors) |
| Shooter tag badges | procedural | original | quads | Shape second channel |
| Overlays (rings, zones, arrows, callout cards) | procedural | original | quads / TMP | Rose = you/act, gold = correct/taught (ART_DIRECTION.md section 4) |
| Fonts | external (bundled) | Instrument Serif and Geist, OFL | TMP font assets | From `theme.fonts`; do not hard-code |

- **Addressables bundle:** `basketball.defense.help-rotation.v1` v1.0.0, expected size < 6 MB compressed (scenario JSON, TMP fonts, audio cues).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (5th-percentile frame >= 50 fps), peak resident memory < 150 MB, cold launch to `ready` < 2 s (< 4 s first framework load), bundle <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state not above "fair" after 3 minutes. Tighter limits for this sim: 10 characters and one ball on screen; slow motion holds 60 fps; no runtime pathfinding (straight-line stunts with easing).

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters: `hintsUsed`, `decisionLatencyMs` (per round), `scoutingCardUses`, `timeouts`. No names, no relationship, no free text, no device identifiers.

## 21. Acceptance criteria (testable)
- **AC-1:** Verdict model: for every scenario in `help.json` the stored verdicts equal the model output (best unique, ties rejected).
- **AC-2:** With seed 5, difficulty 2, `scenarioCount` 3, the sim emits exactly 3 `outcomes`.
- **AC-3:** Slow-motion decision window holds 0.25x (+/- 0.02) and only the four help candidates are tappable (the ball defender is not).
- **AC-4:** X-out: after help, the defender with the shortest path to the open man (excluding the helper) is the one who rotates, and the closeout duration equals path length / 15 ft/s.
- **AC-5:** At level 4-5 shooter tags are hidden until the scouting card is used; each use increments `hintsUsed`.
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
- **EditMode:** Verdict model vs stored data for all 9 scenarios; mirroring; x-out selection logic; scoring maths; determinism by seed; config validation; copy length.
- **PlayMode:** Scene builds; scripted run choosing best/poor helpers; slow-motion decision; timeout path; reduced-motion still frames; tap-only run; pause/resume; abort.
- **Perf:** a measured 3-round run on an iPhone 13-class device with a recorded fps/memory/thermal report attached to the PR.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Verdict_ModelMatchesData |
| AC-2 | PlayMode | Run_ThreeRounds_Seed5 |
| AC-3 | PlayMode | Decision_TargetsAndSlowMo |
| AC-4 | PlayMode | Rotation_XOutAndCloseout |
| AC-5 | PlayMode | ScoutingCard_CountsAsHint |
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
| 1 | Basketball SME to review the penalty weights (10 / 5 / 0 ft) and the "within 8 ft = acceptable" rule for realism | Product | No |
| 2 | Add a second decision (choose the x-out defender) at level 5 in v2? | Product | No |
| 3 | Should the sim show the ball defender's recovery ("chase-down") as a bonus outcome? | Astra | No |
| 4 | Confirm the final tuning constants (speeds, timing windows) with Basketball SME review before Astra locks them. | Product | No |
| 5 | Should the sim honor `theme.colorScheme=light` with the same overlay tokens (planned: yes, per ART_DIRECTION)? | Astra | No |
| 6 | Is a native accessible fallback lesson approved for VoiceOver users (named in section 16)? | Claude | No |
