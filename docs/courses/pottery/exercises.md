# Native Exercise Plan: Pottery (`pottery`)

Tier B plan for `docs/courses/pottery/`. **There are no Tier A sims** (`sims/` does not exist; see CDS sections 5 and 12). All 13 native exercise types are used. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with ajv when this file was written, 2026-09-30). Diagram ids and image asset paths are procedural or original (`original-swoond`) and are listed in section 6.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `decision-scenario` | The diagnosis engine ("why did it crack?"): stage, location, clay, glaze, what changed. Best / acceptable / poor with an `expertNote`, and a `safetyNote` on every studio-safety, kiln and food-safe item. | ~110 |
| `sequence-order` | The pipeline (spec section 19): thrown mug, slab build, handle timeline, a week in the studio, drying and firing stages, wedging and centering steps, each step with a `why`. | ~55 |
| `visual-id` | Recognition (spec section 18): stages of clay, pot forms, tools, surface techniques, defects, marks, kiln atmosphere looks. Original vector art only. | ~70 |
| `hotspot-tap` | Static diagrams: wheel, mug anatomy, foot cross-section, drying cross-section, kiln stacking, time-temperature chart. | ~35 |
| `multiple-choice` | Default knowledge check and Daily Bite. Why-questions ("why wedge?"), terms, traditions. Distractors are the misconceptions in CDS section 2. | ~150 |
| `binary-call` | Safe / not safe, true / myth: dry sweeping, sealed hollow form, dishwasher, "food safe because handmade". Scenes are `none`. | ~50 |
| `term-match` | Introduce 3 to 6 related terms: clay stages, kiln types, colorants, traditions. | ~30 |
| `fill-the-gap` | Vocabulary and rules in context; quick review card. | ~30 |
| `estimate-slider` | Cone temperatures, shrinkage percent, hours to cool, bisque range. Safety-adjacent numbers use tight tolerances. | ~30 |
| `listening-id` | The ring test (sound bisque rings, cracked one thuds), kiln pinging as glaze crazes. Original or synthesized audio; text alternative and Skip. | ~8 |
| `timing-tap` | One light 1D use: the leather-hard trimming window. Slow mode always; never speed pressure. | ~3 |
| `say-this` | Decode what she just said; every item has a `noFakeExpertNote` and honest follow-ups. | ~60 |
| `talk-track` | 18 talk tracks at launch; 8 are written in full in section 4. Smooth meter; replies reward curiosity and honesty. | 18 |

