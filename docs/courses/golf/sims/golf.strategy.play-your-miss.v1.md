# Course Management: Play Your Miss (`golf.strategy.play-your-miss.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `golf.strategy.play-your-miss.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (hand-coded at v1) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `golf`; `unitId` `course-management`; `lessonId` `mgmt-02` ("Play your miss").
- CDS row: section 12, "`mgmt-02`: Play your miss".
- Manifest: `docs/courses/golf/manifest.json` -> `unitySimulations[2]`.
- Prerequisite concepts (else a native primer first): `course-management`, `risk-reward`, `carry-distance`. Primer: a `decision-scenario` on aiming at the middle of a green.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can look at a hole, picture the spread of your own shots, and aim where the bad ones are still fine."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `dispersion` | Dispersion | Say that every golfer's shots land in a spread (an oval), not on one spot. |
| `play-your-miss` | Play your miss | Shift the aim away from the trouble the golfer's typical miss would find. |
| `risk-reward` | Risk and reward | Weigh a tempting line against the cost of trouble, using expected outcome instead of hope. |
| `safe-side` | Safe side | Choose the side of the target where a miss is survivable. |
| `pin-position` | Pin position | Explain why a tucked flag should not always be attacked. |
| `short-sided` | Short-sided | Recognise the side of a green with little room and trouble close by. |
| `layup` | Layup | Decide when a shorter club and a full-wedge leave beat going for it. |
| `par-5-strategy` | Par-5 strategy | Compare going for a par 5 in two with playing it as three shots. |
- **Out of scope:** exact yardage calculations, wind and elevation (native `mgmt-05`), green reading, swing changes, statistics tables from the professional game (the sim uses an illustrative, original expected-strokes table for teaching, see section 11).

## 4. Why Unity (tier justification)
- **Signals:** *spatial reasoning over a map* and *reading a dynamic scene*: the core idea is where the mass of a two-dimensional distribution falls relative to hazards as the aim point moves. The learner drags the aim and watches the oval slide into the water or out of it.
- **Closest native:** `decision-scenario` (facts table: "water right, you miss right, where do you aim?") states the answer but cannot show the oval moving across the hazard or the percentages changing as the aim moves; the insight ("the middle is not always safest, the safest aim is off-center by a margin") is quantitative and visual.
- **Fallback:** native lesson `mgmt-02-native`: four `decision-scenario` items (water right / OB left / short-sided pin / layup), each with a top-down diagram and an `expertNote`, plus two `hotspot-tap` items (tap the safest aim point on a diagram with an oval drawn on it).
- Retained. Justification: moderate to strong (it is the concept that separates a good decision from a hopeful one).

## 5. Player fantasy & core loop
- **Fantasy:** "You are your own caddie, and you know exactly where your bad shots go."
- **Loop:**
  1. Prompt: the hole card (par, yardage, hazards, your typical miss).
  2. Decision: drag the aim reticle (and, in some rounds, pick a club) on the top-down map; the dispersion oval follows.
  3. Execute: one shot is played from the oval using the seeded RNG (drama, not truth).
  4. Freeze: a scatter of 100 balls appears (the true picture), with zone percentages and expected strokes versus the best aim.
  5. Explain: title, body, "say this" line.
- **Session:** about 3 minutes, 3 rounds by default (3-6).

