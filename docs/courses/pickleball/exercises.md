# Native Exercise Plan: Pickleball (`pickleball`)

Tier B plan for `docs/courses/pickleball/`. All 13 native exercise types are used; Tier A sims are in `sims/`. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup when this file was generated). Conventions: prompts <= 12 words; every answer explained; `license` ids are `original-swoond` (procedural or original recordings); no unlicensed marks. Rule text is paraphrased, never copied from the USA Pickleball rulebook (2026 wording: "clearly" in the volley-serve requirements; rally scoring formalised; prompt out-calls). Time-sensitive items (2026 spin test, tour formats) are tagged for the live layer rather than hard-coded in evergreen lessons.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | The default knowledge check and Daily Bite card. Used for rules, definitions, scoring logic and 'which is true' checks in every unit; three or four options; distractors are the classic beginner errors from CDS section 2. | ~220 |
| `binary-call` | The design's kitchen game and every yes/no rule call: volley or bounce, in or out, good serve or fault, legal or not. Diagram markers use the pickleball-court diagram; `ruleTag` names the rule ('Kitchen line', 'Two-bounce rule'). Dynamic kitchen concepts (momentum) are promoted to the Unity sim, not here. | ~70 |
| `term-match` | Introduce 3 to 6 related terms at the start of a unit (shots, slang, tours, gear) and in Term Blitz reviews. Definitions are short, concrete and in plain words. | ~30 |
| `sequence-order` | Ordering the rally opening, serve rotation through a side-out, MLP match order, tournament flow. Order is the concept; per-step `why` text carries the logic. | ~25 |
| `visual-id` | Recognising gear and shot shapes from original illustrations (ball holes, paddle shapes, flight arcs). All images are procedural or original vector art (`original-swoond`); no photographs or brand marks. | ~25 |
| `decision-scenario` | Judgment: line-call disputes, etiquette, choosing a paddle for a described player, how to react when invited to play, general injury care. Facts table plus consequences; `expertNote` and `safetyNote` where relevant. Never coaches confrontation or faking ability. | ~60 |
| `talk-track` | Conversation practice: 18 tracks at launch (see the full list below), one per unit end plus the Conversation Lab and Talk tab. Smooth meter; replies model curiosity over expertise. | 18 |
| `timing-tap` | Only for 1D rhythm: the drop-serve bounce, the split-step, the hands battle. Anything that depends on a 3D scene (momentum, arcs, coverage) is a Unity sim instead. | ~12 |
| `say-this` | Decode what she just said: slang, recaps, rule complaints, gear worries, team talk. Every item includes a `noFakeExpertNote` and follow-up lines that are honest curiosity. | ~80 |
| `fill-the-gap` | Vocabulary in context and rule sentences (kitchen rule, score call, volley-serve wording, reset). Quick review card. | ~45 |
| `listening-id` | Sound recognition: dink vs drive, indoor vs outdoor ball, paddle materials (later). Original foley or synthesised audio only (`original-swoond`); a 'Skip' option is always available. | ~12 |
| `estimate-slider` | Magnitudes: court size, game length, paddle weight, bounce height, spin-test numbers (as release news, not hard-coded). | ~20 |
| `hotspot-tap` | Static diagrams: kitchen, service boxes and diagonals, positions, transition zone, even/odd service side. The court diagram `pickleball-court-top` is procedural. Movement questions are Unity. | ~40 |

Estimated totals: about 660 native items across 107 lessons and the review loop (density ~5-8 per lesson including review pools). Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

The default knowledge check and Daily Bite card. Used for rules, definitions, scoring logic and 'which is true' checks in every unit; three or four options; distractors are the classic beginner errors from CDS section 2.

**Sample 1** (lesson `court-03`)

```json
{
  "prompt": "How far does the kitchen reach from the net?",
  "options": [
    {
      "id": "a",
      "text": "3 feet"
    },
    {
      "id": "b",
      "text": "7 feet"
    },
    {
      "id": "c",
      "text": "10 feet"
    },
    {
      "id": "d",
      "text": "15 feet"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Seven feet on each side of the net. That strip is the kitchen, also called the non-volley zone.",
    "incorrect": "It is seven feet from the net on each side. Fifteen feet is the depth of a service box, a different thing.",
    "sayThisLine": "Wait, the kitchen is only seven feet deep?"
  }
}
```

**Sample 2** (lesson `score-01`)

```json
{
  "prompt": "In traditional doubles scoring, who can score a point?",
  "options": [
    {
      "id": "a",
      "text": "Only the serving side"
    },
    {
      "id": "b",
      "text": "Whoever wins the rally"
    },
    {
      "id": "c",
      "text": "Only the receiving side"
    },
    {
      "id": "d",
      "text": "Nobody until the game starts"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Only the serving side scores. Win a rally as the receiver and you win the serve, not a point.",
    "incorrect": "Traditional side-out scoring lets only the server's side score. Rally scoring, where every rally is a point, is the newer option.",
    "sayThisLine": "They won the rally but didn't score, it was a side out."
  }
}
```

**Sample 3** (lesson `serve-06`)

```json
{
  "prompt": "Before anyone may volley, how many bounces must happen?",
  "options": [
    {
      "id": "a",
      "text": "None"
    },
    {
      "id": "b",
      "text": "One"
    },
    {
      "id": "c",
      "text": "Two"
    },
    {
      "id": "d",
      "text": "Three"
    }
  ],
  "correctOptionIds": [
    "c"
  ],
  "explanation": {
    "correct": "Two: the serve must bounce on the receiving side, then the return must bounce on the serving side. After that, volleys are legal.",
    "incorrect": "It is two bounces, one on each side. That is the two-bounce rule, and it stops the serving team from rushing the net.",
    "sayThisLine": "The two-bounce rule keeps the serve from being a free point."
  }
}
```

**Sample 4** (lesson `gear-05`)

```json
{
  "prompt": "Which is true of the pickleball itself?",
  "options": [
    {
      "id": "a",
      "text": "It is a solid rubber ball"
    },
    {
      "id": "b",
      "text": "It is a perforated plastic ball"
    },
    {
      "id": "c",
      "text": "It is a foam ball with no holes"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "A perforated plastic ball. The holes keep it light and slow through the air.",
    "incorrect": "It is hollow plastic with holes. Outdoor balls have more, smaller holes; indoor balls have fewer, larger ones."
  }
}
```

### 2.2 `binary-call`

The design's kitchen game and every yes/no rule call: volley or bounce, in or out, good serve or fault, legal or not. Diagram markers use the pickleball-court diagram; `ruleTag` names the rule ('Kitchen line', 'Two-bounce rule'). Dynamic kitchen concepts (momentum) are promoted to the Unity sim, not here.

**Sample 1** (lesson `kit-03`)

```json
{
  "prompt": "Ball is high over the net. You stand on the kitchen line.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "pickleball-court",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.6
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.4
      }
    ],
    "alt": "Pickleball court. You stand with a toe on the kitchen line, and the ball is coming over the net without having bounced."
  },
  "choices": [
    {
      "id": "volley",
      "label": "Volley it"
    },
    {
      "id": "bounce",
      "label": "Let it bounce"
    }
  ],
  "correctChoiceId": "bounce",
  "explanation": {
    "correct": "The line counts as kitchen. Volleying with a toe on it is a fault, so you let it bounce.",
    "incorrect": "A toe on the kitchen line is in the kitchen. No volleys there, so wait for the bounce.",
    "sayThisLine": "She let it bounce because her toe was on the line."
  },
  "ruleTag": "Kitchen line"
}
```

**Sample 2** (lesson `serve-06`)

```json
{
  "prompt": "Serve is returned. It's your team's first shot back.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "pickleball-court",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.85
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.5
      }
    ],
    "alt": "You stand near the baseline. The return of serve is coming at you in the air."
  },
  "choices": [
    {
      "id": "volley",
      "label": "Volley it"
    },
    {
      "id": "bounce",
      "label": "Let it bounce"
    }
  ],
  "correctChoiceId": "bounce",
  "explanation": {
    "correct": "Two-bounce rule: the return has to bounce on your side before your team may hit it.",
    "incorrect": "The serving team must let the return bounce first. Only then can volleys start."
  },
  "ruleTag": "Two-bounce rule"
}
```

**Sample 3** (lesson `court-04`)

```json
{
  "prompt": "The ball lands right on the baseline.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "pickleball-court",
    "markers": [
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.02
      }
    ],
    "alt": "Ball touching the far baseline of the pickleball court."
  },
  "choices": [
    {
      "id": "in",
      "label": "In"
    },
    {
      "id": "out",
      "label": "Out"
    }
  ],
  "correctChoiceId": "in",
  "explanation": {
    "correct": "Lines are in. Any part of the ball touching a boundary line counts as in.",
    "incorrect": "A ball touching the baseline is in. Only the kitchen line changes the rules, and only for volleys and serves."
  },
  "ruleTag": "Lines are in"
}
```

**Sample 4** (lesson `serve-07`)

```json
{
  "prompt": "Your serve lands on the kitchen line.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "pickleball-court",
    "markers": [
      {
        "role": "ball",
        "x": 0.75,
        "y": 0.4
      },
      {
        "role": "target",
        "x": 0.75,
        "y": 0.25
      }
    ],
    "alt": "A serve lands exactly on the near kitchen line of the diagonal service box."
  },
  "choices": [
    {
      "id": "good",
      "label": "Good serve"
    },
    {
      "id": "fault",
      "label": "Fault"
    }
  ],
  "correctChoiceId": "fault",
  "explanation": {
    "correct": "Fault. The kitchen line is part of the kitchen, so a serve there is short.",
    "incorrect": "A serve has to clear the kitchen and its line. Landing on the line is short, which is a fault.",
    "sayThisLine": "It caught the kitchen line. Short serve."
  },
  "ruleTag": "Short serve"
}
```

### 2.3 `term-match`

Introduce 3 to 6 related terms at the start of a unit (shots, slang, tours, gear) and in Term Blitz reviews. Definitions are short, concrete and in plain words.

**Sample 1** (lesson `shot-01`)

