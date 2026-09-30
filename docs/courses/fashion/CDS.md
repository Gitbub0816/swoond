# Course Design Specification: Fashion (`fashion`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity simulations, see section 12) |

Time-sensitive facts (fashion-week dates, who designs where, ownership, regulation timelines) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Lesson copy never hard-codes them; the live layer and dated "facts cards" carry them (see `live-data.md`).

---

## 1. Identity

- **Course ID:** `fashion` (immutable)
- **Display name:** Fashion
- **Category / family:** Fashion & Beauty > Fashion (family `Fashion & Beauty`)
- **Simulation prefix:** `fashion` (reserved; no sims are planned)
- **What this course is.** Fashion is a *language* (silhouettes, fabrics, construction, fit words), a *calendar* (shows, seasons, drops), a *set of houses and people*, and a *set of arguments* (sustainability, appropriation, dupes). The person you care about may sew, thrift, chase sneaker drops, watch runway shows, dress with a strong personal aesthetic, or simply love talking about clothes. The course teaches enough vocabulary and context to follow that conversation and ask good questions. It is not a style-advice course and never tells anyone how they should look.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Skincare (`skincare`) | Knowing silhouettes, fabrics and fashion weeks tells you nothing about ingredients, routines or claims. Shared "Fashion & Beauty" shelf only. | Independent (sibling) | Separate course. Beauty at fashion week (makeup looks) is mentioned only as a runway element, not taught. Cross-link "how a look comes together" only. |
| Music (`music`) | Sneaker and streetwear culture grew out of hip-hop, punk and skate scenes, but knowing streetwear does not make you competent about the music, and vice versa. | Adjacent | Cross-link concepts (subculture roots) only. |
| Photography (`photography`) | Fashion photography and editorial shoots overlap in vocabulary, but competence differs. | Adjacent | Only mention editorial shoots as media; no camera content. |
| Movies (`movies`) | Costume design shares fabrics and eras vocabulary; conversation about it differs. | Adjacent | Eras unit may cite costume design as an example, without film imagery. |
| Cooking, Cars, etc. | None. | Independent | None. |

- **Branches** (spec section 7; personalization layer via `style` and `brand`): the shared foundation is the same for everyone; branches change examples, vocabulary emphasis and the live context.

| Branch id | Name | What changes |
|---|---|---|
| `everyday-style` (default) | Everyday style and wardrobe | Outfit-building, staples, dress codes, thrift-plus-basics. No dedicated unit: the core units are written for this lens. |
| `streetwear` | Streetwear and sneaker culture | Drops, raffles, collabs, resale, silhouettes of sneakers, skate/hip-hop/Tokyo roots. Unit `branch-streetwear`. |
| `luxury-runway` | Luxury and runway | Houses, creative directors, collections, fashion weeks, couture craft, show reviews. Unit `branch-luxury-runway`. |
| `vintage` | Vintage and thrift | Dating garments, eras, hunting grounds, condition and repair, resale platforms. Unit `branch-vintage`. |
| `menswear-tailoring` | Menswear and tailoring | Suit anatomy, lapels, shirt collars, shoes, fit at the tailor. Tailoring is a craft, not a gender: the unit is for anyone who wears or loves tailored clothes. Unit `branch-menswear-tailoring`. |

---

## 2. Beginner model

- **What a beginner knows.** They know what they like and dislike wearing, a handful of famous names (Chanel, Nike, Gucci, Zara), maybe "Paris Fashion Week", and that some clothes are expensive. They usually judge fashion by price or brand rather than by construction or silhouette.
- **Terminology that will confuse them.** "Silhouette" (an outline, not a shadow), "a-line", "bias cut", "drape", "hand" (the feel of a fabric), "rise", "inseam", "ease", "collection", "capsule", "resort/cruise", "pre-fall", "couture" (a protected term) vs "ready-to-wear", "atelier", "colorway", "deadstock", "DS/NWT", "grail", "drop", "cop", "raffle", "quiet luxury", "dupe", "greenwashing", "toile", "canvas" (inside a jacket), "lookbook".
- **Common misconceptions.**
  - "Fashion is just trends." (Trends are one layer; construction, craft, history and personal style are equally real.)
  - "Expensive means well made, cheap means badly made." (Price and quality correlate loosely; construction cues can be read at any price.)
  - "Couture means fancy." (Haute couture is a regulated designation in France, with specific criteria; most "couture" language is marketing.)
  - "Vintage means old." (Convention: roughly 20+ years; older secondhand is not always vintage; "vintage-style" is new.)
  - "Sizes are objective." (Sizes are brand-specific and change over time; a size is a label on a garment, not a verdict on a body.)
  - "Fashion weeks are when clothes go on sale." (Shows are mostly for buyers, press and brand-building; clothes reach stores months later, often.)
  - "Sneakerheads just buy shoes." (It is a culture of design history, collaboration, community and a resale market.)
  - "Sustainable" is a clear category. (It is a bundle of contested claims, hence greenwashing.)
- **Concepts that unlock the rest (become foundation units):** silhouettes and garment vocabulary; fabrics and how they behave; construction details; fit words and sizing logic (body-neutral); a working vocabulary for personal style.

## 3. Foundational knowledge

Grouped into modules (these become `foundationalModules[]` and Layer 1 units):

