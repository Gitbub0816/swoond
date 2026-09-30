# Course Design Specification: Basketball (`basketball`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Rules and season facts are stated as of 2026-09-30 (Section 3.6 lists what was verified and where); anything that changes every season is served from live data, not from static lessons.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 1 |
| Author / date | Swoon'd curriculum design (Claude Code), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/*.md`, `NOTES_FOR_ORCHESTRATOR.md` |

---

## 1. Identity
- **Course ID:** `basketball` (immutable)
- **Display name:** Basketball
- **Category / family:** Sports (family) > Basketball. Category path: `Sports > Basketball`.
- **Simulation prefix:** `basketball` (sim ids `basketball.<topic>.<name>.v1`)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns basketball, are they meaningfully conversationally competent about it?" | Verdict | Consequence for course structure |
|---|---|---|---|
| NBA, WNBA, college basketball (men and women) | Yes for the game itself: five-on-five, positions, offense, defense, fouls and strategy transfer almost completely. Differences (quarters vs halves, shot clock 24 vs 30, six vs five fouls, ball size, arc distance, money and eligibility systems) are real but small and teachable in a few lessons. | Shares foundation | One course with three branches; foundations are shared; branch units carry league-specific rules, calendars, economics and culture. |
| International basketball (FIBA, EuroLeague, Olympics) | Mostly yes for the game; the competition structure, rules details (FIBA arc, 40-minute games, no defensive three seconds) and fan culture differ. | Shares foundation (not a branch yet) | Roadmap item: an "international" branch after Wave 1; NBA Europe (targeted for October 2027, not confirmed) may accelerate it. For now international players and the Olympics are covered as culture in `era-04`, `era-07`. |
| 3x3 and streetball | Partly: shared vocabulary, different rules and pace. | Adjacent | Out of scope; mentioned in `era-07` culture. |
| American Football (`american-football`) | No. Football rules, downs, formations and clock are different; some transferable ideas (clock management, spacing, analytics vocabulary). | Adjacent | Independent course; cross-link "clock management" and "analytics" concepts. |
| Hockey (`hockey`) | Partly: flow and line changes feel similar, rules do not. | Adjacent | Independent course; cross-link "power play" vs "bonus" as penalty analogies only in copy, not as prerequisites. |
| Soccer (`soccer`) | Partly: spacing, off-ball movement and pressing concepts transfer at a high level. | Adjacent | Independent course; cross-link "spacing" and "pressing". |
| Fantasy basketball and sports betting | Different skills (roster management, pricing odds). | Independent | Not taught. Betting is explicitly out of scope (Section 13). Fantasy may become a future add-on course. |

- **Branches:**

| id | Name | What changes |
|---|---|---|
| `nba` | NBA (default) | Rules (four 12-minute quarters, 24-second clock, six fouls), the NBA calendar (82 games, Play-In, playoffs, NBA Cup), money (soft cap, luxury tax, aprons, draft lottery), teams and stars. |
| `wnba` | WNBA | Four 10-minute quarters, 28.5-inch ball, the 2026 CBA (cap and roster rules), expansion, the 44-game 2026 season (growing in later years), Commissioner's Cup, offseason leagues, the college-to-W path, teams and stars. |
| `college` | College basketball (men and women) | Two 20-minute halves for men and four 10-minute quarters for women, 30-second clock, five fouls, 68-team NCAA tournament, NET and bubble talk, the transfer portal, NIL and revenue sharing, conferences, recruiting, one-and-done culture. |

Choosing a branch sets the personalization dimension `league` (Section 8). Foundations are the same for every branch; each rule that differs by branch is tagged in the curriculum so an NBA learner is never quizzed on a college-only rule.

## 2. Beginner model
- **What does a complete beginner typically know?** Five players, one ball, hoops at each end; dunks are cool; a few names (Jordan, LeBron, Curry, Caitlin Clark); March Madness means brackets; three-pointers count for three. Most beginners can follow the ball but not what happens away from it.
- **Terminology that will initially confuse them:** "the paint", "the key", "the arc", "and-one", "the bonus", "double-double", "triple-double", "point guard" vs "shooting guard" vs "wing", "pick-and-roll" (screen vs pick), "switch", "drop", "zone", "iso", "load management", "cap space", "the apron", "sign-and-trade", "two-way", "the Play-In", "seed", "the portal", "NIL", "bubble", "Cinderella", "hooper", "bucket", "cooking", "heat check", "ref ball".
- **Common misconceptions (and what we teach instead):**
  1. "Two steps after the dribble is traveling" - a gather step is allowed, then two steps.
  2. "Any contact where the defender falls is a charge" - the defender must be set and not a help defender inside the restricted arc.
  3. "The best regular-season team wins the title" - the playoffs are best-of-seven series; seeding gives home court, not a trophy.
  4. "The NBA has a hard cap like football" - it is a soft cap with exceptions, a luxury tax and aprons.
  5. "The worst team gets the number-one pick" - the lottery is weighted; the worst teams have the best odds but cannot fall below fifth.
  6. "Fouling out is five fouls" - six in the NBA and WNBA, five in college.
  7. "Zone defense is illegal in the NBA" - legal since 2001, with a defensive three-second rule.
  8. "March Madness has 64 teams" - 68 with the First Four.
  9. "An assist is the last pass" - it must lead directly to the basket by the scorer, within the rules of the official scorer.
  10. "The WNBA is a smaller version of the NBA" - different rules details, money, calendar, season length and culture, and a rapidly changing league.
  11. "Standing on the three-point line counts as three" - a foot on the line is a two.
  12. "The shot clock resets to 24 every time it touches the rim" - the NBA resets to 14 after an offensive rebound.
- **Concepts that unlock the rest of the subject (foundation units):** possession and the two clocks; the court and scoring; positions vs roles; spacing; screens and the pick-and-roll; the foul system (personal, team, bonus, free throws); help defense; how seasons, seeds and the playoffs work; the soft cap in plain English.

## 3. Foundational knowledge
### 3.1 Modules (become `foundationalModules[]` and foundation units)
| Module id | Title | Covers |
|---|---|---|
| `the-game` | The Game and Its Players | Objective, scoring, court, clocks, possession, positions vs roles, box score |
| `rules` | Rules and Officiating | Violations, fouls, free throws, charge vs block, goaltending, replay |
| `offense` | How Offense Works | Spacing, cutting, screens, shot types, shot quality, passing, post and iso |
| `defense` | How Defense Works | Man, help, zone, rebounding, rim protection, pressure, transition defense |

### 3.2 Rules (NBA baseline; branch differences flagged)
- **Game:** five per side; 48 minutes in four 12-minute quarters (NBA); five-minute overtimes; the WNBA plays four 10-minute quarters; college men play two 20-minute halves and women four 10-minute quarters (a move to quarters for men is under discussion, not adopted as of 2026-09-30).
- **Clocks:** 24-second shot clock (NBA and WNBA), 30 seconds in college; resets to 14 after an offensive rebound in the NBA; 8 seconds to cross half court (NBA/WNBA), 10 in college; 3 seconds in the lane on offense; 5-second inbound and closely guarded counts.
- **Scoring:** free throw 1, field goal 2, three-pointer 3. The NBA arc is 23 ft 9 in at the top and 22 ft in the corners; the WNBA and college arc is 22 ft 1.75 in. Free-throw line 15 ft from the backboard.
- **Fouls:** personal fouls, shooting fouls (and-one), technical, flagrant (1 and 2), intentional. Disqualification at six (NBA/WNBA) or five (college). Team fouls produce bonus free throws (NBA: from the fifth team foul in a quarter; college men: the seventh in a half for one-and-one, the tenth for two shots).
- **Key judgments:** traveling (gather step, pivot foot, euro step), carrying, double dribble, goaltending, basket interference, charge vs block (legal guarding position, verticality, restricted-area arc 4 ft for secondary defenders).
- **Zone defense** is legal in the NBA (since 2001) with a defensive three-second rule.
- **Replay/review:** coach's challenges (the NBA allows a second challenge after a successful first; for 2025-26 the replay center official rules on proximate fouls in out-of-bounds challenges), the last-two-minute report, transition take-foul enforcement tightened for 2025-26.

### 3.3 Terminology and concepts
389 concepts across the units in Section 11 (Playbook); about 84 core terms get Playbook cards at launch (`exercises.md` section 4). Concept ids are stable kebab-case and are listed per lesson in Section 11.

### 3.4 Strategy
Spacing and gravity; screen actions and ball-screen coverages (drop, hedge, switch, blitz, ice); help and rotation; zone offense and defense; transition; late-clock and end-of-game strategy (two-for-one, fouling up three, timeouts); lineup construction (small ball, switchability); series adjustments.

