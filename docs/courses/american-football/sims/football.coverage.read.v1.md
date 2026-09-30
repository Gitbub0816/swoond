# Coverage Read (`football.coverage.read.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `football.coverage.read.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition not used (scenario-data driven, see section 11) |
| Authors / date | Claude Code (content agent) / 2026-09-30 |
| Changelog | 1.0.0: first spec |

## 2. Course & lesson links
- `courseId`: `american-football`.
- Launched from: unit `defense-basics`, lesson `coverage-04` (default difficulty 2); unit `scheme-literacy`, lesson `motion-tells-04` (difficulty 3, `scenarioSetId: coverage-read-motion`); unit `always-on-review`, lesson `sim-refresh-03` (difficulty 3, mixed set). Matches the existing bridge examples `docs/contracts/unity-bridge/v1/examples/football-coverage-read-launch.json` and `...-result.json`.
- CDS Interaction plan rows: "Coverage read (Unity)" (CDS section 12, row U1).
- Manifest entry: `docs/courses/american-football/manifest.json` -> `unitySimulations[]` (`football.coverage.read.v1`).
- Prerequisites (must be `mastered`, else the lesson shows a native primer): `downs`, `quarterback`, `secondary`, `man-coverage`, `zone-coverage`.
- Native accessibility fallback lesson: `coverage-04-fallback` (hotspot-tap + decision-scenario over still frames of the same scenarios; authored separately, not a port).

## 3. Learning objective(s) & concepts taught
- Learner-facing objective: "You can look at a defense, tell whether it is man or zone (and which zone), and find the receiver who is open because of it."

| conceptId | term | After this the learner can... |
|---|---|---|
| `zone-vs-man` | Zone versus man | Say whether defenders are chasing people or guarding areas, using the safeties, motion and how corners react. |
| `man-coverage` | Man coverage | Spot man from motion (a defender follows) and find crossing routes and mismatches. |
| `zone-coverage` | Zone coverage | Find the soft spot between zones. |
| `cover-2` | Cover 2 | Recognize two deep safeties and attack the sideline hole behind the squatting corner. |
| `cover-3` | Cover 3 | Recognize three deep defenders and attack the curl/flat with a defender in conflict. |
| `cover-4` | Cover 4 | Recognize four deep defenders and take the underneath throw. |
| `cover-1` | Cover 1 | Spot one deep safety with man underneath and find a mismatch. |
| `cover-0` | Cover 0 | Spot no deep safety (blitz coming) and throw the quick answer. |
| `pre-snap-motion` | Pre-snap motion | Use motion to diagnose coverage. |
| `disguise` | Disguise | Notice a safety rotating after the snap. |
| `single-high-shell` / `two-high-shell` | Shell | Say how many deep safeties show pre-snap. |

Scope limits: no passing accuracy, no pass rush timing (see `football.protection.pressure.v1`), no throw arcs (see `football.passing.window.v1`), no penalties, no play calling from the sideline. The learner never needs to memorize a playbook.

## 4. Why Unity (tier justification)
- **Spatial reasoning and movement over time (yes).** The whole skill is watching 11 defenders move after the snap and seeing who is open. Man versus zone is invisible in a still frame: a zone defender drifts to a landmark, a man defender mirrors a receiver. Motion before the snap ("does the corner follow him?") is a timing-in-a-scene tell.
- **Camera perspective (yes).** Learners see the behind-the-quarterback view first (what a QB sees), then a top-down freeze with zone overlays (what an analyst sees). The contrast is the lesson.
- **Native alternative:** `hotspot-tap` on a static formation diagram (used in `shells-03`) teaches shell recognition; `binary-call` teaches "man or zone" from a diagram. Both teach the label, not the read. A native exercise cannot show why the flat defender is stuck, and a fake animation would be a worse version of this sim. Justification is strong; Unity is warranted.