```json
{
  "prompt": "Match the shot to what it does.",
  "pairs": [
    {
      "id": "dink",
      "term": "Dink",
      "definition": "A soft shot that lands in the opponent's kitchen"
    },
    {
      "id": "drop",
      "term": "Drop",
      "definition": "A soft arcing shot from deep that lands in the kitchen"
    },
    {
      "id": "drive",
      "term": "Drive",
      "definition": "A fast, flat, hard shot"
    },
    {
      "id": "lob",
      "term": "Lob",
      "definition": "A high shot over the net players' heads"
    }
  ],
  "distractorDefinitions": [
    "A serve that spins hard"
  ],
  "explanation": {
    "summary": "Soft shots buy time (dink, drop), hard shots take it away (drive), and a lob goes over their heads.",
    "sayThisLine": "That was a drop, not a dink."
  }
}
```

**Sample 2** (lesson `shot-03`)

```json
{
  "prompt": "Decode the showy shots.",
  "pairs": [
    {
      "id": "erne",
      "term": "Erne",
      "definition": "Jump outside the kitchen and volley near the net"
    },
    {
      "id": "atp",
      "term": "ATP",
      "definition": "Hit the ball around the net post, not over the net"
    },
    {
      "id": "bert",
      "term": "Bert",
      "definition": "A partner runs behind you to hit your ball"
    }
  ],
  "distractorDefinitions": [
    "A slow serve that bounces twice"
  ],
  "explanation": {
    "summary": "Erne, ATP and Bert are the crowd-pleasers. They are legal when the kitchen and net rules are respected.",
    "sayThisLine": "Did you see that ATP? Around the post!"
  }
}
```

**Sample 3** (lesson `shot-07`)

```json
{
  "prompt": "Match the slang.",
  "pairs": [
    {
      "id": "pickled",
      "term": "Pickled",
      "definition": "Lost a game without scoring a point"
    },
    {
      "id": "banger",
      "term": "Banger",
      "definition": "A player who hits hard at everything"
    },
    {
      "id": "dinker",
      "term": "Dinker",
      "definition": "A patient player who wins with soft shots"
    },
    {
      "id": "sandbagger",
      "term": "Sandbagger",
      "definition": "A player rated lower than their real level"
    }
  ],
  "explanation": {
    "summary": "Slang is friendly teasing. Learn it, then use it lightly.",
    "sayThisLine": "I got pickled, but their dinker was brilliant."
  }
}
```

**Sample 4** (lesson `pro-01`)

```json
{
  "prompt": "Who is who in pro pickleball?",
  "pairs": [
    {
      "id": "ppa",
      "term": "PPA Tour",
      "definition": "The pro tour of individual events and brackets"
    },
    {
      "id": "mlp",
      "term": "MLP",
      "definition": "Team league with franchises and a season"
    },
    {
      "id": "app",
      "term": "APP Tour",
      "definition": "Circuit mixing pro and amateur brackets"
    },
    {
      "id": "upa",
      "term": "UPA",
      "definition": "Umbrella body over the PPA and MLP"
    }
  ],
  "explanation": {
    "summary": "Different formats, similar sport. PPA and MLP sit under the UPA; the APP is a separate tour.",
    "sayThisLine": "Is that a PPA event or an MLP match?"
  }
}
```

### 2.4 `sequence-order`

Ordering the rally opening, serve rotation through a side-out, MLP match order, tournament flow. Order is the concept; per-step `why` text carries the logic.

**Sample 1** (lesson `court-07`)

```json
{
  "prompt": "Put a rally's opening in order.",
  "items": [
    {
      "id": "serve",
      "text": "Serve lands in the diagonal box",
      "why": "Every rally begins with an underhand serve."
    },
    {
      "id": "return",
      "text": "Receiver returns after the serve bounces",
      "why": "The return must bounce first."
    },
    {
      "id": "third",
      "text": "Serving team hits the third shot after the return bounces",
      "why": "The two-bounce rule applies to both sides."
    },
    {
      "id": "volleys",
      "text": "Now anyone may volley (not in the kitchen)",
      "why": "After two bounces, volleys are legal outside the kitchen."
    }
  ],
  "explanation": {
    "correct": "Serve, return, third shot, then free play. That is why the third shot is such a big deal.",
    "incorrect": "The opening always runs serve, return, third shot. Only then may anyone volley.",
    "sayThisLine": "It's all about the third shot."
  }
}
```

**Sample 2** (lesson `pro-03`)

```json
{
  "prompt": "Order an MLP team match.",
  "items": [
    {
      "id": "wd",
      "text": "Women's doubles game",
      "why": "Games are played in a fixed order."
    },
    {
      "id": "md",
      "text": "Men's doubles game",
      "why": "Second in the fixed order."
    },
    {
      "id": "mx1",
      "text": "First mixed doubles game",
      "why": "Two mixed games close out regulation."
    },
    {
      "id": "mx2",
      "text": "Second mixed doubles game",
      "why": "All four games are played."
    },
    {
      "id": "db",
      "text": "DreamBreaker if the match is 2-2",
      "why": "A rally-scoring tiebreak decides it."
    }
  ],
  "explanation": {
    "correct": "Four games in order; a 2-2 tie goes to the DreamBreaker.",
    "incorrect": "It runs women's, men's, then two mixed games. If it is 2-2, the DreamBreaker decides.",
    "sayThisLine": "It went to a DreamBreaker again."
  }
}
```

**Sample 3** (lesson `score-03`)

```json
{
  "prompt": "Follow the serve through a side out.",
  "items": [
    {
      "id": "s1",
      "text": "Server one serves until they lose a rally",
      "why": "One partner serves first."
    },
    {
      "id": "s2",
      "text": "Server two (partner) serves until they lose a rally",
      "why": "The other partner gets a turn."
    },
    {
      "id": "so",
      "text": "Side out: the serve moves to the other team",
      "why": "Once both partners have lost a rally, the serve passes."
    },
    {
      "id": "new",
      "text": "The new serving team starts with server one",
      "why": "The count resets on the new side."
    }
  ],
  "explanation": {
    "correct": "Server one, server two, side out, then the other team begins. Only the server's side scores along the way.",
    "incorrect": "Each partner gets a turn before the serve passes to the other side.",
    "sayThisLine": "That was a side out. We lose the serve."
  }
}
```

### 2.5 `visual-id`

Recognising gear and shot shapes from original illustrations (ball holes, paddle shapes, flight arcs). All images are procedural or original vector art (`original-swoond`); no photographs or brand marks.

**Sample 1** (lesson `court-05`)

```json
{
  "prompt": "Which ball is built for outdoor play?",
  "image": {
    "asset": "images/pickleball/balls-indoor-outdoor.svg",
    "alt": "Two plastic balls side by side. The left ball has a few large round holes. The right ball has many small holes.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "left",
      "text": "Left: few large holes"
    },
    {
      "id": "right",
      "text": "Right: many small holes"
    }
  ],
  "correctOptionId": "right",
  "explanation": {
    "correct": "Outdoor balls have more, smaller holes and are a bit harder, so wind bothers them less.",
    "incorrect": "Look at the holes. Many small holes mean outdoor; a few large holes mean indoor."
  },
  "cues": [
    "More holes",
    "Smaller holes"
  ]
}
```

**Sample 2** (lesson `gear-02`)

```json
{
  "prompt": "Which paddle is elongated?",
  "image": {
    "asset": "images/pickleball/paddle-shapes.svg",
    "alt": "Two paddles side by side. The left is nearly square. The right is long and narrow.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "left",
      "text": "The nearly square paddle"
    },
    {
      "id": "right",
      "text": "The long, narrow paddle"
    }
  ],
  "correctOptionId": "right",
  "explanation": {
    "correct": "Elongated paddles are longer and narrower, trading a bit of sweet spot for reach and power.",
    "incorrect": "Elongated means longer and narrower. The square-ish one is a standard shape."
  },
  "cues": [
    "Longer face",
    "Narrower face"
  ]
}
```

**Sample 3** (lesson `shot-03`)

```json
{
  "prompt": "Which flight path is a lob?",
  "image": {
    "asset": "images/pickleball/shot-arcs.svg",
    "alt": "Three side-view arcs over a net: one tall, one medium and slow, one flat and fast.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "tall",
      "text": "The tall arc"
    },
    {
      "id": "medium",
      "text": "The medium slow arc"
    },
    {
      "id": "flat",
      "text": "The flat fast line"
    }
  ],
  "correctOptionId": "tall",
  "explanation": {
    "correct": "A lob goes high over the opponents' heads. The medium arc is a drop; the flat line is a drive.",
    "incorrect": "Tall means lob, medium and soft means drop, flat and fast means drive."
  },
  "cues": [
    "Highest arc",
    "Lands deep"
  ]
}
```

### 2.6 `decision-scenario`

Judgment: line-call disputes, etiquette, choosing a paddle for a described player, how to react when invited to play, general injury care. Facts table plus consequences; `expertNote` and `safetyNote` where relevant. Never coaches confrontation or faking ability.

**Sample 1** (lesson `rec-02`)

```json
{
  "prompt": "Your opponent calls your shot out. You saw it in.",
  "situation": {
    "narrative": "Casual open play. No referee. You are pretty sure the ball touched the line.",
    "facts": [
      {
        "label": "Setting",
        "value": "Open play, no ref"
      },
      {
        "label": "Score",
        "value": "8-8, tight game"
      },
      {
        "label": "Your view",
        "value": "Ball touched the line"
      },
      {
        "label": "Their view",
        "value": "They called it out",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "calm",
      "label": "Say 'I thought it clipped the line.' If they're unsure, replay.",
      "verdict": "best",
      "consequence": "They pause, admit they were not sure, and you replay it. Nobody is upset.",
      "considerations": [
        "Players call their own side",
        "Doubt goes to the opponent",
        "Calm keeps the game friendly"
      ]
    },
    {
      "id": "accept",
      "label": "Accept the call and move on.",
      "verdict": "acceptable",
      "consequence": "The game continues, but you may carry it around for a few points.",
      "considerations": [
        "Their side, their call",
        "A quiet word after is still possible"
      ]
    },
    {
      "id": "argue",
      "label": "Insist you were right and demand a replay.",
      "verdict": "poor",
      "consequence": "The mood sours and the next three points are tense.",
      "considerations": [
        "Nobody can prove it",
        "Escalating rarely helps"
      ]
    }
  ],
  "expertNote": "In self-officiated play, players call the lines on their own side of the net, and a ball you are not sure about is in. Ask politely, then let it go.",
  "sayThisLine": "I thought it clipped the line, but your call."
}
```

