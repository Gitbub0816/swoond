# Course Design Specification: Climbing (`climbing`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Climbing is **safety-critical**: Swoon'd teaches appreciation and conversation, never technique. Every technique-adjacent lesson says to learn it from a certified instructor or gym. Checklist for authors: `SAFETY_REVIEW_CHECKLIST.md`.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 3 |
| Author / date | Climbing course design agent (Claude), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion docs | `exercises.md`, `live-data.md`, `SAFETY_REVIEW_CHECKLIST.md`, `sims/climbing.bouldering.problem-read.v1.md`, `NOTES_FOR_ORCHESTRATOR.md` |

---

## 1. Identity
- **Course ID:** `climbing` (immutable)
- **Display name:** Climbing
- **Category / family:** Outdoors & Adventure; category path `Outdoors > Climbing`
- **Simulation prefix:** `climbing` (one planned sim: `climbing.bouldering.problem-read.v1`)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns climbing, are they meaningfully conversationally competent about it?" | Verdict | Consequence for structure |
|---|---|---|---|
| Hiking (`hiking`) | Barely. Approaches and exposure vocabulary overlap; ropes, protection, grades and belaying are a separate, safety-critical language. | Adjacent, independent | Hiking owns the class scale and scrambling words; climbing starts where ropes or pads begin. Cross-link `leave-no-trace`. |
| Camping (`camping`) | No, except shared Leave No Trace and weather habits. | Adjacent, independent | Only mention multi-day big walls as culture. |
| Mountaineering / alpinism | Partly (vocabulary such as big wall, Chamonix). Life-safety skills differ and need real training. | Out of scope beyond culture | `chamonix` and big-wall culture only as talk; no alpine technique. |
| Fitness / strength training | Partly (hangboard, campus talk). | Independent | Training culture appears as a debate unit, never as a programme. |
| Olympics / competition sport generally | The comp world is its own spectator sport but sits on the same vocabulary. | Shares foundation | Competition unit inside this course; no separate course. |

- **Branches** (chosen by the learner or inferred from the Person; each adds one unit with a `branchId`):

| id | Name | What changes (rules, data, culture) |
|---|---|---|
| `bouldering` | Bouldering | Unroped, padded, short problems; V-scale and Font; sit starts, circuits, comp-style sets; Fontainebleau, Bishop, Rocklands. Default branch for a gym-going Person. |
| `sport-climbing` | Sport Climbing | Bolted roped routes; French scale and 5.x; redpoint culture; Kalymnos, the Red, Smith Rock. |
| `trad-and-big-wall` | Trad and Big Wall | Removable protection, cracks, ground-up ethic, British E-grades, El Capitan, Yosemite, Indian Creek. |

Competition climbing is an enthusiast unit, not a branch: it cuts across all three. Not built at launch: alpine and mountaineering, ice and mixed climbing, deep-water soloing, non-U.S. regional branches.

## 2. Beginner model
- **What a beginner knows:** climbing exists; gyms have coloured holds; a movie with a man on a cliff ("Free Solo"); that it looks scary and strong. Often the Olympics.
- **What confuses them:** V4 vs 5.10a vs 6A; "beta", "crux", "send", "flash" vs "onsight"; why some people use ropes and some pads; "sport" vs "trad" (sport is not a stadium sport); "top rope" vs "lead"; what a "project" is; why chalk marks the wall.
- **Misconceptions:** it is all arm strength (feet and thinking matter more); grades are precise (they are opinions); climbers are reckless (most are fanatical about safety); gym skill equals outdoor readiness; "anyone can belay, it is just holding a rope"; free soloing is what climbers normally do; bouldering is "practice for real climbing".
- **Concepts that unlock the rest:** the discipline map, the four grade scales, send vocabulary, holds and wall features, and the culture of checking and instruction. These become the five foundation units.

## 3. Foundational knowledge
Grouped into the five foundation modules (see section 11):
- **What is climbing:** the discipline family tree; gym vs rock; gear named by purpose; the "learn from a pro" rule.
- **Reading the wall:** hold types (jug, crimp, sloper, pinch, pocket, undercling, sidepull, gaston), wall angles (slab to roof), features (volume, arete, dihedral, crack), how a problem is marked.
- **Grades:** V-scale (from Hueco Tanks), YDS 5.x, Font (Fontainebleau), French sport; approximate conversions; sandbag and soft; gym grades vs outdoor.
- **Send talk:** beta, crux, send, flash, onsight, redpoint, pinkpoint, project, burn, pumped, whipper.
- **Movement words:** footwork, heel and toe hook, flag, drop knee, mantle, deadpoint, campus, hangboard, rest days. Words only.
- **Participants and organisations:** IFSC, USA Climbing, Access Fund, American Alpine Club, local climbing coalitions, gyms, setters, guides.
- **Not taught anywhere:** how to belay, lead, place gear, build anchors, rappel, fall, spot, use a rope or harness, or read a route safely outdoors.

## 4. Enthusiast model
- **What enthusiasts talk about:** their project and its crux; the new set at the gym; send trips; grades and sandbags; fingers and tendons; rest days; the crag season; comps; "that line".
- **Distinctions that matter:** flash vs onsight vs redpoint; sport vs trad; V-scale vs Font; sandbag vs soft; gym vs outdoor; top rope vs lead; free climbing vs aid.
- **Knowledge that signals understanding:** asking what the crux is; knowing flash is not onsight; saying "that grade is soft" only when you have reason; not asking "how high is it?" but "what's the style?".
- **Obviously uninformed statements:** "So you just climb up?"; "Isn't that just a rock wall?"; "Why would you fall on purpose?"; "I could do that, my arms are strong"; "Is a V4 harder than a 5.10?" (scales differ); "Free Solo guy does this every day".
- **Controversies and debates:** grade inflation and sandbags; bolting ethics; chipping; the training and hangboard culture; gym vs outdoor purity; Olympic format changes; free-solo morality and the Honnold films; access loss and closures; social media "beta spray"; inclusion and adaptive climbing.

