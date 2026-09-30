# Native Exercise Plan: Cooking (`cooking`)

Tier B plan for `docs/courses/cooking/`. **There are no Tier A sims** (`sims/` does not exist; see CDS sections 5 and 12). All 13 native exercise types are used. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with ajv when this file was written). Conventions: prompts <= 12 words; every answer explained; asset `license` ids are `original-swoond` (procedural or original art, synthesized or in-house audio); no third-party marks or photographs. Food-safety numbers are USDA FSIS home-cook guidance (verified 2026-09-30); rule and recipe text is always paraphrased, never copied from a book, site or show.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite. Why-questions ("why dry the steak?"), terms, cuisine facts. Distractors are the misconceptions from CDS section 2. | ~190 |
| `binary-call` | Safe / not safe, true / myth: rinse the chicken, sear seals juices, leftovers on the counter, dishwasher and knives. Scenes are `none` or a procedural diagram. | ~55 |
| `term-match` | Introduce 3 to 6 related terms: kitchen verbs, cuts, mother sauces, dried chiles, regional dishes. | ~30 |
| `sequence-order` | Processes with a `why` per step: mise en place, onion dice, sear then pan sauce, braise, blanch and shock, hollandaise, timing a dinner. | ~45 |
| `visual-id` | Cuts, cookware, browning ladder, doneness cues, dried chiles. Original vector art only. | ~50 |
| `decision-scenario` | The judgment engine: the sauce broke, the chicken reads 158 F, the soup is flat, which pan, what starts now. Best / acceptable / poor with an `expertNote` and a `safetyNote` on safety items. | ~130 |
| `talk-track` | 20 talk tracks at launch; 8 are written in full in section 4. Smooth meter; replies reward curiosity and honesty. | 20 |
| `timing-tap` | Only 1D feel, always slow-mode friendly, never speed pressure: pull the eggs, toast the spices, brown the butter. | ~8 |
| `say-this` | Decode what she just said; every item has a `noFakeExpertNote` and honest follow-ups. | ~70 |
| `fill-the-gap` | Vocabulary and rules in context; quick review card. | ~30 |
| `listening-id` | Sizzle, boil stages, oil ready, wok. Original or synthesized audio, Skip always available. | ~15 |
| `estimate-slider` | Temperatures, hours, rest times, ratios. Safety numbers use tight tolerances. | ~35 |
| `hotspot-tap` | Static diagrams: knife parts, grip, thermometer placement, beef primals, oven racks. Procedural diagrams. | ~35 |