**Sample 2** (lesson `talk-07`)

```json
{
  "prompt": "Someone asks you to make a fourth. You have never played.",
  "situation": {
    "narrative": "They text you at 5 PM about tonight's open play.",
    "facts": [
      {
        "label": "Your experience",
        "value": "Watched, never played"
      },
      {
        "label": "Their level",
        "value": "Good, friendly"
      },
      {
        "label": "Gear",
        "value": "You have none"
      },
      {
        "label": "Time",
        "value": "Tonight at 7"
      }
    ]
  },
  "options": [
    {
      "id": "honest",
      "label": "Say yes and admit you are a total beginner. Ask for a paddle to borrow.",
      "verdict": "best",
      "consequence": "They laugh, hand you a spare paddle and give you the first two serves to practice.",
      "considerations": [
        "Honesty makes it fun",
        "Borrowing is normal",
        "Beginners are welcome"
      ]
    },
    {
      "id": "later",
      "label": "Say maybe next week and ask for a beginner session.",
      "verdict": "acceptable",
      "consequence": "They understand, and you plan a slower first game together.",
      "considerations": [
        "Safe, but a smaller chance tonight"
      ]
    },
    {
      "id": "bluff",
      "label": "Say you play a lot and jump in.",
      "verdict": "poor",
      "consequence": "By the third point it is obvious. You feel awkward and they feel misled.",
      "considerations": [
        "Faking a level backfires",
        "Trust matters more than looking good"
      ]
    }
  ],
  "expertNote": "Almost every pickleball community has a welcome for beginners. Being honest about your level is the friendliest way to play.",
  "sayThisLine": "I'm brand new. Will you show me where to stand?"
}
```

**Sample 3** (lesson `gear-03`)

```json
{
  "prompt": "She wants a paddle that helps with control.",
  "situation": {
    "narrative": "She plays a patient, dink-heavy game and says her drives feel wobbly.",
    "facts": [
      {
        "label": "Style",
        "value": "Patient dinker"
      },
      {
        "label": "Wish",
        "value": "More control"
      },
      {
        "label": "Budget",
        "value": "Mid-range"
      },
      {
        "label": "Rule",
        "value": "Must be on the approved list",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "control",
      "label": "Try standard-shape, forgiving paddles from the approved list.",
      "verdict": "best",
      "consequence": "Bigger sweet spot and softer feel match her patient game.",
      "considerations": [
        "Approved list",
        "Standard shape favors control",
        "Try before you buy"
      ]
    },
    {
      "id": "power",
      "label": "Buy the heaviest, longest power paddle.",
      "verdict": "poor",
      "consequence": "Her dinks feel clumsy and her arm tires early.",
      "considerations": [
        "Power helps drives, not resets"
      ]
    },
    {
      "id": "cheap",
      "label": "Grab the cheapest paddle without checking approval.",
      "verdict": "poor",
      "consequence": "It may not be legal at sanctioned events.",
      "considerations": [
        "Approval matters for tournaments"
      ]
    }
  ],
  "expertNote": "Paddle choice depends on style. Control-focused players usually favor a standard shape and a forgiving face; check the approved-paddle list before buying.",
  "sayThisLine": "What matters more to you, control or power?"
}
```

**Sample 4** (lesson `rec-07`)

```json
{
  "prompt": "Her elbow hurts after long sessions. What helps?",
  "situation": {
    "narrative": "She plays three hours of open play, three times a week.",
    "facts": [
      {
        "label": "Symptom",
        "value": "Elbow pain after play",
        "emphasis": "warning"
      },
      {
        "label": "Playing time",
        "value": "3 hours, 3 times a week"
      },
      {
        "label": "Warm-up",
        "value": "Usually skipped"
      }
    ]
  },
  "options": [
    {
      "id": "rest",
      "label": "Encourage warming up, taking breaks and seeing a professional if it lingers.",
      "verdict": "best",
      "consequence": "She feels heard, and the tips are sensible and safe.",
      "considerations": [
        "Warm-up",
        "Rest",
        "Professional advice"
      ]
    },
    {
      "id": "buy",
      "label": "Suggest a new paddle will fix it.",
      "verdict": "acceptable",
      "consequence": "A paddle can help comfort, but it is not a diagnosis.",
      "considerations": [
        "Equipment may matter",
        "Not medical advice"
      ]
    },
    {
      "id": "through",
      "label": "Tell her to play through it.",
      "verdict": "poor",
      "consequence": "Ignoring pain can make it worse.",
      "considerations": [
        "Pain is a signal"
      ]
    }
  ],
  "expertNote": "Keep it kind and general: warm up, take breaks, and see a professional if pain sticks around.",
  "safetyNote": "This is a conversation scenario, not medical advice. Encourage seeing a qualified professional."
}
```

### 2.7 `talk-track`

Conversation practice: 18 tracks at launch (see the full list below), one per unit end plus the Conversation Lab and Talk tab. Smooth meter; replies model curiosity over expertise.

Full talk-track scenarios (9) are in section 4, each conforming to the `talk-track` schema and reproduced in full JSON.

**Sample 1** (lesson `talk-01`)

```json
{
  "title": "After league night",
  "setting": "Sam texts after a rough night of open play.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Ugh. We got pickled in game two and my third-shot drop would NOT land.",
      "replies": [
        {
          "id": "good",
          "text": "Ouch, pickled is brutal. Was the drop going into the net or popping up?",
          "smoothDelta": 25,
          "theirResponse": "Popping up! Then they'd just smash it. You get it.",
          "coachNote": "Good: named the pain, asked a specific question."
        },
        {
          "id": "meh",
          "text": "Sorry! I don't know what pickled means, tell me?",
          "smoothDelta": 8,
          "theirResponse": "Ha, it means we got shut out. 11-0. Rough night.",
          "coachNote": "Honest and fine. Next time try to guess from context first."
        },
        {
          "id": "cringe",
          "text": "It's just pickleball. Hit it harder next time.",
          "smoothDelta": -18,
          "theirResponse": "...harder is exactly how I lose the point. Okay.",
          "coachNote": "Harder is the opposite of a drop. Do not advise; ask."
        }
      ]
    },
    {
      "theirMessage": "Yes! I keep sitting up on the ball. Then it's a smash.",
      "replies": [
        {
          "id": "good",
          "text": "So you want it lower and closer to the net, so they can't attack it?",
          "smoothDelta": 25,
          "theirResponse": "Exactly. Low over the net, into the kitchen. You are basically a coach.",
          "coachNote": "Restating what you learned is safe and earns trust."
        },
        {
          "id": "meh",
          "text": "That sounds hard. Want a snack?",
          "smoothDelta": 2,
          "theirResponse": "Ha. Yes, actually. But also I'm stuck on the drop.",
          "coachNote": "Warm, but you skipped a chance to ask about the shot."
        },
        {
          "id": "cringe",
          "text": "You should really just switch to tennis.",
          "smoothDelta": -20,
          "theirResponse": "Wow. Okay. That is not the vibe.",
          "coachNote": "Never dunk on the sport. Cringe."
        }
      ]
    }
  ],
  "closingNote": "A third-shot drop is a soft arcing shot from the back that lands in the kitchen, buying time to move up."
}
```

### 2.8 `timing-tap`

Only for 1D rhythm: the drop-serve bounce, the split-step, the hands battle. Anything that depends on a 3D scene (momentum, arcs, coverage) is a Unity sim instead.

**Sample 1** (lesson `serve-03`)

```json
{
  "prompt": "Tap when the ball hits the bounce zone.",
  "theme": {
    "label": "Drop serve",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 52,
      "zoneEndPct": 72,
      "sweepSeconds": 1.6
    },
    {
      "zoneStartPct": 58,
      "zoneEndPct": 74,
      "sweepSeconds": 1.4
    },
    {
      "zoneStartPct": 62,
      "zoneEndPct": 76,
      "sweepSeconds": 1.2
    }
  ],
  "explanation": {
    "correct": "A drop serve is hit after the ball bounces. Once you find the timing, it is easy to repeat.",
    "incorrect": "The drop serve rewards a steady bounce-and-swing rhythm. Watch the ball rise to the sweet spot.",
    "sayThisLine": "She uses a drop serve to keep it steady."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `shot-05`)

```json
{
  "prompt": "Tap as the opponent hits: split-step now.",
  "theme": {
    "label": "Split step",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 44,
      "zoneEndPct": 60,
      "sweepSeconds": 1.5
    },
    {
      "zoneStartPct": 48,
      "zoneEndPct": 60,
      "sweepSeconds": 1.3
    },
    {
      "zoneStartPct": 50,
      "zoneEndPct": 60,
      "sweepSeconds": 1.1
    },
    {
      "zoneStartPct": 52,
      "zoneEndPct": 60,
      "sweepSeconds": 1
    }
  ],
  "explanation": {
    "correct": "A split step is a small hop as your opponent hits, so you can push off in any direction.",
    "incorrect": "Land as they hit the ball, not before or after. Too early and you are already flat-footed.",
    "sayThisLine": "Split step as they hit, then go."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

**Sample 3** (lesson `soft-06`)

```json
{
  "prompt": "Tap the instant the ball comes back at the line.",
  "theme": {
    "label": "Hands battle",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 60,
      "zoneEndPct": 74,
      "sweepSeconds": 1
    },
    {
      "zoneStartPct": 62,
      "zoneEndPct": 74,
      "sweepSeconds": 0.9
    },
    {
      "zoneStartPct": 64,
      "zoneEndPct": 74,
      "sweepSeconds": 0.8
    }
  ],
  "explanation": {
    "correct": "Fast volleys at the kitchen line are a hands battle. Quick, short blocks win them.",
    "incorrect": "In a hands battle, you have less time. Short, compact reactions beat big swings.",
    "sayThisLine": "That was a hands battle. Blocks only."
  }
}
```

### 2.9 `say-this`

Decode what she just said: slang, recaps, rule complaints, gear worries, team talk. Every item includes a `noFakeExpertNote` and follow-up lines that are honest curiosity.

**Sample 1** (lesson `shot-07`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "We got pickled in the second game and I could not get a drop to land."
  },
  "question": "What is Sam talking about?",
  "options": [
    {
      "id": "a",
      "text": "Lost a game without scoring",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A soft shot into the kitchen not working",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "A jar of pickles at the courts",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "A rules violation",
      "isCorrect": false
    }
  ],
  "translation": "Sam's team lost a game with zero points, and the soft arcing shot from the back kept failing.",
  "followUps": [
    {
      "line": "Ouch. Was the drop going into the net or popping up?",
      "why": "Shows you understand where a drop can fail."
    },
    {
      "line": "Was it a tough matchup or just an off night?",
      "why": "Warm and curious, no fake analysis."
    }
  ],
  "noFakeExpertNote": "You do not need to say how to fix it. Asking beats advising."
}
```

**Sample 2** (lesson `soft-05`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "It was a total dink war. Ten minutes of nobody speeding up."
  },
  "question": "What happened?",
  "options": [
    {
      "id": "a",
      "text": "A long soft rally near the net",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Both sides were patient",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "Someone kept hitting winners",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "A tournament was cancelled",
      "isCorrect": false
    }
  ],
  "translation": "A long rally of soft dinks at the kitchen line where each side waited for the other to make a mistake.",
  "followUps": [
    {
      "line": "Who blinked first?",
      "why": "A light, playful question about a dink war."
    },
    {
      "line": "Do you like those rallies or hate them?",
      "why": "Invites her opinion."
    }
  ],
  "noFakeExpertNote": "Nobody expects you to know who should have sped up."
}
```

