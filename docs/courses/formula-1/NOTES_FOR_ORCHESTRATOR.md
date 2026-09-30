# Notes for the orchestrator: Formula 1 (`formula-1`)

Nothing outside `docs/courses/formula-1/` was edited. Items below are suggestions for shared files or decisions; each is owned by the orchestrator or product owner.

## 1. Shared-file changes suggested

| File | Suggested change |
|---|---|
| `docs/courses/CATALOG.md` | Set `formula-1` status to `cds-draft` (manifest `status` is `cds-draft`); note simulation prefix `f1` and that branches are team paths (11 teams). |
| `docs/astra/GAME_KIT.md` | Register the additions requested by the six F1 sims (section 3 below) and the new environment keys `f1_corner_track`, `f1_straight_and_braking`, `f1_lap_oval_abstract`, `f1_race_topdown`. Add a "Racing (2026 era)" module section. |
| `docs/product/DECISIONS.md` | Suggest entries: (a) F1 branches are team paths, not leagues; (b) F1 uses no team logos, liveries, driver likeness, photos or FOM audio, and does not use listening-id; (c) the "golden generator" pattern for data-driven sims (reference values generated offline by a checked-in tool and committed as fixtures); (d) Jolpica-F1 (CC BY-NC-SA) and OpenF1 (non-commercial) are not usable in production without commercial permission. |
| `tools/validate/validate.mjs` | Extend to (1) parse the first fenced ```json block under "## 10. Configuration schema" in each sim spec and validate example `configuration` objects in the curriculum against it (bridge README open question); (2) check `manifest.unitySimulations[].lessonIds` exist in the curriculum once authored; (3) check every `mastery`/`conceptId` mentioned in sim specs exists in the curriculum `concepts[]`. The six F1 specs follow this heading and fence convention. |
| `docs/contracts/curriculum/v1` | No per-branch data or per-lesson `branchId` exists. F1 personalizes by team via `{{team}}`, `{{driver}}`, `{{region}}` tokens and a default fallback (Ferrari, Charles Leclerc, Monza). Team-specific facts (history beats, current line-up, engine supplier) need a data pack: propose an optional `personalizationData` object (or a `team-packs/*.json` content-pack file keyed by branch id) validated by a small schema. Not blocking; the templated unit `team-story` works with generic fallback until then. |
| `docs/native-exercises/CATALOG.md` | No change needed. F1 uses 12 of 13 types; `listening-id` is deliberately unused. |

## 2. Game Kit additions requested (for Astra)

- **Objective / demonstrate / overlay types:** Objective `shape_path` (learner edits a Path through anchored Targets); demonstrate types `speed_trace`, `value_ribbon`, `gap_chart`, `order_strip`; overlay style `wing_schematic`; Draft overlay style `wake_cone`.
- **TouchController:** scheme `drag-handles` (axis-constrained drags: lateral-only and along-edge-only).
- **Racing module (2026 era):** `DirtyAir`, `Overtake` (deployment taper model), `ActiveAero` (wing state and actuation), `EnergyStore` (battery with deploy, regen and clip), `RaceSim` (deterministic lap-by-lap engine with tyre model, pit loss, neutralisations, pass-margin rule).
- **Data-driven authoring:** every F1 sim expects a checked-in golden generator (exhaustive search or optimiser) that writes reference values to fixtures; the specs list indicative values from the author's prototype, marked non-normative.

## 3. Native fallback lessons implied by the sim specs (accessibility)

Each spec section 16 names a separate designed native lesson for learners who cannot use the Unity sim. They are not counted in the 106 planned lessons and need curriculum authoring: `ct-04-alt-racing-line-diagram`, `rc-02-alt-tow-diagram`, `r26-04-alt-wing-modes`, `r26-06-alt-energy-plan`, `tp-07-alt-undercut`, `sd-04-alt-safety-car`.

## 4. Structural observations

- The course has 15 units (5 foundations, 4 intermediate, 3 enthusiast, and one each for the live, conversation and review layers) and 106 lessons; that is above the "roughly 8-14 units" guide, driven by the template minimums (4+ foundations, 4+ intermediate, 3+ enthusiast, plus the three perpetual layers). Team packs are a single templated unit rather than 11 branch units.
- The conversation layer plans 30 standalone talk tracks (manifest `conversationScenarios.count`) plus 31 talk-track activities embedded in lessons; `exercises.md` has 10 fully written and schema-valid tracks (ids are assigned by the curriculum author; the schema payload has no id field).
- Manifest `nativeExercises[].estimatedCount` and the CDS Interaction plan counts are generated from the same lesson data (tallies of planned activity items), so they are consistent.

## 5. Facts to re-verify before release

Verified by web search on 2026-09-30 (see `live-data.md` section 11 for the snapshot): 2026 technical regulations (no MGU-H, MGU-K up to 350 kW, ICE about 400 kW, ~50/50, 100% sustainable fuel, active aero with Straight Mode and Corner Mode, Overtake Mode within one second, 768 kg minimum weight), the April 2026 mid-season package, the compression-ratio ruling, ADUO checkpoints, the 23-round calendar with the Saudi GP cancelled and the Bahrain GP relocated to Sepang, the grid, and the standings after round 15. Not independently confirmed and flagged in the CDS: the exact FIA rules for where Straight Mode may be activated (circuit-specific zones) and low-grip restrictions; the exact 2026 cost-cap figure (about 215 million dollars with carve-outs); details of Cadillac's and Audi's programmes; commercial terms of Orange Cat Blacktop, API-Sports and SportMonks.

## 6. Validator result

`cd tools/validate && node validate.mjs` passes with `docs/courses/formula-1/manifest.json` valid (see the orchestrator report for the counts). Curriculum JSON has not been authored (out of scope for this task); the payload samples in `exercises.md` were validated separately against `docs/contracts/native-exercises/v1/*.schema.json` (47 blocks, 0 invalid).
