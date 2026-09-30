# The Restart (`nascar.restart.choose-lane.v1`)

## 1. Identity & versioning

| Field | Value |
|---|---|
| simulationId | `nascar.restart.choose-lane.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (data-driven: definition file `nascar.restart.choose-lane.v1.definition.json` composed from Game Kit primitives) |
| Authors / date | Swoon'd curriculum design (Claude) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `nascar`; `unitId`: `racecraft`; `lessonId`: `craft-02` (also usable as a review activity from `perpetual-review`).
- CDS row: `docs/courses/nascar/CDS.md` section 12, row "Restart lane and jump (sim)".
- Manifest entry: `docs/courses/nascar/manifest.json` -> `unitySimulations[]` (simulationId `nascar.restart.choose-lane.v1`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `restart`, `choose-rule`, `passing-lines`; primer on the restart zone shown if `restart` is not yet mastered.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can read a restart, choose the inside or outside lane the way a driver would at the choose line, and say why.

| conceptId | term | After the sim the learner can... |
|---|---|---|
| choose-rule | Choose rule | Explain that drivers pick inside or outside in running order at the choose line, and that the choice is strategic. |
| restart-strategy | Restart strategy | Weigh lane bias, line length and a teammate's push to decide where to restart, and time the jump. |
| restart | Restart | Describe how a restart works and why the cars in the front rows are so keyed up. |
| lane-choice | Lane choice | Choose the lane that gains the most, not the one that sounds most popular. |
| racing-groove | Groove (racing line) | Connect lane advantage to rubber and banking. |
| road-course-racecraft | Road course racecraft | See that on a road course the inside lane tends to get the shorter line into the first braking zone. |

**Out of scope:** Restart-zone rulebook nuances, caution-count rules, penalties beyond the simple jump violation and any specific track's real lane bias claims. Lane biases are stylized scenario data; real bias changes by track, tires and race.

## 4. Why Unity (tier justification)
**Rubric answer.** Reading a dynamic scene: the two-wide field rolls, cars ahead have already picked lanes, the choose line (orange V) is coming up, and the outcome depends on relative positions and timing at speed. Movement over time in space and a behind-the-car camera materially help: the learner sees stacks form and fan out, and feels the jump.

**Closest native type and why it teaches worse:** `binary-call` (inside or outside) with a static diagram could pose the choice and is used natively in `flow-05`. It cannot show how the lane lines actually build, how a teammate pushes, or why the shorter line gets a higher row. The jump timing is a short 1D cue, so at difficulty 1-2 the jump is automatic; the value is the scene. Justification is moderate: if capacity is limited, `rs-01..rs-09` can be re-authored as native `binary-call` items with static diagrams (documented fallback).

## 5. Player fantasy & core loop
**Fantasy:** You are the driver on a restart with the field two-wide behind you and about five seconds to pick your lane.

1. **Prompt:** banner "Restart. Pick your lane at the V."
2. **One decisive interaction:** tap Inside or Outside before crossing the choose line (levels 3+ also require a jump tap when the car ahead goes).
3. **Execute:** the field restarts; your lane forms; the sim projects your position after a 6-second fast run.
4. **Freeze / explain:** freeze on the order after the first turn; callouts show lane stacks, momentum arrows and the jump; **a line you could say out loud:** "He chose the outside and got a great push."
5. **Repeat** for each round.

**Session length:** about 3 minutes, 3 rounds (default). Maximum 240 s of play; `runtime.maxDurationMs` from native is authoritative.

## 6. Scene & entities
- **Environment (registry key):** `oval_intermediate` (short-track and road-course variants use `oval_short` and `road_course_short`; registry keys requested)
- **Camera presets:** `chase-high` (default, behind the player), `top-down` at the choose line and in Freeze, `broadcast-side` for the replay at 0.5x. Reduced motion: cuts only.

| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| player_car | `Vehicle` | player | slot from scenario (5th-8th in running order); rose ring; number 12 |
| field_01..11 | `Vehicle` (LOD1) | opponents | two-wide double-file order; numbers 1-99; already-committed lane per scenario `ahead` |
| pace_car | `Vehicle` | event | peels off at the restart zone; hidden after |
| choose_line | `Zone` (orange V graphic) | world | painted V; crossing it without a choice = tail penalty |
| lane_inside, lane_outside | `Zone` + `Target` x2 | selectable | full-height translucent bands; label "INSIDE" / "OUTSIDE"; stack counters shown as chips |
| restart_zone | `Zone` | world | the box in which the leader may accelerate; go cue: leader's brake lights out and gap opening |
| teammate | `Vehicle` + `Highlight` | event | optional car with a halo; will follow the player's lane |
| jump_ring | `Timing` + `Target` | input (levels 3+) | ring that fills when the car ahead accelerates; tap Go inside window |
| momentum_arrows | `Highlight` (Gold) | overlay | lane arrows in Explain; shown during Decision as a Hint |
| replay | `Replay` | review | records the first 6 s after the restart |

**Reused primitives:** `Vehicle`, `Track`, `Zone`, `Target`, `DecisionPoint`, `Timing`, `Position`, `Highlight`, `Explanation`, `Score`, `Replay`, `SlowMotion`, `CameraRig`, `Hint`, `TouchController`.

**New / extended primitives:** None. Environment keys `oval_short` and `road_course_short` requested; a `RestartFormation` helper (double-file grid from a list) is sim-local.

```
   pace car peels off                  choose line (orange V)
   [ 3 ] [ 2 ]  <- cars already in lane     [V]
   inside lane:  [1][3][5][7]*  <- you (slot 7)
   outside lane: [2][4][6]        (shorter line = higher row)
   [ INSIDE ]                      [ OUTSIDE ]   <- tap a band
   (L3+)  ( GO )  tap when the car ahead accelerates
