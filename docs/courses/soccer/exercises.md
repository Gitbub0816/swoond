# Native Exercise Plan (Tier B): Soccer (`soccer`)

Sample items conform to `docs/contracts/native-exercises/v1/<type>.schema.json` (each payload below was validated against its schema with ajv). The catalog of behavior, scoring and accessibility is `docs/native-exercises/CATALOG.md`. Prompts are 12 words or fewer; every answer is explained; "say this" lines are in the fan's voice, in quotes.
## 1. Types used and estimated counts
| Type | Lesson slots | Est. items in launch pool | Use in this course |
|---|---|---|---|
| `multiple-choice` | 89 | 267 | Default recall/understanding check; also the main review card. Used for rules, competition formats and definitions. |
| `binary-call` | 10 | 30 | Two-way rule calls on a situation (offside, handball, restarts). Scenes are procedural diagrams (`soccer-pitch-attacking-third`, `soccer-pitch-full`) or a `none` scene with a described situation. |
| `term-match` | 24 | 72 | Introduce 3-6 related terms (numbers, blocks, restarts, cards, competitions). |
| `sequence-order` | 2 | 6 | Order-of-events concepts: the knockout tiebreak ladder, the Champions League path, a build-up. |
| `decision-scenario` | 9 | 27 | Judgment: referee calls (DOGSO), manager calls (protect the lead), reading transfer news. Graded best/acceptable/poor. No `safetyNote` needed (not a safety course); do not use for injuries. |
| `talk-track` | 18 | 54 | Conversation practice (lessons and the Talk tab). Eight authored scenarios below; target 24 before launch. |
| `timing-tap` | 1 | 3 | 1D clock rules only: the 8-second keeper rule, the 5-second restart countdown and penalty patience. Sweep and zones per the schema. |
| `say-this` | 66 | 198 | Decoding fan lines; concept selection, translation and follow-up lines. Always with a `noFakeExpertNote`. |
| `fill-the-gap` | 11 | 33 | Vocabulary in context and rule statements (formations, keeper rule, offside). |
| `estimate-slider` | 6 | 18 | Magnitudes: World Cup teams, penalty xG, league-phase matches. |
| `hotspot-tap` | 11 | 33 | Pitch markings, positions in a shape, half-spaces on procedural diagrams (ids listed in NOTES_FOR_ORCHESTRATOR.md). |

**Not used:** `visual-id` and `listening-id`. Reason: logos, kits, player likeness and match audio are licensing-sensitive (spec rule 10) and recognising a photo or a sound is not needed for social competence here. Optional later: an original-illustration `visual-id` set of referee signals (`license` `original-swoond`).
**Sim-adjacent fallbacks:** the native lessons named in CDS section 12 (`offside-01` to `offside-03`, `shape-01` to `shape-03`, `attack-06`, `setpiece-01`, `setpiece-02`) are the accessible route when a Unity sim cannot be used.
## 2. Native types with sample items
### multiple-choice

Default recall/understanding check; also the main review card. Used for rules, competition formats and definitions.

**Away goals** (`mc-away-goals`, concept `away-goals`)

```json
{
  "prompt": "Do away goals count double in Champions League knockouts?",
  "options": [
    {
      "id": "a",
      "text": "Yes, always"
    },
    {
      "id": "b",
      "text": "No, the rule was scrapped in 2021"
    },
    {
      "id": "c",
      "text": "Only in the final"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Right. UEFA scrapped the away-goals rule in 2021, so a level aggregate goes to extra time and penalties.",
    "incorrect": "It was scrapped in 2021. Level on aggregate now means extra time, then a shootout.",
    "sayThisLine": "Nobody gets double credit for goals away from home any more."
  }
}
```

**VAR limits** (`mc-var-limits`, concept `var-basics`)

```json
{
  "prompt": "Which decision can VAR NOT review?",
  "options": [
    {
      "id": "a",
      "text": "A goal"
    },
    {
      "id": "b",
      "text": "A penalty decision"
    },
    {
      "id": "c",
      "text": "A first yellow card"
    },
    {
      "id": "d",
      "text": "Mistaken identity"
    }
  ],
  "correctOptionIds": [
    "c"
  ],
  "explanation": {
    "correct": "Nice read. VAR is limited to goals, penalties, direct red cards and mistaken identity. A plain first yellow is the referee's call.",
    "incorrect": "VAR only reviews goals, penalties, direct reds and mistaken identity, and only for a clear and obvious error.",
    "sayThisLine": "VAR can't help with a first yellow, that's the referee's decision."
  }
}
```

**Who adds time** (`mc-stoppage`, concept `stoppage-time`)

```json
{
  "prompt": "Who decides how much stoppage time is added?",
  "options": [
    {
      "id": "a",
      "text": "The league's timekeeper"
    },
    {
      "id": "b",
      "text": "The referee"
    },
    {
      "id": "c",
      "text": "The home manager"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Yes. The referee tracks time lost to goals, injuries and delays, and the fourth official shows the minimum on a board.",
    "incorrect": "The referee decides. The fourth official just holds up the board with the minimum extra minutes.",
    "sayThisLine": "Six added minutes? Blame the referee's notebook, and the celebrations."
  }
}
```

**Who is the 6** (`mc-the-six`, concept `defensive-midfielder`)

```json
{
  "prompt": "A fan calls him a proper six. What does he do?",
  "options": [
    {
      "id": "a",
      "text": "Scores tap-ins"
    },
    {
      "id": "b",
      "text": "Screens the back four and wins the ball"
    },
    {
      "id": "c",
      "text": "Takes corners only"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Right. The six sits in front of the defence, breaks up attacks and starts the next move.",
    "incorrect": "The six is the defensive midfielder: he shields the back line and wins the ball back.",
    "sayThisLine": "We need a proper six, someone who protects the back line."
  }
}
```

### binary-call

Two-way rule calls on a situation (offside, handball, restarts). Scenes are procedural diagrams (`soccer-pitch-attacking-third`, `soccer-pitch-full`) or a `none` scene with a described situation.

**Offside or onside** (`bc-offside-pass`, concept `offside-position`)

```json
{
  "prompt": "Pass is played. Is the striker offside?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "soccer-pitch-attacking-third",
    "markers": [
      {
        "role": "player",
        "x": 0.52,
        "y": 0.22
      },
      {
        "role": "opponent",
        "x": 0.5,
        "y": 0.3
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.62
      }
    ],
    "alt": "Attacking third. The ball is played from midfield while your striker is nearer the goal line than the last defender."
  },
  "choices": [
    {
      "id": "offside",
      "label": "Offside"
    },
    {
      "id": "onside",
      "label": "Onside"
    }
  ],
  "correctChoiceId": "offside",
  "explanation": {
    "correct": "Yes. At the moment of the pass his feet are nearer the goal line than the last defender, and the ball is behind him.",
    "incorrect": "Look at the moment of the pass: he is nearer the goal line than the second-last defender (keeper included) and the ball, so he is in an offside position.",
    "sayThisLine": "He was just offside, but his position matters only if he's involved."
  },
  "ruleTag": "Offside position"
}
```

**Goal kick offside** (`bc-goalkick-offside`, concept `no-offside-restarts`)

```json
{
  "prompt": "Attacker is ahead of everyone at a goal kick. Offside?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "soccer-pitch-full",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.25
      },
      {
        "role": "opponent",
        "x": 0.5,
        "y": 0.4
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.92
      }
    ],
    "alt": "Goal kick from the far end. Your attacker waits near the halfway line ahead of the last defender."
  },
  "choices": [
    {
      "id": "offside",
      "label": "Offside"
    },
    {
      "id": "onside",
      "label": "Onside"
    }
  ],
  "correctChoiceId": "onside",
  "explanation": {
    "correct": "Right. You cannot be offside directly from a goal kick, throw-in or corner.",
    "incorrect": "There is no offside from a goal kick, throw-in or corner, however far up the attacker stands.",
    "sayThisLine": "You can't be offside from a goal kick."
  },
  "ruleTag": "No offside from restarts"
}
```

**Natural arm** (`bc-handball-natural`, concept `handball`)

```json
{
  "prompt": "Ball hits a defender's arm held tight to his body.",
  "scene": {
    "kind": "none",
    "alt": "A defender stands inside his own penalty area with both arms close to his sides. A cross hits his upper arm from close range."
  },
  "choices": [
    {
      "id": "penalty",
      "label": "Penalty"
    },
    {
      "id": "play-on",
      "label": "Play on"
    }
  ],
  "correctChoiceId": "play-on",
  "explanation": {
    "correct": "Right. An arm in a natural position that has not made the body bigger is usually not a handball offence.",
    "incorrect": "Handball is about deliberate contact or a body made unnaturally bigger. Arms tight to the body are usually fine.",
    "sayThisLine": "His arm was in a natural position, so it's no penalty."
  },
  "ruleTag": "Handball"
}
```

### term-match

Introduce 3-6 related terms (numbers, blocks, restarts, cards, competitions).

**The numbers** (`tm-numbers`, concept `striker`)

```json
{
  "prompt": "Match the number to the role.",
  "pairs": [
    {
      "id": "six",
      "term": "The 6",
      "definition": "Screens the defence and breaks up attacks"
    },
    {
      "id": "eight",
      "term": "The 8",
      "definition": "Runs both ways, links defence and attack"
    },
    {
      "id": "ten",
      "term": "The 10",
      "definition": "Creator who plays between the lines"
    },
    {
      "id": "nine",
      "term": "The 9",
      "definition": "Lead striker who finishes chances"
    }
  ],
  "explanation": {
    "summary": "Shirt numbers began as positions: the numbers stuck as role labels even though squads now wear any number.",
    "sayThisLine": "He's not a nine, he's a false nine."
  }
}
```

**Defensive blocks** (`tm-blocks`, concept `high-press`)

