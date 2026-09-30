# Short Game: Carry and Roll (`golf.short-game.carry-and-roll.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `golf.short-game.carry-and-roll.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (hand-coded at v1) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `golf`; `unitId` `short-game-and-putting`; `lessonId` `short-05` ("Carry and roll").
- CDS row: section 12, "`short-05`: Carry and roll".
- Manifest: `docs/courses/golf/manifest.json` -> `unitySimulations[3]`.
- Prerequisite concepts (else a native primer first): `chip`, `pitch`, `flop`, `bump-and-run` (from `short-04`), `green-speed-stimp` (from `short-03`).

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can pick a landing spot and a club so the ball carries to one place and rolls out to the flag."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `landing-spot` | Landing spot | Choose where the ball should first touch down instead of aiming at the flag. |
| `carry-and-roll` | Carry and roll | Explain that total distance is carry plus roll and that roll depends on club, green speed and slope. |
| `bump-and-run` | Bump-and-run | Use a low club (7-iron) so most of the distance is roll. |
| `chip` | Chip | Use a 9-iron or pitching wedge for a low shot with a balanced carry and roll. |
| `pitch` | Pitch | Use a sand wedge for a higher shot with more carry. |
| `flop` | Flop | Use a lob wedge when there is little green and a lot of trouble to carry. |
| `green-speed-stimp` | Green speed | Explain that faster greens roll more (reinforced from putting). |
- **Out of scope:** spin and check behavior beyond the table, the technique of each shot, lies (tight vs fluffy), and bunker shots (native `short-06`).

## 4. Why Unity (tier justification)
- **Signals:** *physics* (flight then bounce then roll) and *camera perspective* (side-on to see carry and roll as two phases; top-down for the landing spot).
- **Closest native:** `estimate-slider` or `multiple-choice` about ratios ("PW: carry 1, roll about 1") teaches numbers, not the feel that changing the landing spot and the club produces the same finish or different ones. `hotspot-tap` on a static diagram can show a landing spot but not the roll-out.
- **Fallback:** native lesson `short-05-native`: three `decision-scenario` items (club and landing spot for a described lie), two `estimate-slider` items (how many yards of roll after a 5-yd carry with a 7-iron), and one `hotspot-tap` (tap the best landing spot on a diagram with the fringe and a bunker marked).
- Retained. Justification: moderate to strong; the sim is short, and it is the cheapest of the four sims to build (no terrain module needed).

## 5. Player fantasy & core loop
- **Fantasy:** "You are standing greenside and the shot is about where it lands, not where it ends."
- **Loop:**
  1. Prompt: the shot card (yards to the pin, green speed, slope, fringe or bunker).
  2. Decision: choose a club chip and drag the landing-spot marker.
  3. Execute: the ball flies, lands, then rolls out.
  4. Freeze at rest: side-on view with carry (rose) and roll (gold), distance to the pin.
  5. Explain: title, body, "say this" line.
- **Session:** about 3 minutes, 3 rounds by default (3-6).

