# Curriculum Contract v1

`curriculum.schema.json` describes the ongoing course content for one course: `concepts[]` (the Playbook), `units[]` -> `lessons[]` -> `activities[]`, standalone `talkTracks[]`, and a `reviewPolicy`. Files live in `docs/courses/<courseId>/curriculum/*.json` (one file per course version; large courses may split into several files by unit layer only if the loader is extended, which is a contract change).

## Shape

- `concepts[]`: `{id, term, definition, exampleLine, tier?, relatedConceptIds?, aliases?}`. Every `conceptId` referenced anywhere must exist here (enforced by the validator).
- `units[]`: `{id, title, layer, order, prerequisiteUnitIds, branchId?, personalizationSlots?, live?, lessons[]}`. Layers: `foundations`, `intermediate`, `enthusiast`, `current-season`, `conversation`, `review`.
- `lessons[]`: `{id, title, objective, estimatedMinutes, conceptIds, activities[]}`.
- `activities[]`: `{id, type, conceptIds, payload, reviewEligible?, xp?}`. `type` is a native exercise type (payload validated against `docs/contracts/native-exercises/v1/<type>.schema.json`) or `unity-sim` (payload `{simulationId, simulationVersion, difficulty, configuration}`).
- `talkTracks[]`: Talk tab scenarios; payload conforms to `talk-track`.
- `reviewPolicy`: Leitner boxes (`leitner-boxes-v1`).

## Depth expectations

A course is an ongoing programme (D-007): dozens of lessons across the layers. The schema does not cap size. `current-season` units contain templates and a `live` block, not hard-coded scores. IDs are kebab-case and stable; never reuse an id for a different meaning.

## Personalization tokens

Authored strings may contain `{{dimension}}` (e.g. `{{team}}`) resolved from the Person's personalization; the unit must list the dimension in `personalizationSlots`. Provide a generic fallback by writing the sentence to make sense when the token is replaced by the course's default value (declared in the CDS).

## Validation

`node tools/validate/validate.mjs` checks schema, unique ids, prerequisite references, concept references and each activity payload. Example: `examples/american-football-sample.json`.

### Content lint

Schema-valid is not the same as shippable. After the schema checks, `validate.mjs` runs a content lint on every `docs/courses/*/curriculum/*.json` and exits non-zero on any lint error (`--no-lint` skips it; `--course <id>` limits to one course; `--lint-max 0` prints every issue). Rules:

- **placeholder** (error): stub text such as "Sample question?", "Option A", "First step", "Put in order", "How many?", "Another interpretation", lorem ipsum, TODO/TBD, "placeholder", "[insert"; and explanations that are only "Correct." / "Close!" / "Try again.". Reported with file and JSON pointer.
- **duplicate-payload** (error): the same canonical (sorted-key) payload on more than one activity in a course. **repeated-prompt** (error): the same prompt/question/statement text on more than 2 activities.
- **thin-explanation / thin-prompt / empty-option / duplicate-option** (error): explanations under 25 chars, prompts under 12 chars, empty or repeated option texts within an activity.
- **no-sims** (error) / **missing-sim** (warning): every `unitySimulations[].simulationId` in the course manifest should appear in a `unity-sim` activity; a curriculum with none is an error, each individual missing sim a warning.
- **info**: lessons, activities, activity-type histogram and distinct-payload ratio per course.

Tests: `cd tools/validate && npm test` (good/bad fixtures in `test-fixtures/`; `docs/courses/soccer` is the standing negative case until its placeholder curriculum is replaced).
