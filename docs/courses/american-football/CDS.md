# Course Design Specification: American Football (`american-football`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Reference course #1 (CLAUDE.md section 13). Facts about rules and formats are verified as of 2026-09-30 (season context: the 2026 NFL season opens September 9, 2026; the reigning champion is the Seattle Seahawks, who beat the New England Patriots 29-13 in Super Bowl LX on February 8, 2026).

| Field | Value |
|---|---|
| Status | draft |
| Wave | 1 |
| Author / date | Claude Code (content agent), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/*.md`, `NOTES_FOR_ORCHESTRATOR.md` |

---

## 1. Identity
- **Course ID:** `american-football` (immutable)
- **Display name:** American Football
- **Category / family:** Sports; category path `Sports > American Football`
- **Simulation prefix:** `football` (sim IDs `football.<topic>.<name>.v1`; D-008)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns American Football, are they meaningfully conversationally competent about ...?" | Verdict | Consequence |
|---|---|---|---|
| NFL | Yes. The NFL is the default expression of the sport; nearly every foundation concept is the NFL game. | Shares foundation (branch) | NFL is the base course flow and the `nfl` branch. |
| College Football | Mostly, for the game itself (same plays, positions, schemes). No, for the culture: rankings, conferences, transfer portal, NIL, rivalry weeks, bowl games, and a few real rule differences (one-foot catch, overtime, clock). | Shares foundation (branch) | `college-football` branch unit (u13) layered on the same foundations. |
| Fantasy football | Partly. It is a game played on top of NFL stats. The talk (waiver, start/sit, bye week) is a distinct vocabulary. | Adjacent, folded in | One lesson in `league-machine` and conversation practice; not a separate course. No wagering content. |
| Basketball | No. Possession, clock and play-calling are similar ideas but every rule and vocabulary term differs. | Adjacent (independent) | Cross-link concepts (timeout, clock management); do not merge. |
| Soccer | No. Even the word football conflicts; offside means something different. | Sibling-independent | Explicitly teach "offside is not the soccer offside" as a misconception. |
| Hockey | No. | Sibling-independent | None. |
| Flag football | Largely (same ideas, fewer players, no contact). Olympic debut 2028. | Shares foundation (candidate future branch) | Not planned for v1; note in open questions. |
| Canadian football | Partly (three downs, 12 players, bigger field). | Adjacent (candidate future branch) | Not planned; note in open questions. |

- **Branches:**

| id | Name | What changes |
|---|---|---|
| `nfl` | NFL | Default. Rules per NFL rulebook; 32 teams, divisions, 17 games, 7-team-per-conference playoff, draft, salary cap; primetime and Super Bowl culture. Personalization dimension `league`. |
| `college-football` | College Football | Same game with different rules (one-foot catch, 3-yard two-point try, overtime format, clock, targeting ejection), plus conferences and realignment, the 12-team College Football Playoff, polls, transfer portal, NIL and revenue sharing, recruiting, bowl games, rivalry weeks. Data providers differ (school-level data). Personalization dimension `league` (value `college`) plus `team` = school. |

## 2. Beginner model
- **What a complete beginner knows:** touchdown, quarterback, Super Bowl, "halftime show", tailgating, maybe that it is played on Sundays; often confuses it with soccer terms. They usually know six points for a touchdown, and little else.
- **Terminology that will confuse them:** "down and distance" ("third and seven"), "the sticks", "sack", "audible", "checkdown", "nickel", "red zone", "Hail Mary", "safety" (both a position and a score), "spot of the foul", "pass interference", "line of scrimmage", "blitz", "Cover 2", "the two-minute warning", "PAT", "IR", "the cap".
- **Common misconceptions:**
  1. A touchdown is seven points (it is six; the extra point or two-point try comes after).
  2. The game is 60 minutes (the clock stops constantly, so it lasts about three hours).
  3. Fourth down is the last chance so everyone always punts (teams increasingly go for it; this is the biggest live debate).
  4. Offside works like soccer (in football it is only about crossing the line at the snap).
  5. A safety is a defender who is safe (it is a position and a two-point score).
  6. The quarterback throws every play; a "pass" means downfield (screens and checkdowns are short).
  7. The defense just chases the ball (coverages assign people or zones; man versus zone is the core idea).
  8. Holding is called every play so it is random (it is called on a small share of plays, and where it happens changes the result).
  9. A catch means holding the ball (it needs control, feet in bounds and a football move; NFL and college differ).
  10. College and NFL are the same game (they are not: rules, culture, calendar).
  11. Punting is surrendering (it is a field position weapon).
- **Concepts that unlock the rest (become foundation units):** the goal and field; downs and distance; the game clock and play clock; scoring; possession and turnovers; positions (who does what); offense (formations, run and pass, routes); defense (fronts, man vs zone, deep shells); penalties (the ones fans complain about).

## 3. Foundational knowledge
Grouped into modules (these become `foundationalModules[]` and units u01-u09).

| Module (unit id) | Contents |
|---|---|
| Rules and structure (`the-basics`) | 11 vs 11; 100-yard field plus two 10-yard end zones, 53 1/3 yards wide; four 15-minute quarters; three timeouts per half; 40-second play clock (25 after certain stoppages); downs (four tries for 10 yards); touchdown 6, field goal 3, extra point 1 (kick snapped from the 15, so a 33-yard kick), two-point try 2 (NFL: from the 2-yard line; college: the 3), safety 2. Turnovers: interception, fumble. |
| Participants (`players-positions`) | Offense (QB, RB, WR, TE, OL), defense (DL, LB, CB, S), special teams (K, P, long snapper, returner), coaches (head coach, coordinators), depth chart, jersey-number ranges, eligible receivers. |
| Offense (`offense-basics`) | Formations, personnel groupings (11, 12, 21...), shotgun vs under center, run game basics, the route tree (slant, out, curl, post, go, plus hitch, dig, corner, comeback), play-action, RPO, motion, tempo, audibles, screens, hot routes. |
| Defense (`defense-basics`) | Fronts (4-3, 3-4), man vs zone, shells (single-high, two-high), Cover 0-4, pass rush, blitz, nickel/dime, press coverage, run gaps (A/B/C/D), disguise. |
| Penalties and review (`flags-and-rules`) | Offside, false start, holding, pass interference (spot foul in the NFL, 15 yards in college), roughing the passer, hip-drop tackle (banned in the NFL since 2024), targeting (college ejection), intentional grounding, delay of game, illegal formation, the catch rule, accept/decline, replay: automatic review of scoring plays and turnovers, coach's challenges. In 2026 the league's Officiating Command Center may assist the on-field crew with clear video evidence on intentional grounding, roughing the passer and disqualifying acts. |
| Kicking game (`special-teams`) | Kickoff, the dynamic kickoff (introduced 2024; touchbacks to the 35 from 2025; 2026: a team may declare an onside kick at any time, the receiving team needs five players on the restraining line, and a loophole around intentionally kicking out of bounds after a penalty was closed), touchback, fair catch, punting and coffin corner, field goal range (attempt length is the yard line plus 17), onside kick. |
| Situations (`situational-football`) | Third down, fourth-down decisions, red zone, two-point decisions, two-minute drill, clock management, kneel-down, overtime (NFL: 10 minutes in the regular season, 15 in the playoffs; since 2025 both teams get a possession in the regular season, matching the playoffs). |
| The league (`league-machine`) | 32 teams, two conferences (AFC, NFC), four divisions each; 17 games over 18 weeks with a bye; 14 playoff teams (four division winners then three wild cards per conference; only the number-one seed gets a first-round bye); the draft (seven rounds, April); salary cap, free agency (March), franchise tag, 53-man roster, practice squad, injured reserve, trade deadline; primetime games; fantasy football. |
| Play craft (`play-craft`) | Pre-snap reads, route combinations (flood, mesh, smash), quarterback progressions, protection and hot routes, zone vs gap blocking, throwing windows, anticipation, the quarterback sneak and the tush push. |
| Culture, equipment, history | Helmet and pads (shown as diagrams; no trademarks); tailgating; Super Bowl Sunday; Thanksgiving games; dynasties; iconic plays; Hall of Fame in Canton, Ohio. |

## 4. Enthusiast model
- **What enthusiasts talk about:** their team's quarterback; coaching and play calls ("why did he run there?"); the injury report; fantasy lineups; the draft and free agency; the salary cap; officiating; playoff seeding; and matchups ("their corners cannot cover our receivers").
- **Distinctions that matter to them:** man vs zone (and the many named coverages); pre-snap tells versus post-snap rotation (disguise); run fits and gap responsibility; pass rush versus coverage ("coverage sacks"); scheme versus talent; explosive plays; third-down efficiency; turnover margin; hidden yardage in the kicking game; how a team's offense creates leverage with motion and formations.
- **Knowledge that signals genuine understanding:** reading a shell (one-high vs two-high) and saying what runs it invites; explaining why a play-action works only when the run game is respected; naming the free rusher; telling zone from gap runs; knowing why fourth-down aggression became popular (EPA and win probability); knowing the difference between cap hit, dead money and guaranteed money.
- **Beginner statements that sound obviously uninformed:** "Why don't they just throw deep every play?"; "He had 100 rushing yards so he was the MVP"; "The kicker does not matter"; "It was a fumble" (when it was an incomplete pass); "It is always the referee's fault"; "Defense is boring."
- **Common controversies and debates:** the tush push (2025 ban proposal failed 22-10, short of the 24 votes needed; it remains legal in 2026); dynamic kickoff rules; pass interference reviewability; the catch rule; fourth-down analytics vs old-school coaching; whether running backs deserve big contracts; quarterback wins as a stat; the 18-game season; overtime fairness; concussion protocols and hip-drop tackles; whether tanking is a problem; in college, expansion of the playoff (the 2026-27 CFP stays at 12 teams while the SEC and Big Ten disagree on 16 or more), the transfer portal, NIL and revenue sharing, and conference realignment.

## 5. Interaction model
- **What the learner should experience instead of reading:** reading a live-looking defense and finding the open receiver; drawing a route; counting rushers against blockers; choosing a running gap; leading a receiver with the ball. Also arguing fourth-down decisions, decoding fan sentences and chatting with a friendly fan.
- **Unity or native?** Five spatial, movement-over-time skills warrant Unity (tier rubric passed in sims/*): `football.coverage.read.v1`, `football.routes.build.v1`, `football.protection.pressure.v1`, `football.run.gaps.v1`, `football.passing.window.v1`. Everything static (terms, rules, formations on a diagram, decisions, clock feel, conversation) is native. Visual identification uses original procedural diagrams; listening uses original referee narration; decision scenarios teach judgment; sequencing teaches process; timing-tap teaches 1D clock feel.
- **What should NOT be gamified:** injuries and concussions (talked about with respect in `say-this` and articles, never scored as game outcomes); tragic events in player history; violence or hits as spectacle (sims show tackles as a pause, never gore); anything wagering-related (no odds, no props, no betting tie-ins); a fan's emotions after a loss (the loss talk track offers empathy, not points); real player likeness.
- **Summary:** 5 Unity sims + native exercises across all 13 types; details in section 12.

## 6. Dynamic information requirements
Football is a live sport with a weekly rhythm. Structured data and editorial data are separate systems (spec section 11).

| Kind | Needed? | Why | Provider candidates (through Swoon'd adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| scores | Yes | "Did they win?" is the first question after every game | TheSportsDB (initial per spec section 34), API-Sports American Football, SportsDataIO, Sportradar (upgrade) | minutes-during-events (2-5 minute lag is fine) | Cached last score with an "updated X min ago" tag; hide live badges |
| schedules | Yes | Next game for the person's team; "game night" prompts | TheSportsDB, official league schedule (link) | weekly; on schedule change | Cached; static bundled season file |
| standings | Yes | Playoff picture, division race, seeding | TheSportsDB, SportsDataIO | daily; hourly on Sundays | Cached |
| statistics | Light | Basic team and player stats for talk ("he has 900 yards"); never play-by-play | SportsDataIO, API-Sports, CollegeFootballData.com (college; community terms) | daily | Omit stat cards |
| rankings | College branch; NFL power rankings are editorial | AP poll, Coaches poll, CFP committee rankings drive college talk | CFBD, licensed news API | weekly (Sun/Mon; CFP Tuesdays in season) | Cached |
| rosters | Light | Who is the quarterback; injury and depth context | TheSportsDB, SportsDataIO | weekly; on transaction | Cached |
| events | Yes | Draft, free agency, trade deadline, kickoff, Super Bowl calendar | Static calendar plus league site link | seasonal | Bundled |
| alerts (injury report) | Yes | The single most useful current fact for a fan conversation | SportsDataIO, Sportradar; official team reports (link) | daily Wed-Fri, plus game-day inactives | Hide injury card |
| news | Yes (editorial) | Why are fans talking about this today? | Licensed news API (open question Q-3), publisher RSS headlines (link only) | hourly | Static evergreen explainer |
| weather | Optional later | Wind and cold explain kicks and passing in outdoor stadiums | Public weather service | hourly on game days | Omit |
| releases, new-products, closures | No | Not meaningful | | | |

Details, normalized entities and licensing in `live-data.md`.

## 7. Editorial context
- **What commentary helps:** explanations of why a coaching decision was debated, why an injury matters (positionally and schematically), what a trade or free-agent signing changes, what a rule change does, what a controversial call means, and why a playoff scenario is tricky.
- **Appropriate sources:** league and team press releases for facts; publisher headlines and links; official rulebooks; public records. All under publisher terms.
- **Summarize, explain or link?** Explain in our own words and link. Never copy publisher text. A Swoon'd-written explainer template ("why is this a big deal?") is attached to each current storyline, with one link to the original.
- **Example prompts:** "Why are fans talking about this today?"; "Why does this injury matter to a defense?"; "What is controversial about this rule change?"; "Why is fourth-and-two a debate?"; "What does the number-one seed actually buy you?"

## 8. Personalization
| Dimension | How it changes examples and live context | Default when unset | Units using tokens |
|---|---|---|---|
| `team` | Examples about the person's team; game preview, injury report and schedule cards; `{{team}}` in `team-lens`, `this-week`, `league-machine`, conversation practice | A neutral "home team" plus the league's featured game of the week (`{{team\|the home team}}`) | `team-lens`, `this-week`, `league-machine`, `conversation-lab`, `college-football` |
| `player` | Star-player cards and follow-up lines: `{{player}}` | The team's starting quarterback; when no team, a rotating star | `team-lens`, `this-week`, `conversation-lab` |
| `league` | `nfl` or `college` branch selection; switches rules and calendar context | `nfl` | branch gating (`branchId`) |
The foundations remain identical for everyone; only examples and live context personalize. No dimension is required.

## 9. Conversation model
Example lines an enthusiast might say, with translation and implied terminology:

| # | She says | Translation | Implied concepts |
|---|---|---|---|
| 1 | "Our secondary is absolutely killing us this year." | The cornerbacks and safeties are giving up big pass plays. | `secondary`, `cornerback`, `safety-position` |
| 2 | "I cannot believe he punted on fourth and two." | The coach was too conservative on a short fourth down. | `fourth-down-decision`, `punt` |
| 3 | "We keep stalling in the red zone." | They get near the goal line and only kick field goals. | `red-zone`, `field-goal` |
| 4 | "That was pass interference, no question." | A defender illegally contacted a receiver before the ball arrived. | `pass-interference` |
| 5 | "Their front seven is bringing so much pressure." | The defensive line and linebackers are hurrying the quarterback. | `pressure`, `blitz` |
| 6 | "We need to establish the run." | Run the ball successfully to open the pass through play-action. | `play-action`, `run-gap` |
| 7 | "The tush push should be banned." | The quarterback sneak with teammates pushing is nearly unstoppable and controversial. | `tush-push-debate`, `quarterback-sneak` |
| 8 | "Our offensive line can't protect him." | The blockers are letting rushers reach the quarterback. | `offensive-line`, `sack` |
| 9 | "We're stuck in Cover 3 and giving up the underneath." | The zone defense leaves short throws open. | `cover-3` |
| 10 | "We need the one seed for the bye." | Only the number-one seed skips the first playoff round. | `playoff-seeding`, `bye-week` |
| 11 | "His route running is elite." | He runs cuts and depth precisely, creating separation. | `route-tree` |
| 12 | "They got hit with a hip-drop." | A tackle the league banned for safety reasons. | `hip-drop-tackle` |
| 13 | "The portal ruined my roster." | College players transferred out. | `transfer-portal` |
| 14 | "My fantasy running back is on IR." | He is out for weeks, so I must replace him. | `fantasy-football`, `injured-reserve` |

- **What could the learner ask next?** Specific follow-ups: "Is it the corners or the safeties?", "Were they in man or zone?", "Was that a blitz?", "What would you have called?", "Is he hurt or is it scheme?"
- **How Swoon'd helps without encouraging fake expertise:** every conversation item rewards curiosity (honest questions score higher than bluffs); coach notes say "ask what you would honestly want to know"; `say-this` items carry a `noFakeExpertNote`; the "cringe" reply is always the confident wrong answer; nothing is presented as a line to memorize.
- **Targets:** at least 10 talk tracks at launch (10 authored in `exercises.md`), +3 per season; at least 150 `say-this` items across the course; every unit ends with a conversation lesson or `say-this` items.

## 10. Assessment
- **How useful competence is determined:** mastery of concepts (0-1) driven by exercise outcomes and sim mastery signals; talk track smoothness (>= 60 at end) on conversation lessons; spaced review retention.
- **Recognize:** formations and fronts; the name of a penalty from the referee's announcement; a coverage shell.
- **Understand:** why fourth down matters; why the clock stops; why a play-action needs a run game; why a blitz is a risk.
- **Explain:** downs and distance in one sentence; man versus zone; why a team punts; how playoff seeding works.
- **Correctly interpret:** a fan sentence (`say-this`); the standings; an injury report entry; a coaching decision.
- **Mastery model:** `concept-mastery-v1`, `passThreshold` 0.8. Unit checkpoints: "Sunday-ready" after u01-u04; "Watch-party ready" after u05-u09; "Debate-ready" after u10-u12.
- **Useful competence statement:** "Can follow a game with a fan, decode common fan talk, and ask a meaningful follow-up question."

## 11. Curriculum map (ongoing course)
Designed as an ongoing programme, not a deck: 17 units, 117 lessons at v1.0 (the live layer keeps shipping weekly and each season). Layer placement: units u01-u04 Foundations; u05-u09 Intermediate; u10-u14 Enthusiast depth (u13 is the College Football branch, u14 is the team-personalization unit); u15 live; u16 conversation; u17 review. Unit ids are the manifest `foundationalModules[]` where marked. Lesson ids are `<slug>-NN` with NN the position in the unit (`coverage-04` is the fourth lesson of `defense-basics`, matching the bridge examples).

| Layer | Purpose | Minimum expectation | This course |
|---|---|---|---|
| Foundations | Terms, rules, how it works | 4+ units, ~20+ lessons | 4 units, 30 lessons |
| Intermediate | Strategy, distinctions, context | 4+ units | 5 units, 37 lessons |
| Enthusiast depth | What fans debate; nuance; history/culture | 3+ units | 3 core units (u10-u12) plus branch and team units (u13-u14): 5 units, 32 lessons |
| Current-season / live layer | Ongoing, refreshed from live data and editorial | Templates + `live` hooks | u15, 6 weekly templates |
| Conversation practice | Talk tracks, say-this | Continuous; 10+ tracks | u16, 8 lessons, 10 tracks, say-this in every unit |
| Perpetual review | Spaced review | Review policy defined | u17, 4 review lesson templates |

### Foundations

| unit id | Unit title | Prerequisites | Lessons (count and titles) | Main concepts |
|---|---|---|---|---|
| `the-basics` (u01) | The basics | none | 7: What the game is about; The field and the line; Four downs; Where is the first down?; The clock; How points happen; Giving the ball away | `end-zone`, `possession`, `touchdown`, `line-of-scrimmage`, `field-position`, `downs`, `first-down`, `down-and-distance` ... |
| `players-positions` (u02) | Who does what | `the-basics` | 7: The quarterback; Backs, receivers and tight ends; The big guys up front; Linebackers and defensive backs; What she means by the secondary; Reading a jersey; Coaches and depth charts | `quarterback`, `coordinators`, `running-back`, `wide-receiver`, `tight-end`, `offensive-line`, `defensive-line`, `linebacker` ... |
| `offense-basics` (u03) | How offense works | `the-basics`, `players-positions` | 8: Lining up; Shotgun and under center; The running game; The route tree; Route lab; The fake; Screens and quick passes; Tempo and the huddle | `formation`, `personnel-grouping`, `shotgun`, `under-center`, `running-back`, `offensive-line`, `line-of-scrimmage`, `route-tree` ... |
| `defense-basics` (u04) | Reading the defense | `the-basics`, `players-positions` | 8: Fronts; Man or zone; The deep safeties; Read the coverage; The pass rush; The blitz; Nickel and matchups; Cover 4 and Cover 1 and 0 | `four-three-front`, `three-four-front`, `defensive-line`, `linebacker`, `man-coverage`, `zone-coverage`, `zone-vs-man`, `single-high-shell` ... |

### Intermediate

| unit id | Unit title | Prerequisites | Lessons (count and titles) | Main concepts |
|---|---|---|---|---|
| `flags-and-rules` (u05) | Flags and rules | `the-basics` | 8: Before the snap; Holding; Pass interference; Protecting players; Grounding and eligibility; What is a catch?; Flags, replay and challenges; Speaking referee | `offside`, `false-start`, `delay-of-game`, `holding`, `penalty-options`, `pass-interference`, `catch-rule`, `roughing-the-passer` ... |
| `special-teams` (u06) | The kicking game | `the-basics` | 6: The new kickoff; Fair catch and returns; Punting; Field goals; The onside kick; Special teams talk | `kickoff`, `dynamic-kickoff`, `touchback`, `fair-catch`, `punt`, `coffin-corner`, `field-position`, `field-goal` ... |
| `situational-football` (u07) | Situations and strategy | `the-basics`, `offense-basics`, `defense-basics` | 7: Third down; Go for it?; The red zone; Kick or go for two; Two-minute drill; Managing the clock; Overtime | `third-down`, `down-and-distance`, `fourth-down-decision`, `field-position`, `red-zone`, `field-goal`, `touchdown`, `two-point-conversion` ... |
| `league-machine` (u08) | How the league works | `the-basics` | 8: Conferences and divisions; Making the playoffs; The draft; The salary cap; Rosters and injuries; Trades and deadlines; Fantasy football; Game day life | `conference-division`, `seventeen-game-season`, `bye-week`, `playoff-seeding`, `draft`, `depth-chart`, `salary-cap`, `free-agency` ... |
| `play-craft` (u09) | Play craft | `offense-basics`, `defense-basics` | 8: The pre-snap read; Route combinations; Reading progression; Pressure count; Run gaps; Throwing windows; Zone or gap; Short yardage | `pre-snap-read`, `audible`, `disguise`, `route-combination`, `zone-vs-man`, `cover-3`, `quarterback-progression`, `checkdown` ... |

### Enthusiast depth (includes the branch and personalization units)

| unit id | Unit title | Prerequisites | Lessons (count and titles) | Main concepts |
|---|---|---|---|---|
| `scheme-literacy` (u10) | Scheme literacy | `play-craft` | 7: The West Coast offense; Air Raid and spread; Outside zone and play-action; Motion tells; Match and disguise; Tampa 2 and zone blitz; Boxes and mismatches | `west-coast-offense`, `quarterback-progression`, `air-raid`, `formation`, `no-huddle`, `shanahan-zone-scheme`, `outside-zone`, `play-action` ... |
| `debates-and-analytics` (u11) | Debates and analytics | `situational-football`, `scheme-literacy` | 6: Expected points; The go-for-it revolution; Are running backs worth it?; The quarterback wins myth; Tush push and the kickoff; Player safety and load | `epa`, `success-rate`, `fourth-down-decision`, `rb-value-debate`, `salary-cap`, `qb-wins`, `quarterback`, `tush-push-debate` ... |
| `history-and-lore` (u12) | History and lore | `the-basics` | 5: The merger and the first Super Bowl; Dynasties; Plays everyone quotes; The Hall of Fame; Thanksgiving and traditions | `nfl-afl-merger`, `super-bowl`, `conference-division`, `dynasty`, `iconic-play-lore`, `hail-mary`, `hall-of-fame`, `primetime-games` ... |
| `college-football` (u13) | College football | `the-basics`, `players-positions` | 8: What is different; Polls and the committee; The 12-team playoff; Conference chaos; Portal and NIL; Recruiting; Heisman and awards; Rivalry week | `college-clock-rules`, `college-catch-rule`, `college-overtime`, `polls-rankings`, `cfp-format`, `bowl-games`, `conference-realignment`, `rivalry-game` ... |
| `team-lens` (u14) | Your team | `the-basics`, `players-positions` | 6: Your team's identity; How {{team}} plays; The players to know; Division rivals; Team history; How {{team}} fans talk | `team-identity`, `formation`, `pre-snap-read`, `quarterback`, `divisional-rivals`, `conference-division`, `iconic-play-lore`, `tailgating` |

### Current-season / live layer

| unit id | Unit title | Prerequisites | Lessons (count and titles) | Main concepts |
|---|---|---|---|---|
| `this-week` (u15) | This week in football | `league-machine` | 6: Game preview; What happened; The injury report; The playoff picture; Why are fans talking about this?; Offseason moves | `injury-report`, `team-identity`, `divisional-rivals`, `down-and-distance`, `turnover`, `epa`, `depth-chart`, `playoff-picture` ... |

### Conversation practice

| unit id | Unit title | Prerequisites | Lessons (count and titles) | Main concepts |
|---|---|---|---|---|
| `conversation-lab` (u16) | Conversation lab | `the-basics` | 8: The first text; Pregame nerves; During the game; After a tough loss; After a big win; Fantasy and trash talk; The watch party; Friendly debate | `follow-up-question`, `listen-first`, `honest-not-expert`, `touchdown`, `interception`, `team-identity`, `fantasy-football`, `zone-vs-man` ... |

### Perpetual review

| unit id | Unit title | Prerequisites | Lessons (count and titles) | Main concepts |
|---|---|---|---|---|
| `always-on-review` (u17) | Always-on review | `the-basics` | 4: Daily bite; Weekly mix; Sim refresher; New season refresher | `downs`, `zone-vs-man`, `first-down`, `cover-3`, `follow-up-question`, `cover-2`, `run-gap`, `rule-change-of-year` ... |

### Lessons by unit

Activities are native exercise types or a Unity sim id. Every lesson also has a closing `say-this` or review item where natural (not repeated here).

#### u01 `the-basics`: The basics (foundations)

The goal, the field, the clock, four downs and how scoring works.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `goal-01` | What the game is about | You can say in one sentence how a team wins. | `end-zone`, `possession`, `touchdown` | `multiple-choice`, `hotspot-tap` |
| `field-02` | The field and the line | You can point to the end zone, yard lines and the line of scrimmage. | `end-zone`, `line-of-scrimmage`, `field-position` | `hotspot-tap`, `fill-the-gap` |
| `downs-03` | Four downs | You can explain what a down is and why fourth down matters. | `downs`, `first-down`, `down-and-distance` | `multiple-choice`, `fill-the-gap`, `binary-call` |
| `markers-04` | Where is the first down? | You can read the yellow line and say if they got the first down. | `first-down-marker`, `first-down`, `downs` | `binary-call`, `hotspot-tap` |
| `clock-05` | The clock | You can say how long a game is and why it feels longer. | `game-clock`, `play-clock`, `timeout` | `estimate-slider`, `multiple-choice`, `timing-tap` |
| `scoring-06` | How points happen | You can add up a score from touchdowns, kicks and safeties. | `touchdown`, `field-goal`, `extra-point`, `two-point-conversion`, `safety-score` | `term-match`, `estimate-slider`, `multiple-choice` |
| `turnovers-07` | Giving the ball away | You can say the difference between a fumble, an interception and a punt. | `turnover`, `interception`, `fumble`, `punt`, `drive` | `term-match`, `say-this` |

#### u02 `players-positions`: Who does what (foundations)

Every position on the field and what fans mean when they name one.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `qb-01` | The quarterback | You can say why everyone talks about the quarterback. | `quarterback`, `coordinators` | `multiple-choice`, `say-this` |
| `backfield-02` | Backs, receivers and tight ends | You can tell the skill positions apart by what they do. | `running-back`, `wide-receiver`, `tight-end` | `term-match`, `visual-id` |
| `trenches-03` | The big guys up front | You can explain what the offensive line is protecting and why fans love a good one. | `offensive-line`, `defensive-line` | `multiple-choice`, `hotspot-tap` |
| `back-seven-04` | Linebackers and defensive backs | You can name the defenders behind the line and what each one covers. | `linebacker`, `cornerback`, `safety-position`, `secondary` | `term-match`, `hotspot-tap` |
| `secondary-05` | What she means by the secondary | You can decode a sentence about the secondary. | `secondary`, `cornerback`, `strong-safety` | `say-this`, `multiple-choice` |
| `numbers-06` | Reading a jersey | You can guess a player's position from his number. | `jersey-numbers`, `eligible-receiver` | `visual-id`, `fill-the-gap` |
| `staff-07` | Coaches and depth charts | You can tell a coordinator from a head coach and read a depth chart. | `coordinators`, `depth-chart`, `special-teams-unit` | `term-match`, `multiple-choice` |

#### u03 `offense-basics`: How offense works (foundations)

Formations, the run and pass games, and the route tree.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `formations-01` | Lining up | You can read a basic formation and count receivers. | `formation`, `personnel-grouping` | `hotspot-tap`, `multiple-choice` |
| `snap-02` | Shotgun and under center | You can tell shotgun from under center and guess the play type. | `shotgun`, `under-center` | `binary-call`, `multiple-choice` |
| `runs-03` | The running game | You can describe how a handoff turns into yards. | `running-back`, `offensive-line`, `line-of-scrimmage` | `multiple-choice`, `sequence-order` |
| `routes-04` | The route tree | You can name the six main routes. | `route-tree`, `slant-route`, `go-route`, `out-route`, `post-route`, `curl-route` | `term-match`, `visual-id` |
| `route-lab-05` | Route lab | You can build a route so the break comes at the right depth and angle. | `route-tree`, `post-route`, `out-route`, `curl-route` | `unity-sim football.routes.build.v1`, `multiple-choice` |
| `play-action-06` | The fake | You can explain why a fake handoff works. | `play-action`, `run-pass-option` | `multiple-choice`, `say-this` |
| `screens-07` | Screens and quick passes | You can say why a screen beats a blitz. | `screen-pass`, `slant-route`, `blitz` | `binary-call`, `decision-scenario` |
| `tempo-08` | Tempo and the huddle | You can spot no-huddle and an audible. | `no-huddle`, `audible`, `play-clock` | `say-this`, `multiple-choice` |

#### u04 `defense-basics`: Reading the defense (foundations)

Fronts, man versus zone, coverage shells and pass rush.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `fronts-01` | Fronts | You can tell a 4-3 from a 3-4 and say who rushes. | `four-three-front`, `three-four-front`, `defensive-line`, `linebacker` | `hotspot-tap`, `term-match` |
| `man-zone-02` | Man or zone | You can explain the difference between man and zone coverage. | `man-coverage`, `zone-coverage`, `zone-vs-man` | `binary-call`, `multiple-choice` |
| `shells-03` | The deep safeties | You can spot one-high and two-high shells. | `single-high-shell`, `two-high-shell`, `safety-position` | `hotspot-tap`, `visual-id` |
| `coverage-04` | Read the coverage | You can name the coverage and find the open receiver. | `cover-2`, `cover-3`, `zone-vs-man`, `man-coverage` | `unity-sim football.coverage.read.v1`, `multiple-choice` |
| `pass-rush-05` | The pass rush | You can say what a sack, a hurry and pressure mean. | `pass-rush`, `sack`, `pressure`, `edge-rusher`, `stunt` | `term-match`, `say-this` |
| `blitz-06` | The blitz | You can explain the risk and reward of a blitz. | `blitz`, `cover-0`, `cover-1` | `decision-scenario`, `multiple-choice` |
| `nickel-07` | Nickel and matchups | You can say why defenses use five defensive backs. | `nickel`, `cornerback`, `press-coverage` | `multiple-choice`, `fill-the-gap` |
| `cover-4-08` | Cover 4 and Cover 1 and 0 | You can place every coverage on a risk ladder. | `cover-0`, `cover-1`, `cover-4`, `cover-2`, `cover-3` | `sequence-order`, `term-match` |

#### u05 `flags-and-rules`: Flags and rules (intermediate)

The penalties fans argue about and what the referee is actually calling.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `before-snap-01` | Before the snap | You can tell offside from false start. | `offside`, `false-start`, `delay-of-game` | `binary-call`, `listening-id` |
| `holding-02` | Holding | You can explain why holding is called so often and what it costs. | `holding`, `penalty-options` | `multiple-choice`, `binary-call` |
| `interference-03` | Pass interference | You can explain why pass interference is such a big deal. | `pass-interference`, `catch-rule` | `decision-scenario`, `multiple-choice` |
| `safety-04` | Protecting players | You can name the hits the league bans and why. | `roughing-the-passer`, `hip-drop-tackle`, `targeting` | `term-match`, `binary-call` |
| `grounding-05` | Grounding and eligibility | You can spot intentional grounding and illegal formation. | `intentional-grounding`, `illegal-formation`, `eligible-receiver` | `binary-call`, `say-this` |
| `catch-06` | What is a catch? | You can explain the catch rule, and why nobody agrees. | `catch-rule`, `college-catch-rule`, `replay-review` | `multiple-choice`, `decision-scenario` |
| `review-07` | Flags, replay and challenges | You can say what can be reviewed and who decides. | `replay-review`, `penalty-options` | `sequence-order`, `say-this` |
| `referee-08` | Speaking referee | You can decode a referee announcement. | `offside`, `holding`, `pass-interference`, `penalty-options` | `listening-id`, `say-this` |

#### u06 `special-teams`: The kicking game (intermediate)

Kickoffs, punts, field goals and how special teams swing games.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `kickoff-01` | The new kickoff | You can explain the dynamic kickoff in one sentence. | `kickoff`, `dynamic-kickoff`, `touchback` | `hotspot-tap`, `multiple-choice` |
| `returns-02` | Fair catch and returns | You can say when a fair catch is smart. | `fair-catch`, `touchback` | `binary-call`, `decision-scenario` |
| `punting-03` | Punting | You can say why a punt is a weapon, not a surrender. | `punt`, `coffin-corner`, `field-position` | `multiple-choice`, `estimate-slider` |
| `kicking-04` | Field goals | You can guess whether a kick is in range. | `field-goal`, `field-goal-range`, `extra-point` | `estimate-slider`, `binary-call` |
| `onside-05` | The onside kick | You can explain the onside kick and the 2026 change. | `onside-kick`, `rule-change-of-year` | `multiple-choice`, `say-this` |
| `specials-06` | Special teams talk | You can hear a special teams complaint and translate it. | `special-teams-unit`, `touchback`, `fair-catch` | `say-this`, `talk-track` |

#### u07 `situational-football`: Situations and strategy (intermediate)

Fourth downs, the red zone, the two-minute drill and clock management.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `third-down-01` | Third down | You can say why third down decides drives. | `third-down`, `down-and-distance` | `multiple-choice`, `decision-scenario` |
| `fourth-02` | Go for it? | You can weigh a fourth-down decision the way fans do. | `fourth-down-decision`, `field-position` | `decision-scenario`, `estimate-slider` |
| `red-zone-03` | The red zone | You can explain why scoring gets harder near the goal line. | `red-zone`, `field-goal`, `touchdown` | `multiple-choice`, `hotspot-tap` |
| `two-point-04` | Kick or go for two | You can explain when a team goes for two. | `two-point-conversion`, `extra-point` | `decision-scenario`, `fill-the-gap` |
| `two-minute-05` | Two-minute drill | You can describe how a team saves the clock. | `two-minute-drill`, `clock-management`, `timeout` | `sequence-order`, `timing-tap` |
| `clock-06` | Managing the clock | You can spot good and bad clock management. | `clock-management`, `victory-formation`, `timeout` | `decision-scenario`, `say-this` |
| `overtime-07` | Overtime | You can explain how overtime works and who gets the ball. | `overtime`, `field-goal`, `touchdown` | `multiple-choice`, `sequence-order` |

#### u08 `league-machine`: How the league works (intermediate)

Divisions, playoffs, the draft, the salary cap and life as a fan. Branch: `nfl` (default). Personalization slot: `team`.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `structure-01` | Conferences and divisions | You can name how the 32 teams are grouped. | `conference-division`, `seventeen-game-season`, `bye-week` | `hotspot-tap`, `fill-the-gap` |
| `playoffs-02` | Making the playoffs | You can explain seeds, wild cards and the bye. | `playoff-seeding`, `conference-division` | `sequence-order`, `multiple-choice` |
| `draft-03` | The draft | You can say why bad teams pick first. | `draft`, `depth-chart` | `multiple-choice`, `say-this` |
| `cap-04` | The salary cap | You can say why teams cut good players. | `salary-cap`, `free-agency`, `franchise-tag` | `decision-scenario`, `multiple-choice` |
| `roster-05` | Rosters and injuries | You can decode roster moves in the news. | `roster-53`, `practice-squad`, `injured-reserve` | `term-match`, `say-this` |
| `trades-06` | Trades and deadlines | You can say what a trade means for a team. | `trade-deadline`, `salary-cap`, `draft` | `multiple-choice`, `decision-scenario` |
| `fantasy-07` | Fantasy football | You can follow a fantasy conversation without panic. | `fantasy-football`, `bye-week`, `injury-report` | `say-this`, `term-match` |
| `gameday-08` | Game day life | You can talk primetime, tailgating and Super Bowl Sunday. | `primetime-games`, `tailgating`, `super-bowl` | `say-this`, `talk-track` |

#### u09 `play-craft`: Play craft (intermediate)

How passing and running plays are actually built and beaten.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `pre-snap-01` | The pre-snap read | You can list what a quarterback checks before the snap. | `pre-snap-read`, `audible`, `disguise` | `multiple-choice`, `hotspot-tap` |
| `combos-02` | Route combinations | You can describe flood, mesh and smash. | `route-combination`, `zone-vs-man`, `cover-3` | `hotspot-tap`, `multiple-choice` |
| `progression-03` | Reading progression | You can explain a quarterback's first, second and third read. | `quarterback-progression`, `checkdown` | `sequence-order`, `multiple-choice` |
| `protection-04` | Pressure count | You can find the free rusher and choose the right answer. | `protection-scheme`, `blitz`, `hot-route`, `pressure` | `unity-sim football.protection.pressure.v1`, `multiple-choice` |
| `run-gaps-05` | Run gaps | You can name the gap a run hits and who is responsible for it. | `run-gap`, `inside-zone`, `outside-zone`, `gap-scheme` | `unity-sim football.run.gaps.v1`, `hotspot-tap` |
| `throw-window-06` | Throwing windows | You can see why the same throw works on one snap and fails on the next. | `passing-window`, `anticipation-throw`, `back-shoulder-throw`, `yards-after-catch` | `unity-sim football.passing.window.v1`, `multiple-choice` |
| `blocking-07` | Zone or gap | You can tell zone blocking from a gap scheme. | `zone-blocking`, `gap-scheme`, `pulling-guard` | `binary-call`, `term-match` |
| `short-yardage-08` | Short yardage | You can explain the sneak and why teams love it. | `quarterback-sneak`, `tush-push-debate`, `fourth-down-decision` | `decision-scenario`, `say-this` |

#### u10 `scheme-literacy`: Scheme literacy (enthusiast)

The system names fans and announcers throw around.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `west-coast-01` | The West Coast offense | You can say what a West Coast offense actually asks the quarterback to do. | `west-coast-offense`, `quarterback-progression` | `multiple-choice`, `say-this` |
| `air-raid-02` | Air Raid and spread | You can spot Air Raid habits. | `air-raid`, `formation`, `no-huddle` | `say-this`, `term-match` |
| `shanahan-03` | Outside zone and play-action | You can explain why one play sells the other. | `shanahan-zone-scheme`, `outside-zone`, `play-action` | `multiple-choice`, `sequence-order` |
| `motion-tells-04` | Motion tells | You can use motion to guess man or zone. | `pre-snap-motion`, `man-coverage`, `zone-coverage` | `unity-sim football.coverage.read.v1`, `say-this` |
| `match-05` | Match and disguise | You can explain why coverage names are slippery. | `match-coverage`, `disguise`, `cover-2`, `cover-3` | `multiple-choice`, `decision-scenario` |
| `tampa-zone-blitz-06` | Tampa 2 and zone blitz | You can describe two classic defensive ideas. | `tampa-2`, `zone-blitz` | `term-match`, `multiple-choice` |
| `matchups-07` | Boxes and mismatches | You can say why the box count and mismatches drive play calls. | `light-box`, `mismatch`, `single-high-shell` | `decision-scenario`, `say-this` |

#### u11 `debates-and-analytics`: Debates and analytics (enthusiast)

The arguments fans love and the numbers behind them.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `epa-01` | Expected points | You can say what EPA measures without a math degree. | `epa`, `success-rate` | `multiple-choice`, `estimate-slider` |
| `fourth-analytics-02` | The go-for-it revolution | You can explain why analytics pushed fourth-down aggression. | `fourth-down-decision`, `epa` | `decision-scenario`, `say-this` |
| `rb-value-03` | Are running backs worth it? | You can argue both sides of the running back debate. | `rb-value-debate`, `salary-cap` | `multiple-choice`, `talk-track` |
| `qb-wins-04` | The quarterback wins myth | You can say why quarterback wins is a shaky stat. | `qb-wins`, `quarterback` | `say-this`, `multiple-choice` |
| `tush-kick-05` | Tush push and the kickoff | You can explain two live rule fights. | `tush-push-debate`, `kickoff-debate`, `dynamic-kickoff` | `decision-scenario`, `talk-track` |
| `safety-06` | Player safety and load | You can talk about concussions and rule changes with respect. | `concussion-protocol`, `hip-drop-tackle`, `targeting` | `multiple-choice`, `say-this` |

#### u12 `history-and-lore`: History and lore (enthusiast)

Where the game came from and the stories fans quote.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `merger-01` | The merger and the first Super Bowl | You can explain the AFC/NFC split. | `nfl-afl-merger`, `super-bowl`, `conference-division` | `sequence-order`, `multiple-choice` |
| `dynasties-02` | Dynasties | You can name what makes a dynasty. | `dynasty`, `super-bowl` | `multiple-choice`, `say-this` |
| `plays-03` | Plays everyone quotes | You can recognize the famous plays. | `iconic-play-lore`, `hail-mary` | `term-match`, `say-this` |
| `canton-04` | The Hall of Fame | You can explain Canton and the yearly debate. | `hall-of-fame`, `dynasty` | `multiple-choice`, `say-this` |
| `tradition-05` | Thanksgiving and traditions | You can say why football owns holidays. | `primetime-games`, `tailgating`, `rivalry-game` | `say-this`, `talk-track` |

#### u13 `college-football`: College football (enthusiast)

A separate world: rankings, conferences, rules and rivalries. Branch unit: `branchId: college-football`. Personalization slot: `team` (school).

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `college-01` | What is different | You can list the biggest rule differences. | `college-clock-rules`, `college-catch-rule`, `college-overtime` | `term-match`, `binary-call` |
| `polls-02` | Polls and the committee | You can explain how rankings work. | `polls-rankings`, `cfp-format` | `multiple-choice`, `sequence-order` |
| `playoff-03` | The 12-team playoff | You can explain byes, seeds and automatic bids. | `cfp-format`, `bowl-games`, `polls-rankings` | `sequence-order`, `multiple-choice` |
| `realignment-04` | Conference chaos | You can explain realignment in a sentence. | `conference-realignment`, `rivalry-game` | `multiple-choice`, `say-this` |
| `portal-05` | Portal and NIL | You can explain why rosters change every year. | `transfer-portal`, `nil-revenue-sharing`, `recruiting` | `decision-scenario`, `say-this` |
| `recruiting-06` | Recruiting | You can decode recruiting talk. | `recruiting`, `transfer-portal` | `term-match`, `say-this` |
| `awards-07` | Heisman and awards | You can say what a Heisman campaign is. | `heisman`, `polls-rankings` | `multiple-choice`, `say-this` |
| `rivalries-08` | Rivalry week | You can talk rivalry games without insulting anyone. | `rivalry-game`, `tailgating` | `say-this`, `talk-track` |

#### u14 `team-lens`: Your team (enthusiast)

Personalized lessons built around {{team}} and {{player}}. Slots fall back to a default team. Personalization slots: `team`, `player` (`{{team}}`, `{{player}}`).

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `identity-01` | Your team's identity | You can say what {{team}} is known for. | `team-identity` | `say-this`, `multiple-choice` |
| `scheme-02` | How {{team}} plays | You can describe {{team}}'s offense and defense in one line each. | `formation`, `pre-snap-read`, `team-identity` | `hotspot-tap`, `multiple-choice` |
| `stars-03` | The players to know | You can name three players and their roles. | `team-identity`, `quarterback` | `term-match`, `say-this` |
| `rivals-04` | Division rivals | You can name the rivals and why they matter. | `divisional-rivals`, `conference-division` | `multiple-choice`, `say-this` |
| `history-05` | Team history | You can quote one moment in {{team}} history. | `team-identity`, `iconic-play-lore` | `say-this`, `multiple-choice` |
| `fans-06` | How {{team}} fans talk | You can recognize the chants and complaints. | `team-identity`, `tailgating` | `say-this`, `talk-track` |

#### u15 `this-week`: This week in football (current-season)

Weekly templates generated from live data and editorial context. Content refreshes; lessons do not go stale. `live` hook: `dataKind` scores, schedules, standings, alerts, news; `refreshHint` hourly (minutes during games); `adapterKey` `american-football.weekly`. Lessons are templates filled from normalized data, not static content.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `preview-01` | Game preview | You can explain what to watch for in your team's next game. | `injury-report`, `team-identity`, `divisional-rivals` | `say-this`, `multiple-choice` |
| `recap-02` | What happened | You can explain why the result happened. | `down-and-distance`, `turnover`, `epa` | `multiple-choice`, `say-this` |
| `injuries-03` | The injury report | You can read the injury report and explain who matters. | `injury-report`, `depth-chart` | `term-match`, `decision-scenario` |
| `picture-04` | The playoff picture | You can say who is in and what they need. | `playoff-picture`, `tiebreakers`, `playoff-seeding` | `sequence-order`, `multiple-choice` |
| `storyline-05` | Why are fans talking about this? | You can explain the week's big storyline in your own words. | `power-rankings`, `rule-change-of-year` | `say-this`, `talk-track` |
| `offseason-06` | Offseason moves | You can follow the draft, free agency and trades. | `draft`, `free-agency`, `trade-deadline` | `multiple-choice`, `say-this` |

#### u16 `conversation-lab`: Conversation lab (conversation)

Practice real conversations in progressively harder settings. Talk tracks unlock here and in the Talk tab (`talkTracks[]`).

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `first-text-01` | The first text | You can respond to a friendly game text naturally. | `follow-up-question`, `listen-first` | `talk-track`, `say-this` |
| `pregame-02` | Pregame nerves | You can ask about the matchup without bluffing. | `honest-not-expert`, `follow-up-question` | `talk-track`, `say-this` |
| `sunday-03` | During the game | You can react to a big play in the moment. | `touchdown`, `interception`, `follow-up-question` | `talk-track`, `say-this` |
| `loss-04` | After a tough loss | You can comfort without faking. | `listen-first`, `honest-not-expert` | `talk-track` |
| `win-05` | After a big win | You can celebrate and ask a good question. | `follow-up-question`, `team-identity` | `talk-track`, `say-this` |
| `fantasy-06` | Fantasy and trash talk | You can play along with fantasy banter. | `fantasy-football`, `follow-up-question` | `talk-track`, `say-this` |
| `watch-party-07` | The watch party | You can hold your own with her friends. | `honest-not-expert`, `zone-vs-man`, `follow-up-question` | `talk-track`, `say-this` |
| `debate-08` | Friendly debate | You can disagree kindly. | `qb-wins`, `rb-value-debate`, `listen-first` | `talk-track`, `say-this` |

#### u17 `always-on-review`: Always-on review (review)

Spaced review of everything mastered, delivered as short mixed sessions. Cards are selected by the review policy below, not authored per lesson.

| lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `daily-bite-01` | Daily bite | You can retrieve one term a day. | `downs`, `zone-vs-man` | `multiple-choice`, `fill-the-gap` |
| `weekly-mix-02` | Weekly mix | You can mix terms, scenes and conversation. | `first-down`, `cover-3`, `follow-up-question` | `say-this`, `multiple-choice` |
| `sim-refresh-03` | Sim refresher | You can re-run a sim on a concept that is fading. | `cover-2`, `run-gap` | `unity-sim football.coverage.read.v1`, `unity-sim football.run.gaps.v1` |
| `season-refresh-04` | New season refresher | You can catch up on this year's rules and storylines. | `rule-change-of-year`, `epa` | `multiple-choice`, `say-this` |

- **Concept count target (Playbook):** 176 concepts authored for v1.0.0 (listed in `exercises.md` section 4); every `conceptId` above exists in that list.
- **Personalization slots:** `team`, `player`, `league` (section 8), used by `team-lens`, `this-week`, `league-machine`, `conversation-lab`, `college-football`.
- **Review policy (perpetual review):** `leitner-boxes-v1`; `intervalsDays` [1, 3, 7, 14, 30, 60]; `maxItemsPerSession` 12; `masteryThreshold` 0.8; `decayAfterDays` 45 (paused during the offseason refresher week); review activity types: multiple-choice, fill-the-gap, say-this, binary-call, term-match, estimate-slider, hotspot-tap, plus a sim refresher no more than once per week.
- **Release plan:** *Launch (curriculum 1.0.0):* u01-u09 and u14-u17 with the first three Unity sims (coverage read, run gaps, pressure count), 10 talk tracks, and the weekly live templates (scores, schedule, standings, injury card). *1.1:* u10-u12 (enthusiast depth), remaining sims (routes, throwing window), and native fallbacks. *1.2:* u13 College Football branch (timed before the college season). *Continuous:* the live layer each week; a new-season update each August (rule changes, kickoff rules, playoff format, 3 new talk tracks, refreshed `say-this`); a mid-season 'storyline of the week' refresh. *Deprecation:* concepts tied to a single season are tagged and rewritten annually.


## 12. Interaction plan
Every activity family maps to a native type or a Unity sim. Unity is used only where spatial reasoning, movement, timing in a scene or camera perspective materially improves learning and a native exercise would teach it clearly worse (CLAUDE.md section 4). Individual items are in curriculum JSON; native samples and counts in `exercises.md`.

| Lesson / activity family | Concepts | Type (native exercise or `unity-sim`) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| U1. Read the coverage: `defense-basics/coverage-04`, `scheme-literacy/motion-tells-04`, `always-on-review/sim-refresh-03` | `zone-vs-man`, `cover-2`, `cover-3`, `cover-4`, `man-coverage`, `pre-snap-motion`, `disguise` | `unity-sim` `football.coverage.read.v1` | Rubric: movement over time and camera perspective. Man vs zone is invisible in a still frame; a safety rotating or a corner following motion only shows in motion. Closest native (`hotspot-tap`, `binary-call`) teaches the label, not the read. Spec: `sims/football.coverage.read.v1.md` | A | 3 lessons, 18 scenarios |
| U2. Route lab: `offense-basics/route-lab-05` | `route-tree`, `slant-route`, `out-route`, `curl-route`, `post-route`, `go-route` | `unity-sim` `football.routes.build.v1` | Rubric: spatial reasoning (depth and cut geometry) and movement (route plus defender reaction). Native `visual-id` and `hotspot-tap` cover recognition (used in `routes-04`); they cannot teach construction. Weakest Unity case; downgrade-to-native decision gate in the spec. Spec: `sims/football.routes.build.v1.md` | A | 1 lesson (+ review), 12 scenarios |
| U3. Pressure count: `play-craft/protection-04` | `blitz`, `pressure`, `protection-scheme`, `hot-route`, `pre-snap-read`, `edge-rusher` | `unity-sim` `football.protection.pressure.v1` | Rubric: spatial reasoning and timing (a free rusher arrives in about two seconds; a hot throw takes 1.3). Native `hotspot-tap` names the blitzer but cannot show the race or the bluff. Spec: `sims/football.protection.pressure.v1.md` | A | 1 lesson (+ live template), 12 scenarios |
| U4. Run gaps: `play-craft/run-gaps-05`, `always-on-review/sim-refresh-03` | `run-gap`, `inside-zone`, `outside-zone`, `gap-scheme`, `pulling-guard`, `zone-blocking`, `light-box` | `unity-sim` `football.run.gaps.v1` | Rubric: spatial reasoning and camera (behind-the-back vs top-down): a crease opens and closes in half a second. `hotspot-tap` and `term-match` teach gap letters only. Spec: `sims/football.run.gaps.v1.md` | A | 2 lessons, 12 scenarios |
| U5. Throwing window: `play-craft/throw-window-06` | `passing-window`, `anticipation-throw`, `back-shoulder-throw`, `yards-after-catch`, `interception` | `unity-sim` `football.passing.window.v1` | Rubric: physics (ball flight time) and timing in a scene (window opens and closes). `timing-tap` (1D) and `estimate-slider` cannot express lead against a moving defender. Spec: `sims/football.passing.window.v1.md` | A | 1 lesson (+ review), 12 scenarios |
| N1. Knowledge checks and review cards | many | `multiple-choice` | Recall of one fact with explanations; nothing spatial | B | 260 |
| N2. Rulings on a diagram (offside, catch, fair catch) | `offside`, `catch-rule`, `fair-catch`, `first-down-marker` | `binary-call` | Two-way call on a static diagram; a Unity scene adds nothing (rubric: two-way call) | B | 90 |
| N3. Positions, coverages, flags | positions, coverages, flags | `term-match` | Introduces 3-6 related terms at once | B | 45 |
| N4. Processes (pass play, after a touchdown, playoffs) | `drive`, `playoff-seeding`, `two-minute-drill` | `sequence-order` | A true order exists; no spatial | B | 30 |
| N5. Formations, fronts, signals | `formation`, `four-three-front`, `three-four-front`, `shotgun` | `visual-id` | Recognition on original diagrams; no licensed imagery needed | B | 55 |
| N6. Judgment calls (4th down, clocks, challenges, cap moves) | `fourth-down-decision`, `clock-management`, `replay-review`, `salary-cap` | `decision-scenario` | Static facts, best/acceptable/poor; not a dynamic scene | B | 60 |
| N7. Conversation practice | `follow-up-question`, `listen-first`, `honest-not-expert` + topic | `talk-track` | Chat; never Unity | B | 60 (10 at launch) |
| N8. Clock feel (play clock, field goal operation, spike) | `play-clock`, `field-goal`, `two-minute-drill` | `timing-tap` | 1D timing bar suffices. Timing that depends on the 3D scene is Unity (U5) | B | 12 |
| N9. Decode fan talk | many | `say-this` | Language interpretation; never Unity | B | 150 |
| N10. Vocabulary in context | many | `fill-the-gap` | Sentence completion | B | 90 |
| N11. Referee announcements | `offside`, `holding`, `pass-interference` | `listening-id` | Only with original narration (license); skip control provided | B | 24 |
| N12. Numbers (clock lengths, kick distance, field size) | `overtime`, `field-goal-range`, `game-clock` | `estimate-slider` | Magnitude intuition; no scene | B | 40 |
| N13. Diagram positions (line of scrimmage, nose tackle, A gap) | `line-of-scrimmage`, `three-four-front`, `run-gap` | `hotspot-tap` | Static positions; anything that moves is Unity | B | 75 |

Native accessibility fallbacks for Unity lessons are separate designed lessons, not ports: `coverage-04-fallback`, `route-lab-05-fallback`, `protection-04-fallback`, `run-gaps-05-fallback`, `throw-window-06-fallback` (hotspot-tap plus decision-scenario over still frames).

## 13. Licensing & safety
| Area | Handling |
|---|---|
| Imagery | All diagrams and illustrations are original Swoon'd (`original-swoond`) or procedurally rendered. No NFL/NCAA/team logos, wordmarks, uniforms, trophies (Lombardi Trophy design), stadium photos, or player photos. Team names as plain text only. |
| Logos and trademarks | "NFL", "Super Bowl" and team names appear as text for factual reference only; never as a logo. Avoid implying endorsement. Trademark review before store copy. |
| Video | No game footage, no highlights, no broadcast clips. |
| Audio | Referee announcements and crowd sounds are original recordings by Swoon'd (`original-swoond`); no NFL Films, broadcast or stadium audio; no music. |
| Article text | Never copied. Explainers are ours; link to the publisher. |
| Data provider terms | Follow each provider's licence; store only what terms allow; attribute where required; official NFL data is licensed (avoid unofficial endpoints; no ESPN unofficial API). |
| Player likeness | No headshots or likeness. Player names appear as text facts only. Personalization by player uses the name text and stats, no images. |
| Lyrics / music | None used. |
| Wagering | No betting, odds, fantasy-for-money or prop content. |
| Safety | No real-world risk. Injuries and concussions are discussed respectfully; the course never encourages imitating hits or tackles; sims show tackles as a whistle and freeze; no gore. Age-appropriate. |

## 14. Content assets
| Asset | Procedural or licensed | Source |
|---|---|---|
| Field, formations, fronts, route diagrams (`football-*` diagram ids) | Procedural, drawn natively | Own |
| Referee signal illustrations | Drawn by Swoon'd | Own (`original-swoond`) |
| Referee announcement audio | Original recordings | Own (`original-swoond`) |
| Sim assets (fields, capsule characters, ball) | Procedural in Unity | Own (see each sim spec) |
| Team names/colors for personalization | Text and color hex only | Public facts; no logos |
| Fonts | Instrument Serif and Geist (OFL) | Bundled |

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. What does a beginner need to understand? Sections 2 and 3: goal and field, downs, clock, scoring, positions, offense, defense, penalties.
- [x] 2. What do enthusiasts care about? Section 4: schemes, coverages, run fits, fourth downs, cap, injuries, debates.
- [x] 3. What current information matters? Section 6 and `live-data.md`: scores, schedule, standings, injury report, rankings, editorial context.
- [x] 4. What should be interactive? Section 5 and 12: five Unity sims plus 13 native types.
- [x] 5. What should NOT be gamified? Section 5: injuries, tragedies, wagering, violence as spectacle, a fan's loss.
- [x] 6. How should it personalize? Section 8: team, player, league; defaults defined.
- [x] 7. What does conversational competence look like? Section 9 and 10: decoding, asking a follow-up, honesty over bluffing.
- [x] 8. What data providers are needed? Section 6 and `live-data.md`.
- [x] 9. What licensing constraints apply? Section 13.
- [x] 10. How will Swoon'd measure useful understanding? Section 10: concept mastery >= 0.8, talk track smoothness >= 60, retention.

Additional gates: [x] manifest validates (see report); [ ] curriculum validates (not yet written); [x] every Unity sim has a spec draft (`sims/`); [x] every image/audio asset has a license id (`original-swoond`); [ ] voice review (product owner); [x] no copied publisher text.

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Provider choice for NFL/college structured data and its licence for a paid app (TheSportsDB coverage of NFL and NCAA; Sportradar/SportsDataIO cost). | Product | Yes for live layer |
| 2 | News/editorial provider (DECISIONS Q-3). | Product | Yes for live layer |
| 3 | Is `football.routes.build.v1` clearly better than native `visual-id` + `hotspot-tap`? Playtest before build; else downgrade. | Product / Astra | No |
| 4 | Do we add Canadian football or flag football as later branches? | Product | No |
| 5 | Need 17 units (template layer minima force more than the 8-14 typical); OK to ship in phases (release plan)? | Product | No |
| 6 | Legal review of using the term "Super Bowl" in store copy and lesson titles. | Product | No |
| 7 | New `PathEditor` Game Kit primitive (routes sim). | Astra | Yes for U2 |
| 8 | Season-rule refresh process: who re-verifies rule numbers each spring? | Content | No |
