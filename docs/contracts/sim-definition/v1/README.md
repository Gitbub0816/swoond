# Sim Definition Contract v1

Data-driven simulation definition (product spec section 25) owned by Astra. Schema: `sim-definition.schema.json`. Example: `examples/racing-drafting.json` (mirrors the spec's drafting example).

- Authoring may be YAML; it must convert 1:1 to JSON that validates.
- `entities[].kind`, `objectives[].type`, `demonstrate[].type` and `success/failure` actions name Game Kit primitives and actions (see `docs/astra/GAME_KIT.md`). The schema keeps these open strings; Astra's Unity-side registry rejects unknown names at load time.
- The native app never reads sim definitions; it only sees the bridge contract.
- `difficulty` keys `"1"`..`"5"` deep-merge over the base definition.