1. **Silhouettes and Garments** (`silhouettes`): the outline vocabulary for dresses, skirts, trousers, tops and outerwear; volume and proportion.
2. **Fabrics and Fibers** (`fabrics`): fiber, yarn, fabric; natural and synthetic fibers; weaves and knits; drape and hand; patterns; care labels.
3. **Construction and Details** (`construction`): shirt anatomy, necklines, sleeves and collars, seams, darts, hems, lining, closures, pockets, quality cues.
4. **Fit and Sizing Vocabulary** (`fit-vocab`): fit words, garment measurements, why sizing is inconsistent, what alterations can change, inclusive and adaptive design. Body-neutral throughout.
5. **Personal Style Language** (`style-language`): color, texture and pattern mixing, capsule wardrobes, dress codes, aesthetic names, and how to read (respectfully) what someone's clothes say about what they love.

Intermediate content adds houses and designers, the calendar, eras, and how the industry works (Layer 2). Culture, history and the debates are in Layer 3.

## 4. Enthusiast model

- **What enthusiasts talk about.** The fit of a specific piece; how a fabric moves; a designer's latest collection; who just got named creative director where; a thrift find and its label; a sneaker drop and whether they got the W or took the L; a runway show's references; whether something is "quiet luxury" or a "dupe"; a garment's provenance; repair and alterations; the ethics of buying.
- **Distinctions that matter to them.** Couture vs ready-to-wear; the house vs its creative director; fiber vs fabric vs finish; retail vs resale; vintage vs secondhand vs reproduction; tailoring vs alterations; "trend" vs "style"; inspiration vs copying.
- **Knowledge that signals genuine understanding.** Naming a silhouette correctly; asking about fabric weight or drape; noticing construction (lining, seam finishes, pattern matching); knowing a house's history without reciting it; knowing that a show is often a brand statement, not a store preview.
- **Beginner statements that sound uninformed.**
  - "Is that a Chanel?" about anything with pearls or tweed (labels are not the only signal).
  - "It looks expensive." said as if that were a fabric.
  - "Vintage is just used clothes."
  - "Couture is all clothes at Paris Fashion Week."
  - "Why would anyone pay that for shoes?" (opens a fight; ask what draws her instead).
  - Guessing someone's size or commenting on a body.
- **Controversies and debates.** Fast fashion vs slow fashion; greenwashing; the creative director carousel; inspiration vs cultural appropriation; body and age representation on runways; dupes and counterfeits; quiet luxury vs logomania; microtrends and overconsumption; thrifting and gentrification of thrift stores; AI in design and imagery; resale price inflation on sneakers.

## 5. Interaction model

- **What the learner should EXPERIENCE instead of reading.** Recognizing shapes and details by sight (spec section 18 visual identification is the heart of this course), reading a garment flat and tapping the collar, placket or yoke, ordering a garment's journey from fiber to shop, deciding what to say in a real conversation (talk tracks and say-this), and weighing judgment calls (is this label a greenwashing claim? is this thrift find worth it?).
- **Unity?** No. Fashion learning is recognition, vocabulary and judgment. It does not need movement, physics, camera perspective or a dynamic scene. A drape simulator could visualize fabric behavior, but a labelled illustration pair (stiff vs fluid) teaches the concept adequately, and cloth simulation would add cost and risk of misleading physics. See section 12 for the full justification.
- **What should NOT be gamified.** Bodies (no "rate this outfit on a body", no size guessing, no "flattering vs unflattering" scoring), budgets (no "cheap vs expensive" judgments as quality proxies; no shaming), religious or cultural dress (taught respectfully, never as costume), and personal style itself (no "correct" style; the course teaches vocabulary, not taste). Sustainability debates are presented with sourced positions, not scored as right/wrong ideology.
- **Chosen mix.** Native visual-id on original illustrations (heaviest), term-match, hotspot-tap on garment flats, sequence-order for process, decision-scenario for thrift/resale/greenwashing judgment, say-this and talk-track for conversation, multiple-choice, fill-the-gap and estimate-slider. No timing-tap or listening-id (see section 12).

## 6. Dynamic information requirements

Fashion has real but modest current context (spec section 10: do not invent data needs). Structured and editorial systems are separate.

| Data | Needed? | Why / provider candidates | Refresh | Fallback |
|---|---|---|---|---|
| Fashion-week calendar (`schedules`, `events`) | Yes, light | "What is on this week?" Sources: CFDA/Fashion Calendar, FHCM (Paris), CNMI (Milan), BFC (London), curated from official pages; no known open API. | weekly; daily in show weeks | Last verified calendar with link-out |
| Creative director appointments (`transactions`) | Yes, curated | Who leads which house is the most common conversation refresh. Curated from press releases with source links. | as it happens; reviewed weekly | Dated "who's where" card |
| Collection / drop / release calendar (`releases`, `new-products`) | Light, branch-gated | Collab drops and sneaker release dates; official brand pages as link-out only; no resale prices. | weekly | Hide card |
| News (`news`) | Yes, link-only | Identify topics; explain in Swoon'd's words; link out. Editorial provider open (L-01). | daily | Evergreen explainer |
| Regulation pulse (`regulations`) | Light | EU ESPR/Digital Product Passport, France fast-fashion law, EU unsold-goods rules: dated explainer cards from official sources (EUR-Lex, ministries). | monthly | Dated card |
| Weather | No | "What to wear today" is styling advice; out of scope. | - | - |
| Prices/resale market data | No | Licensing risk and it invites budget-shaming; explain how resale works instead. | - | - |
| Scores, standings, stats | No | Not a competitive subject. | - | - |

Provider detail, licensing and adapter notes: `live-data.md`.

## 7. Editorial context

