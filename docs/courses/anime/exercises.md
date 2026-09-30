# Native Exercise Plan: Anime (`anime`)

Tier B plan for `docs/courses/anime/`. The course uses 12 of the 13 native exercise types; there are no Unity sims (CDS section 12). All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with ajv when this file was generated: 36 of 36 pass). Conventions: prompts <= 12 words; every answer explained; `license` ids are `original-swoond`; every image and audio asset is original (spec section 40: no stills, key art, OP/ED audio, lyrics or voice clips). Title names appear as text only. Time-sensitive items (season lineups, streaming catalogues, convention attendance) are live-layer content, not hard-coded in evergreen lessons.

## 1. Plan summary

| Type | How it is used | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite card; definitions, which-is-true, distractors from the classic beginner mistakes in CDS section 2. | ~260 |
| `binary-call` | Two-way calls on text situations: canon vs filler, simulcast or not, sub or dub release. Scene kind is `none`; the situation is in the prompt and alt text. No diagram is needed. | ~30 |
| `term-match` | Introduce 3 to 6 related terms at the start of a unit and in Term Blitz reviews. Definitions plain and short. | ~45 |
| `sequence-order` | Production pipeline, season calendar, eras of anime. Order is the concept; per-step `why` carries logic. | ~30 |
| `visual-id` | Original Swoon'd illustrations of visual shorthand (sparkle backgrounds, chibi, smear frames, speed lines). Never stills or key art (spec section 40). | ~40 |
| `decision-scenario` | Judgment: what to pick for a shared watch, how to respond to piracy links, cosplay and convention etiquette, mature-theme conversations. Facts table plus consequences; `expertNote` always present. | ~45 |
| `talk-track` | Conversation practice: 24 tracks (one per unit end, plus the Conversation Lab and Talk tab). Replies reward curiosity over expertise; smoothDelta clamped to -20..+N by contract. | ~24 |
| `say-this` | Decode what she just said: fandom slang, recap messages, adaptation complaints, season chatter. Each item has honest follow-up lines. | ~90 |
| `fill-the-gap` | Vocabulary in context and the rules of thumb (cour, canon, honorifics). | ~55 |
| `listening-id` | Original recorded or synthesised audio only: honorific pronunciation and score mood cues. Never OP/ED, soundtrack or voice clips from a show. Skip button and text twin always present. | ~14 |
| `estimate-slider` | Magnitudes: cour length, drawings per second, seasons per year, volume counts, convention attendance (as dated news, not hard-coded). | ~14 |
| `hotspot-tap` | Static original diagrams: manga page order, season chart card, credits roll, studio pipeline. Diagram ids are procedural. | ~30 |
| `timing-tap` | **Not used.** No 1D timing concept in anime talk; a fake rhythm game would be worse than clear text (tier rubric). | 0 |

