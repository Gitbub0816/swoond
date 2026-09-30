# Pick the Lane (`nascar.drafting.superspeedway-run.v1`)

## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `nascar.drafting.superspeedway-run.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven: definition file `nascar.drafting.superspeedway-run.v1.definition.json` composed from Game Kit primitives) |
| Authors / date | Swoon'd curriculum design (Claude) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `nascar`; `unitId`: `tracks-air`; `lessonId`: `tracks-09` (also usable as a review activity from `perpetual-review`).
- CDS row: `docs/courses/nascar/CDS.md` section 12, row "Packs and the Big One (sim)".
- Manifest entry: `docs/courses/nascar/manifest.json` -> `unitySimulations[]` (simulationId `nascar.drafting.superspeedway-run.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `drafting`, `aerodynamic-drag`, `bump-draft`, `side-draft`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can read a pack of cars, spot the lane with the momentum, and say why one lane is running away while another has stalled.

| conceptId | term | After the sim the learner can... |
|---|---|---|
| lane-choice | Lane choice | Pick the lane whose line of cars is longest and moving fastest, not the one that is empty. |
| the-run | A run | Explain that a run comes from being pushed and drafted by cars behind and ahead in your lane. |
| pack-racing | Pack racing | Describe why superspeedway cars stay bunched: the draft evens speeds out. |
| the-big-one | The Big One | Recognize how one wreck ahead spreads through a pack and pick the open lane on a spotter call. |
| blocking | Blocking | See that a defender can break a run by moving into your lane, and what that costs him. |
| spotter-talk | Spotter talk | Decode "stay high" and "clear low" calls in a moment of danger. |

**Out of scope:** Bump-draft mechanics at contact level, engine temperature, fuel saving, stage strategy and exact superspeedway rulebook details. Wrecks are stylized (cars spin out of the way; no injury depiction).

## 4. Why Unity (tier justification)
**Rubric answer.** Reading a dynamic scene is the concept: which lane has the run depends on how a whole line of cars is moving right now, and on what the car ahead is about to do. Movement over time in space and camera perspective (the broadcast/top-down view shows the pack the way a spotter sees it) materially improve learning. The Big One is inherently spatial: the learner must see where the wreck is and where the space is.

**Closest native type and why it teaches worse:** `decision-scenario` or `hotspot-tap` on a static diagram can show a snapshot but cannot show that momentum is a property of motion (a line of cars accelerating together, a block breaking a run). A learner could memorize "pick the long line" without ever seeing why. `say-this` and `talk-track` teach the vocabulary natively. This sim is the payoff of the drafting lessons.

## 5. Player fantasy & core loop
**Fantasy:** You are in the pack on the last laps at Talladega and the whole race is about picking the right lane.

1. **Prompt:** in-scene banner "Two laps to go. Which lane has the run?"
2. **One decisive interaction:** time slows to 0.25x; tap the lane (low, middle, high) you want to be in.
3. **Execute:** your car moves into the lane; the pack plays out for 5 s; the deterministic model decides how many spots you gain or lose.
4. **Freeze / explain:** freeze on the moment the run is decided; lane momentum arrows appear; callout explains why.
5. **A line you could say out loud:** "The middle lane had the momentum."

**Session length:** about 3 minutes, 3 rounds (default). Maximum 240 s of play; `runtime.maxDurationMs` from native is authoritative.

## 6. Scene & entities
- **Environment (registry key):** `oval_superspeedway` (new registry key requested: 2.66-mile tri-oval, 33 degree stylized banking, 3 painted lanes)
- **Camera presets:** `broadcast-side` (default, framing 10 cars), `top-down` for the Decision and Freeze, `chase-high` for the 5 s execute of the player car. Reduced motion: cuts only.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| player_car | `Vehicle` | player | number 12, rose ring; starts in lane and row from scenario |
| pack_01..13 | `Vehicle` (low LOD) | opponents | position (lane, gapLengths) from scenario; pace by lane momentum |
| lane_low, lane_mid, lane_high | `Zone` + `Target` (3) | selectable lanes | full-height translucent bands (`accentTint` on hover); `Target.IsCorrect` set by the model |
| draft | `Draft` | physics | same bonus curve as `nascar.drafting.tuck-in.v1` applied lane-wise (maxBonusKph 9, decays to 0 at 8 lengths) |
| dp_lane | `DecisionPoint` | input | TimeLimit from difficulty; slows to 0.25x via `SlowMotion.RampTo` |
| momentum_arrows | `Highlight` (Gold) | overlay | one arrow per lane, length = momentum score; shown only in Explain or as a Hint |
| spotter_card | `Explanation` callout | overlay | text such as "Clear high, stay high!"; appears in wreck scenarios |
| wreck_event | `Vehicle` + `Path` scripted spin | event | 2-4 cars follow a scripted spin path into the wall/apron; no debris physics beyond a simple slide |
| replay | `Replay` | review | records the 5 s execute for slow-mo at 0.25x from `top-down` |

**Reused primitives:** `Vehicle`, `Track`, `Draft`, `Zone`, `Target`, `DecisionPoint`, `SlowMotion`, `Highlight`, `Explanation`, `Score`, `Replay`, `CameraRig`, `Hint`, `Rng`.

**New / extended primitives:** Environment key `oval_superspeedway`; scripted `Vehicle` spin path (uses existing `Path` and `Character`-style animation states; no new primitive).

```
  high  |  [21]         [44]
  mid   |     [12 YOU]  [7]  [88]
  low   |  [33] [5] [16]   [9]
        +-----------------------------> direction of travel
  "Which lane has the run?"   tap a lane band
  low: 3 cars nose-to-tail + 1 behind  ->  momentum arrow long
```

## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Choose lane | Tap a lane band (full-height, three across) | >= 88 x 300 pt each | Band fills rose; car moves; soft haptic tick |
| Swipe alternative | Swipe left/right to move one lane | any area | Same as tapping the adjacent band |
| Hint | Tap Hint pill (lower left) | 44 pt tall | Shows the momentum arrows for 3 s (counts as a hint) |
| Pause | Top-right icon | 44 x 44 pt | Requests pause from native |

- **Accessible tap-only scheme (`ControlScheme.TapOnly`):** Three pill buttons at the bottom (`Low`, `Mid`, `High`, 56 pt high, labeled with a shape glyph per lane) replace swipe and band taps. The decision time limit is doubled in this scheme.
- **Safe area & orientation:** portrait. All controls sit inside `runtime.safeAreaInsets` plus 16 pt; the bottom 88 pt is reserved for the primary control so it never collides with the home indicator.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation, XP totals, streaks and lesson navigation (native). Unity draws only the in-scene HUD and overlays.

## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit / bridge events |
|---|---|---|---|
| Loading | `launch` received and validated | Build world from code, load scenario set, verify `configuration`; on failure emit `error CONFIG_INVALID` / `ASSET_LOAD_FAILED` | World ready -> emit `ready` -> Intro |
| Intro | After `ready` | `broadcast-side`; banner "Pack racing 101"; pack rolls at 1x for 3 s so the learner sees three lanes | Tap Start (or auto after 6 s) -> Playing |
| Playing | Round begins | Pack runs at 1x; spotter card appears in wreck scenarios; countdown to the decision trigger (scenario `decideAtSeconds`) | Decision trigger -> Decision; time limit -> Freeze (timeout outcome). Emits `progress` (max 4/s) |
| Decision | Decision trigger reached | `top-down`, `SlowMotion` 0.25x; lane bands active; timer ring shown when a limit exists | Choice made or time limit -> Executing. Emits `checkpoint` `round-<n>-decision` |
| Executing | Choice locked | 5 s of pack motion driven by the lane-momentum model; player moves into the chosen lane; events (block, wreck) fire at their `atSeconds` | Outcome resolved -> Freeze |
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
| Cars in pack | 6 | 8 | 10 | 12 | 14 |
| Lanes in play | 2 (low, high) | 3 | 3 | 3 | 3 |
| Decision time limit (s) | none | none | 8 | 6 | 4 |
| Decisions per round | 1 | 1 | 1 | 2 | 2 |
| Hints (`Hint` uses) | unlimited | 3 | 2 | 1 | 0 |
| Momentum arrows visible during Decision | on | on (fade 50%) | off | off | off |
| Events per round | none | block or wreck | block or wreck | block and wreck | block and wreck + shift |
| Scenario pool tags | ss-01, ss-02 | ss-01..ss-04 | ss-01..ss-06 | ss-03..ss-08 | ss-05..ss-09 |
| Spotter card | always | always | on wreck only | on wreck only | delayed 0.5 s |

**Default level for lesson `tracks-09`: 2.** Level 1 is passable by a true beginner using hints alone. Level 1 uses two lanes only so the concept is one binary read.

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
        "nascar-superspeedway-run-core-1"
      ],
      "default": "nascar-superspeedway-run-core-1"
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
    "controlScheme": {
      "type": "string",
      "enum": [
        "swipe-tap",
        "tap-only"
      ],
      "default": "swipe-tap"
    },
    "showSpotterCard": {
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
  "seed": 1187,
  "scenarioSetId": "nascar-superspeedway-run-core-1",
  "roundCount": 3,
  "controlScheme": "swipe-tap",
  "showSpotterCard": true
}
```

## 11. Scenario data set
Set `nascar-superspeedway-run-core-1`: **9 scenarios**, file `scenarios/nascar-superspeedway-run-core-1.json`. Lane model: `M(lane) = sum over cars ahead in that lane (max 5) of 1/(1 + 0.5 x gapLengths) + 0.6 x (number of cars within 2.0 lengths behind, max 2) - 1.5 if the lane's front car has a `defend` event before t=3 s`. Best lane = argmax M. A lane with M >= 0.75 x best is *acceptable*. Wreck scenarios instead define `wreckLanes` and a spotter call; the correct lane is the one not in `wreckLanes` closest to the player. Deterministic per seed.

| scenarioId | setup | correct decision | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| ss-01 | Final-lap run, kind run: low 3-car line + car behind, mid lone car, high 2 cars | Go low (M 2.11 vs 1.50 vs 0.36) | lane-choice | L1-3 |
| ss-02 | Block trap, kind block: low has the longest line but its front car defends at t=2 s | Go mid (1.49) not low (1.03) | blocking | L2-4 |
| ss-03 | Wreck ahead in low/mid at t=1.5 s, spotter "Wreck ahead, stay high!" | Go high, keep throttle steady | the-big-one | L1-5 |
| ss-04 | Tandem finish, kind run: you and a partner are one line; two laps to go | Stay in the partner's line (push) until the last lap | the-run | L2-4 |
| ss-05 | Three-wide squeeze: mid lane crowded (4 cars within 1 length), low and high clear | Move to the lane with the longer line, not the empty one | pack-racing | L3-5 |
| ss-06 | Momentum shift at t=3 s: high line breaks up, low line forms | Wait at mid then commit low after the shift (2 decisions) | lane-choice | L4-5 |
| ss-07 | Wreck low, spotter "Clear high, clear high, wreck low!" with a delayed card at L5 | Go high | spotter-talk | L3-5 |
| ss-08 | You are the leader with a run coming from behind in high | Block once early or ride: accept the run and stay low (model chooses) | blocking | L4-5 |
| ss-09 | Finale: run then block then wreck at t=4 s | Sequence of lane choices per decision points | the-big-one | L5 |

**Fully written scenarios:**

**ss-01 (kind run):** `decideAtSeconds` 2; laps-to-go banner "1 to go". Lanes: low ahead gaps [1.0, 2.2, 3.4], behind [1.4]; mid ahead [3.5], behind []; high ahead [2.0, 3.0], behind [1.8]. M(low) = 0.667 + 0.476 + 0.370 + 0.6 = 2.11; M(mid) = 0.364; M(high) = 0.5 + 0.4 + 0.6 = 1.50. Best = low; high is poor (1.50 < 0.75 x 2.11 = 1.58, just below the acceptable line); mid is poor. Correct: low. The player starts mid, a lane away.

**ss-02 (kind block):** low ahead [1.0, 1.8, 2.9, 4.0] behind [1.1], front car event `defend` at t=2.0 (moves into mid). M(low) = 0.667+0.526+0.408+0.333+0.6-1.5 = 1.03. Mid ahead [2.0, 3.2] behind [1.5]: 0.5+0.385+0.6 = 1.485. High ahead [4.5], behind []: 0.308. Best = mid; low is poor because its front car breaks the line. Player starts high. Explain highlights the defending car with a rose outline.

**ss-03 (kind wreck):** pack of 10; at t=1.5 s two cars in low and mid spin (scripted). Spotter card at t=0.5 s: "Wreck ahead, stay high, stay high!". `wreckLanes` [low, mid]; the player starts mid. Correct: high (best); staying mid is poor; low is poor. Tie-break: if the player was already high, correct action is "hold lane" (Decision auto-resolves; the round teaches reading the call).

Remaining scenarios use the shared JSON shape `{scenarioId, kind, lanes:{low|mid|high:{ahead[], behind[], event?}}, wreckLanes?, spotterCall?, decideAtSeconds, decisions:[{atSeconds}], conceptId, tags}`. ss-04 uses a `partner` flag: leaving the partner's line costs M by 1.0; on the final lap `lapsToGo:0` the correct action flips to "split and go". ss-06 has a `shiftAtSeconds` that swaps the lane models.

## 12. Freeze / explain moments
Copy limits enforced by review: Title <= 6 words, body <= 45 words. Voice: cheeky coach, warm, a little flirty, never condescending; the learner is doing this for someone they care about.

### Explain 1: The lane with the run
- **Trigger:** Execute ends (5 s)
- **What freezes:** Pack at the decision outcome; lane momentum arrows appear
- **Camera:** `top-down` freeze then `broadcast-side` replay at 0.25x
- **Callouts:** Gold arrow per lane sized by momentum; the longest gold arrow labeled "THE RUN"; rose outline on the learner's lane if different
- **Correct outcome copy**
  - Title: Nice read. That lane had it.
  - Body: A long line of cars nose-to-tail drags each other faster, and a car pushing from behind adds more. The lane with the most cars stacked up is moving fastest.
  - Say this: "The middle lane had all the momentum."
- **Incorrect outcome copy**
  - Title: Not quite. Empty is slow.
  - Body: An empty lane feels open but has no draft to ride. Speed at a superspeedway comes from other cars, so a longer, tighter line usually wins.
  - Say this: "The lane with the line of cars had the run."

### Explain 2: The block
- **Trigger:** A `defend` event breaks the chosen lane's front car
- **What freezes:** Blocker and the learner car
- **Camera:** `chase-high` then `top-down`
- **Callouts:** Rose outline on the blocker; dotted gold path showing where the run would have gone
- **Correct outcome copy**
  - Title: Nice read. You saw the block.
  - Body: The car in front moved over to shut your lane. When a defender leaves the line, the run dies behind him. Reading that early keeps your speed.
  - Say this: "He saw the block coming and switched lanes."
- **Incorrect outcome copy**
  - Title: Not quite. Watch the leader.
  - Body: The lane looked strong but its front car moved across to block. A block breaks the draft for everyone stacked behind it. Watch what the lead car is doing.
  - Say this: "He got blocked and lost the run."

### Explain 3: The wreck ahead
- **Trigger:** Wreck event resolves
- **What freezes:** Spinning cars and the open lane
- **Camera:** `top-down`
- **Callouts:** Gold path through the open lane; rose bands on the wreck lanes; spotter card re-shown
- **Correct outcome copy**
  - Title: Nice read. Spotter saved you.
  - Body: Spotters see the whole pack from above. When one says stay high, the open space is high. Steady throttle and a clear head get you through the mess.
  - Say this: "The spotter had him go high and he made it through."
- **Incorrect outcome copy**
  - Title: Not quite. Trust the spotter.
  - Body: Wrecks spread fast at superspeedways, and a spinning car can hit anyone nearby. The spotter tells you where the space is. Listen, then move early and smoothly.
  - Say this: "He drove right into the Big One."

### Explain 4: Tandem finish
- **Trigger:** Last-lap decision resolves in scenario ss-04
- **What freezes:** Partner cars in line
- **Camera:** `broadcast-side`
- **Callouts:** Gold link between the two cars; rose label "PUSH"; the split moment marked
- **Correct outcome copy**
  - Title: Nice read. Stay together, then split.
  - Body: Two cars working together are faster than either alone. Push your partner until the final lap, then split and go for the win yourself.
  - Say this: "They worked together until the last lap."
- **Incorrect outcome copy**
  - Title: Not quite. Timing matters.
  - Body: Split too early and you both slow down. Stay too long and you never get a shot at the win. Stay tied together until the last lap, then choose your moment.
  - Say this: "He split from his partner too soon."


## 13. Scoring & mastery signals
**Score (0-100):** mean of round scores. Round score = 100 if the chosen lane is best; 60 if acceptable; 0 otherwise. Wreck rounds: 100 if the chosen or held lane is outside `wreckLanes`, 0 otherwise; -20 if the learner used the Hint. Rounds with 2 decisions average their decisions. **Accuracy** = rounds with score >= 60 / rounds played. **Outcome ids:** `lane-run`, `lane-block`, `lane-wreck`, `lane-tandem`, `lane-shift`.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text |
|---|---|---|
| Chose the empty lane in a run scenario | lane-choice | Picked an empty lane with no draft |
| Chose the lane whose front car defended | blocking | Missed that a block would break the run |
| Stayed in a wreck lane after a spotter call | the-big-one | Ignored a wreck warning |
| Split from the partner too early / too late (ss-04) | the-run | Mistimed the tandem split |
| Wrong side to a spotter call ("stay high" -> low) | spotter-talk | Misread the spotter's direction |
| Chose a crowded lane in ss-05 | pack-racing | Ignored the crowd in the lane |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; native applies its own +0.20/-0.15 exercise scale separately and halves gain when hints were used)

