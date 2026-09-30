# Course Design Specification: NASCAR (`nascar`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Rules and format facts are as of the 2026 season (verified 2026-09-30, mid-Chase; see the fact sheet in section 3 and the verification notes in section 16).

| Field | Value |
|---|---|
| Status | draft |
| Wave | 1 |
| Author / date | Swoon'd curriculum design (Claude) / 2026-09-30 |
| Manifest | `manifest.json` |

---

## 1. Identity
- **Course ID:** `nascar` (immutable)
- **Display name:** NASCAR
- **Category / family:** Motorsports; category path `Sports > Motorsports > NASCAR`
- **Simulation prefix:** `nascar` (sim IDs `nascar.<topic>.<name>.v1`)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns NASCAR, are they meaningfully conversationally competent about it?" | Verdict | Consequence |
|---|---|---|---|
| Formula 1 (`formula-1`) | No. Different formats (road/street circuits, DRS/overtake, tire compounds, budget cap, constructor identity), culture and vocabulary. | Independent (sibling) | Separate course; a shared "motorsport basics" primer is optional cross-link only (flags, pit stop, tires). |
| IndyCar (future) | Partly: ovals and pit stops overlap, but open-wheel cars, push-to-pass, split oval/road calendar and driver market differ. | Adjacent, independent | Future course; oval concepts (drafting, banking, restarts) can cross-link. |
| Sports cars / IMSA / WEC (future) | No: multi-class, endurance, driver swaps. | Independent | Not part of this course. |
| Drag racing, dirt-track and sprint-car racing | No. | Independent | Only mention as "other forms of racing" in the origin story. |
| Cars (`cars`) | Little: knowing cars generally does not explain stages, drafting or pit strategy; NASCAR "stock cars" are purpose-built. | Adjacent | Cross-link brand and engine basics only. |
| NASCAR O'Reilly Auto Parts Series / Craftsman Truck Series | Yes, mostly: same tracks, flags, pit road, drafting; different vehicles, schedules, fields and some rules. | Shares foundation | Branches inside this course, not separate courses. |

- **Branches:**

| id | Name | What changes |
|---|---|---|
| `cup-series` | NASCAR Cup Series | The default: 36 points races, 40-car fields, the Chase, the biggest stars and most talk. |
| `oreilly-series` | NASCAR O'Reilly Auto Parts Series | Middle rung. Rising drivers and Cup part-timers, different schedule (includes Cup-companion weekends), its own championship format and driver stories. |
| `truck-series` | NASCAR Craftsman Truck Series | Entry-level national series. Pickup-style trucks, short and intermediate tracks, chaotic racing, quick rise-and-fall stories. |

Series branches change rules details, schedules, data and culture; the core lessons (flags, drafting, strategy, pit road, tracks) transfer.

## 2. Beginner model
- **What a complete beginner knows:** cars go around in circles and turn left; the Daytona 500 is the big race; the names Earnhardt, Gordon, Petty; "Talladega Nights"; crashes look scary; there is a pit stop. Some know that Chevrolet, Ford and Toyota are the brands.
- **Terminology that confuses:** *stage*, *the Chase*, *caution / yellow*, *green-white-checkered*, *lucky dog / free pass*, *wave-around*, *track position*, *dirty air / clean air*, *loose / tight (push)*, *draft / run / bump draft / side draft*, *the Big One*, *pit cycle*, *off-sequence*, *undercut*, *falloff*, *charter*, *open car*, *choose rule*, *lapped car / a lap down*, *lead lap*, *spotter*, *crew chief*, *the groove / the cushion*.
- **Common misconceptions:**
  1. "They just drive in circles." It is a strategy sport played at 180-200 mph, in traffic, with tire wear, fuel, and air as key variables.
  2. "Stock cars are just cars from the showroom." They are purpose-built to a spec; Next Gen parts are shared by all three brands.
  3. "The fastest car always wins." Track position, cautions, pit strategy and fuel often beat speed.
  4. "Drafting is about engine power." It is aerodynamics: the car behind meets less air.
  5. "A caution is bad for the leader." A caution erases gaps and opens a pit cycle; it can help or hurt depending on tires, fuel and position.
  6. "You win the championship by winning." In 2026 there is no win-and-in: you must be in the top 16 by points and then have the most points after the final race. (Before 2026, wins guaranteed playoff berths.)
  7. "Every race is 500 miles." Distances vary (200-600 miles); only the Daytona 500 carries the number in its name.
  8. "Loose means slow / tight means fast." Both describe balance problems; neither is fast.
  9. "Wrecks are just luck." At superspeedways, pack dynamics make the Big One a structural risk; short tracks reward contact and payback culture.
  10. "Pit crews are extras." A slow stop can cost more than a bad qualifying run.
- **Concepts that unlock the rest (foundation units):** flags and race flow (green-caution-restart), stages, pit road and pit crew, track types, drafting/clean vs dirty air, points and the Chase, the car and its balance. Once those click, commentary decodes.

## 3. Foundational knowledge
Grouped into modules (these become `foundationalModules[]` and foundation units).

