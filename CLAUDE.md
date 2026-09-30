# CLAUDE.md - Swoon'd

Persistent guide for Claude Code sessions in this repo. Read this first; details live in the linked docs. Keep it current (see "Current status / next steps").

## 1. Product in one paragraph

Swoon'd ("Get into what they're into.") helps someone learn the interests of a person they care about (crush, partner, friend, family) well enough to understand and join conversations about it: **socially useful competence**, not expertise. The primary object is the **Person**, not the course: Person -> Interests -> Branch -> Personalization. Each interest is an intentionally designed **course** (an ongoing, deep programme: foundations, intermediate, enthusiast depth, current-season/live, conversation practice, perpetual spaced review), taught through native exercises (Tier B) and, where spatial/physical, Unity simulations (Tier A) built by Astra.

**North star:** turn "I have absolutely no idea what she's talking about" into "Okay. Now I understand why she loves this." Success is not completion or XP; it is whether the learner can genuinely engage with someone they care about. Never optimize for being an encyclopedia; never encourage faking expertise.

Source of truth: `docs/product/SWOOND_PRODUCT_SPEC.md` (do not edit; clarify in `docs/product/DECISIONS.md`). Design source of truth: `docs/design/DESIGN_SPEC.md`.

## 2. Repo layout

```
CLAUDE.md                    this file
README.md                    short intro
.gitignore
docs/
  product/                   SWOOND_PRODUCT_SPEC.md (read-only), DECISIONS.md, GLOSSARY.md, OPEN_QUESTIONS.md
  design/                    design handoff: DESIGN_SPEC.md, README.md, Swoond.dc.html (read-only)
  architecture/              ARCHITECTURE.md (iOS native app)
  contracts/                 versioned JSON Schemas + examples (platform-neutral)
    unity-bridge/v1/         launch-request / simulation-result / bridge-event, lifecycle README
    course-manifest/v1/      per-course manifest schema (1.1)
    curriculum/v1/           curriculum schema (1.2: branch layer, activity branchId, lesson live, branches[]) + root/unit schemas for the split layout
    native-exercises/v1/     one schema + example per native exercise type
    sim-definition/v1/       Astra's data-driven sim schema
  native-exercises/          CATALOG.md (Tier B exercise catalog)
  astra/                     README (handoff), GAME_KIT.md, ROADMAP.md, ART_DIRECTION.md, SIM_SPEC_TEMPLATE.md
  courses/                   README, CDS_TEMPLATE.md, CATALOG.md, <course-id>/{CDS.md,manifest.json,curriculum/,sims/,exercises.md}
tools/validate/              Node 22 ESM validator (ajv 2020-12): node validate.mjs
ios/                         SwoondCore Swift package (done, Linux tests) + Swoond SwiftUI app (in progress)
```

## 3. Ownership rules (non-negotiable)

- **Claude Code owns the native app** (iOS now; Android later): navigation, profiles/persons, course browsing, curriculum UI, progress, native exercises, persistence, networking, notifications, Unity host integration.
- **Astra (OpenAI ChatGPT Work) owns Unity and every simulation:** Unity project, Swoon Game Kit, sim logic, physics, scenes, cameras, Unity tests, Unity builds, the Unity side of the bridge.
- **Never re-implement Unity simulation logic natively.** Native validates and applies a `SimulationResult`; it does not recompute a sim, and does not ship "fallback" copies of Tier A games. (A native fallback lesson for accessibility is a separate designed exercise, not a port.)
- **Never change the bridge contract** (`docs/contracts/unity-bridge/`) without: a version bump (semver rules in its README), a `DECISIONS.md` entry, updated examples, and passing `node tools/validate/validate.mjs`. Breaking changes create a new `vN/` folder. Neither Claude nor Astra changes it unilaterally.
- Courses are intentionally designed; never force them into a generic template (spec rule 4).
- External APIs sit behind Swoon'd-owned adapters; no provider schema becomes the domain model; no unofficial/reverse-engineered production APIs (AllTrails etc.); do not assume public media is redistributable.
- Do not edit `docs/product/SWOOND_PRODUCT_SPEC.md` or `docs/design/*` without product-owner approval.

## 4. Tier rubric: Unity or native?

Default is **native**. Use Unity (Tier A) only when **spatial reasoning, movement, physics, timing in a scene, or camera perspective materially improves learning**, and a native exercise would teach it clearly worse.

