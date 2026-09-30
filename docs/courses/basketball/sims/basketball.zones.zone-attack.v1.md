# Zone Attack: Find the Gap (`basketball.zones.zone-attack.v1`)

> Spec for Astra (Unity). Authored by Swoon'd curriculum design for the Basketball course. Follows `docs/astra/SIM_SPEC_TEMPLATE.md`; section numbers are stable.

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `basketball.zones.zone-attack.v1` |
| simulationVersion | `1.0.0` (major 1 equals `.v1` in the id) |
| Spec status | draft |
| Contract versions | Bridge `1.0.x` (`docs/contracts/unity-bridge/v1/`); sim-definition `1.x` (scenario-data driven; no custom definition file required for v1) |
| Authors / date | Swoon'd curriculum design (Claude Code) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId`: `basketball`; `unitId`: `defense`, `film-room`; `lessonId`s: `def-03`, `flm-05` (`def-03` at difficulty 1-3; `flm-05` at difficulty 4-5).
- CDS: `docs/courses/basketball/CDS.md`, section 12 Interaction plan, row "Zone attack: find the open receiver against 2-3, 3-2 and 1-3-1".
- Manifest entry: `docs/courses/basketball/manifest.json` -> `unitySimulations[]` (`status: spec-draft`).
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first): `zone-defense`, `floor-spacing`, `man-to-man`.

## 3. Learning objective(s) & concepts taught
- **Learner-facing objective:** You can look at a zone defense, name it and pass to the spot it leaves open before it can shift.
| conceptId | term | after this the learner can |
|---|---|---|
| `zone-defense` | Zone defense | Explain that defenders guard areas and shift with the ball. |
| `two-three-zone` | 2-3 zone | Recognize the two-up, three-back shape and where it is thin. |
| `three-two-zone` | 3-2 zone | Recognize the three-up, two-back shape and the open corners. |
| `one-three-one-zone` | 1-3-1 zone | Recognize the point-wing-wing-middle-baseline shape and the baseline weakness. |
| `high-post` | High post | Say when a free-throw-line catch beats a zone and when it does not. |
| `corner-three` | Corner three | Recognize that ball movement finds the corner shooter against zones. |

- **Out of scope:** Matchup zones, box-and-one, zone presses and offensive sets against zone are not in this sim. The zones here are simplified: defenders slide toward the ball with fixed lag.

## 4. Why Unity (tier justification)
- **Rubric answer:** spatial reasoning and movement over time. A zone is defined by the space defenders cover, and its weakness is where that coverage is late; both appear only when the ball moves faster than the defenders slide.
- **What Unity adds:** the learner sees the zone shift and lag after a pass, and can compare the distance of every receiver at the moment of the catch. A static diagram cannot show lag.
- **Closest native type and why it teaches worse:** `hotspot-tap` (tap the open spot on a static zone) can name the gap but not why it opens or how it moves with the pass.
- **Verdict:** Tier A. Native `term-match` (zone names) and `hotspot-tap` prime the vocabulary.

## 5. Player fantasy & core loop
- **Fantasy:** You are the point guard against a zone: one pass, and the defense has to catch up.
- **Core loop** (prompt -> one decisive interaction -> execute -> freeze/explain -> line you could say out loud):
  1. **Prompt:** serif line "Zone up. Find the gap." The zone shape appears.
  2. **Decision:** tap the teammate you want to pass to (up to four targets).
  3. **Execute:** the ball flies for 0.6 s; the zone shifts with lag; the receiver catches or the pass is deflected.
  4. **Freeze:** distances from each defender to the receiver appear in feet.
  5. **Explain and say:** where the zone was thin and why the pass worked or did not.
- **Session length:** About 3 minutes: 3 rounds; each round has about 10 s of decision and 25 s of explain.

## 6. Scene & entities
- **Environment:** `basketball_half_court`
- **Camera presets:** `top-down-half-court` (default); `broadcast-baseline` (replay).
- **Court coordinates (all sims):** feet, origin at the rim center, +y toward half court, +x to the viewer's right when looking from the baseline toward half court. Baseline y = -5.25, half-court line y = 41.75, sidelines x = +/-25, lane x = +/-8 (free-throw line y = 13.75), restricted-area arc radius 4, three-point arc radius 23.75 with corner lines at x = +/-22 up to y = 8.75 (NBA dimensions; college/WNBA arc 22.146 ft can be selected via `configuration.league` where noted).
| id | Game Kit primitive / module | role | key parameters |
|---|---|---|---|
| passer | `Character` + `Ball` | Starts at the ball spot (top or wing) | fixed at the scenario `from` spot |
| receiver_1..receiver_4 | `Character` + `Target` | Teammates at the lineup spots | 44 pt rings; labels by spot |
| zone_1..zone_5 | `Character` (defender) | Zone defenders at anchors, sliding toward the ball | anchor table in section 11; row factor K: top 0.35, mid 0.30, bottom 0.20; lag lambda 0.5 |
| pass_lane | `Path` | Straight line passer-to-receiver used for the deflection test | clear if the nearest defender to the line is >= 2.0 ft |
| open_ring | `Highlight` (distance ring) | Shows defender-to-receiver distance at the catch | open if >= 6.0 ft |
| zone_overlay | `Zone` x5 | Shaded regions the defenders own (levels 1-3) | translucent fills; labels D1..D5 |
| decision | `DecisionPoint` | Single tap on a receiver | no limit at L1-3 |
| camera | `CameraRig` | Presets | reduced motion: cuts |

