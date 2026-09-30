# Course Design Specification: Photography (`photography`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/*.md`, `NOTES_FOR_ORCHESTRATOR.md` |

Time-sensitive facts (camera launches, film stocks, content-credential support, prices) were checked by web search on 2026-09-30, mostly against secondary trade media, and are tagged **[verify at release]**. Lesson copy never hard-codes them; the live layer carries them (see `live-data.md`). Optics, exposure and composition facts are evergreen and are stated as such.

---

## 1. Identity

- **Course ID:** `photography` (immutable)
- **Display name:** Photography
- **Category / family:** Arts > Photography (family `Arts`)
- **Simulation prefix:** `photo`
- **Three lenses, one course.** The person you care about may be (a) a **maker** who shoots and edits, (b) a **gear person** who lives in reviews, forums and lens debates, or (c) a **looker** who loves the art and history. Usually she is a bit of all three. The course is built so each foundation unit teaches what a maker experiences (light, exposure, focus, lenses, framing), because gear talk and photo critique are only legible once you know what the knobs do to the picture. Branches then tilt examples toward *what* she shoots.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Hiking (`hiking`) and Camping (`camping`) | Landscape and wildlife photographers spend a lot of time outdoors, but knowing trails and weather tells you nothing about f-stops, filters or composition. The reverse is also true. | Adjacent, independent | Shared weather/conditions adapter and the safety voice; cross-link `land-04`/`land-05` to hiking; no shared lessons. |
| Movies (`movies`) | Cinematography shares vocabulary (aperture, focal length, colour grading, lighting patterns) but a still-photo enthusiast talks about single frames, prints, gear and light on location; a film fan talks about story, directors, releases. | Adjacent, independent | Cross-link `focal-length`, `lighting-patterns`, `color-grading`; do not merge. |
| Cars (`cars`), Fashion (`fashion`) | She may photograph cars or fashion, but the photography knowledge is genre practice (light, lens, posing), which this course owns; the subject matter is theirs. | Independent | Mention as example subjects only. |
| Pottery, Cooking, other crafts | Food and craft photography reuses light and composition. | Independent | Cross-link light lessons from those courses to `light-and-flash` when authored. |
| Genres (portrait, street, landscape, wildlife) | Learning core photography makes you conversationally competent about each genre's *technique*; each genre has its own culture, ethics and gear. | Shares foundation | Modelled as branches, not courses. |
| Film photography | Same optics and composition, but a different workflow (exposing, developing, scanning), economy and community. | Shares foundation (medium branch) | Branch `film`, not a separate course. Digital learners still get film literacy through `photo-culture-and-debates`. |
| Video / videography | Shares lenses and exposure but adds motion, sound, editing. | Independent (not scheduled) | Out of scope; mentions only. |

- **Branches:**

| id | Name | What changes |
|---|---|---|
| `portrait` | She shoots people | Lens choice for faces, light patterns, posing and consent, eyes and catchlights, retouching honesty. Uses all three sims in genre context. |
| `street` | She shoots the street | Candid work, zone focus, small cameras, timing, ethics and etiquette, local law caution. |
| `landscape` | She shoots landscapes | Weather and light planning, tripods, hyperfocal focus, filters, long exposure, safety and Leave No Trace. |
| `wildlife` | She shoots wildlife and birds | Reach, shutter speed for movement, tracking autofocus, fieldcraft, animal-first ethics. |
| `film` | She shoots film | Emulsions and looks, exposing film, formats, development and scanning, cost and culture. |

No branch chosen = core course only (default). Choosing a branch sets personalization dimension `genre`. A learner may add several branches; the app shows the core units plus each chosen branch unit.

---

## 2. Beginner model

**What a complete beginner knows.** "Cameras have a lens and a button." That a phone camera is good now, that "portrait mode" blurs the background, that "DSLR" means a big serious camera, that Instagram filters exist, that "the golden hour" is a thing people say. They may own an iPhone and shoot in Auto. They probably think megapixels equal quality and that the expensive camera takes the good pictures.

**Terminology that confuses:** aperture, f-stop, f/1.8, stop, shutter speed, ISO, exposure, bokeh, depth of field, focal length, 50mm, full frame, crop sensor, APS-C, mirrorless, DSLR, prime, zoom, RAW, white balance, histogram, highlights and shadows, "blown out", "shooting wide open", "stopping down", "fast lens", "glass", "sharpness", "rule of thirds", "leading lines", "negative space", "SOOC", "GAS", "the trinity", "L-series", "film simulation", "Lightroom", "presets", "grain", "Portra".

**Common misconceptions (each is a lesson beat):**
1. "A better camera makes better photos." Light, timing and composition dominate; gear widens what is possible.
2. "More megapixels means better quality." Sensor size, lens and technique matter more; resolution helps cropping and big prints.
3. "Telephoto lenses compress the scene." Compression is an effect of *where you stand*; a long lens makes you stand farther back to keep the subject size (`perspective-compression`).
4. "Bokeh comes from an expensive lens only." Blur depends on aperture, focal length, subject distance and background distance together (`depth-of-field`).
5. "Wide-open (f/1.4) is always the sharpest or best." It is the shallowest depth of field and often a little soft; the sweet spot is usually stopped down.
6. "Higher ISO is bad." Noise is the price of a fast shutter in dim light; a sharp noisy photo beats a blurry clean one.
7. "Auto mode gives the correct exposure." The meter aims for middle grey, so snow goes dull and black cats go grey (`exposure-compensation`).
8. "Full frame is just better." It has a larger sensor (less noise, shallower depth of field at the same framing) but is bigger, heavier and costlier; many pros shoot smaller formats.
9. "Sharp means good." A soft, moody photo can be the point; a razor-sharp boring photo is still boring.
10. "The rule of thirds is a law." It is a starting tool; great photographs break it deliberately.
11. "Editing is cheating." Every photograph is edited, by the camera, the film lab or the photographer; the debate is about *honesty* and disclosure, not editing itself (`edit-honesty`).
12. "Film is dead." It is small but growing, and prices have risen [verify at release].
13. "I can photograph anyone in public, no questions." Law varies by country and context, and ethics run deeper than law; asking is the default.

**Concepts that unlock the rest (become foundation units):** light (hard/soft, direction, colour), the exposure triangle and the *stop*, focus and depth of field, focal length and perspective, and framing. With those five, almost everything she says about a shoot becomes decodable.

---

## 3. Foundational knowledge

Grouped into modules (become `foundationalModules[]` and foundation units).

| Module (unit id) | Content |
|---|---|
| `seeing-light` | A photograph records light. Hard vs soft (source size relative to subject; shadow edge), direction (front, side, back), golden hour and blue hour (roughly sun 0 to 6 degrees above the horizon; roughly 4 to 8 below), colour temperature (Kelvin: candle about 1900 K, tungsten about 3200 K, daylight about 5500 K, shade about 7000 K), white balance, dynamic range and clipping. |
| `exposure-triangle` | Exposure as total light on the sensor. Aperture (f-number; f/1.4, 2, 2.8, 4, 5.6, 8, 11, 16, 22 each halve the light), shutter speed (each doubling halves the light; motion blur; hand-holding rule of thumb 1/focal length), ISO (base ISO, noise), the stop as shared unit, reciprocity, modes (P, A/Av, S/Tv, M, auto ISO), metering (matrix/evaluative, centre-weighted, spot), 18% grey, exposure compensation. |
| `focus-and-depth` | Autofocus (single vs continuous, AF area, subject and eye detection), focus vs motion blur vs camera shake vs diffraction, depth of field (aperture, focus distance, focal length, sensor size), circle of confusion, bokeh quality, hyperfocal distance, zone focusing. |
| `cameras-and-lenses` | Kinds of camera (phone, compact, mirrorless, DSLR, medium format, film), sensor sizes (full frame 36 x 24 mm; APS-C crop about 1.5 to 1.6; Micro Four Thirds 2.0; 1-inch 2.7; medium format larger), megapixels, RAW vs JPEG, focal length and field of view, crop factor and equivalence, perspective and compression, wide-angle distortion, primes vs zooms, lens speed, stabilisation (in-body and in-lens), phone cameras and computational photography (multi-frame HDR, night mode, portrait-mode depth maps, ProRAW-type formats). |
| `composition` | Framing is choosing what to exclude. Thirds and their limits, lines and shapes, foreground/middle/background layers, negative space and balance, edges and clutter, simplifying, tonal balance. |
| `light-and-flash` (intermediate) | Window light, modifiers (softbox, umbrella, reflector, diffuser), lighting patterns (butterfly, loop, Rembrandt, split, rim, broad and short), catchlights, on-camera flash and bounce, off-camera flash, sync speed, inverse-square law. |
| `motion-and-tricky-light` (intermediate) | Histogram, expose to the right, bracketing and HDR, backlit and snowy scenes, freezing vs blurring motion, panning, long exposure, ND filters, night and low light. |
| `editing-and-color` (intermediate) | RAW workflow, global adjustments, highlights/shadows, white balance, HSL and colour grading, vibrance vs saturation, crop and straighten, sharpening and noise reduction (including AI denoise), presets and "looks", culling, honesty. |
| `gear-culture` (enthusiast) | Sensor-format debates, mirrorless vs DSLR, mounts and ecosystems, third-party lenses, primes vs zooms, "lens character", the "holy trinity" of zooms, GAS, "gear doesn't matter", used gear and rentals, brand personalities. |
| `critique-language` (enthusiast) | How to look at a photograph, technical vs aesthetic critique, the vocabulary (tonality, separation, rendering, gritty, clinical, moody), what makes a photo work, kind and specific feedback, receiving critique, series and editing. |
| `photo-culture-and-debates` (enthusiast) | History and canonical work described in words, decisive moment, landscape tradition and the zone system, colour photography's rise, manipulation and AI, ethics, social media era. |
| Branch units | Portrait, street, landscape, wildlife, film (section 11). |

