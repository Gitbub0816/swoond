# Courses

Each supported interest is an intentionally designed course (product spec sections 3-8), not a label poured into a template. Courses share infrastructure, never curriculum structure (spec section 3).

## Folder layout

```
docs/courses/
  README.md            (this file)
  CATALOG.md           course catalog: family, boundaries, wave, status
  CDS_TEMPLATE.md      Course Design Specification template
  <course-id>/         kebab-case; equals manifest courseId
    CDS.md             the approved Course Design Specification
    manifest.json      validates against course-manifest/v1
    curriculum/        *.json validating against curriculum/v1
    exercises.md       native exercise plan (types, counts, notes)
    sims/
      <simulationId>.md   Astra sim specs (SIM_SPEC_TEMPLATE.md)
```

`tools/validate` checks `manifest.json` (and that `courseId` equals the folder) and every `curriculum/*.json` (schema, ids, concept references, payloads).

## Workflow to add a course

1. **Boundary check.** Apply the spec section 6 test in `CATALOG.md`: is this its own course or a branch?
2. **CDS.** Copy `CDS_TEMPLATE.md` to `<course-id>/CDS.md`; complete every section including the Curriculum map, Interaction plan and the section 47 quality checklist. A course does not enter production on taxonomy alone.
3. **Manifest.** Create `manifest.json` from the CDS (start with `status: cds-draft`).
4. **Curriculum JSON.** Author `curriculum/<courseId>.<version>.json`: concepts (Playbook) first, then units and lessons across all layers, talk tracks, review policy.
5. **Native exercises.** Author payloads (Tier B) using `docs/native-exercises/CATALOG.md`; summarize plan in `exercises.md`.
6. **Astra sim specs.** For each Tier A activity write `sims/<simulationId>.md` from `docs/astra/SIM_SPEC_TEMPLATE.md`; add to manifest `unitySimulations[]`.
7. **Validate.** `cd tools/validate && npm install && node validate.mjs`; fix all failures.
8. **Review.** Product-owner review against the section 47 checklist; move manifest `status` to `cds-approved` / `content-in-progress` / `in-review` / `released` and update `CATALOG.md`.

## Depth standard

A released course is an ongoing programme (D-007): many units and dozens of lessons across foundations, intermediate, enthusiast depth, current-season/live, conversation practice and perpetual spaced review. The design prototype's "3+ units" is a floor.

## Ownership

- CDS, curriculum, exercises: content agents (Haiku for drafts where appropriate; Sonnet for the parts needing judgment) with product-owner approval.
- Sim specs: written by us, implemented by Astra.
- Native implementation: Claude Code.