| event | conceptId | delta | evidence text |
|---|---|---|---|
| `lane-run` success | lane-choice | +0.15 | Chose the lane with the momentum |
| `lane-run` success | the-run | +0.10 | Explained the run by lane length |
| `lane-block` success | blocking | +0.15 | Saw the block early |
| `lane-wreck` success | the-big-one | +0.20 | Went to the open lane |
| `lane-wreck` success | spotter-talk | +0.15 | Followed the call |
| `lane-tandem` success | pack-racing | +0.10 | Kept the tandem together |
| Failed round | lane-choice | -0.10 | Missed the lane read |
| Failed `lane-wreck` round | the-big-one | -0.15 | Stayed in the danger lane |

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

Failure always ends in an Explain moment, never a dead end. If the learner fails the wreck round the Explain uses a calm tone and the freeze shows the safe path first; never dwell on the crash.

## 16. Accessibility
- **Reduced motion:** hard cuts instead of camera sweeps and dolly; no screen shake; freeze is instant; pulsing rings become static rings; overlay animations off.
- **Haptics off:** every haptic cue in section 17 has a visual and (if sound is on) audio equivalent.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): every color meaning has a second channel: shape and pattern (striped fill = wrong, dotted ring = correct, solid ring = selected) and car numbers on every vehicle. Lanes have distinct patterns (solid, diagonal stripes, dots) as well as tint; wreck lanes get an X pattern.
- **Text scale:** overlay text scales with `textScale` 0.8-3.0; callout cards reflow and scroll if needed; body >= 13 pt at scale 1.
- **Tap-only alternative:** see section 7.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson provided: ``tracks-08` (native `term-match` and `binary-call` on bump-draft, side-draft and the Big One) plus `insd-01` spotter calls (`listening-id`)` (a designed native exercise on the same concepts, not a port of this sim).