**Current facts (verified by search 2026-09-30, secondary media; [verify at release]) that shape the enthusiast layer:**
- **Kodak film restructure.** Eastman Kodak took direct distribution of its still film from Kodak Alaris starting September 2025; a March 2026 trade report says the Portra range was re-branded Ektacolor Pro (160, 400, 800), with black and white stocks also renamed. Whether the "Portra" name persists in shops, and current prices (35 mm roughly 15 to 22 US dollars per roll for Portra-class stock in 2026 retail listings), must be re-checked. Lessons teach the *look* and role of the stock and treat brand names as changeable; the live layer carries the naming and price snapshot.
- **Content credentials (C2PA).** By mid-2026 several makers (Sony, Leica, Nikon, Canon, Fujifilm, Panasonic) support or have announced signing at capture, with uneven maturity; a Nikon signing service had a vulnerability and its certificates were revoked in 2025, with the service reported as not restored as of May 2026. Teach the *idea* (provenance, not proof of truth) and re-verify support at release.
- **Camera cycle.** The trade press in 2026 reports a busy launch calendar (Canon EOS R6 Mark III in late 2025; Sony a7R VI and a Canon R6-generation body announced around 13 May 2026; a Fujifilm X-T-series body rumoured for autumn 2026). None of it is asserted in evergreen lessons.
- **Mirrorless is the centre of gravity.** The major makers have largely stopped developing new DSLRs; DSLRs are a used-market story. [verify at release]
- **Computational photography** on phones (multi-frame stacking, night modes, generative fill in editors) is the biggest change in how most people make pictures and drives debates about authenticity.

---

## 4. Enthusiast model

**What enthusiasts talk about:**
- Last weekend's shoot: the light, the location, "I got up for the sunrise and it clouded over", keepers vs rejects.
- Gear: the new lens, the new body, the mount, the "trinity", whether to go mirrorless, prime vs zoom, a used lens find, rentals, "I'm resisting GAS".
- Technique: shooting wide open, backlit portraits, panning, long exposures, focus stacking, birds in flight autofocus, metering for highlights.
- Editing: Lightroom, presets, film simulations and recipes on Fujifilm, the "look", denoise, SOOC.
- Genres and heroes: a favourite photographer, a photobook, a print sale, an exhibition.
- Community: contests, feedback groups, Instagram reach, photo walks, "photo dumps".

**Distinctions that matter to them:** exposure vs brightness in editing; sharpness vs resolution vs "rendering"; bokeh quality vs amount; full frame vs crop vs medium format; prime vs zoom; mirrorless autofocus vs DSLR; colour science vs editing; negative vs slide film; digital vs film looks; candid vs staged; documentary vs fine art.

**Knowledge that signals real understanding:** that perspective comes from position and not from focal length; that noise is signal-to-noise and depends on total light gathered; that "equivalent" apertures explain why crop-sensor depth of field is deeper; that the meter aims for grey; that histograms are the truth, screens lie; that most critique language is about light, moment and edit, not gear; that gear talk is often a way to talk about wanting to make more pictures.

**Beginner statements that sound obviously uninformed:** "What camera did you use? Because these are amazing"; "Just put it on Auto and click"; "Why don't you just buy a better lens?"; "Is the blurry background from Photoshop?"; "More megapixels is better, right?"; "Film? Like, from the old days?"; "You must have a great camera" (the classic backhanded compliment); "Can you make it look less edited?"

**Common controversies and debates:**
1. **Gear vs vision.** "Gear doesn't matter" vs "gear matters, you just need less than you think."
2. **Full frame vs APS-C vs Micro Four Thirds vs medium format** and the myth of "you need full frame".
3. **Mount lock-in and third-party lenses** (who may make autofocus lenses for which mount; adapters; firmware locks).
4. **Megapixel race and file size**, "do I need 60 MP?"
5. **Mirrorless vs DSLR** (largely settled, still emotional for optical-viewfinder fans).
6. **Phone vs camera** and computational photography.
7. **AI in editing** (denoise, generative fill, sky replacement), disclosure, **content credentials**, and photo contests disqualifying AI-generated or over-manipulated work.
8. **Film vs digital**, the price of film, "film look" presets vs the real thing.
9. **Street photography ethics**: candid photos of strangers, consent, children, legality by country.
10. **Wildlife ethics**: baiting owls, flushing birds, geotagging nests.
11. **Sharpness worship** ("pixel peeping") vs feeling, and lens "character".
12. **Instagram look** (over-saturated, orange-teal, the "Lightroom preset" look) vs classical tonality.
13. **Sunrise/sunset "spot" overcrowding** and social-media-driven overtourism at landscape locations.

---

## 5. Interaction model

**What she experiences instead of reading.** Photography is the art of *controlling what a camera sees*. Most of it can be experienced as a picture, a number or a choice, which native exercises do well: estimating exposure in stops, spotting hard vs soft light, recognising a composition, choosing settings for a described scene, decoding gear talk. A few concepts are genuinely about **moving a camera or a light in a three-dimensional scene and watching the image change continuously**; three of those are promoted to Unity (section 12).

**Sims considered and decided (full rationale in section 12):**

| Candidate | Verdict |
|---|---|
| Perspective compression and field of view (move the camera, change focal length, keep the subject the same size) | **Unity** `photo.lens.compression-lab.v1` |
| Depth of field (aperture, focus distance, focal length, camera distance, on a 3D scene) | **Unity** `photo.focus.depth-of-field.v1` |
| Light direction, size and distance sculpting a 3D face and object | **Unity** `photo.light.direction-lab.v1` (weakest case; first to downgrade after playtest) |
| Exposure triangle (aperture, shutter, ISO) | **Native** (`estimate-slider`, `decision-scenario`, `sequence-order`, `visual-id`); the concept is arithmetic in stops and trade-offs, a number is the lesson |
| Shutter speed and motion blur | **Native** (`visual-id` on strips, `estimate-slider`, `timing-tap`) |
| Composition | **Native** (`hotspot-tap`, `visual-id`, `binary-call`); static images are the medium |
| Editing sliders | **Native** exercises on original images; no sim |

**Native carries the rest:** light reading (visual-id, hotspot-tap), exposure logic (estimate-slider, fill-the-gap, sequence-order), scenario judgment ("golden hour in 40 minutes, clouds building, one lens"; decision-scenario), gear vocabulary (term-match, say-this), critique language (say-this, talk-track), shutter sounds (listening-id), film process (sequence-order), ethics (decision-scenario).

