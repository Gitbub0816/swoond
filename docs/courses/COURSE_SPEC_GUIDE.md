# Course Spec Authoring Guide (CDS + manifest + Astra sim specs)

Brief for an agent designing one Swoon'd course end to end, before any curriculum JSON is written
(curriculum JSON is authored later, per unit, via `UNIT_AUTHORING_GUIDE.md`).

## Scope rules
- Write ONLY inside `docs/courses/<course-id>/`. Never edit shared files (CATALOG, CLAUDE.md, schemas,
  templates, GAME_KIT). Put requests for shared changes in `docs/courses/<course-id>/NOTES_FOR_ORCHESTRATOR.md`.
- Do not commit or push. Use a scratch dir unique to your course (other agents run in parallel).
- Do not write `curriculum/` JSON.

## Read first
`CLAUDE.md`; `docs/product/SWOOND_PRODUCT_SPEC.md`; `docs/product/DECISIONS.md`; `docs/product/OPEN_QUESTIONS.md`;
`docs/courses/README.md`, `CDS_TEMPLATE.md`, `CATALOG.md` (use the course id listed there);
`docs/native-exercises/CATALOG.md`; `docs/astra/README.md`, `GAME_KIT.md` (incl. section 5 consolidated
primitives GK-1..GK-20 and sport modules — reuse them before requesting new ones), `ART_DIRECTION.md`,
`SIM_SPEC_TEMPLATE.md`, `ROADMAP.md`; `docs/contracts/course-manifest/v1/` (schema + examples),
`docs/contracts/curriculum/v1/README.md` (layers incl. `branch`), `docs/contracts/sim-definition/v1/`,
`docs/contracts/unity-bridge/v1/README.md`. Use one finished Wave 1 course (e.g. `docs/courses/pickleball/`)
as a quality reference — do not copy its structure blindly; spec §3-§6: the subject determines the course.

## Deliverables
1. **`CDS.md`** following `CDS_TEMPLATE.md` exactly. Genuinely expert: real terminology, real misconceptions,
   real enthusiast debates, current facts (verify anything time-sensitive by web search and date it).
   **Curriculum Map = an ongoing course, not a deck:** foundations → intermediate → enthusiast depth →
   branches/personalization → a perpetual current-context layer (only if the subject truly has one; spec §10,
   §38) → perpetual conversation practice + review. Typically 10-16 units, ~80-120 lessons, each lesson with
   id, title, objective, conceptIds, planned activities (native type or Unity sim id).
   Interaction plan table justifying every Tier A (Unity) choice per the CLAUDE.md rubric — Unity only where
   spatial reasoning, movement, physics or timing materially improves learning. Many courses legitimately
   have **zero** Unity sims; say so and why.
2. **`manifest.json`** valid against course-manifest v1.1. Canonical asset licence id: `original-swoond`.
   `conversationScenarios.path` = `docs/courses/<id>/curriculum/course.json`.
3. **`sims/<simulationId>.md`** — one per Tier A sim, every section of `SIM_SPEC_TEMPLATE.md` filled,
   buildable by Astra without questions: Game Kit entities, difficulty 1-5 params, configuration JSON Schema
   block titled `<simulationId> configuration`, ≥6 concrete scenarios with data, freeze/explain copy in Swoon'd
   voice, mastery signal → conceptId mapping, testable acceptance criteria, PlayMode test plan, native fallback
   lesson, "Game Kit additions requested" (reference GK ids where possible).
4. **`exercises.md`** — per native type used, ≥3 fully written sample payloads that validate against
   `docs/contracts/native-exercises/v1/*.schema.json` (check with ajv); Playbook terms (≥60, definition +
   example line in the enthusiast's voice); ≥8 Talk Track scenarios (enthusiast line, meaning, good/meh/cringe
   replies with coach notes).
5. **`live-data.md`** — dynamic data & editorial plan (spec §10-12, §32-40): provider candidates behind
   adapters, normalized entities, refresh cadence, licensing notes, personalization hooks. For media courses,
   follow spec §40 strictly (talk about works, never redistribute them).
6. **`NOTES_FOR_ORCHESTRATOR.md`** — shared-file change requests, open questions, facts to re-verify.

## Voice
Warm, a little flirty, never condescending. The learner is learning because someone they care about loves this.
Never teach fake expertise; teach understanding and good questions.

## Safety
Outdoors, food, fitness, climbing, etc.: conservative mainstream guidance; state safety constraints in the
manifest; Swoon'd builds appreciation, not a substitute for training.

## Validate
`cd tools/validate && node validate.mjs --course <id> --partial` → your manifest and sim specs must pass.

## Report (under 300 words)
Files, sim ids + one line each (or "none, because…"), unit/lesson/concept counts, validator result, notes.
