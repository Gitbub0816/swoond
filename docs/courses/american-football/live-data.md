# American Football: Dynamic Data and Editorial Plan

Implements product spec sections 10-12 (structured data, editorial, personalized context) and 32-37 (external data architecture, sports data strategy, TheSportsDB, enterprise providers, news/editorial) for `american-football`. Companion to `CDS.md` sections 6-8 and manifest `dynamicData[]`, `editorial`. Facts verified 2026-09-30.

## 1. Verdict: American Football has meaningful live data

Yes. Football has a weekly rhythm (Thursday, Sunday, Monday; college Saturdays) and the first thing a fan asks is what happened and what it means. Per spec section 33 Swoon'd is not ESPN: it needs the recent result, current score, next game, standings, basic player info, basic stats and current context. Being a few minutes behind is acceptable. No play-by-play, no betting-grade feeds, no sub-second latency.

Season context at time of writing: the 2026 NFL regular season opens on September 9, 2026 (Seattle hosting New England, the Super Bowl LX rematch); the Seahawks are the reigning champions after their 29-13 win on February 8, 2026. The College Football Playoff remains 12 teams for 2026-27 (top four ranked teams receive first-round byes; automatic bids for the ACC, Big 12, Big Ten and SEC champions and the highest-ranked Group of 6 champion), with the national championship on January 25, 2027 in Las Vegas. The tush push remains legal in 2026. Do not hard-code any of this in static lessons; it is reference material for the live layer and the yearly refresher (spec rule: live data lives in `live` unit hooks, never in static lessons).

## 2. Architecture (spec section 32)

```
External provider  ->  Provider adapter  ->  Swoon'd normalized data  ->  Course interpretation  ->  Experience
(TheSportsDB, ...)     (internal DTOs)       (Game, Standing, ...)        (this-week templates)     (cards, prompts)
```

- Adapters implement Core repository protocols (`LiveDataRepository`) and return only Swoon'd types. Provider DTOs are `internal` to the adapter (D-004, CLAUDE.md section 6).
- The course never sees a provider. A provider can be replaced (TheSportsDB to SportsDataIO or Sportradar) without changing units or lessons.
- Structured data and editorial data are separate systems with separate adapters and separate licensing (spec section 11).
- Adapter key for the `this-week` unit: `american-football.weekly`.

## 3. Provider candidates

Candidates only. Licence terms, coverage and pricing must be verified before adoption (open questions below). No unofficial or reverse-engineered production APIs (CLAUDE.md section 3): the ESPN and similar undocumented endpoints are excluded.

| Provider | Role | Coverage note | Licensing / fit notes |
|---|---|---|---|
| TheSportsDB | Initial provider (spec section 34): teams, schedules, scores, standings, basic player and team info | Mainstream sports including NFL; NCAA coverage must be tested | Inexpensive; check commercial-use terms, rate limits, attribution and data freshness during live games |
| API-Sports (American Football) | Alternative for scores and stats | NFL and NCAA advertised | Commercial plan required; check redistribution terms |
| SportsDataIO | Upgrade path (spec section 35): fuller stats, injuries, depth charts | NFL and college | Commercial licence; check display and caching rights |
| Sportradar | Upgrade path (spec section 35): official-grade data | NFL and NCAA | Enterprise; usage limits and price; only if coverage cannot be obtained economically elsewhere |
| CollegeFootballData.com (CFBD) | College stats and rankings | FBS/FCS games, rankings, rosters | Community project with its own terms; verify commercial use and attribution |
| Bundled league calendar | Events (draft, free agency, trade deadline, playoffs, Super Bowl) | Static, updated each year | No provider dependency; link out for details |
| Team and league injury reports (official) | Source of truth for injury designations | Published weekly | Link to the official report; adapter must normalize from a licensed feed rather than scrape pages |
| News: licensed news API (open question Q-3) or publisher RSS headlines | Editorial layer only | Headlines and links | Must have redistribution rights for headlines/summaries; never full text |

