# Dynamic Data and Editorial Plan: Pickleball (`pickleball`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context) and 32-37 (provider isolation, sports data strategy, providers, news). Facts below were checked by web search on 2026-09-30 and should be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Yes, modestly.** Pickleball is not a scores-first sport like the NFL or F1, and Swoon'd is "not ESPN" (spec section 33). But the person she is learning for may follow the PPA Tour, MLP or local events, and *rule and equipment news moves fast* (2026 rulebook, spin-rate testing). So the course has a **thin structured layer** (calendar, results, MLP standings, rankings, rosters) plus a **strong editorial layer** ("why are fans talking about this?"). Recreational players get a lighter "current context" layer (gear/rule news, optional weather and court context). Nothing is real-time; a few hours of lag is fine.

Do not invent more: no live point-by-point, no betting-grade data, no per-rally stats.

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Pro season layer | `ppa-tour`, `mlp`, `app-tour` branches; anyone with a `league` set | This week's events, results, standings, rankings, rosters; "why it matters" cards |
| Rules and gear news layer | Everyone (default rec branch) | New rulebook (January), spin-rate test and approvals, notable rule debates; explained in Swoon'd's words with links |
| Local layer (optional) | `rec-play` with `region` set | Nearby-court context, weather "can you play tonight?", closures where a reliable source exists |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer ("How a pro event works") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

External providers never become the domain model (spec section 32): Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. Every candidate below sits behind a Swoon'd adapter.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules`, `events` | "What's on this weekend?" | Carvana PPA Tour calendar, MLP events page, APP Tour calendar (official sites); PickleballTournaments.com (link-out for amateur events) | **Curated ingest** (editors enter/verify dates from official pages; later an adapter to any official feed). No known public API. | weekly (daily on event weeks) | Last verified calendar with "check the official site" link |
| `scores` (results) | Medal results, MLP match results | Official results pages (curated); TheSportsDB only if pickleball coverage is confirmed; Sportradar/SportsDataIO as an upgrade path if coverage exists (unconfirmed) | Curated at first; pilot daily result cards for finals only | daily (pilot); minutes not required | Omit result card, keep editorial explainer |
| `standings` | MLP table and playoff picture | MLP official standings (curated) | Curated ingest | daily during May to August | Static "how MLP standings work" card |
| `rankings` | Pro rankings movers | Carvana PPA Tour World Pickleball Rankings (launched with the 2026-27 season); DUPR (partner API if a licence is agreed) | Curated snapshot weekly; DUPR only via a signed partner agreement | weekly | Last snapshot with date shown |
| `rosters` | Who plays for which MLP team | MLP official rosters (curated) | Event-driven curation (draft, waiver window, trades) | monthly / event-driven | Snapshot |
| `news` | Rule changes, feuds, retirements, paddle news | USA Pickleball news, PPA Tour and MLP news, independent pickleball media | **Link-only** ingestion of headlines/metadata where licence allows; Swoon'd writes the explainer | daily | Evergreen explainers |
| `new-products` | Paddle certification and spin test | USA Pickleball approved paddle list (link-out only), brand press pages (link) | Curated monthly gear note | monthly | Skip |
| `weather` (optional) | "Can we play tonight?" | National Weather Service API (public, US) | Adapter; only when `region` is set | hourly | Hidden |
| `closures` (optional) | Court/park closures | Municipal notices (no uniform source) | Link-out only | daily | Hidden |
| Local courts (optional) | Personalization | OpenStreetMap (`sport=pickleball`), Places2Play (USA Pickleball, link-out) | OSM via adapter with ODbL attribution | monthly | Hidden |

### Season calendar (as of 2026-09-30)
- **Carvana PPA Tour 2026-27:** opened Aug 31 with the Veolia Pickleball National Championships (Cary, NC, Aug 31 to Sep 6; the first of four majors); 20 US events (new stops incl. Chicago and Malibu) plus international events (Asia, Australia, Canada, Italy); Pickleball World Championships in Dallas in November; PPA Finals return to San Clemente in May. A "Challenger Series" of about 20 events feeds ranking points. Season structure is now fall-to-spring.
- **MLP 2026:** May to August; nine regular-season events plus a mid-season tournament; 20 teams at one level; three-week, 12-team playoffs; finals weekend in New York City (Central Park, Aug 30); the New Jersey Fives won their first title over the St. Louis Shock.
- **USA Pickleball rulebook:** new edition each January 1; the 2026 edition introduced "clear/clearly" wording for volley serves, formalised rally scoring, added prompt out-call language and adaptive-division rules.
- **Equipment:** USA Pickleball's paddle spin-rate testing regime scheduled to take effect Oct 1, 2026 (announced threshold below 2,100 RPM; existing certified paddles' treatment to confirm).

Calendar entries are stored as data with source URLs and `verifiedAt` dates, never as lesson copy.

## 4. Normalized Swoon'd entities (provider-agnostic)

Illustrative shapes (Swift/JSON names to be settled by the app team; all `Sendable` value types, IDs strongly typed):

