# Serve: Aim and Land (`pickleball.serve.aim-and-land.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `pickleball.serve.aim-and-land.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `pickleball`; `unitId` `serve-and-return`; `lessonId` `serve-04`.
- CDS row: section 12, "`serve-04`: Serve aim and land".
- Manifest: `unitySimulations[1]`.
- Prerequisite concepts (else native primer first): `underhand-serve`, `serve-diagonal`, `kitchen-nvz`, `service-courts`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can put a legal serve into the correct diagonal box, and you know why a serve that lands short, wide, long or in the wrong box is a fault."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `serve-diagonal` | Diagonal serve | Send the serve cross-court to the opposite service box. |
| `serve-lands-in-box` | Land in the box | Know lines are in; land the ball inside the correct service box. |
| `serve-must-clear-kitchen` | Clear the kitchen | Know a serve landing on the kitchen line or in the kitchen is short (fault). |
| `underhand-serve` | Underhand serve | Understand the serve is low, upward, underhand (visual only in this sim; not the legality test). |
| `serving-side-even-odd` | Even right, odd left | Choose the serving side from the score (levels 3+). |
| `no-service-let` | No service lets | Know a serve that clips the net and lands in is live. |
| `drop-serve` | Drop serve | Recognise that a dropped ball hit after a bounce follows the same landing rules. |
- **Out of scope:** volley-serve arm legality (paddle below wrist, waist height: taught natively in `serve-02`), foot faults (native `serve-01`), scoring, return play.

## 4. Why Unity (tier justification)
- **Signals:** *physics* (ball arc, net clearance, bounce) and *spatial reasoning* (diagonal box, kitchen line, baseline), seen from a behind-the-server perspective and a top-down replay.
- **Closest native:** `hotspot-tap` (tap the correct service box) teaches which box; used in `serve-01`. It cannot teach why a flat hard serve sails long, a soft one dies at the kitchen line, or how far the arc must clear the net. The concept "the kitchen line is short" is felt by a serve dying short.
- **Fallback:** native lesson `serve-04-native`: three `hotspot-tap` + two `binary-call` items with landing diagrams.
- Retained; justification moderate-to-strong because arc/landing intuition is the point.

## 5. Player fantasy & core loop
- **Fantasy:** "You are stepping up to serve, and this one has to land."
- **Loop:**
  1. Prompt: score line ("Your score: 3. Serve from the left.") and the target framing (Intro).
  2. (Levels 3+) Decision 1: pick the serving side from the score (two Targets). Levels 1-2: auto.
  3. Aim: slingshot drag sets direction and power (or tap-target alternative).
  4. Execute: the ball flies; the sim resolves net, bounce, box.
  5. Freeze at first bounce; explain with top-down landing marker vs box; say-this line.
- **Session:** about 3 minutes, 3 rounds (configurable 3-6).

