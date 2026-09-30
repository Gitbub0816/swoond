# Native Exercise Plan: Baseball (`baseball`)

Tier B plan for `docs/courses/baseball/`. All 13 native exercise types are used; the three Tier A sims are in `sims/`. Every sample payload in sections 2 and 4 validates against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup, see the check command at the end). Conventions: prompts are 12 words or fewer; every answer is explained; `license` ids are `original-swoond` (procedural or original art and audio); diagram ids (`baseball-diamond`, `strike-zone-72in`, `box-score-sample`, `line-score-sample`) are drawn natively from coordinate data (feet, see CDS section 14); planned lesson ids are given per sample. Voice: warm, a little flirty, never condescending; nothing here mocks a team or a fan.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite: rules, definitions, stats, roster mechanics. Distractors are the misconceptions in CDS section 2 (foul balls, ERA, saves, tag-up, pitch clock). | ~260 |
| `binary-call` | Rule calls on a `baseball-diamond` diagram: force or tag, fair or foul, infield fly on or off, ABS in or out, who may challenge. | ~80 |
| `term-match` | Introduce 3 to 6 related terms at the start of a unit (positions, pitch types, stats, roster roles) and in Term Blitz reviews. | ~45 |
| `sequence-order` | Ordering a plate appearance, a double play, the postseason ladder, the minor-league path, scorekeeping symbols. | ~30 |
| `visual-id` | Recognising pitch shapes, line scores and park features from original illustrations (no photos, no logos). | ~35 |
| `decision-scenario` | Manager and coach judgment with a facts table (inning, outs, runners, score, handedness): pull the starter, bunt, walk him, steal; plus ballpark etiquette and safety. | ~90 |
| `talk-track` | Conversation practice: 24 tracks at launch (section 4 lists ten in full). | 24 |
| `timing-tap` | 1D rhythm only: the pitch clock, a steal jump, a barrel. Anything in a scene (baserunning, alignment, pitch flight) is Unity. | ~10 |
| `say-this` | Decode what she just said: bullpen rants, count talk, standings talk, rule complaints, lockout talk. Each has follow-up lines that are honest curiosity. | ~85 |
| `fill-the-gap` | Vocabulary and rule sentences in context; quick review cards. | ~60 |
| `listening-id` | Sounds of the ballpark from original synthesised or recorded audio: wood versus metal bat, glove pop, NPB-style cheering (original chants). A skip option is always available. | ~8 |
| `estimate-slider` | Magnitudes: 90 feet, 162 games, 17 inches, 18 seconds, exit velocity. | ~25 |
| `hotspot-tap` | Static diagrams: positions, cutoff, strike zone by batter height, box-score columns. | ~50 |

