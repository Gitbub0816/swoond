# Native Exercise Plan: Photography (`photography`)

Tier B plan for `docs/courses/photography/`. All 13 native exercise types are used; Tier A sims are in `sims/`. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup when this file was written; see the validation note in `NOTES_FOR_ORCHESTRATOR.md`). Conventions: prompts are 12 words or fewer; every explanation teaches how it works; every image and audio asset carries `license: original-swoond` (procedural or in-house originals; photographs by famous photographers are never used, only named and described, spec section 40); asset paths are bundle-relative under `photography/`. Photography-specific rule: no exercise asks the learner to judge, score or rank a real person's photograph; critique exercises use Swoon'd-made images.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | Default knowledge check and Daily Bite card: exposure logic, optics facts, gear definitions, misconceptions ("telephoto compresses"). Distractors are the classic beginner errors from CDS section 2. | ~200 |
| `binary-call` | Two-way calls on an original image: blown or kept, focus miss or motion blur, hard or soft, mistake or choice. Uses `scene.kind: image` with a Swoon'd-made image. | ~40 |
| `term-match` | 3 to 6 related terms per unit intro: aperture words, camera types, lighting patterns, lens words, film words. | ~30 |
| `sequence-order` | Order of f-stops, a basic edit, the film pipeline, a RAW workflow, a shoot-planning checklist. | ~24 |
| `visual-id` | The workhorse of the course: recognise hard vs soft light, direction, lighting patterns, wide vs tele look, shallow vs deep depth of field, film vs digital cues, composition devices. All images original (`original-swoond`). | ~90 |
| `decision-scenario` | Judgment: settings for a scene, shoot planning, rent or buy, ethics and etiquette (street stranger, wildlife distance), editing honesty. Best/acceptable/poor. Safety notes on outdoor and wildlife items. | ~80 |
| `talk-track` | Conversation practice: 16 tracks at launch (nine written below); Smooth meter; replies model curiosity about her shot over gear name-dropping. | 16 |
| `timing-tap` | Only 1D timing: hitting the peak of an action (decisive moment), panning across a subject, the moment to press. Anything about a 3D scene is a sim. | ~8 |
| `say-this` | Decode what she just said: recaps, gear talk, edit talk, film talk. Each has a `noFakeExpertNote`; follow-ups are honest curiosity. | ~70 |
| `fill-the-gap` | Vocabulary in context: exposure sentences, lens sentences, lighting sentences. Quick review. | ~40 |
| `listening-id` | Shutter sounds: focal-plane mechanical, leaf shutter, silent electronic (with fake sound), film advance, mirror slap. Original recordings or synthesised only; Skip is always available. | ~8 |
| `estimate-slider` | Magnitudes: stops between apertures, colour temperature, crop-factor equivalents, sunny-16 shutter, stops of falloff, hyperfocal distance, film speed. | ~50 |
| `hotspot-tap` | Static diagrams: sensor sizes, histogram clipping, thirds grid, where to put a light, lens diagram. Procedural diagrams (`original-swoond`). | ~24 |

Estimated total: about 700 native items across 112 lessons and the review loop. Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `estimate-slider` and `visual-id`.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

**Sample 1** (lesson `exp-02`)

```json
{
  "prompt": "Which aperture lets in the most light?",
  "options": [
    { "id": "a", "text": "f/1.4" },
    { "id": "b", "text": "f/4" },
    { "id": "c", "text": "f/8" },
    { "id": "d", "text": "f/16" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "The f-number is a ratio, so small numbers mean a big opening. f/1.4 lets in about eight times more light than f/4, three stops more.",
    "incorrect": "It feels backwards: the f-number is a fraction of the focal length, so a small number is a wide opening. f/1.4 is the widest here; f/16 is a pinhole.",
    "sayThisLine": "Small f-number, big opening, lots of light."
  }
}
```

**Sample 2** (lesson `cam-06`)

```json
{
  "prompt": "What actually makes a background look compressed?",
  "options": [
    { "id": "a", "text": "The telephoto lens itself squashes space", "explanation": "Lenses do not squash anything; they only crop the view." },
    { "id": "b", "text": "Standing farther from the subject", "explanation": "Right: perspective comes from camera position." },
    { "id": "c", "text": "A smaller sensor", "explanation": "Sensor size changes the crop, not the perspective." },
    { "id": "d", "text": "More megapixels", "explanation": "Resolution has no effect on perspective." }
  ],
  "correctOptionIds": ["b"],
  "explanation": {
    "correct": "Perspective is set by where the camera stands. A long lens simply lets you stay far away and still fill the frame, so the background looks bigger and closer to the subject.",
    "incorrect": "It is distance, not glass. From far away, near and far things differ less in size. A long lens is how you keep the subject the same size while standing back.",
    "sayThisLine": "It's not the lens that compresses; it's where you stand."
  }
}
```

**Sample 3** (lesson `exp-08`)

```json
{
  "prompt": "Why does auto mode turn snow grey?",
  "options": [
    { "id": "a", "text": "The meter aims for middle grey" },
    { "id": "b", "text": "Snow reflects too little light" },
    { "id": "c", "text": "ISO is set too low" },
    { "id": "d", "text": "The lens is dirty" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "The meter assumes the scene averages out to a mid grey. A bright snowy scene gets darkened to match. Adding one to two stops of exposure compensation restores the white.",
    "incorrect": "The camera does not know it is looking at snow. It aims to make the average tone middle grey, so bright scenes come out dull. You fix it with plus exposure compensation.",
    "sayThisLine": "The meter wants everything grey, so I dial in plus exposure."
  }
}
```

**Sample 4** (lesson `cam-03`)

```json
{
  "prompt": "More megapixels means what, mostly?",
  "options": [
    { "id": "a", "text": "Cleaner low-light images" },
    { "id": "b", "text": "More room to crop and print big" },
    { "id": "c", "text": "Better colours" },
    { "id": "d", "text": "Shallower depth of field" }
  ],
  "correctOptionIds": ["b"],
  "explanation": {
    "correct": "Megapixels are how finely the image is divided. More of them help cropping and large prints, but noise, colour and blur depend on sensor size, lens and light.",
    "incorrect": "Resolution is about detail count, not quality. Low-light cleanliness comes from sensor size and technique, colour from processing, and depth of field from optics.",
    "sayThisLine": "More megapixels means more room to crop, not a better photo."
  }
}
```

### 2.2 `binary-call`

**Sample 1** (lesson `see-06`)

