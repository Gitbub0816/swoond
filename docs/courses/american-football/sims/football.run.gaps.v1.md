# Run Gaps (`football.run.gaps.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `football.run.gaps.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition not used (scenario-data driven) |
| Authors / date | Claude Code (content agent) / 2026-09-30 |
| Changelog | 1.0.0: first spec |

## 2. Course & lesson links
- `courseId`: `american-football`. Unit `play-craft`, lesson `run-gaps-05` (default difficulty 2). Reused in `always-on-review` lesson `sim-refresh-03` (difficulty 3) and a `this-week` template (opponent run defense).
- CDS Interaction plan row U4. Manifest `unitySimulations[]` entry `football.run.gaps.v1`.
- Prerequisites: `running-back`, `offensive-line`, `line-of-scrimmage`, `run-gap`. Lesson `blocking-07` (native) is available after the sim as a recap.
- Native accessibility fallback lesson: `run-gaps-05-fallback` (hotspot-tap: "tap the gap where the runner should cut" on still frames).

## 3. Learning objective(s) & concepts taught
- Objective: "You can name the gap a run goes through, and see why the running back chose it."

| conceptId | term | After this the learner can... |
|---|---|---|
| `run-gap` | Run gap | Name A, B, C and D gaps and say who is responsible for each. |
| `inside-zone` | Inside zone | See that the back reads a defender and takes the crease. |
| `outside-zone` | Outside zone | See the stretch, the plant and the cutback. |
| `gap-scheme` | Gap scheme | See a lineman assigned to a specific gap with a puller leading. |
| `zone-blocking` | Zone blocking | Say linemen block an area, not a person. |
| `pulling-guard` | Pulling guard | Recognize a guard leading through the hole. |
| `light-box` | Light box | Notice fewer than seven defenders near the line means running is easier. |

Scope limit: no blocking technique, no option/read-option, no goal-line personnel, no passing.

## 4. Why Unity (tier justification)
- **Spatial reasoning and movement (yes):** a gap is a space that opens and closes in half a second as blockers and defenders collide. Zone versus gap schemes are recognized by how bodies move: zone linemen shift together, gap linemen aim at a spot and a guard pulls.
- **Camera perspective (yes):** learners see the run from behind the back (the view of a runner) and then top-down (the view of a coach).
- **Native alternative:** `hotspot-tap` on a static diagram (used in `run-gaps-05` prior part and `blocking-07`) tests gap labels; it cannot show a crease opening, a puller leading, or a linebacker over-flowing. `term-match` teaches A/B/C as vocabulary only. Justified.

## 5. Player fantasy & core loop
- Fantasy: "You are the running back with one second to pick a hole."
- Loop (3 rounds, about 3 minutes):
  1. **Prompt**: call name and situation ("Inside zone right, 2nd and 6").
  2. **Handoff**: the play develops for about 1.1 s; the line moves.
  3. **One decisive interaction**: time slows to 5 percent; the gap rings appear on the line; tap the gap you would run through.
  4. **Execute**: the back cuts and runs; the yards gained are shown on a yard counter.
  5. **Freeze / explain**: top-down; each defender's assigned gap is shown; the open lane is gold.
  6. **Say-this line**.

## 6. Scene & entities
- Environment `football_field`; camera `chase-high` (behind the back) for play, `top-down` for explain.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `rb` | `Character` (role: player) | the runner | alignment (0,-6) or (2,-6); speed 8.0 yd/s |
| `qb` | `Quarterback` | hands off | (0,-4) |
| `ol_1..5` | `Character` | blockers | x = -4..4 (2 yd spacing); block per scheme |
| `te`, `fb` | `Character` | optional blockers | scenario |
| `puller` | `Character` | pulling guard | scenario (gap schemes) |
| `dl_1..4`, `lb_1..3` | `Defender` | run fits | gap assignments in data |
| `gap_A_L..gap_D_R` | `Target` + `Zone` | selectable lanes | ring >= 44 pt; label A/B/C/D |
| `decision` | `DecisionPoint` | pick a gap | optional timer |
| `Objective: gain_yards` | `Objective` | reach target yards | target from scenario |
| `RunFit` | `Swoond.Sports.Football` module class | resolves who fills which gap and yards per lane | data-driven per scenario |

New primitives: none. Football module addition: `RunFit` (gap assignments and lane yardage), documented in section 11.