- **Reused vs new:** Reused: `Character`, `Ball`, `Target`, `Zone`, `Path`, `CameraRig`, `TouchController`, `DecisionPoint`, `Hint`, `Explanation`, `Score`, `Replay`, `SlowMotion`, `Highlight`, and the Basketball module from the spacing sim. New: a `ZoneShell` data structure in the Basketball module (anchor table + row factors + lag), reusable for zone presses and box-and-one.
- **Layout diagram:**
```
   2-3 zone example (ball at top, passer)
        (D1 -7,17)        (D2 7,17)          <- top row, k = 0.35
   (D3 -11,6)      (D4 0,4)      (D5 11,6)   <- bottom row, k = 0.20
   receivers: wing-l, wing-r, corner-l, corner-r   (or short corners / high post)
   distances are measured at the catch: defenders = anchor + k(ball - anchor), then halfway to the new ball spot
```

### 6.1 Game Kit additions requested
- **`ZoneShell` data:** anchors, row factors (top 0.35, mid 0.30, bottom 0.20), lag lambda 0.5, and the pass-lane deflection distance (2.0 ft); deterministic shifting for any zone family (add rows for future 1-2-2, box-and-one).
- **`Highlight` distance ring** and `PlayerRole` from the spacing sim (reused).
- **Registry keys:** objective type `find_gap`; demonstrate type `zone_shift_overlay`.

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Pass to a teammate | Tap a receiver ring | receiver_1..4 | >= 44 pt (rendered 52 pt) | Ring turns rose; pass starts |
| Show zone (L1-3) | Tap the eye icon | zone_overlay | 44 pt | Toggles overlay |
| Hint | Tap the lightbulb | hint | 44 pt | Gold ring on the best receiver (L1) or on the thinnest area (L2-3) |
| Exit | Tap X | requestExit | 44 pt | `requestExit user-quit` |

- **Accessible alternative (tap-only):** The default scheme is tap-only.
- **Orientation / safe area:** portrait; interactive targets stay above the bottom safe-area inset and clear of the top `runtime.safeAreaInsets.top` plus 12 pt; landscape is not supported in v1.
- **Not drawn by Unity:** paywall, hearts sheet, exit confirmation ("Leave game?"), permission prompts, lesson chrome. Unity may draw an X that emits `requestExit`.

## 8. Step-by-step flow with states
| State | Entry condition | What happens | Exit / next | Bridge events |
|---|---|---|---|---|
| Loading | `launch` received | Validate `contractVersion`, `simulationId`, `configuration`; load scenario JSON and build the world from code; apply theme and accessibility flags. | Scene built -> Intro; failure -> `error` (CONFIG_INVALID / ASSET_LOAD_FAILED) | `ready` (with `gameKitVersion`, `loadTimeMs`) |
| Intro | World built | Prompt card (one line, serif) and a 1.2 s establishing shot. Show the zone name (L1-3) and the passer holding the ball. | Tap "Go" or auto after 3 s -> Playing | `progress` 0.0 |
| Playing | Intro finished | Round `i` of `n` begins. Zone defenders slide to their anchors for the passer's spot (0.8 s). | Decision window opens -> Decision | `progress` (throttled <= 4/s) |
| Decision | Decision window open | DecisionPoint slows or holds the sim. Receivers become tappable; optional limit; the scene is paused (not slowed) because the zone is static until the pass. | Choice locked or limit hit (counts as no answer = incorrect) -> Executing | none |
| Executing | Choice locked | Sim plays out deterministically for 2-5 s. The pass is thrown; the zone shifts with lag; catch or deflection. | Outcome determined -> Freeze | none |
| Freeze | Outcome determined | Time scale eases to 0 over 250 ms (hard cut under reduced motion); scene dims 35% except focal entities. Freeze at the catch with distances. | Focal highlight done -> Explain | `checkpoint` (round id) |
| Explain | Freeze complete | Callouts appear one at a time (250 ms each), then the copy card and the say-this line. Callouts: the shift arrows, the distances, then the copy. | Tap Continue -> Playing (next round) or Summary | none |
| Summary | Last round explained | Score numerals count up over 600 ms; three outcome pips; the one line to say out loud. | Auto after 4 s or tap -> Done | `progress` 1.0 |
| Done | Summary finished | Build `SimulationResult`; emit result then request exit. | Unity idle | `result`, then `requestExit` (`completed`) |
| Paused | Native `pause` | Stop sim time, timers, audio and haptics; keep the frame. | `resume` -> previous state | none |
| Aborted | Native `abort` or X confirmed | Stop immediately; build a partial result. | Emit result -> exit | `result` (`aborted=true`), `requestExit` |