## 6. Scene & entities
- **Environment:** `golf_hole` short-game preset (a fringe band, a green, a flag, an optional bunker); cameras `broadcast-side` (default, side-on) and `top-down` (landing spot placement and freeze).
- **Units/coords:** meters; spec in yards (distance to pin, landing spot) and feet (finish distance). Origin at the ball; +z toward the pin; +x right.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `fringe` | `Zone` | Fringe or rough band before the green | landing here multiplies roll by 0.7 |
| `green` | `Zone` | Putting surface | slope percent, Stimp |
| `bunker` | `Zone` | Optional greenside bunker between ball and green | start and end distance |
| `pin` | `Target` | The flag | distance per scenario |
| `landing` | `Target` (free placement along the line) | The learner's landing spot | rose ring; hit >= 64 pt |
| `clubChips` | `DecisionPoint` chip selector (GK-3) | 7-iron, 9-iron, PW, SW, LW | shows the carry:roll ratio at L1-2 |
| `ball` | `Ball` (phases: flight, bounce, roll) | The shot | apex per club; roll from the model |
| `trace` | `Path` + `Highlight` | Carry (rose) and roll (gold) | dashed at L1 preview |
| `golfer` | `Character` | Chipping stance (decorative) | `AnimState` chip |
| `explain`, `score`, `replay`, `hints` | `Explanation`, `Score`, `Replay`, `Hint` | as per kit | |
- **New primitives:** none generic. Requests `Golf` module `ShortGameModel` (pure function) and the `golf_hole` short-game preset. Reuses `Ball` with a new roll phase (`Ball.Roll(rollDistance, surfaceFactor)`), which is a small extension of the existing bounce API (GAME_KIT `Ball` has bounce; a roll phase is requested).
- **Layout:**
```
 side-on (broadcast-side):
   ball o~~~~~~ (carry) ~~~~~~o . . . (roll) . . .  |> pin
                     landing spot ^        fringe | green
   top-down: [ball] -----> [landing spot] -----> [pin]   (bunker band optional)
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Pick a club | Tap a chip | `clubChips` | 56 pt | Chip solid; ratio label (L1-2) |
| Set the landing spot | Drag along the line to the pin, or tap | `landing` | 64 pt handle | Marker; carry yards label |
| Practice (L4-5) | Tap "Practice" (max 1) | button | 44 pt | Ball plays, no score |
| Hit | Tap "Hit it" (primary pill) | button | 56 pt | Chip animation |
| Hint | Tap "Hint" | button | 44 pt | Suggests a club or a window |
| Next | Tap | Primary pill | 56 pt | |
- **Tap-only scheme:** `controlScheme: "steppers"`: landing spot moves with - / + buttons in 0.5-yard steps; clubs by chips.
- **Portrait**, safe-area insets respected; controls in the bottom third.
- **Not drawn by Unity:** hearts, paywall, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build the scene, load scenario set | Ready or error | `ready` |
| Intro | ready | Shot card | Decision | `progress` |
| Decision | after intro | Club and landing spot; overlays per level; hints; practice (L4-5) | Executing | none |
| Executing | "Hit it" | Flight to the landing spot (with carry noise per level), bounce, roll | Freeze | none |
| Freeze | At rest or in a hazard | Time eases to 0; side-on camera; carry rose, roll gold, distance label | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | Card (section 12); optional slow-mo replay | Next | `checkpoint round-N` |
| Summary | last round | Score numerals | Done | `progress 1.0` |
| Done | summary | `result` then `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze; partial result `aborted true`, `xpEarned 0` | resume / end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Ghost of resting spot (live) | yes | no | no | no | no |
| Carry:roll ratio shown on chips | yes | yes | no | no | no |
| Green speed shown | yes | yes | yes | yes | hidden |
| Carry noise (yd, std dev) | 0 | 0 | 0.3 | 0.4 | 0.5 |
| Success window used | 6 ft | 5 ft | 4 ft | 3 ft | 3 ft |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Practice shots | n/a | n/a | n/a | 1 | 1 |
| Scenario pool | cr-01, cr-03, cr-06 | + cr-04, cr-07 | + cr-05, cr-08, cr-10 | + cr-02, cr-11 | + cr-09, cr-12 |
| Decision time limit (s) | none | none | none | 40 | 30 |
- Default for `short-05`: **2**. L1 passable by a true beginner: ghost of the resting spot, ratio labels and a generous window.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "golf.short-game.carry-and-roll.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["cr-starter", "cr-slopes", "cr-hazards", "cr-mixed"], "default": "cr-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "controlScheme": { "type": "string", "enum": ["drag", "steppers"], "default": "drag" },
    "showRatios": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." },
    "showGhost": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." },
    "carryNoiseYards": { "type": ["number", "null"], "minimum": 0, "maximum": 1.5, "default": null, "description": "null = difficulty default." },
    "displayUnits": { "type": "string", "enum": ["yards", "meters"], "default": "yards" }
  }
}
```
Valid example: `{ "seed": 9, "scenarioSetId": "cr-starter", "scenarioCount": 3, "controlScheme": "drag" }`. Invalid configuration yields `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Scenarios/carry-roll-v1.json` (bundle `sim-golf-carry-roll`). Sets: `cr-starter` = cr-01, cr-03, cr-06, cr-07; `cr-slopes` = cr-03, cr-04, cr-08, cr-10; `cr-hazards` = cr-02, cr-05, cr-09, cr-12; `cr-mixed` = all 12. Deterministic by seed (order and carry noise).
- **N = 12 scenarios** (3 x 4).
- **Reference short-game model (normative; pure function, unit-tested).** Clubs and base roll ratio `r` (roll = r x carry on a flat green at Stimp 10, first bounce on the green): 7-iron 2.0 (bump-and-run), 9-iron 1.3 (chip), pitching wedge 0.9 (pitch), sand wedge 0.5 (high pitch), lob wedge 0.3 (flop). These ratios are illustrative teaching values, not measured data.
  - `r_eff = r x (stimp / 10) x slopeFactor x fringeFactor`. `slopeFactor` = `1 - 0.06 x u` for `u` percent uphill (toward the pin), or `1 + 0.08 x d` for `d` percent downhill. `fringeFactor` = 0.7 if the landing spot is in the fringe (before the green edge), else 1.
  - `total = landing x (1 + r_eff)` (yards from the ball). The finish distance from the pin = |total - pin| (converted to feet, 3 ft per yard).
  - A **bunker** between ball and green spans `[b0, b1]` yards from the ball: the shot fails as "in the bunker" unless the landing spot is at least 0.5 yd beyond `b1` (the ball must carry it).
  - Points: finish within the level window (section 9) earns 1.0; within twice the window 0.7; within three times 0.4; else 0. A bunker or a failed carry earns 0.
- **Scenario shape:**
```json
{ "scenarioId": "cr-01", "pinYd": 12, "stimp": 10, "slopePct": 0, "greenEdgeYd": 3, "bunker": null,
  "windows": { "7i": [3.7, 4.3], "9i": [4.8, 5.6], "PW": [5.8, 6.8], "SW": [7.4, 8.6], "LW": [8.5, 10.0] },
  "teaches": ["carry-and-roll", "landing-spot"], "tags": ["flat", "L1+"] }