## 6. Scene & entities
- **Environment:** `golf_hole` in top-down orthographic-style view (`top-down` camera); low-poly hazards; optional `broadcast-high-behind` preview at intro only.
- **Units/coords:** meters in world; spec in yards. Origin at the aim reference (fairway center at the landing depth for tee shots, green center for approach shots); +x right of the target line for a right-hander; +z down-range. Handedness `left` mirrors x and the bias sign.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `hole` | `Golf` env `golf_hole` | Fairway, rough, trees, water, bunkers, green, OB stakes | zones from scenario data |
| `zones` | `Zone` x N | Playable regions with strokes-remaining costs | `E` values from the table in section 11 |
| `aim` | `Target` (free placement, GK-1/GK-2 style drag) | The aim reticle | rose ring; hit >= 64 pt |
| `oval` | `DispersionOverlay` (new Highlight variant) | The spread of shots (50% and 90% rings) | sigma lateral, sigma depth, bias |
| `clubChips` | `DecisionPoint` chip selector (GK-3) | Club choice in club rounds | e.g. driver / 3-wood; layup / go |
| `ball` | `Ball` | Sampled shot | seeded landing point |
| `scatter` | `Highlight` | 100-point scatter at freeze | deterministic from seed |
| `bars` | `TraceChart`-style overlay (GK-16 style) | Zone percentage bars and expected strokes | native fonts from theme |
| `ghostBest` | `Highlight` (gold outline) | Best aim (hint at low levels) | shown at L1 only |
| `explain`, `score`, `replay`, `hints` | `Explanation`, `Score`, `Replay`, `Hint` | as per kit | |
- **New primitives:** `DispersionOverlay` (generic: an anisotropic Gaussian oval with confidence rings, reusable for tennis/pickleball serve targeting, football throwing, archery), and the golf-module pure functions `DispersionModel` (zone masses by 1-yard grid integration, expected strokes) and `StrokesTable`. Justified because dispersion is the sim's concept and is reusable outside golf.
- **Layout:**
```
            [ green ]
              |
   trees | . fairway ( oval ) . | rough | WATER ->
              |
        (aim reticle)  <- drag
   bars:  Fairway 54%  Rough 41%  Water 3%    Expected strokes 3.79
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Place the aim | Drag the reticle on the map, or tap a point | `aim` | 64 pt | Oval and percentages update live (per level) |
| Choose a club (club rounds) | Tap a chip | `clubChips` | 56 pt | Oval resizes and shifts in depth |
| Hit | Tap "Play it" (primary pill) | button | 56 pt | Ball flies |
| Hint | Tap "Hint" | button | 44 pt | Ghost best aim or text |
| Next | Tap | Primary pill | 56 pt | |
- **Tap-only scheme:** `controlScheme: "steppers"`: the aim moves with left / right buttons in 5-yard steps and up / down buttons for depth; club by chips.
- **Portrait**, safe-area insets respected; controls in the bottom third.
- **Not drawn by Unity:** hearts, paywall, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build the hole and zones, load scenario set and profile | Ready or error | `ready` |
| Intro | ready | Hole card, "your miss" line, preview camera | Decision | `progress` |
| Decision | after intro | Learner moves the aim (and club); overlays per level; hints | Executing | none |
| Executing | "Play it" | One seeded sample shot flies to the landing point | Freeze | none |
| Freeze | Landing | Time eases to 0; 100-ball scatter, zone bars, expected strokes; best aim gold outline | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | Card (section 12) | Next | `checkpoint round-N` |
| Summary | last round | Score numerals | Done | `progress 1.0` |
| Done | summary | `result` then `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze; partial result `aborted true`, `xpEarned 0` | resume / end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Dispersion oval visible during aim | yes (live) | yes (live) | yes (live) | no (shown as a 10-shot history scatter) | no (miss described in words) |
| Zone percentages live | yes | yes | no | no | no |
| Best aim ghost | yes | no | no | no | no |
| Aim grid | 5 yd | 5 yd | 5 yd | 3 yd | 3 yd |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Scenario pool | ym-01, ym-03, ym-09 | + ym-02, ym-04, ym-10 | + ym-05, ym-06 | + ym-07, ym-08, ym-11 | + ym-12 |
| Decision time limit (s) | none | none | none | 40 | 25 |
- Default for `mgmt-02`: **2**. L1 passable by a true beginner: the oval and percentages are live and the best aim is outlined.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "golf.strategy.play-your-miss.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["plan-starter", "plan-clubs", "plan-trouble", "plan-mixed"], "default": "plan-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "skillProfile": { "type": "string", "enum": ["beginner", "mid", "low"], "default": "mid", "description": "Sets dispersion sigma; native maps the Person's skill-level to this. Scenarios that fix a profile (ym-06, ym-10, ym-11) ignore it." },
    "handedness": { "type": "string", "enum": ["right", "left"], "default": "right" },
    "controlScheme": { "type": "string", "enum": ["drag", "steppers"], "default": "drag" },
    "showDispersion": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." },
    "showPercentages": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." },
    "displayUnits": { "type": "string", "enum": ["yards", "meters"], "default": "yards" }
  }
}
```
Valid example: `{ "seed": 21, "scenarioSetId": "plan-starter", "scenarioCount": 3, "skillProfile": "mid" }`. Invalid configuration yields `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Scenarios/plan-v1.json` (bundle `sim-golf-plan`). Sets: `plan-starter` = ym-01, ym-02, ym-03, ym-04; `plan-clubs` = ym-05, ym-06, ym-07, ym-12; `plan-trouble` = ym-08, ym-09, ym-10, ym-11; `plan-mixed` = all 12. Deterministic by seed (order, and the sampled shot and the 100-ball scatter come from the seeded `Rng`).
- **N = 12 scenarios** (3 x 4).
- **Dispersion model (normative; pure function).** Landing point ~ independent normals: lateral mean = aim + `bias` (yards; positive = right), lateral sigma `sx`, depth mean = aimed depth, depth sigma `sz`. Zone masses are computed by summing the density on a 1-yard grid within 4 sigma (not by random sampling), so the score is deterministic and independent of the sampled shot. Profiles (driver-like clubs; approach clubs use the scenario's own sigmas): `beginner` sx 28, sz 16; `mid` sx 20, sz 12; `low` sx 14, sz 9.
- **Expected strokes model (illustrative, original, for teaching; not derived from any proprietary dataset).** `E` = strokes to hole out from a lie, for a mid-handicap golfer. Values used: fairway about 170 yd out 3.60, rough 3.95, trees 4.30, water 4.60 (penalty and drop), out of bounds 4.95 (stroke and distance), fairway bunker 4.05 to 4.60 (per scenario), green 1.5 + 0.084 x distance-to-pin (yd), capped at 2.9, greenside bunker 2.95, rough around a green 2.75, water short of a green 3.70 to 4.30. Expected strokes for an aim = sum of zone mass x `E` (+1 for the shot itself when comparing shots that end in different places).
- **Regret and points.** `regret = EV(aim, club) - EV(best aim and club on the grid)`. Points: regret <= 0.02 gives 1.0; <= 0.06 gives 0.7; <= 0.12 gives 0.4; otherwise 0. The golden generator writes the best aim and the EV table to fixtures; the numbers below are its expected output (values are non-normative until the generator runs).
- **Scenario shape:**
```json
{ "scenarioId": "ym-01", "profile": "mid", "bias": 6, "club": "driver", "depth": 230,
  "zones": [ { "name": "fairway", "x0": -15, "x1": 15, "E": 3.60 }, { "name": "water", "x0": 35, "x1": 999, "z0": 200, "z1": 300, "E": 4.60 } ],
  "reference": { "bestAimX": -10, "bestEV": 3.785 }, "teaches": ["play-your-miss", "safe-side"], "tags": ["L1+"] }
