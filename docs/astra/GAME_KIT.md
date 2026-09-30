# Swoon Game Kit

Reusable Unity framework (product spec sections 23-25). Sims are assemblies of proven primitives, not bespoke apps. Owned by Astra. API sketches below are C#-ish pseudocode to fix responsibilities and names; Astra owns the final signatures but must keep names and responsibilities stable so specs and sim definitions keep working.

## 1. Core primitives (spec section 23)

Conventions: `IdString` = stable string id; `Seconds` = float; all primitives are `MonoBehaviour`/plain C# classes constructed by code (no manual scene wiring).

### Lesson
Responsibility: root context of a run; ties a sim to its `LaunchRequest`, owns conceptIds, difficulty and lifecycle.
```csharp
class Lesson { LaunchRequest Request; int Difficulty; IReadOnlyList<string> ConceptIds;
  void Begin(); void Pause(); void Resume(); void Abort(string reason); event Action<SimulationResult> Completed; }
```

### Simulation
Responsibility: state machine host (Loading, Intro, Playing, Decision, Executing, Freeze, Explain, Summary, Done); runs rounds; emits bridge events.
```csharp
abstract class Simulation { abstract string SimulationId {get;} abstract string Version {get;}
  StateMachine<SimState> States; int RoundIndex; int RoundCount;
  protected abstract void BuildWorld(WorldBuilder b); protected abstract IEnumerator RunRound(int i);
  void EmitProgress(float f); void EmitCheckpoint(string id); }
```

### Character
Responsibility: humanoid stylized agent (low-poly) with animation states, movement along Paths, role tag (receiver, defender, player).
```csharp
class Character { IdString Id; Team Team; void MoveAlong(Path p, float speed); void Face(Vector3 t); void Play(AnimState s); void SetHighlight(HighlightStyle s); }
```

### Vehicle
Responsibility: simplified arcade vehicle physics (not simulation-grade): speed, steering, drag; supports draft and tire/fuel hooks in the racing module.
```csharp
class Vehicle { float Speed; float DragCoefficient; void SetThrottle(float t); void SetSteer(float s); void FollowPath(Path p, float targetSpeed); }
```

### Ball
Responsibility: ball physics and flight paths (parabolic, bounce), possession, bounce counting.
```csharp
class Ball { Vector3 Position; void Throw(Vector3 target, float arcHeight, Seconds flight); void Bounce(Vector3 n, float restitution); int BounceCount; Character Holder; event Action<Vector3> Landed; }
```

### Target
Responsibility: something the learner aims at or selects (receiver, lane, zone, marker); selectable via TouchController; can carry `conceptId`.
```csharp
class Target { IdString Id; bool IsCorrect; string ConceptId; void SetState(TargetState s); event Action<Target> Selected; }
```

### Zone
Responsibility: region on the play surface (area, polygon or circle) that reports entry/exit and occupancy; used for kitchen, coverage zones, win areas; renders as translucent overlay.
```csharp
class Zone { IdString Id; ZoneShape Shape; bool Contains(Vector3 p); event Action<Entity> Entered, Exited; void Show(OverlayStyle s); }
```

### Path
Responsibility: parametric path/route (spline of waypoints) in world space; length, sample at t, draw as overlay line.
```csharp
class Path { IReadOnlyList<Vector3> Points; float Length; Vector3 Sample(float t); void Draw(OverlayStyle s); static Path FromRouteSpec(string spec); }
```

### CameraRig
Responsibility: all camera behavior: presets (chase-high, broadcast-side, top-down, first-person), smooth transitions, framing of targets, slow-mo dolly on freeze; honors reduced motion (cuts instead of sweeps).
```csharp
class CameraRig { void Preset(string name, Seconds blend); void Frame(IEnumerable<Transform> t, float padding); void Shake(float amount); }
```

### TouchController
Responsibility: unified touch input: tap, drag, swipe, hold, virtual stick, with >= 44 pt hit targets, safe-area awareness and accessibility alternatives (tap-only mode).
```csharp
class TouchController { event Action<TapEvent> Tapped; event Action<DragEvent> Dragged; event Action<SwipeEvent> Swiped;
  void SetScheme(ControlScheme s); void SetHitPadding(float pts); }
```

