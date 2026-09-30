# Rally: Arc and Margin (`tennis.rally.arc-and-margin.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `tennis.rally.arc-and-margin.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (not data-driven in v1) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `tennis`; `unitId` `point-construction`; `lessonId` `pc-02`.
- CDS row: section 12, "`pc-02`: Arc, spin and the net".
- Manifest: `docs/courses/tennis/manifest.json` -> `unitySimulations[1]`.
- Prerequisite concepts (else a native primer first): `topspin`, `slice`, `flat-shot`, `crosscourt`, `down-the-line`, `net-height`, `baseline-and-sidelines`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can pick a target and an arc that clear the net with room and land deep enough, and you can say why crosscourt is the safe default."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `net-clearance` | Net clearance | Judge how high over the net a ball needs to be, and why the net is lowest in the middle. |
| `topspin-arc` | Topspin arc | Explain that topspin lets a ball travel high over the net and still dip into the court. |
| `margin-for-error` | Margin for error | Choose the shot with the most room for error on net, depth and sideline. |
| `crosscourt-rally` | Crosscourt | Say why crosscourt is safer than down the line as a neutral shot. |
| `depth-control` | Depth | Know deep is good but not over the baseline; aim a racquet-length inside. |
| `high-percentage` | High-percentage tennis | Pick the safe option when out of position and the aggressive option on a short ball. |
- **Out of scope:** stroke technique, opponent movement (that is `tennis.court.open-court-recovery.v1`), doubles, serve.

## 4. Why Unity (tier justification)
- **Signals:** *physics* (arc, dip, net clearance, depth are the concept) and *camera perspective* (side-on shows height over the net; top-down shows width and depth margins). The learner sees three margins at once.
- **Closest native:** `binary-call` on a diagram ("Is this shot safe?") and `hotspot-tap` (tap the safe zone). Static diagrams cannot show that the same target is safe with topspin and a mistake with a flat drive, because the difference is the arc over time.
- **Fallback:** native lesson `pc-02-native`: two `binary-call` items with side-on arc diagrams, one `hotspot-tap` (safe target), one `decision-scenario` (topspin vs flat), one `estimate-slider` (net height).
- Justification: moderate. Kept because the arc is not drawable as a single number.

## 5. Player fantasy & core loop
- **Fantasy:** "It's a long rally and you are about to hit the ball that keeps you in the point."
- **Loop:**
  1. Prompt: a ball is coming; situation card (where you are, ball height, score pressure).
  2. Decision: choose a target zone (crosscourt deep, down the line, short angle, deep middle) and an arc (flat drive, topspin, slice, high loop).
  3. Aim: fine-tune the aim point (drag), or tap to accept the zone centre.
  4. Execute: the ball flies; the sim reports net clearance, depth and width margins.
  5. Freeze at bounce; explain the smallest margin; say-this line.
- **Session:** about 3 minutes, 3 rounds (3-6).