```
- **Scenarios** (x is yards right of the fairway or green center; regret values are against the best option in the grid):

| scenarioId | Setup | Correct decision/outcome | Teaches | Difficulty tags |
|---|---|---|---|---|
| `ym-01` | Par 4, 400 yd. Water down the right from 200 to 300 yd (starts 35 yd right of center); trees left. Mid profile with a fade that leaks 6 yd right. Driver, landing depth 230. | Best aim 10 yd left of center (EV 3.785). Aims -15 to -5 earn full points. Center (EV 3.818, regret 0.033) earns 0.7; aiming 10 yd right (3.921, regret 0.136) earns 0. | `play-your-miss`, `safe-side` | driver, water, L1+ |
| `ym-02` | Same hole, no bias (an even miss). | Best aim 5 yd left (EV 3.786); center is within 0.004 (full points). Aiming 20 yd left costs 0.072. The middle is fine when the miss is even. | `dispersion`, `play-your-miss` | driver, water, L2+ |
| `ym-03` | Par 3, 165 yd. Pin 10 yd right of green center, 5 yd from the right edge; bunker right; mid 7-iron sigma 9 lateral, 7 depth. | Best aim 7 yd right of center (EV 2.436). Aiming at the flag (+10) has regret 0.036 (0.7); center 0.080 (0.4). | `pin-position`, `short-sided`, `safe-side` | approach, L1+ |
| `ym-04` | Par 3. Pin 10 yd left of center, 5 yd from the left edge with water beyond; bunker right; same sigmas. | Best aim 4 yd left of center (EV 2.506). At the flag (-10) regret 0.118 (0.4); -7 regret 0.028 (0.7); center 0.041 (0.7). | `pin-position`, `safe-side` | approach, water, L2+ |
| `ym-05` | Par 5, second shot from 245 yd out: water short of the green (front at 235), bunkers around, mid profile (sigma 22 lateral, 14 depth). Options: go (3-wood at aim depth 240 to 255) or lay up to about 100 yd. | Layup total 3.95 versus best go aim (255 yd) 3.96: both earn full points; going at 245 (regret 0.16) or 240 (0.33) earns 0. Not going for it is a fine decision at this level. | `layup`, `par-5-strategy`, `risk-reward` | par-5, L3+ |
| `ym-06` | Same hole, low profile (sigma 14, 9). | Go for it: aim depth 250 (total 3.65) versus layup 3.95: layup regret 0.30 earns 0; 255 (regret 0.02) earns full. The same hole, a different answer. | `par-5-strategy`, `risk-reward` | par-5, L3+ |
| `ym-07` | Par 4 dogleg. Fairway bunker on the left from 222 to 252 yd (x -28 to -6); fairway is 30 yd wide. Options: driver (mean 236, sigma 20/12) or 3-wood (mean 212, sigma 16/10). | Best: 3-wood aimed 5 yd right (EV 3.853). Driver best aim 15 yd right has EV 3.922 (regret 0.069, 0.4); driver at center 3.983 (0.13, 0). | `risk-reward`, `dispersion` | club choice, L4+ |
| `ym-08` | Par 4. Out of bounds left of the rough (starts 25 yd left of center); mid profile with a hook that leaks 6 yd left. Driver at 230. | Best aim 15 yd right (EV 3.846); +10 regret 0.004; +5 0.033; center 0.088 (0.4); aiming left 0. | `play-your-miss`, `safe-side` | OB, L4+ |
| `ym-09` | Par 3, 165 yd. Water short of the green (green depth 158 to 185, 28 yd wide). Approach sigma 10 lateral, 8 depth. Learner chooses the aim depth (club). | Aim about 175 (EV 2.408). Aim 170 regret 0.027 (0.7); 180 regret 0.095 (0.4); 165 regret 0.217 (0). Take enough club. | `risk-reward`, `safe-side` | approach, water, L1+ |
| `ym-10` | Hole of ym-01 with a low profile (sigma 14, 9) and no bias. | Best aim center (EV 3.704). Aims from 5 left to 5 right earn full points; 10 left earns 0.7. A tighter miss shrinks the safe margin. | `dispersion`, `play-your-miss` | driver, low, L2+ |
| `ym-11` | Hole of ym-01 with a beginner profile (sigma 28, 16) and a 6-yd right bias. | Best aim 15 yd left (EV 3.885); center regret 0.035 (0.7); aiming 10 yd right regret 0.109 (0.4). A wider miss needs a bigger margin. | `dispersion`, `play-your-miss` | driver, beginner, L4+ |
| `ym-12` | Par 5 layup. Cross-bunkers 25 to 45 yd short of the green. Learner picks the leave distance (60, 80, 100, 120, 140 yd). Sigma 10 depth. | Best leave 100 yd (a full wedge; EV 2.992). Leave 60 regret 0.126 (0); leave 80 regret 0.050 (0.7); leave 120 regret 0.086 (0.4). | `layup`, `par-5-strategy` | par-5, layup, L5 |
- **Rules to generate more:** pick a hazard shape (water, OB, fairway bunker, short-sided pin), a profile and bias, then compute the EV grid; require that (a) the best aim differs from the naive center or flag by at least 3 yd, or the scenario explicitly teaches "center is fine"; (b) at least 3 aims earn full points; (c) at least one plausible aim earns 0.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-best` | Regret <= 0.02 | Gold best-aim outline; scatter; bars | Correct | Nice read. You played your miss. | Your bad shots land in this oval. You aimed so most of it stays out of trouble, and the expected score shows it. That is course management. | "I aimed where my miss is still fine." |
| `x-ok` | Regret <= 0.06 | Gold best aim outline offset from yours | Partial | Good. There was a better spot. | Reasonable, and only slightly worse than the best aim. The best spot is a bit further from the trouble. | "Just a bit more room from the water." |
| `x-poor` | Regret <= 0.12 | Scatter shading in trouble | Partial | Close. The oval touched trouble. | A chunk of your shots reached the hazard. Slide the aim away and look at the percentage drop. | "Move the aim away from the trouble." |
| `x-bad` | Regret > 0.12 | Trouble zone red-tinted with percentages | Incorrect | Not quite. That's a lot of trouble. | Look at the bars: too many shots find the hazard. The safest aim is not always the middle, and never the flag when the flag is tucked. | "I'm not aiming at the flag when it's short-sided." |
| `x-center` | Centered aim on a scenario with a bias | Bias arrow on the oval | Incorrect or Partial | Your miss leans one way. | Your typical miss leans right, so the oval sits right of where you aim. Aim left of the middle so the whole oval lands better. | "My miss goes right, so I aim left." |
| `x-even` | ym-02 or ym-10 resolved | Symmetric oval on the fairway | Correct | Nice read. The middle works. | With an even miss and wide fairway, the middle is good. Play your miss does not mean always aim away. It means know your miss. | "When my miss is even, I just aim at the middle." |
| `x-layup` | ym-05 layup choice | Two bars: layup vs go | Correct | Nice read. Layup is a real play. | Going for it lost as many strokes as it gained for a mid-handicap golfer. A layup to a full wedge is not scared; it is smart. | "Laying up isn't giving up." |
| `x-go` | ym-06 go choice | Two bars: layup vs go | Correct | Nice read. You can go here. | A tighter miss changes the maths. The same water, a smaller oval, and going for it is worth more than the layup. | "For a good player, it's worth going." |
| `x-clubdown` | ym-07 3-wood aimed 5 right | Bunker zone and both ovals | Correct | Nice read. Club down. | A shorter club shrinks the oval and stays short of the bunker. You give up distance for a much better spread. | "I took 3-wood to keep it out of the sand." |
| `x-timeout` | Timer expired | Aim stays where it was | Timeout | Time's up. Try again. | Time ran out and the shot went with your last aim. That is a fine moment to check the oval against the trouble. | "Look at where the bad ones go." |

