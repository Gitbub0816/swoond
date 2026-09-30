# Swoon'd Contracts

Versioned, platform-neutral interfaces. Each folder holds JSON Schemas (draft 2020-12), a README and `examples/` that CI validates (`node tools/validate/validate.mjs`).

| Contract | Path | Producers / consumers |
|---|---|---|
| Unity bridge v1 | `unity-bridge/v1/` | Claude (native host) <-> Astra (Unity) |
| Course manifest v1 (1.1) | `course-manifest/v1/` | Curriculum authors -> backend, native, Astra |
| Curriculum v1 (1.2) | `curriculum/v1/` | Curriculum authors -> native app / backend |
| Native exercise payloads v1 | `native-exercises/v1/` | Curriculum authors -> native engines |
| Sim definition v1 | `sim-definition/v1/` | Astra (Unity data-driven sims) |

Rules: no unilateral breaking changes; additive changes bump the minor version and get a `docs/product/DECISIONS.md` entry; breaking changes create a new `vN/` folder.
