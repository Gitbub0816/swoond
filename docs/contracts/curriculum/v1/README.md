# Curriculum Contract v1 (1.2)

`curriculum.schema.json` describes the ongoing course content for one course: `concepts[]` (the Playbook), `units[]` -> `lessons[]` -> `activities[]`, standalone `talkTracks[]`, and a `reviewPolicy`. Files live in `docs/courses/<courseId>/curriculum/*.json`, in one of two layouts (see below). Contract 1.1 (D-013) added the split layout; contract 1.2 (D-015) added branch support and per-lesson live hooks. Both are additive: 1.0 single files remain valid.

## Shape

- `concepts[]`: `{id, term, definition, exampleLine, tier?, relatedConceptIds?, aliases?}`. Every `conceptId` referenced anywhere must exist here (enforced by the validator).
- `units[]`: `{id, title, layer, order, prerequisiteUnitIds, branchId?, personalizationSlots?, live?, lessons[]}`. Layers: `foundations`, `intermediate`, `enthusiast`, `branch` (1.2), `current-season`, `conversation`, `review`.
- `lessons[]`: `{id, title, objective, estimatedMinutes, conceptIds, live?, activities[]}`.
- `activities[]`: `{id, type, conceptIds, payload, branchId?, reviewEligible?, xp?}`. `type` is a native exercise type (payload validated against `docs/contracts/native-exercises/v1/<type>.schema.json`) or `unity-sim` (payload `{simulationId, simulationVersion, difficulty, configuration}`).
- `talkTracks[]`: Talk tab scenarios; payload conforms to `talk-track`.
- `reviewPolicy`: Leitner boxes (`leitner-boxes-v1`).

## Contract 1.2 additions (D-015)

- **Layer `branch`:** units that exist for one branch only (college, WNBA, a league, a team path). A `branch` unit must set the unit-level `branchId` (validator error otherwise). Non-branch layers may still carry `branchId`.
- **Activity `branchId` (optional):** the activity is shown only when the person's branch matches; activities without it are shared. Use it for rules that differ by branch inside a shared lesson (NBA vs college shot clock) instead of duplicating the lesson. It must not contradict the unit's `branchId`, and must be a branch id of the course manifest.
- **Lesson `live` (optional):** `{dataKind?, refreshHint?, adapterKey?}`, the same hook shape as unit `live`, for a per-lesson live-data hook (for example `live.standings.playin`). Hooks are allowed on any layer, not only `current-season`. The unit hook names the primary feed; the lesson hook refines it.
- **Root `branches[]` (optional, single file and split `course.json`):** `{id, displayName?, facts, lastVerified?, sources?}`; a facts container for branch-specific data (F1 team facts: engine supplier, line-up, history beats; league rule values). `id` must be unique and match a manifest `branches[].id`; `facts` is free-form JSON. Time-sensitive facts carry `lastVerified` (ISO date).
- Files using these features should declare `contractVersion` `1.2.0`. Example: `examples/basketball-branches-1.2.json`.

## Layouts (contract 1.1)

**A. Single file (v1.0).** `curriculum/<name>.json` validates against `curriculum.schema.json`. Example: `examples/american-football-sample.json`.

**B. Split (v1.1).** Detected when `curriculum/course.json` exists:

```
curriculum/course.json                 root: contractVersion "1.1.0", courseId, curriculumVersion, locale?, concepts[], talkTracks[]?, reviewPolicy, unitOrder[]
curriculum/units/<NN>-<unit-id>.json   { contractVersion, courseId, unit: {...same Unit object as v1...}, concepts?: [...] }
```

Schemas: `curriculum-root.schema.json`, `curriculum-unit.schema.json`. Example: `examples/split/american-football/curriculum/`.

Merge rules (validator and `BundledContentRepository` behave identically):

