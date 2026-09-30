# Native Exercise Payload Contracts v1

One JSON Schema per exercise type, describing the `payload` of a curriculum activity (`activity.type` = file name). Catalog with UI, scoring and behavior: `docs/native-exercises/CATALOG.md`.

Types: multiple-choice, binary-call, term-match, sequence-order, visual-id, decision-scenario, talk-track, timing-tap, say-this, fill-the-gap, listening-id, estimate-slider, hotspot-tap.

- `examples/<type>.example.json` is a valid payload for that type (CI requires one per type).
- Text length caps in the schemas are design constraints (prompts are Display M lines).
- Assets are bundle-relative paths inside a content pack; images and audio must carry a `license` id.
- Every answer needs an explanation (design rule: explain right and wrong).