Layout (behind the back; LOS line at y=0):
```
   D   C   B   A | A   B   C   D
   .   .   .   . | .   .   .   .    <- gap rings on the line
 DE  DT      NT  DT      DE           <- front
        LB   LB   LB
  T   G   C   G   T   TE
            QB
            RB
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose gap | Tap a ring | `Target` | ring >= 44 pt (rings widen to 44 pt regardless of yardage) | ring rose, soft tap |
| Hint | Tap "Show fits" | draws each defender's gap assignment for 2 s | 44 pt | counts as hint |
| Replay | Tap "Watch again" | `Replay` | 44 pt | slow-mo replay |
Tap-only. Portrait, safe areas. Native draws hearts, exit, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build scene | Intro | `ready` |
| Intro | ready | Call name card, formation shown | Start (tap) | `progress` 0 |
| Playing | Start | Handoff and mesh (1.1 s); linemen and defenders move per `RunFit` | reaches cut point | none |
| Decision | Cut point | SlowMotion 0.05; rings appear; optional timer | tap or timeout (timeout = nearest gap to current lane) | none |
| Executing | Chosen | Back cuts to gap; play to whistle (max 4 s) | whistle | none |
| Freeze | Whistle | Freeze; top-down; yards counter | 400 ms | none |
| Explain | Freeze | Fits drawn, lane highlighted, copy card | Continue | `checkpoint` |
| Summary | Last round | Score card | Done | none |
| Done | Done | `result`, `requestExit` | end | |
| Paused / Aborted | native | standard | end | |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Play calls | inside zone | + outside zone | + power | + counter, draw | + blitz-stunt, short-yardage |
| Gap rings shown | 6 (A, B, C each side) with labels | 6 | 6 | 8 (with D) | 8 |
| "Fits" overlay | always on | on hint | on hint | on hint | off |
| Hints per session | unlimited | 2 | 2 | 1 | 0 |
| Decision timer | none | none | 10 s | 8 s | 6 s |
| Target yards for success | 3 | 4 | 4 | 4 (2 for short-yardage) | 4 (2 for short-yardage) |
| Box | heavy (8) | mixed | mixed | mixed (light 6 appears) | mixed |
| Scenario pool tags | `zone` | `zone` | `zone`,`gap` | + `misc` | all |
Level 1 is passable by a true beginner: fits are drawn, target is 3 yards, a lane with 4+ yards always exists. Default `run-gaps-05` = 2.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "football.run.gaps.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0 },
    "scenarioSetId": { "type": "string", "enum": ["run-gaps-starter", "run-gaps-schemes", "run-gaps-hard"], "default": "run-gaps-starter" },
    "scenarioCount": { "type": "integer", "minimum": 1, "maximum": 5, "default": 3 },
    "playCalls": { "type": "array", "uniqueItems": true, "minItems": 1, "items": { "type": "string", "enum": ["inside-zone", "outside-zone", "power", "counter", "draw", "dive", "stunt-draw"] } },
    "showFits": { "type": "boolean" },
    "showDGaps": { "type": "boolean", "default": false },
    "decisionTimeLimitSec": { "type": ["number", "null"], "minimum": 3, "maximum": 30 },
    "targetYards": { "type": "integer", "minimum": 1, "maximum": 10 },
    "hintBudget": { "type": "integer", "minimum": 0, "maximum": 10 }
  }
}
```
Valid: `{ "scenarioSetId": "run-gaps-starter", "scenarioCount": 3, "playCalls": ["inside-zone", "outside-zone"], "showFits": true }`. Invalid: `CONFIG_INVALID`.

## 11. Scenario data set
Format `Assets/Sims/Football/RunGaps/scenarios/<set>.json`. **Minimum count: 12** (rounds x 3 = 9): `run-gaps-starter` (rg-01 to rg-04), `run-gaps-schemes` (rg-05 to rg-08), `run-gaps-hard` (rg-09 to rg-12). Each scenario: `playCall`, `formation`, `front`, `fits{defenderId: gapId}`, `blocking{olId: gapOrAreaId, puller?}`, `gapYards{gapId: yards}` (deterministic yardage of running through that gap), `bestGaps`, `okGaps` (yards >= 3), `targetYards`, `conceptId`, `tags`. Gap ids: `A-L`, `A-R`, `B-L`, `B-R`, `C-L`, `C-R`, `D-L`, `D-R`. Deterministic per seed (order and mirroring).

