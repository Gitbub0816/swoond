# Course Catalog

Union of the product spec reference courses (section 45) and the design prototype's 20 launch interests (`docs/design/DESIGN_SPEC.md` section 9). This is the working plan of the first 28 courses, not the final 150-200 (spec sections 43, 46). Quality over count.

Status values mirror the manifest `status` enum: not-started, cds-draft, cds-approved, content-in-progress, in-review, released. Keep this table in sync with each `manifest.json`. `Sims` = planned Unity simulations in the manifest `unitySimulations[]`; `Lessons` = planned lessons in the CDS Curriculum map (not yet authored JSON).

## Waves

- **Wave 1 (8):** American Football, NASCAR, Formula 1, Pickleball, Hiking, Basketball, Hockey, Soccer.
- **Wave 2 (13):** Baseball, Golf, Tennis, Cooking, Movies, Music, Video Games, Pottery, Photography, Camping, Cars, Books, Fashion.
- **Wave 3 (7 listed, more to come):** Anime, K-pop, Climbing, Wine, Skincare, Coffee, Horror Films, then the next candidates chosen from the ~250-300 pool (spec section 43).

Wave 1 status (2026-09-30): all eight courses have a CDS, manifest, sim specs and exercise/live-data plans (`cds-draft`); 41 Unity sims are specced and none built. Curriculum JSON authoring is under way (split per-unit layout). Consolidated Game Kit needs: `docs/astra/GAME_KIT.md` section 5; build order: `docs/astra/ROADMAP.md`; decisions and reviews: `docs/product/OPEN_QUESTIONS.md`.

Wave 1 is chosen for deliberate variety (spec section 45): live data + simulation + terminology + conversation (football, basketball, hockey, soccer, NASCAR, F1), environmental data + judgment (hiking), and a rules-driven sport without live data emphasis (pickleball).

## Catalog