```

## 7. Controls (touch)

| Input | Gesture / target | Hit size | Feedback |
|---|---|---|---|
| Choose lane | Tap the Inside or Outside band (each half of the screen) | >= 160 x 300 pt | Band fills rose; car swings; soft haptic tick |
| Jump (L3+) | Tap the GO ring (bottom center) | 72 pt circle | Ring flashes gold in window, rose if early/late |
| Hint | Tap Hint pill | 44 pt tall | Shows lane momentum arrows for 3 s (counts as a hint) |
| Pause | Top-right icon | 44 x 44 pt | Requests pause from native |

- **Accessible tap-only scheme (`ControlScheme.TapOnly`):** Inside and Outside become two 56 pt pill buttons at the bottom (the band tap remains available). The jump is automatic in tap-only mode at all levels (score capped at 90 for that scheme's jump component, documented in native as an accessibility credit so mastery is not penalized).
- **Safe area & orientation:** portrait. All controls sit inside `runtime.safeAreaInsets` plus 16 pt; the bottom 88 pt is reserved for the primary control so it never collides with the home indicator.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation, XP totals, streaks and lesson navigation (native). Unity draws only the in-scene HUD and overlays.

## 8. Step-by-step flow with states

| State | Entry condition | What happens | Exit / bridge events |
|---|---|---|---|
| Loading | `launch` received and validated | Build world from code, load scenario set, verify `configuration`; on failure emit `error CONFIG_INVALID` / `ASSET_LOAD_FAILED` | World ready -> emit `ready` -> Intro |
| Intro | After `ready` | `chase-high`; banner "Field is rolling. Watch the lanes form."; cars fill lanes for 3 s | Tap Start (or auto after 6 s) -> Playing |
| Playing | Round begins | Cars roll under caution at 45 mph; commitments appear as chips above cars; V approaches; countdown ring appears at L4-5 | Decision trigger -> Decision; time limit -> Freeze (timeout outcome). Emits `progress` (max 4/s) |
| Decision | Decision trigger reached | Time at 0.25x with lanes highlighted; timer ring if limited | Choice made or time limit -> Executing. Emits `checkpoint` `round-<n>-decision` |
| Executing | Choice locked | Player joins the lane; pace car leaves; at levels 3+ the learner taps GO; the field restarts and runs 6 s; the model applies lane gain and jump result | Outcome resolved -> Freeze |
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
| Cars in field | 6 | 8 | 10 | 12 | 12 |
| Lane bias hint visible (arrows) | always | on request | on request | no | no |
| Decision time limit (s) | none | none | 10 | 7 | 5 |
| Jump input | auto | auto | tap, window 0.30 s | tap, window 0.20 s | tap, window 0.12 s |
| Hints (`Hint` uses) | unlimited | 3 | 2 | 1 | 0 |
| Teammate push scenarios | no | yes | yes | yes | yes |
| Scenario pool tags | rs-01, rs-02 | rs-01..rs-04 | rs-01..rs-07 | rs-03..rs-09 | rs-04..rs-09 |

**Default level for lesson `craft-02`: 2.** Level 1 is passable by a true beginner using hints alone. Jump model: go cue time t0 is scenario data (default 1.8 s after the restart zone entry). A tap before t0 - 0.05 s is a jump violation; within [t0, t0 + window] is a perfect jump (+1 spot); later is -1 spot.

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
        "nascar-restart-core-1"
      ],
      "default": "nascar-restart-core-1"
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
    "autoJump": {
      "type": "boolean",
      "default": false,
      "description": "Force automatic jump (tap-only accessibility)."
    },
    "showLaneBias": {
      "type": "boolean",
      "default": false
    }
  },
  "additionalProperties": false
}
```

