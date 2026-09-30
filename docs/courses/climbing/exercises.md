# Climbing: Native Exercise Plan (Tier B)

Native exercise plan for the `climbing` course. Payloads conform to `docs/contracts/native-exercises/v1/<type>.schema.json` (every sample below was validated with ajv). Type behavior, scoring and UI are in `docs/native-exercises/CATALOG.md`. The one Unity sim (`climbing.bouldering.problem-read.v1`) is specified in `sims/`.

## 1. Safety constraints (apply to every exercise)

Checklist for unit authors: `SAFETY_REVIEW_CHECKLIST.md`.

- **Swoon'd builds appreciation and conversation, not climbing skill.** It never teaches how to belay, lead, place gear, build anchors, rappel, spot or fall. Every technique-adjacent exercise says, or implies in its explanation, to learn it from a certified instructor or gym.
- Every `decision-scenario` carries a `safetyNote`. The best answer is the cautious one: say no, ask staff, hire a guide, rest an injury, obey a closure. "Just do it" is never best.
- No timers, streak bonuses or speed rewards on safety scenarios. Hearts follow the catalog rule; copy never shames.
- Movement words (heel hook, drop knee, dyno) are recognition and vocabulary only. No exercise gives body-position coaching for a real climb.
- Free solo and high-risk feats are admired, never presented as a goal.
- No medical advice beyond "rest and see a clinician if pain persists".
- Assets: procedural diagrams (`swoond-procedural`) and original illustrations (licence id `original-swoond`). No athlete photos, no brand logos, no scraped route topos.
- Voice: warm coach, never condescending, never about the crush; one joke per screen at most.

## 2. Types used and planned counts

| Native type | Planned use | Est. authored items at launch | Samples below |
|---|---|---|---|
| `multiple-choice` | see CDS section 12 | 117 | 5 |
| `binary-call` | see CDS section 12 | 62 | 3 |
| `term-match` | see CDS section 12 | 37 | 3 |
| `sequence-order` | see CDS section 12 | 12 | 3 |
| `visual-id` | see CDS section 12 | 14 | 3 |
| `decision-scenario` | see CDS section 12 | 51 | 10 |
| `talk-track` | see CDS section 12 | 11 | 8 |
| `say-this` | see CDS section 12 | 104 | 4 |
| `fill-the-gap` | see CDS section 12 | 39 | 3 |
| `estimate-slider` | see CDS section 12 | 7 | 3 |
| `hotspot-tap` | see CDS section 12 | 8 | 3 |
| `timing-tap` | Not used (no 1D timing concept) | 0 | n/a |
| `listening-id` | Not used (no audio at launch) | 0 | n/a |

## 3. Multiple choice (`multiple-choice`) samples

### `cl-mc-01` (wc-03 / bouldering)

```json
{
  "prompt": "What makes bouldering different from roped climbing?",
  "options": [
    {
      "id": "short",
      "text": "Short problems, no rope, pads below",
      "explanation": "Bouldering stays low so pads and spotters do the job a rope does elsewhere."
    },
    {
      "id": "tall",
      "text": "Very tall walls with a rope",
      "explanation": "That is roped climbing."
    },
    {
      "id": "speed",
      "text": "Only timed races"
    },
    {
      "id": "gear",
      "text": "Racks of removable gear",
      "explanation": "That is trad."
    }
  ],
  "correctOptionIds": [
    "short"
  ],
  "explanation": {
    "correct": "Bouldering trades height for difficulty: short, hard problems over crash pads. The risk is different, not absent.",
    "incorrect": "Think low and unroped. Bouldering is short hard problems over pads; height and ropes belong to other disciplines.",
    "sayThisLine": "I like bouldering. It's like a puzzle you do with your whole body."
  }
}
```

### `cl-mc-02` (gn-01 / v-scale)

```json
{
  "prompt": "Which is a bouldering grade?",
  "options": [
    {
      "id": "v4",
      "text": "V4",
      "explanation": "The V-scale is the U.S. bouldering scale, starting at V0."
    },
    {
      "id": "59",
      "text": "5.9",
      "explanation": "YDS grade for roped routes."
    },
    {
      "id": "7a",
      "text": "7a+",
      "explanation": "French sport route grade."
    },
    {
      "id": "e4",
      "text": "E4",
      "explanation": "British trad grade."
    }
  ],
  "correctOptionIds": [
    "v4"
  ],
  "explanation": {
    "correct": "V grades are bouldering. They began at Hueco Tanks, Texas, and climb upward with no official top.",
    "incorrect": "V means bouldering. The 5.x numbers are roped routes, and the letters-with-numbers like 7a+ are the French route scale.",
    "sayThisLine": "What's the V grade? I'm still learning what the numbers mean."
  }
}
```

### `cl-mc-03` (st-02 / onsight)

```json
{
  "prompt": "She onsighted a route. What happened?",
  "options": [
    {
      "id": "first",
      "text": "First try, no beta, no watching",
      "explanation": "Onsight means nothing is known in advance."
    },
    {
      "id": "many",
      "text": "After weeks of tries",
      "explanation": "That is a redpoint."
    },
    {
      "id": "watched",
      "text": "First try after watching someone",
      "explanation": "That is a flash."
    },
    {
      "id": "rest",
      "text": "She rested on the rope",
      "explanation": "That is hangdogging."
    }
  ],
  "correctOptionIds": [
    "first"
  ],
  "explanation": {
    "correct": "An onsight is a first-try send with no prior information. It is the purest style and a real brag.",
    "incorrect": "Onsight means first try and no info at all. Watching someone first makes it a flash; weeks of tries make it a redpoint.",
    "sayThisLine": "An onsight of a 5.11? That's a proper achievement."
  }
}
```

### `cl-mc-04` (oe-01 / access-fund)

```json
{
  "prompt": "What does the Access Fund do?",
  "options": [
    {
      "id": "keep",
      "text": "Helps keep climbing areas open and cared for",
      "explanation": "It advocates and supports stewardship."
    },
    {
      "id": "comps",
      "text": "Runs the Olympic events",
      "explanation": "That is the IFSC."
    },
    {
      "id": "gear",
      "text": "Sells climbing gear"
    },
    {
      "id": "grades",
      "text": "Sets grades for routes"
    }
  ],
  "correctOptionIds": [
    "keep"
  ],
  "explanation": {
    "correct": "Access Fund is a U.S. nonprofit that helps protect and keep climbing areas open through advocacy and stewardship.",
    "incorrect": "Access Fund works on access and stewardship. Comps belong to the IFSC, and grades are community opinions.",
    "sayThisLine": "I give a bit to Access Fund each year. Crags don't stay open on their own."
  }
}
```

### `cl-mc-05` (sc-02 / belayer)

```json
{
  "prompt": "Friend says, 'Just hold this rope.' Best reply?",
  "options": [
    {
      "id": "no",
      "text": "Say no and ask a gym staff member to teach or check you",
      "explanation": "Belaying is learned hands-on and tested."
    },
    {
      "id": "go",
      "text": "Hold it, how hard can it be",
      "explanation": "Belaying has real consequences if done wrong."
    },
    {
      "id": "video",
      "text": "Watch a video then do it"
    },
    {
      "id": "guess",
      "text": "Copy what others do"
    }
  ],
  "correctOptionIds": [
    "no"
  ],
  "explanation": {
    "correct": "Saying no is the right, respected answer. Belaying is taught by instructors and tested by the gym.",
    "incorrect": "A rope in untrained hands is a real risk. Good climbers respect a 'no, let's get me taught first'.",
    "sayThisLine": "I'm not belay-tested yet. Can we get a staff member to show me?"
  }
}
```

## 4. Binary call (`binary-call`) samples

### `cl-bc-01` (wc-04 / sport-climbing)

```json
{
  "prompt": "Bolts are already on the route. Which style?",
  "scene": {
    "kind": "none",
    "alt": "Text-only question about a climbing route with pre-placed bolts."
  },
  "choices": [
    {
      "id": "sport",
      "label": "Sport"
    },
    {
      "id": "trad",
      "label": "Trad"
    }
  ],
  "correctChoiceId": "sport",
  "explanation": {
    "correct": "Pre-placed bolts mean sport climbing. Trad climbers carry removable gear.",
    "incorrect": "Bolts drilled into the rock are sport-climbing protection. Trad means the climber brings gear to place and remove."
  }
}
```

### `cl-bc-02` (gn-04 / grade-subjectivity)

```json
{
  "prompt": "A grade is a...",
  "scene": {
    "kind": "none",
    "alt": "Text-only question about what a climbing grade is."
  },
  "choices": [
    {
      "id": "opinion",
      "label": "Shared opinion"
    },
    {
      "id": "measure",
      "label": "Exact measurement"
    }
  ],
  "correctChoiceId": "opinion",
  "explanation": {
    "correct": "Grades are community consensus and depend on reach, style and place.",
    "incorrect": "Nobody measures a grade with a ruler. It is an agreed opinion and it changes with height, style and area."
  }
}
```

### `cl-bc-03` (gc-02 / gym-etiquette)

```json
{
  "prompt": "Someone is on the wall above you. Walk under them?",
  "scene": {
    "kind": "none",
    "alt": "Text-only question about gym etiquette."
  },
  "choices": [
    {
      "id": "wait",
      "label": "Wait or go around"
    },
    {
      "id": "walk",
      "label": "Walk right under"
    }
  ],
  "correctChoiceId": "wait",
  "explanation": {
    "correct": "Keep the fall zone clear. A climber can come down with no warning.",
    "incorrect": "The space under a climber is a fall zone. Waiting takes five seconds and keeps everyone safe.",
    "sayThisLine": "I'll wait till they finish. Nice climb, by the way."
  }
}
```

## 5. Term match (`term-match`) samples

### `cl-tm-01` (rw-01 / hold-jug)

```json
{
  "prompt": "Match the hold to its description.",
  "pairs": [
    {
      "id": "jug",
      "term": "Jug",
      "definition": "Big, positive hold you can wrap your hand around"
    },
    {
      "id": "crimp",
      "term": "Crimp",
      "definition": "Small edge held with fingertips"
    },
    {
      "id": "sloper",
      "term": "Sloper",
      "definition": "Rounded hold with no edge, held by friction"
    },
    {
      "id": "pinch",
      "term": "Pinch",
      "definition": "Squeezed between thumb and fingers"
    }
  ],
  "explanation": {
    "summary": "Holds are named for how you grip them. Jugs are friendly, crimps and slopers are the ones people complain about.",
    "sayThisLine": "That sloper is all body tension."
  }
}
```

### `cl-tm-02` (st-01 / beta)

