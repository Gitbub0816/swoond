# Notes for orchestrator (pickleball)

1. **CATALOG.md**: set `pickleball` status to `cds-draft` (manifest already says `cds-draft`). Boundary note could mention tennis adjacency is cross-link only. No other shared-file change required.
2. **Curriculum JSON not authored** (`curriculum/pickleball.0.1.0.json`); manifest `conversationScenarios.path` points there. The CDS section 11 has all 15 units / 107 lessons / 150 concept ids ready to convert; `exercises.md` has 50+ validated payloads and 9 talk tracks.
3. **Game Kit additions requested (Astra)**, shared by all 5 sims: `Court` module (pickleball) + `pickleball_court` environment key; `Serve` helper; `Formation` helper; objective `reach_zone_by_event`; `SlowMotion.Window(realSeconds)` utility. `maintain_proximity` (existing) is reused by court-coverage.
4. **Validator**: does not yet check sim spec paths or per-sim `configuration` against spec schema fragments (bridge README open question). Sim specs each contain a config schema fragment ready for that extension.
5. **Facts to re-verify before content ships** (flagged in CDS/live-data): 2026 rulebook "visible second ball" fault wording; USA Pickleball spin-rate test (Oct 1, 2026, threshold reportedly under 2,100 RPM); DreamBreaker rotation details; Olympic status; 2026-27 PPA calendar. Web sources were secondary media plus the USA Pickleball rulebook change document.
6. **Cross-course**: `relatedCourses` lists `tennis` (not yet authored); ensure the validator/catalog tolerates a course id without a folder.
7. **Licensing**: no tour/team/brand logos or player photos planned; audio is original foley (needs recording or synthesis).
