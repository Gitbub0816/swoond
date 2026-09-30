# Native Exercise Plan: Basketball (`basketball`)

Tier B plan for the Basketball course. Payload contracts: `docs/contracts/native-exercises/v1/<type>.schema.json`; behavior: `docs/native-exercises/CATALOG.md`. Every sample payload below is a valid payload for its type (checked against the schema with ajv while this file was generated) and is ready to be copied into `curriculum/*.json` as `activity.payload` (add `id`, `type`, `conceptIds`). Tier A sims are in `sims/`.

Conventions used in every item: prompt of 12 words or fewer; the app adds the "Nice read." / "Not quite." titles, so bodies never repeat them; every answer teaches how it works; no player photos, team logos or league marks (text names only); diagrams are procedural (`bball-half-court`, `bball-full-court`); all illustrations are original (`swoond-original-illustration`).

Procedural diagram coordinate convention for `bball-half-court` (used by binary-call and hotspot-tap): x = 0 (left sideline) to 1 (right sideline) across 50 ft; y = 0 (half-court line) to 1 (baseline) across 47 ft; the rim center is at (0.5, 0.888); the free-throw line is at y = 0.596; the lane spans x 0.34 to 0.66; the restricted-area arc has radius 4 ft (about 0.08 of the width). `bball-full-court` is the same convention over 94 ft (y = 0 one baseline, y = 1 the other, half-court at y = 0.5).

## 1. Native types used and volume

Types not used: `listening-id` (no licensable audio that teaches a concept better than text; crowd and whistle audio has no learning value here).

| Type | Why this course uses it | Planned count (whole course) |
|---|---|---|
| `multiple-choice` | Default recall and understanding check; every lesson uses it for terms, rules and "which is true" checks. | ~262 |
| `binary-call` | A rule with a clear two-way answer on a static diagram (charge or no charge, violation or legal). Static scenes are enough; the moving version lives in the Unity charge/block sim. | ~29 |
| `term-match` | Introducing 3-5 terms of one topic (court words, coverages, cap words). | ~34 |
| `sequence-order` | Processes whose order is the lesson: possession flow, Play-In bracket, tournament path. | ~16 |
| `visual-id` | Referee signals only, using original Swoon'd illustrations (license `swoond-original-illustration`). No photos of players, no logos. | ~4 |
| `decision-scenario` | Judgment from facts: end-of-game fouling, timeout calls, cap-constrained trades. Not gamified beyond best/acceptable/poor because the honest answer is "it depends". | ~24 |
| `talk-track` | Conversation practice: unit-end lessons, the Talk tab and Conversation Lab. | ~31 |
| `timing-tap` | 1D timing feel: two-for-one window, late-clock start, inbound count. Timing does not depend on a 3D scene here, so it stays native. | ~4 |
| `say-this` | "What is she talking about?" Decode fan lines. The single most important type for this course. | ~149 |
| `fill-the-gap` | Vocabulary in context and quick review cards. | ~13 |
| `estimate-slider` | Magnitudes: court distances, points per shot, possessions per game, offensive rating math. | ~20 |
| `hotspot-tap` | Locations on a procedural half-court: corner three, nail, elbow, shot-chart zones. | ~21 |

Total native activities planned: about 607 across 114 lessons (plus 9 Unity sim launches).

## 2. Sample items per type

### 2.1 `multiple-choice`

Default recall and understanding check; every lesson uses it for terms, rules and "which is true" checks. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 5.

**Two steps after the dribble** (`mc-gather-step`; lesson `rul-01`; conceptIds `traveling`, `gather-step`)

```json
{
  "prompt": "She stops her dribble, then takes two steps. Legal?",
  "options": [
    {
      "id": "yes-gather",
      "text": "Yes, the gather step plus two steps",
      "explanation": "The gather is the step where the ball is secured. Then two more steps are allowed."
    },
    {
      "id": "no-one",
      "text": "No, only one step is allowed",
      "explanation": "One step is not the rule in any league."
    },
    {
      "id": "no-zero",
      "text": "No, she must pass or shoot immediately",
      "explanation": "Players may take steps after the ball is gathered."
    },
    {
      "id": "depends-ref",
      "text": "It depends on the arena",
      "explanation": "Rules do not change by arena. Enforcement can feel loose, which is why fans argue."
    }
  ],
  "correctOptionIds": [
    "yes-gather"
  ],
  "shuffle": true,
  "explanation": {
    "correct": "After a player gathers the ball, two more steps are allowed. The gather step is the catch-up beat, so a move can look like three steps and still be legal.",
    "incorrect": "The rule is a gather step plus two steps. The gather is easy to miss because it happens as the ball is secured, which is why travel calls start so many arguments.",
    "sayThisLine": "\"Wait, was that a gather step or a travel?\""
  }
}
```

**What makes the cap soft** (`mc-soft-cap`; lesson `lea-07`; conceptIds `salary-cap`, `soft-cap`, `bird-rights`)

```json
{
  "prompt": "What makes the NBA salary cap \"soft\"?",
  "options": [
    {
      "id": "exceptions",
      "text": "Teams can exceed it using exceptions and Bird rights",
      "explanation": "Re-signing your own player is the classic way to go over."
    },
    {
      "id": "never-exceed",
      "text": "Teams may never go over it",
      "explanation": "That is a hard cap, the NFL-style idea people often assume."
    },
    {
      "id": "per-game",
      "text": "It changes every game",
      "explanation": "The cap is set once a year from league revenue."
    },
    {
      "id": "stars-only",
      "text": "It only counts the top three players",
      "explanation": "Every contract counts."
    }
  ],
  "correctOptionIds": [
    "exceptions"
  ],
  "shuffle": true,
  "explanation": {
    "correct": "Exceptions and Bird rights let teams go over the cap to keep their own players. Then the luxury tax and aprons act as the guardrails.",
    "incorrect": "A soft cap can be exceeded through specific tools like Bird rights. The luxury tax and the aprons are the real brakes, not a hard ceiling.",
    "sayThisLine": "\"So they can go over the cap to keep him. Is that what Bird rights means?\""
  }
}
```

**After an offensive board** (`mc-shot-clock-reset`; lesson `act-08`; conceptIds `shot-clock`, `shot-clock-reset`)

```json
{
  "prompt": "Offensive rebound. What happens to the NBA shot clock?",
  "options": [
    {
      "id": "to-14",
      "text": "It resets to 14 seconds",
      "explanation": "A shorter reset rewards the offensive rebound without a fresh full clock."
    },
    {
      "id": "to-24",
      "text": "It resets to a full 24",
      "explanation": "That was the old rule."
    },
    {
      "id": "keeps-running",
      "text": "It keeps running from where it was",
      "explanation": "It resets after the ball hits the rim."
    },
    {
      "id": "off",
      "text": "The shot clock turns off",
      "explanation": "The clock stays on in the half court."
    }
  ],
  "correctOptionIds": [
    "to-14"
  ],
  "shuffle": true,
  "explanation": {
    "correct": "The NBA resets to 14 after an offensive rebound. Teams now get a quick second-chance action rather than a whole new possession.",
    "incorrect": "The NBA changed the offensive rebound reset to 14 seconds. That is why put-backs and quick kick-outs are the standard move now.",
    "sayThisLine": "\"Fourteen on the reset, right? So they have to hurry the second try.\""
  }
}
```

**Is zone legal in the NBA** (`mc-zone-legal`; lesson `def-03`; conceptIds `zone-defense`, `defensive-three-seconds`)

```json
{
  "prompt": "Which statement about zone defense in the NBA is true?",
  "options": [
    {
      "id": "legal-with-rule",
      "text": "It is legal, with a defensive three-second rule",
      "explanation": "Defenders cannot camp in the paint forever."
    },
    {
      "id": "banned",
      "text": "It is banned",
      "explanation": "That was true until 2001."
    },
    {
      "id": "playoffs-only",
      "text": "It is only legal in the playoffs",
      "explanation": "No such split exists."
    },
    {
      "id": "once-per-game",
      "text": "Each team may use it once per game",
      "explanation": "There is no usage limit."
    }
  ],
  "correctOptionIds": [
    "legal-with-rule"
  ],
  "shuffle": true,
  "explanation": {
    "correct": "Zone has been legal since 2001, with a defensive three-second rule that keeps defenders from parking in the lane.",
    "incorrect": "Zone became legal in 2001. The defensive three-second call stops a big from sitting in the paint without guarding anyone.",
    "sayThisLine": "\"They can play zone now? Is that the 2-3 thing?\""
  }
}
```

**What a sweep is** (`mc-sweep`; lesson `lea-04`; conceptIds `sweep`, `best-of-seven`)

```json
{
  "prompt": "In a best-of-seven series, what is a sweep?",
  "options": [
    {
      "id": "four-zero",
      "text": "Winning the series 4-0",
      "explanation": "Four wins, no losses."
    },
    {
      "id": "four-three",
      "text": "Winning the series 4-3",
      "explanation": "That is a seven-game series."
    },
    {
      "id": "first-round",
      "text": "Any first-round win",
      "explanation": "A sweep is about the score, not the round."
    },
    {
      "id": "home-only",
      "text": "Winning all your home games",
      "explanation": "Sweeps are about the series result."
    }
  ],
  "correctOptionIds": [
    "four-zero"
  ],
  "shuffle": true,
  "explanation": {
    "correct": "A sweep is 4-0. The fastest way to end a best-of-seven is four straight wins.",
    "incorrect": "A sweep means the winning team never lost a game, so 4-0 in a best-of-seven.",
    "sayThisLine": "\"Did they sweep them? Or did it go longer?\""
  }
}
```

### 2.2 `binary-call`

A rule with a clear two-way answer on a static diagram (charge or no charge, violation or legal). Static scenes are enough; the moving version lives in the Unity charge/block sim. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 4.

**Help defender in the arc** (`bc-charge-restricted`; lesson `rul-06`; conceptIds `charge`, `restricted-area-rule`, `legal-guarding-position`)

```json
{
  "prompt": "Help defender stands inside the restricted arc. Charge?",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "bball-half-court",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.62
      },
      {
        "role": "opponent",
        "x": 0.5,
        "y": 0.85
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.64
      }
    ],
    "alt": "Half-court diagram. The ball handler drives from the free-throw line toward the rim. A help defender stands close to the rim, inside the small semicircle under the basket."
  },
  "choices": [
    {
      "id": "charge",
      "label": "Charge"
    },
    {
      "id": "no-charge",
      "label": "No charge"
    }
  ],
  "correctChoiceId": "no-charge",
  "ruleTag": "Restricted area",
  "explanation": {
    "correct": "A help defender inside the restricted-area arc cannot draw a charge on a drive. The arc is there to stop rim collisions being decided by who falls.",
    "incorrect": "The restricted area protects the driver from a help defender who slides in late. If the defender is under the rim in the arc, it is not a charge, though a blocking foul can still be called.",
    "sayThisLine": "\"Wasn't he inside the arc? I thought that meant no charge.\""
  }
}
```