```json
{
  "prompt": "Match the climbing word.",
  "pairs": [
    {
      "id": "beta",
      "term": "Beta",
      "definition": "Info on how to climb a route"
    },
    {
      "id": "crux",
      "term": "Crux",
      "definition": "The hardest section"
    },
    {
      "id": "send",
      "term": "Send",
      "definition": "Climb it cleanly"
    },
    {
      "id": "project",
      "term": "Project",
      "definition": "A route you keep trying over time"
    }
  ],
  "explanation": {
    "summary": "These four words come up in almost every climbing chat. Ask what her crux is and you are in.",
    "sayThisLine": "What's the crux on your project?"
  }
}
```

### `cl-tm-03` (rp-02 / bolt)

```json
{
  "prompt": "Match the piece of roped vocabulary.",
  "pairs": [
    {
      "id": "bolt",
      "term": "Bolt",
      "definition": "Permanent anchor drilled into rock"
    },
    {
      "id": "draw",
      "term": "Quickdraw",
      "definition": "Two carabiners joined by a short sling"
    },
    {
      "id": "cam",
      "term": "Cam",
      "definition": "Spring-loaded removable gear for cracks"
    },
    {
      "id": "nut",
      "term": "Nut",
      "definition": "Metal wedge placed in a crack"
    }
  ],
  "explanation": {
    "summary": "You learn names here, not how to use them. Gear use is taught hands-on by a certified instructor."
  }
}
```

## 6. Sequence order (`sequence-order`) samples

### `cl-so-01` (rw-05 / wall-slab)

```json
{
  "prompt": "Order from least steep to most overhanging.",
  "items": [
    {
      "id": "slab",
      "text": "Slab",
      "why": "Leans back, so it is gentler"
    },
    {
      "id": "vert",
      "text": "Vertical",
      "why": "Straight up"
    },
    {
      "id": "over",
      "text": "Overhang",
      "why": "Leans out; arms work harder"
    },
    {
      "id": "roof",
      "text": "Roof",
      "why": "Near horizontal; you hang"
    }
  ],
  "explanation": {
    "correct": "From slab to roof, more of your weight hangs from your arms and less sits on your feet.",
    "incorrect": "Start with the lean-back wall and end upside-down: slab, vertical, overhang, roof.",
    "sayThisLine": "Slab is all feet. Roofs are all arms."
  }
}
```

### `cl-so-02` (st-03 / project)

```json
{
  "prompt": "Order a project's life.",
  "items": [
    {
      "id": "pick",
      "text": "Pick a route at your limit",
      "why": "A project is hard enough to need time"
    },
    {
      "id": "try",
      "text": "Try it in pieces",
      "why": "Learn the moves"
    },
    {
      "id": "link",
      "text": "Link sections",
      "why": "Put the pieces together"
    },
    {
      "id": "send",
      "text": "Send it",
      "why": "Clean, no falls"
    }
  ],
  "explanation": {
    "correct": "Projects go from pieces to links to a send. The weeks in between are the point.",
    "incorrect": "A project starts at your limit and runs through pieces and links before the send.",
    "sayThisLine": "I finally linked the first half."
  }
}
```

### `cl-so-03` (cc-05 / olympic-climbing)

```json
{
  "prompt": "Order the Olympic climbing formats.",
  "items": [
    {
      "id": "tokyo",
      "text": "Tokyo 2020: one combined medal",
      "why": "All three disciplines scored together"
    },
    {
      "id": "paris",
      "text": "Paris 2024: speed, plus boulder and lead combined",
      "why": "Two medals per gender"
    },
    {
      "id": "la",
      "text": "LA28: boulder, lead and speed",
      "why": "Three separate medals"
    }
  ],
  "explanation": {
    "correct": "The Olympics moved from one combined medal, to two, to three separate medals at LA28.",
    "incorrect": "Tokyo had one combined medal, Paris split speed off, and LA28 gives boulder, lead and speed their own.",
    "sayThisLine": "Three medals at LA28. Finally."
  }
}
```

## 7. Visual ID (`visual-id`) samples

### `cl-vi-01` (rw-01 / hold-jug)

```json
{
  "prompt": "Which hold is this?",
  "image": {
    "asset": "images/holds/jug.png",
    "alt": "Illustration of a large, deep hold with a wide open grip.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "jug",
      "text": "Jug"
    },
    {
      "id": "crimp",
      "text": "Crimp"
    },
    {
      "id": "sloper",
      "text": "Sloper"
    },
    {
      "id": "pocket",
      "text": "Pocket"
    }
  ],
  "correctOptionId": "jug",
  "explanation": {
    "correct": "A deep, open hold you can wrap your hand around is a jug.",
    "incorrect": "Big and deep means jug. Crimps are thin edges and slopers are rounded.",
    "sayThisLine": "Finally, a jug!"
  }
}
```

### `cl-vi-02` (rw-03 / arete)

```json
{
  "prompt": "Which feature is this?",
  "image": {
    "asset": "images/features/arete.png",
    "alt": "Illustration of an outside corner of a wall like the edge of a building.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "arete",
      "text": "Arete"
    },
    {
      "id": "dihedral",
      "text": "Dihedral"
    },
    {
      "id": "crack",
      "text": "Crack"
    },
    {
      "id": "roof",
      "text": "Roof"
    }
  ],
  "correctOptionId": "arete",
  "explanation": {
    "correct": "An outside corner is an arete. A dihedral is an inside corner.",
    "incorrect": "Outside corner means arete; inside corner means dihedral.",
    "sayThisLine": "That arete is a beauty."
  }
}
```

### `cl-vi-03` (mw-02 / heel-hook)

```json
{
  "prompt": "Which move is this?",
  "image": {
    "asset": "images/moves/heel-hook.png",
    "alt": "Illustration of a heel hooked on a hold at hip height.",
    "license": "original-swoond"
  },
  "options": [
    {
      "id": "heel",
      "text": "Heel hook"
    },
    {
      "id": "toe",
      "text": "Toe hook"
    },
    {
      "id": "smear",
      "text": "Smear"
    },
    {
      "id": "mantle",
      "text": "Mantle"
    }
  ],
  "correctOptionId": "heel",
  "explanation": {
    "correct": "A heel on a hold lets your leg do work your arms would do.",
    "incorrect": "The heel is what hooks here. A toe hook uses the top of the foot.",
    "sayThisLine": "Heel hook saved my arms."
  }
}
```

## 8. Decision scenarios (safety-first) (`decision-scenario`) samples

### `cl-ds-01` (sc-02 / belayer)

```json
{
  "prompt": "She offers you the rope. What now?",
  "situation": {
    "narrative": "At the gym, she is ready to climb and hands you her belay device.",
    "facts": [
      {
        "label": "Your experience",
        "value": "Never belayed"
      },
      {
        "label": "Gym policy",
        "value": "Belay test required",
        "emphasis": "warning"
      },
      {
        "label": "Her ask",
        "value": "Just watch the rope"
      }
    ]
  },
  "options": [
    {
      "id": "decline",
      "label": "Say you're not tested and ask staff to teach you",
      "verdict": "best",
      "consequence": "She smiles. A staff member shows you the class schedule. Nobody is hurt and she respects you more.",
      "considerations": [
        "Belaying is a taught, tested skill",
        "Saying no is a strength"
      ]
    },
    {
      "id": "toprope",
      "label": "Hold it, she is only on top rope",
      "verdict": "poor",
      "consequence": "You might be okay and you might not. A mistake could drop her.",
      "considerations": [
        "Top rope is still serious",
        "Gym rules exist for a reason"
      ]
    },
    {
      "id": "watch",
      "label": "Watch a video while she waits",
      "verdict": "poor",
      "consequence": "Video is not hands-on and a certified check is still required.",
      "considerations": [
        "Videos can't see your hands",
        "Gyms require a test"
      ]
    },
    {
      "id": "later",
      "label": "Offer to climb boulders together and sign up for a class",
      "verdict": "acceptable",
      "consequence": "You stay safe and share the fun while you learn properly.",
      "considerations": [
        "Bouldering needs its own learning",
        "A class is the real answer"
      ]
    }
  ],
  "expertNote": "Experienced climbers respect anyone who says I'm not trained yet. Ask for the class, then belay her when you are tested.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym.",
  "sayThisLine": "I'm not belay tested yet. Let's sign me up for the class and boulder tonight."
}
```

### `cl-ds-02` (sc-03 / instructor-led)

```json
{
  "prompt": "A friend offers to teach you on his rope.",
  "situation": {
    "narrative": "A friend who climbs outside says he will show you the basics at the local crag this weekend.",
    "facts": [
      {
        "label": "His experience",
        "value": "Years outdoors"
      },
      {
        "label": "Your experience",
        "value": "None"
      },
      {
        "label": "Setting",
        "value": "Outdoor crag",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "instructor",
      "label": "Suggest a certified instructor or guide first",
      "verdict": "best",
      "consequence": "He agrees it is smart. You learn with structure, and he's glad to join.",
      "considerations": [
        "Instructors teach systems",
        "Friends may skip steps"
      ]
    },
    {
      "id": "friend",
      "label": "Go with him to learn everything there",
      "verdict": "poor",
      "consequence": "He may be good, but nobody is checking you.",
      "considerations": [
        "Outdoor adds risks",
        "No formal checks"
      ]
    },
    {
      "id": "gym",
      "label": "Take a gym intro first, then decide",
      "verdict": "acceptable",
      "consequence": "A gym class is a good step; outdoors comes later with a guide.",
      "considerations": [
        "Gyms offer supervised learning",
        "Outdoor needs more"
      ]
    }
  ],
  "expertNote": "Experienced climbers know that learning from a friend is how bad habits travel. Good friends push you toward instruction.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym.",
  "sayThisLine": "I'd love to climb with you. Can I take a class first so I'm not a liability?"
}
```

### `cl-ds-03` (gc-02 / fall-zone)

```json
{
  "prompt": "A kid wanders under a climber on a problem.",
  "situation": {
    "narrative": "In the boulder area a child walks toward the landing zone while someone is on the wall.",
    "facts": [
      {
        "label": "Climber",
        "value": "Near the top",
        "emphasis": "warning"
      },
      {
        "label": "Child",
        "value": "Walking under",
        "emphasis": "warning"
      },
      {
        "label": "Staff",
        "value": "Across the room"
      }
    ]
  },
  "options": [
    {
      "id": "call",
      "label": "Say stop, step back calmly and get a staff member",
      "verdict": "best",
      "consequence": "The child is led away and the climber finishes safely.",
      "considerations": [
        "Keep the fall zone clear",
        "Staff can step in"
      ]
    },
    {
      "id": "ignore",
      "label": "Assume someone else will notice",
      "verdict": "poor",
      "consequence": "The climber could land on them.",
      "considerations": [
        "Falls are sudden",
        "Speak up"
      ]
    },
    {
      "id": "grab",
      "label": "Run in and grab the child",
      "verdict": "acceptable",
      "consequence": "It stops the child but may startle everyone; calling out first is better.",
      "considerations": [
        "Calm is safer",
        "Calling gets staff"
      ]
    }
  ],
  "expertNote": "Culture means everyone is responsible for the fall zone, not just staff.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym."
}
```