Estimated total: about 650 native items across 117 lessons and the review loop. Cross-type rules: each lesson ends with one item that carries a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap`, `term-match` and `estimate-slider`; no type exceeds 40% of a unit.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

**Sample 1** (lesson `wheel-01`)

```json
{
  "prompt": "Why do potters wedge clay before throwing?",
  "options": [
    { "id": "a", "text": "It removes air pockets and evens out the clay" },
    { "id": "b", "text": "It dries the clay so it holds its shape" },
    { "id": "c", "text": "It bakes out the water" },
    { "id": "d", "text": "It makes the clay heavier" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Wedging works the clay like kneading dough. It squeezes out trapped air, lines up the flat clay particles and evens out moisture, so the clay behaves the same all the way through.",
    "incorrect": "Wedging is about consistency, not drying. Air pockets can wobble a pot or burst in the kiln, and uneven moisture makes one side stiffer than the other. Working the clay fixes both.",
    "sayThisLine": "I wedge first so there are no air pockets and it's even all the way through."
  }
}
```

**Sample 2** (lesson `fire-02`)

```json
{
  "prompt": "What is a bisque firing for?",
  "options": [
    { "id": "a", "text": "It makes the pot strong enough to handle and porous enough to take glaze" },
    { "id": "b", "text": "It melts the glaze onto the pot" },
    { "id": "c", "text": "It makes the clay waterproof" },
    { "id": "d", "text": "It shrinks the pot to its final size" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "The first firing turns fragile dry clay into firm ceramic, and it is still porous, so it drinks up glaze like a sponge. That makes glazing easy and safer for the pot.",
    "incorrect": "Glaze melts in the second firing. Bisque is the first, cooler firing: it makes the clay strong enough to handle while staying porous so glaze sticks evenly.",
    "sayThisLine": "Did you get the bisque out? Are you glazing this week?"
  }
}
```

**Sample 3** (lesson `body-01`)

```json
{
  "prompt": "Which clay body is fired hottest and is typically white and smooth?",
  "options": [
    { "id": "a", "text": "Porcelain" },
    { "id": "b", "text": "Terra cotta" },
    { "id": "c", "text": "Low-fire earthenware" },
    { "id": "d", "text": "Raku clay" }
  ],
  "correctOptionIds": ["a"],
  "explanation": {
    "correct": "Porcelain is very fine, usually white, and fires to high temperatures, where it becomes dense and can be translucent when thin. Potters describe throwing it as creamy, and it is unforgiving.",
    "incorrect": "That's porcelain. Earthenware and terra cotta fire at lower temperatures and stay more porous, while porcelain fires hot, dense and white."
  }
}
```

### 2.2 `binary-call`

**Sample 1** (lesson `safe-02`)

```json
{
  "prompt": "Clay dust on the studio floor. Reach for the broom?",
  "scene": {
    "kind": "none",
    "alt": "A studio floor with a thin film of dry clay dust and a broom leaning on a table."
  },
  "choices": [
    { "id": "sweep", "label": "Sweep it up" },
    { "id": "wet-clean", "label": "Wet-clean it" }
  ],
  "correctChoiceId": "wet-clean",
  "explanation": {
    "correct": "Studios wet-clean: damp sponges, wet mops or a HEPA vacuum. Sweeping throws fine dust into the air, and dry clay dust contains silica that should not be breathed.",
    "incorrect": "Sweeping lifts the finest dust into the air, where it hangs and gets breathed in. Wet-cleaning traps the dust so it stays on the cloth, not in lungs.",
    "sayThisLine": "Ah, you wet-mop the floor so the dust doesn't fly."
  },
  "ruleTag": "Wet cleaning"
}
```

**Sample 2** (lesson `hand-05`)

```json
{
  "prompt": "A sealed hollow sculpture goes in the kiln. Fine as is?",
  "scene": {
    "kind": "none",
    "alt": "A closed clay ball with no holes, ready to be fired."
  },
  "choices": [
    { "id": "fine", "label": "Fine as it is" },
    { "id": "vent", "label": "Needs a vent hole" }
  ],
  "correctChoiceId": "vent",
  "explanation": {
    "correct": "Air and moisture trapped inside expand as the kiln heats, and a sealed piece can burst. A small hidden vent hole lets the pressure out, which is why makers hide one under a base or in a seam.",
    "incorrect": "Sealed forms trap air and leftover moisture. Heating expands both, and the piece can crack or explode. A small vent hole gives the pressure an exit."
  },
  "ruleTag": "Vent hole"
}
```

**Sample 3** (lesson `coll-05`)

```json
{
  "prompt": "A handmade mug is food safe just because it is handmade.",
  "scene": {
    "kind": "none",
    "alt": "A hand-thrown mug with a speckled glaze on a wooden table."
  },
  "choices": [
    { "id": "true", "label": "True" },
    { "id": "false", "label": "False" }
  ],
  "correctChoiceId": "false",
  "explanation": {
    "correct": "Food-safe depends on the glaze: it must be lead-free, well-formulated and fully melted onto a well-fitted body. Ask the maker; a good potter will happily tell you.",
    "incorrect": "Handmade doesn't guarantee safe. Food safety depends on the glaze recipe and the firing, and crude, antique or imported ware can leach lead. Ask the maker.",
    "sayThisLine": "Is this glaze food safe? I always ask the maker."
  },
  "ruleTag": "Food safe"
}
```

### 2.3 `term-match`

**Sample 1** (lesson `clay-03`)

```json
{
  "prompt": "Match the clay stage to what it means.",
  "pairs": [
    { "id": "slip", "term": "Slip", "definition": "Clay thinned with water to a cream, used to join and decorate" },
    { "id": "leather-hard", "term": "Leather-hard", "definition": "Stiff but still damp, firm enough to trim and carve" },
    { "id": "bone-dry", "term": "Bone dry", "definition": "Completely dry, pale and fragile, ready for the first firing" },
    { "id": "bisque", "term": "Bisque", "definition": "Fired once, hard but still porous, ready to glaze" }
  ],
  "explanation": {
    "summary": "Clay travels from wet to leather-hard to bone dry to bisque to glaze-fired. Each stage is a different working state with its own rules.",
    "sayThisLine": "Is it leather-hard yet, or still too wet to trim?"
  }
}
```

**Sample 2** (lesson `fire-07`)

```json
{
  "prompt": "Match the kiln to how it is fired.",
  "pairs": [
    { "id": "electric", "term": "Electric kiln", "definition": "Heating elements; clean, controllable, the studio workhorse" },
    { "id": "gas", "term": "Gas kiln", "definition": "Burns fuel; can create a reduction atmosphere" },
    { "id": "wood", "term": "Wood kiln", "definition": "Burns wood; ash lands on pots as natural glaze" },
    { "id": "raku", "term": "Raku kiln", "definition": "Small, fast kiln; pieces are pulled out glowing hot" }
  ],
  "explanation": {
    "summary": "Electric kilns are the everyday choice; gas and wood kilns bring flame and atmosphere; raku is a fast, dramatic firing. Each gives different surfaces.",
    "sayThisLine": "Do you fire electric, or do you get to use the wood kiln?"
  }
}
```

**Sample 3** (lesson `glaze-04`)

```json
{
  "prompt": "Match the colorant to the color it is known for.",
  "pairs": [
    { "id": "cobalt", "term": "Cobalt", "definition": "Strong, reliable blue" },
    { "id": "copper", "term": "Copper", "definition": "Green in oxidation, reds in reduction" },
    { "id": "iron", "term": "Iron", "definition": "Browns, amber and tenmoku black; celadon greens in reduction" },
    { "id": "rutile", "term": "Rutile", "definition": "Variegated tans and blues, used for breakup and streaks" }
  ],
  "explanation": {
    "summary": "Metal oxides color glaze. The same colorant can look very different depending on the glaze base, thickness and firing atmosphere, which is why potters test tiles.",
    "sayThisLine": "Is the blue cobalt? I love a good cobalt."
  }
}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `seq-01`)

```json
{
  "prompt": "Put the thrown mug in order, wet clay to finished.",
  "items": [
    { "id": "wedge", "text": "Wedge the clay", "why": "Evens out the clay and removes air pockets before you start." },
    { "id": "throw", "text": "Center, open and pull up the walls", "why": "Shapes the mug while the clay is soft and workable." },
    { "id": "trim", "text": "Trim the foot at leather-hard", "why": "Leather-hard clay is firm enough to cut cleanly but not yet brittle." },
    { "id": "handle", "text": "Pull and attach the handle", "why": "Attach when the mug and handle are at the same dampness so they shrink together." },
    { "id": "dry", "text": "Dry slowly and evenly", "why": "Fast or uneven drying makes cracks and warps." },
    { "id": "bisque", "text": "Bisque fire", "why": "Turns dry clay into strong, porous ceramic ready for glaze." },
    { "id": "glaze", "text": "Glaze the mug", "why": "Bisque is porous, so it draws in glaze evenly." },
    { "id": "glaze-fire", "text": "Glaze fire", "why": "Melts the glaze into glass and matures the clay." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Every stage prepares the next: wedged clay throws evenly, leather-hard clay trims cleanly, bone-dry clay survives the bisque, and bisque takes glaze. Skip one and problems show up later.",
    "incorrect": "Watch the moisture. Work happens while clay is soft (throwing), leather-hard (trimming, handles), then it dries fully and goes through two firings.",
    "sayThisLine": "So the handle goes on when the mug's still leather-hard, right?"
  }
}
```

**Sample 2** (lesson `fire-03`)

```json
{
  "prompt": "Order the fragile points in a firing as it heats.",
  "items": [
    { "id": "water", "text": "Around 212 F, leftover water turns to steam", "why": "Any moisture left in the clay must leave slowly or it can burst the piece." },
    { "id": "burnout", "text": "Up to about 1,000 F, chemically bound water and organics leave", "why": "Clay is still fragile while it gives off gas; heat gently here." },
    { "id": "quartz", "text": "Near 1,063 F, quartz inversion", "why": "Quartz in the clay changes shape suddenly, so heating slowly here is safer." },
    { "id": "peak", "text": "Peak temperature and hold for the target cone", "why": "This is where the clay matures and the glaze melts." },
    { "id": "cool", "text": "Slow cooling through the quartz and cristobalite inversions", "why": "Fast cooling can crack pieces (dunting) as the clay contracts unevenly." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "A firing schedule is slow where the clay is fragile: moisture leaves first, then bound water, then quartz inverts, then peak, then a careful cooling. Rushing is what makes things burst or dunt.",
    "incorrect": "Think of the kiln as gentle at the fragile points: steam near 212 F, gas release to about 1,000 F, the quartz jump near 1,063 F, then peak and a slow cool.",
    "sayThisLine": "I heard you go slow through the quartz inversion."
  }
}
```

**Sample 3** (lesson `wheel-04`)

```json
{
  "prompt": "Order the steps of centering clay on the wheel.",
  "items": [
    { "id": "slam", "text": "Throw the wedged clay firmly onto the center of the wheel head", "why": "A good start close to center saves you a lot of work." },
    { "id": "wet", "text": "Wet the clay and your hands", "why": "Water is the lubricant that keeps clay from grabbing and tearing." },
    { "id": "brace", "text": "Brace your elbows and set the wheel spinning fast", "why": "Bracing lets your body, not your hands, hold the clay steady." },
    { "id": "cone", "text": "Squeeze the clay up into a cone, then press it down again", "why": "Coning up and down works the clay evenly and finds the center." },
    { "id": "check", "text": "Stop and check that it spins without wobble", "why": "If it wobbles, repeat; a good pot begins with a good center." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Centering is a controlled fight: you brace and let steady pressure move the clay to the wheel's true center. The cone up and down is the classic move that does it.",
    "incorrect": "Start close to center, add water, brace, then cone up and down before checking. Hands do not overpower the wheel; a braced body and steady pressure do.",
    "sayThisLine": "Centering is the hardest part, isn't it?"
  }
}
```

**Sample 4** (lesson `glaze-02`)

```json
{
  "prompt": "Order how to glaze a bisque mug by dipping.",
  "items": [
    { "id": "clean", "text": "Wipe the bisque with a damp sponge to remove dust", "why": "Dust makes glaze crawl away from the surface." },
    { "id": "wax", "text": "Wax the foot with wax resist", "why": "Wax keeps glaze off the foot so the mug will not fuse to the kiln shelf." },
    { "id": "stir", "text": "Stir the glaze bucket well", "why": "Glaze materials settle; unstirred glaze goes on too thin." },
    { "id": "dip", "text": "Dip for a few seconds, then lift and let it drip", "why": "Bisque absorbs glaze, so a short dip gives the right thickness." },
    { "id": "wipe", "text": "Wipe any glaze off the foot and let it dry", "why": "Any glaze left on the foot fuses to the kiln shelf." }
  ],
  "partialCredit": true,
  "explanation": {
    "correct": "Clean bisque, a waxed foot and a well-stirred bucket give an even coat that will not weld to the shelf. Thickness comes from bisque absorbing glaze, so time matters more than muscle.",
    "incorrect": "Prepare first: dust off, wax the foot, stir. Then dip briefly and clean the foot. Glaze on the foot fuses to the kiln shelf, which can ruin the shelf and the mug."
  }
}
```

### 2.5 `visual-id`

**Sample 1** (lesson `read-01`)

```json
{
  "prompt": "Which form is this?",
  "image": {
    "asset": "pottery/visual/form-pitcher.svg",
    "alt": "A tall vessel with a wide belly, a narrow neck with a pinched pouring lip, and a single loop handle on one side.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "pitcher", "text": "Pitcher", "explanation": "A pouring lip and a handle are the giveaways." },
    { "id": "vase", "text": "Vase", "explanation": "Vases usually have no handle and no pouring lip." },
    { "id": "tumbler", "text": "Tumbler", "explanation": "A tumbler is a simple handleless cup." },
    { "id": "bowl", "text": "Bowl", "explanation": "A bowl is wide and open, with no neck." }
  ],
  "correctOptionId": "pitcher",
  "explanation": {
    "correct": "The pinched lip and the handle say pitcher. Form names tell you what a piece is for, which is how potters talk about their work.",
    "incorrect": "This one has a pouring lip and a handle, so it is a pitcher. A vase has no spout and a bowl is wide and open."
  },
  "cues": ["Pinched pouring lip", "One loop handle", "Narrow neck with a wider belly"]
}
```

**Sample 2** (lesson `fail-06`)

```json
{
  "prompt": "What is this glaze defect?",
  "image": {
    "asset": "pottery/visual/defect-crazing.svg",
    "alt": "A close-up of a glazed white tile surface covered in a fine web of hairline cracks, like a spiderweb, with no chips or flaking.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "crazing", "text": "Crazing", "explanation": "A fine web of hairline cracks in the glaze." },
    { "id": "shivering", "text": "Shivering", "explanation": "Glaze flakes off edges in sharp slivers." },
    { "id": "crawling", "text": "Crawling", "explanation": "Glaze pulls back into beads, leaving bare clay." },
    { "id": "pinholing", "text": "Pinholing", "explanation": "Tiny holes through the glaze surface." }
  ],
  "correctOptionId": "crazing",
  "explanation": {
    "correct": "A web of fine cracks in the glaze is crazing. The glaze is shrinking more than the clay and is pulled into tension, so it cracks.",
    "incorrect": "The hairline web is crazing. Shivering is the opposite problem, where the glaze is squeezed too hard and flakes off in slivers."
  },
  "cues": ["Fine web of hairline cracks", "Glaze stays attached", "Often appears as the piece cools or days later"]
}
```

**Sample 3** (lesson `clay-03`)

```json
{
  "prompt": "What stage is this mug in?",
  "image": {
    "asset": "pottery/visual/stage-bone-dry-mug.svg",
    "alt": "A plain mug with an even pale grey-white matte surface, no dark damp patches, sitting on a drying rack.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "bone-dry", "text": "Bone dry", "explanation": "Pale, evenly light and completely dry." },
    { "id": "leather-hard", "text": "Leather-hard", "explanation": "Still cool and damp, darker in color." },
    { "id": "bisque", "text": "Bisque", "explanation": "Fired once; usually a warmer, harder look." },
    { "id": "glazed", "text": "Glaze fired", "explanation": "It would have a glassy or matte glaze coating." }
  ],
  "correctOptionId": "bone-dry",
  "explanation": {
    "correct": "Evenly pale and matte with no damp, dark patches means bone dry. It is fragile, but it is ready for the first firing.",
    "incorrect": "Leather-hard clay looks darker and feels cool; bone dry is uniformly pale and feels room temperature to the touch."
  },
  "cues": ["Uniform pale color", "No cool or dark damp patches", "Very fragile but ready to bisque"]
}
```

**Sample 4** (lesson `read-03`)

```json
{
  "prompt": "Thrown or handbuilt? Look at the inside.",
  "image": {
    "asset": "pottery/visual/thrown-rings-interior.svg",
    "alt": "The inside wall of a bowl showing evenly spaced circular ridges spiralling upward, and a smooth symmetrical curve from the base to the rim.",
    "license": "original-swoond"
  },
  "options": [
    { "id": "thrown", "text": "Wheel-thrown", "explanation": "Circular ridges and perfect symmetry come from the spinning wheel." },
    { "id": "coiled", "text": "Coil-built", "explanation": "Coil-built pieces often show joined ridges or horizontal seams." },
    { "id": "slab", "text": "Slab-built", "explanation": "Slab pieces have flat panels and corner seams." },
    { "id": "slip-cast", "text": "Slip-cast", "explanation": "Slip-cast pieces are usually very smooth and even, with thin mold seams." }
  ],
  "correctOptionId": "thrown",
  "explanation": {
    "correct": "The regular circular ridges inside are throwing rings, left by fingers as the walls were pulled up on a spinning wheel.",
    "incorrect": "Throwing rings are concentric ridges from fingers moving up a spinning wall. Handbuilt work tends to show seams, joins or flat panels instead."
  },
  "cues": ["Concentric ridges inside", "Rotational symmetry", "No flat panels or seams"]
}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `fail-03`)

```json
{
  "prompt": "Why did the bottom crack in a spiral?",
  "situation": {
    "narrative": "She threw a bowl and left it to dry. Two days later, a curved crack runs across the inside floor.",
    "facts": [
      { "label": "Stage", "value": "Drying (before firing)" },
      { "label": "Crack shape", "value": "Curved S or spiral on the floor" },
      { "label": "Location", "value": "Center of the base" },
      { "label": "Wall thickness", "value": "Thick base, thin walls" },
      { "label": "Drying", "value": "Set on a shelf near a heater" }
    ]
  },
  "options": [
    {
      "id": "compress",
      "label": "Base not compressed; uneven and fast drying",
      "verdict": "best",
      "consequence": "Correct. The floor's particles were not compressed, and a thick, fast-drying base pulled against the walls. This is the classic S-crack, and it appears before the kiln.",
      "considerations": ["The crack appeared during drying", "Thick base dries slower than thin walls", "Compressing the floor and drying slowly prevents it"]
    },
    {
      "id": "kiln",
      "label": "The kiln fired too fast",
      "verdict": "poor",
      "consequence": "Not this time. The piece was never fired; the crack appeared while it was drying.",
      "considerations": ["Stage matters: it has not been fired yet"]
    },
    {
      "id": "glaze",
      "label": "The glaze does not fit the clay",
      "verdict": "poor",
      "consequence": "There is no glaze yet, so glaze fit cannot be the cause.",
      "considerations": ["Glaze problems show after a glaze firing"]
    },
    {
      "id": "clay",
      "label": "The clay is simply bad",
      "verdict": "acceptable",
      "consequence": "Unlikely on its own. Any clay can S-crack if the base is uncompressed and dries unevenly, so change the technique before blaming the clay.",
      "considerations": ["Check clay only after ruling out compression and drying"]
    }
  ],
  "expertNote": "An experienced potter asks three things: when did it appear, where, and what shape? A spiral in the center of the floor during drying points to compression and drying speed, not glaze or kiln.",
  "sayThisLine": "Was that an S-crack? Do you compress the floor more?"
}
```

**Sample 2** (lesson `fail-05`)

```json
{
  "prompt": "The mug cracked in the kiln. Cause?",
  "situation": {
    "narrative": "A glazed mug came out of a glaze firing with a clean crack from rim to base and a sharp edge, glazed inside the crack.",
    "facts": [
      { "label": "Stage", "value": "Glaze firing, cooling" },
      { "label": "Crack edges", "value": "Sharp and glazed over" },
      { "label": "Kiln opened", "value": "Same evening it finished", "emphasis": "warning" },
      { "label": "Clay", "value": "Stoneware" },
      { "label": "Cooling", "value": "Lid cracked early" }
    ]
  },
  "options": [
    {
      "id": "dunt",
      "label": "Dunting: cooled too fast",
      "verdict": "best",
      "consequence": "Correct. Cooling through the quartz and cristobalite inversions too quickly, for example by opening the kiln early, stresses the clay so it cracks.",
      "considerations": ["Glazed-over crack edges mean it cracked hot, in the kiln", "Opening early speeds cooling through the fragile ranges", "Slow cooling and waiting protect the pot"]
    },
    {
      "id": "drying",
      "label": "It dried too fast before firing",
      "verdict": "poor",
      "consequence": "Drying cracks usually show before firing, and would not have glazed edges.",
      "considerations": ["Glaze in the crack means the crack formed in the kiln"]
    },
    {
      "id": "crazing",
      "label": "Crazing",
      "verdict": "poor",
      "consequence": "Crazing is a fine web in the glaze, not one large crack through the pot.",
      "considerations": ["Crazing does not split the clay"]
    },
    {
      "id": "handle",
      "label": "The handle was attached too dry",
      "verdict": "acceptable",
      "consequence": "Handle joins can crack, but this crack runs rim to base, not around the handle.",
      "considerations": ["Handle cracks are near the join"]
    }
  ],
  "expertNote": "Sharp, glazed-over edges say the piece cracked while the kiln was still hot. Cooling cracks (dunting) are why studios wait for the kiln to cool slowly and never open it early.",
  "sayThisLine": "Did it dunt? I read it's a cooling crack.",
  "safetyNote": "Only trained studio staff open kilns. Kilns and their contents stay dangerously hot long after the fire ends; wait for the studio's cooling rule."
}
```

**Sample 3** (lesson `safe-06`)

```json
{
  "prompt": "Should this pretty imported bowl hold soup?",
  "situation": {
    "narrative": "A bright hand-painted bowl was bought from a market stall. There is no label, and the seller says it is 'traditional'.",
    "facts": [
      { "label": "Origin", "value": "Unknown source, no label" },
      { "label": "Glaze", "value": "Bright, thick, glossy" },
      { "label": "Testing", "value": "None known" },
      { "label": "Intended use", "value": "Hot, acidic soup", "emphasis": "warning" }
    ]
  },
  "options": [
    {
      "id": "decor",
      "label": "Use it as decoration, not for food",
      "verdict": "best",
      "consequence": "Safest. Unknown-source glazed ware can contain lead or cadmium that leach into hot or acidic food, and you cannot tell by looking.",
      "considerations": ["Lead leaching is invisible and tasteless", "Hot and acidic foods leach more", "Ask the maker, or use ware known to be food-safe"]
    },
    {
      "id": "wash",
      "label": "Wash it well, then use it",
      "verdict": "poor",
      "consequence": "Washing does not remove lead built into the glaze. The risk stays.",
      "considerations": ["Leaching comes from the glaze itself"]
    },
    {
      "id": "taste",
      "label": "Try it and see if it tastes odd",
      "verdict": "poor",
      "consequence": "Leached lead has no taste or smell. There is no sensory test.",
      "considerations": ["Taste is not a safety test"]
    },
    {
      "id": "ask",
      "label": "Ask for test results before using it",
      "verdict": "acceptable",
      "consequence": "Reasonable. Without documentation it is safer to keep it for display.",
      "considerations": ["A trustworthy maker can say what glaze they used"]
    }
  ],
  "expertNote": "Potters treat 'food safe' as a claim that needs a reason: a lead-free, well-fitted, fully melted glaze. Unlabelled, crude, antique or decorative ware gets treated as decoration.",
  "sayThisLine": "Is this one meant for food, or is it more of a display piece?",
  "safetyNote": "Swoon'd gives general awareness, not medical or testing advice. FDA guidance advises caution with traditional, antique and unlabelled glazed ware."
}
```

**Sample 4** (lesson `fail-07`)

```json
{
  "prompt": "The glaze beaded up. What happened?",
  "situation": {
    "narrative": "A celadon bowl came out of the glaze kiln with bare clay showing in patches where the glaze rolled into droplets.",
    "facts": [
      { "label": "Stage", "value": "Glaze firing" },
      { "label": "Defect", "value": "Glaze pulled back into beads" },
      { "label": "Bisque handling", "value": "Sat on a dusty shelf for a week" },
      { "label": "Glaze coat", "value": "Applied thick over a dry, dusty surface" }
    ]
  },
  "options": [
    {
      "id": "dust",
      "label": "Dust and thick glaze on the bisque",
      "verdict": "best",
      "consequence": "Correct. Dust or oils on the bisque, or a very thick coat, keep glaze from bonding, so it crawls into beads as it melts.",
      "considerations": ["Wipe bisque with a damp sponge before glazing", "Apply an even, moderate coat", "Crawling shows as bare patches with rounded glaze edges"]
    },
    {
      "id": "cool",
      "label": "It cooled too quickly",
      "verdict": "poor",
      "consequence": "Fast cooling may cause cracks or crazing, not beading.",
      "considerations": ["Crawling happens as the glaze melts, not as it cools"]
    },
    {
      "id": "clay",
      "label": "The clay was too dry",
      "verdict": "poor",
      "consequence": "Clay moisture at this stage is not the cause; the piece was already bisque fired.",
      "considerations": ["The bisque firing removed the moisture"]
    },
    {
      "id": "cone",
      "label": "The kiln under-fired",
      "verdict": "acceptable",
      "consequence": "Underfiring can leave glaze rough, but it does not pull glaze into beads.",
      "considerations": ["Underfiring looks dull or rough, not beaded"]
    }
  ],
  "expertNote": "Crawling is a preparation problem more often than a kiln problem. Ask what the bisque looked like before glazing, and how thick the coat was.",
  "sayThisLine": "Did it crawl? Was the bisque dusty?"
}
```

### 2.7 `talk-track`

See section 4; eight full payloads are provided there and the roster of 18 is in section 5.

### 2.8 `timing-tap`

**Sample 1** (lesson `trim-01`)

```json
{
  "prompt": "Tap when the pot is leather-hard.",
  "theme": { "label": "Trimming window", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 40, "zoneEndPct": 60, "sweepSeconds": 6 },
    { "zoneStartPct": 42, "zoneEndPct": 58, "sweepSeconds": 6 },
    { "zoneStartPct": 44, "zoneEndPct": 56, "sweepSeconds": 5 }
  ],
  "explanation": {
    "correct": "That's the trimming window: stiff enough to cut cleanly, damp enough not to chip. It is a window of time, not a moment, which is why potters check by touch.",
    "incorrect": "Too soon and the clay smears and dents; too late and it chips and dusts. The middle stage, leather-hard, is the sweet spot for trimming and handles.",
    "sayThisLine": "How do you know when it's leather-hard?"
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 2** (lesson `seq-03`)

```json
{
  "prompt": "Tap while the mug and handle are both soft-firm.",
  "theme": { "label": "Handle window", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 35, "zoneEndPct": 55, "sweepSeconds": 6 },
    { "zoneStartPct": 38, "zoneEndPct": 54, "sweepSeconds": 6 }
  ],
  "explanation": {
    "correct": "Nice read. A handle attaches best when it and the mug hold similar moisture, so they shrink together and the join stays strong.",
    "incorrect": "If the handle is much drier or wetter than the mug, they shrink at different rates and the join cracks later. Match the moisture first.",
    "sayThisLine": "Do you wait for the handle and the mug to match?"
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

**Sample 3** (lesson `fire-01`)

```json
{
  "prompt": "Tap when the piece has dried evenly.",
  "theme": { "label": "Even drying", "resultUnit": "points" },
  "rounds": [
    { "zoneStartPct": 60, "zoneEndPct": 80, "sweepSeconds": 7 },
    { "zoneStartPct": 62, "zoneEndPct": 78, "sweepSeconds": 7 }
  ],
  "explanation": {
    "correct": "That's the point of drying slowly: moisture leaves evenly, so the pot shrinks evenly and stays uncracked. Bone dry is the goal before a bisque firing.",
    "incorrect": "Rushed drying dries the edges before the middle, and the difference makes cracks. A slow, even dry gets the piece to bone dry safely."
  },
  "accessibilityAlternative": "tap-to-stop-slow"
}
```

### 2.9 `say-this`

**Sample 1** (lesson `talk-02`)

```json
{
  "statement": { "speaker": "Maya", "text": "Ugh, my base S-cracked again. I think I didn't compress the floor." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "A spiral crack in the bottom of a pot", "isCorrect": true, "explanation": "An S-crack is a curved crack across the base." },
    { "id": "b", "text": "A glaze flaking off the rim", "isCorrect": false, "explanation": "That would be shivering." },
    { "id": "c", "text": "She pressed down the clay floor firmly to strengthen it", "isCorrect": true, "explanation": "Compressing the base aligns the particles and reduces cracking." },
    { "id": "d", "text": "Her wheel is broken", "isCorrect": false, "explanation": "She's describing the pot, not the wheel." }
  ],
  "translation": "The bottom of her pot cracked in a spiral, and she thinks she didn't press the clay floor down firmly enough while throwing.",
  "followUps": [
    { "line": "Is that a drying thing or a throwing thing?", "why": "Shows you know the crack can come from either compression or uneven drying." },
    { "line": "What will you change next time?", "why": "Invites her to problem-solve out loud." }
  ],
  "noFakeExpertNote": "Don't pretend to know how to fix it. Ask what she is going to try; potters love explaining."
}
```

**Sample 2** (lesson `cult-07`)

```json
{
  "statement": { "speaker": "Maya", "text": "Bisque came out clean, so I'm glazing this weekend. Cone 6." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "Her first firing worked and she'll glaze next", "isCorrect": true, "explanation": "Bisque is the first firing." },
    { "id": "b", "text": "She'll fire to a mid-range temperature", "isCorrect": true, "explanation": "Cone 6 is the mid-fire range, about 2,230 F." },
    { "id": "c", "text": "She's starting a diet", "isCorrect": false, "explanation": "Nothing in her message is about food." },
    { "id": "d", "text": "She'll paint it with a brush and leave it to dry", "isCorrect": false, "explanation": "Glaze has to melt in the kiln; it is not paint that dries." }
  ],
  "translation": "Her first firing went well, so she's going to glaze her pieces this weekend, and they will be fired to about cone 6, a mid-range temperature.",
  "followUps": [
    { "line": "What glaze are you excited about?", "why": "Glaze is the fun reveal and she probably has favorites." },
    { "line": "Do you fire electric?", "why": "Cone 6 is often electric; it shows you're listening." }
  ],
  "noFakeExpertNote": "Cone numbers are a real vocabulary. Ask what she likes about cone 6 rather than guessing at what it means."
}
```

**Sample 3** (lesson `talk-03`)

```json
{
  "statement": { "speaker": "Maya", "text": "The celadon pooled perfectly in the carving. I could cry." },
  "question": "What is she talking about?",
  "options": [
    { "id": "a", "text": "A green glaze collected in carved lines and looks great", "isCorrect": true, "explanation": "Celadon is a pale green glaze; it deepens where it pools." },
    { "id": "b", "text": "The glaze ran off the pot and made a mess", "isCorrect": false, "explanation": "Pooling in carving is a deliberate effect." },
    { "id": "c", "text": "She's upset about a broken piece", "isCorrect": false, "explanation": "She says it in delight." },
    { "id": "d", "text": "She carved a line to hold the glaze on purpose", "isCorrect": true, "explanation": "Carving makes grooves where glaze gathers thicker and darker." }
  ],
  "translation": "Her green glaze settled into the carved lines on the pot, making them deeper in color, and she's thrilled with how it looks.",
  "followUps": [
    { "line": "Did you carve it planning for that?", "why": "Shows you get that the carving and glaze work together." },
    { "line": "What made it come out so well?", "why": "Invites her to share her process." }
  ],
  "noFakeExpertNote": "Don't claim to know glazes. Ask what she loves about celadon; the answer will be the fun part."
}
```

### 2.10 `fill-the-gap`

**Sample 1** (lesson `clay-02`)

```json
{
  "prompt": "Complete the sentence about firing.",
  "template": "Clay is fired first to {{first}}, then glazed and fired again to {{second}} the glaze.",
  "gaps": [
    { "id": "first", "options": ["bisque", "boil"], "correct": "bisque" },
    { "id": "second", "options": ["melt", "dry"], "correct": "melt" }
  ],
  "explanation": {
    "correct": "Bisque firing makes the clay strong and porous; the glaze firing melts the glaze into glass and finishes the clay.",
    "incorrect": "The first firing is the bisque, and the second melts the glaze. Glaze is glass, so it has to melt to work."
  }
}
```

**Sample 2** (lesson `fire-04`)

```json
{
  "prompt": "Complete the sentence about cones.",
  "template": "A pyrometric cone bends as it absorbs {{heatwork}}, which tells you how much heat the pot has really {{received}}.",
  "gaps": [
    { "id": "heatwork", "options": ["heatwork", "moisture"], "correct": "heatwork" },
    { "id": "received", "options": ["received", "lost"], "correct": "received" }
  ],
  "explanation": {
    "correct": "Heatwork is the combined effect of temperature and time. Cones bend at set amounts of it, so they show what the kiln really did, not just what a controller said.",
    "incorrect": "Cones measure heatwork, the effect of temperature over time, and they show how much the pot actually received."
  }
}
```

**Sample 3** (lesson `glaze-07`)

```json
{
  "prompt": "Complete the glaze-fit rule.",
  "template": "If the glaze shrinks more than the clay, you get {{defect1}}; if it shrinks less, you may get {{defect2}}.",
  "gaps": [
    { "id": "defect1", "options": ["crazing", "shivering"], "correct": "crazing" },
    { "id": "defect2", "options": ["shivering", "crazing"], "correct": "shivering" }
  ],
  "explanation": {
    "correct": "A glaze that shrinks too much is pulled into tension and crazes; one that shrinks too little is squeezed into compression and can shiver off in slivers.",
    "incorrect": "Crazing means the glaze is in tension (it shrank more than the clay). Shivering is the reverse: the glaze is in too much compression and flakes off."
  }
}
```

### 2.11 `listening-id`

**Sample 1** (lesson `fire-05`)

```json
{
  "prompt": "Tap-test the bisque. What does this ring say?",
  "audio": {
    "asset": "pottery/audio/ring-test-sound-bisque.m4a",
    "durationMs": 3000,
    "license": "original-swoond",
    "description": "A clear, bright, ringing tone that lasts a second or two after the tap.",
    "maxPlays": 3
  },
  "options": [
    { "id": "sound", "text": "The piece is sound", "explanation": "A clear, ringing tone means no cracks." },
    { "id": "cracked", "text": "The piece is cracked", "explanation": "A crack gives a dull, short thud." }
  ],
  "correctOptionId": "sound",
  "explanation": {
    "correct": "A bright, ringing tone means the piece is likely one solid body with no cracks. Potters tap bisque before glazing so they do not glaze a cracked pot.",
    "incorrect": "A ring means sound; a dull thud or buzz suggests a crack. That is why potters tap bisque before spending time on glaze."
  },
  "listenFor": ["A clear tone that lingers", "No buzzing or dullness"]
}
```

**Sample 2** (lesson `fail-06`)

```json
{
  "prompt": "The kiln is cooling and pings. What is happening?",
  "audio": {
    "asset": "pottery/audio/kiln-pinging-crazing.m4a",
    "durationMs": 4000,
    "license": "original-swoond",
    "description": "Several soft metallic ticks and pings spaced irregularly, like tiny glass tapping.",
    "maxPlays": 3
  },
  "options": [
    { "id": "crazing", "text": "Glaze crazing as the pots cool", "explanation": "The pings are glaze contracting into fine cracks." },
    { "id": "elements", "text": "The kiln elements are failing", "explanation": "Elements do not ping like that." },
    { "id": "dry", "text": "Moisture escaping", "explanation": "There is no water left after a glaze firing." }
  ],
  "correctOptionId": "crazing",
  "explanation": {
    "correct": "Pinging as a kiln cools is often crazing: the glaze is contracting more than the clay and cracking into fine lines. Some potters say the pots are singing.",
    "incorrect": "Those soft pings are usually glaze crazing as the kiln cools. The glaze shrinks more than the clay and cracks into a web."
  },
  "listenFor": ["Irregular soft pings", "Like tiny glass tapping"]
}
```

**Sample 3** (lesson `fire-01`)

```json
{
  "prompt": "Which sound is a cracked bisque pot?",
  "audio": {
    "asset": "pottery/audio/ring-test-cracked-bisque.m4a",
    "durationMs": 2000,
    "license": "original-swoond",
    "description": "A short dull thud and a slight buzz, with no ringing tone.",
    "maxPlays": 3
  },
  "options": [
    { "id": "cracked", "text": "Cracked", "explanation": "A dull, short thud or buzz means a crack." },
    { "id": "sound", "text": "Sound", "explanation": "A sound piece rings." }
  ],
  "correctOptionId": "cracked",
  "explanation": {
    "correct": "A dull thud or buzz says the pot is cracked, so the sound cannot travel through it cleanly. Better to find that before glazing than after.",
    "incorrect": "This one is dull, so it is cracked. A sound bisque pot rings clearly because the sound travels through one continuous body."
  },
  "listenFor": ["Dull thud", "Buzz", "No lingering tone"]
}
```

### 2.12 `estimate-slider`

**Sample 1** (lesson `body-02`)

```json
{
  "prompt": "About what temperature is cone 6, in degrees F?",
  "unit": "degrees F",
  "min": 1600,
  "max": 2600,
  "step": 50,
  "correctValue": 2232,
  "tolerance": { "full": 60, "partial": 150 },
  "explanation": {
    "correct": "Cone 6 is about 2,232 F (about 1,222 C) at a slow rate. It is the mid-range that most community studios and electric kilns use.",
    "incorrect": "Cone 6 is around 2,232 F (about 1,222 C). Cone 10 is hotter at about 2,345 F, and low-fire cones sit under 2,000 F. Cones vary with heating rate."
  }
}
```

**Sample 2** (lesson `clay-05`)

```json
{
  "prompt": "How much does typical stoneware shrink in total, percent?",
  "unit": "percent",
  "min": 0,
  "max": 30,
  "step": 1,
  "correctValue": 12,
  "tolerance": { "full": 2, "partial": 4 },
  "explanation": {
    "correct": "Most stoneware shrinks roughly 10 to 14 percent from wet to fired, some porcelains even more. Potters make things bigger to allow for it.",
    "incorrect": "It's more than you would think, about a tenth or more of the size. About 12 percent is typical, depending on the clay body."
  }
}
```

**Sample 3** (lesson `seq-04`)

```json
{
  "prompt": "How many hours does a full electric kiln take to cool?",
  "unit": "hours",
  "min": 2,
  "max": 72,
  "step": 2,
  "correctValue": 24,
  "tolerance": { "full": 8, "partial": 16 },
  "explanation": {
    "correct": "A full kiln often needs a day or more to cool, and studios have their own cooling rule. Opening early risks cracking pots and burns.",
    "incorrect": "Kilns cool slowly, often a day or more for a full load. The studio's rule decides when it is safe; never open a hot kiln."
  }
}
```

### 2.13 `hotspot-tap`

**Sample 1** (lesson `read-01`)

```json
{
  "prompt": "Tap the foot of the mug.",
  "diagram": {
    "diagramId": "mug-anatomy",
    "aspectRatio": 1,
    "alt": "Side view of a mug with a labeled rim at the top, body in the middle, a handle on the right and a narrow ring-shaped base at the bottom."
  },
  "hotspots": [
    { "id": "rim", "label": "Rim", "shape": { "kind": "rect", "x": 0.25, "y": 0.08, "w": 0.4, "h": 0.1 } },
    { "id": "body", "label": "Body", "shape": { "kind": "rect", "x": 0.25, "y": 0.25, "w": 0.4, "h": 0.4 } },
    { "id": "handle", "label": "Handle", "shape": { "kind": "rect", "x": 0.68, "y": 0.28, "w": 0.2, "h": 0.35 } },
    { "id": "foot", "label": "Foot", "shape": { "kind": "rect", "x": 0.28, "y": 0.8, "w": 0.34, "h": 0.12 } }
  ],
  "correctHotspotIds": ["foot"],
  "explanation": {
    "correct": "The foot is the narrow ring the mug stands on. It is trimmed at leather-hard and keeps the base light and stable.",
    "incorrect": "The foot is the ring at the very bottom. Trimming carves it away from the base so the mug sits stably and is not too heavy.",
    "sayThisLine": "Do you trim your feet by hand, or use a bat?"
  }
}
```

**Sample 2** (lesson `fire-05`)

```json
{
  "prompt": "Tap the glazed piece that will fuse to the shelf.",
  "diagram": {
    "diagramId": "kiln-glaze-stacking",
    "aspectRatio": 1.2,
    "alt": "Cross-section of a kiln shelf with three glazed bowls. Two have bare, waxed feet standing clear of the shelf glaze; one has glaze running all the way to the bottom of its foot."
  },
  "hotspots": [
    { "id": "bowl-left", "label": "Left bowl, bare foot", "shape": { "kind": "circle", "cx": 0.2, "cy": 0.55, "r": 0.13 } },
    { "id": "bowl-middle", "label": "Middle bowl, glaze to the foot", "shape": { "kind": "circle", "cx": 0.5, "cy": 0.55, "r": 0.13 } },
    { "id": "bowl-right", "label": "Right bowl, bare foot", "shape": { "kind": "circle", "cx": 0.8, "cy": 0.55, "r": 0.13 } },
    { "id": "shelf", "label": "Kiln shelf", "shape": { "kind": "rect", "x": 0.05, "y": 0.72, "w": 0.9, "h": 0.1 } }
  ],
  "correctHotspotIds": ["bowl-middle"],
  "explanation": {
    "correct": "Glaze melts into glass, so glaze on the foot welds the bowl to the shelf. That is why feet are waxed or wiped clean and shelves are coated with kiln wash.",
    "incorrect": "The middle bowl has glaze running down to its foot. When it melts, it glues the bowl to the shelf. Glazed pieces need bare feet and a coated shelf."
  }
}
```

**Sample 3** (lesson `fire-03`)

```json
{
  "prompt": "Tap where the quartz inversion happens.",
  "diagram": {
    "diagramId": "firing-curve-labeled",
    "aspectRatio": 1.6,
    "alt": "A line chart of kiln temperature over time. The line climbs slowly, with three marked stages: steam near 212 F, a gas-release zone up to about 1,000 F, and a marked point near 1,063 F before a climb to peak."
  },
  "hotspots": [
    { "id": "steam", "label": "Water smoking, about 212 F", "shape": { "kind": "circle", "cx": 0.15, "cy": 0.85, "r": 0.08 } },
    { "id": "burnout", "label": "Gas release, up to about 1,000 F", "shape": { "kind": "circle", "cx": 0.4, "cy": 0.6, "r": 0.09 } },
    { "id": "quartz", "label": "Quartz inversion, about 1,063 F", "shape": { "kind": "circle", "cx": 0.55, "cy": 0.5, "r": 0.08 } },
    { "id": "peak", "label": "Peak temperature", "shape": { "kind": "circle", "cx": 0.85, "cy": 0.15, "r": 0.09 } }
  ],
  "correctHotspotIds": ["quartz"],
  "explanation": {
    "correct": "Quartz inversion is near 1,063 F (573 C). The quartz in the clay changes shape suddenly, so kilns heat slowly through it, and cool slowly through it on the way down.",
    "incorrect": "The quartz inversion is the labeled point near 1,063 F. The steam stage is near 212 F, and peak is where the glaze melts."
  }
}
```

**Sample 4** (lesson `wheel-03`)

```json
{
  "prompt": "Tap the wheel head.",
  "diagram": {
    "diagramId": "wheel-anatomy",
    "aspectRatio": 1,
    "alt": "Side and top view of a pottery wheel: a flat round metal wheel head on the top, a curved splash pan around it, a foot pedal to one side and a motor base underneath."
  },
  "hotspots": [
    { "id": "head", "label": "Wheel head", "shape": { "kind": "rect", "x": 0.3, "y": 0.3, "w": 0.4, "h": 0.1 } },
    { "id": "splash-pan", "label": "Splash pan", "shape": { "kind": "rect", "x": 0.15, "y": 0.42, "w": 0.7, "h": 0.12 } },
    { "id": "pedal", "label": "Foot pedal", "shape": { "kind": "rect", "x": 0.72, "y": 0.75, "w": 0.2, "h": 0.12 } },
    { "id": "base", "label": "Motor base", "shape": { "kind": "rect", "x": 0.25, "y": 0.6, "w": 0.5, "h": 0.2 } }
  ],
  "correctHotspotIds": ["head"],
  "explanation": {
    "correct": "The wheel head is the flat disc that spins. The clay is thrown on it, or on a bat that sits on top.",
    "incorrect": "The wheel head is the round flat disc on top that spins. The splash pan catches the water and slip flung off it."
  }
}
```

## 3. Playbook terms (66)

Definition plus an example line in an enthusiast's voice. Plain words, no jargon in the definition.

| Term | Definition | Example line |
|---|---|---|
| Wedging | Kneading clay to remove air and make it even | "I wedged for ten minutes and still found a bubble." |
| Centering | Getting the clay spinning perfectly steady in the middle of the wheel | "I can't get it centered today." |
| Throwing | Shaping clay on a spinning wheel | "I'm throwing mugs tonight." |
| Pulling | Drawing the clay walls upward and thinner | "Three pulls, and it finally stood tall." |
| Bat | A removable board fixed to the wheel head to throw on | "Put it on a bat so I can move it without touching it." |
| Slip | Clay thinned with water to a cream | "Slip and score, then press it on." |
| Scoring | Scratching rough lines so two pieces of clay bond | "Score both sides before you join." |
| Greenware | Unfired clay, whether damp or dry | "The greenware shelf is full." |
| Leather-hard | Stiff but still damp clay, right for trimming | "It's leather-hard, I'll trim in the morning." |
| Bone dry | Completely dry, fragile clay ready for firing | "Bone dry by Friday, bisque on Saturday." |
| Bisque | Clay after its first firing, hard but porous | "The bisque came out beautiful." |
| Glaze | A thin layer of glass melted onto the pot | "I'm testing a new glaze on tiles." |
| Kiln | An oven that fires clay to very high temperatures | "The kiln is loaded and running." |
| Cone | A small pyramid that bends at a set heat, or a scale of firing heat | "We fire to cone 6." |
| Cone 6 | A mid-range firing, about 2,230 F | "Cone 6 electric is my everyday." |
| Cone 10 | A high-range firing, about 2,345 F | "Cone 10 reduction gives the deepest colors." |
| Oxidation | Firing with plenty of air in the kiln | "Oxidation makes the copper green." |
| Reduction | Firing with limited air, changing glaze and clay color | "Reduction turned the iron celadon." |
| Earthenware | Low-fire, often orange or red, more porous clay | "The terra cotta pot is earthenware." |
| Stoneware | Mid- to high-fire dense clay, the studio staple | "I mostly work in stoneware." |
| Porcelain | White, fine, high-fire clay that can be translucent | "Porcelain is like throwing butter." |
| Grog | Fired clay ground up, added for strength | "Add grog so the sculpture doesn't slump." |
| Paper clay | Clay mixed with paper fiber for lightness and easy repair | "I switched to paper clay for the big piece." |
| Reclaim | Recycling scrap clay back into usable clay | "I reclaimed a whole bucket today." |
| Vitrification | Clay turning dense and glassy so it stops absorbing water | "It's fully vitrified, so it won't leak." |
| Absorption | How much water a fired clay soaks up | "Low absorption means it's more durable." |
| Trimming | Carving away extra clay from a leather-hard piece | "I'm trimming feet all morning." |
| Foot ring | The narrow ring a pot stands on | "That's a lovely foot ring." |
| Fettling | Cleaning up and finishing clay surfaces with knives and sponges | "Fettling the seams before it dries." |
| Sgraffito | Scratching through a layer of slip to reveal the clay beneath | "I did sgraffito birds on the bowl." |
| Mishima | Inlaying slip into carved lines | "Mishima lines in white on dark clay." |
| Underglaze | Colored decoration applied under a clear glaze | "Painted with underglaze, then clear over it." |
| Wax resist | Wax painted on a pot to keep glaze off | "Wax the foot so it won't stick." |
| Kiln wash | Coating on kiln shelves to protect them from glaze drips | "Re-coat the shelf with kiln wash." |
| Pyrometric cone | A small pyramid that bends at a given heat, used to check firing | "The cone bent right on time." |
| Heatwork | The combined effect of temperature and time | "Slow firing gives more heatwork." |
| Quartz inversion | The sudden change in quartz crystals near 1,063 F | "Go slow through the quartz inversion." |
| Dunting | Cracking as a piece cools too quickly | "Two mugs dunted when I opened it early." |
| Crazing | Fine cracks in the glaze surface | "It's crazed, but it looks kind of pretty." |
| Shivering | Glaze flaking off in slivers, often on rims | "The glaze is shivering off the rim." |
| Crawling | Glaze pulling back into beads, leaving bare clay | "The glaze crawled on the shoulder." |
| Pinholing | Tiny holes in the glaze surface | "There are pinholes in the celadon." |
| Blistering | Bubbles or craters in the glaze | "Blisters mean it was fired too hot or too fast." |
| S-crack | A spiral-shaped crack in a pot's base | "My base S-cracked again." |
| Warping | A piece bending out of shape as it dries or fires | "The plate warped in the bisque." |
| Slumping | A piece sagging in the kiln from heat | "The porcelain slumped at cone 10." |
| Wabi-sabi | A Japanese view that finds beauty in imperfection | "I love the wobble; it's wabi-sabi." |
| Kintsugi | Repairing broken pottery with lacquer and gold | "She mended the bowl with kintsugi." |
| Raku | A fast firing where hot pieces are pulled out and reduced in combustibles | "Raku day is a party." |
| Celadon | A pale green glaze, often from iron | "Celadon over porcelain is my favorite." |
| Tenmoku | A dark, iron-rich glaze, black to brown with rust edges | "Tenmoku breaks rusty on the rim." |
| Shino | A thick, often creamy or orange carbon-trapping glaze | "Shino, always shino." |
| Tin glaze | An opaque white glaze made with tin oxide | "Majolica is tin glaze on earthenware." |
| Majolica | Colorful tin-glazed earthenware | "Majolica bowls in bright colors." |
| Slip casting | Pouring liquid clay into a plaster mold | "The cups are slip cast, not thrown." |
| Slab | A rolled, flat sheet of clay used to build | "Slab-built trays are my thing." |
| Coil | A rope of clay stacked to build walls | "Coil-built pots are slow but beautiful." |
| Pinch pot | A pot formed by pinching a ball of clay | "Kids start with pinch pots." |
| Extruder | A machine that pushes clay through a shaped opening | "I made handles with the extruder." |
| Slab roller | A machine that rolls clay into even slabs | "I ran the slab roller all day." |
| Banding wheel | A turntable for decorating and handbuilding | "Set it on the banding wheel to carve." |
| Rib | A curved tool for smoothing and shaping clay | "A rib evens the wall." |
| Kiln load | A batch of pieces fired together | "There's a bisque load going Thursday." |
| Firing schedule | The planned rise, hold and fall of kiln temperature | "I use a slow-cool schedule." |
| Glaze fit | How well a glaze's shrinkage matches the clay's | "It's a fit issue, not a recipe issue." |
| Functional ware | Pottery made to be used, like mugs and bowls | "I mostly make functional ware." |
| Seconds | Pieces with small flaws sold at a discount | "These mugs are seconds." |
| Community studio | A shared studio where members rent space and use equipment | "I have a shelf at the community studio." |
| Atmospheric firing | Firing where flame, ash or vapor shapes the surface | "Atmospheric firing is unpredictable in the best way." |
| Anagama | A long, sloping Japanese-style wood-fired kiln | "They fire the anagama for four days." |

## 4. Talk Track scenarios (8)

Each scenario: setting, her opening line, what it means, three replies (good, meh, cringe) with coach notes, and a full `talk-track` payload that validates against `talk-track.schema.json`. Voice: warm, playful, never about her; the coach rewards curiosity and honest gaps over bluffing.

### 4.1 Kiln opening morning (`tt-kiln-morning`)

- **Setting:** She texts on the morning she opens a kiln.
- **Her line:** "Kiln's open! Six mugs, two casualties. Cracked bases."
- **Meaning:** Most survived, two failed, and she has a diagnosis in mind.
- **Replies:** Good: "Oh no, but four survived! What do you think caused the base cracks?" Meh: "Sorry to hear that." Cringe: "Guess you're not very good at it yet."

```json
{
  "title": "Kiln opening morning",
  "setting": "She texts you the morning she unloads the kiln.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Kiln's open! Six mugs, two casualties. Cracked bases.",
      "replies": [
        { "id": "ask-cause", "text": "Four made it! What do you think happened to the two?", "smoothDelta": 22, "theirResponse": "Honestly? I think I rushed the drying. I love that you asked.", "coachNote": "Curious and kind. She gets to diagnose her own pieces." },
        { "id": "sorry", "text": "Sorry to hear that.", "smoothDelta": 3, "theirResponse": "Thanks. It happens.", "coachNote": "Kind but closed. Add one question next time." },
        { "id": "skill", "text": "Maybe you're just not good at it yet.", "smoothDelta": -18, "theirResponse": "...Wow. Okay.", "coachNote": "A fumble. Cracks are rarely a skill verdict." }
      ]
    },
    {
      "theirMessage": "Base cracks usually mean the floor wasn't compressed or it dried too fast. Mine was both, I think.",
      "replies": [
        { "id": "compress", "text": "Compressed the floor? Is that pressing the clay down while you throw?", "smoothDelta": 20, "theirResponse": "Yes! You pressed it in with a rib so the particles line up. Nice.", "coachNote": "You asked what a term means instead of nodding along." },
        { "id": "same", "text": "Yeah, I always have that problem too.", "smoothDelta": -15, "theirResponse": "You throw pots?", "coachNote": "Don't claim what you haven't done." },
        { "id": "next", "text": "What's your plan for the next batch?", "smoothDelta": 14, "theirResponse": "Slower drying under plastic and firmer floors.", "coachNote": "Invites her to talk about improvement." }
      ]
    }
  ],
  "closingNote": "In pottery, 'what do you think happened?' beats 'sorry'. Diagnosis is what potters love to talk about."
}
```

### 4.2 "It cracked" (`tt-cracked`)

- **Setting:** She is upset about a piece that broke before it ever got glazed.
- **Her line:** "My favorite bowl cracked in the bisque. I spent four hours on it."
- **Meaning:** She lost a piece she cared about and wants sympathy, not a lecture.
- **Replies:** Good: "That stinks. Can you tell where it cracked?" Meh: "It's just a bowl." Cringe: "Just make another."

```json
{
  "title": "It cracked",
  "setting": "She texts you after opening the bisque kiln.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "My favorite bowl cracked in the bisque. I spent four hours on it.",
      "replies": [
        { "id": "empathy", "text": "That really stinks. Four hours is a lot. Can you tell where it cracked?", "smoothDelta": 22, "theirResponse": "Right across the base. Thanks for asking rather than saying it's just a bowl.", "coachNote": "Empathy first, then a diagnostic question." },
        { "id": "just-a-bowl", "text": "It's just a bowl, though.", "smoothDelta": -18, "theirResponse": "It's not just a bowl to me.", "coachNote": "Never shrink something she made." },
        { "id": "remake", "text": "Just make another one!", "smoothDelta": -6, "theirResponse": "Sure, in another four hours.", "coachNote": "It solves the wrong problem." }
      ]
    },
    {
      "theirMessage": "I think it was still a bit damp in the thick part when it went in.",
      "replies": [
        { "id": "damp", "text": "So the moisture couldn't get out fast enough?", "smoothDelta": 20, "theirResponse": "Exactly. Water in thick spots turns to steam and puts pressure on the clay.", "coachNote": "You reasoned from what she told you." },
        { "id": "gone", "text": "Can it be fixed?", "smoothDelta": 8, "theirResponse": "Not really, but I'll reclaim the clay. Some cracks are repairable, though.", "coachNote": "A fair question, and it invites her to explain." },
        { "id": "expert", "text": "I would have caught that.", "smoothDelta": -20, "theirResponse": "...Have you thrown a pot before?", "coachNote": "That is fake expertise and a little unkind." }
      ]
    }
  ],
  "closingNote": "Cracks are a pottery rite of passage. Ask what happened, listen, and never shrink the loss."
}
```

### 4.3 Her glaze obsession (`tt-glaze`)

- **Setting:** She talks about a glaze test that finally worked.
- **Her line:** "Tile test number 14 finally worked. The celadon breaks perfectly over the iron."
- **Meaning:** After many tests, a glaze combination gave the result she wanted.
- **Replies:** Good: "Fourteen tiles! What makes it 'break' over the iron?" Meh: "Nice." Cringe: "Fourteen? Why not buy glaze?"

```json
{
  "title": "Her glaze obsession",
  "setting": "She texts a photo caption after a glaze test.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Tile test number 14 finally worked. The celadon breaks perfectly over the iron.",
      "replies": [
        { "id": "ask-break", "text": "Fourteen tiles, wow! What does it mean when it 'breaks' over the iron?", "smoothDelta": 22, "theirResponse": "Where the glaze is thinner over an edge or texture, it changes color. Iron shows through. I love that you asked.", "coachNote": "You noticed a term and asked about it." },
        { "id": "nice", "text": "Nice.", "smoothDelta": 3, "theirResponse": "Thanks!", "coachNote": "Sweet but closed." },
        { "id": "buy", "text": "Fourteen? Couldn't you just buy glaze?", "smoothDelta": -18, "theirResponse": "It's not the same. Half the fun is figuring it out.", "coachNote": "Never suggest that her craft is unnecessary." }
      ]
    },
    {
      "theirMessage": "I keep notes on every test, thickness and firing. It's like a lab notebook.",
      "replies": [
        { "id": "notebook", "text": "That sounds fun. Can I see the tiles sometime?", "smoothDelta": 20, "theirResponse": "I'll show you my wall of tiles. It's a lot.", "coachNote": "Warm, honest and it invites a next step." },
        { "id": "fake", "text": "I do the same with my recipes.", "smoothDelta": -12, "theirResponse": "Oh, do you make glazes?", "coachNote": "Don't stretch a claim into a lie." },
        { "id": "why", "text": "Why does thickness change the color?", "smoothDelta": 16, "theirResponse": "Thin coats let the clay and iron show; thick coats build up the glaze color. It's the whole game.", "coachNote": "A why-question shows you want to understand." }
      ]
    }
  ],
  "closingNote": "Glaze people love their tiles. A curious question about a test beats a compliment."
}
```

### 4.4 "Come to the studio" (`tt-studio-invite`)

- **Setting:** She invites you to visit her community studio.
- **Her line:** "Come by the studio Saturday! I'll show you my wheel and we can peek at the kiln."
- **Meaning:** She is inviting you into her world; she wants you to be curious, not expert.
- **Replies:** Good: "I'd love that. I've never touched clay. Show me?" Meh: "Maybe." Cringe: "Sure, I'll show you how it's done."

```json
{
  "title": "Come to the studio",
  "setting": "She invites you to her community studio.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Come by the studio Saturday! I'll show you my wheel and we can peek at the kiln.",
      "replies": [
        { "id": "honest", "text": "I'd love that. I've never touched clay, so you'll have to teach me.", "smoothDelta": 24, "theirResponse": "Perfect. I'll set you up with a lump and we'll start with pinch pots.", "coachNote": "Honest, curious and it makes her the expert." },
        { "id": "maybe", "text": "Maybe, I'll see.", "smoothDelta": -4, "theirResponse": "Okay, no pressure.", "coachNote": "Vague answers deflate a real invitation." },
        { "id": "show-off", "text": "Sure, I'll show you how it's done.", "smoothDelta": -20, "theirResponse": "Ha. Okay. Bring an apron.", "coachNote": "Fake expertise, and a bit of a dare." }
      ]
    },
    {
      "theirMessage": "Wear clothes you don't mind getting muddy. And no rings, they get in the way.",
      "replies": [
        { "id": "wet", "text": "Noted. Is there anything I should not touch, like the kiln?", "smoothDelta": 20, "theirResponse": "Kiln stays hands-off unless the monitor says otherwise. Good instinct.", "coachNote": "Respecting safety and the studio's rules shows maturity." },
        { "id": "eager", "text": "Can I try the wheel?", "smoothDelta": 8, "theirResponse": "Maybe once you've tried a pinch pot. The wheel is humbling.", "coachNote": "Enthusiastic, but be ready for a slow start." },
        { "id": "skip", "text": "Is the kiln hot? Can I open it?", "smoothDelta": -14, "theirResponse": "Definitely not. Never open a kiln you did not fire.", "coachNote": "A safety misstep. Ask first, and leave the kiln alone." }
      ]
    }
  ],
  "closingNote": "Saying 'teach me' is the most attractive thing you can say. Respect the studio rules, especially around kilns."
}
```

### 4.5 Handmade versus cheap (`tt-handmade-price`)

- **Setting:** You are shopping together and spot a mug at a craft fair.
- **Her line:** "That mug is $45 and I would buy it in a second. Do you know how much work goes in?"
- **Meaning:** She values the labor, kiln loss and materials behind handmade pottery.
- **Replies:** Good: "I would not have guessed. Walk me through what goes into one." Meh: "That seems like a lot." Cringe: "I can get one for $5 at the store."

```json
{
  "title": "Handmade versus cheap",
  "setting": "You are at a craft fair together.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "That mug is $45 and I'd buy it in a second. Do you know how much work goes in?",
      "replies": [
        { "id": "walk", "text": "Honestly, no. Walk me through what goes into one?", "smoothDelta": 24, "theirResponse": "Wedge, throw, trim, handle, dry, bisque, glaze, glaze fire. And some don't survive.", "coachNote": "Honest curiosity invites her explanation." },
        { "id": "much", "text": "That does seem like a lot for a mug.", "smoothDelta": -6, "theirResponse": "Only if you don't count the hours and the kiln.", "coachNote": "Understandable, but you can ask instead." },
        { "id": "store", "text": "I can get one for five bucks at the store.", "smoothDelta": -18, "theirResponse": "You can. It won't be the same mug.", "coachNote": "That dismisses the craft." }
      ]
    },
    {
      "theirMessage": "And the maker probably lost a few pieces in the kiln that we'll never see.",
      "replies": [
        { "id": "loss", "text": "So the price covers the ones that cracked, too?", "smoothDelta": 22, "theirResponse": "Exactly. Loss rate is part of the price.", "coachNote": "You reasoned it out. She notices." },
        { "id": "second", "text": "Would you buy one that's a seconds piece?", "smoothDelta": 12, "theirResponse": "Yes, if it's a small flaw. Seconds are great for using every day.", "coachNote": "A fair question that shows you are engaged." },
        { "id": "cheap", "text": "Can't they just make more to lower the price?", "smoothDelta": -8, "theirResponse": "It doesn't work like a factory.", "coachNote": "Fair curiosity, but frame it as a question." }
      ]
    }
  ],
  "closingNote": "Handmade prices include hours, materials, kiln time and pieces that did not survive. Curiosity earns you a lot more than a comparison shop."
}
```

### 4.6 Watching the Throw Down (`tt-throwdown`)

- **Setting:** She wants to watch a pottery competition show with you.
- **Her line:** "Tonight's the show where they throw on the wheel under time pressure. It's my favorite episode."
- **Meaning:** She is sharing something she loves, and wants your reaction.
- **Replies:** Good: "I'm in. No spoilers, but what should I watch for?" Meh: "Sure, if there's nothing else on." Cringe: "Can't they just use a machine?"

```json
{
  "title": "Watching the Throw Down",
  "setting": "She invites you to watch a pottery competition together.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "Tonight's the one where they throw on the wheel under time pressure. It's my favorite kind of episode.",
      "replies": [
        { "id": "watch-for", "text": "I'm in. No spoilers, but what should I watch for?", "smoothDelta": 22, "theirResponse": "Watch the centering. You can tell who's calm by how still the clay looks.", "coachNote": "Curious, spoiler-safe, and it lets her teach." },
        { "id": "sure", "text": "Sure, if nothing else is on.", "smoothDelta": 0, "theirResponse": "Well, okay.", "coachNote": "Lukewarm. Show some enthusiasm." },
        { "id": "machine", "text": "Can't they just use a machine?", "smoothDelta": -18, "theirResponse": "That's... the whole point of doing it by hand.", "coachNote": "Comes across as dismissive." }
      ]
    },
    {
      "theirMessage": "That potter's cylinder collapsed! Too much water.",
      "replies": [
        { "id": "water", "text": "Too much water makes the walls weak?", "smoothDelta": 20, "theirResponse": "Yes! Wet clay slumps. Water is a lubricant, but you don't want a swimming pool.", "coachNote": "You linked what you saw to what you learned." },
        { "id": "cheer", "text": "Oh no, poor thing.", "smoothDelta": 6, "theirResponse": "It happens to everybody.", "coachNote": "Kind, but not curious." },
        { "id": "judge", "text": "I could have done better.", "smoothDelta": -16, "theirResponse": "Have you thrown before?", "coachNote": "Don't claim what you haven't done." }
      ]
    }
  ],
  "closingNote": "Watching a competition together is about her joy. Ask what she is watching for and keep spoilers off the table."
}
```

### 4.7 Is it food safe? (`tt-food-safe`)

- **Setting:** She is giving you a handmade bowl and mentions the glaze.
- **Her line:** "This bowl is for you. I tested the glaze and it's food safe, so use it every day."
- **Meaning:** She knows her glaze and wants you to use the bowl.
- **Replies:** Good: "Thank you! What makes it food safe, in your studio's words?" Meh: "Thanks, it's pretty." Cringe: "Well, is it actually food safe though?"

```json
{
  "title": "Is it food safe?",
  "setting": "She gives you a handmade bowl.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "This bowl is for you. I tested the glaze and it's food safe, so use it every day.",
      "replies": [
        { "id": "thanks-ask", "text": "Thank you, I love it! What did you do to test the glaze?", "smoothDelta": 22, "theirResponse": "The recipe is a well-known food-safe one, and my studio fires it fully. I keep notes.", "coachNote": "Grateful, and the question is friendly." },
        { "id": "pretty", "text": "Thanks, it's really pretty.", "smoothDelta": 4, "theirResponse": "I'm glad you like it.", "coachNote": "Sweet, but one question more would help." },
        { "id": "gotcha", "text": "Well, is it actually food safe though?", "smoothDelta": -16, "theirResponse": "Yes. I just told you.", "coachNote": "Sounds like doubt. Ask how, not whether." }
      ]
    },
    {
      "theirMessage": "It's fine in the dishwasher, but I hand-wash mine. And no big temperature swings.",
      "replies": [
        { "id": "shock", "text": "Because a sudden change could crack it?", "smoothDelta": 20, "theirResponse": "Yes, thermal shock. Ceramic doesn't love going from freezer to hot oven.", "coachNote": "You connected care to what you know." },
        { "id": "micro", "text": "Can I microwave it?", "smoothDelta": 10, "theirResponse": "Usually yes for my clay, but I'd check with me for each piece.", "coachNote": "A fair practical question." },
        { "id": "boil", "text": "I'll use it for boiling soup on the stove.", "smoothDelta": -14, "theirResponse": "Not on the stove, please. That's not what it's made for.", "coachNote": "Ask before assuming what a piece can do." }
      ]
    }
  ],
  "closingNote": "Thank her, ask how she thought about the glaze, and ask about care instead of assuming."
}
```

### 4.8 The wheel won't cooperate (`tt-wheel-wobble`)

- **Setting:** She is frustrated after a bad wheel night.
- **Her line:** "I could not center anything tonight. Everything wobbled and then collapsed."
- **Meaning:** A frustrating session; she wants understanding.
- **Replies:** Good: "Ugh, that's rough. Does that happen to everyone?" Meh: "Try again tomorrow." Cringe: "Maybe wheel throwing is not for you."

```json
{
  "title": "The wheel won't cooperate",
  "setting": "She texts after a frustrating night at the wheel.",
  "startingSmooth": 50,
  "exchanges": [
    {
      "theirMessage": "I could not center anything tonight. Everything wobbled and then collapsed.",
      "replies": [
        { "id": "empathy", "text": "Ugh, that sounds rough. Is centering the hardest part?", "smoothDelta": 22, "theirResponse": "By far. Some nights it just clicks and some nights it doesn't.", "coachNote": "Sympathy, then a question that invites her to explain." },
        { "id": "tomorrow", "text": "Try again tomorrow.", "smoothDelta": 2, "theirResponse": "Yeah, I will.", "coachNote": "Fine, but a bit closed." },
        { "id": "quit", "text": "Maybe the wheel isn't for you.", "smoothDelta": -20, "theirResponse": "...Excuse me?", "coachNote": "Never suggest quitting." }
      ]
    },
    {
      "theirMessage": "I think my clay was too soft. And I was tired.",
      "replies": [
        { "id": "soft", "text": "Does soft clay make it harder to control?", "smoothDelta": 20, "theirResponse": "Yes. It's floppy and grabs. A firmer clay is easier to center.", "coachNote": "You asked a thoughtful question about her clay." },
        { "id": "coffee", "text": "Get some sleep and try again.", "smoothDelta": 8, "theirResponse": "Good plan.", "coachNote": "Caring, though it does not engage her craft." },
        { "id": "fix", "text": "You should just use stiffer clay.", "smoothDelta": -6, "theirResponse": "Thanks, I know.", "coachNote": "Advice she did not ask for. Ask instead." }
      ]
    }
  ],
  "closingNote": "A frustrating night is not a verdict. Sympathy first, questions second, advice almost never."
}
```

## 5. Talk Track roster at launch (18)

1. Kiln opening morning (`tt-kiln-morning`, full above) 2. It cracked (`tt-cracked`, full) 3. Her glaze obsession (`tt-glaze`, full) 4. Come to the studio (`tt-studio-invite`, full) 5. Handmade versus cheap (`tt-handmade-price`, full) 6. Watching the Throw Down (`tt-throwdown`, full) 7. Is it food safe? (`tt-food-safe`, full) 8. The wheel won't cooperate (`tt-wheel-wobble`, full) 9. Her craft fair weekend 10. The studio shelf war 11. Raku day 12. She switched to porcelain 13. A gift she made you (care and use) 14. Her favorite maker 15. The museum visit (how to look at a pot) 16. Cone 6 versus cone 10 debate at a party 17. She's thinking of buying a kiln (listen, ask about ventilation and rules; never coach installation) 18. She sold her first piece.

## 6. Asset needs (all `original-swoond`)

- **Procedural diagram ids** requested from the native app: `mug-anatomy`, `wheel-anatomy`, `kiln-glaze-stacking`, `kiln-bisque-stacking`, `firing-curve-labeled`, `foot-cross-section`, `drying-cross-section`, `pot-forms-lineup`.
- **Original vector images:** `pottery/visual/form-pitcher.svg`, `pottery/visual/defect-crazing.svg`, `pottery/visual/stage-bone-dry-mug.svg`, `pottery/visual/thrown-rings-interior.svg`, plus the rest of the forms, tools, techniques and defects sets (about 70).
- **Audio:** `pottery/audio/ring-test-sound-bisque.m4a`, `pottery/audio/ring-test-cracked-bisque.m4a`, `pottery/audio/kiln-pinging-crazing.m4a`; synthesized or recorded in-house.

## 7. Voice and safety notes

- Voice: warm, playful, never about her pieces or her studio. Jokes target the learner's ignorance ("no, the kiln is not an oven"), never a cracked pot.
- Safety items (`studio-safety`, `fire-05`, `fail-05`, `safe-06`, atmospheric-firing lessons and any glaze or dust content) always carry a `safetyNote`, never use timers, and never coach a learner to do something dangerous at home.
- Cultural items (`trad-01` to `trad-04`) name traditions and makers as facts and never trivialize sacred or ceremonial work.
