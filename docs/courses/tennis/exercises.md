# Native Exercise Plan: Tennis (`tennis`)

Tier B plan for `docs/courses/tennis/`. Twelve of the 13 native exercise types are used (`listening-id` is deliberately unused, see CDS section 12); Tier A sims are in `sims/`. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup). Conventions: prompts <= 12 words; every answer explained; `license` ids are `original-swoond` (procedural or original vector art); no tournament, tour or brand marks. Rule text is paraphrased, never copied from the ITF, ATP or WTA rulebooks. Facts that change (rankings, results, calendars) never appear in evergreen payloads; they come from the live layer.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite: rules, scoring logic, tiers, "which is true". Distractors are the classic beginner errors from CDS section 2. | ~240 |
| `binary-call` | Every yes/no rule call: in or out, let or fault, foot fault, hindrance. Scenes use the procedural `tennis-court-top` diagram. | ~70 |
| `term-match` | Introduce 3 to 6 related terms at unit starts (strokes, scoring, draw words, tiers) and in Term Blitz. | ~35 |
| `sequence-order` | Tiebreak serving, season shape, pro pathway, Slam fortnight, point flow. | ~25 |
| `visual-id` | Grips, racquet shapes, surfaces from original vector art; alt text does not give away answers. | ~25 |
| `decision-scenario` | Line-call disputes, second-serve plans, etiquette, rec dilemmas, injury care with `safetyNote`. | ~55 |
| `talk-track` | 20 tracks at launch (8 authored in section 4); Smooth meter; replies model curiosity over expertise. | 20 |
| `timing-tap` | Serve toss, split step, contact rhythm; 1D only. | ~10 |
| `say-this` | Decode slang, recaps, match talk, gear talk. Every item has a `noFakeExpertNote`. | ~80 |
| `fill-the-gap` | Vocabulary and rule sentences in context. | ~45 |
| `estimate-slider` | Court length, net height, first-serve percentage, tiebreak points, string tension ranges. | ~20 |
| `hotspot-tap` | The T, alleys, service boxes, formations, scoreboard, draw bracket. | ~45 |

Estimated totals: about 670 native items across 119 lessons plus the review loop. Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape. Talk-track samples are in section 4 (eight full payloads).

### 2.1 `multiple-choice`

The default knowledge check and Daily Bite card. Used for rules, definitions, scoring logic and 'which is true' checks in every unit; three or four options; distractors are the classic beginner errors from CDS section 2.

**Sample 1** (lesson `score-01`)

```json
{
  "prompt": "What does 'love' mean in tennis scoring?",
  "options": [
    {
      "id": "a",
      "text": "Zero points"
    },
    {
      "id": "b",
      "text": "One point"
    },
    {
      "id": "c",
      "text": "A tied score"
    },
    {
      "id": "d",
      "text": "A serve fault"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Love means zero. Nobody knows the exact origin for sure; one popular guess is the French word for egg, l'oeuf, for a zero.",
    "incorrect": "Love just means zero. A tied score has its own word: 'all', as in 'thirty-all'.",
    "sayThisLine": "Fifteen-love. She's up a point."
  }
}
```

**Sample 2** (lesson `score-03`)

```json
{
  "prompt": "To win a set, what must a player usually reach?",
  "options": [
    {
      "id": "a",
      "text": "Four points"
    },
    {
      "id": "b",
      "text": "Six games, two clear"
    },
    {
      "id": "c",
      "text": "Ten points"
    },
    {
      "id": "d",
      "text": "Three games"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "A set is won with six games and a two-game lead. At 6-6 a tiebreak usually decides it.",
    "incorrect": "Four points wins a game, not a set. A set is six games, two clear, with a tiebreak at 6-6.",
    "sayThisLine": "Wait, a set is games, not points?"
  }
}
```

**Sample 3** (lesson `serve-02`)

```json
{
  "prompt": "Why do players often serve slower on the second serve?",
  "options": [
    {
      "id": "a",
      "text": "They are tired"
    },
    {
      "id": "b",
      "text": "A miss loses the point, so safety wins"
    },
    {
      "id": "c",
      "text": "The rules require it"
    },
    {
      "id": "d",
      "text": "The ball is heavier"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Two misses in a row is a double fault and a lost point. The second serve trades speed for safety, usually with spin.",
    "incorrect": "Nothing in the rules slows the second serve. It is a choice: a miss loses the point, so spin and margin beat speed.",
    "sayThisLine": "Second serve is safe. Kick it in."
  }
}
```

### 2.2 `binary-call`

Every yes/no rule call: in or out, let or fault, legal or not. Scenes use the procedural `tennis-court-top` diagram; `ruleTag` names the rule. Dynamic concepts are promoted to the Unity sims, not here.

**Sample 1** (lesson `court-06`)

```json
{
  "prompt": "The ball touches the baseline. In or out?",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "tennis-court-top",
    "markers": [
      {
        "role": "ball",
        "x": 0.42,
        "y": 0.94
      },
      {
        "role": "player",
        "x": 0.5,
        "y": 0.98
      }
    ],
    "alt": "Top-down tennis court. A ball is drawn touching the baseline on the near side of the court."
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
    "correct": "Any part of the ball touching the line counts. Lines are in, including the baseline.",
    "incorrect": "A ball that touches any part of the line is in. Only the ball landing fully outside the line is out.",
    "sayThisLine": "It clipped the line, so it was in."
  },
  "ruleTag": "Lines are in"
}
```

**Sample 2** (lesson `serve-03`)

```json
{
  "prompt": "The serve clips the net and lands in the box.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "tennis-court-top",
    "markers": [
      {
        "role": "ball",
        "x": 0.35,
        "y": 0.35
      },
      {
        "role": "player",
        "x": 0.6,
        "y": 0.96
      }
    ],
    "alt": "Top-down court. A served ball has touched the net and landed inside the correct service box."
  },
  "choices": [
    {
      "id": "let",
      "label": "Let: replay"
    },
    {
      "id": "fault",
      "label": "Fault"
    }
  ],
  "correctChoiceId": "let",
  "explanation": {
    "correct": "A serve that touches the net and lands in the correct box is a let: replay the serve, with no limit on lets.",
    "incorrect": "It is not a fault. A net-cord serve that lands in is a let and is replayed. That is different from pickleball, which has no service lets.",
    "sayThisLine": "Let. Serve it again."
  },
  "ruleTag": "Service let"
}
```

**Sample 3** (lesson `serve-01`)

```json
{
  "prompt": "The server's foot touches the baseline before contact.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "tennis-court-top",
    "markers": [
      {
        "role": "player",
        "x": 0.62,
        "y": 0.95
      },
      {
        "role": "ball",
        "x": 0.62,
        "y": 0.9
      }
    ],
    "alt": "Top-down court. The server's shoe is drawn on top of the baseline at the moment of the toss."
  },
  "choices": [
    {
      "id": "fault",
      "label": "Foot fault"
    },
    {
      "id": "legal",
      "label": "Legal"
    }
  ],
  "correctChoiceId": "fault",
  "explanation": {
    "correct": "The server must stay behind the baseline and not touch the line or the court until the ball is struck. Touching the line is a foot fault.",
    "incorrect": "Feet may not touch the baseline or the court before contact. A toe on the line is a foot fault, even a small one.",
    "sayThisLine": "Her toe was on the line. Foot fault."
  },
  "ruleTag": "Foot fault"
}
```

### 2.3 `term-match`

Introduce 3 to 6 related terms at the start of a unit (strokes, scoring, draw words, tiers) and in Term Blitz reviews.

**Sample 1** (lesson `stroke-03`)

```json
{
  "prompt": "Match the shot to what it is.",
  "pairs": [
    {
      "id": "volley",
      "term": "Volley",
      "definition": "Hit before the ball bounces"
    },
    {
      "id": "overhead",
      "term": "Overhead",
      "definition": "A smash over your head"
    },
    {
      "id": "drop",
      "term": "Drop shot",
      "definition": "A soft shot that dies near the net"
    },
    {
      "id": "lob",
      "term": "Lob",
      "definition": "A high shot over the net player"
    }
  ],
  "distractorDefinitions": [
    "A serve that clips the net"
  ],
  "explanation": {
    "summary": "Volley and overhead are hit in the air; the drop shot and the lob are touch shots to move the opponent.",
    "sayThisLine": "She lobbed him and he was toast."
  }
}
```

**Sample 2** (lesson `score-02`)

