# Camping: Native Exercise Plan (Tier B)

Native exercise plan for the `camping` course. Every payload below conforms to `docs/contracts/native-exercises/v1/<type>.schema.json` (all 63 were validated with ajv 2020-12 on 2026-09-30). Type behavior, scoring and UI are in `docs/native-exercises/CATALOG.md`. The course uses **no Unity sims**, so there is no sim spec; see `CDS.md` section 5. Asset licence id: `original-swoond` (asset paths are placeholders for original illustrations).

## 1. Safety constraints (apply to every exercise)

- **Swoon'd teaches appreciation, not a substitute for safety training.** It does not replace wilderness first aid, fire safety, food-safety or swiftwater training, or local ranger guidance. A **qualified safety review is a release gate** (CDS section 13).
- Every `decision-scenario` carries a `safetyNote`. Scenarios never call a site, fire, water source, food, crossing or weather window "safe"; the best answer is the conservative one, and leaving, skipping the fire or asking the agency is always a valid best answer when risk rises.
- **No gamified pressure on hazards:** no countdown timers, streak bonuses or speed rewards on scenarios about fire, carbon monoxide, wildlife, water, cold, heat, lightning, floods or evacuation. Hearts follow the catalog rule; copy never shames.
- **Absolute rules stay absolute:** never burn fuel (stove, lantern, heater, charcoal, warm coals) in a tent or vehicle; never use accelerants; never feed wildlife; never leave a fire unattended; never leave a child or pet in a vehicle. Rules that vary by place (fire stage, food storage, canisters, firewood, setbacks) are taught as "follow the posted local rule" with the general principle.
- Sources for the numbers used here: CDC (boil water 1 minute, 3 minutes above 6,500 ft; carbon monoxide), NPS (100 yards from bears and wolves, 25 yards from other wildlife), Leave No Trace Center (cathole 6-8 inches, about 200 feet from water; seven principles), USDA (40 F, two hours, one hour above 90 F), NWS (when thunder roars, go indoors; wait 30 minutes). Verified by web search 2026-09-30; re-verify before release (NOTES).
- Voice: warm coach, never condescending, never about the crush; explanations teach why, not just the rule.
- Diagrams are procedural (`original-swoond`); no scraped imagery.

## 2. Types used and planned counts

| Native type | Planned use | Est. authored items at launch | Samples below |
|---|---|---|---|
| `multiple-choice` | see CDS section 12 | ~200 | 5 |
| `binary-call` | see CDS section 12 | ~50 | 4 |
| `term-match` | see CDS section 12 | ~36 | 4 |
| `sequence-order` | see CDS section 12 | ~50 | 4 |
| `visual-id` | see CDS section 12 | ~24 | 4 |
| `decision-scenario` | see CDS section 12 | ~150 | 15 |
| `talk-track` | see CDS section 12 | ~24 | 8 |
| `fill-the-gap` | see CDS section 12 | ~33 | 4 |
| `estimate-slider` | see CDS section 12 | ~33 | 5 |
| `hotspot-tap` | see CDS section 12 | ~30 | 4 |
| `say-this` | see CDS section 12 | ~80 | 6 |
| `timing-tap` | Not used (no 1D timing concept) | 0 | n/a |
| `listening-id` | Not used at launch (audio licensing) | 0 | n/a |

## 3. Multiple choice (`multiple-choice`) samples



### `cp-mc-01` (fw-02 / attractants)

```json
{
  "prompt": "Which of these must go in the bear box?",
  "options": [
    {
      "id": "toothpaste",
      "text": "Toothpaste and sunscreen",
      "explanation": "Anything with a scent can draw an animal in."
    },
    {
      "id": "tent",
      "text": "Your tent body"
    },
    {
      "id": "sleeping-bag",
      "text": "Your sleeping bag"
    },
    {
      "id": "tarp",
      "text": "A clean, empty tarp"
    }
  ],
  "correctOptionIds": [
    "toothpaste"
  ],
  "explanation": {
    "correct": "Food, trash, coolers and scented toiletries all count. Animals investigate smell, not labels.",
    "incorrect": "Bears and rodents follow smell. Toothpaste, sunscreen, trash and pet food are attractants, not just snacks.",
    "sayThisLine": "\"Toothpaste counts. If it has a smell, it goes in the box.\""
  }
}
```

### `cp-mc-02` (ss-06 / bag-temp-rating)

```json
{
  "prompt": "Which rating should you trust to be comfortable?",
  "options": [
    {
      "id": "comfort",
      "text": "The comfort rating",
      "explanation": "This is the temperature a standard sleeper should stay comfortable at."
    },
    {
      "id": "extreme",
      "text": "The extreme rating",
      "explanation": "Extreme is a survival number, not a comfort target."
    },
    {
      "id": "limit",
      "text": "The lower-limit rating",
      "explanation": "Limit is where a standard sleeper starts to get cold."
    },
    {
      "id": "marketing",
      "text": "The number on the front of the bag"
    }
  ],
  "correctOptionIds": [
    "comfort"
  ],
  "explanation": {
    "correct": "The comfort rating is the honest planning number. The limit and extreme numbers are for the edge.",
    "incorrect": "Extreme ratings describe survival, not sleep. Plan around comfort, and add margin if you sleep cold.",
    "sayThisLine": "\"I read the comfort rating, not the big number on the front.\""
  }
}
```

### `cp-mc-03` (pr-03 / rolling-window)

```json
{
  "prompt": "On a six-month rolling window, when does July 15 open?",
  "options": [
    {
      "id": "jan15",
      "text": "About January 15",
      "explanation": "Each date opens one at a time, six months ahead."
    },
    {
      "id": "jan1",
      "text": "January 1, with the whole month"
    },
    {
      "id": "jul1",
      "text": "July 1, two weeks ahead"
    },
    {
      "id": "random",
      "text": "Whenever the lottery draws"
    }
  ],
  "correctOptionIds": [
    "jan15"
  ],
  "explanation": {
    "correct": "A rolling window opens one arrival date each day, so July 15 opens around January 15. Check the exact rule for your site.",
    "incorrect": "Rolling windows open one day at a time, not a month at a time. Some sites use different windows, so check the listing.",
    "sayThisLine": "\"Mid-July opens mid-January, so I set an alarm.\""
  }
}
```

### `cp-mc-04` (sw-02 / tent-heater)

```json
{
  "prompt": "What is the safest way to add warmth in a tent at night?",
  "options": [
    {
      "id": "bag",
      "text": "Warmer bag, better pad, dry layers and a warm bottle",
      "explanation": "Insulation is safe because it burns nothing."
    },
    {
      "id": "stove",
      "text": "Run a small stove with the door cracked",
      "explanation": "Fuel-burning devices can fill a tent with CO, and can also start fires."
    },
    {
      "id": "charcoal",
      "text": "Bring in charcoal after the fire",
      "explanation": "Coals give off carbon monoxide and can kill."
    },
    {
      "id": "lantern",
      "text": "Leave a gas lantern on low",
      "explanation": "Gas lanterns make CO too."
    }
  ],
  "correctOptionIds": [
    "bag"
  ],
  "explanation": {
    "correct": "Insulate the person, not the tent. Burning fuel indoors risks carbon monoxide and fire.",
    "incorrect": "Cracked doors do not make burning fuel safe in a tent. Carbon monoxide has no smell, so you may not notice until it is too late.",
    "sayThisLine": "\"We stayed warm with a hot bottle. Nothing burns in the tent.\""
  }
}
```

### `cp-mc-05` (fr-04 / dont-move-firewood)

```json
{
  "prompt": "Where should firewood come from?",
  "options": [
    {
      "id": "local",
      "text": "Bought near the campground, or certified heat-treated",
      "explanation": "Local wood avoids carrying insects and disease across regions."
    },
    {
      "id": "home",
      "text": "Your backyard pile, hauled 200 miles",
      "explanation": "Wood can carry pests to new forests."
    },
    {
      "id": "live",
      "text": "Live trees at the site",
      "explanation": "Cutting live trees damages the place."
    },
    {
      "id": "any",
      "text": "Any wood from the road",
      "explanation": "Origin still matters."
    }
  ],
  "correctOptionIds": [
    "local"
  ],
  "explanation": {
    "correct": "Buy where you burn, or use certified heat-treated wood, and follow the site rule about gathering.",
    "incorrect": "Insects and diseases hide in firewood and spread across states. Check the rule for the area you camp in.",
    "sayThisLine": "\"Buy it where you burn it. It keeps the forest healthy.\""
  }
}
```

## 4. Binary call (`binary-call`) samples



### `cp-bc-01` (sw-01 / carbon-monoxide)

```json
{
  "prompt": "Cook inside the tent when it rains?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "tent-stove-rain",
    "alt": "A tent with a rainfly closed in rain, a small canister stove on a mat inside."
  },
  "choices": [
    {
      "id": "no",
      "label": "Never in the tent"
    },
    {
      "id": "yes",
      "label": "Fine with the door cracked"
    }
  ],
  "correctChoiceId": "no",
  "explanation": {
    "correct": "Cooking in a tent risks carbon monoxide and fire even with a vent cracked. Set up a sheltered cooking spot outside, well away from the tent.",
    "incorrect": "Carbon monoxide has no smell or warning. A cracked door does not make burning fuel safe in a tent. Cook outside, stable and downwind."
  },
  "ruleTag": "No fuel in tents"
}
```

### `cp-bc-02` (sw-05 / lightning-camp)

```json
{
  "prompt": "Thunder overhead. Tent or car?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "lightning-meadow",
    "alt": "A meadow campsite with a tent and a hard-topped car parked nearby, storm clouds above."
  },
  "choices": [
    {
      "id": "car",
      "label": "Get in the hard-topped car"
    },
    {
      "id": "tent",
      "label": "Stay in the tent"
    }
  ],
  "correctChoiceId": "car",
  "explanation": {
    "correct": "A tent gives no lightning protection. A hard-topped vehicle with windows closed is much safer, and you wait about 30 minutes after the last thunder.",
    "incorrect": "The tent fabric will not stop lightning. Waiting in the tent feels safe, but a car is meaningfully safer."
  },
  "ruleTag": "When thunder roars"
}
```

### `cp-bc-03` (cs-03 / water-setback)

```json
{
  "prompt": "Camp 50 feet from the lake?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "lake-setback",
    "alt": "A campsite pitched right at a lake shore, tent close to the water."
  },
  "choices": [
    {
      "id": "back",
      "label": "Move back to about 200 feet"
    },
    {
      "id": "stay",
      "label": "Fine, it is close to water"
    }
  ],
  "correctChoiceId": "back",
  "explanation": {
    "correct": "Camping about 200 feet, roughly 70 adult steps, from water protects shorelines, water quality and wildlife access. Where a site is already established, use it as designated.",
    "incorrect": "Shoreline camping damages vegetation and pushes wildlife away from water. In developed campgrounds follow the site layout."
  },
  "ruleTag": "200-foot setback"
}
```

### `cp-bc-04` (fr-06 / fire-accelerant)

```json
{
  "prompt": "Use gas to speed up a slow fire?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "fire-ring-gas",
    "alt": "A smoldering fire in a ring with a can of gasoline nearby."
  },
  "choices": [
    {
      "id": "no",
      "label": "No, never"
    },
    {
      "id": "yes",
      "label": "A splash is fine"
    }
  ],
  "correctChoiceId": "no",
  "explanation": {
    "correct": "Gasoline and similar liquids flash and can burn people badly. Use dry tinder and kindling and patience.",
    "incorrect": "Vapors ignite explosively, so accelerants are a top cause of camp burns."
  },
  "ruleTag": "No accelerants"
}
```

## 5. Term match (`term-match`) samples



### `cp-tm-01` (cb-02 / campsite-anatomy)

```json
{
  "prompt": "Match each campsite feature to its job.",
  "pairs": [
    {
      "id": "bear-box",
      "term": "Bear box",
      "definition": "Locked metal locker for food and scented items"
    },
    {
      "id": "fire-ring",
      "term": "Fire ring",
      "definition": "Metal or stone circle that holds the campfire"
    },
    {
      "id": "tent-pad",
      "term": "Tent pad",
      "definition": "Level, cleared spot for the tent"
    },
    {
      "id": "hookups",
      "term": "Hookups",
      "definition": "Electric or water connections mainly for RVs"
    },
    {
      "id": "camp-host",
      "term": "Camp host",
      "definition": "Volunteer or staffer who lives at the campground"
    }
  ],
  "distractorDefinitions": [
    "A place to charge a phone at the toilet"
  ],
  "explanation": {
    "summary": "Every feature answers a problem: bears, fire, dirt, power and help.",
    "sayThisLine": "\"Nice tent pad. Is there a bear box on the site?\""
  }
}
```

### `cp-tm-02` (ck-01 / canister-stove)

```json
{
  "prompt": "Match each stove to what it does best.",
  "pairs": [
    {
      "id": "canister",
      "term": "Canister stove",
      "definition": "Simple and quick, weaker in cold and wind"
    },
    {
      "id": "liquid",
      "term": "Liquid fuel stove",
      "definition": "Reliable in cold, refillable bottle"
    },
    {
      "id": "alcohol",
      "term": "Alcohol stove",
      "definition": "Very light, slow, faint flame"
    },
    {
      "id": "twoburner",
      "term": "Two-burner stove",
      "definition": "Car-camping stove that cooks like a range"
    }
  ],
  "distractorDefinitions": [
    "Fuel-free stove that burns twigs anywhere"
  ],
  "explanation": {
    "summary": "Stoves trade weight, speed, cold-weather power and simplicity.",
    "sayThisLine": "\"Canister stove, because I want coffee fast.\""
  }
}
```

### `cp-tm-03` (fr-02 / fire-ring)

```json
{
  "prompt": "Match each fire setup.",
  "pairs": [
    {
      "id": "ring",
      "term": "Fire ring",
      "definition": "Existing contained fire spot in a site"
    },
    {
      "id": "pan",
      "term": "Fire pan",
      "definition": "Raised tray that leaves no scar"
    },
    {
      "id": "mound",
      "term": "Mound fire",
      "definition": "Low fire on a mineral-soil layer, only where allowed"
    },
    {
      "id": "ban",
      "term": "Fire ban",
      "definition": "Rule that stops open flames for a period"
    }
  ],
  "explanation": {
    "summary": "Use what exists, use the least impact, and follow the posted rule.",
    "sayThisLine": "\"There is a ban, so we are on stove only.\""
  }
}
```

### `cp-tm-04` (pr-01 / public-land-agencies)