### `cl-ds-04` (sc-05 / leader-fall)

```json
{
  "prompt": "She says leading scares her. You respond?",
  "situation": {
    "narrative": "She is about to lead a route for the first time with an instructor.",
    "facts": [
      {
        "label": "Her feeling",
        "value": "Nervous"
      },
      {
        "label": "Setting",
        "value": "Gym, instructor present"
      }
    ]
  },
  "options": [
    {
      "id": "listen",
      "label": "Say it's normal and ask what she's working on",
      "verdict": "best",
      "consequence": "She relaxes and tells you about her plan with the instructor.",
      "considerations": [
        "Fear is normal",
        "Ask don't advise"
      ]
    },
    {
      "id": "dare",
      "label": "Tell her it's no big deal",
      "verdict": "poor",
      "consequence": "She feels dismissed and more anxious.",
      "considerations": [
        "Minimizing isn't support",
        "Respect the risk"
      ]
    },
    {
      "id": "coach",
      "label": "Tell her exactly how to fall",
      "verdict": "poor",
      "consequence": "You aren't qualified to coach this.",
      "considerations": [
        "Leave technique to instructors",
        "Don't fake expertise"
      ]
    }
  ],
  "expertNote": "The best partners acknowledge fear and leave technique to the instructor.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym.",
  "sayThisLine": "Nervous is normal. What's the instructor working on with you?"
}
```

### `cl-ds-05` (oe-04 / crag-etiquette)

```json
{
  "prompt": "Two parties want the same route.",
  "situation": {
    "narrative": "At a busy crag you arrive and another group is already at the base of the route you came for.",
    "facts": [
      {
        "label": "Crowd",
        "value": "Busy"
      },
      {
        "label": "Their status",
        "value": "Waiting at the base"
      }
    ]
  },
  "options": [
    {
      "id": "ask",
      "label": "Ask how long they'll be and offer to take another route first",
      "verdict": "best",
      "consequence": "They are happy to chat and you alternate.",
      "considerations": [
        "Ask, don't assume",
        "Flexibility keeps the peace"
      ]
    },
    {
      "id": "cut",
      "label": "Start climbing ahead of them",
      "verdict": "poor",
      "consequence": "You've annoyed everyone and broken crag etiquette.",
      "considerations": [
        "Line jumping causes conflict",
        "Wait your turn"
      ]
    },
    {
      "id": "leave",
      "label": "Skip it and leave",
      "verdict": "acceptable",
      "consequence": "Not wrong, but you lose the day.",
      "considerations": [
        "Sharing works",
        "Ask first"
      ]
    }
  ],
  "expertNote": "Crag etiquette is mostly about asking, sharing and keeping things quiet.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym."
}
```

### `cl-ds-06` (oe-06 / seasonal-closure)

```json
{
  "prompt": "A sign says the cliff is closed for nesting birds.",
  "situation": {
    "narrative": "You drive an hour to a crag and find a seasonal closure sign at the trailhead.",
    "facts": [
      {
        "label": "Closure",
        "value": "Raptor nesting",
        "emphasis": "warning"
      },
      {
        "label": "Your plans",
        "value": "One free day"
      }
    ]
  },
  "options": [
    {
      "id": "respect",
      "label": "Respect the closure and pick another area",
      "verdict": "best",
      "consequence": "The birds nest safely and the area stays open for future seasons.",
      "considerations": [
        "Closures protect wildlife",
        "Breaking them can close the crag for good"
      ]
    },
    {
      "id": "sneak",
      "label": "Go anyway, nobody is watching",
      "verdict": "poor",
      "consequence": "You risk the birds and the access for everyone.",
      "considerations": [
        "Access depends on trust"
      ]
    },
    {
      "id": "ask",
      "label": "Check with the local climbing coalition for alternatives",
      "verdict": "acceptable",
      "consequence": "A local group can recommend another crag.",
      "considerations": [
        "Local knowledge helps"
      ]
    }
  ],
  "expertNote": "Seasonal closures are a big reason climbing access exists. Obeying them is how the community earns trust.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym."
}
```

### `cl-ds-07` (wc-05 / gym-to-crag-gap)

```json
{
  "prompt": "She invites you to a real crag next week.",
  "situation": {
    "narrative": "She wants to take you to a rock climbing area to show you a favorite route.",
    "facts": [
      {
        "label": "Your experience",
        "value": "Gym only"
      },
      {
        "label": "Her experience",
        "value": "Years"
      },
      {
        "label": "Setting",
        "value": "Outdoor rock",
        "emphasis": "warning"
      }
    ]
  },
  "options": [
    {
      "id": "guide",
      "label": "Say yes and suggest hiring a guide for the day",
      "verdict": "best",
      "consequence": "You get a safe introduction and she can just enjoy showing you the place.",
      "considerations": [
        "Guides teach outdoor systems",
        "She can be your friend not your instructor"
      ]
    },
    {
      "id": "no",
      "label": "Say yes and wing it",
      "verdict": "poor",
      "consequence": "The outdoors adds hazards you have not been taught.",
      "considerations": [
        "Gym skill isn't automatic",
        "Risks are higher"
      ]
    },
    {
      "id": "walk",
      "label": "Say yes and offer to watch from the ground and learn",
      "verdict": "acceptable",
      "consequence": "A good first step; you see the place without being on rope.",
      "considerations": [
        "Watching teaches culture",
        "Safe choice"
      ]
    }
  ],
  "expertNote": "Gym fitness is not crag readiness. Guides exist for this gap.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym.",
  "sayThisLine": "I'd love to see your crag. Could we hire a guide for my first day outside?"
}
```

### `cl-ds-08` (sc-06 / finger-pulley-injury)

```json
{
  "prompt": "Your finger pops and aches after a hard session.",
  "situation": {
    "narrative": "After a session on small crimps, a finger hurts when you bend it.",
    "facts": [
      {
        "label": "Pain",
        "value": "Sharp in finger",
        "emphasis": "warning"
      },
      {
        "label": "Session",
        "value": "Hard crimps"
      }
    ]
  },
  "options": [
    {
      "id": "rest",
      "label": "Stop climbing on it and see a clinician if pain persists",
      "verdict": "best",
      "consequence": "The finger gets the rest it needs.",
      "considerations": [
        "Tendon injuries need rest",
        "A clinician can diagnose"
      ]
    },
    {
      "id": "push",
      "label": "Climb through it",
      "verdict": "poor",
      "consequence": "It could become a longer injury.",
      "considerations": [
        "Pain is a warning"
      ]
    },
    {
      "id": "tape",
      "label": "Tape it and keep climbing",
      "verdict": "poor",
      "consequence": "Tape doesn't fix an injury.",
      "considerations": [
        "Don't mask pain"
      ]
    }
  ],
  "expertNote": "Finger injuries are common. Serious climbers rest early.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym."
}
```

### `cl-ds-09` (ll-04 / free-solo)

```json
{
  "prompt": "A friend wants to try climbing without a rope.",
  "situation": {
    "narrative": "After watching Free Solo, a friend says he wants to try soloing a cliff near your town.",
    "facts": [
      {
        "label": "His experience",
        "value": "Beginner",
        "emphasis": "warning"
      },
      {
        "label": "Movie",
        "value": "Free Solo"
      }
    ]
  },
  "options": [
    {
      "id": "no",
      "label": "Tell him free soloing is an extreme risk and suggest lessons",
      "verdict": "best",
      "consequence": "He hears you and signs up for a class.",
      "considerations": [
        "Honnold trained for years",
        "Mistakes can't be undone"
      ]
    },
    {
      "id": "go",
      "label": "Tell him it looks fine",
      "verdict": "poor",
      "consequence": "A fall could be fatal.",
      "considerations": [
        "No rope means no margin"
      ]
    },
    {
      "id": "gym",
      "label": "Suggest bouldering at the gym first",
      "verdict": "acceptable",
      "consequence": "A safer start, but the real answer is instruction.",
      "considerations": [
        "Gym first",
        "Get taught"
      ]
    }
  ],
  "expertNote": "Admire the skill, never imitate it. Even top free soloists prepare for years.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym.",
  "sayThisLine": "I love that film, but I'd never try it. Want to do a class instead?"
}
```

### `cl-ds-10` (sc-04 / gear-inspection)

```json
{
  "prompt": "A friend offers you his old rope.",
  "situation": {
    "narrative": "He says it's ten years old and has been in his garage, but it should be fine.",
    "facts": [
      {
        "label": "Rope",
        "value": "Ten years old",
        "emphasis": "warning"
      },
      {
        "label": "Storage",
        "value": "Garage"
      }
    ]
  },
  "options": [
    {
      "id": "decline",
      "label": "Decline and ask a gym or shop about new gear",
      "verdict": "best",
      "consequence": "You skip the risk and learn about gear life.",
      "considerations": [
        "Ropes age",
        "Ask a shop or instructor"
      ]
    },
    {
      "id": "use",
      "label": "Use it, it looks fine",
      "verdict": "poor",
      "consequence": "You can't see internal damage.",
      "considerations": [
        "Looks can deceive"
      ]
    },
    {
      "id": "ask",
      "label": "Ask an instructor what to do with old gear",
      "verdict": "acceptable",
      "consequence": "An expert can check and advise.",
      "considerations": [
        "Experts inspect gear"
      ]
    }
  ],
  "expertNote": "Gear is retired on schedule or after damage, not when it looks bad.",
  "safetyNote": "Learning scenario only. Learn belaying, leading and gear from a certified instructor or gym."
}
```

## 9. Talk Track scenarios (`talk-track`), 8 drafted

Launch target 24 (`conversationScenarios.count`). Deltas: good +20 to +25, meh -5 to +5, cringe -15 to -20.