### 3.5 History, culture, equipment, participants, organizations
- **History:** Naismith (1891); BAA/NBA (1946/1949); 24-second clock (1954); Celtics dynasty; Magic-Bird; Jordan; 1992 Dream Team; the 2000s dynasties; the Warriors and the three-point revolution; the current era.
- **Culture:** AAU, streetball, high-school and college pipelines, one-and-done, sneaker and tunnel-fit culture, international pipelines, women's basketball's growth.
- **Equipment:** ball sizes (men 29.5 in; women 28.5 in), the hoop (10 ft), backboard, shoes (no brand focus, no logos).
- **Participants and organizations:** players, coaches, front offices, referees and replay center; NBA, WNBA, NCAA and conferences, FIBA, players' unions, the G League.

### 3.6 Verified facts and sources (2026-09-30)
These are date-stamped and may change; static lessons never depend on them (they live in live data and the `era-08` / `season-live` templates).

| Fact | As of 2026-09-30 | Source |
|---|---|---|
| NBA champion 2025-26 | New York Knicks beat the San Antonio Spurs 4-1 in the Finals; Jalen Brunson Finals MVP; the Knicks' first title since 1973 | NBA.com, Wikipedia (2026 NBA Finals) |
| NBA MVP 2025-26 | Shai Gilgeous-Alexander (second straight); Jokic second, Wembanyama third | ESPN, CBS Sports |
| NBA Cup | Knicks won the 2025 Cup (124-113 over the Spurs; Brunson MVP); the 2026 Cup has six five-team groups (three per conference), single-elimination knockout of the six group winners plus one wild card per conference, the final on 11 December at Hinkle Fieldhouse, Indianapolis | NBA.com, Wikipedia, ESPN |
| 2026-27 NBA season | Opens 20 October 2026 with a three-game NBC/Peacock slate | SI, FOX Sports |
| NBA media partners | ESPN/ABC, NBC/Peacock and Amazon Prime Video (TNT is no longer a partner) | NBA.com |
| 2025-26 cap thresholds | Cap $154.647M; tax line $187.895M; first apron $195.945M; second apron $207.824M (all reset annually) | Bleacher Report, NBA.com |
| NBA Europe | Targeted for October 2027; not confirmed; EuroLeague vote scheduled 5 October 2026 | ESPN, NBA.com |
| WNBA 2026 | Toronto Tempo and Portland Fire joined (expansion draft 3 April 2026); new CBA: cap about $7.0M, first-year maximum about $1.4M, 12-player rosters plus two developmental spots, 44 games in 2026 rising to 50 (2027-28) and 52 (2029-32); playoffs began 27 September 2026 (best-of-three, best-of-five, best-of-seven Finals from 17 October); the 2025 champion was the Las Vegas Aces | WNBA.com, ESPN, CBS Sports, NBC Sports |
| College 2026 | Michigan beat UConn 69-63 for the men's title (Elliot Cadeau MOP); UCLA beat South Carolina 79-51 for the women's title (Lauren Betts MOP); the first full season of House-settlement revenue sharing (about $20.5M per school cap in 2025-26) | CBS News, NCAA.com, Congress.gov |
| College rules | Men still play two 20-minute halves in 2025-26 and 2026-27; quarters remain under discussion; the NCAA allowed coach's challenges in 2025-26 | NCAA.org, SI |
| NBA rules 2025-26 | Second challenge after a successful one; replay center rules on proximate fouls in out-of-bounds challenges; take-foul definition tightened | Bleacher Report, Deseret News |
| Restricted-area rule | Secondary defender in the arc cannot draw a charge unless jumping vertically; primary defender can | NBA Official (Rule Authority) |

## 4. Enthusiast model
- **What enthusiasts actually talk about:** rotations and minutes; who is starting; lineups ("their best five never plays together"); matchups; coverage choices ("they're in drop and it's getting torched"); shot diet; injuries and load management; trade rumors and cap consequences; the Play-In and seeding math; refs and star treatment; young-player development; draft prospects; the awards races; the bracket; the portal and NIL; whether their team is a contender.
- **Distinctions that matter to them:** shooter vs scorer vs hooper; playmaker vs point guard; rim protector vs rim deterrent; switchable vs not; drop vs switch teams; contender vs pretender; tank vs rebuild vs retool; regular season vs playoff basketball; cap space vs Bird rights vs exceptions; blue blood vs mid-major.
- **Knowledge that signals genuine understanding:** naming a coverage from movement; explaining why a lineup works (spacing and gravity); reading a box score's plus-minus with skepticism; knowing why a trade is or is not possible under the apron; saying "sample size" at the right time; knowing the difference between a charge and a block by the feet.
- **Beginner statements that sound obviously uninformed:** "He scored a touchdown." "Why don't they all just dunk?" "The Lakers are in the Super Bowl." "The point guard is the shortest player." "Why did the ref call a foul? He barely touched him." (a beginner who has not learned the bonus, advantage/disadvantage). "They can just trade for anyone, right?" "The best team wins the title, so the regular season decides it."
- **Common controversies and debates:** GOAT (peak vs longevity vs rings vs era); MVP criteria and narrative; superteams and player empowerment; load management and the 65-game rule; tanking and the lottery; the Play-In and the NBA Cup; whether the three-point era ruined the game; foul-baiting and free-throw rates; officiating consistency and star treatment; NBA Europe and expansion (Seattle, Las Vegas talk); women's game growth, pay and the CBA; college: NIL vs "amateurism", the portal, super-conferences, revenue sharing, quarters vs halves, tournament expansion.

## 5. Interaction model
- **What should the learner EXPERIENCE?** Spacing (see a defense choose), reading a ball screen (see two defenders move), making the charge/block call (see the feet), helping and rotating (see who is left open), leading a break (see the numbers) and attacking a zone (see the gap). Everything else should be quick, reactive and conversational: decode a line, make a call on a diagram, guess a magnitude, order a process.
- **Does the course warrant Unity?** Yes, selectively: six sims where movement, perspective and timing in a scene teach faster than text (Section 12; specs in `sims/`). They are the parts of basketball a beginner cannot "see" from a TV broadcast: what happens away from the ball.
- **Would native interactions be more effective elsewhere?** Yes: terms, rules, shot zones (hotspot-tap), process (sequence-order), magnitudes (estimate-slider), judgment (decision-scenario), conversation (say-this, talk-track), rule calls on diagrams (binary-call), referee signals (visual-id), and 1D timing (timing-tap). Listening exercises are not used.
- **What should NOT be gamified:** GOAT and MVP arguments (they are conversation, not quiz answers); injuries and off-court legal or personal matters; player conduct controversies; the economics of players' pay beyond mechanics (no "who deserves more" scoring); betting, odds and gambling (never taught or promoted); anything that treats the crush's fandom as a test they can fail.
- **Chosen mix (details in Section 12):** 262 multiple-choice, 149 say-this, 31 talk-track, 21 hotspot-tap, 34 term-match, 29 binary-call, 24 decision-scenario, 20 estimate-slider, 16 sequence-order, 13 fill-the-gap, 4 timing-tap, 4 visual-id, plus 9 Unity sim launches of 6 sims.

## 6. Dynamic information requirements
Full plan in `live-data.md`. Summary per spec section 10 (do not invent needs):

| Data | Needed? | Why | Provider candidates (behind adapters, spec section 32) | Refresh | Fallback when down |
|---|---|---|---|---|---|
| Scores | Yes | "Did they win?" is the first question a fan asks | TheSportsDB (MVP); Sportradar / SportsDataIO (upgrade path) | Minutes during games | Last known result with a "as of" stamp |
| Schedules | Yes | What to watch this week | Same | Daily | Cached schedule |
| Standings and seeds | Yes | Seeding and Play-In race | Same | Daily | Cached table |
| Rosters, transactions, injuries | Yes | Trades, signings, injury status change the conversation | Sportradar / SportsDataIO for injuries; league official reports as link-outs; no scraping | Hourly | Cached roster; hide injuries if stale > 24 h |
| Statistics (light) | Yes, limited | Season leaders, team record, box score of last game | Same | Daily | Hide stat cards |
| Rankings (college) | Yes | AP poll and NET context for college | Licensed rankings via data provider; link to the official poll | Weekly | Hide |
| Events (Cup, playoffs, tournament brackets) | Yes | The bracket and series state | Same | Minutes during events; daily otherwise | Cached bracket |
| News | Yes | Editorial layer ("why is everyone talking about this?") | Licensed headline API (open question Q-3); publisher RSS with link-out | Hourly | Editorial cards from our own weekly write-ups |
| Weather, closures, conditions, releases | No | Not relevant to basketball learning | - | - | - |

Structured data (scores, standings) and editorial data (news, explanations) are separate systems (spec section 11).

## 7. Editorial context
- **What commentary helps?** Why a trade matters under the cap rules; why an injury changes a team's rotation; why a coach's timeout or lineup decision was controversial; why a rule change (e.g., a challenge tweak) matters; what a young star's performance means for the season; what a bracket upset means.
- **Appropriate sources:** league and team official releases; wire services and publishers via licensed headline feeds or link-outs; official rulebooks and CBA summaries for rules. Publisher text is never copied.
- **Summarize, explain or link?** Explain in our own words and link to the original (manifest `editorial.approach: explain-and-link`). Short original write-ups (about 90 words) by the Swoon'd editorial process, with a link and headline attribution as the licence allows.
- **Example prompts:** "Why are Knicks fans talking about the second apron?" "Why does this injury matter for the seeding race?" "Why is this trade a big deal?" "What is controversial about the Play-In?" "What did the House settlement change for March Madness?" "Why did the WNBA CBA take so long?"

