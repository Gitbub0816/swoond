# Live Data and Editorial Plan: Basketball (`basketball`)

Implements product spec sections 10-12 (structured data, editorial, personalized context) and 32-37 (external data architecture, sports data, TheSportsDB, enterprise providers, news). It answers CDS section 6 (dynamic information) and section 7 (editorial context) for this course. Provider names are candidates only; all of them sit behind Swoon'd adapters (D-004, spec section 32). Facts stated as of 2026-09-30.

Contents: 1 principles, 2 data domains, 3 normalized Swoon'd data model, 4 providers and adapters, 5 unit live hooks, 6 editorial plan, 7 season calendar and content drops, 8 personalization and notifications, 9 rules-facts registry, 10 quality, monitoring and fallback, 11 licensing and privacy, 12 open questions.

## 1. Principles

1. **Basketball benefits from live data** (spec section 10 test): "Did they win?", "Are they in the Play-In?", "Is he playing tonight?" are the first questions a fan asks, and a learner who can answer them can join the conversation. So basketball gets a live layer. It does not need betting-grade or play-by-play data (spec section 33): being a few minutes behind is fine.
2. **Static lessons never hard-code live facts.** Champions, cap numbers, season length, rosters and standings live in data or are flagged `validThrough` (section 9). Lessons refer to them through `live` hooks.
3. **Structured and editorial are separate systems** (spec section 11). Structured data says `Knicks 4-1`; editorial explains why it mattered. Each has its own adapters, refresh and fallbacks.
4. **We are not ESPN.** No live box-score streaming, no play-by-play, no push of every basket. A "last updated" stamp is shown on everything.
5. **Never copy publishers.** We explain in our own words and link to the original (spec sections 11, 37).
6. **Provider schemas never leak** (spec section 32; CLAUDE.md section 3): the app only sees the types in section 3.

## 2. Data domains

| Domain (manifest `kind`) | What we use it for | Fields we normalize | Provider candidates | Refresh (manifest enum) | Staleness rule and fallback |
|---|---|---|---|---|---|
| Scores (`scores`) | Result of last game, live score card, "did they win?" | gameId, league, status, startTime, home/away teams, score, period, clock (coarse) | TheSportsDB (MVP); Sportradar or SportsDataIO (upgrade) | `minutes-during-events` (poll every 2-5 min while a followed team is playing; hourly otherwise) | Show last known score with "as of hh:mm"; if > 15 min stale during a game, show "Score delayed" and hide clock |
| Schedules (`schedules`) | What to watch this week; next game for `{{team}}`; countdowns | gameId, tipoff, venue (city only), broadcast (network name), competition (regular, Cup, Play-In, playoff, NCAA round) | Same | `daily` (refresh at 04:00 local; hourly on game days) | Cached schedule for up to 7 days |
| Standings (`standings`) | Seeds, Play-In race, conference tables; college conference and bubble context | teamId, conference, wins, losses, seed, gamesBack, streak, tiebreak note | Same | `daily` (hourly on the last two weeks of the regular season) | Cached table with stamp; hide "race" lessons if > 48 h stale |
| Statistics (`statistics`) | Light stat cards: team record, last box score, season leaders | teamId, playerId (display name), PTS/REB/AST for last game and season | Same | `daily` | Hide cards when stale; no unofficial stats endpoints |
| Rosters and transactions (`rosters`) | Who is on the team; trades, signings, waivers; injury status | playerId, displayName, position tag (text), status, transaction type, date, teams involved | Sportradar / SportsDataIO for injuries and transactions; TheSportsDB for basic rosters; league official injury reports as link-outs only | `hourly` | Injuries older than 24 h are hidden, not guessed |
| Rankings (`rankings`) | College: AP poll and NET context | teamId, rank, previous rank, record, poll date | Licensed rankings via Sportradar/SportsDataIO; link out to the official poll and NET pages | `weekly` | Hide when stale |
| Events (`events`) | NBA Cup groups and bracket, Play-In, playoffs, NCAA tournament bracket, WNBA playoffs | eventId, round, seriesScore, bracket links, seed numbers | Same as schedules/scores | `daily` normally; minutes on event days via the scores feed | Cached bracket; bracket view shows "as of" |
| News (`news`) | Feed of headlines for the editorial layer (topic detection only) | headlineId, publisher, url, publishedAt, topic tags | Licensed headline API (open question Q-3); publisher RSS with link-out | `hourly` | If down, editorial cards come from our own weekly write-ups |
| Weather, closures, conditions, releases, new products | Not needed | - | - | - | - |

