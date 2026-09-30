# Native Exercise Plan: Wine (`wine`)

Tier B plan for `docs/courses/wine/`. **There are no Tier A sims** (`sims/` does not exist; see CDS sections 5 and 12). Twelve of the 13 native exercise types are used; `timing-tap` is deliberately unused (no 1D timing skill in wine appreciation; see CDS section 5). All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with ajv when this file was written). Conventions: prompts <= 12 words; every answer explained; asset `license` ids are `original-swoond` (procedural or original art, synthesized or in-house audio); **no winery labels, bottle photographs or brand marks** (spec section 40): bottle, glass and label art is generic and procedural, and any label shown is fictional. Tasting-note and regional facts are paraphrased in Swoon'd's own words. No exercise asks the learner to drink anything; the tasting routine works with smell and attention, and every "taste" item has a no-drinking path (CDS section 13).

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite. Why-questions ("why does red taste drying?"), grape and region facts, label words. Distractors are the misconceptions in CDS section 2. | ~170 |
| `binary-call` | True / myth calls: red at room temperature, screw caps, older is better, sulfites headache claims (framed without medical advice), safe sparkling service. Scenes are `none`. | ~50 |
| `term-match` | Introduce 3 to 6 related terms: structure words, winemaking words, label words, sparkling sweetness, credentials. | ~35 |
| `sequence-order` | Processes with a `why` per step: making red, the vine year, the tasting routine, the restaurant bottle ritual, opening sparkling safely, label ladders (Burgundy, Prädikat). | ~40 |
| `visual-id` | Bottle shapes, closures, glass shapes, color ladders (age, grape), generic label elements. Original vector art only. | ~35 |
| `decision-scenario` | The judgment engine: the list, the corked bottle, the skipped glass, pairing spicy food, budget, gifts. Best / acceptable / poor with an `expertNote` and a `safetyNote` where drinking or pressure is involved. | ~100 |
| `talk-track` | 20 talk tracks at launch; 8 are written in full in section 4. Smooth meter rewards curiosity, honesty and respect for her choices. | 20 |
| `say-this` | Decode what she just said ("skin-contact whites", "Premier Cru", "young Barolo"); every item has a `noFakeExpertNote`. | ~70 |
| `fill-the-gap` | Vocabulary and rules in context; quick review card. | ~40 |
| `listening-id` | Pronunciation of hard names (Sancerre, Gewürztraminer, Rioja, Pouilly-Fumé) and the sound of a safely opened bottle. Original or synthesized audio with a text alternative and Skip. | ~20 |
| `estimate-slider` | Pours per bottle, serving temperatures, ABV ranges, days open, years for drink windows. Numbers are ranges with generous tolerance. | ~30 |
| `hotspot-tap` | Static diagrams: glass anatomy, bottle anatomy, generic label, wine-region maps. Procedural diagrams. | ~30 |