**Camping in the lane** (`bc-three-seconds`; lesson `rul-03`; conceptIds `three-second-violation`)

```json
{
  "prompt": "Offensive big sits in the lane for four seconds. Whistle?",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "bball-half-court",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.8
      },
      {
        "role": "ball",
        "x": 0.75,
        "y": 0.55
      }
    ],
    "alt": "Half-court diagram. An offensive player stands inside the painted lane near the rim while the ball is on the right wing."
  },
  "choices": [
    {
      "id": "violation",
      "label": "Violation"
    },
    {
      "id": "legal",
      "label": "Legal"
    }
  ],
  "correctChoiceId": "violation",
  "ruleTag": "Three seconds",
  "explanation": {
    "correct": "Offensive players cannot stay in the paint more than three seconds while their team has the ball in the frontcourt. The count restarts if they leave.",
    "incorrect": "The paint is not a parking spot. An offensive player staying in the lane longer than three seconds is a violation, which is why bigs keep moving.",
    "sayThisLine": "\"Three seconds in the paint, right? That's the offensive one.\""
  }
}
```

**Ball on the way down** (`bc-goaltending`; lesson `rul-07`; conceptIds `goaltending`, `basket-interference`)

```json
{
  "prompt": "Defender swats a shot on its way down. Call?",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "bball-half-court",
    "markers": [
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.88
      },
      {
        "role": "opponent",
        "x": 0.44,
        "y": 0.86
      }
    ],
    "alt": "Half-court diagram. The ball is directly above the rim on its way down and a defender is beside it."
  },
  "choices": [
    {
      "id": "goaltending",
      "label": "Goaltending"
    },
    {
      "id": "legal-block",
      "label": "Legal block"
    }
  ],
  "correctChoiceId": "goaltending",
  "ruleTag": "Goaltending",
  "explanation": {
    "correct": "Touching a shot on its downward flight above rim level, with a chance to score, is goaltending. The basket counts.",
    "incorrect": "A legal block happens on the way up. On the way down, above rim level and near the basket, it is goaltending and the points go up.",
    "sayThisLine": "\"Was that goaltending? It looked like it was on the way down.\""
  }
}
```

**Back over half court** (`bc-backcourt`; lesson `rul-02`; conceptIds `backcourt-violation`)

```json
{
  "prompt": "Offense crosses half court, then dribbles back over. Call?",
  "scene": {
    "kind": "court-diagram",
    "diagramId": "bball-full-court",
    "markers": [
      {
        "role": "player",
        "x": 0.5,
        "y": 0.52
      },
      {
        "role": "ball",
        "x": 0.5,
        "y": 0.5
      }
    ],
    "alt": "Full-court diagram. The ball handler has both feet in the frontcourt and then steps back across the half-court line with the ball."
  },
  "choices": [
    {
      "id": "backcourt",
      "label": "Backcourt"
    },
    {
      "id": "legal",
      "label": "Legal"
    }
  ],
  "correctChoiceId": "backcourt",
  "ruleTag": "Over and back",
  "explanation": {
    "correct": "Once the offense gets the ball into the frontcourt, it cannot bring it back across half court. That is a backcourt violation, sometimes called over and back.",
    "incorrect": "A team may not take the ball back across half court once it is in the frontcourt. That is the over-and-back violation.",
    "sayThisLine": "\"That's over and back, right?\""
  }
}
```

### 2.3 `term-match`

Introducing 3-5 terms of one topic (court words, coverages, cap words). Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 3.

**Court words** (`tm-court-terms`; lesson `gam-02`; conceptIds `court-lines`, `paint-key`, `three-point-line`, `free-throw-line`, `restricted-area-arc`)

```json
{
  "prompt": "Match each court word to what it means.",
  "pairs": [
    {
      "id": "paint",
      "term": "The paint",
      "definition": "The painted lane between the baseline and free-throw line"
    },
    {
      "id": "arc",
      "term": "The arc",
      "definition": "The three-point line that curves around the basket"
    },
    {
      "id": "elbow",
      "term": "The elbow",
      "definition": "Where the free-throw line meets the lane edge"
    },
    {
      "id": "corner",
      "term": "The corner three",
      "definition": "A shorter three taken from the baseline corner"
    },
    {
      "id": "block",
      "term": "The block",
      "definition": "The small marked box beside the lane near the basket"
    }
  ],
  "distractorDefinitions": [
    "The circle at half court used for the opening tip"
  ],
  "explanation": {
    "summary": "Fans use these words for locations all game long. Once you can place a term on the floor, announcers and friends suddenly make sense.",
    "sayThisLine": "\"So a corner three is shorter than the top of the arc?\""
  }
}
```

**Ball-screen coverages** (`tm-coverages`; lesson `act-02`; conceptIds `drop-coverage`, `hedge-show`, `switch`, `blitz-trap`, `ice-coverage`)

```json
{
  "prompt": "Match each ball-screen coverage to what the defense does.",
  "pairs": [
    {
      "id": "drop",
      "term": "Drop",
      "definition": "Screener's defender backs into the paint and protects the rim"
    },
    {
      "id": "hedge",
      "term": "Hedge / show",
      "definition": "Screener's defender steps out briefly, then recovers to his man"
    },
    {
      "id": "switch",
      "term": "Switch",
      "definition": "The two defenders swap the players they are guarding"
    },
    {
      "id": "blitz",
      "term": "Blitz / trap",
      "definition": "Both defenders trap the ball handler to force the ball out"
    },
    {
      "id": "ice",
      "term": "Ice",
      "definition": "Ball handler is steered toward the sideline, away from the screen"
    }
  ],
  "distractorDefinitions": [
    "The screener sets a second screen to free a shooter"
  ],
  "explanation": {
    "summary": "Coverage names describe what the screener's defender does. Every choice trades rim safety for pressure on the ball.",
    "sayThisLine": "\"Are they in drop, or are they switching everything?\""
  }
}
```

**Cap words** (`tm-cap-words`; lesson `lea-07`; conceptIds `luxury-tax`, `first-apron`, `second-apron`, `bird-rights`, `mid-level-exception`, `max-contract`)

```json
{
  "prompt": "Match each money term to what it does.",
  "pairs": [
    {
      "id": "tax",
      "term": "Luxury tax",
      "definition": "A penalty a team pays for payroll above the tax line"
    },
    {
      "id": "apron",
      "term": "Apron",
      "definition": "A payroll line above the tax that adds restrictions"
    },
    {
      "id": "bird",
      "term": "Bird rights",
      "definition": "Lets a team exceed the cap to re-sign its own player"
    },
    {
      "id": "mle",
      "term": "Mid-level exception",
      "definition": "A tool for signing free agents even when over the cap"
    },
    {
      "id": "max",
      "term": "Max contract",
      "definition": "The highest salary a player can earn, based on service"
    }
  ],
  "distractorDefinitions": [
    "A rule that limits a team to three trades a year"
  ],
  "explanation": {
    "summary": "A soft cap lets teams go over, but the tax and aprons make that expensive and restrictive.",
    "sayThisLine": "\"So the apron is the line where the restrictions start?\""
  }
}
```

### 2.4 `sequence-order`

Processes whose order is the lesson: possession flow, Play-In bracket, tournament path. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 4.

**One possession** (`seq-possession`; lesson `gam-05`; conceptIds `possession-flow`, `half-court-offense`)

```json
{
  "prompt": "Order a half-court possession from start to finish.",
  "items": [
    {
      "id": "bring",
      "text": "Bring the ball across half court",
      "why": "The offense has 8 seconds in the NBA to cross."
    },
    {
      "id": "initiate",
      "text": "Point guard starts the set",
      "why": "A call, a screen, or a pass starts the action."
    },
    {
      "id": "action",
      "text": "Screen or cut creates an advantage",
      "why": "The defense has to answer the movement."
    },
    {
      "id": "decision",
      "text": "Someone shoots, passes or draws a foul",
      "why": "The advantage becomes a decision."
    },
    {
      "id": "rebound",
      "text": "Rebound or inbound, then the next possession",
      "why": "The possession ends and the other team starts one."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Every possession follows the same arc: bring it up, start the action, make the advantage, make the decision, then reset.",
    "incorrect": "Think of the possession as a story: setup, action, decision, then reset. Once you see the story, you can watch it happen live.",
    "sayThisLine": "\"What were they trying to do on that possession?\""
  }
}
```

**How the Play-In runs** (`seq-play-in`; lesson `lea-03`; conceptIds `play-in`, `seventh-eighth-game`, `ninth-tenth-game`)

```json
{
  "prompt": "Order the Play-In steps for one conference.",
  "items": [
    {
      "id": "seven-eight",
      "text": "7th plays 8th; the winner takes the 7 seed",
      "why": "The winner has already earned a playoff spot."
    },
    {
      "id": "nine-ten",
      "text": "9th plays 10th; the loser is eliminated",
      "why": "This is a true elimination game."
    },
    {
      "id": "loser-game",
      "text": "Loser of 7-8 hosts winner of 9-10",
      "why": "The 8 seed is on the line."
    },
    {
      "id": "eight-seed",
      "text": "Winner of that game takes the 8 seed",
      "why": "Everyone else goes home."
    },
    {
      "id": "playoff-start",
      "text": "Seeds 1 to 8 start the playoff bracket",
      "why": "The bracket is now set."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Seeds 7 and 8 get two chances, 9 and 10 get one. The Play-In fills the last two playoff spots in each conference.",
    "incorrect": "The 7-8 winner is safe. The 7-8 loser gets a second chance against the winner of 9-10, and the loser of 9-10 is out first.",
    "sayThisLine": "\"So the 7 and 8 teams get a second chance, the 9 and 10 teams don't?\""
  }
}
```

**The tournament path** (`seq-bracket`; lesson `col-02`; conceptIds `bracket`, `first-four`, `sweet-sixteen`, `final-four`)

