# Native Exercise Plan: K-pop (`k-pop`)

Tier B plan for `docs/courses/k-pop/`. All 13 native exercise types are used; there are **no Unity sims** (CDS section 12). Sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup when this file was generated; 44 samples, 0 failures). Conventions: prompts of 12 words or fewer, explanations that teach, `sayThisLine` a natural sentence the learner could say. All group, member and song names in samples are omitted or invented; **no lyrics, no real recordings, no member photos** are used.

**Rights guardrail (spec sections 20 and 40).** `listening-id` audio is original synthesised or commissioned audio only (licence `original-swoond`), including commissioned Korean-speaker word recordings. `visual-id` and `hotspot-tap` use original procedural illustrations; lightsticks, photocards and banners are drawn generically (no real lightstick designs, no logos). Sample `asset` paths point to *to-be-produced* assets (section 6).

**Script and fonts.** Terms show Hangul next to Revised Romanization; the app needs a Korean-capable fallback font (see NOTES_FOR_ORCHESTRATOR).

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite: roles, industry logic, chart logic, misconceptions. | ~240 |
| `binary-call` | Two-way judgments with no diagram: comeback or return, respectful or invasive, nuanced or absolute. `scene.kind` is `none` with an `alt`. | ~110 |
| `term-match` | Open each unit with 3-6 terms: roles, fan words, charts, events, address terms. | ~60 |
| `sequence-order` | Comeback teaser week, audition to debut, concert night, year in a fandom. | ~30 |
| `visual-id` | Generic lightstick, photocard, banner, album kit, dance formations (original vector art only). | ~28 |
| `decision-scenario` | Judgment with safety and kindness: crowds, trades, sensitive stories, fan-club presales. `safetyNote` where relevant. | ~50 |
| `talk-track` | 20 tracks; replies reward curiosity over bluffing. | ~20 |
| `timing-tap` | 1D only: clap into the chant gap, lightstick lift, slogan cue. Anything scene-based would be Unity; nothing here needs it. | ~12 |
| `say-this` | Decode fan lines: bias, comeback, chants, charts, fandom conflict. | ~140 |
| `fill-the-gap` | Vocabulary in context and Daily Bite review. | ~60 |
| `listening-id` | Original clips: chant gap, genre switch in one track, Korean greetings, meter and build, a variety-show laugh-track sketch. Every clip has a text description and a non-audio companion. | ~50 |
| `estimate-slider` | Dated magnitudes: contract cap, time zones, sizes; never live numbers. | ~16 |
| `hotspot-tap` | Arena plan, album kit, comeback timeline, formation diagram. | ~20 |

About 836 native items across 110 lessons and the review loop. Cross-type rules: every lesson ends with one item that includes a say-this line; every unit ends with a `talk-track` or `say-this`; Daily Bite draws from `multiple-choice`, `fill-the-gap`, `term-match`, `binary-call`; every `listening-id` has a non-audio companion.

## 2. Sample items by type

Each sample names its planned lesson id (see CDS section 11).

### 2.1 `multiple-choice`

**Sample 1** (lesson `ind-01`)

```json
{
  "prompt": "What does 'K-pop' describe best?",
  "options": [
    {
      "id": "a",
      "text": "An industry system for making trained groups and solo acts",
      "explanation": "Right. It names a way of making and marketing pop, not one sound."
    },
    {
      "id": "b",
      "text": "A single music genre with one sound",
      "explanation": "K-pop songs span hip-hop, R&B, rock, dance, ballads and more."
    },
    {
      "id": "c",
      "text": "Any song sung in Korean",
      "explanation": "Language alone does not make something K-pop; trot and indie are separate scenes."
    },
    {
      "id": "d",
      "text": "Only music from the four biggest companies",
      "explanation": "Many loved acts come from smaller or independent agencies."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "K-pop is best understood as a system: auditions, training, planned debut, packaged content and fandom. The sound inside can be almost anything.",
    "incorrect": "K-pop is a system and a culture, not one sound. That is why two K-pop songs can sound nothing alike.",
    "sayThisLine": "Is it the sound you like, or the whole world around it?"
  }
}
```

**Sample 2** (lesson `cbk-03`)

```json
{
  "prompt": "What is a 'title track'?",
  "options": [
    {
      "id": "a",
      "text": "The main song an album is promoted with",
      "explanation": "Right. It usually gets the music video and the stage performances."
    },
    {
      "id": "b",
      "text": "The first song on the tracklist",
      "explanation": "Often not; order is a separate choice."
    },
    {
      "id": "c",
      "text": "The longest song on the album",
      "explanation": "Length has nothing to do with it."
    },
    {
      "id": "d",
      "text": "A song the fans vote to delete",
      "explanation": "No such thing; fans just debate which one should have been chosen."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "The title track (taiteulgok) is the focus song: the agency picks it for the music video, the music show stages and most promotion. The other songs are subsidiary tracks (surokgok).",
    "incorrect": "The title track is the song the release is promoted with. Other songs on the album are called subsidiary tracks, or B-sides.",
    "sayThisLine": "Is that the title track, or a B-side you love?"
  }
}
```

**Sample 3** (lesson `grp-04`)

```json
{
  "prompt": "Who is the 'maknae' of a group?",
  "options": [
    {
      "id": "a",
      "text": "The youngest member",
      "explanation": "Right. Maknae literally means the youngest in a family or team."
    },
    {
      "id": "b",
      "text": "The leader",
      "explanation": "Different role: the leader organises and speaks for the group."
    },
    {
      "id": "c",
      "text": "The best dancer",
      "explanation": "Skill is not the point; it is about age."
    },
    {
      "id": "d",
      "text": "The newest member to join",
      "explanation": "A late joiner can be older than everyone; maknae is about age."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Maknae (막내) means the youngest, and age organises a lot of Korean group life: who speaks formally, who gets teased and who is looked after. It is about age, not talent.",
    "incorrect": "Maknae means youngest member. It is an age word, not a skill or a status.",
    "sayThisLine": "Who is the maknae in your person's group?"
  }
}
```

**Sample 4** (lesson `shw-02`)

```json
{
  "prompt": "What makes a music show win?",
  "options": [
    {
      "id": "a",
      "text": "A weighted mix of measures such as digital sales and votes",
      "explanation": "Right. Each show sets its own formula."
    },
    {
      "id": "b",
      "text": "Only live audience applause",
      "explanation": "Applause is not the main driver."
    },
    {
      "id": "c",
      "text": "A single global streaming number",
      "explanation": "Shows mostly use Korean measures plus their own voting and broadcast scores."
    },
    {
      "id": "d",
      "text": "Whichever group performed last",
      "explanation": "Order does not matter."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Each weekly show adds up several measures such as digital sales, physical albums, video views, broadcast points and voting. The formulas differ by show and change over time.",
    "incorrect": "A win is a weighted score of several measures. Formulas differ by show and get revised, so check the current one.",
    "sayThisLine": "Which measure do you think mattered most this week?"
  }
}
```

**Sample 5** (lesson `dbt-05`)

```json
{
  "prompt": "Which statement about parasocial feelings is fair?",
  "options": [
    {
      "id": "a",
      "text": "They are common and normal; boundaries keep them healthy",
      "explanation": "Right. Feeling close to someone you know through content is human."
    },
    {
      "id": "b",
      "text": "They are proof a fan is unwell",
      "explanation": "Not a diagnosis; most fans enjoy them happily."
    },
    {
      "id": "c",
      "text": "They mean the artist knows the fan personally",
      "explanation": "The feeling can be real while the relationship is one-way."
    },
    {
      "id": "d",
      "text": "Only teenagers feel them",
      "explanation": "People of all ages do."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "A parasocial bond is a one-sided feeling of closeness. It is ordinary, and it stays healthy when fans remember the person on screen has a private life and a real limit.",
    "incorrect": "Parasocial closeness is normal. The boundary is remembering the relationship runs one way.",
    "sayThisLine": "I love how close it feels, even though I know they don't know me."
  }
}
```