Pause/abort: native `pause` freezes sim time, timers and audio in any state and resumes exactly; `abort` moves to Aborted from any state and emits one result with `aborted=true`.

## 9. Difficulty levels 1-5
| Parameter | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Zone families in pool | 2-3 | 2-3, 3-2 | all three | all three | all three |
| Zone overlay and label | shown | shown | toggle | off (name hidden) | off (name hidden) |
| Hint | gold ring on best | ring on thinnest area | 1 free hint | hints cost 1 | none |
| Lineups | five-out | five-out, four-one | + overload | + short corners | all |
| Decision limit (real seconds) | none | none | 10 | 6 | 3 |
| Scenario pool tags | L1 | L1-2 | L2-3 | L3-4 | L5 |

- **Default difficulty for the lesson:** 2 for `def-03`; 4 for `flm-05`. Level 1 is passable by a true beginner with hints (hint text and highlights always on).

## 10. Configuration schema
`LaunchRequest.configuration` (draft 2020-12). Invalid configuration yields `error CONFIG_INVALID`.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "basketball.zones.zone-attack.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": {
      "type": "integer",
      "minimum": 0
    },
    "scenarioSetId": {
      "type": "string",
      "enum": [
        "zone-starter",
        "zone-advanced"
      ],
      "default": "zone-starter"
    },
    "scenarioCount": {
      "type": "integer",
      "minimum": 1,
      "maximum": 10,
      "default": 3
    },
    "zoneFamilies": {
      "type": "array",
      "uniqueItems": true,
      "minItems": 1,
      "items": {
        "type": "string",
        "enum": [
          "2-3",
          "3-2",
          "1-3-1"
        ]
      },
      "default": [
        "2-3",
        "3-2"
      ]
    },
    "showZoneOverlay": {
      "type": "boolean",
      "default": true
    },
    "showZoneName": {
      "type": "boolean",
      "default": true
    },
    "decisionTimeLimitSec": {
      "type": "integer",
      "minimum": 0,
      "maximum": 15,
      "default": 0
    },
    "assetRoot": {
      "type": "string"
    }
  }
}
```

Valid example:

```json
{
  "seed": 21,
  "scenarioSetId": "zone-starter",
  "scenarioCount": 3,
  "zoneFamilies": [
    "2-3",
    "3-2"
  ],
  "showZoneOverlay": true,
  "showZoneName": true,
  "decisionTimeLimitSec": 0
}
```

## 11. Scenario data set
A scenario is a zone family, an offensive lineup and the passer. Answers come from the **reference shift model** below, authored into the data as explicit verdicts. `zone-starter` = za-01..za-06; `zone-advanced` = za-05..za-10.

**Scenario count:** at least **10** authored scenarios (3 rounds x 3 minimum for replay variety), stored as `Scenarios/zone.json` (JSON, versioned with the sim). Selection is deterministic per `configuration.seed`.

**Reference shift model:**

1. Defender anchors (ft; rim origin): **2-3**: D1 (-7,17) t; D2 (7,17) t; D3 (-11,6) b; D4 (0,4) b; D5 (11,6) b. **3-2**: D1 (-14,17) t; D2 (0,20) t; D3 (14,17) t; D4 (-7,5) b; D5 (7,5) b. **1-3-1**: D1 (0,22) t; D2 (-13,13) m; D3 (0,12) m; D4 (13,13) m; D5 (0,3) b. Row: t = top (k 0.35), m = middle (0.30), b = bottom (0.20).
2. With the ball at `B`, defender `i` stands at `anchor_i + k_i (B - anchor_i)`.
3. When the pass goes from `B0` to `B1`, at the catch the defender is at `P0 + 0.5 (P1 - P0)` where `P0`, `P1` are the positions for `B0`, `B1` (zone has moved halfway).
4. **open** = nearest defender to the receiver is >= 6.0 ft. **lane clear** = nearest defender to the pass line is >= 2.0 ft (else the pass is deflected).
5. Verdict: **best** = valid receivers (open and lane clear) with the largest open distance; **acceptable** = other valid receivers; **poor** = invalid (covered or deflected). Score best 100, acceptable 60, poor 0.

Spots (ft): top (0,26), wing-l (-17,19), wing-r (17,19), corner-l (-22,1.5), corner-r (22,1.5), hp = high post (0,14), sc-l (-10,2), sc-r (10,2). Lineups: fiveOut = top, wing-l, wing-r, corner-l, corner-r; fourOneHi = top, wing-l, wing-r, corner-r, hp; overloadL = wing-l, top, corner-l, sc-l, wing-r; shortCorners = top, wing-l, wing-r, sc-l, sc-r.

| scenarioId | zone | lineup | passer | receivers | best (open distance) | acceptable | poor (open ft, lane ft) | difficulty | teaches |
|---|---|---|---|---|---|---|---|---|---|
| za-01 | 2-3 | fiveOut | `top` | wing-l, wing-r, corner-l, corner-r | wing-l or wing-r (9.5 ft) | none | corner-l (open 12.6, lane 0.5); corner-r (open 12.6, lane 0.5) | L1 | Swing to the wing before the zone shifts |
| za-02 | 2-3 | fiveOut | `wing-l` | top, wing-r, corner-l, corner-r | corner-l (10.7 ft) | top | wing-r (open 12.5, lane 1.3); corner-r (open 13.8, lane 0.3) | L1 | Reverse or hit the corner |
| za-03 | 2-3 | fourOneHi | `top` | wing-l, wing-r, corner-r, hp | wing-l or wing-r (9.5 ft) | hp | corner-r (open 12.6, lane 0.5) | L2 | High post is playable but not the best |
| za-04 | 3-2 | fiveOut | `top` | wing-l, wing-r, corner-l, corner-r | corner-l or corner-r (15.1 ft) | none | wing-l (open 4.9, lane 1.9); wing-r (open 4.9, lane 1.9) | L2 | The 3-2 leaves the corners |
| za-05 | 3-2 | overloadL | `wing-l` | top, corner-l, sc-l, wing-r | corner-l (13.3 ft) | none | top (open 5.9, lane 1.9); sc-l (open 4.4, lane 1.3); wing-r (open 8, lane 0.6) | L3 | Overload: the corner beats the short corner |
| za-06 | 1-3-1 | fiveOut | `wing-l` | top, wing-r, corner-l, corner-r | corner-l (12.8 ft) | none | top (open 4.8, lane 2.4); wing-r (open 8.9, lane 1.9); corner-r (open 16.2, lane 0.4) | L3 | 1-3-1: the baseline corner is guarded by one man |
| za-07 | 1-3-1 | fiveOut | `top` | wing-l, wing-r, corner-l, corner-r | wing-l or wing-r (6.2 ft) | none | corner-l (open 15.2, lane 0.7); corner-r (open 15.2, lane 0.7) | L4 | Top of the 1-3-1: the wings, not the corners |
| za-08 | 1-3-1 | shortCorners | `wing-l` | top, wing-r, sc-l, sc-r | sc-r (10.4 ft) | none | top (open 4.8, lane 2.4); wing-r (open 8.9, lane 1.9); sc-l (open 7.7, lane 1) | L4 | Short corner on the far side |
| za-09 | 2-3 | overloadL | `wing-l` | top, corner-l, sc-l, wing-r | corner-l (10.7 ft) | top | sc-l (open 5.1, lane 0.5); wing-r (open 12.5, lane 1.3) | L5 | Corner vs a decoy short corner |
| za-10 | 3-2 | fourOneHi | `top` | wing-l, wing-r, corner-r, hp | corner-r (15.1 ft) | none | wing-l (open 4.9, lane 1.9); wing-r (open 4.9, lane 1.9); hp (open 6, lane 0) | L5 | Skip to the corner; the high post is deflected |

**Fully written first three**

1. **`za-01`** - prompt "Zone up. Find the gap." 2-3 zone, five-out lineup, passer at the top. Best: wing-l or wing-r (open 9.5 ft, lane 3.7 ft). Poor: corner-l and corner-r (the pass is deflected: lane 0.5 ft from a zone guard). Hint (L1): "Swing it before they shift."
2. **`za-02`** - 2-3 zone, five-out, passer at wing-l. Best: corner-l (open 10.7 ft, lane 6.6 ft). Acceptable: top (open 7.2 ft). Poor: wing-r (lane 1.3 ft) and corner-r (lane 0.3 ft). Teaching beat: the closest corner is open, but the skip pass across is picked off.
3. **`za-03`** - 2-3 zone, four-out-one-in lineup (high post), passer at the top. Best: wing-l or wing-r (9.5 ft). Acceptable: hp (open 6.1 ft, lane 4.6 ft: playable but tight). Poor: corner-r (lane 0.5 ft). Teaching beat: the high post is a valid catch, but the wings are more open; the high post is usually where you attack from after the catch.

**Scenarios 04-10** follow the table. Generation rules for more: (a) lineups from the four above; (b) the scenario must have at least one valid receiver and exactly one best distance (ties allowed only between mirrored spots); (c) mirror every second scenario; (d) deterministic per seed by seeded shuffle of the pool by difficulty tag.

## 12. Freeze / explain moments
Copy rules: title <= 6 words, body <= 45 words, optional say-this line in quotes. Voice: cheeky coach, warm, a little flirty, never condescending, never about the crush.

### 12.1 2-3 zone
- **Trigger:** The pass is caught (or deflected).
- **What freezes:** The frame of the catch with all five zone defenders and their distances to the receiver.
- **Camera:** `top-down-half-court`, then `broadcast-baseline` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Zone anchors as dots and the shifted positions as arrows; gold ring on the best receiver with distance in feet; rose ring on the learner's receiver; the pass lane in gold or dashed rose if deflected.
- **Correct outcome copy** - Title: "Beat the 2-3 with speed." | Body: "A 2-3 zone is thin on the wings and corners when the ball moves quickly. Swing the ball before the defenders slide, and the open man is on the perimeter. The zone can only shift so fast." | Say this: "Swing it! The 2-3 is always a step behind."
- **Incorrect outcome copy** - Title: "The zone caught up." | Body: "A cross-court pass gave the defenders time to close or to steal it. Passes that stay close to the ball hit the gap before the zone shifts. Do not skip across the zone." | Say this: "Why do they keep skipping it into the zone?"

### 12.2 3-2 zone
- **Trigger:** The pass is caught (or deflected).
- **What freezes:** The frame of the catch with all five zone defenders and their distances to the receiver.
- **Camera:** `top-down-half-court`, then `broadcast-baseline` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Zone anchors as dots and the shifted positions as arrows; gold ring on the best receiver with distance in feet; rose ring on the learner's receiver; the pass lane in gold or dashed rose if deflected.
- **Correct outcome copy** - Title: "The 3-2 leaves the corners." | Body: "A 3-2 zone stacks three defenders on top and two low. The corners sit between them, so a pass to the corner catches the zone late. The corner three is the classic 3-2 answer." | Say this: "Against a 3-2, the corner is where the shot is."
- **Incorrect outcome copy** - Title: "Covered on top." | Body: "The top three defenders were in the passing lane or on the receiver. Against a 3-2, look past them to the corner. The gap is low and outside, not in the middle." | Say this: "Where is the 3-2 weakest? The corners?"

### 12.3 1-3-1 zone (best receiver is a corner or short corner)
- **Trigger:** The pass is caught (or deflected).
- **What freezes:** The frame of the catch with all five zone defenders and their distances to the receiver.
- **Camera:** `top-down-half-court`, then `broadcast-baseline` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Zone anchors as dots and the shifted positions as arrows; gold ring on the best receiver with distance in feet; rose ring on the learner's receiver; the pass lane in gold or dashed rose if deflected.
- **Correct outcome copy** - Title: "1-3-1: the baseline." | Body: "The 1-3-1 has one defender guarding the whole baseline. The corner on the ball side is the classic open spot. Ball movement to the wing and then the corner finds it." | Say this: "The corner is wide open. It is a 1-3-1."
- **Incorrect outcome copy** - Title: "The zone had the middle." | Body: "The 1-3-1 packs the middle and the top. Passing there hit three defenders. Look to the wing and then the corner, where one defender is stretched thin." | Say this: "Why is the 1-3-1 so hard to pass into?"

### 12.4 1-3-1 zone (best receiver is a wing)
- **Trigger:** The pass is caught (or deflected).
- **What freezes:** The frame of the catch with all five zone defenders and their distances to the receiver.
- **Camera:** `top-down-half-court`, then `broadcast-baseline` replay at 0.5x (cuts under reduced motion).
- **Callouts:** Zone anchors as dots and the shifted positions as arrows; gold ring on the best receiver with distance in feet; rose ring on the learner's receiver; the pass lane in gold or dashed rose if deflected.
- **Correct outcome copy** - Title: "Wings first against the 1-3-1." | Body: "From the top, the wings are the open spots because the 1-3-1 point is a step late. Hit the wing, then look for the corner or the short corner on the next pass. Two quick passes beat it." | Say this: "Wing first, then the corner. That is how you beat a 1-3-1."
- **Incorrect outcome copy** - Title: "Into the middle again." | Body: "The high post or the far corner is where the 1-3-1 is strongest. From the top, the open pass is to the wing before the point defender gets there. Start on the outside." | Say this: "Why not just hit the wing against a 1-3-1?"

### 12.5 Summary line
- **Trigger:** All rounds explained.
- **What freezes:** Not frozen: Summary screen.
- **Camera:** Top-down still of the last catch.
- **Callouts:** Three rounds with zone name and gap spot.
- **Correct outcome copy** - Title: "You found the gap." | Body: "Zones are beaten by moving the ball faster than the defenders slide. You named the zone, found the thin spot and passed to it. That is the whole idea." | Say this: "He found the seam before the zone could shift."
- **Incorrect outcome copy** - Title: "Move it faster." | Body: "Look at where the zone is thin: wings and corners for a 2-3, corners for a 3-2, the baseline for a 1-3-1. Pass to that spot early and the zone cannot get there." | Say this: "What is the weakest spot in this zone?"

## 13. Scoring & mastery signals
- **Score formula (0-100):** Round score: best 100, acceptable 60, poor 0 (no answer = 0). Session score = round(mean).
- **Accuracy:** Rounds with a best receiver divided by rounds played.
- **Outcome ids:** `round-1`..`round-N` (`label` e.g. "2-3: swing to the wing"), `value` = receiver spot id or `deflected`.

**Mistake -> conceptId mapping**

| mistake | conceptId | description text (<= 240 chars) |
|---|---|---|
| Skipped across the zone and was deflected | `zone-defense` | Threw a long pass through the zone that was deflected. |
| Passed into the middle of a 1-3-1 | `one-three-one-zone` | Passed into the packed middle instead of the corner. |
| Passed to a covered wing against a 3-2 | `three-two-zone` | Passed to a wing guarded by a top defender instead of the corner. |
| Passed to a covered corner against a 2-3 | `two-three-zone` | Threw to a corner the bottom defenders cover. |
| Chose the high post when a wing was more open | `high-post` | Chose the high post although a wider gap was available. |

**Mastery signals** (per-session caps: +0.4 / -0.3 per concept per session; total absolute delta <= 1.2.)

| event | conceptId | delta (-1..1) | evidence text |
|---|---|---|---|
| Best in 2-3 | `two-three-zone` | 0.25 | Found the wing or corner gap. |
| Best in 3-2 | `three-two-zone` | 0.25 | Found the corner gap. |
| Best in 1-3-1 | `one-three-one-zone` | 0.25 | Found the baseline gap. |
| Best (any) | `zone-defense` | 0.15 | Passed to the thin spot. |
| Best at a corner | `corner-three` | 0.15 | Found the corner shooter. |
| Acceptable at the high post | `high-post` | 0.1 | Used the high post as a valid catch. |
| Poor (any) | `zone-defense` | -0.1 | Passed into the zone's strength. |

**Mapping to `SimulationResult`:** Rounds -> `outcomes[]`; mistakes -> `mistakes[]` with `at`; signals -> `masterySignals[]`.

## 14. XP & hearts
- **`xpEarned` proposal:** +10 per successful round, +40 for finishing all rounds (native clamps to the lesson XP budget); hint use does not reduce XP but native halves mastery gain when `telemetry.hintsUsed > 0`. Bonus: none.
- **`heartsLost`:** 1 if fewer than half the rounds succeed at difficulty >= 2; otherwise 0; never more than 1 per session; 0 at difficulty 1. Aborted, timeout or error sessions lose no hearts.
- **`replayAvailable`:** `true` after Summary when at least one round was recorded (Replay primitive); native may show a "Watch again" affordance that relaunches with the same seed at no XP.

## 15. Failure states
| Situation | Learner sees | Result fields | Hearts |
|---|---|---|---|
| Failed round | Explain moment for the incorrect outcome with the correct answer highlighted gold; then next round | `outcomes[i].success=false`, `mistakes[]` entry, negative `masterySignals` | Counts toward the session rule above |
| Failed session (fewer than half rounds correct) | Summary with the line "We'll run it back." and one "Try again" (native) plus lesson primer offer | `completed=true`, low `score`, `xpEarned` = successes x 10 only | Max 1 |
| Timeout (`runtime.maxDurationMs`) | Native aborts; Unity shows a short freeze card | `aborted=true`, `abortReason=timeout`, partial `outcomes`, `xpEarned=0` | 0 |
| Abort / user quit | Native "Leave game?" then close | `aborted=true`, `abortReason=user-quit` or `native-abort`, partial `outcomes` | 0 |
| Backgrounded > 120 s | Native aborts on return | `abortReason=backgrounded-too-long` | 0 |
| Asset missing | Native retry sheet | `error ASSET_LOAD_FAILED`, `recoverable=true` | 0 |
| Invalid configuration | Native friendly error and skip | `error CONFIG_INVALID`, `recoverable=false` | 0 |
| Decision limit expires (L3-5) | The passer holds; the shot clock expires and the round ends | `outcomes[i].success=false` | Counts toward the session rule |

Failure always teaches: every failed round ends in an explain moment; there is no dead-end screen.

## 16. Accessibility
- **Reduced motion:** Freeze is a hard cut (no ease); camera moves become cuts; no shake; pulsing rings become static rings; slow-motion replay is replaced by paired stills (before/after) with the same callouts.
- **Haptics off:** all cues fall back to on-screen text/shape only.
- **Color-blind modes** (`protanopia`, `deuteranopia`, `tritanopia`): team colors differ in luminance and every color meaning has a second channel: zone defenders are hollow rings with labels D1..D5; receivers are filled; overlays use dashed vs solid lines; the best receiver is a gold double ring and deflected passes use a dashed rose line.
- **Text scale:** overlay text follows `textScale` up to 2.0; callout cards reflow and scroll if needed; explanation copy is never truncated.
- **Tap-only:** The default scheme is tap-only.
- **VoiceOver / TalkBack:** Unity content has limited screen-reader support. Accessible native fallback lesson (a designed exercise, not a port): `zone-native`: a `hotspot-tap` per zone family (tap the open spot on a labelled diagram) plus a `term-match` of zone names.

## 17. Audio & haptics
| Event | Sound | Haptic | Volume |
|---|---|---|---|
| Scene ready | soft ball-bounce tick | none | -18 dB |
| Decision window opens | low chime | soft tap | -16 dB |
| Correct outcome | warm two-note rise | light success | -14 dB |
| Incorrect outcome | muted thud | warning | -14 dB |
| Freeze | soft whoosh, pitch drop | soft tap | -16 dB |
| Pass thrown | crisp pass whoosh | none | -16 dB |
| Deflection | sharp slap | warning | -14 dB |
| Summary numerals | quiet tick per count step | none | -22 dB |

All cues honor `learnerContext.accessibility.soundEnabled` and `hapticsEnabled`. No music. No commentary voice.

## 18. Art & asset list
| asset | procedural or external | source & license | tris / texture / size | notes |
|---|---|---|---|---|
| Half-court (floor, lines, lane paint, arc, hoop, backboard) | procedural | generated in code; original | < 3k tris; solid colors; 0 textures | `court` token from theme; lines as thin quads |
| Players (offense / defense) | procedural | capsule-bodied stylized figures generated in code; original | < 1.2k tris each; solid colors; no textures | Jersey number and role ring as second channel; defenders desaturated |
| Ball | procedural | original | < 600 tris | Orange in both themes (pieces keep own colors) |
| Zone anchor dots and shift arrows | procedural | original | quads | Distinct dot shapes per row |
| Overlays (rings, zones, arrows, callout cards) | procedural | original | quads / TMP | Rose = you/act, gold = correct/taught (ART_DIRECTION.md section 4) |
| Fonts | external (bundled) | Instrument Serif and Geist, OFL | TMP font assets | From `theme.fonts`; do not hard-code |

- **Addressables bundle:** `basketball.zones.zone-attack.v1` v1.0.0, expected size < 6 MB compressed (scenario JSON, TMP fonts, audio cues).

## 19. Performance budget
Defaults from `docs/astra/README.md` apply: 60 fps sustained on iPhone 13-class (5th-percentile frame >= 50 fps), peak resident memory < 150 MB, cold launch to `ready` < 2 s (< 4 s first framework load), bundle <= 25 MB, textures <= 8 MB VRAM, <= 60k triangles on screen, <= 15 materials, audio <= 3 MB, <= 150 draw calls, thermal state not above "fair" after 3 minutes. Tighter limits for this sim: 11 characters and one ball on screen; defenders move with simple lerp (no pathfinding).

## 20. Telemetry
`telemetry` carries diagnostics only: `avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus sim counters: `hintsUsed`, `decisionLatencyMs` (per round), `overlayToggles`, `deflectedPasses`. No names, no relationship, no free text, no device identifiers.

