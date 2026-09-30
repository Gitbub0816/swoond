# Dynamic Data and Editorial Plan: Golf (`golf`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context) and 32-37 (provider isolation, sports data strategy, providers, news). Facts below were checked by web search on 2026-09-30 and should be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Yes, for the tour layer; lightly for the recreational layer.** Golf is a weekly-event sport with a stable, well-understood data model (events, rounds, leaderboards, cut lines, rankings, points races). A learner whose person watches a tour event on Sunday benefits greatly from "what does -8 thru 14 mean right now, and why does it matter?" That is a **strong structured layer plus a strong editorial layer**. A recreational player's world is mostly evergreen (rules, formats, handicaps), with an optional **weather and gear/rules-news layer**. Swoon'd is not a live-scoring app (spec section 33): a few minutes of lag is fine.

Do not invent more: no shot-by-shot tracking, no betting odds or "props", no strokes-gained per shot, no fantasy golf.

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Tour layer | `pga-tour`, `lpga-tour`, `liv-golf`, `dp-world-tour` branches; anyone with `league` set | This week's event, leaderboard, cut line, races (FedExCup, Race to the CME Globe, Race to Dubai), rankings, "why it matters" cards |
| Majors and cups layer | Everyone | Major-week previews and recaps; Ryder, Solheim and Presidents Cup context in cup years (2027: Ryder Cup at Adare Manor, Sept 17-19) |
| Rules and equipment news layer | Everyone (default rec branch) | Rules of Golf editions, equipment governance (2028 model local rules), new gear, explained in Swoon'd's words with links |
| Local layer (optional) | `rec-play` with `region` set | "Can you play Saturday?" weather and wind, frost or lightning delays, course context |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer ("How a cut works", "How match play scoring works") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

External providers never become the domain model (spec section 32): Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. Every candidate sits behind a Swoon'd adapter.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules`, `events` | "What's on this week?", "Is it a major?" | Official tour calendars (PGA TOUR, LPGA, DP World Tour, LIV, majors); Sportradar Golf and SportsDataIO Golf (licensed upgrade); TheSportsDB (only if golf coverage and terms are confirmed) | **Curated ingest** at launch (editors verify dates from official pages); licensed adapter later | weekly (daily on event weeks) | Last verified calendar plus "check the official site" link |
| `scores` (leaderboards) | Round in progress: position, "thru", cut line | Sportradar Golf or SportsDataIO Golf (licensed); TheSportsDB if coverage and terms allow | Licensed adapter; a few minutes of lag acceptable | minutes-during-events | Round-summary card after the round; official leaderboard link |
| `standings` | FedExCup, Race to the CME Globe, Race to Dubai, LIV points | Same licensed providers; official standings pages (curated snapshot) | Licensed adapter or curated snapshot with date | daily | Last snapshot with "as of" date |
| `rankings` | Official World Golf Ranking; Rolex Women's World Golf Rankings | Official ranking sites (link plus curated snapshot); licensed provider if its terms allow | Snapshot weekly; never presented as real-time | weekly | Snapshot with date shown |
| `rosters` | Cup teams and points; LIV teams | Official team pages (curated); licensed provider | Event-driven curation; cup rosters around selection dates | weekly (event-driven) | Snapshot |
| `statistics` | Light: strokes-gained explainer, driving distance | Licensed provider or a specialist under a commercial licence; otherwise evergreen numbers | Optional; explainers do not require live stats | weekly | Hidden; evergreen explainer |
| `news` | Rulings, LIV, injuries, withdrawals, rules and equipment news | Official news pages (PGA TOUR, LPGA, DP World Tour, LIV, R&A, USGA) and golf media headlines | **Link-only** ingestion of headlines and metadata where the licence allows; Swoon'd writes the explainer | daily | Evergreen explainers |
| `regulations` | Rules of Golf editions, equipment standards, model local rules | R&A and USGA rules and equipment pages | Curated with rule numbers and links; own-words explanations | monthly (event-driven) | Evergreen |
| `new-products` | Gear news and the conforming list | Equipment brand press pages (link-only); USGA and R&A conforming lists (link) | Curated monthly gear note | monthly | Skip |
| `weather` (optional) | "Can you play Saturday?" | National Weather Service API (US, public); a commercial weather provider later for wind and lightning proximity | Adapter; only when `region` is set | hourly | Hidden |
| Local courses (optional) | Personalization | OpenStreetMap (`leisure=golf_course`, ODbL attribution); course websites (link-out) | OSM via adapter; no scraping of course sites | monthly | Hidden |

