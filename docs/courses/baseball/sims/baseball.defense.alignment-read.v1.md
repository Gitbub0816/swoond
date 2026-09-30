# Where Do They Stand? (`baseball.defense.alignment-read.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `baseball.defense.alignment-read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (alignments are data; outcomes are scripted per scenario) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `baseball`; `unitId` `the-defense`; `lessonId` `def-06` (also reused as a review item in `strat-05` at difficulty 3).
- CDS row: section 12, "`def-06`: Where do they stand?". Manifest: `unitySimulations[1]`.
- Prerequisite concepts (or the native primer `def-01` is shown first): `covering-bases`, `force-play`, `double-play`, `sacrifice-fly`, `position-numbers`, `defensive-shift`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can tell where the defense should stand for the situation: infield in to cut off a run, double-play depth to turn two, corners on the lines to stop doubles, and outfielders shallow or deep for the batter."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `infield-in` | Infield in | Say it trades a run cut-off at the plate for a higher chance of a hit through the drawn-in infield. |
| `double-play-depth` | Double-play depth | Say middle infielders shift toward second to turn two, conceding a run from third. |
| `no-doubles-defense` | No-doubles defense | Say late leads are protected by playing deep and toward the lines. |
| `guarding-the-line` | Guarding the line | Know corner infielders hug the foul lines late with a lead to stop doubles. |
| `outfield-depth` | Outfield depth | Choose shallow (cut a runner at the plate), deep (power hitter) or normal. |
| `shift-restrictions` | Alignment restrictions | Know two infielders must be on each side of second base with feet on the dirt when the pitch is released (2023 rule) [verify at release]. |
| `covering-bases` | Covering bases | Recognize who is where, before the ball is hit. |

- **Out of scope:** shifts in the pre-2023 sense (four infielders on one side), pitch-by-pitch defensive positioning by spray chart, and outfield shading beyond one preset.

## 4. Why Unity (tier justification)
- **Signals:** *spatial reasoning* (depth and angle on a field are a picture), *movement over time* (the ball goes where you did not stand), and *reading a dynamic scene* (batter handedness, outs, runners).
- **Closest native:** `hotspot-tap` on a static diagram (used in `game-04`, `mod-03`) and `decision-scenario` (a facts table plus "infield in?"). They teach the rule of thumb but cannot show why the same alignment is right in the 8th and wrong in the 3rd: the *cost* shows up when the ball finds the space you left.
- **Fallback:** native lesson `def-06-native`: 4 `decision-scenario` items (situation facts + best/acceptable/poor consequences) and 2 `hotspot-tap` items (tap where the third baseman stands at double-play depth).
- Justification: moderate-strong; propose native-only if playtests show the picture adds nothing.

## 5. Player fantasy & core loop
- **Fantasy:** "You are the manager with a whiteboard and one glance at the scoreboard. Set the defense and see if you were right."
- **Loop:**
  1. Intro: the situation card (inning, score, outs, runners, batter) and the field view.
  2. **Decision** (one decisive interaction): choose one alignment chip for the asked row (infield or outfield); the fielders slide to the preset.
  3. Execute: the scripted batted ball is hit; fielders resolve it under the oracle.
  4. Freeze at the play: distance rings and a zone overlay show why the ball found or missed the fielders.
  5. Explain: title, body, say-this; a ghost of the best alignment replays the same ball.
- **Session length:** about 3 minutes, 3 rounds.