Estimated total: about 677 native items across 120 lessons and the review loop. Cross-type rules: each lesson ends with one item carrying a say-this line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`. Mature-theme items (lessons `gt-08`, `cr-06`, `sp-04`) are non-graphic and carry a content-note line.

## 2. Sample items by type

### 2.1 `multiple-choice`

Default knowledge check and Daily Bite card; definitions, which-is-true, distractors from the classic beginner mistakes in CDS section 2.

**Sample 1** (lesson `wa-01`)

```json
{
  "prompt": "Which statement about anime is most accurate?",
  "options": [
    {
      "id": "a",
      "text": "It is one genre for kids"
    },
    {
      "id": "b",
      "text": "It is a medium covering every genre"
    },
    {
      "id": "c",
      "text": "It is a Japanese-only art style"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Anime is a medium. Romance, sports, horror, cooking and sci-fi all live inside it, for every age band.",
    "incorrect": "Anime is not one genre or one audience. Think of it like \"live action\": a way of making things, not a kind of story.",
    "sayThisLine": "So what kind of anime is she into?"
  }
}
```

**Sample 2** (lesson `wa-03`)

```json
{
  "prompt": "How long is one cour, roughly?",
  "options": [
    {
      "id": "a",
      "text": "4 episodes"
    },
    {
      "id": "b",
      "text": "12 to 13 episodes"
    },
    {
      "id": "c",
      "text": "26 episodes"
    },
    {
      "id": "d",
      "text": "52 episodes"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "A cour is one broadcast season, about 12 to 13 weekly episodes. Two cours make a 24 to 26 episode run.",
    "incorrect": "A cour is one broadcast quarter of the year, so around 12 or 13 weekly episodes."
  }
}
```

**Sample 3** (lesson `dm-04`)

```json
{
  "prompt": "What does seinen usually aim at?",
  "options": [
    {
      "id": "a",
      "text": "Young children"
    },
    {
      "id": "b",
      "text": "Teen girls"
    },
    {
      "id": "c",
      "text": "Adult men"
    },
    {
      "id": "d",
      "text": "Adult readers with grown-up themes"
    }
  ],
  "correctOptionIds": [
    "d"
  ],
  "explanation": {
    "correct": "Seinen targets adult readers and often leans into moral grey, slower pacing and realism. Labels began as magazine marketing, not rules.",
    "incorrect": "Seinen originally meant \"young men\" in magazine marketing; today it signals adult-leaning tone. Shojo targets teen girls, kodomo targets children.",
    "sayThisLine": "Is that one seinen, or does it just feel grown-up?"
  }
}
```

### 2.2 `binary-call`

Two-way calls on text situations: canon vs filler, simulcast or not, sub or dub release. Scene kind is `none`; the situation is in the prompt and alt text. No diagram is needed.

**Sample 1** (lesson `fv-03`)

```json
{
  "prompt": "An episode that adapts a chapter from the manga. Canon?",
  "scene": {
    "kind": "none",
    "alt": "Episode 14 adapts manga chapters 61 to 63, scene for scene."
  },
  "choices": [
    {
      "id": "canon",
      "label": "Canon"
    },
    {
      "id": "filler",
      "label": "Filler"
    }
  ],
  "correctChoiceId": "canon",
  "explanation": {
    "correct": "It follows the source story, so fans call it canon.",
    "incorrect": "Filler means anime-original material not in the source. This episode follows the manga closely."
  },
  "ruleTag": "Canon vs filler"
}
```

**Sample 2** (lesson `fv-03`)

```json
{
  "prompt": "A beach episode the manga never had. Canon?",
  "scene": {
    "kind": "none",
    "alt": "Episode 9 is a beach day. The manga jumps straight from chapter 40 to chapter 41."
  },
  "choices": [
    {
      "id": "canon",
      "label": "Canon"
    },
    {
      "id": "filler",
      "label": "Filler"
    }
  ],
  "correctChoiceId": "filler",
  "explanation": {
    "correct": "Anime-original episodes that pad the gap are filler. Some are loved anyway.",
    "incorrect": "The source has no such chapter, so it is filler (or anime-original content). Fans may still adore it."
  },
  "ruleTag": "Canon vs filler"
}
```

**Sample 3** (lesson `ss-02`)

```json
{
  "prompt": "A show airs in Japan Saturday, streams here Saturday. Simulcast?",
  "scene": {
    "kind": "none",
    "alt": "Airs in Japan Saturday night. Streams in your country within hours, subtitled."
  },
  "choices": [
    {
      "id": "yes",
      "label": "Simulcast"
    },
    {
      "id": "no",
      "label": "Not simulcast"
    }
  ],
  "correctChoiceId": "yes",
  "explanation": {
    "correct": "Near-same-time release is what simulcast means.",
    "incorrect": "Simulcast means the series arrives abroad at roughly the same time as Japan. This one does."
  },
  "ruleTag": "Simulcast"
}
```

### 2.3 `term-match`

Introduce 3 to 6 related terms at the start of a unit and in Term Blitz reviews. Definitions plain and short.

**Sample 1** (lesson `dm-01`)

```json
{
  "prompt": "Match the shelf to its target reader.",
  "pairs": [
    {
      "id": "shonen",
      "term": "Shonen",
      "definition": "Aimed at teen boys"
    },
    {
      "id": "shojo",
      "term": "Shojo",
      "definition": "Aimed at teen girls"
    },
    {
      "id": "seinen",
      "term": "Seinen",
      "definition": "Aimed at adult men"
    },
    {
      "id": "josei",
      "term": "Josei",
      "definition": "Aimed at adult women"
    }
  ],
  "explanation": {
    "summary": "Four labels that began as magazine marketing. Real audiences cross every line."
  }
}
```

**Sample 2** (lesson `gt-02`)

```json
{
  "prompt": "Match the isekai type to its setup.",
  "pairs": [
    {
      "id": "reinc",
      "term": "Reincarnation",
      "definition": "Dies, then is reborn in a new world"
    },
    {
      "id": "trans",
      "term": "Transportation",
      "definition": "Summoned or pulled there alive"
    },
    {
      "id": "game",
      "term": "Trapped in a game",
      "definition": "Stuck inside a game world"
    }
  ],
  "explanation": {
    "summary": "Same fantasy of a fresh start, three different doors in."
  }
}
```

**Sample 3** (lesson `hm-02`)

```json
{
  "prompt": "Match who does what.",
  "pairs": [
    {
      "id": "studio",
      "term": "Animation studio",
      "definition": "Draws and produces the show"
    },
    {
      "id": "pub",
      "term": "Publisher",
      "definition": "Owns and prints the source manga"
    },
    {
      "id": "dist",
      "term": "Distributor",
      "definition": "Streams or releases it in your region"
    }
  ],
  "explanation": {
    "summary": "Three different jobs. A fan loyal to a studio is not necessarily loyal to a streamer."
  }
}
```

### 2.4 `sequence-order`

Production pipeline, season calendar, eras of anime. Order is the concept; per-step `why` carries logic.

**Sample 1** (lesson `hm-03`)

```json
{
  "prompt": "Order the anime production steps.",
  "items": [
    {
      "id": "plan",
      "text": "Story and script planning",
      "why": "Nothing is drawn until the story plan exists."
    },
    {
      "id": "board",
      "text": "Storyboard (ekonte)",
      "why": "The storyboard is the blueprint for every shot."
    },
    {
      "id": "key",
      "text": "Key animation",
      "why": "Key animators draw the important poses."
    },
    {
      "id": "between",
      "text": "In-betweening",
      "why": "Fills the frames between the key poses."
    },
    {
      "id": "final",
      "text": "Compositing and finishing",
      "why": "Colour, light and effects come last."
    }
  ],
  "explanation": {
    "correct": "Plan, board, key poses, fill-in frames, finish.",
    "incorrect": "Start with the plan and board, then key poses, then in-betweens, and compositing last."
  }
}
```

**Sample 2** (lesson `ss-01`)

```json
{
  "prompt": "Order the anime seasons, starting in January.",
  "items": [
    {
      "id": "w",
      "text": "Winter (January)"
    },
    {
      "id": "s",
      "text": "Spring (April)"
    },
    {
      "id": "su",
      "text": "Summer (July)"
    },
    {
      "id": "f",
      "text": "Fall (October)"
    }
  ],
  "explanation": {
    "correct": "Four seasons a year, each starting near the first month of a quarter.",
    "incorrect": "January, April, July, October: Winter, Spring, Summer, Fall."
  }
}
```

**Sample 3** (lesson `hi-05`)

```json
{
  "prompt": "Order these eras, oldest first.",
  "items": [
    {
      "id": "tv",
      "text": "Early TV anime",
      "why": "Begins in the 1960s."
    },
    {
      "id": "ova",
      "text": "Home-video OVA boom",
      "why": "1980s."
    },
    {
      "id": "late",
      "text": "Late-night anime",
      "why": "1990s growth."
    },
    {
      "id": "stream",
      "text": "Global streaming boom",
      "why": "2010s onward."
    }
  ],
  "explanation": {
    "correct": "TV, home video, late night, streaming.",
    "incorrect": "Each era grew from the distribution channel before it."
  }
}
```

### 2.5 `visual-id`

Original Swoon'd illustrations of visual shorthand (sparkle backgrounds, chibi, smear frames, speed lines). Never stills or key art (spec section 40).

**Sample 1** (lesson `dm-03`)

```json
{
  "prompt": "Which visual shorthand is this?",
  "image": {
    "asset": "images/anime/shorthand-sparkle-flowers.svg",
    "alt": "Original line drawing of a blank face surrounded by flowers and sparkles in the background.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Sparkle-and-flower background"
    },
    {
      "id": "b",
      "text": "Speed lines"
    },
    {
      "id": "c",
      "text": "Sweat drop"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Flowers and sparkles signal a character feeling romantic or radiant. It is classic shojo visual language.",
    "incorrect": "Speed lines show fast motion. A sweat drop shows embarrassment. Flowers and sparkles are the shojo shorthand for feeling."
  },
  "cues": [
    "Flowers behind the figure",
    "Soft sparkles"
  ]
}
```

**Sample 2** (lesson `hm-05`)

```json
{
  "prompt": "Which drawing shows a sakuga moment?",
  "image": {
    "asset": "images/anime/sakuga-smear-arc.svg",
    "alt": "Original diagram of a swinging arm with smear frames and a bright impact flash.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Static talking head"
    },
    {
      "id": "b",
      "text": "Fluid smear-frame action"
    },
    {
      "id": "c",
      "text": "Still background painting"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "Smeared, fluid, expressive motion is what sakuga fans celebrate.",
    "incorrect": "A static shot saves drawings. Sakuga is when animators spend extra drawings on spectacular motion."
  },
  "cues": [
    "Smear frames",
    "Impact flash"
  ]
}
```

**Sample 3** (lesson `wa-06`)

```json
{
  "prompt": "Which drawing is a chibi (SD) reaction?",
  "image": {
    "asset": "images/anime/chibi-reaction.svg",
    "alt": "Original drawing of a tiny round-headed figure with big dot eyes.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Chibi reaction"
    },
    {
      "id": "b",
      "text": "Realistic portrait"
    },
    {
      "id": "c",
      "text": "Silhouette"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Chibi, or super-deformed, shrinks a character for comic effect.",
    "incorrect": "A realistic portrait keeps normal proportions; the tiny round-headed figure is the chibi gag."
  },
  "cues": [
    "Tiny body",
    "Oversized head"
  ]
}
```

### 2.6 `decision-scenario`

Judgment: what to pick for a shared watch, how to respond to piracy links, cosplay and convention etiquette, mature-theme conversations. Facts table plus consequences; `expertNote` always present.

**Sample 1** (lesson `wa-07`)

```json
{
  "prompt": "First shared watch. What do you pick?",
  "situation": {
    "narrative": "She offered to watch something together tonight. You do not know her comfort zone.",
    "facts": [
      {
        "label": "Her taste",
        "value": "Loves cozy and funny shows"
      },
      {
        "label": "Your experience",
        "value": "None"
      },
      {
        "label": "Available time",
        "value": "One evening"
      },
      {
        "label": "Content rating",
        "value": "Check before pressing play"
      }
    ]
  },
  "options": [
    {
      "id": "ask",
      "label": "Ask her to pick a favorite",
      "verdict": "best",
      "consequence": "She lights up and you get to see why she loves it.",
      "considerations": [
        "Shows real interest",
        "Low risk"
      ]
    },
    {
      "id": "mature",
      "label": "Pick the most acclaimed dark series",
      "verdict": "poor",
      "consequence": "It may be heavy for a first evening together.",
      "considerations": [
        "Ratings exist for a reason",
        "Acclaimed does not mean easy"
      ]
    },
    {
      "id": "movie",
      "label": "Suggest a gentle well-known film",
      "verdict": "acceptable",
      "consequence": "Safe, but you skip learning her taste.",
      "considerations": [
        "Short commitment",
        "Less personal"
      ]
    }
  ],
  "expertNote": "Ratings and content notes are your friend; they change by region."
}
```

**Sample 2** (lesson `fv-05`)

```json
{
  "prompt": "A friend shares a pirate link. What do you say?",
  "situation": {
    "narrative": "Your friend offers a free site that hosts an unlicensed episode.",
    "facts": [
      {
        "label": "Official option",
        "value": "Available on a legal service"
      },
      {
        "label": "Who is hurt",
        "value": "The people who made it",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "legal",
      "label": "Thanks, I will use the official one",
      "verdict": "best",
      "consequence": "Friendly and firm. Nobody feels judged.",
      "considerations": [
        "Supports creators",
        "No lecture"
      ]
    },
    {
      "id": "lecture",
      "label": "Give a long speech about piracy",
      "verdict": "poor",
      "consequence": "Now the watch party is awkward.",
      "considerations": [
        "Tone matters"
      ]
    },
    {
      "id": "click",
      "label": "Click it once",
      "verdict": "poor",
      "consequence": "Swoon'd never points you to unlicensed sources.",
      "considerations": [
        "Safety risks too"
      ]
    }
  ],
  "expertNote": "Official releases fund the studios and artists. Sharing the legal option is the friendliest flex."
}
```

**Sample 3** (lesson `cc-02`)

```json
{
  "prompt": "You love a stranger's cosplay. What now?",
  "situation": {
    "narrative": "At a convention you see a cosplay that looks amazing.",
    "facts": [
      {
        "label": "Golden rule",
        "value": "A costume is not consent"
      },
      {
        "label": "Setting",
        "value": "Crowded convention hall"
      }
    ]
  },
  "options": [
    {
      "id": "ask",
      "label": "Compliment, then ask before a photo",
      "verdict": "best",
      "consequence": "They usually smile and pose.",
      "considerations": [
        "Always ask first"
      ]
    },
    {
      "id": "snap",
      "label": "Take a photo without asking",
      "verdict": "poor",
      "consequence": "That is rude and sometimes unsafe for the wearer.",
      "considerations": [
        "Consent"
      ]
    },
    {
      "id": "touch",
      "label": "Touch the prop or costume",
      "verdict": "poor",
      "consequence": "Props are fragile and personal space matters.",
      "considerations": [
        "Do not touch without asking"
      ]
    }
  ],
  "expertNote": "Conventions publish cosplay-consent rules; \"cosplay is not consent\" is the community slogan."
}
```

### 2.7 `talk-track`

Conversation practice: 24 tracks (one per unit end, plus the Conversation Lab and Talk tab). Replies reward curiosity over expertise; smoothDelta clamped to -20..+N by contract.

**Sample 1** (lesson `cl-01`)

```json
{
  "title": "Her favorite series",
  "setting": "She texts you about a series she is rewatching.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Rewatching my comfort anime again. Episode 3 gets me every time.",
      "replies": [
        {
          "id": "a",
          "text": "What makes episode 3 the one for you?",
          "smoothDelta": 30,
          "theirResponse": "The quiet scene at the end, it is so gentle.",
          "coachNote": "Open question. Curiosity, no fake expertise."
        },
        {
          "id": "b",
          "text": "Anime is all the same, right?",
          "smoothDelta": -20,
          "theirResponse": "...Not really.",
          "coachNote": "Dismissive. Anime is a medium, not one genre."
        },
        {
          "id": "c",
          "text": "I loved that one too!",
          "smoothDelta": -20,
          "theirResponse": "Wait, which part?",
          "coachNote": "Do not pretend you have seen it."
        }
      ]
    }
  ],
  "closingNote": "Ask what she loves about it. That is enough."
}
```

**Sample 2** (lesson `cl-02`)

```json
{
  "title": "Sub or dub",
  "setting": "You are choosing how to watch together.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Sub or dub tonight? I kind of always watch sub.",
      "replies": [
        {
          "id": "a",
          "text": "Sub sounds good. What do you like about it?",
          "smoothDelta": 25,
          "theirResponse": "The original voices feel right to me.",
          "coachNote": "You agree and stay curious."
        },
        {
          "id": "b",
          "text": "Dubs are for babies.",
          "smoothDelta": -20,
          "theirResponse": "Wow, okay.",
          "coachNote": "Never mean. Many fans love dubs."
        },
        {
          "id": "c",
          "text": "Whatever you like, I am easy.",
          "smoothDelta": 5,
          "theirResponse": "Sub then!",
          "coachNote": "Fine, but a question is better."
        }
      ]
    }
  ],
  "closingNote": "Sub and dub are both valid. Personal preference wins."
}
```

**Sample 3** (lesson `cl-05`)

```json
{
  "title": "Adaptation letdown",
  "setting": "She is upset about an adaptation of her favorite manga.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They cut my favorite arc. I am so annoyed.",
      "replies": [
        {
          "id": "a",
          "text": "That sounds frustrating. What did the arc mean to you?",
          "smoothDelta": 30,
          "theirResponse": "It is where the characters really grew.",
          "coachNote": "Support first, ask second."
        },
        {
          "id": "b",
          "text": "It is only a show, relax.",
          "smoothDelta": -20,
          "theirResponse": "It is not only a show to me.",
          "coachNote": "Do not dismiss feelings."
        },
        {
          "id": "c",
          "text": "Adaptations always ruin things.",
          "smoothDelta": -10,
          "theirResponse": "Not always...",
          "coachNote": "Too absolute."
        }
      ]
    }
  ],
  "closingNote": "Listen to what the source meant to her."
}
```

### 2.8 `say-this`

Decode what she just said: fandom slang, recap messages, adaptation complaints, season chatter. Each item has honest follow-up lines.

**Sample 1** (lesson `ma-05`)

```json
{
  "statement": {
    "speaker": "Mia",
    "text": "The anime caught up to the manga, so now it is going anime-original."
  },
  "question": "What is she saying?",
  "options": [
    {
      "id": "a",
      "text": "The anime has no more source to adapt",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The manga was cancelled",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "The show is dubbed now",
      "isCorrect": false
    }
  ],
  "translation": "The anime ran out of manga to follow, so it is inventing its own story.",
  "followUps": [
    {
      "line": "Do you think the ending will match the manga?",
      "why": "Shows you know anime-original endings exist."
    }
  ]
}
```

**Sample 2** (lesson `ss-06`)

```json
{
  "statement": {
    "speaker": "Mia",
    "text": "Season 2 is delayed a year. Production committee drama probably."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "The next season is postponed",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The show is cancelled for good",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "She dislikes the committee",
      "isCorrect": false
    }
  ],
  "translation": "The next season got pushed back, maybe for production or scheduling reasons.",
  "followUps": [
    {
      "line": "Did they say why?",
      "why": "Curiosity without assuming."
    }
  ]
}
```

**Sample 3** (lesson `fv-02`)

```json
{
  "statement": {
    "speaker": "Mia",
    "text": "I never skip the OP for this one. It is peak."
  },
  "question": "What is she saying?",
  "options": [
    {
      "id": "a",
      "text": "She watches the opening every time because she loves it",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "She hates the show",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "The opening was removed",
      "isCorrect": false
    }
  ],
  "translation": "She likes the opening theme so much she never skips it. \"Peak\" means excellent.",
  "followUps": [
    {
      "line": "What is it about that opening?",
      "why": "Invites her to share."
    }
  ]
}
```

### 2.9 `fill-the-gap`

Vocabulary in context and the rules of thumb (cour, canon, honorifics).

**Sample 1** (lesson `fv-03`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "An episode that is {{a}} adds story the manga did not have.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "canon",
        "filler",
        "a recap"
      ],
      "correct": "filler"
    }
  ],
  "explanation": {
    "correct": "Filler is anime-original content that pads the schedule.",
    "incorrect": "Canon follows the source. A recap repeats earlier events."
  }
}
```