Deliberately not collected: betting odds, spreads, props, fantasy projections, player biometrics, social media posts.

## 3. Normalized Swoon'd data model (owned by Swoon'd; no provider fields)

These are domain types (SwoondCore `LiveDataRepository`); shapes are illustrative and platform-neutral.

```json
{
  "Team": { "id": "nba-nyk", "league": "nba", "displayName": "New York Knicks", "shortName": "Knicks", "city": "New York", "conference": "east", "colors": { "primary": "#..." , "note": "text tokens only; no logos" } },
  "Game": { "id": "nba-2026-10-20-nyk-phi", "league": "nba", "competition": "regular", "status": "scheduled", "startTime": "2026-10-20T23:30:00Z", "home": "nba-nyk", "away": "nba-phi", "score": null, "period": null, "broadcast": ["NBC", "Peacock"], "asOf": "2026-09-30T12:00:00Z" },
  "StandingsRow": { "teamId": "nba-nyk", "conference": "east", "wins": 0, "losses": 0, "seed": null, "playInEligible": false, "streak": null, "asOf": "2026-09-30T12:00:00Z" },
  "InjuryStatus": { "playerId": "p-000123", "displayName": "Player Name", "teamId": "nba-nyk", "status": "questionable", "reasonCategory": "lower-body", "asOf": "2026-09-30T12:00:00Z", "sourceKind": "provider", "linkOut": "https://..." },
  "Transaction": { "id": "tx-...", "type": "trade", "date": "2026-02-05", "teams": ["nba-nyk", "nba-phi"], "summary": "Swoon'd-written one-liner", "capImpactTag": "second-apron", "linkOut": "https://..." },
  "SeriesState": { "id": "nba-2027-r1-e1", "round": "first-round", "highSeed": "nba-nyk", "lowSeed": "nba-phi", "highWins": 2, "lowWins": 1, "nextGame": "nba-2027-04-25-nyk-phi", "asOf": "..." },
  "BracketNode": { "id": "ncaa-2027-s16-1", "league": "college", "round": "sweet-sixteen", "topSeed": { "team": "...", "seed": 1 }, "bottomSeed": { "team": "...", "seed": 4 }, "winner": null },
  "RuleFact": { "id": "nba-cap-2026-27", "league": "nba", "key": "salary-cap", "value": "as published by the league", "validFrom": "2026-07-01", "validThrough": "2027-06-30", "sourceLink": "https://..." },
  "EditorialCard": { "id": "ed-2026-10-20-01", "topic": "opening-night", "headline": "Swoon'd-written", "body": "About 90 words in our own words", "concepts": ["seeding", "play-in"], "linkOut": { "publisher": "...", "url": "https://..." }, "publishedAt": "..." }
}
```

`injury status` values follow common report vocabulary (out, doubtful, questionable, probable, available); the unit `liv-04` explains them. `reasonCategory` is coarse ("lower-body", "illness", "rest") to avoid medical detail and speculation.

## 4. Providers and adapter architecture

Pipeline (spec section 32): External provider -> Provider adapter -> Swoon'd normalized data -> Course interpretation -> User experience.

- **Adapter contract (proposed for `SwoondCore`):** `LiveDataRepository` with `games(for:)`, `standings(league:)`, `roster(team:)`, `injuries(team:)`, `transactions(league:since:)`, `series(id:)`, `bracket(league:season:)`, `ruleFacts(league:)`. Provider DTOs are `internal` to each adapter and never exported. Every response carries `asOf`.
- **MVP provider: TheSportsDB** (spec section 34). To be investigated in the first live-layer sprint: coverage of NBA (expected good), WNBA (verify: schedules, scores, standings, rosters), NCAA men's and women's basketball (verify: conference standings, tournament events), request limits, commercial licensing tier, attribution requirements. We only ship features that the tested coverage supports; otherwise the feature hides (never guessed).
- **Upgrade path: Sportradar or SportsDataIO** (spec section 35) for injuries, transactions, NCAA data and rankings when TheSportsDB coverage or terms are insufficient. Migration is per-domain: adapters swap without changing curriculum, lessons or `live` hooks.
- **Not used:** any unofficial or reverse-engineered NBA/WNBA/NCAA endpoint (e.g., scraping stats.nba.com); no ESPN private APIs; no scraping of publishers; no AllTrails-style unofficial dependency (spec section 39 pattern).
- **Motorsport-style specialist provider (spec section 36):** not applicable to basketball.
- **Caching:** on-device cache and a Swoon'd backend cache (D-004: bundled JSON + local persistence first; Neon or Firebase later) respect provider cache terms and TTLs; the backend fetches once for all users; devices never call providers directly.
- **Multiple providers can coexist** per domain (for example TheSportsDB for schedules and Sportradar for injuries); the repository picks by domain and health.
- **Outage handling:** each domain has an independent circuit breaker; on failure the app shows the cached value with an "as of" stamp; if stale beyond the section 2 limits the specific card is hidden and lessons fall back to evergreen examples.