| scenarioId | Setup | Correct decision | conceptId | Tags |
|---|---|---|---|---|
| `rg-01-inside-zone-cutback` | Inside zone right vs 4-3 over; `lb_1..3` flow right fast | Cutback lane: `A-L` (6 yd) | `inside-zone` | zone |
| `rg-02-inside-zone-b` | Inside zone left; nose shaded right A; the B-L crease opens behind a double team | `B-L` (5 yd) | `zone-blocking` | zone |
| `rg-03-outside-zone-cut` | Outside zone right (stretch); `dl_4` (edge) sets outside and runs with it; the C-R lane opens after the plant | `C-R` (7 yd) | `outside-zone` | zone |
| `rg-04-inside-zone-stack` | Inside zone right vs 3-4 with two linebackers stacked | `B-R` (4 yd) | `run-gap` | zone |
| `rg-05-power` | Power right: `ol_1` (left guard) pulls; RG double-teams with tackle; the puller kicks out the end | `B-R` (behind the puller, 8 yd) | `gap-scheme` | gap |
| `rg-06-counter` | Counter left: back steps right then cuts left; guard and tackle pull | `B-L` (7 yd) | `pulling-guard` | gap |
| `rg-07-light-box` | Six-man box (`light-box`), single-high safety; any inside gap works but `A-R` has a stunting LB | `B-L` or `A-L` (5 yd) | `light-box` | zone |
| `rg-08-short-yardage` | 3rd and 1, heavy box (8), dive | `A-R` (2 yd; others 0) | `run-gap` | gap, short |
| `rg-09-draw` | Draw play after pass rush upfield: rushers overrun; A-gaps open | `A-L` (9 yd) | `run-gap` | misc |
| `rg-10-stunt` | LB blitz through the A gap; the crease is behind him | `A-R` (6 yd) | `run-gap` | misc |
| `rg-11-edge-crash` | Edge defender crashes inside; bounce the run outside | `D-R` (7 yd) | `outside-zone` | hard |
| `rg-12-heavy-box` | 8-man box, one-hole answer: the back cuts to the weak-side B gap | `B-L` (3 yd) | `run-gap` | hard |

Full detail, first three:
- **rg-01**: front: `dl_1(-6,1)` (DE left), `dl_2(-2,1)`, `dl_3(1.5,1)`, `dl_4(6,1)` (DE right); `lb_1(-4,4.5)`, `lb_2(0,4.5)`, `lb_3(4,4.5)`. Fits: `dl_1: C-L`, `dl_2: B-L`, `dl_3: A-R`, `dl_4: C-R` (with contain), `lb_1: A-L`, `lb_2: B-R`, `lb_3: D-R`. Blocking (zone right): `ol_1..5` step right in unison (2 yd shift over 0.6 s). At t=0.9 s `lb_1` (whose fit is A-L) over-pursues right by 3 yd. Cut point at t=1.1 s. `gapYards`: `A-L` 6, `A-R` 1, `B-L` 2, `B-R` 1, `C-L` 0, `C-R` 0. `bestGaps=["A-L"]`. Explain key `zone-cutback`.
- **rg-02**: same front, mirrored: inside zone left with a double team on `dl_3` by the center and right guard; `lb_2` scrapes left. `gapYards`: `B-L` 5, `A-L` 2, `A-R` 1, `B-R` 0, `C-L` 1, `C-R` 0. Explain key `zone-b-gap`.
- **rg-03**: outside zone right. All OL take a lateral step right (stretch) 1.4 s. `dl_4` sets the edge and runs with the play; `lb_3` flows outside. The back presses the edge then plants at t=1.1 s and cuts. `gapYards`: `C-R` 7, `B-R` 4, `D-R` 0, `A-R` 2, `B-L` 1, `A-L` 0. Explain key `outside-zone`.
Others follow the same schema; `RunFit` verifies that the `gapYards` map has exactly one `bestGaps` (max yards, lead >= 2 yd over next), and that `fits` assign every defender near the line to exactly one gap.

## 12. Freeze / explain moments
Trigger: every round at the whistle. Freeze: the moment the back is tackled or scores. Camera: top-down. Callouts: gap letters (A, B, C, D) as eyebrow labels, each defender with an arrow to his assigned gap (rose), the best lane in gold, and a yards counter. Body copy below.