**Sample 2** (lesson `wa-03`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "One {{a}} is about {{b}} weekly episodes.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "cour",
        "arc"
      ],
      "correct": "cour"
    },
    {
      "id": "b",
      "options": [
        "12",
        "52"
      ],
      "correct": "12"
    }
  ],
  "explanation": {
    "correct": "A cour is one broadcast season, roughly 12 episodes.",
    "incorrect": "An arc is a story chunk, not a schedule unit. A cour is about 12 to 13 episodes."
  }
}
```

**Sample 3** (lesson `fv-06`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "The honorific {{a}} is used for a {{b}}.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "-sensei",
        "-kun"
      ],
      "correct": "-sensei"
    },
    {
      "id": "b",
      "options": [
        "teacher",
        "classmate"
      ],
      "correct": "teacher"
    }
  ],
  "explanation": {
    "correct": "-sensei marks a teacher or expert.",
    "incorrect": "-kun is casual, often for boys or juniors."
  }
}
```

### 2.10 `listening-id`

Original recorded or synthesised audio only: honorific pronunciation and score mood cues. Never OP/ED, soundtrack or voice clips from a show. Skip button and text twin always present.

**Sample 1** (lesson `fv-06`)

```json
{
  "prompt": "Which honorific do you hear?",
  "audio": {
    "asset": "audio/honorifics/sensei.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A studio-recorded voice saying a name followed by a three-syllable honorific.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "-sensei"
    },
    {
      "id": "b",
      "text": "-senpai"
    },
    {
      "id": "c",
      "text": "-chan"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Sensei has the \"sen-sei\" ending for teacher.",
    "incorrect": "Senpai has a \"pai\" ending. Chan ends in a short \"chan\". Listen to the last syllables."
  },
  "listenFor": [
    "Final syllables"
  ]
}
```

