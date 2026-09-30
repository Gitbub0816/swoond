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

## 2026-09-30 - Wave 1 consolidation (contract minors)

### D-014 - Course manifest contract 1.1 (additive): more `dynamicData.kind` values
- **Status:** Accepted
- **Context:** Wave 1 course agents mapped injury reports to `alerts`/`rosters`, trades/signings/transfers to `rosters`, and FIA/rulebook/steward documents to `events` (football, basketball, soccer, F1 manifests).
- **Decision:** `dynamicData[].kind` gains `injuries`, `transactions` and `regulations`. Existing values unchanged; 1.0 manifests stay valid (`contractVersion` pattern already `1.x.y`). Example bumped to 1.1.0. Wave 1 manifests may be re-mapped to the new kinds when their curricula are authored (not required).
- **Consequences:** `SwoondCore` decodes `kind` as a string, so no Core change; adapters may key on the new kinds.

### D-015 - Curriculum contract 1.2 (additive): branches, per-lesson live hooks, branch facts
- **Status:** Accepted
- **Context:** Wave 1 needed branch-only units without misusing `enthusiast` (football College, basketball WNBA/college, soccer six league units, F1 team paths, hockey PWHL); branch-specific rules inside shared lessons (NBA vs college shot clock); per-lesson live hooks (basketball `live.standings.playin`); and a home for branch-specific data (F1 team facts).
- **Decision:** (1) layer enum gains `branch` (a `branch` unit must set unit-level `branchId`). (2) Activities gain optional `branchId`: shown only for that branch, never contradicting the unit's `branchId`, and must be a manifest branch. (3) Lessons gain optional `live` (same shape as unit `live`, allowed on any layer). (4) Curriculum root (single file and split `course.json`) gains optional `branches[]`: `{id, displayName?, facts, lastVerified?, sources?}`, ids unique and matching manifest branches. Files using them declare `contractVersion` 1.2.0. Schemas stay in `curriculum/v1/`; nothing removed or tightened.
- **Consequences:** `SwoondCore`: `Layer.branch`, `Activity.branchId`, `Lesson.live` + `Lesson.activities(forBranch:)`, `BranchFacts`, `Curriculum.branches`/`branchFacts(_:)`; split loader carries root `branches`. Consumers that switch exhaustively over `Layer` (SwoondApp) must handle `.branch`. Validator enforces the branch rules above. Example `examples/basketball-branches-1.2.json`.

### D-016 - Validator: sim spec checks, `thin-lesson`, `--partial`
- **Status:** Accepted
- **Decision:** `tools/validate` (a) requires every manifest `unitySimulations[].specPath` to exist and the spec's configuration JSON Schema (json fence under `## 10. Configuration schema`, or titled `<simulationId> configuration`) to compile as draft 2020-12 with ajv (closes the bridge README open question for schema extraction; validating curriculum `configuration` objects against those schemas is a follow-up); (b) adds lint rule `thin-lesson` (error: lesson with fewer than 4 activities, `unity-sim` counts); (c) adds `--course <id> --partial` for incremental per-unit authoring (no error for `unitOrder` entries without unit files yet, or prerequisites pointing at them, and no `no-sims`; everything else still errors).

### D-017 - Wave 1 course conventions (proposed; confirm via OPEN_QUESTIONS)
- **Status:** Proposed
- **Proposals from the Wave 1 agents:** F1 branches are team paths, not leagues; F1 uses no team logos, liveries, driver likeness, photos or FOM audio, and skips `listening-id`; basketball branches are `nba` (default), `wnba`, `college` (men's and women's share one branch); safety-critical courses (hiking, camping, climbing) require a qualified safety review before release and generated live-layer scenarios pass a safety linter; data-driven sims backed by an optimiser ship a checked-in golden generator; Jolpica-F1 (CC BY-NC-SA) and OpenF1 (non-commercial) are not used in production without commercial permission. Tracked as items in `docs/product/OPEN_QUESTIONS.md`; accepting them moves this entry to Accepted.

