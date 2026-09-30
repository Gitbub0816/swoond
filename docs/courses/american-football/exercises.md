# American Football: Native Exercise Plan (Tier B)

Companion to `CDS.md` (section 12) and `manifest.json` (`nativeExercises[]`). Payloads conform to `docs/contracts/native-exercises/v1/*.schema.json`; every sample below was validated against its schema on 2026-09-30. Catalog of types: `docs/native-exercises/CATALOG.md`.

## 1. Principles for this course

- **Native by default.** Football has five spatial skills that need Unity (coverage reads, route building, pressure counts, run gaps, throwing windows; see `sims/`). Everything else is native: terms, rules, formations on a diagram, decisions, clock feel, conversation.
- **Explain every answer.** Right and wrong. Teach how it works, not just the rule name. Prompts are 12 words or fewer.
- **League clarity.** NFL rules are the default. College differences (one-foot catch, 3-yard two-point try, overtime, clock stops) are stated in the prompt whenever an item touches them.
- **Assets.** All diagrams and audio are original Swoon'd (`license: original-swoond`), procedurally drawn diagram ids `football-*`. No league or team logos, no uniforms, no player likeness, no broadcast audio.
- **Numbers that change.** Overtime length, kickoff spots, playoff format and rule details are tagged `rule-change-of-year`; content review each spring re-verifies them against the newest NFL/NCAA rulebooks (last verified 2026-09-30).
- **No wagering.** Betting and odds are never taught, used as examples or linked.
- **Tone.** Cheeky coach; playful never mean; never about the crush; no faking expertise.

### Counts and placement

| Type | Estimated items | Main units |
|---|---|---|
| `multiple-choice` | 260 | the-basics, players-positions, flags-and-rules, league-machine, always-on-review |
| `binary-call` | 90 | flags-and-rules, special-teams, the-basics (first-down marker) |
| `term-match` | 45 | players-positions, defense-basics, flags-and-rules, always-on-review |
| `sequence-order` | 30 | offense-basics, situational-football, league-machine |
| `visual-id` | 55 | offense-basics, defense-basics, flags-and-rules |
| `decision-scenario` | 60 | situational-football, debates-and-analytics, league-machine |
| `talk-track` | 60 | conversation-lab, this-week, every unit's closing lesson |
| `timing-tap` | 12 | the-basics (clock-05), special-teams, situational-football |
| `say-this` | 150 | every unit from players-positions onward |
| `fill-the-gap` | 90 | the-basics, defense-basics, situational-football, always-on-review |
| `listening-id` | 24 | flags-and-rules (before-snap-01, referee-08), always-on-review |
| `estimate-slider` | 40 | the-basics, special-teams, situational-football |
| `hotspot-tap` | 75 | the-basics, players-positions, defense-basics, play-craft |

## 2. Native exercise types used

### 2.1 `multiple-choice`

**How it is used.** Default knowledge check and the review card. Used in nearly every foundations and intermediate lesson to check one fact with an explanation of how it works, not just the rule name.

**Design notes.** Two to four options; wrong options are common misconceptions (for example 'the clock only runs on plays', 'a safety is a kind of kick'). Every wrong option carries an `explanation` where the misconception is real.

**Estimated items:** 260. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `downs-03`)

```json
{
  "prompt": "What does a first down give the offense?",
  "options": [
    {
      "id": "a",
      "text": "Four more downs"
    },
    {
      "id": "b",
      "text": "A free field goal"
    },
    {
      "id": "c",
      "text": "An extra timeout"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Gain 10 yards and the count resets: four fresh tries. That is why fans cheer a first down.",
    "incorrect": "A first down resets the offense to four tries at another 10 yards. It is not points or timeouts, just more time with the ball.",
    "sayThisLine": "They picked up the first down, so they keep the ball."
  }
}
```

**Sample 2** (lesson or track `back-seven-04`)

```json
{
  "prompt": "What is a free safety's main job?",
  "options": [
    {
      "id": "a",
      "text": "Guard against deep passes"
    },
    {
      "id": "b",
      "text": "Kick field goals"
    },
    {
      "id": "c",
      "text": "Block for the running back"
    },
    {
      "id": "d",
      "text": "Snap the ball"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Safeties are the deepest defenders. The free safety plays the back of the defense and stops big plays over the top.",
    "incorrect": "The free safety is a defensive back who plays deep. He is the last line of defense against long passes.",
    "sayThisLine": "Their free safety saved a touchdown."
  }
}
```

**Sample 3** (lesson or track `scoring-06`)

```json
{
  "prompt": "In the NFL, where does a two-point try start?",
  "options": [
    {
      "id": "a",
      "text": "The 1-yard line"
    },
    {
      "id": "b",
      "text": "The 2-yard line"
    },
    {
      "id": "c",
      "text": "The 3-yard line"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "The NFL uses the 2-yard line. College snaps from the 3, one of the small differences between the two games.",
    "incorrect": "The NFL snaps two-point tries from the 2-yard line. College uses the 3-yard line, so the two versions feel slightly different.",
    "sayThisLine": "Going for two from the two-yard line is a coin flip."
  }
}
```

### 2.2 `binary-call`

**How it is used.** Yes/no rulings on a static diagram: offside vs legal, catch vs incomplete, penalty vs no penalty. The football version of the design's kitchen call. Movement is not needed because the rule turns on a position at one instant.

**Design notes.** Use `field-diagram` scenes with procedural diagram ids; markers are normalized; `ruleTag` names the rule. When NFL and college differ, state the league in the prompt.

**Estimated items:** 90. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `before-snap-01`)

```json
{
  "prompt": "Defender is across the line when the ball is snapped.",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "football-line-of-scrimmage",
    "markers": [
      {
        "role": "opponent",
        "x": 0.5,
        "y": 0.42
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.5
      }
    ],
    "alt": "Overhead view of the line of scrimmage. One defender's helmet is past the ball's line at the snap."
  },
  "choices": [
    {
      "id": "offside",
      "label": "Offside"
    },
    {
      "id": "legal",
      "label": "Legal"
    }
  ],
  "correctChoiceId": "offside",
  "ruleTag": "Offside",
  "explanation": {
    "correct": "Once the ball is snapped a defender may not be beyond the line. Five yards, and the offense usually gets a free play.",
    "incorrect": "The line of scrimmage is the ball's tip. A defender past it at the snap is offside for five yards.",
    "sayThisLine": "Their end was offside again."
  }
}
```

**Sample 2** (lesson or track `catch-06`)

```json
{
  "prompt": "NFL: receiver gets one foot down, then steps out. Catch?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "football-sideline-catch",
    "markers": [
      {
        "role": "player",
        "x": 0.9,
        "y": 0.5
      },
      {
        "role": "ball",
        "x": 0.88,
        "y": 0.48
      }
    ],
    "alt": "Overhead view of the sideline. A receiver has one foot inside the line and the next step lands outside it."
  },
  "choices": [
    {
      "id": "catch",
      "label": "Catch"
    },
    {
      "id": "incomplete",
      "label": "Incomplete"
    }
  ],
  "correctChoiceId": "incomplete",
  "ruleTag": "Catch rule",
  "explanation": {
    "correct": "The NFL needs two feet down inbounds (or another body part) plus control. One foot is enough in college, which confuses everyone.",
    "incorrect": "In the NFL a receiver needs two feet inbounds with control. One foot only counts in college.",
    "sayThisLine": "One foot? That's a catch in college but not the NFL."
  }
}
```

**Sample 3** (lesson or track `returns-02`)

```json
{
  "prompt": "Returner waves for a fair catch. A defender hits him.",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "football-punt-return",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.35
      },
      {
        "role": "opponent",
        "x": 0.5,
        "y": 0.3
      }
    ],
    "alt": "Overhead view of a punt return. The returner stands with one arm raised and a defender is right beside him."
  },
  "choices": [
    {
      "id": "penalty",
      "label": "Penalty"
    },
    {
      "id": "legal-hit",
      "label": "Legal hit"
    }
  ],
  "correctChoiceId": "penalty",
  "ruleTag": "Fair catch",
  "explanation": {
    "correct": "A raised arm means no return, and nobody may touch him. Contact gives the returning team 15 yards.",
    "incorrect": "The wave is a promise not to run, and the hit is illegal. It costs the kicking team 15 yards.",
    "sayThisLine": "He signaled for a fair catch, that hit was a penalty."
  }
}
```

### 2.3 `term-match`

**How it is used.** Introduce three to six related terms at once: positions, coverages, flags, front names.

**Design notes.** Definitions are written in plain English, never in jargon that needs another term. One distractor definition at most.

**Estimated items:** 45. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `backfield-02`)

```json
{
  "prompt": "Match each position to its job.",
  "pairs": [
    {
      "id": "qb",
      "term": "Quarterback",
      "definition": "Takes the snap, throws or hands off"
    },
    {
      "id": "cb",
      "term": "Cornerback",
      "definition": "Covers wide receivers"
    },
    {
      "id": "olb",
      "term": "Linebacker",
      "definition": "Stops runs, rushes and covers"
    },
    {
      "id": "k",
      "term": "Kicker",
      "definition": "Kicks field goals and extra points"
    },
    {
      "id": "te",
      "term": "Tight end",
      "definition": "Blocks like a lineman, catches like a receiver"
    }
  ],
  "distractorDefinitions": [
    "Snaps the ball to the punter"
  ],
  "explanation": {
    "summary": "Offense scores, defense stops, special teams kicks. If you can place a player in one of those three, you can follow the conversation.",
    "sayThisLine": "Their tight end is basically a second tackle and a receiver."
  }
}
```

**Sample 2** (lesson or track `cover-4-08`)

```json
{
  "prompt": "Match the coverage to what it means.",
  "pairs": [
    {
      "id": "c2",
      "term": "Cover 2",
      "definition": "Two safeties split the deep field in halves"
    },
    {
      "id": "c3",
      "term": "Cover 3",
      "definition": "Three defenders split the deep field in thirds"
    },
    {
      "id": "c4",
      "term": "Cover 4",
      "definition": "Four defenders each guard a deep quarter"
    },
    {
      "id": "man",
      "term": "Man coverage",
      "definition": "Each defender follows one receiver"
    }
  ],
  "distractorDefinitions": [
    "The whole defense rushes the passer"
  ],
  "explanation": {
    "summary": "The number is how many defenders guard the deep field. Man is the odd one out: it follows people, not areas.",
    "sayThisLine": "They are in Cover 3, so the short stuff is open."
  }
}
```