| Signal | Unity (Tier A) | Native (Tier B) |
|---|---|---|
| Learner must see things move over time in space (routes, coverage, drafting, ball flight) | Yes | No |
| Physics/camera perspective is the concept | Yes | No |
| A decision depends on reading a dynamic scene | Yes | Static facts: decision-scenario |
| Simple 1D timing bar | No | timing-tap |
| Two-way call on a static diagram | No | binary-call |
| Recall, terms, order, recognition, estimate, conversation | No | Native types |
| Would a "fake game" be a worse teacher than clear text and a diagram? | | Native |

Every Unity activity needs a written tier justification in the CDS Interaction plan and sim spec section 4. The design file's three demo games are representative of look only (D-002): Pit Stop, Pickleball kitchen and Hockey Talk Track are native types.

Native exercise types: multiple-choice, binary-call, term-match, sequence-order, visual-id, decision-scenario, talk-track, timing-tap, say-this, fill-the-gap, listening-id, estimate-slider, hotspot-tap (`docs/native-exercises/CATALOG.md`). Metal / Swift+C++ interop is an optional visual upgrade only.

## 5. Design system rules

Tokens come from `docs/design/DESIGN_SPEC.md` (section 3 colors dark + light, 4 type, 5 layout, 6 components, 7 motion, 8 game rules). Do not invent values.

- **Dark is the default** appearance; also Light and System. Never use dark-mode rose/gold as text on light backgrounds; use the light tokens.
- **Fonts:** Instrument Serif (display, regular + italic) and Geist (UI 400/500/600); bundle both (OFL). Never fall back to Inter/Roboto on purpose. Serif for feelings and lines you would say out loud (in quotes); sans for anything you read or tap. Min text 11 px (uppercase eyebrows only); body >= 13.
- **Accent rose `#FF6F86`** (light `#D93F5E`) means act/you: primary game CTA, selection, your bubbles. **Gold reward `#E8C07A`** (light `#A87A1E`) means earned: XP, streaks, correct, premium. Max one filled accent button per screen.
- Never rely on red/green alone; pair color with a title ("Nice read." / "Not quite.") and explanation.
- Hit targets >= 44 pt; primary buttons 56-58 pt; radii and spacing per spec; no gradients except `hero-grad` and faint radial glows; no emoji; line icons 1.5 px.
- Motion: `cubic-bezier(.2,.8,.2,1)`; 150/250/400 ms; respect Reduce Motion (cross-fades); no confetti.
- Voice: cheeky coach, playful never mean, short sentences, one joke per screen, never about the crush, never manipulative; premise is finding common ground, not faking it.
- Name: "Swoon'd" (curly apostrophe in UI); searchable as swoond/swoon; bundle ids `app.swoond.ios` / `app.swoond.android`.
- Discreet mode ON by default: notifications never contain the Person's name.

## 6. Swift coding conventions

Toolchain: **Xcode 27, Swift 6.4 (Swift 6 language mode), iOS SDK 27, deployment target iOS 18.0** (D-005). Unity 6.3 LTS is Astra's.

- **Swift 6 strict concurrency** on. Domain types are `Sendable` value types; stateful engines are `actor`s; UI state `@MainActor`. No `@unchecked Sendable` without a comment justifying it.
- **`@Observable`** view models (Observation framework) in SwoondApp; **SwiftUI `NavigationStack`** with typed routes. No `ObservableObject`/`@Published` in new code.
- **No third-party dependencies** unless justified in a DECISIONS entry (license, size, maintenance, why Foundation/Swift stdlib is insufficient).
- **SwoondCore stays Foundation-only** (no SwiftUI/UIKit/Combine/CoreData/os.log/Observation) so it builds and tests on Linux. Apple-only glue goes in SwoondApp behind Core protocols.
- **`swift test` must pass** on Linux for SwoondCore before any hand-off. Use Swift Testing (`import Testing`). Every example JSON under `docs/contracts/**/examples` must decode into Core types in tests.
- Backend/provider isolation: repository and adapter protocols in Core; provider DTOs are `internal` to their adapter; never export them (D-004, spec section 32).
- Codable: strict decoding for contracts; unknown keys ignored; `snake`/`camel` per JSON as authored (camelCase in all our schemas).
- IDs: strong types (`CourseID`, `PersonID`, `ConceptID`) wrapping String; never pass raw strings across module APIs.
- Errors: typed `throws`; no `fatalError` in Core; user-facing errors carry a friendly message and a recovery action.
- No force unwraps in Core. Public API documented with `///`.
- SwiftUI code cannot be built in the cloud container (no Xcode): keep it thin, previewable and mark "needs Mac verification" in the hand-off; put logic in Core.
- Files < 400 lines where practical; one primary type per file.
- Never log or transmit the Person's name/relationship to analytics, Unity telemetry or notifications in discreet mode.

## 7. Content conventions

