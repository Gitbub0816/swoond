# Course Design Specification: Cars (`cars`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/cars.handling.drive-layout.v1.md`, `NOTES_FOR_ORCHESTRATOR.md` |

Time-sensitive facts (EV market, policy, import rules, model availability) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Lesson copy never hard-codes them; the live layer (`now-in-cars`) and versioned tokens carry them (see `live-data.md`). Web sources used: US EV sales and tax-credit coverage (Inside Climate News, KBB, Cox-derived summaries), 25-year import rule explainers, and Euronews/PBS coverage of the EU 2035 proposal.

---

## 1. Identity

- **Course ID:** `cars` (immutable)
- **Display name:** Cars
- **Category / family:** Cars & Automotive > Cars (family `Cars & Automotive`)
- **Simulation prefix:** `cars`
- **The subject is a culture with an engineering spine.** "Cars" is not one thing. The person you care about may love how cars *work* (engines, drivetrains), how they *look* (shapes, design language, generations), what they *say* about you (makes, badges, scenes), what you can *do* to them (modding), or the *social* world around them (meets, shows, track days). The course is built so every learner gets a shared spine (how a car works, what the shapes and words mean, who the makes are, what owning one is like) and then tilts into the scene she lives in through branches.
- **Not a motorsport course.** Racing is a spectator sport with series, drivers, standings and live results; cars culture is about the *machines and the people who own them*. The road-going car is the object here.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| NASCAR (`nascar`, wave 1) | A learner who knows engines, drivetrains and makes can follow the *hardware* talk in NASCAR (V8, manufacturer names) but not the sport: stages, drafting, pit strategy, points, drivers. The reverse is also false: a NASCAR fan may not know a DCT from a CVT or what a restomod is. | Independent | Cross-link concepts only (`horsepower`, `torque`, `aero-downforce`, `aero-drag`). No shared units. The Ford/Chevrolet/Toyota rivalry appears in both, for different reasons: identity here, competition there. |
| Formula 1 (`formula-1`, wave 1) | F1 fans talk hybrid power units and aero, which overlaps `ev-hybrid-ice` and `handling-and-chassis` only at the vocabulary level. Road-car culture (badges, trims, owning) does not transfer at all. | Independent | Cross-link `aero-downforce`, `hev`, `regen-braking`. F1 ownership of "engineering" framing is not repeated here. |
| Video games (`video-games`, wave 2) | Racing-game fans know car names and tuning slang from games; that is a bridge into the enthusiast entry, not a course overlap. | Adjacent | One talk-lab line acknowledges "I learned cars from a game"; no dependency. |
| Photography (`photography`, wave 2) | Car photography is a scene, but it needs exposure and composition knowledge Cars does not teach. | Adjacent (not scheduled) | `mt-02` covers photography etiquette at meets only. |
| Camping / hiking (`camping`, `hiking`) | Overlanding sits between trucks and camping. | Adjacent | Branch `truck-offroad` touches it; it does not teach camping, and points to the camping course when it exists. |
| Motorcycles, aviation, boats | Different machines and cultures. | Independent (not in catalog) | Not covered; may become sibling courses. |

- **Branches** (one branch chosen per learner, or the default; branch units only appear for the matching branch):

| id | Name | What changes |
|---|---|---|
| `everyday` | She loves cars in general (default) | Core spine only; balanced examples across scenes; live layer favors new models and everyday ownership news. No branch unit. |
| `american-muscle` | American muscle | V8s, pony cars, drag culture, Cars-and-Coffee cruise nights; examples use Mustang / Camaro / Challenger / Corvette / trucks-as-muscle. |
| `jdm-tuner` | JDM and tuner scene | 90s Japanese legends, the 25-year import rule, drift, touge, tuner culture, import shows. |
| `euro-performance` | Euro performance | Hot hatches to Porsche, homologation specials, the Nurburgring, M/AMG/RS rivalry. |
| `ev-tech` | EVs and tech | Battery and charging depth, software-defined cars, driver assist, the new makers and policy. |
| `truck-offroad` | Trucks and off-road | Payload and towing, 4x4 systems, trail angles, overlanding culture. Safety-conservative. |
| `classic-collector` | Classic and collector | Auctions, listings, restoration choices, concours, clubs and registries. |

Choosing a branch other than `everyday` sets the personalization dimension `style` (scene). Brand is a separate dimension (section 8).

---

## 2. Beginner model

**What a complete beginner knows.** Cars have engines and get you places; "horsepower is how fast it is"; Ferrari and Lamborghini are expensive; electric cars are "the future" (or, depending on the person, "the problem"); a manual is "the one with three pedals". She can probably name body styles loosely ("SUV") and a few makes, mostly by logo and by price tier. She may know what *her own* car is, but not why an enthusiast calls it "the one with the good engine".

**Terminology that confuses:** displacement, "a 2.0T", torque vs horsepower, DCT, CVT, LSD, AWD vs 4WD, PHEV vs MHEV, understeer / oversteer, rev-matching, "the E46", "a facelift", "a restomod", "OEM+", "Stage 1", "sleeper", "cammed", "boost", "coilovers", "widebody", "a survivor", "matching numbers", "JDM", "kei", "shooting brake", "hot hatch", "GT", "homologation special", "Cars and Coffee", "rolling out".

**Common misconceptions (each is a lesson beat):**
1. "More horsepower always means faster." (Weight, gearing, traction and torque delivery matter; `spec-sheet`, `power-to-weight`.)
2. "Horsepower and torque are two different powers." (Torque is what you feel as shove; horsepower is torque times revs, `horsepower`, `torque`.)
3. "Turbo means fast." (A small turbo engine can be a fuel-saving commuter; boost is a tool, `forced-induction`.)
4. "AWD means it cannot slide" / "AWD is the same as 4WD." (AWD helps *traction*, not grip in the corner, and it is a different system from part-time 4WD, `awd`, `four-wheel-drive`, `drive-layout-handling`.)
5. "Automatics are slow and lazy; manuals are always faster." (Modern DCTs and torque-converter autos out-shift humans; a manual is about engagement, not speed, `dct`, `manual-vs-auto-debate`.)
6. "EVs never need maintenance" and "EVs catch fire constantly." (Fewer moving parts, still tires, brakes and coolant; fire rates per vehicle are lower than gas cars in most published analyses but the stories are louder, `bev`, `battery-degradation`. State this carefully and link.)
7. "Range is a fixed number." (Speed, cold, load, tires and heat change it, `range-vs-efficiency`, `cold-weather-range`.)
8. "Premium fuel makes any car faster/cleaner." (Octane only matters if the engine was designed to use it, `octane`.)
9. "Old cars are always better/more reliable" or "old cars are death traps and worthless." (Both are lazy takes; eras differ, `automotive-eras`, `analog-feel`.)
10. "A JDM car is any Japanese car." (JDM = built for the Japanese Domestic Market; a US-market Camry is not JDM, `jdm-meaning`.)
11. "Modding always ruins a car / always improves a car." (It depends on the goal and the execution, `build-philosophy`, `ecu-tune`.)
12. "All car people are loud, reckless, or rich." (The scene is mostly people who love details; etiquette culture is strong, `meet-etiquette`.)

**Concepts that unlock the rest (foundation units):** four-stroke, torque vs horsepower, the power path, drive layout (FWD/RWD/AWD), body-style words, ICE vs hybrid vs EV, and reading a car (proportions, generation, trim).

---

## 3. Foundational knowledge

Grouped into modules (`foundationalModules[]`, each equals a foundation unit id):

| Module (unit id) | Contents |
|---|---|
| **How Engines Work** (`how-engines-work`) | Four-stroke cycle, cylinder and piston, layouts (inline, V, flat, rotary), displacement and naming (a 5.0, a 2.0T), horsepower vs torque and the power band, forced induction (turbo, supercharger, lag), fuels (octane, diesel, direct injection), reading a spec sheet and power-to-weight. |
| **Drivetrain and Gearbox** (`drivetrain-and-gearbox`) | The power path, gear ratios and revs, the manual clutch and rev-matching, torque-converter autos, dual-clutch, CVT, paddles, FWD/RWD/AWD/4WD, differentials and limited slip, engine placement. |
| **EV, Hybrid, ICE** (`ev-hybrid-ice`) | Battery, motor, inverter, kWh and efficiency, regen and one-pedal, charging levels and connectors, HEV/PHEV/MHEV/EREV, cold and aging, hydrogen in one lesson, what feels different at the wheel. |
| **Body Styles and Segments** (`body-styles-segments`) | Sedan, coupe, hatch, wagon, SUV and crossover, pickup, van; convertibles and roof types; size classes and letter segments; sports car / GT / supercar / hypercar; muscle, pony, hot hatch, kei; fastback and notchback words; unibody vs body-on-frame. |
| **Reading a Car** (`reading-a-car`) | Proportions (wheelbase, overhang, cab-forward), design language and light signatures, generations and facelifts, trim levels and badges, chassis codes and nicknames, VIN basics. |

