# Why Drafting Works (`nascar.drafting.tuck-in.v1`)

## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `nascar.drafting.tuck-in.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven: definition file `nascar.drafting.tuck-in.v1.definition.json` composed from Game Kit primitives) |
| Authors / date | Swoon'd curriculum design (Claude) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `nascar`; `unitId`: `tracks-air`; `lessonId`: `tracks-06` (also usable as a review activity from `perpetual-review`).
- CDS row: `docs/courses/nascar/CDS.md` section 12, row "Drafting: free speed (sim)".
- Manifest entry: `docs/courses/nascar/manifest.json` -> `unitySimulations[]` (simulationId `nascar.drafting.tuck-in.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `stock-car`, `oval-racing`, `track-types` (a two-screen primer on air resistance is shown if `aerodynamic-drag` is not yet seen).

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can see, with your own hands, that a car tucked close behind another one goes faster for the same effort, and you can say why in one sentence.

| conceptId | term | After the sim the learner can... |
|---|---|---|
| drafting | Drafting | Hold a car inside the 0.8-1.5 car-length draft window and explain that the lead car takes the air so you do not have to. |
| aerodynamic-drag | Aerodynamic drag | Say that the lead car pushes through more air, and that a trailing car feels less drag. |
| the-run | A run | Recognize that time spent tucked in builds a speed surplus you can use to pass (the slingshot). |
| dirty-air | Dirty air | (Levels 4-5) Notice that in corners the same close gap costs front grip, so the draft helps most on straights. |

**Out of scope:** Bump drafting and pushing (see `nascar.drafting.superspeedway-run.v1`), pack racing, blocking, engine heat from close following, and real physical numbers. Drag figures are stylized for clarity; the sim never claims exact percentages.

## 4. Why Unity (tier justification)
**Rubric answer.** Physics and camera perspective are the concept, and the learner must see something move over time in space. Drafting is invisible: you cannot see air. A Unity scene lets the learner (a) feel the speed surplus as they close the gap, (b) watch airflow ribbons bend around the lead car, and (c) drag the gap slider and see the speed readout change live. Distance is continuous, and the effect only makes sense as a relationship between two moving bodies.

**Closest native type and why it teaches worse:** `binary-call` or `multiple-choice` with a static two-car diagram can state that "closer is faster" but cannot let the learner discover the shape of the effect (big at one car length, gone at ten) or feel the slingshot. `timing-tap` is 1D and has no second car. A native fake would be a worse teacher than the interactive model. Native still teaches the vocabulary (`tracks-07`, `tracks-08`) and provides the accessible fallback.

## 5. Player fantasy & core loop
**Fantasy:** You are a driver who just discovered free speed hiding behind the car in front of you.

1. **Prompt** (native lesson intro, then in-scene banner): "Get close. Stay close. Feel that?"
2. **One decisive interaction:** drag the gap strip to hold your car inside the glowing draft window behind the leader (rounds 1-2) or choose which leader to tuck behind (round 2 variant) or tap Pull Out at the right moment (round 3).
3. **Execute:** the car follows the racing line on auto-steer; speed readout and airflow ribbons update live.
4. **Freeze / explain:** at the end of the round time eases to a stop, ribbons highlight, a callout card explains the effect.
5. **A line you could say out loud:** "He got a great run off the draft."

**Session length:** about 3 minutes, 3 rounds (default). Maximum 240 s of play; `runtime.maxDurationMs` from native is authoritative.

## 6. Scene & entities
- **Environment (registry key):** `oval_intermediate` (new registry key requested: 1.5-mile tri-lane oval, 18 degree stylized banking, procedural surface, no crowd).
- **Camera presets:** `chase-high` (default, FOV 60) while playing; `broadcast-side` (blend 0.4 s) for the freeze; `top-down` for the Replay at 0.25x. Reduced motion: cuts only.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| player_car | `Vehicle` (racing tuning, `Swoond.Sports.Racing`) | player | topSpeedKph 300 free speed 282; DragCoefficient from scenario; auto-steer via `FollowPath`; role ring `accent` (rose) + number 12 |
| lead_car | `Vehicle` | opponent (leader) | aiPace from scenario (270-292 kph); number 7; gold ring only when it is the taught element |
| traffic_01..04 | `Vehicle` | opponent (optional) | spawn from scenario (0-4 cars); fixed lane offsets; number 20-59 |
| draft_window | `Zone` (`Draft` overlay) | teaching zone | Translucent `rewardTint` slab 0.8-1.5 car lengths behind the lead car; label eyebrow "DRAFT WINDOW"; `Contains(player)` drives the objective |
| draft | `Draft` (racing module) | physics | bonus(gap) = maxBonusKph x clamp01(1 - (gap-1.0)/7.0) for gap >= 1.0, maxBonusKph for gap < 1.0; contact if gap < 0.3 (see AC-1) |
| gap_strip | `TouchController` vertical strip + `Target` | input | right edge, 64 pt wide, maps finger y to a target gap 0.3-10 car lengths |
| speed_compare | `Score`/`Timing` HUD | overlay | two bars: "Alone" (free speed) vs "You" (live) and a numeral in Display S serif |
| airflow_overlay | `Highlight` (extension `AirflowOverlay`) | overlay | 6 ribbons curving over lead car; thinner behind the lead car; static under reduced motion |
| racing_track | `Track` (racing module) + `Path` | world | procedural `oval_intermediate`; racing line as `Path` with 0.5 lane offset |
| dp_pullout | `DecisionPoint` | input | round 3 only: option Pull Out (Target) enabled once tuck time >= 4 s |

**Reused primitives:** `Vehicle`, `Track`, `Draft`, `Path`, `Zone`, `Target`, `TouchController`, `DecisionPoint`, `Objective` (maintain_proximity), `Hint`, `Highlight`, `Explanation`, `Score`, `Replay`, `SlowMotion`, `CameraRig`.

**New / extended primitives:** `AirflowOverlay` (extension of `Highlight`; reusable by any sim that visualizes flow, e.g. cycling or F1 later) and one environment key `oval_intermediate`. No new core primitive.

```
        lead_car (7)          <- air splits over it
       ~~~~~~~~~~~~~~~
   [ DRAFT WINDOW 0.8-1.5 lengths ]      gap_strip
        player_car (12)  ---->             |  ^ 10
   (rose ring)                              |  | drag to close
                                            |  v 0.3
   speed:  Alone |######      You |#########  +9 kph
```

## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Gap control | Vertical drag on the right-edge strip; finger height sets target gap | >= 64 x 240 pt strip | Car eases to the target gap; window glows gold when inside; soft haptic tick entering/leaving |
| Choose leader (round variant) | Tap a leader car ring (`Target`) | >= 56 pt ring | Ring locks rose; camera frames the choice |
| Pull Out | Tap the pill button above the safe area | 56 pt tall x 200 pt wide | Car swings to lane +1 and slingshots; button disabled until tuck time >= 4 s |
| Pause | Tap top-right icon (native handles Exit) | 44 x 44 pt | Sends `pause` request to native |

- **Accessible tap-only scheme (`ControlScheme.TapOnly`):** Three buttons replace the drag: `Closer` (-0.5 length), `Hold` (freeze the current gap) and `Back off` (+0.5). Each is 56 pt high. Pull Out and leader choice are already taps. Default target gap is auto-held once inside the window at difficulty 1-2 in this scheme.
- **Safe area & orientation:** portrait. All controls sit inside `runtime.safeAreaInsets` plus 16 pt; the bottom 88 pt is reserved for the primary control so it never collides with the home indicator.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation, XP totals, streaks and lesson navigation (native). Unity draws only the in-scene HUD and overlays.

## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit / bridge events |
|---|---|---|---|
| Loading | `launch` received and validated | Build world from code, load scenario set, verify `configuration`; on failure emit `error CONFIG_INVALID` / `ASSET_LOAD_FAILED` | World ready -> emit `ready` -> Intro |
| Intro | After `ready` | Camera `broadcast-side`; banner card "Tuck in behind the 7. Feel what changes." and a 2 s preview of airflow ribbons | Tap Start (or auto after 6 s) -> Playing |
| Playing | Round begins | Cars run; leader pace per scenario; player follows auto-steer; gap strip active; HUD live. Objective `maintain_proximity` accumulates seconds inside the window | Decision trigger -> Decision; time limit -> Freeze (timeout outcome). Emits `progress` (max 4/s) |
| Decision | Decision trigger reached | Rounds of kind `choose-leader` freeze pace at 0.15x with three leaders ringed; rounds of kind `slingshot` show Pull Out active; kind `hold` has no Decision (goes straight to Executing at time limit) | Choice made or time limit -> Executing. Emits `checkpoint` `round-<n>-decision` |
| Executing | Choice locked | Selected leader is followed for 10 s / Pull Out swings the car out for 4 s / hold rounds run the full hold duration; speed comparison animates | Outcome resolved -> Freeze |
| Freeze | Outcome resolved | `SlowMotion.Freeze` (250 ms ease; hard cut in reduced motion); dim non-focal entities 35%; gold pulse on the correct element then rose outline on the learner's choice if different | After highlight sequence -> Explain |
| Explain | Freeze complete | `Explanation.Present` correct or incorrect copy (section 12); learner taps Continue; optional Replay at 0.25x-0.5x (`Replay.Play`) | Continue -> next round (Playing) or Summary after round 3 |
| Summary | All rounds done | Result beat: score numerals count up 600 ms; per-round outcome chips; one "say this" line from the best moment | Tap Done -> Done. Emits `result` then `requestExit` |
| Done | After `result` sent | Unity idle; awaits native unload | Native unloads Unity |
| Paused | `pause` command or app backgrounded | Time scale 0, audio ducked, input disabled, timers frozen (no timeout while paused) | `resume` -> restores previous state and time scale |
| Aborted | `abort` command or fatal error | Stop immediately, build partial `result` (`completed:false, aborted:true`, `abortReason`), 0 XP | Emit `result` then `requestExit` |

**Bridge event order:** `ready` -> `progress`* (throttled) -> `checkpoint`* (at each Decision and each Explain) -> exactly one `result` -> `requestExit`. `Pause` and `Abort` never emit a second `result`.

## 9. Difficulty levels 1-5

| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Hold seconds required (`hold` rounds) | 5 | 6 | 8 | 8 | 10 |
| Draft window (car lengths) | 0.6-2.5 | 0.7-2.0 | 0.8-1.5 | 0.8-1.5 | 0.9-1.4 |
| Traffic cars | 0 | 0 | 1 | 2 | 4 |
| Lead pace variation (kph, +/-) | 0 | 0 | 2 | 3 | 6 |
| Hints available (`Hint` uses) | unlimited ghost gap | 3 | 2 | 1 | 0 |
| Auto-hold assist (gap) | on | on | off | off | off |
| Airflow overlay | on | on | on | toggle | off |
| Corner gap penalty (dirty air) | off | off | off | on | on |
| Scenario pool tags | ds-01, ds-02 | ds-01..ds-04 | ds-01..ds-06 | ds-03..ds-08 | ds-05..ds-09 |
| Decision time limit (s) | none | none | 12 | 9 | 7 |

**Default level for lesson `tracks-06`: 2.** Level 1 is passable by a true beginner using hints alone. Levels 4-5 add corner sections where the same close gap loses front grip.

## 10. Configuration schema
Fragment for `LaunchRequest.configuration` (`additionalProperties:false`; invalid configuration yields `error CONFIG_INVALID`).

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "LaunchRequest.configuration",
  "type": "object",
  "properties": {
    "seed": {
      "type": "integer",
      "minimum": 0,
      "maximum": 2147483647,
      "description": "Deterministic seed. Omitted: derived from sessionId."
    },
    "scenarioSetId": {
      "type": "string",
      "enum": [
        "nascar-drafting-tuck-in-core-1"
      ],
      "default": "nascar-drafting-tuck-in-core-1"
    },
    "roundCount": {
      "type": "integer",
      "minimum": 1,
      "maximum": 5,
      "default": 3
    },
    "assetRoot": {
      "type": "string",
      "description": "Optional local path announced by native for Addressables bundles."
    },
    "showAirflow": {
      "type": "boolean",
      "default": true
    },
    "controlScheme": {
      "type": "string",
      "enum": [
        "drag",
        "tap-only"
      ],
      "default": "drag"
    }
  },
  "additionalProperties": false
}
```

Valid example:

```json
{
  "seed": 42,
  "scenarioSetId": "nascar-drafting-tuck-in-core-1",
  "roundCount": 3,
  "showAirflow": true,
  "controlScheme": "drag"
}
```

## 11. Scenario data set
Set `nascar-drafting-tuck-in-core-1`: **9 scenarios** (3 rounds x 3 for replay variety), stored as `scenarios/nascar-drafting-tuck-in-core-1.json` in the sim bundle. Selection is deterministic per seed: pick 3 by difficulty tags, with round 1 always kind `hold`, round 2 kind `choose-leader` or `hold`, round 3 kind `slingshot` when the pool allows. Draft model: bonus(gap) as in section 6 with maxBonusKph = 9; free player speed 282 kph unless stated.

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| ds-01 | kind hold; leader 7 at 285 kph, start gap 6.0, no traffic | Close to 0.8-1.5 and hold for the required seconds | drafting | L1-3 |
| ds-02 | kind hold; leader 7 at 284 kph, start gap 9.0 (outside the effect), no traffic | Close the gap aggressively first; do not sit at 9 lengths | aerodynamic-drag | L1-3 |
| ds-03 | kind choose-leader; A 292 kph gap 9.5, B 284 kph gap 2.5, C 270 kph gap 1.5 | Tuck behind B | drafting | L2-5 |
| ds-04 | kind slingshot; leader 285 kph, start gap 1.2 (already tucked); leader defends at t=9 s | Pull Out between tuck time 4 s and 8.5 s | the-run | L2-5 |
| ds-05 | kind hold; leader surges +6 kph at t=3 s | Reopen the gap early enough by matching pace; close it again | drafting | L3-5 |
| ds-06 | kind hold; traffic car slots between you and the leader at t=4 s | Hold behind the traffic car (two cars ahead still cut air) | aerodynamic-drag | L3-5 |
| ds-07 | kind choose-leader; A pair of cars (2 in tandem) gap 5.0 at 286 kph, B single car gap 2.0 at 286 kph | Tuck behind the pair: bigger hole | aerodynamic-drag | L3-5 |
| ds-08 | kind hold with corners; 1.5-mile oval, corner sections T1-T2 and T3-T4 | Stay inside the window on straights, ease to 2.5 lengths in corners | dirty-air | L4-5 |
| ds-09 | kind slingshot finale; two leaders 8 lengths apart, defender moves up at t=8 s | Tuck behind the closer leader, pull out at t=6-7.5 s | the-run | L4-5 |

**Fully written scenarios:**

**ds-01 (kind hold):** environment `oval_intermediate`; leader 7 aiPace 285 kph; player free speed 282; start gap 6.0 car lengths; traffic 0; required seconds by level (5/6/8/8/10). Correct action: gap strip to <= 1.5 within 3 s and stay in [0.8, 1.5]. Expected result: player speed climbs to about 282 + 9 = 291 kph but is capped at leader pace + 6 kph = 291, so the gap holds. Round success: seconds inside window >= required. Explain trigger: after the required seconds or when the round timer (20 s) ends.

**ds-02 (kind hold):** leader 7 aiPace 284 kph; start gap 9.0 lengths; traffic 0. At gap > 8.0 the bonus is 0, so the player is slower than the leader (282 vs 284) and the gap grows unless the learner closes with strip control. A player parked at 9 lengths scores 0 s in window and fails. Correct action: drag the strip down to about 1.0; bonus jumps and the player catches the leader within 4 s. Teaches that the effect is strong only within a few car lengths.

**ds-03 (kind choose-leader):** three leaders ringed at t=0. A: 292 kph at gap 9.5; B: 284 kph at gap 2.5; C: 270 kph at gap 1.5. Model: effective speed if tucked = min(282 + bonus(gap), leaderPace + 6). A: bonus 0, effective 282 < 292, you fall behind (gain 0). B: bonus about 7.1, effective 289 > 284: you catch up to the window and ride at 290. C: effective min(290, 276) = 276 < 282: you would have to lift, losing time. Correct: B (best), A acceptable-but-poor (fast but out of reach), C wrong. Score only B as success.

**ds-04 (kind slingshot):** leader 285 kph; player starts at gap 1.2 tucked; tuckTime counts up; Pull Out button enables at 4.0 s; leader defends (moves up a lane) at t=9 s. If pull-out happens at tuckTime in [4.0, 8.5] the player has speed advantage >= 3 kph at exit and passes within 4 s: success. If tapped before 4.0 s the button is disabled (teaches patience). If tapped at > 8.5 s or never, the leader blocks and the pass fails. This is the `the-run` outcome.

Remaining scenarios (ds-05..ds-09) follow the same JSON shape: `{scenarioId, kind, leaders[{id,paceKph,gapLengths,pair?}], traffic[{atSeconds, laneOffset}], events[{atSeconds, type:'surge'|'defend', valueKph}], corners?, requiredSeconds, correct:{action, params}, conceptId, tags}`. All values are deterministic; only order and small pace jitter (+/- variation by level) use `Rng(seed)`.

## 12. Freeze / explain moments
Copy limits enforced by review: Title <= 6 words, body <= 45 words. Voice: cheeky coach, warm, a little flirty, never condescending; the learner is doing this for someone they care about.

### Explain 1: Holding the draft (hold rounds)
- **Trigger:** Required seconds reached or round timer ends
- **What freezes:** Both cars; airflow ribbons stay live
- **Camera:** `broadcast-side` blend 0.4 s, close on gap
- **Callouts:** Gold arrow from lead car nose to player nose labeled "air split"; rose arrow "less air to push"; speed bars annotated with the kph difference
- **Correct outcome copy**
  - Title: Nice read. Free speed.
  - Body: The lead car punches a hole in the air. Tucked in close, you push through less of it, so you go faster for the same effort. That is the whole trick behind a run.
  - Say this: "He got a great run off the draft."
- **Incorrect outcome copy**
  - Title: Not quite. Too far back.
  - Body: Draft help fades fast with distance. Past about eight car lengths the lead car's hole is gone, so you fight all the air yourself. Close up and it comes back.
  - Say this: "He lost the draft when he fell back."

### Explain 2: Choosing the leader
- **Trigger:** Choice locked and 10 s of execution done
- **What freezes:** All three leaders with their gaps
- **Camera:** `top-down` at 0.5x slow-mo replay of the 10 s
- **Callouts:** Gold ring on the correct leader; dotted rose ring on the chosen one if different; numeric label of effective speed above each
- **Correct outcome copy**
  - Title: Nice read. Close beats fast.
  - Body: A slightly slower car you can tuck behind beats a quicker one you cannot reach. The draft only helps when you are close enough to feel it.
  - Say this: "It is not just speed, it is who you can get close to."
- **Incorrect outcome copy**
  - Title: Not quite. Reach matters.
  - Body: That car was quick but out of range, or too slow to help. The best leader is the one you can tuck behind that is still faster than you alone.
  - Say this: "He picked the wrong car to follow."

### Explain 3: The slingshot
- **Trigger:** Pull Out result known (4 s after tap or leader defends)
- **What freezes:** Both cars at the point of the pass
- **Camera:** `broadcast-side` then `top-down`
- **Callouts:** Gold trail behind the player showing speed surplus; rose marker on the tap moment; "RUN BUILT" label at 4 s
- **Correct outcome copy**
  - Title: Nice read. Perfect slingshot.
  - Body: Riding in the draft built a speed surplus. Pulling out with it lets you zip past before the leader can shut the door. Patience first, then go.
  - Say this: "He timed that run perfectly."
- **Incorrect outcome copy**
  - Title: Not quite. Timing is the trick.
  - Body: Go too early and you have no extra speed yet. Go too late and the leader blocks. Wait for the run to build, then swing out.
  - Say this: "He pulled out too early."

### Explain 4: Corner air (levels 4-5)
- **Trigger:** A corner section ends with the player inside the window in the turn
- **What freezes:** Front tires of the player car with a grip meter
- **Camera:** `chase-high` low, close on nose
- **Callouts:** Rose front-grip bar dropping; gold arrow to widen gap; note "help on straights, harm in turns"
- **Correct outcome copy**
  - Title: Nice read. Breathe in the turns.
  - Body: Close behind another car, your nose gets messy air in a corner and loses grip. Ease back through the turn, close up again on the straight.
  - Say this: "He backed out in the corner to save his front tires."
- **Incorrect outcome copy**
  - Title: Not quite. Grip drained.
  - Body: Right behind the leader in the corner, the air is turbulent and your front tires slide. The draft helps on straights but costs grip in turns.
  - Say this: "He got loose in the dirty air."


## 13. Scoring & mastery signals
**Score (0-100):** mean of round scores. `hold` round = 100 x clamp01(secondsInWindow / requiredSeconds), minus 15 if contact (gap < 0.3) occurred. `choose-leader` round = 100 if best, 40 if acceptable-but-out-of-reach (A in ds-03), else 0. `slingshot` round = 100 if pass completed in the valid window, 50 if the pass completed but tapped within 0.5 s outside the window, else 0. Hints used subtract 5 each (min round score 0). **Accuracy** = rounds with `success:true` / rounds played, where `success` = round score >= 70. **Outcome ids:** `hold-draft`, `choose-leader`, `slingshot`, `corner-gap` (levels 4-5).

**Mistake -> conceptId mapping**

| mistake | conceptId | description text |
|---|---|---|
| Sat outside the window (gap > 3 lengths for > 5 s) | aerodynamic-drag | Stayed too far back to feel the lead car's air hole |
| Contact risk (gap < 0.3 lengths) | drafting | Closed so tight it would cause contact |
| Picked the fast but unreachable leader | drafting | Chose a leader that was out of draft range |
| Pulled out after tuck time 8.5 s, or never pulled out before the leader defended | the-run | Mistimed the slingshot |
| Stayed in window through corner at levels 4-5 | dirty-air | Kept a tight gap through the corner and lost front grip |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; native applies its own +0.20/-0.15 exercise scale separately and halves gain when hints were used)

