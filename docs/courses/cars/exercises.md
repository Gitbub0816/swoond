# Native Exercise Plan: Cars (`cars`)

Tier B plan for `docs/courses/cars/`. All 13 native exercise types are used; the single Tier A sim is in `sims/`. Every sample payload below is the exact contract shape and validates against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv 2020-12 setup on 2026-09-30). Conventions: prompts of 12 words or fewer; every answer explained; every image and audio asset carries `license: original-swoond`; no manufacturer photos, logos or badges (CDS section 13); asset files are planned, so `image.asset` and `audio.asset` paths name assets to be produced (CDS section 14).

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default recall and Daily Bite card: definitions, spec-sheet reading, ownership words. Distractors are the misconceptions in CDS section 2. | ~200 |
| `binary-call` | Yes/no situational calls (differential, regen, etiquette). Scenes use `kind: image` with original illustrations; no court or field diagram fits cars. | ~50 |
| `term-match` | Introduce 3-4 related terms (drive layouts, hybrid letters, restoration words). Plain-English definitions. | ~50 |
| `sequence-order` | Processes: the four strokes, the power path, a pre-purchase check, charging steps, restoration order. | ~30 |
| `visual-id` | Spec section 18: recognition by sight from original illustrations only (archetypes, feature callouts, composites). Alt text describes features without naming the answer. | ~90 |
| `decision-scenario` | Judgment about buying, meets, mods, EV trips. `expertNote` always; `safetyNote` on safety, legal and money topics. | ~50 |
| `talk-track` | See sections 4 and 5. Conversation practice. | ~20 |
| `timing-tap` | Only 1D timing (shift point, clutch bite, power peak). Not pedal feel. | ~10 |
| `say-this` | Decode what she just said; each has a `noFakeExpertNote` and honest follow-ups. | ~80 |
| `fill-the-gap` | Vocabulary in context; quick review card. | ~60 |
| `listening-id` | Original synthesized engine and motor notes only; a Skip is always available; `audio.description` is the text alternative. | ~12 |
| `estimate-slider` | Magnitudes with tolerance bands (percent, mi/kWh, seconds). | ~35 |
| `hotspot-tap` | Static original diagrams identified by `diagramId`; no motion. | ~70 |

