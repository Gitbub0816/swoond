# SWOON'D
## Product & Technical Design Specification

**Status:** Initial Working Specification
**Product:** Swoon'd
**Tagline:** Get into what they're into.
**Primary Platforms:** iOS and Android
**Native iOS:** Swift + SwiftUI
**Native Android:** Kotlin + Jetpack Compose
**Interactive Simulation Engine:** Unity
**Unity / Game Development:** ChatGPT Work / Astra
**Native Application Development:** Claude Code

> Source of truth supplied by the product owner. Do not edit the substance of this document without product-owner approval; add clarifications in `docs/product/DECISIONS.md` instead.

---

# 1. PRODUCT VISION

Swoon'd is an educational application designed to help someone learn the interests of another person they care about.

The initial and strongest consumer use case is romantic:

> "My crush is really into something I know nothing about."

Examples:

- She loves American football, but I know nothing about football.
- He follows NASCAR, but I don't understand racing.
- She plays pickleball, but I don't know the rules.
- He loves hiking, but I've never really hiked.
- She loves pottery, but I don't know anything about ceramics.
- He loves Formula 1, but I don't understand why people care about tire compounds.

Swoon'd teaches the learner enough about that interest to genuinely understand it, participate in conversations about it, recognize important concepts, and better appreciate why the other person enjoys it.

Swoon'd is NOT intended to make every learner an expert.

The objective is:

**Socially useful competence.**

A successful Swoon'd experience should eventually produce:

> "Wait. I actually understand what you're talking about now."

That is the fundamental product outcome.

---

# 2. PERSON-CENTERED PRODUCT MODEL

Traditional educational applications begin with:

> What do you want to learn?

Swoon'd should instead begin with:

> Who are you learning for?

The primary object is therefore the PERSON rather than the COURSE.

Example:

```
Sarah
├── American Football
│   ├── NFL
│   └── Favorite Team: Philadelphia Eagles
├── Pickleball
└── Hiking
```

The user is not simply "learning football."

The user is learning football because football matters to Sarah.

This distinction should influence the entire UX.

Potential relationships include:

- Crush
- Dating partner
- Spouse
- Friend
- Family member
- Parent
- Child
- Coworker
- Other

The romantic/crush use case should remain the strongest initial marketing hook without artificially limiting the underlying product.

---

# 3. CORE PRODUCT PRINCIPLE

Swoon'd should NOT be an AI encyclopedia wrapped in gamification.

The launch product should eventually contain approximately 150-200 deliberately supported interests.

However:

**We are designing 150-200 COURSES, not creating 150-200 labels and pouring information into one generic template.**

Every course must be intentionally designed around how people actually experience that interest.

Courses may share:

- Infrastructure
- Design language
- XP systems
- Progression
- Authentication
- Profiles
- Lesson rendering
- Conversation systems
- Assessment systems
- Data ingestion infrastructure
- Unity infrastructure
- Reusable game primitives

They should NOT automatically share:

- Curriculum structure
- Lesson progression
- Interaction model
- Dynamic data requirements
- Assessment methodology
- Game mechanics
- Personalization dimensions

The subject determines the learning experience.

The platform should accommodate that rather than forcing the subject into a generic course template.

---

# 4. THE LANGUAGE-LEARNING ANALOGY

Swoon'd should treat different interests similarly to how a high-quality language platform must treat different languages.

You cannot properly teach Chinese by taking a Spanish course and replacing Spanish words with Chinese glyphs.

Languages differ in: grammar, sentence structure, writing systems, pronunciation, syntax, punctuation, cultural context.

Likewise, interests differ in: rules, terminology, culture, strategy, relevant current information, physical skills, visual recognition, social conversation, competitive structure, history, interaction.

Therefore Swoon'd must intentionally architect each course.

---

# 5. TAXONOMY IS NOT CURRICULUM

Swoon'd needs organizational categories. However, a category is NOT automatically a course.

```
Sports
└── Motorsports
    ├── NASCAR
    ├── Formula 1
    ├── IndyCar
    ├── MotoGP
    ├── Rally / WRC
    ├── Drag Racing
    └── Kart Racing
```

"Motorsports" is an organizational category. It should NOT be treated as a single learning course.

NASCAR and Formula 1 are fundamentally different interests. They differ in: rules, race formats, vehicles, strategy, pit strategy, tire management, tracks, teams, manufacturers, culture, terminology, championships, fan discussion, competition structure.

