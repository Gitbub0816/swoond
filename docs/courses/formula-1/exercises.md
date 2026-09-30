# Native Exercise Plan: Formula 1 (`formula-1`)

Tier B exercise plan for the F1 course (`docs/courses/formula-1/CDS.md` section 12). Payloads conform to `docs/contracts/native-exercises/v1/<type>.schema.json`; every JSON block below is tagged with an HTML comment naming its type and is validated by the check documented in the last section. Type behaviour, scoring and accessibility follow `docs/native-exercises/CATALOG.md`.

## 0. Plan at a glance

| Type | Est. items at launch | Where it does the most work in this course |
|---|---|---|
| `multiple-choice` | 211 | Default check for every foundation and intermediate lesson; review cards |
| `say-this` | 87 | Decoding fan lines, enthusiast and current-season units |
| `binary-call` | 51 | Rules in a situation: VSC or SC, track limits, tow, Overtake Mode |
| `decision-scenario` | 35 | Strategy and stewarding judgment (pit, weather, defending) |
| `talk-track` | 31 in lessons + 30 standalone | Every layer; Talk tab |
| `term-match` | 29 | Introducing 3 to 6 terms per lesson |
| `fill-the-gap` | 14 | Terms in context; review |
| `estimate-slider` | 14 | Magnitudes (305 km, 768 kg, 2 s stops, 25 points) |
| `hotspot-tap` | 9 | Car anatomy, circuit maps, understeer/oversteer, next-circuit primer |
| `visual-id` | 7 | Flags, tyre sidewalls (original procedural art) |
| `sequence-order` | 6 | Race weekend, pit stop steps, safety-car sequence |
| `timing-tap` | 2 | Pit stop and lights-out reaction (D-002: 1D bar stays native) |
| `listening-id` | 0 | Not used: race and radio audio is not licensable (CDS section 5) |

Conventions used in all samples: prompts are 12 words or fewer; every answer is explained, right and wrong; a "say this" line appears where natural; lines in quotation are in the fan's voice; no logos or driver photos; image assets are original procedural art with licence id `swoond-original`; diagram ids are the procedural keys listed in CDS section 14.

---

## 1. multiple-choice

**How it is used here:** the default check after every teaching card, and the review card in `perpetual-review`. Wrong options are written from real misconceptions (CDS section 2), so the feedback teaches. Multi-select is used sparingly (2026 power unit facts).

<!-- type: multiple-choice -->
```json
{
  "prompt": "How many points does a Grand Prix win score?",
  "options": [
    { "id": "a", "text": "25", "explanation": "Winner gets 25, then 18, 15, 12, 10, 8, 6, 4, 2, 1 down to tenth." },
    { "id": "b", "text": "20", "explanation": "Not since 2010. The current scale starts at 25." },
    { "id": "c", "text": "15", "explanation": "That is third place." },
    { "id": "d", "text": "10", "explanation": "That is fifth place." }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "A win is 25 points. Second gets 18 and third 15. There is no bonus point for the fastest lap since 2025.",
    "incorrect": "The scale is 25, 18, 15, 12, 10, 8, 6, 4, 2, 1 for the top ten. A win is worth 25, so one retirement can cost a title.",
    "sayThisLine": "A win is 25 points, so a DNF really hurts."
  }
}
```

<!-- type: multiple-choice -->
```json
{
  "prompt": "What replaced DRS in 2026?",
  "options": [
    { "id": "a", "text": "Active aero plus Overtake Mode", "explanation": "Movable wings for everyone, and an electrical boost when within a second." },
    { "id": "b", "text": "A bigger rear wing flap only", "explanation": "That was DRS itself, and it was retired." },
    { "id": "c", "text": "Nothing at all", "explanation": "Overtaking help did not vanish; it changed shape." },
    { "id": "d", "text": "A fuel-flow boost button", "explanation": "There is a Boost button, but for electrical energy, not fuel." }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "The old flap that only helped the chaser is gone. Every car now has active aero (Straight Mode and Corner Mode), and a chasing car within one second gets Overtake Mode.",
    "incorrect": "DRS was retired after 2025. 2026 cars use active aero on both wings, plus Overtake Mode, an extra electrical boost for a car within one second of the car ahead.",
    "sayThisLine": "DRS is gone. It is Overtake Mode now."
  }
}
```

<!-- type: multiple-choice -->
```json
{
  "prompt": "Why does a car struggle in the dirty air behind another?",
  "options": [
    { "id": "a", "text": "Turbulent air cuts its downforce", "explanation": "Less grip, especially at the front, so the tyres overheat and slide." },
    { "id": "b", "text": "Its engine gets less air", "explanation": "Engines are fine; the wings lose the clean air they need." },
    { "id": "c", "text": "Its brakes get too hot", "explanation": "Brakes have their own cooling; the issue is aerodynamic." },
    { "id": "d", "text": "The driver cannot see", "explanation": "Visibility matters in the wet, but this is about grip." }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "The car ahead leaves turbulent, messy air. The follower's wings work worse in it, downforce drops, and the tyres slide and overheat. That is why following closely is hard.",
    "incorrect": "It is about downforce. The wings need clean air; behind another car it is turbulent, so grip falls and the tyres cook.",
    "sayThisLine": "He was stuck in the dirty air."
  }
}
```

<!-- type: multiple-choice -->
```json
{
  "prompt": "Which are true of the 2026 power unit?",
  "options": [
    { "id": "a", "text": "It has no MGU-H", "explanation": "The heat-recovery motor was removed." },
    { "id": "b", "text": "It runs on 100% sustainable fuel", "explanation": "Advanced sustainable fuel, not fossil petrol." },
    { "id": "c", "text": "It is purely electric", "explanation": "It is a 1.6 litre turbo V6 plus a big electric motor." },
    { "id": "d", "text": "It is a V8", "explanation": "Still a V6 turbo." }
  ],
  "correctOptionIds": ["a", "b"],
  "allowMultiple": true,
  "explanation": {
    "correct": "Right on both. No MGU-H, and the fuel is 100% advanced sustainable. It is a V6 turbo plus a much stronger MGU-K, split roughly 50/50 with the engine.",
    "incorrect": "The 2026 unit is a 1.6 litre V6 turbo plus an electric motor, split about 50/50. The MGU-H is gone, and the fuel is 100% advanced sustainable.",
    "sayThisLine": "It is a power unit, not just an engine."
  }
}
```

---

## 2. say-this

**How it is used here:** the core social skill. Each item is a fan line in the crush's voice; the learner multi-selects what it implies, then sees a plain-English translation and one to three follow-up questions that show real interest. Every item in the enthusiast and current-season layers fills `noFakeExpertNote`. Statements never use real quotes; they are original lines.

<!-- type: say-this -->
```json
{
  "statement": { "speaker": "Sarah", "text": "They undercut him and he never got it back." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "The rival pitted first and jumped ahead", "isCorrect": true, "explanation": "That is the definition of an undercut." },
    { "id": "b", "text": "Fresh tyres were quicker for a few laps", "isCorrect": true, "explanation": "Fresh tyres are what make the move work." },
    { "id": "c", "text": "He was penalised for going under the limit", "isCorrect": false, "explanation": "Undercut is a strategy term, not a penalty." },
    { "id": "d", "text": "His engine failed", "isCorrect": false, "explanation": "No mechanical failure is mentioned." }
  ],
  "translation": "A rival stopped for tyres first, went quickly on fresh rubber, and was ahead when he stopped a lap or two later.",
  "followUps": [
    { "line": "Was he stuck in traffic after his stop?", "why": "Shows you know a stop can drop you into slower cars." },
    { "line": "Should he have pitted the lap before?", "why": "Asks about the pit window without pretending to know the answer." }
  ],
  "noFakeExpertNote": "Ask what she thinks the team should have done; do not tell her."
}
```

<!-- type: say-this -->
```json
{
  "statement": { "speaker": "Sarah", "text": "He clipped at the end of the straight and got passed." },
  "question": "What does she mean?",
  "options": [
    { "id": "a", "text": "The battery ran out of assist", "isCorrect": true, "explanation": "Clipping is when the car stops getting electrical help." },
    { "id": "b", "text": "The car slowed at the end of the straight", "isCorrect": true, "explanation": "It stops accelerating and can even lose speed." },
    { "id": "c", "text": "He hit a kerb", "isCorrect": false, "explanation": "Clipping a kerb is a different meaning; here it is the battery." },
    { "id": "d", "text": "He was penalised", "isCorrect": false, "explanation": "No penalty is implied." }
  ],
  "translation": "He ran out of electrical energy on the straight, so the car stopped pulling and the car behind went by.",
  "followUps": [
    { "line": "Did he deploy too early in the lap?", "why": "Shows you understand it is about where the energy was spent." },
    { "line": "Was that the battery or the engine?", "why": "Checks understanding of the two halves of the power unit." }
  ],
  "noFakeExpertNote": "If you are unsure, ask what clipping looks like on the timing screen."
}
```

<!-- type: say-this -->
```json
{
  "statement": { "speaker": "Sarah", "text": "Safety car came out right after he pitted. Worst luck." },
  "question": "Why is that unlucky?",
  "options": [
    { "id": "a", "text": "He paid the full pit loss just before it got cheap", "isCorrect": true, "explanation": "Under the safety car a stop costs about half." },
    { "id": "b", "text": "Rivals stopped cheaply and jumped him", "isCorrect": true, "explanation": "Cars that pit later under the safety car lose less." },
    { "id": "c", "text": "The safety car hit his car", "isCorrect": false, "explanation": "It is a pace car, not a hazard to drivers." },
    { "id": "d", "text": "He was disqualified", "isCorrect": false, "explanation": "Nothing suggests a penalty." }
  ],
  "translation": "He took a full-price pit stop moments before a safety car made stops cheap, so everyone else gained on him.",
  "followUps": [
    { "line": "Do teams ever gamble on that?", "why": "Invites her opinion on strategy risk." },
    { "line": "How much cheaper is it under the safety car?", "why": "A genuine question about pit loss." }
  ]
}
```