- **What commentary helps.** Why a creative director change matters; what a show referenced; why a collab sold out; why a sustainability claim is contested; what a new regulation changes; why a trend has a name.
- **Sources.** Trade and mainstream fashion media (BoF, WWD, Vogue, Fashionista, Highsnobiety, Hypebeast, The Cut), official house and calendar sites, regulator pages. Many are paywalled or restrictive: headline/metadata link-out only.
- **Approach.** Explain in our own words and link. Never copy publisher text or runway-review text. Never redistribute runway photography (agency-licensed).
- **Example prompts.** "Why are people talking about this creative-director change?" "What was that show actually referencing?" "Why did this collab sell out in minutes?" "What is a Digital Product Passport?"

## 8. Personalization

| Dimension | How it personalizes | Default when unset | Tokens / units |
|---|---|---|---|
| `style` | Aesthetic her wardrobe leans toward (minimalist, preppy, streetwear, vintage, avant-garde, romantic, sporty, etc.); shifts examples and branch lessons | `everyday-style` | `{{style}}` in style-language, branches, talk tracks |
| `brand` | A house or label she loves (e.g. a favorite designer, sneaker brand); profile lesson and live cards | none (generic examples) | `{{brand}}` in `hou-07`, `brs-04`, `brl-04`, live |
| `region` | Her fashion week city or local thrift scene; local calendar and store-culture context | none | `{{region}}` in live-01, vintage branch |

The person picks a branch (or several) and a style; personalization changes examples and live context, never the foundation.

## 9. Conversation model

Example lines an enthusiast might say, and what they mean:

| # | She says | Meaning / implied terms | What you could ask next |
|---|---|---|---|
| 1 | "That's a bias-cut slip, it just drapes so well." | Fabric cut diagonally to the weave gives fluid drape; slip dress silhouette. | "Is it silk or satin? Does it move a lot when you walk?" |
| 2 | "I found this incredible 90s blazer at a thrift store, the shoulders are perfect." | 1990s tailoring; shoulders = a construction cue, often structured or padded. | "What do you look at first when you thrift, the label or the fabric?" |
| 3 | "Ugh, the drop sold out in ten seconds." | Limited release; bots/raffle friction; "drop". | "Did you enter the raffle or try at launch?" |
| 4 | "That collection was so quiet luxury." | Understated, logo-free, high-quality basics aesthetic. | "Is it about the fabric quality?" |
| 5 | "I'd never wear that, but the construction is unreal." | Appreciating craft separate from taste. | "What is the detail that gets you?" |
| 6 | "Their new creative director is basically resetting the house." | Creative director sets a house's direction; debut collection. | "What did the last one do that this is a reset from?" |
| 7 | "I'm between sizes; I always have to get things tailored." | Sizing inconsistency; alterations. (Body-neutral: never comment on her body.) | "What is the alteration that makes the biggest difference?" |
| 8 | "It's giving Y2K." | Aesthetic reference: low-rise, baby tees, metallics. | "Which piece is your favorite from that era?" |
| 9 | "Honestly the whole thing feels like greenwashing." | Skepticism about vague sustainability claims. | "What claim made it feel off?" |
| 10 | "The Fall show is Milan first, then Paris, right? I'm waiting on the Prada one." | Fashion month order; brand anticipation. | "Do you watch the shows live or wait for the reviews?" |
| 11 | "It's a Jordan 1 high with a custom colorway." | Basketball high-top archetype; colorway; custom. | "Did you get it at retail or resale?" |
| 12 | "I got this repaired, visible mending is my thing now." | Repair/sashiko-style mending as aesthetic. | "Did you do it yourself?" |

- **What the learner could meaningfully ask next.** Questions about *her* taste: the detail, the era, the fabric, how something feels to wear. Questions about the maker: who designed it, what it was referencing.
- **How Swoon'd helps without encouraging fake expertise.** Every say-this includes a `noFakeExpertNote`; follow-ups are honest curiosity. Talk tracks reward curiosity and penalize fake expertise, price talk about someone's clothes, size guesses and body comments (coach notes explain why).
- **Targets.** 16 talk tracks at launch (8 authored in `exercises.md`), ~80 say-this items.

## 10. Assessment

- **Recognize:** silhouettes, necklines, collars, fabrics/patterns, sneaker archetypes, shirt/jacket/shoe anatomy.
- **Understand:** fiber to fabric; construction logic (why lining, why darts); why sizes are inconsistent; couture vs ready-to-wear; the fashion month order; what a drop is; vintage dating cues.
- **Explain:** what greenwashing looks like; why creative directors matter to a house; why people debate dupes.
- **Interpret situations:** a thrift find with flaws; a "sustainable" label; a friend saying an outfit is "giving" something.
- **Mastery model:** `concept-mastery-v1`, pass threshold 0.75 (recognition-heavy course; misses should not punish taste).
- **Useful competence statement:** "She can follow a conversation about what someone is wearing, a collection or a drop, name the shape or fabric she is talking about, ask a real question about it, and say 'okay, I see why you love this' without faking expertise or judging anyone's body or budget."

## 11. Curriculum map (ongoing course)

Activity codes: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `st` say-this, `fg` fill-the-gap, `es` estimate-slider, `ht` hotspot-tap. Every lesson is authored with 4+ activities (validator `thin-lesson`); the table lists the lead activity families. No lesson uses `unity-sim`.

### Layer 1: Foundations