## 6. Scene & entities
- **Environment:** `pickleball_court`. **Cameras:** `chase-high` behind the server (default; aim view), `top-down` (freeze/explain), `broadcast-side` (optional replay of the arc).
- **Units/coords:** meters; origin at net center; x across, z along; server on z<0, facing +z. Right service court (server's right) is x>0; the diagonal target is x<0 on the far side (for a right-side serve).

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `court` | `Court` (Swoond.Sports.Pickleball) | Surface, lines, net (0.914 m posts, 0.864 m center), kitchen zone | see CDS |
| `server` | `Character` | Underhand server (rose ring) | 1.75 m; `AnimState` serve-underhand |
| `ball` | `Ball` | Served ball | fixed dt 1/120, gravity 9.81, linear drag 0.10 s^-1, restitution 0.65 |
| `targetBox` | `Zone` | The correct diagonal service box | gold outline on reveal; L1-2 pre-shaded with `rewardTint` |
| `kitchenZone` | `Zone` | Kitchen (short serve area) | `accentTint` on landing there |
| `sideTargets` | `Target` x2 | Right/left serving side | ring pulse 1 Hz; `conceptId` `serving-side-even-odd` |
| `aimGizmo` | `Path` + `Highlight` | Dotted preview arc (L1-2), landing reticle | rose |
| `landingMarker` | `Highlight` | Where it landed | gold if in, rose if not |
| `decision` | `DecisionPoint` | Side pick | optional time limit |
| `explain`, `score`, `replay`, `hints` | `Explanation`, `Score`, `Replay`, `Hint` | as per kit | |
- **New primitives:** none. Uses `Ball`, `Zone`, `Path`, `Target`. Requests `Court` module + `pickleball_court` env (shared with the other four sims) and a `Serve` helper (reserved name in GAME_KIT section 2): computes launch from drag and applies loft.
- **Layout:**
```
 far side  |  x<0 box (target)  |  x>0 box |
 --- kitchen line ---- net ---- kitchen line ---
 near side |  x<0 box | x>0 box (server on right) |
                ^ baseline, server behind it
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose side (L3+) | Tap | Right / Left `Target` rings | >= 64 pt | Ring solid; light tick |
| Aim + power | Drag back from the ball (slingshot) | Ball handle | handle 64 pt | Dotted arc (L1-2), power meter ring; haptic tick per 25% power |
| Serve | Release drag | n/a | n/a | Serve animation |
| **Tap-only aim** | Tap a point on the far court, then tap "Serve" | Far court plane | 44 pt tap slop | Reticle appears; power derived from target distance; seeded noise per level |
| Next | Tap | Primary pill | 56 pt | |
- **Portrait**, safe-area insets respected, controls in the bottom third.
- **Not drawn by Unity:** hearts, paywall, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build scene, load scenario set | Ready/error | `ready` |
| Intro | ready | Score and rule twist card | Decision (L3+) or Aim | `progress` |
| Decision | L3+ | Pick side; wrong side flagged | Aim | none |
| Aim | after side | Slingshot/tap aim; hints available | Serve | none |
| Executing | Release | Ball flight simulated deterministically; net-cord test; first bounce | First bounce or dead ball | none |
| Freeze | First bounce | Freeze; camera `top-down`; landing marker; correct box gold | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | Card (section 12); optional "watch again" (slow-mo arc) | Next | `checkpoint round-N` |
| Summary | last round | Score numerals | Done | `progress 1.0` |
| Done | summary | Send `result` then `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze time / partial result, `xpEarned 0` | resume / end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Target box pre-shaded | yes | yes | yes | flash 1 s | no |
| Dotted preview arc | full | to net | no | no | no |
| Serving side | auto | auto | learner picks | learner picks | learner picks (score shown as number only) |
| Aim noise (m, std dev at landing) | 0 | 0.10 | 0.20 | 0.30 | 0.40 |
| Launch loft (deg) | assisted | 24 | 22 | 20 | 18 |
| Power meter shown | yes | yes | yes | no | no |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Time limit (aim, s) | none | none | none | 12 | 8 |
| Twist pool | `standard` | `standard`, `deep-third` | + `cord` | + `drop-serve` | + `wrong-side-trap` |
- Default for `serve-04`: **2**. L1 passable by a beginner: pre-shaded target, preview arc, assisted loft, zero noise.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "pickleball.serve.aim-and-land.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["serve-starter", "serve-sides", "serve-mixed"], "default": "serve-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "controlScheme": { "type": "string", "enum": ["slingshot", "tap-target"], "default": "slingshot" },
    "showRouteHints": { "type": "boolean", "default": true },
    "aimTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 5, "maximum": 30, "default": null },
    "assistLoft": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." }
  }
}
```
Valid example: `{ "seed": 7, "scenarioSetId": "serve-starter", "scenarioCount": 3, "controlScheme": "slingshot" }`. Invalid -> `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Scenarios/serve-aim-v1.json` (bundle `sim-pickleball-serve-aim`). Sets: `serve-starter` = twists `standard`,`deep-third`; `serve-sides` = `standard` with side decisions; `serve-mixed` = all. Deterministic by seed: seed picks scenario order and aim-noise samples (noise sampled from `Rng` at round start, so replays match).
- **N = 12 scenarios** (>= 3 x 3). Scenario shape:
```json
{ "scenarioId": "srv-s01", "servingScore": 0, "serverNumber": 2, "serveType": "volley", "twist": "standard",
  "expected": { "side": "right", "targetBox": "far-left-of-server" }, "teaches": "serve-diagonal", "tags": ["standard"] }
