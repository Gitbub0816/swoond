# Hiking: Native Exercise Plan (Tier B)

Native exercise plan for the `hiking` course. Payloads conform to `docs/contracts/native-exercises/v1/<type>.schema.json` (every sample below was validated against its schema with ajv). Type behavior, scoring and UI are in `docs/native-exercises/CATALOG.md`. The one Unity sim (`hiking.navigation.topo-terrain.v1`) is specified separately in `sims/`.

## 1. Safety constraints (apply to every exercise)

- **Swoon'd teaches appreciation, not a substitute for real safety training.** It does not replace a wilderness first aid course, navigation training, avalanche training, swiftwater training or local ranger guidance.
- Every `decision-scenario` carries a `safetyNote`. Scenarios never call a route, crossing, weather window or time "safe"; the best answer is the conservative one, and turning back is always a valid best answer when risk rises.
- **No gamified pressure on hazards:** no countdown timers, streak bonuses or speed rewards on scenarios involving lightning, floods, crossings, wildlife, altitude, heat, snow or lost-hiker situations. (Hearts follow the catalog rule; the copy never shames.)
- No medical procedures beyond recognition and "descend / seek help"; wildlife advice is principles only and defers to local rangers; avalanche content is awareness only.
- Voice: warm coach, never condescending, never about the crush; explanations teach why, not just the rule.
- Live-conditions scenarios are generated from official data, marked with source and age, and pass a safety linter (see `live-data.md`).
- Assets: diagrams are procedural (`swoond-procedural`), illustrations original (`swoond-original-illustration`); no scraped imagery.

## 2. Types used and planned counts

| Native type | Planned use | Est. authored items at launch | Samples below |
|---|---|---|---|
| `multiple-choice` | see CDS section 12 | ~232 | 5 |
| `decision-scenario` | see CDS section 12 | ~126 | 13 |
| `say-this` | see CDS section 12 | ~90 | 6 |
| `talk-track` | see CDS section 12 | ~13 | 9 |
| `term-match` | see CDS section 12 | ~22 | 4 |
| `fill-the-gap` | see CDS section 12 | ~52 | 4 |
| `sequence-order` | see CDS section 12 | ~20 | 4 |
| `visual-id` | see CDS section 12 | ~32 | 4 |
| `hotspot-tap` | see CDS section 12 | ~24 | 4 |
| `binary-call` | see CDS section 12 | ~28 | 4 |
| `estimate-slider` | see CDS section 12 | ~52 | 5 |
| `timing-tap` | Not used (no 1D timing concept) | 0 | n/a |
| `listening-id` | Not used at launch (audio licensing) | 0 | n/a |

## 3. Multiple choice (`multiple-choice`) samples

### `hk-mc-01` (tb-01 / ten-essentials)

```json
{
  "prompt": "Why carry a headlamp on a morning hike?",
  "options": [
    {
      "id": "finish-dark",
      "text": "In case the hike runs past dark",
      "explanation": "Delays, wrong turns and slow partners push finish times later than planned."
    },
    {
      "id": "bright-sun",
      "text": "To see better in bright sun"
    },
    {
      "id": "signal-planes",
      "text": "To signal aircraft"
    },
    {
      "id": "required",
      "text": "Parks require one by law"
    }
  ],
  "correctOptionIds": [
    "finish-dark"
  ],
  "explanation": {
    "correct": "Plans slip. A headlamp turns a late finish into an inconvenience instead of an emergency.",
    "incorrect": "Nobody plans to be out after dark, which is why the light lives in the pack anyway. It is the cheapest insurance on the list.",
    "sayThisLine": "\"I always throw a headlamp in. Plans have a way of running long.\""
  }
}
```

### `hk-mc-02` (rt-01 / elevation-gain)

```json
{
  "prompt": "Two 6-mile hikes: 300 ft gain versus 2,400 ft gain. Which is harder?",
  "options": [
    {
      "id": "flat",
      "text": "The 300 ft one, it is longer"
    },
    {
      "id": "steep",
      "text": "The 2,400 ft one"
    },
    {
      "id": "same",
      "text": "They are identical, both are 6 miles"
    },
    {
      "id": "neither",
      "text": "Impossible to say"
    }
  ],
  "correctOptionIds": [
    "steep"
  ],
  "explanation": {
    "correct": "Climbing dominates effort and time. Roughly, 2,400 ft of gain adds over an hour by Naismith's rule.",
    "incorrect": "Distance is only half the story. Vertical gain slows your pace, raises heart rate and stresses knees on the way down.",
    "sayThisLine": "\"Six miles? What's the gain? That changes everything.\""
  }
}
```

### `hk-mc-03` (nv-03 / contour-line)

```json
{
  "prompt": "On a topo map, contour lines packed tightly mean what?",
  "options": [
    {
      "id": "steep",
      "text": "Steep ground",
      "explanation": "Small horizontal distance covers a lot of elevation."
    },
    {
      "id": "flat",
      "text": "Flat ground"
    },
    {
      "id": "water",
      "text": "Water or a lake"
    },
    {
      "id": "forest",
      "text": "Dense forest"
    }
  ],
  "correctOptionIds": [
    "steep"
  ],
  "explanation": {
    "correct": "Contours are equal-elevation lines. Bunched together, you climb a lot in a short distance.",
    "incorrect": "Wide gaps mean gentle ground, tight lines mean steep. Contours never depict trees or water by themselves.",
    "sayThisLine": "\"Those contours are jammed together, so that section will be steep.\""
  }
}
```

### `hk-mc-04` (nv-06 / declination)

```json
{
  "prompt": "Where does a compass needle point?",
  "options": [
    {
      "id": "true",
      "text": "True north, the geographic pole"
    },
    {
      "id": "magnetic",
      "text": "Magnetic north"
    },
    {
      "id": "grid",
      "text": "Grid north on the map"
    },
    {
      "id": "east",
      "text": "Wherever the trail goes"
    }
  ],
  "correctOptionIds": [
    "magnetic"
  ],
  "explanation": {
    "correct": "Compass needles follow Earth's magnetic field. Declination is the angle to true north and it varies by place and year.",
    "incorrect": "True and magnetic north differ, sometimes by 10 degrees or more. That is why maps list declination and why you adjust for it.",
    "sayThisLine": "\"Check the declination, the compass isn't pointing where the map says north is.\""
  }
}
```

### `hk-mc-05` (wf-03 / hyponatremia)

```json
{
  "prompt": "Hot day, six hours out. Which drinking plan is riskiest?",
  "options": [
    {
      "id": "sip-salt",
      "text": "Sip water and eat salty snacks"
    },
    {
      "id": "only-water",
      "text": "Chug plain water, no food or salt",
      "explanation": "Diluted blood sodium leads to nausea and confusion."
    },
    {
      "id": "electrolyte",
      "text": "Water plus electrolyte mix"
    },
    {
      "id": "thirst",
      "text": "Drink to thirst with snacks"
    }
  ],
  "correctOptionIds": [
    "only-water"
  ],
  "explanation": {
    "correct": "Heavy plain water without salt can dilute sodium. Balance fluid with food and electrolytes.",
    "incorrect": "Sodium loss through sweat plus plain water can cause hyponatremia. Drinking with thirst plus snacks is generally safer.",
    "sayThisLine": "\"I drink to thirst and eat salty snacks, not just chug water.\""
  }
}
```

## 4. Binary call (`binary-call`) samples

### `hk-bc-01` (tb-05 / trail-right-of-way)

```json
{
  "prompt": "You are heading downhill. A hiker climbs toward you.",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "diagram.trail.narrow-passing",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.25
      },
      {
        "role": "opponent",
        "x": 0.5,
        "y": 0.75
      }
    ],
    "alt": "Narrow trail on a slope. You stand upslope and another hiker climbs toward you."
  },
  "choices": [
    {
      "id": "i-yield",
      "label": "I step aside"
    },
    {
      "id": "they-yield",
      "label": "They step aside"
    }
  ],
  "correctChoiceId": "i-yield",
  "explanation": {
    "correct": "Customarily the uphill hiker has the right of way: they are working harder and it is harder to restart momentum.",
    "incorrect": "The common courtesy is that the descending hiker yields. If the trail is wide or they wave you through, thank them and pass.",
    "sayThisLine": "\"Go ahead, you've got the hill.\""
  },
  "ruleTag": "uphill-right-of-way"
}
```

### `hk-bc-02` (tb-05 / trail-right-of-way)

```json
{
  "prompt": "Horses approach on a hillside trail. Where do you step?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "diagram.trail.horse-pass",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.5
      },
      {
        "role": "opponent",
        "x": 0.85,
        "y": 0.5
      }
    ],
    "alt": "Trail traversing a slope with the uphill side to the left and a drop to the right. Riders approach."
  },
  "choices": [
    {
      "id": "uphill",
      "label": "Uphill side"
    },
    {
      "id": "downhill",
      "label": "Downhill side"
    }
  ],
  "correctChoiceId": "downhill",
  "explanation": {
    "correct": "Downhill is the usual advice: horses feel less threatened when they can see you below rather than looming above. Speak calmly so they know you are a person.",
    "incorrect": "Standing above a horse can spook it. Step to the downhill side, stay visible, talk and follow the riders' directions.",
    "sayThisLine": "\"I stepped off the low side and said hello. Horses hate surprises.\""
  },
  "ruleTag": "horse-right-of-way"
}
```

### `hk-bc-03` (gc-03 / cotton-kills)

```json
{
  "prompt": "Cold drizzle is forecast. Which top do you choose?",
  "scene": {
    "kind": "none",
    "alt": "Two tops shown as words only: a cotton hoodie and a synthetic long-sleeve."
  },
  "choices": [
    {
      "id": "cotton",
      "label": "Cotton hoodie"
    },
    {
      "id": "synthetic",
      "label": "Synthetic top"
    }
  ],
  "correctChoiceId": "synthetic",
  "explanation": {
    "correct": "Synthetics and wool keep insulating when damp and dry faster. Cotton absorbs water and drags heat away.",
    "incorrect": "Cotton stays wet for hours. When you stop moving, that wet layer chills you quickly.",
    "sayThisLine": "\"Cotton is a no in drizzle. Synthetic or wool.\""
  },
  "ruleTag": "cotton-kills"
}
```

### `hk-bc-04` (wx-04 / lightning-safety)

```json
{
  "prompt": "Thunder rumbles at 1 PM on an exposed ridge. Your move?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "diagram.ridge.storm",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.2
      }
    ],
    "alt": "Ridge crest above treeline with dark clouds on the horizon."
  },
  "choices": [
    {
      "id": "push",
      "label": "Continue to the summit"
    },
    {
      "id": "descend",
      "label": "Head down now"
    }
  ],
  "correctChoiceId": "descend",
  "explanation": {
    "correct": "Thunder means lightning is close enough to strike. Ridges and summits are the worst places to be, so drop to lower ground immediately.",
    "incorrect": "Pushing on adds minutes of exposure at the most dangerous point. Turn back now and wait for the storm to pass.",
    "sayThisLine": "\"Thunder means we go down, summit can wait.\""
  },
  "ruleTag": "lightning-safety"
}
```

## 5. Term match (`term-match`) samples

### `hk-tm-01` (tb-02 / route shapes)

```json
{
  "prompt": "Match each route shape.",
  "pairs": [
    {
      "id": "oab",
      "term": "Out-and-back",
      "definition": "Go to a point, return the same way"
    },
    {
      "id": "loop",
      "term": "Loop",
      "definition": "Returns to the start without retracing"
    },
    {
      "id": "lolli",
      "term": "Lollipop",
      "definition": "Stem in, loop at the far end, stem out"
    },
    {
      "id": "p2p",
      "term": "Point-to-point",
      "definition": "Ends somewhere else; needs a shuttle"
    }
  ],
  "distractorDefinitions": [
    "Route with no trail at all"
  ],
  "explanation": {
    "summary": "The shape decides logistics: a shuttle for point-to-point, a shared view for out-and-back, and a choice of direction for loops.",
    "sayThisLine": "\"Is it a loop or an out-and-back?\""
  }
}
```

### `hk-tm-02` (nv-05 / landforms)

```json
{
  "prompt": "Match the landform to its contour clue.",
  "pairs": [
    {
      "id": "ridge",
      "term": "Ridge",
      "definition": "U shapes pointing downhill from high ground"
    },
    {
      "id": "drainage",
      "term": "Drainage",
      "definition": "V shapes pointing uphill, water runs here"
    },
    {
      "id": "saddle",
      "term": "Saddle",
      "definition": "Hourglass between two high points"
    },
    {
      "id": "cliff",
      "term": "Cliff",
      "definition": "Contours merge into one thick line"
    }
  ],
  "distractorDefinitions": [
    "A wide gap between lines means a steep drop"
  ],
  "explanation": {
    "summary": "Contours bend toward higher ground around a drainage and away from it around a ridge. Saddles are hourglasses; cliffs are merged lines.",
    "sayThisLine": "\"That V is a drainage, so there's water down there.\""
  }
}
```

### `hk-tm-03` (tc-01 / trail slang)

```json
{
  "prompt": "Match the thru-hiker slang.",
  "pairs": [
    {
      "id": "nobo",
      "term": "NOBO",
      "definition": "Hiking northbound"
    },
    {
      "id": "zero",
      "term": "Zero",
      "definition": "A day with no trail miles"
    },
    {
      "id": "nero",
      "term": "Nero",
      "definition": "A near-zero day with few miles"
    },
    {
      "id": "magic",
      "term": "Trail magic",
      "definition": "Surprise kindness for hikers"
    },
    {
      "id": "tramily",
      "term": "Tramily",
      "definition": "Your trail family"
    }
  ],
  "distractorDefinitions": [
    "A hiker who quits"
  ],
  "explanation": {
    "summary": "Slang signals culture. A zero is a rest day, a nero is almost one, and trail magic is generosity from strangers.",
    "sayThisLine": "\"Did you get any trail magic out there?\""
  }
}
```

### `hk-tm-04` (gc-02 / layers)

```json
{
  "prompt": "Match each layer to its job.",
  "pairs": [
    {
      "id": "base",
      "term": "Base layer",
      "definition": "Wicks sweat from your skin"
    },
    {
      "id": "mid",
      "term": "Mid layer",
      "definition": "Traps warmth"
    },
    {
      "id": "shell",
      "term": "Shell",
      "definition": "Blocks wind and rain"
    }
  ],
  "distractorDefinitions": [
    "Cotton tee that keeps you warm when wet"
  ],
  "explanation": {
    "summary": "Three jobs, three layers. Adding or removing them lets you regulate temperature instead of freezing or sweating.",
    "sayThisLine": "\"Base, mid, shell. I add and remove as I go.\""
  }
}
```

## 6. Sequence order (`sequence-order`) samples

### `hk-so-01` (gc-05 / blister-care)