### PhysicsObject
Responsibility: deterministic lightweight physics body (kinematic or simple dynamics) with fixed timestep so replays match; used by Ball and props.
```csharp
class PhysicsObject { Vector3 Velocity; float Mass; void Step(float fixedDt); void ApplyForce(Vector3 f); }
```

### DecisionPoint
Responsibility: the "one decisive interaction": pauses/slows the sim, presents options (Targets or choice buttons), optional time limit, records the choice and latency.
```csharp
class DecisionPoint { IdString Id; IReadOnlyList<Target> Options; Seconds? TimeLimit; Task<Decision> AwaitDecision(); }
```

### Hint
Responsibility: progressive help (highlight, ghost path, text) gated by difficulty; each use recorded so native halves mastery gain.
```csharp
class Hint { HintLevel Level; void Show(Entity e); int UsedCount; }
```

### Explanation
Responsibility: freeze-frame explain moment: overlay callouts, arrows, a copy card (Display S line + body), optional "say this" line; text comes from spec/scenario data, localized.
```csharp
class Explanation { string Title; string Body; string SayThisLine; IReadOnlyList<Callout> Callouts; Task Present(); }
```

### Objective
Responsibility: evaluates a learning goal over time (maintain proximity for 8 s, reach zone, choose correct target); reports progress and success/failure; links to conceptIds.
```csharp
abstract class Objective { IdString Id; string[] ConceptIds; ObjectiveState State; float Progress; abstract void Tick(float dt); event Action<Objective> Succeeded, Failed; }
```

### Score
Responsibility: accumulates points, accuracy, outcomes and mistakes; builds the `SimulationResult` (score 0-100, accuracy, outcomes[], mistakes[], masterySignals[]).
```csharp
class Score { void RecordOutcome(string id, bool success, string label=null, object value=null);
  void RecordMistake(string conceptId, string description); void Signal(string conceptId, float delta, string evidence);
  SimulationResult Build(bool completed); }
```

### Replay
Responsibility: records deterministic inputs/state per round and replays with camera changes; powers "watch what happened" without re-simulating differently.
```csharp
class Replay { void Record(SimulationFrame f); void Play(float speed, CameraPreset cam); bool Available; }
```

### SlowMotion
Responsibility: global time-scale ramps with ease curves for freeze/explain; audio pitch handling; disabled or shortened under reduced motion.
```csharp
class SlowMotion { void RampTo(float scale, Seconds duration); void Freeze(); void Release(); }
```

### Highlight
Responsibility: visual emphasis on entities/zones/paths (rose for "you/act", gold for "earned/correct", pulsing ring, outline shader, dim-others); color-blind safe (shape + pattern in addition to color).
```csharp
class Highlight { void Apply(Entity e, HighlightStyle s); void Clear(Entity e); static HighlightStyle Rose, Gold, Muted; }
```

### Support services (not in spec list; required)
- **BridgeClient**: parse `LaunchRequest`, emit events, honor pause/resume/abort, enforce timeouts.
- **ThemeService**: exposes `theme.colors` / fonts to overlays and materials.
- **AccessibilityService**: reducedMotion, haptics, colorBlindMode, textScale.
- **Rng**: seeded deterministic random.
- **ScenarioSet**: loads scenario data (JSON) for the sim.

## 2. Sport-specific modules (spec section 24)

Built on the primitives; reusable across sims of the same sport.

### Football (`Swoond.Sports.Football`)
`Formation` (offense/defense alignments as data), `Route` (named routes -> `Path`: go, post, out, slant, curl, seam), `Coverage` (Cover 0/1/2/3/4, man; assigns zones/man matchups to defenders and reacts to routes), `Down` (down & distance state), `Possession`, `Pass` (throw with arc, window checks), `Tackle`, `Receiver`, `Quarterback`, `Defender`.
Responsibilities: pre-snap alignment from formation data, deterministic post-snap movement from Route/Coverage rules, "open receiver" evaluation for the explanation.

Wave 1 additions (class-level, Football module only; no kit primitive): `RouteClassifier` (named route from a drawn path; `football.routes.build.v1`), `Blocking` (assignment resolver: each OL blocks the nearest unassigned rusher inside-out; `football.protection.pressure.v1`), `RunFit` (gap assignments and lane yardage; `football.run.gaps.v1`), `Pass.Evaluate(spot)` (flight time, arrival, intercepted / complete outcomes; `football.passing.window.v1`). `football.coverage.read.v1` needs nothing beyond the existing module.