## 5. Unit live hooks

Per the curriculum schema each `live` unit hook declares which live domain it needs, a refresh cadence and a fallback. Static units call hooks only for examples and "right now" callouts.

| Unit / lessons | Hook id | Domain(s) | Where it appears | Fallback |
|---|---|---|---|---|
| `league-machine` `lea-02` Standings, seeds | `live.standings.conference` | standings | "Where your team sits" card after the lesson | Skip card |
| `league-machine` `lea-03` Play-In | `live.standings.playin` | standings, schedules | "This season's Play-In picture" (only in the regular-season stretch run and April) | Static bracket diagram |
| `league-machine` `lea-04` Playoffs | `live.series.current` | events | Current series scores when playoffs are on | Static example bracket |
| `league-machine` `lea-05` NBA Cup | `live.cup.groups` | events, standings | Cup group table and knockout bracket in November-December | Static format explainer |
| `league-machine` `lea-08-09` Trades/calendar | `live.transactions.league` | rosters | "This week's deals" list | Static examples |
| `branch-college` `col-02` Bracket | `live.bracket.ncaa` | events | The bracket, upsets flagged, in March-April | Last year's bracket as an example, clearly labelled |
| `branch-college` `col-03` NET and bubble | `live.rankings.college` | rankings | AP and NET context in Jan-March | Hidden |
| `branch-wnba` `wnb-01` and `wnb-06` | `live.standings.wnba`, `live.schedule.team` | standings, schedules | Standings, Commissioner's Cup, playoff race | Static structure |
| `season-live` `liv-01` This week in {{league}} | `live.editorial.week` | news, standings, scores | Three explained storylines | Last week's pack, marked stale |
| `season-live` `liv-02` {{team}} game preview | `live.schedule.team` + `live.injuries.team` | schedules, rosters | Next game and who might play | Team's last result |
| `season-live` `liv-03` Why is everyone talking about this? | `live.editorial.today` | news | One explainer card | Evergreen explainer |
| `season-live` `liv-04` Injury report decoder | `live.injuries.team` | rosters | Live status list plus definitions | Static examples of the five statuses |
| `season-live` `liv-05` Standings and seeding race | `live.standings.race` | standings | Seeds, games behind, Play-In line | Static |
| `season-live` `liv-06` Trades and free agency | `live.transactions.week` | rosters | Explain one deal in cap terms | Static |
| `season-live` `liv-07` Playoff series tracker | `live.series.current` | events, scores | Live series state and what to watch | Static |
| `season-live` `liv-08` Awards and All-Star | `live.awards.race` | statistics, news | Awards race explainers, Cup context | Static |
| `eras-culture` `era-08` Current era | `live.rulefacts.current` | rule facts | Champion, MVP and cap facts with `validThrough` | Marked "as of" text |
| `conversation-lab` `con-01..08` | `live.scores.last` | scores | "Your team lost last night" openers use the real last result | Generic openers |

## 6. Editorial plan (spec sections 11 and 37)

**Goal:** turn a current event into learning: "Knicks 4-1 over the Spurs" (structured) becomes "why the second apron makes their offseason interesting" (editorial), with a link to the publisher for the full story.

### 6.1 Pipeline

1. **Signal:** the headline feed and structured events surface topic candidates (trade, injury, series result, rule change, upset, CBA news). A topic is eligible only if it maps to at least one concept in the curriculum.
2. **Draft:** a Swoon'd editor (human owner with Claude drafting) writes an `EditorialCard`: headline (our own), body of about 90 words explaining what happened and why fans care, the concepts to review ("second-apron", "play-in"), and a one-line "say this" prompt. Never paste or closely paraphrase publisher sentences.
3. **Fact check:** every rule or number is checked against the official source (rulebook, CBA summary, league release) and the provider data; facts get a `sourceLink`.
4. **Voice check:** cheeky coach, warm, short sentences, never mean, never about the crush; no gossip.
5. **Sensitivity check:** skip or neutralize injuries with detail, legal or personal matters, player-conduct controversies and anything that would gamify a person's misfortune (CDS section 5). Injury cards say what the status means for the team, not the medical story.
6. **Publish** with the link-out to the original publisher and attribution as the licence requires. Cards expire (default 7 days; playoff cards 48 hours).
7. **Correct:** a correction is published within one refresh cycle and old copies are replaced; no silent edits to a card's facts.