Estimated total: about 640 native items across 117 lessons and the review loop. Cross-type rules: each lesson ends with one item that carries a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`; no item frames consumption as an achievement or a challenge; nothing is timed or scored by quantity.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.


### 2.1 `multiple-choice`

**Sample 1** (lesson `taste-03`)

```json
{
  "prompt": "What makes a red wine feel drying and grippy?",
  "options": [
    {
      "id": "a",
      "text": "Tannin from skins, seeds, stems and oak"
    },
    {
      "id": "b",
      "text": "Acidity"
    },
    {
      "id": "c",
      "text": "Residual sugar"
    },
    {
      "id": "d",
      "text": "The bottle shape"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Tannin binds to proteins in saliva, so your mouth feels dry and grippy, a bit like strong black tea. Red wines get more of it because they ferment with the skins.",
    "incorrect": "That drying grip is tannin. Acidity makes your mouth water; tannin makes it feel dry. Reds have more tannin because they ferment on their skins.",
    "sayThisLine": "I love how grippy the tannin is on this one."
  }
}
```

**Sample 2** (lesson `taste-01`)

```json
{
  "prompt": "A wine smells like ripe peaches. Is it sweet?",
  "options": [
    {
      "id": "a",
      "text": "Not necessarily: fruity aroma is not sugar"
    },
    {
      "id": "b",
      "text": "Yes, fruit smell always means sugar"
    },
    {
      "id": "c",
      "text": "Only if it is white"
    },
    {
      "id": "d",
      "text": "Only if it is cold"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Sweetness is residual sugar you taste on your tongue. Peach smell is aroma. Many dry wines smell fruity, and that is the classic beginner mix-up.",
    "incorrect": "Smell and taste are separate signals. Sugar is tasted; fruit is smelled. A dry wine can smell like peaches.",
    "sayThisLine": "It smells fruity but tastes dry, which I like."
  }
}
```

**Sample 3** (lesson `label-02`)

```json
{
  "prompt": "Which of these is a place, not a grape?",
  "options": [
    {
      "id": "a",
      "text": "Chablis"
    },
    {
      "id": "b",
      "text": "Chardonnay"
    },
    {
      "id": "c",
      "text": "Merlot"
    },
    {
      "id": "d",
      "text": "Riesling"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Chablis is a place in northern Burgundy, and its white wine is made from Chardonnay. Many European labels name the place and expect you to know the grape.",
    "incorrect": "Chablis is a town and appellation in Burgundy. The other three are grapes. Old World labels often give the place, not the grape.",
    "sayThisLine": "Is Chablis always Chardonnay?"
  }
}
```

**Sample 4** (lesson `grape-04`)

```json
{
  "prompt": "Which grape makes red Burgundy?",
  "options": [
    {
      "id": "a",
      "text": "Pinot Noir"
    },
    {
      "id": "b",
      "text": "Cabernet Sauvignon"
    },
    {
      "id": "c",
      "text": "Malbec"
    },
    {
      "id": "d",
      "text": "Syrah"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Red Burgundy is Pinot Noir. It is thin-skinned, so it tends to be lighter in color and tannin with bright acidity, and it reflects where it is grown very clearly.",
    "incorrect": "Red Burgundy is Pinot Noir. Cabernet belongs to Bordeaux, Malbec to Argentina and Cahors, Syrah to the northern Rhône.",
    "sayThisLine": "Is this Pinot from Burgundy or somewhere warmer?"
  }
}
```


### 2.2 `binary-call`

**Sample 1** (lesson `basics-06`)

```json
{
  "prompt": "Red wine should always be served at room temperature.",
  "scene": {
    "kind": "none",
    "alt": "A statement card about serving red wine."
  },
  "choices": [
    {
      "id": "true",
      "label": "True"
    },
    {
      "id": "myth",
      "label": "Myth"
    }
  ],
  "correctChoiceId": "myth",
  "explanation": {
    "correct": "'Room temperature' comes from cool European cellars and castles. Many reds show better lightly cooled, around 55 to 65 F, and a warm room makes them taste flabby and boozy.",
    "incorrect": "Mostly myth. A modern warm room is far above the old cellar temperature. Lightly chilling a red brings out freshness.",
    "sayThisLine": "Could we put the red in the fridge for ten minutes?"
  },
  "ruleTag": "Serving temperature"
}
```

**Sample 2** (lesson `basics-05`)

```json
{
  "prompt": "A screw cap means a cheap wine.",
  "scene": {
    "kind": "none",
    "alt": "A statement card about closures."
  },
  "choices": [
    {
      "id": "true",
      "label": "True"
    },
    {
      "id": "myth",
      "label": "Myth"
    }
  ],
  "correctChoiceId": "myth",
  "explanation": {
    "correct": "Screw caps are a closure, not a quality grade. Many top producers in Australia, New Zealand and Austria use them because they avoid cork taint and keep freshness.",
    "incorrect": "Closure does not equal quality. Plenty of excellent wines wear screw caps.",
    "sayThisLine": "Is that a screw cap for freshness?"
  },
  "ruleTag": "Closure myth"
}
```

**Sample 3** (lesson `coll-03`)

```json
{
  "prompt": "Older wine is always better wine.",
  "scene": {
    "kind": "none",
    "alt": "A statement card about aging."
  },
  "choices": [
    {
      "id": "true",
      "label": "True"
    },
    {
      "id": "myth",
      "label": "Myth"
    }
  ],
  "correctChoiceId": "myth",
  "explanation": {
    "correct": "Most wine is made to drink within a few years. Only some wines gain from age, and only if they have structure (acid, tannin or sugar) to carry them. Others just fade.",
    "incorrect": "Most wines are built for now. Age helps only structured wines, and even then it is a taste, not a rule.",
    "sayThisLine": "Is this one built to age, or is it for drinking now?"
  },
  "ruleTag": "Ageing myth"
}
```

**Sample 4** (lesson `sp-03`)

```json
{
  "prompt": "Opening sparkling wine: pop the cork with a bang.",
  "scene": {
    "kind": "none",
    "alt": "A safety call about opening a sparkling wine bottle."
  },
  "choices": [
    {
      "id": "safe",
      "label": "Fine"
    },
    {
      "id": "skip",
      "label": "Skip it"
    }
  ],
  "correctChoiceId": "skip",
  "explanation": {
    "correct": "The pressure in a sparkling bottle is about that of a truck tyre. Hold the cork, twist the bottle, and let it sigh out. A flying cork can injure eyes, and a pop wastes bubbles.",
    "incorrect": "Skip the bang. Keep a hand on the cork, point it away from everyone and twist the bottle slowly until it sighs.",
    "sayThisLine": "I'll open it slowly so it just sighs."
  },
  "ruleTag": "Safe service"
}
```


### 2.3 `term-match`

**Sample 1** (lesson `taste-05`)

```json
{
  "prompt": "Match the tasting word to what you notice.",
  "pairs": [
    {
      "id": "acidity",
      "term": "Acidity",
      "definition": "Mouthwatering freshness"
    },
    {
      "id": "tannin",
      "term": "Tannin",
      "definition": "Drying grip, like strong tea"
    },
    {
      "id": "body",
      "term": "Body",
      "definition": "Weight of the wine in your mouth"
    },
    {
      "id": "finish",
      "term": "Finish",
      "definition": "How long the flavor lasts after you swallow or spit"
    },
    {
      "id": "balance",
      "term": "Balance",
      "definition": "No single element sticks out"
    }
  ],
  "distractorDefinitions": [
    "How old the wine is"
  ],
  "explanation": {
    "summary": "These five words cover most tasting talk. Acid makes your mouth water, tannin dries it, body is weight, finish is length and balance is how it all fits together.",
    "sayThisLine": "The acidity is bright, but the finish is what I love."
  }
}
```

**Sample 2** (lesson `make-05`)

```json
{
  "prompt": "Match the winemaking word to what happens.",
  "pairs": [
    {
      "id": "maceration",
      "term": "Maceration",
      "definition": "Juice soaks on the grape skins"
    },
    {
      "id": "lees",
      "term": "Lees",
      "definition": "Dead yeast cells that settle after fermentation"
    },
    {
      "id": "malolactic",
      "term": "Malolactic",
      "definition": "Sharp malic acid converts to softer lactic acid"
    },
    {
      "id": "fortification",
      "term": "Fortification",
      "definition": "Adding spirit to wine"
    },
    {
      "id": "veraison",
      "term": "Véraison",
      "definition": "Grapes start to ripen and change color"
    }
  ],
  "explanation": {
    "summary": "Each word marks a step. Maceration brings color and tannin, lees add texture, malolactic softens acidity, fortification raises alcohol, and véraison is the vineyard's turning point.",
    "sayThisLine": "Did this one go through malolactic? It's so creamy."
  }
}
```

**Sample 3** (lesson `label-06`)

```json
{
  "prompt": "Match the sparkling sweetness word to its level.",
  "pairs": [
    {
      "id": "brut-nature",
      "term": "Brut Nature",
      "definition": "Bone dry, no added sugar"
    },
    {
      "id": "brut",
      "term": "Brut",
      "definition": "Dry, the usual style"
    },
    {
      "id": "extra-dry",
      "term": "Extra Dry",
      "definition": "Slightly sweeter than Brut"
    },
    {
      "id": "demi-sec",
      "term": "Demi-Sec",
      "definition": "Noticeably sweet, for dessert"
    }
  ],
  "distractorDefinitions": [
    "Aged over ten years"
  ],
  "explanation": {
    "summary": "The sparkling scale runs counter to intuition: Extra Dry is sweeter than Brut. Brut is the everyday dry style and Demi-Sec suits cake.",
    "sayThisLine": "Wait, Extra Dry is sweeter than Brut?"
  }
}
```


### 2.4 `sequence-order`

**Sample 1** (lesson `make-04`)

```json
{
  "prompt": "Put the making of a red wine in order.",
  "items": [
    {
      "id": "harvest",
      "text": "Harvest the ripe grapes",
      "why": "Everything starts with grapes picked at the right ripeness."
    },
    {
      "id": "crush",
      "text": "Destem and crush",
      "why": "Breaking the skins releases juice and lets yeast reach the sugar."
    },
    {
      "id": "ferment",
      "text": "Ferment the juice with its skins",
      "why": "Skin contact gives a red wine its color, tannin and flavor."
    },
    {
      "id": "press",
      "text": "Press off the wine",
      "why": "Pressing separates young wine from skins and seeds."
    },
    {
      "id": "age",
      "text": "Age in tank or barrel",
      "why": "Time softens and integrates the wine."
    },
    {
      "id": "bottle",
      "text": "Bottle",
      "why": "The wine is protected and ready to ship."
    }
  ],
  "explanation": {
    "correct": "Red wine ferments with its skins, then gets pressed; white wine is pressed first. That one switch explains color and tannin.",
    "incorrect": "The key is skin contact: red ferments with skins, then is pressed. White is pressed before fermenting.",
    "sayThisLine": "So red ferments on the skins and white doesn't?"
  }
}
```

**Sample 2** (lesson `taste-06`)

```json
{
  "prompt": "Order the four steps of a tasting.",
  "items": [
    {
      "id": "look",
      "text": "Look at color and clarity",
      "why": "Color hints at age, grape and weight before you taste."
    },
    {
      "id": "swirl",
      "text": "Swirl gently",
      "why": "Swirling lets aromas lift out of the glass."
    },
    {
      "id": "smell",
      "text": "Smell",
      "why": "Most of what you call taste is smell."
    },
    {
      "id": "sip",
      "text": "Sip and think",
      "why": "Notice sweetness, acidity, tannin, body and finish."
    }
  ],
  "explanation": {
    "correct": "Eyes first, then smell, then taste. Smelling before sipping primes you for what is in the glass.",
    "incorrect": "Look, swirl, smell, sip. Most flavor is smell, so never skip the sniff.",
    "sayThisLine": "I'm smelling first, then I'll tell you what I think."
  }
}
```

**Sample 3** (lesson `list-02`)

```json
{
  "prompt": "Put the restaurant bottle ritual in order.",
  "items": [
    {
      "id": "show",
      "text": "Server shows you the label",
      "why": "You confirm it is the bottle you ordered."
    },
    {
      "id": "open",
      "text": "Server opens the bottle",
      "why": "They open at the table so you see it is sealed."
    },
    {
      "id": "taste",
      "text": "Server pours a small taste for the host",
      "why": "The taste is to check for faults, not to decide if you like it."
    },
    {
      "id": "check",
      "text": "Host smells, sips and nods or asks",
      "why": "A nod means it is sound; a question means you suspect a fault."
    },
    {
      "id": "pour",
      "text": "Server pours for the table",
      "why": "Everyone gets served once the host approves."
    }
  ],
  "explanation": {
    "correct": "The tasting pour checks that the wine is sound, not that you like it. Only a fault, such as cork taint, is a reason to question it.",
    "incorrect": "Label, open, small taste, host nods, then pour. The taste is a fault check, not a vote.",
    "sayThisLine": "It seems fine, thank you. Please pour."
  }
}
```


### 2.5 `visual-id`

**Sample 1** (lesson `basics-05`)

```json
{
  "prompt": "Which bottle shape is this?",
  "image": {
    "asset": "wine/visuals/bottle-silhouette-sloping.svg",
    "alt": "Bottle silhouette with long sloping shoulders and no sharp corner between neck and body.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "burgundy",
      "text": "Burgundy (sloping shoulders)"
    },
    {
      "id": "bordeaux",
      "text": "Bordeaux (high square shoulders)"
    },
    {
      "id": "flute",
      "text": "Flute (tall, slim, Alsace or Mosel)"
    },
    {
      "id": "champagne",
      "text": "Champagne (heavy, sloped, punt)"
    }
  ],
  "correctOptionId": "burgundy",
  "explanation": {
    "correct": "Sloping shoulders are the Burgundy shape, used for Pinot Noir and Chardonnay worldwide. Shape is a hint, not a guarantee.",
    "incorrect": "Look at the shoulders. Sloping means Burgundy, square means Bordeaux. It is a clue, not proof.",
    "sayThisLine": "Is that a Burgundy-style bottle?"
  }
}
```

**Sample 2** (lesson `basics-05`)

```json
{
  "prompt": "What closure is this?",
  "image": {
    "asset": "wine/visuals/closure-screwcap.svg",
    "alt": "Top of a bottle with a smooth metal cap and a thin line around the neck.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "screwcap",
      "text": "Screw cap"
    },
    {
      "id": "natural-cork",
      "text": "Natural cork"
    },
    {
      "id": "synthetic",
      "text": "Synthetic stopper"
    },
    {
      "id": "glass",
      "text": "Glass stopper"
    }
  ],
  "correctOptionId": "screwcap",
  "explanation": {
    "correct": "A screw cap seals the bottle tightly and avoids cork taint. It is a fit for fresh whites and many reds and says nothing about quality.",
    "incorrect": "A smooth metal cap with a line around the neck is a screw cap, not a cork or plastic stopper.",
    "sayThisLine": "Screw cap? Good, no cork taint to worry about."
  }
}
```

**Sample 3** (lesson `aroma-03`)

```json
{
  "prompt": "What does a brick-orange rim suggest on a red?",
  "image": {
    "asset": "wine/visuals/glass-tilt-brick-rim.svg",
    "alt": "A red wine glass tilted against white, with a garnet centre fading to an orange-brown rim.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "older",
      "text": "A wine with some age"
    },
    {
      "id": "young",
      "text": "A very young wine"
    },
    {
      "id": "sparkling",
      "text": "A sparkling wine"
    },
    {
      "id": "faulty",
      "text": "A faulty wine"
    }
  ],
  "correctOptionId": "older",
  "explanation": {
    "correct": "Reds lose purple and turn brick or orange with age. It is a clue about age, not proof: some grapes like Grenache start paler.",
    "incorrect": "An orange-brown rim on a red suggests age. It is a hint, not a guarantee, and it is not a fault.",
    "sayThisLine": "It looks like it has some age on it."
  }
}
```

Asset needs: `wine/visuals/*.svg` generic procedural art (bottle silhouettes, closures, glass tilt with a color ramp). No real brands.


### 2.6 `decision-scenario`

**Sample 1** (lesson `list-03`)

```json
{
  "prompt": "The wine list is huge. What do you do?",
  "situation": {
    "narrative": "A pasta dinner with tomato sauce. The list has 40 pages.",
    "facts": [
      {
        "label": "Budget",
        "value": "About $60 a bottle"
      },
      {
        "label": "Dinner",
        "value": "Tomato pasta"
      },
      {
        "label": "Table",
        "value": "You and her"
      },
      {
        "label": "Her taste",
        "value": "Likes dry and crisp"
      }
    ]
  },
  "options": [
    {
      "id": "ask",
      "label": "Ask the server for a bottle near $60 that suits tomato pasta",
      "verdict": "best",
      "consequence": "The server points to a bright Italian red. It is well priced, fresh and goes with the sauce.",
      "considerations": [
        "Saying your budget out loud is normal and welcome",
        "High acidity matches tomato"
      ]
    },
    {
      "id": "second",
      "label": "Pick the second-cheapest bottle",
      "verdict": "poor",
      "consequence": "It is often a popular, high-markup wine, and nothing about it fits the meal.",
      "considerations": [
        "The second-cheapest rule is a myth",
        "Markup is often highest there"
      ]
    },
    {
      "id": "pricey",
      "label": "Order the big Cabernet to look impressive",
      "verdict": "poor",
      "consequence": "It is heavy against a bright tomato sauce and blows the budget.",
      "considerations": [
        "Bold tannic reds fight acidic tomato",
        "Impressing is not the goal; enjoying together is"
      ]
    }
  ],
  "expertNote": "A good sommelier loves a clear budget and a simple taste description. Giving both is the fastest route to a good bottle.",
  "sayThisLine": "We'd like something dry and fresh, around sixty dollars, to go with tomato pasta.",
  "safetyNote": "Order only what you both want; there is no pressure to finish a bottle, and by-the-glass is always fine."
}
```

**Sample 2** (lesson `aroma-05`)

```json
{
  "prompt": "The wine smells like wet cardboard. What now?",
  "situation": {
    "narrative": "The server pours your tasting sip at dinner.",
    "facts": [
      {
        "label": "Smell",
        "value": "Damp cardboard, muted fruit"
      },
      {
        "label": "Bottle",
        "value": "Sealed with a natural cork"
      },
      {
        "label": "Table",
        "value": "Quiet, nice restaurant"
      }
    ]
  },
  "options": [
    {
      "id": "mention",
      "label": "Say you think it may be corked and ask the server to smell it",
      "verdict": "best",
      "consequence": "The server agrees and brings a fresh bottle with no fuss.",
      "considerations": [
        "Cork taint is a real fault, and staff know it",
        "A polite question keeps it friendly"
      ]
    },
    {
      "id": "silent",
      "label": "Say nothing and drink it",
      "verdict": "acceptable",
      "consequence": "You drink a muted wine that does not show what the producer intended.",
      "considerations": [
        "Corked wine is harmless but dull",
        "Most restaurants would rather be told"
      ]
    },
    {
      "id": "dislike",
      "label": "Send it back because it is not your style",
      "verdict": "poor",
      "consequence": "The server explains it is sound, just not to your taste, and you have awkwardly used the ritual.",
      "considerations": [
        "Fault and preference are different",
        "Ask for something different instead"
      ]
    }
  ],
  "expertNote": "Corked wine smells like damp cardboard or a wet basement and the fruit goes quiet. If it is merely not to your liking, ask for help choosing another bottle rather than returning a sound one.",
  "sayThisLine": "Could you have a smell? I think this might be corked."
}
```

**Sample 3** (lesson `care-05`)

```json
{
  "prompt": "She says she is not drinking tonight. What do you do?",
  "situation": {
    "narrative": "You brought a nice bottle to dinner at her place.",
    "facts": [
      {
        "label": "Her words",
        "value": "Not drinking tonight, thanks"
      },
      {
        "label": "Bottle",
        "value": "Already chilled"
      },
      {
        "label": "Plan",
        "value": "Dinner for two"
      }
    ]
  },
  "options": [
    {
      "id": "warm",
      "label": "Say 'Totally fine' and offer sparkling water or a zero-proof drink",
      "verdict": "best",
      "consequence": "She relaxes, picks a drink and you both enjoy dinner.",
      "considerations": [
        "Her reasons are hers",
        "Offering an alternative keeps the night good"
      ]
    },
    {
      "id": "why",
      "label": "Ask why she is not drinking",
      "verdict": "poor",
      "consequence": "She shrugs and the mood cools.",
      "considerations": [
        "Reasons are private",
        "Curiosity about her is fine, about her choice is pressure"
      ]
    },
    {
      "id": "just-one",
      "label": "Tell her one glass will not hurt",
      "verdict": "poor",
      "consequence": "She feels pushed and the evening gets awkward.",
      "considerations": [
        "Never pressure anyone to drink",
        "No wine is worth the trust it costs"
      ]
    }
  ],
  "expertNote": "Hosts who make it easy to say no are the ones people trust. Keep the bottle for another night, and keep the night warm.",
  "sayThisLine": "No problem at all. Want a sparkling water with lime?",
  "safetyNote": "Never pressure anyone to drink. Reasons for not drinking (health, medication, pregnancy, recovery, preference) are private."
}
```

**Sample 4** (lesson `pair-03`)

```json
{
  "prompt": "Spicy Thai takeout. Which bottle goes best?",
  "situation": {
    "narrative": "A big red curry, extra heat.",
    "facts": [
      {
        "label": "Food",
        "value": "Spicy, coconut, sweet-salty"
      },
      {
        "label": "Option A",
        "value": "Off-dry Riesling, low alcohol"
      },
      {
        "label": "Option B",
        "value": "Big tannic Cabernet, high alcohol"
      },
      {
        "label": "Option C",
        "value": "Oaky Chardonnay"
      }
    ]
  },
  "options": [
    {
      "id": "riesling",
      "label": "Off-dry Riesling",
      "verdict": "best",
      "consequence": "Sweetness and acidity cool the heat and low alcohol does not amplify it.",
      "considerations": [
        "Sugar soothes chili",
        "Low alcohol means less burn"
      ]
    },
    {
      "id": "chard",
      "label": "Oaky Chardonnay",
      "verdict": "acceptable",
      "consequence": "The creamy weight is fine but the oak fights the spice and the heat feels louder.",
      "considerations": [
        "Oak can clash with chili",
        "Weight is fine; oak is the issue"
      ]
    },
    {
      "id": "cab",
      "label": "Big tannic Cabernet",
      "verdict": "poor",
      "consequence": "Tannin and alcohol magnify the burn and the wine tastes bitter.",
      "considerations": [
        "Chili plus tannin tastes harsher",
        "High alcohol amplifies heat"
      ]
    }
  ],
  "expertNote": "With spicy food, go low in alcohol and tannin, with a little sweetness and high acid. It is a principle, not a law.",
  "sayThisLine": "I think an off-dry Riesling would stand up to the heat."
}
```


### 2.7 `say-this`

**Sample 1** (lesson `nat-02`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "I've been into skin-contact whites lately. Orange wine, basically."
  },
  "options": [
    {
      "id": "a",
      "text": "White grapes fermented with their skins",
      "isCorrect": true,
      "explanation": "Orange wine is white wine made like red, on the skins."
    },
    {
      "id": "b",
      "text": "Wine made from oranges",
      "isCorrect": false,
      "explanation": "No oranges. The color comes from the skins."
    },
    {
      "id": "c",
      "text": "A sweet dessert wine",
      "isCorrect": false,
      "explanation": "Orange wines are usually dry, often grippy."
    },
    {
      "id": "d",
      "text": "A blend of red and white",
      "isCorrect": false,
      "explanation": "Blending is not how it's made."
    }
  ],
  "translation": "She likes white wines made with skin contact, so they have amber color and some tannin.",
  "followUps": [
    {
      "line": "What do you like about them compared to regular whites?",
      "why": "Invites her to describe texture and taste."
    },
    {
      "line": "Is there one you would start me on?",
      "why": "Shows curiosity, not expertise."
    }
  ],
  "noFakeExpertNote": "You do not need to know producers. Asking what she likes about it is enough."
}
```

**Sample 2** (lesson `label-03`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "This is a Premier Cru from Meursault. Kind of a splurge."
  },
  "options": [
    {
      "id": "a",
      "text": "A high-ranked white Burgundy vineyard, so a pricier bottle",
      "isCorrect": true,
      "explanation": "Premier Cru is the rung under Grand Cru; Meursault is a village known for Chardonnay."
    },
    {
      "id": "b",
      "text": "A sparkling wine from Champagne",
      "isCorrect": false,
      "explanation": "Meursault is in Burgundy and makes still wine."
    },
    {
      "id": "c",
      "text": "A red from Bordeaux",
      "isCorrect": false,
      "explanation": "Meursault is white Burgundy country."
    },
    {
      "id": "d",
      "text": "A cheap table wine",
      "isCorrect": false,
      "explanation": "Premier Cru signals a classified vineyard, usually pricier."
    }
  ],
  "translation": "She bought a well-regarded white Burgundy from a named vineyard and treats it as a treat.",
  "followUps": [
    {
      "line": "What made you want to try that one?",
      "why": "Asks about her story, not the label."
    },
    {
      "line": "How does Premier Cru compare to the village wines?",
      "why": "Shows you know there is a ladder."
    }
  ],
  "noFakeExpertNote": "Do not pretend to know which vineyard. Saying 'what is special about it?' is a great question."
}
```

**Sample 3** (lesson `taste-03`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "It's a young Barolo, so super tannic. I'm decanting it for an hour."
  },
  "options": [
    {
      "id": "a",
      "text": "It has lots of grip, so she is letting it breathe",
      "isCorrect": true,
      "explanation": "Young Barolo is tannic; air can soften the edges."
    },
    {
      "id": "b",
      "text": "The wine has gone off",
      "isCorrect": false,
      "explanation": "Tannic is a style, not a fault."
    },
    {
      "id": "c",
      "text": "She is warming it up",
      "isCorrect": false,
      "explanation": "Decanting is about air, not temperature."
    },
    {
      "id": "d",
      "text": "She is removing alcohol",
      "isCorrect": false,
      "explanation": "Air does not remove meaningful alcohol."
    }
  ],
  "translation": "It is a powerful, grippy red and she is pouring it into a decanter to let it open up.",
  "followUps": [
    {
      "line": "Does decanting really change the taste?",
      "why": "An honest question, and a chance for her to share."
    },
    {
      "line": "What are we eating with it?",
      "why": "Barolo loves food."
    }
  ],
  "noFakeExpertNote": "Decanting has fans and skeptics. Ask what she notices instead of announcing a view."
}
```

**Sample 4** (lesson `old-01`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "I only drink Old World. New World is way too jammy for me."
  },
  "options": [
    {
      "id": "a",
      "text": "She prefers restrained, earthy, higher-acid styles",
      "isCorrect": true,
      "explanation": "Old World tends toward restraint and New World toward ripe fruit, though there are exceptions."
    },
    {
      "id": "b",
      "text": "She only likes very old wine",
      "isCorrect": false,
      "explanation": "Old World refers to place, not age."
    },
    {
      "id": "c",
      "text": "She hates all American wine",
      "isCorrect": false,
      "explanation": "She prefers a style, not a country."
    },
    {
      "id": "d",
      "text": "She likes sweet wines",
      "isCorrect": false,
      "explanation": "Jammy means very ripe fruit, not necessarily sugar."
    }
  ],
  "translation": "She likes wines from European regions, which tend to be leaner and earthier, over very ripe, fruit-forward ones.",
  "followUps": [
    {
      "line": "What's a bottle that changed your mind about Old World?",
      "why": "Invites a story."
    },
    {
      "line": "Have you had a cool-climate New World wine you liked?",
      "why": "Gently tests the generalization."
    }
  ],
  "noFakeExpertNote": "It is a tendency, not a law; do not argue the exceptions unless she invites it."
}
```


### 2.8 `fill-the-gap`

**Sample 1** (lesson `taste-02`)

```json
{
  "prompt": "Finish the tasting line.",
  "template": "{{g1}} makes your mouth water, while {{g2}} makes it feel dry.",
  "gaps": [
    {
      "id": "g1",
      "options": [
        "Acidity",
        "Tannin",
        "Sugar"
      ],
      "correct": "Acidity"
    },
    {
      "id": "g2",
      "options": [
        "tannin",
        "acidity",
        "sugar"
      ],
      "correct": "tannin"
    }
  ],
  "explanation": {
    "correct": "Acidity triggers saliva so your mouth waters. Tannin binds saliva proteins, so the mouth feels dry and grippy.",
    "incorrect": "Acidity is mouthwatering; tannin is drying. Those are the two opposite feelings to learn first.",
    "sayThisLine": "Bright acidity, soft tannin. That's my kind of red."
  }
}
```

**Sample 2** (lesson `make-06`)

```json
{
  "prompt": "Complete the Champagne fact.",
  "template": "Champagne gets its bubbles from a second fermentation inside the {{g1}}, called the {{g2}} method.",
  "gaps": [
    {
      "id": "g1",
      "options": [
        "bottle",
        "tank",
        "barrel"
      ],
      "correct": "bottle"
    },
    {
      "id": "g2",
      "options": [
        "traditional",
        "Charmat",
        "solera"
      ],
      "correct": "traditional"
    }
  ],
  "explanation": {
    "correct": "Traditional method means the second fermentation, which makes the bubbles, happens in the very bottle you buy. Tank method does it in a large tank, which is cheaper and fruitier.",
    "incorrect": "Champagne's bubbles come from a second fermentation in the bottle, called the traditional method. Tank method is what Prosecco usually uses.",
    "sayThisLine": "Is that traditional method or tank method?"
  }
}
```

**Sample 3** (lesson `make-04`)

```json
{
  "prompt": "Why is red wine red?",
  "template": "Red wine gets its color and {{g1}} from fermenting on the grape {{g2}}.",
  "gaps": [
    {
      "id": "g1",
      "options": [
        "tannin",
        "sugar",
        "bubbles"
      ],
      "correct": "tannin"
    },
    {
      "id": "g2",
      "options": [
        "skins",
        "leaves",
        "stems"
      ],
      "correct": "skins"
    }
  ],
  "explanation": {
    "correct": "Grape juice is almost always clear. Color and tannin both come from the skins, which soak in the fermenting juice.",
    "incorrect": "Color and tannin come from the skins. The juice inside is nearly clear.",
    "sayThisLine": "So the color comes from the skins, not the juice?"
  }
}
```


### 2.9 `listening-id`

**Sample 1** (lesson `fr-03`)

```json
{
  "prompt": "Which wine name did you just hear?",
  "audio": {
    "asset": "wine/audio/sancerre-say.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A voice says 'sahn-SAIR', two syllables with the stress on the second, a Loire white wine name.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "sancerre",
      "text": "Sancerre (sahn-SAIR)",
      "explanation": "A white wine from the Loire, made from Sauvignon Blanc."
    },
    {
      "id": "sauternes",
      "text": "Sauternes (so-TURN)",
      "explanation": "A sweet wine from Bordeaux."
    },
    {
      "id": "saumur",
      "text": "Saumur (so-MOOR)",
      "explanation": "Loire too, but a different sound."
    }
  ],
  "correctOptionId": "sancerre",
  "explanation": {
    "correct": "Sancerre is said 'sahn-SAIR'. Saying it the way locals do shows you care, and nobody expects perfection.",
    "incorrect": "It is 'sahn-SAIR', with the stress at the end. Practice the soft 'sahn'.",
    "sayThisLine": "We'd love the Sancerre, please."
  }
}
```

**Sample 2** (lesson `old-03`)

```json
{
  "prompt": "Which grape name did you just hear?",
  "audio": {
    "asset": "wine/audio/gewurztraminer-say.m4a",
    "durationMs": 3000,
    "license": "original-swoond",
    "description": "A voice says 'guh-VURTZ-trah-mee-ner', five syllables, stress on the second.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "gewurz",
      "text": "Gewürztraminer (guh-VURTZ-trah-mee-ner)",
      "explanation": "An aromatic Alsace white with lychee and rose notes."
    },
    {
      "id": "gruner",
      "text": "Grüner Veltliner (GROO-ner VELT-lee-ner)",
      "explanation": "An Austrian white."
    },
    {
      "id": "gamay",
      "text": "Gamay (ga-MAY)",
      "explanation": "A light red grape from Beaujolais."
    }
  ],
  "correctOptionId": "gewurz",
  "explanation": {
    "correct": "Gewürztraminer is said 'guh-VURTZ-trah-mee-ner'. People shorten it to 'Gewurz', which is perfectly fine.",
    "incorrect": "It is 'guh-VURTZ-trah-mee-ner'. Shortening to 'Gewurz' is normal.",
    "sayThisLine": "Do you like Gewurz with spicy food?"
  }
}
```

**Sample 3** (lesson `sp-03`)

```json
{
  "prompt": "Which sound is a sparkling bottle opened safely?",
  "audio": {
    "asset": "wine/audio/sparkling-sigh.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A soft hiss, like a long exhale, with no loud pop.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "sigh",
      "text": "A soft sigh",
      "explanation": "The cork eased out slowly under your hand."
    },
    {
      "id": "pop",
      "text": "A loud pop",
      "explanation": "A flying cork risks eyes and wastes bubbles."
    }
  ],
  "correctOptionId": "sigh",
  "explanation": {
    "correct": "A soft hiss means you held the cork and let the pressure out gently. It is safer and keeps more of the bubbles.",
    "incorrect": "That was a pop. Hold the cork, twist the bottle and aim for a sigh.",
    "sayThisLine": "Let me open it slowly so it just sighs."
  }
}
```

Audio needs: short synthesized or in-house recordings; TTS licence terms must be checked before shipping (`NOTES_FOR_ORCHESTRATOR.md`). Every clip has a text description, `maxPlays` 3 and a Skip.


### 2.10 `estimate-slider`

**Sample 1** (lesson `care-02`)

```json
{
  "prompt": "How many standard pours are in one bottle?",
  "unit": "pours",
  "min": 2,
  "max": 12,
  "step": 1,
  "correctValue": 5,
  "tolerance": {
    "full": 0,
    "partial": 1
  },
  "explanation": {
    "correct": "A 750 ml bottle holds about five 5-ounce (150 ml) pours. Restaurants and tastings use small pours so you can taste and go slow.",
    "incorrect": "About five. A 750 ml bottle is roughly five standard pours, which is why a bottle shared between two goes a long way.",
    "sayThisLine": "A bottle is about five glasses, so two of us can take our time."
  }
}
```

**Sample 2** (lesson `basics-06`)

```json
{
  "prompt": "What temperature should a crisp white be served at?",
  "unit": "F",
  "min": 30,
  "max": 75,
  "step": 1,
  "correctValue": 47,
  "tolerance": {
    "full": 3,
    "partial": 8
  },
  "explanation": {
    "correct": "Crisp whites taste best around 45 to 50 F (7 to 10 C), cold enough to feel fresh, not so cold the aroma disappears.",
    "incorrect": "About 45 to 50 F. Straight from the fridge can be too cold, so give it ten minutes out.",
    "sayThisLine": "Let's pull it out of the fridge for ten minutes."
  }
}
```

**Sample 3** (lesson `taste-01`)

```json
{
  "prompt": "About what ABV is a Mosel Kabinett Riesling?",
  "unit": "% ABV",
  "min": 5,
  "max": 20,
  "step": 0.5,
  "correctValue": 9,
  "tolerance": {
    "full": 1,
    "partial": 3
  },
  "explanation": {
    "correct": "German Riesling from the Mosel at Kabinett level is often around 8 to 10 percent, low in alcohol thanks to grapes that are picked less ripe and a bit of leftover sugar.",
    "incorrect": "Around 9 percent. Cool-climate Riesling is famously low in alcohol. Warm-climate reds can reach 14 to 15.",
    "sayThisLine": "Nine percent, so it's light but still flavorful."
  }
}
```

**Sample 4** (lesson `coll-04`)

```json
{
  "prompt": "How many days does a stoppered red last in the fridge?",
  "unit": "days",
  "min": 1,
  "max": 14,
  "step": 1,
  "correctValue": 4,
  "tolerance": {
    "full": 1,
    "partial": 2
  },
  "explanation": {
    "correct": "Once open, oxygen slowly dulls a wine. Most still wines stay pleasant 3 to 5 days if sealed and refrigerated, though sparkling is best within a day or two.",
    "incorrect": "About 3 to 5 days. Reseal, refrigerate, and taste before you judge.",
    "sayThisLine": "Let's see how it tastes tomorrow."
  }
}
```


### 2.11 `hotspot-tap`

**Sample 1** (lesson `basics-06`)

```json
{
  "prompt": "Tap where you hold a glass of white wine.",
  "diagram": {
    "diagramId": "wine-glass-anatomy",
    "aspectRatio": 0.6,
    "alt": "Side view of a wine glass with four labeled parts: rim, bowl, stem and foot."
  },
  "hotspots": [
    {
      "id": "rim",
      "label": "Rim",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.06,
        "r": 0.07
      }
    },
    {
      "id": "bowl",
      "label": "Bowl",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.3,
        "r": 0.15
      }
    },
    {
      "id": "stem",
      "label": "Stem",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.62,
        "r": 0.07
      }
    },
    {
      "id": "foot",
      "label": "Foot",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.92,
        "r": 0.09
      }
    }
  ],
  "correctHotspotIds": [
    "stem"
  ],
  "explanation": {
    "correct": "Hold a glass by the stem so your hand does not warm a chilled white and you do not smudge the bowl.",
    "incorrect": "Hold the stem. The bowl is for swirling and looking, not gripping.",
    "sayThisLine": "I'll hold it by the stem."
  }
}
```

**Sample 2** (lesson `old-02`)

```json
{
  "prompt": "Tap Burgundy on the map of France.",
  "diagram": {
    "diagramId": "map-france-wine-regions",
    "aspectRatio": 1.0,
    "alt": "Simple outline of France with dots for wine regions: Champagne in the northeast, Alsace far east, Burgundy east-centre, Loire west-centre, Bordeaux southwest, Rhône southeast."
  },
  "hotspots": [
    {
      "id": "champagne",
      "label": "Champagne",
      "shape": {
        "kind": "circle",
        "cx": 0.58,
        "cy": 0.2,
        "r": 0.06
      }
    },
    {
      "id": "alsace",
      "label": "Alsace",
      "shape": {
        "kind": "circle",
        "cx": 0.84,
        "cy": 0.27,
        "r": 0.06
      }
    },
    {
      "id": "loire",
      "label": "Loire",
      "shape": {
        "kind": "circle",
        "cx": 0.36,
        "cy": 0.4,
        "r": 0.06
      }
    },
    {
      "id": "burgundy",
      "label": "Burgundy",
      "shape": {
        "kind": "circle",
        "cx": 0.66,
        "cy": 0.43,
        "r": 0.06
      }
    },
    {
      "id": "bordeaux",
      "label": "Bordeaux",
      "shape": {
        "kind": "circle",
        "cx": 0.27,
        "cy": 0.66,
        "r": 0.06
      }
    },
    {
      "id": "rhone",
      "label": "Rhône",
      "shape": {
        "kind": "circle",
        "cx": 0.68,
        "cy": 0.66,
        "r": 0.06
      }
    }
  ],
  "correctHotspotIds": [
    "burgundy"
  ],
  "explanation": {
    "correct": "Burgundy sits in east-central France, south of Champagne, home of Pinot Noir and Chardonnay.",
    "incorrect": "Burgundy is east-central France, between Champagne to the north and the Rhône to the south.",
    "sayThisLine": "Burgundy is east of the Loire, right?"
  }
}
```

**Sample 3** (lesson `label-01`)

```json
{
  "prompt": "Tap the vintage year on this label.",
  "diagram": {
    "diagramId": "generic-wine-label",
    "aspectRatio": 0.75,
    "alt": "A fictional wine label showing a made-up producer name, a grape name, a year, the region and the ABV."
  },
  "hotspots": [
    {
      "id": "producer",
      "label": "Producer",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.15,
        "r": 0.08
      }
    },
    {
      "id": "grape",
      "label": "Grape",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.35,
        "r": 0.08
      }
    },
    {
      "id": "year",
      "label": "Vintage year",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.52,
        "r": 0.08
      }
    },
    {
      "id": "region",
      "label": "Region",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.7,
        "r": 0.08
      }
    },
    {
      "id": "abv",
      "label": "Alcohol",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.9,
        "r": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "year"
  ],
  "explanation": {
    "correct": "The vintage is the harvest year of the grapes, not the year of bottling. It shows how the season affected the wine.",
    "incorrect": "Look for the four-digit year. That is the vintage, the year the grapes were harvested.",
    "sayThisLine": "Is it from a good vintage?"
  }
}
```

Diagram needs: `wine-glass-anatomy`, `map-france-wine-regions`, `generic-wine-label` drawn natively to the anchor coordinates above (the coordinates are the canonical positions; the map outline is stylized, not cartographic).


### 2.12 `talk-track`

See section 4 (eight complete payloads).


### 2.13 `timing-tap`

Not used. Wine appreciation has no one-dimensional timing skill; tasting is slow by design and pressure would push the wrong behavior.


## 3. Playbook terms (74)

Definition plus an example line in an enthusiast's voice. Plain words, no jargon in the definition.

| Term | Definition | Example line |
|---|---|---|
| ABV | Alcohol by volume: the percentage of the liquid that is alcohol | "It's only nine percent ABV, so it's light." |
| Acidity | The mouthwatering freshness in wine | "I love the acidity on this one." |
| Tannin | The drying, grippy feel from grape skins, seeds, stems and oak | "Big tannins, but it softens with food." |
| Body | The weight of a wine in the mouth, from light to full | "Light body, so it's easy on a warm night." |
| Finish | How long the flavor lasts after you swallow or spit | "Long finish. It just keeps going." |
| Balance | When acid, tannin, sugar, alcohol and fruit fit together | "Nothing sticks out. It's balanced." |
| Complexity | Many different aromas and flavors that change in the glass | "It's so complex, new notes every minute." |
| Residual sugar | Sugar left in the wine after fermentation | "Bone dry, almost no residual sugar." |
| Dry | A wine with little or no perceptible sugar | "I like my whites dry." |
| Off-dry | A wine with a touch of sweetness | "Off-dry Riesling is perfect with spice." |
| Vintage | The year the grapes were harvested | "2019 was a great vintage there." |
| Non-vintage (NV) | A blend from several years, common in Champagne | "The NV is the house style." |
| Varietal | A wine named for its main grape | "Is this a varietal Pinot?" |
| Appellation | A legally defined wine region with rules | "It's from a tiny appellation." |
| Terroir | The idea that place (soil, climate, slope) shapes the wine | "That's terroir talking." |
| Cuvée | A particular blend or batch of wine | "Their top cuvée is only made in good years." |
| Cru | A classified vineyard or growth, especially in France | "A Premier Cru from a good slope." |
| Château | A wine estate, especially in Bordeaux | "Which château is it from?" |
| Domaine | A wine estate, especially in Burgundy | "A small domaine, family-run." |
| Sommelier | A trained wine professional, often in restaurants | "Let's ask the sommelier." |
| Decant | Pour wine into another vessel to separate sediment or add air | "I'll decant it an hour ahead." |
| Sediment | Harmless solids that settle in older wines | "There's sediment, so pour slowly." |
| Corked | A wine spoiled by a cork-related taint (TCA), smelling of damp cardboard | "I think it's corked." |
| Cork taint (TCA) | The chemical compound behind the corked smell | "One whiff of TCA and the fruit is gone." |
| Oxidized | A wine that has met too much air, tasting flat or nutty | "It tastes oxidized, like bruised apple." |
| Reduction | A sulfur-like, struck-match or rubber smell from too little air | "A little reduction. Give it some air." |
| Brett | Short for Brettanomyces, a yeast that adds barnyard, leather or smoky notes | "A bit of brett gives it that funk." |
| Sulfites | Compounds that occur naturally and are often added to protect wine | "Nearly every wine contains sulfites." |
| Malolactic | A step that turns sharp malic acid into softer lactic acid | "It went through malolactic, so it's buttery." |
| Lees | The dead yeast cells that settle after fermentation | "Aged on the lees for texture." |
| Maceration | Soaking juice on grape skins to extract color and tannin | "Long maceration, so it's deep and grippy." |
| Skin contact | When white grapes ferment with their skins | "Skin contact gives it that amber color." |
| Orange wine | White wine made with skin contact | "She's into orange wine now." |
| Natural wine | Wine made with minimal intervention, with no single legal definition | "It's natural, so it's a bit wild." |
| Pét-nat | Pétillant naturel: a lightly sparkling wine bottled before fermentation ends | "A pét-nat with a crown cap." |
| Qvevri | Georgian clay vessels buried underground for fermentation | "Fermented in qvevri, the old Georgian way." |
| Biodynamic | Farming based on a holistic calendar and preparations, beyond organic | "They farm biodynamically." |
| Organic | Grapes grown without synthetic pesticides under certification rules | "Organic grapes, but not necessarily natural winemaking." |
| Veraison | The moment grapes begin to ripen and change color | "Veraison came early this year." |
| Harvest (vendange) | The grape picking season | "We're in the middle of vendange." |
| Oak | Barrels that add vanilla, spice and structure | "Lots of oak, toasty and vanilla." |
| Unoaked | Wine aged without oak, usually in steel | "I prefer an unoaked Chardonnay." |
| Tank method | Second fermentation in a large tank, used for Prosecco | "Tank method keeps it fresh and fruity." |
| Traditional method | Second fermentation in the bottle, used for Champagne | "Made in the traditional method." |
| Brut | A dry sparkling wine, the usual style | "Brut is my go-to." |
| Blanc de blancs | White wine made only from white grapes, usually Chardonnay | "A blanc de blancs, crisp and citrusy." |
| Blanc de noirs | White wine made from dark grapes | "A blanc de noirs, richer and rounder." |
| Dosage | Sugar added to Champagne before final corking | "Low dosage, so it's very dry." |
| Fortified | Wine with added spirit, like Port and Sherry | "Port is a fortified wine." |
| Solera | A fractional blending system used for Sherry | "A solera keeps the style consistent." |
| Riserva / Reserva | Aging terms that vary by country and mean little in some countries | "Reserva in Rioja has legal rules." |
| DOCG / DOC | Italy's quality classifications | "A DOCG wine from Piedmont." |
| AOC / AOP | France's protected place-of-origin system | "It's an AOP, so there are rules." |
| AVA | American Viticultural Area, a US wine region | "It's from a small AVA in Oregon." |
| Prädikat | German ripeness levels such as Kabinett and Spätlese | "A Spätlese is richer than Kabinett." |
| Trocken | German for dry | "Trocken, so this won't be sweet." |
| Grand Cru | The top rung of the Burgundy vineyard ladder | "A Grand Cru, so rare and pricey." |
| Climat | A named vineyard plot in Burgundy | "Each climat tastes a little different." |
| Left Bank / Right Bank | Bordeaux sides: Cabernet-led vs Merlot-led | "Right Bank, so more Merlot." |
| Super Tuscan | A Tuscan red breaking the rules with non-traditional grapes | "A Super Tuscan from the 70s wave." |
| Appassimento | Drying grapes before fermentation, as in Amarone | "Amarone uses appassimento for richness." |
| En primeur | Buying wine as futures before it is bottled | "They bought Bordeaux en primeur." |
| Provenance | The documented history of a bottle's storage and ownership | "Provenance matters for old bottles." |
| Corkage | A fee restaurants charge to open a bottle you brought | "There's a twenty-dollar corkage." |
| By the glass (BTG) | Wines sold per glass | "Let's do by the glass tonight." |
| Markup | The restaurant's price above retail | "The markup on the big names is steep." |
| Sommelier pick | A guide's or sommelier's recommendation in a restaurant | "What's the sommelier's pick with the fish?" |
| Mouthfeel | The texture of a wine, such as silky, creamy or grippy | "The mouthfeel is so silky." |
| Nose | The smell of a wine | "Lovely nose of pear and flowers." |
| Palate | What you taste and feel in the mouth | "A lean palate, so crisp." |
| Legs / tears | Streaks on the glass after swirling; they say little about quality | "Look at those legs." (Fun to say, tells you little.) |
| Flight | A set of small pours for comparing wines | "Let's do a flight of three Pinots." |
| Blend | A wine made from several grapes or batches | "It's a GSM blend." |
| Zero-proof / NoLo | Wines with no or low alcohol | "Do you have a zero-proof option?" |

The full concept list (about 300 concept ids in CDS section 11) needs Playbook entries at curriculum authoring; 74 are drafted here.


## 4. Talk Track scenarios (8)

Each scenario: setting, her opening line, what it means, three replies (good, meh, cringe) with coach notes, and a full `talk-track` payload that validates against `talk-track.schema.json`. Voice: warm, playful, never about her; the coach rewards curiosity, honesty and respecting her choices over bluffing or pushing drinks.


### 4.1 "She loves this bottle" (`tt-love-this-bottle`)

- **Setting:** She pours a glass and lights up.
- **Her line:** "This is my favorite Riesling. It's so zippy but not sweet."
- **Meaning:** She loves a particular Riesling and wants to be asked about it.
- **Replies:** Good: "Zippy, like the acidity? What do you like about that?" (You used her word and asked for more. Nice.) Meh: "That sounds lovely." (Kind, but closed. Follow up next time.) Cringe: "Oh yeah, Rieslings are all the same." (Do not bluff and generalize. Ask instead.)

```json
{
  "title": "She loves this bottle",
  "setting": "She pours a glass and lights up.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "This is my favorite Riesling. It's so zippy but not sweet.",
      "replies": [
        {
          "id": "ask-zippy",
          "text": "Zippy, like the acidity? What do you like about that?",
          "smoothDelta": 22,
          "theirResponse": "Yes! The acidity makes it feel alive. I love that you noticed that word.",
          "coachNote": "You used her word and asked for more. Nice."
        },
        {
          "id": "faking",
          "text": "Oh yeah, Rieslings are all the same.",
          "smoothDelta": -18,
          "theirResponse": "Hm, not really. There's a huge range.",
          "coachNote": "Do not bluff and generalize. Ask instead."
        },
        {
          "id": "nice",
          "text": "That sounds lovely.",
          "smoothDelta": 4,
          "theirResponse": "It is.",
          "coachNote": "Kind, but closed. Follow up next time."
        }
      ]
    },
    {
      "theirMessage": "It's from the Mosel. The slate soil gives it this stony thing.",
      "replies": [
        {
          "id": "stony",
          "text": "What does stony taste like to you?",
          "smoothDelta": 20,
          "theirResponse": "Like licking a wet rock. Cold, clean. I can't describe it better.",
          "coachNote": "A curious, specific question. She gets to describe."
        },
        {
          "id": "taste",
          "text": "Can I try a sip? I'd love to know what you mean.",
          "smoothDelta": 16,
          "theirResponse": "Of course. Tell me what you get.",
          "coachNote": "Warm and honest, if she's offering."
        },
        {
          "id": "soil-tastes",
          "text": "Soil tastes like stone? That's not real.",
          "smoothDelta": -14,
          "theirResponse": "Some people debate it. But I still taste it.",
          "coachNote": "Skepticism is fine, but not as a dismissal."
        }
      ]
    }
  ],
  "closingNote": "'What do you like about it?' beats any fact you could recite."
}
```


### 4.2 "She hands you the list" (`tt-wine-list`)

- **Setting:** At a restaurant, she slides the wine list to you.
- **Her line:** "You pick tonight. I don't mind what."
- **Meaning:** She is handing the decision over and is open to a shared choice.
- **Replies:** Good: "Honestly I'm not sure. Want to tell me what you like and we pick together?" (Honest and shared. She feels included.) Meh: "Let's ask the server for a bottle around $60 that suits fish." (A budget and the food is the right pair of facts.) Cringe: "I'll go with something big and red. Cab, obviously." (Bluffing without asking what's on the table is a miss.)

```json
{
  "title": "She hands you the list",
  "setting": "At a restaurant, she slides the wine list to you.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "You pick tonight. I don't mind what.",
      "replies": [
        {
          "id": "honest",
          "text": "Honestly I'm not sure. Want to tell me what you like and we pick together?",
          "smoothDelta": 22,
          "theirResponse": "I love that. I usually like dry whites, something crisp.",
          "coachNote": "Honest and shared. She feels included."
        },
        {
          "id": "bluff",
          "text": "I'll go with something big and red. Cab, obviously.",
          "smoothDelta": -14,
          "theirResponse": "Okay, bold. We're having fish, but sure.",
          "coachNote": "Bluffing without asking what's on the table is a miss."
        },
        {
          "id": "ask-server",
          "text": "Let's ask the server for a bottle around $60 that suits fish.",
          "smoothDelta": 18,
          "theirResponse": "Good idea. Let's do that.",
          "coachNote": "A budget and the food is the right pair of facts."
        }
      ]
    },
    {
      "theirMessage": "The server says it's a Muscadet. Do you know it?",
      "replies": [
        {
          "id": "dont",
          "text": "Not really. Isn't it a Loire white?",
          "smoothDelta": 15,
          "theirResponse": "Yes, crisp, good with oysters and fish. Perfect.",
          "coachNote": "You shared a guess and stayed open."
        },
        {
          "id": "fake",
          "text": "Sure, it's one of my favorites.",
          "smoothDelta": -18,
          "theirResponse": "Oh nice. Which producer?",
          "coachNote": "Claiming what you don't know can get found out."
        },
        {
          "id": "curious",
          "text": "No, what's it like?",
          "smoothDelta": 16,
          "theirResponse": "Crisp, salty, lemony. You'll like it.",
          "coachNote": "Curiosity is attractive."
        }
      ]
    }
  ],
  "closingNote": "Saying 'I'm not sure, let's pick together' is a great line."
}
```


### 4.3 "Orange wine opinions" (`tt-orange-wine`)

- **Setting:** She pours an amber wine and explains it.
- **Her line:** "Skin-contact white. Some people hate it. I find it fascinating."
- **Meaning:** She is into a divisive style and wants you to be curious, not judge.
- **Replies:** Good: "What do you find fascinating about it?" (A curious question that gives her space.) Meh: "Can I try? I've never had one." (Honest and open.) Cringe: "I heard those are just faulty wine." (A debate to engage with, not to win.)

```json
{
  "title": "Orange wine opinions",
  "setting": "She pours an amber wine and explains it.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Skin-contact white. Some people hate it. I find it fascinating.",
      "replies": [
        {
          "id": "why",
          "text": "What do you find fascinating about it?",
          "smoothDelta": 22,
          "theirResponse": "The texture. It has tannin like a red but tastes like a white.",
          "coachNote": "A curious question that gives her space."
        },
        {
          "id": "hate",
          "text": "I heard those are just faulty wine.",
          "smoothDelta": -16,
          "theirResponse": "Some are, sure. But not all of them.",
          "coachNote": "A debate to engage with, not to win."
        },
        {
          "id": "try",
          "text": "Can I try? I've never had one.",
          "smoothDelta": 15,
          "theirResponse": "Of course. Tell me what you get.",
          "coachNote": "Honest and open."
        }
      ]
    },
    {
      "theirMessage": "It's a fun argument. Natural wine people can be intense.",
      "replies": [
        {
          "id": "both",
          "text": "I like that you like it. Can you tell me your favorite kind?",
          "smoothDelta": 20,
          "theirResponse": "Probably a Georgian one fermented in clay.",
          "coachNote": "You're curious about her, not her camp."
        },
        {
          "id": "snob",
          "text": "Natural wine is a scam.",
          "smoothDelta": -18,
          "theirResponse": "Wow. Okay.",
          "coachNote": "Do not scoff at her interest."
        },
        {
          "id": "ask-intense",
          "text": "What makes people intense about it?",
          "smoothDelta": 14,
          "theirResponse": "Half the fight is whether it counts as a fault or a style.",
          "coachNote": "A fair question."
        }
      ]
    }
  ],
  "closingNote": "You don't need a side. Curiosity beats taking a side."
}
```


### 4.4 "She is skipping tonight" (`tt-not-drinking`)

- **Setting:** At her place with a bottle you brought.
- **Her line:** "I'm not drinking tonight, but you go ahead."
- **Meaning:** She is skipping alcohol tonight; the test is how easy you make it.
- **Replies:** Good: "Totally fine. What would you like? I brought sparkling water too." (She will remember how easy you made it.) Meh: "Oh no, why not?" (Reasons are private.) Cringe: "Come on, one glass." (Never push.)

```json
{
  "title": "She is skipping tonight",
  "setting": "At her place with a bottle you brought.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I'm not drinking tonight, but you go ahead.",
      "replies": [
        {
          "id": "easy",
          "text": "Totally fine. What would you like? I brought sparkling water too.",
          "smoothDelta": 24,
          "theirResponse": "You are sweet. Sparkling water with lime would be great.",
          "coachNote": "She will remember how easy you made it."
        },
        {
          "id": "why",
          "text": "Oh no, why not?",
          "smoothDelta": -12,
          "theirResponse": "Just not tonight.",
          "coachNote": "Reasons are private."
        },
        {
          "id": "pressure",
          "text": "Come on, one glass.",
          "smoothDelta": -20,
          "theirResponse": "I said no, thanks.",
          "coachNote": "Never push."
        }
      ]
    },
    {
      "theirMessage": "You can still open yours. Tell me what you like about it.",
      "replies": [
        {
          "id": "small",
          "text": "Maybe a small pour. Want to smell it with me?",
          "smoothDelta": 16,
          "theirResponse": "Sure, smell is most of the fun anyway.",
          "coachNote": "You found a way to share the moment."
        },
        {
          "id": "skip",
          "text": "I'll wait so we're both on water.",
          "smoothDelta": 14,
          "theirResponse": "That is kind, but open it if you want.",
          "coachNote": "Kind and considerate, and she is grateful."
        },
        {
          "id": "chug",
          "text": "I'll just drink it all then.",
          "smoothDelta": -18,
          "theirResponse": "Please don't.",
          "coachNote": "Never treat a bottle as something to finish."
        }
      ]
    }
  ],
  "closingNote": "When someone says no, yes to her is the good answer."
}
```


### 4.5 "At the tasting room" (`tt-tasting-room`)

- **Setting:** You're at a small winery with her.
- **Her line:** "I love that they let you taste the barrel sample."
- **Meaning:** She enjoys the small details of tasting and wants a curious companion.
- **Replies:** Good: "What's different about a barrel sample?" (A specific why-question. Good.) Meh: "Cool." (Friendly but closed.) Cringe: "Can we just buy something and go?" (Do not rush her joy.)

```json
{
  "title": "At the tasting room",
  "setting": "You're at a small winery with her.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I love that they let you taste the barrel sample.",
      "replies": [
        {
          "id": "barrel",
          "text": "What's different about a barrel sample?",
          "smoothDelta": 20,
          "theirResponse": "It's still developing, so it's rougher, but you can taste where it's going.",
          "coachNote": "A specific why-question. Good."
        },
        {
          "id": "fine",
          "text": "Cool.",
          "smoothDelta": 2,
          "theirResponse": "Yeah.",
          "coachNote": "Friendly but closed."
        },
        {
          "id": "rush",
          "text": "Can we just buy something and go?",
          "smoothDelta": -15,
          "theirResponse": "Okay, let's go.",
          "coachNote": "Do not rush her joy."
        }
      ]
    },
    {
      "theirMessage": "Their Pinot is delicate. The Syrah is way bolder.",
      "replies": [
        {
          "id": "body",
          "text": "Is that because of the grapes or the climate?",
          "smoothDelta": 20,
          "theirResponse": "Both. Pinot has thin skins and likes cooler sites.",
          "coachNote": "A smart question you can follow."
        },
        {
          "id": "spit",
          "text": "I'll use the spit cup between pours so I can keep tasting.",
          "smoothDelta": 16,
          "theirResponse": "Smart. Good idea.",
          "coachNote": "Responsible and expert-like."
        },
        {
          "id": "drink-all",
          "text": "Let's do every pour they have.",
          "smoothDelta": -16,
          "theirResponse": "Maybe slow down a bit.",
          "coachNote": "Tasting is small, slow and optional."
        }
      ]
    }
  ],
  "closingNote": "Good tasters ask, sip small and spit."
}
```


### 4.6 "Choosing a bottle as a gift" (`tt-gift-bottle`)

- **Setting:** You're buying a bottle for her birthday.
- **Her line:** "What's a good bottle to get someone who likes Pinot Noir?"
- **Meaning:** You are choosing a gift and need to learn her taste.
- **Replies:** Good: "What has she loved lately, and what is your budget?" (Gift choices start with her taste.) Meh: "She mentioned she likes lighter reds. Could you recommend one?" (You listened and shared it.) Cringe: "Just get the most expensive one." (Price is not taste.)

```json
{
  "title": "Choosing a bottle as a gift",
  "setting": "You're buying a bottle for her birthday.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "What's a good bottle to get someone who likes Pinot Noir?",
      "replies": [
        {
          "id": "ask-her",
          "text": "What has she loved lately, and what is your budget?",
          "smoothDelta": 20,
          "theirResponse": "Ah, that helps. A Willamette Pinot or Burgundy then.",
          "coachNote": "Gift choices start with her taste."
        },
        {
          "id": "expensive",
          "text": "Just get the most expensive one.",
          "smoothDelta": -16,
          "theirResponse": "That's not always better.",
          "coachNote": "Price is not taste."
        },
        {
          "id": "what-she-said",
          "text": "She mentioned she likes lighter reds. Could you recommend one?",
          "smoothDelta": 18,
          "theirResponse": "Yes! Try a Pinot from Oregon.",
          "coachNote": "You listened and shared it."
        }
      ]
    },
    {
      "theirMessage": "Want a bottle of something sparkling too?",
      "replies": [
        {
          "id": "yes",
          "text": "Yes, she would love that. Also a nice zero-proof option in case she's skipping.",
          "smoothDelta": 20,
          "theirResponse": "Thoughtful.",
          "coachNote": "Options for her, without assumptions."
        },
        {
          "id": "no",
          "text": "No, only red.",
          "smoothDelta": 2,
          "theirResponse": "Okay.",
          "coachNote": "Fine, but consider options."
        },
        {
          "id": "case",
          "text": "Give me a case.",
          "smoothDelta": -14,
          "theirResponse": "That is a lot.",
          "coachNote": "Quantity is not thoughtfulness."
        }
      ]
    }
  ],
  "closingNote": "Listening to her taste is the gift."
}
```


### 4.7 "Is expensive wine better?" (`tt-price-myths`)

- **Setting:** Over dinner she mentions a pricey bottle she tried.
- **Her line:** "I tried a $200 Burgundy. It was nice, but I liked my $30 one more."
- **Meaning:** She is sharing a value opinion and inviting an honest chat.
- **Replies:** Good: "Interesting! What did you like more about the $30 one?" (Pleasure over price.) Meh: "I read that blind tastings often don't match price." (A fact offered gently.) Cringe: "So you wasted $200." (Do not judge her spending.)

```json
{
  "title": "Is expensive wine better?",
  "setting": "Over dinner she mentions a pricey bottle she tried.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I tried a $200 Burgundy. It was nice, but I liked my $30 one more.",
      "replies": [
        {
          "id": "curious",
          "text": "Interesting! What did you like more about the $30 one?",
          "smoothDelta": 22,
          "theirResponse": "It was easier to drink and fruitier.",
          "coachNote": "Pleasure over price."
        },
        {
          "id": "wasted",
          "text": "So you wasted $200.",
          "smoothDelta": -16,
          "theirResponse": "No, it was a great experience.",
          "coachNote": "Do not judge her spending."
        },
        {
          "id": "myth",
          "text": "I read that blind tastings often don't match price.",
          "smoothDelta": 14,
          "theirResponse": "Yes! And yet price can also mean rarity.",
          "coachNote": "A fact offered gently."
        }
      ]
    },
    {
      "theirMessage": "Part of the price is scarcity, not flavor.",
      "replies": [
        {
          "id": "scarcity",
          "text": "Right, tiny vineyards and high demand. That makes sense.",
          "smoothDelta": 18,
          "theirResponse": "Exactly.",
          "coachNote": "You connected cost drivers."
        },
        {
          "id": "cheap",
          "text": "So I'll just drink cheap wine forever.",
          "smoothDelta": -6,
          "theirResponse": "There are good cheap wines too!",
          "coachNote": "Fine, but she'd love to hear curiosity."
        },
        {
          "id": "ask",
          "text": "How do you find good value bottles?",
          "smoothDelta": 20,
          "theirResponse": "Lesser-known regions and grapes.",
          "coachNote": "A great question to ask."
        }
      ]
    }
  ],
  "closingNote": "Price tells you about cost, not about your enjoyment."
}
```


### 4.8 "Talking to the sommelier" (`tt-sommelier`)

- **Setting:** A nice restaurant with a sommelier.
- **Her line:** "Good evening. Are you looking for something in particular?"
- **Meaning:** A professional is offering help and will respond to clear asks.
- **Replies:** Good: "We like dry whites and want to stay around $70." (Budget and taste in one sentence.) Meh: "Just the house white." (Fine, but you can ask for more.) Cringe: "Whatever's best." (Vague requests are hard to help.)

```json
{
  "title": "Talking to the sommelier",
  "setting": "A nice restaurant with a sommelier.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Good evening. Are you looking for something in particular?",
      "replies": [
        {
          "id": "budget",
          "text": "We like dry whites and want to stay around $70.",
          "smoothDelta": 24,
          "theirResponse": "Perfect. I have a few ideas.",
          "coachNote": "Budget and taste in one sentence."
        },
        {
          "id": "impress",
          "text": "Whatever's best.",
          "smoothDelta": -12,
          "theirResponse": "Best is subjective. Could you tell me more?",
          "coachNote": "Vague requests are hard to help."
        },
        {
          "id": "silent",
          "text": "Just the house white.",
          "smoothDelta": 4,
          "theirResponse": "Of course.",
          "coachNote": "Fine, but you can ask for more."
        }
      ]
    },
    {
      "theirMessage": "I'd suggest this Grüner Veltliner. Crisp, peppery, great with your dish.",
      "replies": [
        {
          "id": "ask",
          "text": "Peppery? Is that typical for the grape?",
          "smoothDelta": 20,
          "theirResponse": "Yes, white pepper notes are a Grüner signature.",
          "coachNote": "A specific question."
        },
        {
          "id": "fake",
          "text": "Oh, Grüner, I know it well.",
          "smoothDelta": -16,
          "theirResponse": "Wonderful. Which producer do you prefer?",
          "coachNote": "A bluff gets found out."
        },
        {
          "id": "yes",
          "text": "That sounds perfect.",
          "smoothDelta": 10,
          "theirResponse": "Wonderful.",
          "coachNote": "Polite and confident."
        }
      ]
    }
  ],
  "closingNote": "Sommeliers love curious guests with a clear budget."
}
```


## 5. Talk Track roster at launch (20)

The eight above plus: `tt-mosel-slate` (terroir curiosity), `tt-birthday-toast` (short sincere toast), `tt-natural-debate` (two friends argue), `tt-brunch-bubbles` (Champagne vs Prosecco), `tt-wine-class` (her WSET class), `tt-cheese-night` (pairing she planned), `tt-restaurant-byo` (corkage), `tt-vacation-vineyard` (her trip story), `tt-dry-january` (her month off, your support), `tt-hosting-friends` (what to serve, including zero-proof), `tt-bad-bottle` (she thinks it is corked), `tt-holiday-dinner` (family table). All follow the same scoring rules: curiosity and respect add; bluffing, pushing drinks and mocking subtract.

## 6. Asset needs (all `original-swoond`)

- Generic bottle silhouettes (Bordeaux, Burgundy, flute, Champagne), closure icons, glass shapes, glass-tilt color ladders.
- Generic fictional label art for label-reading drills; never a real winery's label, logo or trade dress.
- Procedural maps (France, Italy, Spain, Germany, California, Australia and New Zealand, South America) with stylized outlines and dots.
- Synthesized or in-house pronunciation clips and a sparkling sigh; text alternatives for all.
- Diagrams: wine glass anatomy, bottle anatomy, vine cycle, fermentation flow, tasting wheel (original, not the copyrighted Davis wheel graphic).

## 7. Voice and safety notes

- Jokes target the learner's unfamiliarity and wine's own snobbery, never her taste, her budget or her choice not to drink.
- No exercise frames drinking quantity, speed or tolerance as skill. No drinking games, no "finish the bottle", no challenges.
- No health or nutrition claims (no "healthy", "antioxidants", "low-calorie", "good for the heart"). Items that touch sulfites teach facts about what they are and that some people are sensitive, and tell the learner to ask a clinician, never to diagnose.
- Pregnancy, medication and recovery: items treat "not drinking" as a normal, respected answer (`care-05`, `conv-05`); no item asks why.
- Age gate: all items assume the course is unlocked for a legal-age learner; see CDS section 13 and `NOTES_FOR_ORCHESTRATOR.md`.
- Brands and producers appear only as text facts where a lesson needs them; no label images.