```json
{
  "prompt": "Order the rounds of the NCAA tournament.",
  "items": [
    {
      "id": "first-four",
      "text": "First Four",
      "why": "Four games decide the last spots."
    },
    {
      "id": "r64",
      "text": "Round of 64",
      "why": "The bracket opens with 64 teams."
    },
    {
      "id": "r32",
      "text": "Round of 32",
      "why": "Half the field is gone."
    },
    {
      "id": "sweet",
      "text": "Sweet Sixteen",
      "why": "Only 16 teams remain."
    },
    {
      "id": "elite",
      "text": "Elite Eight",
      "why": "The winners reach the Final Four."
    },
    {
      "id": "final",
      "text": "Final Four",
      "why": "Four teams meet in the national semifinals."
    },
    {
      "id": "title",
      "text": "National championship game",
      "why": "Two teams, one trophy."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "The tournament has 68 teams: four First Four games, then the 64-team bracket, then single elimination to one champion.",
    "incorrect": "The field is 68 teams, with the First Four first. After the round of 64, the counts halve until the two-team final.",
    "sayThisLine": "\"Which round did your bracket break in?\""
  }
}
```

**Pick-and-roll steps** (`seq-pnr`; lesson `act-01`; conceptIds `pick-and-roll`, `screener`, `roll-man`)

```json
{
  "prompt": "Order the steps of a pick-and-roll.",
  "items": [
    {
      "id": "call",
      "text": "Ball handler signals for the screen",
      "why": "The play begins before the screen is set."
    },
    {
      "id": "screen",
      "text": "Screener sets a solid screen",
      "why": "A still screener makes the play work."
    },
    {
      "id": "use",
      "text": "Ball handler uses the screen",
      "why": "The handler comes off tight to the screener."
    },
    {
      "id": "react",
      "text": "The two defenders react",
      "why": "That reaction is the coverage."
    },
    {
      "id": "roll",
      "text": "Screener rolls or pops",
      "why": "The screener attacks the space the defense left behind."
    },
    {
      "id": "finish",
      "text": "Pass, shot or drive finishes it",
      "why": "The offense uses whichever option is open."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Screen, use, react, roll. Defenders react to the screen and the offense picks the option their coverage gives up.",
    "incorrect": "A pick-and-roll works as a chain: the screen, the handler using it, the defenders reacting, and the screener attacking the open space.",
    "sayThisLine": "\"What coverage are they in on that pick-and-roll?\""
  }
}
```

### 2.5 `visual-id`

Referee signals only, using original Swoon'd illustrations (license `swoond-original-illustration`). No photos of players, no logos. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 3.

**Referee signal: travel** (`vid-travel`; lesson `rul-08`; conceptIds `referee-signals`, `traveling`)

```json
{
  "prompt": "What is this referee signal?",
  "image": {
    "asset": "illustrations/ref-signal-travel.png",
    "alt": "Illustrated referee with both fists rotating around each other in front of the chest.",
    "license": "swoond-original-illustration"
  },
  "options": [
    {
      "id": "traveling",
      "text": "Traveling"
    },
    {
      "id": "double-dribble",
      "text": "Double dribble"
    },
    {
      "id": "jump-ball",
      "text": "Jump ball"
    },
    {
      "id": "timeout",
      "text": "Timeout"
    }
  ],
  "correctOptionId": "traveling",
  "explanation": {
    "correct": "Rolling fists means traveling. The referee is showing the ball handler took extra steps.",
    "incorrect": "The rolling motion with both fists is the traveling signal. The double-dribble signal is a quick patting motion.",
    "sayThisLine": "\"That circle motion was a travel call, right?\""
  },
  "cues": [
    "Two fists rotating around each other",
    "Held in front of the chest",
    "Not patting or pointing"
  ]
}
```

**Referee signal: blocking foul** (`vid-block`; lesson `rul-08`; conceptIds `referee-signals`, `blocking-foul`)

```json
{
  "prompt": "What is this referee signal?",
  "image": {
    "asset": "illustrations/ref-signal-blocking.png",
    "alt": "Illustrated referee with one hand pressed on the hip while the other arm is raised.",
    "license": "swoond-original-illustration"
  },
  "options": [
    {
      "id": "blocking",
      "text": "Blocking foul on the defender"
    },
    {
      "id": "charge",
      "text": "Charge on the offense"
    },
    {
      "id": "technical",
      "text": "Technical foul"
    },
    {
      "id": "three",
      "text": "Three-point attempt"
    }
  ],
  "correctOptionId": "blocking",
  "explanation": {
    "correct": "Hand on the hip is the blocking-foul signal. The defender was not set in legal position.",
    "incorrect": "A hand on the hip signals a blocking foul on the defense. An offensive foul is signaled with a closed fist instead.",
    "sayThisLine": "\"Hand on hip means he blocked him, right?\""
  },
  "cues": [
    "One hand planted on the hip",
    "Other arm raised for the foul",
    "Points to the defender's team"
  ]
}
```

**Referee signal: made three** (`vid-three-made`; lesson `rul-08`; conceptIds `referee-signals`, `scoring-1-2-3`)

```json
{
  "prompt": "What is this referee signal?",
  "image": {
    "asset": "illustrations/ref-signal-three-made.png",
    "alt": "Illustrated referee with both arms raised overhead, each hand showing three fingers.",
    "license": "swoond-original-illustration"
  },
  "options": [
    {
      "id": "made-three",
      "text": "A made three-pointer"
    },
    {
      "id": "three-seconds",
      "text": "Three-second violation"
    },
    {
      "id": "timeout",
      "text": "Timeout"
    },
    {
      "id": "travel",
      "text": "Traveling"
    }
  ],
  "correctOptionId": "made-three",
  "explanation": {
    "correct": "Both arms up with three fingers means the three-pointer counts. The referee is telling the scorer's table what to record.",
    "incorrect": "Both arms raised with three fingers means a made three. A referee raising one arm with three fingers is signaling a three-point attempt.",
    "sayThisLine": "\"The ref put both arms up, so that three counted?\""
  },
  "cues": [
    "Both arms overhead",
    "Three fingers on each hand",
    "Different from a single raised arm for an attempt"
  ]
}
```

### 2.6 `decision-scenario`

Judgment from facts: end-of-game fouling, timeout calls, cap-constrained trades. Not gamified beyond best/acceptable/poor because the honest answer is "it depends". Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 3.

**Up three, 12 seconds** (`dec-up-three`; lesson `str-04`; conceptIds `foul-when-up-three`, `intentional-foul-strategy`, `last-shot`)

```json
{
  "prompt": "Up three, 12 seconds left. Foul or defend?",
  "situation": {
    "narrative": "Your team leads by three. The other team has the ball at half court.",
    "facts": [
      {
        "label": "Score",
        "value": "Up 3"
      },
      {
        "label": "Time left",
        "value": "12 seconds"
      },
      {
        "label": "Their ball",
        "value": "Half court"
      },
      {
        "label": "Team fouls",
        "value": "Opponent in the bonus"
      },
      {
        "label": "Their best shooter",
        "value": "Hot from three",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "defend-switch",
      "label": "Defend, switch everything, no help off shooters",
      "verdict": "best",
      "consequence": "They must beat a set defense from three. A miss ends it. An offensive rebound is the main risk.",
      "considerations": [
        "Fouling risks a three-point shot with a foul on it",
        "Switching removes open threes",
        "A tie still needs overtime"
      ]
    },
    {
      "id": "foul-early",
      "label": "Foul before a shot, around 6+ seconds left",
      "verdict": "acceptable",
      "consequence": "They get two free throws. If they make both, they need a stop or a steal. It can work but adds risk.",
      "considerations": [
        "The foul must come before the shooting motion",
        "They may make two and foul back",
        "Coaches split on this call"
      ]
    },
    {
      "id": "double-star",
      "label": "Double their star and leave a shooter open",
      "verdict": "poor",
      "consequence": "They pass to the open shooter for a clean three, and now you need a miracle in overtime.",
      "considerations": [
        "Open threes are the exact thing to prevent",
        "A double team leaves someone open"
      ]
    }
  ],
  "expertNote": "Up three is one of the biggest debates in hoops. The math is close, and many coaches choose to foul anyway. A clean rule: never give up a free three.",
  "sayThisLine": "\"Would you foul there, or just defend the three?\""
}
```

**A 12-0 run** (`dec-run-timeout`; lesson `str-01`; conceptIds `timeout`, `momentum-run`)

```json
{
  "prompt": "They just went on a 12-0 run. What now?",
  "situation": {
    "narrative": "Your team is losing a lead and the crowd is getting loud.",
    "facts": [
      {
        "label": "Run",
        "value": "12-0"
      },
      {
        "label": "Quarter",
        "value": "Third, 5:00 left"
      },
      {
        "label": "Timeouts left",
        "value": "4"
      },
      {
        "label": "Turnovers",
        "value": "Three in a row",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "timeout",
      "label": "Call a timeout and reset the plan",
      "verdict": "best",
      "consequence": "The run stops, the tired starters rest and the coach can change the matchup.",
      "considerations": [
        "Timeouts are a coaching tool",
        "Turnovers often mean a rhythm problem, not an effort problem"
      ]
    },
    {
      "id": "sub-two",
      "label": "Sub two starters on the next dead ball",
      "verdict": "acceptable",
      "consequence": "It changes the mix, but the run may continue while the substitutes get set.",
      "considerations": [
        "A sub takes a dead ball",
        "A timeout is faster"
      ]
    },
    {
      "id": "nothing",
      "label": "Do nothing and trust the offense",
      "verdict": "poor",
      "consequence": "The lead may disappear before the coach gets another chance.",
      "considerations": [
        "Runs feed on turnovers",
        "Waiting costs points"
      ]
    }
  ],
  "expertNote": "A timeout after a run interrupts the opponent's rhythm. Teams pay attention to the score, but coaches watch the possession quality too.",
  "sayThisLine": "\"That's a run. Are they going to call a timeout now?\""
}
```

**Over the second apron** (`dec-apron-trade`; lesson `lea-07`; conceptIds `second-apron`, `salary-cap`, `trade`)

