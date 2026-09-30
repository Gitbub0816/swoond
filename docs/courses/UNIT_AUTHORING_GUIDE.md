# Unit Authoring Guide (curriculum contract 1.1+ split layout)

Rules for any agent hand-writing curriculum content for one unit of a course.
Layout: `docs/courses/<courseId>/curriculum/course.json` (root: concepts, talkTracks,
reviewPolicy, unitOrder) + `docs/courses/<courseId>/curriculum/units/NN-<unit-id>.json`.
`NN` is the 1-based position of the unit id in `unitOrder`, zero-padded to 2 digits.

## Read first
- `CLAUDE.md`
- `docs/contracts/curriculum/v1/README.md` and the unit/root schemas + `examples/split/`
- `docs/contracts/native-exercises/v1/*.schema.json` (payload shapes) and `docs/native-exercises/CATALOG.md`
- The course's `CDS.md` (the curriculum map is your blueprint: lesson ids, titles, objectives, conceptIds, planned activities), `exercises.md` (sample items, Playbook, talk tracks), `manifest.json` (simulation ids), and `curriculum/course.json` (concept ids you may reference).
- One already-accepted unit file as a quality reference (e.g. `docs/courses/soccer/curriculum/units/01-the-game.json`).

## Hard rules
1. **Hand-written only.** Write the JSON directly with the Write/Edit tools. No generator scripts (`.sh/.py/.js/...`) anywhere — the validator fails them, and templated output is rejected on review.
2. **Every lesson in the unit** from the CDS map, with the CDS lesson ids.
3. **4–8 activities per lesson** (aim for 5), using the activity types the CDS plans for that lesson. `unity-sim` activities count and must use the manifest's `simulationId`; if the CDS names a native fallback for a sim, include that fallback too. ≤50% of a unit's activities may be one type.
4. **Unique and specific**: no two activities share a payload or prompt; each tests that lesson's concepts.
5. **Factually correct** for the current season/rules stated in the CDS. If unsure, leave it out rather than guess.
6. **Voice**: warm, a little flirty, never condescending — the learner is learning for someone they care about. Explanations ≥ 25 chars and actually explain *why*.
7. **No placeholders** ("Sample question", "Option A", "First step", bare "Try again.").
8. **Concepts**: reference concept ids that exist in `course.json`. Do NOT add unit-local concepts (parallel agents would collide); if a needed concept is missing, list it in your report instead.
9. **Only write your own unit file.** Never edit `course.json`, other units, the manifest or shared files.
10. **Safety** (outdoors, fitness, food, etc.): conservative, follow the CDS safety constraints.
11. **Exact schema fields.** Before writing each activity, open `docs/contracts/native-exercises/v1/<type>.schema.json`
    and use exactly its field names. Past agents invented fields (`correctOrder`, `images`, `correctImageId`, `fanLine`,
    `replies`, `spots`, `context`, `title`, `scenario`, `dilemma`) and were rejected. Copy structure from an accepted
    unit in the same course.
12. **Report honestly.** Your reply must paste the exact validator output lines for your file. Any `FAIL` or
    `LINT-FAIL` line means you are not done. The orchestrator re-runs the validator; a false "pass" is caught.

## Validate
`cd tools/validate && node validate.mjs --course <courseId> --partial` (if `--partial` is unavailable, run without it and ignore only `missing-unit` and `no-sims` errors caused by other unwritten units). Your unit must have **zero** schema and lint errors.

## Report (under 100 words)
File path, per-lesson activity counts, type histogram, validator lines for your file, missing concepts (if any).