## 5. Interaction model
- **Experience instead of reading:** identify holds and features from illustrations, tap wall angles on a side profile, order a project's life, decide what a good friend does when asked to belay, talk to an enthusiast in chat.
- **Unity?** One small Tier A sim, `climbing.bouldering.problem-read.v1`, reads a procedural wall in 3D (camera perspective is the concept: angle, hold facing, corners). No climber figure, no movement, no fall. Full rigour in section 12 and the sim spec section 4. **Honest verdict:** the thinnest Tier A case in the catalog; first to cut if Astra capacity is scarce (native fallback `rw-08` covers it).
- **Rejected Unity candidates:** a climber-movement sim ("pick the right move"): it would teach technique and imply body-position correctness, which this course refuses. A belay or fall simulation: life-safety technique, never simulated (spec rule 4 and the course safety rule). A route-setting sim: better taught as a native sequence and conversation. A speed-wall sim: a 1D timing bar is `timing-tap` territory, and a race game trivialises the discipline. A comp-scoring sim: pure scoring rules, taught natively with sequence-order and multiple-choice.
- **What must NOT be gamified:** safety decisions (no timers, streaks, speed or hearts-shaming), belay and lead scenarios, free-solo admiration, injuries, grades as status, "hardest climb" leaderboards.
- **Chosen mix:** native-heavy (multiple-choice, say-this, binary-call, decision-scenario, term-match, fill-the-gap, hotspot-tap, sequence-order, visual-id, estimate-slider, talk-track) plus four sim lessons.

