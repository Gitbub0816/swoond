# Course Design Specification: Skincare (`skincare`)

| Field | Value |
|---|---|
| Status | draft (blocked from release by the qualified review gate, section 13) |
| Wave | 3 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `SAFETY_REVIEW_CHECKLIST.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity simulations, see section 12) |

Time-sensitive facts (US sunscreen rules, EU cosmetics rules, youth-skincare regulation, brand news) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Lesson copy never hard-codes them; the live layer and dated "facts cards" carry them (see `live-data.md`).

**This is a health-adjacent course.** Swoon'd teaches the vocabulary, culture and label literacy of skincare so the learner can follow and join a conversation with someone who loves it. It never diagnoses, never treats, never recommends a product or a routine for anyone's skin, and never makes before/after claims. Acne, rosacea, eczema, pregnancy and breastfeeding questions, prescription retinoids, allergic-looking reactions and any new or changing spot are always routed to "a dermatologist or pharmacist". Section 13 and `SAFETY_REVIEW_CHECKLIST.md` are binding on every unit author.

---

## 1. Identity

- **Course ID:** `skincare` (immutable)
- **Display name:** Skincare
- **Category / family:** Fashion & Beauty > Skincare (family `Fashion & Beauty`)
- **Simulation prefix:** `skincare` (reserved; no sims are planned)
- **What this course is.** Skincare is a *routine* (cleanse, treat, moisturize, protect), a *vocabulary* (barrier, humectant, INCI, PA++++), a *set of ingredients* people read about and debate (retinoids, acids, niacinamide, vitamin C, peptides, SPF filters), a *culture* ("skintellectuals", K-beauty and J-beauty, shelfies, hauls, dupes, launches), and a *set of arguments* (dermatologists versus influencers, "clean" beauty, what "clinically proven" means). The person you care about may have a nightly ritual, read ingredient lists for fun, return from Seoul with a suitcase of essences, or simply be fiercely loyal to her sunscreen. The course teaches enough to follow that conversation and ask real questions. It is not a skin-advice course, not a product-review service and never tells anyone how their skin should look.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Fashion (`fashion`) | Knowing silhouettes, fabrics and fashion weeks tells you nothing about ingredients, routines or claims; knowing INCI lists tells you nothing about garment construction. Shared "Fashion & Beauty" shelf only. | Independent (sibling) | Separate course, cross-link only ("how a look comes together", shade and undertone vocabulary mention). Fashion's manifest already lists `skincare` as `sibling-independent`; no ingredient or claims teaching is duplicated there. |
| K-pop (`k-pop`) | K-beauty overlaps with K-pop fan culture (idols and beauty endorsements), but knowing K-pop makes you no more competent about essences or sunscreens. | Adjacent | Cross-link only; branch `k-j-beauty` teaches the skincare culture, never idols. |
| Hiking / Camping / Climbing (`hiking`, `camping`, `climbing`) | Sun, altitude and reflection matter outdoors; knowing skincare is not knowing trail safety, and vice versa. | Adjacent | Branch `sun-and-outdoors` cross-links; hiking owns conditions and safety. |
| Photography (`photography`) | Filters, lighting and retouching overlap with "before and after" skepticism, but the competence differs. | Adjacent | A single lesson (`ce-06`) explains why photos mislead; no camera content here. |
| Cooking / Fitness (`cooking`, `fitness`) | "Skin foods" and diet claims exist online; knowing skincare does not make you competent about nutrition or exercise. | Independent | Skincare never gives diet, supplement or fitness advice. |
| Makeup | Skincare and makeup share shelves, shade vocabulary and stores, but makeup is a different craft. Not in the catalog yet. | Adjacent (future) | Only undertone, shade range and sunscreen-under-makeup are mentioned. Candidate for its own course later. |
| Medicine / dermatology | Learning skincare is **not** learning dermatology. | Out of scope | Every condition-shaped question routes to a professional (section 13). |

- **Branches** (spec section 7; personalization layer via `region`, `brand`, `skill-level`): the shared foundation is the same for everyone; branches change examples, vocabulary emphasis and live context.

| Branch id | Name | What changes |
|---|---|---|
| `everyday-routines` (default) | Everyday routines | Cleanse, treat, moisturize, protect; label reading; core actives. No dedicated unit: the core units are written for this lens. |
| `k-j-beauty` | K-beauty and J-beauty | Multi-step menu, essences, ampoules, sheet masks, cushion compacts, glass and mochi skin, PA ratings, regional claim categories. Unit `branch-k-j-beauty`. Personalizes on `region`. |
| `launch-culture` | Launches, drops and dupes | Limited editions, sell-outs, reformulations, dupes, sets and gifting. Unit `branch-launch-culture`. Personalizes on `brand`. Never ranks or endorses a brand. |
| `sun-and-outdoors` | Sun and outdoors | UV index, shade and clothing, reflective days, sport and sweat, when to ask a clinician about a spot. Unit `branch-sun-and-outdoors`. Personalizes on `region`. |

---

## 2. Beginner model

- **What a beginner knows.** They know sunscreen exists, moisturizer exists, "retinol" is a famous anti-aging word, and that some people have very long routines. They know a few brand names and often judge products by price, packaging or a claim on the front.
- **Terminology that will confuse them.** "Barrier", "humectant", "emollient", "occlusive", "actives", "serum versus essence", "SPF versus PA", "broad spectrum", "mineral versus chemical sunscreen", "AHA/BHA/PHA", "retinol versus retinal versus tretinoin", "niacinamide", "L-ascorbic acid", "peptides", "INCI", "non-comedogenic", "PAO", "patch test", "double cleanse", "skin cycling", "slugging", "purging", "glass skin", "dupe", "holy grail".
- **Common misconceptions.**
  - "Skin type is a fixed label." (Words like oily or dry describe how skin tends to feel; they shift with season, stress and products, and they are not diagnoses.)
  - "Natural means safe, chemical means bad." (Everything is a chemical; natural ingredients can irritate; "chemical sunscreen" names a mechanism, not a danger.)
  - "The higher the SPF, the longer I can stay out." (SPF mostly describes UVB sunburn protection in a lab; amount and reapplication matter more than a big number.)
  - "Expensive means better." (Price and effect correlate loosely; ingredient lists and formulation matter more.)
  - "If it stings, it's working." (Stinging is a signal to pause; "purging" is a contested idea and not a safe excuse to ignore irritation.)
  - "More steps, better skin." (Enthusiasts argue about this all the time; minimal routines are a real routine.)
  - "Dermatologist tested means approved." (It is a claim, not an endorsement.)
  - "You must wait exactly X minutes between layers." (Mostly ritual; texture and comfort matter more.)
  - "Sunscreen is only for beaches." (UV is present on cloudy days and through windows, in different amounts.)
- **Concepts that unlock the rest (become foundation units):** the skin barrier and skin-type vocabulary; routine order; cleansers and moisturizers (the three moisturizer jobs); sunscreen basics; reading a label and an INCI list.

## 3. Foundational knowledge

- **Skin basics.** Layers (epidermis, dermis, hypodermis), the barrier, skin-type words, dry versus dehydrated, sensitive versus sensitized, skin tone and undertone, the Fitzpatrick scale as a clinician's sun-reaction scale, and where skincare ends and medicine begins.
- **Routine order.** Cleanse, treat, moisturize, protect; AM versus PM; optional steps; thin to thick; wait-time myths; skinimalism.
- **Cleansers and moisturizers.** Surfactants, cleanser types, double cleansing; humectants, emollients, occlusives; textures by season; oils, balms and slugging.
- **Sunscreen.** UVA/UVB/UVC, SPF numbers, broad spectrum, PA ratings, mineral versus chemical filters, amount and reapplication, white cast and every skin tone.
- **Labels and INCI.** Back-label anatomy, INCI naming, order by amount (and the 1 percent line), PAO and batch codes, front claims, fragrance wording, patch testing.
- **Modules** (become `foundationalModules[]`): `skin-basics`, `routine-order`, `cleansers-moisturizers`, `spf-basics`, `labels-inci`.

## 4. Enthusiast model

- **What enthusiasts talk about.** Routines and the philosophy behind them (skinimalist versus maximalist); ingredient literacy and formulation (pH, preservatives, delivery, packaging); sunscreen texture and cast debates; K-beauty and J-beauty discoveries; launches, limited editions, reformulations and dupes; how to read claims and studies; who to trust.
- **Distinctions that matter to them.** Humectant versus occlusive; AHA versus BHA versus PHA; retinol versus retinal; L-ascorbic acid versus derivatives; mineral versus chemical filters; UVA protection (PA, UVA circle) versus SPF; fragrance-free versus unscented; formulation versus "hero ingredient"; percent versus overall formula.
- **Knowledge that signals genuine understanding.** Reading the INCI order and the 1 percent line; knowing SPF is a UVB measure; knowing over-exfoliation is easy; knowing "not every viral tip is tested"; knowing when to stop and ask a pharmacist or dermatologist.
- **Beginner statements that sound uninformed.** "Natural means safe." "SPF 100 means I can't burn." "Just use more retinol." "That ingredient is toxic" (with no context). "You're using too many products." "Your skin looks ..." (never).
- **Controversies and debates.** Dermatologist creators versus non-credentialed influencers; "clean beauty" as a category; how many steps; "purging"; mineral versus chemical sunscreen; sunscreen contouring and other viral trends; dupes versus originals; tween "Sephora kids" skincare and strong actives; "derm-approved" labels; fast launch culture versus slow evidence. Swoon'd presents multiple sourced positions and never coaches a fight.

## 5. Interaction model

- **What the learner should experience.** Recognizing textures, packaging and label panels; tapping the right part of a label; ordering a routine logically; reading an ingredient list; judging a claim; hearing "what is she talking about?" lines and practising a kind, curious reply.
- **Unity?** No. See section 12.
- **What should NOT be gamified.** Anyone's skin, skin tone, body, age, acne, scars, sensitivity or condition; "good skin" as a goal; before/after outcomes; dosing or strength targets; routine length as a score; product purchases; anything a clinician should decide. Emergencies and symptom questions are never timed or scored; there is no "skin score" and no face scanning.
- **Summary mix.** `visual-id` (textures, packaging, UV bands; original art), `hotspot-tap` (label and skin layers), `term-match`, `fill-the-gap`, `multiple-choice`, `sequence-order`, `binary-call`, `decision-scenario` (judgment, always with `safetyNote`), `say-this`, `talk-track`, `estimate-slider` (facts only).

## 6. Dynamic information requirements

Skincare is **not** a scores-first subject and Swoon'd must not invent live-data needs (spec section 10). Most of the course is evergreen. The live layer is thin, curated and dated; every hook has an evergreen fallback. Details: `live-data.md`.

| Kind | Needed? | Why | Provider candidates (behind adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| `regulations` | Yes (modest) | Sunscreen filter and cosmetics rule changes (e.g. FDA adding a new UV filter in 2026; EU fragrance-allergen labelling) change what labels mean [verify at release] | FDA OTC monograph pages, Federal Register, EUR-Lex / European Commission (curated, dated explainer cards) | monthly | Dated card or evergreen explainer |
| `conditions` | Yes (optional) | UV index for the `region` personalization | EPA UV Index, NWS, Open-Meteo (licence to confirm) | hourly | "Check your local UV index" link |
| `releases`, `new-products` | Optional | Launch and drop dates for the `launch-culture` branch | Official brand announcement pages (link-out, dated facts only) | weekly | Hide card |
| `news` | Yes (modest) | "Why are people talking about this?" explainers | Trade and mainstream beauty media, health-agency pages (link-only) | daily | Evergreen explainer |
| `schedules`, `events` | No | Beauty events (trade shows, sales) are not needed for conversation competence. | | | |
| `alerts` | No | Product recalls are real safety information, but Swoon'd is not a recall service. The course links to the official recall pages in lessons; no push alerts. | | | |
| Prices, resale, reviews, ratings | **Never** | Licensing risk, invites budget-shaming, and review data is unreliable (lesson `sc-05`). | | | |
| Skin photos, skin analysis, face scans | **Never** | Health-adjacent and privacy-sensitive; out of scope. | | | |

Structured data and editorial data are separate systems (spec section 11).

## 7. Editorial context

- **Helpful commentary.** Why a new sunscreen filter matters; what a label-law change means for ingredient lists; why a viral trend is being debated; why dermatologists and creators disagree; what a launch is and why it sold out.
- **Appropriate sources.** Health agencies (FDA, American Academy of Dermatology, WHO, NHS) for safety-adjacent explainers; official brand pages for launch dates; beauty and mainstream media as link-only headlines. **Never** product reviews or ratings as a data source.
- **Approach:** explain in Swoon'd's own words and link; never copy publisher text.
- **Example prompts:** "Why are people talking about this sunscreen rule?" "What does this new label term mean?" "Why are dermatologists worried about this trend?" "What's a dupe, and why is everyone arguing about this one?"
- **Guardrails.** No brand is endorsed, ranked or disparaged; no health claim about a named product; every explainer that touches safety ends with "ask a pharmacist or dermatologist about your skin."

## 8. Personalization

| Dimension (manifest) | How it changes examples and live context | Default | Units using tokens |
|---|---|---|---|
| `region` | UV index card; home regulator and label terms (US, EU, Korea, Japan); shopping-trip examples | none (hidden) | `branch-k-j-beauty`, `branch-sun-and-outdoors`, `season-now`, `claims-evidence` (`{{region}}`) |
| `brand` | Launch and news cards for a brand she loves; examples say "her favorite brand" never a verdict | none | `branch-launch-culture`, `season-now` (`{{brand}}`) |
| `skill-level` | How much depth the skintellectual units foreground | beginner | `skintellectual-culture`, `formulation-basics`, `other-actives` |

**Skin type and concern (requested personalization).** The brief asks that skin type and concern personalize examples. Design decision:
- The learner may optionally set **conversation flavor tokens** for the Person: `{{skinType}}` (dry-leaning, oily-leaning, combination, normal-leaning, sensitive-feeling) and `{{concern}}` (hydration, shine, tone, texture, sun protection). These choose *which examples and vocabulary are shown first* ("her gel cleanser", "her rich night cream"). They are never displayed as facts about her and never drive advice.
- **Excluded by design:** acne, rosacea, eczema, psoriasis, allergies, pregnancy, medications, age, scars, skin colour. No option for a medical condition exists; if the learner types one in free text, the app shows "That's one for a dermatologist or pharmacist. Swoon'd can help you talk about skincare, not treat it." and stores nothing.
- Stored on-device only, never sent to analytics, Unity telemetry or notifications; hidden in discreet mode (CLAUDE.md rule). Default unset.
- **Manifest gap:** the `personalizationDimensions` enum has no `skin-type` or `concern`. The manifest therefore lists `region`, `brand`, `skill-level`; a request to add `skin-type` and `concern` is in `NOTES_FOR_ORCHESTRATOR.md`. Product-owner approval is also requested because a person's skin type is health-adjacent data about a third party (open question 2).

## 9. Conversation model

| # | What she might say | What it means | What to ask next |
|---|---|---|---|
| 1 | "I'm doing skin cycling this month." | Alternating active nights with rest nights, a popular trend. | "How's it going?" |
| 2 | "I never skip SPF, even when it's cloudy." | She reapplies and protects daily because UV is there on cloudy days. | "Do you have a favorite texture?" |
| 3 | "My barrier's been cranky." | Her skin feels irritated or tight; she's simplifying. | "Ugh, sounds annoying. Anything I can do?" (Not: advice.) |
| 4 | "Niacinamide is fourth on the list." | It's a large share of the formula because lists run by amount. | "Why does position matter?" |
| 5 | "It's PA++++." | A strong UVA rating on an Asian-market sunscreen. | "Did you find it on a trip?" |
| 6 | "That's a humectant-heavy formula." | Mostly water-drawing ingredients like glycerin. | "Do you prefer that in summer?" |
| 7 | "I'm adding one new thing at a time." | She patch tests and avoids changing five things at once. | "What's the new thing?" |
| 8 | "Is that creator even qualified?" | She checks credentials and sponsorship. | "What makes you trust one over another?" |
| 9 | "The limited set sold out in minutes." | A launch with scarcity; fans refresh the page. | "What made that one special?" |
| 10 | "It's a decent dupe." | A cheaper lookalike that echoes a pricier product. | "What's it a dupe of?" |
| 11 | "I double cleanse at night." | Oil or balm first, then a water-based cleanser. | "Is that for sunscreen days?" |
| 12 | "I'm a skinimalist now." | Minimal routine by choice. | "What's in your three steps?" |
| 13 | "I bought a cushion in Seoul." | A sponge compact, often with SPF. | "Was the shade range good?" |
| 14 | "I'll patch test it first." | Small-area test before a new product. | "Where do you test?" |
| 15 | "My pharmacist explained what I could layer." | She asked a qualified person; great habit. | "What did she say?" (Not: re-litigating it.) |

- **How Swoon'd helps without encouraging fake expertise.** Every `say-this` item carries a `noFakeExpertNote`; good replies are questions and warmth. Replies that give her advice about her skin, recommend actives, comment on her skin, judge her spending or bluff about ingredients lose points.
- **Targets:** 16 talk tracks and ~70 say-this at launch; 8 tracks are authored in `exercises.md`.

## 10. Assessment

- **Useful competence** is determined by concept mastery (`concept-mastery-v1`, pass 0.75): recognize textures, label parts and filter types; explain in one sentence what a barrier, SPF, INCI order and a retinoid are; interpret a claim; and choose the kind reply in a conversation practice scenario. The safety lessons are mastered only when the learner consistently picks "ask a pharmacist or dermatologist" in condition-shaped scenarios.
- **The learner should be able to:** recognize routine steps and ingredient families; understand what SPF, PA and broad spectrum mean; explain why a list is ordered by amount; correctly interpret "dermatologist tested" and "non-comedogenic"; explain why skincare is not medicine.
- **Useful competence statement:** "She can follow a conversation about someone's routine, a sunscreen or an ingredient, name what is being discussed, ask a real question about it, and say 'okay, I see why you love this' without faking expertise, giving skin advice or judging anyone's skin, tone or budget."
- **Not measured:** appearance, skin outcomes, routine length, spending.


## 11. Curriculum map (ongoing course)

Activity codes: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `st` say-this, `fg` fill-the-gap, `es` estimate-slider, `ht` hotspot-tap. Every lesson is authored with 4+ activities (validator `thin-lesson`); the table lists the lead activity families. No lesson uses `unity-sim`. Every `ds` activity carries a `safetyNote`. Every lesson in a unit reviewed by `SAFETY_REVIEW_CHECKLIST.md`.

### Layer 1: Foundations

**Unit `skin-basics`: Skin Basics and the Barrier** (prereq: none). 7 lessons. Vocabulary only. Nothing here diagnoses or treats; a closing lesson draws the line between skincare and medicine.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sb-01` | Skin in three layers | Name epidermis, dermis and hypodermis and say which layer products mostly reach. | skin-layers | ht, mc, fg |
| `sb-02` | The barrier, in plain words | Explain the brick-and-mortar picture of the skin barrier and what it does. | skin-barrier | mc, vi, st |
| `sb-03` | Skin types are descriptions | Use dry, oily, combination and normal as casual words, never diagnoses. | skin-type-words | fg, tm, st |
| `sb-04` | Dry or dehydrated? | Explain the popular dry-versus-dehydrated framing and its limits. | dry-vs-dehydrated | bc, mc, st |
| `sb-05` | Sensitive and sensitized | Tell a lasting 'sensitive' label from a temporary irritated state, without diagnosing. | sensitive-vs-sensitized | tm, ds, st |
| `sb-06` | Skin tone, undertone and sun | Explain undertone, the Fitzpatrick scale's clinical role and why every skin tone needs sun care. | skin-tone-undertone, fitzpatrick-scale | mc, bc, st |
| `sb-07` | Skincare is not medicine | Explain where cosmetic care ends and medical care begins, and who to ask. | skincare-vs-medicine | ds, mc, st |

