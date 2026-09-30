# Course Design Specification: Golf (`golf`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/*.md`, `NOTES_FOR_ORCHESTRATOR.md` |

Time-sensitive facts in this document (results, formats, tour structures, rules cycles) were checked by web search on 2026-09-30 and are tagged **[verify at release]** where a re-check is needed. Lesson copy never hard-codes them: the live layer and versioned rule tokens carry them (see `live-data.md`). Evergreen lessons teach how things work; "who won last week" is never in a static lesson.

---

## 1. Identity

- **Course ID:** `golf` (immutable)
- **Display name:** Golf
- **Category / family:** Sports > Golf (family `Sports`)
- **Simulation prefix:** `golf`
- **Two lenses, one course.** Golf is unusual in that the person you care about may (a) **play** it (weekend rounds, a league night, a range bucket after work, an annual buddies trip), (b) **watch** it (a major Sunday, the Ryder Cup, a tour event on in the background), or (c) both, which is very common. Every foundation unit teaches the game as a *player* experiences it, because tour golf is only legible once you know what par, a penalty area and a green feel like. Branches then tilt examples and live context toward playing (`rec-play`, default) or toward a tour.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Men's and women's pro golf (PGA TOUR, LPGA, DP World Tour, LIV, majors, Ryder/Solheim Cup) | Yes for the *game* (scoring, courses, shots, rules, majors culture); no for each tour's *structure* (cards, points races, team formats, funding politics). | Shares foundation | One course; tours are branches with branch units and live data. Majors and team cups are shared enthusiast units because they cross tours. |
| Tennis (`tennis`, wave 2), pickleball (`pickleball`) | Social-adjacent (all "sports she plays on weekends") but no knowledge transfers: golf is solo against a course, self-officiated, no opponent interference in stroke play. | Adjacent, independent | No dependency. Optional cross-link on "self-officiating culture" only. |
| Mini golf, Topgolf, driving ranges, simulators (TGL) | Partial: shares words (par, hole) but not the game. | Adjacent (not scheduled) | Named in `game-07` as "golf's cousins" so she does not confuse them. |
| Disc golf | Borrows scoring words; different sport, culture, and equipment. | Independent (not in catalog) | One line in `game-07`. |
| Video games (golf games) | No transfer. | Independent | None. |
| Hiking / camping | Shares "walking a beautiful place" and terrain-reading skills (contours), nothing conversational. | Independent | Reuses the Terrain module (GK-20) for green reading only. |

- **Branches:**

| id | Name | What changes |
|---|---|---|
| `rec-play` | She plays (recreational) | Default. Weekend rounds, leagues, handicaps, scrambles, gear, golf trips. Live layer emphasises weather and gear/rules news, not leaderboards. |
| `pga-tour` | PGA TOUR fan | Weekly leaderboards, FedExCup, signature events, Korn Ferry pathway, tour stars. Uses the shared majors and cups units. |
| `lpga-tour` | LPGA fan | LPGA season, Race to the CME Globe, Rolex rankings, five women's majors, Solheim Cup path, Ladies European Tour link. |
| `liv-golf` | LIV Golf fan | Team and individual format, 13 teams, wild cards, funding and future, eligibility debates. |
| `dp-world-tour` | DP World Tour fan | European-based tour, Race to Dubai, Rolex Series, Challenge Tour, road to the Ryder Cup. |

Branch choice sets personalization dimension `league` (PGA TOUR / LPGA / LIV / DP World Tour / none) for the four tour branches.

---

## 2. Beginner model

**What a complete beginner knows.** Golf is "the slow one", that you hit a small ball into a hole in as few strokes as possible, that there is a guy named Tiger, that "birdie" and "hole in one" are things, that people wear collared shirts, and that Sunday golf on TV is quiet and people whisper. Some know "Fore!" and "the Masters, with the green jacket".

**Terminology that confuses:** par, birdie, eagle, bogey, "under par", "thru 14", the cut, handicap, slope, stimp, fairway vs rough, penalty area, drop, mulligan, gimme, scramble, foursomes vs fourball, dormie, "2 & 1", links, "in the hazard", carry, draw/fade, slice/hook, "chunk", "bladed", "yips", pin vs flag, "lag putt", "up and down", "sandy", "greens in regulation", "strokes gained", "signature event", "FedExCup", "Race to Dubai", "captain's pick".

**Common misconceptions (each is a lesson beat):**
1. "The lowest score wins" is right, but beginners think a score of "-8" is bad because it is negative. (`score-03`)
2. "Par means a perfect score." Par is what an expert is expected to take (with two putts); it is a benchmark, not a limit. (`game-03`)
3. "A hole-in-one is one special score." An ace is always one stroke, but its name relative to par depends on the hole: an eagle on a par 3, an albatross on a par 4, a condor on a par 5. (`score-02`)
4. "You can move the ball to a better spot." Golf's core principle: play it as it lies (with specific exceptions and free relief). (`rule-01`)
5. "Out of bounds and water are the same." Different relief and penalties; water is now a *penalty area*. (`rule-03`)
6. "Everyone plays the same tees." Tee markers and course rating/slope adjust for skill and distance. (`cond-04`, `fmt-07`)
7. "A handicap means she is bad." A handicap is a portable measure so unequal players can compete fairly. (`fmt-06`)
8. "Golf is just about hitting it far." Pros separate by short game, putting and management; average golfers lose most strokes inside 100 yards and to penalties. (`short-01`, `mgmt-01`)
9. "A slice is when you hit it left." For a right-hander a slice curves right; a hook curves left. Left-handers mirror. (`club-05`)
10. "Ryder Cup is another tournament." It is a team match play event, no prize money for players; captain matters. (`cup-01`)
11. "LIV and the PGA TOUR are the same sport with different logos." Same game, different formats, business models and eligibility. (`liv-01`)
12. "Golf is only for rich people." Access varies: municipal courses, driving ranges, par-3 courses; cost and access are a real debate, treated with care. (`hist-08`)
13. "You are not allowed to touch the sand." Rules exist about what you can do in a bunker (loose impediments allowed; touching the sand with your club before the stroke is not). (`rule-05`)

**Concepts that unlock the rest (become foundation units):** the hole and par, the scorecard (relative to par), the fourteen clubs and what loft does, the shot-shape idea (start line versus curve), the penalty and relief logic (what you do when you are in trouble), and how putting differs from every other shot (line and speed). With those, "we went to a scramble and I birdied 16" becomes decodable.

---

## 3. Foundational knowledge

Grouped into modules (become `foundationalModules[]` and foundation units).

