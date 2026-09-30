# Hockey: Dynamic Data and Editorial Plan

Implements product spec sections 10-12 (structured current data, editorial, personalized context) and 32-37 (external data architecture, sports data strategy, TheSportsDB, enterprise providers, news). Companion to `CDS.md` sections 6-8 and `manifest.json` `dynamicData[]` / `editorial`.

Status: draft. Provider names are candidates only; nothing here commits to a vendor. Facts about the 2026-27 season below were checked on 2026-09-30 and must be re-verified before the live layer ships (dates move).

## 1. Principles

1. **Swoon'd is not ESPN** (spec section 33). A learner needs: the recent result, the current score, the next game, standings, basic player information, basic statistics and current context. A few minutes behind during games is fine. No betting-grade or play-by-play feeds.
2. **Provider -> adapter -> Swoon'd normalized data -> course interpretation -> UX** (spec section 32). No provider payload becomes a domain type; provider DTOs stay internal to their adapter.
3. **Structured data and editorial data are separate systems** (spec section 11). A score tells her the result; editorial explains why the fans are talking about it.
4. **Do not invent live needs.** Hockey needs scores, schedules, standings, limited statistics, rosters/injuries, calendar events and news. It does not need weather, closures, alerts, rankings, releases or new-product data.
5. **Live data never appears in static lessons.** Lessons hold templates with tokens; a `live` unit hook fills them (curriculum `live.dataKind`, `refreshHint`, `adapterKey`).
6. **No unofficial or reverse-engineered production APIs.** The leagues' public web endpoints are undocumented and are not a licensed source; they are not used.

## 2. Data needs (spec sections 10, 33)

| Kind | Needed | Used for | Refresh | Granularity we store |
|---|---|---|---|---|
| Scores | yes | Live companion, "last night" card, talk-track context | minutes during events | game id, teams, period, clock (optional), score, status, final result, overtime/shootout flag |
| Schedules | yes | "Next game", watch-together nudge, season calendar | daily | game id, start time (UTC), teams, venue text, broadcast note (text only), league |
| Standings | yes | Playoff race, wild card, points lessons | daily; hourly on game days late in the season | team, GP, W, L, OTL, points, regulation wins, ROW, division, conference, wild-card rank; PWHL: points under 3-2-1-0 |
| Statistics | limited | Goalie save %, power play %, penalty kill %, top scorers | daily | team and player basics only at launch; advanced stats (Corsi, xG) are optional upgrade |
| Rosters / injuries | yes (limited) | `{{player}}` examples, "who is out" context | daily | player name, position, jersey number, status (active, injured, scratched) |
| Events | yes | Draft lottery, deadline, free agency, outdoor games, All-Star, Olympics/Worlds | seasonal, plus dates from calendars | event id, type, start/end date, description text, link |
| News | yes | Editorial layer | hourly | headline, source name, url, published time, topic tags (no body text) |
| Rankings, weather, closures, alerts, conditions, releases, new products, new media | no | | | |

## 3. Adapter architecture

### 3.1 Normalized domain (owned by Swoon'd)

`League` (`nhl`, `pwhl`, `international`), `Team`, `Player`, `Game`, `StandingRow`, `RosterEntry`, `Transaction`, `CalendarEvent`, `Headline`, `PointsRule` (`nhl-2-1-0`, `pwhl-3-2-1-0`).  The `PointsRule` is data, not code branches: standings math and the copy in lessons (`comp-points`, `pwhl-points-playoffs`) read it.

Repository protocols in SwoondCore (ARCHITECTURE and D-004): `LiveDataRepository` with one adapter per provider and per `dataKind`. Adapter keys used by curriculum `live` blocks:

| adapterKey | data | note |
|---|---|---|
| `hockey.live.scores` | games in progress and recent finals | filtered by league and, when set, `team` |
| `hockey.live.schedule` | upcoming games | |
| `hockey.live.standings` | table by league | |
| `hockey.live.roster` | roster and injury status | |
| `hockey.live.events` | calendar events | |
| `hockey.live.headlines` | news headlines and links | editorial system only |

### 3.2 Provider candidates (behind adapters)

