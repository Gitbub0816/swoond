# Court: Open Court and Recovery (`tennis.court.open-court-recovery.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `tennis.court.open-court-recovery.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (not data-driven in v1) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `tennis`; `unitId` `point-construction`; `lessonId` `pc-05`.
- CDS row: section 12, "`pc-05`: Recovery and open court".
- Manifest: `docs/courses/tennis/manifest.json` -> `unitySimulations[2]`.
- Prerequisite concepts (else a native primer first): `crosscourt`, `down-the-line`, `baseline-and-sidelines`, `crosscourt-rally`, `depth-control`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can pick where to stand after you hit so the opponent has no easy open court, and you can say why that spot is usually near the middle and not where you hit from."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `recovery-position` | Recovery position | Choose where to stand after a shot so every reply is reachable. |
| `court-geometry-angles` | Court angles | See that the opponent's possible replies fan out and that the middle covers most of them. |
| `open-court` | Open court | Point to the side of the court the opponent can hit into. |
| `wrong-footing` | Wrong-footing | Recognise a reply behind you into the spot you just left. |
| `change-of-direction` | Change of direction | Explain why staying wide after a wide shot fails. |
- **Out of scope:** stroke technique, shot selection (see `tennis.rally.arc-and-margin.v1`), fitness, doubles.

## 4. Why Unity (tier justification)
- **Signals:** *movement over time* (you must be somewhere before the opponent hits, and you have a fixed running budget) and *spatial reasoning* (reachable replies fan across the court; the best spot depends on where the opponent is and what they can realistically hit).
- **Closest native:** `hotspot-tap` ("tap where you should stand") gives a static answer but not the time-to-reach margin that decides whether the answer works; `decision-scenario` can state rules of thumb ("recover to the middle") but not show why staying wide leaves a gap. The reach margin between spot and reply is the concept.
- **Fallback:** native lesson `pc-05-native`: three `hotspot-tap` items ("where do you recover?") with a side-view diagram, two `binary-call` items ("open court or covered?") and one `decision-scenario`.
- Justification: moderate to strong (movement and timing are the concept; a native tap answers "where" but never "in time").

## 5. Player fantasy & core loop
- **Fantasy:** "You just hit a big shot. Now you move so they can't hurt you."
- **Loop:**
  1. Prompt: replay of your last shot (you are wide, or deep, or stepping in) and the opponent's stretched or comfortable position.
  2. Decision: drag your player (or tap a spot) to a recovery position within your running budget.
  3. Execute: the opponent hits their best reply from an option set (worst case for you); you run to it.
  4. Freeze at your contact: show reach margin (seconds), the fan of replies, the open court.
  5. Explain; say-this line.
- **Session:** about 3 minutes, 3 rounds (3-6).