Knowing NASCAR does not make someone conversationally competent about Formula 1. Therefore they require separate courses.

Contrast this with:

```
Sports
└── American Football
    ├── NFL
    └── College Football
```

NFL and NCAA football contain meaningful differences, but the fundamental sport transfers substantially. Therefore **American Football** can be the foundational course. NFL and college football can become branches/personalization layers.

---

# 6. COURSE BOUNDARY TEST

When deciding whether two related subjects deserve independent courses, use this question:

> If someone learns A, does that knowledge make them meaningfully conversationally competent about B?

If substantially YES: they may share a foundational course with branches.

If substantially NO: they should generally be independent courses.

---

# 7. INTEREST HIERARCHY

Category → Interest / Course → Branch → Person-specific personalization

Example: Sports → Motorsports → NASCAR → Cup Series → Hendrick Motorsports → Kyle Larson. The course is NASCAR. Series, team and driver preferences personalize that course.

Example: Sports → American Football → NFL → Philadelphia Eagles → Favorite players. The foundational American Football curriculum remains reusable. Current information and examples become increasingly personalized.

---

# 8. COURSE DESIGN SPECIFICATION

Every supported interest must receive an internal Course Design Specification (CDS). A course should not enter production merely because it appears in the taxonomy. Each CDS should intentionally define:

## Identity
- Course ID
- Display name
- Category
- Related courses
- Branches

## Beginner Model
- What does a complete beginner typically know?
- What terminology will initially confuse them?
- What misconceptions are common?
- What concepts unlock the rest of the subject?

## Foundational Knowledge
Depending on the interest: rules, terminology, concepts, strategy, history, culture, equipment, techniques, participants, organizations.

## Enthusiast Model
- What do actual enthusiasts talk about?
- What distinctions matter to them?
- What knowledge signals genuine understanding?
- What beginner statements sound obviously uninformed?
- What controversies or debates commonly occur?

## Interaction Model
- What should the learner EXPERIENCE instead of merely reading?
- Does the course warrant a Unity simulation?
- Would native interactions be more effective?
- Would visual identification help?
- Would decision scenarios help?
- Would sequencing help?
- Would listening exercises help?

## Dynamic Information Requirements
Does the interest benefit from: scores, schedules, standings, statistics, rankings, events, releases, conditions, news, weather, closures, new products, new media.

## Editorial Context
- What commentary helps the learner understand current discussion?
- Which external sources are appropriate?
- What licensing restrictions exist?
- Should Swoon'd summarize, explain or simply link?

## Personalization
Could the course personalize around: team, player, driver, league, series, artist, genre, author, region, equipment, destination, franchise, platform.

## Conversation Model
- What might an enthusiast naturally say?
- What does that statement mean?
- What terminology is implied?
- What could the learner meaningfully ask next?
- How can Swoon'd help without encouraging fake expertise?

## Assessment
- How does Swoon'd determine useful competence?
- What should the learner recognize?
- What should they understand?
- What should they be able to explain?
- What situations should they correctly interpret?

---

# 9. COURSE INFORMATION LAYERS

Swoon'd should provide reusable information capabilities. However, every course selects the appropriate combination.

## 9.1 Evergreen Knowledge
Slow-changing foundational knowledge.

- **American Football:** downs, possession, positions, scoring, formations, routes, defensive coverage, penalties, clock management, special teams.
- **NASCAR:** race structure, stages, flags, drafting, pit strategy, track types, tire management, manufacturers, teams, championship structure.
- **Hiking:** trail difficulty, navigation, trail etiquette, equipment, weather awareness, terrain, plant identification, basic safety, elevation, route planning.

---

# 10. STRUCTURED CURRENT DATA

Certain courses benefit dramatically from real-time or frequently refreshed structured data: scores, schedules, standings, statistics, rankings, rosters, drivers, teams, race results, championship standings, upcoming events.

Sports are obvious candidates. Not every course needs this capability.

Do NOT invent artificial "live data" requirements for subjects where it provides little educational value.

---

# 11. EDITORIAL AND CURRENT CONTEXT

Knowing a score is different from understanding what fans are talking about.

Structured information might tell Swoon'd: `Chiefs 24 / Broncos 17 / FINAL`.