Cross-type rules: each lesson ends with an item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`. Estimated total: about 790 native items across 116 lessons and the review loop.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

**Sample 1** (lesson `game-02`)

```json
{
  "prompt": "How many outs end a half-inning?",
  "options": [
    { "id": "a", "text": "Two" },
    { "id": "b", "text": "Three" },
    { "id": "c", "text": "Four" },
    { "id": "d", "text": "As many as the pitcher can get" }
  ],
  "correctOptionIds": ["b"],
  "explanation": {
    "correct": "Three outs and the teams swap. Each inning has a top half for the visitors and a bottom half for the home team.",
    "incorrect": "It is three outs. Then the other team bats, so a full inning is six outs, three for each side.",
    "sayThisLine": "They got out of the inning with a double play."
  }
}
```

**Sample 2** (lesson `count-04`)

```json
{
  "prompt": "What happens on a foul ball with two strikes?",
  "options": [
    { "id": "a", "text": "It is strike three" },
    { "id": "b", "text": "The count stays at two strikes" },
    { "id": "c", "text": "A ball is added" }
  ],
  "correctOptionIds": ["b"],
  "explanation": {
    "correct": "A foul ball is a strike until two strikes; after that it just keeps the at-bat alive. That is why hitters can foul off pitch after pitch.",
    "incorrect": "With two strikes a foul does not become strike three. The count stays put, unless the batter tried to bunt it or the catcher caught it.",
    "sayThisLine": "He fouled off six pitches in that at-bat."
  }
}
```

**Sample 3** (lesson `score-04`)

```json
{
  "prompt": "Which runs does ERA leave out?",
  "options": [
    { "id": "a", "text": "Runs the pitcher earned", "explanation": "Those are the ones ERA counts." },
    { "id": "b", "text": "Unearned runs that scored because of an error" },
    { "id": "c", "text": "Runs scored in extra innings" },
    { "id": "d", "text": "Runs scored on home runs" }
  ],
  "correctOptionIds": ["b"],
  "explanation": {
    "correct": "ERA is earned runs per nine innings. Runs that score because a fielder made an error are unearned, so they do not count against the pitcher.",
    "incorrect": "ERA counts earned runs only. Runs that came home because of an error are unearned, and the official scorer decides which is which.",
    "sayThisLine": "His ERA looks better than it feels because of those errors."
  }
}
```

**Sample 4** (lesson `mod-01`)

```json
{
  "prompt": "How long does a pitcher have with the bases empty?",
  "options": [
    { "id": "a", "text": "12 seconds" },
    { "id": "b", "text": "15 seconds" },
    { "id": "c", "text": "18 seconds" },
    { "id": "d", "text": "20 seconds" }
  ],
  "correctOptionIds": ["b"],
  "explanation": {
    "correct": "Fifteen seconds with the bases empty, 18 with a runner on. The batter must be set in the box with eight seconds left, or he is charged a strike.",
    "incorrect": "It is 15 seconds with the bases empty; the clock was 20 with runners on in 2023 and was trimmed to 18 for 2024. A violation is an automatic ball or strike.",
    "sayThisLine": "The pitch clock got him on that one."
  }
}
```

### 2.2 `binary-call`

**Sample 1** (lesson `base-02`)

```json
{
  "prompt": "Runner on first, grounder to short. Force play?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "baseball-diamond",
    "markers": [
      { "role": "player", "x": 0.72, "y": 0.62 },
      { "role": "ball", "x": 0.4, "y": 0.47 },
      { "role": "target", "x": 0.5, "y": 0.42 }
    ],
    "alt": "Baseball diamond seen from above. A runner stands on first base, the ball is hit toward the shortstop, and second base is the target."
  },
  "choices": [
    { "id": "force", "label": "Force play" },
    { "id": "tag", "label": "Tag play" }
  ],
  "correctChoiceId": "force",
  "explanation": {
    "correct": "The batter must run to first, so the runner on first is forced to go to second. The fielder just needs to touch second base with the ball.",
    "incorrect": "A runner is forced when the batter's run to first pushes him along. That makes it a force play: touch the base, no tag needed.",
    "sayThisLine": "It is a force at second."
  },
  "ruleTag": "Force play"
}
```

**Sample 2** (lesson `def-04`)

```json
{
  "prompt": "Runners on first and second, one out, high pop-up. Batter out?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "baseball-diamond",
    "markers": [
      { "role": "player", "x": 0.72, "y": 0.62 },
      { "role": "player", "x": 0.5, "y": 0.42 },
      { "role": "ball", "x": 0.4, "y": 0.4 }
    ],
    "alt": "Baseball diamond with runners on first and second and a high pop-up over the shortstop."
  },
  "choices": [
    { "id": "out", "label": "Batter is out" },
    { "id": "play-on", "label": "Play on" }
  ],
  "correctChoiceId": "out",
  "explanation": {
    "correct": "That is an infield fly: runners on first and second (or bases loaded), fewer than two outs, and an easy pop-up. The batter is out immediately, even if it drops.",
    "incorrect": "It is the infield fly rule. With runners on and fewer than two outs, an easy pop-up makes the batter out at once, so the defense cannot drop it on purpose to turn a double play.",
    "sayThisLine": "Infield fly rule, the batter is out."
  },
  "ruleTag": "Infield fly rule"
}
```

**Sample 3** (lesson `count-04`)

```json
{
  "prompt": "Two strikes. Foul ball into the stands. Strikeout?",
  "scene": {
    "kind": "none",
    "alt": "No diagram. The batter has two strikes and fouls the pitch into the seats."
  },
  "choices": [
    { "id": "strikeout", "label": "Strikeout" },
    { "id": "alive", "label": "Still alive" }
  ],
  "correctChoiceId": "alive",
  "explanation": {
    "correct": "A foul with two strikes is not strike three, so the at-bat continues. The count stays two strikes.",
    "incorrect": "A foul ball does not end the at-bat with two strikes. The batter stays alive, which is why long at-bats happen.",
    "sayThisLine": "He is still alive with two strikes."
  },
  "ruleTag": "Two-strike foul"
}
```

**Sample 4** (lesson `mod-04`)

```json
{
  "prompt": "Can the manager call the ABS challenge?",
  "scene": {
    "kind": "none",
    "alt": "No diagram. A batter taps his helmet after a called strike."
  },
  "choices": [
    { "id": "yes", "label": "Yes" },
    { "id": "no", "label": "No" }
  ],
  "correctChoiceId": "no",
  "explanation": {
    "correct": "Only the batter, pitcher or catcher may challenge, within two seconds, by tapping the head. The dugout cannot call it for them.",
    "incorrect": "The manager cannot. The batter, pitcher or catcher decides in about two seconds, and each team starts with two challenges (2026 rules, verify at release).",
    "sayThisLine": "He tapped his helmet right away."
  },
  "ruleTag": "ABS challenge"
}
```

### 2.3 `term-match`

**Sample 1** (lesson `pit-01`)

```json
{
  "prompt": "Match each pitch to how it moves.",
  "pairs": [
    { "id": "four-seam", "term": "Four-seam fastball", "definition": "Fast and straight; holds its height more than the others" },
    { "id": "sinker", "term": "Sinker", "definition": "Fast, runs toward the arm side and drops" },
    { "id": "slider", "term": "Slider", "definition": "Hard breaking ball with a sharp sideways bite" },
    { "id": "curveball", "term": "Curveball", "definition": "Slower breaking ball with a big top-to-bottom drop" },
    { "id": "changeup", "term": "Changeup", "definition": "Looks like a fastball but arrives much slower" }
  ],
  "distractorDefinitions": ["A pitch thrown underhand from the rubber"],
  "explanation": {
    "summary": "Fastballs stay quick and straight, breaking balls bend, and the changeup fools you with speed. Hitters read the difference in the first few feet.",
    "sayThisLine": "That was a slider, it broke sideways."
  }
}
```

**Sample 2** (lesson `score-03`)

```json
{
  "prompt": "Match each stat to what it measures.",
  "pairs": [
    { "id": "avg", "term": "Batting average", "definition": "Hits divided by at-bats" },
    { "id": "obp", "term": "On-base percentage", "definition": "How often a batter reaches base, walks included" },
    { "id": "slg", "term": "Slugging percentage", "definition": "Total bases per at-bat; rewards extra-base hits" },
    { "id": "ops", "term": "OPS", "definition": "On-base plus slugging, added together" }
  ],
  "explanation": {
    "summary": "Batting average counts hits only. On-base adds walks, slugging adds power, and OPS glues the two together in one number.",
    "sayThisLine": "His OPS is the number that really tells the story."
  }
}
```

**Sample 3** (lesson `pit-04`)

```json
{
  "prompt": "Match the pitcher to the job.",
  "pairs": [
    { "id": "starter", "term": "Starting pitcher", "definition": "Begins the game and tries to go deep" },
    { "id": "closer", "term": "Closer", "definition": "Usually finishes close games in the ninth" },
    { "id": "setup", "term": "Setup man", "definition": "Pitches the inning before the closer" },
    { "id": "opener", "term": "Opener", "definition": "Starts for an inning or two before a longer arm follows" }
  ],
  "explanation": {
    "summary": "A game is a relay: starter first, then setup men, then the closer. An opener flips that order to dodge the toughest part of the lineup.",
    "sayThisLine": "They used an opener and then a bulk guy."
  }
}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `oct-01`)

