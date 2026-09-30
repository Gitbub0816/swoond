# Dynamic Data and Editorial Plan: Tennis (`tennis`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context) and 32-38 (provider isolation, sports data strategy, providers, news). Facts below were checked by web search on **2026-09-30** (secondary sources) and are tagged **[verify at release]** where they must be re-confirmed. Nothing here is hard-coded into evergreen lessons.

## 1. Verdict: is there meaningful live data?

**Yes, and it is year-round.** Tennis has a match somewhere almost every week, a rolling ranking, brackets that reward following, and rule and technology news that fans discuss. But Swoon'd is "not ESPN" (spec section 33): a few minutes of lag is fine, and point-by-point, betting-grade or serve-speed feeds are out of scope. The recreational branch gets a lighter "current context" (rule/gear news, "can we hit tonight?").

Do not invent more: no live point-by-point, no odds, no per-shot stats, no fantasy scoring.

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Tour season layer | `atp-tour`, `wta-tour`, `grand-slams` branches; anyone with `league` set | This week's events, draws, results, rankings and the Race; "why it matters" cards |
| Slam fortnight layer | Everyone during a Slam | Draw, today's headline matches, upset explainers, the format cheat-sheet |
| Rules and tech news layer | Everyone (default rec branch) | Electronic line calling, wearables, scoring/format changes, clock rules; explained in Swoon'd's words |
| Local layer (optional) | `rec-play` with `region` set | Weather "can we hit tonight?", court closures where a reliable source exists, nearby courts |
| Evergreen fallback | Always | If a provider is down or empty, cards fall back to an evergreen explainer ("How a Slam fortnight works") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. No provider schema becomes the domain model. Every candidate below sits behind a Swoon'd adapter, and none is confirmed; no unofficial or reverse-engineered APIs.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules`, `events` | "What's on this week?" | Official ATP, WTA and Slam calendars; ITF calendar; a licensed tennis data provider (Sportradar or Stats Perform class) | **Curated ingest** first (editors verify from official pages); adapter to a licensed feed later | weekly (daily on event weeks) | Last verified calendar with "check the official site" link |
| `scores` | Match results, finals | Licensed provider (unconfirmed); TheSportsDB only if coverage confirmed; official results pages (link-out) | Adapter; results and final scores only, never point-by-point | minutes-during-events (semis/finals; otherwise hourly) | Omit card; editorial explainer remains |
| `rankings` | Movers; "is she still No. 1?" | ATP and WTA official rankings pages (curated weekly snapshot); licensed provider | Snapshot with date, movement computed by Swoon'd | weekly (Mondays) | Last snapshot with date shown |
| `standings` | The Race to the year-end Finals | ATP Race and WTA Race pages (curated) | Snapshot | weekly, September to November | Static "how the Race works" card |
| `rosters` (draws) | Draw reading | Official draw pages (curated); licensed provider | Adapter; seeds, byes, wild cards, qualifiers | daily on event days | Snapshot |
| `injuries` | "Why is she out?" | Official tournament withdrawal announcements (link-out) | Link-out plus a Swoon'd one-line explainer; no medical claims | daily on event days | Hidden |
| `regulations` | Rule/tech changes | ITF Rules of Tennis, Grand Slam Rulebook, ATP and WTA rulebooks (link-out); official announcements | Curated `RuleUpdate` cards, paraphrased | on-release (annual January refresh check) | Evergreen explainer |
| `news` | Storylines | ATP, WTA and Slam news; independent tennis media | **Link-only** headlines/metadata where the licence allows; Swoon'd writes the explainer | daily | Evergreen explainer cards |
| `weather` (optional) | Rec-play and roof/rain context | National Weather Service API (US); Open-Meteo (verify non-commercial limits) | Adapter; only when `region` set | hourly | Hidden |
| `closures` (optional) | Court closures | Municipal notices (no uniform source) | Link-out | daily | Hidden |
| Local courts (optional) | Personalization | OpenStreetMap (`sport=tennis`, ODbL attribution), USTA Court Locator (link-out) | Adapter; monthly | monthly | Hidden |

**Not to use in production:** Jeff Sackmann's `tennis_atp` / `tennis_wta` datasets (CC BY-NC-SA, non-commercial) and any scraped tour site. TheSportsDB coverage of tennis is unconfirmed. UTR needs a partner agreement; NTRP is USTA-owned, so Swoon'd explains the scale but never stores ratings data.

