# Course Design Specification: Hockey (`hockey`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Rules baseline: NHL 2026-27 (verified 2026-09-30) with labelled PWHL and international differences. The design file's "Hockey Talk Track" tone is reused: cheeky coach, warm, never about the crush.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 1 |
| Author / date | Swoon'd content team (Claude), 2026-09-30 |
| Manifest | `manifest.json` |
| Size | 16 units, 113 lessons, 123 Playbook concepts, 6 Unity sims, 32 talk tracks |

---

## 1. Identity
- **Course ID:** `hockey` (immutable; the catalog's id for the ice hockey course)
- **Display name:** Hockey (ice hockey)
- **Category / family:** Sports > Hockey; family `Sports`
- **Simulation prefix:** `hockey` (sim ids look like `hockey.rules.offside-read.v1`)
- **Rules baseline:** NHL rules as of the 2026-27 season (verified 2026-09-30), with labelled PWHL and international (IIHF/Olympic) differences.

**Related courses & boundary test (spec section 6)**

| Related interest | If someone learns hockey, are they meaningfully conversationally competent about it? | Verdict | Consequence for course structure |
|---|---|---|---|
| Soccer (`soccer`) | No. "Offside", "penalty" and "expected goals" share words but not rules (soccer offside is about the last defender and involvement in play; hockey offside is about the blue line and skates). The invasion-sport intuition (space, possession, shot quality) transfers only a little. | adjacent | Separate courses. Cross-link concepts: offside, expected goals, penalty. The hockey offside lesson explicitly warns about the soccer mental model. |
| Basketball (`basketball`) | No. Line changes vs substitutions, and the best-of-seven playoff series share vocabulary but the game itself does not transfer. | adjacent | Separate. Cross-link playoff series (best-of-seven) and analytics culture. |
| American Football (`american-football`) | No. Shared ideas (special teams, coach's challenge, clock) are shallow; rules, positions and rhythm differ. | sibling-independent | Separate. Cross-link coach's challenge. |
| Baseball (`baseball`) | No. | sibling-independent | Separate. Cross-link best-of-seven and series lingo only. |
| Field hockey, figure skating, curling (not in catalog) | No: different sports. Hockey competence does not make her curling conversation possible. | independent | Not planned; if requested they enter the catalog process, not this course. |

**Branches** (all personalize through the `league` dimension; the learner's crush usually implies one)

| id | name | what changes (rules, data, culture) |
|---|---|---|
| `nhl` | NHL (default) | 32 teams, an 84-game season starting 2026-27 (was 82), four divisions, 16-team playoffs, 5-minute regular-season 3-on-3 overtime then a best-of-three shootout, fighting still allowed as a five-minute major, visors and now mandatory neck protection for players with no prior NHL games, hard salary cap ($104M ceiling in 2026-27), the Stanley Cup. |
| `pwhl` | PWHL | Twelve teams in 2026-27 (Boston, Minnesota, Montreal, New York, Ottawa, Seattle, Toronto, Vancouver plus new Detroit, Hamilton, Las Vegas, San Jose), full cages mandatory, 3-2-1-0 points, best-of-five shootout, the jailbreak rule, different intermissions, the Walter Cup (Montreal Victoire won in 2026), a fan culture built around intimate crowds and player access. |
| `international` | International (IIHF, Olympics, Worlds, World Juniors, best-on-best) | IIHF rulebook, big-ice traditions, national-team identity, Olympic and Worlds formats. The 2026 Olympics ended with U.S. overtime wins over Canada in both the women's and men's gold medal games. |

## 2. Beginner model

**What a complete beginner typically knows.** Ice, sticks, a puck, goalies with big pads, fighting, the penalty box, the Zamboni, the Stanley Cup exists, maybe one famous name (Gretzky, Crosby, Ovechkin, Connor McDavid) and that Canada cares a lot. Many know the Miracle on Ice as a movie plot rather than a rule set.

**Terminology that will initially confuse them.** Icing (sounds like a cake), offside (soccer meaning), power play ("a play?"), line (as in forward line), shift, the point (a spot and also a standings unit), man advantage, empty netter, pulling the goalie, top shelf, five-hole, wraparound, dump-and-chase, cycle, forecheck, backcheck, regulation win, loser point, wild card, LTIR, cap hit, Corsi, PDO, expected goals, chirping, biscuit.

**Common misconceptions**
1. *"Hockey is basically fighting."* Fights per game have fallen sharply; the PWHL and international hockey treat fighting as a punishable offense, and most fans care about the game far more than the fights.
2. *"Offside means he was already in the zone."* Offside is about the blue line and the puck: both skates completely over the leading edge of the blue line before the puck fully crosses. A skate touching the line keeps a player onside, and involvement in the play is irrelevant. (Soccer instincts make this worse.)
3. *"Icing is a penalty."* It is a stoppage, not a penalty: no power play. The cost is that the team that iced cannot change players and must defend the faceoff in its own zone.
4. *"A power play lasts two minutes."* A minor ends early when the power-play team scores; a major does not.
5. *"An overtime loss is a tie."* It is a loss that earns one standings point (NHL) or one point in the PWHL's 3-2-1-0 system; hence the loser-point debate.
6. *"More shots means better play."* Volume is not quality: shots from the slot are far more dangerous than from the perimeter (expected goals, Corsi versus shot quality).
7. *"The goalie gets scored on so the goalie is bad."* Save percentage depends on shot quality; goals-against average depends on the defense in front.
8. *"You can only change players during a stoppage."* Lines change on the fly constantly; that is why a bad change (too many men) is a penalty.
9. *"The regular-season winner gets the Stanley Cup."* The Cup goes to the playoff champion; the regular-season best record gets the Presidents' Trophy.
10. *"The PWHL is just a lesser NHL."* It plays a different rulebook (jailbreak rule, full cages, different shootout) with its own culture. Treat it as its own league, not a lesser version.
11. *"It's the third quarter."* Hockey has three periods and intermissions, not quarters or halves.

**Concepts that unlock the rest (become the foundation units).** The rink and zones; the clock and how play restarts; offside and icing (the two rules that stop play and confuse everyone); penalties and the power play; positions and lines; points, overtime and the playoff path.

## 3. Foundational knowledge

Modules (each becomes a `foundationalModules[]` entry and a foundation unit):

| Module (unit id) | Contents |
|---|---|
| The Game on Ice (`game-on-ice`) | Rink and zones (200 x 85 ft, blue lines, crease, faceoff circles); three 20-minute periods, stop clock, intermissions; faceoffs; goals, shots, saves, assists, hat trick, shutout; line changes and too many men; stoppages; pulling the goalie. |
| The Rules That Cause Arguments (`rules-of-play`) | Offside (leading edge, skates vs puck, delayed offside and tag-up), icing (hybrid icing, exceptions), review and coach's challenge, crease and goalie interference. |
| Penalties and Special Teams (`penalties-specialteams`) | Minors, double minors, majors, misconducts, match penalties; stick fouls and contact fouls; power play, penalty kill, 5-on-3, 4-on-4, penalty shots, embellishment. |
| Who Plays Where (`lines-positions-roles`) | Center, wing, defense, goalie; forward lines and D pairs; captains and alternates; healthy scratches; player types (sniper, grinder, enforcer, playmaker). |
| Equipment, participants, organizations (woven into units 1 and 4) | Skates, sticks, helmets, cages and visors, neck guards; NHL, NHLPA, PWHL, IIHF, USA Hockey and Hockey Canada; officials: two referees and two linesmen in the NHL; what the Department of Player Safety does. |
| History and culture (woven into unit 10) | Original Six, expansion, the Miracle on Ice, Gretzky and Orr era, modern stars, rivalries and traditions. |

## 4. Enthusiast model

**What enthusiasts actually talk about.** Their team's power play and penalty kill; the goalie ("standing on his head", "leaky"); who is on the top line versus the depth lines; last change and line matching; the trap or the forecheck; special teams percentages; expected goals and Corsi; the deadline; the cap and LTIR; the draft lottery and prospects; officiating (goalie interference, offside challenges); hits and suspensions; playoff series (Game 7, home ice, "we're up 3-1"); rivalries and Original Six nights; the PWHL's growth; Olympic and Worlds memories.

**Distinctions that matter to them**
- Volume versus quality: Corsi (attempts) versus expected goals (quality).
- Luck versus skill: PDO, shooting percentage, goalie save percentage.
- Even strength versus special teams (5-on-5 driving play vs power play).
- Minor versus major versus misconduct.
- Cap hit versus actual salary; rental versus long-term contract.
- Regulation win versus overtime win (tiebreakers).
- Forecheck shapes: 1-2-2, 2-1-2, left-wing lock.
- Power play formations: 1-3-1, umbrella, overload; kill formations: box, diamond.

**Knowledge that signals genuine understanding**
- Saying "they can't change after icing" without prompting.
- Knowing offside is decided by the skates and the puck, not involvement.
- Asking whether the power play struggles on the entry or the setup.
- Reading a shot-quality comment ("lots of shots, mostly from the perimeter") correctly.
- Knowing what a rental is and why a cap hit matters.
- Distinguishing goals-against average from save percentage.

**Beginner statements that sound obviously uninformed** (and what to say instead)

| Uninformed | Why it sounds off | Better |
|---|---|---|
| "That was a touchdown!" | Wrong sport. | "What a goal." |
| "It's the third quarter." | Hockey has periods. | "It's the third period." |
| "He shot the ball." | It is a puck. | "He shot the puck." |
| "That's offside because he was in the zone first." | Offside is about the puck and blue line. | "He was over the line before the puck." |
| "Icing is a penalty, right?" | It's a stoppage, not a penalty. | "They iced it, so they can't change." |
| "They lost so they got zero points." | There is a loser point in the NHL. | "They got the point for getting to overtime." |
| "Why don't they just fight more?" | Misunderstands the sport. | "How does the league feel about fighting these days?" |
| "The goalie is bad; he let in five." | Ignores the shot quality and defense. | "How many high-danger shots did he face?" |

**Common controversies and debates**
1. **Fighting**: keep it (deterrence, tradition) or remove it (safety, decline of enforcers).
2. **The loser point**: rewards overtime and distorts standings; some want 3-2-1-0 as in the PWHL.
3. **Overtime and shootouts**: 3-on-3 is thrilling, but is the shootout a gimmick?
4. **Analytics versus the eye test**: Corsi, xG and PDO against what the game looks like.
5. **Player safety and hits**: head contact, suspension consistency, mandatory neck protection (new for players with no prior NHL games in 2026-27).
6. **Goalie interference and offside review**: how tight should challenges be; the "inches" problem.
7. **When to pull the goalie**: data says earlier than tradition.
8. **Tanking and the lottery**; expansion and dilution; the 84-game season and workload.
9. **The trap and the fun police**: defensive systems versus entertainment.
10. **The cap and LTIR games**; the new CBA's contract-length limits and the ban on deferred salary.
11. **The PWHL's growth**: expansion pace, player pay, arenas, the relationship with the NHL.
12. **NHL at the Olympics and best-on-best events.**

## 5. Interaction model

**What the learner should experience instead of reading**
- *See and call it:* offside, icing, line changes and coverage are things you judge as they happen, so they get Unity minigames from the linesman's or coach's seat.
- *Judge the situation:* pulling the goalie, last change, deadline moves, challenges are decision scenarios with consequences.
- *Decode fan talk:* say-this and talk-track exercises are the heart of the course.
- *Recognize:* rink markings, referee signals, formations through visual-id and hotspot-tap.
- *Sequence and compare:* playoff path, icing consequences, a rush, the prospect pipeline.

**Does the course warrant Unity?** Yes, for six things where seeing motion in space or time is the concept: offside reading, icing races, power play spacing, forecheck reading, line change timing, defensive-zone coverage. Everything else is native (rubric in `CLAUDE.md`). The design file's hockey demo (Talk Track) is a native `talk-track`; "Offside?" in the design's future list is upgraded to a real Unity sim because a still drag misses the perspective.

**What should NOT be gamified**
- Fighting and head injuries: explained with care; no scoring of hits, no gore.
- Player personal lives, injuries as entertainment, and anything about betting or fantasy odds: excluded.
- Rivalries as insults: taught as history and fun, never as tribal contempt.
- Cap and contracts: explained in plain language; never framed as gambling on trades.

**Chosen mix (details in section 12):** ~40% native recall/understanding (multiple-choice, term-match, fill-the-gap, estimate-slider, binary-call), ~25% decoding and conversation (say-this, talk-track), ~15% judgment (decision-scenario, sequence-order), ~10% recognition (visual-id, hotspot-tap), and 6 Unity sims for the spatial/timing concepts (about 10% of learner time).

## 6. Dynamic information requirements

Hockey is a strong live-data course (structured data and editorial are separate systems; spec sections 10-12 and 32-37). Detail in `live-data.md`. Not every kind is needed; those not needed are stated.

| Kind | Needed? | Why | Provider candidates (always behind a Swoon'd adapter) | Refresh | Fallback when provider is down |
|---|---|---|---|---|---|
| scores | Yes | "What's the score?" is the first conversation; live companion in the season layer | TheSportsDB (starter); Sportradar / SportsDataIO (upgrade path) | minutes-during-events | Show last known final scores with an "as of" time; hide the live companion card |
| schedules | Yes | Next game for her team; when to watch together | TheSportsDB; league schedule as licensed data | daily | Cached schedule for the season is stored on device |
| standings | Yes | Playoff race, wild card, points, regulation wins | TheSportsDB; Sportradar / SportsDataIO | daily (hourly on game days late in the season) | Last standings with a timestamp; lessons still work with static examples |
| statistics | Limited | Team and player basics (goals, points, save percentage, power play %). No deep advanced-stat feed at launch | TheSportsDB (basic); enterprise upgrade for advanced stats (Corsi, xG) | daily | Skip the card |
| rosters | Yes (limited) | Who is on her team, who is injured; drives `{{player}}` examples | TheSportsDB; Sportradar | daily | Static default roster names off |
| events | Yes | Draft, lottery, trade deadline, free agency, playoffs, outdoor games, All-Star, Olympics/Worlds | League schedule pages as links; TheSportsDB events | seasonal | Static calendar template |
| news | Yes | Editorial context (section 7): why a trade, a call or a slump matters | Licensed news API (open question Q-3) | hourly | Explainer templates without live headline |
| rankings | No | Media power rankings are opinion and licensing-heavy | - | - | - |
| weather, closures, alerts, conditions | No | Indoor sport; no environmental data value | - | - | - |
| releases, new-products, new-media | No | Not applicable to hockey | - | - | - |

**PWHL and international data.** PWHL is a young league; a mainstream provider may not cover it yet. Plan: adapter behind the same interface; use whatever licensed feed exists; otherwise show static PWHL content and links until coverage exists (open question). International tournaments (Olympics, Worlds, World Juniors) are events with tournament-window refresh, not season-long feeds.

**Unofficial APIs are not used in production** (`CLAUDE.md`): the leagues' public-facing stats endpoints are undocumented and are not a licensed source.

## 7. Editorial context

- **What commentary helps the learner understand current discussion:** why a trade was made and what a cap hit means; why a goal was waved off; why the power play is failing; why a coach pulled the goalie early; what an injury means for the depth chart or the cap (LTIR); why fans are angry about a suspension or the schedule; what the playoff race requires.
- **Appropriate sources:** the NHL and PWHL news pages, team sites and national outlets as headline/link sources, with licensed news data via an adapter (Q-3). We never pull article bodies.
- **Summarize, explain, or link?** Explain in our own words and link to the original. Summary only of publicly announced facts (a trade happened: player A to team B for pick C). Never copy publisher text.
- **Licensing restrictions:** no article text, no publisher photos, no video highlights embedded; link out only.
- **Example prompts:** "Why are fans talking about this today?"; "Why does this trade matter?"; "Why was that goal waved off?"; "What does 'cap space' change?"; "What is she worried about before Game 7?"; "Why is the power play a big deal tonight?"

## 8. Personalization

| Dimension | How it changes examples and live context | Default when unset | Units using `{{tokens}}` |
|---|---|---|---|
| `team` | Team identity, rivalries, roster, standings position, next game. Examples in the personalization unit and live cards use `{{team}}`. | "the team" (generic) / league-wide featured game | `nhl-and-your-team`, `season-live`, `conversation-practice` |
| `player` | Player profile, role, storylines; `{{player}}` appears in fan-talk and say-this items. | "the star" / a league-wide star of the week | `nhl-and-your-team`, `season-live` |
| `league` | Branch selection: NHL, PWHL or international. Determines rule labels, standings format and the live feed. | NHL | `pwhl-branch`, `international-branch`, all rule-difference items |

The default value (used when the person has not chosen) is NHL, no team, no player. Every authored sentence with a token reads correctly with these defaults ("the team scored in overtime"). Foundations stay valid; personalization only changes examples and the live layer.

## 9. Conversation model

**What an enthusiast might naturally say** (translation, implied terminology, and a meaningful next question)

| # | She says | What it means | Terms implied | A meaningful follow-up |
|---|---|---|---|---|
| 1 | "Our power play is a disaster. Zero for fourteen." | Her team has failed on 14 straight man-advantage chances. | power play, special teams % | "Is it the zone entry or the setup?" |
| 2 | "He's standing on his head tonight." | The goalie is making impossible saves. | goalie, save | "How many shots has he faced?" |
| 3 | "They iced it four times and the top line is dead." | Repeated icing left tired players out; the icing team can't change. | icing, line change | "Did the coach use the timeout?" |
| 4 | "That goal got waved off for goalie interference. Robbed!" | A goal was disallowed because an attacker impaired the goalie. | crease, challenge | "Did they challenge it?" |
| 5 | "Their Corsi is great but they keep losing." | They out-attempt opponents but score less; maybe bad luck. | Corsi, PDO | "So is the shot quality poor or the goalie?" |
| 6 | "Game 7 tomorrow. I won't sleep." | A tied best-of-seven series decides tomorrow. | best-of-seven, home ice | "Do you have home ice?" |
| 7 | "They traded a rental for a pick." | A player on an expiring contract was sold for a draft selection. | rental, cap hit, draft pick | "Is he a free agent in July?" |
| 8 | "Too many men on the ice. In overtime!" | A bench minor from a bad change gives the other team a power play. | too many men, bench minor | "Long change or short change?" |
| 9 | "We're a point out with a game in hand." | One point outside a playoff spot but with one fewer game played. | points, wild card | "Who's the game in hand against?" |
| 10 | "The third line scored, thank God." | A depth line produced goals when the stars did not. | lines, depth | "Who's on that line?" |
| 11 | "Jailbreak! Penalty's over." (PWHL) | A shorthanded goal frees the penalized player. | jailbreak rule | "Is that a PWHL-only rule?" |
| 12 | "It's an Original Six night." | Two of the pre-1967 teams are playing. | Original Six | "Which two, and what's the history?" |
| 13 | "They pulled the goalie with two minutes left and it worked." | The trailing team used an extra attacker and scored. | extra attacker, empty net | "Do you think they should pull earlier?" |
| 14 | "Still not over that Olympic overtime." | A gold medal game that went to overtime. | 3-on-3, Olympics | "The women's or the men's?" |

**How Swoon'd helps without encouraging fake expertise.** The learner is taught to understand and to ask, not to recite. Talk tracks reward honest curiosity ("Wait, what makes a power play a big deal?" scores well); every say-this carries follow-up questions and, where guessing would be tempting, a `noFakeExpertNote`. The coach never supplies a line that pretends knowledge the learner does not have. The premise stays finding common ground, not faking it.

**Targets.** 32 standalone talk tracks (11 drafted in `exercises.md`), one per conversational situation, including branch and team tracks; about 126 say-this items across enthusiast, live and review layers.

## 10. Assessment

**How useful competence is determined.** Concept mastery (0..1 per concept) driven by native exercise results and Unity mastery signals; a concept is Mastered at or above the pass threshold. The course also tracks *conversation readiness*: say-this decode rate and talk-track Smooth scores on recent items.

**The learner should be able to**
- *Recognize:* the rink lines and zones, referee signals, a power play formation, an offside entry, an icing call.
- *Understand:* why offside and icing exist, why the power play is a big advantage, what points and playoffs mean, what a cap hit is.
- *Explain:* to a friend in one or two sentences what offside is, what a power play is, why a goalie is pulled.
- *Correctly interpret:* fan lines like "zero for fourteen on the power play", "standing on his head", "a point out with a game in hand".

**Mastery model.** `concept-mastery-v1`, pass threshold **0.80**; review policy `leitner-boxes-v1` with intervals [1,3,7,14,30,60] days, at most 12 items per review session, mastery decay after 45 days without review.

**Useful competence statement.** "After this course she can follow a game with a hockey fan, understand why the power play, a penalty or a review call matters, decode the talk around it, and ask a genuinely curious follow-up without pretending to be an expert."

## 11. Curriculum map (ongoing course)

Designed as an ongoing course: 16 units and 113 lessons at launch scope, with the live layer and seasonal content shipping continuously. Lesson ids are stable kebab-case; `conceptIds` are Playbook entries (see `exercises.md` section 3). Activity names are native exercise types (`docs/native-exercises/CATALOG.md`) or `unity-sim` with the simulation id (`sims/<id>.md`). Estimated 4-8 minutes per lesson.

**Layer summary**

| Layer | Purpose | Minimum expectation | This course |
|---|---|---|---|
| Foundations | Terms, rules, how it works | 4+ units, ~20+ lessons | 4 units, 30 lessons |
| Intermediate | Strategy, distinctions, context | 4+ units | 4 units, 30 lessons |
| Enthusiast depth (includes branch units) | What fans debate; nuance; history/culture; NHL/PWHL/international | 3+ units | 5 units, 34 lessons |
| Current-season / live | Ongoing, refreshed from live data and editorial | Templates + `live` hooks | 1 units, 7 lessons |
| Conversation practice | Talk tracks, say-this | 10+ tracks | 1 units, 8 lessons |
| Perpetual review | Spaced review | Review policy defined | 1 units, 4 lessons |

### Foundations

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `game-on-ice` | The Game on Ice | none | 8: Tour the rink; Three periods and a stop clock; The faceoff, the tiny fight; Goals, shots, saves; Assists and hat tricks; Why players keep hopping the boards; Whistles, puck over the glass, covered pucks; Pulling the goalie | `assist`, `center`, `crease`, `delay-of-game`, `extra-attacker`, `faceoff` ... |
| `rules-of-play` | The Rules That Cause Arguments | `game-on-ice` | 8: Offside: the blue line rule; Be the linesman: offside; Delayed offside and tagging up; Icing, and why teams hate it; Be the linesman: hybrid icing; When icing does not apply; Goal, no goal: review and challenges; The crease and goalie contact | `coaches-challenge`, `crease`, `delayed-offside`, `goalie-interference`, `hybrid-icing`, `icing` ... |
| `penalties-specialteams` | Penalties and Special Teams | `game-on-ice` | 8: Two minutes in the box; Stick fouls: high stick, holding, interference; Boarding, charging, cross-checking; Misconducts, ejections and fights; The power play, in one sentence; Surviving a penalty kill; Five-on-three and four-on-four; Penalty shots and embellishment | `cross-check-boarding`, `double-minor`, `embellishment`, `game-misconduct`, `high-sticking-holding`, `hooking-tripping` ... |
| `lines-positions-roles` | Who Plays Where | `game-on-ice` | 6: Centers and wingers; The defensemen; The goalie; Lines and pairs; Captains, alternates and scratches; Sniper, grinder, enforcer | `captain-alternates`, `center`, `defenseman`, `enforcer`, `goal-scoring`, `goaltender` ... |

#### Unit `game-on-ice`: The Game on Ice

What you are looking at: rink, players, clock, goals. Layer `foundations`. Prerequisites: none.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `game-rink-tour` | Tour the rink | Name the zones, lines, creases and circles so a broadcast makes sense. | `rink-layout`, `zones`, `crease` | hotspot-tap, term-match |
| `game-clock-periods` | Three periods and a stop clock | Explain why a hockey game takes longer than 60 minutes. | `periods-clock`, `stoppage` | estimate-slider, multiple-choice |
| `game-faceoffs` | The faceoff, the tiny fight | Describe how play starts and why centers matter on draws. | `faceoff`, `center` | multiple-choice, say-this |
| `game-scoring-basics` | Goals, shots, saves | Tell a goal from a shot and a save, and read a box score line. | `goal-scoring`, `shutout` | fill-the-gap, multiple-choice |
| `game-assists-hat-tricks` | Assists and hat tricks | Credit an assist correctly and know what a hat trick is. | `assist`, `hat-trick` | multiple-choice, fill-the-gap |
| `game-line-changes` | Why players keep hopping the boards | See why lines change constantly and how it can go wrong. | `line-change`, `too-many-men` | `unity-sim` hockey.tactics.line-change-timing.v1, binary-call |
| `game-stoppages` | Whistles, puck over the glass, covered pucks | Recognize the common reasons play stops. | `stoppage`, `delay-of-game` | sequence-order, multiple-choice |
| `game-pull-goalie` | Pulling the goalie | Explain why a team removes its goalie late in a game. | `extra-attacker`, `goal-scoring` | decision-scenario, say-this |

#### Unit `rules-of-play`: The Rules That Cause Arguments

Offside, icing, review. Layer `foundations`. Prerequisites: `game-on-ice`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `rules-offside-line` | Offside: the blue line rule | State what makes an entry offside. | `offside`, `zones` | visual-id, binary-call |
| `rules-offside-call` | Be the linesman: offside | Call offside plays correctly at real speed. | `offside` | `unity-sim` hockey.rules.offside-read.v1 |
| `rules-delayed-offside` | Delayed offside and tagging up | Explain why play sometimes continues after an early entry. | `delayed-offside`, `offside` | sequence-order, `unity-sim` hockey.rules.offside-read.v1 |
| `rules-icing-basics` | Icing, and why teams hate it | Describe what icing is and its penalty. | `icing` | multiple-choice, binary-call |
| `rules-icing-race` | Be the linesman: hybrid icing | Decide when hybrid icing is called. | `hybrid-icing`, `icing` | `unity-sim` hockey.rules.icing-call.v1 |
| `rules-icing-exceptions` | When icing does not apply | Know why a shorthanded team can freely ice. | `icing`, `penalty-kill` | decision-scenario, fill-the-gap |
| `rules-review` | Goal, no goal: review and challenges | Explain what coaches can challenge and what it costs. | `coaches-challenge`, `goalie-interference` | decision-scenario, multiple-choice |
| `rules-crease-contact` | The crease and goalie contact | Explain why some goals get waved off. | `crease`, `goalie-interference` | binary-call, say-this |

#### Unit `penalties-specialteams`: Penalties and Special Teams

Sin bin, power play, penalty kill. Layer `foundations`. Prerequisites: `game-on-ice`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `pen-minors` | Two minutes in the box | Name the common minor penalties and what happens after one. | `minor-penalty`, `hooking-tripping` | visual-id, multiple-choice |
| `pen-stick-infractions` | Stick fouls: high stick, holding, interference | Distinguish the stick and contact minors. | `high-sticking-holding`, `double-minor` | term-match, binary-call |
| `pen-dangerous` | Boarding, charging, cross-checking | Recognize the dangerous fouls that draw majors. | `cross-check-boarding`, `major-penalty` | binary-call, multiple-choice |
| `pen-misconducts` | Misconducts, ejections and fights | Explain game and match penalties and what a fighting major is. | `game-misconduct`, `major-penalty` | fill-the-gap, say-this |
| `pen-power-play` | The power play, in one sentence | Explain what a man advantage is and how it ends. | `power-play`, `minor-penalty` | multiple-choice, fill-the-gap |
| `pen-penalty-kill` | Surviving a penalty kill | Describe what the shorthanded team is trying to do. | `penalty-kill`, `shorthanded-goal` | multiple-choice, say-this |
| `pen-5on3-4on4` | Five-on-three and four-on-four | Explain the strange manpower situations. | `penalty-nuance`, `power-play` | sequence-order, binary-call |
| `pen-penalty-shot` | Penalty shots and embellishment | Recognize a penalty shot and a dive. | `penalty-shot`, `embellishment` | binary-call, say-this |

#### Unit `lines-positions-roles`: Who Plays Where

Positions, lines, roles. Layer `foundations`. Prerequisites: `game-on-ice`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `roles-forwards` | Centers and wingers | Explain what centers and wingers do. | `center`, `winger` | term-match, visual-id |
| `roles-defense` | The defensemen | Explain what defensemen do and why they shoot from the point. | `defenseman`, `point-shot` | term-match, hotspot-tap |
| `roles-goalie` | The goalie | Explain the goalie's job and gear. | `goaltender`, `goal-scoring` | visual-id, multiple-choice |
| `roles-lines-pairs` | Lines and pairs | Describe the four forward lines and three D pairs. | `lines-and-pairs`, `toi` | sequence-order, fill-the-gap |
| `roles-letters` | Captains, alternates and scratches | Understand C, A and healthy scratches. | `captain-alternates`, `healthy-scratch` | multiple-choice, say-this |
| `roles-player-types` | Sniper, grinder, enforcer | Decode player-type slang. | `enforcer`, `hockey-slang` | term-match, say-this |

### Intermediate

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `standings-ot-playoffs` | Points, Overtime and the Cup | `game-on-ice`, `penalties-specialteams` | 6: Standings points and the loser point; 3-on-3 overtime; The shootout; Wild cards and the playoff line; How the playoffs work; The Stanley Cup | `overtime-3v3`, `playoff-format`, `points-system`, `series-lingo`, `shootout`, `stanley-cup` ... |
| `systems-tactics` | How Teams Play | `rules-of-play`, `lines-positions-roles` | 9: The rush and odd-man rushes; The forecheck; Read the forecheck and break out; Neutral zone and the trap; Cycle, dump-and-chase and carry-ins; The slot, screens and tips; Power play formations; Find the seam on the power play; Who has the point? D-zone coverage | `backcheck`, `breakout`, `cycle`, `dzone-coverage`, `forecheck`, `gap-control` ... |
| `goalies-shot-quality` | Goalies and Shot Quality | `lines-positions-roles` | 6: The butterfly and angles; Rebounds and second chances; Save percentage, GAA and what they miss; Goals saved above expected; Starters, backups and back-to-backs; Goalie interference in the video room | `coaches-challenge`, `expected-goals`, `gaa`, `goalie-angles`, `goalie-butterfly`, `goalie-interference` ... |
| `numbers-machinery` | Numbers and League Machinery | `standings-ot-playoffs` | 9: Time on ice and plus-minus; Corsi, Fenwick and possession; Expected goals and PDO; Special teams percentages and faceoffs; The salary cap; LTIR and waivers; The draft and the lottery; Reading a broadcast graphic; Free agency, trades and contracts | `cap-hit`, `contract-terms`, `corsi`, `draft`, `expected-goals`, `faceoff-pct` ... |

#### Unit `standings-ot-playoffs`: Points, Overtime and the Cup

The competition structure. Layer `intermediate`. Prerequisites: `game-on-ice`, `penalties-specialteams`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `comp-points` | Standings points and the loser point | Explain how points work. | `points-system` | multiple-choice, estimate-slider |
| `comp-overtime` | 3-on-3 overtime | Describe regular-season overtime. | `overtime-3v3` | binary-call, fill-the-gap |
| `comp-shootout` | The shootout | Explain how it works and where it does not. | `shootout`, `tiebreakers` | sequence-order, multiple-choice |
| `comp-wildcard` | Wild cards and the playoff line | Read the playoff picture. | `wild-card`, `playoff-format` | term-match, decision-scenario |
| `comp-playoff-format` | How the playoffs work | Explain the 16-team bracket. | `playoff-format`, `series-lingo` | sequence-order, multiple-choice |
| `comp-stanley-cup` | The Stanley Cup | Talk about the Cup and its traditions. | `stanley-cup`, `series-lingo` | say-this, multiple-choice |

#### Unit `systems-tactics`: How Teams Play

Systems, formations, reading play. Layer `intermediate`. Prerequisites: `rules-of-play`, `lines-positions-roles`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `tac-rush-basics` | The rush and odd-man rushes | Explain a rush and a 2-on-1. | `rush`, `gap-control` | multiple-choice, hotspot-tap |
| `tac-forecheck` | The forecheck | Identify forecheck styles. | `forecheck`, `backcheck` | term-match, visual-id |
| `tac-forecheck-read` | Read the forecheck and break out | Choose a breakout against pressure. | `forecheck`, `breakout` | `unity-sim` hockey.tactics.forecheck-read.v1 |
| `tac-neutral-zone` | Neutral zone and the trap | Explain how teams defend the middle. | `neutral-zone-trap`, `zone-entry` | multiple-choice, decision-scenario |
| `tac-cycle-dump` | Cycle, dump-and-chase and carry-ins | Explain offensive zone play. | `cycle`, `zone-entry` | term-match, binary-call |
| `tac-slot-screens` | The slot, screens and tips | Explain where goals come from. | `slot`, `screen-tip`, `one-timer` | hotspot-tap, multiple-choice |
| `tac-pp-formations` | Power play formations | Recognize 1-3-1 and umbrella. | `pp-formations`, `one-timer` | visual-id, term-match |
| `tac-pp-seams` | Find the seam on the power play | Spot the open pass against a box. | `pp-formations`, `pk-formations` | `unity-sim` hockey.special-teams.power-play-spacing.v1 |
| `tac-dzone-coverage` | Who has the point? D-zone coverage | Assign coverage in the defensive zone. | `dzone-coverage`, `pk-formations` | `unity-sim` hockey.tactics.dzone-coverage.v1 |

#### Unit `goalies-shot-quality`: Goalies and Shot Quality

How goalies work and how to judge them. Layer `intermediate`. Prerequisites: `lines-positions-roles`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `goalie-stance` | The butterfly and angles | Explain the goalie's stance. | `goalie-butterfly`, `goalie-angles` | visual-id, hotspot-tap |
| `goalie-rebounds` | Rebounds and second chances | Explain rebound control. | `rebound`, `slot` | binary-call, multiple-choice |
| `goalie-save-pct` | Save percentage, GAA and what they miss | Read goalie stats. | `save-pct`, `gaa` | estimate-slider, multiple-choice |
| `goalie-advanced` | Goals saved above expected | Explain how shot quality changes the picture. | `goalie-stats-advanced`, `expected-goals` | say-this, multiple-choice |
| `goalie-workload` | Starters, backups and back-to-backs | Explain goalie rotation. | `goalie-workload` | decision-scenario, fill-the-gap |
| `goalie-interference-review` | Goalie interference in the video room | Judge interference plays. | `goalie-interference`, `coaches-challenge` | binary-call, decision-scenario |

#### Unit `numbers-machinery`: Numbers and League Machinery

Analytics and the business of hockey. Layer `intermediate`. Prerequisites: `standings-ot-playoffs`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `num-toi-plusminus` | Time on ice and plus-minus | Read basic player stats. | `toi`, `plus-minus` | estimate-slider, multiple-choice |
| `num-corsi` | Corsi, Fenwick and possession | Explain shot-attempt share. | `corsi` | fill-the-gap, say-this |
| `num-xg-pdo` | Expected goals and PDO | Explain luck and quality. | `expected-goals`, `pdo` | say-this, multiple-choice |
| `num-special-pct` | Special teams percentages and faceoffs | Read PP%, PK% and faceoff percentage. | `special-teams-pct`, `faceoff-pct` | estimate-slider, term-match |
| `num-cap` | The salary cap | Explain the cap and cap hit. | `salary-cap`, `cap-hit` | multiple-choice, estimate-slider |
| `num-ltir-waivers` | LTIR and waivers | Decode roster-maneuvering talk. | `ltir`, `waivers` | term-match, say-this |
| `num-draft-lottery` | The draft and the lottery | Explain how teams are built. | `draft`, `prospect-pipeline` | sequence-order, multiple-choice |
| `eye-broadcast` | Reading a broadcast graphic | Decode the on-screen stats. | `corsi`, `toi`, `faceoff-pct` | term-match, fill-the-gap |
| `num-free-agency` | Free agency, trades and contracts | Decode contract talk. | `free-agency`, `contract-terms` | term-match, decision-scenario |

### Enthusiast depth and branch units (layers `enthusiast` and `branch`)

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `the-debates` | Debates and the Eye Test | `numbers-machinery`, `systems-tactics` | 10: The fighting debate; The loser point; Overtime and the shootout; Analytics versus the eye test; Hits, discipline and player safety; When to pull the goalie; Last change chess; What a power play tells you; Third-period leads; Tanking and the lottery | `analytics-eye-test`, `corsi`, `draft`, `extra-attacker`, `fighting-debate`, `goalie-pull-debate` ... |
| `history-rivalries-lore` | History, Rivalries and Lore | `the-debates` | 7: The Original Six; Expansion and Sun Belt hockey; Legends and eras; Miracle on Ice and the Golden Goal; Rivalries; Hats, beards, octopi and the Cup; Hockey slang and chirping | `all-star-format`, `chirping`, `expansion-history`, `hockey-slang`, `legends`, `miracle` ... |
| `nhl-and-your-team` (branch `nhl`) | The NHL and Your Person's Team | `standings-ot-playoffs` | 6: Divisions, conferences and the 84-game season; What changed for 2026-27; {{team}}: what they are about; {{team}}: the players to know; {{team}}: rivals and rituals; Talk like a {{team}} fan | `hockey-slang`, `new-rules-26`, `nhl-structure`, `player-profile`, `rivalries`, `season-84` ... |
| `pwhl-branch` (branch `pwhl`) | The PWHL | `game-on-ice`, `penalties-specialteams` | 6: What is the PWHL?; How PWHL rules differ; The jailbreak rule; 3-2-1-0 and the Walter Cup; How the league came to be; Talk like a PWHL fan | `pwhl-basics`, `pwhl-culture`, `pwhl-playoffs`, `pwhl-rules`, `shorthanded-goal`, `team-identity` ... |
| `international-branch` (branch `international`) | International Hockey | `game-on-ice`, `rules-of-play` | 5: IIHF rules and big ice; The Olympic tournament; Worlds and World Juniors; Best-on-best hockey; Talk like an international fan | `best-on-best`, `iihf-rules`, `legends`, `olympics-hockey`, `worlds-juniors` ... |

#### Unit `the-debates`: Debates and the Eye Test

The debates. Layer `enthusiast`. Prerequisites: `numbers-machinery`, `systems-tactics`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `deb-fighting` | The fighting debate | Understand both sides. | `fighting-debate` | say-this, talk-track |
| `deb-loser-point` | The loser point | Explain why fans disagree. | `loser-point`, `points-system` | say-this, multiple-choice |
| `deb-overtime` | Overtime and the shootout | Explain the format debate. | `ot-format-debate`, `overtime-3v3` | say-this, talk-track |
| `deb-analytics` | Analytics versus the eye test | Explain both camps. | `analytics-eye-test`, `corsi` | say-this, talk-track |
| `deb-head-hits` | Hits, discipline and player safety | Explain the discipline debate. | `head-hits` | say-this, decision-scenario |
| `deb-goalie-pull` | When to pull the goalie | Judge coaching decisions. | `goalie-pull-debate`, `extra-attacker` | decision-scenario, talk-track |
| `eye-last-change` | Last change chess | Read matchups. | `last-change`, `line-change` | `unity-sim` hockey.tactics.line-change-timing.v1, decision-scenario |
| `eye-pp-story` | What a power play tells you | Judge special teams in-game. | `pp-formations`, `special-teams-pct` | `unity-sim` hockey.special-teams.power-play-spacing.v1, say-this |
| `eye-third-period` | Third-period leads | Explain how teams protect a lead. | `neutral-zone-trap`, `extra-attacker` | decision-scenario, talk-track |
| `deb-tanking` | Tanking and the lottery | Explain the tanking debate. | `tanking`, `draft` | say-this, multiple-choice |

#### Unit `history-rivalries-lore`: History, Rivalries and Lore

The stories. Layer `enthusiast`. Prerequisites: `the-debates`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `lore-original-six` | The Original Six | Name the six and why they matter. | `original-six` | term-match, visual-id |
| `lore-expansion` | Expansion and Sun Belt hockey | Explain how the league grew. | `expansion-history`, `nhl-structure` | sequence-order, multiple-choice |
| `lore-legends` | Legends and eras | Talk about Gretzky and modern stars. | `legends` | say-this, multiple-choice |
| `lore-miracle` | Miracle on Ice and the Golden Goal | Explain iconic moments. | `miracle` | say-this, multiple-choice |
| `lore-rivalries` | Rivalries | Explain a few classic rivalries. | `rivalries` | term-match, say-this |
| `lore-traditions` | Hats, beards, octopi and the Cup | Explain rink traditions. | `traditions`, `stanley-cup`, `all-star-format` | multiple-choice, say-this |
| `lore-slang` | Hockey slang and chirping | Decode slang. | `hockey-slang`, `chirping` | term-match, talk-track |

#### Unit `nhl-and-your-team`: The NHL and Your Person's Team

NHL specifics and {{team}}. Layer `branch`. Prerequisites: `standings-ot-playoffs`. Branch `nhl`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `nhl-structure-84` | Divisions, conferences and the 84-game season | Explain the NHL layout. | `nhl-structure`, `season-84` | term-match, estimate-slider |
| `nhl-2627-rules` | What changed for 2026-27 | Explain the new rules. | `new-rules-26` | multiple-choice, say-this |
| `team-identity` | {{team}}: what they are about | Explain the team's identity. | `team-identity` | multiple-choice, say-this |
| `team-key-players` | {{team}}: the players to know | Talk about {{player}}. | `player-profile` | say-this, visual-id |
| `team-rivals` | {{team}}: rivals and rituals | Explain rivalries and traditions. | `rivalries`, `traditions` | say-this, talk-track |
| `team-fan-talk` | Talk like a {{team}} fan | Practice fan talk. | `hockey-slang`, `team-identity` | talk-track |

#### Unit `pwhl-branch`: The PWHL

PWHL specifics. Layer `branch`. Prerequisites: `game-on-ice`, `penalties-specialteams`. Branch `pwhl`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `pwhl-intro` | What is the PWHL? | Explain the league and its 12 teams. | `pwhl-basics` | multiple-choice, term-match |
| `pwhl-rules` | How PWHL rules differ | Know the rule differences. | `pwhl-rules` | binary-call, multiple-choice |
| `pwhl-jailbreak` | The jailbreak rule | Explain the jailbreak rule. | `pwhl-rules`, `shorthanded-goal` | binary-call, say-this |
| `pwhl-points-playoffs` | 3-2-1-0 and the Walter Cup | Read PWHL standings. | `pwhl-rules`, `pwhl-playoffs` | estimate-slider, sequence-order |
| `pwhl-history` | How the league came to be | Explain PWHL history. | `pwhl-culture` | say-this, multiple-choice |
| `pwhl-fan-talk` | Talk like a PWHL fan | Practice PWHL conversation. | `pwhl-culture`, `team-identity` | talk-track |

#### Unit `international-branch`: International Hockey

Olympic and IIHF hockey. Layer `branch`. Prerequisites: `game-on-ice`, `rules-of-play`. Branch `international`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `intl-rules` | IIHF rules and big ice | Explain the international differences. | `iihf-rules` | binary-call, multiple-choice |
| `intl-olympics` | The Olympic tournament | Explain how Olympic hockey works. | `olympics-hockey` | say-this, multiple-choice |
| `intl-worlds-juniors` | Worlds and World Juniors | Explain the other tournaments. | `worlds-juniors` | multiple-choice, fill-the-gap |
| `intl-best-on-best` | Best-on-best hockey | Explain why fans love these events. | `best-on-best`, `olympics-hockey` | say-this, multiple-choice |
| `intl-fan-talk` | Talk like an international fan | Practice conversation. | `olympics-hockey`, `legends` | talk-track |

### Current-season / live

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `season-live` | The Live Season | `game-on-ice` | 7: This week's storylines; Reading the standings today; The playoff race; Watching a live game; The hockey calendar; Trade deadline talk; Playoff mode | `cap-hit`, `draft`, `free-agency`, `game-companion`, `playoff-format`, `playoff-race` ... |

#### Unit `season-live`: The Live Season

Weekly and seasonal layer. Layer `current-season`. Prerequisites: `game-on-ice`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `live-this-week` | This week's storylines | Explain what is being discussed now. | `this-week` | say-this, multiple-choice |
| `live-standings` | Reading the standings today | Interpret the live table. | `playoff-race`, `points-system` | multiple-choice, estimate-slider |
| `live-playoff-race` | The playoff race | Explain who is in, out and on the bubble. | `playoff-race`, `wild-card` | decision-scenario, say-this |
| `live-game-companion` | Watching a live game | Follow a game in progress. | `game-companion`, `power-play` | multiple-choice, say-this |
| `live-season-calendar` | The hockey calendar | Explain what happens each month. | `season-calendar`, `draft` | sequence-order, multiple-choice |
| `live-deadline` | Trade deadline talk | Explain deadline deals. | `free-agency`, `cap-hit` | say-this, decision-scenario |
| `live-playoffs` | Playoff mode | Explain playoff intensity. | `playoff-format`, `series-lingo` | say-this, multiple-choice |

### Conversation practice

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `conversation-practice` | Talk Hockey | `game-on-ice` | 8: Your first hockey question; After a win; After a loss; When the ref ruins the night; The goalie stole it; Playoff nerves; Watching a game together; Ask about her hockey story | `conversation-starters`, `follow-up-questions`, `game-companion`, `goal-scoring`, `goalie-interference`, `goaltender` ... |

#### Unit `conversation-practice`: Talk Hockey

Ongoing conversation practice. Layer `conversation`. Prerequisites: `game-on-ice`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `talk-first-question` | Your first hockey question | Start a conversation. | `conversation-starters` | talk-track, say-this |
| `talk-after-win` | After a win | React to a win. | `follow-up-questions`, `goal-scoring` | talk-track |
| `talk-after-loss` | After a loss | React to a loss with care. | `follow-up-questions`, `honest-curiosity` | talk-track |
| `talk-penalty` | When the ref ruins the night | Talk about a controversial call. | `goalie-interference`, `minor-penalty` | talk-track, say-this |
| `talk-goalie` | The goalie stole it | Talk about a goalie performance. | `save-pct`, `goaltender` | talk-track |
| `talk-playoffs` | Playoff nerves | Talk about playoffs. | `playoff-format`, `series-lingo` | talk-track |
| `talk-watch-together` | Watching a game together | Watch with her. | `game-companion`, `honest-curiosity` | talk-track, say-this |
| `talk-memories` | Ask about her hockey story | Ask meaningful questions. | `conversation-starters`, `follow-up-questions` | talk-track |

### Perpetual review

| unit id | unit title | prerequisites | lessons (count + titles) | main concepts |
|---|---|---|---|---|
| `perpetual-review` | Keep It Fresh | `game-on-ice` | 4: Daily Bite; Weekly mix; What did she mean?; New season refresh | `faceoff`, `forecheck`, `hockey-slang`, `icing`, `new-rules-26`, `offside` ... |

#### Unit `perpetual-review`: Keep It Fresh

Spaced review. Layer `review`. Prerequisites: `game-on-ice`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `rev-daily-bite` | Daily Bite | Review a few due cards each day. | `faceoff`, `icing`, `offside` | multiple-choice, fill-the-gap |
| `rev-weekly-mix` | Weekly mix | Interleave concepts from every layer. | `power-play`, `forecheck`, `salary-cap` | multiple-choice, say-this |
| `rev-what-did-she-mean` | What did she mean? | Decode fan lines. | `hockey-slang`, `team-identity` | say-this |
| `rev-season-refresh` | New season refresh | Refresh after rule changes. | `new-rules-26`, `season-84` | multiple-choice, term-match |

**Concept count target (Playbook):** 123 concepts at launch scope (foundations 40, intermediate 47, enthusiast 29, current-season 4, conversation 3); growth target 180-220 with seasonal terms.

**Personalization slots:** `team`, `player`, `league` (unit `nhl-and-your-team` lists `personalizationSlots: [team, player]`; branch units are selected by `league`). Live units use the same slots for the feed.

**Live hooks (`live` blocks on `season-live`):** `dataKind` scores/standings/schedules/news/events, `adapterKey` `hockey.live.*` (see `live-data.md`); lessons are templates rendered from normalized data.

**Review policy:** `leitner-boxes-v1`, intervals [1,3,7,14,30,60] days, 12 items per session, mastery threshold 0.80, decay after 45 days; review activity types multiple-choice, fill-the-gap, say-this, term-match, binary-call, estimate-slider.

**Release plan**

| Release | Scope |
|---|---|
| Launch (v1.0) | Units 1-8 (foundations and intermediate systems, points/playoffs), `conversation-practice`, `perpetual-review`, `season-live` basics (scores, standings, schedule, this-week), NHL default. Sims: offside-read, icing-call (first), line-change-timing. |
| v1.1 | Units `numbers-machinery`, `the-debates`, `history-rivalries-lore`, `nhl-and-your-team`; sims power-play-spacing, forecheck-read, dzone-coverage. |
| v1.2 | `pwhl-branch` (needs a PWHL data decision), expansion-team refresh. |
| v1.3 | `international-branch` (Worlds/Olympic window content). |
| Seasonal | Each October: rule-change lesson and new-season refresh (`rev-season-refresh`); deadline, playoffs, draft, free-agency lessons via the live layer; new concepts as the game evolves. |

## 12. Interaction plan

Every activity family maps to a native type or Unity sim. Tier rubric (`CLAUDE.md`): Unity only where spatial reasoning, movement, physics, timing in a scene or camera perspective materially improves learning and a native exercise would teach it worse.

| Lesson / activity family | Concepts | Type (native exercise or `unity-sim`) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| `rules-offside-call`, `rules-delayed-offside` | `offside`, `delayed-offside`, `coaches-challenge`, `zones` | `unity-sim` `hockey.rules.offside-read.v1` | (1) **Movement in space over time:** offside is defined by the relationship of two moving skates and a moving puck to a line, at an instant. (2) **Camera perspective is the concept:** from the broadcast angle the entry looks fine; from the blue-line camera you can see the skates are over. Switching camera at the freeze is the lesson. (3) **Timing in a scene:** the learner must decide at speed, as a linesman does. Alternative rejected: `binary-call` on a still diagram. Spec: `sims/hockey.rules.offside-read.v1.md`. | A | 12 scenarios x rounds of 3 |
| `rules-icing-race` | `icing`, `hybrid-icing`, `penalty-kill`, `line-change` | `unity-sim` `hockey.rules.icing-call.v1` | (1) **Movement in space:** hybrid icing is a footrace judged at a line the players have not reached yet; the learner has to predict it from speeds and positions. (2) **Camera perspective:** the high-behind camera shows the gap between two skaters and the dot line, which a diagram cannot express. (3) **Timing:** the call is made while the puck is still in flight. A native `binary-call` on a diagram can teach the definition of icing and its exceptions (and does, in `rules-icing-basics` and `rules-icing-exceptions`), but not the race judgment; that is why only the race is in Unity. Alternative rejected: `binary-call` on a still diagram. Spec: `sims/hockey.rules.icing-call.v1.md`. | A | 12 scenarios x rounds of 3 |
| `tac-pp-seams`, `eye-pp-story` | `pp-formations`, `pk-formations`, `one-timer`, `slot`, `screen-tip` | `unity-sim` `hockey.special-teams.power-play-spacing.v1` | (1) **Spatial reasoning:** spacing is the whole concept: where five attackers stand relative to four killers and which lane is open. (2) **Movement over time:** the killers shift as the puck moves; a still image hides the shifting that creates the seam. (3) **Camera perspective:** the top-down view makes lane geometry readable. Alternative rejected: `hotspot-tap`/`decision-scenario` on a still diagram. Spec: `sims/hockey.special-teams.power-play-spacing.v1.md`. | A | 10 scenarios x rounds of 3 |
| `tac-forecheck-read` | `forecheck`, `breakout`, `backcheck`, `neutral-zone-trap` | `unity-sim` `hockey.tactics.forecheck-read.v1` | (1) **Spatial reasoning and movement:** a forecheck is a shape of five skaters moving; the right breakout is the pass whose lane the shape cannot reach in time. (2) **Reading a dynamic scene:** the learner must read where pressure is, not recall a rule. (3) **Camera perspective:** the top-down view shows lanes and gaps at once. Alternative rejected: `hotspot-tap`/`decision-scenario` on a still diagram. Spec: `sims/hockey.tactics.forecheck-read.v1.md`. | A | 9 scenarios x rounds of 3 |
| `game-line-changes`, `eye-last-change` | `line-change`, `too-many-men`, `icing`, `last-change` | `unity-sim` `hockey.tactics.line-change-timing.v1` | (1) **Timing in a scene:** the learner has a continuous window and the right answer depends on when things happen relative to the puck. (2) **Movement over time and space:** skaters need seconds to reach the bench; how far the bench is (long change) and where the puck is decide the risk. (3) **Reading a dynamic scene:** rushes, clears and turnovers appear on screen. A native `timing-tap` bar is a 1D marker with no puck, no bench and no risk, so it can teach 'timing' but not *what* to time against. `decision-scenario` can list facts about puck and bench but cannot show that a change started at the wrong moment produces a breakaway 3 s later. Alternative rejected: `timing-tap` bar / `decision-scenario`. Spec: `sims/hockey.tactics.line-change-timing.v1.md`. | A | 10 scenarios x rounds of 3 |
| `tac-dzone-coverage` | `dzone-coverage`, `pk-formations`, `slot`, `goalie-interference` | `unity-sim` `hockey.tactics.dzone-coverage.v1` | (1) **Spatial reasoning and movement:** coverage is about where players are in zones and how those zones move with the puck. (2) **Reading a dynamic scene:** the open man appears after a cycle; the learner has to see him move. (3) **Camera perspective:** top-down shows zones and assignments; the broadcast view hides the empty slot. Closest native types: `hotspot-tap` (tap a zone on a diagram) and `term-match` (name the coverage). Those teach the labels and zone map (used in `tac-dzone-coverage`'s primer), but not the cause of a breakdown, which only appears when players move. Alternative rejected: `hotspot-tap`/`decision-scenario` on a still diagram. Spec: `sims/hockey.tactics.dzone-coverage.v1.md`. | A | 10 scenarios x rounds of 3 |
| most foundation lessons | Rules, points, structure, quick checks | `multiple-choice` | Recall of a single fact; a game engine adds nothing. | B | 250 |
| rules and branch-rules lessons | offside, icing exceptions, interference, PWHL jailbreak | `binary-call` | A two-way call on a static diagram teaches the rule cleanly; motion versions are the Unity sims. | B | 75 |
| positions, penalties, special teams, analytics | Term vocabulary | `term-match` | 3-6 terms per set; matching is the fastest way to consolidate. | B | 95 |
| playoff path, icing consequences, rush, prospect path | Process order | `sequence-order` | Order is the concept; no space or timing needed. | B | 50 |
| referee signals, formation diagrams, rink markings | Recognition | `visual-id` | Recognition by sight; original art. | B | 45 |
| goalie pull, last change, deadline, challenge, goalie workload | Judgment | `decision-scenario` | Judgment from facts with consequences; not a motion problem. | B | 70 |
| conversation lessons, branch fan-talk, Talk tab | Conversation practice | `talk-track` | Text conversation is the product; the design file's hockey chat. | B | 32 |
| enthusiast, live and review lessons | Decoding fan lines | `say-this` | Interpretation, not motion. | B | 126 |
| scoring, penalties, icing, review cards | Terms in context | `fill-the-gap` | Cheap review card. | B | 60 |
| clock, cap, season, rink size, percentages | Magnitude intuition | `estimate-slider` | A number is the lesson. | B | 45 |
| rink tour, slot, the point | Static spatial knowledge | `hotspot-tap` | Tap a region on a fixed diagram; if players move it is a sim. | B | 25 |
| not used | - | `timing-tap` | N/A: the only timing concept (line changes) depends on puck, bench and risk in a scene, so it is Unity. | - | 0 |
| not used | - | `listening-id` | N/A: no licensed audio; original ambient only if later needed. | - | 0 |

**Tier A summary.** Six sims, each with a written rubric answer above and a full spec: offside reading and icing (the two line-based calls, judged at speed from a camera that a diagram cannot give), power play spacing, forecheck reading and defensive-zone coverage (spatial reads of moving shapes), and line change timing (timing against a scene). Combined, they are roughly 10% of learner time; the other 90% is native.

Native rows link to `docs/native-exercises/CATALOG.md`; sample payloads are in `exercises.md`.

## 13. Licensing & safety

| Area | Constraint | How handled |
|---|---|---|
| Imagery | No NHL, PWHL, IIHF or team logos and no player photos or likeness without a license (spec rule 10). | All rink, formation and referee-signal art is original vector illustration (license `original-swoond`). Team names and player names appear as plain text only. |
| Logos / trademarks | League and team marks are protected; the phrase "Stanley Cup" is used descriptively. | Text names only; no logos, no trophy imagery, no team colors that copy a mark. Unity jerseys are generic solids/stripes with numbers. |
| Audio | Broadcast audio, goal songs and horns are licensed content. | Original synthesized whistle, skate, puck and crowd beds only (license `original-swoond`). |
| Video | Highlights are rights-managed. | None embedded; link to the league's own pages only. |
| Lyrics | N/A | N/A. |
| Article text | Publisher text is copyrighted. | Explain in our own words and link; headline and link only via a licensed adapter. |
| Player likeness | Names, faces and numbers are player publicity rights. | Names as text in editorial only; no likeness; Unity avatars are generic. |
| Data provider terms | Provider terms restrict redistribution and caching. | Data enters through adapters and is normalized; follow attribution and caching terms per provider (open question for PWHL). |

**Safety and sensitivity.** Physical contact and head injuries are real; the course explains the debates with care, never celebrates injuries, and never presents hits as scoring content. No betting, odds, fantasy wagering or gambling promotion. Content is suitable for all ages; discreet mode stays on by default and notifications never contain the person's name. Hockey has no real-world-risk instructions (unlike outdoors/cooking), so no `safetyNote` is required on decision scenarios, but coaching decisions are labelled as learning aids.

## 14. Content assets

| Asset | Kind | Source / license | Notes |
|---|---|---|---|
| Rink diagrams (full, offensive zone, neutral zone, crease) | procedural vector `diagramId`s | original, `original-swoond` | Used by hotspot-tap, binary-call, visual-id |
| Formation diagrams (1-3-1, umbrella, box, diamond, 1-2-2, 2-1-2, left-wing lock) | illustration | original | Used in tac-pp-formations, tac-forecheck |
| Referee signals (about 12) | illustration | original | Used in pen-minors, pen-stick-infractions |
| Sim art (rink, generic skaters, puck, overlays) | procedural in Unity | original | Per sim spec section 18 |
| Sim and ambient audio (whistle, skates, puck, crowd bed) | synthesized | original, `original-swoond` | No recorded broadcasts |
| Fan-talk scripts, talk tracks, say-this | text | original authoring | Curriculum JSON |
| Team logos, jerseys, player photos | - | NOT USED | Text names only |

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. What does a beginner need to understand? Rink and zones, offside, icing, penalties and the power play, positions and lines, points and playoffs (sections 2-3; units 1-5).
- [x] 2. What do enthusiasts care about? Special teams, goalies, systems, analytics, the cap and roster building, officiating debates, playoff drama, rivalries and the PWHL/Olympics (section 4; units 6-14).
- [x] 3. What current information matters? Scores, schedule, standings and playoff race, rosters and injuries, deadline, draft and free agency, editorial context (sections 6-7; `season-live`).
- [x] 4. What should be interactive? Offside, icing, power play spacing, forecheck, line changes and defensive coverage in Unity; judgment and decoding natively (sections 5, 12).
- [x] 5. What should NOT be gamified? Fighting and head injuries, players' personal lives, betting/odds, tribal insults (section 5).
- [x] 6. How should it personalize? By team, player and league (branch); tokens with safe defaults (section 8).
- [x] 7. What does conversational competence look like? Decoding lines like "zero for fourteen on the power play" and asking a curious follow-up (sections 9-10).
- [x] 8. What data providers are needed? Scores, schedules, standings and basic stats via TheSportsDB with an enterprise upgrade path; a licensed news feed (section 6, `live-data.md`).
- [x] 9. What licensing constraints apply? No logos, likeness, broadcast audio, video or article text; original art and audio only (section 13).
- [x] 10. How will Swoon'd measure useful understanding? Concept mastery (threshold 0.80), say-this decode rate, talk-track Smooth, sim mastery signals (section 10).

Additional gates: [ ] manifest validates (run validator); [ ] curriculum validates (curriculum JSON still to author); [ ] every Unity sim has an approved spec (all six are drafts); [ ] every image/audio asset has a license id (all `original-swoond`); [x] voice review drafted (cheeky coach, never mean, never about the crush); [x] no copied publisher text.

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Does TheSportsDB (or any affordable provider) cover NHL, PWHL and international tournaments well enough for standings and rosters? Terms and caching limits? | Claude / Product | Blocking the live layer, not the foundations |
| 2 | PWHL data source: no known public licensed API; league feed or static content until then? | Product | No (branch ships later) |
| 3 | News provider for editorial context (DECISIONS Q-3). | Product | Blocking editorial live cards |
| 4 | Icing rule variants in the PWHL and IIHF (hybrid vs touch-up) and the airborne-skate offside wording: verify against the current rulebooks before locking copy. | Claude (content) | Only for the affected scenarios |
| 5 | Should college (NCAA) and junior (CHL) hockey become branches later? They are a big part of the pipeline but a separate fan culture. | Product | No |
| 6 | Approve the 16-unit shape (roughly 14 planned; branches added three units). | Product | No |
| 7 | Coach reviewer for formation names (umbrella, 1-2-2, left-wing lock) and the simplified five-zone model. | Product | No |
| 8 | Ten-foot too-many-men rule, challenge rules and shootout format need a rulebook re-check each season (NHL 2026-27 rules changes are verified as of 2026-09-30). | Claude (content) | No |
| 9 | Should the Unity sims cross-post to `basketball` and `soccer` (shared line/lane primitives)? | Astra | No |
