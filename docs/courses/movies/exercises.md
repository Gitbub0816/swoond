# Native Exercise Plan: Movies (`movies`)

Tier B plan for `docs/courses/movies/`. Twelve of the 13 native exercise types are used (`timing-tap` is deliberately not used; see section 1). Tier A sims are in `sims/`. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup when this file was generated). Conventions: prompts <= 12 words; every answer explained; all `license` ids are `original-swoond`; no third-party imagery or audio. **No posters, stills, trailers, clips, score audio, dialogue quotes or publisher/review text appear anywhere in this course (spec section 40, rule 10).** Titles and names are used as facts only; film-specific items describe the technique, not the frame. Time-sensitive facts (awards results, box office) are tagged for the live layer, not hard-coded into evergreen lessons.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite card in every unit. | ~240 |
| `binary-call` | Same-side-or-crossed calls, jump cut or smooth, story-structure calls; also the native fallback for `film.camera.axis-line.v1`. | ~30 |
| `term-match` | Three to six terms at the start of a lesson and in Term Blitz reviews. | ~45 |
| `sequence-order` | Production stages, awards-season order, eras, release windows. | ~35 |
| `visual-id` | Shot size, angle, lighting and aspect-ratio recognition from original technique illustrations. | ~80 |
| `decision-scenario` | What to say, recommend or watch; spoiler etiquette; honest opinions. | ~40 |
| `talk-track` | 24 tracks at launch (roster in section 5): one per unit end plus the Conversation Lab and Talk tab. | ~24 |
| `say-this` | Decode slang, format talk, awards and director shorthand. | ~90 |
| `fill-the-gap` | Vocabulary in context and review. | ~60 |
| `listening-id` | Original film-sound cues: diegetic, leitmotif, Foley, silence, mix. | ~24 |
| `estimate-slider` | Runtimes, ratios, shot lengths, nominee counts, budget tiers. | ~30 |
| `hotspot-tap` | Thirds grid, axis-line sides, lighting diagrams. | ~35 |
| `timing-tap` | **Not used.** Editing rhythm as a 1D timing game would be contrived; `estimate-slider` on average shot length and long-take `listening-id`/`say-this` items cover pacing. | 0 |

Estimated total: about 733 native items across 117 lessons and the review loop. Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

The default knowledge check and Daily Bite card. Crew roles, ratings systems, awards rules, box-office vocabulary. Distractors are the classic beginner errors from CDS section 2.

**Sample 1** (lesson `mk-02`)

```json
{
  "prompt": "Who leads the camera and lighting crews?",
  "options": [
    {
      "id": "a",
      "text": "The producer",
      "explanation": "Producers run money and logistics, not the lens."
    },
    {
      "id": "b",
      "text": "The cinematographer",
      "explanation": "Also called the director of photography, or DP."
    },
    {
      "id": "c",
      "text": "The editor",
      "explanation": "Editors work after shooting, shaping the footage."
    },
    {
      "id": "d",
      "text": "The production designer",
      "explanation": "They design sets and look, not the camera."
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "The cinematographer (DP) decides framing, lenses and light with the director, then leads the camera and lighting crews. Not \"the camera guy\": it is a leading creative role.",
    "incorrect": "That is the cinematographer, also called the director of photography or DP. They work with the director on framing, lenses and light and lead those crews.",
    "sayThisLine": "Who was the cinematographer on that? The light was unreal."
  }
}
```

**Sample 2** (lesson `ct-01`)

```json
{
  "prompt": "What does a Tomatometer percentage measure?",
  "options": [
    {
      "id": "a",
      "text": "The average star rating"
    },
    {
      "id": "b",
      "text": "The share of critics who gave a positive review"
    },
    {
      "id": "c",
      "text": "How much audiences enjoyed it"
    },
    {
      "id": "d",
      "text": "How much money it made"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "It is the percent of reviews counted as positive, not an average. A film most critics mildly liked can score 90% while nobody calls it a masterpiece.",
    "incorrect": "It counts the percent of critics who gave a positive review. It is not an average score, and it says nothing about box office or audience opinion.",
    "sayThisLine": "Ninety percent just means most critics liked it, not that it is a ten."
  }
}
```

**Sample 3** (lesson `aw-03`)

```json
{
  "prompt": "How is the Oscars Best Picture winner chosen?",
  "options": [
    {
      "id": "a",
      "text": "Most first-place votes wins outright"
    },
    {
      "id": "b",
      "text": "A ranked-choice preferential ballot"
    },
    {
      "id": "c",
      "text": "A jury of film critics"
    },
    {
      "id": "d",
      "text": "Box office decides it"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Members rank the nominees. Lowest-ranked films are eliminated and their votes move to the next choice, so a broadly liked film can beat a divisive favourite. Other categories use one vote for one winner.",
    "incorrect": "Best Picture uses a ranked-choice preferential ballot. Films with the fewest first-place votes are dropped and those ballots transfer to their next pick until one film has a majority.",
    "sayThisLine": "Best Picture is ranked-choice, so the broadly loved film often wins."
  }
}
```

**Sample 4** (lesson `mk-06`)

```json
{
  "prompt": "What does it mean if a film has \"legs\"?",
  "options": [
    {
      "id": "a",
      "text": "A strong ensemble cast"
    },
    {
      "id": "b",
      "text": "Its box office holds up week after week"
    },
    {
      "id": "c",
      "text": "It is very long"
    },
    {
      "id": "d",
      "text": "It has a huge marketing budget"
    }
  ],
  "correctOptionIds": [
    "b"
  ],
  "explanation": {
    "correct": "Legs means a small drop from one weekend to the next, usually thanks to word of mouth. A huge opening followed by a steep fall is the opposite: front-loaded.",
    "incorrect": "Legs describes how well box office holds from weekend to weekend. Good legs mean word of mouth is keeping people coming back.",
    "sayThisLine": "It opened modestly but has legs. People keep telling their friends."
  }
}
```

### 2.2 `binary-call`

Two-way judgments on a static top-down diagram or a text-only situation: same side of the axis line or crossed, smooth cut or jump cut. Diagrams are procedural (`original-swoond`); `ruleTag` names the rule. The moving version of the axis line is Tier A (`film.camera.axis-line.v1`); these items are also its native fallback and review format.

**Sample 1** (lesson `mc-04`)

```json
{
  "prompt": "Camera 2 is placed here. Same side or crossed?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "camera-axis-topdown",
    "markers": [
      {
        "role": "opponent",
        "x": 0.35,
        "y": 0.5
      },
      {
        "role": "opponent",
        "x": 0.65,
        "y": 0.5
      },
      {
        "role": "player",
        "x": 0.5,
        "y": 0.85
      },
      {
        "role": "target",
        "x": 0.5,
        "y": 0.15
      }
    ],
    "alt": "Top-down room. Two people face each other along a horizontal line. Camera 1 is below the line. Camera 2 is above the line, on the far side."
  },
  "choices": [
    {
      "id": "same-side",
      "label": "Same side"
    },
    {
      "id": "crossed",
      "label": "Crossed the line"
    }
  ],
  "correctChoiceId": "crossed",
  "ruleTag": "180-degree rule",
  "explanation": {
    "correct": "Camera 1 is below the line between the two people and camera 2 is above it. Cutting between them would flip who is on the left and right of the screen.",
    "incorrect": "Camera 2 sits on the opposite side of the line from camera 1. That flips screen direction on the cut, so it breaks the 180-degree rule.",
    "sayThisLine": "They crossed the line there. Left and right flipped."
  }
}
```

**Sample 2** (lesson `mc-04`)

```json
{
  "prompt": "Camera 2 is placed here. Same side or crossed?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "camera-axis-topdown",
    "markers": [
      {
        "role": "opponent",
        "x": 0.35,
        "y": 0.5
      },
      {
        "role": "opponent",
        "x": 0.65,
        "y": 0.5
      },
      {
        "role": "player",
        "x": 0.5,
        "y": 0.85
      },
      {
        "role": "target",
        "x": 0.25,
        "y": 0.75
      }
    ],
    "alt": "Top-down room. Two people face each other along a horizontal line. Camera 1 is below the line, centred. Camera 2 is also below the line, to the left."
  },
  "choices": [
    {
      "id": "same-side",
      "label": "Same side"
    },
    {
      "id": "crossed",
      "label": "Crossed the line"
    }
  ],
  "correctChoiceId": "same-side",
  "ruleTag": "180-degree rule",
  "explanation": {
    "correct": "Both cameras are below the line, so the left person stays on the left and the right person on the right. You can cut freely between them.",
    "incorrect": "Both cameras are on the same side of the line, so screen direction stays consistent. Only a camera on the other side would flip it.",
    "sayThisLine": "Both cameras stay on one side, so the cut feels natural."
  }
}
```

**Sample 3** (lesson `mc-05`)

```json
{
  "prompt": "Two cuts to almost the same angle. Smooth or jump cut?",
  "scene": {
    "kind": "none",
    "alt": "Text-only question: a shot of a person at a table, then a cut to nearly the same framing with the person slightly shifted."
  },
  "choices": [
    {
      "id": "smooth",
      "label": "Smooth"
    },
    {
      "id": "jump-cut",
      "label": "Jump cut"
    }
  ],
  "correctChoiceId": "jump-cut",
  "ruleTag": "Jump cut",
  "explanation": {
    "correct": "When the angle barely changes, the person seems to teleport. That visible jolt is a jump cut. Filmmakers use it on purpose for tension or style, but usually avoid it.",
    "incorrect": "Nearly the same angle with a small change reads as a jolt, a jump cut. A bigger change in angle or size looks smooth.",
    "sayThisLine": "That was a deliberate jump cut, the edit is meant to be seen."
  }
}
```