```
- **Scenarios** (landing windows are landing distances from the ball, in yards, that finish within 3 ft of the pin, computed by the model above; `slopePct` positive = uphill toward the pin; `greenEdgeYd` = where the green starts; landing before it is fringe):

| scenarioId | Setup | Correct decision/outcome | Teaches | Difficulty tags |
|---|---|---|---|---|
| `cr-01` | Pin 12 yd, Stimp 10, flat, fringe for the first 3 yd. | Every club works if the landing spot is right: 7-iron 3.7 to 4.3; 9-iron 4.8 to 5.6; PW 5.8 to 6.8; SW 7.4 to 8.6; LW 8.5 to 10.0. Lower club, shorter carry. | `landing-spot`, `carry-and-roll` | flat, L1+ |
| `cr-02` | Pin 30 yd, Stimp 10, flat, bunker from 10 to 18 yd, green starts at 20 yd. | Must carry the bunker (landing at least 18.5): PW 18.6 to 19.0 (fringe landing); SW 20.0 to 20.6; LW 22.4 to 23.8. 7-iron and 9-iron land in or roll into the bunker. | `carry-and-roll`, `flop`, `pitch` | bunker, L4+ |
| `cr-03` | Pin 8 yd, Stimp 12 (fast), downhill 3 percent, fringe 1 yd. | 7-iron 1.8 to 2.2; 9-iron 2.4 to 3.0; PW 3.0 to 3.8; SW 4.1 to 5.1; LW 4.9 to 6.2. Downhill fast green: land it short and let it run, or use a high club. | `carry-and-roll`, `green-speed-stimp` | downhill, fast, L1+ |
| `cr-04` | Pin 15 yd, Stimp 9, uphill 4 percent, fringe 2 yd. | 7-iron 6.0 to 6.7; 9-iron 7.5 to 8.4; PW 8.7 to 9.9; SW 10.5 to 11.9; LW 11.7 to 13.2. Uphill kills roll, so carry more. | `carry-and-roll`, `landing-spot` | uphill, L2+ |
| `cr-05` | Pin 25 yd, Stimp 10, flat, green edge 15 yd (a long fringe). | 7-iron 10.1 to 10.8 and 9-iron 12.6 to 13.6 (both land in the fringe, roll cut by 30 percent); PW 14.8 to 15.0 (barely fringe); SW 16.1 to 17.3; LW 18.5 to 19.9. | `carry-and-roll`, `chip` | fringe, L3+ |
| `cr-06` | Pin 6 yd, Stimp 11, flat, green immediately (edge 1 yd). | 7-iron 1.6 to 2.1; 9-iron 2.1 to 2.8; PW 2.6 to 3.5; SW 3.3 to 4.5; LW 3.8 to 5.2. A short shot: pick a low club or a soft high one. | `chip`, `pitch` | short, L1+ |
| `cr-07` | Pin 18 yd, Stimp 8 (slow), flat, fringe 6 yd. | 7-iron 6.6 to 7.3; 9-iron 8.4 to 9.3; PW 9.9 to 11.0; SW 12.2 to 13.5; LW 13.8 to 15.3. Slow green: less roll, so more carry. | `green-speed-stimp`, `carry-and-roll` | slow, L2+ |
| `cr-08` | Pin 10 yd, Stimp 11, downhill 5 percent, fringe 2 yd. | 7-iron 2.3 to 2.6; 9-iron 3.0 to 3.6; PW 3.8 to 4.6; SW 5.1 to 6.2; LW 6.2 to 7.5. Steep downhill: a narrow window for the low clubs. | `carry-and-roll`, `landing-spot` | downhill, L3+ |
| `cr-09` | Pin 22 yd, Stimp 10, flat, bunker from 6 to 14 yd, green edge 16 yd. | Only SW (15.6 to 16.0) and LW (16.2 to 17.6) carry the bunker and stop near the pin; PW, 9-iron and 7-iron cannot clear it and still stop close. | `flop`, `carry-and-roll` | bunker, L5 |
| `cr-10` | Pin 14 yd, Stimp 13 (very fast), uphill 2 percent, fringe 3 yd. | 7-iron 4.0 to 4.5; 9-iron 5.3 to 6.0; PW 6.5 to 7.3; SW 8.3 to 9.5; LW 9.7 to 11.1. | `green-speed-stimp`, `carry-and-roll` | fast, uphill, L3+ |
| `cr-11` | Pin 7 yd, Stimp 12, flat, green immediately. | 7-iron 1.8 to 2.3; 9-iron 2.4 to 3.1; PW 2.9 to 3.8; SW 3.8 to 5.0; LW 4.5 to 5.8. | `bump-and-run`, `chip` | short, fast, L4+ |
| `cr-12` | Pin 20 yd, Stimp 9, uphill 3 percent, bunker from 8 to 12 yd, green edge 12 yd. | PW 12.6 (a razor-thin 12.6 to 12.6, effectively not a play); SW 13.9 to 15.3; LW 15.6 to 17.1. Carry the sand, then uphill roll is small. | `flop`, `pitch`, `carry-and-roll` | bunker, uphill, L5 |
- **Rules to generate more:** pick a pin distance in [5, 30] yd, Stimp in {8, 9, 10, 11, 12, 13}, slope in [-5, +4], a fringe edge in [0, 16] yd, optionally a bunker; compute windows per club; require at least two clubs with a landing window at least 0.5 yd wide (so the round is never a lottery), and at least one club with none (so the choice matters).

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-close` | Finish within the window | Carry rose, roll gold, distance label | Correct | Nice read. Carry, then roll. | You picked where it lands, and the club did the rest. Low club, more roll; high club, more carry. That is the whole short game trick. | "I picked a landing spot and let it release." |
| `x-near` | Within twice the window | Gold ideal landing marker | Partial | Close. A step off. | Good idea, slightly off the landing spot. A half-yard change in the carry moves the finish by several feet. | "Half a yard on the landing spot matters." |
| `x-short` | Finished well short | Roll marked short; distance label | Incorrect | Not quite. Not enough carry. | The ball lost its roll early. That happens in the fringe, uphill or on a slow green. Land it closer to the pin or pick a lower club. | "The fringe ate the roll." |
| `x-long` | Finished well past | Roll marked long | Incorrect | Not quite. Too much release. | The ball ran out more than you expected. Fast greens and downhill lies love to roll. Land it shorter or take a higher club. | "It ran out. Fast green." |
| `x-bunker` | Ball in or rolling into the bunker | Bunker highlighted; landing marker inside | Incorrect | Not quite. That found the sand. | The bunker sat between you and the green. A low shot cannot carry it. Land past the sand with a higher wedge. | "I had to carry the bunker, so I took the lob wedge." |
| `x-slope` | Slope scenarios resolved | Slope arrow; roll numbers | Correct or Incorrect | The slope changed the roll. | Downhill lengthens the roll, uphill shortens it. Same club, same carry, a different finish. Adjust the landing spot for the slope. | "Downhill, I land it shorter." |
| `x-fast` | Stimp scenarios resolved | Green speed label; roll numbers | Correct or Incorrect | Fast greens run further. | On a quick green the ball rolls more, so you land it earlier. On a slow green you carry it further. | "Fast green: land it earlier." |
| `x-fringe` | Fringe scenarios resolved | Fringe band; reduced roll | Correct or Incorrect | The fringe slows it down. | Landing in longer grass takes speed off the ball. Land on the green when you want full roll, or use it deliberately. | "I landed it on the green, not in the fringe." |
| `x-timeout` | Timer expired | Marker stays where it was | Timeout | Time's up. Try again. | Time ran out and the shot used your last landing spot. That is a fine moment to check the pin against the green. | "Pick the landing spot, then the club." |

