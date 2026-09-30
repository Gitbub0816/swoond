# Course Design Specification: Cooking (`cooking`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Cooking is a **technique-and-understanding course with no scoreboard**: it teaches *why* food behaves the way it does (heat, salt, fat, acid, water), how to use a knife and a pan, how kitchens and cuisines talk, and how to keep people safe. The learner is learning because someone they care about loves to cook; the goal is to understand her kitchen, not to fake a chef's résumé.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Cooking course design agent (Claude), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion docs | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity sims, justified in section 5 and section 12) |

Verification note: time-sensitive and safety facts below were checked by web search on **2026-09-30** (USDA FSIS safe minimum temperatures and leftovers/thawing guidance, FDA Food Code 2022 cooling rule, The Bear final season, Top Chef season 23, 2026 James Beard Outstanding Chef). Anything marked **[verify at release]** must be re-checked before content ships (see `NOTES_FOR_ORCHESTRATOR.md`).

---

## 1. Identity
- **Course ID:** `cooking` (immutable)
- **Display name:** Cooking
- **Category / family:** Food & Cooking; category path `Food & Cooking > Cooking`
- **Simulation prefix:** `cooking` (reserved; **no sims are planned**, so no `cooking.<topic>.<name>.vN` id exists)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns cooking, are they meaningfully conversationally competent about it?" | Verdict | Consequence for structure |
|---|---|---|---|
| Baking / pastry (not a catalog course) | Partly. Heat, salt, fat, acid, knife and safety transfer; baking's precision, leavening, gluten and sugar chemistry do not. | Shares foundation | Baking is a **branch** (`baking`, 5 lessons), not a separate course. Cross-links to `kitchen-science` (gluten, eggs, emulsions). |
| Coffee (`coffee`, Wave 3) | Barely. Both involve extraction and heat, but grind, ratio, water chemistry and espresso culture are their own language. | Adjacent, independent | No coffee content here beyond "the kitchen has a grinder." Cross-link only. |
| Wine (`wine`, Wave 3) | Partly. Pairing talk (acid, fat, salt, tannin) transfers; grapes, regions, vintages and tasting do not. | Adjacent, independent | Cooking teaches "acid and fat balance" as food logic; any pairing lesson links out to the wine course once it exists. Alcohol in cooking is covered only as an ingredient (deglazing, wine reductions). |
| Camping (`camping`, Wave 2) | Partly. Food safety, heat and stove basics transfer; campcraft, fire management, bear-safe storage and packing do not. | Adjacent, independent | The `bbq-grilling` branch teaches fire and smoke for a backyard; camp cooking belongs to camping. |
| Pottery (`pottery`, Wave 2) | No, aside from the shared pleasure of a handmade bowl. | Independent | No structural consequence. |
| Nutrition, dieting, fitness | No. Different goals, and health claims are outside Swoon'd's remit. | Out of scope | The course teaches cooking, not diets; no calories, macros, weight-loss or medical claims (section 13). |
| Restaurants / hospitality / food media | Partly: kitchen culture and cooking media are how many enthusiasts talk about cooking. | Shares foundation | Covered as enthusiast units `kitchen-culture` and `cooking-media`; no separate course. |