## 6. Scene & entities
- **Environment:** `tennis_court`. **Cameras:** `side-on-tilted` (GK-19; default, shows net and arc), `top-down` (freeze, margins), `chase-high` (aim).
- **Units/coords:** metres, as in `tennis.serve.place-and-spin.v1` (origin at net centre; x across; z along). Net height 0.914 m at centre, rising linearly to 1.07 m at the doubles posts (x = +-5.485). Singles half-width 4.115 m, half-length 11.885 m.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `court` | `Court` (Swoond.Sports.Tennis) | Surface, lines, net | `surface` param |
| `player` | `Character` | You (rose ring) at the baseline | stance point per scenario |
| `opponent` | `Character` | Stands at a fixed spot | stance point; not moving in this sim |
| `incoming` | `Ball` | The ball you hit (contact height per scenario) | fixed dt 1/120, gravity 9.81, drag, Magnus |
| `arcChips` | `Target` x4 | Flat, topspin, slice, high loop | `conceptId` `topspin-arc` |
| `targetZones` | `Zone` x4 | Crosscourt deep, down the line, short angle, deep middle | pattern-coded |
| `marginBars` | `Highlight` + overlay | Net / depth / width margins (metres) | shown after the hit |
| `netGhost` | `Highlight` | Height line at the net at ball x | side-on |
| `decision`, `explain`, `score`, `replay`, `hints`, `slowmo` | kit | | |
- **New primitives:** none beyond the shared tennis `Court`; uses `Ball` with `Swing` (GK-7) and `DistanceRing` (GK-13) for margin labels.
- **Layout:**
```
 opponent baseline (far)                     zones: crosscourt deep | down the line | short angle | deep middle
 ------------------ net (0.914 m centre) ----------------
 you (near baseline) hit from a contact height chosen by the scenario
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose target | Tap a zone | Far-court zone | >= 64 pt | Zone glows rose |
| Choose arc | Tap a chip | Flat / topspin / slice / loop | >= 56 pt | Chip selected |
| Fine aim (optional, L3+) | Drag reticle inside zone | Reticle handle | 64 pt | Dotted arc preview (L1-2) |
| Hit | Tap **Hit** | Primary pill | 56 pt | Ball flies |
| **Tap-only** | Zones and chips are taps already; aim uses zone centre + seeded noise | | | |
- Portrait; controls in the bottom third. **Not drawn by Unity:** hearts, paywall, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build scene, load scenarios | Ready/error | `ready` |
| Intro | ready | Situation card | Decision | `progress` |
| Decision | Intro done | Choose target and arc | Aim | none |
| Aim | after decision | Optional fine aim (L3+); hints | Hit | none |
| Executing | Hit | Deterministic flight; net test; bounce | First bounce or dead ball | none |
| Freeze | bounce | Freeze; camera `top-down`; three margin bars; smallest margin flagged | Explain | `checkpoint round-N-freeze` |
| Explain | freeze done | Card (section 12); optional slow-mo from side-on | Next | `checkpoint round-N` |
| Summary | last round | Score numerals | Done | `progress 1.0` |
| Done | summary | `result`, `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze / partial result, `xpEarned 0` | resume / end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Arc chips available | topspin, flat | topspin, flat, loop | all four | all four | all four |
| Target zones available | crosscourt, middle | + down the line | + short angle | all | all |
| Preview arc | full | to net | none | none | none |
| Margin bars during aim | shown | shown | on release only | on release only | on release only |
| Aim noise (m) | 0 | 0.15 | 0.25 | 0.35 | 0.45 |
| Situation types | neutral | neutral, short-ball | + defensive | + pressure | + trap |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Time limit (decision, s) | none | none | none | 10 | 7 |
- Default for `pc-02`: **2**. L1: crosscourt or middle only, two arcs, full preview, zero noise.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "tennis.rally.arc-and-margin.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["margin-starter", "margin-mixed", "margin-pressure"], "default": "margin-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "controlScheme": { "type": "string", "enum": ["reticle", "tap-target"], "default": "reticle" },
    "surface": { "type": "string", "enum": ["hard", "clay", "grass"], "default": "hard" },
    "showPreviewArc": { "type": "boolean", "default": true },
    "decisionTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 5, "maximum": 30, "default": null }
  }
}
```
Valid example: `{ "seed": 5, "scenarioSetId": "margin-starter", "scenarioCount": 3, "controlScheme": "tap-target" }`. Invalid -> `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Scenarios/rally-margin-v1.json` (bundle `sim-tennis-rally-margin`). Sets: `margin-starter` = `neutral`, `short-ball`; `margin-mixed` = adds `defensive`; `margin-pressure` = all incl. `trap`. Deterministic by seed.
- **N = 12 scenarios.** Shape:
```json
{ "scenarioId": "rm-s01", "situation": "neutral", "contactHeightM": 0.9, "playerX": 2.0, "opponentX": -2.0, "expected": { "targets": ["crosscourt-deep"], "arcs": ["topspin"] }, "requires": { "minNetMarginM": 0.4, "minDepthMarginM": 0.7 }, "teaches": ["crosscourt-rally"], "tags": ["neutral"] }
```
- **Scenarios:**

| scenarioId | Setup | Correct decision/outcome | Teaches | Tags |
|---|---|---|---|---|
| `rm-s01` | Neutral rally, ball waist high, both at the baseline. | Crosscourt deep with topspin; net margin >= 0.4 m, depth margin >= 0.7 m. | `crosscourt-rally`, `topspin-arc` | neutral |
| `rm-s02` | Neutral rally; a flat drive down the line is offered as tempting. | Down the line flat is the smallest-margin shot (higher net at the edge, shorter court): choose crosscourt. | `margin-for-error`, `net-clearance` | neutral |
| `rm-s03` | Short ball, waist high, inside the service line. Opponent on the opposite side. | Attack: flat or topspin drive, crosscourt or down the line into the open court; net margin >= 0.15 m allowed. | `high-percentage` | short-ball |
| `rm-s04` | You are stretched wide, ball at shoulder height, opponent at the net. | High loop deep middle to buy time; net margin >= 1.5 m, depth margin >= 1.0 m. | `high-percentage`, `topspin-arc` | defensive |
| `rm-s05` | Neutral rally; learner picks flat crosscourt with power. | Flat has a low arc: net margin thin. Prefer topspin for the same target. | `topspin-arc`, `net-clearance` | neutral |
| `rm-s06` | Neutral rally with a big deep ball coming; contact chest high. | Deep middle with topspin; depth margin >= 1.0 m; no risky angle. | `depth-control` | neutral |
| `rm-s07` | Short ball, you are inside the baseline, opponent recovering to the middle. | Short angle with topspin: pulls opponent off court; width margin >= 0.5 m. | `high-percentage` | short-ball |
| `rm-s08` | Pressure: 30-40, neutral rally. | Crosscourt deep topspin again: pick the highest-percentage shot, not the flashiest. | `high-percentage` | pressure |
| `rm-s09` | Defensive: low ball at the shoelaces. | Slice or loop with height; do not flat drive. Net margin >= 0.6 m. | `net-clearance` | defensive |
| `rm-s10` | Trap: the middle of the court looks empty; the opponent leans wide. | Deep middle is still fine; the opponent leaning wide means crosscourt is now covered; choose down the middle or the opposite corner with margin. | `margin-for-error` | trap |
| `rm-s11` | Neutral rally, opponent is a lefty backhand-down-the-line specialist. | Crosscourt to the deuce corner still has the best margin; note a cross-court lefty forehand is the tough one. | `crosscourt-rally` | neutral |
| `rm-s12` | Pressure at break point: deep crosscourt topspin vs a big drive down the line. | Crosscourt deep. Learner should say why in the explain moment. | `high-percentage` | pressure |
- Rules for the rest: generate by choosing situation, contact height 0.4 to 1.4 m, stance positions; `expected` from the situation table (neutral -> crosscourt or middle + topspin; short-ball -> attack; defensive -> loop/slice; pressure -> neutral answer).

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-good-margin` | Meets `requires` | Three margin bars gold; net ghost line | Correct | Nice read. Plenty of room. | Over the net with margin, and deep enough to push them back. That is why players hit crosscourt with topspin: more room on every side. | "Crosscourt, deep, with topspin. Safe and heavy." |
| `x-net` | Net (no cord) | Ball at net; height bar short | Incorrect | Not quite. Net's in the way. | Flat drives have a low arc. Topspin lets you aim higher over the net and still drop in. Add height, not power. | "Flat drive clipped the net. Add topspin." |
| `x-net-cord` | Cord and over | Slow-mo on tape | Neutral | Lucky cord. Still a warning. | It fell in, but the margin was inches. Depend on margin, not luck. | "It cleared by an inch. I'll aim higher." |
| `x-long` | Past the baseline | Depth bar red-outlined | Incorrect | Not quite. Too long. | Long is out. Aim a racquet-length inside the baseline and let topspin bring it down. | "Aim inside the baseline. Topspin drops it." |
| `x-wide` | Outside the sideline | Width bar outlined | Incorrect | Not quite. Too wide. | Down the line has less room: the court is narrower than the diagonal. Crosscourt gives more width. | "Down the line has the least room." |
| `x-dtl-risk` | Down-the-line in but margin under threshold | Width and net bars low | Neutral | In, but risky. | It landed, but the margin was slim: the net is higher at the sideline and the court is shorter. Save it for a short ball. | "Down the line is a risk. Use it on short balls." |
| `x-attack-good` | Short ball attacked with margin | Open-court shading | Correct | Nice read. Attack the short ball. | A short ball is time and room. Hit through it into the open court; you can afford less net margin here. | "Short ball, attack the open court." |
| `x-defense-good` | Loop or slice from a stretched position | Arc trace high | Correct | Nice read. Buy time. | Out of position, a high deep ball gives you time to recover. Safe beats brave here. | "Out of position, I hit it high and deep." |
| `x-pressure-flash` | Flashy target under pressure and missed | Bars show smallest margin | Incorrect | Not quite. Safe wins here. | Under pressure the shot with the biggest margins wins more often. Flashy shots have thin margins. | "On big points I go for margin." |
| `x-timeout` | Decision timer expired | Auto-hit to last selection | Timeout | Time's up. Swing went. | Read the ball, then pick the target. Two seconds of thought beats a guess. | "Read it first, then swing." |