### Season calendar (as of 2026-09-30) **[verify at release]**
- **Grand Slams 2026 (done):** Australian Open (January-February): Alcaraz and Rybakina; Roland-Garros (18 May to 7 June): Zverev and Andreeva; Wimbledon (29 June to 12 July, prize money about GBP 64.2M): Sinner and Noskova; US Open (30 Aug to 13 Sep, about USD 108M): Zverev and Rybakina.
- **Rankings snapshot 14 Sep 2026:** ATP No. 1 Sinner (11,500 pts), then Zverev, Alcaraz, Shelton, Auger-Aliassime; WTA No. 1 Rybakina (9,901 pts), then Sabalenka, Pegula, Gauff, Andreeva.
- **Autumn 2026:** Laver Cup (The O2, London, 25-27 Sep; Team Europe beat Team World 13-5); Asian swing and indoor events; **WTA Finals 8-15 Nov, reported moved to Indian Wells from Riyadh** (single source); **ATP Finals, Turin, 15-22 Nov**; **Davis Cup Finals, Bologna, 24-29 Nov**; WTA season ends 22 Nov.
- **2027:** ATP calendar published; Australian Open from 17 Jan 2027; seven of nine Masters 1000 events are 12-day, 96-player draws (Monte-Carlo and Paris excepted). LA 2028 Olympic tennis 14-30 July 2028 (five events; a 16-team mixed doubles).
- **Rules/tech:** live electronic line calling at the Australian Open, Wimbledon and US Open; Roland-Garros keeps human line judges in 2026; all ATP tour events required live electronic line calling from 2025 and the 2026 WTA rulebook likewise; wearables trial at 2026 Slams; Wimbledon 2026 reported video review for some umpire calls on select courts.

Calendar and ranking entries are stored as data with source URLs and `verifiedAt` dates, never as lesson copy.

## 4. Normalized Swoon'd entities (provider-agnostic)

Illustrative shapes (names settled by the app team; `Sendable` value types with strong IDs):

| Entity | Key fields | Notes |
|---|---|---|
| `TennisEvent` | `id`, `tour` (`atp`/`wta`/`itf`/`team`), `tier` (slam/1000/500/250/finals/team), `name`, `surface`, `startDate`, `endDate`, `city`, `country`, `status`, `sourceURL`, `verifiedAt` | Tier drives "why it matters" copy |
| `DrawEntry` | `eventId`, `draw` (ms/ws/md/wd/xd), `playerIds`, `seed?`, `entryType` (direct/wc/q/ll), `round`, `slot` | Bracket rendering and byes |
| `TennisMatch` | `id`, `eventId`, `round`, `sides[]`, `scoreline` (per-set with tiebreak digits), `winnerSide`, `status` (scheduled/live/final/retired/walkover), `format` | Results only; no point data |
| `Player` | `id`, `displayName`, `country`, `tour`, `rank`, `rankSnapshotDate`, `handedness?`, `style?` | No likeness unless licensed |
| `RankingEntry` | `tour`, `discipline`, `playerId`, `rank`, `points`, `movement`, `snapshotDate` | Movement computed by Swoon'd |
| `RaceEntry` | `tour`, `playerId`, `rank`, `points`, `qualified?`, `snapshotDate` | Year-end Finals |
| `RuleUpdate` | `id`, `body` (itf/atp/wta/slam), `effectiveDate`, `topic`, `summaryKey`, `sourceURL` | Own words |
| `Withdrawal` | `eventId`, `playerId`, `reason?`, `announcedAt`, `sourceURL` | Reason paraphrased or omitted |
| `EditorialCard` | `id`, `topic`, `conceptIds[]`, `explainer`, `links[]`, `publishedAt`, `expiresAt` | Curated |
| `LocalContext` | `region`, `weatherSummary`, `closureNote?`, `nearbyCourts[]` | Optional |

## 5. Editorial plan (spec sections 11, 37)

- **Cadence:** weekly "This week in tennis" card (Monday, after rankings); Slam-fortnight daily cards; rule/tech explainers on release; a "season rollover" card each January.
- **Method:** identify a topic from headlines (link-only), write a Swoon'd explainer in our voice (<= 120 words), map to concepts (e.g. why a match ended in a ten-point breaker -> `final-set-tiebreak`), link out. Never copy publisher text; never quote more than a short factual fragment.
- **Example prompts (Ask card):** "Why are tennis fans talking about the calendar today?", "Why did that match end in a 10-point tiebreak?", "What is a lucky loser?", "Why is Roland-Garros the one Slam with line judges?", "What is the Race?"
- **Anti-doping and legal stories:** process only (how a suspension or appeal works), never verdicts, speculation or blame.
- **Tone guardrails:** no betting content, no criticism of individuals beyond facts, nothing that gives the learner a line to fake expertise; every card ends with an honest curiosity question she could ask.

## 6. Personalization hooks

| Hook | Data used | Effect |
|---|---|---|
| `player` | `Player`, `RankingEntry`, `TennisMatch` | "Your person's favourite: this week" card; talk-track substitution; favourite player profile (`br-06`) |
| `league` (ATP/WTA/Slams) | `TennisEvent.tour` | Which events and rankings appear; default branch |
| `skill-level` | none (static) | Rec lessons and talk tracks tuned to her NTRP band |
| `equipment` | none (static) | Gear-talk cards; string-tension explainer |
| `region` | `LocalContext` | Weather, closures, nearby courts |
Unset tokens fall back to generic phrasing.

## 7. Failure, freshness and safety

- Every live card shows a snapshot date; stale data (> 14 days for rankings, > 3 days on event days) collapses to the evergreen explainer.
- Provider outage never blocks a lesson: `live` hooks are optional decoration.
- Injury/withdrawal cards never speculate about health; link out to the tournament statement.
- No live data in discreet mode notifications; notifications never contain the Person's name.
