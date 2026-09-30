# Native Exercise Plan: Skincare (`skincare`)

Tier B plan for `docs/courses/skincare/`. **No Tier A (Unity) sims**: see CDS section 12. Sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup when this file was generated). Conventions: prompts <= 12 words; every answer explained; a "say this" line where natural; body-, skin-tone- and budget-inclusive wording; all images original (`original-swoond`), face-free and skin-free.

**Health-adjacent rules for every item** (full list in `SAFETY_REVIEW_CHECKLIST.md`): no diagnosis, no treatment advice, no dosing, no before/after claims, no 'fix' language for skin. Acne, rosacea, eczema, pregnancy or breastfeeding, prescription retinoids and any concerning or changing spot always route to 'ask a dermatologist or pharmacist'. Decision scenarios always carry a `safetyNote`; emergencies are never timed or scored. Nothing is scored on appearance.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite: terms, label facts, 'which is true'. Distractors are the classic beginner errors in CDS section 2. | ~180 |
| `binary-call` | Two-way calls with a text description (scene kind none): claim or fact, stack or separate, good sign or marketing. | ~30 |
| `term-match` | Introduce 3-6 related terms (actives, filter types, K-beauty words) and Term Blitz reviews. | ~50 |
| `sequence-order` | Where order is the concept: routine steps, thin to thick, label-check order, patch test steps. | ~20 |
| `visual-id` | Textures, packaging, UV bands, label panels. Original illustrations only (`original-swoond`); no faces, no skin photos, no real products, no before/after. | ~70 |
| `decision-scenario` | Judgment: new product and sensitive skin, viral claims, reading a label, helping a friend. Every item carries a `safetyNote` and a best answer that defers to a pharmacist or dermatologist where health is involved. | ~70 |
| `talk-track` | Conversation practice: 16 tracks at launch (8 authored below). Replies reward curiosity; never comment on her skin, advise her on actives, or judge her spending. | ~16 |
| `say-this` | Decode what she just said: skin cycling, PA ratings, INCI talk, dupes. Every item has a `noFakeExpertNote`. | ~70 |
| `fill-the-gap` | Vocabulary and facts in context; Daily Bite. | ~40 |
| `estimate-slider` | Magnitudes that are facts, never doses or personal targets: reapply interval, SPF share, UV index, typical label percentages. | ~14 |
| `hotspot-tap` | Anatomy of a label, a skin cross-section (face-free), a fictional product panel. Procedural diagrams. | ~30 |
| `timing-tap` | Not used: nothing in skincare is a 1D timing feel. | 0 |
| `listening-id` | Not used: no audio need. | 0 |
| `unity-sim` | Not used (CDS section 12). | 0 |

