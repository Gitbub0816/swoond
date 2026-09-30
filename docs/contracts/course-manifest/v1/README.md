# Course Manifest Contract v1

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
| `dynamicData[]` | `{kind, providerCandidates, refreshFrequency}`: candidates only; adapters own real integration |
| `editorial` | What Swoon'd does with current commentary (explain and link; never copy) |
| `personalizationDimensions[]` | Team, driver, artist... |
| `conversationScenarios` | Count and path (curriculum `talkTracks[]`) |
| `masteryModel` | `concept-mastery-v1`, pass threshold, competence statement |
| `licensingConstraints[]`, `safetyConstraints[]` | Rights and safety rules for content and assets |
| `relatedCourses[]` | Result of the section 6 boundary test |

## Rules

1. Write the CDS first; the manifest is derived from it.
2. `unitySimulations[].specPath` files must exist before `status` moves beyond `planned`.
3. Every `interactionTypes` entry must be justified in the CDS "Interaction plan".
4. Do not invent dynamic data needs (spec section 10).
5. Validate: `node tools/validate/validate.mjs`. Example: `examples/american-football-sample.json` (illustrative, not the real course).