**Unit `routine-order`: Routine Order** (prereq: `skin-basics`). 7 lessons. Order is convention plus physics (thin before thick), not a rulebook.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ro-01` | Cleanse, treat, moisturize, protect | Put the four-step morning logic in order. | routine-core-four | so, mc, st |
| `ro-02` | Why SPF goes last in the morning | Explain why SPF is the final morning step. | spf-last | bc, mc, st |
| `ro-03` | Morning versus night | Say what changes between AM and PM routines and why. | am-vs-pm | tm, ds, st |
| `ro-04` | The extra steps | Decode toner, essence, serum and eye cream as optional steps. | optional-steps | tm, mc, st |
| `ro-05` | Thin to thick | Order products by texture and explain the rule of thumb. | thin-to-thick | so, fg, mc |
| `ro-06` | Wait times and other myths | Separate useful pacing from ritual (how long to wait between layers). | layer-wait-time | mc, bc, ds |
| `ro-07` | A minimal routine is a real routine | Explain skinimalism and why fewer steps can be a full routine. | skinimalism | ds, st, tk |

**Unit `cleansers-moisturizers`: Cleansers and Moisturizers** (prereq: `skin-basics`). 6 lessons. The products almost everyone uses.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cm-01` | What a cleanser does | Explain surfactants, rinse-off and why some cleansers feel harsher. | cleanser-basics, surfactants | mc, vi, fg |
| `cm-02` | Gel, cream, oil, balm, micellar | Recognize common cleanser and texture types. | cleanser-types, texture-types | vi, tm, st |
| `cm-03` | Double cleansing | Explain double cleansing and when people do it. | double-cleanse | so, mc, st |
| `cm-04` | Humectant, emollient, occlusive | Match the three moisturizer jobs to ingredient types. | humectant-emollient-occlusive | tm, mc, fg |
| `cm-05` | Moisturizer textures and seasons | Explain why people swap textures by season or climate. | moisturizer-textures | vi, ds, st |
| `cm-06` | Oils, balms and slugging | Explain facial oils, sealing balms and slugging as a trend. | facial-oils, slugging | mc, bc, st |

