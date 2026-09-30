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

### Racing (`Swoond.Sports.Racing`)
`Vehicle` (racing tuning), `Track` (procedural oval/road course as `Path` + banking), `RacingLine`, `Draft` (drag reduction by distance/alignment), `TireState` (wear/grip), `FuelState`, `PitStop` (timing window, service phases), `Position` (running order), `Timing` (lap/gap/interval).

### Court & field sports (future, name reserved)
`Court` (pickleball, tennis, basketball) with `Kitchen`-style zone rules, `BounceRule` (two-bounce), `Serve`. Add modules under `Swoond.Sports.<Sport>` following the same pattern. New module needs a spec section in the first sim that uses it.

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
