# Climbing: Current-Context Plan (live data)

Applies product spec sections 10, 11, 32, 37, 38, 39 and 40 (sections 39-40: talk about works and events, never redistribute them). Climbing is **not a league sport**: no standings for the learner to track, no seasons the learner must follow. The only dynamic information that earns its place is what people are actually talking about: **competition weekends, crag seasons and friction, closure and access notices, and headline ascents.** The live layer is deliberately thin (3 lessons, `current-season`).

Facts marked "verified 2026-09-30" were checked by web search on that date; all else is a design assumption to confirm at build time. Provider terms change: re-verify each row and record changes in `DECISIONS.md`.

## 1. Principles
1. **Adapter first (spec section 32).** Each provider sits behind a Swoon'd adapter returning normalized types (`CompEvent`, `CompResultLine`, `RankingRow`, `CragConditionSnapshot`, `AccessNotice`, `AscentHeadline`). No provider schema reaches the domain model.
2. **Structured data and editorial are separate systems.** Structured: events, rankings, weather. Editorial: our own explanations with links.
3. **No hard-coded live data in static lessons.** Static lessons use `live` unit hooks and `{{tokens}}`.
4. **No unofficial or reverse-engineered APIs (spec section 39).** Mountain Project, theCrag, 27 Crags, Kaya and IFSC's website endpoints are deep-link only unless a licence or partnership exists.
5. **Conditions are context, never clearance.** Swoon'd never says a crag, route or day is safe. Every conditions card says "Confirm with the land manager or local climbing coalition" and links to the source. Weather and friction are conversation, not go/no-go.
6. **Privacy.** Region choice is coarse (area level), optional, never combined with the Person's name. Notifications follow discreet mode.
7. **Stale is labelled.** Every card shows "Updated <time>" and greys after its TTL; offline shows the last snapshot with its age.

## 2. What we need, by kind (manifest `dynamicData`)
| Kind | Needed? | Why it matters to learning | Provider candidates (behind adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| events | Yes | "Who's competing this weekend?" comp dates, Olympic schedule | IFSC calendar (licence to confirm), USA Climbing (link), Swoon'd editorial calendar | weekly | Authored seasonal list |
| rankings | Limited | World Cup season context | IFSC (licence to confirm) | weekly | Hidden |
| weather | Limited | Friction talk: cool dry days grip, hot humid days slip | NWS API primary; Open-Meteo secondary | hourly | Seasonal norms |
| alerts | Limited | Heat, storm, smoke in a chosen crag region | NWS alerts, AirNow | hourly | Cached with age; link |
| closures | Yes, link-only | Seasonal (nesting) and access notices explain "why is the crag closed?" | Access Fund, local climbing coalitions, land-manager pages | daily | Link to source |
| news | Link-only | "Why is everyone talking about this ascent?" | Press pages; licensed news API TBD (DECISIONS Q-3) | daily | Hidden |
| scores, standings, schedules (league), rosters, injuries, transactions, statistics | No | Would be invented sport framing | n/a | n/a | n/a |
| conditions (snow, streamflow) | No | Hiking and alpine territory | n/a | n/a | n/a |

## 3. Provider notes
### 3.1 IFSC (competition climbing)
- The federation publishes results and rankings on its website; there is **no documented public API** we may assume. Treat any JSON endpoints seen in the wild as unofficial and out of bounds (spec section 39).
- Path: request written permission or a data licence from IFSC; until then show only our own dated editorial ("World Cup this weekend in <city>") with a link, and explain formats (tops, zones, attempts) from static lessons.
- Normalized type `CompResultLine{eventId, discipline, round, athleteName, rank, scoreText}`: names as text, no photos or likenesses.
- Re-verify: IFSC boulder scoring was updated in the 2025 season (points-based scoring); speed and Olympic formats per `SAFETY_REVIEW_CHECKLIST.md` rule 15. Keep format facts in static lessons dated.

### 3.2 NWS and AirNow (crag-region weather)
- NWS: free, custom User-Agent required; grid-point forecasts; alerts at `/alerts/active`. Re-verify per the hiking course `live-data.md` section 3.2.
- AirNow: attribution required; smoke and air quality as "friction and lungs talk", never go/no-go.
- Adapter outputs `CragConditionSnapshot{region, temp, humidity, precipChance, alerts[], updatedAt}`; UI language: "Cool and dry: climbers call that good friction." not "good to climb".

### 3.3 Access notices (Access Fund, coalitions, land managers)
- Link-only. We write a short explanation in our own words (what a seasonal closure is, why it exists) and link; we never relay "open/closed" as authoritative.
- Personalization hook: if the Person's `region` is set, `current-season` shows one notice explanation for that region.

### 3.4 Route and topo sites
- Mountain Project, theCrag, 27 Crags, Kaya: deep-link only ("Find the route on <site>"); no scraping, no embedding of topos or photos, no assumption that content is redistributable.

### 3.5 News and editorial
- Headline ascents and comps: headline plus link plus our own two-sentence explanation. No article text, no athlete photos, no embedded video.
- Example prompts: "Why are climbers talking about this?", "What does a flash at a World Cup mean?", "Why is this crag closed in spring?"

## 4. Editorial topics we explain (approach: explain-and-link)
Why a comp result matters; how boulder, lead and speed differ; why the Olympic format changed (Tokyo combined; Paris speed plus boulder-and-lead; LA28 three separate medals, approved 2025); what a notable ascent means (for example Honnold on Taipei 101, 25 January 2026, broadcast live on Netflix, verified 2026-09-30); why a crag is closed or threatened; what the month's debate is.

## 5. Personalization hooks
| Hook | Uses | Default |
|---|---|---|
| `{{region}}` | Crag-season and conditions card; access explainer | None shown |
| `{{venue}}` | "Your gym's next comp night" if the gym publishes one (link only) | Hidden |
| `{{favoriteClimber}}` | "Janja is competing this weekend" if the events feed covers it | Janja Garnbret |
| `{{skillLevel}}` | Tone of explanations | Beginner |

## 6. Safety linter for generated live-layer scenarios (P-18)
Any generated scenario must pass: no instruction content (Checklist A), cautious answer is `best`, `safetyNote` present, no timer, no claim that conditions are safe, source and age displayed, link to the land manager. Failing items are dropped, not repaired.

## 7. Release and fallback
Launch with static `current-season` only (editorial calendar plus link cards). Turn on IFSC-backed cards only after licence. Every card degrades to "Data unavailable" plus the source link.