| Candidate | Role | Notes and open questions |
|---|---|---|
| TheSportsDB | Starter provider for mainstream sports data (spec section 34) | Verify NHL, PWHL and international coverage, rate limits, caching and redistribution terms, image licensing (we do not use provider images). |
| Sportradar, SportsDataIO | Upgrade path if coverage or reliability is not enough (spec section 35) | Cost; advanced stats; likely NHL-strong, PWHL uncertain. |
| League and team sites | Link-only destinations for "read more" | Not a data source (no documented licensed API). |
| Motorsport provider (Orange Cat Blacktop) | Not applicable | Named in spec section 36 for motorsport only. |
| PWHL feed | Unknown | The league runs its own stats platform; a licensed feed may not exist. Until then PWHL shows static content and links (Open question 2). |

Switching providers must not change course content: adapters output the normalized types above.

### 3.3 Data quality checks (adapter side)

- Plausibility: scores non-negative, periods 1-3 (plus overtime), regular-season overtime is 5 minutes and only one shootout.
- Standings: points equal 2 x wins + OTL (NHL) or 3-2-1-0 (PWHL); flag a mismatch and fall back to the previous good table.
- Team mapping table (provider id to our `Team` id) maintained by us; unknown teams are dropped with a telemetry counter.
- Timestamps normalized to UTC; displayed in the learner's time zone.

## 4. Refresh policy, caching and staleness

| Kind | Poll | Cache TTL on device | "As of" label shown after |
|---|---|---|---|
| Scores | every 60-120 s in a game window for the person's team (or all games if none selected); off otherwise | 2 min | 5 min |
| Schedule | once daily | 24 h | never (static) |
| Standings | daily; hourly on game days in March-April (regular season) and none in the offseason | 6 h | 24 h |
| Roster / injuries | daily | 24 h | 48 h |
| Events | weekly, refreshed daily around key dates | 7 d | never |
| Headlines | hourly | 1 h | 6 h |

Backend polling is centralized (one fetch, many learners) once the backend exists (D-004, Q-2); the local mock uses bundled JSON fixtures. Discreet mode: nothing in a notification contains the Person's name.

## 5. Fallbacks

| Situation | Behavior |
|---|---|
| Provider down or rate-limited | Serve the last cache with an "as of" label; hide the live companion; keep lessons and review fully working. |
| No team selected | League-wide featured game and top storylines; the player and team tokens use defaults (`the team`, `the star`). |
| Off-season | Switch the live layer to the offseason calendar: draft, free agency, next-season preview, rule changes. |
| PWHL data unavailable | Show a static "how the PWHL works" card and a link to the league; the branch still teaches rules. |
| Playoff-only or bye days | Show the series status card (Game N of 7) from schedule data. |

## 6. The season-live layer (units and lesson templates)

Unit `season-live` (layer `current-season`, `live` hook) ships templates, not authored scores. Each lesson is a card template that renders from normalized data and always ends in a say-this or talk-track item.

| Lesson id | Inputs | Template (tokens are resolved at render time) | Editorial slot |
|---|---|---|---|
| `live-this-week` | last 7 days of games, headlines, injuries | "This week {{team}} went {{recordThisWeek}}. The big story: {{storylineTag}}." | Explain the storyline in our own words; link headline |
| `live-standings` | standings table | "{{team}} has {{points}} points in {{gamesPlayed}} games, {{wildCardGap}} from the last playoff spot." | Explain points and the tiebreaker if relevant |
| `live-playoff-race` | standings, schedule | "Who's in, who's out, who is on the bubble." | Explain what the race needs |
| `live-game-companion` | live score, clock, penalties | "It's {{score}} in the {{period}}. Watch for: {{powerPlayOrPullTheGoalie}}." | None (structured only) |
| `live-season-calendar` | events | Where we are in the calendar and what is next | Explain draft/deadline/free agency |
| `live-deadline` | events, standings | "The deadline is {{daysToDeadline}} days away. {{team}} has {{capSpace}} cap space." | Explain rentals, cap hit, why a trade matters |
| `live-playoffs` | series data | "{{team}} leads the series {{seriesScore}}. Game {{gameNumber}} is {{when}}." | Explain series lingo and home ice |

Cap or contract numbers are shown only when the provider licenses them; otherwise the card explains the concept without a number.

## 7. Editorial plan (spec sections 11, 37)

**Goal.** Turn a current event into an educational moment: "Why are fans talking about this today?"

