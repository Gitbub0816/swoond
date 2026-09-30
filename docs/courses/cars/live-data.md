# Dynamic Data and Editorial Plan: Cars (`cars`)

Implements product spec sections 10-12 (structured current data, editorial, personalized context) and 32-37 (provider isolation, news). Facts below were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Cars is a medium-live subject: the evergreen mechanics carry most of the course, and a small current layer (`now-in-cars`) keeps it socially useful. Spec section 40 applies to cars as a *media-adjacent* subject: Swoon'd talks about cars, models and the culture; it never redistributes manufacturer photography, press images, video or audio, and never republishes reviews.

## 1. Verdict: is there meaningful live data?

**Yes, modestly.** Not scores or standings (motorsport results belong to NASCAR/F1). What the person you care about actually mentions weekly: a new model or reveal, a recall, an EV-policy or charging headline, an event, what is newly import-eligible, gas prices. Do not invent more: no VIN-level valuations, no live auction feeds, no telemetry.

## 2. Current-context layers

| Layer | Who sees it | What it is |
|---|---|---|
| New models and launches | Everyone; make-filtered if `brand` set | This model year's launches, reveals, refreshes and cancellations, in Swoon'd words with a source link |
| Recalls | Everyone; her make first | NHTSA recall notices explained calmly: what it covers, what an owner does |
| EV and policy context | Everyone; deeper for `ev-tech` | Market share, charging network and policy headlines (tax credits, tariffs, emissions rules) with dated snapshots |
| Events calendar | Everyone; region-filtered | Car Week, festivals, shows, SEMA, track-day seasons |
| Import eligibility | `jdm-tuner` and anyone who asks | What became 25 years old this month (curated list) |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer ("How a model year works") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. Every candidate below sits behind a Swoon'd adapter; no provider schema becomes the domain model.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Licensing notes | Fallback |
|---|---|---|---|---|---|---|
| `new-products` | Models, years, makes for personalization | NHTSA vPIC (makes, models, VIN decode); fueleconomy.gov vehicle list (EPA/DOE); manufacturer newsrooms (facts only) | vPIC and fueleconomy.gov via adapter; press facts curated with source links | weekly | US government data; check each dataset's terms; press images not used | Evergreen card |
| `releases` | Reveals and launches | Curated calendar | Editors enter and verify with source URLs and `verifiedAt` | weekly | Facts only; no images | Skip |
| `alerts` (recalls) | Owner-relevant, safe | NHTSA recalls API (public) | Adapter by make/model/year | daily | US government data; never present as legal advice | "What is a recall" card |
| `statistics` | Efficiency, EV and hybrid share | fueleconomy.gov API; DOE Alternative Fuels Data Center (station counts, key needed); Cox Automotive, Argonne, Alliance for Automotive Innovation summaries | Adapter for government data; curated own-words snapshot for market summaries | monthly / quarterly | AFDC attribution; summaries link out, never copied | Snapshot with date |
| `events` | Car Week, festivals, shows | Curated; organizer sites | Editors verify; link-out | monthly | Dates and names are facts; no logos | Evergreen guide |
| `regulations` | Policy and import rules | EPA, NHTSA, European Commission, CBP pages | Links + Swoon'd explainer | on-release | Own-words explainer | Evergreen |
| `conditions` (fuel prices) | Gas-price talk | EIA weekly retail prices (public) | Adapter | weekly | US government data | Hidden |
| `news` | Editorial | Publisher RSS (link-only); manufacturer newsrooms | Metadata and headline only where licence allows; Swoon'd writes the explainer | daily | No article text; provider decision open (L-01) | Evergreen |
| Charger locations (optional) | `ev-tech`, `region` | Open Charge Map (attribution), AFDC | Adapter | monthly | Attribution required; never as navigation | Hidden |
| Valuations (optional, later) | Collector talk | Hagerty, KBB, Edmunds (partner APIs) | Only with a signed agreement | n/a | Not assumed | Not offered |
| Auction results | Rejected as structured data | Bring a Trailer, Cars & Bids, RM Sotheby's, Mecum | No open commercial API; scraping violates terms | n/a | Link-out only; curated editorial note on a notable sale | n/a |

