# Feel the Balance (`nascar.handling.tight-loose.v1`)

## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `nascar.handling.tight-loose.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven: definition file `nascar.handling.tight-loose.v1.definition.json` composed from Game Kit primitives) |
| Authors / date | Swoon'd curriculum design (Claude) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `nascar`; `unitId`: `handling`; `lessonId`: `hand-03` (also usable as a review activity from `perpetual-review`).
- CDS row: `docs/courses/nascar/CDS.md` section 12, row "Diagnose and adjust (sim)".
- Manifest entry: `docs/courses/nascar/manifest.json` -> `unitySimulations[]` (simulationId `nascar.handling.tight-loose.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `car-balance` (primer if missing), `tires-and-wheels`; `tight-push` and `loose` are introduced in `hand-01` and re-taught by this sim.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can watch a car go through a corner, tell whether it is tight or loose, and know which way a crew chief needs to move the balance.

| conceptId | term | After the sim the learner can... |
|---|---|---|
| tight-push | Tight (push) | Recognize a car that runs wide because the front will not turn, and say the front needs more grip. |
| loose | Loose | Recognize a car whose rear steps out, and say the rear needs more grip. |
| car-balance | Balance | Explain that the goal is a neutral car and that small changes matter. |
| adjustments | Adjustments | Say that crews shift grip between front and rear with tools like tire pressure, wedge and track bar, without needing the exact settings. |
| tire-falloff | Tire falloff | See that balance changes as tires wear during a long run. |
| long-run-speed | Long-run vs short-run speed | Explain why a car that is perfect on fresh tires can be a handful 25 laps later. |
| dirty-air | Dirty air | Notice that a car can feel tight only because it is following another car. |

**Out of scope:** Exact setup numbers (spring rates, wedge turns, track bar inches, pressures) and which specific tool moves balance in which direction. The dial is abstract: "more front grip" or "more rear grip". Real crews have many tools, and the CDS never claims one tool is the fix.

## 4. Why Unity (tier justification)
**Rubric answer.** Physics and camera perspective are the concept. Tight and loose are defined by how the car moves through a corner: understeer pushes the nose up the track toward the wall, oversteer swings the tail. Seeing the car's actual path against the ideal line from a chase-high or top-down camera, with slip arrows on the front and rear tires, is what makes the terms click. The learner then changes the balance and watches the same corner replay differently: cause and effect over time in space.

**Closest native type and why it teaches worse:** `visual-id` with a still photo cannot show slip; `multiple-choice` or `term-match` can state the definitions ("tight = front loses grip") and are used in `hand-01`/`hand-02`, but definitions alone are exactly what learners forget. A native `binary-call` on a static diagram cannot show the drift growing through the corner or the tail stepping out. `estimate-slider` teaches magnitudes, not motion.

## 5. Player fantasy & core loop
**Fantasy:** You are the crew chief with a headset on, watching your driver fight the car through turn four.

1. **Prompt:** banner "He says it will not turn. What do you see?" (level-dependent).
2. **Watch:** the car runs the corner once (5 s) with slip arrows; the ideal line is a gold dotted path, the actual line a rose trail.
3. **One decisive interaction:** set the Balance dial (more rear grip <-> more front grip) or, at levels 1-2, tap one of three presets.
4. **Execute:** the same corner replays with the new balance; the trail updates; a Balance needle shows the result.
5. **Freeze / explain:** freeze at corner exit; callouts name tight/loose and what changed; **a line you could say out loud:** "He is tight in the middle of the corner."

**Session length:** about 3 minutes, 3 rounds (default). Maximum 240 s of play; `runtime.maxDurationMs` from native is authoritative.

## 6. Scene & entities
- **Environment (registry key):** `oval_intermediate` (turn 3-4 segment only; shared key with the drafting and caution sims)
- **Camera presets:** `chase-high` (default), `top-down` for the Freeze and the Replay (0.5x). Reduced motion: cuts, no dolly.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| player_car | `Vehicle` + `HandlingBalance` (new racing component) | player | frontGrip, rearGrip in 0..1; balance b = (frontGrip - rearGrip) normalized to -1..+1 (negative = tight, positive = loose) |
| ideal_line | `Path` (gold) | overlay | apex line through T3-T4, drawn as gold dotted line |
| actual_trail | `Path` (rose) | overlay | recorded trail of the car; deviates by lateral offset (tight) or yaw (loose) |
| slip_arrows | `Highlight` (extension `SlipArrows`) | overlay | two arrows at front and rear tires, length = slip; gold when neutral |
| wall | `Zone` | world | outside wall zone; offset beyond 4.5 m triggers a harmless "kiss the wall" slide |
| balance_dial | `TouchController` drag + `Target` | input | horizontal dial 88 pt tall; rear glyph left, front glyph right; range -1..+1; step 0.05 |
| balance_needle | `Score`/HUD | overlay | needle with a neutral band +/- tolerance (tolerance per level) |
| lap_delta | `Timing` | overlay | lap-time delta vs neutral (seconds); Display S numeral |
| replay | `Replay` | review | records the execute run for 0.5x replay |

**Reused primitives:** `Vehicle`, `Track`, `Path`, `Zone`, `Target`, `TouchController`, `DecisionPoint`, `Timing`, `Score`, `Replay`, `SlowMotion`, `Highlight`, `Explanation`, `CameraRig`, `Hint`, `TireState`.

**New / extended primitives:** `HandlingBalance` (Racing module component on `Vehicle`): deterministic front/rear grip to lateral offset and yaw mapping; reusable by F1, karting and any car-handling lesson. `SlipArrows` (Highlight extension).

```
        wall  ===============================
                       ideal line (gold ....)
   exit   . . . . . . ..
        car (rose trail ~~~~ drifts up toward the wall = TIGHT)
   [ rear grip  <----O---->  front grip ]   <- Balance dial
   needle:  TIGHT [====|====] LOOSE   (neutral band in gold)
```

## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Balance dial | Horizontal drag; releases on lift | >= 88 pt tall x full width | Needle preview updates live; soft tick each 0.25 step |
| Preset buttons (levels 1-2) | Tap: More front grip / Hold / More rear grip | 56 pt tall, 30% width each | Fixed step 0.5 in that direction |
| Go / Rerun | Tap the pill above the dial | 56 pt | Locks the choice and replays the corner |
| Hint | Tap Hint pill | 44 pt | Shows slip arrows and a text cue on the first watch (counts as a hint) |

- **Accessible tap-only scheme (`ControlScheme.TapOnly`):** Presets replace the dial at all levels: More front grip / Hold / More rear grip (each 0.35 of dial range, up to 3 taps per decision). Go/Rerun is a tap in both schemes.
- **Safe area & orientation:** portrait. All controls sit inside `runtime.safeAreaInsets` plus 16 pt; the bottom 88 pt is reserved for the primary control so it never collides with the home indicator.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation, XP totals, streaks and lesson navigation (native). Unity draws only the in-scene HUD and overlays.

## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit / bridge events |
|---|---|---|---|
| Loading | `launch` received and validated | Build world from code, load scenario set, verify `configuration`; on failure emit `error CONFIG_INVALID` / `ASSET_LOAD_FAILED` | World ready -> emit `ready` -> Intro |
| Intro | After `ready` | `chase-high`; banner "Watch the car through turns 3 and 4."; car runs once with arrows visible at level 1-2 | Tap Start (or auto after 6 s) -> Playing |
| Playing | Round begins | Watch run of 5 s; the actual trail is drawn; at corner exit the sim pauses (`SlowMotion`) and the needle reveals only at levels 1-3 | Decision trigger -> Decision; time limit -> Freeze (timeout outcome). Emits `progress` (max 4/s) |
| Decision | Decision trigger reached | Dial or presets active; timer ring if limited; optional Hint | Choice made or time limit -> Executing. Emits `checkpoint` `round-<n>-decision` |
| Executing | Choice locked | Corner replays with new balance for 5 s (drift scenarios: fast-forward the run and show the balance graph across laps) | Outcome resolved -> Freeze |
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
| Neutral tolerance /b/ | 0.35 | 0.25 | 0.20 | 0.15 | 0.12 |
| Input mode | 3 presets | 3 presets | continuous dial | continuous dial | continuous dial |
| Slip arrows visible on watch run | always | always | on request (Hint) | on request (Hint) | off |
| Balance needle visible before Decision | yes | yes | yes | no | no |
| Drift (tires wearing) rounds | 0 | 0 | 1 | 1 | 2 |
| Decisions per round | 1 | 1 | 1 | 1 | 2 |
| Decision time limit (s) | none | none | 15 | 12 | 10 |
| Hints (`Hint` uses) | unlimited | 3 | 2 | 1 | 0 |
| Scenario pool tags | hs-01, hs-02 | hs-01..hs-03 | hs-01..hs-06 | hs-03..hs-08 | hs-05..hs-09 |

**Default level for lesson `hand-03`: 2.** Level 1 is passable by a true beginner using hints alone. Balance model: after the dial value d (-1 = more rear grip, +1 = more front grip) the new balance is b_new = b0 + 0.7 x d.

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
        "nascar-tight-loose-core-1"
      ],
      "default": "nascar-tight-loose-core-1"
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
    "inputMode": {
      "type": "string",
      "enum": [
        "auto",
        "presets",
        "dial"
      ],
      "default": "auto",
      "description": "auto follows difficulty."
    },
    "showSlipArrows": {
      "type": "boolean",
      "default": true
    }
  },
  "additionalProperties": false
}
```

Valid example:

```json
{
  "seed": 314,
  "scenarioSetId": "nascar-tight-loose-core-1",
  "roundCount": 3,
  "inputMode": "auto",
  "showSlipArrows": true
}
```

## 11. Scenario data set
Set `nascar-tight-loose-core-1`: **9 scenarios**, file `scenarios/nascar-tight-loose-core-1.json`. Model: balance b in -1..+1 (negative tight, positive loose), neutral if |b| <= tolerance. Lateral drift at exit (m) = 6 x max(0, -b - 0.1); tail yaw (deg) = 25 x max(0, b - 0.1). After the dial d in [-1, +1]: b_new = b0 + 0.7 d (segment scenarios use the mean of entry/mid/exit values; drift scenarios use the mean of b over the run). The correct dial range for a tolerance t is [(-t - b0)/0.7, (t - b0)/0.7] clipped to [-1, 1]. Round score: 100 if |b_new| <= t; 60 if |b_new| <= 0.5 |b0| (improved but not neutral); else 0. Deterministic.

| scenarioId | setup | correct decision (dial range at L2 tolerance 0.25) | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| hs-01 | Tight in the middle: b0 = -0.55 (drifts 2.7 m up the track at exit) | More front grip: d in [+0.43, +1.00] | tight-push | L1-3 |
| hs-02 | Loose off the corner: b0 = +0.50 (tail yaw 10 degrees) | More rear grip: d in [-1.00, -0.36] | loose | L1-3 |
| hs-03 | Good car, driver whines: b0 = +0.05 | Hold: d in [-0.43, +0.29] | car-balance | L2-4 |
| hs-04 | Long run: b starts -0.15 and rises +0.02 per lap for 30 laps (mean +0.15) | Set slightly to the rear side to center the run: d in [-0.57, +0.14] | tire-falloff | L3-5 |
| hs-05 | Tight on entry (-0.40), loose on exit (+0.30): mean -0.05 | Hold (compromise): d in [-0.29, +0.43] | car-balance | L3-5 |
| hs-06 | Following another car: b = -0.50 in dirty air, 0.00 in clean air | Hold or small change (/d/ <= 0.25); large fixes make it loose in clean air | dirty-air | L3-5 |
| hs-07 | Very loose short-track exit: b0 = +0.65 | More rear grip: d in [-1.00, -0.57] | loose | L2-5 |
| hs-08 | Overcorrected last stop: b0 = +0.40 after a previous fix | Move back: d in [-0.93, -0.21] | adjustments | L4-5 |
| hs-09 | Two-stint finale: stint 1 b0 = -0.50; stint 2 starts -0.20 rising +0.03 per lap for 20 laps | Two decisions: front grip, then a small rear-side shift | long-run-speed | L5 |

**Fully written scenarios:**

**hs-01 (tight in the middle):** segment T3-T4 at an intermediate oval; b0 = -0.55; lateral drift at exit = 6 x (0.55 - 0.1) = 2.7 m (car runs toward the wall but stays off it); needle reads left of the neutral band; a radio line "It will not turn in the middle!" plays as text. Level-2 tolerance 0.25: correct dial d in [+0.43, +1.00]; Hold (d = 0) leaves b = -0.55 (score 0), a small change d = +0.3 gives b = -0.34 (improved 38%: not enough for 60, needs <= 0.275). After the fix the trail hugs the gold line.

**hs-02 (loose off the corner):** b0 = +0.50; tail yaw = 25 x 0.4 = 10 degrees on exit; radio "Loose on exit, tail is stepping out!". Correct d in [-1.00, -0.36]. Wrong direction d = +0.5 gives b = +0.85 (yaw 18.8 degrees and a visible slide) -> score 0 and mistake `loose`.

**hs-03 (leave it alone):** b0 = +0.05 with the radio line "It is a little bit off, change something!" Correct d in [-0.43, +0.43] (Hold is best). A learner who cranks d = +0.8 makes the car b = +0.61 (loose) and the sim shows the car getting worse; score 0 and a mistake `car-balance`. Teaches restraint and that the goal is neutral, not maximum change.

Other scenarios follow `{scenarioId, kind:'segment'|'drift'|'dirty-air'|'two-stint', b0 | {entry, mid, exit} | {start, slope, laps}, radioLine, toleranceOverride?, correct:{dialMin(at L2), dialMax}, conceptId, tags}`. `correct` is derived at load time from the formulas and asserted against authored values. Radio lines are original text, not quoted from broadcasts.

## 12. Freeze / explain moments
Copy limits enforced by review: Title <= 6 words, body <= 45 words. Voice: cheeky coach, warm, a little flirty, never condescending; the learner is doing this for someone they care about.

### Explain 1: Tight
- **Trigger:** Execute ends and the initial condition was tight
- **What freezes:** Car at corner exit, front tires with slip arrows
- **Camera:** `top-down` then `chase-high`
- **Callouts:** Rose arrow on the front tires (long); gold dotted ideal line; rose trail drifting toward the wall; label "TIGHT: front gives up"
- **Correct outcome copy**
  - Title: Nice read. Nose fixed.
  - Body: Tight means the front tires give up first, so the car runs wide. Giving the front more grip pulls the nose back to the line. Crews do that with tire pressure, wedge and more.
  - Say this: "He is tight in the middle of the corner."
- **Incorrect outcome copy**
  - Title: Not quite. Wrong way.
  - Body: The car was pushing wide because the front had less grip than the rear. Moving grip toward the rear makes it worse. Move it toward the front instead.
  - Say this: "He is tight, so they need front grip."

### Explain 2: Loose
- **Trigger:** Execute ends and the initial condition was loose
- **What freezes:** Car at corner exit, rear tires with slip arrows
- **Camera:** `top-down` then `chase-high`
- **Callouts:** Rose arrow on the rear tires (long); yaw angle wedge; label "LOOSE: tail steps out"
- **Correct outcome copy**
  - Title: Nice read. Tail tamed.
  - Body: Loose means the rear lets go first, so the tail swings out. Giving the rear more grip settles it. A calm rear lets the driver get on the gas earlier.
  - Say this: "He was loose off the corner."
- **Incorrect outcome copy**
  - Title: Not quite. Wrong direction.
  - Body: The rear was sliding because it had less grip than the front. Adding grip to the front makes the tail step out even more. Give the rear more grip instead.
  - Say this: "He is loose, so they need rear grip."

### Explain 3: Leave it alone
- **Trigger:** Execute ends in a `car-balance` scenario where the car was already neutral
- **What freezes:** Neutral needle with the gold band
- **Camera:** `chase-high`
- **Callouts:** Gold needle inside the band; label "GOOD ENOUGH"; rose arrows only if the learner overcorrected
- **Correct outcome copy**
  - Title: Nice read. Do nothing.
  - Body: A neutral car is the goal. Drivers always want a little more, but every change moves grip somewhere else. Sometimes the best call is a smile and a hold.
  - Say this: "It is close, they should not touch it."
- **Incorrect outcome copy**
  - Title: Not quite. It was fine.
  - Body: The car was already close to neutral. Big changes made it tight or loose. Small changes only when you can see the problem in the line.
  - Say this: "They overreacted and made it worse."

### Explain 4: The long run
- **Trigger:** A drift scenario resolves
- **What freezes:** Balance graph across laps with the neutral band
- **Camera:** `top-down` on a graph card
- **Callouts:** Gold band; rose curve rising as tires wear; label "PERFECT ON LAP 5, LOOSE ON LAP 30"
- **Correct outcome copy**
  - Title: Nice read. Built for the run.
  - Body: Tires wear and the balance moves through a run. A smart crew chief centers the car for the whole run, not just for the first laps.
  - Say this: "They set it up for the long run."
- **Incorrect outcome copy**
  - Title: Not quite. Think ahead.
  - Body: You fixed the car for lap one, but the balance drifted as tires wore. Set it so the middle of the run is neutral and both ends stay close.
  - Say this: "It was fast on fresh tires and faded."

### Explain 5: Dirty air
- **Trigger:** A dirty-air scenario resolves
- **What freezes:** Car behind another car with the clean-air overlay
- **Camera:** `chase-high` low
- **Callouts:** Rose front-grip bar dropping behind the leader; gold bar in clean air; label "FOLLOWING = TIGHT"
- **Correct outcome copy**
  - Title: Nice read. It is the air.
  - Body: Right behind another car, the nose gets messy air and loses grip, so the car feels tight. In clean air it is fine. Do not fix what the traffic caused.
  - Say this: "He is only tight because he is behind someone."
- **Incorrect outcome copy**
  - Title: Not quite. Traffic did it.
  - Body: The car was neutral in clean air. The push came from following another car. A big fix would make it loose the moment he passes. Wait to see clean-air behavior.
  - Say this: "He fixed it for traffic and got loose in clean air."


## 13. Scoring & mastery signals
**Score (0-100):** mean of round scores; per-decision scores average within two-decision rounds. Decision score = 100 if |b_new| <= tolerance; 60 if |b_new| <= 0.5 x |b0| (improved but not neutral); else 0; -5 per Hint used (min 0). Hold in a neutral scenario scores 100. **Accuracy** = rounds with score >= 60 / rounds. **Outcome ids:** `balance-tight`, `balance-loose`, `balance-hold`, `balance-drift`, `balance-dirty-air`.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text |
|---|---|---|
| Moved the dial toward the wrong end in a tight scenario | tight-push | Took front grip away from a car that already pushed |
| Moved the dial toward the wrong end in a loose scenario | loose | Took rear grip away from a car that was already loose |
| Overcorrected across neutral (/b_new/ > tolerance on the other side) | car-balance | Fixed the problem and created the opposite one |
| Changed a neutral car (/d/ > 0.5 in hs-03 / hs-06) | car-balance | Changed a car that was already fine |
| Set for lap one in a drift scenario | tire-falloff | Ignored how tires change the balance over a run |
| Big fix for dirty-air tightness | dirty-air | Solved a traffic problem with a setup change |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; native applies its own +0.20/-0.15 exercise scale separately and halves gain when hints were used)

