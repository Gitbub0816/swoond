# Doubles Court Coverage (`pickleball.doubles.court-coverage.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `pickleball.doubles.court-coverage.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `pickleball`; `unitId` `doubles-strategy`; `lessonId` `dbl-05`.
- CDS row: section 12, "`dbl-05`: Doubles court coverage". Manifest: `unitySimulations[4]`.
- Prerequisite concepts: `court-positioning`, `dink`, `kitchen-nvz`, `doubles-vs-singles`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can move with your partner so the two of you cover the court, and you know who takes the ball down the middle."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `moving-as-a-team` | Moving as a team | Shift toward the ball with a partner while keeping the pair about 3 m apart (about 10 ft). |
| `court-positioning` | Court positioning | Describe the side-by-side formation at the kitchen line. |
| `middle-ball` | The middle | Recognise the middle as the most contested space. |
| `forehand-in-the-middle` | Forehand in the middle | Say the player with the forehand to the middle usually takes it. |
| `communication-calls` | Calls | Know to call "mine" or "yours" early. |
- **Out of scope:** stacking/switching (native `dbl-07`), poaching (native `dbl-08`), shot selection, scoring.

## 4. Why Unity (tier justification)
- **Signals:** *spatial reasoning and movement of two agents against a moving target*, *coverage* (gaps opening and closing), *timing* (arrival at contact). The concept is literally coverage over time, like the football coverage reads that the Game Kit was designed for.
- **Closest native:** `hotspot-tap` (tap where the partner should stand) and `decision-scenario` ("ball goes wide: who moves?"). They teach the *static* formation; they cannot show the pair spacing stretching and the middle opening as the ball moves side to side.
- **Fallback:** native lesson `dbl-05-native`: 3 `hotspot-tap` (where should the pair be when the ball is wide) + 3 `binary-call` (who takes the middle) with stills.
- Justification strong.

## 5. Player fantasy & core loop
- **Fantasy:** "You and your partner are a two-person wall at the kitchen line. Keep the wall together."
- **Loop:**
  1. Intro: rally starts; you control your player (rose ring); your partner (AI) moves too.
  2. Per shot (3 per round): the opponent hits toward a lane; you slide to shift with the pair (drag). A spacing band shows if the pair is too far or too close.
  3. On the fourth shot, the ball goes down the middle: **Decision** (Mine / Yours).
  4. Execute: contact resolves; gaps highlighted.
  5. Freeze/explain: top-down overlay shows the ideal formation vs yours, spacing, forehand arrows; say-this line.
- **Session:** about 3 minutes, 3 rounds (each round = 3 lateral shots + 1 middle ball).

## 6. Scene & entities
- **Environment:** `pickleball_court`; camera `top-down` slightly tilted (default, so the horizontal spacing reads), `broadcast-side` for replay.
- **Coords:** meters; origin net center; your team at z=-2.4 (kitchen line), opponents at z=+2.4.