```json
{
  "prompt": "Match each agency to the land it manages.",
  "pairs": [
    {
      "id": "nps",
      "term": "NPS",
      "definition": "National parks and monuments"
    },
    {
      "id": "usfs",
      "term": "USFS",
      "definition": "National forests and grasslands"
    },
    {
      "id": "blm",
      "term": "BLM",
      "definition": "Public lands, often open dispersed camping"
    },
    {
      "id": "state",
      "term": "State parks",
      "definition": "Parks run by the state, own rules and booking"
    }
  ],
  "explanation": {
    "summary": "Rules, fees and booking differ across agencies, so check who runs the land.",
    "sayThisLine": "\"That is national forest, so the rules are different.\""
  }
}
```

## 6. Sequence order (`sequence-order`) samples



### `cp-so-01` (cb-03 / camp-trip-flow)

```json
{
  "prompt": "Order the first hour at a new campsite.",
  "items": [
    {
      "id": "scout",
      "text": "Scout the site: look up, down and around",
      "why": "Hazards are cheaper to find before the tent goes up."
    },
    {
      "id": "clear",
      "text": "Clear pad of sharp debris, no digging",
      "why": "You are protecting the tent and the ground."
    },
    {
      "id": "pitch",
      "text": "Pitch tent, stake and guy out",
      "why": "Stake before you unpack gear so it does not blow away."
    },
    {
      "id": "kitchen",
      "text": "Set up the kitchen and store food",
      "why": "Food storage and cooking areas go well away from the tent."
    },
    {
      "id": "fire",
      "text": "Then consider a fire if allowed",
      "why": "Check restrictions before you touch any wood."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Scout, shelter, then kitchen and fire last.",
    "incorrect": "Do safety scouting before comfort. The tent and food storage come before any fire.",
    "sayThisLine": "\"I do a site scout before I unpack. It saves surprises.\""
  }
}
```

### `cp-so-02` (fr-07 / drown-stir-feel)

```json
{
  "prompt": "Order putting a fire dead out.",
  "items": [
    {
      "id": "water",
      "text": "Pour water on the embers and logs",
      "why": "Wet everything, not just the top."
    },
    {
      "id": "stir",
      "text": "Stir the ashes and turn logs",
      "why": "Hidden coals can hide under ash."
    },
    {
      "id": "repeat",
      "text": "Pour again and stir again",
      "why": "Repeat until nothing hisses."
    },
    {
      "id": "feel",
      "text": "Feel with the back of your hand that it is cold",
      "why": "If it is too hot to touch, it is not out."
    },
    {
      "id": "check",
      "text": "Confirm it is cold before leaving",
      "why": "Never walk away from warm ashes."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Drown, stir, drown again, feel. Cold means out.",
    "incorrect": "Skipping a step leaves buried coals. Feel for heat before you leave.",
    "sayThisLine": "\"Drown, stir, feel. It is cold, so it is out.\""
  }
}
```

### `cp-so-03` (ln-02 / cathole)

```json
{
  "prompt": "Order using a cathole.",
  "items": [
    {
      "id": "distance",
      "text": "Walk 200 feet from water, camp and trail",
      "why": "Protects water and paths."
    },
    {
      "id": "dig",
      "text": "Dig a hole 6 to 8 inches deep",
      "why": "Depth helps decomposition and keeps animals out."
    },
    {
      "id": "use",
      "text": "Use the hole",
      "why": "Keep it small and neat."
    },
    {
      "id": "cover",
      "text": "Cover it and disguise the spot",
      "why": "Leave it looking natural."
    },
    {
      "id": "pack",
      "text": "Pack out toilet paper and hygiene products",
      "why": "Follow local rules for paper."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Far from water, deep, cover, pack out paper.",
    "incorrect": "Water contamination is the biggest risk. Where WAG bags are required, use them instead.",
    "sayThisLine": "\"Six to eight inches deep, two hundred feet away.\""
  }
}
```

### `cp-so-04` (ss-04 / stake-out)

```json
{
  "prompt": "Order pitching a tent.",
  "items": [
    {
      "id": "clear",
      "text": "Clear the ground of sharp objects",
      "why": "Sharp things damage the floor."
    },
    {
      "id": "lay",
      "text": "Lay the footprint and tent, door away from wind",
      "why": "Orientation matters before stakes."
    },
    {
      "id": "poles",
      "text": "Assemble poles and raise the body",
      "why": "Freestanding tents stand first."
    },
    {
      "id": "stake",
      "text": "Stake corners and pull taut",
      "why": "Staking stops wind flipping the tent."
    },
    {
      "id": "fly",
      "text": "Attach the rainfly and guy out",
      "why": "Guy lines steady it against wind."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Clear, lay, raise, stake, cover.",
    "incorrect": "Do not put stakes last. Wind can lift a light tent in seconds.",
    "sayThisLine": "\"Stake it early. Wind will find a loose tent.\""
  }
}
```

## 7. Visual ID (`visual-id`) samples



### `cp-vi-01` (ss-03 / freestanding)

```json
{
  "prompt": "Which shelter is this?",
  "image": {
    "asset": "camping/shelter-freestanding.svg",
    "alt": "Dome tent with crossing poles held up without stakes.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "freestanding",
      "text": "Freestanding tent"
    },
    {
      "id": "tarp",
      "text": "A-frame tarp"
    },
    {
      "id": "hammock",
      "text": "Hammock with tarp"
    },
    {
      "id": "bivy",
      "text": "Bivy sack"
    }
  ],
  "correctOptionId": "freestanding",
  "explanation": {
    "correct": "A freestanding tent stands on its poles.",
    "incorrect": "Compare the distinguishing features listed in the cues and try again."
  },
  "cues": [
    "Crossing poles, a dome shape and a sewn-in floor."
  ]
}
```

### `cp-vi-02` (ss-03 / hammock-camping)

```json
{
  "prompt": "Which shelter is this?",
  "image": {
    "asset": "camping/shelter-hammock.svg",
    "alt": "A hammock hung between two trees with a tarp above.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "hammock",
      "text": "Hammock with tarp"
    },
    {
      "id": "freestanding",
      "text": "Freestanding tent"
    },
    {
      "id": "tarp",
      "text": "Lean-to tarp"
    },
    {
      "id": "cot",
      "text": "Camp cot"
    }
  ],
  "correctOptionId": "hammock",
  "explanation": {
    "correct": "A hammock hangs between two trees, with a tarp over the top.",
    "incorrect": "Compare the distinguishing features listed in the cues and try again."
  },
  "cues": [
    "Suspended body, straps on two trees and a rain tarp above."
  ]
}
```

### `cp-vi-03` (ck-01 / canister-stove)

```json
{
  "prompt": "Which stove is this?",
  "image": {
    "asset": "camping/stove-canister.svg",
    "alt": "A small burner on a squat fuel canister.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "canister",
      "text": "Canister stove"
    },
    {
      "id": "liquid",
      "text": "Liquid fuel stove"
    },
    {
      "id": "twoburner",
      "text": "Two-burner stove"
    },
    {
      "id": "alcohol",
      "text": "Alcohol stove"
    }
  ],
  "correctOptionId": "canister",
  "explanation": {
    "correct": "The burner screws onto a squat pressurized canister.",
    "incorrect": "Compare the distinguishing features listed in the cues and try again."
  },
  "cues": [
    "Short burner, threaded canister and no fuel bottle."
  ]
}
```

### `cp-vi-04` (fw-07 / small-thieves)

```json
{
  "prompt": "Which camp thief is this?",
  "image": {
    "asset": "camping/critter-raven.svg",
    "alt": "A large black bird with a thick beak on a picnic table.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "raven",
      "text": "Raven"
    },
    {
      "id": "raccoon",
      "text": "Raccoon"
    },
    {
      "id": "marmot",
      "text": "Marmot"
    },
    {
      "id": "bear",
      "text": "Black bear"
    }
  ],
  "correctOptionId": "raven",
  "explanation": {
    "correct": "Ravens are clever and unzip bags, so food never sits on the table.",
    "incorrect": "Compare the distinguishing features listed in the cues and try again."
  },
  "cues": [
    "Large black bird with a thick beak and shaggy throat."
  ]
}
```

## 8. Fill the gap (`fill-the-gap`) samples



### `cp-fg-01` (ck-02 / stove-safety)

```json
{
  "prompt": "Finish the stove safety rule.",
  "template": "Cook {{where}}, on a {{surface}} surface, and never refuel a {{state}} stove.",
  "gaps": [
    {
      "id": "where",
      "options": [
        "outside",
        "in the tent",
        "in the vestibule"
      ],
      "correct": "outside"
    },
    {
      "id": "surface",
      "options": [
        "stable and level",
        "soft and sloped"
      ],
      "correct": "stable and level"
    },
    {
      "id": "state",
      "options": [
        "hot",
        "cool"
      ],
      "correct": "hot"
    }
  ],
  "explanation": {
    "correct": "Outside, stable, and never refuel while hot.",
    "incorrect": "Cooking in tents risks carbon monoxide and fire. Refueling a hot stove can flash.",
    "sayThisLine": "\"Outside, stable, and never refuel hot.\""
  }
}
```

### `cp-fg-02` (ln-02 / cathole)

```json
{
  "prompt": "Finish the cathole rule.",
  "template": "Dig {{depth}} inches deep, about {{feet}} feet from water, camp and trails.",
  "gaps": [
    {
      "id": "depth",
      "options": [
        "2 to 3",
        "6 to 8",
        "12 to 14"
      ],
      "correct": "6 to 8"
    },
    {
      "id": "feet",
      "options": [
        "20",
        "200",
        "2,000"
      ],
      "correct": "200"
    }
  ],
  "explanation": {
    "correct": "Six to eight inches deep and 200 feet from water.",
    "incorrect": "Shallow holes are dug up by animals. Too close to water pollutes it.",
    "sayThisLine": "\"Six to eight inches, two hundred feet.\""
  }
}
```

### `cp-fg-03` (ck-05 / danger-zone)

```json
{
  "prompt": "Finish the cooler rule.",
  "template": "Keep cold food at {{temp}} or below, and discard perishables left out over {{hours}} hours.",
  "gaps": [
    {
      "id": "temp",
      "options": [
        "40°F",
        "60°F",
        "70°F"
      ],
      "correct": "40°F"
    },
    {
      "id": "hours",
      "options": [
        "2",
        "6",
        "12"
      ],
      "correct": "2"
    }
  ],
  "explanation": {
    "correct": "Cold means 40°F or below, and two hours is the limit (one hour if it is over 90°F).",
    "incorrect": "Bacteria multiply fast in the danger zone. Extra heat shortens the limit.",
    "sayThisLine": "\"Forty or below, or we toss it after two hours.\""
  }
}
```

### `cp-fg-04` (pr-04 / release-time)

```json
{
  "prompt": "Finish the booking sentence.",
  "template": "A popular site opens on a {{window}} window, so book at {{when}}.",
  "gaps": [
    {
      "id": "window",
      "options": [
        "six-month rolling",
        "random lottery"
      ],
      "correct": "six-month rolling"
    },
    {
      "id": "when",
      "options": [
        "the release time",
        "the day before"
      ],
      "correct": "the release time"
    }
  ],
  "explanation": {
    "correct": "Rolling windows open one day at a time. Be ready at the release time.",
    "incorrect": "Good sites vanish in seconds. Check the release time in the listing.",
    "sayThisLine": "\"I will be on Recreation.gov at release time.\""
  }
}
```

## 9. Estimate slider (`estimate-slider`) samples



### `cp-es-01` (ss-05 / r-value)

```json
{
  "prompt": "What R-value suits a mild summer night?",
  "unit": "R-value",
  "min": 1,
  "max": 7,
  "step": 0.5,
  "correctValue": 2,
  "tolerance": {
    "full": 1,
    "partial": 1.5
  },
  "explanation": {
    "correct": "An R-value around 2 is fine for warm summer nights. Cooler seasons need more.",
    "incorrect": "Higher R-values are warmer, and pads can stack. Ground cold steals more heat than air.",
    "sayThisLine": "\"My summer pad is R2. My winter pad is R5.\""
  }
}
```

### `cp-es-02` (fw-08 / wildlife-distance)

```json
{
  "prompt": "Minimum yards from a bear in a national park?",
  "unit": "yards",
  "min": 5,
  "max": 200,
  "step": 5,
  "correctValue": 100,
  "tolerance": {
    "full": 10,
    "partial": 25
  },
  "explanation": {
    "correct": "Parks ask for at least 100 yards from bears and wolves. Stay 25 yards from other wildlife.",
    "incorrect": "Keep your distance and use a lens. A bold animal is a dangerous animal.",
    "sayThisLine": "\"We keep 100 yards from bears. Always.\""
  }
}
```

### `cp-es-03` (ck-06 / water-treatment-camp)

```json
{
  "prompt": "Minutes to boil water above 6,500 feet?",
  "unit": "minutes",
  "min": 0,
  "max": 10,
  "step": 1,
  "correctValue": 3,
  "tolerance": {
    "full": 0,
    "partial": 1
  },
  "explanation": {
    "correct": "Boil for 1 minute below 6,500 feet and 3 minutes above.",
    "incorrect": "Water boils at a lower temperature at altitude, so the time increases.",
    "sayThisLine": "\"Three minutes at altitude, one at sea level.\""
  }
}
```

### `cp-es-04` (cs-03 / water-setback)

```json
{
  "prompt": "Steps from water to a good campsite?",
  "unit": "steps",
  "min": 10,
  "max": 150,
  "step": 5,
  "correctValue": 70,
  "tolerance": {
    "full": 10,
    "partial": 25
  },
  "explanation": {
    "correct": "About 200 feet is roughly 70 adult steps.",
    "incorrect": "Counting steps is an easy way to measure the setback without a tape.",
    "sayThisLine": "\"Seventy steps from the lake.\""
  }
}
```

### `cp-es-05` (ck-05 / danger-zone)

```json
{
  "prompt": "Max hours perishable food can sit out on a mild day?",
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
    "correct": "Two hours is the limit, and one hour if it is above 90°F.",
    "incorrect": "Warmer days shorten the safe time. When in doubt, throw it out.",
    "sayThisLine": "\"Two hours, one if it is hot.\""
  }
}
```

## 10. Hotspot tap (`hotspot-tap`) samples



### `cp-ht-01` (cb-02 / campsite-anatomy)