### Facts as of 2026-09-30 [verify at release]
- **US EV market:** the federal EV purchase credit ended for vehicles acquired after 2025-09-30. US all-electric sales were about 462,900 in H1 2026, down about 24 percent year over year; Q2 2026 sales were about 247,000 (up about 15 percent on Q1); EV share about 6 percent in the latest quarter, versus a pre-expiry peak near 11 percent; hybrids hit a record 16 percent of new light-vehicle sales in Q2 2026. Sources: Inside Climate News (2026-07-16), KBB, industry summaries.
- **Charging:** NACS (Tesla-origin plug) is being built into new non-Tesla EVs (e.g. 2026 Toyota bZ, Hyundai Ioniq 5); US public charging ports grew about 35 percent in 2025 to more than 242,000; Tesla operates over 3,000 Supercharger stations. Verify counts at release.
- **EU 2035:** in December 2025 the European Commission proposed replacing the 100 percent CO2 cut for new cars with a 90 percent cut, keeping plug-in hybrids, range extenders and some combustion engines beyond 2035; as of September 2026 it is still moving through Parliament and Council. Never present as final law.
- **25-year import rule:** eligibility is by manufacture month, not model year; 2001-built cars (including late Skyline GT-Rs) become eligible through 2026. The rule lists are curated each January and month by month.
- **Model availability** (Charger/Challenger V8 status, Camaro hiatus, which cars still offer a manual, tariffs on imports) changes fast; none is hard-coded. Tagged for verification in NOTES.

## 4. Normalized Swoon'd entities (provider-agnostic)

| Entity | Key fields | Notes |
|---|---|---|
| `CarModel` | `id`, `make`, `model`, `modelYear`, `bodyStyle`, `powertrain` (`ice`/`hev`/`phev`/`bev`), `segment`, `sourceURL`, `verifiedAt` | From vPIC/fueleconomy.gov; `make` drives personalization |
| `LaunchNote` | `id`, `modelId?`, `kind` (reveal/refresh/cancel/revive), `date`, `summaryKey`, `sourceURL` | Copy in Swoon'd words |
| `Recall` | `id` (NHTSA campaign), `make`, `model`, `years`, `component`, `summaryKey`, `remedyKnown`, `sourceURL` | Explain calmly; link to NHTSA |
| `EfficiencyFact` | `modelId`, `mpge` or `miPerKwh`, `rangeMi`, `source`, `snapshotDate` | fueleconomy.gov |
| `MarketSnapshot` | `region`, `metric` (ev-share, hybrid-share), `value`, `period`, `sourceURL` | Own-words card with date |
| `PolicyNote` | `jurisdiction`, `topic`, `status` (proposed/enacted), `effectiveDate`, `summaryKey`, `sourceURL` | Never states proposals as law |
| `EventEntry` | `id`, `name`, `kind` (show/festival/track-season/expo), `start`, `end`, `city`, `country`, `sourceURL`, `verifiedAt` | No logos |
| `ImportEligibility` | `make`, `model`, `buildMonth`, `eligibleMonth`, `notes`, `sourceURL` | Curated list |
| `FuelPrice` | `region`, `fuel`, `price`, `week` | EIA |
| `EditorialCard` | `id`, `topic`, `conceptIds[]`, `explainer`, `links[]`, `publishedAt`, `expiresAt` | Curated |

## 5. Editorial plan

- **Approach:** `explain-and-link`. Identify the topic (from RSS headlines or editor picks), teach the concept, say why enthusiasts care, link out. Never copy article text or reviews; never reproduce third-party ratings.
- **Cadence:** 3-5 cards per week for `now-in-cars`; each card has `conceptIds` so it feeds mastery and review; each expires (default 30 days).
- **Templates:** "Why is everyone talking about ...?" (a reveal, cancellation, revival), "What is this recall?", "What does this policy change mean?", "What became legal this month?", "Where should I go this season?"
- **Voice:** warm, curious, never picks a make as best; passes the "never about the crush" rule.

## 6. Personalization hooks

| Slot | Source | Behavior |
|---|---|---|
| `{{make}}`/`{{model}}` | Person profile | Filters new-model, recall and event cards; unset shows a balanced mix |
| `{{scene}}` | Branch | Prioritizes cards relevant to the scene (muscle, JDM, Euro, EV, trucks, classics) |
| `{{region}}` | Person profile | Units, plugs, events, import and inspection rules |
| Owned-car interest | Optional | "Is there a recall for a car like hers?" card (no VIN stored; make/model/year only) |

## 7. Refresh, failure and privacy

- Each provider is behind an adapter with a health check; cards degrade to evergreen explainers with a "last updated" note when data is stale beyond 2x cadence.
- No VINs, plates or locations are collected; region is coarse. Discreet mode notifications never include the Person's name.
- Legal: NHTSA and EPA/DOE data are US government works; keep source attribution. Manufacturer pages are cited as sources, not mirrored.