```json
{
  "prompt": "Match the defensive style.",
  "pairs": [
    {
      "id": "hp",
      "term": "High press",
      "definition": "Win the ball high, close to the opponent's goal"
    },
    {
      "id": "mb",
      "term": "Mid-block",
      "definition": "Sit in the middle third and press when it enters"
    },
    {
      "id": "lb",
      "term": "Low block",
      "definition": "Defend deep and compact, hit on the counter"
    },
    {
      "id": "cp",
      "term": "Counter-press",
      "definition": "Win the ball straight back after losing it"
    }
  ],
  "explanation": {
    "summary": "The blocks describe where a team defends; the counter-press is what it does the moment it loses the ball.",
    "sayThisLine": "They're a low block who counter-press when they lose it high."
  }
}
```

**Restarts** (`tm-restarts`, concept `throw-in`)

```json
{
  "prompt": "Match the restart to when it happens.",
  "pairs": [
    {
      "id": "ti",
      "term": "Throw-in",
      "definition": "Ball crosses touchline; the last toucher's opponents restart"
    },
    {
      "id": "gk",
      "term": "Goal kick",
      "definition": "Attackers put it over the goal line; defenders restart"
    },
    {
      "id": "ck",
      "term": "Corner kick",
      "definition": "Defenders put it over their own goal line"
    },
    {
      "id": "pk",
      "term": "Penalty kick",
      "definition": "Defender fouls inside his own penalty area"
    }
  ],
  "distractorDefinitions": [
    "Ball goes out after the referee blows halftime"
  ],
  "explanation": {
    "summary": "Who last touched the ball, and which line it crossed, decides the restart."
  }
}
```

### sequence-order

Order-of-events concepts: the knockout tiebreak ladder, the Champions League path, a build-up.

**Knockout tiebreak** (`so-tiebreak`, concept `extra-time-shootout`)

```json
{
  "prompt": "Order a knockout tie's path to a winner.",
  "items": [
    {
      "id": "regular",
      "text": "90 minutes of regulation",
      "why": "Two halves of 45 plus stoppage time."
    },
    {
      "id": "et",
      "text": "30 minutes of extra time",
      "why": "Two 15-minute periods if still level."
    },
    {
      "id": "shootout",
      "text": "Five penalties each",
      "why": "Alternating kicks; most goals wins."
    },
    {
      "id": "sudden",
      "text": "Sudden-death kicks",
      "why": "If still level, one miss loses once both have kicked."
    }
  ],
  "explanation": {
    "correct": "That is the ladder: 90, then 30, then five kicks each, then sudden death.",
    "incorrect": "Play always goes 90 minutes, then extra time, then a shootout, then sudden death.",
    "sayThisLine": "It went all the way to sudden death."
  }
}
```

**Champions League run** (`so-ucl-run`, concept `ucl-league-phase`)

```json
{
  "prompt": "Order a 2026/27 Champions League path.",
  "items": [
    {
      "id": "lp",
      "text": "League phase (eight matches)",
      "why": "One table of 36 clubs."
    },
    {
      "id": "po",
      "text": "Knockout playoff (ranked 9-24)",
      "why": "Two legs; the top eight skip it."
    },
    {
      "id": "r16",
      "text": "Round of 16",
      "why": "Top eight join the playoff winners."
    },
    {
      "id": "qf",
      "text": "Quarter-finals",
      "why": "Two legs."
    },
    {
      "id": "sf",
      "text": "Semi-finals",
      "why": "Two legs."
    },
    {
      "id": "final",
      "text": "The final",
      "why": "One match, neutral venue."
    }
  ],
  "explanation": {
    "correct": "League phase, playoff for 9-24, then the bracket.",
    "incorrect": "Top eight go straight to the last 16; 9-24 play a two-leg playoff first.",
    "sayThisLine": "We need to finish top eight to skip the playoff."
  }
}
```

**Building an attack** (`so-buildup`, concept `build-up`)

```json
{
  "prompt": "Order a patient build-up.",
  "items": [
    {
      "id": "gk",
      "text": "Keeper starts the move"
    },
    {
      "id": "cb",
      "text": "Centre-back draws the press"
    },
    {
      "id": "pivot",
      "text": "Six receives between the lines"
    },
    {
      "id": "wing",
      "text": "Winger isolates the full-back"
    },
    {
      "id": "cross",
      "text": "Cutback into the box"
    },
    {
      "id": "shot",
      "text": "Shot"
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Build from the keeper through the lines, then the wide play, the delivery and the shot.",
    "incorrect": "Build-up goes back to front: keeper, defenders, midfield, wide play, delivery and shot.",
    "sayThisLine": "They build patiently from the back."
  }
}
```

### decision-scenario

Judgment: referee calls (DOGSO), manager calls (protect the lead), reading transfer news. Graded best/acceptable/poor. No `safetyNote` needed (not a safety course); do not use for injuries.

**Last man foul** (`ds-dogso`, concept `dogso`)

```json
{
  "prompt": "Defender hauls down a striker through on goal.",
  "situation": {
    "narrative": "You are refereeing.",
    "facts": [
      {
        "label": "Where",
        "value": "Just outside the area"
      },
      {
        "label": "Foul",
        "value": "Pulled shirt, striker falls"
      },
      {
        "label": "Goal distance",
        "value": "About 20 yards"
      },
      {
        "label": "Other defenders",
        "value": "None close",
        "emphasis": "warning"
      },
      {
        "label": "Ball control",
        "value": "Striker had it under control"
      }
    ]
  },
  "options": [
    {
      "id": "red",
      "label": "Red card for denying the chance",
      "verdict": "best",
      "consequence": "Direct free kick and a sending-off. The team plays a man down.",
      "considerations": [
        "Goal was close",
        "No defender could recover",
        "Ball under control"
      ]
    },
    {
      "id": "yellow",
      "label": "Yellow card only",
      "verdict": "poor",
      "consequence": "Fans and VAR see a missed red. The referee is criticised for lenient handling.",
      "considerations": [
        "The chance was clear",
        "Outside the area so yellow doesn't apply"
      ]
    },
    {
      "id": "advantage",
      "label": "Play advantage, decide later",
      "verdict": "acceptable",
      "consequence": "If he keeps the ball and shoots, fine. If not, go back for the card.",
      "considerations": [
        "Advantage fits when the chance stays alive",
        "Otherwise the card is still due"
      ]
    }
  ],
  "expertNote": "Referees weigh four things: distance to goal, direction of play, likelihood of keeping the ball and number of defenders close.",
  "sayThisLine": "That's DOGSO, last man, it has to be a red."
}
```

**Protect the lead** (`ds-lead`, concept `low-block`)

```json
{
  "prompt": "Leading 1-0 late. What does the manager change?",
  "situation": {
    "narrative": "You are the manager with 12 minutes to go.",
    "facts": [
      {
        "label": "Score",
        "value": "1-0 to you"
      },
      {
        "label": "Time",
        "value": "78 minutes"
      },
      {
        "label": "Opponent possession",
        "value": "65 percent"
      },
      {
        "label": "Your press",
        "value": "Tired, gaps opening",
        "emphasis": "warning"
      },
      {
        "label": "Bench",
        "value": "Fresh centre-back, fresh winger"
      }
    ]
  },
  "options": [
    {
      "id": "drop",
      "label": "Add a centre-back, drop into a low block",
      "verdict": "best",
      "consequence": "You protect the box and keep the shape; they must break you down.",
      "considerations": [
        "Tired press leaves gaps",
        "A low block protects the lead"
      ]
    },
    {
      "id": "attack",
      "label": "Add the winger and go for a second",
      "verdict": "acceptable",
      "consequence": "You might kill the game but risk a counter.",
      "considerations": [
        "A second goal ends it",
        "Leaves gaps behind"
      ]
    },
    {
      "id": "nothing",
      "label": "Change nothing and keep pressing high",
      "verdict": "poor",
      "consequence": "A tired press gets bypassed and the space behind you invites a goal.",
      "considerations": [
        "Legs are gone",
        "Higher risk than reward"
      ]
    }
  ],
  "expertNote": "Managers manage the game state as much as the tactics: when the press tires, protecting the box is often smarter than chasing a second goal.",
  "sayThisLine": "He should have gone to a back five to see it out."
}
```

**Transfer noise** (`ds-transfer`, concept `here-we-go`)

```json
{
  "prompt": "A tabloid says your fave player is done. Now what?",
  "situation": {
    "narrative": "You are scrolling before deadline day.",
    "facts": [
      {
        "label": "Source",
        "value": "Unnamed tabloid"
      },
      {
        "label": "Club statement",
        "value": "None"
      },
      {
        "label": "Trusted reporter",
        "value": "Has not posted"
      },
      {
        "label": "Time",
        "value": "Hours before deadline"
      }
    ]
  },
  "options": [
    {
      "id": "rumour",
      "label": "Treat it as a rumour until confirmed",
      "verdict": "best",
      "consequence": "You stay calm and wait for a club statement or a trusted reporter's here we go.",
      "considerations": [
        "Rumours often collapse",
        "Clubs confirm officially"
      ]
    },
    {
      "id": "post",
      "label": "Tell everyone it's done",
      "verdict": "poor",
      "consequence": "You look silly if it falls through, and you spread noise.",
      "considerations": [
        "No confirmation yet"
      ]
    },
    {
      "id": "panic",
      "label": "Assume the club has lost him",
      "verdict": "acceptable",
      "consequence": "You react to fear more than fact.",
      "considerations": [
        "Being cautious is fine, being sure isn't"
      ]
    }
  ],
  "expertNote": "Fans wait for a club statement or a trusted reporter's here we go before treating a transfer as real.",
  "sayThisLine": "I'll believe it when it's official."
}
```

### timing-tap

1D clock rules only: the 8-second keeper rule, the 5-second restart countdown and penalty patience. Sweep and zones per the schema.

