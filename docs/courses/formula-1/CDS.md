# Course Design Specification: Formula 1 (`formula-1`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Facts about the 2026 season were verified by web search on 2026-09-30 and are flagged "verify" where a live source of truth (FIA regulations, the official calendar) must be re-checked before each release.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 1 |
| Author / date | Claude (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/*.md`, `NOTES_FOR_ORCHESTRATOR.md` |

---

## 1. Identity
- **Course ID:** `formula-1` (immutable)
- **Display name:** Formula 1
- **Category / family:** Motorsports; category path `Sports > Motorsports > Formula 1`
- **Simulation prefix:** `f1` (sim IDs are `f1.<topic>.<name>.v<N>`)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns F1, are they meaningfully conversationally competent about ...?" | Verdict | Consequence for structure |
|---|---|---|---|
| NASCAR (`nascar`) | Mostly no. Stock cars on ovals; stage racing, drafting packs, cautions, no active aero, different fan culture. Shared ideas (pit stops, tyres, drafting) transfer only as vocabulary. | sibling-independent | Separate course; cross-link `undercut`, `slipstream`, `pit-stop` as concepts only. The sim ID prefixes differ (`nascar` vs `f1`) even though both are motorsport and may share a data provider (spec section 36). |
| IndyCar / MotoGP / WRC / Formula E (future) | No. IndyCar shares open-wheel DNA and Indy 500 lore; MotoGP is motorcycles; WRC is rally; Formula E is spec-battery street racing (Formula E energy management borrows 2026 F1 ideas). | sibling-independent | Future courses. F1 links out in the `triple-crown` lore only. |
| Cars (`cars`) | No. Road-car knowledge does not decode strategy, regulations or team politics. Some overlap on engines and aero vocabulary. | adjacent | Cross-link `downforce`, `understeer`, `power-unit` concepts. |
| Video Games (`video-games`) | Partially: F1 game fans know the vocabulary but rarely the rules. | adjacent | None. |
| Soccer / other team sports (fan-culture) | No. Only the "club loyalty" behaviour transfers (tifosi). | adjacent | None. |

- **Branches:** F1 is one continuous world championship; there is no league split. Branches are the team paths, because a person's fandom is overwhelmingly team- or driver-shaped. Each branch personalizes the `team-story` unit and the live layer; the foundation, intermediate and debates layers are shared.

| Branch id | Name | What changes |
|---|---|---|
| `ferrari` | Ferrari | History and tifosi culture; works Ferrari power unit (also supplies Haas and Cadillac); Hamilton and Leclerc; strategy-blame culture |
| `mercedes` | Mercedes | Works team and engine supplier (McLaren, Williams, Alpine); Antonelli and Russell; 2026 form; the compression-ratio story |
| `red-bull` | Red Bull | Red Bull Ford power unit (Red Bull and Racing Bulls); the junior programme; Verstappen and Hadjar |
| `mclaren` | McLaren | Mercedes-powered customer team; Norris and Piastri; 2025 constructors' and drivers' champions story |
| `aston-martin` | Aston Martin | Honda works-style partnership; Alonso and Stroll; new-factory story |
| `williams` | Williams | Historic independent; Mercedes power; Albon and Sainz |
| `alpine` | Alpine | Switched to Mercedes power for 2026; Gasly and Colapinto |
| `haas` | Haas | Ferrari-powered American team; Ocon and Bearman |
| `audi` | Audi | New works team from the Sauber entry; Audi power unit; Hulkenberg and Bortoleto |
| `cadillac` | Cadillac | 11th team, new for 2026; Ferrari power now, GM engine planned; Perez and Bottas |
| `racing-bulls` | Racing Bulls | Red Bull's sister team; Lawson, Lindblad and Tsunoda; junior-driver storylines |

## 2. Beginner model
- **What a complete beginner knows:** "Fast cars go round and round"; maybe that Lewis Hamilton and Max Verstappen exist; maybe a vibe from Drive to Survive (drama, team bosses, paddock feuds); that Ferrari is red and Monaco is glamorous. Most think winning is about the fastest driver and that the sport is about speed alone.
- **Terminology that will confuse them:** power unit (not "engine"), constructor, parc ferme, undercut/overcut, box box, delta, stint, dirty air, deg (degradation), lift and coast, clipping, VSC, purple sector, "the tow", track limits, pole, "five-second penalty", "he's on the mediums", and for 2026 Straight Mode / Corner Mode, Overtake Mode, Boost, Recharge, super clipping.
- **Common misconceptions:**
  1. "Whoever starts first wins." Track position matters, but pit cycles, tyre age and safety cars scramble it; the timing tower does not equal the running order between stops.
  2. "Drivers stop when something breaks." Pit stops are planned; the two-compound rule forces at least one dry-weather stop.
  3. "DRS is still how people overtake." DRS was retired after 2025; 2026 uses active aero and Overtake Mode.
  4. "Softer tyres are simply better." Faster per lap, worse life; "best" depends on the stint length and the track.
  5. "More downforce is always good." It costs drag; Monza and Monaco want opposite set-ups.
  6. "The best driver wins the title." The car is the biggest variable; the teammate is the fairest comparison.
  7. "The fastest lap gets a point." Not since 2025.
  8. "It is the engine." It is a power unit: a V6 turbo plus an electrical system, roughly 50/50 in 2026.
  9. "Refuelling stops." No refuelling in F1 since 2010; stops are for tyres (and repairs).
  10. "A red flag ends the race." It pauses it, allows tyre changes and the race restarts.
  11. "A safety car is a crash." It is a neutralisation, used after crashes or debris.
  12. "Lewis is at Mercedes." Hamilton has driven for Ferrari since 2025.
- **Concepts that unlock the rest (foundation units):** how a weekend flows and scores; flags and neutralisations; downforce versus drag; tyre compounds and degradation; the undercut; and, for the current era, the 2026 power unit and active aero.

## 3. Foundational knowledge
Grouped into modules that become `foundationalModules[]` and the five foundation units:

1. **Race weekend 101 (`race-weekend-101`):** the sport and its two championships; the 2026 grid (11 teams, 22 seats: Alpine, Aston Martin, Audi, Cadillac, Ferrari, Haas, McLaren, Mercedes, Racing Bulls, Red Bull, Williams); works versus customer; the weekend (three practice sessions; qualifying in Q1/Q2/Q3; the race of about 305 km with a two-hour cap); parc fermé; points 25-18-15-12-10-8-6-4-2-1, no fastest-lap point since 2025; sprint weekends (SQ1-SQ3, a roughly 100 km sprint scoring 8 to 1).
2. **Flags and officials (`flags-and-officials`):** yellow, double yellow, red, blue, black, black-and-white, chequered; safety car versus VSC; red-flag restarts; the FIA, race director, stewards; time penalties (5 s, 10 s), drive-through, grid drops, penalty points (12 in 12 months means a one-race ban; from 2026 the system is used for genuinely dangerous or unsportsmanlike incidents); track limits; unsafe release; blue-flag obligations.
3. **Car and circuit (`car-and-circuit`):** monocoque, halo, wings, floor, power unit; downforce versus drag; circuit personalities (street, high-speed, traction); racing line, apex, braking, trail braking, understeer and oversteer; timing screens; DRS's history.
4. **Tyres and pit stops (`tyres-and-pit-stops`):** Pirelli C1 to C5 and the three-compound weekend allocation labelled hard/medium/soft (white/yellow/red); intermediates (green) and full wets (blue); degradation, graining, blistering, the cliff; the stop; two-compound rule; undercut and overcut; pit calls.
5. **The 2026 reset (`the-2026-reset`):** why the new rules; smaller and lighter cars (minimum weight 768 kg, wheelbase about 3.4 m, narrower floor and tyres, less downforce and drag than 2022 to 2025); the power unit (1.6 litre V6 turbo of about 400 kW plus MGU-K of up to 350 kW, MGU-H deleted, ~50/50 split); 100% sustainable fuel; active aero (Straight Mode and Corner Mode, fans say X and Z); Overtake Mode (within one second at the detection point) and Boost; harvesting and clipping; the new entrants and partnerships (Audi works team, Cadillac as the 11th team, Ford with Red Bull, Honda with Aston Martin, Alpine on Mercedes power).
6. **History and equipment culture:** in `history-and-lore` (enthusiast layer) with light touches earlier.

## 4. Enthusiast model
- **What enthusiasts talk about:** last race's strategy calls ("why did they not undercut?"), tyre deg and stint lengths, qualifying gaps, teammate comparisons, upgrades and "what they brought to this track", the pecking order between teams, engine performance, stewards' decisions, silly season and contracts, and (2026) energy management, clipping, wing modes and Overtake Mode.
- **Distinctions that matter:** race pace versus one-lap pace; the fastest car versus the fastest driver; a works team versus a customer; car development trajectory (who is improving); strategy versus execution; tyre management versus outright pace; a stewards' "racing incident" versus a "causing a collision" call.
- **Knowledge that signals genuine understanding:** using "deg", "stint", "undercut", "track position" naturally; asking which compound a driver is on and how old it is; knowing what sector times imply; noticing the gap to the car ahead in seconds and its trend; separating car limitations from driver mistakes; understanding why energy management changes how the 2026 race unfolds (where the car deploys and clips).
- **Beginner statements that sound obviously uninformed:** "Why do they keep stopping for gas?"; "Is DRS still on?"; "He's just faster, that's why he won"; "The driver in the lead is winning" (ignoring pit cycles); "It is only the engine that matters"; "Is the safety car a crash?"; "Ferrari always wins."
- **Controversies and debates (2026 current-era and perennial):**
  - Do active aero and energy-managed racing improve or artificially complicate the show (lift-and-coast, clipping, critics who say drivers now manage a battery more than they race; the April 2026 package to increase clipping recharge allowance to 350 kW and cut qualifying recharge from 8 to 7 MJ)?
  - Power-unit fairness: the 2026 compression-ratio measurement dispute (cold versus hot), the ADUO safety net after rounds 6, 12, 18 for underperforming manufacturers.
  - Stewarding consistency and the penalty-point system.
  - Whether sprint weekends dilute Grand Prix weekends.
  - Calendar politics: new venues and disruption (Madrid's street circuit joined as the Spanish GP while Barcelona-Catalunya kept a date under its own name; Imola dropped; Malaysia's Sepang hosting the relocated Bahrain GP; the Saudi Arabian GP cancelled because of the Middle East conflict) versus classic circuits.
  - The cost cap (2021 breach saga) and the sliding scale of aero testing restrictions.
  - Car versus driver: how much can be attributed to whom (teammate benchmark).
  - Driver-market power moves: Hamilton at Ferrari, Verstappen's future, junior-programme churn.

## 5. Interaction model
- **What the learner should experience rather than read:** racing lines at real corner geometry; the tow and dirty air on a straight; wings opening and closing on a lap; the battery running flat on a straight; a pit window opening with rivals on track; the safety car deploying at the worst moment. Everything else is decision-making from a fact sheet, sorting, recognising or conversing.
- **Does the course warrant Unity?** Yes, selectively. F1 is a spatial, dynamic, physics-driven sport where the concepts fans discuss (line, tow, wake, energy, gaps over laps, safety car bunching) are about things moving over time in space. Six sims are planned (section 12); each maps to a cluster of concepts that native diagrams teach clearly worse.
- **Native is better for:** flags and rules (visual-id, binary-call), terminology (term-match, fill-the-gap), race weekend flow and pit stop steps (sequence-order), scoring and magnitude intuition (estimate-slider), one-shot strategy judgment (decision-scenario), conversation (say-this, talk-track), the pit stop reflex (timing-tap, a 1D bar per D-002 stays native).
- **What should NOT be gamified:** crashes, injuries and fatalities (Imola 1994, Bianchi 2014, Grosjean 2020 are told in a respectful, non-interactive lesson: `hl-06-how-f1-got-safer`); betting or prediction stakes; contract negotiations and salaries; political feuds between named individuals; "who is the greatest driver of all time" (taught as a debate with no correct answer); realistic driving simulation ("do not turn this into a racing game"); team radio audio (rights).
- **Listening-id:** not used at launch; race audio, engine sound and team radio recordings are FOM-owned or unlicensed. Revisit with original synthesized engine notes if the product owner wants an "hear the era" exercise (open question).
- **Summary of the mix:** Native: multiple-choice, say-this, decision-scenario, binary-call, term-match, talk-track, estimate-slider, fill-the-gap, hotspot-tap, sequence-order, visual-id, timing-tap. Unity: six focused sims. Detailed in section 12.

## 6. Dynamic information requirements
Motorsport is a strong live-data fit (spec section 33): results, standings, calendar, the grid, and weather change every weekend. Learners need "recent result, current standings, next race, my driver's weekend", not timing-screen telemetry. Details, entities and licensing are in `live-data.md`.

| Kind | Needed? Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|
| schedules | Yes: next session times, the round, sprint or not, circuit | Jolpica-F1 (Ergast successor), Orange Cat Blacktop, OpenF1 (2023+), TheSportsDB | daily; hourly on race weeks | Last cached calendar; static circuit primers |
| scores (results) | Yes: race, sprint, qualifying, practice classification | Orange Cat Blacktop, Jolpica-F1, OpenF1, API-Sports F1 | minutes-during-events | Show "results not yet available", link out |
| standings | Yes: drivers' and constructors' tables, title permutations | Jolpica-F1, Orange Cat Blacktop, OpenF1 | daily; minutes after a race ends | Last cached standings with stamp |
| rosters | Yes: teams, driver line-ups, numbers, engine supplier (changes happen mid-year) | Orange Cat Blacktop, Jolpica-F1, Swoon'd editorial file | weekly | Bundled 2026 pack |
| statistics | Light: pit stops, tyre stints, fastest laps, gap charts for "decode the race" | OpenF1 (historical), Orange Cat Blacktop | hourly on race days | Hide stat cards |
| weather | Yes: rain risk changes tyre strategy, so it is a teaching moment | Apple WeatherKit (native), Open-Meteo, national services | hourly on race weekends | Omit forecast card |
| news / editorial | Yes: "why are fans talking about this?" | Publisher headlines and links only, licensed API TBD (Q-3) | hourly | Editorial explainers only |
| events (regulation and steward decisions) | Yes: technical directives, mid-season rule changes, penalties | FIA documents (linked), Swoon'd editorial | weekly | Evergreen explainers |

- **Not needed:** wagering odds, betting lines, sub-second timing, full telemetry, driver social feeds, ticketing.
- **Structured and editorial data are separate systems** (spec section 11). Provider payloads are normalised behind Swoon'd adapters; no provider schema is the domain model.

## 7. Editorial context
- **What commentary helps:** why a strategy call was controversial; why a penalty was given (and why fans argue); what an upgrade does; why the title picture changed; what a rules tweak means for racing; why a driver move is news.
- **Appropriate sources (links and headlines only unless licensed):** formula1.com and fia.com official news and documents; The Race, Autosport, Motorsport.com, RaceFans, BBC Sport, Sky Sports F1 (each requires rights review before any programmatic use).
- **Summarize, explain or link?** Explain in our own words and link to the original (spec section 11). Never copy article text; never reproduce team-radio transcripts beyond a short quote for the purpose of teaching, and prefer paraphrase.
- **Example prompts:** "Why are fans talking about clipping today?"; "Why was that a five-second penalty?"; "Why did the team pit under the virtual safety car?"; "What is the compression-ratio row about?"; "What does ADUO change for Honda?"

## 8. Personalization

| Dimension | Values | How it changes examples and live context | Default when unset |
|---|---|---|---|
| `team` | 11 teams (branches) | `team-story` unit; strategy and power-unit examples use `{{team}}`; live feed prioritises the team's session results, upgrades and radio moments | `Ferrari` (the sport's oldest, most-recognised team) |
| `driver` | 22 drivers | `{{driver}}` in `yt-04`, `sl-04`; live "your driver this weekend" card; talk tracks reference the driver's storyline | `Charles Leclerc` |
| `region` | Country or nearest GP | Circuit primers: "if you can only go to one race, {{region}}" and time-zone-aware session times | `Monza` (as a place-name token: "the Italian Grand Prix") |

Units using tokens: `team-story` (team, driver), `season-live` (team, driver, region), some `paddock-talk` tracks. Other units stay generic but may use `{{team}}`-flavoured examples in their intros; all sentences must read correctly with the default substituted.

## 9. Conversation model
Example lines an enthusiast might say (with translation):

| # | She says | What it means | Terms implied | Meaningful follow-ups |
|---|---|---|---|---|
| 1 | "Pole by three tenths, and it's Monaco. That's basically the race." | Fastest in qualifying by 0.3 s at a track where passing is very hard; starting first is worth a lot. | pole-position, street-circuit, track-position | "Is that why they don't need a fast car there?" / "Do they think anyone can undercut him?" |
| 2 | "They undercut him and he never got it back." | The rival pitted first, got a quick lap on fresh tyres, and jumped ahead when he stopped. | undercut, pit-window, track-position | "Should he have pitted earlier?" |
| 3 | "He's cooked his fronts. Deg is killing him." | His front tyres are overheating and losing grip, costing lap time. | tyre-degradation, tyre-management | "Would a different compound have helped?" |
| 4 | "Safety car came out right after he pitted. Worst luck." | He paid the full pit-loss just before the field bunched, whereas rivals stopped cheaply. | safety-car-stop, pit-loss | "Does the team ever gamble on that?" |
| 5 | "The stewards gave him five seconds for that? Come on." | A time penalty for causing contact; she thinks it was harsh. | stewards, time-penalty | "What would the alternative call have been?" |
| 6 | "He clipped at the end of the straight and got passed." | The battery was empty, so the car stopped accelerating and was passed. | super-clipping, energy-store | "Is that because he deployed too early?" |
| 7 | "Their race pace was way better than their quali." | The car is quicker over a stint than over one lap; a good sign for Sunday. | race-pace-vs-quali-pace | "Where do they start? Could they pass?" |
| 8 | "Straight mode on the back straight, and boom, gone." | The driver opened the wings for low drag and pulled away. | straight-mode, active-aero | "Does he need to be inside a second for that?" (Trap: no, Straight Mode is for everyone; Overtake Mode needs the gap.) |
| 9 | "Overtake Mode did nothing because the wake killed him." | He got the electrical boost but dirty air cost him the tow and grip. | overtake-mode, dirty-air | "How close do you have to be?" |
| 10 | "They're double-stacking and the second car lost ten seconds." | Both cars pitted on consecutive laps; the second waited in the pit lane. | double-stack | "Would they have split the stops?" |
| 11 | "Our reliability is the whole story. Two DNFs in three." | The car is fast but failing to finish. | reliability, dnf | "Is it the power unit or something smaller?" |
| 12 | "Silly season has started; his contract's up in 2027." | Rumours about who will drive for whom; his seat may open. | driver-market | "Which teams need a driver?" |
| 13 | "Track limits deleted his best lap. Gutted." | His lap was cancelled because he ran wide, so he starts lower. | track-limits, starting-grid | "Do they make it easy to tell where the line is?" |
| 14 | "Verstappen is on the hards to the end? That's a long stint." | An aggressive one-stop plan; tyre life is the risk. | stint, hard-medium-soft | "Will the tyres last?" |

- **How Swoon'd helps without encouraging fake expertise:** every say-this exercise ends with a follow-up question, not a canned opinion; the coach note steers toward genuine curiosity ("Ask, do not assert"); talk tracks reward listening (asking about her driver) over jargon dumping; the `noFakeExpertNote` field is filled on every enthusiast-layer say-this.
- **Targets:** 30 standalone talk tracks (Talk tab), 31 embedded talk-track activities in lessons, about 87 say-this items at launch and 8 to 10 new say-this items per race weekend in the live layer.

## 10. Assessment
- **How useful competence is determined:** concept mastery (`concept-mastery-v1`, 0..1 per concept, +0.20 correct / -0.15 wrong; sim `masterySignals` in `[-0.25, +0.25]`), weighted toward say-this and talk-track outcomes because those mirror the real social act.
- **Recognise:** the flags, the tyre colours, circuit types, the parts of the car, team names and engines, who is champion and who is in each seat.
- **Understand:** why downforce trades with drag, why tyres degrade, why undercuts work, what a safety car does to gaps, what the 2026 power unit and active aero change.
- **Explain (to someone else):** "why did the safety car change the race?", "what is Overtake Mode?", "why would you pit under a VSC?".
- **Interpret correctly (situations):** a pit call, a stewards' decision, a strategy trade-off, a fan line about clipping.
- **Mastery model:** `concept-mastery-v1`, pass threshold 0.8.
- **Useful competence statement:** "Can follow a Grand Prix with a fan, decode common strategy, penalty and 2026 energy-and-aero chatter, and ask a follow-up question that shows real understanding of why their team or driver's race unfolded the way it did."

## 11. Curriculum map (ongoing course)
The course is designed to keep shipping: 15 units, 106 lessons at launch across all six layers, with the live layer refilled every race weekend and each new season adding a regulation-era unit. Concept count target: 127 Playbook concepts at launch (registry in Appendix A).

Layer summary:

| Layer | Purpose | Units | Lessons |
|---|---|---|---|
| Foundations | Terms, rules, how it works | 5 | 38 |
| Intermediate | Strategy, distinctions, context | 4 | 28 |
| Enthusiast depth | What fans debate; history; your team | 3 | 20 |
| Current-season / live | Weekly refreshed templates | 1 | 8 |
| Conversation practice | Talk tracks and say-this | 1 | 8 |
| Perpetual review | Leitner boxes | 1 | 4 |

### Layer: Foundations

| Unit id | Unit title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `race-weekend-101` | How a Grand Prix weekend works | none | 8: What Formula 1 actually is; Who is on the grid in 2026; Friday to Sunday; Q1, Q2, Q3: the knockout; Lights out to chequered flag; Points, podiums and the two titles; Sprint weekends; Your first Sunday text | chequered-flag, constructor, constructors-championship, customer-team, dnf, drivers-championship, engine-supplier, fastest-lap, formation-lap, grand-prix... |
| `flags-and-officials` | Flags, safety cars and who is in charge | `race-weekend-101` | 6: The flags you will see; Why the safety car exists; VSC or full safety car?; Red flags and restarts; Stewards and the penalty menu; Track limits and unsafe releases | black-flag, blue-flag, chequered-flag, gap-and-interval, grid-penalty, parc-ferme, penalty-points, race-director, red-flag, safety-car... |
| `car-and-circuit` | The car and the circuit | `race-weekend-101` | 8: Anatomy of an F1 car; Downforce versus drag; Monaco, Monza, Spa: circuit personalities; The racing line; Brake, turn, throttle; Understeer and oversteer; Reading the timing screen; DRS: what it was and why it went | apex, braking-zone, dirty-air, downforce, drag, drs, gap-and-interval, hairpin, halo, high-speed-corner... |
| `tyres-and-pit-stops` | Tyres and pit stops | `race-weekend-101` | 8: Why tyres decide races; Hard, Medium, Soft; Intermediates and full wets; Degradation, graining, blistering and the cliff; Anatomy of a pit stop; The two-compound rule; Undercut and overcut: first taste; Reading a pit wall call | blistering, box-box, crossover-point, full-wet-tyre, graining, hard-medium-soft, intermediate-tyre, one-stop-strategy, overcut, pirelli-compounds... |
| `the-2026-reset` | The 2026 reset | `car-and-circuit` | 8: Why F1 reset the rules; Smaller, lighter, narrower cars; The 50/50 power unit; Straight Mode and Corner Mode; Overtake Mode and Boost; Recharging: where the energy comes from; Sustainable fuel; Audi, Cadillac, Ford, Honda: who is new | active-aero, boost-button, constructor, corner-mode, cost-cap, customer-team, downforce, drs, energy-store, engine-supplier... |

#### Unit `race-weekend-101`: How a Grand Prix weekend works

What F1 is, who competes, how a weekend flows and how points work.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `rw-01-what-is-f1` | What Formula 1 actually is | Explain F1 as a world championship of teams and drivers across roughly 23 races. | grand-prix, constructor, drivers-championship, constructors-championship | multiple-choice x3; term-match x1; say-this x1 |
| `rw-02-who-is-on-the-grid` | Who is on the grid in 2026 | Name the 11 teams and explain works versus customer teams. | constructor, works-team, customer-team, engine-supplier | term-match x2; multiple-choice x3; fill-the-gap x1 |
| `rw-03-friday-to-sunday` | Friday to Sunday | Put the parts of a race weekend in order and say what each is for. | race-weekend, practice, parc-ferme, qualifying | sequence-order x1; multiple-choice x3; fill-the-gap x1 |
| `rw-04-qualifying-q1-q3` | Q1, Q2, Q3: the knockout | Explain how qualifying sets the grid and why pole matters. | qualifying, pole-position, starting-grid, track-evolution | multiple-choice x3; binary-call x2; fill-the-gap x1 |
| `rw-05-lights-out-to-chequered` | Lights out to chequered flag | Walk through a race from formation lap to the flag. | formation-lap, race-start, race-distance, chequered-flag | sequence-order x1; estimate-slider x1; multiple-choice x3 |
| `rw-06-points-and-titles` | Points, podiums and the two titles | Score a race and explain how both championships work. | points-system, podium, drivers-championship, constructors-championship, fastest-lap | estimate-slider x1; multiple-choice x3; fill-the-gap x2 |
| `rw-07-sprint-weekends` | Sprint weekends | Explain how a sprint weekend differs and what a sprint is worth. | sprint, points-system, qualifying | sequence-order x1; binary-call x2; multiple-choice x2 |
| `rw-08-first-sunday-text` | Your first Sunday text | Understand a fan's plain race-day message and reply naturally. | pole-position, dnf, podium, starting-grid | say-this x2; talk-track x1 |

#### Unit `flags-and-officials`: Flags, safety cars and who is in charge

Flags, neutralisations, stewards and the penalty menu.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `fc-01-the-flags` | The flags you will see | Recognise yellow, red, blue, black and chequered and what each demands. | yellow-flag, red-flag, blue-flag, black-flag, chequered-flag | visual-id x4; term-match x1; multiple-choice x2 |
| `fc-02-safety-car` | Why the safety car exists | Explain what a safety car does to the gaps and to the race. | safety-car, gap-and-interval, race-director | multiple-choice x3; binary-call x2 |
| `fc-03-vsc-vs-sc` | VSC or full safety car? | Tell the two apart and say which suits which incident. | virtual-safety-car, safety-car | binary-call x3; decision-scenario x1; multiple-choice x1 |
| `fc-04-red-flags` | Red flags and restarts | Explain what a red flag allows and how the race restarts. | red-flag, standing-restart, parc-ferme | sequence-order x1; multiple-choice x3 |
| `fc-05-stewards-and-penalties` | Stewards and the penalty menu | Match common infringements to typical penalties. | stewards, time-penalty, grid-penalty, penalty-points | term-match x2; multiple-choice x3; decision-scenario x1 |
| `fc-06-track-limits-and-releases` | Track limits and unsafe releases | Apply track limits and pit-release rules to simple cases. | track-limits, unsafe-release, blue-flag | binary-call x3; multiple-choice x2 |

#### Unit `car-and-circuit`: The car and the circuit

What an F1 car is, why downforce and drag trade off, and how drivers use a corner.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `ct-01-anatomy-of-a-car` | Anatomy of an F1 car | Locate the main parts: wings, floor, halo, power unit, tyres. | monocoque, halo, power-unit, downforce | hotspot-tap x3; term-match x2 |
| `ct-02-downforce-vs-drag` | Downforce versus drag | Explain why more wing means more grip but less top speed. | downforce, drag | multiple-choice x3; binary-call x2; estimate-slider x1 |
| `ct-03-circuit-personalities` | Monaco, Monza, Spa: circuit personalities | Sort tracks by what they demand: downforce, top speed or traction. | street-circuit, high-speed-corner, hairpin, kerbs | multiple-choice x3; term-match x1; binary-call x2 |
| `ct-04-the-racing-line` | The racing line | Show that the fastest path is the widest arc, not the shortest. | racing-line, apex | multiple-choice x2; unity-sim `f1.racecraft.racing-line.v1` (difficulty 1) |
| `ct-05-brake-turn-throttle` | Brake, turn, throttle | Describe the three phases of a corner and where speed is won. | braking-zone, trail-braking, traction, racing-line | sequence-order x1; multiple-choice x3; unity-sim `f1.racecraft.racing-line.v1` (difficulty 2) |
| `ct-06-understeer-oversteer` | Understeer and oversteer | Identify each from a description and say what drivers do about it. | understeer, oversteer, traction | hotspot-tap x2; binary-call x3; multiple-choice x2 |
| `ct-07-timing-screens` | Reading the timing screen | Read sectors, gaps, intervals and the purple, green and yellow times. | sector, gap-and-interval | multiple-choice x3; fill-the-gap x2; estimate-slider x1 |
| `ct-08-drs-farewell` | DRS: what it was and why it went | Explain the old overtaking flap and why it was replaced. | drs, slipstream, dirty-air | multiple-choice x3; binary-call x2 |

#### Unit `tyres-and-pit-stops`: Tyres and pit stops

Compounds, degradation, the stop, and the first idea of strategy.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `tp-01-why-tyres-decide-races` | Why tyres decide races | Explain that tyres are the main performance variable in a race. | tyre-degradation, tyre-management | multiple-choice x3; estimate-slider x2 |
| `tp-02-hard-medium-soft` | Hard, Medium, Soft | Read the sidewall colours and the trade-off between grip and life. | hard-medium-soft, pirelli-compounds | visual-id x3; term-match x1; multiple-choice x2 |
| `tp-03-inters-and-wets` | Intermediates and full wets | Choose the right wet tyre for a given track condition. | intermediate-tyre, full-wet-tyre, crossover-point | decision-scenario x2; binary-call x3; multiple-choice x1 |
| `tp-04-how-tyres-die` | Degradation, graining, blistering and the cliff | Name the four ways a tyre loses grip and what each looks like. | tyre-degradation, graining, blistering, tyre-cliff | term-match x2; multiple-choice x3; estimate-slider x1 |
| `tp-05-the-pit-stop` | Anatomy of a pit stop | Order the steps of a stop and explain what makes it fast or slow. | pit-stop, pit-loss, box-box, unsafe-release | sequence-order x1; timing-tap x1; estimate-slider x1; multiple-choice x2 |
| `tp-06-two-compound-rule` | The two-compound rule | Explain why every dry race has at least one stop. | two-compound-rule, one-stop-strategy, stint | multiple-choice x3; binary-call x2; decision-scenario x1 |
| `tp-07-undercut-overcut-intro` | Undercut and overcut: first taste | Predict who comes out ahead after a rival stops. | undercut, overcut, track-position, pit-loss | multiple-choice x2; decision-scenario x1; unity-sim `f1.strategy.pit-window.v1` (difficulty 1) |
| `tp-08-the-pit-wall-call` | Reading a pit wall call | Decode a pit call and the trade-offs behind it. | box-box, pit-window, stint, track-position | say-this x2; unity-sim `f1.strategy.pit-window.v1` (difficulty 2) |

#### Unit `the-2026-reset`: The 2026 reset

The new cars: active aero, the 50/50 power unit, Overtake Mode and the new teams.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `r26-01-why-a-reset` | Why F1 reset the rules | Explain what a regulation era is and what 2026 was meant to change. | regulation-era, cost-cap, sustainable-fuel | multiple-choice x3; say-this x1 |
| `r26-02-smaller-lighter-cars` | Smaller, lighter, narrower cars | Describe how the 2026 cars differ in size, weight and downforce. | minimum-weight, downforce, ground-effect | estimate-slider x1; multiple-choice x3; binary-call x2 |
| `r26-03-the-5050-power-unit` | The 50/50 power unit | Explain what the power unit is made of now and what disappeared. | power-unit, ice, mgu-k, energy-store, mgu-h | term-match x2; hotspot-tap x2; multiple-choice x2 |
| `r26-04-straight-and-corner-mode` | Straight Mode and Corner Mode | Explain how active aero works and how it differs from DRS. | active-aero, straight-mode, corner-mode, drs | multiple-choice x3; binary-call x2; unity-sim `f1.aero.active-modes.v1` (difficulty 1) |
| `r26-05-overtake-mode-and-boost` | Overtake Mode and Boost | Explain who gets Overtake Mode and how Boost differs. | overtake-mode, boost-button, gap-and-interval | multiple-choice x3; binary-call x3; decision-scenario x1 |
| `r26-06-recharging` | Recharging: where the energy comes from | Say where a car harvests energy and what it costs. | recharge, super-clipping, lift-and-coast, energy-store | multiple-choice x3; term-match x1; unity-sim `f1.energy.deploy-harvest.v1` (difficulty 1) |
| `r26-07-sustainable-fuel` | Sustainable fuel | Explain what sustainable fuel is and what it changes for fans. | sustainable-fuel, ice | multiple-choice x3; fill-the-gap x2 |
| `r26-08-who-is-new` | Audi, Cadillac, Ford, Honda: who is new | Identify the new teams and engine partnerships. | engine-supplier, works-team, customer-team, constructor | term-match x2; multiple-choice x3; fill-the-gap x1 |

### Layer: Intermediate

| Unit id | Unit title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `racecraft` | Racecraft: how passing really works | `car-and-circuit`, `the-2026-reset` | 7: Dirty air; The tow; The braking-zone duel; Defending without a penalty; Passing without DRS; Lapped cars and blue flags; The start and turn one | active-aero, blue-flag, braking-zone, defending-position, dirty-air, dive-bomb, downforce, drag, gap-and-interval, mgu-h... |
| `strategy-desk` | The strategy desk | `tyres-and-pit-stops`, `flags-and-officials` | 8: Stints and pit windows; The undercut in detail; Managing tyres and lifting off; Safety car: the free stop; Safety car: pit or stay out?; Offset strategies; Weather and the crossover; From qualifying to race plan | crossover-point, double-stack, full-wet-tyre, hard-medium-soft, intermediate-tyre, lift-and-coast, offset-strategy, one-stop-strategy, overcut, pit-loss... |
| `energy-and-aero-2026` | Energy, aero and performance in 2026 | `the-2026-reset` | 8: Energy across a lap; Clipping and super-clipping; When to open the wings; One lap on the battery; Who has the best power unit; Aero development and the tunnel time scale; The cost cap and how teams spend; Reading pace from practice | aduo, aero-testing-restrictions, boost-button, compression-ratio, corner-mode, cost-cap, downforce, drag, energy-store, engine-supplier... |
| `the-paddock` | The paddock: who does what | `race-weekend-101` | 5: Who runs a team; Reading team radio; Teammates and team orders; The driver pipeline; Silly season, tifosi and the Netflix effect | box-box, drive-to-survive, driver-market, feeder-series, junior-programme, lift-and-coast, paddock, pit-wall, race-engineer, reserve-driver... |

#### Unit `racecraft`: Racecraft: how passing really works

Dirty air, the tow, braking duels and defending.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `rc-01-dirty-air` | Dirty air | Explain why a following car loses grip and overheats its tyres. | dirty-air, downforce, tyre-degradation | multiple-choice x2; binary-call x3; unity-sim `f1.racecraft.slipstream-pass.v1` (difficulty 1) |
| `rc-02-the-tow` | The tow | Use the slipstream to gain speed and time the move. | slipstream, drag, gap-and-interval | multiple-choice x2; unity-sim `f1.racecraft.slipstream-pass.v1` (difficulty 2) |
| `rc-03-braking-duels` | The braking-zone duel | Choose a sensible place and line to attack a braking zone. | braking-zone, dive-bomb, defending-position | decision-scenario x2; binary-call x2; unity-sim `f1.racecraft.slipstream-pass.v1` (difficulty 3) |
| `rc-04-defending` | Defending without a penalty | Apply the rules about moving under braking and leaving room. | defending-position, stewards, time-penalty | decision-scenario x2; binary-call x3; multiple-choice x1 |
| `rc-05-passing-without-drs` | Passing without DRS | Explain how tow, Overtake Mode and wake combine to enable a pass. | overtake-mode, slipstream, active-aero, dirty-air | multiple-choice x3; unity-sim `f1.racecraft.slipstream-pass.v1` (difficulty 4) |
| `rc-06-lapped-traffic` | Lapped cars and blue flags | Explain how traffic affects the leader and what the flags demand. | blue-flag, track-position, gap-and-interval | binary-call x3; multiple-choice x2 |
| `rc-07-the-start` | The start and turn one | Explain how starts are won and lost, including in 2026. | race-start, mgu-h, mgu-k, traction | timing-tap x1; multiple-choice x3; binary-call x2 |

#### Unit `strategy-desk`: The strategy desk

Undercuts, safety-car calls, offsets and reading the race as a strategist.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `sd-01-stints-and-windows` | Stints and pit windows | Build a two-stint plan and find its pit window. | stint, pit-window, one-stop-strategy, tyre-degradation | multiple-choice x2; unity-sim `f1.strategy.pit-window.v1` (difficulty 2) |
| `sd-02-undercut-deep` | The undercut in detail | Predict when an undercut works and when it fails. | undercut, overcut, pit-loss, track-position | binary-call x3; unity-sim `f1.strategy.pit-window.v1` (difficulty 3) |
| `sd-03-tyre-management` | Managing tyres and lifting off | Explain lift and coast and tyre saving as a strategy. | tyre-management, lift-and-coast, tyre-degradation | estimate-slider x2; decision-scenario x2; multiple-choice x1 |
| `sd-04-safety-car-stops` | Safety car: the free stop | Explain why a stop under the safety car is cheap. | safety-car-stop, safety-car, pit-loss, double-stack | multiple-choice x2; unity-sim `f1.strategy.safety-car-call.v1` (difficulty 1) |
| `sd-05-safety-car-calls` | Safety car: pit or stay out? | Make the call in messy situations and defend it. | safety-car-stop, virtual-safety-car, double-stack, track-position | decision-scenario x2; unity-sim `f1.strategy.safety-car-call.v1` (difficulty 3) |
| `sd-06-offset-strategies` | Offset strategies | Explain why teams start on different tyres. | offset-strategy, pit-window, hard-medium-soft | decision-scenario x2; multiple-choice x2 |
| `sd-07-weather-strategy` | Weather and the crossover | Decide when to switch tyres as a track dries. | crossover-point, intermediate-tyre, full-wet-tyre | decision-scenario x3; estimate-slider x1; multiple-choice x1 |
| `sd-08-qualifying-and-race-plans` | From qualifying to race plan | Explain how track evolution and grid slot shape the plan. | track-evolution, starting-grid, offset-strategy | decision-scenario x2; multiple-choice x2; unity-sim `f1.strategy.pit-window.v1` (difficulty 4) |

#### Unit `energy-and-aero-2026`: Energy, aero and performance in 2026

Where the battery gives lap time, when the wings open, and how teams develop the car.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `ce-01-energy-across-a-lap` | Energy across a lap | Explain where a car deploys and where it harvests. | recharge, boost-button, energy-store, mgu-k | multiple-choice x2; unity-sim `f1.energy.deploy-harvest.v1` (difficulty 2) |
| `ce-02-clipping` | Clipping and super-clipping | Explain why a car slows at the end of a straight and what teams do about it. | super-clipping, energy-store, lift-and-coast | multiple-choice x2; unity-sim `f1.energy.deploy-harvest.v1` (difficulty 3) |
| `ce-03-when-to-open-the-wings` | When to open the wings | Decide when to hold Straight Mode and when to close it. | straight-mode, corner-mode, drag, downforce | binary-call x2; unity-sim `f1.aero.active-modes.v1` (difficulty 3) |
| `ce-04-one-lap-on-the-battery` | One lap on the battery | Explain qualifying energy limits and how they shape a lap. | recharge, qualifying, super-clipping | decision-scenario x2; unity-sim `f1.energy.deploy-harvest.v1` (difficulty 4) |
| `ce-05-power-unit-politics` | Who has the best power unit | Explain homologation-style upgrades and the ADUO safety net. | aduo, engine-supplier, pu-allocation, compression-ratio | multiple-choice x3; term-match x1 |
| `ce-06-aero-development` | Aero development and the tunnel time scale | Explain ATR, flexi-wings and technical directives. | aero-testing-restrictions, flexi-wing, technical-directive | multiple-choice x3; term-match x1 |
| `ce-07-the-cost-cap` | The cost cap and how teams spend | Explain the cap and why it matters to competitiveness. | cost-cap, regulation-era | multiple-choice x3; estimate-slider x1 |
| `ce-08-reading-pace` | Reading pace from practice | Tell one-lap pace from race pace and spot sandbagging. | race-pace-vs-quali-pace, long-run, sandbagging | decision-scenario x2; multiple-choice x2 |

#### Unit `the-paddock`: The paddock: who does what

Team roles, radio, teammates, the driver pipeline and the media world.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `pd-01-who-runs-a-team` | Who runs a team | Explain what the principal, engineer and strategist each do. | team-principal, race-engineer, pit-wall | term-match x2; multiple-choice x3 |
| `pd-02-reading-team-radio` | Reading team radio | Decode common radio messages and what is really being said. | team-radio, box-box, lift-and-coast | say-this x3; multiple-choice x1 |
| `pd-03-teammates-and-orders` | Teammates and team orders | Explain why the teammate is the true benchmark and when orders are used. | teammate-battle, team-orders | multiple-choice x3; decision-scenario x1; say-this x1 |
| `pd-04-the-driver-pipeline` | The driver pipeline | Explain F3, F2, super licences, junior programmes and reserves. | feeder-series, super-licence, junior-programme, reserve-driver | term-match x2; multiple-choice x3 |
| `pd-05-silly-season-and-fandom` | Silly season, tifosi and the Netflix effect | Explain the driver market and how fandom works. | driver-market, tifosi, drive-to-survive, paddock | say-this x3; multiple-choice x2 |

### Layer: Enthusiast depth

| Unit id | Unit title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `enthusiast-debates` | What fans actually argue about | `strategy-desk`, `energy-and-aero-2026` | 7: How much is the car?; Quali specialist or race-day driver?; Do the 2026 rules make better racing?; The engine row and the compression ratio; Are the stewards consistent?; Cost-cap drama; Too many races? The calendar argument | active-aero, aduo, aero-testing-restrictions, compression-ratio, cost-cap, grand-prix, ground-effect, overtake-mode, penalty-points, porpoising... |
| `history-and-lore` | History and lore | `race-weekend-101` | 7: The champions and their counts; Senna and Prost; Schumacher and the Ferrari years; Hamilton versus Verstappen; Iconic circuits; How F1 got safer; How to watch a race together | constructor, constructors-championship, drivers-championship, gap-and-interval, halo, high-speed-corner, monocoque, pit-stop, red-flag, safety-car... |
| `team-story` | Your team's story | `the-paddock` | 6: {{team}}: who they are; {{team}}: eras and rivalries; {{team}}'s car and power unit now; {{driver}} and {{team}}'s line-up; How {{team}} fans talk; Good questions to ask a {{team}} fan | aduo, constructor, constructors-championship, customer-team, driver-market, engine-supplier, power-unit, race-engineer, regulation-era, team-orders... |

#### Unit `enthusiast-debates`: What fans actually argue about

Car versus driver, rule politics, stewarding, sprints and the calendar.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `ed-01-car-versus-driver` | How much is the car? | Explain why the teammate battle is the fair test. | teammate-battle, race-pace-vs-quali-pace | say-this x3; decision-scenario x1 |
| `ed-02-one-lap-versus-race-day` | Quali specialist or race-day driver? | Discuss why some drivers are quicker over one lap than a stint. | race-pace-vs-quali-pace, tyre-management, trail-braking | say-this x3; multiple-choice x2 |
| `ed-03-better-racing` | Do the 2026 rules make better racing? | Give both sides of the active aero and energy debate. | active-aero, overtake-mode, super-clipping, ground-effect, porpoising | say-this x3; decision-scenario x1; talk-track x1 |
| `ed-04-engine-row` | The engine row and the compression ratio | Explain why the compression ratio dispute mattered. | compression-ratio, aduo, technical-directive | say-this x3; multiple-choice x2 |
| `ed-05-stewarding-consistency` | Are the stewards consistent? | Explain why penalty consistency is a perennial fan argument. | stewards, penalty-points, time-penalty | say-this x3; decision-scenario x2 |
| `ed-06-cost-cap-drama` | Cost-cap drama | Explain the cost-cap breach saga and what penalties fit. | cost-cap, aero-testing-restrictions | say-this x2; multiple-choice x2 |
| `ed-07-calendar-politics` | Too many races? The calendar argument | Discuss classics versus new venues and the 2026 calendar changes. | grand-prix, street-circuit, sprint | say-this x3; multiple-choice x2 |

#### Unit `history-and-lore`: History and lore

Legends, rivalries, safety milestones and why certain places matter.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `hl-01-champions-and-counts` | The champions and their counts | Place Fangio, Schumacher, Hamilton, Verstappen and the 2025 champion. | drivers-championship, constructors-championship | multiple-choice x4; term-match x1 |
| `hl-02-senna-and-prost` | Senna and Prost | Explain why the rivalry is F1's defining story. | teammate-battle, team-orders | multiple-choice x3; say-this x2 |
| `hl-03-schumacher-and-ferrari` | Schumacher and the Ferrari years | Explain why Ferrari's 2000s dominance still shapes fans. | tifosi, constructor, works-team | multiple-choice x3; say-this x2 |
| `hl-04-hamilton-and-verstappen` | Hamilton versus Verstappen | Explain the 2021 finale and why people still argue. | safety-car, stewards, drivers-championship | multiple-choice x3; say-this x2 |
| `hl-05-iconic-circuits` | Iconic circuits | Match legendary circuits to what makes them special. | street-circuit, high-speed-corner, triple-crown | term-match x2; multiple-choice x3 |
| `hl-06-how-f1-got-safer` | How F1 got safer | Explain milestones like the halo and modern crash structures. | halo, monocoque, red-flag | multiple-choice x3; say-this x1 |
| `hl-07-how-to-watch-together` | How to watch a race together | Plan a watch-party and follow the race without over-asking. | gap-and-interval, safety-car, pit-stop | decision-scenario x2; say-this x2; talk-track x1 |

#### Unit `team-story`: Your team's story

Personalized: your person's team, drivers, eras and how their fans talk.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `yt-01-team-identity` | {{team}}: who they are | Say what {{team}} is known for, in one honest sentence. | constructor, works-team, customer-team | multiple-choice x3; say-this x1 |
| `yt-02-team-eras` | {{team}}: eras and rivalries | Place {{team}}'s peaks and slumps and who they fight. | constructors-championship, regulation-era | multiple-choice x3; say-this x2 |
| `yt-03-team-car-now` | {{team}}'s car and power unit now | Explain {{team}}'s 2026 power unit and what it means. | engine-supplier, power-unit, aduo | multiple-choice x3; term-match x1 |
| `yt-04-team-drivers` | {{driver}} and {{team}}'s line-up | Know your person's driver, their teammate and the story between them. | teammate-battle, team-orders | multiple-choice x3; say-this x2 |
| `yt-05-team-fans` | How {{team}} fans talk | Recognise fan in-jokes and pet peeves without faking it. | tifosi, team-radio, driver-market | say-this x3; talk-track x1 |
| `yt-06-team-questions` | Good questions to ask a {{team}} fan | Ask three follow-ups that show you have been listening. | team-principal, race-engineer | say-this x2; talk-track x2 |

### Layer: Current-season / live layer

| Unit id | Unit title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `season-live` | This season, live | `race-weekend-101`, `tyres-and-pit-stops` | 8: This weekend: what to watch; Last race in plain English; The championship picture; {{driver}} this season; {{team}} this season; The 2026 rules, still in motion; Silly season: who is moving; Circuit primer: {{region}} and the next race | aduo, compression-ratio, constructors-championship, driver-market, drivers-championship, hard-medium-soft, junior-programme, pit-window, points-system, race-pace-vs-quali-pace... |

#### Unit `season-live`: This season, live

Weekly templates driven by live data and editorial: preview, recap, title picture, your driver and team.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `sl-01-this-weekend-preview` | This weekend: what to watch | Read a preview: circuit type, tyre picks and what matters. | hard-medium-soft, street-circuit, sprint | multiple-choice x3; decision-scenario x1; say-this x1 |
| `sl-02-last-race-decoded` | Last race in plain English | Decode last race's result, strategy and controversies. | undercut, safety-car-stop, time-penalty | multiple-choice x3; say-this x2 |
| `sl-03-the-title-picture` | The championship picture | Read standings and work out who can still win the title. | title-permutations, drivers-championship, points-system | estimate-slider x1; multiple-choice x3; say-this x1 |
| `sl-04-your-driver-now` | {{driver}} this season | Explain how {{driver}} is doing and why. | teammate-battle, race-pace-vs-quali-pace | multiple-choice x3; say-this x2 |
| `sl-05-your-team-now` | {{team}} this season | Explain {{team}}'s form and what to watch. | constructors-championship, reliability | multiple-choice x3; say-this x2 |
| `sl-06-rules-in-play` | The 2026 rules, still in motion | Follow the mid-season tweaks and why teams argue. | technical-directive, aduo, compression-ratio | multiple-choice x3; say-this x2 |
| `sl-07-silly-season-now` | Silly season: who is moving | Follow the driver-market stories this month. | driver-market, junior-programme, super-licence | say-this x3; multiple-choice x2 |
| `sl-08-next-circuit` | Circuit primer: {{region}} and the next race | Prepare for the next track: layout, personality and likely strategy. | street-circuit, pit-window, track-evolution | hotspot-tap x2; decision-scenario x1; multiple-choice x2 |

### Layer: Conversation practice

| Unit id | Unit title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `paddock-talk` | Paddock talk | `race-weekend-101` | 8: Sunday morning texts; After the race: joy and pain; Qualifying-day chat; Why didn't they pit?; That penalty was a joke; Talking about the 2026 cars; Driver loyalty and banter; The watch party | active-aero, dnf, driver-market, gap-and-interval, grid-penalty, overtake-mode, penalty-points, pit-stop, pit-window, podium... |

#### Unit `paddock-talk`: Paddock talk

Conversation practice: decoding and joining real fan chatter.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `pt-01-sunday-morning` | Sunday morning texts | Reply to pre-race chatter with genuine questions. | starting-grid, pole-position, race-start | talk-track x3; say-this x2 |
| `pt-02-after-the-race` | After the race: joy and pain | Respond to a celebration or a heartbreak well. | podium, dnf, safety-car | talk-track x3; say-this x2 |
| `pt-03-quali-day` | Qualifying-day chat | Talk about pole, penalties and one-lap pace. | qualifying, grid-penalty, race-pace-vs-quali-pace | talk-track x3; say-this x2 |
| `pt-04-strategy-gripes` | Why didn't they pit? | Talk through strategy complaints without pretending. | undercut, pit-window, track-position | talk-track x3; say-this x2 |
| `pt-05-rules-rage` | That penalty was a joke | Handle a rules rant with empathy and one good question. | stewards, time-penalty, penalty-points | talk-track x3; say-this x2 |
| `pt-06-the-new-cars` | Talking about the 2026 cars | Discuss active aero and energy management with curiosity. | active-aero, overtake-mode, super-clipping | talk-track x3; say-this x2 |
| `pt-07-driver-loyalty` | Driver loyalty and banter | Enjoy a friendly rivalry without starting a fight. | teammate-battle, driver-market | talk-track x3; say-this x2 |
| `pt-08-watch-party` | The watch party | Host or join a watch-along and ask the right things at the right time. | safety-car, gap-and-interval, pit-stop | talk-track x3; say-this x2 |

### Layer: Perpetual review

| Unit id | Unit title | Prerequisites | Lessons | Main concepts |
|---|---|---|---|---|
| `perpetual-review` | Perpetual review | `race-weekend-101` | 4: Daily Bite; Weekend recap review; Term retrieval mix; Say-this refresher | active-aero, constructor, downforce, overtake-mode, pit-window, points-system, power-unit, safety-car, safety-car-stop, slipstream... |

#### Unit `perpetual-review`: Perpetual review

Spaced retrieval of mastered concepts across the whole course.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `rv-01-daily-bite` | Daily Bite | Retrieve five due concepts in about two minutes. | points-system, undercut, downforce, safety-car, active-aero | multiple-choice x3; fill-the-gap x1; say-this x1 |
| `rv-02-weekend-recap` | Weekend recap review | Refresh the concepts that appeared in the latest race. | safety-car-stop, tyre-degradation, time-penalty | multiple-choice x3; fill-the-gap x1; say-this x1 |
| `rv-03-term-retrieval` | Term retrieval mix | Match and complete terms from every layer, weakest first. | constructor, power-unit, pit-window, slipstream | term-match x2; fill-the-gap x2; multiple-choice x2 |
| `rv-04-say-this-refresher` | Say-this refresher | Decode fan lines you have already met, in new wording. | overtake-mode, track-limits, stint | say-this x4; talk-track x1 |


**Personalization slots:** `team`, `driver`, `region` (see section 8).

**Review policy:** `leitner-boxes-v1`. Boxes at 1, 3, 7, 14, 30 days; a concept is due when its box interval elapses; a wrong answer returns it to box 1; maximum 12 items per Daily Bite; weakest and most recently seen concepts first; concepts touched by the last race weekend get a boost; `reviewEligible` true for every activity except talk-track and sims (sim outcomes feed mastery only).

**Release plan:**
- **Launch (v0.1.0):** units 1 to 9, 14 (conversation), 15 (review) fully authored; unit 10 debates (all seven); unit 11 history (all seven); unit 12 team-story with data for the four flagship teams and generic content for the rest; unit 13 live templates with the 2026 data adapter; six sims.
- **Weekly after launch:** the live unit's templates re-instantiate each race weekend (preview on Thursday, recap on Monday); 8 to 10 new say-this items and 2 talk tracks per weekend.
- **Per season:** a new-season reset unit (like `the-2026-reset`) when the rules or line-ups change; a season-in-review unit in December.
- **Mid-season regulation changes:** patch `sl-06` and `ce-*` lessons using the editorial flow rather than rewriting lessons.

## 12. Interaction plan
Justifies each activity family. Estimated counts come from the Curriculum map (lesson-embedded items; talk-track count excludes the 30 standalone Talk-tab tracks).

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Racing-line reading (`ct-04`, `ct-05`) | racing-line, apex, braking-zone, trail-braking, traction | `unity-sim` `f1.racecraft.racing-line.v1` | Rubric: spatial reasoning and physics. The learner shapes a path through real corner geometry and sees speed, wheel-on-kerb and lap time change. A native hotspot-tap on a static diagram shows where the apex is but not why a wide entry keeps speed up. Spec: `sims/f1.racecraft.racing-line.v1.md` | A | 2 sessions |
| Tow, dirty air and braking duels (`rc-01`, `rc-02`, `rc-03`, `rc-05`) | slipstream, dirty-air, drag, braking-zone, dive-bomb, overtake-mode | `unity-sim` `f1.racecraft.slipstream-pass.v1` | Rubric: movement over time and physics (wake). The tow is a positional effect: distance and alignment change drag frame by frame; pulling out too early or late is a timing decision inside a moving scene. A native binary-call cannot show speed accumulating. Spec: `sims/f1.racecraft.slipstream-pass.v1.md` | A | 4 sessions |
| Active-aero wing modes (`r26-04`, `ce-03`) | active-aero, straight-mode, corner-mode, drag, downforce | `unity-sim` `f1.aero.active-modes.v1` | Rubric: timing in a scene plus physics. Opening the wings must be timed to straights and closed before braking; the cost of a mistake (grip loss or wasted speed) is felt. A native timing-tap is a 1D bar with no track context; a diagram cannot show mode timing against track geometry. Spec: `sims/f1.aero.active-modes.v1.md` | A | 2 sessions |
| Energy deploy and harvest (`r26-06`, `ce-01`, `ce-02`, `ce-04`) | recharge, boost-button, super-clipping, energy-store, lift-and-coast | `unity-sim` `f1.energy.deploy-harvest.v1` | Rubric: physics and timing in a scene. The 2026 concept is that the battery is finite and where you spend it matters; clipping is only intuitive when you watch the car stop accelerating at the end of a straight. A native estimate-slider or sequence-order can list the rule but not produce the felt trade-off. Spec: `sims/f1.energy.deploy-harvest.v1.md` | A | 4 sessions |
| Pit window and undercut (`tp-07`, `tp-08`, `sd-01`, `sd-02`, `sd-08`) | undercut, overcut, pit-window, pit-loss, tyre-degradation, track-position | `unity-sim` `f1.strategy.pit-window.v1` | Rubric: a decision depends on reading a dynamic scene: gaps, tyre bars and traffic evolve lap by lap and the outcome (rejoining ahead or in traffic) appears only when the race plays forward. A native decision-scenario with a static fact sheet is used for the simpler judgment lessons; the sim is used where the dynamics of the gap are the concept. Spec: `sims/f1.strategy.pit-window.v1.md` | A | 5 sessions |
| Safety car call (`sd-04`, `sd-05`) | safety-car-stop, virtual-safety-car, double-stack, safety-car, track-position | `unity-sim` `f1.strategy.safety-car-call.v1` | Rubric: dynamic scene decision under time pressure: the field bunching is spatial and the consequence (rejoin position) depends on where everyone is. A decision-scenario teaches the rule that "stops are cheap"; the sim teaches the feel of a double-stack and the cost of a wrong call. Spec: `sims/f1.strategy.safety-car-call.v1.md` | A | 2 sessions |
| Weekend/flag ordering | race-weekend, practice, qualifying, formation-lap | `sequence-order` | Order is the concept; a list is enough. | B | 6 |
| Flags, sidewalls, car parts | yellow-flag, blue-flag, hard-medium-soft, tyres | `visual-id` | Recognition is the skill. Procedural original artwork only (licence `swoond-original`). | B | 7 |
| Anatomy, circuit maps, next-circuit primer | monocoque, downforce, understeer, oversteer | `hotspot-tap` | Static diagrams where nothing moves. If cars move, it goes to Unity. | B | 9 |
| Rule in a situation (VSC or SC, track limits, defending, 2026 modes) | safety-car, track-limits, defending-position, overtake-mode | `binary-call` | A clear two-way judgment, best shown on a diagram; not spatially dynamic. | B | 51 |
| Terms and roles | constructor, works-team, stewards, penalty-points | `term-match` | Introducing 3 to 6 terms per lesson. | B | 29 |
| Recall and understanding | most foundation and intermediate concepts | `multiple-choice` | Default check and review card. | B | 211 |
| Terms in context | power-unit, pit-loss, penalty-points | `fill-the-gap` | Vocabulary in a sentence. | B | 14 |
| Magnitudes | race-distance, points-system, minimum-weight, pit-stop | `estimate-slider` | Build feel for numbers (305 km, 768 kg, 2 s stops, 25 points). | B | 14 |
| Strategy and rules judgment | pit-window, safety-car-stop, crossover-point, stewards | `decision-scenario` | A fact sheet (gap, tyre age, weather) and a graded choice teaches judgment where a sim would be overkill. Best/acceptable/poor with an expert note. | B | 35 |
| Pit stop reflex | pit-stop | `timing-tap` | A 1D timing bar per D-002 (the design file's Pit Stop); no scene needed. | B | 2 |
| Decoding fan lines | mixed | `say-this` | The core social skill: interpret, then ask a follow-up. | B | 87 |
| Conversation practice | mixed | `talk-track` | Chat with a Smooth meter; every layer. | B | 31 (+30 standalone) |
| Hearing the sport | n/a | `listening-id` | Not used: audio rights (FOM); would need original audio. | n/a | 0 |

Native items link to types in `docs/native-exercises/CATALOG.md`. Total Tier A sessions in the curriculum: 19 (about 18% of lessons include a sim), all in intermediate-heavy or foundation-anchor lessons where movement or physics is the point.

## 13. Licensing & safety
| Area | Handling |
|---|---|
| Logos and trademarks | F1, Formula 1, Grand Prix wordmarks and logos (Formula One Group / FOM), team logos and liveries (each team), FIA and Pirelli logos are not used. Team, driver and circuit names appear as plain text (nominative use). The app shows a footer "Swoon'd is not affiliated with Formula 1, the FIA or any team." Team personalisation uses a neutral accent ring, not team liveries. |
| Imagery | No press photos (Getty, LAT, Formula 1 Media) or team photos. All flags, tyre sidewalls, car parts, circuit maps and car silhouettes are original procedural art (licence id `swoond-original`). Circuits are drawn as stylised outlines; no official track-map artwork copied. |
| Player likeness | No driver photos, caricatures of real people or signatures at launch. Numbers and initials only. If licensed likeness is later obtained it comes under a separate deal. |
| Audio and video | No race audio, team-radio recordings, broadcast clips or onboards (FOM rights). Radio lines are paraphrased or quoted briefly as text for teaching and marked "paraphrased". `listening-id` unused. |
| Article text | Publisher text never copied; explain and link (spec section 11). |
| Data providers | Jolpica-F1 data is CC BY-NC-SA 4.0 (non-commercial; commercial use requires permission). OpenF1 is licensed for educational, research and non-commercial fan use with paid real-time; commercial use requires arrangement. Neither may be used in production until licensing is agreed; see `live-data.md`. No unofficial or reverse-engineered live-timing endpoints (F1 livetiming, FastF1 scraping) in production. |
| Safety | No physical-safety risk to learners. Editorial handling of fatal accidents and serious injuries must be respectful and non-interactive; no crash reconstruction or gore; no gambling, betting odds or wagering content; keep start-light animations and flashing effects photosensitivity-safe (no strobing above 3 Hz; Reduce Motion honoured). |

## 14. Content assets
- Procedural diagrams (native `diagramId`s): `f1-car-topdown`, `f1-car-side`, `f1-wing-modes`, `f1-pit-lane`, `f1-flag-*` (yellow, double-yellow, red, blue, black, black-white, chequered), `f1-tyre-sidewalls`, `f1-track-*` circuit outlines (about 24 for the calendar); all `swoond-original`.
- Unity procedural environments: `f1_corner_track`, `f1_straight_and_braking`, `f1_lap_oval_abstract`, `f1_pit_road`, `f1_race_topdown`. Vehicles are stylised low-poly cars with numbers and neutral colours (no livery).
- Fonts and design tokens per `docs/design/DESIGN_SPEC.md`.
- Sim copy and exercise text are original.

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. What does a beginner need to understand? Sections 2, 3 (weekend and points, flags, downforce versus drag, tyres and the undercut, the 2026 changes).
- [x] 2. What do enthusiasts care about? Section 4 and units 10 to 12.
- [x] 3. What current information matters? Section 6, `live-data.md`: results, standings, calendar, line-ups, weather, rule news.
- [x] 4. What should be interactive? Section 12: six Unity sims for spatial/dynamic concepts; native exercises for the rest.
- [x] 5. What should NOT be gamified? Section 5.
- [x] 6. How should it personalize? Section 8: team, driver, region.
- [x] 7. What does conversational competence look like? Section 9 and unit 14.
- [x] 8. What data providers are needed? Section 6 and `live-data.md`.
- [x] 9. What licensing constraints apply? Section 13.
- [x] 10. How will Swoon'd measure useful understanding? Section 10.

Additional gates: [ ] manifest validates (see validator run below); [ ] curriculum validates (curriculum JSON not yet authored); [ ] every Unity sim has an approved spec (drafts written; product approval pending); [ ] every image/audio asset has a license id; [ ] voice review (cheeky coach, never mean, never about the crush); [ ] no copied publisher text.

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Data licensing: Swoon'd is commercial; Jolpica-F1 (CC BY-NC-SA) and OpenF1 (non-commercial) need permission or a paid plan. Choose Orange Cat Blacktop or another commercial provider? | Product | Blocking for live layer (not for evergreen units) |
| 2 | Verify per event: FIA rules on where Straight Mode may be activated (circuit-specific zones) and any low-grip restrictions; sim spec `f1.aero.active-modes.v1` models zones abstractly. | Content / Claude | No (re-verify before release) |
| 3 | Team likeness and neutral accent rings: acceptable to show team names with neutral tokens only? Needs legal read on team-name-plus-colour association. | Product / Legal | No |
| 4 | Talk-track voice for the "crush" lines: do we allow mild in-jokes about specific drivers (Kimi, Lewis) in text? | Product | No |
| 5 | Listening-id: commission original engine-note audio for an "era sounds" exercise? | Product | No |
| 6 | 2027 rule changes may alter active-aero and energy limits; plan a delta unit. | Content | No |
| 7 | Curriculum schema has no per-branch data or per-lesson `branchId`; see `NOTES_FOR_ORCHESTRATOR.md` for team-pack data proposal. | Orchestrator | No |
| 8 | Standalone Talk-tab talk tracks: 30 planned; who authors the voice-checked copy? | Content | No |

---

## Appendix A. Playbook concept registry (target for curriculum `concepts[]`)

Every `conceptId` in the Curriculum map exists here. `exercises.md` holds the full Playbook (definition plus example line in the crush's voice).

| conceptId | Term | Tier | Definition |
|---|---|---|---|
| `constructor` | Constructor | foundation | A team that builds its own car and scores points in the constructors' title. Ferrari, McLaren and Mercedes are constructors. |
| `grand-prix` | Grand Prix | foundation | One round of the world championship, run at one circuit over a full weekend. Around 23 a year. |
| `race-weekend` | Race weekend | foundation | The Friday-to-Sunday event: practice, qualifying, then the race. Sprint weekends compress this. |
| `practice` | Free practice | foundation | Friday running (FP1 to FP3 on normal weekends) where teams test set-ups and tyres. Nobody wins anything here. |
| `qualifying` | Qualifying | foundation | Saturday knockout session (Q1, Q2, Q3) that sets the starting order. The fastest single lap wins pole. |
| `pole-position` | Pole position | foundation | First place on the grid, earned by the fastest qualifying lap. Worth a lot at tight tracks like Monaco. |
| `starting-grid` | Starting grid | foundation | The order cars line up in for the start, set by qualifying (plus any penalties). |
| `parc-ferme` | Parc ferme | intermediate | The rules-lock on the cars once qualifying starts: teams can barely change the set-up before the race. |
| `formation-lap` | Formation lap | foundation | The warm-up lap before the start where drivers heat tyres and brakes and then line up on the grid. |
| `race-start` | The start | foundation | Lights-out standing start. Five red lights go out and the field launches; the first lap is chaos. |
| `race-distance` | Race distance | foundation | About 305 km per Grand Prix (Monaco is shorter), capped at two hours of running time. |
| `points-system` | Points system | foundation | Top ten score 25-18-15-12-10-8-6-4-2-1. There is no bonus point for fastest lap since 2025. |
| `drivers-championship` | Drivers' Championship | foundation | The individual title: most points over the season wins. What people mean by 'the championship'. |
| `constructors-championship` | Constructors' Championship | foundation | The team title: both drivers' points added together. Worth big prize money. |
| `sprint` | Sprint | foundation | A short Saturday race (about 100 km) on selected weekends, scoring points to the top eight (8-1). |
| `podium` | Podium | foundation | The top three finishers, who climb the podium and spray champagne. |
| `dnf` | DNF | foundation | Did Not Finish: retired from the race through a crash or a failure. Scores zero. |
| `fastest-lap` | Fastest lap | foundation | The quickest lap of the race. Bragging rights only: the bonus point was removed for 2025. |
| `reliability` | Reliability | intermediate | How likely parts are to survive. A fast, fragile car finishes fewer races and loses titles. |
| `yellow-flag` | Yellow flag | foundation | Danger ahead on the track: slow down, no overtaking in that sector. Double yellow means be ready to stop. |
| `red-flag` | Red flag | foundation | Session stopped, usually after a big crash or dangerous conditions. Cars return to the pits. |
| `blue-flag` | Blue flag | foundation | Tells a lapped driver to let a faster car through. Ignoring it earns a penalty. |
| `black-flag` | Black flag | intermediate | The harshest flag: disqualified from the race. A black-and-white flag is a warning for unsportsmanlike driving. |
| `chequered-flag` | Chequered flag | foundation | The chequered flag ends the race for each driver as they cross the line. |
| `safety-car` | Safety car | foundation | A pace car that leads the field at reduced speed after an incident. It bunches the pack and erases gaps. |
| `virtual-safety-car` | Virtual Safety Car (VSC) | intermediate | Everyone slows to a set delta time without a physical pace car. Gaps stay the same. |
| `standing-restart` | Standing restart | intermediate | After a red flag, the cars line up on the grid again for a fresh start. |
| `stewards` | Stewards | foundation | The officials who investigate incidents and hand out penalties during the weekend. |
| `race-director` | Race director | intermediate | The FIA official who controls the session: starts, safety cars, red flags and restarts. |
| `time-penalty` | Time penalty | foundation | Seconds added to a driver's race time, usually 5 or 10, for an infringement. Often served in the pits. |
| `grid-penalty` | Grid penalty | foundation | Places dropped at the next start, for example for taking extra engine parts. |
| `penalty-points` | Penalty points | intermediate | Licence points for dangerous driving: 12 within 12 months means a one-race ban. |
| `track-limits` | Track limits | foundation | White lines edge the track. All four wheels over them means an advantage, and lap times may be deleted. |
| `unsafe-release` | Unsafe release | intermediate | Leaving the pit box into the path of another car or with a wheel not secure. Usually a time penalty. |
| `drs` | DRS (retired) | foundation | The Drag Reduction System flap was the overtaking aid from 2011 to 2025. Replaced by 2026 active aero and Overtake Mode. |
| `power-unit` | Power unit | foundation | What F1 calls the engine: a turbocharged V6 plus electrical systems. Not just 'the engine'. |
| `monocoque` | Monocoque | intermediate | The carbon-fibre survival cell the driver sits in, with the engine bolted behind and the front suspension ahead. |
| `halo` | Halo | foundation | The titanium bar above the cockpit that protects the driver's head. Introduced 2018. |
| `downforce` | Downforce | foundation | Aerodynamic force pushing the car into the track, so it can corner faster. |
| `drag` | Drag | foundation | Air resistance that slows a car on the straights. Downforce brings drag as a side effect. |
| `ground-effect` | Ground effect | intermediate | Shaping the floor so air speeds up underneath, sucking the car down. The 2022 to 2025 cars relied on it heavily. |
| `porpoising` | Porpoising | enthusiast | Bouncing at speed when the underfloor stalls and reattaches. Was a big story in 2022. |
| `dirty-air` | Dirty air | foundation | The turbulent wake behind a car that steals the follower's downforce and makes it hard to follow closely. |
| `slipstream` | Slipstream (tow) | foundation | Driving in the wake of a car ahead cuts drag on the straight, giving extra top speed. Also called the tow. |
| `active-aero` | Active aero | foundation | New for 2026: front and rear wing elements that move to trade downforce for low drag during a lap. |
| `straight-mode` | Straight Mode (X-mode) | foundation | Low-drag wing setting for straights, allowed in circuit-specific zones. Fans call it X-mode. |
| `corner-mode` | Corner Mode (Z-mode) | foundation | High-downforce default wing setting for braking and corners. Fans call it Z-mode. |
| `overtake-mode` | Overtake Mode | foundation | 2026 electrical boost for a car within one second of the car ahead at a detection point. It replaced DRS. |
| `boost-button` | Boost | intermediate | A manual driver button for extra electrical deployment, limited in how much and how often it can be used. |
| `recharge` | Recharge (harvesting) | foundation | Refilling the battery from braking and from engine power, a lot of which is done on every lap. |
| `mgu-k` | MGU-K | intermediate | The motor-generator on the drivetrain: it recovers braking energy and adds up to 350 kW in 2026. |
| `mgu-h` | MGU-H (removed) | enthusiast | The heat-recovery motor on the turbo, dropped for 2026. Its absence brings back a bit of turbo lag. |
| `ice` | Combustion engine (ICE) | intermediate | The 1.6-litre turbo V6 part of the power unit, producing roughly 400 kW in 2026. |
| `energy-store` | Energy store (battery) | intermediate | The high-voltage battery that holds harvested energy for deployment, with strict per-lap limits. |
| `super-clipping` | Clipping | intermediate | When the battery is empty on a long straight the car stops accelerating and even slows as it harvests. Fans call it super clipping. |
| `lift-and-coast` | Lift and coast | intermediate | Lifting off the throttle early before braking to save fuel, tyres or recharge the battery. |
| `sustainable-fuel` | Sustainable fuel | foundation | 100% advanced sustainable fuel from 2026, made from non-food biomass, waste or captured carbon. |
| `minimum-weight` | Minimum weight | intermediate | The lightest a car and driver may be. It fell by around 30 kg for 2026 to 768 kg. |
| `cost-cap` | Cost cap | intermediate | A yearly limit on team spending, around 215 million dollars with big carve-outs. Breaches bring fines and sporting penalties. |
| `aero-testing-restrictions` | Aero testing restrictions | enthusiast | A sliding scale of wind-tunnel and CFD time: the worse a team finished last year, the more it gets. |
| `aduo` | ADUO | enthusiast | Additional Development and Upgrade Opportunities: extra engine upgrade chances for manufacturers that fall behind, assessed after rounds 6, 12 and 18. |
| `pu-allocation` | PU allocation | intermediate | Teams may use a limited number of each power-unit element per season; fitting extra means grid penalties. |
| `compression-ratio` | Compression ratio | enthusiast | How hard the engine squeezes its air-fuel mix. The 2026 row was about measuring it when the engine is hot as well as cold. |
| `flexi-wing` | Flexi-wing | enthusiast | A wing that bends under load to cut drag while passing static tests. A recurring loophole fight. |
| `technical-directive` | Technical directive | enthusiast | An FIA clarification to teams on how a rule will be policed, often used to close a loophole mid-season. |
| `regulation-era` | Regulation era | intermediate | A multi-year rulebook cycle. 2026 begins a new one, so the pecking order resets. |
| `racing-line` | Racing line | foundation | The fastest path through a corner: usually wide in, clip the apex, wide out to keep speed up. |
| `apex` | Apex | foundation | The point on the inside of a corner where the car passes closest to the kerb. |
| `braking-zone` | Braking zone | foundation | The place on a straight where drivers brake hard for a corner. The main overtaking spot. |
| `trail-braking` | Trail braking | enthusiast | Carrying some brake pressure into the corner to help the car rotate. |
| `understeer` | Understeer | foundation | The front tyres wash wide and the car will not turn in as much as asked. |
| `oversteer` | Oversteer | foundation | The rear steps out and the car turns more than asked, risking a spin. |
| `kerbs` | Kerbs | foundation | The painted ramps at corner edges. Drivers use them to straighten the line but may unsettle the car. |
| `street-circuit` | Street circuit | foundation | A track on closed public roads, like Monaco or Singapore. Tight, bumpy, walls close. |
| `high-speed-corner` | High-speed corner | intermediate | Corners taken flat or nearly flat, where downforce matters most, like Maggotts-Becketts at Silverstone. |
| `hairpin` | Hairpin | foundation | A slow, tight 180-degree corner, usually at the end of a straight and a good overtaking place. |
| `sector` | Sector | foundation | A third of the lap, timed separately. Purple, green and yellow sector times show who is quickest. |
| `gap-and-interval` | Gap and interval | foundation | Gap is the time to the leader; interval is the time to the car ahead. |
| `track-evolution` | Track evolution | intermediate | The track gets faster as rubber lays down and grip builds up during a weekend. |
| `dive-bomb` | Dive-bomb | enthusiast | A very late lunge down the inside under braking. Works if it sticks, causes penalties if not. |
| `defending-position` | Defending | intermediate | Covering the inside line to block a pass. Rules allow one move, and you cannot weave. |
| `traction` | Traction | intermediate | Grip on corner exit to put power down without wheelspin. |
| `pirelli-compounds` | Pirelli compounds (C1 to C5) | foundation | Pirelli supplies five dry compounds, C1 (hardest) to C5 (softest); three are brought to each race. |
| `hard-medium-soft` | Hard, Medium, Soft | foundation | The three compounds at a weekend, labelled white, yellow and red. Softest is fastest but wears first. |
| `intermediate-tyre` | Intermediate tyre | foundation | Green-sidewall tyre for a damp or drying track. Not for heavy rain. |
| `full-wet-tyre` | Full wet tyre | foundation | Blue-sidewall tyre for heavy rain and standing water. |
| `tyre-degradation` | Tyre degradation | foundation | Tyres lose grip and lap time as the stint goes on. Managing it is the core of race strategy. |
| `graining` | Graining | enthusiast | Tiny rubber balls tear off and roughen the surface, temporarily costing grip. |
| `blistering` | Blistering | enthusiast | Overheated rubber bubbles up, permanently damaging the tyre. |
| `tyre-cliff` | Tyre cliff | intermediate | The sudden collapse in grip when a tyre reaches the end of its life. |
| `tyre-management` | Tyre management | intermediate | Driving smoothly enough to make tyres last, sometimes at the cost of speed. |
| `two-compound-rule` | Two-compound rule | foundation | In a dry race, drivers must use at least two different compounds, which forces a stop. |
| `pit-stop` | Pit stop | foundation | The tyre change in the pit lane, in about two seconds of stationary time for a top crew. |
| `pit-window` | Pit window | intermediate | The range of laps in which a stop makes sense given tyre life and track position. |
| `pit-loss` | Pit loss | intermediate | The time lost by driving through the pit lane versus staying on track. About 20 seconds at most circuits. |
| `undercut` | Undercut | foundation | Pitting first to gain time on fresh tyres and jump ahead when the rival stops. |
| `overcut` | Overcut | intermediate | Staying out longer while the rival pits, then using clear air to be faster on old tyres. |
| `stint` | Stint | foundation | The stretch of a race on one set of tyres. |
| `track-position` | Track position | foundation | Where you run on the road. At tracks where passing is hard, it beats pace. |
| `one-stop-strategy` | One-stop | foundation | A race with a single pit stop. Faster if tyres last, but rivals may pounce. |
| `offset-strategy` | Offset strategy | enthusiast | Starting a race on a different tyre from rivals to open a different pit window. |
| `safety-car-stop` | Safety car stop | intermediate | Pitting under a safety car costs far less time because the field is slowed, so it feels 'free'. |
| `double-stack` | Double stack | intermediate | Pitting both team cars in consecutive laps, so the second waits in the pit lane. |
| `crossover-point` | Crossover point | enthusiast | The lap time at which slicks become faster than intermediates as a track dries. |
| `box-box` | Box, box | foundation | The team radio call telling the driver to come into the pits this lap. |
| `team-principal` | Team principal | intermediate | The boss who runs the team and its budget, and usually the public face in the paddock. |
| `race-engineer` | Race engineer | intermediate | The driver's main voice on the radio: sets the car up, passes instructions and reads the data. |
| `pit-wall` | Pit wall | intermediate | Where strategists and engineers sit trackside and make race decisions. |
| `team-radio` | Team radio | intermediate | Driver-to-team messages broadcast during the race. A huge source of memes and drama. |
| `team-orders` | Team orders | intermediate | An instruction to swap positions or hold station for the team's benefit. |
| `teammate-battle` | Teammate benchmark | intermediate | The one driver who has the same car, making the teammate the fairest comparison of talent. |
| `works-team` | Works team | intermediate | A team that builds its own engine, or is owned by the engine maker, like Ferrari and Mercedes. |
| `customer-team` | Customer team | intermediate | A team that buys engines from someone else, like Williams with Mercedes. |
| `engine-supplier` | Engine supplier | intermediate | A company supplying power units: Mercedes, Ferrari, Honda, Audi and Red Bull-Ford in 2026. |
| `super-licence` | Super licence | enthusiast | The FIA licence needed to race in F1, earned with points from lower series. |
| `feeder-series` | Feeder series | intermediate | F3 and F2 and other junior categories that are the ladder to F1. |
| `junior-programme` | Junior programme | enthusiast | Team academies, like Red Bull's, that fund and groom young drivers. |
| `reserve-driver` | Reserve driver | enthusiast | The stand-in who steps up if a race driver is ill or injured. |
| `driver-market` | Silly season | intermediate | Speculation and signings about who drives for whom next year. Peaks mid-season. |
| `paddock` | The paddock | foundation | The hospitality and team area behind the pits where the sport's people live. |
| `tifosi` | Tifosi | foundation | Ferrari's passionate fans, most famously at Monza where the crowd floods the track after the race. |
| `triple-crown` | Triple Crown of Motorsport | enthusiast | Winning the Monaco GP, the Indianapolis 500 and the 24 Hours of Le Mans. Only Graham Hill did it. |
| `drive-to-survive` | Drive to Survive | foundation | The Netflix series that drove a big surge of new fans, especially in the US. |
| `race-pace-vs-quali-pace` | Race pace vs one-lap pace | intermediate | Speed over a whole stint versus a single flat-out lap. Some cars and drivers have one without the other. |
| `long-run` | Long run | intermediate | Friday practice laps on race fuel loads that reveal race pace and tyre wear. |
| `sandbagging` | Sandbagging | enthusiast | Hiding true pace in practice by running with lots of fuel or a conservative engine mode. |
| `title-permutations` | Title permutations | enthusiast | The maths of what each contender needs to clinch the championship with races remaining. |
