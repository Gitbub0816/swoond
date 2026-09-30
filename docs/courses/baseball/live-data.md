# Dynamic Data and Editorial Plan: Baseball (`baseball`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context) and 32-37 (provider isolation, sports data strategy, providers, news). Facts below were checked by web search on **2026-09-30** (secondary media) and must be re-verified at each release **[verify at release]**. Nothing time-sensitive appears in static lesson copy.

## 1. Verdict: is there meaningful live data?

**Yes, and more than most sports.** Baseball is a daily habit: 162 games from late March to late September, then October. The person she is learning for talks about *yesterday's game* and *this week's series*. The `season-now` unit and the daily context card are core, not decoration. Swoon'd is still not ESPN (spec section 33): final scores, current score for the followed team, standings, probable starters, transactions and injuries are enough. No pitch-by-pitch, no betting-grade data, no per-play win probability feeds.

Do not invent more: no live tracking data (Statcast) inside Swoon'd; link out instead.

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Team layer | Everyone with `team` set | Yesterday's result, today's game and probable starters, series preview, standings and games behind, active transactions and injuries for that team, "what she is likely to say tonight" |
| League layer | Everyone | Division and wild-card race, this week's biggest stories, award and milestone watch, rule and CBA news |
| Postseason layer | Everyone, October | Bracket, series status, "how a short series works" explainers |
| Branch layers (later) | `college`, `npb`, `kbo` | College: Omaha race, rankings; NPB: Climax Series and Japan Series; KBO: postseason, ABS talk |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer ("How the wild card works") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

External providers never become the domain model (spec section 32): Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. Every candidate sits behind a Swoon'd adapter.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules` | "When does she play; who starts?" | TheSportsDB (confirm MLB schedule coverage); Sportradar MLB or SportsDataIO MLB (upgrade); official team schedules (link-out) | Adapter to TheSportsDB first; upgrade only if coverage or terms fail | daily; hourly on game days | Last snapshot with "as of" and "check the official site" link |
| `scores` | Recaps, "did we win?" | Same; **not** the MLB Stats API (statsapi.mlb.com): it is an MLB Advanced Media property with restrictive terms and must not be used in production without a licence (also CLAUDE.md: no unofficial endpoints) | Adapter; cache last result | minutes during games for the followed team only; otherwise daily | Last final |
| `standings` | Division and wild-card race | Same; or computed by Swoon'd from final results | Adapter or in-house computation (games behind, magic number, tiebreaker notes) | daily | Snapshot with date |
| `statistics` | Player card, leaders | Provider basic stats; Retrosheet (historical, attribution notice); Lahman database (CC BY-SA 3.0, legal review of share-alike); Chadwick Bureau register (player ID crosswalk, attribution) | Static datasets ingested into the content pack for history; provider for current | daily | Evergreen definitions |
| `rosters` | Who is on the team / IL | Provider roster endpoints; official team pages (link-out) | Adapter | daily | Snapshot |
| `transactions` | Trades, signings, DFAs, call-ups | Sportradar/SportsDataIO transactions (upgrade); official MLB transactions page (link-out) | Adapter or curated link-out cards | daily; hourly the week of the deadline | Explainer card only |
| `injuries` | IL placements | Official team/league lists (link-out); provider upgrade | Link-out cards plus an explainer; no medical claims | daily | Hidden |
| `events` | Postseason bracket, All-Star Game, Draft, Winter Meetings, Opening Day | Bracket from provider results; official pages (link-out) | Curated dates plus provider results | seasonal | Evergreen explainer |
| `regulations` | Rule changes, CBA developments | MLB.com rules glossary and official rules (link-out); curated | Editorial cards with rule references and a `verifiedAt` date | on release | `modern-rules` unit |
| `news` | "Why is everyone talking about this?" | Publisher RSS headlines (link-only); MLB.com news; beat writers | **Link-only** ingestion; Swoon'd writes the explainer | daily | Evergreen explainers |
| `rankings` (light) | Prospects, college top 25 | Curated link-outs; D1Baseball (link-out) | Link-out | weekly | Skip |
| `weather` (optional) | Rainout or delay context | NWS API | Adapter when a `region` or team ballpark region is set | hourly on game days | Hidden |

