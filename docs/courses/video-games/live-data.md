# Dynamic Data and Editorial Plan: Video Games (`video-games`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-37 (provider isolation, providers, news) and **section 40 (media courses: talk about works, never redistribute them)**. Facts below were checked by web search on 2026-09-30; several hardware and price figures came from secondary aggregator sites and are marked **[verify at release]**. Nothing here is hard-coded in evergreen lessons.

## 1. Verdict: is there meaningful live data?

**Yes, modestly, and mostly editorial.** Games are a media-and-hobby ecosystem, not a scores-first sport. The learner benefits from knowing *what is coming out, what big event is on, what a patch changed, why a price or platform story is being argued about, and who won the tournament she is watching*. They do not benefit from a live ticker, player-count charts or price-tracking dashboards.

Do not invent more: no live match tickers, no odds or betting-adjacent data, no review-score feeds, no sales-chart feeds, no per-player statistics.

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Releases and showcases | Everyone; prioritized by `platform`, `franchise`, `genre` | What is coming out soon, delays, remakes, showcase events, why fans care |
| Platform and price news | Everyone; prioritized by `platform` | Hardware launches, price moves, subscription changes, explained without taking sides |
| Esports layer | `strategy-moba`, `shooters`, `fighting` branches; anyone with `team` or `player` set | This month's tentpoles, brackets, results of finals, "why this match mattered" |
| Patch and season layer | Anyone with a `franchise`/`game` set | What changed in her game's latest patch or season, why fans argue about it |
| Evergreen fallback | Always | If any provider is empty or down, cards fall back to an evergreen explainer ("How a game showcase works") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

External providers never become the domain model (spec section 32): Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. Every candidate sits behind a Swoon'd adapter. No unofficial, reverse-engineered or scraped sources (SteamDB, HowLongToBeat, Metacritic scraping, store-page scraping).

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `releases` | "What's coming out and does it matter?" | Curated editorial calendar from official studio and platform pages; IGDB (Twitch; free for non-commercial only, commercial partner agreement needed, contact partner@igdb.com); RAWG (attribution with active link required; free commercial tier for small apps under ~100k MAU; no redistribution) | **Curated at launch**; adapter to IGDB or RAWG only after licence choice (L-13) | weekly | Last verified calendar with source links |
| `events` | Showcases, sales, awards, esports tentpoles | Official organizer pages (curated); Liquipedia (CC BY-SA 3.0 attribution; the free LPDB API is restricted to non-commercial open-source use; rate limit about 60 requests per hour) | Curated first; Liquipedia only under a commercial agreement | weekly | Verified calendar |
| `schedules` | "When is the match?" for tentpole weeks | Official organizer schedules (curated); PandaScore (paid per game, historical from about 400 EUR per month per game, live basic about 1,000 EUR per month per game; betting use prohibited) | Curated; PandaScore only if usage justifies | daily (event weeks) | Omit |
| `scores` (results) | Finals and tentpole winners | Official result pages (curated); Liquipedia or PandaScore under licence | Curated final cards with source link and date | daily (event weeks) | Omit result, keep explainer |
| `news` | "Why is everyone talking about this?" | Official studio and platform-holder blogs; independent games press headlines | **Link-only** ingestion where terms allow; Swoon'd writes the explainer; editorial provider decision open (L-01) | daily | Evergreen explainers |
| `new-products` | Hardware and subscription launches and price moves | Official platform-holder newsrooms (link-only); curated notes | Curated with dates and source | weekly | Skip |
| `regulations` (patch and season notes) | "What did the patch change?" | Official patch notes and season pages (link-only; explained in own words) | Curated per followed game; adapter per publisher only if an official feed exists | weekly | Omit |