### Provider notes and rules
- **No unofficial or reverse-engineered feeds.** Tour and media sites expose undocumented JSON/GraphQL endpoints that developers sometimes scrape; these are **not** allowed in production (CLAUDE.md section 3).
- **Licensed sources for scores.** Sportradar Golf and SportsDataIO Golf are the candidate licensed providers; **coverage of the PGA TOUR, LPGA, DP World Tour, LIV Golf and the majors, pricing and redistribution terms are unconfirmed** and must be checked before the live leaderboard ships (OPEN_QUESTIONS L-02 covers team sports; a golf-specific item is added in `NOTES_FOR_ORCHESTRATOR.md`).
- **TheSportsDB** (spec section 34) is investigated first for cost, but its golf coverage and terms must be confirmed; otherwise skip.
- **Specialist analytics** (for example commercial strokes-gained data vendors) are optional and not needed for launch.
- **Curated ingest** of calendars and rankings is the launch path: editors verify facts from official pages and store `sourceURL` and `verifiedAt`.

### Season calendar (as of 2026-09-30) **[verify at release]**
- **PGA TOUR:** the 2026 season concluded with the Tour Championship at East Lake (Aug 30, 2026); Scottie Scheffler won the FedExCup. The fall series runs September to November. The **2027 schedule** (announced Aug 26, 2026) has 36 events, eight signature events, the new Sompo Championship, the BMW Championship at Liberty National and the Tour Championship on Aug 26-29, 2027. FedExCup playoffs stay at three events (top 70, then 50, then 30).
- **Majors 2026 (all complete):** Masters (Rory McIlroy), PGA Championship at Aronimink (Aaron Rai), U.S. Open at Shinnecock Hills (Wyndham Clark), The Open at Royal Birkdale (Ryan Fox). 2027 majors will be added when the official calendar is verified.
- **Women's majors 2026 (all complete):** Chevron Championship (Nelly Korda), U.S. Women's Open (Nelly Korda), KPMG Women's PGA (Haeran Ryu), Amundi Evian (Haeran Ryu), AIG Women's Open (Shiho Kuwaki). The LPGA season runs into November (CME Group Tour Championship).
- **DP World Tour:** 2026 has 42 events in 25 countries with a Back 9 and Play-offs; season finale DP World Tour Championship, Nov 12-15, 2026, Jumeirah Golf Estates, Dubai (Harry Vardon Trophy for the Race to Dubai winner).
- **LIV Golf:** 2026 moved to 72 holes and 57 players; Saudi PIF funding ends after 2026; the league reports a lead investor for 2027 (terms pending); the Michigan team championship was cancelled and the Indianapolis event was the finale.
- **Team golf:** Solheim Cup 2026, Europe 15-13 (Bernardus, Netherlands, Sept 11-13); Presidents Cup 2026, USA 17-13 (Medinah, Sept 24-27); Ryder Cup 2027 at Adare Manor (Sept 17-19; captains Luke Donald for Europe, Jim Furyk for the USA).
- **Rules and equipment:** Rules of Golf cycle 2019, 2023, next expected 2027 (unconfirmed); the R&A and USGA notice (Sept 21, 2026) on optional 2028 model local rules (ball at 317.0 yd overall distance, driver CT 239 microseconds, club length cap below 46 in), with comments to Oct 21, 2026.

Calendar entries are stored as data with source URLs and `verifiedAt` dates, never as lesson copy.

## 4. Normalized Swoon'd entities (provider-agnostic)