```json
{
  "prompt": "Tap the bear box.",
  "diagram": {
    "diagramId": "campsite-plan",
    "aspectRatio": 1.4,
    "alt": "Top-down plan of a campsite: tent pad, picnic table, fire ring, bear box near the road and a toilet down the path."
  },
  "hotspots": [
    {
      "id": "pad",
      "label": "Tent pad",
      "shape": {
        "kind": "rect",
        "x": 0.08,
        "y": 0.15,
        "w": 0.25,
        "h": 0.3
      }
    },
    {
      "id": "table",
      "label": "Picnic table",
      "shape": {
        "kind": "rect",
        "x": 0.4,
        "y": 0.15,
        "w": 0.2,
        "h": 0.2
      }
    },
    {
      "id": "ring",
      "label": "Fire ring",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.6,
        "r": 0.08
      }
    },
    {
      "id": "box",
      "label": "Bear box",
      "shape": {
        "kind": "rect",
        "x": 0.75,
        "y": 0.15,
        "w": 0.15,
        "h": 0.15
      }
    },
    {
      "id": "toilet",
      "label": "Toilet",
      "shape": {
        "kind": "rect",
        "x": 0.8,
        "y": 0.7,
        "w": 0.12,
        "h": 0.2
      }
    }
  ],
  "correctHotspotIds": [
    "box"
  ],
  "explanation": {
    "correct": "The bear box is a metal locker near the parking area.",
    "incorrect": "Bear boxes are placed to make food storage easy and away from sleeping.",
    "sayThisLine": "\"Everything smelly goes in the bear box.\""
  }
}
```

### `cp-ht-02` (cs-02 / hazard-tree)

```json
{
  "prompt": "Tap the spot you should not pitch.",
  "diagram": {
    "diagramId": "site-cross-section",
    "aspectRatio": 1.6,
    "alt": "Side view of a campsite: a low puddle spot, a level rise, a dead leaning tree over one spot and a dry wash."
  },
  "hotspots": [
    {
      "id": "low",
      "label": "Low puddle spot",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.55,
        "w": 0.2,
        "h": 0.3
      }
    },
    {
      "id": "rise",
      "label": "Level rise",
      "shape": {
        "kind": "rect",
        "x": 0.3,
        "y": 0.4,
        "w": 0.2,
        "h": 0.3
      }
    },
    {
      "id": "dead",
      "label": "Under a dead leaning tree",
      "shape": {
        "kind": "rect",
        "x": 0.55,
        "y": 0.2,
        "w": 0.2,
        "h": 0.5
      }
    },
    {
      "id": "wash",
      "label": "Dry wash",
      "shape": {
        "kind": "rect",
        "x": 0.78,
        "y": 0.65,
        "w": 0.2,
        "h": 0.3
      }
    }
  ],
  "correctHotspotIds": [
    "dead",
    "wash"
  ],
  "explanation": {
    "correct": "Under a dead leaning tree and in a dry wash are both places to avoid.",
    "incorrect": "Dead limbs fall and washes flood. The rise is the sensible spot.",
    "sayThisLine": "\"Look up, and stay out of the wash.\""
  }
}
```

### `cp-ht-03` (cs-06 / camp-triangle)

```json
{
  "prompt": "Tap the best place to store food.",
  "diagram": {
    "diagramId": "camp-triangle-plan",
    "aspectRatio": 1.4,
    "alt": "A plan showing a tent, a cooking area and three possible storage spots, one far from the tent."
  },
  "hotspots": [
    {
      "id": "tent",
      "label": "Next to the tent",
      "shape": {
        "kind": "circle",
        "cx": 0.2,
        "cy": 0.3,
        "r": 0.1
      }
    },
    {
      "id": "kitchen",
      "label": "Next to the kitchen",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.1
      }
    },
    {
      "id": "far",
      "label": "Well away from both",
      "shape": {
        "kind": "circle",
        "cx": 0.85,
        "cy": 0.2,
        "r": 0.1
      }
    },
    {
      "id": "creek",
      "label": "Beside the creek",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.85,
        "r": 0.1
      }
    }
  ],
  "correctHotspotIds": [
    "far"
  ],
  "explanation": {
    "correct": "Storage goes well away from where you sleep, not beside the kitchen or the creek.",
    "incorrect": "Keep sleep, cooking and storage separate. Follow the local storage rule first.",
    "sayThisLine": "\"Kitchen, tent and storage are the three corners.\""
  }
}
```

### `cp-ht-04` (ss-01 / rainfly)

```json
{
  "prompt": "Tap the vestibule.",
  "diagram": {
    "diagramId": "tent-anatomy",
    "aspectRatio": 1.4,
    "alt": "Front view of a tent with rainfly, door, poles, floor and a covered porch area at the front."
  },
  "hotspots": [
    {
      "id": "fly",
      "label": "Rainfly",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.1,
        "w": 0.6,
        "h": 0.25
      }
    },
    {
      "id": "door",
      "label": "Door",
      "shape": {
        "kind": "rect",
        "x": 0.4,
        "y": 0.4,
        "w": 0.2,
        "h": 0.3
      }
    },
    {
      "id": "vest",
      "label": "Vestibule",
      "shape": {
        "kind": "rect",
        "x": 0.3,
        "y": 0.75,
        "w": 0.4,
        "h": 0.2
      }
    },
    {
      "id": "pole",
      "label": "Pole",
      "shape": {
        "kind": "rect",
        "x": 0.1,
        "y": 0.35,
        "w": 0.05,
        "h": 0.5
      }
    }
  ],
  "correctHotspotIds": [
    "vest"
  ],
  "explanation": {
    "correct": "The vestibule is the covered porch for boots and packs.",
    "incorrect": "Boots and wet gear live in the vestibule, outside the dry sleeping area.",
    "sayThisLine": "\"Boots live in the vestibule.\""
  }
}
```

## 11. Say this (`say-this`) samples



### `cp-sy-01` (pr-03 / rolling-window)

```json
{
  "statement": {
    "speaker": "She",
    "text": "\"I have an alarm for ten a.m. Eastern. Site 14 opens for the Fourth.\""
  },
  "options": [
    {
      "id": "rolling",
      "text": "A rolling booking window with a release time",
      "isCorrect": true
    },
    {
      "id": "lottery",
      "text": "A permit lottery",
      "isCorrect": false
    },
    {
      "id": "walk",
      "text": "A walk-up site",
      "isCorrect": false
    },
    {
      "id": "stove",
      "text": "A stove safety rule",
      "isCorrect": false
    }
  ],
  "translation": "She is booking a popular site the moment it opens on a rolling window.",
  "followUps": [
    {
      "line": "\"Do you have a backup site if it goes?\"",
      "why": "Shows you know these vanish fast."
    },
    {
      "line": "\"How many months ahead is it?\"",
      "why": "A sincere question about the window."
    }
  ],
  "noFakeExpertNote": "Ask, do not bluff about booking tricks."
}
```

### `cp-sy-02` (ss-05 / r-value)

```json
{
  "statement": {
    "speaker": "She",
    "text": "\"My pad is R-five, so I was warm even on the frozen ground.\""
  },
  "options": [
    {
      "id": "rvalue",
      "text": "R-value, a pad warmth rating",
      "isCorrect": true
    },
    {
      "id": "rain",
      "text": "Rain protection",
      "isCorrect": false
    },
    {
      "id": "weight",
      "text": "Pack weight only",
      "isCorrect": false
    },
    {
      "id": "stove",
      "text": "A stove rating",
      "isCorrect": false
    }
  ],
  "translation": "She has a warm pad rated well for cold ground.",
  "followUps": [
    {
      "line": "\"What did you sleep on before?\"",
      "why": "Invites her story."
    },
    {
      "line": "\"Is it foam or inflatable?\"",
      "why": "A curious gear question."
    }
  ],
  "noFakeExpertNote": "Do not pretend you have tested pads."
}
```

### `cp-sy-03` (fw-04 / bear-canister)

```json
{
  "statement": {
    "speaker": "She",
    "text": "\"I had to carry a canister. It is heavy, but it is the rule there.\""
  },
  "options": [
    {
      "id": "canister",
      "text": "A required bear canister",
      "isCorrect": true
    },
    {
      "id": "spray",
      "text": "Bear spray",
      "isCorrect": false
    },
    {
      "id": "hang",
      "text": "A bear hang",
      "isCorrect": false
    },
    {
      "id": "pad",
      "text": "A sleeping pad",
      "isCorrect": false
    }
  ],
  "translation": "She carries a required bear-resistant food container.",
  "followUps": [
    {
      "line": "\"Did you notice the weight?\"",
      "why": "A friendly, honest question."
    },
    {
      "line": "\"Did you see any bears?\"",
      "why": "Curious without bluffing."
    }
  ],
  "noFakeExpertNote": "You do not have to know the brands."
}
```

### `cp-sy-04` (fr-03 / fire-restrictions)

```json
{
  "statement": {
    "speaker": "She",
    "text": "\"Stage 2 restrictions, so no campfire. We did stove-only dinner.\""
  },
  "options": [
    {
      "id": "stage",
      "text": "A fire restriction level",
      "isCorrect": true
    },
    {
      "id": "ban",
      "text": "A fire ban on open flames",
      "isCorrect": true
    },
    {
      "id": "pad",
      "text": "A tent pad",
      "isCorrect": false
    },
    {
      "id": "permit",
      "text": "A permit lottery",
      "isCorrect": false
    }
  ],
  "translation": "A rule limited campfires because fire danger is high, so she cooked on a stove.",
  "followUps": [
    {
      "line": "\"That is smart. Did you have s'mores on the stove?\"",
      "why": "Light, warm."
    },
    {
      "line": "\"How do you find out about restrictions?\"",
      "why": "A useful question."
    }
  ],
  "noFakeExpertNote": "Do not guess what stages allow. They vary."
}
```

### `cp-sy-05` (ck-09 / camp-classics)

```json
{
  "statement": {
    "speaker": "She",
    "text": "\"Foil-packet dinners. Sausage, potatoes, onions. Done in twenty minutes.\""
  },
  "options": [
    {
      "id": "foil",
      "text": "Foil-packet cooking",
      "isCorrect": true
    },
    {
      "id": "dutch",
      "text": "A dutch oven",
      "isCorrect": false
    },
    {
      "id": "canister",
      "text": "A stove type",
      "isCorrect": false
    },
    {
      "id": "fire",
      "text": "A fire ring only",
      "isCorrect": false
    }
  ],
  "translation": "She made quick dinners wrapped in foil and cooked on coals or a stove.",
  "followUps": [
    {
      "line": "\"Do you cook them on coals?\"",
      "why": "Shows curiosity."
    },
    {
      "line": "\"What is your favorite combo?\"",
      "why": "Warm question."
    }
  ],
  "noFakeExpertNote": "You do not have to cook; just be interested."
}
```

### `cp-sy-06` (ln-07 / geotagging)

```json
{
  "statement": {
    "speaker": "She",
    "text": "\"I did not geotag that lake. It cannot take a crowd.\""
  },
  "options": [
    {
      "id": "geotag",
      "text": "Choosing not to share a precise location",
      "isCorrect": true
    },
    {
      "id": "permit",
      "text": "A permit rule",
      "isCorrect": false
    },
    {
      "id": "stove",
      "text": "A stove rule",
      "isCorrect": false
    },
    {
      "id": "pad",
      "text": "A pad rating",
      "isCorrect": false
    }
  ],
  "translation": "She avoided tagging a fragile spot to prevent crowds.",
  "followUps": [
    {
      "line": "\"That makes sense. Do you share the general area?\"",
      "why": "Respectful."
    },
    {
      "line": "\"How do you decide what to post?\"",
      "why": "A real question."
    }
  ],
  "noFakeExpertNote": "No need to lecture; ask."
}
```

## 12. Decision scenarios (`decision-scenario`), 15 fully written

Fact sheets are written to be read fast; verdicts mix best, acceptable and poor so the learner weighs, not guesses. Each has `expertNote` and `safetyNote`. These are the core of the course (spec section 17). Scenarios never state that a choice is safe; they teach what an experienced camper weighs.


### `cp-ds-01` (sw-01 / carbon-monoxide)

```json
{
  "prompt": "Cold night. A friend wants to warm the tent. Now what?",
  "situation": {
    "narrative": "Two of you are in a three-season tent. The forecast low is 28°F and everyone is chilly. Someone offers to run the canister stove inside.",
    "facts": [
      {
        "label": "Low tonight",
        "value": "28°F",
        "emphasis": "warning"
      },
      {
        "label": "Shelter",
        "value": "Closed three-season tent"
      },
      {
        "label": "Heat idea",
        "value": "Run stove or lantern inside",
        "emphasis": "warning"
      },
      {
        "label": "Bags",
        "value": "Rated comfort 35°F"
      },
      {
        "label": "Extras",
        "value": "Hot water, spare layers, foam pad"
      }
    ]
  },
  "options": [
    {
      "id": "stove",
      "label": "Run the stove inside with the door cracked",
      "verdict": "poor",
      "consequence": "Carbon monoxide can build up without any smell, and a stove in a tent can start a fire. People have died this way.",
      "considerations": [
        "CO has no smell or warning",
        "A cracked door does not make it safe",
        "Fabric ignites quickly"
      ]
    },
    {
      "id": "charcoal",
      "label": "Bring the warm charcoal from the fire into the tent",
      "verdict": "poor",
      "consequence": "Charcoal and embers release carbon monoxide and can ignite gear.",
      "considerations": [
        "Never burn fuel or coals in a tent"
      ]
    },
    {
      "id": "insulate",
      "label": "Cook outside, fill a bottle with hot water, add dry layers and a second pad",
      "verdict": "best",
      "consequence": "You warm the people, not the tent. Nothing burns near you and you can sleep safely.",
      "considerations": [
        "Hot bottle near the core",
        "Dry layers and a pad under you",
        "Cook outside and downwind"
      ]
    },
    {
      "id": "bed",
      "label": "Skip the hot meal, eat cold food and layer up early",
      "verdict": "acceptable",
      "consequence": "Safe, but a warm meal helps you sleep warm. Cooking outside is better.",
      "considerations": [
        "Eat before you get cold",
        "Calories fuel warmth"
      ]
    }
  ],
  "expertNote": "Warm the person, not the tent. Anything that burns fuel makes carbon monoxide, and CO gives no smell or warning.",
  "sayThisLine": "\"We stayed warm with a hot bottle. Nothing burns in the tent.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-02` (sw-03 / hypothermia-camp)

