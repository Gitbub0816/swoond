# Course Design Specification: K-pop (`k-pop`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 3 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity sims, see section 12) |

Time-sensitive facts (music-show scoring, comeback and tour announcements, contract rules, court and dispute status, record totals) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Lesson copy never hard-codes them; the live layer (`live-data.md`) and dated data tokens carry them. A **cultural review by Korean and Korean-diaspora fans and a Korean-language reviewer is required before release** (see section 16 and NOTES).

**Rights rule for this whole course (spec sections 20 and 40).** Swoon'd *talks about* K-pop; it does not distribute it. No recordings, music videos, lyrics, album art, logos or member photos are used. Every sound the learner hears is original (`original-swoond`), every picture is an original illustration (generic lightsticks, photocards, banners; no real designs or likenesses), and real songs are reached only through the official platforms via link-out. Members are named only as facts in dated data, never quoted or imitated.

**Independent of `music`.** This course is a sibling of `music` (boundary test in section 1). It cross-links but never re-teaches general music theory: where beats, hooks, builds, charts or concert flow appear, the lesson links to the matching `music` concept (`hook`, `build-and-release`, `arrangement`, `charts`, `concert-flow`, `presale-verified-fan`) and stays on what is specific to K-pop.

---

## 1. Identity

- **Course ID:** `k-pop` (immutable)
- **Display name:** K-pop
- **Category / family:** Music > K-pop (family `Music`)
- **Simulation prefix:** `kpop` (reserved; **no simulations are planned**, see section 12)
- **What this course is.** K-pop is less a genre than a *world*: an industry that trains and debuts groups, a release rhythm (comebacks) that runs on teasers and weekly shows, and a fandom culture with names, lightsticks, chants, streaming parties, photocards and its own Korean-derived vocabulary. The person you care about is probably not just "listening to songs"; she is following *people and projects over time*. So the course teaches three things at once: **how the system works** (agencies, trainees, debut, generations), **how the year runs** (comebacks, music shows, tours, awards) and **how fans talk** (roles, words, rituals, etiquette), with careful, honest treatment of the hard parts (contracts, wellbeing, privacy, parasocial closeness).
- **Two lenses, one course.** People enter K-pop as *listeners* (songs and playlists), as *followers* (members, content, variety) and as *collectors or event-goers* (albums, photocards, concerts). Foundation units serve all three; branch units tilt toward what she actually cares about.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Music (`music`) | Someone fluent in general music literacy (beats, hooks, charts, concerts) can talk about a song, but not about trainee systems, comebacks, music-show wins, fan chants, photocards, Korean fan words or fandom etiquette. The reverse is also true: a K-pop fan can be lost on a jazz club or a country story song. | Sibling, independent | No shared units. `k-pop` links to `music` concepts (`hook`, `build-and-release`, `charts`, `concert-flow`, `presale-verified-fan`) and never re-teaches them. |
| Anime / Japanese pop culture (Wave 3 `anime`) | Fan-culture overlaps (conventions, merch, ships) but the industries, languages and etiquette differ. | Adjacent, independent | Possible cross-link on collecting etiquette later. |
| Korean dramas and films (candidate) | Hallyu includes dramas; someone who knows K-pop is not conversationally competent about drama plots or actors. | Adjacent, independent (candidate future courses) | Hallyu is one lesson only (`ind-06`). |
| Learning Korean | A different goal: language skill. | Out of scope | Fan words are taught for *understanding*, with accurate romanization; Swoon'd says "if you want to learn Korean, a real course beats an app lesson". |
| Dance | Choreography appreciation is covered in `concept-and-craft` and the `branch-performance` unit; dancing itself is a skill, not a course goal. | Shares foundation (this course) | No separate dance course. |
| Concerts as a course | Live shows are a unit (`live-tours`), not a course. | Shares foundation | One course; the live layer is a unit. |

- **Branches (what she is most into).** A branch tilts examples, terms, live cards and branch-only lessons; the foundation is shared. Personalization of a specific group is the `artist` dimension, not a branch.

| id | Name | What changes |
|---|---|---|
| `fandom-core` | Fan world (default) | Fandom culture, comebacks, variety, member talk. Default when nothing is set. |
| `performance` | Dance and live performance | Sync, formations, stage tech, live vocals. |
| `charts-data` | Charts and data | Streams vs sales, global charts, records and how to read a headline. |
| `collector` | Collecting and merch | Albums, photocards, limited runs, gifting. |
| `legacy` | Legacy and nostalgia | Earlier generations, reunions, sunbae groups, retro concepts. |

---

## 2. Beginner model

**What a complete beginner knows.** She has heard "K-pop" mentioned, may have heard a big hit, recognises that groups are large and that the choreography is sharp, and knows that "fans are very into it". What is missing is the *structure*: no sense that groups are planned by companies, no idea what a comeback is, why weekly TV shows matter, what a lightstick does, or why fans say "my bias wrecked me".

**Terminology that confuses:** idol, agency, trainee, debut, comeback, title track, B-side, era, concept, teaser, bias, bias wrecker, ult, maknae, leader, center, visual, main vocal, rap line, unit, oppa, noona, hyung, eonni, sunbae, hoobae, ment, lightstick, fan chant, slogan, fandom name, streaming party, photocard, lucky draw, pre-order benefit, fansign, fan meeting, triple crown, all-kill, daesang, bonsang, Hanteo, Circle Chart, stan, ipdeok, taldeok, sasaeng.

**Common misconceptions (each is a lesson beat):**
1. "K-pop is one sound." (It is a system; the sound spans every genre.)
2. "Everyone in a group is just a dancer or a face." (Roles are jobs; many members write, produce, choreograph and run their own channels.)
3. "A comeback means the group was gone." (It is a release era.)
4. "A weekly show win means the group is objectively bigger." (A win is a formula with several measures; formulas differ by show.)
5. "Fans are all the same." (Fandoms differ; most fans are gentle and organised. A loud minority is not the whole.)
6. "Fans who buy many albums are foolish." (People have different reasons; there are fair criticisms too. Do not judge.)
7. "An idol's life is glamorous and easy." (Training and schedules are demanding; the course is honest about wellbeing.)
8. "Using oppa/noona/hyung is a cute shortcut." (Address terms carry relationships; use them only when they fit.)
9. "Fans know the members personally." (Closeness is one-way; healthy fandom respects that.)
10. "Generations are official." (They are fan shorthand, and the boundaries are disputed.)

**Concepts that unlock the rest (become foundation units):** the agency system and what "idol" means; trainee to debut; group roles and lines; the comeback cycle; Korean fan words said right.

---

## 3. Foundational knowledge

Modules (become `foundationalModules[]` and foundation units):

1. **`industry-map`** — agencies, the Big Four as shorthand (HYBE, SM, JYP, YG; real companies, named as facts only), sub-labels and independents, songwriting camps, Hallyu.
2. **`trainee-to-debut`** — audition types (open, casting, global), trainee life, survival shows (with the honest note that a past vote-manipulation scandal led to convictions **[verify at release]**), teaser sequence, debut and showcase, rookie window.
3. **`group-anatomy`** — leader, main/lead vocal, rapper lines, dancers, center, visual, maknae, age "lines", subunits, solo debuts; positions as shorthand, not personality.
4. **`comeback-cycle`** — comeback schedule, tracklist reveal, title track vs B-sides, release time (Korea is UTC+9), promotion weeks, era and concept.
5. **`korean-fan-words`** — romanization (Revised Romanization and common fan spellings), address terms, sunbae/hoobae, choeae/deokhu/ipdeok/taldeok, greetings, name order.