| # | Track | Enthusiast line | What it means | Good | Meh | Cringe |
|---|---|---|---|---|---|---|
| 1 | `cl-tt-01` Her project | "I'm so close to sending my project. The crux is killing me." | She is one move from sending a hard route and the crux keeps stopping her. | "Sounds hard. What's the crux like?" | "You'll get it!" | "Just use a different hold." |
| 2 | `cl-tt-02` A flash | "I flashed a V4 I'd been eyeing all week!" | She climbed a V4 on her first try after studying it. | "Flash! Did you watch someone first?" | "Nice one!" | "V4 is easy, right?" |
| 3 | `cl-tt-03` She mentions a grade | "I'm working on V5s now." | She has reached a solid intermediate bouldering level. | "V5 is a real milestone. What's your favorite style?" | "What is that?" | "I could do a V5, easy." |
| 4 | `cl-tt-04` She invites you to try | "Want to try the rope side with me tonight?" | She is inviting you onto ropes, which needs a belay test first. | "I'd love to, but I'm not belay-tested. Could we do a class first?" | "Sure, whatever." | "Just show me how to belay." |
| 5 | `cl-tt-05` Crag talk | "We're going to the crag Saturday. It's a busy one." | A busy crag means etiquette matters. | "Fun! Any crag etiquette I should know, like noise and trash?" | "Sounds good." | "I'll blast music." |
| 6 | `cl-tt-06` Watching the Games | "Janja's on next. She's unreal." | Janja Garnbret is an Olympic champion; she is excited to watch. | "I heard she won Tokyo and Paris. What makes her so good?" | "Who's that?" | "Climbing is not a real sport." |
| 7 | `cl-tt-07` Do not spray | "I want to figure this one out myself." | She wants to solve it herself, which is normal climbing etiquette. | "Totally. I'll keep the beta to myself unless you ask." | "OK." | "Here, do this, then this." |
| 8 | `cl-tt-08` Speed talk | "The men's speed record is under five seconds. So fast." | The elite men's speed record is under five seconds over a 15 m wall. | "That is wild. Fifteen meters in under five seconds?" | "Fast!" | "It's not real climbing." |

### `cl-tt-01` (tw-01 / project)

```json
{
  "title": "Her project",
  "setting": "Texting after the gym",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I'm so close to sending my project. The crux is killing me.",
      "replies": [
        {
          "id": "good",
          "text": "Sounds hard. What's the crux like?",
          "smoothDelta": 20,
          "theirResponse": "A big span to a sloper. I keep falling off at the last second.",
          "coachNote": "Asks about her world without faking knowledge."
        },
        {
          "id": "meh",
          "text": "You'll get it!",
          "smoothDelta": 5,
          "theirResponse": "Thanks, hope so.",
          "coachNote": "Kind but generic."
        },
        {
          "id": "bad",
          "text": "Just use a different hold.",
          "smoothDelta": -15,
          "theirResponse": "That's not how it works...",
          "coachNote": "Don't advise what you don't know."
        }
      ]
    }
  ],
  "closingNote": "Ask what the crux is and let her tell the story."
}
```

- (+20) "Sounds hard. What's the crux like?" -> Asks about her world without faking knowledge.
- (+5) "You'll get it!" -> Kind but generic.
- (-15) "Just use a different hold." -> Don't advise what you don't know.

### `cl-tt-02` (tw-02 / flash)

```json
{
  "title": "A flash",
  "setting": "Gym night",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I flashed a V4 I'd been eyeing all week!",
      "replies": [
        {
          "id": "good",
          "text": "Flash! Did you watch someone first?",
          "smoothDelta": 20,
          "theirResponse": "Yes, I watched two people and found the sequence.",
          "coachNote": "Uses the right word and asks a real question."
        },
        {
          "id": "meh",
          "text": "Nice one!",
          "smoothDelta": 5,
          "theirResponse": "Thanks!",
          "coachNote": "Fine but shallow."
        },
        {
          "id": "bad",
          "text": "V4 is easy, right?",
          "smoothDelta": -15,
          "theirResponse": "Not for me, it took weeks to get there.",
          "coachNote": "Grades are personal."
        }
      ]
    }
  ],
  "closingNote": "Celebrate and ask about the process."
}
```

- (+20) "Flash! Did you watch someone first?" -> Uses the right word and asks a real question.
- (+5) "Nice one!" -> Fine but shallow.
- (-15) "V4 is easy, right?" -> Grades are personal.

### `cl-tt-03` (tw-03 / v-scale)

```json
{
  "title": "She mentions a grade",
  "setting": "Text",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I'm working on V5s now.",
      "replies": [
        {
          "id": "good",
          "text": "V5 is a real milestone. What's your favorite style?",
          "smoothDelta": 20,
          "theirResponse": "Probably slopey stuff.",
          "coachNote": "Shows you know V grades mean something."
        },
        {
          "id": "meh",
          "text": "What is that?",
          "smoothDelta": 0,
          "theirResponse": "It's a bouldering grade. V0 to V17.",
          "coachNote": "Honest but skips a chance."
        },
        {
          "id": "bad",
          "text": "I could do a V5, easy.",
          "smoothDelta": -20,
          "theirResponse": "Uh, okay.",
          "coachNote": "Do not fake expertise."
        }
      ]
    }
  ],
  "closingNote": "Ask about style, not just the number."
}
```

- (+20) "V5 is a real milestone. What's your favorite style?" -> Shows you know V grades mean something.
- (+0) "What is that?" -> Honest but skips a chance.
- (-20) "I could do a V5, easy." -> Do not fake expertise.

### `cl-tt-04` (tw-04 / certified-instruction)

```json
{
  "title": "She invites you to try",
  "setting": "After a date",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Want to try the rope side with me tonight?",
      "replies": [
        {
          "id": "good",
          "text": "I'd love to, but I'm not belay-tested. Could we do a class first?",
          "smoothDelta": 25,
          "theirResponse": "Great idea, I'll sign us up.",
          "coachNote": "Safe, honest and keeps the date."
        },
        {
          "id": "meh",
          "text": "Sure, whatever.",
          "smoothDelta": -5,
          "theirResponse": "Um, it needs a test first.",
          "coachNote": "Don't agree without knowing."
        },
        {
          "id": "bad",
          "text": "Just show me how to belay.",
          "smoothDelta": -20,
          "theirResponse": "It isn't something I can teach over text.",
          "coachNote": "Belaying is learned from staff."
        }
      ]
    }
  ],
  "closingNote": "Say you want to learn properly. It is attractive."
}
```

- (+25) "I'd love to, but I'm not belay-tested. Could we do a class first?" -> Safe, honest and keeps the date.
- (-5) "Sure, whatever." -> Don't agree without knowing.
- (-20) "Just show me how to belay." -> Belaying is learned from staff.

### `cl-tt-05` (tw-05 / crag-etiquette)

```json
{
  "title": "Crag talk",
  "setting": "Text",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "We're going to the crag Saturday. It's a busy one.",
      "replies": [
        {
          "id": "good",
          "text": "Fun! Any crag etiquette I should know, like noise and trash?",
          "smoothDelta": 20,
          "theirResponse": "Yes, pack it all out and keep the noise down.",
          "coachNote": "Shows respect for the place."
        },
        {
          "id": "meh",
          "text": "Sounds good.",
          "smoothDelta": 0,
          "theirResponse": "Yeah.",
          "coachNote": "Neutral."
        },
        {
          "id": "bad",
          "text": "I'll blast music.",
          "smoothDelta": -15,
          "theirResponse": "Please don't.",
          "coachNote": "Noise upsets other climbers."
        }
      ]
    }
  ],
  "closingNote": "Good partners care about the crag."
}
```

- (+20) "Fun! Any crag etiquette I should know, like noise and trash?" -> Shows respect for the place.
- (+0) "Sounds good." -> Neutral.
- (-15) "I'll blast music." -> Noise upsets other climbers.

### `cl-tt-06` (tw-06 / olympic-climbing)

```json
{
  "title": "Watching the Games",
  "setting": "On the couch",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Janja's on next. She's unreal.",
      "replies": [
        {
          "id": "good",
          "text": "I heard she won Tokyo and Paris. What makes her so good?",
          "smoothDelta": 20,
          "theirResponse": "Everything! She's strong and calm.",
          "coachNote": "Uses a fact and asks."
        },
        {
          "id": "meh",
          "text": "Who's that?",
          "smoothDelta": 0,
          "theirResponse": "A Slovenian star!",
          "coachNote": "Fine, but ask after a fact."
        },
        {
          "id": "bad",
          "text": "Climbing is not a real sport.",
          "smoothDelta": -20,
          "theirResponse": "Wow.",
          "coachNote": "Never dismiss her passion."
        }
      ]
    }
  ],
  "closingNote": "Show curiosity about what she admires."
}
```

- (+20) "I heard she won Tokyo and Paris. What makes her so good?" -> Uses a fact and asks.
- (+0) "Who's that?" -> Fine, but ask after a fact.
- (-20) "Climbing is not a real sport." -> Never dismiss her passion.

### `cl-tt-07` (tw-01 / beta-spray)

```json
{
  "title": "Do not spray",
  "setting": "Gym",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I want to figure this one out myself.",
      "replies": [
        {
          "id": "good",
          "text": "Totally. I'll keep the beta to myself unless you ask.",
          "smoothDelta": 20,
          "theirResponse": "Thanks, that means a lot.",
          "coachNote": "You get climbing etiquette."
        },
        {
          "id": "meh",
          "text": "OK.",
          "smoothDelta": 0,
          "theirResponse": "Thanks.",
          "coachNote": "Fine."
        },
        {
          "id": "bad",
          "text": "Here, do this, then this.",
          "smoothDelta": -15,
          "theirResponse": "I asked you not to.",
          "coachNote": "Beta spray is rude."
        }
      ]
    }
  ],
  "closingNote": "If in doubt, ask before sharing beta."
}
```

- (+20) "Totally. I'll keep the beta to myself unless you ask." -> You get climbing etiquette.
- (+0) "OK." -> Fine.
- (-15) "Here, do this, then this." -> Beta spray is rude.

### `cl-tt-08` (tw-06 / speed-format)

```json
{
  "title": "Speed talk",
  "setting": "Watching a comp",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "The men's speed record is under five seconds. So fast.",
      "replies": [
        {
          "id": "good",
          "text": "That is wild. Fifteen meters in under five seconds?",
          "smoothDelta": 20,
          "theirResponse": "Yes! It's the same wall everywhere.",
          "coachNote": "Shows you know the wall."
        },
        {
          "id": "meh",
          "text": "Fast!",
          "smoothDelta": 5,
          "theirResponse": "Right?",
          "coachNote": "Fine."
        },
        {
          "id": "bad",
          "text": "It's not real climbing.",
          "smoothDelta": -15,
          "theirResponse": "It's a real discipline.",
          "coachNote": "Don't dismiss."
        }
      ]
    }
  ],
  "closingNote": "Appreciate the discipline."
}
```

- (+20) "That is wild. Fifteen meters in under five seconds?" -> Shows you know the wall.
- (+5) "Fast!" -> Fine.
- (-15) "It's not real climbing." -> Don't dismiss.

