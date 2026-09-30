# Hiking curriculum: safety and accuracy review

Scope: `curriculum/units/01` to `06`. Standard applied: conservative mainstream guidance (NPS, NOLS/WFR, Wilderness Medical Society, NWS lightning, heat and flood guidance, EPA AQI, Leave No Trace). Swoon'd teaches appreciation, not survival training, so where sources differ the more cautious choice was taught and "follow official and park guidance" was added.

Validator: `cd tools/validate && node validate.mjs --course hiking --partial` reports 0 schema failures and 0 lint errors or warnings on units 01 to 06. Without `--partial`, the only failure is `unitOrder` entries that have no unit file yet.

Tooling note: the schema check for unit payloads is skipped when `course.json` lists unwritten units and `--partial` is not used. Always run with `--partial` while units are missing.

## 03-water-food-and-body.json (highest severity)

| Activity | Problem | Fix |
|---|---|---|
| wf-03-ds-water-trap | Dangerous. Dizzy, nauseous, headachy hiker at 8,000 ft after 2 L in 3 h was told more water "worsens dilution", salty snacks and keep going was "best", and descent was discouraged. 2 L in 3 h is not excessive; the symptoms point to heat illness, dehydration and/or altitude sickness. | Rewritten. Best is stop, shade, sip water plus salty food, and descend if headache and nausea persist or worsen. Descending is acceptable. Pushing on is poor. "Stop drinking to avoid dilution" is poor. Emergency signs (confusion, stumbling, repeated vomiting) added. |
| wf-03-mc-hyponatremia | Framed ordinary hydration as a sodium-dilution risk. | Now: rare, needs far more plain water than thirst asks for, over many hours, with little food or salt. States never to withhold water from a symptomatic hiker. |
| wf-03-mc-safest-drink | "Chug plain water" framing. | Reframed as drink to thirst and eat salty snacks, versus forcing plain water with no food. |
| wf-01-mc-when-drink, wf-01-mc-heat-hydration | "Before thirst hits", "50 percent more". Overstated and unsourced. | Drink regularly and when thirsty; carry noticeably more in heat. |
| wf-02-tm-treatment | Squeeze filter "pumps"; chemical treatment gave no wait time; no boil or UV caveats. | Corrected. Notes filter virus coverage, chemical wait times, and UV needing clear water. |
| wf-02-mc-giardia, wf-02-mc-filters | Fabricated "hospital bills" line; filter claim too absolute. | Removed. Added "check your filter's specs" and park guidance. |
| wf-05-mc-bonk-signs, wf-05-ds-bonking | Confusion listed as a hunger sign with no red flag; timeline inconsistent (hour 1 vs hour 2); "eating fixes it in 15 min" overpromise. | If dizziness or confusion does not clear, it may be heat or altitude illness; turn back. Timeline fixed. |
| wf-06-mc-heatstroke | Wrong. Taught heatstroke as hot, dry skin with no sweating. Exertional heatstroke often still sweats. Also said "descend" rather than cool and call. | Key sign is altered mental state (confusion, stumbling, collapse). Skin may be dry or sweaty. Call emergency services and cool now. Duplicate sayThisLine replaced. |
| wf-06-ds-heat-illness | Walking back a mile to the creek was "acceptable" for a symptomatic hiker; no cooling step. | Best is shade (make it), cool her, sip fluids, watch for confusion. Creek only once steady. safetyNote added. |
| wf-07-mc-altitude, wf-07-ds-altitude | "Tomorrow you will feel much better" overpromise; no red flags. | Do not ascend with symptoms; descend if worse; confusion, stumbling or breathlessness at rest is an emergency. |
| lint (new type-monoculture rule) | 23 of 32 activities were multiple-choice (error above 50%). | Converted 11 to binary-call, fill-the-gap and term-match with matching concepts; every lesson still has 4 or more activities. Ids renamed to match type (nothing else referenced them). |

## 01-trail-basics.json