## 13. Scoring & mastery signals
- **Physics (teaching scale; non-normative until Astra tunes):** contact height per scenario; launch speed by arc chip: flat 30 m/s, topspin 24 m/s with dip (Magnus, spin 45 rps), slice 20 m/s (low bounce), loop 16 m/s (spin 30 rps, high apex); net height `h(x) = 0.914 + 0.156 * |x| / 5.485`; margins: `netMargin` = ball height at net plane minus `h(x)` minus ball radius 0.033; `depthMargin` = baseline z minus landing z (positive inside); `widthMargin` = sideline x minus |landing x|.
- **Round success:** `in` (net clears, lands inside all lines) and meets the scenario `requires` thresholds. Cord-and-in = `neutral`.
- **Score (0-100):** `round(100 * mean(roundPoints))`; points 1.0 (meets `requires` and matches an `expected` target family), 0.7 (in but under threshold or unexpected target), 0.0 (fault); hint -0.1 each (floor 0.4 for in-shots).
- **accuracy** = rounds with `in` and margins met / rounds.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Net | `net-clearance` | Ball did not clear the net. |
| Long | `depth-control` | Ball landed past the baseline. |
| Wide or thin width margin | `crosscourt-rally` | Chose down the line when crosscourt had more room. |
| Flat drive with thin net margin | `topspin-arc` | Used flat where topspin gave margin. |
| Flashy shot chosen under pressure | `high-percentage` | Skipped the safe shot. |
| Any smallest-margin failure | `margin-for-error` | Did not leave room. |
- **Mastery signals:** meets `requires` -> `margin-for-error` +0.20, `net-clearance` +0.15; topspin used on a neutral ball -> `topspin-arc` +0.20; crosscourt chosen on a neutral ball -> `crosscourt-rally` +0.20; attack on short ball -> `high-percentage` +0.15; deep with margin -> `depth-control` +0.15; mistakes -0.15. Caps +-0.30 per concept per session; hints halve positives.
- **Result mapping:** `outcomes[]` per round (`success`, `label`, `value` = `in|net|long|wide|cord` and the smallest margin name), `mistakes[]`, `masterySignals[]`.