| Course ID | Display name | Family | Category | Wave | Boundary notes (spec section 6) | Likely interaction mix | Sims | Lessons | Status |
|---|---|---|---|---|---|---|---|---|---|
| `american-football` | American Football | Sports | Sports > American Football | 1 | Foundation course; NFL and College Football are branches (spec section 5). Team = personalization. | Unity (coverage/route reads), native terms, say-this, live scores | 5 | 117 (17 units) | `cds-draft` |
| `nascar` | NASCAR | Motorsports | Sports > Motorsports > NASCAR | 1 | Independent of F1 (spec section 5). Series (Cup/Xfinity/Truck) are branches; driver/team personalize. | Unity (drafting, pit strategy), native timing/decision, live results | 6 | 108 (15 units) | `cds-draft` |
| `formula-1` | Formula 1 | Motorsports | Sports > Motorsports > Formula 1 | 1 | Independent of NASCAR and IndyCar. Team/driver personalize. | Unity (tire strategy, overtakes), native decision scenarios, live results | 6 | 106 (15 units) | `cds-draft` |
| `pickleball` | Pickleball | Sports | Sports > Racquet sports > Pickleball | 1 | Adjacent to tennis but independent (rules/kitchen/scoring differ). | Unity (kitchen momentum, third shot, coverage), native binary-call/scoring, curated results | 5 | 107 (15 units) | `cds-draft` |
| `hiking` | Hiking | Outdoors & Adventure | Outdoors > Hiking | 1 | Independent of camping and climbing; not modeled like a sport (spec section 38). Region/destination personalize. | Native decision-scenarios, hotspot/visual-id, conditions data; one Tier A sim (topo-terrain, isolated to 5 lessons with a native fallback) | 1 | 115 (16 units) | `cds-draft` |
| `basketball` | Basketball | Sports | Sports > Basketball | 1 | Foundation; NBA (default), WNBA and college (men's and women's, one branch) are branches. Team/player personalize. | Unity (spacing, screens), native terms, live scores | 6 | 114 (15 units) | `cds-draft` |
| `hockey` | Hockey | Sports | Sports > Hockey | 1 | Foundation; NHL primary branch, PWHL and international are later branches. Team personalizes. | Unity (offside, icing, power-play spacing, forecheck, coverage), native (penalties, terms), live scores | 6 | 113 (16 units) | `cds-draft` |
| `soccer` | Soccer | Sports | Sports > Soccer | 1 | Foundation; leagues and tournaments (Premier League, La Liga, MLS, NWSL, Champions League, World Cup) are branches; club personalizes. | Unity (offside, shape, pressing, set pieces, line height), native terms, live scores | 6 | 115 (20 units) | `cds-draft` |
| `baseball` | Baseball | Sports | Sports > Baseball | 2 | Foundation; MLB primary branch. Team/player personalize. | Native (scoring, count), possible Unity (defensive positioning), live scores | - | - | `not-started` |
| `golf` | Golf | Sports | Sports > Golf | 2 | Independent; tours (PGA, LPGA) are branches. | Unity (shot shape, course management), native terms | - | - | `not-started` |
| `tennis` | Tennis | Sports | Sports > Racquet sports > Tennis | 2 | Adjacent to pickleball, independent. Tours are branches. | Native scoring, possible Unity (serve/court position), live scores | - | - | `not-started` |
| `cooking` | Cooking | Food & Cooking | Food & Cooking > Cooking | 2 | Independent of coffee and wine. Cuisine personalizes. | Native sequence-order, decision-scenario, visual-id; no Unity | - | - | `not-started` |
| `movies` | Movies | Film & Television | Film & Television > Movies | 2 | Foundation for film language; horror is a candidate branch or independent (decide in CDS). Director/franchise personalize. | Native visual-id, say-this, media metadata; licensing-sensitive | - | - | `not-started` |
| `music` | Music | Music | Music > Music | 2 | Genre/artist are personalization; K-pop is independent (culture and fandom differ). | Native listening-id (licensed audio only), say-this, release feed | - | - | `not-started` |
| `video-games` | Video Games | Gaming | Gaming > Video games | 2 | Platform (PC/console/mobile) and franchise personalize; genres are branches. | Native visual-id, say-this; no Unity | - | - | `not-started` |
| `pottery` | Pottery | Crafts | Crafts > Ceramics > Pottery | 2 | Independent; techniques are units. | Native sequence-order, visual-id, decision-scenario (why did it crack?) | - | - | `not-started` |
| `photography` | Photography | Arts | Arts > Photography | 2 | Independent; equipment personalizes. | Native estimate-slider (exposure), decision-scenario, visual-id | - | - | `not-started` |
| `camping` | Camping | Outdoors & Adventure | Outdoors > Camping | 2 | Adjacent to hiking, independent. Region/destination personalize. | Native decision-scenarios, sequence-order; conditions data | - | - | `not-started` |
| `cars` | Cars | Cars & Automotive | Cars & Automotive > Cars | 2 | Independent of motorsport courses. Brand/make personalize. | Native visual-id, term-match | - | - | `not-started` |
| `books` | Books | Books & Literature | Books & Literature > Books | 2 | Genre and author personalize; recommend without redistributing text (spec section 40). | Native say-this, term-match, recommendations | - | - | `not-started` |
| `fashion` | Fashion | Fashion & Beauty | Fashion & Beauty > Fashion | 2 | Independent of skincare. Style/brand personalize. | Native visual-id, term-match, say-this; imagery licensing | - | - | `not-started` |
| `anime` | Anime | Film & Television | Film & Television > Anime | 3 | Independent of movies (culture/terms); franchise personalizes. | Native visual-id, say-this, term-match; licensing-sensitive | - | - | `not-started` |
| `k-pop` | K-pop | Music | Music > K-pop | 3 | Independent of music (fandom culture, groups, comebacks). Group/artist personalize. | Native say-this, term-match, listening-id (licensed only), release feed | - | - | `not-started` |
| `climbing` | Climbing | Outdoors & Adventure | Outdoors > Climbing | 3 | Adjacent to hiking, independent; disciplines (bouldering, sport, trad) are branches. | Native decision-scenarios, hotspot-tap; safety-critical copy | - | - | `not-started` |
| `wine` | Wine | Food & Cooking | Food & Cooking > Wine | 3 | Independent; region/grape personalize. | Native visual-id, term-match, decision-scenario | - | - | `not-started` |
| `skincare` | Skincare | Fashion & Beauty | Fashion & Beauty > Skincare | 3 | Independent of fashion. | Native term-match, decision-scenario; safety/claims care | - | - | `not-started` |
| `coffee` | Coffee | Food & Cooking | Food & Cooking > Coffee | 3 | Independent of cooking and wine. | Native sequence-order, estimate-slider, term-match | - | - | `not-started` |
| `horror-films` | Horror Films | Film & Television | Film & Television > Movies > Horror | 3 | Boundary test vs movies: partially transfers; default independent course sharing film terms via cross-links. | Native visual-id, say-this; licensing-sensitive | - | - | `not-started` |

(Interaction mix is a starting hypothesis; each CDS decides via the Tier rubric.)

## Boundary decisions to apply in CDS work

- **Shared foundation with branches:** American Football (NFL, college), Basketball (NBA, college, WNBA), Soccer (leagues), Baseball (MLB), Hockey (NHL).
- **Independent despite shared data provider:** NASCAR, Formula 1 (and future IndyCar, MotoGP, WRC): one motorsports API does not imply one course (spec section 36).
- **Adjacent, independent:** Pickleball/Tennis, Hiking/Camping/Climbing, Cooking/Coffee/Wine, Movies/Horror Films/Anime, Music/K-pop, Fashion/Skincare. Cross-link concepts; do not merge courses.
- **Course IDs** use the kebab-case values above; simulation prefixes are chosen per CDS (e.g. `football` for `american-football`).

## Not in the catalog yet

- **Other / Request an Interest** (spec section 44): requests are stored as roadmap data; no auto-generated low-quality courses.
- The remaining families (Aviation, Technology, Fitness, Animals & Nature, Travel, History & Culture, Collecting) have no scheduled courses yet; candidates come from the catalog development process (spec section 43).
