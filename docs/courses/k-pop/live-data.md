# Dynamic Data and Editorial Plan: K-pop (`k-pop`)

Implements product spec sections 10-12 (structured data, editorial, personalized context), 32-37 (provider isolation, news) and **section 40 (media courses)**. Facts were checked by web search on 2026-09-30 and are tagged **[verify at release]**; sources are secondary press and are listed in section 8. Calendar, rule and dispute facts are stored as dated data with source URLs and `verifiedAt`, never as lesson copy.

## 1. Verdict: is there meaningful live data?

**Yes, as a weekly rhythm of metadata and context, never as a media feed.** K-pop has no scores or standings in the sports sense; do not invent a leaderboard. What changes weekly and gives the learner something real to say: **what is coming back this week** (comeback calendar), **how the show week went** (wins, charts), **what is on sale** (tours, presales) and **what people are discussing** (awards, industry stories).

**Section 40 rule, applied strictly.** Swoon'd talks *about* works and people: titles, dates, credits, formats, cultural context. It **does not distribute** recordings, music videos, lyrics or lyric translations, cover art, concept or member photos, fancams or variety clips. Every card links out to the official channel. Audio in lessons is original (`original-swoond`).

## 2. Current-context layers

| Layer | Who sees it | What it is |
|---|---|---|
| Comeback week | Everyone; sharper with `artist` | "Coming back this week": title, date and KST release time converted to the learner's region, format, credits, a Swoon'd explainer, official link. |
| Show week | Everyone in season | "Who won this week, and what a win means": dated entry per show with the formula note; never a live board. |
| Tours and presales | Everyone; sharper with `region` and `artist` | Tour announcements, fan-club presale tiers, on-sale steps, "how to plan the night" cards. |
| Awards and year-end | Seasonal | Nomination and category explainers, voting-rule explainers, dates. |
| Industry stories | Everyone | Neutral explainers for disputes and debates: what is on the record, what is alleged, what to ask her. Quarterly review. |
| Evergreen fallback | Always | "How to read a comeback week", "How a win works", "How charts count", "How on-sales work". |

## 3. Data kinds, providers, refresh

Provider -> **Adapter** -> normalized entity -> course interpretation -> UI. Each adapter has a kill switch and fallback. No provider schema becomes the domain model.

| Kind (manifest) | Normalized entity | Provider candidates | Licensing notes | Refresh | Fallback |
|---|---|---|---|---|---|
| `releases` | `Release {id, title, artistRef, date, kstTime, format, credits[], officialUrl}` | MusicBrainz (open core data; per-dataset checks, rate limits, user-agent); Apple Music API/MusicKit and Spotify Web API (developer terms; limits on caching and some endpoints **[verify at release]**); curated calendar | Store ids, dates and titles; no cover art, previews or audio; link out | weekly; daily near releases | Evergreen card |
| `schedules` | `TourDate {id, artistRef, city, venue, date, presaleTiers[], onSaleAt, ticketUrl}` | Ticketmaster Discovery (commercial terms), Interpark and Yes24 (link-out), agency and artist pages, curated | Link out to buy; never sell; no price scraping | weekly | Evergreen explainer |
| `rankings` | `ShowWin {show, date, artistRef, title, formulaNote}`; `ChartSnapshot {chart, date, note, url}` | Circle Chart and Hanteo (official sites, link-out and curated summaries), Melon (link-out), Billboard/Luminate (licence for data), Wikipedia/Wikidata for win lists (CC facts) | Do not scrape; chart data is licensed; snapshot date always shown; show formulas stored as dated data because they change | weekly | Static how-charts-count card |
| `events` | `AwardsEvent {id, name, dates, categories[], votingRulesUrl}` | Organisers' official sites (curated), Wikipedia/Wikidata | Curated with source URLs | seasonal | Evergreen explainer |
| `news` | `Topic {id, headline, url, explainer}` | Headlines (link-only), agency and artist announcements | Metadata only; Swoon'd writes the explainer; editorial provider decision open (DECISIONS Q-3) | daily | Evergreen |
| `new-media` (optional) | `MediaItem {title, date, url}` | Curated concert films and documentaries | Metadata only; hidden when empty | monthly | Hidden |
| Fan platforms (e.g. Weverse-type) | none | none | No public API; do not scrape or proxy; link out only | n/a | n/a |
| Lyrics, cover art, photos, MVs | none | none | **Never** | n/a | n/a |

## 4. Personalization hooks

- `artist`: comeback, tour and show cards filter to her group; unset shows the week's top three and an evergreen card. Optional bias never appears in a card title, only warmer follow-ups.
- `region`: converts KST to local time, shows local on-sale and fan-club rules, local crisis resources in wellbeing explainers.
- `platform`: "open in" links and wording (Melon, Spotify, Apple Music, YouTube Music).
- Tokens `{{artist}}`, `{{region}}`, `{{platform}}` only resolve in the units listed in CDS section 8.

## 5. Editorial plan

- **Explain in our own words and link.** Templates: "Why are fans talking about this today?", "What this win means", "What the presale means for you", "What to say, what not to say".
- **Disputes and wellbeing stories:** state what is on the record, what is alleged, what is not known; no rumours, no speculation about a person's health or private life, no methods; include a short "what a good friend says" card and a regional resource link.
- **Review cadence:** weekly calendar sweep by an editor; quarterly check of dispute and rule explainers; a cultural and Korean-language review before any new sensitive topic ships.
- **No copied text:** headlines plus links; summaries are written fresh.

## 6. Risks and kill switches

- Provider terms change: adapters are swappable; evergreen fallbacks cover every card.
- Wrong or stale facts: every card carries `verifiedAt` and a source URL; stale cards collapse to the evergreen version.
- Rumour contamination: news topics require editor approval before display.

## 7. Season and facts snapshot (2026-09-30) **[verify at release]**

- **Music-show scoring:** formulas combine digital, physical, video, broadcast and voting components, differ by show and are revised; e.g. M Countdown (since 2024-01-05) digital 50, physical 15, video 10, broadcast 20, voting 20 (10 pre-vote plus 10 live); Show Champion digital 35, physical 15, video 10, broadcast 20, voting 20; Inkigayo digital 50, on-air 10, physical 10, video 20, voting 10, with weights revised from 2024-10-06. Store as dated data; never as lesson copy.
- **Charts:** Circle Chart is Korea's national chart; Hanteo reported a record first-half 2026 album total (about 49.5 million copies) driven by BTS and BLACKPINK releases (press report; verify).
- **Comebacks and tours:** BTS confirmed a 2026 return (album titled Arirang, March 20, 2026) and a 79-date world tour across 34 regions through March 2027 **[verify at release]**.
- **Contracts and disputes:** Korean standard contracts cap exclusive terms at seven years after the 2009-era "slave contract" controversy; on 2025-10-30 the Seoul Central District Court ruled NewJeans must honour its contract with ADOR through 2029 and the group said it would appeal; the Fair Trade Commission opened a related probe **[verify status at release]**.

## 8. Sources consulted (secondary press, fetched by search 2026-09-30)

Rolling Stone, Forbes, Variety (BTS 2026 return and tour); Korea Daily (album sales record); Wikipedia lists of music-show winners and scoring pages, Creatrip (scoring guide); NPR, NME, Korea Herald, Music Business Worldwide (NewJeans and ADOR ruling and FTC probe). Primary sources to be captured with URLs and `verifiedAt` in the data store before release.