## 14. XP & hearts
- Proposal: +10 per successful round, +40 for finishing; native clamps.
- `heartsLost` = 1 if accuracy < 0.34; max 1.
- `replayAvailable` true.

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain card with the smallest margin flagged | outcome false + mistake | none |
| Failed session | "Margins are the game. Try again; the next three will feel easier." | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto-hit and explain | timeout outcome | none |
| Abort/backgrounded | Native flow | `aborted`, `xpEarned 0` | none |
| Asset missing / invalid config | Native error | `error` events | none |
Always ends in an explain moment.

## 16. Accessibility
- **Reduced motion:** hard cuts; static dotted arc; no shake; slow-mo replaced by a still with an arc trace.
- **Haptics:** respected; drag ticks skipped when off.
- **Colour-blind:** margin bars carry numbers plus icons (net, depth, width) and patterns; zones patterned; no rose/gold-only meaning.
- **Text scale** honoured.
- **Tap-only:** `controlScheme: "tap-target"`; nothing requires a drag.
- **VoiceOver:** Unity limited; native fallback lesson `pc-02-native` (two `binary-call`, one `hotspot-tap`, one `decision-scenario`, one `estimate-slider`).

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Hit | Racquet pop (synth), pitch by arc | soft tap |
| Net cord | Tape flutter | light tap |
| Bounce | Pop-tick | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
All honour `soundEnabled` / `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural? | Source/license | Budget |
|---|---|---|---|
| Court and net | Procedural | `original-swoond` | < 3k tris |
| Two characters | Procedural low-poly | `original-swoond` | < 3k tris each |
| Ball, racquet | Procedural | `original-swoond` | < 500 tris |
| Margin bars, ghost lines | Procedural overlays | n/a | n/a |
| Audio | Synth/original | `original-swoond` | <= 1 MB |
Bundle `sim-tennis-rally-margin`, <= 6 MB.

## 19. Performance budget
`docs/astra/README.md` defaults apply. Tighter: physics at fixed dt 1/120 within 2 ms; memory < 120 MB; cold launch < 2 s.

## 20. Telemetry
`avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `decisionLatencyMsMedian`, `controlScheme`, `outcomeCodes`, `smallestMarginNames`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 5, difficulty 2, 3 rounds: exactly 3 `outcomes`; repeats give identical landing points.
2. **AC-2:** Net height function matches 0.914 m at x=0 and 1.07 m at |x|=5.485 (tolerance 1 mm).
3. **AC-3:** Margin calculator returns the correct `netMargin`, `depthMargin`, `widthMargin` on a 40-row fixture table.
4. **AC-4:** For a fixed contact point and target, topspin has a higher apex than flat and the same landing within 0.3 m on the calibration fixtures.
5. **AC-5:** Down-the-line with flat chip has smaller minimum margin than crosscourt with topspin on scenario `rm-s02` fixtures.
6. **AC-6:** `ready` < 2 s; one schema-valid `result`.
7. **AC-7:** Tap-only run completes with no drag events.
8. **AC-8:** Pause/resume freezes timer and physics; abort yields `aborted=true`.
9. **AC-9:** Copy lint: titles <= 6 words, bodies <= 45 words, all outcomes have copy.
10. **AC-10:** Reduced-motion and colour-blind second channels present.
11. **AC-11:** Invalid config -> `CONFIG_INVALID`.
12. **AC-12:** Perf p5 >= 50 fps, memory < 120 MB on iPhone 13-class.
13. **AC-13:** Mastery caps +-0.30.

