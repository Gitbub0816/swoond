# Astra Roadmap: Wave 1, Wave 2 and Wave 3 build order (59 sims)

Recommended order for building the Swoon Game Kit and the 59 Tier A sims (41 Wave 1 in phases 0-5, 17 Wave 2 in phases 6-8, 1 Wave 3 in phase 9). Inputs: the 59 sim specs (`docs/courses/*/sims/`), the consolidated additions in `GAME_KIT.md` section 5 (GK-1 to GK-20 for Wave 1; GK-21 to GK-26, extensions and modules in section 5.5 for Wave 2; GK-27 and GK-28 in section 5.6 for Wave 3), and the course notes. Astra owns the actual plan; this is our recommendation and the reasoning behind it. All 59 specs are still `spec-draft`: each needs review to `spec-approved` before its build starts (see "Gates"). Six Wave 2 courses (cooking, music, pottery, camping, books, fashion) have no sims by design.

Sim counts: American Football 5, NASCAR 6, Formula 1 6, Pickleball 5, Hockey 6, Soccer 6, Basketball 6, Hiking 1 = 41 (Wave 1). Baseball 3, Golf 4, Tennis 3, Movies 2, Photography 3, Video Games 1, Cars 1 = 17 (Wave 2). Climbing 1 = 1 (Wave 3). Total 59.

## Ordering principles

1. Build what every sim needs first, then shared bundles that unlock a whole cluster, then single-sim items.
2. Prove the bridge and the hardest shared risk (determinism, scenario data, native fallback) on a sim that needs the fewest new pieces.
3. Within a cluster, order sims so each adds one or two new kit items (small, testable increments).
4. Leave sims with unresolved external gates (SME review, safety) and single-use tech until last.
5. Native remains authoritative: every sim ships with its bridge conformance run against `docs/contracts/unity-bridge/v1/examples/` and, per spec section 16, a designed native fallback lesson exists separately.

## Phase 0 - Game Kit foundations (unblocks all 41)

- Unity 6.3 LTS project, URP, assembly layout, CI (EditMode + PlayMode + build).
- Section 1 core primitives (Lesson, Simulation state machine, Character, Ball, Target, Zone, Path, CameraRig, TouchController, PhysicsObject with fixed timestep, DecisionPoint, Hint, Explanation, Objective, Score, Replay, SlowMotion, Highlight) and the support services (BridgeClient, ThemeService, AccessibilityService, Rng, ScenarioSet).
- Bridge conformance suite: launch -> ready -> progress -> result flows, pause/resume/abort, timeouts, against the contract examples.
- Golden-fixture harness: pure-function oracles (resolvers, evaluators) checked against committed JSON fixtures. Nearly every spec relies on this pattern (football resolvers, `CornerResolver`, basketball verdict tables, F1 golden generators).
- Sim-definition loader with registry validation (`CONFIG_INVALID` on unknown keys); the validator already compiles each spec's configuration schema.
- Accessibility: tap-only control scheme, reduced motion (cuts, no slow-mo sweeps), color-blind shape channels.

Exit: an empty test sim launches from native, reports progress and returns a valid `SimulationResult`.

## Phase 1 - First vertical slice: American Football (5 sims)

**Slice sim: `football.coverage.read.v1`.** Why first: it needs no new kit primitive (Football module only), a launch and a result example already exist in the bridge contracts, it is the reference course, and it exercises the central loop (scene -> freeze -> `DecisionPoint` -> `Explanation`, `Hint`, `Score`, `CameraRig`, `Highlight`). It measures Astra's real foundation cost with the least confounding new design. End-to-end target: native lesson -> Unity -> result -> mastery update, on device.

Then, in order:
1. `football.passing.window.v1`: adds `Pass.Evaluate` and the first use of GK-4 timed window.
2. `football.protection.pressure.v1` and `football.run.gaps.v1`: `Blocking` and `RunFit` resolvers (Football module only).
3. `football.routes.build.v1`: needs GK-1 `PathEditor`; schedule it with Phase 4 (`f1.racecraft.racing-line.v1` shares GK-1) unless football unit U2 must ship earlier. It is the most likely sim to be downgraded to native `visual-id` + `hotspot-tap` after playtest (football CDS open question 3).

## Phase 2 - Racing module and NASCAR (6 sims)

Why here: 12 of 41 sims sit on the Racing module, `Vehicle`/`Track`/`Draft`/`PitStop`/`TireState` already exist in the kit, and the data-driven definition example (`docs/contracts/sim-definition/v1/examples/racing-drafting.json`) is a NASCAR drafting sim. NASCAR needs the fewest new primitives of any cluster, so it validates the data-driven path cheaply.

