# Skincare: safety and accuracy review checklist (for future unit authors and reviewers)

Pattern: `docs/courses/hiking/SAFETY_REVIEW.md` (per-unit findings table plus a numbered checklist). This file is the **pre-authoring checklist and review template** for skincare. When units exist, reviewers record findings in `docs/courses/skincare/SAFETY_REVIEW.md` using the same table format (`Activity | Problem | Fix`).

Skincare is **health-adjacent**. Swoon'd teaches vocabulary, culture and label literacy so a learner can follow a conversation with someone who loves skincare. It is not dermatology, not a skin-advice service and not a product-review service. Where sources differ, teach the more cautious choice and add "ask a dermatologist or pharmacist about your skin."

## A. Qualified review gate (blocking)

1. **No unit ships** until a licensed **dermatologist** and/or licensed **pharmacist** (two reviewers preferred, one of each) has reviewed every activity and signed off in `SAFETY_REVIEW.md` (name, credential, date, unit, version). Orchestrator Sonnet review and the validator are necessary but **not sufficient**.
2. Highest severity units (review first, two signatures): `retinoids`, `exfoliants`, `other-actives`, `spf-basics`, `claims-evidence`, `derm-vs-influencer`, `branch-sun-and-outdoors`, and lesson `di-05` (tween skincare).
3. Re-review is required when a unit changes a safety-relevant answer key, adds a new ingredient, or when a dated regulatory fact changes.
4. Authoring: **Sonnet only** (D-018 safety-critical path; Haiku may not author these units). Brief must include this file.
5. Sources: American Academy of Dermatology, FDA, WHO, NHS, EU SCCS / European Commission, Korea MFDS and Japan MHLW pages for regional rules. If unsure, leave it out.

## B. Hard prohibitions (never appear in any lesson, activity, explanation, coach note or asset)

1. **Diagnosis.** No text that says or implies a person "has" acne, rosacea, eczema, dermatitis, psoriasis, melasma, a fungal infection, an allergy, or any condition. No "is this X?" identification game. No symptom checker. No "what skin condition is this?" `visual-id`.
2. **Treatment and medical advice.** No treatment plans, no "use X to clear/fix/cure Y", no steroid, antibiotic or prescription guidance, no advice about infections, wounds, burns, rashes or reactions beyond "stop using it and ask a pharmacist or doctor; seek urgent care for swelling of the face or lips, trouble breathing, or blistering."
3. **Dosing and frequency instructions.** Strength percentages and "how often" appear only as facts about labels or as what enthusiasts say ("she eases in slowly"), never as instructions to a learner or a friend. The best answer to "how much/how often should I use X?" is "ask a pharmacist or dermatologist."
4. **Pregnancy, breastfeeding, children, medication interactions.** Always "ask a doctor, pharmacist or dermatologist." Do not list ingredients as "safe" or "unsafe" in pregnancy. Tween skincare (`di-05`) explains why dermatologists raise concerns and how to talk kindly; it never prescribes a routine for a child.
5. **Prescription retinoids and similar (tretinoin, isotretinoin, etc.).** Named only as "prescription; ask a clinician". No comparison of strengths, no "how to ask for it", no routine.
6. **Before/after claims or imagery**, retouched or filtered faces, skin close-ups, "glow-ups", outcome promises ("clear skin in X days"), testimonials as evidence.
7. **Product or routine recommendations.** No "best" product, no brand ranking, no affiliate content, no "use this for oily skin". Brand names only as dated facts in live cards, never in a best-answer option.
8. **Shaming or normative language.** No "flawless", "problem skin", "bad skin", "ugly", "aging is bad", "anti-aging" as a goal word in our own voice (quote it only when decoding a label or an enthusiast), no body, age, gender or skin-tone assumptions, no weight or diet claims ("skin foods", detox).
9. **Fear-mongering and miracle claims.** No "toxic", "chemical-free", "detox", "cleanses your body" in our own voice; no dismissal of genuine safety concerns either.
10. **Commenting on someone's skin.** No `talk-track` reply option that remarks on her skin earns positive points; coach notes label it cringe.
11. **Skin photos, face scans, skin analysis, user-uploaded skin images.** None in this course.
12. **Faking expertise.** Nothing teaches the learner to bluff ingredient fluency; every `say-this` has a `noFakeExpertNote`.

## C. Content rules (accuracy)

