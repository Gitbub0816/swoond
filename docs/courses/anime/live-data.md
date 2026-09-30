# Dynamic Data and Editorial Plan: Anime (`anime`)

Spec sections 10-12, 32-40 (media courses) and the manifest `dynamicData`. Swoon'd talks about works; it never redistributes them. Checked 2026-09-30 **[verify at release]**.

## 1. What is dynamic (and what is not)

Anime has a seasonal broadcast calendar but no scores, standings or rosters. Needed: what is airing, where to watch it, what was announced, film releases and awards, events, and the story behind the buzz. Not needed: community scores, ranking tables, per-episode ratings, tracker lists.

## 2. Normalized entities (Swoon'd-owned domain model)

| Entity | Key fields |
|---|---|
| `AnimeSeason` | `seasonId` (e.g. `2026-fall`), `startDate`, `label` |
| `SeriesCard` | `seriesId`, `displayTitle` (romaji and English), `kind` (new, sequel, returning, film), `studio`, `demographic`, `genreTags`, `source` (manga, light-novel, original), `cour`, `eventLine` (our one-line description) |
| `AvailabilityRecord` | `seriesId`, `region`, `serviceName`, `type` (simulcast, catalogue, purchase), `asOf` |
| `EventCard` | `kind` (convention, festival, awards, film release), `name`, `dates`, `location`, `officialUrl` |
| `BuzzExplainer` | `seriesId`, `whyTalking` (our own words), `sourceLinks[]`, `asOf`, `spoilerLevel` |
| `IndustryNote` | `headline` (our own), `explainer`, `sourceLink`, `asOf` |

Provider DTOs are internal to each adapter (D-004). No artwork field exists on any entity.

## 3. Provider candidates (behind adapters)

| Need | Candidate | Terms and notes | Fallback |
|---|---|---|---|
| Season chart | Swoon'd editorial curation (primary) | Our own data; no dependency | n/a |
| Title metadata and IDs | Wikidata (CC0), Wikipedia (CC BY-SA, attribution) | Allowed | Curated records |
| Title metadata (richer) | AniList API | Free non-commercial; under ~$150/month revenue free without permission; above that a commercial licence; no mass collection, no storage as a backup, no use in competing trackers. **Not a launch dependency.** | Wikidata |
| MyAnimeList | Official MAL API | Non-commercial licence, forbids scraping. **Not used.** Jikan is an unofficial scraper and breaches MAL terms: never use in production (spec section 39 principle). | None |
| Kitsu | Kitsu API | Docs are Apache-2.0; commercial data terms unclear. Contact before use. | Wikidata |
| Availability | Watchmode, Movie of the Night, JustWatch partner API | Commercial plans; attribution rules per provider | Hide availability |
| Events, awards | Curated from official pages; Wikidata | Link-only | Hide card |
| Film box office | Curated top-line from public reporting | Attribution; no mirrored tables | Omit |
| News | Publisher RSS (link-only where licence allows) | OPEN_QUESTIONS L-01 | Curated weekly note |

## 4. Refresh cadence

| Data | Cadence |
|---|---|
| Season chart | Weekly; daily in the first two weeks of a season (Jan, Apr, Jul, Oct) |
| Availability | Daily |
| Releases and announcements | Weekly |
| Events | Weekly; daily in convention and awards weeks |
| News and buzz explainers | Daily |

## 5. Editorial plan

Explain in our own words and link; never copy publisher text or synopses. Examples: "Why is everyone talking about this sequel?" (what it continues, why fans care, spoiler-free); "What does cour 2 mean?"; "Why the adaptation debate?". Spoiler level defaults to none. Current fall 2026 lineup facts (for example returning series and premiere dates) are examples for editorial and are **not** hard-coded in lessons. Each explainer stores `asOf`.

## 6. Personalization hooks

`{{franchise}}` (returning-series cards, tie-in films), `{{genre}}` (which season picks lead), `{{platform}}` and `{{region}}` (availability cards and delay explanations), `{{studio}}` (studio news). Unset: show the generic season overview and hide availability. Discreet mode: notifications (for example "New episode of her show") never name the Person.

## 7. Licensing rules (spec section 40)

- No posters, key art, stills, PV embeds, OP/ED audio, lyrics or voice clips.
- Titles and names are text facts; logos are text-only.
- Link out to official channels; never to unlicensed sources.
- Community scores and lists (AniList, MAL, Kitsu) are link-out only.

## 8. Fallbacks

Provider down: show the last cached chart with its `asOf` date and a "last updated" line; hide availability. Lessons never depend on live data; the `this-season` unit regenerates from templates.