Valid example:

```json
{
  "seed": 99,
  "scenarioSetId": "nascar-restart-core-1",
  "roundCount": 3,
  "autoJump": false,
  "showLaneBias": false
}
```

## 11. Scenario data set
Set `nascar-restart-core-1`: **9 scenarios**, file `scenarios/nascar-restart-core-1.json`. **Lane model (deterministic):** start slot = 2 x (cars already in that lane) + (1 inside, 2 outside). Lane score S = laneBias + 0.4 if a teammate is directly behind (push). Spots gained = round-half-away-from-zero(3 x S). Projected finish = max(1, slot - gained). Verdict: best = lowest projected finish (ties are both best); acceptable = within +1; poor otherwise. Jump (levels 3+): perfect = -1 to the projected finish (min 1); late = +1; violation = +6 and a `restart-violation` mistake.

| scenarioId | setup | best lane (projected finish) | teaches conceptId | difficulty tags |
|---|---|---|---|---|
| rs-01 | Outside is the fast lane: Kansas-like intermediate; cars already in line: inside 3, outside 2; lane bias inside -0.1 / outside +0.3 | outside (inside finish P7, outside finish P5) | restart-strategy | L1-3 |
| rs-02 | Inside at the paperclip: Martinsville-like short flat track; cars already in line: inside 2, outside 3; lane bias inside +0.3 / outside -0.2 | inside (inside finish P4, outside finish P9) | choose-rule | L1-3 |
| rs-03 | Shorter line, higher row: Las Vegas-like intermediate; cars already in line: inside 4, outside 2; lane bias inside +0.0 / outside +0.0 | outside (inside finish P9, outside finish P6) | choose-rule | L2-4 |
| rs-04 | Teammate behind you: Kansas-like intermediate; cars already in line: inside 3, outside 3; lane bias inside -0.2 / outside +0.2; teammate directly behind (push) | inside or outside (inside finish P6, outside finish P6) | restart-strategy | L2-4 |
| rs-05 | Bias vs rows: Bristol-like high-banked short track; cars already in line: inside 2, outside 4; lane bias inside +0.1 / outside +0.4 | inside (inside finish P5, outside finish P9) | lane-choice | L3-5 |
| rs-06 | Rubber built up high: Darlington-like egg-shaped oval, lap 250 of 293; cars already in line: inside 3, outside 3; lane bias inside -0.3 / outside +0.3 | outside (inside finish P8, outside finish P7) | racing-groove | L3-5 |
| rs-07 | Road course restart: Road course (Roval-like) restart zone before turn 1; cars already in line: inside 2, outside 2; lane bias inside +0.4 / outside -0.3 | inside (inside finish P4, outside finish P7) | road-course-racecraft | L2-5 |
| rs-08 | Long inside line, push on outside: Kansas-like intermediate; cars already in line: inside 1, outside 4; lane bias inside +0.0 / outside +0.2; teammate directly behind (push) | inside (inside finish P2, outside finish P8) | restart-strategy | L4-5 |
| rs-09 | Overtime restart, everybody wants the outside: Las Vegas-like intermediate, green-white-checkered; cars already in line: inside 2, outside 5; lane bias inside +0.1 / outside +0.3 | inside (inside finish P5, outside finish P11) | choose-rule | L4-5 |

