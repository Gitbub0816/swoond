# Dynamic Data and Editorial Plan: Movies (`movies`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-37 (provider isolation, news) and, above all, **section 40 (media courses: talk about works, never redistribute them)**. Facts and provider terms below were checked by web search on **2026-09-30** and are tagged **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Yes, moderately, and it is mostly editorial.** Movies has no scores or play-by-play. What changes weekly is: what opens, what the box office story is, what streams, where the awards race stands, what a festival just crowned, and what the industry is arguing about (mergers, windows, strikes, rules). That is a **thin structured layer** (release calendar, awards and festival calendar, box-office top line, streaming availability) plus a **strong editorial layer** ("Why is everyone talking about this film?"). A learner who ignores it still finishes the evergreen course; the live layer keeps it feeling current.

Do not invent more (spec section 10): no ratings dashboards, no stats leaderboards, no per-actor data, no "trending" algorithm, no showtime scraping.

**Hard rule:** the live layer never stores or displays posters, key art, stills, trailers, clips, score or dialogue, and never copies synopses, review text or headline body text. Titles, names, dates, numbers and Swoon'd-authored sentences only, plus link-outs.

## 2. Current-context layers

| Layer | Who sees it | What it is |
|---|---|---|
| This week at the movies | Everyone (default branch `mainstream-franchise`) | Weekend box-office story, new wide releases, what people will ask about; text cards with link-outs |
| Awards season | Everyone from September to March; heavier for learners who follow awards | Calendar position, the frontrunner narrative, snubs and upsets; ceremony-day explainers |
| Festival dispatch | Everyone in festival months; heavier for `auteur-arthouse` | What Cannes, Venice, TIFF, Sundance, Berlin just premiered and won; why it matters |
| Where to watch | Everyone, with `platform` set for accuracy | "Where can I stream this?" availability, licensed provider only |
| Industry explainers | Everyone | Mergers, windows, strikes, AI rules, in Swoon'd's words |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to evergreen explainers ("How to read a box-office chart", "How awards season works") |

## 3. Data kinds, providers, refresh

External providers never become the domain model (spec section 32): Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. Every candidate below sits behind a Swoon'd adapter.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules` | Release calendar, festival dates, awards dates | **Swoon'd curated calendar** (editors verify from studio, festival and Academy pages); Wikidata (CC0); TMDB only under a written commercial agreement | Curated at launch; adapter for Wikidata SPARQL later | weekly | Last published calendar with date shown |
| `releases` | New wide releases and streaming premieres | Curated editorial list; TMDB (commercial licence); Gracenote or comparable enterprise metadata (upgrade path) | Curated at launch; licensed adapter after L-13 | weekly (Tue-Thu) | Evergreen "how to pick a movie" card |
| `rankings` | The Monday box-office top-line story | Curated attributed top-line facts; The Numbers or Comscore data by licence (no public API); Box Office Mojo has no API | Curated at launch; no mirrored tables | weekly (Mon) | Static "how to read a box-office chart" card |
| `events` | Awards and festivals: nominations, winners, prizes | Official Academy, BAFTA, Golden Globes, Actor Awards and festival press pages (curated); Wikidata (CC0); Wikipedia (CC BY-SA, attribute) | Curated with source links; adapter to Wikidata for historical winners | daily in awards weeks, weekly otherwise | Last season's winners as evergreen history |
| `new-media` | Where to watch | Watchmode (commercial plans, credit-based), Streaming Availability API (Movie of the Night), JustWatch partner API, TMDB watch providers (commercial licence, must credit JustWatch) | Adapter with provider behind flag; cache within terms | daily | Hide availability; offer "check your services" |
| `news` | Why a story matters | Publisher RSS headlines (link-only, where the licence allows); official studio/awards press pages | Link-only ingestion of titles and URLs; Swoon'd writes the explainer (L-01) | daily | Evergreen explainers |

### Provider terms (checked 2026-09-30) [verify at release]

