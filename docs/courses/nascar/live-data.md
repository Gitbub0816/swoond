# NASCAR: Dynamic Data & Editorial Plan

Course `nascar`. Implements product spec sections 10-12 (structured current data, editorial context, personalized context) and 32-37 (external data architecture, sports and motorsports data, news). NASCAR has strong live-data value: a season is 36 race weekends, a championship that changes weekly, and fans who talk about last Sunday on Monday. Section 38 (no live data) does not apply.

Principles: Provider -> Provider Adapter -> Swoon'd normalized entities -> Course interpretation (`live` unit hooks) -> UX. Structured data and editorial data are separate systems. The learner is usually fine being a few minutes behind (spec section 33); we are not a timing feed. Static lessons never hard-code winners, standings, rosters or current storylines; those come only through hooks.

## 1. Data kinds and providers (candidates only)

| Kind (manifest) | Used for | Provider candidates | Refresh | Adapter fallback |
|---|---|---|---|---|
| schedules | Next race, calendar, series schedules, Chase race list | Orange Cat Blacktop (spec candidate, verify NASCAR coverage), Sportradar or SportsDataIO (enterprise upgrade path), manual editorial calendar | daily; hourly on race day | Bundled season calendar JSON, badge "may be outdated" |
| scores (results) | Race results, running order, winner, stage winners, laps led | Orange Cat Blacktop, TheSportsDB (evaluate motorsport depth) | minutes during events (5 min cadence), final results within hours, corrected results within 24 h | Show last cached result with timestamp; hide "live" badge |
| standings | Points, Chase seeding and Chase standings, series standings | Orange Cat Blacktop, Sportradar | daily; after every race; also daily in the Chase | Cached standings |
| statistics | Wins, laps led, average finish, top-10s for story cards | Orange Cat Blacktop | weekly | Card hidden |
| rosters | Drivers, teams, manufacturers, car numbers, crew chiefs | Orange Cat Blacktop plus manual editorial roster review | monthly and on change (silly season, mid-season swaps) | Bundled snapshot with `asOf` date |
| events | Race weekend info (practice, qualifying, race times), TV listings as link-outs | Schedule provider, broadcaster pages (link-only) | weekly; hourly on race weekends | Static link |
| news | Which stories are current (for editorial explainers) | Licensed news API (open decision Q-3), publisher RSS as link-only | hourly | Evergreen "why this matters" cards |
| weather | Rain delays, race-day conditions for the next race | NWS, Open-Meteo | hourly on race days | Hidden |

Not needed (spec: do not invent live needs): rankings, releases, closures, alerts, new products, new media.

### Licensing notes
- No unofficial or reverse-engineered feeds and no scraping (CLAUDE.md rule; spec section 32). NASCAR.com live feeds, Racing-Reference and team sites are not consumed programmatically.
- TheSportsDB is inexpensive but motorsport coverage may be thin; treat as a fallback for schedules/results only after evaluation.
- Orange Cat Blacktop is named in the spec (section 36); coverage, terms and pricing for NASCAR series are unverified in this repo (open question). One motorsports provider does not imply one course: F1 and IndyCar use separate curricula and separate adapter instances (spec section 36).
- Enterprise providers (Sportradar, SportsDataIO) are upgrade paths, not MVP dependencies.
- Driver and team names are factual identifiers in text; no likeness, logos or livery images come from providers.
- Attribution: display provider attribution where terms require; store provider terms per adapter.

## 2. Normalized entities (Swoon'd-owned, provider-agnostic)

Names are proposals for the `LiveDataRepository` contracts in SwoondCore; provider DTOs never leave the adapter.

