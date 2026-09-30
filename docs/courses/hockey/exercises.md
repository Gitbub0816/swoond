# Hockey: Native Exercise Plan (Tier B)

Companion to `CDS.md` section 12. All sample payloads below validate against `docs/contracts/native-exercises/v1/<type>.schema.json` (checked with the repository validator's ajv setup). Voice: cheeky coach, warm, never about the crush, one joke per screen. Prompts are 12 words or fewer. Every answer is explained. Live facts (cap, season length) are stated as of 2026-27 and must be refreshed each season; do not hard-code scores or standings in static items.

## 1. Types used and volume

| type | lesson activities in the curriculum map | estimated authored items | use in this course |
|---|---|---|---|
| `multiple-choice` | 50 | 250 | Default recall and understanding check; review card. Used for rules, points and structure where one clear fact matters. |
| `binary-call` | 15 | 75 | Every rule in hockey that turns on a yes/no (offside, icing exception, goalie interference, PWHL jailbreak). Static diagram is enough when the call does not need motion; the moving versions are Unity sims. |
| `term-match` | 19 | 95 | Positions, penalties, special teams, analytics terms: 3-6 terms per topic. |
| `sequence-order` | 10 | 50 | Processes with a real order: playoff path, icing consequences, a rush, the prospect pipeline. |
| `visual-id` | 9 | 45 | Referee signals, rink markings, formation diagrams. All images are original procedural illustrations (license `original-swoond`). |
| `decision-scenario` | 14 | 70 | Coaching and management judgment: pulling the goalie, last change, deadline moves, challenges. Judgment over simulation; no safety-critical content. |
| `talk-track` | 18 | 32 | The conversation product: 10+ scenarios (below) plus one per branch and team. |
| `say-this` | 42 | 126 | Decoding fan talk: the main 'what is she talking about?' loop, dominant in enthusiast and live layers. |
| `fill-the-gap` | 12 | 60 | Vocabulary in context and quick review cards. |
| `estimate-slider` | 9 | 45 | Magnitudes that build intuition: game length, cap, season length, rink size. |
| `hotspot-tap` | 5 | 25 | Static rink diagram spatial knowledge: crease, slot, the point, blue line. If players move it is a sim instead. |
| `timing-tap` | 0 | 0 | Not used. The one timing skill (line changes) depends on puck, bench distance and risk in a scene, so it is Unity (`hockey.tactics.line-change-timing.v1`). A bare 1D bar would not teach what to time against. |
| `listening-id` | 0 | 0 | Not used at launch. Hockey audio worth teaching (goal horns, whistle, puck on post) is mostly team-specific or licensed. If added later, use original synthesized audio only (license `original-swoond`). |

Estimated items = activity slots x 5 (say-this x 3, talk-track fixed at 32 scenarios). Team-specific items (`{{team}}`, `{{player}}`) are extra and generated from live data with fallbacks (see `live-data.md`).

## 2. Sample items by type

Each item lists the lesson it would live in. Payloads are complete; assets referenced (`images/hockey/...`, diagram ids) are original illustrations to be produced (see CDS section 14).

### 2.1 `multiple-choice`

**multiple-choice sample 1** (lesson `game-clock-periods`)

```json
{
  "prompt": "How long is a regular NHL period?",
  "options": [
    {
      "id": "a",
      "text": "10 minutes"
    },
    {
      "id": "b",
      "text": "15 minutes"
    },
    {
      "id": "c",
      "text": "20 minutes"
    },
    {
      "id": "d",
      "text": "25 minutes"
    }
  ],
  "correctOptionIds": [
    "c"
  ],
  "explanation": {
    "correct": "Three 20-minute periods make 60 minutes of game clock. The clock stops on every whistle, so the real game takes about two and a half hours.",
    "incorrect": "Each period is 20 minutes, three periods in all. That is a full hour of stop-clock play, stretched to about two and a half hours by whistles and intermissions.",
    "sayThisLine": "Ten minutes left in the third. Still one goal."
  }
}
```

**multiple-choice sample 2** (lesson `pen-minors`)

```json
{
  "prompt": "A player gets a minor penalty. What happens next?",
  "options": [
    {
      "id": "a",
      "text": "He sits two minutes and his team plays a man short"
    },
    {
      "id": "b",
      "text": "He is out for the rest of the game"
    },
    {
      "id": "c",
      "text": "The other team gets a penalty shot"
    },
    {
      "id": "d",
      "text": "Nothing until the period ends"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Two minutes in the box, and his team plays shorthanded. If the other team scores on the power play, the penalty ends early.",
    "incorrect": "A minor is two minutes in the box, not a game ejection. His team plays one skater short, and the other team gets a power play.",
    "sayThisLine": "Two minutes for hooking. Here comes the power play."
  }
}
```

**multiple-choice sample 3** (lesson `comp-points`)

```json
{
  "prompt": "In the NHL, what does a team get for losing in overtime?",
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
      "text": "Two points"
    },
    {
      "id": "d",
      "text": "Half a win"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "An overtime or shootout loss earns one standings point, the so-called loser point. A regulation loss earns none.",
    "incorrect": "The NHL gives one point for losing in overtime or a shootout. A regulation loss earns zero, and any win earns two.",
    "sayThisLine": "They lost in overtime, so at least they got a point."
  }
}
```

**multiple-choice sample 4** (lesson `comp-playoff-format`)

```json
{
  "prompt": "How many teams make the Stanley Cup playoffs?",
  "options": [
    {
      "id": "a",
      "text": "8"
    },
    {
      "id": "b",
      "text": "12"
    },
    {
      "id": "c",
      "text": "16"
    },
    {
      "id": "d",
      "text": "20"
    }
  ],
  "correctOptionIds": [
    "c"
  ],
  "explanation": {
    "correct": "Sixteen teams qualify: eight from each conference, three per division plus two wild cards. It is four best-of-seven rounds to the Cup.",
    "incorrect": "Sixteen of the 32 teams make it, eight per conference. Each round is a best-of-seven.",
    "sayThisLine": "Half the league makes the playoffs. That is a lot of hockey."
  }
}
```

### 2.2 `binary-call`

**binary-call sample 1** (lesson `rules-offside-line`)

```json
{
  "prompt": "Winger's skates are over the blue line. Puck is behind it.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "hockey-rink-neutral-blue-line",
    "markers": [
      {
        "role": "player",
        "x": 0.62,
        "y": 0.4
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.5
      },
      {
        "role": "opponent",
        "x": 0.8,
        "y": 0.55
      }
    ],
    "alt": "Rink view of the neutral zone and the attacking blue line. A winger has both skates past the blue line while the puck is still behind it."
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
    "correct": "Both skates are completely over the blue line before the puck. That is offside, even if he never touches the puck.",
    "incorrect": "If both skates are fully over before the puck crosses, it is offside. What matters is where his skates are, not whether he touches the puck.",
    "sayThisLine": "Both skates were over before the puck. Offside."
  },
  "ruleTag": "Offside"
}
```

**binary-call sample 2** (lesson `rules-icing-exceptions`)

```json
{
  "prompt": "Shorthanded team fires the puck the full length of the ice.",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "hockey-rink-full",
    "markers": [
      {
        "role": "player",
        "x": 0.15,
        "y": 0.5
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.5
      },
      {
        "role": "target",
        "x": 0.95,
        "y": 0.5
      }
    ],
    "alt": "Full rink view. A player near his own goal shoots the puck down the ice past the far goal line. His team is shorthanded."
  },
  "choices": [
    {
      "id": "icing",
      "label": "Icing"
    },
    {
      "id": "noicing",
      "label": "No icing"
    }
  ],
  "correctChoiceId": "noicing",
  "explanation": {
    "correct": "A shorthanded team may ice the puck freely. Otherwise penalty killers could never clear their zone.",
    "incorrect": "Only teams at full strength or on the power play are called for icing. A shorthanded team is allowed to clear the puck the length of the ice.",
    "sayThisLine": "They're shorthanded, so it's not icing."
  },
  "ruleTag": "Icing exception"
}
```

**binary-call sample 3** (lesson `rules-crease-contact`)

```json
{
  "prompt": "An attacker bumps the goalie. The shot goes in.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "hockey-crease",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.62
      },
      {
        "role": "opponent",
        "x": 0.5,
        "y": 0.35
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.75
      }
    ],
    "alt": "Diagram of the crease. An attacker stands in the crease and is touching the goalie as the puck crosses the goal line."
  },
  "choices": [
    {
      "id": "good",
      "label": "Good goal"
    },
    {
      "id": "nogoal",
      "label": "No goal"
    }
  ],
  "correctChoiceId": "nogoal",
  "explanation": {
    "correct": "Contact that keeps the goalie from making the save is goalie interference, so the goal comes off the board. Coaches can challenge it.",
    "incorrect": "When an attacker impairs the goalie's ability to make the save, the goal is disallowed. Standing in the crease alone is not the issue: contact and blocking are.",
    "sayThisLine": "That's goalie interference. No goal."
  },
  "ruleTag": "Goalie interference"
}
```

**binary-call sample 4** (lesson `pwhl-jailbreak`)

```json
{
  "prompt": "PWHL: the shorthanded team scores during a minor penalty.",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "hockey-rink-offensive-zone",
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
      },
      {
        "role": "ball",
        "x": 0.8,
        "y": 0.5
      }
    ],
    "alt": "Offensive zone diagram. The shorthanded team has just scored a goal while a penalty is running."
  },
  "choices": [
    {
      "id": "ends",
      "label": "Penalty ends"
    },
    {
      "id": "continues",
      "label": "Penalty continues"
    }
  ],
  "correctChoiceId": "ends",
  "explanation": {
    "correct": "In the PWHL the jailbreak rule frees the penalized player when a shorthanded goal is scored, so the penalty ends right away.",
    "incorrect": "In the NHL the penalty would run its course. In the PWHL a shorthanded goal releases the penalized player, the jailbreak rule.",
    "sayThisLine": "That's the jailbreak rule. The penalty ends."
  },
  "ruleTag": "PWHL jailbreak"
}
```

### 2.3 `term-match`

**term-match sample 1** (lesson `roles-forwards`)

```json
{
  "prompt": "Match the position to its job.",
  "pairs": [
    {
      "id": "c",
      "term": "Center",
      "definition": "Takes faceoffs and covers the most ice"
    },
    {
      "id": "w",
      "term": "Winger",
      "definition": "Works the boards and finishes chances"
    },
    {
      "id": "d",
      "term": "Defenseman",
      "definition": "Breaks up the rush and shoots from the point"
    },
    {
      "id": "g",
      "term": "Goaltender",
      "definition": "Last line of defense; can freeze the puck"
    }
  ],
  "explanation": {
    "summary": "Three forwards attack, two defensemen protect, and one goaltender stops the puck. Centers are the bridge between offense and defense."
  }
}
```

**term-match sample 2** (lesson `pen-stick-infractions`)

```json
{
  "prompt": "Match each penalty to what it means.",
  "pairs": [
    {
      "id": "h",
      "term": "Hooking",
      "definition": "Using the stick to hold back a player"
    },
    {
      "id": "s",
      "term": "Slashing",
      "definition": "Swinging the stick at an opponent"
    },
    {
      "id": "t",
      "term": "Tripping",
      "definition": "Bringing a player down with the stick or leg"
    },
    {
      "id": "hs",
      "term": "High-sticking",
      "definition": "Stick above the shoulders hits a player"
    }
  ],
  "explanation": {
    "summary": "All four are stick fouls and all four are minors unless blood is drawn or the play is dangerous. Know these and you can follow most power plays."
  }
}
```

**term-match sample 3** (lesson `pen-power-play`)

```json
{
  "prompt": "Match the special-teams term.",
  "pairs": [
    {
      "id": "pp",
      "term": "Power play",
      "definition": "Team with the man advantage"
    },
    {
      "id": "pk",
      "term": "Penalty kill",
      "definition": "Shorthanded team defending"
    },
    {
      "id": "sh",
      "term": "Shorthanded goal",
      "definition": "Goal scored while a man down"
    },
    {
      "id": "53",
      "term": "Five-on-three",
      "definition": "Two penalties on one team at once"
    }
  ],
  "distractorDefinitions": [
    "A penalty served by the coach"
  ],
  "explanation": {
    "summary": "Special teams decide close games: the power play tries to score, the penalty kill tries to survive, and a shorthanded goal is a big swing.",
    "sayThisLine": "Their penalty kill was perfect tonight."
  }
}
```

**term-match sample 4** (lesson `num-corsi`)

```json
{
  "prompt": "Match the analytics term.",
  "pairs": [
    {
      "id": "corsi",
      "term": "Corsi",
      "definition": "Shot attempts for versus against"
    },
    {
      "id": "xg",
      "term": "Expected goals",
      "definition": "Goals a team should score from shot quality"
    },
    {
      "id": "pdo",
      "term": "PDO",
      "definition": "Shooting plus save percentage, often luck"
    },
    {
      "id": "toi",
      "term": "Time on ice",
      "definition": "Minutes a player skates per game"
    }
  ],
  "explanation": {
    "summary": "Corsi counts volume, xG counts quality, PDO checks luck and TOI shows trust. Use them to ask better questions, not to win arguments."
  }
}
```

### 2.4 `sequence-order`

**sequence-order sample 1** (lesson `comp-playoff-format`)

```json
{
  "prompt": "Put the playoff path in order.",
  "items": [
    {
      "id": "r1",
      "text": "First round",
      "why": "Sixteen teams, eight series, best-of-seven."
    },
    {
      "id": "r2",
      "text": "Second round",
      "why": "Eight teams left."
    },
    {
      "id": "cf",
      "text": "Conference final",
      "why": "The winners of each conference are decided."
    },
    {
      "id": "scf",
      "text": "Stanley Cup Final",
      "why": "East champion versus West champion."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Four rounds, each best-of-seven, and the last team standing gets the Cup.",
    "incorrect": "It runs first round, second round, conference final, then the Stanley Cup Final.",
    "sayThisLine": "They are two rounds from the Cup."
  }
}
```

**sequence-order sample 2** (lesson `game-stoppages`)

```json
{
  "prompt": "What happens after icing is called? Put it in order.",
  "items": [
    {
      "id": "whistle",
      "text": "Linesman blows the play dead",
      "why": "Icing is called when the race is judged."
    },
    {
      "id": "faceoff",
      "text": "Faceoff in the offending team's zone",
      "why": "The team that iced has to defend the draw."
    },
    {
      "id": "nochange",
      "text": "Offending team cannot change lines",
      "why": "Tired players stay on the ice."
    },
    {
      "id": "resume",
      "text": "Play resumes after the draw",
      "why": "The puck is dropped and the clock runs."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "That's the cost of icing: no change, a defensive faceoff and tired legs.",
    "incorrect": "The order is whistle, faceoff in the offender's end, no change, then play resumes."
  }
}
```

**sequence-order sample 3** (lesson `tac-rush-basics`)

```json
{
  "prompt": "Order a successful rush.",
  "items": [
    {
      "id": "win",
      "text": "Win the puck in your zone"
    },
    {
      "id": "breakout",
      "text": "Breakout pass up the ice",
      "why": "A clean first pass beats forechecking pressure."
    },
    {
      "id": "cross",
      "text": "Cross the red line with speed"
    },
    {
      "id": "entry",
      "text": "Carry the puck over the blue line"
    },
    {
      "id": "shot",
      "text": "Shoot from the slot",
      "why": "Shots from there score most often."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Win it, break out, cross, enter, shoot: that is a rush in five steps.",
    "incorrect": "A rush starts with possession, then a breakout, crossing center, carrying in, and finally the shot."
  }
}
```

**sequence-order sample 4** (lesson `num-draft-lottery`)

```json
{
  "prompt": "Order a typical path to the NHL.",
  "items": [
    {
      "id": "junior",
      "text": "Junior or college hockey",
      "why": "Most prospects develop here at 16-21."
    },
    {
      "id": "draft",
      "text": "NHL Draft",
      "why": "The team owns the player's rights."
    },
    {
      "id": "eltc",
      "text": "Entry-level contract",
      "why": "A short, capped first deal."
    },
    {
      "id": "ahl",
      "text": "AHL development",
      "why": "The minor-league level below the NHL."
    },
    {
      "id": "nhl",
      "text": "NHL call-up",
      "why": "He plays in the big league."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Play, get drafted, sign, develop, then get the call.",
    "incorrect": "The usual path is junior or college, the draft, a contract, the AHL, then the NHL."
  }
}
```

### 2.5 `visual-id`

**visual-id sample 1** (lesson `game-rink-tour`)

```json
{
  "prompt": "Which part of the ice is highlighted?",
  "image": {
    "asset": "images/hockey/rink-crease-highlight.svg",
    "alt": "Overhead diagram of a hockey goal with a blue semicircle in front of the net highlighted.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "The crease"
    },
    {
      "id": "b",
      "text": "The faceoff circle"
    },
    {
      "id": "c",
      "text": "The penalty box"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "That blue half-circle is the crease: the goalie's space. Attackers standing in it can wipe out a goal.",
    "incorrect": "The highlighted blue area right in front of the net is the crease, the goalie's space."
  },
  "cues": [
    "Blue paint",
    "Directly in front of the net"
  ]
}
```

**visual-id sample 2** (lesson `tac-pp-formations`)

```json
{
  "prompt": "Which power play formation is this?",
  "image": {
    "asset": "images/hockey/pp-131.svg",
    "alt": "Overhead diagram of five attackers: one at the top, three across the middle, one at the goal.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "1-3-1"
    },
    {
      "id": "b",
      "text": "Umbrella"
    },
    {
      "id": "c",
      "text": "Box"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "One at the point, three in a line across the slot and one at the net: 1-3-1. The bumper in the middle is the seam pass.",
    "incorrect": "Look at the line of three across the slot with one above and one below: that is a 1-3-1."
  },
  "cues": [
    "One player high",
    "Three across",
    "One at the net"
  ]
}
```

**visual-id sample 3** (lesson `pen-minors`)

```json
{
  "prompt": "Which penalty is the referee signaling?",
  "image": {
    "asset": "images/hockey/ref-signal-hooking.svg",
    "alt": "Referee drawn making a tugging motion with both forearms in front of his chest.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Hooking"
    },
    {
      "id": "b",
      "text": "Tripping"
    },
    {
      "id": "c",
      "text": "Slashing"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "The tugging motion with both arms is the referee signal for hooking.",
    "incorrect": "Hooking looks like a tugging motion across the chest. Tripping is a leg kick; slashing is a chopping motion."
  },
  "cues": [
    "Arms tugging toward chest"
  ]
}
```

### 2.6 `decision-scenario`

**decision-scenario sample 1** (lesson `game-pull-goalie`)

```json
{
  "prompt": "You're down a goal late. When do you pull the goalie?",
  "situation": {
    "narrative": "You coach a team trailing 2-3 in the third period.",
    "facts": [
      {
        "label": "Score",
        "value": "Trailing 2-3"
      },
      {
        "label": "Time left",
        "value": "2:10"
      },
      {
        "label": "Faceoff",
        "value": "In the offensive zone"
      },
      {
        "label": "Timeout",
        "value": "Available"
      }
    ]
  },
  "options": [
    {
      "id": "now",
      "label": "Pull him at this faceoff",
      "verdict": "best",
      "consequence": "You start six-on-five with the draw in their zone. If you lose it, the empty net is a risk, but the odds of a tie improve.",
      "considerations": [
        "Extra attacker",
        "Faceoff in the offensive zone"
      ]
    },
    {
      "id": "one-minute",
      "label": "Wait until one minute is left",
      "verdict": "acceptable",
      "consequence": "This is the traditional choice and less risky, but you give yourself less time to score.",
      "considerations": [
        "Tradition",
        "Less time"
      ]
    },
    {
      "id": "never",
      "label": "Keep him in",
      "verdict": "poor",
      "consequence": "You don't take a risk, and a one-goal deficit rarely disappears by itself.",
      "considerations": [
        "No extra attacker"
      ]
    }
  ],
  "expertNote": "Analytics suggest pulling earlier than tradition, with a faceoff in the offensive zone. Many coaches still wait until about a minute left.",
  "sayThisLine": "They pulled the goalie early and it worked."
}
```

**decision-scenario sample 2** (lesson `eye-last-change`)

```json
{
  "prompt": "Home coach with last change. Their top line is out.",
  "situation": {
    "narrative": "You are the home coach at a faceoff in your zone.",
    "facts": [
      {
        "label": "Faceoff",
        "value": "Your defensive zone"
      },
      {
        "label": "Their line",
        "value": "Top scoring line"
      },
      {
        "label": "Your options",
        "value": "Shutdown line or scoring line"
      },
      {
        "label": "Score",
        "value": "Tied 1-1, second period"
      }
    ]
  },
  "options": [
    {
      "id": "shutdown",
      "label": "Send your shutdown line",
      "verdict": "best",
      "consequence": "Your best defenders take the matchup and neutralize their top players.",
      "considerations": [
        "Last change",
        "Defensive zone faceoff"
      ]
    },
    {
      "id": "scoring",
      "label": "Send your top scoring line",
      "verdict": "acceptable",
      "consequence": "You could trade chances, but you risk giving up a goal.",
      "considerations": [
        "Offense first"
      ]
    },
    {
      "id": "tired",
      "label": "Leave the tired line out",
      "verdict": "poor",
      "consequence": "They are tired, and a fresh top line can score.",
      "considerations": [
        "Fatigue"
      ]
    }
  ],
  "expertNote": "Last change lets the home coach see who the visitors send, then reply.",
  "sayThisLine": "He has last change, so he can match his line against them."
}
```

**decision-scenario sample 3** (lesson `live-deadline`)

```json
{
  "prompt": "Trade deadline: your favorite team is two points out.",
  "situation": {
    "narrative": "A contender is deciding whether to buy.",
    "facts": [
      {
        "label": "Standings",
        "value": "2 points behind a wild card"
      },
      {
        "label": "Cap space",
        "value": "$2.1 million",
        "emphasis": "warning"
      },
      {
        "label": "Injuries",
        "value": "Top defenseman out long-term"
      },
      {
        "label": "Games left",
        "value": "19"
      }
    ]
  },
  "options": [
    {
      "id": "buy",
      "label": "Trade for a defenseman with a rental contract",
      "verdict": "best",
      "consequence": "You address the injury and stay in the race, using the cap space you have.",
      "considerations": [
        "Cap hit fits",
        "Rental means expiring"
      ]
    },
    {
      "id": "stand",
      "label": "Stand pat",
      "verdict": "acceptable",
      "consequence": "You don't hurt the future but you are relying on the team as it is.",
      "considerations": [
        "Risk of missing playoffs"
      ]
    },
    {
      "id": "sell",
      "label": "Sell every veteran",
      "verdict": "poor",
      "consequence": "You give up on a season that is still alive.",
      "considerations": [
        "Race is close"
      ]
    }
  ],
  "expertNote": "Deadline decisions weigh the standings, the cap and how many games remain.",
  "sayThisLine": "They bought at the deadline and got a defenseman."
}
```

### 2.7 `talk-track`

Full talk-track payloads for the scenarios in section 5 are in section 5; three are shown there in JSON. Shape:

### 2.8 `say-this`

**say-this sample 1** (lesson `rev-what-did-she-mean`)

```json
{
  "statement": {
    "speaker": "Sarah",
    "text": "Our power play is a disaster. Zero for fourteen."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "The team has not scored with a man advantage in 14 tries",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The team lost 14 games",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "Special teams are struggling",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "The goalie has 14 shutouts",
      "isCorrect": false
    }
  ],
  "translation": "Every time the other team took a penalty and Sarah's team had the extra skater, it failed to score. Fourteen straight chances.",
  "followUps": [
    {
      "line": "Is it the breakouts or the zone entry?",
      "why": "Shows you know a power play needs to enter the zone first."
    },
    {
      "line": "Do they run a 1-3-1?",
      "why": "Asking about formation shows you know it has shapes."
    }
  ],
  "noFakeExpertNote": "You don't need to know why it is broken. Asking is better than guessing."
}
```

**say-this sample 2** (lesson `goalie-advanced`)

```json
{
  "statement": {
    "speaker": "Sarah",
    "text": "Our goalie is standing on his head tonight."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "The goalie is making very hard saves",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The goalie fell over",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "The team is being outshot",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "The goalie is injured",
      "isCorrect": false
    }
  ],
  "translation": "He's playing brilliantly, probably because the shots against are heavy and he keeps saving them.",
  "followUps": [
    {
      "line": "How many shots has he faced?",
      "why": "Shot counts are the natural next question."
    },
    {
      "line": "Is that a shutout pace?",
      "why": "Shows you know shutouts."
    }
  ]
}
```

**say-this sample 3** (lesson `deb-head-hits`)

```json
{
  "statement": {
    "speaker": "Sarah",
    "text": "That hit was late and to the head. It should be a suspension."
  },
  "question": "What is the debate?",
  "options": [
    {
      "id": "a",
      "text": "Whether the hit was legal and if the league should discipline him",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Whether the referee missed a goal",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "Player safety rules",
      "isCorrect": true
    },
    {
      "id": "d",
      "text": "A trade rumor",
      "isCorrect": false
    },
    {
      "id": "e",
      "text": "The Department of Player Safety may review it",
      "isCorrect": true
    }
  ],
  "translation": "She thinks the hitter arrived after the puck was gone and made head contact. The league's Department of Player Safety can suspend a player.",
  "followUps": [
    {
      "line": "Did they give him a major?",
      "why": "Asking about the on-ice call shows you follow the sequence."
    },
    {
      "line": "Will the league look at it?",
      "why": "Knowing there is a review process is real understanding."
    }
  ],
  "noFakeExpertNote": "Say what you saw and ask what she thinks. Don't pretend to know the rulebook."
}
```

**say-this sample 4** (lesson `live-standings`)

```json
{
  "statement": {
    "speaker": "Sarah",
    "text": "We're a point out of the wild card with a game in hand."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "The team is just outside the last playoff spot",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "They have an extra game left to play against rivals",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "They lost a point in the standings",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "The wild card is a team",
      "isCorrect": false
    }
  ],
  "translation": "They are one point behind the last playoff berth but have played one fewer game, so they could pass it.",
  "followUps": [
    {
      "line": "Who's the game in hand against?",
      "why": "Follows her thread into the schedule."
    }
  ]
}
```

### 2.9 `fill-the-gap`

**fill-the-gap sample 1** (lesson `game-scoring-basics`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "A {{penalty}} penalty lasts {{minutes}} minutes.",
  "gaps": [
    {
      "id": "penalty",
      "options": [
        "minor",
        "major"
      ],
      "correct": "minor"
    },
    {
      "id": "minutes",
      "options": [
        "two",
        "five"
      ],
      "correct": "two"
    }
  ],
  "explanation": {
    "correct": "Minors are two minutes. Majors, like fighting, are five.",
    "incorrect": "A minor is two minutes and a major is five. Two minutes is the one you'll see most.",
    "sayThisLine": "Two minutes for hooking."
  }
}
```

**fill-the-gap sample 2** (lesson `comp-points`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "An NHL overtime loss is worth {{points}} point.",
  "gaps": [
    {
      "id": "points",
      "options": [
        "zero",
        "one",
        "two"
      ],
      "correct": "one"
    }
  ],
  "explanation": {
    "correct": "That's the loser point: it rewards getting to overtime.",
    "incorrect": "A regulation loss is zero, but an overtime or shootout loss earns one point."
  }
}
```

**fill-the-gap sample 3** (lesson `rules-icing-basics`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "The team that {{who}} the puck cannot {{what}} afterwards.",
  "gaps": [
    {
      "id": "who",
      "options": [
        "iced",
        "shot"
      ],
      "correct": "iced"
    },
    {
      "id": "what",
      "options": [
        "shoot",
        "change lines"
      ],
      "correct": "change lines"
    }
  ],
  "explanation": {
    "correct": "The team that iced it stays out with tired legs for the faceoff.",
    "incorrect": "After icing the offending team cannot change lines. That is the price."
  }
}
```

### 2.10 `estimate-slider`

**estimate-slider sample 1** (lesson `num-cap`)

```json
{
  "prompt": "What is the 2026-27 NHL salary cap ceiling?",
  "unit": "$M",
  "min": 60,
  "max": 140,
  "step": 2,
  "correctValue": 104,
  "tolerance": {
    "full": 2,
    "partial": 8
  },
  "explanation": {
    "correct": "The 2026-27 upper limit is $104 million, with a lower limit near $77 million.",
    "incorrect": "The 2026-27 upper limit is $104 million per team. Cap numbers change each year, so check for updates."
  }
}
```

**estimate-slider sample 2** (lesson `game-clock-periods`)

```json
{
  "prompt": "How long is regular-season NHL overtime?",
  "unit": "minutes",
  "min": 0,
  "max": 20,
  "step": 1,
  "correctValue": 5,
  "tolerance": {
    "full": 0,
    "partial": 2
  },
  "explanation": {
    "correct": "Five minutes of 3-on-3, sudden death. After that comes a shootout.",
    "incorrect": "Regular-season overtime is five minutes of three-on-three. Playoff overtime is different: full 20-minute periods."
  }
}
```

**estimate-slider sample 3** (lesson `nhl-structure-84`)

```json
{
  "prompt": "How many games in the 2026-27 NHL season?",
  "unit": "games",
  "min": 60,
  "max": 100,
  "step": 2,
  "correctValue": 84,
  "tolerance": {
    "full": 0,
    "partial": 4
  },
  "explanation": {
    "correct": "84 games, up from 82: two more games against division rivals.",
    "incorrect": "The season is now 84 games, up from 82."
  }
}
```

**estimate-slider sample 4** (lesson `game-rink-tour`)

```json
{
  "prompt": "How long is an NHL rink?",
  "unit": "feet",
  "min": 100,
  "max": 300,
  "step": 10,
  "correctValue": 200,
  "tolerance": {
    "full": 10,
    "partial": 30
  },
  "explanation": {
    "correct": "200 feet long and 85 feet wide. The PWHL uses the same size.",
    "incorrect": "NHL rinks are 200 feet by 85 feet, about the same as the PWHL's."
  }
}
```

### 2.11 `hotspot-tap`

**hotspot-tap sample 1** (lesson `tac-slot-screens`)

```json
{
  "prompt": "Tap the slot.",
  "diagram": {
    "diagramId": "hockey-rink-offensive-zone",
    "aspectRatio": 1.1,
    "alt": "Overhead diagram of the offensive zone with the net, two faceoff circles, the blue line and the area between them."
  },
  "hotspots": [
    {
      "id": "slot",
      "label": "Slot",
      "shape": {
        "kind": "rect",
        "x": 0.32,
        "y": 0.62,
        "w": 0.36,
        "h": 0.22
      }
    },
    {
      "id": "left-circle",
      "label": "Left faceoff circle",
      "shape": {
        "kind": "circle",
        "cx": 0.25,
        "cy": 0.72,
        "r": 0.1
      }
    },
    {
      "id": "point",
      "label": "The point",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.12,
        "r": 0.08
      }
    },
    {
      "id": "boards",
      "label": "Boards",
      "shape": {
        "kind": "rect",
        "x": 0.0,
        "y": 0.0,
        "w": 0.05,
        "h": 1.0
      }
    }
  ],
  "correctHotspotIds": [
    "slot"
  ],
  "explanation": {
    "correct": "The slot is the area between the faceoff circles in front of the net, where most goals are scored.",
    "incorrect": "The slot is the middle area between the circles right in front of the net.",
    "sayThisLine": "He owns the slot."
  }
}
```

**hotspot-tap sample 2** (lesson `roles-defense`)

```json
{
  "prompt": "Tap where defensemen often shoot from.",
  "diagram": {
    "diagramId": "hockey-rink-offensive-zone",
    "aspectRatio": 1.1,
    "alt": "Overhead offensive-zone diagram with several highlighted areas near the net, the circles and the blue line."
  },
  "hotspots": [
    {
      "id": "point",
      "label": "The point",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.12,
        "r": 0.09
      }
    },
    {
      "id": "crease",
      "label": "Crease",
      "shape": {
        "kind": "rect",
        "x": 0.42,
        "y": 0.8,
        "w": 0.16,
        "h": 0.1
      }
    },
    {
      "id": "corner",
      "label": "Corner",
      "shape": {
        "kind": "circle",
        "cx": 0.08,
        "cy": 0.92,
        "r": 0.07
      }
    },
    {
      "id": "slot",
      "label": "Slot",
      "shape": {
        "kind": "rect",
        "x": 0.32,
        "y": 0.62,
        "w": 0.36,
        "h": 0.2
      }
    }
  ],
  "correctHotspotIds": [
    "point"
  ],
  "explanation": {
    "correct": "The point, just inside the blue line, is where defensemen usually shoot from. Forwards screen and tip.",
    "incorrect": "Defensemen shoot from the point, inside the blue line near the boards or the middle.",
    "sayThisLine": "He blasted it from the point."
  }
}
```

**hotspot-tap sample 3** (lesson `game-rink-tour`)

```json
{
  "prompt": "Tap the blue line.",
  "diagram": {
    "diagramId": "hockey-rink-full",
    "aspectRatio": 2.35,
    "alt": "Full rink diagram showing two goals, two blue lines, a red center line and five faceoff circles."
  },
  "hotspots": [
    {
      "id": "blue-left",
      "label": "Left blue line",
      "shape": {
        "kind": "rect",
        "x": 0.28,
        "y": 0.0,
        "w": 0.02,
        "h": 1.0
      }
    },
    {
      "id": "red",
      "label": "Red line",
      "shape": {
        "kind": "rect",
        "x": 0.49,
        "y": 0.0,
        "w": 0.02,
        "h": 1.0
      }
    },
    {
      "id": "goal-line",
      "label": "Goal line",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.0,
        "w": 0.01,
        "h": 1.0
      }
    },
    {
      "id": "center",
      "label": "Center circle",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "blue-left"
  ],
  "explanation": {
    "correct": "The blue lines mark the attacking and defending zones, and decide offside.",
    "incorrect": "The blue lines are the ones that mark the zones and are used for offside. The red line is the center line.",
    "sayThisLine": "Offside is about the blue line."
  }
}
```

## 3. Playbook (glossary)

123 terms; each is a `concepts[]` entry in the curriculum JSON (same ids as the CDS curriculum map). Example lines are what she might say out loud, in her voice.

| conceptId | term | tier | definition | example line (her voice) |
|---|---|---|---|---|
| `rink-layout` | Rink layout | foundations | The ice surface: two goals, two blue lines, a red center line, five faceoff circles and a boards-and-glass perimeter. NHL and PWHL rinks are 200 by 85 feet. | "So the whole game happens inside that rounded rectangle?" |
| `zones` | Offensive, neutral, defensive zone | foundations | The two blue lines split the ice into three zones. Which one you are in depends on which team you are talking about: their attacking zone is your defensive one. | "We spent the whole second period in our own zone." |
| `crease` | Crease | foundations | The light-blue painted area in front of each net. It is the goalie's space; attackers standing in it can wipe out a goal. | "That goal was waved off because he was in the crease." |
| `periods-clock` | Periods and the clock | foundations | Three 20-minute periods of stop-clock play, with intermissions between. The clock stops on every whistle, so a game takes about 2.5 hours. | "Ten minutes left in the third and we're still down one." |
| `faceoff` | Faceoff | foundations | How play starts or restarts: the referee or linesman drops the puck between two centers, who battle for possession. | "He wins every draw, which is why they use him on the penalty kill." |
| `goal-scoring` | Goals, shots and saves | foundations | A goal is when the whole puck crosses the goal line between the posts. A shot on goal is one that would go in if not stopped; a stop is a save. | "He had 38 shots and they still lost 2-1." |
| `assist` | Assist | foundations | Credit given to up to two teammates who touched the puck right before a goal. The last touch is the goal; the two before it are primary and secondary assists. | "He only got a secondary assist, but that pass was the play." |
| `hat-trick` | Hat trick | foundations | Three goals by one player in one game. Fans traditionally throw hats onto the ice. | "Hat trick! Look at the hats!" |
| `shutout` | Shutout | foundations | A game in which a goalie allows no goals for the whole game. | "Third shutout of the month. He is unreal." |
| `line-change` | Line change | foundations | Swapping groups of skaters on the fly while play continues. Shifts are short (about 40 to 50 seconds) because skating hard is exhausting. | "They got caught on a bad change and it was a breakaway." |
| `stoppage` | Stoppages and puck out of play | foundations | Play stops for a goal, penalty, offside, icing, puck over the glass or a covered puck. A faceoff restarts it. Shooting the puck over the glass from your own zone is a delay-of-game penalty. | "Two minutes for putting it over the glass. Rookie mistake." |
| `offside` | Offside | foundations | An attacker may not enter the offensive zone before the puck. It is offside if both of his skates are completely over the leading edge of the blue line before the puck fully crosses. | "It was offside by a skate. They took the goal off the board." |
| `delayed-offside` | Delayed offside and tag-up | foundations | When the defense is not in control, play continues even though an attacker is early. The attackers must clear the zone by touching the blue line, called tagging up, or play is blown dead. | "He tagged up at the line so the play stayed alive." |
| `icing` | Icing | foundations | Shooting the puck from your own side of center ice across the opponent's goal line untouched. Play stops and the faceoff is in the offender's end, and the team cannot change lines. Exceptions: a shorthanded team is not called for icing. | "Icing again, and they can't change. Tired legs." |
| `hybrid-icing` | Hybrid icing | foundations | The NHL version: a linesman blows the whistle as soon as a defender would reach the faceoff dots ahead of the opposing skater. It replaced a race to touch the puck to prevent injuries. Other leagues can differ (for example touch-up icing, where a player must touch the puck), so check which rulebook you are watching. | "Hybrid icing means they don't race to the boards any more." |
| `coaches-challenge` | Coach's challenge and video review | foundations | A coach can challenge a goal for an offside entry, goalie interference or a missed stoppage. A successful challenge wipes out the goal; a failed one costs the coach's team its timeout in the NHL. | "They challenged for offside and lost, so they lost their timeout." |
| `too-many-men` | Too many men on the ice | foundations | A bench minor for having more than five skaters and a goalie in play, caused by a bad line change. It is served without a player being named. | "Too many men. That change was late." |
| `minor-penalty` | Minor penalty | foundations | A two-minute penalty for an infraction such as tripping or hooking. The team plays shorthanded and the other team has a power play. It ends early if the power-play team scores. | "Two minutes for hooking. Here comes the power play." |
| `double-minor` | Double minor | foundations | A four-minute penalty made of two consecutive minors, most often for a high stick that draws blood. A goal ends the first minor, then the second minor begins. | "Double minor for the high stick, so four minutes of power play." |
| `major-penalty` | Major penalty | foundations | A five-minute penalty for serious infractions such as fighting or a dangerous check. It is served in full, even if the other team scores, and some majors come with a game misconduct. | "Five for fighting is the classic major." |
| `power-play` | Power play | foundations | When one team has a man advantage because the other is serving a penalty. A five-on-four is the most common, five-on-three the biggest. | "The power play was 1-for-3 tonight." |
| `penalty-kill` | Penalty kill | foundations | The defensive job of the shorthanded team: clear the puck, block shots and run out the clock on the penalty. | "The penalty kill went perfect: five kills." |
| `shorthanded-goal` | Shorthanded goal | foundations | A goal scored by the team that is down a man. Fans love them because they are unlikely. | "A shorty! On the power play, they scored short-handed." |
| `penalty-shot` | Penalty shot | foundations | One-on-one against the goalie awarded when a player is fouled from behind on a breakaway. No defenders, no time pressure. | "Penalty shot after the clear breakaway trip." |
| `hooking-tripping` | Hooking, slashing, tripping | foundations | The stick-and-body minors. Hooking is using the stick to hold; slashing is swinging at hands or legs; tripping is bringing an opponent down with the stick or a leg. | "Hooking, tripping, slashing: the three you'll see all night." |
| `high-sticking-holding` | Holding, interference and high sticks | foundations | Holding and interference stop a player without the puck. A high stick is when the stick is above the shoulders and hits someone. | "That was clear interference; he didn't have the puck." |
| `cross-check-boarding` | Cross-checking, boarding, charging | foundations | Dangerous body contact minors or majors: hitting with the stick shaft, driving a player into the boards or taking too many strides before a hit. | "Boarding, five and a game. He's out." |
| `game-misconduct` | Misconducts and ejections | foundations | A ten-minute misconduct and a game misconduct send a player off without the team going shorthanded (unless there was a major). Match penalties are ejections for intent to injure. | "Game misconduct, so he's showered." |
| `penalty-nuance` | 4-on-4 and 5-on-3 situations | foundations | If both teams get minors at the same time, it is four-on-four with no power play. Two penalties on one team is a five-on-three: the biggest advantage in the sport. | "They get a 5-on-3 for 90 seconds." |
| `embellishment` | Embellishment (diving) | foundations | A minor for selling a foul that didn't happen. Fans complain about it and refs punish it inconsistently. | "He dove and got called for embellishment." |
| `delay-of-game` | Delay of game | foundations | A minor for deliberately shooting the puck over the glass or displacing the net. | "Delay of game: over the glass from the defensive zone." |
| `center` | Center | foundations | A forward who lines up in the middle, takes faceoffs and covers the most ice. Good centers are both passers and defenders. | "He's a two-way center: he defends as hard as he scores." |
| `winger` | Winger | foundations | A left or right forward who plays along the boards and finishes scoring chances. | "Her wingers set up a perfect one-timer." |
| `defenseman` | Defenseman | foundations | The two blueliners behind the forwards. They break up the rush, move the puck out and often shoot from the point. | "He's a shutdown defenseman: he never gives them a look." |
| `goaltender` | Goaltender | foundations | The last line of defense. The goalie is the only player allowed to freeze the puck and wears protective gear. | "That goalie stole the game." |
| `lines-and-pairs` | Lines and pairs | foundations | Forwards play in lines of three (center and two wingers); defense play in pairs. A team dresses 12 forwards, 6 defensemen and 2 goalies. First line means the best offensive players. | "The third line scored, which is a huge plus for depth." |
| `captain-alternates` | Captain and alternates | foundations | One captain and up to two alternates wear a C or A. The captain speaks to officials for the team. | "The captain wears the C, the alternates wear an A." |
| `enforcer` | Enforcer and grinder | foundations | Slang for players who play physical roles. Enforcers protect star teammates; grinders forecheck and kill penalties. | "He's not a scorer, he's a grinder. That's a compliment." |
| `healthy-scratch` | Healthy scratch | foundations | A player who is fit but not in the lineup that night. | "He was a healthy scratch. The coach wasn't thrilled." |
| `extra-attacker` | Extra attacker (pulling the goalie) | foundations | When a team is losing late, it pulls its goalie for an extra skater. If it works you can tie; if not the other team scores into an empty net. | "They pulled the goalie with two minutes left." |
| `points-system` | Standings points | intermediate | In the NHL a win is two points, an overtime or shootout loss is one, and a regulation loss is zero. That one 'loser point' makes the standings tricky. The PWHL uses a 3-2-1-0 system. | "They lost in overtime so they at least got a point." |
| `overtime-3v3` | 3-on-3 overtime | intermediate | Regular-season overtime is five minutes of three skaters per side, sudden death. The open ice creates fast, chaotic play. | "Three on three is basically a breakaway contest." |
| `shootout` | Shootout | intermediate | If overtime does not settle it, a best-of-three shootout of one-on-one shots decides the game. Not used in the NHL playoffs. | "It went to a shootout and their guy scored." |
| `tiebreakers` | Regulation wins tiebreaker | intermediate | When teams tie on points, the first tiebreaker is regulation wins (RW), then regulation plus overtime wins (ROW). | "They are tied on points but have more regulation wins." |
| `wild-card` | Wild card | intermediate | In the NHL playoff format, the top three teams in each division qualify, plus two wild cards per conference, the next best teams regardless of division. | "They're in a wild-card spot right now." |
| `playoff-format` | Playoff format | intermediate | Sixteen teams make the Stanley Cup playoffs, in four best-of-seven rounds. Wild-card teams face the division winners in round one. There are no shootouts: overtime is 20-minute sudden-death periods. | "Round one is a best-of-seven, so one bad game isn't the end." |
| `stanley-cup` | Stanley Cup | intermediate | The NHL championship trophy. Every winning player's name is engraved on it, and players each get a day with the Cup in the summer. The NHL awards the Presidents' Trophy for the best regular-season record separately. | "They're playing for the Cup." |
| `series-lingo` | Series lingo | intermediate | Game 7 is winner-take-all. Being up 3-1 in the series is a strong lead. Home ice advantage means the team with the better record hosts more games. | "Up three games to one, they can close it out at home." |
| `forecheck` | Forecheck | intermediate | Pressure the opponent in their own zone to force turnovers. Common systems: 1-2-2 (one forward deep, two mid, two defense), 2-1-2 and left-wing lock. | "They forechecked hard and forced the giveaway." |
| `backcheck` | Backcheck | intermediate | Forwards hustling back into their own zone to defend after a turnover. | "He backchecked all the way to break up the two-on-one." |
| `breakout` | Breakout | intermediate | How a team exits its defensive zone: pass up the boards, defense-to-defense reverse, or a wheel behind the net. | "That breakout was clean, they went straight up ice." |
| `neutral-zone-trap` | Neutral-zone trap | intermediate | A passive system that clogs the middle of the ice to force turnovers, popular in the 1990s and 2000s. It slows the game down. | "The trap suffocated their speed." |
| `cycle` | Cycle and dump-and-chase | intermediate | Cycling is passing the puck along the boards in the offensive zone to tire the defense. Dump-and-chase is shooting it deep and chasing it. | "They cycled for a full minute before the shot." |
| `zone-entry` | Zone entry | intermediate | How a team gets the puck into the offensive zone: carry it in (better shots) or dump it in (safer, fewer chances). | "Carry-ins create more chances than dump-ins." |
| `rush` | Rush and odd-man rush | intermediate | A fast attack from the neutral zone. Odd-man rushes are 2-on-1 or 3-on-2, where attackers outnumber defenders. | "They got a two-on-one and buried it." |
| `slot` | Slot and high-danger area | intermediate | The area between the faceoff circles in front of the net, where the best shots come from. Shots from there go in far more often than from the perimeter. | "He owns the slot: that's where scoring happens." |
| `screen-tip` | Screen and tip | intermediate | A screen is a player standing in the goalie's line of sight. A tip redirects a shot; goals come from both. | "The screen made the shot invisible." |
| `one-timer` | One-timer | intermediate | Shooting a pass immediately without stopping it first. Power plays are built around setting one up. | "Set up for the one-timer from the left circle." |
| `point-shot` | The point | intermediate | The spot just inside the offensive blue line where defensemen shoot. Point shots are usually screened or tipped. | "He blasted one from the point and it got tipped in." |
| `pp-formations` | Power play formations | intermediate | Common setups: 1-3-1 (one at the point, three across the middle, one at the net), umbrella (three up top) and overload (numbers on one side). | "The 1-3-1 opens up the bumper." |
| `pk-formations` | Penalty kill formations | intermediate | Box (four players in a square), diamond and aggressive pressure kills. The box protects the slot; aggressive kills go for turnovers. | "They run a box and just block lanes." |
| `gap-control` | Gap control | intermediate | The distance a defender keeps from the puck carrier. Tight gaps stop rushes; loose gaps give room but risk a shot. | "His gap is tight, so nothing gets through." |
| `dzone-coverage` | Defensive-zone coverage | intermediate | How defenders share the D-zone: man-to-man (each player marks someone), zone (each covers an area), or a collapse that packs everyone near the net. | "They collapsed around the net and gave up perimeter shots." |
| `last-change` | Last change and line matching | intermediate | The home team chooses its lines last after the visitors. Coaches use this to get their best matchup, such as a shutdown pair against the opponent's top line. | "He has last change, so he can match his line against them." |
| `goalie-butterfly` | Butterfly | intermediate | The goalie's standard save posture: drop to the knees with pads flared to seal the ice. | "Standard butterfly and he covers the bottom of the net." |
| `goalie-angles` | Angles and depth | intermediate | A goalie stays on the line between puck and net, and adjusts depth outside the crease to cut down the shooter's view. | "He challenged the shooter and cut down the angle." |
| `save-pct` | Save percentage | intermediate | Saves divided by shots. Around .910 is average in the modern NHL and .920 or better is strong. | "He has a .925 save percentage this year." |
| `gaa` | Goals against average | intermediate | Goals allowed per 60 minutes. It depends heavily on the defense in front, which is why many prefer save percentage. | "His GAA is low, but the team shoots a lot in front of him." |
| `rebound` | Rebound | intermediate | A puck that comes off the goalie after a save; dangerous because the shooter can try again. | "He gave up a big rebound and it went in." |
| `goalie-stats-advanced` | Goals saved above expected | intermediate | An advanced goalie stat comparing his saves against what the shot quality would predict. It shows whether a goalie is better than the shots he faced. | "His GSAx says he's stealing games." |
| `goalie-interference` | Goalie interference | intermediate | A goal can be waved off if an attacker contacts the goalie in the crease, or prevents him from making a save. It's the most argued call in hockey. | "It was goalie interference, no goal." |
| `goalie-workload` | Starter and backup | intermediate | A team's starter plays most games; the backup plays back-to-backs. The rest schedule is a common talking point. | "He's the starter but rests on the second night." |
| `corsi` | Corsi and Fenwick | intermediate | Shot-attempt counts: Corsi counts shots, blocks and misses; Fenwick excludes blocks. A team above 50 percent has more of the puck. | "They have 55 percent of the Corsi, so they're dominating." |
| `expected-goals` | Expected goals (xG) | intermediate | A model that assigns each shot a chance of scoring based on location and type. The total says how many goals a team should have scored. | "They had way more expected goals, but the goalie stopped everything." |
| `pdo` | PDO | intermediate | Shooting percentage plus save percentage. It tends to drift toward 100, so a high PDO is often luck. | "Their PDO is 104, so the good run is probably luck." |
| `toi` | Time on ice | intermediate | How many minutes a player plays. Star defensemen play 25 or more; fourth-liners far fewer. | "He plays 24 minutes a night; the coach trusts him." |
| `plus-minus` | Plus-minus | intermediate | Goals for minus goals against when a player is on the ice at even strength. It is noisy. | "He's plus-18 but that's team-driven." |
| `special-teams-pct` | Power play and penalty kill percentages | intermediate | Goals divided by power plays, and kills divided by penalties. Around 20 percent is average for the power play and 80 percent for the kill. | "Their power play is 26 percent, best in the league." |
| `faceoff-pct` | Faceoff percentage | intermediate | The share of draws a center wins. It matters on the penalty kill and late in games. | "He wins 58 percent of his draws." |
| `salary-cap` | Salary cap | intermediate | A hard limit on team payroll set by the league and the players' union. For 2026-27 the upper limit is $104 million. | "They have no cap space this summer." |
| `cap-hit` | Cap hit | intermediate | The average annual value of a contract, counted against the cap each year. | "His cap hit is $8 million." |
| `ltir` | Long-term injured reserve | intermediate | A roster tool that lets a team exceed the cap to replace a player who will miss long term. | "They used LTIR to add a big contract." |
| `waivers` | Waivers | intermediate | A process where other teams can claim a player before he is sent to the minors. | "He cleared waivers and went to the AHL." |
| `draft` | NHL Draft | intermediate | Annual event where teams select 18-year-old prospects. A lottery decides the top picks among non-playoff teams. | "They won the lottery and moved up to pick first." |
| `free-agency` | Free agency and trades | intermediate | On July 1 unrestricted free agents can sign anywhere. Trades are allowed until the deadline in March. | "July 1 is like hockey Christmas." |
| `contract-terms` | Contract terms | intermediate | Entry-level contracts for young players, RFA versus UFA status, no-trade clauses, buyouts and retained salary. | "He has a no-trade clause, so he has to approve any deal." |
| `prospect-pipeline` | Prospect pipeline | intermediate | Players develop in junior leagues (CHL), college (NCAA), Europe, and the AHL before reaching the NHL. | "She played college hockey before the pros." |
| `fighting-debate` | The fighting debate | enthusiast | Fans argue whether fighting belongs in hockey. The NHL allows five-minute majors; the PWHL and international hockey treat it as something to punish, not accept. Fights have declined sharply. | "Fighting is down every year. Fans are split." |
| `loser-point` | The loser point debate | enthusiast | Critics say giving a point for losing in overtime distorts standings. Supporters say it rewards close games. | "The loser point makes standings weird." |
| `ot-format-debate` | Overtime and shootout debate | enthusiast | Should 3-on-3 be extended? Should shootouts exist? Many enthusiasts think the shootout is a gimmick and 3-on-3 is best. | "Just play more overtime, skip the shootout." |
| `analytics-eye-test` | Analytics versus the eye test | enthusiast | Data lovers say numbers reveal hidden truths; traditionalists say watching shows things numbers miss. Smart fans use both. | "The numbers say he's good but I don't see it." |
| `head-hits` | Hits and head contact | enthusiast | Debate on where hitting ends and dangerous play begins, and how the league disciplines through the Department of Player Safety. | "That hit was late and to the head." |
| `goalie-pull-debate` | When to pull the goalie | enthusiast | Data suggests coaches pull earlier than tradition; many still wait until about a minute left. | "The coach waited too long to pull him." |
| `tanking` | Tanking and the lottery | enthusiast | Accusations that a team loses on purpose for a better draft pick. The lottery reduces the incentive. | "They tanked for a top pick." |
| `all-star-format` | All-Star and rivalry events | enthusiast | Outdoor games, the All-Star Game and skills competitions: how fans value them. | "The Winter Classic is a hockey holiday." |
| `original-six` | Original Six | enthusiast | The six teams of the pre-1967 NHL: Bruins, Blackhawks, Red Wings, Canadiens, Rangers and Maple Leafs. | "That's an Original Six matchup." |
| `expansion-history` | Expansion and Sun Belt hockey | enthusiast | The league grew from six teams to 32, including markets like Vegas, Seattle and Utah. | "Vegas won the Cup in only its sixth season." |
| `legends` | Eras and legends | enthusiast | Gretzky, Orr, Lemieux, Howe, Crosby, Ovechkin. Debates over eras: 'dead puck' versus high-scoring. | "Gretzky's records will never be touched." |
| `miracle` | Miracle on Ice and iconic moments | enthusiast | The 1980 U.S. Olympic upset of the Soviet Union, the Golden Goal in 2010, the 2026 U.S. gold medals. | "The Miracle changed hockey in America." |
| `rivalries` | Rivalries | enthusiast | Bruins-Canadiens, Leafs-Canadiens, Oilers-Flames (Battle of Alberta), Penguins-Capitals. History gives games extra heat. | "It's Battle of Alberta night." |
| `traditions` | Rink traditions | enthusiast | Hat throwing, playoff beards, octopus on the ice in Detroit, goal horns and songs, the Zamboni, the Cup ceremony. | "He grew the playoff beard for luck." |
| `hockey-slang` | Hockey slang | enthusiast | Biscuit is the puck, dangle is a stickhandling move, sauce is a saucer pass, bar down is a shot off the crossbar and in, and chirping is trash talk. | "He dangled the defender and buried it bar down." |
| `chirping` | Chirping and etiquette | enthusiast | Players talk trash to each other; there are unwritten rules about respect, handshake lines and celebrations. | "The handshake line after a series is a tradition." |
| `nhl-structure` | NHL structure | enthusiast | Two conferences and four divisions: Atlantic, Metropolitan, Central and Pacific. Teams play divisional opponents most often. | "They are in the Metropolitan division." |
| `season-84` | The 84-game season | enthusiast | Starting in 2026-27, each team plays 84 games, with two extra divisional games, and a shorter preseason. | "It's an 84-game season now." |
| `new-rules-26` | 2026-27 rule changes | enthusiast | Neck protection is required for players with no prior NHL games, dedicated emergency backup goalies must travel with clubs, and contract limits change under the new CBA. | "Rookies have to wear neck guards now." |
| `team-identity` | Team identity | enthusiast | What makes each club distinct: history, colors, style of play and its city. | "That team plays a heavy game." |
| `player-profile` | Player profile | enthusiast | How to talk about a specific player: role, strengths, stats and storylines. | "He's a sniper on the first line." |
| `pwhl-basics` | PWHL basics | enthusiast | The Professional Women's Hockey League began in 2024. For 2026-27 it has 12 teams, including new Detroit, Hamilton, Las Vegas and San Jose clubs. | "The PWHL has twelve teams now." |
| `pwhl-rules` | PWHL rules differences | enthusiast | Full cages are mandatory, a 3-2-1-0 points system, fighting that is punished, a best-of-five shootout and the jailbreak rule where a short-handed goal ends the penalty. | "The jailbreak rule frees a penalty on a shorthanded goal." |
| `pwhl-playoffs` | Walter Cup | enthusiast | The PWHL's championship trophy. In 2026 the Montreal Victoire won it. | "Victoire took the Walter Cup." |
| `pwhl-culture` | PWHL culture and history | enthusiast | The league grew from the CWHL and PWHPA eras, and fans value its atmosphere and player connection. | "The PWHL crowds are loud." |
| `iihf-rules` | International rules | enthusiast | International (IIHF) rules differ from the NHL in details such as ice size, intermissions and shootout procedure. | "International hockey has slightly different rules." |
| `olympics-hockey` | Olympic hockey | enthusiast | The Olympic tournament, with both men and women's events. In 2026 the U.S. won both golds in overtime. | "The gold medal games went to overtime." |
| `worlds-juniors` | Worlds and World Juniors | enthusiast | The IIHF Worlds and the U20 World Junior Championship, a holiday tradition. | "World Juniors is a holiday tradition." |
| `best-on-best` | Best-on-best tournaments | enthusiast | Events like the 4 Nations Face-Off and Olympic NHL participation, where each country sends top players. | "Best on best means everyone shows up." |
| `this-week` | This week's storylines | current-season | Learning what is happening now: streaks, injuries, trades and milestones. | "What's the big story this week?" |
| `season-calendar` | Season calendar | current-season | Preseason, October start, deadline, playoffs, draft, free agency: each period has its own talk. | "It's trade deadline season." |
| `playoff-race` | Playoff race | current-season | Who is in, who is out, and what the tiebreakers mean. | "They need to win out to make it." |
| `game-companion` | Watching live | current-season | Following a live game: the score, the clock, penalties and strategy. | "It's tied late; they'll pull the goalie." |
| `conversation-starters` | Conversation starters | conversation | Asking questions that show you care: about her team, her favorite player, her memories. | "What got you into hockey?" |
| `follow-up-questions` | Follow-up questions | conversation | A question that builds on what she just said, showing you actually listened. | "Was that the power play unit?" |
| `honest-curiosity` | Honest curiosity | conversation | Saying you don't know but want to learn is a strength, not a weakness. | "I'm still learning. Explain that to me." |

## 4. Talk Track scenarios

11 scenarios for the Talk tab and conversation lessons. Each has two exchanges. Replies are good (+25/+30), meh (+5/+8) or cringe (-5 to -20); start at Smooth 50; success is >= 60. The coach note teaches; nothing is canned expertise.

### Overtime heartbreak (`overtime-heartbreak`)

*Setting:* She texts after her team loses in overtime.

**Exchange 1.** She says: "Lost in OT again. At least we got the point."

*What it means:* Her team lost after regulation ended tied, but earned one standings point for reaching overtime.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | A point is something. Was it 3-on-3 or a shootout? | +25 | 3-on-3. They scored with 40 seconds left. Brutal. | You knew overtime has formats and asked about it. |
| meh | Sorry. Better luck next time. | +5 | Thanks. It stings. | Kind, but it gives her nothing to talk about. |
| cringe | A loss is a loss. Points don't matter. | -15 | They do when it's the wild-card race. | Don't dismiss the standings; they matter to her. |

**Exchange 2.** She says: "The goalie kept us in it. Forty-one saves."

*What it means:* A goalie who saves a lot of shots kept his team in the game; forty-one is a big number.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Forty-one saves. Were they outshooting you? | +25 | Two to one, yeah. He was the only reason it was close. | A natural follow-up: shots against explain the saves. |
| meh | Wow, that's a lot. | +8 | Yeah, he deserved better. | Agreeable but flat. |
| cringe | Guess the defense didn't do much then. | -15 | ...they did their best. Not helpful. | Don't blame her team; be curious. |

*Closing note:* An overtime loss earns one point in the NHL. Ask about the format and the goalie.

### The power play is broken (`power-play-broken`)

*Setting:* She vents during the second intermission.

**Exchange 1.** She says: "Zero for fourteen on the power play. I can't watch."

*What it means:* Her team has not scored in 14 chances with a man advantage.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Zero for fourteen. Is it the zone entry or the setup? | +30 | Both! They can't even get in cleanly. | You know a power play starts with getting into the zone. |
| meh | That's rough. | +5 | It really is. | Warm, but stops the conversation. |
| cringe | What's a power play again? | -20 | Oh, it's... when the other team is in the penalty box. | Fine to ask once, but she just told you the number; ask about that instead. |

**Exchange 2.** She says: "Their penalty kill is elite though."

*What it means:* The opposing team is very good at defending when shorthanded.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Do they run a box or press high? | +25 | Mostly a box. They just block everything. | A formation question shows you know shapes. |
| meh | Maybe you'll score next time. | +5 | I hope so. | Optimistic, no new information. |
| cringe | Just shoot more, it's simple. | -15 | Ha, if only. | Avoid simple advice; she's seen it all. |

*Closing note:* Power play versus penalty kill. Formations are a great question.

### Robbed by the review (`goalie-interference`)

*Setting:* She texts about a disallowed goal.

**Exchange 1.** She says: "They waved off our goal for goalie interference. Robbed!"

*What it means:* A goal was taken back because an attacker impaired the goalie.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Was it contact in the crease? Did the coach challenge it? | +30 | Yes! Their guy was shoved into the goalie. We challenged and lost. | You know coaches can challenge and it costs a timeout. |
| meh | That's a bad call. | +5 | Right? | Agreeing is safe but empty. |
| cringe | Referees are the worst. | -10 | Ha. Well. | Blaming refs gets old fast. |

**Exchange 2.** She says: "And now we lost our timeout too."

*What it means:* The challenge failed, so her team lost its timeout.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Ouch, that's the cost of a failed challenge. | +25 | Exactly. Now we can't use it for the last minute. | You showed you know the penalty for a failed challenge. |
| meh | That's unlucky. | +5 | Yeah. | Correct sentiment, no knowledge. |
| cringe | Why did they challenge then? | -10 | Because we thought we'd win. | Question with an edge; sounds accusing. |

*Closing note:* Goalie interference is the most argued call. A failed challenge costs a timeout.

### Game seven eve (`game-seven`)

*Setting:* The night before a playoff decider.

**Exchange 1.** She says: "Game 7 tomorrow. I won't sleep."

*What it means:* A best-of-seven series is tied 3-3, and the winner advances tomorrow.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Winner takes all. Do you get home ice? | +25 | We do! Thank God. | You understand home ice in a deciding game. |
| meh | Good luck! | +8 | Thank you. | Nice, but generic. |
| cringe | Why not just play one game? | -15 | That's... not how playoffs work. | The best-of-seven structure is a basic thing to know. |

**Exchange 2.** She says: "If we get through, it's the conference final."

*What it means:* The winner of this series moves to the third round.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Third round already. Who would you play? | +25 | Probably Carolina. Ugh. | You counted the rounds. |
| meh | Fingers crossed. | +5 | Yes. | Sweet, no follow-up. |
| cringe | Is that before the Cup? | -5 | Yes, one round before the Final. | It's fine to ask, but the answer was in her sentence. |

*Closing note:* Best-of-seven, Game 7, home ice, and the conference final.

### Too many men (`too-many-men`)

*Setting:* During a game, she texts a groan.

**Exchange 1.** She says: "Too many men on the ice. In overtime!"

*What it means:* A team made a bad line change and got a bench minor at a critical moment.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Bench minor in OT? That's a gift for the power play. | +25 | Right? They scored ten seconds later. | You know it's a two-minute penalty and a power play. |
| meh | How do you get that penalty? | +8 | Bad change. Someone hopped the boards too early. | Honest curiosity works, but explain it first. |
| cringe | They only had five guys out, right? | -15 | No. Six. That's the point. | You missed the meaning of too many men. |

**Exchange 2.** She says: "We've been so sloppy on changes lately."

*What it means:* Her team keeps making line-change mistakes.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Long change in the second? That's the hard one. | +25 | Yes! The bench is so far away. | You know about the long change in the second period. |
| meh | Maybe the coach will fix it. | +5 | He better. | Neutral. |
| cringe | Just don't change lines then. | -20 | ...you can't play 60 minutes without changing. | Skaters need fresh legs; that's the point. |

*Closing note:* A bench minor for too many men. Long change is the second-period detail.

### Deadline day (`trade-deadline`)

*Setting:* She reacts to a trade.

**Exchange 1.** She says: "They traded our second-line center for a rental and a pick."

*What it means:* Her team sold a good player for a temporary player with an expiring contract and a draft pick.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | A rental? Is the new guy an unrestricted free agent? | +25 | Yes, he'll be gone in July. | You know rentals have expiring contracts. |
| meh | Sorry, that stinks. | +5 | It does. | Kind but not curious. |
| cringe | Who cares, the draft is boring. | -15 | ...prospects matter, okay. | Don't dismiss what she values. |

**Exchange 2.** She says: "They said cap space was the reason."

*What it means:* The team needed cap flexibility.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | So the cap hit was the problem? | +25 | His cap hit was huge, yeah. | You link cap hit to roster decisions. |
| meh | Cap is complicated. | +5 | Tell me about it. | True but empty. |
| cringe | Just spend more money. | -20 | There's a hard cap. | Hockey has a hard cap; know that. |

*Closing note:* Rentals are expiring contracts; cap hit is the yearly cost.

### Hat trick night (`hat-trick`)

*Setting:* She sends caps and emoji-free excitement.

**Exchange 1.** She says: "He got a hat trick and the hats rained down!"

*What it means:* One player scored three goals and fans threw hats onto the ice.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Three goals in one game. Did he get all of them at even strength? | +25 | Two, plus one on the power play. Perfect. | A good stat question. |
| meh | That's so many hats! | +8 | They clean them up in a pile. | Fun, but lightly engaged. |
| cringe | Do they have to pay for the hats? | -5 | No, it's a tradition. | Cute but off track. |

**Exchange 2.** She says: "And the fourth goal was an empty netter."

*What it means:* A goal into the net with no goalie, when her team was protecting a lead.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Empty netter, so the other team pulled their goalie? | +25 | Yes, they were chasing the game. | You know why an empty net occurs. |
| meh | Nice. | +5 | Yeah! | Warm but flat. |
| cringe | Is an empty netter a real goal? | -10 | Yes, it counts. | The answer is yes; don't undervalue. |

*Closing note:* A hat trick is three goals. Empty-net goals come when the goalie is pulled.

### Icing and tired legs (`icing-fatigue`)

*Setting:* During a road game.

**Exchange 1.** She says: "They iced it four times in a row. The top line is dead."

*What it means:* Her team kept shooting the puck the length of the ice and could not change players.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | They can't change after icing, right? Tired legs. | +30 | Exactly! They were stuck out there for 90 seconds. | You know the price of icing. |
| meh | That must be exhausting. | +5 | It is. | Sympathetic. |
| cringe | Why do they keep icing it? | -10 | Because they couldn't get out of their zone. | Ask about that gently; she's frustrated. |

**Exchange 2.** She says: "The coach called a timeout to rest them."

*What it means:* The coach used a timeout to give tired players a rest.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Smart. Did it help the next shift? | +25 | Kind of. They scored on the next faceoff. | You know timeouts are a rest. |
| meh | Good idea. | +5 | Yes. | No follow-up. |
| cringe | Can they do that any time? | -5 | Only during a stoppage. | Fine to ask; but say why. |

*Closing note:* After icing the team can't change; timeouts give a rest.

### PWHL night (`pwhl-jailbreak`)

*Setting:* She's watching the PWHL with friends.

**Exchange 1.** She says: "Jailbreak! She scored shorthanded and the penalty ended."

*What it means:* In the PWHL a shorthanded goal frees the penalized player, called the jailbreak rule.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | The jailbreak rule! So their power play ended right away? | +30 | Yes! It's such a fun rule. | You know a PWHL-specific rule. |
| meh | That's a cool rule. | +8 | Right? | Warm, no new information. |
| cringe | Is it the same as the NHL? | -10 | No, it's different. | It's a fine question, but she just explained it. |

**Exchange 2.** She says: "Twelve teams this year. It's getting big."

*What it means:* The PWHL has expanded to twelve teams for 2026-27.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Twelve teams! Who are the new ones? | +25 | Detroit, Hamilton, Las Vegas and San Jose. | You show interest in the expansion teams. |
| meh | That's a lot of teams. | +5 | It is! | Flat. |
| cringe | Is that as big as the NHL? | -10 | The NHL has 32. | Not a bad question, but it compares unfairly. |

*Closing note:* PWHL: jailbreak rule and twelve teams.

### Still not over it (`olympic-memory`)

*Setting:* A memory from the 2026 Olympics.

**Exchange 1.** She says: "Still not over that gold medal game going to overtime."

*What it means:* The 2026 Olympic gold medal games (men's and women's) both went to overtime and were won by the United States.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Which one, the women's or the men's? | +30 | Both! But the women's was the one I cried at. | You know both finals went to overtime. |
| meh | That was a great game. | +5 | It really was. | Warm but generic. |
| cringe | Who was playing again? | -15 | The U.S. and Canada, obviously. | She lives this; be curious about her memory. |

**Exchange 2.** She says: "3-on-3 overtime in the Olympics is chaos."

*What it means:* The Olympic overtime was played three on three, with lots of open ice.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | It's all breakaways out there. Is that why it ended so fast? | +25 | Yes! One mistake and it's over. | You understand 3-on-3 creates open ice. |
| meh | It looked wild. | +5 | It was. | Neutral. |
| cringe | Is 3-on-3 a real hockey game? | -15 | It's real, it's just faster. | Avoid dismissing the format. |

*Closing note:* Both 2026 Olympic finals went to overtime; 3-on-3 creates open ice.

### Analytics chat (`analytics`)

*Setting:* She's a numbers person.

**Exchange 1.** She says: "Their Corsi is great but they keep losing. PDO says it'll turn."

*What it means:* The team takes many shot attempts, but bad luck in shooting and saves suggests it will change.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | So they're unlucky? A low PDO usually bounces back. | +30 | Exactly. Their goalie is at .880. | You know what PDO means. |
| meh | Numbers are confusing. | +3 | They're not that bad! | Honest but flat. |
| cringe | Stats don't win games. | -20 | ...okay, we'll agree to disagree. | Don't dismiss her interests. |

**Exchange 2.** She says: "But my dad says the eye test says otherwise."

*What it means:* Her dad trusts what he sees rather than the numbers.

| reply | you say | smooth | she answers | coach note |
|---|---|---|---|---|
| good | Both matter. What does he see that the numbers miss? | +25 | He says they don't defend the slot. | A balanced question that respects both. |
| meh | Your dad may be right. | +5 | Maybe. | Safe but not curious. |
| cringe | Your dad doesn't get numbers. | -20 | Wow. Rude. | Never insult her family. |

*Closing note:* Analytics versus the eye test: respect both.

### JSON payloads (first three; schema `talk-track`)

**overtime-heartbreak**

```json
{
  "title": "Overtime heartbreak",
  "setting": "She texts after her team loses in overtime.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Lost in OT again. At least we got the point.",
      "replies": [
        {
          "id": "good",
          "text": "A point is something. Was it 3-on-3 or a shootout?",
          "smoothDelta": 25,
          "theirResponse": "3-on-3. They scored with 40 seconds left. Brutal.",
          "coachNote": "You knew overtime has formats and asked about it."
        },
        {
          "id": "meh",
          "text": "Sorry. Better luck next time.",
          "smoothDelta": 5,
          "theirResponse": "Thanks. It stings.",
          "coachNote": "Kind, but it gives her nothing to talk about."
        },
        {
          "id": "cringe",
          "text": "A loss is a loss. Points don't matter.",
          "smoothDelta": -15,
          "theirResponse": "They do when it's the wild-card race.",
          "coachNote": "Don't dismiss the standings; they matter to her."
        }
      ]
    },
    {
      "theirMessage": "The goalie kept us in it. Forty-one saves.",
      "replies": [
        {
          "id": "good",
          "text": "Forty-one saves. Were they outshooting you?",
          "smoothDelta": 25,
          "theirResponse": "Two to one, yeah. He was the only reason it was close.",
          "coachNote": "A natural follow-up: shots against explain the saves."
        },
        {
          "id": "meh",
          "text": "Wow, that's a lot.",
          "smoothDelta": 8,
          "theirResponse": "Yeah, he deserved better.",
          "coachNote": "Agreeable but flat."
        },
        {
          "id": "cringe",
          "text": "Guess the defense didn't do much then.",
          "smoothDelta": -15,
          "theirResponse": "...they did their best. Not helpful.",
          "coachNote": "Don't blame her team; be curious."
        }
      ]
    }
  ],
  "closingNote": "An overtime loss earns one point in the NHL. Ask about the format and the goalie."
}
```

**power-play-broken**

```json
{
  "title": "The power play is broken",
  "setting": "She vents during the second intermission.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Zero for fourteen on the power play. I can't watch.",
      "replies": [
        {
          "id": "good",
          "text": "Zero for fourteen. Is it the zone entry or the setup?",
          "smoothDelta": 30,
          "theirResponse": "Both! They can't even get in cleanly.",
          "coachNote": "You know a power play starts with getting into the zone."
        },
        {
          "id": "meh",
          "text": "That's rough.",
          "smoothDelta": 5,
          "theirResponse": "It really is.",
          "coachNote": "Warm, but stops the conversation."
        },
        {
          "id": "cringe",
          "text": "What's a power play again?",
          "smoothDelta": -20,
          "theirResponse": "Oh, it's... when the other team is in the penalty box.",
          "coachNote": "Fine to ask once, but she just told you the number; ask about that instead."
        }
      ]
    },
    {
      "theirMessage": "Their penalty kill is elite though.",
      "replies": [
        {
          "id": "good",
          "text": "Do they run a box or press high?",
          "smoothDelta": 25,
          "theirResponse": "Mostly a box. They just block everything.",
          "coachNote": "A formation question shows you know shapes."
        },
        {
          "id": "meh",
          "text": "Maybe you'll score next time.",
          "smoothDelta": 5,
          "theirResponse": "I hope so.",
          "coachNote": "Optimistic, no new information."
        },
        {
          "id": "cringe",
          "text": "Just shoot more, it's simple.",
          "smoothDelta": -15,
          "theirResponse": "Ha, if only.",
          "coachNote": "Avoid simple advice; she's seen it all."
        }
      ]
    }
  ],
  "closingNote": "Power play versus penalty kill. Formations are a great question."
}
```

**goalie-interference**

```json
{
  "title": "Robbed by the review",
  "setting": "She texts about a disallowed goal.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They waved off our goal for goalie interference. Robbed!",
      "replies": [
        {
          "id": "good",
          "text": "Was it contact in the crease? Did the coach challenge it?",
          "smoothDelta": 30,
          "theirResponse": "Yes! Their guy was shoved into the goalie. We challenged and lost.",
          "coachNote": "You know coaches can challenge and it costs a timeout."
        },
        {
          "id": "meh",
          "text": "That's a bad call.",
          "smoothDelta": 5,
          "theirResponse": "Right?",
          "coachNote": "Agreeing is safe but empty."
        },
        {
          "id": "cringe",
          "text": "Referees are the worst.",
          "smoothDelta": -10,
          "theirResponse": "Ha. Well.",
          "coachNote": "Blaming refs gets old fast."
        }
      ]
    },
    {
      "theirMessage": "And now we lost our timeout too.",
      "replies": [
        {
          "id": "good",
          "text": "Ouch, that's the cost of a failed challenge.",
          "smoothDelta": 25,
          "theirResponse": "Exactly. Now we can't use it for the last minute.",
          "coachNote": "You showed you know the penalty for a failed challenge."
        },
        {
          "id": "meh",
          "text": "That's unlucky.",
          "smoothDelta": 5,
          "theirResponse": "Yeah.",
          "coachNote": "Correct sentiment, no knowledge."
        },
        {
          "id": "cringe",
          "text": "Why did they challenge then?",
          "smoothDelta": -10,
          "theirResponse": "Because we thought we'd win.",
          "coachNote": "Question with an edge; sounds accusing."
        }
      ]
    }
  ],
  "closingNote": "Goalie interference is the most argued call. A failed challenge costs a timeout."
}
```

The remaining scenarios use the same format; the authoring pass generates them into `curriculum/*.json` `talkTracks[]` (manifest `conversationScenarios`).

## 5. Authoring notes

- **Images:** all rink diagrams, formation diagrams and referee signals are original vector illustrations with license id `original-swoond`; no NHL/PWHL/team logos, marks or player photos. Hotspot and binary-call diagrams are procedural (`diagramId`): `hockey-rink-full`, `hockey-rink-offensive-zone`, `hockey-rink-neutral-blue-line`, `hockey-crease`.
- **Team and player tokens:** items in `nhl-and-your-team` use `{{team}}` and `{{player}}`; each sentence must still read correctly with the defaults (`the team`, `the star`).
- **Numbers to refresh each season:** salary cap ceiling ($104M in 2026-27), season length (84 games), points system, playoff format.
- **PWHL and international:** keep rules-difference items labelled by league in the prompt or diagram so the learner never assumes NHL rules everywhere.
- **No fake expertise:** every `say-this` carries a `noFakeExpertNote` where guessing would be tempting, and follow-ups favor curiosity questions.