## 13. Scoring & mastery signals
- **Round points:** from regret as in section 11 (1.0 / 0.7 / 0.4 / 0); hint penalty -0.1 each (floor 0.4 for a 1.0 round).
- **Score (0-100):** `round(100 * mean(roundPoints))`. **accuracy** = rounds with points >= 0.7 / rounds.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Aimed at the center or the flag despite a biased miss | `play-your-miss` | Ignored which way the typical miss leans. |
| Aimed straight at trouble's edge (too little margin) | `dispersion` | Ignored the width of the spread. |
| Attacked a short-sided pin | `pin-position` / `short-sided` | Took on a flag with no margin. |
| Aimed too far from trouble (gave away strokes) | `risk-reward` | Over-corrected: too much rough or trees. |
| Went for a par 5 with a wide miss over water | `par-5-strategy` | Ignored the water and the layup value. |
| Chose the wrong leave distance | `layup` | Left an awkward partial wedge. |
| Took driver over a fairway bunker | `risk-reward` | Did not weigh club choice against the bunker. |
- **Mastery signals:** best or ok aim -> `play-your-miss` +0.15, `dispersion` +0.10; short-sided scenarios correct -> `pin-position` +0.15, `short-sided` +0.15, `safe-side` +0.10; par-5 scenarios correct -> `par-5-strategy` +0.20, `layup` +0.10 or `risk-reward` +0.10; `x-even` correct -> `dispersion` +0.15; mistakes -0.15 to the mapped concept. Caps +-0.30 per concept; hints halve positives (native).
- **Result mapping:** `outcomes[]` per round (`id` `round-N`, `success`, `label`, `value` = `{ "regret": ..., "aimX": ..., "bestAimX": ..., "club": "..." }`); `mistakes[]`; `masterySignals[]`.

