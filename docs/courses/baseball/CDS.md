# Course Design Specification: Baseball (`baseball`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md`, `sims/*.md` |

Time-sensitive facts in this document (rules, formats, standings, labour situation) were checked by web search on **2026-09-30** and are tagged **[verify at release]** where a re-check is needed before content ships. Search results were secondary media (MLB.com, Yahoo, ESPN, Baseball America, Wikipedia, Opta); nothing was checked against the official rulebook PDF. Lesson copy never hard-codes them; the live layer (`season-now`) and dated rule tokens carry them (see `live-data.md`).

---

## 1. Identity

- **Course ID:** `baseball` (immutable)
- **Display name:** Baseball
- **Category / family:** Sports > Baseball (family `Sports`)
- **Simulation prefix:** `baseball`
- **Three lenses, one course.** Baseball is the sport people *talk through*. The person you care about may (a) follow one team obsessively across 162 games (the dominant case), (b) love the game itself (stats, history, ballparks), or (c) play or coach it (rec league, kids, softball-adjacent). The course teaches the shared game once, then tilts examples through branches and the `team` personalization slot. It is deliberately built around *conversation over time*: baseball fandom is a daily-habit relationship with a team, so the current-season layer and the conversation lab matter more here than in most sports.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Softball (not in catalog) | Fast-pitch softball shares the diamond, batting order, outs, fielding numbers and most base-running logic; pitching (underhand, windmill), field size, ball, innings (7), and culture differ. A learner of baseball follows softball at a basic level but would misjudge pitching talk. | Adjacent | Mention as analogy only; no course. A one-off `col-`/rec note that "softball is not small baseball". If softball becomes a course, cross-link the diamond and scorekeeping units. |
| College baseball | Same core game; metal (BBCOR) bats, 56-game seasons, NCAA tournament to Omaha, transfer portal, NIL, different pace rules. Fans talk conferences and Omaha, not WAR and arbitration. | Shares foundation | Branch `college` (later, see release plan). |
| NPB (Japan) and KBO (Korea) | Same core game; different league structure, playoffs, ties, cheering culture, import rules; heavy pipeline to MLB and heavy cultural texture. A learner who only knows MLB will be lost at "oendan" or "bat-flip culture" and at ties in the standings. | Shares foundation | Branches `npb` and `kbo` (separate: leagues, cultures, playoff formats and fandoms differ). |
| Minor leagues / Little League / high school | Minor leagues are the MLB pipeline (a unit inside `front-office`); youth baseball is a rec-play world with different rules (pitch counts by age, dropped third strike, 60 ft bases). | Shares foundation (minors); adjacent (youth) | Minors are a unit; youth only as safety-flavoured notes in `ballpark-culture` and `pit-05`; not a branch. |
| Cricket | Bat-and-ball surface similarity; entirely different rules and culture. | Independent | No consequence; never used as an analogy (the classic cricket comparison causes more confusion than help). |
| American Football, Basketball, Hockey | Social-adjacent (same fan), no transfer. | Independent | None. Cross-link only for the "sports fan" personas. |
| Fantasy baseball, betting | Fantasy stats culture overlaps; betting is out of scope (spec: not a gambling product). | Adjacent | Fantasy vocabulary appears in `ana-` lessons as fan talk; no betting content, ever. |

- **Branches:**

| id | Name | What changes | Launch |
|---|---|---|---|
| `mlb` | Major League Baseball | Default branch. 30 teams, 162 games, MLB rules (universal DH, pitch clock, ABS challenges), MLB postseason, draft/free-agency world. | Launch |
| `college` | College baseball (NCAA) | BBCOR bats, 56-game season, regionals to the College World Series in Omaha, conferences, transfer portal, NIL, draft path, ABS from 2027 [verify]. | v1.1 |
| `npb` | Nippon Professional Baseball (Japan) | 12 teams in the Central and Pacific Leagues, 143 games, ties, 12-inning cap, Climax Series and Japan Series, oendan cheering culture, posting system to MLB. | v1.2 |
| `kbo` | KBO League (Korea) | 10 teams, 144 games, five-team postseason, Korean Series, bat-flip and cheer-squad culture, ABS in every park, import-player limits, path to MLB. | v1.2 |

Choosing a branch sets the `league` personalization dimension. The `mlb` branch needs no extra units (the enthusiast layer is MLB-flavoured); each other branch adds one `branch` layer unit and branch-tagged activities inside shared lessons (contract 1.2 `branchId`).

---

## 2. Beginner model

**What a complete beginner knows.** "Three strikes, you're out." "Home run!" That it's slow, that there are hot dogs and a song about peanuts, that people love or hate the Yankees, and that pitchers throw fast. Many know the shape of a diamond and that you run counterclockwise, and most do not know *why a runner sometimes just stands on second while everyone yells*. Almost nobody can read a box score.

**Terminology that confuses:** the count ("full count", "two and oh"), "ball" versus "strike" versus "foul", "walk", "hit-by-pitch", "force out", "tag up", "sacrifice fly", "fielder's choice", "earned run", "save", "hold", "DH", "bullpen", "closer", "the shift", "pitch clock", "ABS challenge", "slash line" (.300/.400/.500), "OPS", "WAR", "exit velocity", "barrel", "Tommy John", "DFA", "the IL", "arb", "luxury tax", "lockout", "waiver", "Rule 5", "walk-off", "cycle", "no-no", "the Mendoza line", "dinger", "ribbie".

**Common misconceptions (each is a lesson beat):**
1. "A foul ball is just a do-over." A foul is a strike until two strikes; then it does not count as strike three (unless it is a bunt attempt). Foul balls also may be caught for an out.
2. "Ball four means the batter walks even if the pitcher is just missing." Yes, and that's the point: four balls put the batter on first and runners advance only if forced. Beginners forget "forced".
3. "A runner can only go one base on a single." Not true: runners may take extra bases at risk of an out; *which* ones is most of the strategy.
4. "The pitcher's ERA is his runs allowed." ERA excludes unearned runs (runs that scored due to an error); this is exactly what the scorer's judgment decides.
5. "Batting average is how good a hitter is." It ignores walks and extra-base power. Fans use OBP, slugging and OPS or wRC+ in the same breath.
6. "A save means the closer saved the game." A save has specific criteria (lead of 3 or fewer entering, or tying run on deck, finish the game, not the winning pitcher, at least one inning if the lead is three).
7. "Pitch clock means the umpire is timing the pitcher." The clock is a visible timer; a violation is an automatic ball or strike.
8. "On a fly ball the runner can just take off." Not if the catch is made: he must be touching the base when the ball is first caught, and only then may he run (tagging up). Leaving early means returning to re-tag or risking an appeal out.
9. "The infield fly rule is only about fly balls." It is about protecting runners from a fielder purposely dropping a popup to turn two.
10. "Baseball is boring." Time between pitches, not action, dominates casual perception; the pitch clock (2023) cut the average nine-inning game by roughly 24 minutes, and that is what the enthusiast notices most.
11. "Only the batter and pitcher matter." At any moment nine defenders are positioned by data and a coach signals plays from the dugout; most of the talk is about *what the manager is doing*.
12. "Steroids ruined everything, so stats mean nothing." A common conversation trap; the fair frame is "eras" (see `oct-04`).

**Concepts that unlock the rest (become foundation units):** the count and what ends an at-bat; outs and force versus tag; how a run scores; reading the scoreboard and box score; the nine positions; and pitch types. With those, "She said the bullpen blew a two-run lead in the eighth" becomes decodable.

---

## 3. Foundational knowledge

Grouped into modules (become `foundationalModules[]` and foundation units).