| Provider | What it offers | Terms relevant to a paid consumer app | Decision |
|---|---|---|---|
| **TMDB API** | Rich film/TV metadata, images, cast/crew, watch providers (JustWatch data) | Free only for **non-commercial** use with attribution; **commercial use needs a written agreement** (contact TMDB); notice required: "This product uses TMDB and the TMDB APIs but is not endorsed, certified, or otherwise approved by TMDB" plus approved logo in About/Credits; **no caching beyond 6 months**; **no use with AI/ML-based applications or for training**; no sublicensing; watch providers must credit JustWatch; images belong to rights-holders and are not to be used as an image host | **Not used in production** before a commercial agreement (L-13). Also conflicts with our no-poster rule and our use of AI in content tooling, so at most metadata text under a licence. |
| **OMDb API** | IMDb-derived metadata, posters, ratings | **CC BY-NC 4.0**: no commercial use, even with paid Patreon tiers | **Not usable** |
| **IMDb datasets** | TSV dumps | Personal and **non-commercial** use only; no republishing or building a database | **Not usable**; IMDb offers licensed data via a paid commercial route (AWS Data Exchange class): candidate only after cost review |
| **Letterboxd API** | Film metadata, member activity | Access by request only; **not granted** for recommendation, LLM/GPT, data-analysis, visualization, private/personal projects or for recreating paid-tier features | **Not usable** at present; deep-link to Letterboxd only |
| **Rotten Tomatoes / Metacritic** | Aggregated review scores | No public API; scores and blurbs are provider-owned | Link-out only; a dated hand-verified top-line number as fact at most |
| **Watchmode** | Streaming availability (US and other regions) | Free developer plan is non-commercial (about 2,500 credits/month); paid commercial plans exist [verify pricing and terms at contracting] | Candidate for `new-media` |
| **Streaming Availability API (Movie of the Night)** | Availability across services | Commercial licensing to confirm with the vendor | Candidate; verify |
| **JustWatch partner API** | Availability data and deep links | Partner agreement; attribution | Candidate |
| **Wikidata** | Structured film, festival, award facts | **CC0** (public domain dedication) | **Allowed** for facts (dates, winners, IDs), with quality checks |
| **Wikipedia text** | Prose | **CC BY-SA**: attribution and share-alike | Use for fact-checking only; do not copy prose |
| **Box office data (The Numbers, Comscore, Box Office Mojo)** | Weekend, domestic and worldwide grosses | Commercial licence required; Box Office Mojo (IMDbPro) has no public API | Curated top line with attribution until licensed (L-14) |
| **Showtimes (Fandango, Gracenote, theatre chains)** | Local showtimes | Enterprise licences only | **Out of scope.** Deep-link to theatre pages. |

Consequence: at launch the live layer is **curated editorial content plus Wikidata**, delivered as `live` cards that ship without an app release. Automation can be added per data kind when a commercial agreement exists.

## 4. Normalized entities

Swoon'd-owned; no provider schema leaks (spec section 32, rule 8). Fields are facts and short Swoon'd-authored text only.