```json
{
  "prompt": "Order the response to a hot spot.",
  "items": [
    {
      "id": "feel",
      "text": "Feel warmth or rub on your heel",
      "why": "That tenderness is the signal to act."
    },
    {
      "id": "stop",
      "text": "Stop and take off your shoe and sock",
      "why": "Never push through friction."
    },
    {
      "id": "dry",
      "text": "Dry and clean the area",
      "why": "Tape does not stick to damp skin."
    },
    {
      "id": "tape",
      "text": "Apply tape or a blister pad",
      "why": "Reduces friction so it never blisters."
    },
    {
      "id": "relace",
      "text": "Change socks if wet and re-lace snugly",
      "why": "A snug heel lock stops slipping."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Stopping early with dry skin and tape prevents most blisters.",
    "incorrect": "Tape on wet, unstopped friction fails. Stop first, dry, tape, then re-lace.",
    "sayThisLine": "\"Hot spot? Stop and tape it before it blisters.\""
  }
}
```

### `hk-so-02` (nv-10 / stop-method)

```json
{
  "prompt": "Put STOP in order.",
  "items": [
    {
      "id": "stop",
      "text": "Stop, stay put, breathe",
      "why": "Panic wastes energy and makes it worse."
    },
    {
      "id": "think",
      "text": "Think: when did I last know where I was?",
      "why": "Define what you know."
    },
    {
      "id": "observe",
      "text": "Observe map, GPS, surroundings and supplies",
      "why": "Gather facts before moving."
    },
    {
      "id": "plan",
      "text": "Plan: backtrack, wait, or signal",
      "why": "Choose deliberately."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "STOP turns a scary moment into a decision. Sit, think, observe, then plan.",
    "incorrect": "The letters are the order: Stop, Think, Observe, Plan. Moving first is how small errors become big ones.",
    "sayThisLine": "\"When I'm turned around I do STOP before I take another step.\""
  }
}
```

### `hk-so-03` (tb-07 / hike day)

```json
{
  "prompt": "Order a well-run hike day.",
  "items": [
    {
      "id": "forecast",
      "text": "Check forecast and conditions",
      "why": "Decide go or no-go."
    },
    {
      "id": "plan",
      "text": "Share your trip plan with someone",
      "why": "Someone knows when to worry."
    },
    {
      "id": "pack",
      "text": "Pack essentials, water and food",
      "why": "Pack for the worst plausible day."
    },
    {
      "id": "register",
      "text": "Sign the register and start",
      "why": "A record of your route."
    },
    {
      "id": "turn",
      "text": "Turn back at your turnaround time",
      "why": "Time, not summits, decides."
    },
    {
      "id": "checkin",
      "text": "Tell your contact you are back",
      "why": "Closes the loop."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "A good day starts before the trailhead and ends with a check-in.",
    "incorrect": "The order matters: forecast and plan come before the walk, and check-in closes the loop so nobody starts a search.",
    "sayThisLine": "\"I text my sister my plan before I leave and when I'm back.\""
  }
}
```

### `hk-so-04` (wx-03 / alpine start)

```json
{
  "prompt": "Order an alpine start day.",
  "items": [
    {
      "id": "night",
      "text": "Pack and check forecast the night before",
      "why": "You will be tired and dark at 3 AM."
    },
    {
      "id": "wake",
      "text": "Wake before dawn and eat",
      "why": "Fuel for the climb."
    },
    {
      "id": "climb",
      "text": "Climb in the cool morning",
      "why": "Cold dry air, quiet trail."
    },
    {
      "id": "summit",
      "text": "Summit or turn by the set time",
      "why": "Storms build after midday."
    },
    {
      "id": "down",
      "text": "Be off exposed terrain by noon",
      "why": "Afternoon lightning risk."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "The alpine start is built around getting off exposed terrain before afternoon storms.",
    "incorrect": "Reordering gives you a summit at storm time. The schedule works backward from the storm window.",
    "sayThisLine": "\"We start at four so we're off the summit by noon.\""
  }
}
```

## 7. Visual ID (`visual-id`) samples

### `hk-vi-01` (tb-04 / blaze)

```json
{
  "prompt": "What does this double blaze mean?",
  "image": {
    "asset": "hiking/img/double-blaze-offset.webp",
    "alt": "Two stacked white paint blazes on a tree, the top one shifted to the right of the lower one.",
    "license": "swoond-original-illustration"
  },
  "options": [
    {
      "id": "straight",
      "text": "Continue straight"
    },
    {
      "id": "turn",
      "text": "A turn is coming, the top blaze points the way"
    },
    {
      "id": "summit",
      "text": "You are at the summit"
    },
    {
      "id": "closed",
      "text": "The trail is closed"
    }
  ],
  "correctOptionId": "turn",
  "explanation": {
    "correct": "Two blazes stacked with the upper one offset signal a change of direction in many systems, including the Appalachian Trail. Stay alert.",
    "incorrect": "A single blaze means continue. Two stacked with an offset warns of a turn, in the direction the upper blaze is shifted.",
    "sayThisLine": "\"Double blaze, so the trail turns here.\""
  },
  "cues": [
    "Two blazes stacked vertically",
    "Top blaze offset to one side",
    "Offset points the direction of the turn"
  ]
}
```

### `hk-vi-02` (tb-04 / cairn)

```json
{
  "prompt": "What is this stack of stones for?",
  "image": {
    "asset": "hiking/img/cairn-slab.webp",
    "alt": "A small stack of flat rocks on a bare rock slab with a trail-less slope behind.",
    "license": "swoond-original-illustration"
  },
  "options": [
    {
      "id": "marker",
      "text": "It marks the route"
    },
    {
      "id": "grave",
      "text": "A memorial, do not touch"
    },
    {
      "id": "art",
      "text": "Decoration made by visitors"
    },
    {
      "id": "border",
      "text": "A property boundary"
    }
  ],
  "correctOptionId": "marker",
  "explanation": {
    "correct": "Cairns mark routes where there is no tread, like slickrock or above treeline. Do not add or move them.",
    "incorrect": "On bare rock a footpath cannot form, so cairns guide you. Adding extra ones creates confusion.",
    "sayThisLine": "\"Follow the cairns, and don't build new ones.\""
  },
  "cues": [
    "Deliberate stack of flat rocks",
    "On bare rock or open ground",
    "Spaced within sight of the next one"
  ]
}
```

### `hk-vi-03` (tn-06 / poison-ivy)

```json
{
  "prompt": "Which plant should you avoid touching?",
  "image": {
    "asset": "hiking/img/poison-ivy-leaves.webp",
    "alt": "A vine with clusters of three glossy pointed leaflets, the middle leaflet on a longer stem.",
    "license": "swoond-original-illustration"
  },
  "options": [
    {
      "id": "ivy",
      "text": "Poison ivy, leaves of three"
    },
    {
      "id": "maple",
      "text": "Young maple sapling"
    },
    {
      "id": "clover",
      "text": "Clover"
    },
    {
      "id": "fern",
      "text": "A fern"
    }
  ],
  "correctOptionId": "ivy",
  "explanation": {
    "correct": "Three leaflets, the middle on a longer stem, on a vine or low plant: poison ivy. Its oil causes an itchy rash.",
    "incorrect": "Poison ivy varies but the three leaflets are the giveaway. If touched, rinse skin soon and wash clothes.",
    "sayThisLine": "\"Leaves of three, let it be.\""
  },
  "cues": [
    "Three leaflets per leaf",
    "Middle leaflet on a longer stalk",
    "Glossy or notched edges"
  ]
}
```

### `hk-vi-04` (tn-01 / krummholz)

```json
{
  "prompt": "What is happening to these trees?",
  "image": {
    "asset": "hiking/img/krummholz-treeline.webp",
    "alt": "Low, twisted evergreens pressed flat and swept in one direction on an exposed alpine slope.",
    "license": "swoond-original-illustration"
  },
  "options": [
    {
      "id": "krummholz",
      "text": "Krummholz shaped by wind at treeline"
    },
    {
      "id": "logged",
      "text": "They were logged"
    },
    {
      "id": "young",
      "text": "They are just young trees"
    },
    {
      "id": "dead",
      "text": "They are dead from drought"
    }
  ],
  "correctOptionId": "krummholz",
  "explanation": {
    "correct": "Wind, ice and short seasons stunt and twist trees near treeline. The name is German for crooked wood.",
    "incorrect": "Harsh alpine conditions shape trees. They may be centuries old despite their small size.",
    "sayThisLine": "\"Those twisted trees are krummholz, wind-carved.\""
  },
  "cues": [
    "Low and shrubby",
    "Flagged in one direction",
    "Occurs at the edge of treeline"
  ]
}
```

## 8. Fill the gap (`fill-the-gap`) samples

### `hk-fg-01` (tb-03 / switchback)

```json
{
  "prompt": "Complete the sentence.",
  "template": "A {{term}} is a hairpin turn that lets a trail climb a steep slope at a {{grade}} grade.",
  "gaps": [
    {
      "id": "term",
      "options": [
        "switchback",
        "junction",
        "spur"
      ],
      "correct": "switchback"
    },
    {
      "id": "grade",
      "options": [
        "gentler",
        "steeper"
      ],
      "correct": "gentler"
    }
  ],
  "explanation": {
    "correct": "Switchbacks trade distance for grade, which spares your legs and the hillside.",
    "incorrect": "A junction is where trails meet. Switchbacks zigzag so the slope feels gentler and erodes less.",
    "sayThisLine": "\"Forty switchbacks, but at least it's not a wall.\""
  }
}
```

### `hk-fg-02` (jd-01 / trip-plan)

```json
{
  "prompt": "Complete the trip plan.",
  "template": "Leave your route and {{time}} with a {{who}}, and set a call-out time.",
  "gaps": [
    {
      "id": "time",
      "options": [
        "return time",
        "favorite song"
      ],
      "correct": "return time"
    },
    {
      "id": "who",
      "options": [
        "trusted contact",
        "stranger"
      ],
      "correct": "trusted contact"
    }
  ],
  "explanation": {
    "correct": "A trip plan is only useful if someone knows when to worry and whom to call.",
    "incorrect": "A route without a return time does not tell anyone when to act.",
    "sayThisLine": "\"I texted my sister the route and I'm back by six.\""
  }
}
```

### `hk-fg-03` (nv-08 / handrail)

```json
{
  "prompt": "Finish the navigation idea.",
  "template": "A {{a}} is a feature you follow, and a {{b}} tells you that you have gone too far.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "handrail",
        "cairn",
        "blaze"
      ],
      "correct": "handrail"
    },
    {
      "id": "b",
      "options": [
        "catching feature",
        "summit"
      ],
      "correct": "catching feature"
    }
  ],
  "explanation": {
    "correct": "Handrails keep you oriented; catching features stop overshoots.",
    "incorrect": "A stream to follow is a handrail. A road across your route is the catching feature that tells you to turn back.",
    "sayThisLine": "\"I followed the creek down, with the road as my backstop.\""
  }
}
```

### `hk-fg-04` (wx-03 / alpine-start)

```json
{
  "prompt": "Fill in the mountain weather rule.",
  "template": "Mountain storms tend to build in the {{time}}, so hikers start {{when}}.",
  "gaps": [
    {
      "id": "time",
      "options": [
        "afternoon",
        "morning"
      ],
      "correct": "afternoon"
    },
    {
      "id": "when",
      "options": [
        "early",
        "late"
      ],
      "correct": "early"
    }
  ],
  "explanation": {
    "correct": "Heating builds clouds after midday, so an early start puts you off exposed terrain before storms.",
    "incorrect": "Storms rarely build at dawn. An early start keeps you ahead of them.",
    "sayThisLine": "\"We start at five to beat the afternoon storms.\""
  }
}
```

## 9. Estimate slider (`estimate-slider`) samples

### `hk-es-01` (rt-03 / naismiths-rule)

```json
{
  "prompt": "6 miles, 2,000 ft of climbing. How many hours?",
  "unit": "hours",
  "min": 1,
  "max": 8,
  "step": 0.5,
  "correctValue": 3,
  "tolerance": {
    "full": 0.5,
    "partial": 1
  },
  "explanation": {
    "correct": "Naismith: 1 hour per 3 miles plus 1 hour per 2,000 ft of climbing gives 2 + 1 = 3 hours of moving time.",
    "incorrect": "Distance alone gives 2 hours, but the climb adds another. Breaks and photos add more.",
    "sayThisLine": "\"That's about three hours moving, plus lunch.\""
  }
}
```

### `hk-es-02` (wx-01 / lapse-rate)

```json
{
  "prompt": "70 F at 5,000 ft. Summit is at 9,000 ft. Temperature?",
  "unit": "F",
  "min": 30,
  "max": 80,
  "step": 1,
  "correctValue": 56,
  "tolerance": {
    "full": 3,
    "partial": 7
  },
  "explanation": {
    "correct": "Air cools roughly 3.5 F per 1,000 ft. Four thousand feet is about 14 degrees colder, so roughly 56 F before wind.",
    "incorrect": "The drop is steady with elevation. Pack a layer, since the summit will feel colder with wind.",
    "sayThisLine": "\"It's seventy here, but the top will be mid fifties before wind.\""
  }
}
```

### `hk-es-03` (wf-01 / hydration-rate)

```json
{
  "prompt": "Water for four hours of moderate hiking?",
  "unit": "liters",
  "min": 0,
  "max": 6,
  "step": 0.5,
  "correctValue": 2,
  "tolerance": {
    "full": 0.5,
    "partial": 1
  },
  "explanation": {
    "correct": "About half a liter per hour is the classic starting point, so roughly 2 liters.",
    "incorrect": "Needs vary with heat and effort, but half a liter per hour is a sturdy baseline.",
    "sayThisLine": "\"About half a liter an hour, so two liters for this one.\""
  }
}
```

### `hk-es-04` (rt-02 / grade)

```json
{
  "prompt": "A trail climbs 300 ft in one mile. What grade?",
  "unit": "percent",
  "min": 0,
  "max": 20,
  "step": 0.5,
  "correctValue": 5.5,
  "tolerance": {
    "full": 1,
    "partial": 3
  },
  "explanation": {
    "correct": "300 ft over 5,280 ft is about 5.7 percent: a mellow climb you can keep up for hours.",
    "incorrect": "Grade is rise over run. A mile is 5,280 ft, so 300 ft is only a gentle slope.",
    "sayThisLine": "\"That's about a six percent grade, easy going.\""
  }
}
```

### `hk-es-05` (tc-02 / long trails)

```json
{
  "prompt": "How long is the Appalachian Trail in miles?",
  "unit": "miles",
  "min": 500,
  "max": 4000,
  "step": 100,
  "correctValue": 2200,
  "tolerance": {
    "full": 200,
    "partial": 500
  },
  "explanation": {
    "correct": "The AT runs Georgia to Maine, about 2,200 miles, and most thru-hikers take five to seven months.",
    "incorrect": "It is long, but shorter than the CDT at roughly 3,000 miles and the PCT at about 2,650.",
    "sayThisLine": "\"It's about twenty-two hundred miles, Georgia to Maine.\""
  }
}
```

## 10. Hotspot tap (`hotspot-tap`) samples

### `hk-ht-01` (nv-04 / saddle)