<!-- type: say-this -->
```json
{
  "statement": { "speaker": "Sarah", "text": "Straight mode on the back straight and boom, gone." },
  "question": "What is she describing?",
  "options": [
    { "id": "a", "text": "The wings opened for less drag", "isCorrect": true, "explanation": "Straight Mode is the low-drag setting." },
    { "id": "b", "text": "The car pulled away on the straight", "isCorrect": true, "explanation": "Less drag means more speed." },
    { "id": "c", "text": "Only the chasing car can use it", "isCorrect": false, "explanation": "DRS was chaser only; Straight Mode is for everyone." },
    { "id": "d", "text": "The car went into the pits", "isCorrect": false, "explanation": "Nothing about a stop." }
  ],
  "translation": "The car opened its wings on a straight for lower drag and pulled away.",
  "followUps": [
    { "line": "Do they have to close them before the corner?", "why": "Shows you know grip returns when the wings close." }
  ],
  "noFakeExpertNote": "Do not tell her it is like DRS; ask how it differs from the old DRS days."
}
```

---

## 3. binary-call

**How it is used here:** a clear two-way rule in a situation, drawn on procedural diagrams (`diagramId`). Scene kind `field-diagram` is used for track situations, `none` for pure recall. Markers: `player` is the learner's car, `opponent` the rival, `target` the braking marker or line.

<!-- type: binary-call -->
```json
{
  "prompt": "Gaps frozen, no pace car on track. Which is it?",
  "scene": { "kind": "none", "alt": "No diagram. Text only: the field is slowed to a set delta, gaps are preserved, no pace car is on track." },
  "choices": [
    { "id": "vsc", "label": "Virtual Safety Car" },
    { "id": "sc", "label": "Full safety car" }
  ],
  "correctChoiceId": "vsc",
  "explanation": {
    "correct": "Under a VSC everyone slows to a set delta and the gaps stay frozen. A full safety car brings a physical pace car that bunches the field.",
    "incorrect": "A full safety car has a pace car that bunches the field and erases gaps. Frozen gaps with no pace car is the Virtual Safety Car.",
    "sayThisLine": "Under the VSC the gaps stay the same."
  },
  "ruleTag": "Neutralisations"
}
```

<!-- type: binary-call -->
```json
{
  "prompt": "All four wheels beyond the white line. Track-limits breach?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "f1-track-limits",
    "markers": [ { "role": "player", "x": 0.82, "y": 0.5 } ],
    "alt": "Top-down view of a corner exit. The car is entirely outside the white line on the outside edge."
  },
  "choices": [
    { "id": "yes", "label": "Yes, a breach" },
    { "id": "no", "label": "No, still legal" }
  ],
  "correctChoiceId": "yes",
  "explanation": {
    "correct": "The rule: at least part of a tyre must stay on or touch the white line. All four wheels beyond it counts as leaving the track, and the lap time can be deleted.",
    "incorrect": "All four wheels beyond the white line is a breach. If any part of a tyre touches the line, the car is still on the track.",
    "sayThisLine": "His lap got deleted for track limits."
  },
  "ruleTag": "Track limits"
}
```

<!-- type: binary-call -->
```json
{
  "prompt": "400 metres to the braking point. Pull out of the tow now?",
  "scene": {
    "kind": "field-diagram",
    "diagramId": "f1-straight-braking",
    "markers": [
      { "role": "player", "x": 0.5, "y": 0.72 },
      { "role": "opponent", "x": 0.5, "y": 0.62 },
      { "role": "target", "x": 0.5, "y": 0.1 }
    ],
    "alt": "Straight road seen from above. Your car is a car length behind the leader. The braking marker is far ahead at the top."
  },
  "choices": [
    { "id": "stay", "label": "Stay in the tow" },
    { "id": "pull", "label": "Pull out now" }
  ],
  "correctChoiceId": "stay",
  "explanation": {
    "correct": "Leaving the tow early throws away the free speed and lets the leader cover. Pull out late, just early enough to be alongside before the braking point.",
    "incorrect": "Pulling out this early loses the slipstream and gives the leader time to cover. Stay tucked in and go late.",
    "sayThisLine": "He got out of the tow too soon."
  },
  "ruleTag": "Slipstream timing"
}
```

<!-- type: binary-call -->
```json
{
  "prompt": "Chasing car is 1.4 seconds back at the detection line. Overtake Mode?",
  "scene": { "kind": "none", "alt": "No diagram. Text only: the chasing car is 1.4 seconds behind at the detection line." },
  "choices": [
    { "id": "yes", "label": "Yes, available" },
    { "id": "no", "label": "No, not available" }
  ],
  "correctChoiceId": "no",
  "explanation": {
    "correct": "Overtake Mode needs the chaser to be within one second at the detection point. At 1.4 seconds it is not available.",
    "incorrect": "The rule is one second or less at the detection line. At 1.4 seconds it is not available, so the chaser must close the gap first.",
    "sayThisLine": "He wasn't inside a second, so no Overtake Mode."
  },
  "ruleTag": "Overtake Mode"
}
```

---

## 4. term-match

**How it is used here:** introducing three to six terms of one topic per lesson (flags, tyre wear, power-unit parts, strategy words). Distractor definitions are used when a term has a look-alike.

<!-- type: term-match -->
```json
{
  "prompt": "Match each flag to its meaning.",
  "pairs": [
    { "id": "yellow", "term": "Yellow flag", "definition": "Danger ahead: slow down, no overtaking" },
    { "id": "blue", "term": "Blue flag", "definition": "Let the faster car through" },
    { "id": "red", "term": "Red flag", "definition": "Session stopped: return to the pits" },
    { "id": "chequered", "term": "Chequered flag", "definition": "The race is over for that driver" }
  ],
  "distractorDefinitions": [ "Refuel now", "Track is wet" ],
  "explanation": {
    "summary": "Yellow means take care, blue means make way, red means everything stops, chequered means finished. The black flag is the disqualification flag.",
    "sayThisLine": "He ignored the blue flags and got a penalty."
  }
}
```

<!-- type: term-match -->
```json
{
  "prompt": "Match each tyre problem to what it means.",
  "pairs": [
    { "id": "deg", "term": "Degradation", "definition": "Grip and lap time fall gradually as tyres age" },
    { "id": "graining", "term": "Graining", "definition": "Tiny rubber balls tear off and roughen the surface" },
    { "id": "blister", "term": "Blistering", "definition": "Overheated rubber bubbles and is damaged for good" },
    { "id": "cliff", "term": "Tyre cliff", "definition": "Grip suddenly collapses near the end of life" }
  ],
  "explanation": {
    "summary": "Degradation is the slow fade, graining and blistering are two kinds of surface damage, and the cliff is the sudden drop. Teams plan stops around all four.",
    "sayThisLine": "The front tyres are graining, so his pace has dropped."
  }
}
```

<!-- type: term-match -->
```json
{
  "prompt": "Match each 2026 power unit part.",
  "pairs": [
    { "id": "ice", "term": "ICE", "definition": "1.6 litre turbo V6, about 400 kW" },
    { "id": "mguk", "term": "MGU-K", "definition": "Motor-generator: recovers braking energy, deploys up to 350 kW" },
    { "id": "es", "term": "Energy store", "definition": "The battery that holds harvested energy" },
    { "id": "mguh", "term": "MGU-H", "definition": "Removed for 2026: recovered heat from the turbo" }
  ],
  "explanation": {
    "summary": "Engine plus a much stronger electric side, roughly 50/50 in 2026. The MGU-H is gone, so the turbo reacts more like it did in the 1980s.",
    "sayThisLine": "The combustion engine does about half now."
  }
}
```

<!-- type: term-match -->
```json
{
  "prompt": "Match each strategy word.",
  "pairs": [
    { "id": "undercut", "term": "Undercut", "definition": "Pit first and use fresh tyres to jump ahead" },
    { "id": "overcut", "term": "Overcut", "definition": "Stay out longer and use clear air to gain" },
    { "id": "stint", "term": "Stint", "definition": "A run of laps on one set of tyres" },
    { "id": "double", "term": "Double stack", "definition": "Both team cars pit on consecutive laps" },
    { "id": "window", "term": "Pit window", "definition": "The range of laps where a stop makes sense" }
  ],
  "explanation": {
    "summary": "Undercut and overcut are opposite bets on the same stop. A stint is what a stop ends, and a window is when it is sensible.",
    "sayThisLine": "They are a lap or two from the pit window."
  }
}
```

---

## 5. sequence-order

**How it is used here:** the race weekend flow, the pit stop, the safety-car sequence and the logic chain of an undercut. Items are authored in the correct order; the app shuffles.

<!-- type: sequence-order -->
```json
{
  "prompt": "Put a race weekend in order.",
  "items": [
    { "id": "fp", "text": "Free practice", "why": "Teams learn the track and test set-ups and tyres." },
    { "id": "quali", "text": "Qualifying (Q1, Q2, Q3)", "why": "Fastest single laps set the grid." },
    { "id": "parc", "text": "Parc ferme rules apply", "why": "Set-ups are locked once qualifying starts." },
    { "id": "form", "text": "Formation lap", "why": "Drivers warm tyres and brakes before lining up." },
    { "id": "start", "text": "Lights out", "why": "The race begins from a standing start." },
    { "id": "flag", "text": "Chequered flag", "why": "The race ends." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Practice first, then qualifying (with the set-up lock), then the formation lap and the start, and finally the flag. Sprint weekends compress this.",
    "incorrect": "Start with practice, then qualifying (with parc ferme), then formation lap, lights out and the chequered flag.",
    "sayThisLine": "I plan my whole weekend around the race weekend."
  }
}
```

<!-- type: sequence-order -->
```json
{
  "prompt": "Put a pit stop in order.",
  "items": [
    { "id": "enter", "text": "Enter the pit lane at the speed limit", "why": "Speeding in the pit lane earns a penalty." },
    { "id": "stop", "text": "Stop in the box", "why": "Every tenth counts from here." },
    { "id": "jack", "text": "Raise the car and change four wheels", "why": "Four wheel guns work at once." },
    { "id": "drop", "text": "Drop the car and check it is clear", "why": "Unsafe releases are penalised." },
    { "id": "go", "text": "Release and rejoin", "why": "The car leaves under the speed limit until the exit." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Enter slowly, stop, change wheels, drop, release. A top crew is stationary for about two seconds.",
    "incorrect": "Slow entry, stop, four wheels, drop and release. Two seconds stationary is a world-class stop.",
    "sayThisLine": "Two-second stops, unbelievable."
  }
}
```