**Sample 3** (lesson `kit-05`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "Foot fault on the kitchen! My momentum carried me in after the volley."
  },
  "question": "What went wrong?",
  "options": [
    {
      "id": "a",
      "text": "She touched the kitchen after volleying",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Momentum carried her into the zone",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "She served from the wrong side",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "The ball bounced twice",
      "isCorrect": false
    }
  ],
  "translation": "After hitting a volley she stumbled into the kitchen. That is a fault even if the ball is dead.",
  "followUps": [
    {
      "line": "Even after the ball was dead?",
      "why": "Shows you know the fault can come after contact."
    },
    {
      "line": "Was it a close one?",
      "why": "Friendly, low-pressure."
    }
  ],
  "noFakeExpertNote": "It is fine to say you're still learning the kitchen rule."
}
```

**Sample 4** (lesson `gear-04`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "I'm nervous my paddle won't pass the new spin test."
  },
  "question": "What is Sam worried about?",
  "options": [
    {
      "id": "a",
      "text": "Her paddle might not be approved anymore",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "How much spin the paddle face creates",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "A grip that is too slippery",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "Which shoes to wear",
      "isCorrect": false
    }
  ],
  "translation": "New testing measures how much spin a paddle can create, and paddles that fail may not be approved.",
  "followUps": [
    {
      "line": "Is it a raw carbon one?",
      "why": "Shows you know surface texture matters."
    },
    {
      "line": "When do you find out?",
      "why": "Practical, caring question."
    }
  ],
  "noFakeExpertNote": "Say you've heard about it and ask her to explain. Don't pretend to know the details."
}
```

### 2.10 `fill-the-gap`

Vocabulary in context and rule sentences (kitchen rule, score call, volley-serve wording, reset). Quick review card.

**Sample 1** (lesson `kit-08`)

```json
{
  "prompt": "Complete the kitchen rule.",
  "template": "You cannot {{action}} while standing in the {{place}}.",
  "gaps": [
    {
      "id": "action",
      "options": [
        "volley",
        "serve",
        "dink"
      ],
      "correct": "volley"
    },
    {
      "id": "place",
      "options": [
        "kitchen",
        "backcourt",
        "sideline"
      ],
      "correct": "kitchen"
    }
  ],
  "explanation": {
    "correct": "No volleys in the kitchen. You may stand there, just not volley.",
    "incorrect": "The rule is about volleying in the kitchen. Dinking is fine, and so is standing there.",
    "sayThisLine": "You can stand in the kitchen, just not volley."
  }
}
```

**Sample 2** (lesson `score-02`)

```json
{
  "prompt": "Read the three-number call.",
  "template": "In '4-2-1', the serving team has {{first}} points and it is server number {{third}}.",
  "gaps": [
    {
      "id": "first",
      "options": [
        "2",
        "4"
      ],
      "correct": "4"
    },
    {
      "id": "third",
      "options": [
        "1",
        "2"
      ],
      "correct": "1"
    }
  ],
  "explanation": {
    "correct": "The first number is the serving team's score, the second is the receiving team's score, the third is which server.",
    "incorrect": "Serving score first, receiving score second, server number third."
  }
}
```

**Sample 3** (lesson `serve-02`)

```json
{
  "prompt": "Complete the volley serve rule.",
  "template": "On a volley serve the ball must be struck {{height}} the waist, with an {{arc}} arc.",
  "gaps": [
    {
      "id": "height",
      "options": [
        "below",
        "above"
      ],
      "correct": "below"
    },
    {
      "id": "arc",
      "options": [
        "upward",
        "downward"
      ],
      "correct": "upward"
    }
  ],
  "explanation": {
    "correct": "Contact below the waist with an upward arc. In 2026 the rules say 'clearly', so borderline serves are faults when officiated.",
    "incorrect": "The serve is underhand: below the waist, moving upward.",
    "sayThisLine": "Her serve was clearly below the waist."
  }
}
```

**Sample 4** (lesson `soft-04`)

```json
{
  "prompt": "Complete the reset idea.",
  "template": "A reset is a {{feel}} shot that {{goal}} a fast ball.",
  "gaps": [
    {
      "id": "feel",
      "options": [
        "soft",
        "hard"
      ],
      "correct": "soft"
    },
    {
      "id": "goal",
      "options": [
        "neutralizes",
        "wins with"
      ],
      "correct": "neutralizes"
    }
  ],
  "explanation": {
    "correct": "A reset absorbs pace and lands softly so you are back in control.",
    "incorrect": "A reset is soft and defensive. It slows the ball to neutralize an attack."
  }
}
```

### 2.11 `listening-id`

Sound recognition: dink vs drive, indoor vs outdoor ball, paddle materials (later). Original foley or synthesised audio only (`original-swoond`); a 'Skip' option is always available.

**Sample 1** (lesson `shot-06`)

```json
{
  "prompt": "Which shot makes this sound?",
  "audio": {
    "asset": "audio/pickleball/dink-soft.m4a",
    "durationMs": 3000,
    "license": "original-swoond",
    "description": "A quiet, low tock, then a soft bounce.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "A dink"
    },
    {
      "id": "b",
      "text": "A drive"
    },
    {
      "id": "c",
      "text": "A serve"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "That soft tock and gentle bounce is a dink.",
    "incorrect": "A dink is quiet and low. Drives are loud and sharp."
  },
  "listenFor": [
    "Quiet tock",
    "Slow bounce"
  ]
}
```

**Sample 2** (lesson `shot-06`)

```json
{
  "prompt": "Which shot is this crack?",
  "audio": {
    "asset": "audio/pickleball/drive-hard.m4a",
    "durationMs": 3000,
    "license": "original-swoond",
    "description": "A sharp, loud pop and a quick bounce.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "A dink"
    },
    {
      "id": "b",
      "text": "A drive"
    },
    {
      "id": "c",
      "text": "A reset"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "A drive has a sharp pop and a short rally rhythm.",
    "incorrect": "Loud and fast is a drive. Soft and slow is a dink or reset."
  },
  "listenFor": [
    "Sharp pop",
    "Quick bounce"
  ]
}
```

**Sample 3** (lesson `gear-05`)

```json
{
  "prompt": "Which ball do you hear?",
  "audio": {
    "asset": "audio/pickleball/ball-indoor.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "A softer, slightly hollow pop with a lower pitch.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Indoor ball"
    },
    {
      "id": "b",
      "text": "Outdoor ball"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Indoor balls are softer and sound lower and a little hollow.",
    "incorrect": "Outdoor balls are harder and sound sharper."
  },
  "listenFor": [
    "Lower pitch",
    "Hollow tone"
  ]
}
```

### 2.12 `estimate-slider`

Magnitudes: court size, game length, paddle weight, bounce height, spin-test numbers (as release news, not hard-coded).

**Sample 1** (lesson `court-02`)

```json
{
  "prompt": "How wide is a pickleball court?",
  "unit": "feet",
  "min": 10,
  "max": 40,
  "step": 1,
  "correctValue": 20,
  "tolerance": {
    "full": 1,
    "partial": 3
  },
  "explanation": {
    "correct": "Twenty feet wide and 44 long, the same size as a doubles badminton court.",
    "incorrect": "It is 20 feet wide and 44 feet long. It is a small court, which is why the game is so compact."
  }
}
```

**Sample 2** (lesson `score-06`)

```json
{
  "prompt": "To how many points is a standard game played?",
  "unit": "points",
  "min": 5,
  "max": 25,
  "step": 1,
  "correctValue": 11,
  "tolerance": {
    "full": 0,
    "partial": 2
  },
  "explanation": {
    "correct": "Eleven, and you must win by two. Some rally-scoring events go to 15 or 21.",
    "incorrect": "Standard games go to 11, win by two."
  }
}
```

**Sample 3** (lesson `gear-01`)

```json
{
  "prompt": "About how heavy is a paddle, in ounces?",
  "unit": "ounces",
  "min": 5,
  "max": 12,
  "step": 0.1,
  "correctValue": 8,
  "tolerance": {
    "full": 0.5,
    "partial": 1.2
  },
  "explanation": {
    "correct": "Most paddles weigh about 7.5 to 8.5 ounces. Lighter paddles are quicker; heavier ones add power.",
    "incorrect": "Typical paddles weigh around 8 ounces."
  }
}
```