## 17. Audio & haptics

| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Round start | Soft engine idle swell (0.5 s) | Soft tap | -18 dB |
| Correct outcome | Warm two-note chime | Light success | -12 dB |
| Incorrect outcome | Low single tone | Warning | -12 dB |
| Freeze | Low-pass filter over ambient, 250 ms | Soft tap | -15 dB |
| Callout appears | Short paper tick | None | -20 dB |
| Summary numerals | Soft tick per 10 points | None | -22 dB |
| Wreck event | Low thud (no crash sample), muffled | Warning (light) | -16 dB |
| Spotter card | Radio blip (synthesized) | None | -18 dB |

All cues honor `soundEnabled` and `hapticsEnabled`. No music. Engine ambience is synthesized (procedural), never a licensed recording.

## 18. Art & asset list

| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| stock-car-lowpoly (x14 LOD1) | procedural | original-swoond | ~1.2k tris each | fictional numbers; number decal atlas 512 px |
| oval_superspeedway | procedural | original | ~10k tris | three painted lane bands, tri-oval kink |
| Lane bands and momentum arrows | procedural UI meshes | original | few materials | color + pattern |
| Wreck spin animation | scripted `Path` | original | no assets | no debris beyond 6 small quads |
| Sound cues | synthesized | original-swoond | < 0.8 MB total |  |