## 6. Scene & entities
- **Environment:** `baseball_field`; cameras `broadcast-high-behind` (default), `top-down` (explain), `oblique-low` (execute close-up).
- **Coordinates:** feet; origin home plate; x third-to-first (negative to positive), y toward center; bases 90 ft (see the read-and-go spec, section 6).

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `field` | `BaseballField` | Environment | as above |
| `infield` | 4 x `Character` (muted, position numbers on jersey) | 1B, 2B, SS, 3B | positions from the preset table below |
| `outfield` | 3 x `Character` (muted) | LF, CF, RF | positions from the preset table |
| `pitcher`, `catcher` | `Character` | Fixed | mound (0, 60.5); catcher at plate |
| `batter` | `Character` | Handedness marker only | L or R |
| `runners` | `Character` (rose ring) | Baserunners in the scenario | bases from scenario |
| `ball` | `Ball` | Scripted batted ball | scripted path per `keyBall` (see section 11) |
| `presets` | `FormationSet` (GK-11) | Alignment data | table below |
| `chips` | `Target` x4 | Preset choices | 56 pt tall |
| `zones` | `ResponsibilityOverlay` (GK-14) | Draws each fielder's reach circle | reach: IF 20 ft, OF 35 ft (teaching values) |
| `rings` | `DistanceRing` (GK-13) | Distance from fielder to key bag or ball landing spot | feet |
| `drag` | `SlotPlacement` (GK-2) | Optional: drag fielders (difficulty 5) | 8 ft snap to preset, illegal-placement check |
| `explain`, `score`, `hints`, `replay`, `highlight` | as kit | | |

**Alignment presets (x, y in feet):**

| Row | Preset id | Positions |
|---|---|---|
| Infield | `normal` | 3B (-62, 78), SS (-28, 96), 2B (28, 96), 1B (62, 74) |
| Infield | `in` | 3B (-55, 58), SS (-25, 75), 2B (25, 75), 1B (55, 58) |
| Infield | `dp` (double-play depth) | 3B (-62, 80), SS (-20, 105), 2B (20, 105), 1B (62, 76) |
| Infield | `lines` | 3B (-70, 70), SS (-28, 96), 2B (28, 96), 1B (70, 70) |
| Outfield | `normal` | LF (-140, 245), CF (0, 270), RF (140, 245) |
| Outfield | `shallow` | LF (-120, 215), CF (0, 240), RF (120, 215) |
| Outfield | `deep` | LF (-150, 270), CF (0, 300), RF (150, 270) |
| Outfield | `nodoubles` | LF (-190, 250), CF (0, 290), RF (190, 250) |