## 6. Dynamic information requirements
| Kind | Needed? | Why | Providers (behind adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| events | Yes | Comp weekends, World Cup dates, Olympic schedule: things she might watch | IFSC calendar (licence to confirm), USA Climbing (link), Swoon'd editorial calendar | weekly | Authored seasonal list |
| rankings | Limited | World Cup season context | IFSC (licence to confirm) | weekly | Hidden |
| weather | Limited | "Friction talk" for crag seasons; never a go/no-go | NWS, Open-Meteo | hourly | Seasonal norms |
| alerts | Limited | Heat, storm, smoke near a crag region | NWS, AirNow | hourly | Cached with age |
| closures | Yes (link-only) | Seasonal closures and access notices explain why a crag is off-limits | Access Fund, local coalitions, land managers | daily | Link to the source |
| news | Link-only | "Why is everyone talking about this ascent?" | Press pages, licensed API TBD | daily | Hidden |
| scores, standings, statistics, schedules, rosters, injuries, transactions | No or minimal | Climbing is not a league sport; no invented sport framing | n/a | n/a | n/a |
| conditions (snow, streamflow) | No | That is hiking and alpine territory | n/a | n/a | n/a |

Structured data (events, rankings, weather) and editorial (explanations of why something matters) are separate systems. Full plan: `live-data.md`.

## 7. Editorial context
- **Helpful commentary:** what a result means, why a crag is closed, why the Olympic format changed, what an ascent (for example Honnold on Taipei 101, January 2026) means for the sport, what people are debating.
- **Sources:** IFSC and Olympic press, Access Fund, climbing magazines (headline and link). Never copy text; explain in our own words and link.
- **Example prompts:** "Why are climbers talking about this ascent?" "What does a flash at a World Cup mean?" "Why is this crag closed in spring?"

## 8. Personalization
| Dimension | Changes | Default |
|---|---|---|
| `venue` (home gym) | Gym-specific language (set days, autobelay, comp nights) in examples | "your gym" |
| `region` (home crags) | Which crags appear in examples and seasonal context | Generic U.S. mix |
| `player` (favourite climber) | Talk tracks and legends examples name her favourite | Janja Garnbret |
| `skill-level` | The grade range in examples | V3/5.9 |

Branch choice (`bouldering`, `sport-climbing`, `trad-and-big-wall`) picks the depth unit. `{{tokens}}` are used in `talk-the-wall` and `current-season`.

## 9. Conversation model
Example lines an enthusiast might say (with translation):
1. "I finally flashed that V4." = she climbed a boulder on her first try after getting beta.
2. "I've been projecting this 11a for three weeks." = she keeps trying a hard roped route at her limit.
3. "The crux is a big move to a sloper." = the hardest part is a long reach to a rounded hold.
4. "It's a sandbag." = it's harder than its grade.
5. "They reset the cave on Monday." = the gym replaced the routes on the steep wall.
6. "My fingers are toast." = tendons and forearms are tired.
7. "I'm doing a learn-to-lead class." = she is being taught lead climbing by an instructor.
8. "Janja is on next." = an Olympic champion competes.
9. "Access Fund is doing a cleanup at the crag." = volunteers maintain a climbing area.
10. "We're going to the Red this fall." = Red River Gorge, Kentucky, in cooler weather.
11. "It's a proud line." = an obvious, beautiful route.
12. "Can you give me a spot?" = she is asking someone to watch a boulder fall (answer: only if you have been taught).

- **What she might be asked next:** "What's the crux?" "How many tries has it taken?" "What's the style?" "Who set that?" "What are you working on?"
- **No fake expertise:** scripts coach honest lines ("I'm not belay-tested; let's get me a class"), never boast.
- **Target:** 12 talk tracks at launch (8 drafted in `exercises.md`), about 60 say-this items.

## 10. Assessment
- **Useful competence determined by:** concept mastery >= 0.8 on the ~179 Playbook concepts (weighted to foundations), conversation practice outcomes (Smooth score), and explicit safety-scenario outcomes (a wrong answer on a safety scenario lowers the safety-culture concepts and is never averaged away).
- **Recognize:** grade scales, hold types, wall angles, send words, disciplines. **Understand:** why safety culture matters; why grades are opinions; why access is fragile. **Explain:** flash vs onsight; sport vs trad; why ropes are learned from professionals. **Interpret:** a comp result line; a crag closure; "the crux is at the top".
- **Useful competence statement:** "Can follow her climbing talk, ask a real question about her project, grade or crag, treat climbing safety with respect, and know when to say 'I'd need an instructor for that', without pretending to be a climber."

## 11. Curriculum map (ongoing course)
Designed as an ongoing course. Counts are in the layer summary. "Sim" lessons launch `climbing.bouldering.problem-read.v1`; each has a native fallback in `rw-08`.

### Foundations

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `what-is-climbing` | What is climbing? | - | 7: Why she loves it; The family tree; Bouldering vs roped; Sport vs trad; Gym vs real rock; Shoes, chalk and the rest; The one rule: learn it from a pro | climbing-community, climbing-disciplines, bouldering, top-rope, lead-climbing, sport-climbing, trad-climbing, big-wall |
| `reading-the-wall` | Reading the wall | what-is-climbing | 8: Holds you will hear about; Holds that point somewhere; Volumes and features; Start, finish, colors; Slab to roof; Tilt the wall (sim); Holds from every side (sim); Wall reading without the 3D view | hold-jug, hold-crimp, hold-sloper, hold-pinch, hold-pocket, hold-undercling, hold-sidepull, hold-gaston |
| `grades-and-numbers` | Grades and numbers | what-is-climbing | 7: V-scale 101; YDS, the 5-point-something; Font and French; Roughly equal; Why a grade is an opinion; Gym grades vs outdoor grades; The pyramid | v-scale, yds, font-scale, french-scale, grade-conversion, grade-subjectivity, sandbag, soft-grade |
| `send-talk` | Send talk | what-is-climbing | 7: Beta and crux; Send, flash, onsight; Redpoint, pinkpoint, project; Burns and links; Pumped and whipper; Dynos and proud lines; Do not spray | beta, crux, beta-spray, send, flash, onsight, redpoint, pinkpoint |
| `movement-words` | Movement words | reading-the-wall | 6: Footwork is the secret; Heel and toe hooks; Flagging and drop knees; Mantles, lock-offs, deadpoints; Campus and hangboard; Rest days | footwork, smear, heel-hook, toe-hook, flagging, drop-knee, mantle, lock-off |

**`what-is-climbing` (Foundations).** Why people climb and the map of the sport: styles, gym vs rock, who does what.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `wc-01` | Why she loves it | Name three things climbers say they love (problem-solving, movement, community). | climbing-community,climbing-disciplines | `say-this`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `wc-02` | The family tree | Sort the main disciplines: bouldering, top rope, lead, sport, trad, speed, big wall. | climbing-disciplines,bouldering,top-rope,lead-climbing,sport-climbing,trad-climbing,big-wall | `term-match`, `multiple-choice`, `binary-call`, `sequence-order` |
| `wc-03` | Bouldering vs roped | Explain the big fork: short, unroped, padded problems vs ropes and height. | bouldering,crash-pad,top-rope,lead-climbing,harness | `binary-call`, `multiple-choice`, `say-this`, `hotspot-tap` |
| `wc-04` | Sport vs trad | Tell sport (bolts) from trad (placed gear) in one sentence each. | sport-climbing,trad-climbing,bolt,rack | `term-match`, `binary-call`, `multiple-choice`, `say-this` |
| `wc-05` | Gym vs real rock | Say what is the same and what changes moving from plastic to rock. | gym-vs-crag,gym-to-crag-gap,certified-instruction | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `wc-06` | Shoes, chalk and the rest | Recognize common gear by name and purpose, not how to use it. | climbing-shoes,chalk,harness,autobelay,crash-pad | `visual-id`, `term-match`, `fill-the-gap`, `multiple-choice` |
| `wc-07` | The one rule: learn it from a pro | Say why belaying, leading and gear are learned from certified instructors only. | certified-instruction,belayer,climbing-partner,guide-service | `decision-scenario`, `decision-scenario`, `multiple-choice`, `say-this` |

**`reading-the-wall` (Foundations).** Hold types, wall angles, features, and how a problem is marked.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `rw-01` | Holds you will hear about | Match jug, crimp, sloper, pinch, pocket to their shapes. | hold-jug,hold-crimp,hold-sloper,hold-pinch,hold-pocket | `term-match`, `visual-id`, `visual-id`, `multiple-choice` |
| `rw-02` | Holds that point somewhere | Tell undercling, sidepull and gaston by the direction of pull. | hold-undercling,hold-sidepull,hold-gaston | `term-match`, `hotspot-tap`, `multiple-choice`, `say-this` |
| `rw-03` | Volumes and features | Recognize volumes, arete, dihedral and crack in photos and diagrams. | volume,arete,dihedral,crack | `visual-id`, `hotspot-tap`, `term-match`, `multiple-choice` |
| `rw-04` | Start, finish, colors | Read the tape and colors that define one problem. | route-tape-colors,start-holds,top-out | `fill-the-gap`, `multiple-choice`, `hotspot-tap`, `binary-call` |
| `rw-05` | Slab to roof | Order wall angles from slab to roof and say what each asks of the body. | wall-slab,wall-vertical,wall-overhang,wall-roof | `sequence-order`, `term-match`, `multiple-choice`, `estimate-slider` |
| `rw-06` | Tilt the wall (sim) | See wall angle and features from several sides; say which you are looking at. | wall-slab,wall-vertical,wall-overhang,wall-roof,arete,dihedral,volume | `unity-sim` `climbing.bouldering.problem-read.v1`, `hotspot-tap`, `multiple-choice` |
| `rw-07` | Holds from every side (sim) | See which way a hold faces and so what kind it is. | hold-sidepull,hold-undercling,hold-gaston,feature-reading | `unity-sim` `climbing.bouldering.problem-read.v1`, `multiple-choice`, `visual-id` |
| `rw-08` | Wall reading without the 3D view | Native-only path: wall angles, hold orientation and problem anatomy from diagrams (accessible fallback for the sim). | wall-overhang,hold-sidepull,start-holds,crux,feature-reading | `hotspot-tap`, `hotspot-tap`, `multiple-choice`, `term-match`, `sequence-order` |

**`grades-and-numbers` (Foundations).** Four scales, why grades are opinions, and how to ask about difficulty.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `gn-01` | V-scale 101 | Place V0 to V10 on an easy/moderate/hard mental map. | v-scale | `estimate-slider`, `multiple-choice`, `fill-the-gap`, `say-this` |
| `gn-02` | YDS, the 5-point-something | Read 5.6, 5.10a, 5.12 and know what the pieces mean. | yds | `multiple-choice`, `fill-the-gap`, `sequence-order`, `estimate-slider` |
| `gn-03` | Font and French | Recognize 6A and 7a+ as European grades and know which is which. | font-scale,french-scale | `term-match`, `multiple-choice`, `binary-call`, `say-this` |
| `gn-04` | Roughly equal | Explain why conversions are approximate and never exact. | grade-conversion,grade-subjectivity | `multiple-choice`, `binary-call`, `decision-scenario`, `say-this` |
| `gn-05` | Why a grade is an opinion | Name three things that change how hard a climb feels. | grade-subjectivity,sandbag,soft-grade | `multiple-choice`, `term-match`, `decision-scenario`, `say-this` |
| `gn-06` | Gym grades vs outdoor grades | Explain why gym V4 and outdoor V4 differ. | gym-grades,grade-subjectivity | `binary-call`, `multiple-choice`, `say-this`, `estimate-slider` |
| `gn-07` | The pyramid | Describe the idea of a grade pyramid in training talk. | grade-pyramid,project | `multiple-choice`, `sequence-order`, `fill-the-gap`, `say-this` |

**`send-talk` (Foundations).** The slang that marks someone who really climbs.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `st-01` | Beta and crux | Use beta and crux correctly and ask for neither rudely. | beta,crux,beta-spray | `term-match`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `st-02` | Send, flash, onsight | Sort sends by how they happened. | send,flash,onsight,redpoint | `term-match`, `sequence-order`, `multiple-choice`, `binary-call` |
| `st-03` | Redpoint, pinkpoint, project | Explain the project life cycle in plain words. | redpoint,pinkpoint,project,working-a-route | `sequence-order`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `st-04` | Burns and links | Talk about attempts and link-ups. | attempt,link-up,working-a-route | `multiple-choice`, `fill-the-gap`, `say-this`, `binary-call` |
| `st-05` | Pumped and whipper | Describe tired forearms and big falls in the language climbers use. | pumped,whipper,take | `term-match`, `multiple-choice`, `say-this`, `binary-call` |
| `st-06` | Dynos and proud lines | Recognize a dyno and what makes a line proud. | dyno,proud | `multiple-choice`, `term-match`, `visual-id`, `say-this` |
| `st-07` | Do not spray | Learn the etiquette of beta: ask, never spoil. | beta-spray,beta | `decision-scenario`, `decision-scenario`, `multiple-choice`, `say-this` |

**`movement-words` (Foundations).** Moves by name: recognition and conversation only, never instruction.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `mw-01` | Footwork is the secret | Explain why climbers talk about feet first. | footwork,smear | `multiple-choice`, `binary-call`, `say-this`, `fill-the-gap` |
| `mw-02` | Heel and toe hooks | Recognize hooks in photos and describe why they matter. | heel-hook,toe-hook | `visual-id`, `multiple-choice`, `term-match`, `say-this` |
| `mw-03` | Flagging and drop knees | Know the terms without teaching technique. | flagging,drop-knee | `term-match`, `visual-id`, `multiple-choice`, `say-this` |
| `mw-04` | Mantles, lock-offs, deadpoints | Understand these moves as words, not drills. | mantle,lock-off,deadpoint | `term-match`, `multiple-choice`, `fill-the-gap`, `say-this` |
| `mw-05` | Campus and hangboard | Explain training tools and why injury talk follows. | campusing,hangboard,finger-pulley-injury | `multiple-choice`, `decision-scenario`, `binary-call`, `say-this` |
| `mw-06` | Rest days | Why climbers rest and why pain deserves a clinician. | rest-day,finger-pulley-injury | `multiple-choice`, `decision-scenario`, `binary-call`, `say-this` |

### Intermediate

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `gym-culture` | Gym culture | what-is-climbing, reading-the-wall | 8: Your first gym visit; Gym etiquette; Who sets the routes; Comp style and new sets; Pads, zones and falling; Autobelays and ropes; Spotting and helping; Community nights | gym-orientation, risk-acknowledgement, belay-test, gym-etiquette, fall-zone, problem-setting, route-setter, reset-day |
| `safety-culture` | Safety culture | what-is-climbing | 7: The culture of checking; She asks you to belay; A friend says I will teach you; Gear and retirement; Risk is real; Injuries and pacing; Outdoors needs more | safety-culture, buddy-check, hazard-humility, belayer, belay-test, certified-instruction, instructor-led, climbing-partner |
| `roped-world` | The roped world | what-is-climbing, safety-culture | 7: Top rope vs lead, the idea; What a bolt is; Quickdraws and clipping; The trad rack; Ropes and devices; Going down; Multi-pitch words | top-rope, lead-climbing, leader-fall, bolt, anchor, fixed-anchors, quickdraw, clipping |
| `outdoor-ethics` | Outdoor ethics | what-is-climbing | 7: Why access is fragile; Access Fund and local coalitions; Leave No Trace at the crag; Crag etiquette; Chalk marks and chipping; Closures and sacred places; Fixed anchors and bolting ethics | access-loss, access-fund, local-climbing-coalition, leave-no-trace, human-waste, crag-etiquette, tick-marks, chipping |

**`gym-culture` (Intermediate).** How a climbing gym works and how its people behave.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `gc-01` | Your first gym visit | Describe orientation, waiver, belay test and what they are for. | gym-orientation,risk-acknowledgement,belay-test | `sequence-order`, `decision-scenario`, `multiple-choice`, `say-this` |
| `gc-02` | Gym etiquette | Pick the polite move in common gym situations. | gym-etiquette,fall-zone | `decision-scenario`, `decision-scenario`, `binary-call`, `multiple-choice` |
| `gc-03` | Who sets the routes | Understand setters, resets and color systems. | problem-setting,route-setter,reset-day,route-tape-colors | `term-match`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `gc-04` | Comp style and new sets | Recognize comp-style problems and new-set excitement. | comp-style-set,problem-setting | `multiple-choice`, `visual-id`, `say-this`, `binary-call` |
| `gc-05` | Pads, zones and falling | Explain why gyms have fall zones; falling is taught by staff. | fall-zone,crash-pad,certified-instruction | `decision-scenario`, `multiple-choice`, `binary-call`, `hotspot-tap` |
| `gc-06` | Autobelays and ropes | Know what they are and that they require orientation. | autobelay,belay-test,top-rope | `multiple-choice`, `decision-scenario`, `binary-call`, `say-this` |
| `gc-07` | Spotting and helping | Say why spotting is a taught skill. | spotting-culture,boulder-spotting | `decision-scenario`, `multiple-choice`, `say-this`, `binary-call` |
| `gc-08` | Community nights | Understand gym social culture and how to be welcome. | climbing-community,gym-etiquette | `decision-scenario`, `say-this`, `multiple-choice`, `talk-track` |

**`safety-culture` (Intermediate).** Why climbers are serious about safety and how to respond like a good partner.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `sc-01` | The culture of checking | Explain why climbers double check and welcome being checked. | safety-culture,buddy-check,hazard-humility | `multiple-choice`, `decision-scenario`, `binary-call`, `say-this` |
| `sc-02` | She asks you to belay | Choose the responsible answer when invited to belay without training. | belayer,belay-test,certified-instruction | `decision-scenario`, `decision-scenario`, `binary-call`, `say-this` |
| `sc-03` | A friend says I will teach you | Steer toward an instructor, kindly. | instructor-led,certified-instruction,climbing-partner | `decision-scenario`, `decision-scenario`, `multiple-choice`, `say-this` |
| `sc-04` | Gear and retirement | Understand why gear is inspected and retired. | gear-inspection,rope,harness | `multiple-choice`, `binary-call`, `decision-scenario`, `say-this` |
| `sc-05` | Risk is real | Talk honestly about risk without drama. | risk-acknowledgement,leader-fall,hazard-humility | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `sc-06` | Injuries and pacing | Recognize finger pain as a reason to rest. | finger-pulley-injury,rest-day | `decision-scenario`, `multiple-choice`, `binary-call`, `say-this` |
| `sc-07` | Outdoors needs more | List what outdoor adds (weather, rock, anchors) and why guides exist. | gym-to-crag-gap,guide-service,certified-instruction | `multiple-choice`, `decision-scenario`, `binary-call`, `say-this` |

**`roped-world` (Intermediate).** The language of ropes and gear, names and ideas only.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `rp-01` | Top rope vs lead, the idea | Explain why a lead fall is bigger than a top-rope slip. | top-rope,lead-climbing,leader-fall | `binary-call`, `multiple-choice`, `decision-scenario`, `say-this` |
| `rp-02` | What a bolt is | Understand bolts and anchors as fixed protection. | bolt,anchor,fixed-anchors | `visual-id`, `term-match`, `multiple-choice`, `binary-call` |
| `rp-03` | Quickdraws and clipping | Name quickdraws and clipping as sport-lead vocabulary. | quickdraw,clipping,sport-climbing | `visual-id`, `term-match`, `multiple-choice`, `say-this` |
| `rp-04` | The trad rack | Recognize cams and nuts as removable protection. | rack,cam,nut,trad-climbing | `visual-id`, `term-match`, `multiple-choice`, `say-this` |
| `rp-05` | Ropes and devices | Know the dynamic rope and belay device by name and purpose. | rope,belay-device,belayer | `term-match`, `multiple-choice`, `binary-call`, `say-this` |
| `rp-06` | Going down | Lowering and rappelling as vocabulary, with a training note. | lowering,rappel,certified-instruction | `term-match`, `decision-scenario`, `multiple-choice`, `say-this` |
| `rp-07` | Multi-pitch words | Follow a multi-pitch conversation. | multi-pitch,pitch,big-wall | `sequence-order`, `multiple-choice`, `say-this`, `fill-the-gap` |

**`outdoor-ethics` (Intermediate).** Access, stewardship and the manners of a crag.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `oe-01` | Why access is fragile | Explain how areas get closed. | access-loss,access-fund | `multiple-choice`, `decision-scenario`, `binary-call`, `say-this` |
| `oe-02` | Access Fund and local coalitions | Know who keeps crags open. | access-fund,local-climbing-coalition | `term-match`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `oe-03` | Leave No Trace at the crag | Apply the seven principles at a climbing area. | leave-no-trace,human-waste | `term-match`, `decision-scenario`, `multiple-choice`, `fill-the-gap` |
| `oe-04` | Crag etiquette | Pick the polite choice around other parties. | crag-etiquette | `decision-scenario`, `decision-scenario`, `multiple-choice`, `say-this` |
| `oe-05` | Chalk marks and chipping | Why tick marks get brushed and chipping is taboo. | tick-marks,chipping | `binary-call`, `multiple-choice`, `decision-scenario`, `say-this` |
| `oe-06` | Closures and sacred places | Respect seasonal and cultural closures. | seasonal-closure,cultural-sites | `decision-scenario`, `multiple-choice`, `binary-call`, `say-this` |
| `oe-07` | Fixed anchors and bolting ethics | Explain why bolting is a community decision. | fixed-anchors,bolting-ethics | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |

### Enthusiast depth

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `crags-and-places` | Crags and places | grades-and-numbers, send-talk | 8: Yosemite and El Cap; Fontainebleau; Hueco Tanks; Red River Gorge; Joshua Tree and Indian Creek; Smith Rock and Kalymnos; Bishop, Squamish, Rocklands; Flatanger and Chamonix | yosemite, el-capitan, fontainebleau, font-scale, problem-circuit, hueco-tanks, v-scale, access-loss |
| `legends-and-lines` | Legends and lines | send-talk | 7: John Gill; Lynn Hill and the Nose; The Dawn Wall; Free Solo, the film; Honnold in Taipei; Silence and Burden of Dreams; Janja, Ashima, Margo | john-gill, the-nose, el-capitan, dawn-wall, free-solo-film, alex-honnold, free-solo, free-solo-debate |
| `competition-climbing` | Competition climbing | what-is-climbing, send-talk | 7: IFSC and the World Cup; Boulder comps; Lead comps; Speed; The Olympics; Para climbing; How to watch a comp | ifsc, world-cup-circuit, boulder-format, tops-and-zones, lead-format, speed-format, youth-comp, olympic-climbing |
| `debates-and-culture` | Debates and culture | gym-culture, outdoor-ethics | 7: Gym vs outdoor; Grade inflation and sandbags; The bolt debate; Training culture; Free solo: admire, don't imitate; Fear of falling; Who gets to climb | gym-vs-outdoor, gym-to-crag-gap, grade-inflation, sandbag, soft-grade, bolt-debate, bolting-ethics, training-culture |

**`crags-and-places` (Enthusiast depth).** Famous climbing places and what each is known for.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `cp-01` | Yosemite and El Cap | Place Yosemite and El Capitan in climbing history. | yosemite,el-capitan | `visual-id`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `cp-02` | Fontainebleau | Explain what Font is and why bouldering fans visit. | fontainebleau,font-scale,problem-circuit | `multiple-choice`, `term-match`, `say-this`, `fill-the-gap` |
| `cp-03` | Hueco Tanks | Know Hueco as the V-scale birthplace with limited access. | hueco-tanks,v-scale,access-loss | `multiple-choice`, `binary-call`, `decision-scenario`, `say-this` |
| `cp-04` | Red River Gorge | Recognize the Red as steep sandstone sport. | red-river-gorge | `multiple-choice`, `visual-id`, `say-this`, `fill-the-gap` |
| `cp-05` | Joshua Tree and Indian Creek | Contrast desert granite and Utah cracks. | joshua-tree,indian-creek,crack | `term-match`, `multiple-choice`, `say-this`, `binary-call` |
| `cp-06` | Smith Rock and Kalymnos | Two sport landmarks. | smith-rock,kalymnos | `term-match`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `cp-07` | Bishop, Squamish, Rocklands | Name these boulder and granite hubs. | bishop,squamish,rocklands | `term-match`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `cp-08` | Flatanger and Chamonix | Know the cave and the alpine town. | flatanger,chamonix | `term-match`, `multiple-choice`, `say-this`, `binary-call` |

**`legends-and-lines` (Enthusiast depth).** The climbers and climbs that everybody references.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `ll-01` | John Gill | Explain Gill's influence on bouldering and chalk. | john-gill | `multiple-choice`, `say-this`, `fill-the-gap`, `binary-call` |
| `ll-02` | Lynn Hill and the Nose | Tell why Hill's free ascent mattered. | the-nose,el-capitan | `multiple-choice`, `say-this`, `fill-the-gap`, `binary-call` |
| `ll-03` | The Dawn Wall | Explain what the Dawn Wall achieved. | dawn-wall | `multiple-choice`, `say-this`, `estimate-slider`, `fill-the-gap` |
| `ll-04` | Free Solo, the film | Talk about the film and admire without imitating. | free-solo-film,alex-honnold,free-solo | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `ll-05` | Honnold in Taipei | Understand the January 2026 climb and the livestream. | alex-honnold,free-solo-debate | `multiple-choice`, `say-this`, `decision-scenario`, `binary-call` |
| `ll-06` | Silence and Burden of Dreams | The hardest sport and boulder. | silence-9c,burden-of-dreams,adam-ondra | `multiple-choice`, `estimate-slider`, `say-this`, `fill-the-gap` |
| `ll-07` | Janja, Ashima, Margo | Modern stars of comps and rock. | janja-garnbret,ashima-shiraishi,margo-hayes | `term-match`, `multiple-choice`, `say-this`, `binary-call` |

**`competition-climbing` (Enthusiast depth).** How comps work and how to watch one.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `cc-01` | IFSC and the World Cup | Know who runs comps and the season. | ifsc,world-cup-circuit | `multiple-choice`, `term-match`, `say-this`, `fill-the-gap` |
| `cc-02` | Boulder comps | Read tops, zones and attempts. | boulder-format,tops-and-zones | `multiple-choice`, `sequence-order`, `fill-the-gap`, `say-this` |
| `cc-03` | Lead comps | Understand highest hold and time limits. | lead-format | `multiple-choice`, `binary-call`, `say-this`, `fill-the-gap` |
| `cc-04` | Speed | Understand the standard 15-meter wall and head-to-head. | speed-format,youth-comp | `multiple-choice`, `estimate-slider`, `say-this`, `binary-call` |
| `cc-05` | The Olympics | Tell Tokyo, Paris and LA28 formats apart. | olympic-climbing,janja-garnbret | `sequence-order`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `cc-06` | Para climbing | Know para categories exist and watch them. | para-climbing,adaptive-climbing | `multiple-choice`, `say-this`, `fill-the-gap`, `binary-call` |
| `cc-07` | How to watch a comp | Ask good questions while watching. | comp-calendar,boulder-format,lead-format | `multiple-choice`, `say-this`, `talk-track`, `binary-call` |

**`debates-and-culture` (Enthusiast depth).** What climbers argue about.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `dc-01` | Gym vs outdoor | Hold both sides gracefully. | gym-vs-outdoor,gym-to-crag-gap | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `dc-02` | Grade inflation and sandbags | Talk about who deserves a number. | grade-inflation,sandbag,soft-grade | `multiple-choice`, `binary-call`, `say-this`, `fill-the-gap` |
| `dc-03` | The bolt debate | Understand both camps. | bolt-debate,bolting-ethics | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `dc-04` | Training culture | Discuss hangboards without giving advice. | training-culture,hangboard,finger-pulley-injury | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `dc-05` | Free solo: admire, don't imitate | Talk about risk and ethics. | free-solo-debate,free-solo | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `dc-06` | Fear of falling | Empathize with the mental game. | fear-of-falling,leader-fall | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `dc-07` | Who gets to climb | Adaptive and inclusive climbing. | adaptive-climbing,climbing-community | `multiple-choice`, `say-this`, `decision-scenario`, `binary-call` |

### Branches

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `branch-bouldering` | Branch: bouldering | reading-the-wall, send-talk | 5: Sit starts and problems; Pads and spotters; Read the whole problem (sim); Highballs; Bouldering trips | sit-start, problem-circuit, bouldering, boulder-spotting, crash-pad, spotting-culture, start-holds, crux |
| `branch-sport-climbing` | Branch: sport climbing | roped-world | 5: Redpoint season; Hangdogging; Bolts and grades; Sport destinations; The 9c conversation | sport-redpoint-culture, redpoint, project, hangdog, working-a-route, bolt, french-scale, proud |
| `branch-trad-big-wall` | Branch: trad and big wall | roped-world, outdoor-ethics | 5: What trad demands; Cracks and offwidths; Ground-up and E-grades; Big walls and portaledges; El Cap talk | trad-climbing, rack, cam, nut, crack, offwidth, ground-up-ethic, british-grades |

**`branch-bouldering` (Branch (bouldering)) (`branchId`: `bouldering`).** Bouldering culture in depth.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `bb-01` | Sit starts and problems | Explain sit starts and problem culture. | sit-start,problem-circuit,bouldering | `term-match`, `multiple-choice`, `say-this`, `fill-the-gap` |
| `bb-02` | Pads and spotters | Why bouldering is padded and taught. | boulder-spotting,crash-pad,spotting-culture | `decision-scenario`, `multiple-choice`, `binary-call`, `say-this` |
| `bb-03` | Read the whole problem (sim) | Read a whole problem from all sides. | start-holds,crux,feature-reading,top-out | `unity-sim` `climbing.bouldering.problem-read.v1`, `hotspot-tap`, `multiple-choice` |
| `bb-04` | Highballs | Why tall boulders are a serious, specialist thing. | highball,fear-of-falling | `decision-scenario`, `multiple-choice`, `binary-call`, `say-this` |
| `bb-05` | Bouldering trips | Talk about Fontainebleau, Bishop and Rocklands. | fontainebleau,bishop,rocklands | `multiple-choice`, `say-this`, `fill-the-gap`, `talk-track` |

**`branch-sport-climbing` (Branch (sport-climbing)) (`branchId`: `sport-climbing`).** Sport climbing culture.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `bs-01` | Redpoint season | How sport climbers chase a single route. | sport-redpoint-culture,redpoint,project | `multiple-choice`, `sequence-order`, `say-this`, `fill-the-gap` |
| `bs-02` | Hangdogging | Why resting on rope is normal when working. | hangdog,working-a-route | `multiple-choice`, `binary-call`, `say-this`, `fill-the-gap` |
| `bs-03` | Bolts and grades | What makes a route proud. | bolt,french-scale,proud | `multiple-choice`, `term-match`, `say-this`, `fill-the-gap` |
| `bs-04` | Sport destinations | Kalymnos, Red River, Smith Rock. | kalymnos,red-river-gorge,smith-rock | `term-match`, `multiple-choice`, `say-this`, `binary-call` |
| `bs-05` | The 9c conversation | Talk about Silence and pinnacle routes. | silence-9c,chris-sharma,adam-ondra | `multiple-choice`, `say-this`, `fill-the-gap`, `binary-call` |

**`branch-trad-big-wall` (Branch (trad-and-big-wall)) (`branchId`: `trad-climbing`).** Trad and big-wall culture.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `bt-01` | What trad demands | Explain why trad is slow, serious and revered. | trad-climbing,rack,cam,nut | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `bt-02` | Cracks and offwidths | Crack types and why they are an acquired taste. | crack,offwidth | `term-match`, `multiple-choice`, `say-this`, `binary-call` |
| `bt-03` | Ground-up and E-grades | Know the ground-up ethic and British grades. | ground-up-ethic,british-grades | `multiple-choice`, `term-match`, `say-this`, `fill-the-gap` |
| `bt-04` | Big walls and portaledges | Appreciate a multi-day wall. | big-wall,portaledge,aid-climbing | `multiple-choice`, `sequence-order`, `say-this`, `binary-call` |
| `bt-05` | El Cap talk | Talk about the Nose and Dawn Wall. | el-capitan,the-nose,dawn-wall | `multiple-choice`, `say-this`, `talk-track`, `fill-the-gap` |

### Current-season / live layer

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `current-season` | Current season | send-talk | 3: This season at the crag; Comp weekend; Where did she get that beta? | crag-season, conditions-friction, comp-calendar, ifsc, tops-and-zones, beta-sources, beta |

**`current-season` (Live layer).** Seasonal and live context refreshed from data.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `cs-01` | This season at the crag | Read seasonal conditions as friction and weather talk. | crag-season,conditions-friction | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |
| `cs-02` | Comp weekend | Follow the next comp conversationally. | comp-calendar,ifsc,tops-and-zones | `multiple-choice`, `say-this`, `talk-track`, `binary-call` |
| `cs-03` | Where did she get that beta? | Understand beta sources and their limits. | beta-sources,beta | `multiple-choice`, `decision-scenario`, `say-this`, `binary-call` |

### Conversation practice

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `talk-the-wall` | Talk the wall | send-talk, grades-and-numbers | 6: She tells you about her project; She sends at the gym; She mentions a grade; She invites you to try; She talks about the crag; She watches a comp | ask-about-project, project, crux, send, flash, onsight, v-scale, yds |

**`talk-the-wall` (Conversation practice).** Talk tracks and what-is-she-saying practice.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `tw-01` | She tells you about her project | Ask about a project. | ask-about-project,project,crux | `talk-track`, `say-this`, `multiple-choice` |
| `tw-02` | She sends at the gym | Respond to a send. | send,flash,onsight | `talk-track`, `say-this`, `multiple-choice` |
| `tw-03` | She mentions a grade | Understand V and 5.x grades in a sentence. | v-scale,yds,grade-subjectivity | `talk-track`, `say-this`, `multiple-choice` |
| `tw-04` | She invites you to try | Answer a climbing invite responsibly. | certified-instruction,gym-orientation | `talk-track`, `decision-scenario`, `say-this` |
| `tw-05` | She talks about the crag | Respond to crag talk with care for access. | crag-etiquette,access-fund | `talk-track`, `say-this`, `multiple-choice` |
| `tw-06` | She watches a comp | Join a comp conversation. | boulder-format,olympic-climbing | `talk-track`, `say-this`, `multiple-choice` |

### Perpetual review

| unit id | unit title | prerequisites | lessons | main concepts |
|---|---|---|---|---|
| `perpetual-review` | Perpetual review | foundations complete | 3: Terms refresher; Read the wall again (sim); Safety attitude check | send, crux, beta, v-scale, yds, wall-overhang, hold-sidepull, feature-reading |

**`perpetual-review` (Perpetual review).** Spaced review of mastered concepts.

| lesson id | title | objective | conceptIds | planned activities |
|---|---|---|---|---|
| `pr-01` | Terms refresher | Mixed terms from every unit. | send,crux,beta,v-scale,yds | `term-match`, `multiple-choice`, `fill-the-gap`, `say-this` |
| `pr-02` | Read the wall again (sim) | Mixed refresher on wall and hold reading. | wall-overhang,hold-sidepull,crux,feature-reading | `unity-sim` `climbing.bouldering.problem-read.v1`, `hotspot-tap`, `multiple-choice` |
| `pr-03` | Safety attitude check | Re-answer a safety scenario. | safety-culture,certified-instruction | `decision-scenario`, `decision-scenario`, `multiple-choice`, `say-this` |

### Layer summary
| Layer | Units | Lessons |
|---|---|---|
| Foundations | 5 (`what-is-climbing`, `reading-the-wall`, `grades-and-numbers`, `send-talk`, `movement-words`) | 35 |
| Intermediate | 4 (`gym-culture`, `safety-culture`, `roped-world`, `outdoor-ethics`) | 29 |
| Enthusiast depth | 4 (`crags-and-places`, `legends-and-lines`, `competition-climbing`, `debates-and-culture`) | 29 |
| Branches | 3 (`branch-bouldering`, `branch-sport-climbing`, `branch-trad-big-wall`) | 15 |
| Current-season / live | 1 (`current-season`) | 3 |
| Conversation practice | 1 (`talk-the-wall`) | 6 |
| Perpetual review | 1 (`perpetual-review`) | 3 |
| **Total** | **19 units** | **120 lessons** |

- **Concept count target:** 179 Playbook concepts (`exercises.md` section 14), every one referenced by a lesson.
- **Review policy:** spaced review intervals 1, 3, 7, 21, 60 days after mastery; at most 12 review items per session; safety-culture concepts (`safety-culture`, `buddy-check`, `certified-instruction`, `belayer`, `instructor-led`, `hazard-humility`) are re-asked at the longest interval permanently and in a different scenario form each time. Review never times or scores safety scenarios.
- **Current-season layer:** climbing has a genuine, light current context: comp weekends, crag season and friction talk, closure notices, and "why is everyone talking about this" ascents. It is a 3-lesson hook layer with `live` unit hooks; it is deliberately small. No fake seasons or scores.
- **Personalization slots:** `{{venue}}`, `{{region}}`, `{{favoriteClimber}}`, `{{skillLevel}}` in `talk-the-wall`, `current-season` and three branch lessons.
- **Release plan:** launch = foundations, intermediate, enthusiast, `branch-bouldering`, conversation and review (units 1-14, 18, 19; 107 lessons) plus a static-only `current-season` (3 lessons). Later: `branch-sport-climbing` and `branch-trad-big-wall`, live data once IFSC licensing (L-series) is settled, and Wave 3 follow-ups (alpine culture if a mountaineering course is created). Safety-critical units (`what-is-climbing` wc-07, `gym-culture`, `safety-culture`, `roped-world`, `outdoor-ethics`, sport and trad branches) gate on human safety review before release.

## 12. Interaction plan
| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Read the Wall (`rw-06`, `rw-07`, `bb-03`, `pr-02`) | wall angles, hold facing, features, problem anatomy | `unity-sim` `climbing.bouldering.problem-read.v1` | Camera perspective is the concept: angle, corner sign and hold facing are 3D facts. Closest natives are `hotspot-tap` on a side profile and `visual-id` (both used in fallback `rw-08`); they teach names but not the one-angle ambiguity. Thinnest Tier A case; no climber figure, no movement, no timing. Spec: `sims/climbing.bouldering.problem-read.v1.md` | A | 4 |
| Safety and etiquette judgments (`wc-05`, `wc-07`, `sc-*`, `gc-02`, `gc-05..07`, `oe-*`, `ll-04`, `dc-*`) | safety-culture, certified-instruction, crag-etiquette, access | `decision-scenario` | Judgment from a fact sheet with graded options; the best answer is always the cautious one; `safetyNote` required. A `timing-tap` or game would add pressure that is wrong here | B | 51 |
| Terms and vocabulary | send words, grades, gear names, places | `term-match`, `fill-the-gap`, `multiple-choice` | Recall and recognition | B | 195 |
| Two-way calls | sport vs trad, opinion vs measure, etiquette | `binary-call` | Crisp rules or distinctions; scene `none` or a procedural diagram | B | 62 |
| Hold, feature and move pictures | holds, arete, heel hook | `visual-id` | Recognition from original illustrations (licence `original-swoond`); no photos | B | 14 |
| Wall diagrams | wall angle, feature, start holds | `hotspot-tap` | Tap on a static side profile or top-down sketch; an honest, accessible alternative to the sim | B | 10 |
| Ordering | project life, angles, Olympic formats | `sequence-order` | Order of events or steepness | B | 13 |
| Grades and numbers | V grades, French grade, record numbers | `estimate-slider` | Number sense: wall height, days on a wall, V grade | B | 7 |
| Conversation | project talk, sends, invites | `say-this`, `talk-track` | "What is she talking about?" and chat practice; coach honest lines | B | 115 |

Not used: `timing-tap` (no 1D timing concept; speed climbing is taught by `estimate-slider` and `multiple-choice`), `listening-id` (no audio at launch).

## 13. Licensing & safety
- **Imagery:** original illustrations and procedural diagrams only (licence id `original-swoond`); no athlete, gym or crag photography, guidebook topos or Mountain Project images.
- **Logos and trademarks:** IFSC, Olympic rings, Access Fund, gym chains and gear brands appear as text only.
- **Player likeness:** climbers are named, never depicted; quotes not reproduced.
- **Video/audio:** no comp, film or athlete video embedded; link to rights holders; no audio at launch.
- **Data terms:** IFSC results need a licence or permission; no scraped or unofficial APIs; Mountain Project, theCrag, 27 Crags and Kaya are deep-link only; NWS custom User-Agent; AirNow attribution.
- **Facts:** grades, first ascents and records are facts but are stated as "graded" and checked against a primary source before release (`NOTES_FOR_ORCHESTRATOR.md` lists time-sensitive items).
- **Safety constraints:** the whole course is governed by `SAFETY_REVIEW_CHECKLIST.md`. Headlines: no belay, lead, gear, anchor, rappel, spotting, falling or free-solo instruction; every technique-adjacent lesson points to certified instruction; cautious answers are always best; no timers or streak pressure on safety content; no medical advice beyond rest and see a clinician; a qualified human reviewer (certified instructor or guide) signs off before release.

## 14. Content assets
- **Procedural diagrams** (`swoond-procedural`): wall side profiles, block top-downs, problem diagrams with tape, angle scale.
- **Original illustrations** (`original-swoond`): eight hold types, arete and dihedral, six movement words, gym scenes without branding. About 40 at launch.
- **Sim assets:** procedural wall, volumes, hold library, floor; no external assets.
- **No** photos, logos, athlete images, film stills or route topos.

## 15. Section 47 quality checklist
- [x] 1. What does a beginner need to understand? Sections 2 and 3.
- [x] 2. What do enthusiasts care about? Section 4.
- [x] 3. What current information matters? Comp calendar, crag seasons, closures, major ascents (section 6).
- [x] 4. What should be interactive? Section 5 and 12: wall reading, judgments, conversations.
- [x] 5. What should NOT be gamified? Safety decisions, free solo, injuries, grades as status (section 5).
- [x] 6. How should it personalize? Venue, region, favourite climber, skill level (section 8).
- [x] 7. What does conversational competence look like? Sections 9 and 10.
- [x] 8. What data providers are needed? `live-data.md`.
- [x] 9. What licensing constraints apply? Section 13.
- [x] 10. How will Swoon'd measure useful understanding? Section 10.

Additional gates: [x] manifest validates; [ ] curriculum validates (not yet written); [ ] every Unity sim has an approved spec (draft); [x] every image/audio asset has a licence id (planned); [ ] voice review; [x] no copied publisher text; [ ] qualified safety review (required before release).

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is the Read the Wall sim worth a Tier A slot given the native fallback? | Product / Astra | No |
| 2 | IFSC results and rankings: licence, partnership or link-only? | Product / Legal | Blocks live comp layer only |
| 3 | Who is the qualified safety reviewer (certified instructor or AMGA guide) and when? | Product | Blocks release of safety-critical units |
| 4 | Grade and first-ascent facts need a primary-source check (list in NOTES) | Claude / SME | Before release |
| 5 | 2025-26 IFSC boulder scoring and Olympic LA28 details to re-verify at build time | Claude | No |
| 6 | Should a mountaineering/alpine course exist, and is `chamonix` enough for now? | Product | No |
