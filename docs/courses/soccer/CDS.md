# Course Design Specification: Soccer (`soccer`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Facts about rules, formats and results are verified as of 2026-09-30 (see section 7 and `live-data.md`).

| Field | Value |
|---|---|
| Status | draft |
| Wave | 1 |
| Author / date | Swoon'd course design agent (Claude Sonnet) / 2026-09-30 |
| Manifest | `manifest.json` |

---

## 1. Identity
- **Course ID:** `soccer` (immutable)
- **Display name:** Soccer
- **Category / family:** Sports > Soccer (family: Sports)
- **Simulation prefix:** `soccer`. Six planned sims: `soccer.offside.line-read.v1`, `soccer.pressing.trigger-call.v1`, `soccer.shape.formation-read.v1`, `soccer.setpiece.corner-read.v1`, `soccer.attack.overload-find.v1`, `soccer.defending.line-height.v1`.
- **Naming note:** the course is called Soccer because the target audience is US-first; the content uses "football" naturally in fan quotes (a British fan says football, an American fan says soccer) and the Playbook lists both. Never correct a learner's term.
- **Related courses & boundary test (spec section 6):**

| Related interest | If someone learns soccer, are they conversationally competent about it? | Verdict | Consequence for course structure |
|---|---|---|---|
| American Football | No. Different rules, structure, vocabulary and strategy (downs, plays, special teams). The word 'football' is the only overlap. | sibling-independent | Separate course; do not reuse concept ids. Cross-link only "offside" (a common confusion) and "pressing vs blitz". |
| Basketball | Partially for spatial ideas (overloads, screens vs blocks, transition), not for rules or leagues. | adjacent | Separate course; share nothing but `overload`-style ideas in cross-links. |
| Hockey | Partially for shape and pressing ideas (forecheck vs press, power play vs man advantage). | adjacent | Separate course; cross-link concepts. |
| Futsal / beach soccer / pickup soccer | Yes for the basics (goal, offside variants aside). | shares foundation | Not separate courses; mention in `the-game` as a note only. |
| Fantasy football (FPL) and video game (EA FC) fandom | Partially: they use the same players but add scoring systems and game-specific vocabulary. | adjacent | Candidate future sibling courses; out of scope now. |
| Women's football | Yes for laws and tactics; leagues and culture differ. | shares foundation | Handled as the NWSL branch and lessons `history-06`, `nwsl-01`, `nwsl-02`; every core lesson uses mixed men's/women's examples. |

- **Branches:** each branch sets the personalization dimension `league`.

| Branch id | Name | What changes (rules, data, culture) |
|---|---|---|
| `premier-league` | Premier League | English top flight (20 clubs, 3 relegated). Data: fixtures, table, FA Cup, English pyramid. Culture: Boxing Day, cup magic, spending rules (PSR), Football Principles. |
| `la-liga` | La Liga | Spain's league; El Clasico; Spanish style. Data: table, Clasico. Culture: technical school, Atletico's counter-culture. |
| `mls` | MLS | US/Canada single-entity league, no relegation, salary cap, Designated Players, Supporters' Shield, playoffs. 2026 break for the World Cup; transition season early 2027; August-to-May from 2027-28. |
| `nwsl` | NWSL | US women's league; no relegation; Shield vs Championship; Gotham won 2025 as the lowest seed ever. |
| `champions-league` | Champions League | UEFA's 36-team league phase, playoffs and knockout rounds; not a domestic league, so treated as a competition branch. |
| `world-cup` | World Cup and national teams | Tournament football, the 48-team format, qualifying and international breaks; the 2026 tournament just finished. |

## 2. Beginner model
- **What does a complete beginner typically know?** Two teams, a ball, goalkeeper, goals, that you cannot use your hands. Many know Messi, Ronaldo, Mbappe and the World Cup exists. Some know the Ted Lasso version of the sport. US beginners often know the 2026 World Cup atmosphere but not what a league table or relegation is.
- **What terminology will initially confuse them?** Offside; "nil" and "clean sheet"; "the six / the eight / the ten"; "back four / back three"; "on aggregate"; "extra time" vs "stoppage time" (added time); "pitch" vs field; "kit"; "gaffer", "mister", "manager" vs coach; "the league" vs "the cup"; "loan"; "transfer window"; "promotion and relegation"; "derby"; "xG".
- **Common misconceptions:**
  - The clock stops when the ball goes out (it does not; the referee adds stoppage time at the end).
  - Stoppage time is exactly what the board says (it is a minimum and can be extended).
  - Offside is about standing in front of the last defender (it is measured at the moment of the pass, the ball and second-last opponent count, arms do not, level is onside, and being in an offside position is not an offence unless involved).
  - Away goals still count double in European ties (scrapped in 2021).
  - A 0-0 draw is boring (fans read who created what: xG, pressing, set pieces).
  - Handball is any contact with the arm (it is about deliberate action or making the body unnaturally bigger).
  - A goalkeeper can pick up any pass (the back-pass rule applies to deliberate kicks from teammates).
  - Extra time is 30 minutes of "golden goal" (no golden goal; two 15-minute halves).
  - VAR can review anything (only four categories, only clear and obvious errors, with 2026/27 additions).
  - All soccer leagues have relegation (MLS and NWSL do not).
- **Concepts that unlock the rest of the subject** (become foundation units): the shape of the match and restarts (`the-game`), the laws and officials (`laws-and-officials`), positions and roles (`positions-and-roles`), and the league/cup ecosystem (`competitions-and-clubs`).

## 3. Foundational knowledge
Modules (these become `foundationalModules[]` and foundation units):

| Module (unit id) | Content |
|---|---|
| `the-game` | Match length, stoppage time, goals, restarts (throw-in, goal kick, corner, free kick, penalty), scoring milestones, points and tables, knockouts (extra time, shootouts, two-legged ties), squads and substitutions. |
| `laws-and-officials` | Fouls, yellow/red cards, advantage, DOGSO, handball, simulation and dissent, the officials, back-pass and eight-second rules, the 2026/27 five-second restart countdown and one-minute injury rule. |
| `positions-and-roles` | Goalkeeper, centre-backs, full-backs, wing-backs, the 6/8/10/9, wingers, false nine, box-to-box, playmaker, sweeper-keeper, shirt numbers. |
| `competitions-and-clubs` | League tables, promotion/relegation, cups, European competitions, transfers/loans/contracts, academies, manager vs sporting director, spending rules, derbies, supporter culture. |

- **Rules:** the IFAB Laws of the Game are maintained annually; the 2026/27 edition took effect on 1 July 2026 (with some measures at the World Cup). Rules content is written against those Laws and reviewed each July.
- **Equipment:** minimal: ball, kits, shin pads, goals, corner flags; goal-line technology and body cameras exist but are not learned as equipment.
- **Techniques:** passing, dribbling, shooting, heading, tackling, goalkeeping; learned as vocabulary (nutmeg, rabona, cutback), not coaching.
- **History/culture:** treated in enthusiast depth.