| Entity | Fields | Notes |
|---|---|---|
| `Film` | `id` (Swoon'd), `externalRefs` (`wikidata`, `providerIds` optional), `title`, `year`, `directorNames[]`, `runtimeMin`, `genres[]`, `releaseDates[]` | **No** `posterUrl`, `stillUrl`, `trailerUrl`, `synopsis`. `blurb` is Swoon'd-authored, <= 140 chars. |
| `ReleaseCard` | `filmId`, `openDate`, `platform`, `whyItMatters` (authored), `links[]` (official page, trailer page link-out) | Text only; link-outs open the studio's own page |
| `BoxOfficeStory` | `weekendOf`, `topLine` (authored), `keyNumbers` (attributed, dated), `sourceLinks[]` | No mirrored table |
| `AwardsEvent` | `season`, `body` (academy, bafta, globes, actors, festival), `stage` (nominations, ceremony, winners), `date`, `sourceLinks[]` | Dates from official pages |
| `AwardsResult` | `eventId`, `category`, `winnerFilmId` or `winnerName`, `verified` | Only after official announcement |
| `FestivalResult` | `festival`, `year`, `prize`, `filmTitle`, `directorName` | Official announcement |
| `Availability` | `filmId`, `region`, `services[]`, `asOf` | From the licensed provider; expires in 24 h |
| `ExplainerCard` | `topic`, `headline` (authored), `body` (authored), `sayThisLine`, `sourceLinks[]`, `expiresAt` | Written by a Swoon'd editor; the "Why is everyone talking about this?" card |

## 5. Refresh cadence and freshness

| Data | Cadence | Freshness rule |
|---|---|---|
| Box-office story | Monday morning (US) | Replace weekly; keep the previous week for two weeks |
| Release calendar | Weekly; daily during a big release week | Films shown within 14 days of release |
| Awards events | Daily during nominations, precursor and ceremony weeks; weekly otherwise | Results only after the official announcement |
| Festival dispatch | Daily during the festival, weekly for two weeks after | Prizes only after the official announcement |
| Availability | Daily | Expires in 24 h |
| Explainers | 3-5 per week; extra on awards days | Each card has `expiresAt`; never shown as current after it |
| Time-sensitive concept facts | Each curriculum concept with a live fact has a 90-day freshness flag | Re-verified before appearing in review |

## 6. Editorial plan (spec sections 11, 37)

- **Approach:** explain in our own words, and link (manifest `editorial.approach = explain-and-link`). Never copy publisher text, critic reviews or synopses.
- **Voice:** cheeky coach, short sentences, one joke per card, never mean about a film, a fandom or a person; never about the crush.
- **Card templates** (each has a headline <= 8 words, a body <= 45 words, one "say this" line, up to two link-outs):
  1. *Why is everyone talking about this?* (a film, a casting choice, a release-date move)
  2. *What this number means* (box office, budget, legs)
  3. *Awards explainer* (a snub, an upset, what the frontrunner label means this week)
  4. *Festival dispatch* (what premiered, what won, why it matters in January)
  5. *Industry explainer* (a merger, a windows change, a strike, an AI rule)
  6. *What to watch next* (three text-only suggestions by taste, never a ranking)
- **Sources to link (not copy):** Variety, The Hollywood Reporter, Deadline, IndieWire, Screen Daily, Sight and Sound (BFI), official Academy, BAFTA, Golden Globes, Actor Awards and festival pages, studio press pages.
- **Approvals:** every card is authored by a person or drafted and edited by a person; no auto-published AI card; a checklist runs before publish (facts dated, links live, no copied phrases, no spoilers beyond the first act, ratings mentioned, tone check).
- **Spoiler policy:** cards never reveal endings or twists; they carry a "spoiler-safe" tag; discussion of endings is allowed only in explicitly labelled cards.

## 7. Time-sensitive facts snapshot (2026-09-30) [verify at release]

Not hard-coded in lessons; used as seed content for live cards and for the CDS fact checks.

| Fact | Value (as found 2026-09-30) |
|---|---|
| 98th Academy Awards | Held 15 March 2026, hosted by Conan O'Brien; **Best Picture: *One Battle After Another*** (six Oscars incl. the first Best Casting award); Best Director Paul Thomas Anderson; Best Actor Michael B. Jordan (*Sinners*); Best Actress Jessie Buckley (*Hamnet*); Best Supporting Actress Amy Madigan (*Weapons*). Casting is the first new competitive category since Best Animated Feature (2001). |
| 99th Academy Awards | **Sunday 14 March 2027**; nominations **Thursday 21 January 2027**; eligibility period 1 Jan to 31 Dec 2026; shortlist voting 7-11 Dec, shortlist 15 Dec; nominations voting 11-15 Jan 2027; final submission deadline for general entry 12 Nov 2026. Host reported as Conan O'Brien. |
| Academy rules (recent) | Members must watch all nominees in a category to vote in the final round (98th); generative AI neither helps nor harms nominations, and human authorship is required for screenplays (99th); performers can receive multiple nominations in the same acting category if they land in the top five (99th). |
| Golden Globes 2026 (11 Jan 2026) | Best Motion Picture, Drama: *Hamnet*; Musical or Comedy: *One Battle After Another*. |
| Actor Awards (formerly SAG Awards) 2026 | Renamed "Actor Awards presented by SAG-AFTRA"; *Sinners* won the Cast prize; Michael B. Jordan and Jessie Buckley won lead acting. |
| BAFTA 2026 | *One Battle After Another* took top honours (reported alongside the Producers Guild and Directors Guild wins). |
| Cannes 2026 | Palme d'Or: *Fjord* (Cristian Mungiu), Neon's seventh in a row. |
| Venice 2026 | Golden Lion: *Woman Unknown* (May el-Toukhy). |
| TIFF 2026 | People's Choice reported as *La Bola Negra*; early Best Picture talk includes *The Odyssey* and *Project Hail Mary*. |
| Box office 2026 (worldwide, as of Sept.) | *Spider-Man: Brand New Day* about 2.5 billion dollars, *The Odyssey* about 1.75 billion, *Toy Story 5* about 1.15 billion, *Michael* about 1.03 billion, *The Super Mario Galaxy Movie* about 1.01 billion. US summer 2026 reported at a record of about 4.76 billion dollars. |
| Studio landscape | Paramount Skydance agreed to acquire Warner Bros. Discovery (Netflix declined to match in Feb. 2026; WBD shareholders approved in April; DOJ cleared it in May; a state lawsuit paused it in July; a September settlement includes a commitment to release 30 films in theatres a year). Status is fluid: treat as a live explainer, not an evergreen fact. |
| Sight and Sound poll | 2022 critics' poll: *Jeanne Dielman, 23 quai du Commerce, 1080 Bruxelles* (Chantal Akerman, 1975) first, *Vertigo* second, *Citizen Kane* third; next poll 2032. (Evergreen, but re-check if BFI changes cadence.) |

## 8. Personalization hooks

| Dimension | Live effect |
|---|---|
| `director` | Cards note new releases, festival premieres and awards mentions for her director (link-out); explainers use her director as the example |
| `genre` | Weekly "what to watch next" cards skew to her genre; horror learners see the hand-off to `horror-films` |
| `franchise` | Release calendar, trailer link-outs and box-office cards emphasise her universe |
| `platform` | Availability cards and "new to streaming" filtered to her service |
| `region` | Regional cinema focus and local repertory listings (curated, not scraped); dubbing/subtitle norm text |

Unset dimensions fall back to defaults (CDS section 8). Discreet mode: notifications never contain the Person's name.

## 9. Adapter and fallback notes

- **Adapters:** `ReleaseAdapter`, `BoxOfficeAdapter`, `AwardsAdapter`, `FestivalAdapter`, `AvailabilityAdapter`, `EditorialFeedAdapter`, each normalising into the entities in section 4. Provider DTOs are internal to the adapter; nothing exports a provider field such as `poster_path` or `overview`.
- **Failure:** any adapter failure yields the evergreen fallback card; the live unit never blocks progress.
- **Caching:** cache within each provider's terms (for example TMDB: never beyond 6 months; we do not use TMDB at launch). Availability expires in 24 h; box-office and calendar cards expire at their `expiresAt`.
- **No scraping:** no scraping of Rotten Tomatoes, Metacritic, IMDb, Letterboxd, box-office sites or showtimes; no unofficial APIs (spec rule 9, CLAUDE.md section 3).
- **Legal viewing:** availability links go only to licensed services or the studio's official page.

## 10. Open items

| # | Item | Tracked as |
|---|---|---|
| 1 | TMDB commercial agreement vs a different metadata/availability vendor (cost, terms, the AI/ML restriction) | L-13 (proposed) |
| 2 | Box-office data licence (The Numbers, Comscore) or curated-only | L-14 (proposed) |
| 3 | News provider licence (movies default: link-only headlines) | L-01 |
| 4 | Store-copy and lesson-title use of "Oscars", "Academy Awards", "Actor Awards" | L-15 (proposed) |
| 5 | Original film-sound audio sourcing | L-11 |
| 6 | Re-verify every item in section 7 before release and each season | V-09 (proposed) |