| Module (unit id) | Content |
|---|---|
| `the-game` | Objective (fewest strokes over 18 holes); parts of a hole (tee box, fairway, rough, green, cup and flagstick); par 3/4/5 and why yardage sets par; hazards (bunkers, penalty areas, out of bounds); round structure (front nine, back nine, the turn, par 72 typical); pace of play; golf's cousins. |
| `scoring` | Stroke play; birdie/eagle/albatross/bogey/double bogey; score to par and leaderboard notation ("-8", "E", "thru 14"); scorecard (gross score, stroke index); what adds a penalty stroke; benchmarks (breaking 100, 90, 80). |
| `clubs-and-swings` | 14-club limit; woods, hybrids, irons, wedges, putter; loft and length; carry distances by skill; swing phases in plain words; the ball-flight idea (start line set mostly by the face, curve by face-to-path); draw, fade, slice, hook, push, pull; mishit vocabulary (fat, thin, top, shank); range vs course. |
| `rules-and-etiquette` | Play it as it lies; out of bounds and lost ball (stroke-and-distance, provisional ball); penalty areas (red/yellow); free relief and dropping from knee height; bunker and putting-green rules; etiquette (honor, ready golf, pitch marks, rakes, quiet); scorecard honesty; when to ask an official. Rules paraphrased, current cycle 2023 edition; the next revision is expected on the four-year cycle **[verify at release]**. |
| `short-game-and-putting` | Why the short game matters; putting line and speed, lag putts; reading greens (fall line, slope, grain, speed); chip vs pitch vs flop vs bump-and-run; carry-and-roll and landing spots; bunker shots and bounce; the yips; gimmes and conceded putts. |
| `course-management` (intermediate) | Playing the hole backward; risk-reward; dispersion and "play your miss"; layups; pin positions and safe sides; wind, elevation and lie; pre-shot routine; strategy talk. |
| `formats-and-handicaps` (intermediate) | Match play and its notation (up, dormie, halved, "3 & 2"); scramble; four-ball; foursomes; shamble; Stableford; skins; Nassau; World Handicap System, Handicap Index, course rating, slope rating, course handicap, net score, stroke index, sandbagging and integrity. |
| `courses-and-conditions` (intermediate) | Links, parkland, heathland, desert; architects and their marks; grass types and green speed (Stimpmeter); tee markers and setup; weather and altitude; famous holes as shared culture. |
| `gear-and-numbers` (enthusiast) | Ball construction and compression; driver, shaft flex and fitting; wedge loft, bounce and grind; launch monitors (ball speed, launch angle, spin rate, smash factor, carry vs total); putters, shoes, rangefinders. |
| `the-majors` (enthusiast) | Four men's majors (Masters, PGA Championship, U.S. Open, The Open), five women's majors (Chevron Championship, U.S. Women's Open, KPMG Women's PGA Championship, Amundi Evian Championship, AIG Women's Open), each one's personality, trophies and history, career grand slam. |
| `team-cups` (enthusiast) | Ryder Cup, Solheim Cup, Presidents Cup: teams, format (foursomes, fourballs, singles), points math, captains and picks, qualification, atmosphere. |
| `history-and-debates` (enthusiast) | Scotland origins and St Andrews; Old Tom Morris and Vardon; Jones; Hogan, Palmer, Nicklaus; Tiger; women's golf history; the distance debate; LIV versus tours; slow play, cost and access. |
| Branch units | `tour-pga`, `tour-lpga`, `tour-liv`, `tour-dpwt`, `branch-rec-play`. |

**State of the game as of 2026-09-30 (verified by web search) [verify at release]:**
- **2026 men's majors:** Masters: Rory McIlroy (back-to-back, 13-under, one shot ahead of Scottie Scheffler; only the fourth player to win consecutive Masters after Nicklaus, Faldo and Woods). PGA Championship at Aronimink: Aaron Rai (-9, by three). U.S. Open at Shinnecock Hills: Wyndham Clark (-4, by one over Sam Burns; wire-to-wire). The Open at Royal Birkdale: Ryan Fox (-10, by one over Cameron Young). McIlroy completed the career grand slam at the 2025 Masters.
- **2026 women's majors:** Chevron Championship (Houston): Nelly Korda; U.S. Women's Open (Riviera): Nelly Korda; KPMG Women's PGA (Hazeltine): Haeran Ryu; Amundi Evian: Haeran Ryu; AIG Women's Open (Royal Lytham & St Annes, 50th edition): Shiho Kuwaki (playoff over Esther Henseleit).
- **PGA TOUR:** Scottie Scheffler won the 2026 FedExCup at East Lake (his second; third win of 2026 season; joins Woods and McIlroy as multiple champions). The 2027 schedule (announced 2026-08-26) has 36 events with eight signature events, a new Sompo Championship, the BMW Championship moving to Liberty National, and a Tour Championship on Aug 26-29, 2027. The PGA TOUR's Returning Member Program (Jan 2026) let Brooks Koepka return from LIV without a suspension.
- **LIV Golf:** 2026 moved to 72-hole events (was 54), 13 teams of four, field of 57 with five wild cards. Saudi Arabia's PIF announced it will end funding after the 2026 season; the league says it has secured a lead investor for 2027 (terms pending). The Michigan team championship was cancelled and the Indianapolis event doubled as the finale.
- **DP World Tour:** 42 events in 25 countries in 2026, five "Global Swings", a Back 9 and season-ending Play-offs; the DP World Tour Championship is Nov 12-15, 2026 at Jumeirah Golf Estates, Dubai. Jon Rahm settled his DP World Tour dispute and is eligible for the 2027 Ryder Cup.
- **Team golf:** Solheim Cup 2026 at Bernardus (Netherlands): Europe 15-13 over USA. Presidents Cup 2026 at Medinah: USA 17-13 over the International Team. Ryder Cup 2027 at Adare Manor, Ireland, 17-19 Sept 2027 (captains Luke Donald for Europe, Jim Furyk for the USA); Europe won the 2025 match at Bethpage Black 15-13.
- **Equipment governance:** on 2026-09-21 the R&A and USGA issued a notice to manufacturers on three optional "near-term" model local rules for elite events from 2028 (a ball with an overall distance standard of 317.0 yards or less, a driver-head CT limit of 239 microseconds, and a club-length cap below 46 inches); comments close Oct 21, 2026. Recreational golfers are not affected. The earlier "rollback" ball proposal for 2028 was superseded by this approach: exact status **[verify at release]**.
- **Handicapping:** World Handicap System revised in 2024 (unplayed-hole handling, nine-hole score combining, shorter yardage minimums for posting); no 2026 change found **[verify at release]**.

---

## 4. Enthusiast model

**What enthusiasts talk about:**
- Their round: "I was 3-over through 9 then made a mess of the back", the one shot that "saved the day", the three-putt they cannot stop thinking about, "I lipped out four putts".
- Their game: handicap movement, breaking 90 or 80, "the driver is the problem today", a slice that will not die, a new putter.
- Gear: a fitting, a new driver (loft and shaft), ball choice ("Pro V1 versus something softer"), wedge bounce, a rangefinder.
- Courses: the muni they love, a bucket-list links trip, greens that were "lightning fast", who designed it, "did you see the pin on 17?".
- Watching: the leaderboard on Sunday afternoon, who "has the honor", "did you see that eagle on 15?", major-week traditions, the Ryder Cup atmosphere, whether a player "has the yips".
- The business and politics: LIV, the distance debate, slow play, pay at women's events, whether golf "belongs" at the Olympics.

**Distinctions that matter:** draw vs fade vs slice vs hook; chip vs pitch vs flop; carry vs total distance; gross vs net; stroke play vs match play; strokes gained vs raw stats (fairways hit, greens in regulation); links vs parkland; fast greens vs slow greens; "a tough setup" vs "a bad course"; short-sided vs middle of the green; bogey golf vs breaking 80; playing "to your handicap".

**Knowledge that signals real understanding:** knowing why you aim at the middle of the green (dispersion, not cowardice); why "how far did you hit it" matters less than "how far did it carry"; understanding that a putt has a line *and* speed, and more speed means less break; knowing that par is a benchmark and that a bogey on a par 5 is a bigger loss than a par 3; knowing that in match play the hole is the unit, not the stroke total.

**Beginner statements that sound obviously uninformed:** "Why don't they just hit it closer?"; "Isn't it a sport where the lowest score wins, so negative is bad?"; "So a hole in one is worth more points?"; "Wait, they don't play each other head to head?" (they do in match play, not in stroke play); "Why do they whisper?"; "Can't you just move the ball?"; "So what's a handicap, like a disability?"; "Is LIV the same as the PGA?"; "Isn't the Masters on a different course every year?" (it is always at Augusta National).

**Common controversies:**
1. **Distance and the ball:** should the governing bodies roll back the ball for elite play; the 2026 model local rule notice; how far pros hit versus the courses built for them.
2. **LIV versus the tours:** exclusivity, funding (PIF ending funding after 2026), team format, world ranking points, majors eligibility, returning players.
3. **Slow play:** shot clocks, penalty stroke enforcement, pace on tour versus at the muni.
4. **Cost and access:** green fees, private clubs, public courses being converted, the cost of equipment; who golf is for.
5. **Women's golf:** prize money gaps, sponsorship, television coverage, the growth of the LPGA's global field.
6. **Course setup and the majors:** "too hard" U.S. Open setups, firm-and-fast links, controversial hole locations.
7. **Rules complexity:** the 2019 modernisation, rulings in high-stakes moments, viewer-called rulings.
8. **Amateur golf issues:** sandbagging, handicap integrity, "gimmes", mulligans (casual etiquette).
9. **Olympics:** whether stroke play with 60 players makes sense; not a big discussion in 2026 but recurs each cycle **[verify at release]**.
10. **Tour format tinkering:** signature events, elevated purses, cut rules, the fall series and FedExCup structure.

---

## 5. Interaction model

**What she experiences instead of reading.** Golf is learned through two kinds of space: a ball in flight and a ball on the ground. Four ideas are genuinely spatial or physical and are taught with Unity:

1. **Ball flight / shot shape:** how the clubface and swing path create a start line and a curve (draw, fade, slice, hook). A static diagram cannot show the ball curving through three dimensions or let her feel cause and effect.
2. **Green reading:** slope, fall line, speed and break on a three-dimensional putting surface. A flat picture cannot show contours; the learner must see the slope flow and roll a ball to feel that more speed means less break.
3. **Course management ("play your miss"):** a hole with hazards and the shape of *your* dispersion. The choice is about probability mass over space; an overhead map with a dispersion oval makes it click.
4. **Carry and roll:** the landing spot versus where the ball ends up, with different clubs and green speeds. The physics of "carry it to here, let it run to there" is the whole lesson.

**Native carries the rest:** rules and relief (decision-scenario, hotspot-tap on static diagrams, binary-call), scoring and formats (sequence-order, multiple-choice, fill-the-gap, decision-scenario), terminology (term-match, fill-the-gap), course and equipment recognition (visual-id with original illustrations), the numbers of golf (estimate-slider), the tempo of the swing (timing-tap, honestly 1D), conversation (talk-track, say-this), and the sound of the game (listening-id with original audio).

**Should NOT be gamified:** the pro-golf drama beyond facts (LIV politics are explained, never "sides" to win); injuries and back pain (generic care only, see section 13); alcohol on the course (never celebrated); gambling and betting odds (the course explains formats like skins and Nassau as friendly wagers but never promotes betting or odds); "who is best" pro rankings as a competitive toy; anything that shames a beginner's slowness or a high handicap; and rules-lawyering as a way to "win" arguments (the lesson is honesty and asking for help).

Details in section 12.

---

## 6. Dynamic information requirements

Golf has a **strong tour layer** (leaderboards, majors, cups, rankings) and a **thin evergreen layer** for recreational players. Spec section 33 applies: Swoon'd is not a live-scoring app; a few minutes of lag is fine. Detail in `live-data.md`.

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| schedules | Yes | "What's on this week?" and "Is it a major?" start most conversations | Official tour calendars (PGA TOUR, LPGA, DP World Tour, LIV; curated first), Sportradar Golf / SportsDataIO (upgrade), TheSportsDB (only if coverage confirmed) | weekly | Last verified calendar plus official-site link |
| events | Yes | Event type (major, signature, cup, playoff) drives context cards | same | weekly | same |
| scores (leaderboards) | Yes | Reading "-8 thru 14", cut line, who leads | Sportradar Golf, SportsDataIO Golf (licensed) ; TheSportsDB if coverage | minutes-during-events | Round summary card after the round; "check the official leaderboard" link |
| standings | Yes | FedExCup, Race to the CME Globe, Race to Dubai, LIV points | Same licensed providers; official standings pages (curated) | daily | Last snapshot with date |
| rankings | Yes | Official World Golf Ranking, Rolex Women's World Golf Rankings | Official ranking sites (curated snapshot); licensed provider if terms allow | weekly | Snapshot with date shown |
| rosters | Yes | Ryder/Solheim/Presidents Cup teams and standings; LIV teams | Official team pages (curated), licensed provider | event-driven | Snapshot |
| statistics | Light | Strokes gained explainer, driving distance and accuracy | Licensed provider only; otherwise evergreen numbers | weekly | Hidden; evergreen explainer |
| news | Yes | Rule changes, LIV funding, distance debate, injuries, withdrawals | Link-only headlines from official sources and golf media; editorial explainers by Swoon'd | daily | Evergreen explainers |
| regulations | Yes | Rules of Golf revisions, equipment conformity, model local rules | R&A and USGA pages (link + own-words explanations) | monthly (event-driven) | Evergreen |
| new-products | Light | New drivers, balls, conforming list | Brand press pages (link-only), USGA conforming lists (link) | monthly | Skip |
| weather | Optional (rec) | "Can we play Saturday?" wind, rain, heat, lightning | National Weather Service API (US); commercial weather provider later | hourly | Hidden |
| conditions (course) | Optional (rec) | Home course context: frost delay, cart-path-only | Course websites (link-out only; no uniform API) | daily | Hidden |

Structured data and editorial data are separate systems (spec sections 11, 37). No betting odds, ever.

---

## 7. Editorial context

- **What helps:** why a leaderboard is tight ("what does -14 mean at a U.S. Open"), why a ruling is being debated, why the ball rollback matters to her weekend game (it does not, directly), why LIV changes tour politics, why a Ryder Cup captain's pick is controversial, why a putter change is news.
- **Sources:** R&A and USGA (rules and equipment governance; link + own-words explanation), PGA TOUR, LPGA, DP World Tour and LIV official news (link), golf media such as Golf Channel, GOLF.com, Golf Digest, Sky Sports Golf (headline-level, link-only).
- **Treatment:** explain-and-link (default). Never copy publisher text; Rules of Golf are paraphrased in Swoon'd's words with rule numbers cited.
- **Example prompts (Ask card):** "Why are golf fans arguing about the ball today?", "What does 'thru 14, -6' tell me?", "Why did the ruling matter?", "Why is the Ryder Cup captain's pick controversial?", "What is the cut and who's on the bubble?", "Why does everyone care about the Masters?"

---

## 8. Personalization

| Dimension | Values | Effects | Default | Units using tokens |
|---|---|---|---|---|
| `skill-level` | Never played, 25+, 15-24, 8-14, single digits (handicap band) | Which strategy examples appear first; talk-track lines "at her level"; management sim carries the matching dispersion profile | 15-24 band ("about a 20") | `course-management`, `formats-and-handicaps`, `short-game-and-putting`, `branch-rec-play` |
| `player` | Any golfer (e.g. Scottie Scheffler, Rory McIlroy, Nelly Korda, Jon Rahm, Bryson DeChambeau from the live roster) | Player spotlight cards; talk tracks ("did you see {{player}}'s eagle?"); feed prioritisation | None (generic) | `the-majors`, `tour-*`, `season-now`, `conversation-lab` |
| `league` | PGA TOUR / LPGA / LIV / DP World Tour / none | Chooses branch emphasis and which live cards lead | none = `rec-play` | `tour-*`, `season-now` |
| `team` | LIV team (e.g. Legion XIII, 4Aces GC); also Ryder/Solheim side (USA / Europe) | Team feed, cup-week talk tracks | None | `tour-liv`, `team-cups`, `season-now` |
| `equipment` | Driver/ball/putter brand (optional free text, normalised) | Gear talk cards, conforming-list news pinned | None | `gear-and-numbers`, `season-now` |
| `region` | Her home course or city | Weather ("can we play Saturday?"), local course context, links | None | `branch-rec-play`, `courses-and-conditions`, `season-now` |

Tokens: `{{skillLevel}}`, `{{player}}`, `{{league}}`, `{{team}}`, `{{equipment}}`, `{{region}}`. Unset tokens fall back to generic phrasing ("your person's favorite golfer"), never blank text. The foundation curriculum is unchanged by personalization.

---

## 9. Conversation model

**Fourteen things an enthusiast might say, with translations** (each becomes a say-this or talk-track):

| # | Line | Meaning | Terms implied | Good next question |
|---|---|---|---|---|
| 1 | "I broke 90 for the first time!" | Shot fewer than 90 strokes over 18 holes, a real milestone for many golfers. | breaking-100-90-80, score-benchmarks | "What finally clicked for you?" |
| 2 | "My driver was a slice machine and I lost three balls." | Her tee shots curved hard right; each lost ball costs a penalty stroke and time. | slice, lost-ball, stroke-and-distance | "Did it start left and then peel off, or start right?" |
| 3 | "I two-putted from 50 feet, I'll take that." | A long putt finished close enough that she needed exactly two putts, a good outcome; "lag putt" skill. | lag-putt, putting | "Was it fast or slow up there?" |
| 4 | "We got up and down from the bunker on 17." | She got out of the sand and holed the next putt: a par-saving skill. | up-and-down, bunker-shot | "Was it a fluffy lie or hard-packed?" |
| 5 | "It was a scramble, so I only had to hit three good shots." | Team format where everyone plays from the best ball; fewer pressure shots individually. | scramble | "Did you use her tee shots or yours?" |
| 6 | "I'm a 14 now, was a 17 in March." | Handicap Index dropped by three; she is playing better relative to par. | handicap-index | "Which part of the game moved it most?" |
| 7 | "I three-jacked four times." | Three putts on four holes; a scoring leak. | three-putt, putting | "Was it lag speed or the short ones?" |
| 8 | "Rory came back on the back nine." | The leader wavered and McIlroy played the last nine holes better than the first. | the-turn, leaderboard-reading | "Was it the par 5s or the putter?" |
| 9 | "He's got the honor on the next tee." | The player with the best score on the previous hole tees off first. | honor-system | "Do you play with the honor rule in your group?" |
| 10 | "The cut is projected at +2." | After two rounds only the players at or better than +2 play the weekend. | cut-line | "Who is right on the bubble?" |
| 11 | "This U.S. Open setup is brutal." | The USGA made the course very hard (narrow fairways, thick rough, fast greens). | us-open-setup | "Is the rough what's getting them, or the greens?" |
| 12 | "Did you see the captain's pick?" | The Ryder Cup captain chose a player who did not qualify automatically. | captains-picks | "Was it a controversial one?" |
| 13 | "They got 4 and 3'd in foursomes." | One pair lost the match by four holes with three left, in alternate-shot format. | match-result-notation, foursomes | "Who was hitting the tee shots?" |
| 14 | "New wedges, 56 with more bounce; the sand is a joke now." | Her new sand wedge has 56 degrees of loft and a sole shaped to slide, helping in soft sand. | bounce-grind, wedge-loft-gapping | "Do you play in soft sand a lot?" |

- **What could the learner meaningfully ask next?** Follow-ups about the *feeling* (what clicked, what went wrong) and one honest curiosity question tied to a term she just learned. Never a fake technical claim.
- **How Swoon'd helps without encouraging fake expertise:** every say-this carries a `noFakeExpertNote` ("You do not need to know her swing; ask what she felt"); talk-tracks reward curiosity and penalise bluffing; the Talk Track coach note names what was honest.
- **Target counts:** 18 talk tracks at launch (10 standalone Talk-tab scenarios, 8 unit-end conversation beats) and about 80 say-this items across the course (see `exercises.md` sections 4-5).

---

## 10. Assessment

- **Useful competence** = she can (1) decode what her person says about a round in progress or a completed one, (2) follow a tour event or a major on screen and understand the leaderboard, the format and what just happened, (3) ask two honest, informed follow-up questions, and (4) join a casual round or a viewing party without being lost.
- **Recognise:** scoring terms and leaderboard notation; the clubs and what they do; a shot shape by name; a penalty-area situation; formats (scramble, match play, four-ball); the majors; the team cups.
- **Understand:** why par is a benchmark; why a slice curves; why you aim at the middle of the green; why a putt has line and speed; why a handicap exists; why the Ryder Cup is match play; why the ball debate matters to pros but not to her.
- **Explain:** in her own words, "what is a birdie", "how does the cut work", "what does 2 & 1 mean", "why is LIV controversial".
- **Correctly interpret:** a scorecard, a leaderboard line, a match-play result, a handicap, a green (which way it breaks).
- **Mastery model:** `concept-mastery-v1`, pass threshold **0.8** (foundation and intermediate concepts held to 0.8; enthusiast-depth and live-context concepts count as Familiar at 0.6 for reporting). Review interval ladder (Leitner boxes): 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per daily session; a concept slipping below 0.6 re-enters the ladder at 1d. Sim results contribute masterySignals with the same weights as native (halved when hints are used).
- **Useful competence statement:** "She can follow a round or a golf broadcast, understand par, penalties, formats and the big events, ask a couple of good questions about a shot, a putt or a course, and say 'okay, I get why you love this' without faking it."

---

## 11. Curriculum map (ongoing course)

Course version target at launch: `curriculumVersion 0.1.0` (structure + first units); see release plan. **20 units, 116 lessons, ~205 concepts** across all six layers. Activity legend: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap, `SIM` = Unity sim (id given). Each lesson lists its *lead* activity families; the authored lesson has 4-6 activities (validator rule `thin-lesson`), ends with one item that carries a "line you could say out loud", and adds 1-3 Playbook terms. Every unit's final lesson is a mixed-review capstone with one `tk` or `st` conversation beat. Lesson ids are stable kebab-case. A learner sees about 16 units (only the branch unit that matches their branch appears).

### Layer 1: Foundations

**Unit `the-game`: The Game and the Course** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `game-01` | So what is golf? | Say in one breath what golf is and how you win. | golf-objective, stroke, round-18 | mc, st |
| `game-02` | Anatomy of a hole | Name the tee box, fairway, rough, green, cup and flagstick. | tee-box, fairway, rough, green, cup-and-flagstick | ht, tm |
| `game-03` | Par, and why every hole has one | Explain par as a benchmark tied to length. | par, hole-yardage | mc, es |
| `game-04` | Sand, water and out of bounds | Recognise the three kinds of trouble. | bunker, penalty-area, out-of-bounds | ht, mc |
| `game-05` | Eighteen holes | Describe a round: front nine, back nine, the turn, par 72. | front-back-nine, the-turn, course-par-72 | so, mc |
| `game-06` | What a round feels like | Follow the flow of a round, from tee time to the last putt. | tee-time, pace-of-play, round-flow | so, ds |
| `game-07` | Golf and its cousins | Tell golf from mini golf, Topgolf, disc golf and a range session. | golf-cousins, self-officiating | mc, bc |

**Unit `scoring`: Keeping Score** (prereq: `the-game`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `score-01` | Every swing counts | Explain stroke play and count strokes. | stroke-play, stroke-count | mc, fg |
| `score-02` | Birdie, eagle, bogey | Decode the score names, including the ace. | birdie, eagle-albatross, bogey, hole-in-one | tm, mc |
| `score-03` | "Three under" | Read a leaderboard line like "-8 thru 14". | score-to-par, leaderboard-reading | mc, st |
| `score-04` | Reading a scorecard | Read a card hole by hole and add it up. | scorecard, gross-score | ht, mc |
| `score-05` | When you add a stroke | Know what earns a penalty stroke. | penalty-stroke | ds, bc |
| `score-06` | What is a good score? | Place scores on the map: breaking 100, 90, 80. | score-benchmarks | es, mc |

**Unit `clubs-and-swings`: Clubs, Swings and Shots** (prereq: `the-game`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `club-01` | Fourteen clubs | Sort the clubs into families and know the limit. | fourteen-club-limit, club-families | tm, vi |
| `club-02` | Loft is height, length is distance | Explain what loft and shaft length change. | loft, club-length-distance | es, mc |
| `club-03` | How far does she hit it? | Place typical carry distances by club and skill. | carry-distance | es, ds |
| `club-04` | The swing in plain words | Name the phases of a swing and the setup. | swing-phases, grip-stance-alignment | so, mc |
| `club-05` | Where the ball goes | Explain why a ball curves: face versus path. | swing-path, clubface-angle, face-to-path, start-line, draw, fade, slice, hook, push-pull | SIM `golf.ball-flight.shot-shape.v1`, bc |
| `club-06` | Bad-shot vocabulary | Decode "fat", "thin", "topped", "shank". | mishits, shank | tm, st |
| `club-07` | The range is not the course | Know why range swings differ from round swings; warm up. | range-vs-course, warm-up | mc, ds |

**Unit `rules-and-etiquette`: Rules and Etiquette** (prereq: `scoring`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rule-01` | Play it as it lies | State golf's central rule and its spirit. | play-it-as-it-lies, loose-impediments | bc, mc |
| `rule-02` | Lost ball and out of bounds | Handle lost balls and OB: stroke and distance, provisional ball. | stroke-and-distance, provisional-ball, lost-ball | ds, bc |
| `rule-03` | Penalty areas | Tell red from yellow and know your options. | red-yellow-stakes, penalty-area-relief | ht, ds |
| `rule-04` | Free relief and dropping | Know when relief is free, and how to drop. | free-relief, drop-knee-height, nearest-point-of-relief, unplayable-ball | ht, ds |
| `rule-05` | Bunkers and greens | Know the few bunker and green rules everyone asks about. | bunker-rules, putting-green-rules, marking-ball | bc, mc |
| `rule-06` | Etiquette that shows you belong | Show golf manners: honor, ready golf, pitch marks, rakes. | golf-etiquette, honor-system, ready-golf, pitch-mark-repair | ds, mc |
| `rule-07` | When to ask an official | Know when you do not know, and the scorecard honesty rule. | rules-official, scorecard-signing, two-balls-when-unsure | ds, st |

**Unit `short-game-and-putting`: The Short Game and Putting** (prereq: `clubs-and-swings`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `short-01` | Where the strokes go | Explain why the short game decides scores. | short-game-share | mc, st |
| `short-02` | Putting: line and speed | Say that every putt has a line and a speed; know a lag putt. | putting-line-speed, lag-putt, three-putt | mc, ht |
| `short-03` | Reading a green | Read slope, fall line and speed; choose an aim point. | break, fall-line, green-speed-stimp, aim-point | SIM `golf.putting.read-the-break.v1`, bc |
| `short-04` | Chip, pitch, flop, bump-and-run | Tell the four short shots apart. | chip, pitch, flop, bump-and-run | tm, vi |
| `short-05` | Carry and roll | Pick a landing spot and a club so the roll does the rest. | landing-spot, carry-and-roll | SIM `golf.short-game.carry-and-roll.v1`, bc |
| `short-06` | Bunker shots | Explain the splash shot and why bounce helps. | bunker-shot, wedge-bounce | mc, so |
| `short-07` | Nerves, yips and gimmes | Understand the yips and the conceded putt; know an up-and-down. | yips, gimme, up-and-down | st, ds |

### Layer 2: Intermediate

**Unit `course-management`: Course Management** (prereq: `clubs-and-swings`, `short-game-and-putting`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `mgmt-01` | Play the hole backward | Think green-to-tee and weigh risk and reward. | course-management, risk-reward | mc, ds |
| `mgmt-02` | Play your miss | Aim so the bad shot is survivable, using your own dispersion. | dispersion, play-your-miss | SIM `golf.strategy.play-your-miss.v1`, ds |
| `mgmt-03` | The layup | Decide when to lay up on a par 5 or short of trouble. | layup, par-5-strategy | ds, es |
| `mgmt-04` | Pins and safe sides | Choose the middle of the green and the safe side. | pin-position, short-sided, safe-side | ht, ds |
| `mgmt-05` | Wind, elevation and lie | Adjust club for wind, elevation and awkward lies. | wind-effect, elevation-effect, lie-types | ds, es |
| `mgmt-06` | Routine and mindset | Describe a pre-shot routine and how to reset after a bad hole. | pre-shot-routine, course-mindset | mc, st |
| `mgmt-07` | What strategy sounds like | Follow a strategy conversation about a hole. | convo-strategy-talk | st, tk |

**Unit `formats-and-handicaps`: Formats and Handicaps** (prereq: `scoring`, `rules-and-etiquette`). 9 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fmt-01` | Stroke play vs match play | Tell the two great formats apart. | match-play, holes-up-down | mc, bc |
| `fmt-02` | Reading a match | Read "2 up", "dormie", "halved" and "3 & 2". | dormie, match-result-notation, halved-hole | mc, st |
| `fmt-03` | The scramble | Explain the scramble, golf's favourite team game. | scramble | mc, ds |
| `fmt-04` | Four-ball, foursomes, shamble | Tell best-ball and alternate-shot formats apart. | four-ball, foursomes, shamble | tm, mc |
| `fmt-05` | Stableford, skins, Nassau | Understand the friendly-game formats. | stableford, skins, nassau | tm, mc |
| `fmt-06` | What a handicap is | Explain the Handicap Index as portable skill. | handicap-index, whs | mc, fg |
| `fmt-07` | Course rating and slope | Explain how a course adjusts a handicap. | course-rating, slope-rating, course-handicap | es, mc |
| `fmt-08` | Net score | Turn a gross score into a net score. | net-score, stroke-index-allocation | ds, fg |
| `fmt-09` | Handicap honesty | Explain posting scores and sandbagging. | handicap-integrity, posting-scores | st, ds |

**Unit `courses-and-conditions`: Courses and Conditions** (prereq: `the-game`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cond-01` | Links, parkland, heathland, desert | Tell the main course types apart. | course-types, links-golf | vi, mc |
| `cond-02` | Who designed it | Know why an architect's name matters; recognise a few. | course-architecture, famous-architects | tm, mc |
| `cond-03` | Grass and green speed | Explain grass types and the Stimpmeter. | grass-types, stimpmeter, firm-and-fast | es, mc |
| `cond-04` | Tees, setup and the rough | Read tee markers and how a course is set up. | tee-markers, course-setup | ds, ht |
| `cond-05` | Weather and altitude | Adjust expectations for wind, rain, cold and altitude. | weather-golf, altitude-distance | ds, mc |
| `cond-06` | Holes everyone talks about | Recognise the famous holes as shared culture. | famous-holes | mc, ht |

### Layer 3: Enthusiast depth

**Unit `gear-and-numbers`: Gear and the Numbers** (prereq: `clubs-and-swings`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `gear-01` | The ball | Explain layers, compression and why balls differ. | golf-ball-construction, compression | tm, mc |
| `gear-02` | Drivers, shafts and fitting | Explain loft, flex and lie in a fitting. | club-fitting, shaft-flex, lie-angle | mc, ds |
| `gear-03` | Wedges: loft, bounce, grind | Explain gapping and bounce. | wedge-loft-gapping, bounce-grind | tm, mc |
| `gear-04` | Launch monitor numbers | Read ball speed, launch, spin, smash factor. | launch-monitor, ball-speed, spin-rate, smash-factor, launch-angle | es, mc |
| `gear-05` | Putters, shoes, rangefinders | Recognise putter styles and distance devices. | putter-styles, distance-devices | vi, ds |

**Unit `the-majors`: The Majors** (prereq: `scoring`, `the-game`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `major-01` | What makes a major | Name the nine majors and why they matter. | majors-men, majors-women | tm, mc |
| `major-02` | The Masters | Explain Augusta National, the invitation and the green jacket. | masters, augusta-national, green-jacket | mc, ht |
| `major-03` | The PGA Championship | Place the PGA Championship on the calendar. | pga-championship | mc, st |
| `major-04` | The U.S. Open | Explain the "hardest test" reputation and setups. | us-open, us-open-setup | mc, ds |
| `major-05` | The Open | Explain links golf, the claret jug and the oldest major. | the-open, claret-jug | mc, st |
| `major-06` | The women's majors | Name the five women's majors and their personalities. | womens-majors | tm, mc |
| `major-07` | Grand slams and counting | Explain career grand slam and major counts. | career-grand-slam, major-count | mc, es |

**Unit `team-cups`: Ryder, Solheim, Presidents** (prereq: `formats-and-handicaps`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cup-01` | What the Ryder Cup is | Explain the Ryder Cup in one breath. | ryder-cup, ryder-cup-format | mc, st |
| `cup-02` | Points and the magic number | Do the points math, including who retains. | cup-points-math | es, ds |
| `cup-03` | Captains, picks, qualifying | Explain captain's picks and qualification. | captains-picks, cup-qualification | mc, ds |
| `cup-04` | Solheim Cup and Presidents Cup | Tell the three cups apart. | solheim-cup, presidents-cup | tm, mc |
| `cup-05` | Why the cups feel different | Explain the atmosphere and Sunday singles. | cup-atmosphere, singles-sunday | st, tk |

**Unit `history-and-debates`: History and Debates** (prereq: `the-game`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hist-01` | Scotland, St Andrews and the rulebooks | Tell the origin story and who writes the rules. | golf-origin, st-andrews, rules-bodies | so, mc |
| `hist-02` | The first stars | Place the early eras and Bobby Jones. | golf-eras, bobby-jones | so, mc |
| `hist-03` | Hogan, Palmer, Nicklaus | Explain the television era and Nicklaus's 18 majors. | big-three, nicklaus-18 | mc, st |
| `hist-04` | The Tiger effect | Explain why Woods changed the sport. | tiger-effect | mc, st |
| `hist-05` | Women in golf | Tell the story of women's golf, from the LPGA's founding on. | womens-golf-history | so, mc |
| `hist-06` | The distance debate | Represent both sides of the ball debate. | debate-distance | st, ds |
| `hist-07` | LIV and the tours | Explain the LIV argument without picking a side. | debate-liv-vs-tours | st, ds |
| `hist-08` | Slow play, cost and access | Explain pace, cost and access debates with care. | debate-pace-and-access | st, ds |

### Layer 4: Branches and personalization

Branch units set `branchId`; layer is `branch`. Shared units also carry activities tagged with `branchId` where rules or examples differ.

**Unit `branch-rec-play`: Her Weekend Golf** (branch `rec-play`; prereq: `scoring`, `formats-and-handicaps`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rec-01` | A week at her course | Picture the routine: range, league night, muni vs private. | rec-golf-life, muni-vs-private | mc, tk |
| `rec-02` | Playing a round with her | Be a good playing partner: pace, carts, encouragement, honesty. | playing-partner-etiquette | ds, tk |
| `rec-03` | The league and the golf trip | Understand league nights and golf trips. | league-night, golf-trip | mc, st |

**Unit `tour-pga`: PGA TOUR World** (branch `pga-tour`; prereq: `scoring`, `the-majors`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `pga-01` | How the PGA TOUR works | Explain the season, tour cards and events. | pga-tour-structure, tour-card | mc, so |
| `pga-02` | FedExCup and the playoffs | Explain the points race and the three playoff events. | fedexcup, tour-championship | mc, es |
| `pga-03` | Signature events and the cut | Read a signature event and the cut line. | signature-events, cut-line | mc, ds |
| `pga-04` | Getting to the TOUR | Explain the Korn Ferry pathway and world ranking. | korn-ferry-pathway, world-ranking-owgr | so, mc |

**Unit `tour-lpga`: LPGA World** (branch `lpga-tour`; prereq: `scoring`, `the-majors`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `lpga-01` | How the LPGA Tour works | Explain the season and how players qualify. | lpga-structure, lpga-q-series | mc, so |
| `lpga-02` | Race to the CME Globe | Explain the season race and Player of the Year. | race-to-cme-globe, lpga-player-of-year | mc, ds |
| `lpga-03` | The world ranking and a global tour | Read the women's world ranking; the field's global mix. | womens-world-ranking, lpga-global-field | mc, st |
| `lpga-04` | The road to the Solheim Cup | Explain qualification and captain picks. | solheim-qualification | mc, ds |

**Unit `tour-liv`: LIV World** (branch `liv-golf`; prereq: `scoring`, `formats-and-handicaps`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `liv-01` | What LIV is | Explain shotgun starts, 72 holes and team scoring (2026). | liv-format, shotgun-start | mc, so |
| `liv-02` | Teams, captains, wild cards | Read a LIV field and a team. | liv-teams | mc, tm |
| `liv-03` | Where LIV stands | Explain funding, eligibility and returning players, neutrally. | liv-status | st, ds |

**Unit `tour-dpwt`: DP World Tour World** (branch `dp-world-tour`; prereq: `scoring`, `the-majors`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `dpwt-01` | The DP World Tour | Explain the tour's global calendar and its history. | dpwt-structure, harry-vardon-trophy | mc, so |
| `dpwt-02` | Race to Dubai and Rolex Series | Read the season race and the big events. | race-to-dubai, rolex-series | mc, ds |
| `dpwt-03` | The road to the Ryder Cup | Explain how European points and picks work. | ryder-europe-path | mc, st |

### Layer 5: Current season / live

**Unit `season-now`: Season Now** (prereq: `scoring` and either `the-majors` or `branch-rec-play`). Templated; content refreshed by `live` hooks and editorial cards. 6 lesson templates (each instantiated per week or event).

| Lesson id | Title | Objective | conceptIds | Activities | Live hook |
|---|---|---|---|---|---|
| `live-01` | This week in golf | Know what is on and why it matters. | live-weekly-context | mc, st | schedules, events |
| `live-02` | Read the leaderboard | Interpret today's leaderboard, cut line and pairings. | live-leaderboard, cut-line | mc, ht | scores |
| `live-03` | The race | Interpret FedExCup, Race to the CME Globe, Race to Dubai, or world-ranking movers. | live-ranking-race | mc, es | standings, rankings |
| `live-04` | Major week preview | Prepare for a major: course, storylines, what to watch. | live-major-preview | mc, st | events, news |
| `live-05` | The news explainer | Why is a headline a big deal (rules, equipment, LIV, injuries)? | rule-news-explainer | st, mc | news, regulations, new-products |
| `live-06` | New season primer | Reset for a new season and rules cycle. | season-rollover | mc, so | seasonal |

### Layer 6: Conversation practice and perpetual review

**Unit `conversation-lab`: Conversation Lab** (prereq: any three foundation units; content grows with mastery). 8 lessons; also feeds the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | After her round | Respond with curiosity to a round recap. | convo-follow-up-questions, score-benchmarks | tk, st |
| `talk-02` | The round that went wrong | Support someone after a bad round without fixing it. | convo-bad-round, yips | tk, st |
| `talk-03` | Watching the final round | Follow along with someone during a tour event. | convo-watching-together, leaderboard-reading | tk, st |
| `talk-04` | The gear chat | Ask smart questions about a new driver or wedges. | convo-gear-talk, club-fitting | tk, st |
| `talk-05` | Handicap talk | Handle "I'm a 14 now" conversations. | convo-handicap-talk, handicap-index | tk, st |
| `talk-06` | Major Sunday | Share a big finish. | convo-major-sunday, majors-men | tk, st |
| `talk-07` | "Come play a round" | Accept an invitation honestly. | convo-invitation-to-play, convo-admit-what-you-dont-know | tk, ds |
| `talk-08` | Say-this gauntlet | Decode five lines in a row. | (all layers, sampled) | st |

**Unit `review-loop`: Perpetual Review** (always available after the first lesson). 4 lesson templates driven by the review policy.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Daily Bite | 1 card (mc, fg or tm) from due concepts. | (due concepts) | mc, fg |
| `review-02` | Weekly mix | 3-round session sampled by weakness. | (weak concepts) | mc, bc, ds, tk |
| `review-03` | Penalty and relief boss | Mastery check on the two most-misunderstood areas: penalties and relief. | penalty-stroke, free-relief, penalty-area-relief, stroke-and-distance | bc, ds, ht |
| `review-04` | Term blitz | Playbook term drill. | (terms) | tm, fg |

**Review policy:** Leitner boxes at 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; a concept below 0.6 re-enters at 1d. Sim results contribute masterySignals with the same weights as native (halved when hints are used).

### Concept targets, personalization slots, release plan

- **Concept count target:** ~205 Playbook concepts (listed in the Appendix below); at least 60 have full Playbook entries with an example line (see `exercises.md` section 3).
- **Personalization slots:** `{{skillLevel}}`, `{{player}}`, `{{league}}`, `{{team}}`, `{{equipment}}`, `{{region}}` (section 8).
- **Release plan:**
  - **Launch (0.1 to 1.0):** units `the-game`, `scoring`, `clubs-and-swings`, `rules-and-etiquette`, `short-game-and-putting`, `course-management`, `formats-and-handicaps`, `courses-and-conditions`, `branch-rec-play`, `conversation-lab`, `review-loop`; sims 1, 2 and 3 (ball flight, putting, play-your-miss) first; branch `rec-play` complete.
  - **Fast follow (1.1):** `the-majors`, `team-cups`, `tour-pga`, `tour-lpga`, `season-now` with schedule, leaderboard and news cards; sim 4 (carry and roll).
  - **Ongoing:** `gear-and-numbers`, `history-and-debates`, `tour-liv`, `tour-dpwt`; new lessons per season (new Rules of Golf edition on the four-year cycle; majors calendar April to July; PGA TOUR season January to August with a fall series; LPGA and DP World Tour calendars; Ryder Cup years), new talk tracks weekly during the season.

### Appendix: Playbook concepts (ids)

The game: `golf-objective`, `stroke`, `round-18`, `tee-box`, `fairway`, `rough`, `green`, `cup-and-flagstick`, `par`, `hole-yardage`, `bunker`, `penalty-area`, `out-of-bounds`, `front-back-nine`, `the-turn`, `course-par-72`, `tee-time`, `pace-of-play`, `round-flow`, `golf-cousins`, `self-officiating`.
Scoring: `stroke-play`, `stroke-count`, `birdie`, `eagle-albatross`, `bogey`, `hole-in-one`, `score-to-par`, `leaderboard-reading`, `scorecard`, `gross-score`, `penalty-stroke`, `score-benchmarks`.
Clubs and swings: `fourteen-club-limit`, `club-families`, `loft`, `club-length-distance`, `carry-distance`, `swing-phases`, `grip-stance-alignment`, `swing-path`, `clubface-angle`, `face-to-path`, `start-line`, `draw`, `fade`, `slice`, `hook`, `push-pull`, `mishits`, `shank`, `range-vs-course`, `warm-up`.
Rules: `play-it-as-it-lies`, `loose-impediments`, `stroke-and-distance`, `provisional-ball`, `lost-ball`, `red-yellow-stakes`, `penalty-area-relief`, `free-relief`, `drop-knee-height`, `nearest-point-of-relief`, `unplayable-ball`, `bunker-rules`, `putting-green-rules`, `marking-ball`, `golf-etiquette`, `honor-system`, `ready-golf`, `pitch-mark-repair`, `rules-official`, `scorecard-signing`, `two-balls-when-unsure`.
Short game: `short-game-share`, `putting-line-speed`, `lag-putt`, `three-putt`, `break`, `fall-line`, `green-speed-stimp`, `aim-point`, `chip`, `pitch`, `flop`, `bump-and-run`, `landing-spot`, `carry-and-roll`, `bunker-shot`, `wedge-bounce`, `yips`, `gimme`, `up-and-down`.
Management: `course-management`, `risk-reward`, `dispersion`, `play-your-miss`, `layup`, `par-5-strategy`, `pin-position`, `short-sided`, `safe-side`, `wind-effect`, `elevation-effect`, `lie-types`, `pre-shot-routine`, `course-mindset`, `convo-strategy-talk`.
Formats and handicaps: `match-play`, `holes-up-down`, `dormie`, `match-result-notation`, `halved-hole`, `scramble`, `four-ball`, `foursomes`, `shamble`, `stableford`, `skins`, `nassau`, `handicap-index`, `whs`, `course-rating`, `slope-rating`, `course-handicap`, `net-score`, `stroke-index-allocation`, `handicap-integrity`, `posting-scores`.
Courses: `course-types`, `links-golf`, `course-architecture`, `famous-architects`, `grass-types`, `stimpmeter`, `firm-and-fast`, `tee-markers`, `course-setup`, `weather-golf`, `altitude-distance`, `famous-holes`.
Gear: `golf-ball-construction`, `compression`, `club-fitting`, `shaft-flex`, `lie-angle`, `wedge-loft-gapping`, `bounce-grind`, `launch-monitor`, `ball-speed`, `spin-rate`, `smash-factor`, `launch-angle`, `putter-styles`, `distance-devices`.
Majors and cups: `majors-men`, `majors-women`, `masters`, `augusta-national`, `green-jacket`, `pga-championship`, `us-open`, `us-open-setup`, `the-open`, `claret-jug`, `womens-majors`, `career-grand-slam`, `major-count`, `ryder-cup`, `ryder-cup-format`, `cup-points-math`, `captains-picks`, `cup-qualification`, `solheim-cup`, `presidents-cup`, `cup-atmosphere`, `singles-sunday`.
History and debates: `golf-origin`, `st-andrews`, `rules-bodies`, `golf-eras`, `bobby-jones`, `big-three`, `nicklaus-18`, `tiger-effect`, `womens-golf-history`, `debate-distance`, `debate-liv-vs-tours`, `debate-pace-and-access`.
Branches: `rec-golf-life`, `muni-vs-private`, `playing-partner-etiquette`, `league-night`, `golf-trip`, `pga-tour-structure`, `tour-card`, `fedexcup`, `tour-championship`, `signature-events`, `cut-line`, `korn-ferry-pathway`, `world-ranking-owgr`, `lpga-structure`, `lpga-q-series`, `race-to-cme-globe`, `lpga-player-of-year`, `womens-world-ranking`, `lpga-global-field`, `solheim-qualification`, `liv-format`, `shotgun-start`, `liv-teams`, `liv-status`, `dpwt-structure`, `harry-vardon-trophy`, `race-to-dubai`, `rolex-series`, `ryder-europe-path`.
Live and conversation: `live-weekly-context`, `live-leaderboard`, `live-ranking-race`, `live-major-preview`, `rule-news-explainer`, `season-rollover`, `convo-follow-up-questions`, `convo-bad-round`, `convo-watching-together`, `convo-gear-talk`, `convo-handicap-talk`, `convo-major-sunday`, `convo-invitation-to-play`, `convo-admit-what-you-dont-know`.

---
