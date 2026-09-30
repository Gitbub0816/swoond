# Light Direction Lab (`photo.light.direction-lab.v1`)

## 1. Identity & versioning
| Field | Value |
|---|---|
| simulationId | `photo.light.direction-lab.v1` |
| simulationVersion | `1.0.0` |
| Spec status | draft |
| Contract versions | Bridge `1.0.x`; sim-definition `1.0.x` (scenario-driven) |
| Authors / date | Course design agent (Sonnet) / 2026-09-30 |
| Changelog | 1.0.0: initial spec |

## 2. Course & lesson links
- `courseId` `photography`; `unitId` `light-and-flash` (lessons `lf-02` primary, difficulty 2, direction and patterns; `lf-03`, difficulty 3, size and distance); `branch-portrait` (`port-04`, difficulty 3, face patterns and catchlights).
- CDS row: section 12, "`lf-02`, `lf-03`, `port-04`: light direction". Manifest: `unitySimulations[2]`.
- Prerequisite concepts: `hard-soft-light`, `light-direction`, `exposure` (for `lf-03`, `inverse-square` is introduced in the sim's primer).

## 3. Learning objective(s) & concepts taught
- **Objective:** "You can place one light to sculpt a face the way you want (soft or dramatic, flat or shaped), and say what moving it closer, bigger or higher does."

| conceptId | Term | After this the learner can... |
|---|---|---|
| `light-direction` | Light direction | Predict where shadows fall from azimuth and elevation. |
| `lighting-patterns` | Lighting patterns | Name loop, butterfly, Rembrandt, split, rim and under-lighting from the picture and from the light position. |
| `rembrandt-lighting` | Rembrandt lighting | Place a light about 45 degrees to the side and about 45 degrees up to get the triangle of light on the shadow cheek. |
| `split-lighting` | Split lighting | Place a light at about 90 degrees to light half the face. |
| `butterfly-lighting` | Butterfly (paramount) lighting | Place a light in front and above for a butterfly shadow under the nose. |
| `light-size-distance` | Source size and distance | Say that a bigger or closer source is softer, because what matters is how large it looks from the subject. |
| `inverse-square` | Inverse-square falloff | Predict that doubling the light's distance quarters the light; use it to darken backgrounds. |
| `hard-soft-light` | Hard and soft light | Read shadow-edge width as softness. |
| `catchlight` | Catchlight | Place a light so the eyes show a reflection at about 10 to 11 or 1 to 2 o'clock. |
| `fill-light` | Fill light | Use a reflector to lift shadows to a chosen ratio (used at L4 and up; taught in `lf-04`). |

- **Should NOT need to learn here:** flash power settings, colour, skin retouching, brand names of modifiers; exposure is held constant by the sim (a note says "brightness is auto-matched").

## 4. Why Unity (tier justification)
- **Signals:** *spatial reasoning on a 3D form* (a light moving on a sphere around a face) and *live cause-and-effect* across four continuous variables: azimuth, elevation, size, distance.
- **Closest native:** `visual-id` on 8 to 12 pre-rendered lighting positions of one bust, plus `estimate-slider` for softness and falloff. That teaches the *names* well. What it teaches worse: the learner never sees a shadow edge soften as a source grows, or a triangle form as the light rises; they compare finished results rather than causing them. **This is the weakest of the three Tier A cases.**
- **Decision rule (P-09 style):** build last; run a small playtest of this sim against `lf-02-native` (below). If a native learner who did the fallback identifies patterns and predicts softness as well as a sim learner (within 5 percentage points on the CDS review items), downgrade to native and drop `SoftLight` from the Game Kit request.
- **Native fallback `lf-02-native`** (complete on its own): a 12-frame bust set from the sim's own renderer (`original-swoond`): 8 `visual-id` (name the pattern), 4 `binary-call` (hard or soft), 3 `estimate-slider` (how many stops darker at twice the distance; source size vs distance), 3 `hotspot-tap` on a top-down light diagram (tap where the light must go for a Rembrandt look).
- **Justification: moderate, conditional.**

## 5. Player fantasy & core loop
- **Fantasy:** "You have one light and one model. Shape the face."
- **Core loop:**
  1. Brief ("Make it dramatic: half the face in shadow") with a top-down **light map** (subject, camera, light on a circle) and a small live preview.
  2. Learner drags the **light** around a dome (azimuth and elevation), and sets **source size** (small bare bulb, softbox, big octabox, window) and **distance** (slider). Preview updates live; at L4+ a **reflector** and at L5 a second (**rim**) light are available.
  3. Learner taps **Shoot** (the decisive interaction).
  4. Execute: evaluation; a flash pop.
  5. Freeze: pattern name appears on the face with callouts (triangle, catchlight, shadow-edge width, falloff numeral); explanation; line to say.
- **Session:** about 3 minutes, 3 rounds (default), up to 6.

## 6. Scene & entities
- **Environment:** `photo_stage` (shared, new) in "studio" mode: dark grey backdrop, floor disc, one bust and one prop stand.
- **Cameras:** `photo-rig` (fixed at 1.5 m, eye height, 85 mm equivalent, frames the head), `light-map` (top-down inset), `side` (elevation inset).
- **Entity table:**

| id | Game Kit primitive / module | Role | Key parameters |
|---|---|---|---|
| `stage` | `photo_stage` | Studio | backdrop distance 1.5 m behind subject |
| `bust` | `Character` (stylised head and shoulders) | Model | head turn (0 or +-30 degrees), nose depth, cheek and brow relief |
| `prop` | `PhysicsObject` | Fabric block, wood block (product scenarios) | grain amplitude |
| `key` | `SoftLight` (new) | Key light | azimuth, elevation, distance, size class |
| `rim` | `SoftLight` | Second light (L5) | as above, back hemisphere |
| `reflector` | `Highlight`-style overlay + fill term | Fill card (L4+) | fill 0, 0.25, 0.5 |
| `lightMap` | `CameraRig` `top-down` + `DistanceRing` (GK-13) | Position feedback | drag handle >= 44 pt |
| `goal` | `Objective` (`light_goal`, sim-local) | Evaluate pattern, softness, ratio, catchlight, texture | section 11 |
| `explain`, `score`, `hint`, `replay` | kit | | |
- **Reused:** GK-13 `DistanceRing`, GK-19 `CameraRig` presets (`top-down`, `side-on-tilted`), `Highlight`, `Explanation`, `Score`, `Hint`, GK-12 `choose_target` (scenario `ls-04` fix choice), GK-14 `ResponsibilityOverlay` style for the light-position zones.
- **New:** `SoftLight` (a directional or spot light with an angular source size, physically soft penumbra by PCSS-style blocker search and 1/d^2 falloff; mobile budget in section 19), `photo_stage`, `PhysicalCamera` (shared), objective `light_goal`. Reuse plan: any lighting-related course (cooking photography, pottery glazes) or a future video-lighting lesson.
- **Layout (portrait):**
```
+--------------------------+
| brief card               |
+--------------------------+
|  live preview (bust)     |  top 50%
+--------------------------+
| light map (top-down) o   |  camera at bottom, light dot on ring
| side inset (elevation)   |
+--------------------------+
| [size: bare|soft|big|window] |
| distance ----o----       |
| [reflector] (L4+)        |
|           [ Shoot ]      |
+--------------------------+
```

## 7. Controls (touch)
| Input | Gesture | Target | Hit size | Feedback |
|---|---|---|---|---|
| Move light | Drag the light dot on the top-down ring (azimuth) and the side arc (elevation) | Drag handles | >= 44 pt | Preview and shadows update live; tick haptic each 15 degrees |
| Source size | Tap chips: bare bulb (0.05 m), softbox (0.6 m), octabox (1.2 m), window (1.5 m; fixed position scenarios) | Chip row | 44 x 72 pt each | Shadow edge softens live |
| Distance | Drag slider (0.4 to 3.0 m) or steppers (0.1 m) | Slider | 44 pt | Falloff numeral and brightness (auto-matched exposure shown as EV note) |
| Reflector | Tap toggle then choose 25% or 50% | Chip | 44 x 88 | Shadow side lifts |
| Rim light (L5) | Tap "Add rim", drag second dot | Handle | 44 pt | |
| Hint | Tap | Chip (levels 1 to 3) | 44 x 80 | Shows the target zone on the ring or the needed change |
| Shoot / Next | Tap | Primary pill | 56 pt | |
- **Tap-only alternative:** the ring is also operable by 12 azimuth chips (every 30 degrees) and 5 elevation chips (0, 20, 40, 60, 80); all values spoken.
- Portrait. Native draws hearts, paywall, exit confirmation.

## 8. Step-by-step flow with states
| State | Entry | What happens | Exit | Events |
|---|---|---|---|---|
| Loading | `launch` | Validate config; build studio; compile light shader; load scenarios | Ready/error | `ready` |
| Intro | ready | Brief card; light map shown | Playing | `progress` |
| Playing | intro | Learner moves light and sets size, distance (and reflector, rim) | Shoot | none |
| Decision | Shoot | Record settings and latency | Executing | none |
| Executing | decision | Classify pattern; evaluate goal; flash pop | Freeze | none |
| Freeze | result | Ease to 0; callouts on the face; shadow-edge zoom; falloff numeral | Explain | `checkpoint round-N-freeze` |
| Explain | freeze | Card; "show the pattern that would fit" preview | Next | `checkpoint round-N` |
| Summary | last | Score count-up | Done | `progress 1.0` |
| Done | summary | `result`, `requestExit` | end | `result`, `requestExit` |
| Paused / Aborted | native | Freeze; partial result on abort | resume/end | `result`, `requestExit` |

## 9. Difficulty levels 1-5
| Param | L1 | L2 | L3 | L4 | L5 |
|---|---|---|---|---|---|
| Free variables | azimuth, elevation | + size | + size, distance | + reflector | + rim light |
| Light map with target zone | zone drawn | zone on hint | ring only | ring only | ring only |
| Live pattern label | shown | shown | shown | freeze only | freeze only |
| Numerals (angular size, falloff, ratio) | shown | shown | freeze only | freeze only | freeze only |
| Goal types in pool | `pattern` | + `mood` | + `softness`, `falloff`, `catchlight` | + `fix`, `window`, `product` | + `separation` (two lights) |
| Head turn | 0 | 0 | 0 | +-30 possible | +-30 |
| Hints | 3 | 2 | 1 | 0 | 0 |
- Default for `lf-02`: 2; `lf-03`: 3; `port-04`: 3 (config).

## 10. Configuration schema
```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "title": "photo.light.direction-lab.v1 configuration",
  "type": "object",
  "additionalProperties": false,
  "properties": {
    "seed": { "type": "integer", "minimum": 0, "maximum": 2147483647 },
    "scenarioSetId": { "type": "string", "enum": ["light-starter", "light-size-distance", "light-portrait", "light-mixed"], "default": "light-starter" },
    "scenarioCount": { "type": "integer", "minimum": 3, "maximum": 6, "default": 3 },
    "showTargetZone": { "type": ["boolean", "null"], "default": null, "description": "Null = decided by difficulty." },
    "showLivePatternLabel": { "type": ["boolean", "null"], "default": null, "description": "Null = decided by difficulty." },
    "shadowQuality": { "type": "string", "enum": ["auto", "high", "low"], "default": "auto", "description": "Low uses fewer blocker-search taps on old devices." }
  }
}
```
Valid: `{ "seed": 5, "scenarioSetId": "light-starter", "scenarioCount": 3 }`. Invalid configuration yields `CONFIG_INVALID`.

## 11. Scenario data set
- **File:** `Scenarios/light-v1.json`, bundle `sim-photo-light`. Sets: `light-starter` = tags `pattern`; `light-size-distance` = `softness`, `falloff`; `light-portrait` = `face`; `light-mixed` = all. Deterministic per seed (order and left-right mirroring; the classifier is mirror-symmetric).
- **N = 12 scenarios.** Shape:
```json
{ "scenarioId": "ls-01", "subject": "bust", "headTurnDeg": 0,
  "goal": { "type": "pattern", "pattern": "rembrandt", "softnessMax": "medium" },
  "free": ["azimuth", "elevation", "size", "distance"], "fixed": {},
  "tags": ["pattern", "face"], "teaches": ["rembrandt-lighting", "light-direction"] }
```
- **Maths and classifier (pure functions; `SoftLight`, golden fixtures):**
  - Azimuth theta in degrees from the camera axis (0 in front, positive to the subject's left as seen from camera, 90 side, 180 behind); elevation phi from eye level (0) to overhead (90); relative azimuth theta_rel = theta minus head turn.
  - Angular size alpha = 2 x atan(D / (2 d)) for source size D (m) and distance d (m). Softness class: `hard` alpha < 10 degrees, `medium` 10 to 35, `soft` over 35 degrees. Shadow-edge (penumbra) width at the nose = D x r / (d - r) with r = 0.04 m relief; reported in mm.
  - Falloff: relative illuminance at distance x from the light = 1 / x^2. Background falloff in stops = log2((d + 1.5)^2 / d^2) for the backdrop 1.5 m behind the subject.
  - Pattern (|theta_rel| symmetric; phi in degrees): `flat` |theta_rel| < 15 and phi < 25; `butterfly` |theta_rel| < 15 and 35 <= phi <= 65; `loop` 15 <= |theta_rel| < 40 and 25 <= phi <= 55; `rembrandt` 40 <= |theta_rel| <= 65 and 30 <= phi <= 60; `split` 80 <= |theta_rel| <= 100 and phi < 30; `rim` 120 <= |theta_rel| <= 160 and 10 <= phi <= 50; `top` phi > 70 (raccoon eyes flag); `under` phi < -10 (ghoulish); anything else is `transitional` (no name, no credit for pattern goals). Short vs broad (head turned): light on the side of the face turned away from camera is `short`, toward camera is `broad`.
  - Catchlight position (clock): angle = atan2(sin(theta) x cos(phi), sin(phi)); hours = angle / 30 degrees (12 o'clock straight up); visible when |theta| < 75 and 5 < phi < 80. Target bands: 10 to 11 o'clock or 1 to 2 o'clock (angle magnitude 30 to 60 degrees).
  - Texture visibility for a surface (product blocks) = clamp(1 - cos(grazing angle))-based: high when |theta| >= 70, phi <= 25, alpha < 15; low when frontal (|theta| < 20) or alpha > 40.
  - Shadow-to-key ratio with reflector fill f (0, 0.25, 0.5): ratio = 1 / f (4:1 = 2 stops, 2:1 = 1 stop); with no fill, ratio is "deep".
- **Scenarios and acceptance (bands; all computed from the maths above):**

| scenarioId | Brief | Free variables | Passing band | Teaches | Tags |
|---|---|---|---|---|---|
| `ls-01` | "A classic painterly portrait" | azimuth, elevation, size, distance | pattern `rembrandt` (theta 40 to 65, phi 30 to 60), alpha <= 35 | `rembrandt-lighting`, `light-direction` | pattern, face |
| `ls-02` | "Flattering and soft for a beauty shot" | all four | pattern `butterfly` or `loop`, class `soft` (alpha > 35; for example octabox 1.2 m at 0.9 m gives alpha 67) | `butterfly-lighting`, `hard-soft-light` | pattern, face |
| `ls-03` | "Dramatic: half the face in shadow" | all four | pattern `split` (theta 80 to 100, phi < 30), class `hard` | `split-lighting`, `lighting-patterns` | pattern, face |
| `ls-04` | "Fix the raccoon eyes" (start phi 80) | azimuth, elevation | move to pattern not `top`, phi 20 to 60, catchlight visible | `light-direction`, `catchlight` | fix, face |
| `ls-05` | "Make her hair pop off the background" (two lights) | key and rim | key pattern `loop` or `rembrandt`, rim `rim` (theta 120 to 160, phi 10 to 50) | `lighting-patterns` | separation |
| `ls-06` | "Slim the face with short lighting" (head turned 30 degrees) | azimuth, elevation, size | light on the side turned away from camera, pattern `loop` or `rembrandt` relative to the face, alpha >= 20 | `lighting-patterns`, `light-direction` | pattern, face |
| `ls-07` | "Make the shadows softer without moving the light's angle" (theta, phi locked at 45 and 40) | size, distance | alpha >= 40 (for example 0.6 m at 0.8 m gives 41; 1.2 m at 1.5 m gives 43) | `light-size-distance`, `hard-soft-light` | softness |
| `ls-08` | "Make the background two stops darker" (angle locked) | distance | background falloff >= 2 stops: d <= 1.5 m (0.75 m gives 3.2 stops) | `inverse-square`, `light-size-distance` | falloff |
| `ls-09` | "Show the fabric's texture" (product) | azimuth, elevation, size, distance | texture visibility high: theta >= 70, phi <= 25, alpha < 15 | `light-direction`, `hard-soft-light` | product |
| `ls-10` | "Bring the eyes to life" | azimuth, elevation | catchlight visible in a 10 to 11 or 1 to 2 o'clock band (theta 20 to 60 with phi 20 to 50 lands in band) | `catchlight`, `light-direction` | catchlight, face |
| `ls-11` | "Window portrait: lift the shadow side to about 2:1" (window fixed at theta 70, size 1.5 m) | subject-to-window distance, reflector | alpha > 35 (distance <= 2.0 m) and ratio 2:1 to 4:1 (fill 0.25 or 0.5) | `fill-light`, `light-size-distance` | window |
| `ls-12` | "Noon sun overhead: rescue the portrait" (sun fixed at phi 75, alpha 0.5 degrees) | modifier choice: 1.2 m diffuser overhead at 1.0 m, open shade, reflector alone | best diffuser or open shade (soft, phi acceptable); reflector alone acceptable only if `top` shadows are filled; direct sun poor | `hard-soft-light`, `fill-light` | fix |
- **Generation rule:** choose a goal and the free variables; define the passing band from the maths; require the passing region to be reachable with at least two distinct control settings at L1 to L3; no band may need finer than 5 degrees in angle or 0.1 m in distance.

## 12. Freeze / explain moments
Voice: cheeky coach, never mean. Titles <= 6 words; bodies <= 45 words.

| id | Trigger | Freeze & callouts | Outcome | Title | Body | Say this |
|---|---|---|---|---|---|---|
| `x-rembrandt-good` | `rembrandt` passed | Triangle of light on the shadow cheek highlighted in gold; light-map angles | Correct | Nice read. The triangle appears. | About 45 degrees to the side and 45 up, the nose shadow meets the cheek shadow and leaves a small lit triangle under the eye. That is the painters' look. | "Rembrandt: the little triangle on the shadow cheek." |
| `x-rembrandt-bad` | Pattern goal missed | Callout naming the pattern you made, and the zone that would work | Incorrect | Not quite. Wrong angle for that look. | You made a different pattern. The name comes from where the light sits: to the side and above for Rembrandt, in front and above for butterfly. Nudge toward the gold zone. | "The angle of the light names the pattern." |
| `x-split-good` | `split` passed | Half-lit face with a centre line | Correct | Nice read. Half and half. | At about 90 degrees the light hits one side only. With a small hard source the edge is crisp, which is why it feels dramatic and a little moody. | "Split lighting: one side lit, one in shadow." |
| `x-soft-good` | Softness goal passed | Shadow-edge zoom: narrow vs wide penumbra in mm | Correct | Nice read. Bigger looks softer. | Softness is how large the light looks from her face. A big source, or the same source moved closer, wraps around and blurs shadow edges. | "Bigger or closer means softer." |
| `x-soft-bad` | Softness goal missed | Angular-size numeral vs target | Incorrect | Not quite. Still hard. | The light still looks small from her face. Move it closer or switch to a bigger source. Moving it away makes it smaller and harder, even if the panel is large. | "Far away, even a big light looks small." |
| `x-falloff-good` | Falloff goal passed | Stops numeral for background | Correct | Nice read. The wall went dark. | Light drops with the square of distance. Close to her, the wall behind is much farther from the light in proportion, so it falls off fast. A near light darkens the background. | "Closer light, darker background: inverse-square." |
| `x-raccoon-good` | `ls-04` fixed | Eye sockets lit; catchlight visible | Correct | Nice read. Eyes are back. | Light from straight overhead drops the brow into shadow over the eyes. Lowering it lit the sockets and gave the eyes a sparkle. | "Overhead light gives raccoon eyes; lower it." |
| `x-catch-good` | Catchlight goal passed | Clock overlay on the eye | Correct | Nice read. Eyes with life. | A small reflection of the light in each eye tells us where the light was. Around 10 to 11 or 1 to 2 o'clock feels natural. | "Catchlights are the sparkle in the eyes." |
| `x-rim-good` | `separation` passed | Bright edge on hair and shoulders | Correct | Nice read. Edge light. | A second light behind and to the side draws a bright edge that lifts the subject off the background. Keep it modest so the key still leads. | "A rim light separates her from the background." |
| `x-texture-good` | Texture goal passed | Raking shadows on fabric | Correct | Nice read. Skimming light. | A light almost sideways across a surface makes tiny bumps cast shadows. That reveals texture. A frontal soft light would hide it. | "Low, sideways light shows texture." |
| `x-fill-good` | Ratio goal passed | Ratio numeral (2:1 or 4:1) | Correct | Nice read. Shadows lifted. | A reflector bounces window light back into the shadow side. A ratio of two to four to one keeps shape without going black. | "Reflector fill keeps some shape and some detail." |
| `x-sun-good` | `ls-12` best | Soft overhead light or shade | Correct | Nice read. Tamed the sun. | The noon sun is tiny and overhead: hard and harsh. A big diffuser or open shade makes the light bigger, and therefore softer, from her face. | "At noon, make the light bigger or find shade." |
| `x-timeout` | L5 optional timer | Auto Shoot | Timeout | Time's up. Let's look. | We shot it as you had it. The explanation shows what would have worked. | "Direction, size and distance together." |

## 13. Scoring & mastery signals
- **Round points:** 1.0 if all parts of the goal pass; 0.6 acceptable when the pattern is right but softness or ratio misses by one class, or when `ls-12` reflector-only fills the shadows; 0.0 otherwise. Hint -0.1 each (floor 0.4 for a pass). Two-light goals score on both lights (mean).
- **accuracy** = rounds with points >= 0.6 / rounds. **Outcome success** = points >= 0.6.
- **Mistake -> conceptId:**

| Mistake | conceptId | Description |
|---|---|---|
| Wrong pattern for `rembrandt` | `rembrandt-lighting` | Light not about 45 degrees to the side and up. |
| Wrong pattern for `split` | `split-lighting` | Light not near 90 degrees. |
| Wrong pattern for `butterfly` or `loop` | `butterfly-lighting` | Light not in front and above. |
| Light too high (top) or too low (under) | `light-direction` | Light elevation created raccoon eyes or ghoulish shadows. |
| Softness goal missed | `light-size-distance` | Did not make the source look larger from the subject. |
| Falloff goal missed | `inverse-square` | Did not use distance to control falloff. |
| No catchlight / wrong band | `catchlight` | Light out of the catchlight zone. |
| Ratio outside band | `fill-light` | Fill too much or too little. |
| Texture missed | `hard-soft-light` | Used frontal or soft light where texture needed skim light. |
| Rim missing or too frontal | `lighting-patterns` | Rim light not behind the subject. |
- **Mastery signals:** `rembrandt` pass -> `rembrandt-lighting` +0.20, `lighting-patterns` +0.10; `split` pass -> `split-lighting` +0.20; `butterfly`/`loop` pass -> `butterfly-lighting` +0.15, `hard-soft-light` +0.10; softness pass -> `light-size-distance` +0.20, `hard-soft-light` +0.10; falloff pass -> `inverse-square` +0.20; `catchlight` pass -> `catchlight` +0.20; `window` pass -> `fill-light` +0.15, `light-size-distance` +0.10; `separation` pass -> `lighting-patterns` +0.20; `light-direction` +0.10 on any direction-only pass; mistakes -0.15 to mapped concept; cap +-0.30 per concept per session; hints halve positives (native).
- **Result mapping:** `outcomes[]` (`round-N`, success, label = scenarioId, `value` = `{theta, phi, sizeClass, distance, pattern}`), `mistakes[]`, `masterySignals[]`.

## 14. XP & hearts
+10 per successful round, +40 for finishing (native clamps). `heartsLost` = 1 if accuracy < 0.34, max 1. `replayAvailable` true (re-open the light map for the last round).

## 15. Failure states
| Situation | Learner sees | Result | Hearts |
|---|---|---|---|
| Failed round | Explain with the named pattern you made and the gold zone that fits | outcome false, mistake | none |
| Failed session | "Light is a knack. Another go?" | `heartsLost` 1 if accuracy < 0.34 | -1 |
| Timeout (L5 optional) | Auto shoot plus explain | flagged | none |
| Abort / backgrounded | native | `aborted`, xp 0 | none |
| Shader unsupported / low memory | Native error; native fallback `lf-02-native` offered automatically | `error` | none |

## 16. Accessibility
- **Reduced motion:** freeze is a hard cut; the flash pop is a one-frame cross-fade; no orbiting camera; dragging still moves the light but preview updates without easing.
- **Haptics:** honour `hapticsEnabled`.
- **Colour-blind:** the light map uses shapes (light = sun icon, camera = camera icon, subject = circle); shadows are shown by luminance, not hue; the target zone is hatched and labelled; no red/green.
- **Text scale:** honoured; numerals with units.
- **Tap-only:** yes (azimuth and elevation chips).
- **VoiceOver / TalkBack:** the lit preview is not accessible; controls are labelled with spoken values ("light 45 degrees left, 40 degrees up, softbox at 0.9 metres, angular size 37 degrees, soft"); the explain step reads the pattern name and what to look for. Native fallback `lf-02-native` (frames with full `alt` text) is the accessible equivalent, offered from the intro.

## 17. Audio & haptics
| Event | Sound | Haptic |
|---|---|---|
| Light drag tick (15 degrees) | Soft tick | tick |
| Size chip | Click | light tap |
| Shoot | Original strobe pop (synthesised) | light tap |
| Correct | Warm chime | light success |
| Wrong | Soft thud | warning |
| Freeze | Low hush | soft tap |
All honour `soundEnabled` and `hapticsEnabled`.

## 18. Art & asset list
| Asset | Procedural or external | Source & license | Budget | Notes |
|---|---|---|---|---|
| Studio, backdrop, floor | Procedural | `original-swoond` | < 1k tris | |
| Bust (head and shoulders) | Procedural low-poly with nose, brow and cheek relief | `original-swoond` | < 6k tris | Relief matters for shadows; skin is a single flat tone with subtle subsurface wrap |
| Fabric and wood blocks | Procedural with height noise | `original-swoond` | < 2k tris | Normal-map noise generated in code |
| Light and modifier icons, light map | Procedural | n/a | n/a | Art direction section 4 |
| Audio | Synthesised | `original-swoond` | <= 1 MB | |
Bundle `sim-photo-light`, <= 8 MB.

## 19. Performance budget
Defaults apply; tighter: memory < 130 MB; one shadow-casting light (two at L5) with a 1024 shadow map and 16-tap blocker search; soft-shadow cost <= 3 ms p95 on iPhone 13-class; `shadowQuality: low` uses 8 taps; draw calls <= 100; cold launch < 2 s.

## 20. Telemetry
Standard plus `hintsUsed`, `decisionLatencyMsMedian`, `lightMovesPerRound`, `sizeChanges`, `shadowMsP95`, `shadowQuality`, `difficulty`. No personal data.

## 21. Acceptance criteria (testable)
1. **AC-1:** Seed 5, difficulty 2, 3 rounds: exactly 3 `outcomes`; deterministic (mirroring included).
2. **AC-2:** The pattern classifier returns the tabled pattern for a fixture grid of 40 (theta, phi) pairs including all boundaries, and is mirror-symmetric.
3. **AC-3:** Angular size, softness class, penumbra width, falloff stops and catchlight clock position match the maths to +-1% (or +-1 degree) on 20 fixtures.
4. **AC-4:** Every scenario band (`ls-01` to `ls-12`) passes at its stated example settings and fails one step outside (fixtures).
5. **AC-5:** The rendered penumbra width on a test card matches the analytic width within 20% for three (D, d) pairs (PlayMode render test).
6. **AC-6:** Doubling the light distance quarters measured illuminance on a test patch (+-5%).
7. **AC-7:** `ready` < 2 s; one schema-valid `result`; `requestExit` after.
8. **AC-8:** Abort yields `aborted=true`, xp 0.
9. **AC-9:** Invalid config yields `CONFIG_INVALID`.
10. **AC-10:** Copy lint: titles <= 6 words; bodies <= 45 words; no emoji; say-this in quotes.
11. **AC-11:** Reduced-motion and colour-blind snapshots pass.
12. **AC-12:** Perf p5 >= 50 fps, soft-shadow pass <= 3 ms p95, memory < 130 MB on iPhone 13-class.
13. **AC-13:** Mastery caps respected.

## 22. Test plan
- **EditMode:** classifier and maths fixtures, scenario band fixtures, scoring, determinism, config validation, copy lint, result schema.
- **PlayMode:** scene builds from code; scripted run per goal; render-based penumbra and falloff measurements; freeze and explain; pause/abort; reduced motion.
- **Perf:** iPhone 13-class run, soft-shadow GPU time.

| AC | Type | Test |
|---|---|---|
| AC-1 | EditMode | `Seed_Determinism_Light` |
| AC-2, AC-3, AC-4 | EditMode | `Classifier_Fixtures`, `LightMaths_Fixtures`, `ScenarioBands_Fixtures` |
| AC-5, AC-6 | PlayMode | `Penumbra_MatchesAnalytic`, `InverseSquare_Patch` |
| AC-7, AC-8 | PlayMode | `Launch_Result`, `Abort_Result` |
| AC-9 | EditMode | `Config_Invalid` |
| AC-10 | EditMode | `Copy_Lint` |
| AC-11 | PlayMode | `ReducedMotion_ColorBlind` |
| AC-12 | Perf | `Perf_iPhone13`, `SoftShadow_GpuMs` |
| AC-13 | EditMode | `Mastery_Caps` |

## 23. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Playtest vs the native fallback (section 4) before approval; downgrade if within 5 percentage points. | Product / Claude | No, but gates approval |
| 2 | `SoftLight`: PCSS-style blocker search on mobile within 3 ms; is that realistic on a small scene? Fallback analytic penumbra blur. | Astra | Yes |
| 3 | Pattern angle bands are teaching conventions (schools disagree by 10 degrees); SME (portrait photographer) review of the bands and names. | Product / SME | No |
| 4 | Head model: how much relief for the nose and brow without caricature or uncanny valley? | Astra | No |
| 5 | Model diversity: the bust must not imply one skin tone or facial structure; provide three procedural head variants (skin tone and relief) and randomise by seed. | Product / Astra | No |

### Game Kit additions requested
- **`SoftLight`** (new): light with angular source size, physical penumbra and inverse-square falloff; proposed **GK-23**.
- **`photo_stage`** studio mode and **`PhysicalCamera`** (shared; see the compression-lab spec section 23).
- **`light_goal` objective** (sim-local unless reused).
- Reuse: GK-13 `DistanceRing`, GK-19 camera presets, GK-12 `choose_target`, GK-14 overlay styling.