**Fully written scenarios:**

**rs-01 (Outside is the fast lane):** Kansas-like intermediate. Outside stack builds a tight momentum line here. Lanes ahead of you: inside 3, outside 2. Choosing inside: start slot 7 (= 2 x 3 + 1), lane score -0.1, gain +0 spots, projected P7 (poor). Choosing outside: start slot 6 (= 2 x 2 + 2), lane score +0.3, gain +1 spots, projected P5 (best).

**rs-02 (Inside at the paperclip):** Martinsville-like short flat track. Inside lane is the short way around and gets the momentum out of the corner. Lanes ahead of you: inside 2, outside 3. Choosing inside: start slot 5 (= 2 x 2 + 1), lane score +0.3, gain +1 spots, projected P4 (best). Choosing outside: start slot 8 (= 2 x 3 + 2), lane score -0.2, gain -1 spots, projected P9 (poor).

**rs-03 (Shorter line, higher row):** Las Vegas-like intermediate. Lanes are equal: rows decide. Lanes ahead of you: inside 4, outside 2. Choosing inside: start slot 9 (= 2 x 4 + 1), lane score +0.0, gain +0 spots, projected P9 (poor). Choosing outside: start slot 6 (= 2 x 2 + 2), lane score +0.0, gain +0 spots, projected P6 (best).

Other scenarios use `{scenarioId, track, environment, ahead:{inside,outside}, bias:{inside,outside}, push, goCueSeconds, conceptId, tags}`; `correct` is derived at load time and asserted. Values above are stylized; a subject-matter check is open (section 23).

## 12. Freeze / explain moments
Copy limits enforced by review: Title <= 6 words, body <= 45 words. Voice: cheeky coach, warm, a little flirty, never condescending; the learner is doing this for someone they care about.

### Explain 1: Lane bias
- **Trigger:** Projection ends in a bias-driven scenario (rs-01, rs-02, rs-06, rs-07)
- **What freezes:** Order after the first turn with lane arrows
- **Camera:** `top-down` then `broadcast-side`
- **Callouts:** Gold arrow along the faster lane; rose ring on your car; stack counters above each lane
- **Correct outcome copy**
  - Title: Nice read. Right lane.
  - Body: At this track the lane you choose carries more speed off the restart. Tire rubber, banking and line length change which side has the edge. Drivers know their lane.
  - Say this: "He chose the outside and got a great push."
- **Incorrect outcome copy**
  - Title: Not quite. Wrong side.
  - Body: That lane was slower coming off the line here. The other side gets better grip or momentum. Look at the lane arrows next time, then choose.
  - Say this: "He picked the slow lane on the restart."

### Explain 2: Shorter line, higher row
- **Trigger:** Projection ends in a rows-driven scenario (rs-03, rs-05, rs-08, rs-09)
- **What freezes:** Two lane stacks with slot numbers
- **Camera:** `top-down`
- **Callouts:** Slot numbers on each lane; gold bracket on the shorter line; rose ring on your slot
- **Correct outcome copy**
  - Title: Nice read. Rows count.
  - Body: Joining the shorter line puts you in a higher row. Fewer cars ahead means a better starting spot. Sometimes the less popular lane is the smart one.
  - Say this: "He picked the empty lane to gain a row."
- **Incorrect outcome copy**
  - Title: Not quite. Long line.
  - Body: That line had more cars ahead, so you started further back. Count the cars in each lane before you choose. A shorter line can beat a better lane.
  - Say this: "He joined the long line and lost spots."

