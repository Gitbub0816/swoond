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

