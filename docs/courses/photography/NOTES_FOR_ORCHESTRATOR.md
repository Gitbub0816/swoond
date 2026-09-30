# Notes for orchestrator (photography)

1. **CATALOG.md**: set `photography` status to `cds-draft`. No other shared-file change required.
2. **Curriculum JSON not authored.** CDS section 11 holds 19 units / 112 lessons / 220 concept ids (ids also in scratch `concepts.json`); `manifest.json` `conversationScenarios.path` points to `curriculum/course.json`. `exercises.md` has 57 validated payloads (13 native types, all schema-valid via ajv), 72 Playbook terms and 9 Talk Track scenarios.
3. **Unit count**: 19 units (11 core + 5 branches + live + conversation + review) exceeds the 8-14 guidance; a learner sees 14 to 19. Needs product approval (CDS open question 1).
4. **Unity sims (3 specs)**: `photo.lens.compression-lab.v1`, `photo.focus.depth-of-field.v1`, `photo.light.direction-lab.v1`. The third is the weakest Tier A case; playtest vs native 8-12 pre-rendered positions plus `visual-id`, downgrade if it does not clearly win (CDS open question 2).
5. **Game Kit additions requested (Astra)**: PhysicalCamera (focal length, aperture, focus distance), DepthOfFieldPass (analytic circle-of-confusion bokeh), SoftLight, `photo_stage` environment key. Reuse GK primitives where they fit; Unity URP mobile depth-of-field budget needs confirmation.
6. **Licensing**: `original-swoond` only at launch; in-house photography programme with model releases is a blocker for visual-id asset production. Register extra licence ids (cc0-1.0, public-domain) only if a museum open-access set is added later.
7. **Safety review** (analogue of S-05) needed for solar photography, tides and wildlife-distance copy before `now-03`, `land-05`, `wild-04` release.
8. **Facts to re-verify before content ships**: Kodak Portra/Ektacolor Pro naming and pricing, content-credentials support by maker, 2026 camera/lens launch list, NPS wildlife distances, Open-Meteo commercial terms.
9. **Shared adapters**: weather adapter shared with hiking; relatedCourses may reference courses without folders.
10. **Validator**: `validate.mjs` does not yet check `live` hooks in `live-data.md`; nothing to do until curriculum exists.