**Should NOT be gamified:** critiquing another person's real photos (no scoring of a beauty contest); "gear scores" or rankings of cameras and brands; anything that encourages photographing a real person without consent (including the learner's crush); "likes"-style feedback; deciding that a photograph is good or bad as a single number. The goal is understanding *why* she loves it, not judging it. Nothing that encourages faking a skill level.

---

## 6. Dynamic information requirements

Photography has a **modest but genuinely useful** live layer, different in kind from sports: not scores, but *conditions and news*. Detail in `live-data.md`.

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| conditions (sun, moon, twilight, aurora) | Yes | "Golden hour is at 7:12 tonight" and "there's a full moon" are the most natural photography facts; computed, not fetched | On-device astronomy calculation; NOAA SWPC (public) for aurora | daily | Evergreen card ("what golden hour is") |
| weather | Yes (with region) | Clouds decide the sunset; fog and mist decide the landscape | NWS (public, US), Open-Meteo (commercial plan) via the shared adapter | hourly | Hidden |
| events | Yes | Meteor showers, eclipses, awards seasons, trade shows | NASA and IMO calendars (curated); awards sites (curated, link-out) | monthly | Snapshot |
| releases | Yes | New cameras and lenses drive gear conversation | Manufacturer press pages (curated) | weekly | Snapshot with date shown |
| new-products | Light | Film and software news (renames, price moves, AI tools) | Kodak, Ilford, Fujifilm, Adobe, Capture One release pages (curated) | monthly | Skip |
| news | Yes | "Why is everyone talking about X?" | RSS headlines link-only; Swoon'd explainers | daily | Evergreen explainers |
| alerts | Optional | Aurora watch, severe weather; always with a safety line | NOAA SWPC, NWS | hourly | Hidden |
| scores, standings, rankings, rosters, statistics | **No** | There is no scoreboard in photography; do not invent one (spec section 10) | n/a | n/a | n/a |
| closures | No (defer to hiking adapter) | Locations and permits are hiking/camping concerns | n/a | n/a | n/a |

---

## 7. Editorial context

- **What commentary helps:** why a launch matters to her kind of shooting; what a mount or firmware fight means for lens buyers; what a film stock rename means for her shoebox of Portra; why an AI feature or a contest disqualification is controversial; what content credentials are and are not.
- **Appropriate sources:** manufacturer press pages, independent photography publications, awards and museum sites, NASA and NOAA. Link-only ingestion of headlines; licence decision open (L-01, DECISIONS Q-3).
- **Summarize, explain or link?** Explain in Swoon'd's own words and link. Never copy review or press text. Never reproduce award-winning photographs or press images; describe in words and link to the photographer or awarding body.
- **Example prompts:** "Why are photographers arguing about lens mounts this week?"; "What did that camera launch actually change?"; "Why did Kodak rename its film?"; "What is a content credential and why do photographers care?"; "Why is the moon 'special' tonight?"; "What's a 'supermoon' shot and how do people take it?"; "Why did that photo lose its award?"

---

## 8. Personalization

| Dimension | Values | Effects | Default | Units using tokens |
|---|---|---|---|---|
| `equipment` | Her camera (phone, mirrorless brand, film camera, "I don't know") and mount, normalized from free text | Examples use her kind of camera; gear talk tracks name her system; "does that lens fit?" cards; live release feed prioritises her mount | "her camera" (generic) | `cameras-and-lenses`, `gear-culture`, `now-in-photography`, `conversation-lab` |
| `brand` | Canon, Nikon, Sony, Fujifilm, Leica, OM System, Panasonic, Pentax, Sigma, Kodak, Ilford, Apple/Google/Samsung (phones) | Brand-personality lesson framing, live release news, film-stock examples | none (neutral) | `gear-culture`, `now-in-photography` |
| `genre` | portrait, street, landscape, wildlife, film (branches) | Adds branch units, examples and live cards (sky events for landscape, awards for wildlife) | none = core only | branch units, `conversation-lab` |
| `region` | City or coordinates (optional) | Sun/moon/twilight times, weather, local sky events, aurora likelihood | none (evergreen phrasing) | `now-in-photography`, `land-04` |
| `style` | Moody, bright and airy, black and white, film look, documentary, minimalist; optional favourite photographer name | Which critique-vocabulary examples come first; conversation openers ("what draws you to that look?") | none | `critique-language`, `conversation-lab` |
| `skill-level` | Just starting, hobbyist, serious amateur, working pro | Which depth of gear talk appears; how technical talk-track lines are | hobbyist | `gear-culture`, `conversation-lab` |

Tokens: `{{equipment}}`, `{{brand}}`, `{{genre}}`, `{{region}}`, `{{style}}`, `{{skillLevel}}`. Unset tokens fall back to generic phrasing ("her camera", "her favourite photographer"), never blank text. The foundation curriculum is unchanged by personalization.

---

## 9. Conversation model

**Ten-plus things an enthusiast might say, with translations** (each becomes a say-this or talk-track):

| # | Line | Meaning | Terms implied | Good next question |
|---|---|---|---|---|
| 1 | "I got up for golden hour and it clouded over." | The best low warm light didn't happen; she got flat light. | golden-hour, hard-soft-light | "Was the flat light still workable, or did you pack up?" |
| 2 | "I shot it wide open at 1.8." | Widest aperture, very shallow depth of field, lots of blur. | aperture, depth-of-field | "Did you nail focus on the eyes?" |
| 3 | "I had to bump the ISO to 3200 and the noise is bad." | Not enough light; higher sensitivity added grain. | iso, noise | "Did the noise reduction help in editing?" |
| 4 | "My highlights were totally blown." | The bright parts lost all detail. | blown-highlights, dynamic-range | "Was it the sky or the skin?" |
| 5 | "I'm eyeing the 35mm prime, but I already have too much glass." | She wants a new fixed lens and is joking about GAS. | prime-lens, gas | "What would the 35 do that your zoom doesn't?" |
| 6 | "Full frame or APS-C? I keep going back and forth." | Sensor size dilemma for her next camera. | sensor-size, crop-factor | "What do you mostly shoot?" |
| 7 | "This one's SOOC, no edits." | Straight out of camera, JPEG as shot. | sooc, raw-vs-jpeg | "Do you shoot RAW too, or trust the JPEG?" |
| 8 | "The bokeh on that lens is creamy." | Blurred areas look smooth and pleasant. | bokeh, rendering | "Is it the aperture blades or the lens design?" |
| 9 | "I'm shooting the meteor shower Saturday if the sky clears." | Long exposure night sky photography. | long-exposure, night-photography | "Do you use a tripod and a wide lens?" |
| 10 | "I metered off her face because the window was killing the background." | Exposed for the subject, letting bright window overexpose. | metering-modes, backlight | "Did you use spot metering or exposure compensation?" |
| 11 | "Portra 400 is my favourite for skin tones." | She likes a Kodak colour negative film for its rendering. | film-stocks, color-negative | "Do you have it developed at a lab?" |
| 12 | "I got a keeper on the tenth frame of the burst." | She shot a rapid series and one caught the moment. | burst-mode, decisive-moment | "What told you that frame was the one?" |
| 13 | "The composition is a bit busy on the left." | The left edge has distracting elements. | edges-clutter, composition | "What would you crop or move to fix it?" |
| 14 | "Everyone shoots this spot now. It's ruined by Instagram." | Overcrowded viral location. | debate-overtourism | "Did you find a different angle or time?" |
| 15 | "Do you think AI denoise counts as editing?" | She asks about honesty limits in editing. | edit-honesty, ai-editing | "Where do you draw the line?" |

**How Swoon'd helps without encouraging fake expertise.** Every conversation item carries a `noFakeExpertNote`; follow-ups are honest curiosity ("What made you pick that moment?"), never invented analysis. Coach notes reward asking "what did you see in that light?", admitting "I'm still learning what f-stops do; can you show me?", and complimenting *specifics* ("the light on her left cheek is lovely") instead of gear ("what camera is that?"). Cringe replies are the ones that bluff numbers, name-drop gear, flatter vaguely, or make the photo about the camera.

**Targets:** 16 talk tracks at launch (all `conversation-lab` plus one per unit end, and 3 per branch over time), 70+ say-this items, 40+ fill-the-gap items.

---

## 10. Assessment

