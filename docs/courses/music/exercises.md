# Native Exercise Plan: Music (`music`)

Tier B plan for `docs/courses/music/`. All 13 native exercise types are used; there are **no Unity sims** (CDS section 12). Sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup when this file was generated; 51 samples, 0 failures). Conventions: prompts of 12 words or fewer, explanations that teach and are 25+ characters, per-option notes where useful, `sayThisLine` is a natural sentence for the learner to say; all names are invented and no lyrics or real recordings are used.

**Rights guardrail (spec sections 20 and 40).** `listening-id` audio is original synthesised or produced audio only (licence id `original-swoond`) or an explicit registered licence; sample `audio.asset` paths below point to *to-be-produced* clips (section 6 lists specs). No recording is redistributed and no lyric is reproduced.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | The default knowledge check and Daily Bite card. Used for definitions, credits, "which is true" checks and industry logic. Distractors are the misconceptions in CDS section 2. | ~260 |
| `binary-call` | Two-way judgment calls with no diagram needed: master or publishing, sample or interpolation, major or minor, earplugs or not. `scene.kind` is `none` (with an `alt`) because there is no court or field; a `ruleTag` names the idea. | ~130 |
| `term-match` | Introduce 3 to 6 related terms at the start of a unit (song parts, credits, ticket terms, release formats, DJ terms). | ~60 |
| `sequence-order` | Ordering song form, a concert night, how a record is made, an album rollout, a festival day. Order is the concept; per-step `why` carries the logic. | ~30 |
| `visual-id` | Recognising instruments, vinyl variants, venue types and mixer parts from original vector illustrations (`original-swoond`); no photographs, logos or album art. | ~30 |
| `decision-scenario` | Judgment: ticket queues and budgets, festival clashes, hearing protection, crowd safety, handling fandom conflict. Facts table plus consequences; `expertNote` always; `safetyNote` on hearing/crowd items. | ~60 |
| `talk-track` | Conversation practice: 20 tracks at launch (roster below). Smooth meter; replies model curiosity over expertise. | ~20 |
| `timing-tap` | 1D rhythm only: backbeat, dembow, beatmatching, split-second pulse. One sweep equals one bar so the gold zone marks a beat position. Anything scene-based would be Unity; nothing here needs it. | ~14 |
| `say-this` | Decode what she just said: hooks, eras, releases, ticket stress, fan slang. Every item has follow-ups that are honest curiosity and a `noFakeExpertNote` where useful. | ~150 |
| `fill-the-gap` | Vocabulary in context: backbeat, tension and resolution, release formats, mixing terms. A quick review card. | ~60 |
| `listening-id` | The star of the course: original synthesised clips (`original-swoond`) that teach tempo, meter, backbeat, swing, major/minor, chord colour, bass line, stereo width, builds/drops and generic genre sketches. Every clip has a text `description` (schema-required) and a Skip path; a non-audio equivalent sits in the same unit. | ~80 |
| `estimate-slider` | Magnitudes: BPM, decibels, stream-to-album-unit ratios (dated), venue capacities, festival set lengths. | ~20 |
| `hotspot-tap` | Static diagrams: song map bar, venue floor plan, mixer strip, keyboard octave. Where, not when. | ~20 |

