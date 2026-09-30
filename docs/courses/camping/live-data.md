# Camping: Current-Context Plan (live data)

Applies product spec sections 10, 11, 32, 37, 38 and 39. Camping is **not modeled as a sport**: no scores, standings, seasons or leaderboards. The only dynamic information that earns its place is what changes a real decision: **overnight weather, fire danger and restrictions, alerts, closures, air quality, booking windows and seasons**. Everything else stays evergreen. It reuses hiking's adapters (`docs/courses/hiking/live-data.md`) wherever the source is the same (NWS, NPS, AirNow, NIFC, USGS, NRCS) and adds camping-specific normalized types.

Facts marked "verified 2026-09-30" were checked by web search on that date; everything else is a design assumption to confirm at build time. Provider terms and endpoints change: re-verify each row before implementation.

## 1. Principles

1. **Adapter first (spec section 32).** Every provider sits behind a Swoon'd-owned adapter returning normalized types (`OvernightForecast`, `CampgroundAlert`, `FireRestriction`, `BookingWindow`, `AirQualityReading`, `SeasonalWindow`). No provider schema reaches the domain model or UI.
2. **Structured data and editorial are separate systems.** Structured: NWS, NPS, NIFC, AirNow, USGS, NRCS. Editorial: agency press releases and camp reports, which we only summarize in our own words and link (spec section 11).
3. **Never hard-code live data in lessons.** Static lessons use `live` unit hooks (`camping-season-layer`, hook `camping.conditions`) and `{{tokens}}`.
4. **No unofficial or reverse-engineered APIs (spec section 39).** Recreation.gov, Hipcamp, The Dyrt, KOA and AllTrails are deep-link only. Recreation.gov availability and booking are not part of the public RIDB, and scraping availability is out of bounds.
5. **Live data is context, not clearance.** Every card carries "Confirm with the land manager" and a source link. Swoon'd never says a fire is allowed, water is safe or a site is open; it says what the current source says and when.
6. **Fire restrictions are the riskiest data.** Stages and bans differ by agency, county and state, change daily in season, and no unified national machine feed is assumed. Launch is **link-first**: show "Fire restrictions may be in effect. Check the agency page" with the link; never display a stage Swoon'd cannot cite with an update time. Curated feeds for fire-prone regions are a later decision (open question).
7. **Privacy.** Location use is optional, coarse (region/park/campground), on demand, and never combined with the Person's name. Notifications follow discreet mode.
8. **Stale is labeled.** Each card shows "Updated <time>" and greys out after its TTL; alerts older than 6 hours show a warning banner.

## 2. What we need, by kind (manifest `dynamicData`)

| Kind | Needed? | Why it matters to learning | Provider candidates (behind adapters) | Refresh | Fallback when down |
|---|---|---|---|---|---|
| weather | Yes | Overnight low drives bag, pad and clothing choices; wind and storms drive site and tent decisions | NWS API `api.weather.gov` primary; Open-Meteo or commercial secondary | hourly | Last snapshot with age; seasonal norms text |
| alerts | Yes | Red flag, flood, heat and smoke alerts change tonight's plan | NWS `/alerts/active`; NPS `/alerts`; AirNow | hourly | Cached with age; official link |
| closures | Yes | Campground closures, bear activity, road, water and facility status | NPS API (`/alerts`, `/campgrounds`); USFS/BLM alert pages (link, light parse only where terms allow); NIFC/InciWeb | daily (hourly in fire season) | Cached list; agency link |
| regulations | Yes (link-first) | Fire restriction stages and bans | Agency restriction pages; state fire agencies (link) | daily in fire season | Link only |
| conditions | Yes | Fire danger, perimeters, snowpack, streamflow, smoke | NIFC Open Data; NRCS SNOTEL AWDB; USGS Water Data OGC API; AirNow | daily | Hide card |
| events | Yes (computed or authored) | Rolling-window release dates, permit-lottery windows, meteor showers, dark-sky dates | On-device date rule; editorial calendar (`lastVerified`); agency pages | seasonal | Authored defaults |
| news | Link-only | "Why is this campground closed?" | Agency press RSS (NPS, USFS); licensed news is an open product question (L-01) | daily | Feature hidden |
| scores, standings, rosters, statistics, rankings, schedules | No | Invented sport framing | n/a | n/a | n/a |
| releases, new-products, new-media | No | No learning value | n/a | n/a | n/a |

## 3. Provider notes

### 3.1 NWS (api.weather.gov)
Same rules as hiking (custom `User-Agent`, cache by gridpoint 30-60 minutes, `/alerts/active?point=`, public domain, "Source: NWS"). Camping-specific use: **overnight low** and **wind gust** for the coming night at the gridpoint, plus thunderstorm timing. Label "forecast for this grid point at about <elevation>"; a campground in a valley or at elevation can be colder than the grid point, so the card says "colder in low spots and at elevation" and never predicts the exact low at a site.