- **Course IDs:** kebab-case, immutable once released, equal the folder under `docs/courses/` (`american-football`, `formula-1`, `k-pop`).
- **Other IDs** (unit, lesson, activity, concept, branch): kebab-case; stable; never reuse for a different meaning. Concept ids referenced anywhere must exist in the curriculum `concepts[]`.
- **Simulation IDs:** `<simulationPrefix>.<topic>.<name>.v<N>` (segments lowercase kebab), e.g. `football.coverage.read.v1`. The prefix is the course's manifest `simulationPrefix`. `.vN` = contract major of the sim (D-008).
- **Versions:** curriculum/manifest use semver; bridge `contractVersion` `1.x.y`.
- Explain every answer (right and wrong); teach how it works, not just the rule name. Prompts <= 12 words. Include a "say this" line where natural.
- Live data is never hard-coded into static lessons: use `live` unit hooks and adapters. Editorial: explain in our own words and link; never copy publisher text. Every image/audio asset needs a `license` id.

## 8. Workflow: adding a course

1. Boundary test (spec section 6) using `docs/courses/CATALOG.md`.
2. **CDS**: `docs/courses/CDS_TEMPLATE.md` -> `docs/courses/<id>/CDS.md` (full section 8 + Curriculum map + Interaction plan + section 47 checklist).
3. **Manifest**: `docs/courses/<id>/manifest.json` (schema `course-manifest/v1`).
4. **Curriculum JSON**: split layout, one unit per file: `docs/courses/<id>/curriculum/course.json` + `units/<NN>-<unit-id>.json` (schema `curriculum/v1`, contract 1.2): concepts, units across all layers (branch units use layer `branch`), talk tracks, review policy. Author by hand, never by script; incremental check: `node validate.mjs --course <id> --partial`.
5. **Native exercises**: author payloads per `docs/contracts/native-exercises/v1`; plan in `exercises.md`.
6. **Astra sim specs**: `docs/courses/<id>/sims/<simulationId>.md` from `docs/astra/SIM_SPEC_TEMPLATE.md`; list in manifest `unitySimulations[]`.
7. **Validation**: `cd tools/validate && npm install && node validate.mjs`; then update `docs/courses/CATALOG.md` status.

## 9. Agent / model policy (D-006)

- **Orchestrator session only delegates to subagents**; it does not write content or code itself.
- **Haiku** for docs/specs/content drafting where appropriate; **Sonnet** where judgment is necessary and for all code; **Opus only when absolutely necessary** (record why).
- Subagents must not commit or push unless instructed; the orchestrator commits. Commit messages end with the attribution lines the harness provides.
- Subagent briefs must be self-contained: goal, files to read, files to write, constraints, validation command, and required report format.

## 9a. Curriculum quality pipeline (D-018)

- Haiku authors per-unit curriculum JSON for non-safety-critical courses only. Orchestrator validates; Sonnet does accuracy review of all units before release.
- Safety-critical courses (hiking, camping, climbing, food-safety, fitness) authored by Sonnet; require human domain-expert review.
- Every unit: no schema/lint errors (orchestrator re-runs validator); no templated content; no invented fields; factually correct explanations.

## 10. How to validate

| What | Command | When |
|---|---|---|
| Contracts, manifests, curricula, examples | `cd tools/validate && npm install && node validate.mjs` (Node 22) | After any change under `docs/contracts/` or `docs/courses/` |
| SwoondCore logic | `cd ios/SwoondCore && swift test` (Linux OK) | After any Core change |
| SwiftUI app | Xcode 27 on a Mac: build + test + previews | Before merging app changes (not possible in the cloud container) |
| Unity sims | Astra's Unity test suites + bridge conformance vs `examples/` | Astra |

The validator: schema validation (ajv, draft 2020-12), unique ids, prerequisite/concept/branch references, each activity payload against its native-exercise schema, content lint (placeholders, duplicate/repeated prompts, thin explanations, `thin-lesson` = lessons under 4 activities, `no-sims`), and, per manifest, that every `unitySimulations[].specPath` exists and its configuration JSON Schema compiles. `--course <id> --partial` relaxes missing units and `no-sims` for per-unit authoring. It exits non-zero on failure; `npm test` in `tools/validate` covers it.

## 10a. CI

Two workflows, each with path-specific triggers and independent concurrency:

- `.github/workflows/content.yml`: `content` job (ubuntu, Node 22). Triggers on `docs/**`, `tools/validate/**`, `.github/workflows/content.yml`. Concurrency `content-${{ github.ref }}`, cancel-in-progress: true.
- `.github/workflows/ios.yml`: `core-linux` (ubuntu, `swift:6.3`) and `ios-build` (macos-26, newest Xcode). Triggers on `ios/**`, `.github/workflows/ios.yml`, `tools/ci/**`, `docs/contracts/**` (SwoondCore tests read contract examples). Concurrency `ios-${{ github.ref }}`, cancel-in-progress: true for pull_request only (let each iOS build finish on pushes).