## 6. Scene & entities
- **Environment:** `tennis_court`. **Cameras:** `broadcast-high-behind` (GK-19; default, you at the bottom), `top-down` (freeze/explain).
- **Units/coords:** metres as in the other tennis sims (origin at net centre; player side z<0, baseline z = -11.885; opponent side z>0). Running speed 6.0 m/s (teaching scale), reaction 0.2 s.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `court` | `Court` (Swoond.Sports.Tennis) | Surface and lines | `surface` param |
| `player` | `Character` | You (rose ring), draggable marker | speed 6.0 m/s |
| `opponent` | `Character` | Hits from a scenario position | option set per scenario |
| `ball` | `Ball` | Incoming reply | fixed dt 1/120 |
| `replyFan` | `ConeOverlay` (GK-15) + `Path` | Fan of the opponent's possible replies | shown L1-3 |
| `runBudget` | `Zone` (circle) | Area you can reach before the opponent hits | radius = speed x time |
| `reachRing` | `DistanceRing` (GK-13) | Margin label after the reply | seconds |
| `spotTargets` | `Target` x9 | Tap-only alternative: 3 depths x 3 widths | 64 pt |
| `decision`, `explain`, `score`, `replay`, `hints`, `slowmo` | kit | | |
- **New primitives:** none beyond shared tennis `Court`. Uses GK-10 (`InterceptionEvaluator`: time-to-reach) and GK-15 (`ConeOverlay`); sim-local `RecoveryOracle`.
- **Layout:**
```
 opponent (far) hits a reply into one of: [left corner] [middle] [right corner] [short drop]
 ----------------------- net -----------------------
 you (near) start where your shot left you (wide/deep/inside). Drag to a spot inside the running-budget circle.
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Move | Drag the player marker | Player handle | 64 pt | Marker follows; running-budget circle glows; clock ring |
| Confirm | Tap **Ready** | Primary pill | 56 pt | Split-step animation |
| **Tap-only** | Tap one of 9 spot targets (3 depths x 3 widths), then **Ready** | Spot targets | >= 64 pt | Target solid |
| Hint (L1-3) | Tap **Hint** | Button | 56 pt | Reply fan bisector shown |
- Portrait; controls bottom third. **Not drawn by Unity:** hearts, paywall, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build scene, load scenarios | Ready/error | `ready` |
| Intro | ready | Replay of your shot; situation card | Position | `progress` |
| Position | Intro done | Drag or tap a recovery spot; timer optional | Executing | none |
| Executing | Ready | Player runs to the spot; opponent hits worst-case reply; player runs to ball | Contact or miss | none |
| Freeze | contact/miss | Freeze; `top-down`; reply fan; margin ring; your spot vs the oracle spot | Explain | `checkpoint round-N-freeze` |
| Explain | freeze done | Card (section 12); optional replay from behind | Next | `checkpoint round-N` |
| Summary | last round | Score numerals | Done | `progress 1.0` |
| Done | summary | `result`, `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze / partial result, `xpEarned 0` | resume / end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Reply fan | shown | shown | shown, no bisector | hidden | hidden |
| Running-budget circle | shown | shown | shown | shown | hidden |
| Reach threshold "comfortable" (s) | >= 0.15 | >= 0.20 | >= 0.25 | >= 0.30 | >= 0.30 |
| Scenario situations | `wide-shot` | + `deep-shot` | + `stretched-opponent` | + `approach` | + `trap` |
| Options per scenario | 2 | 2-3 | 3 | 3-4 | 4 (incl. drop shot) |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Time limit (position, s) | none | none | none | 10 | 7 |
- Default for `pc-05`: **2**. L1 passable by a beginner: fan shown, bisector hinted, forgiving threshold.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "tennis.court.open-court-recovery.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["recovery-starter", "recovery-mixed", "recovery-traps"], "default": "recovery-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "controlScheme": { "type": "string", "enum": ["drag", "tap-spot"], "default": "drag" },
    "surface": { "type": "string", "enum": ["hard", "clay", "grass"], "default": "hard" },
    "showReplyFan": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." },
    "positionTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 5, "maximum": 30, "default": null }
  }
}
```
Valid example: `{ "seed": 21, "scenarioSetId": "recovery-starter", "scenarioCount": 3, "controlScheme": "tap-spot" }`. Invalid -> `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Scenarios/recovery-v1.json` (bundle `sim-tennis-recovery`). Sets: `recovery-starter` = `wide-shot`, `deep-shot`; `recovery-mixed` adds `stretched-opponent`, `approach`; `recovery-traps` = all. Deterministic by seed.
- **Oracle (pure `RecoveryOracle`):** each scenario lists the opponent's reply options `(landingX, landingZ, contactDz, flightTime)`. `margin(spot) = min over options of (flightTime - 0.2 - distance(spot, (landingX, landingZ + contactDz)) / 6.0)`. The opponent's reply is the option with the smallest margin. Outcomes: `comfortable` (margin >= level threshold), `stretched` (0 <= margin < threshold), `beaten` (margin < 0). The best spot maximises margin among spots inside the running budget (radius 6.0 x `runTime` from your start). Because it is an optimiser, the spec ships a checked-in **golden generator** that writes best spots and margins to fixtures; the numbers below are non-normative until the generator runs (convention from F1 specs).
- **N = 12 scenarios** (>= 3 rounds x 4). Shape:
```json
{ "scenarioId": "rc-s01", "situation": "wide-shot", "start": [3.5, -12.4], "runTimeSeconds": 1.4, "opponent": [-3.0, 12.3], "options": [[3.5, -10.8, -1.5, 1.55], [-3.5, -10.8, -1.5, 1.42]], "teaches": ["recovery-position"], "tags": ["wide-shot"] }
```
- **Scenarios** (start, best spot and margin are golden-generator sketches):

| scenarioId | Setup | Options (landing x, z, contact dz, flight s) | Best spot (approx) | Teaches | Tags |
|---|---|---|---|---|---|
| `rc-s01` | You hit crosscourt from the right corner; opponent stretched left. | (3.5,-10.8,-1.5,1.55) back to your corner; (-3.5,-10.8,-1.5,1.42) straight down the line | x ~ -0.4, behind the baseline; margin ~0.7 s; staying put is ~0.05 s (stretched) | `recovery-position`, `change-of-direction` | wide-shot |
| `rc-s02` | You are wide on the left after a stretch forehand; opponent has time. | (-3.8,-10.8,-1.5,1.42); (3.8,-10.8,-1.5,1.6); (0,-11.0,-1.5,1.5) | x ~ -0.5; margin ~0.67 s; staying wide ~0.13 s | `recovery-position`, `open-court` | wide-shot |
| `rc-s03` | You hit down the line from the right corner; opponent has only crosscourt or a deep reply. | (3.9,-10.8,-1.5,1.6); (-3.9,-10.8,-1.5,1.9) | x ~ +0.9 (shade to the shorter-flight side); margin ~0.9 s | `court-geometry-angles`, `recovery-position` | stretched-opponent |
| `rc-s04` | You are at the baseline centre; opponent can go both corners or drop-shot. | (-4,-10.8,-1.5,1.5); (4,-10.8,-1.5,1.5); (0,-5.5,0,1.8) | x ~ 0, inside the baseline; margin ~0.57 s | `court-geometry-angles`, `open-court` | deep-shot |
| `rc-s05` | You approached inside the court; opponent can pass either side or lob short. | (4,-10.8,-1.5,1.4); (-4,-10.8,-1.5,1.5); (0,-4,0,1.7) | x ~ +0.3, inside; margin ~0.4 s | `recovery-position` | approach |
| `rc-s06` | You are wide left; opponent stretched right with only a defensive reply. | (3.0,-10.8,-1.5,1.7); (-3.0,-10.8,-1.5,1.6) | x ~ -0.3, baseline; margin ~0.95 s | `recovery-position` | stretched-opponent |
| `rc-s07` | Neutral centre rally, opponent in the middle. | (-3,-10.8,-1.5,1.5); (3,-10.8,-1.5,1.5); (0,-10.8,-1.5,1.4) | centre; margin ~0.8 s; staying is equally good | `court-geometry-angles` | deep-shot |
| `rc-s08` | You hit a heavy crosscourt from the right; opponent has a comfortable reply. | (-4,-10.8,-1.5,1.6); (3.9,-10.8,-1.5,1.4) | x ~ +0.6, baseline; margin ~0.63 s; staying wide ~0.08 s | `change-of-direction` | wide-shot |
| `rc-s09` | Trap: opponent leans left; the wrong-foot is right behind you. | (3.8,-10.8,-1.5,1.6); (-3.8,-10.8,-1.5,1.5) | x ~ +0.2; do not chase the lean | `wrong-footing` | trap |
| `rc-s10` | Trap: you hit a drop shot; the opponent's only reply is a soft lob. | (0,-8.0,0,1.8); (2.0,-11.0,-1.5,1.9) | step in to z ~ -9.5; margin > 0.5 s | `recovery-position` | trap |
| `rc-s11` | You are deep behind the baseline after a lob defence. | (-3,-10.8,-1.5,1.5); (3,-10.8,-1.5,1.5); (0,-3.5,0,1.7) | step to the baseline centre; margin ~0.4 s | `open-court` | deep-shot |
| `rc-s12` | Pressure point: 30-40, you hit wide and the opponent may go either way. | (3.5,-10.8,-1.5,1.55); (-3.5,-10.8,-1.5,1.42) | as `rc-s01` | `recovery-position` | wide-shot |
- Rules for the rest: generate by choosing situation, start point within 4.5 m of the centre line, opponent position on their baseline, 2-4 options from the situation table.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-comfortable` | margin >= threshold | Fan and margin ring gold; your spot vs best | Correct | Nice read. Covered. | Every reply was reachable with time to spare. Standing near the middle means the fan of shots you cannot reach is small. | "I recover to the middle after a wide shot." |
| `x-stretched` | 0 <= margin < threshold | Ring amber; the gap highlighted | Partial | Close. You were stretched. | You reached it, but only just. A step closer to the middle earlier would have given time to set up. | "I got there, but I was late." |
| `x-beaten` | margin < 0 | Reply path drawn; open court hatched | Incorrect | Not quite. That was open. | You left that side open. The opponent hit into the gap you left. Recover toward the centre, not where you hit from. | "I stayed wide and they hit the open court." |
| `x-stay-wide` | Player ends within 0.6 m of start after a wide shot | Start point flagged | Incorrect | Not quite. Don't stay wide. | After a wide shot the open court is behind you. Staying put invites the wrong-foot. Get back toward the middle. | "I stood still and got wrong-footed." |
| `x-overcommit` | Player follows the opponent's lean | Lean arrow drawn; reply opposite | Incorrect | Not quite. Don't chase the lean. | Following the opponent's lean leaves the other side open. Cover the middle of their options. | "I chased his lean and he hit the other way." |
| `x-shade` | Spot within 0.5 m of the oracle x on a stretched-opponent scenario | Bisector line highlighted | Correct | Nice read. You shaded. | The opponent was stretched and had fewer replies. Shading toward the likely reply is smart. | "He's stretched, so I shade to his likely shot." |
| `x-approach` | Approach scenario handled | Net position shown | Correct | Nice read. Close the gap. | After a good approach, get in position to cover both passing lanes. Do not hover at the baseline. | "Approach, then cover the passing lanes." |
| `x-drop` | Standing too deep vs drop shot | Reach ring vs short landing | Incorrect | Not quite. Too deep. | You covered the corners but the short drop was out of reach. Baseline centre or a step inside covers all three. | "Too deep for the drop shot." |
| `x-timeout` | Timer expired | Auto-confirm at current spot | Timeout | Time's up. You stayed put. | Decide while the ball travels, not after. Pick a spot fast. | "Move as they hit, not after." |

