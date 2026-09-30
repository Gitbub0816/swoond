# Native Exercise Plan: Video Games (`video-games`)

Tier B plan for `docs/courses/video-games/`. All 13 native exercise types are used; the one Tier A sim is in `sims/games.controls.aim-assist.v1.md`. Every sample payload below validates against `docs/contracts/native-exercises/v1/*.schema.json` (checked with ajv in the repo's validator setup when this file was written). Conventions: prompts are 12 words or fewer; every answer is explained; no fake-expertise scripts; no game screenshots, art, logos, audio or footage anywhere (spec section 40): images are **original** illustrations and audio is **original synthesized** (`original-swoond`).

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite card: platforms, modes, business models, genres, terms. Distractors are the classic beginner errors from CDS section 2. | ~230 |
| `binary-call` | Two-way judgments with a plain rationale: buff or nerf, cosmetic or pay-to-win, wait or help, works or wrong platform. Scene `none` (text) or a generic HUD diagram; `ruleTag` names the idea. | ~70 |
| `term-match` | Introduce 3 to 6 related terms (platform holders, balance words, genre suffixes, roles) with plain definitions. | ~45 |
| `sequence-order` | Core loops, match flow, live-service season, esports bracket, battle pass, setting up a shared session; `why` per step carries the logic. | ~35 |
| `visual-id` | Recognising camera types, item rarity, HUD elements and controller layouts from **original abstract illustrations**; never game art. | ~30 |
| `decision-scenario` | Judgment: which game to share, what to gift, how to react to a toxic teammate, whether to give hints, whether to buy. `expertNote` always; a `safetyNote` where wellbeing or online safety is involved. | ~60 |
| `talk-track` | 24 tracks at launch (roster in section 5) plus one-exchange micro-tracks at unit ends; Smooth meter; replies reward curiosity over jargon. | 24 |
| `timing-tap` | 1D timing feel only: dodge inside an attack window (i-frames), parry window, cooldown rhythm. Anything spatial is Unity (only the aim-assist sim). | ~14 |
| `say-this` | Decode what she says: slang, recaps, gripes, hardware talk, esports talk. Every item has follow-ups that are honest curiosity and a `noFakeExpertNote`. | ~90 |
| `fill-the-gap` | Vocabulary in context and quick review cards. | ~55 |
| `listening-id` | Original synthesized generic cues (low-health alarm, loot chime, hit-marker tick, level-up jingle archetypes). Skip option always available. | ~10 |
| `estimate-slider` | Magnitudes: frame rates, hours to finish, price tiers, tick rates, team sizes. Dated market numbers are live cards, not lesson facts. | ~25 |
| `hotspot-tap` | Static diagrams: generic HUDs, controller silhouettes, MOBA map, tournament bracket, rank ladder. Movement questions are the sim, not hotspots. | ~45 |

Estimated totals: about 760 native items across 122 lessons and the review loop (density 5 to 8 per lesson with review pools). Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `say-this`.

## 2. Sample items by type

Each sample names a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

**Sample 1** (lesson `plat-07`)

```json
{
  "prompt": "In a graphics menu, what does 60 fps mean?",
  "options": [
    { "id": "a", "text": "60 frames drawn every second" },
    { "id": "b", "text": "60 first-person shooters installed" },
    { "id": "c", "text": "A 60-minute time limit per match" },
    { "id": "d", "text": "60 players allowed in a lobby" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Here fps is frames per second: how many pictures the game draws each second. More frames feel smoother, and 60 is a common target.",
    "incorrect": "In a settings menu, fps means frames per second, a smoothness number. FPS in capitals is also a genre, first-person shooter, which is why people mix them up."
  }
}
```

**Sample 2** (lesson `vocab-02`)

```json
{
  "prompt": "She says they nerfed her main. What happened?",
  "options": [
    { "id": "a", "text": "Her favorite character was made weaker" },
    { "id": "b", "text": "Her favorite character was made stronger" },
    { "id": "c", "text": "Her account was suspended" },
    { "id": "d", "text": "Her character was removed from the game" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "A nerf is a balance change that weakens something. Your main is the character you play most, so she is grumbling about a patch that made hers worse.",
    "incorrect": "A nerf weakens a character, weapon or ability in a patch. The opposite is a buff. It is a game-balance word, not a punishment."
  }
}
```

**Sample 3** (lesson `mode-03`)

```json
{
  "prompt": "What is a battle pass in a live-service game?",
  "options": [
    { "id": "a", "text": "A season-long track of unlockable rewards" },
    { "id": "b", "text": "A ticket for entering an esports arena" },
    { "id": "c", "text": "A cheat code sold in stores" },
    { "id": "d", "text": "A ranked-mode entry fee" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "A battle pass is a season's reward ladder: you play, earn progress and unlock items. Some tiers are free and some cost money, which is why people argue about them.",
    "incorrect": "A battle pass is an in-game reward track tied to a season. You unlock items by playing. It is not a ticket or a cheat."
  }
}
```

**Sample 4** (lesson `buy-02`)

```json
{
  "prompt": "What does a game subscription usually give you?",
  "options": [
    { "id": "a", "text": "Access to a rotating library while you pay" },
    { "id": "b", "text": "Permanent ownership of every game in it" },
    { "id": "c", "text": "A free console each year" },
    { "id": "d", "text": "Automatic wins in ranked play" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Subscriptions like Game Pass, PS Plus and Switch Online rent you a catalog. Games rotate out, and you stop having access if you stop paying.",
    "incorrect": "A subscription is like a streaming service for games: access while you pay, not ownership. That matters when you buy her a gift."
  }
}
```

### 2.2 `binary-call`

**Sample 1** (lesson `vocab-02`)

```json
{
  "prompt": "A patch lowers a hero's damage. Buff or nerf?",
  "scene": {
    "kind": "none",
    "alt": "Text-only scenario. A patch note says a hero's damage was reduced by ten percent."
  },
  "choices": [
    { "id": "nerf", "label": "Nerf" },
    { "id": "buff", "label": "Buff" }
  ],
  "correctChoiceId": "nerf",
  "explanation": {
    "correct": "Lower damage is a nerf: the developers weakened the hero to bring balance. If the change had raised damage it would be a buff.",
    "incorrect": "Buff means stronger, nerf means weaker. A damage cut is a nerf. Players usually complain about their favorites being nerfed."
  },
  "ruleTag": "Balance words"
}
```

**Sample 2** (lesson `mode-05`)

```json
{
  "prompt": "A skin only changes how a character looks. Pay-to-win?",
  "scene": {
    "kind": "none",
    "alt": "Text-only scenario. A store sells a purely cosmetic outfit that gives no stat bonus."
  },
  "choices": [
    { "id": "cosmetic", "label": "No, cosmetic only" },
    { "id": "p2w", "label": "Yes, pay-to-win" }
  ],
  "correctChoiceId": "cosmetic",
  "explanation": {
    "correct": "Pay-to-win means paying buys a gameplay advantage. A skin that changes only looks is cosmetic, which most players accept far more than paid power.",
    "incorrect": "Pay-to-win is about advantages: stronger weapons, faster progress. A purely visual skin gives none, so fans call it cosmetic-only."
  },
  "ruleTag": "Monetization"
}
```

**Sample 3** (lesson `tog-04`)

```json
{
  "prompt": "She is stuck on a puzzle but has not asked. What now?",
  "scene": {
    "kind": "none",
    "alt": "Text-only scenario. You are on the couch while she plays a puzzle section. She has not asked for help."
  },
  "choices": [
    { "id": "wait", "label": "Wait until she asks" },
    { "id": "tell", "label": "Tell her the answer" }
  ],
  "correctChoiceId": "wait",
  "explanation": {
    "correct": "Solving it is her fun. Offer help only if she asks, or ask first: do you want a hint? That is the difference between good company and backseat gaming.",
    "incorrect": "Blurting the answer takes the puzzle away from her. Wait, or ask if she wants a hint. Backseat gaming is the classic couch mistake."
  },
  "ruleTag": "Backseat gaming"
}
```

**Sample 4** (lesson `plat-06`)

```json
{
  "prompt": "Can a console player join a PC friend's match?",
  "scene": {
    "kind": "none",
    "alt": "Text-only scenario. The game supports crossplay between console and PC."
  },
  "choices": [
    { "id": "yes", "label": "Yes, with crossplay" },
    { "id": "no", "label": "No, never" }
  ],
  "correctChoiceId": "yes",
  "explanation": {
    "correct": "Crossplay lets different platforms play the same match. It is per game and often optional, so it is worth checking the settings.",
    "incorrect": "Many games support crossplay across consoles and PC. It depends on the game and sometimes on a setting, so always check."
  },
  "ruleTag": "Crossplay"
}
```

### 2.3 `term-match`

**Sample 1** (lesson `plat-02`)

```json
{
  "prompt": "Match the company to what it is known for.",
  "pairs": [
    { "id": "nintendo", "term": "Nintendo", "definition": "Makes the Switch and Mario games" },
    { "id": "sony", "term": "Sony", "definition": "Makes PlayStation consoles" },
    { "id": "microsoft", "term": "Microsoft", "definition": "Makes Xbox and Game Pass" },
    { "id": "valve", "term": "Valve", "definition": "Runs Steam and makes Steam Deck" }
  ],
  "distractorDefinitions": ["Makes only mobile games"],
  "explanation": {
    "summary": "Four platform holders shape most of what people play on. First-party games come from the platform's own studios, and each has its own store and community.",
    "sayThisLine": "Are you a Switch person or a PlayStation person?"
  }
}
```

**Sample 2** (lesson `vocab-02`)

```json
{
  "prompt": "Match the balance word to its meaning.",
  "pairs": [
    { "id": "nerf", "term": "Nerf", "definition": "A change that makes something weaker" },
    { "id": "buff", "term": "Buff", "definition": "A change that makes something stronger" },
    { "id": "op", "term": "OP", "definition": "So strong it breaks the balance" },
    { "id": "meta", "term": "Meta", "definition": "The strategies everyone is currently using" }
  ],
  "distractorDefinitions": ["A ban for bad behavior"],
  "explanation": {
    "summary": "Balance patches move the meta. A buff or nerf changes what is strong, and players chase whatever the meta says is best.",
    "sayThisLine": "Did the patch change the meta?"
  }
}
```

**Sample 3** (lesson `genre-01`)

```json
{
  "prompt": "Decode these genre names.",
  "pairs": [
    { "id": "soulslike", "term": "Souls-like", "definition": "Hard, pattern-based combat with costly deaths" },
    { "id": "metroidvania", "term": "Metroidvania", "definition": "Explore a map, unlock abilities, revisit old areas" },
    { "id": "roguelike", "term": "Roguelike", "definition": "Randomized runs where dying resets you" },
    { "id": "looter", "term": "Looter-shooter", "definition": "Shooting with a constant stream of gear drops" }
  ],
  "distractorDefinitions": ["A game with no ending"],
  "explanation": {
    "summary": "The suffixes -like and -vania point to a famous game that defined a style. A hybrid name tells you two genres are mixed.",
    "sayThisLine": "Is it more Souls-like or more cozy?"
  }
}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `anat-05`)

```json
{
  "prompt": "Put an action-RPG loop in order.",
  "items": [
    { "id": "explore", "text": "Explore and find an enemy camp", "why": "Every loop starts by going out and finding a challenge." },
    { "id": "fight", "text": "Fight the enemies", "why": "Combat is the skill test at the heart of the loop." },
    { "id": "loot", "text": "Collect loot and experience", "why": "Winning pays out something you can use." },
    { "id": "upgrade", "text": "Upgrade your gear or skills", "why": "You convert loot into power so the next fight feels different." },
    { "id": "harder", "text": "Take on a tougher challenge", "why": "The loop repeats, raised one notch." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "That is the core loop: challenge, reward, upgrade, repeat. Nearly every game, from RPGs to farming sims, hangs on a loop like this.",
    "incorrect": "The loop runs challenge, reward, upgrade, then a harder challenge. If you can name a game's loop, you can explain why it is hard to stop."
  }
}
```

**Sample 2** (lesson `esp-03`)

```json
{
  "prompt": "Order a typical esports season.",
  "items": [
    { "id": "regular", "text": "Regional league regular season", "why": "Teams earn standing and points inside their own region." },
    { "id": "playoffs", "text": "Regional playoffs", "why": "The best teams fight for the region's international spots." },
    { "id": "qualify", "text": "Qualify for the international event", "why": "Only teams from playoffs or qualifiers reach the world stage." },
    { "id": "groups", "text": "Group or Swiss stage at the event", "why": "Global teams meet for the first time and are sorted." },
    { "id": "bracket", "text": "Playoff bracket and grand final", "why": "The last teams standing play knockout matches for the title." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Regional play feeds an international event with a group stage and a bracket. Names differ by game, but the shape is the same.",
    "incorrect": "Most esports seasons run region first, then qualification, then a world event with groups and a bracket. It is like club soccer feeding into a world cup."
  }
}
```

**Sample 3** (lesson `mode-03`)

```json
{
  "prompt": "Order one live-service season.",
  "items": [
    { "id": "announce", "text": "Developers announce the season", "why": "Trailers and notes tell players what is coming." },
    { "id": "patch", "text": "The patch goes live", "why": "New content and balance changes arrive together." },
    { "id": "pass", "text": "Players work through the battle pass", "why": "Progress and rewards drive the middle of the season." },
    { "id": "meta", "text": "The meta settles", "why": "Players figure out what is strongest under the new balance." },
    { "id": "end", "text": "The season ends and the next one starts", "why": "Rewards expire and the cycle restarts." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Announce, patch, play the pass, settle the meta, restart. This rhythm is why her favorite game feels different every couple of months.",
    "incorrect": "A live-service season starts with an announcement and a patch, moves through the pass and the meta, then resets. Knowing the rhythm explains her calendar."
  }
}
```

### 2.5 `visual-id`

**Sample 1** (lesson `anat-04`)

```json
{
  "prompt": "Which camera view is this?",
  "image": {
    "asset": "art/camera-view-a.svg",
    "alt": "Abstract scene drawn from behind and slightly above a small figure. A rounded shape floats over the figure's shoulder and a path stretches ahead into the distance.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "first", "text": "First-person" },
    { "id": "third", "text": "Third-person" },
    { "id": "iso", "text": "Isometric" },
    { "id": "side", "text": "Side-scroller" }
  ],
  "correctOptionId": "third",
  "explanation": {
    "correct": "The camera sits behind the character and you can see them, which is third-person. It shows your character and the space around them, handy for action-adventure games.",
    "incorrect": "First-person shows the world through the character's eyes; third-person puts a camera behind them; isometric looks down at an angle; side-scrollers show a flat side view."
  },
  "cues": ["Character visible from behind", "Camera follows over the shoulder", "Depth stretches away"]
}
```

**Sample 2** (lesson `anat-07`)

```json
{
  "prompt": "Which swatch is the rarest tier?",
  "image": {
    "asset": "art/rarity-ladder.svg",
    "alt": "Five labelled tiles in a row, each with a different border shape and a text label. The rightmost tile has a star-shaped border and is labelled Legendary.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "common", "text": "Common, plain border" },
    { "id": "uncommon", "text": "Uncommon, single line border" },
    { "id": "rare", "text": "Rare, double line border" },
    { "id": "legendary", "text": "Legendary, star border" }
  ],
  "correctOptionId": "legendary",
  "explanation": {
    "correct": "Loot usually climbs from common to legendary. Games use color and shape for rarity, and legendary drops are the ones people brag about.",
    "incorrect": "Rarity ladders run common, uncommon, rare, epic, legendary or similar. The rarest is at the top. Swoon'd's art uses shapes as well as colors."
  },
  "cues": ["Rarity is shown by border shape and text", "Legendary is the rarest tier", "Order climbs left to right"]
}
```

**Sample 3** (lesson `anat-03`)

```json
{
  "prompt": "What is the round icon with a clock sweep?",
  "image": {
    "asset": "art/hud-cooldown-ring.svg",
    "alt": "A round icon with a sword glyph. A dark wedge covers part of it and shrinks like a clock hand.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "cooldown", "text": "A cooldown timer for an ability" },
    { "id": "health", "text": "A health bar" },
    { "id": "minimap", "text": "A minimap" },
    { "id": "ammo", "text": "An ammo counter" }
  ],
  "correctOptionId": "cooldown",
  "explanation": {
    "correct": "The sweeping shade counts down until the ability is ready again. That wait is a cooldown, and watching it is part of playing well.",
    "incorrect": "A clock-sweep on an ability icon is a cooldown timer. Health is a bar, ammo is a number and the minimap is a small map."
  },
  "cues": ["Ability glyph in a circle", "Dark wedge that shrinks", "Ready when the shade clears"]
}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `tog-01`)

```json
{
  "prompt": "She invites you to play. What do you pick?",
  "situation": {
    "narrative": "It is game night. You are new to gaming, she plays a lot, and you both have one controller each.",
    "facts": [
      { "label": "Your experience", "value": "Almost none" },
      { "label": "Her favorite genre", "value": "Action games" },
      { "label": "Session length", "value": "About an hour" },
      { "label": "Players", "value": "Two on one couch" }
    ]
  },
  "options": [
    { "id": "party", "label": "A silly party or kart game", "verdict": "best", "consequence": "You both laugh, you can be bad without stress, and she teaches you controls in passing.", "considerations": ["Low skill floor", "Short rounds", "Fun even when you lose"] },
    { "id": "her-boss", "label": "Her hardest boss game", "verdict": "poor", "consequence": "You spend an hour dying to the tutorial boss and she watches you struggle.", "considerations": ["High skill floor", "Pressure for both of you"] },
    { "id": "co-op", "label": "A forgiving co-op puzzle game", "verdict": "acceptable", "consequence": "Good talk and teamwork, but a puzzle game can stall if neither of you knows the trick.", "considerations": ["Great for talking", "Needs patience"] }
  ],
  "expertNote": "Gamers pick games with a low skill floor and short rounds for beginners. The goal is a good night together, not a good score.",
  "sayThisLine": "Pick something we can both be bad at."
}
```

**Sample 2** (lesson `buy-03`)

```json
{
  "prompt": "You want to gift her a game. First step?",
  "situation": {
    "narrative": "Her birthday is coming and you saw her mention a game she wants.",
    "facts": [
      { "label": "Her platform", "value": "Unknown", "emphasis": "warning" },
      { "label": "Game availability", "value": "Several platforms" },
      { "label": "Edition options", "value": "Standard and deluxe" },
      { "label": "Budget", "value": "Fixed" }
    ]
  },
  "options": [
    { "id": "ask-platform", "label": "Find out her platform and if she owns it", "verdict": "best", "consequence": "You buy the right version and skip a duplicate. It does not spoil the surprise if you ask sideways.", "considerations": ["Wrong platform means a useless gift", "She might already own it"] },
    { "id": "gift-card", "label": "Get a store gift card for her platform", "verdict": "acceptable", "consequence": "It works, but it feels less thoughtful and you still need her platform.", "considerations": ["Safe but generic", "Still needs a platform"] },
    { "id": "just-buy", "label": "Buy any version and hope", "verdict": "poor", "consequence": "The code does not work on her console and the gift becomes a refund chore.", "considerations": ["Codes are platform-locked", "Returns can be messy"] }
  ],
  "expertNote": "Gamers know digital codes are locked to a platform and store. A quick sideways question about what she is playing fixes most gift mistakes.",
  "sayThisLine": "What are you playing on these days?"
}
```

**Sample 3** (lesson `vocab-08`)

```json
{
  "prompt": "A teammate is spamming insults in chat. What now?",
  "situation": {
    "narrative": "You joined her ranked party. A stranger on your team is rude after a lost round.",
    "facts": [
      { "label": "Chat", "value": "Insults directed at you", "emphasis": "warning" },
      { "label": "Match state", "value": "Losing" },
      { "label": "Tools available", "value": "Mute and report" },
      { "label": "Her mood", "value": "Focused" }
    ]
  },
  "options": [
    { "id": "mute", "label": "Mute them and report after the match", "verdict": "best", "consequence": "You stop hearing it, keep your head clear and the team stays focused.", "considerations": ["Removes the fuel", "Reporting is the right place for it"] },
    { "id": "ignore", "label": "Read every message and stew quietly", "verdict": "acceptable", "consequence": "It costs your focus, but at least you did not escalate.", "considerations": ["No escalation", "Wastes attention"] },
    { "id": "argue", "label": "Argue back in chat", "verdict": "poor", "consequence": "The chat becomes a fight, your team tilts and the match gets worse.", "considerations": ["Escalation feeds it", "Distracts the team"] }
  ],
  "expertNote": "Experienced players mute first and report later. Winning a chat fight never wins a match.",
  "safetyNote": "If someone threatens or targets you, report them and leave the match. Your safety comes first.",
  "sayThisLine": "Muted them, moving on."
}
```

**Sample 4** (lesson `mode-05`)

```json
{
  "prompt": "A free game offers a loot box. What do you tell her?",
  "situation": {
    "narrative": "She mentions a game where the best gear comes from random paid boxes.",
    "facts": [
      { "label": "Price model", "value": "Free to play" },
      { "label": "Loot box odds", "value": "Random, low for top items", "emphasis": "warning" },
      { "label": "Advantage", "value": "Better stats for rare gear" },
      { "label": "Your role", "value": "Friend, not lecturer" }
    ]
  },
  "options": [
    { "id": "curious", "label": "Ask how the boxes work and if she spends on them", "verdict": "best", "consequence": "She tells you her own rules and you learn how she thinks about it.", "considerations": ["Curious not judgmental", "Her money, her call"] },
    { "id": "lecture", "label": "Say loot boxes are gambling and she should stop", "verdict": "poor", "consequence": "She feels judged and stops sharing what she plays.", "considerations": ["Unwelcome lecture", "Ends the conversation"] },
    { "id": "buy", "label": "Buy her a bunch as a gift", "verdict": "poor", "consequence": "You just funded random spending on a system you barely understand.", "considerations": ["You do not know her limits", "Randomness is not a gift"] }
  ],
  "expertNote": "Enthusiasts separate cosmetic-only from pay-to-win and random boxes from direct purchases. Ask, then listen.",
  "safetyNote": "If someone is worried about their own spending on games, a trusted friend or consumer-protection resource can help. This is general guidance, not advice."
}
```

### 2.7 `talk-track`

Micro-tracks (one exchange) close a unit or a lesson. The nine full launch scenarios with meanings are in section 4.

**Sample 1** (lesson `vocab-01`)

```json
{
  "title": "GG",
  "setting": "After a close match, her friend types gg in chat.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "That was so close. gg to everybody.",
      "replies": [
        { "id": "a", "text": "gg! That last minute was tense.", "smoothDelta": 20, "theirResponse": "Right?! I thought we had lost it.", "coachNote": "GG means good game. Matching it is friendly and easy." },
        { "id": "b", "text": "What does gg stand for again?", "smoothDelta": 5, "theirResponse": "Good game. It is what you say when a match is done.", "coachNote": "Honest, and a good way to learn. Just say it once." },
        { "id": "c", "text": "Why are you giving up already?", "smoothDelta": -15, "theirResponse": "No, it means good game. We finished!", "coachNote": "gg is politeness, not surrender." }
      ]
    }
  ],
  "closingNote": "GG means good game: a friendly sign-off after a match, win or lose."
}
```

**Sample 2** (lesson `tog-02`)

```json
{
  "title": "Ask about her game",
  "setting": "She has been playing a new game all week.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I am finally past the third boss. It took me twenty tries.",
      "replies": [
        { "id": "a", "text": "Twenty! What finally worked?", "smoothDelta": 25, "theirResponse": "I learned to dodge the second swing. Honestly it clicked.", "coachNote": "You noticed the effort and asked what changed. Great." },
        { "id": "b", "text": "Why not lower the difficulty?", "smoothDelta": -10, "theirResponse": "That would kind of defeat the point.", "coachNote": "Some games make difficulty part of the fun. Ask first." },
        { "id": "c", "text": "Nice. Which game was this?", "smoothDelta": 5, "theirResponse": "The one I told you about, but it is fine.", "coachNote": "Fine, but try to remember the title next time." }
      ]
    }
  ],
  "closingNote": "Struggle-and-win stories are the heart of boss games. Ask what finally worked."
}
```

**Sample 3** (lesson `esp-06`)

```json
{
  "title": "Her team lost",
  "setting": "She texts after her favorite esports team gets knocked out.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "My team just got knocked out of the bracket. Ugh.",
      "replies": [
        { "id": "a", "text": "Oh no. Was it a close series?", "smoothDelta": 25, "theirResponse": "Three games, and the last one was heartbreaking.", "coachNote": "You sympathized and asked a real question." },
        { "id": "b", "text": "It's just a game, right?", "smoothDelta": -20, "theirResponse": "Not really, it is my team.", "coachNote": "Never shrink what she cares about." },
        { "id": "c", "text": "Who beat them?", "smoothDelta": 10, "theirResponse": "A team from another region. They earned it.", "coachNote": "Curious and safe. Follow with a feeling next time." }
      ]
    }
  ],
  "closingNote": "Fans of esports teams feel wins and losses. Treat it like any team she loves."
}
```

### 2.8 `timing-tap`

**Sample 1** (lesson `mech-04`)

```json
{
  "prompt": "Tap to dodge inside the enemy's swing window.",
  "theme": { "label": "Dodge roll", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 55, "zoneEndPct": 78, "sweepSeconds": 1.8 },
    { "zoneStartPct": 60, "zoneEndPct": 76, "sweepSeconds": 1.5 },
    { "zoneStartPct": 65, "zoneEndPct": 77, "sweepSeconds": 1.3 }
  ],
  "explanation": {
    "correct": "Your dodge roll gives brief invincibility, called i-frames. Roll into the swing's danger window and the hit passes through you.",
    "incorrect": "Too early or too late and the attack lands. The trick is that invincibility only lasts a moment, so timing is everything.",
    "sayThisLine": "I finally learned the i-frames on that roll."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `mech-04`)

```json
{
  "prompt": "Tap when the marker enters the parry window.",
  "theme": { "label": "Parry", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 62, "zoneEndPct": 74, "sweepSeconds": 1.6 },
    { "zoneStartPct": 66, "zoneEndPct": 75, "sweepSeconds": 1.4 },
    { "zoneStartPct": 70, "zoneEndPct": 78, "sweepSeconds": 1.2 }
  ],
  "explanation": {
    "correct": "A parry is a tiny window just before an attack lands. Hit it and you deflect the blow and often open the enemy up.",
    "incorrect": "Parry windows are small and unforgiving. Watch the telegraph, the wind-up that tells you the attack is coming, and press just as it lands.",
    "sayThisLine": "The parry window on that boss is tight."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

**Sample 3** (lesson `mech-03`)

```json
{
  "prompt": "Tap the moment your ability is ready again.",
  "theme": { "label": "Cooldown", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 70, "zoneEndPct": 90, "sweepSeconds": 2.0 },
    { "zoneStartPct": 74, "zoneEndPct": 90, "sweepSeconds": 1.7 },
    { "zoneStartPct": 78, "zoneEndPct": 91, "sweepSeconds": 1.5 }
  ],
  "explanation": {
    "correct": "A cooldown is the wait before an ability can be used again. Good players time their next move to the second the ring clears.",
    "incorrect": "Tapping early wastes the button press; tapping late wastes the ability. Watching cooldowns is half of playing well in many games.",
    "sayThisLine": "I am saving my ult until the cooldown is back."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.9 `say-this`

**Sample 1** (lesson `vocab-04`)

```json
{
  "statement": { "speaker": "Maya", "text": "I have been farming that boss for the drop all week and the RNG hates me." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "She keeps beating the same boss hoping for a rare item", "isCorrect": true, "explanation": "Farming is repeating content for rewards." },
    { "id": "b", "text": "She has been growing crops in a farming game", "isCorrect": false, "explanation": "Farming here means grinding a boss, not planting." },
    { "id": "c", "text": "The drop is random and has not come yet", "isCorrect": true, "explanation": "RNG is the randomness that decides what drops." },
    { "id": "d", "text": "Her internet is bad", "isCorrect": false, "explanation": "That would be lag or ping, not RNG." }
  ],
  "translation": "She keeps repeating one boss fight to get a rare item, and the random drop chance has not been kind to her.",
  "followUps": [
    { "line": "How rare is it supposed to be?", "why": "Shows you get that drops have odds and invites her to explain." },
    { "line": "Is it worth it once you get it?", "why": "Asks about the payoff, which is what farming is for." }
  ],
  "noFakeExpertNote": "You do not need to know the game. Asking how rare the drop is beats pretending you know the loot table."
}
```

**Sample 2** (lesson `vocab-07`)

```json
{
  "statement": { "speaker": "Jo", "text": "We had a good comp but our support kept feeding and we lost the fight." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "Her team's mix of roles was fine", "isCorrect": true, "explanation": "Comp is short for team composition." },
    { "id": "b", "text": "A teammate in a helper role kept dying", "isCorrect": true, "explanation": "Support is a helper role and feeding means dying repeatedly." },
    { "id": "c", "text": "The team was giving food to a pet", "isCorrect": false, "explanation": "Feeding means giving the enemy kills." },
    { "id": "d", "text": "The match was in a cooking game", "isCorrect": false, "explanation": "That is a literal reading; this is team-game slang." }
  ],
  "translation": "Her team had a well-balanced group of roles, but the helper-role player kept dying to the enemy and that cost them a key fight.",
  "followUps": [
    { "line": "Was it one bad fight or the whole game?", "why": "Shows you understand a fight can swing a match without being the whole story." },
    { "line": "Who do you usually play?", "why": "Invites her to talk about her own role." }
  ],
  "noFakeExpertNote": "Do not blame her teammate for her. Listening beats diagnosing."
}
```

**Sample 3** (lesson `deb-02`)

```json
{
  "statement": { "speaker": "Kai", "text": "Aim assist on controller is way too strong in this game. Mouse players have no chance." },
  "question": "What is he talking about?",
  "options": [
    { "id": "a", "text": "Controller help that nudges your aim toward targets", "isCorrect": true, "explanation": "That is what aim assist does." },
    { "id": "b", "text": "A complaint that controller players have an unfair edge", "isCorrect": true, "explanation": "The debate is about strength, not whether it exists." },
    { "id": "c", "text": "Mouse players cannot aim at all", "isCorrect": false, "explanation": "The point is fairness, not ability." },
    { "id": "d", "text": "The game is missing a feature", "isCorrect": false, "explanation": "Aim assist is the opposite: too much help." }
  ],
  "translation": "He thinks the built-in help that controller players get for aiming is so strong it makes matches unfair for players using a mouse.",
  "followUps": [
    { "line": "Is it the same in every game or just this one?", "why": "Shows you know assist strength is tuned per game." },
    { "line": "Do you play controller or mouse?", "why": "Shows interest in her own setup." }
  ],
  "noFakeExpertNote": "You can say you do not have a side yet. Asking why someone thinks it is unfair is respected."
}
```

**Sample 4** (lesson `esp-04`)

```json
{
  "statement": { "speaker": "Dani", "text": "Worlds starts in two weeks and my team barely qualified out of the regional playoffs." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "The biggest international esports event of the year", "isCorrect": true, "explanation": "Worlds is the world championship for a game." },
    { "id": "b", "text": "Her team scraped into the tournament", "isCorrect": true, "explanation": "Barely qualified means they just made it." },
    { "id": "c", "text": "A world tour of concerts", "isCorrect": false, "explanation": "Worlds here is an esports tournament." },
    { "id": "d", "text": "Her team is retiring", "isCorrect": false, "explanation": "They qualified, so they are still playing." }
  ],
  "translation": "The world championship for her game is coming up and her favorite team only just earned a spot through the regional playoffs.",
  "followUps": [
    { "line": "Do they have a tough group?", "why": "Shows you know the event has a group stage." },
    { "line": "Where is it this year?", "why": "Easy, honest question that invites her to tell you more." }
  ],
  "noFakeExpertNote": "You do not need to know the teams. Asking about the event is enough."
}
```

### 2.10 `fill-the-gap`

**Sample 1** (lesson `vocab-06`)

```json
{
  "prompt": "Finish her sentence about the connection.",
  "template": "My {{stat}} was terrible, so every fight had {{effect}}.",
  "gaps": [
    { "id": "stat", "options": ["ping", "backlog", "loot", "skin"], "correct": "ping" },
    { "id": "effect", "options": ["lag", "cooldowns", "checkpoints", "achievements"], "correct": "lag" }
  ],
  "explanation": {
    "correct": "Ping is the delay between your device and the server; high ping causes lag. Both are connection words, not game-design words.",
    "incorrect": "Ping is how long messages take to reach the server, and lag is how it feels when that delay is high. Backlog, loot and skins are about something else."
  }
}
```

**Sample 2** (lesson `mode-04`)

```json
{
  "prompt": "Pick the right business words.",
  "template": "A {{model}} game costs nothing up front, but may sell {{items}}.",
  "gaps": [
    { "id": "model", "options": ["free-to-play", "premium", "early access"], "correct": "free-to-play" },
    { "id": "items", "options": ["microtransactions", "day-one patches", "save files"], "correct": "microtransactions" }
  ],
  "explanation": {
    "correct": "Free-to-play games make money from optional purchases called microtransactions. Whether those purchases are fair is a big enthusiast debate.",
    "incorrect": "Free-to-play means no upfront price; the game earns through in-game purchases. Premium games charge once up front."
  }
}
```

**Sample 3** (lesson `vocab-05`)

```json
{
  "prompt": "Complete her gaming to-do list line.",
  "template": "I need to clear my {{pile}} before I start {{mode}}.",
  "gaps": [
    { "id": "pile", "options": ["backlog", "lobby", "meta", "hitbox"], "correct": "backlog" },
    { "id": "mode", "options": ["New Game Plus", "matchmaking", "a patch", "crossplay"], "correct": "New Game Plus" }
  ],
  "explanation": {
    "correct": "A backlog is the pile of games you own and have not played. New Game Plus restarts a finished game with your progress carried over.",
    "incorrect": "A backlog is your unplayed pile. New Game Plus is a second playthrough with your gear kept. The other words are about multiplayer or balance."
  }
}
```

### 2.11 `listening-id`

All audio is **original synthesized** by Swoon'd; nothing is sampled from a game. Each clip's `description` doubles as the text alternative.

**Sample 1** (lesson `anat-03`)

```json
{
  "prompt": "What does this alarm usually mean?",
  "audio": {
    "asset": "audio/cues/low-health-alarm.m4a",
    "durationMs": 3000,
    "license": "original-swoond",
    "description": "A fast, repeating two-tone beep that gets sharper as it continues.",
    "maxPlays": 3
  },
  "options": [
    { "id": "low-health", "text": "Your health is very low" },
    { "id": "level-up", "text": "You just leveled up" },
    { "id": "loot", "text": "A rare item dropped" }
  ],
  "correctOptionId": "low-health",
  "explanation": {
    "correct": "Fast, repeating alarms tell you danger. Games use audio warnings so you can react without looking at the health bar.",
    "incorrect": "A tense, repeating beep is the classic low-health warning. Level-ups and loot use pleasant, rising sounds."
  },
  "listenFor": ["Repeating beep", "Rising urgency", "Warning, not reward"]
}
```

**Sample 2** (lesson `anat-07`)

```json
{
  "prompt": "Which reward does this chime suggest?",
  "audio": {
    "asset": "audio/cues/loot-chime.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A bright, rising three-note chime with a soft sparkle at the end.",
    "maxPlays": 3
  },
  "options": [
    { "id": "loot", "text": "A rare loot drop" },
    { "id": "damage", "text": "You took damage" },
    { "id": "menu", "text": "A menu was opened" }
  ],
  "correctOptionId": "loot",
  "explanation": {
    "correct": "Rising, sparkling chimes tell your brain you earned something. Games use them for loot and rewards.",
    "incorrect": "Bright rising chimes are reward sounds. Damage sounds are low and short, and menus use soft clicks."
  },
  "listenFor": ["Rising notes", "Bright tone", "Sparkle at the end"]
}
```

**Sample 3** (lesson `mech-05`)

```json
{
  "prompt": "What is this short tick usually telling you?",
  "audio": {
    "asset": "audio/cues/hit-marker-tick.m4a",
    "durationMs": 1500,
    "license": "original-swoond",
    "description": "A short, sharp tick, then a slightly deeper tick.",
    "maxPlays": 3
  },
  "options": [
    { "id": "hit", "text": "Your shot connected" },
    { "id": "menu", "text": "The game paused" },
    { "id": "goal", "text": "A quest was completed" }
  ],
  "correctOptionId": "hit",
  "explanation": {
    "correct": "A sharp tick is a hit marker: it confirms a shot landed. A deeper tick often means a stronger hit or a kill.",
    "incorrect": "Short ticks in shooters confirm a hit. A pause or a quest uses a different sound, usually softer or longer."
  },
  "listenFor": ["Short and sharp", "Feedback for your action", "A deeper tone can mean a kill"]
}
```

### 2.12 `estimate-slider`

**Sample 1** (lesson `esp-05`)

```json
{
  "prompt": "How many players are in a standard MOBA match?",
  "unit": "players",
  "min": 2,
  "max": 20,
  "step": 1,
  "correctValue": 10,
  "tolerance": { "full": 1, "partial": 4 },
  "explanation": {
    "correct": "Most big MOBAs are five versus five, so ten players. Team fights are chaotic, and roles matter.",
    "incorrect": "Standard MOBA matches are five players per side, ten in total. Knowing this helps you follow a stream."
  }
}
```

**Sample 2** (lesson `plat-07`)

```json
{
  "prompt": "What frame rate feels smooth in most games?",
  "unit": "fps",
  "min": 15,
  "max": 240,
  "step": 5,
  "correctValue": 60,
  "tolerance": { "full": 10, "partial": 30 },
  "explanation": {
    "correct": "About 60 frames per second is the common baseline for smooth play. Fast competitive games often aim higher.",
    "incorrect": "30 fps feels choppy to many players and 60 fps is the usual smooth baseline. Higher rates help in fast games, but the return shrinks."
  }
}
```

**Sample 3** (lesson `mech-06`)

```json
{
  "prompt": "About what ping starts to feel laggy in a shooter?",
  "unit": "ms",
  "min": 10,
  "max": 300,
  "step": 5,
  "correctValue": 100,
  "tolerance": { "full": 30, "partial": 70 },
  "explanation": {
    "correct": "Around 100 milliseconds of delay you start to feel it, and competitive players want far less. It varies by game.",
    "incorrect": "Under about 50 ms feels responsive to most players; past about 100 ms you start noticing the delay, and higher numbers get frustrating."
  }
}
```

### 2.13 `hotspot-tap`

**Sample 1** (lesson `anat-03`)

```json
{
  "prompt": "Tap the minimap.",
  "diagram": {
    "diagramId": "hud-generic-shooter",
    "aspectRatio": 1.5,
    "alt": "A generic first-person screen layout with a bar at the bottom left, a number at the bottom right, a small round map in the top corner, a crosshair in the center and a row of small icons at the bottom center."
  },
  "hotspots": [
    { "id": "minimap", "label": "Minimap", "shape": { "kind": "circle", "cx": 0.88, "cy": 0.18, "r": 0.1 } },
    { "id": "health", "label": "Health bar", "shape": { "kind": "rect", "x": 0.05, "y": 0.82, "w": 0.28, "h": 0.08 } },
    { "id": "ammo", "label": "Ammo counter", "shape": { "kind": "rect", "x": 0.75, "y": 0.82, "w": 0.2, "h": 0.1 } },
    { "id": "abilities", "label": "Ability icons", "shape": { "kind": "rect", "x": 0.38, "y": 0.86, "w": 0.24, "h": 0.1 } }
  ],
  "correctHotspotIds": ["minimap"],
  "explanation": {
    "correct": "The minimap is the small round map in the corner. It shows your surroundings so you know where enemies and goals are.",
    "incorrect": "The minimap sits in a corner and looks like a tiny map. The bar is health, the number is ammo and the icons are abilities."
  }
}
```

**Sample 2** (lesson `sm-01`)

```json
{
  "prompt": "Tap the jungle.",
  "diagram": {
    "diagramId": "moba-map-generic",
    "aspectRatio": 1,
    "alt": "A simplified square map with three lanes connecting two bases in opposite corners. The areas between the lanes are forested shapes."
  },
  "hotspots": [
    { "id": "top-lane", "label": "Top lane", "shape": { "kind": "rect", "x": 0.05, "y": 0.05, "w": 0.9, "h": 0.1 } },
    { "id": "mid-lane", "label": "Middle lane", "shape": { "kind": "rect", "x": 0.3, "y": 0.4, "w": 0.4, "h": 0.2 } },
    { "id": "bot-lane", "label": "Bottom lane", "shape": { "kind": "rect", "x": 0.05, "y": 0.85, "w": 0.9, "h": 0.1 } },
    { "id": "jungle", "label": "Jungle", "shape": { "kind": "circle", "cx": 0.25, "cy": 0.6, "r": 0.1 } },
    { "id": "base", "label": "Base", "shape": { "kind": "circle", "cx": 0.9, "cy": 0.1, "r": 0.08 } }
  ],
  "correctHotspotIds": ["jungle"],
  "explanation": {
    "correct": "The jungle is the area between lanes, full of neutral monsters. A jungler roams there to help other lanes.",
    "incorrect": "Lanes are the roads between bases. The jungle is the space between them, where neutral monsters live and roaming players farm."
  }
}
```

**Sample 3** (lesson `anat-01`)

```json
{
  "prompt": "Tap the right trigger.",
  "diagram": {
    "diagramId": "controller-generic-twinstick",
    "aspectRatio": 1.6,
    "alt": "A generic game controller seen from above and slightly behind. Two thumbsticks sit low on each side, four buttons on the right and a cross pad on the left. Two shoulder buttons and two triggers sit along the top edge."
  },
  "hotspots": [
    { "id": "left-stick", "label": "Left stick", "shape": { "kind": "circle", "cx": 0.32, "cy": 0.58, "r": 0.09 } },
    { "id": "right-stick", "label": "Right stick", "shape": { "kind": "circle", "cx": 0.62, "cy": 0.68, "r": 0.09 } },
    { "id": "right-trigger", "label": "Right trigger", "shape": { "kind": "rect", "x": 0.7, "y": 0.04, "w": 0.16, "h": 0.14 } },
    { "id": "left-trigger", "label": "Left trigger", "shape": { "kind": "rect", "x": 0.14, "y": 0.04, "w": 0.16, "h": 0.14 } },
    { "id": "face-buttons", "label": "Face buttons", "shape": { "kind": "circle", "cx": 0.78, "cy": 0.48, "r": 0.1 } }
  ],
  "correctHotspotIds": ["right-trigger"],
  "explanation": {
    "correct": "Triggers sit on the top edge of the controller under your index fingers. Right trigger often fires a weapon or accelerates a car.",
    "incorrect": "Triggers are on the top edge, under your index fingers. The sticks are for your thumbs and the face buttons are the four on the right."
  }
}
```

## 3. Playbook terms (79)

Definition plus an example line in the enthusiast's voice. The `conceptId` column reuses the curriculum concept ids from the CDS map.

| Term | conceptId | Definition | Example line |
|---|---|---|---|
| Console | `console` | A dedicated gaming box or handheld you plug into a TV or carry. | "I only play on console, I don't want to tinker." |
| PC gaming | `pc-gaming` | Playing on a computer, usually with a keyboard and mouse. | "My PC can run it at max settings." |
| Handheld | `handheld` | A portable machine you play in your hands. | "I finished the whole thing on my handheld." |
| Exclusive | `exclusive` | A game you can only get on one platform. | "It's a console exclusive, so I can't play it." |
| Port | `port` | A game moved to another platform. | "The PC port runs so well." |
| Crossplay | `crossplay` | Playing with people on other platforms. | "Crossplay is on, so my friends can join." |
| Cross-save | `cross-save` | Sharing one save across platforms. | "I started on Switch and continued on PC." |
| Frame rate (fps) | `frame-rate-fps` | How many pictures the game draws each second. | "I'm playing in performance mode for 60 fps." |
| Ray tracing | `ray-tracing` | A lighting method with realistic reflections that costs performance. | "Ray tracing looks gorgeous but tanks my frames." |
| Performance vs quality mode | `performance-vs-quality-mode` | A console choice between smoother play and prettier pictures. | "Quality mode looks nicer but I'll take smooth." |
| Backwards compatibility | `backwards-compatibility` | A newer machine playing older games. | "Backwards compatibility means my old library still works." |
| Storefront | `storefront` | The store where you buy and download games. | "It's on sale on the store right now." |
| HUD | `hud` | The on-screen health, ammo and map. | "I turned the HUD off for immersion." |
| Cooldown | `cooldown` | The wait before an ability can be used again. | "My cooldowns are the whole game." |
| I-frames | `i-frames` | Brief invincibility during a dodge or action. | "The roll has generous i-frames." |
| Aggro | `aggro` | How much an enemy wants to attack you. | "I pulled aggro and the whole camp came." |
| Checkpoint | `checkpoint` | A spot where the game saves your progress. | "The checkpoint was so far from the boss." |
| Permadeath | `permadeath` | Dying erases your run or character. | "Permadeath makes every fight matter." |
| XP and levels | `xp-levels` | Points that raise your character's power. | "I need one more level before the boss." |
| Loot | `loot` | Items you find or win. | "The loot in this dungeon is unreal." |
| Boss fight | `boss-fight` | A big, patterned fight against a strong enemy. | "That boss took me forty tries." |
| NPC | `npc` | A character the game controls, not a player. | "The NPC gave me a side quest." |
| Core loop | `core-loop` | The repeated cycle that makes a game addictive. | "The core loop is just so satisfying." |
| New Game Plus | `new-game-plus` | A second playthrough with your progress kept. | "I'm doing New Game Plus for the harder bosses." |
| FPS (genre) | `fps` | A first-person shooter. | "I mostly play FPS games." |
| Souls-like | `soulslike` | Hard, pattern-based action games with costly deaths. | "It's a Souls-like, so bring patience." |
| Metroidvania | `metroidvania` | A map you unlock with new abilities. | "Every Metroidvania has one ability that changes everything." |
| Battle royale | `battle-royale` | A last-player-standing match on a shrinking map. | "I got into the final circle in battle royale." |
| MOBA | `moba` | A team lane-based strategy game like League of Legends. | "MOBA games have a steep learning curve." |
| MMO | `mmo` | A huge online world with thousands of players. | "I've got a raid with my MMO guild tonight." |
| JRPG | `jrpg` | A role-playing game in the Japanese tradition, often turn-based. | "JRPGs have the best soundtracks." |
| Sandbox | `sandbox` | An open world where you make your own goals. | "I've built a whole city in this sandbox." |
| Cozy game | `cozy-game` | A gentle, low-stress game. | "I need a cozy game after a stressful week." |
| Live service | `live-service` | A game updated and monetized for years. | "It's a live-service game, so it keeps changing." |
| Season | `season` | A fixed period with new content and rewards. | "Season 4 starts next week." |
| Battle pass | `battle-pass` | A season reward track. | "I'm grinding the battle pass before it ends." |
| Patch notes | `patch-notes` | The list of what an update changed. | "Did you read the patch notes? They gutted my build." |
| DLC | `dlc` | Extra content sold after launch. | "The DLC adds a whole new area." |
| Early access | `early-access` | Playing a game before it is finished. | "It's in early access, so expect bugs." |
| Free-to-play | `free-to-play` | A game with no upfront cost. | "It's free-to-play, but the pass is worth it." |
| Microtransaction | `microtransaction` | A small in-game purchase. | "No microtransactions, thank goodness." |
| Loot box | `loot-box` | A paid or earned random reward. | "The loot boxes feel like gambling." |
| Gacha | `gacha` | A random-pull reward system, often in mobile games. | "I'm saving up for the next gacha banner." |
| Pay-to-win | `pay-to-win` | When paying gives a real gameplay advantage. | "It turned pay-to-win after the update." |
| Matchmaking | `matchmaking` | How the game picks your opponents. | "Matchmaking keeps putting me against pros." |
| Ranked play | `ranked-play` | A competitive mode with a ladder. | "I'm grinding ranked this weekend." |
| MMR | `mmr-elo` | A hidden skill number that sorts players. | "My MMR dropped after that losing streak." |
| GG | `gg` | Good game: what you say after a match. | "gg, that was a fun one." |
| AFK | `afk` | Away from keyboard. | "Sorry, I was AFK getting snacks." |
| Noob | `noob` | A beginner, sometimes an insult. | "Don't call her a noob, we all started." |
| LFG | `lfg` | Looking for group. | "LFG for the raid, need a healer." |
| Nerf / buff | `nerf-buff` | A change that weakens or strengthens something. | "They nerfed my main's damage." |
| OP | `op-overpowered` | So strong it breaks balance. | "That weapon is so OP." |
| Meta | `meta` | The strategies currently considered best. | "The meta has shifted after the patch." |
| Tier list | `tier-list` | A ranking of characters or builds by strength. | "The tier list has my main at the bottom." |
| Clutch | `clutch` | Winning when the odds are against you. | "That clutch in overtime was insane." |
| Carry | `carry` | To win the game for your team. | "She carried us through the whole match." |
| Sweaty | `sweaty` | Very try-hard. | "That lobby was so sweaty." |
| RNG | `rng` | Random luck in a game. | "The RNG was not kind tonight." |
| Grind | `grind` | Repeating tasks to progress. | "I've been grinding for the last piece of gear." |
| Farm | `farm` | Repeating content to collect items or currency. | "I'm farming that boss for a rare drop." |
| Drop rate | `drop-rate` | The chance an item appears. | "The drop rate is under one percent." |
| Backlog | `backlog` | The games you own but have not played. | "My backlog is out of control." |
| Completionist | `completionist` | Someone who does everything in a game. | "I'm a completionist, I want every trophy." |
| Speedrun | `speedrun` | Finishing a game as fast as possible. | "I watched a speedrun of the whole game in an hour." |
| Lag | `lag` | A delay between your action and the result. | "Lag killed me in the last fight." |
| Ping | `ping` | The time your connection takes to reach the server. | "My ping spiked and I died." |
| Tank, healer, DPS | `tank-healer-dps` | Team roles: soak damage, restore health, deal damage. | "We need a tank and a healer." |
| Callouts | `callouts` | Teammates naming enemy positions. | "Her callouts are the reason we won." |
| Tilt | `tilt` | Playing badly because you are frustrated. | "I'm on tilt, I should stop for tonight." |
| Smurf | `smurf` | A skilled player on a low-rank account. | "There's a smurf in my lobby, it's brutal." |
| Aim assist | `aim-assist` | Built-in help that eases aiming on controllers. | "Aim assist is what makes controller shooters playable." |
| Deadzone | `deadzone` | The small stick range the game ignores. | "My stick drifts, I need a bigger deadzone." |
| Hitbox | `hitbox` | The invisible shape that decides hits. | "The hitbox on that boss is huge." |
| Tick rate | `tick-rate` | How often a game server updates. | "Higher tick rate makes shooting feel fair." |
| Rollback netcode | `rollback-netcode` | Online play that guesses inputs to hide lag. | "Rollback netcode saved the online mode." |
| Esports | `esports` | Organized competitive gaming. | "I watch esports more than regular sports." |
| Worlds | `worlds` | The world championship of a game. | "Worlds is my Super Bowl." |
| Draft (pick/ban) | `draft-pick-ban` | Teams choosing and banning characters before a match. | "The draft decided the whole series." |

## 4. Talk Track scenarios (9)

Each scenario shows the enthusiast's line, what it means, and three replies per exchange: good (curious and specific), meh (safe but flat) and cringe (bluffing or dismissive), with a coach note. The JSON is the exact `talk-track` payload. Smooth starts at 50; a good reply is +20 to +30, meh about 0 to +10, cringe -10 to -20.

### 4.1 She hit a new rank (`tt-ranked-up`, lesson `conv-01`)

- **Her line 1:** "I finally hit Platinum in ranked!" Means: she climbed a competitive ladder tier after grinding; terms `ranked-play`, `rank-tiers`.
- **Her line 2:** "I was stuck in Gold for like two months." Means: she plateaued, which is common; term `tilt`.

```json
{
  "title": "She ranked up",
  "setting": "She texts a screenshot's worth of excitement after a long climb.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I finally hit Platinum in ranked!",
      "replies": [
        { "id": "a", "text": "Congrats! That must have been a grind.", "smoothDelta": 25, "theirResponse": "It really was. Weeks of losing streaks.", "coachNote": "You named the effort. Good." },
        { "id": "b", "text": "Nice. Is that good?", "smoothDelta": 5, "theirResponse": "It's a real step up, yeah!", "coachNote": "Honest but flat. Ask about the climb next." },
        { "id": "c", "text": "Cool, I bet the ranks are easy to inflate.", "smoothDelta": -20, "theirResponse": "Wow. Okay.", "coachNote": "Never shrink her win." }
      ]
    },
    {
      "theirMessage": "I was stuck in Gold for like two months.",
      "replies": [
        { "id": "a", "text": "What finally got you unstuck?", "smoothDelta": 25, "theirResponse": "I stopped forcing fights and played the objective.", "coachNote": "A real question invites her to teach you." },
        { "id": "b", "text": "That sounds annoying.", "smoothDelta": 8, "theirResponse": "It was. I almost quit.", "coachNote": "Kind, but it stops the flow. Ask what changed." },
        { "id": "c", "text": "Why not just play with better people?", "smoothDelta": -12, "theirResponse": "It doesn't really work like that.", "coachNote": "Matchmaking is not a friend-list problem." }
      ]
    }
  ],
  "closingNote": "Ranked is a ladder. Ask about the climb, not whether the ladder is easy."
}
```

### 4.2 The boss took forty tries (`tt-boss-tries`, lesson `aa-01`)

- **Her line 1:** "That boss took me forty tries but I finally learned his pattern." Means: boss games are about learning telegraphs; terms `boss-pattern`, `telegraph`.
- **Her line 2:** "The second phase has that delayed swing that gets me every time." Means: the boss changes moves at half health; term `phase-change`.

```json
{
  "title": "The boss finally fell",
  "setting": "She has been stuck on a boss for a week.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "That boss took me forty tries but I finally learned his pattern.",
      "replies": [
        { "id": "a", "text": "Forty tries! What was the tell you finally spotted?", "smoothDelta": 28, "theirResponse": "He lifts his shoulder before the big swing. I had missed it all week.", "coachNote": "You know bosses have tells. That's exactly the right question." },
        { "id": "b", "text": "Wow, that's a lot of dying.", "smoothDelta": 6, "theirResponse": "Yeah, but it's part of the fun, weirdly.", "coachNote": "Fair, but ask what she learned." },
        { "id": "c", "text": "Couldn't you just level up first?", "smoothDelta": -10, "theirResponse": "That's not really how this game works.", "coachNote": "Some games test skill, not stats." }
      ]
    },
    {
      "theirMessage": "The second phase has that delayed swing that gets me every time.",
      "replies": [
        { "id": "a", "text": "Is that when he changes moves at half health?", "smoothDelta": 22, "theirResponse": "Exactly! You've clearly played a game like this.", "coachNote": "Phases are a common idea. You reasoned it out." },
        { "id": "b", "text": "Just dodge later, right?", "smoothDelta": -5, "theirResponse": "That's the trick, yes. Harder than it sounds!", "coachNote": "Not wrong, but it can sound like advice." },
        { "id": "c", "text": "Just dodge, it's easy!", "smoothDelta": -18, "theirResponse": "Cool, you do it then.", "coachNote": "Never say 'just' to someone who died forty times." }
      ]
    }
  ],
  "closingNote": "Boss fights teach through failure. Ask what she learned, not why she did not skip it."
}
```

### 4.3 They nerfed her main (`tt-nerfed-main`, lesson `vocab-02`)

- **Her line 1:** "They nerfed my main again. I can't believe it." Means: developers weakened her favorite character; terms `nerf-buff`, `patch-notes`.
- **Her line 2:** "Now the meta is all about the new hero, so everybody's picking him." Means: the currently best strategies shifted; term `meta`.

```json
{
  "title": "Nerfed again",
  "setting": "She's upset after a balance patch.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They nerfed my main again. I can't believe it.",
      "replies": [
        { "id": "a", "text": "Ugh, that's rough. What did they change?", "smoothDelta": 25, "theirResponse": "Damage down and cooldown up. It's brutal.", "coachNote": "You sympathized and asked for detail." },
        { "id": "b", "text": "That's just how patches go.", "smoothDelta": -5, "theirResponse": "Yeah, but it hurts.", "coachNote": "True but cold. Lead with sympathy." },
        { "id": "c", "text": "Isn't it good for balance though?", "smoothDelta": -15, "theirResponse": "Not when it's my main getting hit.", "coachNote": "Taking the devs' side while she's upset is risky." }
      ]
    },
    {
      "theirMessage": "Now the meta is all about the new hero, so everybody's picking him.",
      "replies": [
        { "id": "a", "text": "Are you going to switch, or stay with your main?", "smoothDelta": 25, "theirResponse": "Stay with my main! I have too many hours.", "coachNote": "Great: it's about her choice, not the tier list." },
        { "id": "b", "text": "What is the meta again?", "smoothDelta": 8, "theirResponse": "It's whatever's strongest right now. It changes each patch.", "coachNote": "Honest question. Good if it is real curiosity." },
        { "id": "c", "text": "Then just play the new hero, obviously.", "smoothDelta": -15, "theirResponse": "It's not that simple, I love my main.", "coachNote": "Games are also about attachment, not only power." }
      ]
    }
  ],
  "closingNote": "A nerf weakens; the meta shifts. She is telling you about loss and loyalty, not only numbers."
}
```

### 4.4 The raid recap (`tt-raid-recap`, lesson `conv-02`)

- **Her line 1:** "We wiped four times on the last boss but our healer finally had it down." Means: her group failed four attempts before succeeding; terms `raid`, `wipe`, `tank-healer-dps`.
- **Her line 2:** "Then I got my first piece of the new set." Means: she earned gear; term `loot`.

```json
{
  "title": "Raid night recap",
  "setting": "She gives a long, happy recap after a raid.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We wiped four times on the last boss but our healer finally had it down.",
      "replies": [
        { "id": "a", "text": "Four wipes and then a win. What changed on the fifth try?", "smoothDelta": 28, "theirResponse": "Everyone stopped standing in the fire, honestly.", "coachNote": "You understood wipes and asked about the fix." },
        { "id": "b", "text": "Sounds intense.", "smoothDelta": 5, "theirResponse": "It really was!", "coachNote": "Kind, but it does not invite more." },
        { "id": "c", "text": "Your healer must be bad if you died that much.", "smoothDelta": -20, "theirResponse": "That's not fair. They were great.", "coachNote": "Do not assign blame for people you've never met." }
      ]
    },
    {
      "theirMessage": "Then I got my first piece of the new set.",
      "replies": [
        { "id": "a", "text": "Which piece? Are you close to completing the set?", "smoothDelta": 22, "theirResponse": "Only the chest so far, four more to go.", "coachNote": "Showing you get that gear comes in sets is charming." },
        { "id": "b", "text": "Nice loot.", "smoothDelta": 8, "theirResponse": "Thanks!", "coachNote": "Fine, but try asking what it does." },
        { "id": "c", "text": "Is that the one you buy with real money?", "smoothDelta": -12, "theirResponse": "No, I earned it in the raid.", "coachNote": "Do not assume purchases; ask first." }
      ]
    }
  ],
  "closingNote": "A wipe is a failed group attempt. Ask what changed, not who was to blame."
}
```

### 4.5 Laggy night (`tt-laggy-night`, lesson `conv-03`)

- **Her line 1:** "My internet was terrible tonight. I couldn't even hit anyone." Means: high ping and lag made her lose fights; terms `lag`, `ping`.
- **Her line 2:** "I'm just so tilted right now." Means: she is frustrated and playing worse; term `tilt`.

```json
{
  "title": "The laggy night",
  "setting": "She messages you angry after a bad session.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "My internet was terrible tonight. I couldn't even hit anyone.",
      "replies": [
        { "id": "a", "text": "That sounds so frustrating. Was it lag or your Wi-Fi?", "smoothDelta": 25, "theirResponse": "Both! My ping was spiking all night.", "coachNote": "You listened first and asked a real question." },
        { "id": "b", "text": "Just get better internet.", "smoothDelta": -18, "theirResponse": "Thanks, wow, I'll do that.", "coachNote": "Do not solve it. She wants to be heard." },
        { "id": "c", "text": "Ouch.", "smoothDelta": 3, "theirResponse": "Yeah.", "coachNote": "Empathy, but no invitation to talk more." }
      ]
    },
    {
      "theirMessage": "I'm just so tilted right now.",
      "replies": [
        { "id": "a", "text": "Want to vent, or want me to distract you?", "smoothDelta": 28, "theirResponse": "Distract me. Tell me something dumb.", "coachNote": "Giving her the choice is gold." },
        { "id": "b", "text": "Maybe take a break from gaming?", "smoothDelta": -10, "theirResponse": "I know. Please don't lecture.", "coachNote": "Health tips land better when asked for." },
        { "id": "c", "text": "It's just a game.", "smoothDelta": -20, "theirResponse": "Right. Not helpful.", "coachNote": "Never shrink her frustration." }
      ]
    }
  ],
  "closingNote": "Tilt is frustration that makes you play worse. Listen before fixing."
}
```

### 4.6 What should I play? (`tt-recommend`, lesson `conv-04`)

- **Her line 1:** "You said you wanted to try something? What kind of games do you like?" Means: she is offering to recommend; term `difficulty-fit`.
- **Her line 2:** "Try this cozy farming one, it's perfect for beginners." Means: a genre suggestion; terms `cozy-game`, `farming-sim`.

```json
{
  "title": "Recommend me something",
  "setting": "She offers to pick a game for you.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "You said you wanted to try something? What kind of games do you like?",
      "replies": [
        { "id": "a", "text": "I like relaxing things and stories, but I'm not good at fast games.", "smoothDelta": 28, "theirResponse": "Perfect, that gives me a lot to work with.", "coachNote": "Honest about your taste and skill. She can now recommend well." },
        { "id": "b", "text": "Whatever you like is fine.", "smoothDelta": 3, "theirResponse": "Hmm, okay, I'll think about it.", "coachNote": "Polite but unhelpful. Give her one preference." },
        { "id": "c", "text": "I want to play the hardest game you own.", "smoothDelta": -15, "theirResponse": "Uh, you'll hate it, but okay.", "coachNote": "Do not bluff about skill." }
      ]
    },
    {
      "theirMessage": "Try this cozy farming one, it's perfect for beginners.",
      "replies": [
        { "id": "a", "text": "Cozy sounds great. What do you like about it?", "smoothDelta": 22, "theirResponse": "It's like a little routine I look forward to each day.", "coachNote": "You accepted and asked why she loves it." },
        { "id": "b", "text": "Is it free?", "smoothDelta": -3, "theirResponse": "No, but it's on sale a lot.", "coachNote": "Fair, but wait a beat before price." },
        { "id": "c", "text": "That sounds boring.", "smoothDelta": -18, "theirResponse": "Ouch. It's actually really engaging.", "coachNote": "Don't dismiss her suggestion." }
      ]
    }
  ],
  "closingNote": "When she recommends, be honest about your taste and curious about her reasons."
}
```

### 4.7 Come play with me (`tt-co-op-night`, lesson `conv-05`)

- **Her line 1:** "Want to play co-op tonight? It's easy, I promise." Means: an invitation; term `couch-coop`.
- **Her line 2:** "You can just follow me and revive me if I go down." Means: a beginner-friendly role in co-op; terms `let-her-lead`, `support-role`.

```json
{
  "title": "Come play with me",
  "setting": "She invites you to a co-op night.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Want to play co-op tonight? It's easy, I promise.",
      "replies": [
        { "id": "a", "text": "Yes! I'm a total beginner though, so be patient.", "smoothDelta": 28, "theirResponse": "Deal. I'll take it slow.", "coachNote": "Honest and warm. Perfect." },
        { "id": "b", "text": "I can't tonight, sorry.", "smoothDelta": -5, "theirResponse": "Oh, okay. Another time.", "coachNote": "Fine if true. Offer another night." },
        { "id": "c", "text": "Sure, I'm actually pretty good at games.", "smoothDelta": -18, "theirResponse": "Oh! Okay, we'll see.", "coachNote": "Bluffing skill backfires fast." }
      ]
    },
    {
      "theirMessage": "You can just follow me and revive me if I go down.",
      "replies": [
        { "id": "a", "text": "Follow and revive. I can do that. Anything I should not touch?", "smoothDelta": 22, "theirResponse": "Just the red barrels. Everything else is fine.", "coachNote": "You accepted the plan and asked a safe question." },
        { "id": "b", "text": "Okay, I'll just do my own thing.", "smoothDelta": -12, "theirResponse": "Uh, that's kind of the opposite.", "coachNote": "Co-op means playing together." },
        { "id": "c", "text": "Sure. Where do I press to revive?", "smoothDelta": 12, "theirResponse": "I'll show you when it happens.", "coachNote": "A fine, honest beginner question." }
      ]
    }
  ],
  "closingNote": "Say yes honestly. Being a willing beginner is a good partner."
}
```

### 4.8 The console got pricier (`tt-new-console`, lesson `buy-01` / live)

- **Her line 1:** "They raised the console price again. I'm so annoyed." Means: platform holder price rise; term `price-debate`.
- **Her line 2:** "I might just wait for a sale or get the handheld instead." Means: she is weighing purchase options; terms `seasonal-sale`, `handheld`.

```json
{
  "title": "The console price hike",
  "setting": "She reacts to news about a price increase.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They raised the console price again. I'm so annoyed.",
      "replies": [
        { "id": "a", "text": "Ugh, that's frustrating. Are you thinking of buying one?", "smoothDelta": 24, "theirResponse": "I was! Now I'm not sure.", "coachNote": "You empathized and asked about her plans." },
        { "id": "b", "text": "That's just how prices go.", "smoothDelta": -5, "theirResponse": "Well, thanks for that.", "coachNote": "Accurate, but cold." },
        { "id": "c", "text": "Just buy a PC then.", "smoothDelta": -15, "theirResponse": "That costs even more, come on.", "coachNote": "Do not give one-line fixes." }
      ]
    },
    {
      "theirMessage": "I might just wait for a sale or get the handheld instead.",
      "replies": [
        { "id": "a", "text": "What would the handheld let you play that you can't now?", "smoothDelta": 24, "theirResponse": "I could play in bed or on the train. And all my old games.", "coachNote": "A question about what she'd gain. Great." },
        { "id": "b", "text": "Sales are good.", "smoothDelta": 3, "theirResponse": "Yeah, the big ones are worth waiting for.", "coachNote": "Fine, but ask her thinking." },
        { "id": "c", "text": "Just buy whatever, money isn't a big deal.", "smoothDelta": -15, "theirResponse": "It is for me, actually.", "coachNote": "Do not assume her budget." }
      ]
    }
  ],
  "closingNote": "Prices are a real part of gaming talk. Ask what she is weighing, not what she should buy."
}
```

### 4.9 Watching the world championship (`tt-worlds-watch`, lesson `esp-04`)

- **Her line 1:** "Worlds starts this week and I'm taking the day off to watch." Means: the world championship of her game; term `worlds`.
- **Her line 2:** "My team has a rough group, but they've got a chance if they win the first match." Means: teams sorted into groups; terms `bracket-formats`, `org-brand`.

```json
{
  "title": "Worlds week",
  "setting": "She is excited about an esports championship.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Worlds starts this week and I'm taking the day off to watch.",
      "replies": [
        { "id": "a", "text": "That's awesome. Who are you rooting for?", "smoothDelta": 28, "theirResponse": "My favorite team! They barely made it.", "coachNote": "Simple, warm and about her." },
        { "id": "b", "text": "You're taking a day off for video games?", "smoothDelta": -18, "theirResponse": "It's like a sports final for me.", "coachNote": "Never mock the effort; treat it like a final." },
        { "id": "c", "text": "Cool. What's Worlds?", "smoothDelta": 10, "theirResponse": "The big international tournament for my game!", "coachNote": "An honest question that lets her explain." }
      ]
    },
    {
      "theirMessage": "My team has a rough group, but they've got a chance if they win the first match.",
      "replies": [
        { "id": "a", "text": "Who's in their group? Anyone they've beaten before?", "smoothDelta": 22, "theirResponse": "Two strong teams, but they beat one of them in the spring.", "coachNote": "Curious about the group and history. Good." },
        { "id": "b", "text": "I hope they win!", "smoothDelta": 8, "theirResponse": "Me too!", "coachNote": "Kind, but ask something specific if you can." },
        { "id": "c", "text": "Isn't that team kind of overrated?", "smoothDelta": -20, "theirResponse": "Excuse me?", "coachNote": "Never criticize her team unprompted." }
      ]
    }
  ],
  "closingNote": "Treat esports like any final she cares about: ask who she is rooting for and why."
}
```

## 5. Talk Track roster at launch (24)

1. `tt-ranked-up` (conv-01), 2. `tt-boss-tries` (aa-01), 3. `tt-nerfed-main` (vocab-02), 4. `tt-raid-recap` (conv-02), 5. `tt-laggy-night` (conv-03), 6. `tt-recommend` (conv-04), 7. `tt-co-op-night` (conv-05), 8. `tt-new-console` (buy-01), 9. `tt-worlds-watch` (esp-04) (the nine above are written in full).
10. `tt-backlog` (she is choosing what to play next), 11. `tt-cozy-village` (she shows her farm or island; `cozy-04`), 12. `tt-gift-hint` (she drops a wishlist hint; `buy-03`), 13. `tt-speedrun-clip` (she shares a speedrun; `cult-05`), 14. `tt-lets-play` (she watches a streamer; `tog-07`), 15. `tt-spoiler-save` (she asks you not to spoil; `aa-05`), 16. `tt-difficulty-debate` (she defends hard games; `deb-03`), 17. `tt-fighting-set` (she watches a set; `fight-04`), 18. `tt-shooter-clutch` (a clutch story; `shoot-05`), 19. `tt-moba-draft` (draft rant; `sm-05`), 20. `tt-gacha-pity` (pity rant; `rpg-05`), 21. `tt-your-first-game` (you tell her about your first game; `cult-01`), 22. `tt-remake-nostalgia` (a remake announced; `deb-05`), 23. `tt-patch-day` (patch-day dread; `live-04`), 24. `tt-honest-idk` (admit not knowing; `conv-07`).

## 6. Asset needs (all `original-swoond`)

- **Images (SVG, original):** `art/camera-view-a.svg` (third-person mock), `camera-view-b.svg` (first-person), `camera-view-c.svg` (isometric), `camera-view-d.svg` (side-scroller), `art/rarity-ladder.svg`, `art/hud-cooldown-ring.svg`, generic controller silhouettes, generic HUD diagrams (`hud-generic-shooter`, `hud-generic-rpg`, `moba-map-generic`, `controller-generic-twinstick`), a genre-map poster. None resembles a specific game.
- **Audio (m4a, original synthesized):** `audio/cues/low-health-alarm.m4a`, `loot-chime.m4a`, `hit-marker-tick.m4a`, `level-up-jingle.m4a`, `menu-select-tick.m4a`, `checkpoint-tone.m4a`, `boss-warning-drone.m4a`, `ready-check-ding.m4a`, `victory-fanfare.m4a`, `defeat-sting.m4a`. Recipe documented with each file; no sampled game audio.
- **Procedural diagrams (no file):** tournament bracket, rank ladder, timeline diagrams for i-frames, cooldowns and netcode.

## 7. Voice and safety notes

- Cheeky coach, never mean, never about her. One joke per screen. No jokes at the expense of any group of players (casuals, hardcore, mobile, console).
- Never present a review score, sales number or price as a lesson fact; those are live cards with sources and dates.
- Loot boxes and gacha are described neutrally; no pull simulation; never a spending nudge.
- Toxicity scenarios teach mute/report/leave; safety notes appear where personal safety or spending worry is involved.
- Never coach faking skill or ownership. Follow-ups are honest curiosity.
