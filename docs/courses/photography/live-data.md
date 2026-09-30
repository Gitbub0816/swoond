# Dynamic Data and Editorial Plan: Photography (`photography`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-38 (provider isolation, news) and, for works, section 40 (talk about works, never redistribute them). Facts below were planned on 2026-09-30 and must be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Yes, modestly, and different in kind from sports.** Photography has no scoreboard. Its live layer is **conditions** (light, sky, weather) plus **gear and culture news**. The foundation course is evergreen; the `now-in-photography` unit (`now-01` to `now-04`) and a few hooks elsewhere (`land-04`) use live cards. Nothing is real-time; hourly at most.

Do not invent more: no scores, standings, rankings, rosters or statistics (spec section 10). Do not build a "best camera" leaderboard.

## 2. Current-context layers

| Layer | Who sees it | What it is |
|---|---|---|
| Tonight's light | Anyone with `region` set | Golden hour, blue hour, moon phase and rise, cloud cover, fog; "will the sunset be any good?" |
| Sky events | Landscape branch, anyone with `region` | Meteor showers, eclipses, aurora outlook, always with the safety line |
| Gear and software news | Everyone; prioritised by `equipment`, `brand` | Launches, film stock changes, AI tool and content-credential news, explained in Swoon'd words |
| Contests and shows | Wildlife, street, film branches and `style` | Why an award or exhibition is being discussed; winners described, never shown |
| Evergreen fallback | Always | Any empty or failed provider falls back to an evergreen explainer ("what golden hour is") |

## 3. Data kinds, providers, refresh

Provider -> **Adapter** -> Swoon'd normalized entity -> course interpretation -> UI. No provider schema is the domain model.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `conditions` | "Golden hour is 7:12 tonight" | On-device astronomy maths (no provider); NOAA SWPC aurora/Kp (public) | Compute locally; SWPC via adapter | daily | Evergreen card |
| `weather` | Clouds decide the sunset | NWS API (public, US); Open-Meteo (commercial plan for a paid app); shared adapter with hiking | Adapter; only when `region` set | hourly | Hidden |
| `events` | Meteor showers, eclipses, awards | NASA and IMO calendars; awards bodies (World Press Photo, Wildlife Photographer of the Year, Sony World Photography Awards) | Curated ingest of dates and names; link-out | monthly | Snapshot |
| `releases` | Camera and lens launches | Manufacturer press pages (Canon, Nikon, Sony, Fujifilm, OM System, Panasonic, Sigma, Tamron, Leica) | Curated ingest of facts; no press images | weekly | Snapshot with date shown |
| `new-products` | Film and software changes | Kodak, Ilford, Fujifilm, CineStill, Harman; Adobe, Capture One, DxO release notes | Curated monthly note, link-out | monthly | Skip |
| `news` | "Why is everyone talking about X?" | Photography news RSS headlines (link-only); licensed publisher if L-01 resolves | Link-only headline metadata plus Swoon'd explainer | daily | Evergreen explainers |
| `alerts` | Aurora watch, severe weather | NOAA SWPC, NWS | Adapter; always with a safety line | hourly | Hidden |
| scores, standings, rankings, rosters, statistics | Not applicable | n/a | n/a | n/a | n/a |

## 4. Normalized Swoon'd entities

- `SkyConditions { regionId, date, sunrise, sunset, goldenHourStart/End, blueHourStart/End, moonPhase, moonrise, cloudCoverPct, visibilityKm, fogRisk, source, asOf }`
- `SkyEvent { id, kind (meteor-shower|eclipse|aurora|planetary), startsAt, endsAt, visibleRegions, safetyNote, sourceUrl }`
- `GearRelease { id, maker, name, category (body|lens|film|software|accessory), mount?, sensorFormat?, announcedAt, summary (Swoon'd words), sourceUrl }`
- `FilmStockChange { id, maker, stock, change (rename|discontinue|price|reintroduce), effectiveAt, sourceUrl }`
- `AwardContext { id, body, name, season, whyDiscussed (Swoon'd words), sourceUrl }` (no image fields, by design)
- `NewsItem { id, headline, publisher, publishedAt, url, explainerId? }`

## 5. Editorial plan

- Explain in Swoon'd's words; link to the source; never copy review or press text.
- Every card answers "why might she care?" using `equipment`, `brand`, `genre`, `style`.
- Award and exhibition cards describe the photographer and work in words (spec section 40); no winning image is ever embedded; link to the awarding body or photographer.
- Gear rumours are labelled as rumours; no brand cheerleading; never "X is better than Y".
- Each card shows "as of <date>" and its source.
- AI and authenticity topics (denoise, generative fill, content credentials) are explained neutrally with the debate's sides named.

## 6. Personalization hooks

| Dimension | Hook |
|---|---|
| `region` | Sun/moon times, weather, local sky events, aurora likelihood (`now-02`, `now-03`, `land-04`) |
| `equipment`, `brand` | Launch feed prioritises her mount and maker; "does it fit?" card (`now-01`) |
| `genre` | Landscape gets sky events; wildlife gets Wildlife Photographer of the Year context; film gets stock-change news |
| `style` | Contest cards favour her style's vocabulary |
| Discreet mode | Notifications never contain the Person's name; "golden hour tonight" style nudges only |

## 7. Lesson hooks (`live` unit hooks in curriculum)

| Lesson | Hook kinds |
|---|---|
| `now-01` | `releases`, `new-products`, `news` |
| `now-02` | `conditions`, `weather` |
| `now-03` | `events`, `alerts` |
| `now-04` | `events`, `news` |
| `land-04` | `conditions`, `weather` (optional card) |

Static lessons never hard-code a launch, price or date; they link to a live hook or use evergreen phrasing.

## 8. Licensing and legal notes

- Sun/moon computed on device: no licence.
- NOAA SWPC and NWS are US government public data; attribute; note NWS fair-use request limits.
- Open-Meteo: free tier is non-commercial only; a commercial plan or the shared hiking weather provider is required for the paid app (L-03 alignment).
- Manufacturer press pages: facts only; no press images, logos or spec-sheet copy.
- RSS: headlines and links only unless a publisher agreement exists (L-01).
- Awards bodies: dates and names; no winning images (spec section 40).
- Photographer names are factual references; no likenesses, no fabricated quotes.
- Shutter and UI sounds are original; no sampled manufacturer audio.

## 9. Reliability and fallbacks

Every card has a cached last-good snapshot with a date, an evergreen fallback, and hides itself rather than showing an error. Offline: conditions still compute on device. A provider outage never blocks lessons.

## 10. Open items

1. L-01 editorial/news provider (default link-only).
2. Weather provider licence decision shared with hiking (L-03).
3. Curation owner for monthly gear and film notes.
4. Safety review of solar, tide and aurora-night wording before `now-03` ships.
5. Re-verify camera launches, film stock names/prices and content-credential support at release.