**Sample 3** (lesson or track `before-snap-01`)

```json
{
  "prompt": "Match the flag to what happened.",
  "pairs": [
    {
      "id": "off",
      "term": "Offside",
      "definition": "Defender crossed the line before the snap"
    },
    {
      "id": "fs",
      "term": "False start",
      "definition": "Offensive player moved before the snap"
    },
    {
      "id": "hold",
      "term": "Holding",
      "definition": "Illegally grabbed a player"
    },
    {
      "id": "dog",
      "term": "Delay of game",
      "definition": "Play clock ran out"
    }
  ],
  "explanation": {
    "summary": "Offside is the defense jumping early. False start is the offense. Holding and delay of game are their own things.",
    "sayThisLine": "False start again? Their tackle is jumpy."
  }
}
```

### 2.4 `sequence-order`

**How it is used.** Processes with a real order: the anatomy of a pass play, what follows a touchdown, the two-minute drill, playoff rounds, the path from draft to roster.

**Design notes.** Items authored in correct order; each `why` teaches the dependency. Not used when there is no true order.

**Estimated items:** 30. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `runs-03`)

```json
{
  "prompt": "Put a pass play in order.",
  "items": [
    {
      "id": "snap",
      "text": "Center snaps the ball",
      "why": "Nothing happens until the snap."
    },
    {
      "id": "drop",
      "text": "Quarterback drops back",
      "why": "He needs space to set his feet."
    },
    {
      "id": "route",
      "text": "Receivers run their routes",
      "why": "They break open as the pocket forms."
    },
    {
      "id": "throw",
      "text": "Quarterback throws",
      "why": "He picks the open receiver."
    },
    {
      "id": "catch",
      "text": "Receiver catches and runs",
      "why": "Yards after the catch count."
    }
  ],
  "explanation": {
    "correct": "Snap, drop, routes, throw, catch: five beats that all happen in about four seconds.",
    "incorrect": "Every pass play starts with a snap and ends with a catch. The quarterback and receivers work at the same time in the middle."
  }
}
```

**Sample 2** (lesson or track `playoffs-02`)

```json
{
  "prompt": "Put the NFL playoff path in order.",
  "items": [
    {
      "id": "wc",
      "text": "Wild Card round"
    },
    {
      "id": "div",
      "text": "Divisional round"
    },
    {
      "id": "conf",
      "text": "Conference Championship"
    },
    {
      "id": "sb",
      "text": "Super Bowl"
    }
  ],
  "explanation": {
    "correct": "Wild Card, Divisional, Conference Championship, Super Bowl. Only the top seed in each conference skips the first round.",
    "incorrect": "Four rounds: Wild Card first, then Divisional, Conference Championships, and the Super Bowl at the end.",
    "sayThisLine": "We need the one seed and the bye."
  }
}
```

**Sample 3** (lesson or track `turnovers-07`)

```json
{
  "prompt": "What happens after a touchdown?",
  "items": [
    {
      "id": "td",
      "text": "Touchdown scored"
    },
    {
      "id": "pat",
      "text": "Extra point or two-point try"
    },
    {
      "id": "ko",
      "text": "Scoring team kicks off"
    },
    {
      "id": "ret",
      "text": "Other team returns the kick"
    },
    {
      "id": "drive",
      "text": "New drive begins"
    }
  ],
  "explanation": {
    "correct": "Score, try for the extra point, kickoff, return, then a new drive. It is the loop the whole game repeats.",
    "incorrect": "After a touchdown comes the extra point or two-point try, then the scoring team kicks off and the other team starts a new drive."
  }
}
```

### 2.5 `visual-id`

**How it is used.** Recognize a formation, a front or a referee signal from an original diagram. Football imagery is procedural or drawn by Swoon'd (license `original-swoond`); no NFL logos, uniforms or player photos.

**Design notes.** `alt` describes distinguishing features without giving away the answer; `cues` are the teach. All assets under `images/diagrams/`.

**Estimated items:** 55. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `snap-02`)

```json
{
  "prompt": "Which one is shotgun?",
  "image": {
    "asset": "images/diagrams/formation-shotgun.png",
    "alt": "Overhead diagram of an offense. The quarterback stands several yards behind the center with a running back beside him.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Quarterback several yards behind center"
    },
    {
      "id": "b",
      "text": "Quarterback directly behind center"
    },
    {
      "id": "c",
      "text": "Quarterback split wide"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Shotgun means the quarterback starts a few yards back, so he sees the field better. It is the default on passing downs.",
    "incorrect": "In shotgun the quarterback lines up several yards behind the center. Directly behind the center is called under center.",
    "sayThisLine": "Shotgun on third and long, obviously."
  },
  "cues": [
    "Quarterback about five yards back",
    "Ball is snapped through the air"
  ]
}
```

**Sample 2** (lesson or track `fronts-01`)

```json
{
  "prompt": "Which one is a 3-4 front?",
  "image": {
    "asset": "images/diagrams/front-3-4.png",
    "alt": "Overhead diagram of a defense. Three big players are on the line and four more stand behind them.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "3-4 front"
    },
    {
      "id": "b",
      "text": "4-3 front"
    },
    {
      "id": "c",
      "text": "Nickel package"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Count the down linemen: three, with four linebackers behind. That extra linebacker usually rushes from the edge.",
    "incorrect": "Three linemen and four linebackers is a 3-4. A 4-3 has four linemen and three linebackers.",
    "sayThisLine": "It's a 3-4, so the outside linebackers rush."
  },
  "cues": [
    "Three linemen",
    "Four linebackers"
  ]
}
```

**Sample 3** (lesson or track `referee-08`)

```json
{
  "prompt": "Which signal means holding?",
  "image": {
    "asset": "images/diagrams/signal-holding.png",
    "alt": "Illustration of a referee grasping one wrist with the other hand in front of his chest.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Holding"
    },
    {
      "id": "b",
      "text": "Offside"
    },
    {
      "id": "c",
      "text": "Delay of game"
    },
    {
      "id": "d",
      "text": "Touchdown"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "The referee grabs one wrist with the other hand. Think of a player grabbing a jersey.",
    "incorrect": "Grabbing your own wrist is holding. Offside is hands on hips, touchdown is both arms up.",
    "sayThisLine": "Holding! I saw the wrist grab."
  },
  "cues": [
    "Hand grabs wrist",
    "In front of the chest"
  ]
}
```

### 2.6 `decision-scenario`

**How it is used.** Judgment calls a coach or fan debates: fourth down, clock management, challenges, kick or go for two. Verdicts are best, acceptable, poor, with a note about what analysts weigh.

**Design notes.** No `safetyNote` needed (no real-world risk), but avoid any wagering framing. Consequences are stated in football terms, never as certainty ('usually', 'analysts prefer').

**Estimated items:** 60. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `fourth-02`)

```json
{
  "prompt": "Fourth and 2 at their 35. What would fans want?",
  "situation": {
    "narrative": "You are down by 3 late in the fourth quarter.",
    "facts": [
      {
        "label": "Down and distance",
        "value": "4th and 2"
      },
      {
        "label": "Ball on",
        "value": "Opponent 35"
      },
      {
        "label": "Score",
        "value": "Trailing by 3"
      },
      {
        "label": "Time left",
        "value": "4:10"
      },
      {
        "label": "Timeouts",
        "value": "2 remaining"
      }
    ]
  },
  "options": [
    {
      "id": "go",
      "label": "Go for it",
      "verdict": "best",
      "consequence": "You need two yards on a normal play and the drive stays alive.",
      "considerations": [
        "A field goal only ties",
        "A punt gives the ball back with time running"
      ]
    },
    {
      "id": "fg",
      "label": "Kick a field goal",
      "verdict": "acceptable",
      "consequence": "A 52-yard kick ties it but is not certain.",
      "considerations": [
        "Long kick, lower odds",
        "Overtime is a coin flip"
      ]
    },
    {
      "id": "punt",
      "label": "Punt",
      "verdict": "poor",
      "consequence": "You give up your best chance and trail with less time.",
      "considerations": [
        "Field position only",
        "You have to stop them again"
      ]
    }
  ],
  "expertNote": "Analytics say teams should go on short fourth downs near midfield, and late in a close game it is even clearer.",
  "sayThisLine": "Go for it! Two yards, what are we doing?"
}
```

**Sample 2** (lesson or track `clock-06`)

```json
{
  "prompt": "Leading late. Which play keeps the clock running?",
  "situation": {
    "narrative": "You lead by 4 and want the game to end.",
    "facts": [
      {
        "label": "Score",
        "value": "Leading by 4"
      },
      {
        "label": "Time left",
        "value": "2:10"
      },
      {
        "label": "Down and distance",
        "value": "2nd and 6"
      },
      {
        "label": "Opponent timeouts",
        "value": "2"
      },
      {
        "label": "Your timeouts",
        "value": "0"
      }
    ]
  },
  "options": [
    {
      "id": "run",
      "label": "Run up the middle",
      "verdict": "best",
      "consequence": "The clock keeps running. They burn a timeout to stop it.",
      "considerations": [
        "Running keeps the clock moving",
        "Fumble risk is small"
      ]
    },
    {
      "id": "short",
      "label": "Short pass",
      "verdict": "acceptable",
      "consequence": "An incomplete pass stops the clock, but a catch in bounds keeps it going.",
      "considerations": [
        "Completion runs the clock",
        "Incompletion stops it"
      ]
    },
    {
      "id": "deep",
      "label": "Throw deep",
      "verdict": "poor",
      "consequence": "Incomplete stops the clock and helps the trailing team.",
      "considerations": [
        "Stops the clock",
        "Interception risk"
      ]
    }
  ],
  "expertNote": "When leading, coaches run the ball to burn clock and force the opponent to use timeouts.",
  "sayThisLine": "He should just run it and keep the clock moving."
}
```

**Sample 3** (lesson or track `review-07`)