Editorial context might explain why a coaching decision was controversial, why a player is receiving criticism, why an injury matters, why a trade is significant, why fans are discussing a particular strategy.

Therefore structured sports data and editorial/news data should be treated as separate information systems.

Swoon'd should generally NOT become an article-republication service. Where legally permitted, external journalism can be used to identify current topics and provide context. Swoon'd can then explain the development educationally, provide its own contextual explanation, teach relevant terminology, explain why enthusiasts care, and link to the original publisher.

Copyrighted article text should not simply be copied into Swoon'd.

---

# 12. PERSONALIZED CONTEXT

As Swoon'd learns what the other person specifically likes, examples and current information should become increasingly relevant.

Generic American Football course: "What is a quarterback?" Personalized course for an Eagles fan: examples increasingly involve Philadelphia. Current feed may prioritize Eagles games, standings, players, relevant injuries, upcoming games, current Eagles discussion.

The foundational curriculum remains valid while context becomes personal.

---

# 13. CONVERSATION TRAINING

Conversation competence is one of the few learning systems that can apply meaningfully across almost every Swoon'd course.

Sarah says: > "Our secondary is absolutely killing us this year."

Swoon'd might ask: "What is she talking about?" The learner identifies: defensive backs, pass coverage, defensive performance. Swoon'd can explain the statement and potentially demonstrate natural follow-up questions.

The goal is NOT to give users canned lines with which to impersonate experts. The goal is to make the learner genuinely understand enough to participate naturally.

---

# 14. INTERACTIVE LEARNING PHILOSOPHY

Swoon'd should NOT require every course to contain a mini-game. That would create bad games for subjects that do not benefit from simulation.

The requirement should instead be:

> Every course should use the most effective interactive learning mechanism appropriate to that interest.

Some courses may contain sophisticated Unity simulations. Some may contain lightweight native interactions. Some may contain both. Some may require almost no traditional gamification.

---

# 15. UNITY SIMULATIONS

Unity should be used when spatial reasoning, movement, physics, timing or physical interaction materially improves learning.

Potential examples: American Football, NASCAR, Formula 1, IndyCar, MotoGP, Pickleball, Golf, Soccer, Basketball, Baseball, Aviation.

### Example: American Football
Scenario: 3rd & 7. The learner sees the defensive formation. Receivers run routes. Defenders react. The learner chooses a receiver or makes a decision. The simulation executes. The simulation then freezes or replays. Swoon'd explains what coverage was being played, what the defense was attempting, which receiver became open, why the learner's decision worked or failed, and what an enthusiast would recognize in the situation.

The objective is NOT to create Madden. The objective is to let someone EXPERIENCE a football concept.

---

# 16. NASCAR / RACING SIMULATION EXAMPLES

Unity could demonstrate: drafting, racing lines, tire degradation, pit timing, track position, aero effects, fuel strategy, passing opportunities, cautions, stage strategy.

The objective is NOT to create a complete racing simulator. The objective is to make otherwise abstract concepts intuitively understandable.

---

# 17. NATIVE INTERACTIVE EXPERIENCES

Unity should NOT load when a native interaction can teach the concept more effectively.

## Decision Scenarios
Potential courses: hiking, camping, travel, cooking, photography.

Example hiking scenario:
```
Current time: 4:51 PM
Sunset: 6:42 PM
Distance remaining: 4.7 miles
Weather: deteriorating
Elevation gain remaining: 1,200 ft
Choose: A. Continue  B. Take alternate route  C. Turn around
```
The learner makes a decision. Swoon'd explains the considerations. This teaches judgment rather than creating an arbitrary hiking video game.

---

# 18. VISUAL IDENTIFICATION
Potential courses: plants, birds, cars, art, fashion, architecture, instruments, collectibles, photography.
Examples: "Which vehicle is the Porsche 911?" "Which bird is a red-tailed hawk?" "Which tool is used for this pottery technique?"

# 19. SEQUENCING / CONSTRUCTION
Potential courses: pottery, cooking, woodworking, knitting, crafts, brewing.
Example: place the pottery process in order. Or: why did this ceramic piece crack? This may teach considerably more than creating a fake Unity pottery simulator.

# 20. LISTENING / RECOGNITION
Potential courses: music, instruments, music production, genre identification, birding.
Any copyrighted audio must have an appropriate licensing basis.

---