## 4. Normalized entities (Swoon'd-owned)

Provider-neutral domain types. Field names are indicative; final shapes live in SwoondCore.

| Entity | Key fields | Notes |
|---|---|---|
| `SportsTeam` | id, name, shortName, city, league (`nfl` or `college`), conference, division, colors (hex), providerRefs | No logo field. Colors are for text accents only. |
| `SportsGame` | id, season, week, kickoffAt, homeTeamId, awayTeamId, status (`scheduled`, `live`, `final`, `postponed`), score, period, clock, venueName, broadcastLabel | Score may lag a few minutes; carry `asOf`. |
| `StandingEntry` | teamId, season, division, wins, losses, ties, pct, divisionRecord, conferenceRecord, streak, seed (`1-7` or null) | Tiebreakers are computed by Swoon'd from records (rules are ours to explain). |
| `PlayerLite` | id, name, teamId, position, jerseyNumber, status | No likeness or image references. |
| `PlayerStatLine` | playerId, season, gamesPlayed, key stats by position | Aggregates only. |
| `InjuryEntry` | playerId, teamId, week, designation (`out`, `doubtful`, `questionable`, `full`), bodyPartLabel, practiceStatus, asOf | Copy is written by us (e.g. "Questionable: hamstring"). |
| `Ranking` | poll (`ap`, `coaches`, `cfp`, `power`), week, entries[teamId, rank, previous] | Power rankings are editorial and labeled as such. |
| `CalendarEvent` | id, kind (`draft`, `free-agency`, `trade-deadline`, `kickoff`, `playoffs`, `super-bowl`), startsAt, label | From the bundled calendar. |
| `Storyline` | id, topicKey, headline (ours), whyItMatters (ours), linkedConceptIds, sourceLinks[{publisher, title, url}], createdAt, expiresAt | Editorial record; see section 7. |
| `PersonalizedFeedItem` | personId, teamId, kind, refId, priority, reason | Derived per person; reason text explains why it appears. |

## 5. Refresh cadence (manifest `refreshFrequency`)

| Kind | Cadence | Notes |
|---|---|---|
| scores | minutes-during-events (2-5 minutes; slower when nothing is live) | Poll only during scheduled windows for the followed team; push notifications (discreet) deliver finals. |
| schedules | weekly; refetch on change | Flex scheduling and Thursday/Saturday changes tracked. |
| standings | daily; hourly on Sundays and Monday | Recompute seed and tiebreaker labels locally. |
| statistics | daily | Basic stats only. |
| rankings | weekly (AP and Coaches Sunday/Monday; CFP Tuesday in the late season) | Power rankings weekly (editorial). |
| rosters | weekly; on transactions | Depth chart context. |
| events | seasonal | Bundled and updated each season. |
| alerts (injury report) | daily Wednesday to Friday; game-day inactives roughly 90 minutes before kickoff | Only for followed team and their next opponent. |
| news | hourly (only followed topics) | Headlines and links only. |

Offseason: polling drops to daily (draft, free agency, trade rumors, rule votes).

## 6. Fallback when a provider is down

- Show the last cached value with an "updated X ago" label; never present stale scores as live.
- Fall back from a live badge to "final/upcoming" copy; hide cards that cannot be trusted (injuries, rankings).
- If a provider goes away, the adapter swap is a Core change only. Unit content does not change.
- News down: show the evergreen "how to follow a storyline" explainer instead of a storyline.
- Never block lessons: `this-week` templates degrade to a static evergreen version.

## 7. Editorial plan (spec sections 11 and 37)