**Sample 2** (lesson `fv-06`)

```json
{
  "prompt": "Which honorific do you hear?",
  "audio": {
    "asset": "audio/honorifics/senpai.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A studio-recorded voice saying a name followed by a three-syllable honorific.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "-sensei"
    },
    {
      "id": "b",
      "text": "-senpai"
    },
    {
      "id": "c",
      "text": "-kun"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "Senpai is for someone ahead of you in school or work.",
    "incorrect": "Senpai ends with \"pai\". Sensei ends with \"sei\"."
  },
  "listenFor": [
    "Stress on \"pai\""
  ]
}
```

**Sample 3** (lesson `cr-04`)

```json
{
  "prompt": "Which is a synthesised battle cue?",
  "audio": {
    "asset": "audio/score/original-battle-cue.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "An original synthesised fast, percussive cue with rising strings.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Battle cue"
    },
    {
      "id": "b",
      "text": "Cozy slice-of-life cue"
    },
    {
      "id": "c",
      "text": "Quiet mystery cue"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Fast percussion and rising tension signal a fight.",
    "incorrect": "Slice-of-life cues are gentle. Mystery cues are sparse."
  },
  "listenFor": [
    "Tempo",
    "Percussion"
  ]
}
```

### 2.11 `estimate-slider`

Magnitudes: cour length, drawings per second, seasons per year, volume counts, convention attendance (as dated news, not hard-coded).