### 2.2 `binary-call`

**Sample 1** (lesson `cbk-01`)

```json
{
  "prompt": "If a group never left, can it still have a comeback?",
  "scene": {
    "kind": "none",
    "alt": "No image. A short statement about how comeback is used."
  },
  "choices": [
    {
      "id": "a",
      "label": "Yes"
    },
    {
      "id": "b",
      "label": "No"
    }
  ],
  "correctChoiceId": "a",
  "explanation": {
    "correct": "Yes. Comeback means a new release era. A group that toured all year can still have a comeback when a new album arrives.",
    "incorrect": "It is a release-cycle word, not a return from a break. Most groups never leave.",
    "sayThisLine": "It's a new era, not a return."
  },
  "ruleTag": "Comeback meaning"
}
```

**Sample 2** (lesson `kor-02`)

```json
{
  "prompt": "A woman says 'oppa' to an older male friend. Normal?",
  "scene": {
    "kind": "none",
    "alt": "No image. A quick address-terms check."
  },
  "choices": [
    {
      "id": "a",
      "label": "Normal use"
    },
    {
      "id": "b",
      "label": "Not how it works"
    }
  ],
  "correctChoiceId": "a",
  "explanation": {
    "correct": "Yes. A woman calls an older man she is close to oppa (오빠). Who says it depends on both people's gender and relative age.",
    "incorrect": "It is normal when the speaker is a woman and the man is older and close. Men use hyung for older men and noona for older women.",
    "sayThisLine": "Oppa, for a close older brother-like friend."
  },
  "ruleTag": "Address terms"
}
```

**Sample 3** (lesson `alb-05`)

```json
{
  "prompt": "Is every buyer of many versions just wasteful?",
  "scene": {
    "kind": "none",
    "alt": "No image. A fairness check on a debated topic."
  },
  "choices": [
    {
      "id": "a",
      "label": "Yes, always"
    },
    {
      "id": "b",
      "label": "It is more nuanced"
    }
  ],
  "correctChoiceId": "b",
  "explanation": {
    "correct": "It is nuanced. Some fans collect for joy, some for lucky-draw access, some feel pressure. Critics also raise cost and waste. A fair view names both.",
    "incorrect": "Collectors, stores and critics all have a point. Judging a person for it misses the nuance.",
    "sayThisLine": "Different people, different reasons, and fair criticism too."
  },
  "ruleTag": "Fair framing"
}
```

**Sample 4** (lesson `dbt-04`)

```json
{
  "prompt": "A fan finds where an idol lives. Is that support?",
  "scene": {
    "kind": "none",
    "alt": "No image. A privacy judgment."
  },
  "choices": [
    {
      "id": "a",
      "label": "Support"
    },
    {
      "id": "b",
      "label": "Harmful"
    }
  ],
  "correctChoiceId": "b",
  "explanation": {
    "correct": "Harmful. Tracking someone's home or schedule is invasive and unsafe, and fans widely condemn it. Support means respecting the person's private life.",
    "incorrect": "Even kind motives do not make tracking someone's home safe. Real support leaves private life private.",
    "sayThisLine": "Fans should respect private life."
  },
  "ruleTag": "Privacy respect"
}
```

**Sample 5** (lesson `fan-04`)

```json
{
  "prompt": "Stream goals: is joining always required to be a 'real' fan?",
  "scene": {
    "kind": "none",
    "alt": "No image. A healthy-participation check."
  },
  "choices": [
    {
      "id": "a",
      "label": "Required"
    },
    {
      "id": "b",
      "label": "Optional"
    }
  ],
  "correctChoiceId": "b",
  "explanation": {
    "correct": "Optional. Streaming parties are a fun team ritual, but there is no fan test. Fans choose how much time and money to give.",
    "incorrect": "Participation is a choice. Gatekeeping who is a 'real' fan is what makes fandom feel bad.",
    "sayThisLine": "Do what feels good to you."
  },
  "ruleTag": "Healthy participation"
}
```

### 2.3 `term-match`

**Sample 1** (lesson `grp-02`)

```json
{
  "prompt": "Match each role to what it means.",
  "pairs": [
    {
      "id": "main-vocal",
      "term": "Main vocalist",
      "definition": "The strongest lead singing role"
    },
    {
      "id": "lead-rapper",
      "term": "Lead rapper",
      "definition": "A featured rapper after the main one"
    },
    {
      "id": "center",
      "term": "Center",
      "definition": "The spotlight position in formations"
    },
    {
      "id": "visual",
      "term": "Visual",
      "definition": "Stage-and-marketing face of a concept"
    },
    {
      "id": "maknae",
      "term": "Maknae",
      "definition": "The youngest member"
    }
  ],
  "distractorDefinitions": [
    "The person who writes every song"
  ],
  "explanation": {
    "summary": "Roles are shorthand that fans use to talk about who does what on stage. They describe jobs, not people's worth, and real members often do more than one.",
    "sayThisLine": "Who is the main vocalist in your group?"
  }
}
```

**Sample 2** (lesson `kor-04`)

```json
{
  "prompt": "Match the fan words to their meaning.",
  "pairs": [
    {
      "id": "choeae",
      "term": "Choeae (bias)",
      "definition": "Your favourite member"
    },
    {
      "id": "deokhu",
      "term": "Deokhu",
      "definition": "A devoted fan of something"
    },
    {
      "id": "ipdeok",
      "term": "Ipdeok",
      "definition": "Falling into a fandom"
    },
    {
      "id": "taldeok",
      "term": "Taldeok",
      "definition": "Leaving a fandom behind"
    }
  ],
  "explanation": {
    "summary": "Choeae (최애) means most loved, and fans say bias for the same idea. Ipdeok (입덕) is entering a fandom; taldeok (탈덕) is leaving it. Deokhu (덕후) comes from the same root as otaku.",
    "sayThisLine": "When was your ipdeok moment?"
  }
}
```

**Sample 3** (lesson `shw-05`)

