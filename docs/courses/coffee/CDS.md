# Course Design Specification: Coffee (`coffee`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Coffee is an **appreciation-and-technique course with no scoreboard**: it teaches where coffee comes from, what roasting and processing do to flavor, why a brew tastes sour or bitter (extraction), how to read a café menu, and how the specialty scene talks. The learner is learning because someone they care about loves coffee; the goal is to understand her morning ritual and her obsessions, not to fake a barista's résumé.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 3 |
| Author / date | Coffee course design agent (Claude), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion docs | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity sims, justified in section 5 and section 12) |

Verification note: time-sensitive facts were checked by web search on **2026-09-30**: SCA Golden Cup Standard numbers (55 g/L plus or minus 10 percent, 200 F plus or minus 5 F water, TDS 1.15 to 1.35 percent, extraction yield 18 to 22 percent), the 2025 World Barista Champion (Jack Simpson, Australia, Milan), the 2026 World Barista Championship (Panama City, 22 to 25 October 2026), EU Deforestation Regulation application date (30 December 2026 after two postponements), and recent arabica price history (record about 4.38 USD/lb in October 2025; about 2.88 USD/lb on 30 September 2026). Anything marked **[verify at release]** must be re-checked before content ships; time-sensitive facts appear only on dated `live` cards, never in evergreen lessons.

---

## 1. Identity
- **Course ID:** `coffee` (immutable)
- **Display name:** Coffee
- **Category / family:** Food & Cooking; category path `Food & Cooking > Coffee`
- **Simulation prefix:** `coffee` (reserved; **no sims are planned**, so no `coffee.<topic>.<name>.vN` id exists)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns coffee, are they meaningfully conversationally competent about it?" | Verdict | Consequence for structure |
|---|---|---|---|
| Cooking (`cooking`, Wave 2) | Barely. Both involve heat and taste, but grind, ratio, extraction, origins and café culture are their own language. A cook is not a coffee person. | Adjacent, independent | No cooking content here beyond the shared habit of tasting. Cross-link `cooking` concepts `maillard-reaction` (roasting is Maillard browning of the bean), `acid-brightens` and `taste-adjust-loop` (dialing in is the same tasting loop), and `weight-vs-volume` (why a scale beats a scoop). |
| Wine (`wine`, Wave 3) | Partly: tasting vocabulary (acidity, body, finish, terroir, variety, processing vs winemaking) rhymes, but grapes, vintages and appellations do not transfer. | Adjacent, independent | Cross-link only. The `tasting` unit teaches coffee descriptors; a "if she also likes wine" callout points to the wine course once it exists. No pairing or alcohol content here (except a neutral mention that "coffee in spirits" cocktails exist; see section 13). |
| Tea (not a catalog course) | Partly: both are brewed extractions, but tea has its own cultures, cultivars and methods. | Adjacent | Out of scope; tea is not mentioned except as a contrast in `brewing-is-extraction` if it helps. |
| Baking / cooking with coffee | No. | Independent | Covered only if the learner asks; not a unit. |
| Nutrition, caffeine and health | No. Health claims are out of scope. | Out of scope | Swoon'd makes **no health or caffeine-benefit/risk claims**; `caffeine-basics` is neutral and factual (section 13). |
| Cafés, hospitality and food media | Partly: café culture and menu literacy are how most people meet coffee. | Shares foundation | Covered in the `cafe-menu` and `third-wave` units; no separate course. |
| Sustainability / trade | Partly: how coffee is sourced is part of modern coffee talk. | Shares foundation | Covered as the `sustainability` unit. Balanced: certifications and direct trade are explained with their limits and critiques; no brand shaming. |

- **Branches.** Two axes that the learner's Person can hold independently (one **brew-method** branch, one optional **origin** branch; see `NOTES_FOR_ORCHESTRATOR.md` #2). `everyday` is the default and has no branch-only unit because the shared core units already serve a drip-and-daily-cup drinker.

| id | Name | What changes (technique, gear, culture) |
|---|---|---|
| `everyday` | Everyday cup (default) | Drip machine, a good bag, a daily mug; ordering at cafés. The shared core units are its curriculum. |
| `espresso` | Home espresso | Machine tiers, dose/yield/time, puck prep, dialing in, milk steaming, latte art, espresso-machine safety. Personalizes by `equipment`. |
| `pour-over` | Pour-over | V60, Kalita, Chemex; bloom, pours and agitation; recipe structure; filter choices. Personalizes by `format`. |
| `immersion` | Immersion and cold | French press, AeroPress, cold brew; steep time, filtration, cold-brew storage safety. Personalizes by `format`. |
| `africa` | Africa and Arabia origins | Ethiopia (the birthplace of arabica), Kenya, Rwanda and Burundi, Yemen; washed vs natural in the homeland, floral and berry profiles. Personalizes by `region`. |
| `latin-america` | Latin America origins | Colombia, Brazil, Costa Rica, Guatemala, Panama (Geisha); from chocolatey Brazil naturals to high-grown Central American washed coffees. Personalizes by `region`. |
| `asia-pacific` | Asia-Pacific origins | Indonesia (wet-hulling), Papua New Guinea, India (monsoon), Vietnam (robusta), Yunnan; earthy, herbal, low-acid profiles and what "low acid" really means. Personalizes by `region`. |

**No "best origin", no roast ranking, no coffee-snob scorekeeping:** branch units teach how a place or method works and how its fans talk, not which is better.

## 2. Beginner model
- **What a complete beginner typically knows:** coffee is a morning habit; it comes as "light, medium, dark" or "regular, decaf"; café menus have Italian words; espresso is "strong"; coffee comes from "beans"; a fancy cup is expensive. They may know a drip maker, a pod machine and a café chain's sizes. They believe dark means strong, that bitter is simply what coffee tastes like (hence the sugar and milk), and that a friend who buys "single-origin" is being precious.
- **Terminology that will initially confuse them:** single-origin, blend, washed, natural, honey, anaerobic, heirloom, Geisha, Bourbon, SL28, altitude, microlot, light roast, first crack, degassing, roast date, bloom, pour-over, V60, Chemex, AeroPress, French press, moka pot, cold brew, espresso, ristretto, lungo, doppio, cortado, flat white, macchiato, crema, portafilter, puck, tamp, channeling, dose, yield, ratio, TDS, extraction, under- and over-extracted, dial in, burr grinder, conical, flat, gooseneck, WDT, RDT, cupping, acidity, body, finish, SCA score, C price, direct trade, Fair Trade.
- **Common misconceptions (each is a lesson target):**
  1. "Coffee beans are beans." (They are seeds of a fruit, the coffee cherry. `seed-not-bean`.)
  2. "Dark roast is stronger, and has more caffeine." (Roast level is flavor, not strength; by scoop dark is slightly less dense, by weight caffeine is roughly similar. `dark-is-stronger-myth`.)
  3. "Bitter is normal; coffee is meant to be bitter." (Good coffee is sweet and balanced; harsh bitterness is often over-extraction or over-roasting. `bitter-astringent`, `acidity-good`.)
  4. "Acidic means sour or bad for you." (Acidity in tasting is brightness, like a crisp apple; sourness is an under-extraction fault; no health claim is made either way. `acidity-vs-sourness`.)
  5. "Espresso is a kind of bean or roast." (It is a method: fine grind, pressure, short contact time. `espresso-not-roast`.)
  6. "Crema means a good shot." (Crema is gas and oils; it depends on freshness and roast and is not a quality guarantee. `crema-myths`.)
  7. "Boiling water is best." (Boiling scorches and over-extracts; roughly 195 to 205 F is the target. `water-temp-range`.)
  8. "A blade grinder is fine." (It produces uneven boulders and dust, which extract unevenly. `burr-vs-blade`.)
  9. "Fair Trade means farmers get rich." (It is a floor price plus premiums with real limits, and certifications are debated. `fair-trade`, `cert-limits`.)
  10. "Honey process has honey in it." (It is the sticky fruit mucilage left on the seed. `honey-no-honey-myth`.)
  11. "Decaf has no caffeine." (Most caffeine is removed, not all. `decaf-basics`.)
  12. "Fancy coffee is just snobbery." (Sometimes the vocabulary is, but differences in origin, processing and roast are real and tasteable. `taste-is-personal`.)
  13. "A flat white is a small latte." (Both are espresso and milk; the ratio, texture and cup size differ by place. `cappuccino-latte-flat-white`.)
  14. "Crema, ristretto, lungo are fancy words for strong." (They are yield and ratio: a lungo is longer, a ristretto shorter. `doppio-ristretto-lungo`.)
- **Concepts that unlock the rest (become foundation units):** what a coffee actually is (seed, species, specialty vs commodity), origins and varieties, processing, roast levels, and the four brewing variables that explain every cup: grind, ratio, temperature, time, and therefore extraction.

## 3. Foundational knowledge
Grouped into modules (these are the manifest `foundationalModules[]` and the five foundation units):