Addressables bundle: `sim-nascar-drafting-superspeedway-run-v1` (expected size <= 8 MB compressed). Overlay styling per `docs/astra/ART_DIRECTION.md` sections 4-5. Vehicle liveries are fictional (no real team paint schemes, sponsors or logos); car numbers are generic.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps sustained on iPhone 13-class (5th percentile >= 50 fps), < 150 MB peak resident memory, cold launch < 2 s to `ready`, bundle <= 25 MB, <= 150 draw calls, <= 60k triangles on screen, <= 15 materials, textures <= 8 MB VRAM, audio <= 3 MB. **Tighter per-sim limits:** <= 15 vehicles on screen at LOD1 (1.2k tris); replay buffer <= 14 MB; slow-mo must not change the fixed timestep determinism.

## 20. Telemetry
Diagnostics only, in `result.telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters `hintsUsed`, `decisionLatencyMs`, `decisionsMade`, `wreckRoundsPassed`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** ss-01: model output M(low)=2.11, M(mid)=0.36, M(high)=1.50 (+/-0.01) and best lane low.
2. **AC-2:** ss-02: the block rule makes low M=1.03 and mid best (1.49).
3. **AC-3:** ss-03: wreck lanes low/mid produce correct lane high; holding lane when already high resolves without a Decision UI.
4. **AC-4:** Decision slows time to 0.25x within 250 ms (hard cut under reduced motion) and restores 1x after execute.
5. **AC-5:** At difficulty 1 only two lane bands are selectable.
6. **AC-6:** Tap-only scheme doubles the decision time limit and exposes Low/Mid/High buttons.
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
- **EditMode:** Lane-momentum model (all 9 scenarios), block/wreck resolution, spotter-call parsing, score maths, config validation, determinism by seed, result schema.
- **PlayMode:** Scene build; scripted full run at levels 1, 3, 5; wreck scripted spin; slow-mo; freeze/explain; pause/resume/abort; tap-only; reduced motion; color-blind pattern screenshots.
- **Perf:** 3 consecutive full runs at difficulty 5 on an iPhone 13-class device; record fps, memory, thermal state (must not exceed "fair").

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | LaneModel_ss01 |
| AC-2 | EditMode | LaneModel_Block |
| AC-3 | PlayMode | Wreck_HighLane |
| AC-4 | PlayMode | Decision_SlowMotion |
| AC-5 | PlayMode | Difficulty1_TwoLanes |
| AC-6 | PlayMode | TapOnly_Buttons |
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
| 1 | Confirm the lane-momentum model constants (0.5, 0.6, -1.5) are acceptable arcade tuning; SME check that stylized behavior matches broadcast intuition. | Astra / Product | No |
| 2 | Should wreck scenes depict any contact, or only avoidance? Proposal: avoidance only, cars slide clear. | Product | No |
| 3 | Environment `oval_superspeedway` lane widths and camera framing need Astra proposal. | Astra | No |

## Game Kit additions requested
- Environment key `oval_superspeedway`.
- A `LaneMomentum` helper on `Draft` (pure function used for scoring and Hint arrows); reusable for cycling pelotons and F1 tows.