## 10. Say this (`say-this`) samples

### `cl-sy-01` (st-02 / flash)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "I flashed my first V5 last night!"
  },
  "options": [
    {
      "id": "first-try",
      "text": "She climbed it first try after getting beta",
      "isCorrect": true,
      "explanation": "A flash is a first-try send with some info beforehand."
    },
    {
      "id": "fell",
      "text": "She fell and quit",
      "isCorrect": false,
      "explanation": "A flash means no falls."
    },
    {
      "id": "watched",
      "text": "She had no information at all",
      "isCorrect": false,
      "explanation": "That would be an onsight."
    },
    {
      "id": "v5",
      "text": "It was an easy grade",
      "isCorrect": false,
      "explanation": "V5 is a solid intermediate-hard boulder grade."
    }
  ],
  "translation": "She climbed a V5 boulder on her first attempt, having seen or heard how it goes. That is a big win.",
  "followUps": [
    {
      "line": "Did you watch anyone first, or did you get beta?",
      "why": "Shows you know the difference between flash and onsight."
    },
    {
      "line": "What was the crux?",
      "why": "Invites her to tell the story."
    }
  ],
  "noFakeExpertNote": "Ask what happened; don't pretend to know the boulder."
}
```

### `cl-sy-02` (st-03 / project)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "I've been on my project for three weeks. I finally linked the crux today."
  },
  "options": [
    {
      "id": "progress",
      "text": "She is close to sending a hard route",
      "isCorrect": true,
      "explanation": "Linking the crux means she did the hardest part in one go."
    },
    {
      "id": "quit",
      "text": "She gave up",
      "isCorrect": false,
      "explanation": "She linked it, so the opposite."
    },
    {
      "id": "new",
      "text": "She started a new route",
      "isCorrect": false,
      "explanation": "A project runs over weeks."
    },
    {
      "id": "walk",
      "text": "She walked past it",
      "isCorrect": false,
      "explanation": "Not what linked means."
    }
  ],
  "translation": "She has been working a hard route for weeks and strung together its hardest section for the first time.",
  "followUps": [
    {
      "line": "How close are you to sending?",
      "why": "Shows you know linking is the step before sending."
    },
    {
      "line": "What's the crux like?",
      "why": "Invites her to describe it."
    }
  ],
  "noFakeExpertNote": "Do not give movement advice. Listen and ask."
}
```