### 2.3 `term-match`

Introduce 3 to 6 related terms at the start of a lesson: crew roles, sound terms, sequel/remake/reboot, eras, awards. Definitions are short and concrete.

**Sample 1** (lesson `mk-02`)

```json
{
  "prompt": "Match each crew role to its job.",
  "pairs": [
    {
      "id": "director",
      "term": "Director",
      "definition": "Leads the creative vision and the performances"
    },
    {
      "id": "dp",
      "term": "Cinematographer",
      "definition": "Designs framing, lenses and light with the director"
    },
    {
      "id": "editor",
      "term": "Editor",
      "definition": "Assembles the footage into the final cut"
    },
    {
      "id": "composer",
      "term": "Composer",
      "definition": "Writes the original score"
    },
    {
      "id": "prod-designer",
      "term": "Production designer",
      "definition": "Designs the sets and overall look"
    }
  ],
  "distractorDefinitions": [
    "Raises the money and runs the schedule"
  ],
  "explanation": {
    "summary": "A film is many crafts pulled together. When someone says the film \"looks amazing\", credit is usually shared by the cinematographer and production designer, not just the director.",
    "sayThisLine": "The production design and the cinematography together made that world."
  }
}
```

**Sample 2** (lesson `mc-07`)

```json
{
  "prompt": "Match each sound term to its meaning.",
  "pairs": [
    {
      "id": "diegetic",
      "term": "Diegetic",
      "definition": "Sound the characters can hear"
    },
    {
      "id": "non-diegetic",
      "term": "Non-diegetic",
      "definition": "Sound only the audience hears, like a score"
    },
    {
      "id": "foley",
      "term": "Foley",
      "definition": "Everyday sounds recreated in a studio"
    },
    {
      "id": "adr",
      "term": "ADR",
      "definition": "Dialogue re-recorded after filming"
    },
    {
      "id": "needle-drop",
      "term": "Needle drop",
      "definition": "An existing pop song placed in a scene"
    }
  ],
  "distractorDefinitions": [
    "A camera move that follows the action"
  ],
  "explanation": {
    "summary": "Sound is half the film. Diegetic vs non-diegetic is the first split cinephiles reach for when they talk about how a scene feels.",
    "sayThisLine": "Was that song in the scene, or just for us?"
  }
}
```

**Sample 3** (lesson `sg-06`)

```json
{
  "prompt": "Match each film relationship to its meaning.",
  "pairs": [
    {
      "id": "sequel",
      "term": "Sequel",
      "definition": "Continues the story after the first film"
    },
    {
      "id": "prequel",
      "term": "Prequel",
      "definition": "Tells events before the first film"
    },
    {
      "id": "remake",
      "term": "Remake",
      "definition": "Tells the same story again with new production"
    },
    {
      "id": "reboot",
      "term": "Reboot",
      "definition": "Restarts a franchise, ignoring earlier continuity"
    },
    {
      "id": "spin-off",
      "term": "Spin-off",
      "definition": "Follows a side character or corner of the world"
    }
  ],
  "explanation": {
    "summary": "People mix these up constantly. The quick test: does it continue the story (sequel), go back (prequel), retell it (remake), restart the series (reboot) or follow someone new (spin-off)?",
    "sayThisLine": "Is it a remake or a reboot? I never know the difference."
  }
}
```

### 2.4 `sequence-order`

Order is the concept: production stages, the awards-season calendar, eras of cinema, box-office and release windows.

**Sample 1** (lesson `mk-03`)

```json
{
  "prompt": "Order a movie from idea to audience.",
  "items": [
    {
      "id": "development",
      "text": "Development: script, financing, attaching talent",
      "why": "Nothing gets built until there is a script and money."
    },
    {
      "id": "pre-production",
      "text": "Pre-production: casting, sets, schedules",
      "why": "Planning before the cameras roll saves money."
    },
    {
      "id": "production",
      "text": "Production: principal photography",
      "why": "The shoot itself."
    },
    {
      "id": "post-production",
      "text": "Post-production: editing, sound, effects, music",
      "why": "The film is assembled after shooting."
    },
    {
      "id": "release",
      "text": "Distribution and release",
      "why": "Marketing, festivals, theatres, streaming."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Five stages, and post-production is where much of the film is really made: editing, sound, effects and score.",
    "incorrect": "The order is development, pre-production, production, post-production, release. Post-production comes after the shoot, not during it.",
    "sayThisLine": "It is in post right now. They are still cutting it."
  }
}
```

**Sample 2** (lesson `aw-01`)

```json
{
  "prompt": "Order the awards-season calendar.",
  "items": [
    {
      "id": "fall-festivals",
      "text": "Fall festivals premiere contenders (Venice, Telluride, TIFF)",
      "why": "The narrative starts in late summer and early fall."
    },
    {
      "id": "precursors",
      "text": "Precursor awards and guild announcements",
      "why": "Critics groups and guilds shape the frontrunner story."
    },
    {
      "id": "nominations",
      "text": "Oscar nominations announced",
      "why": "Voted by the branches in January."
    },
    {
      "id": "final-voting",
      "text": "Final voting and campaigning",
      "why": "All Academy members vote for winners."
    },
    {
      "id": "ceremony",
      "text": "The ceremony",
      "why": "Winners are revealed in early spring."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Festivals plant the seeds, precursors reveal the frontrunners, nominations narrow the field and then everyone votes. Exact dates change each year, so the app tracks the current season.",
    "incorrect": "Festivals come first, then precursors, nominations, final voting and the ceremony. The exact dates shift each season.",
    "sayThisLine": "It is festival season. The awards conversation is just starting."
  }
}
```

**Sample 3** (lesson `er-08`)

```json
{
  "prompt": "Order the eras of American cinema.",
  "items": [
    {
      "id": "silent",
      "text": "Silent era",
      "why": "Before synchronised sound."
    },
    {
      "id": "studio",
      "text": "Studio system and the Production Code",
      "why": "Golden Age of big studios."
    },
    {
      "id": "new-hollywood",
      "text": "New Hollywood",
      "why": "Director-driven films from the late 1960s."
    },
    {
      "id": "blockbuster",
      "text": "The blockbuster era",
      "why": "Jaws and Star Wars in the 1970s."
    },
    {
      "id": "streaming",
      "text": "The streaming era",
      "why": "The 2010s onward."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Each era answers the one before: sound replaced silence, studios gave way to auteurs, auteurs gave way to blockbusters, and streaming reshuffled how films reach us.",
    "incorrect": "Silent, studio system, New Hollywood, blockbuster, streaming. Each era is a reaction to the last.",
    "sayThisLine": "She loves New Hollywood, the era before the summer blockbuster."
  }
}
```

### 2.5 `visual-id`

Recognising a technique by sight (shot size, angle, lighting, aspect ratio, colour palette) on **original Swoon'd illustrations only**. No posters, key art, stills or frame grabs (spec section 40). `license` is always `original-swoond`; `alt` describes the distinguishing features without giving away the answer.

**Sample 1** (lesson `fr-01`)

```json
{
  "prompt": "Which shot size is this?",
  "image": {
    "asset": "movies/technique/shot-size-close-up.svg",
    "alt": "An original illustration of a stylised figure framed from the top of the head to the collarbone, face filling most of the frame.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "wide",
      "text": "Wide shot"
    },
    {
      "id": "medium",
      "text": "Medium shot"
    },
    {
      "id": "close-up",
      "text": "Close-up"
    },
    {
      "id": "ecu",
      "text": "Extreme close-up"
    }
  ],
  "correctOptionId": "close-up",
  "explanation": {
    "correct": "A close-up frames the face, roughly head to collarbone. It puts you inside a character's emotion.",
    "incorrect": "This is a close-up: the face fills the frame. An extreme close-up would show just the eyes or a detail, and a medium shot would show the waist up.",
    "sayThisLine": "That close-up is where the scene really lands."
  },
  "cues": [
    "Face fills most of the frame",
    "Frame ends around the collarbone",
    "Eyes are the focal point"
  ]
}
```

**Sample 2** (lesson `fr-06`)

```json
{
  "prompt": "Which lighting style is this?",
  "image": {
    "asset": "movies/technique/lighting-low-key.svg",
    "alt": "An original illustration of a stylised head lit strongly from one side, with the other half of the face in deep shadow on a dark background.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "high-key",
      "text": "High-key"
    },
    {
      "id": "low-key",
      "text": "Low-key"
    },
    {
      "id": "flat",
      "text": "Flat, even light"
    }
  ],
  "correctOptionId": "low-key",
  "explanation": {
    "correct": "Low-key lighting means strong contrast and deep shadow. It is common in noir, thrillers and horror, and suggests secrets or danger.",
    "incorrect": "Half the face is in deep shadow with strong contrast: that is low-key lighting. High-key is bright and even with soft shadows.",
    "sayThisLine": "The low-key lighting makes everyone look like they are hiding something."
  },
  "cues": [
    "Strong contrast",
    "Large areas of shadow",
    "Dark background"
  ]
}
```