```
- **Scenarios:**

| scenarioId | Setup | Correct decision/outcome | Teaches | Tags |
|---|---|---|---|---|
| `srv-s01` | Score 0 (even), server 2 (start of game, 0-0-2). | Side right; land in far-left diagonal box. | `serving-side-even-odd`, `serve-diagonal` | standard |
| `srv-s02` | Score 3 (odd), server 1. | Side left; land in far-right diagonal box. | `serving-side-even-odd` | standard |
| `srv-s03` | Score 6 (even). "Keep it deep": land in back third of the box (z >= 5.2). | Right; in box, deep third. | `serve-lands-in-box` | deep-third |
| `srv-s04` | Score 4; twist `cord`: the assist-free arc is calibrated so a mid-power serve clips the cord. | Ball touches the net cord and lands in: play on (no let). | `no-service-let` | cord |
| `srv-s05` | Score 2; a friend says "line serves are out". | Landing on a baseline/sideline/centerline is IN; landing on the kitchen line is short. | `serve-lands-in-box`, `serve-must-clear-kitchen` | standard |
| `srv-s06` | Score 5; `drop-serve` twist: ball drops from the hand and bounces before the hit. | Same landing rules; land in far-right box. | `drop-serve` | drop-serve |
| `srv-s07` | Score 8 (even). Start from the wrong side (L5 trap): both side targets shown, score shown as number only. | Right side. | `serving-side-even-odd` | wrong-side-trap |
| `srv-s08` | Score 1. Wind of chance? None (no wind); explicit target: "clear the kitchen by a full ball length". | Land beyond kitchen line + 0.2 m. | `serve-must-clear-kitchen` | standard |
| `srv-s09` | Score 10 (even), long-serve trap (power meter hidden at L4+). | Landing short of baseline z<=6.705. | `serve-lands-in-box` | standard |
| `srv-s10` | Score 7 (odd). | Left; far-right box. | `serving-side-even-odd` | standard |
| `srv-s11` | Score 9 (odd), drop serve. | Left; far-right box. | `drop-serve`, `serve-diagonal` | drop-serve |
| `srv-s12` | Score 0, first server exception: server 2 (0-0-2). | Right; far-left box. | `serving-side-even-odd` | standard |
- Rules for the rest: generate by choosing score 0-11, alternating twists; expected side = right if score even else left.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-in` | Lands in correct box | Gold box outline; landing marker gold; arc replayed | Correct | Nice read. That's a serve. | Diagonal, past the kitchen line, inside the box. That is the whole job of a serve. Lines count as in, so even a close one is fine. | "Good serve, right in the diagonal box." |
| `x-short` | Lands in kitchen or on the kitchen line | Kitchen shaded rose; line glows | Incorrect | Not quite. Too short. | The serve has to clear the kitchen, and the kitchen line counts as kitchen. That one died at the line. A little more legs, a little more arc. | "That serve was short. It has to clear the kitchen." |
| `x-net` | Ball hits net and stays out | Arc with net contact marker | Incorrect | Not quite. Net's in the way. | The ball has to get over the net first. Aim higher, not harder. A soft lift does it. | "She served it into the net." |
| `x-long` | Lands beyond baseline | Landing marker past the line | Incorrect | Not quite. Too long. | Past the baseline is out. Serves are underhand and upward, so a big swing usually sails. Ease off the power. | "Too long. Baseline serves are in, past it is out." |
| `x-wide` | Lands outside sideline | Marker outside | Incorrect | Not quite. Wide. | The sideline is in; the ground beyond it is not. Aim a touch toward the center of the box. | "It was wide. The sideline counts as in." |
| `x-wrong-box` | Lands in the wrong box | Both boxes drawn; correct gold | Incorrect | Not quite. Wrong box. | Serves go cross-court, diagonally. That one landed straight ahead. Think: right side sends left, left side sends right, as the far side sees it. | "Serve diagonal. Straight ahead is a fault." |
| `x-cord` | Ball clips cord and lands in | Slow-mo on net cord | Correct | Nice read. No lets. | It touched the net and still landed in the box. Modern rules have no service lets: if it lands in, play on. | "It clipped the net, but it's good. No lets." |
| `x-side-wrong` | Wrong side picked | Score card highlighted; both boxes drawn | Incorrect | Not quite. Wrong side. | Even score: serve from the right. Odd score: from the left. Zero counts as even. Check the score before you step up. | "Even means right, odd means left." |
| `x-side-right` | Correct side picked (shown before aim) | Score card; side ring gold | Correct | Nice read. Right side. | Your score is even, so you serve from the right. That decides which box you are aiming for. | "Even right, odd left." |
| `x-timeout` | Aim timer expired | Auto-serve at current aim | Timeout | Time's up. Try again. | You ran out of time, and the serve went with your last aim. That is a good moment to look where it landed. | "Take a breath before the toss." |