## 8. Personalization
| Dimension | How it changes examples and live context | Default when unset | Units that use tokens |
|---|---|---|---|
| `league` (branch) | Picks which branch units show, which rule variants appear in exercises, and which live feed is primary | `nba` | all; `branch-college`, `branch-wnba` |
| `team` | Examples use the team's city, colors (as text), rivals and current storylines; live feed prioritizes their games, standings, injuries, transactions | Rotating "team of the week" from the live layer (never assumed to be the crush's) | `{{team}}` in `col-07`, `wnb-06`, `season-live`, `conversation-lab` |
| `player` | Examples and follow-up questions can reference a favorite player; live feed shows their recent games | The team's top scorer from live data, else none | `{{player}}` in `liv-02`, `liv-03`, `conversation-lab` |
| `skill-level` | Sets starting unit and difficulty for sims | `beginner` | Onboarding placement (see Section 10) |
Tokens: `{{team}}`, `{{player}}`, `{{league}}`, `{{conference}}`, `{{rival}}`. Tokens resolve on device from the Person profile; the Person's name and relationship are never used in tokens or notifications (discreet mode). Personalization never changes the foundational curriculum; it changes examples, ordering of review and the live feed.

## 9. Conversation model
- **What might an enthusiast naturally say?** (line -> meaning -> terminology -> good next question)

| # | Line | Meaning | Terms implied | A good follow-up (never fake expertise) |
|---|---|---|---|---|
| 1 | "Our bigs can't switch and everybody knows it." | Her team's centers are too slow to guard guards; opponents attack them after screens. | switch, mismatch, screen | "Who ends up guarding whom?" |
| 2 | "He's a walking bucket but a negative on defense." | Great scorer who costs the team on defense. | bucket, net impact | "Does the team score enough to cover it?" |
| 3 | "We're in the Play-In again." | Their team is seeded 7-10 and must win an extra game. | Play-In, seed | "How many wins away from avoiding it?" |
| 4 | "We shot 5-for-30 from three; the spacing was cramped." | Missed most threes; too few shooters bunched together. | spacing, three-point percentage | "Was it the shots or the ball movement?" |
| 5 | "That was never a charge; he was in the restricted area." | Her team was called for an offensive foul; she thinks the defender was in the no-charge arc. | charge, restricted area | "Was he the primary defender or the help?" |
| 6 | "They're icing everything and we don't have a real handler." | Defense forces the ball toward the sideline on screens; her team lacks a strong ball handler. | ice, ball handler | "Who is your best ball handler?" |
| 7 | "He's sitting out; it's load management." | A healthy star is resting. | load management, back-to-back | "Is it a back-to-back?" |
| 8 | "We can't get to the line; they're not calling anything." | Her team is not shooting free throws; she thinks refs are lenient on the other side. | free throws, whistle | "How many free throws did they get?" |
| 9 | "We just used our trade exception on a defender." | A team absorbed a player's salary using a credit from an earlier trade. | trade exception, cap | "Was that under the apron?" |
| 10 | "Our bench mob is elite; the second unit is outscoring their starters." | Backup players are performing at a high level. | second unit, plus-minus | "Who is the sparkplug off the bench?" |
| 11 | "The portal gutted us; half the rotation transferred." | A college team lost many players through transfers. | transfer portal, rotation | "Who is the coach bringing in?" |
| 12 | "My bracket's dead. A 14 seed beat my champion." | A big first-round upset. | seed, upset, bracket | "Who is the Cinderella?" |
| 13 | "The Fire and the Tempo are so much fun; expansion year vibes." | Enjoying the WNBA's two new teams (Portland and Toronto) in their first season. | expansion, WNBA | "What does a first-year roster look like?" |
| 14 | "He's a hooper. Not just a scorer." | A complete, skilled player who does multiple things well. | hooper, positionless | "What's the difference between a scorer and a hooper?" |
| 15 | "Double-team him and he just kicks it out." | Defenders converge on him; he passes to a teammate who is open. | double team, kick-out | "Who is the shooter he finds?" |

- **How Swoon'd helps without encouraging fake expertise:** every say-this and talk-track rewards honest curiosity: the best replies are real questions; bluffs ("classic 1-4 high issue") lower the Smooth meter; each say-this has a `noFakeExpertNote`. The Conversation Lab includes "when they know far more than you" (`con-06`). We never give canned lines to impersonate an expert, and we never write copy about the crush.
- **Volume:** 24 standalone talk tracks at launch (Talk tab), 31 embedded talk-track activities in lessons, 149 say-this items, and 6 new tracks per season through the live layer.

## 10. Assessment
- **How is useful competence determined?** Concept mastery (0..1) per concept from exercise outcomes and sim mastery signals (ARCHITECTURE.md section 6.1); a concept is "Mastered" at 0.8. Talk Track "Smooth" scores and say-this F-measures show whether concepts transfer to conversation. Spaced review shows retention.
- **The learner should recognize:** court zones, common referee signals, shot types, pick-and-roll coverages, zone names, fouls, the bonus, seeds, playoff rounds, the cap vocabulary, and slang.
- **The learner should understand:** why spacing and shooters open the lane; why a team switches or drops; why a help defender leaves the weakest shooter; why a charge is or is not a charge; how a season and a bracket are structured; why teams tank and how the cap limits contenders.
- **The learner should be able to explain:** "why is she upset?" after a loss; "what does 'in the bonus' mean?"; "why did the coach call a timeout?"; "why is the Play-In a big deal?"; "what changed with NIL?"
- **Situations to interpret correctly:** end-of-game fouling decisions; a late-clock possession; a fast break; a ball screen coverage; a Play-In scenario; a trade under the cap; a college bubble argument.
- **Mastery model:** `concept-mastery-v1`, pass threshold **0.8**. Foundation "Checkpoints" (end of units 1-4) require >= 0.8 on the unit's core concepts; an optional placement quiz in onboarding (12 items) sets the start unit.
- **Useful competence statement:** *After Foundations, one branch and Conversation Lab, you can follow a full game with a fan, decode the common lines ("they're in the bonus", "he can't shoot", "we're in the Play-In"), and ask a genuine follow-up about their team without pretending to be an expert.*
- **Measurement beyond XP:** say-this pass rate (F >= 0.75), talk-track success rate (Smooth >= 60), review retention at 7/30/60 days, and an optional, non-intrusive check-in after two weeks: "Did you talk about it? How did it go?" (feedback only; never gates progress).

## 11. Curriculum map (ongoing course)
Designed as an ONGOING course, not a deck: 15 units, 114 lessons, 389 concepts. Layers: Foundations (31 lessons), Intermediate (31), Enthusiast depth (23), Branches / personalization (13), Current-season / live (8, perpetual), Conversation practice (8, perpetual), plus perpetual spaced review (a policy, not a unit). The unit count is 15 (slightly above the 8-14 planning range) because branches (college, WNBA), the live layer and the Conversation Lab are units in their own right and are kept separate from the 12 content units.

| Layer | Purpose | Minimum expectation | Met by |
|---|---|---|---|
| Foundations | Terms, rules, how it works | 4+ units, ~20+ lessons | 4 units, 31 lessons |
| Intermediate | Strategy, distinctions, context | 4+ units | 4 units, 31 lessons |
| Enthusiast depth | What fans debate; nuance; history/culture | 3+ units | 3 units, 23 lessons |
| Branches / personalization | League-specific rules, calendars, economics, culture; team tokens | one unit per branch | 2 units (college, WNBA); the NBA branch is the default layer, personalized in the live layer |
| Current-season / live | Ongoing, refreshed from live data and editorial | Templates + `live` hooks; new items weekly/seasonally | 1 unit of 8 templated lessons, refreshed weekly |
| Conversation practice | Talk tracks, say-this, "what is she talking about?" | Continuous; 10+ tracks | 1 unit of 8 lessons + Talk tab (24 tracks at launch) + a talk-track or say-this in nearly every unit |
| Perpetual review | Spaced review of mastered concepts | Review policy defined | See "Review policy" below |

### Layer: Foundations

| Unit id | Title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `the-game` | The Game and Its Players | none | 9: Five on five, one hoop; The court, line by line; Two clocks: game and shot; Who has the ball?; How one possession flows; The five positions; Roles over labels: positionless; Reading a box score; Your first hoops chat | objective-of-game, scoring-1-2-3, court-lines, paint-key, three-point-line |
| `rules` | Rules and Officiating | `the-game` | 8: Traveling and the gather step; Dribbling violations; Clock and area violations; Personal and shooting fouls; Free throws, the bonus and techs; Charge or block?; Goaltending and basket interference; Replay, challenges and the L2M | traveling, gather-step, pivot-foot, euro-step, double-dribble |
| `offense` | How Offense Works | `the-game` | 7: Spacing: why the floor is wide; Cuts and off-ball movement; Screens: the picks that free people; Shot types you will hear about; Shot quality: rim, three, free throw; Passing and playmaking; Post play and isolation | floor-spacing, gravity, corner-three, driving-lane, cut |
| `defense` | How Defense Works | `the-game` | 7: Man-to-man basics; Help defense and rotations; Zone defense and how to beat it; Rebounding and the box-out; Rim protection and shot contests; Steals, pressure and traps; Transition defense and the fast break | man-to-man, on-ball-defense, deny-the-pass, closeout, help-defense |