### Racing (`Swoond.Sports.Racing`), shared by NASCAR and Formula 1

Existing: `Vehicle` (racing tuning), `Track` (procedural oval/road course as `Path` + banking), `RacingLine`, `Draft` (drag reduction by distance/alignment), `TireState` (wear/grip), `FuelState`, `PitStop` (timing window, service phases), `Position` (running order), `Timing` (lap/gap/interval).

(Sim short names such as `n.tuck` and `f1.slip` are defined in section 5.) Wave 1 requests split into what both series use and what belongs to one series. Rule of thumb: physics-and-strategy building blocks are shared and parameterised by a per-series rule pack (data); anything that only makes sense under one rulebook stays series-specific.

| Item | Scope | Needed by | Notes |
|---|---|---|---|
| `Wake` (Draft + `DirtyAir`: drag reduction and downforce loss as a function of gap/offset) | Shared | n.tuck, n.super, f1.slip | One wake model; `Draft` keeps its API, `DirtyAir` (`closePenalty`, `range`) is the downforce side. |
| `AirflowOverlay` (ribbons bending around a Vehicle; `sourceVehicle`, `ribbonCount`, `thicknessBehind`) with style `wake_cone` | Shared | n.tuck, f1.slip | Highlight extension. Reusable for cycling. |
| `LaneMomentum` (pure function on `Draft`, used for scoring and Hint arrows) | Shared (requested by NASCAR) | n.super, f1.slip (tows) | |
| `HandlingBalance` (Vehicle component; `SetBalance(b)` -> lateral offset and yaw) and `SlipArrows` (Highlight extension) | Shared (requested by NASCAR) | n.tight | Reusable for F1 corner sims and karting. |
| `RubberMap` (Track overlay: per-lane intensity strips) | Shared (requested by NASCAR) | n.groove | Reusable for F1 dry-line/rubbered-in explanations. |
| `RaceSim` (deterministic lap-by-lap engine with pluggable rule pack: tyre model, pit loss, neutralisations, pass margin) | Shared engine, series rule packs | f1.pit, f1.sc; n.caution as a later consumer | NASCAR `caution-call` ships with a sim-local `ProjectionModel` first; migrate onto `RaceSim` with a NASCAR rule pack (caution, fuel windows, free pass) when both exist. |
| Chart demonstrate types `speed_trace`, `value_ribbon`, `gap_chart`, `order_strip` | Shared (see GK-16, GK-18) | f1.line, f1.aero, f1.energy, f1.pit, f1.sc | Generic, not racing-only. |
| Path editing on a racing line (`shape_path` objective, `drag-handles` scheme) | Shared (see GK-1) | f1.line | |
| Environment keys `oval_short`, `oval_short_banked`, `oval_flat`, `oval_intermediate`, `oval_superspeedway`, `road_course_short` | NASCAR | n.* | Procedural `Track` presets. |
| `LaneMomentum` tuning, `RestartFormation` (sim-local, promote if IndyCar/F1 need it), `ProjectionModel` (sim-local) | NASCAR | n.restart, n.caution | Not kit primitives. |
| Environment keys `f1_corner_track`, `f1_straight_and_braking`, `f1_lap_oval_abstract`, `f1_race_topdown` | F1 | f1.* | |
| `ActiveAero` (wing state `w`, actuation time, drag/downforce multipliers) + overlay style `wing_schematic` | F1 (2026 era) | f1.aero | |
| `EnergyStore` (battery with deploy, regen, clip and taper curve) | F1 (reusable by Formula E/MotoGP) | f1.energy | |
| `Overtake` (2026 deployment taper model; `taperStartMps`, `omTaperStartMps`) | F1 (2026 era) | f1.slip | |

Convention from F1: sims backed by a search/optimiser (racing line, pit window, energy plan) ship a checked-in "golden generator" that writes reference values to fixtures; spec values are non-normative until the generator runs.

### Hockey (`Swoond.Sports.Hockey`)
First use: `hockey.rules.offside-read.v1`; shared by all six hockey sims. `Rink` (dimensions, zones, lines and dots as data), `Puck` (a `Ball` preset), `SkaterMotion`, `Bench` (zone with a door), `FormationSet` shapes for power play / penalty kill / umbrella / 1-2-2 / left-wing lock (data; see GK-11). Rule engines: offside by blade positions (uses GK-8 `Character.Feet`), icing race (GK-9), line-change timing bands (GK-17). Environment key `hockey_rink` (proposed; specs say "Rink").

