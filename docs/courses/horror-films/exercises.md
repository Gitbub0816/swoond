# Native Exercise Plan: Horror Films (`horror-films`)

Tier B plan for `docs/courses/horror-films/`. **Zero Unity sims** (CDS section 12). Twelve of 13 native types are used; `timing-tap` is deliberately not used because a scare-timing bar would frighten the learner as gameplay. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup). Conventions: prompts <= 12 words; every answer explained; all `license` ids are `original-swoond`. **No posters, stills, trailers, clips, score audio, dialogue quotes or publisher/review text appear anywhere (spec section 40, rule 10).** Titles and names are facts only. Violence is never described beyond "a violent death"; no item depicts or details gore. Time-sensitive facts (awards, box office, festival dates) are for the live layer.

## 1. Plan summary

| Type | How it is used | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default check and Daily Bite in every unit. | ~240 |
| `binary-call` | Two-way calls (dread or jump scare, horror or thriller, remake or requel). | ~30 |
| `term-match` | Start-of-lesson terms and Term Blitz. | ~45 |
| `sequence-order` | Jump-scare anatomy, eras, festival calendar, effects pipeline. | ~35 |
| `visual-id` | Scare-craft techniques on original diagrams. | ~50 |
| `decision-scenario` | Comfort, first shared watch, spoilers, honest opinions. | ~40 |
| `talk-track` | 24 tracks (roster in section 3). | 24 |
| `say-this` | Decode slang, subgenre and fandom talk. | ~90 |
| `fill-the-gap` | Vocabulary in context and review. | ~60 |
| `listening-id` | ~18 calm original cues, each with a text twin. | ~18 |
| `estimate-slider` | Budgets, runtimes, calendar facts. | ~20 |
| `hotspot-tap` | Frame anatomy and floor plans. | ~25 |
| `timing-tap` | **Not used.** | 0 |