## 4. Enthusiast model
- **What do actual enthusiasts talk about?** Last night's result and the decisive moment; the manager's substitutions; the referee and VAR; injuries and squad rotation; transfers and rumours; the title race, the top four/Europe race and the relegation scrap; a player's form; tactical fights (high line vs low block); xG; and their club's history and rivalries.
- **Distinctions that matter to them:** press vs low block; possession vs control; clinical vs wasteful; zonal vs man marking; an inverted full-back vs a wing-back; a number 9, a false 9 and a 10; a sweeper-keeper vs an old-school keeper; a derby vs a rivalry.
- **Knowledge that signals genuine understanding:** reading offside as a moment of the pass; knowing the difference between a foul that is a yellow and DOGSO; knowing a team's shape in and out of possession; using xG as a supporting fact, not a weapon; naming the actual trigger for a goal; distinguishing the set-piece routine from luck.
- **Beginner statements that sound obviously uninformed:** "Why did the clock stop?"; "He was offside because he was standing in front of the goalie"; "He should have used his hands"; "That's a corner, so it's a free goal"; "Away goals count double"; calling a shootout a "sudden death" (it becomes that only after five each); "Just kick it in the net"; asking who won when the score is in the message.
- **Controversies and debates** (all written neutrally; the goal is to understand both sides, never to arm a learner with a hot take):
  - VAR: does it kill the spontaneity? The thick-line offside images and the toenail goal; SAOT speeds things up but stays contentious; the "clear and obvious" threshold; new 2026/27 reviews.
  - Daylight offside and other proposed changes.
  - Handball: natural position vs unnatural; penalties for "accidental" handball.
  - Time-wasting: the eight-second keeper rule (2025/26) and the five-second restart countdown (2026/27); the "ball in play" time debate.
  - Style vs results: possession/positional play vs pragmatic low block vs direct play; the "winning ugly" ethos.
  - Analytics vs the eye test: xG, PPDA, progressive carries; the over-reliance risk.
  - GOAT debate: Pele/Maradona/Messi/Ronaldo; how to weigh World Cups vs club trophies; the 2022 and 2026 finals.
  - Money: spending rules (PSR), state-owned clubs, the Super League saga, the Bosman era, wage inflation.
  - 48-team World Cup: dilution vs inclusion; the round of 32; the best third-placed teams.
  - MLS structure: single-entity, the salary cap and Designated Players, no relegation, the calendar shift to August-May from 2027-28 (a transition season in early 2027).
  - Women's football growth and investment; the 50-year FA ban; NWSL parity (Gotham 2025).
  - Fixture congestion and player welfare (international breaks, extra club competitions).

## 5. Interaction model
- **What should the learner EXPERIENCE instead of reading?** Watching a pass frame freeze and deciding who is offside; seeing a press jump on a back pass; watching a team change shape with and without the ball; deciding where a corner should go against a zonal or man-marked defence; finding the free man; setting a defensive line as pressure changes. These are the spatial, moving skills the sport is really about.
- **Does the course warrant Unity?** Yes for six specific skills (spatial + movement + camera perspective). Everything else is better as native exercises: rules, terms, competition structures, numbers and conversation.
- **Would visual identification, decision scenarios, sequencing or listening help?** Decision scenarios (referee calls, manager calls, transfer news), sequencing (knockout tiebreak, competition path, build-up), hotspot-tap (pitch markings, half-spaces, positions on a static diagram), estimate-slider (numbers like xG). Visual-id and listening-id are not used (kit/logos and commentary audio are licensing-sensitive, and nothing in the course needs recognising a photo or sound; an original-illustration referee-signal visual-id set is an optional later addition).
- **What should NOT be gamified?** Injuries, discrimination and abuse at matches; hooliganism (explain, never glamorize); real tragedies in stadiums; betting and gambling (no odds, no fantasy-gambling mechanics); score predictions as a wager; the emotional weight of a loss (talk tracks treat it with empathy, not jokes); a player's private life; and "trash-talk" scoring that rewards being mean.
- **Chosen mix:** 6 Unity sims plus 11 native types. Detailed rationale in section 12.

## 6. Dynamic information requirements
Detail in `live-data.md`. Summary (do not invent live needs: every item below is needed for a live-fan conversation):

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| Scores | Yes | "Who won?" is the first line of most fan texts | TheSportsDB (initial), football-data.org, API-Football; Sportradar/SportsDataIO (upgrade path) | Minutes during matches | Last cached result with an "as of" stamp |
| Schedules | Yes | "When do we play?" | Same providers | Daily | Cached fixtures |
| Standings | Yes | Title, Europe and relegation races | Same providers | Daily, plus after each matchday | Cached table |
| Statistics | Yes (light) | Goals, assists, xG headline numbers for the current-season layer | TheSportsDB (basic); evaluate a stats provider for xG (licence review) | Daily | Authored evergreen numbers |
| Rosters | Yes (light) | Who plays for whom | TheSportsDB | Weekly and around windows | Cached rosters |
| Rankings | Yes (light) | FIFA rankings for internationals | FIFA site as link-only; provider TBD | Monthly | Link-only |
| Events (tournament brackets) | Yes | World Cup, Champions League, cup knockout paths | Same providers | Daily; minutes on match days | Static bracket explanation |
| News | Yes | Why fans are talking about something today | Licensed news API (TBD, DECISIONS Q-3) | Hourly | Editorial explainers with no headline feed |
| Alerts (injury/suspension) | Nice to have | Explains team news | Provider news tags or manual editorial | Hourly on match days | Omit |

Adapters normalize into Swoon'd types; no provider schema leaks into the domain model (D-004, spec section 32). No sub-second or betting-grade data (spec section 33). Structured data and editorial are separate systems.

## 7. Editorial context
- **What commentary helps?** Why a team is winning or struggling (a tactical change, an injury, a fixture pile-up), why a referee decision is controversial, why a transfer matters, why a manager is under pressure, why a rule change is being discussed, and why this weekend's fixture is more than three points.
- **Appropriate external sources:** official league and federation sites (for links: Premier League, UEFA, FIFA, IFAB, MLS, NWSL), club sites, reputable publisher headlines (links only), and Swoon'd's own explainers.
- **Summarize, explain, or link?** Explain in our own words and link (the manifest approach is `explain-and-link`). Never copy publisher text; never reproduce match reports or quotes.
- **Rule-verification sources for this CDS (searched 2026-09-30):** IFAB 2026/27 law-change announcements (five-second restart countdown, ten-second substitution exit, one-minute off-field rule after injury treatment, VAR reviews of clearly incorrect second yellows, mistaken identity and corners, body cameras optional; no offside change approved), the UEFA 2026/27 Champions League format (36 teams, eight league-phase matches each, top eight straight to the last 16, 9-24 to a knockout playoff), the MLS 2026 schedule (World Cup break May 25 to July 16) and the announced 2027-28 calendar, and results of the 2026 World Cup (Spain 1-0 Argentina after extra time; Ferran Torres in the 106th minute), the 2025-26 Premier League (Arsenal champions, 85 points), and the 2026 Champions League final (PSG beat Arsenal on penalties after 1-1).
- **Example prompts:** "Why are fans talking about this today?" "Why does a red card change the whole match?" "Why did VAR overturn that goal?" "Why does her team keep dropping points from set pieces?" "What does 'here we go' mean?" "Why is there a fuss about the international break?"

## 8. Personalization
Default values are used when a dimension is unset so lessons never render an empty token.

| Dimension | How it changes examples and live context | Default when unset | Units using `{{tokens}}` |
|---|---|---|---|
| `team` | Examples use the club's colours-neutral history, current form, rivals and key players; the live layer prioritises this team's results, table position, injuries and next fixture. | "her club" (neutral wording) | `the-live-season`, `conversation-lab`, all branch units, `perpetual-review` |
| `player` | Player-centred examples (role, form, transfer news), and "why is he in the news" explainers. | "her favourite player" | `the-live-season`, `conversation-lab`, branch units |
| `league` | Chooses the branch (`premier-league`, `la-liga`, `mls`, `nwsl`, `champions-league`, `world-cup`) and the competition-specific examples and data. | `premier-league` for wording; the live layer requires an explicit choice | branch units, `the-live-season`, `perpetual-review` |