| id | Primitive | Role | Key parameters |
|---|---|---|---|
| `court` | `Court` module | Court | as CDS |
| `you` | `Character` | Player you slide (rose ring) | move speed 3.2 m/s, x clamped [-2.9, 2.9]; side (left/right) and handedness from scenario |
| `partner` | `Character` | AI partner (rose ring thin) | AI ideal formation with 0.35 s lag; handedness from scenario |
| `opp1`, `opp2` | `Character` | Opponents at the line | strike cues (paddle angle) |
| `ball` | `Ball` | Rally ball | dt 1/120; arrival time from difficulty |
| `spacingBand` | `Zone` (dynamic, between you and partner) | Gold when 2.2 to 3.6 m apart; `accentTint` hatch when too far/close | color plus hatch |
| `ghosts` | `Highlight` x2 | Ideal positions for the current shot (L1-2) | rings |
| `proximityObjective` | `Objective` (`maintain_proximity`) | Keep pair spacing in [2.2, 3.6] m at contact | existing Game Kit objective type; concept `moving-as-a-team` |
| `shotObjective` | `Objective` (`reach_zone`) | Be within 0.6 m of the ideal x at contact | concepts `court-positioning` |
| `callTargets` | `Target` x2 | Mine (you) / Yours (partner) | ring; `conceptId` `forehand-in-the-middle` |
| `decision` | `DecisionPoint` | Middle call | timer per difficulty |
| `explain`, `score`, `hints`, `replay`, `slowmo` | kit | | |
- **Reused:** `Character`, `Zone`, `Objective` (`maintain_proximity`, `reach_zone`), `Target`, `DecisionPoint`, `TouchController`. **New primitives:** none; a `Formation` helper (pair spacing + ideal center function) is requested within the pickleball module.
- **Layout (top-down):**
```
 [opp1]                      [opp2]         z=+2.4
 ============== net z=0 ==============
 [you] <- 3.0 m ->  [partner]               z=-2.4
        ^ spacing band (gold)
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Slide | Drag horizontally | Your player (drag handle 64 pt, also a full-width slide strip 44 pt tall at the bottom) | 44 / 64 pt | Player follows the finger with 0.08 s smoothing; light tick at each 0.5 m |
| Middle call | Tap | "Mine" / "Yours" pills (56 pt) | >= 56 x 140 pt | Selected `accent` outline |
| Hint | Tap | "Hint" chip | 44 pt | Ghost rings appear |
- **Tap-only alternative:** three buttons "Shift left" / "Hold" / "Shift right" (56 pt); each tap moves you 0.5 m (0.25 s cooldown); no drag needed.
- Portrait; safe-area insets respected; native draws hearts/paywall/exit.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config; build scene; load scenarios | Ready/error | `ready` |
| Intro | ready | Scenario card: side, handedness ("You: left side. Partner: right, lefty.") 1.5 s | Playing | `progress` |
| Playing | intro | Shot 1..3: opponent cue (0.5 s), ball flight (arrival time by difficulty); player slides; contact resolves; small pass/fail glyph | After shot 3 | none |
| Decision | shot 4 | Ball goes to the middle; time slows to 0.4x for the decision window | Call made/timeout | none |
| Executing | call | The chosen player reaches or collides (both/no one) | Contact frame | none |
| Freeze | contact | Freeze; top-down; ideal vs actual formation drawn | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card; watch again | Next | `checkpoint round-N` |
| Summary | last | Score count-up; per-shot glyphs | Done | `progress 1.0` |
| Done | summary | `result`, `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze time/timers; partial result, xp 0 | resume/end | `result`, `requestExit` |

**Ideal formation function:** for shot target `x_t`, ideal pair center `c* = clamp(0.55 * x_t, -1.4, 1.4)`; ideal spacing 3.0 m; ideal `you` = `c*` -1.5 if you are the left player else +1.5. Shot success: `|x_you - x_ideal| <= 0.6` and spacing in [2.2, 3.6] at contact.
**Middle-call rule:** the taker is: (a) both right-handed: the left player (forehand toward the middle); (b) left player is a lefty and right player is a righty (both backhand to the middle): either is acceptable if the call is made within the window (score 0.6 for either); (c) right-hander on the left and lefty on the right (both forehands to the middle): the closer player (by x to the ball).

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Ball arrival time per shot (s) | 1.8 | 1.6 | 1.4 | 1.1 | 0.9 |
| Ghost rings (ideal positions) | on | on (shot 1 only) | off | off | off |
| Spacing band overlay | on | on | on | flash at contact | off |
| Opponent cue before shot (s) | 0.8 | 0.7 | 0.5 | 0.4 | 0.3 |
| Lateral shot targets | wide only (|x_t| >= 2) | wide + mid | any | any | any + fast switch (side to side) |
| Middle call window (real s) | 4 | 3.5 | 3 | 2.5 | 1.5 |
| Handedness cases | RR | RR | RR, both-forehand | + both-backhand | all |
| Hints | 3 | 2 | 1 | 0 | 0 |
- Default for `dbl-05`: 2. L1 passable by a beginner: slow ball, ghost rings, wide shots only, RR (rule is simple).

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "pickleball.doubles.court-coverage.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["coverage-starter", "coverage-middle", "coverage-mixed"], "default": "coverage-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "showRouteHints": { "type": "boolean", "default": true },
    "controlScheme": { "type": "string", "enum": ["drag", "tap-shift"], "default": "drag" },
    "youSide": { "type": ["string", "null"], "enum": ["left", "right", null], "default": null, "description": "null = scenario decides." }
  }
}
```
Valid: `{ "seed": 21, "scenarioSetId": "coverage-starter", "scenarioCount": 3, "controlScheme": "drag" }`. Invalid -> `CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/court-coverage-v1.json`, bundle `sim-pickleball-court-coverage`. Sets: `coverage-starter` = tags `wide`; `coverage-middle` = `middle`; `coverage-mixed` = all. Deterministic per seed (order, x-mirroring, opponent cue jitter).
- **N = 12 scenarios.** Shape:
```json
{ "scenarioId": "cc-s01", "youSide": "left", "handedness": { "you": "R", "partner": "R" },
  "shots": [ { "xt": -2.6 }, { "xt": 2.4 }, { "xt": -1.0 } ],
  "middle": { "xt": 0.1 }, "bestCall": "you", "acceptable": [], "teaches": "forehand-in-the-middle", "tags": ["wide", "middle"] }