**Unit `silhouettes`: Silhouettes and Garments** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sil-01` | Outline first | Explain what a silhouette is and why designers begin with it. | silhouette, garment-flat | mc, vi |
| `sil-02` | Dress shapes | Name a-line, sheath, shift, fit-and-flare, wrap, empire and column dresses by outline. | dress-shapes | vi, tm |
| `sil-03` | Skirts by shape | Tell pencil, a-line, circle, pleated, tiered and slip skirts apart. | skirt-shapes | vi, mc |
| `sil-04` | Trousers and legs | Recognize straight, wide-leg, tapered, flare, cargo and jogger shapes. | trouser-shapes, rise | vi, tm |
| `sil-05` | Tops and layers | Identify tee, camisole, button-up, cropped, boxy and oversized tops. | top-shapes | vi, mc |
| `sil-06` | Outerwear shapes | Tell trench, peacoat, bomber, puffer, blazer, parka and cape apart. | outerwear-shapes | vi, tm |
| `sil-07` | Volume and proportion | Explain how volume balance changes an outfit. | volume-and-proportion | ds, st |

**Unit `fabrics`: Fabrics and Fibers** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fab-01` | Fiber, yarn, fabric | Order the journey from fiber to finished fabric. | fiber-yarn-fabric | so, mc |
| `fab-02` | Natural fibers | Match cotton, linen, wool, silk to their traits. | natural-fibers | tm, vi |
| `fab-03` | Synthetic and semi-synthetic | Understand polyester, nylon, elastane, viscose and lyocell. | synthetic-fibers, semi-synthetics | tm, mc |
| `fab-04` | Weaves and knits | Tell woven from knit and name plain, twill, satin and jersey. | weave-vs-knit, weave-types | vi, mc |
| `fab-05` | Fabric words you hear | Decode drape, hand, structure, stretch, breathability. | drape, hand-feel | st, ds |
| `fab-06` | Prints and patterns | Name houndstooth, gingham, plaid, herringbone, paisley, stripes. | pattern-names | vi, tm |
| `fab-07` | Reading a care label | Read fiber content, care symbols and fabric weight. | care-labels, fabric-weight | ds, es, ht |

