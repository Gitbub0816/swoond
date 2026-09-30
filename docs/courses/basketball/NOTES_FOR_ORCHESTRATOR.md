# Notes for the orchestrator: Basketball course

Nothing outside `docs/courses/basketball/` was edited. Items below are proposed changes to shared files and observations.

## 1. Shared-file updates to apply

1. **`docs/courses/CATALOG.md`:** set `basketball` status to `cds-draft` (manifest says `cds-draft`). Update the boundary note to "Foundation; NBA (default), WNBA and College (men's and women's, one branch) are branches."
2. **`CLAUDE.md` section 13 (current status):** Basketball CDS, manifest, 6 sim specs, exercises plan and live-data plan written; curriculum JSON not yet authored.
3. **`docs/astra/GAME_KIT.md` section 2 ("Court & field sports (future, name reserved)"):** the Basketball module is now specified (first use in `sims/basketball.spacing.floor-spacing.v1.md` section 6.1): `Swoond.Sports.Basketball` with `Court` (half/full, feet coordinates, league arc variants), `PlayerRole`, spot registry; plus `SlotPlacement` (TouchController), `Highlight` distance-ring variant, `Replay.Seek/Step` + `ReplayScrubber`, `Zone.ContainsFoot` + foot markers, `ZoneShell`, `BreakDefender`, `Coverage` and `ScreenAction`. Registry keys requested: environments `basketball_half_court`, `basketball_full_court`; objective types `place_and_resolve`, `read_and_choose`, `judge_frame`, `rotate_and_close`, `choose_at_line`, `find_gap`; demonstrate types `help_gap_overlay`, `coverage_cue`, `foot_contact_overlay`, `zone_shift_overlay`.
4. **`docs/product/DECISIONS.md`:** suggested entry "Basketball branches: `nba` (default), `wnba`, `college` (men's and women's share one branch; the two differ in halves vs quarters); international basketball is a roadmap branch."

## 2. Contract observations (no changes made)

- **Layer enum:** the curriculum schema has no "branch" layer. Plan: `branch-college` and `branch-wnba` use `layer: intermediate` (or `enthusiast`) with `branchId` set to `college` / `wnba`; the CDS keeps "Branches / personalization" as its own row. Please confirm.
- **`live` block is per unit** (`dataKind`, `refreshHint`, `adapterKey`), but `live-data.md` defines hooks per lesson (e.g. `live.standings.playin`). Proposal: the unit `live.adapterKey` names the primary hook; lesson-level hooks become `adapterKey` sub-keys or extra fields. Also `league-machine`, `branch-*` and `eras-culture` (`era-08`) have live callouts although they are not `current-season` units; the schema text says "Present on current-season/live units" but does not forbid it.
- **`dynamicData.kind` enum** has no `injuries` or `transactions`; both are mapped to `rosters` in the manifest with a note. Consider adding them (minor version).
- **Lesson objectives** in the CDS are written as imperatives ("Explain ..."); the curriculum contract wants learner-facing "You can ...". Curriculum authors should convert.
- **Talk tracks:** the CDS plans 24 standalone `talkTracks[]` (manifest `conversationScenarios.count: 24`), plus 31 embedded talk-track activities in lessons.
- **Validator extension (bridge README open question):** each sim spec section 10 contains a JSON Schema fragment and one valid example configuration; these were checked with ajv while generating the specs. A CI step could extract them from `sims/*.md` fenced `json` blocks under "## 10. Configuration schema".

## 3. Validator state

`cd tools/validate && node validate.mjs` reports `docs/courses/basketball/manifest.json` as ok. At the time of the run the overall command failed on another course (`docs/courses/american-football/curriculum/curriculum-u01-u04.json`, activity `back-seven-04-*` payload errors); that is not a Basketball file.

## 4. Requests for the native app (Claude Code) derived from this course

- Procedural diagrams: `bball-half-court`, `bball-full-court`, `bball-shot-zones`; coordinate convention documented at the top of `exercises.md` (x sideline to sideline over 50 ft, y from half-court line to baseline over 47 ft; rim at (0.5, 0.888); lane x 0.34 to 0.66; free-throw line y 0.596).
- `visual-id` uses original referee-signal illustrations (license id `swoond-original-illustration`, bundle path `illustrations/`). The license id must exist in the content-pack license registry; the illustrations themselves still need to be produced.
- Rules that differ by branch (shot clock, fouls, halves vs quarters, ball, arc) are tagged by branch so an NBA learner is not asked college-only rules. The curriculum loader needs branch-conditional activity filtering (activity-level `branchId` or per-lesson variants); the current schema supports `branchId` on units only. Proposal: allow `branchId` on activities (minor, additive).

## 5. Decisions and reviews needed from the product owner

1. **Q-3 news provider** (blocks automation of the editorial layer only).
2. **"March Madness" trademark:** legal review before using it in copy; CDS and manifest use "NCAA tournament" in chrome until then.
3. **Basketball SME review** of the reference models before Astra starts (spacing resolver, pnr verdict table, help penalties, zone shift model) and a **referee SME** on the charge/block rule engine (secondary defender in the arc, stationary: play on vs block). All six sim specs are `spec-draft`, not `spec-approved`.
4. **Launch timing:** the 2026-27 NBA season opens on 20 October 2026; the CDS release plan targets 0.1 before it if possible.
5. **Unit count:** the map has 15 units: 11 core content units (4 foundations, 4 intermediate, 3 enthusiast), 2 branch units (college, WNBA), the perpetual live unit and the perpetual Conversation Lab. The brief said roughly 8-14; the extra is one unit. Merge options exist if you prefer 14 (for example fold `analytics` into `strategy`).

## 6. Time-sensitive facts used (verified 2026-09-30 by web search; re-check at release)

Knicks won the 2026 NBA Finals 4-1 over the Spurs (Brunson Finals MVP); Shai Gilgeous-Alexander won the 2025-26 MVP; Knicks won the 2025 NBA Cup; 2026-27 opening night 20 October 2026; 2025-26 cap thresholds (cap $154.647M, tax $187.895M, first apron $195.945M, second apron $207.824M); WNBA 2026 expansion (Portland Fire, Toronto Tempo), new CBA (cap about $7.0M, first-year max about $1.4M, 44 games in 2026), playoffs started 27 September 2026; NCAA 2026: Michigan (men) and UCLA (women); men's college basketball still plays halves in 2025-26 and 2026-27 (quarters under discussion); NBA Europe targeted for October 2027 (unconfirmed). None of these are hard-coded in lessons; they live in `live-data.md` section 9 and `CDS.md` section 3.6.

One item deliberately left for review: the exact NBA shot-clock reset wording after an offensive rebound (14 seconds) and its edge cases (CDS open question 10); the sample item states only the widely reported rule.