# 21. UNITY'S ROLE IN THE APPLICATION

Unity should NOT be the application framework. The application itself remains native.

```
Swoon'd Native App
│
├── Profiles
├── Courses
├── Lessons
├── Progress
├── Current context
├── Conversation training
├── Native interactions
│
└── Simulation requested
        ↓
      Unity
        ↓
   Simulation runs
        ↓
   Results returned
        ↓
   Native Swoon'd resumes
```

Unity experiences should generally be immersive/full-screen transitions.

---

# 22. NATIVE APPLICATION STACK

**iOS:** Swift, SwiftUI, native networking, native persistence where appropriate, native notifications, Unity host integration.

**Android:** Kotlin, Jetpack Compose, native networking, native persistence where appropriate, native notifications, Unity host integration.

The native application should remain fast and lightweight when Unity is not needed.

---

# 23. SWOON GAME KIT

Astra should NOT build every interactive experience as an unrelated Unity project. A reusable internal simulation framework should be created. Working name: **Swoon Game Kit**.

Potential generic primitives: Lesson, Simulation, Character, Vehicle, Ball, Target, Zone, Path, CameraRig, TouchController, PhysicsObject, DecisionPoint, Hint, Explanation, Objective, Score, Replay, SlowMotion, Highlight.

These should become reliable, tested building blocks.

# 24. SPORT-SPECIFIC UNITY MODULES

- **Football:** Formation, Route, Coverage, Down, Possession, Pass, Tackle, Receiver, Quarterback, Defender.
- **Racing:** Vehicle, Track, RacingLine, Draft, TireState, FuelState, PitStop, Position, Timing.

Future simulations should increasingly become assemblies of proven primitives instead of bespoke applications.

# 25. DATA-DRIVEN SIMULATIONS

Long-term, many simulations should be definable primarily through data.

```
LESSON: Why drafting works
Track: oval_short
Vehicles: 3
Player:
  vehicle: car_01
Objective:
  maintain_draft:
    behind: opponent_01
    distance: 0.8-1.5 car_lengths
    duration: 8 seconds
Demonstrate:
  aerodynamic_drag: visual
Success:
  freeze_simulation
  compare_speed
  explain_drafting
```

This allows AI to create future learning experiences by composing reliable systems rather than rebuilding gameplay from scratch.

# 26. UNITY ART DIRECTION

Swoon'd should NOT pursue AAA photorealism. The visual target: **Polished interactive educational model + approachable mobile arcade aesthetic**, rather than EA Sports / full racing simulator.

Advantages: smaller assets, faster loading, lower memory requirements, easier AI generation, simpler animation, easier procedural geometry, better instructional clarity, lower production cost, stronger visual consistency. Players may be stylized. Vehicles may be stylized. Stadiums may be simplified. Educational information should be visually emphasized over realism.

# 27. ASSET STRATEGY

Not every Unity asset requires Blender. Unity/procedural systems can generate: football fields, courts, tracks, route overlays, zones, yard markings, trail geometry, simple terrain, indicators, materials, educational overlays, simple environmental geometry.

External assets may be appropriate for: character models, detailed vehicles, complex equipment, specialized animations, canonical environment props.

Blender should be an occasional asset-production tool rather than a required step for every simulation.

---

# 28. AI DEVELOPMENT MODEL
Two primary AI development environments have separate responsibilities.

# 29. ASTRA / CHATGPT WORK RESPONSIBILITIES
Astra owns the Unity and simulation environment: Unity project architecture, Swoon Game Kit, Unity C#, simulation systems, physics, procedural scenes, camera systems, input systems, game-state machines, reusable sport modules, asset integration, Unity tests, Play Mode verification, performance optimization, iOS Unity builds, Android Unity builds, native/Unity communication layer.

Astra should strongly favor code-driven Unity development, data-driven scenes, reusable systems, automated testing, programmatic scene construction over excessive manual Unity Editor manipulation. The goal is to make AI development deterministic and repeatable.

# 30. CLAUDE CODE RESPONSIBILITIES
Claude Code owns the native Swoon'd application.

- **iOS:** Swift, SwiftUI, app navigation, profiles, person management, course browsing, curriculum UI, progress UI, native exercises, authentication, networking, notifications, native persistence, Unity host integration.
- **Android:** Kotlin, Jetpack Compose, app navigation, profiles, person management, course browsing, curriculum UI, progress UI, native exercises, authentication, networking, notifications, native persistence, Unity host integration.

