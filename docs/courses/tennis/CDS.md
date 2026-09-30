# Course Design Specification: Tennis (`tennis`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/*.md`, `NOTES_FOR_ORCHESTRATOR.md` |

Time-sensitive facts (rules, formats, calendars, results, rankings) were checked by web search on **2026-09-30** and are tagged **[verify at release]** where a re-check is needed. Several came from a single secondary source; they are listed in `NOTES_FOR_ORCHESTRATOR.md`. Lesson copy never hard-codes them: the live layer and versioned rule tokens carry them (see `live-data.md`). Evergreen lessons teach *how tennis works*; results and rankings are always live data with a snapshot date.

---

## 1. Identity

- **Course ID:** `tennis` (immutable)
- **Display name:** Tennis
- **Category / family:** Sports > Racquet sports > Tennis (family `Sports`)
- **Simulation prefix:** `tennis`
- **Two lenses, one course.** The person you care about may (a) **play** (weekend hitting, club or league doubles, a rating like 3.5) or (b) **follow** it (the four Grand Slams, ATP/WTA weeks, a favourite player) or both. Foundations teach the game as a player experiences it because pro tennis is only legible once you know scoring, the serve and what "breaking" means. Branches then tilt examples and live context.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Pickleball (`pickleball`, wave 1) | Partly on the surface (net, racquet/paddle, cross-court, doubles) but the things people argue about differ: tennis has a big court, a full-power serve with two chances and *service lets*, love-15-30-40 scoring where either side scores every point, no kitchen, a bounce-rule that only limits the return (one bounce, not two), and a huge pro/Slam culture. Tennis instincts *mislead* in pickleball (hit hard, roam) and vice versa. | Adjacent, independent | Neither course requires the other. Cross-links: manifest `relatedCourses` lists `pickleball`; lessons `court-01` and `rec-07` compare the two sports; shared concept names are prefixed differently (`volley-tennis` vs `volley`). Pickleball's manifest already lists `tennis` (P-16 resolved: cross-link only, no merge). |
| Padel, squash, badminton, table tennis | Similar feel; different sports; not in the catalog. | Adjacent (not scheduled) | Analogies only; no dependency. |
| Golf, fitness, fashion (tennis whites, Wimbledon style) | Social-adjacent, no knowledge transfer. | Independent | None. |
| Pro tour worlds (ATP, WTA, Grand Slams, team events) | Learning the game makes you competent about how points and matches work; the *structures* (rankings, seeding, tiers, Slam formats) differ per tour. | Shares foundation | Modelled as branches with tour-specific lessons and live data. |

- **Branches:**

| id | Name | What changes |
|---|---|---|
| `rec-play` | She plays (recreational) | Examples use hitting sessions, NTRP levels (3.0/3.5/4.0), club leagues, doubles nights, gear buying, sore shoulders. Live layer emphasises rules/gear news and "can we play tonight?" weather. **Default branch.** |
| `atp-tour` | ATP Tour fan | Men's tour storylines, Masters 1000 weeks, ATP Finals, Next Gen, favourite player. Sets personalization `league` = ATP. |
| `wta-tour` | WTA Tour fan | Women's tour storylines, WTA 1000 weeks, WTA Finals, favourite player. `league` = WTA. |
| `grand-slams` | Slam-only fan | Follows the four majors and little else: each Slam's identity, a fortnight's rhythm, who to know before a Slam. `league` = Slams. |

Branch choice sets personalization dimension `league` (ATP / WTA / Slams / none) for the three following branches; none = `rec-play`.

---

## 2. Beginner model

**What a complete beginner knows.** Tennis is "the one with the weird scoring", Wimbledon means white clothes and strawberries, that Federer/Nadal/Djokovic/Serena were huge, that people grunt, that "love" means zero. Some know a tiebreak exists. Almost nobody can explain why 40-40 is called deuce, why a set is not "first to 6 points", or why someone "breaking serve" is a big deal.

**Terminology that confuses:** love, deuce, advantage, break point, hold, break, tiebreak, let, fault, double fault, ace, unforced error, winner, slice, topspin, flat, drop shot, lob, passing shot, approach, serve and volley, baseline, tramlines, the T, "the ad court", seed, wild card, qualifier, lucky loser, bagel, breadstick, "Masters 1000", "NTRP 3.5", UTR, "moonball", "frame", "shank", "hawk-eye", "walkover", "retire".

