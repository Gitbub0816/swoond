# Unity Art Direction

Sources: product spec sections 26-27; `docs/design/DESIGN_SPEC.md` tokens and motion. The look is **a polished interactive educational model plus an approachable mobile arcade aesthetic**: not AAA photorealism, not a racing or sports simulator. Educational information is emphasized over realism.

## 1. Principles

1. **Clarity over realism.** Simplified stadiums, stylized players and vehicles, readable silhouettes.
2. **Overlays teach.** Routes, zones, arrows and labels are the stars; the world is a quiet stage.
3. **One focal idea per frame.** Dim everything not being explained.
4. **Cheap and consistent.** Stylized low-poly, flat/soft shaded, few materials, procedural where possible (spec section 27).
5. **Swoon'd feel.** Premium, calm dark UI; serif for feeling, sans for information; rose means "act / you", gold means "earned".

## 2. Palette (from LaunchRequest `theme`, never hard-coded)

Default dark values (for reference; read live from the launch request):

| Use | Token | Dark | Light |
|---|---|---|---|
| Scene background / vignette | `bgDeep` | `#0D0C10` | `#EFE9DF` |
| Playing surface (field, court, track infield) | `court` | `#1D2A27` | `#D9E6DF` |
| Panels / cards | `surface` / `surface2` | `#1A191F` / `#26242B` | `#FFFFFF` / `#EDE7DD` |
| Primary text | `ink` | `#F3EEE6` | `#17151A` |
| You / act / selection / route you control | `accent` (rose) | `#FF6F86` | `#D93F5E` |
| Earned / correct / XP / key highlight | `reward` (gold) | `#E8C07A` | `#A87A1E` |
| Wrong / missed tint | `accentTint` | rose 14% | rose 10% |

Rules:
- Pieces, balls and markers keep their own colors on `court` in both modes (design spec section 3).
- Rose = the learner and their action; gold = success, the correct answer, the thing being taught. Never rely on red/green for right/wrong; pair with a title and shape or pattern.
- Team/vehicle colors: desaturated, distinct in luminance so they survive `colorBlindMode` (protanopia/deuteranopia/tritanopia). Provide pattern or number as a second channel.
- No gradients except a soft radial glow: `accent` <= 15% or `reward` <= 15%, behind results/explain moments.

## 3. 3D style

- **Geometry:** low-poly, chunky proportions, beveled edges; characters are simple capsule-bodied stylized figures with jersey numbers and role rings; vehicles stylized with exaggerated silhouettes.
- **Shading:** URP Simple Lit / custom flat shader with a soft rim light; light baked-in feel via one directional light + ambient; optional subtle outline on highlighted entities.
- **Environments:** procedural: yard lines, court lines, track surface, banking, trail geometry, indicators. Grandstands and crowds are simplified shapes or omitted.
- **Textures:** mostly solid colors and small tileable patterns; no photographic textures.
- **Camera:** mild perspective (FOV 50-60), clean framing, smooth blends; top-down/broadcast presets for spatial reads.
- **External assets** (character models, detailed vehicles, specialized animation) only when procedural cannot carry the lesson; must be low-poly, license-cleared and within budget. Blender is an occasional tool, not a required step.

## 4. Overlay language

| Element | Style |
|---|---|
| Route / path you control | Rose line 3-4 pt equivalent, rounded caps, animated dash only if motion allowed |
| Route / path being explained | Gold line, arrowhead at end |
| Zone (coverage, kitchen) | Translucent fill (`accentTint` or `rewardTint`), 1 pt `strokeStrong` border, label in eyebrow style |
| Target / selectable | Ring, pulses at 1 Hz (static ring under reduced motion) |
| Dimmed entity | 35% opacity, desaturated |
| Callout | Card: `surface` fill, 20 radius, 1 px `stroke`, tail toward the entity |

## 5. Typography in overlays

- **Display (Instrument Serif):** explanation titles, quotable lines ("Say this"), big numerals (score, clock). Emphasize one or two words in italic `accent`.
- **UI (Geist 400/500/600):** labels, callout body, buttons. Minimum text size 13 pt (11 pt only for uppercase eyebrows with +0.14em tracking).
- Fonts are bundled and loaded in Unity (TextMeshPro font assets generated from the same OFL fonts). Respect `textScale`.
- Lines to say out loud: serif, in quotation marks.

## 6. Freeze, replay and slow-mo language

The teaching beat: **act -> execute -> freeze -> explain -> (optional) replay -> line to say.**

- **Freeze:** time scale eases to 0 over 250 ms with `cubic-bezier(.2,.8,.2,1)`; scene dims 35% except the focal entities; a soft vignette appears. Reduced motion: hard cut to freeze, no ease.
- **Slow-mo:** 0.25x-0.5x for replay of the critical moment; camera moves to a top-down or side preset; pitch-shifted audio, or muted.
- **Highlight sequence:** 1) gold pulse on the correct element (400 ms), 2) rose outline on what the learner chose if different, 3) callout cards appear one at a time (250 ms each), 4) "say this" line last.
- **Result beat:** numerals count up over 600 ms; no confetti; the finish is type and gold (design spec section 7).
- **Haptics:** correct = light success; wrong = warning; freeze = soft tap; only when `hapticsEnabled`.
- **Audio:** minimal, warm, short cues; no music required; respect `soundEnabled`.

## 7. Asset checklist per sim

Procedural first. For any external asset record: source, license, polygon count, texture size, and why procedural was insufficient. Attach the list in the sim spec section 18.