Claude should NOT independently recreate simulation logic that belongs inside Unity.

# 31. SHARED ASTRA / CLAUDE CONTRACT

Astra and Claude must NOT independently invent communication structures. A versioned interface must exist between the native application and Unity.

Conceptual launch payload:
```json
{
  "simulationId": "football.coverage.read.v1",
  "courseId": "american-football",
  "lessonId": "coverage-04",
  "difficulty": 2,
  "configuration": {},
  "learnerContext": {}
}
```

Conceptual result:
```json
{
  "simulationId": "football.coverage.read.v1",
  "completed": true,
  "score": 82,
  "outcomes": [],
  "mistakes": [],
  "masterySignals": [],
  "xp": 40
}
```

The actual schema should be formally versioned. Neither Astra nor Claude should unilaterally break this contract.

---

# 32. EXTERNAL DATA ARCHITECTURE

External API providers should NEVER become Swoon'd's internal domain model.

External Provider → Provider Adapter → Swoon'd Normalized Data → Course Interpretation → User Experience

Benefits: providers can be replaced, multiple providers can coexist, outages can be mitigated, courses remain stable, native apps remain provider-agnostic, API licensing changes are less destructive.

# 33. SPORTS DATA STRATEGY
Swoon'd is NOT ESPN. It does not initially require sub-second scoring, betting-grade feeds, ultra-low-latency play-by-play, or broadcast infrastructure. A learner usually needs: recent result, current score, upcoming game, standings, basic player information, basic statistics, current relevant context. Being a few minutes behind during live events is generally acceptable.

# 34. THESPORTSDB
TheSportsDB should be investigated as an inexpensive initial provider for mainstream sports (teams, schedules, scores, standings, basic league info, basic player/team context). The provider should remain behind Swoon'd's adapter layer. If Swoon'd later outgrows it, individual sports can migrate to enterprise providers without changing the product architecture.

# 35. ENTERPRISE SPORTS PROVIDERS
Potential future providers: Sportradar, SportsDataIO. Upgrade paths rather than mandatory MVP dependencies unless required coverage cannot be obtained economically elsewhere.

# 36. MOTORSPORTS DATA
A motorsports-specific provider should be used when it provides better coverage than the general sports provider. Candidate: **Orange Cat Blacktop** (F1, NASCAR, IndyCar, MotoGP, Formula E, WRC, WEC).

IMPORTANT: One motorsports API does NOT imply one motorsports course. Each remains an independent curriculum. The API relationship is infrastructure. The course structure is educational.

# 37. NEWS / EDITORIAL DATA
Structured provider → scores/standings/schedules. News provider(s) → current stories. Swoon'd → educational explanation of why the story matters. Original publisher → full article.

Swoon'd should avoid reproducing copyrighted journalism without appropriate rights. Potential functionality: "Why are NASCAR fans talking about this today?", "Why does this injury matter?", "Why is this trade significant?", "What is controversial about this rule change?" The current event becomes an educational opportunity.

# 38. HIKING / OUTDOORS DATA
Hiking should NOT be artificially modeled like a sport. No scores, standings, seasons, rosters. Useful dynamic information: weather, seasonal conditions, closures, wildfire conditions, snow, park alerts, destination information, featured routes, outdoor editorial content. Sources: public land agencies, national/state park info, mapping data, elevation data, weather services, government alerts, outdoor publications.

# 39. ALLTRAILS
AllTrails should NOT be assumed to provide a general public commercial API. Do NOT build a production dependency around an unofficial or reverse-engineered AllTrails API. Approaches: contact AllTrails re partnership; use legally available public trail/park/map/weather sources; deep-link users to AllTrails when appropriate.

# 40. MEDIA COURSES
Movies, television, music, books, games can teach and recommend titles without Swoon'd becoming the distributor. Swoon'd may discuss titles, genres, creators, history, cultural significance, terminology, franchises, recommendations. Separate rights/licensing analysis is required for poster artwork, cover artwork, clips, trailers, music recordings, lyrics, publisher descriptions, review text. Distinguish **talking about a work** from **redistributing copyrighted material from the work**.

