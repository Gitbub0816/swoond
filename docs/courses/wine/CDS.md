# Course Design Specification: Wine (`wine`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Wine is an **appreciation-and-vocabulary course with a responsibility frame**: it teaches what wine is, how it is made, how to read a glass, a label and a wine list, why regions and grapes matter, and how wine people talk and argue, so the learner can share the pleasure of someone they care about, never to drink more, never to fake a sommelier's résumé. It is **age-gated and explicitly non-drinker-friendly**: every unit works by smell, reading, pairing talk and conversation, and "not drinking tonight" is a normal, respected answer.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 3 |
| Author / date | Wine course design agent (Claude), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion docs | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity sims, justified in section 5 and section 12) |

Verification note: time-sensitive facts below were checked by web search on **2026-09-30** (OIV state of the world wine sector in 2025: production about 227 million hectolitres, consumption about 208 million hectolitres, lowest since 1957, vineyard area about 7 million hectares; 2025-2030 US Dietary Guidelines released 7 January 2026 with no numeric alcohol limits). Anything marked **[verify at release]** must be re-checked before content ships (see `NOTES_FOR_ORCHESTRATOR.md`).

---

## 1. Identity
- **Course ID:** `wine` (immutable)
- **Display name:** Wine
- **Category / family:** Food & Cooking; category path `Food & Cooking > Wine`
- **Simulation prefix:** `wine` (reserved; **no sims are planned**, so no `wine.<topic>.<name>.vN` id exists)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns wine, are they meaningfully conversationally competent about it?" | Verdict | Consequence for structure |
|---|---|---|---|
| Cooking (`cooking`, Wave 2) | Partly. Pairing talk (acid, fat, salt, tannin) overlaps with flavor balance, but grapes, regions, vintages, labels and tasting vocabulary do not transfer either way. | Adjacent, independent | `food-pairing` unit links to the cooking units on salt, fat, acid and balance; wine cross-links rather than teaching cooking. Alcohol in cooking stays in the cooking course. |
| Coffee (`coffee`, Wave 3) | Barely. Both use tasting language (acidity, body, finish), but extraction, roasting and espresso culture are their own subject. | Adjacent, independent | Shared tasting words are taught here in wine's terms; `tasting-structure` cross-links to coffee once it exists. No coffee content. |
| Cocktails, beer, spirits, sake (not in catalog) | No. Different production, categories and culture. | Out of scope for now | Not folded in. If added later they are their own courses; do not stretch `wine`. |
| Travel (tasting trips, wine regions) | Partly. Regional geography and tasting-room etiquette matter; itineraries and destinations do not. | Adjacent | Branches and `tasting-room` lessons cover manners; no travel planning. |
| Nutrition, health, pregnancy and alcohol policy | No. Health claims are outside Swoon'd's remit. | Out of scope | The course teaches appreciation and explicit low-risk habits (unit `wine-with-care`); it makes no health claims (section 13). |
| Hospitality / sommeliers | Partly. Sommelier culture is a real enthusiast world. | Shares foundation | Covered as unit `sommelier-culture`; no separate course. |

- **Branches** (region / style personalization; each adds a `branch`-layer unit with `branchId`; `everyday` is the default and has no branch-only unit because the shared core units already serve it):

| id | Name | What changes |
|---|---|---|
| `everyday` | Everyday wine (default) | Weeknight bottles, restaurant confidence, gifts; the shared core units are its curriculum. |
| `french` | French wine | Burgundy climats, Bordeaux banks, Rhône, Loire; pronunciation; the language of terroir. |
| `italian` | Italian wine | Native grapes, Piedmont and Tuscany, appassimento, food-first logic. |
| `iberian` | Spanish and Portuguese wine | Rioja and Ribera, Sherry and Port, Vinho Verde, Albariño, Cava. |
| `american` | American wine | Napa, Sonoma, Paso, Oregon, Washington, Finger Lakes; tasting-room etiquette. |
| `southern-hemisphere` | Southern Hemisphere wine | Australia, New Zealand, Chile, Argentina, South Africa in depth. |
| `sparkling` | Sparkling wine | Champagne, Prosecco, Cava, Crémant; serving bubbles safely. |

Branches not at launch: `german-austrian` (Mosel, Wachau) and `orange-natural` (deeper natural and skin-contact culture); see release plan (section 11). **No region ranking, no "best country"**: branches teach how a region works and how its fans talk, not which is superior.

