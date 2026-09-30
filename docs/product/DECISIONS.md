# Swoon'd Decision Log

Clarifications and decisions layered on top of `SWOOND_PRODUCT_SPEC.md` (which is not edited without product-owner approval). Newest first within a date. Every change to a shared contract needs an entry here.

Format: `D-NNN - title`, status (Accepted / Superseded), context, decision, consequences.

---

## 2026-09-30 - Product-owner decisions (initial set)

### D-001 - iOS first; Swift 6 / SwiftUI; platform-neutral contracts
- **Status:** Accepted (product owner, 2026-09-30)
- **Decision:** The first native app is iOS: Swift 6 and SwiftUI. Android (Kotlin / Jetpack Compose) follows later. All contracts (Unity bridge, course manifest, curriculum, native-exercise payloads, sim definition) are platform-neutral JSON with JSON Schema and must not contain iOS-specific or Android-specific concepts.
- **Environment constraint:** The cloud dev container has no Xcode. All platform-independent logic lives in a Swift package, **SwoondCore**, which must compile and pass `swift test` on Linux (Foundation-only, no Apple-only frameworks). SwiftUI / UnityFramework code (**SwoondApp**) is verified on a Mac.
- **Consequences:** Domain logic (progression, XP, hearts, streak, mastery, review scheduling, content loading, exercise scoring, bridge Codable types) is testable without a simulator. When Android starts, the same specs and JSON drive a Kotlin port of the same logic; the JSON test vectors in the docs are the shared conformance suite.

### D-002 - The three design-file games are representative only
- **Status:** Accepted
- **Decision:** Pit Stop (timing), Pickleball kitchen (binary call) and Hockey Talk Track (chat) in `docs/design/Swoond.dc.html` communicate visual language and interaction feel. They are NOT the final game list. Real games are chosen per course through the CDS (spec section 8) and the tier rubric below.

### D-003 - Two game tiers
- **Status:** Accepted
- **Decision:**
  - **Tier A - Unity:** genuinely interactive, spatial, physics, movement or camera-driven experiences. Built in Unity by Astra (OpenAI ChatGPT Work) from spec documents we write (`docs/astra/SIM_SPEC_TEMPLATE.md`).
  - **Tier B - Native:** mini-quiz style exercises that do not need Unity's richness. Built natively in Swift/SwiftUI, optionally with Swift + C++ interop + Metal for rich visuals or animation.
- **Consequences:** Native exercise catalog in `docs/native-exercises/CATALOG.md`; Unity sims specified per course in `docs/courses/<course-id>/sims/`. The rubric is in `CLAUDE.md` and each CDS "Interaction plan" must justify every Unity choice. Design note: the design file's timing-tap and binary-call games are Tier B (1D bar, 2-way choice). Unity is not used for them.

### D-004 - Backend: local mock now, Neon or Firebase later
- **Status:** Accepted
- **Decision:** Start with a local mock backend: bundled JSON content packs plus in-memory / on-device persistence, behind repository and adapter protocols defined in SwoondCore. Likely production backend is Neon (Postgres) or Firebase; the choice is deferred. No provider schema (Neon rows, Firestore documents, TheSportsDB payloads) may leak into the domain model.
- **Consequences:** `ContentRepository`, `ProgressRepository`, `PersonRepository`, `LiveDataRepository` protocols; provider adapters normalize into Swoon'd types (spec section 32). See `docs/architecture/ARCHITECTURE.md`.

### D-005 - Latest stable toolchains (verified 2026-09-30)
- **Status:** Accepted
- **Decision / versions chosen** (via web search on 2026-09-30):

| Tool | Version | Notes |
|---|---|---|
| Xcode | 27 (released 2026-09-14) | Ships Swift 6.4 and the iOS 27 SDK |
| Swift | 6.4 (released 2026-09-15) | Language mode Swift 6 (strict concurrency complete) |
| iOS SDK | 27.0 | Build SDK |
| iOS deployment target | 18.0 | Product-owner may raise; see D-005a below |
| Unity | 6.3 LTS, currently 6000.3.24f1 | Latest LTS. 6000.6.x is Mainline (non-LTS); do not adopt until it becomes LTS |
| Universal Render Pipeline | Version shipped with Unity 6.3 LTS | |
| Node (validator tooling) | 22 LTS (22.22.2 in dev container) | |
| ajv / ajv-formats | 8.20.0 / 3.0.1 | Draft 2020-12 via `ajv/dist/2020` |

- **D-005a:** The deployment target is a separate decision from the toolchain. iOS 18.0 is chosen as a pragmatic floor (Observation, Swift Testing, NavigationStack all available). Unity 6.3 LTS supports it. Revisit before App Store submission.
- **Consequences:** Re-verify versions at each release milestone and record changes here. Unity LTS upgrades are Astra-driven and require a bridge compatibility check.

