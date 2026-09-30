# Pit or Stay Out? (`nascar.strategy.caution-call.v1`)

## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `nascar.strategy.caution-call.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven: definition file `nascar.strategy.caution-call.v1.definition.json` composed from Game Kit primitives) |
| Authors / date | Swoon'd curriculum design (Claude) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `nascar`; `unitId`: `pit-strategy`; `lessonId`: `pits-06` (also usable as a review activity from `perpetual-review`).
- CDS row: `docs/courses/nascar/CDS.md` section 12, row "Pit or stay out (sim)".
- Manifest entry: `docs/courses/nascar/manifest.json` -> `unitySimulations[]` (simulationId `nascar.strategy.caution-call.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `caution-flag`, `pit-cycle`, `four-tire-stop`, `two-tire-stop`, `track-position`, `fuel-window`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can watch a caution unfold, weigh tires, fuel and track position, and make the call a crew chief would: four tires, two tires or stay out.

| conceptId | term | After the sim the learner can... |
|---|---|---|
| stay-out | Stay out | Explain that staying out keeps track position but risks old tires against fresh ones. |
| four-tire-stop | Four-tire stop | Say that four tires cost time on pit road but give the most grip for a long run. |
| two-tire-stop | Two-tire stop | Explain that two tires is a compromise: quicker stop, some grip. |
| track-position | Track position | Show that where you restart can outweigh raw speed, especially with few laps left. |
| pit-cycle | Pit cycle | Recognize that a caution reshuffles who is on which strategy. |
| fuel-window | Fuel window | See that fuel can force a pit stop even when track position says stay. |
| stage-strategy | Stage strategy | Understand that stage points can change the call near a stage end. |
| tire-falloff | Tire falloff | Connect tire age and abrasive tracks to how much fresh rubber is worth. |

**Out of scope:** Exact fuel arithmetic, real pit-crew timing (native `pits-01` covers it), tire compounds, weather and pit-road penalties. The projection model is an arcade abstraction meant to teach reasoning, not to predict real results.

## 4. Why Unity (tier justification)
**Rubric answer.** The decision depends on reading a dynamic scene: a field of cars reshuffles as some dive into pit road, service takes different times, and the exit order differs from the running order. Movement over time in space (who ends up ahead of whom) and a camera that shows the whole field and pit road at once (`top-down`) materially improve learning, and the consequence phase (the restart and a fast-forwarded stint) makes the trade-off visible.

**Closest native type and why it teaches worse:** `decision-scenario` teaches the *facts to weigh* and the vocabulary well, and is used in the same lesson (`pits-06` pairs this sim with a native decision-scenario set). It cannot show the field physically re-sorting on pit exit or the gaps opening and closing on the restart, which is what makes "track position" intuitive. Justification is moderate, not strong: if Astra capacity is constrained this sim is the first candidate to fall back to a native `decision-scenario` plus `sequence-order` (documented fallback, product decision).

## 5. Player fantasy & core loop
**Fantasy:** You are the crew chief on the box. A caution just flew, you have ten seconds to make the call, and everyone is listening.

1. **Prompt:** banner "Caution. Where do you want to be?" with a data card (laps to go, tire age, fuel window, stage).
2. **One decisive interaction:** tap Four tires, Two tires or Stay out (the player's #12 car and rivals' calls are visible as small tags).
3. **Execute:** the field drives to pit road; cars come out in real service order; the restart happens; a fast-forwarded stint runs (10x) to the projection lap.
4. **Freeze / explain:** freeze on the restart order, then on the projected finish; callouts show who passed whom and why (tire age bars).
5. **A line you could say out loud:** "They stayed out for track position."

**Session length:** about 3 minutes, 3 rounds (default). Maximum 240 s of play; `runtime.maxDurationMs` from native is authoritative.

## 6. Scene & entities
- **Environment (registry key):** `oval_intermediate` (same new key as `nascar.drafting.tuck-in.v1`; pit road drawn along the front stretch with 12 stalls)
- **Camera presets:** `top-down` (default: whole track and pit road), `broadcast-side` for the restart, `chase-high` for the fast-forward. Reduced motion: cuts only, fast-forward replaced by a cut to the result.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| player_car | `Vehicle` | player | number 12 (rose ring); tire age, fuel from scenario; `TireState`, `FuelState` |
| rival_01..11 | `Vehicle` + `TireState` | opponents | prePos, tire age, call (stay/2T/4T) from scenario; numbers 1-99 |
| pit_road | `Zone` (long rect) + `PitStop` | world | 12 stalls; entry/exit lines; speed-limit lane 45 mph label; stop time 4T=11.0 s, 2T=7.5 s |
| pace_car | `Vehicle` | event | leads the field under caution |
| dp_call | `DecisionPoint` | input | 3 `Target` buttons; time limit per difficulty |
| data_card | `Explanation` callout style | overlay | laps to go, tire-age bars, fuel window bar, stage marker |
| restart_line | `Zone` + `Position` | world | start/finish; the restart order is read from `Position` |
| projection | `Score` + `Timing` | logic | fast-forwards the model (section 11) to the projection lap and animates passes made and suffered |
| replay | `Replay` | review | records the pit exit and restart for slow-mo at 0.5x |

**Reused primitives:** `Vehicle`, `Track`, `TireState`, `FuelState`, `PitStop`, `Position`, `Timing`, `Zone`, `DecisionPoint`, `Target`, `Score`, `Replay`, `SlowMotion`, `Highlight`, `Explanation`, `CameraRig`, `Hint`.

**New / extended primitives:** None. Uses the Racing module (`Track`, `PitStop`, `TireState`, `FuelState`, `Position`, `Timing`). Environment key `oval_intermediate` shared with the drafting sim.

```
   pit road  ==[ 1 ][ 2 ][ 3 ] ... [12]==>   (exit)
   track (top-down):  P1 P2 P3 P4 P5 P6*(you) P7 ... P12
   [ Data card ]  laps to go 25 | tires 38 laps | fuel OK
   [ Four tires ]  [ Two tires ]  [ Stay out ]
```

## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Make the call | Tap one of three pill buttons at the bottom | 56 pt tall, 30% width each | Selected pill fills rose; car tag updates; soft tap haptic |
| Inspect rival | Tap a car ring to show its tire age and call | >= 44 pt ring | Data popover 2 s (free; does not count as a hint) |
| Hint | Tap Hint pill | 44 pt tall | Shows the model's projected finish for one option (counts as a hint; -5 score) |
| Pause | Top-right icon | 44 x 44 pt | Requests pause from native |

- **Accessible tap-only scheme (`ControlScheme.TapOnly`):** The three pill buttons are already tap-only. The Decision time limit is doubled and rival inspection opens a full-width list instead of popovers.
- **Safe area & orientation:** portrait. All controls sit inside `runtime.safeAreaInsets` plus 16 pt; the bottom 88 pt is reserved for the primary control so it never collides with the home indicator.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation, XP totals, streaks and lesson navigation (native). Unity draws only the in-scene HUD and overlays.

## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit / bridge events |
|---|---|---|---|
| Loading | `launch` received and validated | Build world from code, load scenario set, verify `configuration`; on failure emit `error CONFIG_INVALID` / `ASSET_LOAD_FAILED` | World ready -> emit `ready` -> Intro |
| Intro | After `ready` | `top-down`; banner "Caution. Check the field."; cars circle behind the pace car for 3 s; the data card populates | Tap Start (or auto after 6 s) -> Playing |
| Playing | Round begins | Green-flag stint fast-forwarded to the caution, then caution laps under the pace car; the learner may inspect rivals and read the card | Decision trigger -> Decision; time limit -> Freeze (timeout outcome). Emits `progress` (max 4/s) |
| Decision | Decision trigger reached | Time frozen at 0.15x; three call buttons active; timer ring when a limit exists | Choice made or time limit -> Executing. Emits `checkpoint` `round-<n>-decision` |
| Executing | Choice locked | Cars pit per their calls (service times from `PitStop`), exit in service order behind the stayers; restart; fast-forward 10x to the projection lap, drawing passes | Outcome resolved -> Freeze |
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
| Cars in the field | 8 | 10 | 12 | 12 | 12 |
| Rival calls visible | all | all | tap to reveal | tap to reveal | hidden until Execute |
| Decision time limit (s) | none | none | 15 | 10 | 8 |
| Hints (`Hint` uses) | unlimited | 3 | 2 | 1 | 0 |
| Data card detail | tire age + fuel + stage + lap | tire age + fuel + stage + lap | no lap counter | no fuel bar (tap to reveal) | minimal: tire age only |
| Falloff rate shown | yes | yes | no | no | no |
| Scenario pool tags | cc-01, cc-02, cc-09 | cc-01..cc-04, cc-06, cc-09 | cc-01..cc-08 | cc-03..cc-08 | cc-04, cc-05, cc-07, cc-08 + jittered |
| Rounds with a mid-round caution change | 0 | 0 | 0 | 1 | 1 |

**Default level for lesson `pits-06`: 2.** Level 1 is passable by a true beginner using hints alone. At levels 4-5 one round adds a second caution during the projection (the model re-evaluates from the new restart), teaching that strategy can be undone by the next yellow.

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
        "nascar-caution-call-core-1"
      ],
      "default": "nascar-caution-call-core-1"
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
    "revealProjection": {
      "type": "boolean",
      "default": true
    },
    "trackKind": {
      "type": "string",
      "enum": [
        "intermediate",
        "abrasive"
      ],
      "default": "intermediate"
    }
  },
  "additionalProperties": false
}
```

Valid example:

```json
{
  "seed": 7,
  "scenarioSetId": "nascar-caution-call-core-1",
  "roundCount": 3,
  "revealProjection": true,
  "trackKind": "intermediate"
}
```

## 11. Scenario data set
Set `nascar-caution-call-core-1`: **9 scenarios**, file `scenarios/nascar-caution-call-core-1.json`. **Projection model (deterministic):** effective tire age after the call = 0 (4T), 0.5 x age (2T), age (stay). Restart order = stayers by pre-caution position, then pitters sorted by `0.3 x prePos + stopSeconds` (4T 11.0, 2T 7.5). Advantage (seconds) over the window = (age difference) x falloffRate r x N laps. A car passes another if the advantage >= passCost (4.0 s); passes made and suffered are each capped at floor(N/2). Projected finish = restart position - passes made + passes suffered; staying out with fuelWindow < N adds +10 (forced green-flag stop). Verdict: best = lowest projected finish; acceptable = within +1; poor otherwise. Stage-kind scenarios also report stage points = max(0, 11 - projected position) for the score. All numbers are authored data; only display jitter uses `Rng(seed)`.

| scenarioId | setup | best call (projected finish) | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| cc-01 | Old tires, long run: Lap 96 of 267; player P6, tires 38 laps old, 25 laps to project, falloff 0.04 s per lap of age | Four tires (finish 4T P3, 2T P6, stay P8) | four-tire-stop | L1-3 |
| cc-02 | Leaders pit, you can lead: Lap 72 of 200 (just after a stage break); player P3, tires 6 laps old, 20 laps to project, falloff 0.025 s per lap of age | Stay out (finish 4T P12, 2T P10, stay P1) | stay-out | L1-3 |
| cc-03 | Two tires, few laps: Lap 181 of 200; player P6, tires 25 laps old, 8 laps to project, falloff 0.03 s per lap of age | Two tires (finish 4T P7, 2T P2, stay P5) | two-tire-stop | L2-4 |
| cc-04 | Fuel window says no: Lap 128 of 267; player P3, tires 6 laps old, 20 laps to project, falloff 0.025 s per lap of age, fuel 14 laps | Two tires (finish 4T P12, 2T P10, stay P11) | fuel-window | L3-5 |
| cc-05 | Stage points at stake: Lap 54 of 267; player P10, tires 20 laps old, 6 laps to project, falloff 0.04 s per lap of age | Four tires / Two tires (finish 4T P7, 2T P7, stay P10) | stage-strategy | L3-5 |
| cc-06 | Gamble on a caution-free run: Lap 150 of 267; player P9, tires 12 laps old, 30 laps to project, falloff 0.03 s per lap of age | Four tires (finish 4T P5, 2T P8, stay P12) | tire-falloff | L2-4 |
| cc-07 | Half the field stays out: Lap 210 of 267; player P4, tires 25 laps old, 10 laps to project, falloff 0.02 s per lap of age | Four tires (finish 4T P2, 2T P7, stay P9) | track-position | L3-5 |
| cc-08 | Darlington chews tires: Lap 133 of 293; player P7, tires 30 laps old, 25 laps to project, falloff 0.06 s per lap of age | Four tires (finish 4T P3, 2T P5, stay P7) | tire-falloff | L4-5 |
| cc-09 | Leader pits, second place stays: Lap 240 of 267; player P2, tires 10 laps old, 15 laps to project, falloff 0.02 s per lap of age | Stay out (finish 4T P12, 2T P11, stay P1) | stay-out | L2-4 |

**Fully written scenarios:**

**cc-01 (Old tires, long run):** Kansas-like intermediate, Lap 96 of 267. Player P6 with tires 38 laps old; falloff 0.04 s per lap of age; pass cost 4.0 s; projected window 25 laps (pass cap 12); fuel window 60 laps. Rival calls (all tires 38 laps old): P1:stay, P2:stay, P3:4T, P4:4T, P5:2T, P7:4T, P8:stay, P9:4T, P10:stay, P11:stay, P12:stay. Model results: Four tires restarts P10, makes 7 passes, is passed 0 times, projected P3 (best); Two tires restarts P8, makes 6 passes, is passed 4 times, projected P6 (poor); Stay out restarts P3, makes 0 passes, is passed 5 times, projected P8 (poor).

**cc-02 (Leaders pit, you can lead):** Kansas-like intermediate, Lap 72 of 200 (just after a stage break). Player P3 with tires 6 laps old; falloff 0.025 s per lap of age; pass cost 4.0 s; projected window 20 laps (pass cap 10); fuel window 60 laps. Rival calls (all tires 6 laps old): P1:4T, P2:4T, P4:stay, P5:stay, P6:stay, P7:stay, P8:stay, P9:stay, P10:stay, P11:stay, P12:stay. Model results: Four tires restarts P12, makes 0 passes, is passed 0 times, projected P12 (poor); Two tires restarts P10, makes 0 passes, is passed 0 times, projected P10 (poor); Stay out restarts P1, makes 0 passes, is passed 0 times, projected P1 (best).

**cc-03 (Two tires, few laps):** Kansas-like intermediate, Lap 181 of 200. Player P6 with tires 25 laps old; falloff 0.03 s per lap of age; pass cost 4.0 s; projected window 8 laps (pass cap 4); fuel window 60 laps. Rival calls (all tires 25 laps old): P1:4T, P2:4T, P3:2T, P4:4T, P5:4T, P7:4T, P8:4T, P9:2T, P10:4T, P11:4T, P12:4T. Model results: Four tires restarts P7, makes 0 passes, is passed 0 times, projected P7 (poor); Two tires restarts P2, makes 0 passes, is passed 0 times, projected P2 (best); Stay out restarts P1, makes 0 passes, is passed 4 times, projected P5 (poor).

The remaining scenarios use the shared JSON shape `{scenarioId, kind, track, lapsLabel, stageEndsInLaps?, N, falloffRate, passCost, player:{prePos, tireAge, fuelLaps}, rivals:[{prePos, tireAge, call}], correct:{best[], acceptable[]}, conceptId, tags}`; `correct` is *derived by the model at load time* and asserted equal to the authored value (load-time consistency check, `CONFIG_INVALID` if they differ).

## 12. Freeze / explain moments
Copy limits enforced by review: Title <= 6 words, body <= 45 words. Voice: cheeky coach, warm, a little flirty, never condescending; the learner is doing this for someone they care about.

### Explain 1: Fresh tires, worth it
- **Trigger:** Projection ends and the best call was tires (four or two)
- **What freezes:** Restart order with tire-age bars
- **Camera:** `broadcast-side` over the pack, then `top-down`
- **Callouts:** Gold arrows from your car through each car passed; tire-age bars (old = short, new = tall); rose label on lost time in the pits
- **Correct outcome copy**
  - Title: Nice read. Rubber wins.
  - Body: Old tires slow you every lap. Fresh ones let you run down the cars ahead of you, and the time in the pits pays back over a long run.
  - Say this: "They took four and drove right through the field."
- **Incorrect outcome copy**
  - Title: Not quite. Tires matter.
  - Body: You saved time on pit road but the cars on fresh rubber ran you down. On a long run, tire age adds up lap after lap. Check how many laps are left before you skip the stop.
  - Say this: "He stayed out too long on old tires."

### Explain 2: Track position
- **Trigger:** Projection ends and the best call was Stay out
- **What freezes:** Leader in clean air; fresh-tire cars stuck behind
- **Camera:** `chase-high` on the leader, then `top-down`
- **Callouts:** Gold ring on the leader; "CLEAN AIR" label; dotted rose arrows showing cars unable to pass
- **Correct outcome copy**
  - Title: Nice read. Track position.
  - Body: With few laps left or a small tire edge, cars behind cannot get by. Leading in clean air beats a fresher set of tires stuck behind you.
  - Say this: "They stayed out for track position and held on."
- **Incorrect outcome copy**
  - Title: Not quite. Position is power.
  - Body: Pitting sent you to the back of the field, and with too few laps left to pass everyone. Sometimes staying out and keeping your spot beats fresh tires.
  - Say this: "He gave up track position for tires."

### Explain 3: The fuel wall
- **Trigger:** A fuel-kind scenario where staying out forces a green-flag stop
- **What freezes:** Fuel bar hitting empty
- **Camera:** `top-down` on the player car
- **Callouts:** Rose fuel bar with the empty mark; gold arrow to pit road; label "WINDOW: 14 LAPS"
- **Correct outcome copy**
  - Title: Nice read. Fuel decides.
  - Body: Staying out was tempting, but the tank would not last the run. A forced green-flag stop costs more than pitting under caution. Two tires got you out fast.
  - Say this: "They had to pit for fuel anyway."
- **Incorrect outcome copy**
  - Title: Not quite. The tank is short.
  - Body: You stayed out but the fuel would not last, so you had to pit under green and lost lots of time. Always check the fuel window before you gamble.
  - Say this: "He ran out of fuel window and had to pit."

### Explain 4: Stage points
- **Trigger:** A stage-kind scenario resolves
- **What freezes:** Order at the stage-end line
- **Camera:** `broadcast-side` at the line
- **Callouts:** Gold numerals 10..1 beside the top ten; rose highlight on your finish; label "STAGE POINTS"
- **Correct outcome copy**
  - Title: Nice read. Points in hand.
  - Body: Near a stage end, where you finish decides bonus points. Fresh tires got you into the top ten before the flag, and that adds up across a season.
  - Say this: "They took tires and grabbed stage points."
- **Incorrect outcome copy**
  - Title: Not quite. Points slipped.
  - Body: Staying out left you on old tires and the cars behind ran you down before the stage ended. Those top-ten spots are worth real points.
  - Say this: "He lost stage points on old tires."


## 13. Scoring & mastery signals
**Score (0-100):** mean of round scores. Round score = 100 if the call's verdict is `best` (any tied best), 60 if `acceptable`, 0 if `poor`; -5 per Hint used (min 0). **Accuracy** = rounds with score >= 60 / rounds played. **Outcome ids:** `call-run`, `call-fuel`, `call-stage`, `call-gamble`. Decision latency is recorded but does not affect score.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text |
|---|---|---|
| Chose Stay out on old tires with a long run left (cc-01, cc-08) | tire-falloff | Ignored how much tire age costs over a long run |
| Chose tires when track position was worth more (cc-02, cc-09) | track-position | Gave up track position for fresh tires that could not pay back |
| Chose Stay out with fuel window shorter than the run (cc-04) | fuel-window | Ignored the fuel window |
| Chose the wrong tire count for the laps left (cc-03) | two-tire-stop | Took the long stop when a short one kept position |
| Chose Stay out near a stage end when points were at stake (cc-05) | stage-strategy | Ignored stage points |
| Chose Four when Two was clearly better | four-tire-stop | Overvalued full service |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; native applies its own +0.20/-0.15 exercise scale separately and halves gain when hints were used)

