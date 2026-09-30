# Serve: Place It and Spin It (`tennis.serve.place-and-spin.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `tennis.serve.place-and-spin.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (not data-driven in v1; hand-built from kit primitives) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `tennis`; `unitId` `serve-and-return`; `lessonId` `serve-05`.
- CDS row: section 12, "`serve-05`: Place it and spin it".
- Manifest: `docs/courses/tennis/manifest.json` -> `unitySimulations[0]`.
- Prerequisite concepts (else a native primer first): `service-box`, `serve-rules`, `serve-diagonal-tennis`, `fault-double-fault`, `service-let`.

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can pick where to aim a serve (wide, body or T) and which spin to use, and you can say why a second serve trades speed for safety."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `serve-targets` | Wide, body, T | Choose a target away from where the returner is leaning. |
| `serve-spins` | Flat, slice, kick | Name the spin from the flight and bounce, and know what each does. |
| `first-second-serve` | First vs second serve | Explain why a second serve is slower, safer and often spun. |
| `service-box` | Service box | Land the ball inside the correct diagonal box (lines are in). |
| `service-let` | Service let | Recognise a net-cord serve that lands in as a let: replay. |
| `serve-diagonal-tennis` | Diagonal serve | Send the serve to the box diagonally opposite. |
| `serve-sides` | Deuce / ad court | Pick the side from the score (levels 3+). |
- **Out of scope:** foot faults and toss legality (native `serve-01`), scoring, rally play after the return, real-world speeds.

## 4. Why Unity (tier justification)
- **Signals:** *physics* (arc over the net, drag, spin-driven curve and bounce), *spatial reasoning* (wide/body/T inside a 4.1 m box against a returner who stands somewhere), and *camera perspective* (behind-the-server view for aiming, side-on replay for the net and the kick bounce).
- **Closest native:** `hotspot-tap` teaches which box (used in `serve-04`), and `decision-scenario` can say "aim T on the ad court to a wide-leaning returner". Neither shows why a flat first serve has less margin over the net than a kick second serve, why a slice pulls wide, or what a kick bounce feels like to a returner. The learner's own aim and a felt outcome are the lesson.
- **Fallback:** native lesson `serve-05-native`: three `hotspot-tap` items (returner leaning; where to aim) and two `decision-scenario` items (first vs second serve).
- Justification: moderate to strong. If playtests show no gain over the fallback, downgrade.

## 5. Player fantasy & core loop
- **Fantasy:** "You are about to serve on a big point, and you have a plan."
- **Loop:**
  1. Prompt: situation card (side, score, first or second serve, where the returner stands).
  2. Decision: choose target (wide / body / T) and spin (flat / slice / kick).
  3. Aim: slingshot drag sets fine placement inside the chosen target (or tap-target).
  4. Execute: the ball flies; the sim resolves net (cord or not), bounce, box, and returner outcome.
  5. Freeze at first bounce; explain with top-down landing marker and returner reach; say-this line.
- **Session:** about 3 minutes, 3 rounds (configurable 3-6).