**Sample 1** (lesson `wa-03`)

```json
{
  "prompt": "Episodes in a typical one-cour series?",
  "unit": "episodes",
  "min": 4,
  "max": 52,
  "step": 1,
  "correctValue": 12,
  "tolerance": {
    "full": 1,
    "partial": 4
  },
  "explanation": {
    "correct": "About 12 to 13 weekly episodes.",
    "incorrect": "A cour is roughly 12 to 13 episodes."
  }
}
```

**Sample 2** (lesson `hm-03`)

```json
{
  "prompt": "Typical TV anime: drawings per second of motion on twos?",
  "unit": "drawings/sec",
  "min": 4,
  "max": 24,
  "step": 1,
  "correctValue": 12,
  "tolerance": {
    "full": 1,
    "partial": 4
  },
  "explanation": {
    "correct": "Animating on twos means 12 drawings per second.",
    "incorrect": "Film runs at 24 frames per second; on twos, each drawing is held for two frames, giving 12."
  }
}
```

**Sample 3** (lesson `ss-01`)

```json
{
  "prompt": "How many anime seasons per year?",
  "unit": "seasons",
  "min": 1,
  "max": 8,
  "step": 1,
  "correctValue": 4,
  "tolerance": {
    "full": 0,
    "partial": 1
  },
  "explanation": {
    "correct": "Four: winter, spring, summer, fall.",
    "incorrect": "Seasons start every three months, so four a year."
  }
}
```