### Layer: Intermediate

| Unit id | Title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `actions` | Actions and Coverages | `offense`, `defense` | 8: Pick-and-roll anatomy; Coverages: drop, hedge, switch, blitz; Reading a coverage live; Handoffs and the DHO; Post entries and split cuts; Pindowns, floppy and getting shooters open; Isolation and mismatch hunting; Late-clock offense | pick-and-roll, screener, ball-handler, roll-man, pick-and-pop |
| `strategy` | In-Game Strategy | `rules`, `offense`, `defense` | 7: Timeouts and after-timeout plays; Rotations and minutes; Small ball and matchups; Foul or not: end-of-game math; Two-for-one and clock management; Series chess: adjustments; Load management and back-to-backs | timeout, after-timeout-play, momentum-run, starting-five, rotation-minutes |
| `analytics` | The Numbers, Explained | `offense` | 7: Points per possession; Efficiency: eFG% and TS%; Usage and stars; All-in-one metrics; Shot charts; Tracking data and play types; Eye test vs numbers | pace, offensive-rating, defensive-rating, net-rating, effective-fg-percentage |
| `league-machine` | How the League Works | `the-game` | 9: NBA structure and the 82-game season; Standings, seeds and tiebreakers; The Play-In Tournament; The playoffs; The NBA Cup; The draft and the lottery; The salary cap in plain English; Trades, free agency and contract types; The calendar: deadline to summer | nba-structure, conference-division, eighty-two-game-season, seeding, tiebreaker |

### Layer: Enthusiast depth

| Unit id | Title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `film-room` | The Film Room | `actions`, `strategy` | 7: Watch everyone except the ball; Named sets: horns, Spain, elevator; Advanced pick-and-roll defense; Gravity and the passing big; Series schemes: drop vs switch vs zone; Shot creation and touch; Diagnose a possession like a coach | off-ball-watching, weak-side, spacing-read, horns-set, spain-pick-and-roll |
| `debates` | The Great Debates | `analytics`, `strategy` | 8: GOAT: how the argument works; MVP and awards arguments; Superteams and player empowerment; Tanking, lottery and the Play-In; Did the three ruin basketball?; Officiating, travels and star calls; Clutch, choking and playoff legends; How to disagree well | goat-debate, peak-vs-longevity, era-adjustment, rings-vs-stats, mvp-criteria |
| `eras-culture` | Eras and Culture | `the-game` | 8: From peach baskets to the shot clock; Russell, Wilt and the 1960s; Magic, Bird and the 1980s; Jordan, the Dream Team and going global; Shaq, Kobe, Duncan and LeBron; Curry, the Warriors and the three; AAU, one-and-done and hoop culture; The current era (as of 2026) | basketball-origins, nba-founding, shot-clock-invention, celtics-dynasty, big-man-era |

### Layer: Branches / personalization

| Unit id | Title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `branch-college` | Branch: College Hoops | `rules`, `league-machine` | 7: College vs NBA rules; March Madness: how the bracket works; Getting in: NET, quad wins and the bubble; Portal, NIL and the House settlement; Conferences, blue bloods and mid-majors; Recruiting and coaching culture; Following {{team}} through the season | college-rules-differences, halves-vs-quarters, college-foul-limits, selection-sunday, first-four |
| `branch-wnba` | Branch: The WNBA | `rules`, `league-machine` | 6: The W: how the league works; WNBA rules and ball differences; The CBA and the money; Draft, expansion and where players play; From campus to the W; Following {{team}} in the W | wnba-structure, wnba-playoff-format, commissioners-cup, wnba-rules-differences, wnba-ball-size |

### Layer: Current-season / live

| Unit id | Title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `season-live` | Season Mode (Live) | `league-machine` | 8: This week in {{league}}; {{team}}: game preview; Why is everyone talking about this?; Injury report decoder; Standings and seeding race; Trades and free agency explainer; Playoff series tracker; Awards and All-Star season | live-weekly-brief, live-game-preview, live-explainer, injury-report, game-time-decision |

### Layer: Conversation practice

| Unit id | Title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `conversation-lab` | Conversation Lab | `the-game` | 8: Opening: the friendly question; When their team loses; When their team wins; The real follow-up question; The GOAT argument, lightly; When they know far more than you; Watching a game together; Texting during the game | conv-ask-follow-up, conv-empathy-loss, conv-celebrate-win, conv-honest-beginner, conv-debate-lightly |

## 11.1 Lessons by unit

#### Unit `the-game`: The Game and Its Players (Foundations, 9 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `gam-01` | Five on five, one hoop | Explain how a game is won and what each basket is worth. | `objective-of-game`, `scoring-1-2-3` | multiple-choice ×3, fill-the-gap, say-this |
| `gam-02` | The court, line by line | Name the lines and zones you will hear about every game. | `court-lines`, `paint-key`, `three-point-line`, `restricted-area-arc`, `free-throw-line` | hotspot-tap ×3, term-match, multiple-choice ×2 |
| `gam-03` | Two clocks: game and shot | Explain the game clock, shot clock and why 24 seconds matters. | `game-clock`, `shot-clock`, `quarters-halves`, `overtime` | estimate-slider ×2, multiple-choice ×2, fill-the-gap |
| `gam-04` | Who has the ball? | Follow possession: jump ball, inbounds, turnovers and the alternating arrow. | `possession`, `inbound`, `turnover`, `jump-ball-arrow` | multiple-choice ×2, binary-call ×2, sequence-order |
| `gam-05` | How one possession flows | Order the phases of a possession from bring-up to shot or foul. | `possession-flow`, `half-court-offense`, `transition-basics` | sequence-order ×2, multiple-choice ×2, say-this |
| `gam-06` | The five positions | Match guard, forward and center to what they usually do. | `point-guard`, `shooting-guard`, `small-forward`, `power-forward`, `center` | term-match ×2, hotspot-tap, multiple-choice ×2 |
| `gam-07` | Roles over labels: positionless | Decode wing, big, 3-and-D and why fans say positionless. | `positionless-basketball`, `wing`, `big-man`, `three-and-d`, `stretch-big`, `sixth-man`, `role-player` | term-match, say-this ×3, multiple-choice |
| `gam-08` | Reading a box score | Read a box score line and say what happened out loud. | `box-score`, `stat-abbreviations`, `fg-percentage`, `plus-minus`, `double-double-triple-double` | fill-the-gap ×2, multiple-choice ×3, say-this ×2 |
| `gam-09` | Your first hoops chat | Handle a casual basketball text without bluffing. | `basic-fan-talk` | talk-track, say-this ×2 |

#### Unit `rules`: Rules and Officiating (Foundations, 8 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `rul-01` | Traveling and the gather step | Explain the gather step and why travel calls confuse everyone. | `traveling`, `gather-step`, `pivot-foot`, `euro-step` | multiple-choice ×3, binary-call ×2, say-this |
| `rul-02` | Dribbling violations | Tell a double dribble from a carry from a clean dribble. | `double-dribble`, `carry-palming`, `backcourt-violation` | binary-call ×4, visual-id, multiple-choice |
| `rul-03` | Clock and area violations | Know the 3-second, 5-second, 8-second and shot-clock violations. | `three-second-violation`, `five-second-violation`, `eight-second-violation`, `shot-clock-violation` | term-match, binary-call ×3, fill-the-gap |
| `rul-04` | Personal and shooting fouls | Sort fouls by type and explain the and-one. | `personal-foul`, `shooting-foul`, `and-one`, `foul-out` | multiple-choice ×3, sequence-order, estimate-slider, say-this |
| `rul-05` | Free throws, the bonus and techs | Explain bonus, technical, flagrant and intentional fouls. | `team-fouls-bonus`, `free-throw`, `technical-foul`, `flagrant-foul`, `intentional-foul` | term-match, decision-scenario, multiple-choice ×2, fill-the-gap |
| `rul-06` | Charge or block? | Judge charge vs block using position, feet and the restricted-area arc. | `charge`, `blocking-foul`, `restricted-area-rule`, `legal-guarding-position`, `verticality` | `unity-sim` `basketball.officiating.charge-block.v1`, binary-call ×3, hotspot-tap, say-this |
| `rul-07` | Goaltending and basket interference | Know when a ball on the way down or up can no longer be touched. | `goaltending`, `basket-interference`, `over-the-back` | binary-call ×3, hotspot-tap, multiple-choice |
| `rul-08` | Replay, challenges and the L2M | Explain replay review, coach challenges and the last-two-minute report. | `replay-review`, `coachs-challenge`, `last-two-minute-report`, `flopping`, `referee-signals` | visual-id ×3, multiple-choice ×2, say-this |

