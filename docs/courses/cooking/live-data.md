# Dynamic Data and Editorial Plan: Cooking (`cooking`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-37 (provider isolation) and 38-40 (current-context layer, licensing, media). Facts below were checked by web search on **2026-09-30** and should be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Barely, and that is the honest answer.** Cooking is an evergreen-technique course: the reasons food browns, why salt goes in layers and what 165 F means do not change with the news cycle. Spec section 10 says not to invent artificial live-data needs. There are no scores, standings, rosters or rankings worth tracking. What *does* change, and what a cook's friend actually talks about, is:

1. **What is in season** near her (produce and, lightly, seafood).
2. **The calendar** (holiday tables, grilling season, a baking season) and the food-safety advice that comes with it.
3. **Food recalls and safety alerts** (a real, useful "why is everyone posting about this?" moment), link-out only.
4. **What is on the food screen and shelf** (show seasons and finales, notable cookbook releases, awards) as cultural talking points.
5. **Optional grilling weather** for the `bbq-grilling` branch.

Everything else stays evergreen. Do not add live restaurant ratings, price feeds, nutrition data, calorie counters or recipe feeds.

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Seasonal kitchen | Everyone; sharper with `region` set | What is in season this month, how to pick and cook it, one technique tie-in |
| Holiday table | Everyone (calendar-driven) | Plan, thaw, cook and store a holiday meal safely; USDA guidance in Swoon'd words |
| Recall explainer | Everyone (opt-in card) | What a recall means, what to check, link to the agency notice |
| Food screen and shelf | Learners with media interest | What is on now (shows, finales, cookbooks, awards) and questions to ask her |
| Grill weather | `bbq-grilling` branch with `region` set | "Can we grill tonight?" (wind, rain, heat) |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer ("How to read a seasonal calendar") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. No provider schema becomes the domain model. Candidates only; every one sits behind a Swoon'd adapter.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `conditions` (seasonal produce) | "What's in season?" | USDA and state Extension seasonal-produce guides (curated); Swoon'd editorial seasonal table | **Curated ingest** by month and region; no live API needed | monthly | National seasonal table |
| `events` | Holiday cooking, awards | Swoon'd editorial calendar; James Beard Foundation and Michelin Guide pages (link-only) | Curated | seasonal | Evergreen holiday card |
| `new-media` | Show seasons, cookbooks | Swoon'd editorial media calendar; network and publisher press pages (link-only); TVmaze or TMDB only after licence review | Curated at first; adapter later if licensed | monthly | Evergreen media units |
| `schedules` | "What's on this month" | Network schedules (curated, link-out) | Curated | monthly | Hidden |
| `alerts` (food recalls) | Recall explainer | USDA FSIS recall data; FDA recalls and openFDA food enforcement | Public government sources via adapter; link-out to the agency notice; Swoon'd writes the explainer | daily | Hidden; evergreen "what to do" card |
| `weather` | Grill weather | National Weather Service API | Adapter, `region` required; NWS needs a custom User-Agent | hourly | Hidden |
| `news` | "Why is everyone arguing about this?" | Publisher headlines (link-only); USDA and FDA news pages | Link-only ingestion where licence allows; Swoon'd explains | daily | Evergreen explainers |

### Time-sensitive facts to keep dated **[verify at release]**

- **USDA FSIS safe minimum temperatures** (verified 2026-09-30): poultry 165 F (74 C); ground meat 160 F (71 C); whole cuts of beef, pork, lamb and veal 145 F (63 C) with a 3-minute rest; fish 145 F; egg dishes 160 F; leftovers and casseroles 165 F. Danger zone 40 to 140 F. Refrigerate within 2 hours (1 hour above 90 F). Leftovers 3 to 4 days. Three safe thawing methods (refrigerator, cold water changed every 30 minutes, microwave then cook immediately). Do not wash raw poultry. These live in evergreen lessons because they change rarely, but re-check yearly and at each release.
- **FDA Food Code** (food businesses): the 2022 edition is the current edition as of 2026-09-30; cooling rule 135 F to 70 F within 2 hours, then to 41 F within a further 4 hours (6 total). Home lessons cite USDA; the Food Code only appears in "how restaurants do it" lessons.
- **Media facts** (dated cards only, never hard-coded in evergreen lessons): *The Bear* is ending with season 5, released 25 June 2026 (Hulu/Disney+ and weekly on FX); *Top Chef* season 23 (Bravo, the Carolinas) premiered 9 March 2026 and finished 8 June 2026; the 2026 James Beard Awards named Michael Tusk of Quince (San Francisco) Outstanding Chef. Re-verify before any media card ships.