## 5. Player fantasy & core loop
- Fantasy: "You are the quarterback with one second to read the defense."
- Loop (3 rounds, about 3 minutes):
  1. **Prompt**: situation card ("3rd and 7, your ball at midfield") and the pre-snap picture from behind the QB. Motion may run.
  2. **Snap**: learner taps Snap (or the play auto-snaps after 5 s at difficulty >= 3). Routes and coverage run for 1.4-2.2 s.
  3. **One decisive interaction**: time slows to 5 percent (DecisionPoint). At difficulty >= 3, first tap the coverage chip, then tap the receiver you would throw to. At difficulty 1-2, only the receiver.
  4. **Execute**: the ball is thrown (Ball.Throw) and the play finishes in slow motion.
  5. **Freeze / explain**: top-down camera, coverage zones drawn, the open receiver highlighted gold, a two-line explanation and a "say this" line.
  6. **Say-this line**: quotable sentence for the learner to say out loud.

## 6. Scene & entities
- Environment: `football_field` (procedural, one end zone visible from the 30 to 60-yard range). Camera presets: `behind-qb-high` (play), `top-down` (explain and replay), `broadcast-side` (replay optional).
- Portrait orientation. Field shown 40 yards wide, 30 yards deep from the line of scrimmage.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `qb` | `Quarterback` (extends Character) | player-stand-in | shotgun (0,-5) yd, or under center (0,-1) |
| `ol_1..5` | `Character` | blockers (static pocket, no rush in this sim) | (-3..3, 0); hold blocks for 3.0 s then idle |
| `rb` | `Receiver` | eligible | alignment per scenario |
| `wr_x`, `wr_z`, `wr_slot` | `Receiver` | eligible | alignment and `Route` per scenario |
| `te` | `Receiver` | eligible | alignment and `Route` per scenario |
| `dl_1..4` | `Defender` | pass rush (visual only, no pressure) | 4-man rush or fewer at blitz rounds |
| `lb_1..3` | `Defender` | zone or man per `Coverage` | assignments in scenario data |
| `cb_l`, `cb_r`, `s_1`, `s_2` | `Defender` | deep and outside | shell from scenario, rotates when `disguise` |
| `ball` | `Ball` | thrown ball | arc 2.5-6 yd, flight 0.5-1.1 s |
| `zone_*` | `Zone` | coverage zone overlay | shown on explain, hatched pattern |
| `target_*` | `Target` | selectable receivers | ring >= 44 pt, pulses at 1 Hz |
| `decision` | `DecisionPoint` | one decision | optional time limit |
| `expl` | `Explanation` + `Highlight` | freeze copy | see section 12 |

Reused: everything above is an existing Game Kit primitive or `Swoond.Sports.Football` module (`Formation`, `Route`, `Coverage`, `Pass`, `Receiver`, `Quarterback`, `Defender`, `Down`). New primitives: none.