```json
{
  "prompt": "A team over the second apron wants a star. What works?",
  "situation": {
    "narrative": "A contender is above the second apron and a star becomes available.",
    "facts": [
      {
        "label": "Team payroll",
        "value": "Above the second apron",
        "emphasis": "warning"
      },
      {
        "label": "Cap space",
        "value": "None"
      },
      {
        "label": "Star salary",
        "value": "Very high"
      },
      {
        "label": "Assets",
        "value": "Two mid-salary players"
      }
    ]
  },
  "options": [
    {
      "id": "trade-matching",
      "label": "Trade matching salary for the star, taking back no more than you send",
      "verdict": "best",
      "consequence": "It fits the restrictions: the team does not add net salary.",
      "considerations": [
        "Second-apron teams cannot take back more salary in trades",
        "It costs real players and picks"
      ]
    },
    {
      "id": "aggregate",
      "label": "Combine two mid-salary players into one bigger contract",
      "verdict": "poor",
      "consequence": "Second-apron teams cannot aggregate salaries in trades, so the deal fails.",
      "considerations": [
        "Aggregation is a restricted tool at this level"
      ]
    },
    {
      "id": "sign-mle",
      "label": "Sign the star with the mid-level exception",
      "verdict": "poor",
      "consequence": "Stars ask for far more, and second-apron teams do not get the taxpayer mid-level.",
      "considerations": [
        "The exception is far smaller than a star contract"
      ]
    }
  ],
  "expertNote": "The second apron was built to stop teams from piling up stars through trades and exceptions. Fans say the tax and apron rules changed how contenders are built.",
  "sayThisLine": "\"Can they even do that trade with the apron rules?\""
}
```

### 2.7 `timing-tap`

1D timing feel: two-for-one window, late-clock start, inbound count. Timing does not depend on a 3D scene here, so it stays native. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 3.

**Two-for-one window** (`tim-two-for-one`; lesson `str-05`; conceptIds `two-for-one`, `clock-management`)

```json
{
  "prompt": "Shoot in the two-for-one window: 36 to 28 seconds left.",
  "theme": {
    "label": "Game clock",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 10,
      "zoneEndPct": 30,
      "sweepSeconds": 3
    },
    {
      "zoneStartPct": 12,
      "zoneEndPct": 28,
      "sweepSeconds": 2.5
    },
    {
      "zoneStartPct": 14,
      "zoneEndPct": 26,
      "sweepSeconds": 2
    }
  ],
  "explanation": {
    "correct": "Shooting at about 36 to 28 seconds left leaves time for your opponent to shoot and for you to get the last shot, so you get two possessions.",
    "incorrect": "Shoot too early and you waste time. Shoot too late and you lose the extra possession. The window is a small band around 30 seconds.",
    "sayThisLine": "\"Are they trying for a two-for-one right now?\""
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Late-clock action** (`tim-late-clock`; lesson `act-08`; conceptIds `late-clock`, `bailout-shot`)

```json
{
  "prompt": "Start the late-clock action with about 7 seconds left.",
  "theme": {
    "label": "Shot clock",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 66,
      "zoneEndPct": 78,
      "sweepSeconds": 3
    },
    {
      "zoneStartPct": 68,
      "zoneEndPct": 76,
      "sweepSeconds": 2.4
    }
  ],
  "explanation": {
    "correct": "Starting around 7 seconds leaves time for one action and a second option. It beats a panic heave at 2.",
    "incorrect": "Start too early and the clock is not a problem. Start too late and the shot is a bailout. Around 7 seconds gives one real read.",
    "sayThisLine": "\"They waited too long. That's a late-clock bailout.\""
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Beat the five-second inbound** (`tim-inbound`; lesson `gam-04`; conceptIds `inbound`, `turnover`)

```json
{
  "prompt": "Release the inbound pass between seconds 2 and 4.",
  "theme": {
    "label": "Inbound count",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 40,
      "zoneEndPct": 80,
      "sweepSeconds": 3
    },
    {
      "zoneStartPct": 45,
      "zoneEndPct": 75,
      "sweepSeconds": 2.4
    },
    {
      "zoneStartPct": 50,
      "zoneEndPct": 72,
      "sweepSeconds": 2
    }
  ],
  "explanation": {
    "correct": "The inbounder gets five seconds. Going in the middle of the count leaves time for a cut to get open and avoids the violation.",
    "incorrect": "Wait too long and the five-second count turns the ball over. Too early and no one is open yet.",
    "sayThisLine": "\"He almost got called for five seconds on the inbound.\""
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.8 `say-this`

"What is she talking about?" Decode fan lines. The single most important type for this course. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 5.

**Our bigs can't switch** (`say-switch`; lesson `act-02`; conceptIds `switch`, `switchability`, `mismatch`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Our bigs can't switch, and every team's guards know it."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "switch",
      "text": "Defenders swapping who they guard on a screen",
      "isCorrect": true,
      "explanation": "That is a switch."
    },
    {
      "id": "big-slow",
      "text": "Big players struggle to move their feet against quick guards",
      "isCorrect": true,
      "explanation": "The complaint is that bigs cannot guard guards in space."
    },
    {
      "id": "targeted",
      "text": "Opponents attack the slow big on purpose",
      "isCorrect": true,
      "explanation": "Offenses hunt those mismatches."
    },
    {
      "id": "lineup",
      "text": "The team keeps changing its starting lineup",
      "isCorrect": false,
      "explanation": "Switching is a defensive choice, not a lineup change."
    },
    {
      "id": "referee",
      "text": "The referees keep switching sides at halftime",
      "isCorrect": false,
      "explanation": "Nothing to do with officials."
    }
  ],
  "translation": "When a screen comes, guards get a big defender on them and can dribble past him. Her team's bigs are not quick enough to guard guards in space.",
  "followUps": [
    {
      "line": "Is that why they keep hunting him on the switch?",
      "why": "It shows you understood the mismatch and invites her to explain."
    },
    {
      "line": "Do you think they should drop the big back instead?",
      "why": "A real coverage question that lets her lead."
    }
  ],
  "noFakeExpertNote": "If you do not know which player she means, say so. Asking \"who?\" is a great follow-up."
}
```

**Walking bucket** (`say-bucket`; lesson `gam-07`; conceptIds `positionless-basketball`, `three-and-d`, `usage-rate`)

```json
{
  "statement": {
    "speaker": "Jordan",
    "text": "He is a walking bucket, but he is a negative on defense."
  },
  "question": "What is he talking about?",
  "options": [
    {
      "id": "scorer",
      "text": "The player scores easily",
      "isCorrect": true,
      "explanation": "\"Bucket\" means a basket."
    },
    {
      "id": "bad-d",
      "text": "The player gives some of it back on defense",
      "isCorrect": true,
      "explanation": "\"Negative on defense\" means he hurts the team defensively."
    },
    {
      "id": "literal",
      "text": "The player literally carries a bucket",
      "isCorrect": false,
      "explanation": "It is slang."
    },
    {
      "id": "injured",
      "text": "The player is injured and not playing",
      "isCorrect": false,
      "explanation": "Nothing about injury."
    }
  ],
  "translation": "He can score whenever he wants, but the team gets scored on more when he is on the floor.",
  "followUps": [
    {
      "line": "Does the team score enough to make up for it?",
      "why": "It is the real argument: the net effect."
    },
    {
      "line": "Who guards his man when he is the weak link?",
      "why": "It leads to a lineup answer instead of a stat argument."
    }
  ],
  "noFakeExpertNote": "You do not need to know the player. Ask what makes him a negative."
}
```

**The Play-In stress** (`say-eight-seed`; lesson `lea-03`; conceptIds `play-in`, `seeding`, `seventh-eighth-game`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "We are stuck in the 8th spot and I do not want to see the Play-In again."
  },
  "question": "What is he talking about?",
  "options": [
    {
      "id": "seed",
      "text": "His team is fighting near the bottom of the playoff picture",
      "isCorrect": true,
      "explanation": "The 7th to 10th seeds enter the Play-In."
    },
    {
      "id": "extra-game",
      "text": "They may need to win an extra game just to make the playoffs",
      "isCorrect": true,
      "explanation": "The Play-In is a mini tournament."
    },
    {
      "id": "elimin",
      "text": "They might miss the playoffs entirely",
      "isCorrect": true,
      "explanation": "The loser of the 9-10 game goes home."
    },
    {
      "id": "trade",
      "text": "They traded for an eighth player",
      "isCorrect": false,
      "explanation": "Eight refers to the seed, not the roster."
    }
  ],
  "translation": "His team is on the bubble. They may have to win a Play-In game to make the playoffs, which is stressful.",
  "followUps": [
    {
      "line": "How many wins do they need to avoid it?",
      "why": "A specific, easy question about the standings."
    },
    {
      "line": "Which game is the scariest one?",
      "why": "Shows you know there is more than one Play-In game."
    }
  ],
  "noFakeExpertNote": "If you do not know the details, ask him to walk you through it."
}
```

**Five of thirty from three** (`say-three-percent`; lesson `off-05`; conceptIds `floor-spacing`, `shot-quality`, `corner-three`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "We shot 5-for-30 from three and the spacing was cramped all night."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "bad-shooting",
      "text": "The team missed most of its threes",
      "isCorrect": true,
      "explanation": "5-for-30 is about 17%."
    },
    {
      "id": "spacing",
      "text": "Players stood too close together, so defenders could help",
      "isCorrect": true,
      "explanation": "Cramped means the floor was not wide enough."
    },
    {
      "id": "loss",
      "text": "They probably lost or nearly lost",
      "isCorrect": true,
      "explanation": "Missing 25 threes usually costs a game."
    },
    {
      "id": "court",
      "text": "The court was smaller than normal",
      "isCorrect": false,
      "explanation": "Cramped is about players, not the floor."
    }
  ],
  "translation": "Her team missed most of its three-pointers and the offense felt squeezed because players were bunched up.",
  "followUps": [
    {
      "line": "Was it the shots, or did the ball just stick?",
      "why": "It asks about cause without claiming a diagnosis."
    },
    {
      "line": "Do they have enough shooters for spacing?",
      "why": "A curious question about the roster."
    }
  ],
  "noFakeExpertNote": "You can say \"I did not see the game. What happened?\" It always lands well."
}
```

