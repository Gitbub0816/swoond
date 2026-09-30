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