Cross-type rules: every lesson ends with one item that includes a "say this" line; every unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`. **Text-twin rule:** any `listening-id` or intensity-flagged item has a `multiple-choice` twin on the same conceptIds with equal mastery credit; it is served whenever the comfort dial is `gentle`, after two skips, or on request.

## 2. Sample items by type

### 2.1 `multiple-choice`

Default knowledge check and Daily Bite card: subgenre facts, history, festivals, ratings. Distractors are the beginner errors from CDS section 2.

**Sample 1** (lesson `wi-01`)

```json
{
  "prompt": "What is dread, in a scary film?",
  "options": [
    {
      "id": "a",
      "text": "A sudden loud shock",
      "explanation": "A shock is a startle, which is a different feeling."
    },
    {
      "id": "b",
      "text": "Unease that builds while you wait",
      "explanation": "Yes: dread lives in anticipation."
    },
    {
      "id": "c",
      "text": "Disgust at something physical",
      "explanation": "That is revulsion, a third feeling."
    },
    {
      "id": "d",
      "text": "Laughing nervously",
      "explanation": "Nervous laughter is a reaction, not the feeling itself."
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Dread is the long, rising unease of waiting for something. Films that run on it feel tense rather than jumpy.",
    "incorrect": "Dread is unease that builds while you wait. A shock is a startle, and revulsion is disgust. Films mix all three.",
    "sayThisLine": "It was more dread than jump scares."
  }
}
```

**Sample 2** (lesson `sc-01`)

```json
{
  "prompt": "Which tool makes a jump scare work?",
  "options": [
    {
      "id": "a",
      "text": "A long calm followed by a sudden sound and movement",
      "explanation": "Yes: quiet sets up the startle."
    },
    {
      "id": "b",
      "text": "A slow, steady rise in tension",
      "explanation": "That is dread, which a jump scare interrupts."
    },
    {
      "id": "c",
      "text": "A quiet scene that never changes",
      "explanation": "Nothing interrupts it, so no startle."
    },
    {
      "id": "d",
      "text": "An explanation of the monster",
      "explanation": "Explaining removes surprise."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "A jump scare is a startle: the film lowers your guard with quiet, then snaps it with sound and sudden movement.",
    "incorrect": "A jump scare needs a calm to break. The quiet builds expectation and the sudden sound triggers the startle reflex.",
    "sayThisLine": "That one was a proper jump scare; the quiet set it up."
  }
}
```

**Sample 3** (lesson `fb-01`)

```json
{
  "prompt": "What makes a film folk horror?",
  "options": [
    {
      "id": "a",
      "text": "Rural land, close community and old belief as the threat",
      "explanation": "Yes: the place and its customs are the danger."
    },
    {
      "id": "b",
      "text": "A masked killer in a suburb",
      "explanation": "That is the slasher template."
    },
    {
      "id": "c",
      "text": "A haunted city apartment",
      "explanation": "That is more a haunting."
    },
    {
      "id": "d",
      "text": "A lab experiment gone wrong",
      "explanation": "That leans sci-fi or body horror."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Folk horror makes the landscape, the community and old beliefs the source of dread. Think isolated villages and the sense that the place is watching.",
    "incorrect": "Folk horror is about landscape, community and old belief. A masked killer is a slasher, and a lab accident points toward sci-fi.",
    "sayThisLine": "It is folk horror: the place is the villain."
  }
}
```

**Sample 4** (lesson `hc-05`)

```json
{
  "prompt": "Which horror-adjacent film won Best Picture in 1991?",
  "options": [
    {
      "id": "a",
      "text": "The Exorcist",
      "explanation": "It was nominated in 1974 but did not win."
    },
    {
      "id": "b",
      "text": "The Silence of the Lambs",
      "explanation": "Yes, often cited as the only one, and debated as thriller."
    },
    {
      "id": "c",
      "text": "Get Out",
      "explanation": "Nominated for the 2018 ceremony, not a winner."
    },
    {
      "id": "d",
      "text": "Psycho",
      "explanation": "Nominated for director, not Best Picture."
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "The Silence of the Lambs won Best Picture at the 1992 ceremony for 1991 films. Fans argue whether it counts as horror or as a thriller.",
    "incorrect": "It was The Silence of the Lambs, which swept the big awards. Whether it is horror or a thriller is itself a fan debate.",
    "sayThisLine": "Is Silence of the Lambs horror, or a thriller to you?"
  }
}
```

### 2.2 `binary-call`

Two-way calls with `scene.kind: none` (dread or jump scare, horror or thriller, remake or legacy sequel). No scene needed, and no horror imagery.

**Sample 1** (lesson `sc-01`)

```json
{
  "prompt": "A film builds tension slowly, then a sudden sound. Which?",
  "scene": {
    "kind": "none",
    "alt": "No scene. A text description of a quiet scene interrupted by a sudden loud sound."
  },
  "choices": [
    {
      "id": "dread",
      "label": "Dread"
    },
    {
      "id": "jump",
      "label": "Jump scare"
    }
  ],
  "correctChoiceId": "jump",
  "explanation": {
    "correct": "The sudden sound is the jump scare. The slow build before it is dread that the scare releases.",
    "incorrect": "The slow build is dread, but the sudden sound is the jump scare. Many scenes use both.",
    "sayThisLine": "The sound design got me."
  },
  "ruleTag": "Dread vs jump scare"
}
```

**Sample 2** (lesson `sm-06`)

```json
{
  "prompt": "A human killer, no ghosts or monsters. Horror or thriller?",
  "scene": {
    "kind": "none",
    "alt": "No scene. A description of a detective mystery with a human culprit."
  },
  "choices": [
    {
      "id": "thriller",
      "label": "Thriller"
    },
    {
      "id": "horror",
      "label": "Horror"
    }
  ],
  "correctChoiceId": "thriller",
  "explanation": {
    "correct": "With no supernatural or monstrous element and the fear coming from suspense about a human threat, this leans thriller. Fans still argue the border.",
    "incorrect": "Horror usually involves the monstrous, the supernatural or dread itself. A suspense story about a human threat leans thriller, though the border is fuzzy."
  },
  "ruleTag": "Horror vs thriller"
}
```

**Sample 3** (lesson `hd-04`)

```json
{
  "prompt": "Old series returns with its original cast. Remake or legacy sequel?",
  "scene": {
    "kind": "none",
    "alt": "No scene. A description of a late sequel with returning original characters."
  },
  "choices": [
    {
      "id": "remake",
      "label": "Remake"
    },
    {
      "id": "legacy",
      "label": "Legacy sequel"
    }
  ],
  "correctChoiceId": "legacy",
  "explanation": {
    "correct": "It continues the story after a long gap, bringing back original characters: a legacy sequel. A remake retells the story from the start.",
    "incorrect": "A remake retells the original story. Continuing it decades later with returning cast is a legacy sequel, sometimes called a requel.",
    "sayThisLine": "Is it a remake, or a legacy sequel?"
  },
  "ruleTag": "Remake vs requel"
}
```

### 2.3 `term-match`

Three to six terms at the start of a lesson and in Term Blitz reviews. Matching subgenres to promises, beats to jobs, effects terms to meanings.

**Sample 1** (lesson `sm-07`)

```json
{
  "prompt": "Match the subgenre to its promise.",
  "pairs": [
    {
      "id": "slasher",
      "term": "Slasher",
      "definition": "A masked killer and a survivor who fights back"
    },
    {
      "id": "folk",
      "term": "Folk horror",
      "definition": "Old belief and a menacing rural place"
    },
    {
      "id": "body",
      "term": "Body horror",
      "definition": "Fear of the body changing or failing"
    },
    {
      "id": "giallo",
      "term": "Giallo",
      "definition": "Stylish Italian murder mystery with a gloved killer"
    },
    {
      "id": "found",
      "term": "Found footage",
      "definition": "Shown as recovered camera recordings"
    }
  ],
  "distractorDefinitions": [
    "Ghosts that haunt one family home"
  ],
  "explanation": {
    "summary": "Each subgenre makes a different promise. Sorting by promise tells you what kind of night to expect.",
    "sayThisLine": "It is a slasher, so the template is the point."
  }
}
```

**Sample 2** (lesson `sc-08`)

```json
{
  "prompt": "Match the beat to its job.",
  "pairs": [
    {
      "id": "cold",
      "term": "Cold open",
      "definition": "A short scene before the titles that sets the tone"
    },
    {
      "id": "safe",
      "term": "False safety",
      "definition": "A calm that lets the audience relax"
    },
    {
      "id": "esc",
      "term": "Escalation",
      "definition": "Threats grow and options shrink"
    },
    {
      "id": "last",
      "term": "Last scare",
      "definition": "A final jolt after you think it is over"
    }
  ],
  "explanation": {
    "summary": "Most horror stories run the same four beats. Spotting them is half the fun of talking about pacing.",
    "sayThisLine": "The cold open did all the work."
  }
}
```

**Sample 3** (lesson `ec-01`)

```json
{
  "prompt": "Match the effects term to its meaning.",
  "pairs": [
    {
      "id": "pros",
      "term": "Prosthetics",
      "definition": "Shaped pieces applied to an actor"
    },
    {
      "id": "anim",
      "term": "Animatronics",
      "definition": "A machine-driven puppet or creature"
    },
    {
      "id": "pup",
      "term": "Puppetry",
      "definition": "Performers moving a physical figure by hand"
    },
    {
      "id": "cgi",
      "term": "CGI",
      "definition": "Images made digitally after filming"
    }
  ],
  "distractorDefinitions": [
    "Lighting that hides a shape"
  ],
  "explanation": {
    "summary": "Practical effects are made on set and filmed. Digital effects are made afterwards. Many films use both.",
    "sayThisLine": "Practical effects, no CGI."
  }
}
```

### 2.4 `sequence-order`

Jump-scare anatomy, eras, festival calendar, effects pipeline. Order is the concept.

**Sample 1** (lesson `sc-02`)

```json
{
  "prompt": "Order a jump scare's anatomy.",
  "items": [
    {
      "id": "setup",
      "text": "Setup: a calm, ordinary moment",
      "why": "The film lowers your guard."
    },
    {
      "id": "quiet",
      "text": "Quiet builds: sound thins out",
      "why": "Silence makes you lean in."
    },
    {
      "id": "mis",
      "text": "Misdirection: a false alarm",
      "why": "A harmless thing relaxes you."
    },
    {
      "id": "sting",
      "text": "Stinger: sudden sound and movement",
      "why": "The startle lands here."
    },
    {
      "id": "rel",
      "text": "Release: breath and nervous laugh",
      "why": "The audience resets."
    }
  ],
  "explanation": {
    "correct": "Setup, quiet, misdirection, stinger, release. Stretching the quiet makes the startle bigger.",
    "incorrect": "The scare needs a calm first, then a false alarm, then the stinger, and finally release.",
    "sayThisLine": "The quiet before it was the best part."
  }
}
```

**Sample 2** (lesson `cs-08`)

```json
{
  "prompt": "Order these eras of horror, earliest first.",
  "items": [
    {
      "id": "exp",
      "text": "German Expressionist silents"
    },
    {
      "id": "univ",
      "text": "Universal monster cycle"
    },
    {
      "id": "hammer",
      "text": "Hammer colour Gothic"
    },
    {
      "id": "slash",
      "text": "Slasher boom"
    },
    {
      "id": "meta",
      "text": "Scream and the meta turn"
    }
  ],
  "explanation": {
    "correct": "Silents in the 1920s, Universal in the 1930s, Hammer from the late 1950s, the slasher boom around 1978 to the late 1980s, then the meta turn in 1996.",
    "incorrect": "The order runs from 1920s silents to Universal in the 1930s, Hammer in the late 1950s, slashers after 1978, then Scream in 1996.",
    "sayThisLine": "Is that a Hammer-style gothic, or Universal?"
  }
}
```

**Sample 3** (lesson `hc-02`)

```json
{
  "prompt": "Order the festival calendar, earliest first.",
  "items": [
    {
      "id": "fan",
      "text": "Fantasia (Montreal, July)"
    },
    {
      "id": "fright",
      "text": "FrightFest (London, August)"
    },
    {
      "id": "ff",
      "text": "Fantastic Fest (Austin, September)"
    },
    {
      "id": "sit",
      "text": "Sitges (Catalonia, October)"
    }
  ],
  "explanation": {
    "correct": "Fantasia in July, FrightFest in late August, Fantastic Fest in September, Sitges in October. Dates shift slightly each year [verify at release].",
    "incorrect": "Think summer to autumn: Fantasia, FrightFest, Fantastic Fest, then Sitges.",
    "sayThisLine": "Did you catch anything at Fantasia this year?"
  }
}
```

### 2.5 `visual-id`

Recognition of scare-craft techniques on **original abstract technique diagrams** (`original-swoond`). None depicts a monster, injury or frightening scene, and none is a film still.

**Sample 1** (lesson `sc-03`)

```json
{
  "prompt": "Which technique does this frame diagram show?",
  "image": {
    "asset": "images/horror/negative-space.svg",
    "alt": "Abstract diagram: a small square near the left edge of a wide empty rectangle, with a large blank area on the right.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Negative space"
    },
    {
      "id": "b",
      "text": "Silhouette"
    },
    {
      "id": "c",
      "text": "Close-up"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "The large empty area invites you to wonder what could appear there. That is negative space: emptiness creating dread.",
    "incorrect": "The figure sits small at one edge with a big blank area. That emptiness is negative space."
  },
  "cues": [
    "Large empty area",
    "Small subject off-centre"
  ]
}
```

**Sample 2** (lesson `sc-05`)

```json
{
  "prompt": "Which lighting does this diagram show?",
  "image": {
    "asset": "images/horror/low-key.svg",
    "alt": "Abstract diagram: a mostly dark rectangle with a single narrow band of light from one side.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "High-key"
    },
    {
      "id": "b",
      "text": "Low-key"
    },
    {
      "id": "c",
      "text": "Flat daylight"
    }
  ],
  "correctOptionId": "b",
  "explanation": {
    "correct": "Mostly dark with one narrow light source is low-key lighting. It hides detail so your imagination fills the gaps.",
    "incorrect": "High-key is bright and even. This one is mostly shadow with a thin band of light, which is low-key."
  },
  "cues": [
    "Mostly shadow",
    "One hard light source"
  ]
}
```

**Sample 3** (lesson `sc-05`)

```json
{
  "prompt": "Which technique is this flat, dark shape on a bright panel?",
  "image": {
    "asset": "images/horror/silhouette.svg",
    "alt": "Abstract diagram: a solid dark rounded shape against a bright rectangle, with no interior detail.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Silhouette"
    },
    {
      "id": "b",
      "text": "Negative space"
    },
    {
      "id": "c",
      "text": "Low-key"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "A solid dark shape against light, with no detail inside, is a silhouette. It shows an outline and withholds everything else.",
    "incorrect": "A silhouette is an outline with no interior detail against a brighter background."
  },
  "cues": [
    "Solid dark shape",
    "No interior detail"
  ]
}
```

### 2.6 `decision-scenario`

The course's core social skill: what to say, suggest or hold back. The options never reward bravado.

**Sample 1** (lesson `wi-03`)

```json
{
  "prompt": "She invites you to a scary movie night. What now?",
  "situation": {
    "narrative": "You do not like scary films. She is excited about tonight's pick.",
    "facts": [
      {
        "label": "Your scare tolerance",
        "value": "Low"
      },
      {
        "label": "Her excitement",
        "value": "High"
      },
      {
        "label": "The pick",
        "value": "A slow-burn ghost story"
      },
      {
        "label": "Rating",
        "value": "R for some content"
      }
    ]
  },
  "options": [
    {
      "id": "honest",
      "label": "Say you get scared easily, and ask what she loves about it",
      "verdict": "best",
      "consequence": "She laughs, tells you what it is about, and picks a gentler one or lets you peek. You are closer, not judged.",
      "considerations": [
        "Honest",
        "Curious about her",
        "Not a dare"
      ]
    },
    {
      "id": "fake",
      "label": "Say you love horror",
      "verdict": "poor",
      "consequence": "She asks which ones you like. You are stuck pretending, and the evening becomes about the bluff.",
      "considerations": [
        "Bluffing costs more than admitting",
        "Invites awkward questions"
      ]
    },
    {
      "id": "cancel",
      "label": "Cancel with a vague excuse",
      "verdict": "acceptable",
      "consequence": "It avoids the night but tells her nothing, and she may feel dismissed.",
      "considerations": [
        "Safe for you",
        "Misses the chance to connect"
      ]
    }
  ],
  "expertNote": "Honesty plus curiosity is the best opening. Liking someone's taste does not require sharing their tolerance.",
  "sayThisLine": "I get scared easily, but tell me what you love about it."
}
```

**Sample 2** (lesson `cl-03`)

```json
{
  "prompt": "Pick a first shared watch.",
  "situation": {
    "narrative": "You want something gentle to watch together. She loves horror; you are new.",
    "facts": [
      {
        "label": "Your comfort dial",
        "value": "Gentle"
      },
      {
        "label": "Her taste",
        "value": "Loves dread and craft"
      },
      {
        "label": "Options",
        "value": "Horror comedy, cozy ghost story, gory slasher"
      },
      {
        "label": "Time",
        "value": "Friday night"
      }
    ]
  },
  "options": [
    {
      "id": "comedy",
      "label": "Suggest a horror comedy and check the rating",
      "verdict": "best",
      "consequence": "She enjoys showing you the genre's funny side, and you can laugh through it. A rating check keeps surprises low.",
      "considerations": [
        "Low intensity",
        "Shows range",
        "Checks the rating"
      ]
    },
    {
      "id": "gory",
      "label": "Suggest the goriest slasher so you look brave",
      "verdict": "poor",
      "consequence": "Looking brave is not the goal. You spend the night tense, and she sees you are not enjoying it.",
      "considerations": [
        "Brave is not the point",
        "Hard to recover"
      ]
    },
    {
      "id": "ask",
      "label": "Ask her which one she would pick for a newcomer",
      "verdict": "acceptable",
      "consequence": "She picks something she loves and knows. Fine, though offering a preference too shows you thought about it.",
      "considerations": [
        "Generous",
        "Less personal"
      ]
    }
  ],
  "expertNote": "Suggest, check the rating, and explain why you chose it. A first shared watch is about her company, not proving anything.",
  "sayThisLine": "Want to start with something a little funny? I'll bring snacks."
}
```

**Sample 3** (lesson `hv-06`)

```json
{
  "prompt": "Someone asks about a twist you know. What do you say?",
  "situation": {
    "narrative": "A friend is halfway through a film you know well. You remember the twist.",
    "facts": [
      {
        "label": "Friend's progress",
        "value": "Halfway"
      },
      {
        "label": "Your knowledge",
        "value": "Knows the ending"
      },
      {
        "label": "Friend's question",
        "value": "What do you think of the ending?"
      },
      {
        "label": "Mood",
        "value": "Excited"
      }
    ]
  },
  "options": [
    {
      "id": "hold",
      "label": "Say you loved it and will talk after they finish",
      "verdict": "best",
      "consequence": "They keep the surprise and look forward to swapping thoughts.",
      "considerations": [
        "Protects surprise",
        "Keeps the conversation going"
      ]
    },
    {
      "id": "tell",
      "label": "Explain the twist and why it works",
      "verdict": "poor",
      "consequence": "The surprise is gone, and they will not forgive that quickly.",
      "considerations": [
        "Spoils a one-time experience"
      ]
    },
    {
      "id": "vague",
      "label": "Hint that there is a big twist",
      "verdict": "acceptable",
      "consequence": "It avoids spoiling the details but tells them there is one, which can itself change the watch.",
      "considerations": [
        "Partial spoiler",
        "Avoids details"
      ]
    }
  ],
  "expertNote": "Horror lives on surprise, so spoiler etiquette is strict. Even telling someone there is a twist can change how they watch.",
  "sayThisLine": "Don't tell me yet; I'll save my reaction until after."
}
```

### 2.7 `talk-track`

Conversation practice. Ten tracks sampled here; 24 at launch. Every track includes honest-gap and curiosity replies, never fake expertise.

**Sample 1** (lesson `cl-01`)

```json
{
  "title": "After the credits",
  "setting": "You finish a scary film together.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Okay, that one was dread, not jump scares. Thoughts?",
      "replies": [
        {
          "id": "a",
          "text": "What was the moment it got you?",
          "smoothDelta": 30,
          "theirResponse": "The long quiet in the hallway. I stopped breathing.",
          "coachNote": "Asks for her experience, not plot."
        },
        {
          "id": "b",
          "text": "So nothing happened?",
          "smoothDelta": -20,
          "theirResponse": "A lot happened, it is just slow.",
          "coachNote": "Dismisses dread."
        },
        {
          "id": "c",
          "text": "I was more scared by the quiet, honestly.",
          "smoothDelta": 20,
          "theirResponse": "Yes! The silence is the trick.",
          "coachNote": "Honest and on-topic."
        }
      ]
    },
    {
      "theirMessage": "Did you want to leave the room?",
      "replies": [
        {
          "id": "a",
          "text": "A bit. I peeked through my fingers.",
          "smoothDelta": 20,
          "theirResponse": "Ha. Half the fun. That counts.",
          "coachNote": "Honest, playful."
        },
        {
          "id": "b",
          "text": "No, it was easy.",
          "smoothDelta": -10,
          "theirResponse": "Oh. Okay.",
          "coachNote": "Bluffing closes the topic."
        }
      ]
    }
  ],
  "closingNote": "Ask how she felt before what happened. Feelings are the conversation."
}
```

**Sample 2** (lesson `cl-02`)

```json
{
  "title": "I don't watch these, but tell me",
  "setting": "She talks about her favourite horror film.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I rewatch it every October. It is comfort.",
      "replies": [
        {
          "id": "a",
          "text": "I don't watch scary films, but I love that it is cozy. What is it about it?",
          "smoothDelta": 30,
          "theirResponse": "It is the atmosphere. Nothing too bloody.",
          "coachNote": "Honest gap plus curiosity."
        },
        {
          "id": "b",
          "text": "That sounds awful.",
          "smoothDelta": -20,
          "theirResponse": "It really is not. Never mind.",
          "coachNote": "Judges her taste."
        },
        {
          "id": "c",
          "text": "What makes it comfort?",
          "smoothDelta": 20,
          "theirResponse": "Knowing every beat.",
          "coachNote": "Curious follow-up."
        }
      ]
    },
    {
      "theirMessage": "Would you ever try one?",
      "replies": [
        {
          "id": "a",
          "text": "Maybe a gentle one with you.",
          "smoothDelta": 30,
          "theirResponse": "I know just the one.",
          "coachNote": "Open, no pressure."
        },
        {
          "id": "b",
          "text": "Never.",
          "smoothDelta": -10,
          "theirResponse": "Fair enough.",
          "coachNote": "Closes the door without curiosity."
        }
      ]
    }
  ],
  "closingNote": "You can love the person and the taste without sharing the tolerance."
}
```

**Sample 3** (lesson `cl-03`)

```json
{
  "title": "Picking a first shared watch",
  "setting": "You plan a first shared horror night.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Pick something. I'll watch anything.",
      "replies": [
        {
          "id": "a",
          "text": "Something funny. How about a horror comedy? I'll check the rating.",
          "smoothDelta": 30,
          "theirResponse": "Love it, I know a few good ones.",
          "coachNote": "Specific and thoughtful."
        },
        {
          "id": "b",
          "text": "The scariest one you have.",
          "smoothDelta": -20,
          "theirResponse": "Are you sure? You seemed nervous.",
          "coachNote": "Performative bravery."
        },
        {
          "id": "c",
          "text": "You choose; tell me why you love it.",
          "smoothDelta": 20,
          "theirResponse": "Okay, I have a plan.",
          "coachNote": "Hands her the wheel."
        }
      ]
    }
  ],
  "closingNote": "Suggest, check the rating, say why. Gentle picks are a choice, not a failure."
}
```

**Sample 4** (lesson `cl-04`)

```json
{
  "title": "You screamed?",
  "setting": "You jumped at a scare in front of her.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Did you just scream?",
      "replies": [
        {
          "id": "a",
          "text": "Yes. Did it get you too?",
          "smoothDelta": 30,
          "theirResponse": "Totally! That sting was perfect.",
          "coachNote": "Owning it makes it shared."
        },
        {
          "id": "b",
          "text": "No, that was not me.",
          "smoothDelta": -20,
          "theirResponse": "It was definitely you.",
          "coachNote": "Denial is funnier for her, not for you."
        },
        {
          "id": "c",
          "text": "That was a good one, you know.",
          "smoothDelta": 10,
          "theirResponse": "It really was.",
          "coachNote": "Acknowledges the craft."
        }
      ]
    }
  ],
  "closingNote": "A scream is a shared scare. Laugh with her, not at yourself."
}
```

**Sample 5** (lesson `cl-05`)

```json
{
  "title": "When she gushes about a director",
  "setting": "She is excited about a director's new film.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Their new one is out! It is so them: slow, strange, gorgeous.",
      "replies": [
        {
          "id": "a",
          "text": "What is the 'so them' part? The pace?",
          "smoothDelta": 30,
          "theirResponse": "The patience. They let a shot run and run.",
          "coachNote": "Asks about style."
        },
        {
          "id": "b",
          "text": "Is it gory?",
          "smoothDelta": -10,
          "theirResponse": "That is not what it is about.",
          "coachNote": "Reduces the work to gore."
        },
        {
          "id": "c",
          "text": "Which one should I start with?",
          "smoothDelta": 20,
          "theirResponse": "The first feature, it is a great entry.",
          "coachNote": "Asks for a starting point."
        }
      ]
    }
  ],
  "closingNote": "Ask about the filmography and the feel before the content."
}
```

**Sample 6** (lesson `cl-06`)

```json
{
  "title": "Spooky season plans",
  "setting": "It is late September.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I start my thirty-one-day marathon next week.",
      "replies": [
        {
          "id": "a",
          "text": "What is on your first night?",
          "smoothDelta": 30,
          "theirResponse": "Something classic, the same one every year.",
          "coachNote": "Curious and specific."
        },
        {
          "id": "b",
          "text": "Sounds exhausting.",
          "smoothDelta": -20,
          "theirResponse": "It is a ritual, not homework.",
          "coachNote": "Kills the mood."
        },
        {
          "id": "c",
          "text": "Can I join for one night?",
          "smoothDelta": 20,
          "theirResponse": "Yes, pick a gentle one.",
          "coachNote": "Invites yourself kindly."
        }
      ]
    }
  ],
  "closingNote": "A marathon is a ritual. Join it without pretending to be a fan."
}
```

**Sample 7** (lesson `cl-07`)

```json
{
  "title": "Disagree kindly",
  "setting": "You disagree about a film.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "That film is a masterpiece.",
      "replies": [
        {
          "id": "a",
          "text": "It didn't land for me, but what do you love about it?",
          "smoothDelta": 30,
          "theirResponse": "The ending stayed with me for days.",
          "coachNote": "Disagreement plus curiosity."
        },
        {
          "id": "b",
          "text": "It was boring.",
          "smoothDelta": -20,
          "theirResponse": "Wow. Okay.",
          "coachNote": "Flat dismissal."
        },
        {
          "id": "c",
          "text": "Was it scary or just good?",
          "smoothDelta": 20,
          "theirResponse": "Both. They are not the same.",
          "coachNote": "Shows you know the distinction."
        }
      ]
    }
  ],
  "closingNote": "Scary, good, fun and important are four different questions."
}
```

**Sample 8** (lesson `cl-08`)

```json
{
  "title": "Is that a remake?",
  "setting": "She mentions a new film.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Honestly it is a legacy sequel, lots of callbacks.",
      "replies": [
        {
          "id": "a",
          "text": "Do you need the original for it to land?",
          "smoothDelta": 30,
          "theirResponse": "A bit, but it stands okay.",
          "coachNote": "Right question."
        },
        {
          "id": "b",
          "text": "So it is a remake?",
          "smoothDelta": -10,
          "theirResponse": "Not quite: same story continued.",
          "coachNote": "Mixes the terms."
        },
        {
          "id": "c",
          "text": "Do you like that they bring the old cast back?",
          "smoothDelta": 20,
          "theirResponse": "I love that, honestly.",
          "coachNote": "Specific follow-up."
        }
      ]
    }
  ],
  "closingNote": "A legacy sequel continues the story; a remake retells it."
}
```

**Sample 9** (lesson `cl-08`)

```json
{
  "title": "Elevated?",
  "setting": "She and a friend argue about a label.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Please do not call it 'elevated horror'.",
      "replies": [
        {
          "id": "a",
          "text": "Do you like the label or does it bug you?",
          "smoothDelta": 30,
          "theirResponse": "It bugs me. Horror was always good.",
          "coachNote": "Genuine question."
        },
        {
          "id": "b",
          "text": "Why not? It is arty.",
          "smoothDelta": -10,
          "theirResponse": "That is exactly the problem.",
          "coachNote": "Misses the critique."
        },
        {
          "id": "c",
          "text": "Is it the word 'elevated'?",
          "smoothDelta": 20,
          "theirResponse": "Yes. It implies the rest is low.",
          "coachNote": "Gets the complaint."
        }
      ]
    }
  ],
  "closingNote": "The label is contested; ask before you pick a side."
}
```

**Sample 10** (lesson `cl-01`)

```json
{
  "title": "Did you like it?",
  "setting": "You watched a gentle ghost story with her.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "What did you think? Honestly.",
      "replies": [
        {
          "id": "a",
          "text": "I liked the quiet scenes best. The house felt alive.",
          "smoothDelta": 30,
          "theirResponse": "Yes, the house is a character.",
          "coachNote": "Specific and warm."
        },
        {
          "id": "b",
          "text": "It was fine.",
          "smoothDelta": -10,
          "theirResponse": "Fine?",
          "coachNote": "Vague."
        },
        {
          "id": "c",
          "text": "I was scared, but I liked that she kept going.",
          "smoothDelta": 20,
          "theirResponse": "Me too. It is hard not to root for her.",
          "coachNote": "Honest."
        }
      ]
    }
  ],
  "closingNote": "Specific praise beats 'it was fine'. Name one thing you noticed."
}
```

### 2.8 `say-this`

Decode a fan's line and pick a genuine follow-up. The 12 samples come from the CDS section 9 table.

**Sample 1** (lesson `sc-01`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "It's not really scary, it's more dread."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "It builds unease slowly",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "It has no monster",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "It is full of jump scares",
      "isCorrect": false
    }
  ],
  "translation": "It works by slowly building tension instead of sudden shocks.",
  "followUps": [
    {
      "line": "What was the moment the dread kicked in?",
      "why": "Asks about her experience."
    }
  ]
}
```