| Entity | Key fields | Notes |
|---|---|---|
| `Series` | `id` (cup, oreilly, trucks), `displayName`, `seasonYear` | Maps to course branches |
| `Race` | `id`, `seriesId`, `seasonYear`, `round`, `name`, `trackId`, `startsAt`, `laps`, `miles`, `status` (scheduled/live/final/delayed), `isChase`, `isFinale`, `broadcastLinks[]` | `isChase` and `isFinale` support the live layer and finale storylines |
| `Track` | `id`, `name`, `city`, `lengthMiles`, `kind` (short, intermediate, superspeedway, road-course, roval), `banking`, `surface` | Also drives `tracks-air` personalization and previews |
| `Result` | `raceId`, `finishPosition`, `driverId`, `teamId`, `startPosition`, `lapsLed`, `stagePoints`, `racePoints`, `status`, `lapsCompleted` | Non-finishers included |
| `StageResult` | `raceId`, `stage`, `top10[]` | For stage-strategy explainers |
| `StandingsEntry` | `seriesId`, `seasonYear`, `driverId`, `rank`, `points`, `wins`, `chaseSeed?`, `gapToLeader`, `asOfRaceId` | Chase flags computed by Swoon'd rules, not provider |
| `Driver` | `id`, `displayName`, `carNumber`, `teamId`, `manufacturerId`, `seriesIds[]`, `archetypeTags[]` | Archetypes (short-track ace, road-course ringer) are editorial |
| `Team` | `id`, `displayName`, `manufacturerId`, `charter` (yes/no/n-a), `driverIds[]` | Charter status is editorial-verified |
| `Manufacturer` | `id` (chevrolet, ford, toyota) | |
| `ContextCard` | `id`, `kind` (recap, preview, chase-picture, storyline), `raceId?`, `driverId?`, `bodyMarkdown`, `links[]`, `validFrom`, `validUntil` | Editorial system output (section 5); links to publishers |
| `LiveHook` | `unitId`, `lessonTemplateId`, `binding` (which entities fill which tokens) | Course interpretation layer |

Chase logic (seeding, reset values 2,100/2,075/2,065/2,060 then -5 to 2,000, most points after the finale wins) is computed by Swoon'd from `StandingsEntry` and rules config, not consumed from a provider, so a provider outage or format change is a config update (`rules-2026` tag).

## 3. Adapter and caching architecture

- Protocols in SwoondCore: `ScheduleRepository`, `ResultsRepository`, `StandingsRepository`, `RosterRepository`, `NewsRepository`, `WeatherRepository` (all behind `LiveDataRepository`). Adapters: `OrangeCatBlacktopAdapter`, `TheSportsDBAdapter`, `ManualEditorialAdapter` (bundled JSON for rosters and calendars). Adapter selection per course via config, so F1 can use the same vendor without sharing the model.
- Local cache with `fetchedAt` and TTL by kind (section 1); stale-while-revalidate; staleness shown in UI ("Updated 2 h ago").
- Race-day polling cadence: every 5 minutes from green flag to final; otherwise per table. No push infrastructure required at launch; optional notifications are discreet (no person names, CLAUDE.md) and only about the learner's followed race ("Race day is tomorrow").
- Outage behavior: lessons always work; live cards show last cached data or hide; never block a static lesson. Mock backend (D-004) supplies fixture data for development.
- Normalization tests: golden-file fixtures per adapter; a 2026 Chase fixture (16 drivers, seeds, reset values) verifies the Chase logic.

## 4. Live units and templates (`this-season`, plus hooks)

| Template (lesson id) | Hooks | Refresh | Content |
|---|---|---|---|
| Race preview (`live-01`) | schedule, track, standings, weather | weekly (Tue) | `{{nextRace}}`: track type, what to watch (strategy, pack racing, rubber), Chase relevance, a `say-this` set, link-out to broadcast |
| Last race, explained (`live-02`) | results, stage results, news | after each race (Mon) | Winner and how (track position, fuel, speed), pit strategy story, one controversy explained in our words with links; 3 exercises |
| Chase picture (`live-03`) | standings, rules config | after each Chase race | Seeds, gap to leader, what the finale means, `estimate-slider` on point gaps |
| {{driver}} this week (`live-04`) | results, standings, roster | weekly | The learner's person's driver: last finish, season arc, what to ask |
| Why are fans talking about this? (`live-05`) | news, editorial | as needed (2-3 per week) | ContextCard explanation plus `say-this` |
| What to say Monday (`live-06`) | all above | weekly | `talk-track` built from the week's storylines |

