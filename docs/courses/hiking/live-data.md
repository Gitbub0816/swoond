# Hiking: Current-Context Plan (live data)

Applies product spec sections 10, 11, 32, 37, 38 and 39. Hiking is **not modeled as a sport**: no scores, standings, seasons, rosters or leaderboards. The only dynamic information that earns its place is what changes a real decision: **weather, conditions, closures, alerts, air quality, seasonal windows, permits**. Everything else stays evergreen.

Facts marked "verified 2026-09-30" were checked by web search on that date; everything else is a design assumption to confirm at build time. Provider terms and endpoints change: re-verify each row before implementation and record changes in `DECISIONS.md`.

## 1. Principles

1. **Adapter first (spec section 32).** Every provider sits behind a Swoon'd-owned adapter that returns normalized types (`ConditionSnapshot`, `TrailAlert`, `AirQualityReading`, `SeasonalWindow`, `PermitWindow`). No provider schema reaches the domain model or the native UI.
2. **Structured data and editorial are separate systems.** Structured: NWS, NPS, USGS, NRCS, AirNow, NIFC. Editorial: agency press releases and trip reports, which we only summarize in our own words and link (spec section 11).
3. **Never hard-code live data in lessons.** Static lessons use `live` unit hooks (`seasonal-conditions-layer`) and `{{tokens}}`.
4. **No unofficial or reverse-engineered APIs (spec section 39).** AllTrails is deep-link only until a partnership exists. Recreation.gov permit *availability* is likewise deep-link only (the public RIDB does not expose real-time availability, and its reservation endpoints are not a published public API).
5. **Live conditions are context, not clearance.** Every conditions card carries "Confirm with the land manager before you go" and a link to the source. Swoon'd never says a hike is safe, only what the current data says.
6. **Privacy.** Location use is optional, coarse (region/park/trail), on demand, and never combined with the Person's name. Notifications about conditions follow discreet mode (never name the Person).
7. **Stale is labeled.** Each card shows "Updated <time>" and greys out after its TTL; offline shows the last snapshot with its age.

## 2. What we need, by kind (manifest `dynamicData`)

| Kind | Needed? | Why it matters to learning | Provider candidates (behind adapters) | Refresh | Fallback when down |
|---|---|---|---|---|---|
| weather | Yes | Point forecasts, heat risk, wind, thunderstorm timing drive every turnaround lesson and the "Is it hikeable today?" lessons | NWS API (`api.weather.gov`) primary; Open-Meteo or a commercial forecast as secondary | hourly | Last snapshot with age; lesson falls back to seasonal norms text |
| alerts | Yes | Red flag warnings, flash flood watches, heat and air quality alerts | NWS `/alerts/active`; NPS API `/alerts`; AirNow | hourly | Cached alerts with age; deep-link to the agency page |
| closures | Yes | Trail and area closures (fire, flood, bear, maintenance) | NPS API (`/alerts`, `/parks`), USFS/BLM alert pages (link + light scrape only where terms allow; prefer official feeds), NIFC/InciWeb for fire | daily (hourly in fire season) | Cached list; link to agency |
| conditions | Yes | Snowpack, stream flow, air quality, fire perimeters: the "this season" layer | NRCS SNOTEL (AWDB REST), USGS Water Data OGC APIs, AirNow, NIFC open data, NOAA CO-OPS (tides for coastal branches later) | daily | Skip the card, show "Data unavailable" |
| events | Limited | Permit lottery windows, wildflower and fall color windows: seasonal context, not scheduling | Swoon'd editorial calendar (authored, reviewed quarterly); agency pages linked | seasonal | Authored defaults |
| news | Link-only | "Why is this trail closed?" explanations | Agency press-release RSS (NPS, USFS); licensed news API is an open product question (DECISIONS Q-3) | daily | None; feature hidden |
| scores, standings, rosters, statistics, rankings, schedules | No | Would be invented sport framing (spec section 10, 38) | n/a | n/a | n/a |
| releases, new-products, new-media | No | Not a learning need for this course | n/a | n/a | n/a |