# 41. COURSE DATA MANIFEST
Each production course should have a machine-readable manifest. Potential fields: course ID, display name, category, branches, curriculum version, foundational modules, interaction types, Unity simulations, native exercises, dynamic data requirements, data providers, editorial requirements, refresh frequency, personalization dimensions, conversation scenarios, mastery model, licensing constraints, safety constraints. This manifest is a coordination object between curriculum, backend, Astra and Claude Code.

# 42. INITIAL COURSE FAMILIES
Sports, Motorsports, Outdoors & Adventure, Gaming, Music, Film & Television, Books & Literature, Food & Cooking, Cars & Automotive, Aviation, Technology, Arts, Crafts, Fitness, Animals & Nature, Travel, History & Culture, Fashion & Beauty, Collecting. These are organizational families, NOT quotas.

# 43. COURSE CATALOG DEVELOPMENT
Create an initial candidate pool of ~250-300 interests. Evaluate each for popularity, social relevance, curriculum depth, distinctiveness, authoritative info availability, interactive learning opportunities, personalization opportunities, dynamic content, licensing complexity, conversation value. Select ~150-200.

# 44. UNSUPPORTED INTERESTS
Include **Other / Request an Interest**. Requests become quantitative roadmap data. Do NOT automatically generate a low-quality course because someone types an unsupported interest.

# 45. REFERENCE COURSE STRATEGY
Do NOT build 200 courses simultaneously. First create ~10-20 deliberately different reference courses: American Football, Basketball, NASCAR, Formula 1, Pickleball, Hiking, Camping, Cooking, Movies, Music, Gaming, Cars, Books, Fashion, Pottery, Photography.

- American Football → live data + simulation + terminology + conversation
- NASCAR → live data + racing simulation + strategy + drivers
- Hiking → environmental information + judgment scenarios + navigation
- Movies → media metadata + cultural context + recommendations
- Music → listening/genre concepts + artists + current releases
- Pottery → process + visual recognition + sequencing

# 46. SCALING STRATEGY
Reference courses → 10-20 excellent courses → ~50 → ~100 → 150-200 curated. Quality over count.

# 47. COURSE QUALITY STANDARD
Before release a course must answer: (1) What does a beginner need to understand? (2) What do enthusiasts care about? (3) What current information matters? (4) What should be interactive? (5) What should NOT be gamified? (6) How should it personalize? (7) What does conversational competence look like? (8) What data providers? (9) What licensing constraints? (10) How will Swoon'd measure useful understanding?

# 48. PRODUCT SUCCESS CRITERION
Not "did the user finish?" nor "how much XP?" but:

> Did Swoon'd make this person more capable of genuinely engaging with someone they care about?

A successful user can recognize terminology, understand conversations, ask meaningful questions, follow current events, appreciate strategy or technique, understand why the enthusiast cares, and participate without pretending to be an expert.

# 49. HIGH-LEVEL SYSTEM OWNERSHIP

```
                        SWOON'D
                           │
            ┌──────────────┴──────────────┐
      Native Application           Simulation Platform
       CLAUDE CODE                       ASTRA
   SwiftUI     Compose               Unity    Game Kit
            └──────── Shared Contract ────┘
                     Swoon'd Backend
          Curriculum     Live Data     Editorial
                     Person Profile
                    Learning Journey
```

# 50. IMPLEMENTATION RULES
1. Astra owns Unity and simulation behavior.
2. Claude Code owns native SwiftUI and Compose product behavior.
3. Neither agent may independently redefine the shared Unity/native interface.
4. Courses are intentionally designed. Do not force courses into generic templates.
5. Unity only when Unity materially improves the learning experience.
6. Native interactions remain native whenever a game engine provides no meaningful advantage.
7. External APIs must sit behind Swoon'd-owned adapters.
8. No external provider's schema becomes Swoon'd's core data model.
9. Avoid unofficial/reverse-engineered production APIs when the service does not authorize that use.
10. Do not assume publicly accessible media is legally redistributable.
11. Do not optimize Swoon'd around becoming an encyclopedia. Optimize it around helping one human understand another human's interests.

# 51. PRODUCT NORTH STAR
Swoon'd exists because people often care about someone before they care about the things that person cares about. The product helps bridge that gap.

Swoon'd should turn:
> "I have absolutely no idea what she's talking about."

into:
> "Okay. Now I understand why she loves this."

That principle should guide curriculum design, engineering, game design, personalization, content acquisition and every major product decision.
