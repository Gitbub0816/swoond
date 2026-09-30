# Live Data & Editorial Plan: Soccer (`soccer`)

Implements product spec sections 10-12 (structured data, editorial context, personalized context) and 32-37 (external data architecture, sports data strategy, TheSportsDB, enterprise providers, news/editorial). Author date: 2026-09-30. Facts marked *(verify)* must be re-checked before use; live values are never hard-coded into static lessons.

## 1. Principles

1. **Swoon'd is not a live-score app** (spec section 33). A learner needs: the recent result, the current score, the next fixture, the table, basic player/team info and enough context to talk about it. A few minutes' delay during matches is fine.
2. **Structured data and editorial are separate systems** (spec section 11). Structured data says "Arsenal 2, Chelsea 1, FINAL"; editorial says why fans care.
3. **Provider -> adapter -> Swoon'd normalized data -> course interpretation -> UX** (spec section 32). No provider schema reaches the domain model or the curriculum JSON. Adapters live behind `LiveDataRepository`.
4. **No invented live needs** (spec section 10). Every data kind below exists because a live fan conversation needs it.
5. **Explain in our own words and link** (spec sections 11 and 37); never copy publisher text.

## 2. Data needs by kind (matches `manifest.json` `dynamicData`)

| Kind | Used for | Provider candidates | Refresh | Fallback when the provider is down |
|---|---|---|---|---|
| Scores | "Who won?" cards, the live unit, notifications (discreet mode: no person name) | TheSportsDB (initial), football-data.org, API-Football; Sportradar / SportsDataIO as upgrade paths | Minutes during matches; hourly otherwise | Last cached result with an "as of" time; the card shows "Last updated 14:05" |
| Schedules | Next-fixture card, "when do we play?" | Same | Daily; hourly on match days | Cached fixtures; if stale > 48 h, hide kickoff times and show the date |
| Standings | Title race, Europe race, relegation, `live-01` and `live-05` templates | Same | Daily and after each matchday | Cached table with a stale badge; never compute points from partial data |
| Statistics | Headline numbers (goals, assists, clean sheets), optional xG | TheSportsDB (basic); an xG provider only after a licence review | Daily | Authored evergreen stats and the plain-English xG lesson |
| Rosters | Who plays for whom; player personalization | TheSportsDB | Weekly and around transfer windows | Cached roster; player tokens fall back to "her favourite player" |
| Rankings | FIFA rankings for internationals | FIFA site as a link-only source; provider TBD | Monthly | Link-only |
| Events | Tournament brackets, cup draws, playoffs | TheSportsDB, football-data.org | Daily; minutes on match days | Static bracket explanation |
| News | Topic detection for editorial explainers | Licensed news API (TBD, DECISIONS Q-3) | Hourly | Evergreen explainers; no headline feed |
| Alerts (injuries/suspensions) | "Why does this injury matter?" | Provider news tags; editorial | Hourly on match days | Omit |

There is no weather, closures or conditions data for this course.

## 3. Adapters and normalized types