## 13. Scoring & mastery signals
- **Round success:** margin >= level threshold (`comfortable`). `stretched` is half credit.
- **Score (0-100):** `round(100 * mean(roundPoints))`; points 1.0 (`comfortable`), 0.5 (`stretched`), 0.0 (`beaten`); hint -0.1 each (floor 0.4 for comfortable).
- **accuracy** = comfortable rounds / rounds.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Stayed near the start point after a wide shot | `change-of-direction` | Did not move back toward the middle. |
| Followed the opponent's lean | `wrong-footing` | Went with the lean and left the other side open. |
| Beaten to an open side | `open-court` | Left a side of the court uncovered. |
| Wrong depth (drop or lob vs depth) | `recovery-position` | Chose a spot that failed a reply option. |
| Ignored a stretched opponent's fewer options | `court-geometry-angles` | Did not shade toward the likely reply. |
- **Mastery signals:** `comfortable` -> `recovery-position` +0.20, `court-geometry-angles` +0.10; move away from start after wide shot -> `change-of-direction` +0.15; avoided lean on trap -> `wrong-footing` +0.20; covered open side -> `open-court` +0.15; mistakes -0.15. Caps +-0.30 per concept per session; hints halve positives.
- **Result mapping:** `outcomes[]` per round (`success`, `label`, `value` = `comfortable|stretched|beaten` and margin seconds), `mistakes[]`, `masterySignals[]`.