```json
{
  "prompt": "Tap the saddle between the two peaks.",
  "diagram": {
    "diagramId": "topo.two-peaks-saddle",
    "aspectRatio": 1,
    "alt": "Topographic map with two closed contour rings, a peak on the left and one on the right, and an hourglass of contour lines between them."
  },
  "hotspots": [
    {
      "id": "peak-left",
      "label": "Left peak",
      "shape": {
        "kind": "circle",
        "cx": 0.22,
        "cy": 0.3,
        "r": 0.12
      }
    },
    {
      "id": "peak-right",
      "label": "Right peak",
      "shape": {
        "kind": "circle",
        "cx": 0.78,
        "cy": 0.3,
        "r": 0.12
      }
    },
    {
      "id": "saddle",
      "label": "The hourglass between the peaks",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.35,
        "r": 0.11
      }
    },
    {
      "id": "valley",
      "label": "Lower valley",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.8,
        "r": 0.12
      }
    }
  ],
  "correctHotspotIds": [
    "saddle"
  ],
  "explanation": {
    "correct": "A saddle is the low point on a ridge between two high points, shown as an hourglass in the contours.",
    "incorrect": "The peaks are closed rings. The saddle is the pinched waist between them, the natural pass.",
    "sayThisLine": "\"The trail crosses at the saddle, that's the easy way over.\""
  }
}
```

### `hk-ht-02` (nv-02 / contour-line)

```json
{
  "prompt": "Tap the steepest section of the slope.",
  "diagram": {
    "diagramId": "topo.slope-spacing",
    "aspectRatio": 1,
    "alt": "Contour map of a hill with widely spaced lines on the west side, tightly packed lines on the east side, and moderately spaced lines to the north."
  },
  "hotspots": [
    {
      "id": "west",
      "label": "West slope, wide gaps",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.3,
        "w": 0.25,
        "h": 0.4
      }
    },
    {
      "id": "north",
      "label": "North slope, medium gaps",
      "shape": {
        "kind": "rect",
        "x": 0.35,
        "y": 0.05,
        "w": 0.3,
        "h": 0.25
      }
    },
    {
      "id": "east",
      "label": "East slope, tight lines",
      "shape": {
        "kind": "rect",
        "x": 0.7,
        "y": 0.3,
        "w": 0.25,
        "h": 0.4
      }
    },
    {
      "id": "summit",
      "label": "Summit ring",
      "shape": {
        "kind": "rect",
        "x": 0.4,
        "y": 0.4,
        "w": 0.2,
        "h": 0.2
      }
    }
  ],
  "correctHotspotIds": [
    "east"
  ],
  "explanation": {
    "correct": "Tight contours mean lots of elevation in a short horizontal distance: the steep side.",
    "incorrect": "Wide gaps are gentle. The east side is a wall of close lines.",
    "sayThisLine": "\"The east side is steep, look at those close contours.\""
  }
}
```

### `hk-ht-03` (nv-04 / drainage)

```json
{
  "prompt": "Where would a stream run on this map?",
  "diagram": {
    "diagramId": "topo.v-drainage",
    "aspectRatio": 1,
    "alt": "Contour lines forming V shapes that point uphill along a central valley, with rounded bulges on either side."
  },
  "hotspots": [
    {
      "id": "valley",
      "label": "The V pointing uphill",
      "shape": {
        "kind": "rect",
        "x": 0.4,
        "y": 0.3,
        "w": 0.2,
        "h": 0.5
      }
    },
    {
      "id": "ridge-left",
      "label": "Rounded ridge on the left",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.3,
        "w": 0.25,
        "h": 0.5
      }
    },
    {
      "id": "ridge-right",
      "label": "Rounded ridge on the right",
      "shape": {
        "kind": "rect",
        "x": 0.7,
        "y": 0.3,
        "w": 0.25,
        "h": 0.5
      }
    }
  ],
  "correctHotspotIds": [
    "valley"
  ],
  "explanation": {
    "correct": "Contours V upstream around a drainage. Water flows down the V.",
    "incorrect": "Ridges bulge downhill. Valleys and streams form V shapes pointing up-slope.",
    "sayThisLine": "\"That V points uphill, so it's a drainage.\""
  }
}
```

### `hk-ht-04` (rt-06 / exposure)

```json
{
  "prompt": "Tap the most exposed part of the route.",
  "diagram": {
    "diagramId": "diagram.route.profile-exposure",
    "aspectRatio": 1.6,
    "alt": "Side view of a trail: forested switchbacks, then a narrow ledge with a steep drop on one side, then a broad meadow."
  },
  "hotspots": [
    {
      "id": "forest",
      "label": "Forested switchbacks",
      "shape": {
        "kind": "rect",
        "x": 0.02,
        "y": 0.4,
        "w": 0.3,
        "h": 0.4
      }
    },
    {
      "id": "ledge",
      "label": "Narrow ledge with a drop",
      "shape": {
        "kind": "rect",
        "x": 0.36,
        "y": 0.3,
        "w": 0.28,
        "h": 0.4
      }
    },
    {
      "id": "meadow",
      "label": "Broad meadow",
      "shape": {
        "kind": "rect",
        "x": 0.68,
        "y": 0.4,
        "w": 0.3,
        "h": 0.4
      }
    }
  ],
  "correctHotspotIds": [
    "ledge"
  ],
  "explanation": {
    "correct": "Exposure is a steep drop beside you. The ledge is where a slip would matter most.",
    "incorrect": "Forest and meadow have room to fall safely. The narrow ledge does not.",
    "sayThisLine": "\"The ledge had real exposure, so I took it slow.\""
  }
}
```

## 11. Say this (`say-this`) samples

### `hk-sy-01` (tb-08 / switchback)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Fifteen switchbacks, then the ridge. My quads are still mad."
  },
  "options": [
    {
      "id": "climb",
      "text": "A steep climb with many hairpin turns",
      "isCorrect": true
    },
    {
      "id": "ridge",
      "text": "A long flat crest to walk",
      "isCorrect": true
    },
    {
      "id": "weather",
      "text": "A weather problem",
      "isCorrect": false
    },
    {
      "id": "gear",
      "text": "A gear complaint",
      "isCorrect": false
    }
  ],
  "translation": "She climbed a steep slope via zigzags, reached a ridge and is tired but happy.",
  "followUps": [
    {
      "line": "How was the ridge, worth it?",
      "why": "Shows you heard the payoff, not just the pain."
    },
    {
      "line": "Did you use poles?",
      "why": "A natural gear follow-up."
    }
  ],
  "noFakeExpertNote": "Ask what a switchback is if you are unsure. Curiosity beats bluffing."
}
```

### `hk-sy-02` (rt-03 / elevation-gain)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "It was only six miles, but almost 2,500 feet of gain."
  },
  "options": [
    {
      "id": "hard",
      "text": "It was harder than six miles sounds",
      "isCorrect": true
    },
    {
      "id": "easy",
      "text": "It was easy and flat",
      "isCorrect": false
    },
    {
      "id": "slow",
      "text": "It probably took longer than an average 6 miles",
      "isCorrect": true
    },
    {
      "id": "far",
      "text": "It was very far",
      "isCorrect": false
    }
  ],
  "translation": "Distance was short but the climbing made it hard and slow.",
  "followUps": [
    {
      "line": "So what was the pace, about a mile and a half an hour?",
      "why": "Ties gain to pace."
    },
    {
      "line": "Did the views make up for it?",
      "why": "Invites the emotional payoff."
    }
  ],
  "noFakeExpertNote": "If you do not know Naismith's rule, just ask how long it took."
}
```

### `hk-sy-03` (nv-06 / declination)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "My compass was off until I set the declination."
  },
  "options": [
    {
      "id": "adjust",
      "text": "She corrected the compass for magnetic vs true north",
      "isCorrect": true
    },
    {
      "id": "broken",
      "text": "Her compass was broken",
      "isCorrect": false
    },
    {
      "id": "battery",
      "text": "Her phone battery died",
      "isCorrect": false
    },
    {
      "id": "map",
      "text": "She lost the map",
      "isCorrect": false
    }
  ],
  "translation": "She adjusted for the angle between magnetic and true north so bearings match the map.",
  "followUps": [
    {
      "line": "What was the declination there?",
      "why": "A specific, genuine question."
    },
    {
      "line": "Do you use a phone or a compass?",
      "why": "Invites a gear chat."
    }
  ],
  "noFakeExpertNote": "You do not need the number, just the idea that maps and compasses disagree."
}
```

### `hk-sy-04` (gn-03 / trail-runners)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "I'm a trail-runner convert. Boots feel like ankle prisons."
  },
  "options": [
    {
      "id": "shoe",
      "text": "She prefers light trail shoes to heavy boots",
      "isCorrect": true
    },
    {
      "id": "run",
      "text": "She only runs, never hikes",
      "isCorrect": false
    },
    {
      "id": "injury",
      "text": "She hurt her ankle",
      "isCorrect": false
    },
    {
      "id": "gear",
      "text": "She thinks boots are outdated for everyone",
      "isCorrect": false,
      "explanation": "That is her preference, not a universal claim."
    }
  ],
  "translation": "She favors lightweight trail runners over boots, a common debate.",
  "followUps": [
    {
      "line": "Do you find your feet get wet a lot?",
      "why": "Touches the wet-foot trade-off."
    },
    {
      "line": "What made you switch?",
      "why": "Invites her story."
    }
  ],
  "noFakeExpertNote": "Do not pick a side to please her. Ask why she switched."
}
```

### `hk-sy-05` (tc-04 / trail-magic)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "There was trail magic at the road crossing! Cold sodas!"
  },
  "options": [
    {
      "id": "kind",
      "text": "Strangers left free food or drink for hikers",
      "isCorrect": true
    },
    {
      "id": "mag",
      "text": "A magic show",
      "isCorrect": false
    },
    {
      "id": "store",
      "text": "A store on the trail",
      "isCorrect": false
    },
    {
      "id": "rain",
      "text": "Rain arrived",
      "isCorrect": false
    }
  ],
  "translation": "Trail angels left drinks for hikers at a crossing, a beloved tradition.",
  "followUps": [
    {
      "line": "That's the best. Who left them?",
      "why": "Shows warmth."
    },
    {
      "line": "What was your first sip like after miles?",
      "why": "Invites a sensory story."
    }
  ]
}
```

### `hk-sy-06` (wx-08 / red-flag)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "There's a red flag warning so we're staying home this weekend."
  },
  "options": [
    {
      "id": "fire",
      "text": "Dry, windy conditions could spread wildfire fast",
      "isCorrect": true
    },
    {
      "id": "cold",
      "text": "It is freezing",
      "isCorrect": false
    },
    {
      "id": "permit",
      "text": "Permits ran out",
      "isCorrect": false
    },
    {
      "id": "flood",
      "text": "There might be a flood",
      "isCorrect": false
    }
  ],
  "translation": "A fire-weather alert means high wildfire risk, and she is choosing not to go.",
  "followUps": [
    {
      "line": "Smart. Are you rebooking for next weekend?",
      "why": "Supportive and forward-looking."
    },
    {
      "line": "Is the trail closed too?",
      "why": "A good curious question."
    }
  ]
}
```

## 12. Decision scenarios (`decision-scenario`), 13 fully written

Fact sheets are written to be read fast; verdicts mix best, acceptable and poor so the learner weighs, not guesses. Each has `expertNote` and `safetyNote`. Scenario 1 is the product spec section 17 sunset example, worked through.

### `hk-ds-01` (jd-03 / daylight-math (spec section 17 scenario))

```json
{
  "prompt": "4:51 PM. Storm clouds building. What do you do?",
  "situation": {
    "narrative": "You are on a loop hike. The planned route finishes over an exposed ridge. A known lower trail cuts back to the car.",
    "facts": [
      {
        "label": "Time now",
        "value": "4:51 PM"
      },
      {
        "label": "Sunset",
        "value": "6:42 PM"
      },
      {
        "label": "Planned route left",
        "value": "4.7 mi, 1,200 ft climb"
      },
      {
        "label": "Lower cutoff to car",
        "value": "2.4 mi, mostly downhill"
      },
      {
        "label": "Weather",
        "value": "Deteriorating, wind rising",
        "emphasis": "warning"
      },
      {
        "label": "Headlamp",
        "value": "In pack, charged"
      }
    ]
  },
  "options": [
    {
      "id": "continue",
      "label": "Continue the planned route over the ridge",
      "verdict": "poor",
      "consequence": "At 2 mph plus climbing time, you finish around 7:50 PM, after sunset, with wind and possible rain exposed on the ridge.",
      "considerations": [
        "Naismith adds about 36 minutes for 1,200 ft",
        "Ridge is the worst place to be if storms arrive",
        "No margin left for a mistake"
      ]
    },
    {
      "id": "cutoff",
      "label": "Take the lower cutoff to the car",
      "verdict": "best",
      "consequence": "About 75 minutes puts you at the car near 6:05 PM, off the ridge and before sunset. You lose the loop, not the day.",
      "considerations": [
        "Known escape with time to spare",
        "Removes exposure before the weather turns",
        "A shorter day is a good day"
      ]
    },
    {
      "id": "retrace",
      "label": "Turn around and retrace the route in",
      "verdict": "acceptable",
      "consequence": "Safe if familiar, but longer than the cutoff. You would arrive close to sunset, wet and tired.",
      "considerations": [
        "Known trail is reassuring",
        "Slower than the cutoff by nearly an hour",
        "Still better than the ridge"
      ]
    }
  ],
  "expertNote": "Experienced hikers work backward from sunset with real pace, then subtract margin. When conditions worsen and the plan is longer than your daylight, the answer is the shortest exit, not the finish line.",
  "sayThisLine": "\"We had sunset at 6:42, so I took the cutoff. Better a short hike than a long night.\"",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-02` (wx-04 / lightning-safety)

```json
{
  "prompt": "Thunder near the summit. What do you do?",
  "situation": {
    "narrative": "You are 0.6 miles below a bare summit on a warm afternoon. A gray wall of cloud is building to the west.",
    "facts": [
      {
        "label": "Time",
        "value": "1:40 PM"
      },
      {
        "label": "Terrain",
        "value": "Above treeline, no shelter",
        "emphasis": "warning"
      },
      {
        "label": "Thunder",
        "value": "One rumble, about 10 seconds after a flash",
        "emphasis": "warning"
      },
      {
        "label": "To summit",
        "value": "0.6 mi, 20 minutes"
      },
      {
        "label": "To trees below",
        "value": "0.8 mi, downhill"
      },
      {
        "label": "Group",
        "value": "Three hikers"
      }
    ]
  },
  "options": [
    {
      "id": "summit",
      "label": "Sprint to the summit before the storm hits",
      "verdict": "poor",
      "consequence": "You reach the highest, most exposed point just as the storm arrives. Lightning risk peaks there.",
      "considerations": [
        "Summits and ridges attract strikes",
        "Flash-to-bang of 10 seconds is about two miles",
        "Storms often move faster than they look"
      ]
    },
    {
      "id": "descend",
      "label": "Turn around and descend toward the trees now",
      "verdict": "best",
      "consequence": "You lose elevation and exposure quickly. Spread out a bit on the way and wait for the storm to pass.",
      "considerations": [
        "Get off high ground first",
        "Avoid lone trees and open flat ridges",
        "Wait about 30 minutes after last thunder"
      ]
    },
    {
      "id": "wait",
      "label": "Stay put and wait it out where you are",
      "verdict": "poor",
      "consequence": "You sit exposed at treeline with lightning nearby, hoping for the best.",
      "considerations": [
        "Waiting on an exposed slope is riskier than moving",
        "Movement toward lower ground is the priority",
        "Decide before it is on top of you"
      ]
    }
  ],
  "expertNote": "Lightning is a timing problem. The right call is made at the first thunder, not when it is overhead. Descend early, spread out, and do not shelter under isolated tall trees.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-03` (jd-06 / river-crossing)