### Explain 3: The push
- **Trigger:** A teammate scenario resolves (rs-04, rs-08)
- **What freezes:** Player and teammate in line
- **Camera:** `chase-high`
- **Callouts:** Gold link between the cars; rose label "PUSH"; gain arrow +1 or +2
- **Correct outcome copy**
  - Title: Nice read. Teammate power.
  - Body: A teammate right behind you will follow and push. That bump helps both cars gain spots off the restart. Teams plan restarts together.
  - Say this: "His teammate pushed him on the restart."
- **Incorrect outcome copy**
  - Title: Not quite. Forget the push.
  - Body: You ignored the teammate behind you and picked the lane for your own reasons. A push adds momentum, so it can beat a slightly better lane.
  - Say this: "He forgot he had a teammate behind him."

### Explain 4: The jump
- **Trigger:** Jump tap resolved (levels 3+)
- **What freezes:** Player car at the restart zone with the ring
- **Camera:** `chase-high` close
- **Callouts:** Gold ring window; rose tick at your tap; label "GO CUE" at t0
- **Correct outcome copy**
  - Title: Nice read. Clean jump.
  - Body: You went when the car ahead did, no earlier. That gets you a little extra speed at the line without breaking the rules. Timing is everything on a restart.
  - Say this: "He got a great jump on the restart."
- **Incorrect outcome copy**
  - Title: Not quite. Timing.
  - Body: Go before the car ahead and you risk a restart penalty. Go late and you lose a spot. Watch the car ahead, then go when it goes.
  - Say this: "He got caught jumping the restart."


## 13. Scoring & mastery signals
**Score (0-100):** mean of round scores. Round score = lane score (100 best, 60 acceptable, 0 poor) adjusted by jump at levels 3+: perfect jump +0 (already in the projection), late -20, violation -40 (min 0); -5 per Hint used. At levels 1-2 the jump is automatic. **Accuracy** = rounds with score >= 60 / rounds. **Outcome ids:** `lane-bias`, `lane-rows`, `lane-push`, `restart-jump`.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text |
|---|---|---|
| Picked the lane with the worse bias (rs-01, rs-02, rs-06, rs-07) | restart-strategy | Ignored which lane carries more speed |
| Picked the longer line when lanes were equal (rs-03) | choose-rule | Ignored the number of cars in each lane |
| Ignored teammate push (rs-04, rs-08) | restart-strategy | Forgot a teammate behind |
| Tapped GO before the cue (violation) | restart | Jumped the restart |
| Tapped GO after the window | restart | Missed the jump |
| Failed to choose before the V (timeout) | choose-rule | Did not choose a lane at the choose line |

**Mastery signals** (per-session cap: +0.30 and -0.20 per concept; native applies its own +0.20/-0.15 exercise scale separately and halves gain when hints were used)

| event | conceptId | delta | evidence text |
|---|---|---|---|
| `lane-bias` success | restart-strategy | +0.15 | Chose the faster lane |
| `lane-bias` success | racing-groove | +0.10 | Connected lane advantage to grip |
| `lane-rows` success | choose-rule | +0.20 | Chose the shorter line |
| `lane-push` success | restart-strategy | +0.15 | Used the teammate's push |
| `restart-jump` perfect | restart | +0.15 | Went with the car ahead |
| Road course scenario (rs-07) success | road-course-racecraft | +0.20 | Chose the inside line into turn 1 |
| Restart violation | restart | -0.15 | Jumped the restart |
| Failed lane round | lane-choice | -0.10 | Wrong lane |

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

Failure always ends in an Explain moment, never a dead end. A violation shows the calm line "Jump early and they send you to the back." and never dwells on the mistake.