**Pipeline.**
1. A licensed news adapter (Q-3) delivers `Headline` records: headline, source, url, time, topic tags. No article bodies.
2. A topic classifier maps the headline to a topic from our own library: *trade*, *injury*, *suspension*, *coaching decision*, *rule/review controversy*, *slump*, *milestone*, *playoff race*, *league news*.
3. For each topic we hold **Swoon'd explainer cards** written by us (2-4 sentences, plain English, one "say this" line), for example:
   - *Why does a trade for a "rental" matter?* Rental means a player on an expiring contract who will be a free agent in the summer. The buyer gets help for the playoff push; the seller gets picks. It matters because the cap hit is temporary but the pick is forever.
   - *Why is goalie interference so argued?* The rule says an attacker cannot impair the goalie, but judging "impair" is subjective, so the same play can be a goal or no goal. Fans argue about consistency.
   - *Why are the Power Play numbers a big deal?* Special teams decide close games, so a long drought raises the pressure on the setup and the entry.
4. The learner card = headline + our explainer + the link to the original publisher ("Read the full story"). We never copy publisher text.
5. Human review: each new explainer card is reviewed once; classifier output is checked weekly.

**Rules.** Explain and link; no article copy; no images from publishers; injuries handled factually and without speculation; suspensions and controversies described neutrally; no betting or odds; no rumours from unverified accounts.

**Sources.** Headline and link only from league news pages, team sites and national outlets, via a licensed adapter if required. If no licensed news feed exists, the fallback is our own editorial: a weekly hand-written "What's happening in hockey" card (link to the league's own news page).

**Prompts the learner can tap** ("Explain this"): *Why are fans talking about this today? Why does this trade matter? Why was that goal waved off? What does cap space change? What is she worried about before Game 7?*

## 8. Personalized context (spec section 12)

- Feed priority when a `team` is set: her team's games and standings, then division rivals, then league headlines.
- When a `player` is set: his recent games and injury status; if none, the team's top storyline.
- `league` selects NHL, PWHL or international feeds and labels (points model, rule differences).
- If the person supports several interests, hockey cards share a single hockey card per day; no name in notifications.
- The foundation curriculum is identical for everyone; only examples and the feed personalize.

## 9. 2026-27 calendar anchors (verify before shipping)

Verified in web searches on 2026-09-30:
- NHL: 32 teams; **84-game regular season** (up from 82; two extra divisional games); regular season opens **September 29, 2026**; **preseason capped at four games**; salary cap ceiling **$104 million** (floor about $76.9 million). New rules: mandatory cut-resistant neck protection for players with no prior NHL games, a dedicated traveling emergency backup goaltender, contract-length limits under the new CBA.
- 2026 results (for context cards): Carolina Hurricanes won the Stanley Cup (6 games over Vegas); Montreal Victoire won the Walter Cup (3-1 over Ottawa); the United States won both Olympic gold medal games in overtime over Canada (2-1).
- PWHL: **12 teams** (new Detroit, Hamilton, Las Vegas, San Jose); opening weekend **December 5-6**; training camps open **November 18** after the Women's World Championship.
- NHL events reported: Heritage Classic (Winnipeg vs Montreal, October 25), Winter Classic (Utah vs Colorado, December 31), All-Star Game (February 7), Stadium Series (Dallas vs Vegas, February 20). Treat as unverified until a second source confirms.

Typical seasonal windows (to be confirmed each year): trade deadline in early March; playoffs begin mid-April; Cup Final in June; draft lottery in spring; draft in late June; free agency opens July 1 (the "hockey Christmas" lesson); Worlds in May; World Juniors at the turn of the year.

## 10. Testing and monitoring

- Fixtures: one completed game, one live game, one overtime/shootout game, one playoff series, one PWHL game, one injured player; adapters must round-trip these.
- Contract tests: normalized types decode in SwoondCore (Linux); no provider types cross the module boundary.
- Freshness dashboards: last successful fetch per kind and adapter; alerts when scores are stale during a game window.
- Editorial checks: no sentence in an explainer card may match publisher text (manual spot check on review).

## 11. Open questions

| # | Question | Owner | Blocking |
|---|---|---|---|
| 1 | TheSportsDB (or an alternative) coverage and terms for NHL, PWHL and international tournaments | Claude / Product | Live layer |
| 2 | PWHL data source and licensing | Product | PWHL live cards |
| 3 | News provider and license cost (DECISIONS Q-3) | Product | Editorial live cards |
| 4 | Advanced stats (Corsi, xG) source or in-house computation from play-by-play | Product | No |
| 5 | Backend polling and caching once a backend is chosen (DECISIONS Q-2) | Claude / Product | Live layer at scale |
| 6 | Confirm 2026-27 event dates (Classics, All-Star, deadline) with the league calendar | Claude (content) | No |