```
- **Scenarios:**

| scenarioId | Setup (side, hands; shots xt; middle) | Best call | Teaches | Tags |
|---|---|---|---|---|
| `cc-s01` | You left R, partner right R; shots -2.6, 2.4, -1.0; middle 0.1 | You (left forehand) | `forehand-in-the-middle` | wide |
| `cc-s02` | You right R, partner left R; shots 2.7, -2.5, 1.2; middle -0.1 | Partner (left forehand) | `forehand-in-the-middle` | wide |
| `cc-s03` | You left R, partner right R; shots -2.8, -2.8, 2.6; middle 0.0 | You | `moving-as-a-team` | wide |
| `cc-s04` | You left R, partner right L (both forehand); ball middle at x=0.5 (closer to partner) | Partner (closer) | `middle-ball` | both-forehand |
| `cc-s05` | You right L, partner left R (both forehand); middle at x=-0.4 | Partner (closer) | `middle-ball` | both-forehand |
| `cc-s06` | You left L, partner right R (both backhand); middle 0.0 | Either (call early) | `communication-calls` | both-backhand |
| `cc-s07` | You right R, partner left R; shots 1.8, 0.8, -1.6; middle 0.2 | Partner | `court-positioning` | mid |
| `cc-s08` | You left R, partner right R; alternating fast switch shots -2.5, 2.5, -2.5; middle -0.2 | You | `moving-as-a-team` | switch |
| `cc-s09` | You right L, partner left L; middle 0.1 (both lefties: right player forehand) | You | `forehand-in-the-middle` | lefty |
| `cc-s10` | You left R, partner right R; partner is slow to shift (AI lag 0.6 s): spacing stress; middle -0.3 | You | `moving-as-a-team` | stress |
| `cc-s11` | You right R, partner left R; shots -2.9, -2.9, -2.9; middle 0.1 | Partner | `moving-as-a-team` | wide |
| `cc-s12` | You left R, partner right R; shots 0.5, -0.5, 0.5 (soft central); middle 0.0 | You | `middle-ball` | mid |
- Generation rule: shots `xt` in [-2.9, 2.9], alternate signs with 40% probability; `bestCall` computed by the middle-call rule.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-team-good` | All three shots covered | Gold spacing band; ideal ghosts overlap you | Correct | Nice read. Two-person wall. | You and your partner shifted together and stayed about ten feet apart. No gaps, no crowding. That is what covering the court looks like. | "We moved as a team and kept the middle covered." |
| `x-gap` | Spacing > 3.6 m at contact | Gap hatched in rose; arrows "too far" | Incorrect | Not quite. Too far apart. | Your pair was stretched. The middle opened and a ball there beats both of you. Shift toward the ball, but keep your partner near. | "We left a hole in the middle." |
| `x-crowd` | Spacing < 2.2 m | Overlap hatched; arrows "too close" | Incorrect | Not quite. Too close. | You bunched up. Now the sideline is open, and one of you is doing nothing. Slide with the ball, then open back up. | "We were too close together." |
| `x-late` | Position error > 0.6 m | Ideal ghost vs actual | Incorrect | Not quite. A step late. | You were on the right idea but arrived after the ball. Start sliding when the opponent's paddle turns, not when the ball is halfway. | "I moved late. I need to read the paddle." |
| `x-mid-forehand` | Correct call in case (a) | Forehand arrow from the taker to the ball | Correct | Nice read. Forehand takes it. | Two right-handers: the player on the left has the forehand toward the middle, so she takes it. Forehands are stronger than backhands, so that is the default. | "Forehand in the middle takes it." |
| `x-mid-forehand-wrong` | Wrong call in (a) | Arrow from the correct taker | Incorrect | Not quite. Other forehand. | The left-hand-side player has the forehand toward the middle here. A backhand in the middle is weaker. Call it with confidence. | "She has the forehand, so she takes the middle." |
| `x-mid-close` | Correct call in (c) | Both forehands; distance lines | Correct | Nice read. Closer one. | Both of you had a forehand to the middle, so the closer player takes it. Say it early so nobody freezes. | "We both had forehands, so the closer one took it." |
| `x-mid-close-wrong` | Wrong call in (c) | Distance lines | Incorrect | Not quite. She was closer. | When both of you have a forehand for the middle, it goes to whoever is closer. The other player should let go and cover the sideline. | "When both can, the closer one takes it." |
| `x-mid-backhand` | (b) either call | Neutral arrows; "call early" speech bubble | Correct (acceptable) | Either works, if called. | Both of you had a backhand there. Either can take it as long as someone calls it early. Silence is what loses the point. | "Someone has to say mine." |
| `x-collide` | No call by timer expiry | Both players converge | Timeout | Time's up. Nobody called. | With no call, you both hesitate or both go. Say "mine" or "yours" early. Even a wrong call beats silence. | "Call it early. Please." |