```json
{
  "prompt": "Match the chart or show to its job.",
  "pairs": [
    {
      "id": "circle",
      "term": "Circle Chart",
      "definition": "Korea's national digital and album charts"
    },
    {
      "id": "hanteo",
      "term": "Hanteo",
      "definition": "A Korean album sales tracker fans follow daily"
    },
    {
      "id": "melon",
      "term": "Melon",
      "definition": "A large Korean streaming service with its own chart"
    },
    {
      "id": "billboard",
      "term": "Billboard",
      "definition": "A US chart body with global charts"
    }
  ],
  "explanation": {
    "summary": "Each chart measures something different, so two charts can disagree without anyone being wrong. Always ask what a chart counts before comparing.",
    "sayThisLine": "Which chart are you watching this week?"
  }
}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `cbk-02`)

```json
{
  "prompt": "Order a typical comeback teaser week.",
  "items": [
    {
      "id": "date",
      "text": "Release date and schedule poster",
      "why": "The calendar comes first so fans can plan."
    },
    {
      "id": "concept",
      "text": "Concept photos and films",
      "why": "Concept images set the mood before any song."
    },
    {
      "id": "tracklist",
      "text": "Tracklist reveal",
      "why": "Fans learn what songs exist and which is the title track."
    },
    {
      "id": "preview",
      "text": "Highlight medley or sample clips",
      "why": "A short preview teases the sound."
    },
    {
      "id": "mvteaser",
      "text": "Music video teaser",
      "why": "The final teaser arrives close to release day."
    }
  ],
  "explanation": {
    "correct": "Schedules are built to grow excitement: date, mood, songs, sound, then the music video teaser.",
    "incorrect": "The usual path is date, concept, tracklist, preview, then MV teaser. Agencies vary the order.",
    "sayThisLine": "Has the tracklist dropped yet?"
  }
}
```

**Sample 2** (lesson `trn-04`)

```json
{
  "prompt": "Order the path from audition to debut.",
  "items": [
    {
      "id": "audition",
      "text": "Audition",
      "why": "Everyone starts with an entry door."
    },
    {
      "id": "trainee",
      "text": "Training period",
      "why": "Skills and group chemistry get built."
    },
    {
      "id": "evaluate",
      "text": "Regular evaluations",
      "why": "Progress is checked and lineups change."
    },
    {
      "id": "reveal",
      "text": "Debut reveal and teasers",
      "why": "The plan goes public."
    },
    {
      "id": "debut",
      "text": "Debut release",
      "why": "Debut is a beginning, not a finish line."
    }
  ],
  "explanation": {
    "correct": "That is the usual arc. Real paths vary a lot in length and order.",
    "incorrect": "Audition, training, evaluations, reveal, debut. Some groups are formed on shows instead.",
    "sayThisLine": "How long were they trainees?"
  }
}
```

**Sample 3** (lesson `liv-01`)

```json
{
  "prompt": "Order a typical concert night.",
  "items": [
    {
      "id": "opening",
      "text": "Opening stage and entrance",
      "why": "A big opener sets the tone."
    },
    {
      "id": "stages",
      "text": "Main stages and dance numbers",
      "why": "Core of the show."
    },
    {
      "id": "ment",
      "text": "Ment: members talk to fans",
      "why": "Breaks for talk and thanks."
    },
    {
      "id": "unit",
      "text": "Unit and solo stages",
      "why": "Variety, costume changes and rest."
    },
    {
      "id": "encore",
      "text": "Encore and final greeting",
      "why": "Final songs, thanks and farewell."
    }
  ],
  "explanation": {
    "correct": "That is the common shape. Every tour varies.",
    "incorrect": "Most shows open big, alternate stages and talks, add unit or solo sets, and close with encore.",
    "sayThisLine": "Are you excited for the encore or the unit stages?"
  }
}
```

### 2.5 `visual-id`

**Sample 1** (lesson `fan-02`)

```json
{
  "prompt": "Which item is a lightstick?",
  "image": {
    "asset": "img/kpop/lightstick-generic.svg",
    "alt": "A simple illustrated handheld stick with a glowing orb on top, a generic lightstick",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Lightstick",
      "explanation": "Right. Each group has its own design, and fans carry it at shows."
    },
    {
      "id": "b",
      "text": "Microphone",
      "explanation": "Mics have a grille and no orb."
    },
    {
      "id": "c",
      "text": "Conductor baton",
      "explanation": "A baton is a thin stick; this has a glowing head."
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "A lightstick is a handheld light that fans wave and sync with the show. Each group has its own design.",
    "incorrect": "The glowing orb on a handle is the clue. Lightsticks are carried by fans, not performers.",
    "sayThisLine": "Do you have a lightstick?"
  },
  "cues": [
    "Glowing head on a handle",
    "Fans carry it, not performers"
  ]
}
```

**Sample 2** (lesson `alb-02`)

```json
{
  "prompt": "Which item is a photocard?",
  "image": {
    "asset": "img/kpop/photocard-generic.svg",
    "alt": "A generic illustrated card with a silhouette and a blank name line, about trading-card size",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Photocard",
      "explanation": "Right. A small collectible card packed in albums."
    },
    {
      "id": "b",
      "text": "Concert ticket",
      "explanation": "Tickets show seat and venue details."
    },
    {
      "id": "c",
      "text": "Sticker sheet",
      "explanation": "Stickers are not card-shaped like this."
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Photocards are small collectible cards packed in albums. Fans trade them and often keep them in sleeves.",
    "incorrect": "Photocards are small, portrait cards. Look for the pocket-sized card with a picture and no seat or date.",
    "sayThisLine": "Which photocard did you want this time?"
  },
  "cues": [
    "Pocket-sized portrait card",
    "Packed inside albums"
  ]
}
```

**Sample 3** (lesson `fan-05`)

```json
{
  "prompt": "What is this fan-made item called?",
  "image": {
    "asset": "img/kpop/slogan-banner-generic.svg",
    "alt": "A generic illustrated fabric banner with a blank message area, held on two poles",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "a",
      "text": "Slogan banner",
      "explanation": "Right. Fans hold these up during special songs."
    },
    {
      "id": "b",
      "text": "Stage backdrop",
      "explanation": "Backdrops belong to the production."
    },
    {
      "id": "c",
      "text": "Merch towel",
      "explanation": "A towel is sold by the agency and is not usually held up this way."
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "A slogan banner is a fan-made banner, often showing a fan message at a scheduled moment. Some venues limit size.",
    "incorrect": "The clue is the fan-made fabric on poles. Always check venue rules first.",
    "sayThisLine": "Are slogan banners allowed at this venue?"
  },
  "cues": [
    "Fabric on poles",
    "Fan-made message"
  ]
}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `liv-06`)

```json
{
  "prompt": "It is a packed floor. What do you do?",
  "situation": {
    "narrative": "You and your person are at a standing show. The crowd is surging and she is close to the barrier.",
    "facts": [
      {
        "label": "Crowd",
        "value": "Tight and surging",
        "emphasis": "warning"
      },
      {
        "label": "Exits",
        "value": "Two, both far"
      },
      {
        "label": "Water",
        "value": "Left in the bag"
      },
      {
        "label": "Her mood",
        "value": "Excited, distracted"
      }
    ]
  },
  "options": [
    {
      "id": "a",
      "label": "Move toward the edge together, check in",
      "verdict": "best",
      "consequence": "You step out of the squeeze, find a spot near an exit and keep the show. She is grateful you noticed.",
      "considerations": [
        "Crowd crush risk rises when people cannot move",
        "Leaving early is always allowed"
      ]
    },
    {
      "id": "b",
      "label": "Stay and push forward for the view",
      "verdict": "poor",
      "consequence": "You gain a view and lose personal space. Surges are dangerous and this is how people get hurt.",
      "considerations": [
        "Pushing adds pressure",
        "She may not want to move anyway"
      ]
    },
    {
      "id": "c",
      "label": "Tell her to leave immediately without explaining",
      "verdict": "acceptable",
      "consequence": "Safe, but she feels taken from the moment. Saying why and offering a plan works better.",
      "considerations": [
        "Safety first",
        "Explain and offer a plan"
      ]
    }
  ],
  "expertNote": "Experienced attendees pick a spot near an exit or aisle, know a meeting point and leave a surge early. Comfort and safety beat the front row.",
  "sayThisLine": "Can we move a little toward the side? I want to actually enjoy this.",
  "safetyNote": "General guidance only. If you feel unsafe, leave and tell venue staff."
}
```

**Sample 2** (lesson `alb-02`)