```json
{
  "prompt": "The creek is loud and brown. Cross or not?",
  "situation": {
    "narrative": "The trail crosses a creek after two days of rain. Your car is 3 miles behind you.",
    "facts": [
      {
        "label": "Creek depth",
        "value": "Above the knee",
        "emphasis": "warning"
      },
      {
        "label": "Current",
        "value": "Fast, standing waves",
        "emphasis": "warning"
      },
      {
        "label": "Water color",
        "value": "Brown, carrying debris"
      },
      {
        "label": "Alternative",
        "value": "Wait for morning or turn back"
      },
      {
        "label": "Time",
        "value": "2:15 PM"
      },
      {
        "label": "Experience",
        "value": "Beginner group"
      }
    ]
  },
  "options": [
    {
      "id": "cross",
      "label": "Cross carefully, unclip your pack and go",
      "verdict": "poor",
      "consequence": "Knee-deep fast water can sweep you off your feet. Debris and cold water make it worse.",
      "considerations": [
        "Depth and speed both matter",
        "Rain-swollen creeks drop overnight",
        "A fall into current is hard to recover from"
      ]
    },
    {
      "id": "turn",
      "label": "Turn back to the last dry spot and try another day",
      "verdict": "best",
      "consequence": "You keep everyone dry and safe. Creeks often fall overnight, and the hike can be rescheduled.",
      "considerations": [
        "No summit justifies a swept crossing",
        "Snowmelt and rain streams peak and fall",
        "Crossing decisions are conservative by design"
      ]
    },
    {
      "id": "upstream",
      "label": "Scout upstream for a wider, slower crossing",
      "verdict": "acceptable",
      "consequence": "Sometimes there is a braided section, but scouting eats time and daylight. Only continue if you find clearly safe water.",
      "considerations": [
        "Wider is usually shallower and slower",
        "Set a time limit on searching",
        "Be ready to still turn back"
      ]
    }
  ],
  "expertNote": "Experienced hikers treat moving water with respect: if it is above the knee and fast, or you are unsure, do not cross. Streams fed by snowmelt are lowest in the morning.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-04` (wf-01 / water-source-reliability)

```json
{
  "prompt": "The spring is dry. What now?",
  "situation": {
    "narrative": "Your planned water source at mile 6 is a seasonal spring. It is dry.",
    "facts": [
      {
        "label": "Water left",
        "value": "1 liter"
      },
      {
        "label": "Distance to next source",
        "value": "4 miles, mostly uphill"
      },
      {
        "label": "Temperature",
        "value": "88 F",
        "emphasis": "warning"
      },
      {
        "label": "Distance back to car",
        "value": "6 miles"
      },
      {
        "label": "Time",
        "value": "1:00 PM"
      },
      {
        "label": "Group",
        "value": "Two hikers"
      }
    ]
  },
  "options": [
    {
      "id": "push",
      "label": "Push on to the next source and hope",
      "verdict": "poor",
      "consequence": "One liter for two people over 4 uphill miles in 88 degree heat is not enough, and the next source may be dry too.",
      "considerations": [
        "Heat multiplies water use",
        "Unverified sources can also be dry",
        "Two people share one liter"
      ]
    },
    {
      "id": "back",
      "label": "Turn back toward the car and drink sparingly",
      "verdict": "best",
      "consequence": "You are closer to certainty. With a liter for a 6-mile return in the heat, reduce effort, rest in shade and keep going steadily.",
      "considerations": [
        "Retreat while you still have reserves",
        "Move in shade and slow your pace",
        "Stop pushing for a summit"
      ]
    },
    {
      "id": "ask",
      "label": "Ask other hikers and check the map for another source",
      "verdict": "acceptable",
      "consequence": "Good addition, but it should not change the plan unless you learn something reliable.",
      "considerations": [
        "Trip reports can be old",
        "Conditions change weekly",
        "Confirm before committing"
      ]
    }
  ],
  "expertNote": "Experienced hikers verify seasonal water with recent reports and carry a margin. When a source fails, they lower demand and retreat rather than gamble.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-05` (nv-10 / stop-method)

```json
{
  "prompt": "The trail vanished at a snow patch. Now what?",
  "situation": {
    "narrative": "You crossed a snow patch and cannot find tread on the far side. You have not seen a blaze in 40 minutes.",
    "facts": [
      {
        "label": "Last confirmed blaze",
        "value": "40 minutes ago",
        "emphasis": "warning"
      },
      {
        "label": "Phone battery",
        "value": "38%"
      },
      {
        "label": "Offline map",
        "value": "Downloaded"
      },
      {
        "label": "Daylight left",
        "value": "3 hours"
      },
      {
        "label": "Weather",
        "value": "Clear"
      },
      {
        "label": "Group",
        "value": "Two hikers"
      }
    ]
  },
  "options": [
    {
      "id": "bushwhack",
      "label": "Bushwhack in the direction you think the trail goes",
      "verdict": "poor",
      "consequence": "You may travel farther from the trail, burning daylight and energy on a guess.",
      "considerations": [
        "Guessing compounds error",
        "Vegetation hides tread",
        "Every step makes backtracking longer"
      ]
    },
    {
      "id": "stop",
      "label": "Stop, check the map and GPS track, and backtrack to the last certain blaze",
      "verdict": "best",
      "consequence": "With GPS and an offline map you can see where you drifted. Returning to the last sure point re-establishes your position.",
      "considerations": [
        "STOP: Stop, Think, Observe, Plan",
        "Trust the map and terrain together",
        "Save phone battery"
      ]
    },
    {
      "id": "split",
      "label": "Split up to search for the trail",
      "verdict": "poor",
      "consequence": "Two lost hikers become two separated hikers, doubling the problem.",
      "considerations": [
        "Never split up when unsure",
        "Keep the group visible",
        "Use the map instead"
      ]
    }
  ],
  "expertNote": "When the trail disappears, experienced hikers pause, gather facts and return to what they know. They do not gamble with a guess.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-06` (wx-08 / air-quality-index)

```json
{
  "prompt": "Smoky morning. Do you still hike?",
  "situation": {
    "narrative": "Your planned 10-mile hike is downwind of a wildfire.",
    "facts": [
      {
        "label": "AQI at trailhead",
        "value": "165 (unhealthy)",
        "emphasis": "warning"
      },
      {
        "label": "Forecast AQI",
        "value": "Worse this afternoon",
        "emphasis": "warning"
      },
      {
        "label": "Route",
        "value": "10 miles, 2,500 ft gain"
      },
      {
        "label": "Group",
        "value": "Includes someone with asthma",
        "emphasis": "warning"
      },
      {
        "label": "Alternative",
        "value": "Lower, shorter trail nearby"
      },
      {
        "label": "Closure",
        "value": "None posted"
      }
    ]
  },
  "options": [
    {
      "id": "go",
      "label": "Do the full hike, smoke is just a smell",
      "verdict": "poor",
      "consequence": "Heavy exertion in unhealthy air raises exposure and can trigger asthma and lung irritation.",
      "considerations": [
        "Exertion increases how much smoke you breathe",
        "AQI 165 is unhealthy for everyone",
        "The forecast is getting worse"
      ]
    },
    {
      "id": "swap",
      "label": "Skip it and pick another day or a short indoor activity",
      "verdict": "best",
      "consequence": "The right call is to protect lungs. Look for a day with cleaner air or a very short easy walk.",
      "considerations": [
        "Someone with asthma needs extra caution",
        "Watch AirNow and the fire report",
        "Do not push through unhealthy air"
      ]
    },
    {
      "id": "short",
      "label": "Do a short, easy walk on the lower trail",
      "verdict": "acceptable",
      "consequence": "Less exertion reduces exposure, but air quality is still poor and it may not be pleasant.",
      "considerations": [
        "Keep it short and slow",
        "Bring an inhaler if needed",
        "Turn back if symptoms start"
      ]
    }
  ],
  "expertNote": "Experienced hikers treat AQI like weather. Above 150 they change the plan; above 200 they stay off exertion outdoors.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-07` (wf-07 / altitude-sickness)

```json
{
  "prompt": "Your partner has a pounding headache at 10,800 ft.",
  "situation": {
    "narrative": "You drove up from sea level yesterday and started a high pass hike today.",
    "facts": [
      {
        "label": "Elevation",
        "value": "10,800 ft"
      },
      {
        "label": "Symptoms",
        "value": "Headache, nausea",
        "emphasis": "warning"
      },
      {
        "label": "Slept at",
        "value": "8,000 ft last night"
      },
      {
        "label": "Distance to pass",
        "value": "1.2 mi, 600 ft up"
      },
      {
        "label": "Distance to car",
        "value": "4 mi downhill"
      },
      {
        "label": "Weather",
        "value": "Clear"
      }
    ]
  },
  "options": [
    {
      "id": "push",
      "label": "Push on to the pass, it is close",
      "verdict": "poor",
      "consequence": "Going higher while symptomatic can worsen altitude illness.",
      "considerations": [
        "Do not ascend with worsening symptoms",
        "Headache plus nausea is a warning",
        "The pass will still be there"
      ]
    },
    {
      "id": "rest",
      "label": "Rest, drink, and only continue if symptoms clear",
      "verdict": "acceptable",
      "consequence": "Mild symptoms sometimes settle, but if they persist or worsen, descend.",
      "considerations": [
        "Rest and hydrate",
        "Do not go higher if symptomatic",
        "Have a descent plan"
      ]
    },
    {
      "id": "descend",
      "label": "Descend to lower elevation",
      "verdict": "best",
      "consequence": "Descending is the most effective treatment. Symptoms typically improve quickly with lower elevation.",
      "considerations": [
        "Lower is the fix for altitude illness",
        "Do not leave them alone",
        "Seek medical care if worsening"
      ]
    }
  ],
  "expertNote": "Experienced hikers acclimatize, climb high and sleep low, and take symptoms seriously. If in doubt, go down.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-08` (jd-07 / wildlife-encounter)

```json
{
  "prompt": "A bear stands on the trail, 80 yards ahead.",
  "situation": {
    "narrative": "You are hiking in bear country. The bear has not noticed you.",
    "facts": [
      {
        "label": "Distance",
        "value": "About 80 yards"
      },
      {
        "label": "Bear behavior",
        "value": "Feeding, has not noticed you"
      },
      {
        "label": "Wind",
        "value": "Blowing toward you"
      },
      {
        "label": "Bear spray",
        "value": "On your hip belt"
      },
      {
        "label": "Trail",
        "value": "Narrow, forest"
      },
      {
        "label": "Group",
        "value": "Two hikers"
      }
    ]
  },
  "options": [
    {
      "id": "photo",
      "label": "Creep closer for a photo",
      "verdict": "poor",
      "consequence": "Approaching wildlife is dangerous and illegal in many parks. A surprised bear is a threat.",
      "considerations": [
        "Never approach for photos",
        "Distance is the main safety tool",
        "Give animals space"
      ]
    },
    {
      "id": "calm",
      "label": "Stop, speak calmly so it knows you are human, and back away or wait",
      "verdict": "best",
      "consequence": "Let the bear know where you are without startling it. Give it a wide berth and turn around if it does not move.",
      "considerations": [
        "Do not run",
        "Have bear spray accessible",
        "Follow local ranger guidance"
      ]
    },
    {
      "id": "run",
      "label": "Run away",
      "verdict": "poor",
      "consequence": "Running can trigger a chase response.",
      "considerations": [
        "Never run from a bear",
        "Back away slowly",
        "Make yourself known"
      ]
    }
  ],
  "expertNote": "Experienced hikers know local guidance varies by species and park, carry bear spray where recommended and never approach for photos.",
  "safetyNote": "Species and region matter. Learn local bear guidance from rangers before you go."
}
```

### `hk-ds-09` (wx-07 / flash-flood)

```json
{
  "prompt": "Blue sky. Slot canyon ahead. Enter?",
  "situation": {
    "narrative": "You are at the mouth of a narrow slot canyon in a dry wash. Clear overhead.",
    "facts": [
      {
        "label": "Sky overhead",
        "value": "Clear"
      },
      {
        "label": "Forecast",
        "value": "40% thunderstorms upstream",
        "emphasis": "warning"
      },
      {
        "label": "Canyon",
        "value": "Narrow, no quick exits",
        "emphasis": "warning"
      },
      {
        "label": "Route",
        "value": "2 miles inside"
      },
      {
        "label": "Flash Flood Watch",
        "value": "In effect",
        "emphasis": "warning"
      },
      {
        "label": "Group",
        "value": "Three hikers"
      }
    ]
  },
  "options": [
    {
      "id": "enter",
      "label": "Enter, it is sunny",
      "verdict": "poor",
      "consequence": "Rain miles upstream can send a wall of water through narrow canyons with no warning.",
      "considerations": [
        "Clear overhead does not mean safe",
        "Slots have no escape route",
        "A watch means conditions favor flooding"
      ]
    },
    {
      "id": "skip",
      "label": "Skip the slot today and choose another route",
      "verdict": "best",
      "consequence": "With a watch and storms upstream, this canyon is off the table. Pick a wide, elevated route.",
      "considerations": [
        "Flash flood watches are a hard no",
        "Reschedule for a stable forecast",
        "Look at the whole watershed"
      ]
    },
    {
      "id": "short",
      "label": "Enter only the first 100 yards",
      "verdict": "poor",
      "consequence": "Even short entries can trap you if a surge arrives.",
      "considerations": [
        "Short is not safe",
        "No escape within a slot",
        "Do not gamble"
      ]
    }
  ],
  "expertNote": "Experienced canyoneers check the watershed forecast and watches for the entire drainage, not just the sky overhead.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-10` (jd-03 / turnaround-time)

```json
{
  "prompt": "1:00 PM turnaround. It is 12:55. The top is close.",
  "situation": {
    "narrative": "You set a 1:00 PM turnaround this morning. Cumulus clouds are building.",
    "facts": [
      {
        "label": "Time",
        "value": "12:55 PM"
      },
      {
        "label": "Turnaround time",
        "value": "1:00 PM"
      },
      {
        "label": "To summit",
        "value": "25 minutes",
        "emphasis": "warning"
      },
      {
        "label": "Clouds",
        "value": "Building, tops darkening",
        "emphasis": "warning"
      },
      {
        "label": "Descent to trees",
        "value": "1 hour"
      },
      {
        "label": "Group",
        "value": "Two hikers"
      }
    ]
  },
  "options": [
    {
      "id": "summit",
      "label": "Go for the summit, you have come this far",
      "verdict": "poor",
      "consequence": "You extend exposure right when storms build, and the descent starts later than planned.",
      "considerations": [
        "Sunk cost is not a reason",
        "The summit will be there tomorrow",
        "Weather beats plans"
      ]
    },
    {
      "id": "turn",
      "label": "Turn around at 1:00 as planned",
      "verdict": "best",
      "consequence": "You honor the plan you made with a clear head, and beat the storm.",
      "considerations": [
        "Turnaround times exist to be kept",
        "Clouds are building",
        "Decisions made early are wiser"
      ]
    },
    {
      "id": "vote",
      "label": "Ask the group to vote",
      "verdict": "acceptable",
      "consequence": "Group input helps, but the pre-set time already reflects the group's best judgment.",
      "considerations": [
        "Consensus can drift toward risk",
        "A pre-set rule avoids in-the-moment bias",
        "Voice concerns before the day"
      ]
    }
  ],
  "expertNote": "Turnaround times are decided when you are calm. Experienced hikers honor them because summit fever makes in-the-moment judgment worse.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-11` (gc-03 / layering)