### 6.2 Topic catalog (what we explain)

| Topic class | Example prompts (the learner's question) | Concepts we teach through it |
|---|---|---|
| Trades and cap moves | "Why is this trade a big deal?" "Why can't they just sign him?" | trade, trade exception, salary cap, second apron, Bird rights |
| Injuries and load | "Why does this injury matter for the seeding race?" "What does 'questionable' mean?" | injury report, rotation, load management |
| Coaching and strategy | "Why did the coach call that timeout?" "Why are they going small?" | timeout, small ball, drop vs switch |
| Rules and officiating | "What is controversial about this rule change?" "Why was that a block?" | replay review, coach's challenge, charge |
| Standings and seeding | "What is the Play-In race?" "Who is the 7 seed and why does it matter?" | seeding, play-in |
| Playoffs and Cup | "What does a 3-1 lead mean?" "What is the NBA Cup and does it count?" | best-of-seven, nba-cup |
| Awards | "Why is the MVP race close?" | mvp-criteria, narrative-vs-value |
| College | "What did NIL change?" "Why is this team on the bubble?" | nil, transfer portal, bubble team, NET |
| WNBA | "What did the new CBA change?" "What is an expansion team?" | wnba-cba, expansion-draft |
| League business | "What is NBA Europe?" "What is the new media deal?" | league structure, media partners (explained neutrally) |

### 6.3 Format, cadence and ownership

- **Weekly pack (`liv-01`):** three storylines per branch, published Monday during the season; a per-team variant for `{{team}}`.
- **Daily explainer (`liv-03`):** one card per active branch on event days (trade deadline, Play-In, playoffs, Selection Sunday, Cup knockouts).
- **Event playbooks:** pre-written templates for recurring events (opening night, Cup final, trade deadline, Play-In, playoffs by round, the draft, free agency, Selection Sunday, Final Four, WNBA draft and expansion) so a card can ship within an hour of the event.
- **Volume target:** about 5 cards per week per branch in season; 1 per week in the offseason.
- **Ownership:** editorial owner (product), Claude for drafts, a second human review for facts and sensitivity; a monthly editorial retro.

### 6.4 What we do not do

No article text, no summaries that substitute for the article, no images from publishers, no screenshots of tweets or posts, no rumor cards ("sources say" stories are only explained after official confirmation), no betting angles.

## 7. Season calendar and content drops

Dates below are known as of 2026-09-30 or are stated as generic windows; exact dates always come from the schedule feed, not from this file.

| Window | What happens | Live/editorial drop |
|---|---|---|
| Early Oct 2026 | EuroLeague vote on NBA Europe (5 Oct); WNBA playoffs (Finals from 17 Oct) | WNBA Finals explainer; NBA Europe explainer (neutral, unconfirmed status) |
| 20 Oct 2026 | 2026-27 NBA opening night (NBC/Peacock triple header) | Opening-night pack; broadcast guide (via schedule feed) |
| Oct-Dec | Regular season; NBA Cup group play; college tip-offs in November | Weekly packs; Cup groups (`live.cup.groups`); college rankings begin |
| 11 Dec 2026 | NBA Cup final at Hinkle Fieldhouse (Indianapolis) | Cup final explainer |
| Jan-Feb | All-Star selection window; trade deadline (date per league calendar) | Trade-deadline explainers (`liv-06`); awards races start (`liv-08`) |
| Mid-Mar 2027 | Selection Sunday and the NCAA tournament (men's and women's) | Bracket (`live.bracket.ncaa`), upset explainers, "your bracket is busted" talk tracks |
| Apr | NBA regular season ends; Play-In; playoffs begin; Final Four | Play-In and seeding explainers, series tracker |
| Apr-Jun | Playoffs, Finals, awards, draft lottery, draft (June) | Series explainers; awards; draft primer (`lea-06` live callout) |
| Late Jun-Jul | Free agency, summer league, cap resets for the new season | Cap and free-agency explainers (`liv-06`); annual rules-facts refresh (section 9) |
| May-Oct 2027 | WNBA season (44 games in 2026; the CBA lengthens it in later years) | WNBA weekly pack; Commissioner's Cup; playoffs |
| Ongoing | College portal windows, NIL and revenue-sharing news | College explainers (`col-04`) |

## 8. Personalization and notifications

- **Feed weighting:** `team` (highest), `player`, `league` branch, then general. If `team` is unset the feed uses the "team of the week" (rotating by storyline interest); it never assumes the crush's team.
- **Tokens:** lesson copy uses `{{team}}`, `{{player}}`, `{{league}}`, `{{conference}}`, `{{rival}}` resolved on device from the Person profile.
- **Discreet mode is default:** no notification ever contains the Person's name or relationship. Notification copy examples: "Your team plays tonight. Want a 60-second briefing?" and "Big trade news. See why it matters." (no team name if the user turned off team names in notifications).
- **Frequency caps:** at most 1 push per day per followed team; game reminders opt-in; quiet hours default 22:00-08:00 local; no streak-loss shaming copy.
- **Feed rules:** never present a follower's fandom as a test; no "you're behind" framing.

## 9. Rules-facts registry and annual refresh

Facts that change and must never live only in static lesson text. Each becomes a `RuleFact` with `validFrom` / `validThrough`. Each October (and after the CBA/summer changes) a checklist runs; changed facts re-queue the affected concepts in review (CDS section 11 review policy).

| Fact | Owner | Refresh |
|---|---|---|
| NBA salary cap, luxury tax line, first apron, second apron (2025-26: $154.647M, $187.895M, $195.945M, $207.824M) | Editorial | Annually at the start of free agency |
| NBA Cup format and dates | Editorial | Annually in September |
| NBA rule changes and coach's-challenge details | Editorial | Annually before opening night |
| Broadcast partners (ESPN/ABC, NBC/Peacock, Amazon Prime Video for 2026-27) | Editorial | Annually |
| WNBA season length (44 games in 2026, rising under the CBA), cap and roster rules, expansion status | Editorial | Annually, plus on CBA or expansion news |
| NCAA rules (halves vs quarters, shot clock, challenge rules), House-settlement revenue-sharing figure | Editorial | Annually in June |
| Champions and award winners (NBA champion 2026: Knicks; NBA MVP 2025-26: Shai Gilgeous-Alexander; NCAA 2026: Michigan men, UCLA women; WNBA 2025: Las Vegas Aces) | Editorial | After each award or final; used only by `era-08` and live templates |
| NBA Europe status (target October 2027, unconfirmed) | Editorial | On news |

## 10. Quality, monitoring and fallback

- **Every card shows "as of":** scores, standings, injuries, brackets.
- **Provider health dashboard:** per domain: last success, latency, error rate, staleness; alert when an event-day domain is stale > 10 minutes.
- **Kill switches:** per domain, remotely toggled; when off, the specific card hides and evergreen fallback text shows.
- **Reconciliation:** nightly job compares standings to sums of results; mismatches block that day's "race" lessons.
- **Cost control:** cache once server-side; devices fetch from Swoon'd's backend (D-004); poll only when a followed team plays.
- **Test data:** fixture packs (frozen JSON) for the mock backend so the app and lessons can be built and tested offline (D-004).
- **Rollout:** ship NBA scores/schedules/standings first, then injuries and transactions, then college brackets and rankings, then WNBA (after coverage verification).

## 11. Licensing and privacy

- **Data terms:** follow each provider's terms; attribute where required; store only what the terms permit; do not redistribute raw feeds.
- **No logos or player images** in any live card; teams appear as text and neutral color chips only.
- **News:** headline and link only unless the licence allows more; no article text.
- **Privacy:** live layer requests carry no Person data; only anonymous followed team/league ids reach the backend for feed weighting; no analytics events include the Person's name or relationship (CLAUDE.md section 6).
- **Gambling:** no odds, spreads or sportsbook links, even if a provider offers them (filter at the adapter).

## 12. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | TheSportsDB coverage and terms for NBA, WNBA and NCAA basketball (verify before committing features) | Claude | Blocking scope of the live MVP |
| 2 | Licensed headline/news API choice and cost (product Q-3) | Product | Blocking the editorial pipeline's automation, not manual cards |
| 3 | Injury and transaction feed: Sportradar vs SportsDataIO vs link-outs; licence and cost | Product | Blocking `liv-04` live data |
| 4 | College rankings licence (AP poll and NET are sensitive); link-out only until licensed | Product | No |
| 5 | Who edits? Staffing for weekly packs and daily explainers in season | Product | No |
| 6 | Push notification content policy review for discreet mode (team names in notifications: opt-in) | Product | No |
| 7 | Backend choice (Neon vs Firebase, product Q-2) for the cache layer; until then a local mock with fixture packs | Product | No |