- **New primitives:** `BaseballField` (shared with the other baseball sims). GK-2, GK-11, GK-13, GK-14 are reused as consolidated requests (GAME_KIT section 5). No new generic primitive.
- **Layout (top-down):**
```
              [LF]     [CF]     [RF]
        [3B]       [SS] [2B]       [1B]
                   pitcher
                     home
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose alignment | Tap | One of four chips (Infield: In / Double-play / Normal / Lines; Outfield: Shallow / Normal / Deep / No-doubles) | >= 56 x 90 pt | Fielders slide (0.6 s); chip outlined `accent` |
| Confirm | Tap "Play ball" | Primary button | 56 pt | Executes |
| Drag (difficulty 5) | Drag a fielder to a spot | Fielder | 44 pt | Snaps to preset within 8 ft; illegal spot shakes back (no shake under Reduce Motion: color flash) |
| Hint | Tap chip | Reveals the outs and runner cue, or the batter's tendency | 44 pt | Highlight |
- **Tap-only:** the four chips plus "Play ball". Portrait; chips at the bottom 30 percent.
- **Not in Unity:** hearts, paywall, exit confirmation.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config; build field; load scenarios | Ready/error | `ready` |
| Intro | ready | Situation card 1.5 s | Decision | `progress` |
| Decision | intro | Chips visible; optional timer; hints | Executing | none |
| Executing | Play ball | Scripted ball is hit; fielders resolve per the outcome table | Freeze at the play (or 2 s max) | none |
| Freeze | play resolved | Time freezes; `top-down`; rings and zones | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card; "Watch the best alignment" ghost replay | Next/Summary | `checkpoint round-N` |
| Summary | last round | Score, mistakes | Done | `progress 1.0` |
| Done | summary | `result` then `requestExit` | end | `result`, `requestExit` |
| Paused/Aborted | native | freeze timers; partial `result` `xpEarned 0` | | `result`, `requestExit` |

**Outcome oracle (deterministic):** each scenario carries a table `preset -> {result, runs, outs, class}`. The scripted ball is the same for every preset; only the fielders' positions change, and the ball path, timing and fielder reach determine the label. Illustration for the drawn-in infield: the scripted ball is hit hard but within reach of a fielder at the `in` preset, and it passes 10 ft beyond the reach circle of a fielder at `normal`, which is what the table encodes.

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Chips available per row | 2 | 3 | 4 | 4 | 4 (or drag) |
| Situation card shows a cue ("Runner on 3rd, 1 out: cut off the run?") | yes | yes | no | no | no |
| Reach circles shown during Decision | yes | yes | no | no | no |
| Decision time limit (s) | none | none | 15 | 10 | 8 |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Placement | chips | chips | chips | chips | drag with legal-placement check |
| Scenario tags | `core` | `core` | + `late-lead` | + `outfield` | all |
- Default for `def-06`: 2. Level 1 is passable by a beginner: two chips (In or Normal), cue text, reach circles.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "baseball.defense.alignment-read.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["al-infield", "al-outfield", "al-mixed"], "default": "al-mixed" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "placementMode": { "type": ["string", "null"], "enum": ["chips", "drag", null], "default": null, "description": "null uses the difficulty default." },
    "showReachCircles": { "type": ["boolean", "null"], "default": null },
    "decisionTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 3, "maximum": 30, "default": null }
  }
}
```
Valid example: `{ "seed": 7, "scenarioSetId": "al-mixed", "scenarioCount": 3 }`. Invalid configuration yields `CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/alignment-read-v1.json` (bundle `sim-baseball-alignment`). Deterministic per seed (order, left/right mirroring).
- **N = 12 scenarios.** Shape:
```json
{ "scenarioId": "al-s01", "row": "infield", "inning": "8th (tied)", "score": "0-0", "outs": 1,
  "runners": ["third"], "batter": { "hand": "R", "type": "contact" },
  "keyBall": { "type": "grounder", "toward": "SS", "speed": "hard" },
  "outcomes": { "in": { "result": "Out at the plate", "runs": 0, "class": "best" },
                 "normal": { "result": "Ground out; run scores", "runs": 1, "class": "poor" },
                 "dp": { "result": "Ground out; run scores", "runs": 1, "class": "poor" },
                 "lines": { "result": "Ground out; run scores", "runs": 1, "class": "poor" } },
  "teaches": ["infield-in", "sacrifice-fly"], "tags": ["core"] }
```
- **Scenarios:**

| scenarioId | Row | Situation | best | acceptable | poor | Teaches | Tags |
|---|---|---|---|---|---|---|---|
| `al-s01` | infield | 8th, tied 0-0, 1 out, runner on 3rd; hard grounder to SS | `in` (out at the plate) | none | `normal`, `dp`, `lines` (run scores) | `infield-in` | core |
| `al-s02` | infield | 1st inning, 0-0, 0 outs, runner on 1st; grounder to SS | `dp` (6-4-3 double play) | `normal` (one out, runner on 2nd) | `in`, `lines` | `double-play-depth` | core |
| `al-s03` | infield | Top 9th, home leads 3-2, 1 out, runner on 3rd; grounder to 3B | `in` (out at the plate; lead holds) | none | `normal`, `dp`, `lines` | `infield-in` | late-lead |
| `al-s04` | infield | 3rd inning, 0-0, 2 outs, runner on 3rd; hard grounder up the middle | `normal` (out at 1st ends the inning) | `dp` | `in` (hit through for a run), `lines` | `infield-in` | core |
| `al-s05` | infield | 7th, leading 7-1, 1 out, runner on 3rd; routine grounder to 2B | `normal` (take the out, give the run) | `dp` | `in`, `lines` | `double-play-depth` | core |
| `al-s06` | infield | Bottom 9th, tied, bases loaded, 1 out; grounder to SS | `in` (force at home) | `dp` (double play ends it) | `normal`, `lines` | `infield-in`, `force-play` | late-lead |
| `al-s07` | infield | Top 9th, home leads 4-3, 1 out, bases empty; pull lefty slugger; line drive down the 1B line | `lines` (1B stops it, single) | `normal` | `in`, `dp` (double into the corner) | `guarding-the-line`, `no-doubles-defense` | late-lead |
| `al-s08` | outfield | Bottom 9th, tied, runner on 2nd, 1 out; single to center | `shallow` (throw beats the runner) | none | `normal`, `deep`, `nodoubles` | `outfield-depth` | outfield |
| `al-s09` | outfield | Top 9th, home leads 4-3, 0 outs, bases empty; pull lefty; ball into the right-field gap | `nodoubles` (held to a single) | `deep` | `normal`, `shallow` (double or triple) | `no-doubles-defense` | late-lead |
| `al-s10` | outfield | 3rd inning, 0-0, 0 outs, bases empty, slugger; ball deep to left-center | `deep` (caught at the track) | none | `normal` (double), `shallow` (triple) | `outfield-depth` | outfield |
| `al-s11` | outfield | 5th inning, 0-0, 1 out, bases empty, slap hitter; bloop to short center | `shallow` (caught) | `normal` | `deep` (single) | `outfield-depth` | outfield |
| `al-s12` | outfield | Bottom 7th, home leads 3-1, 2 outs, runners on 1st and 2nd; ball to the left-field corner | `nodoubles` (single; only one runs) | `deep` | `normal`, `shallow` (both score) | `no-doubles-defense`, `covering-bases` | late-lead |