1. **Skin type words** are descriptions, not diagnoses; they change with season, stress and products. Dry versus dehydrated is taught as a popular framing with limits.
2. **Sensitive skin** is a self-description; sensitized is a temporary irritated state. Never teach how to tell a reaction from a condition; route to a pharmacist.
3. **Patch test**: lowers but does not remove risk; allergic reactions can be delayed; stop if irritated; ask a pharmacist. Do not specify a body site or duration as instructions unless the reviewer approves wording.
4. **SPF**: SPF is mainly a UVB (sunburn) measure; approx. 93/97/98 percent of UVB for SPF 15/30/50 in lab conditions; broad spectrum covers UVA; PA is an Asian UVA rating; generous amount and reapplication about every two hours (and after swimming or heavy sweating) are conservative mainstream guidance; "waterproof" is not a US claim, water-resistant is 40 or 80 minutes; clothing, shade and hats count; every skin tone needs sun protection. Never claim sunscreen alone makes sun exposure "safe".
5. **Mineral versus chemical**: "chemical" names a mechanism, not a danger; do not call either safer. Regional filter availability differs [verify].
6. **Ingredient lists**: ordered by amount down to about 1 percent, then any order (simplified; state "about"). Do not claim a list proves effectiveness.
7. **Label claims**: "dermatologist tested", "hypoallergenic", "non-comedogenic", "clinically proven", "clean" have no single legal meaning or are not endorsements; explain, do not judge a named product.
8. **Exfoliants**: over-exfoliation is taught as a reason to pause and ask a pharmacist; acids and daily SPF go together; no frequency instructions.
9. **Retinoids**: family overview and the OTC versus prescription line; slow starts, dryness and sun sensitivity as things enthusiasts talk about; the best answer to any "should I use one" question is a pharmacist or dermatologist.
10. **Actives (niacinamide, vitamin C, peptides, ceramides, hyaluronic acid, azelaic acid)**: describe what they are and what people like about them; evidence language stays cautious ("often used", "some studies", "evidence varies by type"); never "proven to".
11. **Purging, detox, "toxins", pH myths, "never mix" rules**: present the popular claim and the caution; do not declare a person's reaction as purging.
12. **Regulation** (FDA, EU, Korea, Japan): dated, marked [verify at release], "check the official page"; never legal advice.
13. **Dermatologist versus influencer**: teach source literacy (credentials, sponsorship, evidence); never name or attack an individual creator; credentialed creators also cannot assess a viewer's skin.
14. **Avoid absolutes** ("all", "always", "never") unless official guidance is absolute. No invented statistics.

## D. Inclusion and tone

1. Examples, swatches and scenarios cover a wide range of skin tones, ages, genders and budgets; no face or body art; white cast, shade range and hyperpigmentation-adjacent topics are treated factually.
2. The Fitzpatrick scale is taught only as a clinician's sun-reaction scale, not a beauty or identity label.
3. Budget-neutral: no price shaming in any direction; dupes and luxury are both discussed as choices.
4. Voice: cheeky coach, playful never mean, one joke per screen, never about the crush's skin, never manipulative.
5. The premise is finding common ground, not faking it.

## E. Activity-level rules

1. Every `decision-scenario` has a `safetyNote` ("General learning only. Not medical advice. For any skin concern, see a dermatologist or ask a pharmacist.") and the **best** answer for any condition-shaped scenario is the professional referral.
2. Best answers are conservative: "pause and ask a pharmacist" beats "push through"; never make "keep using it" the best answer for irritated or stinging skin.
3. Emergencies and symptom questions are never timed or scored and never use a streak mechanic.
4. No activity scores appearance, skin state or routine length. Estimate sliders use facts (percent of UVB at SPF 30, reapply hours), never personal targets.
5. Visual-id and hotspot alt text describes features without giving away the answer and never describes a person.
6. Each hotspot has a distinct position; multiple correct answers marked; no placeholder text; no "..." truncation.
7. Keep any one activity type at or below 40 percent of a unit (over 50 percent is a lint error).
8. Every answer, right and wrong, is explained in our own words; prompts <= 12 words; `sayThisLine` where natural.
9. Every image has `license: original-swoond`; no brand logos; invented brand names only ("Example Lab").

## F. Reviewer template

For each unit file, record in `SAFETY_REVIEW.md`:

| Activity | Problem | Severity (blocking / fix / note) | Fix |
|---|---|---|---|

Sign-off block: reviewer name, credential (dermatologist / pharmacist), jurisdiction, date, unit and curriculum version, "approved / approved with changes / not approved", items deferred to "verify at release".

## G. Run

`cd tools/validate && node validate.mjs --course skincare --partial` while units are missing; without `--partial` once all units exist. Then the qualified review (A) before release.
