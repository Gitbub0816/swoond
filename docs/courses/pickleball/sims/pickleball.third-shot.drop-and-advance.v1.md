# Third Shot: Drop and Advance (`pickleball.third-shot.drop-and-advance.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `pickleball.third-shot.drop-and-advance.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `pickleball`; `unitId` `doubles-strategy`; `lessonId` `dbl-03`.
- CDS row: section 12, "`dbl-03`: Third shot drop and advance". Manifest: `unitySimulations[2]`.
- Prerequisite concepts: `two-bounce-rule`, `kitchen-nvz`, `drive`, `drop-shot`, `return-of-serve`. (If not mastered, show the native primer `dbl-02` first.)

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can read where the returners are, choose a drop or a drive for the third shot, and see why a good drop gives your team time to walk up to the kitchen line."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `third-shot-drop` | Third-shot drop | Explain that a soft arcing shot into the kitchen buys time to advance. |
| `third-shot-drive` | Third-shot drive | Say when a drive is smart (returners are back) and when it is risky (they are at the line). |
| `advance-to-kitchen-line` | Advance to the line | Know the serving team wants to reach the kitchen line and why. |
| `transition-zone` | Transition zone | Recognise the danger of being caught mid-court. |
| `drop-shot` | Drop shot | Identify a drop by its arc and landing. |
| `two-bounce-rule` | Two bounces | Know the third shot is hit after the serve-return bounce constraints (serving team must let the return bounce). |
| `lob` | Lob | See a lob as a situational surprise. |
- **Out of scope:** stroke technique, spin, scoring, serve legality.

## 4. Why Unity (tier justification)
- **Signals:** *ball flight/physics* (arc height, flight time, bounce after landing) and *movement over time* (two players covering 4.6 m while the ball is in the air) and *reading a dynamic scene* (where the returners stand).
- **Closest native:** `decision-scenario` ("returners at the line: drop or drive?") and `hotspot-tap` (where should the drop land). They teach the *rule of thumb*, but not the reason: the drop works because flight time >= time to advance; a drive arrives too fast for the team to move up. A learner cannot feel "time to advance" from text.
- **Fallback:** native lesson `dbl-03-native`: 3 `decision-scenario` items with timeline facts (flight time vs run time) plus 2 `hotspot-tap` items.
- Justification strong.

## 5. Player fantasy & core loop
- **Fantasy:** "You and your partner are at the back after the serve. The returners are already at the net. Get out of trouble and win the line."
- **Loop:**
  1. Intro: scene setup, the return has just bounced deep on your side.
  2. Read + decision: choose Drop, Drive or Lob (DecisionPoint, three options) after looking at the returners.
  3. Aim: place the shot (three lanes) with a tap or a tiny drag.
  4. Execute: ball flies; your team auto-advances; opponents react (counter-drive, volley, or reset) using simple deterministic rules.
  5. Freeze at the moment the opponent makes contact after the bounce: show where your team is versus the line, timing bar; explain; say-this line.
- **Session:** about 3 minutes, 3 rounds.