## 3. Provider notes

### 3.1 National Park Service API (developer.nps.gov)
- Free API key; documented default **1,000 requests per hour** per key, with `X-RateLimit-*` headers (verified 2026-09-30).
- Useful endpoints: `/alerts` (hazardous or changing conditions), `/parks`, `/thingstodo`, `/campgrounds`, `/visitorcenters`, `/webcams` (metadata only), `/events`.
- Content is generally public domain as U.S. government work, but images and some text may carry credits; do not assume every media item is redistributable: store links and credit fields, not copies (spec rule 10).
- Adapter maps `alerts` -> `TrailAlert{parkCode, category, title, ourSummary, url, updatedAt}`. Category mapping: Danger, Caution, Information, Park Closure.
- Cache by `parkCode` for 30-60 minutes; one server-side fetch per park per interval, not per user.

### 3.2 National Weather Service (api.weather.gov)
- Free, no key, but **every request must carry a custom User-Agent** with an app/contact string (verified 2026-09-30); requests without one are rejected.
- Flow: `/points/{lat},{lon}` -> `forecast`, `forecastHourly`, `forecastGridData` URLs; alerts via `/alerts/active?point={lat},{lon}` (or `?zone=`). Gridpoint data includes elevation, which we surface to teach "forecast at the right elevation" (lesson `wx-02`).
- Use gridpoint fields for thunderstorm probability timing, wind, apparent temperature; NWS HeatRisk and Red Flag Warnings arrive as alerts/products.
- U.S.-only; public domain. Attribute "Source: NWS" on cards. Respect published limits, back off on 429/503, cache by gridpoint for 30-60 minutes.
- Mountain terrain: gridpoint forecasts are coarse; always label as "forecast for this grid point at about <elevation>" and never as a summit forecast.

### 3.3 USGS
- **Elevation and topo (teaching diagrams, later route previews):** The National Map: 3DEP elevation web services (WMS/WCS/REST), TNM Access API, US Topo and historical topo scans. USGS data is public domain; credit requested.
- **Streamflow (river-crossing context, Wave 2+):** USGS is replacing the legacy `waterservices.usgs.gov` APIs with `api.waterdata.usgs.gov/ogcapi/`; the **legacy service is scheduled to be decommissioned in Q1 2027** (verified 2026-09-30). Build the adapter on the OGC API only.
- Streamflow is shown only as "flow near normal / high / very high for this gauge" with a link, never as a crossing verdict.

### 3.4 NRCS SNOTEL and snow courses
- AWDB REST API (`wcc.sc.egov.usda.gov/awdbRestApi/services`) provides snow water equivalent, depth and temperature for 850+ SNOTEL sites in 12 western states (verified 2026-09-30).
- Adapter yields `SnowpackReading{stationId, elevation, sweIn, depthIn, percentOfMedian, date}`; used by lessons `wx-09`, `ah-03`, `lv-04`. Show percent of median and dates; explain what it means for a pass, never predict passability.

### 3.5 Air quality and smoke
- **AirNow API** (EPA): free account/API key; AQI observations and forecasts by lat/long, zip or reporting area; attribute AirNow and link to airnow.gov. Do not present as medical advice.
- Optional secondary: agency smoke outlooks (NOAA HMS smoke polygons) as links.

### 3.6 Wildfire
- **NIFC Open Data** (ArcGIS Hub, updates about every 5 minutes for perimeters and incidents, GeoJSON/geoservices) and **InciWeb** incident pages (verified 2026-09-30).
- Adapter yields `FireIncident{name, containmentPct, perimeterBoundingBox, url}` for regions the learner selected; closures come from land-manager alerts, not inferred from perimeters. Show "Fire near this area" plus a link.