## 2. Beginner model
- **What a complete beginner typically knows:** wine is red or white, there is a fancy way to smell it, expensive usually means good, and Champagne is for celebrating. They can order "the house white" and recognize Chardonnay, Merlot and Pinot Grigio from shelves. They believe there are rules to follow (red with meat, white with fish) and that knowing wine means memorizing vintages. They are often anxious about sounding uninformed at a restaurant.
- **Terminology that will initially confuse them:** tannin, acidity, body, finish, nose, palate, terroir, vintage, appellation, cru, cuvée, *Grand Cru*, *Reserva*, *Riserva*, *Prädikat*, *Trocken*, brut, residual sugar, malolactic, lees, oak, decant, corked, corkage, sommelier, natural wine, orange wine, pét-nat, biodynamic, en primeur.
- **Common misconceptions (each is a lesson target):**
  1. "Red wine must be served at room temperature." (Old cellars were cool; lightly chilled reds taste better. `serving-temperature`.)
  2. "Screw caps mean cheap wine." (A closure is not a quality grade. `screwcap-myth`.)
  3. "Older wine is always better." (Most wine is for drinking young. `most-wine-drink-now`.)
  4. "Fruity means sweet." (Aroma is not sugar. `dry-vs-fruity`.)
  5. "Expensive means better." (Price reflects land, scarcity and brand as well as quality. `price-quality-curve`.)
  6. "Sulfites cause wine headaches." (Sulfites are present in many foods and all wine; Swoon'd teaches facts and says ask a clinician, no diagnosis. `sulfite-myths`.)
  7. "The tongue map says sweet is at the tip." (Every taste is detected across the tongue. `tongue-map-myth`.)
  8. "Red with cheese is the classic." (White and bubbles are often better matches. `red-with-cheese-myth`.)
  9. "Second-cheapest bottle is the safe pick." (Often a high-markup, popular bottle. `second-cheapest-myth`.)
  10. "The tasting pour is for deciding if I like it." (It is a fault check. `tasting-pour`.)
  11. "Legs on the glass show quality." (They show alcohol and sugar, not quality. Playbook term.)
- **Concepts that unlock the rest of the subject (foundation units):** wine is fermented grape juice; structure (sweetness, acidity, tannin, body, alcohol); the three aroma families; a short list of grape families; place-over-grape on old-world labels; and the respectful frame (age, pace, choice not to drink).

## 3. Foundational knowledge
Grouped into modules (these become `foundationalModules[]` and foundation units):

- **Wine with care (`wine-with-care`):** legal age, ABV, standard pours, pacing, food and water, never driving, non-drinker appreciation, when not to pour, zero-proof and low-alcohol wine.
- **What wine is (`wine-basics`):** grapes, sugar, yeast; still, sparkling, fortified and dessert; colors; Vitis vinifera; bottles and closures; glass, temperature, pour.
- **How wine is made (`how-wine-is-made`):** vineyard year, harvest, crushing and pressing, fermentation, maceration, oak and steel, malolactic, lees, traditional and tank method, fortification.
- **Tasting structure (`tasting-structure`):** sweetness, acidity, tannin, body, balance, finish, complexity, the four-step taste.
- **Aromas and flavors (`aromas-flavors`):** retronasal smell, three aroma families, fruit spectrum, non-fruit notes, faults vs style.
- **Grapes (`grapes-core`):** Chardonnay, Sauvignon Blanc, Pinot Grigio/Gris, Riesling, Gewürztraminer, Chenin Blanc, Pinot Noir, Gamay, Grenache, Cabernet Sauvignon, Merlot, Syrah/Shiraz, Malbec; blends.
- **Participants and institutions:** growers, winemakers, négociants, co-operatives, importers, distributors, retailers, sommeliers, critics; Court of Master Sommeliers, WSET, Institute of Masters of Wine; appellation bodies and regulators.
- **History and culture (light, in enthusiast depth):** ancient Georgia and Mediterranean origins, phylloxera, appellation systems, the Judgment of Paris (1976), Parker-era scoring, the natural-wine movement, climate change.

## 4. Enthusiast model
- **What enthusiasts actually talk about:** what they tasted and where; vintage character; grapes and regions; producers ("small growers"); whether a bottle is "ready"; food matches; price and value finds; natural vs conventional; oak usage; acidity and freshness; "minerality"; what they are cellaring; tasting-note banter; travel to regions; classes (WSET levels, sommelier exams).
- **Distinctions that matter to them:** grape vs place; village vs Premier vs Grand Cru; Old World vs New World (and the limits of the framing); young vs mature; oaked vs unoaked; dry vs off-dry; organic vs biodynamic vs natural; grower Champagne vs big houses; tank vs traditional method sparkling.
- **Knowledge that signals genuine understanding:** reading a label to predict style; asking a good question about a producer's farming; knowing a bottle's drinking window is a judgment, not a fact; knowing fault vs preference; admitting what you don't know.
- **Beginner statements that sound uninformed:** "I only drink dry wine" (if they mean fruity); "It has great legs"; "I can taste the terroir" (said without any detail); "Merlot is bad" (a film joke); "It's too expensive to be bad."
- **Controversies and debates:** natural vs conventional; is minerality real?; does terroir exist in the glass?; score inflation and critic power; oak vs restraint; decanting and air; the price of Burgundy and collector culture; greenwashing; sulfites; Old World vs New World; climate change and region shifts; tariffs; the decline in wine drinking and rise of no/low-alcohol; whether wine snobbery is dying.

## 5. Interaction model
- **What the learner should EXPERIENCE instead of reading:** deciding at a restaurant (decision scenarios), ordering the steps of making wine and of service (sequence), matching terms, recognizing bottle shapes and closures (visual-id), tapping regions and label parts on static diagrams (hotspot), hearing how to say hard names (listening-id), estimating numbers like pours and temperatures, and practicing real conversation (talk-track, say-this). A no-drinking path exists for everything: smell-and-read tasks, "smell this" prompts that can use any food or flower, and the option to skip any tasting prompt.
- **Does the course warrant a Unity simulation? No, and this is a deliberate answer.** Tier rubric (`CLAUDE.md` section 4): Unity only where spatial reasoning, movement, physics, timing in a scene or camera perspective materially improves learning and a native exercise would teach it clearly worse. Every candidate was evaluated and rejected:

| Candidate | Why it is tempting | Why native is better (or equal) | Verdict |
|---|---|---|---|
| Vineyard and terroir flyover (slope, soil, aspect) | Slope and sun are spatial | The concept is a relationship (slope faces the sun, cold air drains) that a static diagram with `hotspot-tap` and a `decision-scenario` teaches with clarity; a 3D vineyard would be costly and would still not show taste. | Reject |
| Fermentation and winemaking process | Bubbling tanks look cool | The process is an ordered story with a "why"; `sequence-order` teaches it better. No physics or timing in a scene matters. | Reject |
| Pouring and swirling physics | Swirling is physical | Skill comes from a real glass in hand, not a screen. Risk of teaching a bad stance on drinking. | Reject |
| Cellar / storage simulator | Collecting games | Gamifying collecting would promote hoarding and price talk; the real lesson is conditions (`estimate-slider`, `decision-scenario`). | Reject |
| Sommelier service sim (present, open, pour) | Procedural, physical | It is an ordered ritual with a purpose (`sequence-order` with `why`); a 3D sim would be theatre. Also avoids a "pour and drink" game. | Reject |
| Region map flyover | Geography | A static procedural map with `hotspot-tap` is the right tool (catalog #13); place recognition is recall, not movement. | Reject |
| Blending game | Interactive mixing | Tasting is the skill, and it cannot be simulated on a screen; a fake blending slider would teach false precision. | Reject |
| Tasting simulator (aromas, flavors) | Sensory | Smell and taste do not exist on screen. Native vocabulary tasks plus a "smell this real thing" nudge are honest. | Reject |

  **Result:** zero Unity sims. `unitySimulations` is empty; there is no `sims/` folder; `interactionTypes` excludes `unity-sim`. Astra has nothing to build for wine; **no Game Kit additions requested**.
- **What should NOT be gamified:** drinking quantity or speed (never a streak or badge for drinking); tasting scores as competition (no "palate score"); collecting or price-speculation mechanics; blind-tasting accuracy ranks; natural-vs-conventional "sides"; any frame of wine as an achievement or a challenge; pressure in conversation ("one glass"); alcohol and health.
- **Summary of the chosen mix:** native exercises only, heavy on `multiple-choice`, `decision-scenario`, `say-this`, `sequence-order`, `term-match`, `hotspot-tap`, `visual-id`; light on `listening-id` and `estimate-slider`; no `timing-tap`. Details in section 12.

## 6. Dynamic information requirements
Wine is an evergreen knowledge course with a light, honest current-context layer. Spec section 10: do not invent live-data needs. There are no scores, standings or rosters. What does change, and what an enthusiast mentions at dinner:

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| `conditions` (growing season, harvest) | Yes, light | "What was this year's harvest like, and why do people care?" | Swoon'd editorial harvest explainers; public weather and climate data (Open-Meteo, NOAA, Copernicus) for region summaries; link-out to regional bodies | seasonal | Evergreen vintage-variation lesson |
| `events` | Yes, light | Harvest, Beaujolais Nouveau day, awards, wine weeks, Dry January, tasting festivals | Swoon'd editorial calendar (curated); organizer pages (link-only) | seasonal | Evergreen calendar |
| `releases` | Yes, light | En primeur campaigns, new vintage releases, hyped bottles | Curated calendar; trade press headlines (link-only) | seasonal | Evergreen explainer |
| `news` | Yes | Tariffs, consumption trends, climate and wildfire smoke taint, regulation. "Why is everyone talking about this?" | Publisher headlines (link-only), OIV and trade bodies (link-out) | weekly | Evergreen explainers |
| `regulations` | Light | Label rule changes (EU ingredient and nutrition labelling, US TTB rules), alcohol policy | TTB, EU Commission, OIV pages (link-out) | on-release | Hidden |
| `alerts` | Light | Wildfire smoke and frost events affecting a vintage; recalls of a wine | NIFC/AirNow, FDA/TTB notices (link-out) | daily | Hidden |
| `new-products` | Light | No/low-alcohol launches, new canned wine trends | Editorial (curated) | monthly | Hidden |
| `scores`, `standings`, `rankings`, `statistics`, `rosters`, `injuries`, `transactions` | **No** | Wine has no league table. Critic scores and auction prices are proprietary and would invite speculation. | none | n/a | n/a |

Structured data (harvest dates, event calendars) and editorial data (explainers) are separate systems. No live prices, no ratings feeds, no inventory. Provider isolation: every source sits behind a Swoon'd adapter (spec sections 32-37). Details in `live-data.md`.

## 7. Editorial context
- **Commentary that helps the learner:** why a region had a hard year; what tariffs mean for what she can buy; why wine consumption is falling and no/low is rising; what "skin contact" means in the news; why a big auction result is being talked about; what a new classification or label rule means.
- **Appropriate external sources:** OIV (International Organisation of Vine and Wine) reports, regional wine bodies, the Institute of Masters of Wine, WSET and Court of Master Sommeliers pages, trade and mainstream publishers (link-only), TTB and EU pages for regulation.
- **Summarize, explain, or link:** explain in our own words and link (manifest `editorial.approach = explain-and-link`); never copy publisher text, tasting notes or critic scores.
- **Example prompts:** "Why is everyone talking about tariffs on wine?", "What does it mean that this harvest came two weeks early?", "Why is her feed full of people arguing about natural wine?", "Beaujolais Nouveau is out; what is it, and what can I ask her?", "What is a zero-proof wine and why are restaurants listing them?"

## 8. Personalization
| Dimension | How it changes examples and live context | Default when unset | Used in |
|---|---|---|---|
| `region` | Which region the examples, maps and live cards prefer (e.g. Burgundy, Tuscany, Willamette) | world tour (a balanced sampler) | regions units, branches, live |
| `style` | Grape or style she loves (Pinot Noir, Riesling, bubbles, orange wine); examples and follow-up lines use it | everyday dry whites and light reds | grapes, pairing, conversation, branches |
| `cuisine` | Pairing examples (Thai, Italian, steakhouse, sushi) and cross-links to `cooking` branches | home cooking | food-pairing, conversation |
| `skill-level` | Depth of tasting talk and labels (casual drinker vs class-taker) | curious beginner | tasting, sommelier, enthusiast |
| `brand` | Not used (avoid winery marketing and logos) | n/a | n/a |

Tokens: `{{region}}`, `{{style}}`, `{{cuisine}}`, `{{skillLevel}}`. Branch choice maps to `region` (`french`, `italian`, `iberian`, `american`, `southern-hemisphere`) or `style` (`sparkling`). A `grape` dimension does not exist in the manifest enum; `style` carries grape preference (request in `NOTES_FOR_ORCHESTRATOR.md`).

## 9. Conversation model
- **What an enthusiast might naturally say (with translation):**
  1. "This Riesling is so zippy." -> Bright acidity; she likes freshness.
  2. "It's a bit jammy for me." -> Very ripe, fruity style; she prefers restraint.
  3. "Needs a decant." -> Give a tannic or closed wine air.
  4. "Corked." -> Smells of damp cardboard; TCA taint.
  5. "I'm into orange wine lately." -> White grapes fermented with skins.
  6. "Is it Premier Cru?" -> Asking about Burgundy vineyard rank.
  7. "That's a Kabinett, so pretty light." -> German Riesling with lower ripeness.
  8. "I love the finish on this." -> The flavor stays after you swallow.
  9. "Their Pinot is delicate; the Syrah is huge." -> Light vs full body styles.
  10. "This is a pét-nat." -> Lightly sparkling wine bottled before fermentation finished; often cloudy.
  11. "What's the vintage?" -> The harvest year; how the season shaped the wine.
  12. "I'm trying this zero-proof Riesling." -> A no-alcohol wine; ask how it differs.
  13. "Let's do a flight." -> A set of small pours to compare.
  14. "It's more of an Old World style." -> Restrained, earthy, higher acid.
- **What each statement means and what terminology is implied:** see above; tag each with concepts in curriculum JSON (`acidity`, `tannin`, `decanting`, `cork-taint`, `orange-wine`, `burgundy-ladder`, `pradikat`, `finish`, `body`, `pet-nat`, `vintage-meaning`, `dealcoholized-wine`).
- **What the learner could meaningfully ask next:** "What do you like about it?", "What was the first bottle that made you love wine?", "What would you pair it with?", "Is there one you would start me on?", "Do you like it more than last time?", "What do you taste when you smell it?"
- **How Swoon'd helps without encouraging fake expertise:** `say-this` items always offer honest follow-ups and a `noFakeExpertNote`; talk-track replies reward curiosity and penalize bluffing and pushing drinks; the coach says "ask, don't pretend".
- **Targets:** 20 talk tracks, about 70 `say-this` items at launch.

## 10. Assessment
- **How useful competence is determined:** the learner can recognize, explain and correctly interpret structure words, read a label for style and place, handle a wine list and the restaurant ritual, hold a short wine conversation with honest curiosity, and behave respectfully around alcohol (offer, not push; respect "no").
- **Recognize:** bottle shapes, closures, major grapes and regions, label words. **Understand:** how structure shapes taste, why red is red, why Champagne is different. **Explain:** why a wine might not suit spicy food. **Correctly interpret:** "Premier Cru", "Kabinett", "Reserva", "Brut".
- **Mastery model:** concept mastery with pass threshold **0.8** (`concept-mastery-v1`); `wine-with-care` items carry a gating requirement (answer every safety and respect item correctly before later units unlock conversation practice); talk-track Smooth >= 60 counts as a pass.
- **Useful competence statement (one sentence):** "She can talk about what she loves in a glass, follow a wine list and a label without panic, pair a bottle sensibly with dinner, ask a couple of good questions, treat a 'not tonight' with warmth, and say 'okay, I get why you love this' without faking it."


## 11. Curriculum map (ongoing course)

Designed as an ongoing course. **24 units, 117 lessons, 307 Playbook concepts.** The unit count exceeds the 8-14 guidance because the layer minimums plus six branches, live, conversation and review total 24; a learner sees about 16 units (core 15 plus the matching branch unit, live, conversation, review). See section 16 (#5) and `NOTES_FOR_ORCHESTRATOR.md`.

Activity abbreviations: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap. Every lesson lists 4 planned activity families; no lesson uses a Unity sim.

| Layer | Purpose | Units | Lessons |
|---|---|---|---|
| Foundations | Respectful frame, what wine is, making, tasting, aromas, grapes | 6 | 35 |
| Intermediate | Old and New World regions, labels, pairing, wine lists | 5 | 28 |
| Enthusiast depth | Terroir and vintage, sommelier culture, natural and orange debates, collecting and price myths | 4 | 20 |
| Branches | French, Italian, Iberian, American, Southern Hemisphere, Sparkling | 6 | 18 |
| Current-season / live | Harvest, news, seasonal moments, releases (refreshed from live hooks) | 1 | 4 |
| Conversation practice | Talk tracks and say-this | 1 | 8 |
| Perpetual review | Spaced review | 1 | 4 |

**Personalization slots:** `{{region}}`, `{{style}}`, `{{cuisine}}`, `{{skillLevel}}` in `food-pairing`, `regions-*`, branch units, `wine-now`, `talking-wine`. **Review policy:** spaced review intervals 1, 3, 7, 21, 60 days; at most 12 items per session; retire a concept after 3 consecutive correct reviews at interval >= 21 days; safety and respect concepts (`care-*`) stay in rotation longer. **Release plan:** launch with all Foundations, Intermediate, Enthusiast, Conversation, Review, Live and branches `french`, `italian`, `american`, `sparkling`; 1.1 adds `iberian` and `southern-hemisphere`; 1.2 adds `german-austrian` and `orange-natural`; live cards refresh seasonally and weekly for news.


### Layer 1: Foundations

**Unit `wine-with-care`: Wine, With Care** (prereq: none). 6 lessons. Adults only, small pours, never pressure. Sets the tone for the whole course.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `care-01` | Wine is for grown-ups | Explain why the course is age-gated and that appreciation comes before drinking. | legal-drinking-age, appreciation-first | mc, bc, st, fg |
| `care-02` | What a drink is | Read ABV and estimate standard pours and pours per bottle. | abv, standard-pour, pours-per-bottle | es, mc, fg, bc |
| `care-03` | Pace, food, water, and the ride home | Describe low-risk hosting habits: food, water, pacing, never driving after drinking. | pacing, water-and-food, never-drive | ds, mc, bc, st |
| `care-04` | You can love wine and not drink it | Show three ways to enjoy wine culture without drinking and treat a non-drinker well. | non-drinker-appreciation, dont-pressure, spit-and-sip | ds, st, mc, tk |
| `care-05` | When not to pour | Recognize when to skip the wine (she says no, medication, pregnancy, recovery) and keep wine talk separate from health talk. | when-to-skip, offer-not-push, wine-talk-not-health-advice | ds, bc, st, mc |
| `care-06` | Zero-proof and low-alcohol wine | Explain dealcoholized and low-alcohol wine and how to offer them gracefully. | dealcoholized-wine, no-low-category | mc, tm, ds, st |

**Unit `wine-basics`: What Wine Actually Is** (prereq: wine-with-care). 6 lessons. Fermented grapes, the main styles, colors, closures, glasses and temperature.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `basics-01` | Grapes, sugar, yeast | Explain that yeast turns grape sugar into alcohol and that fermented grape juice is wine. | wine-is-fermented-grape-juice, yeast-sugar-alcohol | mc, so, fg, st |
| `basics-02` | Still, sparkling, fortified, sweet | Sort wines into still, sparkling, fortified and dessert styles. | wine-categories, fortified-wine, dessert-wine | tm, mc, vi, bc |
| `basics-03` | Red, white, rosé, orange | Explain where wine color comes from. | wine-colors, skin-contact-color | mc, bc, vi, st |
| `basics-04` | The wine grape | Explain Vitis vinifera and why wine grapes are not table grapes. | vitis-vinifera, wine-grape-vs-table-grape | mc, bc, fg, st |
| `basics-05` | Bottles, corks, caps | Recognize bottle shapes and closures and drop the screw-cap myth. | bottle-shapes, closures, screwcap-myth | vi, mc, bc, ds |
| `basics-06` | Glass, temperature, pour | Hold a glass, pour a sensible amount and serve at a sensible temperature. | glassware-basics, serving-temperature, fill-level | ht, es, mc, ds |

**Unit `how-wine-is-made`: How Wine Is Made** (prereq: wine-basics). 6 lessons. Vineyard year, harvest, fermentation, red vs white, oak, bubbles.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `make-01` | The vineyard year | Order the vine year from budbreak to harvest and explain veraison. | vine-cycle, veraison, harvest-timing | so, mc, fg, bc |
| `make-02` | Harvest to crush | Compare hand and machine harvest and explain sorting, destemming and crushing. | hand-vs-machine-harvest, sorting-destemming, crushing-pressing | mc, so, ds, tm |
| `make-03` | Fermentation | Explain alcoholic fermentation, temperature control and wild vs cultured yeast. | alcoholic-fermentation, temperature-control, wild-vs-cultured-yeast | mc, bc, fg, ds |
| `make-04` | Why red is red | Explain maceration and how red, white and rosé are made. | maceration, red-vs-white-process, rose-methods | so, mc, bc, st |
| `make-05` | Oak, steel, and time | Explain oak, stainless steel, lees and malolactic conversion. | oak-aging, stainless-steel, malolactic-fermentation, lees-contact | tm, mc, ds, st |
| `make-06` | Bubbles and fortified | Explain traditional method, tank method and fortification. | traditional-method, tank-method, fortification | so, mc, tm, bc |

**Unit `tasting-structure`: Tasting: The Structure** (prereq: wine-basics). 6 lessons. Sweetness, acidity, tannin, body, balance: the shared vocabulary of every tasting conversation.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `taste-01` | Sweet or dry | Separate dry from sweet and fruity from sweet. | residual-sugar, dry-vs-fruity | mc, bc, es, st |
| `taste-02` | Acidity | Describe acidity as mouthwatering freshness and link it to climate. | acidity, mouthwatering, acid-and-climate | mc, ds, fg, st |
| `taste-03` | Tannin | Describe tannin as drying grip and name where it comes from. | tannin, astringency, tannin-sources | mc, bc, ds, st |
| `taste-04` | Body | Place a wine on the light to full body scale and link it to alcohol. | body, alcohol-weight, extract | mc, vi, ds, st |
| `taste-05` | Balance, length, complexity | Use balance, finish and complexity to talk about quality. | balance, finish, complexity | mc, ds, fg, st |
| `taste-06` | The four-step taste | Run look, swirl and smell, sip, think and skip the tongue-map myth. | tasting-routine, swirl-and-sniff, tongue-map-myth | so, bc, ht, tk |

**Unit `aromas-flavors`: Aromas and Flavors** (prereq: tasting-structure). 5 lessons. Why smell is the main sense, the three aroma families, and faults vs style.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `aroma-01` | Smell does the work | Explain retronasal smell and the difference between aroma and flavor. | retronasal-smell, aroma-vs-flavor | mc, bc, fg, st |
| `aroma-02` | Three aroma families | Sort primary, secondary and tertiary aromas. | primary-aromas, secondary-aromas, tertiary-aromas | tm, mc, ds, st |
| `aroma-03` | The fruit ladder | Read the fruit spectrum from citrus to tropical and red to black as a ripeness signal. | fruit-spectrum, ripeness-signal | so, mc, ds, st |
| `aroma-04` | Not just fruit | Recognize floral, herbal, earthy, spice and mineral notes and the mineral debate. | floral-herbal-earth, oak-spice-notes, mineral-debate | mc, tm, bc, st |
| `aroma-05` | Faulty or just not your style? | Tell cork taint, oxidation and reduction from personal preference. | cork-taint, oxidation, reduction, fault-vs-preference | mc, ds, bc, st |

**Unit `grapes-core`: The Grapes You Will Meet** (prereq: aromas-flavors). 6 lessons. The dozen grapes behind most conversations, in style families rather than a list.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `grape-01` | Chardonnay and its many faces | Explain why Chardonnay can taste lean or buttery. | chardonnay, oaked-vs-unoaked | mc, ds, tm, st |
| `grape-02` | Crisp whites | Describe Sauvignon Blanc, Pinot Grigio and the crisp white family. | sauvignon-blanc, pinot-grigio-gris, crisp-whites | mc, tm, ds, st |
| `grape-03` | Aromatic whites | Describe Riesling, Gewürztraminer and Chenin Blanc. | riesling, gewurztraminer, chenin-blanc | mc, tm, li, st |
| `grape-04` | Light and silky reds | Describe Pinot Noir, Gamay and Grenache. | pinot-noir, gamay, grenache | mc, tm, ds, st |
| `grape-05` | Bold reds | Describe Cabernet Sauvignon, Merlot, Syrah and Malbec. | cabernet-sauvignon, merlot, syrah-shiraz, malbec | tm, mc, ds, st |
| `grape-06` | Blends and names | Explain blends and the Bordeaux and Rhône blend logic. | blends-rule, bordeaux-blend, gsm-blend | mc, tm, bc, st |


### Layer 2: Intermediate

**Unit `regions-old-world`: Regions: The Old World** (prereq: grapes-core). 6 lessons. Europe, where place names are the label: France, Italy, Spain, Portugal, Germany, Austria.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `old-01` | Old World, New World (and why it is shaky) | Use Old World and New World as a rough style guide and know its limits. | old-vs-new-world, place-over-grape | mc, bc, ds, st |
| `old-02` | France: Bordeaux and Burgundy | Place Bordeaux and Burgundy and name their main grapes. | bordeaux-left-right, burgundy-pinot-chardonnay | ht, mc, tm, st |
| `old-03` | France: Rhône, Loire, Alsace, Champagne | Place the other great French regions and their signature wines. | french-regions-map, rhone-loire-alsace, champagne-region | ht, tm, mc, li |
| `old-04` | Italy | Explain Italy as a patchwork of native grapes: Sangiovese, Nebbiolo and more. | italian-regions, sangiovese, nebbiolo | ht, tm, mc, st |
| `old-05` | Spain and Portugal | Place Rioja, Rías Baixas, Sherry, Douro and Vinho Verde. | rioja-tempranillo, sherry-port, vinho-verde | tm, mc, ht, st |
| `old-06` | Germany, Austria, and the rest | Describe Mosel Riesling, Grüner Veltliner and older wine countries like Greece and Georgia. | riesling-mosel, gruner-veltliner, ancient-wine-countries | mc, tm, li, st |

**Unit `regions-new-world`: Regions: The New World** (prereq: grapes-core). 5 lessons. The Americas, Australasia and South Africa: labels that name the grape, styles that follow the sun.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `new-01` | California and the West Coast | Place Napa, Sonoma, Oregon and Washington. | napa-sonoma, oregon-pinot, washington-wine | ht, mc, tm, st |
| `new-02` | Australia and New Zealand | Place Barossa, Margaret River, Marlborough and Central Otago. | barossa-shiraz, marlborough-sauvignon, central-otago-pinot | tm, mc, ds, st |
| `new-03` | Chile and Argentina | Explain Chile's long valleys, Carmenère and Mendoza Malbec. | chile-carmenere, argentina-malbec, altitude-viticulture | mc, tm, bc, st |
| `new-04` | South Africa | Explain Stellenbosch, Chenin Blanc, Pinotage and the Cape Blend. | south-africa-chenin, pinotage, cape-blend | mc, tm, bc, st |
| `new-05` | New and surprising regions | Name rising regions such as English sparkling wine and why the map is changing. | english-sparkling, emerging-regions, warming-map | mc, bc, ds, st |

**Unit `label-reading`: Reading a Label** (prereq: regions-old-world). 6 lessons. What labels must say, how countries differ, and which words mean nothing.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `label-01` | What every label says | List the usual required label facts and read ABV and vintage. | label-requirements, abv-on-label, vintage-meaning | ht, mc, fg, bc |
| `label-02` | Grape or place? | Tell a grape-named label from a place-named label and explain the 75 percent rule. | varietal-label, appellation-label, 75-percent-rule | mc, tm, ds, st |
| `label-03` | France decoded | Read AOC/AOP, the Burgundy ladder and the 1855 Bordeaux classification. | aoc-aop, burgundy-ladder, bordeaux-1855 | so, tm, mc, st |
| `label-04` | Italy and Spain decoded | Read DOC, DOCG, Riserva, Crianza, Reserva and Gran Reserva. | doc-docg, riserva, spanish-aging-terms | tm, so, mc, st |
| `label-05` | Germany and Portugal decoded | Read Prädikat levels, Trocken and Port styles. | pradikat, trocken-halbtrocken, port-styles | so, tm, mc, st |
| `label-06` | New World labels and marketing words | Read AVAs, know why Reserve can mean nothing and read the sparkling sweetness scale. | ava, reserve-meaningless, sparkling-sweetness-scale | so, mc, bc, st |

**Unit `food-pairing`: Food Pairing Basics** (prereq: tasting-structure). 6 lessons. Principles, not rules: weight, acid, tannin, sweetness, and what grows together.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `pair-01` | Match the weight | Match wine weight to food weight. | pairing-intensity, weight-matching | mc, ds, bc, st |
| `pair-02` | Acid, fat, salt, sweet | Explain why acid cuts fat and salt meets sweet. | acid-cuts-fat, salty-sweet | mc, ds, fg, st |
| `pair-03` | Tannin, spice and heat | Explain tannin with protein and why spice clashes with alcohol and tannin. | tannin-protein, spice-and-alcohol, off-dry-with-spice | ds, mc, bc, st |
| `pair-04` | Cheese and the red-wine myth | Explain why white and bubbles often beat red with cheese. | cheese-pairing, red-with-cheese-myth | mc, bc, ds, st |
| `pair-05` | What grows together, and bubbles | Use regional logic and explain why sparkling loves salty and fried food. | grows-together, bubbles-with-fried | mc, ds, tm, st |
| `pair-06` | Sweet wines, broken rules | Match dessert wines and know when to ignore the rules. | sweeter-than-the-food, drink-what-you-like | ds, mc, bc, tk |

**Unit `wine-list-confidence`: Restaurant Wine-List Confidence** (prereq: food-pairing). 5 lessons. From reading the list to the tasting pour to the honest budget sentence.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `list-01` | Reading the list | Read how lists are organized and when by-the-glass is the smart choice. | list-structure, by-the-glass | mc, ds, tm, st |
| `list-02` | The order ritual | Order the steps of presentation, cork or cap, tasting pour and pouring. | bottle-presentation, tasting-pour, corked-check | so, mc, bc, ds |
| `list-03` | Price, markup, value | Explain restaurant markup and value picks and skip the second-cheapest myth. | restaurant-markup, value-picks, second-cheapest-myth | mc, ds, es, st |
| `list-04` | Talking to the sommelier | Give a budget and a taste in one sentence. | budget-phrase, describe-what-you-like, ask-the-sommelier | st, ds, tk, mc |
| `list-05` | Gifts, BYO and hosting | Choose a bottle to bring and handle corkage and hosting etiquette. | byob-etiquette, bring-a-bottle, corkage | ds, mc, st, bc |


### Layer 3: Enthusiast depth

**Unit `terroir-vintage`: Terroir, Vintage, and Farming** (prereq: regions-old-world). 5 lessons. The big enthusiast arguments about place, year and how grapes are farmed.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ter-01` | What terroir means | Explain terroir and why skeptics push back. | terroir, terroir-skeptics | mc, bc, ds, st |
| `ter-02` | Soil, slope, sun | Explain how slope, aspect and day-night temperature swings shape grapes and why the soil-flavor link is debated. | soils-debate, slope-aspect, diurnal-range | mc, tm, ds, st |
| `ter-03` | Vintage variation | Explain vintage variation and the limits of vintage charts. | vintage-variation, vintage-chart-limits, non-vintage | mc, bc, ds, st |
| `ter-04` | Climate change and wine | Explain how warming shifts harvest dates, styles and maps. | climate-change-vines, earlier-harvests, regions-shift | mc, bc, ds, st |
| `ter-05` | Organic, biodynamic, sustainable | Tell organic, biodynamic and sustainable apart and stay skeptical of vague claims. | organic-vs-biodynamic, sustainable-certifications, greenwashing-caution | tm, mc, bc, st |

**Unit `sommelier-culture`: Sommelier Culture and Wine Stories** (prereq: wine-list-confidence). 5 lessons. Credentials, blind tasting, scores and five moments that shaped modern wine.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `somm-01` | What a sommelier does | Describe a sommelier's actual job beyond the cliche. | sommelier-job, service-and-stock | mc, bc, ds, st |
| `somm-02` | Levels and letters | Tell Court of Master Sommeliers, WSET and Master of Wine apart. | court-of-master-sommeliers, wset-levels, master-of-wine | tm, mc, bc, st |
| `somm-03` | Blind tasting | Explain deductive tasting and why blind tasting humbles everyone. | blind-tasting, deductive-method | so, mc, ds, st |
| `somm-04` | Scores, critics, tasting notes | Explain the 100-point scale, score inflation and tasting-note language. | hundred-point-scale, score-inflation, tasting-note-language | mc, bc, tm, st |
| `somm-05` | Five moments in wine history | Place the Judgment of Paris, phylloxera and the appellation idea. | judgment-of-paris, phylloxera, appellation-origin | so, mc, bc, st |

**Unit `natural-orange-debates`: Natural, Orange, and Other Debates** (prereq: how-wine-is-made). 5 lessons. The arguments she may actually be having: what natural means, skin-contact wine, funk, sulfites.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `nat-01` | What 'natural' means | Explain why natural wine has no single legal definition. | natural-wine, no-legal-definition | mc, bc, ds, st |
| `nat-02` | Orange wine and qvevri | Explain skin-contact white wine and Georgian qvevri. | orange-wine, qvevri | mc, tm, bc, st |
| `nat-03` | Pét-nat and the funky side | Explain pét-nat, brett and mousiness. | pet-nat, brettanomyces, funk-vs-fault | mc, tm, ds, st |
| `nat-04` | Sulfites and what is in wine | Explain sulfites and additives without medical claims. | sulfites-basics, additives-debate, sulfite-myths | mc, bc, ds, st |
| `nat-05` | Arguing kindly | Discuss conventional vs natural without snobbery. | conventional-vs-natural, both-can-be-great, no-snobbery | ds, st, tk, mc |

**Unit `collecting-price`: Collecting and Price Myths** (prereq: terroir-vintage). 5 lessons. Why wine costs what it costs, what ages, how to store it, and when collecting becomes a trap.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `coll-01` | Why wine costs what it costs | Explain land, yield, scarcity, brand and logistics as cost drivers. | cost-drivers, scarcity-and-brand | mc, ds, bc, st |
| `coll-02` | Price vs quality | Explain diminishing returns and what blind studies found. | price-quality-curve, blind-price-studies | mc, bc, es, st |
| `coll-03` | What actually ages | Explain drink windows and that most wine is for now. | ageability, drink-windows, most-wine-drink-now | mc, bc, ds, es |
| `coll-04` | Storage and cellars | Explain storage conditions and provenance. | storage-conditions, cellar-vs-fridge, provenance | mc, ds, es, bc |
| `coll-05` | Fine wine as a hobby (and its traps) | Explain en primeur, auctions and counterfeits and never collect to impress. | en-primeur, auction-provenance, counterfeits-caution | mc, bc, ds, st |


### Layer 4: Branches and personalization

Each branch unit has `layer: branch` and a `branchId`. Prereqs as listed. Tokens: `{{region}}`, `{{style}}`, `{{cuisine}}`.

**Unit `branch-french`: French Wine** (branch `french`) (prereq: grapes-core, regions-old-world). 3 lessons. Burgundy and Bordeaux in depth, pronunciation and how French wine people talk.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fr-01` | Burgundy in depth | Explain climats, village vs cru and why Burgundy fascinates. | climats, burgundy-village-cru | mc, so, ds, st |
| `fr-02` | Bordeaux, Rhône, Loire | Read left bank vs right bank and Rhône north vs south. | left-right-bank, rhone-north-south, loire-styles | tm, mc, ds, st |
| `fr-03` | Saying French wine out loud | Pronounce key names and talk about terroir with confidence. | french-pronunciation, terroir-talk | li, st, tk, mc |

**Unit `branch-italian`: Italian Wine** (branch `italian`) (prereq: grapes-core, regions-old-world). 3 lessons. Native grapes, Piedmont and Tuscany, appassimento and food logic.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `it-01` | Piedmont and Tuscany | Explain Nebbiolo in Barolo and Barbaresco, and Sangiovese in Chianti Classico and Brunello. | barolo-barbaresco, chianti-classico, brunello | mc, tm, ds, st |
| `it-02` | Veneto, Sicily, and beyond | Explain Amarone, Soave, Prosecco and Etna. | amarone-appassimento, etna-volcanic, prosecco-veneto | mc, tm, ht, st |
| `it-03` | Italian wine with Italian food | Explain food-first wine logic and the Super Tuscan story. | italian-food-logic, super-tuscan | ds, mc, tk, st |

**Unit `branch-iberian`: Spanish and Portuguese Wine** (branch `iberian`) (prereq: grapes-core, regions-old-world). 3 lessons. Rioja, Ribera, Sherry, Port, Douro, Vinho Verde and Cava.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ib-01` | Rioja and Ribera del Duero | Explain Tempranillo and Spanish aging terms. | rioja-styles, ribera-del-duero | mc, tm, so, st |
| `ib-02` | Sherry and Port | Explain fortified styles, solera and Port categories. | sherry-styles, solera-system, port-categories | tm, mc, bc, st |
| `ib-03` | Albariño, Vinho Verde, Cava | Explain the fresh coastal whites and Cava. | albarino, vinho-verde-style, cava | mc, ds, tm, st |

**Unit `branch-american`: American Wine** (branch `american`) (prereq: grapes-core, regions-new-world). 3 lessons. Napa, Sonoma, Paso, Oregon, Washington, the Finger Lakes and tasting-room manners.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `us-01` | Napa, Sonoma, Paso | Explain the California regions and their styles. | napa-cabernet, sonoma-diversity, paso-robles | mc, ht, tm, st |
| `us-02` | Oregon, Washington, Finger Lakes | Explain Willamette Pinot, Columbia Valley and cool-climate Riesling. | willamette-pinot, columbia-valley, finger-lakes-riesling | mc, tm, ds, st |
| `us-03` | Tasting rooms and California labels | Read a California label and behave well at a tasting room. | california-label-rules, tasting-room-etiquette | so, ds, mc, tk |

**Unit `branch-southern-hemisphere`: Southern Hemisphere Wine** (branch `southern-hemisphere`) (prereq: grapes-core, regions-new-world). 3 lessons. Australia, New Zealand, Chile, Argentina and South Africa in depth.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sh-01` | Australia in depth | Explain Barossa, Eden Valley, Margaret River and old vines. | old-vine-shiraz, eden-valley-riesling, margaret-river | mc, tm, ds, st |
| `sh-02` | New Zealand, Chile, Argentina | Explain Marlborough, Hawke's Bay, Maipo and Uco Valley. | hawkes-bay, maipo-cabernet, uco-valley | mc, tm, ht, st |
| `sh-03` | South Africa in depth | Explain the Cape's old vines and Swartland. | swartland, old-vine-chenin | mc, tm, ds, st |

**Unit `branch-sparkling`: Sparkling Wine** (branch `sparkling`) (prereq: how-wine-is-made, regions-old-world). 3 lessons. Champagne, Prosecco, Cava, Crémant, serving and celebrating responsibly.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sp-01` | Champagne in depth | Explain grower vs house, non-vintage vs vintage, blanc de blancs and dosage. | champagne-houses-growers, blanc-de-blancs-noirs, dosage | mc, tm, so, st |
| `sp-02` | Prosecco, Cava, Crémant and friends | Compare tank and traditional method sparkling wines. | prosecco-vs-champagne, cremant, sparkling-price-logic | tm, mc, bc, st |
| `sp-03` | Serving bubbles safely | Open a bottle safely, choose a glass and toast responsibly. | opening-safely, sparkling-glassware, toast-etiquette | so, li, ds, st |


### Layer 5: Current-season / live

Templates plus `live` hooks; content changes weekly or seasonally (see `live-data.md`). Evergreen fallback always available.

**Unit `wine-now`: Wine Right Now** (prereq: grapes-core). 4 lessons. Current-season layer: harvest reports, wine in the news, seasonal moments, new releases. Refreshed from live hooks.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `now-01` | This year's harvest | Read a harvest report and ask what it changes for the wine she drinks. | harvest-report-reading, vintage-in-the-making | mc, ds, st, bc |
| `now-02` | Wine in the news | Read a wine headline on tariffs, climate or consumption trends. | wine-news-literacy, consumption-trends, trade-and-tariffs | mc, ds, st, bc |
| `now-03` | Seasonal wine moments | Explain Beaujolais Nouveau, rosé season and holiday tables, plus respect for Dry January. | seasonal-wine-calendar, beaujolais-nouveau, dry-january-respect | mc, tm, ds, st |
| `now-04` | New releases and what people chase | Explain release cycles and why some bottles get hyped. | release-cycles, hype-bottles, nolo-launches | mc, bc, ds, st |


### Layer 6: Conversation practice

**Unit `talking-wine`: Talking About Wine** (prereq: wine-basics). 8 lessons. Continuous conversation practice: curious, honest, never faking it.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `conv-01` | She loves this bottle | Ask questions about a bottle she loves instead of judging it. | ask-not-judge, bottle-stories | tk, st, mc, ds |
| `conv-02` | Admitting you do not know | Say 'I don't know it, tell me' warmly. | honest-gaps, curiosity-lines | tk, st, ds, mc |
| `conv-03` | At a tasting room | Ask two good questions at a tasting. | tasting-room-talk, good-questions | tk, st, ds, mc |
| `conv-04` | At the restaurant together | Order together without performing. | order-together, share-the-decision | tk, ds, st, mc |
| `conv-05` | When she is not drinking tonight | Respond warmly when she says no. | skip-gracefully, no-pressure-lines | tk, ds, st, mc |
| `conv-06` | The natural wine argument | Stay curious in a debate. | debate-curiosity, both-sides | tk, st, mc, ds |
| `conv-07` | Choosing a bottle as a gift | Pick a thoughtful bottle for her, honestly. | gift-bottle, listen-for-tastes | tk, ds, st, mc |
| `conv-08` | The toast | Give a short, sincere toast and stop at one. | short-toast, sincere-not-clever | tk, st, mc, ds |


### Layer 7: Perpetual review

**Unit `wine-review`: Keep It Fresh** (prereq: wine-basics). 4 lessons. Spaced review of mastered concepts in short mixed sessions.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Structure recap | Revisit acidity, tannin, body and sweetness. | review-structure | mc, bc, fg, st |
| `review-02` | Grapes and places recap | Revisit grape families and regions. | review-grapes-places | tm, mc, ht, st |
| `review-03` | Labels and lists recap | Revisit label words and restaurant steps. | review-labels-lists | tm, so, mc, ds |
| `review-04` | What is she talking about? | Mixed decoding of real-sounding lines. | review-decode | st, tk, mc, ds |

## 12. Interaction plan

Tier rubric (`CLAUDE.md` section 4): Unity only where spatial reasoning, movement, physics, timing in a scene or camera perspective materially improves learning and a native exercise would teach it clearly worse. **No row below is Tier A.** Every Unity candidate was evaluated in section 5 and rejected. `unitySimulations` in the manifest is empty; there is no `sims/` folder.

| Lesson / activity family | Concepts | Type (native exercise) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Judgment: the list, the corked bottle, pairing spicy food, budget, gifts, "not tonight" | restaurant-markup, cork-taint, off-dry-with-spice, offer-not-push, budget-phrase | `decision-scenario` | Wine skill is judgment from facts (spec section 17 style). Best / acceptable / poor teaches reasons; a sim would only animate the outcome. `safetyNote` on every scenario that involves drinking or pressure. | B | ~100 |
| Processes: making red, the vine year, tasting routine, restaurant bottle ritual, opening bubbles | maceration, vine-cycle, tasting-routine, bottle-presentation, opening-safely | `sequence-order` | Order is the concept and each step has a `why` (catalog #4). | B | ~40 |
| Fact and why checks (structure, grapes, regions, labels, pairing) | most | `multiple-choice` | Default recall and understanding card; distractors are the misconceptions in section 2. | B | ~170 |
| True / myth calls | screwcap-myth, serving-temperature, most-wine-drink-now, sulfite-myths, opening-safely | `binary-call` | Two-way judgments with `scene.kind: none`. Sulfite items never give medical advice. | B | ~50 |
| Vocabulary: structure, process, label, credentials | acidity, tannin, maceration, pradikat, court-of-master-sommeliers | `term-match`, `fill-the-gap` | Recall and recognition in context. | B | ~75 |
| Recognize bottles, closures, glasses, color ladders | bottle-shapes, closures, fruit-spectrum, ripeness-signal | `visual-id` | Recognition is the skill. Original vector art only (`original-swoond`); no real labels or brands. | B | ~35 |
| Diagrams: glass, bottle, generic label, region maps | glassware-basics, label-requirements, french-regions-map, italian-regions | `hotspot-tap` | Static diagram with correct regions; no motion needed (catalog #13). | B | ~30 |
| Pronunciation and the sound of a safe opening | french-pronunciation, opening-safely | `listening-id` | Sound is the point: saying "Sancerre" and "Gewürztraminer" out loud is a real social skill. Original or synthesized audio; Skip and text alternative always available. | B | ~20 |
| Pours, temperatures, ABV, days open | pours-per-bottle, serving-temperature, abv, storage-conditions | `estimate-slider` | Numeric intuition; tolerances are generous. Never used to calibrate drinking amounts. | B | ~30 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice: 20 talk tracks and ~70 say-this items. | B | 20 + ~70 |

**Native exercise types used:** multiple-choice, binary-call, term-match, sequence-order, visual-id, decision-scenario, talk-track, say-this, fill-the-gap, listening-id, estimate-slider, hotspot-tap (12 of 13). **`timing-tap` unused** (no 1D timing skill). **`unity-sim` unused.** Estimated total native items about 640 across 117 lessons and the review loop.

**Accessibility:** `listening-id` always has a text alternative and Skip; `visual-id` `alt` describes distinguishing features without revealing the answer; no exercise relies on color alone (the color ladder uses labels); every tasting item has a no-drinking path (smell, read, choose a description); no exercise requires taste, smell or sight to pass (alternate "describe it" versions).

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| Imagery | Procedural or original illustration only (`license: original-swoond`): generic bottle silhouettes, closures, glass shapes, fictional labels, region maps, vine-cycle and process diagrams, an original aroma wheel. **No real winery labels, bottle photographs, vineyard or estate photography, wine-region tourism photos or trade dress** (spec section 40 and rule 10). Any label shown in a drill is fictional. A feature where the learner photographs their own bottle to practice label reading runs on-device only and is never uploaded or shown to others. |
| Audio | Original or synthesized pronunciation and sound clips (`original-swoond`). No audio from videos, podcasts, documentaries or TTS whose licence forbids app distribution (verify TTS terms). |
| Logos / trademarks | Wineries, brands, critics' publications, Champagne houses, and certification bodies appear as text where a lesson needs them; no logos. Protected names (Champagne, Chianti, Rioja, Port) are used as geographic-indication facts. |
| Video | None embedded; deep-link to official pages. |
| Tasting notes, scores, critic text | Never copied. Swoon'd writes its own tasting descriptions; critic scores are not reproduced (proprietary). The 100-point scale is taught as a concept. |
| Article text | Never copied; explain and link (spec section 11). |
| Lyrics / music | Not applicable. |
| Data terms | OIV and trade-body statistics are cited as facts with a link (verify reuse terms). Weather and climate data (Open-Meteo, NOAA, Copernicus) need terms review (Open-Meteo free tier is non-commercial; paid plan for commercial use) **[verify at adapter build]**. No price or ratings feed (Wine-Searcher, Vivino, Liv-ex, critic databases are proprietary; no scraping). |
| Player likeness | N/A. Real sommeliers, winemakers and critics are named as facts only; no likeness, no fabricated quotes, no endorsement implication. |

**Responsible-drinking and safety rules (state in manifest `safetyConstraints`):**
- **Legal age gate (app requirement):** the course is only available to learners who have confirmed they are of legal drinking age in their jurisdiction (21 in the United States; it differs elsewhere). The gate is an app-level feature, not course content (see `NOTES_FOR_ORCHESTRATOR.md`: age confirmation, jurisdiction, store age rating). Under-age users never see the course and no content is shown on the course card beyond a neutral "age-restricted". Learners of legal age who do not drink are welcome.
- **Appreciation first, non-drinker-friendly:** every unit works with smell, reading, pairing talk, conversation and zero-proof options; unit `wine-with-care` teaches "you can love wine and not drink it". No lesson requires consumption.
- **Never encourage heavy drinking:** no drinking games, speed, challenges, "finish the bottle", tolerance, or toasts to excess; no streak, badge or XP tied to drinking. Toasts stop at one. Pour sizes taught are small (about 5 fl oz / 150 ml, five per 750 ml bottle). Pace, food, water; never drive after drinking; arrange a safe ride.
- **Offer, never push:** "no" and "not tonight" are complete answers; no scenario asks why; a Talk Track penalizes pressure.
- **No health or nutrition claims:** no "healthy", "antioxidant", "heart-healthy", calorie, diet or weight-loss framing. Swoon'd does not say moderate drinking is good for you or bad for you. The 2025-2030 US Dietary Guidelines (released 7 January 2026) advise consuming less alcohol for better overall health without numeric daily limits **[verify at release]**; Swoon'd links to official guidance and does not restate numbers as medical advice.
- **Pregnancy, medication, recovery, health conditions:** one fixed, neutral line wherever relevant: "Some people should not drink at all, including if pregnant, on certain medications or in recovery. If that is her, skip it and ask a clinician for anything health-related." Swoon'd gives no medical advice and does not ask about anyone's health.
- **Sulfites and additives:** facts only (sulfites occur naturally, are commonly added as a preservative, the US label statement applies at 10 ppm or more); no claim about headaches; "if you think you react to something, ask a clinician".
- **Discreet mode (default ON):** notifications never contain the Person's name; wine course notifications use neutral text and never mention alcohol on the lock screen (for instance "A quick lesson is waiting"); no analytics event carries the Person's name or drinking preferences.
- **Sparkling safety:** bottle opening lessons (hold the cork, twist the bottle, aim away, never saber) follow mainstream service guidance.
- **No fake expertise:** never coach the learner to claim vintages, producers or credentials they do not have; "ask, don't pretend".
- **Voice:** jokes target wine snobbery and the learner's unfamiliarity, never her taste, budget, family drinking habits or choice not to drink; no mocking of cheap wine or expensive wine drinkers.

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Bottle silhouettes (Bordeaux, Burgundy, flute, Champagne); closures; glass shapes and glass-tilt color ladders | Procedural vector | Swoon'd | `original-swoond` |
| Fictional generic wine label | Procedural vector | Swoon'd | `original-swoond` |
| Stylized region maps (France, Italy, Spain and Portugal, Germany, California, Oregon and Washington, Australia and New Zealand, South America, South Africa) | Procedural vector | Swoon'd | `original-swoond` |
| Vine-cycle, fermentation flow, oak and steel, traditional vs tank method diagrams | Procedural vector | Swoon'd | `original-swoond` |
| Aroma wheel (original design, not a reproduction of any published wheel) | Procedural vector | Swoon'd | `original-swoond` |
| Pronunciation clips, sparkling sigh | Synthesized or recorded in-house | Swoon'd | `original-swoond` |
| Harvest, event and release cards | Data cards, no images | Curated | n/a |
| Headline cards | Text and link only | Publishers (link-only) | n/a (no images) |

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** What wine is, structure, aromas, a handful of grape families, reading a label, the respectful frame (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Regions, vintages, producers, natural vs conventional, terroir, sommelier culture, collecting and price myths (section 4).
- [x] 3. **What current information matters?** Harvest conditions, events, releases, news on tariffs, climate and consumption, label rule changes; no scoreboard (section 6).
- [x] 4. **What should be interactive?** Judgment scenarios, sequencing, recognition, region and label diagrams, pronunciation, conversation; zero Unity (sections 5, 12).
- [x] 5. **What should NOT be gamified?** Drinking, scoring of palates, collecting and price speculation, natural-vs-conventional sides (section 5).
- [x] 6. **How should it personalize?** region, style, cuisine, skill-level (section 8).
- [x] 7. **What does conversational competence look like?** Curious questions, honest gaps, warmth around "not tonight", a short sincere toast (sections 9, 10).
- [x] 8. **What data providers are needed?** Curated editorial calendars, link-only news, public climate data, link-out regulation pages (`live-data.md`).
- [x] 9. **What licensing constraints apply?** No real labels, bottle photography, brand marks, critic text or scores; original art and audio (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, care-unit gate, review ladder, talk-track Smooth >= 60, competence statement (section 10).

Additional gates: [ ] manifest validates (run `tools/validate`); [ ] curriculum validates (not yet authored); [x] no Unity sims, so no sim specs to approve; [ ] every image/audio asset has a license id (assets not yet produced; ids defined); [ ] responsible-alcohol review by a qualified reviewer (see open questions); [ ] age-gate implemented in the app; [ ] voice review; [x] no copied publisher text (all copy original).

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Approve zero Unity sims for wine (rationale in sections 5 and 12). | Product | No |
| 2 | **Age gate:** how does the app confirm legal drinking age (self-declaration, date of birth, region-based age, App Store age rating)? What happens to a Person-linked course for an under-age learner? Blocks release of this course (`P` item proposed). | Product/Legal/App | Yes for release |
| 3 | **Responsible-alcohol review:** qualified review (public-health or alcohol-policy educator, plus a Certified Sommelier or WSET-certified educator for accuracy) of `wine-with-care`, `care-*` items, `conv-05`, pairing and sparkling safety. Recommended release gate, mirrors P-18/S-05. | Product/Content | Yes for release |
| 4 | App Store and Google Play alcohol-content policies and age ratings; ads/marketing restrictions if any; is the course eligible in regions with strict alcohol-content rules? | Legal/Product | Yes for release |
| 5 | Unit count 24 (6+5+4+6+1+1+1) exceeds 8-14; approve, or fold the six branch units into a tagged `branches` unit (as pickleball does). | Product | No |
| 6 | Launch branch set: `french`, `italian`, `american`, `sparkling` at launch and `iberian`, `southern-hemisphere` at 1.1? Add `german-austrian` and `orange-natural` later? | Product | No |
| 7 | Copy for the health line: is the fixed neutral line in section 13 acceptable, and should the app link to national guidance (which country, which agency)? | Product/Legal | No |
| 8 | Should the optional on-device "scan my bottle" label practice feature ship (Vision OCR, no upload)? | Product/App | No |
| 9 | Pronunciation clips: record in-house or synthesize (licence check for TTS)? Who reviews pronunciations (French, Italian, German, Spanish speakers)? | Content/Product | No |
| 10 | Shared `grape` personalization dimension (manifest enum) or keep `style`. | Product | No |