**That is not a charge** (`say-ref-ball`; lesson `rul-06`; conceptIds `charge`, `restricted-area-rule`, `star-treatment`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "Ref ball again. That was never a charge, he was in the restricted area."
  },
  "question": "What is he talking about?",
  "options": [
    {
      "id": "complaint",
      "text": "He thinks the referees made a bad call",
      "isCorrect": true,
      "explanation": "\"Ref ball\" is fan slang for bad officiating."
    },
    {
      "id": "arc",
      "text": "The defender was under the rim inside the small arc",
      "isCorrect": true,
      "explanation": "A help defender in the arc cannot draw a charge."
    },
    {
      "id": "call",
      "text": "An offensive foul was called on his team",
      "isCorrect": true,
      "explanation": "That is what a charge is."
    },
    {
      "id": "dinner",
      "text": "He is upset about a restaurant reservation",
      "isCorrect": false,
      "explanation": "Nothing about dinner."
    }
  ],
  "translation": "A ref called an offensive foul on his team. He believes the defender was inside the restricted-area arc, where a charge cannot be called.",
  "followUps": [
    {
      "line": "Was he the help defender or the one guarding him?",
      "why": "The primary defender can still draw a charge in the arc."
    },
    {
      "line": "Did they review it?",
      "why": "A simple question that moves the conversation forward."
    }
  ],
  "noFakeExpertNote": "You can be on his side without claiming to know the call was wrong. \"That looked rough\" works."
}
```

### 2.9 `fill-the-gap`

Vocabulary in context and quick review cards. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 3.

**Triple-double** (`fill-triple-double`; lesson `gam-08`; conceptIds `double-double-triple-double`, `stat-abbreviations`)

```json
{
  "prompt": "Complete the stat-line sentence.",
  "template": "A player with 10 points, 10 rebounds and 10 assists has a {{name}}, which needs double figures in {{count}} categories.",
  "gaps": [
    {
      "id": "name",
      "options": [
        "triple-double",
        "double-double",
        "hat trick",
        "five-by-five"
      ],
      "correct": "triple-double"
    },
    {
      "id": "count",
      "options": [
        "two",
        "three",
        "four",
        "five"
      ],
      "correct": "three"
    }
  ],
  "explanation": {
    "correct": "Ten in three categories is a triple-double. Ten in two is a double-double.",
    "incorrect": "Double-double means two categories at 10 or more. Triple-double means three, usually points, rebounds and assists.",
    "sayThisLine": "\"Was that a triple-double, or just a double-double?\""
  }
}
```

**The bonus** (`fill-bonus`; lesson `rul-05`; conceptIds `team-fouls-bonus`, `free-throw`)

```json
{
  "prompt": "Complete the foul sentence.",
  "template": "Once a team is in the {{bonus}}, every non-shooting foul sends the other team to the {{line}}.",
  "gaps": [
    {
      "id": "bonus",
      "options": [
        "bonus",
        "penalty box",
        "power play",
        "paint"
      ],
      "correct": "bonus"
    },
    {
      "id": "line",
      "options": [
        "free-throw line",
        "half-court line",
        "three-point line",
        "baseline"
      ],
      "correct": "free-throw line"
    }
  ],
  "explanation": {
    "correct": "When a team has committed enough fouls in a period, the bonus gives the other team free throws on every foul.",
    "incorrect": "The bonus is a foul limit. After it, every foul sends the other team to the free-throw line.",
    "sayThisLine": "\"They're in the bonus, so every foul is two shots.\""
  }
}
```

**Tax and cap** (`fill-luxury-tax`; lesson `lea-07`; conceptIds `luxury-tax`, `soft-cap`)

```json
{
  "prompt": "Complete the money sentence.",
  "template": "The NBA has a {{soft}} cap, so teams can exceed it, but a team above the {{tax}} line pays a penalty.",
  "gaps": [
    {
      "id": "soft",
      "options": [
        "soft",
        "hard",
        "flat",
        "rolling"
      ],
      "correct": "soft"
    },
    {
      "id": "tax",
      "options": [
        "luxury tax",
        "sales tax",
        "draft",
        "trade"
      ],
      "correct": "luxury tax"
    }
  ],
  "explanation": {
    "correct": "A soft cap can be exceeded through exceptions. The luxury tax makes going over it expensive.",
    "incorrect": "The NBA uses a soft cap, which teams can go above using exceptions. The luxury tax is the penalty for spending too far above it.",
    "sayThisLine": "\"So the tax is what keeps teams from spending forever?\""
  }
}
```

### 2.10 `estimate-slider`

Magnitudes: court distances, points per shot, possessions per game, offensive rating math. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 4.

**Top-of-the-arc distance** (`est-arc`; lesson `gam-02`; conceptIds `three-point-line`)

```json
{
  "prompt": "How far is the NBA three-point line at the top?",
  "unit": "feet",
  "min": 18,
  "max": 28,
  "step": 0.25,
  "correctValue": 23.75,
  "tolerance": {
    "full": 0.5,
    "partial": 2
  },
  "explanation": {
    "correct": "The top of the NBA arc is 23 feet 9 inches, or 23.75 feet. It shortens to 22 feet in the corners.",
    "incorrect": "The arc is 23.75 feet from the basket at the top, and 22 feet in the corners. That difference is why the corner three is the shortest one.",
    "sayThisLine": "\"The corner three is shorter, right? Twenty-two feet?\""
  }
}
```

**Points per shot** (`est-xpts`; lesson `off-05`; conceptIds `shot-quality`, `three-point-revolution`, `expected-points`)

```json
{
  "prompt": "A player hits 36% of threes. Points per shot?",
  "unit": "points",
  "min": 0.5,
  "max": 1.5,
  "step": 0.01,
  "correctValue": 1.08,
  "tolerance": {
    "full": 0.04,
    "partial": 0.12
  },
  "explanation": {
    "correct": "36% of three-pointers is 1.08 points per shot, which beats 50% on twos (1.00). That is the math behind the three-point revolution.",
    "incorrect": "Multiply the make rate by the points: 0.36 times 3 is 1.08. A 50% two-point shooter scores 1.00 per shot.",
    "sayThisLine": "\"A 36 percent three is worth more than a 50 percent two.\""
  }
}
```

**Free-throw distance** (`est-ft-line`; lesson `gam-02`; conceptIds `free-throw-line`)

```json
{
  "prompt": "How far is the free-throw line from the backboard?",
  "unit": "feet",
  "min": 8,
  "max": 22,
  "step": 0.5,
  "correctValue": 15,
  "tolerance": {
    "full": 0.5,
    "partial": 2
  },
  "explanation": {
    "correct": "The free-throw line is 15 feet from the backboard. That is why it is called the charity stripe: an uncontested shot from a fixed spot.",
    "incorrect": "The free-throw line is 15 feet from the backboard, or 19 feet from the baseline. It is the same in the NBA, WNBA and college.",
    "sayThisLine": "\"Fifteen feet from the backboard, right?\""
  }
}
```

**Possessions per game** (`est-possessions`; lesson `ana-01`; conceptIds `pace`, `offensive-rating`)

```json
{
  "prompt": "About how many possessions does one NBA team get per game?",
  "unit": "possessions",
  "min": 60,
  "max": 140,
  "step": 1,
  "correctValue": 100,
  "tolerance": {
    "full": 4,
    "partial": 10
  },
  "explanation": {
    "correct": "A modern NBA team gets about 100 possessions a game. Pace varies a little by team and season.",
    "incorrect": "A modern NBA team gets around 100 possessions per game. That is the denominator behind ratings like offensive rating, which is points per 100 possessions.",
    "sayThisLine": "\"So offensive rating is points per 100 possessions?\""
  }
}
```

### 2.11 `hotspot-tap`

Locations on a procedural half-court: corner three, nail, elbow, shot-chart zones. Catalog: `docs/native-exercises/CATALOG.md`. Sample count: 3.

**Find the corner three** (`hot-corner-three`; lesson `ana-05`; conceptIds `corner-three`, `three-point-line`, `corner-three-value`)

```json
{
  "prompt": "Tap where a corner three is taken.",
  "diagram": {
    "diagramId": "bball-half-court",
    "aspectRatio": 1.06,
    "alt": "Half-court diagram. Half-court line at the top, baseline at the bottom, hoop near the baseline. Regions marked: left corner, right corner, top of the arc, elbow, restricted area."
  },
  "hotspots": [
    {
      "id": "left-corner",
      "label": "Left corner",
      "shape": {
        "kind": "rect",
        "x": 0,
        "y": 0.7,
        "w": 0.13,
        "h": 0.3
      }
    },
    {
      "id": "right-corner",
      "label": "Right corner",
      "shape": {
        "kind": "rect",
        "x": 0.87,
        "y": 0.7,
        "w": 0.13,
        "h": 0.3
      }
    },
    {
      "id": "top-arc",
      "label": "Top of the arc",
      "shape": {
        "kind": "rect",
        "x": 0.35,
        "y": 0.42,
        "w": 0.3,
        "h": 0.12
      }
    },
    {
      "id": "left-elbow",
      "label": "Left elbow",
      "shape": {
        "kind": "circle",
        "cx": 0.38,
        "cy": 0.6,
        "r": 0.07
      }
    },
    {
      "id": "restricted",
      "label": "Restricted area",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.88,
        "r": 0.09
      }
    }
  ],
  "correctHotspotIds": [
    "left-corner",
    "right-corner"
  ],
  "explanation": {
    "correct": "The corner three is the shortest three, 22 feet from the rim, along the sideline by the baseline. It is a favorite shot because it is closer and easy to space.",
    "incorrect": "The corners are the two spots along each sideline near the baseline. The arc is farthest at the top and shortest in the corners.",
    "sayThisLine": "\"They keep finding him in the corner. That's the shortest three.\""
  }
}
```

**Find the nail** (`hot-nail`; lesson `def-02`; conceptIds `the-nail`, `help-defense`)

```json
{
  "prompt": "Tap the nail, the help spot in the middle of the lane.",
  "diagram": {
    "diagramId": "bball-half-court",
    "aspectRatio": 1.06,
    "alt": "Half-court diagram with the lane, free-throw line and the hoop near the baseline. Marked spots include the nail, left block, right block and left corner."
  },
  "hotspots": [
    {
      "id": "nail",
      "label": "The nail",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.6,
        "r": 0.07
      }
    },
    {
      "id": "left-block",
      "label": "Left block",
      "shape": {
        "kind": "circle",
        "cx": 0.34,
        "cy": 0.84,
        "r": 0.06
      }
    },
    {
      "id": "right-block",
      "label": "Right block",
      "shape": {
        "kind": "circle",
        "cx": 0.66,
        "cy": 0.84,
        "r": 0.06
      }
    },
    {
      "id": "corner",
      "label": "Left corner",
      "shape": {
        "kind": "rect",
        "x": 0,
        "y": 0.7,
        "w": 0.13,
        "h": 0.3
      }
    }
  ],
  "correctHotspotIds": [
    "nail"
  ],
  "explanation": {
    "correct": "The nail is the center of the free-throw line. A help defender waiting there can stop a drive and still recover to a shooter.",
    "incorrect": "The nail is the spot at the free-throw line, in the middle. It is the classic place for a help defender because it is close to the paint and to the shooters.",
    "sayThisLine": "\"He was at the nail, so he could help and get back.\""
  }
}
```

**Find the elbow** (`hot-elbow`; lesson `act-05`; conceptIds `high-post`, `elbow`, `post-entry`)

```json
{
  "prompt": "Tap an elbow, where the free-throw line meets the lane.",
  "diagram": {
    "diagramId": "bball-half-court",
    "aspectRatio": 1.06,
    "alt": "Half-court diagram showing the lane, free-throw line, both blocks, the top of the key and the corners."
  },
  "hotspots": [
    {
      "id": "left-elbow",
      "label": "Left elbow",
      "shape": {
        "kind": "circle",
        "cx": 0.34,
        "cy": 0.6,
        "r": 0.06
      }
    },
    {
      "id": "right-elbow",
      "label": "Right elbow",
      "shape": {
        "kind": "circle",
        "cx": 0.66,
        "cy": 0.6,
        "r": 0.06
      }
    },
    {
      "id": "left-block",
      "label": "Left block",
      "shape": {
        "kind": "circle",
        "cx": 0.34,
        "cy": 0.84,
        "r": 0.06
      }
    },
    {
      "id": "top-key",
      "label": "Top of the key",
      "shape": {
        "kind": "rect",
        "x": 0.4,
        "y": 0.4,
        "w": 0.2,
        "h": 0.1
      }
    }
  ],
  "correctHotspotIds": [
    "left-elbow",
    "right-elbow"
  ],
  "explanation": {
    "correct": "The elbows are the corners where the free-throw line meets the lane. Post players catch there to start the offense.",
    "incorrect": "The elbows sit at the free-throw line where it meets the lane. The blocks are lower, near the basket.",
    "sayThisLine": "\"So he catches at the elbow and everyone cuts?\""
  }
}
```

## 3. Talk Track scenarios

Format follows `talk-track.schema.json`. Each scenario lists the enthusiast line, what it means, terms implied, and three reply styles: **good** (genuine, curious, specific; +20 to +24), **meh** (polite but empty; about +4), **cringe** (bluffing, lecturing or dismissive; -6 to -18). The Smooth meter starts at 50 and a run of good replies clears the 60 success line and the 80 bonus line. Replies never reward canned expert lines; they reward honesty and a real follow-up (spec section 13).

Target volume: 24 standalone Talk tab tracks at launch (10 written below), 31 embedded lesson tracks, and 6 new tracks per season through the live layer.

### 3.1 When they lose by 20

- **Lesson:** `con-02` | **Setting:** Texting after her team gets blown out.
- **Enthusiast line:** "That was embarrassing. We got run out of the gym."
- **What it means:** She is upset about a big loss. "Run out of the gym" means the other team dominated from the start.
- **Terms implied:** blowout, run
- **conceptIds:** `conv-empathy-loss`, `basic-fan-talk`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "Ugh, sorry. Was there a moment it got away from you?" | +22 | Empathy first, then one real question. That is the whole trick. |
| meh | "That is rough. Tomorrow is a new game." | +4 | Kind, but generic. A specific question keeps them talking. |
| cringe | "At least it only counts as one loss, lol." | -14 | Do not minimize the mood. Lead with feelings, not math. |

```json
{
  "title": "When they lose by 20",
  "setting": "Texting after her team gets blown out.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "That was embarrassing. We got run out of the gym.",
      "replies": [
        {
          "id": "good-empathy",
          "text": "Ugh, sorry. Was there a moment it got away from you?",
          "smoothDelta": 22,
          "theirResponse": "Third quarter. They went on a 15-2 run and we just stopped hitting shots.",
          "coachNote": "Empathy first, then one real question. That is the whole trick."
        },
        {
          "id": "meh-stat",
          "text": "That is rough. Tomorrow is a new game.",
          "smoothDelta": 4,
          "theirResponse": "Yeah I know. It just stings.",
          "coachNote": "Kind, but generic. A specific question keeps them talking."
        },
        {
          "id": "cringe-cheer",
          "text": "At least it only counts as one loss, lol.",
          "smoothDelta": -14,
          "theirResponse": "...it still counts.",
          "coachNote": "Do not minimize the mood. Lead with feelings, not math."
        }
      ]
    }
  ],
  "closingNote": "Loss talk is about care, not analysis. Listen first."
}
```

### 3.2 Load management again

- **Lesson:** `con-04` | **Setting:** Texting the morning of a game.
- **Enthusiast line:** "He is sitting out again. Load management, on a Tuesday!"
- **What it means:** A star is resting even though healthy. Fans argue about whether it hurts the product.
- **Terms implied:** load-management, back-to-back
- **conceptIds:** `load-management`, `conv-ask-follow-up`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "Is it because it is the second night of a back-to-back?" | +22 | A specific guess shows you know the shape of the argument. |
| meh | "Ugh, that is annoying." | +5 | Safe agreement, but it does not add anything. |
| cringe | "Load management is definitely a myth, he is just soft." | -15 | Do not lecture. You can ask, not pronounce. |

```json
{
  "title": "Load management again",
  "setting": "Texting the morning of a game.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "He is sitting out again. Load management, on a Tuesday!",
      "replies": [
        {
          "id": "good-ask",
          "text": "Is it because it is the second night of a back-to-back?",
          "smoothDelta": 22,
          "theirResponse": "Yes! Exactly. And the league basically has a rule about it now, which is a whole other rant.",
          "coachNote": "A specific guess shows you know the shape of the argument."
        },
        {
          "id": "meh-agree",
          "text": "Ugh, that is annoying.",
          "smoothDelta": 5,
          "theirResponse": "Right? It drives me nuts.",
          "coachNote": "Safe agreement, but it does not add anything."
        },
        {
          "id": "cringe-fake",
          "text": "Load management is definitely a myth, he is just soft.",
          "smoothDelta": -15,
          "theirResponse": "...that is not really the point.",
          "coachNote": "Do not lecture. You can ask, not pronounce."
        }
      ]
    }
  ],
  "closingNote": "Load management is a real debate. Ask questions, do not pick a side to win."
}
```

### 3.3 Cramped spacing

- **Lesson:** `con-04` | **Setting:** Halftime text.
- **Enthusiast line:** "Our spacing is a disaster. Nobody can shoot."
- **What it means:** Her team has too few shooters, so defenders can crowd the paint.
- **Terms implied:** floor-spacing, gravity
- **conceptIds:** `floor-spacing`, `conv-ask-follow-up`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "So they just collapse into the paint on every drive?" | +24 | You described the mechanism in plain English. She will love that. |
| meh | "Maybe they should shoot more?" | -2 | A question, but it misses the point. Shooters have to be able to make them. |
| cringe | "Yeah, classic 1-4 high issue lol." | -16 | Name-dropping a set you have not learned reads as faking. |

```json
{
  "title": "Cramped spacing",
  "setting": "Halftime text.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Our spacing is a disaster. Nobody can shoot.",
      "replies": [
        {
          "id": "good-lane",
          "text": "So they just collapse into the paint on every drive?",
          "smoothDelta": 24,
          "theirResponse": "YES. Every drive turns into four defenders in the lane.",
          "coachNote": "You described the mechanism in plain English. She will love that."
        },
        {
          "id": "meh-shoot",
          "text": "Maybe they should shoot more?",
          "smoothDelta": -2,
          "theirResponse": "Well, that is kind of the problem.",
          "coachNote": "A question, but it misses the point. Shooters have to be able to make them."
        },
        {
          "id": "cringe-pretend",
          "text": "Yeah, classic 1-4 high issue lol.",
          "smoothDelta": -16,
          "theirResponse": "Wait, do you actually know what a 1-4 high is?",
          "coachNote": "Name-dropping a set you have not learned reads as faking."
        }
      ]
    }
  ],
  "closingNote": "You do not need the set name. The mechanism is better."
}
```

### 3.4 The GOAT question

- **Lesson:** `con-05` | **Setting:** Watching highlights together.
- **Enthusiast line:** "Okay, be honest. Who is the GOAT?"
- **What it means:** A classic friendly debate with no correct answer. She wants your opinion and a reason.
- **Terms implied:** goat-debate, peak-vs-longevity
- **conceptIds:** `conv-debate-lightly`, `goat-debate`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "I am still learning, but I keep hearing peak versus longevity. Which matters more to you?" | +24 | Honest, curious, and hands her the mic. |
| meh | "Jordan, obviously." | +3 | A safe pick, but you do not have a reason yet. |
| cringe | "Actually the stats show it is a tie." | -14 | Do not cite what you have not read. |

```json
{
  "title": "The GOAT question",
  "setting": "Watching highlights together.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Okay, be honest. Who is the GOAT?",
      "replies": [
        {
          "id": "good-honest",
          "text": "I am still learning, but I keep hearing peak versus longevity. Which matters more to you?",
          "smoothDelta": 24,
          "theirResponse": "Longevity, honestly. Ask me why in about an hour.",
          "coachNote": "Honest, curious, and hands her the mic."
        },
        {
          "id": "meh-name",
          "text": "Jordan, obviously.",
          "smoothDelta": 3,
          "theirResponse": "Ha, obviously? Okay.",
          "coachNote": "A safe pick, but you do not have a reason yet."
        },
        {
          "id": "cringe-stats",
          "text": "Actually the stats show it is a tie.",
          "smoothDelta": -14,
          "theirResponse": "The stats? Which ones?",
          "coachNote": "Do not cite what you have not read."
        }
      ]
    }
  ],
  "closingNote": "There is no right answer. What matters is being fun to argue with."
}
```

### 3.5 He is a hooper

- **Lesson:** `con-06` | **Setting:** Group chat during a game.
- **Enthusiast line:** "He is a hooper. Not just a scorer, a hooper."
- **What it means:** A hooper is a complete, skilled player who can do a bit of everything.
- **Terms implied:** positionless-basketball, role-player
- **conceptIds:** `positionless-basketball`, `conv-honest-beginner`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "What is the difference between a scorer and a hooper?" | +22 | Asking is charming. It shows you want the nuance. |
| meh | "Yeah he is really good." | +4 | Warm, but vague. |
| cringe | "I thought hoopers were the ones who play in the street." | -6 | Honesty is good. Guessing wrong out loud is a bit cringe. Ask. |

```json
{
  "title": "He is a hooper",
  "setting": "Group chat during a game.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "He is a hooper. Not just a scorer, a hooper.",
      "replies": [
        {
          "id": "good-ask-def",
          "text": "What is the difference between a scorer and a hooper?",
          "smoothDelta": 22,
          "theirResponse": "A scorer just gets buckets. A hooper passes, defends, makes the right read.",
          "coachNote": "Asking is charming. It shows you want the nuance."
        },
        {
          "id": "meh-yeah",
          "text": "Yeah he is really good.",
          "smoothDelta": 4,
          "theirResponse": "He is.",
          "coachNote": "Warm, but vague."
        },
        {
          "id": "cringe-wrong",
          "text": "I thought hoopers were the ones who play in the street.",
          "smoothDelta": -6,
          "theirResponse": "Well... sort of, but no.",
          "coachNote": "Honesty is good. Guessing wrong out loud is a bit cringe. Ask."
        }
      ]
    }
  ],
  "closingNote": "Slang is friendly. Ask what it means."
}
```

### 3.6 Busted bracket

- **Lesson:** `con-03` | **Setting:** Texting after a first-round upset.
- **Enthusiast line:** "My bracket is dead. A 14 seed just beat my national champion."
- **What it means:** A huge upset. A 14 seed defeated a top seed.
- **Terms implied:** bracket, cinderella
- **conceptIds:** `selection-sunday`, `cinderella`, `conv-celebrate-win`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "Wow. Was it a Cinderella story? Tell me who they are." | +22 | You turned her loss into a story. Very smooth. |
| meh | "That sucks. Mine is dead too." | +5 | Relatable, but you can do more. |
| cringe | "Your picks were bad then." | -15 | Never roast the bracket. Everyone knows it is chaos. |

```json
{
  "title": "Busted bracket",
  "setting": "Texting after a first-round upset.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "My bracket is dead. A 14 seed just beat my national champion.",
      "replies": [
        {
          "id": "good-cinder",
          "text": "Wow. Was it a Cinderella story? Tell me who they are.",
          "smoothDelta": 22,
          "theirResponse": "A tiny school from a conference nobody watches. Honestly it is amazing.",
          "coachNote": "You turned her loss into a story. Very smooth."
        },
        {
          "id": "meh-oops",
          "text": "That sucks. Mine is dead too.",
          "smoothDelta": 5,
          "theirResponse": "Ha, everybody's is.",
          "coachNote": "Relatable, but you can do more."
        },
        {
          "id": "cringe-bad",
          "text": "Your picks were bad then.",
          "smoothDelta": -15,
          "theirResponse": "Wow, okay.",
          "coachNote": "Never roast the bracket. Everyone knows it is chaos."
        }
      ]
    }
  ],
  "closingNote": "March is about stories. Ask for the story."
}
```

### 3.7 Can't defend the switch

- **Lesson:** `con-04` | **Setting:** During a game.
- **Enthusiast line:** "They switched everything and we got a mismatch again."
- **What it means:** Her team lost a defensive battle after defenders swapped, leaving a mismatch.
- **Terms implied:** switch, mismatch
- **conceptIds:** `switch`, `conv-ask-follow-up`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "Who ended up guarding whom? A big on a guard?" | +23 | A specific question that shows the mismatch. |
| meh | "That is a bad matchup." | +4 | True, but you can go deeper. |
| cringe | "Just play drop coverage." | -13 | Do not prescribe a scheme you do not know yet. |

```json
{
  "title": "Can't defend the switch",
  "setting": "During a game.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They switched everything and we got a mismatch again.",
      "replies": [
        {
          "id": "good-who",
          "text": "Who ended up guarding whom? A big on a guard?",
          "smoothDelta": 23,
          "theirResponse": "Exactly, our center on their quickest guard. It is a layup line.",
          "coachNote": "A specific question that shows the mismatch."
        },
        {
          "id": "meh-bad",
          "text": "That is a bad matchup.",
          "smoothDelta": 4,
          "theirResponse": "The worst.",
          "coachNote": "True, but you can go deeper."
        },
        {
          "id": "cringe-drop",
          "text": "Just play drop coverage.",
          "smoothDelta": -13,
          "theirResponse": "Drop against this offense? That is not going to work.",
          "coachNote": "Do not prescribe a scheme you do not know yet."
        }
      ]
    }
  ],
  "closingNote": "A mismatch is the whole game. Ask who is on whom."
}
```

### 3.8 Playoff night in the W

- **Lesson:** `con-03` | **Setting:** Texting during a WNBA playoff game.
- **Enthusiast line:** "We are up 2 in the fourth and the crowd is deafening."
- **What it means:** The fans are in a high-pressure, high-energy playoff moment.
- **Terms implied:** wnba-playoff-format, wnba-fandom
- **conceptIds:** `wnba-fandom`, `conv-celebrate-win`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "That sounds so tense. Is the last two minutes always this loud?" | +20 | You mirror the excitement and ask a real question. |
| meh | "Go team!" | +5 | Friendly. Add a question next time. |
| cringe | "Honestly the W is not as good as the NBA." | -18 | Never compare leagues to be clever. It ends the conversation. |

```json
{
  "title": "Playoff night in the W",
  "setting": "Texting during a WNBA playoff game.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We are up 2 in the fourth and the crowd is deafening.",
      "replies": [
        {
          "id": "good-nerves",
          "text": "That sounds so tense. Is the last two minutes always this loud?",
          "smoothDelta": 20,
          "theirResponse": "Every playoff game. My hands are shaking.",
          "coachNote": "You mirror the excitement and ask a real question."
        },
        {
          "id": "meh-go",
          "text": "Go team!",
          "smoothDelta": 5,
          "theirResponse": "Thanks! Keep the vibes coming.",
          "coachNote": "Friendly. Add a question next time."
        },
        {
          "id": "cringe-w",
          "text": "Honestly the W is not as good as the NBA.",
          "smoothDelta": -18,
          "theirResponse": "Please do not.",
          "coachNote": "Never compare leagues to be clever. It ends the conversation."
        }
      ]
    }
  ],
  "closingNote": "Show up for the moment, not the debate."
}
```

### 3.9 Trade news

- **Lesson:** `con-04` | **Setting:** Texting when trade news breaks.
- **Enthusiast line:** "We just gave up three picks for him. Is that too much?"
- **What it means:** Her team traded draft picks for a star. She is asking if the price was too high.
- **Terms implied:** trade, nba-draft
- **conceptIds:** `trade`, `trade-exception`, `conv-ask-follow-up`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "Depends how good he is. What does it do for the team this year?" | +20 | You balanced the price against the benefit. That is exactly how fans argue. |
| meh | "I am sure the front office knows." | +3 | Polite, but it closes the conversation. |
| cringe | "Picks do not matter anyway." | -14 | Picks are the currency of building a team. Do not dismiss them. |

```json
{
  "title": "Trade news",
  "setting": "Texting when trade news breaks.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We just gave up three picks for him. Is that too much?",
      "replies": [
        {
          "id": "good-price",
          "text": "Depends how good he is. What does it do for the team this year?",
          "smoothDelta": 20,
          "theirResponse": "He is a top-10 player. It makes us a real contender right now.",
          "coachNote": "You balanced the price against the benefit. That is exactly how fans argue."
        },
        {
          "id": "meh-trust",
          "text": "I am sure the front office knows.",
          "smoothDelta": 3,
          "theirResponse": "I guess.",
          "coachNote": "Polite, but it closes the conversation."
        },
        {
          "id": "cringe-tank",
          "text": "Picks do not matter anyway.",
          "smoothDelta": -14,
          "theirResponse": "They absolutely matter.",
          "coachNote": "Picks are the currency of building a team. Do not dismiss them."
        }
      ]
    }
  ],
  "closingNote": "Trade talk is about price and fit. Ask about both."
}
```

### 3.10 They are in the bonus

- **Lesson:** `con-08` | **Setting:** Texting during a game.
- **Enthusiast line:** "We are in the bonus. Every foul is free throws now."
- **What it means:** The other team has too many fouls in the period, so every foul now sends her team to the line.
- **Terms implied:** team-fouls-bonus, free-throw
- **conceptIds:** `conv-text-live`, `team-fouls-bonus`

| Style | Reply | Smooth | Coach note |
|---|---|---|---|
| good | "Nice. Is this when the coach tells them to attack the rim?" | +22 | You used the rule to ask a strategy question. |
| meh | "Cool, so they get free throws." | +4 | Correct, but it does not move the chat. |
| cringe | "Wait, do they get to skip the shot clock?" | -8 | A guess that mixes up rules. Try asking what the bonus means. |

```json
{
  "title": "They are in the bonus",
  "setting": "Texting during a game.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We are in the bonus. Every foul is free throws now.",
      "replies": [
        {
          "id": "good-follow",
          "text": "Nice. Is this when the coach tells them to attack the rim?",
          "smoothDelta": 22,
          "theirResponse": "Exactly! Drive at the rim and draw the foul.",
          "coachNote": "You used the rule to ask a strategy question."
        },
        {
          "id": "meh-cool",
          "text": "Cool, so they get free throws.",
          "smoothDelta": 4,
          "theirResponse": "Right.",
          "coachNote": "Correct, but it does not move the chat."
        },
        {
          "id": "cringe-wrong",
          "text": "Wait, do they get to skip the shot clock?",
          "smoothDelta": -8,
          "theirResponse": "No, why would they?",
          "coachNote": "A guess that mixes up rules. Try asking what the bonus means."
        }
      ]
    }
  ],
  "closingNote": "Rules help you ask better questions. Use them."
}
```

## 4. Playbook terms (84 of the 389 concepts have Playbook cards at launch)

Each Playbook card shows the term, a plain-English definition, and an example line in the voice of the person you are learning for (serif, in quotes). Categories: Basics, Court, Rules, Actions, Offense, Strategy, Defense, Analytics, League, Money, College, Slang. Definitions are Swoon'd's own words. Numbers reflect the 2025-26 and 2026-27 seasons; anything that changes yearly (cap figures, season length) is served from live data instead of these cards.

| # | Term | Category | Definition | Example line |
|---|---|---|---|---|
| 1 | Possession | Basics | One team's turn with the ball, ending in a shot, turnover or foul that changes control. | "We had 20 more shots but they had more possessions off our turnovers." |
| 2 | Shot clock | Basics | The timer limiting how long a team can hold the ball before shooting: 24 seconds in the NBA and WNBA, 30 in college. | "They ran out the shot clock and heaved it." |
| 3 | Paint | Court | The painted lane near the basket; also called the key. | "They scored fifty points in the paint." |
| 4 | Restricted area | Court | The four-foot arc under the basket where a help defender cannot draw a charge. | "He was standing in the restricted area, so it was a block, not a charge." |
| 5 | Elbow | Court | The corner where the free-throw line meets the lane. | "He catches at the elbow and everyone cuts around him." |
| 6 | Corner three | Court | A three-pointer from the corner, the shortest three at 22 feet in the NBA. | "He only takes corner threes. That is his whole game." |
| 7 | Bonus | Rules | When a team has enough fouls in a period that every foul sends the other team to the line. | "We are in the bonus, so we are going to the line every time down." |
| 8 | And-one | Rules | A made basket while being fouled, earning one extra free throw. | "He got the and-one, and the whole arena erupted." |
| 9 | Charge | Rules | An offensive foul on a player who runs into a defender who has set his position. | "That was a charge, he got there first and was set." |
| 10 | Blocking foul | Rules | A foul on a defender who is not set when the offensive player collides with him. | "Blocking foul, he slid in late." |
| 11 | Goaltending | Rules | Touching a shot on its way down or on the rim, so the basket counts. | "The ref called goaltending, so the basket counted." |
| 12 | Traveling | Rules | Taking too many steps without dribbling. | "That was two steps and a gather. Is that a travel or not?" |
| 13 | Double dribble | Rules | Dribbling, stopping, and dribbling again, or dribbling with both hands. | "He picked up the dribble then started again, double dribble." |
| 14 | Carry | Rules | When a dribbler palms the ball and turns it over, sometimes also called palming. | "He carried it all the way, that is a carry." |
| 15 | Technical foul | Rules | A foul for conduct or delay rather than contact, usually one free throw. | "He got a tech for yelling at the ref." |
| 16 | Flagrant foul | Rules | Excessive or unnecessary contact, with heavier penalties. | "He got a flagrant one for that hard foul." |
| 17 | Foul out | Rules | A player is disqualified after too many personal fouls: six in the NBA and WNBA, five in college. | "He fouled out with four minutes left, which killed us." |
| 18 | Pick-and-roll | Actions | A screen for the ball handler, then the screener moves to the basket. | "They run the pick-and-roll about forty times a game." |
| 19 | Pick-and-pop | Actions | A screen where the screener steps out for a jump shot instead of rolling. | "He is a big who pops. Defenders hate it." |
| 20 | Screen | Actions | A legal block using the body to free a teammate. | "Set a better screen!" |
| 21 | Handoff | Actions | A pass handed directly to a teammate who runs off it. | "They live off handoffs at the top of the key." |
| 22 | Iso | Actions | Isolation: one player attacks his defender one-on-one while teammates stay out of the way. | "It is iso ball at the end of the shot clock." |
| 23 | Post-up | Actions | Playing with his back to the basket near the block or elbow. | "He posts up and everybody double-teams him." |
| 24 | Cut | Actions | A quick movement toward the basket to get open. | "A backdoor cut is the easiest layup." |
| 25 | Backdoor cut | Actions | A cut behind a defender who is overplaying the pass. | "She backdoor cut and got a layup." |
| 26 | Spacing | Offense | How players spread the floor so defenders cannot help easily. | "The spacing is terrible with two bigs." |
| 27 | Gravity | Offense | A player's pull on defenders because of shooting or scoring threat. | "His gravity opens the lane for everyone." |
| 28 | Drive and kick | Offense | Attacking the rim, then passing to an open shooter. | "They drive and kick until someone is open." |
| 29 | Skip pass | Offense | A pass across the court that skips a teammate to reach the open shooter. | "That skip pass to the corner was perfect." |
| 30 | Pocket pass | Offense | A bounce or short pass to a rolling screener from the ball handler. | "He hit the roller with a pocket pass." |
| 31 | Fast break | Offense | A quick attack before the defense gets set. | "They score fifteen points a game on the fast break." |
| 32 | Transition | Basics | The scramble from defense to offense or the reverse after a change of possession. | "Their transition defense is awful." |
| 33 | Late clock | Offense | The final seconds of the shot clock. | "Late-clock possessions are hard, so a star bails you out." |
| 34 | Two-for-one | Strategy | Shooting early with about 30+ seconds left so you get the last shot too. | "They went for a two-for-one and got both shots." |
| 35 | Foul when up three | Strategy | A strategy of fouling before a three-point attempt in the last seconds. | "Do you foul up three or not? Coaches disagree." |
| 36 | Timeout | Strategy | A stoppage called by a team to rest, draw up a play or stop a run. | "Take a timeout before it gets worse." |
| 37 | ATO | Strategy | After-timeout play, a set designed during a stoppage. | "They ran a great ATO for a wide-open three." |
| 38 | Small ball | Strategy | Lineups with smaller, quicker players instead of two big men. | "They went small in the fourth." |
| 39 | Rotation | Strategy | Which players play, when, and in which lineups. | "His rotation is way too short." |
| 40 | Load management | Strategy | Resting healthy players to protect them for later. | "He sat because of load management." |
| 41 | Back-to-back | Strategy | Two games on consecutive nights. | "It is the second night of a back-to-back, so he sits." |
| 42 | Man-to-man | Defense | Each defender is responsible for one opponent. | "They are mostly man-to-man." |
| 43 | Zone | Defense | Defenders guard areas instead of specific players. | "They switched to a 2-3 zone and we could not shoot." |
| 44 | Help defense | Defense | A defender leaves his man to stop a drive, and teammates rotate. | "The help was late again." |
| 45 | Rotation (defense) | Defense | The chain of defenders sliding over after help leaves a player open. | "Their rotations are slow." |
| 46 | Closeout | Defense | Sprinting at a shooter who just received a pass. | "He closed out under control." |
| 47 | Box out | Defense | Using your body to seal an opponent from the rebound. | "Nobody boxed out and they got the board." |
| 48 | Switch | Defense | Two defenders trade the players they are guarding. | "They switch everything, so screens do not work." |
| 49 | Drop coverage | Defense | The screener's defender sinks toward the basket on a pick-and-roll. | "They play drop and give up the pull-up." |
| 50 | Hedge | Defense | A brief step out by the screener's defender to slow the ball handler. | "He hedged and recovered." |
| 51 | Blitz | Defense | Trapping the ball handler with two defenders. | "They blitzed him and he gave it up." |
| 52 | Rim protector | Defense | A big who alters or blocks shots at the basket. | "We need a real rim protector." |
| 53 | Press | Defense | Full-court pressure to force turnovers. | "They pressed us in the last four minutes." |
| 54 | Effective field goal percentage | Analytics | A shooting stat that counts threes as worth 1.5 twos. | "His eFG% is way higher than his FG%." |
| 55 | True shooting | Analytics | A scoring efficiency stat that also counts free throws. | "His true shooting is elite." |
| 56 | Usage rate | Analytics | The share of team possessions a player ends while he is on the floor. | "His usage is huge, but he is efficient." |
| 57 | Net rating | Analytics | A team's point differential per 100 possessions. | "They have the best net rating in the league." |
| 58 | Pace | Analytics | Possessions per game. | "They like to play at a fast pace." |
| 59 | Plus-minus | Analytics | The score margin while a player is on the court. | "He was plus-20 in that game." |
| 60 | Draft lottery | League | A weighted lottery for the non-playoff teams that decides top draft picks. | "They have the best odds in the lottery." |
| 61 | Tanking | League | Losing on purpose to improve a draft pick. | "We are not tanking, we are just bad." |
| 62 | Play-In | League | A mini tournament that decides the 7th and 8th seeds in each conference. | "We are in the Play-In again." |
| 63 | Seed | League | A team's playoff ranking. | "They are the 3 seed." |
| 64 | Sweep | League | Winning a playoff series 4-0. | "We got swept." |
| 65 | NBA Cup | League | An in-season tournament with group play and a knockout round. | "Winning the Cup is fun but it is not a title." |
| 66 | Salary cap | Money | A payroll threshold that limits how teams sign free agents. | "They have no cap space." |
| 67 | Luxury tax | Money | A penalty paid by teams whose payroll is over the tax line. | "They are paying a huge luxury tax." |
| 68 | Apron | Money | A payroll line above the tax that adds trade and signing restrictions. | "The second apron limits everything." |
| 69 | Bird rights | Money | The right to exceed the cap to re-sign your own player. | "They have Bird rights, so they can keep him." |
| 70 | Sign-and-trade | Money | A free agent re-signs, then is traded to a new team. | "They pulled off a sign-and-trade." |
| 71 | Two-way contract | Money | A contract letting a player split time between the NBA and G League. | "He is on a two-way deal." |
| 72 | Trade exception | Money | A credit that lets a team absorb salary in a later trade. | "They have a trade exception." |
| 73 | Buyout | Money | A player and team agree to end a contract early, often in-season. | "He was bought out and signed with a contender." |
| 74 | Transfer portal | College | The system that lets college players transfer without sitting out. | "He entered the portal." |
| 75 | NIL | College | Name, image and likeness deals for college athletes. | "NIL money changed the whole recruiting scene." |
| 76 | Bubble | College | A team near the cutoff for the NCAA tournament. | "They are on the bubble." |
| 77 | Cinderella | College | A small-conference team that makes a deep tournament run. | "Everyone loves a Cinderella." |
| 78 | Blue blood | College | A traditional powerhouse program with a long history of winning. | "That is a blue blood matchup." |
| 79 | Hooper | Slang | A skilled, complete basketball player, more than just a scorer. | "He is a true hooper." |
| 80 | Cooking | Slang | Playing extremely well, scoring at will. | "He is cooking tonight." |
| 81 | Heat check | Slang | Taking a tough shot after a streak to test whether you are hot. | "That was a heat check and it went in." |
| 82 | Bucket | Slang | A basket or a scorer. | "He is a walking bucket." |
| 83 | Posterize | Slang | To dunk over a defender so hard it looks like a poster. | "He posterized the center." |
| 84 | Ref ball | Slang | Fan slang for calls that seem to help one team. | "That was ref ball, no doubt." |

## 5. Authoring and QA notes

1. Payload validity: run `cd tools/validate && node validate.mjs` once curriculum JSON exists; the same schemas were used to check the samples above.
2. Every activity must carry `conceptIds` that exist in the curriculum `concepts[]`; concept ids used in the samples are listed in the CDS Curriculum map.
3. Diagram-based items (binary-call, hotspot-tap) need the procedural diagram ids `bball-half-court` and `bball-full-court` implemented in SwoondApp (Claude Code). Marker and hotspot coordinates follow the convention above.
4. Visual-id items need eight or more original referee-signal illustrations by design; asset ids in the samples are placeholders under `illustrations/` in the content pack, license `swoond-original-illustration`.
5. Rules that differ by league (shot clock 24 vs 30, fouls 6 vs 5, quarters vs halves, ball size, arc distance) are tagged with the league branch in the curriculum so an NBA learner is not tested on college rules and vice versa.
6. Voice review before release: one joke per screen at most, never about the crush, no shaming.