**Sample 3** (lesson `fr-05`)

```json
{
  "prompt": "Which aspect ratio is this frame?",
  "image": {
    "asset": "movies/technique/aspect-ratio-239.svg",
    "alt": "An original illustration of a very wide, thin rectangle frame with a stylised landscape stretching across it, about two and a half times wider than tall.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "ratio-133",
      "text": "1.33:1 (boxy)"
    },
    {
      "id": "ratio-185",
      "text": "1.85:1 (standard widescreen)"
    },
    {
      "id": "ratio-239",
      "text": "2.39:1 (scope)"
    }
  ],
  "correctOptionId": "ratio-239",
  "explanation": {
    "correct": "About two and a half times wider than tall: scope, or 2.39:1. It suits landscapes and big epics because the world stretches sideways.",
    "incorrect": "The frame is very wide, about 2.39 times wider than it is tall. That is the scope ratio. 1.85 is a little taller, and 1.33 is nearly square.",
    "sayThisLine": "The scope frame makes every landscape feel enormous."
  },
  "cues": [
    "Very wide and thin",
    "Black bars top and bottom on a normal screen",
    "Room for landscapes"
  ]
}
```

**Sample 4** (lesson `fr-02`)

```json
{
  "prompt": "Which camera angle is this?",
  "image": {
    "asset": "movies/technique/angle-low.svg",
    "alt": "An original illustration of a stylised figure seen from below, looking towering with the ceiling visible behind their head.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "eye-level",
      "text": "Eye-level"
    },
    {
      "id": "low-angle",
      "text": "Low angle"
    },
    {
      "id": "high-angle",
      "text": "High angle"
    },
    {
      "id": "dutch",
      "text": "Dutch angle"
    }
  ],
  "correctOptionId": "low-angle",
  "explanation": {
    "correct": "The camera looks up at the figure, so they seem powerful or imposing. A high angle does the opposite.",
    "incorrect": "The camera sits below the subject looking up: a low angle. It makes people loom. A high angle makes them seem small.",
    "sayThisLine": "Shot from a low angle, he looks huge."
  },
  "cues": [
    "Ceiling visible",
    "Subject looms",
    "Camera near the floor"
  ]
}
```

### 2.6 `decision-scenario`

Judgment: picking a movie for her, spoiler etiquette, honest opinions, how to enter a franchise, whether to watch subtitled or dubbed. `expertNote` shows what an experienced friend weighs; never coaches deception. No `safetyNote` needed (not a safety-critical course).

**Sample 1** (lesson `cl-02`)

```json
{
  "prompt": "Picking a movie for her tonight.",
  "situation": {
    "narrative": "She wants to watch something together but has not said what.",
    "facts": [
      {
        "label": "Her recent mood",
        "value": "Loves slow, moody dramas"
      },
      {
        "label": "Time available",
        "value": "About two hours"
      },
      {
        "label": "Setting",
        "value": "Relaxed night in"
      },
      {
        "label": "What you know",
        "value": "She mentioned a favourite director once"
      }
    ]
  },
  "options": [
    {
      "id": "ask-mood",
      "label": "Ask what mood she is in and offer two options",
      "verdict": "best",
      "consequence": "She picks one and feels heard. You learn her taste.",
      "considerations": [
        "Curiosity beats guessing",
        "Two options is easier than an open question"
      ]
    },
    {
      "id": "her-director",
      "label": "Suggest something by her favourite director",
      "verdict": "acceptable",
      "consequence": "She lights up, though she may have seen it. It shows you listened.",
      "considerations": [
        "Shows attention",
        "She may have seen it already"
      ]
    },
    {
      "id": "loud-sequel",
      "label": "Pick a loud franchise sequel you like",
      "verdict": "poor",
      "consequence": "It ignores what she told you, and the mood drops.",
      "considerations": [
        "Picks your taste over hers",
        "Does not match the mood"
      ]
    }
  ],
  "expertNote": "Good recommenders ask about the mood, not the genre, and offer a small choice rather than a lecture.",
  "sayThisLine": "What are you in the mood for: something slow and moody, or something lighter?"
}
```

**Sample 2** (lesson `sg-08`)

```json
{
  "prompt": "She is halfway through a movie you have seen.",
  "situation": {
    "narrative": "You know a twist that changes everything. She is enjoying it.",
    "facts": [
      {
        "label": "Your status",
        "value": "You have seen it"
      },
      {
        "label": "Her status",
        "value": "Halfway through"
      },
      {
        "label": "The twist",
        "value": "Big and unexpected"
      },
      {
        "label": "Her reaction so far",
        "value": "Very engaged"
      }
    ]
  },
  "options": [
    {
      "id": "stay-quiet",
      "label": "Stay quiet and ask what she thinks so far",
      "verdict": "best",
      "consequence": "She keeps the surprise and enjoys sharing her guesses.",
      "considerations": [
        "Spoilers cannot be undone",
        "Her guesses are part of the fun"
      ]
    },
    {
      "id": "hint",
      "label": "Hint that something big is coming",
      "verdict": "poor",
      "consequence": "Even a hint changes how she watches. It can feel like a spoiler.",
      "considerations": [
        "Hints raise expectations",
        "You cannot un-say it"
      ]
    },
    {
      "id": "reveal",
      "label": "Say the twist so you can talk about it",
      "verdict": "poor",
      "consequence": "You ruined it. She will remember.",
      "considerations": [
        "Spoils her first viewing"
      ]
    }
  ],
  "expertNote": "Fans protect the first viewing. Save the discussion until she is done, then ask about her reaction.",
  "sayThisLine": "No spoilers. Tell me when you finish, I have so many questions."
}
```

**Sample 3** (lesson `ct-07`)

```json
{
  "prompt": "She loves a film you found boring.",
  "situation": {
    "narrative": "She just finished raving about her favourite film. You watched it once and did not connect.",
    "facts": [
      {
        "label": "Her feeling",
        "value": "Very passionate"
      },
      {
        "label": "Your honest reaction",
        "value": "Did not connect"
      },
      {
        "label": "Goal",
        "value": "Understand why she loves it"
      }
    ]
  },
  "options": [
    {
      "id": "ask-why",
      "label": "Say it did not grab you but ask what she loves about it",
      "verdict": "best",
      "consequence": "She explains, and you learn what she values in films.",
      "considerations": [
        "Honest without dismissing",
        "Curiosity invites her to share"
      ]
    },
    {
      "id": "fake",
      "label": "Pretend you loved it too",
      "verdict": "poor",
      "consequence": "You are stuck, and a good follow-up question would expose you.",
      "considerations": [
        "Fake love is easy to catch",
        "It closes off real conversation"
      ]
    },
    {
      "id": "dismiss",
      "label": "Say it is overrated",
      "verdict": "poor",
      "consequence": "She feels dismissed and the conversation cools.",
      "considerations": [
        "Judges her taste",
        "Ends the conversation"
      ]
    }
  ],
  "expertNote": "You are allowed to not love it. What matters is asking what she sees, not scoring her taste.",
  "sayThisLine": "It did not click for me, but I want to know what you see in it."
}
```

### 2.7 `say-this`

Decode what she just said: cinephile slang, format talk, awards talk, director shorthand. Each item carries a `noFakeExpertNote` and follow-ups that are honest curiosity.

**Sample 1** (lesson `ct-04`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "It is a slow burn, but the payoff is unreal."
  },
  "options": [
    {
      "id": "a",
      "text": "Pacing is deliberate, tension builds gradually",
      "explanation": "That is what a slow burn is.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The ending rewards the patience",
      "explanation": "Payoff is the reward at the end.",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "It has very little dialogue",
      "explanation": "A slow burn can have plenty of dialogue.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "It was low budget",
      "explanation": "Pace is not about budget.",
      "isCorrect": false
    }
  ],
  "translation": "It takes its time and builds tension slowly, but the ending makes the wait worth it.",
  "followUps": [
    {
      "line": "What made you stay with the slow part?",
      "why": "Invites her to describe what held her attention."
    },
    {
      "line": "Was the payoff a twist or more of an emotional one?",
      "why": "Shows you know payoff has different kinds."
    }
  ],
  "noFakeExpertNote": "You do not need to have seen it. Ask what kept her hooked."
}
```

**Sample 2** (lesson `fd-01`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "I saw it on 70mm and it ruined every other screen for me."
  },
  "options": [
    {
      "id": "a",
      "text": "Screened from a large-format film print",
      "explanation": "70mm is a physical film format.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The picture was bigger and sharper than usual",
      "explanation": "That is why fans love it.",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "It was in 3D",
      "explanation": "70mm is not 3D.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "It ran for 70 minutes",
      "explanation": "The 70 refers to film width in millimetres.",
      "isCorrect": false
    }
  ],
  "translation": "She watched it projected from wide 70-millimetre film, and it looked so good that normal cinemas now feel disappointing.",
  "followUps": [
    {
      "line": "What was the biggest difference you noticed?",
      "why": "Asks about her experience instead of quizzing."
    },
    {
      "line": "Was it worth travelling for?",
      "why": "Acknowledges that 70mm screenings are rare."
    }
  ],
  "noFakeExpertNote": "Ask what she saw. Do not claim you can tell 70mm from digital."
}
```