**Unit `spf-basics`: Sunscreen Basics** (prereq: `skin-basics`). 7 lessons. Conservative mainstream guidance (AAD, FDA, WHO); dates and rules are checked at release.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sp-01` | Why sunscreen leads every routine | Explain why dermatologists and health agencies treat SPF as the top daily habit. | why-spf | mc, ds, st |
| `sp-02` | UVA, UVB, UVC | Name the bands and what each does. | uv-bands | vi, tm, mc |
| `sp-03` | What SPF numbers mean | Explain SPF as a UVB measure and why 30 to 50 is a small step. | spf-number | es, mc, bc |
| `sp-04` | Broad spectrum and PA | Decode broad spectrum, PA ratings and UVA marks. | broad-spectrum, pa-rating | tm, fg, st |
| `sp-05` | Mineral and chemical filters | Explain both filter families without fear or hype. | mineral-vs-chemical | fg, tm, bc |
| `sp-06` | How much, how often | Explain generous amount and reapplying about every two hours. | spf-amount-reapply | es, mc, ds |
| `sp-07` | White cast and every skin tone | Explain white-cast complaints, tinted and sheer formulas, and why everyone wears SPF. | white-cast, spf-all-tones | mc, ds, st |

**Unit `labels-inci`: Labels and INCI Lists** (prereq: `skin-basics`). 7 lessons. Reading skills, not buying instructions. No brand is ranked.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `lb-01` | Anatomy of a back label | Find directions, ingredient list, batch code and PAO on a label. | label-anatomy | ht, mc, fg |
| `lb-02` | What INCI is | Explain INCI and why names look like Latin and chemistry. | inci | mc, st, tm |
| `lb-03` | Reading the order | Explain order-by-amount and the 1 percent line. | ingredient-order | mc, bc, es |
| `lb-04` | PAO and batch codes | Read the open-jar symbol and what batch codes do. | pao-symbol, batch-code | ht, mc, fg |
| `lb-05` | Claims on the front | Decode 'dermatologist tested', 'hypoallergenic', 'non-comedogenic', 'free-from'. | label-claims | bc, tm, ds |
| `lb-06` | Fragrance and 'free-from' | Tell fragrance-free from unscented and understand 'free-from' claims. | fragrance-labeling | mc, bc, st |
| `lb-07` | Patch testing as a habit | Explain what a patch test is, what it can't promise and when to ask a pharmacist. | patch-test | so, ds, st |

### Layer 2: Intermediate

**Unit `exfoliants`: Exfoliants** (prereq: `routine-order`). 6 lessons. Acids are popular and easy to overdo; unit leans on 'go slow, stop if it stings, ask a pro'.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ex-01` | AHA, BHA, PHA | Match each acid family to its nickname and trait. | aha-bha-pha | tm, mc, st |
| `ex-02` | Physical versus chemical | Explain scrubs versus acids and why enthusiasts lean chemical. | physical-vs-chemical-exfoliation | mc, bc, vi |
| `ex-03` | Frequency and pacing | Explain why people start slow and space exfoliation out. | exfoliation-pacing | ds, fg, st |
| `ex-04` | Over-exfoliation | Recognize the talked-about signs of overdoing it and the pause-and-ask move. | over-exfoliation | bc, ds, mc |
| `ex-05` | Acids and the sun | Explain why acids and daily SPF go together. | acids-and-sun | mc, fg, st |
| `ex-06` | Enzyme, peel and tool talk | Decode enzymes, peels and gadgets people mention. | exfoliation-formats | tm, mc, st |