- The merged object is a normal v1 curriculum: `units` = unit files in `unitOrder` order; `concepts` = root `concepts[]` then each unit file's `concepts[]` (in unit order); `locale` defaults to `en-US`; `talkTracks` and `reviewPolicy` come from the root.
- `unitOrder` must match exactly the set of unit files (by `unit.id`); the file name must be `<NN>-<unit-id>.json` and the id part must equal `unit.id`. Every file's `courseId` must equal the root's.
- Root `concepts[]` may be empty because units can add unit-local concepts, but the merged list must be non-empty. A concept id defined in more than one file is an error.
- Other JSON files next to `course.json` are an error; unit files live only in `units/`.
- Cross-references (concept ids, prerequisites, ids unique course-wide) resolve against the merged course, so a unit may reference concepts from the root or any other file.

## Depth expectations

A course is an ongoing programme (D-007): dozens of lessons across the layers. The schema does not cap size. `current-season` units contain templates and a `live` block, not hard-coded scores. IDs are kebab-case and stable; never reuse an id for a different meaning.

## Personalization tokens

Authored strings may contain `{{dimension}}` (e.g. `{{team}}`) resolved from the Person's personalization; the unit must list the dimension in `personalizationSlots`. Provide a generic fallback by writing the sentence to make sense when the token is replaced by the course's default value (declared in the CDS).

## Validation

`node tools/validate/validate.mjs` checks schema (split layout: root and unit schemas per file, then the merged curriculum), unique ids, prerequisite references, concept references and each activity payload. Example: `examples/american-football-sample.json`.

### Content lint

Schema-valid is not the same as shippable. After the schema checks, `validate.mjs` runs a content lint on every curriculum (split layout: on the merged course, with issues reported against the originating file; pointers into unit files start at `/unit`) and exits non-zero on any lint error (`--no-lint` skips it; `--course <id>` limits to one course; `--lint-max 0` prints every issue). `--course <id> --partial` is for incremental per-unit authoring: it does not error on `unitOrder` entries that have no unit file yet (nor on prerequisites pointing at them) and suppresses `no-sims`; every other check still errors. Rules:

- **placeholder** (error): stub text such as "Sample question?", "Option A", "First step", "Put in order", "How many?", "Another interpretation", lorem ipsum, TODO/TBD, "placeholder", "[insert"; and explanations that are only "Correct." / "Close!" / "Try again.". Reported with file and JSON pointer.
- **duplicate-payload** (error): the same canonical (sorted-key) payload on more than one activity in a course. **repeated-prompt** (error): the same prompt/question/statement text on more than 2 activities. `say-this` has a stock question by design, so it is judged on its quoted `statement.text`; `talk-track` frames are exempt (covered by duplicate-payload).
- **thin-explanation / thin-prompt / empty-option / duplicate-option** (error): explanations under 25 chars, prompts under 12 chars, empty or repeated option texts within an activity.
- **thin-lesson** (error): a lesson with fewer than 4 activities (a `unity-sim` activity counts).
- **no-sims** (error) / **missing-sim** (warning): every `unitySimulations[].simulationId` in the course manifest should appear in a `unity-sim` activity; a curriculum with none is an error, each individual missing sim a warning.
- **generated-content** (error): any `*.sh`, `*.py`, `*.js` (also `.mjs`/`.cjs`) inside `docs/courses/*/curriculum/`. Content must be authored, not generated by script.
- **info**: lessons, activities, activity-type histogram and distinct-payload ratio per course.

Tests: `cd tools/validate && npm test` (fixtures in `test-fixtures/`: `good`, `bad` (standing lint negative case), `split-good` (split layout; tests mutate copies of it)). A course with no curriculum yet is not linted.

### Sim spec checks (course manifest)

For every manifest `unitySimulations[]` entry the validator checks that `specPath` exists and that the spec's configuration JSON Schema compiles as draft 2020-12 (ajv, strict). The schema is the first ```json fence under the spec's `## 10. Configuration schema` heading (or any fence whose title is `<simulationId> configuration`). Failures are reported against the spec file.