**Sample 3** (lesson `mc-08`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "The sound mix was so bad I turned on subtitles."
  },
  "options": [
    {
      "id": "a",
      "text": "Dialogue was hard to hear over music or effects",
      "explanation": "That is a classic mix complaint.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "How sounds are balanced together is called the mix",
      "explanation": "The mix is dialogue, music and effects.",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "The subtitles were wrong",
      "explanation": "She used subtitles to compensate.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "The film was in another language",
      "explanation": "She is talking about English dialogue being drowned out.",
      "isCorrect": false
    }
  ],
  "translation": "The music and effects drowned out the speech, so she needed subtitles to follow the dialogue.",
  "followUps": [
    {
      "line": "Was that at home or in a cinema?",
      "why": "Speakers matter, so it shows you know context helps."
    },
    {
      "line": "Do you turn subtitles on for most things now?",
      "why": "A friendly question about a common habit."
    }
  ],
  "noFakeExpertNote": "You do not need to know sound engineering. Ask where she watched."
}
```

**Sample 4** (lesson `dr-02`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "Very Wes Anderson. I mean that as a compliment."
  },
  "options": [
    {
      "id": "a",
      "text": "The style resembles his signature look",
      "explanation": "Symmetry, pastel colours, deadpan staging.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Directors have recognisable styles",
      "explanation": "That is the idea behind auteur talk.",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "Anderson directed the film",
      "explanation": "She may be describing a film in his style by someone else.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "It is a parody of his film",
      "explanation": "A compliment about style, not a parody.",
      "isCorrect": false
    }
  ],
  "translation": "The film has a look and feel that reminds her of Wes Anderson: tidy symmetrical framing, pastel palette and a dry, deadpan tone.",
  "followUps": [
    {
      "line": "Is that the symmetry, the colours or the deadpan?",
      "why": "Shows you know what those three things are."
    },
    {
      "line": "Do you have a favourite of his?",
      "why": "An easy, honest opening."
    }
  ],
  "noFakeExpertNote": "Ask which of his habits she means rather than pretending to know his filmography."
}
```