```json
{
  "prompt": "Cold drizzle at the trailhead. Your friend is in cotton.",
  "situation": {
    "narrative": "38 F, wind and drizzle at a 4-mile trailhead. Your friend wears jeans and a cotton hoodie.",
    "facts": [
      {
        "label": "Temperature",
        "value": "38 F"
      },
      {
        "label": "Conditions",
        "value": "Drizzle, gusty",
        "emphasis": "warning"
      },
      {
        "label": "Friend's clothes",
        "value": "Cotton hoodie and jeans",
        "emphasis": "warning"
      },
      {
        "label": "Spare layers",
        "value": "One fleece, one rain shell"
      },
      {
        "label": "Hike",
        "value": "4 miles, mostly exposed"
      },
      {
        "label": "Car",
        "value": "At the trailhead"
      }
    ]
  },
  "options": [
    {
      "id": "go",
      "label": "Go anyway, they'll warm up while walking",
      "verdict": "poor",
      "consequence": "Cotton soaks and chills, especially when you stop. A wet, cold hiker is at risk of hypothermia.",
      "considerations": [
        "Cotton loses insulation when wet",
        "Wind accelerates heat loss",
        "Trailhead is a cheap place to fix the plan"
      ]
    },
    {
      "id": "swap",
      "label": "Lend layers and shorten or delay the hike",
      "verdict": "best",
      "consequence": "Lend the fleece and shell, shorten the route, or wait for better weather. Cotton under a shell may still be a problem.",
      "considerations": [
        "Fix clothing before the trail",
        "Shorter loops are still hikes",
        "Weather may improve"
      ]
    },
    {
      "id": "cancel",
      "label": "Cancel and go for coffee",
      "verdict": "acceptable",
      "consequence": "Safe and sane. It is always fine to pick another day.",
      "considerations": [
        "No shame in rescheduling",
        "Bad-weather days are for prep",
        "Learn from it"
      ]
    }
  ],
  "expertNote": "Experienced hikers check clothing at the car. It takes two minutes to fix at the trailhead and hours to fix on the trail.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-12` (ah-03 / snowpack)