| event | conceptId | delta | evidence text |
|---|---|---|---|
| `balance-tight` success | tight-push | +0.20 | Moved balance toward the front |
| `balance-loose` success | loose | +0.20 | Moved balance toward the rear |
| `balance-hold` success | car-balance | +0.15 | Left a good car alone |
| Any successful round | adjustments | +0.10 | Used the dial to shift grip |
| `balance-drift` success | tire-falloff | +0.20 | Centered the balance for the whole run |
| `balance-drift` success | long-run-speed | +0.10 | Understood fresh-tire vs long-run feel |
| `balance-dirty-air` success | dirty-air | +0.20 | Recognized traffic as the cause |
| Wrong-direction move in tight scenario | tight-push | -0.15 | Wrong direction |
| Wrong-direction move in loose scenario | loose | -0.15 | Wrong direction |
| Failed round (other) | car-balance | -0.10 | Balance not neutral |

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

Failure always ends in an Explain moment, never a dead end. A wrong-direction move plays out visibly (the car gets worse) so the Explain always contrasts the two runs side by side.

## 16. Accessibility
- **Reduced motion:** hard cuts instead of camera sweeps and dolly; no screen shake; freeze is instant; pulsing rings become static rings; overlay animations off.
- **Haptics off:** every haptic cue in section 17 has a visual and (if sound is on) audio equivalent.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): every color meaning has a second channel: shape and pattern (striped fill = wrong, dotted ring = correct, solid ring = selected) and car numbers on every vehicle. Slip arrows use length plus a chevron pattern (front) vs bar pattern (rear); the neutral band is striped in addition to gold.
- **Text scale:** overlay text scales with `textScale` 0.8-3.0; callout cards reflow and scroll if needed; body >= 13 pt at scale 1.
- **Tap-only alternative:** see section 7.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson provided: ``hand-01` and `hand-02` native sets (`visual-id`, `binary-call` on tight/loose with static diagrams and radio lines) and `hand-05` (`term-match` for tools), which are already in the curriculum` (a designed native exercise on the same concepts, not a port of this sim).