Estimated total: about 757 native items across 116 lessons and the review loop. Cross-type rules: each lesson ends with one item that has a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap`, `term-match`.

## 2. Sample items by type

### 2.1 `multiple-choice`

Default recall and Daily Bite card: definitions, spec-sheet reading, ownership words. Distractors are the misconceptions in CDS section 2.

**Sample 1** (lesson `hw-04`)

```json
{
  "prompt": "Which one is the \"shove\" you feel when you floor it?",
  "options": [
    {
      "id": "a",
      "text": "Horsepower"
    },
    {
      "id": "b",
      "text": "Torque"
    },
    {
      "id": "c",
      "text": "Displacement"
    },
    {
      "id": "d",
      "text": "Redline"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Torque is the twisting force at the crank. That is the shove in your back. Horsepower is torque times revs, so it tells you how long the shove lasts.",
    "incorrect": "Torque is the shove you feel. Horsepower is torque multiplied by engine speed, so it is more about how the shove holds up at high revs.",
    "sayThisLine": "Torque is the shove. Horsepower is how long it lasts."
  }
}
```

**Sample 2** (lesson `dt-05`)

```json
{
  "prompt": "A crossover is listed as AWD. What does that most likely mean?",
  "options": [
    {
      "id": "a",
      "text": "Power goes to all four wheels automatically as needed"
    },
    {
      "id": "b",
      "text": "It has a low-range gearbox for rock crawling"
    },
    {
      "id": "c",
      "text": "It cannot lose grip in a corner"
    },
    {
      "id": "d",
      "text": "It is faster than the RWD version"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "AWD sends power to all four wheels, usually automatically. It helps you get going in rain or snow. It does not raise cornering grip, and it is not a low-range 4WD system.",
    "incorrect": "AWD is an automatic system that shares power across four wheels. Low range is a 4WD feature, and AWD cannot raise the grip your tires have in a corner.",
    "sayThisLine": "AWD helps you get going. Tires still decide the corner."
  }
}
```

**Sample 3** (lesson `ev-02`)

```json
{
  "prompt": "An EV battery is \"82 kWh\". What is that closest to?",
  "options": [
    {
      "id": "a",
      "text": "The size of the fuel tank"
    },
    {
      "id": "b",
      "text": "The top speed"
    },
    {
      "id": "c",
      "text": "The charger plug type"
    },
    {
      "id": "d",
      "text": "The motor power"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "kWh is stored energy, the tank. Efficiency (miles per kWh) is the mpg. Together they give range.",
    "incorrect": "kWh is energy stored, like a gallon count. Motor power is in kilowatts (kW), and speed is not measured in kWh."
  }
}
```

**Sample 4** (lesson `cl-04`)

```json
{
  "prompt": "A car is \"matching numbers\". Which claim does that make?",
  "options": [
    {
      "id": "a",
      "text": "The engine and gearbox are the ones it left the factory with"
    },
    {
      "id": "b",
      "text": "It has never been repainted"
    },
    {
      "id": "c",
      "text": "It has under 10,000 miles"
    },
    {
      "id": "d",
      "text": "It has the same tire size on all four corners"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Matching numbers means the drivetrain serial numbers match the factory records. It does not say anything about paint or mileage. It matters to collectors because originality drives value.",
    "incorrect": "Matching numbers is about the drivetrain being original to the car. Paint and mileage are separate questions.",
    "sayThisLine": "Is it matching numbers, or did the engine get swapped?"
  }
}
```

### 2.2 `binary-call`

Yes/no situational calls (differential, regen, etiquette). Scenes use `kind: image` with original illustrations; no court or field diagram fits cars.

**Sample 1** (lesson `dt-06`)

```json
{
  "prompt": "Snow. One wheel spins, the other does not move.",
  "scene": {
    "kind": "image",
    "image": "images/cars/diff-open-vs-lsd.svg",
    "alt": "Diagram: an open differential sends equal torque to both driven wheels; the left tire sits on ice and spins while the right tire on dry pavement has grip."
  },
  "choices": [
    {
      "id": "open",
      "label": "Open differential"
    },
    {
      "id": "lsd",
      "label": "Limited-slip"
    }
  ],
  "correctChoiceId": "open",
  "explanation": {
    "correct": "An open differential gives both wheels equal torque, and torque is limited by the wheel with less grip. That is why one spins. A limited-slip unit shares torque and can push the other wheel.",
    "incorrect": "A limited-slip differential would push some torque to the grippy wheel. This picture shows the open kind: one wheel spins and the other does not get the drive.",
    "sayThisLine": "Open diffs send the torque to the wheel with less grip."
  },
  "ruleTag": "Differential"
}
```

**Sample 2** (lesson `ev-03`)

```json
{
  "prompt": "Lifting off in an EV lights the brake lamps. Why?",
  "scene": {
    "kind": "image",
    "image": "images/cars/ev-regen-lift.svg",
    "alt": "Diagram: an EV with a battery and a motor; arrows show the motor acting as a generator, slowing the car, while the friction brakes are idle."
  },
  "choices": [
    {
      "id": "regen",
      "label": "Regen braking is slowing it"
    },
    {
      "id": "fault",
      "label": "Something is broken"
    }
  ],
  "correctChoiceId": "regen",
  "explanation": {
    "correct": "Many EVs slow strongly on lift, and the car lights the brakes because you are decelerating. The motor is acting as a generator and sends energy back to the battery.",
    "incorrect": "It is not broken. Strong regen slows the car when you lift, and the brake lights come on so the traffic behind knows.",
    "sayThisLine": "One-pedal driving lights the brake lights on purpose."
  },
  "ruleTag": "Regen"
}
```

**Sample 3** (lesson `mt-02`)

```json
{
  "prompt": "At a meet, someone leaves their hood open. Ok to lean in?",
  "scene": {
    "kind": "image",
    "image": "images/cars/meet-open-hood.svg",
    "alt": "Scene: a parked classic with an open hood at a car meet; a small group stands a respectful distance away."
  },
  "choices": [
    {
      "id": "ask",
      "label": "Ask the owner first"
    },
    {
      "id": "lean",
      "label": "Lean in and touch"
    }
  ],
  "correctChoiceId": "ask",
  "explanation": {
    "correct": "Cars at meets are personal and often polished for hours. Ask first. Owners are usually thrilled to tell you about the engine, and fingerprints on fresh paint are not.",
    "incorrect": "Owners do the hard work. Touching without asking is the classic beginner mistake. Ask, and it is usually a yes.",
    "sayThisLine": "Can I take a closer look at the engine?"
  },
  "ruleTag": "Meet etiquette"
}
```

### 2.3 `term-match`

Introduce 3-4 related terms (drive layouts, hybrid letters, restoration words). Plain-English definitions.

**Sample 1** (lesson `dt-05`)

```json
{
  "prompt": "Match the drive layout to its everyday quirk.",
  "pairs": [
    {
      "id": "fwd",
      "term": "FWD",
      "definition": "Front wheels steer and drive; efficient and stable"
    },
    {
      "id": "rwd",
      "term": "RWD",
      "definition": "Rear wheels push; balanced feel, lighter steering"
    },
    {
      "id": "awd",
      "term": "AWD",
      "definition": "All four share power; strong in bad weather"
    },
    {
      "id": "4wd",
      "term": "4WD",
      "definition": "Selectable low range for hard terrain"
    }
  ],
  "explanation": {
    "summary": "Layout is only where the power goes. It changes traction, feel and cost, not whether a car is good.",
    "sayThisLine": "It's a front-driver, so it pushes when you get on the gas."
  },
  "distractorDefinitions": [
    "Only the rear wheels ever turn"
  ]
}
```

**Sample 2** (lesson `ev-05`)

```json
{
  "prompt": "Match the hybrid type to what it does.",
  "pairs": [
    {
      "id": "hev",
      "term": "HEV",
      "definition": "Hybrid that charges itself; no plug"
    },
    {
      "id": "phev",
      "term": "PHEV",
      "definition": "Plug-in hybrid with real electric range"
    },
    {
      "id": "mhev",
      "term": "MHEV",
      "definition": "Mild hybrid; small motor helps the engine"
    },
    {
      "id": "erev",
      "term": "Range extender",
      "definition": "Engine only makes electricity for the wheels"
    }
  ],
  "explanation": {
    "summary": "The letters tell you how much the electric side can do on its own, from a little help to a full electric commute.",
    "sayThisLine": "It is a plug-in, so most of her commute is electric."
  },
  "distractorDefinitions": [
    "A hybrid that runs only on hydrogen"
  ]
}
```

**Sample 3** (lesson `cl-04`)

```json
{
  "prompt": "Match the restoration word to the car.",
  "pairs": [
    {
      "id": "orig",
      "term": "Original",
      "definition": "Unrestored, still as delivered"
    },
    {
      "id": "rest",
      "term": "Restored",
      "definition": "Returned to factory spec"
    },
    {
      "id": "resto",
      "term": "Restomod",
      "definition": "Old body, modern hardware"
    },
    {
      "id": "surv",
      "term": "Survivor",
      "definition": "Unrestored and well kept over the years"
    }
  ],
  "explanation": {
    "summary": "The words tell you what a car is, not how nice it is. A survivor can outrank a perfect restoration.",
    "sayThisLine": "It is a restomod: it looks old and drives new."
  },
  "distractorDefinitions": [
    "Rebuilt with copy parts"
  ]
}
```

### 2.4 `sequence-order`

Processes: the four strokes, the power path, a pre-purchase check, charging steps, restoration order.

**Sample 1** (lesson `hw-01`)

```json
{
  "prompt": "Put the four strokes in order.",
  "items": [
    {
      "id": "intake",
      "text": "Intake",
      "why": "The piston goes down and pulls air and fuel in."
    },
    {
      "id": "compression",
      "text": "Compression",
      "why": "The piston rises and squeezes the mixture."
    },
    {
      "id": "power",
      "text": "Power",
      "why": "The spark lights it and pushes the piston down."
    },
    {
      "id": "exhaust",
      "text": "Exhaust",
      "why": "The piston rises and pushes the burned gas out."
    }
  ],
  "explanation": {
    "correct": "Suck, squeeze, bang, blow: each stroke sets up the next.",
    "incorrect": "The order follows the piston: in, squeeze, fire, out.",
    "sayThisLine": "Suck, squeeze, bang, blow. That's the engine."
  }
}
```

**Sample 2** (lesson `dt-01`)

```json
{
  "prompt": "Follow the power from engine to road.",
  "items": [
    {
      "id": "engine",
      "text": "Engine",
      "why": "Makes the rotating power at the crank."
    },
    {
      "id": "clutch",
      "text": "Clutch or torque converter",
      "why": "Lets the engine spin while the car is stopped."
    },
    {
      "id": "trans",
      "text": "Gearbox",
      "why": "Multiplies torque with different ratios."
    },
    {
      "id": "shaft",
      "text": "Driveshaft or axles",
      "why": "Carries the power to the wheels."
    },
    {
      "id": "diff",
      "text": "Differential",
      "why": "Splits power between two wheels so they can turn at different speeds."
    }
  ],
  "explanation": {
    "correct": "Power leaves the engine, is coupled, multiplied, carried and split.",
    "incorrect": "The path is engine, coupling, gearbox, shaft, differential, wheels."
  }
}
```

**Sample 3** (lesson `ow-06`)

```json
{
  "prompt": "Order a pre-purchase check, from first to last.",
  "items": [
    {
      "id": "history",
      "text": "Read the history report",
      "why": "Confirm title, accidents and service records first."
    },
    {
      "id": "walk",
      "text": "Walk around in daylight",
      "why": "Look for panel gaps and paint mismatch."
    },
    {
      "id": "drive",
      "text": "Drive it cold, then hot",
      "why": "Some faults only show at one temperature."
    },
    {
      "id": "ppi",
      "text": "Independent inspection",
      "why": "A neutral shop lifts the car and checks what you cannot."
    },
    {
      "id": "deal",
      "text": "Negotiate with what you learned",
      "why": "Facts from the earlier steps are your leverage."
    }
  ],
  "explanation": {
    "correct": "Cheap checks first, expert checks last, negotiation at the end.",
    "incorrect": "Start with records, then eyes, then a drive, then an independent shop, then price."
  }
}
```

### 2.5 `visual-id`

Spec section 18: recognition by sight from original illustrations only (archetypes, feature callouts, composites). Alt text describes features without naming the answer.

**Sample 1** (lesson `bs-01`)

```json
{
  "prompt": "Which body style is this?",
  "image": {
    "asset": "images/cars/archetype-hatchback-side.svg",
    "alt": "Side view of a small car with a sloping rear window and a rear door that lifts as one with the glass.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "sedan",
      "text": "Sedan"
    },
    {
      "id": "hatch",
      "text": "Hatchback"
    },
    {
      "id": "wagon",
      "text": "Wagon"
    },
    {
      "id": "coupe",
      "text": "Coupe"
    }
  ],
  "correctOptionId": "hatch",
  "explanation": {
    "correct": "A hatchback has a rear door hinged at the roof that lifts with the glass. The short tail and sloping rear are the giveaway. A sedan has a separate trunk lid.",
    "incorrect": "Look at the rear. The glass and the door are one piece, and the tail is short. That is a hatchback. A wagon runs the roof much farther back.",
    "sayThisLine": "It's a hatch, so the trunk is really a cargo area."
  },
  "cues": [
    "Rear glass lifts with the door",
    "Short rear overhang",
    "Roof slopes at the tail"
  ]
}
```

**Sample 2** (lesson `dt-07`)

```json
{
  "prompt": "Where does this car keep its engine?",
  "image": {
    "asset": "images/cars/layout-mid-engine.svg",
    "alt": "Cutaway side view of a low two-seater with the engine drawn between the passenger cabin and the rear axle.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "front",
      "text": "Front"
    },
    {
      "id": "mid",
      "text": "Middle, behind the seats"
    },
    {
      "id": "rear",
      "text": "Rear, behind the axle"
    },
    {
      "id": "none",
      "text": "Under the floor (electric)"
    }
  ],
  "correctOptionId": "mid",
  "explanation": {
    "correct": "The engine sits between the cabin and the rear axle. That mid-engine layout puts weight near the center, which is why supercars use it, and why the cabin sits far forward.",
    "incorrect": "Look for the engine block drawn between the seats and the rear axle. That is mid-engine. A rear-engine car has it behind the axle.",
    "sayThisLine": "It's mid-engine, so the weight sits in the middle."
  },
  "cues": [
    "Cabin pushed forward",
    "Engine between seats and axle",
    "Short hood"
  ]
}
```

**Sample 3** (lesson `bs-03`)

```json
{
  "prompt": "Which roof is this?",
  "image": {
    "asset": "images/cars/roof-targa.svg",
    "alt": "Side view of a two-seater with a removable roof panel over the seats and a fixed rear window and roll structure behind.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "conv",
      "text": "Full convertible"
    },
    {
      "id": "targa",
      "text": "Targa"
    },
    {
      "id": "fastback",
      "text": "Fastback"
    },
    {
      "id": "ttop",
      "text": "T-top"
    }
  ],
  "correctOptionId": "targa",
  "explanation": {
    "correct": "A targa removes a roof panel but keeps a fixed roll structure behind the seats. A full convertible folds the whole roof away.",
    "incorrect": "Notice the fixed structure behind the seats. That marks a targa. A convertible drops the whole roof and has no such bar.",
    "sayThisLine": "It is a targa, so the roof panel comes off."
  },
  "cues": [
    "Roll structure behind seats",
    "Removable center panel",
    "Fixed rear window"
  ]
}
```

**Sample 4** (lesson `rc-02`)

```json
{
  "prompt": "Which sign is a light signature?",
  "image": {
    "asset": "images/cars/light-signature.svg",
    "alt": "Front view of an invented car with four small white daytime running lights arranged in a fixed pattern beside each headlight.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "sig",
      "text": "The four-dot daytime lights"
    },
    {
      "id": "logo",
      "text": "The badge"
    },
    {
      "id": "grille",
      "text": "The size of the grille"
    },
    {
      "id": "wheel",
      "text": "The wheel design"
    }
  ],
  "correctOptionId": "sig",
  "explanation": {
    "correct": "Makers now use lighting as identity. A distinctive daytime-light shape lets a car be recognized at night from a mile away, even without a badge.",
    "incorrect": "A light signature is a lighting pattern that says who built the car. The badge is a logo, not a signature.",
    "sayThisLine": "You can tell it's a newer one from the lights alone."
  },
  "cues": [
    "Fixed pattern of lamps",
    "Same at day and night",
    "Independent of the grille"
  ]
}
```

**Sample 5** (lesson `bs-02`)

```json
{
  "prompt": "Is this a crossover or a body-on-frame SUV?",
  "image": {
    "asset": "images/cars/suv-frame-vs-unibody.svg",
    "alt": "Cutaway of a tall wagon showing a steel frame ladder under the body, separate from the cabin, with a live axle at the rear.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "cross",
      "text": "Crossover (unibody)"
    },
    {
      "id": "frame",
      "text": "Body-on-frame SUV"
    },
    {
      "id": "van",
      "text": "Minivan"
    },
    {
      "id": "wagon",
      "text": "Wagon"
    }
  ],
  "correctOptionId": "frame",
  "explanation": {
    "correct": "The ladder frame under a separate body marks a body-on-frame SUV, built for towing and rough tracks. A crossover is built like a car, with the body as the structure.",
    "incorrect": "Look for the ladder frame under the cabin. Crossovers use a single-piece body and no such frame.",
    "sayThisLine": "It's body-on-frame, so it tows well."
  },
  "cues": [
    "Ladder frame under body",
    "Separate cabin",
    "Tall ride height"
  ]
}
```

### 2.6 `decision-scenario`

Judgment about buying, meets, mods, EV trips. `expertNote` always; `safetyNote` on safety, legal and money topics.

**Sample 1** (lesson `ow-01`)

```json
{
  "prompt": "New or used? What helps most?",
  "situation": {
    "narrative": "Her friend is comparing a new compact with a three-year-old certified one, same trim.",
    "facts": [
      {
        "label": "New price",
        "value": "$27,900"
      },
      {
        "label": "Certified used price",
        "value": "$21,500"
      },
      {
        "label": "Certified warranty left",
        "value": "2 years"
      },
      {
        "label": "Miles on used",
        "value": "31,000"
      },
      {
        "label": "Her yearly driving",
        "value": "9,000 mi"
      }
    ]
  },
  "options": [
    {
      "id": "new",
      "label": "Buy new, it is always better",
      "verdict": "poor",
      "consequence": "Depreciation takes the biggest bite in the first years, and she will pay for it. New is fine, but not automatically better.",
      "considerations": [
        "Depreciation is steepest early",
        "Warranty is the real benefit"
      ]
    },
    {
      "id": "cpo",
      "label": "Compare the certified used one and its warranty",
      "verdict": "best",
      "consequence": "Certified used often has warranty left and a lower price. She saves the depreciation and keeps peace of mind.",
      "considerations": [
        "Lower price for the same trim",
        "Warranty still valid",
        "Check the history report"
      ]
    },
    {
      "id": "any",
      "label": "Take the cheapest used one from a stranger",
      "verdict": "acceptable",
      "consequence": "It may be fine, but no inspection and no warranty means more risk. Price is one factor of several.",
      "considerations": [
        "No warranty",
        "Get a pre-purchase inspection"
      ]
    }
  ],
  "expertNote": "Enthusiasts and mechanics weigh total cost, not just sticker: depreciation, warranty, service history and what they will do with the car.",
  "safetyNote": "This is not financial advice; prices are examples.",
  "sayThisLine": "Have you looked at certified pre-owned?"
}
```

**Sample 2** (lesson `mt-02`)

```json
{
  "prompt": "Someone is revving loudly as they leave the meet. You?",
  "situation": {
    "narrative": "A cruise-in has ended. A driver pulls out and bangs the throttle near families and neighbors.",
    "facts": [
      {
        "label": "Time",
        "value": "8:40 PM"
      },
      {
        "label": "Location",
        "value": "Shop parking lot"
      },
      {
        "label": "Nearby",
        "value": "Houses, kids",
        "emphasis": "warning"
      },
      {
        "label": "Organizer rule",
        "value": "No revving, roll out quietly"
      }
    ]
  },
  "options": [
    {
      "id": "join",
      "label": "Join in, everyone else does",
      "verdict": "poor",
      "consequence": "Noise complaints are how meets get shut down. One loud exit can end an event that many people enjoy.",
      "considerations": [
        "Neighbors can complain",
        "Organizers can lose the venue"
      ]
    },
    {
      "id": "quiet",
      "label": "Roll out quietly and stay out of it",
      "verdict": "best",
      "consequence": "Leaving calmly protects the meet and avoids a confrontation. Quiet exits are part of the culture.",
      "considerations": [
        "Meet stays welcome",
        "Nobody escalates"
      ]
    },
    {
      "id": "confront",
      "label": "Confront the driver",
      "verdict": "acceptable",
      "consequence": "It might work, but a confrontation can go wrong. Let organizers handle it.",
      "considerations": [
        "Escalation risk",
        "Better to tell an organizer"
      ]
    }
  ],
  "expertNote": "Experienced organizers say the meet lives or dies by its neighbors. Quiet exits are the rule for a reason.",
  "safetyNote": "Never race, block roads or confront strangers.",
  "sayThisLine": "Quiet exit, everyone gets to come back."
}
```

**Sample 3** (lesson `md-03`)

```json
{
  "prompt": "Stage 1 tune, car under warranty. What matters?",
  "situation": {
    "narrative": "She has a two-year-old turbo hatch with a 5-year warranty and wants more power.",
    "facts": [
      {
        "label": "Car age",
        "value": "2 years"
      },
      {
        "label": "Warranty left",
        "value": "3 years",
        "emphasis": "warning"
      },
      {
        "label": "Tune claim",
        "value": "+40 hp"
      },
      {
        "label": "Use",
        "value": "Daily commute"
      }
    ]
  },
  "options": [
    {
      "id": "flash",
      "label": "Flash the tune tonight, no questions",
      "verdict": "poor",
      "consequence": "A tune can void warranty coverage on affected parts. Extra power stresses parts that were designed for the stock output.",
      "considerations": [
        "Warranty risk",
        "Higher stress on parts"
      ]
    },
    {
      "id": "ask",
      "label": "Ask the tuner and the dealer what is covered first",
      "verdict": "best",
      "consequence": "Different makers treat tunes differently. A quick conversation about what is covered and what is not is cheap insurance.",
      "considerations": [
        "Know the risk",
        "Keep records"
      ]
    },
    {
      "id": "skip",
      "label": "Skip mods until warranty ends",
      "verdict": "acceptable",
      "consequence": "A fine path, especially for a daily. Some people wait and then modify.",
      "considerations": [
        "Patience costs nothing",
        "Might miss the fun now"
      ]
    }
  ],
  "expertNote": "Owners say the tune is the easy part. The real question is what breaks first and who pays.",
  "safetyNote": "General information; check your own warranty and local law.",
  "sayThisLine": "Have you checked what the warranty covers?"
}
```

**Sample 4** (lesson `ev-04`)

```json
{
  "prompt": "Long trip in an EV. When do you charge?",
  "situation": {
    "narrative": "A first-time EV owner plans a 300-mile trip with two stops.",
    "facts": [
      {
        "label": "Battery now",
        "value": "90%"
      },
      {
        "label": "Range",
        "value": "About 260 mi"
      },
      {
        "label": "Next fast charger",
        "value": "170 mi away"
      },
      {
        "label": "Weather",
        "value": "Cold, 25 F",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "empty",
      "label": "Drive until it is nearly empty",
      "verdict": "poor",
      "consequence": "Cold cuts range, and chargers can be busy. Arriving nearly empty leaves no room for surprises.",
      "considerations": [
        "Cold drops range",
        "Chargers can be busy"
      ]
    },
    {
      "id": "early",
      "label": "Plan the stop with a buffer and arrive around 15 percent",
      "verdict": "best",
      "consequence": "A buffer covers cold and detours. Fast chargers also charge fastest at lower states of charge.",
      "considerations": [
        "Cold buffer",
        "Faster charging at low percent"
      ]
    },
    {
      "id": "home",
      "label": "Charge to 100 at every stop",
      "verdict": "acceptable",
      "consequence": "It works, but the last 20 percent is slow. Two shorter stops are often quicker.",
      "considerations": [
        "Slow above 80 percent",
        "Time cost"
      ]
    }
  ],
  "expertNote": "EV owners plan by charger, not by tank: buffer, weather, and charging speed.",
  "safetyNote": "General planning info only; follow your car's guidance.",
  "sayThisLine": "Where are you charging, and do you have a buffer?"
}
```

### 2.7 `talk-track`

Nine complete scenarios with reply styles and payloads are in section 4.

### 2.8 `timing-tap`

Only 1D timing (shift point, clutch bite, power peak). Not pedal feel.

**Sample 1** (lesson `dt-02`)

```json
{
  "prompt": "Tap when the shift light turns gold.",
  "theme": {
    "label": "Shift light",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 58,
      "zoneEndPct": 74,
      "sweepSeconds": 1.6
    },
    {
      "zoneStartPct": 64,
      "zoneEndPct": 76,
      "sweepSeconds": 1.3
    },
    {
      "zoneStartPct": 70,
      "zoneEndPct": 79,
      "sweepSeconds": 1.1
    }
  ],
  "explanation": {
    "correct": "Shift points are set to keep the engine near its power. Too early wastes power; too late hits the limiter.",
    "incorrect": "Shifting too early or too late loses acceleration. The zone is where the engine makes its best power.",
    "sayThisLine": "Shift near the top of the power band."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `dt-03`)

```json
{
  "prompt": "Tap when the clutch reaches the bite point.",
  "theme": {
    "label": "Clutch bite",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 52,
      "zoneEndPct": 66,
      "sweepSeconds": 1.8
    },
    {
      "zoneStartPct": 56,
      "zoneEndPct": 66,
      "sweepSeconds": 1.5
    },
    {
      "zoneStartPct": 60,
      "zoneEndPct": 68,
      "sweepSeconds": 1.3
    }
  ],
  "explanation": {
    "correct": "The bite point is where the clutch starts to grab. Release too fast and it stalls; too slow and it slips.",
    "incorrect": "A clutch that engages too early or late stalls or slips. The window is the bite point.",
    "sayThisLine": "Find the bite point, then ease the pedal."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 3** (lesson `hw-04`)

```json
{
  "prompt": "Tap when the rev needle reaches the power peak.",
  "theme": {
    "label": "Power peak",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 60,
      "zoneEndPct": 75,
      "sweepSeconds": 1.7
    },
    {
      "zoneStartPct": 65,
      "zoneEndPct": 77,
      "sweepSeconds": 1.4
    },
    {
      "zoneStartPct": 70,
      "zoneEndPct": 80,
      "sweepSeconds": 1.2
    }
  ],
  "explanation": {
    "correct": "Peak power arrives at a specific rev band. Below it you have torque; above it power falls.",
    "incorrect": "Power builds, peaks, then falls. The zone marks where a shift keeps the engine at its best.",
    "sayThisLine": "Keep it in the power band."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.9 `say-this`

Decode what she just said; each has a `noFakeExpertNote` and honest follow-ups.

**Sample 1** (lesson `md-02`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Just got the downpipe and intake on. Stage 1, nothing crazy."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "She added bolt-on parts to her turbo car",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "She got new tires",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "She raised power a bit",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "She bought a bigger engine",
      "isCorrect": false
    }
  ],
  "translation": "She bolted on an intake and a less restrictive pipe behind the turbo, and probably had it tuned. A modest power bump, not a rebuilt car.",
  "followUps": [
    {
      "line": "Did you get a tune with it?",
      "why": "Shows you know parts and tune go together."
    },
    {
      "line": "How does it sound now?",
      "why": "Asks about her experience instead of quizzing."
    }
  ],
  "noFakeExpertNote": "You do not need to know the parts; ask how it feels."
}
```

**Sample 2** (lesson `db-01`)

```json
{
  "statement": {
    "speaker": "Theo",
    "text": "They finally took the manual out of the new one. Sad."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "The new model is only available as an automatic",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The car now has no gears at all",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "He is upset about losing engagement",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "The new car is cheaper",
      "isCorrect": false
    }
  ],
  "translation": "The new version dropped the manual gearbox and he misses the involvement. It is a debate, not a spec-sheet problem.",
  "followUps": [
    {
      "line": "What did you like about the manual?",
      "why": "Invites his reason, not a defense."
    },
    {
      "line": "Do you have one now?",
      "why": "Simple and warm."
    }
  ],
  "noFakeExpertNote": "Ask what he loved. You do not need a side."
}
```

**Sample 3** (lesson `ev-04`)

```json
{
  "statement": {
    "speaker": "Riya",
    "text": "I'm on Level 2 at home, so I basically never fast charge."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "She charges overnight at home",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "She has a gas car",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "She charges slowly and cheaply",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "She is on a road trip",
      "isCorrect": false
    }
  ],
  "translation": "Level 2 is a home or workplace charger that refills an EV overnight. She rarely needs a fast charger unless she is travelling.",
  "followUps": [
    {
      "line": "Do you get a full battery by morning?",
      "why": "Shows you understand overnight charging."
    },
    {
      "line": "Did you have to install it?",
      "why": "Sincere, practical."
    }
  ],
  "noFakeExpertNote": "Lead with curiosity about her setup."
}
```

**Sample 4** (lesson `cl-05`)

```json
{
  "statement": {
    "speaker": "Ben",
    "text": "It's a numbers-matching '69, but the paint isn't original."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "The drivetrain is original but it has been repainted",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The car is a replica",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "It is still worth a lot to collectors",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "The engine was swapped",
      "isCorrect": false
    }
  ],
  "translation": "The engine and gearbox are original to the car, which collectors love, but the paint has been redone, which may lower value slightly.",
  "followUps": [
    {
      "line": "Do you have the build sheet?",
      "why": "Shows you know paper matters to originality."
    },
    {
      "line": "How did you find it?",
      "why": "Story questions are always safe."
    }
  ],
  "noFakeExpertNote": "Do not guess a price; ask about the story."
}
```

### 2.10 `fill-the-gap`

Vocabulary in context; quick review card.

**Sample 1** (lesson `hw-03`)

```json
{
  "prompt": "Complete the engine sentence.",
  "template": "A {{disp}} is a big-displacement engine, while a 2.0T is a {{size}} engine with a {{boost}}.",
  "gaps": [
    {
      "id": "disp",
      "options": [
        "5.0",
        "1.0"
      ],
      "correct": "5.0"
    },
    {
      "id": "size",
      "options": [
        "small",
        "huge"
      ],
      "correct": "small"
    },
    {
      "id": "boost",
      "options": [
        "turbo",
        "clutch"
      ],
      "correct": "turbo"
    }
  ],
  "explanation": {
    "correct": "A 5.0 is five liters. A 2.0T is two liters with a turbocharger, so it can make similar power from less engine.",
    "incorrect": "The number is displacement in liters. The letter T means turbo.",
    "sayThisLine": "It's a small turbo four."
  }
}
```

**Sample 2** (lesson `ev-01`)

```json
{
  "prompt": "Fill in the EV parts.",
  "template": "The {{pack}} stores the energy, the {{inv}} converts it, and the {{motor}} turns the wheels.",
  "gaps": [
    {
      "id": "pack",
      "options": [
        "battery pack",
        "clutch"
      ],
      "correct": "battery pack"
    },
    {
      "id": "inv",
      "options": [
        "inverter",
        "radiator"
      ],
      "correct": "inverter"
    },
    {
      "id": "motor",
      "options": [
        "electric motor",
        "gearbox"
      ],
      "correct": "electric motor"
    }
  ],
  "explanation": {
    "correct": "Pack stores DC energy, the inverter makes AC, and the motor makes motion.",
    "incorrect": "The battery holds the energy, the inverter converts it and the motor drives the wheels."
  }
}
```

**Sample 3** (lesson `rc-03`)

```json
{
  "prompt": "Generation or facelift?",
  "template": "A {{gen}} is an all-new car, while a {{lift}} is a mid-life update with new lights and bumpers.",
  "gaps": [
    {
      "id": "gen",
      "options": [
        "generation",
        "trim"
      ],
      "correct": "generation"
    },
    {
      "id": "lift",
      "options": [
        "facelift",
        "recall"
      ],
      "correct": "facelift"
    }
  ],
  "explanation": {
    "correct": "A generation is a new platform and body. A facelift keeps the platform and updates the look.",
    "incorrect": "A new generation is the whole car new. A facelift is a mid-life refresh.",
    "sayThisLine": "It is the second-generation, or just the facelift?"
  }
}
```

### 2.11 `listening-id`

Original synthesized engine and motor notes only; a Skip is always available; `audio.description` is the text alternative.

**Sample 1** (lesson `hw-02`)

```json
{
  "prompt": "Which engine layout makes this sound?",
  "audio": {
    "asset": "audio/cars/flat-six-idle.m4a",
    "durationMs": 5000,
    "license": "original-swoond",
    "description": "A low, burbling idle with an uneven, slightly rattly rhythm and a soft, flat-sounding rev.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Inline-four"
    },
    {
      "id": "b",
      "text": "Flat-six"
    },
    {
      "id": "c",
      "text": "V8"
    },
    {
      "id": "d",
      "text": "Electric motor"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "A boxer or flat engine makes a distinctive, burbling, slightly uneven note. The pistons work horizontally, and the exhaust pulses do not merge evenly.",
    "incorrect": "Listen for a low, rumbly burble. An inline-four is buzzier and a V8 has a deeper, thumping pulse."
  },
  "listenFor": [
    "Low burble",
    "Uneven pulse",
    "Soft rev"
  ]
}
```

**Sample 2** (lesson `ev-07`)

```json
{
  "prompt": "Which one is an electric car pulling away?",
  "audio": {
    "asset": "audio/cars/ev-pull-away.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "A smooth rising whine with no gear changes and no rumble, plus tire and wind noise.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Diesel truck"
    },
    {
      "id": "b",
      "text": "Electric car"
    },
    {
      "id": "c",
      "text": "Two-stroke scooter"
    },
    {
      "id": "d",
      "text": "V8"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "An EV has no gear shifts or exhaust rumble. The rising whine comes from the motor and inverter.",
    "incorrect": "Listen for the smooth whine with no shift points. Combustion engines have a pulse and shift."
  },
  "listenFor": [
    "Smooth rise",
    "No shifts",
    "Tire noise"
  ]
}
```

**Sample 3** (lesson `dt-04`)

```json
{
  "prompt": "Which one is a dual-clutch gearbox shifting?",
  "audio": {
    "asset": "audio/cars/dct-upshift.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "A fast rev climb, a sharp, near-instant shift with a small pop, then rev climb again.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Manual with a slow shift"
    },
    {
      "id": "b",
      "text": "CVT holding revs"
    },
    {
      "id": "c",
      "text": "Dual-clutch"
    },
    {
      "id": "d",
      "text": "Torque-converter auto with slur"
    }
  ],
  "correctOptionId": "c",
  "explanation": {
    "correct": "A dual-clutch has two clutches pre-selecting gears, so shifts are near-instant with a small crisp pop.",
    "incorrect": "A CVT hums at one rev band and a torque-converter auto slurs. A dual-clutch snaps."
  },
  "listenFor": [
    "Crisp shift",
    "Near-instant",
    "Small pop"
  ]
}
```

### 2.12 `estimate-slider`

Magnitudes with tolerance bands (percent, mi/kWh, seconds).

**Sample 1** (lesson `ow-02`)

```json
{
  "prompt": "How much value does a new car typically lose in year one?",
  "unit": "percent",
  "min": 0,
  "max": 50,
  "step": 5,
  "correctValue": 20,
  "tolerance": {
    "full": 5,
    "partial": 10
  },
  "explanation": {
    "correct": "Roughly a fifth of the price in the first year is typical. The exact number depends on the model and market.",
    "incorrect": "New cars lose value fastest in year one, usually around 15 to 25 percent. That is why used and certified cars can be a bargain."
  }
}
```

**Sample 2** (lesson `ev-02`)

```json
{
  "prompt": "How many miles per kWh does a typical EV get?",
  "unit": "mi/kWh",
  "min": 1,
  "max": 6,
  "step": 0.5,
  "correctValue": 3.5,
  "tolerance": {
    "full": 0.5,
    "partial": 1
  },
  "explanation": {
    "correct": "Most EVs land around 3 to 4 miles per kWh. A bigger battery gives more range, not better efficiency.",
    "incorrect": "Efficiency of typical EVs is around 3 to 4 miles per kWh. Big trucks are lower; small efficient cars are higher.",
    "sayThisLine": "That's about 3.5 miles per kWh."
  }
}
```

**Sample 3** (lesson `bm-03`)

```json
{
  "prompt": "How long is a good stock muscle-car quarter mile?",
  "unit": "seconds",
  "min": 9,
  "max": 18,
  "step": 0.5,
  "correctValue": 12,
  "tolerance": {
    "full": 0.5,
    "partial": 1.5
  },
  "explanation": {
    "correct": "Modern factory muscle cars run around 11 to 13 seconds. Quicker times need serious power and traction.",
    "incorrect": "A modern V8 muscle car runs the quarter mile in about 11 to 13 seconds stock. Exact numbers vary with conditions."
  }
}
```

### 2.13 `hotspot-tap`

Static original diagrams identified by `diagramId`; no motion.

**Sample 1** (lesson `hw-01`)

```json
{
  "prompt": "Tap the piston.",
  "diagram": {
    "diagramId": "engine-cutaway-side",
    "aspectRatio": 1.2,
    "alt": "Cutaway of a single cylinder showing a spark plug at the top, two valves, a piston moving in the cylinder and a crankshaft below."
  },
  "hotspots": [
    {
      "id": "piston",
      "label": "Piston",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.55,
        "r": 0.09
      }
    },
    {
      "id": "plug",
      "label": "Spark plug",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.1,
        "r": 0.07
      }
    },
    {
      "id": "valve",
      "label": "Valve",
      "shape": {
        "kind": "circle",
        "cx": 0.35,
        "cy": 0.2,
        "r": 0.07
      }
    },
    {
      "id": "crank",
      "label": "Crankshaft",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.9,
        "r": 0.09
      }
    }
  ],
  "correctHotspotIds": [
    "piston"
  ],
  "explanation": {
    "correct": "The piston moves up and down in the cylinder and turns the crankshaft through a connecting rod.",
    "incorrect": "Look for the part sliding in the cylinder. The spark plug is at the top and the crankshaft is below.",
    "sayThisLine": "The piston is what the fuel pushes."
  }
}
```

**Sample 2** (lesson `hc-01`)

```json
{
  "prompt": "Tap the tire width.",
  "diagram": {
    "diagramId": "tire-sidewall",
    "aspectRatio": 1.4,
    "alt": "Diagram of a tire sidewall reading 245 slash 40 R 18 with each part of the code circled."
  },
  "hotspots": [
    {
      "id": "width",
      "label": "Width (245)",
      "shape": {
        "kind": "circle",
        "cx": 0.2,
        "cy": 0.5,
        "r": 0.1
      }
    },
    {
      "id": "aspect",
      "label": "Aspect ratio (40)",
      "shape": {
        "kind": "circle",
        "cx": 0.45,
        "cy": 0.5,
        "r": 0.1
      }
    },
    {
      "id": "rim",
      "label": "Rim size (18)",
      "shape": {
        "kind": "circle",
        "cx": 0.85,
        "cy": 0.5,
        "r": 0.1
      }
    },
    {
      "id": "load",
      "label": "Load rating",
      "shape": {
        "kind": "circle",
        "cx": 0.65,
        "cy": 0.85,
        "r": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "width"
  ],
  "explanation": {
    "correct": "The first number is the tread width in millimeters. Wider usually means more grip and more road noise.",
    "incorrect": "The first number, 245, is width in millimeters. The second is the sidewall height as a percentage.",
    "sayThisLine": "It is a 245-wide, so it has a lot of rubber."
  }
}
```

**Sample 3** (lesson `to-03`)

```json
{
  "prompt": "Tap the approach angle.",
  "diagram": {
    "diagramId": "offroad-angles",
    "aspectRatio": 1.6,
    "alt": "Side diagram of a truck with three angles marked: front approach, middle breakover, and rear departure."
  },
  "hotspots": [
    {
      "id": "approach",
      "label": "Approach angle",
      "shape": {
        "kind": "circle",
        "cx": 0.15,
        "cy": 0.65,
        "r": 0.09
      }
    },
    {
      "id": "breakover",
      "label": "Breakover angle",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.8,
        "r": 0.09
      }
    },
    {
      "id": "departure",
      "label": "Departure angle",
      "shape": {
        "kind": "circle",
        "cx": 0.85,
        "cy": 0.65,
        "r": 0.09
      }
    }
  ],
  "correctHotspotIds": [
    "approach"
  ],
  "explanation": {
    "correct": "The approach angle is how steep an obstacle the front can climb without scraping the bumper.",
    "incorrect": "Approach is at the front. Breakover is the middle and departure is at the rear."
  }
}
```

**Sample 4** (lesson `rc-06`)

```json
{
  "prompt": "Tap the VIN on the dash.",
  "diagram": {
    "diagramId": "vin-locations",
    "aspectRatio": 1.3,
    "alt": "Diagram of a windshield base from outside with a plate at the driver-side corner, a door jamb sticker and an engine bay tag."
  },
  "hotspots": [
    {
      "id": "dash",
      "label": "Windshield corner plate",
      "shape": {
        "kind": "circle",
        "cx": 0.15,
        "cy": 0.3,
        "r": 0.09
      }
    },
    {
      "id": "jamb",
      "label": "Door jamb sticker",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.7,
        "r": 0.09
      }
    },
    {
      "id": "engine",
      "label": "Engine bay tag",
      "shape": {
        "kind": "circle",
        "cx": 0.85,
        "cy": 0.3,
        "r": 0.09
      }
    }
  ],
  "correctHotspotIds": [
    "dash"
  ],
  "explanation": {
    "correct": "The VIN is visible through the windshield at the driver-side corner. The same 17 characters are on the door jamb sticker and paperwork.",
    "incorrect": "Look through the windshield at the driver-side corner. The plate there holds the 17-digit VIN."
  }
}
```

## 3. Playbook terms (75)

The Playbook shows each term with a definition and an example line in the voice of the person she is learning for (the person who loves cars). Lines are what her person might say; they are never what the learner should fake. Terms unlock on first use; Term Blitz reviews draw from unlocked terms.

| # | Term | Definition | Example line (her person's voice) |
|---|---|---|---|
| 1 | Four-stroke | The engine cycle: intake, compression, power, exhaust. | "It's a regular four-stroke, nothing exotic." |
| 2 | Displacement | The total volume of the engine's cylinders, in liters. | "It's five liters of displacement, so it's thirsty." |
| 3 | Horsepower | How much work the engine can do per second; torque times revs. | "It makes 400 horsepower up top." |
| 4 | Torque | The twisting force at the crank; the shove you feel. | "All that low-end torque is why it launches so well." |
| 5 | Power band | The rev range where the engine makes its best power. | "It only comes alive in the top of the power band." |
| 6 | Redline | The maximum safe engine speed. | "I love running it to redline." |
| 7 | Naturally aspirated (NA) | An engine with no turbo or supercharger. | "I'm keeping it naturally aspirated." |
| 8 | Turbocharger | An exhaust-driven pump that forces more air into the engine. | "The turbo kicks in around three grand." |
| 9 | Turbo lag | The delay before boost arrives. | "There is a little turbo lag off the line." |
| 10 | Supercharger | A belt-driven pump that forces more air in. | "I love the whine of the supercharger." |
| 11 | Boost | Extra air pressure forced in by a turbo or supercharger. | "We are running about 18 psi of boost." |
| 12 | Octane | A fuel rating for resistance to knock. | "It needs premium, 91 octane." |
| 13 | Inline / V / flat | Engine layouts by cylinder arrangement. | "It's a flat-six, so it sits low." |
| 14 | Rotary | A spinning-triangle engine used by Mazda. | "The rotary revs like nothing else." |
| 15 | Clutch | The coupling between engine and gearbox in a manual. | "The clutch is heavy in traffic." |
| 16 | Bite point | Where the clutch starts to grab. | "I keep missing the bite point." |
| 17 | Rev-matching | Blipping the throttle to match revs on a downshift. | "I always rev-match on downshifts." |
| 18 | Dual-clutch (DCT) | An automatic with two clutches for fast shifts. | "The dual-clutch is snappy but jerky in traffic." |
| 19 | CVT | A gearbox with no fixed gears. | "The CVT hums but it's smooth." |
| 20 | Torque converter | The fluid coupling in a traditional automatic. | "It's a torque-converter auto, so it's smooth." |
| 21 | FWD / RWD / AWD | Which wheels are driven: front, rear, all. | "It's RWD, so it wants to slide." |
| 22 | 4WD | Selectable four-wheel drive with low range. | "It has 4WD with a low range for trails." |
| 23 | Differential | The gear set that lets driven wheels turn at different speeds. | "It has a limited-slip diff, so it hooks up." |
| 24 | Limited-slip (LSD) | A differential that shares torque between wheels. | "The LSD makes it so much better on exit." |
| 25 | Understeer | The front runs wide; "it pushes". | "It just understeers in every corner." |
| 26 | Oversteer | The rear steps out; the car rotates. | "It oversteers when I get on the throttle." |
| 27 | Weight transfer | Load shifting front to rear or side to side. | "Braking transfers weight to the front." |
| 28 | Coilovers | Adjustable spring-and-damper suspension. | "I put coilovers on." |
| 29 | Sway bar | An anti-roll bar that reduces body lean. | "A thicker sway bar helped the lean." |
| 30 | Downforce | Aerodynamic force pushing the car down. | "The wing gives real downforce." |
| 31 | Regen | Regenerative braking that recovers energy. | "Regen does most of my braking." |
| 32 | One-pedal driving | Driving an EV mainly with the accelerator. | "I basically drive one-pedal." |
| 33 | kWh | Kilowatt-hour; a unit of battery energy. | "It has an 82 kWh pack." |
| 34 | Level 2 charging | A 240-volt AC charger, often at home. | "I have a Level 2 in the garage." |
| 35 | DC fast charging | High-power charging for trips. | "I fast charged from 10 to 80 in 25 minutes." |
| 36 | NACS | The North American Charging Standard plug. | "The new one has a NACS port." |
| 37 | HEV | A hybrid that does not plug in. | "It's a regular hybrid." |
| 38 | PHEV | A plug-in hybrid. | "My PHEV does 40 miles on electric." |
| 39 | Range extender | A small engine that makes electricity for the wheels. | "It has a range extender." |
| 40 | Sedan | A car with a separate trunk and four doors. | "It's a sedan, not a hatch." |
| 41 | Coupe | A two-door with a fixed roof. | "I love a good coupe." |
| 42 | Hatchback | A car with a rear door that lifts with the glass. | "It's a hot hatch." |
| 43 | Wagon | A long-roof car with cargo space. | "Nothing beats a wagon." |
| 44 | Crossover | A tall car built like a car. | "It's a crossover, not a real SUV." |
| 45 | Body-on-frame | A body mounted on a separate ladder frame. | "It's body-on-frame, so it tows." |
| 46 | Convertible | A car with a fold-away roof. | "Top down, obviously." |
| 47 | Targa | A removable roof panel with a fixed roll structure. | "It's a targa." |
| 48 | Fastback | A roofline that slopes smoothly to the tail. | "That fastback roofline is perfect." |
| 49 | Pony car | A compact, sporty American coupe. | "A Mustang started the pony-car class." |
| 50 | Muscle car | A big V8 car with a focus on straight-line power. | "It's a muscle car through and through." |
| 51 | Hot hatch | A sporty hatchback. | "It's my hot hatch." |
| 52 | Kei car | A tiny Japanese car class. | "I want a kei truck." |
| 53 | Grand tourer (GT) | A fast, comfortable long-distance car. | "It's a GT, not a track car." |
| 54 | Supercar | An exotic high-performance car. | "That's a proper supercar." |
| 55 | Generation | A car's all-new design cycle. | "It's the third generation." |
| 56 | Facelift | A mid-cycle styling update. | "It got a facelift in 2019." |
| 57 | Trim level | A version of a model with a set of features. | "It's the top trim." |
| 58 | Chassis code | A short code for a model generation. | "It's an E46." |
| 59 | VIN | The 17-character vehicle identification number. | "I ran the VIN on it." |
| 60 | Depreciation | Value lost over time. | "It depreciates fast." |
| 61 | Certified pre-owned (CPO) | A used car inspected and warrantied by the maker. | "I bought a CPO." |
| 62 | Recall | A maker-issued fix for a known defect. | "They issued a recall." |
| 63 | Restomod | An old body with modern parts. | "It's a restomod." |
| 64 | Survivor | A well-kept original car. | "It's a survivor." |
| 65 | Patina | Honest wear that shows age. | "I love the patina." |
| 66 | Matching numbers | A car with its original drivetrain. | "It's matching numbers." |
| 67 | Concours | A judged show of very original or restored cars. | "It won at the concours." |
| 68 | Stage 1 | A modest tune plus bolt-ons. | "It's Stage 1." |
| 69 | Sleeper | A quiet-looking fast car. | "It's a sleeper." |
| 70 | OEM+ | Factory-style upgrades. | "I'm going for OEM+." |
| 71 | Stance | Lowered and fitted wheels for looks. | "It's all about the stance." |
| 72 | JDM | Built for the Japanese Domestic Market. | "It's a real JDM car." |
| 73 | Homologation special | A road car built so a race version is legal. | "It's a homologation special." |
| 74 | Track day | A supervised event for driving on a circuit. | "I have a track day this weekend." |
| 75 | Cars and Coffee | A casual morning meet. | "Cars and Coffee is at seven." |

## 4. Talk Track scenarios (9)

Each scenario has the enthusiast's opening line, what it means, three reply styles per exchange (**good**, **meh**, **cringe**) with coach notes, and the payload JSON. Smooth starts at 50; a run succeeds at 60 or more. Good replies model honest curiosity; cringe replies dismiss the car, fake expertise, or push the person. These are conversation practice, not scripts to impersonate an expert (spec section 13).

### 4.1 First ride (`tt-first-ride`)

- **Setting:** She picks you up in her car for the first time.
- **Enthusiast opening:** "Okay, moment of truth. It's a 2.0T with a six-speed. Try not to stall it. Kidding. Mostly."
- **What it means:** She drives a small turbocharged four-cylinder with a manual gearbox and is proud of it. Terms: 2.0T (displacement + turbo), six-speed, manual.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "A manual? I love that you drive stick. Is the clutch light?" | +25 | Asked about her experience of the car, not the spec. |
| 1 | meh | "Wait, what does the T mean?" | +8 | Honest. Try to guess: turbo is a safe guess. |
| 1 | cringe | "Manuals are so outdated, why not an automatic?" | -18 | Do not dismiss a manual to an owner who chose it. |
| 2 | good | "What does a high bite point feel like?" | +22 | Curiosity beats guessing. You learn the term from her. |
| 2 | meh | "I probably would stall it." | +8 | Humble and fine. Ask about the first stall next. |
| 2 | cringe | "Just put it in automatic then." | -15 | There is no 'just' with a manual; ask, do not fix. |

```json
{
  "title": "First ride",
  "setting": "She picks you up in her car for the first time.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Okay, moment of truth. It's a 2.0T with a six-speed. Try not to stall it. Kidding. Mostly.",
      "replies": [
        {
          "id": "good",
          "text": "A manual? I love that you drive stick. Is the clutch light?",
          "smoothDelta": 25,
          "theirResponse": "Ha, yes. It's light and the bite is really high. Nobody else notices!",
          "coachNote": "Asked about her experience of the car, not the spec."
        },
        {
          "id": "meh",
          "text": "Wait, what does the T mean?",
          "smoothDelta": 8,
          "theirResponse": "Turbo! It's a little turbo four. Makes more power than it should.",
          "coachNote": "Honest. Try to guess: turbo is a safe guess."
        },
        {
          "id": "cringe",
          "text": "Manuals are so outdated, why not an automatic?",
          "smoothDelta": -18,
          "theirResponse": "...okay. The gearbox is half the reason I bought it.",
          "coachNote": "Do not dismiss a manual to an owner who chose it."
        }
      ]
    },
    {
      "theirMessage": "The clutch is light and the bite is really high. Most people can't stand it.",
      "replies": [
        {
          "id": "good",
          "text": "What does a high bite point feel like?",
          "smoothDelta": 22,
          "theirResponse": "Like the pedal only grabs near the top. You feel it in your ankle.",
          "coachNote": "Curiosity beats guessing. You learn the term from her."
        },
        {
          "id": "meh",
          "text": "I probably would stall it.",
          "smoothDelta": 8,
          "theirResponse": "Everybody does at first. It's a rite of passage.",
          "coachNote": "Humble and fine. Ask about the first stall next."
        },
        {
          "id": "cringe",
          "text": "Just put it in automatic then.",
          "smoothDelta": -15,
          "theirResponse": "That's not how any of this works.",
          "coachNote": "There is no 'just' with a manual; ask, do not fix."
        }
      ]
    }
  ],
  "closingNote": "A manual gearbox has a clutch you operate yourself. The bite point is where the clutch starts to grab."
}
```

### 4.2 The mod story (`tt-mod-story`)

- **Setting:** She sends a message about her weekend project.
- **Enthusiast opening:** "Finally got the coilovers on and it sits so right now. No more wheel gap!"
- **What it means:** She replaced the springs and dampers with an adjustable set and lowered the car. Terms: coilovers, ride height, wheel gap.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Nice, did you go for looks or for the track?" | +25 | Asked her goal. That is the question builders love. |
| 1 | meh | "Cool, is it lower now?" | +8 | Fine and safe. Try asking why. |
| 1 | cringe | "That must be so bumpy. I hate lowered cars." | -18 | Do not lead with your taste about her build. |
| 2 | good | "Do you have to align it after lowering?" | +22 | Restating what you learned shows you listened. |
| 2 | meh | "So it will be more expensive?" | +5 | Fine, but you missed the chance to ask about the feel. |
| 2 | cringe | "You could have just bought the springs." | -15 | Do not correct what you have not done. |

```json
{
  "title": "The mod story",
  "setting": "She sends a message about her weekend project.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Finally got the coilovers on and it sits so right now. No more wheel gap!",
      "replies": [
        {
          "id": "good",
          "text": "Nice, did you go for looks or for the track?",
          "smoothDelta": 25,
          "theirResponse": "Mostly looks, honestly, but it handles so much flatter too.",
          "coachNote": "Asked her goal. That is the question builders love."
        },
        {
          "id": "meh",
          "text": "Cool, is it lower now?",
          "smoothDelta": 8,
          "theirResponse": "Yes, about an inch. Feels different.",
          "coachNote": "Fine and safe. Try asking why."
        },
        {
          "id": "cringe",
          "text": "That must be so bumpy. I hate lowered cars.",
          "smoothDelta": -18,
          "theirResponse": "...okay. It rides fine, actually.",
          "coachNote": "Do not lead with your taste about her build."
        }
      ]
    },
    {
      "theirMessage": "Mostly looks, honestly, but it handles flatter too. Alignment next.",
      "replies": [
        {
          "id": "good",
          "text": "Do you have to align it after lowering?",
          "smoothDelta": 22,
          "theirResponse": "Yes! Camber gets off. Thanks for asking.",
          "coachNote": "Restating what you learned shows you listened."
        },
        {
          "id": "meh",
          "text": "So it will be more expensive?",
          "smoothDelta": 5,
          "theirResponse": "A bit. Worth it.",
          "coachNote": "Fine, but you missed the chance to ask about the feel."
        },
        {
          "id": "cringe",
          "text": "You could have just bought the springs.",
          "smoothDelta": -15,
          "theirResponse": "Wow. That is not how that works.",
          "coachNote": "Do not correct what you have not done."
        }
      ]
    }
  ],
  "closingNote": "Coilovers are an adjustable spring-and-damper combination. Lowering a car changes its ride height and alignment."
}
```

### 4.3 Manual vs EV (`tt-manual-ev`)

- **Setting:** A friendly debate breaks out at dinner.
- **Enthusiast opening:** "Would you ever buy an EV? I would miss the shifting too much."
- **What it means:** He is a manual fan who is skeptical of EVs. This is a friendly debate; terms: manual, EV, feel.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "What would you miss most, the sound or the engagement?" | +25 | You asked a specific question and allowed nuance. |
| 1 | meh | "I do not know, what do you think?" | +8 | Honest, warm. Offer a small view next time. |
| 1 | cringe | "EVs are just better, honestly." | -18 | Do not turn a chat into a verdict. |
| 2 | good | "Instant torque feels like a shove from a standstill, right?" | +25 | You used the term correctly and stayed curious. |
| 2 | meh | "So is it fun then?" | +5 | Fine. A follow-up about what surprised him would land better. |
| 2 | cringe | "So you would sell your manual?" | -15 | Do not push someone to pick a side. |

```json
{
  "title": "Manual vs EV",
  "setting": "A friendly debate breaks out at dinner.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Would you ever buy an EV? I would miss the shifting too much.",
      "replies": [
        {
          "id": "good",
          "text": "What would you miss most, the sound or the engagement?",
          "smoothDelta": 25,
          "theirResponse": "Both! But honestly the EV torque is addictive.",
          "coachNote": "You asked a specific question and allowed nuance."
        },
        {
          "id": "meh",
          "text": "I do not know, what do you think?",
          "smoothDelta": 8,
          "theirResponse": "Ha, fair. I think I'd try one.",
          "coachNote": "Honest, warm. Offer a small view next time."
        },
        {
          "id": "cringe",
          "text": "EVs are just better, honestly.",
          "smoothDelta": -18,
          "theirResponse": "Okay, wow, the debate club is in session.",
          "coachNote": "Do not turn a chat into a verdict."
        }
      ]
    },
    {
      "theirMessage": "Both! But the instant torque is addictive. I test drove one and laughed.",
      "replies": [
        {
          "id": "good",
          "text": "Instant torque feels like a shove from a standstill, right?",
          "smoothDelta": 25,
          "theirResponse": "Exactly. No revs to wait for. It's a very different fun.",
          "coachNote": "You used the term correctly and stayed curious."
        },
        {
          "id": "meh",
          "text": "So is it fun then?",
          "smoothDelta": 5,
          "theirResponse": "Yes, in a different way.",
          "coachNote": "Fine. A follow-up about what surprised him would land better."
        },
        {
          "id": "cringe",
          "text": "So you would sell your manual?",
          "smoothDelta": -15,
          "theirResponse": "No! I said different, not better.",
          "coachNote": "Do not push someone to pick a side."
        }
      ]
    }
  ],
  "closingNote": "Both can be fun in different ways: manuals are about engagement, EVs about instant torque."
}
```

### 4.4 At the meet (`tt-meet-owner`)

- **Setting:** You walk up to an owner at a Saturday meet.
- **Enthusiast opening:** "Hi. Yes, it is a 1991 with the original engine. Ask away."
- **What it means:** A friendly owner of an early-90s car invites questions. Terms: original engine, generation, provenance.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "She is beautiful. What is your favorite thing about it?" | +25 | An open question that invites a story. |
| 1 | meh | "Is it worth a lot?" | -5 | A price question can feel blunt. Warm it up first. |
| 1 | cringe | "Is it fast?" | -8 | Not wrong, but it invites a spec answer, not a story. |
| 2 | good | "Thanks, may I have a look? What is the last thing you fixed?" | +25 | Asking permission and asking about upkeep shows respect. |
| 2 | meh | "I would love to take a photo." | +10 | Polite. Keep asking about the car too. |
| 2 | cringe | "Can I touch the engine?" | -18 | Ask before touching. Never assume. |

```json
{
  "title": "At the meet",
  "setting": "You walk up to an owner at a Saturday meet.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Hi. Yes, it is a 1991 with the original engine. Ask away.",
      "replies": [
        {
          "id": "good",
          "text": "She is beautiful. What is your favorite thing about it?",
          "smoothDelta": 25,
          "theirResponse": "The sound. And how simple it is. No screens.",
          "coachNote": "An open question that invites a story."
        },
        {
          "id": "meh",
          "text": "Is it worth a lot?",
          "smoothDelta": -5,
          "theirResponse": "Ha. To me, more than money. But it depends.",
          "coachNote": "A price question can feel blunt. Warm it up first."
        },
        {
          "id": "cringe",
          "text": "Is it fast?",
          "smoothDelta": -8,
          "theirResponse": "It's fun. Fast is relative.",
          "coachNote": "Not wrong, but it invites a spec answer, not a story."
        }
      ]
    },
    {
      "theirMessage": "The sound, and it is simple. Hood is up if you want to see.",
      "replies": [
        {
          "id": "good",
          "text": "Thanks, may I have a look? What is the last thing you fixed?",
          "smoothDelta": 25,
          "theirResponse": "Water pump. It's an easy job. Come look.",
          "coachNote": "Asking permission and asking about upkeep shows respect."
        },
        {
          "id": "meh",
          "text": "I would love to take a photo.",
          "smoothDelta": 10,
          "theirResponse": "Sure, just watch the mirror.",
          "coachNote": "Polite. Keep asking about the car too."
        },
        {
          "id": "cringe",
          "text": "Can I touch the engine?",
          "smoothDelta": -18,
          "theirResponse": "Hands off, please. Sorry!",
          "coachNote": "Ask before touching. Never assume."
        }
      ]
    }
  ],
  "closingNote": "Meets are social: ask about the story, ask before touching, and let the owner lead."
}
```

### 4.5 "Should I buy this one?" (`tt-buy-advice`)

- **Setting:** She sends you a listing.
- **Enthusiast opening:** "Found a 2016 Mustang GT with 60k miles. Thoughts?"
- **What it means:** She wants an opinion on a used performance car. Terms: GT (V8 trim), mileage, pre-purchase inspection.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ooh, nice. Do you have the service history? And would you get it inspected?" | +25 | A humble, useful reply. Inspections are the honest advice. |
| 1 | meh | "It looks cool!" | +8 | Warm but thin. Follow with a question. |
| 1 | cringe | "That is an amazing deal, buy it." | -20 | Never push a purchase without facts. |
| 2 | good | "Mileage matters less than how it was maintained. That is what the history tells you." | +22 | You gave a simple, honest principle without faking expertise. |
| 2 | meh | "I have no idea, honestly." | +10 | Honest and totally fine. You can also offer to come along. |
| 2 | cringe | "60k is nothing, they run forever." | -15 | Overconfident. Keep claims modest. |

```json
{
  "title": "\"Should I buy this one?\"",
  "setting": "She sends you a listing.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Found a 2016 Mustang GT with 60k miles. Thoughts?",
      "replies": [
        {
          "id": "good",
          "text": "Ooh, nice. Do you have the service history? And would you get it inspected?",
          "smoothDelta": 25,
          "theirResponse": "Great questions. I'll ask.",
          "coachNote": "A humble, useful reply. Inspections are the honest advice."
        },
        {
          "id": "meh",
          "text": "It looks cool!",
          "smoothDelta": 8,
          "theirResponse": "Right? Okay but what about the mileage?",
          "coachNote": "Warm but thin. Follow with a question."
        },
        {
          "id": "cringe",
          "text": "That is an amazing deal, buy it.",
          "smoothDelta": -20,
          "theirResponse": "Um, you have not even seen it.",
          "coachNote": "Never push a purchase without facts."
        }
      ]
    },
    {
      "theirMessage": "Service history is a good idea. Should I worry about the miles?",
      "replies": [
        {
          "id": "good",
          "text": "Mileage matters less than how it was maintained. That is what the history tells you.",
          "smoothDelta": 22,
          "theirResponse": "That's a good point. I'll ask.",
          "coachNote": "You gave a simple, honest principle without faking expertise."
        },
        {
          "id": "meh",
          "text": "I have no idea, honestly.",
          "smoothDelta": 10,
          "theirResponse": "Fair! I'll ask a shop.",
          "coachNote": "Honest and totally fine. You can also offer to come along."
        },
        {
          "id": "cringe",
          "text": "60k is nothing, they run forever.",
          "smoothDelta": -15,
          "theirResponse": "...is that true for every car?",
          "coachNote": "Overconfident. Keep claims modest."
        }
      ]
    }
  ],
  "closingNote": "A pre-purchase inspection by an independent shop is the boring, best advice."
}
```

### 4.6 Recall letter (`tt-recall`)

- **Setting:** She is worried about a recall notice.
- **Enthusiast opening:** "Got a recall letter for my car. Is that bad?"
- **What it means:** She received a manufacturer recall notice. Terms: recall, safety defect, dealer repair at no cost.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "A recall means the maker found a problem and will fix it free. Do you know what it covers?" | +25 | You explained calmly without alarming her. |
| 1 | meh | "Ugh, that sounds scary. Sorry!" | +8 | Warm but not helpful. Add one calm fact. |
| 1 | cringe | "Just ignore it, it's fine." | -20 | Never tell someone to ignore a safety recall. |
| 2 | good | "Do you want me to help you find the appointment page?" | +25 | A practical, kind offer. |
| 2 | meh | "Wow, so do you have to pay?" | +5 | Fine. An offer to help would land better. |
| 2 | cringe | "My friend's car exploded from that." | -20 | Do not amplify fear. |

```json
{
  "title": "Recall letter",
  "setting": "She is worried about a recall notice.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Got a recall letter for my car. Is that bad?",
      "replies": [
        {
          "id": "good",
          "text": "A recall means the maker found a problem and will fix it free. Do you know what it covers?",
          "smoothDelta": 25,
          "theirResponse": "Airbag inflator, apparently. They'll fix it free.",
          "coachNote": "You explained calmly without alarming her."
        },
        {
          "id": "meh",
          "text": "Ugh, that sounds scary. Sorry!",
          "smoothDelta": 8,
          "theirResponse": "Thanks. It is a bit scary.",
          "coachNote": "Warm but not helpful. Add one calm fact."
        },
        {
          "id": "cringe",
          "text": "Just ignore it, it's fine.",
          "smoothDelta": -20,
          "theirResponse": "...I don't think I should.",
          "coachNote": "Never tell someone to ignore a safety recall."
        }
      ]
    },
    {
      "theirMessage": "Airbag inflator. They say to make an appointment.",
      "replies": [
        {
          "id": "good",
          "text": "Do you want me to help you find the appointment page?",
          "smoothDelta": 25,
          "theirResponse": "That would be so kind.",
          "coachNote": "A practical, kind offer."
        },
        {
          "id": "meh",
          "text": "Wow, so do you have to pay?",
          "smoothDelta": 5,
          "theirResponse": "No, it's free.",
          "coachNote": "Fine. An offer to help would land better."
        },
        {
          "id": "cringe",
          "text": "My friend's car exploded from that.",
          "smoothDelta": -20,
          "theirResponse": "...that is not helping.",
          "coachNote": "Do not amplify fear."
        }
      ]
    }
  ],
  "closingNote": "A recall is a free fix for a known problem. Follow the notice and book the repair."
}
```

### 4.7 Charging talk (`tt-ev-charging`)

- **Setting:** She talks about her EV commute.
- **Enthusiast opening:** "Level 2 at home is a game changer. I never think about gas."
- **What it means:** She is happy with home charging and overnight refills. Terms: Level 2, home charging.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Does it charge fully overnight?" | +25 | Shows you understand overnight charging. |
| 1 | meh | "Do you charge every day?" | +8 | Fine, generic. |
| 1 | cringe | "EVs are so annoying for road trips." | -15 | Do not lead with a complaint she did not ask about. |
| 2 | good | "How do you plan long trips?" | +25 | Curious about her method, not lecturing. |
| 2 | meh | "It sounds like a hassle." | +5 | Fine, but it sounds negative. |
| 2 | cringe | "Just get a hybrid." | -18 | Never suggest she swap what she loves. |

```json
{
  "title": "Charging talk",
  "setting": "She talks about her EV commute.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Level 2 at home is a game changer. I never think about gas.",
      "replies": [
        {
          "id": "good",
          "text": "Does it charge fully overnight?",
          "smoothDelta": 25,
          "theirResponse": "Yes! Wake up to a full battery every day.",
          "coachNote": "Shows you understand overnight charging."
        },
        {
          "id": "meh",
          "text": "Do you charge every day?",
          "smoothDelta": 8,
          "theirResponse": "Most days, yes.",
          "coachNote": "Fine, generic."
        },
        {
          "id": "cringe",
          "text": "EVs are so annoying for road trips.",
          "smoothDelta": -15,
          "theirResponse": "...I do fine on trips, thanks.",
          "coachNote": "Do not lead with a complaint she did not ask about."
        }
      ]
    },
    {
      "theirMessage": "Full every morning. Road trips need planning though.",
      "replies": [
        {
          "id": "good",
          "text": "How do you plan long trips?",
          "smoothDelta": 25,
          "theirResponse": "I use an app to find fast chargers with a buffer.",
          "coachNote": "Curious about her method, not lecturing."
        },
        {
          "id": "meh",
          "text": "It sounds like a hassle.",
          "smoothDelta": 5,
          "theirResponse": "Sometimes. It's improving.",
          "coachNote": "Fine, but it sounds negative."
        },
        {
          "id": "cringe",
          "text": "Just get a hybrid.",
          "smoothDelta": -18,
          "theirResponse": "I like my EV, thanks.",
          "coachNote": "Never suggest she swap what she loves."
        }
      ]
    }
  ],
  "closingNote": "Level 2 charging happens overnight at home; fast charging is for trips."
}
```

### 4.8 The import (`tt-jdm`)

- **Setting:** She shows you a car she is saving for.
- **Enthusiast opening:** "Saving up for an R34. Just became legal to import, so the prices are going wild."
- **What it means:** She wants a late-90s Japanese sports car that has just become eligible for US import under the 25-year rule. Terms: R34, JDM, 25-year rule.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Is that the 25-year rule? Is yours a 2001?" | +25 | You connected the rule to the car and asked a specific question. |
| 1 | meh | "What is an R34?" | +8 | Honest and fine. Follow with why she loves it. |
| 1 | cringe | "Isn't it illegal to import old cars?" | -15 | Do not assume something is illegal. |
| 2 | good | "What is it about the R34 that gets you?" | +25 | You asked about her love, not the price. |
| 2 | meh | "Is it expensive?" | +0 | Not bad, but it drifts to money. |
| 2 | cringe | "Isn't it just a Fast and Furious car?" | -18 | Do not reduce her car to a movie. |

```json
{
  "title": "The import",
  "setting": "She shows you a car she is saving for.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Saving up for an R34. Just became legal to import, so the prices are going wild.",
      "replies": [
        {
          "id": "good",
          "text": "Is that the 25-year rule? Is yours a 2001?",
          "smoothDelta": 25,
          "theirResponse": "Yes! Built in 2001, and it's the last year to open up.",
          "coachNote": "You connected the rule to the car and asked a specific question."
        },
        {
          "id": "meh",
          "text": "What is an R34?",
          "smoothDelta": 8,
          "theirResponse": "A Nissan Skyline GT-R. It's a legend.",
          "coachNote": "Honest and fine. Follow with why she loves it."
        },
        {
          "id": "cringe",
          "text": "Isn't it illegal to import old cars?",
          "smoothDelta": -15,
          "theirResponse": "...no, that's exactly what the rule allows.",
          "coachNote": "Do not assume something is illegal."
        }
      ]
    },
    {
      "theirMessage": "A Nissan Skyline GT-R, built in 2001. Rare and I love the sound.",
      "replies": [
        {
          "id": "good",
          "text": "What is it about the R34 that gets you?",
          "smoothDelta": 25,
          "theirResponse": "The way it drives, honestly. And that it's the last analog GT-R.",
          "coachNote": "You asked about her love, not the price."
        },
        {
          "id": "meh",
          "text": "Is it expensive?",
          "smoothDelta": 0,
          "theirResponse": "Wildly. Yes.",
          "coachNote": "Not bad, but it drifts to money."
        },
        {
          "id": "cringe",
          "text": "Isn't it just a Fast and Furious car?",
          "smoothDelta": -18,
          "theirResponse": "Ok, that's a clich\u00e9, but no.",
          "coachNote": "Do not reduce her car to a movie."
        }
      ]
    }
  ],
  "closingNote": "The 25-year rule lets a car be imported once it is 25 years old by build month."
}
```

### 4.9 Track day (`tt-track-day`)

- **Setting:** She is nervous and excited about her first track day.
- **Enthusiast opening:** "First track day next weekend. My brake pads are new, my tires are fresh, and I am nervous."
- **What it means:** She is preparing for an organized track day. Terms: track day, brake pads, tires, safety inspection.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Congratulations! Is it with an organized group with instructors?" | +25 | You asked the safety question without being a nag. |
| 1 | meh | "Wow, that is a big step." | +8 | Kind and supportive. Add one question. |
| 1 | cringe | "You will be so fast!" | -15 | Do not make it about speed. |
| 2 | good | "What are you most looking forward to?" | +25 | Warm and open. |
| 2 | meh | "Are you going to win?" | -18 | Track days are not races. Ask what she wants to learn. |
| 2 | cringe | "Take a picture for me!" | +5 | Sweet, and safe. |

```json
{
  "title": "Track day",
  "setting": "She is nervous and excited about her first track day.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "First track day next weekend. My brake pads are new, my tires are fresh, and I am nervous.",
      "replies": [
        {
          "id": "good",
          "text": "Congratulations! Is it with an organized group with instructors?",
          "smoothDelta": 25,
          "theirResponse": "Yes, a club event with instructors.",
          "coachNote": "You asked the safety question without being a nag."
        },
        {
          "id": "meh",
          "text": "Wow, that is a big step.",
          "smoothDelta": 8,
          "theirResponse": "It is! Thanks.",
          "coachNote": "Kind and supportive. Add one question."
        },
        {
          "id": "cringe",
          "text": "You will be so fast!",
          "smoothDelta": -15,
          "theirResponse": "I'm not going for fast. I want to learn.",
          "coachNote": "Do not make it about speed."
        }
      ]
    },
    {
      "theirMessage": "Yes, a club event with an instructor and a tech inspection.",
      "replies": [
        {
          "id": "good",
          "text": "What are you most looking forward to?",
          "smoothDelta": 25,
          "theirResponse": "The braking zones. I'm a little terrified.",
          "coachNote": "Warm and open."
        },
        {
          "id": "meh",
          "text": "Are you going to win?",
          "smoothDelta": -18,
          "theirResponse": "It is not a race!",
          "coachNote": "Track days are not races. Ask what she wants to learn."
        },
        {
          "id": "cringe",
          "text": "Take a picture for me!",
          "smoothDelta": 5,
          "theirResponse": "Ha, will do.",
          "coachNote": "Sweet, and safe."
        }
      ]
    }
  ],
  "closingNote": "Track days are organized, insured events with instructors and inspections, not races."
}
```

## 5. Talk Track roster at launch (20)

The nine scenarios above, plus five to author as standalone Talk tab tracks, plus the six `talk-lab` lesson tracks (`tl-01` to `tl-06`), for 20 in total. Standalone tracks to author: "the road-trip playlist and the engine noise", "her car is at the shop again" (warning lights, reliability), "the parking-lot compliment" (owner questions), "the classic she just inherited" (matching numbers, rust), "the truck and the trailer" (tow ratings; `truck-offroad`). Personalized tracks use `{{make}}` and `{{scene}}`.

## 6. Asset needs (all `original-swoond`)

| Asset | Used by | Notes |
|---|---|---|
| `images/cars/archetype-*.svg` (sedan, coupe, hatch, wagon, SUV, pickup, van, convertible, targa) | visual-id, binary-call | Original vector art; no brand cues; alt text describes features without giving away the answer |
| `images/cars/layout-*.svg` (front, mid, rear engine; FWD, RWD, AWD) | visual-id, hotspot-tap | Cutaway with drive wheels marked in a second channel (pattern) |
| `images/cars/light-signature.svg` and other feature callouts | visual-id | Invented cars showing lighting and grille shapes |
| Diagram ids: `engine-cutaway-side`, `tire-sidewall`, `offroad-angles`, `vin-locations` | hotspot-tap | Procedural or vector; hotspots normalized 0-1 |
| `audio/cars/flat-six-idle.m4a`, `ev-pull-away.m4a`, `dct-upshift.m4a` (+ ~27 more) | listening-id | Original synthesized or self-recorded; `description` present for every clip |

## 7. Voice and safety notes

- Cheeky coach, never mean, one joke per screen, never about the person you care about.
- Never mock a make, a scene, or an owner's choices. Identity is described, not ranked.
- Money, warranty, mods and towing items carry a `safetyNote` and never present as advice; no content teaches fast driving on public roads or removing emissions or safety equipment.
- EV and fire language stays neutral and cited; driver-assist copy says the driver stays responsible.
- Facts that change (model availability, prices, EV share, policy) live in live-data cards, not in static items; items that must cite a number use estimate tolerances and dated notes.