### Soccer (`Swoond.Sports.Soccer`)
`SoccerPitch` (environment builder: markings, goals, stripe pattern, coordinate helpers; key `soccer_pitch`), `OffsideLine` (overlay + pure `EvaluateOffside`), `FormationRows` (row clustering and formation label derivation), `CornerResolver` (deterministic marking/zone resolver: `Load`, `Reach`; testable pure function), `LaneEvaluator` (see GK-10), `LineResolver` and `LineController` (move a defensive line with easing; resolve against timeline scenarios). Camera presets `line-cam`, `side-on-tilted` (GK-19).

### Basketball (`Swoond.Sports.Basketball`)
First use: `basketball.spacing.floor-spacing.v1`; shared by all six basketball sims. `Court` (procedural half and full court, named spots, feet-based coordinates, league variants `nba` / `wnba` / `college` for arc radius), `PlayerRole` (roleTag, shootThreat, finishThreat, elite), `BasketballSpots` registry, `Coverage` (ball-screen coverage as keyframed data: drop, hedge, blitz, switch, ice; mirrorable), `ScreenAction` (choreographs handler, screener and contact with timings), `BreakDefender` (scripted commit states, 14 ft/s), `ZoneShell` (anchors, row factors, lag lambda, pass-lane deflection distance; extensible to 1-2-2 and box-and-one). Keys `basketball_half_court`, `basketball_full_court`. Coordinate convention is shared with the native diagrams (x sideline to sideline over 50 ft, y from half-court line to baseline over 47 ft).

### Pickleball (`Swoond.Sports.Pickleball`) and the shared Court pattern
The reserved "Court" module is now specified by pickleball, first use `pickleball.kitchen.momentum-call.v1`, shared by all five pickleball sims: `Court` (dimensions, `Kitchen` non-volley zone, line width; key `pickleball_court`), `BounceRule` (two-bounce), `KitchenRule` (pure evaluator for tests and the scenario oracle), `Serve` (launch from drag/tap, loft assist, landing classifier `in|short|net|long|wide|wrong-box`), `Formation` (pair centre/spacing function, ideal positions; implemented on GK-11 `FormationSet`). Pattern for future racquet sports (tennis, padel, badminton): a `Court` builder + rule evaluator under `Swoond.Sports.<Sport>`; Basketball and Pickleball `Court` share only the builder conventions (named spots, feet/metre coordinates), not code.

### Terrain (`Swoond.Terrain`, first use `hiking.navigation.topo-terrain.v1`)
Not a sport module: a map/terrain toolkit for hiking and later camping, climbing, golf (green reading), skiing, cycling. `Heightfield` (deterministic seeded noise + named stamps, sampling, grade/aspect) and `TerrainMesh` (129 x 129, LOD-free), `ContourOverlay` (marching-squares contours with interval, index lines and labels; flat or draped), `SlopeShader` (grade colour ramp with hatching second channel), `Viewshed` (line-of-sight rays and lit-cell viewshed from an eye point), `ProfileChart` (see GK-16). Key `terrain_heightfield`; camera preset `oblique-low`; demonstrate types `terrain_lift`, `water_flow`, `viewshed`, `elevation_profile`; objective `choose_correct_target` (folded into GK-12 `choose_target`).

## 3. Data-driven simulation definitions (spec section 25)

Sims should increasingly be defined as data composed from primitives. The formal schema: `docs/contracts/sim-definition/v1/sim-definition.schema.json` (JSON canonical; YAML authoring allowed). Example: `docs/contracts/sim-definition/v1/examples/racing-drafting.json`; YAML view of the same:

```yaml
definitionVersion: "1.0.0"
simulationId: nascar.drafting.tuck-in.v1
simulationVersion: "1.0.0"
title: Why drafting works
lesson: { courseId: nascar, lessonId: drafting-01, conceptIds: [drafting, aerodynamic-drag] }
world: { environment: oval_short, params: { laps: 2 } }
entities:
  - { id: car_01, kind: Vehicle, role: player }
  - { id: opponent_01, kind: Vehicle, role: opponent }
objectives:
  - id: maintain-draft
    type: maintain_proximity
    params: { behind: opponent_01, distanceCarLengths: [0.8, 1.5], durationSeconds: 8 }
demonstrate:
  - { id: drag-visual, type: aerodynamic_drag, params: { mode: visual } }
success: [freeze_simulation, compare_speed, "explain:drafting"]
```