Also covered in intermediate units: handling and chassis (tires, suspension, brakes, weight transfer, understeer and oversteer, aero), makes and identities (North America, Germany, Italy/UK/Sweden/France, Japan, Korea, China, performance sub-brands), owning and buying (new/used/CPO, price vs value, financing shape, maintenance, warning lights, recalls, reliability and inspection).

**Original terminology map.** All illustrations are original vector art (`original-swoond`). Where a lesson names a real model, it is a text reference; the illustration is either an archetype, a feature callout, or a stylized composite (see section 13).

---

## 4. Enthusiast model

**What enthusiasts actually talk about.** Their car or the one they want; how it *feels* (steering, gearbox, sound); what they changed and why; a specific generation ("the ND Miata", "the E46 M3", "a C7 Z06", "an 8th-gen Civic Si"); how it compares with its rivals; how hard it is to find, service or insure; what is happening to the kind of car they love (V8s ending, manuals vanishing, EVs arriving, prices climbing); the meets, cruises, track days and trips they organize.

**Distinctions that matter to them:**
- Generation and chassis code, not just model name.
- Engine *family* (LS, Coyote, Hemi, B18, RB26, 2JZ, flat-six) and how it sounds.
- Manual vs automatic; NA vs turbo; RWD vs FWD; analog vs digital feel.
- Original vs restored vs restomod; matching numbers.
- OEM+ (tasteful factory-flavored upgrades) vs stance vs track build.
- "Driver's car" vs a fast car; feel vs numbers.

**Knowledge that signals genuine understanding:** using the right generation words; knowing why a car is *beloved* (not only fast); asking about the *build* before the price; understanding the trade-offs of mods; naming the rival; being able to say what is *good* about the other side of a debate.

**Statements that sound obviously uninformed:** "How many horsepowers does it have?" ("horsepowers" as a plural noun), "Is it a real Ferrari or a Fast and Furious one?", "Cool rims!" for a car whose wheels are the whole story, "Why would you buy a manual?" delivered as an insult, "It's a Honda, so it's slow", "Electric cars just have batteries, no engine, that's boring", "Turbo is just a fancy fan", "You should fix that rust with some paint."

**Common controversies and debates** (all in `the-great-debates` and talk tracks; teach both sides): manual vs automatic; EV vs gas (fun, weight, sound); naturally aspirated vs turbo; big touchscreens vs physical buttons; subscriptions for features; right to repair; SUVs eating sedans and hatchbacks; V8 endangered; modern cars too big/heavy; Nurburgring times and spec-sheet wars; "is it a real sports car" gatekeeping; stance vs function; classic value bubbles; tariffs and where cars are built.

---

## 5. Interaction model

**What the learner should EXPERIENCE instead of reading:**
- **Recognition.** Seeing shapes, proportions, light signatures and drivetrains in original illustrations and training the eye (`visual-id`, `hotspot-tap`). This is the core of spec section 18 (visual identification) and the course's signature interaction.
- **Mechanism.** Putting the power path, four-stroke cycle, charging levels and restoration terms in order or on a diagram (`sequence-order`, `hotspot-tap`, `term-match`).
- **Judgment.** Buying and owning scenarios, meet etiquette, mod trade-offs (`decision-scenario`).
- **Magnitudes.** How much a tank holds, what a kWh is, quarter-mile times (`estimate-slider`).
- **Conversation.** Decoding "she just said..." and replying (`say-this`, `talk-track`).
- **One physical feel that a phone can carry:** how the *drive layout* changes what a car does in a corner, seen from above. This is the single Unity sim.

**Does the course warrant a Unity simulation?** Yes, exactly one, after applying the CLAUDE.md rubric strictly; four other candidates are rejected on the record (section 12). The default is native.

**What should NOT be gamified:**
- Anything implying real driving skill is being learned (never a "drive it yourself" arcade, no lap-time chasing, no reward for speed on public roads).
- Safety work: jacking and lifting, high-voltage EV components, fuel handling, towing and off-road recovery. Only awareness-level judgment scenarios (`safetyNote` always present).
- Money decisions (financing, buying advice): scenarios explain the *shape* of trade-offs; never "best deal" scoring that pretends to be advice.
- Rankings of makes as good/bad; identity is described, not ranked.
- Mod cost and legality: never a "build the fastest car" optimizer.

**Chosen mix:** mostly native (`multiple-choice`, `term-match`, `visual-id`, `hotspot-tap`, `decision-scenario`, `say-this`, `talk-track`), with `sequence-order`, `estimate-slider`, `binary-call`, `fill-the-gap`, `timing-tap` and `listening-id` where each fits, plus one Unity sim. Details in section 12.

---

## 6. Dynamic information requirements

Cars is a *medium-live* subject: evergreen mechanics dominate, but "what is new" and "what is happening to my car's kind" matter socially (spec section 10: do not invent live needs).