| Activity | Problem | Fix |
|---|---|---|
| tb-03-ds-01, tb-05-ds-01, tb-06-ds-01, tb-07-ds-01 | Not in the decision-scenario schema (context, correctOptionId). | Rebuilt to schema with graded verdicts and safetyNotes. |
| tb-05-ds-01 (pack mule) | Advice lacked stock etiquette. | Calm voice, follow handlers, do not hide, never ask stock to reverse. |
| tb-07-ds-01, tb-07-mc-01 | Register full: "text the ranger" implied as an option; no-signal case missing. | A personal contact who expects you back is the trigger for a search. Register is a backup. In-person plan if no signal. |
| tb-06-tm-01, tb-06-fg-01 | Leave No Trace principle names wrong; fill-the-gap had 4 gaps (limit 3) and mixed "soil" and "camp". | Names now match the 7 principles: plan ahead and prepare; travel and camp on durable surfaces; dispose of waste properly; leave what you find; minimize campfire impacts; respect wildlife; be considerate of other visitors. Explanation lists all seven. |
| tb-04-mc-01, tb-04-hs-01 | "Cairns are the official route"; official cairns look "distinct". Cairns can be unofficial or misleading. | Follow a line of cairns and confirm against the map. |
| tb-04-vi-01, tb-04-fg-01 | "Almost always" for double blazes; schema error for `cues` inside `explanation`. | "In many blaze systems"; cues moved to payload. |
| tb-02-bc-01 | Prompt over 120 characters; unhelpful "finish the loop even if tired". | Shortened. Allows backtracking or a signed cutoff. |
| tb-05-tm-01 | Right of way stated as absolute. | Added "posted signs and local rules come first". |

## 02-gear-and-clothing.json

| Activity | Problem | Fix |
|---|---|---|
| gc-01-bc-06 | Discouraged calling for help: "calling in a rescue... is expensive and embarrassing". | Removed. Help can be slow to arrive even on popular trails. |
| gc-04-ds-02 | Boot slide on descents diagnosed as always "too big; go half a size down". A smaller boot can jam toes. | Best is heel-lock lacing plus retest and refit if it persists. Smaller size and other brand are acceptable. |
| gc-07-fg-01, gc-07-ds-03 | UV "doubles" at altitude and clouds do not stop UV. Overstated. | "Raise UV exposure a lot"; clouds do not stop most UV; hat and sunglasses added. |
| gc-03-ds-03, gc-02-fg-04, gc-03-fg-05 | "Loses all insulation/warmth" when wet. | "Most". Rewarming and shivering follow-up added. |
| gc-08-ds-06 | "Infection-free" guarantee; no bleeding or tetanus note. | Watch for infection signs; bleeding that will not stop is an emergency; check tetanus shots. |
| gc-05-ds-03 | No infection signs. | Added when to see a clinician. |
| gc-01-fg-04, gc-02-bc-06, gc-08-tm-02 | Vague template; "wool shell"; fire starter without "where allowed". | Reworded. |

## 04-reading-a-trail.json

| Activity | Problem | Fix |
|---|---|---|
| rt-03-est-01 | Answer key wrong. 9 mi + 1,200 ft is 3.6 h by Naismith, key said 4.5. | Key set to 3.5. |
| rt-01-mc-01 | Answer key wrong under Naismith: 10 flat miles (3.3 h) beats 5 mi + 3,000 ft (3.2 h). | Now 6 flat miles vs 4 miles with 3,000 ft. |
| rt-01-est-01, rt-01-est-02, rt-01-mc-02 | Arithmetic and explanations wrong (mixed Naismith with the mile-per-500-ft rule; 500 ft in 0.5 mi is 19%, not 18%). | Fixed. |
| rt-03-mc-02 | Return time and "double the moving time" contradicted the 30 to 50% rule. | 11:30 AM to 12:30 PM. |
| rt-04-est-02 | Claimed 70 to 80% of sea-level pace at 8,000 ft. Too pessimistic. | About 85 to 95%. Symptoms are a warning sign, not just slowness. |
| rt-04-est-03 | Pack slowdown 15% stated with false precision. | About 5 to 15%. |
| rt-05-tm-01, rt-05-mc-01, rt-05-mc-03 | Class 2 "hands in pockets", "not dangerous"; helmet listed as a wrong answer for class 3. | Class 2 hands used for balance; falls still possible; class 3 needs skills or an experienced partner. |
| rt-06-mc-01, rt-06-mc-03 | Phone-only navigation listed as acceptable; water plan forgot the dry first 4 miles and untreated creek water. | Corrected. |