**Unit `retinoids`: Retinoids** (prereq: `routine-order`). 6 lessons. HEALTH-ADJACENT: prescription retinoids, pregnancy and breastfeeding, acne treatment and dosing are always routed to a dermatologist or pharmacist.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ri-01` | What a retinoid is | Explain the retinoid family as vitamin A derivatives. | retinoid-family | mc, tm, st |
| `ri-02` | Retinol, retinal, retinyl esters | Order cosmetic retinoids from gentle to strong as a rough conversation map. | retinoid-ladder | so, tm, mc |
| `ri-03` | OTC versus prescription | Explain that some retinoids are over the counter, others prescription, and who to ask. | otc-vs-rx-retinoids | bc, ds, st |
| `ri-04` | Patience, dryness and sun | Explain why retinoid talk mentions slow starts, dryness and sun protection. | retinoid-adjustment | mc, ds, st |
| `ri-05` | What she means by '0.3 percent' | Read a strength claim without treating it as a dose. | retinoid-strength | es, mc, st |
| `ri-06` | When a friend asks you | Practice the honest, caring reply that points to a pharmacist or dermatologist. | referral-habit | ds, tk, st |

**Unit `other-actives`: Niacinamide, Vitamin C, Peptides and Friends** (prereq: `labels-inci`). 7 lessons. Ingredient literacy, not recommendations. Evidence claims stay cautious.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `oa-01` | Niacinamide | Explain niacinamide as a vitamin B3 form and what people like about it. | niacinamide | mc, st, fg |
| `oa-02` | Vitamin C | Explain L-ascorbic acid, derivatives and why packaging matters. | vitamin-c | vi, mc, st |
| `oa-03` | Peptides | Explain peptides as a category, not one ingredient. | peptides | mc, tm, st |
| `oa-04` | Ceramides and hyaluronic acid | Explain ceramides and hyaluronic acid in barrier and hydration talk. | ceramides-ha | tm, fg, st |
| `oa-05` | Azelaic and other acids | Decode azelaic, tranexamic and other names in a neutral, label-reading way. | azelaic-and-others | tm, mc, ds |
| `oa-06` | Antioxidants and the day routine | Explain antioxidants as a daytime layer under SPF. | antioxidants | mc, bc, st |
| `oa-07` | Actives she loves | Recognize which ingredient she is talking about from how she describes it. | active-recognition | st, st, tk |

**Unit `combining-pacing`: Combining and Pacing** (prereq: `exfoliants`). 6 lessons. Practical habits: one new thing at a time, patch test, simplify when skin complains.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cp-01` | One new thing at a time | Explain why enthusiasts add one product at a time. | one-at-a-time | mc, ds, st |
| `cp-02` | Mixing myths | Sort real interaction caution from viral 'never mix' rules. | mixing-myths | bc, mc, ds |
| `cp-03` | Skin cycling and rotation | Explain skin cycling and rest nights as a named trend. | skin-cycling | fg, st, mc |
| `cp-04` | Sandwiching and buffering | Explain sandwiching and why people buffer actives. | sandwiching | so, mc, st |
| `cp-05` | Simplify when skin complains | Explain the 'go back to basics' reset and when to ask a pro. | simplify-reset | ds, bc, st |
| `cp-06` | Travel, seasons and climate | Explain how people tweak a routine for weather and travel. | seasonal-adjustment | ds, mc, st |