## 14. XP & hearts
- Proposal: +10 per comfortable round (+5 stretched), +40 for finishing; native clamps.
- `heartsLost` = 1 if accuracy < 0.34; max 1.
- `replayAvailable` true.

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain card with the open court hatched | outcome false + mistake | none |
| Failed session | "Recovery is a habit. Try again; watch where the open court is." | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto-confirm, explain | timeout outcome | none |
| Abort/backgrounded | Native flow | `aborted`, `xpEarned 0` | none |
| Asset missing / invalid config | Native error | `error` events | none |
Always ends in an explain moment.

## 16. Accessibility
- **Reduced motion:** hard cuts; running shown as a jump plus a path line; no shake.
- **Haptics:** respected.
- **Colour-blind:** reply fan uses hatch patterns and labelled arrows; margin ring has the number; open court is hatched, not only tinted.
- **Text scale** honoured.
- **Tap-only:** `controlScheme: "tap-spot"` (9 spots).
- **VoiceOver:** Unity limited; native fallback lesson `pc-05-native` (three `hotspot-tap`, two `binary-call`, one `decision-scenario`).

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Drag | Soft scuff loop (quiet) | tick on entering budget edge |
| Split step | Short thud | soft tap |
| Reply hit | Racquet pop | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
All honour `soundEnabled` / `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural? | Source/license | Budget |
|---|---|---|---|
| Court | Procedural | `original-swoond` | < 3k tris |
| Two characters | Procedural low-poly | `original-swoond` | < 3k tris each |
| Ball, overlays (fan, ring, circle) | Procedural | `original-swoond` | < 500 tris |
| Audio | Synth/original | `original-swoond` | <= 1 MB |
Bundle `sim-tennis-recovery`, <= 6 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md`. Tighter: memory < 120 MB; cold launch < 2 s; oracle < 1 ms per evaluation.

