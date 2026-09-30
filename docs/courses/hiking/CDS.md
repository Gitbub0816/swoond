# Course Design Specification: Hiking (`hiking`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Hiking is deliberately **not** modeled as a sport (spec sections 17, 38, 39): no scores, standings, seasons or leaderboards. It is a judgment, navigation and conditions course.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 1 |
| Author / date | Hiking course design agent (Claude), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion docs | `exercises.md`, `live-data.md`, `sims/hiking.navigation.topo-terrain.v1.md`, `NOTES_FOR_ORCHESTRATOR.md` |

---

## 1. Identity
- **Course ID:** `hiking` (immutable)
- **Display name:** Hiking
- **Category / family:** Outdoors & Adventure; category path `Outdoors > Hiking`
- **Simulation prefix:** `hiking` (sim IDs `hiking.<topic>.<name>.vN`; one planned: `hiking.navigation.topo-terrain.v1`)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns hiking, are they meaningfully conversationally competent about it?" | Verdict | Consequence for structure |
|---|---|---|---|
| Camping (`camping`, Wave 2) | Partly. Weather, navigation, water treatment, Leave No Trace and layering transfer. Shelter craft, stoves, campsite selection, campfires, sleep systems and camp cooking do not. | Adjacent, independent | Hiking mentions overnight only where it changes trail decisions (bear canisters, wilderness permits, thru-hiker logistics). Camping owns campcraft. Cross-link concepts (`leave-no-trace`, `water-treatment`, `weather-window`). |
| Climbing (`climbing`, Wave 3) | Barely. Approaches and class 1-3 scrambling vocabulary transfer. Ropes, protection, grades, belaying and anchors are a different, safety-critical language. | Adjacent, independent | Hiking teaches the class scale (`class-scale`) and `exposure` as reading skills only, never technique. |
| Photography (`photography`) | No. Golden-hour light matters to hikers but lens, exposure and composition do not transfer. | Independent | Only mention "light and daylight" through `daylight-math`. |
| Trail running / fastpacking / backpacking | Mostly yes for vocabulary, terrain and conditions; training, nutrition and pacing differ. | Shares foundation (not a catalog course) | Covered as enthusiast debates (`fastpacking`, `fkt`, `ultralight`); no separate course. |
| Mountaineering, backcountry skiing, avalanche terrain | No. Life-safety skills need real training. | Out of scope | Alpine branch teaches awareness only (`avalanche-danger-scale`, `cornice`) with a standing "awareness is not training" note. |
| Birding / plant ID / geology | Partly (shared curiosity). | Adjacent (future courses) | `terrain-and-nature-literacy` teaches only the terms hikers use in conversation. |