**Sample 5** (lesson `aw-07`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "She got snubbed for Best Director. Absolutely criminal."
  },
  "options": [
    {
      "id": "a",
      "text": "She was not nominated when many expected it",
      "explanation": "That is what snubbed means.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "Nominations are chosen by each branch, so directors chose the directors",
      "explanation": "True for nominations.",
      "isCorrect": true
    },
    {
      "id": "c",
      "text": "She lost at the ceremony",
      "explanation": "Losing is not a snub; a snub is no nomination.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "She was disqualified",
      "explanation": "Disqualification is different.",
      "isCorrect": false
    }
  ],
  "translation": "The director was not nominated despite expectations, and Maya thinks that is unfair.",
  "followUps": [
    {
      "line": "Who got in instead that annoyed you?",
      "why": "Invites her opinion."
    },
    {
      "line": "Do you think the film still did well elsewhere?",
      "why": "Moves the conversation forward."
    }
  ],
  "noFakeExpertNote": "You do not need to know the nominees. Ask about her view."
}
```

### 2.8 `fill-the-gap`

Vocabulary in context; quick review card and Daily Bite.

**Sample 1** (lesson `mk-02`)

```json
{
  "prompt": "Fill in who does what.",
  "template": "The {{a}} designs the sets, while the {{b}} shoots them.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "production designer",
        "editor",
        "composer"
      ],
      "correct": "production designer"
    },
    {
      "id": "b",
      "options": [
        "cinematographer",
        "producer",
        "screenwriter"
      ],
      "correct": "cinematographer"
    }
  ],
  "explanation": {
    "correct": "Production designers build the look of the world; cinematographers photograph it. They work together with the director.",
    "incorrect": "The production designer designs the sets, and the cinematographer shoots them. Editors and composers work on other parts of the film."
  }
}
```

**Sample 2** (lesson `mc-07`)

```json
{
  "prompt": "Score or needle drop?",
  "template": "Music composed for the film is the {{a}}; a pop song placed in a scene is a {{b}}.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "score",
        "soundtrack album",
        "Foley"
      ],
      "correct": "score"
    },
    {
      "id": "b",
      "options": [
        "needle drop",
        "leitmotif",
        "ADR"
      ],
      "correct": "needle drop"
    }
  ],
  "explanation": {
    "correct": "The score is original music written for the film. A needle drop is an existing song dropped into a scene, like a well-known track over a chase.",
    "incorrect": "The score is the composed music; a needle drop is an existing song used in a scene. A soundtrack album can contain both."
  }
}
```

**Sample 3** (lesson `mk-06`)

```json
{
  "prompt": "How do you read box office?",
  "template": "Opening weekend is one number; {{a}} shows how a film holds week after week.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "legs",
        "runtime",
        "aspect ratio"
      ],
      "correct": "legs"
    }
  ],
  "explanation": {
    "correct": "Legs is how well a film keeps earning after opening. A film with legs drops less each weekend, often from word of mouth.",
    "incorrect": "The word you want is legs. Runtime and aspect ratio describe the film, not its box office performance."
  }
}
```

**Sample 4** (lesson `sg-03`)

```json
{
  "prompt": "Name the storytelling device.",
  "template": "A narrator you cannot fully trust is an {{a}} narrator.",
  "gaps": [
    {
      "id": "a",
      "options": [
        "unreliable",
        "omniscient",
        "diegetic"
      ],
      "correct": "unreliable"
    }
  ],
  "explanation": {
    "correct": "An unreliable narrator may lie, misremember or hide something, so the audience has to question the story.",
    "incorrect": "An unreliable narrator cannot be fully trusted. An omniscient narrator knows everything, and diegetic refers to sound."
  }
}
```

### 2.9 `listening-id`

Film sound recognition with **original or synthesised audio only** (diegetic vs non-diegetic, leitmotif, Foley, silence, mix). Never a real film score, dialogue or needle drop. `audio.description` is always provided; a Skip is always available.

**Sample 1** (lesson `mc-07`)

```json
{
  "prompt": "Can the characters hear this sound?",
  "audio": {
    "asset": "movies/audio/diegetic-radio-door.wav",
    "durationMs": 6000,
    "license": "original-swoond",
    "description": "A small radio playing muffled jazz in another room, footsteps, then a door closing, all recorded to sound like they are in the space.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "diegetic",
      "text": "Yes, diegetic: it is in the scene",
      "explanation": "A radio, footsteps and a door all belong to the scene."
    },
    {
      "id": "non-diegetic",
      "text": "No, non-diegetic: added for the audience"
    }
  ],
  "correctOptionId": "diegetic",
  "explanation": {
    "correct": "The radio, footsteps and door come from inside the scene, so the characters would hear them. That is diegetic sound. A score laid over the top would be non-diegetic.",
    "incorrect": "These sounds come from inside the scene, so the characters could hear them: diegetic. Non-diegetic sound, like a score, is only for the audience.",
    "sayThisLine": "Was that music coming from a radio in the room, or just for us?"
  },
  "listenFor": [
    "Muffled radio suggests another room",
    "Footsteps match the space",
    "Door closes with room echo"
  ]
}
```

**Sample 2** (lesson `mc-08`)

```json
{
  "prompt": "What is the musical device in this clip?",
  "audio": {
    "asset": "movies/audio/leitmotif-four-note.wav",
    "durationMs": 9000,
    "license": "original-swoond",
    "description": "A four-note phrase on cello, then the same four notes on high flute, then the same phrase slowed and quiet on low strings.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "leitmotif",
      "text": "Leitmotif",
      "explanation": "A theme tied to a person, place or idea."
    },
    {
      "id": "needle-drop",
      "text": "Needle drop"
    },
    {
      "id": "foley",
      "text": "Foley"
    }
  ],
  "correctOptionId": "leitmotif",
  "explanation": {
    "correct": "The same short theme returns in different clothes. When it comes back low and slow, it can signal danger or sadness. Composers use leitmotifs to tie a character or idea to a sound.",
    "incorrect": "A short theme that returns in different forms is a leitmotif. A needle drop is an existing pop song, and Foley is recreated everyday sound.",
    "sayThisLine": "That theme keeps coming back, it is like the character is following us."
  },
  "listenFor": [
    "Same four notes each time",
    "Different instruments",
    "Slower and quieter the third time"
  ]
}
```

**Sample 3** (lesson `mc-07`)

```json
{
  "prompt": "How were these sounds most likely made?",
  "audio": {
    "asset": "movies/audio/foley-footsteps-leather.wav",
    "durationMs": 5000,
    "license": "original-swoond",
    "description": "Crisp footsteps on gravel and the creak of leather, very clean and close, with no room noise.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "foley",
      "text": "Foley: recreated in a studio",
      "explanation": "Very clean, close sounds are a Foley giveaway."
    },
    {
      "id": "location",
      "text": "Captured on set during the take"
    },
    {
      "id": "score",
      "text": "Composed as part of the score"
    }
  ],
  "correctOptionId": "foley",
  "explanation": {
    "correct": "Clean, close, controlled sounds like these are usually Foley: a Foley artist performs footsteps and props to picture in a studio. Set audio is rarely this tidy.",
    "incorrect": "Very clean and close sounds with no room noise are typical of Foley, performed and recorded in a studio after filming.",
    "sayThisLine": "The Foley work in that scene is incredible, every footstep is perfect."
  },
  "listenFor": [
    "Clean, close sound",
    "No room ambience",
    "Perfectly in step with the picture"
  ]
}
```

### 2.10 `estimate-slider`

Magnitudes: runtime, aspect ratio, average shot length, number of nominees, budget tiers, box-office multiples.

**Sample 1** (lesson `mk-01`)

```json
{
  "prompt": "Typical feature film length, in minutes?",
  "unit": "min",
  "min": 60,
  "max": 240,
  "step": 5,
  "correctValue": 105,
  "tolerance": {
    "full": 15,
    "partial": 30
  },
  "explanation": {
    "correct": "Most features run around an hour and forty-five minutes, with epics pushing past three hours. Runtimes have crept up in recent years.",
    "incorrect": "Most features are about 90 to 120 minutes. Epics run longer, and runtimes have been creeping up.",
    "sayThisLine": "It is nearly three hours. That is a commitment."
  }
}
```

**Sample 2** (lesson `fr-05`)

```json
{
  "prompt": "How wide is a scope frame compared to its height?",
  "unit": ":1",
  "min": 1,
  "max": 3,
  "step": 0.01,
  "correctValue": 2.39,
  "tolerance": {
    "full": 0.1,
    "partial": 0.3
  },
  "explanation": {
    "correct": "Scope is about 2.39 times wider than it is tall. Standard widescreen is about 1.85, and old academy ratio was 1.37.",
    "incorrect": "Scope is roughly 2.39:1. Standard widescreen is 1.85:1, and the old boxy ratio was closer to 1.33:1.",
    "sayThisLine": "Scope makes landscapes feel huge."
  }
}
```

**Sample 3** (lesson `mc-06`)

```json
{
  "prompt": "Average seconds between cuts in a modern action film?",
  "unit": "s",
  "min": 1,
  "max": 15,
  "step": 0.5,
  "correctValue": 3,
  "tolerance": {
    "full": 1,
    "partial": 2
  },
  "explanation": {
    "correct": "Modern action films often cut every two to four seconds. Classic films and long takes hold far longer. That measure is called average shot length, or ASL.",
    "incorrect": "Action films tend to average around three seconds a shot. Slow cinema can average ten seconds or more.",
    "sayThisLine": "The editing is so fast I could barely follow it."
  }
}
```

**Sample 4** (lesson `aw-03`)

```json
{
  "prompt": "Maximum number of Best Picture nominees?",
  "unit": "films",
  "min": 3,
  "max": 15,
  "step": 1,
  "correctValue": 10,
  "tolerance": {
    "full": 0,
    "partial": 2
  },
  "explanation": {
    "correct": "Up to ten. The Academy fixed the field at ten in 2009 and, since 2011, allows between five and ten depending on votes.",
    "incorrect": "The category can have up to ten nominees. Since 2011 the count varies between five and ten depending on the voting.",
    "sayThisLine": "They can nominate up to ten films for Best Picture."
  }
}
```

### 2.11 `hotspot-tap`

Static diagrams: rule-of-thirds power points, axis-line sides, three-point lighting, the parts of a call sheet. Diagram ids are procedural (`original-swoond`); movement questions belong to the Unity sims.

**Sample 1** (lesson `fr-03`)

```json
{
  "prompt": "Tap a rule-of-thirds power point.",
  "diagram": {
    "diagramId": "thirds-grid-frame",
    "aspectRatio": 1.78,
    "alt": "A widescreen frame divided by two vertical and two horizontal lines into nine equal boxes, with a small figure standing near the left third."
  },
  "hotspots": [
    {
      "id": "pp-tl",
      "label": "Upper left intersection",
      "shape": {
        "kind": "circle",
        "cx": 0.333,
        "cy": 0.333,
        "r": 0.06
      }
    },
    {
      "id": "pp-tr",
      "label": "Upper right intersection",
      "shape": {
        "kind": "circle",
        "cx": 0.667,
        "cy": 0.333,
        "r": 0.06
      }
    },
    {
      "id": "pp-bl",
      "label": "Lower left intersection",
      "shape": {
        "kind": "circle",
        "cx": 0.333,
        "cy": 0.667,
        "r": 0.06
      }
    },
    {
      "id": "pp-br",
      "label": "Lower right intersection",
      "shape": {
        "kind": "circle",
        "cx": 0.667,
        "cy": 0.667,
        "r": 0.06
      }
    },
    {
      "id": "centre",
      "label": "Centre of frame",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.07
      }
    }
  ],
  "correctHotspotIds": [
    "pp-tl",
    "pp-tr",
    "pp-bl",
    "pp-br"
  ],
  "explanation": {
    "correct": "The four spots where the third-lines cross are the power points. Putting a subject or eyes on one feels balanced and dynamic, unlike dead centre.",
    "incorrect": "The power points are where the vertical and horizontal third-lines cross. The centre of the frame is not one.",
    "sayThisLine": "Her face sits right on a third, that is why it feels balanced."
  }
}
```

**Sample 2** (lesson `mc-04`)

```json
{
  "prompt": "Tap the side of the line camera 2 must stay on.",
  "diagram": {
    "diagramId": "camera-axis-topdown",
    "aspectRatio": 1,
    "alt": "Top-down room. Two people face each other along a horizontal dashed line. Camera 1 is below the line. The upper and lower halves of the room are tappable."
  },
  "hotspots": [
    {
      "id": "above",
      "label": "Above the line",
      "shape": {
        "kind": "rect",
        "x": 0,
        "y": 0,
        "w": 1,
        "h": 0.48
      }
    },
    {
      "id": "below",
      "label": "Below the line, same side as camera 1",
      "shape": {
        "kind": "rect",
        "x": 0,
        "y": 0.52,
        "w": 1,
        "h": 0.48
      }
    }
  ],
  "correctHotspotIds": [
    "below"
  ],
  "explanation": {
    "correct": "Camera 1 is below the line, so camera 2 should stay below it. Cutting between cameras on the same side keeps left and right consistent.",
    "incorrect": "Camera 2 should stay on the same side of the line as camera 1. Crossing the line flips who is on the left and right of the screen.",
    "sayThisLine": "They kept the cameras on one side, so it never confuses me."
  }
}
```

**Sample 3** (lesson `fr-06`)

```json
{
  "prompt": "Tap the key light.",
  "diagram": {
    "diagramId": "three-point-light-topdown",
    "aspectRatio": 1,
    "alt": "Top-down diagram of a person facing the camera, with three lights: one close and bright at forty-five degrees to one side of the camera, one softer on the other side, and one behind the person."
  },
  "hotspots": [
    {
      "id": "key",
      "label": "Bright light at forty-five degrees near the camera",
      "shape": {
        "kind": "circle",
        "cx": 0.25,
        "cy": 0.75,
        "r": 0.09
      }
    },
    {
      "id": "fill",
      "label": "Soft light on the opposite side",
      "shape": {
        "kind": "circle",
        "cx": 0.75,
        "cy": 0.75,
        "r": 0.09
      }
    },
    {
      "id": "back",
      "label": "Light behind the subject",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.15,
        "r": 0.09
      }
    }
  ],
  "correctHotspotIds": [
    "key"
  ],
  "explanation": {
    "correct": "The key light is the main, brightest light, usually angled about forty-five degrees. The fill softens the shadows and the backlight separates the subject from the background.",
    "incorrect": "The key light is the brightest, main light near the camera at an angle. The fill is softer, and the backlight sits behind the subject.",
    "sayThisLine": "The key light is angled from the side, that is why half her face glows."
  }
}
```

### 2.12 `talk-track`

See section 4: ten full scenarios, each a valid `talk-track` payload.

## 3. Playbook terms (72)

Definition plus an example line in the enthusiast's voice. Concept ids are assigned when the curriculum JSON is authored.

| # | Term | Definition | Example line |
|---|---|---|---|
| 1 | Above the line | Creative and key costs paid before shooting (director, stars, writers); "below the line" is the crew. | "Their above-the-line costs were huge but the crew was tiny." |
| 2 | ADR | Dialogue re-recorded in a studio after filming. | "They had to ADR half the film because of the wind." |
| 3 | Aspect ratio | The width of a frame compared to its height. | "That wide aspect ratio makes every landscape feel enormous." |
| 4 | Auteur | A director whose personal style is visible across their films. | "He is a real auteur, you always know it is his." |
| 5 | Average shot length (ASL) | How many seconds shots last on average. | "The ASL is so low I felt dizzy." |
| 6 | Blocking | How actors and camera move through a scene. | "The blocking in that argument was brilliant." |
| 7 | Box office | Ticket sales, split into opening weekend, domestic and worldwide. | "It made a fortune at the box office." |
| 8 | Cinematographer | The person who leads the camera and lighting, also called the DP. | "The cinematographer shot it all in natural light." |
| 9 | CinemaScore | A grade from opening-night audiences. | "It got an A-minus CinemaScore, so word of mouth is good." |
| 10 | Close-up | A shot framed on the face. | "That close-up was the whole movie." |
| 11 | Colour grading | Adjusting the colour and contrast of the finished picture. | "The colour grading is so teal and orange." |
| 12 | Continuity editing | Cutting so space and time feel smooth and clear. | "The continuity editing is invisible, and that is the point." |
| 13 | Criterion Collection | A home-video label that releases restored classics. | "I am saving up for the Criterion of that one." |
| 14 | Cross-cutting | Alternating between scenes happening at the same time. | "The cross-cutting in the finale built such tension." |
| 15 | Cult classic | A film with a devoted following, often after a quiet release. | "It flopped, but it is a cult classic now." |
| 16 | Cut | A transition from one shot directly to another. | "There is a cut at just the right second." |
| 17 | Cutting on action | Cutting in the middle of a movement so the edit is hidden. | "They cut on action so smoothly you never see it." |
| 18 | Dark comedy | Comedy about dark or serious topics. | "It is a dark comedy about a funeral." |
| 19 | Depth of field | How much of the picture, near to far, is in focus. | "The shallow depth of field isolates her." |
| 20 | Diegetic sound | Sound the characters can hear. | "It is diegetic: the song is on the radio in the car." |
| 21 | Director's cut | A version closer to the director's preferred edit. | "The director's cut adds twenty minutes and fixes the ending." |
| 22 | Dolly zoom | A move where the camera travels one way as the lens zooms the other. | "That Vertigo effect, the dolly zoom, made my stomach drop." |
| 23 | Dutch angle | A tilted camera that makes the frame feel off. | "They used a Dutch angle when things start to go wrong." |
| 24 | Establishing shot | A wide shot that shows where a scene takes place. | "The establishing shot of the city set the mood." |
| 25 | Eyeline match | A cut that shows what a character is looking at. | "The eyeline match tells you what she is seeing." |
| 26 | For your consideration (FYC) | An awards campaign ad or screening asking voters to consider a film. | "There are FYC billboards everywhere this month." |
| 27 | Film noir | A style of moody crime films with shadows and cynicism. | "It is a modern film noir in every way." |
| 28 | Foley | Everyday sounds made in a studio to match the picture. | "The Foley is incredible: every footstep." |
| 29 | Franchise | A series of related films built on shared characters or worlds. | "It is the tenth film in the franchise." |
| 30 | Genre | A category of films sharing conventions. | "It plays with the genre in a clever way." |
| 31 | Handheld | A camera held by the operator, giving a shaky, immediate feel. | "The handheld camera makes it feel like a documentary." |
| 32 | High-key lighting | Bright, even light with few shadows. | "The high-key lighting makes it feel like a sitcom." |
| 33 | Jump cut | A cut between similar angles that makes the action jump. | "The jump cuts made it feel restless and modern." |
| 34 | Legs | A film's ability to keep earning week after week. | "It opened small but has amazing legs." |
| 35 | Leitmotif | A recurring musical theme tied to a character or idea. | "That leitmotif shows up every time he appears." |
| 36 | Letterboxd | A social diary site where fans log and rate films. | "I logged it on Letterboxd right after." |
| 37 | Long take | A shot that runs a long time without a cut. | "The long take at the end had me holding my breath." |
| 38 | Low-key lighting | High-contrast light with deep shadows. | "The low-key lighting makes everything tense." |
| 39 | MacGuffin | An object or goal that drives the plot but matters little itself. | "The briefcase is just a MacGuffin." |
| 40 | Match cut | A cut that links two shots by a matching shape or motion. | "That match cut from the bone to the spaceship is famous." |
| 41 | Metacritic | A site that turns critics' reviews into a weighted average score. | "Its Metascore is 82." |
| 42 | Method acting | An approach where actors draw on deep personal experience. | "He stayed in character for the whole shoot, very method." |
| 43 | Mise-en-scene | Everything placed in the frame: sets, costumes, light, actors. | "The mise-en-scene tells you who these people are." |
| 44 | Montage | A sequence of short shots that condenses time or builds an idea. | "The training montage got me every time." |
| 45 | Needle drop | An existing song placed in a scene. | "That needle drop was perfect." |
| 46 | New Hollywood | American films of about 1967 to 1980 led by directors. | "She is obsessed with New Hollywood." |
| 47 | Non-diegetic sound | Sound only the audience hears, like a score. | "The strings are non-diegetic." |
| 48 | Oscar bait | Films seemingly made to win awards. | "It feels like total Oscar bait." |
| 49 | Opening weekend | A film's box-office total in its first three days. | "It broke opening-weekend records." |
| 50 | Palme d'Or | The top prize at the Cannes Film Festival. | "It won the Palme d'Or." |
| 51 | Pan | A camera turning left or right without moving position. | "There is a slow pan across the room." |
| 52 | Practical effects | Effects made physically on set, not by computer. | "It is all practical effects, which I love." |
| 53 | Precursor awards | Earlier awards that hint at the Oscar frontrunners. | "She tracks all the precursors." |
| 54 | Preferential ballot | A ranked-choice vote used for Best Picture. | "Best Picture is a preferential ballot." |
| 55 | Production designer | The person who designs the film's sets and overall look. | "The production designer built an entire town." |
| 56 | Reboot | A restart of a franchise ignoring earlier continuity. | "They rebooted it with a new cast." |
| 57 | Remake | A new version of an earlier film. | "The remake is nearly shot for shot." |
| 58 | Repertory cinema | A theatre that shows older and classic films. | "There is a repertory cinema showing it on 35mm." |
| 59 | Rule of thirds | Composing by placing subjects on a three-by-three grid. | "The rule of thirds makes the frame feel balanced." |
| 60 | Score | The original music composed for a film. | "The score is haunting." |
| 61 | Shot / reverse shot | Alternating shots of two people in conversation. | "It is mostly shot and reverse shot." |
| 62 | Slow burn | A film that builds tension gradually. | "It is a slow burn, but so worth it." |
| 63 | Snub | When an expected nominee is not nominated. | "That was the snub of the year." |
| 64 | Steadicam | A stabiliser that gives smooth handheld-style motion. | "The Steadicam follows him through the whole hotel." |
| 65 | Streamer | A company that releases films on a streaming service. | "It went straight to a streamer." |
| 66 | Tentpole | A big-budget film a studio relies on for its year. | "That summer tentpole carries the studio." |
| 67 | Three-act structure | Setup, confrontation, resolution. | "The third act falls apart." |
| 68 | Tomatometer | The percent of critics giving a positive review. | "It has a Tomatometer of 91 percent." |
| 69 | Tracking shot | A camera that moves with or alongside the action. | "The tracking shot follows them down the street." |
| 70 | Unreliable narrator | A narrator whose account cannot be fully trusted. | "He is an unreliable narrator." |
| 71 | Wide shot | A shot showing the full scene, subjects small in the frame. | "The wide shot shows how alone she is." |
| 72 | 180-degree rule | Keep cameras on one side of the line between two subjects. | "They broke the 180-degree rule on purpose there." |

## 4. Talk Track scenarios (10)

Each scenario: her line, what it means, the terms implied, then the payload (replies are good / meh / cringe by `smoothDelta` with a coach note). Replies model honest curiosity, never bluffing.

### 4.1 After the movie (`tt-slow-burn`)

- **She says:** "It is a slow burn, but the payoff is unreal. Did you love it?"
- **Meaning:** She is asking whether you connected with a deliberately paced film.
- **Terms implied:** slow burn, payoff, pacing
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "After the movie",
  "setting": "Sitting together as the credits roll.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Okay so that was a slow burn, right? Did you love it?",
      "replies": [
        {
          "id": "good",
          "text": "Slow, but I was hooked. What worked for you?",
          "smoothDelta": 22,
          "theirResponse": "Right?! The quiet middle is what makes the ending hit.",
          "coachNote": "Honest and curious. She gets to explain."
        },
        {
          "id": "meh",
          "text": "It was pretty good.",
          "smoothDelta": 2,
          "theirResponse": "Cool. Good.",
          "coachNote": "Safe, but nothing to build on."
        },
        {
          "id": "cringe",
          "text": "Honestly it dragged. Nothing happened.",
          "smoothDelta": -12,
          "theirResponse": "Oh. It is deliberate.",
          "coachNote": "Dismissing the pacing is dismissing her taste."
        }
      ]
    },
    {
      "theirMessage": "That last shot though. Did it get you?",
      "replies": [
        {
          "id": "good",
          "text": "I did not expect it. Was it always going to end that way?",
          "smoothDelta": 20,
          "theirResponse": "It is set up from the first scene. Watch for it next time.",
          "coachNote": "Admits surprise and asks a real question."
        },
        {
          "id": "meh",
          "text": "Yeah.",
          "smoothDelta": 0,
          "theirResponse": "Same.",
          "coachNote": "A nod, no follow-up."
        },
        {
          "id": "cringe",
          "text": "Spoiler: I called it in minute ten.",
          "smoothDelta": -8,
          "theirResponse": "Okay, sure.",
          "coachNote": "Bragging kills the mood. Ask instead."
        }
      ]
    }
  ],
  "closingNote": "Ask what kept her hooked. She enjoys explaining. You are not being tested."
}
```