Normalized (Swoon'd-owned) types; each adapter maps a provider payload into these and nothing else escapes:

| Type | Key fields |
|---|---|
| `Competition` | id, name, kind (league / cup / tournament), branchId, country/confederation |
| `Season` | id, competitionId, startDate, endDate, phase (regular / knockout / playoffs) |
| `Team` | id, name, shortName, colours (text tokens only), competitionIds |
| `Match` | id, competitionId, matchday/round, kickoff, home/away teamIds, status (scheduled / live / final / postponed), score, extraTime/penalties flags |
| `StandingRow` | competitionId, teamId, played, won, drawn, lost, goalsFor, goalsAgainst, goalDifference, points, position, zone (title / europe / relegation / none) |
| `Player` | id, name, teamId, position group, number |
| `AvailabilityNote` | playerId, kind (injury / suspension / doubt), summary in our words, expectedReturn |
| `NewsTopic` | id, teamIds, playerIds, competitionId, topicKind (result / injury / transfer / referee / tactics / rules / manager), headline reference (link only), detectedAt |
| `EditorialCard` | topicId, ourExplanation, concepts[], sourceLinks[], reviewedBy, publishedAt, expiresAt |

Adapter keys: `soccer.season` (standings, scores, schedules for the live unit), `soccer.tournament` (brackets), `soccer.editorial` (topics and cards). Stale/fallback rules live in the repository, not the UI.

## 4. Provider strategy (spec sections 33-35)

- **Start with TheSportsDB** for mainstream coverage (teams, schedules, scores, standings, basic players) behind an adapter. Confirm free-tier limits, attribution and commercial terms before launch. If coverage or refresh is insufficient for a league, add football-data.org or API-Football as a second adapter for that league only.
- **Upgrade path:** Sportradar or SportsDataIO if latency, coverage of the NWSL/MLS or licensing require it. The adapter boundary makes the swap invisible to courses.
- **Do not scrape** official league or federation sites; **no unofficial APIs** (CLAUDE.md rule). Use them as link-only sources.
- **Provider health:** each adapter reports `lastSuccessAt`; the UI shows freshness when stale.

## 5. Refresh and caching plan

| Data | Foreground refresh | Background refresh | Cache lifetime |
|---|---|---|---|
| Live scores | 60 s while the match card is visible | none | 5 min |
| Today's fixtures | on open | hourly on match days | 6 h |
| Standings | on open | after each matchday (daily) | 24 h |
| Rosters | on open | weekly; daily in windows | 7 d |
| News topics | on open | hourly | 2 h |
| Editorial cards | on open | on publish | until `expiresAt` |

Notifications never contain the Person's name (discreet mode); a notification about a goal names only the team when the learner has enabled team notifications.

## 6. The current-season / live layer (`the-live-season`)

Lessons are templates with `live` hooks (adapterKey `soccer.season`); content is generated from normalized data, not authored statically.

| Lesson | Live inputs | Generated content | Teaches |
|---|---|---|---|
| `live-01` This week's table | `StandingRow[]` for the person's league and team | "Your team is 4th on 12 points, two points behind third; here's what 'level on points' would mean" plus `mc`/`fg` built from the actual table | `league-table`, `form-and-ppg`, `goal-difference` |
| `live-02` The fixture that matters | Next `Match`, two teams' `StandingRow`s | Why this match matters (title, Europe, survival, derby) and one say-this line | `title-race`, `relegation-scrap`, `derby` |
| `live-03` Injury and lineup news | `AvailabilityNote`, latest lineup if available | A decision-scenario with the actual absence ("If your centre-back is out, what changes?") | `injury-report`, `fixture-congestion` |
| `live-04` Transfer news decoder | `NewsTopic` (transfer) | Rumour-vs-confirmed exercise using the current story | `here-we-go`, `transfer-window` |
| `live-05` Title race and relegation maths | Standings plus remaining fixtures | Estimate-slider: "how many points to be safe?" from the real table | `run-in`, `title-race` |
| `live-06` What is everyone talking about | Top `EditorialCard`s | Say-this and talk-track built from today's storyline | `sack-race`, `international-break`, `var-basics` |

**Freshness rules:** templates disable themselves (and show an evergreen replacement) when data is older than the cache lifetime. Scores older than 7 days are shown as "results", not "live".

## 7. Editorial plan (spec sections 11 and 37)

**Goal:** turn a current event into understanding, in our own words, with a link out.

1. **Topic detection.** From `NewsTopic`s and structured data (a red card, a late equaliser, a manager sacked, a rule change, a transfer confirmed), rank by relevance to the learner's `team`, `player` and `league`.
2. **Explainer template** (all cards): "What happened" (1 sentence in our words) -> "Why fans care" (1-2 sentences) -> "The term to know" (linked Playbook concept) -> "A question you could ask" (1 line) -> "Read more" (link to the original publisher).
3. **Editorial review.** A human reviews every card for accuracy and neutrality before publish; no player-blaming, no rumour presented as fact; medical topics are avoided (no guidance about injuries).
4. **Cadence.** Weekly cards for the top storylines per branch, daily on match days for major competitions, and an evergreen bench for slow news.
5. **Copyright.** Publisher headlines and links only. No article text, quotes, photos or match reports.
6. **Discreet mode.** Card copy and notifications never include the Person's name or relationship.

### Sample cards (our own words; illustrate the format, not live news)

- **Why the eight-second rule matters.** *What happened:* a keeper held the ball too long and the referee gave a corner. *Why fans care:* a corner is far more dangerous than a free kick, so the rule stops keepers from wasting time. *Term:* `goalkeeper-eight-seconds`. *Ask:* "Did the ref count with his hand?" Read more: IFAB.
- **Why a late red card changes a season.** *What happened:* a team lost a player with 20 minutes left. *Why fans care:* down to ten, a team defends deeper, gets fewer chances and misses a key player through suspension next week. *Term:* `red-card`, `low-block`. *Ask:* "Do they have a good replacement?"
- **Why the international break worries fans.** *What happened:* the league paused for national teams. *Why fans care:* players travel, get hurt and return tired. *Term:* `international-break`, `fixture-congestion`.
- **Why fans argue about VAR offside.** *What happened:* a goal was ruled out by a tiny margin. *Why fans care:* the line is precise but the rule feels arbitrary at a toenail. *Term:* `saot`, `offside-debates`.

## 8. Personalization of the feed (spec section 12)

- `team`: prioritise the team's results, table position, injuries and next fixture; rivals appear as context. Unset -> a neutral league-wide feed.
- `player`: player-specific explainers when news mentions the player; unset -> skip.
- `league`: chooses branch and provider coverage; the live layer requires an explicit choice (no silent default), because a `premier-league` fan and an `nwsl` fan need different tables.
- The foundation stays valid regardless of personalization; only examples and live context change.

## 9. Season and event calendar (as of 2026-09-30; verify before scheduling content)

| Item | Status |
|---|---|
| 2026 FIFA World Cup (USA/Canada/Mexico) | Completed. Spain 1-0 Argentina after extra time (Ferran Torres, 106th minute) *(verified)*; Golden Boot Kylian Mbappe (10 goals), Golden Ball Rodri, Golden Glove Unai Simon, Young Player Pau Cubarsi *(verified via reported award lists; re-verify names before publishing)* |
| 2025-26 Premier League | Arsenal champions with 85 points; Manchester City 78, Manchester United 71 *(verified)* |
| 2026 UEFA Champions League final (Budapest, 30 May) | PSG beat Arsenal 4-3 on penalties after 1-1 *(verified)* |
| 2026-27 UEFA Champions League | League phase runs 8 September 2026 to 27 January 2027; 36 teams, eight matches each; top eight go direct to the round of 16, 9-24 to a knockout playoff *(verified)* |
| MLS 2026 | World Cup break May 25 to July 16; regular season ends November 7; playoffs and MLS Cup follow *(verified)*; 2025 MLS Cup: Inter Miami beat Vancouver Whitecaps 3-1 *(verified)* |
| MLS calendar shift | Short transition season February to May 2027 (14 regular-season games), then August-to-May from 2027-28 with a winter break *(verified)* |
| NWSL | 2025 champions Gotham FC (1-0 over Washington Spirit; lowest seed to win) *(verified)* |
| IFAB Laws 2026/27 | Effective 1 July 2026: five-second restart countdown (throw-ins, goal kicks), ten-second substitution exit, one-minute off-field after injury treatment, VAR corrects clearly wrong second yellows, mistaken identity and wrongly awarded corners (immediate review only), body cameras optional; no offside change approved *(verified)* |
| 2025/26 IFAB | Goalkeeper eight-second rule (corner if exceeded) *(verified)* |
| Upcoming | 2027 Women's World Cup; 2030 World Cup; UEFA Euro and Copa America cycles *(verify dates before scheduling)* |

## 10. Rules-refresh plan

- Each July (IFAB Annual Business Meeting outcomes take effect 1 July) review `laws-and-officials`, `offside-and-var` and every concept tagged `intermediate` that names a rule; update lessons and reset affected concepts to review box 1.
- Each August: season reset (promotion/relegation, fixtures, MLS calendar from 2027).
- Tournament years: switch on the tournament layer (bracket, group scenarios, national-team branch units).
- Rule proposals under consultation (e.g. player exit protests, mouth-covering) become lessons only once approved.

## 11. Risks and mitigations

| Risk | Mitigation |
|---|---|
| Provider outage or rate limits | Repository caches; stale badges; fallback to evergreen |
| Coverage gaps (NWSL, lower leagues) | Second adapter per league; hide unsupported leagues |
| Licensing of stats/xG | Author evergreen numbers; adopt a licensed source only after review |
| Rumour presented as fact | Editorial rules: label rumour vs confirmed; `here-we-go` is only used when a trusted source confirms |
| Match-day scale spikes | Client-side caching and staggered refresh |
| Personal-data leakage | Discreet mode; no names in notifications or telemetry |

## 12. Open items

1. News provider selection and licence (DECISIONS Q-3).
2. xG provider or authored-only decision.
3. TheSportsDB commercial terms for NWSL/MLS coverage and refresh.
4. Whether to add a tournament-only data source for the 2027 Women's World Cup.
