# Native Exercise Plan: Coffee (`coffee`)

Tier B plan for `docs/courses/coffee/`. **There are no Tier A sims** (`sims/` does not exist; see CDS sections 5 and 12). All 13 native exercise types are used. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with ajv when this file was written). Conventions: prompts <= 12 words; every answer explained; asset `license` ids are `original-swoond`; diagram ids are procedural diagrams drawn natively; no health claims; hot-water and steam safety items carry a `safetyNote` or safety explanation.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite. Origins, processes, roast levels, drinks, certifications. Distractors are the misconceptions from CDS section 2. | ~210 |
| `binary-call` | Sour or bitter, true or myth: dark is stronger, crema means quality, honey process has honey, moka pot safety. Scenes are `none`. | ~55 |
| `term-match` | Introduce 3 to 6 related terms: processing methods, drinks, varieties, gear, certifications. | ~35 |
| `sequence-order` | Processes with a `why` per step: cherry to cup, pour-over, puck prep, steaming milk, cupping, cold brew. | ~40 |
| `visual-id` | Grind sizes, roast levels, drink builds, machine parts, filter shapes. Original vector art only. | ~45 |
| `decision-scenario` | The judgment engine: "my espresso is sour, what now?", the pour-over drained too fast, the press is silty, which gear first. Best / acceptable / poor with an `expertNote`; `safetyNote` on hot-water, steam and storage items. | ~120 |
| `talk-track` | 18 talk tracks at launch; 9 are written in full in section 4. Smooth meter; replies reward curiosity and honesty. | 18 |
| `timing-tap` | Only 1D feel, always slow-mode friendly, never speed pressure or safety: stop the shot at the right yield, end the bloom. | ~8 |
| `say-this` | Decode what she just said; every item has a `noFakeExpertNote` and honest follow-ups. | ~70 |
| `fill-the-gap` | Vocabulary and rules in context; quick review card. | ~30 |
| `listening-id` | Steam stretching vs texturing, a shot pouring, rolling boil, grinder pitch. Original or synthesized audio, Skip always available. | ~14 |
| `estimate-slider` | Ratios, temperatures, brew times, shot yields, milk temperature. Safety numbers use tight tolerances. | ~55 |
| `hotspot-tap` | Static diagrams: coffee belt, machine parts, puck cross-section, V60 cone, flavor wheel, roast curve. Procedural diagrams. | ~35 |