## 17. Audio & haptics

| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Round start | Soft engine idle swell (0.5 s) | Soft tap | -18 dB |
| Correct outcome | Warm two-note chime | Light success | -12 dB |
| Incorrect outcome | Low single tone | Warning | -12 dB |
| Freeze | Low-pass filter over ambient, 250 ms | Soft tap | -15 dB |
| Callout appears | Short paper tick | None | -20 dB |
| Summary numerals | Soft tick per 10 points | None | -22 dB |
| Radio line appears | Short static blip (synthesized) | None | -20 dB |
| Wall kiss | Soft scrape (synthesized) | Warning (light) | -16 dB |

All cues honor `soundEnabled` and `hapticsEnabled`. No music. Engine ambience is synthesized (procedural), never a licensed recording.

## 18. Art & asset list

| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| stock-car-lowpoly (1 hero, LOD0) | procedural | original-swoond | ~3k tris | fictional number 12 |
| Turn 3-4 segment | procedural spline mesh with banking | original | ~6k tris | wall as extruded strip |
| Slip arrows, needle, dial | UI meshes | original | - | pattern + color |
| Sound cues | synthesized | original-swoond | < 0.6 MB |  |

Addressables bundle: `sim-nascar-handling-tight-loose-v1` (expected size <= 5 MB compressed). Overlay styling per `docs/astra/ART_DIRECTION.md` sections 4-5. Vehicle liveries are fictional (no real team paint schemes, sponsors or logos); car numbers are generic.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps sustained on iPhone 13-class (5th percentile >= 50 fps), < 150 MB peak resident memory, cold launch < 2 s to `ready`, bundle <= 25 MB, <= 150 draw calls, <= 60k triangles on screen, <= 15 materials, textures <= 8 MB VRAM, audio <= 3 MB. **Tighter per-sim limits:** One hero car and a track segment: target 60 fps with headroom; replay buffer <= 8 MB.