```json
{
  "prompt": "Should the coach throw the red flag?",
  "situation": {
    "narrative": "A receiver caught a pass at the sideline, ruled complete. Replays are unclear.",
    "facts": [
      {
        "label": "Replay angles",
        "value": "Two look incomplete"
      },
      {
        "label": "Timeouts left",
        "value": "1"
      },
      {
        "label": "Time left",
        "value": "6:00 in the 2nd half"
      },
      {
        "label": "Play result",
        "value": "Gained 22 yards"
      },
      {
        "label": "Review type",
        "value": "Coach's challenge"
      }
    ]
  },
  "options": [
    {
      "id": "challenge",
      "label": "Challenge the catch",
      "verdict": "best",
      "consequence": "A win takes back 22 yards; a loss costs one timeout, but the odds are good with two angles.",
      "considerations": [
        "Two angles look incomplete",
        "Big play, big swing"
      ]
    },
    {
      "id": "stand",
      "label": "Let it stand",
      "verdict": "acceptable",
      "consequence": "You keep your last timeout but concede the yards.",
      "considerations": [
        "Timeout flexibility",
        "Yards conceded"
      ]
    },
    {
      "id": "timeout",
      "label": "Burn the last timeout to think",
      "verdict": "poor",
      "consequence": "You lose the timeout and still have no answer.",
      "considerations": [
        "Wastes the timeout",
        "Does not change the call"
      ]
    }
  ],
  "expertNote": "Coaches challenge when the odds are good and the play is big, and they save timeouts for the end of a half.",
  "sayThisLine": "Is that enough to throw the flag?"
}
```

### 2.7 `talk-track`

**How it is used.** Chat practice with a friendly fan. Ten authored tracks at launch (Talk tab and `conversation-lab`), more per season. Each reply is scored for smoothness; coach notes teach curiosity over bluffing.

**Design notes.** Three replies per exchange: one curious and honest (good), one polite but flat (meh), one that fakes expertise or dismisses her (cringe). Never mock the crush. See the ten scenarios below.

**Estimated items:** 60. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `first-text`)

```json
{
  "title": "Game night text",
  "setting": "She texts you the morning after a big game.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Did you watch the game last night?? That last drive was unreal.",
      "replies": [
        {
          "id": "a",
          "text": "I only caught the end. What happened on that last drive?",
          "smoothDelta": 25,
          "theirResponse": "Okay, so they were down four and marched 80 yards. It took like eight minutes.",
          "coachNote": "Honest and curious. It invites her to tell the story."
        },
        {
          "id": "b",
          "text": "Yeah, crazy game.",
          "smoothDelta": 5,
          "theirResponse": "...You did not watch it, did you?",
          "coachNote": "Vague agreement is easy to spot. Ask something real."
        },
        {
          "id": "c",
          "text": "Yeah, our defense should have blitzed more.",
          "smoothDelta": -15,
          "theirResponse": "We were on offense. Wait, were you even watching?",
          "coachNote": "Faking expertise backfires. Say what you actually saw."
        }
      ]
    },
    {
      "theirMessage": "Eight minutes and they never punted. The kicker had a chance at the end.",
      "replies": [
        {
          "id": "a",
          "text": "Was it a field goal to win, or did they need a touchdown?",
          "smoothDelta": 25,
          "theirResponse": "Field goal! Thirty-eight yards. I was screaming.",
          "coachNote": "Uses the rules you know (field goal, touchdown) to ask a good question."
        },
        {
          "id": "b",
          "text": "Nice.",
          "smoothDelta": 5,
          "theirResponse": "Just nice?",
          "coachNote": "A little flat. She gave you a hook, take it."
        },
        {
          "id": "c",
          "text": "Field goals are boring. Go for the touchdown.",
          "smoothDelta": -15,
          "theirResponse": "Sir, it was a 38-yard game winner.",
          "coachNote": "Do not argue with a moment she loved."
        }
      ]
    }
  ],
  "closingNote": "Curiosity beats bluffing every time. Ask what you would honestly want to know."
}
```

**Sample 2** (lesson or track `fourth-down`)

```json
{
  "title": "The fourth-down gripe",
  "setting": "She texts during a game.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I cannot believe he punted on fourth and two.",
      "replies": [
        {
          "id": "a",
          "text": "Fourth and two feels like a go for it. Was he worried about giving up field position?",
          "smoothDelta": 25,
          "theirResponse": "Exactly! Analytics says go. He never listens.",
          "coachNote": "You showed you know why teams debate it."
        },
        {
          "id": "b",
          "text": "Maybe the coach had a reason?",
          "smoothDelta": 5,
          "theirResponse": "He always has a reason. It is always the same reason.",
          "coachNote": "Not wrong, but it does not join her frustration."
        },
        {
          "id": "c",
          "text": "Punting is always the safe play, that is smart football.",
          "smoothDelta": -15,
          "theirResponse": "Have you seen the numbers? Nobody thinks that anymore.",
          "coachNote": "Old-school certainty on a hot topic is risky. Ask instead."
        }
      ]
    }
  ],
  "closingNote": "Curiosity beats bluffing every time. Ask what you would honestly want to know."
}
```

**Sample 3** (lesson or track `secondary`)

```json
{
  "title": "The secondary is struggling",
  "setting": "At a bar after a loss.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Our secondary is absolutely killing us this year.",
      "replies": [
        {
          "id": "a",
          "text": "Is it the corners getting beat, or the safeties not helping over the top?",
          "smoothDelta": 25,
          "theirResponse": "Both! Last week the safety bit on a fake and it was a touchdown.",
          "coachNote": "Shows you know the secondary has two position groups."
        },
        {
          "id": "b",
          "text": "Yeah, that is rough.",
          "smoothDelta": 5,
          "theirResponse": "It is. I hate it.",
          "coachNote": "Kind, but it leaves her alone with the topic."
        },
        {
          "id": "c",
          "text": "Just get a better quarterback then.",
          "smoothDelta": -15,
          "theirResponse": "We are talking defense. The quarterback is on offense.",
          "coachNote": "Mixing up sides. It is okay to ask instead."
        }
      ]
    },
    {
      "theirMessage": "The safety was so late. Our corners cannot cover anyone.",
      "replies": [
        {
          "id": "a",
          "text": "Do you think they play too much zone? Or are they in man and just getting beat?",
          "smoothDelta": 25,
          "theirResponse": "Man, mostly. That is the frustrating part.",
          "coachNote": "Man versus zone is the perfect follow-up."
        },
        {
          "id": "b",
          "text": "Sounds tough.",
          "smoothDelta": 5,
          "theirResponse": "It is.",
          "coachNote": "Fine. Not memorable."
        },
        {
          "id": "c",
          "text": "Maybe they should blitz every play.",
          "smoothDelta": -15,
          "theirResponse": "That would make it worse.",
          "coachNote": "Blitzing leaves corners alone. Save the guess."
        }
      ]
    }
  ],
  "closingNote": "Curiosity beats bluffing every time. Ask what you would honestly want to know."
}
```

### 2.8 `timing-tap`

**How it is used.** One-dimensional clock feel: the play clock, the field-goal operation, the spike. If the timing depends on the 3D scene (passing windows), it is Unity instead.

**Design notes.** Zones shrink and sweeps speed up per round. Always provide the accessibility alternative (`tap-to-stop-slow` or `hold-and-release`). Copy explains the football reason for the timing, not just the game.

**Estimated items:** 12. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `tempo-08`)