Estimated total: about 700 native items across 120 lessons and the review loop (5 to 6 per lesson including review pools). Cross-type rules: each lesson ends with one item that carries a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`; safety review is never timed.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

**Sample 1** (lesson `cb-01`)

```json
{
  "prompt": "What is a coffee bean, botanically?",
  "options": [
    { "id": "a", "text": "The seed of a fruit called the coffee cherry" },
    { "id": "b", "text": "A legume, like a soybean" },
    { "id": "c", "text": "The root of the coffee shrub" },
    { "id": "d", "text": "A nut that grows in a husk" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Coffee grows as a small red fruit, the cherry. Inside are usually two seeds. We call them beans because they look like beans, but they are seeds.",
    "incorrect": "It is a seed. The coffee shrub produces cherries, and the seeds inside are what get processed, roasted and brewed. That fruit matters later, because processing is all about what happens to it.",
    "sayThisLine": "Wait, so coffee is a fruit seed?"
  }
}
```

**Sample 2** (lesson `ro-04`)

```json
{
  "prompt": "What does a darker roast mainly change?",
  "options": [
    { "id": "a", "text": "The flavor, toward roasty and bittersweet" },
    { "id": "b", "text": "It makes the coffee much stronger in caffeine" },
    { "id": "c", "text": "It makes the coffee acidic and healthy" },
    { "id": "d", "text": "It changes the species of the bean" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Roast level is about flavor. Darker roasts taste more roasty, smoky and bittersweet, with less of the origin's brightness. It is not a strength setting.",
    "incorrect": "Roast level changes flavor, not species and not strength. Dark does not mean more caffeine in any useful way. It means a different taste.",
    "sayThisLine": "Dark isn't stronger, it's just a different flavor."
  }
}
```

**Sample 3** (lesson `pr-04`)

```json
{
  "prompt": "What is 'honey' in honey-processed coffee?",
  "options": [
    { "id": "a", "text": "The sticky fruit mucilage left on the seed while drying" },
    { "id": "b", "text": "Real honey brushed on the beans" },
    { "id": "c", "text": "A sweetener added after roasting" },
    { "id": "d", "text": "Coffee grown near beehives" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "After the skin is removed, some sticky mucilage stays on the seed while it dries. It feels like honey, which is where the name comes from. More mucilage left usually means a fruitier, sweeter cup.",
    "incorrect": "No honey is added. The name comes from the sticky mucilage layer, which feels like honey. How much is left on the seed shifts the flavor between washed and natural.",
    "sayThisLine": "Honey process has no honey. It's the sticky fruit layer."
  }
}
```

**Sample 4** (lesson `ta-02`)

```json
{
  "prompt": "In tasting, what does 'bright acidity' describe?",
  "options": [
    { "id": "a", "text": "A lively, fruity tang like a crisp apple" },
    { "id": "b", "text": "A sour, sharp, unpleasant cup" },
    { "id": "c", "text": "A very hot cup" },
    { "id": "d", "text": "A cup with lots of crema" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Acidity in coffee talk is a pleasant liveliness, the way a crisp apple or citrus feels. It is praised in tasting. Sour, in contrast, is a flaw that usually signals under-extraction.",
    "incorrect": "Acidity is a positive quality: liveliness and fruit. A harsh, sharp, hollow cup is sour, which usually means under-extraction. Learning to tell them apart is a big step.",
    "sayThisLine": "I like the acidity. It tastes bright, not sour."
  }
}
```

### 2.2 `binary-call`

**Sample 1** (lesson `ex-01`)

```json
{
  "prompt": "Thin, sharp, sour, slightly salty cup. Under or over?",
  "scene": { "kind": "none", "alt": "A cup of brewed coffee next to a scale and a kettle on a counter." },
  "choices": [
    { "id": "under", "label": "Under-extracted" },
    { "id": "over", "label": "Over-extracted" }
  ],
  "correctChoiceId": "under",
  "explanation": {
    "correct": "Sour, thin and salty point to under-extraction: too little was dissolved. The sweet middle never arrived. Grind finer, brew hotter or brew longer to fix it.",
    "incorrect": "That profile is under-extracted. Over-extracted coffee is bitter, dry and astringent. Sour and hollow means the water did not pull enough out of the grounds.",
    "sayThisLine": "It's sour, so I think it's under-extracted."
  },
  "ruleTag": "Sour means under"
}
```

**Sample 2** (lesson `ro-04`)

```json
{
  "prompt": "Oily, shiny beans mean the coffee is fresh. Fact or myth?",
  "scene": { "kind": "none", "alt": "A bag of very dark roasted coffee beans with a visible oily sheen." },
  "choices": [
    { "id": "fact", "label": "Fact" },
    { "id": "myth", "label": "Myth" }
  ],
  "correctChoiceId": "myth",
  "explanation": {
    "correct": "Myth. Oil on the surface usually shows a darker roast, where oils migrate outward. It is not a freshness guarantee. The roast date tells you about freshness.",
    "incorrect": "It is a myth. Shine comes mostly from roast level and time, and very dark roasts get oily quickly. Check the roast date instead.",
    "sayThisLine": "Oily just means dark. What's the roast date?"
  },
  "ruleTag": "Check the roast date"
}
```

**Sample 3** (lesson `es-04`)

```json
{
  "prompt": "Thick crema proves an espresso shot is excellent. True or false?",
  "scene": { "kind": "none", "alt": "An espresso shot in a glass showing a layer of golden-brown crema on top." },
  "choices": [
    { "id": "true", "label": "True" },
    { "id": "false", "label": "False" }
  ],
  "correctChoiceId": "false",
  "explanation": {
    "correct": "False. Crema is gas and oils. It is affected by freshness, roast, variety and machine, and a great shot can have modest crema. Taste decides, not foam.",
    "incorrect": "It is false. Very fresh coffee can give a lot of crema even when the shot tastes bad. Taste the shot, and treat crema as one clue.",
    "sayThisLine": "Crema's a clue, not a verdict. How does it taste?"
  },
  "ruleTag": "Crema is not quality"
}
```

**Sample 4** (lesson `me-06`)

```json
{
  "prompt": "Moka pot: block the safety valve to build more pressure?",
  "scene": { "kind": "none", "alt": "A stovetop moka pot with its base, funnel basket and upper chamber." },
  "choices": [
    { "id": "block", "label": "Block the valve" },
    { "id": "never", "label": "Never block it" }
  ],
  "correctChoiceId": "never",
  "explanation": {
    "correct": "Never block the safety valve. It lets pressure escape if something clogs. Fill water only to the valve, use the right grind and heat gently.",
    "incorrect": "The valve is a safety feature, so never block or modify it. Extra pressure does not improve the coffee and can cause a dangerous burst. Follow the maker's instructions.",
    "sayThisLine": "I'd never block the valve. It's there for safety."
  },
  "ruleTag": "Respect the valve"
}
```

### 2.3 `term-match`

**Sample 1** (lesson `pr-06`)

```json
{
  "prompt": "Match the process to what happens.",
  "pairs": [
    { "id": "washed", "term": "Washed", "definition": "Fruit removed before drying; clean, bright cup" },
    { "id": "natural", "term": "Natural", "definition": "Dried inside the whole cherry; fruity, jammy cup" },
    { "id": "honey", "term": "Honey", "definition": "Some sticky fruit left on the seed while drying" },
    { "id": "anaerobic", "term": "Anaerobic", "definition": "Fermented in a sealed, oxygen-free tank" }
  ],
  "distractorDefinitions": ["Roasted twice for extra strength"],
  "explanation": {
    "summary": "Processing is what is done to the cherry between the tree and the roaster. Washed removes the fruit early; natural keeps it on; honey keeps some; anaerobic adds a controlled fermentation.",
    "sayThisLine": "Is this one washed or natural?"
  }
}
```

**Sample 2** (lesson `cm-01`)

```json
{
  "prompt": "Match the espresso order to its build.",
  "pairs": [
    { "id": "espresso", "term": "Espresso", "definition": "A single short shot, about 1 to 2 times the dose in water" },
    { "id": "doppio", "term": "Doppio", "definition": "A double shot of espresso" },
    { "id": "ristretto", "term": "Ristretto", "definition": "A shorter, more concentrated shot" },
    { "id": "lungo", "term": "Lungo", "definition": "A longer shot with more water through the puck" }
  ],
  "explanation": {
    "summary": "These names are about yield and quantity, not bean type. Ristretto is shorter, lungo is longer, and a doppio is simply two shots.",
    "sayThisLine": "I'll have a doppio, please."
  }
}
```

**Sample 3** (lesson `gd-02`)

```json
{
  "prompt": "Match the grinder term to its meaning.",
  "pairs": [
    { "id": "burr", "term": "Burr grinder", "definition": "Crushes beans between two rings for an even grind" },
    { "id": "blade", "term": "Blade grinder", "definition": "Chops beans like a blender, giving uneven pieces" },
    { "id": "conical", "term": "Conical burrs", "definition": "A cone-shaped burr inside a ring" },
    { "id": "flat", "term": "Flat burrs", "definition": "Two parallel rings; often prized for clarity" }
  ],
  "explanation": {
    "summary": "Evenness is the point. Burrs crush, blades chop. Flat and conical are geometries people debate, and both can be excellent.",
    "sayThisLine": "Flat or conical? I'm curious what you chose."
  }
}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `cb-01`)

```json
{
  "prompt": "Put coffee's journey in order, farm to cup.",
  "items": [
    { "id": "pick", "text": "Ripe cherries are picked", "why": "Everything starts with the fruit on the shrub." },
    { "id": "process", "text": "The cherry is processed and dried", "why": "Processing turns the fruit into dry seeds called green coffee." },
    { "id": "export", "text": "Green coffee is sorted and shipped", "why": "Green coffee keeps well, so it travels before roasting." },
    { "id": "roast", "text": "A roaster roasts it", "why": "Roasting creates the flavor and aroma." },
    { "id": "grind", "text": "It is ground", "why": "Grinding exposes the coffee so water can extract it." },
    { "id": "brew", "text": "It is brewed", "why": "Hot water dissolves flavors into your cup." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Coffee is an agricultural product first. Each step changes it, and fresh roasting plus fresh grinding are the last two chances to protect flavor.",
    "incorrect": "Think fruit, then dry seed, then travel, then roast, then grind, then brew. Roasting and grinding come late because green coffee keeps well and ground coffee stales fast.",
    "sayThisLine": "It's a fruit seed before it's a drink."
  }
}
```

**Sample 2** (lesson `me-02`)

```json
{
  "prompt": "Order a basic pour-over.",
  "items": [
    { "id": "rinse", "text": "Rinse the filter and warm the server", "why": "Removes paper taste and keeps the brew warm." },
    { "id": "dose", "text": "Weigh and add the ground coffee", "why": "A weighed dose makes the recipe repeatable." },
    { "id": "bloom", "text": "Pour a small bloom and wait", "why": "Wetting the grounds releases trapped gas so extraction is even." },
    { "id": "pour", "text": "Pour the rest of the water in stages", "why": "Steady pours keep the bed evenly wet." },
    { "id": "drain", "text": "Let it drain and discard the grounds", "why": "Total brew time tells you a lot about grind size." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Rinse, weigh, bloom, pour, drain. Each step makes the brew repeatable, which lets you change one variable at a time.",
    "incorrect": "Start with the filter rinse and the weighed dose, then bloom before the main pour. Bloom goes early so gas escapes and water can reach all the grounds.",
    "sayThisLine": "Do you bloom for thirty seconds or longer?"
  }
}
```

**Sample 3** (lesson `es-06`)

```json
{
  "prompt": "Order the steps for steaming milk safely.",
  "items": [
    { "id": "purge-first", "text": "Point the wand at the drip tray and purge", "why": "Clears water from the wand and keeps steam off people." },
    { "id": "submerge", "text": "Put the tip just under the milk surface", "why": "Lets steam and air in to stretch the milk." },
    { "id": "stretch", "text": "Add air briefly, then lower the tip to texture", "why": "Stretching adds volume; texturing makes it silky microfoam." },
    { "id": "stop", "text": "Stop when the pitcher is hot but touchable", "why": "Overheating ruins texture and can scald." },
    { "id": "wipe-purge", "text": "Wipe the wand and purge again", "why": "Stops milk from baking onto the wand and clearing it for next use." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Purge, submerge, stretch then texture, stop early, wipe and purge. The safety steps bookend the technique.",
    "incorrect": "Safety steps go first and last: purge before you start, wipe and purge when you finish. In between, stretch briefly, then texture, and stop while the pitcher is still touchable.",
    "sayThisLine": "I always purge the wand first."
  }
}
```

### 2.5 `visual-id`

**Sample 1** (lesson `bb-04`)

```json
{
  "prompt": "Which brewing method uses this grind size?",
  "image": {
    "asset": "coffee/img/grind-ladder-coarse.svg",
    "alt": "A pile of coarse coffee grounds, pieces roughly the size of coarse sea salt.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "press", "text": "French press", "explanation": "Coarse grounds steep for minutes; fine grounds would pass the mesh and over-extract." },
    { "id": "espresso", "text": "Espresso", "explanation": "Espresso needs a much finer grind to resist the pressurized water." },
    { "id": "turkish", "text": "Turkish coffee", "explanation": "Turkish is powder-fine, the finest of all." },
    { "id": "moka", "text": "Moka pot", "explanation": "Moka wants medium-fine, between espresso and drip." }
  ],
  "correctOptionId": "press",
  "explanation": {
    "correct": "Coarse, like sea salt, suits long immersion brews such as the French press and cold brew. Big pieces extract slowly, which matches the long steep.",
    "incorrect": "That is a coarse grind. Coarse coffee extracts slowly, so it pairs with long brews like French press and cold brew. Finer methods use much shorter contact."
  },
  "cues": ["Coarse sea-salt sized pieces", "Visible individual chunks", "Long steep methods"]
}
```

**Sample 2** (lesson `ro-02`)

```json
{
  "prompt": "Which roast level is this?",
  "image": {
    "asset": "coffee/img/roast-ladder-medium.svg",
    "alt": "A row of roasted coffee beans in an even medium brown with a dry surface and no shine.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "light", "text": "Light roast", "explanation": "Light roasts are pale, tan to light brown." },
    { "id": "medium", "text": "Medium roast", "explanation": "Medium roasts are even brown and dry on the surface." },
    { "id": "dark", "text": "Dark roast", "explanation": "Dark roasts are deep brown to near black, often shiny." }
  ],
  "correctOptionId": "medium",
  "explanation": {
    "correct": "An even mid-brown with a dry surface is a medium roast. You expect balance: sweetness, body and some acidity, with a little roasted character.",
    "incorrect": "Not quite. Light roasts look tan; dark roasts look near-black and often shiny. This mid-brown and dry bean is medium, where roast flavor and origin character share the stage."
  },
  "cues": ["Even mid-brown color", "Dry surface, no oil sheen", "Balanced sweetness and body"]
}
```

**Sample 3** (lesson `cm-02`)

```json
{
  "prompt": "Which drink is shown in this cross-section?",
  "image": {
    "asset": "coffee/img/drink-cortado.svg",
    "alt": "A small glass with espresso at the bottom and an equal amount of steamed milk above it, with a thin foam cap.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "cortado", "text": "Cortado", "explanation": "Espresso cut with about equal warm milk in a small glass." },
    { "id": "latte", "text": "Latte", "explanation": "A latte has much more milk in a taller glass." },
    { "id": "cappuccino", "text": "Cappuccino", "explanation": "A cappuccino has a thick foam cap and is larger." },
    { "id": "americano", "text": "Americano", "explanation": "An americano is espresso with hot water, no milk." }
  ],
  "correctOptionId": "cortado",
  "explanation": {
    "correct": "A small glass with espresso and about equal steamed milk is a cortado, from the Spanish for 'cut'. The milk softens the espresso without drowning it.",
    "incorrect": "That small equal-parts build is a cortado. Lattes are milk-heavy and cappuccinos carry a thicker foam cap. Sizes vary by café, so ask if unsure."
  },
  "cues": ["Small glass", "Roughly equal espresso and milk", "Thin foam"]
}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `ex-04`; the course's signature question)

```json
{
  "prompt": "My espresso is sour. What now?",
  "situation": {
    "narrative": "She pulls a shot of a new medium-roast bag and winces.",
    "facts": [
      { "label": "Dose in", "value": "18 g" },
      { "label": "Yield out", "value": "36 g" },
      { "label": "Time", "value": "17 seconds", "emphasis": "warning" },
      { "label": "Taste", "value": "Sharp, sour, thin" },
      { "label": "Grinder setting", "value": "Coarser than usual" }
    ]
  },
  "options": [
    {
      "id": "grind-finer",
      "label": "Grind finer and pull it again",
      "verdict": "best",
      "consequence": "The next shot runs slower, around 27 seconds, and the sourness softens into sweetness.",
      "considerations": ["A 17 second shot ran too fast", "Finer grind slows flow and raises extraction", "Change only one variable"]
    },
    {
      "id": "more-coffee",
      "label": "Add more coffee to the basket",
      "verdict": "acceptable",
      "consequence": "Resistance rises a little and the shot slows, but you changed the recipe, not the cause.",
      "considerations": ["More dose can slow a shot", "It also changes the ratio", "Grind is the cleaner first lever"]
    },
    {
      "id": "add-milk",
      "label": "Add milk to cover the sourness",
      "verdict": "poor",
      "consequence": "The drink is less sharp, but the shot is still under-extracted and the problem returns tomorrow.",
      "considerations": ["Masks the fault instead of fixing it", "You learn nothing about the shot"]
    },
    {
      "id": "coarser",
      "label": "Grind coarser to reduce the sourness",
      "verdict": "poor",
      "consequence": "The shot runs even faster, and the cup gets more sour, thinner and saltier.",
      "considerations": ["Coarser lowers extraction", "That is the opposite of the fix"]
    }
  ],
  "expertNote": "Sour plus a fast shot is the classic under-extraction signature. Baristas reach for the grinder first because it changes flow most cleanly, change one thing at a time, and taste after each.",
  "sayThisLine": "Sour and fast? I'd go finer first.",
  "safetyNote": "Keep hands clear of the group head and steam wand while dialing in; hot water and steam burn."
}
```

**Sample 2** (lesson `bb-09`)

```json
{
  "prompt": "The kettle just boiled. Pour now?",
  "situation": {
    "narrative": "She is brewing a pour-over with a light-roast coffee.",
    "facts": [
      { "label": "Water state", "value": "Just boiled, about 212 F", "emphasis": "warning" },
      { "label": "Target range", "value": "195 to 205 F" },
      { "label": "Roast", "value": "Light" },
      { "label": "Kettle", "value": "Stable, gooseneck" }
    ]
  },
  "options": [
    {
      "id": "wait",
      "label": "Let it rest a minute, then pour",
      "verdict": "best",
      "consequence": "Water drops to the target range and the cup tastes sweeter with less harshness.",
      "considerations": ["Boiling can scorch and over-extract", "Light roasts often like the hot end of the range", "Pour steadily away from your body"]
    },
    {
      "id": "pour-now",
      "label": "Pour it straight away",
      "verdict": "acceptable",
      "consequence": "The cup is fine but can taste a bit harsher, and the faster pour raises burn risk.",
      "considerations": ["Some light roasts tolerate very hot water", "Splashes are more dangerous at boiling"]
    },
    {
      "id": "cold-tap",
      "label": "Add cold water to cool it",
      "verdict": "poor",
      "consequence": "The water volume is wrong, the ratio drifts, and the cup tastes diluted.",
      "considerations": ["Ruins the ratio", "Rest the kettle instead"]
    }
  ],
  "expertNote": "Most specialty brewers aim for roughly 195 to 205 F. Lighter roasts often go hotter, darker roasts cooler. A minute off the boil is an easy way to land there.",
  "safetyNote": "Water at this temperature scalds. Keep the kettle stable, pour away from your body, and let the drink cool before sipping."
}
```

**Sample 3** (lesson `gd-01`)

```json
{
  "prompt": "Limited budget. Where does the money go first?",
  "situation": {
    "narrative": "A friend wants better coffee at home and has a small budget.",
    "facts": [
      { "label": "Current gear", "value": "Blade grinder, drip machine" },
      { "label": "Budget", "value": "Enough for one upgrade" },
      { "label": "Goal", "value": "A more consistent, sweeter cup" },
      { "label": "Coffee", "value": "Good fresh specialty beans" }
    ]
  },
  "options": [
    {
      "id": "burr",
      "label": "A decent burr grinder",
      "verdict": "best",
      "consequence": "The grind becomes even, the cup sweeter and cleaner, and every future brew improves.",
      "considerations": ["Grind uniformity affects extraction most", "Blade grinders make boulders and dust", "It helps every brew method"]
    },
    {
      "id": "machine",
      "label": "A pricier brewing machine",
      "verdict": "acceptable",
      "consequence": "Temperature control improves a little, but the uneven grind still limits the cup.",
      "considerations": ["Good machines help", "Grinder quality still caps the result"]
    },
    {
      "id": "gadget",
      "label": "A set of gadgets and a fancy mug",
      "verdict": "poor",
      "consequence": "The shelf looks great and the coffee tastes the same.",
      "considerations": ["Gadgets do not fix uneven grind"]
    }
  ],
  "expertNote": "Many enthusiasts say the grinder matters more than the brewer, and on a budget a good hand or entry-level burr grinder is often the best first upgrade. It is a debate, not a law."
}
```

### 2.7 `talk-track`

Full talk-track payloads are in section 4 (they are the same contract). Three of the nine are validated there as `talk-track` samples.

### 2.8 `timing-tap`

**Sample 1** (lesson `es-02`)

```json
{
  "prompt": "Stop the shot when the scale hits your yield.",
  "theme": { "label": "Stop the shot", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 45, "zoneEndPct": 65, "sweepSeconds": 6 },
    { "zoneStartPct": 50, "zoneEndPct": 62, "sweepSeconds": 5 },
    { "zoneStartPct": 52, "zoneEndPct": 60, "sweepSeconds": 5 }
  ],
  "explanation": {
    "correct": "Yield is part of the recipe. Stopping at the target, usually around twice the dose for a modern shot, keeps flavor balanced.",
    "incorrect": "Watch the scale, not the clock. Stopping early gives a stronger, sourer shot; running long dilutes it. This is a feel game, not a race."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `me-02`)

```json
{
  "prompt": "End the bloom at the right moment.",
  "theme": { "label": "Bloom", "resultUnit": "seconds" },
  "rounds": [
    { "zoneStartPct": 40, "zoneEndPct": 60, "sweepSeconds": 8 },
    { "zoneStartPct": 45, "zoneEndPct": 58, "sweepSeconds": 7 }
  ],
  "explanation": {
    "correct": "A bloom of about 30 to 45 seconds lets gas escape so water can reach every particle. Fresh coffee blooms more.",
    "incorrect": "Too short and gas still blocks the water; too long and the bed cools and dries. Aim for roughly half a minute and adjust by how much the bed puffs."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 3** (lesson `bb-06`)

```json
{
  "prompt": "Tap when the French press hits four minutes.",
  "theme": { "label": "Steep timer", "resultUnit": "seconds" },
  "rounds": [
    { "zoneStartPct": 55, "zoneEndPct": 75, "sweepSeconds": 10 },
    { "zoneStartPct": 58, "zoneEndPct": 72, "sweepSeconds": 9 }
  ],
  "explanation": {
    "correct": "About four minutes is a common starting point for a French press. Time and grind trade off, so taste and adjust.",
    "incorrect": "Steeping too short under-extracts; too long over-extracts. Four minutes is a starting point, not a law. Change the grind or time one at a time."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.9 `say-this`

**Sample 1** (lesson `talk-01`)

```json
{
  "statement": { "speaker": "Her", "text": "This is a washed Ethiopian, Guji. It tastes like blueberry tea." },
  "question": "What is she talking about?",
  "options": [
    { "id": "clean-fruity", "text": "A clean, fruity, floral coffee from southern Ethiopia", "isCorrect": true, "explanation": "Washed means the fruit was removed before drying, which gives clarity. Guji is a zone in Ethiopia known for fruity, floral cups." },
    { "id": "flavored", "text": "Coffee flavored with blueberry tea", "isCorrect": false, "explanation": "Tasting notes describe what she tastes, not what was added." },
    { "id": "hot-wash", "text": "Coffee washed with hot water before roasting", "isCorrect": false, "explanation": "Washed is a processing method done at the farm, not a rinse." },
    { "id": "blend", "text": "A dark blend from several countries", "isCorrect": false, "explanation": "Single-origin from a named zone is the opposite of a blend." }
  ],
  "translation": "She bought a clean-tasting coffee from the Guji area of Ethiopia and finds it fruity and floral, like blueberry tea.",
  "followUps": [
    { "line": "Is that floral thing the Ethiopian signature, or just this one?", "why": "Shows curiosity about origin versus the specific coffee." },
    { "line": "What would you have tasted if it were natural instead of washed?", "why": "Invites her to explain processing without you bluffing." }
  ],
  "noFakeExpertNote": "You don't need to taste blueberry. Ask what she tastes and listen."
}
```

**Sample 2** (lesson `talk-02`)

```json
{
  "statement": { "speaker": "Her", "text": "Ugh, my espresso is running sour. I'm going two clicks finer." },
  "question": "What is she talking about?",
  "options": [
    { "id": "under", "text": "Her shot is under-extracted, so she is tightening the grind", "isCorrect": true, "explanation": "Sour usually means too little extraction. Finer grind slows water and pulls more out." },
    { "id": "milk", "text": "She is adding more milk to fix the flavor", "isCorrect": false, "explanation": "Clicks refer to the grinder's adjustment steps." },
    { "id": "machine", "text": "Her machine is broken", "isCorrect": false, "explanation": "Dialing in is routine, not a repair." },
    { "id": "roast", "text": "She is choosing a darker roast", "isCorrect": false, "explanation": "Clicks are the grinder dial, not the roast." }
  ],
  "translation": "Her espresso tastes sharp and thin, so she is making the grind finer to slow the shot and sweeten it.",
  "followUps": [
    { "line": "Does it taste better after two clicks?", "why": "Checks the result, not the jargon." },
    { "line": "How long was the shot running?", "why": "A genuine question about her numbers." }
  ],
  "noFakeExpertNote": "If you don't know espresso, say so, and ask her to show you what she's adjusting."
}
```

**Sample 3** (lesson `talk-03`)

```json
{
  "statement": { "speaker": "Her", "text": "I upgraded to a flat-burr grinder. The clarity is unreal." },
  "question": "What is she talking about?",
  "options": [
    { "id": "grinder", "text": "A new grinder she says gives cleaner, clearer flavors", "isCorrect": true, "explanation": "Flat burrs are often praised for clarity and uniformity." },
    { "id": "machine", "text": "A new espresso machine", "isCorrect": false, "explanation": "Burrs are grinder parts." },
    { "id": "scale", "text": "A new scale for weighing coffee", "isCorrect": false, "explanation": "A scale has no burrs." },
    { "id": "filter", "text": "A paper filter that cleans the water", "isCorrect": false, "explanation": "Filters don't have burrs either." }
  ],
  "translation": "She bought a better grinder with flat burrs and thinks her coffee now tastes cleaner and more distinct.",
  "followUps": [
    { "line": "What changed in the cup?", "why": "Invites her to describe the difference in her own words." },
    { "line": "Was it a big jump from the old one?", "why": "Shows you care about her upgrade without pretending to know gear." }
  ],
  "noFakeExpertNote": "Flat versus conical is a real debate. You can say you don't know it yet."
}
```

**Sample 4** (lesson `cm-02`)

```json
{
  "statement": { "speaker": "Her", "text": "I'll have a cortado. And honestly, a flat white if they're out." },
  "question": "What is she talking about?",
  "options": [
    { "id": "small-milk", "text": "Small espresso drinks with a little milk", "isCorrect": true, "explanation": "A cortado is espresso with about equal milk; a flat white is similar with a bit more milk and silky texture." },
    { "id": "big-latte", "text": "Two giant lattes", "isCorrect": false, "explanation": "Both drinks are small and espresso-forward." },
    { "id": "cold", "text": "Two iced coffees", "isCorrect": false, "explanation": "These are typically hot." },
    { "id": "tea", "text": "Tea with milk", "isCorrect": false, "explanation": "Both are espresso drinks." }
  ],
  "translation": "She likes small, espresso-forward milk drinks and is fine with either a cortado or a flat white.",
  "followUps": [
    { "line": "Which do you like better, cortado or flat white?", "why": "A simple question she can answer with a story." }
  ],
  "noFakeExpertNote": "Cafés differ in how they build these. You can ask how this café makes it."
}
```

### 2.10 `fill-the-gap`

**Sample 1** (lesson `bb-03`)

```json
{
  "prompt": "Complete the brew ratio.",
  "template": "A 1:{{water}} ratio means one gram of coffee to {{water}} grams of {{liquid}}.",
  "gaps": [
    { "id": "water", "options": ["16", "2", "60", "100"], "correct": "16" },
    { "id": "liquid", "options": ["water", "milk", "oil"], "correct": "water" }
  ],
  "explanation": {
    "correct": "A ratio compares weights. A 1:16 pour-over uses 16 grams of water per gram of coffee. Weighing both makes a recipe repeatable.",
    "incorrect": "A ratio is coffee weight to water weight. Pour-over often sits near 1:16, espresso near 1:2. Weigh, don't scoop.",
    "sayThisLine": "What ratio are you using?"
  }
}
```

**Sample 2** (lesson `ex-01`)

```json
{
  "prompt": "Name the flaw.",
  "template": "A {{taste}} cup usually means the coffee was {{cause}}.",
  "gaps": [
    { "id": "taste", "options": ["sour", "bitter", "sweet"], "correct": "sour" },
    { "id": "cause", "options": ["under-extracted", "over-extracted", "too fresh"], "correct": "under-extracted" }
  ],
  "explanation": {
    "correct": "Sour usually signals under-extraction: not enough dissolved. Bitter and dry points to over-extraction.",
    "incorrect": "Sour means under-extracted; bitter means over-extracted. Roast level and robusta can add bitterness too, so taste in context.",
    "sayThisLine": "It tastes sour, so I think it's under-extracted."
  }
}
```

**Sample 3** (lesson `ro-06`)

```json
{
  "prompt": "Check the freshness clue.",
  "template": "Look for the {{clue}} on the bag, not a {{wrong}} date.",
  "gaps": [
    { "id": "clue", "options": ["roast", "best-by", "packing"], "correct": "roast" },
    { "id": "wrong", "options": ["best-by", "roast", "harvest"], "correct": "best-by" }
  ],
  "explanation": {
    "correct": "A roast date tells you when flavor chemistry started. Many enthusiasts like filter coffee after a few days of rest and use it within a few weeks.",
    "incorrect": "The roast date is the useful clue. A best-by date tells you only when the bag is legally old, not how it tastes."
  }
}
```

### 2.11 `listening-id`

**Sample 1** (lesson `es-06`)

```json
{
  "prompt": "What is the steam wand doing?",
  "audio": {
    "asset": "coffee/audio/steam-stretching.m4a",
    "durationMs": 6000,
    "license": "original-swoond",
    "description": "A steam wand making a rhythmic tearing-paper hiss as air enters the milk.",
    "maxPlays": 3
  },
  "options": [
    { "id": "stretching", "text": "Stretching: adding air", "explanation": "That paper-tearing hiss is air entering the milk." },
    { "id": "texturing", "text": "Texturing: silent swirling", "explanation": "Texturing is quieter, a low whoosh while the milk spins." },
    { "id": "purge", "text": "Purging the wand", "explanation": "A purge is a short, sharp blast of steam." }
  ],
  "correctOptionId": "stretching",
  "explanation": {
    "correct": "That tearing-paper sound means the tip is at the surface pulling in air, stretching the milk. Once it gets warm, lower the tip to spin and texture.",
    "incorrect": "That hiss is stretching, when air enters the milk. Texturing is quieter and smoother. Listening tells you what the barista is doing.",
    "sayThisLine": "You can hear when they stretch the milk."
  },
  "listenFor": ["Tearing-paper hiss", "Rhythmic chirp", "Then a quieter whirl"]
}
```

**Sample 2** (lesson `ro-03`)

```json
{
  "prompt": "What does this roasting sound signal?",
  "audio": {
    "asset": "coffee/audio/first-crack.m4a",
    "durationMs": 8000,
    "license": "original-swoond",
    "description": "Popcorn-like cracking from a roaster as beans expand, at a steady pace.",
    "maxPlays": 3
  },
  "options": [
    { "id": "first", "text": "First crack: light roast territory begins", "explanation": "Sounds like popcorn; a light roast begins here." },
    { "id": "second", "text": "Second crack: dark roast territory", "explanation": "Second crack is quieter and crisper, like rice crisps in milk." },
    { "id": "grind", "text": "The grinder", "explanation": "A grinder whines continuously instead of popping." }
  ],
  "correctOptionId": "first",
  "explanation": {
    "correct": "First crack is a loud, popcorn-like burst as moisture and gas escape. Roasters use it as a landmark and then control how long they develop after it.",
    "incorrect": "That is first crack, loud and popcorn-like. Second crack is later, quieter and crisper, and signals darker roasts."
  },
  "listenFor": ["Loud popping", "Steady rhythm"]
}
```

**Sample 3** (lesson `bb-05`)

```json
{
  "prompt": "Which kettle sound is ready to pour?",
  "audio": {
    "asset": "coffee/audio/kettle-rising.m4a",
    "durationMs": 7000,
    "license": "original-swoond",
    "description": "A kettle building to a rolling boil, bubbling loudly.",
    "maxPlays": 3
  },
  "options": [
    { "id": "rolling", "text": "Full rolling boil", "explanation": "Loud bubbling means about 212 F." },
    { "id": "early", "text": "Barely warm, just starting", "explanation": "A quiet hum happens well before boiling." },
    { "id": "off", "text": "It is silent and cooled", "explanation": "A silent kettle is off and cooling." }
  ],
  "correctOptionId": "rolling",
  "explanation": {
    "correct": "That loud bubbling is a full boil, about 212 F. For most coffee, take it off and let it rest a moment so it lands in the 195 to 205 F range.",
    "incorrect": "That is a rolling boil. Coffee prefers water just under boiling, so pour after a short rest, and always handle a hot kettle carefully.",
    "sayThisLine": "I let it rest off the boil for a bit."
  },
  "listenFor": ["Loud bubbling", "Roaring water"]
}
```

### 2.12 `estimate-slider`

**Sample 1** (lesson `bb-03`)

```json
{
  "prompt": "A typical pour-over ratio: grams of water per gram of coffee?",
  "unit": "g water",
  "min": 5,
  "max": 30,
  "step": 1,
  "correctValue": 16,
  "tolerance": { "full": 1, "partial": 3 },
  "explanation": {
    "correct": "About 1:16, somewhere between 1:15 and 1:17. The SCA's Golden Cup Standard for batch brew is about 55 grams per liter, roughly 1:18. Recipes vary.",
    "incorrect": "Pour-over sits near 16 grams of water per gram of coffee. Espresso uses far less water, around 2, while cold brew concentrate uses around 5 to 8.",
    "sayThisLine": "I use about sixteen to one."
  }
}
```

**Sample 2** (lesson `bb-05`)

```json
{
  "prompt": "Best brewing water temperature for most coffee (F)?",
  "unit": "F",
  "min": 120,
  "max": 212,
  "step": 1,
  "correctValue": 200,
  "tolerance": { "full": 5, "partial": 12 },
  "explanation": {
    "correct": "Around 200 F, within roughly 195 to 205 F, is the common target (the SCA standard states 200 F plus or minus 5 F). Hot enough to extract, not hot enough to scorch.",
    "incorrect": "Aim for about 200 F. Boiling at 212 F can over-extract and taste harsh; water much cooler under-extracts and tastes sour.",
    "sayThisLine": "I let the kettle rest off the boil."
  }
}
```

**Sample 3** (lesson `es-02`)

```json
{
  "prompt": "A classic espresso shot takes about how many seconds?",
  "unit": "seconds",
  "min": 5,
  "max": 60,
  "step": 1,
  "correctValue": 28,
  "tolerance": { "full": 3, "partial": 8 },
  "explanation": {
    "correct": "About 25 to 30 seconds is a common target, with the shot stopped around a 1:2 ratio. It is a guide; recipes differ.",
    "incorrect": "Most espresso lands in the 25 to 30 second range. Much faster is likely under-extracted and sour; much slower may be bitter.",
    "sayThisLine": "How long does your shot run?"
  }
}
```

**Sample 4** (lesson `es-06`)

```json
{
  "prompt": "Safe, drinkable milk temperature for a latte (F)?",
  "unit": "F",
  "min": 100,
  "max": 212,
  "step": 1,
  "correctValue": 150,
  "tolerance": { "full": 6, "partial": 12 },
  "explanation": {
    "correct": "About 140 to 155 F. Hot but drinkable; it tastes sweetest and stays silky.",
    "incorrect": "Steam milk to roughly 140 to 155 F. Hotter scalds, tastes flat and ruins the texture. Never boil it.",
    "sayThisLine": "I stop steaming when the pitcher is hot but touchable."
  }
}
```

### 2.13 `hotspot-tap`

**Sample 1** (lesson `cb-04`)

```json
{
  "prompt": "Tap the region where most coffee grows.",
  "diagram": { "diagramId": "coffee-belt-map", "aspectRatio": 2, "alt": "A simplified world map with a horizontal band highlighted between the Tropic of Cancer and Tropic of Capricorn, and labels for Latin America, Africa and Asia-Pacific." },
  "hotspots": [
    { "id": "tropics", "label": "The band near the equator", "shape": { "kind": "rect", "x": 0.05, "y": 0.4, "w": 0.9, "h": 0.2 } },
    { "id": "arctic", "label": "The far north", "shape": { "kind": "rect", "x": 0.05, "y": 0.02, "w": 0.9, "h": 0.15 } },
    { "id": "antarctic", "label": "The far south", "shape": { "kind": "rect", "x": 0.05, "y": 0.85, "w": 0.9, "h": 0.13 } }
  ],
  "correctHotspotIds": ["tropics"],
  "explanation": {
    "correct": "The coffee belt runs roughly between the Tropics of Cancer and Capricorn, where frost is rare and altitude and rainfall suit the shrub.",
    "incorrect": "Coffee grows in the warm band around the equator, often at altitude for cooler, slower-ripening cherries. Frost kills the plants."
  }
}
```

**Sample 2** (lesson `es-05`)

```json
{
  "prompt": "Tap the portafilter.",
  "diagram": { "diagramId": "espresso-machine-front", "aspectRatio": 1, "alt": "A front view of an espresso machine with a group head on the left, a handled basket locked into it, a steam wand on the right and a drip tray below." },
  "hotspots": [
    { "id": "portafilter", "label": "Portafilter", "shape": { "kind": "rect", "x": 0.15, "y": 0.45, "w": 0.3, "h": 0.15 } },
    { "id": "steam-wand", "label": "Steam wand", "shape": { "kind": "rect", "x": 0.75, "y": 0.3, "w": 0.1, "h": 0.4 } },
    { "id": "drip-tray", "label": "Drip tray", "shape": { "kind": "rect", "x": 0.1, "y": 0.8, "w": 0.8, "h": 0.12 } },
    { "id": "group-head", "label": "Group head", "shape": { "kind": "rect", "x": 0.15, "y": 0.3, "w": 0.3, "h": 0.12 } }
  ],
  "correctHotspotIds": ["portafilter"],
  "explanation": {
    "correct": "The portafilter is the handled basket that holds the coffee and locks into the group head. Never remove it while the machine is brewing.",
    "incorrect": "The portafilter is the handled basket locked under the group head. The group head is the fitting above it; the wand is for steam and is very hot."
  }
}
```

**Sample 3** (lesson `ex-05`)

```json
{
  "prompt": "Tap the channel where water raced through.",
  "diagram": { "diagramId": "puck-cross-section-channel", "aspectRatio": 1, "alt": "A cross-section of a coffee puck with a thin dark vertical crack running from top to bottom on the right side, and dense grounds elsewhere." },
  "hotspots": [
    { "id": "crack", "label": "The crack on the right", "shape": { "kind": "rect", "x": 0.68, "y": 0.1, "w": 0.08, "h": 0.8 } },
    { "id": "center", "label": "The dense center", "shape": { "kind": "circle", "cx": 0.4, "cy": 0.5, "r": 0.15 } },
    { "id": "edge", "label": "The left edge", "shape": { "kind": "rect", "x": 0.05, "y": 0.1, "w": 0.08, "h": 0.8 } }
  ],
  "correctHotspotIds": ["crack"],
  "explanation": {
    "correct": "That crack is a channel. Water takes the easy route, over-extracting grounds along it and under-extracting the rest, so the shot tastes both sour and bitter.",
    "incorrect": "Look for the thin crack. Water flows through the path of least resistance, so evenly distributed, levelled grounds prevent it."
  }
}
```

## 3. Playbook terms (64)

Each term has a definition and an example line in the enthusiast's voice. Concept ids are in CDS section 11 (Appendix); these drafts become curriculum `concepts[]` entries.

| # | Concept id | Term | Definition | Example line |
|---|---|---|---|---|
| 1 | `coffee-cherry` | Coffee cherry | The small red fruit whose seeds become coffee. | "The cherries were picked at peak ripeness." |
| 2 | `arabica-vs-robusta` | Arabica and robusta | The two main species: arabica is sweeter and more complex; robusta is bolder, more bitter and higher in caffeine. | "It's 100% arabica." |
| 3 | `coffee-belt` | Coffee belt | The tropical band between the Tropics where coffee grows. | "Everything on this shelf comes from the coffee belt." |
| 4 | `specialty-grade` | Specialty grade | Green coffee scoring 80 or more on the SCA scale with very few defects. | "It's specialty grade, 86 points." |
| 5 | `single-origin-vs-blend` | Single origin | Coffee from one place, as opposed to a blend of several. | "This one's a single origin from Huila." |
| 6 | `microlot` | Microlot | A small, separately handled batch from one part of a farm. | "It's a microlot from the top of the farm." |
| 7 | `bag-label-literacy` | Bag label | Origin, process, variety, altitude and roast date printed on a specialty bag. | "I read the bag before I read the price." |
| 8 | `ethiopia-heirloom` | Heirloom (Ethiopia) | A mix of local landrace varieties grown in Ethiopia. | "Ethiopian heirloom is floral and tea-like." |
| 9 | `sl28-sl34` | SL28 and SL34 | Kenyan varieties famed for juicy, blackcurrant-like acidity. | "Kenyan SL28 tastes like blackcurrant." |
| 10 | `altitude-and-density` | Altitude and density | Higher growing altitudes make denser, slower-ripening beans, often with more acidity. | "High-grown, so it's dense and bright." |
| 11 | `coffee-varieties` | Variety | The plant cultivar, such as Typica, Bourbon, Caturra, SL28 or Geisha. | "What's the variety on this lot?" |
| 12 | `geisha` | Geisha | A variety prized for floral, tea-like, jasmine flavors, often very expensive. | "The Geisha tasted like jasmine." |
| 13 | `washed-process` | Washed | Fruit removed before drying; clean, bright, clear cup. | "I prefer washed for clarity." |
| 14 | `natural-process` | Natural | Dried inside the whole cherry; fruity, jammy, sometimes funky. | "Natural processed, so it's berry-forward." |
| 15 | `honey-process` | Honey | Some sticky fruit mucilage left on the seed while drying. | "Yellow honey, so a little sweetness." |
| 16 | `mucilage` | Mucilage | The sticky layer between the skin and the seed. | "The mucilage is what makes honey coffee." |
| 17 | `anaerobic-fermentation` | Anaerobic | Fermented in a sealed, oxygen-free tank before drying. | "That anaerobic lot was wild." |
| 18 | `drying-and-defects` | Drying and defects | Careful drying prevents mold and off flavors. | "A bad natural tastes like a fermented mess." |
| 19 | `roast-levels` | Roast level | How long and hot coffee was roasted: light, medium or dark. | "I'm a light-roast person." |
| 20 | `first-crack` | First crack | The popping sound as beans expand; a light roast begins here. | "They dropped it just after first crack." |
| 21 | `second-crack` | Second crack | A later, quieter cracking that marks dark roasts. | "Second crack means it's a dark roast." |
| 22 | `development-time` | Development time | How long a roast continues after first crack. | "Short development keeps it bright." |
| 23 | `roast-date` | Roast date | The date coffee was roasted; the real freshness clue. | "I never buy without a roast date." |
| 24 | `degassing` | Degassing | Release of carbon dioxide after roasting. | "It's still degassing; give it a week." |
| 25 | `staling-and-storage` | Staling | Flavor loss from oxygen, light, heat and time. | "Airtight, cool and dark." |
| 26 | `omni-roast` | Omni roast | A roast meant to work for filter and espresso. | "It's an omni roast, so I use it for both." |
| 27 | `brewing-is-extraction` | Extraction | Dissolving flavors from coffee grounds into water. | "It's all about extraction." |
| 28 | `dose-and-yield` | Dose and yield | Dose is the coffee weight in; yield is the liquid weight out. | "Eighteen in, thirty-six out." |
| 29 | `brew-ratio` | Brew ratio | Coffee weight to water weight, e.g. 1:16. | "I brew at one to sixteen." |
| 30 | `grind-size` | Grind size | How fine or coarse the ground coffee is. | "Go two clicks finer." |
| 31 | `water-temp-range` | Brew temperature | About 195 to 205 F for most brewing. | "I brew at ninety-four." |
| 32 | `contact-time` | Contact time | How long water and coffee touch. | "The contact time was too short." |
| 33 | `water-quality` | Water quality | Minerals and alkalinity shape what water extracts and how the cup tastes. | "Our tap water is too hard." |
| 34 | `bloom` | Bloom | The first small pour that releases gas and wets the grounds. | "Bloom for thirty seconds." |
| 35 | `immersion-vs-percolation` | Immersion and percolation | Immersion steeps grounds in water; percolation passes water through grounds. | "French press is immersion." |
| 36 | `aeropress` | AeroPress | A plunger-style brewer loved for flexibility. | "I travel with my AeroPress." |
| 37 | `moka-pot` | Moka pot | A stovetop brewer that makes strong, espresso-like coffee (not true espresso). | "My grandmother's moka pot." |
| 38 | `cold-brew` | Cold brew | Coffee steeped in cold water for many hours. | "Cold brew concentrate, then dilute." |
| 39 | `under-extraction` | Under-extracted | Too little dissolved: sour, thin, salty. | "It tastes under-extracted." |
| 40 | `over-extraction` | Over-extracted | Too much dissolved: bitter, dry, astringent. | "That shot's over-extracted." |
| 41 | `strength-vs-extraction` | Strength vs extraction | Strength is concentration; extraction is how much was pulled out of the grounds. | "Strong and well-extracted are different things." |
| 42 | `tds` | TDS | Total dissolved solids: how much coffee is dissolved in the cup. | "We hit 1.4 TDS." |
| 43 | `channeling` | Channeling | Water racing through cracks in the puck, extracting unevenly. | "It channeled; the shot sprayed." |
| 44 | `dialing-in` | Dialing in | Adjusting grind and recipe until a coffee tastes good. | "I dialed in the new bag." |
| 45 | `espresso-definition` | Espresso | A concentrated coffee made by forcing hot water through fine grounds under pressure. | "I pull a double every morning." |
| 46 | `espresso-ratio` | Espresso ratio | Dose to yield, commonly near 1:2. | "One to two in twenty-eight seconds." |
| 47 | `crema` | Crema | The golden foam on an espresso shot. | "Nice crema, but how's the taste?" |
| 48 | `pre-infusion` | Pre-infusion | A gentle low-pressure wetting before full pressure. | "The machine has pre-infusion." |
| 49 | `microfoam` | Microfoam | Steamed milk with tiny, silky bubbles. | "Good microfoam pours like paint." |
| 50 | `doppio-ristretto-lungo` | Doppio, ristretto, lungo | Double shot; shorter shot; longer shot. | "A ristretto, please." |
| 51 | `cappuccino-latte-flat-white` | Cappuccino, latte, flat white | Milk espresso drinks differing in milk volume and texture. | "Flat white, no sugar." |
| 52 | `cortado-macchiato` | Cortado and macchiato | Espresso cut with milk (cortado) or marked with foam (macchiato). | "A cortado, please." |
| 53 | `americano-long-black` | Americano and long black | Espresso and hot water; the long black pours espresso over the water. | "A long black keeps the crema." |
| 54 | `third-place` | Third place | A social space that is neither home nor work. | "The café is her third place." |
| 55 | `acidity-good` | Acidity | A pleasant brightness in tasting, like citrus or apple. | "Bright acidity, cherry notes." |
| 56 | `body` | Body | The weight and texture of coffee in the mouth. | "Silky body." |
| 57 | `finish` | Finish | The aftertaste that lingers. | "Long, sweet finish." |
| 58 | `cupping` | Cupping | A standardized, slurp-and-spit tasting used by professionals. | "We cupped ten coffees this morning." |
| 59 | `sca-score-80` | SCA score | A 100-point scale; 80 and above is specialty. | "It scored eighty-six." |
| 60 | `three-waves-model` | Three waves | A story of coffee: commodity, then café culture, then specialty and origin focus. | "Third wave is about origin." |
| 61 | `direct-trade` | Direct trade | A roaster buys directly from producers, with self-defined terms. | "They're direct trade, but ask how." |
| 62 | `fair-trade` | Fair Trade | A certification with minimum prices and premiums for cooperatives. | "It's Fair Trade certified." |
| 63 | `c-price` | C price | The benchmark arabica futures price for commodity coffee. | "The C price jumped again." |
| 64 | `grinder-importance` | The grinder matters | Enthusiasts often say grinder quality matters more than the brewer. | "Buy the grinder first." |