**Keeper's eight seconds** (`ti-eight`, concept `goalkeeper-eight-seconds`)

```json
{
  "prompt": "Tap the moment the keeper's eight seconds run out.",
  "theme": {
    "label": "Keeper clock",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 76,
      "zoneEndPct": 84,
      "sweepSeconds": 3.2
    },
    {
      "zoneStartPct": 78,
      "zoneEndPct": 83,
      "sweepSeconds": 2.6
    },
    {
      "zoneStartPct": 79,
      "zoneEndPct": 82,
      "sweepSeconds": 2.2
    }
  ],
  "explanation": {
    "correct": "Sharp. The eight-second rule concedes a corner, and the referee counts down the last five with a raised hand.",
    "incorrect": "A keeper holding the ball too long concedes a corner. The referee raises a hand to count the last five seconds.",
    "sayThisLine": "He held it too long, that's a corner."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Restart countdown** (`ti-countdown`, concept `time-wasting-countdown`)

```json
{
  "prompt": "Tap when the five-second restart countdown ends.",
  "theme": {
    "label": "Restart clock",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 90,
      "zoneEndPct": 100,
      "sweepSeconds": 3.0
    },
    {
      "zoneStartPct": 92,
      "zoneEndPct": 100,
      "sweepSeconds": 2.4
    },
    {
      "zoneStartPct": 94,
      "zoneEndPct": 100,
      "sweepSeconds": 2.0
    }
  ],
  "explanation": {
    "correct": "Right. New for 2026/27: after the visual five-second countdown a delayed throw-in flips to the opponents and a delayed goal kick becomes their corner.",
    "incorrect": "If the ball isn't in play when the countdown ends, the throw-in flips to the other team.",
    "sayThisLine": "They can't stall like that any more."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Penalty patience** (`ti-penalty`, concept `penalty-strategy`)

```json
{
  "prompt": "Tap when the keeper commits to a dive.",
  "theme": {
    "label": "Penalty duel",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 48,
      "zoneEndPct": 62,
      "sweepSeconds": 2.0
    },
    {
      "zoneStartPct": 52,
      "zoneEndPct": 62,
      "sweepSeconds": 1.7
    },
    {
      "zoneStartPct": 54,
      "zoneEndPct": 61,
      "sweepSeconds": 1.4
    }
  ],
  "explanation": {
    "correct": "Composed. Penalty takers wait for the keeper's weight to commit, then pick the other corner.",
    "incorrect": "Shooting early gives the keeper a clean read. The patient taker waits until the keeper's weight moves.",
    "sayThisLine": "He waited, the keeper moved, easy."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

### say-this

Decoding fan lines; concept selection, translation and follow-up lines. Always with a `noFakeExpertNote`.

**Parked the bus** (`st-parked`, concept `low-block`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "They parked the bus and nicked one on the break."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "A team defending deep and compact",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A team that arrived late",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A counterattack goal",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "A transfer",
      "isCorrect": false
    }
  ],
  "translation": "The other team defended deep with everyone behind the ball, then scored quickly on a counterattack.",
  "followUps": [
    {
      "line": "Did they sit in a low block all game?",
      "why": "Uses the actual term and asks a real question."
    },
    {
      "line": "Who scored the counter?",
      "why": "Turns the slang into curiosity about the moment."
    }
  ],
  "noFakeExpertNote": "If you don't know the team, ask what happened."
}
```

**Back three** (`st-back-three`, concept `back-three`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Our back three got pulled apart down the channels all night."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "Three centre-backs being stretched",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The three referees",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "Space between the centre-backs and full-backs",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "The team bus",
      "isCorrect": false
    }
  ],
  "translation": "Her team plays with three centre-backs, and opposing attackers ran into the gaps beside them.",
  "followUps": [
    {
      "line": "Do your wing-backs get back in time?",
      "why": "Shows you know wing-backs cover the wide gaps."
    }
  ],
  "noFakeExpertNote": "You don't have to know the shape, just ask how they line up."
}
```

**xG remark** (`st-xg`, concept `xg`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "We lost 1-0 but the xG was 2.3 to 0.4. Robbed."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "Her team created much better chances",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Extra time goals",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A statistic about shot quality",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "The referee's score",
      "isCorrect": false
    }
  ],
  "translation": "Her team created higher-quality chances than the opponent, but did not score, so she feels the result was unlucky.",
  "followUps": [
    {
      "line": "Who missed the big chance?",
      "why": "Moves straight to the moment she is thinking about."
    }
  ],
  "noFakeExpertNote": "It's fine to say you're new to xG and ask her to explain."
}
```