**Common misconceptions (each is a lesson beat):**
1. "Scoring is arbitrary." It is odd but consistent: four points make a game, two clear points win it, six games (two clear) make a set.
2. "A set is first to six *points*." It is six *games*.
3. "You need to win more points to win the match." Not always: you can win fewer total points and still win (the score is about *when* you win them). Breaks and tiebreaks matter more than totals.
4. "A ball on the line is out." Lines are in (any touch of the line is in), including the serve line.
5. "A serve that clips the net is a fault." It is a **let**: replayed, and there is no limit to lets (opposite of pickleball's no-service-let).
6. "You get one serve." Two chances; the second is usually safer; two misses is a double fault.
7. "Tennis is only played on one kind of court." Hard, clay, grass and indoor surfaces change the bounce and who wins.
8. "Serving is enough." Servers win most points at the top level, but breaks decide sets; returning is a skill.
9. "The best players hit the hardest." The best players hit *high-margin* shots: topspin, crosscourt, deep, then attack a short ball.
10. "The Grand Slams are the four biggest tournaments in one place." Four separate events, on different continents and surfaces, run by four different bodies, not by the ATP/WTA.
11. "Rankings are wins." Rankings are a rolling 52-week points total; a title in a bigger event is worth more points.
12. "A tiebreak is sudden death." It is to seven points, win by two (10 in some deciders).

**Concepts that unlock the rest (foundation units):** the court map (baseline, service boxes, the T, alleys), the scoring ladder (point, game, set, match, deuce, tiebreak), the serve (two chances, let, fault) and hold/break, the stroke vocabulary (forehand/backhand, topspin/slice, volley, lob), and line calls. With those, most of a dinner-table sentence about tennis becomes decodable.

---

## 3. Foundational knowledge

Grouped into modules (become `foundationalModules[]` and foundation units).

| Module (unit id) | Content |
|---|---|
| `court-and-game` | Objective; origin (Victorian lawn tennis, Major Walter Clopton Wingfield, 1870s; Wimbledon 1877) **[verify origin wording at release]**; court 78 ft long, 27 ft wide singles, 36 ft doubles; net 3 ft 6 in at the posts, 3 ft in the center; service line 21 ft from the net; service boxes 21 x 13.5 ft; the T; doubles alley 4.5 ft; ball (ITF-approved, optic yellow, about 6.5 to 6.9 cm) and racquet (max length 29 in); lines are in; one-bounce rule (the ball may bounce once, then must be returned). |
| `scoring` | Point names (love, 15, 30, 40); deuce and advantage; game (four points, win by two); set (six games, win by two, tiebreak at 6-6); match (best of three, or five for men at Slams); tiebreak (seven points win by two, serve rotation 1-2-2-2); deciding-set tiebreak (ten points at all four Slams; other events vary); match tiebreak in doubles; serve order and changing ends (odd games); how to read and call a scoreboard (server's score first). |
| `serve-and-return` | Serve rules: behind the baseline, between the center mark and sideline, diagonal into the service box, any method (underhand is legal), toss, foot fault; two chances, fault and double fault; **service let** replayed (unlimited); deuce and ad courts; serve targets (wide, body, T); serve types (flat, slice, kick/topspin); ace and service winner; first-serve percentage; returning: position, blocking a big serve, deep-middle return, "return of serve is the equalizer". |
| `strokes-and-shots` | Forehand, backhand (one- vs two-handed), topspin, slice, flat, volley, half-volley, overhead, drop shot, lob, approach, passing shot, tweener; directions (crosscourt, down the line, down the middle, inside-out, inside-in); slang. |
| `rules-and-officiating` | Calling your own lines and the honesty code; lets, hindrance, double bounces; the chair umpire, code violations and point penalties; the 25-second serve clock, changeover and set-break times, medical timeouts; electronic line calling (three of four Slams; every ATP tour event since 2025; WTA 2026 rulebook) vs human line judges (Roland-Garros in 2026) **[verify at release]**; challenges under legacy systems; coaching rules and conduct. |
| `point-construction` | Percentage tennis and margin (net clearance, depth, target size); why crosscourt is safer; open court and recovery; wrong-footing; serve-plus-one and return-plus-one; when to come to the net; doubles formations (one up one back, both up, Australian and I-formation), poaching, signals, doubles serve order, mixed doubles. |
| `surfaces-styles-gear` | Clay (slow, high bounce, sliding), grass (low, quick, skidding), hard (medium to fast; varies), indoor; court pace ratings; player styles (aggressive baseliner, counterpuncher, serve-and-volleyer, all-court); racquet anatomy (head size, string pattern, weight and balance), string materials and tension (polyester vs natural gut, hybrids), grips (continental, eastern, semi-western, western), balls, shoes. |
| `tours-and-calendar` | ATP, WTA, ITF; Slam, ATP Masters 1000 / WTA 1000, 500, 250; ATP Finals, WTA Finals; season shape (Australian swing, Sunshine Double, clay, grass, North American hard, Asian swing, indoors); ranking points and the rolling 52-week system, the Race; draws, seeds, byes, wild cards, qualifiers, lucky losers; team events (Davis Cup, Billie Jean King Cup, United Cup, Laver Cup); the pathway (juniors, college, ITF, Challenger); Olympics (LA 2028: tennis 14 to 30 July 2028, five events incl. mixed doubles) **[verify at release]**. |
| `rec-life` | Finding a hitting partner and a court; the NTRP scale (2.5 to 5.0+) and self-rating; leagues, ladders, round robins; UTR; warm-up and etiquette (new balls, calling the score, ball between points); common overuse injuries at a very general level; tennis vs pickleball (courts, converted courts, crossover). |
| `reading-a-match` | Stats a fan quotes (aces, first-serve %, break points converted, winners, unforced errors); break points and momentum; long matches and heat; tiebreak dynamics; how to watch a set. |
| `grand-slams` | Australian Open (Melbourne, hard, January), Roland-Garros (Paris, clay, May-June), Wimbledon (London, grass, all-white, June-July), US Open (New York, hard, Aug-Sept); fortnight structure; 128-player draws, best-of-five for men, 32 seeds; career Slam vs calendar Slam; record evergreen (Djokovic 24 men's, Court 24 all-time, Serena 23 Open-era). |
| `history-and-debates` | Open era from 1968; Billie Jean King and equal pay (Slams equalised by 2007); Borg-McEnroe, Evert-Navratilova; Graf, Sampras-Agassi; Williams sisters; the Big Three (Federer, Nadal, Djokovic); the post-Big-Three field; GOAT argument; whites and tradition; line judges vs ELC; the calendar, prize money and the players' association (PTPA); anti-doping process; heat and scheduling. |

**State of the game as of 2026-09-30 (searched; secondary sources; all [verify at release]):**
- **2026 Grand Slam singles winners:** Australian Open: Carlos Alcaraz d. Novak Djokovic (men), Elena Rybakina d. Aryna Sabalenka (women). Roland-Garros: Alexander Zverev d. Flavio Cobolli (men), Mirra Andreeva d. Maja Chwalinska (women). Wimbledon (29 Jun to 12 Jul): Jannik Sinner d. Zverev (men), Linda Noskova d. Karolina Muchova (women). US Open (30 Aug to 13 Sep, prize money about US$108M): Zverev d. Ben Shelton (men, first German winner since 1989 per one source), Rybakina d. Sabalenka (women).
- **Rankings snapshot 14 Sep 2026:** ATP: 1 Sinner, 2 Zverev, 3 Alcaraz, 4 Shelton, 5 Auger-Aliassime. WTA: 1 Rybakina, 2 Sabalenka, 3 Pegula, 4 Gauff, 5 Andreeva. Always shown with a snapshot date.
- **Team/year-end:** Laver Cup 2026, The O2, London, 25 to 27 Sep: Team Europe beat Team World 13-5. ATP Finals: Turin, 15 to 22 Nov 2026. WTA Finals: 8 to 15 Nov, reported moved from Riyadh to Indian Wells (single source; verify). Davis Cup Finals: Bologna, 24 to 29 Nov. The WTA season ends 22 Nov.
- **Rules/tech:** live electronic line calling at the Australian Open, Wimbledon and US Open; Roland-Garros retains human line judges in 2026 and trials wearables (approved biometric devices) at the 2026 Slams; ATP required live electronic line calling at every tour event from 2025 and the 2026 WTA rulebook requires it across 1000/500/250; Wimbledon 2026 reported a first-ever video review of some umpire calls on select courts; 25-second serve clock; deciding-set 10-point tiebreak at 6-6 at all four Slams (Wimbledon joined in 2023).
- **2027:** ATP calendar published; Australian Open starts 17 Jan 2027; seven of nine Masters 1000 use the 12-day, 96-draw format (Monte-Carlo and Paris excepted).

---

## 4. Enthusiast model

**What enthusiasts talk about:**
- Last night's hit or league match: a tight tiebreak, a nasty break of serve, a partner who "poaches everything", a first serve that vanished.
- Ratings and level: "I'm a 3.5 trying to get to 4.0", UTR, self-rated sandbaggers.
- Gear: string tension, polyester "stiff" vs gut, a new racquet, "my elbow", overgrips, shoes on clay.
- Watching: a Slam fortnight, an early-round upset, five-set epics, a favourite's draw, who is peaking for the hard-court swing, Sinner/Alcaraz-type rivalries, Sabalenka-Rybakina-Swiatek-Gauff-Andreeva-type rivalries.
- The tour: injuries and withdrawals, wild cards, ranking points, the punishing calendar, prize money, the Saudi and Asian expansion.
- The GOAT argument and the golden era (Federer, Nadal, Djokovic; Serena).

**Distinctions that matter:** flat vs topspin vs slice; hold vs break; unforced error vs forced error vs winner; first vs second serve; clay vs grass vs hard; baseliner vs serve-and-volleyer; singles vs doubles; ATP Masters 1000 vs 250; Slam vs "just a big event"; NTRP vs UTR; seed vs unseeded; 500 vs Masters.

**Knowledge that signals real understanding:** knowing why a break of serve is so decisive, why players slow the game on clay, why crosscourt is the default rally direction (longer, lower net, more margin, and it recovers you back to center), why you attack a short ball, that the second serve is where matches turn, that ranking points roll off after 52 weeks, and that the four Slams are independent events.

**Beginner statements that sound obviously uninformed:** "Why don't they just hit it harder?"; "So love means zero, why not say zero?"; "Is it first to six points?"; "Wait, they play until someone is two ahead?"; "Isn't Wimbledon on clay?"; "Why is Nadal always so good on grass?" (he is a clay specialist); "The net cord was a fault!"; "All the tournaments are the same."

**Common controversies:**
1. **GOAT** (Federer, Nadal, Djokovic; Serena vs Court; Graf).
2. **Line judges vs electronic line calling** and the Roland-Garros clay-mark exception.
3. **Wimbledon whites and tradition;** roofs and evening sessions; heat rules.
4. **Calendar length and player health;** mandatory events; the 12-day Masters format; Asian and Saudi expansion; the players' association (PTPA) and prize-money split.
5. **Prize money and equal pay;** rankings-based revenue share; qualifiers' pay.
6. **Scoring changes:** no-ad, Fast4, match tiebreak, best-of-five for men only.
7. **Anti-doping process and consistency** (2024-2025 high-profile cases; teach process, not verdicts).
8. **Ball and court speed homogenisation:** "all courts play the same".
9. **On-court coaching and shot-clock enforcement;** code violations and "gamesmanship" (medical timeouts, bathroom breaks).
10. **The Olympics and Davis Cup format** (Finals in November; why some stars skip).

---

## 5. Interaction model

**What she experiences instead of reading.** Tennis is learned through *geometry and margin*: where the ball lands, how high over the net, where you stand next. Most rules and scoring are static logic and stay native. Three concepts are genuinely spatial and dynamic and are taught with Unity:

1. **Serve placement and spin** (aim at wide/body/T, flat vs slice vs kick; first serve vs second serve; the box and the net).
2. **Arc and margin** (how topspin arc, net clearance and depth define the safe target).
3. **Open court and recovery** (after you hit, where you stand determines how much of the court the opponent can hit into).

**Native carries the rest:** scoring (multiple-choice, fill-the-gap, sequence-order, decision-scenario), rules and calls (binary-call), vocabulary (term-match, fill-the-gap), diagrams (hotspot-tap), gear and shot recognition (visual-id with original vector art), etiquette and rec dilemmas (decision-scenario), magnitudes (estimate-slider), the serve toss rhythm (timing-tap), conversation (talk-track, say-this). `listening-id` is deliberately **not used** (see section 12).

**Should NOT be gamified:** injury advice beyond generic caution; line-call disputes as a "win the argument" game (teach the honesty code and de-escalation); NTRP/UTR levels as status; "who is the GOAT" as a scored contest; live rankings as a competitive toy; any prompt that encourages faking a level she does not have. Details in section 12.

---

## 6. Dynamic information requirements

Tennis has a **strong** live layer (year-round, worldwide, ranking- and draw-driven). Swoon'd is not a live-score app (spec section 33): a few minutes of lag is fine, and points-level data is out of scope. Detail in `live-data.md`.

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| schedules / events | Yes | "Is there a Masters on this week?", "Who's in the Wimbledon draw?" | Official ATP/WTA/Slam calendars (curated), ITF calendar; a licensed tennis data provider (Sportradar / Stats Perform class) | weekly (daily on event weeks) | Last verified calendar + official-site link |
| scores (results) | Yes | Finals results, "did she win?" | Licensed provider; TheSportsDB only if coverage confirmed | minutes-during-events (finals/semis; not point-by-point) | Result card omitted; editorial explainer remains |
| rankings | Yes | Movers, "is he still No. 1?" | ATP/WTA official ranking pages (curated snapshot) or licensed provider | weekly (Mondays) | Last snapshot with date |
| standings-like (Race to Turin / Riyadh-Indian Wells) | Yes (Sep-Nov) | Year-end finals qualification | Same | weekly | Static "how the Race works" card |
| rosters/draws | Yes | Draw reading for a Slam/1000 | Official draw pages (curated) or licensed provider | daily on event days | Snapshot |
| injuries / withdrawals | Light | "Why is she out of the draw?" | Official tournament announcements (link-out) | daily on event days | Hidden |
| regulations | Yes | Rulebook/tech changes (ELC, wearables, scoring) | ITF/ATP/WTA/Slam rulebooks (link-out, paraphrase) | on-release | Evergreen explainer |
| news | Yes | Storylines fans discuss today | Publisher headlines link-only; Swoon'd writes the explainer | daily | Evergreen explainer cards |
| weather (optional) | Optional | Roof/rain delays; rec-play "can we play tonight?" | NWS API (US), Open-Meteo (non-commercial caveat) | hourly | Hidden |
| closures / local courts (optional) | Optional | Her home court | OpenStreetMap (`sport=tennis`, ODbL), municipal link-outs | monthly | Hidden |

Structured data and editorial data are separate systems (spec sections 11, 37).

---

## 7. Editorial context

- **What helps:** why a player pulled out; why a ranking move matters; why a Slam decider ended with a 10-point tiebreak; why line-calling technology is contested; why a favourite lost early on this surface; why fans argue about the calendar.
- **Sources:** ITF (rulebooks, Grand Slam rulebook), ATP and WTA (rulebooks, news), the four Slams' official sites; independent tennis media as link-only. Sources in the manifest.
- **Treatment:** explain-and-link (default). Never copy publisher text; rules paraphrased with rulebook section pointers; spec section 11.
- **Example prompts (Ask card):** "Why are tennis fans talking about the calendar today?", "Why did that match end in a 10-point tiebreak?", "What does a Masters 1000 mean for the ranking?", "Why did the seed lose in round two?", "What is a lucky loser?"

---

## 8. Personalization

| Dimension | Values | Effects | Default | Units using tokens |
|---|---|---|---|---|
| `skill-level` | Never played, 2.5-3.0, 3.5, 4.0, 4.5+ (NTRP-style; her level) | Which rec lessons appear first; examples "at her level"; "that's a great 3.5 goal" | 3.5 | `rec-life`, `point-construction`, `branches`, `conversation-lab` |
| `player` | Any pro (from the live roster) | Player spotlight cards, talk tracks ("did you see {{player}} save that break point?"), feed priority | None (generic: "your person's favourite player") | `reading-a-match`, `history-and-debates`, `branches`, `season-now`, `conversation-lab` |
| `league` | ATP / WTA / Slams / none | Chooses branch emphasis and which live cards show | none = `rec-play` | `tours-and-calendar`, `branches`, `season-now` |
| `equipment` | Racquet/strings (optional free text normalised) | Gear talk, string-tension cards | None | `surfaces-styles-gear`, `conversation-lab` |
| `region` | Home city/club | Court/weather context, local link-outs | None | `rec-life`, `branches`, `season-now` |

Tokens: `{{skillLevel}}`, `{{player}}`, `{{league}}`, `{{equipment}}`, `{{region}}`. Unset tokens fall back to generic phrasing, never blank text. Foundations are unchanged by personalization. (No `team`: tennis national-team events are covered by the `league`-independent `team-events` lesson.)

---

## 9. Conversation model

**Ten-plus things an enthusiast might say, with translations:**

| # | Line | Meaning | Terms implied | Good next question |
|---|---|---|---|---|
| 1 | "I got bageled in the first set." | Lost 6-0. | bagel, set | "Ouch. Was it serves or rallies?" |
| 2 | "My first serve completely disappeared." | Her first-serve percentage collapsed; she relied on the second serve. | first serve, double fault | "Did you start double faulting?" |
| 3 | "We broke her at 5-4 and that was it." | Won the opponent's service game at 5-4 to take the set. | break, hold | "What changed on that game?" |
| 4 | "It went to a tiebreak and I choked." | 6-6 seven-point breaker lost under pressure. | tiebreak | "Which point do you think about?" |
| 5 | "She hits so many moonballs." | High, loopy topspin shots to frustrate. | moonball, topspin | "Does it work on you or drive you nuts?" |
| 6 | "I went for the inside-out forehand and it clipped the tape." | Hit a forehand from the backhand side toward the opposite corner; net cord. | inside-out, net cord | "Was that a good shot or a bad bounce?" |
| 7 | "We're a 3.5 team playing up." | League doubles team rated 3.5 playing a higher level. | NTRP, league | "How is the level jump?" |
| 8 | "My string tension is too high, my elbow's screaming." | Stiff strings and high tension jar the arm. | string tension, tennis elbow | "What are you thinking of trying?" (never medical advice) |
| 9 | "Nobody wins Roland-Garros by playing flat." | Clay rewards heavy topspin and patience. | clay, topspin | "Is clay your favourite surface to watch?" |
| 10 | "He's just outlasting people in five sets." | Fitness and tactics in best-of-five. | best-of-five | "Is the Slam format what suits him?" |
| 11 | "The hold at 5-5 was massive." | A hard-fought service game that keeps the set alive. | hold, service game | "What was the key point?" |
| 12 | "They took the Slam final in a match tiebreak." | Deciding-set 10-point breaker at 6-6 (or a doubles match tiebreak). | deciding-set tiebreak | "Do you like 10-pointers or long fifth sets?" |
| 13 | "I love Wimbledon; the grass changes everything." | Low, fast bounce; serve and net play matter. | grass | "Do you prefer the quick points?" |
| 14 | "The line judge missed it! Overrule!" | A human call was wrong; chair umpire can overrule. | line judge, overrule | "Would Hawk-Eye have settled it?" |
| 15 | "Six-four, three-six, seven-six. Absolutely wrecked me." | Read a scoreline as three sets (1-1 then a 7-6 tiebreak decider). | scoreline, set | "Who was serving for it at 5-4?" |

**How Swoon'd helps without encouraging fake expertise:** every conversation item carries a `noFakeExpertNote` and follow-ups that are honest curiosity ("What made that serve work?"), never pretend analysis. Coach notes reward asking real questions and admitting "I'm still learning; explain a break to me?". Cringe replies fake authority ("Actually, love means zero"), dunk on the sport, or make it about her level.

**Targets:** 20 talk tracks at launch (8 authored samples in `exercises.md`), 60+ say-this items, 45+ fill-the-gap items.

---

## 10. Assessment

- **Useful competence** = she can (1) decode what her person says about a match or session, (2) follow a match on court or screen and know what just happened and why it mattered, (3) ask two honest, informed follow-up questions, and (4) join a casual hit or a viewing party without being lost.
- **Recognise:** court lines and boxes; a scoreline; fault vs let vs ace; strokes by name; surfaces; tiers of tournaments; a seed, a wild card; NTRP numbers.
- **Understand:** why the score is built this way; why breaks matter; why crosscourt and topspin are the default; why surfaces change styles; why rankings move; why the Slams are special.
- **Explain (own words):** "what is a break of serve", "how does a tiebreak work", "why do the players like clay or grass".
- **Correctly interpret:** a scoreboard, a scoreline, a ranking table and movement, a draw bracket (bye, seed, qualifier), a rules headline.
- **Mastery model:** `concept-mastery-v1`, pass threshold **0.8**. Review ladder: 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per daily session; a concept falling below 0.6 re-enters at 1d. Sim results contribute masterySignals with the same weights as native (halved with hints).
- **Useful competence statement:** "She can follow a tennis match or a Grand Slam, understand the score, the serve and why a break matters, ask a couple of good questions about a shot or a surface, and say 'okay, I get why you love this' without faking it."

---

## 11. Curriculum map (ongoing course)

Target at launch: `curriculumVersion 0.1.0`. **16 units, 119 lessons, 224 concepts** across all layers. Activity legend: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `es` estimate-slider, `ht` hotspot-tap, `SIM` = Unity sim. Lesson ids are stable kebab-case. Every lesson ends with a "line you could say out loud" and 1-2 Playbook additions. Each unit's last lesson is a mixed-review capstone with a `tk` or `st` beat. Unit count exceeds the 8-14 guidance (P-04 precedent); see section 16 #1.

### Layer 1: Foundations

**Unit `court-and-game`: The Court and the Game** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `court-01` | So what is tennis? | Say in one breath what tennis is and how it differs from pickleball. | tennis-objective, tennis-vs-pickleball, tennis-origin | mc, st |
| `court-02` | The court, measured | Locate baseline, sidelines, net and know the size. | court-dimensions, net-height, baseline-and-sidelines | ht, es |
| `court-03` | Singles lines and doubles lines | Tell the singles court from the doubles court by the alley. | singles-sideline, doubles-alley | ht, bc |
| `court-04` | Service boxes and the T | Map the four service boxes and the T. | service-box, center-service-line, the-t | ht, tm |
| `court-05` | Racquet and ball | Recognise a legal racquet and ball and why balls are pressurised and yellow. | racquet-basics, tennis-ball | vi, mc |
| `court-06` | Lines are in | Know a ball touching any line is in. | lines-are-in | bc, mc |
| `court-07` | How a point plays out | Order a point: serve, return, rally, ending. | point-flow, one-bounce-rule | so, tk |

**Unit `scoring`: Scoring** (prereq: `court-and-game`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `score-01` | Love, fifteen, thirty, forty | Count points in a game. | point-scores, love-score | mc, fg |
| `score-02` | Deuce and advantage | Explain why a game needs two clear points. | deuce-advantage, win-by-two | mc, bc |
| `score-03` | Games, sets, matches | Explain how games build sets and sets build matches. | game-set-match, best-of-three-five | mc, so |
| `score-04` | The tiebreak | Follow a seven-point tiebreak and who serves when. | tiebreak-seven, tiebreak-rotation | so, mc |
| `score-05` | The deciding set | Know how deciding sets end at Slams and elsewhere. | final-set-tiebreak, match-tiebreak | mc, ds |
| `score-06` | Who serves, who switches | Follow serve order and changing ends. | serve-rotation, changeover-ends | so, bc |
| `score-07` | Read the scoreboard | Read a scoreline and a live scoreboard aloud. | score-call-server-first, reading-scoreboard, scoreline | ht, mc |
| `score-08` | Hold, break, and the story of a set | Explain hold and break and tell a set's story from its score. | service-hold, service-break | mc, tk |

**Unit `serve-and-return`: Serve and Return** (prereq: `court-and-game`, `scoring`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `serve-01` | The serve, the rules | State where and how a legal serve is hit. | serve-rules, serve-foot-fault, underhand-legal | bc, tt, mc |
| `serve-02` | Two chances | Explain fault, double fault and why the second serve is safer. | fault-double-fault, first-second-serve | mc, ds |
| `serve-03` | Lets are replayed | Know a net-cord serve that lands in is a let, replayed, unlimited. | service-let | bc, so |
| `serve-04` | Deuce court, ad court | Pick the service side from the score and aim diagonally. | serve-sides, serve-diagonal-tennis | ht, bc |
| `serve-05` | Place it and spin it | Aim a serve at wide, body or T and pick flat, slice or kick. | serve-targets, serve-spins, first-second-serve | SIM `tennis.serve.place-and-spin.v1`, bc |
| `serve-06` | Aces and serve numbers | Read ace, service winner and first-serve percentage. | ace, service-winner, first-serve-percentage | es, mc |
| `serve-07` | Returning serve | Know where to stand and why a deep, middle return is smart. | return-position, return-of-serve, return-deep-middle | ds, ht, tt |

**Unit `strokes-and-shots`: Strokes and Shots** (prereq: `court-and-game`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `stroke-01` | Forehand and backhand | Tell forehand from backhand, one-handed from two-handed. | forehand, backhand, backhand-one-vs-two-handed | tm, vi |
| `stroke-02` | Topspin, slice, flat | Name the three spins by flight and purpose. | topspin, slice, flat-shot | mc, tm |
| `stroke-03` | Volley and overhead | Tell volleys, half-volleys and overheads apart. | volley-tennis, half-volley, overhead-tennis | tm, mc |
| `stroke-04` | Drop shot and lob | Recognise touch shots and why they work. | drop-shot-tennis, lob-tennis | tm, vi |
| `stroke-05` | Crosscourt, down the line | Name shot directions. | crosscourt, down-the-line, down-the-middle, inside-out, inside-in | ht, tm |
| `stroke-06` | Approach, pass, tweener | Decode net-play vocabulary. | approach-shot, passing-shot, tweener | vi, mc |
| `stroke-07` | Say it like a player | Decode slang (bagel, moonball, frame, shank). | tennis-slang, bagel-breadstick | st, fg |

**Unit `rules-and-officiating`: Rules and Officiating** (prereq: `scoring`, `serve-and-return`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rules-01` | Who calls the lines | Handle club line calls fairly. | line-calls-rec, honesty-code | ds, bc |
| `rules-02` | Let, hindrance, double bounce | Call the small rule situations. | let-rule, hindrance, double-bounce | bc, mc |
| `rules-03` | The chair umpire | Explain the umpire's role, code violations and point penalties. | chair-umpire, code-violation, point-penalty | mc, tm |
| `rules-04` | The clocks | Know the 25-second clock, changeover and medical timeouts. | serve-clock-25, changeover-time, medical-timeout | es, mc |
| `rules-05` | Hawk-Eye and electronic line calling | Explain electronic line calling and why Roland-Garros differs. | electronic-line-calling, challenge-system, clay-mark-check | mc, ds |
| `rules-06` | Coaching and conduct | Know what coaching and conduct rules say and why fans argue. | on-court-coaching, racquet-abuse, tennis-etiquette | ds, tk |

### Layer 2: Intermediate

**Unit `point-construction`: Building Points, Singles and Doubles** (prereq: `strokes-and-shots`, `serve-and-return`). 12 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `pc-01` | Percentage tennis | Explain margin for error and high-percentage tennis. | margin-for-error, high-percentage | mc, ds |
| `pc-02` | Arc, spin and the net | Choose arc and target to clear the net with margin. | net-clearance, topspin-arc, margin-for-error | SIM `tennis.rally.arc-and-margin.v1`, bc |
| `pc-03` | Why crosscourt | Explain why crosscourt is the default rally direction. | crosscourt-rally, net-lower-in-middle | ht, mc |
| `pc-04` | Depth and the open court | Spot the open court and choose depth. | depth-control, open-court | ds, ht |
| `pc-05` | Recovery: where to go next | Pick a recovery position that shrinks the opponent's targets. | recovery-position, court-geometry-angles, open-court | SIM `tennis.court.open-court-recovery.v1`, mc |
| `pc-06` | Wrong-footing | Explain change of direction and wrong-footing. | wrong-footing, change-of-direction | ds, st |
| `pc-07` | Serve plus one | Explain serve-plus-one and return-plus-one patterns. | serve-plus-one, first-strike | mc, ds |
| `pc-08` | Coming to the net | Judge when to approach and where to stand. | approach-net-decision, net-position | ds, bc |
| `pc-09` | Doubles: formations | Recognise one-up-one-back, both up, Australian and I-formation. | doubles-formations, one-up-one-back, both-up | ht, so |
| `pc-10` | Doubles: poaching and signals | Decode poaching and hand signals. | poaching-tennis, doubles-signals | ds, tk |
| `pc-11` | Doubles: serving and returning | Follow doubles serve order and return sides. | doubles-serve-order, doubles-return-positions | so, bc |
| `pc-12` | Pro doubles and mixed | Explain match tiebreaks, no-ad and mixed doubles. | match-tiebreak-doubles, mixed-doubles, no-ad-scoring | mc, st |

**Unit `surfaces-styles-gear`: Surfaces, Styles and Gear** (prereq: `strokes-and-shots`). 11 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sgs-01` | Hard, clay, grass | Tell the surfaces apart by bounce and speed. | surface-types, bounce-speed | tm, mc |
| `sgs-02` | Clay: slow and sliding | Explain clay-court play. | clay-court-play, sliding | ds, mc |
| `sgs-03` | Grass: low and quick | Explain grass-court play. | grass-court-play | mc, ds |
| `sgs-04` | Hard courts and indoors | Explain hard and indoor courts. | hard-court-play, indoor-court | mc, es |
| `sgs-05` | Court speed and balls | Explain court pace and why balls matter. | court-pace, ball-pressure | fg, mc |
| `sgs-06` | Baseliner, counterpuncher, net rusher | Name player styles. | player-styles, counterpuncher | tm, ds |
| `sgs-07` | Reading a style | Decode style talk in conversation. | style-talk | st, mc |
| `sgs-08` | What a racquet is made of | Understand head size, weight, balance, string pattern. | racquet-head-size, string-pattern, racquet-weight-balance | tm, vi |
| `sgs-09` | Strings and tension | Contrast polyester, gut, hybrids; tension. | string-materials, string-tension | mc, es |
| `sgs-10` | Grips | Recognise continental, eastern, semi-western grips. | grips-basic, semi-western-grip | vi, tm |
| `sgs-11` | Shoes and the rest | Know shoes, overgrips, new balls; general safety. | tennis-shoes, overgrip, new-balls | ds, mc |

**Unit `tours-and-calendar`: Tours and the Calendar** (prereq: `scoring`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `tours-01` | ATP, WTA, ITF | Untangle who runs what. | atp, wta, itf | tm, mc |
| `tours-02` | The four Slams | List the four Slams with place and surface. | grand-slams-overview | mc, so |
| `tours-03` | Masters 1000 and the tiers | Rank event tiers. | tour-tiers, masters-1000, wta-1000 | tm, mc |
| `tours-04` | The season's shape | Order the season's stretches. | season-shape, sunshine-double | so, mc |
| `tours-05` | Rankings and points | Explain ranking points and rolling 52 weeks. | ranking-points, rolling-52-weeks, the-race | mc, es |
| `tours-06` | Draws, seeds, byes | Read a bracket: seed, bye, wild card, qualifier, lucky loser. | seeding, draw-mechanics, wild-card, qualifier, lucky-loser | tm, ds |
| `tours-07` | Team events | Tell Davis Cup, Billie Jean King Cup, United Cup, Laver Cup apart. | team-events, davis-cup, laver-cup | tm, mc |
| `tours-08` | The pathway and the Olympics | Order the pro pathway; know Olympic tennis. | pro-pathway, olympics-tennis | so, mc |

**Unit `rec-life`: Life at the Courts** (prereq: `scoring`, `rules-and-officiating`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rec-01` | Finding a hit | Know how you get on a court and find a partner. | hitting-partner, court-booking | mc, ds |
| `rec-02` | What 3.5 means | Read NTRP levels. | ntrp-levels | tm, mc |
| `rec-03` | Leagues, ladders, round robins | Recognise rec formats. | league-play, ladders, round-robin-tennis | so, mc |
| `rec-04` | UTR and ratings talk | Understand UTR and rating integrity. | utr, ratings-integrity | mc, st |
| `rec-05` | Warm-up and etiquette | Handle warm-up, ball etiquette, score calls. | warm-up-etiquette, ball-etiquette | ds, mc |
| `rec-06` | Sore arms and common sense | Know generic injury caution. | injury-basics-tennis | ds, mc |
| `rec-07` | Tennis and pickleball, side by side | Compare the two sports honestly. | tennis-pickleball-crossover, service-let, one-bounce-rule | mc, bc |

### Layer 3: Enthusiast depth

**Unit `reading-a-match`: Reading a Match** (prereq: `tours-and-calendar`, `point-construction`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `read-01` | The stats she quotes | Read aces, winners, unforced errors, first-serve %. | winners, unforced-errors, break-points-converted | mc, tm |
| `read-02` | Break points and momentum | Explain break point pressure and momentum talk. | break-point, momentum-tennis | ds, st |
| `read-03` | The long match | Explain best-of-five and heat. | five-set-endurance, heat-and-stamina | mc, ds |
| `read-04` | The big points | Recognise pressure moments (5-4, tiebreak 6-6). | pressure-moments, serving-for-the-set | ds, st |
| `read-05` | A tiebreak, point by point | Follow a tiebreak's strategy. | tiebreak-strategy | so, ds |
| `read-06` | Watch a set with me | Narrate a set with basic vocabulary. | broadcast-reading-tennis | ht, tk |

**Unit `grand-slams`: The Grand Slams** (prereq: `tours-and-calendar`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `slam-01` | The Australian Open | Know its place, surface, feel. | ao-identity | mc, st |
| `slam-02` | Roland-Garros | Know its place, surface, feel. | rg-identity | mc, st |
| `slam-03` | Wimbledon | Know grass, whites and traditions. | wimbledon-identity, wimbledon-traditions | mc, so |
| `slam-04` | The US Open | Know its place, surface, feel. | usopen-identity | mc, st |
| `slam-05` | A Slam fortnight | Follow a fortnight: 128 draw, rounds, best-of-five. | slam-format-128, best-of-five | so, mc |
| `slam-06` | Career Slam, calendar Slam | Tell them apart. | career-slam, calendar-slam | mc, tm |
| `slam-07` | Slam records | Know the evergreen records. | slam-records-evergreen | es, mc |

**Unit `history-and-debates`: History and Debates** (prereq: `tours-and-calendar` or `rec-life`). 9 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hist-01` | Amateurs to the Open era | Explain 1968 and the Open era. | open-era | so, mc |
| `hist-02` | Billie Jean King and equal pay | Explain the equal-pay story. | equal-prize-money, battle-of-the-sexes | mc, st |
| `hist-03` | Borg-McEnroe, Evert-Navratilova | Know the classic rivalries. | classic-rivalries | mc, st |
| `hist-04` | The Williams sisters and the power era | Explain power baseline tennis. | williams-era, power-baseline | mc, st |
| `hist-05` | The Big Three | Explain the Federer-Nadal-Djokovic era. | big-three | mc, ds |
| `hist-06` | The new guard | Explain a rivalry era without hard-coding names. | rivalry-era | mc, st |
| `hist-07` | The GOAT argument | Represent several sides. | debate-goat | st, ds |
| `hist-08` | Tradition vs change | Explain whites, line judges, roofs, scoring tweaks. | debate-tradition, debate-line-judges | ds, st |
| `hist-09` | Calendar, money, fairness | Explain the calendar/prize-money/PTPA and anti-doping process debates. | debate-calendar, prize-money-split, anti-doping-process | st, mc |

### Layer 4: Branches and personalization

**Unit `branches`: Your Person's Tennis World** (prereq: `court-and-game`, `scoring`, `serve-and-return`, `strokes-and-shots`). Branch-gated lessons. 7 lessons.

| Lesson id | Title | Branch | Objective | conceptIds | Activities |
|---|---|---|---|---|---|
| `br-01` | A week at her courts | `rec-play` | Picture the routine. | rec-branch-week | mc, tk |
| `br-02` | Her level, her struggle | `rec-play` | Recognise level struggles. | level-progression-tennis, ntrp-levels | tm, ds |
| `br-03` | Watching the ATP Tour | `atp-tour` | Read an ATP event week. | atp-watching, masters-1000 | mc, st |
| `br-04` | Watching the WTA Tour | `wta-tour` | Read a WTA event week. | wta-watching, wta-1000 | mc, st |
| `br-05` | The Slam-only fan | `grand-slams` | Follow the Slams. | slam-only-fan | mc, tk |
| `br-06` | Her favourite player | any tour branch | Profile `{{player}}`. | favorite-player-profile, player-styles | st, mc |
| `br-07` | Her home club | `rec-play` | Understand her local scene. | local-scene-tennis | mc, ds |

### Layer 5: Current season / live

**Unit `season-now`: Season Now** (prereq: `tours-and-calendar` or `rec-life`). Templated; refreshed by `live` hooks and editorial cards. 5 lesson templates.

| Lesson id | Title | Objective | conceptIds | Activities | Live hook |
|---|---|---|---|---|---|
| `live-01` | This week in tennis | Know what's on and why it matters. | live-weekly-context | mc, st | schedules, events |
| `live-02` | Read the draw | Follow the current event's bracket. | draw-reading | mc, ht | events, results |
| `live-03` | Rankings movers | Interpret who moved and why. | ranking-movement | mc, es | rankings |
| `live-04` | The news explainer | Why is a headline a big deal? | rule-news-explainer | st, mc | news, regulations |
| `live-05` | New season primer | Reset for a new season/Slam. | season-rollover | mc, so | seasonal |

### Layer 6: Conversation practice and perpetual review

**Unit `conversation-lab`: Conversation Lab** (prereq: any three foundation units). 8 lessons; also feeds the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | After her hit | Respond with curiosity to a recap. | convo-follow-up-questions, service-break | tk, st |
| `talk-02` | The line call story | Listen to a dispute without taking sides. | convo-line-call-story, line-calls-rec | tk, st |
| `talk-03` | The new racquet | Ask smart gear questions. | convo-gear-talk, string-tension | tk, st |
| `talk-04` | Watching the final together | Follow along. | convo-watching-together, broadcast-reading-tennis | tk, st |
| `talk-05` | Rating talk | Handle "I'm a 3.5" conversations. | convo-rating-talk, ntrp-levels | tk, st |
| `talk-06` | Her player lost | Handle fandom moods. | convo-fan-moods | tk, st |
| `talk-07` | "Come hit with me" | Accept honestly. | convo-invitation-to-hit, convo-admit-what-you-dont-know | tk, ds |
| `talk-08` | Say-this gauntlet | Decode five lines in a row. | (all layers, sampled) | st |

**Unit `review-loop`: Perpetual Review** (always available after first lesson). 4 lesson templates.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Daily Bite | 1 card from due concepts. | (due concepts) | mc, fg |
| `review-02` | Weekly mix | 3-round session sampled by weakness. | (weak concepts) | mc, bc, ds, tk |
| `review-03` | Score and serve boss | Mastery check on scoring and serve rules. | tiebreak-seven, service-let, deuce-advantage | bc, ds, mc |
| `review-04` | Term blitz | Playbook term drill. | (terms) | tm, fg |

**Review policy:** intervals 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; concept below 0.6 re-enters at 1d.

### Concept targets, personalization slots, release plan

- **Concept count target:** 224 Playbook concepts (Appendix, grouped by unit).
- **Personalization slots:** `{{skillLevel}}`, `{{player}}`, `{{league}}`, `{{equipment}}`, `{{region}}`.
- **Release plan:**
  - **Launch (0.1 to 1.0):** `court-and-game`, `scoring`, `serve-and-return`, `strokes-and-shots`, `rules-and-officiating`, `point-construction`, `rec-life`, `conversation-lab`, `review-loop`; sims 1 and 2 (serve, recovery); `rec-play` branch complete.
  - **Fast follow (1.1):** `tours-and-calendar`, `grand-slams`, `reading-a-match`, `branches` (`atp-tour`, `wta-tour`, `grand-slams`), `season-now` cards; sim 3 (arc and margin).
  - **Ongoing:** `surfaces-styles-gear`, `history-and-debates`; new lessons each season (Slam cards, rule changes each January, ATP/WTA calendar); new talk tracks weekly during Slam fortnights.

### Appendix: Playbook concepts (ids, grouped by unit)

- **court-and-game:** `tennis-objective`, `tennis-vs-pickleball`, `tennis-origin`, `court-dimensions`, `net-height`, `baseline-and-sidelines`, `singles-sideline`, `doubles-alley`, `service-box`, `center-service-line`, `the-t`, `racquet-basics`, `tennis-ball`, `lines-are-in`, `point-flow`, `one-bounce-rule`.
- **scoring:** `point-scores`, `love-score`, `deuce-advantage`, `win-by-two`, `game-set-match`, `best-of-three-five`, `tiebreak-seven`, `tiebreak-rotation`, `final-set-tiebreak`, `match-tiebreak`, `serve-rotation`, `changeover-ends`, `score-call-server-first`, `reading-scoreboard`, `scoreline`, `service-hold`, `service-break`.
- **serve-and-return:** `serve-rules`, `serve-foot-fault`, `underhand-legal`, `fault-double-fault`, `first-second-serve`, `service-let`, `serve-sides`, `serve-diagonal-tennis`, `serve-targets`, `serve-spins`, `ace`, `service-winner`, `first-serve-percentage`, `return-position`, `return-of-serve`, `return-deep-middle`.
- **strokes-and-shots:** `forehand`, `backhand`, `backhand-one-vs-two-handed`, `topspin`, `slice`, `flat-shot`, `volley-tennis`, `half-volley`, `overhead-tennis`, `drop-shot-tennis`, `lob-tennis`, `crosscourt`, `down-the-line`, `down-the-middle`, `inside-out`, `inside-in`, `approach-shot`, `passing-shot`, `tweener`, `tennis-slang`, `bagel-breadstick`.
- **rules-and-officiating:** `line-calls-rec`, `honesty-code`, `let-rule`, `hindrance`, `double-bounce`, `chair-umpire`, `code-violation`, `point-penalty`, `serve-clock-25`, `changeover-time`, `medical-timeout`, `electronic-line-calling`, `challenge-system`, `clay-mark-check`, `on-court-coaching`, `racquet-abuse`, `tennis-etiquette`.
- **point-construction:** `margin-for-error`, `high-percentage`, `net-clearance`, `topspin-arc`, `crosscourt-rally`, `net-lower-in-middle`, `depth-control`, `open-court`, `recovery-position`, `court-geometry-angles`, `wrong-footing`, `change-of-direction`, `serve-plus-one`, `first-strike`, `approach-net-decision`, `net-position`, `doubles-formations`, `one-up-one-back`, `both-up`, `poaching-tennis`, `doubles-signals`, `doubles-serve-order`, `doubles-return-positions`, `match-tiebreak-doubles`, `mixed-doubles`, `no-ad-scoring`.
- **surfaces-styles-gear:** `surface-types`, `bounce-speed`, `clay-court-play`, `sliding`, `grass-court-play`, `hard-court-play`, `indoor-court`, `court-pace`, `ball-pressure`, `player-styles`, `counterpuncher`, `style-talk`, `racquet-head-size`, `string-pattern`, `racquet-weight-balance`, `string-materials`, `string-tension`, `grips-basic`, `semi-western-grip`, `tennis-shoes`, `overgrip`, `new-balls`.
- **tours-and-calendar:** `atp`, `wta`, `itf`, `grand-slams-overview`, `tour-tiers`, `masters-1000`, `wta-1000`, `season-shape`, `sunshine-double`, `ranking-points`, `rolling-52-weeks`, `the-race`, `seeding`, `draw-mechanics`, `wild-card`, `qualifier`, `lucky-loser`, `team-events`, `davis-cup`, `laver-cup`, `pro-pathway`, `olympics-tennis`.
- **rec-life:** `hitting-partner`, `court-booking`, `ntrp-levels`, `league-play`, `ladders`, `round-robin-tennis`, `utr`, `ratings-integrity`, `warm-up-etiquette`, `ball-etiquette`, `injury-basics-tennis`, `tennis-pickleball-crossover`.
- **reading-a-match:** `winners`, `unforced-errors`, `break-points-converted`, `break-point`, `momentum-tennis`, `five-set-endurance`, `heat-and-stamina`, `pressure-moments`, `serving-for-the-set`, `tiebreak-strategy`, `broadcast-reading-tennis`.
- **grand-slams:** `ao-identity`, `rg-identity`, `wimbledon-identity`, `wimbledon-traditions`, `usopen-identity`, `slam-format-128`, `best-of-five`, `career-slam`, `calendar-slam`, `slam-records-evergreen`.
- **history-and-debates:** `open-era`, `equal-prize-money`, `battle-of-the-sexes`, `classic-rivalries`, `williams-era`, `power-baseline`, `big-three`, `rivalry-era`, `debate-goat`, `debate-tradition`, `debate-line-judges`, `debate-calendar`, `prize-money-split`, `anti-doping-process`.
- **branches:** `rec-branch-week`, `level-progression-tennis`, `atp-watching`, `wta-watching`, `slam-only-fan`, `favorite-player-profile`, `local-scene-tennis`.
- **season-now:** `live-weekly-context`, `draw-reading`, `ranking-movement`, `rule-news-explainer`, `season-rollover`.
- **conversation-lab:** `convo-follow-up-questions`, `convo-line-call-story`, `convo-gear-talk`, `convo-watching-together`, `convo-rating-talk`, `convo-fan-moods`, `convo-invitation-to-hit`, `convo-admit-what-you-dont-know`.
- **review-loop:** .

---

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4): Unity only where spatial reasoning, movement, physics, timing in a scene, or camera perspective materially improves learning and a native exercise would teach it clearly worse. **Three** Unity sims; everything else is native.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| `serve-05`: Place it and spin it | serve-targets, serve-spins, first-second-serve, service-box | `unity-sim` `tennis.serve.place-and-spin.v1` (`sims/tennis.serve.place-and-spin.v1.md`) | Rubric: **physics (ball flight, bounce, kick) + spatial reasoning + camera perspective** (behind-server view of the T/body/wide targets and returner). Closest native: `hotspot-tap` teaches which box; it cannot teach why a flat first serve is riskier than a kick second, nor what wide/body/T do to a returner. Static box map remains native (`serve-04`). | A | 1 sim, 12+ scenarios |
| `pc-02`: Arc, spin and the net | net-clearance, topspin-arc, margin-for-error, crosscourt-rally | `unity-sim` `tennis.rally.arc-and-margin.v1` | Rubric: **physics (arc over the net, dip, depth) + side-on camera.** Closest native: `binary-call` on a diagram; a static picture cannot show that topspin lets a fast ball drop in, or that net height and court length change margin. | A | 1 sim, 12+ scenarios |
| `pc-05`: Recovery and open court | recovery-position, court-geometry-angles, open-court, wrong-footing | `unity-sim` `tennis.court.open-court-recovery.v1` | Rubric: **movement + spatial reasoning** (where you stand after you hit decides which angles the opponent can reach). Closest native: `hotspot-tap` (tap the right spot) teaches a static answer, not the shifting-opponent reach cone; the concept is inherently about movement over time. | A | 1 sim, 12+ scenarios |
| Court maps, boxes, alleys, formations, scoreboard | court-dimensions, service-box, doubles-formations, reading-scoreboard | `hotspot-tap` | Fixed diagram, no motion. | B | ~45 |
| Rule calls (lines are in, let, foot fault, hindrance, double bounce) | lines-are-in, service-let, let-rule | `binary-call` | Two-way judgment on a static situation. Ball-mark/ELC review stays native: the diagram shows the mark; no motion needed. | B | ~70 |
| Scoring logic (deuce, tiebreak rotation, who serves) | deuce-advantage, tiebreak-rotation, serve-rotation | `decision-scenario`, `multiple-choice`, `sequence-order`, `fill-the-gap` | State logic; a facts table teaches better than animation. | B | ~90 |
| Vocabulary | strokes, slang, tiers | `term-match`, `fill-the-gap`, `multiple-choice` | Recall and recognition. | B | ~170 |
| Gear/shot recognition | racquet-head-size, grips-basic | `visual-id` (procedural/original vector art, `original-swoond`) | Recognition; no photos/marks. | B | ~25 |
| Magnitudes | court-dimensions, first-serve-percentage, rolling-52-weeks | `estimate-slider` | Numeric intuition. | B | ~20 |
| Serve toss and split-step rhythm | serve-rules, return-position | `timing-tap` | 1D timing bar is enough (rubric: simple 1D timing = native). | B | ~10 |
| Etiquette, line disputes, gear choice, rec dilemmas | honesty-code, ratings-integrity | `decision-scenario` | Judgment with consequences and an expert note; safety notes on injury/heat. | B | ~55 |
| Conversation | all | `talk-track`, `say-this` | Native Talk tab and unit ends. | B | 20 talk tracks + ~80 say-this |
| Season structure, pathway, fortnight, tiebreak order | season-shape, pro-pathway, slam-format-128 | `sequence-order` | Order is the concept. | B | ~20 |

**Not used and why:** `listening-id`: tennis has no distinctive sound concepts that beat text (the "pop" is not diagnostic like a pickleball dink, and umpire calls are cheap to teach as text); broadcast audio is prohibited, and original synthesised audio would add cost without teaching value. Reconsider only for a pace/string sound lesson later. **Rejected Unity candidates:** scoring/tiebreak (native logic); electronic line calling and challenges (native binary-call on an image of the mark; no motion needed); doubles positioning (a pickleball-style coverage sim was considered and deferred: `pc-09` and `pc-10` use native `hotspot-tap` and `sequence-order` and can be revisited in 1.2 if playtests show confusion; it would reuse GK-11 `FormationSet`). Accessibility: each sim has a native fallback lesson named in its spec section 16.

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| Imagery | Procedural or original illustrations only (`original-swoond`); no third-party player or event photos without a written licence; Player cards are text-only. |
| Audio | None at launch (`listening-id` unused). Sim audio is original/synthesised. No broadcast audio. |
| Logos / trademarks | ATP, WTA, ITF, Grand Slam names/logos, Wimbledon, Roland-Garros, US Open, Davis Cup, Laver Cup, racquet brands: text mentions and link-outs only; no logos or tournament artwork. Descriptive naming ("the Australian Open") only; no implication of endorsement. Wimbledon's white-clothing rule is described, not depicted with brand imagery. |
| Video | No embedded broadcast video; deep-link to official streams; official embeds only with permission. |
| Rulebooks | ITF, ATP and WTA rulebooks are copyrighted: paraphrase rules with section pointers; never republish. |
| Data terms | No free official public tennis API. Licensed provider needed for scores/rankings at scale (L-02/L-03 style open question). **Jeff Sackmann's tennis datasets are CC BY-NC-SA: not usable in production.** Curated public facts with attribution until a licence is cleared. UTR requires a partner agreement; NTRP is USTA-owned (concept explained, no ratings data). OSM ODbL attribution. |
| Player likeness | Names as facts only; no likeness, endorsement implication or fabricated quotes. Anti-doping/legal storylines: process only, never verdicts or speculation. |
| News text | Never copied; explain and link (spec section 11). |
| Safety | Injury/health content generic ("warm up, stop if it hurts, see a professional"); no medical claims; heat and hydration mentions generic; the learner is never nudged into a fitness or ability claim. Etiquette and line-call lessons teach de-escalation. |
| Voice/people | Never mock beginners, older players or "tennis people"; jokes target the learner's ignorance, never the crush. |

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Court diagrams (top-down and side-on), scoreboards, draw brackets | Procedural (SVG/SwiftUI/Unity) | Generated | `original-swoond` |
| Serve and rally flight diagrams | Procedural | Generated | `original-swoond` |
| Racquet/grip/ball illustrations | Original vector art | Swoon'd | `original-swoond` |
| Player spotlight cards | Text + facts from curated data | Curated | n/a (no images) |
| Sim scenes | Procedural low-poly court (hard/clay/grass tints), characters, ball | Astra | `original-swoond` |

---

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Court map, scoring ladder, serve/let/fault, hold vs break, strokes and slang, line calls (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Breaks and tiebreaks, surfaces and styles, ratings, gear/strings, Slam fortnights, rankings, the GOAT and tradition debates (section 4).
- [x] 3. **What current information matters?** Calendar, draws, results, rankings and the Race, withdrawals, rule/tech news (section 6).
- [x] 4. **What should be interactive?** Three Unity sims (serve placement/spin, arc and margin, open-court recovery) plus native rules, scoring, gear, conversation (section 12).
- [x] 5. **What should NOT be gamified?** Injury advice, line-call disputes, levels as status, GOAT scoring, rankings as a toy (section 5).
- [x] 6. **How should it personalize?** skill level, player, league (tour), equipment, region (section 8).
- [x] 7. **What does conversational competence look like?** Decode her recap, ask honest follow-ups, admit gaps, accept an invite (sections 9, 10).
- [x] 8. **What data providers are needed?** Licensed tennis data provider (TBD), curated ATP/WTA/Slam calendars, NWS, OSM, link-only editorial (section 6; `live-data.md`).
- [x] 9. **What licensing constraints apply?** Trademarks, rulebooks, broadcast, player likeness, Sackmann NC licence, UTR (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, review ladder, talk-track Smooth >= 60, sim masterySignals, competence statement (section 10).

Additional gates: [ ] manifest validates (see NOTES); [ ] curriculum validates (not yet authored); [x] every Unity sim has a draft spec (`sims/`); [ ] every image/audio asset has a licence id (ids defined, assets not produced); [ ] voice review; [x] no copied publisher text.

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Unit count (16) exceeds the 8-14 guidance; approve or fold (`reading-a-match` into `grand-slams`; `history-and-debates` split later)? | Product | No |
| 2 | Re-verify single-source 2026 facts (WTA Finals moved to Indian Wells; Wimbledon 2026 video review; WTA 2026 ELC rule; Zverev "first German since 1989"). | Content | No (live layer) |
| 3 | Tennis data provider and licence for scores/rankings (Sportradar / Stats Perform class); TheSportsDB coverage of tennis. | Product/Data | Yes for live layer |
| 4 | UTR partner API vs concept-only. | Product | No |
| 5 | Astra: `Court` (tennis) module and key `tennis_court`, `TennisServe`, reuse GK-10/GK-15 (see sim specs). | Astra | Yes for sim build |
| 6 | Trademark reading for Grand Slam names in lesson titles (descriptive use) and "Wimbledon whites". | Legal | No |
| 7 | Cross-links from pickleball: author reciprocal lessons in pickleball's `court-01`/`rec` later (pickleball folder untouched here). | Product | No |
| 8 | Anti-doping storylines: approve "process only" editorial rule. | Product | No |