## 16. Accessibility
- **Reduced motion:** hard cuts instead of camera sweeps and dolly; no screen shake; freeze is instant; pulsing rings become static rings; overlay animations off.
- **Haptics off:** every haptic cue in section 17 has a visual and (if sound is on) audio equivalent.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): every color meaning has a second channel: shape and pattern (striped fill = wrong, dotted ring = correct, solid ring = selected) and car numbers on every vehicle. Lane bands use different textures (dots inside, diagonal outside); teammate halo is a ring plus a chevron.
- **Text scale:** overlay text scales with `textScale` 0.8-3.0; callout cards reflow and scroll if needed; body >= 13 pt at scale 1.
- **Tap-only alternative:** see section 7.
- **VoiceOver / TalkBack:** Unity content is not fully screen-reader accessible. Native fallback lesson provided: ``flow-05` native set (`multiple-choice` + `hotspot-tap` on the choose rule with static diagrams), plus `craft-03` `binary-call`` (a designed native exercise on the same concepts, not a port of this sim).

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
| oval_intermediate, oval_short, road_course_short segments | procedural | original | ~7k tris each | painted V and restart zone |
| Lane bands, arrows, jump ring | UI meshes | original | - | pattern + color |
| Sound cues | synthesized | original-swoond | < 0.8 MB | engine rev pulse synthesized |

Addressables bundle: `sim-nascar-restart-choose-lane-v1` (expected size <= 8 MB compressed). Overlay styling per `docs/astra/ART_DIRECTION.md` sections 4-5. Vehicle liveries are fictional (no real team paint schemes, sponsors or logos); car numbers are generic.

## 19. Performance budget
Defaults from `docs/astra/README.md`: 60 fps sustained on iPhone 13-class (5th percentile >= 50 fps), < 150 MB peak resident memory, cold launch < 2 s to `ready`, bundle <= 25 MB, <= 150 draw calls, <= 60k triangles on screen, <= 15 materials, textures <= 8 MB VRAM, audio <= 3 MB. **Tighter per-sim limits:** <= 14 vehicles on screen; restart projection uses the model, not physics, for the 6 s run (scripted trajectories).

## 20. Telemetry
Diagnostics only, in `result.telemetry`: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters `hintsUsed`, `decisionLatencyMs`, `laneChosen`, `jumpOffsetMs`. No personal data; never `personName` or `relationship`.

## 21. Acceptance criteria (testable)
1. **AC-1:** Lane model: rs-01 outside slot 6 gain +1 => P5; inside slot 7 gain 0 => P7; best = outside.
2. **AC-2:** rs-04: both lanes tie at P6 and both count as best.
3. **AC-3:** Load-time consistency: authored `correct` equals model-derived verdicts for all scenarios.
4. **AC-4:** Jump: tap at t0 - 0.10 s is a violation (+6, mistake `restart`); tap at t0 + 0.10 s at L3 is perfect (-1).
5. **AC-5:** Failing to choose before the V auto-resolves as a timeout with the correct lane shown in Explain.
6. **AC-6:** autoJump true (or tap-only) removes the GO ring and caps the jump component at 90.
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
- **EditMode:** Lane model (9 scenarios), tie handling, jump windows, rounding (half away from zero), score maths, config validation, determinism, result schema.
- **PlayMode:** Scene build for three environments; scripted runs at levels 1, 3, 5; choose-line timeout; jump window; freeze/explain; pause/resume/abort; tap-only; reduced motion; color-blind screenshots.
- **Perf:** 3 consecutive full runs at difficulty 5 on an iPhone 13-class device; record fps, memory, thermal state (must not exceed "fair").

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | LaneModel_rs01 |
| AC-2 | EditMode | LaneModel_TieBoth |
| AC-3 | EditMode | Scenario_CorrectMatchesModel |
| AC-4 | PlayMode | Jump_WindowRules |
| AC-5 | PlayMode | ChooseLine_Timeout |
| AC-6 | PlayMode | AutoJump_TapOnly |
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
| 1 | SME check: lane biases per track type are stylized; confirm they do not contradict what fans consider general wisdom, or relabel as "this race" data. | Product / Claude | No |
| 2 | The choose rule and penalties vary by series and track in 2026; sim copy speaks generally ("most ovals"). Confirm wording with rules review. | Claude | No |
| 3 | Environment keys `oval_short` and `road_course_short` need Astra proposals. | Astra | No |

## Game Kit additions requested
- Environment keys `oval_short`, `road_course_short` (segments only).
- `RestartFormation` helper is sim-local, not a kit primitive; if a second sport (F1, IndyCar) needs it, promote to Racing module.