Personalization changes examples, never the truth of the foundation. A learner with an MLS favourite still learns offside identically.

## 9. Conversation model
- **What might an enthusiast naturally say?** 14 example lines with translation:

| # | Enthusiast line | What it means | Terminology implied |
|---|---|---|---|
| 1 | "They parked the bus and nicked one on the break." | The opponent defended deep and scored on a fast counterattack. | low block, counterattack |
| 2 | "Our back three got pulled apart down the channels all night." | The three centre-backs were stretched wide, leaving gaps. | back three, channels, compactness |
| 3 | "We lost 1-0 but the xG was 2.3 to 0.4. Robbed." | Her team created better chances but did not score. | xG, clinical vs wasteful |
| 4 | "Honestly the set-piece coach is our MVP." | Her team scores from corners and free kicks. | corner routine, near/far post |
| 5 | "Offside by a toenail! Literally a toenail." | A disallowed goal decided by a tiny margin on the offside line. | offside position, VAR, SAOT |
| 6 | "He's a proper six, he just sits and sweeps." | A defensive midfielder who screens the back four. | the 6, defensive midfielder |
| 7 | "Our full-backs invert and it's a 3-2-5 with the ball." | The full-backs move inside to form a build-up shape. | inverted full-back, box midfield |
| 8 | "Ninety-eighth minute. NINETY-EIGHTH." | A late goal or heartbreak deep into stoppage time. | stoppage time |
| 9 | "It's the run-in and we've got two games in hand." | The end of the season with unplayed matches. | run-in, matches in hand |
| 10 | "Romano tweeted here we go, it's done." | A transfer is confirmed. | here we go, transfer window |
| 11 | "The press was unreal, six seconds after winning it we scored." | A high press won the ball close to goal. | high press, counter-press |
| 12 | "That VAR check took four minutes for nothing." | A long review with no change. | VAR check vs review |
| 13 | "Six goals, Mbappe... the Golden Boot again." | A tournament scoring award. | Golden Boot, World Cup |
| 14 | "The draw's a decent result away from home." | A point on the road is fine. | three points, away form |

- **What does each statement mean and what terminology is implied?** See the table; the Playbook entries carry the plain-English definitions.
- **What could the learner meaningfully ask next?** Follow-ups that show curiosity, not expertise: "Was that a planned routine?", "Who missed the big chance?", "Do your wing-backs get back in time?", "Which game do you rewatch?", "What's your favourite moment this season?". Each say-this item lists 1-3 follow-ups with a "why it works" caption.
- **How does Swoon'd help without encouraging fake expertise?** Every say-this and talk-track item ends with a "no fake expert" note. Good replies ask a real question or name a real thing that happened; cringe replies bluff, gloat or dismiss. Smooth scoring rewards curiosity, empathy and accuracy over jargon. We never provide "lines to sound smart".
- **Target numbers:** 24 talk tracks (8 authored now in `exercises.md`; the rest before launch) and 60+ say-this items across the course (about 4 per unit at launch), plus a conversation-lab unit of 8 lessons.

## 10. Assessment
- **How is useful competence determined?** Concept-level mastery (0-1), updated by exercise results and sim signals, with spaced review confirming retention. A learner is competent when they can decode an enthusiast's line, follow a match on a screen, and ask a follow-up question.
- **Recognize:** the restarts, a foul vs advantage, a yellow vs a red, common shapes, a pressing trigger, an offside position at the moment of a pass.
- **Understand:** why the clock does not stop, why level is onside, why a low block invites pressure, why possession is not control.
- **Explain:** the league table, extra time and penalties, the Champions League league phase, and the 48-team World Cup format.
- **Correctly interpret:** a referee decision and a VAR review; an xG number; a fan's tactical complaint.
- **Mastery model:** `concept-mastery-v1`; pass threshold 0.8.
- **Useful competence statement:** "Can follow a match with a fan, decode common fan talk and referee calls, and ask a genuine follow-up question about their team."

## 11. Curriculum map (ongoing course)
Designed as an ONGOING course. **20 units, 115 lessons, 172 Playbook concepts.** A learner sees the 11 core units (foundations, intermediate, enthusiast: 4+4+3) plus the branch unit(s) matching their `league`, plus the live, conversation and review units, so about 15-16 units are visible to any one learner even though six branch units exist.

| Layer | Purpose | Units | Lessons |
|---|---|---|---|
| foundations | Terms, rules, how it works | 4 | 30 |
| intermediate | Strategy, distinctions, context | 4 | 31 |
| enthusiast | Debates, nuance, history/culture, branches (six league/competition units) | 9 | 36 |
| current-season | Ongoing, refreshed from live data and editorial | 1 | 6 |
| conversation | Talk tracks, say-this, 'what is she talking about?' | 1 | 8 |
| review | Spaced review | 1 | 4 |

### Foundations (4 units)

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `the-game` | The game in ninety minutes | none | 8: Two halves, no stopping; What counts as a goal; Getting the ball back into play; Free kicks and penalties; Points, tables and drama; Knockouts, extra time and shootouts; Eleven, the bench and the armband; Scoring milestones fans cheer | `match-length`, `stoppage-time`, `goal`, `out-of-play`, `throw-in`, `goal-kick` ... |
| `laws-and-officials` | Rules, cards and the referee | `the-game` | 8: What is a foul; Yellow, red and second yellow; Advantage and tactical fouls; Last man: DOGSO; Handball, the eternal argument; Diving and dissent; The officials and the keeper's rules; Time-wasting crackdown | `foul`, `direct-indirect-free-kick`, `yellow-card`, `red-card`, `advantage`, `professional-foul` ... |
| `positions-and-roles` | Who does what | `the-game` | 7: Keeper and centre-backs; Full-backs and wing-backs; The midfield engine; Wingers and strikers; Modern role labels; The sweeper-keeper; Numbers on the shirt | `goalkeeper`, `centre-back`, `full-back`, `wing-back`, `defensive-midfielder`, `central-midfielder` ... |
| `competitions-and-clubs` | Leagues, cups and clubs | `the-game` | 7: One league, one table; Going up and going down; Domestic cups; Europe and qualification; Transfers, loans and contracts; Academy and the club machine; Derbies and matchday culture | `league-table`, `three-points`, `promotion-relegation`, `domestic-cup`, `continental-competitions`, `transfer-window` ... |

#### `the-game`: The game in ninety minutes