### Layer 3: Enthusiast depth

**Unit `skintellectual-culture`: Skintellectual Culture** (prereq: `routine-order`). 6 lessons. Culture and vocabulary; never a ranking of routines or people.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sc-01` | Where skincare talk lives | Explain forums, short video and reviews as places ingredient talk happens. | skincare-communities | mc, st, tk |
| `sc-02` | Skinimalism and maximalism | Explain minimal and maximal routine cultures without taking sides. | skinimalism-vs-maximalism | tm, ds, st |
| `sc-03` | Shelfies, hauls and PR boxes | Decode shelfie, haul and PR-box content and what it signals. | shelfie-haul-culture | mc, st, tk |
| `sc-04` | Holy grails and dupes | Explain holy grail and dupe talk, including quality caveats. | holy-grail-dupe | tm, ds, st |
| `sc-05` | Reading reviews, including fake ones | Explain review bias, gifted products and skin-variation. | review-literacy | mc, ds, st |
| `sc-06` | What a skintellectual sounds like | Recognize how enthusiasts talk and what good questions sound like. | skintellectual-voice | st, st, tk |

**Unit `claims-evidence`: Claims, Evidence and Regulation** (prereq: `labels-inci`). 6 lessons. Media-literacy unit. No brand is called out; regulatory facts are dated.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ce-01` | How to read a claim | Break a claim into what, how much and compared with what. | claim-anatomy | mc, ds, st |
| `ce-02` | What 'clinically proven' can mean | Explain study types and sample-size caution. | clinically-proven | mc, bc, st |
| `ce-03` | In the lab, on the skin | Explain in-vitro versus in-vivo and why it matters. | in-vitro-vs-in-vivo | tm, mc, st |
| `ce-04` | Clean beauty and 'toxic' talk | Explain why 'clean' has no single meaning and how to approach fear-based claims. | clean-beauty | ds, mc, st |
| `ce-05` | Who regulates cosmetics | Compare US, EU, Korea and Japan in broad strokes, dated. | cosmetic-regulation | tm, mc, st |
| `ce-06` | Why before-and-after photos mislead | Explain why lighting, angle and editing make photos unreliable; Swoon'd shows none. | before-after-caution | bc, ds, st |

**Unit `derm-vs-influencer`: Dermatologists and Influencers** (prereq: `claims-evidence`). 6 lessons. Teaches source literacy. Never tells the learner a specific person is wrong; never gives personal medical advice.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `di-01` | Who is a dermatologist | Explain what dermatologists, pharmacists and estheticians each do. | skin-professionals | tm, mc, st |
| `di-02` | Derm creators and their limits | Explain why a credentialed creator still can't assess your skin. | derm-creators | mc, bc, st |
| `di-03` | Sponsored, gifted and affiliate | Decode #ad, gifted and affiliate links. | sponsorship-disclosure | tm, mc, ds |
| `di-04` | Viral advice and pushback | Practice weighing a viral claim against reliable sources. | viral-claims | ds, bc, tk |
| `di-05` | Tween skincare talk | Explain why dermatologists raise concerns about young people and strong actives, and how to talk about it gently. | tween-skincare | mc, ds, st |
| `di-06` | Disagreement without a fight | Practice staying curious when sources disagree. | disagree-well | tk, st, ds |

