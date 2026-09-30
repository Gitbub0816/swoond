# Swoon'd Native App Architecture (iOS)

Status: foundation, 2026-09-30. Owner: Claude Code. Android will mirror this with Kotlin/Compose and the same contracts (D-001).

Toolchain: Xcode 27, Swift 6.4 (Swift 6 language mode), iOS SDK 27, deployment target iOS 18.0, Unity 6.3 LTS (see `docs/product/DECISIONS.md` D-005).

## 1. Principles

1. **Person first.** The primary object is the Person, not the course (spec section 2).
2. **Native app, Unity as a guest.** The app is fully native and fast without Unity; Unity loads only for Tier A activities and returns results (spec section 21).
3. **Pure core.** Everything that is not UI or Apple-framework glue lives in `SwoondCore`, which builds and tests on Linux.
4. **Contracts before code.** Every cross-agent boundary (bridge, manifest, curriculum, exercise payloads) is a versioned JSON Schema in `docs/contracts/`.
5. **Providers never leak.** External providers sit behind adapters and are normalized to Swoon'd types (spec section 32).
6. **Never re-implement Unity simulation logic natively.** Native validates and applies a `SimulationResult`; it does not recompute the sim.

## 2. Modules

```
swoond/
  ios/                          (created when app work starts)
    SwoondCore/                 Swift package, Foundation-only, Linux-safe
      Sources/SwoondCore/
        Domain/                 Person, Interest, Course, Unit, Lesson, Activity, Concept, ...
        Progress/               ProgressEngine: XP, hearts, streak, mastery, review scheduler
        Content/                ContentLoader (JSON -> domain), ContentValidator, PersonalizationResolver
        Exercises/              pure logic per native exercise type (scoring, session state machines)
        Bridge/                 Codable types for LaunchRequest, SimulationResult, BridgeMessage; BridgeSession state machine
        Repositories/           protocols + in-memory/mock implementations
        Providers/              adapter protocols + normalized data types (LiveData, Editorial)
      Tests/SwoondCoreTests/    swift test (uses shared JSON vectors from docs/contracts examples)
    SwoondApp/                  Xcode project / app target (SwiftUI); Mac-verified
      DesignSystem/             tokens, fonts, components (Chip, PrimaryButton, FeedbackPanel...)
      Features/                 Onboarding, Home(Learn), Games, Talk, Live, Me, Playbook, Paywall, Settings
      Exercises/                SwiftUI renderers for each native exercise type (+ optional Metal views)
      UnityHost/                UnityFramework as-a-library integration, BridgeTransport implementation
      Persistence/              On-device store implementations of repository protocols
```

`SwoondCore` may depend only on Foundation (and `swift-collections`-style packages only with written justification). No `SwiftUI`, `UIKit`, `Combine`, `CoreData`, `os.log` (use a `Logger` protocol), no `Observation` macros in Core (Core types are plain `Sendable` structs, actors and protocols; `SwoondApp` wraps them in `@Observable` view models).

### 2.1 What lives where

| Concern | SwoondCore | SwoondApp |
|---|---|---|
| Domain models (`Person`, `Course`...) | Yes | No |
| XP / hearts / streak / mastery / review engine | Yes | Calls it |
| Content JSON decoding + validation | Yes | Bundles files |
| Native exercise scoring & session state machine | Yes | Renders it |
| Bridge Codable types + `BridgeSession` state machine + timeout logic | Yes | Provides `BridgeTransport` (UnityFramework glue) |
| Repository protocols + in-memory mocks | Yes | On-device implementations (file/SwiftData/SQLite) |
| Provider adapter protocols + normalized types | Yes | Concrete network adapters may live in Core if Foundation-only (`URLSession` is available in swift-corelibs-foundation via FoundationNetworking); otherwise App |
| Views, navigation, design tokens, fonts, haptics, notifications | No | Yes |
| Metal / C++ interop visuals | No | Yes |

## 3. Data flow

```
 JSON content pack ──► ContentLoader ──► Course graph (domain)
                                         │
 Person + selections ──► PersonalizationResolver ──► personalized lesson view
                                         │
 Learner input ──► ExerciseSession (Core) ──► ExerciseOutcome { correct, conceptIds, hearts, xp }
                                         │                     ▲
 Unity ── BridgeMessage(result) ─► BridgeSession ─► SimulationResult ─► ResultMapper ┘ (clamps XP)
                                         ▼
                              ProgressEngine.apply(outcome) ─► ProgressRepository.save
                                         ▼
                              @Observable view models ─► SwiftUI
```

- **ExerciseOutcome** is the single currency the progress engine understands. Native exercises and Unity results both map to it.
- View models are thin: they hold an `actor`-isolated Core object and expose `@Observable` state.
- Concurrency: Swift 6 strict concurrency. Domain types are `Sendable` value types; stateful engines are actors (`ProgressEngine`, `BridgeSession`); UI state is `@MainActor`.

## 4. Repository and provider adapter pattern (spec section 32)