Registries (Astra-owned, versioned with the Game Kit): environment keys, entity kinds, objective types, demonstrate types, actions. An unknown key is a load-time error (`CONFIG_INVALID`). New keys are added to this doc when created.

### Standard actions
`freeze_simulation`, `slow_motion_replay`, `compare_speed`, `highlight:<entityId>`, `explain:<explanationId>`, `award_signal:<conceptId>:<delta>`, `end_round`, `next_scenario`.

## 4. Kit governance

- Kit version is semver (`gameKitVersion` reported in `ready`). Breaking kit changes require migrating existing sims in the same change.
- Every primitive ships with EditMode tests and a minimal PlayMode demo scene generated by code.
- A new primitive must be requested by at least one sim spec and be reusable by at least one more plausible sim.

## 5. Requested additions (Wave 1)

Consolidated from the "Game Kit additions requested" sections of all 41 Wave 1 sim specs (roughly 110 raw line items) and the course notes. Equivalent requests were merged into **20 generic primitives (GK-1 to GK-20)**; everything else is a sport-module class (section 2), a registry key (below) or sim-local code. Astra owns final signatures; names and responsibilities here are the contract with the specs. Each entry follows the section 4 rule: requested by at least one sim, plausibly reusable by another.

Sim short names: **fb** = football (`coverage`, `window` = passing.window, `protect` = protection.pressure, `run` = run.gaps, `routes` = routes.build); **n** = nascar (`tuck`, `super` = superspeedway-run, `caution`, `tight`, `restart`, `groove`); **f1** (`aero`, `energy`, `line` = racing-line, `slip` = slipstream-pass, `pit`, `sc` = safety-car-call); **pb** = pickleball (`kitchen`, `serve`, `third`, `soft`, `cover`); **hk.topo** = hiking topo-terrain; **bb** = basketball (`space`, `pnr`, `charge`, `help`, `break`, `zone`); **hy** = hockey (`offside`, `icing`, `pp` = power-play-spacing, `fore`, `line` = line-change-timing, `dzone`); **sc** = soccer (`offside`, `press`, `shape`, `corner`, `overload`, `height` = defending.line-height).

### 5.1 Generic primitives

"Req" = sims whose spec requested it; "Reuse" = sims that plan to reuse it or clearly fit.