- **Useful competence** = she can (1) decode the language of a shoot recap and a gear chat, (2) look at her photograph and say something specific (light, moment, framing) that is kind and true, (3) ask two honest, informed questions about how the shot was made, (4) join a photo walk or a photo-dump viewing without being lost.
- **Recognise:** hard vs soft light, direction of light, an over- or underexposed image, shallow vs deep depth of field, wide vs telephoto look, film vs digital rendering cues, lighting patterns, composition devices, common gear categories and brands.
- **Understand:** why aperture, shutter and ISO trade off; why a stop is the shared unit; why depth of field depends on more than aperture; why perspective is about position; why the meter is fooled by snow; why light direction sculpts a face; why gear debates exist; what content credentials are for.
- **Explain:** in her own words, "what's an f-stop", "why is her background blurry", "why did she bump the ISO", "what's full frame".
- **Correctly interpret:** an f-number and a shutter speed together, a histogram bunched to one side, a gear headline, a film-stock label, a lighting description ("Rembrandt", "rim").
- **Mastery model:** `concept-mastery-v1`, pass threshold **0.8** (foundation concepts held to 0.8; enthusiast-depth concepts count as Familiar at 0.6 for reporting). Review ladder: 1d, 3d, 7d, 14d, 30d, 60d (Playbook Review); max 12 items per daily session; a concept slipping below 0.6 re-enters at 1d.
- **Useful competence statement:** "She can follow a conversation about light, exposure, lenses and gear, look at her photo and say something specific and kind about it, ask two good questions about how she got the shot, and say 'okay, I see why you love this' without bluffing."

---

## 11. Curriculum map (ongoing course)

Course version target at launch: `curriculumVersion 0.1.0`. **19 units, 112 lessons, 220 concepts** across all six layers. A learner sees the 11 core units plus `now-in-photography`, `conversation-lab`, `review-loop`, plus one unit per chosen branch (14 to 19 units), so per-learner length is in the normal 10-16 range; the count is high because five genres are branches. Approval of the count is an open question (P-04 style).

Activity legend: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap, `SIM` Unity sim.

Every lesson ends with a "line you could say out loud" and 1-2 Playbook additions. Every unit's final lesson is a mixed-review capstone that includes one `tk` or `st` conversation beat. All imagery is original (section 14).

### Layer 1: Foundations

**Unit `seeing-light`: Seeing Light** (prereq: none). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `see-01` | A photo is light | Say why a photograph records light, not things. | photo-is-light, exposure-idea | mc, st |
| `see-02` | Hard light, soft light | Tell hard from soft by the shadow edge. | hard-soft-light, shadow-edge | vi, mc |
| `see-03` | Where the light comes from | Name front, side and back light and what each does. | light-direction, backlight | vi, ds |
| `see-04` | Golden hour and blue hour | Explain why low sun looks warm and soft. | golden-hour, blue-hour | mc, es |
| `see-05` | The colour of light | Read Kelvin and white balance. | color-temperature, white-balance | es, tm |
| `see-06` | Highlights, shadows, and what a camera can hold | Explain dynamic range and blown highlights. | dynamic-range, blown-highlights, clipped-shadows | bc, mc |

