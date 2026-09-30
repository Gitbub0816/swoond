# Native Exercise Plan: Fashion (`fashion`)

Tier B plan for `docs/courses/fashion/`. **No Tier A (Unity) sims**: see CDS section 12. Sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup when this file was generated). Conventions: prompts <= 12 words; every answer explained; a "say this" line where natural; body-neutral and budget-neutral wording throughout; all image assets `original-swoond`.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite card: terms, history, calendar facts, 'which is true'. Distractors are the classic beginner errors from CDS section 2. | ~260 |
| `binary-call` | Two-way calls on a static example: alteration possible or not, quality cue or flaw, vintage or retro. Scenes use `kind: none` (text description) or an original garment illustration. | ~25 |
| `term-match` | Introduce 3-6 related terms at the start of a lesson (fibers, fit words, house vocabulary) and in Term Blitz reviews. | ~60 |
| `sequence-order` | Processes where order is the concept: fiber to fabric, idea to garment, show to store, drop day. | ~25 |
| `visual-id` | The heart of the course (spec section 18): silhouettes, necklines, sleeves, collars, patterns, eras, sneaker archetypes. Original illustrations only (`original-swoond`); no photos, logos or bodies. Alt text describes distinguishing features without giving away the answer; option-level images allowed for 'which one is X'. | ~120 |
| `decision-scenario` | Judgment: greenwashing claims, thrift strategy, alterations, resale safety, dress codes. Body- and budget-neutral wording; `safetyNote` where scams or claims are involved. | ~55 |
| `talk-track` | Conversation practice: 16 tracks at launch (8 authored below). Replies model curiosity; penalize fake expertise, price talk about someone's clothes, size guesses and body comments. | ~16 |
| `say-this` | Decode what she just said: slang, aesthetics, drop talk, fit frustration. Every item has a `noFakeExpertNote`; follow-ups are honest curiosity. | ~80 |
| `fill-the-gap` | Vocabulary and facts in context; quick review card. | ~50 |
| `estimate-slider` | Garment magnitudes (fabric weight, sleeve length, wears per piece). Never a body measurement. | ~12 |
| `hotspot-tap` | Garment anatomy on procedural flats: shirt, jacket, sneaker, care label. Movement is never needed. | ~50 |
| `timing-tap` | Not used: nothing in fashion is a 1D timing feel. | 0 |
| `listening-id` | Not used: no audio need; reconsider only with original or licensed audio that teaches something. | 0 |
| `unity-sim` | Not used (CDS section 12). | 0 |