### Season and event calendar (as of 2026-09-30, all **[verify at release]**)
- **Games:** Gears of War: E-Day dated 2026-10-06 (Xbox, Windows); Call of Duty: Modern Warfare 4 dated 2026-10-23 (PS5, Xbox Series, PC, Nintendo Switch 2); Zelda: Ocarina of Time remake for Switch 2 dated 2026-11-05; Grand Theft Auto VI dated 2026-11-19 (PS5, Xbox Series; no PC date announced; preload from 2026-11-12). Two earlier GTA VI delays are a good "why delays happen" explainer.
- **Awards:** The Game Awards 2026 on 2026-12-10 (Los Angeles). 2025 Game of the Year: Clair Obscur: Expedition 33.
- **Esports:** League of Legends Worlds 2026, 2026-10-15 to 2026-11-14 across Allen (Texas), Los Angeles and New York (final at Barclays Center 2026-11-14); Valorant Champions 2026 in Shanghai, 2026-09-24 to 2026-10-18; The International 2026 (Dota 2) ended 2026-08-23 in Shanghai, Team Spirit beat Team Vision 3-2 for a third title; Esports World Cup 2026 was held in Paris (2026-07-02 to 2026-08-23) after moving from Riyadh, and AG.AL won the Club Championship (returns to Riyadh in 2027); EVO 2026 (fighting games) ran 2026-06-26 to 2026-06-28 in Las Vegas; 2025 champions: T1 (Worlds, third straight title) and NRG (Valorant Champions).
- **Platforms:** Switch 2 launched 2025-06-05 and Nintendo reported about 23.7 million units by 2026-08-06; US Switch 2 price rose to $499.99 on 2026-09-01. Xbox and PlayStation raised console prices in 2026 (exact US figures per secondary sources; verify on official pages); PlayStation Plus prices rose in May 2026 (about $10.99 / $16.99 / $19.99 a month per tier, US); Game Pass Ultimate about $22.99 a month; Nintendo Switch Online individual $19.99 a year (US). Valve's Steam Machine launched around 2026-06-30 (about $1,049 for 512 GB) and the Steam Frame around 2026-09-14; Steam reported a record above 42 million concurrent users in early 2026.
- **Market:** Circana ranked Battlefield 6 the best-selling US game of 2025, then NBA 2K26, Borderlands 4, Monster Hunter Wilds and Call of Duty: Black Ops 7.

Calendar entries are stored as data with source URLs and `verifiedAt` dates, never as lesson copy. Prices and hardware numbers appear only on dated cards.

## 4. Normalized Swoon'd entities (provider-agnostic)

Illustrative shapes (Swift/JSON names to be settled by the app team; all `Sendable` value types with strongly typed IDs):

| Entity | Key fields | Notes |
|---|---|---|
| `GameTitle` | `id`, `name`, `franchiseId?`, `genres[]`, `platforms[]`, `releaseDate?`, `status` (announced/dated/released/delayed), `ratingBody/label?`, `sourceURL`, `verifiedAt` | No box art or key art stored; link to the official store or page |
| `Franchise` | `id`, `name`, `genres[]`, `studioName?` | Text only |
| `GameEvent` | `id`, `kind` (showcase/sale/awards/expo), `name`, `startDate`, `endDate`, `sourceURL`, `verifiedAt` | Curated |
| `EsportsEvent` | `id`, `title`, `tier` (worlds/international/champions/major/regional), `startDate`, `endDate`, `location`, `format` (group/swiss/bracket), `status`, `sourceURL` | Names as text; no logos |
| `EsportsResult` | `id`, `eventId`, `stage` (final/semi), `winnerName`, `runnerUpName`, `scoreline`, `date`, `sourceURL` | Final and semifinal only |
| `PatchNote` | `id`, `gameId`, `version`, `date`, `topic` (balance/season/bugfix), `summaryKey`, `sourceURL` | Swoon'd's own words; never the publisher's text |
| `PlatformNews` | `id`, `platformId`, `topic` (price/hardware/subscription), `effectiveDate`, `summaryKey`, `sourceURL`, `verifiedAt` | Dated card; numbers only inside cards |
| `EditorialCard` | `id`, `topic`, `conceptIds[]`, `explainer`, `links[]`, `publishedAt`, `expiresAt` | Curated; see section 5 |
| `PersonalContext` | `platforms[]`, `franchises[]`, `genres[]`, `creators[]`, `orgs[]`, `region?` | Derived from personalization; no personal data leaves the device in discreet mode |

Repository protocol: `LiveDataRepository` (D-004) returns these types; provider DTOs stay `internal` to their adapters.

## 5. Editorial plan (spec sections 11, 37, 40)

- **Principle:** Structured data tells her *what* is on and *when*; editorial context tells her *why people care*. They are separate systems. Swoon'd talks about works; it does not redistribute them.
- **Approach:** `explain-and-link`. Never copy publisher, review, patch-note or wiki text; never reproduce review scores; explain in Swoon'd's words and link to the original.
- **Sources:** official studio and platform-holder blogs, organizer pages, independent games press (headline-level, link-only). Editorial provider is open (L-01); initial plan is hand-curated by an editor plus generated *original* explainers reviewed before publishing.
- **Card types:**
  1. **Why is everyone talking about this?** (a delay, a price change, a controversy).
  2. **This month** (releases and events).
  3. **Reading the result** (why a grand final mattered).
  4. **What the patch changed** (balance or season notes for her game).
  5. **Term of the week** (draws from the Playbook, links to a lesson).