## 14. XP & hearts
- `xpEarned` proposal: +10 per round with points >= 0.7, +5 for 0.4, +40 for finishing; native clamps.
- `heartsLost` = 1 if accuracy < 0.34, else 0; max 1.
- `replayAvailable` true (deterministic re-run via seed).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Poor round | Explain card (`x-bad`, `x-center`) | outcome false + mistake | none |
| Failed session | "Course management is a habit. Two more and the oval will feel obvious." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Shot uses the current aim; explain | see `x-timeout` | none |
| Abort/backgrounded | Native flow | `aborted true`, `xpEarned 0` | none |
| Asset missing / invalid config | Native error sheet | `error` events (`CONFIG_INVALID`) | none |
Always ends in an explain moment.

## 16. Accessibility
- **Reduced motion:** no camera moves (the view is fixed); the freeze is a hard cut; the scatter appears at once (no staggered animation); no shake.
- **Haptics:** `hapticsEnabled` respected; reticle ticks skipped when off.
- **Color-blind:** zones use hatch patterns and text labels (WATER, OB, BUNKER); oval rings are solid and dashed; best aim outline is gold and dashed, yours rose and solid.
- **Text scale** honored; bars use numerals and labels.
- **Tap-only:** `controlScheme: "steppers"` completes everything with taps.
- **VoiceOver:** Unity is limited; the native fallback `mgmt-02-native` gives the same concept credit.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Reticle move | Soft tick per 5 yd | light tick |
| Shot | Original strike sound | soft tap |
| Scatter appears | Soft patter | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
All honor `soundEnabled` / `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural? | Source/license | Budget |
|---|---|---|---|
| Hole map, zones, hazards, trees | Procedural | `original-swoond` | < 6k tris |
| Overlays (oval, bars, reticle, scatter) | Procedural | n/a | n/a |
| Golfer (intro only) | Procedural | `original-swoond` | < 3k tris |
| Audio | Original synthesis | `original-swoond` | <= 1 MB |
Bundle `sim-golf-plan`, <= 4 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md` apply. Tighter: the dispersion integration (about 20,000 grid cells) runs in under 2 ms per aim update (cache per aim); memory < 90 MB; cold launch < 2 s; draw calls <= 100.