## 6. Scene & entities
- **Environment:** `tennis_court` (new; see requested additions). **Cameras:** `chase-high` behind the server (aim view, default), `top-down` (freeze/explain), `broadcast-side` (optional slow-mo replay of the arc and kick).
- **Units/coords:** metres; origin at net centre; x across (positive = server's right when facing the net), z along the court; server at z<0 facing +z. Singles court 23.77 x 8.23 m, service line 6.40 m from the net, box width 4.115 m. Net 0.914 m at centre, 1.07 m at the posts.

| id | Primitive / module | Role | Key parameters |
|---|---|---|---|
| `court` | `Court` (Swoond.Sports.Tennis) | Surface, lines, net, service boxes, centre service line | hard-court tint default; `surface` param |
| `server` | `Character` | Serving player (rose ring) | 1.85 m; `AnimState` serve-toss, serve-hit |
| `returner` | `Character` | Opponent with a stance | stance x offset, reach model (section 13) |
| `ball` | `Ball` | Served ball (+ `Swing` curved flight, GK-7) | fixed dt 1/120, gravity 9.81, drag k 0.0026, Magnus by spin, restitution 0.75 |
| `targetBox` | `Zone` | Correct diagonal service box | gold outline on reveal; shaded at L1-2 |
| `targetZones` | `Zone` x3 | Wide, body (relative to returner), T | pattern-coded (stripes, dots, dashes) |
| `spinChips` | `Target` x3 | Flat, slice, kick | `conceptId` `serve-spins` |
| `decision` | `DecisionPoint` | Target + spin choice | optional time limit |
| `aimGizmo` | `Path` + `Highlight` | Dotted preview arc (L1-2) and reticle | rose |
| `landingMarker` | `Highlight` | Landing spot | gold circle (in) / X (out) |
| `reachRing` | `DistanceRing` (GK-13) | Returner's reach on freeze | ring + label in metres |
| `explain`, `score`, `replay`, `hints`, `slowmo` | `Explanation`, `Score`, `Replay`, `Hint`, `SlowMotion` | per kit | |
- **New primitives:** none beyond requests: tennis `Court` module + `tennis_court` env; `TennisServe` helper (launch from aim+spin, landing classifier `in|net|long|wide|wrong-box|let`); `Ball.Throw` `Swing` (GK-7, spin-driven curvature).
- **Layout:**
```
 far side |   x<0 box (target)    |  x>0 box |    <- service line at z = 6.40
 ------------------ net ----------------------
 near side|                 server on right side (x>0), behind baseline z = -11.885
 targets inside the box:  wide (x ~ -3.8)   body (at returner)   T (x ~ -0.4)
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Choose side (L3+) | Tap | Deuce / ad `Target` rings | >= 64 pt | Ring solid; light tick |
| Choose target | Tap a target zone | Wide / body / T zones on the far court | >= 64 pt | Zone glows rose; light tick |
| Choose spin | Tap a chip | Flat / slice / kick chips (icon + label) | >= 56 pt tall | Chip selected (rose border) |
| Fine aim + power | Drag back from the ball (slingshot) inside the chosen zone | Ball handle | 64 pt | Dotted arc (L1-2); haptic tick each 25% power |
| Serve | Release drag | n/a | n/a | Serve animation |
| **Tap-only** | After target+spin chips, tap **Serve**; placement in the zone is centred with seeded noise per level | Primary pill | 56 pt | Reticle appears |
- **Portrait**; controls in the bottom third; safe-area insets respected.
- **Not drawn by Unity:** hearts, paywall, exit confirmation, XP.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config, build scene, load scenario set | Ready/error | `ready` |
| Intro | ready | Situation card (side, score, attempt, returner stance) | Decision | `progress` |
| Decision | Intro done | Choose (side at L3+), target and spin | Aim | none |
| Aim | after decision | Slingshot/tap aim; hints available | Serve | none |
| Executing | Release | Deterministic flight; net-cord test; bounce; returner reach | First bounce or dead ball | none |
| Freeze | First bounce | Freeze; camera `top-down`; landing marker; reach ring; correct plan gold | Explain | `checkpoint round-N-freeze` |
| Explain | Freeze done | Card (section 12); optional slow-mo replay (side-on) | Next round | `checkpoint round-N` |
| Let replay | Cord serve lands in | Same attempt replayed once, then continue | Aim | none |
| Summary | last round | Score numerals | Done | `progress 1.0` |
| Done | summary | `result`, then `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze time / partial result with `xpEarned 0` | resume / end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Target box pre-shaded | yes | yes | yes | flash 1 s | no |
| Dotted preview arc | full | to net | no | no | no |
| Serving side | auto | auto | learner picks | learner picks | learner picks (score as number only) |
| Attempt shown | first only | first, second | first, second | first, second, "big point" | all + score pressure |
| Spin choice | flat only | flat, kick | flat, slice, kick | all | all + "which spin was that?" replay quiz |
| Aim noise (m at landing) | 0 | 0.15 | 0.25 | 0.35 | 0.45 |
| Returner stance shown | arrow cue | arrow cue | label only | none (read stance) | none, stance shifts once |
| Hints | 3 | 2 | 1 | 0 | 0 |
| Time limit (decision, s) | none | none | none | 12 | 8 |
| Scenario pool tags | `standard` | `standard`, `second-serve` | + `cord`, `sides` | + `pressure` | + `trap` |
- Default for `serve-05`: **2**. L1 is passable by a beginner: pre-shaded box, preview arc, flat only, zero noise.

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "tennis.serve.place-and-spin.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["serve-starter", "serve-sides", "serve-mixed"], "default": "serve-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "controlScheme": { "type": "string", "enum": ["slingshot", "tap-target"], "default": "slingshot" },
    "surface": { "type": "string", "enum": ["hard", "clay", "grass"], "default": "hard" },
    "showPreviewArc": { "type": "boolean", "default": true },
    "decisionTimeLimitSeconds": { "type": ["integer", "null"], "minimum": 5, "maximum": 30, "default": null },
    "assistLoft": { "type": ["boolean", "null"], "default": null, "description": "null = difficulty default." }
  }
}
```
Valid example: `{ "seed": 11, "scenarioSetId": "serve-starter", "scenarioCount": 3, "controlScheme": "slingshot", "surface": "hard" }`. Invalid -> `error CONFIG_INVALID`.

## 11. Scenario data set
- **Format:** `Scenarios/serve-place-v1.json` (bundle `sim-tennis-serve-place`). Sets: `serve-starter` = tags `standard`, `second-serve`; `serve-sides` = adds `sides`; `serve-mixed` = all. Deterministic by seed: seed picks order and aim-noise samples (sampled at round start so replays match).
- **N = 12 scenarios** (>= 3 rounds x 4). Shape:
```json
{ "scenarioId": "sv-s01", "side": "deuce", "attempt": "first", "score": "30-40", "returnerStance": "wide-cheat", "expected": { "target": "t", "spins": ["flat", "slice"] }, "teaches": ["serve-targets"], "tags": ["standard"] }
```
- **Scenarios:**

| scenarioId | Setup | Correct decision/outcome | Teaches | Tags |
|---|---|---|---|---|
| `sv-s01` | Deuce court, first serve, 30-40. Returner leans wide to protect the backhand. | Target T; flat or slice; lands in box. | `serve-targets`, `serve-diagonal-tennis` | standard |
| `sv-s02` | Ad court, first serve, 15-0. Returner stands deep and central. | Target wide with slice: the curve pulls it off the court. | `serve-targets`, `serve-spins` | standard |
| `sv-s03` | Deuce court, second serve, 40-30. Returner steps in to attack. | Kick to the body or deep middle: high bounce, safe over the net. | `first-second-serve`, `serve-spins` | second-serve |
| `sv-s04` | Ad court, first serve, 0-0, player has a fast flat serve. | Any target that lands in; flat T is fine. Lesson: first serve can be big. | `first-second-serve` | standard |
| `sv-s05` | Deuce court, ball clips the net cord on a fixed-launch serve and lands in the box. | Outcome `let`; replay the attempt, no penalty, no limit. | `service-let` | cord |
| `sv-s06` | Ad court, second serve, 30-40. Learner picks flat at full power. | Flat second serve clips the net or sails long: choose kick or slice for margin. | `first-second-serve` | second-serve |
| `sv-s07` | Score 3-3 (deuce in game). Returner leaning to the T. | Serve wide; aim into the outer third of the box. | `serve-targets` | standard |
| `sv-s08` | Score 2-1 in points (30-15). Wrong-side trap: both side rings shown, score as numbers only (L5). | Deuce court is played when the total points are even; here 30-15 is three points: ad court. | `serve-sides` | sides, trap |
| `sv-s09` | Deuce court, first serve, returner crowds the baseline (close). | Body serve jams the returner; flat at the hip. | `serve-targets` | pressure |
| `sv-s10` | Ad court, first serve, big point 15-40. The server has missed three first serves in a row. | Pick a high-percentage first serve (slice or kick body), not max power. | `first-server-percentage-idea`* | pressure |
| `sv-s11` | Deuce court, second serve, wind of nothing; returner stands well back. | Kick deep to the corner: hard for a deep returner to attack. | `serve-spins` | second-serve |
| `sv-s12` | Ad court, learner-picked spin quiz at L5: replay shows a ball curving to the sideline and skidding low. | Name it: slice. | `serve-spins` | trap |
- \* Use `first-second-serve` for `sv-s10`; there is no separate concept id (keep the concept list closed).
- Rules for the rest: generate by choosing side, attempt, score and stance from the tables; expected target = away from the stance (`wide-cheat` -> T, `t-cheat` -> wide, `close` -> body, `deep` -> wide or body); expected spin: second serve -> kick or slice; first serve -> any.

## 12. Freeze / explain moments
| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-in-away` | In box, away from returner | Landing gold; reach ring shorter than the gap | Correct | Nice read. Away from him. | You aimed where the returner is not. The gap was bigger than his reach, so he could barely get a racquet on it. | "Good serve. You went where he wasn't." |
| `x-in-body` | In, body target vs a crowding returner | Marker on returner; ring tight | Correct | Nice read. Jammed him. | He crowded the line, so you took away his room. A body serve gives him nowhere to swing. | "Body serve. It jammed him." |
| `x-in-close` | In box but into returner's strength | Reach ring covers the marker | Incorrect | Not quite. Into his reach. | It landed in, but right where he was leaning. Easy return. Aim away from the lean. | "It was in, but he was waiting for it." |
| `x-net` | Ball into the net (no cord in) | Arc with net contact marker | Incorrect | Not quite. Net's in the way. | The flat serve has the least room over the net. On a second serve, add spin for margin. | "Flat is risky. Kick it for safety." |
| `x-long` | Lands past the service line | Marker beyond the line | Incorrect | Not quite. Too long. | Long is a fault. Flat has more speed than arc. Slice or kick brings it down inside the box. | "Too long. A kick would have dropped." |
| `x-wide` | Lands outside the sideline | Marker outside; slice curve traced | Incorrect | Not quite. Wide of the box. | Slice curves toward the sideline. Aim a little inside the wide zone so the curve keeps it in. | "The slice pulled it wide. Aim inside." |
| `x-wrong-box` | Lands in the wrong box | Both boxes drawn; correct gold | Incorrect | Not quite. Wrong box. | Serves go diagonally. Right of centre sends you to the far left box (server's view). | "Serve diagonal, cross-court." |
| `x-cord` | Cord touch and lands in | Slow-mo on the net tape | Let (neutral) | Nice read. It's a let. | The ball touched the net and landed in the box. That is a let: replay the serve, as often as it happens. | "Let. Play it again." |
| `x-side-right` | Correct side (L3+) | Score card; ring gold | Correct | Nice read. Right side. | Even points served, so deuce court. The side decides your target box. | "Even points, deuce court." |
| `x-side-wrong` | Wrong side | Both boxes drawn | Incorrect | Not quite. Wrong court. | Total points even: deuce court. Odd: ad court. Count both scores together. | "Even is deuce, odd is ad." |
| `x-second-safe` | Second serve, kick in the box | Kick bounce trace (high) | Correct | Nice read. Safe second. | Kick clears the net with room and drops in. Trading speed for safety on a second serve is the smart deal. | "Second serve, kick it for safety." |
| `x-spin-name` | L5 quiz correct | Curve traced | Correct | Nice read. That's slice. | Sidespin curves the ball and keeps it low after the bounce. That skid pulls returners wide. | "That's a slice serve." |
| `x-timeout` | Decision timer expired | Auto-serve to the last chip | Timeout | Time's up. Serve went. | Slow down before the toss. Read the returner first, then choose. | "Breathe. Read the return, then serve." |

## 13. Scoring & mastery signals
- **Round success:** ball lands in the correct box after legal net clearance (cord-and-in = `let`, replays once and does not consume the round). Full credit needs a target that lands outside the returner's `reachMeters` (oracle below) and, at L3+, the correct side.
- **Returner oracle (pure function `ServeOutcomeOracle`, fixture-tested; numbers non-normative until tuned):** lateral gap `d = |landingX - returnerX|`; `speedClass` = fast (flat first) / medium (slice) / slow (kick, second). `reachMeters` = 1.3 (fast), 1.6 (medium), 1.9 (slow) plus 0.4 if the ball lands in the last 1.5 m deep zone (returner stretched). Outcome: `ace` if d > reach + 0.8; `weak-return` if d > reach; else `neutral`; `attackable` if slow speed class and landing z < 4.5 m.
- **Score (0-100):** `round(100 * mean(roundPoints))`; points 1.0 (in, `ace` or `weak-return`), 0.7 (in, `neutral`), 0.4 (in, `attackable`), 0.0 (fault). At L3+ wrong side costs -0.3 (floor 0). Hint penalty -0.1 each (floor 0.4 for in-serves).
- **accuracy** = rounds with `in` / rounds.
- **Mistake -> concept:**

| Mistake | conceptId | Description |
|---|---|---|
| Aimed at the returner's lean | `serve-targets` | Chose a target inside the returner's reach. |
| Flat second serve into net/long | `first-second-serve` | Took speed over safety on a second serve. |
| Wrong spin for the plan (e.g. slice into body when wide was needed) | `serve-spins` | Spin did not fit the target. |
| Landed outside the box (long/wide/net) | `service-box` | Serve missed the box. |
| Landed in the wrong box | `serve-diagonal-tennis` | Served straight ahead. |
| Wrong side | `serve-sides` | Chose the wrong court for the score. |
| Treated a cord serve as a fault (learner declines the replay) | `service-let` | Misread a let. |
- **Mastery signals:** in-box and away from returner -> `serve-targets` +0.20; correct spin choice -> `serve-spins` +0.15; safe second serve in -> `first-second-serve` +0.20; in the box -> `service-box` +0.10; correct side -> `serve-sides` +0.15; cord serve accepted -> `service-let` +0.25; mistakes -0.15 to the mapped concept. Session caps +-0.30 per concept; hints halve positives (native applies).
- **Result mapping:** `outcomes[]` per round (`id` `round-N`, `success`, `label`, `value` = `in|net|long|wide|wrong-box|let` plus returner outcome), `mistakes[]`, `masterySignals[]`.

## 14. XP & hearts
- Proposal: +10 per successful round, +40 for finishing; native clamps to the lesson budget.
- `heartsLost` = 1 if accuracy < 0.34, else 0; max 1 per session.
- `replayAvailable` true (deterministic re-run via seed).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain card for the specific outcome | outcome false + mistake | none |
| Failed session | "Serves take a few tries. Two more and you'll feel the arc." Try again | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout | Auto-serve, explain (`x-timeout`) | timeout outcome | none |
| Abort/backgrounded | Native flow | `aborted`, `xpEarned 0` | none |
| Asset missing / invalid config | Native error screen | `error` events | none |
Always ends in an explain moment; failure teaches.

## 16. Accessibility
- **Reduced motion:** no camera sweeps; freeze is a hard cut; arc preview is static dots; no shake; slow-mo replay disabled (replaced by a still with an arc trace).
- **Haptics:** `hapticsEnabled` respected; power ticks skipped when off.
- **Color-blind:** zones use stripes (wide), dots (body), dashes (T) plus text labels; landing marker is a filled circle (in) vs X (out); reach ring has dashed outline; nothing depends on rose vs gold alone.
- **Text scale** honoured; cards reflow.
- **Tap-only:** `controlScheme: "tap-target"` is the accessible path; nothing requires a drag.
- **VoiceOver:** Unity content is limited; native fallback lesson `serve-05-native` provided (three `hotspot-tap` + two `decision-scenario`).

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Drag pull | Soft rising tone | tick per 25% power |
| Serve hit | Clean racquet pop (synth) | soft tap |
| Bounce | Pop-tick (kick bounce higher pitch) | none |
| Net cord | Tape flutter | light tap |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
All honour `soundEnabled` / `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural? | Source/license | Budget |
|---|---|---|---|
| Court, net, boxes (hard/clay/grass tints) | Procedural | `original-swoond` | < 3k tris |
| Server and returner | Procedural low-poly | `original-swoond` | < 3k tris each |
| Ball, racquet | Procedural | `original-swoond` | < 500 tris |
| Overlays (arcs, rings, zones) | Procedural | n/a | n/a |
| Audio | Synth/original | `original-swoond` | <= 1 MB |
Bundle `sim-tennis-serve-place`, <= 6 MB. No player likeness, no logos.

## 19. Performance budget
`docs/astra/README.md` defaults apply. Tighter: physics at fixed dt 1/120 within 2 ms/frame; memory < 120 MB; cold launch < 2 s; bundle <= 6 MB.

## 20. Telemetry
`avgFps`, `p5Fps`, `loadTimeMs`, `peakMemoryMb`, `unityVersion`, `gameKitVersion`, plus `hintsUsed`, `decisionLatencyMsMedian`, `controlScheme`, `outcomeCodes`, `returnerOutcomes`, `difficulty`, `surface`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 11, difficulty 2, 3 rounds: exactly 3 `outcomes`; repeated runs give identical landing points.
2. **AC-2:** Landing classifier returns `in|net|long|wide|wrong-box` correctly on a 40-point fixture table including lines (lines are in; service line is in).
3. **AC-3:** Net-clearance test: y at the net plane below net height at that x plus ball radius is `net` (30 fixtures).
4. **AC-4:** A cord-touch fixture that lands in yields `let`, replays once, and does not add a mistake.
5. **AC-5:** Expected side rule: even total points -> deuce, odd -> ad (sweep of 0-0 to 6-6).
6. **AC-6:** `ServeOutcomeOracle` matches the fixture table (40 rows).
7. **AC-7:** Slice curves toward the sideline and kick bounces >= 1.25x the flat bounce height on fixtures.
8. **AC-8:** `ready` < 2 s; `result` schema-valid; exactly one `result`.
9. **AC-9:** Tap-only scheme completes a run with no drag events.
10. **AC-10:** Pause/resume freezes the decision timer and physics; abort yields `aborted=true`.
11. **AC-11:** Copy lint: titles <= 6 words, bodies <= 45 words, all outcomes have copy.
12. **AC-12:** Reduced-motion path has no camera sweeps; colour-blind second channel present.
13. **AC-13:** Invalid config -> `CONFIG_INVALID`.
14. **AC-14:** Perf: p5 >= 50 fps, memory < 120 MB on iPhone 13-class.
15. **AC-15:** Mastery caps +-0.30 per concept.

## 22. Test plan
- **EditMode:** `LandingClassifier`, net-clearance math, `ServeOutcomeOracle`, side rule, seed determinism, config validation, scoring, copy lint, result schema.
- **PlayMode:** scene build, scripted slingshot and tap-target runs, freeze/explain, pause/abort, reduced motion, colour-blind snapshot, let replay.
- **Perf:** iPhone 13-class 3-round run.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Serve` |
| AC-2, AC-3, AC-4 | EditMode | `LandingClassifier_Fixtures`, `NetClearance_Fixtures`, `Cord_Let_Replay` |
| AC-5 | EditMode | `ServeSide_ScoreSweep` |
| AC-6 | EditMode | `ServeOutcomeOracle_Fixtures` |
| AC-7 | EditMode | `SpinFlight_Fixtures` |
| AC-8 | PlayMode | `ColdLaunch_Result_Schema` |
| AC-9 | PlayMode | `TapTarget_FullRun` |
| AC-10 | PlayMode | `Pause_Abort` |
| AC-11 | EditMode | `Copy_Lint` |
| AC-12 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-13 | EditMode | `Config_Invalid` |
| AC-14 | Perf | `Perf_iPhone13` |
| AC-15 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | `Court` (tennis) module, `tennis_court` env, `TennisServe` helper, `Ball.Throw` `Swing` (GK-7). | Astra | Yes |
| 2 | Tuning: flat/slice/kick teaching-scale speeds (44/38/32 m/s) and kick bounce multiplier (1.35) are proposals; Astra to tune so slice curves 0.5 to 0.9 m and a mid-power kick lands 4.5 to 5.8 m past the net. | Astra | No |
| 3 | Is the `cord` scenario forced (fixed launch) or emergent? Proposed: forced by scenario. | Astra/Claude | No |
| 4 | Confirm current serve rules wording (any method, lets, foot fault) against the ITF Rules of Tennis before copy lock. | Claude (content) | No |
| 5 | Sim ignores handedness; left-handed servers mirror the slice curve. Add later? | Claude | No |

### Game Kit additions requested
- Tennis `Court` module + `tennis_court` env (shared by all three tennis sims; follows the pickleball Court pattern, GAME_KIT section 2).
- `TennisServe` helper (launch from aim and spin, landing classifier `in|net|long|wide|wrong-box|let`, `ServeOutcomeOracle`).
- Reuse GK-7 (`Ball.Throw` `Swing`; requested by soccer corner and pickleball serve spin, now also tennis), GK-13 (`DistanceRing`), GK-4-style timed decision window; no new generic primitive.