| explainKey | Outcome | Title | Body | Say this |
|---|---|---|---|---|
| `zone-cutback` | correct | You cut back. Big gain. | In inside zone the back reads the defender who flows too fast and cuts against him. That linebacker ran right, so the left A gap opened up behind him. | "He cut back off the flow." |
| `zone-cutback` | incorrect | Wrong side of the flow. | Zone runs bend the defense one way, and the open space is often opposite. The linebackers ran right, so the cutback lane was on the left. | "In zone, the hole is opposite the flow." |
| `zone-b-gap` | correct | Right at the crease. | Two blockers on one tackle create a seam next to him. The back sees the wall and hits the crease in the B gap for a solid gain. | "That's just inside zone, one cut and go." |
| `zone-b-gap` | incorrect | The wall was elsewhere. | A double team moves one defender and opens a crease next to him. Look for where two blockers work together, not where the defenders are thick. | "Follow the double team." |
| `outside-zone` | correct | Stretch, plant, cut. | Outside zone drags the defense sideways. Once the edge defender commits, the back plants and cuts upfield through a lane. You waited for it. | "Outside zone: stretch it, then get vertical." |
| `outside-zone` | incorrect | Too early. Let it stretch. | Outside zone works because the defense runs sideways. Cutting inside too soon meets defenders who have not moved. Press the edge, then plant. | "Be patient on outside zone." |
| `power-gap` | correct | Follow the guard. | Power is a gap scheme. A guard pulls across the line and leads the way, and the runner follows his hip. The hole opens behind the puller. | "The guard pulled and he followed him through." |
| `power-gap` | incorrect | Trust the puller. | In a gap scheme, linemen block assigned spots and a guard pulls to lead. Cutting away from the puller means running into the defense he was clearing. | "Follow the puller." |
| `counter-gap` | correct | Counter it. Cut left. | The counter starts one way, then cuts back behind two pullers. The defense flowing the first way leaves the backside open. | "Counter fools the defense with a misdirection." |
| `counter-gap` | incorrect | It was a counter. | The back fakes one direction while a guard and tackle pull the other way. Follow the pullers, not the first step. | "Counter goes against the grain." |
| `light-box` | correct | Light box, easy yards. | Only six defenders are near the line, so a run has fewer bodies to beat. Coaches call the run when the box is light. | "They're in a light box, so we should run." |
| `light-box` | incorrect | Not all gaps are equal. | Even in a light box, a stunting linebacker can plug a gap. Look for the gap he left, not the one he filled. | "Light box helps, but read the stunt." |
| `short-yardage` | correct | One yard. You got it. | On third and one, the only gap that matters is the one to the marker. Heavy boxes mean everything is blocked; you found the seam. | "Third and one, they dove for the marker." |
| `short-yardage` | incorrect | Short yardage is tight. | With eight defenders near the line, most lanes are shut. Look for the seam where blockers moved a defender off his gap. | "Short yardage is a rugby scrum." |
| `draw` | correct | Fooled them with a draw. | The line pretends to pass block, defenders rush upfield, and the back takes a quick handoff through the space they left. | "That draw caught them rushing." |
| `draw` | incorrect | They were upfield. | On a draw, the pass rushers overrun the play. The space is right where they came from. | "A draw punishes an aggressive rush." |

## 13. Scoring & mastery signals
- Round score: gap yards >= `targetYards` and the lane is in `bestGaps`: 100; yards >= `targetYards`: 80; yards 1 to target-1: 40; else 0. Hint = -10. Session score = round(mean). Accuracy = rounds with yards >= `targetYards` / rounds.
- Outcome ids `round-1..3`; `value` = chosen gap id.

| mistake | conceptId | description |
|---|---|---|
| Went with the flow on inside zone | `inside-zone` | Ran into the flow instead of cutting back. |
| Cut too soon on outside zone | `outside-zone` | Cut inside before the stretch. |
| Ignored the puller | `gap-scheme` | Ran away from the puller. |
| Missed the double team crease | `zone-blocking` | Missed where two blockers were working. |
| Missed a counter | `pulling-guard` | Followed the first step, not the pullers. |
| Ignored a light box | `light-box` | Did not notice a light box. |
| Ran into a filled gap | `run-gap` | Ran into a gap that a defender filled. |

| event | conceptId | delta | evidence |
|---|---|---|---|
| Best gap, no hint | scenario concept | +0.25 | "Found the lane on {playCall}." |
| Best gap with hint | scenario concept | +0.10 | same |
| Any gap >= target | `run-gap` | +0.10 | "Reached the target yardage." |
| Gap < target | scenario concept | -0.10 | "Missed the lane." |
| Named gap letter correctly in explain (auto, from choice) | `run-gap` | +0.05 | "Chose a gap letter with the right fit." |
Caps: +0.40 / -0.20 per concept per session.