## 05-navigation.json

| Activity | Problem | Fix |
|---|---|---|
| nv-04-mc-01, nv-04-mc-02, nv-04-tm-01, nv-04-ht-01, nv-05-ht-02 | Wrong. Ridge contours shown as V pointing uphill and drainage as V pointing downhill. It is the reverse: contours V uphill (upstream) in drainages and point downhill on ridges. | Answer keys, prompts, alt text and explanations corrected. |
| nv-06-mc-03 (declination) | Wrong direction. Told to add west declination going compass to map. | Map to compass: subtract east, add west. Compass to map is the reverse. |
| nv-06-mc-02, nv-06-fg-01 | Grid north confused with true north; fill-the-gap referenced undefined gaps. | Fixed. |
| nv-10-mc-02 | Dangerous. Correct answer was "follow a creek downhill; it will lead out" and "stay put" was wrong. Drainages lead to cliffs, waterfalls and brush; SAR guidance is to stay put if you told someone and cannot retrace confidently. | Best is stay put, stay warm and visible, call 911 or text, whistle in threes. Retrace only if it is light and you are sure. Creek-following is now a wrong option. |
| nv-04-mc-02, nv-05-mc-02, nv-08-ds-01 | "Follow the drainage down and you'll hit the creek" taught as a navigation tactic. | Removed. Handrails must be confirmed on the map. |
| nv-05-ds-01 | "Flip a coin" between a steep and a gentle descent was acceptable. | Retrace or follow the marked trail is best. |
| nv-01-mc-02 | Quad sizes wrong (4 mi and 16 mi). | About 6 x 8 mi and about 30 x 40 mi. |
| nv-02-mc-01, nv-02-fg-01, nv-02-ds-01 | "Tight lines = small vertical distance"; wrong drainage statement; gaps missing. | Fixed. |
| nv-03-mc-01 | "Up carefully" past a cliff band. | Go around; never climb it. |
| nv-01-ds-01 through nv-10-ds-01 | Placeholder consequences ("This option affects your hiking safety"). Broken prompts. | Rewritten with real content. |
| nv-02-ht-01, nv-03-ht-01, nv-04-ht-01, nv-05-ht-01, nv-05-ht-02 | All hotspots overlapped at the same point, so the answer key was meaningless. | Distinct positions. Diagram assets must match. |
| nv-07-so-01, nv-07-mc-03 | Truncated step text; muddled explanation. | Fixed. |
| nv-09-ds-01, nv-10-ds-01 | Stopping GPS recording as "best"; STOP "never keep hiking". | Airplane mode and paper map; STOP with retrace or stay-put options. |
| lint | Multiple-choice at 49%. | Converted 6 to binary-call, fill-the-gap, term-match and estimate-slider. |

## 06-weather-and-conditions.json

The author was rewriting this file while reviewed (schema was fixed at 09:12). Review applied after that.