## 20. Telemetry
`avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `positionLatencyMsMedian`, `controlScheme`, `outcomeCodes`, `marginsSeconds`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 21, difficulty 2, 3 rounds: exactly 3 `outcomes`; repeat runs identical.
2. **AC-2:** `RecoveryOracle.margin` matches the golden fixture table (40 rows) to 0.01 s.
3. **AC-3:** The golden generator reproduces the fixtures byte-identical from the scenario file.
4. **AC-4:** A spot outside the running budget is clamped to the budget edge, never rejected.
5. **AC-5:** For `rc-s01` staying at the start yields `stretched` at L2 and moving to the oracle spot yields `comfortable`.
6. **AC-6:** `ready` < 2 s; one schema-valid `result`.
7. **AC-7:** Tap-only scheme completes a run with no drag events.
8. **AC-8:** Pause/resume freezes the timer and movement; abort yields `aborted=true`.
9. **AC-9:** Copy lint: titles <= 6 words, bodies <= 45 words, all outcomes have copy.
10. **AC-10:** Reduced-motion and colour-blind second channels present.
11. **AC-11:** Invalid config -> `CONFIG_INVALID`.
12. **AC-12:** Perf p5 >= 50 fps, memory < 120 MB on iPhone 13-class.
13. **AC-13:** Mastery caps +-0.30.

## 22. Test plan
- **EditMode:** `RecoveryOracle` fixtures, golden-generator reproducibility, budget clamp, seed determinism, config validation, scoring, copy lint, result schema.
- **PlayMode:** scene build, scripted drag and tap-spot runs, freeze/explain, pause/abort, reduced motion, colour-blind.
- **Perf:** iPhone 13-class 3-round run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Recovery` |
| AC-2, AC-3 | EditMode | `RecoveryOracle_Fixtures`, `GoldenGenerator_Reproducible` |
| AC-4, AC-5 | EditMode | `BudgetClamp`, `Scenario_rc_s01` |
| AC-6 | PlayMode | `ColdLaunch_Result_Schema` |
| AC-7 | PlayMode | `TapSpot_FullRun` |
| AC-8 | PlayMode | `Pause_Abort` |
| AC-9 | EditMode | `Copy_Lint` |
| AC-10 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-11 | EditMode | `Config_Invalid` |
| AC-12 | Perf | `Perf_iPhone13` |
| AC-13 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Tennis `Court` module and `tennis_court` env (shared). | Astra | Yes |
| 2 | Confirm 6.0 m/s running speed and 0.2 s reaction are good teaching-scale values; make them config later? | Astra/Claude | No |
| 3 | Opponent reply model: worst-case option (as specified) vs probabilistic choice. Worst-case is easier to test and explain; keep for v1. | Claude | No |
| 4 | GK-10 `InterceptionEvaluator` API reuse vs sim-local `RecoveryOracle`. | Astra | No |
| 5 | Add a doubles coverage variant (reusing pickleball court-coverage patterns, GK-11) in 1.2? | Product | No |

### Game Kit additions requested
- Tennis `Court` module + `tennis_court` env (shared).
- `RecoveryOracle` (sim-local, pure, golden-generated fixtures).
- Reuse GK-10 (`InterceptionEvaluator`), GK-13 (`DistanceRing`), GK-15 (`ConeOverlay`), GK-19 (`broadcast-high-behind` preset), `Zone` circle for running budget.