Estimated total: about 650 native items across 118 lessons and the review loop (5 to 6 per lesson including review pools). Cross-type rules: each lesson ends with one item that carries a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`; safety review is never timed.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

**Sample 1** (lesson `heat-03`)

```json
{
  "prompt": "Why pat a steak dry before it hits the pan?",
  "options": [
    { "id": "a", "text": "Surface water must boil off before the meat can brown" },
    { "id": "b", "text": "Dry meat absorbs more oil" },
    { "id": "c", "text": "It removes bacteria from the surface" },
    { "id": "d", "text": "It makes the steak thicker" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Water can't get hotter than 212 F, so a wet surface steams first. Browning (the Maillard reaction) needs a dry, hotter surface, so dry meat gets the crust.",
    "incorrect": "It's about browning. Surface water holds the meat near 212 F until it evaporates, which steams instead of sears. Patting dry lets the pan do its browning work.",
    "sayThisLine": "I dry it first so it sears instead of steams."
  }
}
```

**Sample 2** (lesson `safe-01`)

```json
{
  "prompt": "Which range is USDA's food-safety danger zone?",
  "options": [
    { "id": "a", "text": "40 F to 140 F" },
    { "id": "b", "text": "0 F to 32 F" },
    { "id": "c", "text": "100 F to 212 F" },
    { "id": "d", "text": "212 F to 400 F" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Bacteria multiply fastest between 40 and 140 F, so perishable food should spend as little time there as possible. Cold food stays cold; hot food stays hot.",
    "incorrect": "USDA's danger zone is 40 to 140 F. That's the range where bacteria multiply quickest, which is why the fridge stays cold and hot food stays hot until it is served.",
    "sayThisLine": "Keep cold food cold and hot food hot."
  }
}
```

**Sample 3** (lesson `sfa-03`)

```json
{
  "prompt": "Why does a teaspoon of kosher salt vary by brand?",
  "options": [
    { "id": "a", "text": "Crystal shape changes how much salt fits in a spoon" },
    { "id": "b", "text": "Some brands add sugar" },
    { "id": "c", "text": "Bigger bags contain stronger salt" },
    { "id": "d", "text": "Only table salt can be measured by volume" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Flaky crystals pack loosely and dense ones pack tightly, so a teaspoon of one brand can be noticeably saltier than another. Weighing salt removes the guesswork.",
    "incorrect": "It's crystal shape. Hollow, flaky crystals leave air in the spoon and dense ones do not, so the same volume holds different amounts of salt. Cooks who care will weigh it.",
    "sayThisLine": "Which kosher salt do you use? I hear they measure differently."
  }
}
```

**Sample 4** (lesson `sfa-05`)

```json
{
  "prompt": "A soup tastes flat but salty enough. What helps most?",
  "options": [
    { "id": "a", "text": "A squeeze of lemon or a splash of vinegar" },
    { "id": "b", "text": "More salt" },
    { "id": "c", "text": "More water" },
    { "id": "d", "text": "Turn the heat higher" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Acid brightens and sharpens flavors the way salt amplifies them. When salt is already right and the dish still tastes dull, a little acid is often the missing piece.",
    "incorrect": "When a dish is salted enough but still flat, it usually needs acid. A small squeeze of lemon or splash of vinegar wakes flavors up. More salt would only make it salty and flat.",
    "sayThisLine": "It tastes flat. Does it need acid?"
  }
}
```

### 2.2 `binary-call`

**Sample 1** (lesson `safe-04`)

```json
{
  "prompt": "Raw chicken from the package. Rinse it first?",
  "scene": { "kind": "none", "alt": "A package of raw chicken breasts on a cutting board next to a kitchen sink." },
  "choices": [
    { "id": "rinse-it", "label": "Rinse it" },
    { "id": "dont-rinse", "label": "Don't rinse it" }
  ],
  "correctChoiceId": "dont-rinse",
  "explanation": {
    "correct": "USDA advises not washing raw poultry. Rinsing splashes bacteria onto the sink, counters and nearby food, and cooking to 165 F is what makes the chicken safe.",
    "incorrect": "Skip the rinse. Washing raw chicken can spread bacteria up to about three feet around the sink. Cooking it to 165 F is what kills them, and a thermometer is how you know.",
    "sayThisLine": "I don't wash chicken. Splashing is how germs travel."
  },
  "ruleTag": "Don't wash raw poultry"
}
```

**Sample 2** (lesson `gear-04`)

```json
{
  "prompt": "Searing seals in the juices. True or myth?",
  "scene": { "kind": "none", "alt": "A thick steak sizzling in a hot skillet, dark crust forming on the underside." },
  "choices": [
    { "id": "true", "label": "True" },
    { "id": "myth", "label": "Myth" }
  ],
  "correctChoiceId": "myth",
  "explanation": {
    "correct": "Myth. A seared crust is not waterproof, and meat still loses moisture as it cooks. We sear for flavor from browning, not to lock anything in.",
    "incorrect": "It's a myth. Meat keeps losing moisture as it cooks, sear or not. Searing is worth it because browning creates deep, roasted flavor and a crisp crust.",
    "sayThisLine": "I sear for the crust and the flavor, not to seal anything in."
  },
  "ruleTag": "Kitchen myth"
}
```

**Sample 3** (lesson `safe-06`)

```json
{
  "prompt": "Cooked rice sat on the counter three hours. Keep it?",
  "scene": { "kind": "none", "alt": "A pot of cooked rice with the lid off sitting on a kitchen counter, room temperature." },
  "choices": [
    { "id": "keep-it", "label": "Keep it" },
    { "id": "toss-it", "label": "Toss it" }
  ],
  "correctChoiceId": "toss-it",
  "explanation": {
    "correct": "Toss it. Perishable food shouldn't sit out more than two hours (one hour above 90 F). Reheating doesn't reliably undo what bacteria may have produced.",
    "incorrect": "Throw it out. USDA's two-hour rule applies to cooked rice too. Refrigerate leftovers within two hours, or one hour if it's hotter than 90 F outside.",
    "sayThisLine": "When in doubt, throw it out. Two hours is the limit."
  },
  "ruleTag": "Two-hour rule"
}
```

### 2.3 `term-match`

**Sample 1** (lesson `kit-06`)

```json
{
  "prompt": "Match the kitchen verb to what it means.",
  "pairs": [
    { "id": "saute", "term": "Sauté", "definition": "Cook quickly in a little fat over fairly high heat" },
    { "id": "sweat", "term": "Sweat", "definition": "Cook gently until soft without browning" },
    { "id": "deglaze", "term": "Deglaze", "definition": "Add liquid to a hot pan to lift the browned bits" },
    { "id": "fold", "term": "Fold", "definition": "Gently combine so trapped air stays in" },
    { "id": "reduce", "term": "Reduce", "definition": "Simmer a liquid to concentrate flavor" }
  ],
  "distractorDefinitions": ["Cut into very thin strips"],
  "explanation": {
    "summary": "Recipes use verbs as shorthand for what the food should be doing. Sauté means quick and hot, sweat means gentle and soft, deglaze means lifting the flavorful browned bits, fold protects air, and reduce concentrates.",
    "sayThisLine": "Wait, sweating the onions means not browning them?"
  }
}
```

**Sample 2** (lesson `knife-05`)

```json
{
  "prompt": "Match each cut to its shape.",
  "pairs": [
    { "id": "julienne", "term": "Julienne", "definition": "Thin matchstick strips, about 1/8 inch thick" },
    { "id": "batonnet", "term": "Batonnet", "definition": "Thicker sticks, about 1/4 inch square" },
    { "id": "brunoise", "term": "Brunoise", "definition": "Tiny 1/8 inch cubes" },
    { "id": "chiffonade", "term": "Chiffonade", "definition": "Thin ribbons of rolled leafy herbs or greens" }
  ],
  "explanation": {
    "summary": "Cut names tell you size and shape, which controls how fast food cooks. Uniform pieces cook evenly, and small ones melt into a dish while bigger ones stay distinct.",
    "sayThisLine": "How fine did you cut those, a brunoise?"
  }
}
```

**Sample 3** (lesson `flav-05`)

```json
{
  "prompt": "Match each mother sauce to its base.",
  "pairs": [
    { "id": "bechamel", "term": "Béchamel", "definition": "Milk thickened with a white roux" },
    { "id": "veloute", "term": "Velouté", "definition": "Light stock thickened with a blond roux" },
    { "id": "espagnole", "term": "Espagnole", "definition": "Brown stock thickened with brown roux and tomato" },
    { "id": "hollandaise", "term": "Hollandaise", "definition": "Egg yolks and melted butter, warmed and whisked" },
    { "id": "tomato", "term": "Tomato sauce", "definition": "Tomatoes cooked down with aromatics" }
  ],
  "explanation": {
    "summary": "The five classical mother sauces, as codified by Escoffier, are starting points: change the liquid, thickener or finish and you get a whole family of sauces. Three are roux-based, one is an emulsion and one is a reduction.",
    "sayThisLine": "Is that sauce a béchamel base, or something else?"
  }
}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `kit-01`)

```json
{
  "prompt": "Put mise en place in the right order.",
  "items": [
    { "id": "read", "text": "Read the whole recipe", "why": "You catch surprises like a two-hour marinade before you're mid-cook." },
    { "id": "gather", "text": "Gather ingredients and tools", "why": "You find out you're out of something while it's still easy to fix." },
    { "id": "prep", "text": "Wash, chop and measure everything", "why": "Cooking moves fast; prepped food means no scrambling while something burns." },
    { "id": "organize", "text": "Arrange prepped items in the order you'll use them", "why": "It keeps your hands and attention on the pan." },
    { "id": "cook", "text": "Start cooking", "why": "Only now does the heat go on, because everything is ready." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Mise en place is 'everything in its place.' Reading first and prepping before heat means the cooking is calm and the food doesn't overcook while you chop.",
    "incorrect": "Read first, then gather, then prep, then organize, and only then cook. The point is that every decision is made before the heat is on.",
    "sayThisLine": "I like to do all my mise before I turn anything on."
  }
}
```

**Sample 2** (lesson `knife-04`)

```json
{
  "prompt": "Put the onion dice in order.",
  "items": [
    { "id": "trim", "text": "Cut the onion in half through root and stem", "why": "The root end holds the layers together while you cut." },
    { "id": "peel", "text": "Peel and trim the stem end, leave the root", "why": "The intact root acts as a handle for your cuts." },
    { "id": "horizontal", "text": "Make horizontal slices toward the root", "why": "These slices set the height of the dice." },
    { "id": "vertical", "text": "Make vertical cuts toward the root", "why": "Vertical cuts set the width of the dice." },
    { "id": "across", "text": "Slice across to release the dice", "why": "The final cuts drop the pieces cleanly, all about the same size." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Keeping the root end intact holds the onion together, so the cuts stay tidy and even. Even pieces cook at the same speed, which is the whole reason cooks care.",
    "incorrect": "Halve through the root, peel, then horizontal cuts, vertical cuts, and finally slice across. The root end stays on until the very last cut because it holds the layers together.",
    "sayThisLine": "Keep the root on. It's the handle."
  }
}
```

**Sample 3** (lesson `tech-02`)

```json
{
  "prompt": "Order a pan sear and pan sauce.",
  "items": [
    { "id": "dry", "text": "Pat the meat dry and season it", "why": "A dry, seasoned surface browns instead of steaming." },
    { "id": "preheat", "text": "Heat the pan until hot, add fat", "why": "A hot pan sets a crust quickly." },
    { "id": "sear", "text": "Sear and rest the meat", "why": "Browning creates the crust; resting keeps juices from running out." },
    { "id": "aromatics", "text": "Add aromatics to the pan", "why": "They soften in the leftover fat and pick up the browned bits." },
    { "id": "deglaze", "text": "Deglaze with liquid and reduce", "why": "The browned bits (fond) dissolve and concentrate into sauce." },
    { "id": "finish", "text": "Swirl in butter and taste", "why": "Butter adds gloss; tasting lets you fix salt and acid." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "The sear leaves fond in the pan, and the sauce is built directly on that flavor. It's why cooks call the pan sauce 'free' flavor from the same pan.",
    "incorrect": "Dry and season, hot pan, sear and rest, aromatics, deglaze and reduce, then finish with butter and taste. The fond from the sear is the base of the sauce, so the sear must come first.",
    "sayThisLine": "Do you build your sauce in the same pan as the sear?"
  }
}
```

### 2.5 `visual-id`

**Sample 1** (lesson `knife-05`)

```json
{
  "prompt": "Which cut is this?",
  "image": {
    "asset": "assets/cooking/cuts/julienne-carrot.svg",
    "alt": "Carrot cut into thin, uniform matchstick strips about two inches long, stacked in a small pile.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "julienne", "text": "Julienne" },
    { "id": "brunoise", "text": "Brunoise" },
    { "id": "chiffonade", "text": "Chiffonade" },
    { "id": "rondelle", "text": "Rondelle" }
  ],
  "correctOptionId": "julienne",
  "explanation": {
    "correct": "Thin matchsticks are julienne. They cook fast and evenly, which is why they show up in stir-fries and salads.",
    "incorrect": "Those long matchsticks are julienne. Brunoise is tiny cubes, chiffonade is ribbons of leaves, and rondelles are round slices.",
    "sayThisLine": "Julienne, right? Matchsticks."
  },
  "cues": ["Long thin sticks about 1/8 inch thick", "Uniform length and width", "Cut from a carrot's straight side"]
}
```

**Sample 2** (lesson `kit-04`)

```json
{
  "prompt": "Which pan is this, and what's it for?",
  "image": {
    "asset": "assets/cooking/cookware/saute-pan.svg",
    "alt": "Wide pan with straight tall sides, a flat bottom and a long handle, drawn in cross-section.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "saute-pan", "text": "Sauté pan: straight sides for searing and sauces" },
    { "id": "skillet", "text": "Skillet: sloped sides for flipping and quick cooking" },
    { "id": "stockpot", "text": "Stockpot: tall, for stocks and boiling" },
    { "id": "wok", "text": "Wok: rounded bottom for high-heat stir-fry" }
  ],
  "correctOptionId": "saute-pan",
  "explanation": {
    "correct": "Straight, tall sides and a flat bottom make a sauté pan: it holds sauce and stops splatter. A skillet has sloped sides that help with flipping and evaporation.",
    "incorrect": "The straight tall sides are the clue: that's a sauté pan. A skillet slopes outward, a stockpot is much taller, and a wok has a rounded bottom.",
    "sayThisLine": "Skillet or sauté pan? I'm learning the difference."
  },
  "cues": ["Straight vertical sides", "Flat wide bottom", "Long handle, often a lid"]
}
```

**Sample 3** (lesson `heat-03`)

```json
{
  "prompt": "Which crust is properly browned, not burnt?",
  "image": {
    "asset": "assets/cooking/browning/browning-ladder.svg",
    "alt": "Four seared chicken thighs in a row: pale and gray, light golden, deep golden brown, and nearly black.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "pale", "text": "The pale, gray one" },
    { "id": "light", "text": "The light golden one" },
    { "id": "deep", "text": "The deep golden brown one" },
    { "id": "black", "text": "The nearly black one" }
  ],
  "correctOptionId": "deep",
  "explanation": {
    "correct": "Deep golden brown means the Maillard reaction has done its work: rich, savory flavor without the bitterness of burnt food. Pale means steamed; black means bitter.",
    "incorrect": "The deep golden brown one. Pale food hasn't browned (often crowded or wet), while nearly black food has crossed into bitter, burnt territory.",
    "sayThisLine": "That's the color I'm chasing. Deep golden, not burnt."
  },
  "cues": ["Even color across the surface", "Deep golden rather than black", "Pale means steamed, black means bitter"]
}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `safe-03`)

```json
{
  "prompt": "The chicken thigh reads 158 F. What now?",
  "situation": {
    "narrative": "You're roasting chicken thighs for two. The skin looks perfect and the juices look clear.",
    "facts": [
      { "label": "Food", "value": "Bone-in chicken thighs" },
      { "label": "Thermometer reading", "value": "158 F, thickest part", "emphasis": "warning" },
      { "label": "USDA minimum", "value": "165 F for poultry", "emphasis": "warning" },
      { "label": "Skin", "value": "Golden brown" },
      { "label": "Juices", "value": "Look clear" }
    ]
  },
  "options": [
    { "id": "keep-cooking", "label": "Keep cooking until it reads 165 F", "verdict": "best", "consequence": "A few more minutes in the oven gets it to a safe 165 F, and thighs stay juicy at that temperature.", "considerations": ["165 F is USDA's minimum for all poultry", "Color and clear juices don't prove it's safe", "Re-check the thickest part, away from the bone"] },
    { "id": "serve-it", "label": "Serve it, the juices are clear", "verdict": "poor", "consequence": "Clear juices and golden skin can appear before the meat is safely cooked, so you'd be guessing with someone else's dinner.", "considerations": ["Color isn't a reliable safety indicator", "158 F is below the USDA minimum"] },
    { "id": "rest-and-check", "label": "Rest it and hope carryover reaches 165 F", "verdict": "acceptable", "consequence": "Carryover might raise the temperature a few degrees, but it isn't guaranteed. You'd need to recheck before serving.", "considerations": ["Small pieces have little carryover", "Only serve after the thermometer confirms 165 F"] }
  ],
  "expertNote": "A thermometer removes the guessing. Cooks check the thickest part without touching bone, and go by the number, not the color of the skin or the juices.",
  "sayThisLine": "I trust the thermometer more than my eyes.",
  "safetyNote": "USDA FSIS: cook all poultry to a safe minimum internal temperature of 165 F (74 C), measured with a food thermometer."
}
```

**Sample 2** (lesson `sci-02`)

```json
{
  "prompt": "Your hollandaise just split. What's the best move?",
  "situation": {
    "narrative": "You whisked butter into warm egg yolks. It looked glossy, then went greasy and separated.",
    "facts": [
      { "label": "Sauce", "value": "Hollandaise, just split" },
      { "label": "Symptom", "value": "Oily layer on top, grainy below" },
      { "label": "Likely cause", "value": "Too hot, or butter added too fast" },
      { "label": "Spare", "value": "One fresh egg yolk, warm water" }
    ]
  },
  "options": [
    { "id": "rebuild", "label": "Start a fresh yolk with water, whisk the broken sauce in slowly", "verdict": "best", "consequence": "The new yolk starts a fresh emulsion and the broken sauce is rebuilt into it, giving you a glossy sauce again.", "considerations": ["The yolk's lecithin holds fat and water together", "Add the broken sauce slowly", "Keep the heat gentle"] },
    { "id": "whisk-hard", "label": "Whisk faster over higher heat", "verdict": "poor", "consequence": "More heat scrambles the yolk and makes the sauce worse.", "considerations": ["Heat is usually the problem", "Overheated yolks turn grainy"] },
    { "id": "add-water", "label": "Off the heat, whisk in a teaspoon of warm water", "verdict": "acceptable", "consequence": "Sometimes it pulls the sauce back together, but a deeply split sauce often needs a fresh yolk.", "considerations": ["Works for a mild split", "Add a little at a time"] }
  ],
  "expertNote": "A broken emulsion is fat and water that lost their bond. Fix it by giving them a fresh emulsifier (yolk) or a little liquid, slowly, off harsh heat."
}
```

**Sample 3** (lesson `sfa-06`)

```json
{
  "prompt": "The soup is too salty. What helps?",
  "situation": {
    "narrative": "You seasoned in layers and the last pinch was one too many. Guests arrive in twenty minutes.",
    "facts": [
      { "label": "Dish", "value": "Vegetable soup, four servings" },
      { "label": "Problem", "value": "Noticeably too salty", "emphasis": "warning" },
      { "label": "On hand", "value": "Water, unsalted stock, lemon, a potato" },
      { "label": "Time", "value": "20 minutes" }
    ]
  },
  "options": [
    { "id": "dilute", "label": "Add unsalted stock or water, then rebalance with a bit of acid", "verdict": "best", "consequence": "Dilution lowers the salt concentration, and a little lemon rounds out the flavor so it doesn't taste watered down.", "considerations": ["Add unsalted liquid, not more salted", "Re-taste after each addition", "Adjust acid last"] },
    { "id": "potato", "label": "Drop in a raw potato to absorb the salt", "verdict": "poor", "consequence": "A potato absorbs liquid, not extra salt, so the soup is just as salty. It's a popular myth.", "considerations": ["Salt stays dissolved in the liquid", "Dilution is what really works"] },
    { "id": "sugar", "label": "Add a pinch of sugar to mask it", "verdict": "acceptable", "consequence": "A tiny amount may soften harshness but it doesn't remove salt and can make the soup taste odd.", "considerations": ["Masks rather than fixes", "Use very little"] }
  ],
  "expertNote": "You can't remove salt, only dilute or balance it. Cooks salt in layers and taste as they go so a correction is small when it's needed."
}
```

**Sample 4** (lesson `heat-05`)

```json
{
  "prompt": "The mushrooms are gray and wet. What went wrong?",
  "situation": {
    "narrative": "You dumped a full pound of sliced mushrooms into a skillet. Ten minutes in, they're swimming and pale.",
    "facts": [
      { "label": "Pan", "value": "Ten-inch skillet, medium heat" },
      { "label": "Amount", "value": "One pound, all at once" },
      { "label": "Result", "value": "Gray, wet, no browning" },
      { "label": "Goal", "value": "Golden brown, concentrated flavor" }
    ]
  },
  "options": [
    { "id": "batches", "label": "Cook in batches in a hot pan, with space between pieces", "verdict": "best", "consequence": "Space lets steam escape, so the surface dries and browns. Batches take more time but the flavor is far better.", "considerations": ["Crowding traps steam", "Water caps the pan near 212 F", "Don't salt too early if you want browning"] },
    { "id": "lid", "label": "Put a lid on and keep cooking", "verdict": "poor", "consequence": "A lid traps even more steam, so the mushrooms stew instead of browning.", "considerations": ["Steam keeps the temperature low"] },
    { "id": "wait", "label": "Keep cooking until the liquid evaporates, then let them brown", "verdict": "acceptable", "consequence": "It can work; once the water is gone the mushrooms brown, but it takes longer and they can turn rubbery.", "considerations": ["Slower than batches", "Watch for burning near the end"] }
  ],
  "expertNote": "Browning needs a dry surface above 212 F. Crowding, wet food and a cold pan all keep the surface wet, which is the enemy of browning."
}
```

### 2.7 `talk-track`

The three sample payloads for `talk-track` are the full scenarios in section 4 (`tt-scratch`, `tt-sauce-broke`, `tt-knife`, and five more). Each is a complete payload that validates against `talk-track.schema.json`.

### 2.8 `timing-tap`

**Sample 1** (lesson `sci-01`)

```json
{
  "prompt": "Pull the scrambled eggs while still glossy.",
  "theme": { "label": "Soft scramble", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 40, "zoneEndPct": 62, "sweepSeconds": 5 },
    { "zoneStartPct": 44, "zoneEndPct": 60, "sweepSeconds": 4.5 },
    { "zoneStartPct": 46, "zoneEndPct": 58, "sweepSeconds": 4 }
  ],
  "explanation": {
    "correct": "You pulled them while they were still soft and glossy. Eggs keep cooking from their own heat, so cooks take them off just before they look finished.",
    "incorrect": "Too early looks runny; too late turns rubbery. Eggs keep cooking after you pull them, so aim for glossy and slightly underdone, then let carryover finish."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `flav-03`)

```json
{
  "prompt": "Stop when the spices smell toasty.",
  "theme": { "label": "Toast spices", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 55, "zoneEndPct": 75, "sweepSeconds": 5 },
    { "zoneStartPct": 58, "zoneEndPct": 74, "sweepSeconds": 4.5 },
    { "zoneStartPct": 60, "zoneEndPct": 72, "sweepSeconds": 4 }
  ],
  "explanation": {
    "correct": "That's the window: fragrant but not scorched. Toasting spices in a dry pan for less than a minute wakes their oils; go past it and they turn bitter.",
    "incorrect": "Too early and the spices taste raw; too late and they scorch and turn bitter. Cooks go by smell and a slight color change, and they pull the pan off the heat right away."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 3** (lesson `ita-02`)

```json
{
  "prompt": "Pull the pasta just before al dente.",
  "theme": { "label": "Al dente", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 62, "zoneEndPct": 80, "sweepSeconds": 5 },
    { "zoneStartPct": 64, "zoneEndPct": 78, "sweepSeconds": 4.5 }
  ],
  "explanation": {
    "correct": "That's the moment: a slightly firm center, because the pasta will finish cooking in the sauce. Cooks pull it a minute or two early and toss it with the sauce and some pasta water.",
    "incorrect": "Too early is chalky and too late is mushy. Pull it a minute or two before the package time, taste a piece, and finish it in the pan with the sauce."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

### 2.9 `say-this`

**Sample 1** (lesson `heat-03`)

```json
{
  "statement": { "speaker": "Maya", "text": "I finally got a proper sear on the scallops. Bone-dry, ripping hot pan." },
  "question": "What is she talking about?",
  "options": [
    { "id": "browned", "text": "She got a deep golden crust on the scallops", "isCorrect": true, "explanation": "A proper sear is a browned crust." },
    { "id": "dry-hot", "text": "She dried them and used a very hot pan so they'd brown, not steam", "isCorrect": true, "explanation": "Dry surface plus high heat is the recipe for browning." },
    { "id": "boiled", "text": "She boiled the scallops", "isCorrect": false, "explanation": "Boiling is the opposite of a sear." },
    { "id": "sauce", "text": "She made a scallop sauce", "isCorrect": false, "explanation": "She's talking about the crust on the scallops themselves." }
  ],
  "translation": "She got a nicely browned crust on the scallops by drying them and using a really hot pan, so they browned instead of steaming.",
  "followUps": [
    { "line": "What made the difference this time?", "why": "It invites her to explain her process, which she loves." },
    { "line": "Did you do anything with the pan sauce?", "why": "Shows you know the sear leaves flavor behind." }
  ],
  "noFakeExpertNote": "You don't have to have seared scallops to ask what changed. Curiosity beats bluffing."
}
```

**Sample 2** (lesson `sfa-05`)

```json
{
  "statement": { "speaker": "Jordan", "text": "Everything I make needs more acid. A squeeze of lemon fixes it." },
  "question": "What is he talking about?",
  "options": [
    { "id": "brighten", "text": "A little lemon or vinegar brightens flat-tasting food", "isCorrect": true, "explanation": "Acid sharpens flavors." },
    { "id": "sour", "text": "His food is too sour", "isCorrect": false, "explanation": "He wants more acid, not less." },
    { "id": "salt", "text": "He wants to add more salt", "isCorrect": false, "explanation": "Acid and salt are different tools." },
    { "id": "lemons", "text": "He is worried about lemons in his kitchen", "isCorrect": false, "explanation": "It's about seasoning." }
  ],
  "translation": "When his cooking tastes flat or heavy, a little lemon or vinegar wakes it up. He thinks of acid as a seasoning, like salt.",
  "followUps": [
    { "line": "Do you reach for lemon or vinegar first?", "why": "Shows you know acid comes in different forms." },
    { "line": "What's the dish it fixed most recently?", "why": "Turns a rule into a story he can tell." }
  ],
  "noFakeExpertNote": "If you haven't noticed acid in food yet, say so and ask him to show you a before-and-after."
}
```

**Sample 3** (lesson `heat-06`)

```json
{
  "statement": { "speaker": "Priya", "text": "I pulled it at 130 and let it rest. Carryover did the rest." },
  "question": "What is she talking about?",
  "options": [
    { "id": "carryover", "text": "The meat keeps cooking from its own heat after leaving the oven", "isCorrect": true, "explanation": "That's carryover cooking." },
    { "id": "pulled", "text": "She removed the meat from the heat before it reached its final temperature", "isCorrect": true, "explanation": "'Pulled it' means took it off the heat early." },
    { "id": "shredded", "text": "She made pulled pork", "isCorrect": false, "explanation": "'Pulled it' here is about timing." },
    { "id": "cold", "text": "She let the meat go cold", "isCorrect": false, "explanation": "Resting isn't the same as cooling." }
  ],
  "translation": "She took the meat off the heat before it hit its target temperature, because it keeps rising while it rests. She's timing it so it lands where she wants.",
  "followUps": [
    { "line": "How many degrees does it usually climb?", "why": "Shows you understand carryover is measurable." },
    { "line": "Do you go by a thermometer?", "why": "Invites her to share her method without making a safety point." }
  ],
  "noFakeExpertNote": "Note for the learner: safe minimums come from USDA, and your job here is to ask, not to debate her doneness."
}
```

### 2.10 `fill-the-gap`

**Sample 1** (lesson `sfa-02`)

```json
{
  "prompt": "Complete the seasoning rule.",
  "template": "Season in {{gap-one}}, and {{gap-two}} as you go.",
  "gaps": [
    { "id": "gap-one", "options": ["layers", "the end", "a rush", "secret"], "correct": "layers" },
    { "id": "gap-two", "options": ["taste", "measure", "guess", "stir"], "correct": "taste" }
  ],
  "explanation": {
    "correct": "Salting at several points lets flavor build, and tasting as you go tells you what the dish needs. It beats one big salting at the end.",
    "incorrect": "Season in layers and taste as you go. Salt added early has time to work into the food, and tasting shows you what's still missing.",
    "sayThisLine": "I season in layers and taste as I go."
  }
}
```

**Sample 2** (lesson `heat-06`)

```json
{
  "prompt": "Finish the sentence about resting meat.",
  "template": "Meat keeps cooking after it leaves the heat, called {{gap-one}} cooking, and a rest lets the {{gap-two}} settle.",
  "gaps": [
    { "id": "gap-one", "options": ["carryover", "reverse", "residual sear", "sous vide"], "correct": "carryover" },
    { "id": "gap-two", "options": ["juices", "fat cap", "bones", "smoke"], "correct": "juices" }
  ],
  "explanation": {
    "correct": "Carryover cooking is the heat moving from the outside toward the center. Resting also gives the juices time to redistribute instead of running onto the board.",
    "incorrect": "It's carryover cooking, and the rest lets the juices settle. Cutting immediately sends more of them onto the cutting board.",
    "sayThisLine": "Carryover means it keeps cooking while it rests."
  }
}
```

**Sample 3** (lesson `safe-03`)

```json
{
  "prompt": "Fill in the USDA safe temperatures.",
  "template": "Poultry needs {{gap-one}} F, ground beef {{gap-two}} F, and steaks {{gap-three}} F with a rest.",
  "gaps": [
    { "id": "gap-one", "options": ["145", "160", "165", "180"], "correct": "165" },
    { "id": "gap-two", "options": ["145", "160", "165", "180"], "correct": "160" },
    { "id": "gap-three", "options": ["145", "160", "165", "180"], "correct": "145" }
  ],
  "explanation": {
    "correct": "USDA's home-cook minimums are 165 F for poultry, 160 F for ground meats and 145 F for whole cuts such as steaks, with a three-minute rest for those whole cuts.",
    "incorrect": "The USDA minimums are 165 F for poultry, 160 F for ground meats, and 145 F for steaks, chops and roasts with a three-minute rest. Ground meat is higher because bacteria get mixed inside.",
    "sayThisLine": "165 for chicken, 160 for ground, 145 for steak."
  }
}
```

### 2.11 `listening-id`

**Sample 1** (lesson `heat-05`)

```json
{
  "prompt": "Is the pan hot enough to sear?",
  "audio": {
    "asset": "audio/cooking/sizzle-hot-pan.m4a",
    "durationMs": 6000,
    "license": "original-swoond",
    "description": "A steak hitting a very hot pan: an immediate loud sizzle that stays steady, then a softer crackle.",
    "maxPlays": 3
  },
  "options": [
    { "id": "hot", "text": "Yes, an instant, steady sizzle means the pan is hot" },
    { "id": "cold", "text": "No, a quiet hiss means the pan is cold" },
    { "id": "burning", "text": "No, the pan is smoking and burning the food" }
  ],
  "correctOptionId": "hot",
  "explanation": {
    "correct": "A loud, immediate sizzle that holds steady tells you the pan is hot enough that water is flashing to steam. A weak hiss means a cold pan and gray food.",
    "incorrect": "The loud instant sizzle is the good sign. A faint hiss means the pan isn't hot enough, so food will steam, and you'd hear crackling and smell burning if it were too hot.",
    "sayThisLine": "I listen for the sizzle before I trust the pan."
  },
  "listenFor": ["Instant, loud sizzle", "Steady, not fading", "Crackle settling after a few seconds"]
}
```

**Sample 2** (lesson `kit-05`)

```json
{
  "prompt": "Simmer or rolling boil?",
  "audio": {
    "asset": "audio/cooking/simmer-gentle.m4a",
    "durationMs": 6000,
    "license": "original-swoond",
    "description": "A pot of water at a gentle simmer: soft, quiet bubbling with occasional small pops.",
    "maxPlays": 3
  },
  "options": [
    { "id": "simmer", "text": "A gentle simmer" },
    { "id": "rolling", "text": "A rolling boil" },
    { "id": "cold", "text": "Not yet heated" }
  ],
  "correctOptionId": "simmer",
  "explanation": {
    "correct": "Soft, quiet bubbling with small pops is a simmer, ideal for soups and braises. A rolling boil is louder and churns the whole surface.",
    "incorrect": "That's a gentle simmer: quiet, small bubbles. A rolling boil is much louder with large bubbles breaking across the whole surface, and the water is still at about 212 F either way.",
    "sayThisLine": "Turn it down to a simmer, not a boil."
  },
  "listenFor": ["Quiet, soft bubbling", "Small bubbles, occasional pops", "No churning roar"]
}
```

**Sample 3** (lesson `chn-01`)

```json
{
  "prompt": "Is this wok ready for the ingredients?",
  "audio": {
    "asset": "audio/cooking/wok-roar.m4a",
    "durationMs": 7000,
    "license": "original-swoond",
    "description": "A wok over very high heat with vegetables tossed in: a loud, constant roar with sharp crackles as food moves.",
    "maxPlays": 3
  },
  "options": [
    { "id": "yes", "text": "Yes, a loud roar and crackle means high, even heat" },
    { "id": "no-cold", "text": "No, it sounds cold and damp" },
    { "id": "no-oil", "text": "No, it sounds like no oil was added" }
  ],
  "correctOptionId": "yes",
  "explanation": {
    "correct": "A loud roar with sharp crackles tells you the wok is hot enough for stir-frying, where high heat sears food quickly. Cooks call the smoky flavor that follows wok hei.",
    "incorrect": "That loud, continuous roar with crackles is a hot wok doing its job. A quiet sizzle would mean food is stewing, which is why stir-fry cooks keep the heat high and the food moving.",
    "sayThisLine": "How do you know when the wok is hot enough?"
  },
  "listenFor": ["Roar rather than hiss", "Sharp crackles as food moves", "Steady high volume"]
}
```

### 2.12 `estimate-slider`

**Sample 1** (lesson `safe-03`)

```json
{
  "prompt": "USDA minimum for cooked chicken? Estimate in Fahrenheit.",
  "unit": "F",
  "min": 120,
  "max": 200,
  "step": 1,
  "correctValue": 165,
  "tolerance": { "full": 0, "partial": 5 },
  "explanation": {
    "correct": "Exactly 165 F (74 C) is USDA's minimum internal temperature for all poultry, measured in the thickest part with a food thermometer.",
    "incorrect": "The number is 165 F (74 C) for all poultry. Because this one is a safety number, only the exact value counts as full credit.",
    "sayThisLine": "165 for poultry, no exceptions."
  }
}
```

**Sample 2** (lesson `safe-06`)

```json
{
  "prompt": "How long can cooked food sit out at room temperature?",
  "unit": "hours",
  "min": 0,
  "max": 8,
  "step": 0.5,
  "correctValue": 2,
  "tolerance": { "full": 0, "partial": 1 },
  "explanation": {
    "correct": "Two hours is the limit for perishable food (one hour if it's above 90 F). After that, bacteria have had time to multiply in the danger zone.",
    "incorrect": "The limit is two hours, or one hour when it's above 90 F. After that, the food spent too long in the danger zone. Refrigerate leftovers promptly.",
    "sayThisLine": "The two-hour rule. One hour if it's hot out."
  }
}
```

**Sample 3** (lesson `heat-06`)

```json
{
  "prompt": "A large roast rests. How much does the center rise?",
  "unit": "F",
  "min": 0,
  "max": 30,
  "step": 1,
  "correctValue": 10,
  "tolerance": { "full": 3, "partial": 7 },
  "explanation": {
    "correct": "Around 5 to 15 F is typical for a big roast, so ten is a sensible estimate. Larger and hotter-cooked pieces carry more heat inward.",
    "incorrect": "A big roast usually gains about 5 to 15 F while resting. Small pieces gain just a few degrees, which is why carryover matters more for large cuts.",
    "sayThisLine": "Carryover on a big roast is about ten degrees."
  }
}
```

### 2.13 `hotspot-tap`

**Sample 1** (lesson `knife-01`)

```json
{
  "prompt": "Tap the heel of the knife.",
  "diagram": {
    "diagramId": "knife-anatomy",
    "aspectRatio": 2,
    "alt": "Side view of a chef's knife with the blade pointing right: the handle on the left, then the bolster, the heel just past it, the belly along the middle, and the tip on the right."
  },
  "hotspots": [
    { "id": "heel", "label": "Heel", "shape": { "kind": "rect", "x": 0.3, "y": 0.45, "w": 0.15, "h": 0.4 } },
    { "id": "belly", "label": "Belly", "shape": { "kind": "rect", "x": 0.5, "y": 0.5, "w": 0.2, "h": 0.4 } },
    { "id": "tip", "label": "Tip", "shape": { "kind": "rect", "x": 0.8, "y": 0.4, "w": 0.15, "h": 0.3 } },
    { "id": "spine", "label": "Spine", "shape": { "kind": "rect", "x": 0.3, "y": 0.2, "w": 0.6, "h": 0.15 } }
  ],
  "correctHotspotIds": ["heel"],
  "explanation": {
    "correct": "The heel is the back of the blade near the handle. Cooks use it for cutting through hard things like a carrot, since it's the strongest, heaviest part.",
    "incorrect": "The heel is the back part of the blade, closest to the handle. The tip is the front, the belly curves along the middle, and the spine is the blunt top edge.",
    "sayThisLine": "I use the heel for the tough stuff, right?"
  }
}
```

**Sample 2** (lesson `safe-02`)

```json
{
  "prompt": "Where does the thermometer go?",
  "diagram": {
    "diagramId": "chicken-breast-thermometer",
    "aspectRatio": 1.5,
    "alt": "Cross-section of a roasted chicken breast with a rib bone along the bottom edge; four marked spots: thick center, thin end, touching the bone, and right at the surface."
  },
  "hotspots": [
    { "id": "thick-center", "label": "Thickest part, center", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.5, "r": 0.12 } },
    { "id": "thin-end", "label": "Thin end", "shape": { "kind": "circle", "cx": 0.85, "cy": 0.5, "r": 0.09 } },
    { "id": "on-bone", "label": "Touching the bone", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.85, "r": 0.09 } },
    { "id": "surface", "label": "Right at the surface", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.12, "r": 0.08 } }
  ],
  "correctHotspotIds": ["thick-center"],
  "explanation": {
    "correct": "The thickest part is the last place to heat up, so it tells you the truth. Keep the probe off the bone, which runs hotter and gives a false reading.",
    "incorrect": "Aim for the center of the thickest part, away from the bone. The thin end and the surface heat up first and would read too high, and bone conducts heat differently.",
    "sayThisLine": "Thickest part, away from bone. Got it."
  }
}
```

**Sample 3** (lesson `ing-01`)

```json
{
  "prompt": "Which primal is the most tender steak cut?",
  "diagram": {
    "diagramId": "beef-primal-chart",
    "aspectRatio": 2,
    "alt": "Side view of a cow outline divided into primal regions, from the front: chuck, rib, short loin, sirloin, round, with brisket, plate and flank underneath."
  },
  "hotspots": [
    { "id": "chuck", "label": "Chuck (shoulder)", "shape": { "kind": "rect", "x": 0.1, "y": 0.2, "w": 0.2, "h": 0.35 } },
    { "id": "rib", "label": "Rib", "shape": { "kind": "rect", "x": 0.32, "y": 0.2, "w": 0.15, "h": 0.3 } },
    { "id": "short-loin", "label": "Short loin", "shape": { "kind": "rect", "x": 0.48, "y": 0.2, "w": 0.15, "h": 0.3 } },
    { "id": "round", "label": "Round (rear leg)", "shape": { "kind": "rect", "x": 0.7, "y": 0.2, "w": 0.2, "h": 0.45 } }
  ],
  "correctHotspotIds": ["short-loin"],
  "explanation": {
    "correct": "The short loin (strip and tenderloin steaks) sits along the back and does little work, so the muscle stays tender. Hard-working areas such as chuck and round are tougher.",
    "incorrect": "The short loin, along the back, is the tender one. Chuck and round work hard as shoulder and leg muscles, so they are tougher and better for braising.",
    "sayThisLine": "The tender cuts come from muscles that don't work much."
  }
}
```

---

## 3. Playbook terms (66)

Definition plus an example line in an enthusiast's voice. Plain words, no jargon in the definition.

| Term | Definition | Example line |
|---|---|---|
| Mise en place | Prepping and organizing everything before you turn on the heat | "Mise en place saves my life on weeknights." |
| Sauté | Cook quickly in a little fat over fairly high heat | "I'll sauté the onions while the pasta boils." |
| Sweat | Cook gently until soft and translucent without browning | "Sweat the shallots first, don't let them color." |
| Sear | Brown the surface of food in a hot pan | "Get a hard sear on the outside, then finish it in the oven." |
| Deglaze | Add liquid to a hot pan to lift the browned bits | "Deglaze with a splash of wine." |
| Fond | The browned bits left stuck to the pan after searing | "Everything is in the fond." |
| Reduce | Simmer a liquid until some evaporates and flavor concentrates | "Reduce it by half and it's practically a glaze." |
| Braise | Brown food, then cook it slowly in a little liquid in a covered pot | "The short ribs braised for three hours." |
| Roast | Cook with dry oven heat, usually at higher temperatures | "Roasted vegetables need a hot oven." |
| Blanch | Briefly boil food, then stop the cooking in ice water | "Blanch the green beans so they stay bright." |
| Shock | Plunge hot food into ice water to stop cooking | "Shock them right away or they'll go gray." |
| Julienne | Cut into thin matchstick strips | "I julienned the carrots for the slaw." |
| Brunoise | Cut into tiny cubes, about 1/8 inch | "A fine brunoise of shallot for the vinaigrette." |
| Chiffonade | Slice leafy herbs or greens into thin ribbons | "Chiffonade the basil right at the end." |
| Roux | Flour cooked in fat, used to thicken sauces | "Cook the roux until it smells nutty." |
| Emulsion | A stable mix of fat and water, like mayo or vinaigrette | "Whisk slowly so the emulsion holds." |
| Bloom | Warm spices in fat or liquid to release their flavor | "Bloom the cumin in hot oil first." |
| Rest | Let cooked meat sit before cutting so juices settle | "Rest it ten minutes before you slice." |
| Carryover | Food keeps cooking from stored heat after leaving the heat source | "Carryover will bring it to medium-rare." |
| Al dente | Pasta cooked through but still slightly firm to the bite | "Pull it al dente, it finishes in the sauce." |
| Maillard reaction | The browning reaction between amino acids and sugars that makes savory flavor | "That's Maillard, that's the good stuff." |
| Caramelization | Sugar browning at high heat into nutty, sweet flavors | "Caramelize the onions low and slow." |
| Smoke point | The temperature at which a fat starts to smoke and break down | "Avocado oil has a high smoke point." |
| Kosher salt | Coarse, flaky cooking salt, easy to pinch | "Kosher salt in a bowl by the stove." |
| Finishing salt | Flaky salt sprinkled at the end for crunch | "A little flaky salt on top." |
| Dry brine | Salting meat ahead of time, uncovered, to season and dry the surface | "I dry-brine the chicken overnight." |
| Acid | A sour ingredient, like lemon or vinegar, that brightens flavor | "It needs acid." |
| Umami | The savory "fifth taste" found in foods like mushrooms and parmesan | "A little fish sauce adds umami." |
| Aromatics | Flavorful vegetables and herbs cooked at the start of a dish | "Start with the aromatics." |
| Mirepoix | The classic French base of onion, carrot and celery | "Mirepoix for the stock." |
| Soffritto | Italian aromatic base of slowly cooked onion, carrot and celery | "A patient soffritto makes the ragù." |
| Stock | A savory liquid simmered from bones or vegetables, unseasoned | "Homemade stock beats the carton." |
| Broth | A seasoned savory liquid, ready to sip | "Chicken broth for the sick day." |
| Mother sauce | One of five classical French base sauces that spawn many others | "Béchamel is a mother sauce." |
| Pan sauce | A quick sauce built in the pan after searing | "I made a pan sauce with the fond." |
| Slurry | Starch mixed with cold water, stirred in to thicken | "A cornstarch slurry thickens it fast." |
| Gluten | Stretchy protein network formed when flour meets water | "Don't overwork it, you'll build too much gluten." |
| Hydration | The amount of water compared to flour in a dough | "That's a high-hydration dough." |
| Proof | Let yeast dough rise before baking | "Let it proof until doubled." |
| Cast iron | Heavy, heat-holding pan that improves with seasoning | "I cook everything in cast iron." |
| Carbon steel | Light, high-heat pan similar to a wok, seasoned like cast iron | "I'm on a carbon steel kick." |
| Seasoning (pan) | Baked-on layers of oil that make a pan nonstick | "You have to keep the seasoning up." |
| Honing | Realigning a knife's edge with a steel, not removing metal | "Hone before every session." |
| Whetstone | A stone used to sharpen a knife by grinding a new edge | "I sharpen on a whetstone." |
| Claw grip | Curling the guiding hand's fingertips back while cutting | "Claw hand, always." |
| Dice | Cut into small, even cubes | "Dice the onion small." |
| Danger zone | 40 to 140 F, where bacteria multiply fastest (USDA) | "Don't leave it in the danger zone." |
| Cross-contamination | Bacteria spreading from raw food to other foods or surfaces | "Different boards for raw meat." |
| Internal temperature | Temperature at the food's center, checked with a thermometer | "Check the internal temp, not the color." |
| Instant-read thermometer | A thermometer that gives a temperature in seconds | "An instant-read is the best $20 you'll spend." |
| Rolling boil | Water bubbling vigorously across the whole surface | "Bring the water to a rolling boil." |
| Simmer | Gentle bubbling just below a boil | "Turn it down to a simmer." |
| Poach | Cook gently in liquid just below a simmer | "Poached eggs, barely a shiver." |
| Marinate | Soak food in a seasoned liquid before cooking | "Marinate it in the fridge overnight." |
| Cuts of meat | Sections of an animal, sorted by tenderness and use | "Tough cuts want a braise." |
| Collagen | Connective tissue in tough cuts that melts into gelatin when cooked low and slow | "Give the collagen time." |
| Reverse sear | Cook low first, then finish with a hot sear | "Reverse sear for a thick steak." |
| Wok hei | The smoky "breath of the wok" from very hot stir-frying | "That's wok hei." |
| Velveting | Coating meat in cornstarch or egg white for tender stir-fry | "Velvet the chicken first." |
| Dashi | Japanese stock of kombu and dried bonito | "Dashi is the base of miso soup." |
| Tadka | Spices sizzled in hot fat and poured over a dish (Indian) | "Finish the dal with a tadka." |
| Nixtamalization | Soaking corn in an alkaline solution to make masa | "Nixtamalized corn is the secret." |
| Brigade | The classical kitchen hierarchy of chef, sous chef, line cooks | "Kitchen brigades run like clockwork." |
| Line cook | A cook working a station during service | "She was a line cook for six years." |
| Behind! | Kitchen call warning someone you are walking behind them | "Behind!" |
| Heard | Kitchen reply meaning "I received your call" | "Heard, chef." |
| Family meal | The meal restaurant staff eat together before service | "Family meal is the best meal of the day." |
| 86 | Kitchen slang: the item is out of stock or removed | "We're 86 on the salmon." |

(66 rows. Concept ids for each are listed in CDS section 11's Appendix; term-to-concept mapping is done when the curriculum root is authored.)

---

## 4. Talk Track scenarios (8)

Each scenario: setting, her opening line, what it means, three replies (good, meh, cringe) with coach notes, and a full `talk-track` payload that validates against `talk-track.schema.json`. Voice: warm, playful, never about her; the coach rewards curiosity and honest gaps over bluffing.

### 4.1 "I made this from scratch" (`tt-scratch`)

- **Setting:** She texts a photo caption and a proud line after a big dinner.
- **Her line:** "Made the whole thing from scratch tonight. The sauce took three hours."
- **Meaning:** She's proud of a long-cooked dish and wants to be asked about it.
- **Replies:** Good: "Three hours! What was in it? What's the first thing you put in the pot?" (curious, invites her to share). Meh: "Nice, looks great." (kind but leaves her alone with her pride). Cringe: "Three hours? Couldn't you just buy it?" (dismissive).

```json
{
  "title": "I made this from scratch",
  "setting": "She just finished a big dinner and texted you.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Made the whole thing from scratch tonight. The sauce took three hours.",
      "replies": [
        { "id": "ask-what", "text": "Three hours! What went in it, and what did you start with?", "smoothDelta": 22, "theirResponse": "Onions, then tomato paste, and I let it go low and slow. I love that you asked.", "coachNote": "Curious and specific. She gets to tell her story." },
        { "id": "nice", "text": "Nice, looks great.", "smoothDelta": 3, "theirResponse": "Thanks! It was a lot of work.", "coachNote": "Sweet but closed. Ask one more question next time." },
        { "id": "buy-it", "text": "Three hours? Couldn't you just buy sauce?", "smoothDelta": -18, "theirResponse": "Well, it's not the same thing.", "coachNote": "That's a fumble. Never tell a cook her effort wasn't necessary." }
      ]
    },
    {
      "theirMessage": "I sweat the onions until sweet, then added tomato paste and let it darken a bit.",
      "replies": [
        { "id": "ask-darken", "text": "Why does the tomato paste have to darken?", "smoothDelta": 20, "theirResponse": "Browning it deepens the flavor. Cooked tomato paste tastes sweeter and richer. Cute question.", "coachNote": "A why-question shows you listened and want to understand." },
        { "id": "same", "text": "Sounds exactly like what I do.", "smoothDelta": -15, "theirResponse": "Oh, do you cook a lot?", "coachNote": "Don't claim what you don't do. Honesty is more attractive." },
        { "id": "taste", "text": "I would love to taste it sometime.", "smoothDelta": 12, "theirResponse": "I'll make you a bowl.", "coachNote": "Warm and honest, and it invites a next step." }
      ]
    }
  ],
  "closingNote": "She lit up when you asked about her process. In cooking, 'how did you make it?' beats 'looks good'."
}
```

### 4.2 "My sauce broke" (`tt-sauce-broke`)

- **Setting:** She's frustrated after a sauce split at a dinner.
- **Her line:** "My hollandaise broke right before brunch. I almost cried."
- **Meaning:** An emulsion separated; she's disappointed and wants empathy.
- **Replies:** Good: "Ugh, that stinks. Did you get it back or start over?" Meh: "It's just sauce, don't worry." Cringe: "You probably whisked too fast."

```json
{
  "title": "My sauce broke",
  "setting": "Texting after she nearly lost a brunch sauce.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "My hollandaise broke right before brunch. I almost cried.",
      "replies": [
        { "id": "empathy", "text": "Ugh, that's so frustrating. Did you get it back?", "smoothDelta": 22, "theirResponse": "I whisked a fresh yolk with a splash of water and rebuilt it. It worked!", "coachNote": "Empathy first, then curiosity. Good order." },
        { "id": "dont-worry", "text": "It's just sauce, don't worry about it.", "smoothDelta": -8, "theirResponse": "It's not just sauce to me.", "coachNote": "Minimizing feelings misses the moment. Lead with 'that sounds awful'." },
        { "id": "you-whisked", "text": "You probably whisked too fast, right?", "smoothDelta": -18, "theirResponse": "Actually, it was too hot. But thanks.", "coachNote": "Don't diagnose someone else's kitchen. Ask before you guess." }
      ]
    },
    {
      "theirMessage": "Turns out it was the heat. I keep forgetting hollandaise hates a hot pan.",
      "replies": [
        { "id": "ask-why", "text": "Why does hollandaise hate heat? I didn't know that.", "smoothDelta": 22, "theirResponse": "The yolks scramble and the butter can't stay blended. It's an emulsion, and heat breaks it.", "coachNote": "Admitting you don't know and asking why is a gift to a cook." },
        { "id": "bluff", "text": "Yeah, I always heard that.", "smoothDelta": -10, "theirResponse": "Oh? Where?", "coachNote": "A bluff invites a follow-up you can't answer. Just ask." },
        { "id": "brunch", "text": "Well, brunch survived. That's what counts.", "smoothDelta": 8, "theirResponse": "True. Thanks for cheering me up.", "coachNote": "Kind and supportive, though a question would have gone further." }
      ]
    }
  ],
  "closingNote": "Empathy first, curiosity second. She doesn't need a fix from you, just someone who cares about her sauce."
}
```

### 4.3 Her knife obsession (`tt-knife`)

- **Setting:** She's excited about a new knife.
- **Her line:** "I finally got a Japanese gyuto. It's insanely sharp."
- **Meaning:** A Japanese-style chef's knife (gyuto), thin and hard steel; she's excited about sharpness.
- **Replies:** Good: "What made you switch from your old one? Is it hard to sharpen?" Meh: "Cool, be careful." Cringe: "It's just a knife."

```json
{
  "title": "Her new knife",
  "setting": "She's just bought a Japanese chef's knife.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I finally got a Japanese gyuto. It's insanely sharp.",
      "replies": [
        { "id": "ask-switch", "text": "What made you switch from your old knife?", "smoothDelta": 22, "theirResponse": "It's thinner and holds an edge longer. I can slice tomatoes like paper.", "coachNote": "A 'what made you' question lets her explain her passion." },
        { "id": "careful", "text": "Cool. Be careful with it!", "smoothDelta": 4, "theirResponse": "Always. Thanks.", "coachNote": "Caring, but she didn't get to share what she loves." },
        { "id": "just-knife", "text": "It's just a knife, isn't it?", "smoothDelta": -18, "theirResponse": "Not to me, it isn't.", "coachNote": "To a cook, a knife is the tool she uses every day. Never dismiss it." }
      ]
    },
    {
      "theirMessage": "It's carbon steel so I have to dry it right away or it rusts a little.",
      "replies": [
        { "id": "care", "text": "So it needs more care than a regular knife?", "smoothDelta": 18, "theirResponse": "A bit. Wipe it and dry it, never the dishwasher. That's the trade.", "coachNote": "Good follow-up that shows you're listening." },
        { "id": "dishwasher", "text": "Can't you just put it in the dishwasher?", "smoothDelta": -14, "theirResponse": "Definitely not. That would ruin the edge.", "coachNote": "Fine to ask, but the tone reads as if you're missing the point." },
        { "id": "learn", "text": "Teach me how to hold it properly sometime?", "smoothDelta": 24, "theirResponse": "I'd love to. I'll show you the claw grip.", "coachNote": "Honest, warm and gives her something to teach." }
      ]
    }
  ],
  "closingNote": "People who love their tools love being asked about them. Ask what they like, not whether it's necessary."
}
```

### 4.4 "Let's cook together" (`tt-cook-together`)

- **Setting:** She invites the learner to cook dinner together.
- **Her line:** "Come over Saturday and cook with me? I'll make the pasta."
- **Meaning:** A warm invitation; she leads, you help.
- **Replies:** Good: "I'd love to. I'm not a great cook, but I can chop. Put me to work." Meh: "Sure, what time?" Cringe: "Sure, I cook all the time, I'll take over."

```json
{
  "title": "Let's cook together",
  "setting": "She's invited you over to cook on Saturday.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Come over Saturday and cook with me? I'm making handmade pasta.",
      "replies": [
        { "id": "honest", "text": "I'd love to! I'm not much of a cook, but I can chop. Put me to work?", "smoothDelta": 24, "theirResponse": "Perfect, you're on onions. I'll teach you the claw grip.", "coachNote": "Honest about your level and eager to help. That's what she wants." },
        { "id": "sure", "text": "Sure, what time?", "smoothDelta": 5, "theirResponse": "Around five. Bring nothing but yourself.", "coachNote": "Friendly but flat. A little enthusiasm goes a long way." },
        { "id": "bluff", "text": "Sure, I cook all the time. I'll handle the sauce.", "smoothDelta": -18, "theirResponse": "Oh great. I was planning on making it myself.", "coachNote": "A bluff that could cost you when she hands you the whisk." }
      ]
    },
    {
      "theirMessage": "You can be my sous chef. Do you know what that means?",
      "replies": [
        { "id": "guess", "text": "Kind of like the assistant, right? Second in command in the kitchen?", "smoothDelta": 20, "theirResponse": "Exactly. You'll do great.", "coachNote": "A modest guess with the right idea. Smooth." },
        { "id": "no-idea", "text": "No idea, but I'm in.", "smoothDelta": 12, "theirResponse": "It just means my helper. You'll be fine.", "coachNote": "Charming and honest. Try a guess next time." },
        { "id": "chef", "text": "Yes, chef.", "smoothDelta": 14, "theirResponse": "Ha. Careful, I might get used to that.", "coachNote": "A playful nod to kitchen culture. It works when it's clearly a joke." }
      ]
    }
  ],
  "closingNote": "The best kitchen partner is the one who admits what they don't know and is eager to learn."
}
```

### 4.5 Restaurant or home? (`tt-restaurant-home`)

- **Setting:** She's debating restaurants against home cooking.
- **Her line:** "Honestly? I'd rather cook at home than go to a restaurant."
- **Meaning:** She loves control, cost and the process of cooking.
- **Replies:** Good: "What do you like more about home cooking?" Meh: "Fair, restaurants are expensive." Cringe: "But restaurants are better cooks than you."

```json
{
  "title": "Restaurant or home?",
  "setting": "A casual chat about where to eat.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Honestly? I'd rather cook at home than go to a restaurant.",
      "replies": [
        { "id": "ask-why", "text": "What do you like more about cooking at home?", "smoothDelta": 22, "theirResponse": "I control the salt, the heat, everything. Plus I get to make it exactly how I like.", "coachNote": "An open question about her values, not a debate." },
        { "id": "expensive", "text": "Fair. Restaurants are pricey.", "smoothDelta": 5, "theirResponse": "True, but that's not really it for me.", "coachNote": "Practical, but you missed her real reason. Ask why." },
        { "id": "pros", "text": "But restaurant chefs are way better than you.", "smoothDelta": -20, "theirResponse": "Wow. Okay.", "coachNote": "Ouch. Never rank her against the pros." }
      ]
    },
    {
      "theirMessage": "Restaurants have their place, but nothing beats a slow Sunday braise.",
      "replies": [
        { "id": "braise", "text": "What's your favorite thing to braise?", "smoothDelta": 22, "theirResponse": "Short ribs, hands down. Three hours and the whole apartment smells amazing.", "coachNote": "You picked up her word and asked about it. Nicely done." },
        { "id": "both", "text": "Both sound great. Maybe I'll cook one for you.", "smoothDelta": 14, "theirResponse": "I'd take you up on that.", "coachNote": "Sweet offer, but be ready to follow through." },
        { "id": "fake", "text": "Oh, I braise all the time.", "smoothDelta": -16, "theirResponse": "Really? What do you braise?", "coachNote": "Claiming a skill you don't have gets awkward fast." }
      ]
    }
  ],
  "closingNote": "Cooks love talking about why they cook. Ask what she loves, not what's better."
}
```

### 4.6 Her recipe disaster (`tt-disaster`)

- **Setting:** She's laughing about a cooking mistake.
- **Her line:** "I mistook tablespoon for teaspoon of cayenne. Everyone cried."
- **Meaning:** A funny story; she wants you to laugh with her.
- **Replies:** Good: "Oh no! Did anyone survive? What did you do to fix it?" Meh: "Ha, that's too bad." Cringe: "Rookie mistake."

```json
{
  "title": "Her recipe disaster",
  "setting": "She's telling you about a cooking mishap.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I mistook a tablespoon for a teaspoon of cayenne. Everyone was crying at dinner.",
      "replies": [
        { "id": "laugh", "text": "Oh no! Did anything survive? Could you fix it?", "smoothDelta": 22, "theirResponse": "I added yogurt and a ton of rice. We ate it. Barely.", "coachNote": "You laughed with her and asked how she'd fix it." },
        { "id": "too-bad", "text": "Ha, that's too bad.", "smoothDelta": 3, "theirResponse": "Yeah, it was a night.", "coachNote": "It's a start, but ask what she did next." },
        { "id": "rookie", "text": "Rookie mistake, honestly.", "smoothDelta": -20, "theirResponse": "Thanks a lot.", "coachNote": "Never mock a cook's mistakes. Everyone has one." }
      ]
    },
    {
      "theirMessage": "Lesson learned: read the recipe twice. Mise en place matters.",
      "replies": [
        { "id": "mise", "text": "Is that what mise en place is, getting everything ready first?", "smoothDelta": 20, "theirResponse": "Yes! Measured and lined up before I start. It would have caught it.", "coachNote": "You connected the term to her story. Great learning moment." },
        { "id": "laughing", "text": "I'm going to stick to takeout, then.", "smoothDelta": -6, "theirResponse": "Ha. Suit yourself.", "coachNote": "Funny, but it closes the door. Show you want to learn." },
        { "id": "join", "text": "Next time I'll measure, you cook.", "smoothDelta": 16, "theirResponse": "Deal. Team mise.", "coachNote": "Good teamwork. A joke that keeps the door open." }
      ]
    }
  ],
  "closingNote": "Laugh with her, not at her. Every cook has a cayenne story."
}
```

### 4.7 Watching a cooking show together (`tt-show`)

- **Setting:** She wants to watch a cooking competition.
- **Her line:** "Want to watch the Top Chef finale with me? No spoilers!"
- **Meaning:** A chance to bond over a show she loves; the rule is no spoilers.
- **Replies:** Good: "I'd love to. Who are you rooting for, and why?" Meh: "Sure, I guess." Cringe: "Reality TV is fake anyway."

```json
{
  "title": "Watching a cooking show",
  "setting": "She's inviting you to watch a cooking finale.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Want to watch the Top Chef finale with me? No spoilers!",
      "replies": [
        { "id": "who", "text": "I'd love to! Who are you rooting for, and why?", "smoothDelta": 22, "theirResponse": "The contestant with the perfect knife skills. She never rushes a plate.", "coachNote": "Asks about her opinion and her reasoning." },
        { "id": "sure", "text": "Sure, I guess.", "smoothDelta": -5, "theirResponse": "You don't have to if you don't want to.", "coachNote": "Lukewarm reads as uninterested. Add some genuine interest." },
        { "id": "fake", "text": "Reality TV is scripted anyway.", "smoothDelta": -16, "theirResponse": "Not the cooking, though.", "coachNote": "You may have a point, but she didn't ask. Lead with curiosity." }
      ]
    },
    {
      "theirMessage": "The judges love a dish with balance. Acid, salt, fat, heat.",
      "replies": [
        { "id": "salt-fat", "text": "Is that the salt, fat, acid, heat idea? I'm learning that.", "smoothDelta": 22, "theirResponse": "Yes! You've been paying attention.", "coachNote": "You connected what you're learning to her interest. It shows in the details." },
        { "id": "ask", "text": "What does 'balance' mean for a judge?", "smoothDelta": 16, "theirResponse": "Nothing too salty or too rich. Every bite makes sense.", "coachNote": "A good honest question." },
        { "id": "spoiler", "text": "Did the finalist with the seafood win?", "smoothDelta": -20, "theirResponse": "Hey! I said no spoilers.", "coachNote": "Don't spoil it. She told you the one rule." }
      ]
    }
  ],
  "closingNote": "She's inviting you into something she loves. Your job is curiosity and respecting the no-spoiler rule."
}
```

### 4.8 The steak temperature debate (`tt-steak-debate`)

- **Setting:** She has strong opinions about steak doneness.
- **Her line:** "I'll only eat steak medium-rare. Anything more is a crime."
- **Meaning:** Doneness is personal and passionate; do not argue safety with her, and do not pretend.
- **Replies:** Good: "What do you like about medium-rare? How do you know when it's ready?" Meh: "I like mine well done." Cringe: "That's undercooked, it's not safe."

```json
{
  "title": "The steak debate",
  "setting": "She's talking about how she likes her steak.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I'll only eat steak medium-rare. Anything more is a crime.",
      "replies": [
        { "id": "ask-why", "text": "What do you love about medium-rare? And how do you know when it's ready?", "smoothDelta": 22, "theirResponse": "It's juicy with a warm pink center. I use a thermometer and pull it a bit early to rest.", "coachNote": "Curious, not confrontational. She explains her method." },
        { "id": "well-done", "text": "I like mine well done, honestly.", "smoothDelta": -6, "theirResponse": "Well, to each their own.", "coachNote": "Honest, but delivered as a counter-argument it ends the conversation." },
        { "id": "unsafe", "text": "That's undercooked. It isn't safe.", "smoothDelta": -18, "theirResponse": "I know what I'm doing.", "coachNote": "Lecturing a cook in her own kitchen rarely goes well. Ask instead." }
      ]
    },
    {
      "theirMessage": "I always let it rest so the juices settle. Ten minutes at least.",
      "replies": [
        { "id": "rest", "text": "Why does resting matter so much?", "smoothDelta": 22, "theirResponse": "The juices redistribute instead of spilling onto the board. It makes a huge difference.", "coachNote": "A why-question that respects her skill." },
        { "id": "im-hungry", "text": "Ten minutes? I'd be starving.", "smoothDelta": -3, "theirResponse": "Patience, it's worth it.", "coachNote": "Cute, but a question would have been better." },
        { "id": "cook-for-me", "text": "Will you make me one sometime?", "smoothDelta": 16, "theirResponse": "Absolutely. I'll do it just right.", "coachNote": "A warm ask that lets her show off." }
      ]
    }
  ],
  "closingNote": "Preferences are personal. Ask about her method and her reasons, and leave the debate for another day."
}
```

Safety note for this scenario: Swoon'd keeps USDA's 145 F minimum (with a 3-minute rest for whole cuts) as the safety number in lessons. A cook's informed preference for lower doneness is her decision. The coach never scripts the learner to argue temperature with her, and never suggests serving lower doneness to children, older adults, pregnant people or anyone with a weakened immune system.

## 5. Talk Track roster at launch (20)

Written here: the eight above. Planned to reach 20 (each unit-end track is authored with its unit): `tt-scratch`, `tt-sauce-broke`, `tt-knife`, `tt-cook-together`, `tt-restaurant-home`, `tt-disaster`, `tt-show`, `tt-steak-debate`, `tt-salt-brand` (Diamond Crystal vs Morton), `tt-pan-wars`, `tt-farmers-market`, `tt-hosting`, `tt-family-recipe`, `tt-new-cuisine`, `tt-bake-fail`, `tt-bbq-weekend`, `tt-leftovers` (safety without nagging), `tt-allergy-dinner`, `tt-cookbook-gift`, `tt-holiday-cook`.

## 6. Asset needs (all `original-swoond`)

- Procedural diagram ids: `knife-anatomy`, `chicken-breast-thermometer`, `beef-primal-chart`, `stove-zones`, `oven-racks`, `grill-zones`.
- Illustrations: cuts (julienne, brunoise, chiffonade, batonnet, dice sizes), cookware silhouettes, browning ladder, dried chiles, knife types.
- Audio (synthesized or in-house): `sizzle-hot-pan`, `simmer-gentle`, `wok-roar`, oil-ready crackle, rolling boil.
- No third-party photographs; brands as text only.

## 7. Voice and safety notes

- Warm, a little flirty, never condescending, never about her cooking or her family recipes. Jokes target the learner's ignorance ("I can boil pasta; that's the whole résumé").
- Every safety item states the reference (USDA FSIS for home cooks) and never times the learner. Steak doneness is framed as preference versus safety minimum, with no coaching to argue.
- Never encourage faking skill; `talk-track` replies that bluff are penalized and explained.
- Recipes and cookbook text are never reproduced; works are named as facts, techniques are explained in Swoon'd's words.