## 21. Acceptance criteria (testable)
- **AC-1:** Shift model: for each scenario in `zone.json` the model output (open distance and lane distance within +/- 0.3 ft) matches the stored verdicts.
- **AC-2:** With seed 21, difficulty 2, `scenarioCount` 3, the sim emits exactly 3 `outcomes`.
- **AC-3:** At the catch, defender positions equal the model within 0.5 ft (checked on za-01 and za-06).
- **AC-4:** A pass whose lane distance is < 2.0 ft is deflected and recorded as `deflected`.
- **AC-5:** Zone overlay/name visibility follows difficulty: hidden at levels 4-5 until Freeze.
- **Launch and ready:** With this sim's example configuration, Unity emits `ready` within 2000 ms of receiving `launch`, and exactly one `result` that validates against `simulation-result.schema.json`, followed by `requestExit`.
- **Pause/resume:** After `pause`, no sim time, timers or objective progress advance for 5 s; after `resume` the state continues exactly. `durationMs` excludes paused time.
- **Abort:** `abort` at any state yields a result with `aborted=true`, `completed=false`, the matching `abortReason` and partial `outcomes` within 1000 ms; `xpEarned=0`, `heartsLost=0`.
- **Determinism:** With the same `seed`, `scenarioSetId` and scripted inputs, two runs produce identical `outcomes`, `mistakes` and `masterySignals`.
- **Config validation:** A configuration violating the section 10 schema (unknown key, out-of-range value) produces `error CONFIG_INVALID`; `{}` is valid and uses defaults.
- **Result maths:** `score` is an integer 0-100, `accuracy` in [0,1], every `conceptId` in `mistakes[]` and `masterySignals[]` is listed in section 3, and per-session caps in section 13 are never exceeded.
- **Reduced motion:** With `reducedMotion=true`: Freeze is a hard cut (0 ms ease), no camera sweeps or shake occur, and pulsing rings are static.
- **Tap-only completion:** A full session completes using only single taps (no drags or holds) with the tap-only scheme.
- **Color-blind channel:** For each `colorBlindMode`, every color-coded element also carries the second channel from section 16 (shape, pattern or number), verified by a scene audit.
- **Copy length:** All explain titles are <= 6 words and bodies <= 45 words (asserted from the scenario/copy data).
- **Performance:** On iPhone 13-class: >= 60 fps sustained, 5th-percentile frame >= 50 fps, peak memory < 150 MB, cold launch to `ready` < 2 s, <= 150 draw calls, <= 60k tris on screen.
- **Privacy:** No log line, telemetry field or file contains `personName` or `relationship`.