<!-- type: sequence-order -->
```json
{
  "prompt": "Put the safety-car sequence in order.",
  "items": [
    { "id": "incident", "text": "An incident on track", "why": "Crash or debris starts it." },
    { "id": "deploy", "text": "Race director deploys the safety car", "why": "The message goes to all teams." },
    { "id": "bunch", "text": "The field bunches behind it", "why": "Gaps shrink to a few car lengths." },
    { "id": "pit", "text": "Some cars take a cheap stop", "why": "The stop costs about half." },
    { "id": "restart", "text": "It comes in and the race restarts", "why": "The leader controls the pace to the line." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Incident, deployment, bunching, cheap stops, restart. That bunching is why the safety car reshuffles races.",
    "incorrect": "It starts with an incident, then the race director deploys the car, the field bunches, some cars pit cheaply, and the race restarts.",
    "sayThisLine": "The safety car ruined his ten-second lead."
  }
}
```

---

## 6. visual-id

**How it is used here:** flags and tyre sidewalls. All artwork is original procedural art (`swoond-original`); there are no press photos or team imagery (CDS section 13).

<!-- type: visual-id -->
```json
{
  "prompt": "What does this flag mean?",
  "image": {
    "asset": "images/f1/flag-yellow.svg",
    "alt": "A plain yellow rectangular flag.",
    "license": "swoond-original"
  },
  "options": [
    { "id": "danger", "text": "Danger ahead: slow, no overtaking", "explanation": "Yellow means take care. Double yellow means be ready to stop." },
    { "id": "faster", "text": "Let a faster car through", "explanation": "That is the blue flag." },
    { "id": "stop", "text": "Session stopped", "explanation": "That is the red flag." },
    { "id": "dq", "text": "You are disqualified", "explanation": "That is the black flag." }
  ],
  "correctOptionId": "danger",
  "explanation": {
    "correct": "Yellow flags mark danger ahead in that sector. Drivers must slow and cannot overtake there.",
    "incorrect": "A yellow flag warns of danger ahead. Blue is for lapped cars, red stops the session and black disqualifies.",
    "sayThisLine": "Yellow in sector two, so he had to lift."
  },
  "cues": [ "Plain yellow", "Danger in the marked sector", "Double yellow: be ready to stop" ]
}
```

<!-- type: visual-id -->
```json
{
  "prompt": "Which tyre is the Medium?",
  "image": {
    "asset": "images/f1/tyre-sidewalls.svg",
    "alt": "Three tyre sidewalls in a row: one with a white band, one with a yellow band, one with a red band.",
    "license": "swoond-original"
  },
  "options": [
    { "id": "white", "text": "White band", "explanation": "White is the Hard: durable but slower per lap." },
    { "id": "yellow", "text": "Yellow band", "explanation": "Yellow is the Medium: a balance of grip and life." },
    { "id": "red", "text": "Red band", "explanation": "Red is the Soft: fastest per lap, shortest life." }
  ],
  "correctOptionId": "yellow",
  "explanation": {
    "correct": "Yellow is the Medium. Hard is white and Soft is red. The labels are relative at each race, so a Medium at one track may be a different compound at another.",
    "incorrect": "White band is Hard, yellow is Medium and red is Soft. Wets use green (intermediate) and blue (full wet).",
    "sayThisLine": "Reds are fast but die quickly."
  },
  "cues": [ "White = Hard", "Yellow = Medium", "Red = Soft" ]
}
```

<!-- type: visual-id -->
```json
{
  "prompt": "Which tyre is for heavy rain?",
  "image": {
    "asset": "images/f1/tyre-wets.svg",
    "alt": "Two tyres side by side: one with a green sidewall band and one with a blue sidewall band.",
    "license": "swoond-original"
  },
  "options": [
    { "id": "green", "text": "Green band", "explanation": "Intermediate: for a damp or drying track." },
    { "id": "blue", "text": "Blue band", "explanation": "Full wet: for heavy rain and standing water." }
  ],
  "correctOptionId": "blue",
  "explanation": {
    "correct": "Blue is the full wet, made to clear lots of water. Green is the intermediate, for a track that is wet but not soaked.",
    "incorrect": "Blue is the full wet for heavy rain. Green is the intermediate, for damp or drying conditions.",
    "sayThisLine": "It is drying, so inters are coming off soon."
  },
  "cues": [ "Green = inter", "Blue = full wet" ]
}
```

---

## 7. decision-scenario

**How it is used here:** strategy and stewarding judgment from a fact sheet, graded best / acceptable / poor with an expert note. It teaches the same call as the Unity sims in simpler cases (`sd-03`, `sd-06`, `sd-07`, `fc-05`, `rc-04`). F1 is not safety-critical for learners, so `safetyNote` is omitted.

<!-- type: decision-scenario -->
```json
{
  "prompt": "Rival is 1.6 seconds ahead and your tyres are old. What now?",
  "situation": {
    "narrative": "Lap 20 of 50. You are on Mediums; the rival ahead is on the same age.",
    "facts": [
      { "label": "Gap to car ahead", "value": "1.6 s" },
      { "label": "Your tyres", "value": "Medium, 20 laps old" },
      { "label": "Rival's tyres", "value": "Medium, 20 laps old" },
      { "label": "Pit loss", "value": "About 21 s" },
      { "label": "Tyre cliff", "value": "Near lap 22", "emphasis": "warning" }
    ]
  },
  "options": [
    {
      "id": "pit-now", "label": "Pit now for Hards", "verdict": "best",
      "consequence": "Fresh tyres give you quick laps. When the rival stops a few laps later you come out ahead.",
      "considerations": [ "Undercut needs a small gap", "Your tyres are near the cliff", "Track position is hard to win back" ]
    },
    {
      "id": "same-lap", "label": "Wait and pit when the rival pits", "verdict": "acceptable",
      "consequence": "You stay behind after both stops; nothing is gained, but nothing is lost either.",
      "considerations": [ "Safe but passive", "Rival may cover on the way" ]
    },
    {
      "id": "stay-out", "label": "Stay out as long as possible", "verdict": "poor",
      "consequence": "The tyres fall off the cliff, laps get slower, and the rival stops and jumps you.",
      "considerations": [ "Old tyres cost seconds per lap", "The window closes" ]
    }
  ],
  "expertNote": "With a small gap and tyres near the cliff, strategists ask: what does the fresh set buy me, and can I be sure of clear air? A small gap and worn tyres point to the undercut.",
  "sayThisLine": "They went for the undercut and it worked."
}
```

<!-- type: decision-scenario -->
```json
{
  "prompt": "The track is drying. When do you switch to slicks?",
  "situation": {
    "narrative": "Rain has stopped and a dry line is forming. Your driver is on intermediates.",
    "facts": [
      { "label": "Track", "value": "Dry line, wet at the sides" },
      { "label": "Your tyres", "value": "Intermediates" },
      { "label": "Rivals", "value": "Two already pitted for slicks" },
      { "label": "Lap times", "value": "Their slicks are 2 s faster", "emphasis": "warning" },
      { "label": "Forecast", "value": "No more rain" }
    ]
  },
  "options": [
    {
      "id": "pit-now", "label": "Pit for slicks now", "verdict": "best",
      "consequence": "You lose time in the pits, then gain it back every lap. The switch is already past the crossover.",
      "considerations": [ "Slicks are already 2 s faster", "No rain is coming", "Others have paid the cost" ]
    },
    {
      "id": "one-more", "label": "One more lap on inters", "verdict": "acceptable",
      "consequence": "You lose about two seconds for that lap, but you can see if the dry line holds.",
      "considerations": [ "Small delay", "Rivals extend the gap" ]
    },
    {
      "id": "stay", "label": "Stay on intermediates", "verdict": "poor",
      "consequence": "The tyres overheat on the drying track and you fall down the order.",
      "considerations": [ "Inters wear fast on dry asphalt", "Rivals are much quicker" ]
    }
  ],
  "expertNote": "Strategists watch for the crossover point, when slicks become quicker than intermediates. Once rivals have proved it, waiting rarely helps."
}
```

<!-- type: decision-scenario -->
```json
{
  "prompt": "The car behind dives inside. How should you defend?",
  "situation": {
    "narrative": "Braking zone for a slow corner. You are ahead, the chaser is close.",
    "facts": [
      { "label": "Your position", "value": "Middle of the track" },
      { "label": "Chaser", "value": "Half a car length behind" },
      { "label": "Braking point", "value": "In 80 m" },
      { "label": "Rule", "value": "One defensive move; no weaving under braking", "emphasis": "warning" }
    ]
  },
  "options": [
    {
      "id": "one-move", "label": "Take the inside line once, before the braking zone", "verdict": "best",
      "consequence": "You cover the inside with a single move made before braking. The chaser has to go around the outside.",
      "considerations": [ "One move is allowed", "Move before the braking zone", "Leave room" ]
    },
    {
      "id": "late-move", "label": "Move across again under braking", "verdict": "poor",
      "consequence": "A second move or a move under braking risks contact and a time penalty from the stewards.",
      "considerations": [ "Weaving is not allowed", "Moving under braking is dangerous" ]
    },
    {
      "id": "hold", "label": "Stay in the middle and let him pick", "verdict": "acceptable",
      "consequence": "You leave the inside open and probably lose the place, but you avoid any risk.",
      "considerations": [ "Safe", "Gives the position away" ]
    }
  ],
  "expertNote": "Drivers may make one defensive move and must leave room. Stewards look at when the move was made and whether the chaser had space.",
  "sayThisLine": "He only moved once, so that was fine."
}
```

---

## 8. talk-track

**How it is used here:** conversation practice in every layer and the Talk tab (30 standalone tracks; 31 embedded in lessons). Each exchange offers three replies: a good one (curious and specific, usually +25), a meh one (safe but empty, +5 to +10) and a cringe one (fake expertise or dismissive, -15 to -20). Coach notes teach listening, never scripts. The ten tracks below are complete (payloads conform to `talk-track.schema.json`); the table lists what each line means.

| # | Track id | Setting | What the enthusiast line means | Terms implied |
|---|---|---|---|---|
| 1 | `tt-sunday-morning` | Sunday morning text | She is excited about qualifying: her driver starts on pole | pole-position, starting-grid |
| 2 | `tt-undercut-heartbreak` | After a race | Her driver was undercut and lost the lead | undercut, track-position |
| 3 | `tt-safety-car-luck` | After a race | Bad luck: the safety car came right after a stop | safety-car-stop, pit-loss |
| 4 | `tt-penalty-rant` | Post-race rant | She thinks a five-second penalty was harsh | stewards, time-penalty |
| 5 | `tt-clipping-complaint` | Discussing the new cars | Clipping made a pass impossible | super-clipping, energy-store |
| 6 | `tt-straight-mode` | Watching qualifying | Straight Mode gave a big speed gain | straight-mode, active-aero |
| 7 | `tt-reliability-pain` | Season chat | Two DNFs in three races: the car is fast but fragile | reliability, dnf |
| 8 | `tt-silly-season` | Mid-season | Speculation about a driver's contract | driver-market |
| 9 | `tt-watch-party` | In person | You are hosting a watch party and she is analysing tyres | tyre-degradation, stint |
| 10 | `tt-teammate-talk` | Casual | Her driver is being out-qualified by a teammate | teammate-battle, race-pace-vs-quali-pace |