### 3.2 NPS API (developer.nps.gov)
Free key; documented default 1,000 requests/hour (verified 2026-09-30). Endpoints: `/campgrounds` (name, description, fees text, accessibility, reservation info and URL, site counts), `/alerts` (Danger, Caution, Information, Park Closure), `/parks`. Content is generally public domain but images and some text carry credits: store links and credit fields, not copies. Adapter maps `alerts` -> `CampgroundAlert{parkCode, campgroundId?, severity, title, ourSummary, url, updatedAt}`; category mapping as in hiking. `/campgrounds` is used for **evergreen enrichment** only (amenities such as bear boxes, hookups and toilets), cached weekly, and always shows "Confirm on the official page."

### 3.3 Recreation.gov and RIDB
- **RIDB API** provides facilities, recreation areas, campsite metadata, activities and links (key required; documented 50 requests/minute, verified 2026-09-30). Use it for **facility metadata and the official reservation link**, cached server-side.
- **Availability and booking are not in the public RIDB contract.** Swoon'd never scrapes availability or automates booking. "Check availability" is a deep link to the official facility page.
- **Booking-window calculator (computed, not scraped).** Most Recreation.gov campsites are on a **six-month rolling window**: each arrival date opens exactly six months ahead, one day at a time, at a fixed morning release time (reported as 10 a.m. Eastern; verified 2026-09-30 by secondary sources, re-verify against Recreation.gov). Some facilities use different windows (shorter or longer, group sites up to a year, lotteries, first-come sites). Adapter type `BookingWindow{facilityId?, arrivalDate, opensOn, rule: rolling-6-months|lottery|first-come|custom, releaseTimeLocal?, lastVerified, sourceUrl}`. For any facility not confirmed in the authored table, the card says "Typical window. Confirm on the listing." Cancellation, change fees and service fees exist and change (a $10 change fee for out-of-range date changes was seen 2026-09-30); **fee amounts are never hard-coded in lessons**, only the concepts.
- Fees and passes: America the Beautiful and its 2026 nonresident changes are national park entrance matters (see hiking `live-data.md` 3.7); the camping course teaches only that **discount passes may reduce some federal camping fees and that the site rule decides**; NPS and USFS pages are linked.

### 3.4 Fire: NIFC, InciWeb, restrictions
- **NIFC Open Data** (perimeters and incidents, updates about every 5 minutes) and **InciWeb** pages: adapter yields `FireIncident{name, containmentPct, bbox, url, asOf}` for the learner's region.
- **Fire danger** (National Fire Danger Rating levels Low to Extreme) comes from agency and NWS fire weather products; adapter `FireDanger{areaId, level, asOf, sourceUrl}` only where a machine-readable source is confirmed; otherwise a link.
- **Restrictions and bans** (`FireRestriction{agency, areaName, stage?, summary, effectiveOn, url, lastVerified}`): launch is **link-only** per principle 6; if a curated feed is added, each record must carry the agency URL and verification date, and a Swoon'd human confirms it in fire season before it is shown.

### 3.5 Air quality, snow and water
AirNow (free key, attribution, not medical advice), NRCS SNOTEL and USGS Water Data OGC API (legacy WaterServices retires Q1 2027, verified 2026-09-30) as in hiking, used at camp only as "smoke today", "snow still at high camps" and "stream running high". No crossing or safety verdicts.

### 3.6 Sun, moon and sky (computed)
Sunrise, sunset and twilight (arrive-before-dark math) and **moon phase and illumination** are computed on device with standard algorithms in SwoondCore (no provider). **Meteor shower peaks and dark-sky seasons** are an authored editorial calendar with `lastVerified` and a link to the reference source (for example the American Meteor Society or International Meteor Organization): dates shift by year and moon phase, so the card says "Peak night around <date>; moon <phase>." Light-pollution maps are deep-links only; no map tiles are redistributed.

### 3.7 Hunting season (safety overlay)
Fall camping overlaps hunting seasons in many places. Swoon'd does **not** ingest seasons; the seasonal layer authors a reminder ("Hunting season may be open: wear bright colors and check your state wildlife agency") with a link to the state agency page for the learner's region. Never state specific dates.

### 3.8 Campground and camp-report platforms
Hipcamp, The Dyrt, KOA, Campendium, AllTrails and similar are proprietary with no general public commercial API for our use: **deep-link only, no scraping, no redistribution of listings, photos or reviews.** A partnership is an open product question.

## 4. The seasonal layer (unit `camping-season-layer`)

