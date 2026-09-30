# Dynamic Data and Editorial Plan: Pottery (`pottery`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-37 (provider isolation) and 38-40 (current-context layer, licensing, media). Facts below were checked by web search on **2026-09-30** and should be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Only a thin, curated layer, and that is the honest answer.** Pottery is an evergreen-craft course: why bases S-crack, what cone 6 means and how glaze fits do not change with the news. Spec section 10 says not to invent artificial live-data needs. There are no scores, standings, rosters or rankings to track. What *does* change, and gives the learner something real to say:

1. **The craft calendar:** fair season, open-studio weekends, Empty Bowls charity events, holiday sales, the annual NCECA conference.
2. **What is on screen and on show:** new series of *The Great Pottery Throw Down* and spin-offs, exhibitions, notable books.
3. **Safety alerts:** FDA and CPSC notices about ceramicware (lead), link-out only.
4. **Where she works (optional):** a directory of studios by region.
5. **Light news:** "why is everyone sharing this?" explainers.

Do not add live auction prices, clay or glaze price feeds, social feeds of pottery photographs or a "trending pots" feed (no redistributable imagery; spec section 40).

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Fair season and open studios | Everyone; sharper with `region` set | What a craft fair, open studio and Empty Bowls event are, and what to ask her about them |
| On screen and on show | Learners with media interest | What is on now (series, exhibitions, books) and questions to ask her, spoiler-safe |
| The ceramics calendar | Everyone | Annual moments (NCECA), seasonal firing and sale cycles |
| Ceramicware alert explainer | Everyone (opt-in card) | What a lead alert means, what to check, link to the agency notice |
| Studio finder (optional) | With `region` set | Studios and craft shops near her |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. No provider schema becomes the domain model. Candidates only; every one sits behind a Swoon'd adapter.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `events` | Fair season, open studios, NCECA | Swoon'd editorial craft calendar; NCECA and museum event pages (link-only) | **Curated ingest** with links; region tag optional | seasonal | Evergreen "how craft fairs work" card |
| `new-media` | Show series, exhibitions, books | Swoon'd editorial media calendar; Channel 4 and publisher press pages (link-only); TVmaze/TMDB only after licence review | Curated at first; adapter later if licensed | monthly | Evergreen media lessons |
| `alerts` | Ceramicware lead explainer | FDA ceramicware and lead pages and recalls; CPSC recalls | Public government sources via adapter; link-out to the agency notice; Swoon'd writes the explainer | daily | Hidden; evergreen `safe-06` and `now-04` |
| `conditions` | Optional studio finder | OpenStreetMap craft and shop tags (ODbL); Swoon'd curated list | Adapter with region filter; coverage varies; attribution required | monthly | Hidden |
| `news` | "Why is everyone sharing this?" | Publisher headlines (link-only); NCECA and museum news pages | Link-only ingestion where licence allows; Swoon'd explains | weekly | Evergreen explainers |

### Time-sensitive facts to keep dated **[verify at release]**

- **NCECA 2027 conference:** "Charm", Baltimore, Maryland (Baltimore Convention Center), 10 to 13 March 2027 (verified 2026-09-30 via the NCECA site).
- ***The Great Pottery Throw Down*:** series 9 aired on Channel 4 in early 2026 (finale 8 March 2026); winner Fynn (Cornwall); filmed at Gladstone Pottery Museum, Stoke-on-Trent; host Siobhan McSweeney, judges Keith Brymer Jones and Rich Miller; *The Great Celebrity Pottery Throwdown* announced for Channel 4 from 13 September 2026 (verified 2026-09-30, confirm dates and titles before any card ships). Media cards are dated cards only, never hard-coded in evergreen lessons, and default to no plot or result spoilers.
- **OSHA silica limits** (workplace): PEL 50 ug/m3 8-hour TWA, action level 25 ug/m3 (verified 2026-09-30). Used only in `safe-01` context.
- **FDA ceramicware guidance:** leachable-lead limits exist for ceramic tableware; FDA has warned about traditional and unlabelled or "lead free"-labelled imported pottery with high extractable lead (verified 2026-09-30). Alert cards restate agency guidance in meaning and never loosen it.
- **Cone temperatures** (Orton, slow rate): cone 06 about 1,830 F; cone 04 about 1,945 F; cone 6 about 2,232 F; cone 10 about 2,345 F. These vary with heating rate and are taught as approximate.

## 4. Normalized entities (Swoon'd-owned)

| Entity | Fields | Source kind |
|---|---|---|
| `CraftEvent` | id, kind (craft-fair, open-studio, empty-bowls, conference, exhibition), name (text), regionCode (optional), dateRange, conceptIds, editorialText, url | events |
| `MediaCard` | id, kind (show, series, finale, exhibition, book), title, creator or network as text, dateRange, spoilerLevel, editorialText, conversationHooks, url | new-media |
| `CeramicAlert` | id, agency (FDA, CPSC), title (text or link only), date, productCategory, url, swoondExplainerId | alerts |
| `StudioListing` | id, name, kind (community-studio, gallery, supply-shop), regionCode, url, source, attribution, lastVerified | conditions |
| `EditorialTopic` | id, headline (link-out only), sourceName, url, swoondExplainer, conceptIds, publishedAt | news |

Adapters own the mapping; nothing downstream sees an agency or publisher schema.

## 5. Editorial plan (spec sections 11, 39-40)

- **Approach:** explain and link (manifest `editorial.approach = explain-and-link`). Swoon'd writes a short explainer in its own voice, tags the relevant concepts, adds "what to ask her" prompts, and links to the original.
- **Never copied or redistributed:** publisher article text, exhibition catalogue text, glaze recipe sets, photographs of pots or potters, show clips. Works, makers and events are named and discussed as facts (spec section 40).
- **Topics we explain:** why a ceramicware lead alert matters and what a person does; what a craft fair, open studio or Empty Bowls event is; why a piece is priced as it is; what an exhibition or conference is and why she cares; why a finale is being discussed (spoiler-safe).
- **Spoiler policy:** media cards default to no plot or result details and include a "no spoilers" tag; talk tracks use the no-spoiler rule as a feature.
- **Example prompts:** "Why is her feed full of kiln-opening posts?", "What is Empty Bowls?", "There is a lead alert on imported ceramics: should she care?", "The show is back: what can I ask her without spoilers?"
- **Safety guardrails on generated live content:** alert cards never give medical advice or certify any ware; they restate agency guidance and link out; any generated scenario passes a pottery-safety linter that rejects dry sweeping or sanding as acceptable, paper masks as silica protection, opening a hot kiln, home kiln installation advice, and "handmade means food safe" (see `NOTES_FOR_ORCHESTRATOR.md`).

## 6. Personalization hooks (spec section 12)

| Dimension | Effect on live layer | Default |
|---|---|---|
| `region` | Local fair season, open studios, studio finder; regional traditions as talking points | national calendar, no directory |
| `style` | Cards prefer her kind of clay (functional, sculptural, atmospheric, glaze) | functional wheel-thrown ware |
| `equipment` | Cards reference studio vs home setup for tone only (never installation advice) | a community studio wheel and a shared kiln |
| `skill-level` | "Ask her about this" prompts scale in depth | hobbyist |

## 7. Failure modes

- Provider down or empty: hide the card; show the evergreen explainer.
- Stale dates: cards show a "checked on" date and expire after the date range.
- Alert card with no agency link: never shown.
- Studio directory with thin coverage: hidden rather than shown sparse; no ratings ever.
- Licence change (TVmaze, TMDB, OpenStreetMap): the adapter is swapped; nothing downstream changes.