**Sample 4** (lesson `shot-01`)

```json
{
  "prompt": "Dropped from 78 inches, how high does the ball bounce?",
  "unit": "inches",
  "min": 10,
  "max": 60,
  "step": 1,
  "correctValue": 32,
  "tolerance": {
    "full": 3,
    "partial": 8
  },
  "explanation": {
    "correct": "A regulation ball dropped from 78 inches bounces about 30 to 34 inches, which is why the game is slow and patient.",
    "incorrect": "It bounces about a third of the way back, roughly 30 to 34 inches from 78."
  }
}
```

### 2.13 `hotspot-tap`

Static diagrams: kitchen, service boxes and diagonals, positions, transition zone, even/odd service side. The court diagram `pickleball-court-top` is procedural. Movement questions are Unity.

**Sample 1** (lesson `court-03`)

```json
{
  "prompt": "Tap the kitchen.",
  "diagram": {
    "diagramId": "pickleball-court-top",
    "aspectRatio": 0.72,
    "alt": "Top-down pickleball court. The net runs across the middle, two shaded strips sit either side of it, and four service boxes lie behind them."
  },
  "hotspots": [
    {
      "id": "kitchen-near",
      "label": "Near kitchen",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.5,
        "w": 0.94,
        "h": 0.16
      }
    },
    {
      "id": "kitchen-far",
      "label": "Far kitchen",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.34,
        "w": 0.94,
        "h": 0.16
      }
    },
    {
      "id": "box",
      "label": "Service box",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.66,
        "w": 0.47,
        "h": 0.3
      }
    },
    {
      "id": "baseline",
      "label": "Baseline",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.95,
        "w": 0.94,
        "h": 0.05
      }
    }
  ],
  "correctHotspotIds": [
    "kitchen-near",
    "kitchen-far"
  ],
  "explanation": {
    "correct": "The kitchen is the seven-foot strip on each side of the net. No volleys in it.",
    "incorrect": "Look next to the net. That short strip on each side is the kitchen.",
    "sayThisLine": "The kitchen is right beside the net."
  }
}
```

**Sample 2** (lesson `serve-01`)

```json
{
  "prompt": "Serving from the right? Tap the box you aim at.",
  "diagram": {
    "diagramId": "pickleball-court-top",
    "aspectRatio": 0.72,
    "alt": "Top-down pickleball court. You serve from the near right side. Four boxes: near left, near right, far left, far right as seen from above."
  },
  "hotspots": [
    {
      "id": "far-left",
      "label": "Far left box",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.04,
        "w": 0.47,
        "h": 0.3
      }
    },
    {
      "id": "far-right",
      "label": "Far right box",
      "shape": {
        "kind": "rect",
        "x": 0.5,
        "y": 0.04,
        "w": 0.47,
        "h": 0.3
      }
    },
    {
      "id": "near-left",
      "label": "Near left box",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.66,
        "w": 0.47,
        "h": 0.3
      }
    },
    {
      "id": "near-right",
      "label": "Near right box",
      "shape": {
        "kind": "rect",
        "x": 0.5,
        "y": 0.66,
        "w": 0.47,
        "h": 0.3
      }
    }
  ],
  "correctHotspotIds": [
    "far-left"
  ],
  "explanation": {
    "correct": "Diagonal: from the near right you serve to the far left, seen from above.",
    "incorrect": "Serves go cross-court. From the near right, aim for the box on the opposite side at the far end."
  }
}
```

**Sample 3** (lesson `dbl-01`)

```json
{
  "prompt": "Where should you stand to receive a soft ball?",
  "diagram": {
    "diagramId": "pickleball-court-top",
    "aspectRatio": 0.72,
    "alt": "Top-down pickleball court with your team at the bottom. Marked spots: near the kitchen line left, near the kitchen line right, mid-court and deep baseline."
  },
  "hotspots": [
    {
      "id": "kitchen-line-left",
      "label": "Kitchen line, left",
      "shape": {
        "kind": "circle",
        "cx": 0.27,
        "cy": 0.66,
        "r": 0.07
      }
    },
    {
      "id": "kitchen-line-right",
      "label": "Kitchen line, right",
      "shape": {
        "kind": "circle",
        "cx": 0.73,
        "cy": 0.66,
        "r": 0.07
      }
    },
    {
      "id": "midcourt",
      "label": "Mid-court",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.8,
        "r": 0.08
      }
    },
    {
      "id": "deep",
      "label": "Deep baseline",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.96,
        "r": 0.05
      }
    }
  ],
  "correctHotspotIds": [
    "kitchen-line-left",
    "kitchen-line-right"
  ],
  "explanation": {
    "correct": "At the kitchen line, side by side. From there you can volley and dink comfortably.",
    "incorrect": "The kitchen line is the power spot. Mid-court is the danger zone; deep is a reset spot."
  }
}
```

**Sample 4** (lesson `dbl-04`)

```json
{
  "prompt": "Tap the transition zone.",
  "diagram": {
    "diagramId": "pickleball-court-top",
    "aspectRatio": 0.72,
    "alt": "Side half of the court. Bands from baseline to kitchen line: deep, mid-court, near the kitchen."
  },
  "hotspots": [
    {
      "id": "baseline",
      "label": "Baseline",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.88,
        "w": 0.94,
        "h": 0.1
      }
    },
    {
      "id": "transition",
      "label": "Transition zone",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.72,
        "w": 0.94,
        "h": 0.16
      }
    },
    {
      "id": "line",
      "label": "Kitchen line",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.6,
        "w": 0.94,
        "h": 0.12
      }
    }
  ],
  "correctHotspotIds": [
    "transition"
  ],
  "explanation": {
    "correct": "The transition zone is the middle band between the baseline and the kitchen line. Being caught there is a bad spot.",
    "incorrect": "The transition zone is mid-court, between the baseline and the kitchen line. Cross it, don't camp in it.",
    "sayThisLine": "We got stuck in the transition zone."
  }
}
```

## 3. Playbook terms (76)

The Playbook shows each term with a definition and an example line in the voice of the person she is learning for (the person who loves the game). Lines are quoted in serif; they are what the crush might say, never what the learner should fake. Terms unlock on first use; Term Blitz reviews draw from this list. Time-sensitive terms (tour names, DreamBreaker details) are re-verified each season.