Facts verified 2026-09-30: music-show scoring formulas exist for each show and change (M Countdown, Show Champion, Inkigayo publish weighting between digital, physical, video, broadcast and voting) **[verify at release]**; a Seoul court ruled on 2025-10-30 in favour of ADOR in a dispute with NewJeans, with appeal expected **[verify at release]**; a Korean FTC standard contract caps exclusive contracts at seven years **[verify at release]**; BTS announced a 2026 return with a world tour **[verify at release]**.

---

## 4. Enthusiast model

- **What enthusiasts talk about:** the new comeback (concept, title track, choreography, MV story), who is in the center, member moments from variety or a live, the next music-show week, stream goals, album versions and photocards, concert plans and ticket stress, awards season and who is rookie of the year, and the quiet everyday joy of following people over time.
- **Distinctions that matter:** main vs lead vocal, unit vs solo, title track vs B-side, win vs chart, official vs fan-made, bias vs bias wrecker vs ult, album vs digital, fan club presale vs general sale.
- **Signals of genuine understanding:** asking "which era?" before a question; knowing that a comeback is not a return; using bias and wrecker correctly; knowing that formulas differ by show; admitting "I only know the title track".
- **Sounds obviously uninformed:** "K-pop all sounds the same", "they're just manufactured", "is that one the leader because she's best?", "a win means they're bigger", "why do they buy 30 copies?", calling members by the wrong honorific, mispronouncing the group name as a joke.
- **Controversies and debates (handled with care):** multi-version albums and sustainability; vote-manipulation and mass voting; live vs MR; contract length and label disputes; workload and wellbeing; privacy and sasaeng behaviour; parasocial closeness and paid-message services; fandom wars and gatekeeping; cultural respect vs costume-like treatment; whether generation labels mean anything.

---

## 5. Interaction model

- **What she should experience:** decoding real fan lines; ordering a comeback week; hearing a chant gap, a genre switch and a Korean greeting; tapping an arena plan; judging a crowded floor or a risky photocard trade; practising talk tracks where curiosity beats bluffing.
- **Does the course warrant Unity?** No. Every idea that looked spatial reduces to a static diagram (formations, arena plans) or a 1D timing bar (chant clap). See section 12 for the five rejected sim ideas.
- **What should NOT be gamified:** wellbeing and controversy topics; members as a ranking; fandom identity (no "fandom rank" leaderboards); stream goals (no pressure mechanics); spending on albums or merch; anything that encourages tracking an idol.
- **Chosen mix:** native multiple-choice, binary-call, term-match, sequence-order, say-this, decision-scenario, talk-track, fill-the-gap, plus visual-id, hotspot-tap, timing-tap and listening-id on original assets. Details in section 12.

---

## 6. Dynamic information requirements

K-pop has no league table, but it has a **weekly rhythm** that genuinely changes: comeback calendar, music-show weeks and winners, chart movement, tour and on-sale announcements, awards seasons and industry stories. See `live-data.md` for providers, normalized entities, licensing and fallbacks.

| Need | Needed? | Why | Providers (candidates) | Refresh | Fallback |
|---|---|---|---|---|---|
| Comeback and release calendar | Yes | The main conversation starter each week | MusicBrainz, Apple Music API, Spotify Web API (terms apply), curated editorial | weekly, daily around releases | Evergreen "how to read a comeback week" card |
| Music-show weeks and winners | Yes, light | "Did they win?" is a common question | Curated dated entries (Wikipedia/Wikidata facts, official show sites as link-out) | weekly | Evergreen "how a win works" card |
| Charts (Korean and global) | Yes, light | Context for records and headlines | Circle Chart, Hanteo, Melon, Billboard (link-out and curated summaries) | weekly | Static "how charts count" card |
| Tour and on-sale announcements | Yes | Ticket stress and plans | Ticketmaster Discovery, Interpark, Yes24, artist and agency sites (link-out), curated | weekly | Evergreen on-sale explainer |
| Awards and year-end shows | Seasonal | Nominations, categories, voting rules | Organisers' official sites (curated dates) | seasonal, weekly in season | Evergreen awards explainer |
| News and industry stories | Yes | "Why are fans talking about this?" | Headlines (link-only), agency and artist announcements | daily | Evergreen explainers |
| Scores, standings, injuries, rosters | No | Not a competition; invented leaderboards are off limits (spec section 10) | none | none | none |
| Lyrics, cover art, photos, MV embeds | **Never** | Rights (spec section 40) | none | none | none |