What actually happens in a match, how scoring works and how play restarts.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `game-01` | Two halves, no stopping | You can explain how long a match is and why the clock does not stop. | `match-length`, `stoppage-time` | multiple-choice, estimate-slider |
| `game-02` | What counts as a goal | You can tell a goal from a near miss by the whole-ball-over-the-line rule. | `goal`, `out-of-play` | binary-call, multiple-choice |
| `game-03` | Getting the ball back into play | You can say who restarts play after the ball goes out. | `out-of-play`, `throw-in`, `goal-kick`, `corner-kick` | term-match, hotspot-tap, multiple-choice |
| `game-04` | Free kicks and penalties | You can explain direct vs indirect free kicks and when a penalty is given. | `direct-indirect-free-kick`, `penalty-kick`, `pitch-markings` | hotspot-tap, binary-call, multiple-choice |
| `game-05` | Points, tables and drama | You can read a league table and explain what a win, draw and goal difference do. | `three-points`, `goal-difference`, `clean-sheet` | fill-the-gap, multiple-choice, say-this |
| `game-06` | Knockouts, extra time and shootouts | You can follow a knockout tie, including two-legged ties and shootouts. | `extra-time-shootout`, `aggregate-tie`, `shootout-format` | sequence-order, multiple-choice, say-this |
| `game-07` | Eleven, the bench and the armband | You can explain who plays, how substitutions work and what a captain does. | `squad-substitutes`, `captain-armband` | multiple-choice, fill-the-gap |
| `game-08` | Scoring milestones fans cheer | You can use hat-trick and brace correctly and know the fan talk around them. | `hat-trick`, `clean-sheet` | term-match, say-this |

#### `laws-and-officials`: Rules, cards and the referee

Fouls, cards, handball and what the referee team does.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `laws-01` | What is a foul | You can explain what makes contact a foul and what the restart is. | `foul`, `direct-indirect-free-kick` | binary-call, multiple-choice |
| `laws-02` | Yellow, red and second yellow | You can explain the difference between a caution and a sending-off. | `yellow-card`, `red-card` | term-match, multiple-choice, say-this |
| `laws-03` | Advantage and tactical fouls | You can explain why the referee sometimes lets play run and why fans respect a smart foul. | `advantage`, `professional-foul` | binary-call, multiple-choice, say-this |
| `laws-04` | Last man: DOGSO | You can explain when a foul is a red card because it denied a goal chance. | `dogso`, `red-card` | decision-scenario, multiple-choice |
| `laws-05` | Handball, the eternal argument | You can explain why some handballs are penalties and some are not. | `handball` | binary-call, multiple-choice, say-this |
| `laws-06` | Diving and dissent | You can explain why simulation and dissent get cautions. | `simulation`, `dissent` | multiple-choice, say-this |
| `laws-07` | The officials and the keeper's rules | You can name the officials and explain the back-pass and eight-second rules. | `referee-crew`, `backpass-rule`, `goalkeeper-eight-seconds`, `wall-distance` | term-match, timing-tap, multiple-choice |
| `laws-08` | Time-wasting crackdown | You can explain the new restart countdown and injury rules. | `time-wasting-countdown`, `injury-stoppage-rule` | multiple-choice, decision-scenario |

#### `positions-and-roles`: Who does what

Positions, roles and shirt numbers.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `roles-01` | Keeper and centre-backs | You can explain what a goalkeeper and centre-back do. | `goalkeeper`, `centre-back` | term-match, hotspot-tap |
| `roles-02` | Full-backs and wing-backs | You can explain the difference between a full-back and a wing-back. | `full-back`, `wing-back` | multiple-choice, hotspot-tap |
| `roles-03` | The midfield engine | You can explain the 6, 8 and 10. | `defensive-midfielder`, `central-midfielder`, `attacking-midfielder` | term-match, hotspot-tap, multiple-choice |
| `roles-04` | Wingers and strikers | You can explain how a winger and striker create goals. | `winger`, `striker`, `poacher` | term-match, multiple-choice |
| `roles-05` | Modern role labels | You can decode box-to-box, playmaker and false nine. | `box-to-box`, `playmaker`, `false-nine` | term-match, say-this |
| `roles-06` | The sweeper-keeper | You can explain why modern keepers play like outfield players. | `sweeper-keeper`, `goalkeeper` | multiple-choice, say-this |
| `roles-07` | Numbers on the shirt | You can guess a player's role from a shirt number. | `shirt-numbers`, `striker`, `attacking-midfielder` | multiple-choice, fill-the-gap |

#### `competitions-and-clubs`: Leagues, cups and clubs

How seasons, promotion, cups, transfers and club culture fit together.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `comps-01` | One league, one table | You can explain how the league table decides the champion. | `league-table`, `three-points` | multiple-choice, fill-the-gap |
| `comps-02` | Going up and going down | You can explain promotion and relegation. | `promotion-relegation` | multiple-choice, say-this |
| `comps-03` | Domestic cups | You can explain why the cup produces upsets. | `domestic-cup` | multiple-choice, say-this |
| `comps-04` | Europe and qualification | You can explain how a club qualifies for the Champions League. | `continental-competitions` | multiple-choice, term-match |
| `comps-05` | Transfers, loans and contracts | You can explain a loan, a fee and a free transfer. | `transfer-window`, `loan-and-fee`, `contract-expiry` | term-match, decision-scenario |
| `comps-06` | Academy and the club machine | You can explain the roles of manager, academy and sporting director. | `academy-youth`, `manager-sporting-director` | multiple-choice, say-this |
| `comps-07` | Derbies and matchday culture | You can explain why derbies, supporter culture and spending rules matter. | `derby`, `supporters-groups`, `financial-rules` | multiple-choice, say-this, talk-track |

### Intermediate (4 units)

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `offside-and-var` | Offside and VAR | `laws-and-officials` | 8: The offside position; Position is not an offence; Level is onside; Read the line (sim); Deliberate play or deflection; How VAR works; Line, active play and VAR (sim); The trap and the debates | `offside-position`, `offside-offence`, `active-play`, `level-is-onside`, `offside-body-parts`, `deliberate-play` ... |
| `formations-and-shape` | Formations and shape | `positions-and-roles` | 8: Reading 4-3-3; 4-2-3-1 and 4-4-2; Back threes and wing-backs; Name that shape (sim); With the ball, without it; Compact lines and space; Half-spaces and between the lines (sim); Triangles and switches | `formation-numbers`, `four-three-three`, `back-four`, `four-two-three-one`, `four-four-two`, `back-three` ... |
| `attack-and-defence` | Attack, press and defend | `formations-and-shape` | 9: Building from the back; Progressive passes and through balls; Find the overload (sim); Crosses, cutbacks and overlaps; Pressing triggers (sim); High press, mid-block, low block; Line height (sim); Counter-press and counterattack; Zonal, man and tempo | `build-up`, `play-out-from-back`, `progressive-pass`, `through-ball`, `overload`, `passing-lanes` ... |
| `set-pieces` | Set pieces | `laws-and-officials` | 6: Corner kick basics; Inswing or outswing; Read the corner (sim); Free-kick craft; Penalties; Short corners, blocks and second balls (sim) | `corner-routine`, `near-far-post`, `inswinger-outswinger`, `zonal-man-marking`, `set-piece-marking`, `free-kick-technique` ... |

#### `offside-and-var`: Offside and VAR

The rule that confuses everyone, explained with a sim and real cases.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `offside-01` | The offside position | You can spot an offside position at the moment of the pass. | `offside-position` | hotspot-tap, binary-call |
| `offside-02` | Position is not an offence | You can explain why standing offside is not always an offence. | `offside-offence`, `active-play` | binary-call, multiple-choice |
| `offside-03` | Level is onside | You can call level as onside and know which body parts count. | `level-is-onside`, `offside-body-parts` | binary-call, multiple-choice |
| `offside-04` | Read the line (sim) | You can read the offside line at the moment of the pass under time pressure. | `offside-position`, `level-is-onside`, `offside-body-parts` | `soccer.offside.line-read.v1` |
| `offside-05` | Deliberate play or deflection | You can explain why a defender's deliberate touch resets offside and a deflection does not. | `deliberate-play`, `no-offside-restarts` | binary-call, multiple-choice |
| `offside-06` | How VAR works | You can explain what VAR can and cannot review. | `var-basics`, `check-vs-review` | multiple-choice, term-match, say-this |
| `offside-07` | Line, active play and VAR (sim) | You can read the line and active play as in a VAR review. | `active-play`, `deliberate-play`, `saot` | `soccer.offside.line-read.v1` |
| `offside-08` | The trap and the debates | You can explain the offside trap and the arguments about the rule. | `offside-trap`, `offside-debates`, `var-new-reviews`, `saot` | multiple-choice, say-this, talk-track |