**Sample 2** (lesson `hv-05`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "The kills are the point."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "The deaths are staged as set pieces",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The plot is about detectives",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "She dislikes the film",
      "isCorrect": false
    }
  ],
  "translation": "In this kind of film, the staged set pieces are the entertainment.",
  "followUps": [
    {
      "line": "Was there a favourite one for the staging?",
      "why": "Keeps it about craft, not gore."
    }
  ],
  "noFakeExpertNote": "You can ask about staging without having watched it."
}
```

**Sample 3** (lesson `hv-01`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Very final-girl energy."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "A resourceful survivor who confronts the killer",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A famous actress",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A scary story told aloud",
      "isCorrect": false
    }
  ],
  "translation": "The lead is the resourceful survivor archetype of slashers.",
  "followUps": [
    {
      "line": "Do you think she earns it or is it a trope?",
      "why": "Shows you know it is debated."
    }
  ]
}
```

**Sample 4** (lesson `wr-01`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "It's a proper giallo."
  },
  "question": "What kind of film is that?",
  "options": [
    {
      "id": "a",
      "text": "A stylish Italian murder mystery",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A zombie film",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A documentary",
      "isCorrect": false
    }
  ],
  "translation": "A stylish Italian-style murder mystery, often with a gloved killer and bold colour.",
  "followUps": [
    {
      "line": "Is it more about the mystery or the style?",
      "why": "Giallo fans love both."
    }
  ]
}
```

**Sample 5** (lesson `hd-01`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "It's elevated horror. Don't call it a scary movie."
  },
  "question": "What is she signalling?",
  "options": [
    {
      "id": "a",
      "text": "Prestige-coded dread, and a label people argue about",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A comedy",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A sequel",
      "isCorrect": false
    }
  ],
  "translation": "Slow, art-house-flavoured horror, using a label that many fans dislike.",
  "followUps": [
    {
      "line": "Do you like the label or does it bug you?",
      "why": "Acknowledges it is contested."
    }
  ]
}
```