**Unit `construction`: Construction and Details** (prereq: `silhouettes`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `con-01` | Anatomy of a shirt | Locate collar, placket, cuff, yoke and hem. | shirt-anatomy | ht, mc |
| `con-02` | Necklines | Name crew, V, scoop, boat, halter, cowl, square necklines. | necklines | vi, tm |
| `con-03` | Sleeves and collars | Recognize raglan, set-in, puff, dolman sleeves and common collars. | sleeve-types, collar-types | vi, mc |
| `con-04` | Seams, darts, hems | Explain what seams, darts and hems do. | seams-darts-hems | tm, ht |
| `con-05` | Lining and inside structure | Explain lining, interfacing and canvas. | lining-interfacing | mc, ds |
| `con-06` | Closures and pockets | Identify zips, buttons, hooks, welt and patch pockets. | closures-pockets | vi, tm |
| `con-07` | Spotting quality | Read construction cues at any price point. | quality-cues | ds, bc |

**Unit `fit-vocab`: Fit and Sizing Vocabulary** (prereq: `silhouettes`). 6 lessons. Body-neutral: this unit describes garments, never people.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fit-01` | Fit words | Understand slim, regular, relaxed, oversized and tailored fit as garment cuts. | fit-words | tm, mc |
| `fit-02` | Measuring a garment | Read chest, waist, rise, inseam and shoulder measurements on a flat. | garment-measurements | ht, mc |
| `fit-03` | Sizing is not a number | Explain vanity sizing and why sizes vary by brand. | sizing-inconsistency | mc, st |
| `fit-04` | What a tailor can change | Judge which alterations are usually possible. | alterations | ds, bc |
| `fit-05` | Ease, drape and movement | Understand ease and comfort as design choices. | ease-and-mobility | mc, vi |
| `fit-06` | Inclusive and adaptive design | Explain extended sizing, petite/tall ranges, adaptive clothing. | inclusive-design | mc, ds |

**Unit `style-language`: Personal Style Language** (prereq: `silhouettes`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sty-01` | Color basics | Use palette, neutrals and contrast vocabulary. | color-basics | vi, mc |
| `sty-02` | Texture and pattern mixing | Explain tonal dressing and pattern mixing. | texture-mixing | vi, st |
| `sty-03` | Capsule wardrobes | Explain staples and versatility. | capsule-wardrobe | ds, mc |
| `sty-04` | Dress codes | Decode black tie, cocktail, business casual, smart casual. | dress-codes | mc, ds |
| `sty-05` | Aesthetic names | Match names like minimalism, preppy, gorpcore, quiet luxury, Y2K to what they mean. | aesthetic-names | tm, st |
| `sty-06` | Read her style | Notice what someone's wardrobe signals about what they love, without judging. | style-signals | ds, st |
| `sty-07` | Complimenting well | Give specific, non-body compliments and ask real questions. | convo-style-compliments | tk, st |

### Layer 2: Intermediate

**Unit `houses`: Designers and Houses** (prereq: `silhouettes`, `construction`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hou-01` | What a fashion house is | Explain maison, couturier, creative director. | fashion-house, creative-director | mc, tm |
| `hou-02` | Founding icons | Link a few houses to what they invented (tweed jacket, New Look, tuxedo for women, sculptural cut). | founding-houses | mc, st |
| `hou-03` | Groups and owners | Explain luxury groups and independent houses. | luxury-groups | tm, mc |
| `hou-04` | Italian craft and American sportswear | Contrast Milan craft with American sportswear. | italian-craft, american-sportswear | mc, st |
| `hou-05` | Japanese and Belgian avant-garde | Explain deconstruction and the avant-garde tradition. | avant-garde-japan-belgium | mc, st |
| `hou-06` | Independent and emerging designers | Understand prizes, incubators and small labels. | emerging-designers | mc, ds |
| `hou-07` | Who designs what now | Read a dated "who's where" card and ask about `{{brand}}`. | creative-director-now | st, mc |

**Unit `calendar`: Weeks and the Calendar** (prereq: `houses`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cal-01` | Four capitals, one month | Order New York, London, Milan, Paris. | big-four-weeks | so, mc |
| `cal-02` | Seasons and collection names | Decode SS/FW, resort, cruise, pre-fall and why shows are months ahead. | fashion-seasons | tm, ds |
| `cal-03` | Couture and menswear weeks | Explain haute couture as a designation; know menswear weeks exist. | haute-couture, menswear-weeks | mc, tm |
| `cal-04` | What happens at a show | Distinguish show, presentation, showroom, front row, buyers. | show-anatomy | so, st |
| `cal-05` | From show to store | Follow wholesale, direct-to-consumer, see-now-buy-now. | show-to-store | so, mc |
| `cal-06` | Big cultural nights | Explain the Met Gala, red carpets and fashion awards. | fashion-events | mc, st |

**Unit `eras`: Eras and Icons** (prereq: `silhouettes`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `era-01` | 1920s to 1950s | Link flapper, bias cut and the New Look to their shapes. | era-early-century | vi, so |
| `era-02` | 1960s and 1970s | Recognize mod, disco, punk cues. | era-60s-70s | vi, mc |
| `era-03` | The 1980s | Recognize power dressing and logo mania. | era-80s | vi, st |
| `era-04` | The 1990s | Contrast minimalism and grunge. | era-90s | vi, st |
| `era-05` | The 2000s | Decode Y2K, low-rise, fast-fashion boom. | era-2000s | vi, mc |
| `era-06` | 2010s to now | Understand athleisure, social media and microtrends. | era-2010s-now | mc, st |

**Unit `industry`: How the Industry Works** (prereq: `houses`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ind-01` | Idea to garment | Order sketch, pattern, sample, grading, production. | design-process | so, mc |
| `ind-02` | Who does what | Explain designer, pattern cutter, stylist, editor, buyer, merchandiser. | industry-roles | tm, mc |
| `ind-03` | Fast, slow, and in between | Contrast fast, ultra-fast and slow fashion. | fast-slow-fashion | mc, st |
| `ind-04` | Craft, price and labels | Explain why luxury costs what it does without shaming any budget. | luxury-pricing, made-in-labels | mc, ds |
| `ind-05` | Collabs and capsules | Explain collaborations and capsule collections. | collabs-capsules | mc, st |
| `ind-06` | Media and forecasting | Explain fashion media and trend forecasting. | fashion-media, trend-forecasting | mc, st |

### Layer 3: Enthusiast depth

**Unit `sneaker-streetwear`: Streetwear and Sneaker Culture** (prereq: `silhouettes`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `snk-01` | Where streetwear came from | Trace streetwear to skate, hip-hop, surf and punk. | streetwear-origins | so, mc |
| `snk-02` | Anatomy of a sneaker | Locate upper, midsole, outsole, toe box, tongue, heel counter. | sneaker-anatomy | ht, tm |
| `snk-03` | Sneaker archetypes | Identify court, basketball high-top, runner, skate, chunky trainer shapes. | sneaker-archetypes | vi, mc |
| `snk-04` | Drops, raffles, bots | Decode drop, raffle, colorway, retail vs resale. | drop-culture | st, tm |
| `snk-05` | Resale and authentication | Judge resale safety and authentication cues. | resale-and-auth | ds, mc |
| `snk-06` | Collabs and hype | Explain hype cycles and grails. | hype-cycle | st, mc |
| `snk-07` | Care and wear | Explain sneaker care and the wear-or-keep debate. | sneaker-care | ds, bc |

**Unit `vintage-thrift`: Vintage and Thrift** (prereq: `fabrics`, `construction`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `vin-01` | Vintage, secondhand, retro | Define vintage, secondhand, reproduction, deadstock. | vintage-defined | tm, mc |
| `vin-02` | Dating a garment | Read label, zipper, tag and construction cues. | dating-cues | ht, ds |
| `vin-03` | Thrift strategy | Scan a rack by fabric and measurements, not tags. | thrift-strategy | ds, mc |
| `vin-04` | Resale platforms and markets | Compare consignment, marketplaces, flea markets. | resale-channels | mc, ds |
| `vin-05` | Condition and repair | Read condition terms; understand mending. | condition-repair | tm, ds |
| `vin-06` | Sizing across decades | Explain why vintage sizes differ; measure, do not guess. | vintage-sizing | mc, es |
| `vin-07` | Thrifting ethics | Explain the gentrification debate and donating well. | thrift-ethics | st, ds |

**Unit `sustainability`: Sustainability Debates** (prereq: `fabrics`, `industry`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sus-01` | What the debate is about | State the main concerns (water, emissions, waste, labor) without doom. | fashion-footprint | mc, st |
| `sus-02` | Fibers compared | Compare fiber trade-offs; no single winner. | fiber-tradeoffs | tm, mc |
| `sus-03` | Greenwashing | Spot vague or unsupported claims; know certification names. | greenwashing | ds, st |
| `sus-04` | Labor and supply chains | Explain supply-chain transparency and why it matters. | supply-chain | mc, st |
| `sus-05` | Rules are changing | Explain EU and national rules as a dated explainer. | fashion-regulation | mc, st |
| `sus-06` | Buy less, buy better, borrow | Discuss repair, resale, rental, cost-per-wear without shaming. | circular-fashion | ds, es, st |

**Unit `debates`: Debates and Culture** (prereq: `houses` or `sneaker-streetwear`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `deb-01` | Inspiration or appropriation | Represent both sides respectfully. | debate-appropriation | st, ds |
| `deb-02` | Who is on the runway | Discuss casting, age, size and representation without judging bodies. | debate-representation | st, mc |
| `deb-03` | Dupes and knockoffs | Explain dupes, counterfeits and trade dress. | debate-dupes | st, ds |
| `deb-04` | Quiet luxury vs logos | Explain the swing between understated and loud. | debate-quiet-vs-logo | st, mc |
| `deb-05` | Trend cycles and microtrends | Explain the ~20-year revival idea and microtrends. | debate-trend-cycles | st, mc |
| `deb-06` | The carousel and AI | Explain creative-director turnover and AI in fashion. | debate-carousel-ai | st, mc |

### Layer 4: Branches and personalization

One unit per branch (contract 1.2: `layer: branch`, unit-level `branchId`). `everyday-style` is the default and lives in the core units. Lessons use `{{style}}`, `{{brand}}`, `{{region}}`.

**Unit `branch-streetwear`** (branch `streetwear`; prereq: `sneaker-streetwear`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `brs-01` | Her streetwear world | Picture the scene: skate, sneakers, thrifted graphic tees. | streetwear-scene | mc, st |
| `brs-02` | Drop day | Read a drop calendar and the raffle process. | drop-day | so, ds |
| `brs-03` | Roots in skate, hip-hop, Tokyo | Follow subculture lineages. | streetwear-lineages | mc, st |
| `brs-04` | Her favorite `{{brand}}` | Build a profile of the brand she loves. | favorite-brand-profile | st, mc |

**Unit `branch-luxury-runway`** (branch `luxury-runway`; prereq: `houses`, `calendar`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `brl-01` | Following a collection | Read a collection as a story: references, palette, silhouettes. | collection-reading | vi, st |
| `brl-02` | Reading a show review | Decode review vocabulary without copying any review. | show-review-language | st, mc |
| `brl-03` | Couture as craft | Explain atelier work and why it is slow. | atelier-craft | mc, so |
| `brl-04` | Her favorite `{{brand}}` | Profile the house she loves and its current direction. | favorite-brand-profile | st, mc |

**Unit `branch-vintage`** (branch `vintage`; prereq: `vintage-thrift`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `brv-01` | Her hunting grounds | Understand estate sales, markets, consignment. | vintage-hunting | mc, ds |
| `brv-02` | The era she loves | Dive into `{{era}}` shapes and fabrics. | favorite-era-profile | vi, st |
| `brv-03` | Talking about finds | Ask good questions about a find's story. | convo-vintage-finds | tk, st |
| `brv-04` | Rescuing pieces | Understand mending, cleaning and restoring at a general level. | rescue-and-repair | ds, mc |

**Unit `branch-menswear-tailoring`** (branch `menswear-tailoring`; prereq: `construction`, `fit-vocab`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `brm-01` | Anatomy of a jacket | Locate lapel, gorge, canvas, vent, pocket types. | jacket-anatomy | ht, mc |
| `brm-02` | Lapels, buttons, cuts | Tell notch, peak, shawl; single vs double breasted. | suit-styles | vi, tm |
| `brm-03` | Shirts, ties, shoes | Recognize collars, tie knots (names), oxford/derby/loafer. | menswear-details | vi, tm |
| `brm-04` | Fit at the tailor | Explain shoulder, sleeve, break and taper choices. | tailoring-fit | ds, mc |
| `brm-05` | Dress codes in tailoring | Apply dress codes to tailored pieces. | tailoring-dress-codes | ds, st |

### Layer 5: Current season / live

**Unit `season-now`: Fashion Now** (prereq: any two of `houses`, `calendar`, `sneaker-streetwear`). Templated; refreshed by `live` hooks and editorial cards. 6 lesson templates.

| Lesson id | Title | Objective | conceptIds | Activities | Live hook |
|---|---|---|---|---|---|
| `live-01` | This month in fashion | Know which shows or drops are on and why. | live-weekly-context | mc, st | schedules, events |
| `live-02` | Who's designing where | Read the dated creative-director card. | creative-director-now | mc, st | transactions |
| `live-03` | The show everyone is discussing | Understand references and reception in our own words. | live-show-explainer | st, mc | news |
| `live-04` | Drop and release watch | Read what launches and why it matters. | drop-day | mc, ds | releases, new-products |
| `live-05` | The trend of the moment | Explain the current buzzword and where it came from. | live-trend-explainer | st, mc | news |
| `live-06` | Rules pulse | Understand the latest regulation card. | fashion-regulation | mc, st | regulations |

### Layer 6: Conversation practice and perpetual review

**Unit `conversation-lab`: Conversation Lab** (prereq: any three foundation units). 8 lessons; also feeds the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | Her outfit story | Ask about a detail she is proud of. | convo-style-compliments, style-signals | tk, st |
| `talk-02` | The thrift find | Respond to a find with curiosity. | convo-vintage-finds, dating-cues | tk, st |
| `talk-03` | Fashion week chatter | Follow along in show season. | big-four-weeks, convo-fashion-week | tk, st |
| `talk-04` | The sneaker drop | Handle a win or a missed drop. | drop-culture, convo-drop | tk, st |
| `talk-05` | Between sizes | Support without body talk. | sizing-inconsistency, convo-fit-talk | tk, st |
| `talk-06` | Her favorite designer | Ask about the house she loves. | creative-director, favorite-brand-profile | tk, st |
| `talk-07` | The sustainability chat | Discuss without lecturing. | greenwashing, convo-sustainability | tk, ds |
| `talk-08` | Say-this gauntlet | Decode five lines in a row. | (all layers, sampled) | st |

**Unit `review-loop`: Perpetual Review** (always available after first lesson). 4 lesson templates.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Daily Bite | 1 card from due concepts. | (due concepts) | mc, fg |
| `review-02` | Weekly mix | 3-round session sampled by weakness. | (weak concepts) | mc, vi, ds, tk |
| `review-03` | Shape spotter | Timed-free visual mastery check across silhouettes, necklines, collars. | dress-shapes, necklines, collar-types | vi, ht |
| `review-04` | Term blitz | Playbook term drill. | (terms) | tm, fg |

**Review policy:** intervals 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; a concept below 0.6 re-enters at 1d. Visual concepts are reviewed with varied illustrations so recognition is not memorized from one image.

### Concept targets, personalization slots, release plan

- **Concept count target:** ~150 Playbook concepts (Appendix).
- **Personalization slots:** `{{style}}`, `{{brand}}`, `{{era}}` (vintage), `{{region}}`.
- **Release plan:**
  - **Launch (v0.1-1.0):** `silhouettes`, `fabrics`, `construction`, `fit-vocab`, `style-language`, `houses`, `calendar`, `conversation-lab`, `review-loop`; default `everyday-style`.
  - **Fast follow (1.1):** `eras`, `industry`, `sneaker-streetwear`, `vintage-thrift`, branches `streetwear`, `vintage`; `season-now` with calendar and creative-director cards.
  - **Ongoing:** `sustainability`, `debates`, branches `luxury-runway`, `menswear-tailoring`; new talk tracks each fashion month (Feb-Mar, Sep-Oct), couture weeks (Jan, Jul), and drop seasons.

### Appendix: Playbook concepts (ids)

<<APPENDIX>>

---

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4): Unity only where spatial reasoning, movement, physics, timing in a scene, or camera perspective materially improves learning and a native exercise would teach it clearly worse.

**Verdict: zero Unity simulations (Tier A count 0).** Reasons:
1. **Recognition is the skill.** Silhouettes, necklines, collars, fabrics, patterns and sneaker archetypes are learned by looking at clear static illustrations, which `visual-id` and `hotspot-tap` do better than a 3D scene.
2. **No dynamic scene.** Nothing in the course depends on things moving over time in space. Drape and movement can be shown with paired illustrations (stiff vs fluid) and precise words.
3. **Cloth simulation is the only temptation and it fails the rubric.** A draping sim would be costly, would need a body model (raising the body-neutrality risk the course avoids) and would mislead if physics were imperfect. A native `visual-id` pair plus `st` vocabulary teaches "drape" adequately.
4. **Judgment is text-shaped.** Greenwashing, thrift decisions, resale safety and conversations are `decision-scenario`, `say-this` and `talk-track`.
5. **No 1D timing or audio need.** `timing-tap` and `listening-id` are unused: nothing here is a timing feel, and fabric "sounds" (silk rustle, denim) would not carry social competence. Reconsider `listening-id` only if licensed or original audio adds real value.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Silhouettes, necklines, sleeves, collars, patterns, eras, sneaker archetypes | dress-shapes, necklines, collar-types, pattern-names, sneaker-archetypes | `visual-id` (original illustrations, license `original-swoond`) | Spec section 18 core skill. Alt text describes distinguishing features without giving away the answer. No photos, no logos. | B | ~120 |
| Garment anatomy (shirt, jacket, sneaker, care label) | shirt-anatomy, jacket-anatomy, sneaker-anatomy, care-labels | `hotspot-tap` on procedural garment flats | Fixed diagram, no motion. | B | ~50 |
| Terms and definitions | necklines, fit-words, fabric words, luxury-groups | `term-match`, `fill-the-gap`, `multiple-choice` | Recall and recognition. | B | ~200 |
| Process order (fiber to fabric, idea to garment, show to store, drop day) | design-process, fiber-yarn-fabric, show-to-store | `sequence-order` | Order is the concept; `why` text carries the logic. | B | ~25 |
| Two-way judgments (alteration possible? flaw or feature?) | alterations, quality-cues | `binary-call` | Clear yes/no on a static example. | B | ~25 |
| Judgment (thrift, resale, greenwashing, dress codes, alterations) | thrift-strategy, greenwashing, resale-and-auth | `decision-scenario` | Facts, consequences, expert note; no fake game. Body- and budget-neutral wording; `safetyNote` where scams or claims matter. | B | ~55 |
| Magnitudes (fabric weight, garment measurements, wears per item) | fabric-weight, garment-measurements | `estimate-slider` | Numeric intuition; never a body measurement. | B | ~12 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice (Talk tab and unit ends). | B | 16 talk tracks + ~80 say-this |
| Review | due concepts | `multiple-choice`, `fill-the-gap` | Daily Bite. | B | (pool) |

**Not used:** `unity-sim`, `timing-tap`, `listening-id`. No sim specs are written (no `sims/` folder).

---

## 13. Licensing & safety

- **Imagery (spec section 18, 40).** Original vector illustrations and procedural garment flats only, license id `original-swoond`. No runway or editorial photos (agency-licensed: Getty, Vogue Runway, etc.), no model or celebrity likeness, no street-style photography. Real runway looks are discussed in words and linked out.
- **Logos and trademarks.** No house, sneaker or streetwear logos in art. Monogram patterns, trade dress and signature marks (interlocking-letter logos, monogram canvases, signature check patterns, red soles, stripes on sneakers, famous shoe outlines) are not reproduced; sneaker archetypes use generic, invented shapes. Brand and designer names appear as text facts only.
- **Designer likeness and quotes.** Names as facts; no likeness; no fabricated quotes; no long quotes.
- **Article text.** Never copy publisher, review or press-release text; paraphrase and link.
- **Data terms.** Curated calendar facts with source links; no resale-price data; no scraping of paywalled or restricted sites (`live-data.md`).
- **Audio/video.** None planned; runway video is link-out only.
- **Cultural and religious dress.** Taught with names, contexts and respect; never as costume or aesthetic props; appropriation debates presented from multiple perspectives.
- **Body neutrality (product rule).** Garments have sizes and cuts; people do not have "good" or "bad" bodies. No body-shape typing ("apple", "pear") as prescription; no "flattering" as a verdict; no weight, dieting or size commentary; sizing content explains the industry's inconsistencies. `talk-track` coach notes flag body and size comments as cringe.
- **Budget neutrality.** No shaming price points in any direction; "expensive" and "cheap" are never quality shortcuts; thrift, fast fashion and luxury are all discussed as choices with trade-offs. Sustainability lessons never moralize; they explain claims and trade-offs.
- **Safety.** Resale and authentication scenarios note scam risks generally (payment protection, platform authentication) and never teach how to fake goods. Vintage care advice stays generic (test, patch, ask a professional for delicate pieces). No medical, allergy or skin claims (that is `skincare`).

## 14. Content assets

| Asset | Used by | Approach |
|---|---|---|
| Garment flats (dress, skirt, trouser, top, outerwear silhouettes; necklines; sleeves; collars) | `visual-id`, `hotspot-tap` | Original vector SVG, faceless and body-free (flat-lay only) so no body model is implied. `original-swoond`. |
| Fabric/pattern swatches | `visual-id`, `term-match` | Procedural weave and pattern swatches (twill, satin, houndstooth, gingham, herringbone, plaid). `original-swoond`. |
| Sneaker archetype line drawings | `visual-id`, `hotspot-tap` | Original generic shapes, no brand cues. `original-swoond`. |
| Anatomy diagrams (`fashion-shirt-anatomy`, `fashion-jacket-anatomy`, `fashion-sneaker-anatomy`, `fashion-care-label`) | `hotspot-tap` | Procedural diagrams. `original-swoond`. |
| Era icons (1920s to 2010s silhouettes) | `visual-id` | Original flats. `original-swoond`. |

Estimated ~220 unique illustrations at full launch; ~90 for v1.0. Alt text must describe features, not the answer.

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. What does a beginner need to understand? Sections 2-3: silhouettes, fabrics, construction, fit words (body-neutral), style vocabulary.
- [x] 2. What do enthusiasts care about? Section 4: detail, craft, houses and creative directors, drops, thrift finds, debates.
- [x] 3. What current information matters? Section 6: fashion-week calendar, creative-director appointments, releases, regulation pulse; all curated and dated.
- [x] 4. What should be interactive? Section 5 and 12: visual identification, anatomy hotspots, process ordering, judgment, conversation.
- [x] 5. What should NOT be gamified? Bodies, budgets, cultural dress, taste itself (section 5).
- [x] 6. How should it personalize? `style`, `brand`, `region`; branches (section 8).
- [x] 7. What does conversational competence look like? Section 9 and 10.
- [x] 8. What data providers are needed? Curated official calendars, press releases, regulator pages; no live-data vendor at launch (`live-data.md`).
- [x] 9. What licensing constraints apply? Section 13: original art only; no runway photos or logos.
- [x] 10. How will Swoon'd measure useful understanding? Concept mastery at 0.75; visual and conversation items; section 10.

Additional gates: [x] manifest validates (see validator run); [ ] curriculum validates (not authored yet); [x] every Unity sim has an approved spec (none exist); [ ] every image/audio asset has a license id (assets not yet produced; plan is `original-swoond` for all); [ ] voice review; [x] no copied publisher text.

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Illustration production: who produces ~90 v1.0 original flats (in-house vector art, commissioned, procedural)? | Product / design | Blocks `visual-id` content |
| 2 | Is a licensed source acceptable for any real runway imagery (agency license) or do we stay illustration-only forever? Default: illustration-only. | Product owner | No |
| 3 | Editorial provider for the current layer (L-01). Default: link-only headlines, Swoon'd explainers. | Product owner | Blocks automated live cards |
| 4 | Fashion-week calendar source and licence (CFDA Fashion Calendar, FHCM, CNMI, BFC): curated facts vs feed. | Content lead | No (curated fallback) |
| 5 | Legal read on naming brands and designers in lesson titles and store copy, and on "haute couture" as a protected term. | Legal | No |
| 6 | SME review of sensitive lessons: appropriation, representation, religious dress, sizing and inclusion. | SME | Blocks those lessons |
| 7 | Facts to re-verify at release: creative director roster; Prada-Versace ownership; EU DPP timeline; France fast-fashion law status; SS27 calendar. | Content lead | No |