```json
{
  "prompt": "Wet and shivering at dusk. What do you do?",
  "situation": {
    "narrative": "A friend fell in a creek on the walk back to camp. It is raining and 40°F. They are shivering hard, fumbling their zipper and slurring words.",
    "facts": [
      {
        "label": "Temp",
        "value": "40°F and raining",
        "emphasis": "warning"
      },
      {
        "label": "Signs",
        "value": "Shivering, fumbling, slurred speech",
        "emphasis": "warning"
      },
      {
        "label": "Clothing",
        "value": "Soaked through"
      },
      {
        "label": "Shelter",
        "value": "Tent 50 feet away"
      },
      {
        "label": "Help",
        "value": "No signal; ranger station 20 minutes by car"
      }
    ]
  },
  "options": [
    {
      "id": "sleep",
      "label": "Let them rest and warm up on their own",
      "verdict": "poor",
      "consequence": "Getting colder and less coordinated means it is getting worse. Waiting delays help.",
      "considerations": [
        "Slurred speech means the situation is serious"
      ]
    },
    {
      "id": "warm",
      "label": "Get them dry and insulated, warm sweet drink if alert, and get help",
      "verdict": "best",
      "consequence": "You stop heat loss, add heat gently, and bring in help early. Do not leave them alone.",
      "considerations": [
        "Remove wet clothes and insulate from the ground",
        "Warm sweet drinks only if awake and able to swallow",
        "Call or drive for help if they do not improve"
      ]
    },
    {
      "id": "run",
      "label": "Send them to jog to warm up",
      "verdict": "poor",
      "consequence": "Exertion in wet clothes can worsen heat loss and fatigue.",
      "considerations": [
        "Shelter first",
        "Do not leave them alone"
      ]
    },
    {
      "id": "car",
      "label": "Get them into the car with the heater and dry clothes, then get help",
      "verdict": "acceptable",
      "consequence": "A heated car helps, but only if you can dry them and keep watching. Keep exhaust clear.",
      "considerations": [
        "Do not leave them alone",
        "Get help if signs continue"
      ]
    }
  ],
  "expertNote": "Shivering, fumbling and slurring are warning signs. Stop the heat loss first, keep them company and involve help early.",
  "sayThisLine": "\"We got them dry and warm, and we called for help early.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-03` (sw-05 / lightning-camp)

```json
{
  "prompt": "Thunder is rolling in. Where do you go?",
  "situation": {
    "narrative": "It is 3 p.m. at a meadow campsite. Thunder has started, about 10 seconds after each flash. Your hard-topped car is 100 yards away.",
    "facts": [
      {
        "label": "Thunder",
        "value": "Every 10 seconds",
        "emphasis": "warning"
      },
      {
        "label": "Shelter",
        "value": "Tent in open meadow"
      },
      {
        "label": "Nearby",
        "value": "Hard-topped car, tall lone pine"
      },
      {
        "label": "Time",
        "value": "3:00 p.m."
      },
      {
        "label": "Forecast",
        "value": "Storms for two hours"
      }
    ]
  },
  "options": [
    {
      "id": "tent",
      "label": "Stay inside the tent",
      "verdict": "poor",
      "consequence": "A tent does not protect from lightning, and you are in the open.",
      "considerations": [
        "Tent poles and fabric give no protection"
      ]
    },
    {
      "id": "tree",
      "label": "Wait under the lone pine",
      "verdict": "poor",
      "consequence": "Lone tall trees are the worst places in a storm.",
      "considerations": [
        "Trees attract strikes and side flash"
      ]
    },
    {
      "id": "car",
      "label": "Get in the hard-topped car, windows up; wait 30 min after last thunder",
      "verdict": "best",
      "consequence": "A hard-topped vehicle is much safer than a tent. Stay away from metal parts.",
      "considerations": [
        "No place outdoors is safe",
        "Wait 30 minutes after the last thunder"
      ]
    },
    {
      "id": "building",
      "label": "Go to a substantial enclosed building if closer",
      "verdict": "acceptable",
      "consequence": "A building with plumbing or wiring is good, but the car is closer here.",
      "considerations": [
        "Vault toilets and open shelters are not safe"
      ]
    }
  ],
  "expertNote": "Once thunder is audible you are in range. Shelter in a hard-topped vehicle or a substantial building, and wait 30 minutes after the last thunder.",
  "sayThisLine": "\"When thunder roars, we get in the car.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-04` (sw-06 / flash-flood-camp)

```json
{
  "prompt": "Sunny sky, sandy wash, tempting flat spot. Camp here?",
  "situation": {
    "narrative": "You are at a desert site. A sandy dry wash offers the flattest ground. Clouds are stacking over the mountains upstream, and a flash flood watch is posted.",
    "facts": [
      {
        "label": "Weather here",
        "value": "Sunny"
      },
      {
        "label": "Upstream",
        "value": "Storm clouds",
        "emphasis": "warning"
      },
      {
        "label": "Alerts",
        "value": "Flash flood watch",
        "emphasis": "warning"
      },
      {
        "label": "Spot",
        "value": "Flat sand in a wash"
      },
      {
        "label": "Alternative",
        "value": "Slightly sloped rise 100 yards away"
      }
    ]
  },
  "options": [
    {
      "id": "wash",
      "label": "Camp in the wash",
      "verdict": "poor",
      "consequence": "Water from rain far upstream can arrive fast and at night. Washes are flood paths.",
      "considerations": [
        "Rain can be miles away"
      ]
    },
    {
      "id": "rise",
      "label": "Camp on higher ground away from the wash",
      "verdict": "best",
      "consequence": "Higher ground is out of the path, and you can watch the water and sky.",
      "considerations": [
        "Higher ground and away from channels",
        "Follow the watch instructions"
      ]
    },
    {
      "id": "edge",
      "label": "Camp on the wash bank",
      "verdict": "poor",
      "consequence": "The bank can flood or collapse. It is too close.",
      "considerations": [
        "Stay well back and above"
      ]
    },
    {
      "id": "leave",
      "label": "Leave the area if the watch worsens",
      "verdict": "acceptable",
      "consequence": "Leaving early is smart if conditions get worse, but choose safer ground first.",
      "considerations": [
        "Check alerts again"
      ]
    }
  ],
  "expertNote": "Flash floods come from rain you cannot see. Never camp in a wash or low canyon, and move up immediately if water rises.",
  "sayThisLine": "\"Sunny here, but the wash is a flood path.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-05` (cs-02 / hazard-tree)

```json
{
  "prompt": "Gusty forecast. That flat spot has a dead tree.",
  "situation": {
    "narrative": "The best pad is under a tall dead pine with peeling bark. Gusts of 25 mph are forecast tonight.",
    "facts": [
      {
        "label": "Wind",
        "value": "Gusts to 25 mph",
        "emphasis": "warning"
      },
      {
        "label": "Tree",
        "value": "Dead, leaning, bark peeling",
        "emphasis": "warning"
      },
      {
        "label": "Spot",
        "value": "Flat pad under it"
      },
      {
        "label": "Alternative",
        "value": "Slightly sloped, no overhead hazards"
      },
      {
        "label": "Time",
        "value": "Late afternoon"
      }
    ]
  },
  "options": [
    {
      "id": "under",
      "label": "Pitch under it. It is flat.",
      "verdict": "poor",
      "consequence": "Dead limbs fall in wind, and people have been killed by falling trees.",
      "considerations": [
        "Look up before you pitch"
      ]
    },
    {
      "id": "move",
      "label": "Move to the sloped spot with no overhead hazards",
      "verdict": "best",
      "consequence": "Comfort loses to safety here, and you can fix a slope with clever placement.",
      "considerations": [
        "Look up",
        "Find a spot without hazards"
      ]
    },
    {
      "id": "edge",
      "label": "Pitch at the edge of the dead tree fall zone",
      "verdict": "poor",
      "consequence": "Trees can fall farther than you think.",
      "considerations": [
        "Fall zones extend"
      ]
    }
  ],
  "expertNote": "Always look up. In wind, dead trees and limbs are one of the top campsite hazards.",
  "sayThisLine": "\"Look up before you unpack.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-06` (fw-03 / bear-box)

```json
{
  "prompt": "Arrival at a bear-box site. Where does the food go?",
  "situation": {
    "narrative": "Your site has a bear box. You have a cooler, a bag of snacks, a toothpaste kit and a dog bowl with food.",
    "facts": [
      {
        "label": "Site",
        "value": "Bear box on site"
      },
      {
        "label": "Items",
        "value": "Cooler, snacks, toiletries, dog food",
        "emphasis": "warning"
      },
      {
        "label": "Sign",
        "value": "All food and scented items in locker"
      },
      {
        "label": "Vehicle",
        "value": "Hard-sided SUV"
      }
    ]
  },
  "options": [
    {
      "id": "car",
      "label": "Leave the cooler in the closed SUV",
      "verdict": "poor",
      "consequence": "Where a locker is provided, use it first. Vehicle storage may be prohibited.",
      "considerations": [
        "Follow posted rules"
      ]
    },
    {
      "id": "box",
      "label": "Put all food, coolers and scented toiletries in the box",
      "verdict": "best",
      "consequence": "It follows the rule and protects the wildlife.",
      "considerations": [
        "All scented items go in the box",
        "Keep it latched",
        "Do not leave food in the tent"
      ]
    },
    {
      "id": "tent",
      "label": "Keep snacks in the tent",
      "verdict": "poor",
      "consequence": "Food in the tent attracts animals to where you sleep.",
      "considerations": [
        "Never store food in a tent"
      ]
    }
  ],
  "expertNote": "Use the box every time you step away, and every night. Habituated animals get destroyed.",
  "sayThisLine": "\"Everything smelly goes in the box, even the toothpaste.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-07` (fw-04 / bear-canister)

```json
{
  "prompt": "Permit says canister required. Your friend says hang it.",
  "situation": {
    "narrative": "You are on a backcountry trip where a canister is required. Your friend says a hang is lighter and easier.",
    "facts": [
      {
        "label": "Rule",
        "value": "Canister required by permit",
        "emphasis": "warning"
      },
      {
        "label": "Friend",
        "value": "Wants a hang"
      },
      {
        "label": "Weight",
        "value": "Canister is 2 lb"
      },
      {
        "label": "Option",
        "value": "Rent one at the ranger station"
      }
    ]
  },
  "options": [
    {
      "id": "hang",
      "label": "Hang the food",
      "verdict": "poor",
      "consequence": "It breaks the rule and often fails in practice.",
      "considerations": [
        "Rules protect wildlife and you"
      ]
    },
    {
      "id": "canister",
      "label": "Carry an approved canister",
      "verdict": "best",
      "consequence": "You follow the rule. Weight is the price.",
      "considerations": [
        "Check the approved list"
      ]
    },
    {
      "id": "rent",
      "label": "Rent an approved one if you do not own one",
      "verdict": "acceptable",
      "consequence": "A rental is fine if it meets the approved list.",
      "considerations": [
        "Ask the ranger"
      ]
    }
  ],
  "expertNote": "Follow the local storage rule, not the internet debate. Canisters exist because hangs failed.",
  "sayThisLine": "\"The permit says canister, so we carry one.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-08` (fr-03 / fire-restrictions)

```json
{
  "prompt": "Stage 2 posted. Do you build the fire?",
  "situation": {
    "narrative": "The board says Stage 2 fire restrictions. The site has a metal ring and a stack of dry wood. You want s'mores.",
    "facts": [
      {
        "label": "Restriction",
        "value": "Stage 2 posted",
        "emphasis": "warning"
      },
      {
        "label": "Wind",
        "value": "Breezy"
      },
      {
        "label": "Ring",
        "value": "Metal ring on site"
      },
      {
        "label": "Stove",
        "value": "Valve stove in the car"
      },
      {
        "label": "Host",
        "value": "Camp host nearby"
      }
    ]
  },
  "options": [
    {
      "id": "build",
      "label": "Build a small fire anyway",
      "verdict": "poor",
      "consequence": "The order applies even if a ring is there.",
      "considerations": [
        "Restrictions are enforced"
      ]
    },
    {
      "id": "stove",
      "label": "Skip the campfire and cook with the stove if the order allows",
      "verdict": "best",
      "consequence": "You follow the rule and still cook.",
      "considerations": [
        "Check the exact order",
        "Ask the host"
      ]
    },
    {
      "id": "ask",
      "label": "Ask the host what is allowed today",
      "verdict": "acceptable",
      "consequence": "A good step, but skip the fire in the meantime.",
      "considerations": [
        "Orders vary by area"
      ]
    }
  ],
  "expertNote": "Fire restrictions are legal orders. Read them, ask the host or agency, and skip the fire when in doubt.",
  "sayThisLine": "\"There is a fire ban, so we cooked on the stove.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-09` (fr-05 / ember-hazard)

```json
{
  "prompt": "Red flag warning. Fire is allowed. Do you light it?",
  "situation": {
    "narrative": "No restriction is posted, but a red flag warning is in effect with 30 mph gusts and dry grass.",
    "facts": [
      {
        "label": "Alert",
        "value": "Red flag warning",
        "emphasis": "warning"
      },
      {
        "label": "Wind",
        "value": "Gusts 30 mph",
        "emphasis": "warning"
      },
      {
        "label": "Ground",
        "value": "Dry grass around ring"
      },
      {
        "label": "Rule",
        "value": "Fires allowed in rings"
      },
      {
        "label": "Water",
        "value": "Two buckets ready"
      }
    ]
  },
  "options": [
    {
      "id": "light",
      "label": "Light a small fire",
      "verdict": "poor",
      "consequence": "Embers can fly far in wind and start a wildfire.",
      "considerations": [
        "Small fires can still spread"
      ]
    },
    {
      "id": "skip",
      "label": "Skip the fire and use a stove or lantern",
      "verdict": "best",
      "consequence": "No fire, no risk.",
      "considerations": [
        "Red flag means extreme fire danger"
      ]
    },
    {
      "id": "wait",
      "label": "Wait to see if the wind drops",
      "verdict": "acceptable",
      "consequence": "Waiting is fine, but a red flag warning suggests skipping.",
      "considerations": [
        "Conditions may not change"
      ]
    }
  ],
  "expertNote": "A fire being legal is not the same as it being wise. Red flag conditions mean skip the flames.",
  "sayThisLine": "\"It was windy and dry, so we skipped the fire.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-10` (fr-07 / drown-stir-feel)

```json
{
  "prompt": "Leaving at dawn. The ash still looks warm.",
  "situation": {
    "narrative": "You leave in ten minutes. The fire is mostly ash but a few red coals glow.",
    "facts": [
      {
        "label": "Ash",
        "value": "Warm, few red coals"
      },
      {
        "label": "Water",
        "value": "Two buckets ready"
      },
      {
        "label": "Time",
        "value": "7 a.m."
      },
      {
        "label": "Ground",
        "value": "Dry grass nearby"
      }
    ]
  },
  "options": [
    {
      "id": "bury",
      "label": "Bury it with dirt",
      "verdict": "poor",
      "consequence": "Buried coals stay hot and can reignite.",
      "considerations": [
        "Dirt insulates coals"
      ]
    },
    {
      "id": "dse",
      "label": "Drown, stir, drown again, and feel it is cold",
      "verdict": "best",
      "consequence": "Only cold ashes are out.",
      "considerations": [
        "Stir to expose coals",
        "Feel with the back of your hand"
      ]
    },
    {
      "id": "pour",
      "label": "Pour a little water and leave",
      "verdict": "poor",
      "consequence": "Hidden coals can smolder.",
      "considerations": [
        "Stirring matters"
      ]
    }
  ],
  "expertNote": "Cold to the touch is the only definition of out.",
  "sayThisLine": "\"Drown, stir, feel. It was cold.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-11` (ck-05 / danger-zone)