#### Unit `offense`: How Offense Works (Foundations, 7 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `off-01` | Spacing: why the floor is wide | See how shooters at the arc open lanes for everyone else. | `floor-spacing`, `gravity`, `corner-three`, `driving-lane` | `unity-sim` `basketball.spacing.floor-spacing.v1`, multiple-choice ×2, say-this |
| `off-02` | Cuts and off-ball movement | Recognize a backdoor cut and why moving without the ball matters. | `cut`, `backdoor-cut`, `off-ball-movement`, `give-and-go` | multiple-choice ×3, hotspot-tap ×2, say-this |
| `off-03` | Screens: the picks that free people | Explain on-ball and off-ball screens in plain English. | `ball-screen`, `off-ball-screen`, `screen-assist`, `illegal-screen` | term-match, multiple-choice ×3, binary-call ×2 |
| `off-04` | Shot types you will hear about | Name layup, floater, pull-up, step-back, fadeaway, hook and dunk. | `layup`, `floater`, `pull-up-jumper`, `catch-and-shoot`, `step-back`, `fadeaway`, `hook-shot`, `dunk-alley-oop` | term-match ×2, multiple-choice ×3, say-this |
| `off-05` | Shot quality: rim, three, free throw | Estimate why the rim and the arc beat the long two. | `shot-quality`, `midrange-shot`, `three-point-revolution`, `free-throw-rate` | estimate-slider ×3, hotspot-tap ×2, multiple-choice |
| `off-06` | Passing and playmaking | Tell an assist from a hockey assist and a skip pass from a swing. | `assist`, `pocket-pass`, `skip-pass`, `drive-and-kick`, `hockey-assist` | term-match, multiple-choice ×3, say-this ×2 |
| `off-07` | Post play and isolation | Explain a post-up, an isolation and why mismatches get hunted. | `post-up`, `isolation`, `mismatch`, `double-team` | multiple-choice ×3, decision-scenario ×2, say-this |

#### Unit `defense`: How Defense Works (Foundations, 7 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `def-01` | Man-to-man basics | Describe man defense, closeouts and denying the pass. | `man-to-man`, `on-ball-defense`, `deny-the-pass`, `closeout` | multiple-choice ×3, term-match, say-this |
| `def-02` | Help defense and rotations | Read who helps, who rotates and who is left open. | `help-defense`, `the-nail`, `rotation`, `x-out`, `low-man` | `unity-sim` `basketball.defense.help-rotation.v1`, multiple-choice ×2, say-this |
| `def-03` | Zone defense and how to beat it | Describe 2-3, 3-2, 1-3-1 and matchup zones and where the gaps live. | `zone-defense`, `two-three-zone`, `three-two-zone`, `one-three-one-zone`, `matchup-zone`, `box-and-one`, `defensive-three-seconds` | `unity-sim` `basketball.zones.zone-attack.v1`, term-match, hotspot-tap, multiple-choice ×2 |
| `def-04` | Rebounding and the box-out | Explain boxing out, offensive boards and why rebounds swing games. | `box-out`, `offensive-rebound`, `defensive-rebound`, `rebound-percentage`, `second-chance-points` | multiple-choice ×3, binary-call ×2, estimate-slider, say-this |
| `def-05` | Rim protection and shot contests | Explain rim protection, verticality and a good contest. | `rim-protection`, `shot-contest`, `block-shot`, `paint-protection` | multiple-choice ×3, hotspot-tap, say-this |
| `def-06` | Steals, pressure and traps | Describe pressing, trapping and why gambling for steals is risky. | `steal`, `deflection`, `full-court-press`, `trap`, `gambling` | multiple-choice ×3, decision-scenario, say-this |
| `def-07` | Transition defense and the fast break | Read numbers advantages and why getting back matters. | `transition-defense`, `fast-break`, `numbers-advantage`, `trailer`, `take-foul` | `unity-sim` `basketball.transition.fast-break.v1`, multiple-choice ×2, binary-call ×2, say-this |

#### Unit `actions`: Actions and Coverages (Intermediate, 8 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `act-01` | Pick-and-roll anatomy | Name the ball handler, screener, roll, pop and slip. | `pick-and-roll`, `screener`, `ball-handler`, `roll-man`, `pick-and-pop`, `slip-the-screen` | multiple-choice ×3, term-match, sequence-order |
| `act-02` | Coverages: drop, hedge, switch, blitz | Tell drop, hedge, switch, blitz and ice apart. | `drop-coverage`, `hedge-show`, `switch`, `blitz-trap`, `ice-coverage`, `go-over-under` | term-match ×2, multiple-choice ×3, say-this |
| `act-03` | Reading a coverage live | Pick the best action against each coverage as it happens. | `coverage-reading`, `short-roll`, `pocket-pass`, `reject-the-screen` | `unity-sim` `basketball.screens.pnr-read.v1`, multiple-choice ×2, say-this |
| `act-04` | Handoffs and the DHO | Explain a dribble handoff and why teams love it. | `dribble-handoff`, `chase-defender`, `handoff-action` | multiple-choice ×3, binary-call, hotspot-tap |
| `act-05` | Post entries and split cuts | Follow a post entry and the split cut that follows. | `post-entry`, `split-cut`, `high-post`, `elbow` | multiple-choice ×3, hotspot-tap ×2, say-this |
| `act-06` | Pindowns, floppy and getting shooters open | Recognize the screens that free a shooter running off the ball. | `pindown`, `stagger-screen`, `floppy-action`, `flare-screen` | multiple-choice ×3, term-match, hotspot-tap |
| `act-07` | Isolation and mismatch hunting | Explain why offenses force switches and attack the weak defender. | `mismatch-hunting`, `switch-everything`, `isolation-efficiency` | decision-scenario ×3, multiple-choice ×2, say-this |
| `act-08` | Late-clock offense | Understand the 14-second reset and what teams do with 6 seconds left. | `late-clock`, `shot-clock-reset`, `bailout-shot` | timing-tap ×2, multiple-choice ×2, estimate-slider, say-this |

#### Unit `strategy`: In-Game Strategy (Intermediate, 7 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `str-01` | Timeouts and after-timeout plays | Explain why coaches call timeouts and what an ATO is. | `timeout`, `after-timeout-play`, `momentum-run` | multiple-choice ×3, decision-scenario, say-this |
| `str-02` | Rotations and minutes | Follow starters, bench units and staggered stars. | `starting-five`, `rotation-minutes`, `stagger-minutes`, `bench-unit` | multiple-choice ×3, fill-the-gap, say-this |
| `str-03` | Small ball and matchups | Explain small ball, two-big lineups and switchability. | `small-ball`, `two-big-lineup`, `switchability`, `matchup-hunting` | multiple-choice ×3, decision-scenario ×2, say-this |
| `str-04` | Foul or not: end-of-game math | Decide when to foul, when to defend and why up-3 is tricky. | `foul-when-up-three`, `intentional-foul-strategy`, `hack-a-player`, `last-shot` | decision-scenario ×3, multiple-choice ×2, say-this |
| `str-05` | Two-for-one and clock management | Calculate when to shoot early to get two possessions. | `two-for-one`, `clock-management`, `final-possession` | timing-tap ×2, estimate-slider ×2, decision-scenario |
| `str-06` | Series chess: adjustments | Understand how coaches adjust from game to game in a playoff series. | `series-adjustment`, `rotation-shrink`, `home-court-advantage` | multiple-choice ×3, decision-scenario, say-this |
| `str-07` | Load management and back-to-backs | Explain rest, back-to-backs and the 65-game rule. | `load-management`, `back-to-back`, `sixty-five-game-rule` | multiple-choice ×3, fill-the-gap, say-this ×2 |

#### Unit `analytics`: The Numbers, Explained (Intermediate, 7 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `ana-01` | Points per possession | Explain pace, offensive rating, defensive rating and net rating. | `pace`, `offensive-rating`, `defensive-rating`, `net-rating` | estimate-slider ×2, multiple-choice ×3, term-match |
| `ana-02` | Efficiency: eFG% and TS% | Say why a three counts more in eFG% and what TS% adds. | `effective-fg-percentage`, `true-shooting`, `expected-points` | estimate-slider ×2, fill-the-gap, multiple-choice ×2 |
| `ana-03` | Usage and stars | Explain usage rate, PER and what a star profile looks like. | `usage-rate`, `per`, `win-shares` | multiple-choice ×3, say-this ×2 |
| `ana-04` | All-in-one metrics | Decode BPM, VORP and the all-in-one stat family without a math degree. | `box-plus-minus`, `vorp`, `all-in-one-metrics`, `on-off-differential` | term-match, multiple-choice ×3, say-this |
| `ana-05` | Shot charts | Read a shot chart: hot zones, cold zones and the dead midrange. | `shot-chart`, `zone-shooting`, `corner-three-value`, `restricted-area-fg` | hotspot-tap ×3, multiple-choice ×2 |
| `ana-06` | Tracking data and play types | Explain tracking data, screen assists and play-type frequencies. | `player-tracking`, `play-types`, `contested-shot-rate`, `rim-deterrence` | multiple-choice ×3, say-this ×2 |
| `ana-07` | Eye test vs numbers | Use stats to ask better questions instead of ending arguments. | `analytics-vs-eye-test`, `sample-size`, `clutch-stats` | decision-scenario, multiple-choice ×2, say-this ×2, talk-track |