### 2.12 `hotspot-tap`

Static original diagrams: manga page order, season chart card, credits roll, studio pipeline. Diagram ids are procedural.

**Sample 1** (lesson `ma-01`)

```json
{
  "prompt": "Tap where you start reading a manga page.",
  "diagram": {
    "diagramId": "manga-page-rtl",
    "aspectRatio": 1.3,
    "alt": "Original diagram of a manga page with four numbered panels."
  },
  "hotspots": [
    {
      "id": "tr",
      "label": "Top right panel",
      "shape": {
        "kind": "circle",
        "cx": 0.75,
        "cy": 0.25,
        "r": 0.08
      }
    },
    {
      "id": "tl",
      "label": "Top left panel",
      "shape": {
        "kind": "circle",
        "cx": 0.25,
        "cy": 0.25,
        "r": 0.08
      }
    },
    {
      "id": "bl",
      "label": "Bottom left panel",
      "shape": {
        "kind": "circle",
        "cx": 0.25,
        "cy": 0.75,
        "r": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "tr"
  ],
  "explanation": {
    "correct": "Traditional manga reads right to left, so the top right panel is first.",
    "incorrect": "Manga is read right to left. Start at the top right."
  }
}
```

**Sample 2** (lesson `ss-03`)

```json
{
  "prompt": "Tap the sequel badge on the season chart.",
  "diagram": {
    "diagramId": "season-chart-card",
    "aspectRatio": 1.3,
    "alt": "Original season chart card with a title, a service badge and a sequel badge."
  },
  "hotspots": [
    {
      "id": "seq",
      "label": "Sequel badge",
      "shape": {
        "kind": "circle",
        "cx": 0.8,
        "cy": 0.2,
        "r": 0.08
      }
    },
    {
      "id": "svc",
      "label": "Service badge",
      "shape": {
        "kind": "circle",
        "cx": 0.8,
        "cy": 0.6,
        "r": 0.08
      }
    },
    {
      "id": "title",
      "label": "Title",
      "shape": {
        "kind": "circle",
        "cx": 0.3,
        "cy": 0.3,
        "r": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "seq"
  ],
  "explanation": {
    "correct": "The sequel badge tells you it is a returning series.",
    "incorrect": "The service badge tells you where to watch; the sequel badge marks a returning series."
  }
}
```

**Sample 3** (lesson `st-01`)

```json
{
  "prompt": "Tap the credit that names the director.",
  "diagram": {
    "diagramId": "credits-roll-card",
    "aspectRatio": 1.3,
    "alt": "Original credits roll card listing roles with names."
  },
  "hotspots": [
    {
      "id": "dir",
      "label": "Director",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.2,
        "r": 0.08
      }
    },
    {
      "id": "ad",
      "label": "Animation director",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.08
      }
    },
    {
      "id": "comp",
      "label": "Composer",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.8,
        "r": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "dir"
  ],
  "explanation": {
    "correct": "The director leads the overall vision of the series.",
    "incorrect": "The animation director supervises drawings. The director runs the whole creative vision."
  }
}
```

## 3. Playbook terms (76)

Definition plus an example line in the enthusiast's voice. Each becomes a concept card; definitions are Swoon'd's own words.

