# Sim Spec Template

Copy to `docs/courses/<course-id>/sims/<simulationId>.md`. Every Unity minigame spec MUST follow this structure and numbering (Astra reads by section number). Replace guidance text; delete nothing. Write "None" or "N/A: reason", never leave a section blank. Unresolved items go in section 23.

A spec is "ready for Astra" when the CDS marks the activity as Unity, this spec is complete, and the manifest lists it with `status: spec-approved`.

---

# <Sim title> (`<simulationId>`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `<simulationPrefix>.<topic>.<name>.v1` (kebab-case segments) |
| simulationVersion | `1.0.0` (major equals the `.vN` in the id) |
| Spec status | draft / approved / superseded |
| Contract versions | Bridge `1.x`, sim-definition `1.x` (if data-driven) |
| Authors / date | |
| Changelog | one line per version |

## 2. Course & lesson links
- `courseId`, `unitId`, `lessonId`(s) that launch this sim; link to the CDS "Interaction plan" row.
- Manifest entry path: `docs/courses/<courseId>/manifest.json` -> `unitySimulations[]`.
- Prerequisite concepts (must be `mastered` or the lesson shows a primer first).

## 3. Learning objective(s) & concepts taught
- Learner-facing objective: "You can ..." (1-2 sentences).
- Table of **conceptIds** taught/tested (must exist in the curriculum `concepts[]`): `conceptId | term | what the learner should be able to do after`.
- What the learner should NOT need to learn here (scope limit).

## 4. Why Unity (tier justification)
Answer the rubric explicitly (CLAUDE.md "Tier rubric"): which of spatial reasoning / movement / physics / timing in a scene / camera perspective materially improves learning; why a native exercise (list the closest native type) would teach it worse. If the justification is weak, propose a native exercise instead.

## 5. Player fantasy & core loop
- One sentence fantasy ("You are the quarterback reading the defense").
- Core loop as a numbered list, following the Swoon'd loop: prompt -> one decisive interaction -> execute -> freeze/explain -> line you could say out loud. One mechanic per game.
- Session length target (about 3 minutes, 3 rounds by default).

## 6. Scene & entities
- Environment (procedural key from the registry, e.g. `football_field`), camera presets used.
- Entity table: `id | Game Kit primitive / sport module | role | key parameters`.
- Which primitives are reused vs new (new ones need justification and reuse plan).
- Diagram (ASCII or image) of the initial layout.

## 7. Controls (touch)
- Per input: gesture, target, hit size (>= 44 pt), feedback. Alternative accessible control scheme (tap-only).
- Safe-area and orientation (portrait unless stated).
- What native UI is NOT drawn by Unity (paywall, hearts sheet, exit confirmation).

## 8. Step-by-step flow with states
State machine table: `State | Entry condition | What happens | Exit condition/next`. Minimum states: Loading, Intro, Playing, Decision, Executing, Freeze, Explain, Summary, Done, plus Paused and Aborted handling. Show bridge events emitted at each state (`ready`, `progress`, `checkpoint`, `result`, `requestExit`).

## 9. Difficulty levels 1-5
Table of parameters by level (values, not adjectives): e.g. time limit, number of distractors, hint availability, speed, tolerance, scenario pool tags. Level 1 must be passable by a true beginner with hints. State which level the lesson defaults to.

## 10. Configuration schema
JSON Schema (draft 2020-12) fragment for `LaunchRequest.configuration`, with defaults and ranges. Include at least `seed` (integer, optional) and `scenarioSetId`. Provide one valid example configuration. Invalid configuration yields `error CONFIG_INVALID`.

```json
{ "$schema": "https://json-schema.org/draft/2020-12/schema", "type": "object", "properties": {}, "additionalProperties": false }
```

## 11. Scenario data set
Describe the scenario data (format, file, count). **At least N scenarios** (N = rounds x 3 minimum for replay variety; state N). Table: `scenarioId | setup | correct decision | teaches conceptId | difficulty tags`. Provide the first 3 fully written; the rest may be summarized with clear generation rules. Note whether scenarios are deterministic per seed.

## 12. Freeze / explain moments
For each explain moment: trigger, what freezes, camera, callouts (what is highlighted and where), and the **exact explanation copy** (Title <= 6 words, body <= 45 words, plus optional "say this" line in quotes). Voice: cheeky coach, never mean, short sentences (DESIGN_SPEC section 2). Provide copy for both correct and incorrect outcomes.

## 13. Scoring & mastery signals
- Score formula (0-100), accuracy definition, per-round outcome ids.
- **Mistake -> conceptId mapping table:** `mistake | conceptId | description text`.
- **Mastery signals:** `event | conceptId | delta (-1..1) | evidence text`. Per-session caps.
- Mapping to `SimulationResult` fields (`outcomes[]`, `mistakes[]`, `masterySignals[]`).

## 14. XP & hearts
- `xpEarned` proposal formula (native clamps to lesson budget: default +10 per correct round, +40 for finishing).
- `heartsLost` rule (e.g. 1 per failed round, max 1 per session).
- Behavior of `replayAvailable`.

## 15. Failure states
Failed round, failed session, timeout, abort, backgrounded, asset missing, invalid config. For each: what the learner sees, what result fields are set, and whether hearts are lost. Failure must always teach (explain moment), never dead-end.

## 16. Accessibility
Reduced motion behavior (cuts instead of sweeps, no shake), haptics off, color-blind modes (second channel for every color meaning), text scale, tap-only alternative, VoiceOver/TalkBack note (Unity content is limited; provide an accessible native fallback lesson if the sim cannot be made accessible: name it).

## 17. Audio & haptics
Cue list: event, sound, haptic (light success / warning / soft tap), volume; all honor `soundEnabled` and `hapticsEnabled`.

## 18. Art & asset list
Table: `asset | procedural or external | source & license | tris / texture / size | notes`. Default is procedural. Overlay styling per `ART_DIRECTION.md`. Addressables bundle name and expected size.

## 19. Performance budget
Restate the defaults from `docs/astra/README.md` and list any tighter per-sim limits: fps, memory (< 150 MB), cold launch (< 2 s), bundle size, draw calls, triangles.

## 20. Telemetry
Which diagnostics go in `telemetry` (fps, load, memory, plus sim-specific counters such as `hintsUsed`, `decisionLatencyMs`). No personal data.

## 21. Acceptance criteria (testable)
Numbered, each testable by an EditMode/PlayMode test or a measured check: e.g. "AC-1: With seed 42 and difficulty 2 the sim emits exactly 3 `outcomes`." Include bridge conformance, budget, accessibility and copy-length checks.

## 22. Test plan
- **EditMode:** logic (objective evaluation, coverage assignment), config validation, result schema validity, scoring maths, determinism by seed.
- **PlayMode:** scene builds from code, full run with scripted inputs, freeze/explain sequence, pause/resume/abort, reduced-motion path.
- **Perf:** measured run on iPhone 13-class.
- Table: `AC id | test type | test name`.

## 23. Open questions
`# | Question | Owner (Claude / Astra / Product) | Blocking?` Everything ambiguous above must appear here.