```json
{
  "prompt": "Sky detail: blown out or kept?",
  "scene": {
    "kind": "image",
    "image": "photography/img/exposure/sky-clipped-01.svg",
    "alt": "A low-contrast illustration of a hillside under a sky that is a flat, pure white patch with no cloud shapes visible."
  },
  "choices": [
    { "id": "blown", "label": "Blown out" },
    { "id": "kept", "label": "Detail kept" }
  ],
  "correctChoiceId": "blown",
  "explanation": {
    "correct": "The sky is one flat white with no cloud edges: the sensor ran out of room and recorded pure white. That detail is gone; you cannot pull it back in editing.",
    "incorrect": "Look for texture. Here the sky has no cloud shapes at all, just flat white. That means clipped highlights, and clipped means the information was never recorded.",
    "sayThisLine": "My highlights are blown; I'll expose a little darker next time."
  },
  "ruleTag": "Clipped highlights"
}
```

**Sample 2** (lesson `foc-02`)

```json
{
  "prompt": "Soft photo: missed focus or motion blur?",
  "scene": {
    "kind": "image",
    "image": "photography/img/focus/soft-runner-01.svg",
    "alt": "An illustration of a runner on a sharp, detailed fence. The runner's outline is smeared sideways in one direction; the fence and trees are crisp."
  },
  "choices": [
    { "id": "motion", "label": "Motion blur" },
    { "id": "miss", "label": "Missed focus" }
  ],
  "correctChoiceId": "motion",
  "explanation": {
    "correct": "The fence and trees are crisp, so focus was fine. The runner is smeared in one direction because the shutter was too slow for how fast they moved.",
    "incorrect": "If focus had missed, the background or everything at that distance would be soft too. Here only the runner smears along the direction of travel. That is motion blur.",
    "sayThisLine": "The background's sharp, so that's motion blur, not focus."
  },
  "ruleTag": "Motion blur vs focus miss"
}
```

**Sample 3** (lesson `com-02`)

```json
{
  "prompt": "Subject dead centre: mistake or choice?",
  "scene": {
    "kind": "image",
    "image": "photography/img/composition/centred-lamp-01.svg",
    "alt": "A symmetrical illustration of a lamp post in the exact centre of a wide frame, with a mirror-image pier on each side and calm water below."
  },
  "choices": [
    { "id": "mistake", "label": "Mistake" },
    { "id": "choice", "label": "Deliberate choice" }
  ],
  "correctChoiceId": "choice",
  "explanation": {
    "correct": "Symmetry is the reason to centre. With mirrored piers and water, the centred lamp makes the calm balance the point. The rule of thirds is a tool, not a law.",
    "incorrect": "Centred is not automatically wrong. When the scene is symmetrical, putting the subject in the middle creates calm and balance. Thirds help when there is no such structure.",
    "sayThisLine": "Thirds are a tool; symmetry is a good reason to break them."
  },
  "ruleTag": "Rule of thirds"
}
```

**Sample 4** (lesson `mot-03`)

```json
{
  "prompt": "Backlit face: add exposure compensation?",
  "scene": {
    "kind": "image",
    "image": "photography/img/exposure/backlit-face-01.svg",
    "alt": "An illustration of a person standing in front of a bright window; the window is well exposed and the person's face is a dark silhouette."
  },
  "choices": [
    { "id": "plus", "label": "Yes, go plus" },
    { "id": "minus", "label": "No, go minus" }
  ],
  "correctChoiceId": "plus",
  "explanation": {
    "correct": "The meter saw the bright window and darkened everything. Going plus (or spot metering the face) brings the face up, at the price of a blown window. That trade is yours to choose.",
    "incorrect": "Minus would make the face darker still. The bright window fooled the meter, so add light to the face with plus compensation or meter from the face.",
    "sayThisLine": "The window fooled the meter, so I metered off her face."
  },
  "ruleTag": "Exposure compensation"
}
```

### 2.3 `term-match`

**Sample 1** (lesson `exp-02`)

```json
{
  "prompt": "Match the aperture word to its meaning.",
  "pairs": [
    { "id": "fnum", "term": "f-number", "definition": "Focal length divided by opening; small number, big opening" },
    { "id": "wide", "term": "Wide open", "definition": "The lens at its largest aperture" },
    { "id": "stop-down", "term": "Stopping down", "definition": "Choosing a smaller opening" },
    { "id": "fast", "term": "Fast lens", "definition": "A lens with a very wide maximum aperture" }
  ],
  "distractorDefinitions": ["How long the shutter stays open"],
  "explanation": {
    "summary": "All four are about the opening. Wide open and fast lens both point to a small f-number; stopping down goes the other way to a bigger number.",
    "sayThisLine": "I shot it wide open on a fast prime."
  }
}
```

**Sample 2** (lesson `cam-01`)

```json
{
  "prompt": "Match each camera type to what defines it.",
  "pairs": [
    { "id": "dslr", "term": "DSLR", "definition": "Mirror and optical viewfinder inside the body" },
    { "id": "mirrorless", "term": "Mirrorless", "definition": "No mirror; you see the sensor image on a screen" },
    { "id": "compact", "term": "Compact", "definition": "Small body with a lens that is not removable" },
    { "id": "medium", "term": "Medium format", "definition": "A sensor or film much larger than full frame" },
    { "id": "phone", "term": "Phone camera", "definition": "Tiny sensor with lots of software processing" }
  ],
  "distractorDefinitions": ["A camera that only shoots black and white"],
  "explanation": {
    "summary": "The name usually tells you what is inside: a mirror for a DSLR, no mirror for mirrorless, a fixed lens for a compact, a big sensor for medium format, and heavy software for a phone.",
    "sayThisLine": "Is that a mirrorless or a compact with a fixed lens?"
  }
}
```

**Sample 3** (lesson `lf-02`)

```json
{
  "prompt": "Match the lighting pattern to how it looks.",
  "pairs": [
    { "id": "rembrandt", "term": "Rembrandt", "definition": "A small lit triangle on the shadow-side cheek" },
    { "id": "split", "term": "Split", "definition": "Half the face lit, half in shadow" },
    { "id": "butterfly", "term": "Butterfly", "definition": "A small shadow under the nose from a light in front and above" },
    { "id": "rim", "term": "Rim light", "definition": "A bright edge outlining hair and shoulders" }
  ],
  "distractorDefinitions": ["Even light with no shadows at all"],
  "explanation": {
    "summary": "Each pattern is named by where the light sits: to the side and up for Rembrandt, at 90 degrees for split, in front and above for butterfly, behind for rim.",
    "sayThisLine": "That's Rembrandt lighting. See the little triangle?"
  }
}
```

**Sample 4** (lesson `film-02`)