<!-- type: talk-track -->
```json
{
  "title": "Sunday morning",
  "setting": "She texts before qualifying results. Her driver starts on pole.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "POLE!! By three tenths, and it is Monaco. Basically the race is ours.",
      "replies": [
        { "id": "good", "text": "Pole at Monaco is huge. Is it that hard to pass there?", "smoothDelta": 25, "theirResponse": "YES. It is so tight that track position is almost everything.", "coachNote": "You linked pole to the circuit and asked a real question. Curiosity wins." },
        { "id": "meh", "text": "Nice! Congrats to him.", "smoothDelta": 8, "theirResponse": "Thanks! I am so nervous for tomorrow.", "coachNote": "Kind, but it does not open a conversation. Ask why it matters." },
        { "id": "cringe", "text": "Pole is just the fastest lap. The race matters more.", "smoothDelta": -18, "theirResponse": "...At Monaco, pole is the race.", "coachNote": "True in general, wrong at Monaco, and a bit dismissive. Ask, do not correct." }
      ]
    },
    {
      "theirMessage": "But the start is scary. Turn one is chaos.",
      "replies": [
        { "id": "good", "text": "Does he get a good launch usually?", "smoothDelta": 22, "theirResponse": "He is usually fine, but the new cars have a weird start with the turbo lag.", "coachNote": "A friendly question about her driver. She gets to teach you." },
        { "id": "meh", "text": "Fingers crossed.", "smoothDelta": 6, "theirResponse": "Always.", "coachNote": "Warm but closed. One more question would have kept it going." },
        { "id": "cringe", "text": "Just do not crash.", "smoothDelta": -15, "theirResponse": "Thanks, very helpful.", "coachNote": "It is a joke that lands as dismissive. Keep it curious." }
      ]
    }
  ],
  "closingNote": "Pole position is first on the grid; how much it matters depends on the circuit."
}
```

<!-- type: talk-track -->
```json
{
  "title": "Undercut heartbreak",
  "setting": "After the race. Her driver led, then lost the place in the pits.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "They undercut him and he never got it back. Two laps and it was over.",
      "replies": [
        { "id": "good", "text": "So the other team stopped first and their fresh tyres did the work?", "smoothDelta": 27, "theirResponse": "Exactly! And our pit wall waited a lap too long.", "coachNote": "You restated it in your own words and checked. That shows you followed." },
        { "id": "meh", "text": "That is racing.", "smoothDelta": 5, "theirResponse": "Sure.", "coachNote": "Not wrong, but flat. She is upset; ask what happened." },
        { "id": "cringe", "text": "Your team obviously has bad strategists.", "smoothDelta": -20, "theirResponse": "Excuse me? They are usually great.", "coachNote": "Blaming her team as a stranger to the sport backfires. Ask, do not judge." }
      ]
    },
    {
      "theirMessage": "I just wish they had called him in a lap earlier.",
      "replies": [
        { "id": "good", "text": "Would a lap earlier have kept him ahead, or would he have been stuck in traffic?", "smoothDelta": 25, "theirResponse": "Good point. Traffic is always the risk. I still think earlier.", "coachNote": "You raised the trade-off honestly and let her disagree." },
        { "id": "meh", "text": "Yeah, timing is everything.", "smoothDelta": 7, "theirResponse": "It really is.", "coachNote": "Agreeable, but you added nothing. Try a follow-up." },
        { "id": "cringe", "text": "Well, actually, the ideal lap was probably 24.", "smoothDelta": -16, "theirResponse": "You did not see the gap.", "coachNote": "Fake precision. Never pretend to know the number." }
      ]
    }
  ],
  "closingNote": "An undercut means pitting first so fresh tyres let you jump ahead when the rival stops."
}
```

<!-- type: talk-track -->
```json
{
  "title": "Bad luck with the safety car",
  "setting": "After the race. She is annoyed about the timing of a caution.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "He pitted and the safety car came out on the very next lap. Worst luck ever.",
      "replies": [
        { "id": "good", "text": "Because the stop is cheaper under the safety car?", "smoothDelta": 27, "theirResponse": "Yes! Half the time loss, and everyone else got it.", "coachNote": "You knew why it hurts. That is the whole point of the lesson." },
        { "id": "meh", "text": "Oh no, sorry.", "smoothDelta": 8, "theirResponse": "Thanks.", "coachNote": "Kind. Add a question and it becomes a conversation." },
        { "id": "cringe", "text": "They should have planned for that.", "smoothDelta": -15, "theirResponse": "You cannot plan for a safety car.", "coachNote": "It is luck, not planning. Listen first." }
      ]
    },
    {
      "theirMessage": "Do you think the team should have gambled and stayed out?",
      "replies": [
        { "id": "good", "text": "It depends on the tyres, right? What was he on?", "smoothDelta": 22, "theirResponse": "Hards, fairly fresh. So maybe staying out was smart.", "coachNote": "Asking what his tyres were shows you know the decision depends on them." },
        { "id": "meh", "text": "I do not know, what do you think?", "smoothDelta": 12, "theirResponse": "I think yes, honestly.", "coachNote": "Honest and fine. Adding one fact would make it stronger." },
        { "id": "cringe", "text": "Definitely, anyone can see that.", "smoothDelta": -18, "theirResponse": "Not everyone can.", "coachNote": "Fake certainty. It is fine to say you do not know." }
      ]
    }
  ],
  "closingNote": "A safety car bunches the field and makes a pit stop cost roughly half as much."
}
```

<!-- type: talk-track -->
```json
{
  "title": "That penalty was a joke",
  "setting": "She is frustrated after the stewards' decision.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Five seconds for that?! He did nothing wrong. It was a racing incident.",
      "replies": [
        { "id": "good", "text": "What made it a racing incident to you: did both cars have room?", "smoothDelta": 25, "theirResponse": "Yes, both were on the limit and he had every right to be there.", "coachNote": "You asked about the rule she is invoking. That makes her feel heard." },
        { "id": "meh", "text": "Stewards can be harsh.", "smoothDelta": 7, "theirResponse": "They can be.", "coachNote": "Agreeable but empty. Ask why she thinks so." },
        { "id": "cringe", "text": "Rules are rules. He got what he deserved.", "smoothDelta": -20, "theirResponse": "Wow. Okay.", "coachNote": "Taking the stewards' side against her driver ends the chat. Ask first." }
      ]
    },
    {
      "theirMessage": "And it cost him the podium. Five seconds added to his time.",
      "replies": [
        { "id": "good", "text": "It is added to his race time, right, so he dropped a place?", "smoothDelta": 22, "theirResponse": "Exactly, from third to fifth after the time was added.", "coachNote": "You understood how time penalties work. Nice." },
        { "id": "meh", "text": "That is so unlucky.", "smoothDelta": 8, "theirResponse": "It is!", "coachNote": "Warm. A question about how the penalty works would help." },
        { "id": "cringe", "text": "Why do they even have penalties?", "smoothDelta": -15, "theirResponse": "...To stop crashes?", "coachNote": "It sounds like you did not read her message. Follow her thread." }
      ]
    }
  ],
  "closingNote": "A time penalty adds seconds to a driver's race time and can change the final order."
}
```

<!-- type: talk-track -->
```json
{
  "title": "Clipping complaint",
  "setting": "Chatting about the new cars after a race.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "He clipped at the end of the straight and got passed. Every single lap this weekend.",
      "replies": [
        { "id": "good", "text": "Is that the battery running out, so the car stops getting help?", "smoothDelta": 27, "theirResponse": "Yes! And the new cars make it happen all the time.", "coachNote": "You put the concept in your own words and asked. That is perfect." },
        { "id": "meh", "text": "That sounds annoying.", "smoothDelta": 8, "theirResponse": "It is.", "coachNote": "Empathy is good. Add a question about it." },
        { "id": "cringe", "text": "Sounds like they should just get a bigger battery.", "smoothDelta": -16, "theirResponse": "It is not that simple.", "coachNote": "Simple fixes to complex rules sound uninformed. Ask instead." }
      ]
    },
    {
      "theirMessage": "Some drivers lift and coast just to save energy. It is not proper racing.",
      "replies": [
        { "id": "good", "text": "Do you think it makes the racing worse, or just different?", "smoothDelta": 24, "theirResponse": "Different, maybe. But I miss flat-out racing.", "coachNote": "You invited her opinion without picking a side." },
        { "id": "meh", "text": "Yeah, I can see that.", "smoothDelta": 7, "theirResponse": "Right?", "coachNote": "Fine, but a question keeps her talking." },
        { "id": "cringe", "text": "It is basically Formula E now.", "smoothDelta": -18, "theirResponse": "That is an insult, you know.", "coachNote": "Repeating a jab you half heard sounds like a dig. Ask first." }
      ]
    }
  ],
  "closingNote": "Clipping happens when the battery runs out on a straight and the car stops getting electrical help."
}
```

<!-- type: talk-track -->
```json
{
  "title": "Straight Mode magic",
  "setting": "Watching qualifying together.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Look at him on the back straight. Straight mode and boom, he is gone.",
      "replies": [
        { "id": "good", "text": "The wings open for less drag, right? Then they close before the corner?", "smoothDelta": 27, "theirResponse": "Yes! They have to close for the braking or they run wide.", "coachNote": "You explained it back and got confirmation. Great." },
        { "id": "meh", "text": "He looks really fast.", "smoothDelta": 7, "theirResponse": "Yeah, so fast.", "coachNote": "True, but generic." },
        { "id": "cringe", "text": "Isn't that just DRS?", "smoothDelta": -12, "theirResponse": "No, DRS is gone. This is for everyone.", "coachNote": "A natural mix-up, but a quick question would have been better: how is it different from DRS?" }
      ]
    },
    {
      "theirMessage": "Everyone gets it now. Not just the car behind.",
      "replies": [
        { "id": "good", "text": "So what does the car behind get instead?", "smoothDelta": 24, "theirResponse": "Overtake Mode. Extra electrical power if he is within a second.", "coachNote": "A logical follow-up that leads to the next concept." },
        { "id": "meh", "text": "Oh, I see.", "smoothDelta": 6, "theirResponse": "Yep.", "coachNote": "Polite. Ask a follow-up to learn more." },
        { "id": "cringe", "text": "I knew that.", "smoothDelta": -14, "theirResponse": "Sure you did.", "coachNote": "Pretending backfires. It is fine to say 'I am learning'." }
      ]
    }
  ],
  "closingNote": "Straight Mode is the low-drag wing setting. Overtake Mode is an electrical boost for a car within one second."
}
```

