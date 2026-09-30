# Notes for orchestrator: Anime

## Shared-file change requests
1. `docs/courses/CATALOG.md`: set `anime` status to `cds-draft`, notes column: "Native only; zero Unity; licensing-sensitive".
2. Manifest `personalizationDimensions` includes `studio` (allowed by schema); no schema change needed.
3. Manifest `relatedCourses` uses `sibling-independent` for `k-pop`.
4. Suggest adding `anime` to `movies` and `horror-films` cross-link tables (horror-films already lists it).

## Open questions / decisions
- Commercial route for metadata: stay curated plus Wikidata at launch, or seek an AniList commercial licence (above about $150 per month revenue). Do not use Jikan (unofficial, breaches MAL terms).
- Kitsu commercial data terms unclear; confirm before any use.
- Streaming availability provider and commercial terms.
- News provider (OPEN_QUESTIONS L-01).
- Human sensitivity review for mature-theme lessons (`gt-08`, `cr-06`, `sp-04`, `db-04`) and Kyoto Animation history lesson (`st-03`).
- Audio: commission honorific pronunciation clips (original-swoond).

## Facts to re-verify at release (checked 2026-09-30)
- Streaming landscape: Crunchyroll (largest simulcast catalogue), HIDIVE (MBS deal), Netflix (originals, some weekly), Prime Video channels, Hulu. Catalogues change often.
- Fall 2026 season began 2026-09-25 (Netflix weekly release); premieres 2-4 October reported; do not hard-code.
- AniList terms ($150/month revenue threshold) and MAL API licence.
- Studio facts (MAPPA, ufotable, Kyoto Animation, Ghibli) and industry workload/AI debates.
- The "Big Three" and "new big three" labels and current flagship series.

## Status
Curriculum JSON not written (per guide). `sims/` is empty by design: zero Unity sims.