| event | conceptId | delta | evidence text |
|---|---|---|---|
| `hold` round success | drafting | +0.15 | Held the draft window for the required time |
| `hold` round success with no hints | aerodynamic-drag | +0.10 | Kept close and read the speed bars |
| `choose-leader` best pick | drafting | +0.15 | Chose the leader in range |
| `slingshot` success | the-run | +0.20 | Built a run then passed |
| `corner-gap` success (L4-5) | dirty-air | +0.15 | Widened the gap through the corner |
| Failed `hold` round | aerodynamic-drag | -0.10 | Did not stay in the window long enough |
| Failed `slingshot` round | the-run | -0.10 | Mistimed the pull-out |
| Hint used | drafting | 0 (native halves gains) | Used a hint |

**Mapping to `SimulationResult`:** each round yields one `outcomes[]` entry (`id` = outcome id, `success`, `label`, `value`); each mistake yields `mistakes[]` `{conceptId, description, at}` (`at` = ms since launch); `masterySignals[]` entries use the table above; `score` = formula above rounded to integer; `accuracy` = successful rounds / rounds played (0..1).

## 14. XP & hearts
- `xpEarned` proposal: 10 per successful round, +40 when all 3 rounds are played (`completed:true`), +10 bonus when score >= 90. Max 80. Native clamps to the lesson XP budget.
- `heartsLost`: 1 if the session score < 40 (max 1 per session); 0 otherwise. Never lose a heart for abort, timeout caused by backgrounding, or errors. `unlimitedHearts` learners still report the same value; native ignores it.
- `replayAvailable`: `true` after the first completed round (Replay has recorded data); `false` if aborted before Explain or if Replay memory budget was hit. 