```json
{
  "prompt": "Put the MLB postseason rounds in order.",
  "items": [
    { "id": "wc", "text": "Wild Card Series (best of three)", "why": "The four lowest seeds in each league play for a spot in the next round." },
    { "id": "ds", "text": "Division Series (best of five)", "why": "Top two seeds get a bye, then face the winners." },
    { "id": "cs", "text": "League Championship Series (best of seven)", "why": "Decides each league's pennant." },
    { "id": "ws", "text": "World Series (best of seven)", "why": "The American and National League champions meet." }
  ],
  "explanation": {
    "correct": "Wild card, division series, league championship, World Series. The bye is the reward for a top-two seed.",
    "incorrect": "The ladder is Wild Card Series, Division Series, League Championship Series, World Series. Twelve teams enter and shrink to two.",
    "sayThisLine": "They had the bye, so they skipped the wild card round."
  }
}
```

**Sample 2** (lesson `base-07`)

```json
{
  "prompt": "Order a 6-4-3 double play.",
  "items": [
    { "id": "hit", "text": "Grounder is hit to the shortstop", "why": "The 6 in 6-4-3 is the shortstop." },
    { "id": "throw-2b", "text": "Shortstop throws to second base", "why": "The runner from first is forced out at second." },
    { "id": "relay", "text": "Second baseman touches second, then throws to first", "why": "The 4 turns it and completes the play." },
    { "id": "out-1b", "text": "First baseman catches it: batter is out", "why": "The 3 is the first baseman; two outs on one play." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Shortstop, second baseman, first baseman: 6, 4, 3. One ball hit, two outs recorded.",
    "incorrect": "Follow the numbers: shortstop (6), second baseman (4), first baseman (3). The lead runner goes first, then the batter.",
    "sayThisLine": "That was a 6-4-3 double play."
  }
}
```

**Sample 3** (lesson `front-02`)

```json
{
  "prompt": "Order the minor-league path to the majors.",
  "items": [
    { "id": "sa", "text": "Single-A", "why": "Where most drafted players begin." },
    { "id": "ha", "text": "High-A", "why": "A step up in age and polish." },
    { "id": "aa", "text": "Double-A", "why": "Often the big test for prospects." },
    { "id": "aaa", "text": "Triple-A", "why": "One phone call from the majors." },
    { "id": "mlb", "text": "The majors", "why": "The call-up: 26-man active roster." }
  ],
  "explanation": {
    "correct": "Single-A, High-A, Double-A, Triple-A, then the majors. Players can skip levels, or move back down.",
    "incorrect": "The usual ladder is Single-A, High-A, Double-A, Triple-A, majors. Fans talk about a call-up when someone gets the last step.",
    "sayThisLine": "They called him up from Triple-A this morning."
  }
}
```

### 2.5 `visual-id`

**Sample 1** (lesson `pit-02`)

```json
{
  "prompt": "Which flight path is the curveball?",
  "image": {
    "asset": "images/baseball/pitch-flight-arcs.svg",
    "alt": "Side view of four pitch paths from mound to plate. Path A is nearly flat, path B bends sideways, path C drops steeply late, path D fades and slows.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "a", "text": "Path A, nearly flat" },
    { "id": "b", "text": "Path B, bends sideways" },
    { "id": "c", "text": "Path C, steep late drop" },
    { "id": "d", "text": "Path D, slow fade" }
  ],
  "correctOptionId": "c",
  "explanation": {
    "correct": "The curveball's topspin pulls it down hard and late, so the drop is the giveaway.",
    "incorrect": "A curveball is the one with the big top-to-bottom drop. Flat is a fastball, sideways is a slider, slow fade is a changeup."
  },
  "cues": ["Topspin", "Late steep drop", "Slower than a fastball"]
}
```

**Sample 2** (lesson `score-01`)