| Module (unit id) | Content |
|---|---|
| `the-game` | Objective (score more runs), innings (9, top/bottom), three outs per half-inning, home team bats last (walk-off), extra innings with an automatic runner on second, the diamond (90 ft bases, mound 60 ft 6 in, plate 17 in wide, foul lines, fair and foul territory), nine defenders with numbers, batting order, leadoff and cleanup, the season (162 games, series, doubleheaders). |
| `the-count` | Balls and strikes, the zone, the count as language (3-2 full count), strikeouts (swinging, looking, dropped third strike), foul balls and two-strike rules, walk, hit-by-pitch, intentional walk, ball in play (grounder, liner, fly, popup), hit types, plate appearance vs at-bat. |
| `on-the-bases` | Safe and out, force versus tag, advancing on hits, walks, errors and fielder's choice, leading off, stealing, pickoffs, balks, tagging up, sacrifice fly, sending or holding a runner (third-base coach), double plays, rundowns. |
| `the-defense` | Who covers what, cutoffs and relays, errors versus hits, infield fly rule, the catcher (framing, blocking, calling a game), defensive alignment (infield in, double-play depth, no-doubles), the shift restrictions, range and arm. |
| `scoreboard-and-stats` | Line score (R-H-E), box score, batting stats (AVG, OBP, SLG, OPS, RBI, HR), pitching stats (ERA, WHIP, W-L, SV, HLD, K/BB), scorekeeping shorthand (K, backwards K, 6-4-3), milestone feats (no-hitter, perfect game, cycle), standings (W-L, PCT, GB, run differential). |
| `pitching` | Pitch types (four-seam, sinker, cutter, slider, sweeper, curveball, changeup, splitter), velocity and movement, starters and relievers, rotation and bullpen roles, pitch counts and workload, command versus stuff. |
| `hitting` | Contact, power, plate discipline, exit velocity and launch angle, barrels, approaches (pull, opposite field, two-strike), bunts and sacrifices, platoon splits, hitter types, lineup construction. |
| `strategy` | Managerial levers (pinch-hit, pinch-run, double switch), bullpen matchups and leverage, intentional walks, steal / hit-and-run / squeeze, the shift and its ban, win expectancy, "the book". |
| `modern-rules` | Pitch clock (15 s bases empty, 18 s with runners; batter ready at 8 s), disengagement limit (two per plate appearance), bigger bases (18 in), infield alignment restrictions, ABS challenge system (2026), automatic extra-inning runner, universal DH, three-batter minimum, replay. |

---

## 4. Enthusiast model

**What actual enthusiasts talk about.** Yesterday's game (a *recap* with a villain and a hero), the bullpen (always the bullpen), the manager's decisions ("why did he pull him?"), the lineup (who bats where), injuries (the IL), prospects ("when do they call him up?"), the standings and the wild-card race, trades and the deadline, free agency, contracts and money, the umpires (and now the ABS), and the *feel* of a series. Analytics fans talk WAR, wRC+, FIP, xStats and Statcast. Traditionalists talk RBIs, wins, "clutch", "grit" and unwritten rules. Nostalgia people talk ballparks, radio broadcasters, scorekeeping, and 1990s baseball cards.

**Distinctions that matter to them:**
- Starter versus reliever, and "quality start" versus "workhorse" language.
- Good contact versus lucky contact (xBA versus BA).
- Stuff versus command.
- Hitting for average versus hitting for power versus getting on base.
- Small ball versus three true outcomes (walk, strikeout, home run).
- Value contract versus albatross contract; rental versus long-term.
- The regular season as a marathon versus October as a lottery.
- MLB rules 2022 to 2026: the *new* game versus "the old game".

**Knowledge that signals genuine understanding:** reading a box score; knowing why a two-out RBI single with runners on second and third scores differently based on the left fielder's arm; knowing that the runner on second in extras is automatic; being able to say "they lost the series because the bullpen ran out of arms on Sunday"; knowing that a starter facing the lineup a third time is a known risk; knowing why a closer is used only in save situations and why some fans hate it.