<!-- type: talk-track -->
```json
{
  "title": "Fast but fragile",
  "setting": "Season chat with a fan whose team keeps retiring.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Two DNFs in three races. We have the fastest car and it keeps breaking.",
      "replies": [
        { "id": "good", "text": "Is it the same part failing, or different things?", "smoothDelta": 25, "theirResponse": "Different! First a hydraulic leak, then the power unit. It is maddening.", "coachNote": "A question that shows you know reliability can be one issue or many." },
        { "id": "meh", "text": "That is really unlucky.", "smoothDelta": 8, "theirResponse": "It is.", "coachNote": "Kind, but generic." },
        { "id": "cringe", "text": "So the car is not actually fast.", "smoothDelta": -18, "theirResponse": "Fast and reliable are different things!", "coachNote": "Dismisses her point. Speed and reliability are separate." }
      ]
    },
    {
      "theirMessage": "And every retirement is zero points. The title is slipping away.",
      "replies": [
        { "id": "good", "text": "How far behind are they now in the championship?", "smoothDelta": 22, "theirResponse": "About 40 points. Two more DNFs and it is over.", "coachNote": "Following the points shows you care about the stakes." },
        { "id": "meh", "text": "There is still a lot of season left.", "smoothDelta": 8, "theirResponse": "True, I guess.", "coachNote": "Encouraging. A specific question would land better." },
        { "id": "cringe", "text": "Points do not matter if you cannot finish.", "smoothDelta": -12, "theirResponse": "That is literally what I said.", "coachNote": "You repeated her point as if it were new. Listen and build." }
      ]
    }
  ],
  "closingNote": "A DNF scores zero, so reliability can decide a championship as much as speed."
}
```

<!-- type: talk-track -->
```json
{
  "title": "Silly season",
  "setting": "Mid-season chat about next year's seats.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Silly season has started. His contract is up in 2027 and everyone is guessing.",
      "replies": [
        { "id": "good", "text": "Which teams have a seat open, do you think?", "smoothDelta": 24, "theirResponse": "Two or three. The big ones are all locked, so it is the midfield.", "coachNote": "A natural next question that keeps the topic moving." },
        { "id": "meh", "text": "Where do you want him to go?", "smoothDelta": 12, "theirResponse": "Honestly, he should stay.", "coachNote": "Friendly and warm, but a less informed question." },
        { "id": "cringe", "text": "Sounds like gossip.", "smoothDelta": -14, "theirResponse": "It is the paddock's favourite sport.", "coachNote": "Dismissing a fan's favourite topic. Ask about it." }
      ]
    },
    {
      "theirMessage": "The junior programme might promote someone too.",
      "replies": [
        { "id": "good", "text": "How does a junior driver get a seat, do they need a certain licence?", "smoothDelta": 24, "theirResponse": "Yes, a super licence. You need points from junior series.", "coachNote": "You linked two concepts and asked a real question." },
        { "id": "meh", "text": "That would be exciting.", "smoothDelta": 6, "theirResponse": "It would.", "coachNote": "Fine, but a question keeps it alive." },
        { "id": "cringe", "text": "Isn't everyone in F1 a junior at some point?", "smoothDelta": -12, "theirResponse": "Not exactly, no.", "coachNote": "A guess dressed as a fact. Ask more directly." }
      ]
    }
  ],
  "closingNote": "Silly season is the driver-market speculation; a super licence is the FIA licence needed to race in F1."
}
```

<!-- type: talk-track -->
```json
{
  "title": "The watch party",
  "setting": "You are hosting friends and she is analysing the race.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "His fronts are gone. Watch, he will be in for tyres in two laps.",
      "replies": [
        { "id": "good", "text": "How can you tell? Is it the lap times dropping?", "smoothDelta": 27, "theirResponse": "Yes! Look at the last three laps, he has lost half a second each time.", "coachNote": "You asked how she reads it. People love explaining what they see." },
        { "id": "meh", "text": "Wow, you really know your stuff.", "smoothDelta": 9, "theirResponse": "Haha, thanks.", "coachNote": "A nice compliment. A follow-up question would be better." },
        { "id": "cringe", "text": "I read the tyres were fine.", "smoothDelta": -18, "theirResponse": "Where did you read that?", "coachNote": "Making it up. It is okay to say you are learning." }
      ]
    },
    {
      "theirMessage": "If he pits now, he comes out in traffic though.",
      "replies": [
        { "id": "good", "text": "Would it be better to stay out a bit longer, then?", "smoothDelta": 22, "theirResponse": "Maybe. That is the gamble the team is making.", "coachNote": "You asked about the trade-off she just described." },
        { "id": "meh", "text": "That is annoying.", "smoothDelta": 6, "theirResponse": "It is.", "coachNote": "Empathy is great. Ask about the choice next time." },
        { "id": "cringe", "text": "Just pit anyway, who cares about traffic.", "smoothDelta": -16, "theirResponse": "The traffic is the whole race!", "coachNote": "Dismissing her point. Traffic costs seconds." }
      ]
    }
  ],
  "closingNote": "Falling lap times signal tyre degradation; traffic after a stop is a real cost."
}
```

<!-- type: talk-track -->
```json
{
  "title": "Teammate trouble",
  "setting": "Casual chat about her favourite driver's season.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "He got out-qualified by his teammate again. Same car, and he is a tenth slower.",
      "replies": [
        { "id": "good", "text": "Same car, so that is the fairest comparison, right? Is his race pace better?", "smoothDelta": 27, "theirResponse": "Yes, his Sunday pace is fine. It is the one lap he struggles with.", "coachNote": "You used the teammate benchmark and asked about race versus one-lap pace." },
        { "id": "meh", "text": "That sounds frustrating.", "smoothDelta": 8, "theirResponse": "It really is.", "coachNote": "Empathetic; a question keeps it going." },
        { "id": "cringe", "text": "So he is just slower.", "smoothDelta": -18, "theirResponse": "One quali does not make him slower.", "coachNote": "A snap judgement about her driver. Ask instead." }
      ]
    },
    {
      "theirMessage": "Maybe it is the set-up. The car is easier for the other guy.",
      "replies": [
        { "id": "good", "text": "Do teams change the set-up for one driver's style?", "smoothDelta": 22, "theirResponse": "They try. But the car has a preferred way to be driven.", "coachNote": "A good question that respects her theory." },
        { "id": "meh", "text": "Could be.", "smoothDelta": 6, "theirResponse": "Yeah.", "coachNote": "Agreeable. A question would give her more to say." },
        { "id": "cringe", "text": "Excuses, excuses.", "smoothDelta": -16, "theirResponse": "Not funny.", "coachNote": "Teasing her about her driver can sting. Stay curious." }
      ]
    }
  ],
  "closingNote": "A teammate drives the same car, which makes the teammate battle the fairest measure of a driver."
}
```

---

## 9. timing-tap

**How it is used here:** two items at launch, because a 1D bar suits the pit stop reflex (D-002) but almost nothing else in F1 is a pure timing bar; anything that depends on a scene (wings, tow, energy) is a Unity sim.

