# Live Data & Editorial Plan: Formula 1 (`formula-1`)

Implements product spec sections 10 to 12 (structured current data, editorial context, personalization) and 32 to 37 (external data architecture, sports and motorsports data, news). Companion to `CDS.md` sections 6 to 8 and `manifest.json` `dynamicData[]`. Facts marked "verified 2026-09-30" were checked by web search that day; anything else is a candidate to verify.

## 1. Does F1 need live data? Yes, focused and modest

F1 is a strong fit for the structured layer (spec section 45: "NASCAR, live data plus racing simulation plus strategy plus drivers"; the same holds for F1). A learner needs to be able to say, this week: "who won, what changed in the championship, what happened to my person's driver, when is the next race, what is the weather doing, and what is the argument about?" That is a handful of normalized entities, not a timing wall.

- **Needed:** calendar and session times, session classifications (practice, qualifying, sprint, race), driver and constructor standings, the grid (teams, drivers, numbers, engine suppliers), light race statistics (pit stops, tyre stints, fastest laps), the forecast for the race circuit, and a stream of "what are fans talking about" topics.
- **Not needed (do not invent, spec section 10):** betting odds, sub-second timing, full telemetry or car data, driver social feeds, ticket sales, fantasy-league scoring. Being a few minutes behind during a session is fine (spec section 33).
- **Structured versus editorial are separate systems** (spec sections 11 and 37): structured data says "Russell won by 0.196 s; Antonelli is P5"; editorial says why fans are talking about the safety car, clipping or a penalty, in Swoon'd's own words, with a link out.

## 2. Provider candidates and verdicts

Providers are always behind Swoon'd adapters (spec section 32); no provider schema becomes the domain model; no unofficial or reverse-engineered production endpoints (spec rule 9).

| Candidate | What it covers for F1 | Licensing and cost (as known) | Latency | Verdict |
|---|---|---|---|---|
| **Orange Cat Blacktop** (named in spec section 36) | F1 plus NASCAR, IndyCar, MotoGP, Formula E, WRC, WEC: calendar, results, standings, drivers, teams (confirm F1 depth) | Commercial API; pricing and redistribution terms to be confirmed with the vendor | Near-live during sessions (to verify) | **Primary candidate**, because one relationship covers future motorsport courses (which stay independent courses, spec section 36) |
| **Jolpica-F1** (Ergast successor) | Schedules, results, qualifying, standings, deep history; no live timing or telemetry | Server code Apache 2.0; **dataset CC BY-NC-SA 4.0**: non-commercial with attribution and share-alike; commercial use needs permission from the maintainers; unauthenticated limits about 4 requests/s burst, 500/hour sustained (verified 2026-09-30) | Minutes after sessions | **Backfill and history**, and tests, once commercial permission is granted; not for production before that |
| **OpenF1** | Historical data from 2023 free; real-time requires a paid subscription; sessions, laps, stints, pit stops, weather, positions | Free tier 3 requests/s, 30/min; licensed for educational, research and non-commercial fan use; commercial use needs an arrangement (verified 2026-09-30) | Live on paid tier | **Statistics candidate** (stints, pit stops) after licensing; not for production before that |
| API-Sports Formula 1 | Races, standings, drivers, teams, pit stops (verify coverage) | Commercial tiers (verify) | Minutes | Fallback candidate |
| SportMonks Formula 1 | Schedules, results, standings (verify) | Commercial tiers (verify) | Minutes | Fallback candidate |
| TheSportsDB (spec section 34) | Light F1 coverage: events and results; team and league metadata | Inexpensive; terms to check | Minutes to hours | **Fallback for schedules and results** only |
| Sportradar / SportsDataIO (spec section 35) | Enterprise motorsport feeds | Expensive; enterprise contracts | Sub-minute | Upgrade path only if coverage or reliability requires |
| Official F1 or FOM data (formula1.com live timing) | The source of truth | No public API; FOM data rights are licensed commercially; scraping or unofficial endpoints (F1 livetiming, FastF1 wrappers) are **not allowed in production** | n/a | Link out only |
| Apple WeatherKit (iOS native) / Open-Meteo | Hourly forecast and precipitation for a circuit's coordinates | WeatherKit requires attribution and an Apple developer entitlement; Open-Meteo is free for non-commercial use with a commercial plan (verify) | Hourly | **Weather**: WeatherKit on iOS; Open-Meteo or a national service for the Android parity phase |