**Unit `formulation-basics`: Formulation Basics** (prereq: `labels-inci`). 5 lessons. Nerd depth: why a formula works the way it does.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fb-01` | Emulsions and textures | Explain emulsions and why textures feel the way they do. | emulsions | mc, vi, tm |
| `fb-02` | pH and why it matters | Explain pH in skincare at a conversation level. | skincare-ph | mc, fg, st |
| `fb-03` | Preservatives | Explain why water-based products need preservatives. | preservatives | bc, mc, st |
| `fb-04` | Concentration is not everything | Explain why percent alone doesn't rank products. | concentration-vs-formula | es, ds, st |
| `fb-05` | Packaging and stability | Explain why light, air and heat matter for some ingredients. | packaging-stability | vi, mc, st |

### Layer 4: Branches and personalization

**Unit `branch-k-j-beauty`: Branch: K-Beauty and J-Beauty** (prereq: `routine-order`). 6 lessons. Personalizes on `region`. Culture and vocabulary; no brand ranking; regulatory facts dated.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `kj-01` | Ten steps is a menu | Explain the multi-step image and why people treat it as a menu. | kbeauty-steps | mc, ds, st |
| `kj-02` | Essence, ampoule, sheet mask, cushion | Match K-beauty words to what they are. | kbeauty-vocab | tm, vi, st |
| `kj-03` | Glass skin and mochi skin | Explain the aesthetic ideals as trends and why not to chase them. | glass-mochi-skin | mc, st, tk |
| `kj-04` | Japanese sunscreens and PA | Explain PA ratings and regional sunscreen habits. | regional-sunscreen | tm, fg, st |
| `kj-05` | Functional cosmetics and quasi-drugs | Explain how Korea and Japan group certain claims [verify]. | regional-claim-categories | mc, tm, st |
| `kj-06` | The beauty-shop trip | Practice talking about a shopping trip with curiosity. | beauty-trip-talk | tk, st, ds |

**Unit `branch-launch-culture`: Branch: Launches, Drops and Dupes** (prereq: `skintellectual-culture`). 6 lessons. Personalizes on `brand`. Never ranks, endorses or disparages a brand.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `lc-01` | What a launch looks like | Explain launch, relaunch, limited edition and collab. | launch-vocab | tm, mc, st |
| `lc-02` | Why things sell out | Explain scarcity, influencer seeding and real demand. | sold-out-dynamics | mc, ds, st |
| `lc-03` | Reformulations | Explain why brands reformulate and why fans notice. | reformulation | mc, bc, st |
| `lc-04` | Dupes and value | Explain dupe culture, quality caveats and value versus price. | dupe-culture | ds, mc, st |
| `lc-05` | Gifting and sets | Explain set culture and how to gift skincare thoughtfully. | gifting-skincare | ds, tk, st |
| `lc-06` | Fast launches, slow skin | Explain why hype moves faster than real evidence. | hype-vs-evidence | mc, bc, st |

**Unit `branch-sun-and-outdoors`: Branch: Sun and Outdoors** (prereq: `spf-basics`). 5 lessons. Personalizes on `region` (UV index). Cross-links hiking, camping, climbing for conditions.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `su-01` | The UV index | Read a UV index and what it says about a day. | uv-index | es, mc, st |
| `su-02` | Shade, clothing and hats | Explain sun protection beyond sunscreen. | sun-protection-layers | mc, tm, ds |
| `su-03` | Reflective days | Explain water, sand, snow and altitude as sun amplifiers. | sun-reflection-altitude | mc, bc, ds |
| `su-04` | Sport and sweat | Explain water-resistant claims and reapplying outside. | sport-sunscreen | fg, ds, st |
| `su-05` | New or changing spots | Explain that a new or changing spot belongs with a clinician. | spot-referral | ds, mc, st |

### Layer 5: Current context (live)

**Unit `season-now`: What's in Skincare Right Now** (prereq: `routine-order`). 4 lessons. Live hooks. Always dated; evergreen fallbacks.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sn-01` | Why people are talking about this | Practice reading a dated explainer card. | current-explainer | mc, st, tk |
| `sn-02` | New launches this season | Explain how launches are described and what to ask. | launch-cards | mc, ds, st |
| `sn-03` | Rules pulse | Explain a dated regulation change, such as a new sunscreen filter [verify]. | rules-pulse | mc, tm, st |
| `sn-04` | Seasonal skin talk | Follow winter dryness, summer sun and travel talk. | seasonal-talk | st, ds, tk |

### Layer 6: Conversation practice

**Unit `conversation-lab`: Conversation Lab** (prereq: `spf-basics`). 6 lessons. Continuous; new tracks each season.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cl-01` | Her shelf | Practice asking about a routine without judging it. | convo-shelf | tk, st, ds |
| `cl-02` | Her SPF habit | Practice talking sun habits kindly. | convo-spf | tk, st, mc |
| `cl-03` | Her new active | Practice caring, honest replies when a new ingredient is causing drama. | convo-new-active | tk, ds, st |
| `cl-04` | Her skeptical friend | Practice talking about disagreements and sources. | convo-skeptic | tk, st, ds |
| `cl-05` | Her haul | Practice joy without spending judgments. | convo-haul | tk, st, mc |
| `cl-06` | What not to say | Sort lines that comment on skin, bodies or budgets. | convo-never | bc, ds, tk |

### Layer 7: Perpetual review

**Unit `review-loop`: Review Loop** (prereq: `skin-basics`). 3 lessons. Spaced review; Daily Bite draws from here.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rl-01` | Daily Bite pool | Keep basics fresh with short recall cards. | review-basics | mc, fg, bc |
| `rl-02` | Term Blitz | Review vocabulary across the course. | review-terms | tm, fg, st |
| `rl-03` | Safety and sources refresh | Revisit the 'ask a professional' habit and claim-reading skills. | review-safety | ds, bc, mc |

### Concept targets, personalization slots, release plan

- **Totals:** 19 units (3 are `layer: branch` units), 112 lessons, 119 Playbook concept ids at v1 (Appendix), target ~149 as sub-concepts are split out. Unit count exceeds the guide's 10-16 typical range for the same reason as fashion: branch units are small and optional; consider merging `formulation-basics` into `skintellectual-culture` if the app wants fewer.
- **Perpetual layer.** `season-now` exists because skincare has a real, modest current layer (launches, label-law changes, seasonal talk); `review-loop` holds the spaced-review policy (Daily Bite, Term Blitz, safety and sources refresh).
- **Review policy (for curriculum `course.json`):** intervals 1, 3, 7, 21, 60 days; max 12 items per Daily Bite; safety-habit concepts (`skincare-vs-medicine`, `referral-habit`, `patch-test`, `spot-referral`, `simplify-reset`) reappear at least every 30 days.
- **Personalization slots:** `{{region}}`, `{{brand}}`, `{{skinType}}` (optional, on-device, section 8), `{{concern}}` (optional theme, section 8).
- **Release plan:**
  - **Launch (v0.1-1.0):** `skin-basics`, `routine-order`, `cleansers-moisturizers`, `spf-basics`, `labels-inci`, `conversation-lab`, `review-loop`; default branch `everyday-routines`. Requires qualified review gate.
  - **Fast follow (1.1):** `exfoliants`, `retinoids`, `other-actives`, `combining-pacing`, `skintellectual-culture`, `claims-evidence`, `derm-vs-influencer`; branches `k-j-beauty`, `sun-and-outdoors`.
  - **Ongoing:** `formulation-basics`, branch `launch-culture`, `season-now` cards; new talk tracks each season (winter dryness, summer sun, travel), plus after regulatory changes.
  - **Holding rule:** the `retinoids`, `exfoliants`, `other-actives` and `derm-vs-influencer` units do not ship until the qualified review is recorded in `SAFETY_REVIEW.md`.

### Appendix: Playbook concepts (ids)

skin-basics: `skin-layers`, `skin-barrier`, `skin-type-words`, `dry-vs-dehydrated`, `sensitive-vs-sensitized`, `skin-tone-undertone`, `fitzpatrick-scale`, `skincare-vs-medicine`.

routine-order: `routine-core-four`, `spf-last`, `am-vs-pm`, `optional-steps`, `thin-to-thick`, `layer-wait-time`, `skinimalism`.

cleansers-moisturizers: `cleanser-basics`, `surfactants`, `cleanser-types`, `texture-types`, `double-cleanse`, `humectant-emollient-occlusive`, `moisturizer-textures`, `facial-oils`, `slugging`.