| Activity | Problem | Fix |
|---|---|---|
| wx-01-mc-why-temp | Wrong mechanism ("less ground to radiate"). | Air expands and cools as pressure falls. |
| wx-02-mc-forecast-changes | Claimed forecasts are only good for 3 to 6 hours. | Best a day or two out; recheck the morning you go. |
| wx-02-ftg-forecast-parts | Two right answers (wind direction and cloud cover). | Distractors made wrong. |
| wx-03-ds-alpine-start, wx-03-seq-alpine-prep | Summit times wrong (5:30 start said summit at 1 PM; it is about 9:30). Sequence put wake before packing the night before. | Times and order fixed. |
| wx-04-ds-thunder-starts, wx-04-tm-lightning-steps | "15 miles" for thunder; truncated term. | About 10 miles; NWS wording. |
| wx-04-bc-forest-shelter | "Safe to wait it out in forest: yes". No outdoor place is safe. | Reframed as the lesser risk versus a ridge; get to a building or vehicle if possible. |
| wx-05-es-wind-chill, wx-05-bc-descend | Wind chill at 45°F and 25 mph is about 36°F, not 33°F. 52°F at 35 mph is not near freezing. | Values corrected (40°F, 35 mph is about 28°F). |
| wx-05-ftg-hypo-temp | "32" and "freezing" both accepted. | Single unambiguous gap. |
| wx-06-mc-heat-rating | "High" heat risk. NWS HeatRisk uses 0 to 4 (green, yellow, orange, red, magenta). | Major (red). |
| wx-06-bc-illness-type | Taught hot, dry skin as the sign. | Reframed: stop, cool and go down. |
| wx-08-mc-aqi | AQI 150 marked "unhealthy" but 101 to 150 is Unhealthy for Sensitive Groups. | AQI 175 (Unhealthy, 151 to 200). |
| wx-08-st-smoke | AQI 200 called hazardous (hazardous is 301 and up). | Unhealthy. |
| wx-08-tm-alert-types, wx-08-ds-hike-smoke | Invented "smoke advisory"; respirator claim about masks. | Fire weather watch; cloth and surgical masks do not filter smoke well. |
| wx-09-es-snowpack-delay | Wrong direction. Low snowpack said to delay clearing. | Rebuilt as a binary call on 140%. |
| wx-09-ds-snowpack | "Ice axe and microspikes" without training caveat. | Skills first; ask the land manager. |
| Several | Truncated followUps ending "..."; "This is the safetyNote." text in expertNote. | Completed; moved to `safetyNote` field. |

## Checklist for future hiking unit authors

1. Sources: NPS, NOLS/WFR, WMS, NWS, EPA AirNow, Leave No Trace. If unsure, leave it out.
2. Every safety-critical scenario has a `safetyNote` and says to follow official and park guidance. Emergencies are never timed or scored.
3. Best answer is the conservative choice. "Descend" or "get help" is best when symptoms worsen or persist. Never make "keep going" the best answer for a symptomatic person.
4. Never tell learners to withhold water from someone who may be dehydrated. Hyponatremia: rare, needs large volumes of plain water over many hours with little salt.
5. Heat: heat exhaustion versus heatstroke is decided by confusion or collapse, not by skin dryness. Heatstroke: call for help and cool immediately.
6. Altitude: do not ascend with symptoms; worsening or confusion, stumbling or breathlessness at rest means descend; do not give drug doses.
7. Lightning: no place outdoors is safe; leave exposed high ground early; 30-minute wait; 50 ft spacing. Thunder means roughly 10 miles or closer.
8. Flash floods: rain far upstream counts; never enter a slot canyon if storms are forecast in the watershed; climb to high ground; radar is not a green light.
9. Lost: STOP; stay put if you told someone and cannot retrace confidently; never teach "follow a creek down".
10. Navigation: paper map and compass are the backup; phones fail. Declination: east is least, west is best (map to compass). Ridge contours point downhill; drainage contours point uphill.
11. Naismith: 1 hour per 3 miles plus 1 hour per 2,000 ft. Rework any sum you write and check the key. Grade uses feet over feet (1 mile is 5,280 ft).
12. Right of way: state as custom, add "signs and local rules come first"; stock gets priority and handlers' directions win.
13. Leave No Trace: use the 7 principle names exactly.
14. Ten Essentials as systems: navigation, sun protection, insulation, illumination, first-aid supplies, fire, repair kit and tools, nutrition, hydration, emergency shelter. Never discourage calling for help.
15. Avoid absolutes ("all", "always", "never") unless official guidance is absolute. Avoid invented statistics.
16. Each hotspot has a distinct position; multiple correct answers must be marked; no placeholder text.
17. Run `node validate.mjs --course hiking --partial`. Keep any one activity type at or below 40% of a unit (over 50% is a lint error).