```json
{
  "prompt": "Snap it before the play clock hits zero.",
  "theme": {
    "label": "Play clock",
    "resultUnit": "seconds"
  },
  "rounds": [
    {
      "zoneStartPct": 55,
      "zoneEndPct": 75,
      "sweepSeconds": 1.8
    },
    {
      "zoneStartPct": 62,
      "zoneEndPct": 76,
      "sweepSeconds": 1.5
    },
    {
      "zoneStartPct": 68,
      "zoneEndPct": 80,
      "sweepSeconds": 1.2
    }
  ],
  "explanation": {
    "correct": "The snap has to happen while the clock still has time on it. Too late is delay of game, too early gives the defense a free look.",
    "incorrect": "Snapping late costs five yards and the offense loses momentum. Practice the rhythm.",
    "sayThisLine": "They cut it close on the play clock."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson or track `kicking-04`)

```json
{
  "prompt": "Get the field goal off in the gold window.",
  "theme": {
    "label": "Field goal operation",
    "resultUnit": "seconds"
  },
  "rounds": [
    {
      "zoneStartPct": 60,
      "zoneEndPct": 72,
      "sweepSeconds": 1.5
    },
    {
      "zoneStartPct": 64,
      "zoneEndPct": 74,
      "sweepSeconds": 1.3
    },
    {
      "zoneStartPct": 66,
      "zoneEndPct": 76,
      "sweepSeconds": 1.1
    }
  ],
  "explanation": {
    "correct": "Snap, hold and kick take about 1.3 seconds. A tenth off and the kick can be blocked.",
    "incorrect": "A late kick risks a block, an early one means a rushed kick. The window is small.",
    "sayThisLine": "Snap, hold, kick in 1.3 seconds."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

**Sample 3** (lesson or track `two-minute-05`)

```json
{
  "prompt": "Spike it when the clock says stop.",
  "theme": {
    "label": "Spike the ball",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 50,
      "zoneEndPct": 68,
      "sweepSeconds": 1.7
    },
    {
      "zoneStartPct": 58,
      "zoneEndPct": 72,
      "sweepSeconds": 1.4
    }
  ],
  "explanation": {
    "correct": "Spiking stops the clock on purpose, at the cost of a down. Timing it right saves seconds.",
    "incorrect": "A spike costs a down. Do it too late and time expires, do it too early and you waste a play.",
    "sayThisLine": "He spiked it to save time."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.9 `say-this`

**How it is used.** The signature 'what is she talking about?' item: decode a fan sentence, then choose good follow-up lines. Fills the conversation and enthusiast layers and every live-season template.

**Design notes.** Statements are real fan phrasing, first person. Correct options are concepts implied by the sentence (multi-select). Every item ends with a follow-up line and, where natural, a `noFakeExpertNote`.

**Estimated items:** 150. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `secondary-05`)

```json
{
  "statement": {
    "speaker": "Sarah",
    "text": "Our offense is so one-dimensional. Everything is a pass."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "The team only passes",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The running game is not working",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "The kicker is bad",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "The team has only one player",
      "isCorrect": false
    }
  ],
  "translation": "The team passes almost every play and the run game is not a threat, so defenses can predict what comes next.",
  "followUps": [
    {
      "line": "Do you think they should run more to open things up?",
      "why": "Shows you understand run and pass balance."
    }
  ],
  "noFakeExpertNote": "If you are not sure what one-dimensional means, ask her. She will love explaining it."
}
```

**Sample 2** (lesson or track `shanahan-03`)

```json
{
  "statement": {
    "speaker": "Marcus",
    "text": "We have to establish the run so play-action works."
  },
  "question": "What does he mean?",
  "options": [
    {
      "id": "a",
      "text": "Run the ball early to make defenders respect it",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Fake handoffs work better after real runs",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "Kick more field goals",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "Switch quarterbacks",
      "isCorrect": false
    }
  ],
  "translation": "If the team runs successfully first, defenders step up on fake handoffs, which creates space for passes behind them.",
  "followUps": [
    {
      "line": "Is the play-action off inside zone or something else?",
      "why": "Connects run scheme to the fake."
    },
    {
      "line": "Do you think they are giving up too early on the run?",
      "why": "Invites his opinion."
    }
  ]
}
```

**Sample 3** (lesson or track `watch-party-07`)

```json
{
  "statement": {
    "speaker": "Dana",
    "text": "Their safeties are playing so deep, everything underneath is open."
  },
  "question": "What is she saying?",
  "options": [
    {
      "id": "a",
      "text": "The defense fears deep passes",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Short throws are available",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "The defense is blitzing",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "The offense is running a lot",
      "isCorrect": false
    }
  ],
  "translation": "The safeties are sitting far back to prevent big plays, which leaves space in front of them for short catches.",
  "followUps": [
    {
      "line": "Is that a Cover 2 thing?",
      "why": "Names the possible coverage without bluffing."
    }
  ],
  "noFakeExpertNote": "You can say 'I think so, but I am not sure. What do you see?'"
}
```

### 2.10 `fill-the-gap`

**How it is used.** Vocabulary in context and review: a sentence with one to three gaps.

**Design notes.** Options are same-category terms. Explanation gives the why.

**Estimated items:** 90. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `scoring-06`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "A {{gap-a}} is worth three points and is kicked on {{gap-b}} down.",
  "gaps": [
    {
      "id": "gap-a",
      "options": [
        "field goal",
        "touchdown",
        "safety"
      ],
      "correct": "field goal"
    },
    {
      "id": "gap-b",
      "options": [
        "first",
        "fourth"
      ],
      "correct": "fourth"
    }
  ],
  "explanation": {
    "correct": "Field goals are worth three points and are usually kicked on fourth down when a touchdown is out of reach.",
    "incorrect": "A field goal is three points. Teams usually kick it on fourth down instead of punting.",
    "sayThisLine": "Just kick the field goal."
  }
}
```

**Sample 2** (lesson or track `man-zone-02`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "In {{gap-a}} coverage a defender follows a receiver, in {{gap-b}} he guards an area.",
  "gaps": [
    {
      "id": "gap-a",
      "options": [
        "man",
        "zone"
      ],
      "correct": "man"
    },
    {
      "id": "gap-b",
      "options": [
        "man",
        "zone"
      ],
      "correct": "zone"
    }
  ],
  "explanation": {
    "correct": "Man follows people; zone protects areas. Every coverage is a mix of the two ideas.",
    "incorrect": "Man coverage follows a receiver; zone guards a spot. Swap them and you get the opposite.",
    "sayThisLine": "Is it man or zone?"
  }
}
```

**Sample 3** (lesson or track `markers-04`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "The offense needs {{gap-a}} yards for a first down, and a sack is a loss of {{gap-b}}.",
  "gaps": [
    {
      "id": "gap-a",
      "options": [
        "5",
        "10",
        "15"
      ],
      "correct": "10"
    },
    {
      "id": "gap-b",
      "options": [
        "yards",
        "points"
      ],
      "correct": "yards"
    }
  ],
  "explanation": {
    "correct": "Ten yards for a first down, and a sack costs yards, not points.",
    "incorrect": "The offense needs 10 yards. A sack is a lost yardage play.",
    "sayThisLine": "That sack put them behind the sticks."
  }
}
```

### 2.11 `listening-id`

**How it is used.** Recognize a referee announcement or cadence from original Swoon'd-recorded audio. Never uses broadcast audio or NFL Films.

**Design notes.** Audio is original narration (license `original-swoond`), 3-6 seconds, with a text description; the Skip button awards no XP and costs no heart for learners who cannot hear.

**Estimated items:** 24. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `referee-08`)

```json
{
  "prompt": "What did the referee announce?",
  "audio": {
    "asset": "audio/referee/offside-defense.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "A referee says: Offside, defense, number 92. Five yards.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Offside on the defense"
    },
    {
      "id": "b",
      "text": "False start on the offense"
    },
    {
      "id": "c",
      "text": "Holding on the offense"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Offside on the defense: the defender crossed the line early. It is five yards, and the offense replays the down.",
    "incorrect": "Listen for the word 'defense' after 'offside'. If it said 'offense' it would be a false start.",
    "sayThisLine": "Offside, five yards."
  },
  "listenFor": [
    "The word 'offside'",
    "Which team is named"
  ]
}
```

**Sample 2** (lesson or track `referee-08`)

```json
{
  "prompt": "Which call gives the offense a first down?",
  "audio": {
    "asset": "audio/referee/holding-defense.m4a",
    "durationMs": 4500,
    "license": "original-swoond",
    "description": "A referee says: Holding, defense, number 54. Five yards and an automatic first down.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Holding on the defense"
    },
    {
      "id": "b",
      "text": "Holding on the offense"
    },
    {
      "id": "c",
      "text": "Delay of game"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Defensive holding gives the offense five yards and an automatic first down.",
    "incorrect": "Listen for 'defense' and 'automatic first down'. Holding on the offense costs ten yards.",
    "sayThisLine": "Automatic first down!"
  },
  "listenFor": [
    "Automatic first down"
  ]
}
```

**Sample 3** (lesson or track `referee-08`)

```json
{
  "prompt": "Which call stops the clock for a review?",
  "audio": {
    "asset": "audio/referee/under-review.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "A referee says: After further review, the ruling on the field is overturned.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "The call was reversed"
    },
    {
      "id": "b",
      "text": "The call stands"
    },
    {
      "id": "c",
      "text": "Ball is dead"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Overturned means the original call was reversed after replay.",
    "incorrect": "Overturned means reversed. The call stands would be stated differently.",
    "sayThisLine": "They overturned it."
  },
  "listenFor": [
    "Overturned"
  ]
}
```

### 2.12 `estimate-slider`

**How it is used.** Feel for the numbers: field length, kick distance, clock lengths, roster sizes.

**Design notes.** Tolerances are generous; the point is magnitude. Numbers that change by season (overtime length, playoff format) are checked against `rule-change-of-year` data before each season.

**Estimated items:** 40. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `overtime-07`)

```json
{
  "prompt": "How long is regular-season overtime?",
  "unit": "minutes",
  "min": 0,
  "max": 20,
  "step": 1,
  "correctValue": 10,
  "tolerance": {
    "full": 0,
    "partial": 2
  },
  "explanation": {
    "correct": "Ten minutes in the regular season, and since 2025 both teams get a chance to possess.",
    "incorrect": "Regular-season overtime is ten minutes. It ends early only if someone wins.",
    "sayThisLine": "Overtime is ten minutes now."
  }
}
```

**Sample 2** (lesson or track `kicking-04`)

```json
{
  "prompt": "How long is a field goal from the 35?",
  "unit": "yards",
  "min": 30,
  "max": 80,
  "step": 1,
  "correctValue": 52,
  "tolerance": {
    "full": 1,
    "partial": 4
  },
  "explanation": {
    "correct": "Add 17 yards: 10 for the end zone and 7 for the snap. From the 35, the kick is about 52 yards.",
    "incorrect": "From the 35 the kick is 52 yards, because you add the end zone and the snap distance.",
    "sayThisLine": "That is a 52-yard field goal."
  }
}
```

**Sample 3** (lesson or track `field-02`)

```json
{
  "prompt": "How long is the whole field with end zones?",
  "unit": "yards",
  "min": 80,
  "max": 140,
  "step": 5,
  "correctValue": 120,
  "tolerance": {
    "full": 0,
    "partial": 10
  },
  "explanation": {
    "correct": "One hundred yards of field plus two ten-yard end zones.",
    "incorrect": "The field is 100 yards between goal lines plus 10 yards for each end zone: 120 total."
  }
}
```

### 2.13 `hotspot-tap`

**How it is used.** Tap a place on a static diagram: the line of scrimmage, the nose tackle, the A gap, where the safety lines up. Static positions only; anything that moves is Unity.

**Design notes.** Diagrams are procedural (`football-*` ids); hotspots are >= 44 pt after scaling. Labels are read by VoiceOver.

**Estimated items:** 75. Catalog: `docs/native-exercises/CATALOG.md`.

**Sample 1** (lesson or track `fronts-01`)

```json
{
  "prompt": "Tap the nose tackle.",
  "diagram": {
    "diagramId": "football-front-3-4",
    "aspectRatio": 1.2,
    "alt": "Overhead diagram of a 3-4 defense with three linemen and four linebackers."
  },
  "hotspots": [
    {
      "id": "nt",
      "label": "Nose tackle",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.45,
        "r": 0.06
      }
    },
    {
      "id": "de-l",
      "label": "Left defensive end",
      "shape": {
        "kind": "circle",
        "cx": 0.32,
        "cy": 0.45,
        "r": 0.06
      }
    },
    {
      "id": "de-r",
      "label": "Right defensive end",
      "shape": {
        "kind": "circle",
        "cx": 0.68,
        "cy": 0.45,
        "r": 0.06
      }
    },
    {
      "id": "ilb",
      "label": "Inside linebacker",
      "shape": {
        "kind": "circle",
        "cx": 0.42,
        "cy": 0.28,
        "r": 0.06
      }
    }
  ],
  "correctHotspotIds": [
    "nt"
  ],
  "explanation": {
    "correct": "The nose tackle lines up over the center in a 3-4. His job is to eat blockers so the linebackers make plays.",
    "incorrect": "The nose tackle is the middle lineman, right over the center.",
    "sayThisLine": "The nose tackle takes two blockers."
  }
}
```

**Sample 2** (lesson or track `field-02`)

