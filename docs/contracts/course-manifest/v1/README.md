# Course Manifest Contract v1 (1.2)

Contract 1.2 (D-019, additive): `personalizationDimensions[]` (and so a branch `personalizationDimension`, by convention) gains `era`, `designer`, `actor`, `studio`, `format`, `festival` and `venue` (`series` already existed), requested by the Wave 2 movies, fashion, books and music agents. No new `dynamicData[].kind` was requested by Wave 2 (all 13 manifests fit the 1.1 list). Existing 1.0 and 1.1 manifests stay valid.

Contract 1.1 (D-014, additive): `dynamicData[].kind` gains `injuries`, `transactions` and `regulations`, so courses no longer map injury reports to `alerts`/`rosters`, transfers/trades to `rosters`, or FIA/rulebook documents to `events`. Existing 1.0 manifests stay valid.

`course-manifest.schema.json` implements product spec section 41. One manifest per production course at `docs/courses/<courseId>/manifest.json`. It is the coordination object between curriculum, backend, Astra and native (spec section 41).

## Fields

| Field | Purpose |
|---|---|
| `courseId` | Kebab-case, equals folder name, immutable after release |
| `displayName`, `category`, `family` | Identity and taxonomy (family is one of the 19 spec families) |
| `status`, `wave` | Production tracking (see `docs/courses/CATALOG.md`) |
| `simulationPrefix` | First segment of this course's simulation IDs (D-008) |
| `branches[]` | Sub-variants sharing the foundation (NFL / College) |
| `curriculumVersion` | Semver of the curriculum JSON content |
| `foundationalModules[]` | Unit ids the CDS calls foundational |
| `interactionTypes[]` | Union of native exercise types and `unity-sim` used |
| `unitySimulations[]` | `{simulationId, specPath, status, lessonIds}`: Astra work items |
| `nativeExercises[]` | `{exerciseType, specPath}`: native work items |
| `dynamicData[]` | `{kind, providerCandidates, refreshFrequency, notes?}`: candidates only; adapters own real integration. `kind`: scores, schedules, standings, statistics, rankings, rosters, events, releases, conditions, news, weather, closures, alerts, new-products, new-media, injuries, transactions, regulations |
| `editorial` | What Swoon'd does with current commentary (explain and link; never copy) |
| `personalizationDimensions[]` | Team, driver, artist... Enum: team, player, driver, league, series, artist, genre, author, region, equipment, destination, franchise, platform, cuisine, director, brand, style, skill-level, era, designer, actor, studio, format, festival, venue (last seven from 1.2) |
| `conversationScenarios` | Count and path (curriculum `talkTracks[]`) |
| `masteryModel` | `concept-mastery-v1`, pass threshold, competence statement |
| `licensingConstraints[]`, `safetyConstraints[]` | Rights and safety rules for content and assets |
| `relatedCourses[]` | Result of the section 6 boundary test |

## Rules

1. Write the CDS first; the manifest is derived from it.
2. `unitySimulations[].specPath` files must exist before `status` moves beyond `planned`.
3. Every `interactionTypes` entry must be justified in the CDS "Interaction plan".
4. Do not invent dynamic data needs (spec section 10).
5. Validate: `node tools/validate/validate.mjs`. The validator also checks that every `unitySimulations[].specPath` exists and that the spec's configuration JSON Schema (json fence under "## 10. Configuration schema") compiles as draft 2020-12. Example: `examples/american-football-sample.json` (illustrative, not the real course).