### D-006 - AI agent model policy
- **Status:** Accepted
- **Decision:** Use Haiku for docs and specs where appropriate; Sonnet where necessary (and for all code); Opus only when absolutely necessary. The orchestrator session only delegates to subagents; it does not write content or code itself.

### D-007 - Curriculum is an ongoing, deep course per interest
- **Status:** Accepted
- **Decision:** A course is NOT a short 10-screen deck. Each course has many units and dozens of lessons across layers: foundations, intermediate, enthusiast depth, current-season / live, conversation practice, and perpetual spaced review. Content keeps shipping after launch (live layer, new seasons, new terms).
- **Consequences:** Curriculum schema supports layers, per-unit live data hooks, a review policy and a concept graph. CDS template requires a Curriculum map. The design-spec minimum ("3+ units per interest") is a floor for the design prototype, not the product goal.

## 2026-09-30 - Documentation-foundation clarifications

### D-008 - `simulationId` prefix is the course's `simulationPrefix`, not the courseId
- **Decision:** Sim IDs are `<simulationPrefix>.<topic>.<name>.v<N>`, e.g. `football.coverage.read.v1` (from spec section 31) belongs to course `american-football`, whose manifest declares `"simulationPrefix": "football"`. The `.vN` suffix is the sim's contract major version: an incompatible change to a sim's configuration or result meaning creates `...v2`, not an edit of `v1`.

### D-009 - Bridge result field is `xpEarned`
- **Decision:** Spec section 31's conceptual `xp` is `xpEarned` in the schema. Unity proposes; the native app is authoritative and clamps to the lesson's XP budget. Likewise `heartsLost` is reported by Unity but applied by native.

### D-010 - Bridge contract versioning
- **Decision:** `contractVersion` is semver. Additive, optional fields = minor. Any removal, rename, tightening, or meaning change = major, which lives in a new folder (`docs/contracts/unity-bridge/v2/`), and native supports both majors during a deprecation window. Neither Claude nor Astra changes files under `v1/` except for compatible minor additions, and every such change needs a DECISIONS entry plus a version bump in the schema `$id`-adjacent examples. Details: `docs/contracts/unity-bridge/v1/README.md`.

### D-011 - Native exercise payloads are contracts too
- **Decision:** `docs/contracts/native-exercises/v1/<type>.schema.json` is the source of truth for authored exercise content. Content is validated in CI (`tools/validate`); the SwiftUI engines decode these exact shapes.

### D-012 - Talk tab scenarios live in the curriculum JSON
- **Decision:** Standalone conversation practice is `talkTracks[]` in the curriculum file (payload = `talk-track` exercise schema). Manifest `conversationScenarios.count/path` points at it.

## 2026-09-30 - Curriculum contract 1.1

### D-013 - Curriculum split into per-unit files (contract 1.1, additive)
- **Status:** Accepted
- **Decision:** Curriculum contract 1.1 adds an optional split layout so deep courses (D-007) can be authored one unit per file. `docs/courses/<id>/curriculum/course.json` holds courseId, curriculumVersion, contractVersion `1.1.0`, `concepts[]`, `talkTracks[]`, `reviewPolicy` and `unitOrder[]`; each `curriculum/units/<NN>-<unit-id>.json` holds `{contractVersion, courseId, unit, concepts?}`. The single-file v1.0 layout stays valid. `unitOrder` must match exactly the set of unit files; unit-local `concepts[]` merge into the course concept list and a duplicate concept id across files is an error.
- **Consequences:** The validator detects the layout per course, merges, and runs the same schema, reference checks and content lint on the merged curriculum, reporting problems against the originating file. `BundledContentRepository` loads both layouts. New schemas `curriculum-root.schema.json` and `curriculum-unit.schema.json` sit beside the v1 schema (no new `v2/` folder: nothing was removed or tightened). Content must be authored, not generated: any `*.sh` / `*.py` / `*.js` under `docs/courses/*/curriculum/` is a lint error.

## Open questions (product owner)

| # | Question | Needed by |
|---|---|---|
| Q-1 | iOS minimum deployment target: keep 18.0 or raise to the current major minus one? | Before first TestFlight |
| Q-2 | Production backend choice (Neon vs Firebase) and auth provider | Before any cloud sync feature |
| Q-3 | News/editorial provider for the current-context layer (licensing cost) | Before Wave 1 live layer |
| Q-4 | Whether bridge sessions may be resumed after app termination (checkpoint persistence) in v1 or v1.1 | Before first Unity sim ships |