## 13. Scoring & mastery signals
- **Round points:** per section 11 (1.0, 0.7, 0.4, 0); hazard 0; hint penalty -0.1 each (floor 0.4 for a 1.0 round).
- **Score (0-100):** `round(100 * mean(roundPoints))`. **accuracy** = rounds with points >= 0.7 / rounds.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Finished well short | `carry-and-roll` | Underestimated lost roll (fringe, uphill, slow green). |
| Finished well past | `green-speed-stimp` | Ignored a fast or downhill green. |
| In the bunker | `flop` | Used a low club when the sand needed to be carried. |
| Landing spot at the pin | `landing-spot` | Aimed at the flag instead of choosing a landing spot. |
| Wrong club family for a short pin | `chip` / `pitch` | Used a club that could not finish close from that distance. |
| Landed in the fringe and ignored the penalty | `carry-and-roll` | Forgot the fringe cuts the roll. |
- **Mastery signals:** finish within window -> `carry-and-roll` +0.15, `landing-spot` +0.15, plus the club-family concept used (`bump-and-run` for 7-iron, `chip` for 9-iron or PW, `pitch` for SW, `flop` for LW) +0.10; slope scenarios correct -> `green-speed-stimp` +0.10; bunker scenarios cleared -> `flop` +0.20; mistakes -0.15 to the mapped concept. Caps +-0.30 per concept; hints halve positives (native).
- **Result mapping:** `outcomes[]` per round (`id` `round-N`, `success`, `label`, `value` = `{ "club": "...", "landingYd": ..., "finishFt": ..., "hazard": null }`); `mistakes[]`; `masterySignals[]`.