Order:
1. `nascar.drafting.tuck-in.v1`: `Wake`/`Draft`, `AirflowOverlay`, `oval_intermediate`; first sim-definition (data) sim.
2. `nascar.drafting.superspeedway-run.v1`: `LaneMomentum`, `oval_superspeedway`.
3. `nascar.restart.choose-lane.v1`: `oval_short`, `road_course_short`; sim-local `RestartFormation`.
4. `nascar.track.groove-read.v1`: `RubberMap`, `oval_short_banked`, `oval_flat`.
5. `nascar.handling.tight-loose.v1`: `HandlingBalance`, `SlipArrows`.
   - **2b (Wave 2, optional here): `cars.handling.drive-layout.v1`** slots right after `tight-loose` because it reuses `HandlingBalance` and `SlipArrows` and adds only `corner_topdown` and `GripMeter`; gated on a playtest against the native `hc-04-native` (P-21) and a vehicle-dynamics plausibility pass (S-11). Can also wait until phase 8 if the playtest is pending.
6. `nascar.strategy.caution-call.v1`: existing `PitStop`/`TireState`/`FuelState`/`Position`/`Timing` with a sim-local `ProjectionModel`. Gate: NASCAR SME plausibility check of the stylized constants (NASCAR open question 4).

## Phase 3 - Team-sport spatial kit and four courses (23 sims)

Build the shared spatial bundle once, then bring courses in from cheapest to richest so every sim adds only one or two items. Bundle (GK IDs from `GAME_KIT.md`): environment builders (`pickleball_court`, `hockey_rink`, `soccer_pitch`, `basketball_*_court`), GK-11 FormationSet/CoverageModel, GK-19 camera presets, GK-9 line-crossing/arrival, GK-3 DecisionPoint modes, GK-10 evaluators, GK-6 ScriptedSequence, GK-4 timed window (from Phase 1).

### 3a Pickleball (5): smallest court, simplest rules
`kitchen.momentum-call` (Court, `KitchenRule`, `BounceRule`) -> `third-shot.drop-and-advance` (GK-9 `reach_zone_by_event`) -> `serve.aim-and-land` (`Serve`) -> `soft-game.attack-or-reset` (GK-4) -> `doubles.court-coverage` (`Formation` on GK-11, `maintain_proximity`).
Why first among the four: shortest path to a shipped court sim, and it seeds GK-9, GK-4 and GK-11 at small scale. No live-data pressure.

### 3b Hockey (6)
`rules.offside-read` (Rink/Puck, GK-8 `Feet`, GK-9, `line-cam`) -> `rules.icing-call` (`RaceEvaluator`, `broadcast-high-behind`) -> `special-teams.power-play-spacing` (GK-10 `LaneEvaluator`, GK-11 `FormationSet`) -> `tactics.forecheck-read` (`InterceptionEvaluator`, `PursuitPath`) -> `tactics.dzone-coverage` (`CoverageModel`, GK-14) -> `tactics.line-change-timing` (GK-17 `TimelineStrip`, `ShiftFatigueObjective`, `bench-cam`).
Rationale: heaviest reuse of the bundle (GK-8, 9, 10, 11), and its line-call and lane logic is what soccer and basketball reuse next. Gate: hockey coach review of formation names and the five-zone model; rulebook re-check for airborne-skate offside wording.

### 3c Soccer (6)
`offside.line-read` (SoccerPitch, `OffsideLine`, multi-select DecisionPoint, `line-cam`; reuses GK-9) -> `defending.line-height` (`LineController`, `LineResolver`, continuous DecisionPoint, `side-on-tilted`) -> `shape.formation-read` (`FormationRows`, chip selector) -> `pressing.trigger-call` (GK-6 `ScriptedSequence`, `TimedWindowObjective`, `CoverShadow`) -> `setpiece.corner-read` (`CornerResolver`, `Swing`) -> `attack.overload-find` (`LaneEvaluator` from 3b, reuses GK-6).
Rationale: the soccer CDS itself says offside and shape go first; the pitch/offside pair reuses the hockey line-call work, and the ScriptedSequence-heavy sims land after the kit item has a first consumer.

### 3d Basketball (6)
`spacing.floor-spacing` (Basketball module, GK-2 `SlotPlacement`, GK-13 `DistanceRing`, `place_and_resolve`) -> `defense.help-rotation` (`rotate_and_close`, `help_gap_overlay`) -> `zones.zone-attack` (`ZoneShell`, `find_gap`, GK-14) -> `screens.pnr-read` (`Coverage`, `ScreenAction`, GK-4 ring timer, `read_and_choose`) -> `transition.fast-break` (`BreakDefender`, `choose_at_line`) -> `officiating.charge-block` (GK-5 replay scrub, GK-8 foot markers, `judge_frame`).
Rationale: most basketball-specific new work and the most SME-gated cluster, so last of the four; `spacing` is the seed for the other five. Gates: basketball SME review of all six reference models before Astra starts; referee SME on the charge/block engine before `charge-block` is built. Timing note: the 2026-27 NBA season opens 20 Oct 2026; the spatial-kit sims will not be ready by then, so the basketball course launches native-first and adds sims as they land.