```json
{
  "prompt": "A stranger offers a rare photocard trade.",
  "situation": {
    "narrative": "A trade post looks fair, but the stranger wants payment first.",
    "facts": [
      {
        "label": "Card",
        "value": "Rare, limited"
      },
      {
        "label": "Offer",
        "value": "Payment sent first",
        "emphasis": "warning"
      },
      {
        "label": "Account",
        "value": "Days old",
        "emphasis": "warning"
      },
      {
        "label": "Platform",
        "value": "Private message"
      }
    ]
  },
  "options": [
    {
      "id": "a",
      "label": "Ask for a public, verified trade or use a trusted fan group",
      "verdict": "best",
      "consequence": "You avoid losing money, and you can trade in a group with reviews and vouches.",
      "considerations": [
        "Trusted fan groups keep trade lists",
        "Escrow style middle steps help"
      ]
    },
    {
      "id": "b",
      "label": "Send payment and hope",
      "verdict": "poor",
      "consequence": "New accounts asking for payment first are a classic scam pattern. You may lose the money and the card.",
      "considerations": [
        "Payment first is a red flag",
        "Screenshots are not proof"
      ]
    },
    {
      "id": "c",
      "label": "Offer to meet in a public place",
      "verdict": "acceptable",
      "consequence": "Better than sending money, but meeting strangers needs care. Bring a friend.",
      "considerations": [
        "Public place",
        "Bring someone"
      ]
    }
  ],
  "expertNote": "Experienced collectors trade with people who have a history, use tracked shipping and keep photos. They never pay a new account first.",
  "sayThisLine": "Do you have any trade references I can look at?",
  "safetyNote": "Never share your home address with strangers and never send payment to a new account first."
}
```

**Sample 3** (lesson `cnv-06`)

```json
{
  "prompt": "She mentions a sad industry story. Reply?",
  "situation": {
    "narrative": "Your person says, 'I am so worried about him after that news.'",
    "facts": [
      {
        "label": "Her feeling",
        "value": "Worried"
      },
      {
        "label": "Topic",
        "value": "Wellbeing story",
        "emphasis": "warning"
      },
      {
        "label": "Your knowledge",
        "value": "Little"
      },
      {
        "label": "Setting",
        "value": "Quiet chat"
      }
    ]
  },
  "options": [
    {
      "id": "a",
      "label": "Listen, say it sounds hard, ask what she needs",
      "verdict": "best",
      "consequence": "She feels heard. You did not guess facts or give advice; you stayed with her.",
      "considerations": [
        "Do not speculate about a real person's life",
        "Invite, do not diagnose"
      ]
    },
    {
      "id": "b",
      "label": "Share a theory you read online",
      "verdict": "poor",
      "consequence": "Speculation about a real person's health is harmful and adds noise. She may feel worse.",
      "considerations": [
        "Rumours spread harm",
        "Avoid unverified claims"
      ]
    },
    {
      "id": "c",
      "label": "Change the subject quickly",
      "verdict": "acceptable",
      "consequence": "Avoids harm but can read as dismissive. A short check-in first is kinder.",
      "considerations": [
        "Stay with her first",
        "Offer a break if she wants"
      ]
    }
  ],
  "expertNote": "An experienced friend listens, avoids speculation and lets her lead. If a fan seems in real distress, gently point to real support in her region.",
  "sayThisLine": "That sounds really heavy. Do you want to talk it through, or take a breather?",
  "safetyNote": "If someone may be in danger, encourage contacting local emergency or crisis services."
}
```

### 2.7 `talk-track`

**Sample 1** (lesson `cnv-02`)

```json
{
  "title": "It's comeback day",
  "setting": "Texting at lunchtime",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "IT'S COMEBACK DAY. I've been up since 5.",
      "replies": [
        {
          "id": "good",
          "text": "Tell me what I'm about to hear. What's your first impression?",
          "smoothDelta": 22,
          "theirResponse": "She sends three voice notes. You are in.",
          "coachNote": "Curiosity beats a fake opinion."
        },
        {
          "id": "meh",
          "text": "Cool. Is it good?",
          "smoothDelta": 2,
          "theirResponse": "'Yes?? It just came out, how would I know yet.'",
          "coachNote": "Ask what she hears, not for a verdict."
        },
        {
          "id": "cringe",
          "text": "Another comeback? They do that a lot.",
          "smoothDelta": -14,
          "theirResponse": "'Wow. Okay.'",
          "coachNote": "Do not belittle the thing she loves."
        }
      ]
    }
  ],
  "closingNote": "You asked her to teach you, and that is the whole game."
}
```

**Sample 2** (lesson `cnv-01`)

```json
{
  "title": "The bias wrecker",
  "setting": "Watching a video together",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Ugh, my bias wrecker is on again.",
      "replies": [
        {
          "id": "good",
          "text": "Wait, who's the wrecker? And who is your actual bias?",
          "smoothDelta": 22,
          "theirResponse": "She grins and explains both.",
          "coachNote": "You learned two terms by asking."
        },
        {
          "id": "meh",
          "text": "What's a wrecker?",
          "smoothDelta": 6,
          "theirResponse": "'The one who ruins your loyalty. Keep up!'",
          "coachNote": "Honest, but try asking who it is."
        },
        {
          "id": "cringe",
          "text": "I'll guess: the one everyone thinks is hot.",
          "smoothDelta": -16,
          "theirResponse": "'That is not how this works.'",
          "coachNote": "Do not guess based on looks."
        }
      ]
    }
  ],
  "closingNote": "Bias and wrecker: both are about the heart, not a ranking."
}
```

**Sample 3** (lesson `cnv-03`)

```json
{
  "title": "Favourite member",
  "setting": "At dinner",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Do you want to know who my bias is?",
      "replies": [
        {
          "id": "good",
          "text": "Yes, please. And what do you love about them?",
          "smoothDelta": 24,
          "theirResponse": "She lights up and tells you a story.",
          "coachNote": "Asking why is warmer than naming a rank."
        },
        {
          "id": "meh",
          "text": "Sure. Let me guess?",
          "smoothDelta": 5,
          "theirResponse": "'Go ahead.'",
          "coachNote": "Guessing can work if it is playful, not a test."
        },
        {
          "id": "cringe",
          "text": "Doesn't everyone pick the same one?",
          "smoothDelta": -15,
          "theirResponse": "'No. Wow.'",
          "coachNote": "Never rank or compare members to her face."
        }
      ]
    }
  ],
  "closingNote": "You made room for her."
}
```

### 2.8 `timing-tap`

**Sample 1** (lesson `fan-03`)