**Set-piece coach** (`st-set-piece`, concept `set-piece-marking`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Honestly the set-piece coach is our MVP."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "A specialist who designs corner and free-kick routines",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The ticket seller",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "The reason they score from corners",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "The physio",
      "isCorrect": false
    }
  ],
  "translation": "Her team scores many goals from corners and free kicks, and she credits the coach who plans them.",
  "followUps": [
    {
      "line": "Is that near-post flick planned?",
      "why": "Shows you noticed a specific set-piece routine."
    }
  ],
  "noFakeExpertNote": "Ask her to describe her favourite routine."
}
```

### fill-the-gap

Vocabulary in context and rule statements (formations, keeper rule, offside).

**Front three** (`fg-433`, concept `four-three-three`)

```json
{
  "prompt": "Complete the 4-3-3.",
  "template": "In a 4-3-3 the front three are two {{wide}} and one {{central}}.",
  "gaps": [
    {
      "id": "wide",
      "options": [
        "wingers",
        "full-backs"
      ],
      "correct": "wingers"
    },
    {
      "id": "central",
      "options": [
        "striker",
        "keeper"
      ],
      "correct": "striker"
    }
  ],
  "explanation": {
    "correct": "Right. The wingers hug the touchlines and the striker leads the line.",
    "incorrect": "The front three are two wingers and a striker; full-backs and keepers are behind them."
  }
}
```

**Keeper rule** (`fg-eight`, concept `goalkeeper-eight-seconds`)

```json
{
  "prompt": "Complete the keeper rule.",
  "template": "A keeper who holds it over {{secs}} seconds concedes a {{restart}}.",
  "gaps": [
    {
      "id": "secs",
      "options": [
        "six",
        "eight",
        "ten"
      ],
      "correct": "eight"
    },
    {
      "id": "restart",
      "options": [
        "corner",
        "penalty",
        "free kick"
      ],
      "correct": "corner"
    }
  ],
  "explanation": {
    "correct": "Yes. Eight seconds, and the punishment is a corner.",
    "incorrect": "It is eight seconds, and the opponents get a corner.",
    "sayThisLine": "He has to release it, or it's a corner."
  }
}
```

**Level is onside** (`fg-level`, concept `level-is-onside`)

```json
{
  "prompt": "Complete the offside rule.",
  "template": "An attacker level with the last defender is {{state}} because level is {{answer}}.",
  "gaps": [
    {
      "id": "state",
      "options": [
        "onside",
        "offside"
      ],
      "correct": "onside"
    },
    {
      "id": "answer",
      "options": [
        "onside",
        "offside"
      ],
      "correct": "onside"
    }
  ],
  "explanation": {
    "correct": "Exactly. Level is onside, so the attacker gets the benefit of the doubt.",
    "incorrect": "Level with the second-last defender counts as onside.",
    "sayThisLine": "Level is onside, so the goal stands."
  }
}
```

### estimate-slider

Magnitudes: World Cup teams, penalty xG, league-phase matches.

**World Cup teams** (`es-wc-teams`, concept `wc-format-48`)

```json
{
  "prompt": "How many teams played the 2026 World Cup?",
  "unit": "teams",
  "min": 16,
  "max": 64,
  "step": 4,
  "correctValue": 48,
  "tolerance": {
    "full": 0,
    "partial": 8
  },
  "explanation": {
    "correct": "Yes. The first 48-team World Cup: twelve groups of four.",
    "incorrect": "It was 48 teams, up from 32, in twelve groups of four.",
    "sayThisLine": "Forty-eight teams, and the best third-placed teams went through."
  }
}
```

**Penalty xG** (`es-penalty-xg`, concept `xg`)

```json
{
  "prompt": "What is a typical penalty's xG?",
  "unit": "xG",
  "min": 0,
  "max": 1,
  "step": 0.05,
  "correctValue": 0.77,
  "tolerance": {
    "full": 0.05,
    "partial": 0.15
  },
  "explanation": {
    "correct": "Close. Penalties convert around three times in four, so models give them about 0.76 to 0.78.",
    "incorrect": "Penalties are scored about 75 to 80 percent of the time, so a typical penalty xG is about 0.77."
  }
}
```

**League-phase games** (`es-ucl-games`, concept `ucl-league-phase`)

```json
{
  "prompt": "How many league-phase games per Champions League club?",
  "unit": "matches",
  "min": 4,
  "max": 14,
  "step": 1,
  "correctValue": 8,
  "tolerance": {
    "full": 0,
    "partial": 1
  },
  "explanation": {
    "correct": "Right. Eight matches against eight different opponents: four home and four away.",
    "incorrect": "It's eight matches: four home and four away against eight different opponents.",
    "sayThisLine": "Eight games and the table decides everything."
  }
}
```

### hotspot-tap

Pitch markings, positions in a shape, half-spaces on procedural diagrams (ids listed in NOTES_FOR_ORCHESTRATOR.md).

**Six-yard box** (`ht-six-yard`, concept `pitch-markings`)

```json
{
  "prompt": "Tap the six-yard box.",
  "diagram": {
    "diagramId": "soccer-pitch-attacking-third",
    "aspectRatio": 1.2,
    "alt": "Attacking third of a pitch showing the goal, six-yard box, penalty area, penalty spot and arc."
  },
  "hotspots": [
    {
      "id": "six",
      "label": "Six-yard box",
      "shape": {
        "kind": "rect",
        "x": 0.4,
        "y": 0.02,
        "w": 0.2,
        "h": 0.1
      }
    },
    {
      "id": "area",
      "label": "Penalty area",
      "shape": {
        "kind": "rect",
        "x": 0.25,
        "y": 0.02,
        "w": 0.5,
        "h": 0.28
      }
    },
    {
      "id": "spot",
      "label": "Penalty spot",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.2,
        "r": 0.04
      }
    },
    {
      "id": "arc",
      "label": "Penalty arc",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.34,
        "r": 0.06
      }
    }
  ],
  "correctHotspotIds": [
    "six"
  ],
  "explanation": {
    "correct": "Right. The six-yard box sits inside the bigger penalty area and is where goal kicks are taken from.",
    "incorrect": "The six-yard box is the smaller rectangle right in front of goal, inside the penalty area."
  }
}
```

**Half-space** (`ht-half-space`, concept `half-spaces`)

```json
{
  "prompt": "Tap the left half-space.",
  "diagram": {
    "diagramId": "soccer-pitch-thirds",
    "aspectRatio": 0.8,
    "alt": "Pitch split into five vertical channels: wide left, left half-space, centre, right half-space and wide right."
  },
  "hotspots": [
    {
      "id": "wide-left",
      "label": "Wide left channel",
      "shape": {
        "kind": "rect",
        "x": 0.0,
        "y": 0.1,
        "w": 0.18,
        "h": 0.8
      }
    },
    {
      "id": "half-left",
      "label": "Left half-space",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.1,
        "w": 0.18,
        "h": 0.8
      }
    },
    {
      "id": "centre",
      "label": "Central channel",
      "shape": {
        "kind": "rect",
        "x": 0.4,
        "y": 0.1,
        "w": 0.2,
        "h": 0.8
      }
    },
    {
      "id": "half-right",
      "label": "Right half-space",
      "shape": {
        "kind": "rect",
        "x": 0.62,
        "y": 0.1,
        "w": 0.18,
        "h": 0.8
      }
    }
  ],
  "correctHotspotIds": [
    "half-left"
  ],
  "explanation": {
    "correct": "Right. The half-space sits between the touchline and the centre; creators love receiving there.",
    "incorrect": "The half-space is the channel between the wide lane and the central lane.",
    "sayThisLine": "He lives in the half-space, between the full-back and centre-back."
  }
}
```

**Find the six** (`ht-find-six`, concept `defensive-midfielder`)

```json
{
  "prompt": "Tap the defensive midfielder in this 4-3-3.",
  "diagram": {
    "diagramId": "soccer-433-shape",
    "aspectRatio": 0.8,
    "alt": "Overhead diagram of a 4-3-3: keeper, back four, one deep midfielder with two ahead of him, and a front three."
  },
  "hotspots": [
    {
      "id": "keeper",
      "label": "Goalkeeper",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.92,
        "r": 0.05
      }
    },
    {
      "id": "dm",
      "label": "Deep midfielder",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.58,
        "r": 0.05
      }
    },
    {
      "id": "cm-left",
      "label": "Left central midfielder",
      "shape": {
        "kind": "circle",
        "cx": 0.3,
        "cy": 0.46,
        "r": 0.05
      }
    },
    {
      "id": "cm-right",
      "label": "Right central midfielder",
      "shape": {
        "kind": "circle",
        "cx": 0.7,
        "cy": 0.46,
        "r": 0.05
      }
    },
    {
      "id": "st",
      "label": "Striker",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.12,
        "r": 0.05
      }
    }
  ],
  "correctHotspotIds": [
    "dm"
  ],
  "explanation": {
    "correct": "Nice. The six sits deepest of the three midfielders and screens the back four.",
    "incorrect": "In a 4-3-3 with one holder, the six is the deepest of the midfield three.",
    "sayThisLine": "That's your six, he protects the back four."
  }
}
```

## 3. Talk Track scenarios (8 authored)

Each scenario is one exchange with a good, a meh and a cringe reply. The JSON payload is in the last subsection.

### After a heartbreak loss (`talk-after-loss`)

- **Setting:** She texts after her team loses a derby.
- **Enthusiast line:** "Ninety-eighth minute. NINETY-EIGHTH. I can't even."
- **What it means:** She is hurting; she wants empathy first and football second.

| Reply | Text | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Good | "That is brutal. Which moment hurt most?" | +24 | "The equaliser. We were so close." | Empathy first, then a real question. |
| Meh | "Ah well, it's just a game." | -6 | "Sure, thanks." | True but cold. |
| Cringe | "Told you they'd bottle it." | -18 | "...Wow." | Never gloat. |

### She loves corners (`talk-set-piece`)

- **Setting:** She is excited about a corner goal.
- **Enthusiast line:** "That near post flick was so well drilled!!"
- **What it means:** She noticed a rehearsed routine, a near-post flick and a far-post tap-in.

| Reply | Text | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Good | "Was that a planned routine? The far post man was waiting." | +28 | "YES. They rehearse it." | Names the near/far post idea. |
| Meh | "Nice goal." | +4 | "Thanks!" | Fine but flat. |
| Cringe | "Corners are luck." | -15 | "Excuse me??" | Corners are the opposite of luck. |

### The offside goal (`talk-offside`)

- **Setting:** She is angry about a disallowed goal.
- **Enthusiast line:** "Offside by a TOENAIL. Literally a toenail!"
- **What it means:** She thinks VAR was harsh; the semi-automated line said offside by a toe.

| Reply | Text | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Good | "Toenail? Do you think they should change the rule?" | +26 | "Daylight rule, honestly." | Invites the offside debate. |
| Meh | "Rules are rules." | -4 | "Sure." | True but conversation-ending. |
| Cringe | "VAR is always right." | -16 | "Are you serious?" | Don't defend tech to a fan mid-rage. |

### Her team pressed high (`talk-press`)

- **Setting:** She praises her team's pressing.
- **Enthusiast line:** "They pressed like maniacs, won it high and scored in six seconds."
- **What it means:** She is talking about a pressing trigger and high press that won the ball in the attacking third.

| Reply | Text | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Good | "That press trigger was the back pass, right?" | +28 | "Exactly! They all jump on it." | Shows you spotted the trigger. |
| Meh | "Cool. Was it a nice goal?" | +6 | "Yes!" | Fine but generic. |
| Cringe | "Pressing is boring." | -14 | "..." | Never dismiss what she loves. |

### Transfer news (`talk-transfer`)

- **Setting:** She is nervous about a star player.
- **Enthusiast line:** "Apparently he's leaving in January?? Please no."
- **What it means:** She read a rumour; 'here we go' means it's real, otherwise it is speculation.

| Reply | Text | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Good | "Is it confirmed or just a rumour? I'd wait for the club statement." | +22 | "Rumour so far. Fingers crossed." | Calm and curious. |
| Meh | "Everyone leaves eventually." | -6 | "Thanks for the cheer." | Accurate, unhelpful. |
| Cringe | "Told you he's overrated." | -18 | "Wow." | Never dunk on her favourite. |

### Numbers night (`talk-xg`)

- **Setting:** She defends her team with xG.
- **Enthusiast line:** "We lost but the xG says we won. Stats don't lie!"
- **What it means:** She is using xG to argue her team was unlucky.

| Reply | Text | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Good | "Fair, but does xG count the big chance he skied?" | +18 | "Ha, fine, the miss was awful." | Gently engages; xG is a model. |
| Meh | "What's xG?" | +8 | "Expected goals, shot quality!" | Honest question is fine. |
| Cringe | "xG is nonsense." | -15 | "You didn't even try to understand." | Don't fake expertise or dismiss. |

### Derby banter (`talk-derby`)

- **Setting:** She teases you about a rival.
- **Enthusiast line:** "Enjoy second place while it lasts."
- **What it means:** She is enjoying friendly rivalry.

| Reply | Text | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Good | "Cute. Come back with the head-to-head after the derby." | +22 | "Deal." | Banter with a wink. |
| Meh | "We'll see." | +2 | "Sure!" | Safe but flat. |
| Cringe | "Your team is trash." | -20 | "Wow, okay." | Banter, not insults. |

### World Cup memories (`talk-world-cup`)

- **Setting:** She is reminiscing about the 2026 final.
- **Enthusiast line:** "Torres in the 106th minute. I still get chills."
- **What it means:** She refers to Spain beating Argentina 1-0 in extra time.

| Reply | Text | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Good | "That final was wild. Where did you watch it?" | +26 | "With my dad at a bar!" | Memory question opens the door. |
| Meh | "Yeah, Spain deserved it." | +6 | "They did." | Fine opinion, no question. |
| Cringe | "Argentina were robbed." | -6 | "Excuse me?" | Opinion without curiosity can backfire. |

### Talk-track payloads (schema-valid)

**After a heartbreak loss** (`talk-after-loss`)

```json
{
  "title": "After a heartbreak loss",
  "setting": "She texts after her team loses a derby.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Ninety-eighth minute. NINETY-EIGHTH. I can't even.",
      "replies": [
        {
          "id": "a",
          "text": "That is brutal. Which moment hurt most?",
          "smoothDelta": 24,
          "theirResponse": "The equaliser. We were so close.",
          "coachNote": "Empathy first, then a real question."
        },
        {
          "id": "b",
          "text": "Ah well, it's just a game.",
          "smoothDelta": -6,
          "theirResponse": "Sure, thanks.",
          "coachNote": "True but cold."
        },
        {
          "id": "c",
          "text": "Told you they'd bottle it.",
          "smoothDelta": -18,
          "theirResponse": "...Wow.",
          "coachNote": "Never gloat."
        }
      ]
    }
  ],
  "closingNote": "She is hurting; she wants empathy first and football second."
}
```

**She loves corners** (`talk-set-piece`)

```json
{
  "title": "She loves corners",
  "setting": "She is excited about a corner goal.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "That near post flick was so well drilled!!",
      "replies": [
        {
          "id": "a",
          "text": "Was that a planned routine? The far post man was waiting.",
          "smoothDelta": 28,
          "theirResponse": "YES. They rehearse it.",
          "coachNote": "Names the near/far post idea."
        },
        {
          "id": "b",
          "text": "Nice goal.",
          "smoothDelta": 4,
          "theirResponse": "Thanks!",
          "coachNote": "Fine but flat."
        },
        {
          "id": "c",
          "text": "Corners are luck.",
          "smoothDelta": -15,
          "theirResponse": "Excuse me??",
          "coachNote": "Corners are the opposite of luck."
        }
      ]
    }
  ],
  "closingNote": "She noticed a rehearsed routine, a near-post flick and a far-post tap-in."
}
```

**The offside goal** (`talk-offside`)

```json
{
  "title": "The offside goal",
  "setting": "She is angry about a disallowed goal.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Offside by a TOENAIL. Literally a toenail!",
      "replies": [
        {
          "id": "a",
          "text": "Toenail? Do you think they should change the rule?",
          "smoothDelta": 26,
          "theirResponse": "Daylight rule, honestly.",
          "coachNote": "Invites the offside debate."
        },
        {
          "id": "b",
          "text": "Rules are rules.",
          "smoothDelta": -4,
          "theirResponse": "Sure.",
          "coachNote": "True but conversation-ending."
        },
        {
          "id": "c",
          "text": "VAR is always right.",
          "smoothDelta": -16,
          "theirResponse": "Are you serious?",
          "coachNote": "Don't defend tech to a fan mid-rage."
        }
      ]
    }
  ],
  "closingNote": "She thinks VAR was harsh; the semi-automated line said offside by a toe."
}
```

**Her team pressed high** (`talk-press`)

```json
{
  "title": "Her team pressed high",
  "setting": "She praises her team's pressing.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They pressed like maniacs, won it high and scored in six seconds.",
      "replies": [
        {
          "id": "a",
          "text": "That press trigger was the back pass, right?",
          "smoothDelta": 28,
          "theirResponse": "Exactly! They all jump on it.",
          "coachNote": "Shows you spotted the trigger."
        },
        {
          "id": "b",
          "text": "Cool. Was it a nice goal?",
          "smoothDelta": 6,
          "theirResponse": "Yes!",
          "coachNote": "Fine but generic."
        },
        {
          "id": "c",
          "text": "Pressing is boring.",
          "smoothDelta": -14,
          "theirResponse": "...",
          "coachNote": "Never dismiss what she loves."
        }
      ]
    }
  ],
  "closingNote": "She is talking about a pressing trigger and high press that won the ball in the attacking third."
}
```

**Transfer news** (`talk-transfer`)

```json
{
  "title": "Transfer news",
  "setting": "She is nervous about a star player.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Apparently he's leaving in January?? Please no.",
      "replies": [
        {
          "id": "a",
          "text": "Is it confirmed or just a rumour? I'd wait for the club statement.",
          "smoothDelta": 22,
          "theirResponse": "Rumour so far. Fingers crossed.",
          "coachNote": "Calm and curious."
        },
        {
          "id": "b",
          "text": "Everyone leaves eventually.",
          "smoothDelta": -6,
          "theirResponse": "Thanks for the cheer.",
          "coachNote": "Accurate, unhelpful."
        },
        {
          "id": "c",
          "text": "Told you he's overrated.",
          "smoothDelta": -18,
          "theirResponse": "Wow.",
          "coachNote": "Never dunk on her favourite."
        }
      ]
    }
  ],
  "closingNote": "She read a rumour; 'here we go' means it's real, otherwise it is speculation."
}
```

**Numbers night** (`talk-xg`)

```json
{
  "title": "Numbers night",
  "setting": "She defends her team with xG.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We lost but the xG says we won. Stats don't lie!",
      "replies": [
        {
          "id": "a",
          "text": "Fair, but does xG count the big chance he skied?",
          "smoothDelta": 18,
          "theirResponse": "Ha, fine, the miss was awful.",
          "coachNote": "Gently engages; xG is a model."
        },
        {
          "id": "b",
          "text": "What's xG?",
          "smoothDelta": 8,
          "theirResponse": "Expected goals, shot quality!",
          "coachNote": "Honest question is fine."
        },
        {
          "id": "c",
          "text": "xG is nonsense.",
          "smoothDelta": -15,
          "theirResponse": "You didn't even try to understand.",
          "coachNote": "Don't fake expertise or dismiss."
        }
      ]
    }
  ],
  "closingNote": "She is using xG to argue her team was unlucky."
}
```

**Derby banter** (`talk-derby`)

```json
{
  "title": "Derby banter",
  "setting": "She teases you about a rival.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Enjoy second place while it lasts.",
      "replies": [
        {
          "id": "a",
          "text": "Cute. Come back with the head-to-head after the derby.",
          "smoothDelta": 22,
          "theirResponse": "Deal.",
          "coachNote": "Banter with a wink."
        },
        {
          "id": "b",
          "text": "We'll see.",
          "smoothDelta": 2,
          "theirResponse": "Sure!",
          "coachNote": "Safe but flat."
        },
        {
          "id": "c",
          "text": "Your team is trash.",
          "smoothDelta": -20,
          "theirResponse": "Wow, okay.",
          "coachNote": "Banter, not insults."
        }
      ]
    }
  ],
  "closingNote": "She is enjoying friendly rivalry."
}
```

**World Cup memories** (`talk-world-cup`)

```json
{
  "title": "World Cup memories",
  "setting": "She is reminiscing about the 2026 final.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Torres in the 106th minute. I still get chills.",
      "replies": [
        {
          "id": "a",
          "text": "That final was wild. Where did you watch it?",
          "smoothDelta": 26,
          "theirResponse": "With my dad at a bar!",
          "coachNote": "Memory question opens the door."
        },
        {
          "id": "b",
          "text": "Yeah, Spain deserved it.",
          "smoothDelta": 6,
          "theirResponse": "They did.",
          "coachNote": "Fine opinion, no question."
        },
        {
          "id": "c",
          "text": "Argentina were robbed.",
          "smoothDelta": -6,
          "theirResponse": "Excuse me?",
          "coachNote": "Opinion without curiosity can backfire."
        }
      ]
    }
  ],
  "closingNote": "She refers to Spain beating Argentina 1-0 in extra time."
}
```

## 4. Playbook terms

Every concept the course teaches, with a definition and an example line in a fan's voice. These become `concepts[]` in the curriculum JSON (`exampleLine`).

| id | Term | Tier | Definition | Example line |
|---|---|---|---|---|
| `match-length` | 90 minutes | foundations | A match is two 45-minute halves, and the clock never stops for fouls or the ball going out. | "It's ninety minutes and the clock doesn't stop, so nobody's ever really out of it." |
| `stoppage-time` | Stoppage time | foundations | Extra minutes the referee adds at the end of each half to make up for time lost to goals, injuries and delays. | "Six minutes added on and they're still throwing bodies forward." |
| `goal` | Goal | foundations | A goal counts when the whole ball crosses the whole goal line between the posts and under the crossbar. | "Whole ball over the line, or it's not a goal." |
| `out-of-play` | Out of play | foundations | The ball is out when all of it crosses a touchline or goal line, or the referee stops the game. | "It's the whole ball over the line, not just a bit of it." |
| `throw-in` | Throw-in | foundations | Restart from the touchline for the team that did not touch the ball last, taken with both hands over the head. | "That's their throw, it came off our player last." |
| `goal-kick` | Goal kick | foundations | Restart taken by the defending team from its own six-yard box after the attackers put the ball over the goal line. | "Quick goal kick, they've all pushed up." |
| `corner-kick` | Corner kick | foundations | Restart from the corner arc when the defenders put the ball over their own goal line; you can score directly from it. | "We get a corner every time we push them back, and that's where we're dangerous." |
| `direct-indirect-free-kick` | Direct vs indirect free kick | foundations | A direct free kick can score straight away; an indirect one must touch another player first. | "That's an indirect one, so he can't just shoot it straight in." |
| `penalty-kick` | Penalty kick | foundations | A one-on-one shot from 12 yards awarded for a foul by a defender inside their own penalty area. | "That's a penalty, the foul was inside the box." |
| `extra-time-shootout` | Extra time and shootout | foundations | Knockout ties level after 90 minutes go to two 15-minute periods, then a penalty shootout if still level. | "It'll go to penalties, I can't watch." |
| `aggregate-tie` | Two-legged tie | foundations | Some knockout rounds are played home and away; the combined score decides it, and away goals no longer count double. | "It's 2-1 on aggregate, so they only need one goal in the second leg." |
| `three-points` | Three points for a win | foundations | A league win earns three points, a draw one and a loss none; the table is ranked on points. | "A draw feels like a loss when you're chasing the title." |
| `clean-sheet` | Clean sheet | foundations | A match in which a team concedes no goals. | "Fourth clean sheet in a row, that back four is locked in." |
| `hat-trick` | Hat-trick and brace | foundations | Three goals by one player in a match is a hat-trick; two is a brace. | "He got a hat-trick in the first half, absolutely ridiculous." |
| `pitch-markings` | Pitch markings | foundations | The penalty area, six-yard box, penalty spot, centre circle and halfway line frame most of the rules. | "He fouled him just inside the eighteen-yard box." |
| `squad-substitutes` | Starting eleven and subs | foundations | Each side starts 11 players; leagues typically allow five substitutions in three windows plus half-time. | "Making a double change at the hour mark, he's trying to change the game." |
| `captain-armband` | Captain | foundations | One player per team wears the armband, speaks to the referee and represents the team. | "Only the captain is supposed to talk to the ref." |
| `foul` | Foul | foundations | Careless, reckless or excessive-force contact such as a kick, trip, push or charge gets a direct free kick or a penalty. | "That was a clear foul, he got nothing of the ball." |
| `yellow-card` | Yellow card | foundations | A caution for unsporting behaviour, dissent, persistent fouls or tactical fouls; two yellows in a match mean a red. | "He's on a yellow already so he has to be careful." |
| `red-card` | Red card | foundations | A sending-off for serious foul play, violent conduct, denying a goal-scoring chance or a second yellow; the team plays a man down. | "Down to ten men for the whole second half, that's game over." |
| `advantage` | Advantage | foundations | The referee lets play continue after a foul if the fouled team benefits, and can go back for the foul if it does not. | "Great advantage, the ref let him run on." |
| `dogso` | Denying a goal-scoring opportunity | foundations | Fouling an attacker who had a clear goal chance is a red card, or a yellow if it is a penalty and the defender challenged for the ball. | "Last man, DOGSO, straight red." |
| `handball` | Handball | foundations | Deliberately touching the ball with hand or arm, or making the body unnaturally bigger, is an offence; the shoulder is not the arm. | "His arm was out, natural position or not, that's the debate." |
| `simulation` | Simulation (diving) | foundations | Pretending to be fouled to win a free kick or penalty is a yellow card offence. | "He went down way too easily, that's a dive." |
| `referee-crew` | The officials | foundations | A referee, two assistants on the touchlines, a fourth official at the bench and video officials in a room. | "The assistant flagged, the ref went to the monitor." |
| `wall-distance` | Defensive wall | foundations | Defenders must stand at least 9.15 m (10 yards) from the ball at a free kick, usually lined up as a wall. | "Look how far back they've made the wall stand." |
| `backpass-rule` | Back-pass rule | foundations | A goalkeeper may not handle the ball if a teammate deliberately kicks it to him. | "He has to use his feet there, he can't pick that up." |
| `goalkeeper-eight-seconds` | Eight-second goalkeeper rule | foundations | A goalkeeper who holds the ball longer than eight seconds concedes a corner, with a visible five-second countdown at the end. | "He's holding it too long, the ref's counting down with his hand." |
| `time-wasting-countdown` | Restart countdown | intermediate | New for 2026/27: a five-second visual countdown on delayed throw-ins and goal kicks, then possession or a corner goes to the other side. | "They're stalling but the ref's got the countdown up now." |
| `dissent` | Dissent | foundations | Arguing with or abusing the referee is a yellow card offence; leagues now stress captain-only conversations. | "That's a yellow for dissent, you can't shout at the ref." |
| `professional-foul` | Tactical foul | foundations | Stopping a promising counter with a deliberate foul, usually for a yellow, to break the momentum. | "Great tactical foul, he took the yellow to stop the counter." |
| `injury-stoppage-rule` | Injury off-field rule | intermediate | A player treated on the pitch must stay off for at least one minute after play restarts, under the 2026/27 clarification. | "He has to go off for a minute after treatment now." |
| `goalkeeper` | Goalkeeper | foundations | The only player allowed to use hands (inside their own penalty area), and the last line of defence. | "The keeper had a monster game, three saves in one-on-ones." |
| `centre-back` | Centre-back | foundations | A central defender who marks strikers, wins headers and organises the defensive line. | "He's a proper old-school centre-back, all timing and heading." |
| `full-back` | Full-back | foundations | A wide defender on the left or right who defends the flank and often overlaps to attack. | "Our right-back gets forward more than the winger." |
| `wing-back` | Wing-back | foundations | A wide player in a back-three system who covers the whole flank, attacking and defending. | "In a back five the wing-backs do double the running." |
| `defensive-midfielder` | Defensive midfielder (the 6) | foundations | A midfielder who sits in front of the defence to break up play and start attacks. | "We need a proper six, someone to screen the back line." |
| `central-midfielder` | Central midfielder (the 8) | foundations | A midfielder who links defence and attack and covers a lot of ground. | "He's the engine, an eight who does everything." |
| `attacking-midfielder` | Attacking midfielder (the 10) | foundations | A creative player just behind the striker who unlocks defences with passes. | "He's our number ten, everything goes through him." |
| `winger` | Winger | foundations | A wide attacker who beats full-backs, crosses or cuts inside to shoot. | "Their winger destroyed our full-back all night." |
| `striker` | Striker (the 9) | foundations | The main goalscorer who leads the line, finishes chances and holds up the ball. | "He's a proper nine, lives in the six-yard box." |
| `false-nine` | False nine | intermediate | A centre-forward who drops deep into midfield to drag defenders out of position and create space for others. | "He plays as a false nine so he's always dropping in." |
| `box-to-box` | Box-to-box midfielder | foundations | A midfielder who defends his own area and arrives late to attack the other. | "He covered every blade of grass, a proper box-to-box player." |
| `playmaker` | Playmaker | foundations | A player, often deep, who sets the tempo and finds the key pass. | "He's the metronome, the whole team plays through him." |
| `poacher` | Poacher | foundations | A striker whose game is being in the right place in the box for tap-ins and rebounds. | "He's a poacher, nothing fancy, just always there." |
| `sweeper-keeper` | Sweeper-keeper | intermediate | A goalkeeper who plays far off his line, sweeping up through balls and joining the build-up with his feet. | "Sweeper-keeper, he's basically an extra outfield player." |
| `shirt-numbers` | Shirt numbers | foundations | Traditional numbers hint at roles: 1 keeper, 2-5 defenders, 6-8 midfield, 10 creator, 9 striker, 7 and 11 wingers. | "He wears the 10 for a reason." |
| `league-table` | League table | foundations | Teams are ranked by points, then goal difference and other tiebreakers set by each league. | "We're third but only on goal difference." |
| `promotion-relegation` | Promotion and relegation | foundations | In most of the world the bottom teams drop down a division each season and the top of the lower one goes up. | "Three go down every year and it gets brutal at the bottom." |
| `domestic-cup` | Domestic cup | foundations | A knockout competition inside one country, such as the FA Cup, where small clubs can face giants. | "It's the cup, so anything can happen." |
| `continental-competitions` | Continental cups | foundations | UEFA runs the Champions League, Europa League and Conference League; qualification depends on league position. | "We need top four for the Champions League next season." |
| `transfer-window` | Transfer window | foundations | Fixed periods, usually summer and January, when clubs can register new players. | "It's deadline day, everything's happening." |
| `loan-and-fee` | Loan and transfer fee | foundations | A club buys a player's contract for a fee, or borrows him for a season on loan, sometimes with an option to buy. | "He's out on loan with an option to buy." |
| `contract-expiry` | Contract expiry | intermediate | A player in the last months of a contract can negotiate with other clubs and leave for free when it ends. | "His contract's up in the summer so he can go for free." |
| `academy-youth` | Academy | foundations | A club's youth system that develops players who might reach the first team or be sold. | "He came through the academy, proper local lad." |
| `manager-sporting-director` | Manager and sporting director | intermediate | The manager picks the team and tactics; the sporting director or head of football runs recruitment and long-term planning. | "The manager wanted him but the sporting director wouldn't pay the fee." |
| `financial-rules` | Spending rules | intermediate | Leagues limit spending with rules such as the Premier League's squad-cost rule, UEFA's squad cost ratio or the MLS salary cap. | "They got a points deduction for breaking the spending rules." |
| `derby` | Derby | foundations | A match between local rivals with extra history, noise and emotion. | "It's a derby, throw the form book out." |
| `supporters-groups` | Supporters' culture | foundations | Chants, banners (tifo), ultras and supporters' trusts are part of a club's identity, and owners sometimes clash with fans over them. | "The atmosphere was unreal, the whole end sang for ninety minutes." |
| `offside-position` | Offside position | foundations | An attacker is in an offside position if any part of the head, body or feet is nearer the opponents' goal line than both the ball and the second-last opponent. | "His shoulder was ahead of the last defender." |
| `offside-offence` | Offside offence | foundations | Being in an offside position is not an offence; it becomes one only when you play or touch the ball, or interfere as a teammate passes. | "Offside position, but he never touched it so no offence." |
| `level-is-onside` | Level is onside | foundations | An attacker level with the second-last defender is onside; the benefit of the doubt goes to the attacker. | "Level is onside, so it stands." |
| `active-play` | Involved in active play | intermediate | Offside applies only if the player interferes with play, interferes with an opponent, or gains an advantage from the position. | "He stood offside but he wasn't involved in the play." |
| `offside-body-parts` | Body parts for offside | intermediate | Head, body and feet count for offside; hands and arms (down to the bottom of the armpit) do not. | "Arms don't count, but his knee was past the line." |
| `deliberate-play` | Deliberate play | intermediate | If a defender deliberately plays the ball, the attacker who receives it is not offside; a deflection or block does not reset it. | "It was a deflection, not a deliberate play, so he was still offside." |
| `no-offside-restarts` | No offside from restarts | foundations | You cannot be offside from a throw-in, goal kick or corner kick. | "Can't be offside from a corner, so the goal stands." |
| `var-basics` | VAR | foundations | Video assistant referees can only intervene for goals, penalties, direct red cards and mistaken identity, and only for a clear and obvious error. | "VAR only steps in for a clear and obvious error." |
| `check-vs-review` | VAR check vs review | intermediate | VAR checks every incident silently; a review means the referee looks at a pitchside monitor or accepts advice. | "They've gone to the monitor, that's a review." |
| `saot` | Semi-automated offside | intermediate | Tracking cameras and limb data build a 3D offside line and animation in seconds, replacing hand-drawn lines. | "The graphic came out in about twenty seconds." |
| `var-new-reviews` | New VAR reviews 2026/27 | intermediate | VAR may now correct clearly wrong second yellows and mistaken identity, and review wrongly awarded corners where it can be done immediately. | "They can review a corner now, but only if it's quick." |
| `offside-trap` | Offside trap | intermediate | A defensive line steps up together at the moment of the pass to catch attackers offside. | "That's the trap, the whole back line stepped up together." |
| `offside-debates` | Offside debates | enthusiast | Fans argue over thin margins, and over proposals like the daylight rule where the attacker must be fully clear. | "Daylight offside would end the toenail goals, but it would change the game." |
| `formation-numbers` | Reading formations | foundations | 4-3-3 lists outfield players from defence to attack; the numbers count each line, not exact spots. | "We play a 4-2-3-1, so four at the back and one striker." |
| `back-four` | Back four | foundations | A defence of two centre-backs and two full-backs; the most common structure. | "A flat back four is easier to coordinate." |
| `back-three` | Back three | foundations | Three centre-backs with wing-backs, letting the team overload midfield or cover wide areas. | "A back three gives us an extra body to win the ball." |
| `four-three-three` | 4-3-3 | foundations | Four defenders, three central midfielders and a front three of two wingers and a striker. | "Our 4-3-3 stretches teams with the wingers hugging the touchlines." |
| `four-two-three-one` | 4-2-3-1 | foundations | Four defenders, two holding midfielders, three attacking players behind a lone striker. | "In a 4-2-3-1 the ten sits behind the nine." |
| `four-four-two` | 4-4-2 | foundations | Two banks of four with two strikers up front; compact and simple. | "4-4-2 is two banks of four, really hard to break down." |
| `in-out-possession-shape` | In and out of possession | intermediate | Teams shift shape: a 4-3-3 with the ball can become a 4-5-1 without it, or a 3-2-5 with full-backs tucked in. | "They look like a 4-3-3 but they build in a 3-2-5." |
| `compactness` | Compactness | foundations | Keeping gaps between lines and players small so the opposition has no space between them. | "They stayed compact, there were no gaps to play into." |
| `width-depth` | Width and depth | foundations | Attackers stretch the pitch sideways (width) and forwards and backwards (depth) to pull the defence apart. | "Width on the wing, depth from the striker, that's how you open a defence." |
| `half-spaces` | Half-spaces | intermediate | The vertical channels between the wide and central areas, a favourite place for creators to receive the ball. | "He lives in the half-space, between the full-back and centre-back." |
| `between-the-lines` | Between the lines | intermediate | The space between a defence's back line and its midfield line, where a turning attacker is dangerous. | "He got the ball between the lines and turned." |
| `passing-lanes` | Passing lanes | foundations | Paths between teammates that are not blocked by defenders; angles create lanes. | "No passing lane, so he had to go back." |
| `triangles` | Triangles | intermediate | Three players forming a triangle guarantee the ball carrier always has two passing options. | "Triangles everywhere, they always have an easy pass on." |
| `overload` | Overload | intermediate | Putting more players than the opponent has into one zone to create a free man. | "We overloaded the left and the right winger was free on the switch." |
| `switch-of-play` | Switch of play | foundations | A quick long pass from one flank to the other to attack the weak side. | "The switch was perfect, the winger had acres of space." |
| `build-up` | Build-up play | foundations | How a team moves the ball from the goalkeeper through the thirds to create a shot. | "They build up patiently from the back." |
| `play-out-from-back` | Playing out from the back | foundations | Goalkeeper and defenders pass short to escape pressure and draw opponents forward; risky but rewarding. | "Risky to play out from the back but when it works it's beautiful." |
| `progressive-pass` | Progressive pass | intermediate | A pass that moves the ball meaningfully closer to the opponent's goal. | "He plays progressive passes, always looking forward." |
| `through-ball` | Through ball | foundations | A pass into the space behind the defence for a runner. | "Lovely through ball, he split the defence." |
| `cross-cutback` | Cross and cutback | foundations | A cross is a ball from the wide area into the box; a cutback is a low pass from near the byline back towards the edge of the box. | "The cutback was better than the cross because it beats the keeper's line." |
| `overlap-underlap` | Overlap and underlap | intermediate | A teammate runs outside (overlap) or inside (underlap) the ball carrier to give options and drag defenders. | "The full-back overlapped and the winger went inside." |
| `third-man-run` | Third-man run | intermediate | A pass to a teammate that sets up a pass to a third player running into space. | "That third-man run beat the whole line." |
| `pressing` | Pressing | foundations | Closing down opponents quickly to win the ball back or force a bad pass. | "They press like mad, high up the pitch." |
| `pressing-trigger` | Pressing trigger | intermediate | A cue, such as a back pass, a bad touch or a pass to the touchline, that tells the team to press together. | "The back pass was the trigger and they all went." |
| `high-press` | High press | foundations | Pressing in the opposition half to win the ball close to goal. | "High press, and they scored within six seconds of winning it." |
| `mid-block` | Mid-block | intermediate | Defending in the middle third, letting the opponent have the ball in their own half, then pressing when it enters your zone. | "We sat in a mid-block and waited." |
| `low-block` | Low block | foundations | Defending deep with narrow lines to protect the box and hit on the counter; sometimes called parking the bus. | "They parked the bus and nicked one on the break." |
| `counter-press` | Counter-press | intermediate | Pressing immediately after losing the ball to win it back before the opponent can organise. | "Counter-press, they won it back in five seconds." |
| `counterattack` | Counterattack | foundations | A fast attack after winning the ball while the opponent is out of shape. | "Lightning counter, three passes and it was in the net." |
| `high-line` | High defensive line | intermediate | Defenders stand far up the pitch, squeezing space but leaving room behind them. | "They hold a really high line, so one ball over the top hurts." |
| `zonal-man-marking` | Zonal vs man marking | intermediate | Zonal defenders guard areas; man-markers follow a specific opponent. | "Are they zonal or man-marking at corners?" |
| `rest-defence` | Rest defence | enthusiast | The players who stay back while others attack, ready to stop counters. | "Great rest defence, he was back to snuff it out." |
| `pressing-traps` | Pressing traps | enthusiast | Leaving one pass open to lure the ball into a zone, then closing it, often near the touchline. | "They forced him toward the touchline, the trap worked." |
| `tempo-control` | Tempo and control | intermediate | Speeding up or slowing the game deliberately; keeping possession is not the same as controlling the game. | "They had 70 percent possession but no control." |
| `corner-routine` | Corner routine | intermediate | A rehearsed plan for a corner: where players start, who runs where and the delivery type. | "They had a routine, the near-post flick was planned." |
| `inswinger-outswinger` | Inswinger and outswinger | intermediate | An inswinger curls toward goal; an outswinger curls away from it. | "Inswinger from the right, keepers hate those." |
| `near-far-post` | Near post and far post | intermediate | The near post is the one closer to the taker; runs and flick-ons attack different posts. | "He flicked it on at the near post and someone tapped in at the far." |
| `set-piece-marking` | Set-piece marking systems | enthusiast | Teams defend corners with zonal, man or hybrid systems, often leaving a couple of players on the posts. | "They switched to hybrid marking after conceding three corner goals." |
| `short-corner` | Short corner | intermediate | A corner played short to a teammate to change the angle and pull defenders out. | "Short corner, that pulled the marker away." |
| `screening-blocking` | Blocking at set pieces | enthusiast | Attackers legally shield the keeper's or a marker's path; obstruction is the fine line. | "It was a legal screen, not a foul." |
| `free-kick-technique` | Free-kick technique | foundations | Direct free kicks use dip, curve and dead-ball strikes around or over a wall; delivery is often crossed for headers. | "He bent it round the wall, in the top corner." |
| `penalty-strategy` | Penalty strategy | intermediate | Takers pick a corner or a cheeky chip (the Panenka); keepers study habits and dive early or wait. | "The keeper waited and saved it." |
| `shootout-format` | Shootout format | foundations | Teams alternate five kicks each, then sudden death; a coin toss decides who goes first. | "It's a shootout, five each and then sudden death." |
| `second-ball` | Second ball | intermediate | The loose ball after a clearance or flick-on, where set-piece chaos becomes a goal. | "Set pieces are all about the second ball." |
| `long-throw` | Long throw | intermediate | A throw-in launched into the box like a cross, a weapon for some teams. | "Their long throw is basically a corner." |
| `tiki-taka` | Tiki-taka | enthusiast | A short-passing, high-possession style built on triangles and patient movement, made famous by Barcelona and Spain. | "It's tiki-taka, endless passing until the gap opens." |
| `positional-play` | Positional play | enthusiast | A system (juego de posición) where players occupy zones so the ball carrier always has options; associated with Cruyff and Guardiola. | "It's not passing for passing's sake, it's positional play." |
| `total-football` | Total football | enthusiast | A fluid 1970s Dutch idea where any player can take any role and the shape stays balanced. | "Total football, everyone rotates." |
| `catenaccio` | Catenaccio | enthusiast | An Italian, defence-first system with a sweeper and strict marking, built to win 1-0. | "Catenaccio was the original park-the-bus." |
| `gegenpressing` | Gegenpressing | enthusiast | The German term for counter-pressing, popularised by Klopp: the best playmaker is the turnover close to goal. | "Klopp said gegenpressing is the best playmaker." |
| `inverted-fullback` | Inverted full-back | enthusiast | A full-back who steps into midfield when his team has the ball to overload the centre. | "The right-back tucks inside, he's an inverted full-back." |
| `direct-football` | Direct football | enthusiast | A style that goes long and early, using target men, second balls and set pieces. | "They play direct, a lot of long balls and second balls." |
| `pragmatism-vs-idealism` | Style vs results | enthusiast | A long-running argument between attractive possession football and results-first pragmatism. | "Is it winning ugly or is it pragmatism?" |
| `box-midfield` | Box midfield | enthusiast | A 3-2-5 build-up where the full-backs move inside to form a box with the midfielders. | "City build in a box in midfield, with the full-backs inside." |
| `xg` | Expected goals (xG) | enthusiast | A shot-quality number: the probability a shot becomes a goal, based on distance, angle and situation. | "We lost 1-0 but won the xG 2.1 to 0.3." |
| `xa` | Expected assists (xA) | enthusiast | The xG of shots that come from a pass, measuring chance creation independent of finishing. | "His xA is great even if the strikers keep missing." |
| `ppda` | PPDA | enthusiast | Passes allowed per defensive action, a rough gauge of pressing intensity; lower means more pressing. | "Their PPDA is under eight, that's a heavy press." |
| `possession-stat` | Possession stat | enthusiast | The share of time a team holds the ball; it says nothing about quality or danger by itself. | "Sixty percent possession but not one shot on target." |
| `progressive-carry` | Progressive carry | enthusiast | A dribble that moves the ball meaningfully towards goal; a data measure of ball-carrying. | "He leads the league in progressive carries." |
| `shots-on-target` | Shots and shots on target | enthusiast | Shots on target force a save or go in; the ratio hints at finishing and shot selection. | "Twenty shots but only two on target, shooting from everywhere." |
| `goal-difference` | Goal difference | foundations | Goals scored minus goals conceded, the first tiebreaker in many leagues. | "We're level on points but their goal difference is better." |
| `overperform-underperform` | Over- and underperforming xG | enthusiast | Scoring well above xG is likely unsustainable; regression towards the mean is a common analyst point. | "He's overperforming his xG so it won't last." |
| `eye-test-vs-data` | Eye test vs data | enthusiast | Fans debate whether numbers or watching matches tells you more; the best takes use both. | "The data says he's great but the eye test disagrees." |
| `form-and-ppg` | Form and points per game | foundations | A quick way to compare teams over different numbers of matches or the last five games. | "They're averaging two points a game, that's title form." |
| `world-cup-history` | World Cup history | enthusiast | Held every four years since 1930; Brazil have won five, Argentina won 2022 and Spain won 2026. | "Brazil has five stars, Argentina won 2022 and Spain took 2026." |
| `world-cup-2026` | The 2026 World Cup | enthusiast | The first with 48 teams, hosted by the USA, Canada and Mexico; Spain beat Argentina 1-0 after extra time in the final. | "The 2026 final went to extra time and Ferran Torres won it for Spain." |
| `ballon-dor` | Ballon d'Or | enthusiast | The annual award for the best player, given by France Football; arguments over who deserves it are endless. | "He deserved the Ballon d'Or with that season." |
| `goat-debate` | The GOAT debate | enthusiast | Messi vs Ronaldo vs Pelé vs Maradona: an argument about how to weigh trophies, style, longevity and era. | "The GOAT debate is basically about what you value." |
| `derby-history` | Famous derbies | enthusiast | El Clásico, the Manchester derby, the North London derby and the Old Firm carry decades of history. | "It's not just three points, it's the derby." |
| `bosman-ruling` | Bosman ruling | enthusiast | A 1995 ruling that let players move for free at contract end, transforming transfer markets and wages. | "Bosman changed everything, players finally had power." |
| `premier-league-birth` | Premier League era | enthusiast | England's top tier became the Premier League in 1992, a commercial league with huge global TV deals. | "The Premier League turned football into a global TV product." |
| `womens-football-history` | Women's football history | enthusiast | England's FA banned women's football on affiliated grounds from 1921 to 1971; the 1999 World Cup and the NWSL's 2013 launch fed a modern boom. | "The ban lasted fifty years and look at the crowds now." |
| `us-soccer-history` | US soccer history | enthusiast | The NASL and Pelé in the 1970s, the 1994 World Cup, MLS in 1996, Beckham in 2007 and Messi in 2023 mark US soccer's growth. | "MLS started in 1996 after the World Cup in the USA." |
| `invincibles-treble` | Invincibles and treble | enthusiast | Arsenal's unbeaten 2003-04 league season and Manchester United's 1999 treble are benchmark achievements. | "Unbeaten all season, that's the Invincibles." |
| `pl-european-spots` | Premier League Europe spots | intermediate | League position (and some cup wins) decides Champions League, Europa League and Conference League places. | "Top five gets Champions League if England earns the extra place." |
| `fa-cup` | FA Cup | intermediate | England's historic knockout cup, open to clubs from the Premier League down to non-league. | "It's the FA Cup, the magic of the cup." |
| `la-liga-clasico` | La Liga and El Clásico | intermediate | Spain's top league, dominated by Real Madrid and Barcelona, with Atlético Madrid as the usual challenger. | "Clásico weekend is basically a holiday." |
| `mls-structure` | MLS structure | intermediate | A single-entity league with a salary cap, Designated Players, no relegation and playoffs after the regular season. | "There's no relegation in MLS, so mid-table isn't dangerous." |
| `supporters-shield` | Supporters' Shield and MLS Cup | intermediate | The Shield goes to the best regular-season team; MLS Cup is decided in the playoffs. | "They won the Shield but lost in the playoffs." |
| `mls-calendar-shift` | MLS calendar shift | intermediate | MLS plays a short transition season in early 2027, then moves to an August-to-May calendar in 2027-28. | "MLS is moving to the European calendar in 2027." |
| `nwsl-structure` | NWSL structure | intermediate | The US women's top league has no relegation, a playoff decides the champion, and the Shield goes to the top regular-season team. | "Gotham won it from the number eight seed last year." |
| `ucl-league-phase` | Champions League league phase | intermediate | 36 clubs play eight different opponents in one table; the top eight go straight to the last 16 and 9-24 enter playoffs. | "Top eight skips the playoff round, that's the whole race." |
| `wc-format-48` | 48-team World Cup format | intermediate | Twelve groups of four; the top two plus the eight best third-placed teams reach a round of 32. | "Third place can still go through with the new format." |
| `national-vs-club` | International football | intermediate | Players represent nations in tournaments and qualifiers, with international breaks pausing the club calendar. | "It's an international break so no club games." |
| `fixture-congestion` | Fixture congestion | current-season | Too many matches in a short span forces rotation, injuries and tired legs. | "They're playing three games a week, of course they're tired." |
| `international-break` | International break | current-season | A club-season pause for national-team games, when injuries and travel matter. | "Everyone's holding their breath for the international break." |
| `injury-report` | Injury news | current-season | Availability news (out, doubtful, back in training) shapes team selection and fan mood. | "He's doubtful, he trained yesterday." |
| `here-we-go` | Here we go | current-season | Shorthand made famous by reporter Fabrizio Romano: a transfer is confirmed and essentially done. | "Romano tweeted here we go, it's done." |
| `sack-race` | Managerial pressure | current-season | When results dip, fans and media speculate about a manager being fired; boards weigh cost, timing and fit. | "Two points from six, he's under pressure." |
| `title-race` | Title race | current-season | The fight between the top teams, where goal difference, head-to-heads and the run-in matter. | "It's a three-horse race and the run-in is brutal." |
| `relegation-scrap` | Relegation battle | current-season | Teams near the bottom fight for survival; points gaps and games in hand define the drama. | "It's a relegation scrap, every point is huge." |
| `run-in` | The run-in | current-season | The final stretch of the league season when fixtures and pressure decide everything. | "The run-in is the hard part." |
| `worldie` | Worldie | conversation | A spectacular goal, from long range or an improbable angle. | "That was a worldie, top bins." |
| `nutmeg-rabona` | Nutmeg and rabona | conversation | A nutmeg is passing the ball between an opponent's legs; a rabona is a kick with the kicking foot crossed behind the standing leg. | "He nutmegged him and did a rabona in the same move." |
| `bottled-it` | Bottled it | conversation | A fan phrase for collapsing under pressure in a big moment. | "They bottled it, they had it wrapped up." |
| `clinical` | Clinical vs wasteful | conversation | Clinical means taking chances efficiently; wasteful means creating chances but missing them. | "They were clinical, one chance, one goal." |
| `scrappy-win` | Winning ugly | conversation | A win without dominance, often praised as a sign of a champion mentality. | "It was ugly but three points are three points." |
| `banter-rivalry` | Banter and rivalry | conversation | Friendly teasing between fans; a good exchange includes respect for the other side. | "Fine, you win this time, but wait for the return leg." |
| `match-report-talk` | Post-match talk | conversation | Fans talk about the decisive moment, the manager's changes and whether the result was fair. | "It came down to the substitution at the hour mark." |
| `respect-for-rivals` | Asking a real question | conversation | The best conversational move is a genuine question about why the fan loves the team or a specific player. | "What was it about him that made him your favourite?" |

172 terms.

## 5. Say-this bank plan

- Launch target: 60+ items (about 4 per unit, more for the conversation and live layers).
- Each item: a 1-2 sentence fan line, 3-6 concept options (multi-select), a plain-English translation, 1-3 follow-ups with a "why it works" caption, and a `noFakeExpertNote`.
- Four samples are above (`st-parked`, `st-back-three`, `st-xg`, `st-set-piece`). Slang tiers: universal (parked the bus, clean sheet), UK/Europe (gaffer, worldie), US (Supporters' Shield, Designated Player).
- Voice check: warm, a little flirty, never about the crush, never mean; correct answers explain how it works.

## 6. Authoring notes

- **Diagrams needed natively** (procedural): `soccer-pitch-full`, `soccer-pitch-attacking-third`, `soccer-pitch-thirds`, `soccer-433-shape`.
- **Rule accuracy:** all rules text is written against the IFAB Laws of the Game 2026/27 (effective 1 July 2026); re-verify each July. Do not hard-code league formats that change (Champions League league phase details are marked as season-specific in the live layer).
- **Currency:** anything that changes weekly belongs in the live layer, not in payloads.