| Kind | Needed? | Why | Providers (candidates, behind adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| `new-products` (models) | Yes | "Did you see the new ...?" is the most natural car conversation. | NHTSA vPIC (public), EPA/DOE fueleconomy.gov vehicle list (public), manufacturer press sites (link-only facts), curated editorial | weekly | Evergreen "how a model year works" card |
| `releases` (launches and reveals) | Yes | Reveal season and model-year changes drive talk. | Curated launch calendar with source links | weekly | Skip card |
| `alerts` (recalls) | Yes | Owner-relevant, safe, and public data. | NHTSA recalls API (public) | daily | "What is a recall" card |
| `statistics` (efficiency, range, EV market) | Light | Range/mpg facts and market trend context. | fueleconomy.gov API (EPA), Alternative Fuels Data Center (DOE), Cox Automotive / Argonne / Alliance summaries (link + own words) | monthly / quarterly | Snapshot with date |
| `events` | Yes | Car Week, festivals, shows, SEMA, track-day seasons. | Curated calendar; organizer sites (link-out) | monthly | Evergreen event guide |
| `regulations` | Light | EV policy, emissions, import rules, EU 2035 debate. | Official sources (EPA, NHTSA, European Commission, CBP) as links; Swoon'd explainer | on-release | Evergreen explainer |
| `conditions` / fuel prices | Optional | Gas price talk. | EIA weekly retail prices (public) | weekly | Hidden |
| `news` | Yes | Editorial layer (section 7). | Publisher RSS (link-only) | daily | Evergreen |
| Auction results | Rejected as structured data | Bring a Trailer, Cars & Bids, RM Sotheby's, Mecum have no open commercial API; scraping violates terms. | Link-out only; curated editorial notes on notable sales | n/a | n/a |
| Live scores / standings | No | Not a sport; motorsport results belong to NASCAR/F1. | n/a | n/a | n/a |

Structured data (NHTSA, EPA, DOE) and editorial data are separate systems. Full plan in `live-data.md`.

---

## 7. Editorial context

- **What commentary helps:** why a model was cancelled or revived; why a reveal caused a fuss (a name, a styling change, a manual dropped); why prices of a car are moving; why an EV policy change or a tariff matters for a buyer; why a recall is or is not scary; why a car is called "the last of its kind".
- **Sources:** automotive publications and their RSS feeds (link-only), manufacturer press pages for facts, regulator sites (NHTSA, EPA, European Commission). Swoon'd never copies publisher text.
- **Approach:** `explain-and-link`. Identify a current topic, teach the relevant terms in our own words, say why enthusiasts care, link to the original.
- **Example prompts:** "Why are people upset the new one is an SUV?", "Why does everyone care about a manual gearbox?", "What does a 90% CO2 rule actually change?", "Why are 2001 Skylines suddenly 'legal' this year?", "What is a homologation special and why is it so expensive?"

---

## 8. Personalization

| Dimension | Values | How it changes examples | Live context | Default | Tokens |
|---|---|---|---|---|---|
| `brand` | Any make she loves or owns (from a maintained list of ~60 makes); optional model | Examples in `makes-and-identities`, `reading-a-car`, `owning-and-buying` and talk-lab use her make; "what she is probably proud of". | New models, recalls for her make, events. | none (balanced mix across makes) | `{{make}}`, `{{model}}`, `{{ownedCar}}` |
| `style` (scene) | `american-muscle`, `jdm-tuner`, `euro-performance`, `ev-tech`, `truck-offroad`, `classic-collector`, or none (set by branch) | Chooses which branch unit shows; tilts examples of debates and mods. | Scene-relevant news cards. | none (`everyday`) | `{{scene}}` |
| `region` | Country/state (optional) | Units and plugs (mpg vs L/100 km, NACS vs CCS/Type 2), legal terms (import rules, inspections), local events. | Local events, fuel prices. | none (US units, with alternates named) | `{{region}}` |

Personalization never changes foundational correctness. Tokens appear in `makes-and-identities`, `owning-and-buying`, `now-in-cars`, `talk-lab`. Unset values render neutral examples. Never infer a person's wealth or status from the make; teach "ask why she chose it".

---

## 9. Conversation model

Ten-plus lines an enthusiast might say (with translation, implied terms and good follow-ups):

| # | She says | Means | Terms implied | Good follow-up |
|---|---|---|---|---|
| 1 | "It's a 2.0T with a six-speed. No apologies." | A turbocharged four-cylinder with a manual; she is proud of the manual. | `displacement`, `forced-induction`, `manual-clutch` | "Is the clutch light or does it take some leg?" |
| 2 | "The new one is bigger, heavier, and has a screen for everything." | Modern-car complaints. | `curb-weight`, `modern-car-complaints` | "Did you like the last generation's buttons?" |
| 3 | "Got the coilovers on and it finally sits right." | Adjustable suspension improved stance and handling. | `wheels-fitment`, `suspension-basics`, `stance` | "Did you go for looks or for the track?" |
| 4 | "It pushes in every corner." | Understeer. | `understeer`, `drive-layout-handling` | "Is it a front-driver?" |
| 5 | "Sleeper build, stock body, all motor." | A quiet-looking fast car with no forced induction. | `sleeper`, `naturally-aspirated` | "What did it start as?" |
| 6 | "I'm waiting for the R34s to come in." | 2001-built GT-Rs becoming legal to import. | `import-25-year-rule`, `chassis-codes` | "Do you know how much the paperwork is?" |
| 7 | "Charging at home changed everything." | Level 2 home charging. | `home-charging`, `charging-levels` | "Level 2, overnight?" |
| 8 | "It's matching numbers, but the paint isn't original." | Original drivetrain, repainted. | `matching-numbers`, `restoration-terms` | "Is the paperwork clean?" |
| 9 | "Cars and Coffee is at 7, don't be late, don't rev it." | Local meet etiquette. | `meet-types`, `meet-etiquette` | "Where do people park?" |
| 10 | "The dual-clutch is wonderful until it's not." | DCT quirks at low speed and repair cost. | `dct`, `reliability-vs-repair` | "Does it shudder at low speed?" |
| 11 | "The Ring time doesn't tell you if it's fun." | Nurburgring debate. | `nurburgring-times`, `numbers-vs-feel` | "What did drive best for you?" |
| 12 | "My tune is Stage 1, nothing crazy." | ECU tune with modest gains. | `stage-tuning`, `ecu-tune` | "Did you check the warranty on that?" |

- **What the learner could ask next:** how it *feels*, what generation, what the owner changed and why, what the next dream car is, whether she does track days, how the car is aging.
- **How Swoon'd helps without faking expertise:** every `say-this` has a `noFakeExpertNote`; follow-up lines are sincere curiosity ("what do you love about it?"); coach notes reward asking over declaring; talk-lab forbids inventing ownership or opinions about mods the learner has not tried.
- **Targets:** 14 talk tracks at launch (roster in `exercises.md` section 5) and about 80 `say-this` items over the course.

---

## 10. Assessment

- **How useful competence is determined:** concept mastery (0-1) driven by exercise outcomes and sim mastery signals; pass threshold 0.8; spaced review keeps mastered concepts fresh; talk tracks measure smoothness (>= 60 success).
- **The learner should be able to:**
  - *Recognize:* body styles, drivetrains and engine layouts, generations vs facelifts, trim words, light signatures, meet types.
  - *Understand:* torque vs horsepower, what forced induction does, FWD/RWD/AWD consequences, EV vs hybrid types, why old and new cars feel different.
  - *Explain:* what a make stands for, why she loves the scene she is in, both sides of the big debates in one sentence each.
  - *Correctly interpret:* "2.0T", "matching numbers", "Stage 1", "it pushes", "sleeper", "a Level 2 charger", "a homologation special".
- **Mastery model:** `concept-mastery-v1`, `passThreshold` 0.8.
- **Useful competence statement:** "She can follow a car conversation, understand what her person's car is and why they love it, ask a couple of good questions about the build or the drive, and say 'okay, I get why you love this' without faking it."

---

## 11. Curriculum map (ongoing course)

An ongoing course of 21 units and 116 lessons in the order foundations, intermediate, enthusiast depth, branches, live, conversation practice and perpetual review. A learner sees about 16 units: the 5 foundation units, 3 intermediate, 4 enthusiast, 1 to 2 branch units of her choice, and the live, talk-lab and review units. Unit count exceeds the 8-14 guidance (P-04); phased shipping is below.

Activity codes in the tables are the native exercise type names; every lesson ends with at least one item that has a "say this" line and every unit ends with a talk-track or say-this beat (density about 5-8 items per lesson incl. review pools; the "planned activities" column lists the *families*, curriculum JSON adds items).

### Layer 1: Foundations

**Unit `how-engines-work`: How Engines Work.** Prerequisites: none. 7 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `hw-01` | Suck, squeeze, bang, blow | Name the four strokes and say what each does. | four-stroke, cylinder-piston | sequence-order, hotspot-tap, multiple-choice |
| `hw-02` | Inline, V, flat, rotary | Tell engine layouts apart by name and by sound. | engine-layouts, engine-note, rotary-engine | visual-id, term-match, listening-id |
| `hw-03` | What "5.0" and "2.0T" mean | Decode displacement, cylinder count and the turbo letter. | displacement, cylinder-count, naturally-aspirated | fill-the-gap, multiple-choice, estimate-slider |
| `hw-04` | Horsepower vs torque | Explain torque as shove and horsepower as how long the shove lasts. | horsepower, torque, power-band, redline | multiple-choice, decision-scenario, say-this |
| `hw-05` | Turbo, supercharger, or neither | Contrast boost types and say why turbos have lag. | forced-induction, turbo-vs-supercharger, turbo-lag | term-match, binary-call, multiple-choice |
| `hw-06` | Fuel, octane and diesel | Say what octane does and why the manual decides the fuel. | octane, diesel, direct-injection | multiple-choice, decision-scenario, fill-the-gap |
| `hw-07` | Reading a spec sheet | Pull the story out of hp, torque, weight and 0-60. | spec-sheet, power-to-weight, curb-weight | estimate-slider, multiple-choice, talk-track |

**Unit `drivetrain-and-gearbox`: Drivetrain and Gearbox.** Prerequisites: `how-engines-work`. 7 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `dt-01` | Engine to tire: the power path | Trace power from crankshaft to pavement. | powertrain-path, transmission-purpose | sequence-order, hotspot-tap, multiple-choice |
| `dt-02` | Gear ratios and revs | Say why a low gear multiplies torque and a high gear saves revs. | gear-ratio, rpm-vs-speed, shift-points | estimate-slider, timing-tap, fill-the-gap |
| `dt-03` | The manual and its clutch | Explain what the clutch decouples and what rev-matching is. | manual-clutch, h-pattern, rev-matching | sequence-order, timing-tap, multiple-choice, say-this |
| `dt-04` | Autos come in flavors | Separate torque-converter autos, dual-clutches and CVTs. | torque-converter-auto, dct, cvt, paddle-shifters | term-match, multiple-choice, say-this |
| `dt-05` | FWD, RWD, AWD, 4WD | Name which wheels are driven and the everyday consequence. | fwd, rwd, awd, four-wheel-drive | term-match, hotspot-tap, binary-call |
| `dt-06` | Differentials and limited slip | Say why a differential exists and what a limited-slip changes. | differential, lsd, torque-vectoring | multiple-choice, hotspot-tap, decision-scenario |
| `dt-07` | Where the engine sits | Recognise front-, mid- and rear-engine layouts and their reputations. | engine-placement, weight-distribution | visual-id, hotspot-tap, talk-track |

**Unit `ev-hybrid-ice`: EV, Hybrid, ICE.** Prerequisites: `how-engines-work`. 7 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `ev-01` | What is inside an EV | Name battery, motor and inverter and what each does. | bev, battery-pack, electric-motor, inverter | hotspot-tap, sequence-order, multiple-choice |
| `ev-02` | kWh, range and efficiency | Read kWh as the tank and mi/kWh as the mpg. | kwh, efficiency-mi-kwh, range-vs-efficiency | estimate-slider, multiple-choice, fill-the-gap |
| `ev-03` | Regen and one-pedal driving | Explain regenerative braking and why the brake lights come on. | regen-braking, one-pedal, instant-torque | multiple-choice, binary-call, say-this |
| `ev-04` | Charging 101 | Sort Level 1, Level 2 and DC fast charging and the plug shapes. | charging-levels, connector-standards, home-charging, charging-curve | term-match, decision-scenario, multiple-choice |
| `ev-05` | The hybrid alphabet | Tell HEV, PHEV, MHEV and range-extender apart. | hev, phev, mhev, erev | term-match, decision-scenario, multiple-choice |
| `ev-06` | Batteries, cold and aging | Say why winter cuts range and what battery aging looks like. | cold-weather-range, battery-degradation, hydrogen-fcev | multiple-choice, estimate-slider, decision-scenario |
| `ev-07` | What feels different at the wheel | Describe how an EV and a gas car differ in torque, weight and sound. | instant-torque, ev-weight, engine-note | say-this, binary-call, talk-track |

**Unit `body-styles-segments`: Body Styles and Segments.** Prerequisites: none. 7 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `bs-01` | Sedan, coupe, hatch, wagon | Identify the four classic shapes by roofline and doors. | sedan, coupe, hatchback, wagon | visual-id, term-match, multiple-choice |
| `bs-02` | SUV, crossover, truck, van | Say what makes a crossover different from a body-on-frame SUV. | suv-crossover, pickup, minivan-van, unibody-vs-body-on-frame | visual-id, multiple-choice, decision-scenario |
| `bs-03` | Roofs that open | Tell convertible, roadster, targa and T-top apart. | convertible-roadster, targa-t-top | visual-id, term-match, fill-the-gap |
| `bs-04` | Size classes and segments | Place a car in a size class using US and European labels. | size-classes, segments-letters | multiple-choice, term-match, estimate-slider |
| `bs-05` | Sports car, GT, supercar, hypercar | Explain how the four labels stack up and where they blur. | sports-car, grand-tourer, supercar-hypercar | term-match, multiple-choice, say-this |
| `bs-06` | Muscle, pony, hot hatch, kei | Use the enthusiast body-culture nicknames correctly. | muscle-pony-car, hot-hatch, kei-car | term-match, multiple-choice, say-this |
| `bs-07` | Fastback, notchback, shooting brake | Spot the roofline words designers and fans use. | fastback-notchback, shooting-brake | visual-id, hotspot-tap, talk-track |

**Unit `reading-a-car`: Reading a Car.** Prerequisites: `body-styles-segments`. 6 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `rc-01` | Proportions tell a story | Read wheelbase, overhangs and hood length as clues. | wheelbase-overhang, cab-forward-long-hood | visual-id, hotspot-tap, multiple-choice |
| `rc-02` | Faces and tails | Use lights and grilles as a design signature, not a badge. | design-language, light-signature | visual-id, multiple-choice, term-match |
| `rc-03` | Generations and facelifts | Say the difference between a new generation and a refresh. | generation, facelift, model-year | visual-id, multiple-choice, sequence-order |
| `rc-04` | Trim levels and badges | Decode a base, sport and top trim without a brochure. | trim-levels, badge-reading | term-match, decision-scenario, multiple-choice |
| `rc-05` | Chassis codes and nicknames | Understand why fans say E30, R34 or C8. | chassis-codes, enthusiast-nicknames | term-match, say-this, multiple-choice |
| `rc-06` | VIN and model-year basics | Find the VIN and read what its digits say. | vin-basics | hotspot-tap, multiple-choice, talk-track |

### Layer 2: Intermediate

**Unit `handling-and-chassis`: Handling and Chassis.** Prerequisites: `drivetrain-and-gearbox`. 6 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `hc-01` | Tires are the whole story | Read a tire size and say why grip is the ceiling. | tires-grip, tire-size-reading | hotspot-tap, multiple-choice, estimate-slider |
| `hc-02` | Springs, dampers, sway bars | Separate comfort from body control and say what stiff costs. | suspension-basics, ride-vs-handling | term-match, multiple-choice, binary-call |
| `hc-03` | Brakes and fade | Say what stops a car and why brakes fade. | brakes-basics, brake-fade | multiple-choice, decision-scenario, fill-the-gap |
| `hc-04` | Same corner, three drivetrains | Predict push or tail-out for FWD, RWD and AWD. | understeer, oversteer, drive-layout-handling | unity-sim `cars.handling.drive-layout.v1` |
| `hc-05` | Weight transfer and balance | Explain how braking and throttle move grip around the car. | weight-transfer, traction-limit | multiple-choice, binary-call, say-this |
| `hc-06` | Downforce, drag and wings | Say what a wing, splitter and diffuser do and what they cost. | aero-downforce, aero-drag | hotspot-tap, multiple-choice, talk-track |

**Unit `makes-and-identities`: Makes and Their Identities.** Prerequisites: `body-styles-segments`. 9 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `mk-01` | What a make stands for | Separate make, model, trim and parent company. | make-model-trim, parent-company, brand-identity | term-match, multiple-choice, say-this |
| `mk-02` | Detroit and the new Americans | Sketch Ford, GM, Stellantis, Tesla and Rivian in a line each. | north-american-makes | term-match, multiple-choice, say-this |
| `mk-03` | American icons at a glance | Match five icons to the people who love them. | icon-models-na | visual-id, multiple-choice, term-match |
| `mk-04` | Germany: the big three and Porsche | Say what BMW, Mercedes, Audi and Porsche each try to be. | german-makes, euro-brand-personas | term-match, multiple-choice, say-this |
| `mk-05` | Italy, Britain, Sweden, France | Sketch the exotic, the roadster and the safe. | italian-british-swedish | term-match, multiple-choice, say-this |
| `mk-06` | Euro icons at a glance | Spot the signature shapes that make Euro cars easy to name. | icon-models-eu | visual-id, multiple-choice, term-match |
| `mk-07` | Japan: reliable, clever, sometimes wild | Sketch Toyota, Honda, Nissan, Mazda, Subaru and friends. | japanese-makes | term-match, multiple-choice, say-this |
| `mk-08` | Korea and China | Explain the rise of Hyundai-Kia and the Chinese makers now abroad. | korean-chinese-makes | term-match, multiple-choice, say-this |
| `mk-09` | Luxury, mainstream, performance sub-brands | Read M, AMG, RS, N and Type R as a hint of intent. | performance-subbrands, luxury-vs-mainstream | term-match, multiple-choice, talk-track |

**Unit `owning-and-buying`: Owning and Buying.** Prerequisites: `makes-and-identities`. 6 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `ow-01` | New, used, certified | Name the trade-offs of new, used and certified pre-owned. | new-vs-used, certified-pre-owned | multiple-choice, decision-scenario, term-match |
| `ow-02` | Sticker, transaction price, depreciation | Say why the price and the value diverge. | msrp-transaction, depreciation | multiple-choice, estimate-slider, binary-call |
| `ow-03` | Finance, lease, buy: the shape of it | Explain the three at a high level without giving advice. | finance-lease-buy | term-match, multiple-choice, decision-scenario |
| `ow-04` | Maintenance rhythm | List what a car needs regularly and why skipping hurts. | maintenance-basics, fluids-and-filters | sequence-order, multiple-choice, fill-the-gap |
| `ow-05` | Warning lights and recalls | Say what a light means and what a recall actually is. | warning-lights, recalls | hotspot-tap, decision-scenario, multiple-choice |
| `ow-06` | Reliability and the real cost | Read reliability, repair cost and inspection like a skeptic. | reliability-vs-repair, pre-purchase-inspection, cost-of-ownership | decision-scenario, multiple-choice, talk-track |

### Layer 3: Enthusiast depth

**Unit `classic-vs-modern`: Classic vs Modern.** Prerequisites: `handling-and-chassis`. 6 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `cl-01` | Eras at a glance | Place a car in its era by tech and design. | automotive-eras | sequence-order, multiple-choice, term-match |
| `cl-02` | Carbs to computers | Say what fuel injection and the ECU changed. | carburetor-vs-efi, ecu | multiple-choice, sequence-order, fill-the-gap |
| `cl-03` | Why old cars feel different | Explain analog feel without romanticizing it. | analog-feel, safety-regulations-eras | say-this, binary-call, multiple-choice |
| `cl-04` | Original, restored, restomod, survivor | Use the four restoration words precisely. | restoration-terms, patina | term-match, multiple-choice, visual-id |
| `cl-05` | Value and provenance | Say why matching numbers and paper trails move prices. | matching-numbers, provenance, condition-scale | multiple-choice, decision-scenario, say-this |
| `cl-06` | Living with an old car | Describe the honest realities of rust, parts and storage. | rust, classic-ownership | decision-scenario, multiple-choice, talk-track |

**Unit `meet-and-show-culture`: Meet and Show Culture.** Prerequisites: `reading-a-car`. 5 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `mt-01` | Kinds of meets and shows | Tell a cruise-in from a concours from a track day. | meet-types, concours | term-match, multiple-choice, visual-id |
| `mt-02` | Meet etiquette | Know what not to touch, rev or block. | meet-etiquette, takeover-issue | decision-scenario, binary-call, multiple-choice |
| `mt-03` | Reading the show board | Decode a build sheet, class and trophy. | build-sheet, show-classes | hotspot-tap, multiple-choice, term-match |
| `mt-04` | Track days, autocross, drag nights | Say what each grassroots motorsport is and how safe events work. | track-day, autocross, drag-night | term-match, decision-scenario, multiple-choice |
| `mt-05` | Asking an owner a good question | Practice questions that flatter curiosity, not knowledge. | owner-questions | say-this, talk-track, multiple-choice |

**Unit `modding-and-tuning`: Modding and Tuning.** Prerequisites: `handling-and-chassis`. 6 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `md-01` | Why people modify cars | Name the build philosophies: OEM+, stance, track, sleeper. | build-philosophy | term-match, multiple-choice, say-this |
| `md-02` | Bolt-ons and stages | Explain intake, exhaust, downpipe and what "Stage 1" implies. | bolt-ons, stage-tuning | term-match, multiple-choice, sequence-order |
| `md-03` | Tunes, warranty and reliability | Say what a tune changes and what it may risk. | ecu-tune, warranty-and-mods | multiple-choice, decision-scenario, binary-call |
| `md-04` | Wheels, stance, wraps, PPF | Separate looks mods from performance mods. | wheels-fitment, wrap-ppf-coating, stance | visual-id, term-match, multiple-choice |
| `md-05` | Swaps and street legality | Say why engine swaps thrill people and worry regulators. | engine-swap, mod-legality | decision-scenario, multiple-choice, say-this |
| `md-06` | Sleepers and what a build says | Read a build as a personality and ask about it. | sleeper, build-story | say-this, talk-track, multiple-choice |

**Unit `the-great-debates`: The Great Debates.** Prerequisites: `classic-vs-modern`. 5 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `db-01` | Manual vs automatic | Give each side its best argument in one sentence. | manual-vs-auto-debate | say-this, multiple-choice, talk-track |
| `db-02` | EV vs gas: fun, weight, sound | Explain why people argue and why both can be right. | ev-vs-ice-debate | say-this, multiple-choice, binary-call |
| `db-03` | Naturally aspirated vs turbo | Say why purists love NA and downsizing won. | na-vs-turbo-debate | say-this, multiple-choice, binary-call |
| `db-04` | Too big, too heavy, too many screens | Name the modern-car complaints and the answers to them. | modern-car-complaints, right-to-repair | say-this, multiple-choice, decision-scenario |
| `db-05` | Numbers vs feel | Explain why lap times and spec sheets do not settle arguments. | numbers-vs-feel, nurburgring-times | say-this, multiple-choice, talk-track |

### Layer 4: Branches and personalization

**Unit `branch-american-muscle`: American Muscle (branch).** Prerequisites: `makes-and-identities`. 4 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `bm-01` | Pony car vs muscle car | Say who started it and why the words differ. | muscle-history | sequence-order, term-match, multiple-choice |
| `bm-02` | Small block, Hemi, Coyote, LS | Match the famous V8 families to their homes. | v8-families | term-match, multiple-choice, say-this |
| `bm-03` | Quarter-mile talk | Read ET, trap speed and 60-foot times. | quarter-mile, drag-terms | term-match, estimate-slider, multiple-choice |
| `bm-04` | Muscle today | Explain the state of V8s, EV muscle and the rivalry. | muscle-now | say-this, multiple-choice, talk-track |

**Unit `branch-jdm`: JDM and Tuner Scene (branch).** Prerequisites: `makes-and-identities`. 4 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `jd-01` | What JDM really means | Separate JDM, tuner and import culture. | jdm-meaning, import-culture | term-match, multiple-choice, say-this |
| `jd-02` | The 90s legends | Tell Supra, GT-R, NSX, RX-7, Evo and STI apart. | jdm-icons | visual-id, term-match, multiple-choice |
| `jd-03` | The 25-year rule | Explain the rolling import window and why it matters. | import-25-year-rule | multiple-choice, estimate-slider, say-this |
| `jd-04` | Drift, touge and tuner culture | Say what drifting and touge are and where they came from. | drift-touge | term-match, multiple-choice, talk-track |

**Unit `branch-euro-performance`: Euro Performance (branch).** Prerequisites: `makes-and-identities`. 4 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `eu-01` | Hot hatch to sports sedan | Follow the Euro performance ladder. | euro-perf-ladder | term-match, multiple-choice, say-this |
| `eu-02` | Porsche 911 and the air-cooled era | Explain the 911 idea and why air-cooled ones cost so much. | porsche-911-idea, air-cooled | visual-id, multiple-choice, say-this |
| `eu-03` | The Ring and homologation | Say what a Nurburgring time and a homologation special are. | homologation-special, nurburgring-lore | multiple-choice, term-match, say-this |
| `eu-04` | M, AMG, RS: the rivalry | Give each brand a personality in a sentence. | m-amg-rs | term-match, multiple-choice, talk-track |

**Unit `branch-ev-tech`: EV and Tech (branch).** Prerequisites: `ev-hybrid-ice`. 4 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `et-01` | EV performance and launch | Explain why EVs are quick and what they give up. | ev-performance | estimate-slider, multiple-choice, say-this |
| `et-02` | Software-defined cars | Say what over-the-air updates and driver assist levels are. | ota-updates, driver-assist-levels | term-match, decision-scenario, multiple-choice |
| `et-03` | LFP vs NMC and the battery story | Contrast the two chemistries in plain language. | battery-chemistries | term-match, multiple-choice, estimate-slider |
| `et-04` | New players and policy | Follow the makers and rules shaping EVs now. | ev-policy-players | say-this, multiple-choice, talk-track |

**Unit `branch-truck-offroad`: Trucks and Off-Road (branch).** Prerequisites: `body-styles-segments`. 4 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `to-01` | Half-ton, payload and towing | Read payload, tow rating and cab and bed codes. | payload-tow-rating, truck-classes | term-match, estimate-slider, decision-scenario |
| `to-02` | 4x4 systems | Separate low range, locking diffs and part-time 4WD. | transfer-case-lockers | term-match, multiple-choice, hotspot-tap |
| `to-03` | Approach, breakover, departure | Read the three angles and ground clearance on a diagram. | off-road-angles, articulation | hotspot-tap, multiple-choice, fill-the-gap |
| `to-04` | Overlanding and doing it safely | Talk about trips without pretending to know trail safety. | overlanding, off-road-safety | decision-scenario, say-this, talk-track |

**Unit `branch-classic-collector`: Classic and Collector (branch).** Prerequisites: `classic-vs-modern`. 4 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `cc-01` | How the collector market works | Say what drives values and what a price guide is. | collector-market | multiple-choice, estimate-slider, say-this |
| `cc-02` | Auctions and reading a listing | Read a listing and an auction result skeptically. | auction-reading, sold-vs-bid | decision-scenario, multiple-choice, term-match |
| `cc-03` | Restore, preserve or restomod | Weigh the three choices a classic owner faces. | restoration-choice | decision-scenario, term-match, say-this |
| `cc-04` | Concours, clubs and registries | Explain what judged shows and marque clubs do. | concours-judging, marque-clubs | term-match, multiple-choice, talk-track |

### Layer 5: Current context (live)

**Unit `now-in-cars`: Now in Cars.** Prerequisites: `makes-and-identities`. 5 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `nc-01` | New this model year | Explain what launches, reveals and refreshes mean this season. | model-year-launch | say-this, multiple-choice |
| `nc-02` | EV market and charging news | Read this quarter's EV headlines without hype. | ev-market-context | say-this, multiple-choice, binary-call |
| `nc-03` | Recalls in plain English | Say what a recall is and what an owner does. | recalls | multiple-choice, decision-scenario |
| `nc-04` | The events calendar | Know the big shows and festivals and why fans go. | events-calendar | multiple-choice, term-match, say-this |
| `nc-05` | Your make right now | See what her make is talking about this month. | make-now | say-this, multiple-choice, talk-track |

### Layer 6a: Conversation practice

**Unit `talk-lab`: Talk Lab.** Prerequisites: `makes-and-identities`. 6 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `tl-01` | "What are you driving?" | Open a car chat with curiosity. | owner-questions, brand-identity | talk-track, say-this |
| `tl-02` | At the meet | Make small talk at a car meet without faking it. | meet-etiquette, build-story | talk-track, say-this |
| `tl-03` | When her car is a problem | Support a friend with car trouble, not fix her life. | warning-lights, reliability-vs-repair | talk-track, say-this |
| `tl-04` | The friendly debate | Have manual-vs-EV banter without a winner. | manual-vs-auto-debate, ev-vs-ice-debate | talk-track, say-this |
| `tl-05` | Passenger seat | Ride along and say something warm and true. | engine-note, analog-feel | talk-track, say-this |
| `tl-06` | "Should I buy this one?" | Give a humble answer when asked for advice. | pre-purchase-inspection, cost-of-ownership | talk-track, say-this |

### Layer 6b: Perpetual review

**Unit `review-loop`: Perpetual Review.** Prerequisites: `how-engines-work`. 4 lessons.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `rv-01` | Term blitz | Recall the terms from earlier units on the spaced schedule. | powertrain-path, horsepower, regen-braking, trim-levels | term-match, fill-the-gap, multiple-choice |
| `rv-02` | Spot the body style and layout | Recognise shapes and drivetrains fast. | sedan, coupe, engine-placement | visual-id, hotspot-tap |
| `rv-03` | Boss: predict the slide | Run the handling sim at level 4. | understeer, oversteer, drive-layout-handling | unity-sim `cars.handling.drive-layout.v1` |
| `rv-04` | Say-this mix | Decode a mixed bag of enthusiast lines. | generation, build-philosophy, ev-vs-ice-debate | say-this, talk-track |

**Layer notes.**

| Layer | Purpose | Minimum expectation | Met by |
|---|---|---|---|
| Foundations | Terms, how it works | 4+ units, ~20+ lessons | 5 units, 33 lessons |
| Intermediate | Distinctions and context | 4+ units | 3 units, 21 lessons. The brief minimum is 4 units; the `makes-and-identities` unit is deliberately one unit of 9 lessons that carries the four "region" sub-arcs (N. America, Europe, Japan/Korea/China, sub-brands) to avoid four thin units. Split it in phase 2 if authoring shows depth. |
| Enthusiast depth | Debates, culture, history | 3+ units | 4 units, 22 lessons |
| Branches | Scene-specific depth | Branch layer units | 6 branch units, 24 lessons, one shown per learner (2 with "also interested in") |
| Current-season / live | Ongoing context | Templates + `live` hooks | `now-in-cars`, 5 lessons with lesson-level `live` hooks, refreshed weekly/monthly (cars genuinely has a perpetual "new this year" layer) |
| Conversation practice | Talk tracks, say-this | 10+ tracks | `talk-lab` 6 lessons + 14 standalone tracks |
| Perpetual review | Spaced review | Policy defined | `review-loop` 4 lessons + review policy below |

**Review policy (for `course.json`):** intervals 1, 3, 7, 14, 30 days after mastery; a concept returns to review when mastery falls below 0.8; max 12 review items per day; Daily Bite draws from `multiple-choice`, `fill-the-gap`, `term-match`; the boss review `rv-03` reruns the handling sim at difficulty 4.

**Concept targets.** About 213 concept ids (Playbook); the core subset is fixed at curriculum authoring. The full id list is in the appendix below.

**Personalization slots.** `{{make}}` in mk-01..mk-09 examples, ow-01..ow-06, nc-05, tl-01..tl-06; `{{scene}}` in the branch selection lesson and debates; `{{region}}` in `ev-04`, `ow-01`, `jd-03`, `nc-02`, `nc-04`.

**Release plan.**
- **Launch (v1.0):** all foundation, intermediate and enthusiast units; branch units `american-muscle`, `jdm-tuner`, `euro-performance`, `ev-tech` (the four largest scenes); `talk-lab`; `review-loop`; `now-in-cars` with curated (non-API) cards; the Unity sim.
- **v1.1 (about 60 days later):** `truck-offroad` and `classic-collector` branches after a safety and licensing review; NHTSA recall lookups by make; fueleconomy.gov efficiency cards.
- **Ongoing:** weekly `now-in-cars` cards; a yearly model-year sweep (each September); a quarterly EV-market refresh; the 25-year list each January; new scenes as branches (kei, stance, overlanding depth, kit cars) when the catalog process asks for them.

### Appendix: Playbook concepts (ids by unit)

- **how-engines-work**: `four-stroke`, `cylinder-piston`, `engine-layouts`, `engine-note`, `rotary-engine`, `displacement`, `cylinder-count`, `naturally-aspirated`, `horsepower`, `torque`, `power-band`, `redline`, `forced-induction`, `turbo-vs-supercharger`, `turbo-lag`, `octane`, `diesel`, `direct-injection`, `spec-sheet`, `power-to-weight`, `curb-weight`
- **drivetrain-and-gearbox**: `powertrain-path`, `transmission-purpose`, `gear-ratio`, `rpm-vs-speed`, `shift-points`, `manual-clutch`, `h-pattern`, `rev-matching`, `torque-converter-auto`, `dct`, `cvt`, `paddle-shifters`, `fwd`, `rwd`, `awd`, `four-wheel-drive`, `differential`, `lsd`, `torque-vectoring`, `engine-placement`, `weight-distribution`
- **ev-hybrid-ice**: `bev`, `battery-pack`, `electric-motor`, `inverter`, `kwh`, `efficiency-mi-kwh`, `range-vs-efficiency`, `regen-braking`, `one-pedal`, `instant-torque`, `charging-levels`, `connector-standards`, `home-charging`, `charging-curve`, `hev`, `phev`, `mhev`, `erev`, `cold-weather-range`, `battery-degradation`, `hydrogen-fcev`, `ev-weight`, `engine-note`
- **body-styles-segments**: `sedan`, `coupe`, `hatchback`, `wagon`, `suv-crossover`, `pickup`, `minivan-van`, `unibody-vs-body-on-frame`, `convertible-roadster`, `targa-t-top`, `size-classes`, `segments-letters`, `sports-car`, `grand-tourer`, `supercar-hypercar`, `muscle-pony-car`, `hot-hatch`, `kei-car`, `fastback-notchback`, `shooting-brake`
- **reading-a-car**: `wheelbase-overhang`, `cab-forward-long-hood`, `design-language`, `light-signature`, `generation`, `facelift`, `model-year`, `trim-levels`, `badge-reading`, `chassis-codes`, `enthusiast-nicknames`, `vin-basics`
- **handling-and-chassis**: `tires-grip`, `tire-size-reading`, `suspension-basics`, `ride-vs-handling`, `brakes-basics`, `brake-fade`, `understeer`, `oversteer`, `drive-layout-handling`, `weight-transfer`, `traction-limit`, `aero-downforce`, `aero-drag`
- **makes-and-identities**: `make-model-trim`, `parent-company`, `brand-identity`, `north-american-makes`, `icon-models-na`, `german-makes`, `euro-brand-personas`, `italian-british-swedish`, `icon-models-eu`, `japanese-makes`, `korean-chinese-makes`, `performance-subbrands`, `luxury-vs-mainstream`
- **owning-and-buying**: `new-vs-used`, `certified-pre-owned`, `msrp-transaction`, `depreciation`, `finance-lease-buy`, `maintenance-basics`, `fluids-and-filters`, `warning-lights`, `recalls`, `reliability-vs-repair`, `pre-purchase-inspection`, `cost-of-ownership`
- **classic-vs-modern**: `automotive-eras`, `carburetor-vs-efi`, `ecu`, `analog-feel`, `safety-regulations-eras`, `restoration-terms`, `patina`, `matching-numbers`, `provenance`, `condition-scale`, `rust`, `classic-ownership`
- **meet-and-show-culture**: `meet-types`, `concours`, `meet-etiquette`, `takeover-issue`, `build-sheet`, `show-classes`, `track-day`, `autocross`, `drag-night`, `owner-questions`
- **modding-and-tuning**: `build-philosophy`, `bolt-ons`, `stage-tuning`, `ecu-tune`, `warranty-and-mods`, `wheels-fitment`, `wrap-ppf-coating`, `stance`, `engine-swap`, `mod-legality`, `sleeper`, `build-story`
- **the-great-debates**: `manual-vs-auto-debate`, `ev-vs-ice-debate`, `na-vs-turbo-debate`, `modern-car-complaints`, `right-to-repair`, `numbers-vs-feel`, `nurburgring-times`
- **branch-american-muscle**: `muscle-history`, `v8-families`, `quarter-mile`, `drag-terms`, `muscle-now`
- **branch-jdm**: `jdm-meaning`, `import-culture`, `jdm-icons`, `import-25-year-rule`, `drift-touge`
- **branch-euro-performance**: `euro-perf-ladder`, `porsche-911-idea`, `air-cooled`, `homologation-special`, `nurburgring-lore`, `m-amg-rs`
- **branch-ev-tech**: `ev-performance`, `ota-updates`, `driver-assist-levels`, `battery-chemistries`, `ev-policy-players`
- **branch-truck-offroad**: `payload-tow-rating`, `truck-classes`, `transfer-case-lockers`, `off-road-angles`, `articulation`, `overlanding`, `off-road-safety`
- **branch-classic-collector**: `collector-market`, `auction-reading`, `sold-vs-bid`, `restoration-choice`, `concours-judging`, `marque-clubs`
- **now-in-cars**: `model-year-launch`, `ev-market-context`, `recalls`, `events-calendar`, `make-now`
- **talk-lab**: `owner-questions`, `brand-identity`, `meet-etiquette`, `build-story`, `warning-lights`, `reliability-vs-repair`, `manual-vs-auto-debate`, `ev-vs-ice-debate`, `engine-note`, `analog-feel`, `pre-purchase-inspection`, `cost-of-ownership`
- **review-loop**: `powertrain-path`, `horsepower`, `regen-braking`, `trim-levels`, `sedan`, `coupe`, `engine-placement`, `understeer`, `oversteer`, `drive-layout-handling`, `generation`, `build-philosophy`, `ev-vs-ice-debate`
---

## 12. Interaction plan

Each activity family maps to a native type or the Unity sim. Native rows link to the type in `docs/native-exercises/CATALOG.md`.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Body styles, roof types, generations vs facelifts, design cues (`bs-01`..`bs-07`, `rc-01`..`rc-03`, `md-04`, `mt-01`, `jd-02`, `eu-02`, `mk-03`, `mk-06`) | sedan, coupe, suv-crossover, generation, facelift, design-language, ... | `visual-id` | Recognition by sight is the skill (spec section 18). Native gives zoom, cues and per-option explanations, and original illustrations are static. No motion or camera is needed. | B | ~90 |
| Diagram parts: engine cutaway, drivetrain, EV pack, sidewall, VIN plate, off-road angles, tire and brake parts | four-stroke, powertrain-path, battery-pack, tire-size-reading, vin-basics, off-road-angles | `hotspot-tap` | Spatial knowledge on a *fixed* diagram; nothing moves. Unity would add cost without improving recall. | B | ~70 |
| Introduce 3-6 terms of a topic (drivetrains, hybrids, restoration words, trims) | fwd/rwd/awd, hev/phev, restoration-terms | `term-match` | Term-to-plain-English pairing is a recall task; tap-tap works on phone. | B | ~50 |
| Processes: four strokes, power path, charging sequence, restoration steps, pre-purchase inspection order | four-stroke, powertrain-path, charging-levels, pre-purchase-inspection | `sequence-order` | Order is the concept; per-step `why` text carries the logic. A simulated engine would teach the same order with more build cost. | B | ~30 |
| Rules and definitions checks | most core concepts | `multiple-choice`, `fill-the-gap` | Default recall and Daily Bite formats. | B | ~260 |
| Yes/no situational calls (regen on or off, AWD or 4WD, which fuel, etiquette dos and don'ts) | regen-braking, four-wheel-drive, octane, meet-etiquette | `binary-call` | Two-way judgment; diagram optional. | B | ~50 |
| Magnitudes: tank size, kWh, range, 0-60, quarter-mile, tow rating, weight | kwh, efficiency-mi-kwh, quarter-mile, payload-tow-rating | `estimate-slider` | The number and the intuition for it are the lesson; closeness matters more than exactness. | B | ~35 |
| Buying, owning, meet, mod, towing scenarios | new-vs-used, warning-lights, meet-etiquette, ecu-tune, off-road-safety | `decision-scenario` | Judgment over simulation; `expertNote` shows what an experienced owner weighs; `safetyNote` on safety topics. | B | ~50 |
| Conversation decoding and practice | all | `say-this`, `talk-track` | Every course; teaches understanding with a no-fake-expert note. | B | ~80 say-this, 14+ talk tracks |
| Engine and exhaust notes; DCT vs manual shift; EV whine vs V8; horn, turbo flutter (optional) | engine-layouts, engine-note, turbo-lag | `listening-id` | Sound *is* part of car identity. Original synthesized audio only (`original-swoond`); a "Skip" always awards no XP and no heart loss. Non-audio fallback is the same items as text descriptions. | B | ~12 |
| 1D rhythm: shift light, clutch bite point, regen blending | shift-points, manual-clutch | `timing-tap` | A one-dimensional bar carries the *timing* concept. It does not carry pedal *feel* (see rejected sim R-1). | B | ~10 |
| **Drive layout in a corner** (`hc-04`, `rv-03`) | understeer, oversteer, drive-layout-handling, weight-transfer | `unity-sim` `cars.handling.drive-layout.v1` | See tier justification below. Spec: `sims/cars.handling.drive-layout.v1.md`. | **A** | 2 lessons, 3 rounds each |

### Tier A justification (CLAUDE.md rubric)

**`cars.handling.drive-layout.v1` (spec `sims/cars.handling.drive-layout.v1.md`).**
- **Signals met:** *Movement over time in space* (a car's path through a corner is a trajectory, and "push" or "tail-out" *are* the difference between the intended and the actual trajectory); *physics is the concept* (friction budget per axle, weight transfer, which axle is driven); *camera perspective* (a top-down view with ghost paths is the only way to see "runs wide" versus "rotates" at once; a side view cannot).
- **Closest native type:** `binary-call` (a diagram with two choices) or `multiple-choice` with a static drawing of arrows. It teaches the *labels* ("understeer = front loses grip") but not the *cause and effect*: that the same corner with the same throttle gives FWD a wide line, RWD a tail-out and AWD a held line, and that lifting or braking mid-corner flips balance by moving weight. Learners who only get the labels regularly misuse them ("it oversteers" said of a wide line). Ghost paths, live grip meters and slow-mo make the cause visible; text does it worse.
- **Why not more?** Everything else about cars fits a diagram, a sequence or a recall card. One sim, isolated to 2 lessons, with a native fallback lesson (`hc-04-native`: three `binary-call` items on a static path diagram plus a `sequence-order` "what happens as she lifts") for accessibility and failure.
- **Justification is strong; Unity retained.**

### Rejected Unity candidates (recorded so nobody re-litigates)

| # | Candidate | Verdict | Reasoning |
|---|---|---|---|
| R-1 | Manual gearbox and clutch feel (stall, bite point, rev-match) | Native | The learner does not need to *drive* stick; she needs to understand that the clutch decouples engine and wheels and that the revs must match. The *feel* of a clutch is force and travel in the left leg; a touchscreen has neither, so a sim would be a fake game (rubric: "Would a fake game be a worse teacher than clear text and a diagram? Native."). Native covers it: `sequence-order` (engage/shift), `timing-tap` for the 1D bite window, `estimate-slider` for revs vs speed, `hotspot-tap` on a diagram. |
| R-2 | EV vs ICE torque delivery (instant torque vs power band) | Native | The concept is a *curve shape*. A static torque chart with `hotspot-tap` and `estimate-slider` teaches it. An animated launch adds spectacle, not understanding. |
| R-3 | How an engine runs (four-stroke, valves, cam) | Native | Order of events; `sequence-order` plus an original diagram. Animated pistons are a nice-to-have (candidate for optional Metal upgrade, not a sim). |
| R-4 | Car meet or show "what would you do" | Native | Judgment about etiquette and social cues: `decision-scenario` with a fact sheet. No spatial or timing component. |
| R-5 | Aerodynamics (downforce, drag, airflow) | Native for now | Would fit the Racing module (`Wake`, `AirflowOverlay`), but the shared Racing module is scoped to NASCAR/F1; a road-car aero sim would be a second tier-A item with weak conversational return. `hc-06` uses annotated diagrams. Revisit if the Racing module is stable and a playtest shows aero is the confusion. |
| R-6 | Braking distance and stopping (physics of speed) | Native | `estimate-slider` covers the magnitudes. Also a sensitive topic (reads like driving safety training). |

---

## 13. Licensing & safety

**Media rights**
- **Imagery (spec section 18, core to the course).** Original illustrations only (license `original-swoond`, canonical id per L-12). Manufacturer photos, press images and logos are *not* used. Three tiers of art:
  1. **Archetypes** (sedan, coupe, hatch, wagon, SUV, pickup, van; convertible, targa; drive layouts; engine layouts). Fully generic, no rights issue.
  2. **Feature callouts** (headlight shapes, rooflines, wheel-well proportions, grille geometry shown as isolated generic shapes, wheelbase and overhang bars). Generic, no rights issue.
  3. **Real-model silhouettes** (for "which one is the Mustang?" items). Original stylized silhouettes drawn from public-domain geometry knowledge, with no logos, badges or trademarked wordmarks; the model name is used nominatively in text. Car body shapes can be protected (design patents, trade dress); these items are **gated on counsel review** before launch (N-1). Until then, tier 3 is replaced by **stylized composites**: invented cars ("the Swoon'd Coupe") that exaggerate the cues of a make (long hood, round lamps, split grille) so the learner learns *cues*, not memorized silhouettes.
- **Logos and trademarks:** No manufacturer logos, badges or wordmark artwork in lesson art. Names are text facts. Brand identity is taught by describing character and cues, not by reproducing marks. In talk tracks and copy, only truthful statements.
- **Audio:** Original synthesized or self-recorded engine and motor notes only; no manufacturer audio, no YouTube audio. Each clip gets a description text alternative.
- **Video:** None embedded; deep-link to organizers' and creators' official pages only.
- **Article text and reviews:** Never copied; links and Swoon'd explainers only (spec section 11). Ratings from third parties (J.D. Power, Consumer Reports) are not reproduced.
- **Data terms:** NHTSA and EPA/DOE data are US government works (check each dataset's terms); DOE AFDC needs an API key and attribution; Open Charge Map requires attribution; commercial valuation data (Kelley Blue Book, Hagerty, Edmunds) needs partner contracts and is not assumed. No scraping of auction sites.
- **Person likeness:** Names as facts only; no likeness. Avoid celebrities' car collections as trivia unless sourced.

**Safety and legality**
- Driving carries real risk; Swoon'd builds *appreciation*, not driving instruction. No content teaches how to drive fast, drift, or race on public roads. Track days and autocross are described as *organized, insured events with safety gear*, never as something to try at speed on the street.
- **Modding:** No how-to for removing emissions equipment (illegal in many jurisdictions), disabling safety systems, or unsafe lifts; scenarios emphasize warranty, insurance, inspection and legality. "Consult a qualified shop."
- **Working on a car:** Never teach lifting a car without stands, high-voltage EV work, fuel handling or airbags. Awareness only, with `safetyNote`.
- **Towing and off-road:** Conservative mainstream guidance; ratings are on the vehicle's placard and owner's manual; trail safety is not taught here. `truck-offroad` requires a qualified safety review before release (aligned with D-017).
- **Fire and battery safety:** Neutral facts, no fear-mongering, no "EVs explode" or "gas cars are safe" claims without cited context.
- **Driver-assist:** Level descriptions only; never imply hands-off driving. Copy states that current consumer systems require an attentive driver.
- **Money:** Buying and financing lessons explain trade-offs and are not financial advice.
- **Social:** Meet etiquette scenarios teach de-escalation and respect; no glorifying street takeovers, intimidation, or recklessness. The premise is common ground, never faking ownership or expertise.

---

## 14. Content assets

| Asset | Count (launch) | Procedural or licensed | Source |
|---|---|---|---|
| Archetype illustrations (body styles, roof types, layouts, engine placement) | ~45 | Original vector | In-house, `original-swoond` |
| Feature callout illustrations (lamp shapes, rooflines, sidewall, VIN plate, wheel/tire parts) | ~50 | Original vector | In-house |
| Diagrams (engine cutaway, four-stroke, drivetrain, EV pack, charging ports, off-road angles) | ~35 | Original vector, `diagramId`s consumed by `hotspot-tap` | In-house |
| Stylized composite cars (make-cue teaching) | ~24 | Original vector | In-house |
| Real-model silhouettes | 0 at launch; up to ~60 after N-1 review | Original vector | In-house after counsel review |
| Audio (engine notes, EV whine, DCT shift, turbo, exhaust) | ~30 clips | Original synthesized | In-house |
| Sim: procedural car models, corner, arrows, gauges | procedural | Procedural in Unity | Astra, see sim spec |
| Icons | line, 1.5 px | Original | Design system |

Every image and audio asset carries `license: original-swoond` (canonical; L-12).

---

## 15. Section 47 quality checklist

- [x] 1. What does a beginner need to understand? Sections 2-3: the power path, torque vs horsepower, drive layouts, body-style words, ICE/hybrid/EV, and how to read a car.
- [x] 2. What do enthusiasts care about? Section 4: generation, engine family, feel, mods, matching numbers, the debates.
- [x] 3. What current information matters? Section 6: new models, recalls, EV market and policy, events, import rule list, gas prices.
- [x] 4. What should be interactive? Section 12: recognition (`visual-id`, `hotspot-tap`), mechanism (`sequence-order`), judgment (`decision-scenario`), and one sim (drive layout in a corner).
- [x] 5. What should NOT be gamified? Section 5: driving skill, safety work, money decisions, rankings of makes, mod optimizers.
- [x] 6. How should it personalize? Section 8: brand, style (scene), region.
- [x] 7. What does conversational competence look like? Sections 9-10.
- [x] 8. What data providers are needed? Section 6 and `live-data.md`.
- [x] 9. What licensing constraints apply? Section 13.
- [x] 10. How will Swoon'd measure useful understanding? Section 10 (concept mastery 0.8, talk-track smoothness, spaced review).

Additional gates: [x] manifest validates (`node validate.mjs --course cars --partial`); [ ] curriculum validates (not authored yet); [x] every Unity sim has a spec (1); [ ] every image/audio asset has a licence id (assets not produced yet); [x] voice review by author (cheeky coach, never mean, never about the crush); [x] no copied publisher text; [ ] counsel review of tier-3 silhouettes (N-1); [ ] safety review of `truck-offroad` (D-017).

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Counsel review: are original stylized silhouettes of real models acceptable (nominative use, design-patent and trade-dress risk), or must all real-model items use composites? | Product / legal | Blocks tier-3 art only |
| 2 | Illustration production: in-house vs commissioned for ~150 original assets and the composite set. | Product | Blocks asset production, not curriculum |
| 3 | Are all six branches launch-scale, or launch four (v1.1 for `truck-offroad` and `classic-collector`)? Proposed: launch four. | Product | No |
| 4 | Editorial provider for automotive news (link-only headlines) and licensing (L-01 / Q-3). | Product | Blocks `now-in-cars` news cards only |
| 5 | Units and plug defaults by region (US mpg/NACS vs UK/EU L/100 km and Type 2/CCS2). Proposed: US default with alternates in text. | Product | No |
| 6 | Who owns the yearly model-year sweep and the January 25-year list refresh? (P-15) | Product | No |
| 7 | Is `hc-04` clearly better than native `binary-call` on static path diagrams (analogous to P-09 for football routes)? Proposed: playtest; downgrade if not clearly better. | Product / Astra | No |