## 20. Telemetry
Diagnostics only, in `result.telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters `hintsUsed`, `decisionLatencyMs`, `dialValue`, `roundsOvercorrected`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** Balance maths: for hs-01 at L2 the correct dial range is [+0.43, +1.00] and d = +0.3 yields score 0.
2. **AC-2:** Load-time consistency: `correct` dial ranges in the data equal the model-derived range for every scenario at every level.
3. **AC-3:** Wrong-direction move in hs-02 (d = +0.5) yields b_new = +0.85 and score 0 with mistake `loose`.
4. **AC-4:** hs-03 Hold scores 100 and d = +0.8 scores 0 with mistake `car-balance`.
5. **AC-5:** Drift scenario hs-04: mean-of-run scoring; d = -0.21 scores 100 at L4.
6. **AC-6:** At levels 1-2 the dial is replaced by 3 presets and every preset is >= 44 pt.
7. **AC-7:** Replay shows both runs (before/after) side by side under 0.5x in the Explain step.
8. **AC-8:** Bridge conformance: given every `launch` example in `docs/contracts/unity-bridge/v1/examples/` (with `simulationId` swapped) the sim emits `ready`, >= 1 `progress`, one `result` valid against `simulation-result.schema.json`, then `requestExit`.
9. **AC-9:** Determinism: with the same `seed`, difficulty and scripted inputs two runs produce identical `outcomes[]`, `score` and scenario order.
10. **AC-10:** Invalid configuration (unknown key, out-of-range value) yields `error CONFIG_INVALID` within 500 ms and no scene load.
11. **AC-11:** With seed 42, difficulty 2 and default config the sim plays exactly 3 rounds and `result.outcomes` has exactly 3 entries.
12. **AC-12:** All explain copy: title <= 6 words, body <= 45 words, say-this line <= 120 characters; every conceptId used exists in the curriculum `concepts[]`.
13. **AC-13:** Reduced motion: no camera sweeps, no shake, freeze is a hard cut; flow still completes.
14. **AC-14:** Color-blind mode: every correct/incorrect marker has a non-color channel (pattern/shape) in a screenshot diff per mode.
15. **AC-15:** Pause/resume: pausing for 30 s mid-round then resuming continues from the same state with no timeout fired; abort emits a single result with `aborted:true`.
16. **AC-16:** Privacy: no log line, telemetry key or persisted file contains `personName` or `relationship` values.
17. **AC-17:** Budgets on iPhone 13-class: avg fps >= 58, p5 >= 50, peak memory < 150 MB, cold launch < 2 s.

## 22. Test plan
- **EditMode:** Balance/drift/yaw maths for all nine scenarios, dial-range derivation, drift mean scoring, overcorrection detection, score maths, config validation, determinism, result schema.
- **PlayMode:** Scene build; scripted full runs at levels 1, 3, 5; presets and dial input; explain sequences for all five moments; pause/resume/abort; tap-only; reduced motion; color-blind screenshots.
- **Perf:** 3 consecutive full runs at difficulty 5 on an iPhone 13-class device; record fps, memory, thermal state (must not exceed "fair").

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | BalanceModel_hs01 |
| AC-2 | EditMode | Scenario_CorrectMatchesModel |
| AC-3 | EditMode | WrongDirection_Loose |
| AC-4 | EditMode | Hold_NeutralCar |
| AC-5 | EditMode | DriftScoring_hs04 |
| AC-6 | PlayMode | Presets_HitTargets |
| AC-7 | PlayMode | Explain_SideBySide |
| AC-8 | EditMode | BridgeConformance_ResultValidatesAgainstSchema |
| AC-9 | EditMode | Determinism_SameSeedSameResult |
| AC-10 | EditMode | Config_InvalidRejected |
| AC-11 | PlayMode | FullRun_ThreeOutcomes |
| AC-12 | EditMode | Copy_LengthsAndConceptIds |
| AC-13 | PlayMode | ReducedMotion_NoSweeps |
| AC-14 | PlayMode | ColorBlind_SecondChannel |
| AC-15 | PlayMode | PauseResumeAbort |
| AC-16 | EditMode | Privacy_NoPersonData |
| AC-17 | Perf | PerfBudget_IPhone13 |

## 23. Open questions

| # | Question | Owner (Claude / Astra / Product) | Blocking? |
|---|---|---|---|
| 1 | Subject-matter review: confirm the abstract front/rear-grip dial is acceptable and add named tools (wedge, track bar, pressure) in a later minor version only with verified direction of effect. | Product / Claude | No |
| 2 | `HandlingBalance` component ownership: kit Racing module or sim-local for v1? | Astra | No |
| 3 | Radio lines are original copy; confirm they may be shown as on-screen text (no audio VO in v1). | Claude | No |

## Game Kit additions requested
- `HandlingBalance` (Racing module; Vehicle component): `SetBalance(float b)`, outputs lateral offset and yaw; deterministic; reusable for F1, karting.
- `SlipArrows` (Highlight extension): arrows at named wheels sized by slip.
