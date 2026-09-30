# Course Design Specification: Camping (`camping`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Camping, like hiking, is deliberately **not** modeled as a sport (spec sections 17, 38): no scores, standings or leaderboards. It is a judgment, campcraft and rules course: where to sleep, how to stay warm, dry and fed, how to store food and use fire responsibly, how to leave a place as you found it, and how to get a site at all. It is a **safety-critical course** (fire, carbon monoxide, wildlife, water, cold): a qualified safety review is a release gate (D-017 / P-18 / S-05).

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Camping course design agent (Claude), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion docs | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity, see section 5) |
| Adjacent course read | `docs/courses/hiking/CDS.md`, `exercises.md`, `live-data.md`, `manifest.json` (`SAFETY_REVIEW.md` does not exist yet; noted in `NOTES_FOR_ORCHESTRATOR.md`) |

---

## 1. Identity
- **Course ID:** `camping` (immutable)
- **Display name:** Camping
- **Category / family:** Outdoors & Adventure; category path `Outdoors > Camping`
- **Simulation prefix:** `camping` (reserved; **no sim ids are planned**, `unitySimulations: []`)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns camping, are they meaningfully conversationally competent about it?" | Verdict | Consequence for structure |
|---|---|---|---|
| Hiking (`hiking`, Wave 1) | Partly. Leave No Trace basics, layering, weather sense, water treatment and wildlife principles transfer. Shelter craft, sleep systems, campsite choice, camp kitchens, food storage rules, fire rules, reservations and camp culture do not, and a hiker can know all of hiking and still not know why a pad has an R-value or how to book Site 14. | Adjacent, independent | Camping owns **campcraft**. It never re-teaches navigation, contour reading, Naismith, turnaround times, altitude or trail difficulty, and cross-links instead (table below). Overlap concepts are taught from the **camp angle** (the night, the site) with a link to the hiking unit for the trail angle. |
| Backpacking / overnight trips | Mostly yes for campcraft (tent, bag, stove), no for trail logistics. | Shares foundation (branch, not a course) | One branch unit `backpacking-overnight` (7 lessons) bridges to hiking; base weight, ultralight and thru-hike culture stay in hiking. |
| Climbing (`climbing`, Wave 3) | No. Ropes, anchors and grades are a separate safety-critical language. | Independent | Not mentioned beyond "approach camps" in culture. |
| Cooking (`cooking`, Wave 2) | Barely. Camp kitchens borrow the vocabulary but the skill (technique, ingredients) differs. Camp cooking here is stoves, fuel, cold storage, food safety and dishes. | Adjacent, independent | `camp-kitchen-and-water` teaches stove, cooler and water safety, not recipes. `camp-classics` only lets the learner talk foil packets and dutch ovens; link out to cooking. |
| RVs and van life | Partly for campground etiquette and hookups; no for vehicle systems. | Adjacent (future) | Etiquette and hookups in `car-camping-life`; van life and overlanding as culture only. |
| Stargazing / astronomy | No, except camp-adjacent dark-sky culture. | Independent | Two culture lessons (`ch-04`, `ch-05`); no astronomy course content. |

**Cross-links to hiking (concept ids in `docs/courses/hiking/exercises.md`).** Camping concepts stay unique to this course; where a hiking concept is the trail-side twin, the camping lesson carries `crossLink` metadata and a deep-link "Also in Hiking" card, and does not repeat the lesson.

| Camping concept | Hiking concept / unit | What camping adds |
|---|---|---|
| `lnt-principles` | `leave-no-trace`, `pack-it-out`, `durable-surface` (`trail-basics`) | The camp half: waste, dishes, fires, campsite impact |
| `water-treatment-camp` | `water-treatment`, `giardia` (`wf-02`) | Camp water systems, potable taps, dishes and greywater |
| `hypothermia-camp` | `hypothermia`, `wind-chill` (`wx-05`), `layering-system` | The night: bag, pad, wet gear, stove-in-tent traps |
| `heat-illness-camp` | `heat-illness` (`wf-06`) | Vehicle heat and camp shade |
| `lightning-camp` | `lightning-safety` (`wx-04`) | Tent is not shelter; vehicle rules |
| `flash-flood-camp`, `dry-wash-flood` | `flash-flood` (`wx-07`) | Choosing a site outside flood paths |
| `bear-canister`, `bear-encounter`, `wildlife-distance` | `bear-canister`, `wildlife-encounter` (`jd-07`) | Food storage as a camp system: boxes, vehicles, sacks, hangs |
| `wilderness-permit-camp`, `permit-lottery-camp`, `quota` | `wilderness-permit`, `permit-lottery` (`np-02`, `np-03`) | Campground reservations, rolling windows and first-come sites (Recreation.gov) |
| `fire-restrictions`, `ember-hazard` | `red-flag-warning`, `fire-closure` (`wx-08`) | The campfire question itself |
| `cell-coverage-camp` | `cell-coverage-myth` (`jd-08`) | Camp-specific: no bars at the site, emergency plan |
| `overnight-backpacking`, `weight-vs-comfort` | `base-weight`, `ultralight` (`gn-01`, `gn-02`) | Pointer only; hiking owns the pack-weight debate |
| `tick-mosquito-camp` | `tick-check` (`tn-05`) | Short pointer; no duplicate lesson |

