# content/

`content/courses/` is the app's bundled content pack. It is **generated** from `docs/courses/` by
`node tools/content/build-pack.mjs` (Node 22). Do not hand-edit; edit `docs/courses/<id>/` and re-run it.

- Included: courses with `manifest.json` + `curriculum/course.json` that pass `validate.mjs --course <id> --partial`
  (0 schema errors, 0 lint errors). Others are skipped.
- Partial courses: `unitOrder` in the pack's `course.json` is trimmed to units that exist, so the app never loads a missing unit.
- `INDEX.json` lists courses, unit counts and `generatedAt`.
- CI runs `node tools/content/build-pack.mjs --check` and fails when this folder is stale.
- App precedence: `ContentBootstrap` composes `courses/` (this pack) first, then the small seed in
  `ios/Swoond/Resources/ContentPacks`; on the same course id, this pack wins.