| # | Term | Definition | Example line (crush's voice) |
|---|---|---|---|
| 1 | Kitchen (non-volley zone) | The 7-foot strip on each side of the net where you may not volley. | "I got called for a foot fault in the kitchen again." |
| 2 | Kitchen line | The line at the back of the kitchen; it counts as kitchen for volleys. | "My toe was on the kitchen line, so it was a fault." |
| 3 | Volley | Hitting the ball before it bounces. | "That was a beautiful volley at the net." |
| 4 | Two-bounce rule | The serve and return must each bounce before anyone may volley. | "Two-bounce rule: I had to let it bounce." |
| 5 | Dink | A soft shot that lands in the opponent's kitchen. | "We had a ten-minute dinking battle." |
| 6 | Third-shot drop | A soft arcing shot from the back that lands in the kitchen. | "My third-shot drop was on fire tonight." |
| 7 | Drive | A fast, flat, hard shot. | "She drove it right at my feet." |
| 8 | Drop shot | A soft shot that lands low in the kitchen after an arc. | "That drop shot barely cleared the net." |
| 9 | Lob | A high shot over the opponents' heads. | "I lobbed them and they were both stuck at the net." |
| 10 | Reset | A soft shot that neutralizes a fast ball. | "I just needed to reset that ball." |
| 11 | Speed-up | Suddenly hitting a soft-game ball hard. | "I sped up and caught them off guard." |
| 12 | Pop-up | A soft ball that floats up and can be attacked. | "That was a pop-up and they smashed it." |
| 13 | Attackable ball | A ball high enough (above net height) to hit down at. | "Don't attack unless it's an attackable ball." |
| 14 | Counter-attack | Answering a fast ball with a fast ball or a soft block. | "I blocked it back because it was a counter-attack." |
| 15 | Hands battle | A fast exchange of volleys near the net. | "That was a real hands battle." |
| 16 | Block | A short, compact volley that absorbs pace. | "I just blocked it back into the kitchen." |
| 17 | Transition zone | Mid-court between the baseline and the kitchen line. | "We got caught in the transition zone." |
| 18 | No man's land | Another name for the transition zone. | "Never stand in no man's land." |
| 19 | Ready position | Paddle up in front, knees bent, weight forward. | "Paddle up. Ready position!" |
| 20 | Split step | A small hop as the opponent hits, to react quickly. | "Split step as they hit the ball." |
| 21 | Erne | A jump outside the kitchen to volley at the net. | "I went for an Erne and it worked!" |
| 22 | ATP | Around-the-post: hitting the ball around the net post. | "That ATP was ridiculous." |
| 23 | Bert | A partner runs behind you to poach your ball. | "We tried a Bert and it was chaos." |
| 24 | Poach | Stepping across to hit your partner's ball. | "I poached that one and won the point." |
| 25 | Stacking | Starting both partners on one side to keep strengths in place. | "We stacked, and it confused them." |
| 26 | Switching | Partners swap sides during a rally to cover the court. | "We switched and I took the middle." |
| 27 | Middle | The space between partners; the most contested area. | "Down the middle is where points are won." |
| 28 | Forehand in the middle | The player whose forehand faces the center takes the middle ball. | "I have the forehand in the middle, so it's mine." |
| 29 | Side-out | When the serve passes to the other team. | "Side-out, our serve!" |
| 30 | Side-out scoring | Only the serving side can score. | "We play side-out scoring at our courts." |
| 31 | Rally scoring | Every rally scores a point for the winner. | "They played rally scoring at the tournament." |
| 32 | First-server exception | The team serving first only gets one server (0-0-2). | "It was 0-0-2 so I only got one serve." |
| 33 | Server one / server two | Which partner is serving in the serving turn. | "I'm server two, so I serve next." |
| 34 | Score call | Three numbers: server score, receiver score, server number. | "It's 5-3-2, my serve." |
| 35 | Pickled | Losing a game without scoring. | "We got pickled in the first game." |
| 36 | Fault | A rule violation that ends the rally. | "Fault! You were in the kitchen." |
| 37 | Let | A replayed point (not used on serves in modern rules). | "There are no lets on the serve anymore." |
| 38 | Serve | The underhand shot that starts a rally. | "My serve was deep today." |
| 39 | Volley serve | A serve hit out of the air, below waist with an upward arc. | "I do a volley serve, my partner does a drop serve." |
| 40 | Drop serve | A serve where you drop the ball and hit it after it bounces. | "Drop serve is easier for me." |
| 41 | Foot fault | Stepping on or over the baseline while serving, or touching the kitchen when volleying. | "Foot fault on the serve!" |
| 42 | Baseline | The back boundary line of the court. | "It landed right on the baseline." |
| 43 | Centerline | The line splitting the service courts. | "The serve clipped the centerline." |
| 44 | Service box | The diagonal target area for a serve. | "My serve landed in the wrong service box." |
| 45 | Ball on court | A shout to stop play because a loose ball entered your court. | "Ball on court!" |
| 46 | Open play | Informal drop-in games where players rotate. | "I was at open play all Saturday." |
| 47 | Paddle stack | The line of paddles marking who plays next. | "My paddle's in the stack." |
| 48 | Round robin | A format where everyone plays everyone in a group. | "We're doing a round robin tonight." |
| 49 | Ladder league | A league where you move up or down based on results. | "I moved up on the ladder." |
| 50 | Third shot | The serving team's first shot after the return. | "The third shot decides everything." |
| 51 | Fifth shot | The serving side's second shot; often a drop as they approach the line. | "I reset on the fifth shot." |
| 52 | Kitchen line dinks | Dinks played from just behind the kitchen line. | "Kitchen line dinks all day." |
| 53 | Banger | A player who hits hard at nearly everything. | "He's a total banger." |
| 54 | Dinker | A patient player who wins with soft shots. | "She's a dinker and it's so annoying." |
| 55 | Sandbagger | A player who plays below their true rating to win. | "That guy is a sandbagger." |
| 56 | DUPR | A rating system for pickleball players. | "My DUPR is 3.8." |
| 57 | 3.5 / 4.0 | Common skill levels: 3.5 is intermediate, 4.0 is solid competitive. | "I'm a 3.5 aiming for 4.0." |
| 58 | Approved paddle | A paddle on the official approved list, legal in sanctioned play. | "Make sure it's an approved paddle." |
| 59 | Surface roughness / grit | Texture of the paddle face that creates spin. | "That grit gives so much spin." |
| 60 | Raw carbon | A carbon-fiber face with a natural gritty texture. | "I switched to a raw carbon paddle." |
| 61 | Fiberglass face | A paddle face with more pop and a softer feel. | "Fiberglass gives me more power." |
| 62 | Polymer core | The honeycomb inside most paddles. | "Polymer core makes it quiet." |
| 63 | Swing weight | How heavy a paddle feels in motion. | "This has a high swing weight." |
| 64 | Elongated paddle | A longer, narrower paddle shape for reach and power. | "I like an elongated paddle." |
| 65 | Indoor ball | A softer ball with fewer, larger holes. | "We play with an indoor ball at the gym." |
| 66 | Outdoor ball | A harder ball with more, smaller holes. | "Outdoor balls fly better in wind." |
| 67 | PPA Tour | The pro tour of individual events and brackets. | "The PPA finals are this weekend." |
| 68 | MLP | Major League Pickleball, a team league. | "My MLP team plays tonight." |
| 69 | APP Tour | A circuit mixing pro and amateur brackets. | "I signed up for an APP event." |
| 70 | UPA | United Pickleball Association, the umbrella over the PPA and MLP. | "The UPA runs both, right?" |
| 71 | DreamBreaker | MLP's rally-scoring tiebreak played to 21 when a match is 2-2. | "We lost in the DreamBreaker again." |
| 72 | Gold medal match | The final of a pro bracket. | "They're in the gold medal match." |
| 73 | World rankings | The unified pro ranking across events. | "She's ranked number one in the world." |
| 74 | Slam | A major tour event with the most points on the line. | "That's a slam, big points." |
| 75 | Franchise (MLP) | A team in MLP tied to a city or brand. | "I've been a fan of that franchise since day one." |
| 76 | Pro singles | One-on-one pro play, rarer than doubles. | "Pro singles is brutal on the legs." |

## 4. Talk Track scenarios (9)

Each scenario has the enthusiast's opening line, what it means, three reply styles per exchange (**good**, **meh**, **cringe**) with coach notes, and the payload JSON. Smooth starts at 50; a run is a success at >= 60. Good replies model honest curiosity; cringe replies fake expertise, dunk on the sport, or dismiss the person. These are conversation practice, not scripts to impersonate an expert (spec section 13).

### 4.1 After league night (`tt-league-night`)

- **Setting:** Sam texts after a rough night of open play.
- **Enthusiast opening:** "Ugh. We got pickled in game two and my third-shot drop would NOT land."
- **What it means:** She lost a game 11-0 (pickled) and her soft arcing shot from the back (third-shot drop) would not land. Terms: pickled, third-shot drop, kitchen.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ouch, pickled is brutal. Was the drop going into the net or popping up?" | +25 | Good: named the pain, asked a specific question. |
| 1 | meh | "Sorry! I don't know what pickled means, tell me?" | +8 | Honest and fine. Next time try to guess from context first. |
| 1 | cringe | "It's just pickleball. Hit it harder next time." | -18 | Harder is the opposite of a drop. Do not advise; ask. |
| 2 | good | "So you want it lower and closer to the net, so they can't attack it?" | +25 | Restating what you learned is safe and earns trust. |
| 2 | meh | "That sounds hard. Want a snack?" | +2 | Warm, but you skipped a chance to ask about the shot. |
| 2 | cringe | "You should really just switch to tennis." | -20 | Never dunk on the sport. Cringe. |

```json
{
  "title": "After league night",
  "setting": "Sam texts after a rough night of open play.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Ugh. We got pickled in game two and my third-shot drop would NOT land.",
      "replies": [
        {
          "id": "good",
          "text": "Ouch, pickled is brutal. Was the drop going into the net or popping up?",
          "smoothDelta": 25,
          "theirResponse": "Popping up! Then they'd just smash it. You get it.",
          "coachNote": "Good: named the pain, asked a specific question."
        },
        {
          "id": "meh",
          "text": "Sorry! I don't know what pickled means, tell me?",
          "smoothDelta": 8,
          "theirResponse": "Ha, it means we got shut out. 11-0. Rough night.",
          "coachNote": "Honest and fine. Next time try to guess from context first."
        },
        {
          "id": "cringe",
          "text": "It's just pickleball. Hit it harder next time.",
          "smoothDelta": -18,
          "theirResponse": "...harder is exactly how I lose the point. Okay.",
          "coachNote": "Harder is the opposite of a drop. Do not advise; ask."
        }
      ]
    },
    {
      "theirMessage": "Yes! I keep sitting up on the ball. Then it's a smash.",
      "replies": [
        {
          "id": "good",
          "text": "So you want it lower and closer to the net, so they can't attack it?",
          "smoothDelta": 25,
          "theirResponse": "Exactly. Low over the net, into the kitchen. You are basically a coach.",
          "coachNote": "Restating what you learned is safe and earns trust."
        },
        {
          "id": "meh",
          "text": "That sounds hard. Want a snack?",
          "smoothDelta": 2,
          "theirResponse": "Ha. Yes, actually. But also I'm stuck on the drop.",
          "coachNote": "Warm, but you skipped a chance to ask about the shot."
        },
        {
          "id": "cringe",
          "text": "You should really just switch to tennis.",
          "smoothDelta": -20,
          "theirResponse": "Wow. Okay. That is not the vibe.",
          "coachNote": "Never dunk on the sport. Cringe."
        }
      ]
    }
  ],
  "closingNote": "A third-shot drop is a soft arcing shot from the back that lands in the kitchen, buying time to move up."
}
```

### 4.2 The line call (`tt-line-call`)

- **Setting:** Sam is still annoyed after open play.
- **Enthusiast opening:** "They called my shot out and it was on the line!! Lines are IN."
- **What it means:** A friendly dispute: a ball touching the line was called out. Terms: in/out, lines are in, self-officiating.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ugh, annoying. Did you say something or let it go?" | +25 | Empathy first, then curiosity about how it played out. |
| 1 | meh | "Were you sure it was in?" | -2 | It can sound like doubting her. Empathize first. |
| 1 | cringe | "Honestly, refs make mistakes. You should complain to the organizers." | -15 | Open play has no refs. Do not escalate a friendly dispute. |
| 2 | good | "Tight game. Did you get the next point back?" | +22 | Follows her story and stays curious. |
| 2 | meh | "Sports are stressful." | 0 | Harmless but generic. |
| 2 | cringe | "You should just rate your opponents lower." | -12 | Mixing up ratings and a line call. Listen first. |