```json
{
  "prompt": "Clap into the chant gap.",
  "theme": {
    "label": "Chant clap",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 40,
      "zoneEndPct": 52,
      "sweepSeconds": 2.4
    },
    {
      "zoneStartPct": 56,
      "zoneEndPct": 66,
      "sweepSeconds": 2.0
    }
  ],
  "explanation": {
    "correct": "You landed in the gap. Chants are call and response: fans fill the quiet bars between the vocals.",
    "incorrect": "The gap is short. Fan chants sit in the space between lines, so wait for the quiet bar.",
    "sayThisLine": "Do you know when to come in on the chant?"
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `fan-03`)

```json
{
  "prompt": "Tap at the slogan moment.",
  "theme": {
    "label": "Slogan cue",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 70,
      "zoneEndPct": 82,
      "sweepSeconds": 2.6
    },
    {
      "zoneStartPct": 20,
      "zoneEndPct": 32,
      "sweepSeconds": 2.2
    },
    {
      "zoneStartPct": 45,
      "zoneEndPct": 55,
      "sweepSeconds": 1.8
    }
  ],
  "explanation": {
    "correct": "Good timing. Slogans often arrive at a set moment, like the last line of a song.",
    "incorrect": "Watch for the cue: slogans follow a set bar, not a loose guess.",
    "sayThisLine": "When is the slogan moment in this song?"
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 3** (lesson `liv-01`)

```json
{
  "prompt": "Lift your lightstick on the beat.",
  "theme": {
    "label": "Lightstick lift",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 48,
      "zoneEndPct": 56,
      "sweepSeconds": 2.0
    },
    {
      "zoneStartPct": 30,
      "zoneEndPct": 38,
      "sweepSeconds": 1.6
    }
  ],
  "explanation": {
    "correct": "On the beat. Synchronised lights look good because everyone lands together.",
    "incorrect": "Count with the bar: hold, hold, now.",
    "sayThisLine": "Shall we sync our lights on the chorus?"
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.9 `say-this`

**Sample 1** (lesson `cbk-03`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "The title track is fine but the B-sides are the album."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "The focus song is not her favourite; she prefers other tracks",
      "explanation": "Right. The title track is promoted; B-sides are everything else.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "She is angry about the album title",
      "explanation": "Nothing in the line is about the album name.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "The album has no title track",
      "explanation": "She mentions one, so it exists.",
      "isCorrect": false
    }
  ],
  "translation": "She likes the non-focus songs more than the promoted one.",
  "followUps": [
    {
      "line": "Which B-side would you play for me first?",
      "why": "Invites her to teach."
    },
    {
      "line": "Is that a common thing for fans?",
      "why": "Shows curiosity about the culture."
    }
  ],
  "noFakeExpertNote": "You do not have to have an opinion on the tracks; asking for her favourite is enough."
}
```

**Sample 2** (lesson `kor-04`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "I officially ipdeok'd last night."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "She became a fan of something, a group or a show",
      "explanation": "Right. Ipdeok means falling into a fandom.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "She left a fandom",
      "explanation": "That would be taldeok.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "She bought a ticket",
      "explanation": "Not what the word means.",
      "isCorrect": false
    }
  ],
  "translation": "She just fell for something new and is telling you with excitement.",
  "followUps": [
    {
      "line": "Who or what pulled you in?",
      "why": "Invites the story."
    },
    {
      "line": "What should I watch first to get it?",
      "why": "Honest and curious."
    }
  ],
  "noFakeExpertNote": "Use the word only if she does, and ask before you guess what she is into."
}
```

**Sample 3** (lesson `shw-03`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "That's a triple crown. I'm shaking."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "A song reached three music show wins, a milestone",
      "explanation": "Right. The exact rule varies by show, so ask what she is counting.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A concert with three encores",
      "explanation": "No, it is about music show wins.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "Three members won rookie awards",
      "explanation": "No, that is a different thing.",
      "isCorrect": false
    }
  ],
  "translation": "A song has won music shows three times, which fans treat as a milestone.",
  "followUps": [
    {
      "line": "How long did the goal take?",
      "why": "Invites her story."
    },
    {
      "line": "Which show was the hardest?",
      "why": "Shows you know shows differ."
    }
  ],
  "noFakeExpertNote": "Definitions of triple crown vary, so ask what she counts."
}
```