## 22. Test plan
- **EditMode:** net height, margin calculator, arc calibration, scenario oracle (`requires`), seed determinism, config validation, scoring, copy lint, result schema.
- **PlayMode:** scene build, scripted reticle and tap runs, freeze/explain, pause/abort, reduced motion, colour-blind.
- **Perf:** iPhone 13-class 3-round run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Rally` |
| AC-2 | EditMode | `NetHeight_Function` |
| AC-3 | EditMode | `Margins_Fixtures` |
| AC-4, AC-5 | EditMode | `ArcCalibration`, `DownTheLine_Risk` |
| AC-6 | PlayMode | `ColdLaunch_Result_Schema` |
| AC-7 | PlayMode | `TapTarget_FullRun` |
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
| 2 | Magnus model and dip: Astra to calibrate so a 24 m/s topspin drive aimed 1 m above the net lands 1.0 to 2.0 m inside the baseline (values are teaching-scale). | Astra | No |
| 3 | Confirm net height figures (0.914 m centre, 1.07 m posts) against the ITF Rules of Tennis before copy lock. | Claude (content) | No |
| 4 | Are `rm-s10` and `rm-s11` clear enough for L5, or should they move to a later version? | Claude | No |

### Game Kit additions requested
- Tennis `Court` module + `tennis_court` env (shared with the other two tennis sims).
- `RallyMargin` (pure evaluator: net height function, `netMargin/depthMargin/widthMargin`, scenario `requires` check). Sim-local; reusable for badminton/pickleball later.
- Reuse GK-7 (`Ball.Throw` `Swing`), GK-13 (`DistanceRing`), GK-19 (`side-on-tilted` camera preset).
