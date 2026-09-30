# Dynamic Data and Editorial Plan: Wine (`wine`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-37 (provider isolation) and 38-40 (current-context layer, licensing, media). Facts below were checked by web search on **2026-09-30** and should be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**A little, and it is mostly editorial.** Wine is an evergreen knowledge course: what tannin is and how Champagne is made do not change with the news. Spec section 10 says not to invent live-data needs. There are no scores, standings or rosters, and **Swoon'd deliberately does not ingest prices, ratings or critic scores** (proprietary, speculative, and they push the course toward collecting and spending). What does change, and what an enthusiast mentions at dinner:

1. **The harvest and the vintage** (how the season went, in words).
2. **The calendar** (harvest, Beaujolais Nouveau on the third Thursday of November, rosé season, holiday tables, Dry January and Sober October respected, wine weeks).
3. **Release cycles** (en primeur campaigns, new vintage releases, hyped bottles), as conversation topics only.
4. **Industry news** (tariffs, falling consumption and the rise of no/low, climate and smoke events, label rules).
5. **Optional alerts** (wildfire smoke and frost affecting a vintage; a recall explainer), link-out.

Everything else stays evergreen. Do not add live inventory, store locators, delivery, price feeds or rating feeds.

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Harvest watch | Everyone; sharper with `region` set | How this year's season is going or went, why it matters, one structure concept tie-in |
| Wine calendar | Everyone (calendar-driven) | Beaujolais Nouveau, harvest, rosé season, holiday table, Dry January; always with a zero-proof note |
| Release radar | Learners with collecting interest | What a campaign is, why a bottle is hyped, questions to ask her; no prices |
| Wine in the news | Everyone (opt-in card) | Tariffs, consumption trends, climate, regulation; Swoon'd explainer plus link-out |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer ("How to read a vintage report") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. No provider schema becomes the domain model. Candidates only; every one sits behind a Swoon'd adapter.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `conditions` | Harvest and season summaries | Swoon'd editorial; Open-Meteo, NOAA, Copernicus (climate summaries; Open-Meteo free tier is non-commercial, paid plan needed for commercial use); regional wine bodies (link-out) | Curated ingest by region and season; optional climate adapter later | seasonal | Evergreen vintage lesson |
| `events` | Calendar | Swoon'd editorial calendar; organizer pages (link-only) | Curated | seasonal | Evergreen calendar |
| `releases` | En primeur, new vintages | Swoon'd curated calendar; trade press headlines (link-only) | Curated; no prices | seasonal | Evergreen explainer |
| `news` | "Why is everyone talking about this?" | Publisher headlines (link-only); OIV and trade bodies (link-out) | Link-only ingestion where the licence allows; Swoon'd writes the explainer; provider decision open (L-01) | weekly | Evergreen explainers |
| `regulations` | Label and alcohol rules | TTB notices; EU Commission; OIV (link-out) | Curated; link-out | on-release | Hidden |
| `alerts` | Smoke taint, frost, recalls | NIFC and AirNow (public); FDA and TTB notices (link-out) | Adapter with `region`; explainer is Swoon'd's; no health advice | daily | Hidden |
| `new-products` | No/low launches | Swoon'd editorial | Curated | monthly | Hidden |

### Time-sensitive facts to keep dated **[verify at release]**

- **OIV, State of the World Wine Sector 2025** (published 2026): production about 227 million hectolitres (up about 0.6 percent on 2024 and about 9.4 percent below the five-year average, the third consecutive low year); consumption about 208 million hectolitres (down about 2.7 percent, lowest since 1957); world vineyard area about 7 million hectares (sixth consecutive decline); the US remains the largest consuming market (about 31.9 million hectolitres, down about 4.3 percent); trade volume and value fell in 2025 amid tariffs. Cited as a dated card, never hard-coded in evergreen lessons.
- **US Dietary Guidelines 2025-2030** (released 7 January 2026): advise people to consume less alcohol for better overall health, without the numeric daily limits of earlier editions. Link-out only; Swoon'd does not restate numbers as advice.
- **Tariffs and trade:** US tariff treatment of EU and other wine changed repeatedly in 2025; any tariff card must be dated and refreshed weekly, or hidden.
- **Calendar rules:** Beaujolais Nouveau release is the third Thursday of November; Dry January is an annual month-long movement; dates are computed from rules in the adapter, not hard-coded.

## 4. Normalized entities (Swoon'd-owned)

| Entity | Fields | Source kind |
|---|---|---|
| `HarvestCard` | id, regionCode, season, summary (Swoon'd text), conceptIds, sources (links), lastVerified | conditions |
| `WineEvent` | id, name, date rule, regionCode, noLowNote, conceptIds, editorialText, links | events |
| `ReleaseCard` | id, kind (en-primeur, new-vintage, hyped-bottle), regionCode, editorialText, conversationHooks, links | releases |
| `EditorialTopic` | id, headline (link-out only), sourceName, url, swoondExplainer, conceptIds, publishedAt | news, regulations |
| `WineAlert` | id, type (smoke, frost, recall), regionCode, title (text or link only), date, url, swoondExplainerId | alerts |

Adapters own the mapping; nothing downstream sees a provider or publisher schema.

## 5. Editorial plan (spec sections 11, 39-40)

- **Approach:** explain and link (manifest `editorial.approach = explain-and-link`). Swoon'd writes a short explainer in its own voice, tags the concepts, adds "what to ask her" prompts, and links to the original.
- **Never copied or redistributed:** publisher article text, critic scores, tasting notes, label or bottle images, winery marketing copy. Works and people are named as facts (spec section 40); Swoon'd talks about wine, it does not redistribute anyone's content.
- **Topics we explain:** why a harvest matters; what tariffs or climate mean for what she can buy; why consumption is falling and no/low is rising; why people argue about natural wine; what a classification or label word means; why a release or auction is being discussed.
- **Example prompts:** "Why is everyone talking about tariffs on wine?", "What does it mean that this harvest came early?", "Beaujolais Nouveau is out; what is it, and what can I ask her?", "Why are restaurants listing zero-proof wines?"
- **Guardrails on generated live content:** no health or medical claims; no content that encourages drinking more, faster or as a challenge; no price or score; every card with a drinking angle carries a zero-proof or skip-it note; an alcohol-content linter rejects health claims, "chug", "finish the bottle" and pressure language.

## 6. Personalization hooks (spec section 12)

| Dimension | Effect on live layer | Default |
|---|---|---|
| `region` | Harvest and news cards prefer her region; alerts filtered to it | world-tour (mixed regions) |
| `style` | Release and calendar cards prefer her grape or style (bubbles at new year, rosé in summer) | everyday |
| `cuisine` | Seasonal pairing tips prefer her cuisine | home cooking |
| `skill-level` | Depth of explainers | curious beginner |

## 7. Failure modes

- Provider down or empty: hide the card, show the evergreen fallback; never show stale news without a date.
- Curated table out of date: cards carry `lastVerified`; older than 60 days are hidden.
- Licence unclear (climate APIs, headline providers): curated editorial only.
- Never present a snapshot as real-time; always show the date. Never show a card if its only angle is buying or price.

## 8. Licensing summary

OIV and trade statistics are cited facts with links (verify reuse terms). Publisher and critic content is link-only. No images or audio from any provider. Open-Meteo, NOAA and Copernicus need terms review before commercial use. Wine-Searcher, Vivino, Liv-ex and critic databases are not used (proprietary, no scraping, and the course does not want prices).