```json
{
  "prompt": "Tap the line of scrimmage.",
  "diagram": {
    "diagramId": "football-field-midfield",
    "aspectRatio": 1.4,
    "alt": "Overhead view of a football field with the ball marked at midfield and yard lines across."
  },
  "hotspots": [
    {
      "id": "los",
      "label": "Line of scrimmage",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.47,
        "w": 0.9,
        "h": 0.06
      }
    },
    {
      "id": "goal",
      "label": "Goal line",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.05,
        "w": 0.9,
        "h": 0.05
      }
    },
    {
      "id": "marker",
      "label": "First-down marker",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.3,
        "w": 0.9,
        "h": 0.05
      }
    }
  ],
  "correctHotspotIds": [
    "los"
  ],
  "explanation": {
    "correct": "The line of scrimmage runs through the ball's tip, side to side. Nobody crosses it before the snap.",
    "incorrect": "The ball's line is the line of scrimmage. The goal line and the first-down line are at other spots.",
    "sayThisLine": "Nobody is past the line of scrimmage."
  }
}
```

**Sample 3** (lesson or track `run-gaps-05`)

```json
{
  "prompt": "Tap the A gap on the left.",
  "diagram": {
    "diagramId": "football-run-gaps",
    "aspectRatio": 1.6,
    "alt": "Overhead diagram of the offensive line with gaps between the linemen labelled with dots."
  },
  "hotspots": [
    {
      "id": "a-l",
      "label": "Left A gap",
      "shape": {
        "kind": "circle",
        "cx": 0.44,
        "cy": 0.5,
        "r": 0.03
      }
    },
    {
      "id": "b-l",
      "label": "Left B gap",
      "shape": {
        "kind": "circle",
        "cx": 0.36,
        "cy": 0.5,
        "r": 0.03
      }
    },
    {
      "id": "c-l",
      "label": "Left C gap",
      "shape": {
        "kind": "circle",
        "cx": 0.28,
        "cy": 0.5,
        "r": 0.03
      }
    },
    {
      "id": "a-r",
      "label": "Right A gap",
      "shape": {
        "kind": "circle",
        "cx": 0.56,
        "cy": 0.5,
        "r": 0.03
      }
    }
  ],
  "correctHotspotIds": [
    "a-l"
  ],
  "explanation": {
    "correct": "The A gap is the space between the center and the guard. A defender assigned there plugs the middle of the run.",
    "incorrect": "Start at the center. The gap right next to him is the A gap; the next one out is B, then C.",
    "sayThisLine": "Their linebacker filled the A gap."
  }
}
```

## 3. Talk Track scenarios

Ten scenarios (target: 10 at launch, 3 more per season). Each row has the enthusiast line, what it means, and three replies. `smoothDelta` mapping: good +25, meh +5, cringe -15. The payloads validate against `talk-track.schema.json`; the first three are shown in 2.7 as samples. Talk-track ids for `curriculum/*.json` `talkTracks[]` are `tt-<slug>`.

### 3.1 `tt-first-text`: Game night text

Setting: She texts you the morning after a big game. Concepts: `follow-up-question`, `listen-first`, `honest-not-expert`. Layer: foundations.

**Exchange 1. She says:** "Did you watch the game last night?? That last drive was unreal."

**What it means:** She is excited about the final possession (a drive, likely a scoring one).

- **Good:** "I only caught the end. What happened on that last drive?" Her reply: "Okay, so they were down four and marched 80 yards. It took like eight minutes." Coach note: *Honest and curious. It invites her to tell the story.*
- **Meh:** "Yeah, crazy game." Her reply: "...You did not watch it, did you?" Coach note: *Vague agreement is easy to spot. Ask something real.*
- **Cringe:** "Yeah, our defense should have blitzed more." Her reply: "We were on offense. Wait, were you even watching?" Coach note: *Faking expertise backfires. Say what you actually saw.*

**Exchange 2. She says:** "Eight minutes and they never punted. The kicker had a chance at the end."

**What it means:** She is describing a long drive that ended with a field goal try.

- **Good:** "Was it a field goal to win, or did they need a touchdown?" Her reply: "Field goal! Thirty-eight yards. I was screaming." Coach note: *Uses the rules you know (field goal, touchdown) to ask a good question.*
- **Meh:** "Nice." Her reply: "Just nice?" Coach note: *A little flat. She gave you a hook, take it.*
- **Cringe:** "Field goals are boring. Go for the touchdown." Her reply: "Sir, it was a 38-yard game winner." Coach note: *Do not argue with a moment she loved.*

### 3.2 `tt-fourth-down`: The fourth-down gripe

Setting: She texts during a game. Concepts: `fourth-down-decision`, `follow-up-question`. Layer: intermediate.

**Exchange 1. She says:** "I cannot believe he punted on fourth and two."

**What it means:** She thinks the coach was too conservative. Fourth and two is a short yardage decision fans think you should go for.

- **Good:** "Fourth and two feels like a go for it. Was he worried about giving up field position?" Her reply: "Exactly! Analytics says go. He never listens." Coach note: *You showed you know why teams debate it.*
- **Meh:** "Maybe the coach had a reason?" Her reply: "He always has a reason. It is always the same reason." Coach note: *Not wrong, but it does not join her frustration.*
- **Cringe:** "Punting is always the safe play, that is smart football." Her reply: "Have you seen the numbers? Nobody thinks that anymore." Coach note: *Old-school certainty on a hot topic is risky. Ask instead.*

### 3.3 `tt-secondary`: The secondary is struggling

Setting: At a bar after a loss. Concepts: `secondary`, `cornerback`, `safety-position`. Layer: foundations.

**Exchange 1. She says:** "Our secondary is absolutely killing us this year."

**What it means:** She means the cornerbacks and safeties are giving up big pass plays.

- **Good:** "Is it the corners getting beat, or the safeties not helping over the top?" Her reply: "Both! Last week the safety bit on a fake and it was a touchdown." Coach note: *Shows you know the secondary has two position groups.*
- **Meh:** "Yeah, that is rough." Her reply: "It is. I hate it." Coach note: *Kind, but it leaves her alone with the topic.*
- **Cringe:** "Just get a better quarterback then." Her reply: "We are talking defense. The quarterback is on offense." Coach note: *Mixing up sides. It is okay to ask instead.*

**Exchange 2. She says:** "The safety was so late. Our corners cannot cover anyone."

**What it means:** She is talking about coverage: are the defenders in man or zone?

- **Good:** "Do you think they play too much zone? Or are they in man and just getting beat?" Her reply: "Man, mostly. That is the frustrating part." Coach note: *Man versus zone is the perfect follow-up.*
- **Meh:** "Sounds tough." Her reply: "It is." Coach note: *Fine. Not memorable.*
- **Cringe:** "Maybe they should blitz every play." Her reply: "That would make it worse." Coach note: *Blitzing leaves corners alone. Save the guess.*

### 3.4 `tt-red-zone`: Stalling near the goal

Setting: During a commercial. Concepts: `red-zone`, `field-goal`, `touchdown`. Layer: intermediate.

**Exchange 1. She says:** "We keep stalling in the red zone and settling for field goals."

**What it means:** The team gets inside the opponent's 20 but only scores three points instead of seven.

- **Good:** "Are they running or throwing down there? Is the field just too short to throw?" Her reply: "Both are bad. The field is short and everyone covers everyone." Coach note: *Uses the red zone idea and asks about it.*
- **Meh:** "Field goals still count." Her reply: "They do. It is just not enough." Coach note: *True, but it dampens her mood.*
- **Cringe:** "Just kick a longer field goal." Her reply: "That is not how it works..." Coach note: *Red zone means the ball is already close. Ask what she sees.*

### 3.5 `tt-tush-push`: The tush push debate

Setting: She brings up a hot topic. Concepts: `tush-push-debate`, `quarterback-sneak`. Layer: enthusiast.

**Exchange 1. She says:** "The tush push should be banned. It is not even football."

**What it means:** She is talking about the quarterback sneak where teammates push him forward. The debate is that it is nearly unstoppable.

- **Good:** "Is it the pushing that bothers you or that nobody can stop it?" Her reply: "Both. It is basically a free first down." Coach note: *Asks what she really cares about.*
- **Meh:** "Some people like it." Her reply: "Sure, if your team does it." Coach note: *Balanced, but not curious.*
- **Cringe:** "It is legal, so it is fine. End of story." Her reply: "Wow. Okay." Coach note: *Shutting down a debate is never smooth.*

### 3.6 `tt-fantasy`: Fantasy heartbreak

Setting: A Sunday morning text. Concepts: `fantasy-football`, `injury-report`. Layer: intermediate.

**Exchange 1. She says:** "My fantasy running back got ruled out an hour before kickoff."

**What it means:** She is annoyed: her player was inactive due to injury, and she has to scramble for a replacement.

- **Good:** "Ugh. Do you have a waiver pickup, or is it time to bench?" Her reply: "I found one! He is the backup for that same team." Coach note: *Uses fantasy words and offers help.*
- **Meh:** "That stinks." Her reply: "It really does." Coach note: *Sympathy is good. Add a question to keep it going.*
- **Cringe:** "That is why I do not play fantasy." Her reply: "...I did not ask." Coach note: *Skip judgments. Sunday mornings are fragile.*

### 3.7 `tt-tough-loss`: After a heartbreaker

Setting: Right after the final whistle. Concepts: `listen-first`, `honest-not-expert`. Layer: conversation.

**Exchange 1. She says:** "I am so mad I cannot even talk about the game."

**What it means:** She lost and needs a moment. You do not need football knowledge here, just care.

- **Good:** "Want to vent, or want to think about anything else for a bit?" Her reply: "Vent. Give me five minutes." Coach note: *Lets her choose. That is the good part.*
- **Meh:** "It is just a game." Her reply: "It is not just a game." Coach note: *Practical, but not what she needs.*
- **Cringe:** "Maybe they will win next week, haha." Her reply: "...This is not funny." Coach note: *Cheering her up too fast can feel dismissive.*

### 3.8 `tt-blitz`: The blitz that sacked him

Setting: Watching together. Concepts: `blitz`, `sack`, `pre-snap-read`. Layer: intermediate.

**Exchange 1. She says:** "That blitz came out of nowhere and he got crushed."

**What it means:** The defense sent extra rushers, and the quarterback was sacked or hit without warning.

- **Good:** "Could he see it coming pre-snap? Was somebody supposed to pick it up?" Her reply: "The running back had to block him and missed. See?" Coach note: *Shows you know about spotting the blitz and who blocks it.*
- **Meh:** "Brutal." Her reply: "Yes." Coach note: *Agreeing is fine. Add a question next time.*
- **Cringe:** "The line is terrible, fire them all." Her reply: "One guy missed a block, chill." Coach note: *Big blame with no evidence sounds like bluffing.*