Estimated total: about 590 native items across 112 lessons and the review loop. Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice` and `fill-the-gap`; visual concepts are reviewed with different illustrations each time.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

**Sample 1** (lesson `sb-02`)

```json
{
  "prompt": "What does your skin barrier mainly do?",
  "options": [
    {
      "id": "a",
      "text": "Keeps water in and irritants out"
    },
    {
      "id": "b",
      "text": "Makes skin glow"
    },
    {
      "id": "c",
      "text": "Removes dead cells for you"
    },
    {
      "id": "d",
      "text": "Blocks all sunlight"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "The barrier is the skin's outermost layer. Think bricks (cells) and mortar (fats): it slows water loss and keeps most irritants out.",
    "incorrect": "The barrier is about holding water in and keeping irritants out. Glow and sun protection are separate jobs.",
    "sayThisLine": "Is that one meant to be barrier-friendly?"
  }
}
```

**Sample 2** (lesson `lb-03`)

```json
{
  "prompt": "An ingredient list is ordered how?",
  "options": [
    {
      "id": "a",
      "text": "Highest amount first, down to about 1 percent"
    },
    {
      "id": "b",
      "text": "Alphabetical"
    },
    {
      "id": "c",
      "text": "Most expensive first"
    },
    {
      "id": "d",
      "text": "Newest ingredient first"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Ingredients are listed from most to least, until about 1 percent. After that, brands may list them in any order.",
    "incorrect": "Lists run by amount, not price or alphabet. Below roughly 1 percent the order is not a reliable signal.",
    "sayThisLine": "What's the first thing on the list?"
  }
}
```

**Sample 3** (lesson `sp-03`)

```json
{
  "prompt": "What does a higher SPF number mainly describe?",
  "options": [
    {
      "id": "a",
      "text": "Protection from sunburn (UVB)"
    },
    {
      "id": "b",
      "text": "How long you can stay out"
    },
    {
      "id": "c",
      "text": "Protection from all UV equally"
    },
    {
      "id": "d",
      "text": "How waterproof it is"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "SPF is a lab measure of protection against the UV that causes sunburn. It does not say how long you can stay out, and it is not a pass to skip reapplying.",
    "incorrect": "SPF mainly tells you about sunburn protection. Broad-spectrum wording and UVA ratings cover the rest.",
    "sayThisLine": "Is yours broad spectrum?"
  }
}
```

### 2.2 `binary-call`

**Sample 1** (lesson `ro-02`)

```json
{
  "prompt": "Morning routine: SPF goes where?",
  "scene": {
    "kind": "none",
    "alt": "No diagram. A sunscreen, a moisturizer and a cleanser sit in a row."
  },
  "choices": [
    {
      "id": "last",
      "label": "Last step"
    },
    {
      "id": "first",
      "label": "First step"
    }
  ],
  "correctChoiceId": "last",
  "explanation": {
    "correct": "In the morning, SPF usually goes on as the final skincare step, so nothing is layered over it and it forms an even film.",
    "incorrect": "SPF is typically last in the morning routine. Putting it first means other products get rubbed over the top."
  },
  "ruleTag": "Routine order"
}
```

**Sample 2** (lesson `lb-05`)

```json
{
  "prompt": "'Dermatologist tested' means dermatologist approved?",
  "scene": {
    "kind": "none",
    "alt": "No diagram. A product box carries a small 'dermatologist tested' line."
  },
  "choices": [
    {
      "id": "yes",
      "label": "Yes, approved"
    },
    {
      "id": "no",
      "label": "No, not the same"
    }
  ],
  "correctChoiceId": "no",
  "explanation": {
    "correct": "The phrase only says someone tested it. It is not a standard, and it is not an endorsement of the product for your skin.",
    "incorrect": "It is not an approval. Claim wording is often a marketing choice, so look for what was tested and how."
  },
  "ruleTag": "Label claims"
}
```

**Sample 3** (lesson `ex-04`)

```json
{
  "prompt": "Scrubby grains plus a strong acid: a good pairing?",
  "scene": {
    "kind": "none",
    "alt": "No diagram. A gritty scrub and a leave-on acid toner both list exfoliating on the label."
  },
  "choices": [
    {
      "id": "stack",
      "label": "Fine to stack"
    },
    {
      "id": "overdo",
      "label": "Probably too much"
    }
  ],
  "correctChoiceId": "overdo",
  "explanation": {
    "correct": "Two exfoliating steps at once is a classic over-exfoliation setup. Enthusiasts pick one method at a time and go slowly.",
    "incorrect": "Stacking exfoliators is the common mistake. If skin feels stingy or tight, pause the actives and ask a pharmacist.",
    "sayThisLine": "I'm keeping it to one exfoliant."
  },
  "ruleTag": "Exfoliation"
}
```

### 2.3 `term-match`

**Sample 1** (lesson `cm-04`)

```json
{
  "prompt": "Match the moisturizer job to the ingredient type.",
  "pairs": [
    {
      "id": "hum",
      "term": "Humectant",
      "definition": "Draws water toward the skin (glycerin, hyaluronic acid)"
    },
    {
      "id": "emo",
      "term": "Emollient",
      "definition": "Softens and smooths the surface (squalane, shea butter)"
    },
    {
      "id": "occ",
      "term": "Occlusive",
      "definition": "Seals the surface to slow water loss (petrolatum)"
    }
  ],
  "explanation": {
    "summary": "Most moisturizers mix all three jobs. Enthusiasts talk about which job a product leans on.",
    "sayThisLine": "It's very humectant-heavy, right?"
  }
}
```

**Sample 2** (lesson `ex-01`)

```json
{
  "prompt": "Match the exfoliating acid to its nickname.",
  "pairs": [
    {
      "id": "aha",
      "term": "AHA",
      "definition": "Water-soluble acids like glycolic and lactic"
    },
    {
      "id": "bha",
      "term": "BHA",
      "definition": "Oil-soluble salicylic acid"
    },
    {
      "id": "pha",
      "term": "PHA",
      "definition": "Larger-molecule acids like gluconolactone, known for a gentle reputation"
    }
  ],
  "explanation": {
    "summary": "AHA, BHA and PHA are chemical exfoliants. Which one someone loves usually comes down to texture and how their skin feels.",
    "sayThisLine": "Are you an AHA person or a BHA person?"
  }
}
```

**Sample 3** (lesson `kj-02`)

```json
{
  "prompt": "Match the K-beauty word to its meaning.",
  "pairs": [
    {
      "id": "ess",
      "term": "Essence",
      "definition": "Watery, lightweight hydrating step after cleansing"
    },
    {
      "id": "amp",
      "term": "Ampoule",
      "definition": "A small, concentrated treatment step"
    },
    {
      "id": "sm",
      "term": "Sheet mask",
      "definition": "Fabric soaked in serum, worn for a set time"
    },
    {
      "id": "cu",
      "term": "Cushion",
      "definition": "Compact with a sponge holding liquid base or sunscreen"
    }
  ],
  "explanation": {
    "summary": "K-beauty has its own vocabulary for textures and steps. Knowing the words makes her shelf much easier to follow."
  }
}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `ro-01`)

```json
{
  "prompt": "Put a simple morning routine in order.",
  "items": [
    {
      "id": "clean",
      "text": "Gentle cleanse or rinse",
      "why": "Start with a clean surface."
    },
    {
      "id": "treat",
      "text": "Lightweight treatment, if you use one",
      "why": "Thin products go on before thick ones."
    },
    {
      "id": "moist",
      "text": "Moisturizer",
      "why": "Helps skin hold water and sets up the next layer."
    },
    {
      "id": "spf",
      "text": "Sunscreen",
      "why": "Last, so it forms an even layer on top."
    }
  ],
  "explanation": {
    "correct": "The everyday logic: cleanse, treat, moisturize, protect. Thin textures go before thick ones, and SPF finishes the morning.",
    "incorrect": "Try cleanse, treat, moisturize, then SPF. Sunscreen is last in the morning so it sits evenly on top.",
    "sayThisLine": "Mine is cleanse, moisturize, SPF. Keeps it simple."
  }
}
```

**Sample 2** (lesson `ro-05`)

```json
{
  "prompt": "Order these textures, thinnest to thickest.",
  "items": [
    {
      "id": "toner",
      "text": "Watery essence or toner",
      "why": "Runniest, goes first."
    },
    {
      "id": "serum",
      "text": "Serum",
      "why": "Light and slightly viscous."
    },
    {
      "id": "cream",
      "text": "Cream",
      "why": "Thicker, holds moisture in."
    },
    {
      "id": "balm",
      "text": "Balm or ointment",
      "why": "Thickest, often last at night."
    }
  ],
  "explanation": {
    "correct": "Thinnest to thickest is the usual rule of thumb, because thick layers can block thin ones from spreading.",
    "incorrect": "Thin layers first, then thick. A balm under a toner would just sit in the way."
  }
}
```

**Sample 3** (lesson `lb-07`)

```json
{
  "prompt": "Put the label check in a sensible order.",
  "items": [
    {
      "id": "job",
      "text": "Decide what you want it to do",
      "why": "A goal keeps you from buying for the claim."
    },
    {
      "id": "inci",
      "text": "Read the ingredient list",
      "why": "It tells you what is actually in the bottle."
    },
    {
      "id": "claims",
      "text": "Read the front claims",
      "why": "Claims are marketing; check them against the list."
    },
    {
      "id": "patch",
      "text": "Plan a patch test",
      "why": "Try a small area first before using it on your face."
    }
  ],
  "explanation": {
    "correct": "Start with the goal, check the list, then weigh the claims, then test small.",
    "incorrect": "Goal, list, claims, test. The front of the box comes last because it is marketing."
  }
}
```

### 2.5 `visual-id`

**Sample 1** (lesson `cm-02`)

```json
{
  "prompt": "Which product texture is this?",
  "image": {
    "asset": "skincare/textures/gel.svg",
    "alt": "A clear, wobbly dome of translucent blue-tinted product with a glossy surface and a soft edge.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "gel",
      "text": "Gel"
    },
    {
      "id": "cream",
      "text": "Cream"
    },
    {
      "id": "balm",
      "text": "Balm"
    },
    {
      "id": "lotion",
      "text": "Lotion"
    }
  ],
  "correctOptionId": "gel",
  "explanation": {
    "correct": "Gels are water-based, translucent and bouncy. People with oil-prone or hot-climate routines often like them for that light feel.",
    "incorrect": "This one is see-through and wobbly, which is the gel signature. Creams are opaque and balms are firm.",
    "sayThisLine": "Is that a gel texture?"
  },
  "cues": [
    "Translucent and bouncy",
    "Glossy, holds a dome shape",
    "Water-based feel"
  ]
}
```

**Sample 2** (lesson `fb-05`)

```json
{
  "prompt": "Which bottle type protects actives best?",
  "image": {
    "asset": "skincare/packaging/three-bottles.svg",
    "alt": "Three generic containers side by side: an open-mouth clear jar, a clear dropper bottle, and a dark opaque airless pump.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "jar",
      "text": "Open clear jar"
    },
    {
      "id": "drop",
      "text": "Clear dropper"
    },
    {
      "id": "pump",
      "text": "Opaque airless pump"
    }
  ],
  "correctOptionId": "pump",
  "explanation": {
    "correct": "Light, air and fingers can degrade touchy ingredients like vitamin C. Opaque, airless packaging limits all three.",
    "incorrect": "The opaque airless pump limits light and air exposure. Open clear jars let in both."
  },
  "cues": [
    "Opaque blocks light",
    "Airless limits oxygen",
    "No fingers in the product"
  ]
}
```

**Sample 3** (lesson `sp-02`)

```json
{
  "prompt": "Which UV band causes mostly sunburn?",
  "image": {
    "asset": "skincare/spf/uv-bands.svg",
    "alt": "A simple spectrum bar with three labeled bands: long-wave, mid-wave and short-wave, with arrows showing how deep each reaches.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "uva",
      "text": "UVA"
    },
    {
      "id": "uvb",
      "text": "UVB"
    },
    {
      "id": "uvc",
      "text": "UVC"
    }
  ],
  "correctOptionId": "uvb",
  "explanation": {
    "correct": "UVB is the band behind most sunburn, and SPF is measured against it. UVA reaches deeper and is handled by broad-spectrum protection.",
    "incorrect": "UVB is the sunburn band. UVA is long-wave and deeper. UVC is mostly absorbed by the atmosphere.",
    "sayThisLine": "SPF is mostly about UVB, right?"
  },
  "cues": [
    "B for burn",
    "A for aging-deep reach",
    "C mostly blocked by atmosphere"
  ]
}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `lb-07`)

```json
{
  "prompt": "New serum, sensitive afternoon: what do you do?",
  "situation": {
    "narrative": "A friend wants to try a new serum. She has a small sensitive patch on her jaw.",
    "facts": [
      {
        "label": "Product",
        "value": "New serum with acids"
      },
      {
        "label": "Her skin",
        "value": "Stings at the moment",
        "emphasis": "warning"
      },
      {
        "label": "Plan",
        "value": "Put it all over tonight"
      }
    ]
  },
  "options": [
    {
      "id": "wait",
      "label": "Wait, patch test later, ask a pharmacist if unsure",
      "verdict": "best",
      "consequence": "She avoids a bad surprise and gets a real answer for her own skin.",
      "considerations": [
        "Stinging skin is a stop sign for new actives",
        "A pharmacist can read the list with her"
      ]
    },
    {
      "id": "small",
      "label": "Try a tiny spot and watch",
      "verdict": "acceptable",
      "consequence": "Better than full-face, but stinging skin is not the moment to add an acid.",
      "considerations": [
        "A patch test lowers risk but does not remove it"
      ]
    },
    {
      "id": "all",
      "label": "Use it everywhere; it is a hyped product",
      "verdict": "poor",
      "consequence": "Hype does not tell you how her skin reacts.",
      "considerations": [
        "Popular is not the same as right for her"
      ]
    }
  ],
  "expertNote": "Enthusiasts add one new product at a time, patch test first, and treat stinging skin as a pause. It is not a verdict, just a habit.",
  "sayThisLine": "I'd wait and patch test it. Want me to come with you to ask the pharmacist?",
  "safetyNote": "General learning only. Not medical advice. For any skin concern, see a dermatologist or ask a pharmacist."
}
```

**Sample 2** (lesson `di-04`)

```json
{
  "prompt": "A creator says 'skip SPF, it is a scam'. Now what?",
  "situation": {
    "narrative": "You are scrolling with her. A popular creator claims sunscreen is unnecessary.",
    "facts": [
      {
        "label": "Creator",
        "value": "No qualifications listed",
        "emphasis": "warning"
      },
      {
        "label": "Claim",
        "value": "Sunscreen is a scam",
        "emphasis": "warning"
      },
      {
        "label": "Her reaction",
        "value": "Half-laughing, half-unsure"
      }
    ]
  },
  "options": [
    {
      "id": "ask",
      "label": "Ask what she thinks, then look at what dermatologists and health agencies say",
      "verdict": "best",
      "consequence": "You stay curious and point toward reliable sources without lecturing.",
      "considerations": [
        "Health agencies broadly recommend sun protection",
        "A claim without sources is just a claim"
      ]
    },
    {
      "id": "agree",
      "label": "Agree so she thinks you are open-minded",
      "verdict": "poor",
      "consequence": "Agreeing to be liked is faking a view you do not hold.",
      "considerations": [
        "Swoon'd never asks you to fake a stance"
      ]
    },
    {
      "id": "fight",
      "label": "Take the creator apart in the comments",
      "verdict": "acceptable",
      "consequence": "You may be right, but the conversation becomes about winning.",
      "considerations": [
        "Curiosity usually lands better"
      ]
    }
  ],
  "expertNote": "Healthy skepticism looks for credentials, sources and conflicts of interest. You do not need to win, just to know where to look.",
  "sayThisLine": "What does a dermatologist say about that?",
  "safetyNote": "General learning only. Not medical advice. For any skin concern, see a dermatologist or ask a pharmacist."
}
```

**Sample 3** (lesson `ri-06`)

```json
{
  "prompt": "She wants to try a retinoid. What is a good move?",
  "situation": {
    "narrative": "She mentions a retinol serum and asks what you think.",
    "facts": [
      {
        "label": "Her question",
        "value": "Is this too strong for me?"
      },
      {
        "label": "Your role",
        "value": "Friend, not clinician",
        "emphasis": "warning"
      },
      {
        "label": "Product type",
        "value": "Retinol serum"
      }
    ]
  },
  "options": [
    {
      "id": "ref",
      "label": "Say you are not the expert; suggest a pharmacist or dermatologist",
      "verdict": "best",
      "consequence": "You are supportive and honest, and she gets real guidance.",
      "considerations": [
        "Retinoids vary a lot in strength",
        "Prescription retinoids and pregnancy questions go to a clinician"
      ]
    },
    {
      "id": "dose",
      "label": "Tell her how often and how much to use",
      "verdict": "poor",
      "consequence": "You cannot know her skin. Specific instructions can do harm.",
      "considerations": [
        "Never give dosing advice to a friend"
      ]
    },
    {
      "id": "hype",
      "label": "Say everyone swears by it, go for it",
      "verdict": "poor",
      "consequence": "Popularity is not safety for her skin.",
      "considerations": [
        "Hype skips patch testing and pacing"
      ]
    }
  ],
  "expertNote": "Retinoids are a big topic with real nuance. A friend's best move is curiosity and a pointer to someone qualified.",
  "sayThisLine": "I'm not sure what's right for you. A pharmacist could help.",
  "safetyNote": "General learning only. Not medical advice. For any skin concern, see a dermatologist or ask a pharmacist."
}
```

### 2.7 `say-this`

**Sample 1** (lesson `cp-03`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "I'm doing skin cycling this month. Two rest nights, my barrier needed it."
  },
  "options": [
    {
      "id": "a",
      "text": "A rotation of active and rest nights",
      "isCorrect": true,
      "explanation": "Skin cycling is a popular rhythm: active nights alternate with recovery."
    },
    {
      "id": "b",
      "text": "She is treating a condition",
      "isCorrect": false,
      "explanation": "Not implied. It is a routine trend, not a diagnosis."
    },
    {
      "id": "c",
      "text": "Barrier means how thick her moisturizer is",
      "isCorrect": false,
      "explanation": "Barrier is the skin's outer layer, not a product."
    },
    {
      "id": "d",
      "text": "She stopped washing her face",
      "isCorrect": false,
      "explanation": "Rest nights usually mean gentle cleanse and moisturizer, not none."
    }
  ],
  "translation": "She alternates nights with active ingredients and nights of gentle, hydrating care, to give her skin a break.",
  "followUps": [
    {
      "line": "How's it going so far?",
      "why": "Open, warm, and lets her lead."
    },
    {
      "line": "What made you switch to that?",
      "why": "Invites her story without advising."
    }
  ],
  "noFakeExpertNote": "Don't advise on her actives. Ask about her experience."
}
```

**Sample 2** (lesson `lb-02`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "It's all fragrance-free but the INCI is long. The first five are what matter."
  },
  "options": [
    {
      "id": "a",
      "text": "Ingredients near the top make up most of the product",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Only the last five ingredients do anything",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "She counts calories in it",
      "isCorrect": false
    }
  ],
  "translation": "Ingredient lists run by amount. The top ingredients are the main body of the product; tiny amounts come later.",
  "followUps": [
    {
      "line": "Which ones do you look for?",
      "why": "Curious, invites her expertise."
    },
    {
      "line": "Is a long list a bad sign?",
      "why": "Honest question, not a verdict."
    }
  ],
  "noFakeExpertNote": "Do not memorize INCI names to impress her. Ask what she looks for."
}
```

**Sample 3** (lesson `kj-04`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "Got my cushion and a Japanese sunscreen in Seoul and Tokyo, PA++++ all the way."
  },
  "options": [
    {
      "id": "a",
      "text": "She picked up a compact and a sunscreen with a UVA rating",
      "isCorrect": true,
      "explanation": "PA is an Asian UVA rating; more plus signs, more UVA protection."
    },
    {
      "id": "b",
      "text": "PA is a payment app",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A cushion is a pillow for her skincare",
      "isCorrect": false
    }
  ],
  "translation": "She bought a sponge compact and a sunscreen with a high UVA rating on a trip to Korea and Japan.",
  "followUps": [
    {
      "line": "Was it easy to find your shade?",
      "why": "Shade range is a real topic in beauty."
    },
    {
      "line": "What do you like about those formulas?",
      "why": "Invites her enthusiasm."
    }
  ],
  "noFakeExpertNote": "You don't need to rank brands. Ask what she loves about them."
}
```

### 2.8 `fill-the-gap`

**Sample 1** (lesson `sp-05`)

```json
{
  "prompt": "Finish the sunscreen sentence.",
  "template": "{{a}} sunscreens use zinc oxide or titanium dioxide and sit on the skin.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "Mineral",
        "Chemical",
        "Natural",
        "Water-based"
      ],
      "correct": "Mineral"
    }
  ],
  "explanation": {
    "correct": "Mineral filters (zinc oxide, titanium dioxide) mainly sit on the skin and scatter or absorb UV. Chemical filters absorb UV within the skin layer.",
    "incorrect": "Zinc oxide and titanium dioxide are the mineral filters.",
    "sayThisLine": "I love how this mineral one feels."
  }
}
```

**Sample 2** (lesson `sb-03`)

```json
{
  "prompt": "Finish the skin-type sentence.",
  "template": "Skin types are {{a}} words, not {{b}}.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "descriptive",
        "medical",
        "permanent"
      ],
      "correct": "descriptive"
    },
    {
      "id": "b",
      "options": [
        "diagnoses",
        "opinions",
        "brands"
      ],
      "correct": "diagnoses"
    }
  ],
  "explanation": {
    "correct": "'Oily', 'dry' and 'combination' describe how skin tends to feel. They are useful conversation words, not diagnoses, and they change.",
    "incorrect": "Skin types are descriptions people use. Only a clinician diagnoses a condition."
  }
}
```

**Sample 3** (lesson `ro-05`)

```json
{
  "prompt": "Finish the layering line.",
  "template": "Apply products {{a}} to {{b}}.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "thinnest",
        "thickest"
      ],
      "correct": "thinnest"
    },
    {
      "id": "b",
      "options": [
        "thickest",
        "coolest"
      ],
      "correct": "thickest"
    }
  ],
  "explanation": {
    "correct": "Thin textures go first so they can spread; thick ones follow to seal.",
    "incorrect": "Go thin to thick, with SPF last in the morning."
  }
}
```

### 2.9 `estimate-slider`

**Sample 1** (lesson `sp-06`)

```json
{
  "prompt": "How often to reapply sunscreen outdoors, in hours?",
  "unit": "hours",
  "min": 0,
  "max": 8,
  "step": 0.5,
  "correctValue": 2,
  "tolerance": {
    "full": 0.5,
    "partial": 1
  },
  "explanation": {
    "correct": "About every two hours outdoors, and after swimming or heavy sweating.",
    "incorrect": "The usual guidance is about every two hours, sooner after swimming or sweating.",
    "sayThisLine": "Want me to grab the sunscreen?"
  }
}
```

**Sample 2** (lesson `sp-03`)

```json
{
  "prompt": "What share of UVB does SPF 30 block, roughly?",
  "unit": "percent",
  "min": 50,
  "max": 100,
  "step": 1,
  "correctValue": 97,
  "tolerance": {
    "full": 1,
    "partial": 3
  },
  "explanation": {
    "correct": "SPF 30 filters roughly 97 percent of UVB in lab conditions. SPF 50 is about 98. The gain gets small, so reapplying matters more than chasing big numbers.",
    "incorrect": "Roughly 97 percent. The jump from 30 to 50 is small, about one point.",
    "sayThisLine": "SPF 30 and I reapply."
  }
}
```

**Sample 3** (lesson `ri-05`)

```json
{
  "prompt": "Typical OTC retinol strength, as a percent of a product?",
  "unit": "percent",
  "min": 0,
  "max": 5,
  "step": 0.05,
  "correctValue": 0.3,
  "tolerance": {
    "full": 0.2,
    "partial": 0.4
  },
  "explanation": {
    "correct": "Over-the-counter retinol products are often in the 0.1 to 1 percent range. Strength is only one part; formula and skin matter too.",
    "incorrect": "Most OTC retinol sits well under 1 percent. It is a conversation fact, not a dosing tip.",
    "sayThisLine": "I'm curious what percent she uses."
  }
}
```

### 2.10 `hotspot-tap`

**Sample 1** (lesson `lb-01`)

```json
{
  "prompt": "Tap the ingredient list.",
  "diagram": {
    "diagramId": "skincare-product-label",
    "aspectRatio": 0.8,
    "alt": "A generic fictional product back panel with four blocks: a directions box, an ingredient list, a batch code and a small jar-and-months symbol."
  },
  "hotspots": [
    {
      "id": "dir",
      "label": "Directions box",
      "shape": {
        "kind": "rect",
        "x": 0.08,
        "y": 0.1,
        "w": 0.84,
        "h": 0.2
      }
    },
    {
      "id": "inci",
      "label": "Ingredient list",
      "shape": {
        "kind": "rect",
        "x": 0.08,
        "y": 0.34,
        "w": 0.84,
        "h": 0.3
      }
    },
    {
      "id": "batch",
      "label": "Batch code",
      "shape": {
        "kind": "rect",
        "x": 0.08,
        "y": 0.68,
        "w": 0.4,
        "h": 0.12
      }
    },
    {
      "id": "pao",
      "label": "Period-after-opening symbol",
      "shape": {
        "kind": "rect",
        "x": 0.55,
        "y": 0.68,
        "w": 0.37,
        "h": 0.22
      }
    }
  ],
  "correctHotspotIds": [
    "inci"
  ],
  "explanation": {
    "correct": "The ingredient list is the long run of names. INCI is the standard naming system.",
    "incorrect": "The list is the long paragraph of names, usually in small type. Directions and batch codes are separate."
  }
}
```

**Sample 2** (lesson `lb-04`)

```json
{
  "prompt": "Tap the open-jar symbol.",
  "diagram": {
    "diagramId": "skincare-product-label",
    "aspectRatio": 0.8,
    "alt": "The same generic back panel, with the small symbol at the lower right showing an open jar and a number of months."
  },
  "hotspots": [
    {
      "id": "dir",
      "label": "Directions box",
      "shape": {
        "kind": "rect",
        "x": 0.08,
        "y": 0.1,
        "w": 0.84,
        "h": 0.2
      }
    },
    {
      "id": "inci",
      "label": "Ingredient list",
      "shape": {
        "kind": "rect",
        "x": 0.08,
        "y": 0.34,
        "w": 0.84,
        "h": 0.3
      }
    },
    {
      "id": "batch",
      "label": "Batch code",
      "shape": {
        "kind": "rect",
        "x": 0.08,
        "y": 0.68,
        "w": 0.4,
        "h": 0.12
      }
    },
    {
      "id": "pao",
      "label": "Period-after-opening symbol",
      "shape": {
        "kind": "rect",
        "x": 0.55,
        "y": 0.68,
        "w": 0.37,
        "h": 0.22
      }
    }
  ],
  "correctHotspotIds": [
    "pao"
  ],
  "explanation": {
    "correct": "An open jar with a number means months you can use the product after opening (PAO). Batch codes are for tracing the product.",
    "incorrect": "The open-jar symbol is the PAO. Batch codes are a different stamp."
  }
}
```

**Sample 3** (lesson `sb-01`)

```json
{
  "prompt": "Tap the outermost layer of skin.",
  "diagram": {
    "diagramId": "skincare-skin-layers",
    "aspectRatio": 1.2,
    "alt": "A simplified, face-free cross-section of skin: a thin top layer, a thicker middle layer and a fatty bottom layer, with a hair shaft and a pore."
  },
  "hotspots": [
    {
      "id": "epi",
      "label": "Epidermis (outer)",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.05,
        "w": 0.9,
        "h": 0.18
      }
    },
    {
      "id": "der",
      "label": "Dermis (middle)",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.26,
        "w": 0.9,
        "h": 0.3
      }
    },
    {
      "id": "hyp",
      "label": "Hypodermis (deep)",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.6,
        "w": 0.9,
        "h": 0.3
      }
    }
  ],
  "correctHotspotIds": [
    "epi"
  ],
  "explanation": {
    "correct": "The epidermis is the outermost layer, where the barrier sits. The dermis below holds collagen and blood vessels.",
    "incorrect": "The barrier lives in the epidermis, the thin outer layer. The dermis is beneath it."
  }
}
```

### 2.11 `talk-track`

See section 4: eight full authored tracks.

## 3. Playbook terms (84)

Definition plus an example line in the enthusiast's voice. Items tagged [verify] are regulatory facts to re-check at release.

| # | Term | Definition | Example line |
|---|---|---|---|
| 1 | Skin barrier | The skin's outer layer that slows water loss and keeps most irritants out. | "My barrier's been cranky, so I'm keeping it simple this week." |
| 2 | Stratum corneum | The very outer layer of the epidermis; the 'bricks and mortar' part of the barrier. | "It all happens in the stratum corneum, honestly." |
| 3 | Epidermis / dermis | The outer and middle layers of skin; the epidermis is thin, the dermis holds collagen and vessels. | "Most topical products only work in the epidermis." |
| 4 | Skin type | A casual description (dry, oily, combination, normal) of how skin tends to feel; not a diagnosis. | "I'm combination, oily in the T-zone." |
| 5 | T-zone | Forehead, nose and chin, where many people feel more shine. | "My T-zone gets shiny by lunch." |
| 6 | Dry vs dehydrated | A popular framing: dry lacks oil, dehydrated lacks water. A simplification, but widely used. | "It's dehydrated, not dry, so I'm adding a humectant." |
| 7 | Sensitive skin | A common self-description for skin that stings or reddens easily; not a diagnosis. | "I'm sensitive, so I patch test everything." |
| 8 | Sensitized skin | Skin that is temporarily irritated, often after over-doing actives. | "I sensitized it with too many acids." |
| 9 | Fitzpatrick scale | A six-point sun-reaction scale used by clinicians; not a beauty label and not a risk pass. | "That's a clinical scale, not a shade chart." |
| 10 | Undertone | Cool, warm or neutral hue under a skin shade; used in makeup shade matching. | "I'm neutral-olive, so matching is a saga." |
| 11 | Cleanser | A product that removes dirt, oil and sunscreen; types include gel, cream, oil, balm. | "A gentle gel cleanser is my whole morning." |
| 12 | Double cleanse | An oil or balm cleanser first, then a water-based one, often at night. | "Sunscreen night means I double cleanse." |
| 13 | Micellar water | A rinse-free-style cleansing water with tiny surfactant clusters. | "I use micellar water when I'm lazy." |
| 14 | Surfactant | The cleaning agent in cleansers; some are gentler than others. | "That cleanser has a mild surfactant system." |
| 15 | Toner / essence | Thin, watery steps after cleansing; 'toner' and 'essence' vary by brand. | "I do an essence before my serum." |
| 16 | Serum | A light, concentrated treatment, usually under moisturizer. | "Serum first, cream after." |
| 17 | Moisturizer | A cream or lotion that helps skin hold water; mixes humectants, emollients and occlusives. | "I switch to a richer cream in winter." |
| 18 | Humectant | Ingredient that pulls water toward the skin, like glycerin or hyaluronic acid. | "It's glycerin-heavy, very humectant." |
| 19 | Emollient | Ingredient that softens and smooths the surface. | "Squalane is my favorite emollient." |
| 20 | Occlusive | Ingredient that seals the surface to slow water loss, like petrolatum. | "I use an occlusive on dry nights." |
| 21 | Slugging | Sealing with a thick occlusive layer overnight; a social trend, not for everyone. | "My winter routine ends with slugging." |
| 22 | Ceramides | Skin-identical fats found in the barrier; popular moisturizer ingredient. | "Ceramides are the mortar, right?" |
| 23 | Hyaluronic acid | A humectant ingredient that binds water; works best with a follow-up moisturizer. | "HA, then cream to lock it in." |
| 24 | Glycerin | A classic, inexpensive humectant. | "Glycerin is underrated." |
| 25 | SPF | Sun protection factor: lab measure of sunburn (UVB) protection. | "I never skip SPF." |
| 26 | Broad spectrum | US label term: protection against both UVB and UVA, measured by a test. | "Check that it says broad spectrum." |
| 27 | UVA / UVB | Two bands of UV; UVB is mostly sunburn, UVA goes deeper and is under-rated. | "UVA comes through windows, which surprises people." |
| 28 | PA rating | An Asian UVA-protection rating shown as plus signs (PA+ to PA++++). | "It's PA++++, which is a UVA thing." |
| 29 | Mineral sunscreen | Uses zinc oxide or titanium dioxide filters that sit on the skin. | "Mineral, but it leaves a white cast." |
| 30 | Chemical sunscreen | Uses organic filters (like avobenzone) that absorb UV; 'chemical' describes the mechanism, not danger. | "It's a chemical one, feels invisible." |
| 31 | White cast | Chalky tint left by some sunscreens, especially on deeper skin tones. | "Nothing leaves a white cast on me anymore." |
| 32 | Water resistant (40/80) | US label for how many minutes the SPF holds in water; not waterproof. | "It says water resistant 80, I still reapply." |
| 33 | Reapply | Put on sunscreen again, typically about every two hours outdoors. | "Reapply at lunch." |
| 34 | INCI | International Nomenclature of Cosmetic Ingredients: the standard naming for ingredient lists. | "I read the INCI before I buy." |
| 35 | Ingredient order | Lists go by amount, most to least, until about 1 percent. | "It's in the top five." |
| 36 | Fragrance / parfum | A catch-all label term for scents; some people avoid it for sensitivity. | "I stick to fragrance-free." |
| 37 | Fragrance-free vs unscented | Fragrance-free has no added fragrance; unscented may still mask odors. | "Fragrance-free, not just unscented." |
| 38 | Non-comedogenic | Claim that a product is unlikely to clog pores; not a standardized term. | "It says non-comedogenic, but is that regulated?" |
| 39 | Hypoallergenic | Marketing term suggesting lower allergy risk; no common legal definition in the US. | "Hypoallergenic is a vibe, not a guarantee." |
| 40 | Dermatologist tested | A claim that someone tested; not an endorsement. | "Tested by whom, though?" |
| 41 | PAO symbol | Open-jar icon with months (e.g. 12M) for use after opening. | "PAO says twelve months." |
| 42 | Patch test | Trying a product on a small area before wider use; lowers, not removes, risk. | "I patch test new things behind my ear." |
| 43 | Active ingredient (skincare sense) | Informal term for ingredients that do something measurable, like acids or retinoids. | "Go slow with new actives." |
| 44 | Exfoliation | Removing dead surface cells by physical scrubs or chemical acids. | "I only exfoliate twice a week." |
| 45 | AHA | Alpha hydroxy acids such as glycolic and lactic; water-soluble. | "Lactic acid is my AHA." |
| 46 | BHA | Beta hydroxy acid, mainly salicylic; oil-soluble. | "BHA for my T-zone." |
| 47 | PHA | Polyhydroxy acids such as gluconolactone; gentle reputation. | "PHA feels the softest to me." |
| 48 | Over-exfoliation | Doing too much exfoliating; skin may feel stingy, tight or shiny. | "I over-exfoliated and had to pause." |
| 49 | Retinoid | Family of vitamin A derivatives; some are cosmetic, some are prescription. | "Retinoids are a whole topic." |
| 50 | Retinol | An over-the-counter retinoid form popular in cosmetics. | "I'm easing into retinol." |
| 51 | Retinal | A retinoid one step closer to retinoic acid than retinol. | "Retinal is stronger than retinol." |
| 52 | Adapalene | A retinoid; a low-strength gel is sold over the counter in the US, stronger forms by prescription [verify]. | "Adapalene's in the pharmacy aisle now, I think." |
| 53 | Tretinoin | Prescription retinoid; ask a clinician. | "My derm handles the tretinoin side." |
| 54 | Niacinamide | Vitamin B3 form common in serums and moisturizers. | "Niacinamide is in everything." |
| 55 | Vitamin C (L-ascorbic acid) | An antioxidant form that is unstable, often at low pH. | "Mine's L-ascorbic, in a dark bottle." |
| 56 | Peptides | Short amino-acid chains used in moisturizers; evidence varies by type. | "Peptides are a category, not one ingredient." |
| 57 | Antioxidants | Ingredients that neutralize free radicals; often used in daytime routines. | "I layer an antioxidant under SPF." |
| 58 | Azelaic acid | A multi-use acid sold OTC at lower strength and by prescription higher; ask a pharmacist. | "Azelaic acid, ten percent." |
| 59 | Purging | A claim that skin gets worse before it gets better; contested and not a safe excuse to ignore irritation. | "Is it purging or is it irritation? Don't guess." |
| 60 | Skin cycling | A popular rotation of active nights and rest nights. | "Two rest nights in my cycle." |
| 61 | Sandwiching | Putting an active between layers of moisturizer to buffer it. | "Moisturizer, retinol, moisturizer." |
| 62 | Skinimalism | A minimal routine philosophy: fewer steps, better basics. | "I'm a skinimalist now." |
| 63 | Skintellectual | Enthusiast who reads ingredient science and debates formulation. | "She's a full skintellectual." |
| 64 | Dupe | A cheaper product meant to echo a pricier one; quality and ingredients vary. | "It's a decent dupe at a third of the price." |
| 65 | Holy grail | A product someone would rebuy forever. | "That cleanser is my holy grail." |
| 66 | Glass skin | K-beauty ideal of a smooth, luminous look; a trend, not a goal. | "Glass skin is the vibe." |
| 67 | Ampoule | A small concentrated treatment step in K-beauty. | "One ampoule a night." |
| 68 | Cushion | Compact with sponge holding liquid product, often sunscreen or base. | "Cushion and done." |
| 69 | Formulation | How ingredients are combined, including pH, stability and texture. | "It's more about the formulation than the hero ingredient." |
| 70 | Emulsion | A mixture of oil and water; moisturizers are often emulsions. | "A light emulsion is perfect." |
| 71 | Preservative | Ingredient that stops microbes from growing in a product; needed for water-based products. | "Preservative-free isn't automatically better." |
| 72 | pH | Acidity scale; many actives need a certain range to work and stay gentle. | "Low pH is part of why it tingles." |
| 73 | Clean beauty | A marketing category with no single legal definition; debated. | "Clean beauty is a contested term." |
| 74 | Clinically proven | A claim that may rest on small or company-run studies; look for what was measured. | "Clinically proven by whom?" |
| 75 | Functional cosmetics (Korea) | Korean regulatory category for cosmetics with certain claims like UV or wrinkle care [verify]. | "Korea has a functional cosmetics category." |
| 76 | Quasi-drug (Japan) | Japanese category between cosmetics and drugs for certain claims [verify]. | "In Japan that's a quasi-drug." |
| 77 | MoCRA | US Modernization of Cosmetics Regulation Act (2022), giving FDA more cosmetics oversight [verify]. | "MoCRA changed the reporting rules." |
| 78 | Dermatologist | A medical doctor specialized in skin, hair and nails. | "Ask a dermatologist, not a comment section." |
| 79 | Pharmacist | A professional who can explain ingredients, interactions and OTC options. | "My pharmacist explained what I could layer." |
| 80 | #ad / sponsored | Disclosure that a creator was paid or gifted. | "Is that sponsored?" |
| 81 | Haul / PR box | Video of a big purchase or brand-sent gifts. | "She posted a haul." |
| 82 | Limited edition / drop | A product released in a short window or number. | "The drop sold out." |
| 83 | Reformulation | When a brand changes a product's recipe. | "They reformulated and it feels different." |
| 84 | UV index | A daily scale of expected sun strength at a place. | "UV index is a nine today." |

## 4. Talk Track scenarios (8)

### 4.1 The shelfie (`tt-shelfie`, lesson `cl-01`)

Each reply has a coach note; 'good', 'meh' and 'cringe' replies are the +15/+10, 0/-5 and -10 or lower deltas.

```json
{
  "title": "The shelfie",
  "setting": "She sends a photo of her bathroom shelf.",
  "exchanges": [
    {
      "theirMessage": "Finally organized my shelf. Cleanser, essence, serums, SPF. The little routine I love.",
      "replies": [
        {
          "id": "a",
          "text": "That looks so calm. Which one is your favorite?",
          "smoothDelta": 15,
          "theirResponse": "Oh that's easy, the essence. It's my favorite step.",
          "coachNote": "Curious and kind. You asked about her joy."
        },
        {
          "id": "b",
          "text": "That's a lot of products. Do you need all of them?",
          "smoothDelta": -10,
          "theirResponse": "It's a hobby. It's fine...",
          "coachNote": "Sounds like judging her hobby. Ask, don't audit."
        },
        {
          "id": "c",
          "text": "You should add a retinol to that.",
          "smoothDelta": -15,
          "theirResponse": "I'm good, thanks.",
          "coachNote": "Unprompted advice about her skin. Never."
        }
      ]
    },
    {
      "theirMessage": "It's like a little ritual. Five minutes where I'm not thinking about anything else.",
      "replies": [
        {
          "id": "a",
          "text": "That sounds great. Do you do it morning and night?",
          "smoothDelta": 15,
          "theirResponse": "Both. Morning's quick, night's longer.",
          "coachNote": "You heard the ritual, not just the products."
        },
        {
          "id": "b",
          "text": "So it's basically a fancy face wash.",
          "smoothDelta": -10,
          "theirResponse": "Ha, not really...",
          "coachNote": "Flattening what she loves."
        },
        {
          "id": "c",
          "text": "Teach me your morning one?",
          "smoothDelta": 10,
          "theirResponse": "Sure, it's simpler than it looks.",
          "coachNote": "Invites her to teach. Nice."
        }
      ]
    }
  ],
  "closingNote": "Ask about the ritual, not her skin. The shelf is the conversation, not her face."
}
```

### 4.2 Sunscreen every day (`tt-spf-daily`, lesson `cl-02`)

Each reply has a coach note; 'good', 'meh' and 'cringe' replies are the +15/+10, 0/-5 and -10 or lower deltas.

```json
{
  "title": "Sunscreen every day",
  "setting": "She packs for a sunny weekend.",
  "exchanges": [
    {
      "theirMessage": "I wear SPF even when it's cloudy. UV doesn't care about clouds.",
      "replies": [
        {
          "id": "a",
          "text": "Makes sense. Do you have a favorite texture?",
          "smoothDelta": 15,
          "theirResponse": "Yes, a light gel one. No white cast on me.",
          "coachNote": "Real curiosity."
        },
        {
          "id": "b",
          "text": "I never wear sunscreen, it's a hassle.",
          "smoothDelta": -5,
          "theirResponse": "Hm. I guess everyone's different.",
          "coachNote": "Honest, but you closed the topic."
        },
        {
          "id": "c",
          "text": "SPF 100 means I'm safe all day, right?",
          "smoothDelta": -10,
          "theirResponse": "Not quite, you still reapply.",
          "coachNote": "A myth worth correcting gently."
        }
      ]
    },
    {
      "theirMessage": "I reapply every two hours outside, it's a whole system.",
      "replies": [
        {
          "id": "a",
          "text": "Can I borrow yours now and then?",
          "smoothDelta": 10,
          "theirResponse": "Sure, bring your own for the trip.",
          "coachNote": "Friendly, practical."
        },
        {
          "id": "b",
          "text": "Every two hours? That's obsessive.",
          "smoothDelta": -10,
          "theirResponse": "It's actually the usual advice...",
          "coachNote": "Don't mock good habits."
        },
        {
          "id": "c",
          "text": "I'll bring a spare in my bag.",
          "smoothDelta": 15,
          "theirResponse": "Thank you, that helps.",
          "coachNote": "Helpful without lecturing."
        }
      ]
    }
  ],
  "closingNote": "Protective habits get respect, not teasing."
}
```

### 4.3 Retinol week (`tt-new-retinol`, lesson `cl-03`)

Each reply has a coach note; 'good', 'meh' and 'cringe' replies are the +15/+10, 0/-5 and -10 or lower deltas.

```json
{
  "title": "Retinol week",
  "setting": "She mentions a new retinol and her skin feels dramatic.",
  "exchanges": [
    {
      "theirMessage": "I started a retinol and my skin is being dramatic. Dry patches, tight all over.",
      "replies": [
        {
          "id": "a",
          "text": "Ugh, that sounds annoying. Is someone helping you with it?",
          "smoothDelta": 15,
          "theirResponse": "I'll ask my pharmacist tomorrow.",
          "coachNote": "Supportive and points to a pro."
        },
        {
          "id": "b",
          "text": "Use it every night, it will pass.",
          "smoothDelta": -20,
          "theirResponse": "I'm not sure that's right...",
          "coachNote": "Never instruct. Risky."
        },
        {
          "id": "c",
          "text": "Just put on more moisturizer and keep going.",
          "smoothDelta": -15,
          "theirResponse": "Hm, I'll check.",
          "coachNote": "Advice without knowing her skin."
        }
      ]
    },
    {
      "theirMessage": "Yeah I think I'll pause it. Sorry, I wanted tonight to be fun.",
      "replies": [
        {
          "id": "a",
          "text": "No apology needed. Want to watch something cozy?",
          "smoothDelta": 15,
          "theirResponse": "That sounds perfect.",
          "coachNote": "Kind and warm."
        },
        {
          "id": "b",
          "text": "Fix your skin first, then we'll go.",
          "smoothDelta": -15,
          "theirResponse": "Wow, okay.",
          "coachNote": "Never make her skin a condition."
        },
        {
          "id": "c",
          "text": "I can bring tea.",
          "smoothDelta": 10,
          "theirResponse": "Aw, sweet.",
          "coachNote": "Simple care."
        }
      ]
    }
  ],
  "closingNote": "You are a friend, not a clinician. Care, curiosity, and a pointer to a pharmacist or dermatologist."
}
```

### 4.4 The ingredient list (`tt-inci-list`, lesson `lb-02`)

Each reply has a coach note; 'good', 'meh' and 'cringe' replies are the +15/+10, 0/-5 and -10 or lower deltas.

```json
{
  "title": "The ingredient list",
  "setting": "She reads a bottle in the store.",
  "exchanges": [
    {
      "theirMessage": "Look, niacinamide is fourth. Fourth! That's a lot for this price.",
      "replies": [
        {
          "id": "a",
          "text": "Fourth seems high. Why does position matter?",
          "smoothDelta": 15,
          "theirResponse": "Order goes by amount, so it's a big share.",
          "coachNote": "Good question, teaches you both."
        },
        {
          "id": "b",
          "text": "What's niacinamide?",
          "smoothDelta": 10,
          "theirResponse": "A B-vitamin form people love for texture and tone.",
          "coachNote": "Honest question."
        },
        {
          "id": "c",
          "text": "Fourth is better than first for sure.",
          "smoothDelta": -10,
          "theirResponse": "No, first is the most.",
          "coachNote": "Faking it."
        }
      ]
    },
    {
      "theirMessage": "Also no fragrance. I love when brands skip it.",
      "replies": [
        {
          "id": "a",
          "text": "Is that a preference for your skin or the scent?",
          "smoothDelta": 10,
          "theirResponse": "Both, honestly.",
          "coachNote": "Open question."
        },
        {
          "id": "b",
          "text": "Fragrance-free means it cannot cause reactions.",
          "smoothDelta": -10,
          "theirResponse": "Not really, any ingredient can.",
          "coachNote": "Overpromise."
        },
        {
          "id": "c",
          "text": "I'll trust you on this one.",
          "smoothDelta": 10,
          "theirResponse": "Ha. Careful, I'm still learning too.",
          "coachNote": "Humble."
        }
      ]
    }
  ],
  "closingNote": "Ask what she looks for. Never fake INCI fluency."
}
```

### 4.5 The influencer take (`tt-influencer`, lesson `cl-04`)

Each reply has a coach note; 'good', 'meh' and 'cringe' replies are the +15/+10, 0/-5 and -10 or lower deltas.

```json
{
  "title": "The influencer take",
  "setting": "She forwards a viral skincare video.",
  "exchanges": [
    {
      "theirMessage": "This creator says dermatologists are lying about SPF. Thoughts?",
      "replies": [
        {
          "id": "a",
          "text": "What are their credentials? And who pays them?",
          "smoothDelta": 15,
          "theirResponse": "Good question, let me check.",
          "coachNote": "Healthy skepticism without a fight."
        },
        {
          "id": "b",
          "text": "Creators are usually right, they test it all.",
          "smoothDelta": -10,
          "theirResponse": "Hmm, not sure.",
          "coachNote": "Trust without checking."
        },
        {
          "id": "c",
          "text": "What do dermatologists say about it?",
          "smoothDelta": 15,
          "theirResponse": "Let's look together.",
          "coachNote": "Go to the qualified source."
        }
      ]
    },
    {
      "theirMessage": "Half of my feed disagrees with the other half.",
      "replies": [
        {
          "id": "a",
          "text": "That's the internet. Maybe we only trust what's sourced?",
          "smoothDelta": 10,
          "theirResponse": "Fair.",
          "coachNote": "Steady."
        },
        {
          "id": "b",
          "text": "Just pick a side.",
          "smoothDelta": -5,
          "theirResponse": "Hm.",
          "coachNote": "Dismissive."
        },
        {
          "id": "c",
          "text": "Want to ask your pharmacist what they think?",
          "smoothDelta": 10,
          "theirResponse": "Good idea.",
          "coachNote": "A qualified opinion."
        }
      ]
    }
  ],
  "closingNote": "Skepticism is a skill. You do not have to win, just know where good information lives."
}
```

### 4.6 Launch day (`tt-launch-day`, lesson `lc-02`)

Each reply has a coach note; 'good', 'meh' and 'cringe' replies are the +15/+10, 0/-5 and -10 or lower deltas.

```json
{
  "title": "Launch day",
  "setting": "A limited-edition set drops at noon.",
  "exchanges": [
    {
      "theirMessage": "The limited set drops at noon. I'm taking a break from work to get it.",
      "replies": [
        {
          "id": "a",
          "text": "Fun. What makes that one special to you?",
          "smoothDelta": 15,
          "theirResponse": "The packaging and it's a full-size set.",
          "coachNote": "Curious about the why."
        },
        {
          "id": "b",
          "text": "It's just marketing.",
          "smoothDelta": -10,
          "theirResponse": "Well, yes, but it's fun.",
          "coachNote": "Dismisses the joy."
        },
        {
          "id": "c",
          "text": "Want me to set a reminder?",
          "smoothDelta": 10,
          "theirResponse": "Oh that'd be great.",
          "coachNote": "Helpful."
        }
      ]
    },
    {
      "theirMessage": "Sold out in minutes. I'm bummed.",
      "replies": [
        {
          "id": "a",
          "text": "Ouch. Will they restock?",
          "smoothDelta": 10,
          "theirResponse": "Maybe. I'll wait.",
          "coachNote": "Practical."
        },
        {
          "id": "b",
          "text": "Good, you didn't need it.",
          "smoothDelta": -15,
          "theirResponse": "Wow, okay.",
          "coachNote": "Never say what she needs."
        },
        {
          "id": "c",
          "text": "I'm sorry. Want to get coffee instead?",
          "smoothDelta": 15,
          "theirResponse": "Yes, please.",
          "coachNote": "Warm."
        }
      ]
    }
  ],
  "closingNote": "Hype is fun. You can enjoy it with her without judging spending or skin."
}
```

### 4.7 The Seoul haul (`tt-seoul-haul`, lesson `kj-06`)

Each reply has a coach note; 'good', 'meh' and 'cringe' replies are the +15/+10, 0/-5 and -10 or lower deltas.

```json
{
  "title": "The Seoul haul",
  "setting": "She just got back from Seoul.",
  "exchanges": [
    {
      "theirMessage": "I came back with a suitcase of essences and sheet masks. Seoul beauty shops are dangerous.",
      "replies": [
        {
          "id": "a",
          "text": "Tell me the best thing you found.",
          "smoothDelta": 15,
          "theirResponse": "A rice essence, it's my new obsession.",
          "coachNote": "You invited her story."
        },
        {
          "id": "b",
          "text": "You really do this ten-step thing?",
          "smoothDelta": 0,
          "theirResponse": "Not every night. It's a menu, not a rule.",
          "coachNote": "Fine, but you assumed. Ask instead."
        },
        {
          "id": "c",
          "text": "Skincare is a scam, honestly.",
          "smoothDelta": -15,
          "theirResponse": "...okay.",
          "coachNote": "Do not dismiss her passion."
        }
      ]
    },
    {
      "theirMessage": "I'm doing one sheet mask tonight. Want to join?",
      "replies": [
        {
          "id": "a",
          "text": "Yes, let's do it together.",
          "smoothDelta": 15,
          "theirResponse": "Yay!",
          "coachNote": "Sharing the hobby."
        },
        {
          "id": "b",
          "text": "I'll watch. I don't know what to pick.",
          "smoothDelta": 10,
          "theirResponse": "I'll pick for you.",
          "coachNote": "Honest and fun."
        },
        {
          "id": "c",
          "text": "Not my thing.",
          "smoothDelta": -5,
          "theirResponse": "Fair.",
          "coachNote": "Polite, but a missed connection."
        }
      ]
    }
  ],
  "closingNote": "You are not expected to love it. You can still enjoy what she enjoys."
}
```

### 4.8 The gift question (`tt-gift`, lesson `lc-05`)

Each reply has a coach note; 'good', 'meh' and 'cringe' replies are the +15/+10, 0/-5 and -10 or lower deltas.

```json
{
  "title": "The gift question",
  "setting": "You want to surprise her with something skincare-related.",
  "exchanges": [
    {
      "theirMessage": "What do you want for your birthday? I'm terrible at guessing.",
      "replies": [
        {
          "id": "a",
          "text": "A gift card to your favorite shop, so you choose.",
          "smoothDelta": 15,
          "theirResponse": "Sweet, that's perfect.",
          "coachNote": "Respects her taste and skin."
        },
        {
          "id": "b",
          "text": "A serum for your dull skin.",
          "smoothDelta": -20,
          "theirResponse": "Excuse me?",
          "coachNote": "Never comment on her skin."
        },
        {
          "id": "c",
          "text": "Whatever you love. What's on your wishlist?",
          "smoothDelta": 15,
          "theirResponse": "I'll send you a list.",
          "coachNote": "Asks, doesn't assume."
        }
      ]
    },
    {
      "theirMessage": "Also, I'm sensitive to a lot of stuff, so please don't guess.",
      "replies": [
        {
          "id": "a",
          "text": "Totally. I'll stick to what's on your list.",
          "smoothDelta": 15,
          "theirResponse": "Thank you.",
          "coachNote": "Listening."
        },
        {
          "id": "b",
          "text": "I can ask the store staff to help.",
          "smoothDelta": 5,
          "theirResponse": "Maybe, but a list is easiest.",
          "coachNote": "Decent, but the list is better."
        },
        {
          "id": "c",
          "text": "I'll get something cheap to test.",
          "smoothDelta": -10,
          "theirResponse": "Hmm, please don't.",
          "coachNote": "Unwanted product on sensitive skin."
        }
      ]
    }
  ],
  "closingNote": "Skincare gifts are personal. When in doubt, ask or pick something she chose."
}
```

## 5. Talk Track roster at launch (16)

Authored above: `tt-shelfie`, `tt-spf-daily`, `tt-new-retinol`, `tt-inci-list`, `tt-influencer`, `tt-launch-day`, `tt-seoul-haul`, `tt-gift`. To author next: `tt-winter-dryness` (she swaps textures for winter), `tt-label-claims` (she points out a marketing claim), `tt-patch-test` (she patch tests a gift), `tt-sunscreen-trip` (packing for a sunny trip), `tt-derm-visit` (she mentions an appointment; reply with support, not curiosity about the reason), `tt-dupe-debate` (she loves a dupe), `tt-tween-cousin` (a younger cousin asks for strong actives), `tt-ingredient-deep-dive` (a skintellectual explains pH).

## 6. Asset needs (all `original-swoond`)

| Asset | Used by | Notes |
|---|---|---|
| Texture illustrations (gel, cream, balm, lotion, oil, essence) | `visual-id`, `term-match` | Abstract blobs on neutral ground; no faces or skin. |
| Packaging silhouettes (jar, tube, dropper, airless pump, stick) | `visual-id` | Generic, unbranded, no logos. |
| UV band spectrum diagram | `visual-id`, `hotspot-tap` | Procedural. |
| `skincare-skin-layers` | `hotspot-tap` | Face-free cross-section. |
| `skincare-product-label` | `hotspot-tap` | Fictional label with invented ingredient list (real INCI names, invented proportions) and invented brand name 'Example Lab'. |
| Skin-tone swatches | `visual-id` | Abstract rounded squares across a wide range; used for undertone and white-cast lessons; never a face or body. |
| Sun-protection layers icon set | `visual-id` | Hat, shade, clothing, sunscreen. |

## 7. Voice and safety notes

- Never comment on anyone's skin. Coach notes flag 'you should use X' and 'your skin looks...' as cringe.
- Never include before/after imagery, filtered faces or skin close-ups.
- No brand is ranked, recommended or disparaged; invented brands only in examples.
- Explain concepts; do not tell anyone what to use. Wherever 'what should I do about my skin' is implied, the best answer is 'a pharmacist or dermatologist can help with yours'.
- Sun content follows conservative mainstream guidance (AAD, FDA, WHO); dates and rules marked [verify].
- Skin-tone inclusive: sunscreen, shade-range and scar/hyperpigmentation-adjacent examples use a range of tones; Fitzpatrick is taught as a clinician's sun-reaction scale, never as a beauty label.
- Every Swoon'd unit on this course needs the qualified review gate in `SAFETY_REVIEW_CHECKLIST.md` before release.
