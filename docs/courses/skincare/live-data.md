# Dynamic Data and Editorial Plan: Skincare (`skincare`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context) and 32-40 (provider isolation, news, media-adjacent courses). Facts below were checked by web search on 2026-09-30 and must be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Yes, but modestly.** Skincare is evergreen at its core (barrier, routine order, filters, INCI). The current layer is thin and curated: what sunscreen and cosmetics rules have changed, today's UV index for the learner's region, what launches are being discussed, and editorial "why are people talking about this?" explainers. It is **health-adjacent and media-adjacent** (spec section 40): Swoon'd talks about products and claims, never redistributes media, never rates products, and never gives personal skin advice.

Explicitly **not** planned: prices, ratings, reviews, resale data; skin photos, face scans or skin analysis; "trending products" leaderboards; product recall push alerts (lessons link to official recall pages instead); ingredient "safety scores"; anything that scores a person's skin.

## 2. Current-context layers

| Layer | Who sees it | What it is |
|---|---|---|
| Rules pulse | Everyone | Dated explainers of label and sunscreen-rule changes |
| UV index | Learners who set `region` | Today's UV index with a one-line "what it means" and a link to the official page |
| Launch watch | `launch-culture` branch, or anyone who sets a `brand` | Dated launch facts (link-out only), with an explainer of what the term means |
| Why people are talking | Everyone | Swoon'd-written explainers that link to original coverage |
| Evergreen fallback | Always | If any card is missing, an evergreen explainer ("What is broad spectrum?") |

## 3. Data kinds, providers, refresh

External providers never become the domain model (spec section 32): Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `regulations` | Label meaning changes | FDA OTC monograph pages, Federal Register; EUR-Lex / European Commission cosmetics pages; Korea MFDS and Japan MHLW pages (curated) | **Curated ingest** by editors with source links; "as of" date on each card | monthly | Dated card |
| `conditions` | UV index for `region` | EPA UV Index, NWS, Open-Meteo (licence to confirm) | Adapter to a normalized `UVIndexReading`; no derived health advice | hourly | "Check your local UV index" link |
| `releases`, `new-products` | Launch vocabulary and conversation hooks | Official brand announcement pages | Link-out only; store dates as facts; never scrape retailers or review sites | weekly / monthly | Hide card |
| `news` | Why people are talking about X | Health-agency pages; trade and mainstream beauty media | **Link-only** headlines/metadata where licence allows; Swoon'd writes the explainer | daily | Evergreen explainer |

### Snapshot as of 2026-09-30 (illustrative; not hard-coded in lessons) [verify at release]
- **US sunscreen:** The FDA issued a final order adding bemotrizinol to the OTC sunscreen monograph on 2026-06-09, effective 2026-08-09, reported as the first new US sunscreen active in about 26 years; products using it are expected late 2026 or 2027. Europe and Asia have long had more UV filters than the US, so regional sunscreen talk differs.
- **EU cosmetics:** Expanded fragrance-allergen labelling (around 56 additional allergens) phases in between 2026 and 2028, with a 2026-07-31 marker for some products; several CMR ingredient bans applied from 2026-05-01. Details must be checked against official EU texts before any card ships.
- **Youth skincare ("Sephora kids"):** In April 2026 the Connecticut Attorney General announced safeguards agreed with a large beauty retailer around marketing anti-aging products to children; California has considered AB 728 on sales of anti-aging skincare to minors. Status and details must be checked against primary sources; any card is framed as "what people are debating", never as advice.

## 4. Editorial approach

- **Explain and link.** Swoon'd's own words; link to the original publisher. Never copy review, article or press-release text.
- **Topics we explain:** what a new sunscreen rule means for labels; what a label term means; why dermatologists worry about a viral trend; what a launch or reformulation is; what a regional claim category means.
- **Sources (link-only, licence to be confirmed, open item L-01):** FDA, American Academy of Dermatology, NHS, WHO, European Commission; trade and mainstream beauty media as headlines only.
- **Guardrail on every safety-adjacent card:** "This is general information. For your own skin, ask a dermatologist or pharmacist."
- **Example prompts:** "Why are people talking about this sunscreen rule?" "What does this new label term mean?" "Why are dermatologists worried about this trend?"

## 5. Licensing and spec section 40 posture

| Asset | Posture |
|---|---|
| Product and skin photography | Never bundled or hotlinked; link-out only |
| Creator or brand video | Link-out; no embeds by default |
| Logos, trade dress | Not reproduced; text mentions only |
| Creator and brand names | Facts only; no likeness, no fabricated quotes |
| Reviews, ratings and articles | Paraphrase and link; no copying; no ratings data |
| Illustrations | All original (`original-swoond`) |
| Data | Curated facts with attribution and dates; no scraping of retailers or review sites; no unofficial APIs |

## 6. Personalization hooks

- `region`: UV index card, home regulator's label terms (US, EU, Korea, Japan); default none, hidden when unset.
- `brand`: launch and news cards for a brand she loves; default none. A card never says a brand is good or bad.
- `skill-level`: which explainers surface (beginner label explainers vs formulation nerd cards); default beginner.
- Optional on-device `{{skinType}}` and `{{concern}}` flavor tokens choose *examples* only; they never filter live safety content and never leave the device (CDS section 8).

## 7. Failure modes

Provider or curation gaps never block lessons: every live hook has an evergreen fallback; every fact card carries its "as of" date; no card is shown past its staleness limit (UV index 3 hours, rules pulse 90 days, launch cards 30 days) without a "check the source" notice. A regulation card whose source cannot be re-verified is hidden, not guessed.