**Sample 6** (lesson `ec-01`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Practical effects, no CGI."
  },
  "question": "What is she praising?",
  "options": [
    {
      "id": "a",
      "text": "Physical makeup, prosthetics or puppets",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A cartoon look",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "Cheap sets",
      "isCorrect": false
    }
  ],
  "translation": "The creatures were built for real and filmed, not made on a computer.",
  "followUps": [
    {
      "line": "Which effect made you think, how did they do that?",
      "why": "Invites a story."
    }
  ]
}
```

**Sample 7** (lesson `sc-06`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "The sound design did all the work."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "Audio created most of the fear",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "There was no music",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "The film was silent",
      "isCorrect": false
    }
  ],
  "translation": "Drones, silence and small noises created the tension, more than visuals.",
  "followUps": [
    {
      "line": "Did you feel it more in the theatre?",
      "why": "Sound lands differently in a room."
    }
  ]
}
```

**Sample 8** (lesson `hd-04`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "That's a legacy sequel, so a lot of callbacks."
  },
  "question": "What is a legacy sequel?",
  "options": [
    {
      "id": "a",
      "text": "A late sequel for old fans with returning characters",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A remake from scratch",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A spin-off with no link",
      "isCorrect": false
    }
  ],
  "translation": "It continues an old series decades later, with original characters and references.",
  "followUps": [
    {
      "line": "Do you need the original for it to land?",
      "why": "Practical and curious."
    }
  ]
}
```

**Sample 9** (lesson `ff-01`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "It's found footage, but a good one."
  },
  "question": "What is found footage?",
  "options": [
    {
      "id": "a",
      "text": "A film presented as recovered camera recordings",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A documentary",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A silent film",
      "isCorrect": false
    }
  ],
  "translation": "It is shot to look like real recordings someone found, with handheld camera.",
  "followUps": [
    {
      "line": "Did it feel real or staged?",
      "why": "The genre lives on that question."
    }
  ]
}
```