- The first three are written in full above (`al-s01` in JSON). The others are summarized with class and result; Astra fills the `outcomes` table for every preset using the class labels and a one-line result string. **Generation rule:** infield row: `in` best if `runner on 3rd` and `outs < 2` and (`inning >= 7` and `|score diff| <= 1`); `dp` best if `runner on 1st` and `outs < 2` and early or close; `normal` best if `outs == 2` or `lead >= 4`; `lines` best if `inning >= 8` and `lead <= 2` and a pull power hitter. Outfield row: `shallow` best if `runner on 2nd or 3rd` and `winning run` and singles are the threat; `deep` or `nodoubles` best with a power hitter or late lead.
- **Numbers are teaching values, not tracking data.** Reach circles and outcome tables are non-normative until SME review [verify].

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body (<= 45 words) | Say this |
|---|---|---|---|---|---|---|
| `x-in-good` | `in` chosen and best | Runner out at the plate; ring shows the throw shorter than the run | Correct | Nice read. Run cut off. | Runner on third, less than two outs, late in a close game: bring the infield in. The fielder throws home before the runner gets there. The price is more hits through the middle. | "They have the infield in, so the run can't score on a grounder." |
| `x-in-through` | `in` chosen when poor | Ball passes the drawn-in fielder; reach circle shown | Incorrect | Not quite. Ball got through. | Playing in is a gamble: hard grounders that a normal infield turns into outs sneak by. With two outs, or early with a lead, the run is not worth that risk. | "They played in and it got through, so the price was a run." |
| `x-normal-conceded` | `normal` chosen when `in` is best | Run scores while the out is made at first | Incorrect | Not quite. Run scored. | They took the out and gave up the run. That is fine early or with a big lead, but tied in the eighth every run matters. Bring the infield in. | "The run scored on a ground out; a drawn-in infield saves it." |
| `x-dp-good` | `dp` chosen when best | 6-4-3, two outs | Correct | Nice read. Two for one. | With a runner on first and fewer than two outs, the middle infielders cheat toward second so the throw is short. A double play erases the runner and the threat. | "6-4-3, that's a double play." |
| `x-lines-good` | `lines` when best | Single instead of a double | Correct | Nice read. Line held. | Late with a small lead, the corners guard the lines so a hard pull shot cannot become a double. It concedes the middle, which is the trade. | "The corners on the line, no-doubles defense." |
| `x-shallow-good` | `shallow` when best | Throw beats the runner at the plate | Correct | Nice read. Throw wins. | With the winning run on second, the outfield plays shallow so a single can be cut down at the plate. The risk is a ball over their heads. | "They're playing shallow because a single wins it." |
| `x-deep-good` | `deep` / `nodoubles` when best | Ball caught or held to a single | Correct | Nice read. Nothing over the top. | A power bat, or a late lead, means the outfield backs up so nothing gets over their heads or into the corners. A single is fine; a double is not. | "Playing deep, no doubles." |
| `x-shallow-over` | `shallow` when poor | Ball sails over | Incorrect | Not quite. Over their heads. | A shallow outfield turns power into triples. Use it only when a single would lose the game and the batter cannot drive it deep. | "Too shallow, it went over their heads." |
| `x-illegal` | Drag mode illegal placement | Ghost of the legal spot | Info | That spot is not allowed. | Since 2023, two infielders must stand on each side of second base and all four must have their feet on the infield dirt when the pitch is released. | "They can't shift like they used to." |
| `x-timeout` | Timer expired | Auto `normal` | Timeout | Time's up. Let's look. | The clock ran out, so the defense stayed normal. Read the outs and the score first, then choose. | "Look at the outs and the score." |