## 13. Scoring & mastery signals
- **Round success:** ball lands in the correct box (lines in) after legal net clearance; at L3+ correct side also required for full credit.
- **Score (0-100):** `round(100 * mean(roundPoints))`, points: 1.0 (correct side, in), 0.7 (in the box but the `deep-third` bonus target missed), 0.5 (wrong side but landed correct box), 0.0 otherwise; hint penalty -0.1 each (floor 0.4 for in-serves).
- **accuracy** = rounds successful / rounds.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Landed short (kitchen or line) | `serve-must-clear-kitchen` | Serve landed in the kitchen or on its line. |
| Landed in wrong box | `serve-diagonal` | Served straight instead of diagonal. |
| Wrong side for the score | `serving-side-even-odd` | Chose the wrong service side for the score. |
| Long/wide/net | `serve-lands-in-box` | Serve missed the box (long, wide or net). |
| Called "let" behavior (replayed serve after cord, if the learner taps Serve again) | `no-service-let` | Treated a cord serve as a let. |
- **Mastery signals:** correct in-box -> `serve-lands-in-box` +0.15, `serve-diagonal` +0.15; correct side -> `serving-side-even-odd` +0.20; clear kitchen on a `standard`/`kitchen` twist -> `serve-must-clear-kitchen` +0.20; cord scenario in -> `no-service-let` +0.25; drop-serve scenario in -> `drop-serve` +0.15; mistakes -0.15 each to the mapped concept. Per-session caps +-0.30 per concept; hints halve positives (native).
- **Result mapping:** `outcomes[]` per round (`id` `round-N`, `success`, `label`, `value` = outcome code `in|short|net|long|wide|wrong-box`); `mistakes[]`; `masterySignals[]`.

## 14. XP & hearts
- +10 per successful round, +40 for finishing; native clamps.
- `heartsLost` = 1 if accuracy < 0.34, else 0; max 1.
- `replayAvailable` true (deterministic re-run via seed).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain card for the specific outcome | outcome false + mistake | none |
| Failed session | "Serves are hard on the first try. Two more and you'll feel the arc." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto serve, explain | see `x-timeout` | none |
| Abort/backgrounded | Native flow | `aborted`, `xpEarned 0` | none |
| Asset missing / invalid config | Native errors | `error` events | none |
Always ends in an explain moment.