**Sample 10** (lesson `be-04`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Honestly the ending was ambiguous and I love that."
  },
  "question": "What does she like?",
  "options": [
    {
      "id": "a",
      "text": "Not knowing exactly what was real",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A twist explained clearly",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "The sequel",
      "isCorrect": false
    }
  ],
  "translation": "The film leaves room for your own interpretation.",
  "followUps": [
    {
      "line": "What is your read on what happened?",
      "why": "Invites her theory."
    }
  ]
}
```

**Sample 11** (lesson `fb-01`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "It's folk horror: the landscape is the villain."
  },
  "question": "What does she mean?",
  "options": [
    {
      "id": "a",
      "text": "The rural place and old beliefs are the threat",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A film about a farm",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "There is no villain",
      "isCorrect": false
    }
  ],
  "translation": "The setting and community create the menace.",
  "followUps": [
    {
      "line": "Is it the community or the place that gets you?",
      "why": "A genuine question."
    }
  ]
}
```

**Sample 12** (lesson `hc-03`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "I do a thirty-one-day October marathon."
  },
  "question": "What is she describing?",
  "options": [
    {
      "id": "a",
      "text": "A film a day through October",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A running race",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A festival pass",
      "isCorrect": false
    }
  ],
  "translation": "It is a yearly tradition of watching one horror film per day in October.",
  "followUps": [
    {
      "line": "What is on the list for the first night?",
      "why": "Shows interest."
    }
  ]
}
```

### 2.9 `fill-the-gap`

Vocabulary in context and review.

**Sample 1** (lesson `sc-01`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "A {{a}} builds tension slowly, while a {{b}} startles you in an instant.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "jump scare",
        "slow burn"
      ],
      "correct": "slow burn"
    },
    {
      "id": "b",
      "options": [
        "jump scare",
        "slow burn"
      ],
      "correct": "jump scare"
    }
  ],
  "explanation": {
    "correct": "Slow burns live on dread. Jump scares are the quick startle.",
    "incorrect": "A slow burn builds; a jump scare snaps. Try swapping them to see why they do not fit."
  }
}
```