## 15. Failure states

| Case | What the learner sees | Result / event fields | Hearts |
|---|---|---|---|
| Failed round | Round outcome `success:false`, Explain with the incorrect copy, then Continue | outcome recorded; mistake + negative signal | Only via session rule (score < 40) |
| Failed session (score < 40) | Summary shows the constructive line "Rough one. Worth a rematch." and a Try again prompt (native) | `completed:true`, low score | 1 heart |
| Timeout (decision limit) | Decision auto-resolves as "no choice", Explain shows the correct answer | outcome `success:false`, mistake `timeout`-tagged in the description | No extra loss |
| Abort (user quits) | Native exit confirmation; Unity stops | `completed:false, aborted:true, abortReason:user-quit`, 0 XP, partial outcomes kept | No |
| Backgrounded | Auto-pause; resume restores state | If away > `runtime.maxDurationMs` native aborts: `backgrounded-too-long` | No |
| Asset missing | Native shows retry sheet | `error ASSET_LOAD_FAILED recoverable:true`; no result | No |
| Invalid config | Native skips activity with a friendly message | `error CONFIG_INVALID recoverable:false`; no result | No |

Failure always ends in an Explain moment, never a dead end. A learner who fails hold rounds three times in a row is offered (by native, between sessions) the fallback lesson and an automatic level-1 rerun.