## 14. XP & hearts
`xpEarned` = 10 per round with yards >= target + 40 for finishing. `heartsLost` = 1 if >= 2 of 3 rounds below target. `replayAvailable` = true after any round.

## 15. Failure states
| Case | Learner sees | Result | Hearts |
|---|---|---|---|
| Stuffed run | Back tackled in the backfield, comic freeze, explain with the open lane | round failed | session rule |
| Timer ended (L3+) | Back takes the nearest gap to his path, then explain | as scored | session rule |
| Session failed | "Holes close fast. Try again?" | `completed=true`, low score | 1 |
| Abort / asset / config | standard | | 0 |

## 16. Accessibility
Reduced motion: no camera blends, slow-mo becomes a hold frame, no shake. Color-blind: gap rings carry letters, defenders' fit arrows are solid lines with arrowheads, best lane has a bracket glyph. Text scale honored. Tap-only. VoiceOver: native fallback `run-gaps-05-fallback`.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Handoff | leather slap | soft tap | 0.5 |
| Tap gap | click | soft tap | 0.4 |
| Gain >= target | gold chime | light success | 0.7 |
| Stuffed | thud | warning | 0.5 |

## 18. Art & asset list
| asset | procedural / external | source & license | size | notes |
|---|---|---|---|---|
| Field, characters (up to 15) | procedural | own | < 1 MB | |
| Gap rings, arrows | procedural | own | 0 | |
| Fonts/audio | OFL / original | `original-swoond` | < 2 MB | |
Bundle `sim-football-run-gaps`, < 5 MB.

## 19. Performance budget
Defaults; tighter: <= 16 characters, <= 60 draw calls, memory <= 110 MB, `ready` <= 1.5 s.

## 20. Telemetry
`hintsUsed`, `decisionLatencyMsMean`, `yardsMean`, `bestGapRate`, `scenarioIds`, `playCalls`.

## 21. Acceptance criteria (testable)
1. AC-1: With seed 21, difficulty 2, 3 rounds: exactly 3 outcomes.
2. AC-2: Each scenario has exactly one best gap with a lead >= 2 yd (data test).
3. AC-3: `fits` covers every near-line defender exactly once.
4. AC-4: Running through a gap yields exactly its `gapYards` (+/- 0.5 yd) in PlayMode.
5. AC-5: Determinism by seed.
6. AC-6: Result validates; bridge lifecycle conformance.
7. AC-7: Copy limits.
8. AC-8: Reduced motion: no blends.
9. AC-9: Gap rings hit area >= 44 pt at 375x667.
10. AC-10: Hearts rule.
11. AC-11: Perf on iPhone 13-class: p5 >= 50 fps, memory <= 110 MB.
12. AC-12: Invalid config gives `CONFIG_INVALID`.
13. AC-13: No personal fields in logs.
14. AC-14: Level 1 has fits overlay always on and no timer.

## 22. Test plan
| AC | Type | Test |
|---|---|---|
| AC-1, AC-5 | PlayMode | `RunGaps_FullRun_Seed21_Deterministic` |
| AC-2, AC-3 | EditMode | `Scenarios_Valid_BestGap_And_Fits` |
| AC-4 | PlayMode | `GapRun_YardsMatchData` |
| AC-6 | EditMode | `Bridge_Conformance` |
| AC-7 | EditMode | `Explanations_CopyLimits` |
| AC-8 | PlayMode | `ReducedMotion_NoBlend` |
| AC-9 | PlayMode | `TouchTargets_MinSize` |
| AC-10 | EditMode | `Hearts_Rule` |
| AC-11 | Perf | `Perf_iPhone13_RunGaps` |
| AC-12 | EditMode | `Config_Invalid` |
| AC-13 | EditMode | `Privacy_NoPersonalFields` |
| AC-14 | EditMode | `Difficulty_L1_Params` |
Plus scripted-tap PlayMode run, freeze/explain sequence, pause/resume/abort.

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is 2 yd OL spacing acceptable for legibility on a phone? | Astra | No |
| 2 | Should the timeout choice be the nearest gap or a fixed "stuffed" result? | Product | No |
| 3 | Add running-back vision ("cone of vision") overlay for teaching zone reads? | Product | No |