## Phase 4 - Formula 1 (6 sims) plus `football.routes.build.v1`

Why after NASCAR and the team-sport bundle: F1 has the largest racing-specific surface (`RaceSim`, `ActiveAero`, `EnergyStore`, `Overtake`), needs golden generators for every optimiser-backed sim, and reuses the NASCAR wake, overlay and chart work.

Order: `f1.racecraft.slipstream-pass` (`DirtyAir`, `Overtake`, `wake_cone` on the NASCAR wake) -> `f1.racecraft.racing-line` with `football.routes.build` (GK-1 `PathEditor`, GK-16 `speed_trace`; one primitive, two consumers) -> `f1.aero.active-modes` (`ActiveAero`, `wing_schematic`) -> `f1.energy.deploy-harvest` (`EnergyStore`, `value_ribbon`) -> `f1.strategy.pit-window` (`RaceSim`, `gap_chart`) -> `f1.strategy.safety-car-call` (`RaceSim` neutralisations, `order_strip`).
Gates: re-verify 2026 regulation facts and per-circuit Straight Mode zones before copy locks; team-neutral visuals (no logos, liveries, likeness).

## Phase 5 - Terrain: Hiking (1 sim) and Golf putting (Wave 2)

`hiking.navigation.topo-terrain.v1` last: it is the only consumer of the Terrain module (GK-20) plus `oblique-low`, `Viewshed`, `SlopeShader`, the biggest isolated cost for one sim, and the course works without it (5 lessons have a native fallback `nv-05`, or `hotspot-tap` replacements). Wave 2 now supplies the second consumer: `golf.putting.read-the-break.v1` (phase 6c) needs `Heightfield`, `ContourOverlay` at 0.5 in intervals, `water_flow` and the `golf_green` preset, so Terrain is built once for whichever of the two ships first and the other rides on it (camping's revisit-only `camping.site.read.v1` would be a third). Gate: product approval of the hiking sim (hiking CDS open question 1).


## Phase 6 - Wave 2 sports (10 sims)

Why after phase 3: tennis and golf reuse the court/ball kit that pickleball, soccer and hockey prove, and baseball needs a new field module but reuses the same spatial bundle (GK-2, 4, 9, 11, 13, 14). None is a Wave 1 prerequisite, so they follow the Wave 1 sports rather than compete with them.

### 6a Tennis (3): cheapest, extends an existing pattern
Build order: `tennis.serve.place-and-spin.v1` (new `Court` module and `tennis_court`, `TennisServe`, shares `RacquetServe` with pickleball `serve.aim-and-land`, GK-7 `Swing`, GK-13) -> `tennis.rally.arc-and-margin.v1` (sim-local `RallyMargin`, `side-on-tilted`) -> `tennis.court.open-court-recovery.v1` (sim-local `RecoveryOracle`, GK-10, GK-15). Why first in Wave 2: no new kit primitive beyond the Court builder, three sims for one module. Gate: one SME pass (S-06 extension); golden generators for `RallyMargin` and `RecoveryOracle`.

### 6b Baseball (3)
Build order: `baseball.baserunning.read-and-go.v1` (needs only `BaseballField`, `BaseRunner`, GK-4, GK-9; the course's own recommendation) -> `baseball.defense.alignment-read.v1` (GK-11 alignments, GK-2 `IsLegal`, GK-14 reach circles, GK-13) -> `baseball.pitching.pitch-shapes.v1` last (`PitchFlight` on GK-7, `StrikeZoneOverlay`, `batter-eye`/`catcher-cam`/`orbit` presets, GK-16 break plot; Astra sizes it first, baseball CDS open question 10). Gate: baseball SME pass on all three models (S-07). Timing: MLB data and the December CBA explainer are live-layer items, independent of the sims.

### 6c Golf (4)
Build order: `golf.ball-flight.shot-shape.v1` (Golf module, `golf_hole`, `FlightModel`, GK-7, `chase-high`/`top-down`) -> `golf.strategy.play-your-miss.v1` (GK-24 `DispersionOverlay`, `DispersionModel`, `StrokesTable`; also pays forward to tennis/pickleball serve targeting) -> `golf.short-game.carry-and-roll.v1` (GK-25 `Ball.Roll`, `ShortGameModel`) -> `golf.putting.read-the-break.v1` (Terrain green preset; ships with phase 5). Gate: PGA professional or coach review of all four models (S-08); golden-generator reproduction of scenario windows.

## Phase 7 - Camera and optics (5 sims)

One shared primitive, GK-21 `PhysicalCamera`, unlocks both the film and photography courses, and none of the five needs a physics system. Order: `film.camera.lens-and-move.v1` (Film module, `FilmCamera`, `film_set_street`, GK-15, `film-frame`/`top-down-inset`; the stronger Tier A case) -> `photo.lens.compression-lab.v1` (reuses `PhysicalCamera` and `photo_stage`) -> `photo.focus.depth-of-field.v1` (GK-22 `DepthOfFieldPass`, `dof_scale`; confirm the URP mobile depth-of-field budget here first) -> `film.camera.axis-line.v1` (`AxisRules`, `film_set_room`, `split-cut`; downgrade candidate vs native `binary-call`, P-21) -> `photo.light.direction-lab.v1` last (GK-23 `SoftLight`; the weakest Tier A case, playtest against native pre-rendered positions). Gates: cinematographer/optics SME pass (S-10, low effort); the photography in-house shoot (L-24) is independent of the sims. Safety review of photography copy (S-15) does not block the sims.

## Phase 8 - Controls (1 sim, last)

`games.controls.aim-assist.v1`: Controls module (`ReticleAim`, `RateStick`, `AimAssist` variants), GK-26 `TrackingObjective`, `drag-relative`, `aim_range`. It needs almost nothing else, so it is scheduled last alongside the isolated hiking sim. Gate: the 20-plus novice playtest against the native `mech-02-alt` with an 8-point concept-check lead; if it fails, drop the sim and rename `mech-02-alt` to `mech-02` (P-21).

## Phase 9 - Wave 3: Climbing (1 sim, last, cut-first candidate)

`climbing.bouldering.problem-read.v1` (Read the Wall): the only Wave 3 sim and the weakest Tier A case in the catalog (camera perspective is real, but a native side-profile hotspot gets most of the learning; native fallback lesson `rw-08`; P-38). It needs two new single-consumer items, GK-27 `WallBuilder` (with `WallPanel`, `Volume`, `HoldShape`, environment key `climbing_wall`) and GK-28 `AngleGauge`, plus the `orbit-wall` camera preset (GK-19 family). Dependencies: Phase 0 core (Simulation, DecisionPoint GK-3 multi-select, objectives GK-12 `choose_target`, `CameraRig` GK-19, Highlight), nothing from the sport modules. Schedule after phase 8 and only if capacity allows; if cut, replace `rw-06`, `rw-07`, `bb-03`, `pr-02` with `hotspot-tap` and `multiple-choice`. Gate: qualified climbing reviewer (S-20) and a route-setter check of the "where the crux usually is" heuristic.

## Summary table

| Phase | Sims | New kit items introduced | Cumulative sims |
|---|---|---|---|
| 0 | 0 (test sim) | Core primitives, bridge, harness | 0 |
| 1 | 4 (+1 later) | Football module, GK-4 | 4 |
| 2 | 6 | Racing shared items (`Wake`, `AirflowOverlay`, `LaneMomentum`, `RubberMap`, `HandlingBalance`) | 10 |
| 3a-d | 23 | Court/rink/pitch modules, GK-2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 19 | 33 |
| 4 | 7 | GK-1, 16, 18, `RaceSim`, `ActiveAero`, `EnergyStore`, `Overtake` | 40 |
| 5 | 1 | GK-20 Terrain | 41 |
| 6a-c | 10 | Tennis Court, Baseball module, Golf module, GK-24, GK-25, GK-7 `PitchFlight`, GK-2 `IsLegal`, GK-16/19 extensions (golf putting ships on the phase 5 Terrain build) | 51 |
| 7 | 5 | GK-21, GK-22, GK-23, Film module | 56 |
| 8 | 1 | Controls module, GK-26 | 57 |
| 2b (or after 8) | 1 | `corner_topdown`, `GripMeter` (cars drive-layout, inside the NASCAR cluster if its playtest gate is done) | 58 |
| 9 | 1 | GK-27 `WallBuilder`, GK-28 `AngleGauge`, `orbit-wall` (climbing; cut-first) | 59 |

## Gates checklist (before each sim starts)

- Spec moves from `spec-draft` to `spec-approved` (product + Astra), manifest `unitySimulations[].status` follows.
- SME reviews listed in `docs/product/OPEN_QUESTIONS.md` (section "SME reviews") for that course.
- The designed native fallback lesson exists (spec section 16).
- Wave 2 additions: the cars, aim-assist, photo light-direction and film axis-line sims also pass their playtest-versus-native gate (P-21).
- Validator green: spec path exists and the configuration schema compiles (`node tools/validate/validate.mjs`).
- Sim configuration examples in the spec launch in the sim's EditMode tests.