#### Unit `league-machine`: How the League Works (Intermediate, 9 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `lea-01` | NBA structure and the 82-game season | Describe conferences, divisions and the shape of a season. | `nba-structure`, `conference-division`, `eighty-two-game-season` | multiple-choice ×3, fill-the-gap, estimate-slider |
| `lea-02` | Standings, seeds and tiebreakers | Explain seeding and why the 7th seed matters. | `seeding`, `tiebreaker`, `standings-reading` | multiple-choice ×3, sequence-order, say-this |
| `lea-03` | The Play-In Tournament | Walk through the 7-10 seed play-in bracket. | `play-in`, `seventh-eighth-game`, `ninth-tenth-game` | sequence-order ×2, multiple-choice ×2, binary-call |
| `lea-04` | The playoffs | Explain the four best-of-seven rounds and playoff vocabulary. | `playoff-format`, `best-of-seven`, `sweep`, `conference-finals`, `nba-finals` | sequence-order, multiple-choice ×3, fill-the-gap, say-this |
| `lea-05` | The NBA Cup | Explain in-season tournament groups, knockout and what counts. | `nba-cup`, `cup-group-play`, `cup-knockout` | multiple-choice ×3, term-match, say-this |
| `lea-06` | The draft and the lottery | Explain the lottery, rookie scale and tanking. | `nba-draft`, `draft-lottery`, `tanking`, `rookie-scale`, `two-way-contract` | multiple-choice ×3, term-match, say-this ×2 |
| `lea-07` | The salary cap in plain English | Explain a soft cap, luxury tax, aprons and max contracts. | `salary-cap`, `luxury-tax`, `first-apron`, `second-apron`, `soft-cap`, `max-contract`, `supermax`, `mid-level-exception`, `bird-rights` | term-match ×2, multiple-choice ×3, estimate-slider ×2, say-this |
| `lea-08` | Trades, free agency and contract types | Decode player options, sign-and-trades and buyouts. | `trade`, `free-agency`, `restricted-free-agent`, `player-option`, `team-option`, `sign-and-trade`, `trade-exception`, `buyout` | term-match ×2, multiple-choice ×3, decision-scenario, say-this ×2 |
| `lea-09` | The calendar: deadline to summer | Place the trade deadline, draft, free agency and summer league on the year. | `trade-deadline`, `summer-league`, `offseason-calendar` | sequence-order ×2, multiple-choice ×2, say-this |

#### Unit `film-room`: The Film Room (Enthusiast depth, 7 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `flm-01` | Watch everyone except the ball | See spacing, gravity and weak-side action in real possessions. | `off-ball-watching`, `weak-side`, `spacing-read` | `unity-sim` `basketball.spacing.floor-spacing.v1`, multiple-choice ×2, say-this ×2 |
| `flm-02` | Named sets: horns, Spain, elevator | Recognize horns, Spain pick-and-roll and elevator screens. | `horns-set`, `spain-pick-and-roll`, `elevator-screen`, `box-set`, `motion-offense` | term-match ×2, hotspot-tap ×2, multiple-choice ×2, say-this |
| `flm-03` | Advanced pick-and-roll defense | Tell apart tag, top-lock, scram and peel switches. | `top-lock`, `tag-the-roller`, `scram-switch`, `peel-switch`, `late-switch` | `unity-sim` `basketball.screens.pnr-read.v1`, term-match, multiple-choice ×3 |
| `flm-04` | Gravity and the passing big | Explain hub offense and why shooters bend a defense. | `gravity-effect`, `hub-offense`, `passing-big` | multiple-choice ×3, say-this ×2, decision-scenario |
| `flm-05` | Series schemes: drop vs switch vs zone | Follow why a team changes coverage or goes zone as a surprise. | `drop-vs-switch`, `pack-the-paint`, `zone-change-up` | `unity-sim` `basketball.zones.zone-attack.v1`, multiple-choice ×2, say-this ×2 |
| `flm-06` | Shot creation and touch | Name the footwork, fakes and touch that separate scorers. | `shot-creation`, `rim-pressure`, `pump-fake`, `up-and-under`, `touch` | multiple-choice ×3, term-match, say-this ×2 |
| `flm-07` | Diagnose a possession like a coach | Explain why a possession worked or failed in one sentence. | `possession-diagnosis` | decision-scenario ×3, say-this ×3, talk-track |

#### Unit `debates`: The Great Debates (Enthusiast depth, 8 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `deb-01` | GOAT: how the argument works | Explain peak vs longevity vs rings and why nobody wins. | `goat-debate`, `peak-vs-longevity`, `era-adjustment`, `rings-vs-stats` | multiple-choice ×3, say-this ×3, talk-track |
| `deb-02` | MVP and awards arguments | Explain MVP criteria, narrative and voter fatigue. | `mvp-criteria`, `narrative-vs-value`, `award-voting` | multiple-choice ×3, say-this ×2, decision-scenario |
| `deb-03` | Superteams and player empowerment | Explain superteams, loyalty and why fans split. | `superteam`, `player-empowerment`, `loyalty-debate` | multiple-choice ×2, say-this ×3, talk-track |
| `deb-04` | Tanking, lottery and the Play-In | Explain the incentive problem behind tanking and reform ideas. | `tanking-debate`, `lottery-reform`, `play-in-debate` | multiple-choice ×3, say-this ×2, decision-scenario |
| `deb-05` | Did the three ruin basketball? | Explain the pace-and-space complaint and its rebuttal. | `three-point-era`, `midrange-debate`, `foul-baiting` | multiple-choice ×3, say-this ×3, talk-track |
| `deb-06` | Officiating, travels and star calls | Explain why fans yell about the refs and what is actually going on. | `star-treatment`, `travel-creep`, `referee-controversy` | multiple-choice ×3, say-this ×2, decision-scenario |
| `deb-07` | Clutch, choking and playoff legends | Separate clutch myths from what small samples can support. | `clutch-debate`, `ring-counting`, `playoff-performer` | multiple-choice ×3, say-this ×2, talk-track |
| `deb-08` | How to disagree well | Disagree warmly without pretending to be the expert. | `debate-etiquette` | talk-track ×2, say-this ×2 |

#### Unit `eras-culture`: Eras and Culture (Enthusiast depth, 8 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `era-01` | From peach baskets to the shot clock | Place Naismith, the BAA/NBA merger and the 24-second clock. | `basketball-origins`, `nba-founding`, `shot-clock-invention` | sequence-order, multiple-choice ×3, say-this |
| `era-02` | Russell, Wilt and the 1960s | Explain the Celtics dynasty and the first big-man era. | `celtics-dynasty`, `big-man-era` | multiple-choice ×3, say-this ×2 |
| `era-03` | Magic, Bird and the 1980s | Explain why the 1980s built the modern league. | `magic-bird-rivalry`, `showtime`, `bad-boys-era` | multiple-choice ×3, say-this ×2 |
| `era-04` | Jordan, the Dream Team and going global | Explain the Bulls dynasty and the 1992 Olympic team. | `jordan-bulls`, `dream-team`, `global-game` | multiple-choice ×3, say-this ×2, talk-track |
| `era-05` | Shaq, Kobe, Duncan and LeBron | Place the 2000s dynasties and the arrival of LeBron. | `2000s-dynasties`, `lebron-era`, `iso-ball-era` | multiple-choice ×3, say-this ×2 |
| `era-06` | Curry, the Warriors and the three | Explain how the Warriors changed shot selection. | `warriors-dynasty`, `small-ball-revolution`, `three-point-revolution-history` | multiple-choice ×3, say-this ×2, estimate-slider |
| `era-07` | AAU, one-and-done and hoop culture | Explain AAU, one-and-done and sneaker and tunnel culture. | `aau`, `one-and-done`, `sneaker-culture`, `international-pipeline` | multiple-choice ×3, say-this ×2, talk-track |
| `era-08` | The current era (as of 2026) | Place today's stars and teams in the timeline and update it as seasons move. | `current-era-stars`, `generational-shift` | multiple-choice ×2, say-this ×2, talk-track |

