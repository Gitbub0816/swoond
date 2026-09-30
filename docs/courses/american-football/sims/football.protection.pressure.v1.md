# Pressure Count (`football.protection.pressure.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `football.protection.pressure.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition not used (scenario-data driven) |
| Authors / date | Claude Code (content agent) / 2026-09-30 |
| Changelog | 1.0.0: first spec |

## 2. Course & lesson links
- `courseId`: `american-football`. Unit `play-craft`, lesson `protection-04` (default difficulty 2). Reused in `this-week` templates (a blitz-heavy opponent) at difficulty 3.
- CDS Interaction plan row U3. Manifest `unitySimulations[]` entry `football.protection.pressure.v1`.
- Prerequisites: `blitz`, `pass-rush`, `offensive-line`, `sack`. Lessons `blitz-06` (defense-basics) and `pre-snap-01` (play-craft) come first.
- Native accessibility fallback lesson: `protection-04-fallback` (hotspot-tap: "tap the free rusher" on still diagrams, plus a decision-scenario for the hot-route answer).

## 3. Learning objective(s) & concepts taught
- Objective: "You can count the rushers, find the one nobody is blocking, and say why the quarterback has to throw fast."

| conceptId | term | After this the learner can... |
|---|---|---|
| `blitz` | Blitz | Recognize when more than four defenders will rush. |
| `pressure` | Pressure | Explain why an unblocked rusher wins in about two seconds. |
| `protection-scheme` | Pass protection scheme | Say that five linemen and a back can only block so many rushers. |
| `hot-route` | Hot route | Explain the fast throw to the receiver the blitzer left behind. |
| `pre-snap-read` | Pre-snap read | Use alignment and creeping defenders to predict the rush. |
| `sack` | Sack | Say what happens when a rusher is free. |
| `edge-rusher` | Edge rusher | Spot an outside rusher on an unprotected side. |

Scope limit: no blocking techniques (no hand placement), no penalties, no quarterback footwork, no coverage identification (see `football.coverage.read.v1`).

## 4. Why Unity (tier justification)
- **Spatial reasoning and movement (yes):** who is free is a matter of geometry and time: defenders creep, the line slides, a blitzer arrives in 1.5 seconds. Seeing 7 defenders run at the quarterback teaches "extra rusher equals problem" in a way a count printed in text cannot.
- **Timing in a scene (yes):** the difference between a completed hot route (1.2 s) and a sack (1.8 s) is the lesson.
- **Native alternative:** `hotspot-tap` on a static diagram (used in `blitz-06`) teaches "tap the blitzer". It cannot show how fast the rush arrives, or that bluffs exist. `decision-scenario` teaches the choice but not the count. Justified: the arrival race is the learning.

## 5. Player fantasy & core loop
- Fantasy: "You are the quarterback, and the defense just started creeping. Who is coming?"
- Loop (3 rounds, about 3 minutes):
  1. **Prompt**: "3rd and 6. Show me who is coming." Pre-snap picture with defenders moving into position.
  2. **Decisive interaction (stage 1)**: tap every rusher you think nobody is blocking (0, 1 or 2), or tap Snap with none.
  3. **Execute**: the snap; the line blocks; the running back kicks out one free rusher; the rest is a race.
  4. **Stage 2 (only when one rusher cannot be blocked)**: time slows; tap the hot receiver.
  5. **Freeze / explain**: freeze at the moment the rusher arrives (or the ball is out), top-down.
  6. **Say-this line**.

## 6. Scene & entities
- Environment `football_field`; camera `behind-qb-high` for play, `top-down` for explain.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `qb` | `Quarterback` | you | (0,-5) shotgun |
| `ol_1..5` | `Character` | blockers | x = -4,-2,0,2,4; y=0 |
| `rb` | `Receiver` | block or release | (-1.5,-5); kicks out to one free rusher |
| `te` | `Receiver` | optional blocker | scenario |
| `wr_*` | `Receiver` | hot-route targets | scenario alignments |
| `dl_1..4` | `Defender` | rushers | y=1.2; speed 5.5 yd/s |
| `lb_1..3` | `Defender` | rush or drop | y=4.5; speed 6.5 yd/s |
| `nickel`, `cb_*`, `s_*` | `Defender` | blitz or cover | speed 7.0 yd/s |
| `blocker_line_*` | `Path` overlay | assignment lines (levels 1-2) | rose lines |
| `free_ring_*` | `Target` | selectable defenders | ring >= 44 pt |
| `pocket` | `Zone` | pocket radius 3 yd around QB | entering = pressure |
| `decision` | `DecisionPoint` | stage 1 and 2 | timer |
| `Objective: pocket_holds` | `Objective` | success if no rusher enters the pocket before the throw | |

