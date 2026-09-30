# Unity Bridge Contract v1

The only interface between the native Swoon'd app (Claude Code) and Unity simulations (Astra). Neither side may unilaterally change it (spec sections 31 and 50; D-010).

- Schemas: `launch-request.schema.json`, `simulation-result.schema.json`, `bridge-event.schema.json` (message envelope).
- Examples (validated in CI): `examples/`.
- Current contract version: **1.0.0**.

## 1. Transport

Native and Unity exchange **UTF-8 JSON strings**, one message per call, in both directions.

- **Native -> Unity:** a single entry point in the Unity library, `SwoondBridge.Receive(string json)` (C# static, exposed to iOS via `UnitySendMessage`-style bridging or `NativeCallProxy`; Android via `UnityPlayer.UnitySendMessage`). Native never calls any other Unity method.
- **Unity -> native:** Unity invokes one registered callback, `SwoondBridge.Send(string json)`, delivered on native side to `BridgeTransport.onMessage(Data)`.
- Every message uses the envelope in `bridge-event.schema.json`: `contractVersion`, `direction`, `sessionId`, `seq`, `timestampMs`, `type`, `payload`.
- `seq` is monotonic per sender per session starting at 0. A receiver ignores duplicates and treats a gap as a non-fatal warning (log to telemetry).
- Messages are small (< 256 KB). Large data (assets, scenario sets) is delivered via content packs / Addressables, never in messages.
- Unknown JSON properties MUST be ignored by both sides (forward compatibility). Unknown `type` values MUST be logged and ignored.

## 2. Lifecycle

```
native                                   Unity
  | -- load UnityFramework (lazy) ----->  |
  | -- launch(LaunchRequest) ----------->  |  validates contractVersion, simulationId, configuration
  |                                        |  loads scene / assets
  | <------------------------- ready ----  |  (or error: CONTRACT_UNSUPPORTED / SIMULATION_UNKNOWN / CONFIG_INVALID ...)
  | <---------------------- progress* ---  |  optional, throttled (max 4 per second)
  | <-------------------- checkpoint* ---  |  after each round / explain moment
  | -- pause -------------------------->   |  Unity freezes sim time, audio, timers
  | -- resume ------------------------->   |
  | -- abort(reason) ------------------>   |  Unity stops and emits a result (aborted=true)
  | <------------------------- result ---  |  exactly once
  | <------------------- requestExit ---   |  after result; native dismisses Unity
  | -- unload / pause Unity -------------  |
```

1. **Launch.** Native sends `launch` with a `LaunchRequest` payload. It must not send anything else before `ready`, except `abort`.
2. **Ready.** Unity replies `ready` (with `supportedContractVersions`, versions, load time). Native waits at most `readyTimeoutMs` (default **8000**). On timeout: native sends `abort`, unloads Unity, shows a friendly error and offers retry or a native fallback if the lesson defines one. No hearts are lost.
3. **Play.** Unity may emit `progress` and `checkpoint` events. Native treats them as informational (UI progress, resume support) and never blocks Unity on them.
4. **Pause / resume.** Native sends `pause` (reason `app-backgrounded`, `interruption`, `native-overlay`, `user`) and `resume`. While paused Unity must stop simulation time, timers and audio and must not advance objectives. Active `durationMs` excludes paused time.
5. **Abort.** Native sends `abort` for user quit (the X button), timeout, being backgrounded longer than **120 s** (`backgrounded-too-long`), memory pressure or native error. Unity emits a `result` with `aborted=true`, `completed=false`, the matching `abortReason`, and partial `outcomes`; xpEarned should be 0 unless the sim spec defines partial credit.
6. **Result.** Unity emits exactly one `result` event containing a `SimulationResult`. After sending it, Unity emits `requestExit` (reason `completed`, `user-quit`, `needs-native-ui`, or `fatal`). Native applies the result, dismisses the Unity view, and unloads or pauses Unity.
7. **Exit request during play.** If the learner taps a Unity-drawn exit affordance, Unity emits `requestExit` (`user-quit`) and native replies with `abort` (or directly shows the native "Leave game?" confirmation if the sim spec defers it to native).

### Who owns what

| Concern | Owner |
|---|---|
| Sim behavior, scoring inside the sim, explanations, freeze/replay | Unity (Astra) |
| Applying XP, hearts, streak, mastery; clamping | Native |
| Theme tokens, accessibility flags | Native provides, Unity honors |
| Full-screen presentation, safe areas, app-level dialogs, paywall | Native |

Unity must not present its own paywall, permission prompts, or network calls (v1 sims are offline).

## 3. Timeout and crash handling

| Situation | Detection | Native behavior |
|---|---|---|
| No `ready` in 8 s | Timer in `BridgeSession` | `abort`, unload, error UI, retry |
| Session exceeds `runtime.maxDurationMs` | Timer | `abort(timeout)`; if no `result` within 3 s, synthesize an aborted result locally |
| No `result` within 5 s after `abort` | Timer | Synthesize aborted result (0 XP), unload Unity |
| `error` event, `recoverable=true` | Event | Offer "Try again" (relaunch identical request, new `sessionId`) |
| `error` event, `recoverable=false` | Event | Show error, skip the activity, report to telemetry; do not penalize hearts |
| Unity process / view crash or OOM (framework unload, app relaunch) | Host-detected | On next launch, mark the interrupted session as aborted; if a `checkpoint` exists offer resume via `runtime.resumeState`; never charge hearts |
| App killed while Unity running | Host-detected on next launch | Same as crash |
| Malformed JSON or schema-invalid message | Decode failure | Log, ignore; if it was a `result`, treat as `error INTERNAL_ERROR` |

Native is authoritative: it validates the result against the schema, clamps `score`, `xpEarned` and `heartsLost`, ignores unknown `conceptId`s (with telemetry), and applies masterySignals via the mastery model (ARCHITECTURE.md section 6.1).

## 4. Versioning and compatibility

- `contractVersion` is semver `MAJOR.MINOR.PATCH`. v1 folder covers all `1.x.y`.
- **Minor** (additive, optional fields, new enum values that receivers can safely ignore, new event types): allowed inside `v1/`. Requires a DECISIONS entry and a bump in every example's `contractVersion` only if the example uses the new feature.
- **Major** (remove/rename/tighten a field, change meaning of a field or the lifecycle): new `v2/` folder; native keeps a `v1` adapter until Astra's deployed sims no longer use it.
- Native sends its highest supported `contractVersion` in the `launch` envelope. Unity's `ready` lists `supportedContractVersions`. If Unity does not support the native version's major, it emits `error CONTRACT_UNSUPPORTED` and native retries with an older supported minor if it has one.
- **Simulation versions.** `simulationId` ends in `.vN`; `simulationVersion` is `N.minor.patch` and MUST start with the same N as the id. Native asks for an exact version; Unity may satisfy any compatible `N.x.y` and reports the one it runs in `ready` and `result`. Mismatch of the major yields `SIMULATION_VERSION_UNSUPPORTED`.
- **Configuration** is sim-specific and versioned with the sim, not with the bridge; each sim spec contains its own JSON Schema fragment (SIM_SPEC_TEMPLATE section 10). Native content authors validate `configuration` against that fragment in CI (`tools/validate` extension planned; see Open questions).
- **Conformance.** Both sides test against `examples/`: native decodes them into Codable types and replays event sequences; Unity deserializes launch requests and produces schema-valid results (EditMode tests). Any change to a schema or example must pass `node tools/validate/validate.mjs` and both suites.

## 5. Asset delivery (Addressables / asset bundles)

- Sim code and core assets ship inside the Unity library build. Large or optional assets (per-sim environments, character models, audio) ship as **Addressables asset bundles** identified by `simulationId` + `simulationVersion`.
- v1 rule: bundles are delivered by the **native app** (bundled in the app, or downloaded to Caches with checksum and cached, using the content-pack mechanism) and made available to Unity at launch through a local path convention: `<Caches>/SwoondSims/<simulationId>/<simulationVersion>/` announced in `configuration.assetRoot` (optional; absent means everything is in the build). Unity never performs network requests.
- If required bundles are missing Unity emits `error ASSET_LOAD_FAILED` (recoverable=true); native re-downloads and relaunches.
- Per-sim asset budgets are in the sim spec and `docs/astra/README.md`.

## 6. Privacy

- `personName` and `relationship` are display-only (for greetings/overlays). Unity must not persist, log, or include them in `telemetry`.
- `telemetry` is diagnostics only (fps, load time, memory). No free text, no device identifiers.

## 7. Open questions

- Should `configuration` be validated in CI by resolving each sim spec's schema fragment from `unitySimulations[].specPath`? (Proposed: yes, once the first sim spec exists.)
- Checkpoint persistence across app termination (DECISIONS Q-4).
- Whether Unity may request a native haptic (`haptic` event) instead of calling iOS haptics directly. v1: Unity handles haptics itself when `hapticsEnabled` is true; revisit for Android parity.