### 3.9 `tt-rookie`: The rookie quarterback

Setting: She is impressed after a game. Concepts: `quarterback-progression`, `pressure`. Layer: enthusiast.

**Exchange 1. She says:** "The rookie looked so calm against pressure."

**What it means:** She likes how he handled being rushed: getting rid of the ball quickly or moving in the pocket.

- **Good:** "Was he getting the ball out fast, or escaping the rush?" Her reply: "A bit of both. He checks down really fast." Coach note: *Knowing that a quick release or a checkdown is a sign of calm.*
- **Meh:** "He looked good." Her reply: "He did." Coach note: *Agreeing is fine, but it ends there.*
- **Cringe:** "Rookies are always overrated." Her reply: "Well. We will see." Coach note: *A blanket take invites an argument. Ask her what she saw.*

### 3.10 `tt-rankings`: Rankings drama

Setting: A college football Saturday. Concepts: `polls-rankings`, `cfp-format`. Layer: enthusiast.

**Exchange 1. She says:** "We dropped four spots after that loss. The committee is a joke."

**What it means:** She is upset about the playoff committee ranking her team lower after a defeat.

- **Good:** "Does it hurt the playoff chances or is it early enough to recover?" Her reply: "We still control our destiny if we win out." Coach note: *Ties the ranking to the playoff.*
- **Meh:** "Rankings are weird." Her reply: "They really are." Coach note: *True, and a bit too easy.*
- **Cringe:** "Rankings do not matter." Her reply: "They matter when there is a playoff!" Coach note: *They do matter to her. Do not wave it away.*

## 4. Playbook terms

176 concepts (ids used in `conceptIds` throughout the curriculum and sim specs). Example lines are what a friendly fan might say out loud.