## 16. Accessibility
- **Reduced motion:** hard cuts instead of camera sweeps and dolly; no screen shake; freeze is instant; pulsing rings become static rings; overlay animations off.
- **Haptics off:** every haptic cue in section 17 has a visual and (if sound is on) audio equivalent.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): every color meaning has a second channel: shape and pattern (striped fill = wrong, dotted ring = correct, solid ring = selected) and car numbers on every vehicle. Draft window is a striped slab in addition to gold tint; leader ring is dotted, player ring is solid.
- **Text scale:** overlay text scales with `textScale` 0.8-3.0; callout cards reflow and scroll if needed; body >= 13 pt at scale 1.
- **Tap-only alternative:** see section 7.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson provided: ``tracks-07` (native `binary-call` and `fill-the-gap` on drafting distance and clean/dirty air), offered by native as the accessible alternative for `tracks-06`` (a designed native exercise on the same concepts, not a port of this sim).

## 17. Audio & haptics

| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Round start | Soft engine idle swell (0.5 s) | Soft tap | -18 dB |
| Correct outcome | Warm two-note chime | Light success | -12 dB |
| Incorrect outcome | Low single tone | Warning | -12 dB |
| Freeze | Low-pass filter over ambient, 250 ms | Soft tap | -15 dB |
| Callout appears | Short paper tick | None | -20 dB |
| Summary numerals | Soft tick per 10 points | None | -22 dB |