**Beginner statements that sound obviously uninformed:**
- "Why don't they just let the pitcher hit?" (He doesn't in MLB since 2022: universal DH.)
- "That was a great game, nobody scored." (A 0-0 game can be a masterpiece; but "nobody scored" without asking who pitched is empty.)
- "He hit .300 so he's amazing." (Depends on OBP, park, era.)
- "Why did they walk him on purpose? That's cheating." (It is a standard strategy.)
- "Cricket but slower." (Do not.)
- "Why do they call it a save?" (Fine to ask; do not pretend.)
- "It's all luck in October." (Partly true; but that is a debate, see `oct-02`.)

**Common controversies and debates:**
- The pitch clock and pitch-count/injury concerns; is the game "better", "faster", or "less baseball"?
- ABS challenges: does a robot zone kill umpire craft; will full ABS come? (2026 challenge system, first full MLB season; [verify at release].)
- Shift ban: did the ban help batting average on balls in play?
- Bat flips and "unwritten rules" (cultural clash, "the right way to play").
- The Hall of Fame and PED-era players; the "character clause".
- The **salary cap** fight and the December 2026 CBA expiry: lockout expected [verify at release]; small versus big-market payrolls; Dodgers "buying" championships.
- Openers, bullpen games, and the death of the complete game; starting pitcher innings decline.
- Three true outcomes; strikeouts up, contact down; "too many strikeouts".
- Tanking and the draft lottery; and the 2026 Houston Astros, reported as the first team without a winning record to win a division in a 162-game season [verify at release].
- Expansion talk (Nashville and Salt Lake City are the cities most often named) and the Athletics' move from Oakland to Sacramento and then Las Vegas [verify at release].
- Ohtani's two-way stardom and the Dodgers' payroll structure (deferred money).

---

## 5. Interaction model

**What the learner should experience instead of reading.** Reading a scoreboard and a box score (visual-id and hotspot-tap on original box-score art), making the calls a manager faces (decision-scenario with a facts table: outs, runners, score, batter and pitcher handedness), hearing what the *count* means in a sentence, sorting who covers which base, and **seeing things move**: a runner deciding to stop or go as a ball drops, fielders placed for a situation, and a pitch's flight as a hitter sees it.

**Does baseball warrant a Unity simulation?** Yes, **three**, chosen narrowly by the tier rubric:
1. **Baserunning: read the ball and go or hold** (movement over time; timing in a scene; race between runner and throw). Native `decision-scenario` teaches the rule ("tag up on a deep fly") but not the *feel* that a throw beats you by half a step.
2. **Defensive alignment: where fielders stand for the situation** (spatial reasoning; positions as a picture: infield in, double-play depth, no-doubles). Static native `hotspot-tap` shows a *standard* alignment; it cannot show why depth changes with the outs and the score, or what happens when a ball is hit into the empty spot.
3. **Pitch shapes: read the pitch from early flight** (physics and camera perspective: what a hitter sees in the first 0.15 s; spin, drop, sweep, tunneling; the ABS zone scaled to the batter). Photos, diagrams and text cannot show that a slider and a fastball look identical for the first 30 feet.

**What should NOT be gamified:** the history of the sport (Negro leagues, integration, labour fights) as points-chasing trivia (taught with `multiple-choice` and `say-this` with reflective explanations, never with speed pressure); injuries (Tommy John surgery is taught as context, not a "game"); the CBA/lockout is explained neutrally; no betting or gambling content; no "guess the stat line" for real named players' health; and never mock fans of a team (the person she cares about is one).

**Chosen mix (details in section 12):** ~75% native (multiple-choice, binary-call, term-match, sequence-order, visual-id, decision-scenario, talk-track, say-this, fill-the-gap, estimate-slider, hotspot-tap, timing-tap for the pitch clock and swing timing, listening-id for the "sounds of the ballpark"), and 3 Tier A sims (5 lessons).

---

## 6. Dynamic information requirements

Baseball is a *daily* sport (162 games, roughly April to late September, then October), so the current layer matters more than it does for pickleball or hiking. Swoon'd is not ESPN (spec section 33): a few minutes behind is fine; no live pitch-by-pitch.

| Kind | Needed? | Why | Provider candidates (behind adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules` | Yes | "When does her team play this week; who is the starter?" | TheSportsDB (basic MLB coverage, confirm); Sportradar or SportsDataIO MLB (upgrade); official team schedule link-outs | daily (hourly game days) | Last snapshot with "as of" date |
| `scores` | Yes | Recaps and "did they win last night?" | Same as above; MLB Stats API (statsapi.mlb.com) is **not licensed for commercial use**; do not use in production without an MLB Advanced Media agreement | minutes during games (light), otherwise daily | Last final result |
| `standings` | Yes | Division race, wild card, magic number | Same providers; standings computed by Swoon'd from finals if needed | daily | Snapshot |
| `statistics` | Light | Leaders and the player card | Provider basic stats; Retrosheet (historical, attribution), Lahman database (CC BY-SA 3.0), Chadwick Bureau register (IDs); Baseball Savant and FanGraphs/Baseball-Reference are **link-out only** (terms restrict use) | daily | Evergreen definitions |
| `rosters` / `transactions` / `injuries` | Yes | "Who's on the IL, who got traded" | Provider transactions feeds (Sportradar/SportsDataIO), official MLB transactions page as link-out | daily (hourly around the trade deadline) | Explainer card only |
| `events` | Yes | Postseason bracket, All-Star Game, Draft, Winter Meetings | Provider + curated | event driven | Evergreen explainer |
| `regulations` | Yes | New rules (pitch clock, ABS, CBA) | Curated editorial with rule numbers/links (MLB.com rule glossary, official rules) | on-release | Evergreen unit `modern-rules` |
| `news` | Yes | "Why is everyone talking about this?" | Publisher RSS headline-only (link-out), Swoon'd writes the explainer; provider decision is open (DECISIONS Q-3 / L-01) | daily | Evergreen explainers |
| `rankings` | Light | Prospect rankings (pipeline), college top-25 | Curated link-out | weekly | Skip |
| `weather` | Optional | Rainouts and roofs on game day | NWS API | hourly on game days | Hidden |
| `releases` / `closures` / `alerts` | No | No meaningful need | n/a | n/a | n/a |

Structured data and editorial are separate systems (spec section 11). Details: `live-data.md`.

---

## 7. Editorial context

- **What commentary helps:** "why did fans boo the manager?", "why does a 3-run lead in the ninth feel unsafe?", "what is a bullpen game?", "why is the salary cap fight a big deal?", "why did the Dodgers win again?", "what is the ABS challenge and why are people angry?".
- **Sources:** MLB.com news and glossary, team beat writers (headline/link-only), The Athletic, ESPN, Baseball America (link-only), FanGraphs (link-only). Explain in Swoon'd words and link; never copy publisher text.
- **Summarize, explain, or link?** `explain-and-link`. Explanations are educational: what happened, why it matters to a fan, what term she may hear next.
- **Example prompts:** "Why are fans talking about the lockout?", "Why did the manager pull the starter in the sixth?", "Why is this trade deadline different?", "What does a wild-card round feel like?", "What is she likely to say after tonight's game?".
- **Editorial safety:** no injury speculation or medical claims about named players; no accusations about named individuals (PED talk is historical and factual only); neutral on labour disputes; never mock a team's fans.

---

## 8. Personalization

| Dimension | How it changes examples and live context | Default when unset | Units using tokens |
|---|---|---|---|
| `team` | Examples use her team's park, division rivals, recent series, bullpen storylines; live feed leads with her team; talk tracks "her team lost/won" | Neutral "her team" with a rotating famous-team example (e.g. Dodgers, Yankees, Cubs, Red Sox, Braves, Guardians named as plain text) | `the-game`, `strategy`, `season-now`, `conversation-lab`, `ballpark-culture` |
| `player` | Player card, stat lines explained through the player she loves; ranking or award storylines | A neutral archetype ("her favourite shortstop") | `hitting`, `pitching`, `analytics`, `season-now` |
| `league` | Set by the branch (MLB / college / NPB / KBO); chooses which season and postseason explainers lead | `MLB` | `season-now`, branch units |
| `region` | Weather and local park context; broadcast availability tips | Hidden | `ballpark-culture`, `season-now` |
| `skill-level` | Depth of explanation in lessons: "watcher" versus "plays rec/coaches kids" (adds fundamentals like force-play mechanics) | "watcher" | `on-the-bases`, `the-defense`, `hitting` |

Personalization tokens use the curriculum syntax `{{team}}`, `{{player}}`, `{{league}}`, `{{region}}`, `{{skillLevel}}`; the default value is chosen so every sentence still reads well (section 8 of the CDS template rule).

---

## 9. Conversation model

**What an enthusiast might naturally say (translation and implied terminology):**

| # | She says | What it means | Terms implied | A meaningful next question |
|---|---|---|---|---|
| 1 | "Our bullpen blew it again." | Relief pitchers gave up the lead late; the team lost or nearly lost. | bullpen, blown-save, reliever | "Was it the closer or the guy before him?" |
| 2 | "He took a 3-2 slider right down the middle." | Full count; the hitter watched a strike (called strike three). | full-count, slider, called-strike-three | "Was he sitting on a fastball?" |
| 3 | "We're one game back for the second wild card." | Team trails the last playoff spot by one game. | wild-card, games-behind | "Who else is chasing it?" |
| 4 | "They pulled him after 92 pitches and he'd only given up one run!" | Manager removed a starter with a low pitch count and a good outing. | pitch-count, times-through-the-order | "Was the bullpen rested?" |
| 5 | "That's a sacrifice fly, so no at-bat but an RBI." | Fly ball caught in the outfield, runner tags and scores; batter is not charged an at-bat. | sac-fly, RBI, at-bat | "Was the outfielder's arm the reason he tagged?" |
| 6 | "He's on the IL; they called up Perez." | Player is injured and replaced by a call-up. | IL, call-up | "What kind of injury? Just a short stint?" |
| 7 | "I hate the ghost runner." | Dislikes the automatic runner on second in extra innings. | automatic-runner, extra-innings | "Would you go back to the old way, or just start the runner on first?" |
| 8 | "The ABS challenge got him there." | A batter/pitcher/catcher challenged a ball-strike call and the system overturned it. | ABS-challenge | "Do teams save challenges for late innings?" |
| 9 | "We're a game over .500 with a plus-twelve run differential." | 1 game over .500; scored 12 more runs than allowed; hints team is slightly better than record. | run-differential, .500 | "What do fans expect next?" |
| 10 | "He's hitting .270 but the OBP is .380. That's a leadoff guy." | Low average but he walks; high on-base skill. | OBP, leadoff-hitter | "Does he steal a lot too?" |
| 11 | "The shift is gone so lefties are back." | Since the shift restrictions, pull-heavy lefties get more hits on grounders. | shift-ban, pull-hitter | "Did batting averages actually go up?" |
| 12 | "Lockout by December." | Owners will stop the offseason when the CBA expires on Dec 1 2026. | CBA, lockout | "Is the salary cap the sticking point?" |
| 13 | "That was a 6-4-3." | Shortstop to second baseman to first baseman: a double play. | position-numbers, double-play | "Did he turn two?" |
| 14 | "He's a rental." | A player on an expiring contract acquired at the deadline. | rental, trade-deadline | "Would you keep him or sell?" |
| 15 | "Watching the Ks stack up in the seventh." | Strikeouts; (Ks in a scorecard). | K, strikeout | "How many so far?" |

**How Swoon'd helps without encouraging fake expertise:** every conversation item includes a `noFakeExpertNote` and follow-ups that are honest curiosity ("Who was he facing?"), never pretend analysis. Coach notes reward asking about *her experience* and admitting "I'm still learning; walk me through it." Cringe replies fake authority, correct her ("Actually it's a hold, not a save"), or insult her team.

**Targets:** 24 talk tracks at launch (`conversation-lab` six lessons, one per foundation unit end, plus 6 in the current-season layer), 80+ say-this items, 4 tracks per branch.

---

## 10. Assessment

- **Useful competence** = she can (1) decode a game recap and a scoreboard, (2) follow a broadcast or a live game and know what just happened and why it mattered, (3) explain the count, force versus tag, and the modern rules in her own words, and (4) ask two honest, informed questions about her team's bullpen, lineup or the standings.
- **Recognise:** the field and positions, the count, pitch types by name and shape, a box score and line score, standings columns, the new-rule vocabulary.
- **Understand:** why the count drives strategy; why runners tag up; why bullpens are used the way they are; why OPS beats batting average; what WAR is in one sentence; why the wild-card round is a coin flip; what a CBA is and why a lockout stops the offseason.
- **Explain:** "what is the infield fly rule", "how does the pitch clock change the game", "what is ERA".
- **Correctly interpret:** a line score, a box score row (`3 AB, 2 H, 1 RBI, 1 BB`), a 6-4-3, a standings row with GB, a pitcher's line (`6.0 IP, 4 H, 2 ER, 7 K`).
- **Mastery model:** `concept-mastery-v1`, pass threshold **0.8**; enthusiast-depth concepts count as Familiar at 0.6 for reporting. Review interval ladder: 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per daily session; a concept slipping below 0.6 re-enters at 1d.
- **Useful competence statement:** "She can follow a baseball game or a broadcast, read the scoreboard and the box score, understand the count and the modern rules, ask a couple of good questions about a bullpen or a lineup, and say 'okay, I get why you love this' without faking it."

---

## 11. Curriculum map (ongoing course)

Course version target at launch: `curriculumVersion 0.1.0` (structure + first units). **19 units, 116 lessons** across all six layers (a learner sees 16 core units plus at most the units of the branch(es) they choose; branch units are tagged `branchId`). Activity legend: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap, `SIM` unity-sim. The Activities column names the activity *families* the lesson uses; each lesson has 4 or more activities in curriculum JSON (validator rule `thin-lesson`) and ends with a "line you could say out loud" and 1-2 Playbook additions. Every unit's final lesson is a mixed-review capstone that includes one `tk` or `st` beat.

Concept ids are listed in the Appendix (generated from these tables; every id below appears there).

### Layer 1: Foundations (5 units, 35 lessons)

**Unit `the-game`: The Game in One Sitting** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `game-01` | Two teams, one long story | Say in one breath what baseball is and why it feels slow. | game-objective, baseball-pace | mc, st, fg |
| `game-02` | Innings and outs | Explain three outs, top and bottom, and why nine innings. | inning, half-inning, out | mc, so, bc |
| `game-03` | The diamond, mapped | Locate the bases, mound, plate, foul lines and infield/outfield. | diamond, infield, outfield, foul-line, fair-foul-territory | ht, tm, mc |
| `game-04` | Nine defenders, nine numbers | Name the positions and their numbers. | pitcher, catcher, infielder, outfielder, position-numbers | ht, tm, vi |
| `game-05` | The batting order | Explain the lineup and why batting order matters. | batting-order, leadoff-hitter, cleanup-hitter, designated-hitter | mc, ds, fg |
| `game-06` | How a game ends | Handle nine innings, walk-offs and extra innings with the automatic runner. | nine-innings, walk-off, extra-innings, automatic-runner, home-team-bats-last | bc, mc, so |
| `game-07` | The long season | Understand 162 games, series, and why one loss barely matters. | season-162, series, games-behind, winning-percentage | es, mc, tk |

**Unit `the-count`: The Count and the At-Bat** (prereq: `the-game`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `count-01` | Balls and strikes | Define ball, strike and the strike zone. | ball, strike, strike-zone | mc, ht, bc |
| `count-02` | The count is a language | Read "3-2", "0-2" and know who has the advantage. | count, full-count, hitters-count, pitchers-count | fg, mc, ds |
| `count-03` | Three ways to strike out | Tell swinging, looking, and dropped third strike apart. | strikeout, swinging-strike, called-strike-three, dropped-third-strike | bc, mc, st |
| `count-04` | Fouls and near-misses | Know when a foul is a strike and when it is not. | foul-ball, foul-tip, checked-swing | bc, mc, ds |
| `count-05` | Walks and hit-by-pitch | Explain how a batter reaches without a hit. | walk, hit-by-pitch, intentional-walk | mc, bc, ds |
| `count-06` | Ball in play | Recognize grounder, liner, fly, popup, and hit types. | ground-ball, line-drive, fly-ball, pop-up, single, double, triple, home-run, ground-rule-double | vi, tm, mc |
| `count-07` | One plate appearance, start to finish | Order a plate appearance; at-bat versus plate appearance. | plate-appearance, at-bat, pitch-sequencing | so, tk, st |

**Unit `on-the-bases`: Running the Bases** (prereq: `the-count`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `base-01` | Safe or out | Define safe, out and the tag. | safe, tag | bc, mc, vi |
| `base-02` | Force plays and tag plays | Decide whether a runner must be forced. | force-play, tag-play | ds, bc, ht |
| `base-03` | Advancing | Explain how runners move on hits, walks, errors and fielder's choices. | advance, fielders-choice | mc, so, bc |
| `base-04` | Leads, steals and pickoffs | Describe leading off, stealing, pickoffs and balks. | lead-off, stolen-base, caught-stealing, pickoff, balk | bc, mc, ds |
| `base-05` | Tagging up | Explain why runners hold on a fly ball. | tag-up, sacrifice-fly | ds, bc, mc |
| `base-06` | Read it and go | Decide go or hold as a ball drops and the throw comes. | send-or-hold, third-base-coach, read-and-go, two-outs-running | SIM `baseball.baserunning.read-and-go.v1`, bc, ds |
| `base-07` | Double plays and rundowns | Follow a 6-4-3 and a rundown. | double-play, rundown, triple-play | so, mc, tk |

**Unit `the-defense`: The Defense** (prereq: `on-the-bases`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `def-01` | Who covers what | Say who covers which base and who backs up. | covering-bases, backing-up | ht, mc, ds |
| `def-02` | Hit or error? | Explain the scorer's decision; passed ball versus wild pitch. | error, hit-vs-error, wild-pitch, passed-ball | mc, bc, ds |
| `def-03` | Cutoffs and relays | Explain the cutoff man and the relay. | cutoff-man, relay-throw | ht, ds, mc |
| `def-04` | The infield fly rule | Say what it is, when it applies, and why it exists. | infield-fly-rule | bc, mc, ds |
| `def-05` | The catcher | Explain blocking, framing and calling a game. | catcher-duties, pitch-framing, pitch-calling | mc, st, vi |
| `def-06` | Where do they stand? | Choose depth and alignment for the situation. | infield-in, double-play-depth, no-doubles-defense, guarding-the-line, outfield-depth | SIM `baseball.defense.alignment-read.v1`, ht, ds |
| `def-07` | Range, arm and Gold Glove | Talk about defense: range, arm, Gold Glove. | range, arm-strength, gold-glove | mc, tm, tk |

**Unit `scoreboard-and-stats`: Scoreboards, Box Scores and Stats** (prereq: `the-count`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `score-01` | Reading a scoreboard | Read a line score and R-H-E. | line-score | vi, mc, fg |
| `score-02` | The box score | Read a batter's and pitcher's row. | box-score, earned-run | vi, ht, mc |
| `score-03` | The batting line | Define AVG, OBP, SLG, OPS, RBI. | batting-average, on-base-percentage, slugging-percentage, ops, rbi | tm, fg, es |
| `score-04` | The pitching line | Define ERA, WHIP, W-L, save, hold, quality start. | era, whip, win-loss-record, save, hold, quality-start, strikeout-to-walk | mc, tm, bc |
| `score-05` | Scorekeeping shorthand | Read K, backwards K, 6-4-3, F8. | scorekeeping-symbols | so, fg, ht |
| `score-06` | Feats and milestones | Recognize no-hitter, perfect game, cycle, triple crown. | no-hitter, perfect-game, cycle, triple-crown, complete-game, shutout | mc, st, bc |
| `score-07` | Reading the standings | Read W-L, PCT, GB, run differential, magic number. | standings, run-differential, magic-number, wild-card-race | vi, mc, tk |

### Layer 2: Intermediate (4 units, 28 lessons)

**Unit `pitching`: Pitching** (prereq: `the-count`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `pit-01` | The fastball family | Tell four-seam, sinker and cutter apart. | four-seam-fastball, sinker, cutter, velocity | vi, mc, tm |
| `pit-02` | Breaking balls | Tell curveball, slider and sweeper apart. | curveball, slider, sweeper | vi, mc, tm |
| `pit-03` | Reading the pitch | Read a pitch from its early flight. | changeup, splitter, pitch-movement, tunneling, pitch-mix | SIM `baseball.pitching.pitch-shapes.v1`, mc, ds |
| `pit-04` | Starters and relievers | Explain rotation, bullpen, closer, setup, opener. | starting-pitcher, rotation, reliever, bullpen, closer, setup-man, opener | mc, tm, ds |
| `pit-05` | Pitch counts and workload | Explain pitch counts and the third time through the order. | pitch-count, times-through-the-order, tommy-john, injured-list | mc, ds, es |
| `pit-06` | Stuff versus command | Distinguish stuff from command. | command, stuff, spin-rate | mc, ds, fg |
| `pit-07` | The pitchers' duel | Talk through a pitching duel and a bullpen day. | pitchers-duel | mc, st, tk |

**Unit `hitting`: Hitting** (prereq: `the-count`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hit-01` | Contact, power, discipline | Separate the three hitting skills. | contact-hitting, power-hitting, plate-discipline, chase-rate, whiff | mc, vi, tm |
| `hit-02` | Exit velocity and launch angle | Explain what a barrel is. | exit-velocity, launch-angle, barrel, hard-hit | es, mc, ht |
| `hit-03` | Approach | Explain pull, opposite-field and two-strike approaches. | pull-hitter, opposite-field, spray-chart, situational-hitting, two-strike-approach | mc, ds, ht |
| `hit-04` | Bunts and sacrifices | Decide when a bunt or sac fly helps. | bunt, sacrifice-bunt, squeeze-play, productive-out | ds, bc, mc |
| `hit-05` | Platoon and handedness | Explain lefty-righty matchups. | platoon-advantage, switch-hitter, lefty-righty-split | ds, mc, bc |
| `hit-06` | Types of hitter | Recognize slugger, contact hitter, five-tool, three true outcomes. | five-tool-player, three-true-outcomes | tm, vi, mc |
| `hit-07` | Why he bats second | Read a lineup card. | lineup-construction, protection | ds, mc, tk |

**Unit `strategy`: Strategy and the Manager** (prereq: `pitching`, `hitting`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `strat-01` | The manager's toolbox | Explain pinch hitters, pinch runners, double switches. | pinch-hitter, pinch-runner, defensive-replacement, double-switch | mc, ds, tm |
| `strat-02` | The bullpen decision | Explain leverage and save situations. | matchup-pitching, leverage, save-situation | ds, mc, bc |
| `strat-03` | Walk him on purpose | Explain intentional walks and pitching around a hitter. | pitching-around, first-base-open | ds, bc, mc |
| `strat-04` | Steal, hit-and-run, squeeze | Explain the break-even steal rate and hit-and-run. | hit-and-run, delayed-steal, steal-break-even | ds, mc, bc |
| `strat-05` | The shift, then and now | Explain the shift and its restrictions. | defensive-shift, shift-restrictions | ds, ht, mc |
| `strat-06` | Win expectancy | Read a win-probability swing. | win-expectancy | es, mc, ds |
| `strat-07` | Second-guessing the manager | Discuss "the book" without being a know-it-all. | the-book, analytics-vs-gut | ds, tk, st |

**Unit `modern-rules`: The Modern Game (2023 to 2026)** (prereq: `the-count`, `on-the-bases`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `mod-01` | The pitch clock | State the 15/18-second clock and the batter rule. | pitch-clock, batter-timer | mc, tt, es, fg |
| `mod-02` | Two pickoffs, then a balk | Explain the disengagement limit. | disengagement-limit | bc, mc, ds |
| `mod-03` | Bigger bases, fewer shifts | Explain 18-inch bases and infield alignment limits. | bigger-bases | ht, mc, bc |
| `mod-04` | The ABS challenge | Explain how an ABS challenge works and who may call one. | abs-challenge, hawk-eye | bc, ds, mc |
| `mod-05` | The zone in numbers | Explain the ABS zone scaled to the batter. | abs-zone | ht, es, mc |
| `mod-06` | DH, ghost runner, three-batter minimum | Explain universal DH, automatic runner, three-batter rule. | universal-dh, three-batter-minimum, roster-limits | mc, tm, ds |
| `mod-07` | Did the rules fix baseball? | Discuss what the changes did without being a know-it-all. | replay-review, managers-challenge, rule-change-effects | mc, ds, tk |

### Layer 3: Enthusiast depth (4 units, 24 lessons)

**Unit `analytics`: Analytics Without the Headache** (prereq: `scoreboard-and-stats`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ana-01` | Beyond batting average | Explain OPS+, wOBA, wRC+ in one sentence each. | ops-plus, woba, wrc-plus | tm, mc, es |
| `ana-02` | WAR, gently | Explain WAR and its limits. | war, replacement-level | mc, ds, es |
| `ana-03` | Pitching beyond ERA | Explain FIP, xERA, BABIP luck. | fip, xera, babip | mc, tm, ds |
| `ana-04` | Statcast in one sitting | Read Statcast terms on a broadcast. | statcast, xba, xwoba, sprint-speed | vi, mc, tm |
| `ana-05` | Defense and running by the numbers | Read OAA, DRS and baserunning runs. | outs-above-average, defensive-runs-saved, baserunning-runs | mc, tm, ds |
| `ana-06` | Analytics versus the eye test | Talk about Moneyball, small samples, regression. | moneyball, sample-size, regression-to-mean | ds, tk, st |

**Unit `front-office`: The Front Office** (prereq: `scoreboard-and-stats`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `front-01` | How MLB is organised | Explain leagues, divisions and interleague. | american-league, national-league, division, interleague | mc, tm, so |
| `front-02` | The farm system | Explain the minors, call-ups, options and the Rule 5 draft. | minor-leagues, prospect, call-up, option, rule-5-draft | so, mc, tm |
| `front-03` | The draft and international signings | Explain the draft, lottery and prospect ranking. | mlb-draft, draft-lottery, international-signing | mc, so, ds |
| `front-04` | Contracts and free agency | Explain arbitration, free agency, opt-outs and no-trade clauses. | free-agency, arbitration, service-time, qualifying-offer, opt-out, no-trade-clause | tm, ds, mc |
| `front-05` | Payroll, tax and trades | Explain the luxury tax, deadline, DFA and rentals. | luxury-tax, payroll, trade-deadline, dfa, waivers, rental | ds, mc, tm |
| `front-06` | The CBA and the lockout | Explain the CBA, lockout versus strike, and the salary-cap fight. | cba, lockout, salary-cap-debate | mc, ds, tk |

**Unit `october-and-history`: October and Baseball's Long Memory** (prereq: `scoreboard-and-stats`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `oct-01` | The 12-team playoff | Order the wild card, division series, LCS and World Series. | wild-card-series, bye, division-series, lcs, world-series | so, mc, ht |
| `oct-02` | Why October is different | Explain short-series variance and the hot hand. | home-field-advantage, hot-hand, short-series-variance | ds, mc, st |
| `oct-03` | Baseball's long memory | Place the dead-ball era, Babe Ruth and the Negro leagues. | dead-ball-era, babe-ruth, negro-leagues, jackie-robinson | mc, so, st |
| `oct-04` | Eras and scandals | Talk about the steroid era without a hot take. | steroid-era, reserve-clause | mc, ds, tk |
| `oct-05` | The Hall of Fame debate | Explain voting, 75 percent and the character clause. | hall-of-fame, bbwaa-vote, character-clause | mc, ds, tk |
| `oct-06` | Droughts and dynasties | Talk about famous droughts ending and dynasties. | curse-drought, dynasty | mc, st, tk |

**Unit `ballpark-culture`: Ballpark Culture and Fan Life** (prereq: `the-game`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cult-01` | Why it is a hangout sport | Explain the rhythm of a game and its rituals. | seventh-inning-stretch, ballpark-rituals | mc, st, fg |
| `cult-02` | Unwritten rules and bat flips | Talk about unwritten rules without taking a side. | unwritten-rules, bat-flip, benches-clearing, beanball | ds, mc, tk |
| `cult-03` | Ballparks with personality | Explain park factors and famous parks. | park-factors, green-monster, wrigley-ivy | mc, vi, ht |
| `cult-04` | Baseball slang | Decode dinger, can of corn, ribbie, Mendoza line. | baseball-slang, mendoza-line | tm, fg, st |
| `cult-05` | Going to a game | Score a game, foul-ball etiquette, arriving, heckling. | scoring-at-the-park, foul-ball-etiquette, heckling | ds, mc, tk |
| `cult-06` | Rivalries and loyalty | Talk about rivalries kindly. | rivalry, fan-loyalty | ds, st, tk |

### Layer 4: Branches and personalization (3 units, 15 lessons)

Branch units (`layer: branch`, unit `branchId`) are shown only when the branch is selected. Shared lessons carry branch-tagged activities (`branchId`) for rules that differ (e.g. `mod-01` for college's 2027 timer; `game-06` for NPB ties). The `mlb` branch has no unit of its own (it is the default course).

**Unit `branch-college`: College Baseball** (branch `college`; prereq: `the-game`, `the-count`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `col-01` | College baseball at a glance | Explain the season, BBCOR bat and conferences. | ncaa-baseball, bbcor-bat, conference-baseball | mc, tm, fg |
| `col-02` | The road to Omaha | Order regionals, super regionals and the College World Series. | regionals-to-omaha, cws | so, mc, ht |
| `col-03` | College versus pro rules | Compare DH, bats, timers and the coming ABS. | college-rule-differences | bc, mc, ds |
| `col-04` | Draft, NIL and the portal | Explain the transfer portal, NIL and draft eligibility. | transfer-portal, nil, draft-eligibility | mc, ds, tm |
| `col-05` | Talking college baseball | Practice conversation about a college team. | convo-college-talk | tk, st, mc |

**Unit `branch-npb`: Nippon Professional Baseball** (branch `npb`; prereq: `the-game`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `npb-01` | NPB at a glance | Explain 12 teams, two leagues and the season. | npb-structure, cl-vs-pl | mc, tm, es |
| `npb-02` | How the game feels different | Explain ties, the 12-inning cap and small ball. | ties-npb, small-ball-npb | mc, bc, ds |
| `npb-03` | Oendan and stadium culture | Explain organised cheering. | oendan | mc, st, li |
| `npb-04` | Climax Series and Japan Series | Order NPB's postseason. | climax-series, japan-series | so, mc, ht |
| `npb-05` | From Japan to MLB | Explain the posting system and the pipeline. | posting-system, foreign-player-limit | mc, ds, tk |

**Unit `branch-kbo`: KBO League** (branch `kbo`; prereq: `the-game`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `kbo-01` | KBO at a glance | Explain 10 teams and the season. | kbo-structure | mc, tm, es |
| `kbo-02` | Bat flips and cheer squads | Explain bat-flip culture and cheerleaders. | bat-flip-culture, cheer-squads | mc, st, li |
| `kbo-03` | KBO rules and ABS | Explain ties, ABS in every park and import limits. | abs-kbo, kbo-imports | bc, mc, ds |
| `kbo-04` | The KBO postseason | Order the KBO playoffs. | kbo-postseason, korean-series | so, mc, ht |
| `kbo-05` | From Korea to MLB | Explain the KBO-MLB pipeline. | kbo-to-mlb | mc, ds, tk |

### Layer 5: Current season / live (1 unit, 5 lessons)

Templates instantiated weekly from live data and editorial (see `live-data.md`); the lessons are shells with `live` hooks, and their exercises are generated from Swoon'd's own explainer text and entity data, never hard-coded scores.

**Unit `season-now`: This Season** (layer `current-season`; prereq: `scoreboard-and-stats`; `live` hook on the unit, `refreshHint` daily in-season). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `live-01` | This week in baseball | Read this week's schedule and yesterday's results with {{team}}. | live-weekly-context | mc, st, tk, fg |
| `live-02` | The race | Read the standings and the wild-card picture. | season-race, magic-number | vi, mc, ds, tk |
| `live-03` | Why is everyone talking about this? | Explain trades, injuries and news in plain words. | transaction-explainer, rule-news-explainer | mc, st, ds, tk |
| `live-04` | Awards and milestones | Understand MVP/Cy Young talk and milestones in progress. | award-season, milestone-watch | mc, st, fg, tk |
| `live-05` | The hot stove | Understand the offseason (free agency, Winter Meetings, CBA news). | hot-stove, cba-news-explainer, season-rollover | mc, ds, tk, st |

### Layer 6: Conversation practice and perpetual review (2 units, 9 lessons)

**Unit `conversation-lab`: Conversation Lab** (prereq: any three foundation units; content grows with mastery). 6 lessons; also feeds the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | Decoding her recap | Respond with curiosity to a game recap. | convo-recap, convo-follow-up-questions | tk, st, mc, fg |
| `talk-02` | The bullpen meltdown | Handle "the bullpen blew it again". | convo-bullpen-talk, bullpen, blown-save | tk, st, ds, mc |
| `talk-03` | She hates the manager | Listen to a rant without piling on. | convo-manager-rant, convo-team-loss | tk, st, ds, mc |
| `talk-04` | At the park | Small talk at a game: what to ask, what to skip. | convo-at-the-park | tk, st, ds, fg |
| `talk-05` | The new rules debate | Talk pitch clock and ABS without lecturing. | convo-rule-change-talk | tk, st, mc, ds |
| `talk-06` | Say-this gauntlet | Decode five lines in a row and admit what you do not know. | convo-admit-what-you-dont-know | st, tk, mc, ds |

**Unit `review-loop`: Perpetual Review** (always available after the first lesson). 3 lesson templates driven by the review policy.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rev-01` | Daily Bite | One card (mc/fg/tm) from due concepts. | (due concepts) | mc, fg, tm, bc |
| `rev-02` | Weekly mix | Three-round session sampled by weakness. | (weak concepts) | mc, bc, ds, tk |
| `rev-03` | Box-score and rules boss | Mastery check on the two most misunderstood areas (force/tag/tag-up and reading a box score). | force-play, tag-up, box-score, infield-fly-rule | SIM `baseball.baserunning.read-and-go.v1` (hard), vi, bc, ds |

**Review policy:** intervals 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; concept below 0.6 re-enters at 1d. Sim results contribute masterySignals with the same weights as native (halved when hints used).

### Concept targets, personalization slots, release plan

- **Concept count target:** see the Appendix (330 ids; `exercises.md` writes the first 72 Playbook entries with definitions and example lines, the rest are authored with each unit).
- **Personalization slots:** `{{team}}`, `{{player}}`, `{{league}}`, `{{skillLevel}}`, `{{region}}` (section 8).
- **Release plan:**
  - **Launch (v0.1 to 1.0):** branch `mlb`; units `the-game` to `scoreboard-and-stats`, `pitching`, `hitting`, `strategy`, `modern-rules`, `conversation-lab`, `review-loop`; sims 1 and 2 (baserunning, alignment) are last in the Astra order.
  - **Fast follow (1.1):** `analytics`, `front-office`, `october-and-history`, `season-now` (live cards), sim 3 (`pitch-shapes`); `college` branch after the college season starts (Feb 2027).
  - **1.2:** `ballpark-culture`, `npb` and `kbo` branches (timed to their seasons, March 2027).
  - **Ongoing:** new `season-now` cards weekly; rule-change refresh each off-season; new talk tracks weekly in-season; a "post-CBA" refresh once the December 2026 situation resolves.
- **Branch pacing note:** a learner never sees all 19 units; the 16 core units plus the chosen branch unit(s).


### Appendix: Playbook concepts (ids)

Each id is first introduced in the unit shown; later lessons reuse it. Total: 330.

`the-game` (28): `game-objective`, `baseball-pace`, `inning`, `half-inning`, `out`, `diamond`, `infield`, `outfield`, `foul-line`, `fair-foul-territory`, `pitcher`, `catcher`, `infielder`, `outfielder`, `position-numbers`, `batting-order`, `leadoff-hitter`, `cleanup-hitter`, `designated-hitter`, `nine-innings`, `walk-off`, `extra-innings`, `automatic-runner`, `home-team-bats-last`, `season-162`, `series`, `games-behind`, `winning-percentage`.

`the-count` (29): `ball`, `strike`, `strike-zone`, `count`, `full-count`, `hitters-count`, `pitchers-count`, `strikeout`, `swinging-strike`, `called-strike-three`, `dropped-third-strike`, `foul-ball`, `foul-tip`, `checked-swing`, `walk`, `hit-by-pitch`, `intentional-walk`, `ground-ball`, `line-drive`, `fly-ball`, `pop-up`, `single`, `double`, `triple`, `home-run`, `ground-rule-double`, `plate-appearance`, `at-bat`, `pitch-sequencing`.

`on-the-bases` (20): `safe`, `tag`, `force-play`, `tag-play`, `advance`, `fielders-choice`, `lead-off`, `stolen-base`, `caught-stealing`, `pickoff`, `balk`, `tag-up`, `sacrifice-fly`, `send-or-hold`, `third-base-coach`, `read-and-go`, `two-outs-running`, `double-play`, `rundown`, `triple-play`.

`the-defense` (20): `covering-bases`, `backing-up`, `error`, `hit-vs-error`, `wild-pitch`, `passed-ball`, `cutoff-man`, `relay-throw`, `infield-fly-rule`, `catcher-duties`, `pitch-framing`, `pitch-calling`, `infield-in`, `double-play-depth`, `no-doubles-defense`, `guarding-the-line`, `outfield-depth`, `range`, `arm-strength`, `gold-glove`.

`scoreboard-and-stats` (26): `line-score`, `box-score`, `earned-run`, `batting-average`, `on-base-percentage`, `slugging-percentage`, `ops`, `rbi`, `era`, `whip`, `win-loss-record`, `save`, `hold`, `quality-start`, `strikeout-to-walk`, `scorekeeping-symbols`, `no-hitter`, `perfect-game`, `cycle`, `triple-crown`, `complete-game`, `shutout`, `standings`, `run-differential`, `magic-number`, `wild-card-race`.

`pitching` (27): `four-seam-fastball`, `sinker`, `cutter`, `velocity`, `curveball`, `slider`, `sweeper`, `changeup`, `splitter`, `pitch-movement`, `tunneling`, `pitch-mix`, `starting-pitcher`, `rotation`, `reliever`, `bullpen`, `closer`, `setup-man`, `opener`, `pitch-count`, `times-through-the-order`, `tommy-john`, `injured-list`, `command`, `stuff`, `spin-rate`, `pitchers-duel`.

`hitting` (25): `contact-hitting`, `power-hitting`, `plate-discipline`, `chase-rate`, `whiff`, `exit-velocity`, `launch-angle`, `barrel`, `hard-hit`, `pull-hitter`, `opposite-field`, `spray-chart`, `situational-hitting`, `two-strike-approach`, `bunt`, `sacrifice-bunt`, `squeeze-play`, `productive-out`, `platoon-advantage`, `switch-hitter`, `lefty-righty-split`, `five-tool-player`, `three-true-outcomes`, `lineup-construction`, `protection`.

`strategy` (17): `pinch-hitter`, `pinch-runner`, `defensive-replacement`, `double-switch`, `matchup-pitching`, `leverage`, `save-situation`, `pitching-around`, `first-base-open`, `hit-and-run`, `delayed-steal`, `steal-break-even`, `defensive-shift`, `shift-restrictions`, `win-expectancy`, `the-book`, `analytics-vs-gut`.

`modern-rules` (13): `pitch-clock`, `batter-timer`, `disengagement-limit`, `bigger-bases`, `abs-challenge`, `hawk-eye`, `abs-zone`, `universal-dh`, `three-batter-minimum`, `roster-limits`, `replay-review`, `managers-challenge`, `rule-change-effects`.

`analytics` (18): `ops-plus`, `woba`, `wrc-plus`, `war`, `replacement-level`, `fip`, `xera`, `babip`, `statcast`, `xba`, `xwoba`, `sprint-speed`, `outs-above-average`, `defensive-runs-saved`, `baserunning-runs`, `moneyball`, `sample-size`, `regression-to-mean`.

`front-office` (27): `american-league`, `national-league`, `division`, `interleague`, `minor-leagues`, `prospect`, `call-up`, `option`, `rule-5-draft`, `mlb-draft`, `draft-lottery`, `international-signing`, `free-agency`, `arbitration`, `service-time`, `qualifying-offer`, `opt-out`, `no-trade-clause`, `luxury-tax`, `payroll`, `trade-deadline`, `dfa`, `waivers`, `rental`, `cba`, `lockout`, `salary-cap-debate`.

`october-and-history` (19): `wild-card-series`, `bye`, `division-series`, `lcs`, `world-series`, `home-field-advantage`, `hot-hand`, `short-series-variance`, `dead-ball-era`, `babe-ruth`, `negro-leagues`, `jackie-robinson`, `steroid-era`, `reserve-clause`, `hall-of-fame`, `bbwaa-vote`, `character-clause`, `curse-drought`, `dynasty`.

`ballpark-culture` (16): `seventh-inning-stretch`, `ballpark-rituals`, `unwritten-rules`, `bat-flip`, `benches-clearing`, `beanball`, `park-factors`, `green-monster`, `wrigley-ivy`, `baseball-slang`, `mendoza-line`, `scoring-at-the-park`, `foul-ball-etiquette`, `heckling`, `rivalry`, `fan-loyalty`.

`branch-college` (10): `ncaa-baseball`, `bbcor-bat`, `conference-baseball`, `regionals-to-omaha`, `cws`, `college-rule-differences`, `transfer-portal`, `nil`, `draft-eligibility`, `convo-college-talk`.

`branch-npb` (9): `npb-structure`, `cl-vs-pl`, `ties-npb`, `small-ball-npb`, `oendan`, `climax-series`, `japan-series`, `posting-system`, `foreign-player-limit`.

`branch-kbo` (8): `kbo-structure`, `bat-flip-culture`, `cheer-squads`, `abs-kbo`, `kbo-imports`, `kbo-postseason`, `korean-series`, `kbo-to-mlb`.

`season-now` (9): `live-weekly-context`, `season-race`, `transaction-explainer`, `rule-news-explainer`, `award-season`, `milestone-watch`, `hot-stove`, `cba-news-explainer`, `season-rollover`.

`conversation-lab` (9): `convo-recap`, `convo-follow-up-questions`, `convo-bullpen-talk`, `blown-save`, `convo-manager-rant`, `convo-team-loss`, `convo-at-the-park`, `convo-rule-change-talk`, `convo-admit-what-you-dont-know`.

`review-loop` (0): .

---

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4): Unity only where spatial reasoning, movement, physics, timing in a scene, or camera perspective materially improves learning and a native exercise would teach it clearly worse. Baseball is mostly *knowledge and judgment over static situations* (count, outs, runners, score), which native `decision-scenario` handles well; only three concepts need to be seen moving.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| `base-06`, `rev-03`: Read it and go | send-or-hold, tag-up, two-outs-running, third-base-coach, read-and-go, sacrifice-fly | `unity-sim` `baseball.baserunning.read-and-go.v1` (spec `sims/baseball.baserunning.read-and-go.v1.md`) | Rubric: **movement over time and timing in a scene**: a runner's decision is a *race* between his speed and a throw whose flight time depends on where the ball was fielded and who has the arm. Closest native: `decision-scenario` with a facts table (arm rating, distance); it teaches the heuristic ("tag up on a deep fly with less than two outs") but cannot let the learner see the throw arrive half a step late, which is what fans mean by "he was thrown out by a mile". Native `bc`/`ds` still teaches the static rules in `base-01` to `base-05`. | A | 1 sim, 12 scenarios |
| `def-06`: Where do they stand? | infield-in, double-play-depth, no-doubles-defense, guarding-the-line, outfield-depth | `unity-sim` `baseball.defense.alignment-read.v1` | Rubric: **spatial reasoning**: alignment is a picture (depth, angles, lines), and the payoff shows only when the ball is hit into the gap you left. Closest native: `hotspot-tap` on a standard-alignment diagram (used in `game-04`, `mod-03`) teaches names, not trade-offs. | A | 1 sim, 12 scenarios |
| `pit-03`: Reading the pitch | pitch-movement, tunneling, velocity, four-seam-fastball, slider, curveball, changeup, abs-zone | `unity-sim` `baseball.pitching.pitch-shapes.v1` | Rubric: **physics and camera perspective**: break, spin and tunneling are only visible in motion from the hitter's view; a diagram or photo shows one frame. Closest native: `visual-id` on original art teaches pitch *names* (`pit-01`, `pit-02`). Fallback native lesson `pit-03-native`. | A | 1 sim, 12 scenarios |
| Field map, positions, box-score reading, batter's zone | diamond, position-numbers, box-score, strike-zone | `hotspot-tap` (procedural diagrams `baseball-diamond`, `box-score-sample`, `strike-zone`) | Fixed diagram, no motion (native catalog `hotspot-tap`). | B | ~50 |
| Rule calls (foul or fair, force or tag, is the infield fly on, ABS in or out) | force-play, infield-fly-rule, foul-ball, abs-challenge | `binary-call` | Two-way judgment on a static situation. | B | ~80 |
| Manager decisions (walk him? pinch-hit? bunt?) and rules-in-context | intentional-walk, sacrifice-bunt, leverage, save-situation | `decision-scenario` with facts (inning, outs, runners, score, handedness) | Judgment with consequences and an expert note; the situation is a state, not motion. | B | ~90 |
| Vocabulary, stats definitions, slang | ERA, OBP, dinger, ribbie | `term-match`, `fill-the-gap`, `multiple-choice` | Recall and recognition. | B | ~250 |
| Ordering (a plate appearance, the postseason, scorekeeping) | plate-appearance, wild-card-series, scorekeeping-symbols | `sequence-order` | Order is the concept. | B | ~30 |
| Pitch-type, park and field recognition (original illustrations) | four-seam-fastball, slider, green-monster | `visual-id` (procedural or original vector art, `original-swoond`) | Recognition; no photos. | B | ~35 |
| Pitch-clock feel; swing timing; stealing a base rhythm | pitch-clock, delayed-steal | `timing-tap` | 1D timing bar suffices ("Simple 1D timing bar: No Unity", CLAUDE.md rubric). | B | ~10 |
| Magnitudes (90 feet, 15 seconds, 162 games, 53.5 percent) | season-162, pitch-clock, abs-zone | `estimate-slider` | Numeric intuition. | B | ~25 |
| Sounds of the ballpark (bat crack vs clank, crowd, umpire signals as words) | bbcor-bat, oendan | `listening-id` (original recordings or synthesised, `original-swoond`; skip option always) | The *sound* of a barrel and the sound of a metal bat are an experience; college and NPB/KBO cheering are audio-driven. | B | ~8 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice (Talk tab and unit ends). | B | 24 talk tracks + ~80 say-this |

All 13 native types and `unity-sim` are used. Accessibility fallback: each sim has a native fallback lesson (a designed `decision-scenario`/`hotspot-tap` set) named in its spec section 16 (`base-06-native`, `def-06-native`, `pit-03-native`).

---

## 13. Licensing & safety

**Licensing (spec sections 39-40 and rule 10):**

| Area | Handling |
|---|---|
| Imagery | Procedural or original illustrations (`original-swoond`) only. No MLB, team or player photos, no ballpark photography, no baseball-card images. |
| Logos / trademarks | MLB, the 30 team names and marks, "World Series", "Statcast", "Gold Glove", "Hall of Fame" (institution), NCAA, "College World Series", NPB, KBO and team marks are trademarks: **plain-text mentions and link-outs only**; no logos, wordmarks or colours-as-branding in lesson art. Team names as facts, with a non-affiliation footer. |
| Audio | Original recordings or synthesised only (bat crack, crowd, glove pop, organ-style stings created in-house). No broadcast audio, no licensed songs; "Take Me Out to the Ball Game" (1908) is public domain, but recordings and arrangements are not: text only. |
| Video | No embedded broadcast or highlight video; deep-link to official sources. MLB clips are licensed content: link out only. |
| Data terms | MLB Stats API (`statsapi.mlb.com`) and Baseball Savant are MLB Advanced Media properties with non-commercial or restricted terms: **not used in production without a licence**; FanGraphs and Baseball-Reference are link-out only (terms forbid scraping). Retrosheet requires its attribution notice; Lahman database is CC BY-SA 3.0 (share-alike implications for any derived database, legal check needed); Chadwick Bureau register is openly licensed with attribution [verify]. NCAA statistics and D1Baseball rankings are link-out only. |
| Article text | Never copy publisher text; paraphrase and link (spec section 11). |
| Player likeness | Names as facts only; no likenesses, endorsements, or invented quotes. Historical figures (e.g. Jackie Robinson) are discussed factually and respectfully; no fabricated speech. |
| Sensitive content | Baseball history includes segregation, labour disputes, PED scandals and player deaths/injuries. Use factual, respectful copy; the `oct-03` to `oct-05` lessons are reviewed for sensitivity before release. Gambling: no betting content; Pete Rose/gambling is mentioned only as a factual Hall of Fame governance topic. |

**Safety:** Baseball is not a high-risk subject for the learner. Constraints (also in the manifest): generic, conservative youth-baseball notes only (pitch counts and rest days are taught as league safety rules, not medical advice); Tommy John surgery and arm injuries are explained as context, never as a "will he be OK?" prediction; never coach confrontation with umpires, opponents or fans; heckling lessons teach good-natured cheer only; foul-ball awareness at the ballpark is a safety note ("watch the ball, look up when the crowd shouts, children away from the dugout side"); never encourage faking knowledge with the person she cares about.

---

## 14. Content assets

| Asset | Source | Notes |
|---|---|---|
| Field diagram (`baseball-diamond`), positions overlay, strike-zone diagram (`strike-zone`), box-score art (`box-score-sample`, `line-score-sample`), scorecard art, standings table art | Procedural diagrams drawn natively (SwiftUI) from coordinate data in feet; license `original-swoond` | Coordinates: x across from third-base side (negative) to first-base side (positive), y from home plate toward center field; see sim specs section 6 |
| Pitch-type illustrations (grips, flight arcs) | Original vector art, `original-swoond` | `visual-id` |
| Ballpark illustrations (stylised Green Monster, ivy wall) | Original vector art; no photos | Generic "park with a tall left-field wall" allowed |
| Audio: bat crack, metal-bat ping, glove pop, crowd, cheer chants (NPB/KBO style, original) | Synthesised or recorded in-house | Cheer chants must be new melodies, not team fight songs |
| Unity: field, mound, bases, 9 fielders, runner, ball, ABS zone frame | Procedural low-poly, `original-swoond`, no team colours | Per sim spec section 18 |

Every image/audio asset carries a `license` id (`original-swoond`).

---

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. **What does a beginner need to understand?** The count, force versus tag, how runs score, the scoreboard and box score, positions, and pitch types (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Bullpens, managers' decisions, lineups, the standings race, prospects, trades, money and the CBA, umpires and ABS, analytics vs eye test, ballpark culture (section 4).
- [x] 3. **What current information matters?** Schedule and yesterday's result, standings and wild-card picture, transactions and injuries, postseason bracket, rule changes, the CBA/lockout situation (section 6).
- [x] 4. **What should be interactive?** Three sims (baserunning, alignment, pitch shapes) plus native decision-scenarios for manager calls, hotspot-tap on diagrams, and conversation practice (section 5, 12).
- [x] 5. **What should NOT be gamified?** History, injuries, labour disputes, betting (none), any mockery of fans (section 5).
- [x] 6. **How should it personalize?** Team, player, league (branch), region, skill level (section 8).
- [x] 7. **What does conversational competence look like?** She decodes a recap, asks about the bullpen or lineup, and follows the game (sections 9, 10).
- [x] 8. **What data providers are needed?** TheSportsDB to start; Sportradar/SportsDataIO upgrade; curated rules and CBA editorial; no MLB Stats API in production without licence (section 6, `live-data.md`).
- [x] 9. **What licensing constraints apply?** Section 13.
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, talk-track "smooth" score, and conversation-lab completion (section 10).

Additional gates: [ ] manifest validates; [ ] curriculum validates (curriculum not authored yet); [ ] every Unity sim has an approved spec (three `spec-draft`); [ ] every image/audio asset has a license id; [ ] voice review (cheeky coach, never mean, never about the crush); [ ] no copied publisher text; [ ] 2026-rule facts re-verified (section 16 and NOTES).

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | The December 1 2026 CBA expiry is expected to produce a lockout; when it does, `season-now` and `front-06` need a neutral, dated explainer. Ship `front-06` before or after the CBA outcome? Recommendation: ship after the first week of December with a dated card, evergreen definitions before. | Product | No |
| 2 | Provider and licence for MLB data (TheSportsDB coverage of MLB; Sportradar or SportsDataIO upgrade; MLB Stats API terms). Overlaps L-02. | Product / Data | Blocks the live layer only |
| 3 | Unit count is 19 (16 core plus 3 branch units), above the 8-14 guidance (P-04 pattern). Approve, or fold `ballpark-culture` into `october-and-history` and drop `analytics` to 4 lessons? | Product | No |
| 4 | Branch roll-out: `college` (v1.1) and `npb`/`kbo` (v1.2) timing vs the seasons; whether NPB and KBO should be a single "Asia" branch. Recommendation: two branches, separate units, shared `asia-crossover` talk track. | Product | No |
| 5 | Lahman database licence (CC BY-SA 3.0) share-alike impact on any derived Swoon'd dataset; Retrosheet notice text. | Legal | No |
| 6 | Baseball SME review of the three sim reference models (runner speed, throw times, alignment outcome table, pitch flight). Recommendation: one pass before `spec-approved`. | Product / SME | Yes for sim approval |
| 7 | Whether to teach the "Manfred runner" name (commissioner's name) or only "automatic runner". Recommendation: teach "automatic runner", mention "ghost runner" and "Manfred runner" as the nicknames fans use. | Content | No |
| 8 | 2026 facts to re-verify before release (see NOTES): ABS challenge details (2 challenges, extra innings), pitch clock, pickoff limit, mound visits, postseason results, division winners, NCAA ABS 2027, NPB/KBO 2027 rule changes, CBA developments. | Content | Yes before release |
| 9 | Voice review: which mild in-jokes about specific teams (Cubs' drought, Yankees payroll) are allowed? Recommendation: light, historical, never about a current player or the learner's team; product owner voice-passes a sample. | Product | No |
| 10 | Sim `baseball.pitching.pitch-shapes.v1` needs a `PitchFlight` primitive (spin-based flight); may not be worth building before the other two. Astra to size. | Astra | No |