```json
{
  "prompt": "Match each film type to its result.",
  "pairs": [
    { "id": "neg", "term": "Colour negative", "definition": "Forgiving film that is scanned or printed to positive" },
    { "id": "slide", "term": "Slide (reversal)", "definition": "Film that gives a positive image directly, less forgiving" },
    { "id": "bw", "term": "Black and white", "definition": "Film recording only tones, easy to develop at home" },
    { "id": "instant", "term": "Instant film", "definition": "A print that develops itself within minutes" }
  ],
  "distractorDefinitions": ["Film that needs no light to expose"],
  "explanation": {
    "summary": "Negative film has room for mistakes; slide film wants exact exposure. Black and white is the friendliest to process yourself, and instant film hands you the print.",
    "sayThisLine": "I shoot colour negative because it's forgiving."
  }
}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `exp-05`)

```json
{
  "prompt": "Order these apertures from most light to least.",
  "items": [
    { "id": "f14", "text": "f/1.4", "why": "The widest opening here lets in the most light." },
    { "id": "f2", "text": "f/2", "why": "One stop less than f/1.4." },
    { "id": "f28", "text": "f/2.8", "why": "One stop less than f/2." },
    { "id": "f4", "text": "f/4", "why": "Half the light of f/2.8." },
    { "id": "f8", "text": "f/8", "why": "Two stops less than f/4." },
    { "id": "f16", "text": "f/16", "why": "Two more stops down: a small opening." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Each full stop halves the light, and the f-numbers grow by about 1.4 times. Learn the row 1.4, 2, 2.8, 4, 5.6, 8, 11, 16 and you can do exposure maths in your head.",
    "incorrect": "The row is 1.4, 2, 2.8, 4, 5.6, 8, 11, 16. Smaller numbers are wider openings, so the order of light is the order of the numbers.",
    "sayThisLine": "Each stop is half the light."
  }
}
```

**Sample 2** (lesson `film-05`)

```json
{
  "prompt": "Order the journey of a roll of colour film.",
  "items": [
    { "id": "shoot", "text": "Shoot the roll", "why": "The film records latent images as it is exposed." },
    { "id": "rewind", "text": "Rewind and remove it", "why": "Light-tight canister before the film leaves the camera." },
    { "id": "develop", "text": "Develop (C-41 process)", "why": "Chemistry turns the latent images into a visible negative." },
    { "id": "scan", "text": "Scan or print", "why": "The negative is turned into a positive you can view." },
    { "id": "edit", "text": "Edit and share", "why": "Digital scans are adjusted like any other file." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Expose, protect from light, develop, then scan or print. Colour negative uses the C-41 process, which most labs run; slide film uses E-6.",
    "incorrect": "You cannot see anything until development, and you cannot develop before the roll is out of the camera in the dark. Scanning comes after the chemistry.",
    "sayThisLine": "I'm waiting on the lab for my roll."
  }
}
```

**Sample 3** (lesson `ed-02`)

```json
{
  "prompt": "Put the basic edit in a sensible order.",
  "items": [
    { "id": "crop", "text": "Crop and straighten", "why": "Fix the frame first so later moves suit the final picture." },
    { "id": "wb", "text": "Set white balance", "why": "Colour cast affects every later colour decision." },
    { "id": "exposure", "text": "Adjust overall exposure", "why": "Get the brightness right before fine tonal work." },
    { "id": "hs", "text": "Recover highlights, lift shadows", "why": "Tune the extremes after the overall level is right." },
    { "id": "color", "text": "Fine-tune colour and contrast", "why": "Colour and contrast shape the mood." },
    { "id": "sharp", "text": "Sharpen and reduce noise", "why": "Finishing touches, best judged at the final size." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "A common order is frame, colour cast, overall brightness, extremes, colour and contrast, then sharpening. Many editors reorder it, but the logic is to fix big things before small ones.",
    "incorrect": "Work big to small: the crop and colour cast affect everything, then overall exposure, then the extremes, then colour and contrast, then sharpening at the end.",
    "sayThisLine": "I fix the frame and white balance before I touch contrast."
  }
}
```

### 2.5 `visual-id`

**Sample 1** (lesson `see-02`)

```json
{
  "prompt": "Is this light hard or soft?",
  "image": {
    "asset": "photography/img/light/bust-hard-01.svg",
    "alt": "A stylised bust lit from the left. The nose casts a dark shadow across the cheek; the transition from light to shadow spans about 5 percent of the face width.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "hard", "text": "Hard light" },
    { "id": "soft", "text": "Soft light" }
  ],
  "correctOptionId": "hard",
  "explanation": {
    "correct": "Crisp, dark shadow edges mean the light source is small compared with the subject. Soft light wraps around and fades shadows into their surroundings.",
    "incorrect": "Look at the shadow edges. When they are sharp and the transition is narrow, the light is hard. Soft light gives gradual, feathered edges.",
    "sayThisLine": "See how sharp the shadow edge is? That's hard light."
  },
  "cues": ["Sharp shadow edges", "Narrow transition from light to dark", "High contrast"]
}
```

**Sample 2** (lesson `lf-02`)

```json
{
  "prompt": "Which lighting pattern is this?",
  "image": {
    "asset": "photography/img/light/bust-rembrandt-01.svg",
    "alt": "A stylised bust lit from the upper left. The right cheek is in shadow and holds one small bright patch just below the eye.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "rembrandt", "text": "Rembrandt" },
    { "id": "butterfly", "text": "Butterfly" },
    { "id": "split", "text": "Split" },
    { "id": "flat", "text": "Flat front light" }
  ],
  "correctOptionId": "rembrandt",
  "explanation": {
    "correct": "The little triangle on the shadow-side cheek is the signature. The light is about 45 degrees to the side and 45 degrees up.",
    "incorrect": "Find the tell-tale triangle of light under the eye on the shadowed side. Split has half the face dark; butterfly puts a shadow under the nose; flat light has almost no shadow.",
    "sayThisLine": "That little triangle under the eye is Rembrandt."
  },
  "cues": ["Triangle of light on the shadow cheek", "Nose shadow meets cheek shadow", "Light about 45 degrees up and to the side"]
}
```

**Sample 3** (lesson `cam-04`)

```json
{
  "prompt": "Wide lens or telephoto?",
  "image": {
    "asset": "photography/img/lens/street-tele-01.svg",
    "alt": "An illustration of a street with five lamp posts receding into the distance. The nearest post and the farthest post are drawn at 100 percent and 90 percent of the same height.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "tele", "text": "Telephoto, shot from far away" },
    { "id": "wide", "text": "Wide, shot from close" }
  ],
  "correctOptionId": "tele",
  "explanation": {
    "correct": "When near and far lamp posts look similar in size, the camera was far away, which usually means a long lens to keep the subject big. A wide shot up close makes the nearest post huge and the far ones tiny.",
    "incorrect": "Posts that look packed together at nearly equal size say the camera is far from the scene. Wide shots from close make near things loom and far things shrink.",
    "sayThisLine": "It looks like she shot that from far away with a long lens."
  },
  "cues": ["Similar apparent size across depth", "Stacked layers", "Background looks close"]
}
```

**Sample 4** (lesson `foc-03`)

```json
{
  "prompt": "Shallow or deep depth of field?",
  "image": {
    "asset": "photography/img/focus/flower-shallow-01.svg",
    "alt": "An illustration of a single flower in the centre with detailed petals; the garden behind it and the leaves in front are drawn as soft coloured discs.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "shallow", "text": "Shallow" },
    { "id": "deep", "text": "Deep" }
  ],
  "correctOptionId": "shallow",
  "explanation": {
    "correct": "Only the flower is crisp; front and back melt away. That thin slice of sharpness is shallow depth of field, typical of wide apertures, close subjects and long lenses.",
    "incorrect": "Deep depth of field keeps near and far both sharp. Here everything except the flower has dissolved, which is the mark of a shallow depth of field.",
    "sayThisLine": "Shallow depth of field: only the flower is sharp."
  },
  "cues": ["Only one plane sharp", "Foreground and background blurred", "Soft bokeh circles"]
}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `exp-06`)

```json
{
  "prompt": "Indoors, dim, kid running. Which settings?",
  "situation": {
    "narrative": "A birthday party in a dim living room. You want sharp shots of a child running. Your prime lens goes to f/1.8.",
    "facts": [
      { "label": "Light", "value": "Dim room, tungsten lamps", "emphasis": "warning" },
      { "label": "Subject", "value": "Child running, fast" },
      { "label": "Lens", "value": "50mm f/1.8" },
      { "label": "Goal", "value": "Sharp, not blurred" }
    ]
  },
  "options": [
    { "id": "fast-iso", "label": "f/1.8, 1/250 s, ISO 3200", "verdict": "best", "consequence": "The child is frozen and the exposure is right. There is some noise, but the shots are usable.", "considerations": ["Fast shutter stops motion", "Wide aperture gathers light", "Noise is cheaper than blur"] },
    { "id": "low-iso", "label": "f/8, 1/30 s, ISO 100", "verdict": "poor", "consequence": "Clean but blurred: 1/30 s smears a running child, and f/8 lets too little light for a good frame.", "considerations": ["Motion needs a fast shutter", "Low ISO cannot fix a slow shutter"] },
    { "id": "slow-shutter", "label": "f/1.8, 1/30 s, ISO 400", "verdict": "acceptable", "consequence": "Exposure is fine, but motion blur is likely. It might work when she pauses.", "considerations": ["Good for still moments", "Risky for movement"] }
  ],
  "expertNote": "When light is short and the subject moves, protect the shutter speed first, open the aperture second, and let ISO rise. A sharp, noisy photo beats a clean blur.",
  "sayThisLine": "I bumped the ISO so I could freeze the action."
}
```

**Sample 2** (lesson `land-04`)

```json
{
  "prompt": "Golden hour in 40 minutes. What do you do?",
  "situation": {
    "narrative": "You planned a coastal sunset shoot. Clouds are building, and the tide is coming in over the rocks you wanted to stand on.",
    "facts": [
      { "label": "Sunset in", "value": "40 minutes" },
      { "label": "Sky", "value": "Clouds building in the west" },
      { "label": "Tide", "value": "Rising, covering the rocks", "emphasis": "warning" },
      { "label": "Kit", "value": "Tripod, wide zoom, headlamp" }
    ]
  },
  "options": [
    { "id": "higher-ground", "label": "Shoot from higher, safe ground; watch the clouds", "verdict": "best", "consequence": "You stay safe, and the building clouds may catch colour at sunset. You get a good angle without risking the tide.", "considerations": ["Rising tide is the real hazard", "Clouds can add drama", "A safe spot is still a photograph"] },
    { "id": "rocks", "label": "Wade out to the rocks for the composition", "verdict": "poor", "consequence": "You risk being cut off by the tide, and waves can knock over a tripod and a person. The shot is not worth it.", "considerations": ["Tide can trap you", "Wet rocks are slippery"] },
    { "id": "go-home", "label": "Pack up: clouds mean no sunset", "verdict": "acceptable", "consequence": "Safe, but you may miss colour; clouds often catch light after the sun dips.", "considerations": ["Stay until the light is done", "Overcast can still give moody results"] }
  ],
  "expertNote": "Experienced landscape photographers scout the tide and exit routes first, stay for the light after sunset, and let the sky decide the frame. The shot is never worth being cut off.",
  "sayThisLine": "I wait for the light after the sun's gone, not just the sunset.",
  "safetyNote": "Learning aid only. Check tide tables, stay well above the waterline and never turn your back on the sea; tell someone your plan."
}
```

**Sample 3** (lesson `str-04`)

```json
{
  "prompt": "A stranger objects to your photo. Now what?",
  "situation": {
    "narrative": "You took a candid street photo in a public square. A man notices, looks unhappy and walks up.",
    "facts": [
      { "label": "Place", "value": "Public square" },
      { "label": "Person", "value": "Adult, clearly uneasy" },
      { "label": "Photo", "value": "He is small in the frame" },
      { "label": "Your goal", "value": "Respect and stay calm" }
    ]
  },
  "options": [
    { "id": "listen-offer", "label": "Listen, explain briefly, offer to delete", "verdict": "best", "consequence": "He relaxes, you delete it in front of him, and the moment ends kindly. You keep your dignity and his.", "considerations": ["Consent matters beyond legality", "Deleting costs little", "De-escalation beats winning"] },
    { "id": "argue-law", "label": "Insist it is legal to photograph in public", "verdict": "poor", "consequence": "The conversation turns into a fight. Even if you are right on the law, you have hurt someone and spoiled the day.", "considerations": ["Legality varies by country", "Ethics are broader than law"] },
    { "id": "walk-away", "label": "Say nothing and walk away", "verdict": "acceptable", "consequence": "It avoids conflict but leaves him uneasy and you with a photo he objected to.", "considerations": ["Better to acknowledge him", "Silence can look sneaky"] }
  ],
  "expertNote": "Most street photographers keep the shot only if the subject would not mind it being kept. When someone objects, listen, explain in a sentence, and offer to delete. Laws differ from place to place; kindness travels.",
  "sayThisLine": "Happy to delete it if you'd like.",
  "safetyNote": "This is etiquette, not legal advice; local law varies. Never photograph children or vulnerable people without consent, and never argue with an angry stranger."
}
```

**Sample 4** (lesson `gear-06`)

```json
{
  "prompt": "Rent, buy used, or buy new?",
  "situation": {
    "narrative": "She is going to a friend's wedding in a month and wants a fast 85mm portrait lens. She will probably not use it much after.",
    "facts": [
      { "label": "Need", "value": "One weekend, one lens" },
      { "label": "Budget", "value": "Limited" },
      { "label": "Later use", "value": "Unlikely" },
      { "label": "Time", "value": "A month to prepare" }
    ]
  },
  "options": [
    { "id": "rent", "label": "Rent the lens for the weekend", "verdict": "best", "consequence": "A small fee gets the lens for exactly the time needed, with time left to practise before the wedding.", "considerations": ["One-time need", "Practise before the day", "No resale hassle"] },
    { "id": "used", "label": "Buy used and resell later", "verdict": "acceptable", "consequence": "It can cost less over time if you resell well, but it takes effort and carries some risk.", "considerations": ["Resale takes time", "Check condition and warranty"] },
    { "id": "new", "label": "Buy new at full price", "verdict": "poor", "consequence": "A large expense for a lens she may rarely use again, and it loses value the moment it leaves the shop.", "considerations": ["Depreciation", "Low future use"] }
  ],
  "expertNote": "For a single event, renting is often the smartest spend. For a lens you will use monthly, used copies from reputable dealers are usually the best value.",
  "sayThisLine": "Renting one for the weekend sounds smart."
}
```

### 2.7 `talk-track`

The nine full Talk Track scenarios in section 4 are the sample payloads for this type (each validates against `talk-track.schema.json`); the launch roster of 16 is in section 5.

### 2.8 `timing-tap`

**Sample 1** (lesson `str-05`)

```json
{
  "prompt": "Tap at the peak of the jump.",
  "theme": { "label": "Decisive moment", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 44, "zoneEndPct": 58, "sweepSeconds": 1.6 },
    { "zoneStartPct": 46, "zoneEndPct": 56, "sweepSeconds": 1.3 },
    { "zoneStartPct": 48, "zoneEndPct": 55, "sweepSeconds": 1.0 }
  ],
  "explanation": {
    "correct": "You pressed at the top of the action. Street and sports photographers learn to anticipate the peak, and to press a hair early to beat their own reaction time.",
    "incorrect": "The peak is brief, and reaction time eats a fraction of a second. Watch the action build and press just before it arrives.",
    "sayThisLine": "I pressed just before the peak; that's the decisive moment."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `mot-04`)

```json
{
  "prompt": "Tap as the cyclist crosses the centre.",
  "theme": { "label": "Panning", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 42, "zoneEndPct": 58, "sweepSeconds": 2.0 },
    { "zoneStartPct": 44, "zoneEndPct": 56, "sweepSeconds": 1.6 },
    { "zoneStartPct": 45, "zoneEndPct": 55, "sweepSeconds": 1.3 }
  ],
  "explanation": {
    "correct": "Panning works when the camera follows the subject and you press as they cross your planned spot. The subject stays sharp while the background streaks.",
    "incorrect": "Pick your spot, follow the subject smoothly and press as they arrive there. Stopping the pan when you press ruins the streaks.",
    "sayThisLine": "Follow through the shot, the way you do when you pan."
  },
  "accessibilityAlternative": "hold-and-release"
}
```

**Sample 3** (lesson `wild-02`)

```json
{
  "prompt": "Tap the instant the wings are raised.",
  "theme": { "label": "Wingbeat", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 60, "zoneEndPct": 72, "sweepSeconds": 1.4 },
    { "zoneStartPct": 62, "zoneEndPct": 71, "sweepSeconds": 1.1 },
    { "zoneStartPct": 64, "zoneEndPct": 70, "sweepSeconds": 0.9 }
  ],
  "explanation": {
    "correct": "Wing positions come and go in fractions of a second. A high burst rate helps, but knowing the rhythm lets you time the frame you want.",
    "incorrect": "Birds change pose faster than you react. Learn the rhythm of a wingbeat and press a beat early; a fast burst catches the rest.",
    "sayThisLine": "I shoot a burst so I catch the wing up."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.9 `say-this`

**Sample 1** (lesson `conv-01`)

```json
{
  "statement": { "speaker": "Her", "text": "I got up at 5 for golden hour and it clouded over. Total flat light." },
  "question": "What is she talking about?",
  "options": [
    { "id": "gh", "text": "The warm low-sun hour after sunrise", "isCorrect": true, "explanation": "Golden hour is the soft, warm light near sunrise and sunset." },
    { "id": "flat", "text": "Cloud cover made soft, shadowless light", "isCorrect": true, "explanation": "Flat light means little contrast or shadow shape, often on overcast days." },
    { "id": "iso", "text": "Her camera's ISO setting", "isCorrect": false, "explanation": "ISO was not mentioned." },
    { "id": "lens", "text": "A lens she bought", "isCorrect": false, "explanation": "Nothing about lenses here." }
  ],
  "translation": "She got up early to shoot in the beautiful warm light after sunrise, but clouds covered the sun and the light turned dull and even, without the dramatic shadows she wanted.",
  "followUps": [
    { "line": "Was the flat light still workable, or did you pack up?", "why": "Shows you understand flat light and invites her story." },
    { "line": "Did anything look good in that soft light?", "why": "Honest curiosity that treats the trip as worthwhile." }
  ],
  "noFakeExpertNote": "You do not need to know f-stops here. Ask what she saw and what she would do differently."
}
```

**Sample 2** (lesson `cam-05`)

```json
{
  "statement": { "speaker": "Her", "text": "I keep going back and forth on full frame or APS-C. Do I need the bigger sensor?" },
  "question": "What is she weighing?",
  "options": [
    { "id": "size", "text": "A bigger sensor versus a smaller, cheaper, lighter one", "isCorrect": true, "explanation": "Full frame is larger, usually costlier and heavier." },
    { "id": "noise", "text": "Cleaner low-light images and a shallower depth of field", "isCorrect": true, "explanation": "The usual benefits of a larger sensor." },
    { "id": "film", "text": "Whether to switch to film", "isCorrect": false, "explanation": "Film is not mentioned." },
    { "id": "flash", "text": "Which flash to buy", "isCorrect": false, "explanation": "Not related." }
  ],
  "translation": "She is choosing between a larger sensor, which tends to be cleaner in low light and blurs backgrounds more easily but costs more and weighs more, and a smaller, lighter, cheaper sensor.",
  "followUps": [
    { "line": "What do you mostly shoot? That might decide it.", "why": "Turns gear talk into shooting talk, where she is the expert." },
    { "line": "Is weight or low light the bigger deal for you?", "why": "Shows you understand the trade without pretending to pick for her." }
  ],
  "noFakeExpertNote": "Do not recommend a camera. Ask what she shoots; the answer usually settles the debate."
}
```

**Sample 3** (lesson `gear-05`)

```json
{
  "statement": { "speaker": "Her", "text": "I'm resisting GAS. I do NOT need another prime." },
  "question": "What is she joking about?",
  "options": [
    { "id": "gas", "text": "Gear acquisition syndrome, the urge to keep buying kit", "isCorrect": true, "explanation": "GAS is photographers' joke about endless gear buying." },
    { "id": "prime", "text": "A fixed-focal-length lens she already has enough of", "isCorrect": true, "explanation": "A prime does not zoom." },
    { "id": "petrol", "text": "Petrol prices", "isCorrect": false, "explanation": "GAS in photography is not fuel." },
    { "id": "mount", "text": "A broken lens mount", "isCorrect": false, "explanation": "Not mentioned." }
  ],
  "translation": "She wants another fixed lens but is telling herself she has enough. It is a self-teasing way of saying she is tempted.",
  "followUps": [
    { "line": "Which one is tempting you?", "why": "Invites the fun part: what she wants and why." },
    { "line": "What would that lens let you shoot that you can't now?", "why": "Moves from gear to what she wants to make." }
  ],
  "noFakeExpertNote": "You can laugh with her. Do not egg her on with prices or brand claims you cannot back up."
}
```

**Sample 4** (lesson `ed-05`)

```json
{
  "statement": { "speaker": "Her", "text": "This one's SOOC, no edits. I just love what the camera does with reds." },
  "question": "What does SOOC tell you?",
  "options": [
    { "id": "sooc", "text": "Straight out of camera: the JPEG as shot", "isCorrect": true, "explanation": "SOOC means no editing afterwards." },
    { "id": "colour", "text": "She likes the camera's colour rendering", "isCorrect": true, "explanation": "Colour science and film simulations shape the look." },
    { "id": "raw", "text": "She shot RAW and edited a lot", "isCorrect": false, "explanation": "The opposite of SOOC." },
    { "id": "film", "text": "It is a film photograph", "isCorrect": false, "explanation": "SOOC is about digital files." }
  ],
  "translation": "She is showing a photo exactly as the camera produced it and praising how the camera renders red, which enthusiasts often treat as part of a brand's colour character.",
  "followUps": [
    { "line": "Do you have a favourite colour setting on it?", "why": "Shows you know cameras have looks, and asks about her taste." },
    { "line": "Do you ever edit that look further?", "why": "Invites her workflow without judgment." }
  ],
  "noFakeExpertNote": "You do not need to know brand colour science. Ask what she loves about the colour."
}
```

**Sample 5** (lesson `foc-05`)

```json
{
  "statement": { "speaker": "Her", "text": "The bokeh on that lens is creamy. Look at the highlights!" },
  "question": "What is she praising?",
  "options": [
    { "id": "blur", "text": "How pleasant the out-of-focus areas look", "isCorrect": true, "explanation": "Bokeh is about the character of blur." },
    { "id": "discs", "text": "Smooth, round highlight circles in the background", "isCorrect": true, "explanation": "Highlights blur into discs; smooth ones are prized." },
    { "id": "sharp", "text": "How sharp the subject is", "isCorrect": false, "explanation": "Bokeh refers to blur, not sharpness." },
    { "id": "iso", "text": "Low noise", "isCorrect": false, "explanation": "Not related." }
  ],
  "translation": "She is delighted by how smoothly the lens turns the background into soft blur and round, gentle highlights.",
  "followUps": [
    { "line": "Was that wide open?", "why": "Aperture affects bokeh; the question is natural and informed." },
    { "line": "What was the light in the background?", "why": "Lights behind make the discs she is talking about." }
  ],
  "noFakeExpertNote": "Do not claim to judge bokeh quality. Ask what she likes about it and where she shot it."
}
```

**Sample 6** (lesson `cul-05`)

```json
{
  "statement": { "speaker": "Her", "text": "Do you think AI denoise counts as editing, or is it cheating?" },
  "question": "What is she really asking?",
  "options": [
    { "id": "honesty", "text": "Where the line is between editing and misrepresenting", "isCorrect": true, "explanation": "The debate is honesty, not editing itself." },
    { "id": "denoise", "text": "Whether software noise reduction changes the photo's truth", "isCorrect": true, "explanation": "AI denoise reconstructs detail; opinions differ." },
    { "id": "camera", "text": "Which camera has less noise", "isCorrect": false, "explanation": "She is asking about software." },
    { "id": "film", "text": "Whether grain is bad", "isCorrect": false, "explanation": "A different topic." }
  ],
  "translation": "She is asking whether using AI to clean up grainy photos is a normal part of editing or crosses a line into something dishonest.",
  "followUps": [
    { "line": "Where do you draw the line?", "why": "Invites her real view and keeps you honest about not having one yet." },
    { "line": "Would you tell people you used it?", "why": "Touches disclosure, the heart of the debate." }
  ],
  "noFakeExpertNote": "It is fine to say you have not made up your mind. Curiosity beats a hot take."
}
```

### 2.10 `fill-the-gap`

**Sample 1** (lesson `exp-06`)

```json
{
  "prompt": "Complete the exposure rule.",
  "template": "Opening the aperture by one stop lets in {{light}} the light, so you can use a {{shutter}} shutter speed.",
  "gaps": [
    { "id": "light", "options": ["half", "double", "four times"], "correct": "double" },
    { "id": "shutter", "options": ["faster", "slower"], "correct": "faster" }
  ],
  "explanation": {
    "correct": "Each stop is a doubling or halving. More light through the lens lets you halve the exposure time and keep the same brightness.",
    "incorrect": "A wider aperture by one stop doubles the light. To keep exposure equal you can double your shutter speed, which is a faster setting.",
    "sayThisLine": "One stop wider means one stop faster."
  }
}
```

**Sample 2** (lesson `cam-04`)

```json
{
  "prompt": "Fill in the lens words.",
  "template": "A {{wide}} lens shows more of the scene, while a {{tele}} lens magnifies distant subjects.",
  "gaps": [
    { "id": "wide", "options": ["wide-angle", "telephoto", "macro"], "correct": "wide-angle" },
    { "id": "tele", "options": ["wide-angle", "telephoto", "fisheye"], "correct": "telephoto" }
  ],
  "explanation": {
    "correct": "Short focal lengths see wide; long ones see narrow and magnify. The millimetre number is about field of view.",
    "incorrect": "Wide-angle lenses have short focal lengths and show more; telephoto lenses have long ones and magnify.",
    "sayThisLine": "Wide for the room, tele for the far shore."
  }
}
```

**Sample 3** (lesson `lf-03`)

```json
{
  "prompt": "Complete the softness rule.",
  "template": "A light looks {{soft}} when it is {{big}} compared with the subject, and moving it {{closer}} makes it look bigger.",
  "gaps": [
    { "id": "soft", "options": ["harder", "softer"], "correct": "softer" },
    { "id": "big", "options": ["small", "large"], "correct": "large" },
    { "id": "closer", "options": ["closer", "farther"], "correct": "closer" }
  ],
  "explanation": {
    "correct": "Softness is about how large the light appears from the subject. A larger source, or the same source closer, wraps light around and blurs shadow edges.",
    "incorrect": "Big and close means soft. A small or faraway light is hard, no matter how bright it is.",
    "sayThisLine": "Bigger or closer means softer."
  }
}
```

**Sample 4** (lesson `mot-05`)

```json
{
  "prompt": "Complete the ND filter sentence.",
  "template": "A neutral density filter {{does}} the light entering the lens, so you can use a {{shutter}} shutter speed in daylight.",
  "gaps": [
    { "id": "does", "options": ["reduces", "increases", "colours"], "correct": "reduces" },
    { "id": "shutter", "options": ["slower", "faster"], "correct": "slower" }
  ],
  "explanation": {
    "correct": "An ND filter is sunglasses for the lens. It cuts light without changing colour so you can use a long exposure, for silky water, even at noon.",
    "incorrect": "ND filters darken the scene evenly, which allows slower shutter speeds. Nothing about them adds light or colour.",
    "sayThisLine": "I put an ND on for the silky water."
  }
}
```

### 2.11 `listening-id`

**Sample 1** (lesson `film-01`)

```json
{
  "prompt": "Which shutter did you just hear?",
  "audio": {
    "asset": "photography/audio/shutter-focal-plane-01.m4a",
    "durationMs": 2400,
    "license": "original-swoond",
    "description": "A crisp two-part mechanical click: a sharp clack followed by a lower, quieter clack about a tenth of a second later.",
    "maxPlays": 3
  },
  "options": [
    { "id": "focal", "text": "Mechanical focal-plane shutter" },
    { "id": "leaf", "text": "Leaf shutter" },
    { "id": "electronic", "text": "Silent electronic shutter" }
  ],
  "correctOptionId": "focal",
  "explanation": {
    "correct": "The double clack is curtains opening and closing, the classic sound of a mirrorless or DSLR in mechanical shutter mode.",
    "incorrect": "A leaf shutter is a soft, single 'snick', and a fully electronic shutter is silent. Two distinct clacks mean mechanical curtains.",
    "sayThisLine": "That double click is the mechanical shutter."
  },
  "listenFor": ["Two distinct clacks", "A short gap between them", "A dry mechanical texture"]
}
```

**Sample 2** (lesson `cam-07`)

```json
{
  "prompt": "What kind of shutter makes this sound?",
  "audio": {
    "asset": "photography/audio/shutter-leaf-01.m4a",
    "durationMs": 1600,
    "license": "original-swoond",
    "description": "A soft, quiet, single 'snick' with almost no vibration afterwards.",
    "maxPlays": 3
  },
  "options": [
    { "id": "focal", "text": "Mechanical focal-plane shutter" },
    { "id": "leaf", "text": "Leaf shutter" },
    { "id": "advance", "text": "Film advance lever" }
  ],
  "correctOptionId": "leaf",
  "explanation": {
    "correct": "A leaf shutter sits in the lens and opens like a small iris. It is quiet and can sync with flash at very high speeds, which is why compact and medium-format cameras use it.",
    "incorrect": "A film advance is a ratchet sound and focal-plane shutters make a louder double clack. The quiet single snick is a leaf shutter.",
    "sayThisLine": "That soft snick is a leaf shutter."
  },
  "listenFor": ["A single soft sound", "Very little vibration", "Quiet compared with a DSLR"]
}
```

**Sample 3** (lesson `film-01`)

```json
{
  "prompt": "What is that ratcheting sound?",
  "audio": {
    "asset": "photography/audio/film-advance-01.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A quick, rising ratchet click of a lever being wound, then a small stop.",
    "maxPlays": 3
  },
  "options": [
    { "id": "advance", "text": "Advancing the film to the next frame" },
    { "id": "focal", "text": "A mechanical shutter firing" },
    { "id": "leaf", "text": "A leaf shutter" }
  ],
  "correctOptionId": "advance",
  "explanation": {
    "correct": "A ratchet is the lever winding the film to the next frame and cocking the shutter. It is part of the ritual that film shooters say slows them down in a good way.",
    "incorrect": "The shutter sounds are clacks or snicks. A rising ratchet with a small stop is a lever winding film.",
    "sayThisLine": "I love the wind-on sound; it slows me down."
  },
  "listenFor": ["A ratchet rising in pitch", "A stop at the end", "Mechanical, metallic tone"]
}
```

### 2.12 `estimate-slider`

**Sample 1** (lesson `exp-05`)

```json
{
  "prompt": "How many stops from f/2 to f/8?",
  "unit": "stops",
  "min": 0,
  "max": 8,
  "step": 1,
  "correctValue": 4,
  "tolerance": { "full": 0, "partial": 1 },
  "explanation": {
    "correct": "f/2, f/2.8, f/4, f/5.6, f/8 is four steps: each stop halves the light, so f/8 lets in one sixteenth of what f/2 does.",
    "incorrect": "Count the row: 2, 2.8, 4, 5.6, 8. That is four stops, which is sixteen times less light.",
    "sayThisLine": "That's four stops. Sixteen times less light."
  }
}
```

**Sample 2** (lesson `see-05`)

```json
{
  "prompt": "Roughly what Kelvin is midday daylight?",
  "unit": "K",
  "min": 1500,
  "max": 9000,
  "step": 100,
  "correctValue": 5500,
  "tolerance": { "full": 500, "partial": 1200 },
  "explanation": {
    "correct": "Daylight is about 5200 to 5600 K, which is why camera daylight white balance sits near 5500. Candle and tungsten are warmer and lower; shade and overcast are cooler and higher.",
    "incorrect": "Low numbers are warm (candle about 1900 K, tungsten about 3200 K) and high numbers are cool (shade about 7000 K). Midday sun sits in the middle, near 5500 K.",
    "sayThisLine": "Daylight is around 5500 Kelvin."
  }
}
```

**Sample 3** (lesson `cam-05`)

```json
{
  "prompt": "A 35mm lens on APS-C: equivalent field of view?",
  "unit": "mm",
  "min": 20,
  "max": 100,
  "step": 1,
  "correctValue": 52,
  "tolerance": { "full": 3, "partial": 10 },
  "explanation": {
    "correct": "APS-C crops the image by about 1.5 times, so a 35mm lens looks like roughly a 52mm lens on full frame (about 56mm on Canon's 1.6 crop).",
    "incorrect": "Multiply the focal length by the crop factor, about 1.5 for most APS-C: 35 times 1.5 is roughly 52mm.",
    "sayThisLine": "A 35 on crop is about a 50 on full frame."
  }
}
```

**Sample 4** (lesson `lf-03`)

```json
{
  "prompt": "Double the light's distance: how many stops darker?",
  "unit": "stops",
  "min": 0,
  "max": 6,
  "step": 1,
  "correctValue": 2,
  "tolerance": { "full": 0, "partial": 1 },
  "explanation": {
    "correct": "Light spreads over a larger area: double the distance and it falls to a quarter, which is two stops. This is the inverse-square law.",
    "incorrect": "Light follows the inverse-square law. Twice as far means one quarter the light, and a quarter is two stops.",
    "sayThisLine": "Double the distance, quarter the light."
  }
}
```

**Sample 5** (lesson `film-03`)

```json
{
  "prompt": "Sunny 16 at ISO 100: shutter speed denominator?",
  "unit": "1/x s",
  "min": 30,
  "max": 1000,
  "step": 10,
  "correctValue": 100,
  "tolerance": { "full": 20, "partial": 60 },
  "explanation": {
    "correct": "On a bright sunny day at f/16, set the shutter speed to about one over the ISO: 1/100 s at ISO 100. It is the film shooter's back-pocket rule.",
    "incorrect": "The Sunny 16 rule says f/16 with a shutter speed of about 1 over the ISO, so 1/100 s at ISO 100 in bright sun.",
    "sayThisLine": "Sunny 16: one over ISO at f/16."
  }
}
```

### 2.13 `hotspot-tap`

**Sample 1** (lesson `cam-02`)

```json
{
  "prompt": "Tap the full frame sensor.",
  "diagram": {
    "diagramId": "sensor-sizes-nested",
    "aspectRatio": 1.5,
    "alt": "Four nested rectangles centred on each other, labelled by size from smallest to largest: Micro Four Thirds, APS-C, full frame, medium format."
  },
  "hotspots": [
    { "id": "mft", "label": "Micro Four Thirds", "shape": { "kind": "rect", "x": 0.36, "y": 0.34, "w": 0.28, "h": 0.32 } },
    { "id": "apsc", "label": "APS-C", "shape": { "kind": "rect", "x": 0.30, "y": 0.28, "w": 0.06, "h": 0.44 } },
    { "id": "ff", "label": "Full frame", "shape": { "kind": "rect", "x": 0.22, "y": 0.20, "w": 0.08, "h": 0.60 } },
    { "id": "mf", "label": "Medium format", "shape": { "kind": "rect", "x": 0.10, "y": 0.12, "w": 0.12, "h": 0.76 } }
  ],
  "correctHotspotIds": ["ff"],
  "explanation": {
    "correct": "Full frame is the same size as a 35mm film frame, 36 by 24 mm. Smaller sensors crop the view; larger ones, like medium format, gather more.",
    "incorrect": "Full frame is the third from the smallest: it matches 35mm film at 36 by 24 mm. APS-C and Micro Four Thirds are smaller; medium format is bigger.",
    "sayThisLine": "Full frame is the same size as a 35mm film frame."
  }
}
```

**Sample 2** (lesson `mot-01`)

```json
{
  "prompt": "Tap where this histogram is clipped.",
  "diagram": {
    "diagramId": "histogram-clipped-highlights",
    "aspectRatio": 1.6,
    "alt": "A histogram with shadows on the left and highlights on the right. The graph has a tall spike squeezed against the far right edge; the left and middle are low."
  },
  "hotspots": [
    { "id": "shadows", "label": "Shadows (left edge)", "shape": { "kind": "rect", "x": 0.02, "y": 0.10, "w": 0.16, "h": 0.80 } },
    { "id": "mids", "label": "Midtones (middle)", "shape": { "kind": "rect", "x": 0.35, "y": 0.10, "w": 0.30, "h": 0.80 } },
    { "id": "highs", "label": "Highlights (right edge)", "shape": { "kind": "rect", "x": 0.82, "y": 0.10, "w": 0.16, "h": 0.80 } }
  ],
  "correctHotspotIds": ["highs"],
  "explanation": {
    "correct": "A spike jammed against the right wall means bright pixels hit the maximum and lost detail. That is clipped highlights: the info is gone, so expose a little darker.",
    "incorrect": "The left edge shows shadows, the right shows highlights. The spike pressing on the right edge is clipping; the sensor recorded pure white there.",
    "sayThisLine": "The histogram's piled up on the right; I'm clipping."
  }
}
```

**Sample 3** (lesson `lf-02`)

```json
{
  "prompt": "Tap where the light goes for Rembrandt.",
  "diagram": {
    "diagramId": "top-down-light-ring",
    "aspectRatio": 1,
    "alt": "A top-down diagram with a circle for the subject in the middle and the camera at the bottom. Eight positions marked around a ring: front, front-left, left, back-left, behind, back-right, right, front-right."
  },
  "hotspots": [
    { "id": "front", "label": "In front, by the camera", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.88, "r": 0.07 } },
    { "id": "front-left", "label": "Front-left, about 45 degrees", "shape": { "kind": "circle", "cx": 0.24, "cy": 0.76, "r": 0.07 } },
    { "id": "left", "label": "Left, 90 degrees", "shape": { "kind": "circle", "cx": 0.12, "cy": 0.5, "r": 0.07 } },
    { "id": "behind", "label": "Behind the subject", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.12, "r": 0.07 } }
  ],
  "correctHotspotIds": ["front-left"],
  "explanation": {
    "correct": "Rembrandt lighting comes from about 45 degrees to one side, and also about 45 degrees up. From the front it goes flat; at 90 degrees it becomes split lighting.",
    "incorrect": "Rembrandt sits between front and side: about 45 degrees off the camera axis, and raised about 45 degrees. Straight front is flat; full side is split; behind is rim.",
    "sayThisLine": "About 45 degrees to the side and 45 up."
  }
}
```

**Sample 4** (lesson `com-02`)

```json
{
  "prompt": "Tap the strongest rule-of-thirds power point.",
  "diagram": {
    "diagramId": "thirds-grid-dune-scene",
    "aspectRatio": 1.5,
    "alt": "A simple dune landscape with a small figure standing near the lower right intersection of a thirds grid; a low sun disc sits near the upper left intersection."
  },
  "hotspots": [
    { "id": "ul", "label": "Upper-left intersection (sun)", "shape": { "kind": "circle", "cx": 0.333, "cy": 0.333, "r": 0.06 } },
    { "id": "ur", "label": "Upper-right intersection", "shape": { "kind": "circle", "cx": 0.667, "cy": 0.333, "r": 0.06 } },
    { "id": "ll", "label": "Lower-left intersection", "shape": { "kind": "circle", "cx": 0.333, "cy": 0.667, "r": 0.06 } },
    { "id": "lr", "label": "Lower-right intersection (figure)", "shape": { "kind": "circle", "cx": 0.667, "cy": 0.667, "r": 0.06 } }
  ],
  "correctHotspotIds": ["lr"],
  "explanation": {
    "correct": "The figure sits on a power point, with the sun on the opposite one to balance it. That diagonal tension makes the frame feel considered.",
    "incorrect": "The intersections of the thirds lines are the power points. The figure, the story here, is on the lower right, and the sun balances it from the upper left.",
    "sayThisLine": "The figure's on a third, balanced by the sun."
  }
}
```