spf-basics: `why-spf`, `uv-bands`, `spf-number`, `broad-spectrum`, `pa-rating`, `mineral-vs-chemical`, `spf-amount-reapply`, `white-cast`, `spf-all-tones`.

labels-inci: `label-anatomy`, `inci`, `ingredient-order`, `pao-symbol`, `batch-code`, `label-claims`, `fragrance-labeling`, `patch-test`.

exfoliants: `aha-bha-pha`, `physical-vs-chemical-exfoliation`, `exfoliation-pacing`, `over-exfoliation`, `acids-and-sun`, `exfoliation-formats`.

retinoids: `retinoid-family`, `retinoid-ladder`, `otc-vs-rx-retinoids`, `retinoid-adjustment`, `retinoid-strength`, `referral-habit`.

other-actives: `niacinamide`, `vitamin-c`, `peptides`, `ceramides-ha`, `azelaic-and-others`, `antioxidants`, `active-recognition`.

combining-pacing: `one-at-a-time`, `mixing-myths`, `skin-cycling`, `sandwiching`, `simplify-reset`, `seasonal-adjustment`.

skintellectual-culture: `skincare-communities`, `skinimalism-vs-maximalism`, `shelfie-haul-culture`, `holy-grail-dupe`, `review-literacy`, `skintellectual-voice`.

claims-evidence: `claim-anatomy`, `clinically-proven`, `in-vitro-vs-in-vivo`, `clean-beauty`, `cosmetic-regulation`, `before-after-caution`.

derm-vs-influencer: `skin-professionals`, `derm-creators`, `sponsorship-disclosure`, `viral-claims`, `tween-skincare`, `disagree-well`.

formulation-basics: `emulsions`, `skincare-ph`, `preservatives`, `concentration-vs-formula`, `packaging-stability`.

branch-k-j-beauty: `kbeauty-steps`, `kbeauty-vocab`, `glass-mochi-skin`, `regional-sunscreen`, `regional-claim-categories`, `beauty-trip-talk`.

branch-launch-culture: `launch-vocab`, `sold-out-dynamics`, `reformulation`, `dupe-culture`, `gifting-skincare`, `hype-vs-evidence`.

branch-sun-and-outdoors: `uv-index`, `sun-protection-layers`, `sun-reflection-altitude`, `sport-sunscreen`, `spot-referral`.

season-now: `current-explainer`, `launch-cards`, `rules-pulse`, `seasonal-talk`.

conversation-lab: `convo-shelf`, `convo-spf`, `convo-new-active`, `convo-skeptic`, `convo-haul`, `convo-never`.

review-loop: `review-basics`, `review-terms`, `review-safety`.

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4): Unity only where spatial reasoning, movement, physics, timing in a scene, or camera perspective materially improves learning and a native exercise would teach it clearly worse.

**Verdict: zero Unity simulations (Tier A count 0).** Reasons:
1. **Recognition and judgment are the skills.** Textures, packaging, label panels, UV bands and routine order are learned by looking at clear static illustrations and ordering steps, which `visual-id`, `hotspot-tap`, `sequence-order` and `term-match` do better than a 3D scene.
2. **No dynamic spatial scene.** Nothing depends on things moving over time in space. Skin-layer and UV diagrams are fixed cross-sections; "absorption" and "penetration" are explained in words and diagrams, not simulated.
3. **The tempting sim is the one we must not build.** A face or skin simulator (skin-layer animations, "see your skin age", ingredient-penetration physics, UV damage visualizers) would need a body or face model, would imply outcomes, would drift into medical claims, and would be unverifiable for accuracy. It fails the rubric and the health-adjacent safety rules.
4. **Judgment is text-shaped.** Claims, viral advice, patch-test habits and referrals are `decision-scenario`, `say-this` and `talk-track`.
5. **No 1D timing or audio need.** `timing-tap` and `listening-id` are unused. "Wait two minutes" is a myth to explain, not a timing skill to train.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Textures, packaging, UV bands, label panels, sun-protection layers | texture-types, packaging-stability, uv-bands, label-anatomy | `visual-id` (original illustrations, `original-swoond`) | Core recognition skill; alt text describes features without giving away the answer; no faces, no skin photos, no real products. | B | ~70 |
| Label anatomy, skin layers (face-free) | label-anatomy, skin-layers, pao-symbol | `hotspot-tap` on procedural diagrams | Fixed diagram, no motion. | B | ~30 |
| Terms and definitions | humectant-emollient-occlusive, aha-bha-pha, kbeauty-vocab | `term-match`, `fill-the-gap`, `multiple-choice` | Recall and recognition. | B | ~270 |
| Routine and label-check order | routine-core-four, thin-to-thick, patch-test | `sequence-order` | Order is the concept; `why` text carries the logic. | B | ~20 |
| Two-way calls | spf-last, label-claims, over-exfoliation | `binary-call` (text scenes) | Clear yes/no on a static statement. | B | ~30 |
| Judgment (new products, viral claims, label reading, helping a friend) | patch-test, viral-claims, referral-habit, simplify-reset | `decision-scenario` with `safetyNote` | Facts, consequences, expert note; best answer is conservative and defers to a professional for health. | B | ~70 |
| Magnitudes (facts only) | spf-number, spf-amount-reapply, uv-index, retinoid-strength | `estimate-slider` | Numeric intuition; never a dose, strength target or body measure. | B | ~14 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice (Talk tab and unit ends). | B | 16 talk tracks + ~70 say-this |
| Review | due concepts | `multiple-choice`, `fill-the-gap` | Daily Bite. | B | (pool) |

**Not used:** `unity-sim`, `timing-tap`, `listening-id`. No sim specs are written (no `sims/` folder).

---

## 13. Licensing & safety

**Safety rules for every unit (binding; detail in `SAFETY_REVIEW_CHECKLIST.md`):**
1. **Never diagnose.** No lesson or reply names a condition as something a person "has"; no "is this acne/eczema/rosacea?" game; no skin-symptom checker.
2. **Never give medical advice or treatment.** Acne, rosacea, eczema, psoriasis, hyperpigmentation treatment, pregnancy and breastfeeding, prescription retinoids, steroid creams, allergies and reactions, any changing or new mole or spot: the best answer is always "ask a dermatologist or pharmacist".
3. **No personal product or routine recommendation.** Teach how to read and discuss; never "use X for Y".
4. **No dosing or strength instructions.** Strength numbers are facts about labels, not targets.
5. **No before/after claims or imagery**, no retouched or filtered faces, no outcome promises ("clear skin in 14 days").
6. **Patch-test framing.** Teach patch testing as a cautious habit that lowers but does not remove risk; "stop and ask a pharmacist if you react".
7. **Body-, age-, gender- and skin-tone inclusive, never shaming.** Skin is not good or bad; no "flawless", "problem skin", "aging is bad" language; every tone represented in examples; white cast and shade range taught honestly.
8. **No brand shilling.** No brand is ranked, recommended, disparaged or used as a "best" answer; brand names only as dated facts in live cards; invented brand names in examples; no affiliate content.
9. **No fear-mongering and no miracle claims.** "Toxic" and "chemical-free" claims are examined, not endorsed; also no dismissal of real safety concerns; when unsure, leave it out.
10. **Sources.** Conservative mainstream guidance: American Academy of Dermatology, FDA, WHO, NHS, EU SCCS/European Commission, Korea MFDS and Japan MHLW pages for regional rules. Dated with "check official guidance".
11. **Never teach faking expertise or judging someone's skin.** No line in any `talk-track` rewards commenting on her skin.
12. **Discreet mode.** Skin-type or concern tokens are never in notifications; the Person's name is never sent to analytics (CLAUDE.md).