All cues honor `soundEnabled` and `hapticsEnabled`. No music. Engine ambience is synthesized (procedural), never a licensed recording.

## 18. Art & asset list

| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| stock-car-lowpoly (x6 instances) | procedural (capsule body + bevels + number decal) | original, `original-swoond` | ~2.5k tris each; 256 px number atlas | fictional livery, generic numbers |
| oval_intermediate track | procedural spline mesh | original | ~8k tris, solid colors | banking drawn as shading bands |
| Airflow ribbons | procedural line renderer | original | 6 ribbons, one shared material | static under reduced motion |
| HUD fonts | Instrument Serif + Geist TMP assets | OFL (bundled by kit) | shared with kit |  |
| Sound cues | synthesized | original-swoond | < 0.6 MB total | no licensed engine recordings |

Addressables bundle: `sim-nascar-drafting-tuck-in-v1` (expected size <= 6 MB compressed). Overlay styling per `docs/astra/ART_DIRECTION.md` sections 4-5. Vehicle liveries are fictional (no real team paint schemes, sponsors or logos); car numbers are generic.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps sustained on iPhone 13-class (5th percentile >= 50 fps), < 150 MB peak resident memory, cold launch < 2 s to `ready`, bundle <= 25 MB, <= 150 draw calls, <= 60k triangles on screen, <= 15 materials, textures <= 8 MB VRAM, audio <= 3 MB. **Tighter per-sim limits:** <= 8 vehicles on screen; airflow ribbons <= 120 line segments; replay buffer <= 12 MB.