```json
{
  "prompt": "The cooler sat in a hot car. Toss it?",
  "situation": {
    "narrative": "The cooler sat in the car for three hours at 85°F. The thermometer reads 46°F. It has raw chicken, salad and cheese.",
    "facts": [
      {
        "label": "Cooler temp",
        "value": "46°F",
        "emphasis": "warning"
      },
      {
        "label": "Time",
        "value": "3 hours"
      },
      {
        "label": "Ambient",
        "value": "85°F"
      },
      {
        "label": "Food",
        "value": "Raw chicken, salad, hard cheese"
      }
    ]
  },
  "options": [
    {
      "id": "cook",
      "label": "Cook the chicken well and eat it",
      "verdict": "poor",
      "consequence": "Cooking does not undo all toxins bacteria can produce.",
      "considerations": [
        "Above 40°F for too long"
      ]
    },
    {
      "id": "toss",
      "label": "Discard the perishables and keep the hard cheese",
      "verdict": "best",
      "consequence": "Perishables above 40°F for over two hours should go.",
      "considerations": [
        "Two-hour rule",
        "Some hard cheese is safer"
      ]
    },
    {
      "id": "salad",
      "label": "Eat only the salad",
      "verdict": "poor",
      "consequence": "Salad can also be risky.",
      "considerations": [
        "Perishables count"
      ]
    }
  ],
  "expertNote": "When in doubt, throw it out. Warm coolers are a common cause of camp illness.",
  "sayThisLine": "\"Above forty for two hours, we toss it.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-12` (ck-06 / water-treatment-camp)

```json
{
  "prompt": "Clear stream, 7,200 feet. How do you make it safe?",
  "situation": {
    "narrative": "A clear mountain stream runs near cattle grazing. You have a filter, tablets and a stove.",
    "facts": [
      {
        "label": "Elevation",
        "value": "7,200 feet"
      },
      {
        "label": "Source",
        "value": "Clear stream near cattle",
        "emphasis": "warning"
      },
      {
        "label": "Kit",
        "value": "Filter, tablets, stove"
      },
      {
        "label": "Time",
        "value": "Plenty"
      }
    ]
  },
  "options": [
    {
      "id": "drink",
      "label": "Drink it. It is clear.",
      "verdict": "poor",
      "consequence": "Clear water can carry parasites and bacteria.",
      "considerations": [
        "Clear is not safe"
      ]
    },
    {
      "id": "boil",
      "label": "Boil it for three minutes",
      "verdict": "best",
      "consequence": "Above 6,500 feet CDC advises three minutes.",
      "considerations": [
        "Boil fully",
        "Let it cool"
      ]
    },
    {
      "id": "filter",
      "label": "Use a filter alone",
      "verdict": "acceptable",
      "consequence": "Filters remove bacteria and parasites. Add chemicals or boil for viruses.",
      "considerations": [
        "Follow the filter label"
      ]
    }
  ],
  "expertNote": "Match treatment to what you must remove, and follow product instructions.",
  "sayThisLine": "\"Three minutes at altitude, one at sea level.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-13` (pr-04 / release-time)

```json
{
  "prompt": "Fourth of July weekend, one shot. How do you book?",
  "situation": {
    "narrative": "You want a lake campground for July 4 weekend. Sites are on a six-month rolling window.",
    "facts": [
      {
        "label": "Target date",
        "value": "July 3 arrival"
      },
      {
        "label": "Window",
        "value": "Six months rolling"
      },
      {
        "label": "Release",
        "value": "Morning of Jan 3"
      },
      {
        "label": "Backups",
        "value": "Two other campgrounds"
      }
    ]
  },
  "options": [
    {
      "id": "late",
      "label": "Wait until spring to look",
      "verdict": "poor",
      "consequence": "Popular sites are gone in seconds.",
      "considerations": [
        "Book at release"
      ]
    },
    {
      "id": "release",
      "label": "Log in early on the release date, use flexible dates and backups",
      "verdict": "best",
      "consequence": "It uses the rules.",
      "considerations": [
        "Set an alarm",
        "Have backup sites",
        "Use cancellations later"
      ]
    },
    {
      "id": "next",
      "label": "Check the day after release",
      "verdict": "acceptable",
      "consequence": "You might get lucky with cancellations.",
      "considerations": [
        "Prime sites vanish fast"
      ]
    }
  ],
  "expertNote": "Book at release, and stay flexible. Cancellations are a fair second chance.",
  "sayThisLine": "\"I had an alarm set for release time.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-14` (sw-09 / wildfire-evacuation)