**Qualified review gate (blocking).** Before any skincare unit ships, it must be reviewed by a **licensed dermatologist or a licensed pharmacist** (two reviewers preferred: one of each), who signs off per unit in `docs/courses/skincare/SAFETY_REVIEW.md` (to be created at first review, following `docs/courses/hiking/SAFETY_REVIEW.md`). Orchestrator Sonnet review is not a substitute. Units `retinoids`, `exfoliants`, `other-actives`, `derm-vs-influencer`, `claims-evidence`, `spf-basics` and `branch-sun-and-outdoors` are highest severity. The authoring pipeline follows D-018: safety-critical and health-adjacent courses are authored by Sonnet, not Haiku; this course is health-adjacent and is treated as such.

**Licensing and media:**
- **Imagery (spec sections 18, 40).** Original vector illustrations and procedural diagrams only (`original-swoond`). No photos of skin or faces, no model likeness, no stock skin-condition images, no before/after, no real product photography.
- **Logos and trademarks.** No brand logos or trade dress in art; brand names appear as text facts in live cards only.
- **Ingredient names.** INCI names are standard identifiers; explanations are in Swoon'd's words.
- **Article and review text.** Never copy; link out; no ratings or review data (spec section 40).
- **Data terms.** Curated dated facts from regulator pages; UV index from public providers with licence to confirm; no scraping of retailers or review sites.
- **Audio / video.** None; creators' videos are never embedded; link-out only.
- **Creators.** Names appear only as facts with sources; no likeness, no fabricated quotes; no content that targets an individual creator.
- **Third parties' skin data.** No face scans, no skin analysis, no user-uploaded skin photos in this course.

## 14. Content assets

| Asset | Used by | Approach |
|---|---|---|
| Texture illustrations (gel, cream, balm, lotion, oil, essence) | `visual-id`, `term-match` | Original vector blobs on neutral ground; face-free, skin-free. `original-swoond`. |
| Packaging silhouettes (jar, tube, dropper, airless pump, stick, cushion compact) | `visual-id` | Generic, unbranded. `original-swoond`. |
| UV bands and sun-protection layers | `visual-id`, `hotspot-tap` | Procedural diagrams. `original-swoond`. |
| `skincare-skin-layers` | `hotspot-tap` | Face-free cross-section. `original-swoond`. |
| `skincare-product-label` | `hotspot-tap`, `visual-id` | Fictional label ("Example Lab", invented proportions, real INCI names). `original-swoond`. |
| Skin-tone and shade swatches | `visual-id` | Abstract swatches across a wide range; no faces. `original-swoond`. |

Estimated ~110 unique illustrations at full launch; ~40 for v1.0. Alt text must describe features, not the answer.

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. What does a beginner need to understand? Sections 2-3: barrier, routine order, moisturizer jobs, sunscreen basics, labels.
- [x] 2. What do enthusiasts care about? Section 4: ingredients, formulation, routines, K-beauty, launches, sources, debates.
- [x] 3. What current information matters? Section 6: regulation pulse, UV index, launches and explainers; all curated and dated.
- [x] 4. What should be interactive? Sections 5 and 12: recognition, label tapping, ordering, judgment, conversation.
- [x] 5. What should NOT be gamified? Anyone's skin, tone, age or condition; outcomes; doses; symptom questions; spending (section 5).
- [x] 6. How should it personalize? `region`, `brand`, `skill-level` plus optional on-device skin-type and concern flavor tokens (section 8).
- [x] 7. What does conversational competence look like? Sections 9 and 10.
- [x] 8. What data providers are needed? Curated regulator pages, public UV index, link-only news; no review or price data (`live-data.md`).
- [x] 9. What licensing constraints apply? Section 13: original art only; no skin photos, no logos.
- [x] 10. How will Swoon'd measure useful understanding? Concept mastery at 0.75; conversation items; safety habit mastery (section 10).

Additional gates: [x] manifest validates (see validator run); [ ] curriculum validates (not authored yet); [x] every Unity sim has an approved spec (none exist); [ ] every image/audio asset has a license id (assets not yet produced; plan is `original-swoond` for all); [ ] voice review; [x] no copied publisher text; [ ] **qualified dermatology/pharmacy review recorded per unit (blocking)**.

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Who is the qualified reviewer (licensed dermatologist and/or pharmacist), what is the review contract and turnaround, and do we want a named advisory board? | Product owner | **Blocks release** of every unit |
| 2 | Is an optional, on-device skin-type and concern token acceptable given that it is health-adjacent data about a third party? Default proposal: flavor tokens only, no conditions, no analytics. | Product owner / Legal | Blocks the personalization slot |
| 3 | Manifest enum: add `skin-type` and `concern` to `personalizationDimensions`? | Orchestrator | No |
| 4 | Illustration production: who produces ~40 v1.0 original illustrations (textures, packaging, diagrams, swatches)? | Product / design | Blocks `visual-id` content |
| 5 | UV index provider (EPA, NWS, Open-Meteo commercial terms). | Product owner | No (fallback link) |
| 6 | Editorial provider (L-01): link-only headlines and Swoon'd explainers. | Product owner | Blocks automated live cards |
| 7 | Legal read on naming brands and creators in live cards and on health-adjacent claims copy; consider App Store health-category implications. | Legal | No |
| 8 | Should the app include a persistent "Not medical advice" footer on every skincare lesson? Proposal: yes, on decision scenarios and the `retinoids`/`exfoliants` units. | Product owner | No |
| 9 | Facts to re-verify at release: FDA sunscreen monograph (bemotrizinol, effective 2026-08-09), EU fragrance-allergen labelling dates (31 Jul 2026 etc.), Connecticut/California youth-skincare actions, SPF/PA testing rules by region, Korea functional cosmetics and Japan quasi-drug definitions. | Content lead | No |
| 10 | Does the app need age gating for skincare content (tween-skincare lesson `di-05`)? | Product owner / Legal | Blocks `di-05` |