#### Unit `branch-college`: Branch: College Hoops (Branches / personalization, 7 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `col-01` | College vs NBA rules | List what changes on the court between college and the pros. | `college-rules-differences`, `halves-vs-quarters`, `college-foul-limits` | multiple-choice ×3, term-match, binary-call ×2 |
| `col-02` | March Madness: how the bracket works | Explain Selection Sunday, seeds, rounds and the bracket. | `selection-sunday`, `first-four`, `bracket`, `sweet-sixteen`, `final-four` | sequence-order ×2, multiple-choice ×3, fill-the-gap |
| `col-03` | Getting in: NET, quad wins and the bubble | Explain the NET, quadrant wins and bubble talk. | `net-rankings`, `quad-wins`, `bubble-team`, `auto-bid`, `at-large-bid` | term-match, multiple-choice ×3, say-this ×2 |
| `col-04` | Portal, NIL and the House settlement | Explain the transfer portal, NIL and revenue sharing in plain English. | `transfer-portal`, `nil`, `revenue-sharing`, `house-settlement`, `eligibility` | term-match, multiple-choice ×3, say-this ×2 |
| `col-05` | Conferences, blue bloods and mid-majors | Sort power conferences, blue bloods and Cinderellas. | `conference-tournament`, `blue-blood`, `mid-major`, `cinderella`, `rivalry` | multiple-choice ×3, term-match, say-this |
| `col-06` | Recruiting and coaching culture | Explain recruiting, commitments and the coaching carousel. | `recruiting`, `commitment`, `coaching-carousel`, `program-culture` | multiple-choice ×3, say-this ×2 |
| `col-07` | Following {{team}} through the season | Follow {{team}}'s season arc from November to March. | `college-season-arc` | multiple-choice ×2, say-this ×2, talk-track |

#### Unit `branch-wnba`: Branch: The WNBA (Branches / personalization, 6 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `wnb-01` | The W: how the league works | Explain the WNBA season, standings and playoff format. | `wnba-structure`, `wnba-playoff-format`, `commissioners-cup` | multiple-choice ×3, sequence-order, fill-the-gap |
| `wnb-02` | WNBA rules and ball differences | Compare WNBA and NBA on quarters, ball and three-point line. | `wnba-rules-differences`, `wnba-ball-size` | term-match, binary-call ×2, multiple-choice ×2 |
| `wnb-03` | The CBA and the money | Explain the 2026 CBA, the cap and why it was a big deal. | `wnba-cba`, `wnba-salary-cap`, `wnba-roster-rules` | multiple-choice ×3, estimate-slider ×2, say-this |
| `wnb-04` | Draft, expansion and where players play | Explain expansion drafts, the draft and offseason leagues. | `wnba-draft`, `expansion-draft`, `offseason-leagues` | multiple-choice ×3, sequence-order, say-this |
| `wnb-05` | From campus to the W | Follow a college star's path to the pros. | `college-to-wnba`, `rookie-contract` | multiple-choice ×3, say-this ×2, talk-track |
| `wnb-06` | Following {{team}} in the W | Follow {{team}} across the season and its playoff race. | `wnba-fandom` | multiple-choice ×2, say-this ×2, talk-track |

#### Unit `season-live`: Season Mode (Live) (Current-season / live, 8 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `liv-01` | This week in {{league}} | Get the week's three storylines explained in plain English. | `live-weekly-brief` | say-this ×3, multiple-choice ×2 |
| `liv-02` | {{team}}: game preview | Know what to watch in {{team}}'s next game. | `live-game-preview` | multiple-choice ×3, say-this ×2 |
| `liv-03` | Why is everyone talking about this? | Understand today's biggest story and why fans care. | `live-explainer` | say-this ×3, multiple-choice ×2 |
| `liv-04` | Injury report decoder | Read Out, Doubtful, Questionable, Probable and game-time decisions. | `injury-report`, `game-time-decision` | term-match, multiple-choice ×3, say-this |
| `liv-05` | Standings and seeding race | Explain the race for seeds and Play-In spots this week. | `live-seeding-race` | multiple-choice ×3, say-this ×2 |
| `liv-06` | Trades and free agency explainer | Explain this week's biggest transaction and the cap logic behind it. | `live-transaction-explainer` | multiple-choice ×3, say-this ×2 |
| `liv-07` | Playoff series tracker | Follow a live series: what changed and what to watch. | `live-series-tracker` | multiple-choice ×3, say-this ×2 |
| `liv-08` | Awards and All-Star season | Understand the awards race, All-Star voting and the Cup. | `live-awards-race` | multiple-choice ×3, say-this ×2 |

#### Unit `conversation-lab`: Conversation Lab (Conversation practice, 8 lessons)

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `con-01` | Opening: the friendly question | Ask a genuine opening question about their team. | `conv-ask-follow-up` | talk-track ×2, say-this ×2 |
| `con-02` | When their team loses | React to a tough loss with empathy, not stats. | `conv-empathy-loss` | talk-track ×2, say-this ×2 |
| `con-03` | When their team wins | Celebrate a big win with real specifics. | `conv-celebrate-win` | talk-track ×2, say-this ×2 |
| `con-04` | The real follow-up question | Ask a follow-up that shows you were listening. | `conv-ask-follow-up`, `conv-honest-beginner` | talk-track ×2, say-this ×3 |
| `con-05` | The GOAT argument, lightly | Take part in a debate without claiming expertise. | `conv-debate-lightly`, `goat-debate` | talk-track ×2, say-this ×2 |
| `con-06` | When they know far more than you | Be honest, curious and charming about what you do not know. | `conv-honest-beginner` | talk-track ×2, say-this ×2 |
| `con-07` | Watching a game together | Follow along in person and ask good questions during play. | `conv-game-watch` | talk-track ×2, say-this ×3 |
| `con-08` | Texting during the game | Text well while a game is on and keep it light. | `conv-text-live` | talk-track ×2, say-this ×2 |

