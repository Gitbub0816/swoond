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