## 13. Scoring & mastery signals
- **Shot points (0/1)** for each lateral shot: success per section 8 formula (spacing in band and position error <= 0.6 m). **Middle call points:** best 1.0, acceptable 0.6, wrong 0.0, timeout 0.0.
- **Round points** = `0.6 * mean(shot points) + 0.4 * middleCallPoints`.
- **accuracy** = rounds with points >= 0.7 / rounds. **Outcome success** = points >= 0.7.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Spacing > 3.6 m at contact | `moving-as-a-team` | Left a gap in the middle by moving apart from the partner. |
| Spacing < 2.2 m | `court-positioning` | Bunched with the partner and left the sideline open. |
| Late to ideal position | `court-positioning` | Arrived after the ball because the slide started late. |
| Wrong middle taker (case a) | `forehand-in-the-middle` | Gave the middle ball to the backhand side. |
| Wrong middle taker (case c) | `middle-ball` | Did not give the ball to the closer player. |
| No call before timeout | `communication-calls` | Nobody called the middle ball. |
- **Mastery signals:** shots in band -> `moving-as-a-team` +0.20 (once per round); position within 0.6 m -> `court-positioning` +0.15; correct middle in (a)/(lefty) -> `forehand-in-the-middle` +0.25; correct in (c) -> `middle-ball` +0.20; call made in time -> `communication-calls` +0.15; mistakes -0.15 mapped; caps +-0.30/concept; hints halve positives (native).
- **Result mapping:** outcomes per round (`round-N`, success, label, `value` = round points as number), mistakes, masterySignals.

## 14. XP & hearts
+10 per successful round, +40 finishing; native clamps. `heartsLost` 1 if accuracy < 0.34, max 1. `replayAvailable` true.

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain with formation overlay | outcome false, mistakes | none |
| Failed session | "Two-person timing is hard alone. Try the slow version." Try again at lower difficulty suggested | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout on call | `x-collide` explain | mistake `communication-calls` | none |
| Abort/backgrounded | native | `aborted`, xp 0 | none |
| Asset/config error | native error | `error` | none |

## 16. Accessibility
- **Reduced motion:** no camera sweeps; the opponent cue is a static arrow; slow-mo decision window becomes a pause; no shake.
- **Haptics:** honor `hapticsEnabled`.
- **Color-blind:** spacing band uses solid gold vs diagonal hatch (too far) vs dots (too close) plus a text label; ghost rings have distinct shapes (circle vs square for you vs partner).
- **Text scale:** honored.
- **Tap-only:** `controlScheme: "tap-shift"` and pills.
- **VoiceOver:** Unity limited; native fallback `dbl-05-native` provided.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Slide tick | Soft tick per 0.5 m | light tap |
| Ball contact | Paddle pop | none |
| Pair in band | Low hum (subtle) | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
| Call | "Mine" voice? none (visual bubble only) | soft tap |