- **Branches** (selected once by the learner or inferred from the Person's stated places; each adds a unit with `branchId`):

| id | Name | What changes (rules, data, culture) |
|---|---|---|
| `national-parks` | National Parks and Permits | Permit lotteries, timed-entry reservations, shuttles, passes and fees, ranger culture, park alerts (NPS API); crowds and quotas are the central social topic. |
| `desert-and-canyon` | Desert and Canyon Country | Heat, dry routes and water caches, flash floods and slot canyons, cryptobiotic soil, dawn starts; NWS heat and flood alerts dominate the live layer. |
| `alpine-and-high-country` | Alpine and High Country | Treeline, altitude, lightning and afternoon storms, late snow and traction, avalanche awareness (not training); SNOTEL and alpine forecast data matter. |

Branches not built at launch (see release plan): forest-and-coast (wet country, tides, ticks), long-distance and thru-hiking (currently covered as culture in `trail-culture-and-history`), and non-U.S. regions.

## 2. Beginner model
- **What a complete beginner knows:** hiking is "a long walk outside." They have seen trail photos, may have used AllTrails for a park, know sunscreen exists, and think difficulty equals distance. They have almost no mental model of elevation, weather in mountains, navigation without a blue dot, or what goes wrong.
- **Terminology that confuses:** switchback, blaze, cairn, junction, trailhead, spur, point-to-point, lollipop, elevation gain vs. elevation, grade, "class 3", exposure, scree, saddle, drainage, declination, bearing, handrail, bonk, hot spot, base weight, zero/nero, NOBO/SOBO, trail magic, shoulder season, red flag warning, HeatRisk, turnaround time, alpine start.
- **Common misconceptions (each is a lesson target):**
  1. "Cotton is fine." (Cotton kills: wet cotton pulls heat away; `cotton-kills`.)
  2. "If I have a phone I'm safe." (Coverage is patchy; `cell-coverage-myth`; download offline maps.)
  3. "More water, always." (Plain water alone risks hyponatremia; `hyponatremia`.)
  4. "Six miles is easy." (Gain and terrain dominate; `elevation-gain`, `naismiths-rule`.)
  5. "Clear clouds at the trailhead means clear at the top." (Mountain weather changes with elevation; `lapse-rate`, `afternoon-thunderstorms`.)
  6. "Clear stream water is safe." (`giardia`, `water-treatment`.)
  7. "The summit is the goal; turning back is failure." (`summit-fever`, `turnaround-time`.)
  8. "Boots prevent sprains, so trail runners are irresponsible." (Fit and conditioning matter; the evidence for boot ankle support is weak; `trail-runners-debate`.)
  9. "Moss grows on the north side." (Unreliable; use map and compass.)
  10. "The app's blue dot replaces map knowledge." (Batteries, GPS error, wrong trail, no context; `gps-vs-paper`.)
  11. "Sunny where I am means no flash flood." (Rain miles upstream; `flash-flood`.)
  12. "It is only a rock scramble, no big deal." (`class-scale`, `exposure`.)
- **Concepts that unlock the rest (become foundation units):** elevation gain and time (Naismith), layering and cotton, water and food, trip plan and turnaround time, reading a trail description, Leave No Trace.

## 3. Foundational knowledge
Grouped into modules (these are the manifest `foundationalModules[]` and the four foundation units):

| Module | Contents |
|---|---|
| `trail-basics` | Route shapes, trail furniture (junction, spur, switchback), blazes and cairns, right of way, Leave No Trace, register etiquette, a hike day start to finish |
| `gear-and-clothing` | The ten essentials as ten *systems* (navigation, sun protection, insulation, illumination, first-aid supplies, fire, repair kit and tools, nutrition, hydration, emergency shelter; the classic object list is navigation, headlamp, sun protection, first aid, knife, fire, shelter, extra food, water, clothes), layering, cotton, footwear fit, hot spots and blisters, packs, poles |
| `water-food-and-body` | Hydration rate, treatment methods, electrolytes and hyponatremia, calories per hour, bonking, heat illness, altitude sickness and acclimatization |
| `reading-a-trail` | Elevation gain vs. distance, grade, Naismith's rule, moving vs. total time, pace, difficulty labels (no standard) and the Yosemite Decimal class scale, trail vs. route, exposure, seasonal water |

Also foundational across later units: navigation (maps, contours, norths, bearings, GPS), weather (lapse rate, thunderstorms, wind chill, heat risk, flash floods, smoke), judgment (daylight math, turnaround times, head traps, group decisions, crossings, wildlife, signaling), and culture/history (Wilderness Act 1964, National Trails System Act 1968, the long trails, hiker traditions). **Organizations** the learner should recognize: NPS, USFS, BLM, state parks, Leave No Trace Center, American Hiking Society, Appalachian Trail Conservancy, Pacific Crest Trail Association, Continental Divide Trail Coalition, The Mountaineers, NOLS, Wilderness Medical Society, avalanche centers (via Avalanche.org).

## 4. Enthusiast model
- **What enthusiasts talk about:** the trip ("I did the ridge loop, 11 miles, 3,000 ft"), conditions ("snow on the pass?", "creek's running high", "smoke came in"), timing ("alpine start", "turnaround at one"), gear ("base weight", shoes, poles, filters), objectives (peak lists, thru-hikes, FKTs, permit lotteries), and community values (Leave No Trace, "hike your own hike", trail magic).
- **Distinctions that matter to them:** hiking vs. trekking vs. backpacking vs. scrambling vs. mountaineering; trail vs. route; distance vs. gain; moving time vs. total time; class 2 vs. class 3; single-track vs. social trail; forecast for the town vs. the ridge; snow that is "consolidated" vs. "rotten"; "signal" vs. a satellite messenger; day hiker's ten essentials vs. thru-hiker's kit.
- **Knowledge that signals genuine understanding:** asking about gain, not just miles; mentioning turnaround time and afternoon storms; checking a recent trip report and water source status; knowing that a forecast is for a grid point and elevation; knowing why you tape a hot spot early; describing your plan to someone before you go.
- **Beginner statements that sound obviously uninformed:** "It's just a walk in the woods." "I'll wear jeans." "We'll follow the app." "There'll be signal." "I don't need water, it's cold." "We'll push for the summit no matter what." "That trail is two miles, it's nothing." "Let's take the shortcut across the meadow."
- **Controversies and debates (each becomes a Debate lesson or Talk Track hook):**
  - Ultralight vs. "carry the ten essentials for real" (trade-offs between weight and margin).
  - Trail runners vs. boots; wet-foot philosophy.
  - Paper map and compass vs. phone and GPS; which fails more often.
  - Trekking poles: knees vs. carry and fuss.
  - Solo hiking: independence vs. margin.
  - Dogs on trail (leash rules, wildlife, other hikers).
  - Overcrowding, the "social media effect", and whether to geotag fragile places.
  - Permit lotteries and quotas vs. first-come access; timed entry in parks.
  - E-bikes on trails (class 1 e-bike access debates).
  - Building or moving cairns; trail "art".
  - Peak lists and FKTs: motivation vs. pressure.
  - Should rescued hikers pay for rescues? (An access and ethics debate; we explain, we do not take a side.)
  - Wildfire closures and land management (we explain terms only).

## 5. Interaction model
- **What the learner should experience instead of read:** making the calls a hiker makes (turn around or push, cross or wait, which line), *seeing* the land a contour map describes, reading real trail descriptions and forecasts, and rehearsing conversations. Judgment beats memorization; the north star is understanding why she loves it.
- **Does the course warrant Unity? One sim, rigorously justified.** The Tier rubric (CLAUDE.md section 4) is met by exactly one concept family: **topographic map reading** (`hiking.navigation.topo-terrain.v1`, "Contour Flyover"). A topo map is a 2D encoding of 3D terrain. The lesson is the camera-perspective correspondence: contour spacing becomes slope, bends become ridges and valleys, merged lines become cliffs. A static image or hotspot-tap can test recognition but cannot teach the mapping; a tilting camera over a real heightfield can. It is used in five lessons (`nv-03`, `nv-04`, `nv-08`, `ah-05`, `rv-03`) with an accessible native path (`nv-05`).
- **Unity candidates considered and rejected:**

| Candidate | Why rejected |
|---|---|
| Thunderstorm build-up over a ridge | The concept is timing across a day; a native `decision-scenario` with a time-stamped fact sheet plus `sequence-order` (alpine start) teaches it clearly. No spatial or physical concept a scene adds. |
| River-crossing physics | Real risk, and a sim would imply skill transfer and false confidence. The lesson is judgment ("if unsure, do not cross"); native decision scenario is better and safer. |
| Daylight and turnaround planning | Arithmetic and judgment; `estimate-slider` and `decision-scenario` are clearer. |
| First-person "walk the trail" game | Would be a fake game; the course is about decisions and reading, not traversal. |
| Wildlife encounter sim | Entertainment risk; a sim invites "gaming" real-world safety. Native scenario with agency-aligned advice only. |
| Trail-building / erosion | Interesting, but a native sequence-order and explanation teach it; not central to the learner's goals. |

- **What should NOT be gamified:** emergencies, first aid, wildlife, river crossings, lightning, avalanche terrain and any real hazard. No timers, streak pressure, speed bonuses or "survival" scoring on hazard decisions; safety scenarios always show a `safetyNote`. No mileage, elevation, summit or "peaks collected" leaderboards or badges that could push someone to overreach (peak lists appear only as culture to understand). No pressure mechanics on turnaround decisions.
- **Chosen mix (details in section 12):** ~85% native (`decision-scenario`, `say-this`, `talk-track`, `multiple-choice`, `hotspot-tap`, `estimate-slider`, `sequence-order`, `visual-id`, `term-match`, `fill-the-gap`, `binary-call`), one Unity sim across five lessons, and a live conditions layer generated from official data.

## 6. Dynamic information requirements
Hiking data is environmental, not competitive (spec sections 10, 38). Full plan in `live-data.md`.

| Kind | Needed? | Why | Providers (via adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| Scores / standings / rankings / statistics / rosters / schedules | No | Would be invented sport framing | n/a | n/a | n/a |
| Weather | Yes | Turnaround, storm and heat lessons; "Is it hikeable today?" | NWS API; secondary forecast provider | hourly | Last snapshot with age |
| Conditions | Yes | Snowpack, streamflow, smoke, fire | NRCS SNOTEL, USGS Water Data OGC API, AirNow, NIFC | daily | Hide card |
| Closures and alerts | Yes | Trail and park closures, red flag, flood and heat alerts | NPS API, NWS alerts, NIFC/InciWeb, land-manager pages | hourly (alerts), daily (closures) | Cached with age; official link |
| Events | Limited | Permit windows, wildflower and fall color windows | Swoon'd editorial calendar | seasonal | Authored defaults |
| News | Link-only | Explaining current trail topics | Agency press releases; licensed news API TBD (DECISIONS Q-3) | daily | Feature hidden |
| Releases / new products / new media | No | No learning value | n/a | n/a | n/a |

Structured data (NWS, NPS, USGS, NRCS, AirNow, NIFC) and editorial context (press releases, trip reports) are separate systems. Adapter notes: NWS needs a custom `User-Agent`; NPS default limit 1,000 requests/hour; RIDB 50 requests/minute; USGS legacy WaterServices retires Q1 2027 so build on the OGC API; AllTrails is deep-link only.

## 7. Editorial context
- **What commentary helps:** why a trail or area is closed; what a red flag warning, flood watch or AQI means; why a permit lottery exists and how it works; why a pass is still snowed in; how a fire changes an area; what a new regulation (timed entry, fee change) means for a visit.
- **Sources (link-only or explain-and-link):** agency alerts and press releases (NPS, USFS, BLM), avalanche center forecasts (linked), NWS discussions (linked), outdoor publications and trip-report sites (headline and link only).
- **Licensing restrictions:** agency content is generally public domain, but images may carry credits; publisher articles and trip reports are copyrighted and never copied.
- **Approach:** explain in our own words and link (`explain-and-link`).
- **Example prompts:** "Why is this trail closed?" "What does a red flag warning mean for us Saturday?" "Why do people fight over permits for one canyon?" "Why is everyone talking about smoke this week?" "What does 'snow water equivalent' tell you about the pass?"

## 8. Personalization
| Dimension | How it changes examples and live context | Default when unset | Units using tokens |
|---|---|---|---|
| `region` | Weather and season examples, hazards (heat, snow, ticks, thunderstorms), local land agencies, live layer feed | "your area" (neutral U.S. temperate mountain examples) | `trail-basics`, `weather-and-conditions`, `trail-culture-and-history`, `terrain-and-nature-literacy`, branch units, `seasonal-conditions-layer` |
| `destination` | Named trails, parks or peaks she loves; examples use it ("her trail"); permit and alert context | "the trail she loves" | `reading-a-trail`, `navigation`, `national-parks-and-permits` |
| `equipment` | Gear examples (her pack, shoes, poles, filter type) | "your gear" | `gear-and-clothing`, `gear-nerd-debates` |
| `skill-level` | Difficulty of scenarios, sim difficulty, pace of talk tracks | "beginner" | `water-food-and-body`, `judgment-and-emergencies`, `talk-the-trail`, `perpetual-review` |

Tokens: `{{region}}`, `{{destination}}`, `{{equipment}}`, `{{skill-level}}`. Copy must read well with defaults. Branch selection (`national-parks`, `desert-and-canyon`, `alpine-and-high-country`) gates the branch units. Personalization never uses the Person's name in notifications (discreet mode).

## 9. Conversation model
- **What an enthusiast might naturally say (translation and implied terms):**

| # | She says | What it means | Terms implied |
|---|---|---|---|
| 1 | "We did the lollipop loop, about seven miles with 2,000 feet of gain." | A route with a stem and loop; the climbing made it work. | `lollipop-loop`, `elevation-gain` |
| 2 | "Alpine start, off the summit by noon." | Left before dawn to avoid afternoon thunderstorms. | `alpine-start`, `afternoon-thunderstorms` |
| 3 | "My turnaround was one o'clock, so we bailed 200 feet from the top." | She kept a pre-set time and turned back near the summit. | `turnaround-time`, `summit-fever` |
| 4 | "Trail runners all the way, my feet were wet by mile two and I didn't care." | She prefers light shoes and accepts wet feet. | `trail-runners-debate`, `wet-foot-philosophy` |
| 5 | "The spring was dry, so we filtered from the creek two miles back." | A seasonal source failed; they treated stream water. | `water-source-reliability`, `water-treatment` |
| 6 | "Class 3 scramble up the last pitch. Some exposure." | Hand-over-hand climbing with a fall hazard. | `class-scale`, `exposure` |
| 7 | "I didn't win the lottery again." | A limited-permit draw she lost. | `permit-lottery`, `wilderness-permit` |
| 8 | "Snowpack's still at 140% on the pass, we're waiting until July." | Snow water equivalent is well above median, so the pass is snowed in. | `snowpack`, `weather-window` |
| 9 | "Base weight's down to eleven pounds." | Pack without food, water and fuel is very light. | `base-weight`, `ultralight` |
| 10 | "Red flag warning, so no fires and we're skipping the ridge." | High wildfire danger weather. | `red-flag-warning`, `fire-closure` |
| 11 | "We took a zero in town and resupplied." | A rest day and food restock on a long trail. | `zero-day`, `resupply` |
| 12 | "I got a hot spot at mile three and taped it right away." | Early friction; she prevented a blister. | `hot-spot`, `blister-care` |
| 13 | "The declination was off, so I re-set my bearing." | She adjusted the compass to true or grid north. | `declination`, `bearing` |
| 14 | "Smoke rolled in. AQI was 160." | Wildfire smoke made the air unhealthy. | `air-quality-index` |

- **What the learner can meaningfully ask next:** "What was the gain?" "Did you have a turnaround time?" "How were the conditions up top?" "Did you see the alerts before you went?" "What made you pick that trail?" "What is your favorite view you've earned?" Each maps to a concept.
- **Helping without encouraging fake expertise:** every `say-this` and `talk-track` includes a `noFakeExpertNote` or coach note that rewards **honest curiosity** ("I'm newer to this, what's the gain?") over bluffing. Cringe replies model faked expertise or safety-dismissing bravado and are penalized. Swoon'd never scripts opinions the learner does not hold.
- **Targets:** 24 talk tracks at launch (9 drafted in `exercises.md`), 60+ `say-this` items, growing weekly with the live layer.

## 10. Assessment
- **How useful competence is determined:** concept-level mastery (0-1) driven by exercise outcomes and sim signals (`concept-mastery-v1`), with **safety-critical concepts** (`turnaround-time`, `lightning-safety`, `flash-flood`, `river-crossing`, `hypothermia`, `heat-illness`, `altitude-sickness`, `cotton-kills`, `trip-plan`, `stop-method`) requiring at least two correct decision-scenario outcomes across two sessions before showing as Mastered.
- **Recognize:** route shapes, trail marks, contour landforms, gear layers, alerts and forecasts terms, plants (poison ivy), tick and heat hazards.
- **Understand:** why gain drives time; how layers manage sweat; why storms drive early starts; why permits exist; what Leave No Trace asks.
- **Explain:** her plan from her trip line ("what does an alpine start do?"), why a turnaround time is set in advance.
- **Correctly interpret:** a trail description, a point forecast, a red flag warning, an AQI number, a topo map (via the sim), a fellow hiker's trip recap.
- **Mastery model:** pass threshold 0.8; review policy Leitner boxes.
- **Useful competence statement:** *"Can follow her trail talk, sanity-check a day's plan for time, weather and water, and ask a real follow-up question, without pretending to be an expert or a safety authority."*
- Swoon'd measures understanding by whether the learner can interpret her statements (`say-this`), hold a conversation (`talk-track` Smooth score), and make sound conservative calls on scenarios, not by completion or XP.

## 11. Curriculum map (ongoing course)
16 units, **115 lessons**, **148 Playbook concepts** (drafted in `exercises.md`, section "Playbook terms"). The unit count exceeds the 8-14 rule of thumb because the template's own layer minimums (4 foundation + 4 intermediate + 3 enthusiast) plus branches, the live layer, conversation and review already total 16 (see `NOTES_FOR_ORCHESTRATOR.md`). Lesson `activities` are native exercise types or `unity-sim`; lesson IDs are stable and referenced by the manifest.

### Foundations

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `trail-basics` | Trail basics | none | 8: What counts as a hike; Shapes of a route; Trail furniture; Following the marks; Who yields to whom; Leave No Trace, plainly; A hike day, start to finish; First trail small talk | `trailhead`, `out-and-back`, `loop-hike`, `lollipop-loop`, `point-to-point`, `junction`, `spur-trail`, `switchback` ... |
| `gear-and-clothing` | Gear and clothing | `trail-basics` | 8: The ten essentials; Layers, not a big coat; Why cotton is the villain; Shoes that fit; Blisters before they happen; Packs and poles; Light, shelter and sun; First aid and repair | `ten-essentials`, `layering-system`, `base-layer`, `mid-layer`, `shell`, `cotton-kills`, `wicking`, `footwear-fit` ... |
| `water-food-and-body` | Water, food and your body | `trail-basics` | 7: How much water; Making water safe; Salt and the water trap; Fueling the climb; Hitting the wall; When heat turns serious; Going high | `hydration-rate`, `dehydration-signs`, `water-treatment`, `giardia`, `electrolytes`, `hyponatremia`, `calories-per-hour`, `trail-snacks` ... |
| `reading-a-trail` | Reading a trail description | `trail-basics` | 6: Miles are not the whole story; How steep is steep; Planning with Naismith; Real pace, fantasy pace; What moderate actually means; Trail, route, exposure, water | `elevation-gain`, `grade`, `naismiths-rule`, `moving-vs-total-time`, `pace`, `difficulty-ratings`, `class-scale`, `route-vs-trail` ... |

#### `trail-basics`: Trail basics

What a hike is, how routes are shaped, how trails are marked, and how to share them. Personalization slots: `{{region}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `tb-01` | What counts as a hike | You can tell a day hike from a walk in the park and know why the trailhead matters. | `trailhead` | `multiple-choice`, `term-match` |
| `tb-02` | Shapes of a route | You can name out-and-back, loop, lollipop and point-to-point and say what each demands. | `out-and-back`, `loop-hike`, `lollipop-loop`, `point-to-point` | `term-match`, `hotspot-tap` |
| `tb-03` | Trail furniture | You can recognize a junction, a spur and a switchback and explain why each exists. | `junction`, `spur-trail`, `switchback` | `visual-id`, `fill-the-gap` |
| `tb-04` | Following the marks | You can read blazes and cairns and spot a social trail. | `blaze`, `cairn`, `social-trail` | `visual-id`, `multiple-choice` |
| `tb-05` | Who yields to whom | You can call right of way correctly on a narrow trail. | `trail-right-of-way` | `binary-call`, `multiple-choice` |
| `tb-06` | Leave No Trace, plainly | You can explain the seven principles and give one everyday example each. | `leave-no-trace`, `durable-surface`, `pack-it-out` | `multiple-choice`, `decision-scenario` |
| `tb-07` | A hike day, start to finish | You can order a hike day from planning to the trail register and home. | `trail-register`, `trailhead` | `sequence-order`, `say-this` |
| `tb-08` | First trail small talk | You can respond to a hiker's trip recap with a curious, honest follow-up. | `junction`, `switchback`, `blaze` | `say-this`, `talk-track` |

#### `gear-and-clothing`: Gear and clothing

Why hikers carry what they carry: the ten essentials, layering, feet and packs. Personalization slots: `{{equipment}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `gc-01` | The ten essentials | You can list the ten essentials as systems and say what problem each solves. | `ten-essentials` | `term-match`, `multiple-choice` |
| `gc-02` | Layers, not a big coat | You can build a layering system and say what each layer does. | `layering-system`, `base-layer`, `mid-layer`, `shell` | `sequence-order`, `term-match` |
| `gc-03` | Why cotton is the villain | You can explain why cotton is a poor choice in cool or wet weather. | `cotton-kills`, `wicking` | `binary-call`, `decision-scenario` |
| `gc-04` | Shoes that fit | You can explain why fit beats brand and how to check it. | `footwear-fit`, `hot-spot` | `multiple-choice`, `decision-scenario` |
| `gc-05` | Blisters before they happen | You can treat a hot spot early and know the order of care. | `hot-spot`, `blister-care` | `sequence-order`, `decision-scenario` |
| `gc-06` | Packs and poles | You can choose a sensible daypack size and explain what poles do on descents. | `daypack`, `hiking-poles` | `multiple-choice`, `visual-id` |
| `gc-07` | Light, shelter and sun | You can explain why a day hiker carries a headlamp, a bivy and sun protection. | `headlamp`, `emergency-shelter`, `sun-protection` | `fill-the-gap`, `say-this` |
| `gc-08` | First aid and repair | You can sketch a sensible first aid and repair kit for a short hike. | `first-aid-kit`, `fire-and-repair` | `multiple-choice`, `decision-scenario` |

#### `water-food-and-body`: Water, food and your body

Hydration, fuel, heat and altitude: how the body behaves on a climb. Personalization slots: `{{skill-level}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `wf-01` | How much water | You can estimate water needs for a hike and read early dehydration signs. | `hydration-rate`, `dehydration-signs` | `estimate-slider`, `multiple-choice` |
| `wf-02` | Making water safe | You can compare ways to treat backcountry water and name what they stop. | `water-treatment`, `giardia` | `term-match`, `multiple-choice` |
| `wf-03` | Salt and the water trap | You can explain why plain water alone can be dangerous on long hikes. | `electrolytes`, `hyponatremia` | `multiple-choice`, `decision-scenario` |
| `wf-04` | Fueling the climb | You can estimate calories per hour and pick sensible trail food. | `calories-per-hour`, `trail-snacks` | `estimate-slider`, `fill-the-gap` |
| `wf-05` | Hitting the wall | You can spot bonking early and know how to fix it. | `bonking`, `calories-per-hour` | `decision-scenario`, `multiple-choice` |
| `wf-06` | When heat turns serious | You can distinguish heat cramps, exhaustion and heatstroke in plain language. | `heat-illness` | `decision-scenario`, `say-this` |
| `wf-07` | Going high | You can explain acclimatization and recognize altitude sickness. | `altitude-sickness`, `acclimatization` | `multiple-choice`, `decision-scenario` |

#### `reading-a-trail`: Reading a trail description

Miles, gain, grade, pace and the vocabulary of difficulty. Personalization slots: `{{destination}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `rt-01` | Miles are not the whole story | You can explain why elevation gain matters as much as distance. | `elevation-gain`, `grade` | `estimate-slider`, `multiple-choice` |
| `rt-02` | How steep is steep | You can turn rise and run into a grade and feel what it means. | `grade` | `estimate-slider`, `hotspot-tap` |
| `rt-03` | Planning with Naismith | You can estimate hiking time from distance and gain. | `naismiths-rule`, `moving-vs-total-time` | `estimate-slider`, `fill-the-gap` |
| `rt-04` | Real pace, fantasy pace | You can adjust pace for terrain, pack and group. | `pace`, `moving-vs-total-time` | `estimate-slider`, `multiple-choice` |
| `rt-05` | What moderate actually means | You can explain why difficulty labels vary and what the class scale describes. | `difficulty-ratings`, `class-scale` | `term-match`, `say-this` |
| `rt-06` | Trail, route, exposure, water | You can read a description for red flags: routes, exposure, unreliable water. | `route-vs-trail`, `exposure`, `water-source-reliability` | `binary-call`, `multiple-choice` |

### Intermediate

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `navigation` | Navigation and maps | `reading-a-trail` | 10: What a map is telling you; Contour lines 101; Contours come alive; Ridges, saddles, valleys; Landforms without the flyover; Three norths and declination; Bearings and the compass; Handrails and catching features; Phone navigation done right; Turned around? STOP | `map-scale`, `map-legend`, `contour-line`, `contour-interval`, `index-contour`, `cliff-contours`, `ridgeline`, `saddle` ... |
| `weather-and-conditions` | Weather and conditions | `reading-a-trail` | 9: Mountains make their own weather; Point forecasts; Afternoon storms, early starts; Lightning on the trail; Wind, wet and hypothermia; Heat forecasts; Flash flood logic; Smoke and fire weather; Snow and weather windows | `lapse-rate`, `point-forecast`, `afternoon-thunderstorms`, `alpine-start`, `lightning-safety`, `wind-chill`, `hypothermia`, `heat-risk` ... |
| `judgment-and-emergencies` | Judgment and emergencies | `weather-and-conditions`, `navigation` | 10: The plan before the trail; Daylight math; Turnaround times; Head traps; Group pace and group decisions; River crossings; Wildlife on the trail; Signal is not safety; Signaling for help; What first aid training gives you | `trip-plan`, `margin-of-safety`, `daylight-math`, `turnaround-time`, `summit-fever`, `sunk-cost-trap`, `group-pace`, `river-crossing` ... |
| `national-parks-and-permits` | National parks and permits (branch `national-parks`) | `trail-basics` | 6: How parks manage crowds; Permit lotteries; Wilderness permits; Passes and fees; Reading park alerts; Talking parks | `timed-entry`, `shuttle-system`, `permit-lottery`, `wilderness-permit`, `annual-pass`, `alerts-and-closures`, `fire-closure`, `leave-no-trace` ... |
| `desert-and-canyon-country` | Desert and canyon country (branch `desert-and-canyon`) | `water-food-and-body`, `weather-and-conditions` | 5: Desert heat rules; Caches and dry routes; Slot canyons and flash floods; Slickrock and the crust; Talking desert | `heat-illness`, `hydration-rate`, `water-cache`, `water-source-reliability`, `slot-canyon`, `flash-flood`, `cairn`, `cryptobiotic-soil` ... |
| `alpine-and-high-country` | Alpine and high country (branch `alpine-and-high-country`) | `navigation`, `weather-and-conditions` | 6: Above treeline; Storm-proofing your day; Late snow and traction; Avalanche awareness; Reading a high route; Altitude and pacing | `treeline`, `exposure`, `alpine-start`, `lightning-safety`, `snowpack`, `microspikes`, `postholing`, `avalanche-danger-scale` ... |

#### `navigation`: Navigation and maps

Maps, contours, north, bearings and staying found, with the terrain flyover sim. Personalization slots: `{{destination}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `nv-01` | What a map is telling you | You can read scale and legend to size up a route. | `map-scale`, `map-legend` | `multiple-choice`, `fill-the-gap` |
| `nv-02` | Contour lines 101 | You can read interval and index contours and find elevation on a map. | `contour-line`, `contour-interval`, `index-contour` | `hotspot-tap`, `multiple-choice` |
| `nv-03` | Contours come alive | You can tell steep from gentle ground and spot cliffs from contour spacing. | `contour-line`, `cliff-contours`, `contour-interval` | `unity-sim` (`hiking.navigation.topo-terrain.v1`) |
| `nv-04` | Ridges, saddles, valleys | You can pick out a ridge, saddle or drainage on a topo map. | `ridgeline`, `saddle`, `drainage` | `unity-sim` (`hiking.navigation.topo-terrain.v1`) |
| `nv-05` | Landforms without the flyover | You can identify landforms on a static map (also the accessible path for the sim lessons). | `ridgeline`, `saddle`, `drainage`, `cliff-contours` | `hotspot-tap`, `multiple-choice` |
| `nv-06` | Three norths and declination | You can explain true, magnetic and grid north and why declination matters. | `north-types`, `declination` | `multiple-choice`, `fill-the-gap` |
| `nv-07` | Bearings and the compass | You can describe how a bearing is taken and followed. | `bearing` | `sequence-order`, `multiple-choice` |
| `nv-08` | Handrails and catching features | You can pick a line using handrails, catching features and aiming off. | `handrail`, `catching-feature`, `aiming-off` | `unity-sim` (`hiking.navigation.topo-terrain.v1`), `multiple-choice` |
| `nv-09` | Phone navigation done right | You can prepare a phone for navigation with offline maps, tracks and waypoints. | `gps-track`, `offline-maps`, `waypoint` | `sequence-order`, `say-this` |
| `nv-10` | Turned around? STOP | You can apply STOP and dead reckoning when unsure where you are. | `stop-method`, `dead-reckoning` | `decision-scenario`, `multiple-choice` |

#### `weather-and-conditions`: Weather and conditions

Reading forecasts and conditions for hikers, and the hazards weather creates. Personalization slots: `{{region}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `wx-01` | Mountains make their own weather | You can estimate temperature change with elevation. | `lapse-rate` | `estimate-slider`, `multiple-choice` |
| `wx-02` | Point forecasts | You can use a point forecast at the right elevation. | `point-forecast` | `multiple-choice`, `say-this` |
| `wx-03` | Afternoon storms, early starts | You can explain why mountain hikers start early. | `afternoon-thunderstorms`, `alpine-start` | `decision-scenario`, `sequence-order` |
| `wx-04` | Lightning on the trail | You can name lightning precautions and when to make them. | `lightning-safety` | `decision-scenario`, `binary-call` |
| `wx-05` | Wind, wet and hypothermia | You can explain how wind and wet turn cool days dangerous. | `wind-chill`, `hypothermia` | `estimate-slider`, `decision-scenario` |
| `wx-06` | Heat forecasts | You can read a heat risk rating and change a plan. | `heat-risk`, `heat-illness` | `decision-scenario`, `multiple-choice` |
| `wx-07` | Flash flood logic | You can explain why rain miles away can flood a canyon. | `flash-flood` | `decision-scenario`, `binary-call` |
| `wx-08` | Smoke and fire weather | You can read AQI and red flag warnings for a hike. | `air-quality-index`, `red-flag-warning` | `decision-scenario`, `multiple-choice` |
| `wx-09` | Snow and weather windows | You can explain why lingering snow and short windows change trail plans. | `snowpack`, `weather-window` | `decision-scenario`, `say-this` |

#### `judgment-and-emergencies`: Judgment and emergencies

Turnarounds, daylight math, head traps, crossings, wildlife and calling for help. Personalization slots: `{{skill-level}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `jd-01` | The plan before the trail | You can build a trip plan with margin. | `trip-plan`, `margin-of-safety` | `fill-the-gap`, `sequence-order` |
| `jd-02` | Daylight math | You can work back from sunset to a turn time. | `daylight-math` | `estimate-slider`, `decision-scenario` |
| `jd-03` | Turnaround times | You can set and honor a turnaround time. | `turnaround-time` | `decision-scenario` |
| `jd-04` | Head traps | You can name summit fever and the sunk-cost trap in yourself. | `summit-fever`, `sunk-cost-trap` | `multiple-choice`, `decision-scenario` |
| `jd-05` | Group pace and group decisions | You can explain group pace and how to voice doubts. | `group-pace` | `decision-scenario`, `talk-track` |
| `jd-06` | River crossings | You can explain when to cross and when to turn around. | `river-crossing` | `decision-scenario` |
| `jd-07` | Wildlife on the trail | You can describe distance, noise and food storage basics. | `wildlife-encounter`, `bear-canister` | `decision-scenario`, `multiple-choice` |
| `jd-08` | Signal is not safety | You can explain why cell coverage cannot be your plan. | `cell-coverage-myth`, `satellite-messenger` | `multiple-choice`, `say-this` |
| `jd-09` | Signaling for help | You can describe distress signals and when to use them. | `sos-signals` | `fill-the-gap`, `multiple-choice` |
| `jd-10` | What first aid training gives you | You can explain why real wilderness first aid training matters. | `wilderness-first-aid` | `multiple-choice`, `say-this` |

#### `national-parks-and-permits`: National parks and permits

How U.S. parks manage crowds, permits, fees and alerts. Personalization slots: `{{destination}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `np-01` | How parks manage crowds | You can explain timed entry and shuttles. | `timed-entry`, `shuttle-system` | `multiple-choice`, `say-this` |
| `np-02` | Permit lotteries | You can explain why lotteries exist and how to approach them. | `permit-lottery` | `multiple-choice`, `decision-scenario` |
| `np-03` | Wilderness permits | You can describe quotas and what a wilderness permit covers. | `wilderness-permit` | `fill-the-gap`, `decision-scenario` |
| `np-04` | Passes and fees | You can explain the annual pass and where fees change. | `annual-pass` | `multiple-choice` |
| `np-05` | Reading park alerts | You can turn an alert into a decision. | `alerts-and-closures`, `fire-closure` | `decision-scenario`, `say-this` |
| `np-06` | Talking parks | You can chat about parks with a fan without bluffing. | `leave-no-trace`, `wilderness-act` | `say-this`, `talk-track` |

#### `desert-and-canyon-country`: Desert and canyon country

Heat, water and slot canyons. Personalization slots: `{{region}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `dc-01` | Desert heat rules | You can plan water and timing for desert heat. | `heat-illness`, `hydration-rate` | `decision-scenario`, `estimate-slider` |
| `dc-02` | Caches and dry routes | You can plan around water caches and dry sources. | `water-cache`, `water-source-reliability` | `decision-scenario`, `multiple-choice` |
| `dc-03` | Slot canyons and flash floods | You can decide whether a slot canyon is safe to enter. | `slot-canyon`, `flash-flood` | `decision-scenario`, `binary-call` |
| `dc-04` | Slickrock and the crust | You can follow cairns on slickrock and avoid soil crust. | `cairn`, `cryptobiotic-soil` | `visual-id`, `multiple-choice` |
| `dc-05` | Talking desert | You can follow desert trip talk. | `slot-canyon`, `heat-risk` | `say-this`, `talk-track` |

#### `alpine-and-high-country`: Alpine and high country

Treeline, storms, late snow and avalanche awareness. Personalization slots: `{{region}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `ah-01` | Above treeline | You can explain the exposure and shelter changes above treeline. | `treeline`, `exposure` | `multiple-choice`, `decision-scenario` |
| `ah-02` | Storm-proofing your day | You can schedule a high route around storms. | `alpine-start`, `lightning-safety` | `decision-scenario`, `sequence-order` |
| `ah-03` | Late snow and traction | You can judge when snow needs traction or a turn. | `snowpack`, `microspikes`, `postholing` | `decision-scenario`, `multiple-choice` |
| `ah-04` | Avalanche awareness | You can read a danger rating and know awareness is not training. | `avalanche-danger-scale`, `cornice` | `multiple-choice`, `say-this` |
| `ah-05` | Reading a high route | You can read contours to find a safer line. | `contour-line`, `saddle`, `ridgeline` | `unity-sim` (`hiking.navigation.topo-terrain.v1`) |
| `ah-06` | Altitude and pacing | You can pace and sleep sensibly at altitude. | `acclimatization`, `altitude-sickness` | `estimate-slider`, `decision-scenario` |

### Enthusiast depth

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `gear-nerd-debates` | Gear nerd debates | `gear-and-clothing`, `judgment-and-emergencies` | 7: Base weight and the big three; Ultralight trade-offs; Trail runners or boots; Filters compared; Paper or phone; Going fast; Hike your own hike | `base-weight`, `big-three`, `ultralight`, `shakedown-hike`, `trail-runners-debate`, `wet-foot-philosophy`, `water-filter-types`, `gps-vs-paper` ... |
| `trail-culture-and-history` | Trail culture and history | `gear-and-clothing` | 8: What a thru-hike is; The big three trails; Trail names and tramilies; Trail magic, hiker hunger; Zeros, neros, resupply; Peakbagging lists; How wilderness got protected; Hut-to-hut and classic walks | `thru-hike`, `section-hike`, `triple-crown`, `nobo-sobo`, `trail-name`, `tramily`, `trail-magic`, `hiker-hunger` ... |
| `terrain-and-nature-literacy` | Terrain and nature literacy | `navigation` | 7: Life zones and treeline; Rock underfoot; Glacier country; The living crust; Tick country; Plants to know; Snow travel words | `treeline`, `krummholz`, `talus-scree`, `cirque-moraine`, `cryptobiotic-soil`, `tick-check`, `poison-ivy`, `postholing` ... |

#### `gear-nerd-debates`: Gear nerd debates

What hikers argue about: weight, shoes, filters, maps and style. Personalization slots: `{{equipment}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `gn-01` | Base weight and the big three | You can define base weight and name the big three. | `base-weight`, `big-three` | `estimate-slider`, `term-match` |
| `gn-02` | Ultralight trade-offs | You can explain what ultralight gains and gives up. | `ultralight`, `shakedown-hike` | `multiple-choice`, `say-this` |
| `gn-03` | Trail runners or boots | You can present both sides of the shoe debate. | `trail-runners-debate`, `wet-foot-philosophy` | `multiple-choice`, `say-this` |
| `gn-04` | Filters compared | You can compare filter types by speed, weight and failure modes. | `water-filter-types` | `term-match`, `decision-scenario` |
| `gn-05` | Paper or phone | You can explain why many hikers carry both. | `gps-vs-paper` | `decision-scenario` |
| `gn-06` | Going fast | You can explain fastpacking and FKTs without mocking either. | `fastpacking`, `fkt` | `say-this`, `multiple-choice` |
| `gn-07` | Hike your own hike | You can respect a different style without abandoning safety. | `hyoh`, `social-trail` | `say-this`, `talk-track` |

#### `trail-culture-and-history`: Trail culture and history

Long trails, hiker traditions and how the wild places were protected. Personalization slots: `{{region}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `tc-01` | What a thru-hike is | You can define thru-hike, section hike and Triple Crown. | `thru-hike`, `section-hike`, `triple-crown` | `multiple-choice`, `term-match` |
| `tc-02` | The big three trails | You can place the AT, PCT and CDT and their rough lengths. | `triple-crown`, `nobo-sobo` | `estimate-slider`, `multiple-choice` |
| `tc-03` | Trail names and tramilies | You can explain trail names and tramilies. | `trail-name`, `tramily` | `say-this`, `talk-track` |
| `tc-04` | Trail magic, hiker hunger | You can recognize trail magic and hiker hunger stories. | `trail-magic`, `hiker-hunger` | `say-this`, `fill-the-gap` |
| `tc-05` | Zeros, neros, resupply | You can follow a thru-hiker's logistics talk. | `zero-day`, `resupply` | `term-match`, `decision-scenario` |
| `tc-06` | Peakbagging lists | You can explain why people chase lists like 14ers and the Adirondack 46. | `peakbagging` | `multiple-choice`, `say-this` |
| `tc-07` | How wilderness got protected | You can outline the Wilderness Act and how it shapes hiking. | `wilderness-act` | `sequence-order`, `multiple-choice` |
| `tc-08` | Hut-to-hut and classic walks | You can describe hut-to-hut trekking and famous long walks. | `hut-to-hut` | `multiple-choice`, `say-this` |

#### `terrain-and-nature-literacy`: Terrain and nature literacy

The landscape you walk through: zones, rock, ice, soil, plants and ticks. Personalization slots: `{{region}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `tn-01` | Life zones and treeline | You can explain treeline and why krummholz looks the way it does. | `treeline`, `krummholz` | `visual-id`, `multiple-choice` |
| `tn-02` | Rock underfoot | You can tell talus from scree and predict how each feels. | `talus-scree` | `visual-id`, `binary-call` |
| `tn-03` | Glacier country | You can spot a cirque and a moraine. | `cirque-moraine` | `visual-id`, `hotspot-tap` |
| `tn-04` | The living crust | You can explain why desert soil crust must not be stepped on. | `cryptobiotic-soil` | `multiple-choice`, `decision-scenario` |
| `tn-05` | Tick country | You can describe tick prevention and checks. | `tick-check` | `sequence-order`, `multiple-choice` |
| `tn-06` | Plants to know | You can recognize poison ivy and say what to do after contact. | `poison-ivy` | `visual-id`, `multiple-choice` |
| `tn-07` | Snow travel words | You can decode postholing and microspikes talk. | `postholing`, `microspikes` | `multiple-choice`, `fill-the-gap` |

### Current-season / live layer

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `seasonal-conditions-layer` | This season on the trail | `weather-and-conditions`, `judgment-and-emergencies` | 6: This week on the trail; Is it hikeable today?; Smoke and fire watch; Snow and water this season; The season's window; What her group chat is saying | `trail-report`, `alerts-and-closures`, `point-forecast`, `heat-risk`, `wind-chill`, `air-quality-index`, `fire-closure`, `red-flag-warning` ... |

#### `seasonal-conditions-layer`: This season on the trail

Live conditions, generated from normalized data and refreshed weekly. Personalization slots: `{{region}}`. Live hook: `hiking.conditions` (daily to weekly refresh).

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `lv-01` | This week on the trail | You can read this week's alerts and closures for your area. | `trail-report`, `alerts-and-closures` | `multiple-choice`, `say-this` |
| `lv-02` | Is it hikeable today? | You can weigh forecast, heat and wind for a real trail. | `point-forecast`, `heat-risk`, `wind-chill` | `decision-scenario` |
| `lv-03` | Smoke and fire watch | You can read fire closures, AQI and red flags together. | `air-quality-index`, `fire-closure`, `red-flag-warning` | `decision-scenario` |
| `lv-04` | Snow and water this season | You can read snowpack and water reliability. | `snowpack`, `water-source-reliability` | `multiple-choice`, `decision-scenario` |
| `lv-05` | The season's window | You can explain what makes now a good time for a hike. | `seasonal-window` | `multiple-choice`, `say-this` |
| `lv-06` | What her group chat is saying | You can decode current trail chatter. | `trail-report`, `seasonal-window` | `say-this` |

### Conversation practice

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `talk-the-trail` | Talk the trail | `trail-basics`, `gear-and-clothing` | 8: Planning a hike together; Her trip recap; Gear talk, no faking; When she is nervous about conditions; The trail-name story; Decoding her trail reports; The first date hike; The good follow-up | `trip-plan`, `turnaround-time`, `elevation-gain`, `exposure`, `base-weight`, `trail-runners-debate`, `weather-window`, `lightning-safety` ... |

#### `talk-the-trail`: Talk the trail

Conversation practice that grows with the course. Personalization slots: `{{skill-level}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `tk-01` | Planning a hike together | You can plan a hike together without overpromising. | `trip-plan`, `turnaround-time` | `talk-track` |
| `tk-02` | Her trip recap | You can respond to a trip recap with a curious follow-up. | `elevation-gain`, `exposure` | `talk-track`, `say-this` |
| `tk-03` | Gear talk, no faking | You can join gear talk honestly. | `base-weight`, `trail-runners-debate` | `talk-track`, `say-this` |
| `tk-04` | When she is nervous about conditions | You can support a cautious call. | `weather-window`, `lightning-safety` | `talk-track` |
| `tk-05` | The trail-name story | You can enjoy a trail-name story. | `trail-name`, `trail-magic` | `talk-track` |
| `tk-06` | Decoding her trail reports | You can decode her trail-report message. | `trail-report`, `junction` | `say-this` |
| `tk-07` | The first date hike | You can pace a first hike together. | `group-pace`, `margin-of-safety` | `talk-track`, `decision-scenario` |
| `tk-08` | The good follow-up | You can ask a follow-up that shows you listened. | `hyoh`, `pace` | `say-this`, `talk-track` |

### Perpetual review

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `perpetual-review` | Perpetual review | `trail-basics` | 4: Daily bite; Judgment replay; Map reading refresher; Season change refresher | `ten-essentials`, `leave-no-trace`, `junction`, `turnaround-time`, `weather-window`, `contour-line`, `ridgeline`, `saddle` ... |

#### `perpetual-review`: Perpetual review

Spaced review of mastered concepts, forever. Personalization slots: `{{skill-level}}`.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `rv-01` | Daily bite | You can recall core terms after a gap. | `ten-essentials`, `leave-no-trace`, `junction` | `multiple-choice`, `fill-the-gap`, `term-match` |
| `rv-02` | Judgment replay | You can re-decide a scenario with changed facts. | `turnaround-time`, `weather-window` | `decision-scenario` |
| `rv-03` | Map reading refresher | You can re-read contours after a break. | `contour-line`, `ridgeline`, `saddle` | `hotspot-tap`, `unity-sim` (`hiking.navigation.topo-terrain.v1`) |
| `rv-04` | Season change refresher | You can adapt gear and plans to the new season. | `layering-system`, `lapse-rate`, `snowpack` | `fill-the-gap`, `multiple-choice` |


### Layer summary
| Layer | Purpose | Units in this course |
|---|---|---|
| Foundations | Terms, rules, how it works | `trail-basics`, `gear-and-clothing`, `water-food-and-body`, `reading-a-trail` (29 lessons) |
| Intermediate | Strategy, distinctions, context | `navigation`, `weather-and-conditions`, `judgment-and-emergencies` + branch units `national-parks-and-permits`, `desert-and-canyon-country`, `alpine-and-high-country` (29 core + 17 branch) |
| Enthusiast depth | What fans debate; nuance; history/culture | `gear-nerd-debates`, `trail-culture-and-history`, `terrain-and-nature-literacy` (22 lessons) |
| Branches/personalization | Region, destination, terrain | Branch units gated by `branchId`; tokens `{{region}}` etc. |
| Current-season / live | Ongoing, refreshed from live data | `seasonal-conditions-layer` (6 templates; new items weekly, seasonal editorial refresh) |
| Conversation practice | Talk tracks, say-this, "what is she talking about?" | `talk-the-trail` (8 lessons) + Talk tab (24+ tracks) |
| Perpetual review | Spaced review of mastered concepts | `perpetual-review` + policy below |

- **Review policy (curriculum `reviewPolicy`):** `leitner-boxes-v1`, `intervalsDays` `[1, 3, 7, 14, 30, 60, 120]`, `maxItemsPerSession` 12, `masteryThreshold` 0.8, `decayAfterDays` 45 (hiking knowledge is seasonal: a winter learner should see summer-hazard concepts again before the season turns), `reviewActivityTypes`: `multiple-choice`, `fill-the-gap`, `term-match`, `decision-scenario`, `hotspot-tap`, `estimate-slider`, `say-this`, `unity-sim` (via `rv-03`).
- **Concept count target (Playbook):** 148 at launch; growth to ~220 with branches and live layer.
- **Personalization slots:** see section 8 and per-unit tables.
- **Release plan:**
  - **Launch (v1.0):** `trail-basics`, `gear-and-clothing`, `water-food-and-body`, `reading-a-trail`, `navigation` (with the Contour Flyover sim, subject to Astra), `weather-and-conditions`, `judgment-and-emergencies`, `talk-the-trail`, `perpetual-review`, and a U.S.-only `seasonal-conditions-layer` (NWS + NPS alerts + AirNow).
  - **Update 1 (about 8 weeks):** `gear-nerd-debates`, `trail-culture-and-history`, `national-parks-and-permits`.
  - **Update 2:** `terrain-and-nature-literacy`, `desert-and-canyon-country`, `alpine-and-high-country` (with `ah-05` using the sim), SNOTEL and USGS streamflow cards.
  - **Continuing:** weekly seasonal items, quarterly editorial calendar, new branches (forest-and-coast, long-distance and thru-hiking), non-U.S. regions, more sim scenarios (14 at launch, 40 over time), more talk tracks.

## 12. Interaction plan
Native rows link to `docs/native-exercises/CATALOG.md`. Counts are approximate authored items at launch (before the live layer).

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Contour Flyover: steepness, cliffs, landforms, route lines, high routes (`nv-03`, `nv-04`, `nv-08`, `ah-05`, `rv-03`) | `contour-line`, `contour-interval`, `index-contour`, `cliff-contours`, `ridgeline`, `saddle`, `drainage`, `handrail`, `catching-feature`, `exposure` | `unity-sim` (`hiking.navigation.topo-terrain.v1`) | Camera perspective and spatial reasoning are the concept: the learner sees a flat map lift into terrain, watches water flow and sight lines resolve. Closest native (`hotspot-tap`) teaches recognition only. Spec: `sims/hiking.navigation.topo-terrain.v1.md`. | A | 5 lesson uses x 3 rounds; 14 scenarios |
| Trail, gear, body and reading-a-trail facts | `ten-essentials`, `layering-system`, `hydration-rate`, `elevation-gain`, ... | `multiple-choice` | Recall and understanding of rules and terms; default review card. Standard. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~232 |
| Judgment scenarios across all units | `turnaround-time`, `lightning-safety`, `river-crossing`, `flash-flood`, ... | `decision-scenario` | Judgment under real constraints (time, weather, water, group). Spec section 17. Unity would add nothing: the facts, not a scene, drive the decision. Fact-sheet card with graded options; every scenario has `safetyNote`. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~126 |
| Interpret her trail talk | `trail-name`, `class-scale`, `red-flag-warning`, ... | `say-this` | Decoding what she said is the north-star skill (spec section 13). Quote card, concept chips, follow-ups, `noFakeExpertNote`. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~90 |
| Conversation practice (Talk tab and unit ends) | `trip-plan`, `group-pace`, `base-weight`, ... | `talk-track` | Conversation practice for every unit; forgiving, no hearts. Chat with Smooth meter; honest curiosity beats bluffing. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~13 |
| Vocabulary sets | `blaze`, `saddle`, `nobo-sobo`, ... | `term-match` | Grouped vocabulary (route shapes, landforms, slang, layers). Tap-tap matching. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~22 |
| Rule-of-thumb sentences | `switchback`, `handrail`, `alpine-start`, ... | `fill-the-gap` | Vocabulary in context and rule-of-thumb sentences. Inline gaps. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~52 |
| Processes and order | `blister-care`, `stop-method`, `trip-plan`, ... | `sequence-order` | Processes where order matters: blister care, STOP, hike day, alpine start, layering. Partial credit. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~20 |
| Sight recognition | `blaze`, `cairn`, `poison-ivy`, `krummholz`, ... | `visual-id` | Recognize trail marks, plants, landforms and terrain features by sight; illustrations are original (license ids). Cues in feedback. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~32 |
| Diagram taps (accessible companion to the sim) | `saddle`, `drainage`, `exposure`, `grade` | `hotspot-tap` | Tap a region on a static or procedural diagram (saddle, steep slope, exposure). Static diagrams, no motion needed; the accessible companion to the sim. Procedural diagrams from the sim's heightfield code. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~24 |
| Yes/no situational rules | `trail-right-of-way`, `cotton-kills`, `lightning-safety` | `binary-call` | Two-way situational rules (who yields, cotton or synthetic, descend or push). Diagram or none. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~28 |
| Magnitude intuition | `naismiths-rule`, `lapse-rate`, `hydration-rate`, `grade` | `estimate-slider` | Magnitudes hikers must intuit: hours, temperature drop, liters, grade, trail length. Tolerance bands. Native catalog: `docs/native-exercises/CATALOG.md`. | B | ~52 |
| Live layer items (weekly, generated) | `trail-report`, `alerts-and-closures`, `snowpack`, ... | `decision-scenario`, `say-this`, `multiple-choice` | Templates filled from normalized data; native types only. Never Unity. | B | new weekly |
| Not used: `timing-tap`, `listening-id` | n/a | n/a | No 1D timing concept; audio (bird calls, thunder) needs licensed or original recordings (deferred). | n/a | 0 |

**Tier A row detail: Contour Flyover (`hiking.navigation.topo-terrain.v1`)**
- **Rubric answer:** camera perspective is the concept (map <-> terrain); movement in space (hiker walk, water flow, sight rays) reveals truth; a native `hotspot-tap` on a static diagram teaches recognition only and cannot show the correspondence dynamically.
- **Native fallback for accessibility (a separate designed lesson, not a port):** `nv-05` "Landforms without the flyover".
- **Spec:** `sims/hiking.navigation.topo-terrain.v1.md`.

## 13. Licensing & safety
**Media rights**

| Area | Handling |
|---|---|
| Imagery | Launch uses **original illustrations and procedural diagrams** (`swoond-original-illustration`, `swoond-procedural`). NPS/USGS public-domain photos only after per-image credit and restriction review (`nps-public-domain`, `usgs-public-domain`). No AllTrails, Gaia or onX imagery; no scraped photos. |
| Maps and terrain | USGS data is public domain (credit requested); OSM-derived data under ODbL with attribution; the sim uses synthetic terrain (no real maps). |
| Logos and trademarks | Names as text only (REI, Garmin, Patagonia, AllTrails, Gaia GPS, Appalachian Trail Conservancy logos, etc.). "Leave No Trace" and "Ten Essentials" are used descriptively with credit to the Leave No Trace Center for Outdoor Ethics and The Mountaineers. Trail emblems (AT, PCT, CDT) are not reproduced. |
| Audio | None at launch (bird/thunder audio needs licensed or original recordings; `listening-id` is not used). |
| Video | None. |
| Lyrics / text | None. Publisher article text is never copied; agency text is paraphrased. |
| Data terms | See `live-data.md`: NWS UA header, NPS key/limits, RIDB limits/terms, USGS credit, AirNow attribution, OSM ODbL. |
| Personal likeness | None. |

**Safety constraints (also in the manifest):**
1. Swoon'd teaches **appreciation and understanding, not safety training**. It is not a substitute for a wilderness first aid course, navigation training, avalanche training, or local knowledge.
2. Scenarios are learning aids; every `decision-scenario` carries a `safetyNote` and never claims a route, time or condition is safe.
3. Never imply a scenario replaces real-world navigation or survival skills; the sim uses synthetic terrain and says so.
4. Live conditions are informational; always link to the official source and say "confirm with the land manager".
5. No medical instruction beyond recognition and "seek help / descend"; no treatment protocols beyond widely taught basics (e.g. taping a hot spot).
6. Wildlife: distance, noise and food storage principles only, deferring to local ranger guidance; species and region differ.
7. Avalanche and snow: awareness only; no route advice; standing sentence "Awareness is not training."
8. Do not gamify hazards (no timers, streaks or speed bonuses on safety decisions; no summit, mileage or elevation leaderboards).
9. Encourage conservative choices; modeling turning around is always a "best" answer when risk rises.
10. Emergency numbers vary by region; the app links to the local number and satellite-messenger guidance rather than hard-coding one.
11. A qualified reviewer (e.g. Wilderness First Responder and Leave No Trace trainer) reviews all safety-critical lessons before release (owner: product; see open questions).
12. Discreet mode: notifications never include the Person's name.

## 14. Content assets
| Asset | Type | Source | License id |
|---|---|---|---|
| Topo/landform diagrams (`topo.*`, `diagram.*` for hotspot-tap, binary-call) | Procedural, generated from the same heightfield code as the sim | In-house | `swoond-procedural` |
| Trail-mark, cairn, plant, krummholz, talus, cirque, tick illustrations (`visual-id`) | Original illustration | In-house or commissioned | `swoond-original-illustration` |
| Sim art | Procedural (see sim spec section 18) | In-house | `swoond-procedural` |
| Optional photography | NPS/USGS public domain only after review | Agencies | `nps-public-domain`, `usgs-public-domain` |
| Audio | None | n/a | n/a |
| Fonts | Instrument Serif, Geist | OFL | `ofl` |

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Gain vs. distance, layering, water and food, trip plan and turnaround, basic navigation, weather in mountains, and Leave No Trace (sections 2-3).
- [x] 2. **What do enthusiasts care about?** Conditions, timing, gear trade-offs, permits and crowds, ethics, long trails and lists (section 4).
- [x] 3. **What current information matters?** Weather, alerts, closures, smoke, snowpack, fire, permit windows and seasons (section 6, `live-data.md`).
- [x] 4. **What should be interactive?** Judgment scenarios, map reading (the Contour Flyover), estimates, ordering processes, conversation (section 5, 12).
- [x] 5. **What should NOT be gamified?** Hazards, emergencies, wildlife, crossings, avalanche terrain, mileage/elevation/summit leaderboards (section 5, 13).
- [x] 6. **How should it personalize?** Region, destination, equipment, skill level, and three branches (section 8).
- [x] 7. **What does conversational competence look like?** Following her recap, asking about gain, timing and conditions, admitting what you do not know (section 9).
- [x] 8. **What data providers are needed?** NWS, NPS, NRCS, USGS, AirNow, NIFC, RIDB metadata; agency feeds; no AllTrails API (section 6, `live-data.md`).
- [x] 9. **What licensing constraints apply?** Original art, agency data terms, ODbL, trademarks as text, no publisher text (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery, say-this interpretation, talk-track Smooth score, safety decisions, review retention (section 10).

Additional gates: [x] manifest validates (run `tools/validate`); [ ] curriculum JSON authored and validates (next step); [ ] Astra approves the sim spec; [x] every image/audio asset planned has a license id; [ ] voice review; [x] no copied publisher text; [ ] qualified safety review (WFR / LNT trainer).

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Approve one Unity sim (Contour Flyover) or ship the whole course native at launch? The sim is isolated to 5 lessons with a native fallback, so the course does not depend on it. | Product | No |
| 2 | Who performs the qualified safety review (WFR, LNT trainer) and when? | Product | Yes for release |
| 3 | Confirm 16 units vs. the 8-14 guidance (template layer minimums imply 16). | Product / orchestrator | No |
| 4 | Editorial/news provider for "why is this trail closed" (DECISIONS Q-3); launch is link-only. | Product | No |
| 5 | AllTrails partnership approach vs. deep-link only. | Product | No |
| 6 | Illustration sourcing (in-house vs. commissioned) for `visual-id` assets. | Product | No for CDS approval |
| 7 | Non-U.S. scope: launch is U.S. land agencies and NWS only. | Product | No |
| 8 | Should "leave your trip plan with a contact" nudge integrate with the app's Person list (privacy risk), or stay purely educational? | Product / Claude | No |
| 9 | Manifest `foundationalModules` vs. curriculum unit ids: confirm only foundations-layer units belong in `foundationalModules` (this manifest does so). | Orchestrator | No |