New items ship every race week (36 per season) and at season boundaries (schedule, rules, rosters). Items carry `validUntil` and expire; a "Catch up" card shows the last two weeks for returning learners.

## 5. Editorial plan (spec sections 11 and 37)

- **Separate system.** A News provider identifies current topics; Swoon'd writes an original explanation (why it matters, terms to know, what fans debate) and links to the original publisher. No article text is copied; headlines are identifiers with links, no publisher images.
- **Workflow.** Editorial queue (human-in-the-loop for launch): topics ranked from provider news and Swoon'd's own weekly race review; each ContextCard is 90-140 words, uses only vocabulary from the concept inventory, and links to 1-3 sources. AI-drafted, human-reviewed for factual and voice checks (cheeky coach, warm, never mean, never about the crush).
- **Recurring formats.** "Why are fans talking about this today?", "What is [term]?", "Explain this pit call", "What changed about the rules?", "What does this penalty mean?", "Chase picture in 60 seconds".
- **Explained topics (manifest `topicsWeExplain`).** Pit calls, penalties, rule and format changes, driver storylines, championship math.
- **Sources (link-only unless licensed):** NASCAR.com, team and manufacturer newsrooms, Jayski, Frontstretch, Racer, Motorsport.com.
- **Rule/format changes** are a first-class editorial event: when NASCAR changes a rule, the affected `rules-2026` concepts are flagged, a "What changed" card is published, and review items are rewritten before the next race.

## 6. Personalization hooks (spec section 12)

| Dimension | Hook | Effect | Default |
|---|---|---|---|
| series | `Series` | Feeds and examples default to Cup, O'Reilly or Trucks | Cup |
| driver | `Driver` | `{{driver}}` in `live-04`, talk lines; the "Monday" track references their recent result and archetype | Current Cup points leader |
| team | `Team` | Team stories, teammates, charter status in `teams-people` and previews | Team of the default driver |
| brand (manufacturer) | `Manufacturer` | Manufacturer-flavored examples; alliance stories | none (neutral) |
| region / home track | `Track` | `{{track}}` used in track lessons and race previews; tie-in when the home race is within 14 days | The next race's track |

The foundational curriculum is unchanged by personalization; only examples, the live feed order and card content change. Personalization data never appears in notifications while discreet mode is on.

## 7. Refresh calendar (per season)

| Period | Cadence | Notes |
|---|---|---|
| Off-season (Nov-Jan) | weekly | Rosters, rules changes, schedule release, "What changed this year" units |
| Regular season (Feb-Aug, 26 races) | weekly, hourly on race days | Preview Tuesday, recap Monday |
| The Chase (Sep-Nov, 10 races) | daily standings, weekly cards | Chase picture after each race; finale coverage at Homestead |
| Special events | as scheduled | Daytona 500, Coca-Cola 600, Southern 500, All-Star Race (2026 at Dover): each gets a "why it matters" card |

## 8. Risks and open items

- Provider coverage/price for NASCAR series unverified (Orange Cat Blacktop); manual editorial fallback keeps the layer alive with a smaller scope.
- News licensing (Q-3) gates editorial automation; launch with hand-curated evergreen cards plus link-only.
- 2026 rule facts (Chase reset, charter terms, horsepower by track, stage-length policy) can change; all live in a versioned rules config and tagged `rules-2026`.
- O'Reilly and Truck series data parity (results, standings) must be confirmed per provider before branches ship.
- Time-zone and broadcast listings are link-out only (rights).