Keep the local commands in section 10 green before pushing; bump the action versions and runner label when the toolchain in section 12 moves.

## 11. Key docs

- Product: `docs/product/SWOOND_PRODUCT_SPEC.md`, `docs/product/DECISIONS.md`, `docs/product/GLOSSARY.md`
- Design: `docs/design/DESIGN_SPEC.md`, `docs/design/README.md`, `docs/design/Swoond.dc.html` (open in a browser with `support.js`)
- Architecture: `docs/architecture/ARCHITECTURE.md`
- Contracts: `docs/contracts/README.md`; bridge `docs/contracts/unity-bridge/v1/README.md`; manifest `docs/contracts/course-manifest/v1/README.md`; curriculum `docs/contracts/curriculum/v1/README.md`; native payloads `docs/contracts/native-exercises/v1/README.md`; sim definition `docs/contracts/sim-definition/v1/README.md`
- Native exercises: `docs/native-exercises/CATALOG.md`
- Astra: `docs/astra/README.md`, `GAME_KIT.md`, `ART_DIRECTION.md`, `SIM_SPEC_TEMPLATE.md`
- Courses: `docs/courses/README.md`, `CDS_TEMPLATE.md`, `CATALOG.md`
- Open decisions, licensing/legal checks, SME reviews, facts to re-verify: `docs/product/OPEN_QUESTIONS.md`
- Astra build plan: `docs/astra/ROADMAP.md`; consolidated Game Kit requests: `docs/astra/GAME_KIT.md` section 5

## 12. Toolchain versions (verified 2026-09-30)

Xcode 27; Swift 6.4; iOS SDK 27.0; iOS deployment target 18.0; Unity 6.3 LTS (6000.3.24f1) with URP; Node 22; ajv 8.20.0; ajv-formats 3.0.1. Re-verify at release milestones and record in DECISIONS.

## 13. Current status / next steps

*(The orchestrator updates this section after each work session.)*

**Status (2026-09-30):**
- Foundation done: product decisions (D-001 to D-018), glossary, architecture, all contracts with validated examples (bridge v1, course manifest 1.1, curriculum 1.2, 13 native exercise schemas, sim-definition v1), native exercise catalog, Astra handoff docs, validator with content lint and sim-spec checks (`npm test` green).
- SwoondCore done: domain, ProgressEngine, ContentLoader (single-file and split layouts, branch-aware), bridge types and BridgeSession, exercise engines, mock providers; `swift test` passes on Linux.
- iOS app written; CI building on macOS; content pack at `content/courses`.
- Soccer curriculum complete (20 units, reviewed). Wave 1 other courses in progress (hiking, basketball, F1, football, NASCAR, hockey, pickleball). Wave 2 specs 12/13 done (books pending). Wave 3 started (horror-films).
- Game Kit: sport modules specified (Hockey, Soccer, Basketball, Pickleball court pattern, shared Racing for NASCAR + F1, Terrain for hiking). Consolidated requests (20 generic primitives) in `docs/astra/GAME_KIT.md` section 5; build order in `docs/astra/ROADMAP.md`. Nothing built in Unity yet.
- Consolidated open questions (45: product, licensing/legal, SME, facts to re-verify): `docs/product/OPEN_QUESTIONS.md`.

**Next steps (suggested order):**
1. Product-owner pass on `docs/product/OPEN_QUESTIONS.md` (P-01 to P-19 first; L-01 news provider and L-02/L-03 data providers block the live layer).
2. Finish the SwiftUI app shell and Mac verification; wire `BundledContentRepository` to the authored split curricula.
3. Finish curriculum JSON per unit for all 8 Wave 1 courses (`validate.mjs --course <id> --partial` while incremental), then flip catalog/manifest status to `content-in-progress`.
4. Hand Astra `docs/astra/` (GAME_KIT section 5, ROADMAP) and agree the bridge v1 conformance suite; first vertical slice `football.coverage.read.v1`.
5. Line up SME reviews (S-01 to S-06) ahead of each sim's approval; safety review for hiking (S-05).
6. Follow-up validator work: validate sim `configuration` objects in curriculum activities against each spec's schema; check `unitySimulations[].lessonIds` against curriculum lessons.
7. Wave 2 (13 courses, `docs/courses/CATALOG.md`) once the Wave 1 curriculum pipeline and first sim slice are proven; reuse Wave 1 modules (Court, Terrain, spatial kit) where they fit.