- **Sample prompts:** "Why was the release delayed again?", "What is Worlds and who is playing?", "Why did the console get more expensive?", "What did the patch nerf and why are fans mad?", "Is the new remake a remake or a remaster?"
- **Editorial safety:** no accusations about named developers or players; controversies are shown as positions, not verdicts; no gambling or betting links; no mature-game recommendations to minors; cheeky but never mean.

## 6. Personalization hooks (spec section 12)

| Dimension | Live-data effect |
|---|---|
| `platform` | Leads platform and price news for that platform; store and subscription names in cards |
| `franchise` / `game` | Prioritizes that franchise's releases, patch notes and events; examples in cards |
| `genre` (branch) | Chooses which esports and release cards lead (MOBA vs shooter vs fighting vs cozy) |
| `player` (streamer or pro) | Event and creator cards; names as facts only |
| `team` (org) | Team results and event cards; talk track "her team lost/won" |
| `region` | Regional esports naming, currency wording, store availability caveats |
| `skill-level` | Explainer depth ("what is a smurf" vs "how the meta shifted after the patch") |

Unset dimensions fall back to generic cards; never blank.

## 7. Lesson hooks (`live` unit hooks in curriculum)

Unit `season-now`: `live-01` (releases), `live-02` (events, new-products), `live-03` (events, schedules), `live-04` (regulations), `live-05` (news). Lessons are templates: each week or event the template is instantiated with card content; exercises (mostly `multiple-choice`, `say-this`, `fill-the-gap`) are generated from Swoon'd's own explainer text and entity data. Static lessons never embed dates, prices, names or numbers that change.

## 8. Licensing and legal notes (spec section 40)

- **Talk about works; never redistribute them.** No screenshots, key art, box art, logos, trailers, gameplay clips, game music or sound effects, character likeness, or copied review/patch/wiki text. All Swoon'd art and audio are original (`original-swoond`). Link out to official pages and streams.
- **Provider terms (verify each before use):** IGDB is free for non-commercial use only; commercial use needs a partner agreement. RAWG requires attribution with an active hyperlink, free commercial tier for small apps, no redistribution or resale. Liquipedia content is CC BY-SA 3.0 (attribution and share-alike; free API only for non-commercial open-source projects, custom User-Agent, rate limits, no automated HTML scraping). PandaScore is paid per game and prohibits betting-related use. Steam Web API terms and rate limits apply and must be read before use.
- **No unofficial or reverse-engineered APIs** in production (SteamDB, Metacritic, HowLongToBeat, store-page scraping), consistent with spec section 39 and CLAUDE.md section 3.
- **Trademarks:** game, platform and team names appear as plain text; no logos or brand art. Controller symbols owned by platform holders are described in text, not drawn.
- **Player and streamer likeness:** names as facts only; no photos, avatars or quotes; no endorsement implied.
- **Ratings and age:** content and rating flags appear in plain text on recommendations; never steer minors to mature-rated titles.
- **Gambling adjacency:** no betting data, no skin-market data, no promotional links.

## 9. Reliability and fallbacks

| Failure | Behaviour |
|---|---|
| Curation delay or provider outage | Show last verified data with "as of {date}"; never fabricate |
| No events this week | "Quiet week" card plus an evergreen lesson |
| Off-season for esports | Season-rollover card and "how the next season works" primer |
| Adapter or API removed | Adapter swapped; entities unchanged |
| Conflicting sources | Prefer the official source; log the discrepancy; hide the card until resolved |
| Delay announced after a card ships | Card expires early on the next refresh; editor corrects |
| Region unset | Hide region-specific wording |

## 10. Open items

1. IGDB commercial partner agreement vs RAWG under attribution terms (L-13). (Product)
2. Editorial and news provider (L-01). (Product)
3. Whether any esports data (Liquipedia commercial, PandaScore) is worth paying for at launch, or stay curated. (Product)
4. Re-verify all dated cards above before release, especially console prices, hardware figures and event dates (V-09). (Content)
5. Confirm the wording and legal comfort of naming publishers' games in lesson titles and store copy (L-14). (Legal)