## Units 07-16 (final pass)

Scope: `curriculum/units/07` to `16`, every activity, checked against NPS, NOLS/WFR, WMS, NWS, avalanche.org and Leave No Trace, and cross-read against units 01 to 06 for consistency (hydration and heat, altitude, lightning, STOP/stay-put, flash floods, contour direction, HeatRisk levels). No dangerous answer keys were found; the units were already conservative. Fixes are small accuracy and consistency changes.

| Unit | Activity | Problem | Fix |
|---|---|---|---|
| 07 | jd-02-bc-headlamp | Prompt said the turn time was "in ten minutes" but asked "Turn now?", muddying the rule. | Prompt now states the turn time has arrived. |
| 08 | np-06-st-park-fan | Called the rock-stack request a park "rule" under Leave No Trace. | Now "Leave No Trace guidance". Fee facts (annual pass $80, nonresident $100 surcharge at 11 parks, $250 pass) already carry "as of 2026-09-30" and "check the official page". |
| 09 | dc-05-tt-desert-chat | "Orange means a lot of people will feel it" and "moderate to high" overstated NWS orange. | Orange is moderate risk, worse without cooling and water. |
| 10 | ah-01-es-cooler-up-high | Answer key 60 F did not match the explanation (10 to 15 F drop from 70 F is 55 to 60 F). | Key 58 F; say-this line updated. |
| 11 | gn-05-ds-dead-phone | Expert note allowed "paper as backup, or the reverse". Paper map and compass are the backup. | Reworded; both always carried. |
| 11 | gn-07-ds-slower-friend | Best answer did not say to descend if the clouds kept building. | Best option now adds heading down early. |
| 13 | tn-04-ds-crust-detour | Prompt mentioned a bike that is not in the scenario. | Prompt matches the scenario. |
| 13 | tn-08-seq-bear-spray | Spray step was operational; no note that nothing is guaranteed. | Reworded to "follow the can's label", distance and retreat come first. |
| 14 | lv-02-ds-hot-afternoon | "High" heat risk is not an NWS HeatRisk level (same error fixed in unit 06). | "Major (red)". |
| 14 | lv-02-tm-heat-risk-levels | Orange wording said "many people". | "Especially for people without effective cooling and hydration". |
| 16 | rv-01-fg-lnt-durable | Template grammar broke the waste gap. | Template reads correctly. |
| 16 | rv-02-ds-late-summit | "Nearer viewpoint" could be on the same exposed ridge. | "Lower, sheltered viewpoint on the way down". |

Units 12 and 15: no changes needed.

### Unit 13 lesson tn-08 (Wild neighbors) versus the CDS

The CDS unit table lists seven lessons (tn-01 to tn-07) and safety constraint 6 limits wildlife to "distance, noise and food storage principles only"; constraint 5 limits medical content. tn-08 (6 activities) goes further: bear spray readiness, mountain lion response and snake bite do/don't. Decision: **keep**. All content matches NPS guidance, every scenario has a `safetyNote` deferring to park rules, nothing is scored under time pressure, and the snake note only says what not to do plus "call emergency services". It adds real value because the crowd-facing talk (bear spray, lions) comes up constantly. Follow-up for the orchestrator: update the CDS unit 13 row to eight lessons and word constraint 6 to allow "agency-aligned deterrent and encounter basics".

### Consistency confirmed across units 01 to 16

Altitude: do not ascend with symptoms, descend if worse, confusion or breathlessness at rest is an emergency. Lightning: no safe place outdoors, leave ridges early, 30 minutes after last thunder, spread about 50 ft, thunder roughly 10 miles or closer. Heat: confusion or collapse means call and cool. Flash floods: rain upstream counts, go up not along. Lost or hurt: stay put with a shared plan, whistle in threes, never follow a creek down. Avalanche and snow: awareness only, "take a course". Bears: 100 yards, never run, never feed, bear spray only with practice. Fees and permits: dated and "check the official page".