| ID | Primitive (merged from) | Req | Reuse | Sims |
|---|---|---|---|---|
| GK-1 | **`PathEditor`**: `TouchController` + `Path` waypoint editing with snap-to-grid, angle snapping, min/max length, axis-constrained `drag-handles` scheme (lateral-only, along-edge-only), accessible stepper/chip alternative; objective type `shape_path` (learner edits a Path through anchored Targets). Merges football `PathEditor` and F1 `shape_path` + `drag-handles`. | fb.routes, f1.line | golf aim points, hiking route planning | 2 |
| GK-2 | **`SlotPlacement`** (TouchController): tap-select then tap-place, or drag-and-snap (60 pt magnet), undo by tapping a placed player. | bb.space | bb.zone, pb.cover, sc.shape, fb formations | 1 (+3) |
| GK-3 | **`DecisionPoint` modes**: multi-select (options + "Nobody"), continuous (button live during Playing, no freeze), screen-space chip selector. Merges soccer requests and the chips alternatives of football/basketball. | sc.offside, sc.press, sc.height, sc.shape | sc.corner, fb.routes (chips) | 4 (+2) |
| GK-4 | **Timed decision window**: `SlowMotion.Window(realSeconds)` (slows time-scale, measures the timer in real time), visible ring-timer style, `TimedWindowObjective` (input inside window, reports latency). Merges pickleball `SlowMotion.Window`, basketball decision-window ring timer, soccer `TimedWindowObjective`. | pb.soft, bb.pnr, sc.press | fb.window, fb.coverage, hy.line | 3 (+3) |
| GK-5 | **Replay scrubbing**: `Replay.Seek(t)`, `Step(dt)`, loop range and speed; `ReplayScrubber` UI (contact tick, 44 pt thumb, step buttons); action `seek_contact_frame`. | bb.charge | any "watch what happened" lesson (hy.offside, sc.offside) | 1 |
| GK-6 | **`ScriptedSequence`**: deterministic keyframed choreography for characters and ball, scenario-driven. `ScreenAction` and `BreakDefender` (basketball) are module-level users of it. | sc.press, sc.corner, sc.overload | bb.pnr, bb.break | 3 (+2) |
| GK-7 | **`Ball.Throw` `Swing`**: curved-flight parameter. | sc.corner | pb.serve spin, football touch passes | 1 |
| GK-8 | **`Character` extensions**: `Feet` (left/right blade or boot spans in world x/z) + `FootContact` events + foot markers (grounded / airborne / moving, shape second channel) + `Zone.ContainsFoot` (line-inclusive); `Reach` (stick reach block radius); `PursuitPath` (chase along a straight line at speed with 0.2 s reaction delay); `LineController` (move a line of characters with easing to a target height). Merges hockey `Character.Feet`, basketball foot markers, hockey `stickReach`/`PursuitPath`, soccer `LineController`. | hy.offside, bb.charge, hy.pp, hy.fore, sc.height | tennis/pickleball line calls | 5 |
| GK-9 | **Line-crossing and arrival objectives**: `LineCrossingObjective` (per-entity first/complete crossing times against a `Zone` edge), `RaceEvaluator` (two Paths' arrival times at a Zone, with margin), `reach_zone_by_event` (zone, players[], deadlineEvent). Merges hockey line objectives/evaluator and pickleball `reach_zone_by_event`. | hy.offside, hy.icing, pb.third | sc.offside (`OffsideLine` builds on it), bb.break, racing pit-lane | 3 (+3) |
| GK-10 | **Geometry evaluators** (pure, deterministic): `LaneEvaluator` (segment-to-point clearance with reach), `InterceptionEvaluator` (time-to-reach a lane for pursuers). | hy.pp, hy.fore, sc.overload | fb.coverage, bb passing lanes, sc.press | 3 (+3) |
| GK-11 | **`FormationSet` + `CoverageModel`**: data-driven named shapes with shift rules; zone maps, man-assignment tables and collapse/box rules as data (basketball `ZoneShell` and `Coverage`, pickleball `Formation`, soccer `FormationRows` are specialisations). | hy.pp, hy.fore, hy.dzone, pb.cover, bb.zone, bb.pnr, sc.shape | fb.coverage, fb formations | 7 |
| GK-12 | **Objective type additions**: `choose_target` (one generic type; folds `choose_correct_target`, `read_and_choose`, `find_gap` and `choose_at_line` through a `trigger` param), `place_and_resolve` (with GK-2), `judge_frame` (with GK-5), `rotate_and_close`, `ShiftFatigueObjective` (fatigue gauge with tired animation). Requesting specs may keep their original key as an alias until migrated. | hk.topo, bb.pnr, bb.zone, bb.break, bb.space, bb.charge, bb.help, hy.line | | 8 |
| GK-13 | **`DistanceRing`** (Highlight variant): line between two entities with a live distance label in feet/metres (help gap, kitchen, offside). Demonstrate type `help_gap_overlay`. | bb.space, bb.help | bb.zone, pb.kitchen, sc.offside | 2 (+3) |
| GK-14 | **`ResponsibilityOverlay`**: zone rectangles and assignment lines drawn on the surface, animated shifts. Demonstrate types `zone_shift_overlay`, `coverage_cue`. | hy.dzone, bb.zone, bb.pnr | fb.coverage, sc marking | 3 |
| GK-15 | **`ConeOverlay`**: cone geometry behind an entity (`CoverShadow`; `wake_cone` for racing). | sc.press, f1.slip | hy.fore | 2 |
| GK-16 | **`TraceChart`** (demonstrate types `speed_trace`, `value_ribbon`, `elevation_profile`, i.e. `ProfileChart`): value-vs-distance/time line with labels and highlights. | f1.line, f1.aero, f1.energy, hk.topo | cycling, running | 4 |
| GK-17 | **`TimelineStrip`**: safe/risk bands on a time axis, shown after the fact. | hy.line | racing pit windows, football timing | 1 |
| GK-18 | **`RankStrip`** (`order_strip`, `gap_chart`): running order and gaps over time. | f1.pit, f1.sc | n.caution | 2 (+1) |
| GK-19 | **`CameraRig` presets**: `line-cam` (parametric low camera along a line: axis, height, FOV; merges hockey `blueline-cam` and soccer `LineCam`), `broadcast-high-behind`, `side-on-tilted`, `bench-cam`, `oblique-low`. | hy.offside, hy.icing, hy.line, sc.offside, sc.height, hk.topo | any line-call or long-field sim | 6 |
| GK-20 | **Terrain module** (section 2): `Heightfield`, `TerrainMesh`, `ContourOverlay`, `SlopeShader`, `Viewshed`. | hk.topo | camping, climbing, golf, skiing | 1 |

### 5.2 Racing and sport-module requests

Not generic; see section 2 for the shared vs series-specific split (Racing) and module contents (Football, Hockey, Soccer, Basketball, Pickleball, Terrain). Racing shared: `Wake`/`DirtyAir`, `AirflowOverlay`, `LaneMomentum`, `HandlingBalance`, `SlipArrows`, `RubberMap`, `RaceSim` (rule packs). Series-specific: NASCAR environments and sim-local `RestartFormation`/`ProjectionModel`; F1 `ActiveAero`, `EnergyStore`, `Overtake`, `wing_schematic`, four `f1_*` environments.

### 5.3 Registry keys to add (GAME_KIT section 3)

- **Environments:** `oval_short`, `oval_short_banked`, `oval_flat`, `oval_intermediate`, `oval_superspeedway`, `road_course_short`, `f1_corner_track`, `f1_straight_and_braking`, `f1_lap_oval_abstract`, `f1_race_topdown`, `pickleball_court`, `basketball_half_court`, `basketball_full_court`, `soccer_pitch`, `hockey_rink` (proposed name), `terrain_heightfield`.
- **Objective types:** `shape_path`, `choose_target` (aliases `choose_correct_target`, `read_and_choose`, `find_gap`, `choose_at_line`), `place_and_resolve`, `judge_frame`, `rotate_and_close`, `reach_zone_by_event`, `line_crossing`, `shift_fatigue`.
- **Demonstrate types:** `speed_trace`, `value_ribbon`, `gap_chart`, `order_strip`, `help_gap_overlay`, `coverage_cue`, `zone_shift_overlay`, `foot_contact_overlay`, `terrain_lift`, `water_flow`, `viewshed`, `elevation_profile`; overlay styles `wing_schematic`, `wake_cone`.
- **Actions:** `seek_contact_frame`.
- **TouchController schemes:** `drag-handles`, `slot-placement`.

### 5.4 Priority for Astra (what unblocks the most sims)

Ordering rule: (1) anything on the path of every sim, (2) shared bundles that unlock a whole course cluster, (3) generics used by 3+ sims, (4) single-sim items last. The build sequence itself is in `docs/astra/ROADMAP.md`.

1. **P0, all 41 sims:** the section 1 core primitives, support services, `BridgeClient`, seeded `Rng`/`ScenarioSet`, and a golden-fixture test harness (pure-function oracles plus fixtures is used by almost every spec).
2. **P1a, 12 sims:** finish the shared Racing module (5.2; mostly small additions). NASCAR needs almost nothing new; F1 needs `RaceSim`, `ActiveAero`, `EnergyStore`, `Overtake`.
3. **P1b, 23 sims (hockey, soccer, basketball, pickleball):** court/rink/pitch environment builders plus the team-sport spatial bundle: GK-11 (7 sims), GK-19 (6), GK-9 (6 incl. reuse), GK-3 (6 incl. reuse), GK-6 (5), GK-4 (6 incl. reuse), GK-10 (6 incl. reuse).
4. **P2 (2-5 sims each):** GK-8, GK-12, GK-13, GK-14, GK-15, GK-16, GK-18, GK-1 (blocks `football.routes.build.v1` and `f1.racecraft.racing-line.v1`; football unit U2 depends on it).
5. **P3 (single sim, each blocks one sim only):** GK-2, GK-5, GK-7, GK-17, GK-20.

Football and the rest of the kit are independent: `football.coverage.read.v1` needs no new primitive and is the recommended first vertical slice.