**Sample 2** (lesson `hv-01`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "In a slasher, the {{a}} is the resourceful survivor who confronts the {{b}}.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "final girl",
        "cold open"
      ],
      "correct": "final girl"
    },
    {
      "id": "b",
      "options": [
        "killer",
        "composer"
      ],
      "correct": "killer"
    }
  ],
  "explanation": {
    "correct": "Carol Clover named the final girl in her 1992 book. Fans still debate what she means.",
    "incorrect": "The survivor is the final girl, and she faces the killer."
  }
}
```

**Sample 3** (lesson `ec-01`)

```json
{
  "prompt": "Complete the sentence.",
  "template": "{{a}} effects are made on set, while {{b}} effects are added afterwards.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "Practical",
        "Digital"
      ],
      "correct": "Practical"
    },
    {
      "id": "b",
      "options": [
        "digital",
        "practical"
      ],
      "correct": "digital"
    }
  ],
  "explanation": {
    "correct": "Practical means physical and filmed. Digital means made on a computer after.",
    "incorrect": "Practical is physical on set. Digital comes later."
  }
}
```

### 2.10 `listening-id`

**Comfort-gated** original synthesised cues. Each has an intensity preview ("calm, no sudden sounds"), skip without penalty and a text twin (a described-version `multiple-choice`) with identical mastery. Replaced by the twin at `gentle`. No film audio, no imitation of any famous theme or stinger.

**Sample 1** (lesson `sc-06`)

```json
{
  "prompt": "Which sound technique is this?",
  "audio": {
    "asset": "audio/horror/low-drone.m4a",
    "durationMs": 8000,
    "license": "original-swoond",
    "description": "Original synthesised cue. Calm: a quiet, steady low tone with no sudden sounds.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Drone"
    },
    {
      "id": "b",
      "text": "Silence"
    },
    {
      "id": "c",
      "text": "Stinger"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "A steady low tone that hangs under a scene is a drone. It unsettles by never resolving.",
    "incorrect": "A drone is a long, sustained low note. Silence would be no sound, and a stinger is a short sharp hit."
  },
  "listenFor": [
    "Steady low tone",
    "Nothing changes"
  ]
}
```

**Sample 2** (lesson `sc-06`)

```json
{
  "prompt": "What is happening in this cue?",
  "audio": {
    "asset": "audio/horror/silence-gap.m4a",
    "durationMs": 6000,
    "license": "original-swoond",
    "description": "Original synthesised cue. Calm: a soft room tone that drops to total quiet, with no sudden sound afterwards.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Silence as a tool"
    },
    {
      "id": "b",
      "text": "A loud stinger"
    },
    {
      "id": "c",
      "text": "A melody"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "When the ambience drops away, the quiet makes you listen harder. Silence is a scare tool.",
    "incorrect": "The sound falls away rather than hitting. Dropping to quiet is silence used on purpose."
  },
  "listenFor": [
    "Sound drops away",
    "Waiting"
  ]
}
```

**Sample 3** (lesson `sc-07`)

```json
{
  "prompt": "Which music idea does this cue show?",
  "audio": {
    "asset": "audio/horror/wrong-lullaby.m4a",
    "durationMs": 10000,
    "license": "original-swoond",
    "description": "Original synthesised cue. Calm: a simple music-box tune with a few notes slightly out of tune.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "A lullaby played wrong"
    },
    {
      "id": "b",
      "text": "A full orchestra"
    },
    {
      "id": "c",
      "text": "A drum beat"
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "A familiar comfort tune bent slightly out of tune feels wrong. That is the wrong-lullaby technique.",
    "incorrect": "A sweet, simple tune with a few off notes is the wrong-lullaby idea."
  },
  "listenFor": [
    "Simple tune",
    "A few notes off"
  ]
}
```

### 2.11 `estimate-slider`

Numbers that matter: budgets, runtimes, calendar facts.

**Sample 1** (lesson `hc-06`)

```json
{
  "prompt": "Blumhouse's model aims at budgets under roughly how much?",
  "unit": "million dollars",
  "min": 1,
  "max": 50,
  "step": 1,
  "correctValue": 5,
  "tolerance": {
    "full": 1,
    "partial": 3
  },
  "explanation": {
    "correct": "Blumhouse's stated model keeps budgets around or under five million dollars. Small budgets make hits likelier.",
    "incorrect": "The famous model keeps budgets near five million dollars or less, so one modest hit covers several misses."
  }
}
```

**Sample 2** (lesson `wi-05`)

```json
{
  "prompt": "How long is a typical horror feature?",
  "unit": "minutes",
  "min": 60,
  "max": 150,
  "step": 5,
  "correctValue": 95,
  "tolerance": {
    "full": 5,
    "partial": 15
  },
  "explanation": {
    "correct": "Most horror features run about 90 to 100 minutes. Tight runtimes keep tension from going slack.",
    "incorrect": "Horror runs lean, about 90 to 100 minutes, because tension sags when stretched."
  }
}
```

**Sample 3** (lesson `hc-03`)

```json
{
  "prompt": "Most Fridays the 13th in one calendar year?",
  "unit": "times",
  "min": 0,
  "max": 6,
  "step": 1,
  "correctValue": 3,
  "tolerance": {
    "full": 0,
    "partial": 1
  },
  "explanation": {
    "correct": "A year can hold at most three. Fans mark each one with a marathon.",
    "incorrect": "The calendar allows up to three Fridays the 13th in a year."
  }
}
```

### 2.12 `hotspot-tap`

Procedural diagrams only: frame anatomy, a haunted-house floor plan and a cabin map. Static, top-down, nothing frightening.

**Sample 1** (lesson `sc-03`)

```json
{
  "prompt": "Tap the negative space that creates dread.",
  "diagram": {
    "diagramId": "horror-negative-space-frame",
    "aspectRatio": 1.5,
    "alt": "Abstract frame: a small figure at the left, a doorway shape at the right, and a wide empty corridor between them."
  },
  "hotspots": [
    {
      "id": "fig",
      "label": "Figure",
      "shape": {
        "kind": "circle",
        "cx": 0.15,
        "cy": 0.6,
        "r": 0.08
      }
    },
    {
      "id": "gap",
      "label": "Empty corridor",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.12
      }
    },
    {
      "id": "door",
      "label": "Doorway",
      "shape": {
        "kind": "circle",
        "cx": 0.85,
        "cy": 0.5,
        "r": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "gap"
  ],
  "explanation": {
    "correct": "The empty space between the figure and the doorway is where your mind invents something. Emptiness is doing the work.",
    "incorrect": "The object is not the point here. Tap the empty corridor: negative space makes you wait."
  }
}
```

**Sample 2** (lesson `hv-04`)

```json
{
  "prompt": "Tap the space the film makes feel safest.",
  "diagram": {
    "diagramId": "haunted-house-floorplan",
    "aspectRatio": 1.5,
    "alt": "Top-down floor plan of a two-room house with a hallway, a front door and a basement stair."
  },
  "hotspots": [
    {
      "id": "front",
      "label": "Front door",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.9,
        "r": 0.07
      }
    },
    {
      "id": "hall",
      "label": "Hallway",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.09
      }
    },
    {
      "id": "base",
      "label": "Basement stair",
      "shape": {
        "kind": "circle",
        "cx": 0.85,
        "cy": 0.2,
        "r": 0.07
      }
    }
  ],
  "correctHotspotIds": [
    "front"
  ],
  "explanation": {
    "correct": "The front door is the exit and the usual sign of safety, which is why films so often cut it off or lock it.",
    "incorrect": "Safety in a haunted house is the way out. The front door is the exit that films love to remove."
  }
}
```

**Sample 3** (lesson `hv-04`)

```json
{
  "prompt": "Tap the path a cabin-in-the-woods film isolates.",
  "diagram": {
    "diagramId": "cabin-woods-map",
    "aspectRatio": 1.5,
    "alt": "Top-down map: a cabin in a clearing, a single road leaving at the bottom and dense woods all around."
  },
  "hotspots": [
    {
      "id": "cabin",
      "label": "Cabin",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.4,
        "r": 0.08
      }
    },
    {
      "id": "road",
      "label": "Only road out",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.92,
        "r": 0.07
      }
    },
    {
      "id": "woods",
      "label": "Woods",
      "shape": {
        "kind": "circle",
        "cx": 0.15,
        "cy": 0.3,
        "r": 0.1
      }
    }
  ],
  "correctHotspotIds": [
    "road"
  ],
  "explanation": {
    "correct": "Isolation works by cutting the escape. The single road out is the thing the story takes away.",
    "incorrect": "The isolation trick is removing the way out. Tap the single road."
  }
}
```

### 2.13 Text-twin example (for the `listening-id` sample 1, served at `gentle`)

The twin describes the technique in words, with no audio.

```json
{
  "prompt": "Which sound technique is a steady low tone?",
  "options": [
    {
      "id": "a",
      "text": "Drone",
      "explanation": "A sustained low note that never resolves."
    },
    {
      "id": "b",
      "text": "Silence",
      "explanation": "Silence is the absence of sound."
    },
    {
      "id": "c",
      "text": "Stinger",
      "explanation": "A short, sharp hit."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "A steady low tone hanging under a scene is a drone. It unsettles by never resolving.",
    "incorrect": "A drone is a sustained low note. Silence is no sound, and a stinger is a short sharp hit."
  }
}
```

## 3. Talk track roster (24 at launch)

| # | Track | Unit / lesson | Skill |
|---|---|---|---|
| 1 | After the credits | `cl-01` | Ask about feeling first |
| 2 | I don't watch these, but tell me | `cl-02` | Curious without watching |
| 3 | Picking a first shared watch | `cl-03` | Gentle suggestion with rating check |
| 4 | You screamed? | `cl-04` | Own your scare |
| 5 | When she gushes about a director | `cl-05` | Ask about style, not gore |
| 6 | Spooky season plans | `cl-06` | Join a ritual honestly |
| 7 | Disagree kindly | `cl-07` | Scary vs good |
| 8 | Is that a remake? | `cl-08` | Legacy sequel vs remake |
| 9 | Elevated? | `hd-01` | The label debate |
| 10 | Did you like it? | `cl-01` | Specific praise |
| 11-24 | One per unit capstone (`what-is-horror`, `scare-craft`, `the-subgenre-map`, `horror-vocabulary`, `century-of-scares`, `slashers-and-final-girls`, `ghosts-haunts-possession`, `folk-body-and-beyond`, `found-footage-and-formats`, `world-horror`, `effects-and-craft`, `horror-culture`, branch capstones) | capstones | Unit-specific |

## 4. Talk tracks: Scenario table (10 written in full above)

Each track above has: the enthusiast line, its meaning (in the `theirResponse` and closing note), and three reply tiers. Smooth deltas use the contract range (-20 to +30): **good** replies +20 to +30 (specific, curious, honest), **meh** replies about -10 to +10 (polite but vague), **cringe** replies -20 (dismissive, bluffing, gore-fixated). Coach notes always name *why* (for example, "Bluffing closes the topic").

## 5. Playbook terms (72)

Definitions are Swoon'd's own words. The example line is what an enthusiast would say.

| Term | Definition | Example line |
|---|---|---|
| Dread | Unease that builds while you wait. | "It is all dread, barely a jump scare." |
| Jump scare | A sudden sound and movement that startles. | "That jump scare got me." |
| Stinger | The sharp sound hit that lands a scare. | "The stinger was perfectly timed." |
| Cat scare | A false alarm that turns out harmless. | "It was just a cat scare, phew." |
| Slow burn | A film that builds tension patiently. | "It's a slow burn, stay with it." |
| Negative space | Empty frame area that invites fear. | "The negative space is unsettling." |
| Silhouette | A dark outline with no detail. | "The silhouette in the doorway, so good." |
| Low-key lighting | Mostly shadow with a few hard lights. | "The low-key light hides everything." |
| Sound design | The crafted audio world of a film. | "The sound design did all the work." |
| Drone | A sustained low tone under a scene. | "A drone sat under the whole scene." |
| Dissonance | Clashing notes that feel unsettled. | "The strings were pure dissonance." |
| Wrong lullaby | A comforting tune bent off-key. | "The wrong lullaby gave me chills." |
| Cold open | A short scene before the titles. | "The cold open sets the tone." |
| False safety | A calm that lets you relax before a scare. | "It lulls you into false safety." |
| Escalation | Threats grow as options shrink. | "The escalation in act two is great." |
| Final scare | A last jolt after the ending seems calm. | "Good final scare, I did not see it." |
| Slasher | A masked killer stalking a group. | "It's a classic slasher." |
| Final girl | The resourceful slasher survivor. | "Very final-girl energy." |
| Scream queen | A star known for horror roles. | "She is a proper scream queen." |
| Giallo | Stylish Italian murder-mystery horror. | "It's a proper giallo." |
| Folk horror | Rural places and old belief as menace. | "Folk horror: the land is the villain." |
| Body horror | Fear of the body changing or failing. | "It's body horror about ageing." |
| Cosmic horror | Fear of vast, unknowable forces. | "Cosmic horror, nothing you can fight." |
| Found footage | Presented as recovered recordings. | "Found footage, but a good one." |
| Screenlife | A story told through screens and devices. | "It's a screenlife horror." |
| Mockumentary | A fictional film shot like a documentary. | "A horror mockumentary, very funny." |
| Anthology | A film of several short stories. | "I love an anthology for October." |
| J-horror | Japanese horror, often quiet ghost stories. | "J-horror is all slow crawl." |
| K-horror | Korean horror, often social and sharp. | "K-horror always has a social edge." |
| Onryo | A vengeful ghost in Japanese folklore. | "The onryo is the classic J-horror ghost." |
| Haunting | A place is troubled by a presence. | "It's a haunting, not a ghost story." |
| Possession | A person controlled by an outside force. | "A possession film with faith at its core." |
| Exorcism | A ritual to drive a presence out. | "An exorcism movie at heart." |
| Occult horror | Horror about demons, cults and dark rites. | "Very occult, very 1970s." |
| Creature feature | A film built around a monstrous animal or being. | "A solid creature feature." |
| Kaiju | A giant monster from Japanese cinema. | "It's a kaiju film, so big." |
| Zombie film | Horror about the walking dead. | "A slow-zombie film with satire." |
| Psychological horror | Fear from the mind and perception. | "More psychological than supernatural." |
| Uncanny | Something familiar that feels deeply wrong. | "The uncanny doll does the work." |
| Doppelganger | A double of a person. | "A doppelganger story, so creepy." |
| Liminal space | An in-between place that feels off. | "Empty hallways, very liminal." |
| Haunted house | A home that holds a threat. | "The house is a character." |
| Cabin in the woods | An isolated cabin setting. | "Classic cabin-in-the-woods setup." |
| Set piece | A staged showpiece sequence. | "The kills are set pieces." |
| Meta-horror | Horror that knows the genre's rules. | "Scream is meta-horror." |
| Legacy sequel | A late sequel with returning characters. | "It's a legacy sequel." |
| Requel | A sequel that also resets a series. | "Is it a remake or a requel?" |
| Remake | A retelling of an earlier film. | "A remake of a cult classic." |
| Retcon | A change that rewrites series history. | "They retconned the whole timeline." |
| Elevated horror | A contested label for arty, dread-led horror. | "I dislike the label elevated horror." |
| Post-horror | A rival term for elevated horror. | "Some critics say post-horror." |
| Video nasty | A UK 1980s banned or prosecuted video. | "The video nasty panic is fascinating." |
| Practical effects | Effects made physically on set. | "Practical effects, no CGI." |
| Prosthetics | Shaped pieces applied to an actor. | "The prosthetics were incredible." |
| Animatronics | A machine-driven puppet or creature. | "Animatronics sell the reveal." |
| Creature design | The look and logic of a monster. | "The creature design is original." |
| Foley | Sounds made and recorded by hand. | "The Foley work is brilliant." |
| Midnight Madness | A festival strand for genre films. | "It won the midnight crowd." |
| Fantastic Fest | A genre festival in Austin each September. | "I heard about it at Fantastic Fest." |
| Sitges | A genre festival in Catalonia each October. | "It played Sitges." |
| Fantasia | A genre festival in Montreal each July. | "It premiered at Fantasia." |
| FrightFest | A London horror festival each August. | "I'm going to FrightFest." |
| Shudder | A streaming service for horror. | "It's on Shudder now." |
| Fangoria | A long-running horror magazine brand. | "I grew up on Fangoria." |
| Horror host | A costumed presenter of horror films on TV. | "An old horror host introduced it." |
| Spooky season | September to October horror culture. | "It is spooky season." |
| Cozy horror | Horror that feels comforting. | "It's my cozy horror pick." |
| Blumhouse model | Low budgets and high returns. | "The Blumhouse model works." |
| Unrated cut | A version not rated by a board. | "I saw the unrated cut." |
| NC-17 | A US rating barring ages 17 and under. | "It was an NC-17 fight." |
| Twist ending | A late reveal that reframes the story. | "I did not see that twist coming." |
| Sequel bait | A closing hint of another film. | "The sequel bait at the end!" |

## 6. Validation

Every JSON block in section 2 was validated with ajv (draft 2020-12) against its schema when this file was generated (54 payloads, 0 failures). Re-run by extracting blocks and checking against `docs/contracts/native-exercises/v1/<type>.schema.json`.
