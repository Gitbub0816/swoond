# Native Exercise Plan: Books (`books`)

Tier B plan for `docs/courses/books/`. Eleven native types are used; there are **no Unity sims** (CDS section 12) and **no `listening-id` or `timing-tap`** (no licensed audio; rhythm is not a book concept). Sample payloads below use the exact contract shape and were checked against `docs/contracts/native-exercises/v1/*.schema.json` with the repo's ajv setup (see the report for the count).

**Rights guardrail (spec section 40).** No exercise shows a real cover, blurb, excerpt or review. Any "passage" in an exercise is **original Swoon'd text** written for teaching (never quoted from a book). `visual-id` images are original Swoon'd illustrations (`original-swoond`) of formats and genre conventions, never real jackets. Book and author names appear as facts only, mostly in `say-this` lines a person might really say. Sample `image.asset` and `diagramId` values are *to-be-produced* assets (section 6).

## 1. Plan summary

| Type | How it is used | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite: definitions, distinctions (longlist vs shortlist), "which is true". Distractors are the misconceptions in CDS section 2. | ~220 |
| `binary-call` | Two-way calls with no diagram (`scene.kind` is `none` with `alt`): first person or close third; plot-driven or character-driven; DNF fine or not. | ~100 |
| `term-match` | Introduce 3-6 related terms at unit start (reader shorthand, POV, trope names, prizes). | ~60 |
| `sequence-order` | Publishing pipeline, story structure order, how a club meeting runs, release-week timeline. | ~30 |
| `visual-id` | Recognise formats and genre-convention stand-ins from original illustrations. | ~40 |
| `decision-scenario` | Recommend, gift, spoiler and etiquette judgment; graded best/acceptable/poor. | ~60 |
| `talk-track` | 30 conversation tracks (20 at launch). | ~30 |
| `say-this` | "What is she talking about?" (star of the course). | ~160 |
| `fill-the-gap` | Vocabulary in context; quick review. | ~60 |
| `estimate-slider` | Magnitudes: word counts, prize money, ISBN digits. | ~20 |
| `hotspot-tap` | Book anatomy, bookstore floor, story arc diagram. | ~20 |

Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this`; nothing rewards a "correct opinion" about a book.

## 2. Sample items by type

Each sample lists its planned lesson id.

### 2.1 `multiple-choice`

#### mc-01 (`multiple-choice`, lesson `rl-01`)
```json
{
  "prompt": "She says she DNF'd a book. What happened?",
  "options": [
    { "id": "stopped", "text": "She stopped reading it before the end", "explanation": "DNF means did not finish. It is a decision, not a failure." },
    { "id": "lost", "text": "She lost the book", "explanation": "Nothing to do with losing it." },
    { "id": "gift", "text": "She gave it away as a present", "explanation": "That would be a gift, not a DNF." },
    { "id": "reread", "text": "She reads it again every year", "explanation": "That is a reread or a comfort read." }
  ],
  "correctOptionIds": ["stopped"],
  "allowMultiple": false,
  "shuffle": true,
  "explanation": {
    "correct": "DNF means did not finish. Most enthusiasts DNF books without guilt, at 10 percent or 60 percent, because their reading time is limited and a book that is not working is not worth the slog.",
    "incorrect": "DNF stands for did not finish: she started the book and chose to stop. It is a normal part of reading life, not a judgment on you or on readers who finish everything.",
    "sayThisLine": "What made you put it down, the pacing or the characters?"
  }
}
```

#### mc-02 (`multiple-choice`, lesson `pc-01`)
```json
{
  "prompt": "What is a prize longlist?",
  "options": [
    { "id": "wide", "text": "A wider first cut of titles, narrowed later to a shortlist", "explanation": "Right: longlist comes first, then shortlist, then winner." },
    { "id": "winners", "text": "The list of every past winner", "explanation": "That is a roll of honour, not a longlist." },
    { "id": "shortlist", "text": "The same thing as a shortlist", "explanation": "A shortlist is the smaller, later cut." },
    { "id": "bestseller", "text": "A bestseller chart", "explanation": "Bestseller charts count sales; a longlist is chosen by judges." }
  ],
  "correctOptionIds": ["wide"],
  "explanation": {
    "correct": "Many prizes announce a longlist first (often 10 to 20 books), then a shortlist (often six), then a winner. Being on a longlist is an honour and a sales boost, but it is not the same as being a finalist.",
    "incorrect": "A longlist is the first, wider cut of books judges are still considering. It narrows to a shortlist and then one winner. Knowing the difference stops you saying a longlisted book 'lost'.",
    "sayThisLine": "Oh, that one made the longlist? Did it get shortlisted too?"
  }
}
```

#### mc-03 (`multiple-choice`, lesson `sc-03`)
```json
{
  "prompt": "Which sentence is written in close third person?",
  "options": [
    { "id": "first", "text": "\"I knew the door was locked, and I hated it.\"", "explanation": "That is first person: 'I'." },
    { "id": "close-third", "text": "\"She knew the door was locked and hated that she knew.\"", "explanation": "Third person, told from inside her thoughts." },
    { "id": "second", "text": "\"You know the door is locked, and you hate it.\"", "explanation": "Second person: 'you'." },
    { "id": "omni", "text": "\"Nobody in the town knew what the locked door hid, but the door itself had been waiting.\"", "explanation": "Omniscient: a narrator who knows beyond one character." }
  ],
  "correctOptionIds": ["close-third"],
  "explanation": {
    "correct": "Close third uses 'she' or 'he' but stays inside one character's head, so the reader gets her thoughts without an 'I'. Many romance and thriller readers love it for intimacy plus flexibility.",
    "incorrect": "Close third person uses he or she but limits us to one character's thoughts and perceptions. First person uses 'I', second uses 'you', omniscient knows more than any character. The tell is whose head we are in.",
    "sayThisLine": "Is it first person or close third? I always notice that first."
  }
}
```

#### mc-04 (`multiple-choice`, lesson `pb-02`)
```json
{
  "prompt": "What is an imprint?",
  "options": [
    { "id": "brand", "text": "A named publishing brand inside a larger publisher", "explanation": "Yes: a label with its own taste and identity." },
    { "id": "printing", "text": "One print run of a book", "explanation": "That is a printing." },
    { "id": "mark", "text": "The ink stamp on a library book", "explanation": "That is a library stamp." },
    { "id": "agent", "text": "A literary agent's assistant", "explanation": "That is an assistant, not an imprint." }
  ],
  "correctOptionIds": ["brand"],
  "explanation": {
    "correct": "Big publishers are built from imprints, each with its own list and editors. Readers sometimes follow an imprint the way film fans follow a studio.",
    "incorrect": "An imprint is a brand within a publisher, like a label with its own taste. It is not a printing or a stamp. Big publishing houses hold dozens of imprints.",
    "sayThisLine": "Which imprint is that from? Some of them have a really consistent taste."
  }
}
```

### 2.2 `binary-call`

#### bc-01 (`binary-call`, lesson `sc-05`)
```json
{
  "prompt": "The narrator hides a key fact. Unreliable narrator?",
  "scene": { "kind": "none", "alt": "A short original setup: a narrator tells us a friend 'was never there that night', but later details prove the friend was." },
  "choices": [
    { "id": "yes", "label": "Yes, unreliable" },
    { "id": "no", "label": "No, reliable" }
  ],
  "correctChoiceId": "yes",
  "explanation": {
    "correct": "An unreliable narrator is one whose account we cannot fully trust, through lying, self-deception or missing knowledge. Catching it is much of the fun.",
    "incorrect": "When a narrator claims one thing and the story shows another, the narrator is unreliable. A narrator can be honest yet limited, but here the account and the facts clash.",
    "sayThisLine": "When did you first notice you couldn't trust her?"
  },
  "ruleTag": "Unreliable narrator"
}
```

#### bc-02 (`binary-call`, lesson `tr-01`)
```json
{
  "prompt": "She loves slow, interior books. Recommend a fast heist?",
  "scene": { "kind": "none", "alt": "A friend says she loves quiet books about people thinking and remembering, with little happening on the surface." },
  "choices": [
    { "id": "risky", "label": "Probably a mismatch" },
    { "id": "sure", "label": "Safe bet" }
  ],
  "correctChoiceId": "risky",
  "explanation": {
    "correct": "She has told you what she values: interiority over plot momentum. A fast heist novel promises the opposite, so it is a risky rec unless it is famously character-rich.",
    "incorrect": "Match taste, not reputation. Someone who loves slow, interior books usually values character and language over speed. A plot-first heist promises different pleasures.",
    "sayThisLine": "Is it more the writing or the characters that pulls you in?"
  },
  "ruleTag": "Character vs plot"
}
```

#### bc-03 (`binary-call`, lesson `dc-01`)
```json
{
  "prompt": "Is it wrong to quit a book you dislike?",
  "scene": { "kind": "none", "alt": "A reader explains she stopped a book at page 60 because she was bored." },
  "choices": [
    { "id": "fine", "label": "No, it is fine" },
    { "id": "wrong", "label": "Yes, she must finish" }
  ],
  "correctChoiceId": "fine",
  "explanation": {
    "correct": "Most readers see quitting as normal. A minority like to finish everything; both are allowed. Do not tell someone their DNF is a failing.",
    "incorrect": "There is no rule that a reader must finish. Many enthusiasts DNF freely because time is limited. If she is happy with her call, agree with her instinct and ask why.",
    "sayThisLine": "Good call, life's short. What was the last thing you loved?"
  },
  "ruleTag": "DNF is normal"
}
```

### 2.3 `term-match`

#### tm-01 (`term-match`, lesson `rl-01`)
```json
{
  "prompt": "Match the reader shorthand.",
  "pairs": [
    { "id": "tbr", "term": "TBR", "definition": "Books you plan to read, or the pile of them" },
    { "id": "dnf", "term": "DNF", "definition": "Started it but did not finish" },
    { "id": "arc", "term": "ARC", "definition": "An advance copy sent before publication" },
    { "id": "reread", "term": "Reread", "definition": "Reading a favourite again" }
  ],
  "distractorDefinitions": ["A book that is out of print"],
  "explanation": {
    "summary": "These four show up constantly in reader chat. TBR is a to-be-read list or pile, DNF is quitting, an ARC is an advance reader copy, and a reread is a comfort return.",
    "sayThisLine": "How tall is your TBR right now?"
  }
}
```

#### tm-02 (`term-match`, lesson `sc-03`)
```json
{
  "prompt": "Match each point of view to its tell.",
  "pairs": [
    { "id": "first", "term": "First person", "definition": "Told by a character as 'I'" },
    { "id": "close", "term": "Close third", "definition": "'She' or 'he', inside one head" },
    { "id": "omni", "term": "Omniscient", "definition": "A narrator who knows more than any character" },
    { "id": "second", "term": "Second person", "definition": "Addresses the reader as 'you'" }
  ],
  "distractorDefinitions": ["Told in letters only"],
  "explanation": {
    "summary": "Point of view is about whose knowledge and voice we get. First person uses 'I', close third stays inside one head, omniscient roams, second person says 'you'.",
    "sayThisLine": "Is it first person or close third? That changes how it feels."
  }
}
```

#### tm-03 (`term-match`, lesson `rm-02`)
```json
{
  "prompt": "Match the trope to what it means.",
  "pairs": [
    { "id": "e2l", "term": "Enemies-to-lovers", "definition": "Rivals who slowly fall in love" },
    { "id": "f2l", "term": "Friends-to-lovers", "definition": "Longtime friends become partners" },
    { "id": "fake", "term": "Fake dating", "definition": "A pretend couple who catch real feelings" },
    { "id": "grumpy", "term": "Grumpy-sunshine", "definition": "A cranky lead paired with a cheerful one" },
    { "id": "prox", "term": "Forced proximity", "definition": "Stuck together by circumstance" }
  ],
  "distractorDefinitions": ["A twist ending revealed in the last chapter"],
  "explanation": {
    "summary": "Tropes are recognisable setups readers actively seek out, like a menu. They are promises of a pleasure, not lazy clichés, which is why readers name them in advance.",
    "sayThisLine": "Is it more enemies-to-lovers or friends-to-lovers?"
  }
}
```

### 2.4 `sequence-order`

#### so-01 (`sequence-order`, lesson `pb-01`)
```json
{
  "prompt": "Order the path from manuscript to shelf.",
  "items": [
    { "id": "write", "text": "Author finishes a manuscript", "why": "Nothing starts until there is a finished book." },
    { "id": "agent", "text": "A literary agent takes it on", "why": "Most big publishers only read agented submissions." },
    { "id": "sell", "text": "An editor acquires it and pays an advance", "why": "The publisher buys the right to publish it." },
    { "id": "edit", "text": "Editing, copyedits and cover design", "why": "The book is shaped and packaged." },
    { "id": "publish", "text": "Publication day and reviews", "why": "The book meets readers on its pub date." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "The traditional route runs manuscript, agent, acquiring editor, editing and design, then publication. Self-publishing skips the agent and editor buyer but still needs editing and design.",
    "incorrect": "The usual order is: finished manuscript, agent, editor acquires with an advance, editing and design, then publication. Each step depends on the one before it.",
    "sayThisLine": "Did she go through an agent, or publish it herself?"
  }
}
```

#### so-02 (`sequence-order`, lesson `sc-06`)
```json
{
  "prompt": "Order a classic three-act story.",
  "items": [
    { "id": "setup", "text": "Setup: meet the lead and their world", "why": "We need to care before things break." },
    { "id": "inciting", "text": "An event disrupts the ordinary life", "why": "The story starts when something changes." },
    { "id": "rising", "text": "Complications and rising stakes", "why": "Tension builds through obstacles." },
    { "id": "climax", "text": "The climax: the decisive confrontation", "why": "Stakes peak in one decisive scene." },
    { "id": "resolution", "text": "Resolution: the new normal", "why": "Loose ends settle and the change lands." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Three-act structure runs setup, disruption, rising complications, climax, resolution. Many books bend it, but readers feel the shape even when they cannot name it.",
    "incorrect": "The usual shape is setup, then a disruption, then rising complications, a climax, and a resolution. Not every book follows it, but it is the shape readers expect by default.",
    "sayThisLine": "Where did it lose you, the middle or the ending?"
  }
}
```

#### so-03 (`sequence-order`, lesson `rlf-01`)
```json
{
  "prompt": "Order a typical book club month.",
  "items": [
    { "id": "pick", "text": "The group picks a book", "why": "Everyone needs the same title." },
    { "id": "read", "text": "Everyone reads at their own pace", "why": "Most clubs give a few weeks." },
    { "id": "ask", "text": "The host prepares a few open questions", "why": "Good questions keep the talk flowing." },
    { "id": "meet", "text": "Meet, eat and talk about it", "why": "The social part is often the point." },
    { "id": "next", "text": "Vote on the next pick", "why": "The cycle restarts." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "A club cycle is pick, read, prepare questions, meet, then choose the next book. The talk matters as much as the book, and clubs vary a lot in how strict they are.",
    "incorrect": "A club usually picks a book, reads it, prepares questions, meets to talk, and votes on the next one. Many clubs are relaxed about finishing.",
    "sayThisLine": "What did your club pick this month?"
  }
}
```

### 2.5 `visual-id`

#### vi-01 (`visual-id`, lesson `be-01`)
```json
{
  "prompt": "Which format is this illustration?",
  "image": {
    "asset": "books/technique/format-trade-paperback.svg",
    "alt": "A flat illustration of a book with a soft flexible cover, taller than a pocket paperback, with a slightly rough spine.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "trade", "text": "Trade paperback", "explanation": "Soft cover in a larger size than mass-market." },
    { "id": "hardcover", "text": "Hardcover", "explanation": "Hardcovers have rigid boards and often a dust jacket." },
    { "id": "mass", "text": "Mass-market paperback", "explanation": "Smaller, cheaper, thinner paper." },
    { "id": "ebook", "text": "Ebook reader", "explanation": "A screen, not paper." }
  ],
  "correctOptionId": "trade",
  "explanation": {
    "correct": "Trade paperbacks are the larger soft-cover format, often the first paperback after a hardcover. They cost less than a hardcover and feel sturdier than mass-market.",
    "incorrect": "The flexible cover rules out a hardcover; the larger size rules out mass-market. It is a trade paperback, the larger soft-cover size most readers know.",
    "sayThisLine": "Do you prefer hardcover or trade paperback?"
  },
  "cues": ["Soft flexible cover", "Larger than a pocket paperback", "Usually pricier than mass-market"]
}
```

#### vi-02 (`visual-id`, lesson `gm-02`)
```json
{
  "prompt": "Which genre does this stand-in cover suggest?",
  "image": {
    "asset": "books/technique/genre-standin-thriller.svg",
    "alt": "An original abstract mock cover: a dark background, huge sans-serif capital letters, a single thin red line, and a small lone figure silhouetted at the bottom.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "thriller", "text": "Thriller or mystery", "explanation": "Dark palette, big bold type, a lone figure." },
    { "id": "romcom", "text": "Rom-com", "explanation": "Rom-coms use bright colours and playful illustration." },
    { "id": "cozy", "text": "Cozy fantasy", "explanation": "Cozy fantasy leans warm and illustrated." },
    { "id": "lit", "text": "Literary fiction", "explanation": "Literary covers are often quieter, with restrained type." }
  ],
  "correctOptionId": "thriller",
  "explanation": {
    "correct": "Cover design is a promise about genre. Dark palettes, big bold type and a lone figure signal tension. Readers use these signals to shop quickly.",
    "incorrect": "The dark palette and bold type point to thriller or mystery. Covers act as genre shorthand, though they can mislead, and publishers change them across editions.",
    "sayThisLine": "That cover looks like a thriller. Is it as tense as it looks?"
  },
  "cues": ["Dark palette", "Large bold type", "Lone figure"]
}
```

#### vi-03 (`visual-id`, lesson `dc-04`)
```json
{
  "prompt": "What is this special-edition feature?",
  "image": {
    "asset": "books/technique/edition-sprayed-edges.svg",
    "alt": "An original illustration of a closed book seen from the side, where the page edges are coloured with a bright pattern instead of plain white paper.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "sprayed", "text": "Sprayed edges", "explanation": "Colour or pattern applied to the page block." },
    { "id": "bookmark", "text": "A ribbon bookmark", "explanation": "Ribbons hang from the spine." },
    { "id": "errata", "text": "An errata slip", "explanation": "A loose sheet noting corrections." },
    { "id": "torn", "text": "Water damage", "explanation": "Damage is uneven, not a designed pattern." }
  ],
  "correctOptionId": "sprayed",
  "explanation": {
    "correct": "Sprayed edges are coloured or patterned page edges, a popular special-edition extra, especially in fantasy and romance. They are a collectible detail, not part of the story.",
    "incorrect": "A designed colour or pattern on the page edges is called sprayed edges. It is common in special editions, and readers who collect them often talk about the edges first.",
    "sayThisLine": "Are the edges sprayed on that one? I've seen those look amazing."
  },
  "cues": ["Colour on the page block", "A designed pattern", "Seen from the side"]
}
```

### 2.6 `decision-scenario`

#### ds-01 (`decision-scenario`, lesson `tr-05`)
```json
{
  "prompt": "Choose a gift book for someone who loves cozy fantasy.",
  "situation": {
    "narrative": "It is her birthday. You know she is a big cozy-fantasy reader and you have never read the genre.",
    "facts": [
      { "label": "Her taste", "value": "Cozy fantasy, low stakes" },
      { "label": "Your knowledge", "value": "None of the genre" },
      { "label": "Time", "value": "One evening" },
      { "label": "Risk", "value": "She may already own it", "emphasis": "warning" }
    ]
  },
  "options": [
    { "id": "ask", "label": "Ask her friend or a bookseller what she has been wanting", "verdict": "best", "consequence": "You learn what she wants and whether she already owns it.", "considerations": ["A bookseller knows the genre", "Avoids duplicates", "Shows you care"] },
    { "id": "bestseller", "label": "Buy the current bestseller", "verdict": "acceptable", "consequence": "It may be fine, but a bestseller is not the same as her taste.", "considerations": ["Popular is not personal", "Might be a duplicate"] },
    { "id": "classic", "label": "Buy a famous classic you always meant to read", "verdict": "poor", "consequence": "It says more about you than her.", "considerations": ["Ignores her stated taste", "A gift should fit the reader"] }
  ],
  "expertNote": "The best gift shows you noticed her taste. Ask a bookseller for two or three cozy-fantasy picks, then choose one and add a gift receipt.",
  "sayThisLine": "I don't read much cozy fantasy, so I asked the bookseller what fans love."
}
```

#### ds-02 (`decision-scenario`, lesson `rl-05`)
```json
{
  "prompt": "She is mid-book. Do you spoil the ending?",
  "situation": {
    "narrative": "You finished the same novel last week and are dying to talk about the ending.",
    "facts": [
      { "label": "Her progress", "value": "About halfway" },
      { "label": "Your urge", "value": "Very high" },
      { "label": "Her preference", "value": "Unknown" },
      { "label": "Spoiler risk", "value": "High", "emphasis": "warning" }
    ]
  },
  "options": [
    { "id": "ask", "label": "Ask if she wants spoilers, then keep vague until she finishes", "verdict": "best", "consequence": "She feels respected and you save the good talk.", "considerations": ["Ask before you spoil", "Save specifics for later"] },
    { "id": "hint", "label": "Say 'the ending is wild' without details", "verdict": "acceptable", "consequence": "It teases but does not spoil.", "considerations": ["Still shapes her expectations"] },
    { "id": "spoil", "label": "Blurt out the twist", "verdict": "poor", "consequence": "You cannot un-spoil it.", "considerations": ["Ruins the experience", "Easy to avoid"] }
  ],
  "expertNote": "Readers protect the surprise. Ask, then wait. A good line is 'text me when you finish, I have thoughts.'",
  "sayThisLine": "No spoilers. Tell me the second you finish."
}
```

#### ds-03 (`decision-scenario`, lesson `bt-03`)
```json
{
  "prompt": "She asks if you have read her favourite. You have not.",
  "situation": {
    "narrative": "She lights up: 'Have you read it?' You have not.",
    "facts": [
      { "label": "Her mood", "value": "Excited" },
      { "label": "Your status", "value": "Never read it" },
      { "label": "Temptation", "value": "Bluff", "emphasis": "warning" }
    ]
  },
  "options": [
    { "id": "honest", "label": "'Not yet, tell me why you love it'", "verdict": "best", "consequence": "She gets to share what she loves and you learn something real.", "considerations": ["Honest", "Invites her enthusiasm"] },
    { "id": "vague", "label": "'I have heard it is great'", "verdict": "acceptable", "consequence": "Safe, but leaves the conversation flat.", "considerations": ["True but passive"] },
    { "id": "bluff", "label": "'Oh, I loved it'", "verdict": "poor", "consequence": "The next question exposes the bluff.", "considerations": ["Fake expertise backfires"] }
  ],
  "expertNote": "Enthusiasts love explaining. Honesty plus curiosity beats bluffing every time.",
  "sayThisLine": "Not yet. What's the thing about it you'd want me to notice?"
}
```

### 2.7 `talk-track` (samples; full Talk Track scenarios in section 4)

#### tt-01 (`talk-track`, lesson `bt-01`)
```json
{
  "title": "What are you reading?",
  "setting": "Texting after she posts a photo of her book",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Finally started the book everyone keeps recommending. Chapter 3 and I'm hooked.",
      "replies": [
        { "id": "ask-what", "text": "Nice! What is it about, in your words?", "smoothDelta": 20, "theirResponse": "Ha, okay, so it's about two rivals stuck on a road trip...", "coachNote": "Asking for her words invites her to share what she loves." },
        { "id": "quiz", "text": "Which edition did you get?", "smoothDelta": 0, "theirResponse": "Uh, the paperback? Why?", "coachNote": "Fine, but it is a bit of a side quest right now." },
        { "id": "bluff", "text": "Oh yeah, I heard the ending is great.", "smoothDelta": -15, "theirResponse": "Wait, you know the ending?!", "coachNote": "Spoiler risk and fake expertise in one line." }
      ]
    }
  ],
  "closingNote": "Curiosity about what she loves beats trivia."
}
```

#### tt-02 (`talk-track`, lesson `bt-04`)
```json
{
  "title": "You disliked it",
  "setting": "At coffee, after finishing the same book",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "So? Did you like the book I lent you?",
      "replies": [
        { "id": "honest-kind", "text": "Honestly, the middle dragged for me, but the ending got me. What worked for you?", "smoothDelta": 25, "theirResponse": "Oh, I get that! The middle is slow, but I loved the ending...", "coachNote": "Honest, specific, and curious about her view." },
        { "id": "gush", "text": "It was amazing, best thing ever!", "smoothDelta": -5, "theirResponse": "Really? Which part?", "coachNote": "Overpraise gets tested by the next question." },
        { "id": "dismiss", "text": "Kind of boring.", "smoothDelta": -15, "theirResponse": "Oh. Okay.", "coachNote": "Blunt with no curiosity closes the door." }
      ]
    }
  ],
  "closingNote": "You can disagree about a book and still be warm."
}
```

#### tt-03 (`talk-track`, lesson `sa-03`)
```json
{
  "title": "The adaptation",
  "setting": "After watching a screen version of her favourite book",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Okay, they cut half the book. I have Thoughts.",
      "replies": [
        { "id": "which-part", "text": "Which part do you miss most?", "smoothDelta": 22, "theirResponse": "The whole subplot with the sisters!", "coachNote": "Asks about her attachment, not the film's quality." },
        { "id": "better", "text": "Movies are always better anyway.", "smoothDelta": -20, "theirResponse": "...Excuse me?", "coachNote": "A hot take that shuts her down." },
        { "id": "neutral", "text": "Adaptations always cut things.", "smoothDelta": 5, "theirResponse": "True, but still!", "coachNote": "True but flat; ask her instead." }
      ]
    }
  ],
  "closingNote": "Let her mourn the cut subplot."
}
```

### 2.8 `say-this`

#### st-01 (`say-this`, lesson `rl-01`)
```json
{
  "statement": { "speaker": "Maya", "text": "I DNF'd it at 40 percent. The pacing killed me." },
  "question": "What is she talking about?",
  "options": [
    { "id": "quit", "text": "She stopped reading before the end", "explanation": "DNF means did not finish.", "isCorrect": true },
    { "id": "slow", "text": "The story felt too slow for her", "explanation": "Pacing is about how fast the story moves.", "isCorrect": true },
    { "id": "diet", "text": "Something about a diet", "explanation": "Nothing to do with food.", "isCorrect": false },
    { "id": "sports", "text": "A sports injury", "explanation": "Pacing here is about story speed.", "isCorrect": false }
  ],
  "translation": "She gave the book a fair try, got 40 percent in, and quit because it moved too slowly for her.",
  "followUps": [
    { "line": "Was it slow, or just not your kind of story?", "why": "Invites her to say what she wanted." },
    { "line": "What is the last book that hooked you fast?", "why": "Moves toward what she does like." }
  ],
  "noFakeExpertNote": "You do not need to know the book. Ask what pulled her out."
}
```

#### st-02 (`say-this`, lesson `gm-04`)
```json
{
  "statement": { "speaker": "Priya", "text": "It's enemies-to-lovers with forced proximity, so obviously I'm in." },
  "question": "What is she talking about?",
  "options": [
    { "id": "rivals", "text": "Two people who dislike each other end up together", "explanation": "Enemies-to-lovers.", "isCorrect": true },
    { "id": "stuck", "text": "They are stuck in the same place", "explanation": "Forced proximity.", "isCorrect": true },
    { "id": "sequel", "text": "It is a sequel", "explanation": "Not mentioned.", "isCorrect": false },
    { "id": "spoiler", "text": "She is giving away the ending", "explanation": "She describes setup, not ending.", "isCorrect": false },
    { "id": "promise", "text": "These tropes are things she seeks out", "explanation": "She says 'obviously I'm in': it is a promise she wants.", "isCorrect": true }
  ],
  "translation": "It is a romance where rivals fall for each other and are trapped together, exactly the setup she loves.",
  "followUps": [
    { "line": "Do you like the slow-burn version or the fast one?", "why": "Shows you know tropes have variations." },
    { "line": "What is your favourite trope to see done well?", "why": "Invites her taste, not a quiz." }
  ],
  "noFakeExpertNote": "Tropes are things she likes on purpose. Curiosity beats pretending."
}
```

#### st-03 (`say-this`, lesson `sc-05`)
```json
{
  "statement": { "speaker": "Jonah", "text": "The narrator is so unreliable, I had to go back and reread chapter one." },
  "question": "What is he talking about?",
  "options": [
    { "id": "trust", "text": "The narrator's account cannot be fully trusted", "explanation": "That is unreliable narration.", "isCorrect": true },
    { "id": "reread", "text": "He went back to check earlier clues", "explanation": "Rereading is part of the fun.", "isCorrect": true },
    { "id": "typo", "text": "The book has printing mistakes", "explanation": "Unreliable is about the narrator.", "isCorrect": false },
    { "id": "audio", "text": "The audiobook glitched", "explanation": "Not what he said.", "isCorrect": false }
  ],
  "translation": "The story is told by someone who is lying, mistaken or hiding something, and he flipped back to spot the clues.",
  "followUps": [
    { "line": "When did you first suspect them?", "why": "Invites his experience of catching it." },
    { "line": "Did the reread change how you saw chapter one?", "why": "Shows you get the pleasure of rereading." }
  ],
  "noFakeExpertNote": "Ask when he suspected; do not guess the twist."
}
```

#### st-04 (`say-this`, lesson `sa-02`)
```json
{
  "statement": { "speaker": "Leo", "text": "I'm three books in and the fourth is two years away. I'm in mourning." },
  "question": "What is he talking about?",
  "options": [
    { "id": "wait", "text": "A long wait for the next book in a series", "explanation": "Sequel wait.", "isCorrect": true },
    { "id": "series", "text": "He is deep in a multi-book series", "explanation": "Three books in.", "isCorrect": true },
    { "id": "pass", "text": "Someone has died", "explanation": "Mourning is a joke about the wait.", "isCorrect": false },
    { "id": "cancel", "text": "The series was cancelled", "explanation": "It is delayed, not cancelled.", "isCorrect": false }
  ],
  "translation": "He loves a series and is sad the next book will not arrive for two years.",
  "followUps": [
    { "line": "Do you reread the earlier ones while you wait?", "why": "Common practice; asks about his habits." },
    { "line": "What made you hooked on it?", "why": "Turns waiting into what he loves." }
  ],
  "noFakeExpertNote": "Do not guess when the book comes out. Ask what he is hoping for."
}
```

### 2.9 `fill-the-gap`

#### fg-01 (`fill-the-gap`, lesson `sc-08`)
```json
{
  "prompt": "Complete the pacing sentence.",
  "template": "A chapter that ends on a {{gap-a}} makes you turn the page, and a fast, gripping book is called a {{gap-b}}.",
  "gaps": [
    { "id": "gap-a", "options": ["cliffhanger", "colophon", "epigraph"], "correct": "cliffhanger" },
    { "id": "gap-b", "options": ["page-turner", "doorstop", "backlist"], "correct": "page-turner" }
  ],
  "explanation": {
    "correct": "A cliffhanger ends a chapter on unresolved tension, and a page-turner is a book you cannot put down. Authors use hooks and cliffhangers to keep momentum.",
    "incorrect": "A cliffhanger ends on unresolved tension. A page-turner is a gripping, fast read. A colophon is publication info, a doorstop is a very thick book, and backlist means older titles.",
    "sayThisLine": "That chapter ending was a total cliffhanger."
  }
}
```

#### fg-02 (`fill-the-gap`, lesson `pb-06`)
```json
{
  "prompt": "Finish the publishing sentence.",
  "template": "New releases are the {{gap-a}}, while older titles that keep selling are the {{gap-b}}.",
  "gaps": [
    { "id": "gap-a", "options": ["frontlist", "backlist", "imprint"], "correct": "frontlist" },
    { "id": "gap-b", "options": ["backlist", "frontlist", "advance"], "correct": "backlist" }
  ],
  "explanation": {
    "correct": "Frontlist means recent releases a publisher is promoting; backlist means older titles that continue to sell. A backlist book can suddenly boom, for example after an adaptation or a viral moment.",
    "incorrect": "The frontlist is this season's new books and the backlist is older titles that keep selling. An imprint is a publishing brand and an advance is an up-front payment.",
    "sayThisLine": "That's actually an old backlist book that took off."
  }
}
```

#### fg-03 (`fill-the-gap`, lesson `gm-03`)
```json
{
  "prompt": "Match the age categories.",
  "template": "Books for readers about 12 to 18 are {{gap-a}}, and books in between grade school and teens are {{gap-b}}.",
  "gaps": [
    { "id": "gap-a", "options": ["young adult", "middle grade", "new adult"], "correct": "young adult" },
    { "id": "gap-b", "options": ["middle grade", "young adult", "adult"], "correct": "middle grade" }
  ],
  "explanation": {
    "correct": "Young adult (YA) targets teens; middle grade targets roughly 8 to 12. Many adults read YA, and crossover books appeal across categories.",
    "incorrect": "YA is for teens, middle grade is for older children, and new adult is for the early twenties. Age categories are about the protagonist's age and themes, not who is allowed to read it.",
    "sayThisLine": "Is it YA, or more adult? Some cross over."
  }
}
```

### 2.10 `estimate-slider`

#### es-01 (`estimate-slider`, lesson `be-04`)
```json
{
  "prompt": "How many words in a typical adult novel?",
  "unit": "words",
  "min": 10000,
  "max": 250000,
  "step": 5000,
  "correctValue": 85000,
  "tolerance": { "full": 15000, "partial": 35000 },
  "explanation": {
    "correct": "Most adult novels fall roughly between 70,000 and 100,000 words. Epic fantasy often runs far longer, and literary novels can run shorter.",
    "incorrect": "A typical adult novel is around 70,000 to 100,000 words. Under about 40,000 is often a novella, and huge fantasy doorstops can top 200,000.",
    "sayThisLine": "Is it a quick read, or a doorstop?"
  }
}
```

#### es-02 (`estimate-slider`, lesson `pc-02`)
```json
{
  "prompt": "How much is the Booker Prize worth, in pounds?",
  "unit": "GBP",
  "min": 1000,
  "max": 200000,
  "step": 1000,
  "correctValue": 50000,
  "tolerance": { "full": 5000, "partial": 25000 },
  "explanation": {
    "correct": "The Booker Prize winner receives 50,000 pounds. Shortlisted authors also receive a smaller award, and the sales boost can be bigger than the cheque.",
    "incorrect": "The winner of the Booker Prize receives 50,000 pounds. The sales lift for the winner and even the shortlist often matters more than the money.",
    "sayThisLine": "The Booker winner gets fifty thousand pounds, but the sales boost is bigger."
  }
}
```

#### es-03 (`estimate-slider`, lesson `be-03`)
```json
{
  "prompt": "How many digits in a modern ISBN?",
  "unit": "digits",
  "min": 6,
  "max": 20,
  "step": 1,
  "correctValue": 13,
  "tolerance": { "full": 0, "partial": 2 },
  "explanation": {
    "correct": "Modern ISBNs have 13 digits (ISBN-13). Each edition and format of a book has its own ISBN, so a hardcover and a paperback differ.",
    "incorrect": "Modern ISBNs are 13 digits long. Older ISBN-10 numbers had 10. Each edition and format gets its own number.",
    "sayThisLine": "Which edition is that? The ISBN would tell us."
  }
}
```

### 2.11 `hotspot-tap`

#### ht-01 (`hotspot-tap`, lesson `be-02`)
```json
{
  "prompt": "Tap the spine.",
  "diagram": { "diagramId": "book-anatomy-diagram", "aspectRatio": 1.2, "alt": "A labelled-free diagram of a hardcover book standing upright, with a dust jacket, front cover on the left, spine in the middle and back cover on the right." },
  "hotspots": [
    { "id": "front", "label": "Front cover", "shape": { "kind": "rect", "x": 0.05, "y": 0.1, "w": 0.35, "h": 0.8 } },
    { "id": "spine", "label": "Spine", "shape": { "kind": "rect", "x": 0.42, "y": 0.1, "w": 0.16, "h": 0.8 } },
    { "id": "back", "label": "Back cover", "shape": { "kind": "rect", "x": 0.6, "y": 0.1, "w": 0.35, "h": 0.8 } }
  ],
  "correctHotspotIds": ["spine"],
  "explanation": {
    "correct": "The spine is the narrow edge that faces out on a shelf, usually carrying the title and author. It is how readers find a book in a stack.",
    "incorrect": "The spine is the narrow middle edge that faces outward on a shelf. The front and back covers are the wide faces on either side.",
    "sayThisLine": "I judge my shelf by the spines, honestly."
  }
}
```

#### ht-02 (`hotspot-tap`, lesson `gm-05`)
```json
{
  "prompt": "Where would a cross-genre book most likely be shelved?",
  "diagram": { "diagramId": "bookstore-floor-plan", "aspectRatio": 1.5, "alt": "A top-down bookstore floor plan with four areas: Fiction along the left wall, Mystery in the back, Science Fiction and Fantasy on the right, and Nonfiction near the front." },
  "hotspots": [
    { "id": "fiction", "label": "General fiction", "shape": { "kind": "rect", "x": 0.02, "y": 0.1, "w": 0.28, "h": 0.8 } },
    { "id": "mystery", "label": "Mystery", "shape": { "kind": "rect", "x": 0.35, "y": 0.05, "w": 0.3, "h": 0.25 } },
    { "id": "sff", "label": "Science fiction and fantasy", "shape": { "kind": "rect", "x": 0.7, "y": 0.1, "w": 0.28, "h": 0.8 } },
    { "id": "nonfiction", "label": "Nonfiction", "shape": { "kind": "rect", "x": 0.35, "y": 0.7, "w": 0.3, "h": 0.25 } }
  ],
  "correctHotspotIds": ["fiction"],
  "explanation": {
    "correct": "Books that blend genres are often shelved in general fiction when no single genre section fits, though a store may choose the section with the biggest audience.",
    "incorrect": "When a book mixes genres, stores often use general fiction, or pick the genre most likely to attract its readers. Shelving is a bookstore decision, not a rule.",
    "sayThisLine": "Where would you find it, fantasy or general fiction?"
  }
}
```

#### ht-03 (`hotspot-tap`, lesson `sc-06`)
```json
{
  "prompt": "Tap the climax on the story arc.",
  "diagram": { "diagramId": "story-structure-arc", "aspectRatio": 1.6, "alt": "A line chart of tension over time: it starts low, rises with small bumps, peaks near the right, then drops sharply to a low resolution." },
  "hotspots": [
    { "id": "setup", "label": "Setup", "shape": { "kind": "circle", "cx": 0.12, "cy": 0.8, "r": 0.1 } },
    { "id": "rising", "label": "Rising action", "shape": { "kind": "circle", "cx": 0.45, "cy": 0.5, "r": 0.1 } },
    { "id": "climax", "label": "Climax", "shape": { "kind": "circle", "cx": 0.75, "cy": 0.12, "r": 0.1 } },
    { "id": "resolution", "label": "Resolution", "shape": { "kind": "circle", "cx": 0.92, "cy": 0.75, "r": 0.08 } }
  ],
  "correctHotspotIds": ["climax"],
  "explanation": {
    "correct": "The climax is the highest-tension point, where the central conflict comes to a head. Everything before builds toward it and everything after settles the consequences.",
    "incorrect": "The climax sits at the peak of the tension line. Setup is the calm start, rising action is the build, and resolution is the fall-away at the end.",
    "sayThisLine": "The climax was where I couldn't put it down."
  }
}
```

## 3. Playbook terms (80)

Definition in plain English, then an example line in an enthusiast's voice (all Swoon'd-written). Terms map to concept ids in CDS section 11 where one exists.

| # | Term | Definition | Example line |
|---|---|---|---|
| 1 | TBR | To-be-read: books you plan to read, or the pile of them. | "My TBR is a tower and I keep buying more." |
| 2 | DNF | Did not finish; you quit a book. | "DNF at 40 percent, no regrets." |
| 3 | ARC | Advance reader copy, sent before publication. | "I got an ARC of her new one, don't tell anyone." |
| 4 | Reading slump | A stretch where nothing appeals. | "I'm in a slump, everything feels like homework." |
| 5 | Book hangover | Not being able to start a new book after a great one. | "Book hangover. I'm just staring at the cover." |
| 6 | Mood reader | Picks books by feeling, not schedule. | "I'm a mood reader, I can't plan my TBR." |
| 7 | Comfort read | A book you return to for warmth. | "It's my comfort read for rainy weeks." |
| 8 | Reread | Reading a book again. | "I reread it every autumn." |
| 9 | Auto-buy author | An author you buy without reading the description. | "She's an auto-buy for me." |
| 10 | Standalone | A book that is complete on its own. | "Thank goodness, it's a standalone." |
| 11 | Duology | A two-book series. | "It's a duology, so no long wait." |
| 12 | Doorstop | A very thick book. | "It's a doorstop but worth it." |
| 13 | Hardcover | Rigid-boarded book, often with a dust jacket. | "I own the hardcover, it's gorgeous." |
| 14 | Trade paperback | Larger soft-cover format. | "The trade paperback is the one I read on the train." |
| 15 | Mass-market paperback | Small, cheap paperback. | "I found a mass-market copy at a used bookshop." |
| 16 | Dust jacket | Removable paper cover on a hardcover. | "I take the dust jacket off to read." |
| 17 | Spine | The narrow edge facing out on a shelf. | "I organise my shelves by spine colour." |
| 18 | Colophon | Publication and production info page. | "There's a note about the typeface in the colophon." |
| 19 | Epigraph | A short quotation at the start of a book or chapter. | "The epigraph sets the mood." |
| 20 | Edition | A version of a book, such as a new cover or translation. | "Which edition did you get?" |
| 21 | Printing | One print run of an edition. | "First printing, so it's a little collectible." |
| 22 | ISBN | The number identifying an edition. | "Search the ISBN to get the right one." |
| 23 | Novella | A short novel, roughly 17,500 to 40,000 words. | "It's a novella, I finished it in an evening." |
| 24 | Omnibus | Several books in one volume. | "I got the omnibus of the first three." |
| 25 | Plot | What happens, in order. | "The plot's simple, the writing is what wins." |
| 26 | Theme | What the book is about underneath. | "The theme is grief, really." |
| 27 | Character arc | How a character changes. | "Her arc from timid to fierce is perfect." |
| 28 | Round vs flat character | A layered character vs a one-note one. | "The side characters felt flat." |
| 29 | Point of view (POV) | Whose perspective tells the story. | "Dual POV keeps it fresh." |
| 30 | Close third | Third person that stays inside one head. | "Close third, so we feel everything with her." |
| 31 | Omniscient narrator | A narrator who knows everything. | "The omniscient narrator gives the game away." |
| 32 | Unreliable narrator | A narrator you cannot fully trust. | "That narrator is so unreliable." |
| 33 | Dual timeline | Two time periods told in alternation. | "The dual timeline works, both halves are good." |
| 34 | Frame narrative | A story wrapped around another story. | "It's a frame story, someone finds a diary." |
| 35 | Nonlinear | Told out of chronological order. | "Nonlinear, so keep a mental map." |
| 36 | Worldbuilding | Creating a world's rules and culture. | "The worldbuilding is unreal." |
| 37 | Pacing | The speed of the story. | "The pacing dragged in the middle." |
| 38 | Cliffhanger | A chapter or book ending on unresolved tension. | "That chapter ended on a cliffhanger." |
| 39 | Page-turner | A book you cannot put down. | "Total page-turner, finished it in one day." |
| 40 | Show, don't tell | Convey through scene and action rather than explanation. | "It shows her fear, it never just says it." |
| 41 | Prose | The style of the sentences. | "The prose is gorgeous, I highlighted half of it." |
| 42 | Trope | A recurring setup readers seek out. | "Fake dating is my favourite trope." |
| 43 | Cliché | A trope worn out through lazy use. | "That twist is a cliché." |
| 44 | Enemies-to-lovers | Rivals fall in love. | "I'll read any enemies-to-lovers." |
| 45 | Slow burn | Attraction that builds gradually. | "It's such a slow burn, I was screaming." |
| 46 | HEA / HFN | Happily ever after / happy for now; the romance ending promise. | "It has an HEA, thank goodness." |
| 47 | Heat level | How explicit the romance content is. | "Check the heat level before you gift it." |
| 48 | Closed door / open door | Whether intimate scenes happen off or on the page. | "It's closed door, so cozy." |
| 49 | Romantasy | Romance and fantasy where the love story is central. | "Romantasy is all I read this summer." |
| 50 | Cozy fantasy | Low-stakes, comforting fantasy. | "Cozy fantasy for the win." |
| 51 | Grimdark | Bleak, morally grey fantasy. | "It's grimdark, so brace yourself." |
| 52 | Hard vs soft magic | Rules-based magic vs mysterious magic. | "Hard magic, with costs and rules." |
| 53 | Space opera | Large-scale adventure set in space. | "It's a sprawling space opera." |
| 54 | Cyberpunk | Near-future tech and corporate dystopia. | "Classic cyberpunk vibes." |
| 55 | Whodunit | A mystery about who committed the crime. | "A proper whodunit, with clues." |
| 56 | Red herring | A clue that misleads. | "That was a red herring, I fell for it." |
| 57 | Cozy mystery | Gentle mystery with little on-page violence. | "A cozy mystery with a cat." |
| 58 | Noir | Dark, cynical crime storytelling. | "It's pure noir." |
| 59 | Psychological thriller | Suspense driven by minds and secrets. | "The psychological thriller kept me up." |
| 60 | Memoir | A true story of the author's own life. | "The memoir wrecked me." |
| 61 | Narrative nonfiction | True stories told with novelistic craft. | "It reads like a novel but it's all true." |
| 62 | Self-help | Books promising personal improvement. | "I keep buying self-help and reading half." |
| 63 | Autofiction | Fiction built from the author's life. | "Autofiction, so it's hard to tell what's real." |
| 64 | Literary fiction | Fiction valuing style and depth over plot. | "It's very literary, so slower." |
| 65 | Commercial fiction | Fiction aimed at a broad audience. | "Commercial fiction, and unapologetically fun." |
| 66 | Young adult (YA) | Books for teens, read by all ages. | "YA can be devastating." |
| 67 | Middle grade | Books for roughly 8 to 12. | "My favourite middle grade holds up." |
| 68 | Comp titles | "X meets Y" comparison titles. | "It's Pride and Prejudice meets a heist." |
| 69 | Backlist | Older titles that keep selling. | "It's backlist, but everyone's talking about it now." |
| 70 | Frontlist | New releases. | "I only read frontlist when it's hyped." |
| 71 | Imprint | A publisher's brand label. | "That imprint has great taste." |
| 72 | Advance | Money paid to an author up front. | "Her advance was huge, apparently." |
| 73 | Longlist / shortlist | Successive cuts in a prize process. | "It made the longlist but not the shortlist." |
| 74 | Booker Prize | A leading UK-linked prize for a novel in English. | "The Booker shortlist is my summer reading." |
| 75 | Pulitzer Prize | A US prize in journalism and the arts, including fiction. | "It won the Pulitzer, so I'm nervous." |
| 76 | Hugo Award | A fan-voted prize for science fiction and fantasy. | "It's a Hugo winner." |
| 77 | BookTok | Book-focused TikTok community. | "I only bought it because of BookTok." |
| 78 | Buddy read | Reading the same book together. | "Let's do a buddy read." |
| 79 | Special edition | A collectible printing with extras. | "I bought the special edition for the edges." |
| 80 | Sprayed edges | Coloured page edges. | "The sprayed edges are so pretty." |

## 4. Talk Track scenarios (10 fully written)

Each: setting, her line, meaning, and three replies (good / meh / cringe) with coach notes. Delta values sit in the range -20 to +30. These become `talkTracks[]` payloads later.

### 4.1 What are you reading? (`tt-what-reading`, lesson `bt-01`)
- **Setting:** She is reading in a cafe.
- **She says:** "Sorry, I'm in the middle of a chapter, it's so good."
- **Meaning:** She is absorbed and happy; a genuine invitation to ask.
- **Good (+22):** "Don't apologise. What's it about?" Coach: warm, gives her the floor.
- **Meh (0):** "Oh, what is it?" Coach: fine; add a little warmth.
- **Cringe (-15):** "Isn't reading kind of slow?" Coach: dismissive; never mock reading speed.

### 4.2 Her favourite book (`tt-favorite-book`, lesson `bt-02`)
- **Setting:** First-date chat.
- **She says:** "If you make me pick a favourite book I will have a crisis."
- **Meaning:** She has many; she is joking about the impossible question.
- **Good (+22):** "Okay, top three then? Or the one you'd hand a stranger." Coach: lowers the pressure and stays curious.
- **Meh (+2):** "So what's the best one?" Coach: repeats the crisis.
- **Cringe (-12):** "I only read good books." Coach: snobbery.

### 4.3 Haven't read it (`tt-not-read`, lesson `bt-03`)
- **She says:** "You haven't read it?! Okay we're fixing that."
- **Meaning:** Playful; she wants to share.
- **Good (+25):** "Guilty. Where should I start, and what should I notice?" Coach: honest and curious.
- **Meh (+3):** "Maybe someday." Coach: polite but closes it.
- **Cringe (-15):** "I saw the movie, same thing." Coach: reveals you missed the point.

### 4.4 Different taste (`tt-different-taste`, lesson `bt-04`)
- **She says:** "You didn't like it?" (a little hurt)
- **Meaning:** She wants you to enjoy what she loves.
- **Good (+24):** "The middle wasn't for me, but I see why you love it. What got you?" Coach: honest, kind, specific.
- **Meh (0):** "It was okay." Coach: vague.
- **Cringe (-18):** "It's objectively bad." Coach: no one wins that argument.

### 4.5 The DNF (`tt-the-dnf`, lesson `dc-01`)
- **She says:** "I gave up on the book everyone loves. Am I broken?"
- **Meaning:** She wants reassurance.
- **Good (+25):** "Not broken. What lost you? I'm curious." Coach: validates and asks.
- **Meh (+5):** "You should try again later." Coach: pushy.
- **Cringe (-15):** "You have to finish it." Coach: ignores her call.

### 4.6 Book club night (`tt-book-club`, lesson `bt-05`)
- **She says:** "We're doing my pick tonight. Please be nice about it."
- **Meaning:** She is nervous; the book matters to her.
- **Good (+22):** "Always. Any question you want me to try to answer?" Coach: supportive and engaged.
- **Meh (+2):** "It'll be fine." Coach: vague.
- **Cringe (-12):** "I skimmed the Wikipedia page." Coach: skimming is honest but tell her warmly.

### 4.7 The adaptation (`tt-adaptation`, lesson `sa-03`)
- **She says:** "They changed the ending. Ugh."
- **Meaning:** She is disappointed.
- **Good (+22):** "What was the ending in the book? I'd love to hear." Coach: lets her share.
- **Meh (+2):** "Adaptations always change things." Coach: true but flat.
- **Cringe (-15):** "Better than the book." Coach: dismissive.

### 4.8 The gift (`tt-the-gift`, lesson `bt-07`)
- **She says:** "You bought me a book?" (she opens it)
- **Meaning:** Surprised; the pick reveals whether you noticed her taste.
- **Good (+25):** "I asked a bookseller what fans of your favourites love. Hope it's a fit; receipt's inside." Coach: thoughtful and low-pressure.
- **Meh (+3):** "It was on sale." Coach: undersells it.
- **Cringe (-15):** "It's the one everyone is reading." Coach: not personal.

### 4.9 The audiobook question (`tt-audiobook`, lesson `dc-02`)
- **She says:** "I mostly listen to books on my commute."
- **Meaning:** She reads by audio.
- **Good (+22):** "Nice. What's the best narrator you've heard?" Coach: audiobooks count, and narrators matter.
- **Meh (0):** "Does that count as reading?" Coach: reopens a tired debate.
- **Cringe (-18):** "That's cheating." Coach: judgmental.

### 4.10 The long wait (`tt-long-wait`, lesson `sa-02`)
- **She says:** "The next one isn't out until 2028. I might die."
- **Meaning:** Playful series grief.
- **Good (+22):** "Do you reread the earlier ones while you wait?" Coach: shows you get the ritual.
- **Meh (+2):** "That's a long time." Coach: agreeable but flat.
- **Cringe (-12):** "Why not read something else?" Coach: misses the point.

## 5. Talk Track roster at launch (20)
`tt-what-reading`, `tt-favorite-book`, `tt-not-read`, `tt-different-taste`, `tt-the-dnf`, `tt-book-club`, `tt-adaptation`, `tt-the-gift`, `tt-audiobook`, `tt-long-wait`, `tt-bookstore-date`, `tt-tbr-tower`, `tt-reread-comfort`, `tt-spoiler-oops`, `tt-prize-shortlist`, `tt-romance-respect`, `tt-classic-nerves`, `tt-cover-debate`, `tt-buddy-read`, `tt-library-holds`. Ten more (30 total) at 0.2: genre branch tracks, nonfiction and classics tracks.

## 6. Asset needs (all `original-swoond`)
- ~40 vector illustrations: formats (hardcover, trade, mass-market, ebook reader), edges and bindings, genre-convention stand-ins (type-only, no real titles or artwork), library card, book club circle.
- 5 procedural diagrams: `book-anatomy-diagram`, `bookstore-floor-plan`, `story-structure-arc`, `dual-timeline-diagram`, `pov-camera-diagram`.
- No audio.
- Original teaching passages (short, Swoon'd-authored) for POV, tense and unreliable-narrator items; registered as `original-swoond` text.
- Bundle path convention: `books/technique/`, `books/diagrams/`.

## 7. Voice and safety notes
- Voice: cheeky coach; warm; never mocks a genre, a taste or a reading speed; never about the crush; one joke per screen.
- Never grade an opinion about a book. Correct answers exist only for vocabulary, distinctions and etiquette.
- Sexual-content items stay at label level (heat level, closed/open door) with no explicit text.
- Nothing here quotes a real book; all example lines are Swoon'd-written.