**Sample 4** (lesson `fan-01`)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "We're up against another fandom war, ugh."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "Fans are arguing online with another fandom",
      "explanation": "Right. Fandom wars are online fights between groups of fans.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A concert clash",
      "explanation": "No, it is about online conflict.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A music-show rule change",
      "explanation": "No; she says war and another fandom.",
      "isCorrect": false
    }
  ],
  "translation": "She is tired of the online conflict and may need someone to listen.",
  "followUps": [
    {
      "line": "Is it getting to you?",
      "why": "Checks on her."
    },
    {
      "line": "Do you want to mute it for a bit?",
      "why": "Offers a break."
    }
  ],
  "noFakeExpertNote": "Do not take sides; ask how she is."
}
```

### 2.10 `fill-the-gap`

**Sample 1** (lesson `cbk-01`)

```json
{
  "prompt": "Complete the comeback line.",
  "template": "A {{word}} is a new release era, even for a group that never {{left}}.",
  "gaps": [
    {
      "id": "word",
      "options": [
        "comeback",
        "debut",
        "hiatus"
      ],
      "correct": "comeback"
    },
    {
      "id": "left",
      "options": [
        "left",
        "signed",
        "won"
      ],
      "correct": "left"
    }
  ],
  "explanation": {
    "correct": "Comeback means a new release era, not a return from a break.",
    "incorrect": "Comeback is about a new release era. Hiatus is a pause; debut is the first release.",
    "sayThisLine": "Is this a comeback or a return from a break?"
  }
}
```

**Sample 2** (lesson `grp-04`)

```json
{
  "prompt": "Finish the age terms.",
  "template": "The {{youngest}} is the maknae; a woman calls an older male friend {{oppa}}.",
  "gaps": [
    {
      "id": "youngest",
      "options": [
        "youngest member",
        "leader",
        "visual"
      ],
      "correct": "youngest member"
    },
    {
      "id": "oppa",
      "options": [
        "oppa",
        "noona",
        "hyung"
      ],
      "correct": "oppa"
    }
  ],
  "explanation": {
    "correct": "Maknae is age-based; oppa is a woman to an older man.",
    "incorrect": "Maknae means youngest. Hyung is used by men to older men; noona by men to older women.",
    "sayThisLine": "Who is the maknae?"
  }
}
```

**Sample 3** (lesson `shw-05`)

```json
{
  "prompt": "Fill in the chart idea.",
  "template": "Two charts can {{disagree}} because each one counts a different {{measure}}.",
  "gaps": [
    {
      "id": "disagree",
      "options": [
        "disagree",
        "match",
        "merge"
      ],
      "correct": "disagree"
    },
    {
      "id": "measure",
      "options": [
        "measure",
        "member",
        "language"
      ],
      "correct": "measure"
    }
  ],
  "explanation": {
    "correct": "Different charts count different things, so they can differ.",
    "incorrect": "Always check what a chart counts before comparing.",
    "sayThisLine": "Which chart are you looking at?"
  }
}
```

### 2.11 `listening-id`

**Sample 1** (lesson `fan-03`)

```json
{
  "prompt": "Where does the chant fit?",
  "audio": {
    "asset": "audio/kpop/chant-gap-01.m4a",
    "durationMs": 8000,
    "license": "original-swoond",
    "description": "Eight seconds of a synthesised pop beat. Two bars of synth melody, then a one-bar gap where a clap pattern sits.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "In the gap after the vocal line",
      "explanation": "Right. Chants fill the quiet bar."
    },
    {
      "id": "b",
      "text": "On top of the synth melody",
      "explanation": "Overlapping hides the vocal line."
    },
    {
      "id": "c",
      "text": "Only at the very end",
      "explanation": "The clip shows the gap in the middle."
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Fans leave the melody alone and answer in the gap, like call and response.",
    "incorrect": "Listen for the quiet bar after the melody. That is where the chant goes.",
    "sayThisLine": "Did you hear the gap?"
  },
  "listenFor": [
    "A one-bar gap",
    "Clap pattern"
  ]
}
```

**Sample 2** (lesson `crf-04`)

```json
{
  "prompt": "Did the track switch feel?",
  "audio": {
    "asset": "audio/kpop/genre-switch-01.m4a",
    "durationMs": 12000,
    "license": "original-swoond",
    "description": "Twelve seconds of a synthesised track: a soft piano verse switches to a driving electronic beat at seven seconds.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "It switches from slow to driving",
      "explanation": "Right. The feel changes mid-track."
    },
    {
      "id": "b",
      "text": "It stays in one mood",
      "explanation": "Listen again for the change."
    },
    {
      "id": "c",
      "text": "It fades out at the end",
      "explanation": "Not in this clip."
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Many K-pop tracks switch feel inside one song, which is why fans call them 'song switches'.",
    "incorrect": "The clip starts soft and turns driving. That is a switch.",
    "sayThisLine": "That switch is wild."
  },
  "listenFor": [
    "Soft piano start",
    "Driving beat after 7 seconds"
  ]
}
```

**Sample 3** (lesson `kor-05`)

```json
{
  "prompt": "Which greeting do you hear?",
  "audio": {
    "asset": "audio/kpop/greeting-annyeonghaseyo-01.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A commissioned native Korean speaker says 'annyeonghaseyo' clearly and slowly.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "a",
      "text": "Annyeonghaseyo",
      "explanation": "Right. The standard polite hello."
    },
    {
      "id": "b",
      "text": "Gamsahamnida",
      "explanation": "That one is thank you."
    },
    {
      "id": "c",
      "text": "Saranghae",
      "explanation": "That one is I love you."
    }
  ],
  "correctOptionId": "a",
  "explanation": {
    "correct": "Annyeonghaseyo is the polite hello, and you can use it kindly.",
    "incorrect": "Annyeonghaseyo has five syllables. Gamsahamnida is 'thank you'.",
    "sayThisLine": "Annyeonghaseyo."
  },
  "listenFor": [
    "Five syllables",
    "Polite ending"
  ]
}
```

### 2.12 `estimate-slider`

**Sample 1** (lesson `dbt-01`)

```json
{
  "prompt": "Standard idol contract cap, in years?",
  "unit": "years",
  "min": 1,
  "max": 15,
  "step": 1,
  "correctValue": 7,
  "tolerance": {
    "full": 0,
    "partial": 1
  },
  "explanation": {
    "correct": "Seven years is the widely cited cap in standard contracts since the FTC stepped in. Verify the current rule at release.",
    "incorrect": "The commonly cited cap is seven years, reached after the long-contract controversy.",
    "sayThisLine": "The standard is seven years, right?"
  }
}
```

**Sample 2** (lesson `cbk-04`)

```json
{
  "prompt": "Korea is how many hours ahead of US Eastern?",
  "unit": "hours",
  "min": 0,
  "max": 20,
  "step": 1,
  "correctValue": 14,
  "tolerance": {
    "full": 0,
    "partial": 2
  },
  "explanation": {
    "correct": "In US standard time, Korea is 14 hours ahead, so a 6 p.m. release there is about 4 a.m. in the US East. Daylight saving changes it by one hour.",
    "incorrect": "Korea is UTC+9. US Eastern is UTC-5 in standard time, so 14 hours ahead.",
    "sayThisLine": "What time will the drop be for us?"
  }
}
```

**Sample 3** (lesson `trn-02`)

```json
{
  "prompt": "Typical trainee time before debut?",
  "unit": "years",
  "min": 0,
  "max": 10,
  "step": 1,
  "correctValue": 3,
  "tolerance": {
    "full": 1,
    "partial": 2
  },
  "explanation": {
    "correct": "Many trainees train around two to four years, but it ranges from months to ten or more. This is an average, not a rule.",
    "incorrect": "It varies a lot. A typical range is a few years, with big outliers.",
    "sayThisLine": "How long were they trainees?"
  }
}
```

### 2.13 `hotspot-tap`

**Sample 1** (lesson `liv-01`)

```json
{
  "prompt": "Tap the standing floor area.",
  "diagram": {
    "diagramId": "kpop-arena-plan",
    "aspectRatio": 1.5,
    "alt": "A simple arena plan: a stage at the top, a floor zone in front, raised seats around the sides."
  },
  "hotspots": [
    {
      "id": "stage",
      "label": "Stage",
      "shape": {
        "kind": "rect",
        "x": 0.3,
        "y": 0.02,
        "w": 0.4,
        "h": 0.15
      }
    },
    {
      "id": "floor",
      "label": "Standing floor",
      "shape": {
        "kind": "rect",
        "x": 0.25,
        "y": 0.22,
        "w": 0.5,
        "h": 0.3
      }
    },
    {
      "id": "seats",
      "label": "Raised seats",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.6,
        "w": 0.9,
        "h": 0.3
      }
    }
  ],
  "correctHotspotIds": [
    "floor"
  ],
  "explanation": {
    "correct": "The floor is the standing area nearest the stage. Seats are the raised tiers.",
    "incorrect": "The floor is the open area in front of the stage. Seats are the tiers.",
    "sayThisLine": "Floor or seats for you?"
  }
}
```

**Sample 2** (lesson `alb-01`)

```json
{
  "prompt": "Tap where the photocard usually sits.",
  "diagram": {
    "diagramId": "kpop-album-kit",
    "aspectRatio": 1.5,
    "alt": "An unfolded album kit with a photobook, a disc sleeve and a small card pocket."
  },
  "hotspots": [
    {
      "id": "book",
      "label": "Photobook",
      "shape": {
        "kind": "rect",
        "x": 0.05,
        "y": 0.1,
        "w": 0.55,
        "h": 0.8
      }
    },
    {
      "id": "disc",
      "label": "Disc sleeve",
      "shape": {
        "kind": "rect",
        "x": 0.62,
        "y": 0.1,
        "w": 0.33,
        "h": 0.35
      }
    },
    {
      "id": "card",
      "label": "Photocard pocket",
      "shape": {
        "kind": "rect",
        "x": 0.62,
        "y": 0.55,
        "w": 0.33,
        "h": 0.3
      }
    }
  ],
  "correctHotspotIds": [
    "card"
  ],
  "explanation": {
    "correct": "Photocards are usually tucked in a small pocket or sleeve in the kit.",
    "incorrect": "Look for the small pocket beside the disc sleeve. The photobook is the big pages.",
    "sayThisLine": "Did you get the card you wanted?"
  }
}
```

**Sample 3** (lesson `cbk-02`)

```json
{
  "prompt": "Tap the tracklist reveal.",
  "diagram": {
    "diagramId": "kpop-comeback-timeline",
    "aspectRatio": 1.5,
    "alt": "A horizontal timeline of comeback week with date poster, concept photo, tracklist, preview and MV teaser."
  },
  "hotspots": [
    {
      "id": "date",
      "label": "Date poster",
      "shape": {
        "kind": "rect",
        "x": 0.03,
        "y": 0.4,
        "w": 0.16,
        "h": 0.2
      }
    },
    {
      "id": "concept",
      "label": "Concept photos",
      "shape": {
        "kind": "rect",
        "x": 0.22,
        "y": 0.4,
        "w": 0.16,
        "h": 0.2
      }
    },
    {
      "id": "tracklist",
      "label": "Tracklist",
      "shape": {
        "kind": "rect",
        "x": 0.41,
        "y": 0.4,
        "w": 0.16,
        "h": 0.2
      }
    },
    {
      "id": "preview",
      "label": "Preview medley",
      "shape": {
        "kind": "rect",
        "x": 0.6,
        "y": 0.4,
        "w": 0.16,
        "h": 0.2
      }
    },
    {
      "id": "mv",
      "label": "MV teaser",
      "shape": {
        "kind": "rect",
        "x": 0.79,
        "y": 0.4,
        "w": 0.16,
        "h": 0.2
      }
    }
  ],
  "correctHotspotIds": [
    "tracklist"
  ],
  "explanation": {
    "correct": "The tracklist comes after the concept images and before the preview.",
    "incorrect": "It is the third step: date, concept, tracklist.",
    "sayThisLine": "Has the tracklist dropped?"
  }
}
```

## 3. Playbook terms (68)

Definition plus an example line in the enthusiast's voice. Romanization follows the Revised Romanization of Korean; common fan spellings are noted. Hangul is shown so the learner can recognise it, never required.

| Term | Korean / romanization | Definition | Example line |
|---|---|---|---|
| Idol | 아이돌 (aidol) | A performer trained and packaged by an agency to sing, dance and build a public persona. | "They're idols, so they're trained at everything: singing, dance, cameras." |
| Hallyu | 한류 | The Korean Wave: the global spread of Korean pop culture, music, TV and film. | "Hallyu is bigger than K-pop; dramas and films helped." |
| Agency | 소속사 (sosokssa) | The company that manages an act: training, releases, contracts and promotion. | "Who's their agency? That changes the style." |
| Trainee | 연습생 (yeonseupsaeng) | Someone training at an agency before debut. | "She was a trainee for years before debut." |
| Audition | 오디션 | A tryout to enter an agency as a trainee. | "There's an open audition next month." |
| Survival show | 서바이벌 | A competition show that forms a group or ranks trainees. | "The group formed on a survival show." |
| Debut | 데뷔 (debwi) | The first official release of a group or solo act. | "Their debut was a banger." |
| Rookie | 신인 (sinin) | An act in its first year or two after debut. | "It's a rookie year, so the rookie awards are a big deal." |
| Generation | 세대 | Fan shorthand for a wave of groups by debut era; boundaries are debated. | "Fourth gen sounds different from second gen." |
| Comeback | 컴백 (keombaek) | A new release era, not necessarily a return from a break. | "They're back with a new comeback in March." |
| Era | 시대 | A release cycle with its own look, concept and sound. | "I love their dark era." |
| Concept | 콘셉트 (konsepteu) | The theme, styling and story of a release. | "The concept this time is a school mystery." |
| Title track | 타이틀곡 (taiteulgok) | The focus song of a release, used for the MV and music show stages. | "The title track hit me instantly." |
| B-side | 수록곡 (surokgok) | A non-focus song on an album; Korean: subsidiary track. | "The B-sides are the real album." |
| Tracklist | 트랙리스트 | The list of songs on a release, often revealed during teasers. | "The tracklist dropped this morning." |
| Teaser | 티저 | A short preview, image or video released before a comeback. | "The first teaser is a one-word poster." |
| Music video (MV) | 뮤직비디오 | The official video; fans watch for story and choreography. | "The MV has a hidden story." |
| Dance practice | 안무 영상 (anmu yeongsang) | A video of the group dancing in practice clothes, often one shot. | "Watch the dance practice for the formations." |
| Fancam | 직캠 (jikkaem) | A video filmed or edited to follow one member; also spelled jikcam. | "His fancam from that stage is unreal." |
| Music show | 음악방송 (eumak bangsong) | A weekly TV show with stages and a win. | "We have three music shows this week." |
| Win | 1위 (irwi) | A first-place result on a weekly show's chart formula. | "They got their first win!" |
| Triple crown | 트리플 크라운 | A milestone of three wins; the exact definition varies by show. | "We're one win from a triple crown." |
| All-kill | 올킬 | Topping all the main Korean real-time charts at once. | "It's an all-kill on release day." |
| Encore stage | 앙코르 무대 | A special replay stage after a win. | "The encore stage was emotional." |
| Circle Chart | 서클차트 | Korea's official national music charts, formerly the Gaon Chart. | "Check the Circle Chart for the week." |
| Hanteo | 한터 | A Korean album sales tracker widely used by fans. | "Hanteo numbers are up." |
| Melon | 멜론 | A major Korean streaming service with its own chart. | "Melon is the one everyone watches." |
| Daesang | 대상 | The grand prize at awards shows. | "They won daesang!" |
| Bonsang | 본상 | A main category prize at awards shows. | "A bonsang is already a huge win." |
| Fandom | 팬덤 (paendeom) | The community of fans of an act, usually with a name. | "The fandom is already planning the lights." |
| Lightstick | 응원봉 (eungwonbong) | An official handheld light fans carry at concerts. | "Don't forget the lightstick." |
| Fan chant | 응원법 (eungwonbeop) | A scripted call-and-response fans do during songs. | "Learn the fan chant before the show." |
| Slogan | 슬로건 | A fan banner or towel with a message shown at a set moment. | "The slogan event is at the final song." |
| Bias | 최애 (choeae) | A fan's favourite member; choeae means most loved. | "Who's your bias?" |
| Bias wrecker | - | A member who threatens a fan's loyalty to her bias. | "He's my bias wrecker." |
| Ult | - | Ultimate bias: the very favourite of all. | "She's my ult." |
| Stan | - | To support an act enthusiastically; also a name for a devoted fan. | "I stan this group." |
| Ipdeok | 입덕 | Falling into a fandom. | "My ipdeok was sudden." |
| Taldeok | 탈덕 | Leaving a fandom. | "She did a taldeok, but came back." |
| Deokhu | 덕후 | A devoted fan of something. | "I'm a deokhu for this show." |
| Sasaeng | 사생 | An obsessive fan who invades an idol's privacy; condemned by other fans. | "Sasaeng behaviour is never okay." |
| Maknae | 막내 | The youngest member of a group. | "The maknae is full of energy." |
| Leader | 리더 | The group's organiser and spokesperson. | "The leader handled the speech." |
| Center | 센터 | The spotlight position in formations. | "She's the center for this song." |
| Visual | 비주얼 | A role emphasising image and look in a concept. | "The visual was in every poster." |
| Main vocal | 메인 보컬 | The strongest lead singing role. | "The main vocal took the high notes." |
| Rapper line | 랩 라인 | The group's rapping members. | "The rap line wrote this verse." |
| Subunit | 유닛 | A smaller group formed from members of a larger one. | "The subunit released a single." |
| Oppa | 오빠 | A woman to an older male friend or brother. | "She calls him oppa." |
| Noona | 누나 | A man to an older female friend or sister. | "He calls her noona." |
| Hyung | 형 | A man to an older male friend or brother. | "He called him hyung." |
| Eonni | 언니 | A woman to an older female friend or sister; often spelled unnie. | "She calls her eonni." |
| Sunbae | 선배 (sunbae) | A senior in a field or school; used for older artists. | "He's my sunbae in the industry." |
| Hoobae | 후배 (hubae) | A junior in a field; spelled hubae in RR. | "The hoobae group bowed." |
| Hwaiting | 화이팅 | Go for it! Cheers of encouragement; fighting! | "Hwaiting, you can do it." |
| Aegyo | 애교 | Cute behaviour displayed on purpose, a playful trait. | "She did aegyo for the camera." |
| Daebak | 대박 | Awesome, amazing, or huge; a big hit. | "Daebak! That was incredible." |
| Mukbang | 먹방 | A broadcast of eating; sometimes a variety segment. | "They did a mukbang for fans." |
| Fansign | 팬싸인회 (paensainhoe) | An event where fans meet idols and get signed items. | "I won the fansign lottery." |
| Fan meeting | 팬미팅 | A small fan event with games, talk and performances. | "The fan meeting was cozy." |
| Photocard | 포토카드 | A collectible card packed in albums. | "I'm looking for that photocard." |
| Lucky draw | 럭키드로우 | A store draw for prizes like fansign chances. | "I entered the lucky draw." |
| Pre-order benefit | 예약 특전 | A bonus item for pre-ordering at a particular shop. | "The benefit is a limited card." |
| Ment | 멘트 | The talk between songs at a concert. | "Her ment made me cry." |
| Kalgunmu | 칼군무 | Precision group dance, literally 'knife-sharp group dance'. | "That kalgunmu was flawless." |
| MR | 엠알 | A backing track used for performances; means music recorded. | "They performed live over MR." |
| Concept film | 컨셉 필름 | A short story-like film that previews the release's concept. | "The concept film is a mini movie." |
| Year-end show | 연말 무대 | Season-end broadcasts with special collaborations and stages. | "The year-end show had surprise collabs." |

## 4. Talk Track scenarios (8)

### 4.1 It's comeback day (`tt-comeback-day`, lesson `cnv-02`)

- **Setting:** Texting at lunchtime
- **She says:** "IT'S COMEBACK DAY. I've been up since 5."
- **Meaning:** She is excited: a new release just dropped and she is up early to catch it.

| Reply | Kind | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Tell me what I'm about to hear. What's your first impression? | good | +22 | She sends three voice notes. You are in. | Curiosity beats a fake opinion. |
| Cool. Is it good? | meh | +2 | 'Yes?? It just came out, how would I know yet.' | Ask what she hears, not for a verdict. |
| Another comeback? They do that a lot. | cringe | -14 | 'Wow. Okay.' | Do not belittle the thing she loves. |

**Closing note:** You asked her to teach you, and that is the whole game.

### 4.2 The bias wrecker (`tt-bias-wrecker`, lesson `cnv-01`)

- **Setting:** Watching a video together
- **She says:** "Ugh, my bias wrecker is on again."
- **Meaning:** A bias wrecker is a member who is not her favourite yet keeps pulling her attention.

| Reply | Kind | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Wait, who's the wrecker? And who is your actual bias? | good | +22 | She grins and explains both. | You learned two terms by asking. |
| What's a wrecker? | meh | +6 | 'The one who ruins your loyalty. Keep up!' | Honest, but try asking who it is. |
| I'll guess: the one everyone thinks is hot. | cringe | -16 | 'That is not how this works.' | Do not guess based on looks. |

**Closing note:** Bias and wrecker: both are about the heart, not a ranking.

### 4.3 Favourite member (`tt-favourite-member`, lesson `cnv-03`)

- **Setting:** At dinner
- **She says:** "Do you want to know who my bias is?"
- **Meaning:** She is inviting you into something personal.

| Reply | Kind | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Yes, please. And what do you love about them? | good | +24 | She lights up and tells you a story. | Asking why is warmer than naming a rank. |
| Sure. Let me guess? | meh | +5 | 'Go ahead.' | Guessing can work if it is playful, not a test. |
| Doesn't everyone pick the same one? | cringe | -15 | 'No. Wow.' | Never rank or compare members to her face. |

**Closing note:** You made room for her.

### 4.4 Stream goal stress (`tt-stream-goal`, lesson `cnv-04`)

- **Setting:** Late evening
- **She says:** "We need forty thousand more streams before midnight."
- **Meaning:** A fandom goal is running; she feels pressure to help hit it.

| Reply | Kind | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Want company? I can keep the playlist running while you take a breather. | good | +22 | She says thanks and relaxes. | Support her pace; it is not a duty. |
| Is that a lot? | meh | +4 | 'It is a lot. But it is doable.' | Ask what it means, not only the number. |
| It's just numbers, who cares? | cringe | -18 | 'I care.' | Never dismiss a shared goal. |

**Closing note:** You helped without taking over.

### 4.5 Fan club presale (`tt-ticket-fandom`, lesson `cnv-05`)

- **Setting:** Pre-on-sale day
- **She says:** "My fan club level might not get me the presale."
- **Meaning:** Presale access differs by fan-club level and country; she is anxious.

| Reply | Kind | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Want to plan backups together? Different nights, different prices? | good | +22 | 'Yes, please.' She feels supported. | Offer a plan, not just comfort. |
| That's annoying. | meh | +5 | 'Yeah.' | Sympathy is fine; add a next step. |
| Just buy from a reseller. | cringe | -12 | 'Those are scams half the time.' | Do not push risky resale. |

**Closing note:** A plan beats panic.

### 4.6 A sensitive story (`tt-hard-topic`, lesson `cnv-06`)

- **Setting:** Quiet chat
- **She says:** "Did you see the news about that group's agency?"
- **Meaning:** She brings up an industry controversy and wants your take.

| Reply | Kind | Smooth | Her response | Coach note |
|---|---|---|---|---|
| I saw the headline but not the details. What's your read? | good | +22 | She explains carefully and you both stay calm. | Honest not-knowing is great. |
| That is messed up. | meh | -2 | 'We do not know yet.' | Avoid verdicts on disputes before facts. |
| I heard they did something awful. | cringe | -18 | 'Where did you hear that?' | Never repeat rumours as facts. |

**Closing note:** You asked, listened and did not speculate.

### 4.7 I don't know this one (`tt-not-know`, lesson `cnv-07`)

- **Setting:** Sunday afternoon
- **She says:** "You didn't know about the song before it was a meme?"
- **Meaning:** She is teasing; she wants to know if you keep up.

| Reply | Kind | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Nope, I only just found out. Show me the original? | good | +22 | She happily shows you. | Admitting it is charming. |
| Everyone knows it. | meh | -4 | 'Do they?' | Do not bluff. |
| Yeah, I knew it all along. | cringe | -20 | 'Okay, then what's it called?' | Faking expertise is caught fast. |

**Closing note:** Curiosity wins.

### 4.8 Your turn (`tt-share-yours`, lesson `cnv-08`)

- **Setting:** Post-concert walk
- **She says:** "What are you into?"
- **Meaning:** She is asking about you; she wants a real exchange.

| Reply | Kind | Smooth | Her response | Coach note |
|---|---|---|---|---|
| Honestly I'm into [your thing]. Want to hear why? | good | +24 | 'Yes!' The conversation is mutual. | Be yourself; shared ground is better than copying. |
| Not much, I like what you like. | meh | -3 | 'Hm.' | Mirroring is flattering but flat. |
| K-pop. Only K-pop now. | cringe | -16 | 'You do not have to say that.' | Do not perform a new identity. |

**Closing note:** Sharing your own taste is the point.

## 5. Talk Track roster at launch (20)

1. `tt-comeback-day`
2. `tt-bias-wrecker`
3. `tt-favourite-member`
4. `tt-stream-goal`
5. `tt-ticket-fandom`
6. `tt-hard-topic`
7. `tt-not-know`
8. `tt-share-yours`
9. `tt-lightstick-check (live-liv)`
10. `tt-fan-translation-credit (fan-06)`
11. `tt-photocard-trade (alb-02)`
12. `tt-awards-night (shw-06)`
13. `tt-variety-clip (cnt-05)`
14. `tt-parasocial-check (dbt-05)`
15. `tt-fandom-pileon (dbt-06)`
16. `tt-concert-recap (liv-01)`
17. `tt-her-era (now-03)`
18. `tt-no-ranking (cnv-03)`
19. `tt-cultural-respect (dbt-07)`
20. `tt-sunbae-fan (brl-02)`

The first eight are written above; the rest follow the same structure (curious good reply, flat meh reply, bluffing cringe reply) when curriculum JSON is authored.

## 6. Asset needs (all `original-swoond`)

| Asset | Count | Notes |
|---|---|---|
| Synthesised audio clips (chant gaps, genre switch, meter, build, variety sketch) | ~40 | Original synth or commissioned composer under work-for-hire; never a clone of a real song. |
| Korean word recordings | ~25 | Commissioned native-speaker recordings (greetings, fan words); contract covers app use. |
| Procedural illustrations (lightstick, photocard, banner, album kit, arena plan, formation) | ~30 | Generic designs only; no real lightstick, logo or member likeness. |
| Diagrams (comeback timeline, chart map, music-show calendar) | ~10 | Drawn natively from data. |

## 7. Voice and safety notes

- Voice: cheeky coach, playful, never mean, never about the crush. One joke per screen.
- Never grade her taste or rank members. Coach notes reward asking and listening.
- Wellbeing and controversy items use safe-messaging rules: no methods, no speculation about real people, point to real support, a `safetyNote` where relevant.
- Never teach stalking, tracking or approaching idols outside official events. Privacy items are framed as respect.
- No real member names or quotes are put in anyone's mouth; invented examples use generic roles.