| event | conceptId | delta | evidence text |
|---|---|---|---|
| `call-run` success where best is Four | four-tire-stop | +0.15 | Took four for a long run |
| `call-run` success where best is Two | two-tire-stop | +0.15 | Took two for few laps |
| `call-run` success where best is Stay out | stay-out | +0.20 | Kept track position |
| Any successful round | track-position | +0.10 | Weighed where they restart |
| `call-fuel` success | fuel-window | +0.20 | Respected the fuel window |
| `call-stage` success | stage-strategy | +0.20 | Weighed stage points |
| Successful round on abrasive track (cc-08) | tire-falloff | +0.15 | Valued fresh tires at a tire-eating track |
| Any failed round | pit-cycle | -0.05 | Misread the pit cycle |
| Failed `call-fuel` round | fuel-window | -0.15 | Ignored fuel |

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

Failure always ends in an Explain moment, never a dead end. The projection is deterministic and always shown after a wrong call so the learner sees exactly how the result followed from their choice.

## 16. Accessibility
- **Reduced motion:** hard cuts instead of camera sweeps and dolly; no screen shake; freeze is instant; pulsing rings become static rings; overlay animations off.
- **Haptics off:** every haptic cue in section 17 has a visual and (if sound is on) audio equivalent.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): every color meaning has a second channel: shape and pattern (striped fill = wrong, dotted ring = correct, solid ring = selected) and car numbers on every vehicle. Tire-age bars use height plus a pattern (stripes = old, solid = new); stayers get a ring, pitters a chevron.
- **Text scale:** overlay text scales with `textScale` 0.8-3.0; callout cards reflow and scroll if needed; body >= 13 pt at scale 1.
- **Tap-only alternative:** see section 7.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson provided: ``pits-06` native `decision-scenario` set (same nine situations as text fact sheets) plus `pits-07` term-match` (a designed native exercise on the same concepts, not a port of this sim).

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
| stock-car-lowpoly (x12 LOD1) | procedural | original-swoond | ~1.2k tris | fictional numbers |
| oval_intermediate + pit road | procedural | original | ~9k tris | 12 stalls, lane markers |
| Pit crew silhouettes | procedural capsules (5 per stall for the player, none for rivals) | original | ~300 tris each | abstract, no logos |
| Tire-age and fuel bars | UI meshes | original | - | color + pattern |
| Sound cues | synthesized | original-swoond | < 0.8 MB total | air gun buzz synthesized, no recordings |