- **Branches** (learner-selected or inferred from the Person's stated camping style; each adds one branch unit with `branchId`):

| id | Name | What changes (rules, data, culture) |
|---|---|---|
| `car-camping` | Car camping (default) | Developed campgrounds, hookups and generators, kids and dogs, comfort gear, camp kitchen boxes, rain days; the reserved-site culture. |
| `backpacking` | Overnight backpacking | Carrying the camp: permits and designated sites, dry camps and water carry, canister placement, breaking camp; bridges to hiking. |

Dispersed camping and overlanding are **not** a branch: the rules (stay limits, setbacks, no services, leave-no-trace at scale) live in `public-lands-and-reservations` (`pr-02`) and culture in `ch-06`, because they are land-management facts every camper needs. Branches not built at launch: winter and snow camping (a real training-needed domain: awareness only later), paddle-in and canoe camping, RV and van systems, non-U.S. regions. **Region** (`{{region}}`) is a personalization dimension, not a branch: bear country, desert heat, fire weather and cold nights all change examples, not structure.

## 2. Beginner model
- **What a complete beginner knows:** camping is "sleeping in a tent" and "a fire and s'mores." They may have gone once as a kid or on a music-festival weekend. They think a tent equals shelter, a sleeping bag equals warmth, and a campfire is the point. They have almost no model of campsite hazards, why the ground is cold, food storage, fire restrictions, or that popular campsites are booked six months ahead.
- **Terminology that confuses:** rainfly, footprint, vestibule, guy line, freestanding, three-season vs four-season, R-value, comfort vs limit rating, fill power, condensation, hookups, dispersed camping, first-come first-served, rolling window, release time, wilderness permit, quota, bear box, canister, IGBC, attractant, cathole, WAG bag, greywater, fire ring, fire pan, mound fire, Stage 1 / Stage 2 restrictions, shutoff valve, drown-stir-feel, dead and down, quiet hours, camp host.
- **Common misconceptions (each is a lesson target):**
  1. "A tent will keep me safe in a storm." (No: a tent is not lightning shelter; `lightning-camp`.)
  2. "I can cook or warm up in the tent if I crack the door." (No: carbon monoxide and fire; `carbon-monoxide`, `tent-heater`.)
  3. "The sleeping bag is what keeps me warm." (The pad and dry clothes matter as much; `r-value`.)
  4. "Bags are rated by their big number." (Comfort, not extreme; `bag-temp-rating`.)
  5. "The tent leaked." (Often condensation; `condensation`.)
  6. "Food in the car is fine." (Only where rules say so; lockers first; `vehicle-food-storage`.)
  7. "Bears only want food." (Toothpaste, trash and coolers count; `attractants`.)
  8. "A small fire is fine during a ban." (No: bans are legal orders; `fire-ban`.)
  9. "Clear water is safe water." (`water-treatment-camp`.)
  10. "Cooked food that sat in the cooler is fine." (`danger-zone`.)
  11. "Any flat spot is a campsite." (Washes, low ground, dead trees; `site-criteria`, `hazard-tree`.)
  12. "I can just show up." (Reservations, permits, quotas, first-come sites; `rolling-window`.)
  13. "Biodegradable soap means I can wash in the lake." (`greywater`, `water-setback`.)
  14. "Burying trash is Leave No Trace." (Pack it out; `micro-trash`.)
- **Concepts that unlock the rest (become foundation units):** the site (anatomy and criteria), the sleep system (pad, bag, shelter), the camp kitchen (stove, cold storage, safe water), and the food-and-fire rules. Everything else hangs on these.

## 3. Foundational knowledge
| Module | Contents |
|---|---|
| `camp-basics` | Front-country, backcountry and car camping; campsite anatomy (tent pad, fire ring, bear box, table, loop); hookups; camp hosts; quiet hours and check-in; a checklist by trip type; camp zones; lights and red mode |
| `shelter-and-sleep` | Tent parts, three- vs four-season, freestanding vs trekking-pole vs hammock, pitching and staking, orientation to wind, pads and R-value, bags and ratings, down vs synthetic, liners, condensation and ventilation, dry sleep clothes |
| `campsite-selection` | Flat and drained, hazard trees, dry washes and cold air, setback from water (about 200 ft), wind and sun, durable and established sites, the camp triangle, scouting |
| `camp-kitchen-and-water` | Stove types, stove safety, kitchen layout, meal planning, cooler craft and the danger zone, water treatment, dishes and greywater, camp classics |

Also foundational across later units: food storage and wildlife (bear boxes, canisters, spray, distance, never feed), fire (rings, pans, restriction stages, firewood rules, putting a fire out), camp safety (CO, hypothermia, heat, storms, floods, help), Leave No Trace at camp, public lands and reservations. **Organizations the learner should recognize:** NPS, USFS, BLM, state parks, Recreation.gov (operated for federal agencies), the Leave No Trace Center for Outdoor Ethics, the Interagency Grizzly Bear Committee (IGBC) for certified bear-resistant products, Smokey Bear and the Ad Council fire-prevention campaign, National Interagency Fire Center, Don't Move Firewood, KOA and private campgrounds, the CDC (water and carbon monoxide guidance) and NWS (lightning and heat).

## 4. Enthusiast model
- **What enthusiasts talk about:** the site ("Site 14 backs to the creek"), the booking story ("four tries at release time"), the night ("dropped to 30, my pad was fine but my feet froze"), the kitchen ("foil packets, twenty minutes"), the fire ("Stage 2, so stove only"), wildlife ("the raven unzipped my pack"), the sky ("Milky Way from camp"), gear (pad R-values, canister vs sack, stove type), and values (Leave No Trace, quiet hours, dark-sky manners).
- **Distinctions that matter to them:** car camping vs backcountry vs dispersed; developed vs primitive campground; reserved vs first-come; three- vs four-season; comfort vs limit rating; down vs synthetic; foam vs inflatable; canister vs Ursack vs hang; stove vs fire; "established site" vs "new site"; "packing out" vs "burying"; quiet hours vs generator hours.
- **Knowledge that signals genuine understanding:** checking the overnight low, not the daytime high; knowing the release time and having a backup site; asking "is the water potable or do I need to treat it?"; noticing a hazard tree; knowing fire rules change by the day; storing toothpaste in the bear box; not cooking in the tent, ever.
- **Beginner statements that sound obviously uninformed:** "We'll just crack the door and run the heater." "The tent will keep us safe in the storm." "It's a small fire, it's fine." "We'll leave the food in the car overnight." "I'll wash the dishes in the lake." "Any flat spot works." "I'll book when we're closer." "My 20-degree bag will be fine at 20 degrees."
- **Controversies and debates (each becomes a Debate lesson or Talk Track hook):**
  - Bear canister vs Ursack vs hang (rules differ by area; we teach "follow the local rule").
  - Campfires vs stoves-only, and whether fires should be allowed in fire-prone areas.
  - Pad wars: closed-cell foam vs inflatable; R-value inflation.
  - Down vs synthetic, and hydrophobic down.
  - Tent vs tarp vs hammock; cowboy camping.
  - Rooftop tents and glamping: real camping?
  - Reservation systems: lotteries, bots, cancellation hunting and the six-month rush.
  - Dispersed camping crowding and geotagging fragile places.
  - Generators and quiet hours in campgrounds; dogs at camp.
  - Van life and overlanding on public land.
  - Ultralight vs comfortable car camping (we do not take a side).

## 5. Interaction model
- **What the learner should EXPERIENCE instead of read:** making the calls a camper makes: where to pitch, whether to light a fire today, what goes in the box, what to do when thunder starts, whether to toss the cooler food, how to book a site the minute it opens. Judgment and rules beat memorization; the north star is understanding why she loves it.
- **Does the course warrant Unity? No. Zero Tier A sims, justified below.** The CLAUDE.md rubric asks whether spatial reasoning, movement, physics, scene timing or camera perspective materially improves learning *and* a native exercise would teach it clearly worse. Camping is a *rules, hazards and judgment* subject. Its spatial ideas (which patch of ground is best, where the water goes) are **static and diagrammatic**: a top-down or cross-section diagram with `hotspot-tap` shows a hazard tree, a dry wash and a level rise in one image, and a `decision-scenario` fact sheet carries the reasoning. Everything else is time-ordered process (`sequence-order`), magnitude (`estimate-slider`), recognition (`visual-id`) or conversation. A game engine would add polish, not understanding, and a "camp survival sim" would tempt gaming of real hazards (fire, CO, wildlife), which the safety rules forbid.
- **Unity candidates considered and rejected:**

| Candidate | Why rejected |
|---|---|
| Campsite selection in 3D (`camping.site.read.v1` on the shared terrain toolkit, GK-20) | The strongest candidate: rain flows downhill, cold air pools, a tree falls. But every concept is a static relationship (low ground collects water, dead trees fall, washes flood) that `hotspot-tap` on a procedural cross-section and `decision-scenario` teach clearly. No motion or perspective is needed to learn it, and a simulated storm would imply the learner can predict real conditions. **Revisit only if playtests show hotspot-tap fails**; it would reuse `Heightfield`, `TerrainMesh` and `SlopeShader` with no new kit items. |
| Campfire or stove simulation | Real risk: it would model fire behavior and invite experimentation ("what if I add more wood in the wind?"). Rules, restriction stages and the drown-stir-feel order are taught natively. |
| Carbon monoxide in a tent | A visualization could show gas building up, but it would imply a threshold where it is safe. The lesson is absolute (never burn fuel in a tent), so a conservative `decision-scenario` is better and safer. |
| Bear encounter or food-storage game | Entertainment risk, false confidence, and the correct lesson is a rule (store food properly) plus distance. Native only. |
| Tent pitching in wind | Physics is not the concept; order and orientation are. `sequence-order` and `decision-scenario`. |
| Tying knots | `sequence-order` with step `why` text is enough; a knot sim would be a fake game. |
| Star-gazing | Fun, but a planetarium is not the goal; lessons are about dark skies and timing. |

- **What should NOT be gamified:** fire, carbon monoxide, wildlife, water treatment, hypothermia, heat, lightning, flash floods, evacuation and every emergency. No timers, streak or speed bonuses on hazard decisions; safety scenarios always show a `safetyNote`. No counts of nights, sites, parks or "camping streaks" that could push someone to camp unsafely; no badges for campfires. Conversation and reservation lessons may be light; safety lessons are never framed as a game.
- **Chosen mix (details in section 12):** 100% native. `decision-scenario` (about a fifth of activity slots and the heart of the course per spec section 17), `multiple-choice`, `say-this`, `talk-track`, `hotspot-tap`, `sequence-order`, `binary-call`, `estimate-slider`, `term-match`, `fill-the-gap`, `visual-id`, and a live conditions layer generated from official data.

## 6. Dynamic information requirements
Camping data is environmental and regulatory, not competitive (spec sections 10, 38). Full plan in `live-data.md`.

| Kind | Needed? | Why | Providers (via adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| Scores / standings / rankings / statistics / rosters / schedules | No | Would be invented sport framing | n/a | n/a | n/a |
| Weather (overnight lows, wind, storms) | Yes | "What is the low tonight?", storms, heat | NWS API | hourly | Last snapshot with age |
| Alerts (red flag, flood, heat, smoke) | Yes | Fire and weather hazards at camp | NWS alerts; NPS API; AirNow | hourly | Cached with age; official link |
| Closures and campground alerts | Yes | Campground closures, bear activity, road and water status | NPS API (`/alerts`, `/campgrounds`); USFS and BLM alert pages (link); NIFC/InciWeb | daily (hourly in fire season) | Cached; link to agency |
| Regulations (fire restrictions and bans) | Yes | The central "can I have a fire?" question | Agency restriction pages (link-first); no unified national machine feed is assumed | daily in fire season | Link only; never invent a stage |
| Conditions (fire danger, snow, smoke, stream flow) | Yes | Seasonal layer | NIFC, NRCS SNOTEL, AirNow, USGS | daily | Hide card |
| Events (booking windows, permit lotteries, meteor showers, dark-sky dates) | Yes, computed or authored | "What opens when?" | On-device date rule for rolling windows; editorial calendar with `lastVerified` | seasonal | Authored defaults |
| News | Link-only | "Why is the campground closed?" | Agency press RSS; licensed news TBD (L-01) | daily | Hidden |
| Releases / new products / new media | No | No learning value | n/a | n/a | n/a |

Structured data (NWS, NPS, NIFC, AirNow, USGS, NRCS) and editorial context (press releases, camp reports) are separate systems. Key adapter constraints (verified 2026-09-30, see `live-data.md`): Recreation.gov **availability and booking are not part of the public RIDB**, so Swoon'd never scrapes it; availability is a deep-link. The "what opens when" feature is a **computed rule** (arrival date minus the facility's window), flagged "confirm on the listing".

## 7. Editorial context
- **What commentary helps:** why a campground is closed or a fire ban was issued; what a red flag warning or Stage 2 restriction means for tonight; why permit lotteries and quotas exist; why bear-resistant storage is required in some places; what "shoulder season" means for a site that is "open".
- **Sources (link-only or explain-and-link):** agency alerts and press releases (NPS, USFS, BLM), NWS discussions (linked), Recreation.gov facility pages (linked), outdoor publications and camp reports (headline and link only).
- **Licensing restrictions:** agency text is generally public domain but images may carry credits; publisher articles and camp reviews are copyrighted and never copied.
- **Approach:** `explain-and-link`.
- **Example prompts:** "Why is the campground closed?" "What does Stage 2 mean for our weekend?" "Why did the lake site sell out in ten seconds?" "Why is everyone talking about the meteor shower?"

## 8. Personalization
| Dimension | How it changes examples and live context | Default when unset | Units using tokens |
|---|---|---|---|
| `region` | Bear country, fire season, desert heat, cold nights, local agencies, live layer | "your area" (neutral U.S. temperate examples) | `camp-basics`, `shelter-and-sleep`, `campsite-selection`, `food-storage-and-wildlife`, `fire-and-fire-rules`, `camp-safety-and-weather`, `leave-no-trace-at-camp`, `public-lands-and-reservations`, `camp-culture-and-history`, `camping-season-layer` |
| `destination` | The campground or park she loves ("her campground"), reservation and alert context | "the campground she loves" | `campsite-selection`, `public-lands-and-reservations` |
| `equipment` | Her tent, stove, pad, cooler, rig | "your gear" | `shelter-and-sleep`, `camp-kitchen-and-water`, `car-camping-life`, `backpacking-overnight`, `camp-gear-debates` |
| `style` (`{{camping-style}}`) | Car, backpacking or dispersed: which scenarios and vocabulary are foregrounded | "car camping" | `camp-basics`, branch units, `talk-the-campsite` |
| `skill-level` | Scenario difficulty, sim-free pacing of talk tracks | "beginner" | `camp-kitchen-and-water`, `camp-safety-and-weather`, `camp-craft-skills`, `talk-the-campsite`, `perpetual-review` |

Tokens: `{{region}}`, `{{destination}}`, `{{equipment}}`, `{{camping-style}}`, `{{skill-level}}`. Copy must read well with defaults. Branch selection (`car-camping`, `backpacking`) gates the branch units. Manifest `personalizationDimensions` uses the schema enum (`region`, `destination`, `equipment`, `style`, `skill-level`). Personalization never puts the Person's name in notifications (discreet mode).

## 9. Conversation model
- **What an enthusiast might naturally say (translation and implied terms):**

| # | She says | What it means | Terms implied |
|---|---|---|---|
| 1 | "I got Site 14! It took four tries at release time." | She won a competitive booking the instant a rolling window opened. | `rolling-window`, `release-time` |
| 2 | "It dropped to thirty last night. My pad was fine but my feet froze." | Overnight low, a well-rated pad, and cold feet from the bag or dry socks. | `overnight-low`, `r-value`, `bag-temp-rating` |
| 3 | "Stage 2, so stove-only dinner." | A fire restriction stopped campfires; valve stoves may still be allowed. | `fire-restrictions`, `shutoff-valve` |
| 4 | "Toothpaste goes in the bear box too." | Anything scented is an attractant. | `attractants`, `bear-box` |
| 5 | "I had to carry a canister, it is the rule there." | A required bear-resistant food container. | `bear-canister`, `igbc-certified` |
| 6 | "We dispersed on national forest, fourteen-day limit, no services." | Free camping outside a campground on public land. | `dispersed-camping`, `stay-limit` |
| 7 | "There was so much condensation, but no leak." | Wet tent from breath and humidity. | `condensation`, `ventilation` |
| 8 | "The site was on a rise, away from the wash." | She picked ground outside flood paths. | `site-criteria`, `dry-wash-flood` |
| 9 | "The raven unzipped my pack." | A camp thief. | `small-thieves` |
| 10 | "We drove three hours for a real dark sky." | A low-light-pollution site for the Milky Way. | `dark-sky`, `milky-way-season` |
| 11 | "Foil packets, twenty minutes." | Quick foil-wrapped camp dinners. | `camp-classics` |
| 12 | "I did not geotag it. It cannot take a crowd." | She kept a fragile place quiet. | `geotagging` |
| 13 | "Cold water, so we filtered and treated." | Filter plus chemical or boiling. | `water-treatment-camp` |
| 14 | "We were first-come, so we arrived Thursday." | A site not booked in advance. | `first-come-site` |

- **What the learner can meaningfully ask next:** "What was the low?" "What was the site like: flat, shady, near water?" "Was it reserved or first-come?" "Were there fire restrictions?" "How did you store the food?" "What do you love most about camp mornings?"
- **Helping without encouraging fake expertise:** every `say-this` and `talk-track` carries a `noFakeExpertNote` or coach note rewarding **honest curiosity** ("I'm new to this, what is R-value?") over bluffing. Cringe replies model faked expertise or safety-dismissing bravado ("a small fire is fine", "the tent will keep us safe") and are penalized. Swoon'd never scripts opinions the learner does not hold.
- **Targets:** 24 talk tracks at launch (8 drafted in `exercises.md`), 60+ `say-this` items, growing with the live layer.

## 10. Assessment
- **How useful competence is determined:** concept-level mastery (0-1) from exercise outcomes (`concept-mastery-v1`), with **safety-critical concepts** requiring at least **two correct decision-scenario outcomes across two sessions** before showing as Mastered: `carbon-monoxide`, `tent-heater`, `fire-restrictions`, `fire-accelerant`, `drown-stir-feel`, `unattended-fire`, `attractants`, `bear-canister`, `vehicle-food-storage`, `wildlife-distance`, `never-feed`, `water-treatment-camp`, `danger-zone`, `hypothermia-camp`, `lightning-camp`, `flash-flood-camp`, `dry-wash-flood`, `hazard-tree`, `hot-vehicle`, `wildfire-evacuation`, `stove-safety`.
- **Recognize:** tent and stove types, campsite features, hazard trees and washes on a diagram, camp thieves, campground signs.
- **Understand:** why the pad matters, why the low matters more than the high, why food storage is a rule, why fire restrictions change, why water needs treating, why sites sell out.
- **Explain:** her plan from her trip line ("what does Stage 2 do to dinner?"), why you never cook in a tent.
- **Correctly interpret:** a campground listing, a fire restriction notice, an overnight forecast, a bag rating, a permit or booking-window message, a camper's recap.
- **Mastery model:** pass threshold 0.8; review policy Leitner boxes.
- **Useful competence statement:** *"Can follow her camp talk, sanity-check a night out for site, warmth, food storage, fire rules and water, book or plan a site without bluffing, and ask a real follow-up, without pretending to be an expert or a safety authority."*
- Swoon'd measures understanding by whether the learner can interpret her statements (`say-this`), hold a conversation (`talk-track` Smooth score), and make sound conservative calls on scenarios, not by completion, XP or nights camped.

## 11. Curriculum map (ongoing course)
17 units, **120 lessons**, **179 Playbook concepts** (drafted in `exercises.md`, section "Playbook terms"). The unit count exceeds the 8-14 rule of thumb for the same reason as hiking (P-04): the template's layer minimums (4 foundation + 4 intermediate + 3 enthusiast) plus branches, live, conversation and review already total 17; see `NOTES_FOR_ORCHESTRATOR.md` for fold options. Lesson `activities` are native exercise types (no `unity-sim`); lesson ids are stable. Every lesson needs 4+ activities in curriculum JSON (validator `thin-lesson`): the "planned activities" column lists the **families**, and each family authors 2-3 items per lesson.

### Foundations

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `camp-basics` | Camping basics | none | 7: What counts as camping; Anatomy of a campsite; Reading the campground; Camp etiquette and quiet hours; The camp checklist; Three zones, one camp; Light after dark | `front-country`, `backcountry`, `car-camping`, `tent-pad`, `fire-ring`, `bear-box`, `campground-loop`, `hookups` ... |
| `shelter-and-sleep` | Shelter and sleep systems | `camp-basics` | 8: Tent anatomy; Seasons and sizes; Freestanding, trekking-pole, hammock; Pitching it right; Sleeping pads and R-value; Sleeping bags: what the number means; Condensation and ventilation; Sleeping warm, staying dry | `rainfly`, `footprint`, `vestibule`, `tent-poles`, `three-season-tent`, `four-season-tent`, `freestanding`, `trekking-pole-shelter` ... |
| `campsite-selection` | Choosing a campsite | `camp-basics` | 7: Flat, drained, sheltered; Look up: hazard trees; Water, washes and cold air; Wind, sun and view; Durable surfaces and existing sites; The camp triangle; Arrive, scout, decide | `site-criteria`, `drainage`, `hazard-tree`, `widowmaker`, `water-setback`, `dry-wash-flood`, `cold-air-pooling`, `wind-shelter` ... |
| `camp-kitchen-and-water` | Camp kitchen and water | `camp-basics` | 9: Stoves compared; Stove safety; Setting up the camp kitchen; Planning meals; Cooler craft and food safety; Making water safe; Dishes and greywater; Cooking in wind and rain; Camp classics | `canister-stove`, `liquid-fuel-stove`, `alcohol-stove`, `two-burner-stove`, `stove-safety`, `wind-screen`, `camp-kitchen-layout`, `meal-planning` ... |

#### `camp-basics`: Camping basics

What camping is, how a campsite works, and the trip from arrival to pack-up. Personalization slots: {{region}}, {{camping-style}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `cb-01` | What counts as camping | You can tell front-country, backcountry and car camping apart. | `front-country`, `backcountry`, `car-camping` | `term-match`, `multiple-choice` |
| `cb-02` | Anatomy of a campsite | You can name the parts of a developed campsite and what each is for. | `tent-pad`, `fire-ring`, `bear-box`, `campground-loop` | `hotspot-tap`, `term-match` |
| `cb-03` | Reading the campground | You can explain hookups, camp hosts and how loops differ. | `hookups`, `camp-host`, `campground-loop` | `multiple-choice`, `say-this` |
| `cb-04` | Camp etiquette and quiet hours | You can follow quiet hours, check-in and checkout without guessing. | `quiet-hours`, `check-in-time` | `binary-call`, `decision-scenario` |
| `cb-05` | The camp checklist | You can build a checklist from the trip type instead of from memory. | `camp-checklist`, `weight-vs-comfort` | `fill-the-gap`, `multiple-choice` |
| `cb-06` | Three zones, one camp | You can lay out cook, sleep and toilet zones and explain why. | `camp-zones` | `hotspot-tap`, `sequence-order` |
| `cb-07` | Light after dark | You can pick lighting that helps you and does not bother neighbors. | `red-light-mode` | `multiple-choice`, `binary-call` |

#### `shelter-and-sleep`: Shelter and sleep systems

Tents, pads, bags and the science of staying warm, dry and comfortable overnight. Personalization slots: {{equipment}}, {{region}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `ss-01` | Tent anatomy | You can name the parts of a tent and what each does. | `rainfly`, `footprint`, `vestibule`, `tent-poles` | `hotspot-tap`, `term-match` |
| `ss-02` | Seasons and sizes | You can explain what three-season and four-season mean and how tent capacity is measured. | `three-season-tent`, `four-season-tent` | `multiple-choice`, `binary-call` |
| `ss-03` | Freestanding, trekking-pole, hammock | You can recognize the main shelter types and their trade-offs. | `freestanding`, `trekking-pole-shelter`, `hammock-camping` | `visual-id`, `multiple-choice` |
| `ss-04` | Pitching it right | You can pitch a tent in the right order and orient it against the wind. | `stake-out`, `guy-line`, `tent-orientation` | `sequence-order`, `decision-scenario` |
| `ss-05` | Sleeping pads and R-value | You can pick a pad for the season by R-value. | `sleeping-pad`, `r-value` | `estimate-slider`, `multiple-choice` |
| `ss-06` | Sleeping bags: what the number means | You can read a bag rating and compare down and synthetic. | `bag-temp-rating`, `down-vs-synthetic`, `fill-power`, `bag-liner` | `multiple-choice`, `term-match` |
| `ss-07` | Condensation and ventilation | You can tell condensation from a leak and fix it with airflow. | `condensation`, `ventilation` | `decision-scenario`, `multiple-choice` |
| `ss-08` | Sleeping warm, staying dry | You can build a warm, dry sleep routine and keep wet gear away from the dry system. | `dry-sleep-clothes`, `wet-gear-management` | `decision-scenario`, `fill-the-gap` |

#### `campsite-selection`: Choosing a campsite

Reading the ground, the trees, the water and the weather before you unpack. Personalization slots: {{region}}, {{destination}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `cs-01` | Flat, drained, sheltered | You can judge a site by slope, drainage and shelter. | `site-criteria`, `drainage` | `hotspot-tap`, `multiple-choice` |
| `cs-02` | Look up: hazard trees | You can spot a hazard tree and know why you move. | `hazard-tree`, `widowmaker` | `hotspot-tap`, `decision-scenario` |
| `cs-03` | Water, washes and cold air | You can explain setback from water, dry-wash flooding and cold-air pooling. | `water-setback`, `dry-wash-flood`, `cold-air-pooling` | `hotspot-tap`, `decision-scenario` |
| `cs-04` | Wind, sun and view | You can weigh shelter, shade and view without ignoring hazards. | `wind-shelter`, `site-criteria` | `binary-call`, `multiple-choice` |
| `cs-05` | Durable surfaces and existing sites | You can pick a durable surface and an established site over a fresh scar. | `durable-camp-surface`, `established-site` | `multiple-choice`, `decision-scenario` |
| `cs-06` | The camp triangle | You can place cooking, sleeping and storage well apart. | `camp-triangle` | `hotspot-tap`, `sequence-order` |
| `cs-07` | Arrive, scout, decide | You can scout a site and decide when to move on. | `site-scouting` | `decision-scenario`, `estimate-slider` |

#### `camp-kitchen-and-water`: Camp kitchen and water

Stoves, food planning, cold storage, safe water and clean dishes. Personalization slots: {{equipment}}, {{skill-level}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `ck-01` | Stoves compared | You can name the main stove types and where each shines. | `canister-stove`, `liquid-fuel-stove`, `alcohol-stove`, `two-burner-stove` | `term-match`, `visual-id` |
| `ck-02` | Stove safety | You can use a stove safely and explain why never in a tent. | `stove-safety`, `wind-screen` | `decision-scenario`, `binary-call` |
| `ck-03` | Setting up the camp kitchen | You can lay out a camp kitchen for safety and flow. | `camp-kitchen-layout` | `hotspot-tap`, `sequence-order` |
| `ck-04` | Planning meals | You can plan meals, fuel and water for a trip. | `meal-planning` | `estimate-slider`, `multiple-choice` |
| `ck-05` | Cooler craft and food safety | You can pack a cooler and know when food must be tossed. | `cooler-craft`, `danger-zone` | `estimate-slider`, `decision-scenario` |
| `ck-06` | Making water safe | You can pick a treatment method that matches the threat. | `water-treatment-camp`, `potable-water` | `multiple-choice`, `decision-scenario` |
| `ck-07` | Dishes and greywater | You can wash dishes without harming water or attracting wildlife. | `dishwashing-system`, `greywater` | `sequence-order`, `multiple-choice` |
| `ck-08` | Cooking in wind and rain | You can adapt cooking safely to weather. | `wind-screen`, `stove-safety` | `decision-scenario`, `fill-the-gap` |
| `ck-09` | Camp classics | You can talk foil packets, dutch ovens and camp breakfast. | `camp-classics` | `say-this`, `term-match` |

### Intermediate

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `food-storage-and-wildlife` | Food storage and wildlife | `campsite-selection`, `camp-kitchen-and-water` | 8: Why food storage matters; What counts as smelly; Bear boxes and vehicles; Bear canisters; Hangs, sacks and odor bags; Bear spray and encounters; Small thieves; Distance and never feed | `food-conditioned`, `attractants`, `food-locker`, `bear-box`, `vehicle-food-storage`, `bear-canister`, `igbc-certified`, `bear-hang` ... |
| `fire-and-fire-rules` | Fire and fire rules | `campsite-selection` | 8: Fire: the joy and the hazard; Rings, pans and mound fires; Restriction stages and bans; Firewood rules; Safe distance and clearance; No accelerants; Drown, stir, feel; Fire talk | `campfire-culture`, `unattended-fire`, `fire-ring`, `fire-pan`, `mound-fire`, `fire-restrictions`, `fire-ban`, `shutoff-valve` ... |
| `camp-safety-and-weather` | Camp safety and weather | `shelter-and-sleep`, `campsite-selection` | 9: Carbon monoxide: the silent hazard; Heaters, lanterns and charcoal; Cold nights and hypothermia; Heat and hot vehicles; Storms and wind at camp; Floods and rising water; Bugs and skin; First aid and a plan; No bars, smoke and evacuation | `carbon-monoxide`, `co-symptoms`, `tent-heater`, `hypothermia-camp`, `heat-illness-camp`, `hot-vehicle`, `lightning-camp`, `wind-storm-camp` ... |
| `leave-no-trace-at-camp` | Leave No Trace at camp | `camp-basics` | 7: The seven principles, camp edition; Human waste; Trash and micro-trash; Camp impact; Leave what you find; Neighbors and noise; Crowds, groups and geotags | `lnt-principles`, `cathole`, `wag-bag`, `pack-out-tp`, `vault-toilet`, `micro-trash`, `campsite-impact`, `durable-camp-surface` ... |
| `public-lands-and-reservations` | Public lands, reservations and permits | `camp-basics` | 9: Who runs the land; Developed versus dispersed; Recreation.gov 101; Beating the rush; First-come, first-served; Permits, quotas and lotteries; Fees and passes; Reading a site listing; Reservations gone wrong | `public-land-agencies`, `developed-campground`, `dispersed-camping`, `stay-limit`, `recreation-gov`, `rolling-window`, `release-time`, `cancellation-hunting` ... |

#### `food-storage-and-wildlife`: Food storage and wildlife

Why food storage matters, what counts as smelly, and how to store it where bears live. Personalization slots: {{region}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `fw-01` | Why food storage matters | You can explain how fed animals become dangerous. | `food-conditioned`, `attractants` | `multiple-choice`, `say-this` |
| `fw-02` | What counts as smelly | You can list what must be stored, including toiletries and trash. | `attractants` | `multiple-choice`, `binary-call` |
| `fw-03` | Bear boxes and vehicles | You can use a bear box first and follow vehicle rules. | `food-locker`, `bear-box`, `vehicle-food-storage` | `decision-scenario`, `binary-call` |
| `fw-04` | Bear canisters | You can explain when canisters are required and what certified means. | `bear-canister`, `igbc-certified` | `multiple-choice`, `decision-scenario` |
| `fw-05` | Hangs, sacks and odor bags | You can explain why hangs and sacks are conditional and follow the local rule. | `bear-hang`, `ursack`, `odor-proof-bag` | `multiple-choice`, `decision-scenario` |
| `fw-06` | Bear spray and encounters | You can describe bear-spray basics and encounter principles without acting like an expert. | `bear-spray`, `bear-encounter` | `decision-scenario`, `multiple-choice` |
| `fw-07` | Small thieves | You can protect camp from raccoons, ravens and rodents. | `small-thieves` | `visual-id`, `multiple-choice` |
| `fw-08` | Distance and never feed | You can keep wildlife distances and explain why feeding is harmful. | `wildlife-distance`, `never-feed` | `estimate-slider`, `decision-scenario` |

#### `fire-and-fire-rules`: Fire and fire rules

Campfire culture, where fires are allowed, restriction stages, firewood and putting a fire dead out. Personalization slots: {{region}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `fr-01` | Fire: the joy and the hazard | You can explain why campfires are loved and why they start wildfires. | `campfire-culture`, `unattended-fire` | `multiple-choice`, `say-this` |
| `fr-02` | Rings, pans and mound fires | You can explain fire containment options and when each is used. | `fire-ring`, `fire-pan`, `mound-fire` | `term-match`, `multiple-choice` |
| `fr-03` | Restriction stages and bans | You can read a fire restriction and decide what is allowed. | `fire-restrictions`, `fire-ban`, `shutoff-valve` | `decision-scenario`, `term-match` |
| `fr-04` | Firewood rules | You can explain buy-where-you-burn and dead-and-down rules. | `firewood-rules`, `dont-move-firewood`, `dead-and-down` | `multiple-choice`, `binary-call` |
| `fr-05` | Safe distance and clearance | You can set up a fire area with clearance and water ready. | `fire-clearance`, `ember-hazard` | `decision-scenario`, `sequence-order` |
| `fr-06` | No accelerants | You can explain why gasoline and fluids are never used to start fires. | `fire-accelerant` | `binary-call`, `multiple-choice` |
| `fr-07` | Drown, stir, feel | You can put a fire dead out and check it is cold. | `drown-stir-feel` | `sequence-order`, `decision-scenario` |
| `fr-08` | Fire talk | You can join fire and s'mores talk with respect for the rules. | `campfire-culture`, `smores` | `say-this`, `fill-the-gap` |

#### `camp-safety-and-weather`: Camp safety and weather

The hazards that are specific to camp: CO, cold nights, heat, storms, floods and getting help. Personalization slots: {{region}}, {{skill-level}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `sw-01` | Carbon monoxide: the silent hazard | You can explain why fuel-burning devices never go in a tent. | `carbon-monoxide`, `co-symptoms` | `decision-scenario`, `binary-call` |
| `sw-02` | Heaters, lanterns and charcoal | You can name heat sources that are unsafe in shelters and safer alternatives. | `tent-heater`, `carbon-monoxide` | `decision-scenario`, `multiple-choice` |
| `sw-03` | Cold nights and hypothermia | You can recognize hypothermia at camp and know when to get help. | `hypothermia-camp` | `decision-scenario`, `multiple-choice` |
| `sw-04` | Heat and hot vehicles | You can spot heat illness and explain vehicle heat danger. | `heat-illness-camp`, `hot-vehicle` | `decision-scenario`, `binary-call` |
| `sw-05` | Storms and wind at camp | You can explain lightning and wind decisions at a campsite. | `lightning-camp`, `wind-storm-camp` | `decision-scenario`, `binary-call` |
| `sw-06` | Floods and rising water | You can explain flash-flood danger for campsites and how to react. | `flash-flood-camp`, `dry-wash-flood` | `decision-scenario`, `multiple-choice` |
| `sw-07` | Bugs and skin | You can describe bug protection and daily checks. | `tick-mosquito-camp` | `multiple-choice`, `sequence-order` |
| `sw-08` | First aid and a plan | You can explain a camp first aid kit and an emergency plan. | `camp-first-aid`, `emergency-plan` | `fill-the-gap`, `multiple-choice` |
| `sw-09` | No bars, smoke and evacuation | You can plan for no signal and respond to smoke and evacuation notices. | `cell-coverage-camp`, `wildfire-evacuation` | `decision-scenario`, `multiple-choice` |

#### `leave-no-trace-at-camp`: Leave No Trace at camp

The seven principles, applied to camp: waste, trash, impact and other people. Personalization slots: {{region}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `ln-01` | The seven principles, camp edition | You can name the seven principles and give a camp example of each. | `lnt-principles` | `multiple-choice`, `term-match` |
| `ln-02` | Human waste | You can explain vault toilets, catholes and WAG bags. | `cathole`, `wag-bag`, `pack-out-tp`, `vault-toilet` | `decision-scenario`, `sequence-order` |
| `ln-03` | Trash and micro-trash | You can explain why small litter matters and how to sweep. | `micro-trash` | `multiple-choice`, `binary-call` |
| `ln-04` | Camp impact | You can name and avoid common campsite impacts. | `campsite-impact`, `durable-camp-surface` | `binary-call`, `decision-scenario` |
| `ln-05` | Leave what you find | You can explain why rocks, plants and artifacts stay. | `leave-what-you-find` | `multiple-choice`, `say-this` |
| `ln-06` | Neighbors and noise | You can respect neighbors with sound, light and dogs. | `considerate-camper` | `decision-scenario`, `talk-track` |
| `ln-07` | Crowds, groups and geotags | You can discuss group limits and geotagging with nuance. | `group-size-limit`, `geotagging` | `say-this`, `multiple-choice` |

#### `public-lands-and-reservations`: Public lands, reservations and permits

Who runs the land, how Recreation.gov works, first-come sites and permits. Personalization slots: {{region}}, {{destination}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `pr-01` | Who runs the land | You can tell NPS, USFS, BLM and state parks apart. | `public-land-agencies` | `term-match`, `multiple-choice` |
| `pr-02` | Developed versus dispersed | You can explain what dispersed camping asks of you. | `developed-campground`, `dispersed-camping`, `stay-limit` | `multiple-choice`, `decision-scenario` |
| `pr-03` | Recreation.gov 101 | You can explain rolling windows and release times. | `recreation-gov`, `rolling-window`, `release-time` | `estimate-slider`, `multiple-choice` |
| `pr-04` | Beating the rush | You can plan a booking day and use cancellations honestly. | `release-time`, `cancellation-hunting` | `decision-scenario`, `multiple-choice` |
| `pr-05` | First-come, first-served | You can plan a first-come arrival and pay correctly. | `first-come-site`, `self-pay-station` | `sequence-order`, `decision-scenario` |
| `pr-06` | Permits, quotas and lotteries | You can explain permits and why they exist. | `wilderness-permit-camp`, `permit-lottery-camp`, `quota` | `multiple-choice`, `decision-scenario` |
| `pr-07` | Fees and passes | You can explain fees, changes and pass discounts. | `cancellation-policy`, `discount-pass` | `fill-the-gap`, `multiple-choice` |
| `pr-08` | Reading a site listing | You can read site attributes and pick the right site. | `site-attributes`, `walk-in-site` | `decision-scenario`, `hotspot-tap` |
| `pr-09` | Reservations gone wrong | You can handle a late arrival, a no-show or a wrong site. | `check-in-time`, `cancellation-policy` | `decision-scenario`, `say-this` |

### Branches / personalization

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `car-camping-life` | Car camping life (branch `car-camping`) | `camp-kitchen-and-water` | 6: The car camp kitchen; Comfort gear; Kids at camp; Dogs at camp; RV and generator neighbors; The rain day | `camp-kitchen-box`, `two-burner-stove`, `camp-chair-culture`, `kids-at-camp`, `leash-rules`, `rv-etiquette`, `hookups`, `rain-day-plan` ... |
| `backpacking-overnight` | The overnight backpacking step (branch `backpacking`) | `shelter-and-sleep`, `campsite-selection` | 7: From day hike to overnight; Miles to camp; Water carry and dry camps; Designated sites and permits; Canister and camp setup on arrival; Breaking camp; Overnight trip talk | `overnight-backpacking`, `weight-vs-comfort`, `trip-mileage-camp`, `water-carry`, `dry-camp`, `designated-site`, `wilderness-permit-camp`, `canister-placement` ... |

#### `car-camping-life`: Car camping life

Developed-campground life: comfort, kids, dogs, RV neighbors and rain days. Personalization slots: {{equipment}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `cc-01` | The car camp kitchen | You can set up a camp kitchen box for a weekend. | `camp-kitchen-box`, `two-burner-stove` | `sequence-order`, `multiple-choice` |
| `cc-02` | Comfort gear | You can talk chairs, cots and canopies. | `camp-chair-culture` | `multiple-choice`, `say-this` |
| `cc-03` | Kids at camp | You can set fire, water and boundary rules for kids. | `kids-at-camp` | `decision-scenario`, `multiple-choice` |
| `cc-04` | Dogs at camp | You can explain leash and wildlife rules for pets. | `leash-rules` | `binary-call`, `decision-scenario` |
| `cc-05` | RV and generator neighbors | You can follow generator and RV etiquette. | `rv-etiquette`, `hookups` | `binary-call`, `multiple-choice` |
| `cc-06` | The rain day | You can plan a comfortable, safe rain day. | `rain-day-plan` | `decision-scenario`, `fill-the-gap` |

#### `backpacking-overnight`: The overnight backpacking step

The step from a day hike to a night out, built on the hiking course. Personalization slots: {{equipment}}, {{skill-level}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `bp-01` | From day hike to overnight | You can explain what changes on an overnight trip. | `overnight-backpacking`, `weight-vs-comfort` | `multiple-choice`, `say-this` |
| `bp-02` | Miles to camp | You can plan a camp distance with daylight. | `trip-mileage-camp` | `estimate-slider`, `decision-scenario` |
| `bp-03` | Water carry and dry camps | You can plan water carry and dry camps. | `water-carry`, `dry-camp` | `decision-scenario`, `estimate-slider` |
| `bp-04` | Designated sites and permits | You can follow a permit and designated site. | `designated-site`, `wilderness-permit-camp` | `multiple-choice`, `decision-scenario` |
| `bp-05` | Canister and camp setup on arrival | You can set camp, canister and kitchen in order. | `canister-placement`, `camp-triangle` | `sequence-order`, `hotspot-tap` |
| `bp-06` | Breaking camp | You can pack up efficiently and leave no trace. | `break-camp`, `micro-trash` | `sequence-order`, `multiple-choice` |
| `bp-07` | Overnight trip talk | You can chat about an overnight trip without bluffing. | `overnight-backpacking`, `water-carry` | `say-this`, `talk-track` |

### Enthusiast depth

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `camp-gear-debates` | Camp gear debates | `shelter-and-sleep`, `camp-kitchen-and-water` | 6: Tent, tarp or hammock; Pad wars; Stove wars; Canister, sack or hang; Rooftop tents and glamping; Cowboy camping and ultralight | `tent-vs-tarp`, `hammock-camping`, `pad-debate`, `r-value`, `stove-debate`, `canister-vs-ursack`, `rooftop-tent`, `glamping` ... |
| `camp-craft-skills` | Camp craft | `shelter-and-sleep` | 5: Taut-line and bowline; Trucker's hitch and ridgelines; Tarp pitches; Dutch oven and coals; Camp repair and knife sense | `taut-line-hitch`, `bowline`, `trucker-hitch`, `tarp-pitch`, `camp-weather-eyes`, `dutch-oven`, `fire-restrictions`, `camp-repair` ... |
| `camp-culture-and-history` | Camp culture and history | `camp-basics` | 6: How camping got here; Campfire songs and stories; Rangers, hosts and Junior Rangers; Dark skies and the Milky Way; Meteor showers; Van life and overlanding | `camp-history`, `campfire-stories`, `smores`, `ranger-program`, `junior-ranger`, `camp-host`, `dark-sky`, `milky-way-season` ... |

#### `camp-gear-debates`: Camp gear debates

What campers argue about: tents, pads, stoves, canisters and comfort. Personalization slots: {{equipment}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `gd-01` | Tent, tarp or hammock | You can present both sides of the shelter debate. | `tent-vs-tarp`, `hammock-camping` | `multiple-choice`, `say-this` |
| `gd-02` | Pad wars | You can compare foam and inflatable pads. | `pad-debate`, `r-value` | `multiple-choice`, `say-this` |
| `gd-03` | Stove wars | You can compare stove types by conditions. | `stove-debate` | `term-match`, `decision-scenario` |
| `gd-04` | Canister, sack or hang | You can explain the food storage debate and defer to local rules. | `canister-vs-ursack` | `decision-scenario`, `say-this` |
| `gd-05` | Rooftop tents and glamping | You can discuss comfort camping fairly. | `rooftop-tent`, `glamping` | `multiple-choice`, `say-this` |
| `gd-06` | Cowboy camping and ultralight | You can explain minimalist camping and its limits. | `cowboy-camping`, `ultralight-camp` | `multiple-choice`, `say-this` |

#### `camp-craft-skills`: Camp craft

Knots, tarps, dutch ovens and repairs: the hands-on skills of camp. Personalization slots: {{skill-level}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `kn-01` | Taut-line and bowline | You can describe when to use each knot. | `taut-line-hitch`, `bowline` | `sequence-order`, `multiple-choice` |
| `kn-02` | Trucker's hitch and ridgelines | You can explain how a ridgeline gets tight. | `trucker-hitch`, `tarp-pitch` | `sequence-order`, `multiple-choice` |
| `kn-03` | Tarp pitches | You can choose a tarp pitch for wind and rain. | `tarp-pitch`, `camp-weather-eyes` | `decision-scenario`, `visual-id` |
| `kn-04` | Dutch oven and coals | You can explain dutch oven cooking and its fire rules. | `dutch-oven`, `fire-restrictions` | `multiple-choice`, `decision-scenario` |
| `kn-05` | Camp repair and knife sense | You can name field repairs and safe knife habits. | `camp-repair`, `knife-safety` | `fill-the-gap`, `binary-call` |

#### `camp-culture-and-history`: Camp culture and history

Where camping came from and the rituals people love: fire, stars, rangers and van life. Personalization slots: {{region}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `ch-01` | How camping got here | You can outline camping history from early camps to modern campgrounds. | `camp-history` | `sequence-order`, `multiple-choice` |
| `ch-02` | Campfire songs and stories | You can enjoy fire-circle culture and s'mores talk. | `campfire-stories`, `smores` | `say-this`, `fill-the-gap` |
| `ch-03` | Rangers, hosts and Junior Rangers | You can talk ranger programs and Junior Ranger fondly. | `ranger-program`, `junior-ranger`, `camp-host` | `multiple-choice`, `say-this` |
| `ch-04` | Dark skies and the Milky Way | You can explain dark sky and Milky Way season. | `dark-sky`, `milky-way-season` | `multiple-choice`, `estimate-slider` |
| `ch-05` | Meteor showers | You can plan a meteor-shower night. | `meteor-shower` | `multiple-choice`, `say-this` |
| `ch-06` | Van life and overlanding | You can follow van-life and overlanding talk. | `van-life`, `dispersed-camping` | `multiple-choice`, `say-this` |

### Current-season / live layer

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `camping-season-layer` | This season at camp | `fire-and-fire-rules`, `camp-safety-and-weather` | 6: This week at camp; Is a fire okay tonight?; What is the low tonight?; What opens when; Shoulder season and hunting season; The season window | `campground-alert`, `camp-report`, `fire-danger-rating`, `fire-restrictions`, `ember-hazard`, `overnight-low`, `bag-temp-rating`, `rolling-window` ... |

#### `camping-season-layer`: This season at camp

Live fire danger, alerts, overnight lows, booking windows and seasons. Personalization slots: {{region}}. Live hook: `camping.conditions` (daily to weekly refresh).

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `lv-01` | This week at camp | You can read current campground alerts and closures. | `campground-alert`, `camp-report` | `multiple-choice`, `say-this` |
| `lv-02` | Is a fire okay tonight? | You can read fire danger and restrictions together. | `fire-danger-rating`, `fire-restrictions`, `ember-hazard` | `decision-scenario` |
| `lv-03` | What is the low tonight? | You can match bag and pad to the overnight low. | `overnight-low`, `bag-temp-rating` | `decision-scenario`, `estimate-slider` |
| `lv-04` | What opens when | You can work out when a date opens on a rolling window. | `rolling-window`, `release-time` | `estimate-slider`, `multiple-choice` |
| `lv-05` | Shoulder season and hunting season | You can plan fall and spring camping around closures and hunters. | `shoulder-season-camp`, `hunting-season-camp` | `decision-scenario`, `multiple-choice` |
| `lv-06` | The season window | You can explain why now is a good or poor time for a site. | `seasonal-camp-window`, `camp-report` | `multiple-choice`, `say-this` |

### Conversation practice

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `talk-the-campsite` | Talk the campsite | `camp-basics`, `shelter-and-sleep` | 8: Planning a camping trip together; Her campsite story; Gear talk, no faking; When she is nervous about the forecast; The campfire conversation; Decoding her reservation text; The first camping date; The good follow-up | `camp-checklist`, `recreation-gov`, `site-criteria`, `camp-zones`, `r-value`, `stove-debate`, `lightning-camp`, `overnight-low` ... |

#### `talk-the-campsite`: Talk the campsite

Conversation practice that grows with the course. Personalization slots: {{skill-level}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `tk-01` | Planning a camping trip together | You can plan a trip together without overpromising. | `camp-checklist`, `recreation-gov` | `talk-track` |
| `tk-02` | Her campsite story | You can respond to a camp story with real curiosity. | `site-criteria`, `camp-zones` | `talk-track`, `say-this` |
| `tk-03` | Gear talk, no faking | You can join gear talk honestly. | `r-value`, `stove-debate` | `talk-track`, `say-this` |
| `tk-04` | When she is nervous about the forecast | You can support a cautious call. | `lightning-camp`, `overnight-low` | `talk-track` |
| `tk-05` | The campfire conversation | You can chat by the fire and respect fire rules. | `fire-restrictions`, `smores` | `talk-track` |
| `tk-06` | Decoding her reservation text | You can decode her booking messages. | `rolling-window`, `first-come-site` | `say-this` |
| `tk-07` | The first camping date | You can plan a gentle first overnight together. | `weight-vs-comfort`, `quiet-hours` | `talk-track`, `decision-scenario` |
| `tk-08` | The good follow-up | You can ask a follow-up that shows you listened. | `dark-sky`, `water-setback` | `say-this`, `talk-track` |

### Perpetual review

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `perpetual-review` | Perpetual review | `camp-basics` | 4: Daily bite; Judgment replay; Rule refresher; Season change refresher | `attractants`, `carbon-monoxide`, `water-setback`, `fire-restrictions`, `lightning-camp`, `food-locker`, `drown-stir-feel`, `bag-temp-rating` ... |

#### `perpetual-review`: Perpetual review

Spaced review of everything you have learned, forever. Personalization slots: {{skill-level}}.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `rv-01` | Daily bite | You can recall core camp terms after a gap. | `attractants`, `carbon-monoxide`, `water-setback` | `multiple-choice`, `fill-the-gap`, `term-match` |
| `rv-02` | Judgment replay | You can re-decide a scenario with changed facts. | `fire-restrictions`, `lightning-camp` | `decision-scenario` |
| `rv-03` | Rule refresher | You can refresh food storage and fire rules. | `food-locker`, `drown-stir-feel` | `multiple-choice`, `sequence-order` |
| `rv-04` | Season change refresher | You can adapt gear and plans to the new season. | `bag-temp-rating`, `overnight-low`, `shoulder-season-camp` | `fill-the-gap`, `multiple-choice` |

### Layer summary
| Layer | Purpose | Units in this course |
|---|---|---|
| Foundations | Terms, rules, how it works | `camp-basics`, `shelter-and-sleep`, `campsite-selection`, `camp-kitchen-and-water` (31 lessons) |
| Intermediate | Rules, hazards, context | `food-storage-and-wildlife`, `fire-and-fire-rules`, `camp-safety-and-weather`, `leave-no-trace-at-camp`, `public-lands-and-reservations` (41 lessons) |
| Branches / personalization | Camping style and region | `car-camping-life`, `backpacking-overnight` (13 lessons, gated by `branchId`); tokens `{{region}}` etc. |
| Enthusiast depth | What campers debate; craft; culture | `camp-gear-debates`, `camp-craft-skills`, `camp-culture-and-history` (17 lessons) |
| Current-season / live | Ongoing, refreshed from live data | `camping-season-layer` (6 templates; new items weekly, seasonal editorial refresh) |
| Conversation practice | Talk tracks, say-this, "what is she talking about?" | `talk-the-campsite` (8 lessons) + Talk tab (24+ tracks) |
| Perpetual review | Spaced review of mastered concepts | `perpetual-review` (4 lessons) + policy below |

- **Review policy (curriculum `reviewPolicy`):** `leitner-boxes-v1`, `intervalsDays` `[1, 3, 7, 14, 30, 60, 120]`, `maxItemsPerSession` 12, `masteryThreshold` 0.8, `decayAfterDays` 45 (camping is seasonal and rule-heavy: a winter learner sees fire, bear and heat concepts again before the season turns; fire rules and booking windows are re-verified yearly). `reviewActivityTypes`: `multiple-choice`, `fill-the-gap`, `term-match`, `decision-scenario`, `hotspot-tap`, `estimate-slider`, `say-this`.
- **Concept count target (Playbook):** 179 at launch; growth to ~230 with the live layer and a future winter-camping branch.
- **Personalization slots:** see section 8 and per-unit tables.
- **Release plan:**
  - **Launch (v1.0):** `camp-basics`, `shelter-and-sleep`, `campsite-selection`, `camp-kitchen-and-water`, `food-storage-and-wildlife`, `fire-and-fire-rules`, `camp-safety-and-weather`, `leave-no-trace-at-camp`, `public-lands-and-reservations`, `talk-the-campsite`, `perpetual-review`, and a U.S.-only `camping-season-layer` (NWS, NPS alerts, AirNow, NIFC, computed booking windows). **Blocked until the safety review passes (section 13).**
  - **Update 1 (about 8 weeks):** `car-camping-life`, `backpacking-overnight`, `camp-gear-debates`.
  - **Update 2:** `camp-craft-skills`, `camp-culture-and-history`, dark-sky and meteor-shower editorial calendar, first-come and permit-window authored data.
  - **Continuing:** weekly seasonal items, quarterly editorial calendar, more talk tracks, non-U.S. regions, a winter-camping branch (awareness only) and a paddle-in branch.

## 12. Interaction plan
Native rows link to `docs/native-exercises/CATALOG.md`. Counts are approximate authored items at launch (before the live layer). **There are no Tier A rows** (see section 5).

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Judgment scenarios: CO, fire, storms, floods, cold, wildlife, water, booking, evacuation, site choice | `carbon-monoxide`, `fire-restrictions`, `lightning-camp`, `hypothermia-camp`, `bear-canister`, `water-treatment-camp`, `release-time`, ... | `decision-scenario` | Spec section 17. The decision depends on facts (time, weather, rules, distance), not a scene; graded best/acceptable/poor teaches trade-offs, and every scenario has `safetyNote`. A sim would add pressure without understanding. | B | ~150 |
| Camp and rule facts, comparisons | `r-value`, `bag-temp-rating`, `attractants`, `stay-limit`, ... | `multiple-choice` | Recall and understanding of rules and terms; default review card. | B | ~200 |
| Interpret her camp talk | `rolling-window`, `fire-restrictions`, `bear-canister`, ... | `say-this` | Decoding what she said is the north-star skill (spec section 13). | B | ~80 |
| Conversation practice (Talk tab, unit ends) | `camp-checklist`, `fire-restrictions`, `lightning-camp`, ... | `talk-track` | Forgiving chat with a Smooth meter; honest curiosity beats bluffing. | B | ~24 + lesson uses |
| Diagram taps: site anatomy, hazards, camp triangle, tent parts, listing | `campsite-anatomy`, `hazard-tree`, `camp-triangle`, `rainfly`, `site-attributes` | `hotspot-tap` | Spatial knowledge on a **static** diagram (top-down site plan, side cross-section). The spatial reasoning is real but static, so Unity adds nothing. Procedural diagrams, no motion. | B | ~30 |
| Situational rules | `carbon-monoxide`, `lightning-camp`, `water-setback`, `fire-accelerant`, `leash-rules` | `binary-call` | Clear yes/no rules where the wrong answer is a hazard (cook in tent? gas on a fire?). | B | ~50 |
| Processes and order | `camp-trip-flow`, `drown-stir-feel`, `cathole`, `stake-out`, `taut-line-hitch` | `sequence-order` | Process where order matters: site setup, putting a fire out, cathole, pitching, knots, breaking camp. Partial credit. | B | ~50 |
| Vocabulary sets | `campsite-anatomy`, `canister-stove`, `fire-ring`, `public-land-agencies` | `term-match` | Grouped vocabulary (stoves, fires, agencies, sleep gear). | B | ~36 |
| Rule sentences | `stove-safety`, `cathole`, `danger-zone`, `release-time` | `fill-the-gap` | Rules in context. | B | ~33 |
| Magnitude intuition | `r-value`, `wildlife-distance`, `water-treatment-camp`, `water-setback`, `danger-zone` | `estimate-slider` | Numbers campers must intuit (R-value, yards, minutes, steps, hours). Tolerance bands. | B | ~33 |
| Sight recognition | `freestanding`, `hammock-camping`, `canister-stove`, `small-thieves` | `visual-id` | Recognize shelters, stoves and camp animals by sight; original illustrations. | B | ~24 |
| Live layer items (weekly, generated) | `fire-danger-rating`, `overnight-low`, `campground-alert`, `rolling-window` | `decision-scenario`, `say-this`, `multiple-choice` | Templates filled from normalized data; native only; safety linter. | B | new weekly |
| Not used: `timing-tap`, `listening-id`, `unity-sim` | n/a | n/a | No 1D timing concept; audio (owl, coyote, thunder) needs licensed or original recordings (deferred); no Tier A per section 5. | n/a | 0 |

## 13. Licensing & safety
**Media rights**

| Area | Handling |
|---|---|
| Imagery | Original illustrations and procedural diagrams only at launch (`original-swoond`). NPS/USFS/USGS photos only after per-image credit review. No Recreation.gov, AllTrails, Hipcamp, The Dyrt, KOA or gear-brand imagery; no scraped photos. |
| Logos and trademarks | Names (Recreation.gov, KOA, REI, Jetboil, BearVault, Ursack, Smokey Bear) as text only. "Leave No Trace" credited descriptively to the Leave No Trace Center for Outdoor Ethics. Smokey Bear is a federally protected character: text mention only; no artwork or slogan reproduction. "Drown, stir, feel" is described in our own words. |
| Audio | None at launch (`listening-id` unused). |
| Video | None. |
| Lyrics / text | No campfire song lyrics; songs named as facts only. Agency text paraphrased; publisher and review text never copied. |
| Data terms | See `live-data.md`: NWS UA header, NPS key/limits, RIDB terms, AirNow attribution, NIFC, no Recreation.gov scraping. |
| Personal likeness | None. |

**Safety constraints (also in the manifest).** Camping is safety-critical (D-017 / P-18): fire, carbon monoxide in tents, wildlife, water treatment, cold and heat. Guidance is conservative and mainstream (NPS, USFS, Leave No Trace, CDC, NWS, USDA food safety); where agencies differ or rules vary by place, Swoon'd teaches the principle and defers to the posted local rule.
1. Swoon'd teaches **appreciation and understanding, not safety training**. It is not a substitute for wilderness first aid, fire-safety, food-safety or local ranger guidance.
2. **A qualified safety review is a release gate:** all safety-critical lessons and scenarios (section 10 list) are reviewed by a qualified reviewer (e.g. Wilderness First Responder plus a Leave No Trace trainer, ideally with a current or former NPS/USFS ranger for fire and food-storage rules) before release. No lesson ships to learners until signed off. Review results are recorded in `SAFETY_REVIEW.md` (to be created; hiking's does not yet exist).
3. Every `decision-scenario` carries a `safetyNote`, never claims a site, fire, water source, food or condition is "safe", and the conservative option is always best when risk rises.
4. **Fire:** never teach fire-building technique beyond containment, distance, rules and putting it out; no accelerants, ever; "a fire being legal is not the same as being wise." Restriction stages and bans vary: link to the agency notice, never assert a stage.
5. **Carbon monoxide:** absolute rule: no stove, lantern, heater, grill or charcoal (including warm coals) in a tent, vehicle, RV or enclosed shelter, even with vents open (CDC). Vestibule cooking is taught as a hazard, not a technique. The course states a CO alarm is standard in RVs and enclosed campers.
6. **Wildlife:** principles only (distance, storage, never feed, follow local guidance); no encounter "tactics" beyond widely published agency advice; bear spray is awareness ("know local guidance, carry accessible") and never a substitute for storage or distance.
7. **Water:** CDC methods stated with source and date (boil 1 minute, 3 above 6,500 ft; filters and chemicals match the threat; chemical contact times per the product label); no claim that any treated water is guaranteed safe.
8. **Food safety:** USDA two-hour rule (one hour above 90 F) and 40 F cold-holding; "when in doubt, throw it out."
9. **Cold and heat:** recognition and "warm, dry, insulated, get help" only; hypothermia and heat illness are not treated beyond widely taught basics; never leave children or pets in a vehicle.
10. **No gamified pressure on hazards** (no timers, streaks, speed bonuses, "survival" scoring), and no nights-camped, sites-visited or campfire badges.
11. Live conditions are informational: show source and age, link to the land manager, say "confirm with the agency." Generated live scenarios pass a **safety linter** (no "safe" claims, no rule assertions without a linked source, required `safetyNote`).
12. Emergency numbers vary by region; link to the local number and satellite-messenger guidance rather than hard-coding.
13. Discreet mode: notifications never include the Person's name.

## 14. Content assets
| Asset | Type | Source | License id |
|---|---|---|---|
| Diagrams: campsite plan, site cross-section (`site-cross-section`), camp triangle, tent anatomy, stove anatomy, fire-ring layout (`hotspot-tap`, `binary-call`) | Procedural / vector drawn in-app | In-house | `original-swoond` |
| Shelter, stove and camp-animal illustrations (`visual-id`), e.g. `camping/shelter-freestanding.svg` | Original illustration | In-house or commissioned | `original-swoond` |
| Optional photography | NPS/USFS/USGS public domain only after review | Agencies | `original-swoond` is not used for these; use a per-source id (`nps-public-domain`) once L-12 registry exists |
| Audio | None | n/a | n/a |
| Fonts | Instrument Serif, Geist | OFL | `ofl` |

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** The site, the sleep system, the kitchen and water, food and fire rules, and what makes camp hazardous (sections 2-3).
- [x] 2. **What do enthusiasts care about?** The booking story, the night, fire rules, food storage, gear trade-offs, dark skies and manners (section 4).
- [x] 3. **What current information matters?** Overnight lows, fire danger and restrictions, alerts and closures, smoke, booking windows, seasons (section 6, `live-data.md`).
- [x] 4. **What should be interactive?** Judgment scenarios, diagram taps, ordered processes, estimates, conversation (sections 5, 12).
- [x] 5. **What should NOT be gamified?** Fire, CO, wildlife, water, cold, heat, storms, floods, evacuation; no nights-camped leaderboards (sections 5, 13).
- [x] 6. **How should it personalize?** Region, destination, equipment, style, skill level, and two branches (section 8).
- [x] 7. **What does conversational competence look like?** Following her recap, asking about the low, the site, the rules, admitting what you do not know (section 9).
- [x] 8. **What data providers are needed?** NWS, NPS, NIFC/InciWeb, AirNow, USGS, NRCS, RIDB metadata, agency pages; no Recreation.gov availability scraping (section 6, `live-data.md`).
- [x] 9. **What licensing constraints apply?** Original art, agency data terms, trademarks as text, no publisher text, Smokey Bear text only (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery, say-this interpretation, talk-track Smooth score, two-session safety-decision mastery, review retention (section 10).

Additional gates: [x] manifest validates (run `tools/validate`); [ ] curriculum JSON authored and validates (next step); [x] every Unity sim has an approved spec (vacuously: zero sims); [x] every image/audio asset planned has a license id; [ ] voice review; [x] no copied publisher text; [ ] **qualified safety review (release gate)**.

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Who performs the qualified safety review (WFR + LNT trainer, ideally with ranger input on fire and food storage), and when? | Product | **Yes, for release** |
| 2 | Confirm zero Unity. Revisit `camping.site.read.v1` (Heightfield-based campsite reading) only if playtests show static `hotspot-tap` cross-sections fail. | Product | No |
| 3 | Confirm 17 units vs the 8-14 guidance (see `NOTES_FOR_ORCHESTRATOR.md` fold options). | Product / orchestrator | No |
| 4 | Fire restriction data: no unified machine-readable national feed is assumed. Link-only at launch, or invest in a curated per-agency feed for fire-prone regions? | Product / backend | No |
| 5 | Recreation.gov: availability is not a public API. Deep-link only, or pursue a partnership with the operator? | Product | No |
| 6 | Hipcamp, The Dyrt, KOA and other private-camp platforms: deep-link only (same rule as AllTrails). | Product | No |
| 7 | U.S. scope: launch is U.S. agencies and NWS only; Canada (Parks Canada reservations) and others later. | Product | No |
| 8 | Vestibule cooking: the course teaches "cook outside" and treats vestibule cooking as a hazard. Confirm this conservative stance with the safety reviewer, since some experienced backpackers vestibule-cook in storms. | Safety reviewer | Yes (review) |
| 9 | Bear spray: how much to teach (awareness only) and whether to include species-specific encounter guidance (black vs grizzly) or only "follow local guidance". Default: principles only. | Safety reviewer | Yes (review) |
| 10 | Illustration sourcing (in-house vs commissioned) for shelters, stoves and camp animals. | Product | No |
| 11 | `SAFETY_REVIEW.md` format: hiking has none; agree a shared template (reviewer, date, lessons covered, changes required, sign-off). | Orchestrator | No |