## 20. Telemetry
`avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `aimMovesPerRound`, `decisionLatencyMsMedian`, `regretMean`, `skillProfile`, `controlScheme`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** With seed 21, difficulty 2, 3 rounds, exactly 3 `outcomes`; repeating gives identical outcomes and identical scatter points.
2. **AC-2:** `DispersionModel` fixtures: for the 12 scenarios, zone masses and expected strokes at the listed aims match the values in section 11 within 0.005 (EV) and 0.02 (mass).
3. **AC-3:** The best-aim search over the grid returns the listed best aim for every scenario (12 fixtures).
4. **AC-4:** Regret-to-points mapping fixtures at the thresholds 0.02, 0.06, 0.12 (both sides).
5. **AC-5:** Left-hander mode mirrors x and bias; results equal by symmetry.
6. **AC-6:** Zone masses sum to 1.0 +- 0.001 (within 4 sigma; renormalised) for every aim on the grid.
7. **AC-7:** Generated scenarios satisfy rules (a), (b), (c) of section 11 (property test over 300 seeds).
8. **AC-8:** `ready` < 2 s; `result` schema-valid; exactly one result.
9. **AC-9:** Steppers scheme completes a run with no drag events.
10. **AC-10:** Pause/resume freezes the timer and animation; abort yields `aborted=true`.
11. **AC-11:** Copy lint: titles <= 6 words, bodies <= 45 words, all outcomes have copy.
12. **AC-12:** Reduced motion path has no camera moves or staggered animation; color-blind second channel present.
13. **AC-13:** Invalid config yields `CONFIG_INVALID`.
14. **AC-14:** Perf: p5 >= 50 fps, memory < 90 MB on iPhone 13-class; aim update < 2 ms.
15. **AC-15:** Mastery signal caps +-0.30 per concept.

## 22. Test plan
- **EditMode:** `DispersionModel` fixtures, best-aim search, points mapping, mirror test, scenario generation property test, config validation, scoring, determinism, copy lint, result schema.
- **PlayMode:** scene builds from code; scripted drag and stepper runs; freeze/explain; pause/abort; reduced motion; colour-blind snapshot.
- **Perf:** iPhone 13-class 3-round run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Plan` |
| AC-2, AC-6 | EditMode | `Dispersion_Fixtures`, `Masses_Sum` |
| AC-3 | EditMode | `BestAim_Fixtures` |
| AC-4 | EditMode | `Regret_Points` |
| AC-5 | EditMode | `Mirror_LeftHander` |
| AC-7 | EditMode | `Scenario_Property` |
| AC-8 | PlayMode | `ColdLaunch_Result_Schema` |
| AC-9 | PlayMode | `Steppers_FullRun` |
| AC-10 | PlayMode | `Pause_Abort` |
| AC-11 | EditMode | `Copy_Lint` |
| AC-12 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-13 | EditMode | `Config_Invalid` |
| AC-14 | Perf | `Perf_iPhone13` |
| AC-15 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Add the `Golf` module (`DispersionModel`, `StrokesTable`) and the generic `DispersionOverlay` Highlight variant; a golden generator for the EV fixtures. | Astra | Yes |
| 2 | SME (PGA professional or golf coach) review of the expected-strokes values and the profile sigmas; the table is illustrative and must not be presented as tour data. | Product | Yes for approval |
| 3 | Should the profile come from the Person's handicap band automatically (native maps `skill-level` to `skillProfile`)? Proposed yes. | Claude | No |
| 4 | Do we show one sampled shot before the scatter, or skip it to avoid "results-based thinking"? Proposed: show one shot, then the scatter with copy that says one shot is not the answer. | Claude/Product | No |

### Game Kit additions requested
- `Golf` module: `DispersionModel`, `StrokesTable`, `golf_hole` environment (shared with the other golf sims).
- `DispersionOverlay` (Highlight variant; generic; reusable for serve, throw and shot-placement sims).
- GK-3 chip selector for club choice; GK-16 style bar chart overlay; GK-1/GK-2 style free placement target.