### 4.2 The look (`tt-cinematography`)

- **She says:** "The cinematography was unreal. I could screenshot every frame."
- **Meaning:** She loved how the film was photographed: light, colour and framing.
- **Terms implied:** cinematography, framing, colour
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "The look",
  "setting": "Texting after she watched a film.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "The cinematography was unreal. I could screenshot every frame.",
      "replies": [
        {
          "id": "good",
          "text": "Was it the light, the colour or the framing that got you?",
          "smoothDelta": 22,
          "theirResponse": "The light. It looked like painted afternoons.",
          "coachNote": "Shows you know cinematography has parts."
        },
        {
          "id": "meh",
          "text": "Nice! Was it a good story too?",
          "smoothDelta": 4,
          "theirResponse": "Yeah, but the visuals carried it for me.",
          "coachNote": "Fine, but it changes the subject."
        },
        {
          "id": "cringe",
          "text": "The camera guy did a great job.",
          "smoothDelta": -10,
          "theirResponse": "The cinematographer, haha. But yes.",
          "coachNote": "Say cinematographer or just \"the photography\"."
        }
      ]
    },
    {
      "theirMessage": "Sorry, I am a nerd about this. I always check who shot it.",
      "replies": [
        {
          "id": "good",
          "text": "Never sorry. Who was it? I want to look up what else they shot.",
          "smoothDelta": 24,
          "theirResponse": "I will send you a list. You will love it.",
          "coachNote": "Turns her interest into a shared plan."
        },
        {
          "id": "meh",
          "text": "Ha, okay.",
          "smoothDelta": 0,
          "theirResponse": "Yeah...",
          "coachNote": "Reads as disinterest."
        },
        {
          "id": "cringe",
          "text": "I only notice the actors.",
          "smoothDelta": -6,
          "theirResponse": "That is fair, I guess.",
          "coachNote": "Honest but deflating. Be curious."
        }
      ]
    }
  ],
  "closingNote": "The credits are a treasure map. Ask who shot it, then look for their other work."
}
```

### 4.3 The snub (`tt-snub`)

- **She says:** "She got snubbed for Best Director. Criminal."
- **Meaning:** A director she expected to be nominated was not.
- **Terms implied:** snub, nominations, branch
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "The snub",
  "setting": "Nominations morning, group chat.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Nominations are out and she got snubbed for Best Director. Criminal.",
      "replies": [
        {
          "id": "good",
          "text": "That stings. Who got in instead?",
          "smoothDelta": 20,
          "theirResponse": "Five names I could recite, but not hers. Ugh.",
          "coachNote": "Sympathetic and curious."
        },
        {
          "id": "meh",
          "text": "Oh no. Who is she again?",
          "smoothDelta": 5,
          "theirResponse": "The one who made the movie we saw at Christmas!",
          "coachNote": "Honest, but you can save the question for later."
        },
        {
          "id": "cringe",
          "text": "It is just the Oscars, who cares.",
          "smoothDelta": -14,
          "theirResponse": "I do, actually.",
          "coachNote": "Never dismiss something she cares about."
        }
      ]
    },
    {
      "theirMessage": "And the directors branch votes on that one. Do you know how nominations work?",
      "replies": [
        {
          "id": "good",
          "text": "Not really. Do directors nominate directors?",
          "smoothDelta": 22,
          "theirResponse": "Exactly. Each branch nominates its own category. That is why it stings.",
          "coachNote": "Admitting a gap invites her to teach."
        },
        {
          "id": "meh",
          "text": "Sort of.",
          "smoothDelta": 0,
          "theirResponse": "Okay. I will explain later.",
          "coachNote": "Vague."
        },
        {
          "id": "cringe",
          "text": "Yes, everyone votes on everything.",
          "smoothDelta": -12,
          "theirResponse": "No, it is more complicated.",
          "coachNote": "Do not bluff. Say you are not sure."
        }
      ]
    }
  ],
  "closingNote": "Nominations come from each branch; winners from everyone. That single fact wins conversations."
}
```