#### `formations-and-shape`: Formations and shape

Reading formation numbers and how teams actually shape up.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `shape-01` | Reading 4-3-3 | You can read a formation from its numbers. | `formation-numbers`, `four-three-three`, `back-four` | hotspot-tap, multiple-choice |
| `shape-02` | 4-2-3-1 and 4-4-2 | You can explain the difference between 4-2-3-1 and 4-4-2. | `four-two-three-one`, `four-four-two` | term-match, multiple-choice |
| `shape-03` | Back threes and wing-backs | You can explain why some teams play with three centre-backs. | `back-three`, `wing-back` | hotspot-tap, multiple-choice |
| `shape-04` | Name that shape (sim) | You can read a team's shape from its movement. | `formation-numbers`, `in-out-possession-shape`, `compactness` | `soccer.shape.formation-read.v1` |
| `shape-05` | With the ball, without it | You can explain how shape changes in and out of possession. | `in-out-possession-shape` | multiple-choice, say-this |
| `shape-06` | Compact lines and space | You can explain compactness, width and depth. | `compactness`, `width-depth` | multiple-choice, fill-the-gap |
| `shape-07` | Half-spaces and between the lines (sim) | You can find the half-space and the pocket between lines. | `half-spaces`, `between-the-lines`, `passing-lanes` | `soccer.shape.formation-read.v1` |
| `shape-08` | Triangles and switches | You can explain triangles, overloads and a switch of play. | `triangles`, `overload`, `switch-of-play` | multiple-choice, term-match, say-this |

#### `attack-and-defence`: Attack, press and defend

How teams build attacks, press, drop back and counter.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `attack-01` | Building from the back | You can explain build-up and playing out from the back. | `build-up`, `play-out-from-back` | multiple-choice, say-this |
| `attack-02` | Progressive passes and through balls | You can tell progressive passes and through balls apart. | `progressive-pass`, `through-ball` | term-match, multiple-choice |
| `attack-03` | Find the overload (sim) | You can find the free man by spotting the overload. | `overload`, `passing-lanes`, `third-man-run`, `switch-of-play` | `soccer.attack.overload-find.v1` |
| `attack-04` | Crosses, cutbacks and overlaps | You can explain crosses, cutbacks, overlaps and underlaps. | `cross-cutback`, `overlap-underlap`, `third-man-run` | term-match, multiple-choice, say-this |
| `attack-05` | Pressing triggers (sim) | You can recognise a pressing trigger and call the press. | `pressing`, `pressing-trigger`, `high-press` | `soccer.pressing.trigger-call.v1` |
| `attack-06` | High press, mid-block, low block | You can tell the three defensive blocks apart. | `high-press`, `mid-block`, `low-block` | term-match, multiple-choice, say-this |
| `attack-07` | Line height (sim) | You can explain how a high line squeezes space and risks the ball over the top. | `high-line`, `offside-trap`, `compactness` | `soccer.defending.line-height.v1` |
| `attack-08` | Counter-press and counterattack | You can explain the five seconds after losing the ball. | `counter-press`, `counterattack`, `rest-defence` | multiple-choice, decision-scenario, say-this |
| `attack-09` | Zonal, man and tempo | You can explain zonal vs man marking and tempo. | `zonal-man-marking`, `tempo-control`, `pressing-traps` | term-match, multiple-choice, say-this |

#### `set-pieces`: Set pieces

Corners, free kicks, penalties and throws.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `setpiece-01` | Corner kick basics | You can explain how a corner is taken and defended. | `corner-routine`, `near-far-post` | multiple-choice, hotspot-tap |
| `setpiece-02` | Inswing or outswing | You can explain inswingers and outswingers. | `inswinger-outswinger`, `near-far-post` | term-match, binary-call, say-this |
| `setpiece-03` | Read the corner (sim) | You can read a corner routine and predict the target. | `corner-routine`, `zonal-man-marking`, `set-piece-marking`, `near-far-post` | `soccer.setpiece.corner-read.v1` |
| `setpiece-04` | Free-kick craft | You can explain free-kick technique. | `free-kick-technique`, `wall-distance` | multiple-choice, hotspot-tap, say-this |
| `setpiece-05` | Penalties | You can explain penalty strategy and the shootout. | `penalty-strategy`, `shootout-format` | multiple-choice, decision-scenario, say-this |
| `setpiece-06` | Short corners, blocks and second balls (sim) | You can spot the short-corner trick and the second ball. | `short-corner`, `screening-blocking`, `second-ball`, `long-throw` | `soccer.setpiece.corner-read.v1` |

### Enthusiast depth (3 units) and branches (6 units)

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `tactical-schools` | Tactical schools and debates | `attack-and-defence` | 7: Total football; Tiki-taka and positional play; Catenaccio; Gegenpressing; Inverted full-backs; Direct football; Style vs results | `total-football`, `positional-play`, `tiki-taka`, `triangles`, `catenaccio`, `low-block` ... |
| `numbers-and-data` | Numbers and analytics | `attack-and-defence` | 6: Expected goals (xG); Assists, chance creation and xA; PPDA and pressing numbers; Possession is not control; Over- and underperforming; Eye test vs data | `xg`, `xa`, `progressive-pass`, `ppda`, `high-press`, `possession-stat` ... |
| `history-and-culture` | History, culture and debates | `the-game` | 7: World Cup history; The 2026 World Cup; Ballon d'Or and GOAT; Famous derbies; Bosman and the money era; Women's football; US soccer and the great seasons | `world-cup-history`, `world-cup-2026`, `wc-format-48`, `ballon-dor`, `goat-debate`, `derby-history` ... |
| `branch-premier-league` (branch `premier-league`) | Branch: Premier League | `competitions-and-clubs` | 3: The Premier League ladder; FA Cup and the pyramid; Spending rules and the 2026/27 laws | `pl-european-spots`, `league-table`, `promotion-relegation`, `fa-cup`, `domestic-cup`, `financial-rules` ... |
| `branch-la-liga` (branch `la-liga`) | Branch: La Liga | `competitions-and-clubs` | 2: The big two and the chasers; Spanish style | `la-liga-clasico`, `derby-history`, `positional-play`, `tiki-taka` |
| `branch-mls` (branch `mls`) | Branch: MLS | `competitions-and-clubs` | 3: How MLS is built; The salary cap and Designated Players; The calendar shift and supporters | `mls-structure`, `supporters-shield`, `financial-rules`, `mls-calendar-shift`, `supporters-groups` |
| `branch-nwsl` (branch `nwsl`) | Branch: NWSL | `competitions-and-clubs` | 2: How the NWSL works; Why the boom is recent | `nwsl-structure`, `supporters-shield`, `womens-football-history` |
| `branch-champions-league` (branch `champions-league`) | Branch: Champions League | `competitions-and-clubs` | 3: The league phase; Playoffs and two legs; Why Champions League nights feel different | `ucl-league-phase`, `continental-competitions`, `aggregate-tie`, `extra-time-shootout`, `derby-history` |
| `branch-world-cup` (branch `world-cup`) | Branch: World Cup and national teams | `the-game` | 3: The 48-team format; National teams vs clubs; Talking about 2026 | `wc-format-48`, `goal-difference`, `national-vs-club`, `world-cup-history`, `world-cup-2026`, `goat-debate` |