| Module (unit id) | Contents |
|---|---|
| `nascar-101` NASCAR 101 | What stock car racing is; series ladder (Trucks, O'Reilly, Cup); laps vs miles; starting grid; how a race is won; origins (Prohibition-era bootleggers, Bill France Sr., founding 1948); race-day timeline. |
| `race-flow` How a Race Works | Flags; stages and stage breaks; cautions; pit road basics; restarts and the choose rule; overtime (green-white-checkered); free pass and wave-around; a race in seven beats. |
| `car-crew` The Car & the Crew | Stock car vs street car; Next Gen car (2022): composite symmetrical body, independent rear suspension, single center-lock lug nut, sequential shifter, common parts; 358 ci V8 with different power by track type; Chevrolet, Ford, Toyota; spoiler and splitter; Goodyear tires, E15 fuel and a ~20 gallon fuel cell; crew chief, spotter, pit crew; safety and inspection. |
| `tracks-air` Tracks & Air | Track types (short, intermediate, superspeedway, road course, Roval); banking and grooves; rubbering in; drafting; clean/dirty air; bump and side drafting; pack racing and the Big One; identifying a track. |

**2026 fact sheet (verified 2026-09-30; sources in section 16):**
- Cup Series: 36 points races; 26-race regular season then a 10-race **Chase** for the top 16 in points. No win-and-in and no eliminations; playoff points are gone.
- Chase reset: seed 1 (regular-season champion) 2,100; seed 2 2,075; seed 3 2,065; seed 4 2,060; then 5 fewer per seed to 2,000 for 16th. Most points after the finale wins the title.
- Race points: winner 55 (up from 40), 2nd 35, 3rd 34, down to 1 for 40th. Stage points: top 10 at each stage end get 10 down to 1.
- Chase schedule: Darlington, World Wide Technology Raceway, Bristol, Kansas, Las Vegas, Charlotte Roval, Phoenix, Talladega, Martinsville and the finale at Homestead-Miami (Nov 8). Phoenix hosted the finale 2020-2025.
- Engine power: about 510 hp with a 7-inch spoiler at superspeedways (Daytona, Talladega, Atlanta); 670 hp at intermediates and Michigan; 750 hp at tracks under 1.5 miles and on road courses, using a larger tapered spacer. Next Gen chassis and body unchanged.
- Charters: the December 2025 antitrust settlement (23XI Racing and Front Row Motorsports v. NASCAR) gave all charter teams permanent ("evergreen") charters with conditions and returned the six disputed charters to 23XI and Front Row for 2026. 36 charters plus four open-car spots make a 40-car field.
- Stage lengths were adjusted at Talladega in spring 2026 to discourage fuel saving.
- Series names: NASCAR Cup Series, NASCAR O'Reilly Auto Parts Series (formerly Xfinity), NASCAR Craftsman Truck Series.

| Module (unit id) | Contents (Intermediate) |
|---|---|
| `pit-strategy` Pit Stops & Strategy | Anatomy and timing of a pit stop; pit road penalties; track position; four vs two tires; fuel windows; pit or stay out; undercut, overcut, gambles; stage strategy. |
| `handling` Handling & Setup | Tight (push) and loose; balance; diagnosing and adjusting; tire pressure; wedge, track bar and springs (as tools, not recipes); tire falloff; long-run vs short-run speed. |
| `points-chase` Points, the Chase & the Season | Race and stage points; the 26-race regular season; the Chase 2026; the championship race; format history (points era, Chase 2004, elimination 2014, Chase 2026); charters and open teams; qualifying. |
| `racecraft` Racecraft & Restarts | Passing lines; restart lane and jump; clean-air passes; blocking; road-course racecraft; lapped traffic; payback; racing vs wrecking. |

Other knowledge areas covered in later units: history and culture (legends, the Daytona 500, eras), equipment and technology (Next Gen details), participants and organizations (teams, owners, alliances, manufacturers, sponsors), techniques (drafting, restart, road-course), and the rules-and-penalties layer (inspection, damaged vehicle policy).

## 4. Enthusiast model
- **What enthusiasts talk about:** last weekend's strategy ("did the pit call work?"), track position, who has speed vs who has the lead, tire falloff, the Chase picture, restarts, a driver's season arc, team and manufacturer pride, rivalries and payback, rule changes, the schedule, and the eternal comparison with the past.
- **Distinctions that matter to them:** *fast car* vs *lucky finish*; *dominated* vs *won*; *track position* vs *raw speed*; *long-run* vs *short-run* speed; *intermediate* vs *short track* vs *superspeedway* skill sets; *race* vs *wreck*; *fuel mileage* win vs speed win; *road-course ringer* vs oval specialist.
- **Knowledge that signals genuine understanding:** using *loose/tight* correctly; noticing *off-sequence* strategies; saying why a caution helped one team; understanding that superspeedway racing is a *pack* game and the Big One is structural; naming the Chase reset and that wins no longer bank playoff points; knowing which manufacturer a team is with.
- **Beginner statements that sound uninformed:** "They just drive in circles"; "Why don't they just go faster?" at Talladega; "Who has the fastest engine?" as the only question; "So the guy who wins the most races is champion"; "Why are they going slow behind that car?" (caution); calling the O'Reilly Series "Xfinity" (still common, mildly dated); mixing up *tight* and *loose*.
- **Controversies and debates:** (1) Championship format: eliminations (2014-2025) vs the 2026 Chase; (2) stage racing and planned cautions; (3) Next Gen car: parity and cost vs driving feel and durability; (4) superspeedway fuel-saving and pack racing quality; (5) schedule: number of road courses, street races and legacy ovals; (6) charters and team economics after the 2025 settlement; (7) fuel-mileage finishes; (8) the horsepower push to 750 at short tracks; (9) payback culture and on-track policing; (10) all-time greats (Petty, Earnhardt, Gordon, Johnson).

## 5. Interaction model
- **What the learner should EXPERIENCE instead of reading:** feeling free speed in a draft; picking a lane in a pack and watching a run form; making the pit-or-stay-out call and seeing the restart order; seeing why a car is tight or loose and turning the balance dial; choosing a restart lane at the choose line; reading banking and rubber to find the fast groove. Everything else is conversation and recall.
- **Unity warranted?** Yes, in six places where spatial reasoning, movement over time and camera perspective are the concept (see section 12). Each has a written tier justification and a native fallback lesson.
- **Native interactions that are more effective:** flags and terms (`term-match`, `visual-id`); rules with clear yes/no (`binary-call`); pit-stop order and race format (`sequence-order`); pit-stop timing feel (`timing-tap`, 1D); judgment (`decision-scenario`); magnitudes (`estimate-slider`); fan language (`say-this`); conversation (`talk-track`); spotter calls (`listening-id` with original audio); diagrams (`hotspot-tap`).
- **What should NOT be gamified:** crash consequences or injuries (calm factual copy only); real drivers' deaths and serious injuries (never a game beat); wagering, fantasy scoring or odds (no gambling framing); scoring real drivers for being wrong; timing-attack games that reward reckless driving; any "pretend you're a driver on public roads" framing.
- **Chosen mix:** roughly 94% native items, six Unity sims used in six lessons (plus review re-use), heavy on `say-this` and `talk-track`; details in section 12.

## 6. Dynamic information requirements
Motorsport is a live-season subject, so structured current data is genuinely valuable here (spec sections 10, 33, 36). Adapters normalize into Swoon'd entities (`Race`, `Result`, `StandingsEntry`, `Driver`, `Team`, `Track`); no provider schema leaks (spec section 32). Full plan in `live-data.md`.

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback if down |
|---|---|---|---|---|---|
| Schedules | Yes | "When is the next race?" and the season structure | Orange Cat Blacktop (spec candidate), Sportradar/SportsDataIO (enterprise upgrade), manual editorial calendar | daily | Bundled season calendar JSON with a "may be outdated" badge |
| Results | Yes | Last race recap and stories | Orange Cat Blacktop, TheSportsDB (if coverage is adequate) | minutes during events, then final within hours | Show last cached result with timestamp |
| Standings | Yes | Chase picture; "is my person's driver in the Chase?" | Same | weekly (daily during the Chase) | Cached standings |
| Statistics | Light | Laps led, wins, average finish for stories | Same | weekly | Hide the card |
| Rosters (drivers, teams, manufacturers) | Yes | Personalization and correct team/driver mapping | Same + manual editorial roster | monthly / on change | Bundled roster snapshot |
| Events (race weekend info, TV) | Light | "What is on this weekend?" | Schedule provider; broadcaster listings are link-out | daily | Static link |
| News | Yes (editorial) | Why fans are talking | News API or RSS via licensed provider (Q-3 open) | hourly | Evergreen "why this matters" cards |
| Weather | Light | Rain delays and race-day conditions | NWS / Open-Meteo | hourly on race days | Hide the card |
| Rankings | No | Not a NASCAR concept beyond standings | n/a | n/a | n/a |
| Releases, closures, alerts, new products | No | No educational value; do not invent | n/a | n/a | n/a |

Structured data and editorial data are separate systems; a provider outage never blocks lessons. NASCAR.com/live feeds are not consumed unofficially; only licensed providers.

## 7. Editorial context
- **Commentary that helps:** why a strategy call was controversial; why a driver is celebrated or criticized; what a penalty means; why a rule change is contentious; what the Chase picture looks like.
- **Appropriate sources (explain and link, never copy):** NASCAR.com news, team and manufacturer newsrooms, Jayski, Frontstretch, Racer, Motorsport.com, Autosport and beat reporters' public posts (link-only).
- **Licensing:** article text is never copied; we write our own explanation, teach vocabulary and link to the publisher (spec section 11, 37). Headlines are used only as identifiers with links; no images.
- **Example prompts:** "Why are fans talking about that pit call?"; "What does it mean that he is 'off-sequence'?"; "Why is a fuel-mileage win controversial?"; "What changed about the Chase this year?"; "Why did the finale move back to Homestead?"
- **Approach in manifest:** `explain-and-link`.

## 8. Personalization

| Dimension | How it changes content | Default when unset | Units using tokens |
|---|---|---|---|
| Series (`series`) | Which series the live feed and examples default to (Cup, O'Reilly, Trucks); branch units | Cup Series | `your-corner`, `this-season` |
| Driver (`driver`) | Examples, live cards and Talk Lab lines use `{{driver}}`; follow-up questions reference the driver's style (short-track ace, road-course ringer) | Current points leader (live) | `your-corner`, `this-season`, `talk-lab` |
| Team (`team`) | Team stories, manufacturer, teammates, alliances via `{{team}}` | Team of the default driver | `your-corner`, `teams-people`, `this-season` |
| Manufacturer / brand (`brand`) | Chevrolet, Ford or Toyota flavored examples | none (neutral) | `your-corner`, `teams-people` |
| Home track / region (`region`) | Track lessons and previews use `{{track}}` (the person's home race) | Next race's track | `tracks-air`, `your-corner`, `this-season` |

Tokens: `{{driver}}`, `{{team}}`, `{{series}}`, `{{manufacturer}}`, `{{track}}`, `{{nextRace}}`. The foundational curriculum stays valid without any personalization; personalization changes examples and the live feed, never the concepts.

## 9. Conversation model
Example lines a NASCAR fan might naturally say, with translation, implied terminology and a meaningful next question. The learner is taught to understand and ask, never to impersonate expertise.

| # | She says | Means | Terms implied | A good next question |
|---|---|---|---|---|
| 1 | "We got caught speeding on pit road and lost the race." | A pit road penalty cost track position. | pit road speed, pit penalty, track position | "Was it entering or leaving?" |
| 2 | "He was so loose off turn four." | The rear of the car slid on corner exit. | loose, balance | "Did they change anything on the stop?" |
| 3 | "They took two tires and it cost them." | A short stop lost to fresher four-tire cars. | two-tire stop, tire falloff | "Would four have been quicker over the run?" |
| 4 | "He got a huge run off the draft but got blocked." | He built speed behind a car but the leader shut the lane. | draft, run, block | "Did he try the other lane?" |
| 5 | "They stayed out and got the lead." | Skipped tires under caution to lead. | stay out, track position | "Will the tires hold?" |
| 6 | "Stage two ends in five laps, everybody will pit." | Planned caution soon; a pit cycle opens. | stage break, pit cycle | "Who stays out?" |
| 7 | "I like the Chase better, at least now consistency counts." | 2026 format has no eliminations. | Chase, points reset | "Do you miss win-and-in?" |
| 8 | "It is Talladega, so bring the Big One." | A big pack wreck is expected. | superspeedway, pack, the Big One | "Why do they run so tight there?" |
| 9 | "That was a fuel-mileage win." | Won by stretching fuel. | fuel window, fuel mileage | "Does that feel like a real win?" |
| 10 | "He is a road-course ringer." | Especially strong at road courses. | road course, driver archetypes | "Which other road courses does he like?" |
| 11 | "Restart on the outside, of course." | Preferred lane at the choose line. | restart, choose rule | "Is the outside better here?" |
| 12 | "He led 200 laps and finished 12th." | Dominant car undone by strategy or a caution. | laps led, dominant car | "What happened at the end?" |
| 13 | "We are a lap down thanks to a spin." | Lost a full lap to the leader. | lapped car, free pass | "Can they get the free pass?" |
| 14 | "Our charter is safe now, thank goodness." | Team economics after the 2025 settlement. | charter | "What did the settlement change?" |

- **How Swoon'd helps without encouraging fake expertise:** `say-this` items teach the meaning first; `talk-track` rewards questions and curiosity over jargon; `noFakeExpertNote` marks lines that are advanced; coach notes flag wrong-but-plausible claims (mixing up tight/loose, using old playoff rules).
- **Targets:** 24 Talk tab talk tracks plus ~21 lesson-embedded tracks; ~140 `say-this` items; the Talk Lab unit (`talk-lab`) has 8 lessons; each Enthusiast unit ends with a conversation lesson.

## 10. Assessment
- **How useful competence is determined:** concept mastery (0..1 per concept) driven by native exercise outcomes and Unity `masterySignals`, with spaced review confirming retention; conversation performance is a first-class signal (Smooth meter on talk tracks).
- **Recognize:** all flags, track types, the three series, the three manufacturers, the pit crew roles, common radio calls.
- **Understand:** why drafting works; why track position matters; how stages and the Chase produce a champion; what tight and loose mean.
- **Explain (in one sentence):** why a pit call worked or did not; why a car got faster or slower; why a race was controversial.
- **Correctly interpret:** fan lines in section 9; a running order and a lap chart at a glance; a caution's effect.
- **Mastery model:** `concept-mastery-v1`, pass threshold 0.80 per concept; course-level "conversation-ready" flag when the top 60 foundational and intermediate concepts (marked `core` in curriculum) are mastered and the learner has completed 10 talk tracks with Smooth >= 60.
- **Useful competence statement:** "After this course you can follow a NASCAR broadcast, understand why fans are cheering or complaining, and ask a fan you care about a genuinely good question about their driver's day."

## 11. Curriculum map (ongoing course)

An ONGOING course: **15 units, 108 lessons** across foundations, intermediate, enthusiast depth, branches/personalization, a perpetual live layer, conversation practice and perpetual review. Concept target (Playbook): **131 concepts** (see `exercises.md` section 4). Lesson activities name native exercise types or Unity sim ids; `mixed` means an adaptive review set drawn from mastered and weak concepts.

### Layer summary

| Layer | Units | Lessons | Expectation met |
|---|---|---|---|
| Foundations | 4 | 33 | 4+ units, ~20+ lessons |
| Intermediate | 4 | 31 | 4+ units |
| Enthusiast depth | 3 | 20 | 3+ units |
| Branches & personalization | 1 | 6 | team/driver/series branches |
| Current-season / live | 1 | 6 | templates + live hooks |
| Conversation practice | 1 | 8 | 10+ tracks |
| Perpetual review | 1 | 4 | policy defined |

### Unit table

| unit id | unit title | layer | prerequisites | lessons | main concepts |
|---|---|---|---|---|---|
| `nascar-101` | NASCAR 101 | Foundations | none | 7 | `stock-car`, `oval-racing`, `series-ladder`, `cup-series`, `oreilly-series`, `truck-series`... |
| `race-flow` | How a Race Works | Foundations | `nascar-101` | 8 | `green-flag`, `caution-flag`, `red-flag`, `white-flag`, `checkered-flag`, `black-flag`... |
| `car-crew` | The Car & the Crew | Foundations | `nascar-101` | 8 | `stock-car`, `body-and-chassis`, `next-gen-car`, `tires-and-wheels`, `engine-package`, `tapered-spacer`... |
| `tracks-air` | Tracks & Air | Foundations | `race-flow` | 10 | `short-track`, `track-types`, `intermediate-track`, `aero-sensitivity`, `superspeedway`, `tri-oval`... |
| `pit-strategy` | Pit Stops & Strategy | Intermediate | `race-flow`, `tracks-air` | 8 | `pit-crew`, `pit-stop-timing`, `four-tire-stop`, `pit-penalty`, `pit-road-speed`, `track-position`... |
| `handling` | Handling & Setup | Intermediate | `car-crew`, `tracks-air` | 7 | `tight-push`, `loose`, `car-balance`, `adjustments`, `tire-pressure`, `wedge`... |
| `points-chase` | Points, the Chase & the Season | Intermediate | `race-flow` | 8 | `race-points`, `stage-points`, `chase-2026`, `regular-season-champion`, `points-reset`, `championship-race`... |
| `racecraft` | Racecraft & Restarts | Intermediate | `tracks-air`, `pit-strategy` | 8 | `passing-lines`, `racing-groove`, `restart-strategy`, `choose-rule`, `restart`, `clean-air-pass`... |
| `culture-debates` | Legends, Eras & Debates | Enthusiast depth | `points-chase` | 7 | `legends`, `daytona-500-lore`, `crown-jewel`, `playoff-debate`, `chase-2026`, `next-gen-debate`... |
| `insider-craft` | The Insider Layer | Enthusiast depth | `racecraft`, `culture-debates` | 6 | `spotter-talk`, `spotter`, `loop-data`, `laps-led`, `dominant-car`, `track-position`... |
| `teams-people` | Teams, Owners & Drivers | Enthusiast depth | `culture-debates` | 7 | `team-organization`, `crew-chief`, `alliances`, `manufacturers`, `driver-archetypes`, `driver-pipeline`... |
| `your-corner` | Your Person's Corner | Branches & personalization | `race-flow` | 6 | `cup-series`, `series-focus`, `oreilly-series`, `truck-series`, `driver-focus`, `driver-archetypes`... |
| `this-season` | This Season | Current-season / live | `your-corner` | 6 | `current-season`, `track-types`, `track-position`, `chase-2026`, `points-reset`, `driver-focus`... |
| `talk-lab` | The Talk Lab | Conversation practice | `race-flow` | 8 | `conversation-basics`, `pit-cycle`, `stay-out`, `the-big-one`, `wreck-vs-race`, `chase-2026`... |
| `perpetual-review` | Keep It Fresh | Perpetual review | `nascar-101` | 4 | `useful-competence`, `chase-2026` |

#### Unit `nascar-101`: NASCAR 101 (Foundations)

What you are looking at, and why 40 cars circling a track is a real sport. Prerequisites: none.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `n101-01` | What NASCAR actually is | Explain in one sentence what stock car racing is and why fans love it. | `stock-car`, `oval-racing` | multiple-choice; say-this |
| `n101-02` | The three series ladder | Name Cup, O'Reilly and Trucks and how drivers climb. | `series-ladder`, `cup-series`, `oreilly-series`, `truck-series` | term-match; multiple-choice |
| `n101-03` | Laps, miles and the 500 | Read a race distance and convert laps to miles at a given track. | `laps-and-distance` | estimate-slider; fill-the-gap |
| `n101-04` | The starting grid | Explain how the field lines up and why the front row matters. | `starting-grid`, `qualifying` | multiple-choice; binary-call |
| `n101-05` | How you win | Follow a green-to-checkered race and the meaning of running order. | `running-order`, `checkered-flag`, `lap-down` | sequence-order; multiple-choice |
| `n101-06` | Where it came from | Tell the moonshine-to-Daytona story in two sentences. | `nascar-origins` | multiple-choice; say-this |
| `n101-07` | Race day, start to finish | Describe a race-day timeline and a typical Sunday. | `green-flag`, `checkered-flag` | sequence-order; talk-track |

#### Unit `race-flow`: How a Race Works (Foundations)

Flags, stages, cautions, restarts and the rhythm of a race. Prerequisites: nascar-101.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `flow-01` | The flags | Match every flag to its meaning and consequence. | `green-flag`, `caution-flag`, `red-flag`, `white-flag`, `checkered-flag`, `black-flag` | term-match; visual-id |
| `flow-02` | Stages, explained | Explain why races are split into stages and what stage points do. | `stage-racing`, `stage-break`, `stage-points` | multiple-choice; sequence-order |
| `flow-03` | Cautions: why the race slows | List why a caution is thrown and what happens next. | `caution-flag`, `running-order` | multiple-choice; binary-call |
| `flow-04` | Pit road, the basics | Explain what happens on pit road and who is over the wall. | `pit-road`, `pit-crew`, `pit-road-speed` | hotspot-tap; term-match |
| `flow-05` | Restarts and the choose rule | Describe a restart and the choose rule. | `restart`, `choose-rule` | multiple-choice; hotspot-tap |
| `flow-06` | Overtime, red flags and finishing | Explain overtime and why races run long. | `overtime`, `red-flag` | binary-call; sequence-order |
| `flow-07` | Lucky dogs and wave-arounds | Explain how lapped cars return to the lead lap. | `free-pass`, `wave-around`, `lap-down` | decision-scenario; multiple-choice |
| `flow-08` | A race in seven beats | Narrate the shape of a race. | `stage-racing`, `restart`, `pit-road`, `checkered-flag` | sequence-order; say-this; talk-track |

#### Unit `car-crew`: The Car & the Crew (Foundations)

What is under the paint and who keeps it fast. Prerequisites: nascar-101.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `car-01` | Stock car, not stock | Explain why a stock car is not a showroom car. | `stock-car`, `body-and-chassis` | multiple-choice; visual-id |
| `car-02` | The Next Gen car | Name what changed with the Next Gen car. | `next-gen-car`, `tires-and-wheels` | multiple-choice; hotspot-tap |
| `car-03` | Engines and horsepower | Explain why horsepower differs by track. | `engine-package`, `tapered-spacer`, `horsepower-levels` | estimate-slider; multiple-choice |
| `car-04` | Three brands | Spot Chevrolet, Ford and Toyota nose cues. | `manufacturers` | visual-id; term-match |
| `car-05` | Wings and lips | Explain what a spoiler and splitter do. | `spoiler-splitter`, `aerodynamic-drag` | hotspot-tap; multiple-choice |
| `car-06` | Tires and fuel | Explain what Goodyear tires and E15 fuel mean for racing. | `tires-and-wheels`, `fuel-cell` | fill-the-gap; multiple-choice |
| `car-07` | Who does what | Match crew chief, spotter, driver and pit crew to jobs. | `crew-chief`, `spotter`, `pit-crew` | term-match; say-this |
| `car-08` | Safety and inspection | Explain how safety tech and inspection shape the sport. | `safety-design`, `inspection` | multiple-choice; decision-scenario |

#### Unit `tracks-air`: Tracks & Air (Foundations)

Track types, banking, grooves and the invisible thing everyone talks about: air. Prerequisites: race-flow.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `tracks-01` | Short tracks | Describe what makes short tracks different. | `short-track`, `track-types` | multiple-choice; visual-id |
| `tracks-02` | Intermediates | Explain why intermediates are about aero and handling. | `intermediate-track`, `aero-sensitivity` | multiple-choice; term-match |
| `tracks-03` | Superspeedways | Explain why superspeedways are different. | `superspeedway`, `tri-oval` | multiple-choice; estimate-slider |
| `tracks-04` | Road courses and the Roval | Explain what makes road courses different. | `road-course`, `roval`, `braking-zone` | visual-id; multiple-choice |
| `tracks-05` | Banking, grooves and rubber | Choose the groove for the situation. | `banking`, `racing-groove`, `rubbering-in`, `flat-track` | **unity-sim `nascar.track.groove-read.v1`**; hotspot-tap |
| `tracks-06` | Drafting: free speed | Feel how drafting reduces drag. | `drafting`, `aerodynamic-drag` | **unity-sim `nascar.drafting.tuck-in.v1`**; multiple-choice |
| `tracks-07` | Clean air and dirty air | Explain why the leader has clean air and the follower loses grip. | `clean-air`, `dirty-air` | binary-call; fill-the-gap |
| `tracks-08` | Bump drafts and side drafts | Distinguish bump draft from side draft. | `bump-draft`, `side-draft` | term-match; binary-call |
| `tracks-09` | Packs and the Big One | Pick lanes in a pack and see how the Big One starts. | `pack-racing`, `the-big-one`, `lane-choice`, `the-run` | **unity-sim `nascar.drafting.superspeedway-run.v1`**; say-this |
| `tracks-10` | Name that track | Identify a track by its shape. | `track-types`, `crown-jewel` | visual-id; multiple-choice |

#### Unit `pit-strategy`: Pit Stops & Strategy (Intermediate)

Track position, tires, fuel and the calls that win races. Prerequisites: race-flow, tracks-air.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `pits-01` | Anatomy of a pit stop | Put a four-tire pit stop in order and read a time. | `pit-crew`, `pit-stop-timing`, `four-tire-stop` | sequence-order; timing-tap |
| `pits-02` | Pit road penalties | Spot a pit road penalty and what it costs. | `pit-penalty`, `pit-road-speed` | binary-call; multiple-choice |
| `pits-03` | Track position | Explain why running in front can beat speed. | `track-position`, `clean-air` | decision-scenario; multiple-choice |
| `pits-04` | Four tires, two tires | Choose between four and two tires. | `four-tire-stop`, `two-tire-stop` | decision-scenario; term-match |
| `pits-05` | Fuel windows | Estimate how many laps a tank lasts. | `fuel-window`, `fuel-cell` | estimate-slider; fill-the-gap |
| `pits-06` | Pit or stay out | Make the caution call. | `stay-out`, `pit-cycle`, `track-position`, `two-tire-stop` | **unity-sim `nascar.strategy.caution-call.v1`**; decision-scenario |
| `pits-07` | Undercut, overcut, gamble | Explain undercut, overcut and gamble. | `undercut`, `overcut`, `gamble-strategy` | term-match; decision-scenario |
| `pits-08` | Stage strategy | Decide whether to chase stage points or track position. | `stage-strategy`, `stage-points` | decision-scenario; say-this |

#### Unit `handling`: Handling & Setup (Intermediate)

Tight, loose and what the crew chief can change. Prerequisites: car-crew, tracks-air.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `hand-01` | Tight vs loose | Describe tight and loose in plain English. | `tight-push`, `loose` | multiple-choice; visual-id |
| `hand-02` | Balance | Explain why balance decides races. | `car-balance` | binary-call; multiple-choice |
| `hand-03` | Diagnose and adjust | Diagnose tight or loose and choose the right fix. | `tight-push`, `loose`, `adjustments`, `tire-pressure`, `wedge` | **unity-sim `nascar.handling.tight-loose.v1`**; fill-the-gap |
| `hand-04` | Tire pressure | Explain how pressure changes grip. | `tire-pressure` | estimate-slider; multiple-choice |
| `hand-05` | Wedge, track bar, springs | Map adjustments to handling. | `wedge`, `track-bar`, `adjustments` | term-match; decision-scenario |
| `hand-06` | Tire falloff | Explain why tires fade and how it changes strategy. | `tire-falloff`, `long-run-speed` | estimate-slider; multiple-choice |
| `hand-07` | Long run vs short run | Explain fast-on-the-short-run. | `long-run-speed`, `tire-falloff` | say-this; multiple-choice |

#### Unit `points-chase`: Points, the Chase & the Season (Intermediate)

How the championship is decided in 2026. Prerequisites: race-flow.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `chase-01` | Race points | Compute points for a finish. | `race-points` | estimate-slider; multiple-choice |
| `chase-02` | Stage points | Add stage points to race points. | `stage-points`, `race-points` | fill-the-gap; multiple-choice |
| `chase-03` | The 26-race regular season | Explain the regular season and the 16-driver field. | `chase-2026`, `regular-season-champion` | multiple-choice; sequence-order |
| `chase-04` | The Chase, 2026 edition | Explain the 10-race Chase with no eliminations. | `chase-2026`, `points-reset` | fill-the-gap; decision-scenario |
| `chase-05` | Championship race | Explain how the finale decides the title. | `championship-race`, `chase-2026` | binary-call; multiple-choice |
| `chase-06` | Format history | Order format eras. | `playoff-format-history` | sequence-order; multiple-choice |
| `chase-07` | Charters and open teams | Explain charters and open cars. | `charter-system`, `open-team` | multiple-choice; say-this |
| `chase-08` | Qualifying formats | Explain qualifying and the pole. | `qualifying`, `starting-grid` | multiple-choice; binary-call |

#### Unit `racecraft`: Racecraft & Restarts (Intermediate)

How drivers pass, defend and survive. Prerequisites: tracks-air, pit-strategy.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `craft-01` | Passing lines | Choose the passing line. | `passing-lines`, `racing-groove` | hotspot-tap; multiple-choice |
| `craft-02` | Restart lane and jump | Pick the restart lane and jump. | `restart-strategy`, `choose-rule`, `restart` | **unity-sim `nascar.restart.choose-lane.v1`**; multiple-choice |
| `craft-03` | Getting clean air | Explain clean-air passes. | `clean-air-pass`, `clean-air` | binary-call; say-this |
| `craft-04` | Blocking and being blocked | Judge a block. | `blocking` | binary-call; decision-scenario |
| `craft-05` | Road course racecraft | Explain road-course passing. | `road-course-racecraft`, `braking-zone` | multiple-choice; visual-id |
| `craft-06` | Lapped traffic | Explain lapped traffic. | `lapped-traffic`, `lap-down` | decision-scenario; multiple-choice |
| `craft-07` | Payback | Explain payback and code. | `payback`, `wreck-vs-race` | say-this; talk-track |
| `craft-08` | Racing vs wrecking | Judge racing or wrecking. | `wreck-vs-race` | binary-call; say-this |

#### Unit `culture-debates`: Legends, Eras & Debates (Enthusiast depth)

What fans argue about at the bar. Prerequisites: points-chase.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `cult-01` | The seven-title club | Explain the three legends with seven titles. | `legends` | multiple-choice; term-match |
| `cult-02` | Daytona 500 lore | Explain why the Daytona 500 matters. | `daytona-500-lore`, `crown-jewel` | multiple-choice; say-this |
| `cult-03` | Playoff format debate | Explain both sides of the format debate. | `playoff-debate`, `chase-2026` | say-this; talk-track |
| `cult-04` | Next Gen debate | Explain the Next Gen argument. | `next-gen-debate`, `next-gen-car` | say-this; talk-track |
| `cult-05` | Stages and fuel saving | Explain the stage and fuel-saving debate. | `stage-debate`, `fuel-saving-superspeedway` | say-this; multiple-choice |
| `cult-06` | Schedule debate | Explain the schedule debate. | `schedule-debate` | say-this; multiple-choice |
| `cult-07` | Fuel-mileage finishes | Judge a fuel-mileage win. | `fuel-mileage-debate` | decision-scenario; say-this |

#### Unit `insider-craft`: The Insider Layer (Enthusiast depth)

The stuff that makes fans nod: radio, data and the rulebook. Prerequisites: racecraft, culture-debates.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `insd-01` | Spotter talk | Decode spotter calls. | `spotter-talk`, `spotter` | listening-id; say-this |
| `insd-02` | Reading the loop data | Read laps led and average running position. | `loop-data`, `laps-led` | multiple-choice; estimate-slider |
| `insd-03` | Dominant but did not win | Explain why the fastest car does not always win. | `dominant-car`, `track-position` | decision-scenario; say-this |
| `insd-04` | Damaged vehicle policy | Explain the clock. | `damaged-vehicle` | binary-call; multiple-choice |
| `insd-05` | Penalties and tech | Explain penalties. | `penalties-tech`, `inspection` | multiple-choice; say-this |
| `insd-06` | Reading a race from the lap chart | Read a race from its chart. | `running-order`, `pit-cycle`, `laps-led` | sequence-order; multiple-choice |

#### Unit `teams-people`: Teams, Owners & Drivers (Enthusiast depth)

The organizations and people behind the cars. Prerequisites: culture-debates.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `team-01` | How a team is built | Explain team organizations. | `team-organization`, `crew-chief` | multiple-choice; term-match |
| `team-02` | Alliances | Explain alliances and engine deals. | `alliances`, `manufacturers` | multiple-choice; say-this |
| `team-03` | Driver types | Name driver archetypes. | `driver-archetypes` | term-match; say-this |
| `team-04` | The pipeline | Explain the driver pipeline. | `driver-pipeline`, `series-ladder` | sequence-order; multiple-choice |
| `team-05` | Sponsors and paint | Explain sponsorship. | `sponsorship` | multiple-choice; visual-id |
| `team-06` | Rivalries | Explain rivalries. | `rivalries`, `payback` | say-this; talk-track |
| `team-07` | Manufacturer loyalty | Explain manufacturer loyalty. | `manufacturers`, `rivalries` | say-this; multiple-choice |

#### Unit `your-corner`: Your Person's Corner (Branches & personalization)

Pick the series, team, driver, manufacturer and track your person loves. Prerequisites: race-flow.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `corner-01` | Cup Series branch | Learn what Cup fans care about. | `cup-series`, `series-focus` | say-this; multiple-choice |
| `corner-02` | O'Reilly Series branch | Learn what O'Reilly fans care about. | `oreilly-series`, `series-focus` | say-this; multiple-choice |
| `corner-03` | Truck Series branch | Learn what Truck fans care about. | `truck-series`, `series-focus` | say-this; multiple-choice |
| `corner-04` | Their driver: {{driver}} | Learn the driver's story. | `driver-focus`, `driver-archetypes` | say-this; talk-track |
| `corner-05` | Their team: {{team}} | Learn the team's story. | `team-focus`, `team-organization`, `manufacturer-focus` | say-this; talk-track |
| `corner-06` | Their track: {{track}} | Learn the home track. | `track-focus`, `track-types` | visual-id; say-this |

#### Unit `this-season`: This Season (Current-season / live)

Rolling weekly lessons refreshed from live data. Prerequisites: your-corner.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `live-01` | Race preview: {{nextRace}} | Preview this week's race. | `current-season`, `track-types` | say-this; multiple-choice |
| `live-02` | Last race, explained | Explain last race in plain English. | `current-season`, `track-position` | say-this; multiple-choice |
| `live-03` | Chase picture | Read the Chase standings. | `chase-2026`, `points-reset` | multiple-choice; estimate-slider |
| `live-04` | {{driver}} this week | Explain how their driver is doing. | `driver-focus` | say-this; talk-track |
| `live-05` | Why are fans talking about this? | Understand a current storyline. | `current-season`, `playoff-debate` | say-this; multiple-choice |
| `live-06` | What to say Monday | Prepare a Monday conversation. | `conversation-basics`, `current-season` | talk-track; say-this |

#### Unit `talk-lab`: The Talk Lab (Conversation practice)

Practice real conversations. Prerequisites: race-flow.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `talk-01` | First race together | Have a first conversation about a race. | `conversation-basics` | talk-track |
| `talk-02` | Talk about a pit call | Discuss a pit call. | `pit-cycle`, `stay-out` | talk-track |
| `talk-03` | Talk about a wreck | Talk about a wreck. | `the-big-one`, `wreck-vs-race` | talk-track |
| `talk-04` | Talk about the Chase | Discuss the Chase. | `chase-2026` | talk-track |
| `talk-05` | Talk about their driver | Discuss their driver. | `driver-focus` | talk-track |
| `talk-06` | What is she talking about? I | Decode enthusiast lines. | `conversation-basics` | say-this |
| `talk-07` | What is she talking about? II | Decode advanced lines. | `conversation-basics` | say-this |
| `talk-08` | Recovering from a wrong guess | Recover gracefully. | `conversation-basics` | talk-track; say-this |

#### Unit `perpetual-review`: Keep It Fresh (Perpetual review)

Spaced review that never ends. Prerequisites: nascar-101.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `rev-01` | Daily Bite | One card a day. | `useful-competence` | multiple-choice; fill-the-gap |
| `rev-02` | Weak spot review | Review weak concepts. | `useful-competence` | mixed |
| `rev-03` | Season refresh | Refresh rules changes. | `chase-2026` | multiple-choice; say-this |
| `rev-04` | Mastery check-in | Reconfirm mastery. | `useful-competence` | mixed |

### Live-layer templates (unit `this-season`)
Rolling lessons instantiated weekly from live data and editorial: race preview, last-race explainer, Chase picture, driver in focus, "why are fans talking about this", and a "what to say Monday" talk track. New items ship every race week (36 per season) and at season boundaries (schedule, rules changes, rosters). Items carry `live` hooks (`liveHooks: schedule, results, standings, roster, news`) and a `validUntil` so stale cards disappear. Static lessons never hard-code current standings, winners or rosters.

### Review policy (unit `perpetual-review`)
- Spaced intervals after mastery: 1, 3, 7, 16, 35, 90 days; a failed review resets to 1 day.
- Max 12 review items per day; Daily Bite = 3 items; weak-concept review triggers when mastery drops below 0.6.
- Season refresh: at each season boundary, all `rules-2026`-tagged concepts are re-reviewed and rewritten to the new season's rules first.
- Mixed sets draw from mastered and weak concepts; Unity sims may be reused as review at levels above the learner's last success.

### Personalization slots
`{{driver}}`, `{{team}}`, `{{series}}`, `{{manufacturer}}`, `{{track}}`, `{{nextRace}}` in units `your-corner`, `this-season`, `talk-lab`, `teams-people`, `tracks-air` (see section 8).

### Release plan
- **Launch (v1.0):** units `nascar-101` through `racecraft` (Foundations and Intermediate), `talk-lab`, `perpetual-review`, `your-corner` (Cup branch and driver/team/manufacturer slots), `this-season` (preview, recap, Chase picture, Monday talk), and the first three sims (`tuck-in`, `caution-call`, `tight-loose`). Lessons `tracks-05`, `tracks-09` and `craft-02` launch with their native activities (the fallback sets named in each sim spec) and the sim activity unlocks when Astra ships it.
- **v1.1 (about 8 weeks later):** units `culture-debates`, `insider-craft`, `teams-people`; sims `superspeedway-run`, `choose-lane`, `groove-read`; O'Reilly and Truck branches.
- **Ongoing:** weekly live items; season-boundary refresh (new season rules, schedule, rosters); new talk tracks monthly; new sim scenarios per season; NASCAR Brasil, Canada and regional series are out of scope unless requested.

## 12. Interaction plan

Every activity family maps to a native type or a Unity sim with justification. Tier rubric per `CLAUDE.md` section 4: Unity only where spatial reasoning, movement, physics, timing in a scene or camera perspective materially improves learning and a native exercise would teach it clearly worse.

| Lesson / activity family | Concepts | Type (native exercise or `unity-sim`) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| `tracks-06` Drafting: free speed | drafting, aerodynamic-drag, the-run, dirty-air | `unity-sim` `nascar.drafting.tuck-in.v1` | Physics + camera: invisible air, a distance-dependent effect and a slingshot timing. Native `binary-call` could state "closer is faster" but not let the learner discover the shape of the effect. Spec: `sims/nascar.drafting.tuck-in.v1.md` | A | 1 lesson (+review reuse) |
| `tracks-09` Packs and the Big One | lane-choice, the-run, pack-racing, the-big-one, blocking, spotter-talk | `unity-sim` `nascar.drafting.superspeedway-run.v1` | Reading a dynamic scene: which lane has the momentum depends on how a line of cars is moving and what the car ahead is about to do. `decision-scenario`/`hotspot-tap` show a snapshot, not motion. Spec: `sims/nascar.drafting.superspeedway-run.v1.md` | A | 1 lesson |
| `pits-06` Pit or stay out | stay-out, pit-cycle, track-position, four-tire-stop, two-tire-stop, fuel-window, stage-strategy, tire-falloff | `unity-sim` `nascar.strategy.caution-call.v1` | Dynamic scene: the field re-sorts through pit road and the restart. Justification is moderate: `decision-scenario` teaches the facts (and is paired in the same lesson); the sim adds the visible reshuffle. Documented native fallback. Spec: `sims/nascar.strategy.caution-call.v1.md` | A | 1 lesson |
| `hand-03` Diagnose and adjust | tight-push, loose, car-balance, adjustments, tire-falloff, long-run-speed, dirty-air | `unity-sim` `nascar.handling.tight-loose.v1` | Physics + camera: tight/loose are defined by how the car moves through a corner; slip arrows on a top-down view teach it better than a still image or definition. Spec: `sims/nascar.handling.tight-loose.v1.md` | A | 1 lesson |
| `craft-02` Restart lane and jump | choose-rule, restart-strategy, restart, lane-choice, racing-groove, road-course-racecraft | `unity-sim` `nascar.restart.choose-lane.v1` | Dynamic scene with relative positions and timing: stacks form and fan out. Justification is moderate; `binary-call` covers the rule (in `flow-05`). Documented native fallback. Spec: `sims/nascar.restart.choose-lane.v1.md` | A | 1 lesson |
| `tracks-05` Banking, grooves and rubber | racing-groove, banking, rubbering-in, flat-track, dirty-air | `unity-sim` `nascar.track.groove-read.v1` | Spatial reasoning: banking, rubber and lane length are surface properties best read from above and then raced by three ghost cars. `hotspot-tap` in the same lesson covers recognition. Spec: `sims/nascar.track.groove-read.v1.md` | A | 1 lesson |
| Flags, terms, positions, tracks vocabulary | flags, tracks, crew roles, manufacturers | `term-match` ([catalog](../../native-exercises/CATALOG.md)) | Recall of 3-6 related terms; no motion needed. | B | ~40 |
| Rules recall and quick review | rules, formats, terminology | `multiple-choice` | The default review card; explanation on every answer. | B | ~260 |
| Pit road, free pass, flat-track and racing-vs-wrecking calls | pit-penalty, free-pass, flat-track, wreck-vs-race | `binary-call` | A two-way call on a static diagram (the rubric says native). | B | ~90 |
| Pit stop order, race flow, championship eras | pit-crew, stage-racing, playoff-format-history | `sequence-order` | Order matters; steps are discrete. | B | ~30 |
| Flag, aero-part and track-shape recognition | flags, spoiler-splitter, track-types | `visual-id` | Recognition is the skill; illustrations are original. | B | ~55 |
| Strategy judgment paired with sims and stand-alone | pit-cycle, stay-out, blocking, fuel-window | `decision-scenario` | Facts to weigh and consequences without needing motion. | B | ~60 |
| Pit stop, pit-entry and restart-jump timing feel | pit-stop-timing, restart | `timing-tap` | One-dimensional timing; a scene is not needed (rejected as Unity). | B | ~15 |
| Magnitudes: laps, points, seconds, horsepower | laps-and-distance, race-points, pit-stop-timing | `estimate-slider` | A number is the lesson; closeness matters more than exactness. | B | ~45 |
| Pit stall and turn/lane diagrams | pit-crew, racing-groove, restart | `hotspot-tap` | Fixed diagram; if cars move, it is a sim. | B | ~40 |
| Terms in context, the Chase sentence | chase-2026, tight-push, choose-rule | `fill-the-gap` | Vocabulary in context and quick review. | B | ~70 |
| Spotter calls | spotter-talk | `listening-id` | Recognition of short calls; original synthesized audio. | B | ~12 |
| What is she talking about? (fan language) | all Enthusiast concepts | `say-this` | The signature conversation-interpretation exercise. | B | ~140 |
| Conversation practice (Talk tab, Talk Lab, unit ends) | conversation-basics + unit concepts | `talk-track` | Conversation is native by definition (spec section 13). | B | ~45 + 24 |

**Considered and rejected for Unity:** pit stop timing (`timing-tap`, 1D); flags (`term-match`/`visual-id`); track shape identification (`visual-id`); tire wear as a magnitude (`estimate-slider`); race strategy as pure facts (`decision-scenario`); qualifying and points math (`estimate-slider`, `fill-the-gap`).

**Unity share:** 6 of 108 lessons (about 5.5%) have a Unity sim; sims are also reusable as review at higher difficulty. Every sim has a native fallback lesson for accessibility or capacity limits (named in each spec, section 16).

## 13. Licensing & safety
- **Imagery:** no team liveries, sponsor logos, driver photos or NASCAR marks in images unless licensed; use original illustrations (`original-swoond`) and fictional numbers/liveries in sims. Team and driver names appear as facts in text (nominative use) with a trademark note in the app legal page.
- **Audio:** only original synthesized audio (spotter calls, cues); no broadcast audio, no driver radio, no engine recordings from licensed sources.
- **Logos/trademarks:** NASCAR, series names and team names used descriptively; no implied endorsement; "unofficial" language in the legal footer.
- **Video:** none in the course.
- **Lyrics:** n/a.
- **Article text:** never copied (spec section 11, 37); explain and link.
- **Data provider terms:** licensed providers only (spec section 32-36); attribution shown where required; no scraping of NASCAR.com, Racing-Reference or team sites.
- **Player likeness:** no player-likeness renders; only names in text.
- **Safety:** motorsport crashes can injure and kill real people. Wreck content is calm, factual, never dwells on injury or fatalities; no gamified crash outcomes; sims stylize wrecks as cars sliding clear. No encouragement of dangerous driving on public roads; no wagering framing.

## 14. Content assets
- **Procedural:** all six sims (cars, tracks, overlays, cues); track outlines; pit stall diagram; groove diagrams; flag illustrations; aero-part diagrams (drawn by design, `original-swoond`).
- **Licensed/none:** no photography in v1. Any later photography requires an explicit license id (e.g. CC BY with attribution, or a wire-service license) and a review.
- **Audio:** ~12 synthesized spotter clips (`original-swoond`); UI cues synthesized.
- **Diagrams needed:** `nascar-oval-front-stretch`, `nascar-field-under-caution`, `nascar-pit-stall`, `nascar-turn-grooves`, `nascar-restart-double-file`, `nascar-turn-contact`, track outlines for ~12 tracks (generic silhouettes, no branding).

## 15. Section 47 quality checklist

- [x] 1. What does a beginner need to understand? Sections 2-3 (flags, stages, pit road, track types, drafting, points and the Chase, the car and balance).
- [x] 2. What do enthusiasts care about? Section 4 (strategy, track position, debates, rivalries).
- [x] 3. What current information matters? Section 6 (schedule, results, Chase standings, rosters, news).
- [x] 4. What should be interactive? Section 12 (six Unity sims; native everything else).
- [x] 5. What should NOT be gamified? Section 5 (crashes and injuries, wagering, reckless driving).
- [x] 6. How should it personalize? Section 8 (series, driver, team, manufacturer, home track).
- [x] 7. What does conversational competence look like? Section 9 and 10.
- [x] 8. What data providers are needed? Section 6 and `live-data.md`.
- [x] 9. What licensing constraints apply? Section 13.
- [x] 10. How will Swoon'd measure useful understanding? Section 10 (concept mastery 0.80, talk-track Smooth, spaced review).

Additional gates: [x] manifest validates (`node tools/validate/validate.mjs`); [ ] curriculum validates (curriculum JSON not yet authored); [ ] every Unity sim has an approved spec (6 specs drafted, status `spec-draft`); [ ] every image/audio asset has a license id (assets not yet produced); [ ] voice review; [x] no copied publisher text.

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Verify Orange Cat Blacktop's coverage, pricing and terms for NASCAR (Cup, O'Reilly, Trucks): schedules, results, standings, rosters. Fallback candidates: Sportradar/SportsDataIO. | Product | Blocks live layer |
| 2 | News/editorial provider and licensing (DECISIONS Q-3). | Product | Blocks editorial cards |
| 3 | Confirm 2026 rules items before launch and after each season boundary: horsepower packages by track type, Chase reset values, charter terms after the December 2025 settlement, stage-length policy. All are tagged `rules-2026`. | Content | No |
| 4 | Stylized constants in the sims (draft bonus, lane momentum, projection model, balance and lane models) need a NASCAR subject-matter check for plausibility. | Product / Claude | No |
| 5 | Should the O'Reilly and Truck branches ship at launch or v1.1 (current plan: v1.1)? | Product | No |
| 6 | Voice review of the six sim scripts and the talk tracks (cheeky coach, never mean, never about the crush). | Product | No |
| 7 | Naming: is "the Chase" the right term to teach for 2026, given older fans also say "playoffs"? Plan: teach both, prefer "the Chase" (official 2026 name). | Content | No |

**Verification notes (2026-09-30).** Web-verified: Chase format and reset values (2,100 / 2,075 / 2,065 / 2,060 then -5 to 2,000), 55 points for a win, no win-and-in and no playoff points, the 10-race Chase list ending at Homestead-Miami on Nov 8, horsepower by track type (510 / 670 / 750), the Talladega stage-length change, the December 2025 permanent-charter settlement, series names. Sources consulted: nascar.com news, Yahoo Sports, Fox Sports, Red Bull, Bleacher Report, Sportico, Jayski, Wikipedia (Next Gen). Details that could not be fetched directly from nascar.com (403) were cross-checked against multiple secondary sources; recheck before release.