```json
{
  "prompt": "Smoke and an evacuation warning at camp. Now what?",
  "situation": {
    "narrative": "A plume rises over the ridge. A ranger drives through: evacuation warning, be ready to leave. Wind is toward you.",
    "facts": [
      {
        "label": "Smoke",
        "value": "Thick, drifting toward camp",
        "emphasis": "warning"
      },
      {
        "label": "Order",
        "value": "Evacuation warning",
        "emphasis": "warning"
      },
      {
        "label": "Gear",
        "value": "Tent up, kitchen out"
      },
      {
        "label": "Route",
        "value": "One road out"
      }
    ]
  },
  "options": [
    {
      "id": "pack",
      "label": "Fully pack the tent first",
      "verdict": "poor",
      "consequence": "Delay can trap you.",
      "considerations": [
        "Leave gear if needed"
      ]
    },
    {
      "id": "go",
      "label": "Grab people, pets and essentials and leave now by the posted route",
      "verdict": "best",
      "consequence": "Life over gear.",
      "considerations": [
        "Follow official orders"
      ]
    },
    {
      "id": "watch",
      "label": "Watch for an hour",
      "verdict": "poor",
      "consequence": "Fires move faster than expected.",
      "considerations": [
        "Do not wait"
      ]
    }
  ],
  "expertNote": "Leave early on official notice. Tents are replaceable.",
  "sayThisLine": "\"We left at the warning. Gear can be replaced.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

### `cp-ds-15` (ln-02 / cathole)

```json
{
  "prompt": "Two miles in, no toilet. How do you go?",
  "situation": {
    "narrative": "You are camped in a forest 150 feet from a creek. No toilet, no WAG bag rule posted.",
    "facts": [
      {
        "label": "Location",
        "value": "Forest, 150 ft from creek"
      },
      {
        "label": "Facilities",
        "value": "None"
      },
      {
        "label": "Rule",
        "value": "No WAG requirement"
      },
      {
        "label": "Tools",
        "value": "Small trowel"
      }
    ]
  },
  "options": [
    {
      "id": "creek",
      "label": "Dig a hole by the creek",
      "verdict": "poor",
      "consequence": "Too close to water.",
      "considerations": [
        "Water pollution"
      ]
    },
    {
      "id": "far",
      "label": "Go 200 feet from water and camp, dig 6-8 inches, cover, pack out paper",
      "verdict": "best",
      "consequence": "It follows LNT.",
      "considerations": [
        "Follow local rules for paper"
      ]
    },
    {
      "id": "surface",
      "label": "Leave it on the surface",
      "verdict": "poor",
      "consequence": "It spreads disease and litter.",
      "considerations": [
        "Bury or pack out"
      ]
    }
  ],
  "expertNote": "Distance from water is the biggest rule.",
  "sayThisLine": "\"Six to eight inches, two hundred feet.\"",
  "safetyNote": "A learning aid, not safety training. Follow local land-manager rules and take a real course."
}
```

## 13. Talk Track scenarios (`talk-track`), 8 drafted

Each scenario: an enthusiast line, what it means, and reply options graded **good / meh / cringe** with a coach note. Deltas: good +20 to +25, meh 0 to +5, cringe -10 to -20. The payloads below are the curriculum `talkTracks[].payload` drafts. The launch target is 24 tracks (`conversationScenarios.count`).

| # | Track | Enthusiast line | What it means | Good | Meh | Cringe |
|---|---|---|---|---|---|---|
| 1 | `cp-tt-01` The reservation | "I got site 14! It took me four tries at release time." | She won a booking the moment a rolling window opened. | "Nice! What made the site worth it?" | "Cool." | "I could have booked it in one try." |
| 2 | `cp-tt-02` Cold night | "It got down to 30 last night. My pad was fine but my feet froze." | She had a cold night; the pad worked but her feet got cold. | "Ouch. Was it the bag or the pad?" | "That sounds cold." | "You should have slept by the fire." |
| 3 | `cp-tt-03` Fire ban | "They put a fire ban on. No campfires this weekend." | A fire ban cancels campfires, so cooking moves to the stove. | "Good call. Should we bring the stove and cook something special?" | "That is a bummer." | "We will just do a small one." |
| 4 | `cp-tt-04` Bear box | "Grab the toothpaste. It goes in the bear box too." | She reminds you that scented toiletries go in the bear box. | "Right, anything with a scent. I would have forgotten." | "Even toothpaste?" | "Bears do not care about toothpaste." |
| 5 | `cp-tt-05` Storm nerves | "There is a 40% chance of afternoon storms. I am nervous about the tent." | She is nervous about afternoon storms and camping. | "Should we check the forecast together and plan to get to the car if thunder starts?" | "It is only 40%." | "The tent will keep us safe." |
| 6 | `cp-tt-06` Dark sky | "We could see the Milky Way from camp. It was unreal." | She saw the Milky Way from a dark camp. | "I want to see that. Was it far from any town?" | "Nice." | "I see stars all the time." |
| 7 | `cp-tt-07` Leave no trace | "Someone left a trash bag by the fire ring. It drives me nuts." | She is bothered by litter left at a fire ring. | "Ugh. Should we grab it and pack it out?" | "That is annoying." | "Someone else will get it." |
| 8 | `cp-tt-08` First overnight | "Want to try a night out? I have a spare pad and bag." | She invites you on a first overnight and offers spare gear. | "Yes. I am new, so I will bring layers and food. What should I know?" | "Sure." | "I am basically an expert." |

### `cp-tt-01` (tk-06 / rolling-window)

**Terms implied:** rolling-window. **What it means:** She won a booking the moment a rolling window opened.

**Coach notes:**

- Good (+22): "Nice! What made the site worth it?" -> Curious about her why.
- Meh (+2): "Cool." -> Give her more.
- Cringe (-15): "I could have booked it in one try." -> Do not compete.

```json
{
  "title": "The reservation",
  "setting": "Texting about a campground",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I got site 14! It took me four tries at release time.",
      "replies": [
        {
          "id": "good",
          "text": "Nice! What made the site worth it?",
          "smoothDelta": 22,
          "theirResponse": "Ha, it backs to the creek and has a flat pad.",
          "coachNote": "Curious about her why."
        },
        {
          "id": "meh",
          "text": "Cool.",
          "smoothDelta": 2,
          "theirResponse": "Yeah, thanks.",
          "coachNote": "Give her more."
        },
        {
          "id": "cringe",
          "text": "I could have booked it in one try.",
          "smoothDelta": -15,
          "theirResponse": "Well, okay.",
          "coachNote": "Do not compete."
        }
      ]
    }
  ]
}
```

### `cp-tt-02` (tk-02 / overnight-low)

**Terms implied:** overnight-low, r-value. **What it means:** She had a cold night; the pad worked but her feet got cold.

**Coach notes:**

- Good (+20): "Ouch. Was it the bag or the pad?" -> You ask about the system.
- Meh (+2): "That sounds cold." -> Ask more.
- Cringe (-12): "You should have slept by the fire." -> Never suggest heat in the tent.

```json
{
  "title": "Cold night",
  "setting": "After a night out",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "It got down to 30 last night. My pad was fine but my feet froze.",
      "replies": [
        {
          "id": "good",
          "text": "Ouch. Was it the bag or the pad?",
          "smoothDelta": 20,
          "theirResponse": "The bag. I should have worn dry socks.",
          "coachNote": "You ask about the system."
        },
        {
          "id": "meh",
          "text": "That sounds cold.",
          "smoothDelta": 2,
          "theirResponse": "Yes.",
          "coachNote": "Ask more."
        },
        {
          "id": "cringe",
          "text": "You should have slept by the fire.",
          "smoothDelta": -12,
          "theirResponse": "That is not a great idea.",
          "coachNote": "Never suggest heat in the tent."
        }
      ]
    }
  ]
}
```

### `cp-tt-03` (tk-05 / fire-ban)

**Terms implied:** fire-ban, shutoff-valve. **What it means:** A fire ban cancels campfires, so cooking moves to the stove.

**Coach notes:**

- Good (+22): "Good call. Should we bring the stove and cook something special?" -> You support the rule.
- Meh (+3): "That is a bummer." -> Offer a plan.
- Cringe (-20): "We will just do a small one." -> Fire bans are legal orders.

```json
{
  "title": "Fire ban",
  "setting": "Planning a weekend",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They put a fire ban on. No campfires this weekend.",
      "replies": [
        {
          "id": "good",
          "text": "Good call. Should we bring the stove and cook something special?",
          "smoothDelta": 22,
          "theirResponse": "Yes! I can do a stove version of s'mores.",
          "coachNote": "You support the rule."
        },
        {
          "id": "meh",
          "text": "That is a bummer.",
          "smoothDelta": 3,
          "theirResponse": "Yeah.",
          "coachNote": "Offer a plan."
        },
        {
          "id": "cringe",
          "text": "We will just do a small one.",
          "smoothDelta": -20,
          "theirResponse": "No, we will not.",
          "coachNote": "Fire bans are legal orders."
        }
      ]
    }
  ]
}
```

### `cp-tt-04` (tk-02 / attractants)

**Terms implied:** attractants, bear-box. **What it means:** She reminds you that scented toiletries go in the bear box.

**Coach notes:**

- Good (+22): "Right, anything with a scent. I would have forgotten." -> You learn and say so.
- Meh (+3): "Even toothpaste?" -> Fine, but learn.
- Cringe (-18): "Bears do not care about toothpaste." -> Do not dismiss rules.

```json
{
  "title": "Bear box",
  "setting": "Arriving at camp",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Grab the toothpaste. It goes in the bear box too.",
      "replies": [
        {
          "id": "good",
          "text": "Right, anything with a scent. I would have forgotten.",
          "smoothDelta": 22,
          "theirResponse": "Exactly.",
          "coachNote": "You learn and say so."
        },
        {
          "id": "meh",
          "text": "Even toothpaste?",
          "smoothDelta": 3,
          "theirResponse": "Yes, it has a scent.",
          "coachNote": "Fine, but learn."
        },
        {
          "id": "cringe",
          "text": "Bears do not care about toothpaste.",
          "smoothDelta": -18,
          "theirResponse": "They do.",
          "coachNote": "Do not dismiss rules."
        }
      ]
    }
  ]
}
```

### `cp-tt-05` (tk-04 / lightning-camp)

**Terms implied:** lightning-camp, weather. **What it means:** She is nervous about afternoon storms and camping.

**Coach notes:**

- Good (+22): "Should we check the forecast together and plan to get to the car if thunder starts?" -> You support a plan.
- Meh (+2): "It is only 40%." -> Do not dismiss her.
- Cringe (-20): "The tent will keep us safe." -> This is wrong.

```json
{
  "title": "Storm nerves",
  "setting": "Before a trip",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "There is a 40% chance of afternoon storms. I am nervous about the tent.",
      "replies": [
        {
          "id": "good",
          "text": "Should we check the forecast together and plan to get to the car if thunder starts?",
          "smoothDelta": 22,
          "theirResponse": "Yes, that would help.",
          "coachNote": "You support a plan."
        },
        {
          "id": "meh",
          "text": "It is only 40%.",
          "smoothDelta": 2,
          "theirResponse": "True, but still.",
          "coachNote": "Do not dismiss her."
        },
        {
          "id": "cringe",
          "text": "The tent will keep us safe.",
          "smoothDelta": -20,
          "theirResponse": "A tent does nothing for lightning.",
          "coachNote": "This is wrong."
        }
      ]
    }
  ]
}
```

### `cp-tt-06` (tk-08 / dark-sky)

**Terms implied:** dark-sky, milky-way-season. **What it means:** She saw the Milky Way from a dark camp.

**Coach notes:**

- Good (+22): "I want to see that. Was it far from any town?" -> A curious follow-up.
- Meh (+2): "Nice." -> Say more.
- Cringe (-12): "I see stars all the time." -> Do not one-up.

```json
{
  "title": "Dark sky",
  "setting": "Late night",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We could see the Milky Way from camp. It was unreal.",
      "replies": [
        {
          "id": "good",
          "text": "I want to see that. Was it far from any town?",
          "smoothDelta": 22,
          "theirResponse": "Two hours from the nearest city.",
          "coachNote": "A curious follow-up."
        },
        {
          "id": "meh",
          "text": "Nice.",
          "smoothDelta": 2,
          "theirResponse": "Yeah.",
          "coachNote": "Say more."
        },
        {
          "id": "cringe",
          "text": "I see stars all the time.",
          "smoothDelta": -12,
          "theirResponse": "Not like this.",
          "coachNote": "Do not one-up."
        }
      ]
    }
  ]
}
```

### `cp-tt-07` (ln-06 / micro-trash)

**Terms implied:** micro-trash, lnt-principles. **What it means:** She is bothered by litter left at a fire ring.

**Coach notes:**

- Good (+22): "Ugh. Should we grab it and pack it out?" -> Action beats complaining.
- Meh (+2): "That is annoying." -> Offer help.
- Cringe (-15): "Someone else will get it." -> Do not ignore.

```json
{
  "title": "Leave no trace",
  "setting": "At the campground",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Someone left a trash bag by the fire ring. It drives me nuts.",
      "replies": [
        {
          "id": "good",
          "text": "Ugh. Should we grab it and pack it out?",
          "smoothDelta": 22,
          "theirResponse": "Yes, thanks.",
          "coachNote": "Action beats complaining."
        },
        {
          "id": "meh",
          "text": "That is annoying.",
          "smoothDelta": 2,
          "theirResponse": "Yes.",
          "coachNote": "Offer help."
        },
        {
          "id": "cringe",
          "text": "Someone else will get it.",
          "smoothDelta": -15,
          "theirResponse": "Not great.",
          "coachNote": "Do not ignore."
        }
      ]
    }
  ]
}
```

### `cp-tt-08` (tk-07 / weight-vs-comfort)

**Terms implied:** weight-vs-comfort, camp-checklist. **What it means:** She invites you on a first overnight and offers spare gear.

**Coach notes:**

- Good (+24): "Yes. I am new, so I will bring layers and food. What should I know?" -> Honest and open.
- Meh (+2): "Sure." -> Ask more.
- Cringe (-18): "I am basically an expert." -> Never fake it.

```json
{
  "title": "First overnight",
  "setting": "Planning a first trip",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Want to try a night out? I have a spare pad and bag.",
      "replies": [
        {
          "id": "good",
          "text": "Yes. I am new, so I will bring layers and food. What should I know?",
          "smoothDelta": 24,
          "theirResponse": "I will share a checklist.",
          "coachNote": "Honest and open."
        },
        {
          "id": "meh",
          "text": "Sure.",
          "smoothDelta": 2,
          "theirResponse": "Great.",
          "coachNote": "Ask more."
        },
        {
          "id": "cringe",
          "text": "I am basically an expert.",
          "smoothDelta": -18,
          "theirResponse": "Oh really?",
          "coachNote": "Never fake it."
        }
      ]
    }
  ]
}
```

## 14. Playbook terms (179)

Each entry becomes a curriculum `concepts[]` item: `id`, `term`, `definition`, `exampleLine` (a line the camper in her life might say, shown in serif italics). Concept ids are referenced by lessons in `CDS.md` section 11. "First taught" is the unit where the concept first appears. Rules that vary by place are defined generally and defer to local posting. Cross-links to hiking concepts are in `CDS.md` section 1.

| id | Term | Definition | Example line | First taught |
|---|---|---|---|---|
| `front-country` | Front-country camping | Camping you can drive or walk a short way to, usually in a developed campground with tables, toilets and water. | "We are front-country this weekend, so yes, I am bringing the real coffee pot." | `camp-basics` |
| `backcountry` | Backcountry camping | Camping away from roads and services, reached on foot, bike or boat, where you carry everything you need. | "Backcountry means no toilets, no water tap, no nothing. I love it." | `camp-basics` |
| `car-camping` | Car camping | Driving to a site and camping beside the vehicle, so gear weight barely matters and comfort can win. | "Car camping is the only time I own a camp chair with a cupholder." | `camp-basics` |
| `tent-pad` | Tent pad | The flat, cleared, often gravel or packed-dirt patch in a developed site where the tent goes. | "Site 14 has a great tent pad. Level, and not in a puddle zone." | `camp-basics` |
| `fire-ring` | Fire ring | A metal or stone ring in a campsite that contains the campfire; where fires are allowed you use the existing one. | "We had a proper fire ring, so we did not scar up a new spot." | `camp-basics` |
| `bear-box` | Bear box | A metal food-storage locker at a campsite that bears cannot open; all food and scented items go inside. | "Everything with a smell goes in the bear box. Even the toothpaste." | `camp-basics` |
| `campground-loop` | Campground loop | A ring of numbered sites along one road inside a campground; loops differ in shade, noise and privacy. | "Loop B is quieter. Loop A is right by the bathrooms." | `camp-basics` |
| `hookups` | Hookups | Electric, water and sometimes sewer connections at a site, mainly used by RVs and trailers. | "We booked a full-hookup site because the trailer has an air conditioner." | `camp-basics` |
| `camp-host` | Camp host | A volunteer or staff member who lives at a campground and helps with rules, firewood and questions. | "The camp host told us the owl is in the big cedar. Bring a headlamp." | `camp-basics` |
| `quiet-hours` | Quiet hours | Posted hours, often 10 pm to 6 am, when noise, generators and loud voices are not allowed. | "Quiet hours start at ten, so the guitar goes back in the car." | `camp-basics` |
| `check-in-time` | Check-in and checkout time | The posted times when a site becomes yours and when you must be gone; showing up early may not get you the site. | "Checkout is noon, so we are packing the tent while the coffee brews." | `camp-basics` |
| `camp-checklist` | Camp checklist | A packing list built from your trip type, so nothing essential like the stakes or the lighter stays home. | "I keep a checklist in my phone. It has saved us from forgetting the stove." | `camp-basics` |
| `camp-zones` | Camp zones | Splitting camp into a cooking area, a sleeping area and a toilet or wash area so smells, mess and traffic stay apart. | "Kitchen over there, tent over here. Never sleep where you cook." | `camp-basics` |
| `red-light-mode` | Red light mode | A dim red setting on a headlamp that keeps your night vision and bothers neighbors and sleepers less. | "I switch to red so I do not blind everyone at the picnic table." | `camp-basics` |
| `weight-vs-comfort` | Weight versus comfort | The core camping trade-off: every extra pound is free in a car and costly on your back. | "In the car I bring the cast-iron. On the trail it stays home." | `camp-basics` |
| `rainfly` | Rainfly | The waterproof outer cover of a tent that sheds rain and adds a layer of warmth. | "We put the rainfly on even though it looked clear. Good call at 2 a.m." | `shelter-and-sleep` |
| `footprint` | Footprint | A groundsheet cut to the tent floor that protects it from abrasion and adds a moisture barrier. | "The footprint keeps rocks from chewing up the floor." | `shelter-and-sleep` |
| `vestibule` | Vestibule | A covered porch space outside the tent door where you leave boots and packs out of the rain. | "Boots live in the vestibule so the mud stays out of the sleeping area." | `shelter-and-sleep` |
| `tent-poles` | Poles and pole sleeves | The flexible frame of a tent, threaded through sleeves or clips to give it shape. | "I broke a pole section, but the repair sleeve got us through the weekend." | `shelter-and-sleep` |
| `three-season-tent` | Three-season tent | A tent built for spring, summer and fall with good ventilation and rain protection but limited snow strength. | "It is a three-season tent, so I am not taking it to the snow." | `shelter-and-sleep` |
| `four-season-tent` | Four-season tent | A stronger, warmer, often heavier tent designed for winter wind and snow load, with less ventilation. | "Four-season tent, because the forecast has wind and snow up high." | `shelter-and-sleep` |
| `freestanding` | Freestanding tent | A tent that holds its shape on its poles alone; stakes are for wind and for keeping it from blowing away. | "Freestanding, so we could set it on a tent platform without stakes." | `shelter-and-sleep` |
| `trekking-pole-shelter` | Trekking-pole shelter | A lightweight shelter held up by hiking poles instead of dedicated tent poles. | "My tent is trekking-pole supported, so it weighs about a pound." | `shelter-and-sleep` |
| `hammock-camping` | Hammock camping | Sleeping in a suspended hammock, usually with a tarp above and an underquilt for warmth. | "Hammock camp, so I need two good trees and an underquilt." | `shelter-and-sleep` |
| `guy-line` | Guy line | A cord that ties a tent or tarp to a stake or anchor to steady it in wind. | "Guy it out or the fly will flap all night." | `shelter-and-sleep` |
| `stake-out` | Staking and anchoring | Securing the tent to the ground with stakes, or with rocks or gear where stakes will not hold. | "The ground was rock hard, so we anchored the corners with rocks." | `shelter-and-sleep` |
| `tent-orientation` | Tent orientation | Pitching so the door faces away from wind and the narrow end takes the gusts. | "I pitched it with the low end into the wind." | `shelter-and-sleep` |
| `sleeping-pad` | Sleeping pad | The insulation and cushion under you; the ground steals more heat than the air does. | "The pad matters more than the bag. Cold ground is the enemy." | `shelter-and-sleep` |
| `r-value` | R-value | A number for how well a sleeping pad resists heat loss; higher means warmer, and it adds up when pads are stacked. | "R-value of five, so I am toasty even on frozen ground." | `shelter-and-sleep` |
| `bag-temp-rating` | Sleeping bag temperature rating | The standardized temperature a bag is rated for; the comfort number is the honest one, not the extreme number. | "Comfort rating is 25, so I treat it like a 30 to 35 degree bag." | `shelter-and-sleep` |
| `down-vs-synthetic` | Down versus synthetic | Down is lighter and more packable but loses warmth when wet; synthetic insulates better damp and costs less. | "Synthetic, since it is going to rain and I do not want a wet down bag." | `shelter-and-sleep` |
| `bag-liner` | Sleeping bag liner | A thin sleeping sack that adds a few degrees of warmth and keeps the bag clean. | "A silk liner adds warmth and I wash it instead of the bag." | `shelter-and-sleep` |
| `condensation` | Condensation | Moisture from breath and damp air collecting as droplets on the inside of a tent wall, even when it is not raining. | "The tent was wet inside, but it was condensation, not a leak." | `shelter-and-sleep` |
| `ventilation` | Ventilation | Opening vents and doors to move humid air out so condensation and stuffiness stay down. | "Crack the vents, you will wake up drier." | `shelter-and-sleep` |
| `fill-power` | Fill power | A measure of down quality: higher fill power means more loft and warmth for the weight. | "800 fill down packs so small it disappears in my pack." | `shelter-and-sleep` |
| `dry-sleep-clothes` | Dry sleep clothes | A set of clothes kept dry just for sleeping; never sleep in the clothes you hiked or sweated in. | "I keep one dry base layer only for the sleeping bag." | `shelter-and-sleep` |
| `wet-gear-management` | Wet gear management | Keeping wet items out of the sleeping area, drying what you can, and protecting the dry system. | "Wet stuff stays in the vestibule; the dry bag is sacred." | `shelter-and-sleep` |
| `site-criteria` | Campsite criteria | What makes a site good: flat, well drained, sheltered, away from hazards and water, on a durable surface. | "We chose the flat spot on the sand bar rise, not the low meadow." | `campsite-selection` |
| `drainage` | Drainage | How water moves across the ground; a site in a low spot becomes a puddle or worse when it rains. | "It rained hard, and the low spot filled. We were glad we camped on the rise." | `campsite-selection` |
| `hazard-tree` | Hazard tree | A dead, leaning or damaged tree, or one with dead limbs, that can drop wood on a tent, especially in wind. | "There was a hazard tree over the pad, so we moved." | `campsite-selection` |
| `widowmaker` | Widowmaker | Slang for a dead branch or tree that can fall without warning; look up before you pitch. | "Look up. That dead limb is a widowmaker." | `campsite-selection` |
| `cold-air-pooling` | Cold-air pooling | Cold air is heavy and drains into low spots and valley floors on still nights, making them colder than the slopes. | "Do not camp in the hollow; the cold air pools there." | `campsite-selection` |
| `dry-wash-flood` | Dry wash and flash flood risk | A dry streambed or low canyon can flood from rain miles away; do not camp in one. | "Sunny here, but the storm was upstream. Never camp in a wash." | `campsite-selection` |
| `water-setback` | Setback from water | Camping and cleaning about 200 feet (roughly 70 adult steps) from lakes and streams to protect water and shorelines and to leave room for wildlife. | "We camped 200 feet back from the lake, 70 steps, and counted." | `campsite-selection` |
| `wind-shelter` | Wind shelter | Using terrain or trees, with care, to reduce wind on the site while watching for hazard trees. | "Boulders on the windward side saved us from the gusts." | `campsite-selection` |
| `durable-camp-surface` | Durable camp surface | Bare ground, gravel, sand, rock or dry grass that recovers from use, versus fragile meadow, moss or vegetation. | "We camped on the gravel bar, not the wildflowers." | `campsite-selection` |
| `established-site` | Established site | A campsite already flattened by use; reusing it concentrates impact instead of creating a new scar. | "We used the established site instead of making a new one." | `campsite-selection` |
| `camp-triangle` | Camp triangle | Keeping cooking, sleeping and food storage well apart, commonly about 200 feet, so food smells stay away from sleeping areas. | "Kitchen, bear box, tent: three corners of a triangle." | `campsite-selection` |
| `site-scouting` | Site scouting | Walking a site before committing: looking up, down and around for hazards, water paths and better spots. | "I walk the whole site before I unpack anything." | `campsite-selection` |
| `canister-stove` | Canister stove | A small stove that screws onto a pressurized fuel canister; quick and simple but loses power in cold and wind. | "Canister stove, because I want coffee in two minutes." | `camp-kitchen-and-water` |
| `liquid-fuel-stove` | Liquid fuel stove | A stove that burns white gas or multi-fuel from a refillable bottle; reliable in cold and easy to refuel abroad. | "Liquid fuel stove for winter; it just works in the cold." | `camp-kitchen-and-water` |
| `alcohol-stove` | Alcohol stove | A very light, simple stove that burns denatured alcohol; slow and hard to see flame in daylight. | "Alcohol stove, it weighs an ounce, but I check the flame carefully." | `camp-kitchen-and-water` |
| `two-burner-stove` | Two-burner camp stove | A suitcase-style propane stove for car camping that cooks like a small range. | "We bring the two-burner and cook real breakfast." | `camp-kitchen-and-water` |
| `stove-safety` | Stove safety | Rules for safe stove use: stable level surface, outdoors, away from tent and brush, never refuel hot, never leave lit. | "I never cook in the tent. Not even a little." | `camp-kitchen-and-water` |
| `camp-kitchen-layout` | Camp kitchen layout | A stable table or ground spot for the stove with a wind screen, a water source and a clean and dirty flow. | "Kitchen station: stove, prep board, wash bin, trash bag." | `camp-kitchen-and-water` |
| `meal-planning` | Meal planning | Planning meals and quantities by day, with fuel and water factored in, so you do not overpack or run short. | "I plan every meal and bring one extra dinner." | `camp-kitchen-and-water` |
| `cooler-craft` | Cooler craft | Packing a cooler so food stays cold: pre-chill, block ice, layers, shade and keeping it closed. | "Block ice lasts longer, and I keep the cooler in shade." | `camp-kitchen-and-water` |
| `danger-zone` | The danger zone | The 40 to 140 degrees Fahrenheit range where bacteria multiply fast; keep cold food at 40 or below and hot food hot. | "Cold stuff stays under forty, or we toss it after two hours." | `camp-kitchen-and-water` |
| `water-treatment-camp` | Treating camp water | Making stream or lake water safer with boiling, filtering, chemicals or UV, matched to what you are trying to remove. | "Filter first, then treat if there is any chance of viruses." | `camp-kitchen-and-water` |
| `potable-water` | Potable water | Water designated safe to drink, like campground taps; posted signs say if it is not. | "The tap at the end of the loop is potable. I filled all our bottles." | `camp-kitchen-and-water` |
| `dishwashing-system` | Camp dishwashing system | Scrape, wash, rinse and sanitize with a small amount of biodegradable soap, using basins away from water sources. | "Three-bin system, and the water gets strained and scattered." | `camp-kitchen-and-water` |
| `greywater` | Greywater | Used wash water; strain out food bits, carry it well away from water sources and broadcast it, or use the campground drain. | "Strain the food out and scatter the greywater. Do not dump it in the lake." | `camp-kitchen-and-water` |
| `camp-classics` | Camp classics | Foil-packet dinners, dutch oven meals, cast-iron breakfasts and s'mores: the food part of camp culture. | "Foil packets tonight. Sausage, potatoes, onions. Do not overthink it." | `camp-kitchen-and-water` |
| `wind-screen` | Wind screen | A shield that blocks wind from a stove flame; never wrap it tightly around a fuel canister, which can overheat it. | "Wind screen up, but not around the canister." | `camp-kitchen-and-water` |
| `food-conditioned` | Food-conditioned wildlife | Animals that learn to seek human food and become bold and dangerous; a fed bear is often a dead bear. | "That bear got food from campers, so now it is a problem bear." | `food-storage-and-wildlife` |
| `attractants` | Attractants | Anything with a smell that wildlife might investigate: food, trash, toiletries, coolers, pet food, even empty wrappers. | "Toothpaste counts. Anything with a smell is an attractant." | `food-storage-and-wildlife` |
| `bear-canister` | Bear canister | A hard, lockable, animal-resistant container for food and scented items, required in many backcountry areas. | "The park requires a canister, so mine lives at the edge of camp." | `food-storage-and-wildlife` |
| `igbc-certified` | IGBC-certified | A container certified by the Interagency Grizzly Bear Committee after testing; many land managers require it. | "Check that your canister is on the certified list before you buy." | `food-storage-and-wildlife` |
| `food-locker` | Food locker | A metal storage locker at a campsite or trailhead; where provided, using it is usually required. | "Locker first, always. The car is not the plan where lockers exist." | `food-storage-and-wildlife` |
| `bear-hang` | Bear hang | Suspending food from a rope between trees; only acceptable where rules allow, and hard to do correctly. | "Hang bags are outdated in most places. Canister rules are common now." | `food-storage-and-wildlife` |
| `ursack` | Ursack | A woven, animal-resistant sack; approved in some areas and not others, so check local rules. | "They allow Ursacks here, but not in the canister zone." | `food-storage-and-wildlife` |
| `odor-proof-bag` | Odor-resistant bag | A sealed bag that reduces smell; it helps but does not make food safe on its own. | "Odor bags help, but they are not a substitute for the box." | `food-storage-and-wildlife` |
| `bear-spray` | Bear spray | A pepper-based deterrent for close encounters in bear country; carry it accessible and know the local guidance. | "Bear spray is on my hip, not buried in the pack." | `food-storage-and-wildlife` |
| `wildlife-distance` | Wildlife viewing distance | National parks ask you to stay at least 100 yards from bears and wolves and 25 yards from other wildlife. | "We watched the elk from the car, well over 25 yards." | `food-storage-and-wildlife` |
| `never-feed` | Never feed wildlife | Feeding, even accidentally, harms animals and makes them dependent and aggressive; it is illegal in parks. | "Do not toss it the crust. Never feed." | `food-storage-and-wildlife` |
| `small-thieves` | Camp thieves | Raccoons, ravens, jays, squirrels, marmots and mice that raid food and gear; secure food, close packs and clear crumbs. | "A raven unzipped my daypack. Food away, always." | `food-storage-and-wildlife` |
| `bear-encounter` | Bear encounter basics | Never approach; stay calm, keep distance, back away and follow the local guidance; principles vary by species and place. | "Do not run. Talk calmly, back up, and give it room." | `food-storage-and-wildlife` |
| `vehicle-food-storage` | Vehicle food storage | Locking food in a hard-sided closed vehicle, allowed only where the rules say so; lockers first, and a soft-top or open window does not count. | "Only in the car where allowed, and we check the rule first." | `food-storage-and-wildlife` |
| `campfire-culture` | Campfire culture | The songs, stories and s'mores around a fire that make it social and also make it a hazard. | "The fire is why people love camp, and why we treat it seriously." | `fire-and-fire-rules` |
| `fire-pan` | Fire pan | A raised metal tray that holds a fire off the ground, leaving no scar; used where fires are allowed and the rules permit pans. | "Fire pan, so nothing touches the ground." | `fire-and-fire-rules` |
| `mound-fire` | Mound fire | A low fire built on a layer of mineral soil to insulate the ground, used only where allowed. | "Mound fire, and we scattered it all when we left." | `fire-and-fire-rules` |
| `fire-restrictions` | Fire restriction stages | Officials limit fires as danger rises, from Stage 1 to Stage 2 or a full ban; stages differ by agency and area. | "Stage 2 restrictions, so no campfires at all today." | `fire-and-fire-rules` |
| `fire-ban` | Fire ban | A prohibition on open flames and sometimes charcoal, smoking outside vehicles and some stoves. | "There is a fire ban, so only cook stoves with shutoff valves." | `fire-and-fire-rules` |
| `shutoff-valve` | Shutoff valve stove | A stove with an on-off valve, which some fire-restriction orders allow even when campfires are banned. | "Stoves with shutoff valves are OK under the ban, but I still check the order." | `fire-and-fire-rules` |
| `firewood-rules` | Firewood rules | Buy wood locally or use certified heat-treated wood; do not cut live trees or take standing dead wood unless permitted. | "We bought wood at the camp store, no hauling." | `fire-and-fire-rules` |
| `dont-move-firewood` | Do not move firewood | Firewood can carry insects and disease across regions, so burn it where you buy it or use certified heat-treated wood. | "Buy where you burn. We are not carrying bugs across the state." | `fire-and-fire-rules` |
| `dead-and-down` | Dead and down | Wood already on the ground, small and dead, that can be gathered where rules allow; standing dead trees are usually habitat. | "Only dead and down, and only where it is allowed." | `fire-and-fire-rules` |
| `fire-clearance` | Fire area clearance | Keeping tents, chairs, hanging branches, fuels and gear well away from the fire and out of the sparks path. | "Chairs back, tents way back, branches overhead checked." | `fire-and-fire-rules` |
| `drown-stir-feel` | Drown, stir, feel | The rule for putting out a fire: pour water, stir the ashes, and repeat until it is cold to the touch. | "Drown, stir, feel. If it is too hot to touch, it is not out." | `fire-and-fire-rules` |
| `unattended-fire` | Unattended fire | A fire left alone even briefly; wind can carry embers, and abandoned fires start wildfires. | "Never leave the fire alone, not even for a minute." | `fire-and-fire-rules` |
| `fire-accelerant` | Accelerants | Gasoline and similar liquids sometimes used to start fires; never use them, they cause explosive flare-ups and burns. | "No lighter fluid. No gas. That is how people get hurt." | `fire-and-fire-rules` |
| `ember-hazard` | Ember and spark hazard | Wind-blown embers and sparks can ignite dry ground; dry, windy conditions raise the risk sharply. | "It was windy and dry, so we skipped the fire." | `fire-and-fire-rules` |
| `carbon-monoxide` | Carbon monoxide | An odorless, colorless gas from burning fuel that can kill quickly in enclosed spaces like tents. | "CO has no smell. That is why we never burn anything in the tent." | `camp-safety-and-weather` |
| `co-symptoms` | CO poisoning signs | Headache, dizziness, weakness, nausea and confusion; move everyone to fresh air and call emergency help. | "Headache and dizzy in the tent? Get out and get help." | `camp-safety-and-weather` |
| `tent-heater` | Tent heater danger | Using a fuel-burning heater, stove, lantern or charcoal in a tent risks CO poisoning and fire; do not. | "No heater in the tent. Use a warmer bag instead." | `camp-safety-and-weather` |
| `hypothermia-camp` | Hypothermia at camp | A dangerous drop in body temperature from cold, wet and wind; signs include shivering, fumbling and mumbling. | "Shivering and slurring? Get warm and dry, and get help." | `camp-safety-and-weather` |
| `heat-illness-camp` | Heat illness at camp | Heat exhaustion and heatstroke from hot weather and exertion; confusion or a hot, dry skin state is an emergency. | "Confused and hot, that is heatstroke, call for help." | `camp-safety-and-weather` |
| `hot-vehicle` | Hot vehicle danger | A closed car heats rapidly and can kill children and pets within minutes; never leave them inside. | "Never leave anyone in the car, even for a minute." | `camp-safety-and-weather` |
| `lightning-camp` | Lightning at camp | No place outdoors is safe; a tent does not protect you, and a hard-topped vehicle or building is much safer. | "When thunder roars, get in the car. The tent does nothing." | `camp-safety-and-weather` |
| `wind-storm-camp` | Wind and storm at camp | High wind can collapse tents and drop limbs; secure the camp, lower or take down shelters, and move to safer ground. | "The wind picked up, so we took the tarp down." | `camp-safety-and-weather` |
| `flash-flood-camp` | Flash flood at camp | Rapid flooding of washes, streams and low ground; move to higher ground immediately and never wait for the water. | "Water rising fast, we moved uphill and left the tent." | `camp-safety-and-weather` |
| `camp-first-aid` | Camp first aid kit | A kit for cuts, burns, blisters and allergies, plus the knowledge to use it; training matters more than the kit. | "My camp kit has burn gel, tape and a wilderness first aid card." | `camp-safety-and-weather` |
| `emergency-plan` | Emergency plan | Knowing where the nearest help is, who has the car keys, and what you will do if someone is hurt or a fire starts. | "Everyone knows the meeting point and where the ranger station is." | `camp-safety-and-weather` |
| `cell-coverage-camp` | Cell coverage at camp | Many campgrounds and most backcountry have weak or no signal; plan without it and know where you can get it. | "No bars at camp, so we told a friend our plan." | `camp-safety-and-weather` |
| `wildfire-evacuation` | Campground evacuation | If wildfire or smoke threatens, leave early on official notice, take essentials, and never wait to pack the tent. | "We left when the ranger said go, tent and all left behind." | `camp-safety-and-weather` |
| `tick-mosquito-camp` | Bugs at camp | Mosquitoes, ticks and biting flies are part of camp; use repellent, covering and daily checks as the agencies advise. | "We do a tick check every night at camp." | `camp-safety-and-weather` |
| `lnt-principles` | Leave No Trace seven principles | Plan ahead, travel and camp on durable surfaces, dispose of waste, leave what you find, minimize fire impacts, respect wildlife, be considerate. | "I follow the seven principles. Pack it in, pack it out." | `leave-no-trace-at-camp` |
| `cathole` | Cathole | A small hole dug 6 to 8 inches deep, about 200 feet from water, camp and trail, for human waste, then covered. | "Six to eight inches deep and 200 feet from water." | `leave-no-trace-at-camp` |
| `wag-bag` | WAG bag | A sealed waste bag used where burying is not allowed, like popular peaks and canyons, and packed out. | "They require WAG bags up here, so we carry them out." | `leave-no-trace-at-camp` |
| `pack-out-tp` | Pack out toilet paper | Carrying used paper and hygiene products out in a sealed bag, or following the local rule for burying. | "We double-bag the used paper and carry it out." | `leave-no-trace-at-camp` |
| `vault-toilet` | Vault toilet | A non-flush toilet with a sealed underground vault; the campground option before you ever dig a hole. | "There is a vault toilet at the trailhead, so use it before we go." | `leave-no-trace-at-camp` |
| `micro-trash` | Micro-trash | Tiny litter such as bottle caps, twist ties, crumbs and foil bits that gets left behind and harms wildlife. | "We did a micro-trash sweep before we left." | `leave-no-trace-at-camp` |
| `campsite-impact` | Campsite impact | The damage from camping such as trampled vegetation, bare soil, cut trees and multiple fire scars. | "That site is trampled from years of camping." | `leave-no-trace-at-camp` |
| `leave-what-you-find` | Leave what you find | Leaving rocks, plants, antlers and cultural artifacts as they are so others can discover them. | "We took photos, not pinecones." | `leave-no-trace-at-camp` |
| `considerate-camper` | Considerate camper | Respecting neighbors with low noise, dark-friendly lights, dogs under control and no shortcuts through sites. | "Lantern down, voices low. It is a shared place." | `leave-no-trace-at-camp` |
| `group-size-limit` | Group size limit | Rules capping the number of people or stoves in a party to lower impact, especially in wilderness. | "The wilderness limit is twelve, so we split into two groups." | `leave-no-trace-at-camp` |
| `geotagging` | Geotagging fragile places | Posting exact locations of quiet sites can send crowds to them; many outdoors people share less precisely. | "I left the geotag off. That spot cannot take a crowd." | `leave-no-trace-at-camp` |
| `public-land-agencies` | Public land agencies | NPS, USFS, BLM, state parks and others each run camping with different rules, fees and booking systems. | "That is national forest, not park, so the rules are different." | `public-lands-and-reservations` |
| `developed-campground` | Developed campground | A managed campground with numbered sites and services, usually reserved and paid. | "Developed campground, so there is a table, a ring and a tap." | `public-lands-and-reservations` |
| `dispersed-camping` | Dispersed camping | Camping outside developed campgrounds on public land, often free, with no services and strict leave-no-trace expectations. | "Dispersed camping, no amenities, and we packed everything out." | `public-lands-and-reservations` |
| `stay-limit` | Stay limit | A cap on how many nights you can camp in one place or area, commonly 14 days on many public lands but it varies. | "Fourteen-day limit, so we moved on after two weeks." | `public-lands-and-reservations` |
| `recreation-gov` | Recreation.gov | The federal reservation site for many campgrounds and permits run by NPS, USFS, BLM and others. | "I have the release date on my calendar for Recreation.gov." | `public-lands-and-reservations` |
| `rolling-window` | Rolling booking window | A reservation system where each day, new dates open exactly a set time ahead, commonly six months on many Recreation.gov sites. | "It is a six-month rolling window, so I book at the minute it opens." | `public-lands-and-reservations` |
| `release-time` | Release time | The exact moment new dates open, which is why prime sites vanish in seconds. | "Release is at ten a.m. Eastern; I had my finger on the button." | `public-lands-and-reservations` |
| `cancellation-hunting` | Cancellation hunting | Watching for sites released after others cancel, using alerts or repeated checks, a legitimate way to get a full booking. | "I got the site on a cancellation, at midnight." | `public-lands-and-reservations` |
| `first-come-site` | First-come, first-served site | A site that is not reserved in advance; you arrive early, find one open and pay at a station or online. | "First-come only, so we arrived Thursday morning." | `public-lands-and-reservations` |
| `self-pay-station` | Self-pay station | A fee tube or kiosk at a campground where you pay for a first-come site and post your receipt. | "Fee envelope, cash or card, and the tag goes on the post." | `public-lands-and-reservations` |
| `wilderness-permit-camp` | Wilderness camping permit | A required permit, often with quotas, for overnight backcountry trips in certain areas. | "We need a wilderness permit, and the quota fills fast." | `public-lands-and-reservations` |
| `permit-lottery-camp` | Permit lottery | A random draw for limited permits or sites, used for very popular places. | "I entered the lottery and I did not win." | `public-lands-and-reservations` |
| `quota` | Quota | A limit on the number of visitors or campers per night to protect the place and the experience. | "The quota is twelve parties, so it sells out." | `public-lands-and-reservations` |
| `site-attributes` | Site attributes | Listing details like tent-only, max vehicle length, pad type, proximity to water and accessibility features. | "Site 22 is tent-only with a walk-in path from the lot." | `public-lands-and-reservations` |
| `walk-in-site` | Walk-in site | A site reached by a short walk from the parking area; often quieter and tent-only. | "Walk-in sites are more private, and worth the haul." | `public-lands-and-reservations` |
| `cancellation-policy` | Cancellation and change policy | The rules and fees for canceling or changing a reservation; they differ by facility and agency. | "There was a change fee, so I checked before rebooking." | `public-lands-and-reservations` |
| `discount-pass` | Discount passes | Some federal passes give reduced camping fees at some sites, such as for seniors and access pass holders; confirm the site rule. | "Her pass gives half off at some sites, but not all." | `public-lands-and-reservations` |
| `rv-etiquette` | RV and generator etiquette | Running generators only in allowed hours, keeping lights and noise down, and respecting neighbors. | "Generator hours are posted, and we stick to them." | `car-camping-life` |
| `camp-kitchen-box` | Camp kitchen box | A bin or box packed with cookware, utensils and staples so a car camp kitchen can be set up quickly. | "The kitchen box lives in the garage, packed and ready." | `car-camping-life` |
| `leash-rules` | Dogs at camp | Dogs must generally be leashed, kept out of water sources and never left unattended; pets add wildlife and noise issues. | "Leash on, waste bags packed, and the dog stays with us." | `car-camping-life` |
| `camp-chair-culture` | Camp comfort gear | Chairs, tables, cots, canopies and lanterns that make car camping comfortable. | "I would take the camp chair over the mountain view." | `car-camping-life` |
| `rain-day-plan` | Rain day plan | Games, tarp cover, a dry cooking area and a plan for staying comfortable when it rains. | "Tarp over the kitchen, cards out, and we are fine." | `car-camping-life` |
| `kids-at-camp` | Camping with kids | Rules and routines for young campers: boundaries, fire and water supervision, and early bedtimes. | "The kids know the fire circle rules and the boundary." | `car-camping-life` |
| `overnight-backpacking` | Overnight backpacking | A hike with one or more nights out, carrying shelter, sleep system, food and water. | "Just one night out, so my pack is 22 pounds." | `backpacking-overnight` |
| `trip-mileage-camp` | Miles to camp | Choosing a camp distance you can reach with daylight, given climb, pack weight and pace. | "Six miles to camp, with 1,800 feet of climb, feels right." | `backpacking-overnight` |
| `water-carry` | Water carry | How much water to haul between sources, given weight and reliability; water is heavy. | "Dry camp, so I carry three liters up." | `backpacking-overnight` |
| `designated-site` | Designated campsite | A specific numbered camp spot required by a permit in some backcountry areas. | "We have designated site 4 at the lake." | `backpacking-overnight` |
| `dry-camp` | Dry camp | Camping where there is no nearby water, so you carry everything from the last source. | "It is a dry camp. Fill up at the spring." | `backpacking-overnight` |
| `break-camp` | Break camp | Packing up and leaving a site cleaner than you found it, in an efficient morning routine. | "We break camp by eight, so we hit the trail before the heat." | `backpacking-overnight` |
| `canister-placement` | Canister placement | Storing a bear canister away from the tent, on flat ground, not near water or cliffs. | "The canister sits well away from camp on a flat spot." | `backpacking-overnight` |
| `tent-vs-tarp` | Tent versus tarp | Trade-off between a full enclosed tent and a lighter open tarp; bugs, wind and skill drive the choice. | "Tarp, because I want to sleep under the stars, but bugs will win." | `camp-gear-debates` |
| `stove-debate` | Stove debate | Canister for simplicity, liquid fuel for cold and longer trips, alcohol for weight, wood for fuel-free camps where allowed. | "Canister stove or bust, I am not fussing with fuel." | `camp-gear-debates` |
| `canister-vs-ursack` | Canister versus Ursack | Canisters are hard, heavy and widely accepted; sacks are lighter but allowed less places, and none replace local rules. | "Ursack is lighter, but this area needs a hard canister." | `camp-gear-debates` |
| `pad-debate` | Pad wars | Foam is cheap and tough, inflatables are comfy and warmer per ounce but can puncture. | "Foam pad, because a leak at midnight is a nightmare." | `camp-gear-debates` |
| `rooftop-tent` | Rooftop tents | A tent mounted on a vehicle roof; fast setup and comfort versus cost, weight, fuel economy and site limits. | "Rooftop tent, so setup takes two minutes." | `camp-gear-debates` |
| `glamping` | Glamping | Camping with comfort touches such as real beds, large tents or cabins. | "Glamping is my kind of camping, and I own it." | `camp-gear-debates` |
| `cowboy-camping` | Cowboy camping | Sleeping under the sky with no shelter, best in dry stable weather and where bugs and rules allow. | "Cowboy camp, no tent, just stars and my bag." | `camp-gear-debates` |
| `ultralight-camp` | Ultralight camping | Minimizing camp gear weight, trading comfort and margin for speed and distance. | "Ultralight camp, no chair, no extra, just what matters." | `camp-gear-debates` |
| `taut-line-hitch` | Taut-line hitch | An adjustable knot for tent guy lines and tarp ridgelines that slides to tighten and holds when loaded. | "Taut-line hitch on every guy line so I can tension it." | `camp-craft-skills` |
| `bowline` | Bowline | A fixed loop knot that does not slip and is easy to untie, useful for anchoring lines. | "Bowline on the ridgeline, and it holds all night." | `camp-craft-skills` |
| `trucker-hitch` | Trucker's hitch | A knot system that gives mechanical advantage for cinching a line tight, such as a tarp ridgeline. | "Trucker's hitch, and the ridgeline is drum tight." | `camp-craft-skills` |
| `tarp-pitch` | Tarp pitches | Standard ways to set a tarp such as A-frame and lean-to, chosen for wind, rain and space. | "A-frame in the wind, lean-to when I want the view." | `camp-craft-skills` |
| `dutch-oven` | Dutch oven cooking | Cooking in a heavy lidded pot with coals above and below, a car-camp tradition. | "Dutch oven cobbler is the reason I love camping." | `camp-craft-skills` |
| `camp-repair` | Camp repair | Quick fixes for tents, pads and stoves: repair tape, patches, spare stakes, cord and sealant. | "Tenacious tape fixed the fly, and we kept camping." | `camp-craft-skills` |
| `knife-safety` | Camp knife safety | Cutting away from your body, keeping blades sheathed and dry and working seated on stable ground. | "Cut away from yourself, always." | `camp-craft-skills` |
| `camp-weather-eyes` | Reading camp weather | Watching sky, wind and pressure trends to spot storms and cold nights early; see hiking for the full weather units. | "The wind shifted and the clouds thickened, so we tightened the tent." | `camp-craft-skills` |
| `camp-history` | Camping history | From early recreation camps and the Civilian Conservation Corps to national parks and modern RV culture, camping has shaped how people access outdoors. | "The CCC built half these campgrounds in the thirties." | `camp-culture-and-history` |
| `junior-ranger` | Junior Ranger | A park program where kids complete activities to earn a badge; many adults love it too. | "We did the Junior Ranger booklet, and the badge is on the fridge." | `camp-culture-and-history` |
| `ranger-program` | Ranger program | Evening talks, walks and stargazing led by park rangers, a staple of campground life. | "The ranger talk was about owls, and we learned so much." | `camp-culture-and-history` |
| `dark-sky` | Dark sky | A location with little light pollution where stars and the Milky Way show clearly. | "We drove three hours for a real dark sky." | `camp-culture-and-history` |
| `milky-way-season` | Milky Way season | The months when the galactic core is visible in the night sky, roughly spring to early fall in the Northern Hemisphere. | "Milky Way season starts in spring, so we are planning." | `camp-culture-and-history` |
| `meteor-shower` | Meteor shower | A night of many shooting stars, best watched from dark places with patience; peak nights are on published calendars. | "Perseids peak in August, so we booked early." | `camp-culture-and-history` |
| `van-life` | Van life and overlanding | Living or traveling from a vehicle, often camping in dispersed spots; a culture with its own gear and etiquette. | "We are overlanding for the weekend, so a dispersed site." | `camp-culture-and-history` |
| `smores` | S'mores | Graham cracker, chocolate and toasted marshmallow, the icon of campfire tradition. | "Nobody skips s'mores. It is the whole point." | `fire-and-fire-rules` |
| `campfire-stories` | Campfire stories and songs | Ghost stories, songs and games by the fire, a social ritual with generations of tradition. | "We told ghost stories until the fire died down." | `camp-culture-and-history` |
| `fire-danger-rating` | Fire danger rating | A daily rating of how easily fires can start and spread in an area, often from low to extreme. | "Fire danger is very high, so no fire tonight." | `camping-season-layer` |
| `campground-alert` | Campground alert | A notice about closures, bear activity, road damage, water shutoffs or fire in a campground. | "There was a closure alert, so we called ahead." | `camping-season-layer` |
| `shoulder-season-camp` | Shoulder season camping | Spring and fall camping, with fewer crowds, colder nights, limited services and closed facilities. | "Shoulder season, so it is cold but the sites are empty." | `camping-season-layer` |
| `overnight-low` | Overnight low | The forecast low temperature at camp, which drives bag, pad and clothing choices more than the daytime high. | "Highs in the seventies, but the low is 34, so bring the warm bag." | `camping-season-layer` |
| `hunting-season-camp` | Hunting season at camp | In many areas fall camping overlaps hunting season; wear bright colors and check local dates. | "It is hunting season, so we wore orange." | `camping-season-layer` |
| `seasonal-camp-window` | Camp season window | The months when a campground is open and comfortable, from snowmelt to first frost, often with reservation rush dates. | "The window is June to September, and July is booked solid." | `camping-season-layer` |
| `camp-report` | Camp report | A recent report from campers about a site or campground: bugs, water, noise, road and crowd conditions. | "The camp report says the road is rough, so bring the truck." | `camping-season-layer` |