## 13. Scoring & mastery signals
- **Round points (0..1):** `decisionScore` (best 1.0, acceptable 0.6, poor 0.0). Legal-placement violation in drag mode counts as no choice (retry, -0.1 once).
- **accuracy** = rounds with `decisionScore >= 0.6` divided by rounds. **Outcome id** `round-N`, success if points >= 0.6, `label` = chosen preset.
- **Mistake -> conceptId:**

| Mistake | conceptId | Description |
|---|---|---|
| `normal` or `dp` with a runner on third, less than two outs, late and close | `infield-in` | Did not bring the infield in to cut the run. |
| `in` with two outs or a big lead | `infield-in` | Played in when the run was not worth the risk. |
| `normal` or `in` with a runner on first and fewer than two outs early | `double-play-depth` | Missed the chance to turn two. |
| `normal` late with a small lead and a pull power hitter | `no-doubles-defense` | Left the lines open. |
| `shallow` versus a power hitter | `outfield-depth` | Played shallow into a ball over their heads. |
| Illegal drag placement | `shift-restrictions` | Placed fielders outside the alignment rules. |
- **Mastery signals:** correct row decision -> primary concept +0.20 (`infield-in`, `double-play-depth`, `no-doubles-defense`, `outfield-depth`); correct `lines` -> `guarding-the-line` +0.20; correct legal placement in drag mode -> `shift-restrictions` +0.15; mistakes -0.15; per-concept per-session cap +-0.30; hints halve positives.
- **Result mapping:** `outcomes[]` per round, `mistakes[]`, `masterySignals[]`, `score` 0-100 = mean(points) x 100.

## 14. XP & hearts
+10 per successful round (points >= 0.6), +40 finishing; native clamps. `heartsLost` 1 if accuracy < 0.34, max 1. `replayAvailable` true.

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain with the best-alignment ghost | success false, mistake | none |
| Failed session | "Positioning is a picture, not a rule. Watch the ghost once more." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto `normal` then explain | timeout label | none |
| Abort/backgrounded | Native handles; partial result | `aborted`, `xpEarned 0` | none |
| Asset/config error | Native error sheet | `error` | none |

## 16. Accessibility
- **Reduced motion:** fielders cut to the preset (no sliding); ghost replay replaced by two stills (chosen vs best); no shake (illegal placement uses a color flash and a text line).
- **Haptics:** honor `hapticsEnabled`. **Color-blind:** reach circles are hatched and numbered; preset chips carry a text label plus a small icon; the best-alignment ghost is dashed.
- **Text scale:** honored. **Tap-only:** yes (chips).
- **VoiceOver/TalkBack:** Unity content is limited; native fallback `def-06-native` (decision-scenario with the field described in the facts table: "Infield: normal. Runner on third, 1 out, tied, 8th").

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Choose chip | Soft tick | light tap |
| Bat crack | Synth crack | none |
| Fielded / out | Glove pop | soft tap |
| Safe/run scores | Low crowd rise | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |

## 18. Art & asset list
| Asset | Procedural or external | License | Budget |
|---|---|---|---|
| Field, mound, bases, warning track | Procedural | `original-swoond` | < 3k tris |
| 9 fielders + batter + runners | Procedural capsule figures | `original-swoond` | < 2.5k tris each |
| Ball | Procedural | `original-swoond` | < 500 tris |
| Overlays (reach circles, rings, chips) | Unity UI | `original-swoond` | n/a |
| Audio | Synthesised | `original-swoond` | <= 1.5 MB |
Addressables bundle `sim-baseball-alignment`, <= 6 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md`; tighter: 14 characters + ball < 30k tris; memory < 130 MB; cold launch < 2 s.

## 20. Telemetry
Standard diagnostics plus `hintsUsed`, `decisionLatencyMsMedian`, `presetChosenCounts`, `illegalPlacements`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 7, difficulty 2, 3 rounds: exactly 3 `outcomes`, identical across runs.
2. **AC-2:** For each of the 12 scenarios and each preset the outcome table returns the class listed above (fixture).
3. **AC-3:** Every preset in section 6 satisfies the legal-placement rule (two infielders on each side of second, all inside the infield dirt line) in an EditMode test; an illegal drag position is rejected.
4. **AC-4:** `ready` within 2 s; exactly one schema-valid `result`; `requestExit` follows.
5. **AC-5:** Pause freezes physics and timers; abort yields `aborted=true`, `xpEarned=0`.
6. **AC-6:** Explain copy: title <= 6 words, body <= 45 words for every id in section 12.
7. **AC-7:** Reduced-motion path has no fielder sliding; a tap-only run completes.
8. **AC-8:** Invalid configuration yields `CONFIG_INVALID`.
9. **AC-9:** Perf p5 >= 50 fps and memory < 130 MB on iPhone 13-class.
10. **AC-10:** Mastery signals capped at +-0.30 per concept per session.
11. **AC-11:** The generation rule of section 11 reproduces the `best` class of the 12 scenarios.

## 22. Test plan
- **EditMode:** preset legality, outcome table, generation rule, config validation, scoring, determinism by seed, copy lint, result schema.
- **PlayMode:** scene builds from code, tap-only full run, freeze/explain, pause/abort, reduced motion, drag-mode legality flash.
- **Perf:** iPhone 13-class.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Alignment` |
| AC-2, AC-11 | EditMode | `Outcome_Table_Fixture`, `Generation_Rule` |
| AC-3 | EditMode | `Preset_Legality` |
| AC-4, AC-5 | PlayMode | `Launch_Result`, `Pause_Abort` |
| AC-6 | EditMode | `Copy_Lint` |
| AC-7 | PlayMode | `ReducedMotion_TapOnly` |
| AC-8 | EditMode | `Config_Invalid` |
| AC-9 | Perf | `Perf_iPhone13` |
| AC-10 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Add `BaseballField` and `baseball_field`; confirm GK-2, GK-11, GK-13, GK-14 land first (they are also requested by basketball, hockey, soccer). | Astra | Yes |
| 2 | SME review of the preset positions and the outcome tables (especially `in` versus `normal` trade-offs). | Product / SME | Yes for `spec-approved` |
| 3 | Confirm the 2023 alignment rule wording (two infielders each side of second, feet on the infield dirt) and that no 2026 change alters it. | Content | Before release |
| 4 | Should `outfield` and `infield` rows be one scenario with two decisions at difficulty 5? Current spec keeps one row per scenario. | Claude | No |

### Game Kit additions requested
- `BaseballField` module and `baseball_field` environment key (shared).
- `FormationSet` data for baseball alignments (GK-11); `SlotPlacement` legal-position callback (GK-2 extension: `IsLegal(position)` predicate, reusable by hockey line changes and pickleball court coverage).
- `ResponsibilityOverlay` reach-circle style (GK-14) and `DistanceRing` (GK-13) reused.