- **`coffee-basics` What Coffee Actually Is.** The coffee cherry and seed; arabica vs robusta (and the minor species); the coffee belt and growing conditions; commodity vs specialty grade; a neutral, health-claim-free lesson on caffeine and decaf.
- **`origins` Origins and Varieties.** Reading a bag (origin, region, farm, variety, process, altitude, roast date); Ethiopia as the homeland; Kenya and East Africa; Colombia and Central America; Brazil; Indonesia and Asia-Pacific; varieties (Typica, Bourbon, Caturra, SL28, Geisha) and how variety differs from origin.
- **`processing` Processing.** Harvest and selective picking; washed (clean, bright), natural (fruity, funky), honey (between), anaerobic and other experimental processes and the debate about them; what process does to taste.
- **`roasting` Roast Levels.** What roasting is; light, medium, dark and the flavor spectrum; first and second crack; roast myths; filter roast vs espresso roast; freshness, degassing, roast date and storage.
- **`brew-basics` Grind, Ratio, Temperature, Time.** Brewing as extraction; weighing; ratio; grind size; water temperature; contact time; water quality; fresh grinding; and hot-water and equipment safety.

The full concept list is in the Appendix of section 11.

## 4. Enthusiast model
- **What enthusiasts actually talk about:** the bag in her hands ("this is a washed Ethiopian, Guji, it tastes like blueberry tea"), the brew ("I changed my grind two clicks finer and the sour went away"), gear ("I upgraded to a flat-burr grinder", "the espresso machine has a PID"), a café she loves ("they pull a great cortado"), a roaster's new release, a competition result, a trip ("I visited a farm in Colombia"), and the economics ("a fair price to the farmer"). Many also talk about *ritual*: the quiet ten minutes with a scale and a kettle.
- **Distinctions that matter to them:** origin and variety; processing; roast development (light vs dark); freshness (roast date, not "best by"); grinder quality; water; ratio and recipe; washed vs natural clarity; filter vs espresso coffees; milk texture; the difference between "strong" and "well extracted".
- **Knowledge that signals genuine understanding:** saying "sour means under-extracted, bitter means over-extracted" with the nuance that roast level and robusta also produce bitterness; knowing you change one variable at a time; asking about roast date; knowing that a finer grind slows the flow and raises extraction; distinguishing acidity from sourness; asking about the grinder before the machine.
- **Beginner statements that sound obviously uninformed:** "Dark roast is stronger", "I like my coffee strong so I'll get espresso, it has more caffeine" (per serving it often has less than a large drip), "crema means it's good", "is that just... fancy coffee?", "is decaf caffeine-free?", "it's just expensive beans", "I'll have a large espresso".
- **Common controversies and debates:** light vs dark roast ("sour third-wave coffee" vs "burnt chain coffee"); is a grinder more important than an espresso machine (mostly yes); flat vs conical burrs; is bloom necessary; WDT and RDT; does pre-infusion matter; water recipes (Third Wave Water, Barista Hustle, home mineral recipes) vs "just use filtered"; super-automatic espresso machines; capsules and sustainability; anaerobic and other experimental processing as innovation or hype; Geisha prices; Fair Trade vs direct trade vs "just pay more"; single-dosing; whether latte art matters to taste; whether the specialty scene is gatekeeping.

## 5. Interaction model
- **What should the learner EXPERIENCE instead of reading?** Diagnosing a cup from a fact sheet ("my espresso is sour, shot ran 18 seconds, grinder set coarse: what now?"); ordering the steps of a pour-over and seeing *why* each step goes there; estimating a ratio, temperature or brew time; recognizing grind sizes, roast levels, processing stages and drink builds from procedural diagrams; tapping the right place on an espresso-machine or V60 diagram; hearing steam-wand stretching, a rolling boil, a shot pouring; matching tasting terms to meanings; rehearsing real conversations ("I got a washed Ethiopian, what do you think?").
- **Does the course warrant a Unity simulation? No. Zero sims.** The Tier rubric (`CLAUDE.md` section 4) requires that spatial reasoning, movement, physics, timing in a scene or camera perspective *materially* improve learning **and** that a native exercise would teach it clearly worse. Every coffee concept was tested against that rubric (table below). The honest result is that coffee's hard parts are (a) **cause-and-effect reasoning** (finer grind, slower flow, more extraction), (b) **diagnosis from taste and numbers** (sour vs bitter), (c) **vocabulary and recognition** (origins, processes, drinks), and (d) **culture and ethics**. Those are what `decision-scenario`, `estimate-slider`, `sequence-order`, `visual-id`, `hotspot-tap`, `term-match`, `say-this` and `talk-track` are for. The motor skills (tamping, pouring, steaming, latte art) cannot be learned from a phone at all.

**Unity candidates considered and rejected (rigorous, one row each):**

| Candidate sim | Rubric signal it appears to meet | Why native is as good or better | Additional reason it would be harmful or fake |
|---|---|---|---|
| Espresso extraction flow (water through a puck, channeling, flow vs grind), e.g. `coffee.espresso.extraction-flow.v1` | Physics, movement over time, camera perspective (strongest candidate) | The teachable content is a small causal rule set: finer grind or more dose raises resistance and slows flow; uneven puck prep makes channels; channels give sour and bitter at once. A `decision-scenario` with a fact sheet (dose, yield, time, taste) teaches the *decision*; a static puck cross-section `hotspot-tap` plus `sequence-order` for puck prep teaches the geometry; `estimate-slider` teaches the numbers. A particle sim adds motion but no decision. | A plausible-looking simulation would need a validated percolation model. Real extraction depends on bean density, roast, water chemistry, pressure profile and basket geometry. A simplified model produces false precision and "the sim said so" over tasting the cup. **Rejected.** |
| Pour-over pouring game (control kettle flow, spiral, bloom), e.g. `coffee.pour-over.pour-control.v1` | Movement, timing in a scene | The concepts are recipe structure and effects (bloom releases gas, agitation raises extraction, pour rate affects contact time) taught by `sequence-order` with a `why` per step and `decision-scenario` ("the brew drained in 1:40: what changes?"). The motor skill (steady gooseneck pour) is not transferable through a touchscreen swipe. | A scored pouring game rewards a motor skill that does not exist on a phone and invites "perfect pour" thinking, contradicting the course's message that taste decides. **Rejected.** |
| Grind-size particle distribution explorer | Spatial, visual | A static diagram series (`visual-id` for grind sizes; `hotspot-tap` for fines vs boulders) plus a `decision-scenario` teaches why uniformity matters. Distribution is a chart, not a scene. | Pure decoration; a slider that shows circles is not a decision. **Rejected.** |
| Milk steaming and latte art | Motion, timing, sound | Steam-wand positions and stages are `sequence-order` and `hotspot-tap`; the sound of stretching vs texturing is `listening-id`; milk temperature is an `estimate-slider`. Pouring latte art is a motor skill. | Fake haptics; risk of trivializing steam burns. **Rejected.** |
| Roast profile (time vs temperature curve, first crack) | Timing over time | A static roast-curve diagram with `hotspot-tap` (first crack, development time) and `sequence-order` for stages; `estimate-slider` for temperatures. The learner is not roasting. | A roasting game implies the learner should roast, and misleads on real-world roaster safety and variability. **Rejected.** |
| Coffee belt and origin map explorer | Spatial reasoning | A procedural map diagram with `hotspot-tap` (tap Ethiopia, Colombia, Indonesia) plus `visual-id` and `term-match`. The map is static; no camera perspective matters. | Geography trivia does not build the conversational competence the course is for. **Rejected.** |
| "Stop the shot" timing mini-game | Timing | A one-dimensional timing problem: `timing-tap` covers it, and lightly (slow mode always on), for "stop the shot at a 1:2 ratio". No scene needed. | Not a sim; stays native. **Not Tier A.** |
| Café barista rush / order-taking game | Timing in a scene | `talk-track` and `decision-scenario` ("three drinks ordered: which to pull first?"). | Gamifies stress; this course's voice is warm; encourages disrespect to baristas. **Rejected.** |
| Farm-to-cup supply chain tycoon | Systems, spatial | `sequence-order` (cherry to cup), `decision-scenario` ("which premium supports quality?") and editorial. | Trivializes farmers' livelihoods and reduces a human system to a game; conflicts with the course's ethical note. **Rejected.** |