```
External Provider ─► Provider Adapter ─► Normalized Data ─► Course Interpretation ─► UX
```

Repository protocols (Core):

```swift
public protocol ContentRepository: Sendable {
    func courseIndex() async throws -> [CourseSummary]
    func manifest(courseId: CourseID) async throws -> CourseManifest
    func curriculum(courseId: CourseID, locale: Locale) async throws -> Curriculum
}
public protocol PersonRepository: Sendable {
    func people() async throws -> [Person]
    func save(_ person: Person) async throws
    func delete(personId: PersonID) async throws
}
public protocol ProgressRepository: Sendable {
    func progress(personId: PersonID, courseId: CourseID) async throws -> CourseProgress
    func save(_ p: CourseProgress) async throws
    func learnerState() async throws -> LearnerState      // xp, hearts, streak, premium
    func save(_ s: LearnerState) async throws
}
public protocol LiveDataRepository: Sendable {          // normalized, provider-agnostic
    func liveContext(courseId: CourseID, personalization: Personalization) async throws -> LiveContext
}
public protocol EditorialRepository: Sendable {
    func topics(courseId: CourseID, personalization: Personalization) async throws -> [EditorialTopic]
}
```

Adapters implement provider-specific protocols (`SportsDataProvider`, `MotorsportsDataProvider`, `NewsProvider`, `OutdoorConditionsProvider`), each returning normalized types (`Fixture`, `Standing`, `RaceResult`, `EditorialTopic`...). Provider DTOs (`TheSportsDBEventDTO`) are `internal` to the adapter file and never exported.

Implementations by phase:

| Phase | Content | Persistence | Live data |
|---|---|---|---|
| 1 (now) | Bundled JSON content pack | In-memory + on-device file store | Fixture JSON |
| 2 | Bundled + downloaded packs | On-device + cloud sync (Neon or Firebase, D-004) | TheSportsDB / motorsports adapters |
| 3 | Backend-served | Cloud primary, on-device cache | Enterprise providers if needed |

Domain identifiers are Swoon'd's own (`PersonID`, `CourseID` = the kebab-case `courseId`). Backend row IDs or Firestore paths never appear in domain types.

## 5. Person-centered model

```
Person (id, displayName, relationship, createdAt, isActive)
 └─ InterestSelection[]            (personId, courseId)
     ├─ branchId?                  (e.g. nfl)
     └─ Personalization            { dimension: value } e.g. team = "Philadelphia Eagles"
```

- Progress is keyed by **(personId, courseId)**: the same learner learning football for Sarah and for Jordan has separate progress and personalization, but concept mastery may be shared across persons for the same course (decision: mastery is per **learner and course**, not per person; per-person progress tracks *units completed and Common Ground %*). This avoids relearning "downs" twice.
- **Common Ground %** = weighted average over the Person's interests of `course progress %` (weights default equal; a Person can mark a "main interest" with weight 2).
- **Discreet mode** (default ON): notifications never contain the Person's name. Enforced in a single `NotificationComposer` in SwoondApp with a Core-tested copy policy.
- Personalization resolves `{{team}}`-style tokens in authored text and selects live-context sources; missing values fall back to generic copy.

## 6. Learning journey model

```
Course
 └─ Unit (layer: foundations | intermediate | enthusiast | current-season | conversation | review)
     └─ Lesson (objective, conceptIds)
         └─ Activity (type: native exercise | unity-sim, conceptIds, payload)
```

- **Layers** are unlock groups, not a rigid order: foundations gate intermediate (via `prerequisiteUnitIds`); enthusiast depth unlocks after intermediate; **current-season** units are generated from normalized live data and refresh; **conversation** units and Talk tab tracks run in parallel; **review** is perpetual.
- **A play session** = a lesson's activities; the UI groups exercises into rounds of three (~3 minutes) per design spec section 8.

### 6.1 Mastery per concept

- `mastery[conceptId] in [0,1]`, initial 0. Stored per learner + course.
- Native exercise outcome: for each `conceptIds` entry: correct = +0.20, wrong = -0.15 (first attempt); hint used halves gains. Multi-item exercises average their items first.
- Unity `masterySignals[]`: apply `delta` directly (range -1..1), then clamp to [0,1]; native caps any single session's per-concept gain at +0.40.
- **Mastered** when `mastery >= manifest.masteryModel.passThreshold` (default 0.80); status labels in Playbook: New (0 attempts), Learning, Mastered.
- Decay: if `daysSinceLastSeen > reviewPolicy.decayAfterDays`, mastery decays 0.01 per day (floor at 0.5 x last peak) until reviewed.

### 6.2 Spaced review (Leitner, `leitner-boxes-v1`)