## 16. Accessibility
- **Reduced motion:** no camera sweeps; freeze is a hard cut; the arc preview is static dots; no shake.
- **Haptics:** `hapticsEnabled` respected; power ticks skipped when off.
- **Color-blind:** landing marker is a filled circle (in) vs an X (out); zones use hatch patterns; boxes labelled "TARGET".
- **Text scale** honored; card reflows.
- **Tap-only:** `controlScheme: "tap-target"` is the accessibility path; nothing requires a drag.
- **VoiceOver:** Unity limited; native fallback lesson `serve-04-native` provided.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Drag pull | Soft rising tone | tick every 25% power |
| Serve hit | Paddle pop | soft tap |
| Ball bounce | Pop-tick | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
All honor `soundEnabled`/`hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural? | Source/license | Budget |
|---|---|---|---|
| Court, net, boxes | Procedural | `original-swoond` | < 2k tris |
| Server character | Procedural | `original-swoond` | < 3k tris |
| Ball/paddle | Procedural | `original-swoond` | < 500 tris |
| Overlays | Procedural | n/a | n/a |
| Audio | Original foley/synth | `original-swoond` | <= 1 MB |
Bundle `sim-pickleball-serve-aim`, <= 5 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md` apply. Tighter: physics at fixed dt 1/120 within 2 ms per frame; memory < 110 MB; cold launch < 2 s.

## 20. Telemetry
`avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `aimLatencyMsMedian`, `controlScheme`, `outcomeCodes` (list), `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** With seed 7, difficulty 2, 3 rounds, exactly 3 `outcomes`; repeating gives identical landing points.
2. **AC-2:** The landing classifier (`in|short|net|long|wide|wrong-box`) is correct on a fixture table of 40 landing points including lines (lines are in; kitchen line is short).
3. **AC-3:** Net clearance test: a ball whose y at the net plane is less than the net height at that x + ball radius is `net` (30 fixtures).
4. **AC-4:** A cord-touch fixture that lands in yields `in` with `cord=true`, never a replay.
5. **AC-5:** Expected side equals right for even scores including 0 and left for odd (score 0-11 sweep).
6. **AC-6:** `ready` < 2 s; `result` schema-valid; exactly one result.
7. **AC-7:** Tap-only scheme completes a run with no drag events.
8. **AC-8:** Pause/resume freezes the aim timer and ball physics; abort yields `aborted=true`.
9. **AC-9:** Copy lint: titles <= 6 words, bodies <= 45 words, all outcomes have copy.
10. **AC-10:** Reduced motion path has no camera sweeps; color-blind second channel present.
11. **AC-11:** Invalid config -> `CONFIG_INVALID`.
12. **AC-12:** Perf: p5 >= 50 fps, memory < 110 MB on iPhone 13-class.
13. **AC-13:** Mastery signal caps +-0.30 per concept.

## 22. Test plan
- **EditMode:** `LandingClassifier`, net-clearance math, side rule, seed determinism, config validation, scoring, copy lint, result schema.
- **PlayMode:** scene build, scripted slingshot and tap-target runs, freeze/explain, pause/abort, reduced motion, colour-blind snapshot.
- **Perf:** iPhone 13-class 3-round run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Serve` |
| AC-2, AC-3, AC-4 | EditMode | `LandingClassifier_Fixtures`, `NetClearance_Fixtures`, `Cord_NoLet` |
| AC-5 | EditMode | `ServingSide_ScoreSweep` |
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
| 1 | `Court` module, `pickleball_court` environment, `Serve` helper additions. | Astra | Yes |
| 2 | Physics tuning: mid-power lofted serve should land 4.5 to 5.5 m past the net; Astra to tune drag/restitution to this outcome. | Astra | No |
| 3 | Is the cord scenario (`srv-s04`) worth a fixed calibrated aim, or emergent? Proposed: forced by scenario (fixed launch). | Astra/Claude | No |
| 4 | Confirm current volley-serve/drop-serve wording; sim doesn't test arm legality. | Claude (content) | No |

### Game Kit additions requested
- `Court` module + `pickleball_court` env (shared).
- `Serve` helper in `Swoond.Sports.Pickleball` (launch from drag/tap, loft assist, landing classifier `in|short|net|long|wide|wrong-box`). Reuse: return-of-serve/tennis serve sims later.