Layout at snap (ASCII, offense faces up the page; `O` offense, `D` defender, `Q` quarterback):
```
        S          S             <- two-high shell shown
   CB                      CB
        LB    LB   LB
 D   D  D   D                    <- front (4 rushers)
 X      T  G  C  G  T  Y   Z
                 Q
                 RB
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Snap | Tap the Snap pill (bottom center) | Start play | 56 pt high, full width minus 32 pt | soft tap haptic, snap sound |
| Coverage call (diff >= 3) | Tap one of 3-4 chips (Man, Cover 2, Cover 3, Cover 4 ...) | Chip row above safe area | 44 pt high | chip fills rose, light haptic |
| Pick receiver | Tap a receiver ring | `Target` | ring radius >= 44 pt on screen (Unity scales to touch size, not world size) | ring turns rose, ball thrown |
| Hint | Tap "Show me" (top right) | Shows zone overlay for 2 s | 44 pt | counts as a hint |
| Replay | Tap "Watch again" during Explain | `Replay` | 44 pt | slow-mo replay from top-down |

Tap-only scheme is the default; no drag or swipe. Safe areas from `runtime.safeAreaInsets`. Portrait only. Not drawn by Unity: hearts, paywall, exit confirmation, XP animation (native draws these; Unity emits `requestExit` when the learner taps the close affordance drawn by native overlay).

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate config, build field, place 22 characters, load scenarios | ready to show intro | `ready` (loadTimeMs) |
| Intro | Loading done | Situation card slides in (250 ms), formation visible, motion runs if scenario has it | learner taps Snap (or auto 5 s at diff >= 3) | `progress` 0 |
| Playing | Snap | Routes and coverage execute for 1.4-2.2 s (deterministic) | reaches read frame | none |
| Decision | Read frame | SlowMotion to 0.05, targets ring, coverage chips appear, optional timer | tap chosen (or timer ends) | none |
| Executing | Decision recorded | Ball thrown, slow-mo release to 0.5x, catch or breakup shown | ball resolves | none |
| Freeze | Ball resolves | SlowMotion.Freeze, camera to `top-down` (cut if reduced motion) | 400 ms | none |
| Explain | Freeze | Zones drawn, open receiver gold, copy card, say-this line | learner taps Continue | `checkpoint` (round id) |
| Next round | Continue | Reset scenario | Playing/Intro or Summary after last round | `progress` k/3 |
| Summary | Rounds done | Score card, per-round outcomes, "watch again" | tap Done | none |
| Done | Done tapped | Emit result | end | `result`, then `requestExit` (completed) |
| Paused | native `pause` | Freeze sim time, timers, audio | `resume` | none |
| Aborted | native `abort` or user quit | Emit result with `aborted=true`, partial outcomes, xpEarned 0 | end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Coverage pool | cover-2, cover-3 | cover-2, cover-3, man | + cover-4 | + cover-1, cover-0 | all |
| Eligible receivers | 3 | 3 | 4 | 4 | 5 |
| Coverage call step | off | off | on | on | on |
| Shell + zones auto-shown pre-snap | on | off (hint) | off | off | off |
| Hint budget (per session) | 3 | 2 | 1 | 1 | 0 |
| Decision time limit | none | none | 12 s | 8 s | 6 s |
| Pre-snap motion scenarios | 0 percent | 0 | 33 percent | 50 percent | 50 percent |
| Disguise scenarios | 0 | 0 | 0 | 33 percent | 50 percent |
| Auto-snap delay | none | none | 5 s | 5 s | 3 s |
| Route hints (route lines drawn pre-snap) | on | on | off | off | off |
| Scenario pool tags | `starter` | `starter` | `starter`,`motion` | `motion`,`disguise` | all |

Level 1 is passable by a true beginner: the shell and zones are drawn, only two coverages, the receiver ring hints are present, no timer. Lesson defaults: `coverage-04` = 2; `motion-tells-04` = 3; `sim-refresh-03` = 3.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "football.coverage.read.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0 },
    "scenarioSetId": { "type": "string", "enum": ["coverage-read-starter", "coverage-read-motion", "coverage-read-mixed"], "default": "coverage-read-starter" },
    "scenarioCount": { "type": "integer", "minimum": 1, "maximum": 5, "default": 3 },
    "down": { "type": "integer", "minimum": 1, "maximum": 4, "description": "Overrides the scenario's down (situation card only)." },
    "yardsToGo": { "type": "integer", "minimum": 1, "maximum": 20 },
    "showRouteHints": { "type": "boolean", "default": true },
    "coverageFamilies": {
      "type": "array", "uniqueItems": true, "minItems": 1,
      "items": { "type": "string", "enum": ["man", "cover-0", "cover-1", "cover-2", "cover-3", "cover-4"] },
      "description": "Pool filter. Defaults from difficulty (section 9)."
    },
    "enableCoverageCall": { "type": "boolean", "description": "Default by difficulty: on for >= 3." },
    "decisionTimeLimitSec": { "type": ["number", "null"], "minimum": 3, "maximum": 30, "description": "Null = no limit." },
    "allowMotion": { "type": "boolean" },
    "allowDisguise": { "type": "boolean" },
    "hintBudget": { "type": "integer", "minimum": 0, "maximum": 5 }
  }
}
```
Valid example (the shipped bridge example):
```json
{ "down": 3, "yardsToGo": 7, "scenarioSetId": "coverage-read-starter", "scenarioCount": 3, "showRouteHints": true, "coverageFamilies": ["cover-2", "cover-3", "man"] }
```
Invalid values (for example `scenarioCount: 9`) yield `error CONFIG_INVALID` (recoverable=false). `seed` absent means Unity derives the seed from `sessionId`.