<!-- type: timing-tap -->
```json
{
  "prompt": "Tap when the marker hits the gold.",
  "theme": { "label": "Pit stop", "resultUnit": "seconds" },
  "rounds": [
    { "zoneStartPct": 55, "zoneEndPct": 73, "sweepSeconds": 1.6 },
    { "zoneStartPct": 62, "zoneEndPct": 75, "sweepSeconds": 1.3 },
    { "zoneStartPct": 68, "zoneEndPct": 78, "sweepSeconds": 1.1 }
  ],
  "explanation": {
    "correct": "A crew changes four wheels in about two seconds. Precision beats speed, and every tenth is track position.",
    "incorrect": "A slow stop can cost places that are hard to win back. Crews rehearse for this exact reflex.",
    "sayThisLine": "That pit stop cost him three places."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

<!-- type: timing-tap -->
```json
{
  "prompt": "Tap when the lights go out.",
  "theme": { "label": "Lights out", "resultUnit": "seconds" },
  "rounds": [
    { "zoneStartPct": 70, "zoneEndPct": 82, "sweepSeconds": 1.8 },
    { "zoneStartPct": 74, "zoneEndPct": 82, "sweepSeconds": 1.5 },
    { "zoneStartPct": 77, "zoneEndPct": 83, "sweepSeconds": 1.3 }
  ],
  "explanation": {
    "correct": "Drivers launch on the lights going out, holding the car on its clutch. A fast reaction wins places before turn one.",
    "incorrect": "React too soon and it is a jump start with a penalty; too late and you lose places. The start is a reaction contest.",
    "sayThisLine": "The start decided everything. He lost three places."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

<!-- type: timing-tap -->
```json
{
  "prompt": "Tap at the braking marker.",
  "theme": { "label": "Braking point", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 60, "zoneEndPct": 76, "sweepSeconds": 1.7 },
    { "zoneStartPct": 64, "zoneEndPct": 74, "sweepSeconds": 1.4 }
  ],
  "explanation": {
    "correct": "Late braking gains time but risks running wide. The marker is the sweet spot for this drill.",
    "incorrect": "Brake too early and you lose time; too late and you run off. Drivers refine the point lap by lap.",
    "sayThisLine": "He braked way later than anyone else."
  }
}
```

---

## 10. fill-the-gap

**How it is used here:** vocabulary in context; quick review cards.

<!-- type: fill-the-gap -->
```json
{
  "prompt": "Complete the sentence.",
  "template": "A team pits {{who}} to gain track position on fresh tyres; that is called the {{term}}.",
  "gaps": [
    { "id": "who", "options": ["first", "last"], "correct": "first" },
    { "id": "term", "options": ["undercut", "overcut", "stint"], "correct": "undercut" }
  ],
  "explanation": {
    "correct": "Pitting first and using the fresh tyres to jump ahead is the undercut. Staying out longer is the overcut.",
    "incorrect": "The undercut means pitting first on fresh tyres. The overcut is the opposite: staying out longer.",
    "sayThisLine": "They undercut him."
  }
}
```

<!-- type: fill-the-gap -->
```json
{
  "prompt": "Fill in the 2026 terms.",
  "template": "In 2026 the {{old}} was replaced by {{new}}, and the {{removed}} was removed from the power unit.",
  "gaps": [
    { "id": "old", "options": ["DRS", "ERS", "KERS"], "correct": "DRS" },
    { "id": "new", "options": ["active aero", "a larger wing"], "correct": "active aero" },
    { "id": "removed", "options": ["MGU-H", "MGU-K", "turbo"], "correct": "MGU-H" }
  ],
  "explanation": {
    "correct": "DRS gave way to active aero and Overtake Mode, and the MGU-H was dropped to cut cost and complexity.",
    "incorrect": "DRS was retired for 2026 and replaced by active aero. The MGU-H, the heat-recovery motor, was removed; the MGU-K was made much stronger.",
    "sayThisLine": "DRS is gone and the MGU-H is gone too."
  }
}
```

<!-- type: fill-the-gap -->
```json
{
  "prompt": "Fill in the stewards' penalty.",
  "template": "Causing a collision usually earns a {{penalty}}; twelve {{points}} in a year means a one-race ban.",
  "gaps": [
    { "id": "penalty", "options": ["time penalty", "trophy", "extra lap"], "correct": "time penalty" },
    { "id": "points", "options": ["penalty points", "championship points"], "correct": "penalty points" }
  ],
  "explanation": {
    "correct": "Time penalties (5 or 10 seconds) are the usual sanction, and penalty points on the licence add up to a ban at twelve within twelve months.",
    "incorrect": "Collisions typically bring a five or ten second time penalty. Penalty points, not championship points, count toward a ban.",
    "sayThisLine": "Five seconds for causing a collision."
  }
}
```

---

## 11. estimate-slider

**How it is used here:** magnitudes that anchor understanding: race distance, weight, stop time, points.

<!-- type: estimate-slider -->
```json
{
  "prompt": "How long is a Grand Prix, in kilometres?",
  "unit": "km",
  "min": 150,
  "max": 450,
  "step": 5,
  "correctValue": 305,
  "tolerance": { "full": 10, "partial": 40 },
  "explanation": {
    "correct": "About 305 km, so the lap count changes with the track. Monaco is shorter, and races are capped at two hours.",
    "incorrect": "A Grand Prix is about 305 km (Monaco is shorter), so short tracks have more laps.",
    "sayThisLine": "It is roughly 305 kilometres."
  }
}
```

<!-- type: estimate-slider -->
```json
{
  "prompt": "How long is a top pit stop, stationary?",
  "unit": "seconds",
  "min": 1,
  "max": 10,
  "step": 0.1,
  "correctValue": 2.4,
  "tolerance": { "full": 0.4, "partial": 1.2 },
  "explanation": {
    "correct": "Around two and a half seconds standing still; the best crews do it in under two. The whole visit costs about 20 seconds including the pit lane.",
    "incorrect": "Stationary time is about 2 to 3 seconds. Including the trip through the pit lane a stop costs about 20 seconds.",
    "sayThisLine": "Two-second stops, unbelievable."
  }
}
```

<!-- type: estimate-slider -->
```json
{
  "prompt": "What is the minimum weight of a 2026 car, in kilograms?",
  "unit": "kg",
  "min": 600,
  "max": 900,
  "step": 5,
  "correctValue": 768,
  "tolerance": { "full": 10, "partial": 30 },
  "explanation": {
    "correct": "768 kg with the driver, about 30 kg lighter than before. Lighter cars are one of the 2026 goals.",
    "incorrect": "The 2026 minimum is 768 kg, about 30 kg less than the 2025 cars.",
    "sayThisLine": "The new cars are lighter and smaller."
  }
}
```

---

## 12. hotspot-tap

**How it is used here:** static diagrams where nothing moves: car anatomy, circuit maps, corner phases. If the answer depends on cars moving (tow, wake, gap), it belongs in a Unity sim.

<!-- type: hotspot-tap -->
```json
{
  "prompt": "Tap the halo.",
  "diagram": {
    "diagramId": "f1-car-topdown",
    "aspectRatio": 0.6,
    "alt": "Top-down view of an F1 car: front wing at the top, cockpit in the middle with a curved bar over it, rear wing at the bottom."
  },
  "hotspots": [
    { "id": "front-wing", "label": "Front wing", "shape": { "kind": "rect", "x": 0.15, "y": 0.02, "w": 0.7, "h": 0.1 } },
    { "id": "halo", "label": "Halo", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.42, "r": 0.09 } },
    { "id": "floor", "label": "Floor", "shape": { "kind": "rect", "x": 0.2, "y": 0.5, "w": 0.6, "h": 0.2 } },
    { "id": "rear-wing", "label": "Rear wing", "shape": { "kind": "rect", "x": 0.2, "y": 0.9, "w": 0.6, "h": 0.08 } }
  ],
  "correctHotspotIds": ["halo"],
  "explanation": {
    "correct": "The halo is the titanium bar over the cockpit that protects the driver's head. It has been mandatory since 2018.",
    "incorrect": "The halo is the curved bar over the driver's head in the middle of the car, not a wing.",
    "sayThisLine": "The halo saved him in that crash."
  }
}
```

<!-- type: hotspot-tap -->
```json
{
  "prompt": "Tap the best place to pass on this circuit.",
  "diagram": {
    "diagramId": "f1-track-generic-overtake",
    "aspectRatio": 1.3,
    "alt": "Stylised circuit outline with a long straight on the left ending in a tight hairpin, and a fast sweeping curve on the right."
  },
  "hotspots": [
    { "id": "hairpin", "label": "Hairpin after the long straight", "shape": { "kind": "circle", "cx": 0.2, "cy": 0.12, "r": 0.08 } },
    { "id": "sweeper", "label": "Fast sweeper", "shape": { "kind": "circle", "cx": 0.8, "cy": 0.6, "r": 0.08 } },
    { "id": "pit", "label": "Pit entry", "shape": { "kind": "rect", "x": 0.4, "y": 0.9, "w": 0.2, "h": 0.06 } }
  ],
  "correctHotspotIds": ["hairpin"],
  "explanation": {
    "correct": "A long straight into a slow corner is the classic passing place: the chaser gets the tow, then out-brakes the leader.",
    "incorrect": "Look for a long straight followed by a tight corner. That combination gives a run and a big braking zone, which is where passes happen.",
    "sayThisLine": "He passed at the hairpin under braking."
  }
}
```

<!-- type: hotspot-tap -->
```json
{
  "prompt": "Tap the apex of this corner.",
  "diagram": {
    "diagramId": "f1-corner-line",
    "aspectRatio": 1,
    "alt": "A right-hand corner seen from above with the inside kerb on the right and three marked spots: the entry on the left, a point on the inside kerb in the middle, and the exit on the right."
  },
  "hotspots": [
    { "id": "entry", "label": "Turn-in point", "shape": { "kind": "circle", "cx": 0.25, "cy": 0.7, "r": 0.07 } },
    { "id": "apex", "label": "Apex on the inside kerb", "shape": { "kind": "circle", "cx": 0.55, "cy": 0.45, "r": 0.07 } },
    { "id": "exit", "label": "Exit", "shape": { "kind": "circle", "cx": 0.85, "cy": 0.2, "r": 0.07 } }
  ],
  "correctHotspotIds": ["apex"],
  "explanation": {
    "correct": "The apex is where the car passes closest to the inside of the corner. You aim at it to keep the largest possible radius.",
    "incorrect": "The apex is the spot on the inside of the corner, marked by the kerb, not the entry or exit.",
    "sayThisLine": "He clipped the apex on every lap."
  }
}
```

---

## 13. Playbook terms

The Playbook is the learner's glossary and the curriculum `concepts[]` seed. Every `conceptId` used in the Curriculum map (CDS Appendix A) appears here with a plain definition and an example line in the crush's voice (spoken by a fan the learner wants to talk with; never about the crush). 127 terms; each is taught in the lesson(s) listed in CDS section 11. Definitions are original wording.

| # | conceptId | Term | Definition | Example line (in her voice) |
|---|---|---|---|---|
| 1 | `constructor` | Constructor | A team that builds its own car and scores points in the constructors' title. Ferrari, McLaren and Mercedes are constructors. | "Ferrari has never missed a season. They are the constructor." |
| 2 | `grand-prix` | Grand Prix | One round of the world championship, run at one circuit over a full weekend. Around 23 a year. | "I would fly to a Grand Prix just for the atmosphere." |
| 3 | `race-weekend` | Race weekend | The Friday-to-Sunday event: practice, qualifying, then the race. Sprint weekends compress this. | "I plan my whole weekend around the race weekend." |
| 4 | `practice` | Free practice | Friday running (FP1 to FP3 on normal weekends) where teams test set-ups and tyres. Nobody wins anything here. | "Practice times mean nothing, but everyone reads them anyway." |
| 5 | `qualifying` | Qualifying | Saturday knockout session (Q1, Q2, Q3) that sets the starting order. The fastest single lap wins pole. | "Quali is my favourite part. One lap, no excuses." |
| 6 | `pole-position` | Pole position | First place on the grid, earned by the fastest qualifying lap. Worth a lot at tight tracks like Monaco. | "Pole at Monaco is basically half the win." |
| 7 | `starting-grid` | Starting grid | The order cars line up in for the start, set by qualifying (plus any penalties). | "He qualified third but starts eighth after the penalty." |
| 8 | `parc-ferme` | Parc ferme | The rules-lock on the cars once qualifying starts: teams can barely change the set-up before the race. | "They can't touch the car in parc ferme, so they are stuck with that set-up." |
| 9 | `formation-lap` | Formation lap | The warm-up lap before the start where drivers heat tyres and brakes and then line up on the grid. | "Watch the weaving on the formation lap: they are warming the tyres." |
| 10 | `race-start` | The start | Lights-out standing start. Five red lights go out and the field launches; the first lap is chaos. | "The start decided everything. He lost three places into turn one." |
| 11 | `race-distance` | Race distance | About 305 km per Grand Prix (Monaco is shorter), capped at two hours of running time. | "It is roughly 305 kilometres, so lap count changes by track." |
| 12 | `points-system` | Points system | Top ten score 25-18-15-12-10-8-6-4-2-1. There is no bonus point for fastest lap since 2025. | "A win is 25 points, so a DNF really hurts." |
| 13 | `drivers-championship` | Drivers' Championship | The individual title: most points over the season wins. What people mean by 'the championship'. | "He leads the championship by a comfortable margin." |
| 14 | `constructors-championship` | Constructors' Championship | The team title: both drivers' points added together. Worth big prize money. | "They lost the constructors' because their second driver never scored." |
| 15 | `sprint` | Sprint | A short Saturday race (about 100 km) on selected weekends, scoring points to the top eight (8-1). | "Sprints add points but I still think Sunday is the real race." |
| 16 | `podium` | Podium | The top three finishers, who climb the podium and spray champagne. | "First podium of his career!" |
| 17 | `dnf` | DNF | Did Not Finish: retired from the race through a crash or a failure. Scores zero. | "DNF from a puncture, just brutal." |
| 18 | `fastest-lap` | Fastest lap | The quickest lap of the race. Bragging rights only: the bonus point was removed for 2025. | "He took the fastest lap on fresh softs, purely for fun." |
| 19 | `reliability` | Reliability | How likely parts are to survive. A fast, fragile car finishes fewer races and loses titles. | "They are quick but reliability is killing their season." |
| 20 | `yellow-flag` | Yellow flag | Danger ahead on the track: slow down, no overtaking in that sector. Double yellow means be ready to stop. | "Yellow in sector two, so he had to lift." |
| 21 | `red-flag` | Red flag | Session stopped, usually after a big crash or dangerous conditions. Cars return to the pits. | "They red-flagged it, and everyone got a free tyre change." |
| 22 | `blue-flag` | Blue flag | Tells a lapped driver to let a faster car through. Ignoring it earns a penalty. | "He ignored blue flags and got a five-second penalty." |
| 23 | `black-flag` | Black flag | The harshest flag: disqualified from the race. A black-and-white flag is a warning for unsportsmanlike driving. | "They are one warning away from a black flag." |
| 24 | `chequered-flag` | Chequered flag | The chequered flag ends the race for each driver as they cross the line. | "He took the chequered flag by half a second." |
| 25 | `safety-car` | Safety car | A pace car that leads the field at reduced speed after an incident. It bunches the pack and erases gaps. | "The safety car ruined his ten-second lead." |
| 26 | `virtual-safety-car` | Virtual Safety Car (VSC) | Everyone slows to a set delta time without a physical pace car. Gaps stay the same. | "Under the VSC gaps stay frozen, unlike a full safety car." |
| 27 | `standing-restart` | Standing restart | After a red flag, the cars line up on the grid again for a fresh start. | "After the red flag we get a standing restart. Chaos incoming." |
| 28 | `stewards` | Stewards | The officials who investigate incidents and hand out penalties during the weekend. | "The stewards are looking at it after the race." |
| 29 | `race-director` | Race director | The FIA official who controls the session: starts, safety cars, red flags and restarts. | "The race director called the safety car early." |
| 30 | `time-penalty` | Time penalty | Seconds added to a driver's race time, usually 5 or 10, for an infringement. Often served in the pits. | "Five seconds for causing a collision, and it dropped him off the podium." |
| 31 | `grid-penalty` | Grid penalty | Places dropped at the next start, for example for taking extra engine parts. | "Ten-place grid penalty for a new power unit, so a long Sunday." |
| 32 | `penalty-points` | Penalty points | Licence points for dangerous driving: 12 within 12 months means a one-race ban. | "He is on ten penalty points, so one more incident and he sits out." |
| 33 | `track-limits` | Track limits | White lines edge the track. All four wheels over them means an advantage, and lap times may be deleted. | "His pole lap got deleted for track limits." |
| 34 | `unsafe-release` | Unsafe release | Leaving the pit box into the path of another car or with a wheel not secure. Usually a time penalty. | "They got an unsafe release penalty for the pit stop." |
| 35 | `drs` | DRS (retired) | The Drag Reduction System flap was the overtaking aid from 2011 to 2025. Replaced by 2026 active aero and Overtake Mode. | "DRS is gone. It is Overtake Mode now." |
| 36 | `power-unit` | Power unit | What F1 calls the engine: a turbocharged V6 plus electrical systems. Not just 'the engine'. | "It is a power unit, not just an engine. There is a hybrid system." |
| 37 | `monocoque` | Monocoque | The carbon-fibre survival cell the driver sits in, with the engine bolted behind and the front suspension ahead. | "The monocoque took the impact and he walked away." |
| 38 | `halo` | Halo | The titanium bar above the cockpit that protects the driver's head. Introduced 2018. | "The halo saved him in that crash." |
| 39 | `downforce` | Downforce | Aerodynamic force pushing the car into the track, so it can corner faster. | "Without downforce it just slides around the corners." |
| 40 | `drag` | Drag | Air resistance that slows a car on the straights. Downforce brings drag as a side effect. | "Too much wing makes drag, so they lose top speed." |
| 41 | `ground-effect` | Ground effect | Shaping the floor so air speeds up underneath, sucking the car down. The 2022 to 2025 cars relied on it heavily. | "The ground-effect cars bounced badly on the straights." |
| 42 | `porpoising` | Porpoising | Bouncing at speed when the underfloor stalls and reattaches. Was a big story in 2022. | "You can see the porpoising on the onboard." |
| 43 | `dirty-air` | Dirty air | The turbulent wake behind a car that steals the follower's downforce and makes it hard to follow closely. | "He was stuck in dirty air and cooked his tyres." |
| 44 | `slipstream` | Slipstream (tow) | Driving in the wake of a car ahead cuts drag on the straight, giving extra top speed. Also called the tow. | "He got a great tow down the straight and flew past." |
| 45 | `active-aero` | Active aero | New for 2026: front and rear wing elements that move to trade downforce for low drag during a lap. | "They open the wings on the straights now." |
| 46 | `straight-mode` | Straight Mode (X-mode) | Low-drag wing setting for straights, allowed in circuit-specific zones. Fans call it X-mode. | "Straight mode makes the car so much faster in a straight line." |
| 47 | `corner-mode` | Corner Mode (Z-mode) | High-downforce default wing setting for braking and corners. Fans call it Z-mode. | "Everyone has to be in corner mode by the braking zone." |
| 48 | `overtake-mode` | Overtake Mode | 2026 electrical boost for a car within one second of the car ahead at a detection point. It replaced DRS. | "He was inside a second, so he had Overtake Mode on the straight." |
| 49 | `boost-button` | Boost | A manual driver button for extra electrical deployment, limited in how much and how often it can be used. | "He saved the boost for the last lap." |
| 50 | `recharge` | Recharge (harvesting) | Refilling the battery from braking and from engine power, a lot of which is done on every lap. | "He was recharging through the corner." |
| 51 | `mgu-k` | MGU-K | The motor-generator on the drivetrain: it recovers braking energy and adds up to 350 kW in 2026. | "The MGU-K is three times more powerful now." |
| 52 | `mgu-h` | MGU-H (removed) | The heat-recovery motor on the turbo, dropped for 2026. Its absence brings back a bit of turbo lag. | "The MGU-H is gone, which is why starts got tricky." |
| 53 | `ice` | Combustion engine (ICE) | The 1.6-litre turbo V6 part of the power unit, producing roughly 400 kW in 2026. | "The combustion engine does about half now." |
| 54 | `energy-store` | Energy store (battery) | The high-voltage battery that holds harvested energy for deployment, with strict per-lap limits. | "The battery ran flat halfway down the straight." |
| 55 | `super-clipping` | Clipping | When the battery is empty on a long straight the car stops accelerating and even slows as it harvests. Fans call it super clipping. | "He clipped at the end of the straight and got passed." |
| 56 | `lift-and-coast` | Lift and coast | Lifting off the throttle early before braking to save fuel, tyres or recharge the battery. | "The engineer said lift and coast, so he is managing something." |
| 57 | `sustainable-fuel` | Sustainable fuel | 100% advanced sustainable fuel from 2026, made from non-food biomass, waste or captured carbon. | "The fuel is sustainable now, and it works in normal petrol engines." |
| 58 | `minimum-weight` | Minimum weight | The lightest a car and driver may be. It fell by around 30 kg for 2026 to 768 kg. | "The 2026 cars are lighter and smaller, and drivers still complain." |
| 59 | `cost-cap` | Cost cap | A yearly limit on team spending, around 215 million dollars with big carve-outs. Breaches bring fines and sporting penalties. | "Everybody is watching the cost cap because it levels the field." |
| 60 | `aero-testing-restrictions` | Aero testing restrictions | A sliding scale of wind-tunnel and CFD time: the worse a team finished last year, the more it gets. | "Top teams get less tunnel time. It is called ATR." |
| 61 | `aduo` | ADUO | Additional Development and Upgrade Opportunities: extra engine upgrade chances for manufacturers that fall behind, assessed after rounds 6, 12 and 18. | "Honda gets extra upgrades under ADUO if they are behind." |
| 62 | `pu-allocation` | PU allocation | Teams may use a limited number of each power-unit element per season; fitting extra means grid penalties. | "He used a fifth turbo, so a grid penalty is coming." |
| 63 | `compression-ratio` | Compression ratio | How hard the engine squeezes its air-fuel mix. The 2026 row was about measuring it when the engine is hot as well as cold. | "The engine row is about the compression ratio when hot." |
| 64 | `flexi-wing` | Flexi-wing | A wing that bends under load to cut drag while passing static tests. A recurring loophole fight. | "They say the wing bends at speed and calls it a loophole." |
| 65 | `technical-directive` | Technical directive | An FIA clarification to teams on how a rule will be policed, often used to close a loophole mid-season. | "A technical directive killed that clever trick." |
| 66 | `regulation-era` | Regulation era | A multi-year rulebook cycle. 2026 begins a new one, so the pecking order resets. | "It is a new regulation era, so everyone starts from scratch." |
| 67 | `racing-line` | Racing line | The fastest path through a corner: usually wide in, clip the apex, wide out to keep speed up. | "He was on a perfect racing line through the chicane." |
| 68 | `apex` | Apex | The point on the inside of a corner where the car passes closest to the kerb. | "He clipped the apex on every lap." |
| 69 | `braking-zone` | Braking zone | The place on a straight where drivers brake hard for a corner. The main overtaking spot. | "He dived down the inside in the braking zone." |
| 70 | `trail-braking` | Trail braking | Carrying some brake pressure into the corner to help the car rotate. | "He is a big trail-braking driver, so he rotates the car well." |
| 71 | `understeer` | Understeer | The front tyres wash wide and the car will not turn in as much as asked. | "The car understeers in slow corners." |
| 72 | `oversteer` | Oversteer | The rear steps out and the car turns more than asked, risking a spin. | "He caught a big oversteer moment on exit." |
| 73 | `kerbs` | Kerbs | The painted ramps at corner edges. Drivers use them to straighten the line but may unsettle the car. | "He rode the kerb hard and nearly lost it." |
| 74 | `street-circuit` | Street circuit | A track on closed public roads, like Monaco or Singapore. Tight, bumpy, walls close. | "Street circuits are unforgiving, because the wall is right there." |
| 75 | `high-speed-corner` | High-speed corner | Corners taken flat or nearly flat, where downforce matters most, like Maggotts-Becketts at Silverstone. | "That is a high-speed corner, and it is a downforce test." |
| 76 | `hairpin` | Hairpin | A slow, tight 180-degree corner, usually at the end of a straight and a good overtaking place. | "He passed at the hairpin under braking." |
| 77 | `sector` | Sector | A third of the lap, timed separately. Purple, green and yellow sector times show who is quickest. | "He was purple in sector one." |
| 78 | `gap-and-interval` | Gap and interval | Gap is the time to the leader; interval is the time to the car ahead. | "The gap is two seconds, and he is closing every lap." |
| 79 | `track-evolution` | Track evolution | The track gets faster as rubber lays down and grip builds up during a weekend. | "Track evolution means the last runners in quali get quicker times." |
| 80 | `dive-bomb` | Dive-bomb | A very late lunge down the inside under braking. Works if it sticks, causes penalties if not. | "That dive-bomb was risky, and they touched." |
| 81 | `defending-position` | Defending | Covering the inside line to block a pass. Rules allow one move, and you cannot weave. | "He defended the inside, and nothing was illegal." |
| 82 | `traction` | Traction | Grip on corner exit to put power down without wheelspin. | "Great traction out of the last corner." |
| 83 | `pirelli-compounds` | Pirelli compounds (C1 to C5) | Pirelli supplies five dry compounds, C1 (hardest) to C5 (softest); three are brought to each race. | "They picked C3, C4 and C5 for this track." |
| 84 | `hard-medium-soft` | Hard, Medium, Soft | The three compounds at a weekend, labelled white, yellow and red. Softest is fastest but wears first. | "Reds are fast but die quickly." |
| 85 | `intermediate-tyre` | Intermediate tyre | Green-sidewall tyre for a damp or drying track. Not for heavy rain. | "It's drying, so inters are coming off soon." |
| 86 | `full-wet-tyre` | Full wet tyre | Blue-sidewall tyre for heavy rain and standing water. | "They needed the full wets, and visibility was awful." |
| 87 | `tyre-degradation` | Tyre degradation | Tyres lose grip and lap time as the stint goes on. Managing it is the core of race strategy. | "His tyres are degrading, so the lap times are dropping." |
| 88 | `graining` | Graining | Tiny rubber balls tear off and roughen the surface, temporarily costing grip. | "The front tyres are graining, which explains the drop." |
| 89 | `blistering` | Blistering | Overheated rubber bubbles up, permanently damaging the tyre. | "The rears are blistering, so he needs to pit." |
| 90 | `tyre-cliff` | Tyre cliff | The sudden collapse in grip when a tyre reaches the end of its life. | "He hit the tyre cliff and lost three seconds." |
| 91 | `tyre-management` | Tyre management | Driving smoothly enough to make tyres last, sometimes at the cost of speed. | "He's a master at tyre management." |
| 92 | `two-compound-rule` | Two-compound rule | In a dry race, drivers must use at least two different compounds, which forces a stop. | "Everyone has to pit because of the two-compound rule." |
| 93 | `pit-stop` | Pit stop | The tyre change in the pit lane, in about two seconds of stationary time for a top crew. | "Two-second stops, unbelievable." |
| 94 | `pit-window` | Pit window | The range of laps in which a stop makes sense given tyre life and track position. | "They are in the pit window, and the call is coming." |
| 95 | `pit-loss` | Pit loss | The time lost by driving through the pit lane versus staying on track. About 20 seconds at most circuits. | "The pit loss here is twenty-odd seconds, so it is worth staying out." |
| 96 | `undercut` | Undercut | Pitting first to gain time on fresh tyres and jump ahead when the rival stops. | "Ferrari undercut him and jumped ahead." |
| 97 | `overcut` | Overcut | Staying out longer while the rival pits, then using clear air to be faster on old tyres. | "The overcut worked because the track ahead was clear." |
| 98 | `stint` | Stint | The stretch of a race on one set of tyres. | "Long first stint, then a switch to hards." |
| 99 | `track-position` | Track position | Where you run on the road. At tracks where passing is hard, it beats pace. | "Track position is everything at this circuit." |
| 100 | `one-stop-strategy` | One-stop | A race with a single pit stop. Faster if tyres last, but rivals may pounce. | "A one-stop is possible if the tyres hold." |
| 101 | `offset-strategy` | Offset strategy | Starting a race on a different tyre from rivals to open a different pit window. | "They offset the strategy so they can attack later." |
| 102 | `safety-car-stop` | Safety car stop | Pitting under a safety car costs far less time because the field is slowed, so it feels 'free'. | "He pitted under the safety car and it was basically free." |
| 103 | `double-stack` | Double stack | Pitting both team cars in consecutive laps, so the second waits in the pit lane. | "They double-stacked, and the second car lost time waiting." |
| 104 | `crossover-point` | Crossover point | The lap time at which slicks become faster than intermediates as a track dries. | "It is at the crossover point, so they are going to slicks." |
| 105 | `box-box` | Box, box | The team radio call telling the driver to come into the pits this lap. | "Box, box, box, and he pitted." |
| 106 | `team-principal` | Team principal | The boss who runs the team and its budget, and usually the public face in the paddock. | "The team principal blamed the strategy." |
| 107 | `race-engineer` | Race engineer | The driver's main voice on the radio: sets the car up, passes instructions and reads the data. | "His race engineer keeps him calm." |
| 108 | `pit-wall` | Pit wall | Where strategists and engineers sit trackside and make race decisions. | "The pit wall made the wrong call." |
| 109 | `team-radio` | Team radio | Driver-to-team messages broadcast during the race. A huge source of memes and drama. | "His radio message was hilarious." |
| 110 | `team-orders` | Team orders | An instruction to swap positions or hold station for the team's benefit. | "They told him to let his teammate through: team orders." |
| 111 | `teammate-battle` | Teammate benchmark | The one driver who has the same car, making the teammate the fairest comparison of talent. | "He is beating his teammate, and that's why people rate him." |
| 112 | `works-team` | Works team | A team that builds its own engine, or is owned by the engine maker, like Ferrari and Mercedes. | "Ferrari is a works team, so the engine and the chassis are in-house." |
| 113 | `customer-team` | Customer team | A team that buys engines from someone else, like Williams with Mercedes. | "Williams is a customer team and uses Mercedes engines." |
| 114 | `engine-supplier` | Engine supplier | A company supplying power units: Mercedes, Ferrari, Honda, Audi and Red Bull-Ford in 2026. | "Honda is back as Aston Martin's supplier." |
| 115 | `super-licence` | Super licence | The FIA licence needed to race in F1, earned with points from lower series. | "He did not have enough points for a super licence." |
| 116 | `feeder-series` | Feeder series | F3 and F2 and other junior categories that are the ladder to F1. | "He won F2 to earn his F1 seat." |
| 117 | `junior-programme` | Junior programme | Team academies, like Red Bull's, that fund and groom young drivers. | "He's a Red Bull junior, so the seat is his if he performs." |
| 118 | `reserve-driver` | Reserve driver | The stand-in who steps up if a race driver is ill or injured. | "The reserve driver stepped in at short notice." |
| 119 | `driver-market` | Silly season | Speculation and signings about who drives for whom next year. Peaks mid-season. | "It is silly season, and everyone is guessing about next year's seats." |
| 120 | `paddock` | The paddock | The hospitality and team area behind the pits where the sport's people live. | "Everyone in the paddock is talking about it." |
| 121 | `tifosi` | Tifosi | Ferrari's passionate fans, most famously at Monza where the crowd floods the track after the race. | "The tifosi at Monza turn the whole place red." |
| 122 | `triple-crown` | Triple Crown of Motorsport | Winning the Monaco GP, the Indianapolis 500 and the 24 Hours of Le Mans. Only Graham Hill did it. | "Monaco is one third of the triple crown, so it matters." |
| 123 | `drive-to-survive` | Drive to Survive | The Netflix series that drove a big surge of new fans, especially in the US. | "I got into F1 through Drive to Survive." |
| 124 | `race-pace-vs-quali-pace` | Race pace vs one-lap pace | Speed over a whole stint versus a single flat-out lap. Some cars and drivers have one without the other. | "Fast in quali, but the race pace is nowhere." |
| 125 | `long-run` | Long run | Friday practice laps on race fuel loads that reveal race pace and tyre wear. | "His long run looked strong on the mediums." |
| 126 | `sandbagging` | Sandbagging | Hiding true pace in practice by running with lots of fuel or a conservative engine mode. | "They were sandbagging in practice." |
| 127 | `title-permutations` | Title permutations | The maths of what each contender needs to clinch the championship with races remaining. | "He can clinch it in Mexico if he wins and his rival finishes outside the top three." |

---

## 14. Validation

Every block tagged `<!-- type: <exercise-type> -->` in this file is a valid payload for `docs/contracts/native-exercises/v1/<type>.schema.json`. The check used while authoring extracts each tagged JSON block and validates it with the same ajv setup as `tools/validate/validate.mjs` (draft 2020-12). When the curriculum JSON is authored these payloads move into `curriculum/formula-1.<version>.json` activities and the standard validator covers them.

Authoring rules restated for the curriculum authors:
1. Prompts are 12 words or fewer (schema cap 120 characters).
2. Explain every answer, right and wrong; teach how it works.
3. Add a `sayThisLine` where natural; lines are in the fan's voice and are never about the person the learner is learning for.
4. Never reproduce team radio, article text or logos; images are `swoond-original`.
5. Avoid time-sensitive facts inside evergreen exercises (current champion, current standings, calendar); those belong in the live layer.
6. Regulation numbers in exercises (768 kg, 350 kW, 305 km, points) are re-verified before each season; see CDS section 16 open question 2.