New primitives: none. Football module extension: `Blocking` (assignment resolver: each OL blocks the nearest unassigned rusher inside-out; RB takes the free rusher chosen by the learner if exactly one). Deterministic; data in the scenario file lists the resolved free rushers, and EditMode tests validate the resolver against them.

Layout:
```
      S            S
 CB                     CB
   LB     LB    LB   N(nickel)
 D  D     D  D
      T G C G T
          Q  RB
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Mark free rusher | Tap a defender's ring (toggle) | `Target` | ring >= 44 pt | ring turns rose, soft tap |
| Snap | Tap pill (bottom) | commits stage 1 | 56 pt | thud |
| Hot route | Tap a receiver ring (stage 2) | `Target` | ring >= 44 pt | ball released |
| Hint | Tap "Count for me" | shows count HUD + assignment lines for 2 s | 44 pt | hint used |
Tap-only. Alternative: none needed (all taps). Portrait, safe areas honored. Native draws hearts, exit, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate, build scene | Intro | `ready` |
| Intro | ready | Prompt card, defenders shuffle (creep) for 2.5 s | learner may mark | `progress` 0 |
| Playing (Read) | Intro done | Defenders idle-move; timer (L3+) counts | tap Snap or timer end | none |
| Decision (stage 1) | Snap tapped | Selections locked, defenders rush | rush resolves; if unblockable count >= 1 after RB -> stage 2 | none |
| Decision (stage 2) | Free count > RB capacity | SlowMotion 0.1, tap hot receiver, 3 s (or timer) | ball thrown or sack | none |
| Executing | Decision done | Ball thrown or QB hit; play finishes | ball lands or sack | none |
| Freeze | Resolved | Freeze at arrival; top-down | 400 ms | none |
| Explain | Freeze | Free rushers highlighted; blockers drawn; copy card | Continue | `checkpoint` |
| Summary | Last round | Score card | Done | none |
| Done | Done | `result` then `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | as standard | end | |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Scenario pool | `four-man`, `six-edge` | + `five-man`, `six-safety` | + `bluff` | + `seven-hot` | + `empty-hot`, `stunt` |
| Count HUD (Rushers N / Blockers M) | on | hint only | off | off | off |
| Assignment lines | on | hint only | off | off | off |
| Read timer (before auto-snap) | none | none | 10 s | 8 s | 6 s |
| Hints per session | unlimited | 2 | 1 | 1 | 0 |
| Stage 2 (hot route) | off | off | off | on | on |
| Bluff rate | 0 | 0 | 33 percent | 33 percent | 40 percent |
| Rushers max | 6 | 6 | 6 | 7 | 7 |
Level 1 passable by a true beginner (count is on screen, lines drawn, only two scenario types). Default: `protection-04` = 2.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "football.protection.pressure.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0 },
    "scenarioSetId": { "type": "string", "enum": ["pressure-starter", "pressure-blitz", "pressure-hot"], "default": "pressure-starter" },
    "scenarioCount": { "type": "integer", "minimum": 1, "maximum": 5, "default": 3 },
    "showCountHud": { "type": "boolean" },
    "showAssignmentLines": { "type": "boolean" },
    "readTimeLimitSec": { "type": ["number", "null"], "minimum": 3, "maximum": 30 },
    "allowBluffs": { "type": "boolean", "default": false },
    "allowHotRoute": { "type": "boolean", "default": false },
    "hintBudget": { "type": "integer", "minimum": 0, "maximum": 10 },
    "down": { "type": "integer", "minimum": 1, "maximum": 4 },
    "yardsToGo": { "type": "integer", "minimum": 1, "maximum": 20 }
  }
}
```
Valid: `{ "scenarioSetId": "pressure-starter", "scenarioCount": 3, "showCountHud": true, "allowBluffs": false }`. Invalid config gives `CONFIG_INVALID`.

## 11. Scenario data set
Format `Assets/Sims/Football/Pressure/scenarios/<set>.json`. **Minimum count: 12** (rounds x 3 = 9): `pressure-starter` (pp-01 to pp-04), `pressure-blitz` (pp-05 to pp-08), `pressure-hot` (pp-09 to pp-12). Deterministic per seed (order and mirroring). Each scenario lists rushers, drops, blocker resolution, `freeRusherIds`, `rbCapacity` (0 or 1), and `hotTargetId` when stage 2 is required. Coordinates: x yards lateral, y yards downfield.

| scenarioId | Setup | Correct decision | conceptId | Tags |
|---|---|---|---|---|
| `pp-01-four-man` | 4 DL rush; LBs at (-4,4.5), (0,4.5), (4,4.5) drop; 5 OL, RB (-1.5,-5), TE right | Free set {}; Snap with none | `pressure` | starter |
| `pp-02-five-man` | 4 DL + Mike (0,4.5) A-gap blitz; 5 OL block all five; RB releases | Free set {} | `blitz` | starter |
| `pp-03-six-edge` | No tight end on the left: `nickel` at (-10,5) blitzes the edge; 4 DL + Mike also rush (6 rushers); OL takes five; `nickel` is free | Free {`nickel`}; RB kicks out | `edge-rusher` | starter |
| `pp-04-six-safety` | 4 DL + delayed `s_1` from (0,12) via the A-gap; OL takes five; `s_1` is free | Free {`s_1`} | `blitz` | starter |
| `pp-05-bluff` | Mike creeps to (0,1.5) and Sam to (4,2); at snap both drop | Free set {} | `pre-snap-read` | bluff |
| `pp-06-six-fire-zone` | 3 DL + `lb_1`, `lb_3`, `nickel` rush; one DL drops; OL takes five; nickel free | Free {`nickel`} | `blitz` | blitz |
| `pp-07-empty-hot` | Empty backfield (RB split at (-9,0)); 4 DL + Mike + `lb_3` (6 rushers), OL takes 5; `lb_3` free; RB cannot block | Free {`lb_3`}; stage 2: `wr_slot` (slot vacated by `lb_3`'s side is open) | `hot-route` | hot |
| `pp-08-seven-hot` | 7 rushers: 4 DL + `lb_1`, `lb_3`, `cb_l`; 5 OL + RB can block six, so one rusher is always unblockable (two are free before the RB picks one) | Free {`lb_3`, `cb_l`}; RB takes `lb_3`, stage 2: `wr_x` (the corner left his man) | `hot-route` | hot |
| `pp-09` to `pp-12` | Mixed: three-man rush and two delayed blitzers (stunt), corner blitz with press slot, safety plus nickel double A-gap blitz, and an empty-set bluff | as above | `pressure`, `protection-scheme`, `blitz` | hot, stunt |

Fully written: 
- **pp-01**: Rushers `dl_1..4` (rush start t=0); `lb_1..3` drop to hook zones by t=1.2 s. Blockers: `ol_1..5` each blocks the nearest rusher, `rb` free to release into a checkdown. `freeRusherIds = []`, `rbCapacity = 1`. At t=2.0 s the pocket is clean; the QB throws to the checkdown (`rb`). Explain key `four-man`.
- **pp-03**: Rushers: `dl_1..4`, `lb_2` (Mike at (0,4.5) blitzing A-gap), `nickel` at (-10,5) (edge, on the side with no tight end). Blockers: `ol_1..5` pick up `dl_1..4` and Mike; `nickel` arrives free: distance sqrt(10^2+10^2) = 14.1 yd at 7.0 yd/s, so at t=2.0 s. The RB (`rb` at (-1.5,-5)) can block him if kicked out to the left at t=0.4 s. `freeRusherIds = ["nickel"]`, `rbCapacity = 1`, stage 2 not needed. If the learner marks {}: the nickel sacks the QB at t=2.0 s (no RB help). If the learner marks {`nickel`}: the RB stops him at t=1.8 s and the throw at t=2.4 s completes. Explain key `six-edge`.
- **pp-08**: rushers `dl_1..4`, `lb_1`, `lb_3`, `cb_l`; blockers OL 5 + RB 1; `freeRusherIds = ["lb_3","cb_l"]`; `rbCapacity = 1` so one remains unblockable; stage 2: `hotTargetId = "wr_x"` (the corner he vacated). QB must release by t=1.3 s (the rusher arrives t=1.8 s). Stage 2 window: 3 s slow-mo. Explain key `seven-hot`.
Remaining scenarios follow the same schema with the resolver checking that `freeRusherIds` equals the computed set (EditMode test).

## 12. Freeze / explain moments
Trigger: after each round. Freeze: at the moment a rusher arrives, or the ball lands. Camera: top-down. Callouts: free rushers in `accentTint` rings with numbers, arrows from each blocker to his man (gold), a dashed line from the QB to the hot receiver. Copy card below.

| explainKey | Outcome | Title | Body | Say this |
|---|---|---|---|---|
| `four-man` | correct | Four rushers. Nobody free. | Five linemen against four rushers is a comfortable count. The extra blocker is a safety valve and the back can release. Pressure comes from numbers, not just speed. | "Four-man rush, they're not bringing anyone." |
| `four-man` | incorrect | Nobody is free here. | Four rushers face five blockers, so every rusher has a man. Marking a linebacker who is dropping into coverage wastes a read. Watch who actually charges. | "Not every creeper rushes." |
| `five-man` | correct | Five on five. Fine. | A blitzing linebacker adds a fifth rusher, but five linemen can still take five. The line holds and the back can go out for a pass. | "They sent one more, but the line had it." |
| `five-man` | incorrect | The line has that count. | Five rushers face five linemen. Nobody is left unblocked. It only becomes a problem with a sixth rusher. | "Five rushers? The line is fine." |
| `six-edge` | correct | Sixth man found. | Six rushers against five linemen leaves one free. That is usually the outside blitzer. The running back steps up and takes him. Quarterback stays clean. | "The back has to pick up the corner blitz." |
| `six-edge` | incorrect | The sixth man got home. | Five linemen block five rushers. The extra one, here the nickel off the edge, is free and gets to the quarterback in about two seconds. Find the man nobody is facing. | "Count six? Someone's free." |
| `six-safety` | correct | Safety blitz spotted. | A safety who walks up late is a rusher too. He was the sixth man and the back picked him up. Nice eyes. | "They dialed up a safety blitz." |
| `six-safety` | incorrect | Look deep, too. | The free rusher came from the safety spot, not the front seven. Blitzers can come from anywhere, which is why coaches call it disguise. | "Blitzes can come from the back." |
| `bluff` | correct | Nobody is coming. | Those linebackers crept up, then dropped. A bluff is when they show a blitz and do not send it. You held your fire. | "That was a fake blitz." |
| `bluff` | incorrect | It was a bluff. | The linebackers crept up but dropped into coverage at the snap. A defender near the line is not always a rusher. Wait for him to actually run. | "Don't chase every creeper." |
| `seven-hot` | correct | Seven rushers. Throw hot. | Seven rushers, six blockers: someone is always free. The answer is not a block. It is a fast throw to the receiver left one-on-one, before the rusher lands. | "Too many rushers to block, so throw hot." |
| `seven-hot` | incorrect | Too slow. Get it out. | Count them: one rusher has no blocker, and he arrives in under two seconds. The blitzer left a receiver alone, so throw there right now. | "Beat the blitz with a quick throw." |
| `empty-hot` | correct | No back. Get it out. | With the back split wide, five linemen cannot stop six rushers. The quarterback needs to throw quickly to the space the blitzer left. | "Empty set plus a blitz means quick throws." |
| `empty-hot` | incorrect | Nobody is there to block. | The back is out wide, so the extra rusher has a clear run. You need the ball out fast to the receiver the blitzer left. | "Empty backfield, no help." |

## 13. Scoring & mastery signals
- Stage 1 score = 100 x F1 of the marked set vs `freeRusherIds` (F1 of empty vs empty = 1). Stage 2 present: round score = 70 x F1 + 30 x (hot target correct). Round success = score >= 90. Hint: -10 each. Session `score` = round(mean), `accuracy` = success rounds / rounds.
- Outcome ids `round-1..3`, `value` = scenario key.

| mistake | conceptId | description |
|---|---|---|
| Marked a bluffing defender | `pre-snap-read` | Marked a creeper who dropped. |
| Missed the free rusher | `pressure` | Did not see the unblocked rusher. |
| Marked a blocked rusher | `protection-scheme` | Counted a blocked rusher as free. |
| Missed edge rusher | `edge-rusher` | Missed the outside rusher. |
| Wrong or no hot route when needed | `hot-route` | Did not throw fast to the vacated receiver. |
| Missed blitz | `blitz` | Did not spot the sixth rusher. |

| event | conceptId | delta | evidence |
|---|---|---|---|
| Free set exact, no hint | `pressure` | +0.20 | "Found the free rusher." |
| Free set exact on a blitz scenario | `blitz` | +0.20 | "Spotted the extra rusher." |
| Bluff correctly ignored | `pre-snap-read` | +0.20 | "Ignored a bluff." |
| Hot target correct | `hot-route` | +0.25 | "Threw hot to the vacated receiver." |
| Correct on edge scenario | `edge-rusher` | +0.20 | "Found the edge rusher." |
| Free set wrong | `pressure` | -0.10 | "Missed the free rusher." |
| Hot target wrong | `hot-route` | -0.10 | "Missed the hot route." |
Caps: +0.40 / -0.20 per concept per session. `protection-scheme` gets +0.10 for any correct round and -0.05 for wrong ones.

## 14. XP & hearts
- `xpEarned` = 10 per successful round + 40 for finishing (native clamps).
- `heartsLost` = 1 if >= 2 rounds failed. Max 1.
- `replayAvailable` true after any round (replay from top-down shows the race).

## 15. Failure states
| Case | Learner sees | Result | Hearts |
|---|---|---|---|
| Wrong free set | Sack or hurried throw plays out, then explain | round failed | session rule |
| Read timer ended (L3+) | Auto-snap with the current marks, then explain | scored as marked | session rule |
| Stage 2 timeout | QB takes the sack (slow, comic, not gory), explain | failed | session rule |
| Session failed | "Blitzes are hard. Let's count again." plus native Try again | `completed=true`, low score | 1 |
| Abort/background/asset/config | as standard | | 0 |

## 16. Accessibility
Reduced motion: no camera blend or shake; sack shown as a still freeze with a "pressure" ring. Haptics off honored. Color-blind: rushers have hollow rings with numbers; free rushers have a star glyph plus rose tint; blocker assignment lines are solid with arrowheads, not just gold. Text scale honored. Tap-only. VoiceOver: native fallback lesson `protection-04-fallback`.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Creep | low rumble | none | 0.3 |
| Snap | thud | soft tap | 0.6 |
| Sack | thump | warning | 0.5 |
| Clean throw | gold chime | light success | 0.7 |

## 18. Art & asset list
| asset | procedural / external | source & license | size | notes |
|---|---|---|---|---|
| Field, characters (up to 18) | procedural | own | < 1 MB | |
| Overlay lines/rings | procedural | own | 0 | |
| Fonts, audio | bundled OFL / original | `original-swoond` | < 2 MB | |
Bundle `sim-football-protection-pressure`, < 5 MB.

## 19. Performance budget
Defaults; tighter: <= 18 characters, <= 60 draw calls, memory <= 110 MB, `ready` <= 1.5 s.

## 20. Telemetry
`hintsUsed`, `readTimeMsMean`, `freeSetF1Mean`, `hotRouteAccuracy`, `scenarioIds`.

## 21. Acceptance criteria (testable)
1. AC-1: With seed 11, difficulty 2, 3 rounds: exactly 3 outcomes.
2. AC-2: For every scenario, the `Blocking` resolver's free set equals `freeRusherIds`.
3. AC-3: Stage 2 appears only when free count > `rbCapacity`.
4. AC-4: Determinism by seed.
5. AC-5: L1 shows count HUD and lines; L3 does not, and has a 10 s timer.
6. AC-6: Result validates against `simulation-result.schema.json`; bridge lifecycle passes conformance.
7. AC-7: Copy limits (titles <= 6 words, bodies <= 45 words).
8. AC-8: Reduced motion: no camera blend.
9. AC-9: Touch targets >= 44 pt (ring hit area, not model size).
10. AC-10: Hearts rule.
11. AC-11: Perf on iPhone 13-class: p5 >= 50 fps, memory <= 110 MB.
12. AC-12: Invalid config gives `CONFIG_INVALID`.
13. AC-13: No personal fields in logs.
14. AC-14: An unblocked rusher entering the pocket radius before the throw is a sack in the sim in every scenario data (data test).

## 22. Test plan
| AC | Type | Test |
|---|---|---|
| AC-1, AC-4 | PlayMode | `Pressure_FullRun_Seed11_Deterministic` |
| AC-2 | EditMode | `BlockingResolver_MatchesScenarioFreeSets` |
| AC-3 | EditMode | `Stage2_Trigger_Rule` |
| AC-5 | EditMode | `Difficulty_Table_Applies` |
| AC-6 | EditMode | `Bridge_Conformance` |
| AC-7 | EditMode | `Explanations_CopyLimits` |
| AC-8 | PlayMode | `ReducedMotion_NoBlend` |
| AC-9 | PlayMode | `TouchTargets_MinSize` |
| AC-10 | EditMode | `Hearts_Rule` |
| AC-11 | Perf | `Perf_iPhone13_Pressure` |
| AC-12 | EditMode | `Config_Invalid` |
| AC-13 | EditMode | `Privacy_NoPersonalFields` |
| AC-14 | EditMode | `Scenarios_UnblockedRusher_Sacks` |
Plus PlayMode scripted taps for stage 1 and stage 2 and pause/resume/abort.

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is 2 yd OL spacing (wider than real) acceptable for legibility? | Astra | No |
| 2 | Should stage 2 always appear at L5 even when RB capacity covers, as a double check? | Product | No |
| 3 | Sack animation tone: comic freeze vs cut to explain. | Product | No |