### 3.7 Recreation.gov RIDB and permits
- **RIDB API** (Recreation Information Database) provides facilities, recreation areas, permit-entrance metadata, activities and links: API key required; **50 requests per minute** documented (verified 2026-09-30).
- Real-time availability and booking are **not** part of the public RIDB contract. Swoon'd shows permit *concepts* (lottery, timed entry, quotas), authored lottery/season windows with the date last verified, and deep-links to the official reservation page. No scraping.
- Fees: the annual America the Beautiful pass is $80 for U.S. residents, and beginning 2026 nonresidents pay a $100 per-person surcharge at 11 designated parks unless they hold a $250 nonresident annual pass (verified 2026-09-30, NPS/DOI). Authored fee text carries a `lastVerified` date and a link; these change by policy.

### 3.8 Avalanche.org public API (awareness only)
- Daily danger ratings (1-5) for forecast zones from participating avalanche centers. Use only in the alpine branch (`ah-04`) as "Today's rating in the zone you picked: Considerable (3)" with a link to the local center's forecast, and the standing sentence "Awareness is not avalanche training."
- Consider it optional at launch: coverage is limited to forecast zones, and misuse risk is highest here.

### 3.9 Maps, terrain and sun
- **Basemap/tiles:** MapKit (native) for orientation; OpenStreetMap-derived data under ODbL requires attribution and its public tile servers forbid heavy use, so use a commercial vendor or our own tile pipeline. Mapzen/Terrarium open elevation tiles or USGS 3DEP for terrain.
- **Trail geometry (featured routes):** OSM (ODbL, share-alike caution), USFS and NPS open trail datasets. Store only Swoon'd-derived summaries (name, length, gain) with attribution.
- **Sunrise/sunset/civil twilight:** computed on device with the NOAA solar algorithm in SwoondCore (no network, no provider). Used by `jd-02` and live "daylight left" hooks.

### 3.10 AllTrails and other trail platforms
- **No production dependency on any AllTrails API** (spec section 39). AllTrails publishes no general public commercial API; reverse-engineered or scraped access is prohibited by our rules.
- **Allowed:** (a) plain **deep-links** to a trail or search page the learner chooses ("Open in AllTrails"), (b) a **partnership** conversation via AllTrails business development (there are visible AllTrails integrations with device makers and AI assistants as of 2026, suggesting programmatic partnerships exist), (c) manual editorial links.
- Same rule for Gaia GPS, onX, CalTopo, FarOut: link out; no scraping; no redistribution of their maps, tracks or reviews.

## 4. The seasonal layer (unit `seasonal-conditions-layer`)

- Six evergreen lesson **templates** (`lv-01` .. `lv-06`) plus weekly items generated from normalized data for the learner's `{{region}}` / `{{destination}}`; adapter key `hiking.conditions` in the curriculum `live` block, `dataKind: conditions`, `refreshHint: daily-weekly`.
- Item types (all native): `multiple-choice`, `say-this`, `decision-scenario` with facts filled from live data. Fact rows show source and age. A `safetyNote` is always present on generated scenarios.
- Cadence: hourly data refresh, **weekly** new item generation (Mondays), **seasonal** editorial calendar review (spring snowmelt and wildflowers, summer thunderstorm and heat season, fall color and shoulder season, winter traction and short days).
- Generated scenarios must be validated against the decision-scenario schema and a **safety linter** (no "safe" claims, no distance/time promises, a required `safetyNote`), then pass a human check for the first season before automation.
- Editorial approach in the manifest: `explain-and-link`; topics: why a trail is closed, why "red flag" matters, how a permit lottery works, what snowpack means for a pass, why smoke changes plans.

## 5. Deep-links