```json
{
  "prompt": "Match the scoring word to its meaning.",
  "pairs": [
    {
      "id": "love",
      "term": "Love",
      "definition": "Zero points"
    },
    {
      "id": "deuce",
      "term": "Deuce",
      "definition": "40-40; win two in a row to finish"
    },
    {
      "id": "adv",
      "term": "Advantage",
      "definition": "One point ahead after deuce"
    },
    {
      "id": "tb",
      "term": "Tiebreak",
      "definition": "A points game played at 6-6"
    }
  ],
  "distractorDefinitions": [
    "A serve that lands in the net"
  ],
  "explanation": {
    "summary": "Games need a two-point lead; that is why deuce and advantage exist.",
    "sayThisLine": "It went to deuce three times."
  }
}
```

**Sample 3** (lesson `tours-06`)

```json
{
  "prompt": "Match the draw word to what it means.",
  "pairs": [
    {
      "id": "seed",
      "term": "Seed",
      "definition": "A top-ranked player placed to avoid others early"
    },
    {
      "id": "bye",
      "term": "Bye",
      "definition": "Skipping a round without playing"
    },
    {
      "id": "wc",
      "term": "Wild card",
      "definition": "An entry granted by the tournament"
    },
    {
      "id": "q",
      "term": "Qualifier",
      "definition": "Won through the pre-event qualifying"
    },
    {
      "id": "ll",
      "term": "Lucky loser",
      "definition": "A qualifying loser who replaces a withdrawn player"
    }
  ],
  "distractorDefinitions": [
    "A player who serves underhand"
  ],
  "explanation": {
    "summary": "Seeds and byes protect the top of the draw; wild cards, qualifiers and lucky losers fill the rest.",
    "sayThisLine": "She's a lucky loser and she reached the quarters."
  }
}
```

### 2.4 `sequence-order`

Order is the concept: tiebreak serving, season shape, tour pathway, Slam fortnight, point flow.

**Sample 1** (lesson `tours-04`)

```json
{
  "prompt": "Order the season's main stretches, January to November.",
  "items": [
    {
      "id": "aus",
      "text": "Australian swing and Australian Open",
      "why": "The first Slam opens the season in January."
    },
    {
      "id": "sun",
      "text": "Sunshine Double: Indian Wells, Miami",
      "why": "Two big hard-court events in the US spring."
    },
    {
      "id": "clay",
      "text": "Clay season and Roland-Garros",
      "why": "Slow red clay from April into June."
    },
    {
      "id": "grass",
      "text": "Grass season and Wimbledon",
      "why": "A short grass stretch around late June and July."
    },
    {
      "id": "us",
      "text": "US hard courts and the US Open",
      "why": "The summer hard-court swing ends with the last Slam."
    },
    {
      "id": "indoor",
      "text": "Asian swing, indoors, year-end Finals",
      "why": "The season closes indoors with Finals in November."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Hard, hard, clay, grass, hard, indoor hard: the surfaces change through the year and so do the favourites.",
    "incorrect": "Start with the Australian Open in January and finish with the Finals in November; clay comes before grass.",
    "sayThisLine": "Clay season is my favourite stretch."
  }
}
```

**Sample 2** (lesson `score-04`)

```json
{
  "prompt": "Order a standard seven-point tiebreak's serving.",
  "items": [
    {
      "id": "p1",
      "text": "Player A serves one point",
      "why": "The player due to serve starts the tiebreak with one point."
    },
    {
      "id": "p2",
      "text": "Player B serves two points",
      "why": "After the first point the server changes every two points."
    },
    {
      "id": "p3",
      "text": "Player A serves two points",
      "why": "Serve alternates in pairs."
    },
    {
      "id": "sw",
      "text": "Players change ends after six points",
      "why": "Ends change every six points to balance sun and wind."
    },
    {
      "id": "win",
      "text": "First to seven, two clear, wins the set",
      "why": "At 6-6 in the tiebreak play continues until someone is two ahead."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "One point, then two each: A, BB, AA, BB. Change ends every six points; first to seven with a two-point lead wins.",
    "incorrect": "The pattern is one serve for the first player, then two each, changing ends every six points.",
    "sayThisLine": "Whose serve is it in the breaker?"
  }
}
```

**Sample 3** (lesson `tours-08`)

```json
{
  "prompt": "Order a typical path to the pro tours.",
  "items": [
    {
      "id": "jr",
      "text": "Junior tournaments",
      "why": "Most future pros start with age-group events."
    },
    {
      "id": "col",
      "text": "College tennis or ITF World Tennis Tour",
      "why": "Players build ranking points on the entry-level tour or in college."
    },
    {
      "id": "chal",
      "text": "Challenger and WTA 125 events",
      "why": "The step below the main tours."
    },
    {
      "id": "tour",
      "text": "ATP or WTA Tour events",
      "why": "The main tours with the biggest points and prize money."
    },
    {
      "id": "slam",
      "text": "Grand Slam main draws",
      "why": "The top-ranked players and qualifiers enter the Slams."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "There are exceptions, but most pros climb from juniors and the entry-level tours through Challengers into the main tours.",
    "incorrect": "Start with juniors and the entry level, then Challengers, then the main tours and Slams.",
    "sayThisLine": "She came up through college tennis."
  }
}
```

### 2.5 `visual-id`

Recognising grips, racquet shapes and surfaces from original vector art (`original-swoond`); no photographs or brand marks. Alt text describes features without giving away the answer.

**Sample 1** (lesson `sgs-10`)

```json
{
  "prompt": "Which grip is shown?",
  "image": {
    "asset": "images/tennis/grip-continental.svg",
    "alt": "Line drawing of a hand on a racquet handle seen from above, with the V of the hand marked near the top edge.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Continental"
    },
    {
      "id": "b",
      "text": "Semi-western"
    },
    {
      "id": "c",
      "text": "Two-handed"
    },
    {
      "id": "d",
      "text": "Underhand"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "The V sits on the top edge: a continental grip, the classic serve and volley grip.",
    "incorrect": "With the V on the top edge it is continental. Semi-western moves the hand further under the handle for heavier topspin.",
    "sayThisLine": "She hits her serve with a continental grip."
  },
  "cues": [
    "Where does the V sit?",
    "Top edge means continental"
  ]
}
```

**Sample 2** (lesson `sgs-01`)

```json
{
  "prompt": "Which surface is this?",
  "image": {
    "asset": "images/tennis/surface-clay.svg",
    "alt": "Illustrated top-down court with a textured surface and a long slide mark beside the baseline.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Clay"
    },
    {
      "id": "b",
      "text": "Grass"
    },
    {
      "id": "c",
      "text": "Hard court"
    },
    {
      "id": "d",
      "text": "Indoor carpet"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Slide marks and a gritty surface point to clay: slow and high bouncing, and players slide into shots.",
    "incorrect": "The long slide mark is the clue: clay. Grass and hard courts do not hold marks like that.",
    "sayThisLine": "Clay season means sliding and patience."
  },
  "cues": [
    "Look for slide marks",
    "Slow, high bounce"
  ]
}
```

**Sample 3** (lesson `court-05`)

```json
{
  "prompt": "Which racquet has the larger head?",
  "image": {
    "asset": "images/tennis/racquet-head-sizes.svg",
    "alt": "Two racquet outlines side by side, labelled A and B, with different head sizes.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "A (oversize)"
    },
    {
      "id": "b",
      "text": "B (midsize)"
    },
    {
      "id": "c",
      "text": "They are equal"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "A bigger head means a larger sweet spot and more forgiveness, but often less feel.",
    "incorrect": "A has the larger head. Larger heads forgive off-centre hits but can feel less precise.",
    "sayThisLine": "Her racquet head is a bit bigger for forgiveness."
  },
  "cues": [
    "Compare head width",
    "Bigger head, bigger sweet spot"
  ]
}
```

### 2.6 `decision-scenario`

Judgment: line-call disputes, second-serve plans, etiquette, rec dilemmas, injury care (with `safetyNote`). Never coaches confrontation or faking ability.

**Sample 1** (lesson `rules-01`)