### 4.4 The rating (`tt-letterboxd`)

- **She says:** "I gave it 4.5 on Letterboxd. Is that harsh?"
- **Meaning:** She rates films on a five-star scale with half stars and is asking for your read.
- **Terms implied:** Letterboxd, star rating
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "The rating",
  "setting": "She shows you her phone.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I gave it 4.5 on Letterboxd. Is that harsh?",
      "replies": [
        {
          "id": "good",
          "text": "That sounds high! What pushed it to 4.5 and not 5?",
          "smoothDelta": 22,
          "theirResponse": "The last act is a bit messy but the first hour is perfect.",
          "coachNote": "Turns a number into a story."
        },
        {
          "id": "meh",
          "text": "Not sure, I do not use it.",
          "smoothDelta": 3,
          "theirResponse": "That is okay. It is basically a movie diary.",
          "coachNote": "Honest, but you can be curious too."
        },
        {
          "id": "cringe",
          "text": "That is a lot for a movie.",
          "smoothDelta": -8,
          "theirResponse": "A lot? Four and a half is a great movie.",
          "coachNote": "You misread the scale."
        }
      ]
    },
    {
      "theirMessage": "Do you rate movies at all?",
      "replies": [
        {
          "id": "good",
          "text": "Not really, but I would like to. How do you decide?",
          "smoothDelta": 22,
          "theirResponse": "I just ask how much I want to rewatch it.",
          "coachNote": "Asks for her method."
        },
        {
          "id": "meh",
          "text": "Nope.",
          "smoothDelta": 0,
          "theirResponse": "Fair.",
          "coachNote": "Dead end."
        },
        {
          "id": "cringe",
          "text": "Stars are pointless.",
          "smoothDelta": -12,
          "theirResponse": "It is just for me.",
          "coachNote": "Do not dismiss her ritual."
        }
      ]
    }
  ],
  "closingNote": "Four and a half out of five is a lot. Ask why, not how much."
}
```

### 4.5 The format (`tt-70mm`)

- **She says:** "I saw it on 70mm. It ruined every other screen for me."
- **Meaning:** She watched it in a large film format and now regular cinemas disappoint.
- **Terms implied:** 70mm, IMAX, film projection
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "The format",
  "setting": "She is back from a special screening.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I saw it on 70mm. It ruined every other screen for me.",
      "replies": [
        {
          "id": "good",
          "text": "That sounds special. What was different?",
          "smoothDelta": 22,
          "theirResponse": "It was sharper, deeper, and you could see the grain.",
          "coachNote": "Curiosity about her experience."
        },
        {
          "id": "meh",
          "text": "Cool. What is 70mm?",
          "smoothDelta": 6,
          "theirResponse": "Wide film. Big and sharp.",
          "coachNote": "Honest, fine."
        },
        {
          "id": "cringe",
          "text": "It is the same movie either way.",
          "smoothDelta": -12,
          "theirResponse": "Not the same experience.",
          "coachNote": "Format matters to fans."
        }
      ]
    },
    {
      "theirMessage": "Now I want to see everything on film.",
      "replies": [
        {
          "id": "good",
          "text": "Where do you find film screenings?",
          "smoothDelta": 20,
          "theirResponse": "Repertory cinemas and special events. I will show you.",
          "coachNote": "Opens a shared plan."
        },
        {
          "id": "meh",
          "text": "That sounds expensive.",
          "smoothDelta": -2,
          "theirResponse": "A little. Worth it, though.",
          "coachNote": "A downer."
        },
        {
          "id": "cringe",
          "text": "Streaming is basically the same.",
          "smoothDelta": -14,
          "theirResponse": "Not even close.",
          "coachNote": "Do not start a war."
        }
      ]
    }
  ],
  "closingNote": "Ask what looked different. You are not expected to tell 70mm from digital."
}
```

### 4.6 The director run (`tt-director-run`)

- **She says:** "I am doing a director run: every Kurosawa, in order."
- **Meaning:** She is watching a director's whole filmography chronologically.
- **Terms implied:** filmography, auteur, director run
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "The director run",
  "setting": "Her watchlist.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I am doing a director run: every Kurosawa, in order.",
      "replies": [
        {
          "id": "good",
          "text": "Love that. Which one made you want to keep going?",
          "smoothDelta": 22,
          "theirResponse": "One about a samurai and a bandit told four different ways. I am hooked.",
          "coachNote": "Curious about the hook."
        },
        {
          "id": "meh",
          "text": "That is a lot of movies.",
          "smoothDelta": 2,
          "theirResponse": "It is! About thirty.",
          "coachNote": "True, but low energy."
        },
        {
          "id": "cringe",
          "text": "Are they all in black and white?",
          "smoothDelta": -8,
          "theirResponse": "Many are, and they are gorgeous.",
          "coachNote": "Sounds like a barrier."
        }
      ]
    },
    {
      "theirMessage": "Want to watch one with me?",
      "replies": [
        {
          "id": "good",
          "text": "Yes. Which is best for a first one?",
          "smoothDelta": 24,
          "theirResponse": "Start here. It is thrilling, not homework.",
          "coachNote": "Accepts and asks for a starting point."
        },
        {
          "id": "meh",
          "text": "Maybe sometime.",
          "smoothDelta": -2,
          "theirResponse": "Okay...",
          "coachNote": "She offered. Take it."
        },
        {
          "id": "cringe",
          "text": "Subtitles though?",
          "smoothDelta": -10,
          "theirResponse": "Yes, you will forget in ten minutes.",
          "coachNote": "Do not lead with an objection."
        }
      ]
    }
  ],
  "closingNote": "When she offers to share, say yes and ask where to start."
}
```

### 4.7 The universe (`tt-franchise`)

- **She says:** "Have you seen the whole saga?"
- **Meaning:** She loves a big franchise and wants to know if you know it.
- **Terms implied:** franchise, canon, release order
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "The universe",
  "setting": "She is excited about a new franchise release.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "The new one is out Friday. Have you seen the whole saga?",
      "replies": [
        {
          "id": "good",
          "text": "Not all of it. Where should I start so I can watch with you?",
          "smoothDelta": 24,
          "theirResponse": "I will make you a watch order. It is a little confusing.",
          "coachNote": "Honest and inviting."
        },
        {
          "id": "meh",
          "text": "A few of them.",
          "smoothDelta": 3,
          "theirResponse": "Which ones?",
          "coachNote": "Vague. Be specific."
        },
        {
          "id": "cringe",
          "text": "They are all the same.",
          "smoothDelta": -14,
          "theirResponse": "They really are not.",
          "coachNote": "Never flatten her fandom."
        }
      ]
    },
    {
      "theirMessage": "Release order or chronological? I keep arguing about it.",
      "replies": [
        {
          "id": "good",
          "text": "What is the difference for someone new?",
          "smoothDelta": 22,
          "theirResponse": "Release order keeps the surprises. Chronological spoils some.",
          "coachNote": "Asks about the debate."
        },
        {
          "id": "meh",
          "text": "I have no idea.",
          "smoothDelta": 2,
          "theirResponse": "Ha. Good news: easy to explain.",
          "coachNote": "Honest but flat."
        },
        {
          "id": "cringe",
          "text": "Watch order does not matter.",
          "smoothDelta": -10,
          "theirResponse": "It matters a lot to fans!",
          "coachNote": "Wrong and dismissive."
        }
      ]
    }
  ],
  "closingNote": "Watch order is a friendly argument. Ask for a plan, not a verdict."
}
```