```json
{
  "prompt": "Steep snow across the trail. No traction. Proceed?",
  "situation": {
    "narrative": "Late-season snow covers a north-facing slope on your route. Below it is a long slide to rocks.",
    "facts": [
      {
        "label": "Snow slope",
        "value": "Steep, hard and icy in shade",
        "emphasis": "warning"
      },
      {
        "label": "Traction",
        "value": "None with you",
        "emphasis": "warning"
      },
      {
        "label": "Runout",
        "value": "Long slide to rocks",
        "emphasis": "warning"
      },
      {
        "label": "Time",
        "value": "10:30 AM"
      },
      {
        "label": "Ice axe / training",
        "value": "None"
      },
      {
        "label": "Alternative",
        "value": "Turn back or use a lower route"
      }
    ]
  },
  "options": [
    {
      "id": "cross",
      "label": "Cross carefully in your regular shoes",
      "verdict": "poor",
      "consequence": "On steep hard snow, a slip can become an uncontrolled slide.",
      "considerations": [
        "Runout matters as much as slope",
        "Regular shoes do not grip ice",
        "Consequences are severe"
      ]
    },
    {
      "id": "turn",
      "label": "Turn back or take the lower route",
      "verdict": "best",
      "consequence": "No view is worth a slide. Come back when the snow melts or with training and gear.",
      "considerations": [
        "Late snow lingers in shade",
        "Traction and skills are required",
        "Lower route keeps you safe"
      ]
    },
    {
      "id": "kick",
      "label": "Kick steps across the softest edge",
      "verdict": "poor",
      "consequence": "Even soft edges can change to ice; kicking steps is a skill taught in a class, not improvised.",
      "considerations": [
        "Skills need practice",
        "Do not improvise on slopes with bad runout",
        "Turn around"
      ]
    }
  ],
  "expertNote": "Experienced hikers know the consequences of a slip decide the choice. If a fall has a bad end, do not step onto the snow without skill and gear.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

### `hk-ds-13` (np-02 / permit-lottery)

```json
{
  "prompt": "You did not win the permit lottery. Now what?",
  "situation": {
    "narrative": "She won a permit for a famous hike and you did not. The trip is in two weeks.",
    "facts": [
      {
        "label": "Permit",
        "value": "One, for a single person"
      },
      {
        "label": "Trail",
        "value": "Limited daily quota"
      },
      {
        "label": "Alternatives",
        "value": "Nearby trails without quotas"
      },
      {
        "label": "Reserving",
        "value": "Walk-up spots are limited"
      },
      {
        "label": "Time",
        "value": "14 days out"
      },
      {
        "label": "Group",
        "value": "Two hikers"
      }
    ]
  },
  "options": [
    {
      "id": "sneak",
      "label": "Hike the trail without a permit",
      "verdict": "poor",
      "consequence": "Rules protect fragile places and you can be fined or removed. It also puts the trail's quota at risk.",
      "considerations": [
        "Permits limit impact",
        "Rangers do check",
        "Not worth the risk"
      ]
    },
    {
      "id": "alt",
      "label": "Pick an alternative trail and celebrate her win separately",
      "verdict": "best",
      "consequence": "Respect the rules, and find another beautiful hike together. Her win is a chance to hear about it later.",
      "considerations": [
        "Find a nearby non-quota trail",
        "Do not hijack her permit",
        "Enjoy the day"
      ]
    },
    {
      "id": "waitlist",
      "label": "Try for a walk-up permit or waitlist",
      "verdict": "acceptable",
      "consequence": "Sometimes possible, but plan an alternative in case it fails.",
      "considerations": [
        "Check the agency's rules",
        "Arrive early",
        "Have a backup"
      ]
    }
  ],
  "expertNote": "Experienced hikers see permit systems as part of the deal: they protect places from being loved to death. Always have a Plan B.",
  "safetyNote": "A learning aid, not safety training. Take a real course and follow local land-manager guidance."
}
```

## 13. Talk Track scenarios (`talk-track`), 9 drafted

Each scenario: an enthusiast line, what it means, and reply options graded **good / meh / cringe** with a coach note. Deltas: good +20 to +25, meh 0 to +5, cringe -10 to -20. The payloads below are the curriculum `talkTracks[].payload` drafts. The launch target is 24 tracks (`conversationScenarios.count`).

| # | Track | Enthusiast line | What it means | Good | Meh | Cringe |
|---|---|---|---|---|---|---|
| 1 | `hk-tt-01` Sunrise on the ridge | "Just got back from the ridge. Caught sunrise, so worth the 4 AM alarm." | She started before dawn to catch sunrise from a ridge. Her knees are complaining about the descent. | "4 AM start? That's real alpine-start dedication. How was the light?" | "Wow, that's early. Was it cold?" | "I could totally do that, I'm basically a mountaineer." |
| 2 | `hk-tt-02` Saturday plan | "Want to do the lake loop Saturday? About 7 miles, 1,500 ft of gain." | She is proposing a 7-mile, 1,500-foot hike with a turnaround time to avoid afternoon storms. | "Sounds great. I'm newer to this, so what pace should I expect? I'll bring snacks and layers." | "Sure, sounds fun!" | "Easy, that's nothing. I could do 15." |
| 3 | `hk-tt-03` Base weight brag | "My base weight is finally down to eleven pounds!" | She has cut her pack weight without food and water to 11 pounds; a common gear-nerd achievement. | "Eleven! What was the biggest swap, the pack, the shelter or the sleeping bag?" | "Nice! Is that light?" | "Mine's like 40 pounds and I don't care." |
| 4 | `hk-tt-04` Storm nerves | "The forecast says 50% storms after noon and I'm second-guessing Saturday." | She is worried about afternoon storms and is considering a change of plan. | "Good instinct. Could we start earlier or pick a lower trail?" | "It's only 50%, you'll be fine." | "Storms are overrated. Let's go." |
| 5 | `hk-tt-05` Trail name story | "On my section hike they called me Ziploc because everything was in bags." | On a long trail hikers get nicknames called trail names, often from funny incidents. | "Ha, love it. Did the name stick? Who gave it to you?" | "That's funny." | "Trail names are kind of cringe." |
| 6 | `hk-tt-06` Lost at a snow patch | "We lost the trail at a snow patch. Did STOP and backtracked to the last blaze." | She lost the trail at a snow patch, used STOP, and found the last blaze. | "Good call. Did the GPS track help you find it?" | "Scary!" | "You should have kept going. Trails always turn up." |
| 7 | `hk-tt-07` First hike nerves | "I'm nervous about pace. I don't want to hold you back." | She is nervous about pace and does not want to hold you up, or she is telling you the group moves at the slowest pace. | "We hike at whoever's pace is slowest. I'll bring snacks and plenty of margin." | "You'll be fine." | "Just try to keep up." |
| 8 | `hk-tt-08` Lottery loss | "I didn't win the permit lottery again." | She entered a permit lottery for a limited-quota hike and did not win. | "Ugh, sorry. Any great nearby trails without quotas? I'd love to plan one with you." | "Sorry to hear that." | "Just go without one. Who'll know?" |
| 9 | `hk-tt-09` The banana peel | "Someone left a banana peel at the overlook. Drives me nuts." | She is bothered by a banana peel left at an overlook; peels are trash that takes a long time to break down. | "Peels can last a long time out here. Did you pack it out?" | "It's biodegradable though, right?" | "It's just a banana peel." |

### `hk-tt-01` (tk-02 / alpine-start)

**Terms implied:** alpine start, descent, hiking poles. **What it means:** She started before dawn to catch sunrise from a ridge. Her knees are complaining about the descent.

**Coach notes:**

- Good (+20): "4 AM start? That's real alpine-start dedication. How was the light?" -> Names the idea, then asks about her experience.
- Meh (+5): "Wow, that's early. Was it cold?" -> Fine, but you skipped the interesting part.
- Cringe (-15): "I could totally do that, I'm basically a mountaineer." -> Do not fake a level of experience you do not have.
- Good (+20): "Did you have poles? I hear they take a lot of load off on descents." -> Shows you learned something and invites a next step.
- Meh (+5): "Ouch. Did you ice them after?" -> Caring but generic.
- Cringe (-15): "Just walk faster, it hurts less." -> Advice without knowledge is a friction point.

```json
{
  "title": "Sunrise on the ridge",
  "setting": "Texting after her early-morning hike",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Just got back from the ridge. Caught sunrise, so worth the 4 AM alarm.",
      "replies": [
        {
          "id": "early-good",
          "text": "4 AM start? That's real alpine-start dedication. How was the light?",
          "smoothDelta": 20,
          "theirResponse": "Right? The whole valley went pink. Most people never see it.",
          "coachNote": "Names the idea, then asks about her experience."
        },
        {
          "id": "early-meh",
          "text": "Wow, that's early. Was it cold?",
          "smoothDelta": 5,
          "theirResponse": "Freezing at first, then perfect once the sun came up.",
          "coachNote": "Fine, but you skipped the interesting part."
        },
        {
          "id": "early-cringe",
          "text": "I could totally do that, I'm basically a mountaineer.",
          "smoothDelta": -15,
          "theirResponse": "Ha, sure. Okay.",
          "coachNote": "Do not fake a level of experience you do not have."
        }
      ]
    },
    {
      "theirMessage": "Honestly the descent was rough on my knees though.",
      "replies": [
        {
          "id": "desc-good",
          "text": "Did you have poles? I hear they take a lot of load off on descents.",
          "smoothDelta": 20,
          "theirResponse": "Yes! Poles saved me on the way down. Want to try mine sometime?",
          "coachNote": "Shows you learned something and invites a next step."
        },
        {
          "id": "desc-meh",
          "text": "Ouch. Did you ice them after?",
          "smoothDelta": 5,
          "theirResponse": "Yep, a bag of frozen peas.",
          "coachNote": "Caring but generic."
        },
        {
          "id": "desc-cringe",
          "text": "Just walk faster, it hurts less.",
          "smoothDelta": -15,
          "theirResponse": "That is not how that works.",
          "coachNote": "Advice without knowledge is a friction point."
        }
      ]
    }
  ],
  "closingNote": "Asking about the moment beats claiming the skill."
}
```

### `hk-tt-02` (tk-01 / turnaround-time)

**Terms implied:** elevation gain, turnaround time, afternoon storms. **What it means:** She is proposing a 7-mile, 1,500-foot hike with a turnaround time to avoid afternoon storms.

**Coach notes:**

- Good (+20): "Sounds great. I'm newer to this, so what pace should I expect? I'll bring snacks and layers." -> Honesty about your level plus a preparedness signal.
- Meh (+5): "Sure, sounds fun!" -> Warm, but you did not learn what you are signing up for.
- Cringe (-15): "Easy, that's nothing. I could do 15." -> Overpromising is how people end up in trouble on trail.
- Good (+25): "Love a turnaround time. Should I check the forecast tonight?" -> You respect the plan and offer to help.
- Meh (+0): "Okay, 8 it is." -> Passive; add one useful question.
- Cringe (-20): "Turnaround? We'll see how we feel up there." -> Summit fever starts with 'we'll see how we feel'.

```json
{
  "title": "Saturday plan",
  "setting": "Planning a hike together",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Want to do the lake loop Saturday? About 7 miles, 1,500 ft of gain.",
      "replies": [
        {
          "id": "plan-good",
          "text": "Sounds great. I'm newer to this, so what pace should I expect? I'll bring snacks and layers.",
          "smoothDelta": 20,
          "theirResponse": "Perfect. We'll keep it easy. Bring water too.",
          "coachNote": "Honesty about your level plus a preparedness signal."
        },
        {
          "id": "plan-meh",
          "text": "Sure, sounds fun!",
          "smoothDelta": 5,
          "theirResponse": "Great, it's a date.",
          "coachNote": "Warm, but you did not learn what you are signing up for."
        },
        {
          "id": "plan-cringe",
          "text": "Easy, that's nothing. I could do 15.",
          "smoothDelta": -15,
          "theirResponse": "Ha, okay, we'll see on Saturday.",
          "coachNote": "Overpromising is how people end up in trouble on trail."
        }
      ]
    },
    {
      "theirMessage": "We should leave by 8 and set a 2 PM turnaround to beat the storms.",
      "replies": [
        {
          "id": "turn-good",
          "text": "Love a turnaround time. Should I check the forecast tonight?",
          "smoothDelta": 25,
          "theirResponse": "Yes please. I'll check too.",
          "coachNote": "You respect the plan and offer to help."
        },
        {
          "id": "turn-meh",
          "text": "Okay, 8 it is.",
          "smoothDelta": 0,
          "theirResponse": "Cool.",
          "coachNote": "Passive; add one useful question."
        },
        {
          "id": "turn-cringe",
          "text": "Turnaround? We'll see how we feel up there.",
          "smoothDelta": -20,
          "theirResponse": "I'd rather set it now, when we're calm.",
          "coachNote": "Summit fever starts with 'we'll see how we feel'."
        }
      ]
    }
  ],
  "closingNote": "Plans made when you're calm keep you safe when you're not."
}
```

### `hk-tt-03` (tk-03 / base-weight)

**Terms implied:** base weight, big three, ultralight. **What it means:** She has cut her pack weight without food and water to 11 pounds; a common gear-nerd achievement.

**Coach notes:**

- Good (+20): "Eleven! What was the biggest swap, the pack, the shelter or the sleeping bag?" -> Uses the big three idea as a genuine question.
- Meh (+5): "Nice! Is that light?" -> Honest, but you can do better.
- Cringe (-10): "Mine's like 40 pounds and I don't care." -> Dismissing what she cares about closes the topic.
- Good (+20): "Worth it for the miles? Or do you miss it?" -> Explores the trade-off she cares about.
- Meh (+0): "Comfort's overrated." -> Agreeing without asking why is empty.
- Cringe (-15): "So basically you are suffering on purpose." -> Mocking the hobby is not curiosity.

```json
{
  "title": "Base weight brag",
  "setting": "Gear chat over text",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "My base weight is finally down to eleven pounds!",
      "replies": [
        {
          "id": "bw-good",
          "text": "Eleven! What was the biggest swap, the pack, the shelter or the sleeping bag?",
          "smoothDelta": 20,
          "theirResponse": "The shelter. Went to a tarp. I'm in love.",
          "coachNote": "Uses the big three idea as a genuine question."
        },
        {
          "id": "bw-meh",
          "text": "Nice! Is that light?",
          "smoothDelta": 5,
          "theirResponse": "Very. Most people carry double that.",
          "coachNote": "Honest, but you can do better."
        },
        {
          "id": "bw-cringe",
          "text": "Mine's like 40 pounds and I don't care.",
          "smoothDelta": -10,
          "theirResponse": "Haha, well, your knees might.",
          "coachNote": "Dismissing what she cares about closes the topic."
        }
      ]
    },
    {
      "theirMessage": "It costs some comfort though. No camp chair.",
      "replies": [
        {
          "id": "cf-good",
          "text": "Worth it for the miles? Or do you miss it?",
          "smoothDelta": 20,
          "theirResponse": "Worth it. I sit on my pack.",
          "coachNote": "Explores the trade-off she cares about."
        },
        {
          "id": "cf-meh",
          "text": "Comfort's overrated.",
          "smoothDelta": 0,
          "theirResponse": "Ha, not always.",
          "coachNote": "Agreeing without asking why is empty."
        },
        {
          "id": "cf-cringe",
          "text": "So basically you are suffering on purpose.",
          "smoothDelta": -15,
          "theirResponse": "It's a choice, not suffering!",
          "coachNote": "Mocking the hobby is not curiosity."
        }
      ]
    }
  ],
  "closingNote": "Ask about trade-offs. Every gear choice is one."
}
```

### `hk-tt-04` (tk-04 / lightning-safety)

**Terms implied:** afternoon thunderstorms, weather window, lightning safety. **What it means:** She is worried about afternoon storms and is considering a change of plan.

**Coach notes:**

- Good (+25): "Good instinct. Could we start earlier or pick a lower trail?" -> Supports caution and proposes options.
- Meh (-5): "It's only 50%, you'll be fine." -> Reassurance without information.
- Cringe (-20): "Storms are overrated. Let's go." -> Never brush off a safety instinct.
- Good (+20): "Deal. I'll check the point forecast tonight and text you." -> You offer a concrete task.
- Meh (+0): "Sure." -> Fine, low energy.
- Cringe (-15): "Fine, but we're wimping out." -> Turning safety into shame.

```json
{
  "title": "Storm nerves",
  "setting": "She is second-guessing a trip",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "The forecast says 50% storms after noon and I'm second-guessing Saturday.",
      "replies": [
        {
          "id": "st-good",
          "text": "Good instinct. Could we start earlier or pick a lower trail?",
          "smoothDelta": 25,
          "theirResponse": "That's smart. A lower loop would do it.",
          "coachNote": "Supports caution and proposes options."
        },
        {
          "id": "st-meh",
          "text": "It's only 50%, you'll be fine.",
          "smoothDelta": -5,
          "theirResponse": "Hmm, that's a coin flip on a ridge.",
          "coachNote": "Reassurance without information."
        },
        {
          "id": "st-cringe",
          "text": "Storms are overrated. Let's go.",
          "smoothDelta": -20,
          "theirResponse": "Not funny. Lightning is not a joke.",
          "coachNote": "Never brush off a safety instinct."
        }
      ]
    },
    {
      "theirMessage": "Yeah, lower loop and we'd be off exposed ground by noon.",
      "replies": [
        {
          "id": "lo-good",
          "text": "Deal. I'll check the point forecast tonight and text you.",
          "smoothDelta": 20,
          "theirResponse": "Perfect. Thanks for taking it seriously.",
          "coachNote": "You offer a concrete task."
        },
        {
          "id": "lo-meh",
          "text": "Sure.",
          "smoothDelta": 0,
          "theirResponse": "Okay.",
          "coachNote": "Fine, low energy."
        },
        {
          "id": "lo-cringe",
          "text": "Fine, but we're wimping out.",
          "smoothDelta": -15,
          "theirResponse": "Wimping out? It's judgment.",
          "coachNote": "Turning safety into shame."
        }
      ]
    }
  ],
  "closingNote": "Caution is a skill. Support it."
}
```

### `hk-tt-05` (tk-05 / trail-name)

**Terms implied:** trail name, section hike, tramily. **What it means:** On a long trail hikers get nicknames called trail names, often from funny incidents.

**Coach notes:**

- Good (+20): "Ha, love it. Did the name stick? Who gave it to you?" -> Curious about the story and the community.
- Meh (+5): "That's funny." -> Nice, but short.
- Cringe (-15): "Trail names are kind of cringe." -> Do not mock what she loves.
- Good (+20): "I'd love to hear more trail stories sometime." -> Shows genuine interest.
- Meh (+0): "Cool." -> You can ask a follow-up.
- Cringe (-5): "Do I get a trail name if I come?" -> Fine as a joke, but ask about her story first.

```json
{
  "title": "Trail name story",
  "setting": "Hearing about her section hike",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "On my section hike they called me Ziploc because everything was in bags.",
      "replies": [
        {
          "id": "tn-good",
          "text": "Ha, love it. Did the name stick? Who gave it to you?",
          "smoothDelta": 20,
          "theirResponse": "My tramily did on day three. Never lost it.",
          "coachNote": "Curious about the story and the community."
        },
        {
          "id": "tn-meh",
          "text": "That's funny.",
          "smoothDelta": 5,
          "theirResponse": "Yeah, I guess.",
          "coachNote": "Nice, but short."
        },
        {
          "id": "tn-cringe",
          "text": "Trail names are kind of cringe.",
          "smoothDelta": -15,
          "theirResponse": "Wow. It's a tradition, actually.",
          "coachNote": "Do not mock what she loves."
        }
      ]
    },
    {
      "theirMessage": "It's silly but it stuck. I still answer to it.",
      "replies": [
        {
          "id": "st2-good",
          "text": "I'd love to hear more trail stories sometime.",
          "smoothDelta": 20,
          "theirResponse": "Stories for days, get ready.",
          "coachNote": "Shows genuine interest."
        },
        {
          "id": "st2-meh",
          "text": "Cool.",
          "smoothDelta": 0,
          "theirResponse": "Yep.",
          "coachNote": "You can ask a follow-up."
        },
        {
          "id": "st2-cringe",
          "text": "Do I get a trail name if I come?",
          "smoothDelta": -5,
          "theirResponse": "Ha, earn it first.",
          "coachNote": "Fine as a joke, but ask about her story first."
        }
      ]
    }
  ],
  "closingNote": "Listen for the story behind the word."
}
```

### `hk-tt-06` (tk-06 / stop-method)

**Terms implied:** STOP, blaze, GPS track. **What it means:** She lost the trail at a snow patch, used STOP, and found the last blaze.

**Coach notes:**

- Good (+20): "Good call. Did the GPS track help you find it?" -> You recognized the method.
- Meh (+5): "Scary!" -> True, but ask something.
- Cringe (-20): "You should have kept going. Trails always turn up." -> Never encourage guessing when lost.
- Good (+20): "Do you use an app or a GPS device?" -> A natural gear follow-up.
- Meh (+0): "Smart." -> Warm.
- Cringe (-10): "I just use my phone, it always works." -> Signal is not safety.

```json
{
  "title": "Lost at a snow patch",
  "setting": "Hearing about a mistake",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We lost the trail at a snow patch. Did STOP and backtracked to the last blaze.",
      "replies": [
        {
          "id": "lo-good",
          "text": "Good call. Did the GPS track help you find it?",
          "smoothDelta": 20,
          "theirResponse": "Totally. It showed we'd drifted about 200 feet.",
          "coachNote": "You recognized the method."
        },
        {
          "id": "lo-meh",
          "text": "Scary!",
          "smoothDelta": 5,
          "theirResponse": "A little, but we kept calm.",
          "coachNote": "True, but ask something."
        },
        {
          "id": "lo-cringe",
          "text": "You should have kept going. Trails always turn up.",
          "smoothDelta": -20,
          "theirResponse": "No. That's how people get lost.",
          "coachNote": "Never encourage guessing when lost."
        }
      ]
    },
    {
      "theirMessage": "It's why I always download offline maps.",
      "replies": [
        {
          "id": "of-good",
          "text": "Do you use an app or a GPS device?",
          "smoothDelta": 20,
          "theirResponse": "App plus a paper map backup.",
          "coachNote": "A natural gear follow-up."
        },
        {
          "id": "of-meh",
          "text": "Smart.",
          "smoothDelta": 0,
          "theirResponse": "Yes!",
          "coachNote": "Warm."
        },
        {
          "id": "of-cringe",
          "text": "I just use my phone, it always works.",
          "smoothDelta": -10,
          "theirResponse": "Not out there. No signal.",
          "coachNote": "Signal is not safety."
        }
      ]
    }
  ],
  "closingNote": "Naming the method shows you listened."
}
```

### `hk-tt-07` (tk-07 / group-pace)

**Terms implied:** group pace, margin of safety, first hike. **What it means:** She is nervous about pace and does not want to hold you up, or she is telling you the group moves at the slowest pace.

**Coach notes:**

- Good (+25): "We hike at whoever's pace is slowest. I'll bring snacks and plenty of margin." -> Warmth plus a real principle.
- Meh (+0): "You'll be fine." -> Reassurance without content.
- Cringe (-20): "Just try to keep up." -> Never pressure the pace.
- Good (+20): "Water, a snack, a layer and sunscreen. I'll bring the rest." -> Clear and helpful.
- Meh (+0): "Just bring yourself." -> Cute, but not useful.
- Cringe (-10): "Nothing, I've got everything." -> Do not take over her prep.

```json
{
  "title": "First hike nerves",
  "setting": "Before your first hike together",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I'm nervous about pace. I don't want to hold you back.",
      "replies": [
        {
          "id": "pc-good",
          "text": "We hike at whoever's pace is slowest. I'll bring snacks and plenty of margin.",
          "smoothDelta": 25,
          "theirResponse": "That means a lot. Thank you.",
          "coachNote": "Warmth plus a real principle."
        },
        {
          "id": "pc-meh",
          "text": "You'll be fine.",
          "smoothDelta": 0,
          "theirResponse": "Hopefully.",
          "coachNote": "Reassurance without content."
        },
        {
          "id": "pc-cringe",
          "text": "Just try to keep up.",
          "smoothDelta": -20,
          "theirResponse": "Wow. Okay.",
          "coachNote": "Never pressure the pace."
        }
      ]
    },
    {
      "theirMessage": "Okay. What should I bring?",
      "replies": [
        {
          "id": "br-good",
          "text": "Water, a snack, a layer and sunscreen. I'll bring the rest.",
          "smoothDelta": 20,
          "theirResponse": "Perfect. Sounds like a plan.",
          "coachNote": "Clear and helpful."
        },
        {
          "id": "br-meh",
          "text": "Just bring yourself.",
          "smoothDelta": 0,
          "theirResponse": "Haha, okay.",
          "coachNote": "Cute, but not useful."
        },
        {
          "id": "br-cringe",
          "text": "Nothing, I've got everything.",
          "smoothDelta": -10,
          "theirResponse": "I'd feel better bringing a layer.",
          "coachNote": "Do not take over her prep."
        }
      ]
    }
  ],
  "closingNote": "The slowest hiker sets the pace. Say so."
}
```

### `hk-tt-08` (np-06 / permit-lottery)

**Terms implied:** permit lottery, quota, wilderness permit. **What it means:** She entered a permit lottery for a limited-quota hike and did not win.

**Coach notes:**

- Good (+20): "Ugh, sorry. Any great nearby trails without quotas? I'd love to plan one with you." -> Supportive and constructive.
- Meh (+5): "Sorry to hear that." -> Kind but flat.
- Cringe (-20): "Just go without one. Who'll know?" -> Never encourage breaking permit rules.
- Good (+20): "That's the trade-off with popular places. Maybe try shoulder season." -> A thoughtful suggestion.
- Meh (+0): "That sucks." -> Empathy without an idea.
- Cringe (-10): "Popular trails are overrated anyway." -> Do not dismiss her dream trail.

```json
{
  "title": "Lottery loss",
  "setting": "She lost a permit draw",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I didn't win the permit lottery again.",
      "replies": [
        {
          "id": "pl-good",
          "text": "Ugh, sorry. Any great nearby trails without quotas? I'd love to plan one with you.",
          "smoothDelta": 20,
          "theirResponse": "Actually yes, there's a nice loop nearby.",
          "coachNote": "Supportive and constructive."
        },
        {
          "id": "pl-meh",
          "text": "Sorry to hear that.",
          "smoothDelta": 5,
          "theirResponse": "Thanks.",
          "coachNote": "Kind but flat."
        },
        {
          "id": "pl-cringe",
          "text": "Just go without one. Who'll know?",
          "smoothDelta": -20,
          "theirResponse": "Rangers will. And that's not okay.",
          "coachNote": "Never encourage breaking permit rules."
        }
      ]
    },
    {
      "theirMessage": "It's so competitive. Everyone wants the same trail.",
      "replies": [
        {
          "id": "co-good",
          "text": "That's the trade-off with popular places. Maybe try shoulder season.",
          "smoothDelta": 20,
          "theirResponse": "Good idea. Fewer crowds too.",
          "coachNote": "A thoughtful suggestion."
        },
        {
          "id": "co-meh",
          "text": "That sucks.",
          "smoothDelta": 0,
          "theirResponse": "Yeah.",
          "coachNote": "Empathy without an idea."
        },
        {
          "id": "co-cringe",
          "text": "Popular trails are overrated anyway.",
          "smoothDelta": -10,
          "theirResponse": "Not true, they're popular for a reason.",
          "coachNote": "Do not dismiss her dream trail."
        }
      ]
    }
  ],
  "closingNote": "Empathy first, then an alternative."
}
```

### `hk-tt-09` (tb-06 / leave-no-trace)

**Terms implied:** Leave No Trace, pack it out. **What it means:** She is bothered by a banana peel left at an overlook; peels are trash that takes a long time to break down.

**Coach notes:**

- Good (+20): "Peels can last a long time out here. Did you pack it out?" -> Shows you understand pack-it-out.
- Meh (-5): "It's biodegradable though, right?" -> A common misconception, asked honestly.
- Cringe (-15): "It's just a banana peel." -> Small things are the whole point of the ethic.
- Good (+20): "I'd like to learn it properly. What's the one you care most about?" -> You ask and you listen.
- Meh (+0): "That's cool." -> Give it more.
- Cringe (-15): "You must be fun at parties." -> Do not tease values.

```json
{
  "title": "The banana peel",
  "setting": "She notices trash at a viewpoint",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Someone left a banana peel at the overlook. Drives me nuts.",
      "replies": [
        {
          "id": "bp-good",
          "text": "Peels can last a long time out here. Did you pack it out?",
          "smoothDelta": 20,
          "theirResponse": "I did, in my trash bag. It's the principle.",
          "coachNote": "Shows you understand pack-it-out."
        },
        {
          "id": "bp-meh",
          "text": "It's biodegradable though, right?",
          "smoothDelta": -5,
          "theirResponse": "Technically, but it takes ages and animals eat it.",
          "coachNote": "A common misconception, asked honestly."
        },
        {
          "id": "bp-cringe",
          "text": "It's just a banana peel.",
          "smoothDelta": -15,
          "theirResponse": "That's exactly how trails get trashed.",
          "coachNote": "Small things are the whole point of the ethic."
        }
      ]
    },
    {
      "theirMessage": "Leave No Trace is basically my personality.",
      "replies": [
        {
          "id": "ln-good",
          "text": "I'd like to learn it properly. What's the one you care most about?",
          "smoothDelta": 20,
          "theirResponse": "Probably plan ahead. Everything else flows from it.",
          "coachNote": "You ask and you listen."
        },
        {
          "id": "ln-meh",
          "text": "That's cool.",
          "smoothDelta": 0,
          "theirResponse": "Thanks.",
          "coachNote": "Give it more."
        },
        {
          "id": "ln-cringe",
          "text": "You must be fun at parties.",
          "smoothDelta": -15,
          "theirResponse": "Hah. Okay.",
          "coachNote": "Do not tease values."
        }
      ]
    }
  ],
  "closingNote": "Care about what she cares about."
}
```

## 14. Playbook terms (148)

Each entry becomes a curriculum `concepts[]` item: `id`, `term`, `definition`, `exampleLine` (a line the hiker in her life might say, shown in serif italics). Concept ids are referenced by lessons in `CDS.md` section 11 and by the sim. Unit shown is where the concept is first taught.

| id | Term | Definition | Example line | First taught |
|---|---|---|---|---|
| `trailhead` | Trailhead | The place a trail starts, usually with a parking lot, a sign and often a map or register. | "Meet me at the trailhead by 6:30. The lot fills up by eight." | `trail-basics` |
| `out-and-back` | Out-and-back | A hike that goes to a destination and returns the same way you came. | "It's an out-and-back, so the way down is the same view in reverse." | `trail-basics` |
| `loop-hike` | Loop | A route that returns to the start without retracing your steps. | "We're doing the loop clockwise so the big climb is on fresh legs." | `trail-basics` |
| `lollipop-loop` | Lollipop | A route with a stem in and out and a loop at the far end. | "It's a lollipop: two miles up the stem, then the loop around the lake." | `trail-basics` |
| `point-to-point` | Point-to-point | A hike that ends somewhere different from where it starts, so you need a shuttle or a ride. | "It's point-to-point, so we're leaving a car at the far trailhead." | `trail-basics` |
| `junction` | Junction | A place where two or more trails meet; the most common spot to take a wrong turn. | "Careful at the junction. Everyone goes left there and it's wrong." | `trail-basics` |
| `switchback` | Switchback | A hairpin turn that lets a trail climb a steep slope at a gentle, sustainable grade. | "Forty switchbacks. I counted. Twice." | `trail-basics` |
| `blaze` | Blaze | A painted mark on a tree or rock that keeps you on the trail; a stacked pair often warns of a turn. | "I lost the trail for ten minutes until I spotted a white blaze." | `trail-basics` |
| `cairn` | Cairn | A small stack of rocks that marks the route where there is no tread, like bare rock or above treeline. | "Follow the cairns across the slab, and please don't build new ones." | `trail-basics` |
| `spur-trail` | Spur trail | A short side trail off the main route to a viewpoint, lake, water source or campsite. | "There's a spur to the overlook. Ten minutes, totally worth it." | `trail-basics` |
| `social-trail` | Social trail | An unofficial path worn by foot traffic, often shortcuts that cause erosion and confusion. | "That's a social trail. Stay on the real one, it's wrecking the meadow." | `trail-basics` |
| `trail-right-of-way` | Right of way | The etiquette of who yields: bikes yield to hikers and horses, hikers yield to horses, and downhill usually yields to uphill. | "I stepped off for the horses. You always yield to the horses." | `trail-basics` |
| `leave-no-trace` | Leave No Trace | Seven principles for minimizing your impact: plan ahead, durable surfaces, waste, leave what you find, campfires, wildlife, other visitors. | "I'm a Leave No Trace person. Pack it in, pack it out." | `trail-basics` |
| `durable-surface` | Durable surface | Ground that resists damage: maintained trail, rock, gravel, dry grass or snow. | "We rested on the slickrock, it's a durable surface, not the moss." | `trail-basics` |
| `pack-it-out` | Pack it out | Carry all trash, food scraps and toilet paper out with you, including peels and cores. | "Orange peels are trash too. Pack it out." | `trail-basics` |
| `trail-register` | Trail register | A sign-in book or box at a trailhead or pass that logs who went where and when. | "I signed the register. It's how rangers know we were up there." | `trail-basics` |
| `ten-essentials` | Ten Essentials | A checklist of ten systems (navigation, sun protection, insulation, light, first aid, fire, repair, food, water, shelter) that prepares you to handle an unplanned night out. | "Even for a four-mile hike I carry the ten essentials." | `gear-and-clothing` |
| `layering-system` | Layering | Wearing several thin layers you can add or remove instead of one thick one, so you can regulate sweat and warmth. | "I never wear one big jacket. Layers, so I can adjust." | `gear-and-clothing` |
| `base-layer` | Base layer | The thin wicking layer against your skin, usually synthetic or merino wool. | "Merino base layer. It doesn't smell after three days." | `gear-and-clothing` |
| `mid-layer` | Mid layer | The insulating layer, such as fleece or a puffy jacket, that holds in warmth. | "I threw on the puffy at the summit and it was heaven." | `gear-and-clothing` |
| `shell` | Shell | The outer wind and rain layer; it blocks weather but must vent or you sweat inside it. | "Shell's in the pack. The sky looks moody." | `gear-and-clothing` |
| `cotton-kills` | Cotton kills | The rule that cotton soaks up water, dries slowly and pulls heat from your body, so avoid it in cool or wet conditions. | "Jeans on a rainy hike? Cotton kills, my friend." | `gear-and-clothing` |
| `wicking` | Wicking | A fabric's ability to pull sweat off your skin to the outer surface so it can evaporate. | "These socks are wicking. My feet stay dry." | `gear-and-clothing` |
| `footwear-fit` | Footwear fit | Shoes that lock your heel, leave room for toes to splay and do not slide on descents; fit matters more than category. | "Wrong-size boots ruined my first hike. Fit is everything." | `gear-and-clothing` |
| `hot-spot` | Hot spot | A warm, tender patch where friction is starting; the moment to act before it becomes a blister. | "I felt a hot spot at mile three so I stopped and taped it." | `gear-and-clothing` |
| `blister-care` | Blister care | Prevention and treatment: tape hot spots early, keep feet dry, change socks, and cover open blisters properly. | "Tape it before it blisters. Tape early, tape often." | `gear-and-clothing` |
| `hiking-poles` | Trekking poles | Adjustable poles that reduce load on knees on descents and add balance on rough or wet ground. | "Poles saved my knees on the descent." | `gear-and-clothing` |
| `daypack` | Daypack | A 10 to 30 liter pack carrying the day's essentials, food, water and layers. | "Twenty-liter daypack, snacks on the hip belt." | `gear-and-clothing` |
| `headlamp` | Headlamp | A hands-free light carried on every hike, including day hikes, in case you finish after dark. | "I always throw a headlamp in, even if I'll be back by noon." | `gear-and-clothing` |
| `emergency-shelter` | Emergency shelter | Lightweight protection like a bivy or space blanket that lets you survive an unplanned night. | "There's an emergency bivy at the bottom of my pack, just in case." | `gear-and-clothing` |
| `sun-protection` | Sun protection | Sunscreen, sunglasses, hat and sun-covering clothing; UV rises with elevation and reflects off snow and water. | "Sunburn above treeline is no joke. Hat and SPF, always." | `gear-and-clothing` |
| `first-aid-kit` | First aid kit | Supplies for blisters, cuts, sprains and allergic reactions, matched to the trip length and your training. | "I carry a small first aid kit, tape and blister pads mostly." | `gear-and-clothing` |
| `fire-and-repair` | Fire and repair | A fire starter for emergencies plus a small kit (knife, tape, cord) to fix gear on the trail. | "Duct tape wrapped on my poles. It fixes everything." | `gear-and-clothing` |
| `hydration-rate` | Hydration rate | A rule of thumb of about half a liter per hour in moderate weather, more in heat or steep terrain. | "About half a liter an hour. More when it's hot." | `water-food-and-body` |
| `water-treatment` | Water treatment | Making backcountry water safe by filtering, chemical treatment, UV or boiling. | "I filter everything. Even the pretty streams." | `water-food-and-body` |
| `giardia` | Giardia | A microscopic parasite in natural water that causes severe stomach illness; filters and treatment stop it. | "Clear water still has giardia. I've seen the hospital bills." | `water-food-and-body` |
| `electrolytes` | Electrolytes | Salts you lose in sweat, sodium especially; replace them on long or hot hikes. | "I drop an electrolyte tab in one bottle every hot day." | `water-food-and-body` |
| `hyponatremia` | Hyponatremia | Dangerously low blood sodium from drinking lots of plain water without salt, causing confusion and nausea. | "Chugging plain water all day isn't safe. Salt matters." | `water-food-and-body` |
| `calories-per-hour` | Calories per hour | Hiking burns roughly 300 to 500 calories an hour; snacking a little every hour beats a big meal. | "Snack every hour, not just at lunch." | `water-food-and-body` |
| `bonking` | Bonking | Hitting the wall when your energy stores run out, producing weakness, irritability and slowness. | "I bonked at mile eight. Forgot to eat." | `water-food-and-body` |
| `trail-snacks` | Trail food | Calorie-dense food that survives a pack: nuts, bars, jerky, cheese, dried fruit, tortillas. | "Tortillas and peanut butter is the best trail lunch." | `water-food-and-body` |
| `altitude-sickness` | Altitude sickness | Headache, nausea and fatigue from going up faster than your body adapts, usually above about 8,000 feet. | "I had a headache at the pass. Altitude, I think." | `water-food-and-body` |
| `acclimatization` | Acclimatization | Letting your body adapt to elevation by ascending gradually and sleeping lower than your high point. | "We're spending a night at 8,000 feet to acclimatize first." | `water-food-and-body` |
| `heat-illness` | Heat illness | A spectrum from cramps to heat exhaustion to heatstroke, an emergency with confusion and hot dry skin. | "We started at dawn because the canyon is dangerous by noon." | `water-food-and-body` |
| `dehydration-signs` | Dehydration signs | Dark urine, headache, dizziness, dry mouth and unusual fatigue. | "My urine was dark, so I doubled my water." | `water-food-and-body` |
| `elevation-gain` | Elevation gain | The total climbing on a route, adding every uphill, not just the difference between start and top. | "Only six miles, but two thousand feet of gain." | `reading-a-trail` |
| `grade` | Grade | The steepness of a slope as rise over run in percent. | "The grade steepens to fifteen percent past the falls." | `reading-a-trail` |
| `naismiths-rule` | Naismith's rule | A planning formula: one hour per three miles plus one hour per two thousand feet of climbing. | "By Naismith's rule, we're looking at four hours up." | `reading-a-trail` |
| `moving-vs-total-time` | Moving vs total time | Moving time counts walking only; total time includes breaks, photos and lunch. | "Three hours moving, but five with breaks and views." | `reading-a-trail` |
| `pace` | Pace | How fast you cover ground, typically about two miles an hour on moderate terrain, less on steep or rough terrain. | "On steep trail we averaged a mile and a half an hour." | `reading-a-trail` |
| `difficulty-ratings` | Difficulty rating | Labels like easy or strenuous that are subjective and not standardized across apps and agencies. | "They call it moderate. It felt strenuous to me." | `reading-a-trail` |
| `class-scale` | Class scale | The Yosemite Decimal System's classes 1 to 5, from walking to roped climbing. | "It's class 2, a little hands-on scrambling near the top." | `reading-a-trail` |
| `exposure` | Exposure | Steep drop-offs beside your route where a fall would be serious. | "The exposure on the ridge was intense." | `reading-a-trail` |
| `route-vs-trail` | Route vs trail | A trail has maintained tread; a route follows a line across terrain without one. | "It's a route, not a trail. You need to navigate." | `reading-a-trail` |
| `water-source-reliability` | Water source reliability | Whether streams and springs are actually flowing; many are seasonal and can be dry. | "The spring at mile six may be dry in September." | `reading-a-trail` |
| `contour-line` | Contour line | A line on a map connecting points of equal elevation. | "Those contours are so tight that the slope has to be brutal." | `navigation` |
| `contour-interval` | Contour interval | The vertical distance in elevation between adjacent contour lines. | "Forty foot contour interval on this map." | `navigation` |
| `index-contour` | Index contour | A darker contour line, usually every fifth, labeled with its elevation. | "Follow the bold index contours to read the height." | `navigation` |
| `ridgeline` | Ridge and spur | A ridge is a long crest of high ground; a spur is a smaller ridge sticking out from it. Contours bend down-slope, away from higher ground. | "We're walking the ridge, then dropping down the spur." | `navigation` |
| `saddle` | Saddle | A low point on a ridge between two higher points, appearing as an hourglass on a map. | "The saddle between the two peaks is where the trail crosses." | `navigation` |
| `drainage` | Drainage | A valley or draw where water runs; contours form Vs that point uphill. | "Follow the drainage down and you'll hit the creek." | `navigation` |
| `cliff-contours` | Cliff contours | Contour lines that bunch together or merge, signaling very steep or vertical ground. | "The contours merge here. That's a cliff, not a trail." | `navigation` |
| `map-scale` | Map scale | The ratio of map distance to real distance; on a 1:24,000 map, one inch is 2,000 feet. | "On a one to twenty-four thousand map, an inch is two thousand feet." | `navigation` |
| `map-legend` | Map legend | The key that explains map symbols such as trails, roads, water and vegetation. | "I checked the legend to see if that dashed line was a trail." | `navigation` |
| `north-types` | True, magnetic and grid north | Three norths: the geographic pole, where a compass points, and the map's grid lines. | "Compass north isn't map north. Check the declination." | `navigation` |
| `declination` | Declination | The angle between true north and magnetic north at your location, which changes by place and year. | "Declination here is about ten degrees east, so I adjusted." | `navigation` |
| `bearing` | Bearing | A direction expressed in degrees from north, from 0 to 360. | "Take a bearing of ninety, due east, to the lake." | `navigation` |
| `handrail` | Handrail | A linear feature such as a stream, ridge or road that you can follow to stay oriented. | "I used the creek as a handrail all the way down." | `navigation` |
| `catching-feature` | Catching feature | A feature that tells you that you have gone too far, like a road or river past your target. | "The road is my catching feature. If I hit it, I overshot." | `navigation` |
| `gps-track` | GPS track | A recorded breadcrumb line of where you have been, which can be followed back. | "I saved my GPS track so I can retrace it." | `navigation` |
| `offline-maps` | Offline maps | Map areas downloaded to a phone so navigation works without signal. | "I downloaded the offline map before losing signal." | `navigation` |
| `waypoint` | Waypoint | A saved point such as a trailhead, junction or water source. | "I dropped a waypoint at the car." | `navigation` |
| `stop-method` | STOP | Stop, Think, Observe, Plan: the first response when you are unsure where you are. | "When I get turned around, I do STOP. Sit, breathe, look at the map." | `navigation` |
| `dead-reckoning` | Dead reckoning | Estimating position from a known start, direction, speed and time. | "Forty minutes at two miles an hour, so about a mile and a third along." | `navigation` |
| `aiming-off` | Aiming off | Deliberately aiming to one side of a target on a linear feature so you know which way to turn. | "I aimed off to the left so I'd know which way to turn at the creek." | `navigation` |
| `lapse-rate` | Lapse rate | Air cools about 3 to 5 degrees Fahrenheit per thousand feet of elevation gain. | "It's 70 at the trailhead, but the summit will be 50." | `weather-and-conditions` |
| `point-forecast` | Point forecast | A forecast for an exact map location and elevation rather than a nearby town. | "I checked the point forecast for the summit, not the town." | `weather-and-conditions` |
| `afternoon-thunderstorms` | Afternoon thunderstorms | Mountain storms that build in the afternoon after morning heating. | "Storms build after noon here, so we go early." | `weather-and-conditions` |
| `alpine-start` | Alpine start | Starting before dawn to be off exposed terrain before afternoon weather. | "Alpine start at 4 AM to be off the peak by noon." | `weather-and-conditions` |
| `lightning-safety` | Lightning safety | Leave summits and ridges early, avoid lone trees, spread out the group and wait 30 minutes after the last thunder. | "When thunder roars, get off the ridge." | `weather-and-conditions` |
| `wind-chill` | Wind chill | How much colder wind makes exposed skin feel; it does not lower the actual air temperature. | "Fifty degrees with wind gusts feels like thirty-five." | `weather-and-conditions` |
| `heat-risk` | Heat risk | A forecast rating of heat danger that accounts for temperature, humidity and sun. | "The heat risk is extreme today, so we're hiking at dawn." | `weather-and-conditions` |
| `hypothermia` | Hypothermia | Dangerous cooling of the body core, showing as shivering, fumbling and confusion, even above freezing. | "It was 45 and rainy. Hypothermia happens in that too." | `weather-and-conditions` |
| `flash-flood` | Flash flood | A sudden, violent rise in water from rain that may fall miles away, especially dangerous in canyons and washes. | "Rain upstream can flood a slot canyon while it's sunny above." | `weather-and-conditions` |
| `air-quality-index` | Air quality index | A 0 to 500 scale of air pollution; wildfire smoke can push it into unhealthy ranges. | "The AQI is 160 from smoke, so we're skipping the hike." | `weather-and-conditions` |
| `red-flag-warning` | Red flag warning | A fire-weather alert for warm, dry, windy conditions when fires spread fast. | "There's a red flag warning, so no campfires and no risk." | `weather-and-conditions` |
| `snowpack` | Snowpack | Accumulated snow that lingers on high trails into summer, hiding tread and making steep slopes hazardous. | "The pass will still have snowpack until July." | `weather-and-conditions` |
| `weather-window` | Weather window | A stretch of settled weather long enough to complete a plan. | "We got a weather window from eight to two." | `weather-and-conditions` |
| `turnaround-time` | Turnaround time | A pre-set clock time at which you head back regardless of how close the summit is. | "Our turnaround is one o'clock, summit or not." | `judgment-and-emergencies` |
| `daylight-math` | Daylight math | Working back from sunset using pace, distance and buffer to know when you must turn around. | "Sunset is 6:42, so we start back by 3:30." | `judgment-and-emergencies` |
| `summit-fever` | Summit fever | The urge to push on toward the goal and ignore warning signs. | "I got summit fever and ignored the clouds. Mistake." | `judgment-and-emergencies` |
| `sunk-cost-trap` | Sunk-cost trap | Pressing on because of effort already spent rather than the risk ahead. | "We'd come so far, but the trail was too icy to continue." | `judgment-and-emergencies` |
| `trip-plan` | Trip plan | Telling someone your route, group and return time, and when to call for help. | "I left my trip plan with a friend, with a call-out time." | `judgment-and-emergencies` |
| `margin-of-safety` | Margin of safety | Extra time, water, food and daylight beyond the plan. | "I plan for margin, an extra hour and extra snacks." | `judgment-and-emergencies` |
| `group-pace` | Group pace | The rule that the slowest hiker sets the speed and no one gets left behind. | "We hike at the pace of the slowest person." | `judgment-and-emergencies` |
| `sos-signals` | SOS signals | Distress signaling such as three whistle blasts, three flashes or three fires. | "Three whistle blasts means help." | `judgment-and-emergencies` |
| `satellite-messenger` | Satellite messenger | A device that texts or sends SOS via satellite when no cell service exists. | "My inReach lets me message from the middle of nowhere." | `judgment-and-emergencies` |
| `wilderness-first-aid` | Wilderness first aid | Medical training for situations where help is hours away. | "I did a wilderness first aid course last spring." | `judgment-and-emergencies` |
| `river-crossing` | River crossing | Crossing a stream safely: scout, cross early, unbuckle the hip belt and face upstream; or skip it. | "It was knee deep and fast, so we turned around." | `judgment-and-emergencies` |
| `wildlife-encounter` | Wildlife encounter | Standard precautions: keep distance, do not feed, make noise in bear country, know local guidance. | "We saw a bear a hundred yards off and gave it space." | `judgment-and-emergencies` |
| `bear-canister` | Bear canister | A hard-sided container that keeps food from bears in areas that require it. | "The park requires bear canisters overnight." | `judgment-and-emergencies` |
| `cell-coverage-myth` | Signal is not safety | Cell coverage in the backcountry is patchy at best; plan as if there is none. | "I don't count on signal out there. I download the map." | `judgment-and-emergencies` |
| `base-weight` | Base weight | The weight of your pack without food, water and fuel. | "My base weight is twelve pounds." | `gear-nerd-debates` |
| `big-three` | Big three | The three heaviest items: pack, shelter and sleep system. | "I dropped two pounds just by swapping my big three." | `gear-nerd-debates` |
| `ultralight` | Ultralight | A philosophy of carrying very little, typically a base weight under ten pounds. | "I'm ultralight, so no camp chair." | `gear-nerd-debates` |
| `trail-runners-debate` | Trail runners vs boots | The debate: light, breathable trail runners versus boots with ankle support and durability. | "I'm a trail-runner convert. Boots feel like ankle prisons." | `gear-nerd-debates` |
| `wet-foot-philosophy` | Wet-foot philosophy | Letting shoes get wet and drain rather than fight to keep them dry. | "I splash through creeks now. My shoes dry while I walk." | `gear-nerd-debates` |
| `gps-vs-paper` | Paper map vs GPS | The perennial debate over reliance on batteries versus paper; the sensible answer is both. | "Phone is my main, paper map is the backup." | `gear-nerd-debates` |
| `water-filter-types` | Filter types | Squeeze, gravity, pump and UV each trade speed, weight and reliability. | "I use a squeeze filter. It's light, but it can freeze." | `gear-nerd-debates` |
| `fastpacking` | Fastpacking | Moving quickly with a very light pack, mixing hiking and running. | "We're fastpacking it in two days. It's a run and a hike." | `gear-nerd-debates` |
| `hyoh` | Hike your own hike | A trail-culture motto: everyone chooses their own pace, gear and style. | "Hike your own hike, whatever works for you." | `gear-nerd-debates` |
| `shakedown-hike` | Shakedown hike | A short trip to test gear before a big one. | "We did a shakedown hike to test my new pack." | `gear-nerd-debates` |
| `thru-hike` | Thru-hike | Hiking a long trail end to end in one continuous journey. | "She's thru-hiking the whole Appalachian Trail." | `trail-culture-and-history` |
| `section-hike` | Section hike | Completing a long trail in pieces over time. | "I've section hiked about half of it." | `trail-culture-and-history` |
| `trail-name` | Trail name | A nickname a hiker earns or is given on the trail. | "My trail name is Sherpa, because I carry everyone's snacks." | `trail-culture-and-history` |
| `trail-magic` | Trail magic | Unexpected kindness for hikers, like free food or a ride. | "There was trail magic at the road, with cold soda and hot dogs." | `trail-culture-and-history` |
| `triple-crown` | Triple Crown | Completing the Appalachian, Pacific Crest and Continental Divide Trails. | "He's got two of the Triple Crown and needs the CDT." | `trail-culture-and-history` |
| `nobo-sobo` | NOBO and SOBO | Northbound and southbound thru-hikers. | "I'm a NOBO. I start in Georgia in March." | `trail-culture-and-history` |
| `zero-day` | Zero and nero | A zero is a rest day with no hiking miles; a nero is a near-zero day with few. | "I'm taking a zero in town to rest my feet." | `trail-culture-and-history` |
| `hiker-hunger` | Hiker hunger | The enormous appetite thru-hikers develop after weeks of long days. | "Hiker hunger hit and I ate two pizzas." | `trail-culture-and-history` |
| `resupply` | Resupply | Buying or receiving food and supplies along a long route. | "Next resupply is in town, four days ahead." | `trail-culture-and-history` |
| `fkt` | FKT | Fastest known time: an informal record for a set route. | "He's chasing an FKT on the loop." | `gear-nerd-debates` |
| `peakbagging` | Peakbagging | Trying to summit every peak on a list, like 14ers or the Adirondack 46. | "I'm peakbagging the 14ers, and I've done nine." | `trail-culture-and-history` |
| `wilderness-act` | Wilderness Act | The 1964 U.S. law creating a system of protected wilderness areas where motors and permanent structures are prohibited. | "It's designated wilderness, so no bikes and no motors." | `trail-culture-and-history` |
| `hut-to-hut` | Hut to hut | Trekking between lodges or huts instead of carrying a tent. | "We're doing a hut-to-hut in the Alps." | `trail-culture-and-history` |
| `tramily` | Tramily | A trail family, the group of hikers who bond on a long trail. | "My tramily and I hiked together for weeks." | `trail-culture-and-history` |
| `treeline` | Treeline | The elevation above which trees cannot grow, marking a change to exposed alpine terrain. | "Above treeline there is no shelter from storms." | `terrain-and-nature-literacy` |
| `talus-scree` | Talus and scree | Loose rock: talus is boulder-sized, scree is smaller and slides underfoot. | "The scree slope slid with every step." | `terrain-and-nature-literacy` |
| `cryptobiotic-soil` | Cryptobiotic soil | A living crust of organisms in desert soil, easily destroyed by footsteps. | "Don't bust the crust, stay on the trail." | `terrain-and-nature-literacy` |
| `cirque-moraine` | Cirque and moraine | Glacial landforms: a bowl carved in a mountainside and the ridge of debris a glacier left. | "The lake sits in a cirque beneath a moraine." | `terrain-and-nature-literacy` |
| `krummholz` | Krummholz | Stunted, wind-twisted trees at the edge of treeline. | "Those twisted krummholz trees are hundreds of years old." | `terrain-and-nature-literacy` |
| `tick-check` | Tick check | Inspecting your body after hikes in tick country and using repellent and treated clothing. | "I do a tick check after every hike." | `terrain-and-nature-literacy` |
| `poison-ivy` | Poison ivy | A plant with three-leaved clusters that causes an itchy rash on contact. | "Leaves of three, let it be." | `terrain-and-nature-literacy` |
| `postholing` | Postholing | Sinking deeply into soft snow with each step. | "We were postholing to our knees by noon." | `terrain-and-nature-literacy` |
| `microspikes` | Microspikes | Slip-on traction for icy trails. | "Bring microspikes. That north slope is icy till June." | `terrain-and-nature-literacy` |
| `permit-lottery` | Permit lottery | A random draw that allocates limited permits for popular hikes. | "I won the lottery for the Wave, I can't believe it." | `national-parks-and-permits` |
| `timed-entry` | Timed-entry reservation | A reservation for a window of entry into busy parks to limit crowding. | "We need a timed-entry reservation for the park." | `national-parks-and-permits` |
| `wilderness-permit` | Wilderness permit | A permit to camp or hike in a protected backcountry zone, often with quotas. | "We got the backcountry permit for two nights." | `national-parks-and-permits` |
| `shuttle-system` | Park shuttle | Free or paid shuttles that carry visitors to trailheads where parking is limited. | "We take the shuttle to the trailhead, no parking." | `national-parks-and-permits` |
| `annual-pass` | America the Beautiful pass | The federal recreation pass covering entrance fees at national parks and other federal lands. | "I bought the annual pass, it paid for itself in three visits." | `national-parks-and-permits` |
| `slot-canyon` | Slot canyon | A deep, narrow canyon carved by water, hazardous during rain nearby. | "The slot canyon glowed, but we watched the sky." | `desert-and-canyon-country` |
| `water-cache` | Water cache | Water stashed ahead on a desert route for later use. | "I cached water at the trailhead for the return." | `desert-and-canyon-country` |
| `avalanche-danger-scale` | Avalanche danger scale | A 1 to 5 rating from low to extreme published by avalanche centers. | "Danger is level 3, considerable, so we're avoiding steep slopes." | `alpine-and-high-country` |
| `cornice` | Cornice | An overhanging shelf of wind-packed snow on a ridge that can collapse. | "Stay back from the cornice, you can't tell where it ends." | `alpine-and-high-country` |
| `trail-report` | Trail report | A recent, human account of conditions like snow, mud, closures or blowdowns. | "The trail report says the creek crossing is high." | `seasonal-conditions-layer` |
| `fire-closure` | Fire closure | An official closure of an area due to wildfire risk or activity. | "The forest is closed because of the fire." | `national-parks-and-permits` |
| `seasonal-window` | Seasonal window | The best period for a hike, like wildflower bloom, fall color or snowmelt. | "Peak wildflowers hit in mid July." | `seasonal-conditions-layer` |
| `alerts-and-closures` | Alerts and closures | Official notices about hazards or closed trails, published by land agencies. | "I checked the park alerts before we left." | `national-parks-and-permits` |