## 6. Scene & entities
- **Environment:** `pickleball_court`; cameras `broadcast-side` (default, high, both halves visible), `top-down` (explain), `chase-high` (execution close-up).
- **Coords:** meters; origin net center; near side z<0 (learner's team); baseline z=-6.705; kitchen line z=-2.134. Opponents on z>0.

| id | Primitive | Role | Key parameters |
|---|---|---|---|
| `court` | `Court` module | Court/kitchen | as CDS |
| `you` | `Character` | Hitter (rose ring) | start (x from scenario, z -6.6), run speed 4.0 m/s during advance, 0.25 s split-step pause at the line |
| `partner` | `Character` | Partner (rose ring, thinner) | start opposite half at z -6.4; advances the same |
| `opp1`, `opp2` | `Character` | Returners (muted) | positions from scenario; reaction time 0.35 s |
| `ball` | `Ball` | Third shot | dt 1/120, restitution 0.65, drag 0.10 s^-1 |
| `drop` / `drive` / `lob` | `Target` x3 | Shot choices | `conceptId` per shot |
| `aimLanes` | `Target` x3 | Left / middle / right lane | rings on the far side |
| `oppKitchen` | `Zone` | Their kitchen (drop target) | `rewardTint` when landed inside |
| `transitionZone` | `Zone` | Mid-court "danger" band z in [-5.2, -2.6] | `accentTint` hatch |
| `kitchenLineZone` | `Zone` thin | Your kitchen line target for advance | gold on arrival |
| `advanceObjective` | `Objective` (`reach_zone`) | Team reaches `kitchenLineZone` (both players' z >= -2.35) before opponent's contact after bounce | ConceptIds above |
| `timeline` | overlay | Bars: ball flight time vs team advance time | numerals in Numeral serif |
| `paths` | `Path` | Advance paths and ball arcs | rose (you) / gold (correct) |
| `decision`, `explain`, `score`, `hints`, `replay`, `slowmo` | as kit | | |
- **New primitives:** none beyond the shared `Court` module; requests **`AdvanceObjective`** (a `reach_zone` objective with a deadline `by_event: opponent_contact`) as a registry entry of objective type `reach_zone_by_event` (existing `reach_zone` extended by `deadline`), reusable for football coverage timing.
- **Layout (top-down):**
```
 z=+6.7  baseline (opp)     [opp1] [opp2] at kitchen line z=+2.134 (scenario s01)
 z=+2.1  kitchen line    ====== net z=0 ======  
 z=-2.1  kitchen line (your target)
 z=-6.7  baseline: [you]   [partner]
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose shot | Tap | Drop / Drive / Lob pills (bottom, 56 pt tall) | >= 56 x 100 pt | Selected gets `accent` outline; shot arc preview draws (L1-2) |
| Aim | Tap a lane ring (Left / Middle / Right) or drag the reticle within the far side | Lane rings | 64 pt | Ring solid |
| Hit | Tap "Hit it" (primary, 56 pt) | n/a | 56 pt | Executes |
| Explain scrub | Drag / step buttons | Timeline bar | 44 pt | Frame stepper |
- **Tap-only:** every control above is tap; drag is optional. Portrait; overlays in the bottom 35%; the court occupies the top 65%.
- **Not in Unity:** hearts, paywall, confirm-exit, XP display.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config; build court/characters; load scenarios | Ready/error | `ready` |
| Intro | ready | Scenario card: "The return landed deep. Their team is up. What now?" (1.5 s) | Decision | `progress` |
| Decision | intro | Three-option DecisionPoint; optional timer; hints available | Aim | none |
| Aim | decision | Lane picking | Execute | none |
| Executing | Hit | Ball flight; team advance; opponent reaction rules run; 2 s max | Freeze at opponent contact after bounce | none |
| Freeze | contact | Freeze, top-down, timeline bars, transition-zone shading | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card with copy; "Watch again" slow-mo; Next | Next round/Summary | `checkpoint round-N` |
| Summary | last round | Score count-up, mistakes recap | Done | `progress 1.0` |
| Done | summary | `result` then `requestExit(completed)` | end | `result`, `requestExit` |
| Paused/Aborted | native | freeze time/timers; partial result `xpEarned 0` | resume/end | `result`, `requestExit` |

**Opponent reaction rules (deterministic):**
- Ball lands in opp kitchen and second-bounce apex < 0.914 m above ground (net height): opponents can only dink/reset (`reset`). Team keeps advancing.
- Drive that lands in the court and opponents at the line: opponents volley/counter-drive at your feet if your team's average z < -2.8 at their contact (`caught`), otherwise reset.
- Drive versus opponents back (baseline z > 5.5): they must return from the back; no counter-drive.
- Lob: if the ball clears the taller opponent's reach (apex >= 3.4 m over their position) and lands in (z 4-6.7), they retreat; else smash (`overhead-smash`) -> `caught`.
- Ball into net, out: point lost, `error` type recorded (`net`/`long`).

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Arc preview for the chosen shot | full | full | half | none | none |
| Opponent positions shown with labels ("AT THE LINE"/"BACK") | yes | yes | no | no | no |
| Shot options | Drop, Drive | Drop, Drive | Drop, Drive, Lob | 3 | 3 |
| Aim | auto middle | 3 lanes | 3 lanes | 3 lanes | drag reticle |
| Aim noise (m) | 0 | 0.1 | 0.2 | 0.3 | 0.4 |
| Team advance speed (m/s) | 4.4 | 4.0 | 4.0 | 3.8 | 3.8 |
| Decision time limit (s) | none | none | 12 | 8 | 6 |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Scenario tags | `at-line` | `at-line`,`back` | + `mixed` | + `lob` | all |
- Default for `dbl-03`: 2. Level 1 is passable by a beginner: only Drop/Drive, opponent labels, auto aim, preview.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "pickleball.third-shot.drop-and-advance.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["third-shot-starter", "third-shot-reads", "third-shot-mixed"], "default": "third-shot-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "showRouteHints": { "type": "boolean", "default": true, "description": "Show opponent labels and arc preview (also gated by difficulty)." },
    "allowLob": { "type": ["boolean", "null"], "default": null },
    "decisionTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 3, "maximum": 30, "default": null },
    "controlScheme": { "type": "string", "enum": ["lanes", "reticle"], "default": "lanes" }
  }
}
```
Valid: `{ "seed": 11, "scenarioSetId": "third-shot-starter", "scenarioCount": 3 }`. Invalid -> `CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/third-shot-v1.json` (bundle `sim-pickleball-third-shot`). Deterministic per seed (order, mirroring x, aim noise).
- **N = 12 scenarios.** Shape:
```json
{ "scenarioId": "ts-s01", "returners": [{ "id": "opp1", "xz": [-1.0, 2.3] }, { "id": "opp2", "xz": [1.1, 2.3] }],
  "returnDepth": "deep", "youXZ": [-1.4, -6.5], "partnerXZ": [1.4, -6.4],
  "best": "drop", "acceptable": [], "poor": ["drive", "lob"], "teaches": "third-shot-drop", "tags": ["at-line"] }
```
- **Scenarios:**

| scenarioId | Setup | Best / acceptable / poor | Teaches | Tags |
|---|---|---|---|---|
| `ts-s01` | Both returners at the kitchen line (z=2.3), deep return. | Drop / none / Drive, Lob | `third-shot-drop` | at-line |
| `ts-s02` | Both returners still on their baseline (z=6.2). | Drive / Drop / Lob | `third-shot-drive` | back |
| `ts-s03` | One at the line (z=2.3), one back (z=5.5). | Drop (to the line player's feet side... any lane in kitchen) / Drive to the back player / Lob | `third-shot-drop`, `transition-zone` | mixed |
| `ts-s04` | Both at the line; return short and high (you are already at z=-4.4). | Drop / Drive (acceptable if you are already near line) / Lob | `advance-to-kitchen-line` | at-line |
| `ts-s05` | Both jammed close to the net (z=1.0), tall. | Lob / Drop / Drive | `lob` | lob |
| `ts-s06` | Both at the line; you are on the far left corner (x=-2.7). | Drop cross-court (middle lane) / Drop straight / Drive | `third-shot-drop` | at-line |
| `ts-s07` | One returner at the line (z=2.3), other stuck at midcourt (z=4.0, transition). | Drive at the midcourt player's feet / Drop / Lob | `transition-zone` | mixed |
| `ts-s08` | Both back, but they are noticeably slow to move up (`moveSpeed` 3.0 m/s). | Drop / Drive | `third-shot-drop` | back |
| `ts-s09` | Both at the line, aim decision: 2 of 3 lanes are sitting-duck lanes near the sideline (out risk). | Drop middle lane | `drop-shot` | at-line |
| `ts-s10` | One at the line, one left-handed backhand to your right. | Drop to the backhand side | `third-shot-drop` | mixed |
| `ts-s11` | Both at the line; partner already ahead at z=-3.2 (hurt or fast). | Drop | `advance-to-kitchen-line` | at-line |
| `ts-s12` | Both back, then one moves up during your shot (reaction test at L5). | Drop | `third-shot-drop` | back |
- Generation rule: vary returner z in {1.0, 2.3, 4.0, 5.5, 6.2}, return depth, lane count; `best` is drop if any returner z <= 4.2, drive if both >= 5.5, lob if both <= 1.2.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-drop-good` | Drop lands in kitchen; team reaches line | Timeline: flight 1.2 s vs advance 1.1 s; gold arc; team at line | Correct | Nice read. Time bought. | The arc gave you 1.2 seconds, and your team needed 1.1 to reach the line. That is the point of a drop: a soft ball that lands low so you can walk up. | "Great third-shot drop. Now they are stuck dinking." |
| `x-drive-caught` | Drive vs opponents at line; team mid-court | Transition zone hatched; drive path 0.6 s vs advance 1.1 s | Incorrect | Not quite. Caught midcourt. | The drive arrived in 0.6 seconds. Your team was still in the danger zone when they hit it back at your feet. Against players at the line, soften it. | "You get caught in no-man's land on a drive." |
| `x-drive-good` | Drive vs opponents back | Both back; drive path; no counter | Correct | Nice read. They were back. | They stayed on the baseline, so a firm drive is fine. They cannot attack from there. Read where they stand first, then choose. | "They stayed back, so the drive made sense." |
| `x-drop-back` | Drop vs opponents back (acceptable) | Timeline neutral | Correct (acceptable) | Fine, but read them. | A drop always works, but they were still back, so a drive was also on. Notice the difference for next time. | "They were back. I could have driven that." |
| `x-drop-net` | Drop into the net | Arc vs net | Incorrect | Not quite. Net first. | A drop is soft, but it still has to clear the net with a little margin. Add a bit more arc, not more power. | "The drop caught the net." |
| `x-drop-high` | Drop lands but bounces high (>= 0.914 m apex) | Second-bounce apex line above net height | Incorrect | Not quite. Sitting up. | The ball landed in, but it sat up above the net after the bounce. That is a ball they can attack. Lower and closer to the net is the goal. | "It popped up. Too high is attackable." |
| `x-drop-late` | Drop lands in but team did not reach the line | Timeline: advance 1.4 s vs flight 1.2 s | Incorrect | Not quite. Too slow up. | The shot was good, but your team was still mid-court when they hit. Start moving as soon as the ball leaves your paddle. | "Get moving the moment you drop it." |
| `x-lob-good` | Lob over jammed opponents | Apex over head; opponents retreat | Correct | Nice read. Over their heads. | They crowded the net, so the lob caught them out. A lob is a surprise, not a plan. Use it sparingly. | "I lobbed them because they were jammed up." |
| `x-lob-bad` | Lob into a smash | Opp overhead smash | Incorrect | Not quite. Smash time. | Too short and too low. It gave them a free overhead. A lob only works when it clears their reach and lands deep. | "Careful, a bad lob is a smash." |
| `x-timeout` | Decision timer expired | Auto-drop | Timeout | Time's up. Let's look. | The clock ran out, so we hit a drop. Look at where they stood, then decide. | "Read where they are, then hit." |

## 13. Scoring & mastery signals
- **Round points (0..1):** `0.5 * decisionScore + 0.5 * executionScore`.
  - `decisionScore`: best 1.0, acceptable 0.6, poor 0.0.
  - `executionScore`: drop = 0.4 lands in opp kitchen + 0.2 net clearance in [0.15, 1.2] m + 0.2 second-bounce apex < net height + 0.2 team reaches line before opponent contact; drive = 0.5 lands in + 0.5 not `caught` (team's mean z >= -2.8 or opponents back); lob = 0.5 lands in [z 4, 6.7] + 0.5 apex >= 3.4 m.
- **accuracy** = rounds with `decisionScore >= 0.6` / rounds. **Success for outcome** = points >= 0.7.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Drive against returners at the line | `third-shot-drive` | Drove into players at the kitchen line and got caught mid-court. |
| Drop into net / high pop | `third-shot-drop` | Third-shot drop was too flat or too high. |
| Team late to line | `advance-to-kitchen-line` | Did not start advancing after the third shot. |
| Caught in the zone | `transition-zone` | Left the team in the transition zone when the ball came back. |
| Bad lob | `lob` | Used a lob when it could be smashed. |
- **Mastery signals:** good drop vs at-line -> `third-shot-drop` +0.25; drive vs back -> `third-shot-drive` +0.20; reached line by contact -> `advance-to-kitchen-line` +0.20; avoided caught -> `transition-zone` +0.10; lob success -> `lob` +0.15; `drop-shot` +0.10 for in-kitchen landing; mistakes -0.15 to mapped concept; caps +-0.30/concept; hints halve positives (native).
- **Result mapping:** outcomes per round (`round-N`, `success`, `label`, `value` = chosen shot); `mistakes[]`, `masterySignals[]`.

## 14. XP & hearts
+10 per successful round (points >= 0.7), +40 finishing; native clamps. `heartsLost` 1 if accuracy < 0.34, max 1. `replayAvailable` true.

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain with timeline | outcome false, mistake | none |
| Failed session | "That one is a real skill. Watch the timeline once more." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto drop + explain | as above | none |
| Abort/backgrounded | native | `aborted`, xp 0 | none |
| Asset/config error | native error | `error` | none |

## 16. Accessibility
- **Reduced motion:** no camera sweeps (hard cuts); slow-mo replay replaced by a step-through of 4 stills; no shake.
- **Haptics:** honor `hapticsEnabled`.
- **Color-blind:** shot arcs use dash patterns (solid drop, dashed drive, dotted lob) plus labels; zones hatched; advance bars have numerals.
- **Text scale:** honored; the timeline card reflows.
- **Tap-only:** yes (lanes scheme).
- **VoiceOver:** Unity limited; native fallback `dbl-03-native` provided.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Choose shot | Soft tick | light tap |
| Hit | Paddle pop (soft for drop, sharp for drive) | soft tap |
| Bounce | Pop-tick | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
| Freeze | Low whoosh | soft tap |

## 18. Art & asset list
| Asset | Procedural | License | Budget |
|---|---|---|---|
| Court/net/zones | Procedural | `original-swoond` | < 2k tris |
| 4 characters | Procedural capsule figures | `original-swoond` | < 3k tris each |
| Ball/paddles | Procedural | `original-swoond` | < 500 tris |
| Timeline overlay | UI Toolkit/uGUI | n/a | n/a |
| Audio | Original foley/synth | `original-swoond` | <= 1 MB |
Bundle `sim-pickleball-third-shot`, <= 6 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md`; tighter: 4 characters + ball < 15k tris on screen; memory < 120 MB; cold launch < 2 s.

## 20. Telemetry
Standard diagnostics plus `hintsUsed`, `decisionLatencyMsMedian`, `shotsChosen` (counts), `timeoutCount`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 11, difficulty 2, 3 rounds -> exactly 3 outcomes, deterministic across runs.
2. **AC-2:** For each of 12 scenarios and each shot option, the evaluator returns the tabled `best`/`acceptable`/`poor` classification.
3. **AC-3:** Flight time of a default drop from baseline to the kitchen is in [1.0, 1.5] s and the default advance time from baseline to `z >= -2.35` at 4.0 m/s (incl. 0.25 s reaction) is in [1.1, 1.5] s, so a default good drop is `reached` (fixture).
4. **AC-4:** A default drive flight time is < 0.8 s and results in `caught` against at-line opponents (fixture).
5. **AC-5:** Second-bounce apex measurement classifies unattackable vs attackable against the 0.914 m net height (20 fixtures).
6. **AC-6:** `ready` < 2 s; exactly one schema-valid `result`; `requestExit` after.
7. **AC-7:** Pause/resume freezes physics and the decision timer; abort -> `aborted=true`, `xpEarned=0`.
8. **AC-8:** Copy lint (title <= 6 words, body <= 45 words) passes.
9. **AC-9:** Reduced-motion path has no camera sweeps; tap-only run completes.
10. **AC-10:** Invalid config -> `CONFIG_INVALID`.
11. **AC-11:** Perf p5 >= 50 fps, memory < 120 MB (iPhone 13-class).
12. **AC-12:** Mastery caps +-0.30 per concept.

## 22. Test plan
- **EditMode:** scenario classification, timing math, bounce apex, reaction rules, config validation, scoring, seed determinism, copy lint, result schema.
- **PlayMode:** scripted full run (tap-only), freeze/explain, pause/abort, reduced motion, colour-blind snapshot.
- **Perf:** iPhone 13-class.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_ThirdShot` |
| AC-2 | EditMode | `Scenario_Classification` |
| AC-3, AC-4 | EditMode | `Timing_DropVsDrive` |
| AC-5 | EditMode | `Bounce_Apex_Attackable` |
| AC-6, AC-7 | PlayMode | `Launch_Result`, `Pause_Abort` |
| AC-8 | EditMode | `Copy_Lint` |
| AC-9 | PlayMode | `ReducedMotion_TapOnly` |
| AC-10 | EditMode | `Config_Invalid` |
| AC-11 | Perf | `Perf_iPhone13` |
| AC-12 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Add `Court` module, env key, and `reach_zone_by_event` objective type. | Astra | Yes |
| 2 | Are opponent reaction rules (section 8) acceptable as scripted, or should they be data-driven per scenario? Proposed: data-driven parameters, scripted logic. | Astra | No |
| 3 | Tune numbers (flight 1.0-1.5 s, run 4.0 m/s) against real footage as a sanity check; educational clarity over realism. | Astra | No |
| 4 | Pro third-shot tendencies (more drives at the pro level): add a note in native `pro-05`, not here. | Claude | No |

### Game Kit additions requested
- `Court` module + `pickleball_court` env (shared).
- Objective registry entry `reach_zone_by_event` (zone, players[], deadlineEvent). Reuse: football pursuit timing, NASCAR pit-lane timing.