## 11. Scenario data set
Format: `Assets/Sims/Football/Coverage/scenarios/<scenarioSetId>.json`, array of scenario objects. **Minimum count: 18** (three sets of 6; rounds x 3 minimum is 9). Shipped: `coverage-read-starter` 6 (`starter`), `coverage-read-motion` 6 (`motion`), `coverage-read-mixed` 6 (`disguise`, hard). Selection: seeded shuffle without replacement, filtered by `coverageFamilies` and difficulty tags, never two consecutive rounds of the same coverage. Deterministic per seed. Coordinates: x lateral yards (negative = left), y yards downfield from the line of scrimmage.

Schema per scenario (abbreviated): `{id, down, yardsToGo, ballOn, offense:{personnel, alignments{id:[x,y]}, routes{id:[spec]}, motion?}, defense:{shellPre, coverage, postSnapShell, alignments{id:[x,y]}, assignments{id:...}}, readTimeSec, correctTargetIds[], acceptableTargetIds[], coverageCallCorrect, conceptId, tags[], explainKey}`.

| scenarioId | Setup | Correct decision | conceptId | Tags |
|---|---|---|---|---|
| `cr-01-cover3-curlflat` | 3rd and 7, own 45. 11 personnel, trips right: TE curl (10 yd), RB flat, WR deep go. Single-high (S at 0,13). Cover 3. The flat defender (`lb_3` at 6,5) widens to the RB. | `te` (curl at 9 yd, separation 3.1 yd). Coverage call: Cover 3. | `cover-3` | starter |
| `cr-02-cover2-corner` | 2nd and 9, opp 38. Two-high (S at -9,12 and 9,12). Slot runs a corner route to the right (breaks at 12 yd toward the sideline). CB squats at (15,5). | `wr_slot` (corner route lands outside safety's half, separation 3.4 yd). Coverage: Cover 2. | `cover-2` | starter |
| `cr-03-man-cross` | 3rd and 5, own 30. Motion: `wr_slot` goes across pre-snap and the CB (`cb_l`) follows him. Man (Cover 1). Two crossing routes (mesh) at 5 yd. | `wr_slot` off the mesh after the rub, separation 2.6 yd. Coverage call: Man. | `man-coverage` | starter, motion |
| `cr-04-cover4-flat` | 1st and 10, own 25. Two-high shell but the safeties read the run and stay deep, corners bail. Quarters. Flat route by RB, curl by TE. | `rb` in the flat (nearest defender 5.4 yd). Coverage: Cover 4. | `cover-4` | starter |
| `cr-05-cover1-wheel` | 2nd and 6, opp 30. Single-high (S at 0,13), press corners, `lb_1` covering `rb`. RB runs a wheel route up the right sideline. | `rb` (LB is 4 yd behind). Coverage: Cover 1. | `cover-1` | starter |
| `cr-06-cover0-slant` | 3rd and 4, opp 12. No safeties; `s_1`, `s_2` and `lb_1` walk up and blitz (6 rushers). Slot runs a quick slant against press man. | `wr_slot` (slant, throw in 0.8 s). Coverage: Cover 0. | `cover-0` | starter |

First three, fully written (coordinates in yards):
- **cr-01**: offense `qb(0,-5)`, `rb(2,-5)`, `te(5,0)`, `wr_z(16,0)`, `wr_slot(-7,-1)`, `wr_x(-15,0)`. Routes: `te: curl [ [5,9], [5,8] ]`, `rb: flat [ [8,-1], [14,1] ]`, `wr_z: go [ [16,25] ]`, `wr_x: go`, `wr_slot: seam [ [-7,20] ]`. Defense: `cb_l(-15,7)`, `cb_r(15,7)`, `s_1(0,13)`, `s_2(9,5)` (strong safety in the flat), `lb_1(-5,4)`, `lb_2(0,4)`, `lb_3(5,4)`. Post-snap: `cb_l`, `s_1`, `cb_r` drop to deep thirds at y=17 (x=-17,0,17); `lb_1` hook (-7,9); `lb_2` hook (0,8); `lb_3` hook right (5,9); `s_2` flat right (12,3), widening to `rb` at t=1.2 s. Read frame at t=1.7 s: `te` at (5.4,9.1), nearest defender `lb_3` at (7.5,7.8) moving away, separation 3.1 yd. Explain key `cover3-curlflat`.
- **cr-02**: `qb(0,-5)`, `rb(0,-7)`, `te(5,0)`, `wr_x(-14,0)`, `wr_z(15,0)`, `wr_slot(9,-1)`. Routes: `wr_slot: corner [ [9,12], [17,16] ]`, `wr_z: hitch [ [15,6] ]`, `te: seam [ [5,18] ]`, `wr_x: go`, `rb: swing`. Defense two-high: `s_1(-9,12)`, `s_2(9,12)`, `cb_l(-14,6)`, `cb_r(15,6)`; post-snap `cb_r` squats to flat (17,4) (hitch), `s_2` drops to half (9,15) and reads `te` seam, `lb_*` hooks. Read frame 1.9 s: `wr_slot` at (13.6,13.5), `s_2` at (8.2,15.8) (bound by the seam), separation 3.4 yd. Explain key `cover2-corner`.
- **cr-03**: motion `wr_slot` (-7,-1) to (7,-1) over 1.2 s pre-snap; `cb_l` mirrors across the formation (shown as a 1.0 s lateral run). This is the man tell. Mesh routes: `wr_slot: cross [ [3,5],[-8,6] ]`, `te: cross [ [2,4],[12,5] ]` passing 1.5 yd apart at t=1.0 s. Defenders: `cb_l` follows slot, `lb_2` follows TE; the two collide at the mesh point at t=1.05 s (rub). Read frame 1.6 s: `wr_slot` at (-6,5.6), `cb_l` at (-3.6,4.9) trailing by 2.6 yd. Single safety at (0,13). Explain key `man-cross-motion`.

Scenarios 04 to 06 follow the same schema with the alignment and routes summarized in the table; scenarios 07 to 12 (`coverage-read-motion`): jet motion versus zone (no defender follows, correct target is the void curl), motion to expose a corner blitz, a two-back motion tell, a bunch formation versus man (defender switch), a trips formation versus Cover 3 buzz, motion to check for Cover 2 versus Cover 3 (the safety rotation). Scenarios 13 to 18 (`coverage-read-mixed`): Cover 2 disguised as Cover 4 and back, single-high rotating to two-high, two-high rotating to Cover 3 (the middle is now taken, so the sideline is open), fire-zone blitz (three-deep, three-under, five rushers) and quick game, Tampa 2 middle-linebacker carry, and Cover 6 (quarter-quarter-half) picks. Generation rule: each scenario must compute `correctTargetIds` via the deterministic `OpenReceiver` evaluation (section 13) and a designer sign-off that only one clear best target exists (best separation lead >= 1.2 yd over the second best). Deterministic per seed for scenario order; motion and defender timings are fixed in the scenario data.

## 12. Freeze / explain moments
Trigger: after every round. Freeze: the play at the ball's arrival. Camera: cut or blend (400 ms) to `top-down`. Callouts: zones drawn as hatched `rewardTint` fills labelled (for example "deep third"), open receiver ring in gold, defender who is stuck in `accentTint` with an arrow to his two responsibilities. Every explanation card: Title (<= 6 words), body (<= 45 words), say-this line in serif quotes.

| explainKey | Outcome | Title | Body | Say this |
|---|---|---|---|---|
| `cover3-curlflat` | correct | Three deep. Curl is open. | Cover 3 drops three players deep, so the flat defender has to pick between two routes. He chased the runner and the curl sat down behind him. Nice read. | "They're in three-deep, so the curl-flat is going to hurt them." |
| `cover3-curlflat` | incorrect | Look underneath, not deep. | Three defenders guard the deep thirds, so going deep is walking into traffic. The weakness is underneath: one flat defender, two routes. Try again next snap. | "Three-deep leaves the short stuff open." |
| `cover2-corner` | correct | Two safeties. Corner beats them. | Cover 2 splits the deep field into halves and squats the corners short. A corner route bends into the space behind the corner and outside the safety. You found the hole. | "In Cover 2 the hole is behind the corner." |
| `cover2-corner` | incorrect | Close. That safety had it. | The safety covers the whole deep half, so anything up the middle gets there late. The soft spot is out by the sideline behind the squatting corner. Worth a rewatch. | "Two-high is soft on the outside." |
| `man-cross-motion` | correct | He followed. That is man. | When a defender chases a receiver across the formation, no one is guarding an area. Crossing routes then cause traffic jams and one defender gets picked. That is your target. | "The corner followed him across, so it's man." |
| `man-cross-motion` | incorrect | Motion told you the answer. | The corner shadowed the motion man, so he is guarding a person, not a place. Man defenses lose to crossers and rubs, not to deep balls over the top. | "If he follows the motion, it's man." |
| `cover4-flat` | correct | Four deep, flat is free. | Quarters puts four defenders deep, and nobody is left to cover the short area on the sideline. The back in the flat has room. Take it. Small gains add up. | "Quarters gives you the underneath." |
| `cover4-flat` | incorrect | Four deep is a wall. | With four defenders sitting deep, anything downfield is crowded. The cheap yards are in the flat, where the defense has nobody. Patience wins here. | "Against quarters, check it down." |
| `cover1-wheel` | correct | One safety. Mismatch found. | With one deep safety and man everywhere else, a running back on a linebacker is a speed mismatch. The wheel route runs past him. Good spot. | "Single-high with man? Attack the linebacker." |
| `cover1-wheel` | incorrect | Find the mismatch. | Man coverage means each receiver has his own defender. The best matchup is the one where the defender is slower than the runner. That was the back on the linebacker. | "In man, look for the slowest defender." |
| `cover0-slant` | correct | No safety. Throw it fast. | Cover 0 has no deep help and sends extra rushers. The answer is a quick throw before they arrive. Slant, now. You beat the blitz. | "Cover 0 means one quick slant and it's a house call." |
| `cover0-slant` | incorrect | Too slow. Pressure is coming. | Without a safety, a blitz has a fast route to the quarterback. Deep routes need time you do not have. Quick throws win against Cover 0. | "Beat Cover 0 with speed and a slant." |
| `disguise-rotate` | correct | Same picture. Different play. | Both safeties showed, then one dropped into the middle after the snap. You read the rotation and took the space it left open. That is what pros call disguise. | "They showed two-high and rotated. Sneaky." |
| `disguise-rotate` | incorrect | They changed it on you. | The defense showed two safeties but rotated after the snap, so the pre-snap picture lied. Watch what they do after the ball moves, not just before. | "Don't trust the shell until after the snap." |
| `coverage-call-correct` | (chip correct) | Nice call. | Naming the shell is the hardest part. | none |
| `coverage-call-wrong` | (chip wrong) | Not that one. | Count the deep defenders: two, three or four? Then check who follows the motion. | none |
| `timeout` | timer ended | The rush got there. | Pressure arrived before you chose. Trust your first read next time. | none |

## 13. Scoring & mastery signals
- Per-round score: level 1-2: 100 if `correctTargetIds`, 60 if `acceptableTargetIds`, else 0. Level >= 3: 60 (target) + 40 (coverage call). Hint penalty: -10 per hint used in that round (floor 0). Session `score` = round(mean of round scores). `accuracy` = rounds whose target was correct or acceptable / rounds.
- Outcome ids: `round-1`, `round-2`, `round-3`; `label` e.g. "Read Cover 3 and hit the curl"; `value` = true coverage id.
- **`OpenReceiver` evaluation:** at read time, separation = distance to nearest defender in the pass lane and within 2 yd radius; `correct` = highest separation and >= 2.0 yd; `acceptable` = separation >= 1.2 yd.

| mistake | conceptId | description text |
|---|---|---|
| Threw to a covered receiver in Cover 2 | `cover-2` | Threw into the safety's deep half instead of the sideline hole. |
| Threw deep against Cover 3 | `cover-3` | Threw deep into a three-deep shell instead of underneath. |
| Threw to receiver who followed by a defender in man | `man-coverage` | Threw into a trailing defender. |
| Covered receiver in quarters | `cover-4` | Threw downfield into four deep instead of underneath. |
| Missed blitz | `cover-0` | Held the ball with no safety help. |
| Fooled by disguise | `disguise` | Trusted the pre-snap shell. |
| Wrong coverage chip | true coverage id | Named the wrong coverage. |
| Wrong man/zone family | `zone-vs-man` | Confused man with zone. |
| Ignored motion | `pre-snap-motion` | Did not use motion to identify coverage. |

Mastery signals (native applies; mastery model adds +0.20 / -0.15 per exercise, sims propose deltas):

| event | conceptId | delta | evidence |
|---|---|---|---|
| Correct receiver, no hint | scenario concept | +0.25 | "Chose the open receiver against <coverage>." |
| Correct receiver, hint used | scenario concept | +0.10 | same |
| Coverage chip correct | true coverage id | +0.15 | "Named <coverage> from the shell." |
| Correct man/zone family | `zone-vs-man` | +0.15 | "Distinguished man from zone." |
| Correct on a motion scenario | `pre-snap-motion` | +0.20 | "Used motion to diagnose coverage." |
| Correct on a disguise scenario | `disguise` | +0.20 | "Read the post-snap rotation." |
| Wrong receiver | scenario concept | -0.10 | "Missed the open receiver against <coverage>." |
| Wrong coverage chip | true coverage id | -0.10 | "Misnamed the coverage." |
| Timeout | scenario concept | -0.05 | "Ran out of time." |

Per-session caps: +0.40 and -0.20 per concept. Result mapping: `outcomes[]` one per round, `mistakes[]` per wrong decision (`at` = active ms), `masterySignals[]` aggregated per concept after caps.

## 14. XP & hearts
- `xpEarned` = 10 per round with a correct or acceptable receiver + 40 for completing all rounds (max 70 for 3 rounds; native clamps to the lesson budget).
- `heartsLost` = 1 if 2 or more of 3 rounds were failed, otherwise 0. Max 1 per session. Abort = 0 hearts.
- `replayAvailable` = true whenever at least one round finished; false on early abort before round 1.

## 15. Failure states
| Case | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Wrong receiver | Explain card with replay of the correct read | round `success=false`, mistake logged | counted at session level |
| Timeout (>= L3) | "The rush got there" then the standard explain | round failed, mistake `timeout` | as above |
| Failed session (0 or 1 of 3 correct) | Summary with a kind line ("Coverage is a language. Let's go again.") and a Try again offer (native) | `completed=true`, low score | 1 |
| Backgrounded < 120 s | Native pauses Unity | none | 0 |
| Backgrounded > 120 s / user quit | Native abort | `aborted=true`, `abortReason`, partial outcomes, xp 0 | 0 |
| Asset missing | `error ASSET_LOAD_FAILED` (recoverable) | no result | 0 |
| Invalid config | `error CONFIG_INVALID` | no result | 0 |
Failure always ends on an explain moment, never a dead end.

## 16. Accessibility
- **Reduced motion:** camera cuts instead of blends, SlowMotion becomes hold-frame, no shake, no dash animation; ball flight remains but at 1x.
- **Haptics:** off when `hapticsEnabled=false`.
- **Color-blind (`colorBlindMode`):** offense = filled circle base with jersey number; defense = hollow ring base with position letters; open receiver = gold ring plus a bracket glyph; zone overlays use hatch patterns (diagonal for zone, dotted for man shadows) in addition to color.
- **Text scale:** cards reflow to `textScale` up to 1.6; copy never truncates (body max 45 words).
- **Tap-only:** default.
- **VoiceOver/TalkBack:** Unity content is limited; provide native fallback `coverage-04-fallback` (still-frame hotspot-tap and decision-scenario over the same six starter scenarios).

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Snap | leather thud | soft tap | 0.6 |
| Decision open | low pulse | none | 0.4 |
| Tap receiver | soft click | soft tap | 0.5 |
| Correct | gold chime | light success | 0.7 |
| Wrong | dull thud | warning | 0.5 |
| Timer last 3 s | tick | none | 0.3 |
All honor `soundEnabled` and `hapticsEnabled`.

## 18. Art & asset list
| asset | procedural / external | source & license | size | notes |
|---|---|---|---|---|
| Field, lines, hash marks, end zone | procedural | own | 0 | `football_field` |
| 22 characters | procedural capsule bodies + number decals | own | < 1 MB | role rings |
| Ball | procedural | own | 0 | prolate |
| Zone overlays / route lines | procedural | own | 0 | per ART_DIRECTION section 4 |
| Fonts | bundled | Instrument Serif and Geist (OFL) | < 1 MB | TMP assets |
| Audio | original | own, license id `original-swoond` | < 2 MB | 8 cues |
No team logos, no real jersey designs. Addressables bundle: `sim-football-coverage-read`, expected < 6 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md` apply. Tighter: <= 22 characters at <= 900 triangles each (about 20k), <= 60 draw calls, memory peak <= 120 MB, `launch` to `ready` <= 1.5 s.

## 20. Telemetry
`telemetry` extra keys: `hintsUsed`, `decisionLatencyMsMean`, `coverageCallAccuracy`, `scenarioIds` (ids only), `difficulty`. No names or free text.

## 21. Acceptance criteria (testable)
1. AC-1: With seed 42, difficulty 2, `scenarioCount` 3, the sim emits exactly 3 `outcomes` and one `result`.
2. AC-2: With the same seed and scripted inputs, two runs produce byte-identical `SimulationResult` (excluding `sessionId`, `durationMs`, `telemetry`).
3. AC-3: Every scenario in every set has exactly one `correctTargetIds` element whose separation exceeds the second best by >= 1.2 yd (EditMode data test).
4. AC-4: `OpenReceiver` evaluation agrees with `correctTargetIds` for all 18 scenarios.
5. AC-5: Difficulty 1 shows shell zones pre-snap and has no timer; difficulty 3 has coverage chips and a 12 s limit.
6. AC-6: The shipped bridge launch example parses and runs; the result validates against `simulation-result.schema.json`.
7. AC-7: Invalid config (`scenarioCount: 9`) emits `error CONFIG_INVALID`.
8. AC-8: `pause` stops sim time and timers; `resume` continues within 100 ms; `abort` emits `aborted=true` with xp 0.
9. AC-9: Reduced-motion run has zero camera blends and no shake.
10. AC-10: All Explanation titles are <= 6 words and bodies <= 45 words (data test).
11. AC-11: Tap targets >= 44 pt at screen sizes 375x667 and 430x932.
12. AC-12: Hearts lost is 1 iff >= 2 of 3 rounds failed.
13. AC-13: No mistakes/mastery `conceptId` outside the section 3 list plus the six coverage ids.
14. AC-14: Performance on iPhone 13-class: p5 fps >= 50, peak memory <= 120 MB, `ready` <= 1.5 s.
15. AC-15: `personName` and `relationship` appear nowhere in logs or `telemetry`.

## 22. Test plan
| AC | Type | Test name |
|---|---|---|
| AC-1, AC-2 | PlayMode | `CoverageRead_FullRun_Seed42_Deterministic` |
| AC-3, AC-4 | EditMode | `Scenarios_OpenReceiver_MatchesAuthoredTargets` |
| AC-5 | EditMode | `Difficulty_Table_AppliesParameters` |
| AC-6 | EditMode | `Bridge_LaunchExample_ParsesAndResultValidates` |
| AC-7 | EditMode | `Config_Invalid_EmitsConfigInvalid` |
| AC-8 | PlayMode | `PauseResumeAbort_Lifecycle` |
| AC-9 | PlayMode | `ReducedMotion_NoBlendNoShake` |
| AC-10 | EditMode | `Explanations_CopyLimits` |
| AC-11 | PlayMode | `TouchTargets_MinSize` |
| AC-12 | EditMode | `Hearts_Rule` |
| AC-13 | EditMode | `Result_ConceptIds_Known` |
| AC-14 | Perf | `Perf_iPhone13_CoverageRead` |
| AC-15 | EditMode | `Privacy_NoPersonalFields` |
Also: EditMode scoring maths per difficulty (level >= 3 weighting), mastery caps, and PlayMode freeze/explain sequence with scripted taps.

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Should the difficulty-1 zone overlay come from a `Coverage` module method or authored zones per scenario? | Astra | No |
| 2 | Are 5 percent slow-mo and a 1.4-2.2 s read window right on device? Tune in playtest. | Astra/Product | No |
| 3 | Add a `replayCamera` config for the learner's choice of broadcast-side vs top-down? | Product | No |
| 4 | Confirm the native fallback `coverage-04-fallback` uses the same six starter scenarios as stills (Claude authors). | Claude | No |
