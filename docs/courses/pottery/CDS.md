# Course Design Specification: Pottery (`pottery`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Pottery is a **process-and-diagnosis course**: the subject is a sequence (wet clay to fired object) in which every stage sets up the next, and in which the most common enthusiast conversation is "it cracked, and here is why". The learner is learning because someone they care about spends evenings at a wheel, waits on a kiln, and lights up when a piece comes out right. The goal is socially useful competence, not a makers' apprenticeship: understand what she is describing, ask a good question, and never fake skill.

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Pottery course design agent (Claude), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion docs | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity sims, justified in sections 5 and 12) |

Verification note: time-sensitive and safety facts were checked by web search on **2026-09-30**: OSHA respirable crystalline silica limits (PEL 50 ug/m3 8-hour TWA, action level 25 ug/m3), FDA lead-in-ceramicware guidance (leachable-lead limits; warning about traditional and "lead free" labelled imported pottery), *The Great Pottery Throw Down* series 9 (Channel 4, finale 8 March 2026; winner Fynn from Cornwall; Gladstone Pottery Museum, Stoke-on-Trent; celebrity spin-off announced for 13 September 2026) and NCECA 2027 ("Charm", Baltimore, 10 to 13 March 2027). Cone temperatures are the standard Orton values at a slow (about 108 F per hour) rate; they shift with heating rate. Anything marked **[verify at release]** must be re-checked before content ships (see `NOTES_FOR_ORCHESTRATOR.md`).

---

## 1. Identity
- **Course ID:** `pottery` (immutable)
- **Display name:** Pottery
- **Category / family:** Crafts; category path `Crafts > Ceramics > Pottery`
- **Simulation prefix:** `pottery` (reserved; **no sims are planned**, so no `pottery.<topic>.<name>.vN` id exists)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns pottery, are they meaningfully conversationally competent about it?" | Verdict | Consequence for structure |
|---|---|---|---|
| Ceramics as fine art, sculpture, collecting | Largely yes. Vocabulary, firing, glaze and process knowledge transfer; only the art-world layer (auctions, museum discourse) is extra. | Shares foundation | Covered by enthusiast units `traditions-and-makers` and `collecting-and-art`, and the `handbuilding-sculpture` branch. Not a separate course. |
| Glaze chemistry | Partly. Casual glaze talk is in the core; the chemistry nerd world (UMF, line blends) is a deep subculture. | Shares foundation | Branch `glaze-chemistry`, 3 lessons. |
| Cooking (`cooking`, Wave 2) | Barely. A handmade bowl is the only overlap; food safety of glaze is covered here in `studio-safety`. | Independent | Cross-link only ("her bowl, your soup"). |
| Coffee (`coffee`, Wave 3) | Barely. Handmade mugs and pour-over dripper cones are a shared conversation; coffee's language is its own. | Adjacent, independent | Cross-link only. |
| Painting, drawing, other visual arts | No. Different materials and vocabulary. | Independent | None. |
| Woodworking, jewelry, glass, fibre crafts | Partly (craft-fair culture, maker identity, kiln-formed glass), but techniques do not transfer. | Adjacent, independent | Shared craft-culture lessons only in `studio-culture`. |
| Industrial ceramics, tile, sanitaryware, technical ceramics | No, apart from the shared materials science. | Out of scope | Mentioned only where Stoke-on-Trent history needs it (`trad-07`). |

- **Branches** (chosen or inferred from what she does at the studio; each branch has 3 tagged lessons in the `branches` unit; `wheel-throwing` is the default because the wheel is what most people picture and most community-studio members do):

| id | Name | What changes (technique, culture, vocabulary) |
|---|---|---|
| `wheel-throwing` | Wheel throwing (default) | Centering, opening, pulling, throwing forms, wheel troubleshooting; the "I'm on the wheel tonight" world. |
| `handbuilding-sculpture` | Handbuilding and sculpture | Pinch, coil, slab; hollowing and drying sculpture; figurative and large-scale ceramics; a slower, drier, more architectural kind of clay talk. |
| `atmospheric-firing` | Atmospheric firing | Raku, wood, soda and salt, pit firing, community kiln builds; fire as a collaborator; the kiln crew culture. |
| `glaze-chemistry` | Glaze chemistry | Recipes by weight, batches, unity molecular formula, line and triaxial blends, glaze databases; the "ask her about her tiles" world. |

Branch choice sets personalization dimension `style` (for example functional, sculptural, atmospheric, glaze-nerd) and optionally `equipment`. Default `wheel-throwing`. **No branch is ranked above another.** Nobody is more "real".

## 2. Beginner model
- **What a complete beginner typically knows:** clay is mud, pots go in a kiln, there is a wheel, and the movie *Ghost*. Beginners think the wheel is the skill and the kiln is the oven; they think a glaze is paint and a pot is "done" when it looks finished. They rarely know that a pot is fired twice, that it shrinks by roughly a tenth or more, that it is at its most fragile just before it becomes strong, or that most people who take a class lose pieces to invisible mistakes made days earlier.
- **Terminology that will initially confuse them:** wedging, centering, throwing, pulling, bat, greenware, leather-hard, bone dry, bisque, glaze firing, cone, cone 6, oxidation, reduction, slip, scoring, grog, stoneware, porcelain, earthenware, foot ring, trimming, fettling, kiln wash, dunting, crazing, shivering, pinholing, crawling, "S-crack", "kiln load", "raku", "sgraffito", "celadon", "tenmoku", "shino", "wabi-sabi", "kintsugi".
- **Common misconceptions (each is a lesson target):**
  1. "Pottery is drying in the sun or baking in an oven." (Clay only becomes ceramic in a kiln, permanently and chemically. `clay-particles`, `firing-changes-clay`.)
  2. "One firing is enough." (Most studio work is fired twice: bisque then glaze. `bisque-purpose`, `multiple-firings`.)
  3. "Glaze is paint." (Glaze is a thin layer of glass that has to melt and fit the clay. `glaze-is-glass`, `glaze-color-shift`.)
  4. "The wheel is the hard part." (Centering is; but preparation, drying and firing decide whether a piece survives. `centering`, `pottery-pipeline`.)
  5. "A crack means she did something wrong at the wheel." (Most cracks are made in drying or cooling, and are systemic, not a verdict on skill. `diagnosis-method`.)
  6. "Hollow pieces are fine in the kiln." (Sealed air and trapped moisture can burst a piece. `vent-hole`.)
  7. "Wet pieces can go straight in the kiln if you are in a hurry." (Bone dry is not optional. `even-drying`, `kiln-explosion`.)
  8. "Clay and glaze colors are what you see." (Glazes fire to different colors than wet glaze. `glaze-color-shift`, `test-tiles`.)
  9. "Handmade pots are cheap hobby items." (Time, kiln loss and materials make them expensive. `handmade-pricing`.)
  10. "If it's handmade it's automatically food-safe." (Only with a properly formulated, fully melted, lead-free glaze; imported and antique ware may not be. `food-safe-glaze`, `leachable-lead`.)
  11. "Clay dust is just dust." (Dry clay dust contains respirable crystalline silica. `silica-dust`.)
  12. "A perfect symmetrical pot is the goal." (Many makers prize the hand and the wobble; others chase precision. `wabi-sabi`, `handmade-vs-commercial`.)
- **Concepts that unlock the rest (become foundation units):** what clay is and its stages; clay bodies and cones; wedging and the wheel; handbuilding; and studio safety, because the hazards (dust, heat, glaze materials) are real and often invisible.

## 3. Foundational knowledge
Grouped into modules (these are the manifest `foundationalModules[]` and the five foundation units):

- **`clay-and-studio` Clay and the Studio.** What clay is (plate-like particles plus water; plasticity); the stages from slip to glaze-fired ware; the big picture of the pipeline; shrinkage; studio zones and equipment; the words pottery, ceramics and ware.
- **`clay-bodies` Clay Bodies.** Earthenware, stoneware, porcelain; low, mid and high fire; vitrification and absorption; grog, sand, paper clay; choosing a body for a job.
- **`wheel-basics` Wedging and the Wheel.** Why and how to wedge; wheel anatomy; centering; opening and the floor; pulling walls; shaping, tools and cutting off.
- **`handbuilding` Handbuilding.** Pinch, coil, slab; score and slip; slab handling; molds and slip casting; hollow forms and vent holes.
- **`studio-safety` Studio Safety.** Silica dust and wet cleaning; respirators and dry-material handling; glaze raw-material hazards and hygiene; kiln heat and ventilation; food-safe glazing and lead. Conservative, mainstream, and framed as *understanding her studio's rules*, not as instructions to do dangerous things at home.

The full concept list is in the Appendix of section 11.