```json
{
  "prompt": "A friend's serve lands near the line. What do you do?",
  "situation": {
    "narrative": "Friendly doubles, no umpire. Your partner thinks the ball was out.",
    "facts": [
      {
        "label": "Who calls",
        "value": "The player on that side"
      },
      {
        "label": "Ball",
        "value": "Touched the line?",
        "emphasis": "warning"
      },
      {
        "label": "Doubt",
        "value": "Not sure either way"
      },
      {
        "label": "Stakes",
        "value": "Weeknight club match"
      }
    ]
  },
  "options": [
    {
      "id": "give",
      "label": "Give the benefit of the doubt: say 'good'",
      "verdict": "best",
      "consequence": "The game goes on and trust stays high.",
      "considerations": [
        "In club tennis, doubt goes to the opponent",
        "A close ball is not worth a fight"
      ]
    },
    {
      "id": "ask",
      "label": "Ask for a replay of the point",
      "verdict": "acceptable",
      "consequence": "Fair, but you must agree on it first.",
      "considerations": [
        "Replays should be agreed, not demanded",
        "Best for a genuine simultaneous doubt"
      ]
    },
    {
      "id": "argue",
      "label": "Insist it was out and keep the point",
      "verdict": "poor",
      "consequence": "The match turns tense and your friend stops trusting your calls.",
      "considerations": [
        "Calls must be honest",
        "Arguing turns a hit into a fight"
      ]
    }
  ],
  "expertNote": "The honesty code is simple: if you are not sure it was out, it was in. Your call, your responsibility.",
  "sayThisLine": "If I'm not sure, I give it to them."
}
```

**Sample 2** (lesson `rec-06`)

```json
{
  "prompt": "Her elbow aches after a long hit. What is a sensible response?",
  "situation": {
    "narrative": "She says her elbow is sore after a big weekend of tennis.",
    "facts": [
      {
        "label": "Symptom",
        "value": "Elbow ache after play",
        "emphasis": "warning"
      },
      {
        "label": "Duration",
        "value": "Two days"
      },
      {
        "label": "She plays",
        "value": "Three times a week"
      },
      {
        "label": "Your role",
        "value": "Someone who cares"
      }
    ]
  },
  "options": [
    {
      "id": "listen",
      "label": "Listen, suggest rest and a professional if it persists",
      "verdict": "best",
      "consequence": "She feels heard and gets pointed to real help.",
      "considerations": [
        "Generic, kind and non-medical",
        "A physio or doctor can advise properly"
      ]
    },
    {
      "id": "tips",
      "label": "Give her racquet and string advice",
      "verdict": "acceptable",
      "consequence": "Interested, but it may sound like diagnosing.",
      "considerations": [
        "Gear can matter, but you are not a coach",
        "Ask what her coach or physio said"
      ]
    },
    {
      "id": "push",
      "label": "Tell her to play through it",
      "verdict": "poor",
      "consequence": "She feels dismissed and may make it worse.",
      "considerations": [
        "Never encourage playing through pain",
        "Care beats toughness"
      ]
    }
  ],
  "expertNote": "Swoon'd builds appreciation, not medical advice. Listen, be kind, and let professionals advise.",
  "sayThisLine": "That sounds sore. Maybe rest it and get it looked at?",
  "safetyNote": "General information only, not medical advice. See a qualified professional for any pain."
}
```

**Sample 3** (lesson `serve-02`)

```json
{
  "prompt": "Second serve at break point. What is the smart plan?",
  "situation": {
    "narrative": "She missed her first serve. The second one decides the point.",
    "facts": [
      {
        "label": "Score",
        "value": "30-40 (break point)",
        "emphasis": "warning"
      },
      {
        "label": "Serve",
        "value": "Second"
      },
      {
        "label": "Returner",
        "value": "Steps in to attack"
      },
      {
        "label": "Spin available",
        "value": "Kick or slice"
      }
    ]
  },
  "options": [
    {
      "id": "kick",
      "label": "Kick serve deep to the body",
      "verdict": "best",
      "consequence": "It clears the net with room, bounces high, and jams the returner.",
      "considerations": [
        "Margin over the net",
        "High bounce disrupts an attacker"
      ]
    },
    {
      "id": "slice",
      "label": "Slice it wide",
      "verdict": "acceptable",
      "consequence": "Safe-ish, but the returner is set to run it down if it sits up.",
      "considerations": [
        "Curve helps margin",
        "Needs accuracy"
      ]
    },
    {
      "id": "flat",
      "label": "Flat and fast, full power",
      "verdict": "poor",
      "consequence": "It clips the net or sails long: a double fault.",
      "considerations": [
        "Second serves cannot afford a miss",
        "Flat has the least room"
      ]
    }
  ],
  "expertNote": "On second serves, players trade speed for safety. Spin brings the ball down inside the box.",
  "sayThisLine": "Second serve at break point: kick it in."
}
```

### 2.7 `timing-tap`

Only for 1D rhythm: serve toss, split step, contact. Anything that depends on a scene (arc, movement) is a Unity sim.

**Sample 1** (lesson `serve-01`)

```json
{
  "prompt": "Tap when the toss reaches the gold.",
  "theme": {
    "label": "Serve toss",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 55,
      "zoneEndPct": 72,
      "sweepSeconds": 1.8
    },
    {
      "zoneStartPct": 60,
      "zoneEndPct": 74,
      "sweepSeconds": 1.5
    },
    {
      "zoneStartPct": 64,
      "zoneEndPct": 76,
      "sweepSeconds": 1.3
    }
  ],
  "explanation": {
    "correct": "A steady toss reaches the top and hangs; hit it near the peak for control.",
    "incorrect": "Hit too early or too late and the serve loses control. Watch for the top of the toss.",
    "sayThisLine": "A good toss makes the serve easy."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `serve-07`)

```json
{
  "prompt": "Tap on the split step as the server hits.",
  "theme": {
    "label": "Split step",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 48,
      "zoneEndPct": 66,
      "sweepSeconds": 1.6
    },
    {
      "zoneStartPct": 52,
      "zoneEndPct": 66,
      "sweepSeconds": 1.4
    },
    {
      "zoneStartPct": 56,
      "zoneEndPct": 68,
      "sweepSeconds": 1.2
    }
  ],
  "explanation": {
    "correct": "A split step just as the opponent strikes readies you to move in either direction.",
    "incorrect": "Too early and you are on the ground when the ball is hit; too late and you are flat-footed.",
    "sayThisLine": "Split step as she hits it."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

**Sample 3** (lesson `stroke-02`)

```json
{
  "prompt": "Tap at contact: the zone is small.",
  "theme": {
    "label": "Contact point",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 60,
      "zoneEndPct": 74,
      "sweepSeconds": 1.5
    },
    {
      "zoneStartPct": 64,
      "zoneEndPct": 74,
      "sweepSeconds": 1.3
    }
  ],
  "explanation": {
    "correct": "Clean contact in front of the body is the difference between a heavy shot and a frame.",
    "incorrect": "Contact too early or late misfires. Timing is a rhythm, not force.",
    "sayThisLine": "Contact in front made it so clean."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.8 `say-this`

Decode what she just said: slang, recaps, match talk, gear talk. Every item has a `noFakeExpertNote` and follow-ups that are honest curiosity.

**Sample 1** (lesson `stroke-07`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "We got bageled in the first set, then won it in a breaker."
  },
  "options": [
    {
      "id": "a",
      "text": "They lost the first set 6-0",
      "isCorrect": true,
      "explanation": "A bagel is a 6-0 set."
    },
    {
      "id": "b",
      "text": "They won the match on a tiebreak",
      "isCorrect": true,
      "explanation": "A breaker is a tiebreak."
    },
    {
      "id": "c",
      "text": "They lost the whole match 6-0, 6-0",
      "isCorrect": false,
      "explanation": "She said they won it."
    },
    {
      "id": "d",
      "text": "A bagel is a food break",
      "isCorrect": false,
      "explanation": "Just slang for zero."
    }
  ],
  "translation": "They lost the first set 6-0 and then won the deciding set with a tiebreak.",
  "followUps": [
    {
      "line": "Wow, what changed after the first set?",
      "why": "Shows curiosity about the turnaround."
    },
    {
      "line": "Was the breaker close?",
      "why": "Invites her to relive the tense part."
    }
  ],
  "noFakeExpertNote": "You can ask what a bagel is; guessing wrong out loud is cheaper than nodding."
}
```

**Sample 2** (lesson `read-02`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "That hold at 5-5 was massive. She saved two break points."
  },
  "options": [
    {
      "id": "a",
      "text": "She won her own service game to stay in the set",
      "isCorrect": true,
      "explanation": "A hold is winning your own serve."
    },
    {
      "id": "b",
      "text": "She broke her opponent's serve",
      "isCorrect": false,
      "explanation": "That would be a break."
    },
    {
      "id": "c",
      "text": "Break points were stopped by the umpire",
      "isCorrect": false,
      "explanation": "Break points are chances for the returner."
    },
    {
      "id": "d",
      "text": "The set was still alive at 5-5",
      "isCorrect": true,
      "explanation": "Winning the game kept it level."
    }
  ],
  "translation": "At 5-5 she won her own service game, saving two break points, and stayed level in the set.",
  "followUps": [
    {
      "line": "What did she do on the break points?",
      "why": "Asks for the story behind the stat."
    },
    {
      "line": "Did that change the match?",
      "why": "Shows you get why holds matter."
    }
  ],
  "noFakeExpertNote": "If you cannot name the serve, ask: 'Was she serving?'"
}
```

**Sample 3** (lesson `sgs-07`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "Kick serve is money on clay. It jumps right up at the returner."
  },
  "options": [
    {
      "id": "a",
      "text": "A topspin serve that bounces high",
      "isCorrect": true,
      "explanation": "Kick means heavy topspin."
    },
    {
      "id": "b",
      "text": "Clay slows the ball so high bounces are hard to attack",
      "isCorrect": true,
      "explanation": "Clay is slow and the bounce sits up."
    },
    {
      "id": "c",
      "text": "A kick serve is a serve with the foot",
      "isCorrect": false,
      "explanation": "No feet; it is racquet spin."
    },
    {
      "id": "d",
      "text": "Money means it is expensive",
      "isCorrect": false,
      "explanation": "Money means it works well."
    }
  ],
  "translation": "A topspin serve that bounces high is especially effective on clay, where the slow surface lets the bounce sit up at the returner.",
  "followUps": [
    {
      "line": "Does it work as well on grass?",
      "why": "Invites a comparison between surfaces."
    },
    {
      "line": "Who has the best kick serve, in your opinion?",
      "why": "Invites her opinion without faking expertise."
    }
  ],
  "noFakeExpertNote": "You do not have to name a player; asking her to explain the bounce is enough."
}
```