Statcast (Baseball Savant), FanGraphs and Baseball-Reference are link-out only (their terms restrict scraping and reuse).

### Season calendar and situation (as of 2026-09-30) **[verify at release]**

- **MLB 2026 regular season** has just ended (about Sept 27). Reported division winners: Rays (AL East, best AL record), Guardians (AL Central), Astros (AL West; reported as the first team without a winning record to win a division in a 162-game season), Braves (NL East), Brewers (NL Central), Dodgers (NL West). Wild-card teams reported: Yankees, Red Sox and White Sox (AL); Padres, Cubs and Phillies (NL). Sources are secondary (ESPN, Yahoo, CBS, MLB.com); do not present as final without a provider check.
- **Postseason 2026:** 12 teams; top two seeds in each league get a bye (Dodgers, Brewers, Rays, Guardians reported); Wild Card Series (best of three at the higher seed's park) began **Sept 29**; Division Series begins **Oct 3**; NLCS reported to start **Oct 11**, ALCS **Oct 12**; World Series reported to start **Oct 23**. Game one of the Wild Card Series was Sept 29.
- **Defending champions:** Los Angeles Dodgers won the 2025 World Series over the Toronto Blue Jays, 4-3, with Game 7 won 5-4 in 11 innings (Will Smith's homer off Shane Bieber; Yoshinobu Yamamoto was World Series MVP); back-to-back titles after 2024, the first since the 2000 Yankees.
- **Awards (season-long reporting, not yet announced):** MVP and Cy Young awards are announced in November; media reports name leading candidates. Swoon'd does not display a "favorite" until the awards are announced.
- **Labour:** the collective bargaining agreement (CBA) expires **Dec 1 2026 (11:59 pm ET)**; owners proposed a salary cap and floor for the first time since 1994; the players' union rejects a cap; a lockout on or after Dec 1 is widely expected by media, not certain. A lockout would freeze free agency and trades and could threaten the 2027 season. Cards must be neutral and dated.
- **Rules in force 2026:** pitch clock (15 s bases empty, 18 s with runners on; batter set by 8 s), two disengagements per plate appearance (a third that does not pick off a runner is a balk), 18-inch bases, infield alignment restrictions (two infielders on each side of second, feet on the dirt), universal DH, automatic runner on second in extra innings, three-batter minimum, mound visits four per game, **ABS challenge system for the first time in the MLB regular season**: batter, pitcher or catcher may challenge within two seconds by tapping the head or helmet; two challenges per team per game, retained on a successful challenge; extra innings carry one over and add one per extra inning; no challenge after a replay review or when a position player is pitching. ABS zone width equals home plate (17 in) with height about 27 percent to 53.5 percent of the batter's height.
- **ABS results reported:** through early September about 9,000 challenges, roughly 54 percent overturned; batters roughly 49 percent, fielders (catchers, pitchers) roughly 58 percent. Numbers are dated and cited as "reported".
- **College (NCAA Division I):** the 2026 College World Series (Omaha) champion: Oklahoma over North Carolina (best of three: 9-3, 2-6, 13-2), Oklahoma's first title since 1994 (per WBSC and other coverage). The NCAA has approved the ABS challenge system for all divisions from the 2027 regular season (three challenges per team; pitcher, catcher or batter); the SEC piloted it in the 2026 SEC Tournament; Division I introduces a 30-second timer between batters and for mound visits and offensive timeouts in 2027 [verify: specific 2027 changes are as reported in July-August 2026].
- **NPB 2026 (snapshot, September):** Central League led by the Hanshin Tigers ahead of the Yomiuri Giants; Pacific League led by the Fukuoka SoftBank Hawks ahead of the Seibu Lions and Nippon-Ham Fighters. The Climax Series and Japan Series follow in October and November.
- **KBO 2026 (snapshot, September):** KT Wiz first, then Samsung Lions and LG Twins; the postseason follows in October.
- Calendar entries are stored as data with source URLs and `verifiedAt` dates, never as lesson copy.

## 4. Normalized Swoon'd entities (provider-agnostic)

Illustrative shapes (Swift/JSON names to be settled by the app team; all `Sendable` value types with strongly typed ids):

| Entity | Key fields | Notes |
|---|---|---|
| `BaseballGame` | `id`, `league` (mlb/college/npb/kbo), `season`, `startTime`, `homeTeamId`, `awayTeamId`, `status` (scheduled/live/final/postponed), `lineScore[]`, `homeRuns`, `awayRuns`, `winningPitcherId?`, `losingPitcherId?`, `savePitcherId?`, `probableStarters`, `venue`, `sourceURL`, `verifiedAt` | Line score only; no play-by-play |
| `BaseballTeam` | `id`, `league`, `division`, `name`, `city`, `venue`, `record`, `streak`, `runDifferential` | Logos never used |
| `Standing` | `season`, `teamId`, `division`, `wins`, `losses`, `pct`, `gamesBehind`, `wildCardGamesBehind`, `magicNumber`, `playoffStatus`, `snapshotDate` | Magic number computed by Swoon'd |
| `Player` | `id`, `displayName`, `position`, `throws`, `bats`, `teamId`, `status` (active/IL/minors), `snapshotDate` | Names as facts; no likeness |
| `PlayerLine` | `playerId`, `season`, `stat lines (basic)`, `snapshotDate` | Basic slash line, HR, RBI, ERA, IP, K; advanced stats link-out |
| `Transaction` | `id`, `date`, `type` (trade/signing/dfa/call-up/il), `teamIds`, `playerIds`, `summaryKey`, `sourceURL` | Explainer copy is Swoon'd's own |
| `InjuryNote` | `id`, `playerId`, `status`, `listedOn`, `sourceURL` | Neutral wording; no medical prognosis |
| `PostseasonSeries` | `id`, `round`, `higherSeedTeamId`, `lowerSeedTeamId`, `bestOf`, `wins`, `status` | Bracket built from results |
| `RuleUpdate` | `id`, `body` (mlb/ncaa/npb/kbo), `effectiveDate`, `topic`, `summaryKey`, `sourceURL`, `verifiedAt` | e.g. ABS challenge, pitch clock, CBA |
| `LaborStatus` | `id`, `agreementExpires`, `status` (in-force/lockout/agreement), `summaryKey`, `sourceURL`, `verifiedAt` | Neutral; dated |
| `EditorialCard` | `id`, `topic`, `conceptIds[]`, `explainer`, `links[]`, `publishedAt`, `expiresAt`, `teamId?` | Curated; see section 5 |
| `LocalContext` | `region`, `weatherSummary`, `venueNote?` | Optional; adapter-normalized |

Repository protocol: `LiveDataRepository` (D-004) returns these types; provider DTOs stay `internal` to their adapters. Standings and rankings are stored with `snapshotDate` and shown as such.

## 5. Editorial plan (spec sections 11, 37)

- **Principle:** structured data tells her *what* happened; editorial tells her *why people care*. They are separate systems.
- **Approach:** `explain-and-link`. Never copy publisher text; never copy league rule text wholesale; explain in Swoon'd's words with links and rule references.
- **Sources:** MLB.com news and rules glossary (link-only), beat writers (link-only), national outlets (link-only), Baseball America (link-only), FanGraphs (link-only). Editorial provider is an open decision (DECISIONS Q-3 / L-01); initial plan is a hand-curated editor plus *original* explainers reviewed before publishing.
- **Card types:**
  1. **Why is everyone talking about this?** (trade, injury, manager decision, umpire/ABS moment, rule controversy, lockout).
  2. **This week** (series, probable starters, race status).
  3. **Reading the result** (why a comeback mattered, what a blown save means for the standings).
  4. **Term of the week** (draws from the Playbook, links to a lesson).
  5. **What she'll probably say tonight** (pre-game conversation prompt tied to her team).
- **Sample prompts:** "Why are fans talking about the bullpen?", "Why did the manager pull the starter?", "What is a wild-card series?", "Why is the salary cap fight a big deal?", "What does the ABS challenge change?", "Why did the Astros win the division at .500?"
- **Editorial safety:** no accusations about named individuals; no injury prognoses or medical claims; neutral on labour disputes; PED-era items only factual and historical; no betting/odds content; cheeky but never mean to a team or its fans.

## 6. Personalization hooks (spec section 12)

| Dimension | Live-data effect |
|---|---|
| `team` | Leads the feed with the team's result, next game and probable starter, series preview, standings, transactions, injuries, and the "what she'll say tonight" card; `conversation-lab` scenarios use her team |
| `player` | Player card: recent form, milestones, awards, contract storyline (text-only) |
| `league` (branch) | MLB by default; `college` shows Omaha race; `npb`/`kbo` show their standings and postseason explainers |
| `region` | Weather for her team's park; "watch parties and broadcast availability" tips only where a reliable source exists |
| `skill-level` | Watcher vs plays-rec: which explainers show (rules mechanics vs analytics depth) |

Unset dimensions fall back to generic cards (a rotating example team as plain text); never blank.

## 7. Lesson hooks (`live` unit hooks in curriculum)

Unit `season-now` (`current-season`): `live-01` (schedules, scores), `live-02` (standings, events), `live-03` (transactions, injuries, news, regulations), `live-04` (statistics, events: awards and milestones), `live-05` (transactions, regulations, events: offseason and CBA). Lessons are templates: each week the template is instantiated with card content; exercises (mostly `multiple-choice`, `say-this`, `fill-the-gap`, `talk-track`) are generated from Swoon'd's own explainer text and entity data. Static lessons never embed dates, records, awards or player numbers that change (e.g. the rule facts in `modern-rules` are versioned tokens with a `verifiedAt` date).

Per-lesson `live` hooks (contract 1.2): `mod-04` (regulations: ABS challenge updates), `front-06` (regulations: CBA/lockout status), `oct-01` (events: bracket), `score-07` (standings), `front-05` (transactions: deadline).

## 8. Licensing and legal notes

- The MLB Stats API and Baseball Savant data are MLB Advanced Media properties with restrictive terms; no production use without an agreement. No scraping or reverse-engineered endpoints (CLAUDE.md section 3).
- Team and league names are trademarks: text mentions and links only; no logos, wordmarks or team-colour branding; non-affiliation footer.
- Player likeness: names as facts, no photos or endorsement implication.
- Retrosheet requires its notice text; Lahman is CC BY-SA 3.0 (share-alike: legal review before deriving a Swoon'd dataset); Chadwick Bureau register requires attribution [verify].
- Rulebook and article text is copyrighted: link, paraphrase, cite rule numbers.
- Video and broadcast: no embedding; deep-link to official sources.
- NCAA, NPB and KBO data and logos are separate licences; link-out and curated facts only.

## 9. Reliability and fallbacks

| Failure | Behaviour |
|---|---|
| Provider or curation delay | Show last verified data with "as of {date}"; never fabricate |
| No game today | "Off day" card plus an evergreen lesson |
| Rain delay or postponement | Show status; explain doubleheader rules on demand |
| Off-season | `season-rollover` card, hot-stove explainers, new-season rule recap |
| Lockout | Neutral explainer card; freeze transaction cards that would misstate legal status |
| Adapter/API removed | Adapter swapped; entities unchanged |
| Conflicting sources | Prefer official site; log discrepancy; hide the card until resolved |
| Region unset | Hide the local layer |

## 10. Open items

1. Provider and licence for MLB data (TheSportsDB coverage of MLB; Sportradar/SportsDataIO terms; MLB Stats API not usable without an agreement). (Product/Data; overlaps L-02)
2. Transactions and injuries feed licence (L-04 pattern). (Product)
3. Editorial provider selection and budget (DECISIONS Q-3 / L-01). (Product)
4. Who curates the weekly `season-now` cards and the CBA cards. (Product)
5. Re-verify before release: postseason bracket and results, division winners, award winners, ABS challenge rules and statistics, NCAA 2027 rule changes, NPB/KBO postseason formats, CBA status. (Content)
6. Lahman share-alike review and Retrosheet notice text. (Legal)