### 4.8 The comfort movie (`tt-rewatch`)

- **She says:** "It is my comfort movie. I have watched it twenty times."
- **Meaning:** A film she rewatches for emotional comfort, not novelty.
- **Terms implied:** rewatch, comfort movie
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "The comfort movie",
  "setting": "A quiet night in.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "It is my comfort movie. I have watched it twenty times.",
      "replies": [
        {
          "id": "good",
          "text": "What is it about it that feels like home?",
          "smoothDelta": 24,
          "theirResponse": "The rhythm. I know every line, and it still gets me.",
          "coachNote": "Warm, curious, and personal."
        },
        {
          "id": "meh",
          "text": "Twenty? Wow.",
          "smoothDelta": 3,
          "theirResponse": "Ha, yes.",
          "coachNote": "Surprise, no depth."
        },
        {
          "id": "cringe",
          "text": "Why not watch something new?",
          "smoothDelta": -10,
          "theirResponse": "Because this is the point.",
          "coachNote": "Misses the point of comfort viewing."
        }
      ]
    },
    {
      "theirMessage": "Do you have one?",
      "replies": [
        {
          "id": "good",
          "text": "I think it is a film I keep coming back to. I am still figuring out why.",
          "smoothDelta": 22,
          "theirResponse": "That is exactly what a comfort movie is.",
          "coachNote": "Honest and reflective."
        },
        {
          "id": "meh",
          "text": "Not really.",
          "smoothDelta": 0,
          "theirResponse": "Okay.",
          "coachNote": "A closed door."
        },
        {
          "id": "cringe",
          "text": "I do not rewatch movies.",
          "smoothDelta": -8,
          "theirResponse": "Fair, I guess.",
          "coachNote": "Sounds judgy."
        }
      ]
    }
  ],
  "closingNote": "A comfort movie is about feeling, not quality. Ask how it feels."
}
```

### 4.9 You have not seen it (`tt-havent-seen`)

- **She says:** "You have not seen it?! We are fixing that this weekend."
- **Meaning:** Playful shock that you missed a film she loves; an invitation.
- **Terms implied:** honest gaps, watch together
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "You have not seen it",
  "setting": "She is stunned you have never seen it.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "You have not seen it?! We are fixing that this weekend.",
      "replies": [
        {
          "id": "good",
          "text": "Guilty. No spoilers. What should I look out for?",
          "smoothDelta": 24,
          "theirResponse": "Watch the first ten minutes closely. Everything is planted there.",
          "coachNote": "Honest, fun, and invites a tip."
        },
        {
          "id": "meh",
          "text": "I have heard of it.",
          "smoothDelta": 2,
          "theirResponse": "Heard of it is not seen it!",
          "coachNote": "True but feels like hedging."
        },
        {
          "id": "cringe",
          "text": "Yeah, I saw it years ago.",
          "smoothDelta": -14,
          "theirResponse": "What was your favourite scene?",
          "coachNote": "A bluff. She will ask a follow-up."
        }
      ]
    },
    {
      "theirMessage": "Okay, what is the one thing you are hoping for?",
      "replies": [
        {
          "id": "good",
          "text": "I want to see why you love it.",
          "smoothDelta": 24,
          "theirResponse": "Now I am nervous. You had better love it.",
          "coachNote": "The best reason to watch."
        },
        {
          "id": "meh",
          "text": "A good time?",
          "smoothDelta": 2,
          "theirResponse": "Sure.",
          "coachNote": "A little generic."
        },
        {
          "id": "cringe",
          "text": "Honestly I am not that into these.",
          "smoothDelta": -12,
          "theirResponse": "Oh. Okay.",
          "coachNote": "Kills the invitation."
        }
      ]
    }
  ],
  "closingNote": "Admit the gap with a smile. It is the friendliest thing you can say."
}
```

### 4.10 Picking tonight (`tt-date-night`)

- **She says:** "You pick tonight. But it cannot be something I have seen."
- **Meaning:** She gives you the choice under a small constraint.
- **Terms implied:** recommendation, taste
- **Replies:** good (+20 to +24), meh (about 0), cringe (about -8 to -14); coach notes explain why.

```json
{
  "title": "Picking tonight",
  "setting": "Deciding what to watch.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "You pick tonight. But it cannot be something I have seen.",
      "replies": [
        {
          "id": "good",
          "text": "What have you loved lately? I will pick something in that neighbourhood.",
          "smoothDelta": 22,
          "theirResponse": "Slow, moody dramas. Surprise me.",
          "coachNote": "Uses her taste as a map."
        },
        {
          "id": "meh",
          "text": "How about a comedy?",
          "smoothDelta": 4,
          "theirResponse": "Hmm, maybe.",
          "coachNote": "Reasonable, but ignores her taste."
        },
        {
          "id": "cringe",
          "text": "Everything I like, you have seen.",
          "smoothDelta": -8,
          "theirResponse": "Then pick something new.",
          "coachNote": "A cop-out."
        }
      ]
    },
    {
      "theirMessage": "Two hours or less please, I have work tomorrow.",
      "replies": [
        {
          "id": "good",
          "text": "Perfect. I found two: both under two hours. Which vibe?",
          "smoothDelta": 24,
          "theirResponse": "The second one. It sounds beautiful.",
          "coachNote": "Prepared, respectful and gives her a choice."
        },
        {
          "id": "meh",
          "text": "I will see what is on.",
          "smoothDelta": 0,
          "theirResponse": "Okay...",
          "coachNote": "No plan."
        },
        {
          "id": "cringe",
          "text": "It is only a little longer.",
          "smoothDelta": -14,
          "theirResponse": "I said two hours.",
          "coachNote": "Ignored her constraint."
        }
      ]
    }
  ],
  "closingNote": "Recommendations start with her taste. Offer two options with a reason."
}
```

## 5. Talk Track roster at launch (24)

The 10 above plus 14 more, one per unit end or theme, written at authoring time: `tt-first-date-genre` (mainstream vs arthouse taste), `tt-oscar-night` (watch party), `tt-box-office` (why it "flopped"), `tt-remake` (remake vs original), `tt-subtitles` (dubbed or subtitled), `tt-cinema-etiquette` (phones, talking), `tt-scorsese` (auteur talk), `tt-a24` (arthouse label), `tt-old-movie` (a classic she loves), `tt-runtime` (three-hour epic), `tt-cult` (cult classic), `tt-horror-handoff` (she loves horror; points to the `horror-films` course), `tt-director-cut` (versions) and `tt-festival` (she is at a film festival).

## 6. Asset needs (all `original-swoond`)

| Asset | Type | Notes |
|---|---|---|
| Shot-size, angle, lighting, colour and aspect-ratio technique illustrations | Original vector art | About 60; stylised figures and geometric scenes; never a recognisable film frame or character |
| Procedural diagrams (`thirds-grid-frame`, `camera-axis-topdown`, `three-point-light-topdown`) | SwiftUI procedural | Drawn natively |
| Film-sound cues (diegetic scenes, leitmotif, Foley, silence, mix) | Original composition/synthesis and recorded Foley | About 24 clips of 4 to 10 seconds; not derivative of any specific film score |
| Timelines (eras, awards calendar, production stages) | Procedural typography | Drawn natively |

## 7. Voice and safety notes

- Warm, a little flirty, never condescending; jokes at the learner's ignorance, never about the crush or a fandom.
- Never teach fake expertise: every conversation item rewards asking, admitting gaps and curiosity.
- No taste policing (no "real cinephiles"); no scoring of opinions.
- Sensitive film history is factual and contextual; nothing graphic; content ratings (G to NC-17) are taught as plain-language literacy.
- No suggestions of piracy; where-to-watch only via licensed availability data.