#### `tactical-schools`: Tactical schools and debates

The big styles fans argue about.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `schools-01` | Total football | You can explain the Dutch idea of fluid roles. | `total-football`, `positional-play` | multiple-choice, say-this |
| `schools-02` | Tiki-taka and positional play | You can explain tiki-taka and positional play. | `tiki-taka`, `positional-play`, `triangles` | multiple-choice, term-match, say-this |
| `schools-03` | Catenaccio | You can explain the Italian defensive tradition. | `catenaccio`, `low-block` | multiple-choice, say-this |
| `schools-04` | Gegenpressing | You can explain why the turnover is the playmaker. | `gegenpressing`, `counter-press` | multiple-choice, say-this |
| `schools-05` | Inverted full-backs | You can explain why full-backs move into midfield. | `inverted-fullback`, `box-midfield` | hotspot-tap, multiple-choice, say-this |
| `schools-06` | Direct football | You can defend and criticise direct football. | `direct-football`, `second-ball` | multiple-choice, say-this |
| `schools-07` | Style vs results | You can talk about the beauty-versus-results debate without taking a cheap side. | `pragmatism-vs-idealism`, `false-nine` | multiple-choice, say-this, talk-track |

#### `numbers-and-data`: Numbers and analytics

How modern fans use data without losing the eye test.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `numbers-01` | Expected goals (xG) | You can explain xG in plain English. | `xg` | multiple-choice, estimate-slider, say-this |
| `numbers-02` | Assists, chance creation and xA | You can explain xA. | `xa`, `progressive-pass` | multiple-choice, say-this |
| `numbers-03` | PPDA and pressing numbers | You can explain PPDA. | `ppda`, `high-press` | multiple-choice, estimate-slider |
| `numbers-04` | Possession is not control | You can explain why possession can mislead. | `possession-stat`, `tempo-control` | multiple-choice, say-this |
| `numbers-05` | Over- and underperforming | You can explain why finishing streaks fade. | `overperform-underperform`, `xg` | multiple-choice, decision-scenario |
| `numbers-06` | Eye test vs data | You can hold both views. | `eye-test-vs-data`, `form-and-ppg`, `progressive-carry`, `shots-on-target` | multiple-choice, say-this, talk-track |

#### `history-and-culture`: History, culture and debates

Big moments and arguments fans bring up.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `history-01` | World Cup history | You can name the eras of the World Cup. | `world-cup-history`, `world-cup-2026` | multiple-choice, term-match, say-this |
| `history-02` | The 2026 World Cup | You can talk about the 48-team World Cup and its final. | `world-cup-2026`, `wc-format-48` | multiple-choice, fill-the-gap, say-this |
| `history-03` | Ballon d'Or and GOAT | You can discuss the individual-awards argument. | `ballon-dor`, `goat-debate` | multiple-choice, say-this, talk-track |
| `history-04` | Famous derbies | You can explain the great derbies. | `derby-history`, `derby` | term-match, say-this |
| `history-05` | Bosman and the money era | You can explain how the Bosman ruling changed transfers. | `bosman-ruling`, `premier-league-birth`, `contract-expiry` | multiple-choice, say-this |
| `history-06` | Women's football | You can tell the story of women's football and why the boom is recent. | `womens-football-history` | multiple-choice, say-this, talk-track |
| `history-07` | US soccer and the great seasons | You can explain how soccer grew in the US and name benchmark seasons. | `us-soccer-history`, `invincibles-treble` | multiple-choice, say-this |

#### `branch-premier-league`: Branch: Premier League

England's top flight: ladder, cups, rules and the 2026/27 season. (personalization slots: `team`, `player`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `pl-01` | The Premier League ladder | You can explain how Premier League places decide Europe and relegation. | `pl-european-spots`, `league-table`, `promotion-relegation` | multiple-choice, fill-the-gap |
| `pl-02` | FA Cup and the pyramid | You can explain the FA Cup and the English pyramid. | `fa-cup`, `domestic-cup` | multiple-choice, say-this |
| `pl-03` | Spending rules and the 2026/27 laws | You can explain the spending rules and the new law changes fans are discussing. | `financial-rules`, `var-new-reviews`, `time-wasting-countdown` | multiple-choice, say-this, decision-scenario |

#### `branch-la-liga`: Branch: La Liga

Spain's league, the Clásico and Spanish style. (personalization slots: `team`, `player`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `ll-01` | The big two and the chasers | You can explain El Clásico and why Atlético is the usual third party. | `la-liga-clasico`, `derby-history` | multiple-choice, say-this |
| `ll-02` | Spanish style | You can explain how Spanish teams think about possession. | `positional-play`, `tiki-taka` | multiple-choice, say-this, talk-track |

#### `branch-mls`: Branch: MLS