- **Branches** (one chosen or inferred from the Person's stated cuisine; each adds a `branch` layer unit with `branchId`; `everyday` is the default and has no branch-only unit because all shared units already serve it):

| id | Name | What changes (technique, pantry, culture) |
|---|---|---|
| `everyday` | Everyday home cooking (default) | Weeknight dinners, pantry cooking, cooking for two; the shared core units are its curriculum. |
| `baking` | Baking and pastry | Weight-based precision, leaveners, gluten, creaming, lamination, bread and sourdough culture; raw flour and raw dough safety. |
| `italian` | Italian | Restraint and ingredient quality, soffritto, pasta logic (shape, al dente, finishing in the pan), regional identity; fierce "rules". |
| `french` | French | The classical method: mother sauces, butter and wine reductions, the brigade heritage, bistro classics. |
| `mexican` | Mexican | Corn and masa, nixtamalization, dried chiles, salsas and moles, regional Mexico; Mexican vs Tex-Mex conversations. |
| `chinese` | Chinese | The wok and *wok hei*, velveting, the pantry (soy, Shaoxing, vinegars, doubanjiang), regional cuisines, Sichuan *mala*. |
| `japanese` | Japanese | Dashi and umami, rice, knife culture, seasonality and restraint, izakaya and ramen-shop food. |
| `indian` | Indian | *Tadka* and spice blooming, regional staples, ghee, dal, breads and biryani, the word "curry". |
| `bbq-grilling` | BBQ and grilling | Fire management, direct vs indirect heat, low-and-slow smoking, the stall, regional styles; carbon monoxide and fire safety. |

Branches not built at launch: see release plan (section 11). **No cuisine ranking, no "authenticity police"**: branch units teach how a cuisine works and how its cooks talk, not which is best.

## 2. Beginner model
- **What a complete beginner typically knows:** they can boil pasta, scramble an egg, reheat leftovers, follow a recipe line by line, and order takeout. They have watched cooking videos and think cooking is "following instructions." They believe cooks "just know" amounts and that a recipe is a rulebook rather than a description of a process. They usually do not know why a step exists.
- **Terminology that will initially confuse them:** *mise en place*, sauté, sweat, sear, deglaze, fond, reduce, braise, blanch, shock, julienne, brunoise, chiffonade, roux, emulsify, bloom, rest, carryover, al dente, "season to taste", "until translucent", "until fragrant", "medium-high", "a knob of butter", "fold", "temper", *soffritto*, *tadka*, *wok hei*, *dashi*, kosher salt, finishing salt, Maillard, "the stall", "pull the steak".
- **Common misconceptions (each is a lesson target):**
  1. "Searing seals in the juices." (It does not; it builds flavor via browning. `sear-myth`.)
  2. "You can tell meat is done by color or by cutting into it." (Color is unreliable for safety; use a thermometer. `color-not-safe-indicator`.)
  3. "Rinse raw chicken first." (It spreads bacteria; do not wash raw poultry. `dont-wash-chicken`.)
  4. "Salt at the end; it draws out moisture and toughens meat." (Salting early and in layers gives better flavor. `seasoning-in-layers`, `dry-brine`.)
  5. "Oil in the pasta water keeps it from sticking." (Stirring and enough water do the work. `pasta-water-myth`.)
  6. "Alcohol burns off completely." (Not entirely; some remains depending on time and method. `alcohol-cooks-off-myth`.)
  7. "A recipe's time is the rule." (Heat, pan, stove and ingredient size vary; use cues and a thermometer. `cues-over-clock`.)
  8. "Bland food needs more salt." (Often it needs acid, or fat, or heat. `balance-flavors`.)
  9. "Cast iron is ruined by soap." (Modern dish soap is fine; the seasoning is polymerized oil. `gear-myths`.)
  10. "Cooking is a talent, not a skill." (It is repeatable technique plus tasting. `taste-adjust-loop`.)
  11. "A dull knife is safer because it cuts less." (Dull knives slip. `sharp-knife-safety`.)
  12. "Leave the leftovers out to cool before the fridge." (Refrigerate within two hours; one hour above 90 F. `two-hour-rule`.)
- **Concepts that unlock the rest (become foundation units):** mise en place and reading a recipe, the language of heat, salt/fat/acid/water and tasting, knife skills, food safety numbers.

## 3. Foundational knowledge
Grouped into modules (these are the manifest `foundationalModules[]` and the five foundation units):

- **`kitchen-basics` The Kitchen and Its Language.** Mise en place and reading a recipe first; weighing vs scooping; the essential tools; pots and pans and what they are made of; what "low, medium, high", simmer and boil actually mean; the basic verbs of cooking.
- **`heat` Heat: The First Ingredient.** Conduction, convection, radiation; dry vs moist heat; Maillard browning (needs a dry surface and roughly 300 F and up) vs caramelization (sugar, higher temperature, different flavors); preheating and crowding (water caps surface temperature at 212 F); carryover cooking and resting; smoke points.
- **`salt-fat-acid` Salt, Fat, Acid, Water.** What salt does (amplifies flavor, suppresses bitterness) and when to add it; kosher salts differ by volume; fat carries flavor and coats the mouth; acid brightens; balance and the "what does this need?" diagnosis; water as an ingredient (starchy pasta water, salting water).
- **`knife-skills` Knife Skills.** Knife anatomy; pinch grip and claw hand; honing vs sharpening and why sharp is safer; the onion dice; the cut vocabulary (julienne, batonnet, brunoise, dice sizes, chiffonade); knife types and care (never the dishwasher).
- **`food-safety` Food Safety That Actually Matters.** The danger zone (USDA: 40 to 140 F; FDA Food Code for food businesses uses 41 to 135 F); the two-hour rule (one hour above 90 F); thermometers; the USDA minimum internal temperatures; cross-contamination; safe thawing and marinating; leftovers and fast cooling; cooking for others (allergens, raw egg and raw flour risk).

The full concept list is in the Appendix of section 11.

## 4. Enthusiast model
- **What enthusiasts actually talk about:** the dish she made ("the braise came out unreal"), technique ("I finally got a real sear"), a gear obsession (a carbon steel pan, a new knife, a Dutch oven), a source ("I've been cooking through the Food Lab"), a kitchen or show ("did you see the finale?"), a cuisine deep dive ("I'm learning proper carbonara"), the seasonal ingredient ("ramps are out", "peak tomato season"), and their failures ("my sauce broke and I almost cried"). Many cooks also talk about *feeding people*: hosting, family recipes, "cooking as love".
- **Distinctions that matter to them:** searing vs steaming (crowded pan), fresh vs dried herbs, kosher vs table salt (and Diamond Crystal vs Morton), stock vs broth, braise vs stew vs roast, carbon steel vs cast iron vs stainless vs nonstick, German vs Japanese knives, weighing vs scooping, "authentic" vs "adapted", cooking to a thermometer vs "feel", restaurant technique vs home constraints.
- **Knowledge that signals genuine understanding:** explaining why you dry the meat before searing, salting in layers, tasting and adjusting acid at the end, using starchy pasta water to finish a sauce, resting meat and understanding carryover, knowing which cuts want fast heat and which want long braising, knowing *why* a sauce broke and how to fix it, treating the thermometer as a tool rather than an insult.
- **Beginner statements that sound obviously uninformed:** "Just sear it to seal in the juices." "Chicken is done when the juices run clear." "Wash the chicken first." "Olive oil is for everything, including high-heat searing." "Non-stick means I can use metal utensils and high heat." "Recipe says 20 minutes so it's done." "I'll dice an onion by chopping it into random pieces." "Isn't cooking just following a recipe?" "Salt makes steak dry." "Pasta needs oil in the water." "Just add more salt" (to everything).
- **Common controversies and debates (never take a side on the crush's behalf; teach the shape of the argument):** Cast iron vs carbon steel vs nonstick; Diamond Crystal vs Morton kosher salt; dry brining vs "salt right before"; reverse sear vs traditional sear; thermometer doneness vs USDA minimums for steak (see safety note, section 13); whether the air fryer is a real cooking method; sous vide as a home technique (requires strict time-temperature discipline); "authentic" cuisine vs creative adaptation (carbonara with cream, fusion, Tex-Mex vs Mexican); pineapple on pizza; NY vs Neapolitan vs Detroit pizza; Texas brisket vs Carolina pulled pork; garlic press vs knife; nonstick coatings and high heat; whether recipe blogs bury the recipe under a life story; whether reality cooking shows reflect real kitchens; whether tipping and restaurant pricing (kitchen wages) are fair (touch lightly, out of scope).

## 5. Interaction model
- **What should the learner EXPERIENCE instead of reading?** Making judgment calls with a fact sheet in front of them ("the pan is smoking, the onions are brown at the edges, the recipe says 8 minutes: what do you do?"); putting a process in order and seeing *why* each step goes there; recognizing cuts, cuts of meat, knife parts and browning stages by sight; hearing the sizzle, the pop and the rolling boil; tapping the right spot on a diagram (where the thermometer goes, the heel of the knife, the fatty cap); estimating a temperature or a rest time; and rehearsing real conversations ("I made this from scratch").
- **Does the course warrant a Unity simulation? No. Zero sims.** The Tier rubric (`CLAUDE.md` section 4) requires that spatial reasoning, movement, physics, timing in a scene or camera perspective *materially* improve learning **and** that a native exercise would teach it clearly worse. Every cooking concept was tested against that rubric (table below). The honest result is that cooking's hard parts are (a) **cause-and-effect knowledge** (why browning happens), (b) **sensory cue recognition** (what "ready" looks, sounds and smells like), (c) **judgment under safety constraints**, and (d) **vocabulary and culture**. Those are what `decision-scenario`, `visual-id`, `listening-id`, `hotspot-tap`, `sequence-order`, `estimate-slider`, `say-this` and `talk-track` are for. The physical skills (knife handling, pan feel) cannot be learned from a phone at all; a simulation would create a false confidence that is worse than clear text plus a diagram.

**Unity candidates considered and rejected (rigorous, one row each):**

| Candidate sim | Rubric signal it appears to meet | Why native is as good or better | Additional reason it would be harmful or fake |
|---|---|---|---|
| Knife cuts: a slicing mini-game (`cooking.knife.dice.v1`) | Movement over time; camera perspective | The teachable content is cut *names, sizes and order of steps* (`sequence-order`, `visual-id`, `hotspot-tap` on a procedural knife and grip diagram). The motor skill is not transferable through a touchscreen swipe. | A speed- or accuracy-scored knife game rewards fast, careless cutting, contradicting the safety lesson that sharp and slow is safer. Teaches wrong muscle memory. **Rejected.** |
| Pan heat and sear: a heat-transfer simulation (`cooking.heat.sear-window.v1`) | Physics (heat flux, moisture) | The concepts are a small set of causal rules (dry surface, hot pan, do not crowd, leave it alone). A `decision-scenario` with a fact sheet plus a `visual-id` browning ladder and `estimate-slider` for temperatures teaches the *rules*; a fluid sim adds nothing a diagram does not. | A simplified physics model would misteach heat intuition (real pans, stoves, ingredients and moisture vary enormously). Cost/benefit fails; risk of "the sim said so" over a thermometer. **Rejected.** |
| Multi-dish timing "rush" game (`cooking.service.rush.v1`) | Timing in a scene | Sequencing and backward planning are `sequence-order` and `decision-scenario` problems ("the roast rests 20 minutes: what starts now?"). | Pressure-timing games teach panic, not planning, and misrepresent a professional kitchen (see The Bear discussions). **Rejected.** |
| Emulsion / sauce-breaking demo (`cooking.emulsion.whisk.v1`) | Physics, motion | `sequence-order` (add oil slowly), `decision-scenario` ("it broke: which fix?"), and a static cross-section `visual-id`. Same approach as the catalog's own pottery guidance ("why did it crack?"). | An animation of droplets is a decoration, not a decision. **Rejected.** |
| Dough kneading / gluten development | Movement, physics | Gluten is a concept (`multiple-choice`, `decision-scenario` about overmixing) and a sensory skill (windowpane test) that a phone cannot teach. | Fake haptics. **Rejected.** |
| Grill / smoker fire management (`cooking.bbq.airflow.v1`) | Physics (airflow, temperature over time) | Vents-and-temperature decisions are `decision-scenario` items with a chart; the stall is an `estimate-slider` and a diagram. | Safety: a game about fire and carbon monoxide should not trivialize either; text and decision scenarios can carry safety notes precisely. **Rejected.** |
| Plating / composition | Spatial reasoning | `visual-id` and `decision-scenario` ("which plate uses height and contrast?"). Style is subjective and licensed photography is not needed. | Subjective; no scoring truth. **Rejected.** |
| Kitchen line management ("The Bear" style) | Scene reading, timing | `talk-track`, `say-this` and `decision-scenario` on call-outs and station logic. | Would gamify stress; the course's voice is warm. **Rejected.** |

- **Verdict:** `interactionTypes` uses only native types (all 13; `unity-sim` is not used; see section 12); `unitySimulations` is `[]`; there is no `sims/` folder. If a future playtest shows a specific concept cannot be taught natively, the correct route is a numbered open question in `NOTES_FOR_ORCHESTRATOR.md` naming the concept, the failing native design and the rubric signal, not a speculative sim.
- **What should NOT be gamified:** food safety numbers (no timed or streak pressure on temperatures; accuracy, not speed); allergens and cooking for someone with an allergy; knife handling (no speed scoring); any "diet" or body content (out of scope); cuisines (no ranking, no gotcha "authenticity" quizzes that shame home cooks); her cooking (never grade her); alcohol; and family recipes and cultural food traditions (approached with curiosity, never as trivia).
- **Chosen mix:** roughly 100% native: `multiple-choice` (default), `decision-scenario` (the judgment engine of this course), `sequence-order` (processes), `visual-id` and `hotspot-tap` (cuts, knives, cookware, doneness cues), `listening-id` (sizzle, boil stages), `estimate-slider` (temperatures, times, ratios), `fill-the-gap`, `term-match`, `say-this`, `talk-track`, `binary-call` (safe / not safe), `timing-tap` (used sparingly for feel: pull the eggs, toast the spices). Details in section 12.

## 6. Dynamic information requirements
Cooking is an evergreen-knowledge course. Spec section 10: "Do NOT invent artificial live data requirements." The honest verdict is a **thin live layer**:

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| scores, standings, statistics, rosters | **No** | No competition data educates a cook. (Competition shows are discussed as works, not tracked.) | none | n/a | n/a |
| schedules | Modest | "What food shows return this month?" and holiday cooking calendars | Curated editorial calendar (Swoon'd), TVmaze / TMDB (only after licence check) | monthly | Evergreen "how to watch a cooking show" lesson |
| releases / new-media | Modest | New seasons of shows, notable cookbook releases, awards (James Beard in June; Michelin guide releases) | Curated editorial (Swoon'd); publisher press pages link-only | monthly | Evergreen media units |
| events | Light | Awards and festivals as talking points | Curated | seasonal | Evergreen |
| alerts (food recalls) | **Yes, but link-out** | A real and useful "why is everyone posting about this recall?" explainer | USDA FSIS recall API, FDA openFDA food enforcement / recalls pages (US-government; verify terms at adapter build) | daily | Hidden; evergreen "what to do when a food is recalled" |
| conditions / weather | Optional | Grilling weather ("can we grill tonight?") for the `bbq-grilling` branch and outdoor cooking | National Weather Service API | hourly | Hidden |
| seasonal produce (a form of "conditions") | **Yes** | "What is in season near her?" | USDA and state seasonal-produce guides (curated), reviewed by Swoon'd | monthly | Static regional seasonal table |
| news | Light | "Why is everyone talking about X?" (a recall, a viral technique, a chef in the news) | Publisher headlines link-only | daily | Evergreen explainers |
| rankings | **No** | Restaurant rankings are marketing and taste-dependent | none | n/a | n/a |
| closures, injuries, transactions, regulations | **No** | Not relevant | none | n/a | n/a |

Structured data (recalls, seasons) and editorial data (media, culture) are separate systems. Details, licensing, normalized entities and personalization hooks: `live-data.md`.

## 7. Editorial context
- **What commentary helps?** "Why is everyone arguing about this?" (a viral technique, a recall, a rule of thumb debunked), "what just won an award and why does it matter?", "what does this show's finale mean?" (works discussed as cultural events), "what is in season and how do I cook it?", "why is this holiday food-safety warning repeated every year?"
- **Appropriate external sources:** USDA FSIS and FoodSafety.gov, FDA (recalls, Food Code), Extension services (university), publisher/media pages (Serious Eats, NYT Cooking, Bon Appétit, America's Test Kitchen, Food52, Saveur, Eater) **link-only**, James Beard Foundation and Michelin Guide pages for awards **link-only**, show pages (Bravo, FX) for schedule facts.
- **Summarize, explain or link?** Explain in Swoon'd's words and link. Recipes, cookbook text, show clips, photographs and publisher articles are never copied or redistributed (spec section 40). Swoon'd teaches the *technique* and writes its own examples; it never reproduces a recipe verbatim from a book, site or show.
- **Example prompts:** "Why is her feed full of people arguing about [salt / pasta water / the stall]?", "What is a food recall and should she care?", "What does 'in season' mean for what she is cooking this month?", "The finale is out: what should I ask her?", "Why did everyone say her braise was 'dry' at the end?"

## 8. Personalization
| Dimension | How it changes examples and live context | Default when unset | Units using tokens |
|---|---|---|---|
| `cuisine` | Which branch unit is shown; examples ("Sara's favorite: `{{cuisine}}`") | `home cooking` (branch `everyday`) | branch units, `flavor-building`, `conversation-lab`, `now-in-the-kitchen` |
| `skill-level` | Depth of explanations, whether tips assume a thermometer, sharpener, etc. | `home cook` | `kitchen-basics`, `techniques`, `conversation-lab` |
| `equipment` | Cast iron, carbon steel, Dutch oven, air fryer, wok, smoker: gear talk | `a good pan and a sharp knife` | `gear-and-debates`, `techniques`, `bbq-grilling` |
| `region` | Seasonal produce and weather; grilling season | `your area` | `now-in-the-kitchen`, `ingredients-and-planning` |
| `style` | Weeknight vs project cooking vs baker vs host | `weeknight cook` | `ingredients-and-planning`, `conversation-lab` |

Tokens: `{{cuisine}}`, `{{skillLevel}}`, `{{equipment}}`, `{{region}}`, `{{style}}`. Every authored sentence must read correctly with the default substituted. Personalization never requires personal data beyond the Person's stated cuisine and gear.

## 9. Conversation model
**Example enthusiast lines (12+), each with meaning and what to ask next:**

| # | She says | Means | Implied terms | A good next question |
|---|---|---|---|---|
| 1 | "I finally got a proper sear on the scallops." | Browned crust from a hot dry pan, not gray steamed scallops | Maillard, dry surface, preheat, don't crowd | "What did you change to get it? Was the pan hotter or were they drier?" |
| 2 | "My sauce broke." | The emulsion separated (fat and water parted) | emulsion, whisk, temperature | "Could you save it? I read that a splash of water and whisking sometimes brings it back." |
| 3 | "I've been dry-brining everything." | Salting meat in advance and letting it rest, uncovered, before cooking | dry brine, salt, moisture | "Does it change the crust, or mostly the seasoning?" |
| 4 | "This needs acid." | The dish tastes flat; a squeeze of lemon or a splash of vinegar will brighten it | acid, balance | "What would you use here: lemon or vinegar?" |
| 5 | "I'm on a carbon steel kick." | She likes carbon steel pans (seasoned, light, high heat) | carbon steel, seasoning | "Do you like it better than cast iron?" |
| 6 | "Diamond Crystal only." | She uses a specific kosher salt because its flakes are less salty by volume | kosher salt brands | "Is that a taste thing or a measuring thing?" |
| 7 | "Everything is in the fond." | The browned bits stuck to the pan are the base of a pan sauce | fond, deglaze, pan sauce | "What do you deglaze with, wine or stock?" |
| 8 | "It came out al dente, finished in the sauce." | Pasta cooked slightly firm, then combined with sauce and pasta water | al dente, starchy water | "Do you save the pasta water every time?" |
| 9 | "I pulled it at 130 and let it rest." | She removed the meat before the final temperature, expecting carryover | carryover, rest, thermometer | "Do you go by the thermometer or by feel?" (never tell her USDA's number is wrong; see safety note) |
| 10 | "Family meal was chaos, but we made it." | Kitchen-culture reference to the staff meal and the rush | family meal, service | "What's your favorite thing you've made for people?" |
| 11 | "The braise needs another hour." | Tough cut, low heat, collagen not yet melted | braise, collagen | "How will you know when it's ready?" |
| 12 | "Did you watch the finale? Carmy..." | She is talking about a TV show's characters | works, no spoilers | "No spoilers, but what did you love about the season?" |
| 13 | "I always weigh my flour." | She measures by weight for accuracy | weight vs volume, baking | "Is that a baking thing or everything?" |
| 14 | "Mise en place saves my life." | Prepping and organizing ingredients before cooking | mise en place | "How long does your prep usually take?" |

- **How Swoon'd helps without encouraging fake expertise:** every `say-this` carries a `noFakeExpertNote`; `talk-track` replies rate *curiosity*, *honest gaps* and *offering to help* highest; the coach never scripts a claim like "I braise all the time". The most valuable skill is asking about *her* process ("what did you change?") and telling the truth ("I can boil pasta; teach me the sauce part").
- **Target number of talk tracks and say-this items:** 20 talk tracks at launch (10 standalone Talk-tab scenarios plus unit-end tracks), about 70 `say-this` items.

## 10. Assessment
- **How useful competence is determined:** concept mastery 0..1 per Playbook concept, driven by native exercise outcomes and spaced review (`concept-mastery-v1`); `decision-scenario` scores best/acceptable/poor; a **safety gate**: the `food-safety` unit's key numbers (USDA temperatures, two-hour rule, cross-contamination) must be mastered (mastery >= 0.8) before the course reports the safety concepts as "Mastered"; conversation via talk-track Smooth >= 60.
- **Recognize:** knife cuts, cuts of meat (tender vs tough), pan types, browning stages, boil and simmer stages by sight/sound, the five mother sauces by name, common cuisine staples.
- **Understand:** why browning works, why salt goes in layers, why acid brightens, why rest matters, why a sauce breaks, why temperatures matter for safety.
- **Explain (in a sentence, to her):** "I get that you dry the meat so it browns instead of steams." / "Salt early because it needs time to work." / "Acid is what makes it taste alive."
- **Correctly interpret:** "pulled it at 130" (carryover), "this needs acid", "the pan's not hot enough", "my sauce broke", "in the weeds".
- **Mastery model:** pass threshold **0.8**; safety concepts additionally require a passing decision-scenario set. **Useful competence statement:** "She can talk about her cooking, understand why she does what she does, cook a safe, simple meal beside her, ask a couple of good questions about technique, and say 'okay, I get why you love this' without faking it."

---

## 11. Curriculum map (ongoing course)

Designed as an ongoing course. **23 units, 118 lessons, 225 Playbook concepts.** The unit count exceeds the 8-14 guidance because the template's layer minimums (5 foundation + 4 intermediate + 3 enthusiast) plus eight branches, live, conversation and review already total 23; a learner sees about 15 units (core 12 plus the matching branch unit, live, conversation, review). Ship in phases (release plan below); see `NOTES_FOR_ORCHESTRATOR.md` (unit count, same as P-04 for other courses).

Activity abbreviations: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap. Every lesson lists 4+ planned activity families; no lesson uses a Unity sim.

| Layer | Purpose | Units | Lessons |
|---|---|---|---|
| Foundations | Language, heat, salt/fat/acid/water, knives, food safety | 5 | 33 |
| Intermediate | Techniques, flavor building, ingredients and planning, kitchen science | 4 | 27 |
| Enthusiast depth | Gear and debates, kitchen culture, cooking media | 3 | 16 |
| Branches | Baking, Italian, French, Mexican, Chinese, Japanese, Indian, BBQ and grilling | 8 | 26 |
| Current-season / live | Seasonal cooking, holidays, recalls explained, what is on the food screen | 1 | 4 |
| Conversation practice | Talk tracks and say-this | 1 | 8 |
| Perpetual review | Spaced review | 1 | 4 |

### Layer 1: Foundations

**Unit `kitchen-basics`: The Kitchen and Its Language** (prereq: none). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `kit-01` | Mise en place | Explain why cooks prep before they cook and read a recipe first. | mise-en-place, read-recipe-first | so, mc, ds, st |
| `kit-02` | Weigh, don't scoop | Know why weight beats volume and estimate common weights. | weight-vs-volume, kitchen-scale, measuring-tools | mc, es, fg, ds |
| `kit-03` | The tools you actually use | Recognize the essential tools and what each is for. | essential-tools, instant-read-thermometer | vi, tm, mc, ds |
| `kit-04` | Pots, pans, and what they're made of | Tell cookware by shape and material and know what each is good at. | cookware-materials, pan-anatomy | vi, ht, mc, tm |
| `kit-05` | Low, medium, high, and simmer | Translate stove language into what the food is doing. | heat-levels, simmer-vs-boil | tm, mc, li, ds |
| `kit-06` | Kitchen verbs | Decode sauté, sweat, fold, reduce, deglaze, temper and friends. | kitchen-verbs, reduce | tm, fg, st, mc |

**Unit `heat`: Heat: The First Ingredient** (prereq: `kitchen-basics`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `heat-01` | Three ways heat travels | Distinguish conduction, convection and radiation in a kitchen. | heat-transfer | mc, tm, ht, ds |
| `heat-02` | Dry heat and moist heat | Match dry-heat and moist-heat methods to food. | dry-vs-moist-heat | mc, ds, tm, so |
| `heat-03` | Why browning tastes good | Explain Maillard browning in plain words. | maillard-reaction, browning-needs-dry-surface | mc, vi, ds, st |
| `heat-04` | Caramelization is different | Tell caramelization from Maillard and know its temperature range. | caramelization, maillard-vs-caramelization | es, tm, mc, ds |
| `heat-05` | Preheat and don't crowd | Explain why a hot pan and space matter (steam). | preheat-pan, overcrowding, water-caps-temperature | ds, bc, li, so |
| `heat-06` | Carryover and resting | Predict carryover cooking and why meat rests. | carryover-cooking, resting-meat | es, ds, tt, mc |
| `heat-07` | Fat meets heat | Know smoke point and pick a fat for the job. | smoke-point, fat-as-heat-medium | mc, tm, li, ds |

**Unit `salt-fat-acid`: Salt, Fat, Acid, Water** (prereq: `kitchen-basics`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sfa-01` | What salt actually does | Explain salt as flavor amplifier and bitterness suppressor. | salt-enhances-flavor, salt-suppresses-bitterness | mc, st, fg, ds |
| `sfa-02` | Season in layers | Know when to salt and why once at the end is not enough. | seasoning-in-layers, taste-as-you-go | so, ds, mc, bc |
| `sfa-03` | Not all salts are equal | Understand kosher salt brands, finishing salt and volume vs weight. | kosher-salt-brands, finishing-salt, dry-brine | es, vi, mc, ds |
| `sfa-04` | Fat carries flavor | Explain fat as flavor carrier and mouthfeel. | fat-flavor-carrier, fat-mouthfeel | mc, tm, ds, fg |
| `sfa-05` | Acid wakes things up | Use acid to brighten a flat dish. | acid-brightens, acid-sources | ds, mc, tm, st |
| `sfa-06` | Balance and the fix | Diagnose a dish (too salty, flat, heavy) and choose the fix. | balance-flavors, fix-too-salty | ds, bc, mc, tk |
| `sfa-07` | Water is an ingredient | Explain starchy pasta water and salting the water. | pasta-water, starchy-water, pasta-water-myth | mc, fg, ds, es |

**Unit `knife-skills`: Knife Skills** (prereq: `kitchen-basics`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `knife-01` | Anatomy of a chef's knife | Name the parts of a knife (heel, spine, tip, bolster, tang). | knife-anatomy | ht, tm, mc, fg |
| `knife-02` | Pinch grip and claw | Describe the grip and the guiding hand that keep fingers safe. | pinch-grip, claw-hand | ht, bc, mc, vi |
| `knife-03` | Why sharp is safer | Explain honing vs sharpening and dull-knife risk. | honing-vs-sharpening, sharp-knife-safety | mc, ds, bc, tm |
| `knife-04` | Dice an onion | Order the steps of an onion dice and know dice sizes. | onion-dice, dice-sizes | so, vi, mc, es |
| `knife-05` | Cut vocabulary | Recognize julienne, batonnet, brunoise, chiffonade. | julienne, brunoise, chiffonade, batonnet | tm, vi, fg, mc |
| `knife-06` | Other knives, and care | Know the paring, serrated and boning knife jobs and basic care. | knife-types, knife-care | vi, mc, bc, ds |

**Unit `food-safety`: Food Safety That Actually Matters** (prereq: `kitchen-basics`). 7 lessons. Conservative USDA/FDA guidance only; see section 13.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `safe-01` | The danger zone | State the danger zone and the two-hour rule. | danger-zone, two-hour-rule | es, mc, bc, ds |
| `safe-02` | Thermometers over vibes | Use a thermometer correctly and know color is not a safety indicator. | thermometer-use, color-not-safe-indicator | ds, ht, mc, bc |
| `safe-03` | The numbers | Recall the USDA minimum internal temperatures (165, 160, 145 plus rest). | usda-safe-temps, rest-time-145 | mc, tm, es, fg |
| `safe-04` | Cross-contamination | Prevent bacteria spreading: boards, hands, raw poultry not rinsed. | cross-contamination, separate-boards, dont-wash-chicken | ds, bc, mc, vi |
| `safe-05` | Thaw and marinate safely | Choose safe thawing methods and marinate in the fridge. | safe-thawing, safe-marinating | ds, bc, mc, so |
| `safe-06` | Leftovers and cooling | Store, cool fast and reheat leftovers safely. | leftovers-3-4-days, cool-fast, reheat-165 | mc, ds, es, bc |
| `safe-07` | Cooking for others | Handle allergens, raw egg and raw flour risk, and ask before assuming. | allergens-basics, raw-egg-flour-risk, hand-washing | ds, st, bc, tk |

### Layer 2: Intermediate

**Unit `techniques`: Core Techniques** (prereq: `heat`, `knife-skills`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `tech-01` | Sauté and stir-fry | Distinguish sautéing from stir-frying and know the setup. | saute, stir-fry | mc, so, ds, tm |
| `tech-02` | Pan-sear and pan sauce | Order a sear and pan sauce and explain fond. | pan-sear, fond, deglaze, pan-sauce | so, ds, mc, st |
| `tech-03` | Roasting | Pick roasting temperature for the food and know why vegetables brown. | roast-high-heat, roast-vegetables | ds, mc, es, vi |
| `tech-04` | Braising | Explain braising, collagen and why tough cuts win. | braise, collagen-to-gelatin, tough-cuts | so, mc, ds, tm |
| `tech-05` | Simmer, poach and boil | Choose the right water temperature for the food. | poach, poaching-temps | es, mc, ds, li |
| `tech-06` | Steam and blanch | Blanch and shock vegetables and know why. | steam, blanch-and-shock | so, mc, ds, bc |
| `tech-07` | Grilling and broiling | Contrast direct and indirect heat; know broiler basics. | direct-vs-indirect-heat, broil | ht, ds, mc, bc |
| `tech-08` | Pick the technique | Match a cut and a goal to a technique. | choose-technique | ds, vi, mc, tk |

**Unit `flavor-building`: Building Flavor** (prereq: `salt-fat-acid`, `heat`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `flav-01` | Aromatics | Recognize mirepoix, trinity, sofrito and their cousins. | mirepoix, aromatic-bases | tm, mc, vi, fg |
| `flav-02` | Stock, broth and fond | Distinguish stock from broth and know how to use them. | stock, broth-vs-stock | so, mc, ds, tm |
| `flav-03` | Herbs and spices | Know fresh vs dried herbs and how to bloom spices. | fresh-vs-dried-herbs, bloom-spices | ds, mc, tm, tt |
| `flav-04` | Umami | Identify umami sources and why they deepen flavor. | umami, umami-sources | mc, tm, st, ds |
| `flav-05` | The mother sauces | Name the five mother sauces and the roux. | mother-sauces, roux | tm, so, mc, fg |
| `flav-06` | Taste, adjust, repeat | Run the taste-adjust loop across salt, acid, fat, sweet and heat. | taste-adjust-loop, fix-bland | ds, tk, mc, st |

**Unit `ingredients-and-planning`: Ingredients and Planning** (prereq: `kitchen-basics`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ing-01` | Cuts of meat | Know tender vs tough cuts and read a primal chart. | tender-vs-tough-cuts, beef-primals | ht, vi, mc, ds |
| `ing-02` | Fish and shellfish basics | Buy and cook fish with the right cues and safe temperature. | fish-basics, fish-doneness | mc, ds, vi, bc |
| `ing-03` | Produce and seasonality | Know why seasonality matters and how to check ripeness. | seasonality, ripeness | mc, ds, tm, st |
| `ing-04` | Eggs, dairy and butter | Understand egg basics, butter vs oil, and cream types. | eggs-basics, butter-vs-oil, cream-types | mc, tm, ds, fg |
| `ing-05` | The pantry | Build a versatile pantry and choose oils and vinegars. | pantry-staples, oils-and-vinegars | tm, mc, ds, vi |
| `ing-06` | Substitutions and scaling | Substitute and scale without breaking the recipe. | substitutions, scaling-recipes | ds, es, fg, mc |
| `ing-07` | Timing a whole dinner | Work backward from serving time and use rest as a buffer. | work-backwards, one-oven-planning | so, ds, tk, mc |

**Unit `kitchen-science`: Kitchen Science** (prereq: `heat`, `salt-fat-acid`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sci-01` | Eggs and protein | Explain protein coagulation in eggs and scrambled/soft eggs. | protein-coagulation, egg-doneness | mc, so, tt, ds |
| `sci-02` | Emulsions | Explain how vinaigrette, mayo and hollandaise hold together and break. | emulsion, vinaigrette-ratio, broken-sauce | so, ds, mc, vi |
| `sci-03` | Starch and thickening | Explain gelatinization, slurries and roux thickening. | starch-gelatinization, slurry | mc, ds, tm, es |
| `sci-04` | Pasta, rice and grains | Cook pasta, rice and grains by cues and ratios. | pasta-cooking, rice-washing | es, so, mc, ds |
| `sci-05` | Gluten and doughs | Explain gluten and overworking. | gluten, overmixing | mc, ds, tm, bc |
| `sci-06` | Beans and tough stuff | Know soaking, acid and the kidney bean safety rule. | legumes-soaking, kidney-bean-safety | mc, ds, bc, es |

### Layer 3: Enthusiast depth

**Unit `gear-and-debates`: Gear and Debates** (prereq: `techniques`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `gear-01` | The pan wars | Compare cast iron, carbon steel, stainless and nonstick. | cast-iron-vs-carbon-steel, nonstick-care | mc, tm, ds, st |
| `gear-02` | The knife wars | Compare German and Japanese knives, steels and stones. | german-vs-japanese-knives, whetstone | mc, st, tm, ds |
| `gear-03` | Sous vide, air fryers, pressure cookers | Place gadgets in context (and safety). | sous-vide-basics, gadget-context | ds, mc, st, bc |
| `gear-04` | Myths the internet loves | Debunk searing-seals-juices, alcohol-cooks-off and friends. | sear-myth, alcohol-cooks-off-myth, gear-myths | bc, mc, st, ds |
| `gear-05` | Steak arguments | Understand reverse sear, dry brine, and doneness vs safety. | reverse-sear, steak-doneness-vs-safety | ds, st, tk, mc |

**Unit `kitchen-culture`: Kitchen Culture** (prereq: `techniques`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cult-01` | The brigade | Know the brigade roles and why kitchens have a chain of command. | brigade-system | tm, so, mc, st |
| `cult-02` | Kitchen call-outs | Decode "behind", "corner", "heard", "86", "fire", "in the weeds". | kitchen-callouts, in-the-weeds | tm, fg, st, mc |
| `cult-03` | Line, prep and family meal | Understand station work, prep lists, staging and staff meal. | line-vs-prep, family-meal | mc, ds, st, tk |
| `cult-04` | How restaurants are judged | Know stars, guides and awards (Michelin, James Beard). | restaurant-recognition | mc, tm, st, bc |
| `cult-05` | Home cook, pro cook | Explain what changes between a restaurant kitchen and a home kitchen. | pro-vs-home | mc, st, ds, tk |
| `cult-06` | Food, family and respect | Approach family recipes and authenticity with curiosity. | family-recipes, authenticity-debate | ds, st, tk, mc |

**Unit `cooking-media`: Cooking Media** (prereq: `flavor-building`). 5 lessons. Talks about works; never reproduces them (spec section 40).

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `media-01` | The cookbook shelf | Know the kitchen canon and who wrote what. | kitchen-canon | mc, tm, st, fg |
| `media-02` | The teachers online | Understand video cooks, recipe blogs and how to judge a recipe. | online-cooks, tested-recipes | mc, st, ds, bc |
| `media-03` | Competition shows | Know what competition shows reward and what is real. | competition-shows | mc, st, ds, tm |
| `media-04` | Chefs on screen | Know the well-known documentaries and fiction and how fans talk about them. | chef-documentaries, kitchen-fiction | mc, st, tk, tm |
| `media-05` | Reading a recipe like a cook | Read headnotes, yield, "to taste" and cues. | recipe-literacy, cues-over-clock | ds, fg, so, mc |

### Layer 4: Branches and personalization

Each branch unit has `layer: branch` and a `branchId`. Prereq: `techniques` and `flavor-building` unless noted. Tokens: `{{cuisine}}`, `{{skillLevel}}`, `{{equipment}}`.

**Unit `branch-baking`: Baking and Pastry** (branch `baking`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bake-01` | Baking is chemistry | Explain why baking demands weight and ratios. | baking-precision, baker-percentages | mc, es, ds, st |
| `bake-02` | Leaveners | Distinguish baking soda, baking powder and yeast. | leaveners, soda-vs-powder | tm, mc, ds, bc |
| `bake-03` | Fat and flour | Explain creaming, laminated dough and flaky pie crust. | creaming-method, lamination | so, mc, ds, vi |
| `bake-04` | Sugar and eggs | Explain meringue, custard and caramel. | meringue, custard-basics | so, mc, ds, tm |
| `bake-05` | Bread and sourdough | Explain fermentation, hydration and sourdough starter; raw dough and flour safety. | fermentation, hydration, sourdough-starter | mc, ds, st, bc |

**Unit `branch-italian`: Italian** (branch `italian`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ita-01` | Less is more | Explain restraint, soffritto and ingredient quality. | italian-restraint, soffritto | mc, ds, tm, st |
| `ita-02` | Pasta logic | Explain pasta shapes, al dente and finishing in the pan. | pasta-shapes, al-dente, finish-in-pan | mc, so, ds, tt |
| `ita-03` | Talking Italian food | Decode the rules fans argue about (carbonara, pizza). | carbonara-rule, pizza-styles | st, mc, tk, bc |

**Unit `branch-french`: French** (branch `french`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fra-01` | The French method | Connect mother sauces, mise en place and the brigade. | french-method, escoffier | tm, mc, so, st |
| `fra-02` | Butter, wine and reductions | Explain beurre blanc, wine reductions and pan sauces. | beurre-blanc, wine-reduction | so, ds, mc, tm |
| `fra-03` | Bistro classics | Recognize classic dishes and the "fussy" myth. | bistro-classics, french-myth | mc, vi, st, tk |

**Unit `branch-mexican`: Mexican** (branch `mexican`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `mex-01` | Corn and masa | Explain nixtamalization, masa, tortillas and tamales. | nixtamalization, masa | mc, so, ds, tm |
| `mex-02` | Chiles and salsas | Recognize dried chiles and the logic of salsas and moles. | dried-chiles, salsa-logic, mole | vi, tm, mc, ds |
| `mex-03` | Regional Mexico | Talk about regions and Mexican vs Tex-Mex. | mexican-regions, tex-mex-vs-mexican | mc, st, tk, bc |

**Unit `branch-chinese`: Chinese** (branch `chinese`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `chn-01` | Wok and wok hei | Explain the wok, high heat and wok hei. | wok-technique, wok-hei | mc, so, ds, li |
| `chn-02` | Velveting, sauces and the pantry | Know velveting and the core pantry. | velveting, chinese-pantry | tm, mc, so, ds |
| `chn-03` | Regions and mala | Talk about regional cuisines and Sichuan mala. | chinese-regions, mala | mc, st, tk, tm |

**Unit `branch-japanese`: Japanese** (branch `japanese`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `jpn-01` | Dashi and umami | Explain dashi, kombu and katsuobushi. | dashi, umami-history | so, mc, tm, ds |
| `jpn-02` | Rice, knife and restraint | Explain rice culture, knife culture and seasonality. | japanese-rice, shun | mc, ds, vi, st |
| `jpn-03` | Ramen shop to izakaya | Decode everyday Japanese food talk. | izakaya-food, ramen-components | tm, mc, st, tk |

**Unit `branch-indian`: Indian** (branch `indian`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ind-01` | Tadka and spice blooming | Explain tadka and layering spices. | tadka, spice-layering | so, mc, ds, tt |
| `ind-02` | Staples and regions | Know dal, ghee, breads, biryani and regional differences. | dal-ghee-breads, indian-regions | tm, mc, ds, vi |
| `ind-03` | Talking about curry | Explain why "curry" is a broad word and how spice levels work. | curry-word, garam-masala | mc, st, tk, bc |

**Unit `branch-bbq-grilling`: BBQ and Grilling** (branch `bbq-grilling`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bbq-01` | Fire and smoke | Explain direct vs indirect fire, charcoal vs gas and outdoor fire and carbon monoxide safety. | fire-management, grill-safety | ds, mc, ht, bc |
| `bbq-02` | Low and slow | Explain collagen, the stall and safe vs tender temperatures. | the-stall, safe-vs-tender-temp | es, mc, ds, so |
| `bbq-03` | Regional styles and talk | Decode regional barbecue and "smoke ring". | bbq-regions, smoke-ring | mc, st, tk, tm |

### Layer 5: Current season / live

**Unit `now-in-the-kitchen`: Now in the Kitchen** (prereq: `kitchen-basics`; grows with mastery). Templated; refreshed by `live` hooks and editorial cards. 4 lesson templates (each instantiated per month or event).

| Lesson id | Title | Objective | conceptIds | Activities | Live hook |
|---|---|---|---|---|---|
| `now-01` | In season this month | Know what is in season near `{{region}}` and how to cook it. | seasonality, seasonal-cooking | mc, ds, tm, st | conditions (curated seasonal produce) |
| `now-02` | The holiday table | Plan and safely cook a holiday meal (thawing, temperatures, leftovers). | holiday-cooking, safe-thawing, usda-safe-temps | ds, mc, so, bc | events (calendar) |
| `now-03` | Recall explainer | Understand what a food recall means and what a cook should do. | food-recalls | ds, mc, st, bc | alerts (USDA FSIS, FDA) |
| `now-04` | On the food screen and shelf | Know what is on now (shows, cookbooks, awards) and why fans care. | current-food-media | mc, st, tk, tm | new-media, events |

### Layer 6: Conversation practice and perpetual review

**Unit `conversation-lab`: Conversation Lab** (prereq: any three foundation units; content grows with mastery). 8 lessons; also feeds the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | "I made this from scratch" | Respond with curiosity to a proud dinner report. | convo-follow-up-questions, maillard-reaction | tk, st, mc, ds |
| `talk-02` | "My sauce broke" | Comfort and help without pretending. | convo-empathy, broken-sauce | tk, st, ds, mc |
| `talk-03` | Her knife obsession | Ask smart questions about knives and sharpening. | convo-gear-talk, honing-vs-sharpening | tk, st, mc, ds |
| `talk-04` | "Let's cook together" | Accept honestly, offer to be the sous chef. | convo-invitation-to-cook, convo-admit-what-you-dont-know | tk, ds, st, mc |
| `talk-05` | Restaurant or home? | Handle a "restaurant vs home cooking" debate warmly. | pro-vs-home, convo-restaurant-talk | tk, st, ds, mc |
| `talk-06` | Her recipe disaster | Laugh with her, not at her. | convo-recipe-disaster, cues-over-clock | tk, st, mc, ds |
| `talk-07` | Watching a cooking show together | Follow along and ask about what she loves. | convo-watching-together, competition-shows | tk, st, mc, ds |
| `talk-08` | Say-this gauntlet | Decode five lines in a row. | (all layers, sampled) | st, st, st, st |

**Unit `review-loop`: Perpetual Review** (always available after first lesson). 4 lesson templates driven by the review policy.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Daily Bite | 1 card (mc/fg/tm) from due concepts. | (due concepts) | mc, fg, tm, es |
| `review-02` | Weekly mix | 3-round session sampled by weakness. | (weak concepts) | mc, bc, ds, tk |
| `review-03` | Safety check | Always-on refresh of the food-safety numbers; never timed. | usda-safe-temps, danger-zone, cross-contamination, leftovers-3-4-days | mc, bc, ds, es |
| `review-04` | Term blitz | Playbook term drill. | (terms) | tm, fg, mc, st |

**Review policy:** Leitner-style intervals 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; a concept below 0.6 re-enters at 1d; **safety concepts** (`usda-safe-temps`, `danger-zone`, `two-hour-rule`, `cross-contamination`, `dont-wash-chicken`, `leftovers-3-4-days`, `kidney-bean-safety`) re-enter on a shorter cadence (1d, 3d, 7d, 14d, 30d) and never lose the "explain why" step. No timers on safety review.

### Concept targets, personalization slots, release plan

- **Concept count target:** 225 Playbook concepts (Appendix below); 60+ terms drafted with definitions and example lines in `exercises.md` section 3.
- **Personalization slots:** `{{cuisine}}`, `{{skillLevel}}`, `{{equipment}}`, `{{region}}`, `{{style}}` (section 8).
- **Release plan:**
  - **Launch (v0.1-1.0):** foundations (5 units), intermediate (4 units), `gear-and-debates`, `kitchen-culture`, `conversation-lab`, `review-loop`; branches `baking`, `italian`, `mexican`, `bbq-grilling` (the cuisines most likely to be her favorites, plus baking as a huge subculture); `now-in-the-kitchen` templates with seasonal produce and holiday cards only.
  - **Fast follow (1.1):** `cooking-media`, branches `french`, `chinese`, `japanese`, `indian`, recall alerts card and media card.
  - **Ongoing:** new lessons per season (holidays, produce, new show seasons, new cookbook talk), new talk tracks monthly, regional and cuisine sub-branches (Thai, Korean, Middle Eastern, Southern US, Vietnamese) driven by demand data (spec section 43), refresh of USDA/FDA references yearly.

### Appendix: Playbook concepts (ids)

`kitchen-basics`: `mise-en-place`, `read-recipe-first`, `weight-vs-volume`, `kitchen-scale`, `measuring-tools`, `essential-tools`, `instant-read-thermometer`, `cookware-materials`, `pan-anatomy`, `heat-levels`, `simmer-vs-boil`, `kitchen-verbs`, `reduce`.
`heat`: `heat-transfer`, `dry-vs-moist-heat`, `maillard-reaction`, `browning-needs-dry-surface`, `caramelization`, `maillard-vs-caramelization`, `preheat-pan`, `overcrowding`, `water-caps-temperature`, `carryover-cooking`, `resting-meat`, `smoke-point`, `fat-as-heat-medium`.
`salt-fat-acid`: `salt-enhances-flavor`, `salt-suppresses-bitterness`, `seasoning-in-layers`, `taste-as-you-go`, `kosher-salt-brands`, `finishing-salt`, `dry-brine`, `fat-flavor-carrier`, `fat-mouthfeel`, `acid-brightens`, `acid-sources`, `balance-flavors`, `fix-too-salty`, `pasta-water`, `starchy-water`, `pasta-water-myth`.
`knife-skills`: `knife-anatomy`, `pinch-grip`, `claw-hand`, `honing-vs-sharpening`, `sharp-knife-safety`, `onion-dice`, `dice-sizes`, `julienne`, `brunoise`, `chiffonade`, `batonnet`, `knife-types`, `knife-care`.
`food-safety`: `danger-zone`, `two-hour-rule`, `thermometer-use`, `color-not-safe-indicator`, `usda-safe-temps`, `rest-time-145`, `cross-contamination`, `separate-boards`, `dont-wash-chicken`, `safe-thawing`, `safe-marinating`, `leftovers-3-4-days`, `cool-fast`, `reheat-165`, `allergens-basics`, `raw-egg-flour-risk`, `hand-washing`.
`techniques`: `saute`, `stir-fry`, `pan-sear`, `fond`, `deglaze`, `pan-sauce`, `roast-high-heat`, `roast-vegetables`, `braise`, `collagen-to-gelatin`, `tough-cuts`, `poach`, `poaching-temps`, `steam`, `blanch-and-shock`, `direct-vs-indirect-heat`, `broil`, `choose-technique`.
`flavor-building`: `mirepoix`, `aromatic-bases`, `stock`, `broth-vs-stock`, `fresh-vs-dried-herbs`, `bloom-spices`, `umami`, `umami-sources`, `mother-sauces`, `roux`, `taste-adjust-loop`, `fix-bland`.
`ingredients-and-planning`: `tender-vs-tough-cuts`, `beef-primals`, `fish-basics`, `fish-doneness`, `seasonality`, `ripeness`, `eggs-basics`, `butter-vs-oil`, `cream-types`, `pantry-staples`, `oils-and-vinegars`, `substitutions`, `scaling-recipes`, `work-backwards`, `one-oven-planning`.
`kitchen-science`: `protein-coagulation`, `egg-doneness`, `emulsion`, `vinaigrette-ratio`, `broken-sauce`, `starch-gelatinization`, `slurry`, `pasta-cooking`, `rice-washing`, `gluten`, `overmixing`, `legumes-soaking`, `kidney-bean-safety`.
`gear-and-debates`: `cast-iron-vs-carbon-steel`, `nonstick-care`, `german-vs-japanese-knives`, `whetstone`, `sous-vide-basics`, `gadget-context`, `sear-myth`, `alcohol-cooks-off-myth`, `gear-myths`, `reverse-sear`, `steak-doneness-vs-safety`.
`kitchen-culture`: `brigade-system`, `kitchen-callouts`, `in-the-weeds`, `line-vs-prep`, `family-meal`, `restaurant-recognition`, `pro-vs-home`, `family-recipes`, `authenticity-debate`.
`cooking-media`: `kitchen-canon`, `online-cooks`, `tested-recipes`, `competition-shows`, `chef-documentaries`, `kitchen-fiction`, `recipe-literacy`, `cues-over-clock`.
`branch-baking`: `baking-precision`, `baker-percentages`, `leaveners`, `soda-vs-powder`, `creaming-method`, `lamination`, `meringue`, `custard-basics`, `fermentation`, `hydration`, `sourdough-starter`.
`branch-italian`: `italian-restraint`, `soffritto`, `pasta-shapes`, `al-dente`, `finish-in-pan`, `carbonara-rule`, `pizza-styles`.
`branch-french`: `french-method`, `escoffier`, `beurre-blanc`, `wine-reduction`, `bistro-classics`, `french-myth`.
`branch-mexican`: `nixtamalization`, `masa`, `dried-chiles`, `salsa-logic`, `mole`, `mexican-regions`, `tex-mex-vs-mexican`.
`branch-chinese`: `wok-technique`, `wok-hei`, `velveting`, `chinese-pantry`, `chinese-regions`, `mala`.
`branch-japanese`: `dashi`, `umami-history`, `japanese-rice`, `shun`, `izakaya-food`, `ramen-components`.
`branch-indian`: `tadka`, `spice-layering`, `dal-ghee-breads`, `indian-regions`, `curry-word`, `garam-masala`.
`branch-bbq-grilling`: `fire-management`, `grill-safety`, `the-stall`, `safe-vs-tender-temp`, `bbq-regions`, `smoke-ring`.
`now-in-the-kitchen`: `seasonal-cooking`, `holiday-cooking`, `food-recalls`, `current-food-media`.
`conversation-lab`: `convo-follow-up-questions`, `convo-empathy`, `convo-gear-talk`, `convo-invitation-to-cook`, `convo-admit-what-you-dont-know`, `convo-restaurant-talk`, `convo-recipe-disaster`, `convo-watching-together`.

---

## 12. Interaction plan

Tier rubric (`CLAUDE.md` section 4): Unity only where spatial reasoning, movement, physics, timing in a scene or camera perspective materially improves learning and a native exercise would teach it clearly worse. **No row below is Tier A.** Every Unity candidate was evaluated in section 5 and rejected. `unitySimulations` in the manifest is empty; there is no `sims/` folder; `interactionTypes` excludes `unity-sim`.

| Lesson / activity family | Concepts | Type (native exercise) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Judgment: "the sauce broke", "the chicken is 158 F", "too salty", "which pan?" | balance-flavors, broken-sauce, usda-safe-temps, cast-iron-vs-carbon-steel, choose-technique | `decision-scenario` | Cooking is decisions from cues and facts. Fact sheet plus best/acceptable/poor teaches judgment (catalog #6; spec section 17 names cooking). A sim would only animate the outcome. | B | ~130 |
| Processes: mise en place, onion dice, sear then pan sauce, braise, blanch and shock, hollandaise | mise-en-place, onion-dice, pan-sauce, braise, blanch-and-shock, emulsion | `sequence-order` | Order is the concept and each step has a `why` (catalog #4; spec section 19 names cooking). | B | ~45 |
| Rule and fact checks (why sear, where salt goes, dairy, cuts, terms in context) | most | `multiple-choice` | Default recall/understanding card; distractors are the misconceptions in section 2. | B | ~190 |
| Safe / not safe, true / myth calls | danger-zone, dont-wash-chicken, sear-myth, kidney-bean-safety, knife-care | `binary-call` | Two-way judgments; `scene.kind` is `none` or a procedural diagram. | B | ~55 |
| Vocabulary: terms, cuts, techniques, cuisine terms | kitchen-verbs, julienne, mother-sauces, dashi | `term-match`, `fill-the-gap` | Recall and recognition in context. | B | ~60 |
| Recognize cuts, cookware, browning, doneness cues, dried chiles | julienne, cookware-materials, maillard-reaction, dried-chiles | `visual-id` | Recognition is the skill. Procedural or original illustrations only (`original-swoond`). | B | ~50 |
| Diagrams: knife parts, grip, thermometer placement, beef primals, oven racks, stove zones | knife-anatomy, thermometer-use, beef-primals, direct-vs-indirect-heat | `hotspot-tap` | Static diagram with correct regions; no motion needed (catalog #13). | B | ~35 |
| Sizzle, boil stages, oil ready | heat-levels, smoke-point, wok-hei | `listening-id` | Sound is a real cooking cue. Original or synthesized audio (`original-swoond`); "Skip" always available. | B | ~15 |
| Temperatures, times, ratios, hours | usda-safe-temps, carryover-cooking, danger-zone, poaching-temps, the-stall | `estimate-slider` | Numeric intuition; closeness matters. Safety numbers use tight tolerances or none. | B | ~35 |
| Feel: pull the eggs, toast the spices, brown the butter | egg-doneness, bloom-spices, tadka | `timing-tap` | Only 1D rhythm; explicitly *not* speed pressure; slow-mode always on. | B | ~8 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice: 20 talk tracks and ~70 say-this items. | B | 20 + ~70 |

**Native exercise types used:** multiple-choice, binary-call, term-match, sequence-order, visual-id, decision-scenario, talk-track, timing-tap, say-this, fill-the-gap, listening-id, estimate-slider, hotspot-tap (all 13; the last four are used lightly). **`unity-sim` unused.** Estimated total native items ~650 across 118 lessons and the review loop.

**Accessibility:** `listening-id` always has a text alternative and Skip; `visual-id` `alt` describes distinguishing features without revealing the answer; `timing-tap` uses `tap-to-stop-slow`; no exercise relies on color alone (browning ladder uses labels).

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| Imagery | Procedural or original illustration only (`license: original-swoond`): knife anatomy, cuts, primals, pan cross-sections, browning ladder, dried chiles, kitchen tools. **No food photography** from third parties. No photographs of chefs, restaurants, shows or products. |
| Audio | Original or synthesized sizzles, boils, oil crackle (`original-swoond`). No TV or video audio. |
| Logos / trademarks | Brands (Diamond Crystal, Morton, Le Creuset, Lodge, Wüsthof, Shun...) appear only as text where a lesson needs them; no logos. Awards and guides (Michelin, James Beard) as text mentions and link-outs. TV titles as text. |
| Video | No embedded show or clip video; deep-link to official pages only. |
| Recipes and cookbook text | Recipes as verbatim text are copyrighted expression; Swoon'd writes its own examples and never copies from books, blogs, shows or publishers. Titles and authors mentioned as facts (works discussed, not redistributed; spec section 40). No quotation of chapter text. |
| Article text | Never copied; explain and link (spec section 11). |
| Lyrics / music | Not applicable. |
| Data terms | USDA FSIS and FDA recall data are public US-government sources; verify current terms and rate limits at adapter build. NWS API needs a User-Agent. TVmaze/TMDB terms require review before use. Award pages and show schedules are curated facts with links. |
| Player likeness | N/A. Real chefs and authors appear by name as facts only; no likeness, no fabricated quotes, no endorsement implication. |

**Safety (conservative mainstream guidance; state in manifest `safetyConstraints`; Swoon'd builds appreciation and understanding, not a substitute for training):**
- Food-safety content follows **USDA FSIS / FoodSafety.gov** for home cooks (danger zone 40 to 140 F; two-hour rule, one hour above 90 F; leftovers 3 to 4 days; do not wash raw poultry; thaw in the refrigerator, in cold water changed every 30 minutes, or in the microwave then cook immediately). The **FDA Food Code (2022 edition)** is the reference for food businesses (danger zone 41 to 135 F; cooling from 135 F to 70 F within 2 hours, then to 41 F within a further 4 hours). Lessons name which reference they follow; home lessons use USDA numbers.
- **USDA minimum internal temperatures** (verified 2026-09-30): poultry 165 F (74 C); ground meats 160 F (71 C); whole cuts of beef, pork, lamb and veal 145 F (63 C) with a 3-minute rest; fish 145 F; egg dishes 160 F; leftovers and casseroles 165 F. Color and juices are not reliable safety indicators. **Steak preference note:** many enthusiasts pull steaks below 145 F. Swoon'd teaches the USDA minimum as the safety number, explains that preference-based doneness exists and is the cook's informed choice, and **never recommends serving lower temperatures to children, older adults, pregnant people or anyone with a weakened immune system** (higher-risk groups); it never coaches the learner to argue safety with her.
- Raw and undercooked eggs, raw flour and raw cookie dough carry risk; Swoon'd states this and does not encourage raw consumption.
- Allergens: Swoon'd teaches the US "major allergens" and "ask first, read labels"; it gives no medical advice and never suggests an allergen is "fine in small amounts".
- Knife safety: Claw and pinch grip, stable board, sharp knife; no speed scoring, no "cut without looking" content. Fire and grill safety: never grill or burn charcoal indoors or in enclosed spaces (carbon monoxide); keep a fire extinguisher or a bucket of water or sand nearby; never add lighter fluid to hot coals. Kidney beans: boil raw dried red kidney beans vigorously for at least 10 minutes; do not rely on a slow cooker alone.
- No nutrition, diet, weight-loss or medical claims. No claims about "healthy"/"clean" foods. Alcohol appears only as an ingredient for adults with a note that cooking does not remove all alcohol.
- Voice: jokes target the learner's ignorance, never the crush, never her family recipes, never her cooking; never mock cuisines or "food snobs". Cultural respect: cuisines taught with curiosity, no stereotypes.
- Never encourage the learner to fake culinary skill or claim credit for food they did not make.

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Knife anatomy, grips, cuts (julienne to brunoise), onion-dice steps | Procedural / original vector | Swoon'd | `original-swoond` |
| Beef primal chart, chicken parts, fish types | Procedural | Swoon'd | `original-swoond` |
| Pan and pot cross-sections, cookware silhouettes | Procedural | Swoon'd | `original-swoond` |
| Browning ladder (pale to deep brown), doneness diagrams (temperature bands) | Procedural | Swoon'd | `original-swoond` |
| Dried-chile and spice lineup | Original vector | Swoon'd | `original-swoond` |
| Thermometer placement diagrams; thawing and cooling diagrams | Procedural | Swoon'd | `original-swoond` |
| Sizzle, oil crackle, rolling vs simmer, wok sizzle | Synthesized / recorded in-house | Swoon'd | `original-swoond` |
| Seasonal produce tables, holiday calendars | Data cards, no images | Curated | n/a |
| Show, award and cookbook cards | Text + links only | Curated | n/a (no images) |

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Mise en place, heat language, why browning works, salt/fat/acid/water, knife basics, food-safety numbers (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Technique, gear debates, salt brands, pan wars, kitchen culture, cookbooks and shows, cuisine deep dives (section 4).
- [x] 3. **What current information matters?** Seasonal produce, holiday food safety, recalls (link-out), what is on the food screen and shelf, awards (section 6). No scoreboard data.
- [x] 4. **What should be interactive?** Decision scenarios, sequencing, visual and hotspot recognition, sound cues, estimates, conversation; zero Unity sims (sections 5, 12).
- [x] 5. **What should NOT be gamified?** Food safety numbers, allergens, knife speed, diets, cuisines-as-ranking, family recipes (section 5).
- [x] 6. **How should it personalize?** cuisine, skill level, equipment, region, style (section 8).
- [x] 7. **What does conversational competence look like?** Decode her dinner stories, ask honest technique questions, admit gaps, offer to help (sections 9, 10).
- [x] 8. **What data providers are needed?** Curated seasonal and media calendars, USDA FSIS and FDA recalls (link-out), NWS for optional grilling weather, publisher links (`live-data.md`).
- [x] 9. **What licensing constraints apply?** Recipes and cookbook text, show clips and photos, brand marks, publisher text; original art and audio only (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, safety gate, review ladder, talk-track Smooth >= 60, competence statement (section 10).

Additional gates: [ ] manifest validates (run `tools/validate`); [ ] curriculum validates (not yet authored); [x] no Unity sims, so no sim specs to approve; [ ] every image/audio asset has a license id (assets not yet produced; ids defined); [ ] safety review of `food-safety` and cooking-safety lessons (recommended release gate; see `NOTES_FOR_ORCHESTRATOR.md`); [ ] voice review; [x] no copied publisher text (all copy original).

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Approve zero Unity sims for cooking (rationale in sections 5 and 12). Any candidate to re-open must name the concept, the failing native design and the rubric signal. | Product | No |
| 2 | Food-safety and cooking-safety review by a qualified reviewer (registered dietitian, food scientist or Extension food-safety educator) before release of `food-safety`, `kitchen-science` (kidney beans, eggs), `bake-05`, `bbq-01` and `bbq-02`. Recommended as a release gate (mirrors hiking S-05). | Product/Content | Yes for release |
| 3 | Steak doneness lessons: confirm the framing "USDA minimum 145 F with rest is the safety number; lower is an informed preference and never for higher-risk groups" is acceptable copy. | Product/Content | No |
| 4 | Unit count 23 (5+4+3+8+1+1+1) exceeds 8-14; approve, or fold the four smaller cuisine units into a single tagged `branches` unit (as pickleball does). | Product | No |
| 5 | Cuisine branch launch set: `baking`, `italian`, `mexican`, `bbq-grilling` at launch and `french`, `chinese`, `japanese`, `indian` at 1.1? Which sub-cuisines (Thai, Korean, Southern US, Middle Eastern) next? | Product | No |
| 6 | Recalls card: confirm USDA FSIS and FDA data terms and whether Swoon'd may show recall summaries in-app (link-out default). | Legal/Data | No |
| 7 | Seasonal produce source: Extension guides vary by state; is a national curated table plus optional regional overlay acceptable at launch? | Content | No |
| 8 | Media accuracy (The Bear final season, Top Chef season 23, James Beard 2026): re-verify at release; who owns the monthly media refresh? | Content | No |
| 9 | Alcohol as an ingredient: any age-gate or copy requirements for wine or spirits in recipes (deglazing, flambé)? | Product/Legal | No |
| 10 | Original audio: synthesize or record in-house the sizzle, boil and oil sounds? | Product | No (synthesize for MVP) |