Addressables bundle: `sim-nascar-strategy-caution-call-v1` (expected size <= 8 MB compressed). Overlay styling per `docs/astra/ART_DIRECTION.md` sections 4-5. Vehicle liveries are fictional (no real team paint schemes, sponsors or logos); car numbers are generic.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps sustained on iPhone 13-class (5th percentile >= 50 fps), < 150 MB peak resident memory, cold launch < 2 s to `ready`, bundle <= 25 MB, <= 150 draw calls, <= 60k triangles on screen, <= 15 materials, textures <= 8 MB VRAM, audio <= 3 MB. **Tighter per-sim limits:** <= 14 vehicles on screen; fast-forward runs the model, not physics (10x timeline is scripted), so CPU stays under 60% of a core.

## 20. Telemetry
Diagnostics only, in `result.telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters `hintsUsed`, `decisionLatencyMs`, `callChosen`, `rivalInspections`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** The projection model reproduces the tabulated results for cc-01 (4T P3, 2T P6, Stay P8), cc-02 (4T P12, 2T P10, Stay P1) and cc-03 (4T P7, 2T P2, Stay P5).
2. **AC-2:** Load-time consistency: the authored `correct` set of every scenario equals the model-derived verdicts, or the sim raises `CONFIG_INVALID`.
3. **AC-3:** Restart order: stayers precede pitters; among pitters ordering uses 0.3 x prePos + stop seconds.
4. **AC-4:** Fuel rule: Stay out with fuel window < N adds exactly +10 to the projected finish and shows the Explain 3 copy.
5. **AC-5:** Fast-forward completes within 12 s at 10x and pass animations match `made`/`passed` counts.
6. **AC-6:** Under reduced motion the fast-forward is replaced by a cut to the result and the flow completes.
7. **AC-7:** Bridge conformance: given every `launch` example in `docs/contracts/unity-bridge/v1/examples/` (with `simulationId` swapped) the sim emits `ready`, >= 1 `progress`, one `result` valid against `simulation-result.schema.json`, then `requestExit`.
8. **AC-8:** Determinism: with the same `seed`, difficulty and scripted inputs two runs produce identical `outcomes[]`, `score` and scenario order.
9. **AC-9:** Invalid configuration (unknown key, out-of-range value) yields `error CONFIG_INVALID` within 500 ms and no scene load.
10. **AC-10:** With seed 42, difficulty 2 and default config the sim plays exactly 3 rounds and `result.outcomes` has exactly 3 entries.
11. **AC-11:** All explain copy: title <= 6 words, body <= 45 words, say-this line <= 120 characters; every conceptId used exists in the curriculum `concepts[]`.
12. **AC-12:** Reduced motion: no camera sweeps, no shake, freeze is a hard cut; flow still completes.
13. **AC-13:** Color-blind mode: every correct/incorrect marker has a non-color channel (pattern/shape) in a screenshot diff per mode.
14. **AC-14:** Pause/resume: pausing for 30 s mid-round then resuming continues from the same state with no timeout fired; abort emits a single result with `aborted:true`.
15. **AC-15:** Privacy: no log line, telemetry key or persisted file contains `personName` or `relationship` values.
16. **AC-16:** Budgets on iPhone 13-class: avg fps >= 58, p5 >= 50, peak memory < 150 MB, cold launch < 2 s.

## 22. Test plan
- **EditMode:** Projection model for all nine scenarios, restart ordering, fuel penalty, stage points, score maths, consistency check, config validation, determinism, result schema.
- **PlayMode:** Scene build; scripted runs at levels 1, 3, 5; pit road animation; fast-forward; freeze/explain; pause/resume/abort; tap-only; reduced motion; color-blind screenshots.
- **Perf:** 3 consecutive full runs at difficulty 5 on an iPhone 13-class device; record fps, memory, thermal state (must not exceed "fair").

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | Projection_MatchesTable |
| AC-2 | EditMode | Scenario_CorrectMatchesModel |
| AC-3 | EditMode | RestartOrder_Rules |
| AC-4 | PlayMode | FuelPenalty_Explain |
| AC-5 | PlayMode | FastForward_PassCounts |
| AC-6 | PlayMode | ReducedMotion_NoFastForward |
| AC-7 | EditMode | BridgeConformance_ResultValidatesAgainstSchema |
| AC-8 | EditMode | Determinism_SameSeedSameResult |
| AC-9 | EditMode | Config_InvalidRejected |
| AC-10 | PlayMode | FullRun_ThreeOutcomes |
| AC-11 | EditMode | Copy_LengthsAndConceptIds |
| AC-12 | PlayMode | ReducedMotion_NoSweeps |
| AC-13 | PlayMode | ColorBlind_SecondChannel |
| AC-14 | PlayMode | PauseResumeAbort |
| AC-15 | EditMode | Privacy_NoPersonData |
| AC-16 | Perf | PerfBudget_IPhone13 |

## 23. Open questions

| # | Question | Owner (Claude / Astra / Product) | Blocking? |
|---|---|---|---|
| 1 | SME review of model constants (falloff, passCost, cap) so results feel plausible to a NASCAR fan; tune per scenario if needed. | Product / Claude | No |
| 2 | Confirm pit-stop times (4T 11.0 s, 2T 7.5 s) as arcade values; real Next Gen stops are roughly 9-12 s for four tires. | Claude | No |
| 3 | Level 4-5 second-caution mechanic: confirm scope is OK for v1.0.0 or defer to 1.1.0. | Astra / Product | No |
| 4 | Moderate Unity justification: confirm the native fallback (`decision-scenario` set) is acceptable if capacity is limited. | Product | No |

## Game Kit additions requested
- None new. Uses existing Racing module primitives (`PitStop`, `TireState`, `FuelState`, `Position`, `Timing`). A `ProjectionModel` helper class is sim-local (Swoond.Sims.Nascar), not a kit primitive.