| Target | Pattern | Notes |
|---|---|---|
| Apple Maps | `https://maps.apple.com/?ll=<lat>,<lon>&q=<name>` (or `MKMapItem`) | Native, no key; Apple Maps has offline maps and hiking routes in the U.S. (verified 2026-09-30) |
| Google Maps | `https://www.google.com/maps/search/?api=1&query=<lat>,<lon>` | Universal link |
| AllTrails | `https://www.alltrails.com/` plus a trail or search URL chosen by the learner or editor | Link only; label "Open in AllTrails"; no scraped data |
| Recreation.gov | Official permit/facility page URL from RIDB `Link` fields | Availability is on their site |
| NPS | `https://www.nps.gov/<parkCode>/planyourvisit/conditions.htm` and alerts pages | Prefer the park's own conditions page |
| NWS | `https://forecast.weather.gov/MapClick.php?lat=<lat>&lon=<lon>` | Official point forecast |
| AirNow | `https://www.airnow.gov/` with location | Air quality |
| Avalanche.org | Forecast center URL from the API | Awareness only |

All external links open in the system browser with a small "You are leaving Swoon'd" affordance; no tracking parameters.

## 6. Normalized data sketch (owned by Swoon'd; not provider shapes)

```
ConditionSnapshot { regionId | trailheadId, asOf, source, forecast[hourly...], heatRisk, alertRefs[] }
TrailAlert        { id, areaId, severity: info|caution|danger|closure, title, ourSummary, url, source, updatedAt, expiresAt? }
AirQualityReading { areaId, aqi, category, pollutant, forecastAqi?, asOf, source }
SnowpackReading   { stationId, elevationFt, sweIn, depthIn, percentOfMedian, asOf }
FireIncident      { name, containmentPct, bbox, url, asOf }
SeasonalWindow    { id, regionId, title, startsOn, endsOn, lastVerified, sourceUrl }
PermitWindow      { id, areaId, opensOn, closesOn, kind: lottery|first-come|timed-entry, lastVerified, sourceUrl }
```

## 7. Licensing and terms summary

| Source | License / terms | Handling |
|---|---|---|
| NWS, NOAA, USGS, NIFC | U.S. government works, generally public domain | Attribute; follow API usage rules (User-Agent, rate limits) |
| NPS API and content | Free key; content generally public domain, media may carry credits | Store links and credits, not photo copies |
| NRCS SNOTEL | Public data | Attribute; cache respectfully |
| AirNow | EPA free API; attribution; not for health decisions | Show disclaimer |
| Recreation.gov RIDB | Key + terms; 50 req/min | Cache server-side; no availability scraping |
| OpenStreetMap | ODbL, attribution and share-alike | Attribution string in map credits; no bulk public tile use |
| AllTrails, Gaia, onX, others | Proprietary; no public commercial API | Deep-link only; no scraping or copying |
| Agency press releases, trip reports, outdoor publications | Copyright of publishers | Our own explanation plus a link; no article text |

## 8. Failure and safety behavior

- Any provider failure -> show last good snapshot with age, or hide the card. Never invent a value.
- If alerts data is older than 6 hours, the card shows a warning banner: "Alerts may be out of date. Check the official page."
- Hazards data (flash flood, fire) always shows the official link first.
- Rate-limit/back-off: exponential with jitter; per-provider circuit breaker; server-side cache so 10,000 learners hit each provider once per interval.
- No push notification content includes the Person's name (discreet mode); conditions notifications are opt-in and rate-limited to one per day.

## 9. Open items

| # | Question | Blocking? |
|---|---|---|
| L-1 | News/editorial provider for "why is this trail closed" explanations (DECISIONS Q-3) | No: launches as link-only agency feeds |
| L-2 | Trail/route content: build from OSM/USFS/NPS or partner with AllTrails? | No for launch |
| L-3 | International (Parks Canada, UK Met Office, etc.) weather/alerts adapters | Post-launch |
| L-4 | Avalanche.org: include at launch or hold | No |
| L-5 | Mapping vendor for tiles (attribution, cost) | Before featured routes |