- Each concept has `box` in 0..(intervals.count-1) and `dueAt`.
- First correct answer on a concept places it in box 0 with `dueAt = now + intervalsDays[0]`.
- Correct review: `box += 1`, `dueAt = now + intervalsDays[box]`. Wrong review: `box = max(0, box - 2)`, `dueAt = now + intervalsDays[box]`.
- A review session picks up to `maxItemsPerSession` due concepts, choosing for each an activity of an allowed `reviewActivityTypes` whose `reviewEligible` is true, preferring one not seen last time.
- Review earns XP like normal correct answers; a completed review session counts as a finished game (+40).

### 6.3 Live / current layer

Current-season units carry a `live` block (`adapterKey`, `dataKind`). The app requests normalized data through `LiveDataRepository`, then a **Course Interpretation** step (per-course, authored in the curriculum as templates + concept links) turns it into Daily Bites, "What just happened" feed items and Talk prompts. Editorial context is explained in Swoon'd's own words and links to publishers (spec section 11).

## 7. XP, hearts, streak rules (from `docs/design/DESIGN_SPEC.md` section 8 and design README)

| Rule | Value |
|---|---|
| XP per correct answer | +10 |
| XP per finished game/session | +40 |
| XP per Daily Bite | +10 |
| XP per challenge win | +80 |
| Wrong answer | -1 heart |
| Hearts max | 5 (Swoon'd+ = unlimited) |
| Hearts at 0 | Sheet: "Wait 4h" / "Practice to earn one" / "Go unlimited" (paywall) |
| Heart regen | +1 heart per 4 hours while below max (assumption; see Open Questions) |
| Streak | Increments on first XP earned each local calendar day; resets to 0 if a local day passes with no XP |
| Daily reminder | 8 PM local by default; discreet copy: "Your daily game is ready" |
| Common Ground % | Weighted average of the Person's per-interest progress |

Unity results: `xpEarned` and `heartsLost` are proposals. `ResultMapper` clamps `xpEarned` to `activity.xp ?? lessonXpBudget` and `heartsLost` to `runtime.heartsRemaining` at launch (unless unlimited).

Timing-tap scoring (design): hit = 100; miss = `max(0, 60 - offPct*3)` where `offPct` is the distance in percentage points to the nearest zone edge. A round with a hit counts as correct for XP/hearts; a miss costs a heart only if score < 40.

## 8. Unity host integration (SwoondApp / UnityHost)

- Unity is built by Astra as **Unity as a Library (UaaL)** producing `UnityFramework.framework` (+ Data). SwoondApp embeds it and loads lazily on first sim launch; the framework is never loaded for native-only sessions.
- `UnityHost` implements `BridgeTransport` (Core protocol): `send(_ json: Data)` calls Unity's single entry method; a Unity-side native callback delivers events as JSON `Data`.
- `BridgeSession` (Core, actor) owns the state machine: `idle -> launching -> ready -> running <-> paused -> finished | failed | aborted`, enforces `seq` ordering, the `ready` timeout (default 8 s), the session `maxDurationMs`, and maps `error` events to recovery actions. See the lifecycle in `docs/contracts/unity-bridge/v1/README.md`.
- Presentation: full-screen cover over the NavigationStack; Unity view is hosted in a `UIViewControllerRepresentable`. On `requestExit` the cover dismisses and the result is applied.
- Memory: Unity is unloaded (or paused) after result to return to native baseline memory. Cold launch budget is owned by Astra (`docs/astra/README.md`).

## 9. Persistence (phase 1)

- On-device: JSON files in Application Support (atomic writes), one per store (`people.json`, `learner.json`, `progress-<personId>-<courseId>.json`, `mastery-<courseId>.json`). All versioned with `schemaVersion` and migrated by Core.
- Keychain only for future auth tokens. No PII beyond Person display name and relationship; those are never sent to Unity telemetry or analytics.
- Content packs: `Resources/ContentPacks/<courseId>/{manifest.json, curriculum/*.json, assets/}` bundled; later downloaded to Caches with checksum.

## 10. Navigation (SwiftUI)

`NavigationStack` per tab with typed `NavigationPath` routes; tabs Learn, Games, Talk, Live, Me (design spec section 5). Modal flows (onboarding, game session, results, paywall, hearts sheet) are `.fullScreenCover` / `.sheet`. State containers are `@Observable` classes injected via `.environment`.

## 11. Testing strategy

| Layer | How | Where |
|---|---|---|
| Core logic | `swift test` (Swift Testing), runs on Linux CI | `SwoondCoreTests` |
| Contract conformance | Decode every `docs/contracts/**/examples/*.json` into Core types | `SwoondCoreTests` |
| Content | `node tools/validate/validate.mjs` in CI | `tools/validate` |
| UI | Xcode previews + XCUITest smoke on Mac | `SwoondAppTests` |
| Bridge | Fake `BridgeTransport` that replays example event streams | `SwoondCoreTests` |

## 12. Open questions

- Heart regeneration timing (4h per heart) is inferred from the design copy "Wait 4h"; confirm.
- Streak freeze / repair is not in the design; not implemented until specified.
- Cross-person mastery sharing (section 5) is an architectural decision proposed here; ratify in DECISIONS.