### Review policy (perpetual spaced review)
- **Intervals after mastery:** 1, 3, 7, 14, 30, 60, 120 days (an item reappears at the next interval on a correct answer; a wrong answer drops it two steps and lowers the concept's mastery by 0.15).
- **Max items per review session:** 10 (about 3 minutes); at most 20 per day; review is never a hard gate.
- **Selection:** concepts due, weighted toward the Person's branch and team, then by lowest mastery; at most 3 from any one unit per session; freshly rule-changed concepts (Section 3.6 facts flagged `validThrough`) are re-verified each October and re-queued.
- **Formats:** multiple-choice, fill-the-gap, say-this and one talk-track per week; a sim revisit (difficulty +1) once per month for weak concepts.
- **Season effects:** new-season updates (rules, CBA numbers, awards, rookies) generate review items automatically from the live layer's change log.

### Also
- **Concept count target (Playbook):** 389 concepts in the map (each becomes a `concepts[]` entry in the curriculum JSON); about 84 core terms with Playbook cards at launch (`exercises.md` section 4).
- **Personalization slots:** `league` (branch), `team`, `player`, `skill-level` (Section 8); token lessons: `col-07`, `wnb-06`, `liv-01..08`, `con-01..08`.
- **Release plan:**

| Release | Ships | Timing |
|---|---|---|
| 0.1 (launch) | Units `the-game`, `rules`, `offense`, `defense`, `actions`, `league-machine`, `conversation-lab`, `season-live` (NBA feed), sims `floor-spacing`, `pnr-read`, `charge-block`; Talk tab with 24 tracks; Playbook (84 cards) | Before the 2026-27 NBA opener (20 October 2026) is ideal; otherwise as soon as ready |
| 0.2 | Units `strategy`, `analytics`; sims `help-rotation`, `fast-break` | Before the NBA trade deadline |
| 0.3 | `branch-college`, `film-room`; sim `zone-attack`; college live feed | Before Selection Sunday (March 2027) |
| 0.4 | `branch-wnba`; WNBA live feed; Commissioner's Cup and playoffs templates | Before the 2027 WNBA season |
| 0.5 | `debates`, `eras-culture` | Summer 2027 |
| Ongoing | Weekly live lessons; 6 new talk tracks per season; annual October re-verification of rules, cap numbers and awards; `era-08` refresh each offseason; new sims from the roadmap (handoffs, post double-teams, box-and-one, take fouls) | Perpetual |

## 12. Interaction plan
Rubric applied per CLAUDE.md section 4: Unity only where spatial reasoning, movement, physics, timing in a scene or camera perspective materially improves learning, and a native exercise would teach it clearly worse. Native types link to `docs/native-exercises/CATALOG.md`. Counts are whole-course estimates (curriculum JSON has the items).

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Spacing: place shooters to open the lane (`off-01`, `flm-01`) | floor-spacing, gravity, corner-three, driving-lane, drive-and-kick, weak-side | `unity-sim` `basketball.spacing.floor-spacing.v1` | Spatial reasoning and movement over time: defenders' help decisions depend on placement; a static `hotspot-tap` shows spots but not consequences. Spec: `sims/basketball.spacing.floor-spacing.v1.md` | A | 2 |
| Ball-screen coverage read (`act-03`, `flm-03`) | pick-and-roll, drop-coverage, hedge-show, switch, blitz-trap, ice-coverage, coverage-reading, short-roll | `unity-sim` `basketball.screens.pnr-read.v1` | Dynamic scene reading and camera perspective; a coverage exists only in how two defenders move. `decision-scenario` would spell out the answer as text. Spec: `sims/basketball.screens.pnr-read.v1.md` | A | 2 |
| Charge or block (`rul-06`) | charge, blocking-foul, restricted-area-rule, legal-guarding-position, verticality | `unity-sim` `basketball.officiating.charge-block.v1` | Camera perspective and timing: feet set before contact and arc position are visible only from the right angle in slow motion; `binary-call` on a static diagram has no time axis. Spec: `sims/basketball.officiating.charge-block.v1.md` | A | 1 |
| Help defense and rotation (`def-02`) | help-defense, the-nail, rotation, x-out, low-man, closeout | `unity-sim` `basketball.defense.help-rotation.v1` | Movement of four defenders in sequence and who is left open; `hotspot-tap` shows the nail but not the trade. Spec: `sims/basketball.defense.help-rotation.v1.md` | A | 1 |
| Fast break: numbers and commit (`def-07`) | fast-break, numbers-advantage, transition-defense, trailer | `unity-sim` `basketball.transition.fast-break.v1` | Moving count and a defender's commit at a moment; `timing-tap` is 1D and `binary-call` is static. Spec: `sims/basketball.transition.fast-break.v1.md` | A | 1 |
| Zone attack (`def-03`, `flm-05`) | zone-defense, two-three-zone, three-two-zone, one-three-one-zone, high-post | `unity-sim` `basketball.zones.zone-attack.v1` | Lag in a zone's shift is the concept; only motion shows it. Spec: `sims/basketball.zones.zone-attack.v1.md` | A | 2 |
| Recall checks: terms, rules, "which is true" | all | `multiple-choice` | Default recall type; clearest for rules with exceptions | B | 262 |
| Court zones and spots (nail, elbow, corner three, shot-chart zones) | court-lines, three-point-line, the-nail, shot-chart, high-post, elbow | `hotspot-tap` | Fixed diagram, no motion; if players move, we use a sim instead | B | 21 |
| Rule calls on a diagram (violations, goaltending, backcourt) | violations, goaltending | `binary-call` | Clear two-way rule with a static scene; the moving version is the charge/block sim | B | 29 |
| Term families (court words, coverages, cap words, zones) | positions, coverages, cap terms | `term-match` | 3-5 terms per topic; quick and clear | B | 34 |
| Processes (possession, Play-In, bracket, offseason, pick-and-roll steps) | possession-flow, play-in, bracket | `sequence-order` | The order is the lesson | B | 16 |
| Referee signals (original illustrations) | referee-signals | `visual-id` | Recognition is the skill; original art avoids licensing risk | B | 4 |
| Judgment (end-of-game, timeouts, cap-constrained trades, mismatches) | strategy, cap | `decision-scenario` | "It depends" judgment is the lesson; no fake game | B | 24 |
| Magnitudes (court distances, points per shot, possessions, ratings) | scoring, analytics | `estimate-slider` | A number is the lesson | B | 20 |
| Timing feel (two-for-one, late clock, inbound) | two-for-one, late-clock | `timing-tap` | 1D timing bar is enough; the scene does not matter | B | 4 |
| Vocabulary in context and review | all | `fill-the-gap` | Fast review card | B | 13 |
| "What is she talking about?" | all | `say-this` | The core conversation skill; every unit | B | 149 |
| Conversation practice | conv-* | `talk-track` | Forgiving chat practice | B | 31 |

**Unity candidates considered and rejected (tier rubric):** shot arc and backspin physics ("why lofted shots go in") - physics is real but the social value is low and `estimate-slider`/text teaches enough; free-throw shooting - `timing-tap` (1D); box score reading - native; bracket filling - `sequence-order` and `decision-scenario`; foul counting and bonus - `estimate-slider`/`multiple-choice`; lottery odds - `estimate-slider`; late-clock actions - `timing-tap`. Listening exercises: not used.

## 13. Licensing & safety
| Area | Constraint and handling |
|---|---|
| logos-trademarks | No NBA, WNBA, NCAA or team logos, jerseys with real marks or league-branded assets. Team and league names appear as text in a nominative, descriptive way; no implied endorsement. "March Madness" is an NCAA trademark: use "NCAA tournament" in product chrome and descriptive "March Madness" only after legal review (open question). |
| player-likeness | No player photos, illustrations of real players or player-specific animation. Players are referred to by name in text only when relevant (e.g., live data, editorial); sims use anonymous stylized figures. |
| imagery | All images are original: procedural court diagrams and original referee-signal illustrations (`swoond-original-illustration`). No unlicensed photos; no press images. |
| video | No game footage, clips or highlights are embedded; deep-link out. |
| audio | No licensed audio (no `listening-id`). Sim audio cues are original synthesized sounds. |
| article-text | Publisher article text is never copied; Swoon'd writes its own explanation and links to the original. |
| data-provider-terms | Follow each provider's terms; attribute where required; no unofficial or reverse-engineered NBA/WNBA/NCAA endpoints in production (e.g., no scraping stats.nba.com); adapters normalize data (spec section 32). |
| Gambling | Swoon'd does not teach, promote or link to betting, odds or sportsbooks, and does not show spreads or props. |
| Age and sensitivity | Injuries are explained factually and never gamified; off-court legal or personal stories are not turned into lessons; no gossip. |
| Safety | Not a physical-risk course. The manifest `safetyConstraints` lists content-safety rules instead: no betting content, no gamification of injuries or off-court matters, and never encourage faking expertise. |

## 14. Content assets
| Asset | Type | Source |
|---|---|---|
| `bball-half-court`, `bball-full-court` diagrams | Procedural, drawn natively (SwoondApp) | Original |
| Shot-chart zone diagram (`bball-shot-zones`) | Procedural | Original |
| Referee-signal illustrations (8+) | Vector illustrations | Original; license `swoond-original-illustration` |
| Unity court, players, ball, overlays | Procedural | Original; see each sim spec section 18 |
| Fonts | Instrument Serif, Geist | OFL |
| Audio | Original synthesized cues for sims only | Original |
| Live data and editorial | Adapters | Providers per `live-data.md` |

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. What does a beginner need to understand? Sections 2 and 3 (possession, clocks, positions vs roles, spacing, screens, fouls and the bonus, help defense, seasons and playoffs, the soft cap).
- [x] 2. What do enthusiasts care about? Section 4 (rotations, matchups, coverages, cap and trades, seeding, refs, debates).
- [x] 3. What current information matters? Section 6 and `live-data.md` (scores, standings, injuries, transactions, bracket, editorial explainers).
- [x] 4. What should be interactive? Section 12 (six Unity sims; native types elsewhere).
- [x] 5. What should NOT be gamified? Section 5 (GOAT/MVP arguments, injuries, pay debates, off-court matters, betting).
- [x] 6. How should it personalize? Section 8 (league branch, team, player, skill-level).
- [x] 7. What does conversational competence look like? Sections 9 and 10 (decode lines, honest follow-ups, empathy after a loss).
- [x] 8. What data providers are needed? Section 6 and `live-data.md` (TheSportsDB first; Sportradar/SportsDataIO as upgrades; licensed news API TBD).
- [x] 9. What licensing constraints apply? Section 13.
- [x] 10. How will Swoon'd measure useful understanding? Section 10 (concept mastery, say-this, talk-track, review retention, optional check-in).

Additional gates: [ ] manifest validates (run validator); [ ] curriculum validates (curriculum JSON not yet authored); [ ] every Unity sim has an approved spec (6 specs are drafts pending SME review; see each spec section 23); [ ] every image/audio asset has a license id (referee illustrations use `swoond-original-illustration`); [ ] voice review (cheeky coach, never mean, never about the crush); [x] no copied publisher text.

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Licensed news/editorial provider for the current-context layer (product Q-3); until then, publisher RSS with link-out only | Product | Blocking the live editorial layer, not the launch |
| 2 | Legal review of "March Madness" use in product copy (trademark) | Product / Legal | Blocking `branch-college` copy |
| 3 | Basketball SME review of the six sim reference models (resolver, verdict tables, shift model, rule engine) before Astra starts | Product | Blocking sim approval |
| 4 | Referee SME review of the charge/block rule engine, especially the secondary-defender-in-arc play-on judgment | Product | Blocking `basketball.officiating.charge-block.v1` |
| 5 | Provider for injury reports and transactions with acceptable licence terms (Sportradar vs SportsDataIO vs official link-outs) | Product | Blocking the injury decoder live feed |
| 6 | Should we schedule the launch before the 2026-27 NBA opener (20 Oct 2026) or ship 0.1 after? | Product | No |
| 7 | International (FIBA/EuroLeague) branch timing given the NBA Europe plan (October 2027 target, unconfirmed) | Product | No |
| 8 | Should we add an optional "quarters vs halves" note if the NCAA adopts quarters for men? (track: NCAA has discussed it; not adopted as of 2026-09-30) | Product | No |
| 9 | WNBA data coverage in TheSportsDB (standings, rosters, injuries) and whether WNBA/NCAA need a second provider | Claude | No, before `branch-wnba` live feed |
| 10 | NBA shot-clock reset edge cases (offensive rebound to 14): confirm exact rulebook wording before authoring the item | Claude | No |
