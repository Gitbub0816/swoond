# NASCAR: Native Exercise Plan (Tier B)

Course `nascar`. All 13 native exercise types are used, each for what it teaches best (spec rule 6). Payloads below are valid against `docs/contracts/native-exercises/v1/<type>.schema.json` (checked with the repo's ajv setup). Estimated counts are course-wide targets across the ~108 lessons and review sets; individual items live in `curriculum/*.json`. Time-sensitive facts are tagged so they can be refreshed each season (see `live-data.md`, `CDS.md` section 6).

## 1. Type usage summary

| Type | How it is used in NASCAR | Est. count | Sample lessons |
|---|---|---|---|
| `multiple-choice` | Default recall and understanding card: rules, formats, terminology. Anchor of Daily Bite and review sets. Every 2026 rule item carries the tag `rules-2026` in curriculum metadata so it can be re-verified each season. | ~260 | `chase-03`, `flow-01`, `tracks-06`, `car-07` |
| `binary-call` | Yes/no rule calls with a small diagram: pit road penalties, free pass eligibility, flat-track lane logic, racing vs wrecking. Never a Unity job: two options, static scene. | ~90 | `pits-02`, `flow-07`, `tracks-07`, `craft-08` |
| `term-match` | Introduce 3-6 terms of one topic: flags, crew roles, track types, manufacturers, aero parts, points vocabulary. | ~40 | `flow-01`, `car-07`, `tracks-02` |
| `sequence-order` | Processes and eras: a four-tire pit stop, the flow of a race, championship-format history, race-weekend schedule. | ~30 | `pits-01`, `chase-06`, `flow-08` |
| `visual-id` | Recognition of track shapes, flags, aero parts, car anatomy, pit-crew roles. All images are original Swoon'd illustrations (`original-swoond`) or licensed; no team liveries, driver photos or sponsor logos unless cleared. | ~55 | `tracks-10`, `flow-01`, `car-05` |
| `decision-scenario` | The native home of strategy judgment: pit calls, blocking, fuel gambles, stage strategy. Paired with the Unity sims in `pits-06`, `craft-02`. `safetyNote` used only where real-world risk could be implied (fuel gambles: professional teams). | ~60 | `pits-06`, `craft-04`, `cult-07` |
| `talk-track` | Conversation practice on every topic: the Talk Lab unit, end-of-unit conversation lessons and the Talk tab. Never canned expert lines; always teaches asking, listening and using a term correctly. | ~45 lesson tracks + 24 Talk tab tracks | `talk-02`, `talk-04`, `talk-03` |
| `timing-tap` | 1D timing feel: pit stop window, pit road entry at speed, restart jump. If the concept needs a scene (drafting, lane choice), it is a Unity sim, not this. | ~15 | `pits-01`, `pits-02`, `craft-02` |
| `say-this` | The signature 'what is she talking about?' item. Heavily used in Enthusiast depth and the live layer. Uses fan slang and current storylines. | ~140 | `talk-06`, `cult-03`, `insd-05`, `live-02` |
| `fill-the-gap` | Terms in context and quick review cards: the Chase sentence, choose rule, tight/loose, horsepower by track type. | ~70 | `chase-04`, `flow-05`, `hand-01`, `car-03` |
| `listening-id` | Spotter calls only, with original synthesized audio (`original-swoond`). No broadcast audio, no real driver radio, no engine recordings from licensed sources. A skip option is always offered. | ~12 | `insd-01`, `insd-01`, `insd-01` |
| `estimate-slider` | Magnitudes: race laps and miles, points values, pit stop seconds, fuel-window laps, horsepower by track type. | ~45 | `laps-and-distance`, `chase-01`, `pits-01` |
| `hotspot-tap` | Fixed diagrams: pit stall positions, grooves on a turn, restart lanes, flag stand and start-finish anatomy, car aero parts. Static only; if cars move, it is a sim. | ~40 | `flow-04`, `tracks-05`, `flow-05` |

Unity-vs-native rule of thumb for this course: if the learner has to watch cars move relative to each other (drafting, lanes, restarts, balance, grooves) it is a Unity sim (`sims/`); everything about vocabulary, rules, recall, ordering, magnitudes, recognition and conversation is native.

## 2. Authoring rules specific to NASCAR

- Prompts <= 12 words; explanation on every answer; a "say this" line where natural.
- Time-sensitive facts (championship format, points values, horsepower packages, schedule, charters) carry a `rules-2026` metadata tag in the curriculum JSON and are re-verified before each season; never hard-code standings, winners, driver teams or current storylines in static lessons.
- No team liveries, sponsor logos, driver photographs or likeness in exercise images unless a license id says so; original illustrations use `original-swoond`.
- Cars in images and sims carry fictional numbers and colors. Real driver and team names appear only in text, only as facts (spec section 39-40), and preferably through `{{tokens}}` filled from live data.
- Never imply the learner should fake expertise: `say-this` items include a `noFakeExpertNote` when a line is advanced.
- Safety: NASCAR crashes are real; wreck content uses calm, factual language and never dwells on injury.

## 3. Sample items per type

### multiple-choice

How it is used: Default recall and understanding card: rules, formats, terminology. Anchor of Daily Bite and review sets. Every 2026 rule item carries the tag `rules-2026` in curriculum metadata so it can be re-verified each season.

**Sample 1** (lesson `chase-03`)

```json
{
  "prompt": "How many drivers make the 2026 Chase?",
  "options": [
    {
      "id": "a",
      "text": "Four"
    },
    {
      "id": "b",
      "text": "Ten"
    },
    {
      "id": "c",
      "text": "Sixteen"
    },
    {
      "id": "d",
      "text": "Twenty-four"
    }
  ],
  "correctOptionIds": [
    "c"
  ],
  "explanation": {
    "correct": "Sixteen drivers, set by points after 26 races. All sixteen stay alive for all ten Chase races; nobody is knocked out.",
    "incorrect": "Sixteen. The regular season points order after 26 races sets the field, and in 2026 no one is eliminated during the Chase.",
    "sayThisLine": "Sixteen of them are in the Chase, and nobody gets cut."
  }
}
```

**Sample 2** (lesson `flow-01`)

```json
{
  "prompt": "What does the white flag mean?",
  "options": [
    {
      "id": "a",
      "text": "Caution, slow down",
      "explanation": "That is yellow."
    },
    {
      "id": "b",
      "text": "One lap to go",
      "explanation": "Yes: the white flag shows one lap remaining."
    },
    {
      "id": "c",
      "text": "Race is over",
      "explanation": "That is the checkered flag."
    },
    {
      "id": "d",
      "text": "Pit road is closed",
      "explanation": "Pit road closure is announced over the radio, not by a white flag."
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "White means one lap left. It is the moment everything gets spicy.",
    "incorrect": "White means one lap to go. Yellow is caution and checkered ends the race.",
    "sayThisLine": "White flag, one to go."
  }
}
```

**Sample 3** (lesson `tracks-06`)

```json
{
  "prompt": "Why is the car behind in a draft faster?",
  "options": [
    {
      "id": "a",
      "text": "It has a bigger engine"
    },
    {
      "id": "b",
      "text": "It pushes through less air"
    },
    {
      "id": "c",
      "text": "It weighs less"
    },
    {
      "id": "d",
      "text": "It has fresher tires"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "The lead car cuts the air, so the trailing car meets less resistance and can go faster for the same effort.",
    "incorrect": "The trailing car is not stronger. The car in front pushes the air aside, so the follower faces less drag.",
    "sayThisLine": "He got a great run off the draft."
  }
}
```

**Sample 4** (lesson `car-07`)

```json
{
  "prompt": "Who tells the driver where other cars are?",
  "options": [
    {
      "id": "a",
      "text": "The crew chief"
    },
    {
      "id": "b",
      "text": "The spotter"
    },
    {
      "id": "c",
      "text": "The jack man"
    },
    {
      "id": "d",
      "text": "The pace car driver"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "The spotter watches from high above the track and calls where cars are: clear, car left, three wide.",
    "incorrect": "That is the spotter's job, from the grandstand roof. The crew chief handles strategy and adjustments.",
    "sayThisLine": "The spotter said he was clear."
  }
}
```

### binary-call

How it is used: Yes/no rule calls with a small diagram: pit road penalties, free pass eligibility, flat-track lane logic, racing vs wrecking. Never a Unity job: two options, static scene.

**Sample 1** (lesson `pits-02`)

```json
{
  "prompt": "He exceeds pit road speed. Penalty?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "nascar-oval-front-stretch",
    "alt": "Overhead diagram of pit road with a speed timing zone; a car crosses it faster than the posted limit.",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.7
      },
      {
        "role": "target",
        "x": 0.5,
        "y": 0.3
      }
    ]
  },
  "choices": [
    {
      "id": "penalty",
      "label": "Penalty"
    },
    {
      "id": "fine",
      "label": "No penalty"
    }
  ],
  "correctChoiceId": "penalty",
  "explanation": {
    "correct": "Speeding on pit road is a penalty. It is timed in zones and usually means a drive-through or a trip to the tail of the field.",
    "incorrect": "Pit road speed is enforced with timing zones. Going over the limit costs the driver track position.",
    "sayThisLine": "He sped on pit road and lost the lead."
  },
  "ruleTag": "Pit road speed"
}
```

**Sample 2** (lesson `flow-07`)

```json
{
  "prompt": "Caution. Lapped car, first one down. Free pass?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "nascar-field-under-caution",
    "alt": "Overhead of the field under caution: the leader, a group of lead-lap cars and a car one lap down at the back.",
    "markers": [
      {
        "role": "player",
        "x": 0.3,
        "y": 0.5
      },
      {
        "role": "opponent",
        "x": 0.7,
        "y": 0.5
      }
    ]
  },
  "choices": [
    {
      "id": "yes",
      "label": "Gets the free pass"
    },
    {
      "id": "no",
      "label": "Stays a lap down"
    }
  ],
  "correctChoiceId": "yes",
  "explanation": {
    "correct": "The first car one lap down under caution takes the free pass and gets back on the lead lap.",
    "incorrect": "The first car one lap down gets the free pass, so it can rejoin the lead lap.",
    "sayThisLine": "He got the free pass and got his lap back."
  }
}
```

**Sample 3** (lesson `tracks-07`)

```json
{
  "prompt": "On a flat track, is a higher lane faster?",
  "scene": {
    "kind": "none",
    "diagramId": "nascar-oval-front-stretch",
    "alt": "Diagram not needed: think about a nearly flat track with a shorter low groove and a longer high groove."
  },
  "choices": [
    {
      "id": "yes",
      "label": "Faster"
    },
    {
      "id": "no",
      "label": "Slower"
    }
  ],
  "correctChoiceId": "no",
  "explanation": {
    "correct": "Without banking to help, the higher lane is only a longer trip. Low is usually quickest on flat tracks.",
    "incorrect": "Higher lanes are longer. Without banking or rubber to help, they lose time.",
    "sayThisLine": "It is flat, so everybody wants the bottom."
  },
  "ruleTag": "Flat track"
}
```

**Sample 4** (lesson `craft-08`)

```json
{
  "prompt": "He gets shoved out of the groove. Racing or wrecking?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "nascar-turn-contact",
    "alt": "Two cars side by side in a turn; the outside car slides up the track after contact from the inside car.",
    "markers": [
      {
        "role": "player",
        "x": 0.4,
        "y": 0.55
      },
      {
        "role": "opponent",
        "x": 0.55,
        "y": 0.5
      }
    ]
  },
  "choices": [
    {
      "id": "racing",
      "label": "Hard racing"
    },
    {
      "id": "wrecking",
      "label": "Wrecking"
    }
  ],
  "correctChoiceId": "racing",
  "explanation": {
    "correct": "Light contact side by side in a turn is part of racing. Payback starts when contact is clearly intentional or reckless.",
    "incorrect": "A little rub while side by side is normal. Fans call it wrecking when it is deliberate or clearly reckless.",
    "sayThisLine": "That was hard racing, nothing more."
  }
}
```

### term-match

How it is used: Introduce 3-6 terms of one topic: flags, crew roles, track types, manufacturers, aero parts, points vocabulary.

**Sample 1** (lesson `flow-01`)

```json
{
  "prompt": "Match the flag to its job.",
  "pairs": [
    {
      "id": "green",
      "term": "Green flag",
      "definition": "Racing starts or resumes"
    },
    {
      "id": "yellow",
      "term": "Yellow flag",
      "definition": "Caution: slow down behind the pace car"
    },
    {
      "id": "red",
      "term": "Red flag",
      "definition": "Race stopped completely"
    },
    {
      "id": "white",
      "term": "White flag",
      "definition": "One lap to go"
    },
    {
      "id": "checkered",
      "term": "Checkered flag",
      "definition": "Race is finished"
    }
  ],
  "distractorDefinitions": [
    "Pit road is closed for the rest of the race"
  ],
  "explanation": {
    "summary": "Green go, yellow slow, red stop, white one lap, checkered done.",
    "sayThisLine": "White flag, one lap to go."
  }
}
```

**Sample 2** (lesson `car-07`)

```json
{
  "prompt": "Match the role to the job.",
  "pairs": [
    {
      "id": "cc",
      "term": "Crew chief",
      "definition": "Calls strategy and adjustments"
    },
    {
      "id": "sp",
      "term": "Spotter",
      "definition": "Tells the driver where cars are"
    },
    {
      "id": "jm",
      "term": "Jack man",
      "definition": "Lifts the car on pit stops"
    },
    {
      "id": "dr",
      "term": "Driver",
      "definition": "Steers and feels the balance"
    }
  ],
  "explanation": {
    "summary": "The driver drives, the spotter watches, the crew chief thinks, the crew works fast."
  }
}
```

**Sample 3** (lesson `tracks-02`)

```json
{
  "prompt": "Match the track type to its personality.",
  "pairs": [
    {
      "id": "short",
      "term": "Short track",
      "definition": "Tight and full of contact"
    },
    {
      "id": "inter",
      "term": "Intermediate",
      "definition": "Aero and handling decide"
    },
    {
      "id": "super",
      "term": "Superspeedway",
      "definition": "Big packs and bigger wrecks"
    },
    {
      "id": "road",
      "term": "Road course",
      "definition": "Left and right turns and braking"
    }
  ],
  "explanation": {
    "summary": "Track type predicts the kind of race you are about to see.",
    "sayThisLine": "It is a superspeedway, so anything can happen."
  }
}
```

### sequence-order

How it is used: Processes and eras: a four-tire pit stop, the flow of a race, championship-format history, race-weekend schedule.

**Sample 1** (lesson `pits-01`)

```json
{
  "prompt": "Put a four-tire pit stop in order.",
  "items": [
    {
      "id": "enter",
      "text": "Enter pit road at the speed limit",
      "why": "Speeding earns a penalty."
    },
    {
      "id": "stop",
      "text": "Stop in the box",
      "why": "The stall box is the target."
    },
    {
      "id": "jack",
      "text": "Jack lifts the car"
    },
    {
      "id": "tires",
      "text": "Tires come off and new ones go on"
    },
    {
      "id": "drop",
      "text": "Jack drops, car leaves"
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Every step depends on the last. Ten seconds of choreography.",
    "incorrect": "The order is enter, stop, lift, change tires, drop and go."
  }
}
```

**Sample 2** (lesson `chase-06`)

```json
{
  "prompt": "Order these championship eras, oldest first.",
  "items": [
    {
      "id": "points",
      "text": "Full-season points era"
    },
    {
      "id": "chase04",
      "text": "The Chase begins (2004)"
    },
    {
      "id": "elim",
      "text": "Elimination playoffs (2014)"
    },
    {
      "id": "chase26",
      "text": "The Chase returns (2026)"
    }
  ],
  "explanation": {
    "correct": "Points to Chase to eliminations, then a return to a Chase.",
    "incorrect": "The Chase arrived in 2004, elimination rounds in 2014 and a new Chase in 2026."
  }
}
```

**Sample 3** (lesson `flow-08`)

```json
{
  "prompt": "Order the beats of a typical race.",
  "items": [
    {
      "id": "green",
      "text": "Green flag"
    },
    {
      "id": "s1",
      "text": "Stage 1 ends with a caution"
    },
    {
      "id": "s2",
      "text": "Stage 2 ends with a caution"
    },
    {
      "id": "final",
      "text": "Final stage and pit cycles"
    },
    {
      "id": "chk",
      "text": "Checkered flag"
    }
  ],
  "explanation": {
    "correct": "Two stages, then the final run.",
    "incorrect": "Green, stage one, stage two, final stage, checkered."
  }
}
```

### visual-id

How it is used: Recognition of track shapes, flags, aero parts, car anatomy, pit-crew roles. All images are original Swoon'd illustrations (`original-swoond`) or licensed; no team liveries, driver photos or sponsor logos unless cleared.

**Sample 1** (lesson `tracks-10`)

```json
{
  "prompt": "Which track type is this?",
  "image": {
    "asset": "images/nascar/track-outline-superspeedway.png",
    "alt": "Overhead outline of a very long oval with a bulge on the front stretch and wide gentle turns.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Short track"
    },
    {
      "id": "b",
      "text": "Superspeedway"
    },
    {
      "id": "c",
      "text": "Road course"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "Long, wide, high banking and a tri-oval kink: a superspeedway.",
    "incorrect": "Look at the size and the front-stretch kink. That is a superspeedway.",
    "sayThisLine": "It is a superspeedway."
  },
  "cues": [
    "Very long straights",
    "Tri-oval kink",
    "Gentle wide turns"
  ]
}
```

**Sample 2** (lesson `flow-01`)

```json
{
  "prompt": "Which flag is this?",
  "image": {
    "asset": "images/nascar/flag-yellow.png",
    "alt": "A plain rectangular flag waving over a start-finish line.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Green"
    },
    {
      "id": "b",
      "text": "Yellow"
    },
    {
      "id": "c",
      "text": "White"
    },
    {
      "id": "d",
      "text": "Black"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "Solid yellow is caution: slow down and hold your position.",
    "incorrect": "Yellow means caution. Green starts racing and white shows the last lap.",
    "sayThisLine": "Yellow flag, caution."
  },
  "cues": [
    "Solid yellow",
    "Caution"
  ]
}
```

**Sample 3** (lesson `car-05`)

```json
{
  "prompt": "Which aero part is highlighted?",
  "image": {
    "asset": "images/nascar/aero-splitter-highlight.png",
    "alt": "Side view of a stock car with a flat blade under the nose highlighted in gold.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Rear spoiler"
    },
    {
      "id": "b",
      "text": "Front splitter"
    },
    {
      "id": "c",
      "text": "Side mirror"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "The flat blade under the nose is the splitter. It shapes the air going under and around the front of the car.",
    "incorrect": "That flat blade under the nose is the front splitter. The spoiler is on the back.",
    "sayThisLine": "It is the front splitter."
  },
  "cues": [
    "Flat blade",
    "Under the nose"
  ]
}
```

### decision-scenario

How it is used: The native home of strategy judgment: pit calls, blocking, fuel gambles, stage strategy. Paired with the Unity sims in `pits-06`, `craft-02`. `safetyNote` used only where real-world risk could be implied (fuel gambles: professional teams).

**Sample 1** (lesson `pits-06`)

```json
{
  "prompt": "Caution with 25 laps left. Old tires. Call?",
  "situation": {
    "narrative": "You are sixth on the lead lap.",
    "facts": [
      {
        "label": "Laps to go",
        "value": "25"
      },
      {
        "label": "Tire age",
        "value": "38 laps",
        "emphasis": "warning"
      },
      {
        "label": "Field",
        "value": "Six cars stay out"
      },
      {
        "label": "Fuel",
        "value": "Enough to finish"
      },
      {
        "label": "Track",
        "value": "Intermediate"
      }
    ]
  },
  "options": [
    {
      "id": "four",
      "label": "Take four tires",
      "verdict": "best",
      "consequence": "You restart back in the pack but on fresh rubber, and drive through the cars on old tires.",
      "considerations": [
        "25 laps is long",
        "Cars ahead are on old tires"
      ]
    },
    {
      "id": "two",
      "label": "Take two tires",
      "verdict": "acceptable",
      "consequence": "You leave pit road sooner but the two old tires still cost you.",
      "considerations": [
        "Quicker stop",
        "Half the grip"
      ]
    },
    {
      "id": "stay",
      "label": "Stay out",
      "verdict": "poor",
      "consequence": "You keep position for a few laps and then fresh tires run you down.",
      "considerations": [
        "Old tires fade",
        "25 laps is too many to hold on"
      ]
    }
  ],
  "expertNote": "A long run rewards fresh tires. Track position matters most when few laps remain.",
  "sayThisLine": "They took four and drove through the field."
}
```

**Sample 2** (lesson `craft-04`)

```json
{
  "prompt": "He is closing fast. Do you block?",
  "situation": {
    "narrative": "You lead with ten laps to go.",
    "facts": [
      {
        "label": "Laps to go",
        "value": "10"
      },
      {
        "label": "Gap",
        "value": "0.3 seconds"
      },
      {
        "label": "Rival",
        "value": "Faster, fresher tires"
      },
      {
        "label": "Track",
        "value": "Short track"
      },
      {
        "label": "Blocks so far",
        "value": "Two already",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "block",
      "label": "Block him again",
      "verdict": "poor",
      "consequence": "He gets angry and looks for payback.",
      "considerations": [
        "Third block is dirty",
        "Fans and drivers notice"
      ]
    },
    {
      "id": "line",
      "label": "Run your line, race hard",
      "verdict": "best",
      "consequence": "You defend cleanly and he has to work for it.",
      "considerations": [
        "Clean defense",
        "Keeps respect"
      ]
    },
    {
      "id": "let",
      "label": "Let him by",
      "verdict": "acceptable",
      "consequence": "You lose the lead but keep the car and the respect.",
      "considerations": [
        "Saves tires",
        "Gives up the win"
      ]
    }
  ],
  "expertNote": "Drivers accept a block or two, but repeated blocks invite payback.",
  "sayThisLine": "He raced him clean at the end."
}
```

**Sample 3** (lesson `cult-07`)

```json
{
  "prompt": "Do you go for fuel mileage to win?",
  "situation": {
    "narrative": "You lead with 32 laps to go.",
    "facts": [
      {
        "label": "Laps to go",
        "value": "32"
      },
      {
        "label": "Fuel window",
        "value": "About 29 laps",
        "emphasis": "warning"
      },
      {
        "label": "Gap to second",
        "value": "4 seconds"
      },
      {
        "label": "Second place",
        "value": "Faster car"
      },
      {
        "label": "Caution chance",
        "value": "Possible"
      }
    ]
  },
  "options": [
    {
      "id": "save",
      "label": "Save fuel and hope for a caution",
      "verdict": "acceptable",
      "consequence": "If a caution comes you win; if not the fast car catches you.",
      "considerations": [
        "Gambles on a yellow",
        "Risk of running dry"
      ]
    },
    {
      "id": "pit",
      "label": "Pit now for fuel",
      "verdict": "poor",
      "consequence": "You lose the lead and the fast car takes the win.",
      "considerations": [
        "Gives up track position"
      ]
    },
    {
      "id": "push",
      "label": "Push as normal and pit later",
      "verdict": "best",
      "consequence": "You stretch the run with a normal pace, then pit under green at the right lap.",
      "considerations": [
        "Keeps pace",
        "Plans the stop"
      ]
    }
  ],
  "expertNote": "Fuel saving is a real strategy, and fans argue about whether it is a legitimate way to win.",
  "safetyNote": "Real racing decisions involve professional teams; this is a learning scenario."
}
```

### talk-track

How it is used: Conversation practice on every topic: the Talk Lab unit, end-of-unit conversation lessons and the Talk tab. Never canned expert lines; always teaches asking, listening and using a term correctly.

**Sample 1** (lesson `talk-02`)

```json
{
  "title": "That pit call",
  "setting": "She texts right after her driver's team makes a gutsy call.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They stayed out on old tires with 40 to go. Bold or dumb?",
      "replies": [
        {
          "id": "a",
          "text": "Track position bet? I can see it going either way.",
          "smoothDelta": 25,
          "theirResponse": "Right?? If a caution hits they look like geniuses.",
          "coachNote": "You used track position and stayed open-minded."
        },
        {
          "id": "b",
          "text": "They should just pit for fresh tires.",
          "smoothDelta": 0,
          "theirResponse": "Maybe. Depends on the caution window.",
          "coachNote": "Not wrong, but a bit blunt for a fan."
        },
        {
          "id": "c",
          "text": "What is a pit call?",
          "smoothDelta": -15,
          "theirResponse": "...It is when they decide when to stop for tires.",
          "coachNote": "You read the message, so ask a real follow-up."
        }
      ]
    },
    {
      "theirMessage": "Now he is fifth. Fresh tires behind are catching him.",
      "replies": [
        {
          "id": "a",
          "text": "Is he going to hold on or fade?",
          "smoothDelta": 20,
          "theirResponse": "Fade, probably. Tire falloff at this track is nuts.",
          "coachNote": "Good question that invites her to explain."
        },
        {
          "id": "b",
          "text": "Great, so it worked.",
          "smoothDelta": -10,
          "theirResponse": "Not yet. We will see.",
          "coachNote": "Hold off on declaring victory."
        }
      ]
    }
  ],
  "closingNote": "Stay-out calls trade fresh tires for track position."
}
```

**Sample 2** (lesson `talk-04`)

```json
{
  "title": "Talk about the Chase",
  "setting": "Her driver made the Chase and she is nervous.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Sixteen in the Chase and we start 11th. Ugh.",
      "replies": [
        {
          "id": "a",
          "text": "With no eliminations, does the reset put him within reach?",
          "smoothDelta": 25,
          "theirResponse": "Exactly! It is 2,000 to 2,100. Every point counts for ten races.",
          "coachNote": "You used the 2026 format correctly."
        },
        {
          "id": "b",
          "text": "Is that bad? Is 11th like being knocked out?",
          "smoothDelta": -5,
          "theirResponse": "No, nobody is knocked out anymore.",
          "coachNote": "Close, but the 2026 Chase has no cutoffs."
        },
        {
          "id": "c",
          "text": "Then win the next race and you are in!",
          "smoothDelta": -20,
          "theirResponse": "That was the old system.",
          "coachNote": "That rule ended. Win-and-in is gone in 2026."
        }
      ]
    }
  ],
  "closingNote": "In 2026 the Chase is ten races, no eliminations, most points at Homestead wins."
}
```

**Sample 3** (lesson `talk-03`)

```json
{
  "title": "After the wreck",
  "setting": "Sunday at Talladega, the Big One just happened.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Talladega did what Talladega does. Big One on lap 150.",
      "replies": [
        {
          "id": "a",
          "text": "That is why they run in packs there, right? One slip and everybody goes.",
          "smoothDelta": 25,
          "theirResponse": "Exactly. The draft keeps them bunched and mistakes spread.",
          "coachNote": "Connected pack racing to the wreck."
        },
        {
          "id": "b",
          "text": "Is everyone okay?",
          "smoothDelta": 10,
          "theirResponse": "Yes, the safety on these cars is wild.",
          "coachNote": "Kind and relevant."
        },
        {
          "id": "c",
          "text": "They should just slow down.",
          "smoothDelta": -15,
          "theirResponse": "Ha. It is the draft. They cannot really lift.",
          "coachNote": "Ask why before advising."
        }
      ]
    }
  ],
  "closingNote": "Superspeedway racing is packs and drafting; the Big One is a pack crash."
}
```

### timing-tap

How it is used: 1D timing feel: pit stop window, pit road entry at speed, restart jump. If the concept needs a scene (drafting, lane choice), it is a Unity sim, not this.

**Sample 1** (lesson `pits-01`)

```json
{
  "prompt": "Tap when the marker hits the gold.",
  "theme": {
    "label": "Pit stop",
    "resultUnit": "seconds"
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
    "correct": "Pit crews win races by shaving tenths.",
    "incorrect": "A slow stop can cost track position, which is hard to win back.",
    "sayThisLine": "That pit stop cost him three spots."
  }
}
```

**Sample 2** (lesson `pits-02`)

```json
{
  "prompt": "Hit the brakes at the pit road line.",
  "theme": {
    "label": "Pit entry",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 45,
      "zoneEndPct": 60,
      "sweepSeconds": 1.8
    },
    {
      "zoneStartPct": 50,
      "zoneEndPct": 60,
      "sweepSeconds": 1.5
    },
    {
      "zoneStartPct": 52,
      "zoneEndPct": 59,
      "sweepSeconds": 1.2
    }
  ],
  "explanation": {
    "correct": "Hitting pit road speed right at the line keeps you clear of a penalty and saves tenths.",
    "incorrect": "Too fast and you risk a speeding penalty. Too slow and you give away time.",
    "sayThisLine": "He hit the pit road speed perfectly."
  }
}
```

**Sample 3** (lesson `craft-02`)

```json
{
  "prompt": "Go when the car ahead goes.",
  "theme": {
    "label": "Restart jump",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 50,
      "zoneEndPct": 70,
      "sweepSeconds": 1.8
    },
    {
      "zoneStartPct": 55,
      "zoneEndPct": 68,
      "sweepSeconds": 1.4
    },
    {
      "zoneStartPct": 58,
      "zoneEndPct": 66,
      "sweepSeconds": 1.1
    }
  ],
  "explanation": {
    "correct": "A clean jump gets you a little extra speed without breaking the rules.",
    "incorrect": "Jumping early risks a penalty; going late costs you a spot.",
    "sayThisLine": "He got a great jump on the restart."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

### say-this

How it is used: The signature 'what is she talking about?' item. Heavily used in Enthusiast depth and the live layer. Uses fan slang and current storylines.

**Sample 1** (lesson `talk-06`)

```json
{
  "statement": {
    "speaker": "Sarah",
    "text": "We lost the race on the last pit stop. Two tires, never should have."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "A pit stop decision",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Tire choice",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "Track position lost",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "A speeding penalty",
      "isCorrect": false
    }
  ],
  "translation": "The team's strategy call cost them the win: only two fresh tires left them slower than cars with four.",
  "followUps": [
    {
      "line": "Would four tires have been faster over the last laps?",
      "why": "It shows you understand the tire trade-off."
    },
    {
      "line": "Did they lose spots on pit road too?",
      "why": "Track position is the deeper story."
    }
  ],
  "noFakeExpertNote": "You do not need to know the exact laps. Ask what she thinks."
}
```

**Sample 2** (lesson `cult-03`)

```json
{
  "statement": {
    "speaker": "Mike",
    "text": "I love that the Chase is back. Consistency should crown the champion."
  },
  "question": "What is he talking about?",
  "options": [
    {
      "id": "a",
      "text": "The 2026 championship format",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Ten races with a points reset",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "A pit strategy",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "The Next Gen car",
      "isCorrect": false
    }
  ],
  "translation": "He likes that 2026 replaced elimination rounds with a ten-race Chase where all points matter.",
  "followUps": [
    {
      "line": "Do you miss the win-and-in drama, or is this better?",
      "why": "It invites his view without faking expertise."
    }
  ]
}
```

**Sample 3** (lesson `insd-05`)

```json
{
  "statement": {
    "speaker": "Jess",
    "text": "He led 180 laps and still finished 12th. Dominant car, bad luck."
  },
  "options": [
    {
      "id": "a",
      "text": "He led the most laps",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A strategy or caution ruined his day",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "He was disqualified",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "He was penalized for speeding",
      "isCorrect": false
    }
  ],
  "translation": "His car was fastest but strategy, a caution or a mistake dropped him back.",
  "followUps": [
    {
      "line": "What happened at the end?",
      "why": "Simple, honest and lets her tell the story."
    }
  ]
}
```

**Sample 4** (lesson `live-02`)

```json
{
  "statement": {
    "speaker": "Alex",
    "text": "That was a fuel-mileage win. Anyone could have run out."
  },
  "options": [
    {
      "id": "a",
      "text": "The winner stretched his fuel",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The race ended under fuel-saving speeds",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "The winner led the most laps",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "A stage was cut short",
      "isCorrect": false
    }
  ],
  "translation": "The race was decided by who could make it to the end on the fuel they had.",
  "followUps": [
    {
      "line": "Does that count as a real win or does it feel cheap?",
      "why": "Steps into the enthusiast debate honestly."
    }
  ]
}
```

### fill-the-gap

How it is used: Terms in context and quick review cards: the Chase sentence, choose rule, tight/loose, horsepower by track type.

**Sample 1** (lesson `chase-04`)

```json
{
  "prompt": "Complete the 2026 Chase sentence.",
  "template": "The Chase has {{drivers}} drivers racing for {{races}} races with {{elims}}.",
  "gaps": [
    {
      "id": "drivers",
      "options": [
        "12",
        "16",
        "24"
      ],
      "correct": "16"
    },
    {
      "id": "races",
      "options": [
        "4",
        "10",
        "26"
      ],
      "correct": "10"
    },
    {
      "id": "elims",
      "options": [
        "no eliminations",
        "one cut",
        "three cuts"
      ],
      "correct": "no eliminations"
    }
  ],
  "explanation": {
    "correct": "Sixteen drivers, ten races, no eliminations, and the title goes to the most points after Homestead.",
    "incorrect": "Sixteen drivers race ten races with no cuts."
  }
}
```

**Sample 2** (lesson `flow-05`)

```json
{
  "prompt": "Complete the restart sentence.",
  "template": "On most ovals drivers {{verb}} the inside or outside lane at the {{where}}.",
  "gaps": [
    {
      "id": "verb",
      "options": [
        "choose",
        "are assigned",
        "vote on"
      ],
      "correct": "choose"
    },
    {
      "id": "where",
      "options": [
        "choose line",
        "pit wall",
        "victory lane"
      ],
      "correct": "choose line"
    }
  ],
  "explanation": {
    "correct": "Drivers pick inside or outside at the choose line, in running order.",
    "incorrect": "The choose rule lets drivers pick their lane at the choose line."
  }
}
```

**Sample 3** (lesson `hand-01`)

```json
{
  "prompt": "Tight or loose?",
  "template": "A car that runs wide because the front will not turn is {{state}}, and the cure is more {{cure}} grip.",
  "gaps": [
    {
      "id": "state",
      "options": [
        "tight",
        "loose"
      ],
      "correct": "tight"
    },
    {
      "id": "cure",
      "options": [
        "front",
        "rear"
      ],
      "correct": "front"
    }
  ],
  "explanation": {
    "correct": "Tight means the front gives up first, so the crew wants more front grip.",
    "incorrect": "Tight means the front lacks grip. Loose is the rear.",
    "sayThisLine": "He is tight in the middle of the corner."
  }
}
```

**Sample 4** (lesson `car-03`)

```json
{
  "prompt": "Complete the horsepower sentence.",
  "template": "At superspeedways the Next Gen car runs about {{hp}} horsepower with a {{spoiler}} spoiler.",
  "gaps": [
    {
      "id": "hp",
      "options": [
        "510",
        "670",
        "750"
      ],
      "correct": "510"
    },
    {
      "id": "spoiler",
      "options": [
        "tall",
        "short"
      ],
      "correct": "tall"
    }
  ],
  "explanation": {
    "correct": "About 510 hp with a tall spoiler keeps superspeedway speeds down and packs tight.",
    "incorrect": "Superspeedway cars run about 510 hp and a tall spoiler."
  }
}
```

### listening-id

How it is used: Spotter calls only, with original synthesized audio (`original-swoond`). No broadcast audio, no real driver radio, no engine recordings from licensed sources. A skip option is always offered.

**Sample 1** (lesson `insd-01`)

```json
{
  "prompt": "What is the spotter telling him?",
  "audio": {
    "asset": "audio/nascar/spotter-clear-high.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "A synthesized calm voice says: clear high, clear high, stay there.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "You can move up the track"
    },
    {
      "id": "b",
      "text": "A wreck is ahead"
    },
    {
      "id": "c",
      "text": "Pit this lap"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Clear high means there is nothing on your high side, so you can move up.",
    "incorrect": "Clear high says the high side is open.",
    "sayThisLine": "The spotter said clear high."
  },
  "listenFor": [
    "Clear",
    "High",
    "Calm tone"
  ]
}
```

**Sample 2** (lesson `insd-01`)

```json
{
  "prompt": "What is this call?",
  "audio": {
    "asset": "audio/nascar/spotter-three-wide.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "A synthesized voice says: three wide below, three wide below, hold your line.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Three cars alongside"
    },
    {
      "id": "b",
      "text": "Wreck ahead"
    },
    {
      "id": "c",
      "text": "Pit road closed"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Three wide means three cars side by side, so hold your line and give room.",
    "incorrect": "Three wide means three cars across.",
    "sayThisLine": "He is three wide down there."
  },
  "listenFor": [
    "Three wide",
    "Hold"
  ]
}
```

**Sample 3** (lesson `insd-01`)

```json
{
  "prompt": "What should he do?",
  "audio": {
    "asset": "audio/nascar/spotter-wreck-high.m4a",
    "durationMs": 5000,
    "license": "original-swoond",
    "description": "A synthesized urgent voice says: wreck ahead, wreck ahead, stay high, stay high.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Stay high"
    },
    {
      "id": "b",
      "text": "Go low"
    },
    {
      "id": "c",
      "text": "Stop on the track"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Wreck ahead, stay high means the danger is low and the open lane is high.",
    "incorrect": "The spotter told him to stay high to avoid the wreck.",
    "sayThisLine": "The spotter saved him from the wreck."
  },
  "listenFor": [
    "Wreck ahead",
    "Stay high"
  ]
}
```

### estimate-slider

How it is used: Magnitudes: race laps and miles, points values, pit stop seconds, fuel-window laps, horsepower by track type.

**Sample 1** (lesson `laps-and-distance`)

```json
{
  "prompt": "How many laps is the Daytona 500?",
  "unit": "laps",
  "min": 100,
  "max": 400,
  "step": 10,
  "correctValue": 200,
  "tolerance": {
    "full": 10,
    "partial": 40
  },
  "explanation": {
    "correct": "200 laps of the 2.5-mile track gives 500 miles.",
    "incorrect": "The 500 in the name is miles. On a 2.5-mile track that is 200 laps.",
    "sayThisLine": "It is 200 laps around Daytona."
  }
}
```

**Sample 2** (lesson `chase-01`)

```json
{
  "prompt": "Points for winning a Cup race in 2026?",
  "unit": "points",
  "min": 30,
  "max": 80,
  "step": 5,
  "correctValue": 55,
  "tolerance": {
    "full": 0,
    "partial": 10
  },
  "explanation": {
    "correct": "A win is worth 55 points, up from 40 before 2026.",
    "incorrect": "A win is 55 points in 2026, up from 40.",
    "sayThisLine": "A win is worth 55 points now."
  }
}
```

**Sample 3** (lesson `pits-01`)

```json
{
  "prompt": "How long is a four-tire pit stop?",
  "unit": "seconds",
  "min": 5,
  "max": 25,
  "step": 1,
  "correctValue": 10,
  "tolerance": {
    "full": 1,
    "partial": 3
  },
  "explanation": {
    "correct": "About ten seconds, sometimes a bit less or more with fuel.",
    "incorrect": "A four-tire stop is about ten seconds. Tenths matter.",
    "sayThisLine": "About ten seconds for four tires."
  }
}
```

### hotspot-tap

How it is used: Fixed diagrams: pit stall positions, grooves on a turn, restart lanes, flag stand and start-finish anatomy, car aero parts. Static only; if cars move, it is a sim.

**Sample 1** (lesson `flow-04`)

```json
{
  "prompt": "Tap the spot where the jack man works.",
  "diagram": {
    "diagramId": "nascar-pit-stall",
    "aspectRatio": 1.4,
    "alt": "Overhead diagram of a pit stall with a car and five crew positions around it."
  },
  "hotspots": [
    {
      "id": "jack",
      "label": "Jack man position",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.78,
        "r": 0.06
      }
    },
    {
      "id": "fuel",
      "label": "Fueler position",
      "shape": {
        "kind": "circle",
        "cx": 0.85,
        "cy": 0.5,
        "r": 0.06
      }
    },
    {
      "id": "front",
      "label": "Front tire changer",
      "shape": {
        "kind": "circle",
        "cx": 0.25,
        "cy": 0.25,
        "r": 0.06
      }
    },
    {
      "id": "rear",
      "label": "Rear tire changer",
      "shape": {
        "kind": "circle",
        "cx": 0.25,
        "cy": 0.75,
        "r": 0.06
      }
    }
  ],
  "correctHotspotIds": [
    "jack"
  ],
  "explanation": {
    "correct": "The jack man lifts the car from the pit-road side at the rear.",
    "incorrect": "The jack man stays at the rear of the car by the pit wall side.",
    "sayThisLine": "The jack man lifts it fast."
  }
}
```

**Sample 2** (lesson `tracks-05`)

```json
{
  "prompt": "Tap the high groove.",
  "diagram": {
    "diagramId": "nascar-turn-grooves",
    "aspectRatio": 1.3,
    "alt": "Overhead diagram of a banked turn with three painted lanes: low near the infield, middle and high next to the wall."
  },
  "hotspots": [
    {
      "id": "low",
      "label": "Low groove",
      "shape": {
        "kind": "rect",
        "x": 0.1,
        "y": 0.6,
        "w": 0.8,
        "h": 0.12
      }
    },
    {
      "id": "mid",
      "label": "Middle groove",
      "shape": {
        "kind": "rect",
        "x": 0.1,
        "y": 0.4,
        "w": 0.8,
        "h": 0.12
      }
    },
    {
      "id": "high",
      "label": "High groove",
      "shape": {
        "kind": "rect",
        "x": 0.1,
        "y": 0.2,
        "w": 0.8,
        "h": 0.12
      }
    }
  ],
  "correctHotspotIds": [
    "high"
  ],
  "explanation": {
    "correct": "The high groove runs near the outside wall and is longer but can be faster on steep banking.",
    "incorrect": "The high groove hugs the wall on the outside of the turn.",
    "sayThisLine": "He ran the high groove."
  }
}
```

**Sample 3** (lesson `flow-05`)

```json
{
  "prompt": "Tap the inside lane on the restart.",
  "diagram": {
    "diagramId": "nascar-restart-double-file",
    "aspectRatio": 0.9,
    "alt": "Overhead of a double-file restart with two columns of cars; the inside column is closest to the infield."
  },
  "hotspots": [
    {
      "id": "inside",
      "label": "Inside lane",
      "shape": {
        "kind": "rect",
        "x": 0.15,
        "y": 0.1,
        "w": 0.3,
        "h": 0.8
      }
    },
    {
      "id": "outside",
      "label": "Outside lane",
      "shape": {
        "kind": "rect",
        "x": 0.55,
        "y": 0.1,
        "w": 0.3,
        "h": 0.8
      }
    }
  ],
  "correctHotspotIds": [
    "inside"
  ],
  "explanation": {
    "correct": "The inside lane is nearest the infield on the left side.",
    "incorrect": "Inside means closest to the infield grass, on the left side of the field.",
    "sayThisLine": "He chose the inside lane."
  }
}
```

## 4. Playbook terms

131 terms, each mapped to a concept id in the curriculum `concepts[]`. The example line is written in the voice of a fan (the crush) using the term naturally; it is used as the "hear it" line in Playbook cards.

| # | Term | conceptId | Plain-English definition | Example line |
|---|---|---|---|---|
| 1 | Stock car | `stock-car` | A purpose-built race car styled like a showroom model but built to a strict NASCAR rulebook. | "It looks like a Camry, but it is absolutely not a Camry." |
| 2 | Series ladder | `series-ladder` | The three national series: Trucks, O'Reilly Auto Parts (the middle rung) and Cup at the top. | "He came up through Trucks, then O'Reilly, now he is in Cup." |
| 3 | Cup Series | `cup-series` | NASCAR's top national series: 36 points races, 40-car fields, the biggest names and money. | "Cup is the big league. Everything else feeds into it." |
| 4 | O'Reilly Auto Parts Series | `oreilly-series` | The middle national series (long known as Xfinity, earlier Busch), where rising drivers and Cup part-timers race. | "He is running the O'Reilly race on Saturday too. Cup guys do that a lot." |
| 5 | Craftsman Truck Series | `truck-series` | The entry-level national series, run in pickup-style trucks, known for hard racing on short tracks. | "Trucks is where the chaotic short-track racing lives." |
| 6 | Oval racing | `oval-racing` | Racing around a closed loop, almost always turning left; setups and strategy are built around that. | "Yes, they only turn left. No, it is not boring; it is chess at 180 mph." |
| 7 | Race distance | `laps-and-distance` | Races are set by laps or miles, not time, so track length changes how many laps you need. | "A 500-mile race at Daytona is 200 laps; at Bristol it is 500 laps of a half-mile." |
| 8 | Starting grid | `starting-grid` | Two-by-two lineup set by qualifying (or by rule); the pole sitter starts first. | "He starts on the pole, so clean air at the green flag." |
| 9 | Green flag | `green-flag` | Signals the start or restart of full-speed racing. | "Green flag drops and the field is off." |
| 10 | Yellow flag (caution) | `caution-flag` | Slows the field behind the pace car for an incident or debris; the running order freezes and pit stops happen. | "Caution is out, so everybody dives to pit road." |
| 11 | Red flag | `red-flag` | Stops the race completely, usually for a big crash, track repair or weather. | "They red-flagged it to fix the wall." |
| 12 | Checkered flag | `checkered-flag` | Ends the race; the first car across the line wins. | "Checkered flag, and he wins by half a car length." |
| 13 | White flag | `white-flag` | Shows one lap remaining. | "White flag, one lap to go, everything is about to get wild." |
| 14 | Black flag | `black-flag` | Orders a driver to pit road for a penalty or safety issue; ignoring it means no more laps are scored. | "They got black-flagged and had to come in." |
| 15 | Stage racing | `stage-racing` | Each race is split into stages; the top ten at each stage end score bonus points. | "Stage points are why they race so hard on lap 60." |
| 16 | Stage break | `stage-break` | A planned caution at the end of stage one and two that opens a pit cycle. | "They pitted at the stage break to get tires." |
| 17 | Restart | `restart` | The moment racing resumes after a caution; cars line up in double file behind the leader. | "Restarts are where the passing happens." |
| 18 | Choose rule | `choose-rule` | On restarts the drivers pick the inside or outside lane in running order, so lane choice is a strategy call. | "He chose the outside lane on the restart and got a great push." |
| 19 | Overtime (green-white-checkered) | `overtime` | If a caution or stoppage happens near the end, the race is extended to try for a green-flag finish. | "They went to overtime and it got crazy." |
| 20 | Pit road | `pit-road` | The lane beside the track where crews service cars under a speed limit. | "She got caught speeding on pit road." |
| 21 | Pit crew | `pit-crew` | The five over-the-wall specialists (tire changers, carrier, jack man, fueler) who service the car in seconds. | "Their pit crew won the race with that four-tire stop." |
| 22 | Pit road speed limit | `pit-road-speed` | A posted limit, monitored in timing zones, that changes track by track. | "He sped on entry, drive-through penalty." |
| 23 | Pit road penalty | `pit-penalty` | A penalty for infractions on pit road (speeding, too many men, box violations) that costs track position. | "A too-many-men penalty ruined their day." |
| 24 | Free pass (lucky dog) | `free-pass` | Under caution, the first car one lap down gets to rejoin the lead lap. | "He got the free pass and got his lap back." |
| 25 | Wave-around | `wave-around` | Lapped cars under caution may pass the pace car to unlap themselves and rejoin the tail of the field. | "The wave-around got everyone back on the lead lap." |
| 26 | Lapped car | `lap-down` | A car the leader has passed by a full lap; it races on but is not in contention to win. | "He is a lap down but still racing." |
| 27 | Running order | `running-order` | The current ranking of cars on track. | "Check the running order: he is fourth." |
| 28 | Next Gen car | `next-gen-car` | The current Cup car (since 2022): symmetrical body, composite panels, independent rear suspension, single-lug wheels. | "Next Gen changed a lot: parts are shared across teams." |
| 29 | Body & chassis | `body-and-chassis` | A steel-tube chassis wearing composite body panels; the shape is tightly regulated for aero fairness. | "The bodies are basically the same shape now." |
| 30 | Engine package | `engine-package` | A naturally aspirated 358 cubic-inch V8; horsepower differs by track type via the tapered spacer. | "It is a V8 with different power at different tracks." |
| 31 | Tapered spacer | `tapered-spacer` | A plate atop the intake manifold whose opening size limits air and so horsepower. | "Bigger spacer, more horsepower, harder to drive." |
| 32 | Horsepower levels | `horsepower-levels` | Around 510 hp at superspeedways, 670 at intermediates and 750 at short tracks and road courses in 2026. | "750 at the short tracks this year, so more of a handful." |
| 33 | Manufacturers | `manufacturers` | Chevrolet, Ford and Toyota: three brands whose factory support and pride shape fan loyalties. | "I am a Ford girl. Chevy fans mean well, though." |
| 34 | Spoiler & splitter | `spoiler-splitter` | Aero parts: the rear spoiler adds downforce and drag, the front splitter shapes airflow under the nose. | "A taller spoiler means a lot more drag in traffic." |
| 35 | Tires & wheels | `tires-and-wheels` | Goodyear supplies the racing slicks; a single center-lock lug nut per wheel replaced five lug nuts in 2022. | "One lug nut per wheel now, so stops are trickier." |
| 36 | Fuel & fuel cell | `fuel-cell` | Fuel is E15; the tank holds around 20 gallons, so fuel mileage decides many finishes. | "They gambled on fuel mileage and it worked." |
| 37 | Crew chief | `crew-chief` | The lead engineer and strategist on the pit box who decides pit calls and adjustments. | "The crew chief called the two-tire stop." |
| 38 | Spotter | `spotter` | A team member on the grandstand roof who tells the driver where other cars are. | "The spotter said clear, so he moved up." |
| 39 | Inspection | `inspection` | Pre- and post-race checks that ensure every car meets the rules; failure means penalties. | "They lost the win in post-race inspection." |
| 40 | Safety design | `safety-design` | Roll cage, SAFER barriers, HANS device and a crushable Next Gen structure protect drivers. | "It looks brutal, but the safety tech is wild." |
| 41 | Track types | `track-types` | Short tracks (under a mile), intermediates (1-2 miles), superspeedways (2.5 miles and up) and road courses; each rewards different skills. | "Track type tells you who is going to be good." |
| 42 | Short track | `short-track` | Tight ovals under a mile (Martinsville, Bristol) known for contact, tire wear and bumper-to-bumper racing. | "Martinsville is a paperclip and everyone gets crumpled." |
| 43 | Intermediate track | `intermediate-track` | 1-2 mile ovals (Kansas, Las Vegas, Charlotte) where aero and handling dominate. | "Intermediates are all about being fast in the corners." |
| 44 | Superspeedway | `superspeedway` | The 2.5-mile-plus giants (Daytona, Talladega, Atlanta) with pack racing and wrecks. | "Talladega is the one where anything can happen." |
| 45 | Road course | `road-course` | Left-and-right circuits with braking zones and elevation; ringer drivers can shine here. | "Road courses reward braking and patience." |
| 46 | Flat track | `flat-track` | Ovals with little banking (Phoenix, Martinsville) that need mechanical grip and heavy braking. | "Phoenix is flat so it is a tire management race." |
| 47 | Banking | `banking` | The tilt of the racing surface; steep banking (Bristol, Talladega) lets cars go faster and creates multi-groove racing. | "Bristol's banking is why it sounds like a stadium." |
| 48 | Groove (racing line) | `racing-groove` | The paths cars use: low, middle and high; rubber builds in the fast one. | "He moved to the high groove for the pass." |
| 49 | Rubbering in | `rubbering-in` | Rubber laid down by tires makes a lane grippier; the fast groove often moves during a race. | "The track rubbered in so the top lane came alive." |
| 50 | Tri-oval | `tri-oval` | An oval with a kink on the front stretch (Daytona, Talladega) that shapes the finish-line area. | "The tri-oval finish is where photo finishes happen." |
| 51 | Roval | `roval` | The Charlotte Roval: a road course laid over the oval's infield and one banked turn. | "The Roval is the wild one in the Chase." |
| 52 | Crown jewel races | `crown-jewel` | The most prestigious races: Daytona 500, Coca-Cola 600, Southern 500 and the Brickyard race. | "Winning a crown jewel is huge for a career." |
| 53 | Aero sensitivity | `aero-sensitivity` | How much car speed depends on airflow; more sensitive at fast tracks. | "At 200 mph, air matters more than horsepower." |
| 54 | Drafting | `drafting` | Following closely behind another car so the lead car cuts the air and both go faster. | "He got a great run off the draft." |
| 55 | Aerodynamic drag | `aerodynamic-drag` | The air resistance a car fights; the lead car pays most of it. | "Whoever is in front is doing the hard work." |
| 56 | Clean air | `clean-air` | Smooth airflow on the nose and splitter; cars up front have it, and it usually means more grip. | "He wanted clean air at the restart." |
| 57 | Dirty air | `dirty-air` | Turbulent air behind another car that reduces front grip and makes passing harder on downforce tracks. | "He got stuck in dirty air and could not pass." |
| 58 | Bump draft | `bump-draft` | A trailing car nudges the lead car so both go faster for a moment. | "He got a push from the bump draft." |
| 59 | Side draft | `side-draft` | Using a nearby car's air on the side to slow it or gain speed. | "He side-drafted him up the track." |
| 60 | Pack racing | `pack-racing` | Many cars nose-to-tail and side-by-side at superspeedways because the draft equalizes speed. | "They are running in a huge pack at Daytona." |
| 61 | The Big One | `the-big-one` | A multi-car superspeedway crash caused by one small mistake in the pack. | "The Big One took out half the field." |
| 62 | Lane choice | `lane-choice` | Picking the line (low, high or middle) that has the momentum in the draft. | "Whichever lane has the run wins." |
| 63 | A run | `the-run` | The speed surplus a trailing car gains from the draft before it swings out to pass. | "She had a big run but got blocked." |
| 64 | Blocking | `blocking` | Moving to stop an overtaker; acceptable once, but repeated blocks anger rivals. | "That block was late and dirty." |
| 65 | Superspeedway fuel saving | `fuel-saving-superspeedway` | Drivers ease off to stretch fuel and avoid crashes at superspeedways; a topic many fans dislike. | "They rode around in the back saving fuel and it was boring." |
| 66 | Track position | `track-position` | Where you run on the track; being in front often matters more than raw speed. | "He has track position so he does not need speed." |
| 67 | Pit cycle | `pit-cycle` | The rhythm of green-flag stops; teams pit in a similar window as fuel and tires run out. | "The pit cycle shuffled the order." |
| 68 | Four-tire stop | `four-tire-stop` | Changing all four tires (about 9-11 seconds); gives maximum grip. | "Four tires gave him the best restart." |
| 69 | Two-tire stop | `two-tire-stop` | Changing two tires (sometimes with fuel) to save seconds and gain track position. | "Two tires got him off pit road first." |
| 70 | Fuel window | `fuel-window` | The range of laps a full tank can last, which sets when teams must pit. | "They are outside the fuel window." |
| 71 | Undercut | `undercut` | Pitting earlier so fresh tires gain time before rivals stop. | "They tried the undercut and it worked." |
| 72 | Overcut | `overcut` | Staying out longer while rivals pit, hoping clear track beats their new tires. | "They stayed out and gained on old tires." |
| 73 | Stay out | `stay-out` | Choosing not to pit under caution to gain track position at the cost of fresher tires. | "They stayed out to get the lead." |
| 74 | Strategy gamble | `gamble-strategy` | Off-cycle strategies (fuel gamble, staying out) that pay off only if cautions or laps fall right. | "They took a gamble and it paid off." |
| 75 | Stage strategy | `stage-strategy` | Whether to pit before or after a stage ends, chasing stage points or track position. | "They gave up stage points to stay ahead." |
| 76 | Tire falloff | `tire-falloff` | Speed lost as tires wear; big at abrasive tracks such as Darlington. | "Tire falloff is huge at Darlington." |
| 77 | Pit stop timing | `pit-stop-timing` | Total time from stopping to leaving the stall; measured in tenths. | "That 9.8 second stop was fantastic." |
| 78 | Tight (push) | `tight-push` | The front tires lose grip, so the car pushes wide; understeer. | "He was tight and pushed up into the wall." |
| 79 | Loose | `loose` | The rear loses grip so the tail swings out; oversteer. | "He got loose in turn four." |
| 80 | Balance | `car-balance` | How the car handles between tight and loose; drivers want neutral. | "He said the balance is off." |
| 81 | Tire pressure | `tire-pressure` | Air pressure changes contact patch and grip; one of the easiest adjustments. | "They raised the air pressure to tighten it up." |
| 82 | Wedge (round-in) | `wedge` | A cross-weight adjustment made in the pits that changes how the car turns. | "They adjusted the wedge for handling." |
| 83 | Track bar | `track-bar` | A rear suspension link that shifts the axle side to side to change balance. | "They moved the track bar." |
| 84 | Long-run vs short-run speed | `long-run-speed` | How the car holds pace over many laps versus how fast it is on fresh tires. | "Fast on the short run, fades on the long run." |
| 85 | Adjustments | `adjustments` | In-race changes teams make during pit stops to fix balance. | "They made adjustments on that stop." |
| 86 | Race points | `race-points` | Finish-position points: 55 for the win, 35 for second, 34 for third, down to 1 for 40th. | "A win is worth 55 points." |
| 87 | Stage points | `stage-points` | Top 10 at each stage end score 10 down to 1. | "He scored stage points on lap 60." |
| 88 | The Chase (2026) | `chase-2026` | Top 16 in points after 26 races are reset and race 10 races; most points after the final race wins the title, with no eliminations. | "It is the Chase again: no eliminations, just ten races." |
| 89 | Points reset | `points-reset` | Before the Chase, points are reset by seed: 2,100, 2,075, 2,065, then 5 fewer for each seed down to 2,000 for 16th. | "Regular-season champion starts with a 25-point cushion." |
| 90 | Regular-season champion | `regular-season-champion` | The points leader after 26 races, who takes the top seed and a 25-point head start. | "He won the regular season title." |
| 91 | Championship race | `championship-race` | The 36th race (Homestead in 2026), whose points decide the title. | "It all comes down to Homestead." |
| 92 | Format history | `playoff-format-history` | Points era 1949-2003; Chase 2004; elimination playoffs 2014-2025; Chase returns in 2026. | "They changed the format again." |
| 93 | Playoff format debate | `playoff-debate` | Fans argue whether eliminations or full-season consistency crown the better champion. | "I prefer the Chase: it rewards consistency." |
| 94 | Charter system | `charter-system` | 36 charters guarantee a start and a revenue share; since the December 2025 settlement they are permanent ("evergreen") with conditions; open teams fill any remaining spots. | "He is an open car, no charter." |
| 95 | Open team | `open-team` | A team without a charter that must qualify on speed for the remaining spots. | "They missed the race, no charter." |
| 96 | Qualifying | `qualifying` | The session that sets the starting grid; formats vary by track type. | "He qualified on the pole." |
| 97 | Restart strategy | `restart-strategy` | Lane choice, gap to the leader and jump timing to gain spots on a restart. | "He got a great jump on the restart." |
| 98 | Passing lines | `passing-lines` | Where a pass can succeed: high, low or three-wide, depending on the track. | "Great pass on the low line." |
| 99 | Clean air pass | `clean-air-pass` | Passing once the car is out of the leader's dirty air. | "He cleared him and got clean air." |
| 100 | Road course racecraft | `road-course-racecraft` | Braking, apexes and patience; the pass often happens under braking. | "He out-braked him into turn 1." |
| 101 | Braking zone | `braking-zone` | The part of a road course where cars slow for a corner. | "He dived in the braking zone." |
| 102 | Payback | `payback` | Retaliation after contact; a NASCAR tradition that fuels rivalries. | "They have history; there might be payback." |
| 103 | Racing vs wrecking | `wreck-vs-race` | Racing is contact within judgment; wrecking is intentional or reckless. | "That was hard racing." |
| 104 | Lapped traffic | `lapped-traffic` | Slower cars the leaders must pass; traffic can help or hurt. | "He got held up by lapped cars." |
| 105 | Origins | `nascar-origins` | Rooted in Prohibition-era bootleggers in the Southeast; NASCAR was founded in 1948 by Bill France Sr. | "Moonshiners are why it exists." |
| 106 | Legends | `legends` | Richard Petty, Dale Earnhardt and Jimmie Johnson share seven titles each; Jeff Gordon has four. | "Seven titles for Petty, Earnhardt and Johnson." |
| 107 | Daytona 500 lore | `daytona-500-lore` | The most prestigious race, run in February at Daytona; a win is career-defining. | "The Daytona 500 is the Super Bowl." |
| 108 | Next Gen debate | `next-gen-debate` | Debate over whether the car is too stiff, too similar or too hard to pass in. | "People love or hate the Next Gen car." |
| 109 | Stage racing debate | `stage-debate` | Fans disagree on whether stages add or remove drama. | "Stages are contrived, some say." |
| 110 | Schedule debate | `schedule-debate` | Arguments over road courses, street races and legacy ovals. | "Bring back the old tracks." |
| 111 | Fuel-mileage finishes | `fuel-mileage-debate` | A race decided by economy rather than pure speed; enthusiasts split on whether it is legitimate. | "That was a fuel-mileage win." |
| 112 | Spotter talk | `spotter-talk` | Terms like clear, car left, three-wide and stay high; understanding them decodes radio. | "Clear high means you can move up." |
| 113 | Loop data | `loop-data` | Advanced stats such as average running position and green-flag speed that show who was truly fast. | "He led laps and had the best loop data." |
| 114 | Laps led | `laps-led` | Number of laps a driver has led; one way to spot a dominant car. | "He led 200 laps." |
| 115 | Damaged vehicle policy | `damaged-vehicle` | A rule for repairing damaged cars within a time limit or being out of the race. | "They ran out of time on the damaged-vehicle clock." |
| 116 | Penalties & tech | `penalties-tech` | Loss of points, crew chief suspension and fines for rules violations. | "They got penalized after inspection." |
| 117 | Dominant car | `dominant-car` | A car that leads the most laps but might not win because of pit call, caution or luck. | "He dominated but lost on strategy." |
| 118 | Race team | `team-organization` | Organizations such as Hendrick, Gibbs, Penske, 23XI and Trackhouse that field multiple cars. | "Hendrick has four cars." |
| 119 | Alliances | `alliances` | Teams share engineering data and engines within manufacturer groups. | "They are in the Toyota camp." |
| 120 | Driver types | `driver-archetypes` | Short-track ace, superspeedway specialist, road-course ringer, veteran, young gun. | "He is a road-course guy." |
| 121 | Driver pipeline | `driver-pipeline` | How drivers climb: short tracks, ARCA, Trucks, O'Reilly, Cup. | "He came up through ARCA." |
| 122 | Sponsorship | `sponsorship` | Paint schemes and funding; sponsors often decide who gets a ride. | "Sponsor money keeps them running." |
| 123 | Rivalries | `rivalries` | Long-running feuds and manufacturer rivalries that fans follow. | "They have a long-running feud." |
| 124 | Season storylines | `current-season` | Ongoing arcs each season: hot drivers, rule changes, the Chase picture. | "Who is in the Chase this year?" |
| 125 | Driver in focus | `driver-focus` | The specific driver the learner's person follows. | "Do you know how his season is going?" |
| 126 | Team in focus | `team-focus` | The specific team the learner's person follows. | "Are you a Hendrick fan?" |
| 127 | Manufacturer in focus | `manufacturer-focus` | Chevrolet, Ford or Toyota brand loyalty. | "Ford, Chevy or Toyota?" |
| 128 | Home track | `track-focus` | The track the person cares about most. | "Their home race is at Darlington." |
| 129 | Series in focus | `series-focus` | Whether the person follows Cup, O'Reilly or Trucks. | "Do you follow Cup or Trucks?" |
| 130 | Conversation basics | `conversation-basics` | Asking good follow-ups about drivers, strategy and races. | "What did you think of that pit call?" |
| 131 | Useful competence | `useful-competence` | Enough knowledge to follow a race and ask real questions. | "I follow the strategy now." |

## 5. Talk Track scenarios

Ten scenarios for the Talk tab and the Talk Lab (the first three are also authored in full as `talk-track` payloads above). Format: enthusiast line, what it means, and three reply tiers with the coach note. Good = shows understanding and asks a real question; Meh = safe but shallow; Cringe = fakes expertise or gets it wrong.

### 1. Track position bet

- **Enthusiast line:** "They stayed out on old tires with 40 to go. Bold or dumb?"
- **What it means:** The crew chief gave up fresh tires to keep the lead; fans debate whether it will hold.
- **Good reply:** "Track position bet? I can see it going either way. What do you think?"
- **Meh reply:** "They should have pitted."
- **Cringe reply:** "Obviously dumb. Everyone knows you take tires."
- **Coach notes:** Good uses the term and stays curious. Meh is a bare opinion. Cringe pretends a settled expert view.

### 2. Draft and the run

- **Enthusiast line:** "He got a monster run off the draft on the last lap and still could not get by."
- **What it means:** He built speed by tucking behind another car, but the leader blocked or held him off.
- **Good reply:** "Did the leader block him, or did he just run out of track?"
- **Meh reply:** "Wow, close finish."
- **Cringe reply:** "He should have used the big engine."
- **Coach notes:** Good shows you know the run and asks about the block. Cringe invents an engine advantage.

### 3. Dirty air

- **Enthusiast line:** "He was stuck in dirty air the whole second stage."
- **What it means:** Following another car disturbed the air over his front end, so he lost grip and could not pass.
- **Good reply:** "Is that why he could not get around him even though he was faster?"
- **Meh reply:** "That is rough."
- **Cringe reply:** "So he should have just gone faster."
- **Coach notes:** Good links dirty air to being unable to pass. Meh is sympathy only.

### 4. Playoff format

- **Enthusiast line:** "Honestly I like the Chase better than the elimination rounds."
- **What it means:** She prefers a ten-race points championship with no eliminations.
- **Good reply:** "Do you like that consistency matters more, or that there is no win-and-in?"
- **Meh reply:** "I do not follow the format much."
- **Cringe reply:** "Yes, because one race decides everything."
- **Coach notes:** Good names a real trade-off. Cringe states the old system as if it were current.

### 5. Tight/loose

- **Enthusiast line:** "He was so tight in the middle of the corner, they never fixed it."
- **What it means:** The front tires would not turn the car, so it pushed toward the wall and the team could not solve it.
- **Good reply:** "Did they try changing anything on the stops, or was it the tires?"
- **Meh reply:** "That is a shame."
- **Cringe reply:** "So the car was too loose."
- **Coach notes:** Good asks about adjustments. Cringe mixes up tight and loose, which fans notice.

### 6. The Big One

- **Enthusiast line:** "Talladega, so obviously the Big One happened."
- **What it means:** A pack crash that takes out many cars, common at superspeedways.
- **Good reply:** "Is it the draft that keeps them so close together?"
- **Meh reply:** "Is everyone okay?"
- **Cringe reply:** "They should just slow down."
- **Coach notes:** Good connects pack racing to the wreck. Meh is kind and fine. Cringe gives naive advice.

### 7. Pit road penalty

- **Enthusiast line:** "We had it won until the too-many-men penalty."
- **What it means:** The team had an extra crew member over the wall, costing a pit-road penalty and track position.
- **Good reply:** "Was it the stop that cost the win, or the tire choice before that?"
- **Meh reply:** "Ouch."
- **Cringe reply:** "Did they get fined?"
- **Coach notes:** Good keeps the focus on the story. Cringe assumes a fine; the loss was position.

### 8. Stage racing

- **Enthusiast line:** "I hate that they pit at the stage break; it ruins the strategy."
- **What it means:** She dislikes planned cautions splitting the race and scrambling pit cycles.
- **Good reply:** "Would you rather have one long race, or do you like the points for stages?"
- **Meh reply:** "Yeah, stages are weird."
- **Cringe reply:** "But stages give the drivers a break, right?"
- **Coach notes:** Good invites her view on a real debate. Cringe guesses a wrong reason.

### 9. Fuel mileage

- **Enthusiast line:** "That was a fuel-mileage win. I feel cheated."
- **What it means:** The winner stretched his fuel to the end while faster cars pitted or ran out.
- **Good reply:** "Do you count that as a real win, or does it feel like luck?"
- **Meh reply:** "At least someone won."
- **Cringe reply:** "So he had the fastest car."
- **Coach notes:** Good joins the legitimacy debate. Cringe contradicts the meaning.

### 10. Restart jump

- **Enthusiast line:** "He got a great jump on the restart and drove right by."
- **What it means:** He accelerated with the leader and gained spots, staying inside the rules.
- **Good reply:** "Did he go outside or inside? The lane seems to matter a lot."
- **Meh reply:** "Nice move."
- **Cringe reply:** "He must have had more horsepower."
- **Coach notes:** Good asks about lane choice. Cringe credits engine power for a timing skill.