| # | Term | Definition | Example line |
|---|---|---|---|
| 1 | Anime | Animation made in or in the style of Japan's industry, across every genre. | "Anime isn't a genre, it's a whole shelf of genres." |
| 2 | Manga | Japanese comics, usually read right to left and serialised in magazines or apps. | "The manga goes way deeper than the show." |
| 3 | Light novel | Short illustrated novels aimed at teens, a common source for anime. | "It started as a light novel, then got the anime." |
| 4 | Original anime | A series not adapted from manga or novels. | "It's an original, so nobody knows the ending." |
| 5 | Cour | One broadcast season, about 12 to 13 episodes. | "Two cours, so about 24 episodes." |
| 6 | Split cour | One long series broadcast in two parts with a gap. | "It's a split cour, second half in the spring." |
| 7 | Season | One of four yearly broadcast slots: winter, spring, summer, fall. | "What are you watching this season?" |
| 8 | OVA | Original video animation, made for home video rather than TV. | "There's an OVA that covers the side story." |
| 9 | ONA | Original net animation, released online first. | "It's an ONA, straight to streaming." |
| 10 | Shonen | Stories aimed at teen boys: effort, rivals, growth. | "Classic shonen, the training arc is the point." |
| 11 | Shojo | Stories aimed at teen girls, often centred on feelings and relationships. | "It's shojo, so the inner monologue matters." |
| 12 | Seinen | Stories aimed at adult men; often grown-up tone. | "Seinen, so expect moral grey." |
| 13 | Josei | Stories aimed at adult women about grown-up life and love. | "Josei, it's about work and real relationships." |
| 14 | Kodomo | Stories aimed at young children. | "Kodomo shows are about gentle lessons." |
| 15 | Isekai | Stories where someone ends up in another world. | "It's an isekai, he wakes up in a fantasy world." |
| 16 | Mecha | Stories built around giant robots. | "Real robot mecha, so the machines run out of ammo." |
| 17 | Slice of life | Quiet stories about daily living. | "Nothing happens and it's perfect." |
| 18 | Iyashikei | Healing anime meant to soothe. | "It's iyashikei. My shoulders drop by episode two." |
| 19 | Sports anime | Stories about teams and competition, about people more than the sport. | "I cried over a volleyball match." |
| 20 | Magical girl | Transformation heroines protecting the world. | "Magical girl, the transformation sequence is the ritual." |
| 21 | Tsundere | Archetype that is prickly outside, soft inside. | "Classic tsundere, she'll never admit it." |
| 22 | Senpai | Someone ahead of you in school or work. | "She looks up to her senpai." |
| 23 | Sensei | Teacher or master. | "Sensei is the mentor." |
| 24 | Honorific | Suffix like -san or -kun marking relationship. | "Dropping the -san means they got close." |
| 25 | OP | Opening theme sequence. | "I never skip the OP." |
| 26 | ED | Ending theme sequence. | "The ED is a banger." |
| 27 | Filler | Anime-original episodes not in the source. | "Skip the filler arc." |
| 28 | Canon | Events that follow the source story. | "Is that canon or anime-original?" |
| 29 | Recap episode | An episode that summarises earlier ones. | "Budget ran low, so a recap." |
| 30 | Anime-original content | New story made for the anime, not from the source. | "The anime-original ending is divisive." |
| 31 | Sakuga | Standout animation; also the fan term for it. | "That fight scene is pure sakuga." |
| 32 | Limited animation | Using fewer drawings to save time and cost. | "Limited animation, but the framing is brilliant." |
| 33 | On twos | Using one drawing for every two film frames. | "Animated on twos, that's why it feels stylised." |
| 34 | Key animator | Draws the main poses of a scene. | "Fans track their favorite key animators." |
| 35 | Director | Leads the creative vision of a series. | "Same director as her favorite film." |
| 36 | Series composition | Plans the overall story structure of a season. | "Series composition shaped the pacing." |
| 37 | Animation director | Supervises drawing quality and consistency. | "The animation director tightened the faces." |
| 38 | Production committee | Group of companies that fund a show. | "A production committee decides if there is a season 2." |
| 39 | Studio | The company that animates the series. | "Which studio made it?" |
| 40 | Seiyuu | A Japanese voice actor. | "Her favorite seiyuu plays the lead." |
| 41 | Simulcast | Streaming abroad at about the same time as Japan. | "It simulcasts on Saturdays." |
| 42 | Simuldub | A dub released nearly alongside the subtitled version. | "There is a simuldub now." |
| 43 | Sub | Original audio with subtitles. | "I'm a sub person." |
| 44 | Dub | Audio re-recorded in another language. | "The dub is actually great." |
| 45 | Localization | Adapting a work for another audience beyond translation. | "The localization kept the pun." |
| 46 | Romaji | Japanese written with Latin letters. | "The romaji title is different from the English one." |
| 47 | Tankobon | A collected manga volume. | "I'm on volume twelve of the tankobon." |
| 48 | Serialization | Publishing a story in instalments. | "It's serialized weekly." |
| 49 | Hiatus | A planned pause in a series or manga. | "The manga is on hiatus again." |
| 50 | Adaptation | Turning a source work into anime. | "The adaptation cut a lot." |
| 51 | Anime-only | A fan who watches but hasn't read the source. | "I'm anime-only, no spoilers." |
| 52 | Spoiler | Information that ruins a surprise. | "No spoilers!" |
| 53 | Otaku | Obsessive fan; loaded, varies by context. | "She's proud to be an otaku." |
| 54 | Weeb | Often teasing slang for an anime super-fan; can sound rude. | "Careful with the word weeb." |
| 55 | Waifu | A fictional character someone adores; playful. | "That's my waifu." |
| 56 | Husbando | Same, for male characters. | "Best husbando of the season." |
| 57 | Oshi | A favorite, from idol culture; also applied to characters. | "She has an oshi in every season." |
| 58 | Moe | Affection for cute, endearing characters. | "It's pure moe." |
| 59 | Kawaii | Cute. | "Everything about it is kawaii." |
| 60 | Peak | Slang for excellent. | "That episode was peak." |
| 61 | Mid | Slang for mediocre. | "Honestly a bit mid." |
| 62 | Tier list | A ranked list of favorites. | "Post your tier list." |
| 63 | Cosplay | Dressing as a character. | "Her cosplay took three months." |
| 64 | Doujinshi | Self-published fan or original comics. | "She bought a doujinshi at the convention." |
| 65 | Artist alley | Convention area where artists sell work. | "Meet me at artist alley." |
| 66 | Comiket | Japan's huge twice-yearly fan-works market. | "Comiket is enormous." |
| 67 | Scale figure | A detailed collectible figure at a set scale. | "A 1/7 scale figure." |
| 68 | Blind box | A sealed box with a random figure inside. | "I got the secret in my blind box." |
| 69 | Seichi junrei | Pilgrimage to real places used in a show. | "She did a seichi junrei trip." |
| 70 | Isekai (overpowered MC) | A protagonist who is absurdly strong from the start. | "The OP main character trope is the joke." |
| 71 | Arc | A self-contained story chunk in a long series. | "The Chunin Exams arc is huge." |
| 72 | Power scaling | Debating who is stronger across series. | "Power scaling is a game, not a fight." |
| 73 | Big Three | A label for three long-running flagship shonen series; contested. | "The Big Three label is debated." |
| 74 | PV | Promotional video for an upcoming series. | "The PV dropped this morning." |
| 75 | Key visual | A promotional illustration for a series. | "The new key visual looks stunning." |
| 76 | BD | Blu-ray disc release. | "The BD version fixes the animation." |