| Entity | Key fields | Notes |
|---|---|---|
| `PickleballEvent` | `id`, `tour` (`ppa`/`mlp`/`app`/`other`), `name`, `tier` (slam/cup/open/challenger/mlp-week/final), `startDate`, `endDate`, `city`, `country`, `status` (upcoming/live/final), `sourceURL`, `verifiedAt` | Tier drives "why it matters" copy |
| `PickleballMatch` | `id`, `eventId`, `bracket` (women's, men's, mixed, singles...), `round`, `sides[]` (playerIds), `scoreline`, `winnerSide`, `format` (side-out/rally, games-to), `status` | Only for finals/medal matches at first |
| `Player` | `id`, `displayName`, `country`, `tourAffiliations[]`, `worldRank` per discipline, `snapshotDate` | No likeness in the app unless licensed |
| `Team` (MLP) | `id`, `name`, `city`, `rosterIds[]`, `season`, `record`, `standingsPoints` | Logos not used |
| `Standing` | `season`, `teamId`, `rank`, `record`, `points`, `playoffStatus` | |
| `RankingEntry` | `discipline`, `playerId`, `rank`, `points`, `movement`, `snapshotDate` | Movement computed by Swoon'd |
| `RuleUpdate` | `id`, `body` (usap/ppa/mlp), `effectiveDate`, `topic`, `summaryKey`, `sourceURL` | Copy is Swoon'd's own words |
| `EquipmentNote` | `id`, `topic`, `effectiveDate`, `summaryKey`, `sourceURL` | e.g. spin test |
| `EditorialCard` | `id`, `topic`, `conceptIds[]`, `explainer`, `links[]`, `publishedAt`, `expiresAt` | Curated; see section 5 |
| `LocalContext` | `region`, `weatherSummary`, `closureNote?`, `nearbyCourts[]` | Optional; adapter-normalized |

Repository protocol: `LiveDataRepository` (D-004) returns these types; provider DTOs stay `internal` to their adapters. Rankings snapshots are stored with `snapshotDate` and shown as such.

## 5. Editorial plan (spec sections 11, 37)

- **Principle:** Structured data tells her *what* happened; editorial context tells her *why people care*. They are separate systems.
- **Approach:** `explain-and-link`. Never copy publisher text, and never copy rulebook text wholesale; explain in Swoon'd's words with rule numbers/URLs.
- **Sources:** USA Pickleball (rules, approvals), Carvana PPA Tour and MLP (official news), independent pickleball media (headline-level, link-only). Editorial provider decision is open (DECISIONS Q-3); the initial plan is hand-curated by an editor (human) plus generation of *original* explainers reviewed before publishing.
- **Card types:**
  1. **Why is everyone talking about this?** (rules and gear news, controversy explainers)
  2. **This week** (events, what's at stake)
  3. **Reading the result** (why a gold medal match mattered, what a DreamBreaker win means)
  4. **Term of the week** (draws from the Playbook, links to a lesson)
- **Sample prompts:** "Why are fans talking about paddles today?", "Why did that match end in a DreamBreaker?", "Why is rally scoring controversial?", "What does the spin test change for a paddle I just bought?", "Why does everyone complain about pickleball noise?"
- **Editorial safety:** no accusations about named individuals; no medical or injury claims; cheeky but never mean; don't declare a paddle "illegal".

## 6. Personalization hooks (spec section 12)

| Dimension | Live-data effect |
|---|---|
| `league` (PPA / MLP / APP) | Chooses which pro cards lead the feed; default `none` = rec-play (rules/gear news) |
| `team` (MLP) | Team result, standing, roster news, next opponent; talk tracks "her team lost/won" |
| `player` | Ranking movement, event appearances, streaks, rivalry cards (text-only) |
| `skill-level` | Which explainers show ("what's the difference between 3.5 and 4.0", vs. pro strategy) |
| `equipment` | Paddle-related news (spin test) pinned when set |
| `region` | Weather ("can you play tonight?"), local tournaments (link-out), court context |

Unset dimensions fall back to generic cards; never blank.

## 7. Lesson hooks (`live` unit hooks in curriculum)

Unit `season-now`: `live-01` (schedules, events), `live-02` (events, results), `live-03` (rankings), `live-04` (standings), `live-05` (news, new-products), `live-06` (seasonal). Lessons are templates: each week/event the template is instantiated with the card content, exercises (mostly `multiple-choice`, `say-this`, `hotspot-tap`) are generated from Swoon'd's own explainer text and the entity data. Static lessons never embed dates, names or numbers that change.

## 8. Licensing and legal notes

- No official public pro API is known: scraping unofficial or reverse-engineered endpoints is **not** allowed for production (CLAUDE.md section 3). Curation from public official pages with attribution is the launch approach; open an official data partnership conversation with the UPA/PPA/MLP before automating.
- Logos, team marks and brand names are trademarks: text mentions and links only.
- Player likeness: names as facts only; no photos, endorsements, or fabricated quotes.
- Rankings/ratings from DUPR require a partner agreement; OSM data requires ODbL attribution; NWS data is public (US government) with attribution recommended.
- Rulebook PDFs are copyrighted: link, paraphrase, cite rule numbers (for example rules 2070, 2221, 2242 in the 2026 book).
- Video and broadcast: no embedding of broadcast video; deep-link to official streams.

## 9. Reliability and fallbacks

| Failure | Behaviour |
|---|---|
| Provider or curation delay | Show last verified data with "as of {date}"; never fabricate |
| No events this week | "Off week" card plus evergreen lesson |
| Off-season | `season-rollover` card, new-season primer, rule changes recap |
| Adapter/API removed | Adapter swapped; entities unchanged |
| Conflicting sources | Prefer official site; log discrepancy; hide the card until resolved |
| Region unset | Hide local layer |

## 10. Open items

1. Pilot: which pro results are shown (finals only) and who curates them weekly. (Product/Data)
2. Any official UPA/PPA/MLP data feed? Open outreach. (Product)
3. Editorial provider selection and budget (DECISIONS Q-3). (Product)
4. DUPR partner API licence (ratings and player cards). (Product)
5. Verify spin-rate test effective date, threshold and grandfathering after Oct 1, 2026 before the `gear-04` and `live-05` cards ship. (Content)