- **Verdict:** `interactionTypes` uses only native types (all 13; `unity-sim` is not used; see section 12); `unitySimulations` is `[]`; there is no `sims/` folder. If playtests show a specific concept cannot be taught natively, the correct route is a numbered open question in `NOTES_FOR_ORCHESTRATOR.md` naming the concept, the failing native design and the rubric signal, not a speculative sim.
- **What should NOT be gamified:** caffeine and any health or "healthy coffee" content; hot-water, steam and machine safety (no timing pressure, no streaks); farmers, wages and trade (no tycoon framing, no shaming a brand or buyer); her taste ("never grade what she likes"); roast or origin ranking; latte art as a performance; milk alternatives and allergens (ask first, read labels).
- **Chosen mix:** roughly 100% native: `multiple-choice` (default), `decision-scenario` (the judgment engine: "my espresso is sour, what now?"), `estimate-slider` (ratios, temperatures, times, yields: the course's numerical spine), `sequence-order` (brewing processes, supply chain), `visual-id` and `hotspot-tap` (grind sizes, roast levels, drink builds, machines, maps), `term-match`, `fill-the-gap`, `say-this`, `talk-track`, `binary-call` (sour or bitter, true or myth), `listening-id` (steam, pour and grinder sounds; used lightly), `timing-tap` (used sparingly: stop the shot, end the bloom). Details in section 12.

## 6. Dynamic information requirements
Coffee is an evergreen-knowledge course. Spec section 10: "Do NOT invent artificial live data requirements." The honest verdict is a **thin live layer**:

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| scores, standings, rosters, injuries, transactions | **No** | No league data educates a coffee friend. (Competitions are discussed as events.) | none | n/a | n/a |
| conditions (harvest calendar) | **Yes, light** | "What is fresh now?" Northern and Southern hemisphere harvests and arrival windows change by month. | Swoon'd editorial harvest table, curated from ICO and SCA public information | monthly | Static harvest-calendar card |
| events | Modest | World Coffee Championships (WBC, Brewers Cup, Latte Art), World of Coffee, SCA Expo, local roaster events | Curated editorial calendar; event pages link-only | seasonal | Evergreen "what is a championship" lesson |
| statistics (price explainers) | Light | "Why is coffee so expensive right now?" an explainer of the C price and why it moves, dated | ICO monthly composite indicator (public), editorial; ICE futures data only if licensed (not assumed) | monthly | Evergreen `c-price` lesson |
| regulations | Light | EU Deforestation Regulation and similar rules affecting sourcing | European Commission pages (link-out), editorial explainer | as changes | Evergreen lesson |
| news | Light | "Why is everyone talking about X?" (frost, price spikes, a record Geisha auction, a competition winner) | Publisher headlines link-only; ICO and SCA news link-out | weekly | Evergreen explainers |
| new-products / releases | Modest | Roaster seasonal releases, notable gear launches | Curated editorial only; no price feed | monthly | Hidden |
| rankings | **No** | "Best coffee" lists are marketing and taste-dependent | none | n/a | n/a |
| weather, alerts, closures | **No** | Not relevant (frost and drought appear as news explainers, not feeds) | none | n/a | n/a |

Structured data (harvest calendar, events, regulations) and editorial data (news, culture) are separate systems. Details, licensing, normalized entities and personalization hooks: `live-data.md`.

## 7. Editorial context
- **What commentary helps?** "Why is everyone talking about coffee prices?", "what does it mean when a roaster says the new Ethiopian is in?", "what did the new world champion do differently?", "what is this EU rule everyone mentions?", "what is this trend (anaerobic, single-dosing, a new grinder) and is it hype?"
- **Appropriate external sources:** SCA (Specialty Coffee Association) and World Coffee Championships pages, ICO (International Coffee Organization), European Commission pages, FAO and peer-reviewed or university sources for agronomy, trade publications (Sprudge, Perfect Daily Grind, Daily Coffee News, Barista Magazine, Global Coffee Report, Coffee Review) and roaster pages **link-only**.
- **Summarize, explain or link?** Explain in Swoon'd's words and link. Publisher articles, SCA standards text, photographs and competition routines are never copied or redistributed (spec section 40). Swoon'd cites standards as facts (for example, "the SCA's Golden Cup Standard suggests about 55 grams per liter") and teaches the idea, not the document.
- **Example prompts:** "Why is her feed full of people arguing about [dark roast / grinders / Geisha]?", "What does 'washed Ethiopian, Guji' on the bag mean?", "What is a world barista champion's routine about?", "What is the C price and why does it jump?", "What should I ask about her new grinder?"

## 8. Personalization
| Dimension | How it changes examples and live context | Default when unset | Units using tokens |
|---|---|---|---|
| `region` (origin country or region she loves, e.g. Ethiopia, Colombia) | Which origin branch unit shows; examples and harvest card ("Sara's favorite: `{{origin}}`") | `a single-origin coffee` (no origin branch) | `origins`, origin branch units, `now-in-coffee`, `conversation-lab` |
| `format` (brew method she uses: espresso, pour-over, immersion, drip) | Which brew-method branch shows; diagnostic examples use her method | `your usual brew` (branch `everyday`) | `methods`, `extraction`, brew-method branch units, `conversation-lab` |
| `equipment` (grinder, machine, kettle) | Gear talk, what to ask about, dial-in examples | `a good grinder and a scale` | `gear-and-debates`, `espresso-and-milk`, `branch-espresso` |
| `skill-level` | Depth of explanations; whether tips assume a scale, refractometer or espresso machine | `home brewer` | `brew-basics`, `extraction`, `conversation-lab` |
| `style` (daily-cup drinker, café regular, home barista, specialty nerd) | Emphasis: menu literacy vs recipes vs culture | `daily-cup drinker` | `cafe-menu`, `third-wave`, `conversation-lab` |
| `brand` (her favorite roaster or café, optional) | Named in examples as a fact; live events for that roaster only if a public calendar exists | `a local roaster` | `third-wave`, `now-in-coffee` |

Tokens: `{{origin}}`, `{{brewMethod}}`, `{{equipment}}`, `{{skillLevel}}`, `{{style}}`, `{{roaster}}`. Every authored sentence must read correctly with the default substituted. Personalization never requires personal data beyond the Person's stated coffee preferences and gear. (Origin uses the `region` dimension until a dedicated `origin` value exists; see NOTES #1.)

## 9. Conversation model
**Example enthusiast lines (12+), each with meaning and what to ask next:**

| # | She says | Means | Implied terms | A good next question |
|---|---|---|---|---|
| 1 | "This is a washed Ethiopian, Guji. It tastes like blueberry tea." | A clean-tasting coffee from the Guji zone in southern Ethiopia, with a fruity, floral, light-bodied profile | washed, Ethiopia, heirloom, tasting notes | "Is that floral thing the Ethiopian signature, or just this one?" |
| 2 | "My espresso is running sour." | Shot is under-extracted: too fast, too coarse, or too cool | sour, under-extraction, dial in, grind | "Are you going finer or changing the dose?" |
| 3 | "I dialed in a new bag this morning." | She adjusted grind and recipe until the new coffee tasted good | dial in, dose, yield, taste | "How many shots did it take?" |
| 4 | "I'm obsessed with my new flat-burr grinder." | Gear upgrade for evenness of grind | flat burrs, grind uniformity | "What did it change in the cup?" |
| 5 | "The roast date is three weeks ago, so it's just hitting its stride." | Beans have rested and degassed, so extraction is more even now | roast date, degassing | "How long do you like to rest filter vs espresso?" |
| 6 | "Natural processed, so a bit funky." | Dried in the fruit: jammy, winey, sometimes fermenty | natural, cherry, funk | "Do you like the funky ones, or prefer washed?" |
| 7 | "A 1:16 ratio, 94 degrees, bloom for 40 seconds." | A pour-over recipe: one part coffee to sixteen of water, at 94 C, with a 40 second bloom | ratio, bloom, temperature | "What do you change first if it tastes flat?" |
| 8 | "I'll have a cortado." | A small espresso drink cut with about equal warm milk | cortado, espresso, milk ratio | "Is that your usual, or are you a flat white person?" |
| 9 | "Light roast is better." or "Dark roast is burnt." | A debate position | roast levels, acidity, development | "What do you taste in a light roast that you miss in a dark one?" |
| 10 | "I only buy direct trade." | She prefers sourcing with transparency about farm-gate prices | direct trade, traceability | "How do you know it's direct, versus just marketing?" |
| 11 | "Geisha is overrated but it's pretty." | She finds an expensive variety delicate and floral and is skeptical about the price | Geisha, variety, price | "What is the most memorable Geisha you've had?" (only if she has had one) |
| 12 | "I channel every second shot." | Water is finding a path through the puck, giving uneven extraction | channeling, puck prep, WDT | "Do you use a needle tool to stir the grounds?" |
| 13 | "The cupping scored an 86." | A professional tasting gave an SCA-style score; 80+ is "specialty" | cupping, SCA score | "What stood out in it?" |
| 14 | "Cold brew concentrate, then dilute." | Long, cold steep gives a concentrate that is diluted for drinking | cold brew, ratio, dilution | "How long do you steep it?" |

- **How Swoon'd helps without encouraging fake expertise:** every `say-this` carries a `noFakeExpertNote`; `talk-track` replies rate *curiosity*, *honest gaps* and *offering to try* highest; the coach never scripts a claim like "I taste the blueberry notes". The most valuable skills are asking about *her* process ("what did you change?") and telling the truth ("I can make drip; teach me pour-over").
- **Target number of talk tracks and say-this items:** 18 talk tracks at launch (10 standalone Talk-tab scenarios plus unit-end tracks), about 70 `say-this` items.

## 10. Assessment
- **How useful competence is determined:** concept mastery 0..1 per Playbook concept, driven by native exercise outcomes and spaced review (`concept-mastery-v1`); `decision-scenario` scores best/acceptable/poor; conversation via talk-track Smooth >= 60. A **safety gate**: the hot-water, steam and equipment safety concepts (`hot-water-safety`, `steam-safety`, `milk-temperature-safety`, `cold-brew-safety`, `moka-pot-safety`) must be mastered (>= 0.8) before the course reports the brewing units as "Mastered".
- **Recognize:** origins and their flavor tendencies, processing methods, roast levels, grind sizes, brewing tools, espresso drinks and their builds, common tasting descriptors.
- **Understand:** why extraction explains sour and bitter; why a finer grind slows flow; why weight beats volume; why roast date matters; why processing changes flavor; why a grinder is the keystone; what certifications do and do not guarantee.
- **Explain (in a sentence, to her):** "I get that a shot that runs fast and tastes sour is under-extracted, so you go finer." / "Natural processing dries the fruit on the seed, so it's fruitier." / "Dark roast isn't stronger, it's just a different flavor."
- **Correctly interpret:** "dial in", "1:2 in 28", "bloom", "washed Ethiopian", "it's channeling", "84 points", "single-dosing", "a 4:6 method".
- **Mastery model:** pass threshold **0.8**. **Useful competence statement:** "She can talk about her coffee, understand why it tastes the way it does, order with confidence, ask a couple of good questions about origin or brewing, and say 'okay, I get why you love this' without faking it."

---

## 11. Curriculum map (ongoing course)

Designed as an ongoing course. **22 units, 120 lessons, 259 Playbook concepts** (exact count in the Appendix). The unit count exceeds the 8-14 guidance for the same reason as cooking (layer minimums of 5 foundation + 4 intermediate + 4 enthusiast, plus six branch units, live, conversation and review); a learner sees about 15 units (core 13 plus the matching brew-method and origin branch units, live, conversation, review). Ship in phases (release plan below); fold option in `NOTES_FOR_ORCHESTRATOR.md` #3.

Activity abbreviations: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap. Every lesson lists 4+ planned activity families; no lesson uses a Unity sim.

| Layer | Purpose | Units | Lessons |
|---|---|---|---|
| Foundations | What coffee is, origins, processing, roasting, the four brewing variables | 5 | 34 |
| Intermediate | Brew methods, extraction and troubleshooting, espresso and milk, tasting | 4 | 30 |
| Enthusiast depth | Café and menu culture, the specialty scene, gear and debates, sustainability | 4 | 26 |
| Branches | Espresso, pour-over, immersion and cold; Africa, Latin America, Asia-Pacific origins | 6 | 15 |
| Current-season / live | Harvest calendar, price explainer, news and regulations, championships | 1 | 4 |
| Conversation practice | Talk tracks and say-this | 1 | 7 |
| Perpetual review | Spaced review | 1 | 4 |

### Layer 1: Foundations

**Unit `coffee-basics`: What Coffee Actually Is** (prereq: none). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cb-01` | From cherry to cup | Explain that coffee is the seed of a fruit and order the journey from farm to cup. | coffee-cherry, seed-not-bean, coffee-supply-chain | so, mc, vi, st |
| `cb-02` | Arabica and robusta | Tell the two main species apart and what each is known for. | arabica-vs-robusta, species-flavor | mc, tm, bc, st |
| `cb-03` | What is in your cup | Know that a cup is about 98 to 99 percent water and that brewing dissolves a little coffee. | coffee-is-mostly-water, coffee-solubles | mc, es, fg, ds |
| `cb-04` | The coffee belt | Place the coffee belt and say why altitude and climate matter. | coffee-belt, growing-conditions | ht, mc, tm, st |
| `cb-05` | Commodity and specialty | Explain what "specialty grade" means and why it is not just a price tag. | commodity-vs-specialty, specialty-grade | mc, bc, ds, st |
| `cb-06` | Caffeine, plainly | State neutral facts on caffeine and decaf, with no health claims. | caffeine-basics, decaf-basics | mc, bc, fg, st |

**Unit `origins`: Origins and Varieties** (prereq: `coffee-basics`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `or-01` | Reading a bag | Decode a specialty bag label: origin, farm, variety, process, altitude, roast date. | bag-label-literacy, single-origin-vs-blend, microlot | vi, tm, mc, st |
| `or-02` | Ethiopia: where coffee began | Describe Ethiopia's heirloom coffees and the floral, fruity profile fans expect. | ethiopia-heirloom, origin-flavor-tendencies | mc, ht, st, ds |
| `or-03` | Kenya and East Africa | Recognize Kenya's juicy, blackcurrant-like acidity and the SL28 and SL34 varieties. | east-africa-profile, sl28-sl34, kenya-grading | mc, tm, bc, st |
| `or-04` | Colombia and Central America | Describe sweet, balanced Colombian and Central American washed coffees and altitude's role. | colombia-profile, central-america-profile, altitude-and-density | mc, ht, es, st |
| `or-05` | Brazil, the giant | Explain Brazil's scale, natural processing and chocolatey, nutty profile. | brazil-profile, brazil-natural | mc, bc, tm, st |
| `or-06` | Indonesia and Asia-Pacific | Recognize earthy, low-acid profiles and the idea of wet-hulling. | indonesia-wet-hulled, asia-pacific-profile | mc, ht, bc, st |
| `or-07` | Varieties: Typica to Geisha | Separate variety from origin and name the famous varieties. | coffee-varieties, geisha, variety-vs-origin | tm, mc, ds, st |

**Unit `processing`: Processing** (prereq: `coffee-basics`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `pr-01` | Picking and the cherry | Describe ripe cherry, selective picking and the mucilage layer. | harvest-picking, mucilage | vi, mc, so, st |
| `pr-02` | Washed | Explain washed processing and the clean, bright cup it gives. | washed-process, clean-bright-profile | so, mc, bc, st |
| `pr-03` | Natural | Explain natural processing, why it tastes fruity and why drying must be careful. | natural-process, fruity-funky-profile, drying-and-defects | so, mc, ds, st |
| `pr-04` | Honey and pulped natural | Explain honey processing without the honey myth. | honey-process, honey-no-honey-myth | mc, bc, tm, st |
| `pr-05` | Experimental processing | Understand anaerobic and other experimental processing and the debate. | anaerobic-fermentation, experimental-debate | mc, ds, bc, st |
| `pr-06` | Taste the process | Predict how a process changes the cup and separate process from origin. | process-flavor-map, process-vs-origin | tm, mc, ds, st |

**Unit `roasting`: Roast Levels** (prereq: `coffee-basics`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ro-01` | What roasting does | Explain that roasting turns green coffee into the brown, aromatic bean. | green-coffee, roasting-basics | so, mc, vi, st |
| `ro-02` | Light, medium, dark | Place roast levels on a flavor spectrum. | roast-levels, roast-flavor-spectrum, roast-color-vs-flavor | vi, mc, tm, st |
| `ro-03` | First crack, second crack | Describe the two cracks and development time. | first-crack, second-crack, development-time | ht, so, mc, li |
| `ro-04` | Roast myths | Debunk "dark is stronger" and "oily beans are fresh". | dark-is-stronger-myth, oily-beans | bc, mc, ds, st |
| `ro-05` | Filter roast, espresso roast | Explain that these are roaster's choices, not different beans, and what omni-roast means. | filter-vs-espresso-roast, omni-roast | mc, tm, ds, st |
| `ro-06` | Fresh coffee | Read a roast date and explain degassing, staling and storage. | roast-date, degassing, staling-and-storage | es, mc, ds, st |

**Unit `brew-basics`: Grind, Ratio, Temperature, Time** (prereq: `coffee-basics`). 9 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bb-01` | Brewing is extraction | Explain that brewing dissolves flavors from grounds into water. | brewing-is-extraction, extraction-yield-basics | mc, so, fg, st |
| `bb-02` | Weigh it | Know why a scale beats a scoop and what dose and yield mean. | coffee-scale, dose-and-yield | mc, es, ds, fg |
| `bb-03` | Ratio | Express a brew as a ratio and estimate common ones. | brew-ratio, golden-cup-ratio | es, mc, tm, ds |
| `bb-04` | Grind size | Match grind size to method and say how it changes extraction. | grind-size, grind-vs-surface-area | vi, mc, ds, st |
| `bb-05` | Water temperature | Know the target range and why boiling is too hot. | water-temp-range, temp-effect | es, bc, mc, ds |
| `bb-06` | Time | Understand contact time and its trade-off with grind. | contact-time, time-grind-tradeoff | es, tt, mc, ds |
| `bb-07` | Water matters | Explain why water is mostly the cup and what hardness and alkalinity do. | water-quality, hardness-alkalinity | mc, bc, ds, st |
| `bb-08` | Grind fresh | Explain why freshly ground coffee is better and what a grinder does. | grind-freshness, grinder-role | mc, bc, ds, fg |
| `bb-09` | Hot water and safe brewing | Handle hot water, kettles and cleaning conservatively. | hot-water-safety, equipment-cleaning | ds, bc, so, mc |

### Layer 2: Intermediate

**Unit `methods`: Brew Methods** (prereq: `brew-basics`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `me-01` | Two families of brewing | Separate immersion from percolation (pour-through) methods. | brew-families, immersion-vs-percolation | tm, mc, vi, st |
| `me-02` | Pour-over | Describe the pour-over recipe: bloom, pours, drawdown. | pour-over-basics, bloom, cone-vs-flat-bottom | so, vi, mc, st |
| `me-03` | Drip machines | Explain what a good automatic brewer does and what it lacks. | drip-machine, scaa-certified-brewer | mc, bc, ds, st |
| `me-04` | French press | Describe immersion brewing with a metal filter and what it means for body. | french-press, metal-vs-paper-filter | so, mc, ds, st |
| `me-05` | AeroPress | Explain the AeroPress's flexibility and why people love it. | aeropress, aeropress-flexibility | mc, tm, ds, st |
| `me-06` | Moka pot | Understand that a moka pot is not espresso and how to use it safely. | moka-pot, moka-pot-safety | mc, bc, ds, st |
| `me-07` | Cold brew and iced coffee | Separate cold brew from iced coffee and store cold brew safely. | cold-brew, japanese-iced-coffee, cold-brew-safety | mc, es, ds, bc |
| `me-08` | Turkish, siphon and friends | Recognize regional and theatrical brews. | turkish-coffee, siphon-brewer, regional-brews | tm, mc, vi, st |

**Unit `extraction`: Extraction and Troubleshooting** (prereq: `brew-basics`; `methods` recommended). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ex-01` | Under-extracted | Recognize the sour, thin, salty cup and its causes. | under-extraction, sour-thin | ds, bc, mc, st |
| `ex-02` | Over-extracted | Recognize the bitter, dry, astringent cup and its causes. | over-extraction, bitter-astringent | ds, bc, mc, st |
| `ex-03` | Strength vs extraction | Separate how concentrated from how well extracted. | strength-vs-extraction, tds | mc, es, tm, ds |
| `ex-04` | Fix sour, fix bitter | Choose the right variable to change, one at a time. | dial-in-fix-table, one-variable-rule | ds, ds, so, st |
| `ex-05` | Channeling and unevenness | Explain channeling and why agitation and puck prep matter. | channeling, even-extraction, agitation | ht, ds, mc, st |
| `ex-06` | Dialing in by taste | Use a taste-first loop to dial in a new bag. | dialing-in, taste-first-method | so, ds, mc, st |
| `ex-07` | Numbers for the curious | Know the SCA yield and TDS ranges and what a refractometer does. | refractometer-basics, extraction-yield-range, brew-control-chart | es, mc, tm, fg |

**Unit `espresso-and-milk`: Espresso and Milk** (prereq: `brew-basics`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `es-01` | What espresso is | Explain espresso as a method: fine grind, pressure, short time. | espresso-definition, espresso-not-roast, espresso-pressure | mc, bc, tm, st |
| `es-02` | The recipe: dose, yield, time | Read "18 in, 36 out, 28 seconds". | espresso-ratio, espresso-dose-yield-time | es, mc, tt, st |
| `es-03` | Dialing in a shot | Adjust grind first, using taste and flow. | espresso-dial-in, grind-first | ds, ds, so, mc |
| `es-04` | Crema and pre-infusion | Explain crema and its myths and what pre-infusion is. | crema, crema-myths, pre-infusion | mc, bc, ds, st |
| `es-05` | Machines | Tell machine types and key parts apart. | machine-types, boiler-types, super-automatic | vi, ht, tm, mc |
| `es-06` | Steaming milk | Know the stages of steaming and the safe temperature. | steam-wand, milk-stretching, milk-temperature-safety, steam-safety | so, li, es, ds |
| `es-07` | Microfoam and latte art | Explain microfoam and why latte art is milk texture. | microfoam, latte-art-basics | mc, vi, bc, st |
| `es-08` | Milk and alternatives | Know how milk and plant milks behave and ask about allergies. | milk-alternatives-barista, milk-allergen-care | mc, bc, ds, tm |

**Unit `tasting`: Tasting Vocabulary** (prereq: `coffee-basics`; parallel to other intermediate units). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ta-01` | What you can taste | Separate taste, aroma and flavor. | taste-basics, aroma-vs-flavor | mc, tm, fg, st |
| `ta-02` | Acidity, the good kind | Explain acidity as brightness, not sourness. | acidity-good, acidity-vs-sourness | mc, bc, ds, st |
| `ta-03` | Body, sweetness, finish | Describe mouthfeel, sweetness and aftertaste. | body, sweetness, finish | tm, mc, fg, st |
| `ta-04` | The flavor wheel | Use the coffee flavor wheel to name flavors. | flavor-wheel, descriptor-language | ht, mc, tm, st |
| `ta-05` | Cupping | Describe how a professional cupping works. | cupping, cupping-protocol | so, mc, bc, st |
| `ta-06` | Side by side | Explain why tasting two coffees together teaches the most. | tasting-comparison, palate-calibration | ds, mc, st, fg |
| `ta-07` | Notes are hints | Explain that "blueberry" is a note, not an ingredient, and be honest about tasting. | notes-are-suggestions, tasting-honesty | bc, mc, st, ds |

### Layer 3: Enthusiast depth

**Unit `cafe-menu`: Café Culture and Menu Literacy** (prereq: `espresso-and-milk` lesson `es-01`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cm-01` | The espresso ladder | Tell espresso, doppio, ristretto and lungo apart. | espresso-menu, doppio-ristretto-lungo | tm, es, mc, st |
| `cm-02` | Milk drinks decoded | Distinguish cappuccino, latte, flat white, cortado and macchiato. | cappuccino-latte-flat-white, cortado-macchiato | vi, tm, mc, ds |
| `cm-03` | Long drinks and filter | Understand americano, long black, drip and pour-over on a menu. | americano-long-black, filter-on-menu | tm, mc, bc, ds |
| `cm-04` | Menus by place | Know how Italy, Australia and New Zealand, the Nordics, Japan and the US differ. | italian-bar-culture, australia-nz-cafe, nordic-coffee, japanese-kissaten, us-chains-vs-indie | mc, tm, st, ds |
| `cm-05` | Ordering with confidence | Order without bluffing and ask a barista a genuine question. | ordering-etiquette, specialty-cafe-etiquette | ds, tk, st, mc |
| `cm-06` | The third place | Explain the café as the "third place" and a short history of coffeehouses. | third-place, coffeehouse-history | mc, so, st, tm |
| `cm-07` | Sizes, syrups, seasonals | Decode size language and seasonal drinks without snobbery. | drink-size-language, syrups-seasonal, no-coffee-snobbery | mc, bc, ds, st |

**Unit `third-wave`: Third Wave and the Specialty Scene** (prereq: `roasting`, `origins`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `tw-01` | The three waves | Explain the three-waves model and its critiques. | three-waves-model, wave-critique | so, mc, st, bc |
| `tw-02` | Grades and scores | Explain SCA 80+ scoring and Cup of Excellence. | sca-score-80, cup-of-excellence | es, mc, tm, st |
| `tw-03` | Importers, roasters, direct trade | Follow a specialty coffee from farm to roaster. | specialty-supply-chain, importer-role, direct-trade | so, mc, ds, st |
| `tw-04` | Competitions | Explain the World Barista Championship and Brewers Cup and what judges value. | world-coffee-championships, competition-coffees | mc, tm, st, bc |
| `tw-05` | Scene culture | Understand roaster and café culture, events and community. | roaster-culture, coffee-community | mc, st, ds, tk |
| `tw-06` | Scene debates | Hold a balanced view on "specialty snobbery" and the light-roast backlash. | specialty-snobbery-debate, light-roast-backlash | ds, tk, st, mc |

**Unit `gear-and-debates`: Home Gear and Debates** (prereq: `brew-basics`; `extraction` recommended). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `gd-01` | The grinder is the thing | Explain why the grinder matters most. | grinder-importance, burr-vs-blade | mc, ds, bc, st |
| `gd-02` | Flat, conical, hand, electric | Separate burr geometry and hand vs electric grinders. | burr-geometry, hand-grinder, grinder-adjustment | tm, vi, mc, ds |
| `gd-03` | Scales, kettles, timers | Know the everyday kit and what each does. | kitchen-scale-coffee, gooseneck-kettle, brew-timer | mc, vi, ht, tm |
| `gd-04` | Home espresso tiers | Describe the machine budget tiers and realistic trade-offs. | espresso-tiers, machine-budget-reality | ds, mc, tm, st |
| `gd-05` | Pods, capsules, super-autos | Discuss convenience gear fairly, including sustainability. | capsule-coffee, pod-sustainability | mc, ds, bc, st |
| `gd-06` | Techniques people argue about | Explain WDT, RDT, bloom and pre-infusion debates. | wdt, rdt, bloom-debate, technique-debates | tm, mc, bc, st |
| `gd-07` | Water recipes and gadget fatigue | Understand water-recipe culture and spot hype. | water-recipes, gadget-fatigue | mc, ds, st, bc |
| `gd-08` | The dark roast debate | Hold a generous view of dark roast and taste preference. | dark-roast-debate, taste-is-personal | ds, tk, st, mc |

**Unit `sustainability`: Sustainability, Fair Trade and Farmers** (prereq: `coffee-basics`; `third-wave` recommended). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `su-01` | What a cup pays the farmer | Explain the C price and farm-gate price without numbers that go stale. | c-price, farmgate-price | es, mc, ds, st |
| `su-02` | Certifications explained | Explain Fair Trade, Rainforest Alliance, organic and their limits. | fair-trade, rainforest-alliance, organic-certification, cert-limits | tm, mc, bc, st |
| `su-03` | Direct trade and traceability | Explain direct trade's promises and critiques. | direct-trade-debate, traceability | mc, ds, st, tk |
| `su-04` | Climate and coffee | Explain climate pressure, leaf rust and adaptation in neutral terms. | climate-and-coffee, leaf-rust, variety-adaptation | mc, bc, ht, st |
| `su-05` | Forests, shade and the EU rule | Explain deforestation risk, shade-grown coffee and the EU Deforestation Regulation. | deforestation-and-coffee, shade-grown, eudr | mc, ds, st, bc |

### Layer 4: Branches and personalization

Branch units set `branchId`; the shared core is the `everyday` default. Each has 2 to 3 lessons and personalizes with tokens.

**Unit `branch-espresso`: Home Espresso** (branchId `espresso`; prereq: `espresso-and-milk`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `be-01` | The puck workflow | Order puck prep: dose, distribute, tamp, lock in. | puck-prep, tamping, portafilter-basics | so, ht, mc, st |
| `be-02` | Shot diagnostics | Diagnose fast, slow, sour and bitter shots from numbers and taste. | espresso-diagnostics, flow-rate | ds, ds, es, bc |
| `be-03` | Milk at home | Steam milk safely and make a basic flat white. | home-milk-workflow, steam-wand-cleaning | so, li, ds, bc |

**Unit `branch-pour-over`: Pour-over** (branchId `pour-over`; prereq: `methods` lesson `me-02`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bp-01` | Recipe structure | Read a pour-over recipe: ratio, bloom, pours, time. | pour-over-recipe, named-recipes | so, es, mc, st |
| `bp-02` | Pours and agitation | Explain pour rate, agitation and drawdown. | pour-rate, drawdown-time, agitation-pourover | ds, ds, mc, tt |
| `bp-03` | Cones, filters and kettles | Compare V60, Kalita, Chemex and filter types. | cone-shapes, filter-papers, kettle-flow | vi, tm, mc, ds |

**Unit `branch-immersion`: Immersion and Cold** (branchId `immersion`; prereq: `methods`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bi-01` | French press, done well | Describe steep time, the crust and decanting. | press-technique, press-decanting | so, ds, mc, bc |
| `bi-02` | AeroPress recipes and the championship | Explain inverted vs standard and the World AeroPress Championship. | aeropress-recipes, aeropress-championship | mc, tm, ds, st |
| `bi-03` | Cold brew at home, safely | Make and store cold brew conservatively and dilute it right. | cold-brew-ratio, cold-brew-storage | es, ds, bc, so |

**Unit `branch-africa`: Africa and Arabia** (branchId `africa`; prereq: `origins` lessons `or-02`, `or-03`). 2 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ba-01` | Ethiopia, region by region | Tell Yirgacheffe, Guji and Sidama apart as fans do. | ethiopia-regions, ethiopian-heirloom-varieties | mc, ht, tm, st |
| `ba-02` | Kenya, Rwanda, Burundi, Yemen | Describe East African washing and Yemen's ancient trade. | kenya-double-wash, rwanda-burundi, yemen-coffee | mc, tm, ds, st |

**Unit `branch-latin-america`: Latin America** (branchId `latin-america`; prereq: `origins` lessons `or-04`, `or-05`). 2 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bl-01` | Colombia and Brazil, deeper | Describe Colombian regions and Brazilian farm scale. | colombia-regions, brazil-regions | mc, ht, tm, st |
| `bl-02` | Central America and Panama | Explain why Panama Geisha and Costa Rica micro-mills are famous. | central-america-detail, panama-geisha-auctions | mc, ds, tm, st |

**Unit `branch-asia-pacific`: Asia-Pacific** (branchId `asia-pacific`; prereq: `origins` lesson `or-06`). 2 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bs-01` | Indonesia and Papua New Guinea | Describe wet-hulling, earthy profiles and island origins. | indonesia-islands, png-coffee, low-acid-myth | mc, ht, bc, st |
| `bs-02` | India, Vietnam and Yunnan | Explain monsoon coffee, robusta in Vietnam and emerging Chinese arabica. | monsooned-coffee, vietnam-robusta, yunnan-coffee | mc, tm, ds, st |

### Layer 5: Current season / live

**Unit `now-in-coffee`: Now in Coffee** (prereq: `coffee-basics`; grows with mastery). Templated; refreshed by `live` hooks and editorial cards. 4 lesson templates (each instantiated per month or event).

| Lesson id | Title | Objective | conceptIds | Activities | Live hook |
|---|---|---|---|---|---|
| `nc-01` | What is fresh this month | Know which origins are arriving now, near `{{origin}}` where relevant. | harvest-calendar | mc, tm, ds, st | conditions (curated harvest table) |
| `nc-02` | Why is coffee pricey? | Understand a dated price explainer and how the C price moves. | c-price-explainer | mc, ds, st, bc | statistics (ICO, editorial) |
| `nc-03` | Coffee in the news | Understand a current story (frost, regulation, trade) and ask a good question. | coffee-news-literacy, eudr | mc, ds, st, bc | news, regulations |
| `nc-04` | Championships and releases | Know what is on this season (WBC, Brewers Cup, roaster releases) and why fans care. | current-coffee-events | mc, st, tk, tm | events, new-products |

### Layer 6: Conversation practice and perpetual review

**Unit `conversation-lab`: Conversation Lab** (prereq: any three foundation units; content grows with mastery). 7 lessons; also feeds the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | "This is a washed Ethiopian" | Respond with curiosity to a proud bag reveal. | convo-follow-up-questions, washed-process | tk, st, mc, ds |
| `talk-02` | "My espresso is sour" | Sympathize and ask, without pretending to fix it. | convo-empathy, under-extraction | tk, st, ds, mc |
| `talk-03` | The new grinder | Ask smart questions about gear without faking. | convo-gear-talk, grinder-importance | tk, st, mc, ds |
| `talk-04` | Ordering together | Order with her at her café and handle the menu honestly. | convo-cafe-order, cappuccino-latte-flat-white | tk, ds, st, mc |
| `talk-05` | Light vs dark | Stay warm in the roast debate. | convo-roast-debate, dark-roast-debate | tk, st, ds, mc |
| `talk-06` | "I only buy direct trade" | Ask about sourcing without challenging her values. | convo-ethics-talk, direct-trade | tk, st, mc, ds |
| `talk-07` | Say-this gauntlet | Decode five lines in a row. | (all layers, sampled) | st, st, st, st |

**Unit `review-loop`: Perpetual Review** (always available after first lesson). 4 lesson templates driven by the review policy.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Daily Bite | 1 card (mc/fg/tm) from due concepts. | (due concepts) | mc, fg, tm, es |
| `review-02` | Weekly mix | 3-round session sampled by weakness. | (weak concepts) | mc, bc, ds, tk |
| `review-03` | Safety check | Always-on refresh of hot-water, steam and storage safety; never timed. | hot-water-safety, steam-safety, milk-temperature-safety, cold-brew-safety, moka-pot-safety | mc, bc, ds, es |
| `review-04` | Term blitz | Playbook term drill. | (terms) | tm, fg, mc, st |

**Review policy:** Leitner-style intervals 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; a concept below 0.6 re-enters at 1d; **safety concepts** (`hot-water-safety`, `steam-safety`, `milk-temperature-safety`, `cold-brew-safety`, `moka-pot-safety`, `equipment-cleaning`, `milk-allergen-care`) re-enter on a shorter cadence (1d, 3d, 7d, 14d, 30d) and never lose the "explain why" step. No timers on safety review.

### Concept targets, personalization slots, release plan

- **Concept count target:** 259 Playbook concepts (Appendix below); 60+ terms drafted with definitions and example lines in `exercises.md` section 3 (62 at time of writing).
- **Personalization slots:** `{{origin}}`, `{{brewMethod}}`, `{{equipment}}`, `{{skillLevel}}`, `{{style}}`, `{{roaster}}` (section 8).
- **Release plan:**
  - **Launch (v0.1-1.0):** foundations (5 units), intermediate (4 units), `cafe-menu`, `third-wave`, `gear-and-debates`, `conversation-lab`, `review-loop`; brew-method branches `espresso`, `pour-over`; origin branches `africa` and `latin-america`; `now-in-coffee` with harvest-calendar and event cards only.
  - **Fast follow (1.1):** `sustainability` (needs fact review and ethics tone check), `immersion` and `asia-pacific` branches, price and regulation cards.
  - **Ongoing:** new lessons per season (harvest arrivals, championship results, new rules), new talk tracks monthly, deeper origins (Central America by country, East Africa), regional menus (Vietnam egg coffee, Middle Eastern cardamom coffee, Ethiopian coffee ceremony) driven by demand data (spec section 43), refresh of standards references yearly.

### Appendix: Playbook concepts (ids)

`coffee-basics`: `coffee-cherry`, `seed-not-bean`, `coffee-supply-chain`, `arabica-vs-robusta`, `species-flavor`, `coffee-is-mostly-water`, `coffee-solubles`, `coffee-belt`, `growing-conditions`, `commodity-vs-specialty`, `specialty-grade`, `caffeine-basics`, `decaf-basics`.
`origins`: `bag-label-literacy`, `single-origin-vs-blend`, `microlot`, `ethiopia-heirloom`, `origin-flavor-tendencies`, `east-africa-profile`, `sl28-sl34`, `kenya-grading`, `colombia-profile`, `central-america-profile`, `altitude-and-density`, `brazil-profile`, `brazil-natural`, `indonesia-wet-hulled`, `asia-pacific-profile`, `coffee-varieties`, `geisha`, `variety-vs-origin`.
`processing`: `harvest-picking`, `mucilage`, `washed-process`, `clean-bright-profile`, `natural-process`, `fruity-funky-profile`, `drying-and-defects`, `honey-process`, `honey-no-honey-myth`, `anaerobic-fermentation`, `experimental-debate`, `process-flavor-map`, `process-vs-origin`.
`roasting`: `green-coffee`, `roasting-basics`, `roast-levels`, `roast-flavor-spectrum`, `roast-color-vs-flavor`, `first-crack`, `second-crack`, `development-time`, `dark-is-stronger-myth`, `oily-beans`, `filter-vs-espresso-roast`, `omni-roast`, `roast-date`, `degassing`, `staling-and-storage`.
`brew-basics`: `brewing-is-extraction`, `extraction-yield-basics`, `coffee-scale`, `dose-and-yield`, `brew-ratio`, `golden-cup-ratio`, `grind-size`, `grind-vs-surface-area`, `water-temp-range`, `temp-effect`, `contact-time`, `time-grind-tradeoff`, `water-quality`, `hardness-alkalinity`, `grind-freshness`, `grinder-role`, `hot-water-safety`, `equipment-cleaning`.
`methods`: `brew-families`, `immersion-vs-percolation`, `pour-over-basics`, `bloom`, `cone-vs-flat-bottom`, `drip-machine`, `scaa-certified-brewer`, `french-press`, `metal-vs-paper-filter`, `aeropress`, `aeropress-flexibility`, `moka-pot`, `moka-pot-safety`, `cold-brew`, `japanese-iced-coffee`, `cold-brew-safety`, `turkish-coffee`, `siphon-brewer`, `regional-brews`.
`extraction`: `under-extraction`, `sour-thin`, `over-extraction`, `bitter-astringent`, `strength-vs-extraction`, `tds`, `dial-in-fix-table`, `one-variable-rule`, `channeling`, `even-extraction`, `agitation`, `dialing-in`, `taste-first-method`, `refractometer-basics`, `extraction-yield-range`, `brew-control-chart`.
`espresso-and-milk`: `espresso-definition`, `espresso-not-roast`, `espresso-pressure`, `espresso-ratio`, `espresso-dose-yield-time`, `espresso-dial-in`, `grind-first`, `crema`, `crema-myths`, `pre-infusion`, `machine-types`, `boiler-types`, `super-automatic`, `steam-wand`, `milk-stretching`, `milk-temperature-safety`, `steam-safety`, `microfoam`, `latte-art-basics`, `milk-alternatives-barista`, `milk-allergen-care`.
`tasting`: `taste-basics`, `aroma-vs-flavor`, `acidity-good`, `acidity-vs-sourness`, `body`, `sweetness`, `finish`, `flavor-wheel`, `descriptor-language`, `cupping`, `cupping-protocol`, `tasting-comparison`, `palate-calibration`, `notes-are-suggestions`, `tasting-honesty`.
`cafe-menu`: `espresso-menu`, `doppio-ristretto-lungo`, `cappuccino-latte-flat-white`, `cortado-macchiato`, `americano-long-black`, `filter-on-menu`, `italian-bar-culture`, `australia-nz-cafe`, `nordic-coffee`, `japanese-kissaten`, `us-chains-vs-indie`, `ordering-etiquette`, `specialty-cafe-etiquette`, `third-place`, `coffeehouse-history`, `drink-size-language`, `syrups-seasonal`, `no-coffee-snobbery`.
`third-wave`: `three-waves-model`, `wave-critique`, `sca-score-80`, `cup-of-excellence`, `specialty-supply-chain`, `importer-role`, `direct-trade`, `world-coffee-championships`, `competition-coffees`, `roaster-culture`, `coffee-community`, `specialty-snobbery-debate`, `light-roast-backlash`.
`gear-and-debates`: `grinder-importance`, `burr-vs-blade`, `burr-geometry`, `hand-grinder`, `grinder-adjustment`, `kitchen-scale-coffee`, `gooseneck-kettle`, `brew-timer`, `espresso-tiers`, `machine-budget-reality`, `capsule-coffee`, `pod-sustainability`, `wdt`, `rdt`, `bloom-debate`, `technique-debates`, `water-recipes`, `gadget-fatigue`, `dark-roast-debate`, `taste-is-personal`.
`sustainability`: `c-price`, `farmgate-price`, `fair-trade`, `rainforest-alliance`, `organic-certification`, `cert-limits`, `direct-trade-debate`, `traceability`, `climate-and-coffee`, `leaf-rust`, `variety-adaptation`, `deforestation-and-coffee`, `shade-grown`, `eudr`.
`branch-espresso`: `puck-prep`, `tamping`, `portafilter-basics`, `espresso-diagnostics`, `flow-rate`, `home-milk-workflow`, `steam-wand-cleaning`.
`branch-pour-over`: `pour-over-recipe`, `named-recipes`, `pour-rate`, `drawdown-time`, `agitation-pourover`, `cone-shapes`, `filter-papers`, `kettle-flow`.
`branch-immersion`: `press-technique`, `press-decanting`, `aeropress-recipes`, `aeropress-championship`, `cold-brew-ratio`, `cold-brew-storage`.
`branch-africa`: `ethiopia-regions`, `ethiopian-heirloom-varieties`, `kenya-double-wash`, `rwanda-burundi`, `yemen-coffee`.
`branch-latin-america`: `colombia-regions`, `brazil-regions`, `central-america-detail`, `panama-geisha-auctions`.
`branch-asia-pacific`: `indonesia-islands`, `png-coffee`, `low-acid-myth`, `monsooned-coffee`, `vietnam-robusta`, `yunnan-coffee`.
`now-in-coffee`: `harvest-calendar`, `c-price-explainer`, `coffee-news-literacy`, `current-coffee-events`.
`conversation-lab`: `convo-follow-up-questions`, `convo-empathy`, `convo-gear-talk`, `convo-cafe-order`, `convo-roast-debate`, `convo-ethics-talk`.

---

## 12. Interaction plan

Tier rubric (`CLAUDE.md` section 4): Unity only where spatial reasoning, movement, physics, timing in a scene or camera perspective materially improves learning and a native exercise would teach it clearly worse. **No row below is Tier A.** Every Unity candidate was evaluated in section 5 and rejected. `unitySimulations` in the manifest is empty; there is no `sims/` folder; `interactionTypes` excludes `unity-sim`. Native rows follow `docs/native-exercises/CATALOG.md`.

| Lesson / activity family | Concepts | Type (native exercise) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Diagnosis: "my espresso is sour", "the pour-over drained in 1:20", "the French press is silty", "which grinder first?" | under-extraction, over-extraction, dial-in-fix-table, espresso-diagnostics, grinder-importance | `decision-scenario` | Coffee is decisions from numbers and taste. A fact sheet (dose, yield, time, grind, taste) with best/acceptable/poor teaches judgment and the one-variable rule. A sim would only animate the outcome. | B | ~120 |
| Numbers: ratios, temperatures, brew times, shot yields, milk temperatures, ratios of drinks | brew-ratio, water-temp-range, espresso-ratio, contact-time, milk-temperature-safety, tds | `estimate-slider` | The course's numeric spine: closeness matters more than exact values. Safety values (milk and serving temperatures, cold-brew storage) use tight tolerances. | B | ~55 |
| Processes: cherry to cup, pour-over steps, puck prep, steaming stages, cupping order | coffee-supply-chain, pour-over-basics, puck-prep, steam-wand, cupping-protocol | `sequence-order` | Order is the concept and each step carries a `why` (catalog #4). | B | ~40 |
| Rule and fact checks (origins, processes, roast levels, drinks, certifications) | most | `multiple-choice` | Default recall and understanding card; distractors are the misconceptions in section 2. | B | ~210 |
| Sour or bitter? Myth or fact? | acidity-vs-sourness, dark-is-stronger-myth, crema-myths, honey-no-honey-myth, moka-pot-safety | `binary-call` | Two-way judgments; `scene.kind` is `none` (no diagram library needed). | B | ~55 |
| Vocabulary: terms, varieties, drinks, gear, certifications | doppio-ristretto-lungo, geisha, burr-geometry, fair-trade | `term-match`, `fill-the-gap` | Recall and recognition in context. | B | ~60 |
| Recognize grind sizes, roast levels, drink builds, machine parts, filter shapes, process stages | grind-size, roast-levels, cappuccino-latte-flat-white, machine-types, cone-shapes | `visual-id` | Recognition is the skill. Procedural vector art only (`original-swoond`). | B | ~45 |
| Diagrams: the coffee belt and origin map, espresso machine parts, puck cross-section, V60 cone, flavor wheel, roast curve | coffee-belt, machine-types, channeling, cone-shapes, flavor-wheel, first-crack | `hotspot-tap` | Static diagram with correct regions; no motion needed (catalog #13). Replaces the rejected map and puck sims. | B | ~35 |
| Steam stretching vs texturing, pouring shot, rolling boil, grinder pitch, first crack | milk-stretching, steam-safety, first-crack | `listening-id` | Sound is a real barista cue. Original or synthesized audio (`original-swoond`); "Skip" and a text alternative are always available. | B | ~14 |
| Feel: stop the shot at the right yield, end the bloom | espresso-dose-yield-time, bloom | `timing-tap` | Only 1D rhythm; explicitly not speed pressure; slow mode always on; never used for safety. | B | ~8 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice: 18 talk tracks and ~70 say-this items. | B | 18 + ~70 |

**Native exercise types used:** multiple-choice, binary-call, term-match, sequence-order, visual-id, decision-scenario, talk-track, timing-tap, say-this, fill-the-gap, listening-id, estimate-slider, hotspot-tap (all 13; the last four are used lightly). **`unity-sim` unused.** Estimated total native items ~700 across 120 lessons and the review loop.

**Accessibility:** `listening-id` always has a text alternative and Skip; `visual-id` `alt` describes distinguishing features without revealing the answer; `timing-tap` uses `tap-to-stop-slow`; no exercise relies on color alone (roast ladder and grind ladder use labels and numbers).

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| Imagery | Procedural or original illustration only (`license: original-swoond`): grind ladder, roast ladder, drink builds (cup cross-sections), espresso machine parts, puck cross-section, V60 and Chemex cones, origin map, flavor wheel, roast curve. **No third-party photographs** of farms, bags, cafés, roasters or competitors. |
| Audio | Original or synthesized steam, pour, grinder, boil and crack sounds (`original-swoond`). No video or podcast audio. |
| Logos / trademarks | Brands (Hario V60, Chemex, AeroPress, Bialetti, Breville, La Marzocco, Baratza, Comandante, Fellow, Nespresso, Starbucks, Third Wave Water, Fair Trade USA, Rainforest Alliance) and SCA, Q Grader, Cup of Excellence, World Barista Championship appear only as text where a lesson needs them; no logos. Flavor wheel: Swoon'd draws an original wheel with original categories; the SCA and World Coffee Research Coffee Taster's Flavor Wheel is cited and linked, not reproduced. |
| Video | No embedded competition or brewing video; deep-link to official pages. |
| Recipes and standards text | Named recipes (for example, the 4:6 method, well-known French press and V60 techniques) are cited by name and creator as facts; Swoon'd writes its own explanation and does not copy recipe text or competition routines. The SCA Golden Cup numbers are stated as facts with attribution. |
| Article text | Never copied; explain and link (spec section 11). |
| Lyrics / music | N/A. |
| Data terms | ICO composite price indicator is publicly available (verify reuse terms at adapter build); ICE futures data is licensed and is **not** assumed; European Commission pages are link-out; trade publications are link-only. |
| Player likeness | Champions and authors are named as facts only; no likeness, no quotes beyond short fair-use facts, no endorsement implication. |
| Ethics and trade claims | Fair Trade, direct trade and certifications are described neutrally and with critiques; Swoon'd does not claim that any brand is ethical or unethical. |

**Safety (conservative mainstream guidance; state in manifest `safetyConstraints`; Swoon'd builds appreciation and understanding, not a substitute for training):**
- **Hot water, steam and burns.** Brewing water is 195 to 205 F, far above scalding temperature; teach pouring away from the body, stable kettles, never carrying hot vessels near children or pets, handle and spout awareness, and **letting hot drinks cool before sipping** (serving drinks are hot enough to burn). Steam wands: purge before and after, keep the tip under the milk surface, never point at people, wipe and purge after each use; steam and portafilters are pressure and burn hazards. Do not remove a portafilter during extraction. For a scald, cool running water and seek medical care for anything serious; no medical advice beyond that mainstream first step.
- **Milk temperature.** Teach "hot but drinkable" (roughly 140 to 155 F / 60 to 68 C for most milk drinks) and never scalding; children's drinks cooler. No heating milk to boiling.
- **Moka pot.** Fill water only to the valve, never seal the safety valve, never heat an empty or dry pot or use excessive flame; open only when cool; follow the manufacturer's instructions.
- **Cold brew and storage.** Refrigerate cold brew, keep equipment clean, use it within about a week (conservative mainstream guidance; **[verify at release]** against current food-safety guidance), and do not leave brewed coffee with milk unrefrigerated for long; discard if it smells or looks off. Cold brew is not "pasteurized"; do not teach long room-temperature steeps as safe.
- **Grinders.** Unplug before cleaning; never put fingers near burrs; blade grinders are a hand-injury risk when opened. **Descaling** only with descaler or methods approved by the machine's manufacturer; rinse thoroughly; never mix chemicals.
- **Allergens and milk alternatives.** Ask first and read labels; nut, soy, oat (gluten cross-contact risk) and dairy allergies exist; no medical advice; never imply an allergen is "fine in small amounts".
- **Caffeine and health.** **No health claims, no benefit or risk claims, no dosage guidance.** `caffeine-basics` states only neutral facts (caffeine is a stimulant found in coffee; content varies by bean, brew and serving size; decaf still contains a little) and always says that anyone with a medical question, including pregnancy, medication or heart conditions, should ask a health professional. Swoon'd does not recommend how much to drink and does not say coffee is healthy or unhealthy.
- **Dark-humor rule.** Jokes target the learner's ignorance, never the crush, never her taste, never baristas or farmers.
- Never encourage the learner to fake coffee expertise or claim credit for a brew they did not make.

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Grind-size ladder (Turkish to coarse), roast ladder (light to dark) | Procedural / original vector | Swoon'd | `original-swoond` |
| Drink cross-sections (espresso, cortado, cappuccino, latte, flat white, americano, macchiato) | Procedural | Swoon'd | `original-swoond` |
| Espresso machine parts (group head, portafilter, wand, gauge), grinder parts | Procedural | Swoon'd | `original-swoond` |
| Puck cross-section (even vs channeled), extraction chart, roast curve | Procedural | Swoon'd | `original-swoond` |
| V60, Kalita, Chemex, AeroPress, French press, moka pot silhouettes | Original vector | Swoon'd | `original-swoond` |
| Coffee belt and origin map; cherry cross-section; processing flow diagrams | Procedural | Swoon'd | `original-swoond` |
| Original flavor-wheel graphic | Original vector | Swoon'd (categories written by Swoon'd; not the SCA wheel) | `original-swoond` |
| Steam stretching and texturing, pouring shot, grinder, boil, crack | Synthesized / recorded in-house | Swoon'd | `original-swoond` |
| Harvest calendar, events and news cards | Data cards, no images | Curated | n/a |

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Seeds not beans, species, origins and varieties, processing, roast levels, and the four brewing variables that explain extraction (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Origin and process, freshness, grinders, ratios and recipes, dialing in, milk texture, specialty culture, ethics of sourcing, and the big debates (section 4).
- [x] 3. **What current information matters?** Harvest arrivals, price explainers, regulations, championships, news (section 6). No scoreboard data.
- [x] 4. **What should be interactive?** Diagnostic decision scenarios, estimates, sequencing, recognition and hotspot diagrams, sounds, conversation; zero Unity sims (sections 5, 12).
- [x] 5. **What should NOT be gamified?** Caffeine and health, safety, farmers and trade, her taste, roast and origin ranking, latte-art performance, allergens (section 5).
- [x] 6. **How should it personalize?** Origin (`region`), brew method (`format`), equipment, skill level, style, roaster (section 8).
- [x] 7. **What does conversational competence look like?** Decode her bag and brew stories, ask honest technique questions, order well, admit gaps, offer to try (sections 9, 10).
- [x] 8. **What data providers are needed?** Curated harvest, event and media calendars; ICO public indicator (price explainer); European Commission pages (link-out); trade publications (link-only) (`live-data.md`).
- [x] 9. **What licensing constraints apply?** Original art and audio only, brand text mentions, no publisher text, no reproduction of the SCA flavor wheel or standards text, ICE data not assumed (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, safety gate, review ladder, talk-track Smooth >= 60, competence statement (section 10).

Additional gates: [ ] manifest validates (run `tools/validate`); [ ] curriculum validates (not yet authored); [x] no Unity sims, so no sim specs to approve; [ ] every image/audio asset has a license id (assets not yet produced; ids defined); [ ] safety review of `brew-basics` (`bb-09`), `methods` (`me-06`, `me-07`), `espresso-and-milk` (`es-06`, `es-08`) and branch lessons `be-03`, `bi-03` (recommended release gate; see `NOTES_FOR_ORCHESTRATOR.md`); [ ] voice review; [x] no copied publisher text (all copy original).

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Approve zero Unity sims for coffee (rationale in sections 5 and 12). Any candidate to re-open must name the concept, the failing native design and the rubric signal. | Product | No |
| 2 | Food-safety review (Extension educator or food scientist) of cold-brew storage guidance, milk temperatures and the moka-pot and steam lessons before release; mirrors the cooking gate. | Product/Content | Yes for release |
| 3 | Unit count 22 (5+4+4+6+1+1+1) exceeds 8-14; approve, or fold the six branch units (for example, one `branches` unit with activity-level `branchId`). | Product | No |
| 4 | Branch model: can a Person hold one brew-method branch and one origin branch at once? | Product/Native | No |
| 5 | Resolved (D-022, manifest contract 1.3): `origin` added to `personalizationDimensions`; the manifest now uses `origin` (and for the three origin branches) while `region` stays the learner's locale. | Product | No |
| 6 | Price explainer: is ICO's composite indicator usable in-app, or editorial numbers only (ICE futures licensing)? Provider decision L-02/L-03 family. | Legal/Data | No |
| 7 | Flavor wheel: confirm that an original Swoon'd wheel is acceptable (the SCA and World Coffee Research wheel is referenced by link only). | Legal | No |
| 8 | Sustainability tone: human review of `sustainability` for neutrality toward certifications and brands. | Content | Yes for `sustainability` release |
| 9 | Caffeine and pregnancy or heart-condition notes: confirm the "ask a health professional" framing (no claims) is acceptable copy. | Product/Legal | No |
| 10 | Original audio: synthesize or record in-house the steam, pour, grinder and crack sounds? | Product | No (synthesize for MVP) |
| 11 | Dated facts (WBC 2025 and 2026, EUDR date, price history, tariffs) need an owner for monthly refresh. | Content | No |