## 4. Talk Track scenarios (10)

Each: enthusiast line, meaning, good / meh / cringe replies with coach notes. Replies reward curiosity and honesty; the crush is never mocked.

**1. Comfort rewatch**
- Enthusiast line: She says she rewatches one show every winter.
- Meaning: She finds comfort in familiar stories.
- Good: "Is that show what you put on when you need a hug?" Coach note: curious, honest, short.
- Meh: "I love that one too (you have not seen it)." Coach note: Cringe: fakes expertise.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Ask what she feels when it starts.

**2. Sub or dub**
- Enthusiast line: She asks how you want to watch.
- Meaning: A genuine personal preference question.
- Good: "I'm new; what do you like about sub?" Coach note: curious, honest, short.
- Meh: "Dubs are cringe." Coach note: Meh: dismissive.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Ask why she prefers hers.

**3. The OP skipper**
- Enthusiast line: He says he never skips the OP.
- Meaning: He loves the opening as art.
- Good: "What makes that opening special to you?" Coach note: curious, honest, short.
- Meh: "Why would anyone watch the OP?" Coach note: Cringe: dismissive.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Ask which OP is his favorite.

**4. Adaptation grief**
- Enthusiast line: She says the anime cut her favorite arc.
- Meaning: She is disappointed; arcs matter.
- Good: "What did that arc mean for you?" Coach note: curious, honest, short.
- Meh: "The anime is better anyway." Coach note: Cringe: argumentative.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Ask what the arc meant.

**5. Season chart**
- Enthusiast line: He asks what you are watching this season.
- Meaning: A common social opener.
- Good: "I'm just starting. What should I watch?" Coach note: curious, honest, short.
- Meh: "I watch everything (you do not)." Coach note: Cringe: fake.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Be honest and ask about his picks.

**6. Filler skip**
- Enthusiast line: She says to skip the filler arc.
- Meaning: Filler is anime-original padding.
- Good: "How do you tell filler from canon?" Coach note: curious, honest, short.
- Meh: "Skipping is wrong." Coach note: Meh: judgemental.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Ask how she knows where it starts.

**7. Manga reader flex**
- Enthusiast line: He says the manga is better.
- Meaning: He has strong feelings about source fidelity.
- Good: "What is different in the manga?" Coach note: curious, honest, short.
- Meh: "Whatever, I like the anime." Coach note: Meh: shuts conversation.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Ask what the manga does better.

**8. Convention plan**
- Enthusiast line: She invites you to a convention.
- Meaning: She wants to share a world she loves.
- Good: "I'd love to go. What should I know?" Coach note: curious, honest, short.
- Meh: "Isn't that for weirdos?" Coach note: Cringe: unkind.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Ask what to expect.

**9. Cosplay**
- Enthusiast line: She shows her cosplay in progress.
- Meaning: She is proud of effort and craft.
- Good: "How did you make that part?" Coach note: curious, honest, short.
- Meh: "Is it comfortable?" Coach note: Good/meh depending on tone.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Compliment the work and ask how she made it.

**10. Heavy story**
- Enthusiast line: He recommends a dark thriller series.
- Meaning: He respects serious storytelling.
- Good: "What do you love about how it builds tension?" Coach note: curious, honest, short.
- Meh: "Sounds depressing." Coach note: Meh: flat.
- Cringe: pretending to expertise or putting the show down. Coach note: never fake it.
- Next question: Ask what makes it gripping without asking for spoilers.