### D-018 - Curriculum authoring quality pipeline
- **Status:** Accepted
- **Decision:** Haiku may author per-unit curriculum JSON only for non-safety-critical courses, one unit per agent, following `UNIT_AUTHORING_GUIDE.md`.
- **Evidence:** Haiku repeatedly (a) produced templated placeholder content when given whole courses, (b) invented schema fields and misreported validator results, (c) made substantive factual errors — Soccer units 01-10 needed ~110 answer-key/explanation fixes; Hiking units 01-06 contained dangerous errors (reversed declination rule, "follow a creek downhill when lost", mis-taught hyponatremia/heatstroke).
- **Enforcement (1):** The orchestrator re-runs the validator itself before accepting any unit (agent reports are not trusted).
- **(2):** Every Haiku-authored course requires a Sonnet accuracy+conformance review pass over all units before the course is considered complete (model: `docs/courses/soccer/REVIEW.md`).
- **(3):** Safety-critical courses (hiking, camping, climbing, cooking food-safety units, fitness) are authored directly by Sonnet following the course's `SAFETY_REVIEW.md` checklist, and still need a qualified human safety review before release.
- **(4):** Curriculum JSON is never generated by script.
- **Consequences:** Haiku agents receive `UNIT_AUTHORING_GUIDE.md` and strict validation upfront; quality reviews are orchestrator-scheduled; unsafe courses stay with Sonnet and require human domain-expert approval.

## 2026-09-30 - Wave 2 consolidation (contract minor, proposed conventions)

### D-019 - Course manifest contract 1.2 (additive): more `personalizationDimensions`
- **Status:** Accepted
- **Context:** Wave 2 agents asked for dimensions the 1.1 enum lacked: movies (`actor`, `era`, optionally `studio`), fashion (`designer`, `era` for the vintage branch), books (optionally `format`, `era`), music (optionally `festival`, `venue`). No Wave 2 course asked for a new `dynamicData.kind`; all 13 manifests fit the 1.1 list.
- **Decision:** `personalizationDimensions[]` gains `era`, `designer`, `actor`, `studio`, `format`, `festival`, `venue` (`series` already existed). Existing values unchanged; 1.0 and 1.1 manifests stay valid. Sample manifest bumped to 1.2.0. No new `v2/` folder.
- **Consequences:** `SwoondCore` decodes `personalizationDimensions` as `[String]`, so no Core change. Validator test added (new values pass, unknown values still fail). Branch `personalizationDimension` stays a free string.

### D-020 - Film, Television and Books media conventions (proposed; confirm via OPEN_QUESTIONS)
- **Status:** Proposed
- **Proposal (movies and books agents; applies to horror-films, anime, Television, music):** no posters, key art, stills, trailers, clips, score or soundtrack audio, dialogue, blurbs, covers, excerpts, publisher synopses, review text, rating aggregates or author/cast photos; all imagery, audio and sample passages are original (`original-swoond` licence id); titles and names appear as facts only; trailer link-outs go only to official channels; lyrics are never ingested or shown. `horror-films` stays an independent course (movies CDS boundary test). Tracked as P-25 and L-21.

### D-021 - Hazard and sensitivity release gates beyond hiking (proposed; confirm via OPEN_QUESTIONS)
- **Status:** Proposed
- **Proposal (extends D-017/D-018, P-18):** a qualified human review is a release gate for lessons in these areas: camping (fire, CO, wildlife, water, cold), cooking food safety (USDA minimums, thawing, kidney beans, raw egg), pottery studio safety (silica dust, respirators, kiln, glaze materials, food-safe claims), photography (solar, tides, wildlife distance) and the cars `truck-offroad` branch (towing, off-road). Authored by Sonnet per D-018 (3), never Haiku. A generated-content safety linter (food temperatures, "colour = done", fire/CO rules, distances) applies to live-layer scenarios. Cultural and sensitivity reviews (pottery traditions, fashion appropriation/religious dress/sizing) gate the named lessons. Tracked as S-07 to S-19.

## Open questions (product owner)

The consolidated, deduplicated list (including Wave 1) lives in `docs/product/OPEN_QUESTIONS.md`. Q-1 to Q-4 below are kept for history and appear there as P-01, P-02, L-01 (Q-3) and P-03 (Q-4).

| # | Question | Needed by |
|---|---|---|
| Q-1 | iOS minimum deployment target: keep 18.0 or raise to the current major minus one? | Before first TestFlight |
| Q-2 | Production backend choice (Neon vs Firebase) and auth provider | Before any cloud sync feature |
| Q-3 | News/editorial provider for the current-context layer (licensing cost) | Before Wave 1 live layer |
| Q-4 | Whether bridge sessions may be resumed after app termination (checkpoint persistence) in v1 or v1.1 | Before first Unity sim ships |