- **Workflow:** (1) the news adapter surfaces headlines and topic tags; (2) an editor (human plus model draft) selects storylines for the followed teams and league; (3) Swoon'd writes a `Storyline` with `headline`, `whyItMatters`, linked concept ids and links to the original publisher; (4) the app renders it in `this-week` and the Home feed; (5) it expires after a week or when superseded.
- **What we explain:** why an injury matters (which position group, which scheme), why a coaching decision is controversial (fourth-down math, clock), what a trade or signing changes (cap, depth), what a rule change does, why a ranking or playoff scenario is tricky, why a rivalry game matters.
- **What we do not do:** copy publisher text; summarize a specific article's reporting beyond a headline; invent rumors; provide wagering angles; use player likeness.
- **Linking:** every storyline has 1-3 publisher links; if none is available, the storyline is marked evergreen and carries no claim about current events.
- **Example prompts:** "Why are fans talking about this today?"; "Why does this injury matter?"; "What is controversial about this rule change?"; "Why is fourth-and-two a debate?"
- **Timing:** weekly cycle: Monday recap and reaction, Tuesday/Wednesday injury and trade, Thursday preview, Sunday live, plus offseason cycles (draft, free agency).
- **Voice:** cheeky coach, warm, never about the crush, no faking expertise.

## 8. `this-week` unit templates (live hooks)

| Lesson template | Data used | Rendered content |
|---|---|---|
| `preview-01` Game preview | `SportsGame`, `InjuryEntry`, `StandingEntry` for the person's team | "What to watch" card, three concepts to refresh, a `say-this` item using the opponent, a follow-up question to ask |
| `recap-02` What happened | final `SportsGame`, `Storyline` | Result, why it happened in concept terms (turnovers, fourth downs), `multiple-choice` check |
| `injuries-03` The injury report | `InjuryEntry` | Term-match on designations, scenario about a missing position group |
| `picture-04` The playoff picture | `StandingEntry`, `Ranking` | Sequence of what must happen; tiebreaker explainer |
| `storyline-05` Why are fans talking about this? | `Storyline` | Our explanation, linked concept lessons, talk track |
| `offseason-06` Offseason moves | `CalendarEvent`, `Storyline` | Draft, free agency, trades in plain terms |

Each template lists `conceptIds` from the Playbook so mastery and review continue to work.

## 9. Personalization hooks (spec section 12)

- **team:** picks the followed team; drives which `SportsGame`, `InjuryEntry`, `StandingEntry`, `Storyline` items reach the feed and how `{{team}}` tokens render. Default: neutral "home team" plus the league featured game.
- **player:** picks a spotlight player for `PlayerStatLine` and follow-up lines; default: the team's starting quarterback.
- **league:** `nfl` or `college`; selects the branch, the calendar, standings/rankings type and rule notes.
- Foundations remain identical; only examples and live context personalize.
- **Discreet mode (spec/CLAUDE.md):** notifications never contain the person's name or relationship. Push "final score" notifications use generic copy ("Your team's game just ended") only if the person opted in.
- **Privacy:** live queries include only team ids, never personal data.

## 10. Licensing notes

- Store and display only what each provider's terms allow (cache duration, attribution, display of scores and injuries).
- No team logos, wordmarks or player images even if a provider offers them (trademark and likeness).
- Do not republish publisher text; headlines and short factual notes only where the news licence allows.
- Rankings (AP, Coaches) have their own copyright and licensing: confirm before showing polls or store rank numbers only as facts with attribution.
- Injury designations and league calendars are facts but the feed licence governs redistribution.
- Sports-betting affiliate data and odds are out of scope.

## 11. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Which provider licence supports a paid consumer app for NFL and NCAA scores, standings and injuries? Test TheSportsDB first, then price SportsDataIO / API-Sports. | Product | Yes |
| 2 | News/editorial source and its redistribution rights (Q-3). | Product | Yes |
| 3 | Rankings licensing (AP poll display). | Product | No |
| 4 | Score notifications: do we offer them at all, and in what discreet form? | Product | No |
| 5 | Who runs the weekly editorial workflow and at what cost? | Product | No |