## 22. Test plan
- **EditMode:** Shift model vs stored verdicts for all scenarios; lane deflection logic; mirroring; scoring maths; determinism by seed; config validation; copy length.
- **PlayMode:** Scene builds; scripted run with best and poor passes; catch-position audit; overlay visibility by difficulty; reduced-motion stills; tap-only run; pause/resume; abort.
- **Perf:** a measured 3-round run on an iPhone 13-class device with a recorded fps/memory/thermal report attached to the PR.

| AC id | test type | test name |
|---|---|---|
| AC-1 | EditMode | ShiftModel_MatchesData |
| AC-2 | PlayMode | Run_ThreeRounds_Seed21 |
| AC-3 | PlayMode | Catch_PositionsMatchModel |
| AC-4 | PlayMode | PassLane_Deflection |
| AC-5 | PlayMode | Overlay_ByDifficulty |
| Launch and ready | PlayMode | BridgeConformance_ReadyResultExit |
| Pause/resume | PlayMode | PauseResume_NoTimeAdvance |
| Abort | PlayMode | Abort_PartialResult |
| Determinism | EditMode | Determinism_SameSeedSameResult |
| Config validation | EditMode | Config_ValidationAndDefaults |
| Result maths | EditMode | Result_SchemaAndCaps |
| Reduced motion | PlayMode | ReducedMotion_NoEaseNoShake |
| Tap-only completion | PlayMode | TapOnly_FullRun |
| Color-blind channel | EditMode | ColorBlind_SecondChannelAudit |
| Copy length | EditMode | Copy_LengthLimits |
| Performance | Perf | Perf_iPhone13Report |
| Privacy | EditMode | Privacy_NoPersonalData |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Basketball SME to review the anchor tables and the 0.5 lag for realism against real 2-3, 3-2 and 1-3-1 behavior | Product | Yes, before spec approval |
| 2 | Add a matchup-zone or box-and-one family in v2? | Product | No |
| 3 | Should the sim show the shot result (make/miss) after the catch or stop at the open look? | Product | No |
| 4 | Confirm the final tuning constants (speeds, timing windows) with Basketball SME review before Astra locks them. | Product | No |
| 5 | Should the sim honor `theme.colorScheme=light` with the same overlay tokens (planned: yes, per ART_DIRECTION)? | Astra | No |
| 6 | Is a native accessible fallback lesson approved for VoiceOver users (named in section 16)? | Claude | No |