Illustrative shapes (Swift/JSON names to be settled by the app team; all `Sendable` value types, IDs strongly typed):

| Entity | Key fields | Notes |
|---|---|---|
| `GolfEvent` | `id`, `tour` (`pga`/`lpga`/`dpwt`/`liv`/`major`/`cup`/`other`), `name`, `tier` (major/signature/rolex-series/playoff/cup/regular), `format` (stroke/match/team), `courseId`, `startDate`, `endDate`, `city`, `country`, `status` (upcoming/live/final), `purseDisplay?`, `sourceURL`, `verifiedAt` | Tier drives "why it matters" copy |
| `GolfCourse` | `id`, `name`, `city`, `country`, `parByHole[]`, `yardageByTee[]`, `type` (links/parkland/...), `sourceURL` | Static; from curated or OSM data |
| `Player` | `id`, `displayName`, `country`, `tourAffiliations[]`, `worldRank?`, `snapshotDate` | No likeness in the app unless licensed |
| `LeaderboardEntry` | `eventId`, `playerId`, `round`, `position` (with ties), `toPar`, `thru` (holes played or F), `todayToPar`, `status` (active/cut/wd/dq) | Provider-normalized; "thru" never shown as a raw provider string |
| `CutLine` | `eventId`, `projectedToPar`, `rule` (`top-65-and-ties`...), `asOf` | Rule stored as data; copy explains it |
| `Race` | `season`, `type` (fedexcup/cme-globe/race-to-dubai/liv), `playerId`, `rank`, `points`, `asOf` | Movement computed by Swoon'd |
| `RankingEntry` | `system` (owgr/rolex-womens), `playerId`, `rank`, `points`, `movement`, `snapshotDate` | Shown with date; never real-time |
| `TeamStanding` (cups, LIV) | `event`, `side`/`team`, `points`, `roster[]` | Cup points math is in curriculum, data only supplies numbers |
| `RuleUpdate` | `id`, `body` (randa/usga/tour), `effectiveDate`, `topic`, `ruleNumber?`, `summaryKey`, `sourceURL` | Copy is Swoon'd's own words |
| `EquipmentNote` | `id`, `topic` (ball/driver/conforming), `effectiveDate`, `summaryKey`, `sourceURL` | e.g. 2028 model local rules |
| `EditorialCard` | `id`, `topic`, `conceptIds[]`, `explainer`, `links[]`, `publishedAt`, `expiresAt` | Curated; see section 5 |
| `LocalContext` | `region`, `weatherSummary`, `windMph`, `lightningNote?`, `courseNote?` | Optional; adapter-normalized |

Repository protocol: `LiveDataRepository` (D-004) returns these types; provider DTOs stay `internal` to their adapters. Rankings and standings are stored with `asOf` dates and shown as such.

## 5. Editorial plan (spec sections 11, 37)