## 4. Enthusiast model
- **What enthusiasts actually talk about:** the kiln load ("I have a bisque load going in Thursday"), what came out ("the glaze finally worked"), what failed ("lost two mugs to S-cracks"), a technique ("I've been pulling taller cylinders"), a clay ("I switched to a porcelain and it's like throwing cream"), a glaze ("the celadon over iron slip is unreal"), studio life ("shelf space is a war"), a maker she admires, craft fairs and sales, and the emotional loop of *waiting* for a kiln to cool.
- **Distinctions that matter to them:** stoneware vs porcelain vs earthenware, cone 6 vs cone 10, oxidation vs reduction, electric vs gas vs wood, wheel vs handbuilding, functional vs sculptural, thrown vs slip-cast vs molded, matte vs gloss (and matte durability), commercial vs handmade glaze, bisque vs single fire, throwing "thick then trim" vs "throw it thin", wedging methods, score-and-slip vs "same moisture, just press".
- **Knowledge that signals genuine understanding:** knowing that most breakage happens at drying or cooling and that it is about uneven stress; knowing why the bottom of a pot is a common crack site (S-cracks); knowing bone dry and leather-hard as working states; understanding that glaze must fit the clay; that colours change in the kiln; that kilns are slow to cool for a reason; that loss rates are part of pricing; that a kiln opening is a small ritual.
- **Beginner statements that sound obviously uninformed:** "So you just bake it?" "Why not put the wet pot in?" "Can you microwave that handmade mug?" (Often fine, sometimes not; ask her.) "Why is it so expensive, it's just clay." "It's cracked, so it's ruined." (Some are repairable; some cracks are a feature in kintsugi.) "Just paint it after." "Why doesn't every pot look the same?" "Is it food safe?" asked as a gotcha with no idea what it means.
- **Common controversies and debates (never take a side on the crush's behalf; teach the shape of the argument):** cone 6 electric oxidation vs cone 10 reduction; score and slip vs "same-moisture" joining; whether to bisque at all (once-fire); bat vs direct-on-wheel-head throwing; matte glaze durability and food safety; functional pottery vs "craft" vs "art" hierarchy; wheel-thrown perfection vs visible hand; commercial glazes vs mixed-from-scratch; handmade pricing and craft-fair culture; wood firing's environmental footprint vs community and tradition; cultural appropriation vs appreciation when working in a tradition (Japanese, Pueblo, Korean); "food safe" claims without testing; and the studio politics of shared kilns.

## 5. Interaction model
- **What should the learner EXPERIENCE instead of reading?** Putting a process in order and seeing *why* each step goes there (the pipeline is the course's spine); diagnosing a piece from a fact sheet ("stage, location, clay, glaze, what was different") and choosing the likeliest cause and fix; recognizing forms, tools, surfaces, techniques and defects by sight; reading diagrams (wheel, mug anatomy, kiln stacking, drying cross-section); hearing the real cues (the ring of a sound bisque piece vs the dull thud of a cracked one, kiln "pinging" as glaze crazes on cooling); estimating temperatures, times and shrinkage; and talking to a person who cares.
- **Does the course warrant a Unity simulation? No. Zero sims.** The Tier rubric (`CLAUDE.md` section 4) requires that spatial reasoning, movement, physics, timing in a scene or camera perspective *materially* improve learning **and** that a native exercise would teach it clearly worse. Every plausible pottery sim was tested against that rubric. The honest answer: pottery's difficult, physical core is **touch** (pressure, speed, wetness, feel of a wall going thin), and a phone screen carries none of it. The concepts that *can* be taught (order, cause and effect, recognition, vocabulary, safety) are exactly what native types do best.

**Unity candidates considered and rejected (rigorous, one row each):**

| Candidate sim | Rubric signal it appears to meet | Why native is as good or better | Additional reason it would be harmful or fake |
|---|---|---|---|
| Centering on the wheel: a touch-and-pressure minigame (`pottery.wheel.centering.v1`) | Movement, physics, timing in a scene | Centering is a *feel* skill (pressure, hand position, wheel speed, water) that lives in proprioception and the resistance of clay. A finger drag on glass has no resistance, no wobble feedback in the hands and no wet friction. What is *teachable* is the causal model (three forces: the wheel wants to fling the clay off center; a braced hand pushes back; speed and water change how forgiving it is) and the ordered stages: `sequence-order` (brace elbows, wet, speed high, cone up and down) and `decision-scenario` ("the clay wobbles as you push: what changed?"). | A sim would teach *that centering is a gesture*, and reward the wrong instinct (visual smoothness) with fake resistance. It risks giving the learner the false sense that they "get" throwing, which is the opposite of the product rule of never teaching fake expertise. **Rejected.** |
| Wall-pulling and shaping: drag to form a profile with wall-thickness physics (`pottery.wheel.pull.v1`) | Physics, movement, camera perspective | The teachable content is: walls thin as you pull; thin walls slump if wet or too tall; thick bottoms trigger cracks; the profile should be even. That is a cross-section diagram (`hotspot-tap`, `visual-id`), estimate items (`estimate-slider` on wall thickness) and `decision-scenario`. | A drag game would be judged by the shape the learner draws, not by what clay does. Clay collapse is not a scoring mechanic. Fake physics would teach fake limits. **Rejected.** |
| Kiln firing curve simulator: raise and hold temperature over time; hit a cone (`pottery.kiln.schedule.v1`) | Timing in a scene, physics over time | The concepts are a short ordered list of thresholds (water smoking near 212 F, chemical water loss through roughly 1,000 F, quartz inversion near 1,063 F, peak, slow cooling through the inversions) plus a rule (slow where the clay is fragile). `sequence-order`, `estimate-slider` and a static labelled time-temperature chart `hotspot-tap` teach that completely; a `timing-tap` is used once for the drying window. | A firing schedule is a *decision* with well-known constraints, not a dexterity game. A sim would invite "optimize the ramp for speed", which is the wrong lesson (rushing is the cause of most explosions). Also implies she is programming a kiln, which is a trained job. **Rejected.** |
| Kiln loading: 3D stacking puzzle with shelves and posts (`pottery.kiln.load.v1`) | Spatial reasoning, camera perspective | The rules are few and crisp (bisque pieces may touch and can be stacked; glazed pieces must not touch or touch shelves; keep pieces off elements and thermocouples; use kiln wash; leave gaps for heat flow). `hotspot-tap` on a labelled cross-section diagram ("tap the piece that will fuse to the shelf") and `binary-call`/`decision-scenario` teach the rules without a physics engine. | Loading is done under the studio's kiln monitor; a puzzle could encourage a learner to think they may load a kiln. Also the spatial content is small. **Rejected.** (See "closest call" below.) |
| Crack and stress visualizer: animated cross-section showing drying stress (`pottery.dry.stress.v1`) | Physics visualization | This is a causal picture, and a set of 3 to 4 static or two-frame diagrams with labelled arrows (`visual-id`, `hotspot-tap`) plus `decision-scenario` diagnose it. Animation adds nothing to a fact ("thin parts dry first, pull on thick parts"). | Decoration, not a decision. **Rejected.** |
| Glaze layering and colour-mixing simulator (`pottery.glaze.mix.v1`) | Physics of light, visual | Real glaze colour depends on chemistry, thickness, base, atmosphere and firing; a simulator would need a validated model that does not exist and would misteach colour. Native: `visual-id` on original test-tile illustrations, `term-match` on colorants, `decision-scenario` ("which change makes this blue less runny?"). | Fake chemistry. A wrong colour model is worse than none. **Rejected.** |
| Trimming lathe cross-section (`pottery.trim.foot.v1`) | Camera perspective, motion | The learning is which part to remove, why the base is thick, what a foot ring is: `hotspot-tap` on a cross-section, `sequence-order` for trimming steps, `visual-id` for feet. | A slicing game rewards fast careless cuts (also a real hazard: trimming tools are sharp). **Rejected.** |
| Handle attachment timing (`pottery.handle.timing.v1`) | Timing | Matching moisture of pot and handle is a one-line rule with a consistent cue (both leather-hard); `sequence-order`, `timing-tap` (1D) and `decision-scenario` cover it. | A timing game would gamify a rule that is really "wait, and check by feel". **Rejected.** |
| 3D pot inspector: rotate a piece to spot defects and identify form (`pottery.inspect.turntable.v1`) | Camera perspective | This is the **closest call**. A few defects show only from certain angles (underside crack, glaze pooling in a foot). But 2 to 3 native `visual-id` items (one per angle, the second being the underside) and `hotspot-tap` on a procedural diagram deliver the same recognition without a 3D engine. If a multi-view visual-id turns out to be needed at scale, the correct route is an additive native contract change (`views[]` on `visual-id`, suggested in `NOTES_FOR_ORCHESTRATOR.md`), not a Unity sim. | Extra runtime cost for a recognition skill. **Rejected for launch; revisit only after native playtests.** |

- **Verdict:** `interactionTypes` uses only native types (all 13); `unitySimulations` is `[]`; there is no `sims/` folder. If a future playtest shows a specific concept cannot be taught natively, the correct route is a numbered open question in `NOTES_FOR_ORCHESTRATOR.md` naming the concept, the failing native design and the rubric signal, not a speculative sim.
- **What should NOT be gamified:** studio safety (no timers, streak pressure or "beat the clock" on dust, respirators, kiln heat, glaze hazards or food-safe claims: accuracy, not speed); "food safe" claims (never quiz-shame); loading or firing a kiln (never simulated as a game); glaze mixing from powders (no "recipe builder" game); her pieces (never grade her work or rank her against others); cultural traditions (no ranking Japanese vs Korean vs Pueblo; no gotcha "authenticity" quizzes; sacred, ceremonial or community-owned practices are described with respect and never trivialized); auctions and money (no speculation prompts); and losing a piece (cracks are teaching moments, never jokes at her expense).
- **Chosen mix:** roughly 100% native: `sequence-order` (the pipeline; sequencing is core, spec section 19), `decision-scenario` (why did it crack? diagnosis is core), `visual-id` and `hotspot-tap` (forms, tools, techniques, defects, diagrams; spec section 18), `multiple-choice`, `binary-call`, `term-match`, `fill-the-gap`, `estimate-slider` (cones, times, shrinkage), `listening-id` (the ring test, kiln pinging), `timing-tap` (one light 1D use), `say-this` and `talk-track`. Details in section 12.

## 6. Dynamic information requirements
Pottery is an evergreen-craft course. Spec section 10: "Do NOT invent artificial live data requirements." The honest verdict is a **thin, curated live layer**:

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| scores, standings, statistics, rosters, rankings, injuries, transactions | **No** | No competition data educates a learner about pottery. The TV competition is discussed as a work, not tracked. | none | n/a | n/a |
| events | **Yes (curated)** | Craft-fair season, open-studio weekends, Empty Bowls charity dinners, the NCECA annual conference (10 to 13 March 2027, Baltimore, "Charm") and museum exhibitions give real "ask her about this" moments. | Swoon'd editorial calendar; NCECA and museum event pages (link-only); optional local listings via user-supplied region | seasonal | Evergreen "how craft fairs work" lesson |
| new-media | Modest | New series of *The Great Pottery Throw Down* (and spin-offs), exhibitions, notable books and documentaries. Works are discussed, never redistributed (spec section 40). | Swoon'd editorial media calendar; Channel 4 and publisher press pages (link-only); TVmaze/TMDB only after licence review | monthly | Evergreen media lessons |
| alerts | **Yes, link-out** | A real, useful "why is everyone posting about lead in a ceramic mug?" explainer: FDA and CPSC notices about ceramicware and imported traditional pottery. | FDA ceramicware and lead pages and recalls; CPSC recalls (public) | daily | Hidden; evergreen `safe-06` |
| conditions | Optional | "Studio near me": open studios and community studios by region (a directory, not a rating). | OpenStreetMap (ODbL; verify craft/shop tags at adapter build); curated | monthly | Hidden |
| news | Light | "Why is everyone talking about this piece, auction, or exhibition?" | Publisher headlines link-only | daily | Evergreen explainers |
| weather, closures, schedules, releases, new-products, regulations | **No** (except a possible seasonal "kiln season" note, curated) | Not needed. Do not invent a clay-price feed or a live auction feed. | none | n/a | n/a |

Structured data (events, alerts) and editorial data (media, culture) are separate systems. Details, licensing, normalized entities and personalization hooks: `live-data.md`.

## 7. Editorial context
- **What commentary helps?** "Why is everyone sharing this exhibition?", "what is a craft fair and why does she plan around them?", "what was that lead-in-ceramics alert and should she care?", "the *Throw Down* finale aired: what can I ask her?", "why is a handmade mug this price?"
- **Appropriate external sources:** NCECA, museums (for exhibition facts, link-only), Channel 4 and press pages, FDA and CPSC for safety alerts, Glazy and Digitalfire-style glaze references (link-only), ceramics magazines and blogs (link-only).
- **Summarize, explain or link?** Explain in Swoon'd's words and link. Never copy publisher text, glaze recipes from proprietary sources, photographs of pots or auction catalogue text. Names of makers and works are facts.
- **Example prompts:** "Why is her feed full of people posting kiln-opening photos?", "What is an Empty Bowls event?", "There is a lead alert on imported ceramics: what does it actually mean?", "The pottery show is back: what can I ask her without spoilers?", "What does 'cone 6' mean on that class flyer?"

## 8. Personalization
| Dimension | How it changes examples and live context | Default when unset | Units using tokens |
|---|---|---|---|
| `style` | Which branch unit is shown (wheel, handbuilding and sculpture, atmospheric, glaze chemistry); examples ("She loves `{{style}}`") | `functional wheel-thrown ware` | `branches`, `studio-culture`, `conversation-lab` |
| `equipment` | Wheel, hand tools, electric kiln, access to a community studio vs home studio: gear talk | `a community studio wheel and a shared kiln` | `wheel-basics`, `drying-and-firing`, `studio-culture` |
| `skill-level` | Depth of explanations; whether tips assume she trims and glazes her own work | `hobbyist` | `wheel-basics`, `why-it-failed`, `conversation-lab` |
| `region` | Local craft fairs, open studios, community studios; regional traditions (Pueblo, Stoke-on-Trent, Bizen) as talking points | `your area` | `now-in-the-studio`, `traditions-and-makers` |

Tokens: `{{style}}`, `{{equipment}}`, `{{skillLevel}}`, `{{region}}`. Every authored sentence must read correctly with the default substituted. Personalization never requires personal data beyond the Person's stated kind of pottery and gear.

## 9. Conversation model
**Example enthusiast lines (12+), each with meaning and what to ask next:**

| # | She says | Means | Implied terms | A good next question |
|---|---|---|---|---|
| 1 | "I opened the kiln and lost two mugs." | Two pieces failed in the firing or cooling | kiln opening, loss rate, dunting | "What happened to them? Did they crack, or did the glaze go wrong?" |
| 2 | "It's leather-hard, I'll trim tomorrow." | The pot is stiff enough to carve, not yet dry | leather-hard, trimming | "How do you know when it's ready to trim?" |
| 3 | "My base S-cracked." | A spiral-shaped crack across the bottom, usually from base compression or uneven drying | S-crack, compression, uneven drying | "Do you compress the floor more, or is it about drying slowly?" |
| 4 | "Bisque came out great." | The first firing worked; the ware is porous and ready to glaze | bisque, absorption | "Are you glazing this week?" |
| 5 | "I'm on cone 6 electric." | Mid-fire, electric kiln, oxidation | cone 6, oxidation, electric kiln | "Do you miss reduction, or is cone 6 enough?" |
| 6 | "The glaze crawled." | Glaze pulled back into beads, leaving bare clay | crawling, dust, thick application | "Was the bisque dusty, or was it too thick?" |
| 7 | "I'm wedging like my life depends on it." | She is preparing clay to remove air and align it | wedging, air bubbles | "Do you use ram's head or spiral?" |
| 8 | "Shino, always shino." | She loves a specific glaze family (thick, carbon-trap, hardy) | shino, glaze effects | "What do you love about it?" |
| 9 | "That's wabi-sabi, I'm not fixing it." | She embraces the imperfection | wabi-sabi | "Is the imperfection your favorite part?" |
| 10 | "Kiln day is like Christmas." | She loves unloading the kiln and seeing results | kiln opening, glaze reveal | "What are you hoping comes out best?" |
| 11 | "I had to reclaim the whole bucket." | She rehydrates scrap clay | reclaim, slop | "Is reclaiming meditative or a chore?" |
| 12 | "The celadon is pooling in the carving." | Green glaze collects in the carved lines, deepening color | celadon, carving, pooling | "Do you carve to catch the glaze on purpose?" |
| 13 | "I need a pyrometric cone or I'm blind." | She wants an independent check of heat work | pyrometric cone, heatwork | "Does the cone tell you what the controller can't?" |
| 14 | "The show was so good this year." | *The Great Pottery Throw Down* or a similar work | works, no spoilers | "No spoilers, but what did you love about it?" |

- **How Swoon'd helps without encouraging fake expertise:** every `say-this` carries a `noFakeExpertNote`; `talk-track` replies rate *curiosity*, *honest gaps*, *asking about her process* and *offering to help* highest; the coach never scripts a claim like "I throw all the time". The most valuable skills are asking "what happened to it?" (diagnosis is her favourite topic) and telling the truth ("I don't know what cone 6 means yet; tell me").
- **Target number of talk tracks and say-this items:** 18 talk tracks at launch (10 standalone Talk-tab scenarios plus unit-end tracks), about 60 `say-this` items.

## 10. Assessment
- **How useful competence is determined:** concept mastery 0..1 per Playbook concept, driven by native exercise outcomes and spaced review (`concept-mastery-v1`); `decision-scenario` scores best/acceptable/poor; **a safety gate**: the `studio-safety` unit's concepts (`silica-dust`, `wet-cleaning`, `kiln-heat-safety`, `glaze-toxic-materials`, `food-safe-glaze`) must be mastered (>= 0.8) before the course reports them as "Mastered"; conversation via talk-track Smooth >= 60.
- **Recognize:** the stages of clay, pot forms and anatomy, tools, surfaces and techniques, common defects (cracks, crazing, pinholes, crawling, warping), glaze effects and colours, famous traditions and makers.
- **Understand:** why clay is wedged, why pots are fired twice, why bone dry matters, why the base and handles crack, why glaze must fit, why kilns cool slowly, why a handmade mug costs what it does, and why studio dust is dangerous.
- **Explain (in a sentence, to her):** "I get that you compress the base so it doesn't S-crack." / "Bisque makes it strong but porous so the glaze sticks." / "The kiln has to cool slowly because the clay can crack on the way down."
- **Correctly interpret:** "S-cracked", "crawled", "pulled the bisque", "cone 6", "wedged", "leather-hard", "bat", "kiln load".
- **Mastery model:** pass threshold **0.8**; safety concepts additionally require a passing decision-scenario set. **Useful competence statement:** "She can talk about her work, understand why she does each step and why pieces crack or come out wrong, tell a bisque pot from a glazed one and a thrown pot from a handbuilt one, ask a couple of good questions about her clay or glaze, and say 'okay, I get why you love this' without faking it."

---

## 11. Curriculum map (ongoing course)

Designed as an ongoing course. **18 units, 117 lessons**, Playbook concepts counted in the Appendix. The unit count exceeds the 8-14 guidance for the same reasons as other courses (P-04); a learner sees about 14 units (core 12 plus live, conversation and review; branch lessons only for the matching branch). All four branches live in one tagged `branches` unit. Ship in phases (release plan below).

Activity abbreviations: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap. Every lesson lists 4 planned activity families; no lesson uses a Unity sim. **Type balance:** no unit lets one type exceed 40% of its activities (validator lint `type-monoculture`); in `why-it-failed` keep `ds` under 40% by using `vi`, `mc`, `bc`, `ht`, `li` for recognition and cause checks.

| Layer | Purpose | Units | Lessons |
|---|---|---|---|
| Foundations | Clay, bodies, wheel, handbuilding, studio safety | 5 | 29 |
| Intermediate | Trimming, drying and firing, glazing, why it failed, the pipeline, reading a pot | 6 | 41 |
| Enthusiast depth | Studio culture and debates, traditions and makers, collecting and art | 3 | 20 |
| Branches | Wheel throwing, handbuilding and sculpture, atmospheric firing, glaze chemistry | 1 (12 tagged lessons) | 12 |
| Current-season / live | Fair season, on screen and on show, the ceramics calendar, ceramicware alerts | 1 | 4 |
| Conversation practice | Talk tracks and say-this | 1 | 7 |
| Perpetual review | Spaced review | 1 | 4 |

### Layer 1: Foundations

**Unit `clay-and-studio`: Clay and the Studio** (prereq: none). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `clay-01` | What clay actually is | Explain clay as tiny plate-shaped particles plus water, and why that makes it moldable. | clay-particles, plasticity, water-in-clay | mc, vi, fg, st |
| `clay-02` | Mud to mug: the big picture | Put the pipeline in order from wet clay to finished piece. | pottery-pipeline, firing-changes-clay | so, mc, tm, st |
| `clay-03` | The stages of clay | Recognise slip, plastic clay, leather-hard, bone dry, bisque and glazed ware. | leather-hard, bone-dry, greenware, slip | vi, tm, mc, ds |
| `clay-04` | A tour of the studio | Name the wheel, wedging table, slab roller, extruder, kilns and glaze room. | studio-zones, slab-roller, extruder | ht, vi, mc, tm |
| `clay-05` | Shrinkage: the quiet rule | Explain that clay shrinks as it dries and fires and why that drives many failures. | shrinkage, drying-shrinkage, firing-shrinkage | es, mc, ds, bc |
| `clay-06` | Pottery, ceramics, ware: the words | Tell pottery, ceramics, greenware and bisqueware apart. | ceramics-vs-pottery, functional-ware, bisqueware | tm, mc, fg, st |

**Unit `clay-bodies`: Clay Bodies** (prereq: `clay-and-studio`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `body-01` | Earthenware, stoneware, porcelain | Classify clay bodies by firing range and character. | earthenware, stoneware, porcelain | tm, mc, vi, ds |
| `body-02` | Cones and firing ranges | Place low, mid and high fire on the cone scale. | cone-ranges, low-mid-high-fire | es, mc, tm, ds |
| `body-03` | Vitrification and absorption | Explain why fired stoneware holds water and terra cotta may not. | vitrification, absorption-rate, porosity | mc, ds, bc, es |
| `body-04` | Grog, paper and other additions | Know what grog, sand and paper fibre do to a clay body. | grog, paperclay, clay-body-additives | tm, mc, ds, vi |
| `body-05` | Choosing a clay | Match a clay body to a mug, a sculpture and an outdoor planter. | choose-clay-body, clay-colour | ds, mc, tm, st |

**Unit `wheel-basics`: Wedging and the Wheel** (prereq: `clay-and-studio`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `wheel-01` | Why we wedge | Explain that wedging removes air, aligns particles and evens moisture. | wedging, air-bubbles, clay-memory | mc, so, ds, bc |
| `wheel-02` | Wedging methods | Tell ram's head, spiral and cut-and-slam apart. | ram-head-wedge, spiral-wedge, cut-and-slam | vi, tm, mc, st |
| `wheel-03` | Anatomy of a wheel | Name the wheel head, bat, splash pan and pedal. | wheel-anatomy, bat, wheel-direction | ht, tm, mc, fg |
| `wheel-04` | Centering | Explain centering as forces and stages, and why it is the hardest step. | centering, coning-up-down, wheel-speed-control | so, ds, mc, st |
| `wheel-05` | Opening and the floor | Order opening the clay and setting a floor, and know why the base is compressed. | opening-clay, compressing-base, floor-thickness | so, mc, ds, ht |
| `wheel-06` | Pulling walls | Explain pulling, wall thickness and water management. | pulling-walls, water-management-throwing, wall-thickness | so, ds, mc, bc |
| `wheel-07` | Shaping, ribs and cutting off | Recognise throwing tools and the steps of finishing a piece on the wheel. | throwing-ribs, wire-cut-off, throwing-vocabulary | vi, tm, so, st |

**Unit `handbuilding`: Handbuilding** (prereq: `clay-and-studio`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hand-01` | Pinch, coil, slab | Name the three core handbuilding methods and what each is good at. | pinch-pot, coil-building, slab-building | tm, mc, vi, ds |
| `hand-02` | Score and slip | Order a proper join and explain why joins fail. | score-and-slip, join-failure | so, ds, mc, bc |
| `hand-03` | Working slabs | Explain even slab thickness and stiffening before assembly. | slab-rolling, slab-stiffness | so, es, mc, ds |
| `hand-04` | Molds and casting | Tell slump, hump and press molds and slip casting apart. | slump-hump-mold, press-mold, slip-casting | tm, vi, mc, ds |
| `hand-05` | Hollow forms and vent holes | Explain why sealed hollow forms need a vent. | vent-hole, hollow-forms, trapped-air-steam | ds, bc, mc, ht |

**Unit `studio-safety`: Studio Safety** (prereq: `clay-and-studio`). 6 lessons. Conservative mainstream guidance; framed as understanding her studio's rules. See section 13.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `safe-01` | Dust is the danger | Explain that dry clay dust carries respirable crystalline silica and why that matters. | silica-dust, respirable-crystalline-silica, silicosis | mc, bc, ds, st |
| `safe-02` | Clean the wet way | Choose wet cleaning over dry sweeping or sanding. | wet-cleaning, hepa-vacuum, no-dry-sweeping | so, bc, ds, mc |
| `safe-03` | Respirators and dry materials | Know that dry-powder handling belongs to trained people with proper controls. | respirator-basics, dry-material-handling | mc, ds, bc, tm |
| `safe-04` | Glaze materials and hygiene | Recognise hazardous glaze materials and studio hygiene rules. | glaze-toxic-materials, studio-hygiene, lead-in-glaze | tm, mc, bc, ds |
| `safe-05` | Kilns are hot | Explain kiln heat, ventilation and why you wait to open one. | kiln-heat-safety, kiln-ventilation, kiln-cooling-wait | ds, bc, mc, ht |
| `safe-06` | "Food safe", honestly | Explain what a food-safe claim requires and why crude or imported ware needs caution. | food-safe-glaze, leachable-lead, ceramic-tableware-caution | ds, bc, mc, st |

### Layer 2: Intermediate

**Unit `trimming-finishing`: Trimming, Handles, and Surface** (prereq: `wheel-basics`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `trim-01` | Leather-hard is the sweet spot | Explain why pots are trimmed at leather-hard and how to test it. | trimming, leather-hard-window | so, ds, tt, bc |
| `trim-02` | Trimming tools | Recognise loop tools, a fettling knife, a needle tool and calipers. | trim-tools, fettling-knife, calipers | vi, tm, ht, mc |
| `trim-03` | The foot ring | Explain the foot, its function and what a thick bottom causes. | foot-ring, thick-bottom-problem, weight-balance | vi, mc, ds, ht |
| `trim-04` | Handles that hold | Order handle making and explain the moisture-match rule. | pulled-handle, handle-attachment-timing | so, ds, mc, vi |
| `trim-05` | Lids, galleries and spouts | Explain how a lid seats and what a gallery does. | lid-gallery, spout-basics | so, vi, tm, ds |
| `trim-06` | Surface at the right stage | Match each decoration to the stage of clay where it is done. | sgraffito, slip-trailing, mishima, underglaze, texture-stamping | so, tm, ds, mc |

**Unit `drying-and-firing`: Drying and Firing** (prereq: `clay-and-studio`, `clay-bodies`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fire-01` | Drying: slow and even | Explain why pieces dry slowly and evenly and how a studio does it. | even-drying, drying-cracks, plastic-cover-drying | so, ds, mc, bc |
| `fire-02` | Bone dry to bisque | Explain what a bisque firing does and roughly where it ends. | bisque-firing, bisque-purpose, bisque-temp-range | so, es, mc, ds |
| `fire-03` | Water smoking and quartz | Place the fragile stages of a firing schedule on a temperature line. | water-smoking, quartz-inversion, firing-schedule | es, so, mc, li |
| `fire-04` | Cones tell the truth | Explain pyrometric cones and heatwork. | pyrometric-cone, heatwork, kiln-controller | vi, mc, ds, es |
| `fire-05` | Loading a kiln | Apply the stacking rules for bisque vs glaze firings. | kiln-loading, kiln-wash, stacking-bisque | ht, ds, so, bc |
| `fire-06` | Oxidation and reduction | Explain how the atmosphere in the kiln changes glaze and clay colour. | oxidation-atmosphere, reduction-atmosphere | mc, ds, tm, vi |
| `fire-07` | Kilns by type | Tell electric, gas, wood, raku and soda kilns apart. | electric-kiln, gas-kiln, wood-kiln, kiln-types | tm, mc, vi, ds |

**Unit `glazing`: Glazing** (prereq: `drying-and-firing`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `glaze-01` | Glaze is glass | Explain glaze as a thin layer of melted glass made of silica, flux and alumina. | glaze-is-glass, silica-flux-alumina | mc, tm, fg, st |
| `glaze-02` | Applying glaze | Compare dipping, pouring, brushing and spraying and why thickness matters. | glaze-application, glaze-thickness, wax-resist | so, ds, mc, vi |
| `glaze-03` | Wet glaze is not final colour | Explain why glazes look chalky and fire to a different colour, and why test tiles exist. | glaze-color-shift, test-tiles | vi, mc, ds, tm |
| `glaze-04` | Colorants | Recognise cobalt, copper, iron, rutile and manganese as colorants and note the hazards. | colorant-oxides, cobalt-blue, copper-green-red, iron-glaze | tm, mc, vi, ds |
| `glaze-05` | Gloss, satin, matte | Compare glaze surface types and matte durability. | glossy-matte-satin, matte-durability | mc, vi, ds, bc |
| `glaze-06` | Layering and effects | Explain layering, breaking, pooling and named effects (celadon, tenmoku, shino). | glaze-layering, breaking-over-edges, glaze-effects | vi, tm, mc, ds |
| `glaze-07` | Glaze fit | Explain that glaze and clay must shrink together and how a mismatch shows. | glaze-fit, coefficient-of-expansion | mc, ds, bc, tm |

**Unit `why-it-failed`: Why Did It Crack?** (prereq: `drying-and-firing`, `glazing`). 9 lessons. **Diagnosis is core (spec section 19 for this course).** Each lesson teaches: stage, location, evidence, likely cause, prevention.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fail-01` | The diagnosis mindset | Diagnose by stage, location and evidence, not by blame. | diagnosis-method, failure-stage, crack-location | ds, mc, so, st |
| `fail-02` | Rim, wall and handle cracks | Explain uneven drying, joins and handle cracks. | rim-crack, uneven-thickness, handle-crack | ds, mc, vi, bc |
| `fail-03` | The S-crack in the base | Explain why the base cracks in a spiral and how compression and drying prevent it. | s-crack, base-compression | vi, ds, mc, bc |
| `fail-04` | Explosions and bloating | Explain trapped moisture, air and over-firing. | kiln-explosion, bloating, over-firing | ds, mc, bc, vi |
| `fail-05` | Dunting | Explain cooling cracks, the fragile temperatures and why kilns are not opened hot. | dunting, cooling-cracks, cristobalite-inversion | ds, so, mc, li |
| `fail-06` | Crazing and shivering | Tell crazing from shivering and link each to glaze fit. | crazing, shivering, crazing-sound | vi, ds, li, tm |
| `fail-07` | Pinholes, blisters, crawling | Tell glaze surface defects apart and link each to cause. | pinholes, blistering, crawling, glaze-running | vi, ds, mc, tm |
| `fail-08` | Warping and slumping | Explain warping from uneven drying and slumping in the kiln. | warping, slumping, plate-warp | ds, mc, vi, bc |
| `fail-09` | The diagnosis tree | Use the full diagnosis tree on mixed cases. | diagnosis-tree, prevention-checklist | ds, ds, so, tk |

**Unit `process-sequence`: The Whole Pipeline** (prereq: `trimming-finishing`, `drying-and-firing`, `glazing`). 6 lessons. **Sequencing is core (spec section 19).**

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `seq-01` | The thrown mug, start to finish | Order every step of a thrown mug and explain each step's why. | sequence-thrown-mug, pottery-pipeline | so, ds, mc, st |
| `seq-02` | The slab-built tray | Order a slab build from rolling to glaze firing. | sequence-slab-build, slab-stiffness | so, ds, mc, bc |
| `seq-03` | The handle timeline | Plan handle making around the moisture of the pot. | moisture-matching, working-in-stages | so, ds, mc, es |
| `seq-04` | A week in the studio | Plan a realistic week: throw, trim, dry, bisque, glaze, fire. | studio-timeline, kiln-turnaround | so, es, ds, mc |
| `seq-05` | What can still be fixed? | Choose the right repair or recycling option by stage. | repair-by-stage, reclaiming-clay, kintsugi | ds, mc, tm, bc |
| `seq-06` | Firings and their order | Explain once-firing, bisque then glaze, and third firings for overglaze and lustre. | once-fire, multiple-firings, overglaze-third-fire | so, mc, ds, tm |

**Unit `reading-pots`: Reading a Pot** (prereq: `clay-and-studio`). 6 lessons. **Visual identification (spec section 18).**

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `read-01` | Forms and anatomy | Name common forms and the parts of a pot from lip to foot. | pot-forms, pot-anatomy | vi, ht, tm, mc |
| `read-02` | Tools by sight | Recognise ribs, wire, needle tool, sponge, calipers, banding wheel and bats. | tools-by-sight, banding-wheel | vi, tm, ht, mc |
| `read-03` | Thrown or handbuilt? | Spot throwing rings, seams and mold-made marks. | throwing-rings, handbuilt-tells, mold-made-tells | vi, ds, mc, bc |
| `read-04` | Spot the surface technique | Recognise carving, sgraffito, mishima, slip trailing, stamping and wax resist. | surface-technique-id, wax-resist-look | vi, tm, mc, ds |
| `read-05` | Defect or design? | Tell an intended effect from a real defect. | defect-vs-feature, intentional-crackle | vi, ds, mc, bc |
| `read-06` | Marks on the bottom | Recognise maker's stamps, stilt marks, cone marks and seconds. | maker-stamp, stilt-marks, seconds | vi, tm, mc, ds |

### Layer 3: Enthusiast depth

**Unit `studio-culture`: Studio Culture and Debates** (prereq: `drying-and-firing`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cult-01` | The community studio | Know how membership, shelves, glaze buckets and wheel schedules work. | community-studio, studio-etiquette, shelf-space | mc, ds, st, tm |
| `cult-02` | Kiln day | Explain the ritual and logistics of loading and opening a kiln. | kiln-opening, kiln-reveal | mc, st, tm, ds |
| `cult-03` | Production potter, studio artist | Understand how pottery is a business, craft-fair culture and production. | production-pottery, studio-potter, craft-fair | mc, st, tk, tm |
| `cult-04` | Cone 6 versus cone 10 | Explain the debate without taking a side. | cone6-vs-cone10 | mc, ds, st, tk |
| `cult-05` | Wheel, hand, function, sculpture | Explain the wheel vs handbuilding and function vs sculpture debates. | functional-vs-sculptural, wheel-vs-hand | mc, st, tk, ds |
| `cult-06` | The "perfect" pot | Explain wabi-sabi, symmetry and handmade vs commercial. | handmade-vs-commercial, wabi-sabi | mc, st, tk, ds |
| `cult-07` | The jargon she'll use | Decode studio slang in context. | studio-slang, bisque-day-lingo | tm, fg, st, mc |

**Unit `traditions-and-makers`: Traditions and Makers** (prereq: `clay-bodies`). 7 lessons. Talks about works and people as facts; never reproduces images or text.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `trad-01` | China and Korea | Connect porcelain, celadon, Jingdezhen and the Korean moon jar. | porcelain-history, celadon, jingdezhen, moon-jar | mc, tm, vi, st |
| `trad-02` | Japan | Connect raku, mingei, wabi-sabi and kintsugi. | raku-origin, mingei, kintsugi-art | mc, tm, st, ds |
| `trad-03` | Tin glaze: Islamic, Italian, Dutch | Connect tin glaze, majolica, Delft and lustreware. | tin-glaze, majolica, delft, lusterware | mc, tm, vi, st |
| `trad-04` | Native American and Mexican traditions | Connect Pueblo pottery, Talavera and barro negro, with respect and caution around lead-glazed ware. | pueblo-pottery, talavera, barro-negro, cultural-respect-pottery | mc, ds, st, tk |
| `trad-05` | The studio pottery movement | Connect Leach, Hamada, Cardew, Rie and Coper. | studio-pottery-movement, leach-hamada | mc, tm, st, ds |
| `trad-06` | Clay goes contemporary | Connect Voulkos, Woodman, Odundo, Perry and de Waal. | contemporary-ceramics, ceramics-as-art | mc, tm, st, tk |
| `trad-07` | Stoke-on-Trent | Explain the Potteries, bone china and transferware. | stoke-potteries, bone-china, transferware | mc, tm, vi, st |

**Unit `collecting-and-art`: Ceramics as Art and Collecting** (prereq: `reading-pots`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `coll-01` | Why handmade costs what it does | Explain time, kiln loss, materials and studio costs behind handmade prices. | handmade-pricing, loss-rate | mc, ds, es, st |
| `coll-02` | Judging a handmade piece | Use weight, balance, lip, foot and glaze coverage to judge a piece. | craft-quality-cues | vi, ht, ds, mc |
| `coll-03` | Buying and starting a collection | Buy what you love from a maker; use marks, fairs and galleries. | collecting-basics, craft-fair-buying | mc, ds, st, tk |
| `coll-04` | Provenance, condition, value | Explain provenance, condition reports and reproductions. | provenance, condition-reports, reproductions | mc, ds, tm, bc |
| `coll-05` | Caring for handmade ware | Explain dishwasher, microwave and thermal-shock care and crazed ware. | ceramic-care, thermal-shock | ds, bc, mc, so |
| `coll-06` | How to look at a pot | Use form, surface and hand to talk about a piece in a museum or shop. | looking-at-ceramics, exhibition-wording | mc, vi, st, tk |

### Layer 4: Branches and personalization

**Unit `branches`: Your Person's Kind of Clay** (prereq: `wheel-basics`, `handbuilding`, `glazing`). 12 lessons; each is tagged by branch and shown only for the matching `branchId` (activity-level `branchId`; the unit is layered `enthusiast` because a `branch`-layer unit requires one unit-level `branchId`; see `NOTES_FOR_ORCHESTRATOR.md`).

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `br-wheel-01` | Throwing forms | Order a throwing progression from cylinder to bowl to pitcher. | throwing-progression, cylinder-first | so, mc, ds, vi |
| `br-wheel-02` | Big, small and altered | Explain throwing off the hump, large forms and altering thrown pieces. | throwing-off-hump, altering-thrown-forms | mc, ds, tm, vi |
| `br-wheel-03` | When it will not centre | Diagnose a wobbling, off-centre or collapsing throw. | wheel-troubleshooting | ds, mc, tk, st |
| `br-hand-01` | Sculptural handbuilding | Explain hollowing, thickness and drying for sculpture. | hollowing-sculpture, sculpture-drying | so, ds, mc, bc |
| `br-hand-02` | Figure and scale | Explain scale, armatures and firing thin or large sculpture. | figurative-ceramics, sculpture-firing | mc, ds, tm, st |
| `br-hand-03` | Talking sculpture with her | Ask good questions about form and intent. | ceramic-sculpture-vocab | tk, st, mc, ds |
| `br-atmo-01` | Raku | Explain the raku process and its thermal-shock and safety limits. | raku-process, raku-crackle | so, mc, ds, vi |
| `br-atmo-02` | Wood, soda, salt and pit | Compare ash, soda and salt vapour and pit firing, and their surfaces. | atmospheric-firing, wood-ash, soda-firing, pit-firing | vi, tm, mc, ds |
| `br-atmo-03` | Talking atmospheric firing | Ask about crews, anagama kilns and long firings. | anagama, kiln-crew | tk, st, mc, tm |
| `br-glz-01` | Recipes and ratios | Read a glaze recipe by weight and percentage and know what a database is. | glaze-recipe, unity-molecular-formula, glaze-database | mc, tm, es, ds |
| `br-glz-02` | Testing: line and triaxial blends | Explain test-tile methods and record keeping. | line-blend, triaxial-blend, glaze-testing | so, mc, ds, vi |
| `br-glz-03` | Talking glaze chemistry | Ask about her tiles without bluffing chemistry. | glaze-nerd-talk | tk, st, mc, ds |

### Layer 5: Current season / live

**Unit `now-in-the-studio`: Now in the Studio** (prereq: `clay-and-studio`; grows with mastery). Templated; refreshed by `live` hooks and editorial cards. 4 lesson templates (each instantiated per season or event).

| Lesson id | Title | Objective | conceptIds | Activities | Live hook |
|---|---|---|---|---|---|
| `now-01` | Fair season and open studios | Know what a craft fair, open studio and Empty Bowls event are near `{{region}}`. | craft-fair-season, empty-bowls, open-studio | mc, ds, st, tm | events (curated) |
| `now-02` | On screen and on show | Know what is on now (shows, exhibitions, books) and why she cares. | current-ceramics-media | mc, st, tk, tm | new-media, events |
| `now-03` | The ceramics calendar | Know the big annual moments, such as the NCECA conference. | nceca-conference | mc, st, tm, ds | events |
| `now-04` | Alert explainer: lead and ceramicware | Understand a ceramicware lead alert and what a person should do. | ceramicware-alerts, leachable-lead | ds, mc, bc, st | alerts (FDA, CPSC) |

### Layer 6: Conversation practice and perpetual review

**Unit `conversation-lab`: Conversation Lab** (prereq: any three foundation units; grows with mastery). 7 lessons; also feeds the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | Kiln opening morning | Respond with curiosity to her kiln-opening report. | convo-follow-up-questions, kiln-opening | tk, st, mc, ds |
| `talk-02` | "It cracked" | Comfort and ask diagnostic questions without pretending. | convo-empathy, diagnosis-method | tk, st, ds, mc |
| `talk-03` | Her glaze obsession | Ask smart questions about glaze without bluffing. | convo-glaze-talk, glaze-effects | tk, st, mc, ds |
| `talk-04` | "Come to the studio" | Accept honestly and offer to carry the clay. | convo-invitation-to-studio, convo-admit-what-you-dont-know | tk, ds, st, mc |
| `talk-05` | Handmade versus cheap | Handle a "why is it expensive" chat with warmth. | convo-value-of-handmade, handmade-pricing | tk, st, ds, mc |
| `talk-06` | Watching the Throw Down | Follow along and ask about what she loves, no spoilers. | convo-watching-together, current-ceramics-media | tk, st, mc, ds |
| `talk-07` | Say-this gauntlet | Decode five lines in a row. | (all layers, sampled) | st, st, st, st |

**Unit `review-loop`: Perpetual Review** (always available after first lesson). 4 lesson templates driven by the review policy.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Daily Bite | 1 card (mc/fg/tm) from due concepts. | (due concepts) | mc, fg, tm, es |
| `review-02` | Weekly mix | 3-round session sampled by weakness. | (weak concepts) | mc, bc, ds, tk |
| `review-03` | Safety check | Always-on refresh of studio-safety concepts; never timed. | silica-dust, wet-cleaning, kiln-heat-safety, glaze-toxic-materials, food-safe-glaze | mc, bc, ds, es |
| `review-04` | Term blitz | Playbook term drill. | (terms) | tm, fg, mc, st |

**Review policy:** Leitner-style intervals 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; a concept below 0.6 re-enters at 1d; **safety concepts** (`silica-dust`, `wet-cleaning`, `no-dry-sweeping`, `respirator-basics`, `glaze-toxic-materials`, `kiln-heat-safety`, `kiln-cooling-wait`, `food-safe-glaze`, `leachable-lead`) re-enter on a shorter cadence (1d, 3d, 7d, 14d, 30d) and never lose the "explain why" step. No timers on safety review.

### Concept targets, personalization slots, release plan

- **Concept count target:** see Appendix (277 ids); 60+ terms drafted with definitions and example lines in `exercises.md` section 3.
- **Personalization slots:** `{{style}}`, `{{equipment}}`, `{{skillLevel}}`, `{{region}}` (section 8).
- **Release plan:**
  - **Launch (v0.1-1.0):** foundations (5 units), intermediate (6 units), `studio-culture`, `traditions-and-makers`, `conversation-lab`, `review-loop`; branches `wheel-throwing` and `handbuilding-sculpture`; `now-in-the-studio` with fair-season and evergreen cards only.
  - **Fast follow (1.1):** `collecting-and-art`, branches `atmospheric-firing` and `glaze-chemistry`, alert and media cards.
  - **Ongoing:** new talk tracks monthly, new live cards each season (fair season, holiday sale season, new show series, NCECA), new lessons from demand (spec section 43): slip casting deep dive, tile and mosaic, kiln building, ceramics business.

### Appendix: Playbook concepts (ids)

`clay-and-studio`: `clay-particles`, `plasticity`, `water-in-clay`, `pottery-pipeline`, `firing-changes-clay`, `leather-hard`, `bone-dry`, `greenware`, `slip`, `studio-zones`, `slab-roller`, `extruder`, `shrinkage`, `drying-shrinkage`, `firing-shrinkage`, `ceramics-vs-pottery`, `functional-ware`, `bisqueware`.
`clay-bodies`: `earthenware`, `stoneware`, `porcelain`, `cone-ranges`, `low-mid-high-fire`, `vitrification`, `absorption-rate`, `porosity`, `grog`, `paperclay`, `clay-body-additives`, `choose-clay-body`, `clay-colour`.
`wheel-basics`: `wedging`, `air-bubbles`, `clay-memory`, `ram-head-wedge`, `spiral-wedge`, `cut-and-slam`, `wheel-anatomy`, `bat`, `wheel-direction`, `centering`, `coning-up-down`, `wheel-speed-control`, `opening-clay`, `compressing-base`, `floor-thickness`, `pulling-walls`, `water-management-throwing`, `wall-thickness`, `throwing-ribs`, `wire-cut-off`, `throwing-vocabulary`.
`handbuilding`: `pinch-pot`, `coil-building`, `slab-building`, `score-and-slip`, `join-failure`, `slab-rolling`, `slab-stiffness`, `slump-hump-mold`, `press-mold`, `slip-casting`, `vent-hole`, `hollow-forms`, `trapped-air-steam`.
`studio-safety`: `silica-dust`, `respirable-crystalline-silica`, `silicosis`, `wet-cleaning`, `hepa-vacuum`, `no-dry-sweeping`, `respirator-basics`, `dry-material-handling`, `glaze-toxic-materials`, `studio-hygiene`, `lead-in-glaze`, `kiln-heat-safety`, `kiln-ventilation`, `kiln-cooling-wait`, `food-safe-glaze`, `leachable-lead`, `ceramic-tableware-caution`.
`trimming-finishing`: `trimming`, `leather-hard-window`, `trim-tools`, `fettling-knife`, `calipers`, `foot-ring`, `thick-bottom-problem`, `weight-balance`, `pulled-handle`, `handle-attachment-timing`, `lid-gallery`, `spout-basics`, `sgraffito`, `slip-trailing`, `mishima`, `underglaze`, `texture-stamping`.
`drying-and-firing`: `even-drying`, `drying-cracks`, `plastic-cover-drying`, `bisque-firing`, `bisque-purpose`, `bisque-temp-range`, `water-smoking`, `quartz-inversion`, `firing-schedule`, `pyrometric-cone`, `heatwork`, `kiln-controller`, `kiln-loading`, `kiln-wash`, `stacking-bisque`, `oxidation-atmosphere`, `reduction-atmosphere`, `electric-kiln`, `gas-kiln`, `wood-kiln`, `kiln-types`.
`glazing`: `glaze-is-glass`, `silica-flux-alumina`, `glaze-application`, `glaze-thickness`, `wax-resist`, `glaze-color-shift`, `test-tiles`, `colorant-oxides`, `cobalt-blue`, `copper-green-red`, `iron-glaze`, `glossy-matte-satin`, `matte-durability`, `glaze-layering`, `breaking-over-edges`, `glaze-effects`, `glaze-fit`, `coefficient-of-expansion`.
`why-it-failed`: `diagnosis-method`, `failure-stage`, `crack-location`, `rim-crack`, `uneven-thickness`, `handle-crack`, `s-crack`, `base-compression`, `kiln-explosion`, `bloating`, `over-firing`, `dunting`, `cooling-cracks`, `cristobalite-inversion`, `crazing`, `shivering`, `crazing-sound`, `pinholes`, `blistering`, `crawling`, `glaze-running`, `warping`, `slumping`, `plate-warp`, `diagnosis-tree`, `prevention-checklist`.
`process-sequence`: `sequence-thrown-mug`, `sequence-slab-build`, `moisture-matching`, `working-in-stages`, `studio-timeline`, `kiln-turnaround`, `repair-by-stage`, `reclaiming-clay`, `kintsugi`, `once-fire`, `multiple-firings`, `overglaze-third-fire`.
`reading-pots`: `pot-forms`, `pot-anatomy`, `tools-by-sight`, `banding-wheel`, `throwing-rings`, `handbuilt-tells`, `mold-made-tells`, `surface-technique-id`, `wax-resist-look`, `defect-vs-feature`, `intentional-crackle`, `maker-stamp`, `stilt-marks`, `seconds`.
`studio-culture`: `community-studio`, `studio-etiquette`, `shelf-space`, `kiln-opening`, `kiln-reveal`, `production-pottery`, `studio-potter`, `craft-fair`, `cone6-vs-cone10`, `functional-vs-sculptural`, `wheel-vs-hand`, `handmade-vs-commercial`, `wabi-sabi`, `studio-slang`, `bisque-day-lingo`.
`traditions-and-makers`: `porcelain-history`, `celadon`, `jingdezhen`, `moon-jar`, `raku-origin`, `mingei`, `kintsugi-art`, `tin-glaze`, `majolica`, `delft`, `lusterware`, `pueblo-pottery`, `talavera`, `barro-negro`, `cultural-respect-pottery`, `studio-pottery-movement`, `leach-hamada`, `contemporary-ceramics`, `ceramics-as-art`, `stoke-potteries`, `bone-china`, `transferware`.
`collecting-and-art`: `handmade-pricing`, `loss-rate`, `craft-quality-cues`, `collecting-basics`, `craft-fair-buying`, `provenance`, `condition-reports`, `reproductions`, `ceramic-care`, `thermal-shock`, `looking-at-ceramics`, `exhibition-wording`.
`branches`: `throwing-progression`, `cylinder-first`, `throwing-off-hump`, `altering-thrown-forms`, `wheel-troubleshooting`, `hollowing-sculpture`, `sculpture-drying`, `figurative-ceramics`, `sculpture-firing`, `ceramic-sculpture-vocab`, `raku-process`, `raku-crackle`, `atmospheric-firing`, `wood-ash`, `soda-firing`, `pit-firing`, `anagama`, `kiln-crew`, `glaze-recipe`, `unity-molecular-formula`, `glaze-database`, `line-blend`, `triaxial-blend`, `glaze-testing`, `glaze-nerd-talk`.
`now-in-the-studio`: `craft-fair-season`, `empty-bowls`, `open-studio`, `current-ceramics-media`, `nceca-conference`, `ceramicware-alerts`.
`conversation-lab`: `convo-follow-up-questions`, `convo-empathy`, `convo-glaze-talk`, `convo-invitation-to-studio`, `convo-admit-what-you-dont-know`, `convo-value-of-handmade`, `convo-watching-together`.

---

## 12. Interaction plan

Tier rubric (`CLAUDE.md` section 4): Unity only where spatial reasoning, movement, physics, timing in a scene or camera perspective materially improves learning and a native exercise would teach it clearly worse. **No row below is Tier A.** Every Unity candidate was evaluated in section 5 and rejected. `unitySimulations` in the manifest is empty; there is no `sims/` folder; `interactionTypes` excludes `unity-sim`.

| Lesson / activity family | Concepts | Type (native exercise) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Diagnosis: "the base spiral-cracked", "the glaze crawled", "it popped in the kiln", "it crazed on cooling" | s-crack, dunting, crazing, crawling, kiln-explosion, diagnosis-tree | `decision-scenario` | Diagnosis is judgment from cues (stage, location, clay, glaze, what changed). Fact sheet plus best/acceptable/poor teaches the *reasoning*, and an `expertNote` teaches what a studio veteran weighs. A sim would only animate a crack. Spec section 17 pattern. Every item carries the stage, and safety items carry a `safetyNote`. | B | ~110 |
| Sequencing: mud to mug, slab build, handle timing, a week in the studio, drying and firing schedule | pottery-pipeline, sequence-thrown-mug, moisture-matching, firing-schedule | `sequence-order` | Order is the concept and each step has a `why` (spec section 19; catalog #4). A "build the mug" game would reward speed instead of order. | B | ~55 |
| Recognition: forms, tools, surfaces, techniques, defects, marks | pot-forms, tools-by-sight, surface-technique-id, crazing, seconds | `visual-id` | Recognition is the skill (spec section 18). Original vector or procedural illustrations only (`original-swoond`); `alt` describes distinguishing features without giving the answer. | B | ~70 |
| Diagrams: wheel anatomy, mug anatomy, foot cross-section, kiln stacking, drying cross-section, time-temperature chart | wheel-anatomy, foot-ring, kiln-loading, quartz-inversion | `hotspot-tap` | Static diagram with correct regions; motion is not the concept (catalog #13). | B | ~35 |
| Rule and fact checks (why wedge, why bisque, what glaze is, what cone 6 means) | most | `multiple-choice` | Default recall/understanding card; distractors are the misconceptions in section 2. | B | ~150 |
| Safe / not safe, true / myth calls (dry sweeping, sealed hollow form, dishwasher) | wet-cleaning, vent-hole, ceramic-care | `binary-call` | Two-way judgments; `scene.kind` is `none` or `image` (procedural). | B | ~50 |
| Vocabulary and pairs (clay stages, colorants, kiln types, traditions) | leather-hard, colorant-oxides, kiln-types, tin-glaze | `term-match`, `fill-the-gap` | Recall and recognition in context. | B | ~30 + ~30 |
| Sounds: ring of sound vs cracked bisque, kiln pinging as glaze crazes | crazing-sound, bisque-firing | `listening-id` | The ring test and kiln pinging are real studio cues. Original or synthesized audio (`original-swoond`); text alternative and Skip always available. | B | ~8 |
| Numbers: cone temperatures, shrinkage percent, wall thickness, hours to cool, bisque hold | cone-ranges, shrinkage, quartz-inversion, kiln-turnaround | `estimate-slider` | Numeric intuition; closeness matters. Safety numbers use tight tolerances or none. | B | ~30 |
| Feel: the leather-hard trimming window | leather-hard-window | `timing-tap` | Only a 1D rhythm; slow mode always on; explicitly *not* speed pressure. | B | ~3 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice: 18 talk tracks and ~60 say-this items. | B | 18 + ~60 |

**Native exercise types used:** multiple-choice, binary-call, term-match, sequence-order, visual-id, decision-scenario, talk-track, timing-tap, say-this, fill-the-gap, listening-id, estimate-slider, hotspot-tap (all 13; `timing-tap` and `listening-id` used lightly). **`unity-sim` unused.** Estimated total native items about 650 across 117 lessons and the review loop.

**Accessibility:** `listening-id` always has a text alternative and Skip; `visual-id` `alt` describes distinguishing features without revealing the answer; `timing-tap` uses `tap-to-stop-slow`; no exercise relies on colour alone (glaze colour items use names and labels).

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| Imagery | Procedural or original illustration only (`license: original-swoond`): wheel, mug anatomy, forms, tool silhouettes, cone chart, drying cross-sections, kiln stacking, test tiles, defect illustrations, glaze-effect swatches. **No third-party photographs** of pots, potters, museum objects, studios or kilns. |
| Audio | Original or synthesized studio sounds (ring test, kiln ticks, kiln pings, wheel). No TV, video or podcast audio. |
| Logos / trademarks | Clay, kiln, wheel and glaze brands (for example Laguna, Amaco, Skutt, Brent, Shimpo, Orton) appear only as text where a lesson needs them; no logos. Awards, conferences and TV titles as text and link-outs. |
| Video | No embedded show or clip video; deep-link to official pages. |
| Article text | Never copied; Swoon'd writes its own explainers and links (spec sections 11 and 40). |
| Glaze recipes | Recipes are shared craft knowledge but many sources are copyrighted or proprietary; Swoon'd shows only simple original teaching examples and never reproduces a published recipe set. |
| Museum and artwork content | Works and artists are named as facts (spec section 40); no image reproduction, no gallery catalogue text, no fabricated quotes. Contemporary artists appear as facts only, no likeness. |
| Data terms | FDA and CPSC alerts are public US-government sources (verify terms at adapter build). OpenStreetMap needs ODbL attribution if used. TVmaze/TMDB need licence review. |
| Player likeness | N/A. Judges, hosts and contestants named as facts only; no likeness. |
| Cultural heritage | Traditions (Japanese, Korean, Pueblo, Mexican and others) are described as living practices with respect. Sacred, ceremonial and community-owned designs are never treated as decoration or replicated; learners are told to buy from and credit makers. |

**Safety (conservative mainstream guidance; state in manifest `safetyConstraints`; Swoon'd builds appreciation and understanding, not a substitute for studio instruction):**
- **Silica dust.** Dry clay and many glaze materials contain crystalline silica, and repeated inhalation of respirable dust can cause silicosis and other serious lung disease. OSHA's workplace limit is 50 ug/m3 (8-hour average) with an action level of 25 ug/m3 (verified 2026-09-30). Studios manage this by wet cleaning (damp sponges and mops, HEPA vacuums), no dry sweeping or dry sanding, covered clay, and controlled mixing. The course teaches *why*, not how to substitute for a studio's rules. Never suggest dry sweeping, blowing dust, or dry sanding greenware.
- **Respirators.** Where dust cannot be controlled, respirators must be properly fitted; the course teaches that dry-powder handling (mixing glaze, sanding) belongs to trained people with proper ventilation. Never present a paper dust mask as adequate for silica.
- **Glaze materials.** Hazards include barium carbonate, lithium, manganese, chromium, cadmium and selenium colourants, nickel and lead-containing frits or old glazes. Swoon'd never encourages mixing or spraying glazes at home without training and controls; wash hands; no food or drink in the studio; keep children and pregnant people away from raw materials and dust (ask the studio).
- **Kilns.** Kilns reach roughly 1,800 to 2,400 F: burn, fire and fume hazards (sulfur, carbon monoxide from fuel-fired kilns, fumes from organic burnout and some glazes). Only trained people load, fire or unload kilns; never open or unload a hot kiln; surfaces stay hot for a long time. Kiln ventilation is not optional. Never teach home kiln installation, wiring or firing; that is an electrical and fire-code job. Raku and atmospheric firing involve open flame, thermal shock and smoke; taught as *how it works and what she means*, never as a how-to.
- **Food-safe claims.** "Food safe" requires a lead-free, properly formulated, fully melted glaze; unfired, underfired or badly fitted glaze can leach. Lead and cadmium can leach from crude, antique, imported or decorative ware (FDA guidance; traditional Mexican pottery labelled "lead free" has been found with high extractable lead). The course teaches to *ask the maker* and *avoid using decorative, crude, antique or unknown-source ware for food or drink*; it gives no medical advice and never certifies anything.
- **Trimming and tools.** Sharp loops and knives: no speed scoring; never gamify tool handling.
- Swoon'd never encourages the learner to fake pottery skill or claim credit for a piece they did not make. Voice: jokes target the learner's ignorance, never the crush, never her cracked pot, never her studio, never "hobby" vs "art" hierarchies.

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Wheel, mug anatomy, foot cross-section, pot forms, tool silhouettes | Procedural / original vector | Swoon'd | `original-swoond` |
| Clay-stage ladder (slip to glazed), drying cross-sections | Procedural | Swoon'd | `original-swoond` |
| Defect illustrations (S-crack, dunt, crazing, shivering, crawl, pinhole, blister, warp) | Original vector | Swoon'd | `original-swoond` |
| Kiln stacking cross-section, time-temperature chart with cones | Procedural | Swoon'd | `original-swoond` |
| Glaze-effect swatches and test-tile illustrations | Original vector | Swoon'd | `original-swoond` |
| Ring test, kiln ticks, kiln pings, wheel hum | Synthesized / recorded in-house | Swoon'd | `original-swoond` |
| Event, media and alert cards | Data cards, no images | Curated | n/a |

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** What clay is, the stages and pipeline, bodies and cones, wedging and the wheel, handbuilding, and studio safety (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Kiln loads, what failed and why, glazes, cones, studio life, traditions and makers, debates (section 4).
- [x] 3. **What current information matters?** Craft-fair season, open studios, the ceramics calendar, what is on screen, ceramicware alerts (section 6). No scoreboard data.
- [x] 4. **What should be interactive?** Sequencing the pipeline, diagnosing cracks and defects, visual and hotspot recognition, sound cues, estimates, conversation; zero Unity sims (sections 5, 12).
- [x] 5. **What should NOT be gamified?** Studio safety, food-safe claims, kilns, glaze mixing, her pieces, cultural traditions, auctions (section 5).
- [x] 6. **How should it personalize?** style, equipment, skill level, region (section 8).
- [x] 7. **What does conversational competence look like?** Decode her kiln and glaze stories, ask honest process questions, admit gaps, offer to help (sections 9, 10).
- [x] 8. **What data providers are needed?** Curated calendars, FDA and CPSC alerts (link-out), optional OpenStreetMap studio finder, publisher links (`live-data.md`).
- [x] 9. **What licensing constraints apply?** Original art and audio only, no reproductions of works, trademark text-only, cultural heritage care (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, safety gate, review ladder, talk-track Smooth >= 60, competence statement (section 10).

Additional gates: [ ] manifest validates (run `tools/validate`); [ ] curriculum validates (not yet authored); [x] no Unity sims, so no sim specs to approve; [ ] every image/audio asset has a license id (assets not yet produced; ids defined); [ ] **safety review of `studio-safety`, `fire-05`, `br-atmo-01` and `now-04` by a qualified reviewer (ceramics studio safety or industrial hygiene) before release**; [ ] cultural review of `trad-01` to `trad-04` (recommended); [ ] voice review; [x] no copied publisher text (all copy original).

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Approve zero Unity sims for pottery (rationale in sections 5 and 12). Any candidate to re-open must name the concept, the failing native design and the rubric signal. | Product | No |
| 2 | Safety review by a qualified reviewer (studio safety or industrial hygiene) of dust, respirator, kiln, glaze-material and food-safe copy before release. | Product/Content | Yes for release |
| 3 | Cultural review of `trad-01` to `trad-04`: naming, respectful framing of Pueblo, Korean and Japanese traditions, no sacred items. | Product/Content | No |
| 4 | Unit count 18 (5+6+3+1+1+1+1) exceeds 8-14; approve (P-04) or fold `collecting-and-art` into `studio-culture`. | Product | No |
| 5 | The `branches` unit uses layer `enthusiast` with activity-level `branchId` (one unit, 12 tagged lessons). Confirm, or authorize four `branch`-layer units. | Product | No |
| 6 | Launch branch set: `wheel-throwing` and `handbuilding-sculpture` at launch, `atmospheric-firing` and `glaze-chemistry` at 1.1? | Product | No |
| 7 | Studio finder: is an OpenStreetMap-based directory acceptable (ODbL, coverage gaps), or link-only? | Data/Legal | No |
| 8 | Ceramicware alert card: confirm FDA and CPSC terms and whether Swoon'd may show summaries (link-out default). | Legal/Data | No |
| 9 | Media accuracy (Throw Down series 9 winner, celebrity spin-off dates, NCECA dates): re-verify at release; who owns the media refresh? | Content | No |
| 10 | Original audio: synthesize or record in-house the ring test and kiln pings? | Product | No (synthesize for MVP) |