Estimated totals: about 760 native items across 120 lessons and the review loop. Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice` and `fill-the-gap`; visual concepts are reviewed with different illustrations each time.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

Default knowledge check and Daily Bite card: terms, history, calendar facts, 'which is true'. Distractors are the classic beginner errors from CDS section 2.

**Sample 1** (lesson `sil-01`)

```json
{
  "prompt": "What does a silhouette describe?",
  "options": [
    {
      "id": "a",
      "text": "The outline of a garment"
    },
    {
      "id": "b",
      "text": "The fabric's price"
    },
    {
      "id": "c",
      "text": "The designer's name"
    },
    {
      "id": "d",
      "text": "The stitch count"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "A silhouette is the overall outline a garment makes, which is why designers often sketch it first.",
    "incorrect": "A silhouette is the outline. Fabric and price matter, but the outline is what you see from across the room.",
    "sayThisLine": "I love the silhouette of that coat."
  }
}
```

**Sample 2** (lesson `fab-03`)

```json
{
  "prompt": "Which fiber is semi-synthetic, made from wood pulp?",
  "options": [
    {
      "id": "a",
      "text": "Viscose"
    },
    {
      "id": "b",
      "text": "Polyester"
    },
    {
      "id": "c",
      "text": "Wool"
    },
    {
      "id": "d",
      "text": "Nylon"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Viscose (rayon) starts as plant cellulose that is chemically processed into fiber, so it sits between natural and synthetic.",
    "incorrect": "Viscose is made from dissolved wood pulp. Polyester and nylon are fully synthetic; wool is a natural animal fiber.",
    "sayThisLine": "Is that viscose or silk? It drapes so nicely."
  }
}
```

**Sample 3** (lesson `cal-01`)

```json
{
  "prompt": "Which city usually closes the big four fashion weeks?",
  "options": [
    {
      "id": "a",
      "text": "Paris"
    },
    {
      "id": "b",
      "text": "New York"
    },
    {
      "id": "c",
      "text": "London"
    },
    {
      "id": "d",
      "text": "Milan"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "The usual order is New York, London, Milan, Paris, with Paris closing the month.",
    "incorrect": "The order is New York, London, Milan, then Paris last. Dates shift a little each season, so check the calendar.",
    "sayThisLine": "Are you watching the Paris shows this year?"
  }
}
```

### 2.2 `binary-call`

Two-way calls on a static example: alteration possible or not, quality cue or flaw, vintage or retro. Scenes use `kind: none` (text description) or an original garment illustration.

**Sample 1** (lesson `fit-04`)

```json
{
  "prompt": "Can a tailor usually take in a shirt's side seams?",
  "scene": {
    "kind": "none",
    "alt": "No diagram. A collared shirt is a little wide through the body."
  },
  "choices": [
    {
      "id": "yes",
      "label": "Usually yes"
    },
    {
      "id": "no",
      "label": "Usually no"
    }
  ],
  "correctChoiceId": "yes",
  "explanation": {
    "correct": "Side seams can normally be taken in on woven shirts.",
    "incorrect": "Taking in side seams is one of the simplest alterations on a woven shirt."
  },
  "ruleTag": "Alterations"
}
```

**Sample 2** (lesson `con-07`)

```json
{
  "prompt": "Patterned seam lines meet up at the side. Quality cue?",
  "scene": {
    "kind": "none",
    "alt": "No diagram. A striped shirt where stripes line up across the side seam."
  },
  "choices": [
    {
      "id": "cue",
      "label": "A good sign"
    },
    {
      "id": "flaw",
      "label": "A flaw"
    }
  ],
  "correctChoiceId": "cue",
  "explanation": {
    "correct": "Matching a pattern across seams takes extra fabric and care, so it often signals attention to construction.",
    "incorrect": "Matched patterns take extra fabric and time to cut, which is why enthusiasts notice them."
  },
  "ruleTag": "Quality cue"
}
```

**Sample 3** (lesson `vin-01`)

```json
{
  "prompt": "A new dress is styled like the 1970s. Is it vintage?",
  "scene": {
    "kind": "none",
    "alt": "No diagram. A brand-new dress with a 1970s look."
  },
  "choices": [
    {
      "id": "vintage",
      "label": "Vintage"
    },
    {
      "id": "retro",
      "label": "Retro or vintage-style"
    }
  ],
  "correctChoiceId": "retro",
  "explanation": {
    "correct": "Vintage means actually made in a past era; new items styled like the past are retro or vintage-style.",
    "incorrect": "Vintage needs age. A new dress in an old style is retro or vintage-style."
  },
  "ruleTag": "Vintage vs retro"
}
```

### 2.3 `term-match`

Introduce 3-6 related terms at the start of a lesson (fibers, fit words, house vocabulary) and in Term Blitz reviews.

**Sample 1** (lesson `fab-02`)

```json
{
  "prompt": "Match the natural fiber to its trait.",
  "pairs": [
    {
      "id": "cotton",
      "term": "Cotton",
      "definition": "Soft, breathable plant fiber that wrinkles easily"
    },
    {
      "id": "linen",
      "term": "Linen",
      "definition": "Crisp plant fiber that dries fast and creases"
    },
    {
      "id": "wool",
      "term": "Wool",
      "definition": "Animal fiber that insulates and resists odor"
    },
    {
      "id": "silk",
      "term": "Silk",
      "definition": "Smooth animal fiber with a natural sheen"
    }
  ],
  "distractorDefinitions": [
    "Man-made fiber from petroleum"
  ],
  "explanation": {
    "summary": "Plant fibers (cotton, linen) breathe; animal fibers (wool, silk) come from sheep and silkworms.",
    "sayThisLine": "I love how linen wrinkles, it feels relaxed."
  }
}
```

**Sample 2** (lesson `fit-01`)

```json
{
  "prompt": "Match the fit word to the cut.",
  "pairs": [
    {
      "id": "slim",
      "term": "Slim fit",
      "definition": "Cut closer to the body with less fabric"
    },
    {
      "id": "regular",
      "term": "Regular fit",
      "definition": "The standard cut, neither tight nor loose"
    },
    {
      "id": "relaxed",
      "term": "Relaxed fit",
      "definition": "Roomier through the body and legs"
    },
    {
      "id": "oversized",
      "term": "Oversized",
      "definition": "Intentionally cut much larger than the size implies"
    }
  ],
  "explanation": {
    "summary": "Fit words describe how a garment is cut, not how a person should look in it."
  }
}
```

**Sample 3** (lesson `hou-03`)

```json
{
  "prompt": "Match the term to what it means.",
  "pairs": [
    {
      "id": "maison",
      "term": "Maison",
      "definition": "French word for a fashion house"
    },
    {
      "id": "cd",
      "term": "Creative director",
      "definition": "Person who sets a house's design direction"
    },
    {
      "id": "atelier",
      "term": "Atelier",
      "definition": "Workshop where garments are made by hand"
    },
    {
      "id": "rtw",
      "term": "Ready-to-wear",
      "definition": "Clothes made in standard sizes for stores"
    }
  ],
  "distractorDefinitions": [
    "A store's clearance rack"
  ],
  "explanation": {
    "summary": "Houses have a name, a creative director and an atelier; ready-to-wear is the part most people can buy."
  }
}
```

### 2.4 `sequence-order`

Processes where order is the concept: fiber to fabric, idea to garment, show to store, drop day.

**Sample 1** (lesson `fab-01`)

```json
{
  "prompt": "Order the journey from fiber to fabric.",
  "items": [
    {
      "id": "fiber",
      "text": "Raw fiber is harvested",
      "why": "Cotton is picked, wool sheared, or a synthetic polymer is made."
    },
    {
      "id": "yarn",
      "text": "Fibers are spun into yarn",
      "why": "Spinning twists short fibers into a continuous thread."
    },
    {
      "id": "fabric",
      "text": "Yarn is woven or knitted into fabric",
      "why": "Interlacing (weave) or looping (knit) makes the cloth."
    },
    {
      "id": "finish",
      "text": "Fabric is dyed and finished",
      "why": "Dye, softening and coatings change color and feel."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Fiber, yarn, fabric, finish: each step changes how the cloth behaves.",
    "incorrect": "Start from the raw material and add structure step by step: fiber, yarn, fabric, finish."
  }
}
```

**Sample 2** (lesson `ind-01`)

```json
{
  "prompt": "Order how a garment goes from idea to shop.",
  "items": [
    {
      "id": "sketch",
      "text": "Designer sketches the idea"
    },
    {
      "id": "pattern",
      "text": "Pattern maker draws the flat pieces",
      "why": "Patterns turn a drawing into cuttable shapes."
    },
    {
      "id": "sample",
      "text": "A sample garment is sewn and fitted",
      "why": "Samples reveal what the drawing hid."
    },
    {
      "id": "grade",
      "text": "The pattern is graded into a size range",
      "why": "Grading scales the pattern across sizes."
    },
    {
      "id": "produce",
      "text": "Factory produces the collection"
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Sketch, pattern, sample, grading, production: each stage fixes problems before the next.",
    "incorrect": "The idea has to become a pattern, then a sample, then a size range, then production."
  }
}
```

**Sample 3** (lesson `cal-05`)

```json
{
  "prompt": "Order a collection's path from runway to store.",
  "items": [
    {
      "id": "design",
      "text": "Collection is designed months ahead"
    },
    {
      "id": "show",
      "text": "Collection is shown on the runway or in a showroom"
    },
    {
      "id": "orders",
      "text": "Buyers place wholesale orders",
      "why": "Stores commit to what they will stock."
    },
    {
      "id": "produce",
      "text": "Pieces are produced"
    },
    {
      "id": "store",
      "text": "Pieces arrive in stores"
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Traditionally: design, show, orders, production, stores, often about six months from show to shelf.",
    "incorrect": "Shows come before orders and production; stores get the clothes last."
  }
}
```

### 2.5 `visual-id`

The heart of the course (spec section 18): silhouettes, necklines, sleeves, collars, patterns, eras, sneaker archetypes. Original illustrations only (`original-swoond`); no photos, logos or bodies. Alt text describes distinguishing features without giving away the answer; option-level images allowed for 'which one is X'.

**Sample 1** (lesson `sil-02`)

```json
{
  "prompt": "Which dress silhouette is this?",
  "image": {
    "asset": "images/fashion/dress-a-line.svg",
    "alt": "Flat-lay dress drawing: fitted at the top, widening steadily from waist to hem in a straight-sided triangle.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "A-line"
    },
    {
      "id": "b",
      "text": "Sheath"
    },
    {
      "id": "c",
      "text": "Empire"
    },
    {
      "id": "d",
      "text": "Wrap"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "It is fitted at the top and flares in a clean triangle from the waist: the A-line.",
    "incorrect": "Look at the sides: they run straight outward from the waist like the letter A. A sheath would stay narrow."
  },
  "cues": [
    "Fitted top",
    "Straight flare from waist"
  ]
}
```

**Sample 2** (lesson `con-02`)

```json
{
  "prompt": "Which neckline is this?",
  "image": {
    "asset": "images/fashion/neckline-boat.svg",
    "alt": "Flat-lay top drawing with a very wide, shallow neckline that runs nearly shoulder to shoulder.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Boat neck"
    },
    {
      "id": "b",
      "text": "Scoop neck"
    },
    {
      "id": "c",
      "text": "V-neck"
    },
    {
      "id": "d",
      "text": "Square neck"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "A boat neck runs wide and shallow across the collarbones, nearly shoulder to shoulder.",
    "incorrect": "The width gives it away: nearly shoulder to shoulder and shallow. A scoop is rounder and deeper."
  },
  "cues": [
    "Wide and shallow",
    "Follows collarbone line"
  ]
}
```

**Sample 3** (lesson `snk-03`)

```json
{
  "prompt": "Which sneaker archetype is this?",
  "image": {
    "asset": "images/fashion/sneaker-chunky-runner.svg",
    "alt": "Line drawing of a low sneaker with a thick layered sole, stacked panels and a rounded, bulky toe.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Chunky trainer"
    },
    {
      "id": "b",
      "text": "Skate shoe"
    },
    {
      "id": "c",
      "text": "Court low"
    },
    {
      "id": "d",
      "text": "Basketball high-top"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Thick layered soles and stacked panels make it a chunky trainer, sometimes called a dad shoe.",
    "incorrect": "A skate shoe is flatter with a grippy thin sole; a court low is slim. This one has a bulky layered sole."
  },
  "cues": [
    "Thick sole",
    "Stacked panels"
  ]
}
```

### 2.6 `decision-scenario`

Judgment: greenwashing claims, thrift strategy, alterations, resale safety, dress codes. Body- and budget-neutral wording; `safetyNote` where scams or claims are involved.

**Sample 1** (lesson `sus-03`)

```json
{
  "prompt": "A tag says 'eco-friendly'. Your friend is curious. What now?",
  "situation": {
    "narrative": "You and a friend are looking at a jacket tag.",
    "facts": [
      {
        "label": "Tag claim",
        "value": "Eco-friendly collection"
      },
      {
        "label": "Detail on tag",
        "value": "No fiber percentages"
      },
      {
        "label": "Certification named",
        "value": "None",
        "emphasis": "warning"
      },
      {
        "label": "Brand page",
        "value": "Vague goals, no dates"
      }
    ]
  },
  "options": [
    {
      "id": "look",
      "label": "Ask what makes it eco-friendly and look for specifics",
      "verdict": "best",
      "consequence": "You learn whether there is a fiber percentage, a named certification or a dated target.",
      "considerations": [
        "Specific claims can be checked",
        "Vague words prove little"
      ]
    },
    {
      "id": "trust",
      "label": "Assume it is fine",
      "verdict": "acceptable",
      "consequence": "You may be right, but you have no evidence either way.",
      "considerations": [
        "Absence of detail is a signal"
      ]
    },
    {
      "id": "mock",
      "label": "Say the whole brand is a scam",
      "verdict": "poor",
      "consequence": "You end the conversation and may be wrong.",
      "considerations": [
        "A vague claim is not proof of bad intent"
      ]
    }
  ],
  "expertNote": "Enthusiasts ask for numbers, names and dates before they judge a claim.",
  "sayThisLine": "What does eco-friendly actually mean here?",
  "safetyNote": "This is a learning scenario about reading claims, not a verdict on any real brand."
}
```

**Sample 2** (lesson `vin-03`)

```json
{
  "prompt": "Racks are packed. What do you check first at the thrift store?",
  "situation": {
    "narrative": "A friend loves thrifting and invited you along.",
    "facts": [
      {
        "label": "Time",
        "value": "45 minutes"
      },
      {
        "label": "Racks",
        "value": "Hundreds of pieces"
      },
      {
        "label": "Tags",
        "value": "Sizes are inconsistent"
      },
      {
        "label": "Goal",
        "value": "Find something she'd love"
      }
    ]
  },
  "options": [
    {
      "id": "fabric",
      "label": "Feel the fabric and check seams and condition",
      "verdict": "best",
      "consequence": "You quickly skip weak pieces and spot good fibers and construction.",
      "considerations": [
        "Fabric and construction matter more than the tag",
        "Size tags vary across decades"
      ]
    },
    {
      "id": "tag",
      "label": "Only look at the size tag",
      "verdict": "acceptable",
      "consequence": "You may miss great pieces sized differently.",
      "considerations": [
        "Sizes vary by brand and era"
      ]
    },
    {
      "id": "brand",
      "label": "Only grab famous brand names",
      "verdict": "poor",
      "consequence": "You skip well-made unbranded pieces and may be misled by fakes.",
      "considerations": [
        "Labels can be faked or misleading"
      ]
    }
  ],
  "expertNote": "Experienced thrifters scan by fabric first, then check measurements and flaws, not the tag size.",
  "sayThisLine": "What do you look at first when you thrift?"
}
```

**Sample 3** (lesson `fit-04`)

```json
{
  "prompt": "Sleeves run long, shoulders fit. What helps?",
  "situation": {
    "narrative": "A friend asks how alterations work.",
    "facts": [
      {
        "label": "Shoulders",
        "value": "Fit well"
      },
      {
        "label": "Sleeve length",
        "value": "About 1 inch long"
      },
      {
        "label": "Fabric",
        "value": "Wool blend"
      }
    ]
  },
  "options": [
    {
      "id": "tailor",
      "label": "Ask a tailor to shorten the sleeves",
      "verdict": "best",
      "consequence": "Sleeve shortening is a common alteration and keeps the shoulders as they are.",
      "considerations": [
        "Shoulders are hard to alter; sleeves usually are not"
      ]
    },
    {
      "id": "shoulder",
      "label": "Ask to rebuild the shoulders",
      "verdict": "poor",
      "consequence": "Shoulder rebuilds are complex and expensive; the shoulders were already fine.",
      "considerations": [
        "Change only what needs changing"
      ]
    },
    {
      "id": "skip",
      "label": "Wear it as is and decide it is the jacket's fault",
      "verdict": "acceptable",
      "consequence": "It is fine if she likes the look, but a simple alteration was available.",
      "considerations": [
        "Fit is a garment problem, not a personal one"
      ]
    }
  ],
  "expertNote": "Tailors treat garments, not bodies: the question is which part of the garment to adjust."
}
```

### 2.7 `say-this`

Decode what she just said: slang, aesthetics, drop talk, fit frustration. Every item has a `noFakeExpertNote`; follow-ups are honest curiosity.

**Sample 1** (lesson `sty-05`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "It's giving quiet luxury, no logos, just insane fabric."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "An understated, logo-free aesthetic",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Fabric quality as the main point",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "A loud, logo-heavy outfit",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "A very cheap item",
      "isCorrect": false
    }
  ],
  "translation": "She likes clothes that whisper rather than shout: simple shapes, no visible branding, and great materials.",
  "followUps": [
    {
      "line": "Is it the way the fabric drapes?",
      "why": "Shows you know fabric is the point without pretending to identify it."
    }
  ],
  "noFakeExpertNote": "You can say you have heard the term without claiming to know exactly which brands count."
}
```

**Sample 2** (lesson `snk-04`)

```json
{
  "statement": {
    "speaker": "Jordan",
    "text": "Missed the drop again, bots ate the raffle."
  },
  "question": "What happened?",
  "options": [
    {
      "id": "a",
      "text": "A limited release sold out",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Automated software beat human entries",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "The shoes were recalled",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "A store closed forever",
      "isCorrect": false
    }
  ],
  "translation": "A limited release sold out almost instantly, and automated buying programs (bots) crowded out real people in the entry lottery.",
  "followUps": [
    {
      "line": "Is there a release you're still hoping for?",
      "why": "Acknowledges the frustration and shifts to what she wants."
    }
  ],
  "noFakeExpertNote": "Ask how raffles work instead of guessing; enthusiasts love explaining it."
}
```

**Sample 3** (lesson `fit-03`)

```json
{
  "statement": {
    "speaker": "Ren",
    "text": "I'm a different size in every brand, I just get everything tailored."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "Sizes vary between brands",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "She alters clothes to fit",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "Her body changes every week",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "She only buys custom shoes",
      "isCorrect": false
    }
  ],
  "translation": "Size labels are not standardized, so she treats them as rough guides and adjusts the garment with a tailor.",
  "followUps": [
    {
      "line": "What's the alteration that helps the most?",
      "why": "Curious about the process, not her body."
    }
  ],
  "noFakeExpertNote": "Never comment on her size or shape. The garment is the subject."
}
```

### 2.8 `fill-the-gap`

Vocabulary and facts in context; quick review card.

**Sample 1** (lesson `fab-04`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "A {{a}} fabric is made of yarns crossing at right angles, while a {{b}} is made of interlocking loops.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "woven",
        "knit",
        "printed"
      ],
      "correct": "woven"
    },
    {
      "id": "b",
      "options": [
        "knit",
        "woven"
      ],
      "correct": "knit"
    }
  ],
  "explanation": {
    "correct": "Woven fabrics interlace yarns; knits loop them, which is why knits stretch more.",
    "incorrect": "Woven means interlaced at right angles; knit means looped, which gives stretch."
  }
}
```

**Sample 2** (lesson `cal-02`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "Fall/winter shows happen in {{a}}, and spring/summer shows happen in {{b}}.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "February and March",
        "June and July",
        "November"
      ],
      "correct": "February and March"
    },
    {
      "id": "b",
      "options": [
        "September and October",
        "January",
        "April"
      ],
      "correct": "September and October"
    }
  ],
  "explanation": {
    "correct": "Shows are months ahead: fall/winter in Feb-Mar, spring/summer in Sep-Oct.",
    "incorrect": "Shows come well before the season: fall/winter in February and March, spring/summer in September and October."
  }
}
```

**Sample 3** (lesson `vin-01`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "Clothing is usually called {{a}} when it is roughly {{b}} years old or more.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "vintage",
        "antique",
        "retro"
      ],
      "correct": "vintage"
    },
    {
      "id": "b",
      "options": [
        "20",
        "5",
        "100"
      ],
      "correct": "20"
    }
  ],
  "explanation": {
    "correct": "By common convention, vintage means about 20 years or older; retro means new items styled like the past.",
    "incorrect": "Vintage is about 20 years or more; retro means new but old-style; antique usually means 100 years or older."
  }
}
```

### 2.9 `estimate-slider`

Garment magnitudes (fabric weight, sleeve length, wears per piece). Never a body measurement.

**Sample 1** (lesson `vin-06`)

```json
{
  "prompt": "How many inches is a typical men's shirt sleeve length?",
  "unit": "inches",
  "min": 20,
  "max": 40,
  "step": 1,
  "correctValue": 34,
  "tolerance": {
    "full": 2,
    "partial": 4
  },
  "explanation": {
    "correct": "Shirt sleeves often measure roughly 32 to 36 inches, from the neck to the cuff.",
    "incorrect": "Sleeve lengths run about 32 to 36 inches on typical men's dress shirts; measurements differ by brand."
  }
}
```

**Sample 2** (lesson `fab-07`)

```json
{
  "prompt": "About how many ounces per square yard is heavyweight denim?",
  "unit": "oz",
  "min": 6,
  "max": 24,
  "step": 1,
  "correctValue": 14,
  "tolerance": {
    "full": 2,
    "partial": 4
  },
  "explanation": {
    "correct": "Around 12 to 16 oz is heavy; light denim is closer to 8 oz.",
    "incorrect": "Heavier denim is roughly 12 to 16 ounces per square yard. Weight changes how it wears and softens."
  }
}
```

**Sample 3** (lesson `sus-06`)

```json
{
  "prompt": "How many wears might a loved jacket see?",
  "unit": "wears",
  "min": 0,
  "max": 500,
  "step": 10,
  "correctValue": 100,
  "tolerance": {
    "full": 50,
    "partial": 150
  },
  "explanation": {
    "correct": "Around 100 wears is a common illustration for a well-loved piece; cost per wear is just division.",
    "incorrect": "The number is illustrative: many well-loved pieces are worn dozens to hundreds of times. It is not a target."
  }
}
```

### 2.10 `hotspot-tap`

Garment anatomy on procedural flats: shirt, jacket, sneaker, care label. Movement is never needed.

**Sample 1** (lesson `con-01`)

```json
{
  "prompt": "Tap the collar.",
  "diagram": {
    "diagramId": "fashion-shirt-anatomy",
    "aspectRatio": 1.0,
    "alt": "Flat-lay of a button-up shirt with labelled zones: neckband collar, front placket, yoke across the upper back, cuff and hem."
  },
  "hotspots": [
    {
      "id": "collar",
      "label": "Collar",
      "shape": {
        "kind": "rect",
        "x": 0.35,
        "y": 0.05,
        "w": 0.3,
        "h": 0.12
      }
    },
    {
      "id": "placket",
      "label": "Placket",
      "shape": {
        "kind": "rect",
        "x": 0.46,
        "y": 0.2,
        "w": 0.08,
        "h": 0.6
      }
    },
    {
      "id": "cuff",
      "label": "Cuff",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.7,
        "w": 0.14,
        "h": 0.1
      }
    },
    {
      "id": "hem",
      "label": "Hem",
      "shape": {
        "kind": "rect",
        "x": 0.25,
        "y": 0.88,
        "w": 0.5,
        "h": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "collar"
  ],
  "explanation": {
    "correct": "The collar frames the neck and is the most visible detail on a shirt.",
    "incorrect": "The collar sits at the neck. The placket is the strip with buttons down the front."
  }
}
```

**Sample 2** (lesson `brm-01`)

```json
{
  "prompt": "Tap the lapel.",
  "diagram": {
    "diagramId": "fashion-jacket-anatomy",
    "aspectRatio": 1.0,
    "alt": "Flat-lay of a tailored jacket with zones: lapel, pocket flap, sleeve cuff, back vent."
  },
  "hotspots": [
    {
      "id": "lapel",
      "label": "Lapel",
      "shape": {
        "kind": "rect",
        "x": 0.3,
        "y": 0.1,
        "w": 0.15,
        "h": 0.3
      }
    },
    {
      "id": "pocket",
      "label": "Pocket",
      "shape": {
        "kind": "rect",
        "x": 0.55,
        "y": 0.55,
        "w": 0.2,
        "h": 0.08
      }
    },
    {
      "id": "cuff",
      "label": "Sleeve cuff",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.75,
        "w": 0.12,
        "h": 0.1
      }
    },
    {
      "id": "vent",
      "label": "Vent",
      "shape": {
        "kind": "rect",
        "x": 0.45,
        "y": 0.85,
        "w": 0.1,
        "h": 0.12
      }
    }
  ],
  "correctHotspotIds": [
    "lapel"
  ],
  "explanation": {
    "correct": "The lapel is the folded-back front edge of the jacket, below the collar.",
    "incorrect": "The lapel is the folded flap on the chest, framing the shirt."
  }
}
```

**Sample 3** (lesson `snk-02`)

```json
{
  "prompt": "Tap the midsole.",
  "diagram": {
    "diagramId": "fashion-sneaker-anatomy",
    "aspectRatio": 1.6,
    "alt": "Side view of a generic sneaker with labelled zones: toe box, tongue, upper panel, midsole, outsole, heel counter."
  },
  "hotspots": [
    {
      "id": "toe",
      "label": "Toe box",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.45,
        "w": 0.2,
        "h": 0.2
      }
    },
    {
      "id": "tongue",
      "label": "Tongue",
      "shape": {
        "kind": "rect",
        "x": 0.35,
        "y": 0.2,
        "w": 0.15,
        "h": 0.2
      }
    },
    {
      "id": "midsole",
      "label": "Midsole",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.72,
        "w": 0.55,
        "h": 0.1
      }
    },
    {
      "id": "outsole",
      "label": "Outsole",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.85,
        "w": 0.55,
        "h": 0.06
      }
    },
    {
      "id": "heel",
      "label": "Heel counter",
      "shape": {
        "kind": "rect",
        "x": 0.75,
        "y": 0.35,
        "w": 0.15,
        "h": 0.3
      }
    }
  ],
  "correctHotspotIds": [
    "midsole"
  ],
  "explanation": {
    "correct": "The midsole is the cushioning layer between the outsole and the upper.",
    "incorrect": "The midsole is the thick cushion layer above the outsole (the part touching the ground)."
  }
}
```

### 2.11 `talk-track`

See section 4: eight full tracks (three reply styles per exchange).

## 3. Playbook terms (70)

The Playbook shows each term with a definition and an example line in the voice of the person she is learning for. Lines are quoted in serif; they are what she might say, never what the learner should fake. Terms unlock on first use; Term Blitz reviews draw from them.

| # | Term | Definition | Example line (her voice) |
|---|---|---|---|
| 1 | Silhouette | The overall outline a garment makes. | "I love the silhouette, it's so architectural." |
| 2 | Flat (technical flat) | A front-and-back line drawing of a garment laid out flat. | "I sketched the flat before I cut anything." |
| 3 | A-line | Fitted at the top, widening gradually toward the hem. | "An A-line skirt goes with everything." |
| 4 | Sheath | A close, straight dress that follows the body's line without flaring. | "That black sheath is my interview dress." |
| 5 | Fit-and-flare | Fitted through the bodice and waist, flaring out into the skirt. | "Fit-and-flare always feels a little twirly." |
| 6 | Wrap | A garment that crosses over and ties or fastens at the side. | "The wrap dress is forgiving and easy." |
| 7 | Empire waist | A seam right under the bust, with the skirt falling from there. | "The empire waist gives it that romantic look." |
| 8 | Wide-leg | Trousers that stay wide from hip to hem. | "Wide-leg trousers are so comfortable." |
| 9 | Tapered | A leg that narrows toward the ankle. | "I like a tapered leg with sneakers." |
| 10 | Cargo | Trousers with large side pockets. | "Cargo pants are back." |
| 11 | Rise | The distance from the crotch seam to the waistband. | "I prefer a high rise." |
| 12 | Inseam | The length of the inner leg seam. | "I always check the inseam before hemming." |
| 13 | Oversized | Deliberately cut larger than the size implies. | "It's oversized on purpose." |
| 14 | Cropped | A garment ending above its usual length. | "A cropped jacket balances high-waisted trousers." |
| 15 | Trench | A belted, double-breasted raincoat with a storm flap. | "My trench has held up ten years." |
| 16 | Bomber | A short jacket with ribbed cuffs and hem, a military legacy. | "A bomber over a slip dress is my go-to." |
| 17 | Fiber | The raw material a textile is made from, like cotton or polyester. | "Check the fiber content on the tag." |
| 18 | Drape | How a fabric hangs and falls. | "That fabric has amazing drape." |
| 19 | Hand (hand-feel) | How a fabric feels when you touch it. | "The hand of this wool is incredible." |
| 20 | Bias cut | Fabric cut on the diagonal so it clings and flows. | "A bias-cut satin skirt moves like water." |
| 21 | Twill | A weave with diagonal ridges, as in denim and chinos. | "Twill holds its shape well." |
| 22 | Satin | A weave with a glossy face, often silk or polyester. | "Satin catches the light beautifully." |
| 23 | Jersey | A soft, stretchy knit used for tees. | "Jersey feels effortless." |
| 24 | Herringbone | A V-shaped zigzag weave pattern. | "That herringbone coat is timeless." |
| 25 | Houndstooth | A broken-check pattern with pointed shapes. | "Houndstooth is bold but classic." |
| 26 | Gingham | A simple checked cotton pattern. | "Gingham is so summery." |
| 27 | Selvedge | A finished edge on fabric that keeps it from fraying. | "Selvedge denim has a tidy edge inside the cuff." |
| 28 | Placket | The strip of fabric where a garment fastens. | "The placket is finished so neatly." |
| 29 | Yoke | The shaped panel across the shoulders of a shirt. | "The yoke shows up in the back of the shirt." |
| 30 | Dart | A folded, stitched wedge that shapes fabric. | "Darts give the bodice its shape." |
| 31 | Seam allowance | The extra fabric beyond a seam line. | "There's plenty of seam allowance to let it out." |
| 32 | Lining | An inner layer that finishes and smooths a garment. | "The lining is silk, which is lovely." |
| 33 | Interfacing | A hidden layer that stiffens collars and cuffs. | "Cheap interfacing bubbles after washing." |
| 34 | Canvas | Inside layering of a tailored jacket that shapes it. | "A canvassed jacket molds over time." |
| 35 | Vent | An opening at the back or side of a jacket or skirt. | "Double vent, very classic." |
| 36 | Vanity sizing | Brands labelling garments smaller than their measurements. | "Vanity sizing makes labels meaningless." |
| 37 | Ease | Extra room in a garment beyond body measurements. | "There's a lot of ease in this coat." |
| 38 | Alterations | Adjustments to an existing garment by a tailor. | "I had the hem taken up." |
| 39 | Capsule wardrobe | A small set of versatile pieces that mix and match. | "I built a capsule for travel." |
| 40 | Tonal | Dressing in shades of one color. | "Tonal beige looks so calm." |
| 41 | Quiet luxury | Understated, logo-free clothes valued for quality. | "She's very quiet luxury." |
| 42 | Gorpcore | Outdoor technical gear worn as everyday fashion. | "Gorpcore fleece, obviously." |
| 43 | Y2K | Early-2000s aesthetic: low rise, baby tees, metallics. | "It's giving Y2K." |
| 44 | Maison | French for house: a fashion house. | "The maison just named a new director." |
| 45 | Creative director | The person who sets a house's design vision. | "The new creative director is resetting the house." |
| 46 | Atelier | A workshop where garments are made by hand. | "Everything is finished in the atelier." |
| 47 | Haute couture | A legally protected French designation for made-to-order, hand-crafted clothing. | "Couture week is the craft showcase." |
| 48 | Ready-to-wear (RTW) | Clothes made in standard sizes for stores. | "I prefer the ready-to-wear collections." |
| 49 | Resort / cruise | A mid-season collection between main seasons. | "The resort show is in a fun location." |
| 50 | Pre-fall | A collection shown between spring/summer and fall/winter. | "Pre-fall is quieter and wearable." |
| 51 | Collection | A designer's full set of pieces for a season. | "I loved the new collection." |
| 52 | Lookbook | A styled set of photos presenting a collection. | "The lookbook dropped this morning." |
| 53 | Capsule collection | A small themed set of pieces, often a collab. | "The capsule sold out in an hour." |
| 54 | Colorway | A specific color combination of a design. | "That colorway is my favorite." |
| 55 | Drop | A limited release at a set time. | "The drop is at 10 a.m." |
| 56 | Raffle | A lottery-style entry system for limited releases. | "I entered the raffle." |
| 57 | Deadstock | Unsold, unworn new-old stock, or leftover fabric. | "These are deadstock, never worn." |
| 58 | Grail | A dream item a collector hunts for. | "That jacket is my grail." |
| 59 | Retail vs resale | Original store price vs resold price. | "They're going for double on resale." |
| 60 | Vintage | Typically 20+ years old and from a past era. | "This blazer is vintage, 1990s." |
| 61 | Thrift | Buying secondhand at charity or resale stores. | "I thrifted the whole outfit." |
| 62 | NWT / EUC | New with tags / excellent used condition. | "It's NWT, tags still on." |
| 63 | Visible mending | Repair meant to be seen as decoration. | "Visible mending is my thing now." |
| 64 | Fast fashion | Quickly produced, low-priced, high-turnover clothing. | "Fast fashion moves so quickly." |
| 65 | Greenwashing | Sustainability claims that are vague or misleading. | "That feels like greenwashing." |
| 66 | Cost per wear | Price divided by the number of times worn. | "I look at cost per wear." |
| 67 | Dupe | A cheaper look-alike of a popular item. | "Is it a dupe or the real thing?" |
| 68 | Microtrend | A short-lived trend, often spread online. | "That microtrend lasted a month." |
| 69 | Lapel | The folded flap at the front of a jacket. | "Peak lapels look sharp." |
| 70 | Notch lapel | A lapel with a notch where collar meets lapel. | "Notch lapels are the most common." |

## 4. Talk Track scenarios (8)

Each scenario has her opening line, what it means, three reply styles per exchange (**good**, **meh**, **cringe**) with coach notes, and the payload JSON. Smooth starts at 50; a run is a success at >= 60. Good replies model honest curiosity; cringe replies fake expertise, judge budgets or comment on bodies.

### 4.1 The thrift find (`tt-thrift-find`)

- **Setting:** Ari texts a photo caption after a thrift trip.
- **Enthusiast opening:** "Found a 90s blazer for six dollars. The shoulders are perfect!"
- **What it means:** She found a well-made 1990s jacket cheaply; shoulders (structure) matter. Terms: vintage, thrift, structure.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "What made you look at it, the fabric or the shoulders?" | +25 | Good: you asked about her process. |
| 1 | meh | "Nice! Is that a lot?" | +5 | Honest but you framed it by price, not by the piece. |
| 1 | cringe | "Six dollars means it's probably fake, right?" | -20 | Never assume a cheap find is bad; it insults the find and her taste. |
| 2 | good | "Does a tailor usually handle sleeves? Sounds like a small fix." | +25 | Good: you used a term you actually understand. |
| 2 | meh | "Whatever fits you, right?" | +2 | Warm but off the garment. |
| 2 | cringe | "You should just buy a new one." | -18 | Never dismiss thrifting or repair. |

```json
{
  "title": "The thrift find",
  "setting": "Ari texts a photo caption after a thrift trip.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Found a 90s blazer for six dollars. The shoulders are perfect!",
      "replies": [
        {
          "id": "good",
          "text": "What made you look at it, the fabric or the shoulders?",
          "smoothDelta": 25,
          "theirResponse": "Ha, both! The wool was heavy and the shoulders were structured.",
          "coachNote": "Good: you asked about her process."
        },
        {
          "id": "meh",
          "text": "Nice! Is that a lot?",
          "smoothDelta": 5,
          "theirResponse": "It's a steal for the wool alone.",
          "coachNote": "Honest but you framed it by price, not by the piece."
        },
        {
          "id": "cringe",
          "text": "Six dollars means it's probably fake, right?",
          "smoothDelta": -20,
          "theirResponse": "...No? It has a real label.",
          "coachNote": "Never assume a cheap find is bad; it insults the find and her taste."
        }
      ]
    },
    {
      "theirMessage": "Right? Wool, lined, and it needs a tiny sleeve hem. I'll take it to my tailor.",
      "replies": [
        {
          "id": "good",
          "text": "Does a tailor usually handle sleeves? Sounds like a small fix.",
          "smoothDelta": 25,
          "theirResponse": "Yes! Sleeves are one of the easy ones.",
          "coachNote": "Good: you used a term you actually understand."
        },
        {
          "id": "meh",
          "text": "Whatever fits you, right?",
          "smoothDelta": 2,
          "theirResponse": "Sure, but the fit is the fun part.",
          "coachNote": "Warm but off the garment."
        },
        {
          "id": "cringe",
          "text": "You should just buy a new one.",
          "smoothDelta": -18,
          "theirResponse": "...That's the opposite of the vibe.",
          "coachNote": "Never dismiss thrifting or repair."
        }
      ]
    }
  ],
  "closingNote": "A vintage find is judged by fabric, construction and fit; small fixes like sleeve hems are ordinary alterations."
}
```

### 4.2 Fashion week chatter (`tt-fashion-week`)

- **Setting:** Sam texts during show season.
- **Enthusiast opening:** "Milan wrapped up. I'm waiting on Paris to see if the house does a reset."
- **What it means:** Fashion month moves city to city; a reset is a big change of direction under a creative director.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Do you follow the shows live or wait for the recap?" | +25 | Good: curiosity about her habits. |
| 1 | meh | "Wait, isn't fashion week just one week?" | +8 | Honest; ask what she means next time. |
| 1 | cringe | "These shows are just for celebrities." | -20 | Dunking on the subject ends the chat. |
| 2 | good | "So a reset means the new director changes the direction?" | +25 | Restating what you learned is safe. |
| 2 | meh | "Cool, do you buy those clothes?" | +3 | Fine, but ask about ideas before shopping. |
| 2 | cringe | "Which brand is best?" | -15 | 'Best' invites an argument; ask what she likes. |

```json
{
  "title": "Fashion week chatter",
  "setting": "Sam texts during show season.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Milan wrapped up. I'm waiting on Paris to see if the house does a reset.",
      "replies": [
        {
          "id": "good",
          "text": "Do you follow the shows live or wait for the recap?",
          "smoothDelta": 25,
          "theirResponse": "Live when I can, the recap for the rest.",
          "coachNote": "Good: curiosity about her habits."
        },
        {
          "id": "meh",
          "text": "Wait, isn't fashion week just one week?",
          "smoothDelta": 8,
          "theirResponse": "Ha, it's a month across four cities.",
          "coachNote": "Honest; ask what she means next time."
        },
        {
          "id": "cringe",
          "text": "These shows are just for celebrities.",
          "smoothDelta": -20,
          "theirResponse": "Um. They're for buyers and press.",
          "coachNote": "Dunking on the subject ends the chat."
        }
      ]
    },
    {
      "theirMessage": "Live. The show is the first time you see the new creative director's ideas.",
      "replies": [
        {
          "id": "good",
          "text": "So a reset means the new director changes the direction?",
          "smoothDelta": 25,
          "theirResponse": "Exactly. Sometimes drastically.",
          "coachNote": "Restating what you learned is safe."
        },
        {
          "id": "meh",
          "text": "Cool, do you buy those clothes?",
          "smoothDelta": 3,
          "theirResponse": "Not the runway version, ha.",
          "coachNote": "Fine, but ask about ideas before shopping."
        },
        {
          "id": "cringe",
          "text": "Which brand is best?",
          "smoothDelta": -15,
          "theirResponse": "There's no best. Depends on taste.",
          "coachNote": "'Best' invites an argument; ask what she likes."
        }
      ]
    }
  ],
  "closingNote": "Fashion month moves New York, London, Milan, Paris; a new creative director's debut sets a house's direction."
}
```

### 4.3 The sneaker drop (`tt-drop-day`)

- **Setting:** Jordan is bummed after a release.
- **Enthusiast opening:** "Missed the drop again. Bots ate the raffle."
- **What it means:** A limited release sold out; automated bots beat human entries in the raffle lottery.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ugh, brutal. Which one were you trying for?" | +25 | Good: sympathy plus a specific question. |
| 1 | meh | "Just buy something else?" | -8 | Fixing it misses why it matters. |
| 1 | cringe | "They're only shoes." | -20 | Never diminish what she loves. |
| 2 | good | "That's a real principle. Is there another drop you're hoping for?" | +25 | Respect her choice and look ahead. |
| 2 | meh | "Maybe try resale?" | -3 | She said no to resale; don't push. |
| 2 | cringe | "You could have paid the resale price." | -18 | Never shame budget or choices. |

```json
{
  "title": "The sneaker drop",
  "setting": "Jordan is bummed after a release.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Missed the drop again. Bots ate the raffle.",
      "replies": [
        {
          "id": "good",
          "text": "Ugh, brutal. Which one were you trying for?",
          "smoothDelta": 25,
          "theirResponse": "The high-top in the green colorway.",
          "coachNote": "Good: sympathy plus a specific question."
        },
        {
          "id": "meh",
          "text": "Just buy something else?",
          "smoothDelta": -8,
          "theirResponse": "It's not that simple, ha.",
          "coachNote": "Fixing it misses why it matters."
        },
        {
          "id": "cringe",
          "text": "They're only shoes.",
          "smoothDelta": -20,
          "theirResponse": "...Wow. Okay.",
          "coachNote": "Never diminish what she loves."
        }
      ]
    },
    {
      "theirMessage": "Yeah. Retail is $130 but resale is triple, and I refuse to pay it.",
      "replies": [
        {
          "id": "good",
          "text": "That's a real principle. Is there another drop you're hoping for?",
          "smoothDelta": 25,
          "theirResponse": "Actually yes, a collab next month.",
          "coachNote": "Respect her choice and look ahead."
        },
        {
          "id": "meh",
          "text": "Maybe try resale?",
          "smoothDelta": -3,
          "theirResponse": "I could, but I don't like the markup.",
          "coachNote": "She said no to resale; don't push."
        },
        {
          "id": "cringe",
          "text": "You could have paid the resale price.",
          "smoothDelta": -18,
          "theirResponse": "Not the point.",
          "coachNote": "Never shame budget or choices."
        }
      ]
    }
  ],
  "closingNote": "A drop is a limited release; raffles and bots make it hard, and resale prices are a debate, not a duty."
}
```

### 4.4 Between sizes (`tt-fit-talk`)

- **Setting:** Ren is frustrated with sizing.
- **Enthusiast opening:** "Sizes are so inconsistent. I'm three different sizes depending on the brand."
- **What it means:** Brands size differently; she uses measurements instead. Body comments are off-limits.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Sizing is a mess. Do you look at garment measurements?" | +25 | Good: garment-first. |
| 1 | meh | "Ha, what size are you?" | -20 | Never ask about someone's size. |
| 1 | cringe | "Just lose weight then it'll fit." | -20 | Never comment on bodies. This is the biggest cringe. |
| 2 | good | "So you measure the garment, not the tag?" | +25 | Restating shows listening. |
| 2 | meh | "Makes sense." | +5 | Fine but low effort. |
| 2 | cringe | "Why don't you just go to a tailor?" | -8 | Don't jump to fixes. |

```json
{
  "title": "Between sizes",
  "setting": "Ren is frustrated with sizing.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Sizes are so inconsistent. I'm three different sizes depending on the brand.",
      "replies": [
        {
          "id": "good",
          "text": "Sizing is a mess. Do you look at garment measurements?",
          "smoothDelta": 25,
          "theirResponse": "I do now, a flat measurement chart helps.",
          "coachNote": "Good: garment-first."
        },
        {
          "id": "meh",
          "text": "Ha, what size are you?",
          "smoothDelta": -20,
          "theirResponse": "...I'd rather not get into that.",
          "coachNote": "Never ask about someone's size."
        },
        {
          "id": "cringe",
          "text": "Just lose weight then it'll fit.",
          "smoothDelta": -20,
          "theirResponse": "Please stop.",
          "coachNote": "Never comment on bodies. This is the biggest cringe."
        }
      ]
    },
    {
      "theirMessage": "Yeah. Measurements on the flat lay are the only thing I trust.",
      "replies": [
        {
          "id": "good",
          "text": "So you measure the garment, not the tag?",
          "smoothDelta": 25,
          "theirResponse": "Right. The tag is just a guess.",
          "coachNote": "Restating shows listening."
        },
        {
          "id": "meh",
          "text": "Makes sense.",
          "smoothDelta": 5,
          "theirResponse": "Yeah, thanks.",
          "coachNote": "Fine but low effort."
        },
        {
          "id": "cringe",
          "text": "Why don't you just go to a tailor?",
          "smoothDelta": -8,
          "theirResponse": "I do, but that's not always the fix.",
          "coachNote": "Don't jump to fixes."
        }
      ]
    }
  ],
  "closingNote": "Sizes are label conventions; garment measurements are the reliable guide. Never comment on a body."
}
```

### 4.5 Her favorite designer (`tt-fave-designer`)

- **Setting:** Maya talks about a house she loves.
- **Enthusiast opening:** "The new collection is so different from last season. The direction changed completely."
- **What it means:** New creative director, new direction; she can see the change in shape and fabric.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "What changed the most, the shapes or the fabrics?" | +25 | Good: asks about a specific element. |
| 1 | meh | "Is that a good thing?" | +5 | Fine: invites her opinion. |
| 1 | cringe | "I liked the old stuff better." | -18 | Don't fake taste to sound informed. |
| 2 | good | "Did the previous director's ideas stay in the house at all?" | +25 | Curious about continuity. |
| 2 | meh | "Who is it?" | +4 | Honest question, easy. |
| 2 | cringe | "Creative directors don't matter, it's the brand." | -15 | Don't contradict what you don't know. |

```json
{
  "title": "Her favorite designer",
  "setting": "Maya talks about a house she loves.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "The new collection is so different from last season. The direction changed completely.",
      "replies": [
        {
          "id": "good",
          "text": "What changed the most, the shapes or the fabrics?",
          "smoothDelta": 25,
          "theirResponse": "The shapes, wider and softer.",
          "coachNote": "Good: asks about a specific element."
        },
        {
          "id": "meh",
          "text": "Is that a good thing?",
          "smoothDelta": 5,
          "theirResponse": "I love it, some people don't.",
          "coachNote": "Fine: invites her opinion."
        },
        {
          "id": "cringe",
          "text": "I liked the old stuff better.",
          "smoothDelta": -18,
          "theirResponse": "...You didn't see the old stuff.",
          "coachNote": "Don't fake taste to sound informed."
        }
      ]
    },
    {
      "theirMessage": "The new creative director has a totally different point of view.",
      "replies": [
        {
          "id": "good",
          "text": "Did the previous director's ideas stay in the house at all?",
          "smoothDelta": 25,
          "theirResponse": "A little, in the tailoring.",
          "coachNote": "Curious about continuity."
        },
        {
          "id": "meh",
          "text": "Who is it?",
          "smoothDelta": 4,
          "theirResponse": "It's a name you might know.",
          "coachNote": "Honest question, easy."
        },
        {
          "id": "cringe",
          "text": "Creative directors don't matter, it's the brand.",
          "smoothDelta": -15,
          "theirResponse": "They actually do.",
          "coachNote": "Don't contradict what you don't know."
        }
      ]
    }
  ],
  "closingNote": "A creative director sets a house's direction; collections show that direction each season."
}
```

### 4.6 The sustainability chat (`tt-greenwash`)

- **Setting:** Lee is skeptical of a brand claim.
- **Enthusiast opening:** "This brand says its collection is 'sustainable' but gives zero details. Feels like greenwashing."
- **What it means:** She is skeptical of unsupported eco-claims and wants checkable specifics.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "What details would convince you? Fiber percentages? A certification?" | +25 | Good: asks what evidence looks like. |
| 1 | meh | "Wait, what's greenwashing?" | +8 | Honest; you learned a term. |
| 1 | cringe | "Everything is greenwashing, it's pointless." | -20 | Cynicism ends a conversation. |
| 2 | good | "That makes sense. Do you also buy secondhand or repair?" | +22 | Adds her actual habits, not judgment. |
| 2 | meh | "I never check that stuff." | -5 | Honest but leaves it there. |
| 2 | cringe | "Do you ever buy fast fashion?" | -15 | Don't turn a shared view into a trap. |

```json
{
  "title": "The sustainability chat",
  "setting": "Lee is skeptical of a brand claim.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "This brand says its collection is 'sustainable' but gives zero details. Feels like greenwashing.",
      "replies": [
        {
          "id": "good",
          "text": "What details would convince you? Fiber percentages? A certification?",
          "smoothDelta": 25,
          "theirResponse": "Exactly. Specific claims I can check.",
          "coachNote": "Good: asks what evidence looks like."
        },
        {
          "id": "meh",
          "text": "Wait, what's greenwashing?",
          "smoothDelta": 8,
          "theirResponse": "Vague claims to look eco-friendly.",
          "coachNote": "Honest; you learned a term."
        },
        {
          "id": "cringe",
          "text": "Everything is greenwashing, it's pointless.",
          "smoothDelta": -20,
          "theirResponse": "...That's not helpful.",
          "coachNote": "Cynicism ends a conversation."
        }
      ]
    },
    {
      "theirMessage": "Yeah, I look for numbers and named standards.",
      "replies": [
        {
          "id": "good",
          "text": "That makes sense. Do you also buy secondhand or repair?",
          "smoothDelta": 22,
          "theirResponse": "Both, honestly.",
          "coachNote": "Adds her actual habits, not judgment."
        },
        {
          "id": "meh",
          "text": "I never check that stuff.",
          "smoothDelta": -5,
          "theirResponse": "Ha, fair.",
          "coachNote": "Honest but leaves it there."
        },
        {
          "id": "cringe",
          "text": "Do you ever buy fast fashion?",
          "smoothDelta": -15,
          "theirResponse": "...Are you going to judge me?",
          "coachNote": "Don't turn a shared view into a trap."
        }
      ]
    }
  ],
  "closingNote": "Greenwashing is a vague or unsupported claim; specifics (numbers, named standards) make a claim checkable."
}
```

### 4.7 Her outfit story (`tt-outfit-story`)

- **Setting:** Noor sends a photo of an outfit she built.
- **Enthusiast opening:** "I built this outfit around one vintage scarf. Everything else follows the colors."
- **What it means:** She builds outfits from a hero piece and a color palette.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Which color from the scarf did you pull out first?" | +25 | Good: a specific, non-body compliment question. |
| 1 | meh | "Looks great!" | +8 | Kind, but generic. |
| 1 | cringe | "It's okay, kind of busy." | -18 | Don't critique an outfit she's proud of. |
| 2 | good | "Do you usually start from one piece like that?" | +25 | Shows curiosity about her process. |
| 2 | meh | "You have good taste." | +5 | Kind but leaves no follow-up. |
| 2 | cringe | "Does it make you look thinner?" | -20 | Never comment on bodies. |

```json
{
  "title": "Her outfit story",
  "setting": "Noor sends a photo of an outfit she built.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I built this outfit around one vintage scarf. Everything else follows the colors.",
      "replies": [
        {
          "id": "good",
          "text": "Which color from the scarf did you pull out first?",
          "smoothDelta": 25,
          "theirResponse": "The rust. I matched the boots.",
          "coachNote": "Good: a specific, non-body compliment question."
        },
        {
          "id": "meh",
          "text": "Looks great!",
          "smoothDelta": 8,
          "theirResponse": "Thanks!",
          "coachNote": "Kind, but generic."
        },
        {
          "id": "cringe",
          "text": "It's okay, kind of busy.",
          "smoothDelta": -18,
          "theirResponse": "...Okay.",
          "coachNote": "Don't critique an outfit she's proud of."
        }
      ]
    },
    {
      "theirMessage": "The rust made the whole thing feel warm.",
      "replies": [
        {
          "id": "good",
          "text": "Do you usually start from one piece like that?",
          "smoothDelta": 25,
          "theirResponse": "Yes, a hero piece, then everything else supports it.",
          "coachNote": "Shows curiosity about her process."
        },
        {
          "id": "meh",
          "text": "You have good taste.",
          "smoothDelta": 5,
          "theirResponse": "Thanks!",
          "coachNote": "Kind but leaves no follow-up."
        },
        {
          "id": "cringe",
          "text": "Does it make you look thinner?",
          "smoothDelta": -20,
          "theirResponse": "...Please don't.",
          "coachNote": "Never comment on bodies."
        }
      ]
    }
  ],
  "closingNote": "Ask about the choices in the outfit, not the body wearing it."
}
```

### 4.8 The jacket she wants (`tt-tailoring`)

- **Setting:** Kai shares a tailored jacket.
- **Enthusiast opening:** "Found the perfect jacket. Peak lapels, canvassed, but the sleeves need work."
- **What it means:** She found a well-made jacket; peak lapels and canvas are quality cues; sleeves need shortening.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Peak lapels and canvassed, nice. Are the sleeves something a tailor can shorten?" | +25 | Good: uses the terms you learned and stays practical. |
| 1 | meh | "Is it expensive?" | -10 | Price talk misses her excitement. |
| 1 | cringe | "Those terms sound fake." | -20 | Never dismiss vocabulary you don't know. |
| 2 | good | "Working buttons, so you can unbutton the cuff. Is that a detail you look for?" | +25 | Restating the detail and asking why she cares. |
| 2 | meh | "What does that mean?" | +6 | Honest and welcome. |
| 2 | cringe | "Nobody ever notices that." | -18 | Don't deflate her enthusiasm. |

```json
{
  "title": "The jacket she wants",
  "setting": "Kai shares a tailored jacket.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Found the perfect jacket. Peak lapels, canvassed, but the sleeves need work.",
      "replies": [
        {
          "id": "good",
          "text": "Peak lapels and canvassed, nice. Are the sleeves something a tailor can shorten?",
          "smoothDelta": 25,
          "theirResponse": "Yes, that's an easy one.",
          "coachNote": "Good: uses the terms you learned and stays practical."
        },
        {
          "id": "meh",
          "text": "Is it expensive?",
          "smoothDelta": -10,
          "theirResponse": "Not the point.",
          "coachNote": "Price talk misses her excitement."
        },
        {
          "id": "cringe",
          "text": "Those terms sound fake.",
          "smoothDelta": -20,
          "theirResponse": "They're real!",
          "coachNote": "Never dismiss vocabulary you don't know."
        }
      ]
    },
    {
      "theirMessage": "It even has a working button on the sleeve.",
      "replies": [
        {
          "id": "good",
          "text": "Working buttons, so you can unbutton the cuff. Is that a detail you look for?",
          "smoothDelta": 25,
          "theirResponse": "Always, it's a sign of care.",
          "coachNote": "Restating the detail and asking why she cares."
        },
        {
          "id": "meh",
          "text": "What does that mean?",
          "smoothDelta": 6,
          "theirResponse": "You can actually open the cuff.",
          "coachNote": "Honest and welcome."
        },
        {
          "id": "cringe",
          "text": "Nobody ever notices that.",
          "smoothDelta": -18,
          "theirResponse": "I do.",
          "coachNote": "Don't deflate her enthusiasm."
        }
      ]
    }
  ],
  "closingNote": "Peak lapel, canvassed construction and working cuffs are details tailoring fans notice."
}
```

## 5. Talk Track roster at launch (16)

The eight scenarios above plus eight more to author: the museum or exhibit visit, the vintage market weekend, the gift she hopes for (asking, not guessing), the show she stayed up to watch, the friend who wears a lot of black, her first tailored piece, the repair project, and the dress code invitation ("what does cocktail attire mean?"). Personalized tracks use `{{style}}`, `{{brand}}`, `{{era}}`, `{{region}}` substitution with defaults.

## 6. Asset needs (all `original-swoond`)

| Asset | Used by | Notes |
|---|---|---|
| `images/fashion/dress-*.svg`, `skirt-*.svg`, `trouser-*.svg`, `top-*.svg`, `outerwear-*.svg` | visual-id | Body-free garment flats |
| `images/fashion/neckline-*.svg`, `sleeve-*.svg`, `collar-*.svg` | visual-id | Detail flats |
| `images/fashion/pattern-*.svg`, `weave-*.svg` | visual-id, term-match | Procedural swatches |
| `images/fashion/sneaker-*.svg` | visual-id | Generic archetype line art, no brand cues |
| `fashion-shirt-anatomy`, `fashion-jacket-anatomy`, `fashion-sneaker-anatomy`, `fashion-care-label` diagrams | hotspot-tap | Procedural |

## 7. Voice and safety notes

- Cheeky coach, never mean, one joke per screen, never about the crush.
- Never mock bodies, sizes, ages, budgets, thrift shoppers, fast-fashion shoppers or luxury shoppers.
- Never guess or ask about a size; sizing items are about garments and brands.
- Cultural and religious dress items are respectful and go through SME review.
- Sustainability items present sourced positions and specifics, not moralizing.
- Resale and authentication items carry scam-awareness `safetyNote`; they never teach faking goods.
- Time-sensitive facts (who leads which house, calendar dates, regulations) are never hard-coded in exercise payloads; they come from the live layer.