**Unit `exposure-triangle`: The Exposure Triangle** (prereq: `seeing-light`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `exp-01` | Exposure is a bucket of light | Define exposure and spot over- and underexposure. | exposure, over-under-exposure | vi, mc |
| `exp-02` | Aperture and the f-number | Explain f-numbers and why small numbers mean big openings. | aperture, f-number, wide-open | tm, es |
| `exp-03` | Shutter speed | Relate shutter speed to motion blur and hand-holding. | shutter-speed, motion-blur, handholding-rule | tt, mc |
| `exp-04` | ISO and noise | Explain what ISO does and what it costs. | iso, noise | vi, mc |
| `exp-05` | The stop | Use the stop as a common unit across all three. | stop, reciprocity | so, es |
| `exp-06` | Three knobs, one budget | Trade settings while keeping exposure equal. | exposure-triangle, tradeoffs | ds, fg |
| `exp-07` | P, A, S, M and auto ISO | Pick a mode for a situation. | exposure-modes, aperture-priority, shutter-priority, auto-iso | mc, ds |
| `exp-08` | Metering and compensation | Explain why the meter aims for grey and how to override it. | metering-modes, middle-grey, exposure-compensation | ds, bc |

**Unit `focus-and-depth`: Focus and Depth of Field** (prereq: `exposure-triangle`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `foc-01` | How autofocus decides | Tell single from continuous AF and know eye detection. | autofocus-modes, af-area, eye-af | mc, st |
| `foc-02` | Sharp is not one thing | Separate focus miss, motion blur, shake and diffraction. | focus-miss, camera-shake, diffraction | vi, bc |
| `foc-03` | Depth of field: three dials | Name the four factors that set depth of field. | depth-of-field, focus-distance, subject-background-distance | mc, es |
| `foc-04` | Isolate or include | Choose aperture, distance and lens to isolate or include. | depth-of-field, aperture, subject-isolation, focus-distance | SIM `photo.focus.depth-of-field.v1`, bc |
| `foc-05` | Bokeh talk | Decode bokeh quality vs amount. | bokeh, rendering | vi, st |
| `foc-06` | Hyperfocal and zone focus | Explain hyperfocal focusing and zone focusing. | hyperfocal, zone-focusing | ds, fg |

**Unit `cameras-and-lenses`: Cameras and Lenses** (prereq: `exposure-triangle`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cam-01` | Kinds of camera | Sort phone, compact, mirrorless, DSLR, medium format and film. | camera-types | tm, mc |
| `cam-02` | Sensor size and "full frame" | Explain sensor size and its trade-offs. | sensor-size, full-frame | mc, ht |
| `cam-03` | Megapixels, RAW and JPEG | Debunk the megapixel myth; define RAW. | megapixels, raw-vs-jpeg | mc, bc |
| `cam-04` | Focal length is field of view | Relate millimetres to what fits in the frame. | focal-length, field-of-view | vi, es |
| `cam-05` | Crop factor and equivalence | Convert between formats; explain "equivalent" numbers. | crop-factor, equivalence | es, fg |
| `cam-06` | Compression and distortion | Explain that perspective comes from position, and choose lenses for looks. | perspective-compression, subject-distance, wide-angle-distortion, focal-length | SIM `photo.lens.compression-lab.v1`, bc |
| `cam-07` | Primes, zooms, and "fast" lenses | Compare primes and zooms and define lens speed. | prime-lens, zoom-lens, lens-speed | tm, mc |
| `cam-08` | The camera in your pocket | Explain computational photography on phones. | phone-cameras, computational-photography, portrait-mode-depth-map | mc, st |

**Unit `composition`: Composition** (prereq: `seeing-light`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `com-01` | Frame first | Choose what to include and exclude. | framing, subject-clarity | ht, mc |
| `com-02` | Thirds are a tool, not a law | Use and break the rule of thirds. | rule-of-thirds | ht, bc |
| `com-03` | Lines and shapes | Spot leading lines, diagonals and shapes. | leading-lines, shapes-geometry | ht, vi |
| `com-04` | Layers | Read foreground, middle and background. | depth-layers, foreground-interest | vi, mc |
| `com-05` | Negative space and balance | Explain empty space and visual balance. | negative-space, visual-balance | vi, st |
| `com-06` | Edges and clutter | Find distractions at the edges and simplify. | edges-clutter, simplify | ht, ds |
| `com-07` | Light as composition | See tonal balance and where the eye lands. | tonal-balance, eye-path | vi, tk |

### Layer 2: Intermediate

**Unit `light-and-flash`: Light and Flash** (prereq: `seeing-light`, `exposure-triangle`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `lf-01` | Window light and big soft sources | Explain why a window makes flattering light. | window-light, source-size | vi, mc |
| `lf-02` | Direction sculpts | Place a light to make a chosen pattern. | light-direction, lighting-patterns, rembrandt-lighting, split-lighting | SIM `photo.light.direction-lab.v1`, bc |
| `lf-03` | Size, distance and softness | Predict how source size and distance change shadows. | light-size-distance, inverse-square, hard-soft-light | SIM `photo.light.direction-lab.v1`, es |
| `lf-04` | Reflectors, diffusers, negative fill | Choose a modifier to fix a problem. | reflector, diffuser, fill-light | ds, tm |
| `lf-05` | Flash on camera | Use bounce and fill flash sensibly. | on-camera-flash, bounce-flash, fill-flash | ds, mc |
| `lf-06` | Off-camera flash and sync speed | Explain flash sync and why the flash freezes motion. | off-camera-flash, sync-speed, catchlight | fg, st |

**Unit `motion-and-tricky-light`: Motion and Tricky Light** (prereq: `exposure-triangle`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `mot-01` | Reading the histogram | Read a histogram for clipping and bias. | histogram, clipping | ht, mc |
| `mot-02` | Expose to the right, bracket, HDR | Explain ETTR, bracketing and HDR. | expose-to-the-right, bracketing, hdr | ds, bc |
| `mot-03` | Backlit, snowy and other meter fools | Pick compensation for fooled meters. | exposure-compensation, backlight, middle-grey | ds, es |
| `mot-04` | Freeze, blur and pan | Choose shutter speed for a motion look. | shutter-speed, panning, freeze-motion | vi, ds |
| `mot-05` | Long exposure and ND filters | Explain long exposure and ND stops. | long-exposure, nd-filter | es, so |
| `mot-06` | Night and low light | Choose settings for night and explain stars vs trails. | night-photography, high-iso-strategy, star-trails | ds, mc |

**Unit `editing-and-color`: Editing and Colour** (prereq: `exposure-triangle`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ed-01` | Why RAW, and what a catalog is | Describe a RAW workflow. | raw-workflow, catalog | so, mc |
| `ed-02` | The basic edit | Order and explain the basic global adjustments. | global-adjustments, highlights-shadows-sliders | so, vi |
| `ed-03` | Colour: HSL, vibrance, grading | Tell vibrance from saturation; explain grading. | hsl, vibrance-saturation, color-grading | vi, tm |
| `ed-04` | Crop, sharpen, denoise | Explain crop, sharpening and noise reduction. | crop-straighten, sharpening, noise-reduction | mc, fg |
| `ed-05` | Presets, looks and SOOC | Decode presets, looks and SOOC. | presets-looks, sooc | st, bc |
| `ed-06` | Culling: keepers and selects | Explain culling and selecting. | culling-selects | ds, tk |

### Layer 3: Enthusiast depth

**Unit `gear-culture`: Gear Culture and Debates** (prereq: `cameras-and-lenses`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `gear-01` | Full frame, APS-C, Micro Four Thirds | Present the trade-offs fairly. | sensor-formats-debate, format-tradeoffs | mc, st |
| `gear-02` | Mirrorless vs DSLR | Explain the shift and what still divides fans. | mirrorless-vs-dslr, electronic-viewfinder | mc, bc |
| `gear-03` | Mounts, ecosystems, lock-in | Explain mounts, adapters and third-party lens politics. | lens-mount, ecosystem-lock-in, third-party-lenses | tm, ds |
| `gear-04` | Primes, zooms, the trinity, "character" | Decode "the trinity" and "lens character". | holy-trinity-zooms, lens-character, sharpness-vs-rendering | tm, st |
| `gear-05` | GAS and "gear doesn't matter" | Explain both sides of the gear argument. | gas, gear-vs-vision | mc, tk |
| `gear-06` | Used, rented and bought smart | Choose used, rent or buy for a described need. | used-gear, lens-rental | ds, mc |
| `gear-07` | Brand personalities | Describe brand reputations without tribalism. | brand-personalities, color-science, film-simulations | mc, st |

**Unit `critique-language`: Critique Language** (prereq: `composition`, `seeing-light`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cri-01` | How to look at a photo | Look in four passes: whole, path, detail, feeling. | looking-in-passes, eye-path | ht, mc |
| `cri-02` | Technical vs aesthetic | Separate technical faults from aesthetic choices. | technical-vs-aesthetic | bc, mc |
| `cri-03` | The vocabulary | Use tonality, separation, rendering, gritty, clinical, moody. | tonality, separation, gritty-clinical-moody | tm, st |
| `cri-04` | What makes a photo work | Name subject, light, moment and geometry in a photo. | subject-light-moment-geometry | vi, st |
| `cri-05` | Kind, specific feedback | Give feedback that is specific and kind. | kind-specific-feedback | ds, tk |
| `cri-06` | She shows you a photo | React well when shown a photo. | reacting-to-work, ask-about-the-shot | tk, ds |
| `cri-07` | Series, sequencing, photobooks | Explain series and sequencing. | series-sequencing, photobooks | so, mc |

**Unit `photo-culture-and-debates`: Photography Culture and Debates** (prereq: `critique-language`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cul-01` | A short history | Place daguerreotype, roll film, digital and phones on a timeline. | photo-history-timeline | so, mc |
| `cul-02` | The decisive moment | Explain the decisive moment and documentary tradition. | decisive-moment, documentary-tradition | mc, st |
| `cul-03` | Landscape tradition and the zone system | Explain the zone system and f/64. | zone-system, landscape-tradition | mc, fg |
| `cul-04` | Colour becomes serious | Explain why colour photography's acceptance is a story. | color-photography-history | mc, st |
| `cul-05` | Manipulation, AI and content credentials | Explain the manipulation and AI debate and C2PA. | edit-honesty, ai-editing, content-credentials | ds, mc |
| `cul-06` | Ethics across genres | Weigh consent, privacy and animal welfare. | photo-ethics, consent-first | ds, bc |
| `cul-07` | The Instagram era | Explain the algorithm-shaped look and overtourism. | social-media-look, debate-overtourism | st, mc |

### Layer 4: Branches / personalization

**Unit `branch-portrait`** (`branchId: portrait`; prereq: `focus-and-depth`, `cameras-and-lenses`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `port-01` | Lenses for faces | Choose a portrait lens and distance. | portrait-lens, perspective-compression, wide-angle-distortion | SIM `photo.lens.compression-lab.v1`, mc |
| `port-02` | Posing without stiffness | Explain directing a person, with consent first. | posing-direction, consent-first | ds, tk |
| `port-03` | Eyes, focus and depth | Focus on the eye and choose aperture for one or two faces. | eye-focus, subject-isolation, depth-of-field | SIM `photo.focus.depth-of-field.v1`, bc |
| `port-04` | Light patterns for faces | Name and place Rembrandt, loop, butterfly, split, rim. | lighting-patterns, rembrandt-lighting, butterfly-lighting, catchlight | SIM `photo.light.direction-lab.v1`, vi |
| `port-05` | Skin, retouching and honesty | Discuss retouching limits. | retouching-honesty, skin-tone-rendering | ds, st |

**Unit `branch-street`** (`branchId: street`; prereq: `composition`, `cameras-and-lenses`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `str-01` | What street photography is | Define candid work and its tradition. | street-photography, candid-vs-staged | mc, st |
| `str-02` | Zone focus and small cameras | Explain zone focus and lens choice (28, 35, 40mm). | zone-focusing, street-focal-lengths | ds, fg |
| `str-03` | Light, shadows and layers in the city | See layers and light pockets in a scene. | city-light-shadow, depth-layers | ht, vi |
| `str-04` | Etiquette and the law, calmly | Handle a stranger's objection well. | street-ethics, consent-first | ds, tk |
| `str-05` | The decisive moment, in practice | Time a tap to the peak of action. | decisive-moment, anticipation | tt, mc |

**Unit `branch-landscape`** (`branchId: landscape`; prereq: `focus-and-depth`, `motion-and-tricky-light`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `land-01` | Light is the subject | Explain why landscape photographers chase light and weather. | landscape-light, weather-mood | vi, mc |
| `land-02` | Tripods, apertures, hyperfocal | Choose settings for front-to-back sharpness. | hyperfocal, tripod-use, diffraction | ds, es |
| `land-03` | Filters and long exposure | Explain polarisers, ND and graduated ND. | polarizer, nd-filter, graduated-nd | tm, ds |
| `land-04` | Planning a shoot | Plan sun, moon, tide and weather for a location. | shoot-planning, sun-moon-tide-planning | ds, es |
| `land-05` | Safety and Leave No Trace | Weigh safety and impact against a shot. | landscape-safety, leave-no-trace-photography | ds, bc |

**Unit `branch-wildlife`** (`branchId: wildlife`; prereq: `focus-and-depth`, `motion-and-tricky-light`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `wild-01` | Long lenses and the reach problem | Explain reach, crop sensors and teleconverters. | telephoto-reach, teleconverter, crop-factor | mc, es |
| `wild-02` | Shutter speed for fur and feathers | Choose shutter speeds for animal motion. | wildlife-shutter-speed, freeze-motion | ds, es |
| `wild-03` | Tracking focus | Explain tracking AF and subject detection. | tracking-af, subject-detection | mc, bc |
| `wild-04` | Fieldcraft and ethics | Put the animal first. | wildlife-ethics, fieldcraft | ds, bc |
| `wild-05` | Eye level and clean backgrounds | Choose angle and background separation. | subject-isolation, eye-level-angle | SIM `photo.focus.depth-of-field.v1`, vi |

**Unit `branch-film`** (`branchId: film`; prereq: `exposure-triangle`, `cameras-and-lenses`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `film-01` | What film is | Explain emulsion, grain and film speed. | film-basics, film-speed, grain | mc, so |
| `film-02` | Stocks and looks | Sort colour negative, slide and black and white. | film-stocks, color-negative, slide-film, bw-film | tm, vi |
| `film-03` | Exposing film | Explain latitude and why negative likes light. | film-latitude, sunny-16, incident-metering | es, ds |
| `film-04` | Formats | Compare 35mm, 120, large format, instant. | film-formats | tm, mc |
| `film-05` | Development, scans and labs | Order the film pipeline. | film-development, film-scanning, film-labs | so, fg |
| `film-06` | Why film now | Discuss the film revival honestly. | film-revival, film-cost, film-vs-digital | st, tk |

### Layer 5: Current-season / live

**Unit `now-in-photography`: Now in Photography** (prereq: `cameras-and-lenses`, `light-and-flash`; `live` hooks). 4 lessons, refreshed weekly; new templates each season.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `now-01` | This week's gear news, decoded | Explain a current launch or rumour and whether it matters to her. | live-gear-news, release-literacy | mc, st |
| `now-02` | Tonight's light | Read sun, moon and cloud for her region. | live-conditions, golden-hour | ds, es |
| `now-03` | Sky events and seasons | Explain meteor showers, eclipses, aurora and the safety line. | sky-events, solar-safety | mc, ds |
| `now-04` | Contests, shows and photobooks | Explain why an award or exhibition is being discussed. | live-awards-context | st, mc |

### Layer 6: Conversation practice and perpetual review

**Unit `conversation-lab`: Conversation Lab** (prereq: `seeing-light`; unlocks progressively). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `conv-01` | Decode her shoot recap | Turn a recap into terms and a question. | convo-follow-up-questions, convo-shoot-recap | st, tk |
| `conv-02` | She shows you a photo | Say something specific and kind. | convo-photo-reaction, kind-specific-feedback | tk, st |
| `conv-03` | Gear chat without bluffing | Talk gear honestly. | convo-gear-talk, convo-admit-what-you-dont-know | tk, st |
| `conv-04` | Photo walk invitation | Ask to see her work or plan a walk together. | convo-photo-walk, consent-first | tk, ds |
| `conv-05` | When the shoot went badly | Respond with empathy and one useful question. | convo-empathy, convo-follow-up-questions | tk, st |

**Unit `review-loop`: Perpetual Review** (prereq: none; unlocks after any foundation unit). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rev-01` | Light and exposure review | Retrieve exposure and light concepts on the ladder. | exposure-triangle, stop, hard-soft-light, metering-modes | mc, es |
| `rev-02` | Lens and focus review | Retrieve lens, depth and perspective concepts. | depth-of-field, focal-length, perspective-compression, crop-factor | mc, SIM `photo.lens.compression-lab.v1` |
| `rev-03` | Talk and critique review | Retrieve critique and gear vocabulary. | tonality, separation, gear-vs-vision, kind-specific-feedback | st, tk |

- **Review policy:** ladder 1d, 3d, 7d, 14d, 30d, 60d; daily session max 12 items; new concepts enter after their unit capstone; sims are eligible for review only via their native fallbacks (sim runs are longer).
- **Concept count target (Playbook):** 220 ids (Appendix). Playbook terms with definitions and example lines in `exercises.md` section 3.
- **Personalization slots:** `{{equipment}}` in `cam-*`, `gear-*`, `conv-03`; `{{genre}}` opens branch units; `{{region}}` in `now-02`, `now-03`, `land-04`; `{{style}}` in `cri-*`, `conv-02`.
- **Release plan:**
  - **Launch (v0.1 to 1.0):** `seeing-light`, `exposure-triangle`, `focus-and-depth`, `cameras-and-lenses`, `composition`, `light-and-flash`, `motion-and-tricky-light`, `editing-and-color`, `conversation-lab`, `review-loop`; sims 1 and 2 (compression, depth of field) when built, native fallbacks until then; branch `portrait` (uses all three sims' native fallbacks).
  - **Fast follow (1.1):** `gear-culture`, `critique-language`, `photo-culture-and-debates`, `now-in-photography` (weather/sun cards first, news after L-01), branches `street` and `landscape`, sim 3 (light lab) if the playtest keeps it Tier A.
  - **Ongoing:** branches `wildlife` and `film`; per-season gear and film updates; awards-season and sky-event cards; new talk tracks each quarter; a new-camera-cycle explainer each release wave.

### Appendix: Playbook concepts (ids)

Every conceptId used in the tables above, grouped by the unit where it first appears (220 ids; all must exist in the curriculum `concepts[]`):

Light: `photo-is-light`, `exposure-idea`, `hard-soft-light`, `shadow-edge`, `light-direction`, `backlight`, `golden-hour`, `blue-hour`, `color-temperature`, `white-balance`, `dynamic-range`, `blown-highlights`, `clipped-shadows`.
Exposure: `exposure`, `over-under-exposure`, `aperture`, `f-number`, `wide-open`, `shutter-speed`, `motion-blur`, `handholding-rule`, `iso`, `noise`, `stop`, `reciprocity`, `exposure-triangle`, `tradeoffs`, `exposure-modes`, `aperture-priority`, `shutter-priority`, `auto-iso`, `metering-modes`, `middle-grey`, `exposure-compensation`.
Focus and depth: `autofocus-modes`, `af-area`, `eye-af`, `focus-miss`, `camera-shake`, `diffraction`, `depth-of-field`, `focus-distance`, `subject-background-distance`, `subject-isolation`, `bokeh`, `rendering`, `hyperfocal`, `zone-focusing`.
Cameras and lenses: `camera-types`, `sensor-size`, `full-frame`, `megapixels`, `raw-vs-jpeg`, `focal-length`, `field-of-view`, `crop-factor`, `equivalence`, `perspective-compression`, `subject-distance`, `wide-angle-distortion`, `prime-lens`, `zoom-lens`, `lens-speed`, `phone-cameras`, `computational-photography`, `portrait-mode-depth-map`.
Composition: `framing`, `subject-clarity`, `rule-of-thirds`, `leading-lines`, `shapes-geometry`, `depth-layers`, `foreground-interest`, `negative-space`, `visual-balance`, `edges-clutter`, `simplify`, `tonal-balance`, `eye-path`.
Light and flash: `window-light`, `source-size`, `lighting-patterns`, `rembrandt-lighting`, `split-lighting`, `light-size-distance`, `inverse-square`, `reflector`, `diffuser`, `fill-light`, `on-camera-flash`, `bounce-flash`, `fill-flash`, `off-camera-flash`, `sync-speed`, `catchlight`.
Motion and tricky light: `histogram`, `clipping`, `expose-to-the-right`, `bracketing`, `hdr`, `panning`, `freeze-motion`, `long-exposure`, `nd-filter`, `night-photography`, `high-iso-strategy`, `star-trails`.
Editing: `raw-workflow`, `catalog`, `global-adjustments`, `highlights-shadows-sliders`, `hsl`, `vibrance-saturation`, `color-grading`, `crop-straighten`, `sharpening`, `noise-reduction`, `presets-looks`, `sooc`, `culling-selects`.
Gear culture: `sensor-formats-debate`, `format-tradeoffs`, `mirrorless-vs-dslr`, `electronic-viewfinder`, `lens-mount`, `ecosystem-lock-in`, `third-party-lenses`, `holy-trinity-zooms`, `lens-character`, `sharpness-vs-rendering`, `gas`, `gear-vs-vision`, `used-gear`, `lens-rental`, `brand-personalities`, `color-science`, `film-simulations`.
Critique: `looking-in-passes`, `technical-vs-aesthetic`, `tonality`, `separation`, `gritty-clinical-moody`, `subject-light-moment-geometry`, `kind-specific-feedback`, `reacting-to-work`, `ask-about-the-shot`, `series-sequencing`, `photobooks`.
Culture and debates: `photo-history-timeline`, `decisive-moment`, `documentary-tradition`, `zone-system`, `landscape-tradition`, `color-photography-history`, `edit-honesty`, `ai-editing`, `content-credentials`, `photo-ethics`, `consent-first`, `social-media-look`, `debate-overtourism`.
Portrait: `portrait-lens`, `posing-direction`, `eye-focus`, `butterfly-lighting`, `retouching-honesty`, `skin-tone-rendering`.
Street: `street-photography`, `candid-vs-staged`, `street-focal-lengths`, `city-light-shadow`, `street-ethics`, `anticipation`.
Landscape: `landscape-light`, `weather-mood`, `tripod-use`, `polarizer`, `graduated-nd`, `shoot-planning`, `sun-moon-tide-planning`, `landscape-safety`, `leave-no-trace-photography`.
Wildlife: `telephoto-reach`, `teleconverter`, `wildlife-shutter-speed`, `tracking-af`, `subject-detection`, `wildlife-ethics`, `fieldcraft`, `eye-level-angle`.
Film: `film-basics`, `film-speed`, `grain`, `film-stocks`, `color-negative`, `slide-film`, `bw-film`, `film-latitude`, `sunny-16`, `incident-metering`, `film-formats`, `film-development`, `film-scanning`, `film-labs`, `film-revival`, `film-cost`, `film-vs-digital`.
Live: `live-gear-news`, `release-literacy`, `live-conditions`, `sky-events`, `solar-safety`, `live-awards-context`.
Conversation: `convo-follow-up-questions`, `convo-shoot-recap`, `convo-photo-reaction`, `convo-gear-talk`, `convo-admit-what-you-dont-know`, `convo-photo-walk`, `convo-empathy`.

---

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4): Unity only where spatial reasoning, movement, physics, timing in a scene, or camera perspective materially improves learning **and** a native exercise would teach it clearly worse.

### 12.1 The decision: is there a Unity sim at all, and which?

Photography is the rare subject in which *the camera itself is the thing being learned*. That makes "camera perspective" a first-order rubric signal, but it does **not** automatically justify Unity, because most photographic concepts are numbers and images, and images are exactly what native exercises serve well. The test applied to every candidate was: (1) is the concept a **relationship among continuous, interacting variables in a 3D scene** that the learner must manipulate to *feel* the relationship; and (2) can a **fixed set of authored images** plus a native slider or choice communicate the same relationship as well?

- **Compression and field of view (Unity).** The central variable pair is camera *position* and *focal length*, with the constraint "keep the subject the same size". The insight (compression follows distance, not lens; wide close-ups distort faces) is exactly the thing that a still image cannot convey, because each still has the answer baked in. A native alternative would need a pre-rendered grid of images across distance x focal length (at least 6 x 6 per scene) *plus* 2D layer scaling, which does not reproduce real perspective on a 3D face (the nose-bulge effect) and cannot respond to a learner-chosen target ("make the mountain loom behind her"). The learner must walk the camera back while zooming in and *watch the subject stay put while the background swells*. Tier A, strongest case. Closest native: `estimate-slider` + `visual-id` on authored pairs (used as the fallback and for the static rule).
- **Depth of field (Unity).** DoF depends on four variables (aperture, focus distance, focal length, camera-to-subject distance) plus the *background distance*, which makes an authored grid combinatorially large (5 apertures x 5 focal lengths x 4 distances x 3 focus points = 300 images per scene). A native 2D layered-blur composite could approximate it for a fixed camera, but breaks the moment the learner moves the camera (parallax, framing change), which is the point of `foc-04`. The Unity scene computes blur analytically (the same circle-of-confusion formula the lesson teaches) and renders it with the engine's bokeh depth-of-field. Tier A, strong. Fallback: authored image pairs with `visual-id` + `estimate-slider`.
- **Light direction, size and distance (Unity, weakest).** The three-dimensional relationship between a light's azimuth, elevation, size and distance and the shape of shadows on a 3D face is genuinely spatial, and exploration teaches it. But a native alternative is credible: 8 to 12 pre-rendered lighting positions on one bust plus `visual-id` naming the patterns and `estimate-slider` for source size gets most of the vocabulary across. Unity earns its place only by letting the learner *drag* the light continuously and see the shadow edge soften as the source grows, and by rewarding "place the light to produce X". This is the sim most likely to be downgraded after playtest; it ships last and its native fallback lesson is complete on its own. Tier A conditional.
- **Shutter speed and motion blur (native).** Considered and rejected. The relationship is blur length = subject speed x exposure time / subject size in frame, easy to state; three authored strips (1/1000, 1/125, 1/15) plus an `estimate-slider` and `timing-tap` teach it fully. There is no spatial reasoning required and no camera perspective change, so a sim would be a decorative game (rubric row: "Would a fake game be a worse teacher than clear text and a diagram? Native").
- **Exposure triangle (native).** A numeric puzzle: keep the total light constant while trading knobs; a decision-scenario and `estimate-slider` are exact fits. The spec's own list names photography for decision scenarios and estimate sliders.
- **Composition, editing, film process, gear (native).** Static images and vocabulary.

### 12.2 One shared scene toolkit

All three sims run on one procedural "photo studio" environment key (`photo_stage`) and one new module (`Swoond.Photo`: `PhysicalCamera`, `DepthOfFieldPass`, `SoftLight`; requested in the sim specs and consolidated in `NOTES_FOR_ORCHESTRATOR.md`). Building the first sim pays for the other two, which matters for a Wave 2 course competing for Astra's time.

### 12.3 Interaction plan table

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| `cam-06`, `port-01`, `rev-02`: compression and field of view | perspective-compression, subject-distance, wide-angle-distortion, focal-length, field-of-view | `unity-sim` `photo.lens.compression-lab.v1` (spec `sims/photo.lens.compression-lab.v1.md`) | Rubric: **camera perspective is the concept** and the learner must move the camera and zoom together. Closest native: `estimate-slider` or `visual-id` on authored pairs; those show a result but not the trade (walk back + zoom in = same subject, different background). | A | 1 sim, 12+ scenarios |
| `foc-04`, `port-03`, `wild-05`: depth of field | depth-of-field, aperture, focus-distance, subject-isolation, bokeh | `unity-sim` `photo.focus.depth-of-field.v1` (spec `sims/photo.focus.depth-of-field.v1.md`) | Rubric: **spatial reasoning + camera perspective**: five interacting variables on a 3D scene, parallax when the camera moves. Closest native: `visual-id` pairs and `estimate-slider`; combinatorial and cannot follow a moving camera. | A | 1 sim, 12+ scenarios |
| `lf-02`, `lf-03`, `port-04`: light direction | light-direction, lighting-patterns, rembrandt-lighting, light-size-distance, hard-soft-light, catchlight | `unity-sim` `photo.light.direction-lab.v1` (spec `sims/photo.light.direction-lab.v1.md`) | Rubric: **spatial reasoning on a 3D form** (light on a face). Closest native: 8-12 pre-rendered positions + `visual-id`; teaches names, not the continuous cause-effect of size and distance. **Conditional Tier A** (P-09 style): playtest against the native fallback before approving. | A | 1 sim, 12+ scenarios |
| Exposure trades and metering | exposure-triangle, stop, reciprocity, exposure-compensation, metering-modes | `estimate-slider`, `decision-scenario`, `fill-the-gap`, `sequence-order` | A number in stops is the lesson; closeness matters more than exactness (catalog #12). Judgment with constraints is a decision-scenario. No sim. | B | ~90 |
| Light reading | hard-soft-light, light-direction, golden-hour | `visual-id`, `hotspot-tap`, `multiple-choice` | Recognition on original images. | B | ~50 |
| Motion blur | shutter-speed, panning, freeze-motion | `visual-id`, `estimate-slider`, `timing-tap` | Three strips explain the physics; 1D timing bar for peak action (rubric: simple timing = native). | B | ~30 |
| Composition | rule-of-thirds, leading-lines, negative-space, edges-clutter | `hotspot-tap`, `visual-id`, `binary-call` | Static images; tap where the problem is. | B | ~55 |
| Gear vocabulary and debates | camera-types, lens-mount, crop-factor, gear-vs-vision | `term-match`, `multiple-choice`, `say-this`, `decision-scenario` | Recall, recognition, judgment ("rent or buy?"). | B | ~90 |
| Sensor and lens diagrams | sensor-size, field-of-view | `hotspot-tap` (procedural diagrams) | Fixed diagram, no motion. | B | ~15 |
| Editing | global-adjustments, hsl, crop-straighten | `sequence-order`, `visual-id`, `multiple-choice` | Order of operations and recognising the effect on original images. | B | ~45 |
| Shutter sounds | film-basics, electronic-shutter | `listening-id` (original or synthesised audio) | The sound is part of the culture (leaf, focal plane, film advance, silent electronic shutter). | B | ~8 |
| Film pipeline | film-development, film-scanning | `sequence-order`, `fill-the-gap` | Process order. | B | ~20 |
| Ethics and etiquette | consent-first, street-ethics, wildlife-ethics | `decision-scenario`, `binary-call` | Judgment with consequences; teaches de-escalation and animal-first. | B | ~35 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice. | B | 16 talk tracks + ~70 say-this |
| Live cards | live-conditions, live-gear-news | `decision-scenario`, `multiple-choice`, `say-this` (templated) | Data-driven cards; no sim. | B | templated |

**Not used:** all 13 native types appear. Accessibility fallback: each sim has a designed native fallback lesson (sim spec section 16 and 4), which for the light lab is a complete standalone lesson.

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| Imagery (spec sections 39-40, rule 10) | **Original only at launch** (`license: original-swoond`): procedural diagrams, vector illustrations and in-house photographs shot by Swoon'd with signed model and property releases. Famous photographs (Adams, Cartier-Bresson, Eggleston, Maier, Salgado, and so on) are **talked about, never reproduced**: Swoon'd names the photographer and the work, describes it in its own words and links to the photographer's estate, agency or museum page. Public-domain and CC0 museum imagery (for example open-access collections) is a possible later addition and requires its own registered license ids and per-asset provenance; "publicly viewable" is not "redistributable". No image scraped from the web or from camera makers' press kits. |
| AI-generated imagery | Not used for lesson photographs (this is a course about photographic honesty). Diagrams and illustrations are drawn or procedurally generated. Any AI-assisted illustration must be disclosed in the asset record and reviewed. |
| Audio | Shutter, mirror and film-advance sounds recorded in-house or synthesised (`original-swoond`). |
| Logos / trademarks | Camera, lens, film and software brands as text only; no logos or product renders. Names of film stocks and cameras are nominative use. |
| Video | None embedded; deep-link. |
| Press and reviews | Never copied; explain and link. |
| Data terms | Sun/moon computed locally; NOAA/NWS public; Open-Meteo commercial plan; see `live-data.md`. |
| Photographer likeness | Names as facts; no likeness or fabricated quotes; work described neutrally. |
| People in imagery | Only Swoon'd staff or paid models with signed releases; no minors' photographs in lesson art. |
| Safety | See manifest `safetyConstraints`: never look at the sun through a viewfinder without proper solar filters; conservative outdoor guidance (edges, tides, lightning); animal-first wildlife rules (100 yards for bears and wolves, 25 yards for other wildlife, per NPS guidance); consent-first portrait and street; film chemistry at awareness level only. |
| Voice / people | Jokes target the learner's ignorance ("f-stop... is that a kind of tequila?"), never the crush, never other photographers, never gear owners of any brand. Never coach covert photography of anyone. |

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Exposure strips (under/correct/over), histograms | Procedural / vector | Generated | `original-swoond` |
| Hard vs soft light and direction example images | In-house photographs of a still-life and a staff model with releases; and rendered stand-ins | Swoon'd | `original-swoond` |
| Depth-of-field and compression pairs (fallback) | Rendered from the sim scene | Astra export | `original-swoond` |
| Composition example scenes | Vector illustrations and in-house photographs | Swoon'd | `original-swoond` |
| Sensor-size, mount and lens diagrams | Procedural | Generated | `original-swoond` |
| Film process illustrations | Vector | Swoon'd | `original-swoond` |
| Editing before/after pairs | In-house RAW files edited in-house | Swoon'd | `original-swoond` |
| Shutter and film-advance sounds | Recorded or synthesised | Swoon'd | `original-swoond` |
| Sim scenes (stage, bust, still-life, characters, landscape backdrop) | Procedural low-poly | Astra | `original-swoond` |
| Photographer spotlight cards | Text only | Curated | n/a (no images) |

---

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Light, the exposure triangle and stops, focus and depth of field, focal length and perspective, framing (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Gear and its debates, light and timing, editing looks, critique vocabulary, ethics and honesty (section 4).
- [x] 3. **What current information matters?** Golden hour, moon and sky events, weather, gear launches, film news, AI and authenticity news (section 6).
- [x] 4. **What should be interactive?** Three Unity sims for camera and light in a 3D scene (compression, depth of field, light direction); native estimate-slider, decision-scenario, hotspot-tap and the rest for everything else (section 12).
- [x] 5. **What should NOT be gamified?** Scoring other people's photos, brand rankings, covert photography, gear scores (section 5).
- [x] 6. **How should it personalize?** equipment, brand, genre, region, style, skill level (section 8).
- [x] 7. **What does conversational competence look like?** Decoding recaps and gear talk, reacting to her photo with specifics, honest follow-ups (sections 9, 10).
- [x] 8. **What data providers are needed?** On-device astronomy, NOAA/NWS, weather adapter, curated release/event calendars, editorial link sources (section 6; `live-data.md`).
- [x] 9. **What licensing constraints apply?** Photographs are never reproduced; original imagery only; trademarks as text; press and review text never copied (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, review ladder, talk-track Smooth >= 60, sim masterySignals, competence statement (section 10).

Additional gates: [ ] manifest validates (see report); [ ] curriculum validates (not yet authored); [x] every Unity sim has a draft spec (`sims/`); [ ] every image/audio asset has a license id (assets not produced; ids defined); [ ] voice review; [x] no copied publisher text (all copy original).

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Unit count 19 (11 core + 5 branches + live + conversation + review) exceeds the 8-14 guidance; approve (a learner sees 14 to 19) or fold? | Product | No |
| 2 | Is `photo.light.direction-lab.v1` clearly better than the native 8-12 pre-rendered positions + `visual-id` fallback? Playtest and keep Tier A only if it wins; otherwise downgrade (no `SoftLight` needed). | Product / Astra | No |
| 3 | In-house photography programme: who shoots the original photographs, and model-release process (staff vs paid models)? | Product | Blocks visual-id asset production |
| 4 | Register additional license ids (for example `cc0-1.0`, `public-domain`) for a possible later museum open-access set? Default: only `original-swoond` at launch. | Product / Legal | No |
| 5 | Editorial/news provider for the gear-news card (L-01). Default: link-only headlines plus Swoon'd explainers. | Product | No |
| 6 | Weather provider licence (Open-Meteo commercial plan vs NWS only vs shared hiking adapter). | Product / Data | No |
| 7 | Re-verify Kodak Portra to Ektacolor Pro naming and pricing, content-credentials support by maker, and the 2026 camera-launch list before `gear-*`, `cul-05` and `now-01` ship. | Content | No |
| 8 | Soundmaker: record shutter sounds in-house or synthesise (L-11)? | Product | No |
| 9 | Astra: confirm Game Kit additions (PhysicalCamera, DepthOfFieldPass, SoftLight, `photo_stage`) and the Unity URP depth-of-field mobile budget. | Astra | Yes for sim build |
| 10 | Safety review of solar-photography, tides and wildlife-distance copy by a qualified reviewer (analogous to S-05). | Product | Blocks release of `now-03`, `land-05`, `wild-04` |