### `cl-sy-03` (sc-07 / gym-to-crag-gap)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "Next month I want to start leading outside. I'm booking a guide."
  },
  "options": [
    {
      "id": "safe",
      "text": "She plans to learn outdoors the careful way",
      "isCorrect": true,
      "explanation": "Hiring a guide is the standard way to start outdoors."
    },
    {
      "id": "boasting",
      "text": "She is bragging",
      "isCorrect": false,
      "explanation": "She is planning responsibly."
    },
    {
      "id": "quit",
      "text": "She is quitting the gym",
      "isCorrect": false,
      "explanation": "Not implied."
    },
    {
      "id": "solo",
      "text": "She will go alone",
      "isCorrect": false,
      "explanation": "A guide is a person."
    }
  ],
  "translation": "She wants to lead real routes outside and plans to learn with a certified guide. That is smart and normal.",
  "followUps": [
    {
      "line": "Where are you going?",
      "why": "Shows interest without pretending to know."
    },
    {
      "line": "What do you want to learn first?",
      "why": "Respects the process."
    }
  ],
  "noFakeExpertNote": "Do not offer gear or technique advice."
}
```

### `cl-sy-04` (cc-05 / olympic-climbing)

```json
{
  "statement": {
    "speaker": "Her",
    "text": "Three separate medals at LA28! Finally."
  },
  "options": [
    {
      "id": "olympics",
      "text": "Boulder, lead and speed each get their own medal",
      "isCorrect": true,
      "explanation": "LA28 gives each discipline its own event."
    },
    {
      "id": "one",
      "text": "Only one medal exists",
      "isCorrect": false,
      "explanation": "That was Tokyo."
    },
    {
      "id": "speedonly",
      "text": "Only speed is included",
      "isCorrect": false,
      "explanation": "All three are in."
    },
    {
      "id": "sport",
      "text": "A gym opened",
      "isCorrect": false,
      "explanation": "Not related."
    }
  ],
  "translation": "She is happy the Olympics will award separate medals for boulder, lead and speed at the 2028 Los Angeles Games.",
  "followUps": [
    {
      "line": "Who do you think wins the boulder medal?",
      "why": "Keeps the talk open."
    },
    {
      "line": "Which discipline do you like watching?",
      "why": "Invites her taste."
    }
  ]
}
```

## 11. Fill the gap (`fill-the-gap`) samples

### `cl-fg-01` (st-01 / crux)

```json
{
  "prompt": "Fill in the climbing word.",
  "template": "The hardest section of a route is the {{word}}.",
  "gaps": [
    {
      "id": "word",
      "options": [
        "crux",
        "jug",
        "pinch",
        "volume"
      ],
      "correct": "crux"
    }
  ],
  "explanation": {
    "correct": "The crux is the hardest section, and climbers always ask what it is.",
    "incorrect": "The hardest section is called the crux. Jugs are easy holds.",
    "sayThisLine": "What's the crux?"
  }
}
```

### `cl-fg-02` (gn-02 / yds)

```json
{
  "prompt": "Complete the grade.",
  "template": "Roped routes in North America use the {{scale}} scale, like 5.{{num}}.",
  "gaps": [
    {
      "id": "scale",
      "options": [
        "YDS",
        "V-scale",
        "Font"
      ],
      "correct": "YDS"
    },
    {
      "id": "num",
      "options": [
        "10a",
        "V4",
        "7a"
      ],
      "correct": "10a"
    }
  ],
  "explanation": {
    "correct": "YDS grades start with 5. and a number, with letters from 10 up.",
    "incorrect": "YDS is the roped scale and it reads like 5.10a. V grades are for boulders."
  }
}
```

### `cl-fg-03` (oe-03 / leave-no-trace)

```json
{
  "prompt": "Fill in the crag habit.",
  "template": "At the crag, {{action}} your trash and {{action2}} tick marks you left.",
  "gaps": [
    {
      "id": "action",
      "options": [
        "pack out",
        "bury",
        "burn"
      ],
      "correct": "pack out"
    },
    {
      "id": "action2",
      "options": [
        "brush off",
        "add",
        "ignore"
      ],
      "correct": "brush off"
    }
  ],
  "explanation": {
    "correct": "Packing out trash and brushing tick marks helps keep access.",
    "incorrect": "Pack it out and brush your marks. Burying or burning trash is not Leave No Trace.",
    "sayThisLine": "Pack it out, always."
  }
}
```

## 12. Estimate slider (`estimate-slider`) samples

### `cl-es-01` (cc-04 / speed-format)

```json
{
  "prompt": "How tall is the Olympic speed wall, in meters?",
  "unit": "meters",
  "min": 5,
  "max": 30,
  "step": 1,
  "correctValue": 15,
  "tolerance": {
    "full": 1,
    "partial": 3
  },
  "explanation": {
    "correct": "The standard speed wall is 15 meters, identical around the world so times can be compared.",
    "incorrect": "It is 15 meters, the same everywhere, so records mean something.",
    "sayThisLine": "It's a 15-meter sprint."
  }
}
```

### `cl-es-02` (ll-03 / dawn-wall)

```json
{
  "prompt": "How many days did the Dawn Wall free ascent take in 2015?",
  "unit": "days",
  "min": 1,
  "max": 40,
  "step": 1,
  "correctValue": 19,
  "tolerance": {
    "full": 2,
    "partial": 5
  },
  "explanation": {
    "correct": "Caldwell and Jorgeson spent 19 days on the wall in January 2015.",
    "incorrect": "It took 19 days, with days of rest and rough weather."
  }
}
```

### `cl-es-03` (ll-06 / burden-of-dreams)

```json
{
  "prompt": "The hardest confirmed boulder is V what?",
  "unit": "V grade",
  "min": 8,
  "max": 20,
  "step": 1,
  "correctValue": 17,
  "tolerance": {
    "full": 0,
    "partial": 1
  },
  "explanation": {
    "correct": "Burden of Dreams is graded V17 (9A) and repeated by others.",
    "incorrect": "The top of the boulder scale for confirmed problems is V17."
  }
}
```

## 13. Hotspot tap (`hotspot-tap`) samples

### `cl-ht-01` (rw-05 / wall-overhang)

```json
{
  "prompt": "Tap the overhanging section.",
  "diagram": {
    "diagramId": "wall-side-profile",
    "aspectRatio": 1.2,
    "alt": "Side profile of a climbing wall with a slab on the left, a vertical middle and an overhang on the right."
  },
  "hotspots": [
    {
      "id": "slab",
      "label": "Slab",
      "shape": {
        "kind": "circle",
        "cx": 0.2,
        "cy": 0.6,
        "r": 0.1
      }
    },
    {
      "id": "vertical",
      "label": "Vertical",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.1
      }
    },
    {
      "id": "overhang",
      "label": "Overhang",
      "shape": {
        "kind": "circle",
        "cx": 0.8,
        "cy": 0.4,
        "r": 0.1
      }
    }
  ],
  "correctHotspotIds": [
    "overhang"
  ],
  "explanation": {
    "correct": "The overhang leans out past vertical, so your arms carry more weight.",
    "incorrect": "The overhang is the part leaning out over the floor. The slab leans back.",
    "sayThisLine": "It's overhanging, so the arms have to work."
  }
}
```

### `cl-ht-02` (rw-03 / arete)

```json
{
  "prompt": "Tap the arete.",
  "diagram": {
    "diagramId": "block-top-down",
    "aspectRatio": 1.2,
    "alt": "Top-down sketch of a block with one outside corner and one inside corner."
  },
  "hotspots": [
    {
      "id": "arete",
      "label": "Outside corner",
      "shape": {
        "kind": "circle",
        "cx": 0.7,
        "cy": 0.3,
        "r": 0.08
      }
    },
    {
      "id": "dihedral",
      "label": "Inside corner",
      "shape": {
        "kind": "circle",
        "cx": 0.3,
        "cy": 0.3,
        "r": 0.08
      }
    },
    {
      "id": "face",
      "label": "Flat face",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.7,
        "r": 0.1
      }
    }
  ],
  "correctHotspotIds": [
    "arete"
  ],
  "explanation": {
    "correct": "An arete is an outside corner, like the edge of a building.",
    "incorrect": "The outside corner is the arete. The inside corner is a dihedral."
  }
}
```

### `cl-ht-03` (rw-04 / start-holds)

```json
{
  "prompt": "Tap the start holds.",
  "diagram": {
    "diagramId": "problem-diagram",
    "aspectRatio": 1.2,
    "alt": "Wall diagram with a problem marked by green tape: two start holds low, several holds above, and a finish hold at top."
  },
  "hotspots": [
    {
      "id": "start",
      "label": "Low tagged holds",
      "shape": {
        "kind": "circle",
        "cx": 0.4,
        "cy": 0.85,
        "r": 0.08
      }
    },
    {
      "id": "mid",
      "label": "Middle hold",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.5,
        "r": 0.08
      }
    },
    {
      "id": "finish",
      "label": "Top hold",
      "shape": {
        "kind": "circle",
        "cx": 0.5,
        "cy": 0.15,
        "r": 0.08
      }
    }
  ],
  "correctHotspotIds": [
    "start"
  ],
  "explanation": {
    "correct": "Start holds are the tagged holds where you begin, usually low.",
    "incorrect": "The starts are the tagged holds at the bottom; the finish hold is at the top."
  }
}
```

## 14. Playbook terms

Each row becomes a curriculum `concepts[]` item: `id`, `term`, `definition`, `exampleLine`. Lesson conceptIds in `CDS.md` section 11 use these ids. Gear, movement and risk terms are vocabulary only; none is an instruction.

| id | Term | Definition | Example line | First taught |
|---|---|---|---|---|
| `climbing-disciplines` | Climbing disciplines | The main flavors: bouldering, top rope, lead (sport), trad, speed, and big-wall. Each has its own gear, risks and culture. | "I'm a boulderer. Ropes stress me out." "Ha. I'm a sport climber. Bouldering destroys my skin." | `what-is-climbing` |
| `bouldering` | Bouldering | Climbing short problems without a rope, over crash pads, where falls are short and planned for. | "Bouldering night! Six problems, one project, zero ropes." | `what-is-climbing` |
| `top-rope` | Top rope | A rope already runs through an anchor above the climber, so a fall is a short slip that the belayer catches. | "Top rope is where everyone starts. It's the friendliest way to be on a rope." | `what-is-climbing` |
| `lead-climbing` | Lead climbing | Climbing up with the rope attached to you and clipping it into protection as you go; falls are longer, so it needs training and a trusted partner. | "She's leading a 5.11 tomorrow. She's nervous, which honestly is the right amount." | `what-is-climbing` |
| `sport-climbing` | Sport climbing | Lead climbing on routes with pre-placed bolts for protection, so the challenge is movement and endurance. | "Sport climbing is about pulling hard. The bolts are already there." | `what-is-climbing` |
| `trad-climbing` | Trad climbing | Lead climbing where the climber places removable protection in cracks and then removes it, which adds judgment and a lot of skill. | "Trad is a different sport. You're climbing and building your own safety net." | `what-is-climbing` |
| `free-solo` | Free solo | Climbing with no rope or protection at all. It is extremely dangerous and is not what gyms or beginners do. | "Free solo is the thing in the movie. Nobody on my team does it." | `what-is-climbing` |
| `aid-climbing` | Aid climbing | Using gear to pull or stand on to make upward progress, common on big walls, as opposed to free climbing with hands and feet on rock. | "Free climbing means the gear is only for safety. Aid means you use it to go up." | `what-is-climbing` |
| `big-wall` | Big wall | A long, multi-day or multi-pitch climb on a huge cliff, like El Capitan. | "She wants to do a big wall someday. It takes days and a lot of planning." | `what-is-climbing` |
| `multi-pitch` | Multi-pitch | A climb split into several rope-lengths (pitches) with stops at ledges in between. | "It's a four-pitch climb. We'll be up there most of the day." | `what-is-climbing` |
| `pitch` | Pitch | One rope-length of a climb, from one belay stop to the next. | "The crux is on pitch three." | `what-is-climbing` |
| `gym-vs-crag` | Gym vs crag | Gyms are plastic holds with setters and padded floors; crags are natural rock where routes are found, not set. | "Gym climbing is great, but real rock feels different. There's no color-coded tape." | `what-is-climbing` |
| `belayer` | Belayer | The partner who manages the rope for a roped climber. A serious responsibility that takes training and a certified check-off. | "I trust my belayer completely. That's the whole thing." | `what-is-climbing` |
| `climbing-partner` | Climbing partner | Someone you climb with regularly and trust with safety; partnerships are a big part of climbing culture. | "Finding a good partner is half the sport." | `what-is-climbing` |
| `climbing-shoes` | Climbing shoes | Tight, sticky-rubber shoes for precise footwork; often fit snugly and not for walking. | "They hurt, but that's the fit. I take them off between attempts." | `what-is-climbing` |
| `chalk` | Chalk | Powdered magnesium carbonate that keeps hands dry for grip; some gyms limit loose chalk. | "Chalk bag's my favorite accessory." | `what-is-climbing` |
| `harness` | Harness | The waist and leg gear a roped climber wears; a safety item that should be fitted and checked by someone qualified. | "Always get your harness checked by the gym staff." | `what-is-climbing` |
| `crash-pad` | Crash pad | A thick foam pad bouldering climbers place under the problem to cushion falls; it reduces risk but does not remove it. | "We brought three pads for that landing." | `what-is-climbing` |
| `autobelay` | Auto-belay | A device on some gym walls that catches a climber automatically; used only after the gym's orientation. | "The autobelay lets me climb when my partner isn't here." | `what-is-climbing` |
| `certified-instruction` | Certified instruction | Learning ropes, belaying and gear from a qualified gym instructor or certified guide, never from videos or friends alone. | "I booked a learn-to-belay class. It's the responsible move." | `what-is-climbing` |
| `hold-jug` | Jug | A big, positive hold you can wrap your hand around; the friendliest kind of hold. | "There's a jug at the top. I can breathe again." | `reading-the-wall` |
| `hold-crimp` | Crimp | A small edge you grip with fingertips; hard on fingers and a classic of hard climbing. | "It's all crimps. My fingers hate me." | `reading-the-wall` |
| `hold-sloper` | Sloper | A rounded hold with no edge that you hold by friction and body position. | "Slopers are all about body tension." | `reading-the-wall` |
| `hold-pinch` | Pinch | A hold you squeeze between thumb and fingers. | "It's a fat pinch. I can't close my hand around it." | `reading-the-wall` |
| `hold-pocket` | Pocket | A hole in the rock or plastic where you put one to three fingers. | "Two-finger pocket. Careful with tendons." | `reading-the-wall` |
| `hold-undercling` | Undercling | A hold you grab from underneath, pulling up and out. | "The key is the undercling. You lean back on it." | `reading-the-wall` |
| `hold-sidepull` | Sidepull | A hold you grip from the side, with your body leaning away. | "It's a sidepull, so you need to face the other way." | `reading-the-wall` |
| `hold-gaston` | Gaston | A hold you press outward on, like opening a sliding door, with your elbow out. | "The gaston move is brutal on shoulders." | `reading-the-wall` |
| `volume` | Volume | A large geometric shape bolted to a gym wall that adds features and can have holds attached. | "He climbed onto the volume and stood up. It was a mantle move." | `reading-the-wall` |
| `wall-slab` | Slab | A wall leaning back less than vertical; balance and footwork matter more than pulling. | "Slab is all trust in your feet." | `reading-the-wall` |
| `wall-vertical` | Vertical wall | A wall at 90 degrees to the ground. | "It's a vertical face with small holds." | `reading-the-wall` |
| `wall-overhang` | Overhang | A wall leaning out past vertical so you hang from your arms; steeper means harder on the body. | "It's 45 degrees overhanging. Core strength city." | `reading-the-wall` |
| `wall-roof` | Roof | A horizontal or nearly horizontal section where you climb upside down. | "She crushed the roof and never came off." | `reading-the-wall` |
| `arete` | Arete | An outside corner, like the edge of a building, that you climb along or beside. | "That arete is a classic line." | `reading-the-wall` |
| `dihedral` | Dihedral (corner) | An inside corner where two walls meet at an angle, like an open book. | "A perfect dihedral. You can stem up it." | `reading-the-wall` |
| `crack` | Crack | A line in the rock where fingers, hands or fists can jam. | "Crack climbing is a whole skill. It hurts in a way you grow to love." | `reading-the-wall` |
| `route-tape-colors` | Hold color and tape | Gyms mark each problem by hold color or tape so climbers follow one route at a time. | "Follow the green holds. The blue ones are someone else's." | `reading-the-wall` |
| `start-holds` | Start and finish holds | Marked holds you begin on and hold to finish a problem, usually with a clear number or tag. | "Match the start, control the finish." | `reading-the-wall` |
| `top-out` | Top out | Climbing over the top of a boulder or wall and standing on top; often a finish outdoors, not always in the gym. | "She topped out and stood there for a second." | `reading-the-wall` |
| `feature-reading` | Reading the wall | Looking at a problem from the ground and planning which holds, angles and rests you'll use before you touch it. | "Give me a minute to read it first." | `reading-the-wall` |
| `v-scale` | V-scale | The U.S. bouldering grade scale, V0 upward and open-ended; it began at Hueco Tanks, Texas. | "I just sent my first V4!" | `grades-and-numbers` |
| `yds` | YDS (5.x) | The Yosemite Decimal System for roped climbs: 5.0 to 5.15, with letters a to d from 5.10 up. | "It's a 5.10 but feels harder." | `grades-and-numbers` |
| `font-scale` | Font scale | The bouldering scale from Fontainebleau, France, written like 6A, 7B+; used across Europe. | "It's a 7A in Font grades." | `grades-and-numbers` |
| `french-scale` | French sport scale | The European sport-route scale like 6b, 7a+, 9c; used in most of the world outside North America. | "I projected an 8a at Kalymnos." | `grades-and-numbers` |
| `grade-subjectivity` | Grades are opinions | A grade is a consensus opinion shaped by height, reach, style and local tradition, not a measurement. | "It's a V5 for tall people and V7 if you're short." | `grades-and-numbers` |
| `sandbag` | Sandbag | A route or problem that feels harder than its listed grade. | "Don't trust the grade. That V3 is a sandbag." | `grades-and-numbers` |
| `soft-grade` | Soft grade | A route that feels easier than its grade, sometimes called a gift. | "It's soft for the grade. You'll like it." | `grades-and-numbers` |
| `grade-conversion` | Grade conversion | Rough translation between scales; approximate because scales and places disagree. | "V5 is somewhere around 6C, but don't quote me." | `grades-and-numbers` |
| `gym-grades` | Gym grades | Gym grades are set by staff and are often looser than outdoor grades; some gyms use colors instead of numbers. | "Gym V4 and outdoor V4 are totally different animals." | `grades-and-numbers` |
| `grade-pyramid` | Grade pyramid | A training idea: many easier climbs for each harder one, building a broad base. | "I need more volume at my base, not just projects." | `grades-and-numbers` |
| `beta` | Beta | Information about how to climb a route: sequence, holds, tricks. It is a gift and a spoiler. | "Want beta or do you want to figure it out?" | `send-talk` |
| `crux` | Crux | The hardest section of a route or problem. | "The crux is that second move." | `send-talk` |
| `send` | Send | To climb a route successfully, without falling or resting on gear. | "She sent it on her fourth go." | `send-talk` |
| `flash` | Flash | Sending a route on the first try after getting beta. | "He flashed it. He'd watched two people first." | `send-talk` |
| `onsight` | Onsight | Sending a route on the first try with no prior info, no beta and no watching. | "An onsight of a 5.11 is a big deal." | `send-talk` |
| `redpoint` | Redpoint | Sending a lead route clean, without falls, after trying it before. | "I finally redpointed my project." | `send-talk` |
| `pinkpoint` | Pinkpoint | Leading a route with the protection already placed, clean, after practice. | "Pinkpoint means the gear was pre-placed." | `send-talk` |
| `project` | Project | A route or problem you try repeatedly over time because it's at your limit. | "It's been my project for six months." | `send-talk` |
| `attempt` | Attempt, go, burn | One try on a route or problem; climbers count them. | "Three more burns and I'm done." | `send-talk` |
| `working-a-route` | Working a route | Trying a route in pieces over several sessions to learn its moves before linking them. | "I'm working it. Sunday I might link it." | `send-talk` |
| `link-up` | Link up | Connecting sections of a route without falling. | "I linked the first half today." | `send-talk` |
| `dyno` | Dyno | A dynamic move where you jump to a hold. | "The dyno at the end is scary good." | `send-talk` |
| `pumped` | Pumped | Forearms swollen and tired from sustained climbing; your grip fades. | "I got so pumped I dropped off." | `send-talk` |
| `whipper` | Whipper | A big dramatic fall; climbers say it with wide eyes. | "She took a whipper and laughed." | `send-talk` |
| `take` | Take! | What a climber calls to say 'I'm going to hang on the rope'. Learned in instruction with a partner. | "I heard take and knew she was done." | `send-talk` |
| `beta-spray` | Beta spray | Giving unsolicited beta; considered rude in climbing culture. | "Please, no spray. I want to figure it out." | `send-talk` |
| `proud` | Proud line | A route that's aesthetic, obvious and impressive. | "That's a proud line. Everybody wants it." | `send-talk` |
| `flagging` | Flagging | Extending a leg out for balance rather than using a foothold. | "Flag your left foot and the barn-door stops." | `movement-words` |
| `heel-hook` | Heel hook | Hooking a heel on a hold to pull with your leg. | "Heel hook saved me. My leg did the work." | `movement-words` |
| `toe-hook` | Toe hook | Hooking the top of your toe onto a hold to hold tension. | "Toe hook on the roof. Feels sketchy, works." | `movement-words` |
| `drop-knee` | Drop knee | Rotating a knee inward to bring your hips close to the wall. | "Drop knee there and you get so much reach." | `movement-words` |
| `smear` | Smearing | Using the friction of the shoe rubber on a blank surface instead of a hold. | "This slab is all smears." | `movement-words` |
| `mantle` | Mantle | Pressing down on a hold to lift yourself up onto a ledge, like getting out of a pool. | "It ends with a mantle. Ugly but rewarding." | `movement-words` |
| `deadpoint` | Deadpoint | A controlled dynamic move where you reach the hold at the zero-gravity moment at the top of your motion. | "It's a deadpoint to the crimp." | `movement-words` |
| `lock-off` | Lock-off | Holding one arm bent while the other reaches. | "Lock-off on the left and reach." | `movement-words` |
| `footwork` | Footwork | Precise foot placement; beginners pull with arms, experienced climbers push with legs. | "Good footwork is the secret. My feet do more than my arms." | `movement-words` |
| `campusing` | Campusing | Climbing with only hands, no feet; a training exercise. | "The campus board is a training tool, not a climbing style." | `movement-words` |
| `hangboard` | Hangboard | A training board for finger strength; overuse is a common injury source. | "She's a hangboard person. I asked about her routine." | `movement-words` |
| `rest-day` | Rest day | A day off climbing for recovery; tendons recover slower than muscles. | "Rest day. Tendons need time." | `movement-words` |
| `gym-etiquette` | Gym etiquette | Shared habits: don't walk under climbers, keep chalk reasonable, clean up, wait your turn. | "Never stand under someone climbing." | `gym-culture` |
| `problem-setting` | Problem setting | The craft of designing routes on gym walls with holds, tape and difficulty; done by trained setters. | "The new set is fire. The setters cooked." | `gym-culture` |
| `route-setter` | Route setter | A gym staffer who designs and sets routes and problems. | "Our setter loves slopers. I can tell." | `gym-culture` |
| `reset-day` | Reset day | A day a section of the gym is stripped and reset with new problems. | "Reset day! New problems!" | `gym-culture` |
| `fall-zone` | Fall zone | The area beneath a climber on the wall; keep it clear. | "Watch the fall zone. Somebody's coming down." | `gym-culture` |
| `spotting-culture` | Spotting | Watching and guiding a bouldering climber's fall; a skill to be taught, not guessed. | "Can you spot me? Show me how first." | `gym-culture` |
| `belay-test` | Belay test | A gym check where staff confirm you can belay before you're allowed to. | "I passed my belay test yesterday." | `gym-culture` |
| `gym-orientation` | Gym orientation | The first-visit briefing on gym rules, pads, autobelays and areas. | "Do the orientation. It's not optional." | `gym-culture` |
| `comp-style-set` | Comp-style set | Problems set to mimic competition: big moves, unusual shapes, short and powerful. | "This is comp style. It's more jumpy." | `gym-culture` |
| `climbing-community` | Climbing community | A social culture where people cheer each other on and trade beta; gym nights are dates, not contests. | "Everyone cheers you on. It's so wholesome." | `gym-culture` |
| `safety-culture` | Safety culture | Climbing's habit of checking yourself and partner, asking questions and calling out mistakes without ego. | "We always double check. It's just what we do." | `safety-culture` |
| `buddy-check` | Buddy check | A partner check before leaving the ground; learned from an instructor and treated as non-negotiable. | "Buddy check. Every time, no exceptions." | `safety-culture` |
| `risk-acknowledgement` | Risk and waivers | Climbing has real risk; gyms use waivers and orientation to make that clear. | "I signed the waiver. I'm aware it's a risk sport." | `safety-culture` |
| `instructor-led` | Instructor-led learning | Safety skills are learned hands-on from a certified instructor or guide, not from an app. | "I'm learning from an instructor. Not YouTube." | `safety-culture` |
| `gear-inspection` | Gear care | Ropes and gear are inspected, retired when worn and used as their makers direct. | "She retired that rope. Safe is better." | `safety-culture` |
| `leader-fall` | Leader fall | A fall while leading; bigger than a top-rope slip, which is why lead is taught in steps. | "A leader fall is normal in the sport, but it's a trained skill." | `safety-culture` |
| `hazard-humility` | Humility | The habit of saying 'I don't know' and asking questions; most accidents involve ego or rushing. | "I said I wasn't sure and the guide re-explained. Great." | `safety-culture` |
| `finger-pulley-injury` | Finger pulley injury | A common climber injury in the fingers; see a clinician if pain persists. | "She tweaked a pulley. She's resting for weeks." | `safety-culture` |
| `gym-to-crag-gap` | Gym-to-crag gap | Outdoor climbing adds rock quality, anchors, weather and route-finding; gym skill isn't automatically enough. | "Outdoors is a whole new set of skills." | `safety-culture` |
| `guide-service` | Guide service | Certified guides lead beginners outdoors and teach skills. | "We booked a guide for our first day on the rock." | `safety-culture` |
| `quickdraw` | Quickdraw | Two carabiners joined by a short sling, clipped to a bolt and the rope on sport routes. | "She grabbed fifteen draws." | `roped-world` |
| `bolt` | Bolt | A permanent anchor drilled into rock for sport routes. | "There's a bolt every few feet." | `roped-world` |
| `anchor` | Anchor | The point at the top of a route where climbers clip in to lower or rappel. | "Clip the anchor and lower off." | `roped-world` |
| `rack` | Rack | A trad climber's collection of removable protection. | "She's racking up for the route." | `roped-world` |
| `cam` | Cam (SLCD) | A spring-loaded camming device that expands in a crack. | "She placed a cam in the crack." | `roped-world` |
| `nut` | Nut (chock) | A metal wedge placed in a crack for trad protection. | "Nuts are old school and brilliant." | `roped-world` |
| `rope` | Dynamic rope | A stretchy climbing rope that absorbs fall energy. | "Dynamic ropes stretch. That's on purpose." | `roped-world` |
| `clipping` | Clipping | Attaching the rope to protection as a leader moves up. | "She clipped and kept going." | `roped-world` |
| `lowering` | Lowering | Coming down a route on the rope after a climb. | "She lowered off and we high-fived." | `roped-world` |
| `rappel` | Rappel | Descending a rope with a device; a skill with serious consequences that requires hands-on training. | "We rappelled from the top." | `roped-world` |
| `belay-device` | Belay device | A friction tool that lets a belayer hold and feed rope. | "He has a new belay device." | `roped-world` |
| `access-fund` | Access Fund | A U.S. nonprofit that keeps climbing areas open and protects them through advocacy and stewardship. | "I donate to Access Fund every year." | `outdoor-ethics` |
| `leave-no-trace` | Leave No Trace for climbers | Seven principles adapted for crags: plan ahead, durable surfaces, pack out waste, leave what you find, etc. | "Pack out your tape and your trash." | `outdoor-ethics` |
| `crag-etiquette` | Crag etiquette | Shared manners at outdoor climbing areas: keep noise down, share routes, don't hog anchors. | "Don't blast music at the crag." | `outdoor-ethics` |
| `fixed-anchors` | Fixed anchors | Bolts and hardware installed in rock; their care and placement are community decisions. | "The fixed anchors were replaced last season." | `outdoor-ethics` |
| `bolting-ethics` | Bolting ethics | Debates over when, where and how to place bolts in natural rock. | "The bolting debate is a whole thing." | `outdoor-ethics` |
| `seasonal-closure` | Seasonal closure | Areas closed to protect nesting birds or sensitive habitat; always obey them. | "The cliff is closed for peregrine nesting." | `outdoor-ethics` |
| `chipping` | Chipping | Altering natural rock to create holds; widely condemned. | "Chipping is a crime against the crag." | `outdoor-ethics` |
| `tick-marks` | Tick marks | Chalk marks left on rock to mark holds; many areas discourage or clean them. | "Brush your tick marks when you're done." | `outdoor-ethics` |
| `human-waste` | Human waste | Packing out or burying waste as land managers require; a key part of access. | "Pack out your waste. The area is fragile." | `outdoor-ethics` |
| `access-loss` | Access loss | When a crag closes due to conflict, damage or land-owner concerns. | "They lost access to that crag because of trash." | `outdoor-ethics` |
| `local-climbing-coalition` | Local climbing coalition | A local group that stewards an area, organizes cleanups and works with land managers. | "I volunteer with the local coalition." | `outdoor-ethics` |
| `cultural-sites` | Cultural and sacred sites | Some climbing areas are sacred to Indigenous peoples; voluntary closures or restrictions respect that. | "Some areas ask climbers to stay off for cultural reasons." | `outdoor-ethics` |
| `yosemite` | Yosemite | California valley famous for granite walls like El Capitan and Half Dome and for climbing history. | "Yosemite is the cathedral of climbing." | `crags-and-places` |
| `el-capitan` | El Capitan | A roughly 3,000-foot granite wall in Yosemite, site of the Nose, Dawn Wall and Honnold's free solo. | "El Cap is the big one." | `crags-and-places` |
| `fontainebleau` | Fontainebleau | Forest near Paris with sandstone boulders, color-coded circuits and the origin of the Font scale. | "Fontainebleau is the birthplace of bouldering." | `crags-and-places` |
| `red-river-gorge` | Red River Gorge | Kentucky sandstone cliffs famous for steep sport routes. | "We're going to the Red this fall." | `crags-and-places` |
| `hueco-tanks` | Hueco Tanks | Texas state park and the birthplace of the V-scale; access is managed and limited. | "Hueco is magical. You need a reservation." | `crags-and-places` |
| `joshua-tree` | Joshua Tree | California desert granite famous for trad and bouldering. | "Joshua Tree is cozy. Desert sunsets and cracks." | `crags-and-places` |
| `smith-rock` | Smith Rock | Oregon crag often called the birthplace of American sport climbing. | "Smith Rock's where it all changed in the eighties." | `crags-and-places` |
| `indian-creek` | Indian Creek | Utah desert famous for parallel crack climbing. | "Indian Creek's all cracks. Bring tape." | `crags-and-places` |
| `kalymnos` | Kalymnos | Greek island with limestone sport routes and a cheerful climbing tourism scene. | "Kalymnos is sport-climbing heaven." | `crags-and-places` |
| `bishop` | Bishop | California area with the Buttermilks, famous for granite bouldering. | "Bishop has great boulders." | `crags-and-places` |
| `squamish` | Squamish | British Columbia granite town famous for trad and bouldering. | "Squamish is my favorite." | `crags-and-places` |
| `rocklands` | Rocklands | South African sandstone bouldering destination. | "Rocklands has amazing boulders." | `crags-and-places` |
| `flatanger` | Flatanger | Norwegian cave where Adam Ondra climbed Silence. | "Flatanger is massive." | `crags-and-places` |
| `chamonix` | Chamonix | French Alpine town, hub of alpinism and big mountain climbing. | "Chamonix is for alpine lovers." | `crags-and-places` |
| `john-gill` | John Gill | American pioneer who shaped modern bouldering, popularized chalk and treated bouldering as a sport in itself. | "John Gill basically invented modern bouldering." | `legends-and-lines` |
| `the-nose` | The Nose and Lynn Hill | The classic El Capitan route; Lynn Hill made its first free ascent in 1993. | "Lynn Hill freed the Nose. Still wild." | `legends-and-lines` |
| `dawn-wall` | The Dawn Wall | Tommy Caldwell and Kevin Jorgeson's 2015 free ascent of a very hard El Capitan route over 19 days. | "The Dawn Wall took them almost three weeks." | `legends-and-lines` |
| `free-solo-film` | Free Solo (film) | The Oscar-winning documentary about Alex Honnold's rope-free ascent of El Capitan in 2017. | "The film Free Solo is hard to watch." | `legends-and-lines` |
| `alex-honnold` | Alex Honnold | American climber famous for free soloing; in January 2026 he climbed Taipei 101 without ropes in a live broadcast. | "Honnold's Taipei climb was on Netflix." | `legends-and-lines` |
| `silence-9c` | Silence (9c) | Adam Ondra's 2017 route in Flatanger, Norway, the first graded 9c. | "Silence was the first 9c." | `legends-and-lines` |
| `burden-of-dreams` | Burden of Dreams | Nalle Hukkataival's 2016 boulder problem in Finland, graded V17 (9A), the hardest confirmed repeated problem. | "Burden of Dreams is V17." | `legends-and-lines` |
| `janja-garnbret` | Janja Garnbret | Slovenian competition star and Olympic champion in Tokyo and Paris; one of the sport's most dominant. | "Janja is unreal." | `legends-and-lines` |
| `ashima-shiraishi` | Ashima Shiraishi | American prodigy who climbed V15 as a teenager. | "Ashima started so young." | `legends-and-lines` |
| `margo-hayes` | Margo Hayes | American climber who in 2017 was the first woman to climb 5.14d (9a+) with La Rambla. | "Margo Hayes did La Rambla." | `legends-and-lines` |
| `adam-ondra` | Adam Ondra | Czech climber who climbs at the top level in bouldering, sport and competition. | "Ondra can do everything." | `legends-and-lines` |
| `chris-sharma` | Chris Sharma | American sport climber known for pushing limits, including Realization at Ceüse and Jumbo Love. | "Sharma made sport climbing feel like art." | `legends-and-lines` |
| `ifsc` | IFSC | The International Federation of Sport Climbing, which runs the World Cup and World Championships. | "IFSC runs the World Cup." | `competition-climbing` |
| `olympic-climbing` | Olympic climbing | Climbing debuted at Tokyo 2020; Paris 2024 combined boulder and lead with speed separate; LA28 will have three separate medal events: boulder, lead and speed. | "Olympic climbing is finally three medals." | `competition-climbing` |
| `boulder-format` | Boulder competition | Climbers attempt several problems in limited time, scored by tops, zones and attempts. | "Boulder finals are like sprints." | `competition-climbing` |
| `lead-format` | Lead competition | Climbers climb a route as high as possible within a time limit; the highest hold wins. | "Lead is endurance." | `competition-climbing` |
| `speed-format` | Speed climbing | Head-to-head on an identical 15-meter wall; the fastest time wins. | "Speed is a sprint." | `competition-climbing` |
| `tops-and-zones` | Tops and zones | Boulder scoring: a top is finishing a problem, a zone is reaching a marked mid-hold; fewer attempts break ties. | "She topped all four." | `competition-climbing` |
| `world-cup-circuit` | World Cup circuit | A season of IFSC events across the world, ending in a ranking. | "The World Cup season runs through the summer." | `competition-climbing` |
| `para-climbing` | Para climbing | Climbing categories for athletes with physical or visual impairments. | "Para climbing has amazing athletes." | `competition-climbing` |
| `youth-comp` | Youth and national comps | Junior and national events that feed into the elite circuit. | "She's on the youth team." | `competition-climbing` |
| `grade-inflation` | Grade inflation | Complaints that grades on popular routes drift softer over time. | "That grade's inflated." | `debates-and-culture` |
| `gym-vs-outdoor` | Gym vs outdoor | An ongoing debate: is gym climbing real climbing? Most enthusiasts say both count, but they're different skills. | "Gym people can be good outdoors too." | `debates-and-culture` |
| `bolt-debate` | Bolt debate | Whether bolting routes should be allowed and where. | "Bolting routes is controversial." | `debates-and-culture` |
| `training-culture` | Training culture | Hangboards, campus boards and structured plans; popular and injury-prone. | "She follows a training plan." | `debates-and-culture` |
| `free-solo-debate` | Free solo debate | Is free soloing inspiring or irresponsible? Many climbers admire the skill and never imitate it. | "I admire it. I'd never do it." | `debates-and-culture` |
| `fear-of-falling` | Fear of falling | A core mental challenge; climbers train it with instructors in controlled settings. | "She works on her fear of falling." | `debates-and-culture` |
| `adaptive-climbing` | Adaptive climbing | Climbing adapted for different abilities, from gyms to para competitions. | "Adaptive programs are growing." | `debates-and-culture` |
| `sit-start` | Sit start | Starting a boulder problem from a seated position. | "It's a sit start." | `branch-bouldering` |
| `highball` | Highball | A tall boulder problem where a fall is serious; approached with great caution and experience. | "That highball is scary." | `branch-bouldering` |
| `problem-circuit` | Circuit | A set of boulder problems to climb in order, common at Fontainebleau. | "We did the orange circuit." | `branch-bouldering` |
| `boulder-spotting` | Spotters and pads | Bouldering partners use spotters and several pads together; skills learned from experienced people. | "We brought pads and a spotter." | `branch-bouldering` |
| `hangdog` | Hangdogging | Resting on the rope mid-route while working it. | "Hangdogging is how you learn." | `branch-sport-climbing` |
| `sport-redpoint-culture` | Redpoint culture | Sport climbers often spend days or seasons on a single route until they send it. | "She's been on it for weeks." | `branch-sport-climbing` |
| `british-grades` | British E-grades | The UK trad system that describes overall difficulty and danger, like E4 6a. | "It's E4 6a." | `branch-trad-big-wall` |
| `ground-up-ethic` | Ground-up ethic | A tradition of establishing routes from the ground up, without pre-inspecting from above. | "They did it ground-up." | `branch-trad-big-wall` |
| `portaledge` | Portaledge | A hanging tent used on multi-day big walls. | "They slept on a portaledge." | `branch-trad-big-wall` |
| `offwidth` | Offwidth | A crack too wide for fists and too narrow for the body; infamous for being awkward and tiring. | "Offwidths are brutal." | `branch-trad-big-wall` |
| `crag-season` | Crag season | The best weather window for an area, like fall at the Red or winter in the desert. | "The season is starting." | `current-season` |
| `conditions-friction` | Friction conditions | Cool, dry weather makes rock grippy; heat and humidity make it slippery. | "It's too humid for friction." | `current-season` |
| `comp-calendar` | Comp calendar | The schedule of IFSC and national events. | "The next World Cup is next week." | `current-season` |
| `beta-sources` | Beta sources | Apps and sites with route info like Mountain Project or theCrag; information is user-written and can be wrong. | "I checked the route online." | `current-season` |
| `ask-about-project` | Asking about a project | A great conversation opener: ask what her project is, what the crux is, and what she's learned. | "What's your project right now?" | `talk-the-wall` |