## 4. Normalized entities (Swoon'd-owned)

| Entity | Fields | Source kind |
|---|---|---|
| `SeasonalItem` | id, name, category (produce, seafood, other), regionCode, monthStart, monthEnd, cookingTip (Swoon'd text), conceptIds, source, lastVerified | conditions |
| `HolidayCard` | id, name, date rule, safetyChecklistIds, conceptIds, editorialText, links | events |
| `FoodAlert` | id, agency (USDA-FSIS, FDA), title (as text or link only), date, productCategory, url, swoondExplainerId | alerts |
| `MediaCard` | id, kind (show, finale, cookbook, award), title, creator or network as text, dateRange, editorialText, conversationHooks, url | new-media, events |
| `GrillWeather` | regionCode, hourly forecast summary, wind, precipitation chance, heat index, updatedAt | weather |
| `EditorialTopic` | id, headline (link-out only), sourceName, url, swoondExplainer, conceptIds, publishedAt | news |

Adapters own the mapping; nothing downstream sees an agency or publisher schema.

## 5. Editorial plan (spec sections 11, 39-40)

- **Approach:** explain and link (manifest `editorial.approach = explain-and-link`). Swoon'd writes a short explainer in its own voice, tags the relevant concepts, adds "what to ask her" prompts, and links to the original.
- **Never copied or redistributed:** recipes, cookbook text, publisher article text, show clips, food photography, restaurant reviews. Recipes are creative expression; a technique or a ratio is taught in Swoon'd's words with original examples. Works (books, shows, films) are named and discussed as facts, per spec section 40.
- **Topics we explain:** why a recall matters and what a cook does; why holiday food-safety warnings repeat; why a technique or "myth" is trending; what a star or a Beard award means; what is in season; why a finale is being discussed (spoiler-safe).
- **Spoiler policy:** media cards default to no plot details and include a "no spoilers" tag; talk tracks use the no-spoiler rule as a feature.
- **Example prompts:** "Why is her feed full of people arguing about pasta water?", "What is a food recall and should she care?", "It's peak tomato season: what should I cook?", "The finale is out. What can I ask her without spoilers?"
- **Safety guardrails on generated live content:** recall cards never give medical advice; holiday cards restate USDA guidance verbatim in meaning, never loosen a number; any generated scenario passes a food-safety linter that rejects temperatures below USDA minimums, "color = done" claims, room-temperature thawing and raw-egg encouragement (see `NOTES_FOR_ORCHESTRATOR.md`).

## 6. Personalization hooks (spec section 12)

| Dimension | Effect on live layer | Default |
|---|---|---|
| `region` | Seasonal table, grill weather, holiday variants | national table, no weather |
| `cuisine` | Seasonal tips and holiday cards prefer the cuisine (Mexican holiday tamales, Italian feast) | home cooking |
| `equipment` | Cards mention the tool she owns (smoker, Dutch oven, cast iron) | a good pan and a sharp knife |
| `skill-level` | "Try this" tips scale in difficulty | home cook |
| `style` | Weeknight tips vs project cooking vs baking | weeknight cook |

## 7. Failure modes

- Provider down or empty: hide the card, show the evergreen fallback; never show stale recalls without a date.
- Curated table out of date: cards carry `lastVerified`; older than 45 days are hidden.
- Licence unclear (TVmaze, TMDB): curated calendar only.
- Never show a recall, weather or media card as if real-time when it is a snapshot; always show the date.

## 8. Licensing summary

USDA FSIS, FDA and NWS are US-government sources (verify terms and rate limits at adapter build). Publisher and network content is link-only. Award pages (James Beard, Michelin) are facts plus links, no logos. TVmaze and TMDB require licence review. No images or audio from any provider.