### 2.9 `fill-the-gap`

Vocabulary in context and rule sentences. Quick review card.

**Sample 1** (lesson `score-03`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "A set goes to {{games}} games, and the winner must be {{margin}} clear.",
  "gaps": [
    {
      "id": "games",
      "options": [
        "four",
        "six",
        "eight"
      ],
      "correct": "six"
    },
    {
      "id": "margin",
      "options": [
        "one game",
        "two games",
        "three games"
      ],
      "correct": "two games"
    }
  ],
  "explanation": {
    "correct": "Six games with a two-game lead; at 6-6 a tiebreak decides it.",
    "incorrect": "A normal set is six games and a two-game lead. That is why 6-5 continues.",
    "sayThisLine": "She took the set six-four."
  }
}
```

**Sample 2** (lesson `sgs-01`)

```json
{
  "prompt": "Complete the surface facts.",
  "template": "Wimbledon is played on {{a}} and Roland-Garros on {{b}}.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "grass",
        "clay",
        "hard court"
      ],
      "correct": "grass"
    },
    {
      "id": "b",
      "options": [
        "grass",
        "clay",
        "hard court"
      ],
      "correct": "clay"
    }
  ],
  "explanation": {
    "correct": "Grass for Wimbledon, clay for Roland-Garros. The other two Slams are on hard courts.",
    "incorrect": "Wimbledon is grass; Roland-Garros is clay. Only the Australian and US Opens are hard courts.",
    "sayThisLine": "Wimbledon is grass, Roland-Garros is clay."
  }
}
```

**Sample 3** (lesson `stroke-02`)

```json
{
  "prompt": "Finish the shot description.",
  "template": "Topspin makes the ball {{path}} over the net and {{dip}} into the court.",
  "gaps": [
    {
      "id": "path",
      "options": [
        "travel high",
        "travel low"
      ],
      "correct": "travel high"
    },
    {
      "id": "dip",
      "options": [
        "dip",
        "float"
      ],
      "correct": "dip"
    }
  ],
  "explanation": {
    "correct": "Topspin curves the ball downward, so players can aim higher over the net and still land it in.",
    "incorrect": "Topspin makes the ball dip. That gives margin over the net and helps keep it in.",
    "sayThisLine": "Her topspin dips right at the baseline."
  }
}
```

### 2.10 `estimate-slider`

Magnitudes: court length, net height, first-serve percentage, ranking-point ideas (as live context, never hard-coded).

**Sample 1** (lesson `court-02`)

```json
{
  "prompt": "How long is a tennis court?",
  "unit": "feet",
  "min": 40,
  "max": 120,
  "step": 2,
  "correctValue": 78,
  "tolerance": {
    "full": 2,
    "partial": 6
  },
  "explanation": {
    "correct": "78 feet from baseline to baseline. Doubles is wider (36 ft) but the length is the same.",
    "incorrect": "78 feet, or about 23.8 metres. Singles and doubles share that length.",
    "sayThisLine": "Seventy-eight feet, baseline to baseline."
  }
}
```

**Sample 2** (lesson `court-02`)

```json
{
  "prompt": "How high is the net at the centre?",
  "unit": "inches",
  "min": 20,
  "max": 60,
  "step": 1,
  "correctValue": 36,
  "tolerance": {
    "full": 1,
    "partial": 4
  },
  "explanation": {
    "correct": "Three feet, 36 inches, in the middle. The posts are a bit higher at 42 inches.",
    "incorrect": "36 inches at the centre. It rises to 42 at the posts, which is why the middle is the lowest spot.",
    "sayThisLine": "The net is lowest in the middle."
  }
}
```

**Sample 3** (lesson `serve-06`)

```json
{
  "prompt": "Roughly what share of first serves do top pros land in?",
  "unit": "percent",
  "min": 30,
  "max": 90,
  "step": 1,
  "correctValue": 62,
  "tolerance": {
    "full": 4,
    "partial": 9
  },
  "explanation": {
    "correct": "Around 60 to 65 percent is typical at the top level. It varies by player and surface.",
    "incorrect": "Typically about 60 to 65 percent. Even the best miss a third of the time, which is why the second serve matters.",
    "sayThisLine": "About six in ten first serves go in."
  }
}
```

### 2.11 `hotspot-tap`

Static diagrams: the T, alleys, service boxes, formations, scoreboard. Movement questions are Unity.

**Sample 1** (lesson `court-04`)

```json
{
  "prompt": "Tap the T on the far side.",
  "diagram": {
    "diagramId": "tennis-court-top",
    "aspectRatio": 0.55,
    "alt": "Top-down tennis court with net across the middle, service lines, a centre service line and the baselines."
  },
  "hotspots": [
    {
      "id": "t-far",
      "label": "The T (far side)",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.258,
        "r": 0.05
      }
    },
    {
      "id": "net-centre",
      "label": "Net centre",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.05
      }
    },
    {
      "id": "baseline-mark",
      "label": "Baseline centre mark",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.05,
        "r": 0.05
      }
    },
    {
      "id": "alley-l",
      "label": "Doubles alley (left)",
      "shape": {
        "kind": "rect",
        "x": 0.1,
        "y": 0.05,
        "w": 0.1,
        "h": 0.9
      }
    }
  ],
  "correctHotspotIds": [
    "t-far"
  ],
  "explanation": {
    "correct": "The T is where the service line meets the centre service line. It is the favourite target for aces.",
    "incorrect": "The T is the meeting point of the service line and the centre line, not the net or baseline.",
    "sayThisLine": "He hit the T for the ace."
  }
}
```

**Sample 2** (lesson `court-03`)

```json
{
  "prompt": "Tap a strip used only in doubles.",
  "diagram": {
    "diagramId": "tennis-court-top",
    "aspectRatio": 0.55,
    "alt": "Top-down tennis court showing singles and doubles sidelines."
  },
  "hotspots": [
    {
      "id": "alley-l",
      "label": "Left doubles alley",
      "shape": {
        "kind": "rect",
        "x": 0.1,
        "y": 0.05,
        "w": 0.1,
        "h": 0.9
      }
    },
    {
      "id": "alley-r",
      "label": "Right doubles alley",
      "shape": {
        "kind": "rect",
        "x": 0.8,
        "y": 0.05,
        "w": 0.1,
        "h": 0.9
      }
    },
    {
      "id": "box-l",
      "label": "Service box (far left)",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.258,
        "w": 0.3,
        "h": 0.242
      }
    },
    {
      "id": "baseline",
      "label": "Far baseline",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.04,
        "w": 0.6,
        "h": 0.03
      }
    }
  ],
  "correctHotspotIds": [
    "alley-l",
    "alley-r"
  ],
  "explanation": {
    "correct": "The alleys are the outer strips between the singles and doubles sidelines; in play only in doubles.",
    "incorrect": "The alleys are the outer strips: in in doubles, out in singles.",
    "sayThisLine": "That's out in singles but in in doubles."
  }
}
```

**Sample 3** (lesson `serve-04`)

```json
{
  "prompt": "Serving from the right: tap the target box.",
  "diagram": {
    "diagramId": "tennis-court-top",
    "aspectRatio": 0.55,
    "alt": "Top-down court seen from the server's end, server at the bottom on the right of the centre mark."
  },
  "hotspots": [
    {
      "id": "far-left",
      "label": "Far left box",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.258,
        "w": 0.3,
        "h": 0.242
      }
    },
    {
      "id": "far-right",
      "label": "Far right box",
      "shape": {
        "kind": "rect",
        "x": 0.5,
        "y": 0.258,
        "w": 0.3,
        "h": 0.242
      }
    },
    {
      "id": "near-left",
      "label": "Near left box",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.5,
        "w": 0.3,
        "h": 0.242
      }
    },
    {
      "id": "near-right",
      "label": "Near right box",
      "shape": {
        "kind": "rect",
        "x": 0.5,
        "y": 0.5,
        "w": 0.3,
        "h": 0.242
      }
    }
  ],
  "correctHotspotIds": [
    "far-left"
  ],
  "explanation": {
    "correct": "A right-side server hits diagonally to the far left box, as seen from the server's end.",
    "incorrect": "Serves go diagonal. From the right you aim at the far box on the left, not straight ahead.",
    "sayThisLine": "Deuce court serves go to the far left box."
  }
}
```

### 2.12 `talk-track`

See section 4: eight complete payloads (each with two exchanges and good/meh/cringe replies) and the launch roster in section 5.

## 3. Playbook terms (68)

The Playbook shows each term with a definition and an example line in the voice of the person she is learning for. Lines are what the crush might say, never what the learner should fake. Terms unlock on first use; Term Blitz reviews draw from this list. No time-sensitive facts (rankings, results) appear here.

| # | Term | Definition | Example line (crush's voice) |
|---|---|---|---|
| 1 | Baseline | The back line at each end; the server stands behind it. | "I got a foot fault: my toe was on the baseline." |
| 2 | Tramlines / alleys | The outer strips that are in for doubles and out for singles. | "That was in the alley, so it's out in singles." |
| 3 | The T | Where the service line meets the centre service line. | "She hit the T for an ace." |
| 4 | Service box | The rectangle the serve must land in, diagonal from the server. | "It landed in the box by a hair." |
| 5 | Love | Zero points. | "I was down thirty-love before I woke up." |
| 6 | Deuce | 40-40; a player must win two points in a row to take the game. | "We went to deuce four times." |
| 7 | Advantage | One point ahead after deuce. | "Advantage me, but I choked." |
| 8 | Game | Four points won by a two-point lead. | "I held my game to love." |
| 9 | Set | Six games won by two, or a tiebreak at 6-6. | "I took the first set six-three." |
| 10 | Tiebreak | A points game played at 6-6; usually to seven, win by two. | "The set went to a tiebreak and I nearly cried." |
| 11 | Match tiebreak | A ten-point breaker used instead of a deciding set in some formats. | "We played a ten-point breaker for the third set." |
| 12 | Final-set tiebreak | The Grand Slam ten-point breaker at 6-6 in the deciding set. | "It went to a ten-point breaker at 6-6 in the fifth." |
| 13 | Hold | Winning your own service game. | "That hold at 5-5 changed the match." |
| 14 | Break | Winning a game your opponent served. | "She got the break in the third game." |
| 15 | Break point | A point that would win the game on the opponent's serve. | "She saved three break points." |
| 16 | Ace | A serve the returner never touches. | "Nine aces in one set!" |
| 17 | Fault | A serve that misses the box or the net. | "First serve was a fault." |
| 18 | Double fault | Two faults in a row, losing the point. | "Double fault on set point, ouch." |
| 19 | Let | A net-cord serve that lands in; replay the serve. | "It was a let, so we replayed it." |
| 20 | Foot fault | The server's foot touches the line or court before contact. | "He got called for a foot fault." |
| 21 | First serve | The first attempt, often the fastest. | "Her first serve was on fire." |
| 22 | Second serve | The safer attempt after a fault. | "I kicked my second serve in." |
| 23 | Flat serve | A hard serve with little spin. | "His flat serve is a rocket." |
| 24 | Slice serve | A serve with sidespin that curves and skids. | "Slice serve out wide." |
| 25 | Kick serve | A topspin serve that bounces high. | "The kick serve jumps up at you." |
| 26 | Return of serve | The first shot back after the serve. | "Returning is the hardest part for me." |
| 27 | Forehand | A stroke hit on your dominant side. | "My forehand is my weapon." |
| 28 | Backhand | A stroke hit on the non-dominant side, one- or two-handed. | "Her one-handed backhand is beautiful." |
| 29 | Topspin | Forward spin that makes the ball dip and bounce high. | "Heavy topspin drives me nuts." |
| 30 | Slice | Backspin that keeps the ball low. | "I slice my backhand when I'm stretched." |
| 31 | Flat | A shot with little spin, hit through the ball. | "He hit it flat and it clipped the tape." |
| 32 | Volley | A shot hit before the ball bounces. | "I poached at the net with a volley." |
| 33 | Half-volley | A volley hit right after the bounce. | "She half-volleyed at her feet." |
| 34 | Overhead | A smash hit above the head. | "Overhead put-away, easy." |
| 35 | Drop shot | A soft shot that dies near the net. | "That drop shot wrong-footed me." |
| 36 | Lob | A high, arcing shot over the net player. | "She lobbed me twice." |
| 37 | Approach shot | A shot hit while moving toward the net. | "I hit an approach and closed in." |
| 38 | Passing shot | A shot that goes past the net player. | "Sweet passing shot down the line." |
| 39 | Tweener | A shot hit between the legs. | "He hit a tweener and got lucky." |
| 40 | Crosscourt | A diagonal shot to the opposite side. | "I keep it crosscourt until I get a short ball." |
| 41 | Down the line | A shot straight along the sideline. | "Winner down the line!" |
| 42 | Inside-out | A forehand from the backhand side to the opposite corner. | "My inside-out forehand is my favourite shot." |
| 43 | Unforced error | A miss with no real pressure from the opponent. | "Too many unforced errors today." |
| 44 | Winner | A shot the opponent cannot reach. | "That was a clean winner." |
| 45 | Rally | An exchange of shots after the serve. | "We had a twenty-shot rally." |
| 46 | Moonball | A very high, loopy topspin shot. | "Her moonballs drive me crazy." |
| 47 | Bagel | A set won 6-0. | "I got bageled in the first set." |
| 48 | Breadstick | A set won 6-1. | "Took the second set as a breadstick." |
| 49 | Seed | A top-ranked player placed in a draw to avoid other top players early. | "She's the number-two seed." |
| 50 | Bye | Advancing a round without playing. | "The top seeds get a bye." |
| 51 | Wild card | A tournament-granted entry. | "He got a wild card into the main draw." |
| 52 | Qualifier | A player who won through qualifying. | "A qualifier just beat the fifth seed." |
| 53 | Lucky loser | A qualifying loser who replaces a withdrawn player. | "A lucky loser reached the quarters." |
| 54 | Slam / major | One of the four biggest tournaments. | "I'd watch a Slam over anything." |
| 55 | Masters 1000 | A big ATP event just below a Slam in points. | "Indian Wells is a Masters 1000." |
| 56 | Tour tier | The class of an event: 250, 500, 1000, Slam. | "That's a 500-level event." |
| 57 | Ranking points | Points earned by results, rolling over 52 weeks. | "He dropped in the rankings after his points came off." |
| 58 | Chair umpire | The official who oversees the match and scores it. | "The chair umpire warned him." |
| 59 | Code violation | A warning for misconduct, then point penalties. | "She got a code violation for smashing the racquet." |
| 60 | Electronic line calling | A system that calls lines with cameras instead of line judges. | "Wimbledon uses electronic line calling now." |
| 61 | Challenge | A player's request to review a call, in systems that allow it. | "She challenged and it was in." |
| 62 | Shot clock | A clock that limits time between points. | "He got a time violation." |
| 63 | Changeover | A short break when players switch ends. | "We sat down at the changeover." |
| 64 | NTRP | The US rating scale for recreational players, 1.0 to 7.0. | "I'm a 3.5 on the NTRP scale." |
| 65 | UTR | Universal Tennis Rating, a numeric rating based on results. | "Her UTR is 8.5." |
| 66 | Hard court | A fast or medium-speed cement or acrylic surface. | "I prefer the hard courts." |
| 67 | Grass | A low, quick surface with skidding bounces. | "Grass rewards big serves." |
| 68 | Clay | A slow surface with high, sliding bounces. | "Clay favours patient players." |

## 4. Talk Track scenarios (8)

Each scenario has the enthusiast's opening line, what it means, three reply styles per exchange (**good**, **meh**, **cringe**) with coach notes, and the payload JSON. Smooth starts at 50; a run is a success at >= 60. Good replies model honest curiosity; cringe replies fake expertise, dunk on the sport or dismiss the person. These are conversation practice, not scripts to impersonate an expert (spec section 13).

### 4.1 After her hit (`tt-rec-recap`)

- **Setting:** Sam texts after a tough hit with a friend.
- **Enthusiast opening:** "We got bageled in the first set, then my first serve came back and we almost stole the second."
- **What it means:** They lost the first set 6-0, then her first serve improved and the second set was close. Terms: bagel, first serve, set.
- **Coach frame:** The score and the serve are the two things she is proud and annoyed about.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ouch, a bagel is brutal. What changed with your first serve?" | +25 | Named the pain and asked one specific question. |
| 1 | meh | "Sorry! What does bageled mean?" | +8 | Honest and fine. Try guessing from context first. |
| 1 | cringe | "Just serve harder next time." | -18 | Advice from nowhere. Ask, do not coach. |
| 2 | good | "Breaking at 4-3 sounds huge. Did the slower serve go in more?" | +25 | You connected the serve to the break. Real interest. |
| 2 | meh | "Nice! Want dinner?" | +3 | Warm, but you skipped a chance to ask about the game. |
| 2 | cringe | "Slow serves are for beginners." | -20 | Never dunk on a tactic. Second serves win matches. |

```json
{
  "title": "After her hit",
  "setting": "Sam texts after a tough hit with a friend.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We got bageled in the first set, then my first serve came back and we almost stole the second.",
      "replies": [
        {
          "id": "good",
          "text": "Ouch, a bagel is brutal. What changed with your first serve?",
          "smoothDelta": 25,
          "theirResponse": "Honestly I slowed it down and got it in. Then I broke her at 4-3.",
          "coachNote": "Named the pain and asked one specific question."
        },
        {
          "id": "meh",
          "text": "Sorry! What does bageled mean?",
          "smoothDelta": 8,
          "theirResponse": "Ha, it means I lost the set 6-0. Rough.",
          "coachNote": "Honest and fine. Try guessing from context first."
        },
        {
          "id": "cringe",
          "text": "Just serve harder next time.",
          "smoothDelta": -18,
          "theirResponse": "Harder is how I miss. Okay.",
          "coachNote": "Advice from nowhere. Ask, do not coach."
        }
      ]
    },
    {
      "theirMessage": "Honestly I slowed it down and got it in. Then I broke her at 4-3.",
      "replies": [
        {
          "id": "good",
          "text": "Breaking at 4-3 sounds huge. Did the slower serve go in more?",
          "smoothDelta": 25,
          "theirResponse": "Yes! A lot more. It felt boring but it worked.",
          "coachNote": "You connected the serve to the break. Real interest."
        },
        {
          "id": "meh",
          "text": "Nice! Want dinner?",
          "smoothDelta": 3,
          "theirResponse": "Ha, yes. But also I want to talk about that serve.",
          "coachNote": "Warm, but you skipped a chance to ask about the game."
        },
        {
          "id": "cringe",
          "text": "Slow serves are for beginners.",
          "smoothDelta": -20,
          "theirResponse": "Wow. That is not the vibe.",
          "coachNote": "Never dunk on a tactic. Second serves win matches."
        }
      ]
    }
  ],
  "closingNote": "A break of serve is winning a game your opponent served. It is the biggest swing in a set."
}
```

### 4.2 The line call (`tt-line-call`)

- **Setting:** Sam is still annoyed after a friendly match.
- **Enthusiast opening:** "They called my serve out and it was on the line!! Lines are IN."
- **What it means:** A ball touching the line is in. She is annoyed at a bad call. Terms: lines are in, line call.
- **Coach frame:** A dispute; the goal is empathy, not being the referee.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ugh, that's frustrating. Was it close or clearly on the line?" | +25 | Empathy first, then a factual question. |
| 1 | meh | "That's annoying. Did you win the match?" | +4 | Friendly, but you skipped the line call. |
| 1 | cringe | "Rules are rules. You probably missed it." | -18 | Never side against her in the heat of a story. |
| 2 | good | "Replaying seems fair. Do you usually just say 'let's replay it'?" | +25 | You showed interest in how club etiquette works. |
| 2 | meh | "Cool, so it's fine now." | +3 | Fine, but 'it's fine' can feel dismissive. |
| 2 | cringe | "Get Hawk-Eye for your club." | -12 | Joking about tech is okay; dismissing the story is not. |

```json
{
  "title": "The line call",
  "setting": "Sam is still annoyed after a friendly match.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They called my serve out and it was on the line!! Lines are IN.",
      "replies": [
        {
          "id": "good",
          "text": "Ugh, that's frustrating. Was it close or clearly on the line?",
          "smoothDelta": 25,
          "theirResponse": "It was right on the line, I saw the chalk jump! We replayed the point.",
          "coachNote": "Empathy first, then a factual question."
        },
        {
          "id": "meh",
          "text": "That's annoying. Did you win the match?",
          "smoothDelta": 4,
          "theirResponse": "We did. But I'm still fuming.",
          "coachNote": "Friendly, but you skipped the line call."
        },
        {
          "id": "cringe",
          "text": "Rules are rules. You probably missed it.",
          "smoothDelta": -18,
          "theirResponse": "Um. I know where the line is.",
          "coachNote": "Never side against her in the heat of a story."
        }
      ]
    },
    {
      "theirMessage": "It was right on the line, I saw the chalk jump! We replayed the point.",
      "replies": [
        {
          "id": "good",
          "text": "Replaying seems fair. Do you usually just say 'let's replay it'?",
          "smoothDelta": 25,
          "theirResponse": "Yeah, when neither of us is sure. Otherwise it's the caller's call.",
          "coachNote": "You showed interest in how club etiquette works."
        },
        {
          "id": "meh",
          "text": "Cool, so it's fine now.",
          "smoothDelta": 3,
          "theirResponse": "Sure. It just stuck with me.",
          "coachNote": "Fine, but 'it's fine' can feel dismissive."
        },
        {
          "id": "cringe",
          "text": "Get Hawk-Eye for your club.",
          "smoothDelta": -12,
          "theirResponse": "It's a Tuesday night hit, not Wimbledon.",
          "coachNote": "Joking about tech is okay; dismissing the story is not."
        }
      ]
    }
  ],
  "closingNote": "In club tennis lines are in, the caller makes the call, and doubt goes to the opponent."
}
```

### 4.3 The new strings (`tt-new-racquet`)

- **Setting:** Sam texts after restringing.
- **Enthusiast opening:** "I restrung with polyester at 52 pounds and my arm hates me."
- **What it means:** Polyester is a stiff string; higher tension means less give and more shock. Terms: polyester, tension.
- **Coach frame:** She may be joking or worried; either way, be kind and curious, not medical.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ouch. Are stiffer strings harder on the arm? Are you thinking of loosening them?" | +25 | Curious and connected the string to the arm. |
| 1 | meh | "Sorry about your arm! What's polyester?" | +8 | Honest ask; guess a bit first. |
| 1 | cringe | "You just need to toughen up." | -20 | Never tell someone to push through pain. |
| 2 | good | "A hybrid sounds like a good compromise. What do you like about polyester?" | +25 | You remembered the term and asked why she likes it. |
| 2 | meh | "Cool. Hope it feels better." | +4 | Kind, if a little short. |
| 2 | cringe | "Buy the most expensive racquet, that fixes everything." | -12 | Gear rarely fixes everything; that sounds like a salesman. |

```json
{
  "title": "The new strings",
  "setting": "Sam texts after restringing.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I restrung with polyester at 52 pounds and my arm hates me.",
      "replies": [
        {
          "id": "good",
          "text": "Ouch. Are stiffer strings harder on the arm? Are you thinking of loosening them?",
          "smoothDelta": 25,
          "theirResponse": "Yes, poly is stiff. Maybe 48 pounds, or a hybrid with softer strings.",
          "coachNote": "Curious and connected the string to the arm."
        },
        {
          "id": "meh",
          "text": "Sorry about your arm! What's polyester?",
          "smoothDelta": 8,
          "theirResponse": "It's a stiff string that gives you control and spin. Lots of players use it.",
          "coachNote": "Honest ask; guess a bit first."
        },
        {
          "id": "cringe",
          "text": "You just need to toughen up.",
          "smoothDelta": -20,
          "theirResponse": "Tough is how arms get hurt. Bye.",
          "coachNote": "Never tell someone to push through pain."
        }
      ]
    },
    {
      "theirMessage": "Yes, poly is stiff. Maybe 48 pounds, or a hybrid with softer strings.",
      "replies": [
        {
          "id": "good",
          "text": "A hybrid sounds like a good compromise. What do you like about polyester?",
          "smoothDelta": 25,
          "theirResponse": "The control and the spin. I just have to tame the arm ache.",
          "coachNote": "You remembered the term and asked why she likes it."
        },
        {
          "id": "meh",
          "text": "Cool. Hope it feels better.",
          "smoothDelta": 4,
          "theirResponse": "Thanks. I'm going to rest it a bit.",
          "coachNote": "Kind, if a little short."
        },
        {
          "id": "cringe",
          "text": "Buy the most expensive racquet, that fixes everything.",
          "smoothDelta": -12,
          "theirResponse": "I wish it were that easy.",
          "coachNote": "Gear rarely fixes everything; that sounds like a salesman."
        }
      ]
    }
  ],
  "closingNote": "Stiffer strings and higher tension can be tougher on the arm; hybrids mix a stiff and a soft string."
}
```

### 4.4 Watching the final (`tt-watch-final`)

- **Setting:** Sam texts during a Slam final.
- **Enthusiast opening:** "It's 6-6 in the fifth and now it's the ten-point breaker. I can't breathe."
- **What it means:** The deciding set reached 6-6, so a ten-point tiebreak decides the match. Terms: deciding set, tiebreak.
- **Coach frame:** Nervous and excited; the tension is the point.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Ten-pointer, first to ten and two clear, right? Who's serving first?" | +25 | You guessed the rule and asked a real question. |
| 1 | meh | "Wow, tense! What's a breaker again?" | +8 | Honest; try recalling the rule first. |
| 1 | cringe | "Why don't they just play until someone wins?" | -15 | Do not argue with the format mid-match. |
| 2 | good | "So it flips every two points. Which player do you want this for?" | +25 | You showed you followed the rule and cared about her side. |
| 2 | meh | "Same, I can't watch." | +4 | Sweet but no new information. |
| 2 | cringe | "It's just tennis, calm down." | -20 | Never minimise her stress. |

```json
{
  "title": "Watching the final",
  "setting": "Sam texts during a Slam final.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "It's 6-6 in the fifth and now it's the ten-point breaker. I can't breathe.",
      "replies": [
        {
          "id": "good",
          "text": "Ten-pointer, first to ten and two clear, right? Who's serving first?",
          "smoothDelta": 25,
          "theirResponse": "Yes! And she's serving first, just one point, then it switches every two.",
          "coachNote": "You guessed the rule and asked a real question."
        },
        {
          "id": "meh",
          "text": "Wow, tense! What's a breaker again?",
          "smoothDelta": 8,
          "theirResponse": "It's a short points game to decide the set. Ten points at the Slams.",
          "coachNote": "Honest; try recalling the rule first."
        },
        {
          "id": "cringe",
          "text": "Why don't they just play until someone wins?",
          "smoothDelta": -15,
          "theirResponse": "Because the schedule and the players' bodies.",
          "coachNote": "Do not argue with the format mid-match."
        }
      ]
    },
    {
      "theirMessage": "Yes! And she's serving first, just one point, then it switches every two.",
      "replies": [
        {
          "id": "good",
          "text": "So it flips every two points. Which player do you want this for?",
          "smoothDelta": 25,
          "theirResponse": "Honestly? The underdog. But my heart is a mess.",
          "coachNote": "You showed you followed the rule and cared about her side."
        },
        {
          "id": "meh",
          "text": "Same, I can't watch.",
          "smoothDelta": 4,
          "theirResponse": "We are a team, watch through your fingers.",
          "coachNote": "Sweet but no new information."
        },
        {
          "id": "cringe",
          "text": "It's just tennis, calm down.",
          "smoothDelta": -20,
          "theirResponse": "Not helping.",
          "coachNote": "Never minimise her stress."
        }
      ]
    }
  ],
  "closingNote": "A ten-point deciding tiebreak: first to ten, two points clear, serve changes every two points after the first."
}
```

### 4.5 Rating talk (`tt-rating`)

- **Setting:** Sam mentions her league rating.
- **Enthusiast opening:** "I'm a 3.5 but I play like a 4.0 on good days."
- **What it means:** NTRP 3.5 is a solid intermediate level; 4.0 is a step up with more consistency and depth. Terms: NTRP, level.
- **Coach frame:** Proud and slightly self-deprecating; she wants to be seen.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "What does a good 4.0 day look like for you?" | +25 | You asked for her experience and not the number. |
| 1 | meh | "That's great! What's NTRP?" | +8 | Fine; try to learn it before the next chat. |
| 1 | cringe | "So are you a sandbagger?" | -18 | Accusing is a cringe reply. |
| 2 | good | "Is consistency the gap between 3.5 and 4.0?" | +25 | You built on her answer. That is following. |
| 2 | meh | "Cool, keep at it." | +4 | Kind but generic. |
| 2 | cringe | "Levels don't matter, it's just tennis." | -15 | Never wave off what she cares about. |

```json
{
  "title": "Rating talk",
  "setting": "Sam mentions her league rating.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I'm a 3.5 but I play like a 4.0 on good days.",
      "replies": [
        {
          "id": "good",
          "text": "What does a good 4.0 day look like for you?",
          "smoothDelta": 25,
          "theirResponse": "Deep crosscourts, fewer errors, and my serve goes in. It's about consistency.",
          "coachNote": "You asked for her experience and not the number."
        },
        {
          "id": "meh",
          "text": "That's great! What's NTRP?",
          "smoothDelta": 8,
          "theirResponse": "It's the US rating scale for rec players, 1.0 to 7.0.",
          "coachNote": "Fine; try to learn it before the next chat."
        },
        {
          "id": "cringe",
          "text": "So are you a sandbagger?",
          "smoothDelta": -18,
          "theirResponse": "Excuse me? I'm being honest.",
          "coachNote": "Accusing is a cringe reply."
        }
      ]
    },
    {
      "theirMessage": "Deep crosscourts, fewer errors, and my serve goes in. It's about consistency.",
      "replies": [
        {
          "id": "good",
          "text": "Is consistency the gap between 3.5 and 4.0?",
          "smoothDelta": 25,
          "theirResponse": "Mostly! At 3.5 I make more errors on the big points.",
          "coachNote": "You built on her answer. That is following."
        },
        {
          "id": "meh",
          "text": "Cool, keep at it.",
          "smoothDelta": 4,
          "theirResponse": "Thanks! I'm trying.",
          "coachNote": "Kind but generic."
        },
        {
          "id": "cringe",
          "text": "Levels don't matter, it's just tennis.",
          "smoothDelta": -15,
          "theirResponse": "They matter to me.",
          "coachNote": "Never wave off what she cares about."
        }
      ]
    }
  ],
  "closingNote": "NTRP levels describe rec players; the gap between neighbouring levels is mostly consistency."
}
```

### 4.6 Favourite Slam (`tt-slam-pick`)

- **Setting:** Sam is picking a Slam to watch.
- **Enthusiast opening:** "Roland-Garros is my favourite. Nobody wins on clay by accident."
- **What it means:** Clay is slow with a high bounce, so points last longer and patience wins. Terms: clay, patience.
- **Coach frame:** She loves the craft of clay-court tennis.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "Why does clay reward patience? Is it the slower ball and the high bounce?" | +25 | You guessed the reason and asked a follow-up. |
| 1 | meh | "Cool. Isn't that in Paris?" | +6 | True and friendly, but shallow. |
| 1 | cringe | "Clay is boring. Nothing happens." | -20 | Never dunk on her favourite. |
| 2 | good | "Do you like watching the sliding too?" | +25 | You noticed a clay detail and asked about it. |
| 2 | meh | "Sure, sounds fun." | +3 | Warm but no new topic. |
| 2 | cringe | "I bet grass is more exciting." | -12 | Do not turn it into a ranking contest. |

```json
{
  "title": "Favourite Slam",
  "setting": "Sam is picking a Slam to watch.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Roland-Garros is my favourite. Nobody wins on clay by accident.",
      "replies": [
        {
          "id": "good",
          "text": "Why does clay reward patience? Is it the slower ball and the high bounce?",
          "smoothDelta": 25,
          "theirResponse": "Exactly. Big hitters can't just blast it. You have to build the point.",
          "coachNote": "You guessed the reason and asked a follow-up."
        },
        {
          "id": "meh",
          "text": "Cool. Isn't that in Paris?",
          "smoothDelta": 6,
          "theirResponse": "Yes! Late May into June.",
          "coachNote": "True and friendly, but shallow."
        },
        {
          "id": "cringe",
          "text": "Clay is boring. Nothing happens.",
          "smoothDelta": -20,
          "theirResponse": "Nothing? I would argue with you for an hour.",
          "coachNote": "Never dunk on her favourite."
        }
      ]
    },
    {
      "theirMessage": "Exactly. Big hitters can't just blast it. You have to build the point.",
      "replies": [
        {
          "id": "good",
          "text": "Do you like watching the sliding too?",
          "smoothDelta": 25,
          "theirResponse": "The sliding is my favourite. It looks like dancing.",
          "coachNote": "You noticed a clay detail and asked about it."
        },
        {
          "id": "meh",
          "text": "Sure, sounds fun.",
          "smoothDelta": 3,
          "theirResponse": "It is!",
          "coachNote": "Warm but no new topic."
        },
        {
          "id": "cringe",
          "text": "I bet grass is more exciting.",
          "smoothDelta": -12,
          "theirResponse": "Different vibe. Let me enjoy my clay.",
          "coachNote": "Do not turn it into a ranking contest."
        }
      ]
    }
  ],
  "closingNote": "Clay is slow and bounces high, so patience and shot tolerance matter; sliding is a clay skill."
}
```

### 4.7 Her player lost (`tt-player-lost`)

- **Setting:** Sam texts after an early exit.
- **Enthusiast opening:** "My favourite lost in round two and I am fuming. Cramping in the fifth set!"
- **What it means:** Her favourite player lost after five sets and physical cramps. Terms: round two, five sets.
- **Coach frame:** She is upset; the ideal reply is empathy, then curiosity.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "That's rough. Was it the heat or the length of the match?" | +25 | Empathy first, then a specific question. |
| 1 | meh | "Sorry! Was it close?" | +6 | Kind, but a bit generic. |
| 1 | cringe | "It's just a game, get over it." | -20 | Never dismiss a fan's feelings. |
| 2 | good | "Do they usually do well in the heat?" | +25 | Curious and forward-looking. |
| 2 | meh | "They'll win next time." | +5 | Encouraging; a small opening was missed. |
| 2 | cringe | "They should have trained harder." | -18 | Never blame the player in front of a fan. |

```json
{
  "title": "Her player lost",
  "setting": "Sam texts after an early exit.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "My favourite lost in round two and I am fuming. Cramping in the fifth set!",
      "replies": [
        {
          "id": "good",
          "text": "That's rough. Was it the heat or the length of the match?",
          "smoothDelta": 25,
          "theirResponse": "Both. Five sets and it was so hot, poor thing.",
          "coachNote": "Empathy first, then a specific question."
        },
        {
          "id": "meh",
          "text": "Sorry! Was it close?",
          "smoothDelta": 6,
          "theirResponse": "It was five sets, so yes.",
          "coachNote": "Kind, but a bit generic."
        },
        {
          "id": "cringe",
          "text": "It's just a game, get over it.",
          "smoothDelta": -20,
          "theirResponse": "Not helpful.",
          "coachNote": "Never dismiss a fan's feelings."
        }
      ]
    },
    {
      "theirMessage": "Both. Five sets and it was so hot, poor thing.",
      "replies": [
        {
          "id": "good",
          "text": "Do they usually do well in the heat?",
          "smoothDelta": 25,
          "theirResponse": "Not really. It's their weak spot, but they'll bounce back.",
          "coachNote": "Curious and forward-looking."
        },
        {
          "id": "meh",
          "text": "They'll win next time.",
          "smoothDelta": 5,
          "theirResponse": "I hope so!",
          "coachNote": "Encouraging; a small opening was missed."
        },
        {
          "id": "cringe",
          "text": "They should have trained harder.",
          "smoothDelta": -18,
          "theirResponse": "That is so harsh.",
          "coachNote": "Never blame the player in front of a fan."
        }
      ]
    }
  ],
  "closingNote": "Long matches in heat are a real test; fans grieve early exits like a friend leaving."
}
```

### 4.8 Come hit with me (`tt-come-hit`)

- **Setting:** Sam invites you to hit.
- **Enthusiast opening:** "You should come hit with me Saturday. Just rallying, no scoring."
- **What it means:** She wants to share the sport gently: no scoring, just hitting. Terms: rally.
- **Coach frame:** An invitation is the point of learning; honesty matters more than looking good.

| Exchange | Reply style | Reply | Smooth | Coach note |
|---|---|---|---|---|
| 1 | good | "I'd love to. I'm a total beginner though; will you show me a forehand?" | +28 | Honest, eager and asked for a teacher. That is charming. |
| 1 | meh | "Maybe. I'm busy." | -5 | You closed a door. Try an honest yes. |
| 1 | cringe | "Sure, I played in college." | -20 | Faking expertise gets exposed fast. |
| 2 | good | "Can you teach me what deuce means when we play a game later?" | +25 | You promised curiosity and planning. |
| 2 | meh | "Sounds good." | +4 | Fine but small. |
| 2 | cringe | "I'll just watch YouTube first so I don't look silly." | -8 | Preparing is fine; hiding is not. |

```json
{
  "title": "Come hit with me",
  "setting": "Sam invites you to hit.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "You should come hit with me Saturday. Just rallying, no scoring.",
      "replies": [
        {
          "id": "good",
          "text": "I'd love to. I'm a total beginner though; will you show me a forehand?",
          "smoothDelta": 28,
          "theirResponse": "Perfect. I'll bring balls. We'll start slow.",
          "coachNote": "Honest, eager and asked for a teacher. That is charming."
        },
        {
          "id": "meh",
          "text": "Maybe. I'm busy.",
          "smoothDelta": -5,
          "theirResponse": "Okay, no worries.",
          "coachNote": "You closed a door. Try an honest yes."
        },
        {
          "id": "cringe",
          "text": "Sure, I played in college.",
          "smoothDelta": -20,
          "theirResponse": "Wait, really? Which team?",
          "coachNote": "Faking expertise gets exposed fast."
        }
      ]
    },
    {
      "theirMessage": "Perfect. I'll bring balls. We'll start slow.",
      "replies": [
        {
          "id": "good",
          "text": "Can you teach me what deuce means when we play a game later?",
          "smoothDelta": 25,
          "theirResponse": "Ha, of course. First you learn to rally.",
          "coachNote": "You promised curiosity and planning."
        },
        {
          "id": "meh",
          "text": "Sounds good.",
          "smoothDelta": 4,
          "theirResponse": "Great. Bring water!",
          "coachNote": "Fine but small."
        },
        {
          "id": "cringe",
          "text": "I'll just watch YouTube first so I don't look silly.",
          "smoothDelta": -8,
          "theirResponse": "You won't look silly. Just come.",
          "coachNote": "Preparing is fine; hiding is not."
        }
      ]
    }
  ],
  "closingNote": "A rally is hitting the ball back and forth, no scoring, the friendliest way to start."
}
```

## 5. Talk Track roster at launch (20)

The eight scenarios above plus twelve to author: post-game recap after a win, first league match nerves, the doubles-partner poaching moment, favourite pro player ({{player}}), a Slam upset, a seed's early exit, tiebreak agony, the rankings-race chat, the Wimbledon whites and traditions moment, the Australian heat chat, a racquet-shopping talk, and "she wants to teach you a serve". Personalized tracks use `{{token}}` substitution with generic fallbacks.

## 6. Asset needs (all `original-swoond`)

| Asset | Used by | Notes |
|---|---|---|
| `tennis-court-top`, `tennis-court-side` diagrams | binary-call, hotspot-tap | Procedural: lines, service boxes, alleys, net |
| `tennis-scoreboard`, `tennis-draw-bracket`, `tennis-doubles-formations` diagrams | hotspot-tap | Procedural |
| `images/tennis/grip-continental.svg` (+ other grips), `racquet-head-sizes.svg`, `surface-clay.svg` (+ grass, hard) | visual-id | Original vector art; alt text describes features without giving away the answer |

No audio assets at launch.

## 7. Voice and safety notes

- Cheeky coach, never mean, one joke per screen, never about the crush.
- Never mock beginners, older players or "tennis people".
- Injury items are generic and always carry a `safetyNote`; no medical claims; never encourage playing through pain or heat illness.
- Rule items cite the concept, not the rulebook text; rules that changed for 2026 (electronic line calling, wearables, video review) are flagged for re-verification before release.
- Line-call and etiquette items teach de-escalation, never confrontation.