```json
{
  "title": "The line call",
  "setting": "Sam is still annoyed after open play.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They called my shot out and it was on the line!! Lines are IN.",
      "replies": [
        {
          "id": "good",
          "text": "Ugh, annoying. Did you say something or let it go?",
          "smoothDelta": 25,
          "theirResponse": "I said 'thought it clipped', they said no. So I let it go. Barely.",
          "coachNote": "Empathy first, then curiosity about how it played out."
        },
        {
          "id": "meh",
          "text": "Were you sure it was in?",
          "smoothDelta": -2,
          "theirResponse": "Yes. I saw it. Okay, thanks.",
          "coachNote": "It can sound like doubting her. Empathize first."
        },
        {
          "id": "cringe",
          "text": "Honestly, refs make mistakes. You should complain to the organizers.",
          "smoothDelta": -15,
          "theirResponse": "There are no refs, it's open play. Never mind.",
          "coachNote": "Open play has no refs. Do not escalate a friendly dispute."
        }
      ]
    },
    {
      "theirMessage": "The worst part is it was 10-10.",
      "replies": [
        {
          "id": "good",
          "text": "Tight game. Did you get the next point back?",
          "smoothDelta": 22,
          "theirResponse": "We did! 12-10. Kitchen dinks all the way.",
          "coachNote": "Follows her story and stays curious."
        },
        {
          "id": "meh",
          "text": "Sports are stressful.",
          "smoothDelta": 0,
          "theirResponse": "Ha. Yes. Yes they are.",
          "coachNote": "Harmless but generic."
        },
        {
          "id": "cringe",
          "text": "You should just rate your opponents lower.",
          "smoothDelta": -12,
          "theirResponse": "That is... a strange leap.",
          "coachNote": "Mixing up ratings and a line call. Listen first."
        }
      ]
    }
  ],
  "closingNote": "In self-officiated play, players call the lines on their own side, and lines are in."
}
```

### 4.3 The new paddle (`tt-new-paddle`)

- **Setting:** Sam shows off a new purchase.
- **Enthusiast opening:** "Got a raw carbon paddle! The spin is unreal. My dinks dive now."
- **What it means:** She bought a textured carbon paddle for spin. Terms: raw carbon, surface roughness, spin, approved paddle.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Nice! Does the rough face make the ball grip more? I heard spin is a hot topic." | +28 | You said 'I heard', which is honest, and asked a real question. |
| 1 | meh | "Cool, which brand is best?" | +4 | Fine, but 'best' starts a debate you can't join yet. |
| 1 | cringe | "That's cheating, right? Too much spin." | -18 | Never call her gear cheating. Ask, don't accuse. |
| 2 | good | "When do you find out? And will it change how you play?" | +22 | Concern and a practical follow-up. |
| 2 | meh | "That sounds complicated!" | +3 | Polite. Add a question next time. |
| 2 | cringe | "Just buy another paddle, they're all the same." | -16 | They're not the same. Don't dismiss gear talk. |

```json
{
  "title": "The new paddle",
  "setting": "Sam shows off a new purchase.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Got a raw carbon paddle! The spin is unreal. My dinks dive now.",
      "replies": [
        {
          "id": "good",
          "text": "Nice! Does the rough face make the ball grip more? I heard spin is a hot topic.",
          "smoothDelta": 28,
          "theirResponse": "Yes! There's testing on spin now. I hope mine passes. Good ear.",
          "coachNote": "You said 'I heard', which is honest, and asked a real question."
        },
        {
          "id": "meh",
          "text": "Cool, which brand is best?",
          "smoothDelta": 4,
          "theirResponse": "Ha, that's a whole debate. Depends on your style.",
          "coachNote": "Fine, but 'best' starts a debate you can't join yet."
        },
        {
          "id": "cringe",
          "text": "That's cheating, right? Too much spin.",
          "smoothDelta": -18,
          "theirResponse": "It's approved! ...Right? Now I'm worried.",
          "coachNote": "Never call her gear cheating. Ask, don't accuse."
        }
      ]
    },
    {
      "theirMessage": "The new spin-rate test starts soon, so I hope it's still legal.",
      "replies": [
        {
          "id": "good",
          "text": "When do you find out? And will it change how you play?",
          "smoothDelta": 22,
          "theirResponse": "Soon. I'd have to swap paddles. Thanks for asking.",
          "coachNote": "Concern and a practical follow-up."
        },
        {
          "id": "meh",
          "text": "That sounds complicated!",
          "smoothDelta": 3,
          "theirResponse": "It is. But I'll explain it sometime.",
          "coachNote": "Polite. Add a question next time."
        },
        {
          "id": "cringe",
          "text": "Just buy another paddle, they're all the same.",
          "smoothDelta": -16,
          "theirResponse": "They are really not. Okay.",
          "coachNote": "They're not the same. Don't dismiss gear talk."
        }
      ]
    }
  ],
  "closingNote": "Paddle faces with more texture create more spin. Governing bodies test paddles to keep the game fair."
}
```

### 4.4 Watching the final (`tt-watch-final`)

- **Setting:** You are on the couch with Sam and a pro match on.
- **Enthusiast opening:** "Oh my gosh, it's going to a third game! Come watch."
- **What it means:** She is watching a pro final. Terms: gold medal match, best of three, side-out vs rally scoring, third game.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Yes! So it's best of three? Who is serving?" | +25 | Curious, shows you know matches are a set of games. |
| 1 | meh | "Is that good?" | +3 | Acceptable, but you can guess: 'a third game means it's tied'. |
| 1 | cringe | "Is this basically tennis?" | -15 | The tennis comparison is the classic beginner slip. |
| 2 | good | "A dink rally! Whoever pops one up loses the point, right?" | +25 | You used a taught idea: attackable balls. |
| 2 | meh | "They should just hit it harder." | -8 | Power isn't always the answer. Ask why they're waiting. |
| 2 | cringe | "This is so slow, honestly." | -18 | Don't call her passion boring. Ask about it. |

```json
{
  "title": "Watching the final",
  "setting": "You are on the couch with Sam and a pro match on.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Oh my gosh, it's going to a third game! Come watch.",
      "replies": [
        {
          "id": "good",
          "text": "Yes! So it's best of three? Who is serving?",
          "smoothDelta": 25,
          "theirResponse": "Best of three, yes. That team is serving. You can follow it already.",
          "coachNote": "Curious, shows you know matches are a set of games."
        },
        {
          "id": "meh",
          "text": "Is that good?",
          "smoothDelta": 3,
          "theirResponse": "It means they're tied one game each, so it's tense.",
          "coachNote": "Acceptable, but you can guess: 'a third game means it's tied'."
        },
        {
          "id": "cringe",
          "text": "Is this basically tennis?",
          "smoothDelta": -15,
          "theirResponse": "Nope. Kitchen and two-bounce rule. Watch.",
          "coachNote": "The tennis comparison is the classic beginner slip."
        }
      ]
    },
    {
      "theirMessage": "Look at that kitchen battle! Nobody wants to speed up.",
      "replies": [
        {
          "id": "good",
          "text": "A dink rally! Whoever pops one up loses the point, right?",
          "smoothDelta": 25,
          "theirResponse": "YES. Pop it up and it's over. You're getting it.",
          "coachNote": "You used a taught idea: attackable balls."
        },
        {
          "id": "meh",
          "text": "They should just hit it harder.",
          "smoothDelta": -8,
          "theirResponse": "They'd miss. Patience is the strategy!",
          "coachNote": "Power isn't always the answer. Ask why they're waiting."
        },
        {
          "id": "cringe",
          "text": "This is so slow, honestly.",
          "smoothDelta": -18,
          "theirResponse": "It's a chess match. Ugh.",
          "coachNote": "Don't call her passion boring. Ask about it."
        }
      ]
    }
  ],
  "closingNote": "Pro rallies often hinge on patience: whoever lets the ball sit up gives the other side an attack."
}
```

### 4.5 Rating talk (`tt-rating`)

- **Setting:** Sam is chatting about tournaments.
- **Enthusiast opening:** "I'm a 3.5 but my DUPR says 3.8. I'm trying to break 4.0."
- **What it means:** She talks about levels and DUPR. Terms: 3.5, DUPR, sandbagging, open play.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ooh, what's the thing holding you back from 4.0?" | +28 | Open, kind, and about her goals. |
| 1 | meh | "Is 4.0 good?" | +6 | Honest. Consider guessing the scale first. |
| 1 | cringe | "I bet I'd be a 4.0 in a week." | -20 | Fake confidence is a beginner trap. Skip it. |
| 2 | good | "A sandbagger is someone rated lower than they play, right? Does that happen a lot?" | +24 | You checked the term instead of pretending. |
| 2 | meh | "That sounds unfair." | +6 | Sympathetic and safe. |
| 2 | cringe | "Maybe you're the sandbagger." | -18 | Never accuse her. Joking about cheating goes badly. |

```json
{
  "title": "Rating talk",
  "setting": "Sam is chatting about tournaments.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I'm a 3.5 but my DUPR says 3.8. I'm trying to break 4.0.",
      "replies": [
        {
          "id": "good",
          "text": "Ooh, what's the thing holding you back from 4.0?",
          "smoothDelta": 28,
          "theirResponse": "Consistency on the drop. Basically everything, ha.",
          "coachNote": "Open, kind, and about her goals."
        },
        {
          "id": "meh",
          "text": "Is 4.0 good?",
          "smoothDelta": 6,
          "theirResponse": "It's a solid competitive level. Yes!",
          "coachNote": "Honest. Consider guessing the scale first."
        },
        {
          "id": "cringe",
          "text": "I bet I'd be a 4.0 in a week.",
          "smoothDelta": -20,
          "theirResponse": "Sure. Good luck with that.",
          "coachNote": "Fake confidence is a beginner trap. Skip it."
        }
      ]
    },
    {
      "theirMessage": "Every tournament there's a sandbagger, though.",
      "replies": [
        {
          "id": "good",
          "text": "A sandbagger is someone rated lower than they play, right? Does that happen a lot?",
          "smoothDelta": 24,
          "theirResponse": "Too often. That's why ratings are a big deal.",
          "coachNote": "You checked the term instead of pretending."
        },
        {
          "id": "meh",
          "text": "That sounds unfair.",
          "smoothDelta": 6,
          "theirResponse": "It is! People get really riled up about it.",
          "coachNote": "Sympathetic and safe."
        },
        {
          "id": "cringe",
          "text": "Maybe you're the sandbagger.",
          "smoothDelta": -18,
          "theirResponse": "Excuse me?",
          "coachNote": "Never accuse her. Joking about cheating goes badly."
        }
      ]
    }
  ],
  "closingNote": "A rating like 3.5 or 4.0 describes level of play, and systems like DUPR try to track it more precisely."
}
```

### 4.6 Her team lost (`tt-team-loss`)