## 20. Telemetry
Diagnostics only, in `result.telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters `hintsUsed`, `decisionLatencyMs`, `secondsInWindowTotal`, `contactCount`, `pullOutTuckTime`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** Draft model: for gap 0.5, 1.0, 3.0, 5.0, 8.0, 10.0 lengths the bonus is 9.0, 9.0, 6.4, 3.9, 0.0, 0.0 kph (+/-0.1); contact flagged for gap < 0.3.
2. **AC-2:** ds-03: with model inputs the sim resolves B as best, A as acceptable-poor and C as wrong.
3. **AC-3:** ds-04: a Pull Out request before tuck time 4.0 s is rejected; at 5.0 s it succeeds; at 9.5 s it fails.
4. **AC-4:** Difficulty 1 with hints unlimited completes with score >= 70 when the scripted input holds gap 1.0.
5. **AC-5:** Airflow overlay is disabled at level 5 and under reduced motion static ribbons are drawn.
6. **AC-6:** Bridge conformance: given every `launch` example in `docs/contracts/unity-bridge/v1/examples/` (with `simulationId` swapped) the sim emits `ready`, >= 1 `progress`, one `result` valid against `simulation-result.schema.json`, then `requestExit`.
7. **AC-7:** Determinism: with the same `seed`, difficulty and scripted inputs two runs produce identical `outcomes[]`, `score` and scenario order.
8. **AC-8:** Invalid configuration (unknown key, out-of-range value) yields `error CONFIG_INVALID` within 500 ms and no scene load.
9. **AC-9:** With seed 42, difficulty 2 and default config the sim plays exactly 3 rounds and `result.outcomes` has exactly 3 entries.
10. **AC-10:** All explain copy: title <= 6 words, body <= 45 words, say-this line <= 120 characters; every conceptId used exists in the curriculum `concepts[]`.
11. **AC-11:** Reduced motion: no camera sweeps, no shake, freeze is a hard cut; flow still completes.
12. **AC-12:** Color-blind mode: every correct/incorrect marker has a non-color channel (pattern/shape) in a screenshot diff per mode.
13. **AC-13:** Pause/resume: pausing for 30 s mid-round then resuming continues from the same state with no timeout fired; abort emits a single result with `aborted:true`.
14. **AC-14:** Privacy: no log line, telemetry key or persisted file contains `personName` or `relationship` values.
15. **AC-15:** Budgets on iPhone 13-class: avg fps >= 58, p5 >= 50, peak memory < 150 MB, cold launch < 2 s.

## 22. Test plan
- **EditMode:** Draft bonus curve; `maintain_proximity` objective accumulation; leader-choice resolution; score maths for each round kind; config schema validation; scenario JSON validity; determinism by seed; result schema validity.
- **PlayMode:** Scene builds from code; scripted full run at levels 1, 3 and 5; freeze/explain sequence; pause/resume/abort; tap-only scheme; reduced motion; color-blind screenshot diffs.
- **Perf:** 3 consecutive full runs at difficulty 5 on an iPhone 13-class device; record fps, memory, thermal state (must not exceed "fair").

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | DraftBonus_CurveMatchesSpec |
| AC-2 | EditMode | ChooseLeader_ResolvesBest |
| AC-3 | PlayMode | Slingshot_Window |
| AC-4 | PlayMode | Difficulty1_BeginnerPass |
| AC-5 | PlayMode | AirflowOverlay_Modes |
| AC-6 | EditMode | BridgeConformance_ResultValidatesAgainstSchema |
| AC-7 | EditMode | Determinism_SameSeedSameResult |
| AC-8 | EditMode | Config_InvalidRejected |
| AC-9 | PlayMode | FullRun_ThreeOutcomes |
| AC-10 | EditMode | Copy_LengthsAndConceptIds |
| AC-11 | PlayMode | ReducedMotion_NoSweeps |
| AC-12 | PlayMode | ColorBlind_SecondChannel |
| AC-13 | PlayMode | PauseResumeAbort |
| AC-14 | EditMode | Privacy_NoPersonData |
| AC-15 | Perf | PerfBudget_IPhone13 |

## 23. Open questions

| # | Question | Owner (Claude / Astra / Product) | Blocking? |
|---|---|---|---|
| 1 | Confirm the stylized maxBonusKph of 9 and gap decay are acceptable to Astra as arcade tuning (not simulation-grade). | Astra | No |
| 2 | The repo example `racing-drafting.json` uses `oval_short` and lesson `drafting-01`; this spec uses `oval_intermediate` and lesson `tracks-06`. OK to supersede the example's values? | Claude / Astra | No |
| 3 | Should `AirflowOverlay` live in the Racing module or the kit core? | Astra | No |
| 4 | Confirm the fallback lesson id naming with the curriculum author. | Claude | No |

## Game Kit additions requested
- `AirflowOverlay` (Highlight extension): ribbons that bend around a Vehicle; parameters: sourceVehicle, ribbonCount, thicknessBehind. Reusable for F1 (slipstream/dirty air) and cycling.
- Registry: environment key `oval_intermediate`; objective type `maintain_proximity` already exists; demonstrate type `aerodynamic_drag` already exists.