| conceptId | Term | Layer | Definition | Example line |
|---|---|---|---|---|
| `end-zone` | End zone | foundations | The 10-yard area at each end of the field. Get the ball into the other team's end zone and it is a touchdown. | "He got both feet in the end zone. Six points." |
| `line-of-scrimmage` | Line of scrimmage | foundations | The imaginary line where the ball sits before each play. Nobody may cross it before the snap. | "Their guy jumped over the line of scrimmage. Flag." |
| `field-position` | Field position | foundations | Where the ball sits on the 100-yard field. The closer to the other end zone, the fewer yards you need to score. | "Starting at midfield is a gift." |
| `downs` | Downs | foundations | The offense gets four plays (downs) to gain 10 yards. Gain them and the count resets to first down. | "They have to go for it on fourth down." |
| `first-down-marker` | First-down marker | foundations | The yellow line on TV and the orange pylon-and-chain on the field that show where 10 yards ends. | "He was short of the marker by an inch." |
| `first-down` | First down | foundations | A fresh set of four downs, earned by gaining 10 yards or more. | "That is a first down. Four more tries." |
| `down-and-distance` | Down and distance | foundations | The count of the current try and yards still needed, said like third and seven. | "Third and seven, they have to throw." |
| `game-clock` | Game clock | foundations | Sixty minutes of playing time in four quarters. The clock stops often, so games take about three hours. | "They are just trying to run out the clock." |
| `play-clock` | Play clock | foundations | The 40-second countdown (25 after some stoppages) to snap the ball. Miss it and it is delay of game. | "Snap it! The play clock is dying." |
| `timeout` | Timeout | foundations | A pause each team can call, three per half, to stop the clock and regroup. | "He burned a timeout just to think." |
| `touchdown` | Touchdown | foundations | Six points for getting the ball into the end zone, by carrying it in or catching it there. | "Touchdown! Six points and a shot at the extra one." |
| `field-goal` | Field goal | foundations | Three points for kicking the ball through the uprights, usually on fourth down. | "Just take the three and kick the field goal." |
| `extra-point` | Extra point | foundations | One point for a kick after a touchdown, snapped from the 15-yard line (a 33-yard kick). | "The extra point is good, seven total." |
| `two-point-conversion` | Two-point conversion | foundations | After a touchdown, run or pass it in from the 2-yard line for two points instead of kicking. | "They are going for two. Bold." |
| `safety-score` | Safety (score) | foundations | Two points for the defense when the offense is tackled in its own end zone. The scorers also get the ball back. | "A safety! Two points and we get the ball." |
| `turnover` | Turnover | foundations | When the offense loses the ball to the defense by interception or fumble. | "That turnover flipped the whole game." |
| `interception` | Interception | foundations | A pass caught by a defender. The defense takes over the ball. | "He got picked off. He never saw the linebacker." |
| `fumble` | Fumble | foundations | The ball carrier loses control of the ball. Either team can recover it. | "Fumble! The ball is loose, who has it?" |
| `punt` | Punt | foundations | A kick on fourth down that sends the ball to the other team as far downfield as possible. | "They punted. It was fourth and long anyway." |
| `drive` | Drive | foundations | One offensive possession from getting the ball until scoring, punting or turning it over. | "That was a 14-play, seven-minute drive." |
| `possession` | Possession | foundations | Which team has the ball. The other team is on defense. | "We finally have possession again." |
| `quarterback` | Quarterback | foundations | The player who runs the offense: takes the snap, then throws or hands off. | "Their quarterback looks calm under pressure." |
| `running-back` | Running back | foundations | Lines up behind the quarterback; runs the ball, catches passes, sometimes blocks. | "The running back found a hole." |
| `wide-receiver` | Wide receiver | foundations | Lines up wide and runs routes to catch passes. | "Their number-one receiver is a problem." |
| `tight-end` | Tight end | foundations | A hybrid who blocks like a lineman and catches like a receiver. | "Tight end is both jobs at once." |
| `offensive-line` | Offensive line | foundations | Five big players (center, two guards, two tackles) who block for the run and protect the quarterback. | "The O-line gave him all day to throw." |
| `defensive-line` | Defensive line | foundations | The front players (tackles and ends) who rush the passer and stop runs. | "Their D-line is eating us alive." |
| `linebacker` | Linebacker | foundations | Defenders behind the line who stop runs, rush the passer and cover backs and tight ends. | "The linebacker read that play perfectly." |
| `cornerback` | Cornerback | foundations | A defensive back who lines up wide and covers receivers. | "Their corner is glued to him." |
| `safety-position` | Safety (position) | foundations | The deepest defenders, the last line against big plays. Free safety and strong safety. | "Our safeties keep biting on the fake." |
| `secondary` | Secondary | foundations | The defensive backs: cornerbacks and safeties who cover receivers. | "Our secondary is getting torched." |
| `special-teams-unit` | Special teams | foundations | Kickoffs, punts, field goals and returns: the third phase of the game. | "Special teams cost us that game." |
| `eligible-receiver` | Eligible receiver | foundations | The players allowed to catch a forward pass: backs, receivers and tight ends, identified by number and alignment. | "He was not eligible, so it is a penalty." |
| `jersey-numbers` | Jersey numbers | foundations | Numbers loosely signal position groups, for example quarterbacks 1-19 and linemen 50-79. | "Number 87 must be a tight end or receiver." |
| `coordinators` | Coordinators | foundations | The head coach runs the team; the offensive (OC) and defensive coordinator (DC) design and often call the plays. | "Fire the offensive coordinator, that play call was awful." |
| `depth-chart` | Depth chart | foundations | A ranking of players at each position: starters, then backups. | "He is second on the depth chart now." |
| `strong-safety` | Strong safety | intermediate | The safety who lines up on the tight end side and helps against the run and short passes. | "The strong safety came up to stop the run." |
| `formation` | Formation | foundations | How the 11 offensive players line up before the snap. | "Five wide, empty backfield. They are throwing." |
| `personnel-grouping` | Personnel grouping | foundations | A two-digit code: running backs first, then tight ends. 11 means one back, one tight end, three receivers. | "They are in 11 personnel, three receivers." |
| `shotgun` | Shotgun | foundations | The quarterback lines up several yards behind the center. Common on passing downs. | "Shotgun on third and long. Pass." |
| `under-center` | Under center | foundations | The quarterback takes the snap directly from the center. Common for runs and play-action. | "Under center on third and one. Sneak?" |
| `route-tree` | Route tree | foundations | The menu of pass routes, numbered by depth and break angle: slant, out, curl, post, corner, go. | "Slant, post, corner. It is all the route tree." |
| `slant-route` | Slant route | foundations | A quick diagonal cut toward the middle after one to three steps. | "Quick slant for the first down." |
| `go-route` | Go route | foundations | A straight sprint down the field; the deep shot. | "He is just running a go, throw it up." |
| `out-route` | Out route | foundations | Run about 8 to 10 yards, then cut sharply to the sideline. | "Out route to the sideline to stop the clock." |
| `post-route` | Post route | foundations | Run deep, then cut diagonally toward the goalposts. | "The post was wide open." |
| `curl-route` | Curl route | foundations | Run downfield, then turn back toward the quarterback to settle in a gap. | "He sat down in the zone on a curl." |
| `screen-pass` | Screen pass | foundations | A short pass behind the line with blockers set up in front, meant to punish an aggressive rush. | "The screen killed their blitz." |
| `play-action` | Play-action | foundations | Fake a handoff, then throw. It freezes linebackers and opens space behind them. | "Play-action fooled the whole defense." |
| `run-pass-option` | Run-pass option (RPO) | foundations | One snap, and the quarterback chooses to hand off or throw after reading one defender. | "That RPO puts the linebacker in a bind." |
| `pre-snap-motion` | Pre-snap motion | foundations | A player moves before the snap to reveal the coverage or create a mismatch. | "Watch the motion. The corner followed him, so it is man." |
| `audible` | Audible | foundations | The quarterback changes the play at the line after reading the defense. | "He audibled out of that play." |
| `no-huddle` | No-huddle | foundations | Skipping the huddle to speed up tempo and limit defensive substitutions. | "They went no-huddle and gassed the defense." |
| `hot-route` | Hot route | intermediate | A receiver changes his route on the fly, usually to beat a blitz. | "Hot route to the slant, that is a beaten blitz." |
| `checkdown` | Checkdown | intermediate | A safe short throw to the running back when the deeper options are covered. | "He took the checkdown. Fine, not exciting." |
| `four-three-front` | 4-3 front | foundations | Four defensive linemen and three linebackers. | "They are in a base 4-3." |
| `three-four-front` | 3-4 front | foundations | Three linemen and four linebackers, with the extra linebackers rushing from the edge. | "In a 3-4 the outside linebackers are the pass rushers." |
| `man-coverage` | Man coverage | foundations | Each defender shadows one receiver wherever he goes. | "If it is man, the corner follows him everywhere." |
| `zone-coverage` | Zone coverage | foundations | Defenders guard areas of the field instead of specific players. | "They are in zone, so sit down in the hole." |
| `zone-vs-man` | Zone versus man | foundations | The core coverage distinction: guard an area, or guard a person. Everything else builds on it. | "Is that man or zone? I could not tell." |
| `cover-0` | Cover 0 | intermediate | Man coverage with no deep safety help, usually paired with an all-out blitz. High risk, high reward. | "Cover 0 means one miss is a touchdown." |
| `cover-1` | Cover 1 | intermediate | Man coverage underneath with one deep safety (single-high). | "One deep safety, that is Cover 1." |
| `cover-2` | Cover 2 | intermediate | Two safeties split the deep field into halves while corners guard the flats. The hole is between corner and safety. | "They are in Cover 2, so throw to the seam." |
| `cover-3` | Cover 3 | intermediate | A zone where three defenders split the deep field into thirds. | "They are sitting in Cover 3 and giving up the short stuff." |
| `cover-4` | Cover 4 | intermediate | Also called quarters: four defenders each take a deep quarter of the field. | "Quarters is why nobody got behind them." |
| `blitz` | Blitz | foundations | Sending more than the usual four pass rushers, often a linebacker or defensive back. | "He blitzed and got home." |
| `pass-rush` | Pass rush | foundations | The defensive line and rushers attacking the quarterback. | "Their pass rush is the reason we lost." |
| `sack` | Sack | foundations | Tackling the quarterback behind the line of scrimmage for a loss of yards. | "Sack! That is second and long now." |
| `pressure` | Pressure | intermediate | Hurrying or hitting the quarterback, even without a sack. Fans and analysts track pressure rate. | "He was under pressure all night." |
| `nickel` | Nickel | intermediate | Five defensive backs, the standard answer to three-receiver sets. | "Nickel is basically their base defense now." |
| `press-coverage` | Press coverage | intermediate | A corner lines up right on the receiver and jams him at the line. | "Press coverage, the corner is in his face." |
| `run-gap` | Run gap | intermediate | The spaces between blockers (A between center and guard, B guard to tackle, C outside the tackle) that defenders are assigned to fill. | "The linebacker lost his gap and the back got out." |
| `disguise` | Disguise | intermediate | Showing one coverage before the snap and rotating into another after. | "They disguised it beautifully, looked like Cover 2 and turned into Cover 3." |
| `edge-rusher` | Edge rusher | intermediate | An outside pass rusher, among the most valuable players on defense. | "Their edge rusher is a monster." |
| `stunt` | Stunt | intermediate | Two rushers swap lanes to confuse the blockers. | "That stunt freed up the guy inside." |
| `offside` | Offside | intermediate | A defender is across the line of scrimmage when the ball is snapped. Five yards. | "Offside on the defense, five yards." |
| `false-start` | False start | intermediate | An offensive player moves before the snap, and the play is dead. Five yards. | "False start again? Their tackle is jumpy." |
| `holding` | Holding | intermediate | Illegally grabbing a player. Ten yards on offense; five yards and an automatic first down on defense. | "That was holding, ten yards, brings it back." |
| `pass-interference` | Pass interference | intermediate | Illegal contact with a receiver before the ball arrives. In the NFL it is a spot foul. | "That should have been pass interference." |
| `roughing-the-passer` | Roughing the passer | intermediate | An illegal hit on the quarterback: 15 yards and an automatic first down. | "Roughing the passer is a free first down." |
| `targeting` | Targeting | intermediate | College penalty: forcible contact to the head or neck of a defenseless player. Ejection when confirmed. | "They reviewed it for targeting, that is an ejection." |
| `hip-drop-tackle` | Hip-drop tackle | intermediate | A tackle where the defender swivels his hips and drops his weight onto the runner's legs. Banned by the NFL from 2024. | "That is a hip-drop, fifteen yards." |
| `intentional-grounding` | Intentional grounding | intermediate | Throwing the ball away with no receiver nearby to dodge a sack. Loss of down and yardage. | "That is intentional grounding, no one was near it." |
| `delay-of-game` | Delay of game | intermediate | The offense fails to snap before the play clock hits zero. Five yards. | "Delay of game. They lost track of the clock." |
| `catch-rule` | What is a catch | intermediate | A receiver must control the ball, get both feet (or another body part) down inbounds, and make a football move. | "Was that a catch? The rule is so confusing." |
| `replay-review` | Replay review | intermediate | Scoring plays and turnovers are automatically reviewed; coaches can challenge other calls with a red flag. | "He threw the red flag. He is challenging it." |
| `penalty-options` | Accept or decline | intermediate | The team that did not commit the foul may accept the penalty or decline it and keep the play result. | "They declined the penalty because the play was better." |
| `illegal-formation` | Illegal formation | intermediate | The offense must have seven players on the line of scrimmage and only certain players may be eligible receivers. | "Illegal formation, they only had six on the line." |
| `kickoff` | Kickoff | intermediate | A kick that starts each half and follows every score. | "Kickoff to start the second half." |
| `dynamic-kickoff` | Dynamic kickoff | intermediate | The modern kickoff: the kicking team lines up at the receiving team's 40, with a setup zone and a landing zone to create more returns and fewer injuries. | "The new kickoff is why returns are back." |
| `touchback` | Touchback | intermediate | The ball is dead in the end zone and the receiving team starts at a set spot: the 35 after a kickoff (2025 rule), the 20 after a punt. | "He took the touchback, starts at the 35." |
| `fair-catch` | Fair catch | intermediate | The returner waves an arm, cannot be hit, and cannot run the ball back. | "He signaled for a fair catch." |
| `onside-kick` | Onside kick | intermediate | A short kick the kicking team tries to recover. Since 2026 a team can declare one at any time. | "They are trying an onside kick, this is desperate." |
| `field-goal-range` | Field-goal range | intermediate | Roughly inside the opponent's 35, where a kicker makes most attempts. Attempt length is about 17 yards more than the yard line. | "That is 55 yards, that is a long field goal." |
| `coffin-corner` | Coffin corner | intermediate | A punt aimed out of bounds near the goal line so the returner cannot use it. | "Great coffin-corner punt." |
| `fourth-down-decision` | Fourth-down decision | intermediate | Go for it, punt or kick a field goal. The most argued choice in football. | "Go for it! Why did he punt?" |
| `red-zone` | Red zone | intermediate | Inside the opponent's 20-yard line, where the field shrinks and scoring gets harder. | "We stall every time in the red zone." |
| `third-down` | Third down | intermediate | The make-or-break down. Convert and the drive lives; fail and it is a punt or fourth-down gamble. | "The defense needs one stop on third down." |
| `two-minute-drill` | Two-minute drill | intermediate | The hurry-up offense before halftime or the end of the game, saving the clock with sideline throws and timeouts. | "Two-minute drill, can they get a field goal?" |
| `clock-management` | Clock management | intermediate | Using timeouts, out-of-bounds plays and running plays to control how much time is left. | "Awful clock management, he left time on the clock." |
| `victory-formation` | Victory formation | intermediate | The kneel-down: the quarterback takes the snap and drops to a knee to run out the clock. | "They are kneeling. Game over." |
| `overtime` | Overtime | intermediate | Extra period when tied. NFL regular season: 10 minutes, and since 2025 both teams get a possession like the playoffs. | "Overtime! Both teams get the ball now." |
| `conference-division` | Conference and division | intermediate | Two conferences (AFC and NFC), four divisions each, four teams per division. Division rivals play twice a year. | "That is a division game, it matters more." |
| `seventeen-game-season` | 17-game season | intermediate | Each team plays 17 games over 18 weeks with one bye week. | "Seventeen games, plus one bye." |
| `playoff-seeding` | Playoff seeding | intermediate | Seven teams per conference: four division winners then three wild cards. Only the number-one seed gets a first-round bye. | "We need the number-one seed for the bye." |
| `draft` | NFL Draft | intermediate | Seven rounds each April where teams select college players, worst records picking first. | "Bad team, top pick. That is the draft." |
| `salary-cap` | Salary cap | intermediate | The league-wide limit on what a team can spend on player salaries. | "They are cap-strapped so they cut him." |
| `free-agency` | Free agency | intermediate | Players whose contracts ended can sign with any team, opening each March. | "He hit free agency and signed for a fortune." |
| `franchise-tag` | Franchise tag | intermediate | A one-year, high-salary contract a team can force on a key player to keep him. | "They franchise-tagged him rather than lose him." |
| `practice-squad` | Practice squad | intermediate | Extra players a team keeps for practice who can be signed to the active roster. | "He was on the practice squad and got called up." |
| `injured-reserve` | Injured reserve | intermediate | A list for injured players who miss at least several weeks and free up a roster spot. | "He is on IR for the year." |
| `roster-53` | 53-man roster | intermediate | The active roster: 53 players, of whom 48 dress for a game. | "They cut down to 53." |
| `trade-deadline` | Trade deadline | intermediate | The date after which teams cannot make trades until the new league year. | "Trade deadline is Tuesday, watch for a move." |
| `bye-week` | Bye week | intermediate | The week off in the schedule, plus a chance to rest and heal. | "Bye week, so no game to stress about." |
| `fantasy-football` | Fantasy football | intermediate | A game where fans draft real players and score points from their real stats each week. | "My fantasy team needs a big week from him." |
| `primetime-games` | Primetime games | intermediate | Nationally televised night games: Thursday, Sunday and Monday night. | "Sunday Night Football is our game this week." |
| `zone-blocking` | Zone blocking | intermediate | Linemen block an area together and the back picks his hole, rather than each having a specific target. | "Zone blocking is why he cut back." |
| `gap-scheme` | Gap scheme | intermediate | Blocking where each lineman has an assigned gap, often with a puller leading the way: power and counter. | "Power is a gap scheme, a guard pulls." |
| `pulling-guard` | Pulling guard | intermediate | A lineman who steps back and runs across the formation to lead block. | "The pulling guard cleared the corner." |
| `inside-zone` | Inside zone | intermediate | The staple run: the back reads the blockers and takes the first crease, mainly between the tackles. | "Inside zone up the middle again." |
| `outside-zone` | Outside zone | intermediate | The back stretches the play sideways, then plants and cuts upfield through a lane. | "Outside zone, stretch it, then cut." |
| `protection-scheme` | Pass protection scheme | intermediate | How the line and backs divide up the rushers: man, zone-slide, or a mix. The center calls the protection. | "The center pointed out the Mike." |
| `pre-snap-read` | Pre-snap read | intermediate | What the quarterback identifies before the snap: safeties, corner leverage, box count, and blitz threats. | "He saw the blitz pre-snap and changed it." |
| `route-combination` | Route combination | intermediate | Two or more routes designed to beat a coverage together, like mesh, flood, or smash. | "That flood concept overloaded the zone." |
| `quarterback-progression` | Quarterback progression | intermediate | The order in which the quarterback checks receivers: first read, second read, checkdown. | "He went through his progression and found the third read." |
| `passing-window` | Passing window | intermediate | The gap between defenders where the ball can be completed. It opens and closes in tenths of a second. | "The window was tiny but he threaded it." |
| `anticipation-throw` | Anticipation throw | intermediate | Throwing before the receiver breaks, to where he will be, to beat the defender. | "That anticipation throw was perfect." |
| `back-shoulder-throw` | Back-shoulder throw | intermediate | A throw placed on the receiver's back shoulder so only he can catch it against tight coverage. | "Back-shoulder throw, the corner had no play." |
| `yards-after-catch` | Yards after catch | intermediate | Yards gained after the reception; a mark of a dangerous receiver. | "He gets so many yards after catch." |
| `quarterback-sneak` | Quarterback sneak | intermediate | A quick surge behind the center by the quarterback on short yardage, including the tush push. | "The tush push is just a quarterback sneak with a shove." |
| `west-coast-offense` | West Coast offense | enthusiast | A timing-based passing system using short, quick throws as a substitute for runs. Bill Walsh popularized it. | "It is a West Coast offense, lots of short passes." |
| `air-raid` | Air Raid | enthusiast | A pass-heavy system with spread formations and simple, repeated concepts. Mike Leach and Hal Mumme. | "College Air Raid is why teams throw 50 times." |
| `shanahan-zone-scheme` | Outside-zone play-action scheme | enthusiast | The Shanahan tree offense: outside zone, then play-action off the same look. | "The Shanahan offense looks like zone, then a bootleg." |
| `match-coverage` | Match coverage | enthusiast | A zone that turns into man once receivers enter an area. Modern defense blends both. | "It looks like zone but it is really match coverage." |
| `tampa-2` | Tampa 2 | enthusiast | A Cover 2 where the middle linebacker drops deep to cover the hole between the safeties. | "The Tampa 2 is why they beat the deep pass." |
| `zone-blitz` | Zone blitz | enthusiast | Rush a linebacker or defensive back while a lineman drops into coverage. | "They zone-blitzed, the lineman dropped back." |
| `two-high-shell` | Two-high shell | enthusiast | Two safeties deep before the snap, either Cover 2, Cover 4, or a disguise. | "Two-high, so run it." |
| `single-high-shell` | Single-high shell | enthusiast | One deep safety before the snap: Cover 1 or Cover 3. | "Single-high means they are stacking the box." |
| `light-box` | Light box | enthusiast | Fewer than seven defenders near the line of scrimmage, so running is easier. | "They are in a light box, hand it off." |
| `mismatch` | Mismatch | enthusiast | A player facing an opponent he is much better against, such as a fast tight end on a linebacker. | "They found a mismatch with the tight end." |
| `epa` | Expected points added | enthusiast | A stat measuring how much each play changes the team's expected scoring. Positive helps. | "His EPA per play is elite." |
| `success-rate` | Success rate | enthusiast | The share of plays that keep the offense on schedule: about 40 percent of needed yards on first down, 60 on second, all on third. | "Success rate says the offense is fine." |
| `rb-value-debate` | Running back value debate | enthusiast | The argument over whether running backs are worth big contracts given short careers and easy replacement. | "Paying a running back that much? That is the whole debate." |
| `qb-wins` | Quarterback wins | enthusiast | Crediting the quarterback with the team's record; a widely disputed stat. | "Quarterback wins is not a real stat." |
| `kickoff-debate` | Kickoff debate | enthusiast | Whether the kickoff is too dangerous to keep, and how far to change it, versus tradition. | "The kickoff debate never ends." |
| `tush-push-debate` | Tush push debate | enthusiast | Whether the shove-assisted quarterback sneak should be banned. A 2025 vote failed 22-10, short of the 24 needed. | "The tush push is unfair, or unstoppable?" |
| `concussion-protocol` | Concussion protocol | enthusiast | The league procedure to remove and clear players after a suspected head injury. | "He is in the concussion protocol, he is out." |
| `hail-mary` | Hail Mary | enthusiast | A desperate long pass into a crowded end zone, usually as time expires. | "That Hail Mary was pure luck." |
| `super-bowl` | Super Bowl | enthusiast | The NFL championship game, held each February since the 1966 season. The winner takes the Lombardi Trophy. | "They are in the Super Bowl this year." |
| `nfl-afl-merger` | NFL-AFL merger | enthusiast | The 1966 agreement combining two rival leagues, creating the conferences and the Super Bowl. | "The AFC used to be the AFL." |
| `dynasty` | Dynasty | enthusiast | A team that dominates for years, such as the 1970s Steelers or the 2000s-2010s Patriots. | "Dynasty talk always starts with the Patriots." |
| `iconic-play-lore` | Iconic play lore | enthusiast | The famous plays fans reference: the Immaculate Reception, the Catch, the Helmet Catch, the Philly Special. | "Everyone brings up the Immaculate Reception." |
| `hall-of-fame` | Hall of Fame | enthusiast | The Pro Football Hall of Fame in Canton, Ohio; its yearly class is a big argument each February. | "He is a first-ballot Hall of Famer." |
| `college-overtime` | College overtime | intermediate | Each team gets the ball at the opponent's 25 for one untimed possession in alternating rounds; from the third round, two-point tries only. | "College overtime is just a shootout." |
| `college-clock-rules` | College clock rules | intermediate | The clock stops on a first down only briefly; the college clock also stops after incomplete passes and out of bounds. | "In college the clock runs more." |
| `college-catch-rule` | College catch rule | intermediate | A college receiver needs only one foot inbounds, not two. | "It is one foot in college, two in the NFL." |
| `conference-realignment` | Conference realignment | enthusiast | The ongoing reshuffling of college conferences, with the SEC and Big Ten now dominant. | "Realignment ruined the old rivalries." |
| `cfp-format` | College Football Playoff | enthusiast | A 12-team playoff: four conference champions and the highest-ranked Group of 6 champion get bids, top four seeds get byes. | "We need to finish in the top four for the bye." |
| `transfer-portal` | Transfer portal | enthusiast | The system that lets college players transfer freely and immediately; rosters turn over every year. | "Half his roster is new from the portal." |
| `nil-revenue-sharing` | NIL and revenue sharing | enthusiast | Name, image and likeness deals, and since 2025 direct revenue sharing, paying college athletes. | "NIL is why the best players stay in school." |
| `heisman` | Heisman Trophy | enthusiast | The annual award for the most outstanding player in college football. | "He is a Heisman contender." |
| `bowl-games` | Bowl games | enthusiast | Postseason college games; the biggest are New Year's Six bowls and the playoff. | "Bowl season is just football all December." |
| `polls-rankings` | Polls and rankings | enthusiast | Weekly rankings (AP poll, Coaches poll, and the playoff committee) that shape the playoff race. | "We dropped in the rankings after that loss." |
| `rivalry-game` | Rivalry game | enthusiast | A yearly game with deep history where records do not matter: Ohio State-Michigan, Iron Bowl, Army-Navy. | "In a rivalry game you throw out the records." |
| `recruiting` | Recruiting | enthusiast | How colleges land high school players, ranked with stars, with national signing days. | "Their recruiting class is the best in the country." |
| `team-identity` | Team identity | enthusiast | What a team is known for: its scheme, star players and fan culture. Personalized per team. | "What is your team's whole identity?" |
| `divisional-rivals` | Divisional rivals | enthusiast | The three teams in your division that you play twice each year. | "Beat your divisional rivals or forget the playoffs." |
| `tailgating` | Tailgating | enthusiast | Pre-game parties in the parking lot, with food, music and games. A core fan ritual. | "I will bring a cooler to the tailgate." |
| `injury-report` | Injury report | current-season | The weekly official listing of who is out, doubtful, questionable or full-participation. | "He is listed as questionable, so who knows." |
| `playoff-picture` | Playoff picture | current-season | Who is in, who is out and what each team needs, updated weekly. | "We need the tiebreaker to get in." |
| `tiebreakers` | Tiebreakers | current-season | The rules to rank teams with equal records: head-to-head, division record and more. | "We win the head-to-head tiebreaker." |
| `power-rankings` | Power rankings | current-season | Media rankings of teams by current strength rather than record. | "We are third in the power rankings." |
| `rule-change-of-year` | Rule change of the year | current-season | The yearly rules tweaks approved each spring. Includes the 2026 kickoff and officiating changes. | "The new kickoff rule changes things." |
| `follow-up-question` | Follow-up question | conversation | A specific, curious question that shows you listened and want to learn more. | "Why do you think the defense keeps collapsing on third down?" |
| `listen-first` | Listen first | conversation | Respond to what they said before adding your own opinion; the base skill of good conversation. | "Wait, tell me what you saw on that play." |
| `honest-not-expert` | Honest, not expert | conversation | Admit what you do not know and ask. Faking expertise is easy to spot and loses trust. | "I do not know that term, teach me?" |

## 5. Authoring checklist

- Every `conceptId` exists in the Playbook table.
- Prompt <= 12 words; explanation gives the reason.
- NFL vs college stated when they differ.
- All images/audio carry `license` `original-swoond` (or another registry id) and an `alt`/`description`.
- No team names except in personalization tokens (`{{team}}`, `{{player}}`) and only as text.
- Voice review: cheeky coach, warm, never condescending, never about the crush.
- Run `cd tools/validate && node validate.mjs` after moving items into `curriculum/*.json`.