## 14. XP & hearts
- `xpEarned` proposal: +10 per round with points >= 0.7, +5 for 0.4, +40 for finishing; native clamps.
- `heartsLost` = 1 if accuracy < 0.34, else 0; max 1.
- `replayAvailable` true (deterministic re-run via seed).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Poor round or hazard | Explain card | outcome false + mistake | none |
| Failed session | "The short game is about feel. Two more and the roll will make sense." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Shot uses the current landing spot; explain | see `x-timeout` | none |
| Abort/backgrounded | Native flow | `aborted true`, `xpEarned 0` | none |
| Asset missing / invalid config | Native error sheet | `error` events (`CONFIG_INVALID`) | none |
Always ends in an explain moment.

## 16. Accessibility
- **Reduced motion:** no camera sweeps; freeze is a hard cut; the ball's flight is a quick cross-fade between launch and landing (no arc animation) with a static trace; no shake.
- **Haptics:** `hapticsEnabled` respected; marker ticks skipped when off.
- **Color-blind:** carry (solid) and roll (dashed) differ by pattern, not only rose versus gold; bunker and fringe are hatched and labelled; result markers use circle versus X.
- **Text scale** honored; card reflows.
- **Tap-only:** `controlScheme: "steppers"` completes everything with taps.
- **VoiceOver:** Unity is limited; the native fallback `short-05-native` gives the same concept credit.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Marker move | Soft tick | light tick |
| Strike | Original soft chip sound (synthesised) | soft tap |
| Landing | Turf thud | none |
| Roll | Soft hiss scaled by speed | none |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
All honor `soundEnabled` / `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural? | Source/license | Budget |
|---|---|---|---|
| Short-game scene (fringe, green, bunker, flag) | Procedural | `original-swoond` | < 3k tris |
| Golfer, club, ball | Procedural | `original-swoond` | < 4k tris |
| Overlays (trace, ghost, labels) | Procedural | n/a | n/a |
| Audio | Original synthesis | `original-swoond` | <= 1 MB |
Bundle `sim-golf-carry-roll`, <= 4 MB.

## 19. Performance budget
Defaults from `docs/astra/README.md` apply. Tighter: analytic carry and roll (no per-frame physics beyond animation); memory < 90 MB; cold launch < 2 s; draw calls <= 90.

## 20. Telemetry
`avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `practiceShotsUsed`, `clubsChosen` (histogram), `landingErrorYdMedian`, `controlScheme`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** With seed 9, difficulty 2, 3 rounds, exactly 3 `outcomes`; repeating gives identical outcomes.
2. **AC-2:** Short-game model fixtures: for each of the 12 scenarios and each club, the listed landing window finishes within 3 ft and one step outside finishes beyond 3 ft (60 fixtures).
3. **AC-3:** Fringe rule: landing at `greenEdge - 0.1` applies the 0.7 factor; at `greenEdge + 0.1` it does not (fixture).
4. **AC-4:** Bunker rule: landing at `b1 + 0.4` fails, at `b1 + 0.6` passes (fixture); a landing before the bunker fails.
5. **AC-5:** Slope factors: 4 percent uphill multiplies roll by 0.76, 3 percent downhill by 1.24 (fixtures).
6. **AC-6:** Generated scenarios satisfy the two generation rules in section 11 (property test over 300 seeds).
7. **AC-7:** `ready` < 2 s; `result` schema-valid; exactly one result.
8. **AC-8:** Steppers scheme completes a run with no drag events.
9. **AC-9:** Pause/resume freezes the animation and timer; abort yields `aborted=true`.
10. **AC-10:** Copy lint: titles <= 6 words, bodies <= 45 words, all outcomes have copy.
11. **AC-11:** Reduced motion path has no camera sweeps or arc animation; color-blind second channel present.
12. **AC-12:** Invalid config yields `CONFIG_INVALID`.
13. **AC-13:** Perf: p5 >= 50 fps, memory < 90 MB on iPhone 13-class.
14. **AC-14:** Mastery signal caps +-0.30 per concept.