## 18. Art & asset list
| Asset | Procedural | License | Budget |
|---|---|---|---|
| Court/net/zones | Procedural | `original-swoond` | < 2k tris |
| Four characters | Procedural | `original-swoond` | < 3k tris each |
| Ball | Procedural | `original-swoond` | < 300 tris |
| Overlays (band, ghosts, arrows) | Procedural | n/a | n/a |
| Audio | Original | `original-swoond` | <= 1 MB |
Bundle `sim-pickleball-court-coverage`, <= 5 MB. Speech bubbles are text ("MINE"), no voice-over.

## 19. Performance budget
Defaults apply; tighter: 4 characters + dynamic zone < 15k tris; memory < 120 MB; cold launch < 2 s; drag input latency < 50 ms.

## 20. Telemetry
Standard plus `hintsUsed`, `meanPositionErrorM`, `meanSpacingM`, `callLatencyMsMedian`, `controlScheme`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 21, difficulty 2, 3 rounds -> exactly 3 outcomes, deterministic.
2. **AC-2:** The ideal-formation function returns the documented values for 20 fixtures (e.g. `xt=-2.6` -> center -1.4, you-left ideal -2.9).
3. **AC-3:** The middle-call oracle returns the tabled `bestCall`/`acceptable` for all 12 scenarios.
4. **AC-4:** The spacing band color state matches spacing thresholds (2.2 and 3.6 m) in 20 fixtures.
5. **AC-5:** With the tap-shift scheme, a full run completes with no drag events.
6. **AC-6:** `ready` < 2 s; exactly one schema-valid `result`; `requestExit` after.
7. **AC-7:** Pause/resume freezes ball, AI and timers; abort -> `aborted=true`.
8. **AC-8:** Copy lint passes.
9. **AC-9:** Reduced-motion and color-blind checks pass.
10. **AC-10:** Invalid config -> `CONFIG_INVALID`.
11. **AC-11:** Perf p5 >= 50 fps, memory < 120 MB (iPhone 13-class).
12. **AC-12:** Mastery caps +-0.30 per concept.
13. **AC-13:** Drag input to character position latency < 50 ms (PlayMode measurement).

## 22. Test plan
- **EditMode:** ideal-formation math, middle-call oracle, band thresholds, scoring, seed determinism, config validation, copy lint, result schema.
- **PlayMode:** scripted drag and tap-shift runs, freeze/explain, pause/abort, reduced motion, colour-blind snapshot, input latency.
- **Perf:** iPhone 13-class.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Coverage` |
| AC-2 | EditMode | `IdealFormation_Fixtures` |
| AC-3 | EditMode | `MiddleCall_Oracle` |
| AC-4 | EditMode | `SpacingBand_Thresholds` |
| AC-5 | PlayMode | `TapShift_FullRun` |
| AC-6, AC-7 | PlayMode | `Launch_Result`, `Pause_Abort` |
| AC-8 | EditMode | `Copy_Lint` |
| AC-9 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-10 | EditMode | `Config_Invalid` |
| AC-11 | Perf | `Perf_iPhone13` |
| AC-12 | EditMode | `Mastery_Caps` |
| AC-13 | PlayMode | `Input_Latency` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Shared `Court` module + env key + `Formation` helper. | Astra | Yes |
| 2 | Is the fixed 3.0 m spacing right at the kitchen line? Teach the idea ("about half the court each, moving together"), not a fixed number. Numbers may be tuned. | Product/Claude | No |
| 3 | Do we show handedness clearly for beginners (an "L"/"R" chip on each player)? Proposed yes. | Astra | No |
| 4 | Stacking is intentionally out of scope; confirm native `dbl-07` covers it. | Claude | No |

### Game Kit additions requested
- Shared `Court` module + `pickleball_court`.
- `Formation` helper in `Swoond.Sports.Pickleball` (pair center/spacing function, ideal positions). Reuse: tennis doubles and padel coverage sims.