```json
{
  "prompt": "What does the E column on a line score show?",
  "image": {
    "asset": "images/baseball/line-score-sample.svg",
    "alt": "A line score with two rows of inning numbers and three final columns labeled R, H and E.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "a", "text": "Extra innings" },
    { "id": "b", "text": "Errors" },
    { "id": "c", "text": "Earned runs" }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "R is runs, H is hits, E is errors: the three numbers at the end of every line score.",
    "incorrect": "E is errors. The last three columns are always runs, hits and errors, so you can read a game at a glance."
  },
  "cues": ["R runs", "H hits", "E errors"]
}
```

**Sample 3** (lesson `cult-03`)

```json
{
  "prompt": "Which park feature is this?",
  "image": {
    "asset": "images/baseball/tall-left-field-wall.svg",
    "alt": "Illustration of a very tall green wall in left field of a small old ballpark, close to the infield.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "a", "text": "The Green Monster" },
    { "id": "b", "text": "The ivy wall" },
    { "id": "c", "text": "The warning track" }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Fenway Park's tall left-field wall is called the Green Monster. Short distance, huge wall: line drives turn into doubles.",
    "incorrect": "That tall green wall is the Green Monster at Fenway Park. The ivy is Wrigley Field's outfield wall."
  },
  "cues": ["Very tall", "Green", "Close to home plate"]
}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `strat-02`)

```json
{
  "prompt": "Your starter is tiring in the seventh. What now?",
  "situation": {
    "narrative": "You are the manager. Your team leads by one run.",
    "facts": [
      { "label": "Inning", "value": "Bottom 7th, one out" },
      { "label": "Score", "value": "Leading 3-2" },
      { "label": "Starter pitch count", "value": "98 pitches" },
      { "label": "Batter", "value": "Left-handed slugger, third time up" },
      { "label": "Bullpen", "value": "Rested lefty ready", "emphasis": "warning" }
    ]
  },
  "options": [
    { "id": "stay", "label": "Leave him in", "verdict": "poor", "consequence": "The starter is tired, facing the lineup a third time, and he leaves a fastball over the plate.", "considerations": ["High pitch count", "Third time through the order favors the hitter"] },
    { "id": "lefty", "label": "Bring in the rested lefty", "verdict": "best", "consequence": "The fresh lefty gets the slugger out and the lead holds into the eighth.", "considerations": ["Handedness matchup", "Fresh arm at high leverage"] },
    { "id": "closer", "label": "Bring in the closer now", "verdict": "acceptable", "consequence": "The closer gets the out but has to record eight more outs, and he may not be there for the ninth.", "considerations": ["Uses your best arm early", "Workload matters"] }
  ],
  "expertNote": "Managers weigh leverage, matchups and rest. The best arm is not always used at the biggest moment; it is used when it matters and can still finish.",
  "sayThisLine": "They should have gone to the bullpen earlier."
}
```

**Sample 2** (lesson `hit-04`)

```json
{
  "prompt": "Tie game, runner on first, nobody out. Bunt?",
  "situation": {
    "narrative": "You manage the home team in a close game.",
    "facts": [
      { "label": "Inning", "value": "Bottom 9th" },
      { "label": "Score", "value": "Tied 2-2" },
      { "label": "Runner", "value": "On first, nobody out" },
      { "label": "Batter", "value": "Good bunter, weak hitter" },
      { "label": "On deck", "value": "Two strong hitters" }
    ]
  },
  "options": [
    { "id": "bunt", "label": "Sacrifice bunt", "verdict": "best", "consequence": "The runner moves to second with one out, and a single wins it.", "considerations": ["Gets the winning run into scoring position", "Weak hitter, strong hitters follow"] },
    { "id": "swing", "label": "Swing away", "verdict": "acceptable", "consequence": "A double play is possible with the weak hitter, but a hit could also win it.", "considerations": ["Double play risk", "Chance of a hit"] },
    { "id": "steal", "label": "Steal second", "verdict": "poor", "consequence": "The runner is thrown out and you lose a base runner with nobody out.", "considerations": ["Risk of the out", "Two good hitters coming"] }
  ],
  "expertNote": "The sacrifice bunt trades an out for a base. Analytics folks dislike it early, but in a tied ninth with weak hitters up it is still a sensible bet.",
  "sayThisLine": "The bunt makes sense with those hitters coming up."
}
```

**Sample 3** (lesson `strat-03`)

```json
{
  "prompt": "First base is open, two outs. Walk the slugger?",
  "situation": {
    "narrative": "You manage the defense in a one-run game.",
    "facts": [
      { "label": "Inning", "value": "Top 8th, two outs" },
      { "label": "Score", "value": "You lead 4-3" },
      { "label": "Runner", "value": "On second base" },
      { "label": "Batter", "value": "League home-run leader" },
      { "label": "On deck", "value": "Weak-hitting catcher" }
    ]
  },
  "options": [
    { "id": "walk", "label": "Intentional walk", "verdict": "best", "consequence": "The slugger walks, the catcher makes the third out.", "considerations": ["First base is open", "Force play possible at any base"] },
    { "id": "pitch", "label": "Pitch to him", "verdict": "poor", "consequence": "A homer scores three runs and flips the game.", "considerations": ["Slugger swings freely", "Big upside for him"] }
  ],
  "expertNote": "With first base open, an intentional walk costs almost nothing in defensive position. It gives the batter first base but sets up a force at every bag.",
  "sayThisLine": "They walked him on purpose, first base was open."
}
```

**Sample 4** (lesson `cult-05`)

```json
{
  "prompt": "A foul ball is heading toward your row. What do you do?",
  "situation": {
    "narrative": "You are at the park with someone you care about. It's a sunny day.",
    "facts": [
      { "label": "Seats", "value": "Behind the third-base dugout" },
      { "label": "Nearby", "value": "A child two seats over" },
      { "label": "Your hands", "value": "Holding a drink and a hot dog" },
      { "label": "Crowd", "value": "Shouting 'heads up!'", "emphasis": "warning" }
    ]
  },
  "options": [
    { "id": "watch", "label": "Watch the ball, shield yourself and the child", "verdict": "best", "consequence": "The ball lands two rows away; everyone is fine, and you look calm.", "considerations": ["Foul balls are fast", "Kids should not chase them into the aisle"] },
    { "id": "catch", "label": "Reach for it with the drink in your hand", "verdict": "poor", "consequence": "You spill, miss, and nearly get hit.", "considerations": ["Hard to control", "Ball can hurt"] },
    { "id": "look", "label": "Look away and hope it misses", "verdict": "poor", "consequence": "You do not see where it goes; the ball lands near you.", "considerations": ["Watch the ball", "Reaction time matters"] }
  ],
  "expertNote": "Regulars keep an eye on the batter and the ball, and keep drinks down when hitters are dangerous. Catching a foul ball is fun, but not worth being hit.",
  "sayThisLine": "Keep your eyes on the ball at the park.",
  "safetyNote": "Swoon'd is not safety training. Pay attention at the ballpark and keep children away from the dugout side."
}
```

### 2.7 `talk-track`

Samples are the ten full tracks in section 4 (`T1` to `T10`), each with the enthusiast line, meaning and coach notes. They are the launch samples; the manifest count (24) adds one per unit end and six for the current-season layer.

### 2.8 `timing-tap`

**Sample 1** (lesson `mod-01`)

```json
{
  "prompt": "Tap when the clock reaches the gold.",
  "theme": { "label": "Pitch clock", "resultUnit": "seconds" },
  "rounds": [
    { "zoneStartPct": 60, "zoneEndPct": 82, "sweepSeconds": 2.4 },
    { "zoneStartPct": 66, "zoneEndPct": 82, "sweepSeconds": 2.0 },
    { "zoneStartPct": 72, "zoneEndPct": 84, "sweepSeconds": 1.7 }
  ],
  "explanation": {
    "correct": "Late in the clock but not too late: pitchers like to use almost all of it, then throw. Hitters have to be set with eight seconds left.",
    "incorrect": "You have to throw before the clock hits zero or it is an automatic ball. Wait for the gold, but never let it run out.",
    "sayThisLine": "The pitch clock hurried him."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `base-04`)

```json
{
  "prompt": "Tap on the pitcher's first move.",
  "theme": { "label": "Steal jump", "resultUnit": "seconds" },
  "rounds": [
    { "zoneStartPct": 50, "zoneEndPct": 70, "sweepSeconds": 1.8 },
    { "zoneStartPct": 55, "zoneEndPct": 68, "sweepSeconds": 1.5 },
    { "zoneStartPct": 58, "zoneEndPct": 66, "sweepSeconds": 1.3 }
  ],
  "explanation": {
    "correct": "A good jump is half the steal. Runners read the pitcher's first move, then go, and every tenth of a second counts.",
    "incorrect": "Too early and the pitcher picks him off; too late and the catcher throws him out. The gold is the sweet spot.",
    "sayThisLine": "He got a great jump on that steal."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

**Sample 3** (lesson `hit-02`)

```json
{
  "prompt": "Tap when the ball hits the sweet spot.",
  "theme": { "label": "Barrel it", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 55, "zoneEndPct": 75, "sweepSeconds": 1.6 },
    { "zoneStartPct": 60, "zoneEndPct": 74, "sweepSeconds": 1.3 },
    { "zoneStartPct": 63, "zoneEndPct": 72, "sweepSeconds": 1.1 }
  ],
  "explanation": {
    "correct": "A barrel is a well-struck ball: good speed and a good launch angle. Timing the sweet spot is the whole trick.",
    "incorrect": "Too early or too late and you foul it off or hit a weak grounder. Barrels come from perfect timing.",
    "sayThisLine": "He barreled that one up."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.9 `say-this`

**Sample 1** (lesson `talk-02`)

```json
{
  "statement": { "speaker": "Maya", "text": "Our bullpen blew it again. Seventh inning, up by two, gone." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "The relief pitchers lost the lead late", "isCorrect": true },
    { "id": "b", "text": "The starting pitcher got hurt" },
    { "id": "c", "text": "A fielding error decided the game", "explanation": "Errors are separate from pitchers blowing a lead." },
    { "id": "d", "text": "Relievers gave up the lead", "isCorrect": true }
  ],
  "translation": "Her team's relief pitchers gave up a lead they were supposed to protect, and the team lost or nearly lost because of it.",
  "followUps": [
    { "line": "Was it the closer, or the guy before him?", "why": "Shows you know relievers have different roles." },
    { "line": "How many blown saves is that this month?", "why": "Blown save is the term she is likely to use next." }
  ],
  "noFakeExpertNote": "You do not need a stat; asking who pitched is honest and she will love telling you."
}
```

**Sample 2** (lesson `count-02`)

```json
{
  "statement": { "speaker": "Maya", "text": "He took a 3-2 slider right down the middle. Strike three. I could scream." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "The batter watched strike three with a full count", "isCorrect": true },
    { "id": "b", "text": "The batter swung and missed at a fastball" },
    { "id": "c", "text": "The umpire threw a pitch" },
    { "id": "d", "text": "A slow breaking ball struck him out looking", "isCorrect": true }
  ],
  "translation": "It was a full count (three balls, two strikes). The batter did not swing at a strike and was called out. She is frustrated he did not swing.",
  "followUps": [
    { "line": "Do you think he was sitting on a fastball?", "why": "Asks about the batter's plan without pretending to know it." },
    { "line": "Was it a called strike three?", "why": "Uses the right term for striking out looking." }
  ],
  "noFakeExpertNote": "Do not argue whether it was a strike; ask what she saw."
}
```

**Sample 3** (lesson `score-07`)

```json
{
  "statement": { "speaker": "Maya", "text": "We're two games back of the last wild card, and we play them this weekend." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "The team trails the last playoff spot by two games", "isCorrect": true },
    { "id": "b", "text": "The team is two games from winning the division" },
    { "id": "c", "text": "A series against the team just ahead of them", "isCorrect": true },
    { "id": "d", "text": "The team already made the playoffs" }
  ],
  "translation": "Her team is outside the playoff picture by two games and has a series against a rival for the final spot, so it matters a lot.",
  "followUps": [
    { "line": "So a sweep would tie it up?", "why": "Shows you understand what games behind means." },
    { "line": "Who else is in that race?", "why": "Invites her to tell you the story." }
  ]
}
```

**Sample 4** (lesson `talk-05`)

```json
{
  "statement": { "speaker": "Maya", "text": "I can't stand the ghost runner in extra innings. It ruins the drama." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "The automatic runner placed on second in extras", "isCorrect": true },
    { "id": "b", "text": "A haunted ballpark" },
    { "id": "c", "text": "A rule that speeds up extra innings", "isCorrect": true },
    { "id": "d", "text": "The runner who was pinch-hit for" }
  ],
  "translation": "Since 2020, each extra inning starts with a runner on second base. Some fans love the quick finish; others say it cheapens extra-inning baseball.",
  "followUps": [
    { "line": "Would you rather play until someone scores from scratch?", "why": "Invites her opinion without picking a side." }
  ],
  "noFakeExpertNote": "It is fine to say you like the quicker games, but let her explain why she does not."
}
```

**Sample 5** (lesson `talk-05`)

```json
{
  "statement": { "speaker": "Maya", "text": "The ABS challenge got him. Strike three was a ball, so the AB kept going." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "A ball-strike call was overturned by the system", "isCorrect": true },
    { "id": "b", "text": "A replay review of a home run" },
    { "id": "c", "text": "The batter or catcher used a challenge", "isCorrect": true },
    { "id": "d", "text": "A pitcher balked" }
  ],
  "translation": "In 2026 each team gets two challenges a game on balls and strikes. The tracking system said the pitch missed the zone, so the at-bat continued.",
  "followUps": [
    { "line": "Do teams save their challenges for late innings?", "why": "Shows you know challenges are limited." }
  ],
  "noFakeExpertNote": "If she asks you about the zone, say you are still learning the batter-height part."
}
```

### 2.10 `fill-the-gap`

**Sample 1** (lesson `game-02`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "A half-inning ends after {outs} outs, and the home team bats in the {half} of each inning.",
  "gaps": [
    { "id": "outs", "options": ["two", "three"], "correct": "three" },
    { "id": "half", "options": ["top", "bottom"], "correct": "bottom" }
  ],
  "explanation": {
    "correct": "Three outs end a half-inning, and the home team always bats last, in the bottom half.",
    "incorrect": "It takes three outs, and the home team bats in the bottom half so it hits last. That is why walk-offs exist.",
    "sayThisLine": "The home team gets the last at-bat."
  }
}
```

**Sample 2** (lesson `score-04`)

```json
{
  "prompt": "Complete the pitching stat.",
  "template": "ERA counts {earned} runs per {nine} innings pitched.",
  "gaps": [
    { "id": "earned", "options": ["earned", "all"], "correct": "earned" },
    { "id": "nine", "options": ["three", "nine"], "correct": "nine" }
  ],
  "explanation": {
    "correct": "Earned run average is earned runs per nine innings. Unearned runs from errors are left out.",
    "incorrect": "ERA is earned runs per nine innings: the pitcher's responsibility, scaled to a full game.",
    "sayThisLine": "His ERA is under three."
  }
}
```

**Sample 3** (lesson `mod-06`)

```json
{
  "prompt": "Complete the rule sentence.",
  "template": "The {dh} bats for the pitcher in both leagues, ever since the {year} season.",
  "gaps": [
    { "id": "dh", "options": ["designated hitter", "pinch runner"], "correct": "designated hitter" },
    { "id": "year", "options": ["2020", "2022"], "correct": "2022" }
  ],
  "explanation": {
    "correct": "Universal DH began in 2022. Pitchers no longer bat in the National League either, except in rare two-way cases.",
    "incorrect": "It is the designated hitter, and since 2022 both leagues use one. That ended the National League's tradition of pitchers batting.",
    "sayThisLine": "The universal DH changed lineups."
  }
}
```

### 2.11 `listening-id`

**Sample 1** (lesson `col-01`)

```json
{
  "prompt": "Which bat makes this sound?",
  "audio": {
    "asset": "audio/baseball/metal-bat-ping.m4a",
    "durationMs": 3000,
    "license": "original-swoond",
    "description": "A bright, high-pitched ping of a ball hitting a metal bat.",
    "maxPlays": 3
  },
  "options": [
    { "id": "a", "text": "A metal bat" },
    { "id": "b", "text": "A wooden bat" },
    { "id": "c", "text": "A plastic bat" }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Metal bats ping. College and high school baseball use metal bats (college's are limited by a performance standard); MLB uses wood.",
    "incorrect": "A ping is a metal bat. Wood makes a deeper crack, which you hear in the majors."
  },
  "listenFor": ["Bright ping", "Higher pitch than wood"]
}
```

**Sample 2** (lesson `npb-03`)

```json
{
  "prompt": "Which kind of ballpark is this?",
  "audio": {
    "asset": "audio/baseball/oendan-chant.m4a",
    "durationMs": 6000,
    "license": "original-swoond",
    "description": "A synthesised crowd chanting in rhythm with trumpets and drums, an original chant, not a team song.",
    "maxPlays": 3
  },
  "options": [
    { "id": "a", "text": "A Japanese pro game" },
    { "id": "b", "text": "A US major-league game" },
    { "id": "c", "text": "A quiet minor-league game" }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Organized cheering with trumpets, drums and chants for each batter is the oendan tradition of Japanese pro baseball.",
    "incorrect": "That steady chanting with brass and drums for each batter is a Japanese pro tradition called oendan; US parks are usually looser."
  },
  "listenFor": ["Trumpets", "Drums", "Chants that repeat for each batter"]
}
```

**Sample 3** (lesson `pit-01`)

```json
{
  "prompt": "What just happened?",
  "audio": {
    "asset": "audio/baseball/glove-pop.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A sharp, crisp pop, like a fast ball hitting a leather glove.",
    "maxPlays": 3
  },
  "options": [
    { "id": "a", "text": "A fastball hit the catcher's glove" },
    { "id": "b", "text": "A batter hit a home run" },
    { "id": "c", "text": "The umpire dropped his mask" }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "That sharp pop is a fast pitch landing in the catcher's mitt. The louder the pop, the harder the pitch.",
    "incorrect": "It is a pitch meeting the catcher's glove. A bat makes a crack or a ping, not a pop."
  },
  "listenFor": ["Sharp pop", "Leather sound"]
}
```

### 2.12 `estimate-slider`

**Sample 1** (lesson `game-03`)

```json
{
  "prompt": "How far apart are the bases?",
  "unit": "feet",
  "min": 60,
  "max": 120,
  "step": 5,
  "correctValue": 90,
  "tolerance": { "full": 0, "partial": 10 },
  "explanation": {
    "correct": "Ninety feet between bases. That distance has stayed the same for over a century, and it is why close plays at first are so close.",
    "incorrect": "The answer is 90 feet. It is short enough for a fast runner to beat a throw on a grounder, which is the whole drama of infield hits.",
    "sayThisLine": "It was a bang-bang play at first."
  }
}
```

**Sample 2** (lesson `game-07`)

```json
{
  "prompt": "How many regular-season games does an MLB team play?",
  "unit": "games",
  "min": 100,
  "max": 200,
  "step": 2,
  "correctValue": 162,
  "tolerance": { "full": 0, "partial": 10 },
  "explanation": {
    "correct": "One hundred sixty-two games. That is why one loss barely matters and a hot stretch matters a lot.",
    "incorrect": "It is 162 games, a marathon of six months. That is why fans talk about streaks and series, not single games."
  }
}
```

**Sample 3** (lesson `mod-01`)

```json
{
  "prompt": "How many seconds does a pitcher get with runners on?",
  "unit": "seconds",
  "min": 10,
  "max": 30,
  "step": 1,
  "correctValue": 18,
  "tolerance": { "full": 0, "partial": 3 },
  "explanation": {
    "correct": "Eighteen seconds with a runner on base, 15 with the bases empty. The extra time is for holding the runner.",
    "incorrect": "It is 18 seconds with runners on; the clock started at 20 in 2023 and was trimmed for 2024.",
    "sayThisLine": "He is up against the pitch clock."
  }
}
```

**Sample 4** (lesson `mod-05`)

```json
{
  "prompt": "How wide is home plate?",
  "unit": "inches",
  "min": 10,
  "max": 30,
  "step": 1,
  "correctValue": 17,
  "tolerance": { "full": 0, "partial": 3 },
  "explanation": {
    "correct": "Seventeen inches. The strike zone is that width, and its height changes with the batter.",
    "incorrect": "Home plate is 17 inches wide. The ABS zone is that wide, with a height scaled to the batter."
  }
}
```

### 2.13 `hotspot-tap`

**Sample 1** (lesson `game-04`)

```json
{
  "prompt": "Tap the shortstop.",
  "diagram": {
    "diagramId": "baseball-diamond",
    "aspectRatio": 1,
    "alt": "Overhead diagram of a baseball field with nine defensive positions marked as circles."
  },
  "hotspots": [
    { "id": "p", "label": "Pitcher", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.62, "r": 0.05 } },
    { "id": "c", "label": "Catcher", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.9, "r": 0.05 } },
    { "id": "1b", "label": "First base", "shape": { "kind": "circle", "cx": 0.75, "cy": 0.6, "r": 0.05 } },
    { "id": "2b", "label": "Second base", "shape": { "kind": "circle", "cx": 0.6, "cy": 0.47, "r": 0.05 } },
    { "id": "ss", "label": "Shortstop", "shape": { "kind": "circle", "cx": 0.4, "cy": 0.47, "r": 0.05 } },
    { "id": "3b", "label": "Third base", "shape": { "kind": "circle", "cx": 0.25, "cy": 0.6, "r": 0.05 } },
    { "id": "lf", "label": "Left field", "shape": { "kind": "circle", "cx": 0.2, "cy": 0.25, "r": 0.06 } },
    { "id": "cf", "label": "Center field", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.15, "r": 0.06 } },
    { "id": "rf", "label": "Right field", "shape": { "kind": "circle", "cx": 0.8, "cy": 0.25, "r": 0.06 } }
  ],
  "correctHotspotIds": ["ss"],
  "explanation": {
    "correct": "The shortstop plays between second and third base and is number 6 on the scorecard.",
    "incorrect": "The shortstop stands between second and third base. Position 6 in the scoring shorthand is the shortstop.",
    "sayThisLine": "That ball went up the middle past the shortstop."
  }
}
```

**Sample 2** (lesson `mod-05`)

```json
{
  "prompt": "Tap the pitch that is a strike.",
  "diagram": {
    "diagramId": "strike-zone-72in",
    "aspectRatio": 0.8,
    "alt": "A strike-zone rectangle for a six-foot batter, seen from the catcher's view, with four pitch dots: high above the zone, low below it, in the middle, and outside the plate."
  },
  "hotspots": [
    { "id": "high", "label": "High and inside", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.12, "r": 0.06 } },
    { "id": "low", "label": "In the dirt", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.9, "r": 0.06 } },
    { "id": "middle", "label": "Middle of the zone", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.5, "r": 0.06 } },
    { "id": "outside", "label": "Outside the plate", "shape": { "kind": "circle", "cx": 0.92, "cy": 0.5, "r": 0.06 } }
  ],
  "correctHotspotIds": ["middle"],
  "explanation": {
    "correct": "The zone is 17 inches wide, from about a quarter of the batter's height up to just over half. The middle is a strike.",
    "incorrect": "A strike must touch the zone: 17 inches wide, and from roughly 27 percent to 53.5 percent of the batter's height.",
    "sayThisLine": "Right down the middle, strike."
  }
}
```

**Sample 3** (lesson `def-03`)

```json
{
  "prompt": "Throw from right field to home. Tap the cutoff man.",
  "diagram": {
    "diagramId": "baseball-diamond",
    "aspectRatio": 1,
    "alt": "Overhead field diagram. A ball is fielded in right field with a runner heading home. Nine positions are marked."
  },
  "hotspots": [
    { "id": "1b", "label": "First baseman", "shape": { "kind": "circle", "cx": 0.75, "cy": 0.6, "r": 0.05 } },
    { "id": "2b", "label": "Second baseman", "shape": { "kind": "circle", "cx": 0.6, "cy": 0.47, "r": 0.05 } },
    { "id": "ss", "label": "Shortstop", "shape": { "kind": "circle", "cx": 0.4, "cy": 0.47, "r": 0.05 } },
    { "id": "3b", "label": "Third baseman", "shape": { "kind": "circle", "cx": 0.25, "cy": 0.6, "r": 0.05 } }
  ],
  "correctHotspotIds": ["1b"],
  "explanation": {
    "correct": "The first baseman lines up between right field and the plate as the cutoff man, ready to catch and redirect the throw.",
    "incorrect": "On a throw home from right field, the first baseman is the cutoff man. The second baseman is the relay on deep hits."
  }
}
```

**Sample 4** (lesson `score-02`)

```json
{
  "prompt": "Tap the column that shows runs batted in.",
  "diagram": {
    "diagramId": "box-score-sample",
    "aspectRatio": 1.6,
    "alt": "A box score row for one hitter with columns AB, R, H, RBI, BB and K."
  },
  "hotspots": [
    { "id": "ab", "label": "AB", "shape": { "kind": "rect", "x": 0.3, "y": 0.2, "w": 0.1, "h": 0.6 } },
    { "id": "r", "label": "R", "shape": { "kind": "rect", "x": 0.4, "y": 0.2, "w": 0.1, "h": 0.6 } },
    { "id": "h", "label": "H", "shape": { "kind": "rect", "x": 0.5, "y": 0.2, "w": 0.1, "h": 0.6 } },
    { "id": "rbi", "label": "RBI", "shape": { "kind": "rect", "x": 0.6, "y": 0.2, "w": 0.1, "h": 0.6 } },
    { "id": "bb", "label": "BB", "shape": { "kind": "rect", "x": 0.7, "y": 0.2, "w": 0.1, "h": 0.6 } },
    { "id": "k", "label": "K", "shape": { "kind": "rect", "x": 0.8, "y": 0.2, "w": 0.1, "h": 0.6 } }
  ],
  "correctHotspotIds": ["rbi"],
  "explanation": {
    "correct": "RBI is runs batted in: how many runs scored because of the batter's at-bat.",
    "incorrect": "RBI is the fourth column: runs the batter drove in. R is runs he scored himself, H is hits, BB is walks, K is strikeouts.",
    "sayThisLine": "He had three RBI last night."
  }
}
```