Estimated totals: about 934 native items across 119 lessons and the review loop (four planned activity families per lesson, several items per family, plus review pools). Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap`, `term-match` and `binary-call`; every `listening-id` has a non-audio companion.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

The default knowledge check and Daily Bite card. Used for definitions, credits, "which is true" checks and industry logic. Distractors are the misconceptions in CDS section 2.

**Sample 1** (lesson `song-02`)

```json
{
  "prompt": "What is the difference between a hook and a chorus?",
  "options": [
    {
      "id": "a",
      "text": "A hook is a catchy idea; a chorus is a whole repeated section",
      "explanation": "Right. A chorus can contain the hook, but a hook can be a riff, a beat or a two-word phrase anywhere."
    },
    {
      "id": "b",
      "text": "They are two names for the same thing",
      "explanation": "Common mix-up. Fans use them loosely, but they are not identical."
    },
    {
      "id": "c",
      "text": "The hook is always the first line of the verse",
      "explanation": "Hooks can appear in any section, including an intro riff."
    },
    {
      "id": "d",
      "text": "The chorus is only found in slow songs",
      "explanation": "Choruses appear in every tempo and genre."
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "A hook is the small idea that grabs you; a chorus is a section that repeats. Often the hook lives inside the chorus, which is why people blur them.",
    "incorrect": "A chorus is a repeated section. A hook is the catchy idea, which may be a riff, a beat or a phrase anywhere in the song.",
    "sayThisLine": "Is that the hook, or is the whole chorus doing it?"
  }
}
```

**Sample 2** (lesson `rel-04`)

```json
{
  "prompt": "A label owns the master. What does that mean?",
  "options": [
    {
      "id": "a",
      "text": "It owns one specific recording of a song"
    },
    {
      "id": "b",
      "text": "It owns the words and melody forever, in every recording"
    },
    {
      "id": "c",
      "text": "It owns the artist's stage name"
    },
    {
      "id": "d",
      "text": "It owns the concert tickets"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "The master is a particular recording. The song itself (words and melody) is the publishing side, and it can belong to someone else, which is why re-recording is a thing.",
    "incorrect": "The master is the specific recording, not the song's words and melody. Those are publishing, and they can have different owners.",
    "sayThisLine": "So who owns the recording, and who owns the song itself?"
  }
}
```

**Sample 3** (lesson `live-03`)

```json
{
  "prompt": "What does a \"verified fan\" presale usually try to do?",
  "options": [
    {
      "id": "a",
      "text": "Screen out bots and resellers before tickets go on sale"
    },
    {
      "id": "b",
      "text": "Guarantee every applicant a ticket"
    },
    {
      "id": "c",
      "text": "Lower the ticket price for members"
    },
    {
      "id": "d",
      "text": "Let you pick any seat for free"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "Verified fan systems try to filter automated buyers and give real fans a shot. They rarely guarantee a ticket, because demand can far exceed supply.",
    "incorrect": "A verified fan presale screens for real fans and blocks bots. It does not guarantee a ticket or a lower price.",
    "sayThisLine": "Did you get a verified fan code, or are we praying?"
  }
}
```

**Sample 4** (lesson `hist-06`)

```json
{
  "prompt": "Which pair best explains how streaming changed song writing?",
  "options": [
    {
      "id": "a",
      "text": "Shorter intros and earlier hooks, because skips are counted"
    },
    {
      "id": "b",
      "text": "Longer intros, because listeners are more patient"
    },
    {
      "id": "c",
      "text": "No change, because songs are written the same way"
    },
    {
      "id": "d",
      "text": "Songs got fewer choruses to save space on servers"
    }
  ],
  "correctOptionIds": [
    "a"
  ],
  "explanation": {
    "correct": "When a skip can hurt a song's performance, writers often get to the hook faster. It is a trend, not a law, and plenty of songs still take their time.",
    "incorrect": "Streaming rewards keeping listeners past the first seconds, so many writers put the hook earlier. It is a trend, not a rule.",
    "sayThisLine": "Do you feel like songs get to the point faster now?"
  }
}
```

### 2.2 `binary-call`

Two-way judgment calls with no diagram needed: master or publishing, sample or interpolation, major or minor, earplugs or not. `scene.kind` is `none` (with an `alt`) because there is no court or field; a `ruleTag` names the idea.

**Sample 1** (lesson `rel-04`)

```json
{
  "prompt": "A label owns a recording. Which right is that?",
  "scene": {
    "kind": "none",
    "alt": "Text question with no diagram: a label owns a specific recording of a song."
  },
  "choices": [
    {
      "id": "master",
      "label": "Master rights"
    },
    {
      "id": "publishing",
      "label": "Publishing rights"
    }
  ],
  "correctChoiceId": "master",
  "explanation": {
    "correct": "The master is the specific recording. Publishing is the song itself (melody and words), which a writer or publisher can own separately.",
    "incorrect": "Publishing covers the song; the master covers one particular recording of it. A label's ownership of a recording is a master right.",
    "sayThisLine": "Is it the recording or the song that is in dispute?"
  },
  "ruleTag": "Master vs publishing"
}
```

**Sample 2** (lesson `prod-06`)

```json
{
  "prompt": "She re-sings the melody in a studio. Sample or interpolation?",
  "scene": {
    "kind": "none",
    "alt": "Text question with no diagram: a new performance of an existing melody."
  },
  "choices": [
    {
      "id": "sample",
      "label": "Sample"
    },
    {
      "id": "interpolation",
      "label": "Interpolation"
    }
  ],
  "correctChoiceId": "interpolation",
  "explanation": {
    "correct": "An interpolation re-records or recreates the melody or line; a sample reuses the original recording itself. The legal paperwork differs, which is why songwriters sometimes choose one over the other.",
    "incorrect": "A sample reuses the actual old recording. Re-performing the melody yourself is an interpolation.",
    "sayThisLine": "Did they sample the record or replay the tune?"
  },
  "ruleTag": "Sampling terms"
}
```

**Sample 3** (lesson `harm-02`)

```json
{
  "prompt": "Wistful, shadowed, 2 a.m. in the car. Major or minor?",
  "scene": {
    "kind": "none",
    "alt": "Text question with no diagram: choose the scale that matches a wistful shadowed mood."
  },
  "choices": [
    {
      "id": "major",
      "label": "Major"
    },
    {
      "id": "minor",
      "label": "Minor"
    }
  ],
  "correctChoiceId": "minor",
  "explanation": {
    "correct": "Minor scales tend to sound darker and more wistful; major sounds brighter. It is a tendency, not a law, and plenty of sad songs are in major with sad words.",
    "incorrect": "Minor is the note set most often tied to a wistful or shadowed mood. Major usually sounds brighter.",
    "sayThisLine": "Does this one feel major or minor to you?"
  },
  "ruleTag": "Major and minor"
}
```

**Sample 4** (lesson `live-06`)

```json
{
  "prompt": "It is very loud in the pit. Earplugs or tough it out?",
  "scene": {
    "kind": "none",
    "alt": "Text question with no diagram: loud concert, decide about hearing protection."
  },
  "choices": [
    {
      "id": "earplugs",
      "label": "Wear earplugs"
    },
    {
      "id": "tough",
      "label": "Tough it out"
    }
  ],
  "correctChoiceId": "earplugs",
  "explanation": {
    "correct": "Concert volume can be high enough to cause hearing damage over a night, and concert earplugs lower volume evenly so music still sounds clear. Ringing afterwards is a sign to protect your ears next time.",
    "incorrect": "Music can stay loud for hours, and hearing damage can build without pain. Earplugs made for music keep the sound clear while protecting your ears.",
    "sayThisLine": "Do you take earplugs, or should I?"
  },
  "ruleTag": "Hearing care"
}
```

### 2.3 `term-match`

Introduce 3 to 6 related terms at the start of a unit (song parts, credits, ticket terms, release formats, DJ terms).

**Sample 1** (lesson `song-01`)

```json
{
  "prompt": "Match each part of a song to what it does.",
  "pairs": [
    {
      "id": "verse",
      "term": "Verse",
      "definition": "Tells the story; the words change, the tune stays"
    },
    {
      "id": "chorus",
      "term": "Chorus",
      "definition": "The big repeated part with the title and the tune you sing back"
    },
    {
      "id": "bridge",
      "term": "Bridge",
      "definition": "A contrast section that appears once, before the final chorus"
    },
    {
      "id": "outro",
      "term": "Outro",
      "definition": "The ending that winds a song down"
    }
  ],
  "distractorDefinitions": [
    "A quiet count-in before the band starts"
  ],
  "explanation": {
    "summary": "Verses set the scene, choruses are the part everyone sings, the bridge gives a change of view, and the outro closes it. Fans use these words constantly, so you can now decode \"the part where it goes quiet\".",
    "sayThisLine": "Is that the bridge, where it strips back?"
  }
}
```

**Sample 2** (lesson `prod-01`)

```json
{
  "prompt": "Match each credit to what that person does.",
  "pairs": [
    {
      "id": "songwriter",
      "term": "Songwriter",
      "definition": "Writes the melody and words"
    },
    {
      "id": "producer",
      "term": "Producer",
      "definition": "Shapes the overall sound and choices of a record"
    },
    {
      "id": "engineer",
      "term": "Audio engineer",
      "definition": "Records and balances the sound technically"
    },
    {
      "id": "session",
      "term": "Session musician",
      "definition": "Hired player who performs parts on someone else's record"
    }
  ],
  "explanation": {
    "summary": "Credits explain who did what. One person can do several jobs, especially in home studios, but knowing the roles lets you ask a great question: \"Who produced it?\"",
    "sayThisLine": "Who produced this one?"
  }
}
```

**Sample 3** (lesson `live-03`)

```json
{
  "prompt": "Match each ticket term to what it means.",
  "pairs": [
    {
      "id": "presale",
      "term": "Presale",
      "definition": "Early access before the general on-sale"
    },
    {
      "id": "dynamic",
      "term": "Dynamic pricing",
      "definition": "Price that moves with demand while on sale"
    },
    {
      "id": "face",
      "term": "Face value",
      "definition": "The original price printed on the ticket"
    },
    {
      "id": "resale",
      "term": "Resale",
      "definition": "A ticket sold on again by a fan or a broker"
    },
    {
      "id": "fees",
      "term": "Service fees",
      "definition": "Extra charges added on top of the ticket price"
    }
  ],
  "distractorDefinitions": [
    "A free upgrade to the pit"
  ],
  "explanation": {
    "summary": "Ticket words explain why the same show can cost different amounts. Knowing them lets you ask about fees before you check out.",
    "sayThisLine": "Was that the face value, or is it dynamic pricing?"
  }
}
```

### 2.4 `sequence-order`

Ordering song form, a concert night, how a record is made, an album rollout, a festival day. Order is the concept; per-step `why` carries the logic.

**Sample 1** (lesson `live-01`)

```json
{
  "prompt": "Put a typical arena show in order.",
  "items": [
    {
      "id": "doors",
      "text": "Doors open and the crowd files in",
      "why": "Everything starts with the crowd arriving, usually an hour or more before the first act."
    },
    {
      "id": "opener",
      "text": "Opening act plays a short set",
      "why": "The opener warms the room while the headliner's crew finishes preparing."
    },
    {
      "id": "changeover",
      "text": "Crew changes the stage (changeover)",
      "why": "Gear is swapped and checked between acts; this is the bathroom-and-drinks window."
    },
    {
      "id": "headliner",
      "text": "Headliner plays the main set",
      "why": "The artist people bought tickets for plays their full set."
    },
    {
      "id": "encore",
      "text": "Encore after a short break",
      "why": "By tradition the band leaves, the crowd calls them back, and the biggest hits often close."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Doors, opener, changeover, headliner, encore: the shape of nearly every concert. Knowing it means you arrive on time for the opener you might love and you do not leave before the encore.",
    "incorrect": "The order is doors, opener, changeover, headliner and encore. The crowd arrives first; the encore comes after the main set.",
    "sayThisLine": "Should we get there for the opener?"
  }
}
```

**Sample 2** (lesson `song-06`)

```json
{
  "prompt": "Order this pop song from start to finish.",
  "items": [
    {
      "id": "intro",
      "text": "Intro",
      "why": "A short opening to set the sound."
    },
    {
      "id": "verse1",
      "text": "Verse 1",
      "why": "Sets the scene at a lower energy."
    },
    {
      "id": "prechorus",
      "text": "Pre-chorus",
      "why": "Builds tension toward the chorus."
    },
    {
      "id": "chorus1",
      "text": "Chorus",
      "why": "The big release and the part you sing back."
    },
    {
      "id": "bridge",
      "text": "Bridge",
      "why": "A contrast before the last big chorus."
    },
    {
      "id": "chorus2",
      "text": "Final chorus",
      "why": "Often the biggest, sometimes with a key change."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Intro, verse, pre-chorus, chorus, bridge, final chorus is the classic shape. Many songs vary it, but this is the skeleton behind thousands of hits.",
    "incorrect": "The classic pop shape moves from intro through a verse and pre-chorus to the chorus, then a bridge and a last chorus.",
    "sayThisLine": "Where do you think the bridge lands in this one?"
  }
}
```

**Sample 3** (lesson `prod-02`)

```json
{
  "prompt": "Order how a record is made.",
  "items": [
    {
      "id": "write",
      "text": "Write the song",
      "why": "Everything begins with a melody, words and chords."
    },
    {
      "id": "demo",
      "text": "Record a demo",
      "why": "A rough version to test the idea."
    },
    {
      "id": "track",
      "text": "Track the parts (recording)",
      "why": "Musicians record drums, bass, keys and vocals, often layer by layer."
    },
    {
      "id": "mix",
      "text": "Mix the tracks",
      "why": "Balance levels, EQ and space so it sounds like one record."
    },
    {
      "id": "master",
      "text": "Master the mix",
      "why": "Final polish and consistency before it is released."
    }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Write, demo, track, mix, master. Real projects loop back (a producer may rewrite after the demo), but this is the standard route from idea to release.",
    "incorrect": "The usual route is write, demo, track, mix, then master. Mixing comes after all the parts are recorded.",
    "sayThisLine": "Did they record it live or layer it?"
  }
}
```

### 2.5 `visual-id`

Recognising instruments, vinyl variants, venue types and mixer parts from original vector illustrations (`original-swoond`); no photographs, logos or album art.

**Sample 1** (lesson `sound-01`)

```json
{
  "prompt": "Which illustration shows a typical rhythm section?",
  "image": {
    "asset": "img/music/rhythm-section-lineup.svg",
    "alt": "Original illustration of four stylised band members at instruments: one at a drum kit, one with a long-necked low-pitched stringed instrument, one with an electric guitar and one at a keyboard.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "drums-bass-guitar-keys",
      "text": "Drums, bass, rhythm guitar, keys",
      "explanation": "That is the classic pop and rock rhythm section: drums and bass lock the groove while guitar or keys fill the harmony."
    },
    {
      "id": "strings-only",
      "text": "A string quartet",
      "explanation": "A string quartet has two violins, viola and cello; there is no drum kit."
    },
    {
      "id": "brass-band",
      "text": "A brass band",
      "explanation": "A brass band has trumpets, trombones, tubas; not drums, electric guitar and keys."
    },
    {
      "id": "choir",
      "text": "A choir",
      "explanation": "A choir is voices only."
    }
  ],
  "correctOptionId": "drums-bass-guitar-keys",
  "explanation": {
    "correct": "Drums and bass are the heart of the rhythm section, with guitar or keys adding chords. Once you can name the band from a picture, you can hear who does what.",
    "incorrect": "The picture shows a drum kit, a bass, an electric guitar and a keyboard: the standard rhythm section of pop and rock.",
    "sayThisLine": "Is the bass doing anything interesting in this song?"
  },
  "cues": [
    "Drum kit = timekeeper",
    "Bass = low, long neck, few strings",
    "Guitar and keys = chords and colour"
  ]
}
```

**Sample 2** (lesson `rel-07`)

```json
{
  "prompt": "Which vinyl listing shows a picture-disc variant?",
  "image": {
    "asset": "img/music/vinyl-variants-row.svg",
    "alt": "Original illustration of four records side by side: a black disc, a solid-colour disc, a splatter-coloured disc and a disc with a printed picture across the vinyl itself.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "black",
      "text": "Standard black vinyl"
    },
    {
      "id": "colour",
      "text": "Solid colour vinyl"
    },
    {
      "id": "splatter",
      "text": "Splatter vinyl"
    },
    {
      "id": "picture",
      "text": "Picture disc"
    }
  ],
  "correctOptionId": "picture",
  "explanation": {
    "correct": "A picture disc has an image printed on the playing surface. They look great, but often sound a little noisier than standard pressings. Colour and splatter changes only the tint of the vinyl.",
    "incorrect": "A picture disc has an image printed across the record surface itself. Colour and splatter discs are just coloured or mottled vinyl.",
    "sayThisLine": "Is it a picture disc or a coloured variant?"
  },
  "cues": [
    "Picture disc = artwork across the surface",
    "Splatter = mottled colours",
    "Solid colour = single tint"
  ]
}
```

**Sample 3** (lesson `live-02`)

```json
{
  "prompt": "Which sketch looks like a club, not an arena?",
  "image": {
    "asset": "img/music/venue-sizes-sketch.svg",
    "alt": "Original illustration of two venue outlines side by side: a small room with a low stage and a bar along one wall, and a huge oval bowl with tiered seating and a big stage at one end.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "small-room",
      "text": "The small room with a low stage and a bar"
    },
    {
      "id": "oval-bowl",
      "text": "The oval bowl with tiered seating"
    }
  ],
  "correctOptionId": "small-room",
  "explanation": {
    "correct": "Clubs hold a few hundred people, with a low stage and standing space. Arenas hold thousands, with tiered seating and a big production. Intimacy versus spectacle is why fans love both for different reasons.",
    "incorrect": "Clubs are small rooms with a low stage; arenas are big bowls with tiered seating. The first sketch is the club.",
    "sayThisLine": "Is it a small room or a big arena?"
  },
  "cues": [
    "Low stage and a bar = club",
    "Tiered seats and a huge stage = arena"
  ]
}
```

### 2.6 `decision-scenario`

Judgment: ticket queues and budgets, festival clashes, hearing protection, crowd safety, handling fandom conflict. Facts table plus consequences; `expertNote` always; `safetyNote` on hearing/crowd items.

**Sample 1** (lesson `live-03`)

```json
{
  "prompt": "Presale is live and prices are jumping. What now?",
  "situation": {
    "narrative": "You are helping a friend buy tickets for a show she has wanted for years. You are in the queue when the price starts to climb.",
    "facts": [
      {
        "label": "Face-value tier",
        "value": "Sold out",
        "emphasis": "warning"
      },
      {
        "label": "Dynamic-priced tier",
        "value": "Rising while you wait"
      },
      {
        "label": "Fees",
        "value": "Shown only at checkout"
      },
      {
        "label": "Her budget",
        "value": "A firm limit she gave you"
      }
    ]
  },
  "options": [
    {
      "id": "stay-budget",
      "label": "Stick to her budget and skip the pricey tier",
      "verdict": "best",
      "consequence": "You stay within what she said. She may miss this show, but you avoided a decision that wasn't yours to make.",
      "considerations": [
        "Her budget is her decision",
        "Dynamic prices can drop or rise while on sale",
        "Check for a later on-sale or an official resale option"
      ]
    },
    {
      "id": "ask-quick",
      "label": "Text her the current price and ask",
      "verdict": "acceptable",
      "consequence": "You may lose your place in the queue while you wait, but she stays in control.",
      "considerations": [
        "Respectful of her wallet",
        "Timing risk in a fast queue"
      ]
    },
    {
      "id": "overspend",
      "label": "Buy anyway to impress her",
      "verdict": "poor",
      "consequence": "You spent her money or yours in a panic and made the trip about the ticket instead of her.",
      "considerations": [
        "Pressure buying is what dynamic pricing is designed to trigger",
        "A nice gesture should not create stress"
      ]
    }
  ],
  "expertNote": "Experienced fans decide a budget first, know which official resale channel to check, and never rush into fees they have not seen. Prices that move with demand are a design choice, not a personal insult.",
  "sayThisLine": "Do you want me to go higher or should we wait for another drop?"
}
```

**Sample 2** (lesson `live-05`)

```json
{
  "prompt": "Two acts you both want overlap. Pick a plan.",
  "situation": {
    "narrative": "At a festival, the headliner she loves overlaps with a smaller band you were curious about.",
    "facts": [
      {
        "label": "Headliner set",
        "value": "8:30 to 9:45 pm"
      },
      {
        "label": "Smaller act",
        "value": "8:45 to 9:30 pm"
      },
      {
        "label": "Walk between stages",
        "value": "About 12 minutes"
      },
      {
        "label": "Her priority",
        "value": "The full headliner set"
      }
    ]
  },
  "options": [
    {
      "id": "stay",
      "label": "Stay for the whole headliner set with her",
      "verdict": "best",
      "consequence": "She gets the night she wanted, and you have a story to ask her about. Curiosity can wait for the next set.",
      "considerations": [
        "It is her moment",
        "You can listen to the smaller band later"
      ]
    },
    {
      "id": "split",
      "label": "Catch 15 minutes of the small act first, then rejoin",
      "verdict": "acceptable",
      "consequence": "You get a taste but walk in late, and the crowd is thick.",
      "considerations": [
        "Ask first",
        "Meet at a fixed spot in case you lose each other"
      ]
    },
    {
      "id": "ditch",
      "label": "Wander off without telling her",
      "verdict": "poor",
      "consequence": "You lose each other in a crowd with bad reception, and she spends her favourite set worrying.",
      "considerations": [
        "Always agree a meeting point",
        "A festival is not the time to disappear"
      ]
    }
  ],
  "expertNote": "Festival veterans agree on a meeting spot, share their location, and plan the must-sees first. Clashes are normal; the schedule rarely favours everyone.",
  "sayThisLine": "Which set do you not want to miss?"
}
```

**Sample 3** (lesson `live-06`)

```json
{
  "prompt": "Your ears are ringing after the first hour. Now what?",
  "situation": {
    "narrative": "Mid-show, everything sounds muffled and there is a faint ringing.",
    "facts": [
      {
        "label": "Show length",
        "value": "About two more hours"
      },
      {
        "label": "Where you stand",
        "value": "Right next to the speakers",
        "emphasis": "warning"
      },
      {
        "label": "You have",
        "value": "Foam earplugs in your bag"
      }
    ]
  },
  "options": [
    {
      "id": "plugs-move",
      "label": "Put in earplugs and move away from the speakers",
      "verdict": "best",
      "consequence": "Sound stays clear enough to enjoy and your ears get a break. You can still feel the bass.",
      "considerations": [
        "Ringing after loud sound is a warning sign",
        "Farther from speakers is much quieter",
        "Concert earplugs keep music clear"
      ]
    },
    {
      "id": "keep",
      "label": "Keep standing there without protection",
      "verdict": "poor",
      "consequence": "Ringing may last hours or longer, and repeated exposure can cause lasting damage.",
      "considerations": [
        "Damage can build without pain"
      ]
    },
    {
      "id": "leave",
      "label": "Leave and never go to loud shows again",
      "verdict": "acceptable",
      "consequence": "You protect your ears, but you have overreacted; earplugs would have let you stay.",
      "considerations": [
        "You can enjoy shows with protection"
      ]
    }
  ],
  "expertNote": "Sound-savvy fans wear earplugs designed for music, avoid standing directly at the speaker stacks, and give their ears quiet time afterward. If ringing lasts, they see a professional.",
  "sayThisLine": "Should I bring earplugs for you too?",
  "safetyNote": "General guidance only, not medical advice. If ringing or muffled hearing persists, see a hearing professional."
}
```

### 2.7 `talk-track`

Conversation practice: 20 tracks at launch (roster below). Smooth meter; replies model curiosity over expertise.

**Sample 1** (lesson `talk-01`) - Track id `tt-new-album`.

```json
{
  "title": "Have you heard the new album?",
  "setting": "Texting on release Friday",
  "exchanges": [
    {
      "theirMessage": "It is out!! I stayed up until midnight and the last track destroyed me.",
      "replies": [
        {
          "id": "curious",
          "text": "Midnight listen, love that. What was it about the last track?",
          "smoothDelta": 20,
          "theirResponse": "The build in the second half. I did not expect it.",
          "coachNote": "Curious and specific. You asked about her experience, not the facts."
        },
        {
          "id": "meh",
          "text": "Nice! I will check it out.",
          "smoothDelta": 3,
          "theirResponse": "Okay, let me know what you think.",
          "coachNote": "Friendly but it closes the door. Ask one small question next time."
        },
        {
          "id": "cringe",
          "text": "I only listen to the singles, albums are overrated.",
          "smoothDelta": -15,
          "theirResponse": "Oh. Okay.",
          "coachNote": "You dismissed the thing she loves. Save the hot take for someone who asked."
        }
      ]
    },
    {
      "theirMessage": "I will send you my favourite. Tell me if you get the build.",
      "replies": [
        {
          "id": "good",
          "text": "Yes please. I will listen for what changes in the second half.",
          "smoothDelta": 15,
          "theirResponse": "Perfect, that is exactly what to listen for.",
          "coachNote": "You picked a listening task. That is real engagement."
        },
        {
          "id": "meh",
          "text": "Sure, thanks.",
          "smoothDelta": 2,
          "theirResponse": "Cool!",
          "coachNote": "Polite, but the moment invited more."
        },
        {
          "id": "cringe",
          "text": "I will pretend I love it, no problem.",
          "smoothDelta": -20,
          "theirResponse": "Wait, what?",
          "coachNote": "Never fake it. Curiosity beats performance."
        }
      ]
    }
  ],
  "closingNote": "You asked, you listened, you did not bluff. That is the whole game."
}
```

**Sample 2** (lesson `talk-02`) - Track id `tt-her-playlist`.

```json
{
  "title": "Her playlist",
  "setting": "She sends you a playlist for a road trip",
  "exchanges": [
    {
      "theirMessage": "I made you a playlist. The order matters, listen in order!",
      "replies": [
        {
          "id": "order",
          "text": "Listening in order tonight. Is there a reason the order matters?",
          "smoothDelta": 18,
          "theirResponse": "Yes! It builds from calm to sing-along. I spent ages on it.",
          "coachNote": "You honoured the effort and asked about the design."
        },
        {
          "id": "meh",
          "text": "Thanks, I will shuffle it in the car.",
          "smoothDelta": -3,
          "theirResponse": "Oh, okay.",
          "coachNote": "Shuffle undoes her sequencing. Ask first."
        },
        {
          "id": "cringe",
          "text": "Twenty songs is a lot, can you cut it?",
          "smoothDelta": -15,
          "theirResponse": "Never mind.",
          "coachNote": "You treated a gift like homework."
        }
      ]
    },
    {
      "theirMessage": "Track 7 is my favourite song ever, do not skip it.",
      "replies": [
        {
          "id": "curious",
          "text": "Track 7 noted. What is it about that one?",
          "smoothDelta": 15,
          "theirResponse": "It is the one I play when I need to feel like myself.",
          "coachNote": "You asked about feeling, not facts. Perfect."
        },
        {
          "id": "meh",
          "text": "Good to know.",
          "smoothDelta": 2,
          "theirResponse": "Yep.",
          "coachNote": "Fine, but you can ask a follow-up."
        },
        {
          "id": "cringe",
          "text": "Oh that one is so overplayed.",
          "smoothDelta": -18,
          "theirResponse": "Well it matters to me.",
          "coachNote": "Taste snobbery lands as an insult here."
        }
      ]
    }
  ],
  "closingNote": "A playlist is a letter. You read it carefully."
}
```

**Sample 3** (lesson `talk-03`) - Track id `tt-got-tickets`.

```json
{
  "title": "I got tickets!",
  "setting": "She calls after the on-sale",
  "exchanges": [
    {
      "theirMessage": "I GOT TICKETS. I was in the queue for two hours, my hands are shaking.",
      "replies": [
        {
          "id": "celebrate",
          "text": "That is amazing, congratulations! Who is going with you?",
          "smoothDelta": 18,
          "theirResponse": "Probably my sister, but I might have a spare!",
          "coachNote": "You celebrated her effort and asked a warm question."
        },
        {
          "id": "meh",
          "text": "Cool. How much were they?",
          "smoothDelta": -5,
          "theirResponse": "Uh, a lot. Does it matter?",
          "coachNote": "Price first is a bit flat. Save it for later."
        },
        {
          "id": "cringe",
          "text": "Two hours for a concert? You are crazy.",
          "smoothDelta": -15,
          "theirResponse": "It is not just a concert to me.",
          "coachNote": "You mocked the effort. Do not."
        }
      ]
    },
    {
      "theirMessage": "I have never seen them live. What if it is not as good as the album?",
      "replies": [
        {
          "id": "reassure",
          "text": "Live is different, more raw. Want to listen to a live version before? I can help you plan.",
          "smoothDelta": 15,
          "theirResponse": "Yes, that would be fun.",
          "coachNote": "You gave honest reassurance and offered a plan without faking expertise."
        },
        {
          "id": "meh",
          "text": "It will be fine.",
          "smoothDelta": 2,
          "theirResponse": "I hope so.",
          "coachNote": "True but generic."
        },
        {
          "id": "cringe",
          "text": "Live is always worse, they use backing tracks.",
          "smoothDelta": -18,
          "theirResponse": "Wow, thanks.",
          "coachNote": "A know-it-all trap. She needed encouragement."
        }
      ]
    }
  ],
  "closingNote": "You matched her energy and helped without taking over."
}
```

**Sample 4** (lesson `talk-04`) - Track id `tt-after-show`.

```json
{
  "title": "After the show",
  "setting": "She texts at midnight",
  "exchanges": [
    {
      "theirMessage": "They played the one I never thought they would play live. I cried.",
      "replies": [
        {
          "id": "ask",
          "text": "That sounds unreal. Which song was it?",
          "smoothDelta": 20,
          "theirResponse": "A deep cut from the second album. It is not even a single.",
          "coachNote": "You asked for the story. Perfect."
        },
        {
          "id": "meh",
          "text": "Nice, glad you had fun.",
          "smoothDelta": 2,
          "theirResponse": "Thanks!",
          "coachNote": "Warm, but no door open."
        },
        {
          "id": "cringe",
          "text": "Oh, I saw them play that on YouTube last week.",
          "smoothDelta": -12,
          "theirResponse": "Oh... okay.",
          "coachNote": "Do not steal her moment to prove you know something."
        }
      ]
    },
    {
      "theirMessage": "The setlist had 26 songs and the encore was three tracks I love.",
      "replies": [
        {
          "id": "curious",
          "text": "Twenty-six! Did they play the hits early or save them for the encore?",
          "smoothDelta": 15,
          "theirResponse": "They saved the biggest for the encore, of course.",
          "coachNote": "A question that shows you understand show flow."
        },
        {
          "id": "meh",
          "text": "That is a lot of songs.",
          "smoothDelta": 3,
          "theirResponse": "Yep.",
          "coachNote": "True, but shows no curiosity about what she enjoyed."
        },
        {
          "id": "cringe",
          "text": "You should have left before the encore to beat traffic.",
          "smoothDelta": -18,
          "theirResponse": "What?!",
          "coachNote": "Fans stay for the encore. Always."
        }
      ]
    }
  ],
  "closingNote": "You let her relive the night. That is the gift."
}
```

**Sample 5** (lesson `talk-05`) - Track id `tt-favorite-song`.

```json
{
  "title": "What is your favourite song?",
  "setting": "In the car",
  "exchanges": [
    {
      "theirMessage": "Okay, real question. What is your favourite song?",
      "replies": [
        {
          "id": "honest",
          "text": "Honestly? It is a simple one I grew up with, and I only know why I love it, not the music terms. What is yours?",
          "smoothDelta": 20,
          "theirResponse": "Ooh, that is sweet. Mine is a bit sad, want to hear?",
          "coachNote": "Honest and curious back. This is exactly what she wants."
        },
        {
          "id": "meh",
          "text": "Hmm, I do not really have one.",
          "smoothDelta": -4,
          "theirResponse": "Really? Nothing?",
          "coachNote": "Sometimes true, but give her something."
        },
        {
          "id": "cringe",
          "text": "Something obscure you have never heard of.",
          "smoothDelta": -15,
          "theirResponse": "Right...",
          "coachNote": "Hipster posturing keeps her out."
        }
      ]
    },
    {
      "theirMessage": "Why do you love it?",
      "replies": [
        {
          "id": "feel",
          "text": "It reminds me of a summer, and I like how it builds at the end.",
          "smoothDelta": 15,
          "theirResponse": "I love how the build got you.",
          "coachNote": "You described a feeling and used a term you now know."
        },
        {
          "id": "meh",
          "text": "It is just good.",
          "smoothDelta": 0,
          "theirResponse": "Okay.",
          "coachNote": "Give one small detail."
        },
        {
          "id": "cringe",
          "text": "The harmonic structure is objectively superior.",
          "smoothDelta": -20,
          "theirResponse": "You are joking, right?",
          "coachNote": "Fake expertise sounds awful. Say what you feel."
        }
      ]
    }
  ],
  "closingNote": "Honesty about taste beats performance."
}
```

**Sample 6** (lesson `talk-06`) - Track id `tt-swap-recs`.

```json
{
  "title": "Swapping recommendations",
  "setting": "On the couch",
  "exchanges": [
    {
      "theirMessage": "Send me one song you think I would love. No pressure.",
      "replies": [
        {
          "id": "personal",
          "text": "I will send one I love, and tell you the part I like most.",
          "smoothDelta": 18,
          "theirResponse": "I will listen with headphones tonight.",
          "coachNote": "You made it personal and low-stakes."
        },
        {
          "id": "meh",
          "text": "I will think about it.",
          "smoothDelta": -2,
          "theirResponse": "Okay!",
          "coachNote": "Do not stall on something small."
        },
        {
          "id": "cringe",
          "text": "I will ask a friend what girls like.",
          "smoothDelta": -20,
          "theirResponse": "Uh, no. Just pick one.",
          "coachNote": "Do not outsource yourself."
        }
      ]
    },
    {
      "theirMessage": "I listened to yours. It was not really my style, but the drums were great.",
      "replies": [
        {
          "id": "open",
          "text": "Fair! What did you like about the drums?",
          "smoothDelta": 15,
          "theirResponse": "The groove, it felt tight.",
          "coachNote": "Great: took feedback well and got curious."
        },
        {
          "id": "meh",
          "text": "Ah okay.",
          "smoothDelta": -2,
          "theirResponse": "Yeah.",
          "coachNote": "Lean in a little."
        },
        {
          "id": "cringe",
          "text": "You have bad taste then.",
          "smoothDelta": -20,
          "theirResponse": "Wow.",
          "coachNote": "Never punish honesty."
        }
      ]
    }
  ],
  "closingNote": "You gave and received gracefully."
}
```

**Sample 7** (lesson `live-03`) - Track id `tt-ticket-fees`.

```json
{
  "title": "The ticket fees",
  "setting": "She texts during a queue",
  "exchanges": [
    {
      "theirMessage": "The fees are almost as much as the ticket. Why is this legal?!",
      "replies": [
        {
          "id": "sympathy",
          "text": "Ugh, that is so frustrating. Want me to help compare the final prices?",
          "smoothDelta": 18,
          "theirResponse": "Yes please, I do not trust the first number.",
          "coachNote": "Sympathy first, help second."
        },
        {
          "id": "meh",
          "text": "That is how it works.",
          "smoothDelta": -4,
          "theirResponse": "Not helpful, thanks.",
          "coachNote": "Accurate but cold."
        },
        {
          "id": "cringe",
          "text": "Just buy from a scalper, it is easier.",
          "smoothDelta": -18,
          "theirResponse": "That is how people get scammed.",
          "coachNote": "Bad advice; resale scams are common."
        }
      ]
    },
    {
      "theirMessage": "Someone said the company got in trouble in court this year?",
      "replies": [
        {
          "id": "honest",
          "text": "I read a bit: a jury found against the ticketing company in April. I do not know the details though, want to look together?",
          "smoothDelta": 15,
          "theirResponse": "Yes, I want to understand it.",
          "coachNote": "You shared what you know and said what you do not."
        },
        {
          "id": "meh",
          "text": "Yes something like that.",
          "smoothDelta": 0,
          "theirResponse": "What do you mean?",
          "coachNote": "Vague. Say what you actually know."
        },
        {
          "id": "cringe",
          "text": "It is all rigged, no point in going.",
          "smoothDelta": -12,
          "theirResponse": "I still want to go.",
          "coachNote": "Cynicism drains her excitement."
        }
      ]
    }
  ],
  "closingNote": "You stayed on her side. Facts optional, empathy required."
}
```

**Sample 8** (lesson `fan-05`) - Track id `tt-gatekeeper`.

```json
{
  "title": "The gatekeeper",
  "setting": "She tells a story about a fan meetup",
  "exchanges": [
    {
      "theirMessage": "A guy at the meetup told me I was not a real fan because I did not know the early albums.",
      "replies": [
        {
          "id": "support",
          "text": "That sounds awful. You are absolutely a real fan. What is your favourite era?",
          "smoothDelta": 20,
          "theirResponse": "The middle one. It saved me in a hard year.",
          "coachNote": "You supported her and returned to what she loves."
        },
        {
          "id": "meh",
          "text": "Some people are like that.",
          "smoothDelta": 3,
          "theirResponse": "Yeah.",
          "coachNote": "True, but she wanted warmth."
        },
        {
          "id": "cringe",
          "text": "Well, you should learn the early albums then.",
          "smoothDelta": -15,
          "theirResponse": "Wow. Not you too.",
          "coachNote": "That is the gatekeeper move."
        }
      ]
    },
    {
      "theirMessage": "Do you think there is one right way to be a fan?",
      "replies": [
        {
          "id": "open",
          "text": "No. Everyone starts somewhere. I am learning too, and you are teaching me.",
          "smoothDelta": 18,
          "theirResponse": "That means a lot.",
          "coachNote": "Honest, humble, warm."
        },
        {
          "id": "meh",
          "text": "Probably not.",
          "smoothDelta": 2,
          "theirResponse": "Maybe.",
          "coachNote": "A bit short for a big moment."
        },
        {
          "id": "cringe",
          "text": "Fans who do not know the deep cuts are just casuals.",
          "smoothDelta": -20,
          "theirResponse": "Please stop.",
          "coachNote": "You just joined the gatekeeper."
        }
      ]
    }
  ],
  "closingNote": "You made fandom feel safe. That is a real superpower."
}
```

**Sample 9** (lesson `debate-02`) - Track id `tt-autotune-debate`.

```json
{
  "title": "The Auto-Tune debate",
  "setting": "Dinner with friends",
  "exchanges": [
    {
      "theirMessage": "My cousin says Auto-Tune is cheating. I say it is an instrument. Who is right?",
      "replies": [
        {
          "id": "both",
          "text": "Sounds like both are true: it can fix notes or be a creative sound. What do you hear in your favourite song that uses it?",
          "smoothDelta": 18,
          "theirResponse": "The robotic sound in the chorus is the point.",
          "coachNote": "You explored both sides and asked what she hears."
        },
        {
          "id": "meh",
          "text": "I do not know, I just listen.",
          "smoothDelta": 3,
          "theirResponse": "Fair.",
          "coachNote": "Honest but no follow-up."
        },
        {
          "id": "cringe",
          "text": "It is definitely cheating, real singers do not need it.",
          "smoothDelta": -15,
          "theirResponse": "That is such a boring take.",
          "coachNote": "A hot take you cannot back up."
        }
      ]
    },
    {
      "theirMessage": "Do you think artists should tell people when they use it?",
      "replies": [
        {
          "id": "curious",
          "text": "Good question, I think of it as an effect people choose. Where do you draw the line?",
          "smoothDelta": 15,
          "theirResponse": "When it hides the voice instead of shaping it.",
          "coachNote": "You asked for her line instead of claiming one."
        },
        {
          "id": "meh",
          "text": "Maybe.",
          "smoothDelta": 1,
          "theirResponse": "Okay.",
          "coachNote": "Give it more."
        },
        {
          "id": "cringe",
          "text": "Nobody cares about that stuff.",
          "smoothDelta": -12,
          "theirResponse": "I do.",
          "coachNote": "You dismissed what she cares about."
        }
      ]
    }
  ],
  "closingNote": "You kept the debate friendly and learned something."
}
```

### 2.8 `timing-tap`

1D rhythm only: backbeat, dembow, beatmatching, split-second pulse. One sweep equals one bar so the gold zone marks a beat position. Anything scene-based would be Unity; nothing here needs it.

**Sample 1** (lesson `rhythm-03`) - Tempo 120 BPM; a full sweep of 2.0 s equals one 4/4 bar, so the gold zone at 25% and 75% marks beats 2 and 4.

```json
{
  "prompt": "Tap on the backbeat: beat two of the bar.",
  "theme": {
    "label": "Backbeat",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 22,
      "zoneEndPct": 32,
      "sweepSeconds": 2
    },
    {
      "zoneStartPct": 72,
      "zoneEndPct": 82,
      "sweepSeconds": 2
    },
    {
      "zoneStartPct": 22,
      "zoneEndPct": 30,
      "sweepSeconds": 1.6
    }
  ],
  "explanation": {
    "correct": "The gold zone sits where the snare hits in most pop and rock. Landing there is the clap you feel in a crowd.",
    "incorrect": "The backbeat is beats two and four of the bar, not the first beat. Aim a little after the first quarter of the sweep.",
    "sayThisLine": "Do you clap on two and four without thinking?"
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `edm-01`) - Beatmatch feel: a sweep represents one beat; tap when the two markers align.

```json
{
  "prompt": "Line up the beat like a DJ blending two tracks.",
  "theme": {
    "label": "Beatmatch",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 45,
      "zoneEndPct": 55,
      "sweepSeconds": 1.8
    },
    {
      "zoneStartPct": 46,
      "zoneEndPct": 54,
      "sweepSeconds": 1.4
    },
    {
      "zoneStartPct": 47,
      "zoneEndPct": 53,
      "sweepSeconds": 1.1
    }
  ],
  "explanation": {
    "correct": "DJs listen to two tracks and nudge tempo until the beats align. Here the gold zone is the moment the beats line up.",
    "incorrect": "Beatmatching means the two beats land together. The gold zone marks the alignment point in the middle of the sweep.",
    "sayThisLine": "Can you hear when the two beats are drifting?"
  }
}
```

**Sample 3** (lesson `latin-01`) - Dembow: steady kick with a syncopated snare accent (boom-ch-boom-chick). Zones mark the second accent; exact placement is set by the synthesised loop chosen by the sound designer.

```json
{
  "prompt": "Tap the second hit of the dembow pattern.",
  "theme": {
    "label": "Dembow",
    "resultUnit": "points"
  },
  "rounds": [
    {
      "zoneStartPct": 34,
      "zoneEndPct": 44,
      "sweepSeconds": 2
    },
    {
      "zoneStartPct": 34,
      "zoneEndPct": 44,
      "sweepSeconds": 1.7
    },
    {
      "zoneStartPct": 36,
      "zoneEndPct": 42,
      "sweepSeconds": 1.4
    }
  ],
  "explanation": {
    "correct": "The dembow is a repeating boom-ch-boom-chick that keeps reggaeton moving. Hitting the second accent teaches you the shape of the pulse.",
    "incorrect": "The dembow pairs a steady kick with a syncopated snare accent. Aim for the second accent of the pattern in the sweep.",
    "sayThisLine": "Is that the dembow under the beat?"
  }
}
```

### 2.9 `say-this`

Decode what she just said: hooks, eras, releases, ticket stress, fan slang. Every item has follow-ups that are honest curiosity and a `noFakeExpertNote` where useful.

**Sample 1** (lesson `song-02`)

```json
{
  "statement": {
    "speaker": "Maya",
    "text": "The bridge kills me every time and then that last chorus just lifts."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "A contrast section, then a bigger final chorus",
      "explanation": "Yes: a bridge changes the view, and the last chorus often adds a lift.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A physical bridge on the tour stage",
      "explanation": "Not that kind of bridge. In songs it is a section.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A key change in the album cover",
      "explanation": "Covers do not change key.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "The intro repeating at the end",
      "explanation": "That would be an outro or a reprise.",
      "isCorrect": false
    }
  ],
  "translation": "She is describing the contrast section that appears once, then the final chorus that feels bigger, often with more layers or a higher key.",
  "followUps": [
    {
      "line": "Does the last chorus change key or just get louder?",
      "why": "Shows you know the two common ways a final chorus lifts."
    },
    {
      "line": "What does the bridge do that the verses do not?",
      "why": "Invites her to explain what she hears."
    }
  ],
  "noFakeExpertNote": "It is fine to say \"I hear it but I do not know the word for it.\""
}
```

**Sample 2** (lesson `rel-02`)

```json
{
  "statement": {
    "speaker": "Jordan",
    "text": "She dropped the lead single, so the whole album cycle starts now."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "The first song announces the new album and a run of releases",
      "explanation": "Right: a lead single introduces a new album and kicks off the rollout.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The album is already out",
      "explanation": "Lead singles come before the album.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "The tour is finished",
      "explanation": "A cycle often includes a tour later.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "A remix of an older hit",
      "explanation": "A lead single is new material.",
      "isCorrect": false
    }
  ],
  "translation": "The first song from the new album is out, which usually means more singles, videos and news are coming over the next weeks or months.",
  "followUps": [
    {
      "line": "Do you think the album will sound like this single?",
      "why": "A good curious question; lead singles do not always represent the album."
    },
    {
      "line": "When is the album due?",
      "why": "Simple, factual and shows interest."
    }
  ]
}
```

**Sample 3** (lesson `debate-02`)

```json
{
  "statement": {
    "speaker": "Sam",
    "text": "People hate on the Auto-Tune but honestly it is an instrument at this point."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "Pitch correction used as a sound, not just to fix notes",
      "explanation": "Yes. Many artists use hard-tuned vocals as a deliberate effect.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A type of guitar tuner",
      "explanation": "Not a guitar tuner; it is vocal software.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A complaint that live shows are lip-synced",
      "explanation": "That is a separate debate.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "A method for tuning drum kits",
      "explanation": "Drums are tuned by hand.",
      "isCorrect": false
    }
  ],
  "translation": "He is defending pitch-correction software as a creative sound, like a guitar pedal, instead of a cheat that hides bad singing.",
  "followUps": [
    {
      "line": "Where do you draw the line between an effect and a fix?",
      "why": "A genuine question that invites him to explain."
    },
    {
      "line": "Which songs use it in a way you love?",
      "why": "Moves the topic toward what he enjoys."
    }
  ],
  "noFakeExpertNote": "You do not have to pick a side; ask what he hears."
}
```

**Sample 4** (lesson `live-05`)

```json
{
  "statement": {
    "speaker": "Priya",
    "text": "We have a clash at seven, so I need to pick between two sets."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "Two acts she wants are playing at the same time",
      "explanation": "Yes: a set clash is when the festival schedule overlaps two acts.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "The band members had an argument",
      "explanation": "Not that kind of clash.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "Two songs have the same rhythm",
      "explanation": "That is not what festival-goers mean.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "The sound system is clashing",
      "explanation": "Sound issues are not called clashes.",
      "isCorrect": false
    }
  ],
  "translation": "Two performers she wants to see are scheduled at the same time, so she has to choose one or split her time.",
  "followUps": [
    {
      "line": "Which one can you catch another time?",
      "why": "Helps her prioritise and shows you are listening."
    },
    {
      "line": "Do you want company or do you want to run between them?",
      "why": "Offers support without taking over."
    }
  ]
}
```

**Sample 5** (lesson `fan-03`)

```json
{
  "statement": {
    "speaker": "Alex",
    "text": "Everyone loves the singles, but the deep cut on side B is the real album."
  },
  "question": "What is she talking about?",
  "options": [
    {
      "id": "a",
      "text": "A non-single album track that fans prize, on the vinyl's second side",
      "explanation": "Yes: deep cut and side B are fan-speak for the songs beyond the hits.",
      "isCorrect": true
    },
    {
      "id": "b",
      "text": "A rare vinyl pressing",
      "explanation": "That is about the release, not the track.",
      "isCorrect": false
    },
    {
      "id": "c",
      "text": "A lyric printed on the sleeve",
      "explanation": "Not about lyrics.",
      "isCorrect": false
    },
    {
      "id": "d",
      "text": "A remix",
      "explanation": "Deep cuts are original tracks.",
      "isCorrect": false
    }
  ],
  "translation": "He thinks a lesser-known album track, from the second side of the vinyl, is better than the songs that became hits.",
  "followUps": [
    {
      "line": "What is it about that track that gets you?",
      "why": "Invites him to describe rather than test you."
    },
    {
      "line": "Which song should I start with if I only have time for one?",
      "why": "Asks for a recommendation, a classic bonding move."
    }
  ],
  "noFakeExpertNote": "Say \"I only know the singles\" if that is true. Fans love guiding you."
}
```

### 2.10 `fill-the-gap`

Vocabulary in context: backbeat, tension and resolution, release formats, mixing terms. A quick review card.

**Sample 1** (lesson `rhythm-03`)

```json
{
  "prompt": "Complete the sentence about the backbeat.",
  "template": "In most pop and rock, the {{snare}} hits on beats {{beats}}, which is called the backbeat.",
  "gaps": [
    {
      "id": "snare",
      "options": [
        "snare",
        "bass drum",
        "cymbal"
      ],
      "correct": "snare"
    },
    {
      "id": "beats",
      "options": [
        "one and three",
        "two and four",
        "every beat"
      ],
      "correct": "two and four"
    }
  ],
  "explanation": {
    "correct": "The snare on two and four is what makes a crowd clap. The kick often lands on one and three, so the two together make the pulse.",
    "incorrect": "The backbeat is the snare on beats two and four. The kick usually takes the other beats.",
    "sayThisLine": "Clap on two and four and watch the room join."
  }
}
```

**Sample 2** (lesson `harm-06`)

```json
{
  "prompt": "Complete the sentence about tension.",
  "template": "A chord that feels {{unsettled}} tends to move to one that feels {{home}}, which is called resolution.",
  "gaps": [
    {
      "id": "unsettled",
      "options": [
        "unsettled",
        "finished",
        "silent"
      ],
      "correct": "unsettled"
    },
    {
      "id": "home",
      "options": [
        "home",
        "louder",
        "stranger"
      ],
      "correct": "home"
    }
  ],
  "explanation": {
    "correct": "Music creates tension with a chord that wants to move, and release when it lands on home. That pull is why a pre-chorus feels like it is leaning forward.",
    "incorrect": "Tension is the unsettled feeling before a chord moves to a settled one. The settled one is called home or the tonic.",
    "sayThisLine": "That unresolved chord is driving me wild."
  }
}
```

**Sample 3** (lesson `rel-01`)

```json
{
  "prompt": "Complete the sentence about release types.",
  "template": "A {{single}} is one song, while an {{ep}} is a short set and an album is a full-length record.",
  "gaps": [
    {
      "id": "single",
      "options": [
        "single",
        "deluxe",
        "remix"
      ],
      "correct": "single"
    },
    {
      "id": "ep",
      "options": [
        "EP",
        "mixtape",
        "era"
      ],
      "correct": "EP"
    }
  ],
  "explanation": {
    "correct": "Single, EP, album: the three main sizes. A mixtape is usually a free or informal project, so it is a slightly different animal.",
    "incorrect": "A single is one song and an EP is a short set, generally under an album. A deluxe or remix is a different thing.",
    "sayThisLine": "Is that a full album or just an EP?"
  }
}
```

### 2.11 `listening-id`

The star of the course: original synthesised clips (`original-swoond`) that teach tempo, meter, backbeat, swing, major/minor, chord colour, bass line, stereo width, builds/drops and generic genre sketches. Every clip has a text `description` (schema-required) and a Skip path; a non-audio equivalent sits in the same unit.

**Sample 1** (lesson `rhythm-02`) - Original synthesised clip, 10 s, 90 BPM, in 3/4 throughout (paired 4/4 clip exists in the same set).

```json
{
  "prompt": "Listen. Which time signature is this?",
  "audio": {
    "asset": "audio/music/meter-waltz-01.m4a",
    "durationMs": 10000,
    "license": "original-swoond",
    "description": "Original synthesised piano and soft drum loop counted in groups of three beats at 90 BPM: a waltz feel, strong beat then two light beats.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "3-4",
      "text": "3/4, a waltz-like sway"
    },
    {
      "id": "4-4",
      "text": "4/4, the pop and rock default"
    },
    {
      "id": "6-8",
      "text": "6/8, a rolling twelve-eight feel"
    }
  ],
  "correctOptionId": "3-4",
  "explanation": {
    "correct": "Count 1-2-3, 1-2-3: the strong beat returns every three. That is the waltz sway of 3/4.",
    "incorrect": "Count along: strong-light-light repeating. That is groups of three (3/4). A 4/4 clip would give you strong-light-medium-light.",
    "sayThisLine": "Does that feel like it is in three?"
  },
  "listenFor": [
    "Strong first beat",
    "Two lighter beats",
    "A sway rather than a march"
  ]
}
```

**Sample 2** (lesson `harm-02`) - Original synthesised clip, 8 s: slow minor-key progression on pad and piano (paired major clip exists in the same set).

```json
{
  "prompt": "Which mood does this chord progression have?",
  "audio": {
    "asset": "audio/music/mood-minor-01.m4a",
    "durationMs": 8000,
    "license": "original-swoond",
    "description": "Original synthesised pad and soft piano playing a slow chord progression in a minor key, moody and reflective.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "minor",
      "text": "Minor: shadowed, wistful"
    },
    {
      "id": "major",
      "text": "Major: bright, open"
    }
  ],
  "correctOptionId": "minor",
  "explanation": {
    "correct": "The lowered third gives the chords a darker colour. Your ear will learn this contrast quickly.",
    "incorrect": "Notice the darker, more wistful colour of the chords. That is minor. Major would feel brighter and more open.",
    "sayThisLine": "That one sounds minor to me, does it to you?"
  },
  "listenFor": [
    "A darker colour",
    "A slower, reflective pace"
  ]
}
```

**Sample 3** (lesson `genre-06`) - Original synthesised genre sketch: house at 124 BPM, kick on every beat, offbeat hi-hat, synth stab.

```json
{
  "prompt": "Listen. Which genre sketch is this?",
  "audio": {
    "asset": "audio/music/genre-sketch-house-01.m4a",
    "durationMs": 12000,
    "license": "original-swoond",
    "description": "Original synthesised house sketch at 124 BPM: kick on every beat, hi-hat on the off-beats, a repeating synthesiser chord stab and a simple bass line.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "house",
      "text": "House or dance"
    },
    {
      "id": "country",
      "text": "Country ballad"
    },
    {
      "id": "metal",
      "text": "Heavy metal"
    },
    {
      "id": "jazz",
      "text": "Jazz trio"
    }
  ],
  "correctOptionId": "house",
  "explanation": {
    "correct": "Four on the floor at around 124 BPM with off-beat hats is classic house. Genre by ear means listening for these habits.",
    "incorrect": "The kick on every beat at a steady 124 BPM with off-beat hi-hats points to house. Country, metal and jazz have very different drum and instrument habits.",
    "sayThisLine": "Is that a house beat? The kick is on every beat."
  },
  "listenFor": [
    "Kick on every beat",
    "Hats on the off-beats",
    "A repeating synth stab"
  ]
}
```

**Sample 4** (lesson `rhythm-04`) - Original synthesised clip, 8 s: same drum pattern, first half straight, second half swung.

```json
{
  "prompt": "Is the second half of this loop straight or swung?",
  "audio": {
    "asset": "audio/music/swing-vs-straight-01.m4a",
    "durationMs": 8000,
    "license": "original-swoond",
    "description": "Original synthesised drum loop, first four seconds with evenly spaced hi-hats, next four seconds with a long-short lilt to the hi-hats.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "swung",
      "text": "Swung: long-short lilt"
    },
    {
      "id": "straight",
      "text": "Straight: even spacing"
    }
  ],
  "correctOptionId": "swung",
  "explanation": {
    "correct": "The second half gives the hi-hats a long-short pattern, like a skipping step. That lilt is swing.",
    "incorrect": "In the second half the hi-hats are uneven, long then short. That is swing; the first half is straight.",
    "sayThisLine": "Do you hear that shuffle in the hi-hats?"
  },
  "listenFor": [
    "Skipping, lilting hi-hats",
    "Even, march-like hi-hats in the first half"
  ]
}
```

**Sample 5** (lesson `ear-02`) - Original synthesised clip: only a bass line, then drums join.

```json
{
  "prompt": "What is the lowest instrument doing here?",
  "audio": {
    "asset": "audio/music/bass-line-focus-01.m4a",
    "durationMs": 10000,
    "license": "original-swoond",
    "description": "Original synthesised bass line that walks up and down a simple pattern, with a light drum kit joining after four seconds.",
    "maxPlays": 3
  },
  "options": [
    {
      "id": "walk",
      "text": "Walking a melody that links the chords and the beat"
    },
    {
      "id": "hold",
      "text": "Holding one long note the whole time"
    },
    {
      "id": "silent",
      "text": "Nothing, the bass is silent"
    }
  ],
  "correctOptionId": "walk",
  "explanation": {
    "correct": "A good bass line moves and connects the rhythm to the chords. It is the reason a groove feels alive.",
    "incorrect": "The low instrument is moving between notes, tying the beat to the harmony. It is not holding one note.",
    "sayThisLine": "Did you notice the bass moving under it?"
  },
  "listenFor": [
    "Notes moving under the beat",
    "Where the drums join"
  ]
}
```

### 2.12 `estimate-slider`

Magnitudes: BPM, decibels, stream-to-album-unit ratios (dated), venue capacities, festival set lengths.

**Sample 1** (lesson `rhythm-01`)

```json
{
  "prompt": "Roughly how fast is a typical pop song?",
  "unit": "BPM",
  "min": 40,
  "max": 200,
  "step": 5,
  "correctValue": 120,
  "tolerance": {
    "full": 10,
    "partial": 25
  },
  "explanation": {
    "correct": "Many pop and dance songs fall between about 100 and 130 BPM, close to a brisk walk. Slow ballads sit in the 60s and 70s; drum and bass runs near 170.",
    "incorrect": "A typical pop tempo is around 120 BPM, about a brisk walking pace. Ballads are far slower and drum and bass far faster.",
    "sayThisLine": "What BPM would you guess for this one?"
  }
}
```

**Sample 2** (lesson `live-06`)

```json
{
  "prompt": "How loud can a rock concert get near the speakers?",
  "unit": "dB",
  "min": 60,
  "max": 130,
  "step": 5,
  "correctValue": 105,
  "tolerance": {
    "full": 5,
    "partial": 15
  },
  "explanation": {
    "correct": "Concerts often reach 100 to 110 decibels near the speakers. Long exposure at levels like that can harm hearing, which is why earplugs are recommended.",
    "incorrect": "Concert volume commonly reaches 100 to 110 dB, far above conversation at about 60 dB. That is loud enough to risk hearing damage over a night.",
    "sayThisLine": "Should I grab earplugs for both of us?"
  }
}
```

**Sample 3** (lesson `rel-05`)

```json
{
  "prompt": "How many paid streams equal one album unit (early 2026)?",
  "unit": "streams",
  "min": 500,
  "max": 2000,
  "step": 50,
  "correctValue": 1000,
  "tolerance": {
    "full": 0,
    "partial": 250
  },
  "explanation": {
    "correct": "Since early 2026, Billboard's formula counts 1,000 paid on-demand streams from an album as one album unit, and 2,500 ad-supported ones. Formulas change, which is why the number is dated.",
    "incorrect": "As of early 2026 the album-unit formula counts about 1,000 paid on-demand streams as one unit. Chart rules change from time to time, so check the current one.",
    "sayThisLine": "Do you know how the chart counts streams these days?"
  }
}
```

### 2.13 `hotspot-tap`

Static diagrams: song map bar, venue floor plan, mixer strip, keyboard octave. Where, not when.

**Sample 1** (lesson `song-01`)

```json
{
  "prompt": "Tap the chorus on this song map.",
  "diagram": {
    "diagramId": "song-map-bar",
    "aspectRatio": 3,
    "alt": "A horizontal bar showing a pop song timeline: intro, verse one, pre-chorus, chorus, verse two, chorus, bridge, final chorus, outro. Each section is a labelled block."
  },
  "hotspots": [
    {
      "id": "intro",
      "label": "Intro block",
      "shape": {
        "kind": "rect",
        "x": 0,
        "y": 0.2,
        "w": 0.08,
        "h": 0.6
      }
    },
    {
      "id": "verse-1",
      "label": "Verse one block",
      "shape": {
        "kind": "rect",
        "x": 0.08,
        "y": 0.2,
        "w": 0.16,
        "h": 0.6
      }
    },
    {
      "id": "chorus-1",
      "label": "First chorus block",
      "shape": {
        "kind": "rect",
        "x": 0.3,
        "y": 0.2,
        "w": 0.14,
        "h": 0.6
      }
    },
    {
      "id": "bridge",
      "label": "Bridge block",
      "shape": {
        "kind": "rect",
        "x": 0.72,
        "y": 0.2,
        "w": 0.1,
        "h": 0.6
      }
    }
  ],
  "correctHotspotIds": [
    "chorus-1"
  ],
  "explanation": {
    "correct": "The first chorus follows the pre-chorus and is the tune everyone remembers. The verse sits before it and the bridge comes later, once.",
    "incorrect": "The chorus is the repeated big section after the pre-chorus. The bridge sits later and appears once.",
    "sayThisLine": "Where does the chorus first hit?"
  }
}
```

**Sample 2** (lesson `live-04`)

```json
{
  "prompt": "Tap the spot for a great view without a crush.",
  "diagram": {
    "diagramId": "venue-floorplan-ga",
    "aspectRatio": 1.2,
    "alt": "A top-down floor plan of a standing general-admission venue: a stage at the top, a barricaded front pit, a middle floor, a soundboard tent in the centre and a bar along the back wall."
  },
  "hotspots": [
    {
      "id": "front-barricade",
      "label": "Front barricade",
      "shape": {
        "kind": "rect",
        "x": 0.2,
        "y": 0.18,
        "w": 0.6,
        "h": 0.1
      }
    },
    {
      "id": "mid-floor",
      "label": "Middle floor beside the soundboard",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.55,
        "r": 0.12
      }
    },
    {
      "id": "back-bar",
      "label": "Back near the bar",
      "shape": {
        "kind": "rect",
        "x": 0.1,
        "y": 0.85,
        "w": 0.8,
        "h": 0.1
      }
    }
  ],
  "correctHotspotIds": [
    "mid-floor"
  ],
  "explanation": {
    "correct": "Near the soundboard is where sound engineers mix for the best balance, and the crowd is thinner than at the barricade. Great for a clear view and sound.",
    "incorrect": "The mid floor near the soundboard usually has the best balance of sound and space. The barricade is packed and the back is far from the stage.",
    "sayThisLine": "Want the barricade or the soundboard sweet spot?"
  }
}
```

**Sample 3** (lesson `prod-03`)

```json
{
  "prompt": "Tap the control that places a sound left or right.",
  "diagram": {
    "diagramId": "mixer-channel-strip",
    "aspectRatio": 0.5,
    "alt": "A cartoon mixing-desk channel strip: at the top a gain knob, then EQ knobs, then a pan knob, and at the bottom a long fader."
  },
  "hotspots": [
    {
      "id": "gain",
      "label": "Gain knob",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.1,
        "r": 0.08
      }
    },
    {
      "id": "eq",
      "label": "EQ knobs",
      "shape": {
        "kind": "rect",
        "x": 0.25,
        "y": 0.25,
        "w": 0.5,
        "h": 0.2
      }
    },
    {
      "id": "pan",
      "label": "Pan knob",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.55,
        "r": 0.08
      }
    },
    {
      "id": "fader",
      "label": "Volume fader",
      "shape": {
        "kind": "rect",
        "x": 0.4,
        "y": 0.65,
        "w": 0.2,
        "h": 0.3
      }
    }
  ],
  "correctHotspotIds": [
    "pan"
  ],
  "explanation": {
    "correct": "Pan controls where a sound sits between left and right. Mixers use it to make room: guitars left, keys right, vocals centre.",
    "incorrect": "Pan moves a sound between left and right speakers. Gain sets input level, EQ shapes tone and the fader sets volume.",
    "sayThisLine": "Is that guitar panned hard to one side?"
  }
}
```

## 3. Playbook terms (88)

Definition plus an example line in the enthusiast's voice (invented; no lyrics). Ids are Playbook concept ids.

| Term | Concept id | Definition | In her voice |
|---|---|---|---|
| Verse | `verse` | The part of a song that tells the story or sets the scene; the words change each time, the tune stays. | "The verses are so quiet that the chorus feels like a door swinging open." |
| Chorus | `chorus` | The big repeated section, usually with the title and the tune you sing back. | "Everyone screams the chorus; the verses are where you catch your breath." |
| Pre-chorus | `pre-chorus` | A short section that climbs toward the chorus and makes it feel bigger. | "The pre-chorus is a staircase and the chorus is the rooftop." |
| Bridge | `bridge` | A contrast section, usually once, that changes the view before the last chorus. | "Then the bridge strips everything back and you forget how it ends." |
| Hook | `hook` | The catchiest small idea in a song: a phrase, riff or rhythm that grabs you. | "That synth hook is doing all the work." |
| Earworm | `earworm` | A tune that loops in your head without permission. | "It has been in my head since Tuesday, total earworm." |
| Build and release | `build-and-release` | Adding tension (layers, volume, pitch) and then letting it go at a big moment. | "The build in the last minute is unreal, then it just lets go." |
| Drop | `drop` | In dance-leaning music, the moment after a build when the beat and bass slam in. | "Wait for the drop, you will feel it in your ribs." |
| Breakdown | `breakdown` | A stripped-back section where most layers drop out before the energy returns. | "The breakdown is just a pulse and a voice, and then boom." |
| Tempo (BPM) | `tempo-bpm` | How fast the beat is, counted in beats per minute; walking pace is roughly 100 to 120. | "It is only 70 BPM but it feels heavy, not slow." |
| Bar (measure) | `bar-measure` | One repeating group of beats; songs are counted bar by bar. | "Count four bars and the whole band comes in." |
| Time signature | `time-signature` | How many beats sit in a bar (4/4 is most common; 3/4 sways like a waltz). | "It is in three, that is why it swings like that." |
| Backbeat | `backbeat` | A strong hit on beats two and four, usually the snare, that makes you clap. | "The backbeat is what makes the whole room clap on the wrong beats." |
| Four on the floor | `four-on-the-floor` | A kick drum on every beat; the steady heartbeat of house and disco. | "Four on the floor and suddenly nobody is sitting." |
| Syncopation | `syncopation` | Accents on unexpected parts of the beat, so the rhythm feels playful or pushed. | "The syncopated bass line is what makes it bounce." |
| Swing and shuffle | `swing-shuffle` | A long-short lilt to the beats instead of an even split. | "That shuffle is so lazy in the best way." |
| Groove and pocket | `groove-pocket` | When drums and bass lock so tightly the rhythm feels effortless. | "The drummer and bassist are just living in the pocket." |
| Half-time feel | `half-time` | Keeping the tempo but placing the backbeat so the song feels twice as slow. | "It switches to half-time and hits like a truck." |
| Fill | `fill` | A short drum flourish that marks a change of section. | "That fill into the chorus is perfect." |
| Pitch | `pitch` | How high or low a note is. | "Her voice jumps up a whole octave there." |
| Melody | `melody` | The tune: a line of notes you can hum. | "I love the melody, I could hum it all day." |
| Major scale | `major-scale` | The note set behind bright, open, happy-leaning sounds. | "It is major, so it sounds sunny even though the words are not." |
| Minor scale | `minor-scale` | The note set behind darker, moodier, more wistful sounds. | "Everything in minor just feels like 2 a.m. in the car." |
| Chord | `chord` | Three or more notes played together. | "It is only three chords and it still gets me." |
| Key and tonic | `key-tonic` | The home note and scale a song is built around; the tonic is where it feels settled. | "It ends on the home chord, that is why it feels finished." |
| Chord progression | `chord-progression` | The order of chords a section moves through. | "Same progression as a hundred songs, still works." |
| Four-chord song | `four-chord-song` | The famous progression (I-V-vi-IV) behind countless pop hits. | "Half the radio is the same four chords in different clothes." |
| Tension and resolution | `tension-resolution` | A chord or note that feels unsettled and then moves to one that feels at home. | "That unresolved chord before the chorus is driving me wild." |
| Key change | `key-change` | Shifting the whole song up (often a step or two) for a lift, typically near the end. | "The last chorus goes up a key and I lose it every time." |
| Harmony vocals | `harmony-vocals` | Extra voices singing different notes that fit with the melody. | "The stacked harmonies in the chorus are giving me goosebumps." |
| Rhythm section | `rhythm-section` | The drums and bass (often with rhythm guitar or keys) that carry the groove. | "The rhythm section is so tight you could set a watch by them." |
| Bass line | `bass-line` | The low melody played by bass guitar or synth; it links rhythm and harmony. | "Listen to the bass line, it is its own song." |
| Timbre | `timbre` | The colour or texture of a sound: why a violin and a flute differ on the same note. | "The timbre of her voice is so raspy and warm." |
| Dynamics | `dynamics` | How loud or soft the music gets, and how it changes. | "The dynamics are wild: whisper then wall of sound." |
| Falsetto | `falsetto` | A light, high voice above the normal chest range. | "He drops into falsetto and it is so tender." |
| Songwriter | `songwriter` | The person who writes the melody and words (not always the performer). | "She writes for other people too, not just herself." |
| Producer | `producer` | The person who shapes how a record sounds: choices, arrangement, direction. | "That producer's drums are unmistakable." |
| Audio engineer | `audio-engineer` | The technician who records, edits and balances the sound. | "The engineer got the room sound so real." |
| Stems | `stems` | Grouped audio tracks (drums, bass, vocals) bounced separately from a full mix. | "They released the stems so people can remix it." |
| Mixing | `mixing` | Balancing all the recorded parts into one stereo track. | "The mix is so clean, you can hear every instrument." |
| EQ (equalisation) | `eq` | Boosting or cutting parts of the frequency range to shape a sound. | "They rolled off the highs to make it feel warm and old." |
| Compression | `compression` | Reducing the gap between loud and soft so a sound feels steady and punchy. | "The vocal is so compressed it sits right in your ear." |
| Reverb and delay | `reverb-delay` | Reverb is the sense of a room or hall; delay is echoing repeats. | "There is so much reverb it sounds like a cathedral." |
| Mastering | `mastering` | The final polish that makes a mix consistent, loud enough and ready for release. | "The remaster sounds louder, but is it better?" |
| Pitch correction | `pitch-correction` | Software that nudges notes onto pitch; the hard, robotic setting is the famous effect. | "It is not cheating, it is a sound, like a guitar pedal." |
| Sample | `sample` | A piece of an existing recording reused in a new song. | "The whole beat is a sample of an old soul track." |
| Interpolation | `interpolation` | Re-recording an existing melody or line rather than using the original recording. | "They interpolated the chorus so they did not need the master." |
| Cover | `cover-version` | A new performance of a song someone else wrote or first recorded. | "Her cover made me love the original more." |
| Remix | `remix` | A new version of a song rebuilt by another producer. | "The club remix is completely different." |
| Genre | `genre` | A group of songs sharing sound, culture and habits; a useful label, not a wall. | "It is basically indie folk with a pop chorus." |
| Subgenre | `subgenre` | A narrower slice of a genre with its own signature sound. | "Not just rock, it is shoegaze." |
| Topline | `topline` | The melody and lyrics written over a track. | "She wrote the topline in twenty minutes." |
| Hook craft | `hook-craft` | The techniques (repetition, contour, surprise) used to make a hook stick. | "The hook repeats just enough and then twists at the end." |
| Arrangement | `arrangement` | What plays when: which instruments and layers come and go. | "The arrangement in the last verse is so clever." |
| Single, EP, album | `release-formats` | A single is one song, an EP a short set, an album a full-length record. | "It is an EP, so only five songs, but each one is great." |
| Album cycle | `album-cycle` | The planned run of singles, videos, tours and the album drop. | "We are in the album cycle now, so expect a new single every month." |
| Lead single | `lead-single` | The first song released to introduce a new album. | "The lead single set the whole tone." |
| Deluxe edition | `deluxe-edition` | An album re-release with extra songs or versions. | "The deluxe has three bonus tracks, worth it." |
| Record label | `record-label` | A company that funds, releases and markets music; majors are the big three. | "She left the major label to go independent." |
| Streaming royalties | `streaming-royalties` | The payments that flow from streams to rights holders after platform and label splits. | "A stream pays fractions of a cent, which is why touring matters." |
| Publishing versus master | `publishing-vs-master` | Publishing is the song (words and melody); the master is a specific recording of it. | "She re-recorded to own her masters." |
| Charts | `charts` | Weekly rankings of songs or albums using streams, sales and airplay. | "It debuted at number one, first week." |
| Streaming units | `streaming-units` | A formula that converts streams into equivalent album sales for charts. | "The formula changed, so streaming counts for more now." |
| First week | `first-week` | The opening sales and streaming total that decides a debut chart position. | "First week numbers are huge because of the vinyl variants." |
| Year-end recap (Wrapped) | `year-end-recap` | A yearly personalised summary of listening, shared as a social ritual. | "My Wrapped is embarrassing, it is just one artist." |
| Variants and pressings | `variants-pressings` | Different colours or editions of the same vinyl release; pressings are production runs. | "I missed the first pressing so I bought the signed variant." |
| Concert flow | `concert-flow` | The order of a show: doors, opener, changeover, headliner, encore. | "The opener starts at eight, do not be late." |
| Setlist | `setlist` | The list of songs played in a show, in order. | "Look at the setlist, they played three deep cuts." |
| Encore | `encore` | Extra songs after the main set, expected by tradition. | "They left the stage, so we all waited for the encore." |
| Presale and verified fan | `presale-verified-fan` | Early ticket access via a code, membership or a queue that screens for real fans. | "I got a verified fan code, I am praying." |
| Dynamic pricing | `dynamic-pricing` | Ticket prices that move with demand while on sale. | "The prices shot up while we were in the queue." |
| GA, pit and reserved | `ga-pit-reserved` | General admission is standing without assigned spots; the pit is the front standing area; reserved means a seat. | "We got GA, so we need to be there early." |
| Set clash | `set-clash` | Two artists you want to see playing at the same time at a festival. | "I have to pick between two sets, it is a clash." |
| Era | `era` | A distinct period of an artist's output, look and sound, often tied to an album. | "This is my favourite era, the sad one." |
| Easter egg | `easter-egg` | A hidden clue or nod in a video, cover or lyric that fans decode. | "There is an easter egg in the video, look at the calendar." |
| Deep cut | `deep-cut` | An album track that is not a single; fans prize them. | "Everyone knows the hits, but this deep cut is the best." |
| B-side | `b-side` | Originally the flip side of a single; now a bonus or non-album song. | "That b-side deserved to be a single." |
| Stan | `stan` | An intensely devoted fan (from a hit song about a fan); used affectionately or as a tease. | "I am a proud stan, do not talk to me." |
| Parasocial bond | `parasocial` | A one-sided closeness fans feel with a public figure. | "It feels like she knows me, even though she does not." |
| Gatekeeping | `gatekeeping` | Deciding who counts as a real fan, and shutting others out. | "Do not gatekeep, we all started somewhere." |
| Stereo image | `stereo-image` | How sounds are spread left to right (and near to far) in the mix. | "The stereo image is so wide it feels like headphones are the point." |
| Live versus studio | `live-vs-studio` | The difference between a record's polished sound and what happens on stage. | "Live it is way rawer, I like it more." |
| Riff | `riff` | A short repeating instrumental phrase, often on guitar. | "That riff is legendary." |
| Dembow | `dembow` | The rhythmic pattern (boom-ch-boom-chick) at the heart of reggaeton. | "The dembow starts and everybody moves." |
| Clave | `clave` | A repeating five-hit rhythmic pattern that organises much Afro-Latin music. | "Everything in salsa hangs on the clave." |
| Melisma | `melisma` | Singing several notes on one syllable; the vocal run. | "Her runs are unreal, that is melisma." |
| Beatmatching | `beatmatching` | A DJ aligning the tempo of two tracks so they blend. | "The DJ blended them so smoothly you did not notice." |
| Fan boundaries | `fan-boundaries` | Respecting artists' privacy and safety: no doxxing, no chasing, no crowding. | "We love them, but we do not go to their house." |

## 4. Talk Track scenarios (9)

Each scenario: her opening line, what it means, then good / meh / cringe replies with the Smooth delta and the coach note. The JSON payloads for each are in section 2.7.

### 4.1 Have you heard the new album? (`tt-new-album`, lesson `talk-01`)

*Setting:* Texting on release Friday

*What her opening means:* She has been waiting for this album and is excited; she wants you to be curious, not to quiz her.

**Exchange 1. She says:** "It is out!! I stayed up until midnight and the last track destroyed me."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Midnight listen, love that. What was it about the last track?" | Good | +20 | "The build in the second half. I did not expect it." | Curious and specific. You asked about her experience, not the facts. |
| "Nice! I will check it out." | Meh | +3 | "Okay, let me know what you think." | Friendly but it closes the door. Ask one small question next time. |
| "I only listen to the singles, albums are overrated." | Cringe | -15 | "Oh. Okay." | You dismissed the thing she loves. Save the hot take for someone who asked. |

**Exchange 2. She says:** "I will send you my favourite. Tell me if you get the build."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Yes please. I will listen for what changes in the second half." | Good | +15 | "Perfect, that is exactly what to listen for." | You picked a listening task. That is real engagement. |
| "Sure, thanks." | Meh | +2 | "Cool!" | Polite, but the moment invited more. |
| "I will pretend I love it, no problem." | Cringe | -20 | "Wait, what?" | Never fake it. Curiosity beats performance. |

*Closing note:* You asked, you listened, you did not bluff. That is the whole game.

### 4.2 Her playlist (`tt-her-playlist`, lesson `talk-02`)

*Setting:* She sends you a playlist for a road trip

*What her opening means:* She made a playlist for a mood; sharing it is an invitation to know her better, not to rate her taste.

**Exchange 1. She says:** "I made you a playlist. The order matters, listen in order!"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Listening in order tonight. Is there a reason the order matters?" | Good | +18 | "Yes! It builds from calm to sing-along. I spent ages on it." | You honoured the effort and asked about the design. |
| "Thanks, I will shuffle it in the car." | Meh | -3 | "Oh, okay." | Shuffle undoes her sequencing. Ask first. |
| "Twenty songs is a lot, can you cut it?" | Cringe | -15 | "Never mind." | You treated a gift like homework. |

**Exchange 2. She says:** "Track 7 is my favourite song ever, do not skip it."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Track 7 noted. What is it about that one?" | Good | +15 | "It is the one I play when I need to feel like myself." | You asked about feeling, not facts. Perfect. |
| "Good to know." | Meh | +2 | "Yep." | Fine, but you can ask a follow-up. |
| "Oh that one is so overplayed." | Cringe | -18 | "Well it matters to me." | Taste snobbery lands as an insult here. |

*Closing note:* A playlist is a letter. You read it carefully.

### 4.3 I got tickets! (`tt-got-tickets`, lesson `talk-03`)

*Setting:* She calls after the on-sale

*What her opening means:* She got tickets to a show she badly wanted; she is excited and possibly nervous about logistics.

**Exchange 1. She says:** "I GOT TICKETS. I was in the queue for two hours, my hands are shaking."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "That is amazing, congratulations! Who is going with you?" | Good | +18 | "Probably my sister, but I might have a spare!" | You celebrated her effort and asked a warm question. |
| "Cool. How much were they?" | Meh | -5 | "Uh, a lot. Does it matter?" | Price first is a bit flat. Save it for later. |
| "Two hours for a concert? You are crazy." | Cringe | -15 | "It is not just a concert to me." | You mocked the effort. Do not. |

**Exchange 2. She says:** "I have never seen them live. What if it is not as good as the album?"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Live is different, more raw. Want to listen to a live version before? I can help you plan." | Good | +15 | "Yes, that would be fun." | You gave honest reassurance and offered a plan without faking expertise. |
| "It will be fine." | Meh | +2 | "I hope so." | True but generic. |
| "Live is always worse, they use backing tracks." | Cringe | -18 | "Wow, thanks." | A know-it-all trap. She needed encouragement. |

*Closing note:* You matched her energy and helped without taking over.

### 4.4 After the show (`tt-after-show`, lesson `talk-04`)

*Setting:* She texts at midnight

*What her opening means:* She loved a moment in the setlist and wants to relive it; "they played the one" means a fan-favourite deep cut.

**Exchange 1. She says:** "They played the one I never thought they would play live. I cried."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "That sounds unreal. Which song was it?" | Good | +20 | "A deep cut from the second album. It is not even a single." | You asked for the story. Perfect. |
| "Nice, glad you had fun." | Meh | +2 | "Thanks!" | Warm, but no door open. |
| "Oh, I saw them play that on YouTube last week." | Cringe | -12 | "Oh... okay." | Do not steal her moment to prove you know something. |

**Exchange 2. She says:** "The setlist had 26 songs and the encore was three tracks I love."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Twenty-six! Did they play the hits early or save them for the encore?" | Good | +15 | "They saved the biggest for the encore, of course." | A question that shows you understand show flow. |
| "That is a lot of songs." | Meh | +3 | "Yep." | True, but shows no curiosity about what she enjoyed. |
| "You should have left before the encore to beat traffic." | Cringe | -18 | "What?!" | Fans stay for the encore. Always. |

*Closing note:* You let her relive the night. That is the gift.

### 4.5 What is your favourite song? (`tt-favorite-song`, lesson `talk-05`)

*Setting:* In the car

*What her opening means:* She asks what your favourite song is; she wants to see what you care about, not a test.

**Exchange 1. She says:** "Okay, real question. What is your favourite song?"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Honestly? It is a simple one I grew up with, and I only know why I love it, not the music terms. What is yours?" | Good | +20 | "Ooh, that is sweet. Mine is a bit sad, want to hear?" | Honest and curious back. This is exactly what she wants. |
| "Hmm, I do not really have one." | Meh | -4 | "Really? Nothing?" | Sometimes true, but give her something. |
| "Something obscure you have never heard of." | Cringe | -15 | "Right..." | Hipster posturing keeps her out. |

**Exchange 2. She says:** "Why do you love it?"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "It reminds me of a summer, and I like how it builds at the end." | Good | +15 | "I love how the build got you." | You described a feeling and used a term you now know. |
| "It is just good." | Meh | 0 | "Okay." | Give one small detail. |
| "The harmonic structure is objectively superior." | Cringe | -20 | "You are joking, right?" | Fake expertise sounds awful. Say what you feel. |

*Closing note:* Honesty about taste beats performance.

### 4.6 Swapping recommendations (`tt-swap-recs`, lesson `talk-06`)

*Setting:* On the couch

*What her opening means:* She wants you to swap songs; it is trust-building and playful, not a test.

**Exchange 1. She says:** "Send me one song you think I would love. No pressure."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "I will send one I love, and tell you the part I like most." | Good | +18 | "I will listen with headphones tonight." | You made it personal and low-stakes. |
| "I will think about it." | Meh | -2 | "Okay!" | Do not stall on something small. |
| "I will ask a friend what girls like." | Cringe | -20 | "Uh, no. Just pick one." | Do not outsource yourself. |

**Exchange 2. She says:** "I listened to yours. It was not really my style, but the drums were great."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Fair! What did you like about the drums?" | Good | +15 | "The groove, it felt tight." | Great: took feedback well and got curious. |
| "Ah okay." | Meh | -2 | "Yeah." | Lean in a little. |
| "You have bad taste then." | Cringe | -20 | "Wow." | Never punish honesty. |

*Closing note:* You gave and received gracefully.

### 4.7 The ticket fees (`tt-ticket-fees`, lesson `live-03`)

*Setting:* She texts during a queue

*What her opening means:* She is frustrated by ticket fees and price jumps; she wants sympathy, not a lecture.

**Exchange 1. She says:** "The fees are almost as much as the ticket. Why is this legal?!"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Ugh, that is so frustrating. Want me to help compare the final prices?" | Good | +18 | "Yes please, I do not trust the first number." | Sympathy first, help second. |
| "That is how it works." | Meh | -4 | "Not helpful, thanks." | Accurate but cold. |
| "Just buy from a scalper, it is easier." | Cringe | -18 | "That is how people get scammed." | Bad advice; resale scams are common. |

**Exchange 2. She says:** "Someone said the company got in trouble in court this year?"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "I read a bit: a jury found against the ticketing company in April. I do not know the details though, want to look together?" | Good | +15 | "Yes, I want to understand it." | You shared what you know and said what you do not. |
| "Yes something like that." | Meh | 0 | "What do you mean?" | Vague. Say what you actually know. |
| "It is all rigged, no point in going." | Cringe | -12 | "I still want to go." | Cynicism drains her excitement. |

*Closing note:* You stayed on her side. Facts optional, empathy required.

### 4.8 The gatekeeper (`tt-gatekeeper`, lesson `fan-05`)

*Setting:* She tells a story about a fan meetup

*What her opening means:* She mentions another fan who gatekeeps; she wants to feel that fandom is welcoming.

**Exchange 1. She says:** "A guy at the meetup told me I was not a real fan because I did not know the early albums."

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "That sounds awful. You are absolutely a real fan. What is your favourite era?" | Good | +20 | "The middle one. It saved me in a hard year." | You supported her and returned to what she loves. |
| "Some people are like that." | Meh | +3 | "Yeah." | True, but she wanted warmth. |
| "Well, you should learn the early albums then." | Cringe | -15 | "Wow. Not you too." | That is the gatekeeper move. |

**Exchange 2. She says:** "Do you think there is one right way to be a fan?"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "No. Everyone starts somewhere. I am learning too, and you are teaching me." | Good | +18 | "That means a lot." | Honest, humble, warm. |
| "Probably not." | Meh | +2 | "Maybe." | A bit short for a big moment. |
| "Fans who do not know the deep cuts are just casuals." | Cringe | -20 | "Please stop." | You just joined the gatekeeper. |

*Closing note:* You made fandom feel safe. That is a real superpower.

### 4.9 The Auto-Tune debate (`tt-autotune-debate`, lesson `debate-02`)

*Setting:* Dinner with friends

*What her opening means:* A friend defends Auto-Tune as a creative effect; you want to engage without picking a fight.

**Exchange 1. She says:** "My cousin says Auto-Tune is cheating. I say it is an instrument. Who is right?"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Sounds like both are true: it can fix notes or be a creative sound. What do you hear in your favourite song that uses it?" | Good | +18 | "The robotic sound in the chorus is the point." | You explored both sides and asked what she hears. |
| "I do not know, I just listen." | Meh | +3 | "Fair." | Honest but no follow-up. |
| "It is definitely cheating, real singers do not need it." | Cringe | -15 | "That is such a boring take." | A hot take you cannot back up. |

**Exchange 2. She says:** "Do you think artists should tell people when they use it?"

| Reply | Type | Smooth | She answers | Coach note |
|---|---|---|---|---|
| "Good question, I think of it as an effect people choose. Where do you draw the line?" | Good | +15 | "When it hides the voice instead of shaping it." | You asked for her line instead of claiming one. |
| "Maybe." | Meh | +1 | "Okay." | Give it more. |
| "Nobody cares about that stuff." | Cringe | -12 | "I do." | You dismissed what she cares about. |

*Closing note:* You kept the debate friendly and learned something.

## 5. Talk Track roster at launch (20)

Authored above (9): `tt-new-album`, `tt-her-playlist`, `tt-got-tickets`, `tt-after-show`, `tt-favorite-song`, `tt-swap-recs`, `tt-ticket-fees`, `tt-gatekeeper`, `tt-autotune-debate`. Planned (11), to be authored per unit: `tt-her-favorite-era` (fandom-culture), `tt-reunion-tour` (live-music), `tt-vinyl-day` (releases-industry), `tt-festival-plan` (live-music), `tt-cover-or-original` (how-records-are-made), `tt-wrapped-reveal` (releases-industry), `tt-opener-discovery` (live-music), `tt-mixed-feelings` (conversation-lab, she dislikes the new album), `tt-genre-brunch` (genre-map, a friendly genre argument), `tt-what-she-cried-to` (fandom-culture, a song tied to a hard time: theme-level only, warm, no advice), `tt-live-vs-record` (listening-like-a-fan). Branch tracks (4 per branch over time) are added after launch.

## 6. Asset needs (all `original-swoond`)

| Asset | Spec | Est. count |
|---|---|---|
| Listening clips | AAC .m4a, 44.1 kHz, 6 to 14 s, loudness-normalised (about -16 LUFS), 100 to 220 KB each; original MIDI compositions rendered with licensed or self-made instruments; A/B comparisons packed in one clip with a short neutral tone marker; **no reference to any existing recording**; text description written per clip | ~110 (rhythm 25, harmony 25, genre sketches 30, sound/timbre 15, production 10, ear-check 5) |
| Sample-clip files referenced above | `meter-waltz-01`, `mood-minor-01`, `genre-sketch-house-01`, `swing-vs-straight-01`, `bass-line-focus-01` (under `audio/music/`) | 5 |
| Diagrams | `song-map-bar`, `venue-floorplan-ga`, `mixer-channel-strip`, plus keyboard octave; procedural | ~10 |
| Illustrations | `rhythm-section-lineup`, `vinyl-variants-row`, `venue-sizes-sketch`, instrument set, vinyl variants | ~30 |

## 7. Voice and safety notes

- Cheeky coach, never mean; jokes target the learner's ignorance, never the crush, her taste, or any genre or fandom.
- Never grade taste; grade understanding. "Cringe" replies are about faking expertise, dismissing what she loves, or stealing the moment.
- Every `say-this` and talk track invites honest curiosity; `noFakeExpertNote` reminds the learner to say "I only know the singles" when true.
- Hearing, crowd and ticket-scam content stays conservative and mainstream (CDS section 13); `safetyNote` is filled on every hearing/crowd/festival `decision-scenario`.
- Dated facts (chart ratios, ticketing litigation, AI licensing, awards dates) appear in explanations only with an "as of" phrase and are release-checked (`NOTES_FOR_ORCHESTRATOR.md`).
- No lyrics, album art, artist photos or real recordings anywhere in this file.