- Six evergreen lesson **templates** (`lv-01` to `lv-06`) plus weekly generated items for the learner's `{{region}}` / `{{destination}}`; curriculum `live` block: adapter key `camping.conditions`, `dataKind: conditions`, `refreshHint: daily-weekly`.
- Item types (all native): `multiple-choice`, `say-this`, `decision-scenario` with fact rows filled from live data. Facts show source and age. A `safetyNote` is always present.
- Cadence: hourly data refresh, **weekly** item generation (Mondays), **seasonal** editorial review (spring opening and snowmelt, summer fire and heat season and booking rush dates, fall shoulder season and hunting overlap, winter closures).
- **Safety linter for generated scenarios** (required before any live item ships; P-18 / D-017): reject any text that (a) says a site, fire, water, food or condition is "safe" or "fine", (b) states a fire stage, ban, fee or window without a linked, dated source, (c) lacks `safetyNote`, (d) makes a distance, time or temperature promise, (e) frames hazard choices with time pressure or scoring, or (f) contradicts an absolute rule (CO in tents, accelerants, feeding wildlife, unattended fire). First season of generated content also gets a human safety check.
- Editorial (`explain-and-link`) topics: why a campground is closed, what Stage 2 or red flag means for tonight, why lotteries and quotas exist, why food storage is required, what shoulder season means.

## 5. Deep-links

| Target | Pattern | Notes |
|---|---|---|
| Recreation.gov facility or permit | URL from RIDB `Link` fields | Availability and booking live on their site |
| NPS campground and conditions | `https://www.nps.gov/<parkCode>/planyourvisit/campgrounds.htm` and conditions pages | Prefer the park's page |
| USFS / BLM | Forest or field-office alert and camping pages from the agency | Link only |
| NWS | `https://forecast.weather.gov/MapClick.php?lat=<lat>&lon=<lon>` | Official point forecast |
| AirNow | `https://www.airnow.gov/` with location | Air quality |
| InciWeb / NIFC | Incident page from the adapter | Fire |
| State fire and wildlife agencies | Agency page for the learner's state | Restrictions and hunting seasons |
| Hipcamp, The Dyrt, AllTrails | Learner-chosen search URL | Link only; label "Open in <name>" |

All external links open in the system browser with a small "You are leaving Swoon'd" affordance; no tracking parameters.

## 6. Normalized data sketch (owned by Swoon'd; not provider shapes)

```
OvernightForecast { areaId, nightOf, lowF, gustMph, precipChance, alertRefs[], asOf, source }
CampgroundAlert   { id, areaId, severity: info|caution|danger|closure, title, ourSummary, url, source, updatedAt, expiresAt? }
FireRestriction   { id, agency, areaName, stage?, summary, effectiveOn?, url, lastVerified }   // link-first
FireDanger        { areaId, level: low|moderate|high|very-high|extreme, asOf, sourceUrl }
FireIncident      { name, containmentPct, bbox, url, asOf }
AirQualityReading { areaId, aqi, category, pollutant, forecastAqi?, asOf, source }
BookingWindow     { facilityId?, arrivalDate, opensOn, rule, releaseTimeLocal?, lastVerified, sourceUrl }
SeasonalWindow    { id, regionId, title, startsOn, endsOn, lastVerified, sourceUrl }
SkyEvent          { id, kind: meteor-shower|milky-way-season|new-moon, peakOn?, lastVerified, sourceUrl }
```

## 7. Licensing and terms summary

| Source | License / terms | Handling |
|---|---|---|
| NWS, NOAA, USGS, NIFC | U.S. government works, generally public domain | Attribute; follow usage rules (User-Agent, limits) |
| NPS API and content | Free key; media may carry credits | Store links and credits, not photo copies |
| NRCS SNOTEL | Public data | Attribute; cache respectfully |
| AirNow | EPA free API; attribution | Show disclaimer |
| Recreation.gov RIDB | Key and terms; 50 req/min; no availability | Cache server-side; deep-link for availability |
| CDC, USDA, LNT Center | Guidance we paraphrase | Cite in-lesson and in `safetyNote` where useful; no copied text |
| Hipcamp, The Dyrt, KOA, AllTrails | Proprietary | Deep-link only |
| Agency press releases, camp reports, outdoor publications | Publisher copyright | Our own explanation plus a link |

## 8. Failure and safety behavior

- Any provider failure -> show last good snapshot with age, or hide the card. Never invent a value.
- Alerts older than 6 hours: banner "Alerts may be out of date. Check the official page."
- Fire and flood data always show the official link first.
- Back-off with jitter; per-provider circuit breaker; server-side cache so 10,000 learners hit each provider once per interval.
- Push notifications are opt-in, rate-limited to one per day, and never name the Person (discreet mode).

## 9. Open items

| # | Question | Blocking? |
|---|---|---|
| L-1 | News/editorial provider for closure explanations (DECISIONS Q-3) | No: link-only |
| L-2 | Curated fire-restriction feed for fire-prone regions vs link-only | No for launch |
| L-3 | Recreation.gov partnership vs deep-link only | No |
| L-4 | Verify the Recreation.gov release time and default window directly on the operator's help pages before build | Before build |
| L-5 | Non-U.S. (Parks Canada, provincial parks) reservation and alert adapters | Post-launch |
| L-6 | Meteor-shower and dark-sky calendar source and licence (link-only vs authored) | No |