**Decision needed (DECISIONS Q-3 and CDS open question 1):** choose the commercial structured provider (recommended: Orange Cat Blacktop, with TheSportsDB as fallback for schedules and results) and get written permission for any use of Jolpica or OpenF1 data.

## 3. Normalized entities (Swoon'd domain model)

Swoon'd owns these types (Core, Foundation-only). Provider DTOs are internal to adapters. IDs are Swoon'd's own and stable across providers: `f1:season:2026`, `f1:round:2026-15`, `f1:driver:kimi-antonelli`, `f1:team:mercedes`, `f1:circuit:baku`.

| Entity | Fields (essential) | Notes |
|---|---|---|
| `Season` | `year`, `regulationEra`, `roundCount`, `pointsScale`, `status` | `regulationEra` e.g. `2026-power-unit-era`; drives which lessons and terms are current |
| `Circuit` | `id`, `name`, `city`, `country`, `lat`, `lon`, `type` (street, permanent, semi-permanent), `lengthKm`, `laps`, `personalityTags` (top speed, downforce, traction), `overtakingDifficulty`, `straightModeZones?` | Static primer data; `straightModeZones` is editorial (verified per season) |
| `Round` | `id`, `season`, `number`, `name` (Grand Prix name), `circuitId`, `startsAt`, `hasSprint`, `status` (scheduled, live, final, cancelled, relocated), `hostNote` | `relocated` models the 2026 Bahrain GP at Sepang; `cancelled` models Saudi Arabia |
| `Session` | `id`, `roundId`, `kind` (fp1, fp2, fp3, sprint-qualifying, sprint, qualifying, race), `startsAt`, `status`, `neutralisations[]` (SC/VSC/red flag laps) | |
| `Team` | `id`, `name`, `constructorName`, `engineSupplierId`, `isWorks`, `colourToken` (Swoon'd neutral token, not a livery), `since` | |
| `Driver` | `id`, `displayName`, `number`, `code`, `nationality`, `teamId`, `seatStatus`, `juniorProgramme?` | Text only; no likeness (CDS section 13) |
| `Entry` | `seasonId`, `teamId`, `driverId`, `carNumber`, `fromRound`, `toRound?` | Handles mid-season swaps and reserves stepping in |
| `SessionClassification` | `sessionId`, rows: `position`, `driverId`, `timeOrGap`, `laps`, `status` (finished, dnf, dsq), `gridPosition?`, `points?`, `fastestLap?` | The core "result" shape |
| `Standings` | `seasonId`, `kind` (drivers, constructors), `afterRound`, rows: `position`, `entityId`, `points`, `wins`, `podiums?` | Also feeds `title-permutations` |
| `PitStop` | `sessionId`, `driverId`, `lap`, `stationaryS?`, `laneS?`, `fromCompound?`, `toCompound?` | Statistics (optional) |
| `Stint` | `sessionId`, `driverId`, `compound`, `lapStart`, `lapEnd`, `ageAtStart` | Powers "decode the race" cards |
| `WeatherForecast` | `roundId`, `hours[]`: `time`, `rainChancePct`, `tempC`, `windMs`, `trackWetnessHint?` | Attribution carried with the record |
| `StewardDecision` | `sessionId`, `driverId`, `kind` (time-penalty, grid-drop, reprimand, none), `seconds?`, `reasonCode`, `documentUrl` | Link out to the FIA document; text is Swoon'd's own |
| `RegulationEvent` | `id`, `date`, `kind` (technical-directive, rule-change, power-unit-decision), `topicIds[]`, `sourceUrl` | Feeds editorial (compression-ratio row, ADUO checkpoints, mid-season package) |
| `NewsHeadline` | `id`, `publisher`, `title`, `url`, `publishedAt`, `topicIds[]` | Headline and link only; never body text |
| `EditorialTopic` | `id`, `title`, `whyFansCare`, `explainerMarkdown` (Swoon'd-authored), `linkedConceptIds[]`, `sources[]`, `validFrom`, `validTo`, `personalizationHints` | The unit of the editorial layer |
| `LiveContext` | the assembled object returned by `LiveDataRepository.liveContext(courseId:personalization:)`: next round, last classification, standings snapshot, personalised cards, topics | Produced by the Course Interpretation step |

## 4. Adapter architecture and failure handling

```
Provider (Orange Cat Blacktop / TheSportsDB / OpenF1 / Jolpica / WeatherKit)
   -> Provider adapter (MotorsportsDataProvider, internal DTOs)
   -> Normalized types (section 3)
   -> Course Interpretation (Formula 1 templates: lesson cards, Daily Bites, Talk prompts)
   -> User experience (season-live unit, feed, Talk, notifications)
```

- **Protocols (Core):** `MotorsportsDataProvider` with `schedule(season)`, `classification(session)`, `standings(season, kind)`, `roster(season)`, `pitStops(session)`, `stints(session)`; `WeatherProvider` with `forecast(circuit, range)`; `EditorialRepository.topics(courseId:personalization:)`.
- **Multiple providers:** the repository merges by priority (primary commercial, then fallback); disagreements are logged and the primary wins; adapters never expose provider fields.
- **Caching:** last good response stored on device with a timestamp; results and standings for completed sessions are immutable after the classification is final (except post-race penalties, which update via a `StewardDecision` re-fetch for 24 hours).
- **Stale-state UX:** every live card shows "as of" time; when the provider is down the card shows the last good value with "updated 3 hours ago"; a session in progress shows "live data is delayed".
- **Fallback when a provider is down:** switch to the fallback provider for schedules, results, standings; drop statistics cards; skip the weather card; keep editorial explainers (they are Swoon'd-authored and cached). The evergreen course never depends on live data.
- **Offline:** the content pack bundles the 2026 calendar, roster and circuit primers (static), so the season-live unit always has something to teach (it degrades to "last known" and evergreen primers).

## 5. Refresh cadence

| Data | Cadence | Notes |
|---|---|---|
| Season calendar and session times | Daily; hourly during a race week | Rounds can be relocated or cancelled (2026 Bahrain and Saudi) |
| Session classifications | Every 1 to 2 minutes while a session is live; then final once | A few minutes' delay is acceptable |
| Standings | On session final; daily otherwise | Also refresh after steward reviews |
| Roster and seats | Weekly; immediately on announcements (editorial) | Silly season |
| Pit stops, stints | Race day: every 2 minutes during the race; final after | Optional |
| Weather forecast | Hourly for the next round's circuit on race weekends; daily otherwise | |
| Headlines | Hourly | Topic clustering runs after each fetch |
| Regulation events | Weekly, plus on FIA document publication | |
| Editorial explainers | Weekly cycle below | Human-reviewed |

**Race-weekend editorial rhythm (a `season-live` template refresh):**

| When | What refreshes |
|---|---|
| Monday to Wednesday | "Last race in plain English" (`sl-02`); title picture (`sl-03`); driver and team cards |
| Wednesday or Thursday | "This weekend: what to watch" (`sl-01`): circuit personality, tyre picks, weather, sprint or not; circuit primer (`sl-08`) |
| Friday | Practice notes: who looked quick on long runs (`race-pace-vs-quali-pace`, `long-run`) |
| Saturday | Qualifying decode; sprint decode; "why did they start there?" |
| Sunday and Monday | Race recap; strategy story of the race (undercut, safety car); new Talk prompts |

## 6. Live-layer lesson templates (unit `season-live`)

The curriculum unit carries a `live` block (`adapterKey`, `dataKind`, `refreshHint`) and lesson content is generated from templates, not hard-coded. Bindings:

| Lesson template | adapterKey / dataKind | Generated from | Concepts boosted in review |
|---|---|---|---|
| `sl-01-this-weekend-preview` | `formula-1.weekend` / `schedules` | `Round`, `Circuit`, `WeatherForecast`, tyre allocation (editorial) | `hard-medium-soft`, `street-circuit`, `sprint` |
| `sl-02-last-race-decoded` | `formula-1.recap` / `scores` | `SessionClassification`, `Stint`, `PitStop`, `StewardDecision`, editorial topics | `undercut`, `safety-car-stop`, `time-penalty` |
| `sl-03-the-title-picture` | `formula-1.standings` / `standings` | `Standings` (both), remaining rounds and points available | `title-permutations`, `points-system` |
| `sl-04-your-driver-now` | `formula-1.driver` / `statistics` | Driver's classifications, teammate delta (qualifying and race), topics tagged to the driver | `teammate-battle`, `race-pace-vs-quali-pace` |
| `sl-05-your-team-now` | `formula-1.team` / `standings` | Constructors' position, upgrades (editorial), reliability record | `constructors-championship`, `reliability` |
| `sl-06-rules-in-play` | `formula-1.regulations` / `events` | `RegulationEvent` and editorial (mid-season tweaks, compression-ratio row, ADUO checkpoints) | `technical-directive`, `aduo`, `compression-ratio` |
| `sl-07-silly-season-now` | `formula-1.market` / `rosters` | `Entry` changes, editorial rumours labelled as such | `driver-market`, `junior-programme`, `super-licence` |
| `sl-08-next-circuit` | `formula-1.circuit` / `schedules` | `Circuit` primer and next `Round` | `street-circuit`, `pit-window`, `track-evolution` |

Each template yields: (a) one "what just happened" feed card in Swoon'd's own words, (b) three to five Daily Bite items (say-this, multiple-choice, estimate-slider from real numbers), (c) one or two Talk prompts, and (d) the concept links to the Playbook. Example, from the 2026-09-30 snapshot: after Azerbaijan the recap template can say "Russell won by 0.196 s after a safety-car period erased his gap" and link the say-this line "The safety car ruined his ten-second lead" to `safety-car`.

## 7. Personalization hooks

| Dimension | Uses in live data |
|---|---|
| `team` | Pins the team's session results, standings position, upgrades and radio-moment topics to the top; drives `sl-05`; tint of the accent ring (neutral token) |
| `driver` | `sl-04`; "your driver this weekend" card; Talk tracks that reference the driver's storyline; teammate delta |
| `region` | Nearest Grand Prix and time-zone-aware session times ("Qualifying is at 9 pm your time"); `sl-08` primers; "which race would you go to" content |

Rules: personalization missing means generic content with the defaults (team `Ferrari`, driver `Charles Leclerc`, region `Monza`); **discreet mode** stays on by default, so notifications never contain the Person's name (they say "qualifying starts in one hour", never "Sarah's driver"); live cards never expose the Person's name to any provider or to analytics.

## 8. Editorial plan (spec sections 11 and 37)

- **Principle:** identify what fans are discussing, explain it educationally in Swoon'd's own words, teach the vocabulary, explain why enthusiasts care, and link to the original publisher. Never copy article text; never reproduce team-radio transcripts beyond a very short quoted phrase when teaching (prefer paraphrase); never provide legal or betting advice.
- **Topic pipeline:** headlines fetched hourly (headline and link only) -> clustered by topic -> matched to a topic taxonomy (strategy, penalty, regulation, power unit, driver market, upgrade, reliability, safety) -> Swoon'd content team (Haiku drafts, human review; D-006) writes or updates an `EditorialTopic` explainer of about 120 words with concept links -> shown in the feed and the Talk prompt bank. The same topic is not rewritten if nothing new happened.
- **Explainer template:** "What happened" (2 sentences), "Why fans care" (2 sentences), "The term to know" (concept link), "A good question to ask" (one line), "Read more" (publisher link).
- **Seed topics for launch (from CDS section 4):**
  1. Clipping and energy management: why cars slow at the end of straights, and the mid-season tweaks (qualifying recharge limit cut from 8 to 7 MJ, super-clip allowance raised to 350 kW, verified 2026-09-30).
  2. The compression-ratio row: why measuring hot as well as cold mattered (controlled hot and cold from 1 June 2026, hot only from 2027).
  3. ADUO: what it is and what the checkpoints after rounds 6, 12 and 18 mean for engine makers.
  4. Active aero and Overtake Mode: how passing changed without DRS.
  5. Stewarding consistency: why penalties spark arguments; penalty-points reform for 2026.
  6. The calendar under pressure: Saudi Arabia cancelled, Bahrain relocated to Sepang, Madrid as a new street venue.
  7. Silly season: how seats become available, and who is out of contract (labelled as reports, not facts).
  8. The title fight: a plain-English explanation of the current championship picture.
- **Sensitive-topic policy:** crashes, injuries and deaths get respectful, brief, non-speculative treatment; no medical speculation; no rumours about private lives; no gambling framing.
- **Cadence and ownership:** one editorial producer per race weekend; a weekly review pass; a "correction" path when facts change (for example a penalty amended after the race).

## 9. Licensing and rights summary

| Area | Policy |
|---|---|
| Structured data | Only providers with written commercial permission in production; Jolpica-F1 and OpenF1 need commercial arrangements (see section 2); attribute where required; respect rate limits |
| FOM data, timing screens, broadcast graphics | Not used; link out to formula1.com |
| Photos, videos, radio | Not used (CDS section 13) |
| Headlines and links | Headline text and link only; check each publisher's terms; no article bodies |
| Weather | Follow provider attribution (WeatherKit requires attribution) |
| Regulations | FIA regulation documents are linked, and our explanations are our own words |
| Trademarks | Plain text names only; non-affiliation footer |

## 10. Season rollover and change management

- **New season:** new `Season` record, roster and calendar import, a "new-season reset" unit like `the-2026-reset` if the rules or line-ups change, a season-in-review unit in December, and archived recaps.
- **Mid-season change:** rule tweaks (April 2026 package), technical directives and ADUO decisions are handled as `RegulationEvent` plus an editorial topic, not by rewriting evergreen lessons; the affected exercise numbers (for example the qualifying recharge limit) are re-verified before each season and after WMSC decisions.
- **Calendar disruptions:** `status` values `cancelled` and `relocated` are first-class; the 2026 example (Saudi cancelled, Bahrain at Sepang on 4 October) must render sensibly ("Bahrain Grand Prix, held at Sepang, Malaysia").
- **Regulation-era metadata:** the season's `regulationEra` selects which lessons show "current" badges and which are marked "history".

## 11. Fixture snapshot for tests (verified 2026-09-30, after round 15)

Use this as a bundled fixture for adapter tests and previews; re-fetch from the provider in production.

- **Calendar (2026):** 23 rounds after changes. Saudi Arabian GP cancelled (Middle East conflict); the Bahrain GP relocated to Sepang, Malaysia, on 4 October; Madrid hosts the Spanish GP on 13 September; sprint weekends: China, Miami, Canada, Britain, Netherlands, Singapore. Remaining after Azerbaijan (26 September): Bahrain GP at Sepang (4 October), Singapore (11 October, sprint), United States (25 October), Mexico City (1 November), Sao Paulo (8 November), Las Vegas (21 November), Qatar (29 November), Abu Dhabi (6 December). Confirm each date with the adapter.
- **Drivers' standings (after round 15, top six):** Antonelli 302, Russell 236, Hamilton 199, Norris 186, Leclerc 179, Verstappen 163.
- **Last race:** Azerbaijan GP, 26 September 2026: Russell won by 0.196 s over Verstappen, Hadjar third; Russell took pole and led every lap (a grand slam); two safety-car periods; Antonelli climbed from 16th to fifth.
- **Grid:** 11 teams, 22 drivers (Alpine: Gasly, Colapinto; Aston Martin: Alonso, Stroll; Audi: Bortoleto, Hulkenberg; Cadillac: Perez, Bottas; Ferrari: Leclerc, Hamilton; Haas: Ocon, Bearman; McLaren: Norris, Piastri; Mercedes: Antonelli, Russell; Racing Bulls: Lawson, Lindblad; Red Bull: Verstappen, Hadjar; Williams: Albon, Sainz). Engine suppliers: Mercedes (Mercedes, McLaren, Williams, Alpine), Ferrari (Ferrari, Haas, Cadillac), Honda (Aston Martin), Audi, Red Bull Ford (Red Bull, Racing Bulls).
- **Regulation events:** April 2026 package (qualifying recharge 8 to 7 MJ; super-clip allowance 250 to 350 kW; low-power start detection; boost cap changes); compression ratio controlled hot and cold from 1 June 2026; ADUO checkpoints after rounds 6, 12, 18.

## 12. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Choose the commercial motorsport provider and get written terms (recommended: Orange Cat Blacktop with TheSportsDB as fallback) | Product | Blocking for the live layer |
| 2 | Permission or paid plan for Jolpica-F1 (history/backfill) and OpenF1 (statistics)? | Product | No |
| 3 | News/editorial provider licensing (DECISIONS Q-3): headline API or RSS only | Product | Blocking for topic clustering |
| 4 | Editorial staffing model per race weekend (Haiku drafts plus human review) | Product | No |
| 5 | Android weather provider (WeatherKit is Apple-only) | Claude | No |
| 6 | Whether to show teams' colours at all in live cards (legal read on team name plus colour) | Product / Legal | No |