Structured data (dates, titles, credits) and editorial (Swoon'd-written explainers) are separate systems.

---

## 7. Editorial context

- **Commentary that helps:** why a comeback is being discussed; what a win or a chart move actually measures; why a ticket sale or fan-club presale is stressful; what a nomination list implies; a neutral explainer of a dispute (what is settled, what is alleged); why a variety clip became a meme.
- **Sources:** official agency and artist announcements, awards organisers and show sites, established music press (headlines and links only), public-interest reporting for legal and industry stories.
- **Summarise, explain or link?** Explain in our own words and link; never copy publisher text, lyrics or translations. Disputes are written as "here is what is on the record, here is what is alleged, here is what to ask her".
- **Example prompts:** "Why are fans talking about this today?", "What does 'triple crown' mean for this week?", "What should I say about the ticket news?", "Why is everyone stressed about the presale?"
- **Care rule:** wellbeing and controversy stories are explained without speculation, methods or rumours, follow safe-messaging guidance, and always offer "what to say and what not to say".

---

## 8. Personalization

| Dimension | How it changes examples and live context | Default when unset | Tokens (units) |
|---|---|---|---|
| `artist` (group, and optionally a member as her bias) | Live cards and talk-track intros use her group; era, comeback, tour and fan-club items reference `{artist}`; `{bias}` appears only in say-this follow-ups, never as a test of her taste | Fictional demo group in evergreen copy (never a real group's invented quotes) | `{artist}`, `{bias}` in `kpop-now`, `fandom-culture`, `conversation-lab`, `live-tours` |
| `region` | Local venues, time zones, on-sale times, local fan-club rules, local crisis resources in wellbeing items | Region-neutral examples | `{region}` in `live-tours`, `kpop-now`, `debates-with-care` |
| `platform` | Wording for where she listens (Melon, Spotify, Apple Music, YouTube Music, Weverse-style fan platforms) | "your streaming app" | `{platform}` in `comeback-cycle`, `fandom-culture`, `content-variety` |

The app never quizzes her taste or ranks members. A bias is optional and used only for warmer follow-ups. Branches (performance, charts-data, collector, legacy) tilt examples; choosing one sets nothing else.

---

## 9. Conversation model

Enthusiast lines (invented, paraphrase-style; no lyrics) with meaning and a good next question.

| # | She says | Meaning | Concepts | A good follow-up |
|---|---|---|---|---|
| 1 | "It's comeback day and I've been up since five." | A new release dropped; she is excited. | `comeback` | "What's your first impression?" |
| 2 | "The title track is fine but the B-sides are the album." | She prefers the non-focus songs. | `title-track`, `b-side` | "Which B-side first?" |
| 3 | "My bias wrecker is on again." | A member who keeps pulling her attention from her favourite. | `choeae-bias` | "Who's your actual bias?" |
| 4 | "I officially ipdeok'd last night." | She became a fan of something new. | `ipdeok-taldeok` | "What pulled you in?" |
| 5 | "It's the last week of promotions." | The release window is ending; the show weeks are almost over. | `promotion-window` | "Will there be an encore stage?" |
| 6 | "That's a triple crown." | A three-win milestone on the shows. | `triple-crown` | "How long did the goal take?" |
| 7 | "We need forty thousand more streams." | A stream goal is running; she feels pressure. | `streaming-party` | "Want a break? I can keep it playing." |
| 8 | "Fan club presale is tonight; I might not get in." | Access is tiered; she is anxious. | `fan-club-presale` | "Want to plan backups?" |
| 9 | "The maknae line carried that episode." | The youngest members were the funniest. | `maknae`, `variety-show` | "Which moment made you laugh?" |
| 10 | "I'm saving up for the lightstick." | She wants the official light for shows. | `lightstick` | "Do you know the fan chants?" |
| 11 | "They announced a unit." | A smaller group from within the group is coming. | `subunit` | "Who's in it?" |
| 12 | "The photocard I wanted was in the third album." | Collecting and luck. | `photocard`, `preorder-benefit` | "Want to trade?" |
| 13 | "This era's concept is so good." | The look and story of the release. | `era`, `concept` | "What's the story?" |
| 14 | "Wait, is that a fancam?" | A video following one member. | `fancam` | "Who's in it?" |
| 15 | "I could not sleep after the news." | An industry story upset her. | `sensitive-topic-response` | "Do you want to talk or take a break?" |
| 16 | "It's my two-year ipdeok-iversary." | She marks the time since becoming a fan. | `ipdeok-taldeok` | "What was the first song?" |
| 17 | "It was a fourth-gen thing." | She places a group by era shorthand. | `fourth-gen` | "What does that era sound like?" |
| 18 | "Sunbae-nim came to support the rookie." | An older artist visited a newer act. | `sunbae-hoobae` | "That's sweet. Who?" |

**How Swoon'd helps without encouraging fake expertise:** every talk track and say-this has a `noFakeExpertNote` and follow-ups that are honest curiosity ("what do you love about it?"), never pretend analysis. Cringe replies fake authority, rank members, dismiss the fandom or repeat rumours. Swoon'd never scripts an opinion about her favourite group.

**Targets:** 20 talk tracks at launch (roster in `exercises.md`), 140+ say-this items, 60+ fill-the-gap items.

---

## 10. Assessment

- **Useful competence** = she can (1) decode what her person says about a comeback, a show week or a fan ritual, (2) use the right role and fan words kindly, (3) understand how a win, a chart and a presale work at a high level, (4) ask two honest, informed follow-ups, and (5) handle a hard topic (a sad story, a dispute, a fandom fight) without speculating.
- **Recognise:** roles and lines, comeback stages, music shows, chart names, fandom objects, address terms, event types.
- **Understand:** why comebacks are planned, why formulas change the meaning of a win, why fans buy multiple versions, why privacy matters.
- **Explain:** "what a comeback is", "what a title track is", "why sasaeng behaviour is harmful", "why generation labels are shorthand".
- **Correctly interpret:** a comeback schedule poster, a music-show result, a tour poster, a presale announcement, an album version listing.
- **Mastery model:** `concept-mastery-v1`, pass threshold **0.8**. Review ladder 1d, 3d, 7d, 14d, 30d, 60d, max 12 items per daily session; below 0.6 re-enters at 1d. Ear check (`rev-03`): five synthesised clips; pass at 4 of 5; never used to rate taste.
- **Useful competence statement:** "She can follow a conversation about a comeback, a show week or a concert plan, use the roles and fan words kindly, understand what a win or a chart does and does not say, ask a couple of genuinely curious questions about her favourite group, and handle a hard story with care, without faking any of it."

---

## 11. Curriculum map (ongoing course)

Designed as an ongoing course: foundations, intermediate, enthusiast depth, branches, a perpetual live layer, continuous conversation practice and spaced review. Totals: **20 units, 110 lessons, 221 concepts**. Activity codes: MC multiple-choice, BC binary-call, TM term-match, SO sequence-order, VI visual-id, DS decision-scenario, TT talk-track, TP timing-tap, ST say-this, FG fill-the-gap, LI listening-id, ES estimate-slider, HT hotspot-tap. No Unity activities.


### Layer 1: Foundations

**Unit `industry-map`: How the Idol System Works** (layer `foundations`; prerequisites: none; 6 lessons). The business shape behind the music: agencies, the Big Four as shorthand, what 'idol' means, how a group is planned like a long-running product.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `ind-01` | What 'idol' and 'K-pop' actually mean | Explain that K-pop is an industry-made system of trained, multi-skilled performers, not one sound or genre | `idol-definition`, `kpop-not-a-genre` | MC, BC, FG |
| `ind-02` | The agency is the center of gravity | Describe what an entertainment agency does: scout, train, plan, produce, manage | `agency-role`, `full-service-model` | MC, SO, TM |
| `ind-03` | The Big Four, and why the label is shorthand | Name HYBE, SM, JYP, YG as shorthand for big agencies and know the 'Big Four' is a fan/press phrase, not an official tier | `big-four-shorthand`, `agency-house-style` | TM, MC, HT |
| `ind-04` | Sub-labels and independent agencies | Understand that one company can contain several labels and that many beloved groups sit outside the big names | `sub-label`, `independent-agency` | MC, BC, DS |
| `ind-05` | Producers, songwriters and the camp system | Explain that songs are often built in songwriting camps by teams, and how that differs from singer-songwriter culture (link: music) | `songwriting-camp`, `producer-credit` | MC, FG, ST |
| `ind-06` | Why Korea built this, and Hallyu in one page | Say in plain words what Hallyu (the Korean Wave) is and why the model exported well | `hallyu`, `export-model` | MC, SO, ST |

**Unit `trainee-to-debut`: Trainee to Debut** (layer `foundations`; prerequisites: `industry-map`; 6 lessons). The pipeline from audition to first release, and why debut is a beginning.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `trn-01` | Auditions: open, casting and global | Tell the three common entry doors apart | `audition-types`, `casting` | TM, MC, BC |
| `trn-02` | Life as a trainee | Describe training: vocal, dance, language, media and monthly evaluations, without romanticising it | `trainee-life`, `monthly-evaluation` | MC, DS, SO |
| `trn-03` | Survival shows, explained | Explain how a survival show forms a group and why fans vote, including the honest note about past vote-rigging scandals | `survival-show`, `audience-vote` | MC, ST, BC |
| `trn-04` | Pre-debut reveals and teasers | Recognise the usual teaser sequence: concept film, member posters, schedule, highlight medley | `teaser-sequence`, `pre-debut-content` | SO, FG, HT |
| `trn-05` | Debut, showcase and debut date | Explain what a debut is, what a showcase is, and why fans celebrate debut anniversaries | `debut`, `showcase`, `debut-anniversary` | MC, FG, ST |
| `trn-06` | Rookies and 'rookie awards' | Understand the rookie window and why rookie awards are a one-time shot | `rookie-window`, `rookie-award` | MC, BC, ST |

**Unit `group-anatomy`: Inside a Group: Roles and Units** (layer `foundations`; prerequisites: `industry-map`; 6 lessons). Who does what in a group, what 'line' means, and how to use position words without turning people into slots.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `grp-01` | Leader: the job, not the crown | Describe a leader as the group's spokesperson and organiser, not necessarily the best singer | `leader-role` | MC, TM, ST |
| `grp-02` | Vocal and rap lines | Tell main, lead and sub vocal and rapper roles apart | `main-vocal`, `lead-vocal`, `rap-line` | TM, MC, FG |
| `grp-03` | Dancers, center and visual | Explain main/lead dancer, center and 'visual' as stage and marketing roles | `main-dancer`, `center`, `visual-role` | TM, MC, BC |
| `grp-04` | Maknae, hyung line and age words | Explain maknae and the age-ordered 'lines' and why age matters in Korean group life | `maknae`, `age-line`, `honorifics-basics` | MC, FG, ST |
| `grp-05` | Subunits, solo debuts and unit projects | Distinguish a subunit, a solo debut and a one-off collaboration | `subunit`, `solo-debut`, `unit-project` | TM, DS, MC |
| `grp-06` | Positions are shorthand, not personality | Use roles as conversation starters and avoid boxing people in | `position-as-shorthand`, `member-individuality` | BC, ST, MC |

**Unit `comeback-cycle`: The Comeback Cycle** (layer `foundations`; prerequisites: `trainee-to-debut`; 6 lessons). The release rhythm: teasers, release day, promotion weeks, and why 'comeback' does not mean return.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `cbk-01` | What 'comeback' means | Explain that a comeback is a new release era, even for groups that never left | `comeback`, `promotion-cycle` | MC, BC, FG |
| `cbk-02` | Teasers, tracklist and the countdown | Read a comeback schedule: date announcement, teasers, tracklist, track preview, MV teaser | `comeback-schedule`, `tracklist-reveal` | SO, HT, MC |
| `cbk-03` | Title track, B-sides and the focus track | Understand title track (taiteulgok), subtitle songs, and why fans debate which song should be the title | `title-track`, `b-side`, `focus-track` | TM, MC, ST |
| `cbk-04` | Release day, six p.m. and the first hours | Explain why Korean release times and first-day streaming matter and how time zones change the experience | `release-time`, `first-day-performance` | ES, MC, DS |
| `cbk-05` | Promotion weeks: music shows, content, variety | Walk the standard two-to-four-week promotion window | `promotion-window`, `promotion-activities` | SO, MC, ST |
| `cbk-06` | Era, concept and the end of a cycle | Use 'era' and 'concept' and understand the pause after promotion ends | `era`, `concept`, `hiatus-cycle` | FG, MC, ST |

**Unit `korean-fan-words`: Korean Fan Words, Said Right** (layer `foundations`; prerequisites: none; 6 lessons). The words fans use daily, in accurate Revised Romanization and common fan spellings, with how to say them kindly and correctly.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `kor-01` | Reading romanization without fear | Understand that fans use Revised Romanization and variant spellings; learn the vowels that trip people up | `romanization-basics`, `hangul-awareness` | MC, FG, LI |
| `kor-02` | Family and age words: oppa, noona, hyung, eonni | Know who says which and why the learner should not use them casually | `oppa-noona-hyung-eonni`, `address-terms` | TM, DS, MC |
| `kor-03` | Sunbae, hoobae and 'nim' | Explain seniority words and why fans say sunbae-nim for older artists | `sunbae-hoobae`, `nim-suffix` | TM, MC, ST |
| `kor-04` | Fan words: choeae, deokhu, ipdeok, taldeok | Decode deokhu, deokjil, ipdeok, taldeok and choeae (bias) | `choeae-bias`, `ipdeok-taldeok`, `deokhu` | TM, FG, ST |
| `kor-05` | Greetings, thanks and cheers worth knowing | Say annyeonghaseyo, gamsahamnida, hwaiting and saranghae appropriately | `basic-greetings`, `hwaiting` | LI, FG, ST |
| `kor-06` | Names, order and respect | Put the family name first, pair names with the right honorific, and avoid nickname overreach | `korean-name-order`, `stage-name-vs-name` | MC, BC, DS |


### Layer 2: Intermediate

**Unit `music-shows-charts`: Music Shows, Wins and Charts** (layer `intermediate`; prerequisites: `comeback-cycle`; 7 lessons). How weekly music shows and Korean charts work, what a win means, and why the formula changes the conversation.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `shw-01` | The weekly music shows | Name the main weekly shows and what they are for | `music-show`, `weekly-show-calendar` | TM, MC, HT |
| `shw-02` | What a win is: the point system | Explain at a high level that digital, physical, broadcast, video and voting points combine, and formulas differ by show | `show-win-formula`, `point-system` | MC, ES, DS |
| `shw-03` | Triple crown, all-kill and records | Decode 'triple crown', 'perfect all-kill' and why records are defined by the chart | `triple-crown`, `all-kill` | TM, MC, FG |
| `shw-04` | Encore stage, pre-recorded and live | Understand encore stages and 'live' versus 'lip-sync' debates in context | `encore-stage`, `live-vs-pre-recorded` | BC, MC, ST |
| `shw-05` | Circle Chart, Hanteo, Melon and Billboard | Tell Korean album and digital charts apart and know which measures what | `circle-chart`, `hanteo`, `melon-chart`, `billboard-global` | TM, MC, HT |
| `shw-06` | Year-end shows and awards | Map the year-end awards: gayo daejeon, daesang, bonsang and rookie awards | `year-end-awards`, `daesang-bonsang` | TM, MC, SO |
| `shw-07` | What a win does and does not mean | Stay kind: a win is one measurement; avoid 'their music is objectively bigger' talk | `win-context`, `metric-humility` | BC, ST, DS |

**Unit `fandom-culture`: Fandom Culture** (layer `intermediate`; prerequisites: `korean-fan-words`; 7 lessons). Fandom names, lightsticks, chants and the shared rituals that make fans feel like a team.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `fan-01` | Fandom names and what they signal | Know that every group has a named fandom and why the name matters to the people in it | `fandom-name`, `fandom-identity` | TM, MC, FG |
| `fan-02` | The lightstick | Explain what a lightstick is, why it is carried and how it syncs at some concerts | `lightstick`, `lightstick-sync` | VI, MC, ST |
| `fan-03` | Fan chants and slogans | Understand fan chants (eungwon-beop) and slogans as a shared call and response | `fan-chant`, `fan-slogan` | TP, MC, FG |
| `fan-04` | Streaming goals and mass voting | Explain streaming parties, goals and why they feel urgent and what healthy participation looks like | `streaming-party`, `voting-culture` | MC, DS, ST |
| `fan-05` | Fan projects: ads, birthday cafes and support | Understand fan-funded projects such as subway ads and birthday cafes | `fan-project`, `birthday-cafe` | MC, BC, ST |
| `fan-06` | Fan accounts, fancams and translation | Know the roles of translators, fancam creators and fan accounts; credit and permissions | `fancam`, `fan-translation`, `credit-etiquette` | MC, DS, ST |
| `fan-07` | Stan culture without the drama | Distinguish healthy stanning from gatekeeping and fandom wars | `stan-culture`, `fandom-conflict` | DS, TT, MC |

**Unit `content-variety`: Content, Variety and Platforms** (layer `intermediate`; prerequisites: `comeback-cycle`; 6 lessons). The endless non-music output: variety shows, vlogs, dance practices, live streams and fan platforms.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `cnt-01` | Dance practice and performance videos | Tell a dance practice from a performance video and a fancam | `dance-practice`, `performance-video` | TM, MC, VI |
| `cnt-02` | Variety shows and idol personalities | Explain why idols appear on variety shows and what fans are watching for | `variety-show`, `idol-persona` | MC, BC, ST |
| `cnt-03` | Self-made content: vlogs, lives and 'bangsong' | Recognise group-run content channels and live streams | `self-produced-content`, `live-stream` | MC, FG, ST |
| `cnt-04` | Fan platforms and private messages | Describe fan platforms and paid message services and why they make fans feel close | `fan-platform`, `message-subscription` | MC, BC, DS |
| `cnt-05` | Memes, clips and inside jokes | Understand how a clip becomes an inside joke and how to ask about one | `meme-culture`, `inside-joke` | ST, MC, TT |
| `cnt-06` | Fan events: fansigns, fan meetings, video calls | Explain fansign, fan meeting and video-call events and how fans enter them | `fansign`, `fan-meeting`, `video-call-event` | TM, MC, DS |

**Unit `live-tours`: Concerts, Tours and Global Stages** (layer `intermediate`; prerequisites: `fandom-culture`; 6 lessons). How K-pop concerts run, how tours reach the world, and ticket realities (link: music).

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `liv-01` | A K-pop concert night | Sequence a typical show: opening, stages, ments, encore; link to music concert-flow | `concert-flow-kpop`, `ment-talk` | SO, MC, HT |
| `liv-02` | Fan clubs, presales and ticket stress | Understand fan-club presales and why access differs by country | `fan-club-presale`, `presale-verified-fan` | MC, DS, ST |
| `liv-03` | Tour logistics: legs, cities, stadiums | Read a world-tour poster and decode leg, date, and venue size | `tour-leg`, `venue-size` | HT, ES, MC |
| `liv-04` | Fanmade banners, slogans and lightstick rules | Explain what is usually allowed or banned at venues and why | `venue-rules`, `banner-etiquette` | DS, BC, MC |
| `liv-05` | Festivals, awards and world-stage appearances | Understand K-pop at festivals and global award shows | `festival-set`, `global-stage` | MC, TM, ST |
| `liv-06` | Staying safe and kind in a crowd | Plan a hearing-safe, crowd-safe show day | `crowd-safety`, `hearing-care` | DS, MC, BC |


### Layer 3: Enthusiast depth

**Unit `generations-history`: Generations and History** (layer `enthusiast-depth`; prerequisites: `industry-map`, `group-anatomy`; 7 lessons). The story of K-pop in eras, told as shorthand with caveats.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `gen-01` | Generations as shorthand, not law | Explain why generation labels are fan shorthand and boundaries are disputed | `generation-shorthand`, `generation-debate` | MC, BC, FG |
| `gen-02` | First generation: the 1990s template | Describe how the 1990s groups built the idol blueprint | `first-gen`, `idol-blueprint` | SO, MC, ST |
| `gen-03` | Second generation: the Korean Wave expands | Explain the 2000s push into Japan and Asia and the rise of large fandom infrastructure | `second-gen`, `asian-expansion` | MC, SO, TM |
| `gen-04` | Third generation: global social media | Explain why social platforms changed fan reach in the 2010s | `third-gen`, `social-media-reach` | MC, BC, ST |
| `gen-05` | Fourth and newer generations | Describe worldviews, self-produced content and global trainee pools, with caveats about the label | `fourth-gen`, `newer-gen`, `global-members` | TM, MC, ST |
| `gen-06` | Boy groups, girl groups and how fans talk about both | Understand style traditions without stereotyping | `boy-group-tradition`, `girl-group-tradition` | MC, BC, DS |
| `gen-07` | Solo artists, bands and trot | Know that K-pop sits beside solo, band and trot scenes and does not erase them | `solo-scene`, `band-scene`, `trot-awareness` | MC, TM, ST |

**Unit `concept-and-craft`: Concept, Choreography and Craft** (layer `enthusiast-depth`; prerequisites: `comeback-cycle`, `group-anatomy`; 6 lessons). What fans notice in performance and production: concepts, point choreography, formations and sound.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `crf-01` | Concept and worldbuilding | Explain why groups build story worlds and connected universes | `worldbuilding`, `concept-lore` | MC, ST, BC |
| `crf-02` | Choreography and point dance | Understand a 'point choreography' and why fans learn it | `point-choreography`, `dance-challenge` | MC, VI, ST |
| `crf-03` | Formations and stage design | Read a formation as a spatial story; link to native diagrams | `formation`, `stage-design` | HT, SO, MC |
| `crf-04` | Genre-blending inside one track | Hear multiple sections and genre switches in one track (link: music build-and-release) | `genre-blend`, `song-switch` | LI, MC, FG |
| `crf-05` | Language mix and hook lines | Understand Korean plus English lyrics and global-hook writing without quoting any lyrics | `language-mix`, `hook-line` | MC, BC, ST |
| `crf-06` | Styling, stylists and era aesthetics | Decode era aesthetics, styling and fashion-brand tie-ins | `styling`, `era-aesthetic` | MC, ST, VI |

**Unit `albums-and-collecting`: Albums, Photocards and Collecting** (layer `enthusiast-depth`; prerequisites: `comeback-cycle`; 6 lessons). The physical-product economy, handled with curiosity rather than judgment.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `alb-01` | Physical albums as fan objects | Explain why an album is a photobook plus collectible, not only a disc | `physical-album`, `album-version` | MC, VI, BC |
| `alb-02` | Photocards and trading | Explain photocards, trading etiquette and how to avoid scams | `photocard`, `trading-etiquette`, `scam-awareness` | DS, MC, ST |
| `alb-03` | Pre-order benefits and lucky draws | Understand store benefits and why fans buy multiple versions | `preorder-benefit`, `lucky-draw` | MC, DS, BC |
| `alb-04` | First-week sales and what the numbers mean | Interpret first-week sales and their limits | `first-week-sales`, `sales-context` | ES, MC, FG |
| `alb-05` | The 'too many versions' debate, fairly | Explain both sides of the multi-version debate and the environmental and cost concerns fans raise | `version-debate`, `sustainability-concern` | DS, BC, ST |
| `alb-06` | Merch, official vs resale | Know official shops, bootleg risk and what to ask first | `official-merch`, `bootleg-risk` | MC, DS, FG |

**Unit `debates-with-care`: Industry Debates, Handled with Care** (layer `enthusiast-depth`; prerequisites: `trainee-to-debut`, `fandom-culture`; 7 lessons). Real issues fans talk about: contracts, wellbeing, privacy, parasocial closeness and fandom behaviour. Tone: informed, neutral, human.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `dbt-01` | Contracts: the seven-year norm and the history | Explain the standard-contract rules and why the long-contract controversy mattered | `contract-length`, `standard-contract` | MC, SO, BC |
| `dbt-02` | Agency and group disputes, read carefully | Read a label-group dispute without picking a villain and know what is settled vs alleged | `dispute-literacy`, `alleged-vs-ruled` | DS, MC, ST |
| `dbt-03` | Wellbeing and workload | Talk about schedules, rest and mental health kindly; safe-messaging rules; point to real support | `idol-wellbeing`, `safe-messaging` | DS, MC, TT |
| `dbt-04` | Privacy and sasaeng behaviour | Explain why invasive fan behaviour is harmful and what fans do about it | `sasaeng`, `privacy-respect` | BC, DS, MC |
| `dbt-05` | Parasocial closeness, healthily | Name parasocial feelings, what is normal and what to watch | `parasocial`, `healthy-fandom-boundaries` | MC, DS, ST |
| `dbt-06` | Fandom conflicts and pile-ons | Understand fandom wars, doxxing and what a good fan does | `fandom-war`, `pile-on` | DS, TT, MC |
| `dbt-07` | Cultural respect and outsider talk | Talk about Korean culture without stereotypes or treating K-pop as costume | `cultural-respect`, `outsider-etiquette` | BC, TT, ST |


### Layer 4: Branches and personalization

**Unit `branch-performance`: Branch: Dance and Live Performance** (layer `branch`; prerequisites: `group-anatomy`, `concept-and-craft`; 3 lessons). For people whose person loves the stage.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `brp-01` | Reading a stage: sync, power and rhythm | Explain 'kalgunmu' (precision sync) and power moves without pretending to judge technique | `kalgunmu`, `sync-quality` | MC, TM, ST |
| `brp-02` | Dance breaks, line dances and solos | Name the set pieces of a performance | `dance-break`, `unit-stage` | HT, MC, FG |
| `brp-03` | Live vocals, in-ears and stage tech | Understand in-ear monitors, MR and live-band sets | `live-vocals`, `in-ear-monitor`, `mr-track` | MC, BC, ST |

**Unit `branch-charts-data`: Branch: Charts and Data** (layer `branch`; prerequisites: `music-shows-charts`; 3 lessons). For people whose person tracks numbers.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `brc-01` | Streaming, downloads and unique listeners | Tell streams, unique listeners and sales apart | `unique-listeners`, `stream-vs-sale` | MC, TM, ES |
| `brc-02` | Global charts and how K-pop gets counted | Explain why global and Korean charts count differently (link: music charts) | `global-chart-rules`, `chart-eligibility` | MC, BC, FG |
| `brc-03` | Reading a chart headline honestly | Practice interpreting a headline with context | `chart-headline-literacy`, `record-definition` | DS, MC, ST |

**Unit `branch-collector`: Branch: Collecting and Merch** (layer `branch`; prerequisites: `albums-and-collecting`; 3 lessons). For people whose person collects.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `brk-01` | Organising a collection kindly | Learn sleeves, binders and storing cards safely | `collection-care`, `photocard-storage` | VI, MC, ST |
| `brk-02` | Limited editions and release timing | Explain limited runs, restocks and how to ask | `limited-edition`, `restock` | MC, DS, FG |
| `brk-03` | Gift ideas that show you listened | Design a thoughtful gift that is not faking expertise | `thoughtful-gift`, `gift-etiquette` | DS, ST, MC |

**Unit `branch-legacy`: Branch: Legacy and Nostalgia** (layer `branch`; prerequisites: `generations-history`; 3 lessons). For people whose person loves older groups.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `brl-01` | Reunions, anniversaries and legacy acts | Understand reunion tours, anniversary albums and what fans feel | `reunion`, `anniversary-release` | MC, ST, BC |
| `brl-02` | Sunbae groups and their fans today | Explain how older groups keep fandoms alive | `legacy-fandom`, `sunbae-group` | MC, TM, ST |
| `brl-03` | Retro concepts and revival trends | Decode 'retro' and 'Y2K' concept trends | `retro-concept`, `revival-trend` | MC, VI, FG |


### Layer 5: Current season / live

**Unit `kpop-now`: K-pop Now (Live Layer)** (layer `current-context`; prerequisites: `comeback-cycle`, `music-shows-charts`, `fandom-culture`; 5 lessons). Refreshed weekly: comeback calendar, music-show weeks, tour announcements, awards season. Templates with live hooks; never hard-coded.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `now-01` | This week's comebacks | Use the comeback calendar to start a conversation | `comeback-calendar-reading` | MC, ST, TT |
| `now-02` | Why are fans talking about this today? | Explain a current topic in plain words with a link | `current-topic-explainer` | MC, ST, DS |
| `now-03` | Your group's era | Personalised era card for {{artist}} | `artist-era-context` | MC, ST, FG |
| `now-04` | Tour and ticket watch | Explain a new tour announcement and on-sale steps | `tour-announcement-reading` | DS, MC, ST |
| `now-05` | Awards season explainer | Explain nominations, categories and voting rules | `awards-season-reading` | MC, TM, ST |


### Layer 6a: Conversation practice

**Unit `conversation-lab`: Conversation Lab** (layer `conversation-practice`; prerequisites: `korean-fan-words`, `fandom-culture`; 8 lessons). Continuous practice: decode, respond, ask, and know when to simply listen.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `cnv-01` | She just said 'my bias wrecked me' | Decode bias-wrecker and similar terms and respond warmly | `bias-wrecker`, `warm-response` | TT, ST, MC |
| `cnv-02` | Comeback day conversation | Talk about a comeback with curiosity | `comeback-chat` | TT, ST, FG |
| `cnv-03` | Asking about her favourite member | Ask about a bias without ranking members | `bias-question`, `no-ranking-members` | TT, ST, BC |
| `cnv-04` | Streaming goal stress | Support without taking over | `support-listening` | TT, DS, ST |
| `cnv-05` | Concert plan talk | Plan a show day together | `concert-planning-chat` | TT, DS, ST |
| `cnv-06` | The sensitive topic | Respond kindly when an industry controversy comes up | `sensitive-topic-response` | TT, DS, ST |
| `cnv-07` | When you don't know | Admit it with curiosity instead of faking | `honest-not-knowing` | TT, ST, BC |
| `cnv-08` | Your turn: share what you like | Connect your own tastes without hijacking hers | `shared-ground` | TT, ST, MC |


### Layer 6b: Perpetual review

**Unit `review-loop`: Perpetual Review** (layer `perpetual-review`; prerequisites: `music-shows-charts`; 3 lessons). Spaced review of mastered concepts; ear-and-terms checks.

| Lesson id | Title | Objective | conceptIds | Planned activities |
|---|---|---|---|---|
| `rev-01` | Daily bite | Mixed recall of mastered concepts, max 12 items | `review-daily-mix` | MC, FG, TM |
| `rev-02` | Term refresh: Korean fan words | Review pronunciation and use of key terms | `review-korean-terms` | TM, LI, FG |
| `rev-03` | Ear check: a chant, a build, a language switch | Five synthesised clips; pass at 4 of 5 | `review-ear-check` | LI, MC, TP |

### Layer notes

- **Current-season layer (`kpop-now`).** Templates with `live` hooks; new cards weekly (comeback calendar, show weeks, tour announcements) and seasonal (awards, year-end shows). Evergreen fallback cards are always available. Lessons never hard-code live facts.
- **Conversation practice.** `conversation-lab` plus a talk-track or say-this closing every unit; 20 talk tracks at launch.
- **Perpetual review.** `review-loop`: daily bite (max 12), Korean-terms refresh, ear check. Intervals 1d, 3d, 7d, 14d, 30d, 60d.
- **Cross-links to `music` (neutral, not prerequisites):** `comeback-cycle` links `music:album-cycle` and `music:lead-single`; `crf-04` links `music:build-and-release`; `shw-05`/`brc-02` link `music:charts`; `liv-01` links `music:concert-flow`; `liv-02` links `music:presale-verified-fan`; `ind-05` links `music:writing-credits`.

### Concept targets, personalization slots, release plan

- **Concept target:** 221 concepts (Playbook), 68 terms in `exercises.md` (68 with example lines).
- **Personalization slots:** `artist` (and optional bias), `region`, `platform` (section 8).
- **Launch:** units 1-13, branch units 14-17 (short), `kpop-now` with evergreen fallbacks and a first comeback calendar, `conversation-lab` (8 lessons), `review-loop`.
- **Post-launch:** weekly live cards; new branch units (e.g. `global-members`, `variety-deep-dive`); seasonal awards units; new talk tracks quarterly; year-end explainer update.

### Appendix: Playbook concepts (ids by unit of first appearance)

- **`industry-map`** (12): `idol-definition`, `kpop-not-a-genre`, `agency-role`, `full-service-model`, `big-four-shorthand`, `agency-house-style`, `sub-label`, `independent-agency`, `songwriting-camp`, `producer-credit`, `hallyu`, `export-model`
- **`trainee-to-debut`** (13): `audition-types`, `casting`, `trainee-life`, `monthly-evaluation`, `survival-show`, `audience-vote`, `teaser-sequence`, `pre-debut-content`, `debut`, `showcase`, `debut-anniversary`, `rookie-window`, `rookie-award`
- **`group-anatomy`** (15): `leader-role`, `main-vocal`, `lead-vocal`, `rap-line`, `main-dancer`, `center`, `visual-role`, `maknae`, `age-line`, `honorifics-basics`, `subunit`, `solo-debut`, `unit-project`, `position-as-shorthand`, `member-individuality`
- **`comeback-cycle`** (14): `comeback`, `promotion-cycle`, `comeback-schedule`, `tracklist-reveal`, `title-track`, `b-side`, `focus-track`, `release-time`, `first-day-performance`, `promotion-window`, `promotion-activities`, `era`, `concept`, `hiatus-cycle`
- **`korean-fan-words`** (13): `romanization-basics`, `hangul-awareness`, `oppa-noona-hyung-eonni`, `address-terms`, `sunbae-hoobae`, `nim-suffix`, `choeae-bias`, `ipdeok-taldeok`, `deokhu`, `basic-greetings`, `hwaiting`, `korean-name-order`, `stage-name-vs-name`
- **`music-shows-charts`** (16): `music-show`, `weekly-show-calendar`, `show-win-formula`, `point-system`, `triple-crown`, `all-kill`, `encore-stage`, `live-vs-pre-recorded`, `circle-chart`, `hanteo`, `melon-chart`, `billboard-global`, `year-end-awards`, `daesang-bonsang`, `win-context`, `metric-humility`
- **`fandom-culture`** (15): `fandom-name`, `fandom-identity`, `lightstick`, `lightstick-sync`, `fan-chant`, `fan-slogan`, `streaming-party`, `voting-culture`, `fan-project`, `birthday-cafe`, `fancam`, `fan-translation`, `credit-etiquette`, `stan-culture`, `fandom-conflict`
- **`content-variety`** (13): `dance-practice`, `performance-video`, `variety-show`, `idol-persona`, `self-produced-content`, `live-stream`, `fan-platform`, `message-subscription`, `meme-culture`, `inside-joke`, `fansign`, `fan-meeting`, `video-call-event`
- **`live-tours`** (12): `concert-flow-kpop`, `ment-talk`, `fan-club-presale`, `presale-verified-fan`, `tour-leg`, `venue-size`, `venue-rules`, `banner-etiquette`, `festival-set`, `global-stage`, `crowd-safety`, `hearing-care`
- **`generations-history`** (16): `generation-shorthand`, `generation-debate`, `first-gen`, `idol-blueprint`, `second-gen`, `asian-expansion`, `third-gen`, `social-media-reach`, `fourth-gen`, `newer-gen`, `global-members`, `boy-group-tradition`, `girl-group-tradition`, `solo-scene`, `band-scene`, `trot-awareness`
- **`concept-and-craft`** (12): `worldbuilding`, `concept-lore`, `point-choreography`, `dance-challenge`, `formation`, `stage-design`, `genre-blend`, `song-switch`, `language-mix`, `hook-line`, `styling`, `era-aesthetic`
- **`albums-and-collecting`** (13): `physical-album`, `album-version`, `photocard`, `trading-etiquette`, `scam-awareness`, `preorder-benefit`, `lucky-draw`, `first-week-sales`, `sales-context`, `version-debate`, `sustainability-concern`, `official-merch`, `bootleg-risk`
- **`debates-with-care`** (14): `contract-length`, `standard-contract`, `dispute-literacy`, `alleged-vs-ruled`, `idol-wellbeing`, `safe-messaging`, `sasaeng`, `privacy-respect`, `parasocial`, `healthy-fandom-boundaries`, `fandom-war`, `pile-on`, `cultural-respect`, `outsider-etiquette`
- **`branch-performance`** (7): `kalgunmu`, `sync-quality`, `dance-break`, `unit-stage`, `live-vocals`, `in-ear-monitor`, `mr-track`
- **`branch-charts-data`** (6): `unique-listeners`, `stream-vs-sale`, `global-chart-rules`, `chart-eligibility`, `chart-headline-literacy`, `record-definition`
- **`branch-collector`** (6): `collection-care`, `photocard-storage`, `limited-edition`, `restock`, `thoughtful-gift`, `gift-etiquette`
- **`branch-legacy`** (6): `reunion`, `anniversary-release`, `legacy-fandom`, `sunbae-group`, `retro-concept`, `revival-trend`
- **`kpop-now`** (5): `comeback-calendar-reading`, `current-topic-explainer`, `artist-era-context`, `tour-announcement-reading`, `awards-season-reading`
- **`conversation-lab`** (10): `bias-wrecker`, `warm-response`, `comeback-chat`, `bias-question`, `no-ranking-members`, `support-listening`, `concert-planning-chat`, `sensitive-topic-response`, `honest-not-knowing`, `shared-ground`
- **`review-loop`** (3): `review-daily-mix`, `review-korean-terms`, `review-ear-check`

---

## 12. Interaction plan

Zero Unity simulations, on purpose. Tier rubric answered per family (CLAUDE.md section 4): does spatial reasoning, movement, physics, scene timing or camera perspective *materially* improve learning, and would a native exercise teach it clearly worse?

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Knowledge checks (roles, industry logic, charts) | roles, comeback, shows | `multiple-choice` | Recall and distinction; a simulation would be a fake game | B | ~240 |
| Judgment calls without a diagram (comeback vs return, respectful vs invasive) | comeback, privacy | `binary-call` (`scene.kind` none) | Two-way call; no visual needed | B | ~110 |
| Terms at unit start | roles, fan words, charts | `term-match` | Introduces 3-6 terms at once | B | ~60 |
| Comeback week, audition to debut, concert night | comeback-schedule, debut, concert-flow-kpop | `sequence-order` | Order is the concept; per-step reason carries logic | B | ~30 |
| Lightstick, photocard, banner, album kit | fan objects | `visual-id` | Recognition from generic original illustrations | B | ~28 |
| Crowds, trades, sensitive stories, presale | crowd-safety, scam-awareness, sensitive-topic-response | `decision-scenario` | Judgment with consequences; safety note where needed | B | ~50 |
| Conversation practice | conversation units | `talk-track` | Chat meter; replies reward curiosity | B | ~20 |
| Chant gap, slogan cue, lightstick lift | fan-chant | `timing-tap` | 1D bar timing only; scene timing would be Unity, but nothing here depends on seeing things move in space | B | ~12 |
| Decode fan lines | bias, comeback, chants | `say-this` | The course's core skill | B | ~140 |
| Vocabulary in context | terms | `fill-the-gap` | Fast review | B | ~60 |
| Audio sketches (chant gap, genre switch, greetings) | fan-chant, genre-blend | `listening-id` | Original synthesised or commissioned audio; real songs never used | B | ~50 |
| Dated magnitudes (contract cap, time zone, trainee years) | contract-length, release-time | `estimate-slider` | One number; dated | B | ~16 |
| Arena plan, album kit, comeback timeline, formation | formation, album-kit | `hotspot-tap` | Static diagrams; where, not when | B | ~20 |

**Rejected Tier A ideas (why none):**
1. *Formation viewer or choreography sim* (dancers moving on a stage). Formations do involve space, but the learning goal is social ("why does she love that moment?"), not reproducing choreography. A static formation diagram plus `hotspot-tap` teaches it clearly, and choreography is itself creative work we will not reproduce or simulate.
2. *Concert arena walk-through.* The decisions (where to stand, when to leave) are taught better by `decision-scenario` with a `safetyNote`; a 3D arena adds build cost and no extra understanding.
3. *Lightstick sync sim.* A `timing-tap` bar covers the only learning goal (landing on a beat).
4. *Music-show scoring sim.* The formula is a weighted table; `estimate-slider` and `multiple-choice` teach it, and formulas change, so a hard-coded sim would be wrong by next season.
5. *Trainee life sim.* Risks romanising a demanding life and inviting a fake-game tone; it is taught honestly with reading-and-decision items.

No Game Kit additions are requested.

---

## 13. Licensing & safety

| Area | Handling (spec sections 39-40, rule 10) |
|---|---|
| Audio | Original synthesised or commissioned only (`original-swoond`); no commercial recordings or snippets; no clones of a specific work; Korean-speaker word recordings under a commissioned licence covering app use. Real songs reached via official platform link-out. |
| Lyrics | Never reproduced or ingested, including short quotes; example lines are invented; translations of lyrics are not shown. |
| Imagery | Original illustrations only; generic lightsticks, photocards and banners; **no member photos**, no real lightstick designs, no concept photos, no fan-made artwork without a licence. |
| Logos and trademarks | Agency, group, lightstick, awards and platform marks: text mentions only; no logo files. |
| Video | No embedded MVs, dance practices, fancams or variety clips; deep-link to official channels only. |
| Article text | Never copy press text; headlines with links. |
| Data terms | Spotify, Apple Music, Ticketmaster, Bandsintown, Billboard/Luminate, Melon, Hanteo and Circle Chart each have terms; every provider sits behind a Swoon'd adapter; no scraping; scraping chart sites is prohibited; Weverse and other fan platforms have no public API and are not scraped. |
| Member likeness and names | Names as facts in dated data only; no fabricated quotes; no implied endorsement. Do not use stage names in a way that implies endorsement. |
| Translation and pronunciation | Romanization follows Revised Romanization of Korean with common fan spellings noted; reviewed by a Korean-language reviewer. |
| Cultural review | Required: Korean and Korean-diaspora fan reviewers check tone, honorifics, stereotypes, the wording of the industry-debate units and the glossary. |

**Safety and care constraints:**
- **Wellbeing:** wellbeing and controversy content follows safe-messaging guidance: no methods, no speculation about real people, no rumours; point to local crisis resources by `region`; never diagnose.
- **Privacy and respect:** never coach locating private addresses, following idols, or approaching them off-stage; sasaeng behaviour is named as harmful.
- **Parasocial feelings:** treated as normal and human; flag healthy boundaries (spending, sleep, time) without shaming.
- **Money:** albums, merch and paid messages are not gamified; teach budgeting and scam awareness; official resale only.
- **Crowds and hearing:** hearing and crowd guidance as in the `music` course; general information, not medical advice.
- **Fandom conflict:** never encourage pile-ons, doxxing or brigading.
- Never encourage the learner to fake expertise or taste; never grade taste or rank members.

---

## 14. Content assets

| Asset | Source | Licence | Count |
|---|---|---|---|
| Original illustrations (lightstick, photocard, banner, album kit, arena plan, formation) | Procedural/vector | `original-swoond` | ~30 |
| Diagrams (comeback timeline, chart map, show calendar) | Drawn natively from data | `original-swoond` | ~10 |
| Synthesised audio (chant gap, genre switch, meter, build) | In-house synth or commissioned composer | `original-swoond` | ~40 |
| Korean word recordings | Commissioned native speakers | `original-swoond` (commissioned) | ~25 |
| Fonts | Instrument Serif, Geist; a Korean fallback such as Noto Sans KR (OFL) | OFL | 1-2 |
| Platform link icons | Text links only at launch | n/a | 0 |

---

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** That K-pop is a system (agency, trainee, debut), the comeback rhythm, group roles, music-show and chart basics, fandom objects and words (sections 2, 3, 11).
- [x] 2. **What do enthusiasts care about?** Comebacks, eras, concepts, member moments, stages, charts, fandom rituals, collecting, concerts and awards (section 4).
- [x] 3. **What current information matters?** Comeback calendar, show weeks, tours and on-sales, awards, industry stories (sections 6, 7; `live-data.md`).
- [x] 4. **What should be interactive?** Decoding fan lines, ordering a comeback week, hearing a chant gap, tapping a diagram, crowd and trade judgments, talk tracks (section 12).
- [x] 5. **What should NOT be gamified?** Wellbeing topics, member rankings, fandom rank boards, stream goals, spending, tracking (section 5).
- [x] 6. **How should it personalize?** `artist` (group, optional bias), `region`, `platform`, five branches (sections 1, 8).
- [x] 7. **What does conversational competence look like?** Section 10's competence statement and section 9's 18 lines.
- [x] 8. **What data providers are needed?** MusicBrainz, Apple Music API, Spotify Web API, Ticketmaster, Circle Chart, Hanteo, Melon, Billboard (link-out), curated editorial; all behind adapters (section 6, `live-data.md`).
- [x] 9. **What licensing constraints apply?** Section 13: no recordings, MVs, lyrics or member photos; original illustrations and audio; chart and metadata terms checked.
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery at 0.8, talk-track curiosity, ear check; never taste (section 10).

Additional gates: [x] manifest validates (run `node validate.mjs --course k-pop --partial`); [ ] curriculum validates (curriculum not authored yet); [x] no Unity sims, so no sim specs needed; [ ] every image/audio asset has a license id (assets not produced yet; ids assigned); [ ] voice review; [ ] cultural and Korean-language review; [x] no copied publisher text.

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Cultural review panel: who reviews tone, honorifics, stereotypes and the industry-debate units (Korean-language reviewer plus Korean and diaspora fans)? | Product owner | Yes, before release |
| 2 | Korean-capable fallback font for Hangul next to Geist (Noto Sans KR vs system Apple SD Gothic Neo). | Design / Claude Code | Yes, for Hangul display |
| 3 | Is showing Hangul alongside romanization acceptable, or romanization only at launch? | Product owner | No |
| 4 | Deep-link policy to fan platforms (Weverse-type) and streaming services; none have public APIs for our use. | Legal | No |
| 5 | Chart providers: Circle Chart/Hanteo/Melon data terms; link-out only at launch? | Legal | No |
| 6 | Are named groups allowed in dated data cards (comeback calendar) without a licence? Names as facts only. | Legal | No |
| 7 | Commissioned Korean voice talent vs TTS for word clips (TTS quality and licence). | Product owner | No |
| 8 | Wellbeing content: adopt a safe-messaging checklist and region-by-region crisis resource list. | Product owner / SME | Yes, for `dbt-03` |
| 9 | Resolved (D-022, manifest contract 1.3): `member` added to `personalizationDimensions` and listed in the manifest; branch dimensions stay `artist`. | Orchestrator | No |
| 10 | Generation labels: keep 1st-5th with caveats, or avoid numbering? | SME review | No |