## 22. Test plan
- **EditMode:** short-game model fixtures, fringe and bunker rules, slope factors, scenario generation property test, config validation, scoring, determinism, copy lint, result schema.
- **PlayMode:** scene builds from code; scripted drag and stepper runs; freeze/explain; pause/abort; reduced motion; colour-blind snapshot.
- **Perf:** iPhone 13-class 3-round run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_CarryRoll` |
| AC-2 | EditMode | `ShortGameModel_Fixtures` |
| AC-3, AC-4 | EditMode | `Fringe_Rule`, `Bunker_Rule` |
| AC-5 | EditMode | `Slope_Factors` |
| AC-6 | EditMode | `Scenario_Property` |
| AC-7 | PlayMode | `ColdLaunch_Result_Schema` |
| AC-8 | PlayMode | `Steppers_FullRun` |
| AC-9 | PlayMode | `Pause_Abort` |
| AC-10 | EditMode | `Copy_Lint` |
| AC-11 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-12 | EditMode | `Config_Invalid` |
| AC-13 | Perf | `Perf_iPhone13` |
| AC-14 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | `Golf` module `ShortGameModel`; a `Ball.Roll` phase (roll distance, surface factor) added to `Ball`. | Astra | Yes |
| 2 | SME (PGA professional or short-game coach) check of the carry:roll ratios, fringe factor and slope factors; the table is a teaching approximation. | Product | Yes for approval |
| 3 | The `cr-12` PW window is effectively zero width; keep as an intentional "not a play" or retune the numbers? Proposed: retune the pin to 21 yd when the generator runs. | Claude | No |
| 4 | Do we add spin and check (a lob wedge that stops dead) as a second physics variable in v2? Proposed: v2. | Claude/Astra | No |

### Game Kit additions requested
- `Golf` module: `ShortGameModel` (pure function), `golf_hole` short-game preset (shared with the other golf sims).
- `Ball.Roll` phase extension (roll distance and surface factor).
- GK-3 chip selector; GK-19 `broadcast-side` and `top-down` presets (already listed).