- **Principle:** structured data tells her *what* happened; editorial context tells her *why people care*. They are separate systems.
- **Approach:** `explain-and-link`. Never copy publisher text and never copy Rules of Golf text; explain in Swoon'd's words with rule numbers and URLs.
- **Sources:** R&A and USGA (rules, equipment), PGA TOUR, LPGA, DP World Tour and LIV (official news), golf media (headline-level, link-only). Editorial provider selection is open (DECISIONS Q-3, OPEN_QUESTIONS L-01); the initial plan is hand-curated by a human editor plus generated *original* explainers reviewed before publishing.
- **Card types:**
  1. **Why is everyone talking about this?** (rulings, LIV news, the ball debate, controversial setups)
  2. **This week** (event, course, storylines, what's at stake)
  3. **Reading the leaderboard** (what -8 thru 14 means, who is on the cut line)
  4. **Major week** (course primer, what makes this major different, what to watch)
  5. **Term of the week** (draws from the Playbook, links to a lesson)
- **Sample prompts:** "Why are golf fans arguing about the ball today?", "What does 'thru 14, -6' tell me?", "Why did that ruling matter?", "Why is the captain's pick controversial?", "What is the cut and who's on the bubble?"
- **Editorial safety:** no accusations about named individuals; no medical or injury speculation beyond public facts; no betting content; political controversies (LIV, funding) covered neutrally with both arguments; cheeky but never mean.

## 6. Personalization hooks (spec section 12)

| Dimension | Live-data effect |
|---|---|
| `league` (PGA TOUR / LPGA / LIV / DP World Tour) | Chooses which tour cards lead the feed; default `none` = `rec-play` (rules, gear and weather cards) |
| `player` | Leaderboard position, race movement, "did you see" cards, rivalry and milestone notes (text-only) |
| `team` | LIV team results; cup side (USA / Europe / International) results and standings in cup years |
| `skill-level` | Which explainers show ("what a 12 handicap means" vs "how the cut works") |
| `equipment` | Gear-related news (conforming list, new drivers) pinned when set |
| `region` | Weather ("can you play Saturday?"), local course context, nearby tournaments (link-out) |

Unset dimensions fall back to generic cards; never blank.

## 7. Lesson hooks (`live` unit hooks in curriculum)

Unit `season-now`: `live-01` (schedules, events), `live-02` (scores), `live-03` (standings, rankings), `live-04` (events, news), `live-05` (news, regulations, new-products), `live-06` (seasonal). Lessons are templates: each week or event the template is instantiated with card content, and exercises (mostly `multiple-choice`, `say-this`, `hotspot-tap` on a normalized leaderboard diagram) are generated from Swoon'd's own explainer text and the entity data. Per-lesson `live` hooks also appear in `pga-03` (cut line), `pga-02` (FedExCup), `lpga-02` (Race to the CME Globe), `dpwt-02` (Race to Dubai) and `cup-02` (cup points during a cup week). Static lessons never embed dates, names or numbers that change.

## 8. Licensing and legal notes

- No unofficial, undocumented or reverse-engineered tour or media endpoints; licensed providers or official partnerships only for scores.
- Trademarks (PGA TOUR, LPGA, DP World Tour, LIV Golf, R&A, USGA, Ryder Cup, Masters, Augusta National, "green jacket", equipment brands): text mentions and links only; no logos or event artwork.
- Player likeness: names as facts only; no photos, endorsements, or fabricated quotes.
- Rankings (OWGR, Rolex Women's World Golf Rankings): link and curated snapshots with attribution until a licence is agreed.
- Rules of Golf and equipment rules text are copyrighted: link, paraphrase, cite rule numbers.
- OSM (`leisure=golf_course`) needs ODbL attribution; NWS data is public with attribution recommended.
- Video and broadcast: no embedding of broadcast video; deep-link to official streams.
- Betting: no odds, tips or gambling content; if a provider's feed includes odds, the adapter strips them.

## 9. Reliability and fallbacks

| Failure | Behaviour |
|---|---|
| Provider or curation delay | Show last verified data with "as of {date}"; never fabricate |
| No event this week | "Off week" card plus an evergreen lesson |
| Off-season | `season-rollover` card, new-season primer, rules-cycle recap |
| Adapter/API removed | Adapter swapped; entities unchanged |
| Conflicting sources | Prefer the official site; log the discrepancy; hide the card until resolved |
| Region unset | Hide the local layer |
| Leaderboard during suspended play (weather) | Show "play suspended" state and the last known standing; explain suspensions in an evergreen card |

## 10. Open items

1. Provider coverage and pricing: Sportradar Golf vs SportsDataIO Golf vs TheSportsDB for the PGA TOUR, LPGA, DP World Tour, LIV and the majors, plus redistribution terms. (Product/Data)
2. Editorial provider selection and budget (DECISIONS Q-3, L-01). (Product)
3. Rankings licensing (OWGR, Rolex Women's World Golf Rankings): link-only until an agreement exists. (Product)
4. Confirm the next Rules of Golf edition and date before rules content locks. (Content)
5. Confirm the 2026 LIV team champion and the 2027 LIV format after funding changes before `tour-liv` cards ship. (Content)
6. Weather provider for wind and lightning proximity beyond NWS. (Product)