- **Setting:** Sam's favorite MLP team lost after a tie.
- **Enthusiast opening:** "We lost in the DreamBreaker again. I can't."
- **What it means:** She follows an MLP team that lost on a DreamBreaker. Terms: MLP, DreamBreaker, team format.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "That's rough. It came down to the tiebreak after 2-2? Did they play well?" | +25 | You knew the tiebreak follows a tie, and led with empathy. |
| 1 | meh | "What is a DreamBreaker?" | +6 | Fine, but explain how you'll learn it, too. |
| 1 | cringe | "They always lose. Maybe root for another team." | -20 | Loyalty matters to fans. Never suggest switching teams. |
| 2 | good | "Home crowd could help! Who's their toughest opponent?" | +22 | You matched her hope with curiosity. |
| 2 | meh | "Good luck!" | +4 | Kind, but a follow-up question builds more. |
| 2 | cringe | "They probably won't." | -15 | Don't predict doom for someone's team. |

```json
{
  "title": "Her team lost",
  "setting": "Sam's favorite MLP team lost after a tie.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We lost in the DreamBreaker again. I can't.",
      "replies": [
        {
          "id": "good",
          "text": "That's rough. It came down to the tiebreak after 2-2? Did they play well?",
          "smoothDelta": 25,
          "theirResponse": "Yes, two games each, then the DreamBreaker. So close.",
          "coachNote": "You knew the tiebreak follows a tie, and led with empathy."
        },
        {
          "id": "meh",
          "text": "What is a DreamBreaker?",
          "smoothDelta": 6,
          "theirResponse": "The tiebreak game to 21 when a match is 2-2.",
          "coachNote": "Fine, but explain how you'll learn it, too."
        },
        {
          "id": "cringe",
          "text": "They always lose. Maybe root for another team.",
          "smoothDelta": -20,
          "theirResponse": "Wow. No.",
          "coachNote": "Loyalty matters to fans. Never suggest switching teams."
        }
      ]
    },
    {
      "theirMessage": "Next week we play at home. We have to win.",
      "replies": [
        {
          "id": "good",
          "text": "Home crowd could help! Who's their toughest opponent?",
          "smoothDelta": 22,
          "theirResponse": "They're a tough team. But at home, we'll see.",
          "coachNote": "You matched her hope with curiosity."
        },
        {
          "id": "meh",
          "text": "Good luck!",
          "smoothDelta": 4,
          "theirResponse": "Thanks!",
          "coachNote": "Kind, but a follow-up question builds more."
        },
        {
          "id": "cringe",
          "text": "They probably won't.",
          "smoothDelta": -15,
          "theirResponse": "Not helpful.",
          "coachNote": "Don't predict doom for someone's team."
        }
      ]
    }
  ],
  "closingNote": "In MLP, a match is four games; if it is 2-2 a rally-scoring DreamBreaker decides it."
}
```

### 4.7 Come play (`tt-come-play`)

- **Setting:** Sam needs a fourth for tonight.
- **Enthusiast opening:** "We need a fourth tonight at 7. Come play! I'll teach you."
- **What it means:** She invites you to play. Terms: open play, fourth, beginner, borrow a paddle.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "I'd love to. Fair warning: total beginner. Can I borrow a paddle?" | +30 | Honest, eager, practical. The best answer. |
| 1 | meh | "Maybe another time, I'm busy." | -4 | Polite but you may miss a moment. |
| 1 | cringe | "Sure, I'm basically a 4.0 already." | -20 | Faking a level backfires in one rally. |
| 2 | good | "Kitchen: no volleys in the zone, right? I can stand there but not volley?" | +25 | Showed what you learned, asked to confirm. |
| 2 | meh | "Okay, will do." | +5 | Good, but a question would help. |
| 2 | cringe | "I'm not scared of a kitchen, ha." | -10 | Learn the term before joking about it. |

```json
{
  "title": "Come play",
  "setting": "Sam needs a fourth for tonight.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We need a fourth tonight at 7. Come play! I'll teach you.",
      "replies": [
        {
          "id": "good",
          "text": "I'd love to. Fair warning: total beginner. Can I borrow a paddle?",
          "smoothDelta": 30,
          "theirResponse": "Perfect. You'll do great. I'll show you the kitchen.",
          "coachNote": "Honest, eager, practical. The best answer."
        },
        {
          "id": "meh",
          "text": "Maybe another time, I'm busy.",
          "smoothDelta": -4,
          "theirResponse": "Sure, no pressure.",
          "coachNote": "Polite but you may miss a moment."
        },
        {
          "id": "cringe",
          "text": "Sure, I'm basically a 4.0 already.",
          "smoothDelta": -20,
          "theirResponse": "Oh? We'll see...",
          "coachNote": "Faking a level backfires in one rally."
        }
      ]
    },
    {
      "theirMessage": "Wear court shoes if you have them. And don't step in the kitchen!",
      "replies": [
        {
          "id": "good",
          "text": "Kitchen: no volleys in the zone, right? I can stand there but not volley?",
          "smoothDelta": 25,
          "theirResponse": "Yes! You already know more than you think.",
          "coachNote": "Showed what you learned, asked to confirm."
        },
        {
          "id": "meh",
          "text": "Okay, will do.",
          "smoothDelta": 5,
          "theirResponse": "Great, see you there.",
          "coachNote": "Good, but a question would help."
        },
        {
          "id": "cringe",
          "text": "I'm not scared of a kitchen, ha.",
          "smoothDelta": -10,
          "theirResponse": "...It's the no-volley zone. Never mind.",
          "coachNote": "Learn the term before joking about it."
        }
      ]
    }
  ],
  "closingNote": "Being honest about your level is the friendliest way to join a game."
}
```

### 4.8 Her sore elbow (`tt-elbow`)

- **Setting:** Sam mentions being sore after a long session.
- **Enthusiast opening:** "My elbow is killing me after three hours of open play."
- **What it means:** She mentions elbow pain after long sessions. Terms: warm-up, rest, professional advice.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "That sounds rough. Do you get breaks between games?" | +25 | Caring and practical, not a diagnosis. |
| 1 | meh | "You should ice it." | +4 | Fine, but avoid instructing on health. |
| 1 | cringe | "Play through it, no pain no gain." | -20 | Never encourage playing through pain. |

```json
{
  "title": "Her sore elbow",
  "setting": "Sam mentions being sore after a long session.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "My elbow is killing me after three hours of open play.",
      "replies": [
        {
          "id": "good",
          "text": "That sounds rough. Do you get breaks between games?",
          "smoothDelta": 25,
          "theirResponse": "Not really, and I never warm up. Fair point.",
          "coachNote": "Caring and practical, not a diagnosis."
        },
        {
          "id": "meh",
          "text": "You should ice it.",
          "smoothDelta": 4,
          "theirResponse": "Yeah, maybe.",
          "coachNote": "Fine, but avoid instructing on health."
        },
        {
          "id": "cringe",
          "text": "Play through it, no pain no gain.",
          "smoothDelta": -20,
          "theirResponse": "That's terrible advice.",
          "coachNote": "Never encourage playing through pain."
        }
      ]
    }
  ],
  "closingNote": "Be kind and general: warm up, take breaks, and see a professional if the pain lingers."
}
```

### 4.9 Rally scoring rant (`tt-rally-rant`)

- **Setting:** Sam is passionate about scoring formats.
- **Enthusiast opening:** "Rally scoring ruins comebacks. Side-out forever."
- **What it means:** She dislikes rally scoring. Terms: rally scoring, side-out, comeback.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Because with side-out you can string points on your serve? Tell me more." | +28 | You inferred the difference and invited her opinion. |
| 1 | meh | "Isn't rally scoring newer?" | +6 | Fine. Add a follow-up question. |
| 1 | cringe | "Rally scoring is obviously better." | -18 | Don't pick sides in a debate you just learned. |

```json
{
  "title": "Rally scoring rant",
  "setting": "Sam is passionate about scoring formats.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Rally scoring ruins comebacks. Side-out forever.",
      "replies": [
        {
          "id": "good",
          "text": "Because with side-out you can string points on your serve? Tell me more.",
          "smoothDelta": 28,
          "theirResponse": "Exactly, big runs on serve. Rally scoring flattens it.",
          "coachNote": "You inferred the difference and invited her opinion."
        },
        {
          "id": "meh",
          "text": "Isn't rally scoring newer?",
          "smoothDelta": 6,
          "theirResponse": "It is, and people are split.",
          "coachNote": "Fine. Add a follow-up question."
        },
        {
          "id": "cringe",
          "text": "Rally scoring is obviously better.",
          "smoothDelta": -18,
          "theirResponse": "...And now we're arguing.",
          "coachNote": "Don't pick sides in a debate you just learned."
        }
      ]
    }
  ],
  "closingNote": "Side-out scoring lets only the server score; rally scoring gives a point on every rally. Fans debate both."
}
```

## 5. Talk Track roster at launch (18)

The nine scenarios above plus nine more to author: post-game recap (win), first tournament nerves, the paddle stack etiquette moment, favourite pro player ({{player}}), MLP team trade news ({{team}}), noise complaint at the local courts, court reservation frustration, invited to a doubles round robin, the she-wants-to-teach-you-a-serve moment. Personalized tracks use `{{token}}` substitution with safe defaults.

## 6. Asset needs (all `original-swoond`)

| Asset | Used by | Notes |
|---|---|---|
| `pickleball-court` and `pickleball-court-top` diagrams | binary-call, hotspot-tap | Procedural: lines, kitchen, service boxes |
| `images/pickleball/balls-indoor-outdoor.svg`, `paddle-shapes.svg`, `shot-arcs.svg` | visual-id | Original vector art, alt text without giving away the answer |
| `audio/pickleball/dink-soft.m4a`, `drive-hard.m4a`, `ball-indoor.m4a` (+ outdoor) | listening-id | Original foley or synthesised; descriptions provided for accessibility |

## 7. Voice and safety notes

- Cheeky coach, never mean, one joke per screen, never about the crush.
- Never mock older players, beginners, or "pickleball people".
- Injury items are generic and always carry a `safetyNote`; no medical claims.
- Rule items cite the concept, not the rulebook text; rule wording that changed in 2026 is flagged for re-verification before release.