MLS structure, supporters and the calendar shift. (personalization slots: `team`, `player`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `mls-01` | How MLS is built | You can explain MLS structure and why there is no relegation. | `mls-structure`, `supporters-shield` | multiple-choice, term-match |
| `mls-02` | The salary cap and Designated Players | You can explain how MLS balances stars and cap. | `mls-structure`, `financial-rules` | multiple-choice, decision-scenario |
| `mls-03` | The calendar shift and supporters | You can explain the 2027 calendar shift and supporter culture. | `mls-calendar-shift`, `supporters-groups` | multiple-choice, say-this |

#### `branch-nwsl`: Branch: NWSL

The US women's league and the wider women's game. (personalization slots: `team`, `player`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `nwsl-01` | How the NWSL works | You can explain NWSL structure, the Shield and the playoffs. | `nwsl-structure`, `supporters-shield` | multiple-choice, term-match |
| `nwsl-02` | Why the boom is recent | You can explain why the NWSL and women's football are booming now. | `womens-football-history`, `nwsl-structure` | multiple-choice, say-this |

#### `branch-champions-league`: Branch: Champions League

The league phase, playoffs and knockout nights. (personalization slots: `team`, `player`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `ucl-01` | The league phase | You can explain the 36-team league phase. | `ucl-league-phase`, `continental-competitions` | multiple-choice, fill-the-gap, estimate-slider |
| `ucl-02` | Playoffs and two legs | You can explain the playoff round and two-leg ties. | `ucl-league-phase`, `aggregate-tie`, `extra-time-shootout` | sequence-order, multiple-choice, say-this |
| `ucl-03` | Why Champions League nights feel different | You can talk about big European nights. | `continental-competitions`, `derby-history` | multiple-choice, say-this, talk-track |

#### `branch-world-cup`: Branch: World Cup and national teams

International football and the 2026 tournament. (personalization slots: `team`, `player`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `wc-01` | The 48-team format | You can explain groups, best third-placed teams and the round of 32. | `wc-format-48`, `goal-difference` | multiple-choice, fill-the-gap, estimate-slider |
| `wc-02` | National teams vs clubs | You can explain qualifiers, breaks and how national teams differ from clubs. | `national-vs-club`, `world-cup-history` | multiple-choice, say-this |
| `wc-03` | Talking about 2026 | You can talk about Spain, Argentina and the tournament highlights. | `world-cup-2026`, `goat-debate` | multiple-choice, say-this, talk-track |

### Current-season / live layer (1 unit, templates + `live` hook)

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `the-live-season` | The live season | `formations-and-shape` | 6: This week's table; The fixture that matters; Injury and lineup news; Transfer news decoder; Title race and relegation maths; What is everyone talking about | `league-table`, `form-and-ppg`, `goal-difference`, `title-race`, `relegation-scrap`, `derby` ... |

#### `the-live-season`: The live season

Weekly refreshed lessons built from live standings, fixtures and editorial explainers. (live hook: dataKind `standings,scores,schedules,news`, adapterKey `soccer.season`, refresh hourly; minutes during matches; personalization slots: `team`, `player`, `league`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `live-01` | This week's table | You can read your team's place in the table and what it needs. | `league-table`, `form-and-ppg`, `goal-difference` | multiple-choice, fill-the-gap |
| `live-02` | The fixture that matters | You can explain why this week's match matters. | `title-race`, `relegation-scrap`, `derby` | multiple-choice, say-this |
| `live-03` | Injury and lineup news | You can explain what an injury or a lineup change means for the team. | `injury-report`, `fixture-congestion` | multiple-choice, decision-scenario |
| `live-04` | Transfer news decoder | You can tell rumour from confirmed news. | `here-we-go`, `transfer-window`, `contract-expiry` | multiple-choice, say-this |
| `live-05` | Title race and relegation maths | You can explain what a team needs from its run-in. | `run-in`, `title-race`, `relegation-scrap` | multiple-choice, estimate-slider |
| `live-06` | What is everyone talking about | You can explain the story fans are talking about today. | `sack-race`, `international-break`, `var-basics` | say-this, talk-track |

### Conversation practice (1 unit + Talk tab)

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `conversation-lab` | Conversation lab | `the-game` | 8: After a win; After a loss; Talking about the referee; Talking tactics; Talking transfers; Rivalry and banter; Match-day fan slang; Asking a real question | `clean-sheet`, `worldie`, `bottled-it`, `clinical`, `handball`, `offside-offence` ... |

#### `conversation-lab`: Conversation lab

Talk tracks and What is she talking about lines that combine everything. (personalization slots: `team`, `player`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `talk-01` | After a win | You can respond warmly to a happy fan. | `clean-sheet`, `worldie` | talk-track, say-this |
| `talk-02` | After a loss | You can respond to disappointment without being flippant. | `bottled-it`, `clinical` | talk-track, say-this |
| `talk-03` | Talking about the referee | You can join a referee complaint without picking a fight. | `handball`, `offside-offence` | talk-track, say-this |
| `talk-04` | Talking tactics | You can ask a good tactical question. | `pressing`, `low-block`, `counter-press` | talk-track, say-this |
| `talk-05` | Talking transfers | You can react to transfer news and rumours. | `here-we-go`, `loan-and-fee` | talk-track, say-this |
| `talk-06` | Rivalry and banter | You can tease without being mean. | `banter-rivalry`, `derby` | talk-track, say-this |
| `talk-07` | Match-day fan slang | You can decode nutmegs, rabonas and worldies. | `nutmeg-rabona`, `worldie`, `scrappy-win` | say-this, talk-track |
| `talk-08` | Asking a real question | You can ask a curious question instead of faking it. | `respect-for-rivals`, `match-report-talk` | talk-track, say-this |

### Perpetual review

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `perpetual-review` | Perpetual review | `the-game` | 4: Daily bite; Weekly rewind; Say-this lightning round; Season recap | `match-length`, `offside-position`, `xg`, `formation-numbers`, `pressing`, `corner-routine` ... |

#### `perpetual-review`: Perpetual review

Spaced review that keeps concepts warm all season. (personalization slots: `team`, `player`, `league`)

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `review-01` | Daily bite | You can recall today's due concepts in three minutes. | `match-length`, `offside-position`, `xg` | multiple-choice, fill-the-gap |
| `review-02` | Weekly rewind | You can revisit last week's concepts at a slower pace. | `formation-numbers`, `pressing`, `corner-routine` | multiple-choice, term-match |
| `review-03` | Say-this lightning round | You can decode fan lines quickly. | `worldie`, `bottled-it`, `clinical` | say-this |
| `review-04` | Season recap | You can explain the season's big stories. | `title-race`, `relegation-scrap`, `world-cup-2026` | multiple-choice, say-this |

### Concept count target (Playbook)
172 concepts authored in the Playbook for launch (see `exercises.md` section 4 for every term with definition and example line). Target after year one: 220+ with new slang and rule changes. Every concept id is referenced by at least one lesson.

### Personalization slots
`team`, `player`, `league` (section 8). Tokens appear in the live, conversation, branch and review units.

### Review policy
Leitner boxes (`leitner-boxes-v1`): intervals 1, 3, 7, 14, 30, 60 days; max 12 items per review session; mastery threshold 0.8; mastery decay after 45 days without review; review activity types: multiple-choice, fill-the-gap, term-match, say-this, binary-call, estimate-slider. New rules (each July) reset affected concepts to box 1.

### Release plan
- **Launch:** all foundation, intermediate and enthusiast units; the `premier-league`, `mls`, `champions-league` and `world-cup` branch units; the live unit with standings/scores/news templates; conversation lab (8 lessons, 24 talk tracks); review. Unity: `soccer.offside.line-read.v1` and `soccer.shape.formation-read.v1` first (highest teaching value, simplest scenes).
- **Update 1 (launch + 6-8 weeks):** `soccer.pressing.trigger-call.v1`, `soccer.setpiece.corner-read.v1`; `nwsl` and `la-liga` branch units.
- **Update 2:** `soccer.attack.overload-find.v1`, `soccer.defending.line-height.v1`.
- **Ongoing:** weekly live templates; July rules refresh (IFAB), August season reset (fixtures, promotion/relegation, MLS calendar in 2027), tournament layers (Euros, Copa America, the 2027 Women's World Cup, the 2030 World Cup), and new slang.

## 12. Interaction plan
Every activity family maps to a native type or Unity sim. Estimated counts are lesson slots x about 3 items in the launch pool (sims: scenarios in the set). Native types link to `docs/native-exercises/CATALOG.md`.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Offside line read: `offside-04`, `offside-07` | offside-position, level-is-onside, offside-body-parts, active-play, deliberate-play | `unity-sim` `soccer.offside.line-read.v1` (spec: `sims/soccer.offside.line-read.v1.md`) | Rubric: spatial reasoning yes (line vs ball vs defender), movement over time yes (runs and the pass frame), camera perspective yes (parallax). Closest native: `binary-call`/`hotspot-tap` on static diagrams teach the definition (used in `offside-01` to `offside-03`) but cannot make the learner find the pass frame. | A | 28 scenarios |
| Pressing trigger call: `attack-05` | pressing, pressing-trigger, high-press, mid-block, pressing-traps | `unity-sim` `soccer.pressing.trigger-call.v1` (spec: `sims/soccer.pressing.trigger-call.v1.md`) | Timing in a scene: the trigger is a moving event. `timing-tap` is a 1D bar, `decision-scenario` is static facts; neither shows the press collapse when called early. | A | 16 scenarios |
| Name that shape / find the pocket: `shape-04`, `shape-07` | formation-numbers, in-out-possession-shape, compactness, half-spaces, between-the-lines | `unity-sim` `soccer.shape.formation-read.v1` (spec: `sims/soccer.shape.formation-read.v1.md`) | A formation is a pattern that changes by phase; shape, gap and pocket only make sense in motion and from above. Native `hotspot-tap` (used in `shape-01` to `shape-03`) teaches numbers but shows one frame. | A | 18 scenarios |
| Read the corner: `setpiece-03`, `setpiece-06` | corner-routine, zonal-man-marking, set-piece-marking, near-far-post, short-corner, second-ball | `unity-sim` `soccer.setpiece.corner-read.v1` (spec: `sims/soccer.setpiece.corner-read.v1.md`) | Ball flight (swing), runs and marking assignments beat a static diagram, and the decision is spatial. | A | 16 scenarios |
| Find the free man: `attack-03` | overload, passing-lanes, third-man-run, switch-of-play, triangles | `unity-sim` `soccer.attack.overload-find.v1` (spec: `sims/soccer.attack.overload-find.v1.md`) | Lanes open and close as defenders shift; a top-down dynamic scene shows what a broadcast frame hides. `decision-scenario` loses geometry. | A | 16 scenarios |
| Set the line: `attack-07` | high-line, offside-trap, compactness, low-block, counter-press | `unity-sim` `soccer.defending.line-height.v1` (spec: `sims/soccer.defending.line-height.v1.md`) | Continuous control in a moving scene (line height against pressure and a runner); a native bar or fact sheet cannot show the squeeze or the runner behind. | A | 16 scenarios |
| Definitions and rules recall | most foundation concepts | `multiple-choice` | Default check for terms and rules. | B | 267 |
| Yes/no calls on a diagram or description | offside-position, handball, no-offside-restarts, foul | `binary-call` | Two-way rule calls on a static situation; better than Unity for one-frame rules. | B | 30 |
| Term families | positions, restarts, blocks, cards | `term-match` | Introduce 3-6 related terms at once. | B | 72 |
| Ordering processes | tiebreaks, competition paths, build-up | `sequence-order` | Order is the concept (knockout ladder, league phase to final). | B | 6 |
| Referee, manager and transfer judgment | dogso, low-block, here-we-go, financial-rules | `decision-scenario` | Judgment from facts; graded best/acceptable/poor teaches trade-offs. | B | 27 |
| Talk-track (lesson + Talk tab) | conversation concepts | `talk-track` | Conversation practice; smooth score rewards empathy and curiosity. | B | 54 + 24 Talk tab |
| Say-this | fan slang and tactics | `say-this` | "What is she talking about?" decodes real lines. | B | 198 |
| Fill the gap | rules in context | `fill-the-gap` | Vocabulary in context. | B | 33 |
| Estimate | numbers (teams, xG, matches) | `estimate-slider` | Closeness matters more than exactness. | B | 18 |
| Hotspot-tap | pitch markings, positions, half-spaces | `hotspot-tap` | Spatial knowledge on a static diagram. If players move, use Unity. | B | 33 |
| Timing-tap | goalkeeper-eight-seconds, time-wasting-countdown, penalty-strategy | `timing-tap` | A 1D bar is enough: the 8-second and 5-second rules are pure clocks. Unity is not justified. | B | 3 |

**Not used:** `visual-id` and `listening-id` (imagery and audio licensing risk, spec rule 10; nothing here needs photo or sound recognition).

**Native fallback lessons** (for accessibility and when Unity is unavailable; designed exercises, not ports): `offside-native-fallback` (uses `offside-01` to `offside-03`), `shape-native-fallback` (`shape-01` to `shape-03`, `shape-05`), `pressing-native-fallback` (`attack-06`), `set-piece-native-fallback` (`setpiece-01`, `setpiece-02`).

## 13. Licensing & safety
| Area | Handling |
|---|---|
| Logos and trademarks | No club, league, FIFA, UEFA or MLS logos, badges or trophies; use names as plain text (nominative use). No official kit imagery; sims use fictional colour kits with patterns. Team colours are personalization tokens as text only. |
| Player likeness | No photos, avatars or likeness of real players; use names in text only. Sims use generic stylised figures. |
| Imagery and diagrams | Procedural or original diagrams only (`soccer-pitch-full`, `soccer-pitch-attacking-third`, `soccer-pitch-thirds`, `soccer-433-shape`). Each asset gets a `license` id (`original-swoond`). |
| Video and highlights | No embedded video or GIFs; link out to official channels only where terms allow. |
| Audio | No chants, commentary or match audio. Any audio is original synthesized cues. |
| Article text | Never copied; explain and link. |
| Data provider terms | Follow each provider's terms and attribution; TheSportsDB as the initial candidate; no scraping of official sites; no unofficial APIs. |
| Rules text | Written in our own words from the IFAB Laws; link to the official IFAB Laws page. |
| Safety | No medical guidance (injuries, concussion); no glamorization of hooliganism or violence at derbies; no gambling odds or prompts; respectful treatment of abuse and discrimination topics (explain, do not joke). Never about the crush; never mocking a team or fan base. |

## 14. Content assets
- Procedural pitch diagrams (natively drawn by the app, diagram ids above) and Unity procedural pitches.
- Original pitch-marking, formation and half-space diagrams for hotspot-tap and binary-call.
- Original illustrated referee-signal set (optional future `visual-id`, `license` `original-swoond`).
- Fonts: Instrument Serif and Geist (OFL).
- Scenario JSON for sims (original data).
- No external imagery, audio or logos at launch.

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. What does a beginner need to understand? Sections 2-3 (the match, restarts, the laws, roles, the league system).
- [x] 2. What do enthusiasts care about? Section 4 (tactics, referee/VAR, xG, transfers, tables, rivalries).
- [x] 3. What current information matters? Section 6 and `live-data.md` (scores, tables, fixtures, injuries, transfers, editorial explainers).
- [x] 4. What should be interactive? Section 5 and 12 (6 sims + 11 native types).
- [x] 5. What should NOT be gamified? Section 5 (injuries, abuse, tragedies, gambling, hooliganism, mocking).
- [x] 6. How should it personalize? Section 8 (team, player, league).
- [x] 7. What does conversational competence look like? Section 9 and 10.
- [x] 8. What data providers are needed? Section 6 and `live-data.md`.
- [x] 9. What licensing constraints apply? Section 13.
- [x] 10. How will Swoon'd measure useful understanding? Section 10 (concept mastery, pass 0.8, spaced review, talk-track smooth score).

Additional gates: [x] manifest validates; [ ] curriculum validates (curriculum JSON not yet written); [ ] every Unity sim has an approved spec (6 drafts written, approval pending); [x] every image/audio asset has a license id (none needed at launch); [ ] voice review (pending); [x] no copied publisher text.

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Default `league` when unset: `premier-league` for wording, or ask at onboarding? Consider a region-based default for US learners (MLS/NWSL). | Product | No |
| 2 | News provider for the editorial layer (DECISIONS Q-3). | Product | Yes, for the live layer only |
| 3 | xG / advanced stats provider and licence (or use only authored numbers). | Product / Claude | No |
| 4 | Should the course name in the UI be "Soccer" for all learners, or "Football" for non-US locales? | Product | No |
| 5 | Confirm the launch order of sims (offside and shape first). | Product / Astra | No |
| 6 | Diagram ids to be drawn natively (list in `NOTES_FOR_ORCHESTRATOR.md`). | Claude | Yes, for hotspot-tap items |
| 7 | 2026/27 IFAB measures still in consultation (player exit protests, mouth-covering): add lessons once approved. | Content | No |
