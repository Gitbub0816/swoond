# Course Design Specification: Anime (`anime`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 3 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity sims, justified in section 12) |

Time-sensitive facts (streaming catalogues, the fall 2026 lineup, studio news, industry figures) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Evergreen lessons never hard-code them; the live layer and `{{tokens}}` carry them (see `live-data.md`).

**Two design constraints shape this course.**

1. **Media licensing (spec section 40, rule 10).** Swoon'd talks *about* anime; it never redistributes it. No stills, frame grabs, key art, posters, character art, trailers, clips, OP/ED or soundtrack audio, song lyrics, voice clips, or publisher/synopsis text. Teaching images are **original Swoon'd illustrations of a technique** (sparkle-background shorthand, smear frames, a manga page's reading order, a season-chart card). Titles, studios and people appear as text facts only. Details: section 13.
2. **Mature themes.** Anime spans every age band. Some celebrated series deal with war, loss, cruelty and violence. The course teaches understanding and kind conversation at **survey depth and non-graphic**, never pushes mature titles at a learner of unknown age, and teaches ratings literacy instead (`wa-07`, `cr-06`, `db-04`). Fanservice is discussed only as a taste debate, not described.

---

## 1. Identity

- **Course ID:** `anime` (immutable)
- **Display name:** Anime
- **Category / family:** Film & Television > Anime (family `Film & Television`)
- **Simulation prefix:** `anime` (reserved; no sims are planned)
- **What "Anime" means here.** The person you care about might be a *weekly-season* watcher who tracks every premiere, a *long-runner* fan on hundreds of episodes of one series, a *Ghibli and film* lover, a *comfort-show* slice-of-life fan, a *manga reader* who loves the source more, or a *convention goer and cosplayer*. The course teaches the shared language (what anime is, demographics, genres, production, studios, seasons, sub and dub, adaptation, fandom) and tilts by branch. Focus is talking about the medium and the fandom; the course never requires watching anything.
- **Related courses and boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Movies (`movies`) | Partly. Movies gives film language (framing, editing, sound). It does not give manga pipelines, seasonal broadcast, studios, sub/dub or fandom vocabulary. The reverse also fails. | **Independent, adjacent** (catalog: "Independent of movies (culture/terms)") | Lessons `cr-03`, `sf-03` carry a one-line cross-link to movies (`movies:fr-06` Light, `movies:fr-03` Composition) and never re-teach film language. |
| Video Games (`video-games`) | Partly. Gacha, JRPGs and visual novels feed anime (and the reverse), but game fandom has other terms and live data. | **Adjacent** | `cc-04` (gacha tie-ins) and `ma-03` (game-to-anime adaptations) cross-link to `video-games`. No dependency. |
| Horror Films (`horror-films`) | Anime horror exists (psychological thrillers, Junji Ito adaptations), but horror film culture is separate. | **Adjacent** | `gt-08` covers anime thrillers gently; horror-films `wr-02` covers J-horror cinema. Cross-link only. |
| K-pop (`k-pop`) | Shared fandom behaviours (oshi culture, merch, events), different artists and releases. | **Independent** | `fv-04` (oshi) names the idol-culture origin; no merge. |
| Books (`books`) | Manga and light novels are books in form, but reading culture differs. | **Adjacent** | `ma-01` to `ma-03` teach manga/light-novel publishing; no dependency. |
| Music (`music`) | Anime music is a craft inside the medium. | **Adjacent** | `hm-07` and `cr-04` cover it by craft, never quoting. |
| Sub-worlds: battle shonen, seinen and prestige, slice of life and romance, studios and films | Shared foundation; each has its own canon and talk. | **Shares foundation** | Four branches. |

- **Branches** (the "what kind of anime fan is she" lens; foundation is shared; a learner may enable several; choosing a branch never implies watching anything).

| id | Name | What changes |
|---|---|---|
| `shonen-battle` (default) | Shonen and long-runners | Arcs, power systems, rivals, hundreds of episodes, tie-in films, the "Big Three" argument. Personalizes by franchise. |
| `seinen-prestige` | Seinen and prestige | Moral grey, mystery and thriller structure, sci-fi and cyberpunk canon, how to ask about heavy stories kindly. |
| `slice-romance` | Slice of life and romance | Comfort shows, romance beats, school and music-club life, shojo and josei classics. |
| `studio-film` | Studios and films | Ghibli-fan vocabulary, theatrical anime and the box office, auteur film language, festivals and the Oscars. Personalizes by studio or director. |

---

## 2. Beginner model

**What a complete beginner typically knows.** They know the word "anime", a handful of famous titles and characters, that it's Japanese, and that it has a look: big eyes, colourful hair. They know their own reaction ("is it cartoons for kids?"). They may know the word "otaku" and be unsure whether it is an insult.

**Terminology that will initially confuse them.**
- Shelves and forms: shonen, shojo, seinen, josei; OVA, ONA, cour, split cour, season vs arc.
- Fandom: isekai, filler, canon, OP, ED, waifu, oshi, tsundere, senpai, sakuga, moe, "peak", "mid".
- Business: production committee, simulcast, simuldub, raws, fansub, licensing window, "BD sales".
- Craft: key animator, animation director, on twos, limited animation.

**Common misconceptions.**
1. "Anime is a genre." (It is a medium spanning every genre.)
2. "It is all for kids." (Every age band has shows; ratings exist.)
3. "It all has the big-eyes look." (Styles vary enormously by studio and director.)
4. "Subs are for snobs; dubs are for kids." (Both are legitimate and personal.)
5. "Filler is bad." (Some filler is beloved; the word names a fact, not a verdict.)
6. "The anime and manga are the same story." (Adaptations cut, reorder and sometimes invent endings.)
7. "Anime is cheap animation." (Limited animation is a craft choice; sakuga is huge.)
8. "Weeb and otaku are harmless slang everywhere." (Tone depends on the speaker.)
9. "Free streaming sites are fine." (They are unlicensed; official releases fund the creators.)
10. "Watching means I must catch up with 1,000 episodes." (You can understand a long-runner through its arcs.)

**Concepts that unlock the rest (become foundation units).** (1) Anime is a medium. (2) Where stories come from (manga, light novel, original) and what a cour is. (3) Demographics as magazine shelves. (4) Genre grammar (isekai, mecha, slice of life). (5) Fandom vocabulary and its tone. (6) How a show is made and who is credited.

---

## 3. Foundational knowledge

| Module (unit id) | Contents |
|---|---|
| `what-anime-is` | Medium vs genre, source ladder, cours, formats, title reading, myths, ratings. |
| `demographics` | Shonen, shojo, seinen, josei, kodomo; crossovers. |
| `genres-and-tropes` | Battle shonen, isekai, mecha, slice of life, romcom, sports, magical girl, thriller, archetypes. |
| `fandom-vocabulary` | Otaku, OP/ED, filler/canon, waifu, raws/fansubs, honorifics, slang, spoiler etiquette. |
| `how-anime-is-made` | Production committee, studio/publisher/distributor, pipeline, roles, sakuga, seiyuu, composers. |

History, culture, equipment (merch) and organizations are in later layers.

---

## 4. Enthusiast model

**What enthusiasts talk about.** What is airing this season and on which service; adaptation quality; studio workload; sakuga moments; which openings slap; sub vs dub; whether an arc was paced well; manga vs anime; which voice actor plays whom; convention plans; cosplay progress; new merch; tier lists.

**Distinctions that matter.** Canon vs filler vs anime-original; season vs cour vs arc; studio vs director; demographic vs genre; OVA vs ONA vs film; simulcast vs licence windows; scanlation vs official release; moe vs fanservice (taste debate).

**Knowledge that signals genuine understanding.** Knowing a show's studio and director; saying "second cour"; naming who did the key animation for a scene; knowing the source and whether the anime has caught up; naming the source magazine's shelf.

**Statements that sound uninformed.** "Anime is cartoons." "Is that the one with big eyes?" "Why do they scream so much?" "It's all the same." "It's basically for kids."

**Controversies and debates (taught as debates, not settled).** Sub vs dub; adaptation faithfulness; the Big Three and its successors; power scaling; production committee and animator pay; generative AI in anime; fanservice and taste; overrated vs underrated; legal vs unlicensed viewing; streaming exclusives. The course presents sides, never verdicts on contested ethics beyond "support official releases".

---

## 5. Interaction model

- **What the learner experiences.** Sorting shows onto demographic shelves, ordering the production pipeline, spotting visual shorthand in original illustrations, decoding fan messages (`say-this`), choosing how to respond in awkward situations (piracy links, cosplay consent, dub arguments), and practising talk tracks.
- **Does the course warrant Unity?** **No.** No concept in the subject materially needs a moving spatial scene. Animation technique (on twos, smear frames) is best taught by a labelled still diagram and a short original loop, not a physics sim. See section 12 for the justification and what was considered.
- **What should NOT be gamified.** Fan tastes (no "best anime" scoring), consumption volume (no "episodes watched" XP), mature content (never rewarded as bravery), piracy, and fandom rankings of real people. No leaderboards.
- **Mix.** Native only: multiple-choice, term-match, sequence-order, visual-id, decision-scenario, say-this, talk-track, fill-the-gap, estimate-slider, hotspot-tap, binary-call, listening-id (original audio only).

---

## 6. Dynamic information requirements

| Kind | Needed? | Why and how |
|---|---|---|
| Schedules | Yes, weekly (daily at season start) | Seasonal chart: premieres and weekly episodes; Swoon'd-curated plus title metadata provider. |
| Releases | Yes, weekly | New series, sequels, films, announcements (key visual, PV). Text cards only; no artwork. |
| New media | Yes, daily | Where-to-watch availability per region (streaming provider API). Fallback: hide availability. |
| Events | Yes, weekly | Conventions, film releases, awards dates (Crunchyroll Anime Awards, Annecy, Academy Awards for animated feature). Curated. |
| News | Yes, daily | Industry stories; explain in our words and link. See OPEN_QUESTIONS L-01. |
| Rankings | Optional, weekly | Top-line Japanese box office for anime films; no mirrored tables. |
| Scores, standings, statistics | **No.** Anime is not a sport. Community scores (AniList, MAL) are not a product feature; if shown, only as a link-out. |

Structured data (season chart, availability) and editorial (why it is buzzing) are separate systems. Full plan: `live-data.md`.

---

## 7. Editorial context

- **What commentary helps.** Why a show is trending this week; what a sequel announcement means; why a studio is in the news; what an adaptation change means for fans; why a film is a box-office event.
- **Sources** (link-only, never copied): Anime News Network, Crunchyroll News, Polygon, Variety, official studio, publisher, festival and awards pages.
- **Approach.** Explain in our own words and link. No publisher or synopsis text.
- **Example prompts.** "Why is everyone talking about this show today?" "What does 'cour 2' mean for this series?" "What is the argument about the new adaptation?"

---

## 8. Personalization

| Dimension | Changes | Default | Tokens |
|---|---|---|---|
| Franchise | Examples, arc talk, tie-in films, conversation lines | A generic long-runner example set | `{{franchise}}` in `branch-shonen-battle`, `cx-03`, conversation lab |
| Genre | Which genre units and examples lead | Slice-of-life and shonen mix | `{{genre}}` in genres unit, conversation lab |
| Platform | Availability cards | Unset: hide availability | `{{platform}}` in `sl-01`, `sl-02` |
| Region | Which services and delays apply | Country from device, else unset | `{{region}}` in `sl-02`, `ss-02` |
| Studio / director | Studio and director spotlights | Ghibli and a modern studio | `{{studio}}` in `studios-and-directors`, `branch-studio-film` |

Discreet mode on by default: notifications never contain the Person's name.

---

## 9. Conversation model

Example lines an enthusiast might say, with translation:

1. "It's an isekai but the MC is actually competent." / A portal-fantasy where the hero is skilled for a reason; she is comparing it to the usual overpowered trope.
2. "They adapted two cours in one season." / Faster pacing than usual, likely cuts.
3. "Ugh, the second cour is on hiatus." / The second half of the run is delayed.
4. "The OP is peak, I never skip it." / She loves the opening.
5. "It's MAPPA so the sakuga is going to be nuts." / Studio reputation for action animation.
6. "I'm anime-only, don't spoil." / She has not read the manga.
7. "The dub is actually good." / Dubs have improved; she is open to them.
8. "It caught up with the manga so it's filler now." / The anime ran out of source material.
9. "That studio is really overworked." / Industry workload discussion.
10. "I'm cosplaying at the con in spring." / She is making a costume.
11. "It's a Ghibli rewatch night." / A comfort ritual.
12. "Can't wait for the new season of my show." / A returning series.

**Next questions.** "What do you love about it?" "Which arc is your favorite?" "Sub or dub for you?" "What should I watch first?" **How Swoon'd helps without faking.** Every `say-this` ends with honest follow-up lines; `noFakeExpert` framing is on every item; never "pretend you have seen it". **Targets:** 24 talk tracks, 90 say-this items.

---

## 10. Assessment

- **Competence** is determined by concept mastery of the playbook, decoding fan messages, and handling conversation scenarios kindly.
- The learner should recognise fandom terms, understand how shows are made and released, explain what a cour is, and handle sub/dub, spoilers and cosplay etiquette.
- **Mastery model:** `concept-mastery-v1`, pass threshold 0.8.
- **Useful competence statement:** "I can follow and join a conversation about anime: I understand the shelves, genres, studios, seasons and fandom vocabulary people use, I know how to ask honest, curious questions, and I can enjoy the conversation without pretending to have watched everything."

---

## 11. Curriculum map (ongoing course)

Designed as an ONGOING course: foundations, intermediate, enthusiast depth, branches, a live season layer, then perpetual conversation and review. Totals: **21 units, 120 lessons, 225 unique concepts**. The current-season unit holds lesson *templates* that regenerate each season; the lessons below are the launch instances.

### Layer 1: Foundations (5 units, 38 lessons)

**Unit `what-anime-is`: What Anime Is** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `wa-01` | Anime is a medium, not a genre | Explain that anime is Japanese-style animation spanning every genre and age band, not one look or one audience. | anime-as-medium, genre-vs-medium | multiple-choice, visual-id, say-this, fill-the-gap |
| `wa-02` | Manga, light novels and originals | Name where anime stories come from and why the source matters to fans. | source-ladder, manga, light-novel, original-anime | multiple-choice, term-match, fill-the-gap, say-this |
| `wa-03` | Episodes, cours and seasons | Say how long a cour is and why 'season 2' can mean a new cour or a whole new run. | cour, split-cour, season-numbering | estimate-slider, multiple-choice, sequence-order, fill-the-gap |
| `wa-04` | TV, OVA, ONA and films | Tell TV series, OVA/ONA and theatrical films apart and know which one someone means. | tv-anime, ova-ona, anime-film | term-match, multiple-choice, binary-call, say-this |
| `wa-05` | Reading a title | Decode 'Part 2', 'The Final Season' and arc names without asking for a recap. | arc-vs-season, sequel-naming | multiple-choice, sequence-order, fill-the-gap, decision-scenario |
| `wa-06` | Myths worth retiring | Spot the big-eyes, all-for-kids and all-the-same myths and answer them kindly. | style-myths, stylisation-range | visual-id, binary-call, multiple-choice, say-this |
| `wa-07` | Ratings and knowing what you are pressing play on | Read a content rating and pick something sensible for a shared watch without pushing mature titles. | content-rating-literacy, shared-watch-etiquette | decision-scenario, multiple-choice, say-this, fill-the-gap |

**Unit `demographics`: Demographics: Shonen, Shojo, Seinen, Josei** (prereq: `what-anime-is`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `dm-01` | The four-shelf map | Match shonen, shojo, seinen and josei to their target readers and say why the labels exist. | demographic-marketing, magazine-origin | term-match, multiple-choice, fill-the-gap, visual-id |
| `dm-02` | Shonen: effort, rivals and growth | Describe the shonen promise and recognise its usual beats. | shonen, jump-values | multiple-choice, say-this, sequence-order, fill-the-gap |
| `dm-03` | Shojo: feelings up front | Describe shojo's focus on inner life and relationships and its visual shorthand. | shojo, shojo-visual-language | multiple-choice, visual-id, say-this, fill-the-gap |
| `dm-04` | Seinen: grown-up stories | Explain that seinen aims at adult readers and what that changes in tone and pacing. | seinen, psychological-realism | multiple-choice, binary-call, say-this, term-match |
| `dm-05` | Josei: adult life and love | Describe josei's focus on grown-up relationships, work and daily life. | josei, adult-relationships | multiple-choice, say-this, term-match, fill-the-gap |
| `dm-06` | Kodomo and all-ages | Place children's and family anime and explain 'all-ages' honestly. | kodomo, all-ages | multiple-choice, term-match, binary-call, say-this |
| `dm-07` | A shelf, not a fence | Explain why a show can cross demographic lines and how genre differs from demographic. | crossover-audience, demographic-vs-genre | decision-scenario, multiple-choice, say-this, fill-the-gap |

**Unit `genres-and-tropes`: Genres and Tropes** (prereq: `demographics`). 9 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `gt-01` | Battle shonen and power systems | Explain power systems, tournament arcs and training arcs as the genre's grammar. | battle-shonen, power-system, tournament-arc, training-arc | multiple-choice, term-match, sequence-order, say-this |
| `gt-02` | Isekai: another world | Distinguish reincarnation, transportation and trapped-in-a-game isekai and the overpowered-hero joke. | isekai, isekai-subtypes, overpowered-mc | term-match, multiple-choice, binary-call, say-this |
| `gt-03` | Mecha: giant robots | Separate super robot from real robot and place the genre in anime history. | mecha, real-vs-super-robot | visual-id, multiple-choice, term-match, say-this |
| `gt-04` | Slice of life and iyashikei | Explain why quiet, low-stakes shows are loved and what 'healing' anime means. | slice-of-life, iyashikei | multiple-choice, say-this, fill-the-gap, binary-call |
| `gt-05` | Romance and romcom | Recognise romcom beats and the harem trope as a genre convention without judgement. | romcom, harem-trope | multiple-choice, term-match, say-this, fill-the-gap |
| `gt-06` | Sports anime | Explain why sports anime is about people and team stakes more than the sport. | sports-anime, underdog-team | multiple-choice, say-this, decision-scenario, fill-the-gap |
| `gt-07` | Magical girl | Describe the magical girl formula and its long shadow over modern anime. | mahou-shoujo, transformation-sequence | multiple-choice, visual-id, term-match, say-this |
| `gt-08` | Thrillers, mystery and horror, gently | Discuss psychological thrillers and horror-tinged anime without graphic detail. | psychological-thriller, cat-and-mouse-story | multiple-choice, say-this, decision-scenario, fill-the-gap |
| `gt-09` | Archetypes: tsundere and friends | Use character archetypes as shorthand while knowing characters are more than labels. | character-archetypes, senpai-kouhai | term-match, multiple-choice, say-this, visual-id |

**Unit `fandom-vocabulary`: Fandom Vocabulary** (prereq: `what-anime-is`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fv-01` | Otaku, weeb and tone | Know how loaded the words are and pick friendly ones. | otaku, weeb-label, gatekeeping | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `fv-02` | OP, ED and the skip button | Explain openings and endings and why fans argue about them. | op-ed, opening-culture | term-match, multiple-choice, say-this, fill-the-gap |
| `fv-03` | Filler, canon and recaps | Tell canon from filler from anime-original content and recap episodes. | filler, canon, anime-original-content, recap-episode | term-match, multiple-choice, binary-call, say-this |
| `fv-04` | Waifu, husbando and best girl | Understand waifu, husbando, oshi and best-girl talk as affectionate fandom play. | waifu-husbando, best-girl-discourse, oshi | multiple-choice, say-this, fill-the-gap, decision-scenario |
| `fv-05` | Raws, fansubs and scanlations | Know what these words mean, why official releases matter, and never treat piracy as a flex. | raw-fansub-scanlation, official-release | term-match, multiple-choice, decision-scenario, fill-the-gap |
| `fv-06` | Honorifics: -san, -kun, -senpai | Read honorifics as relationship signals and use them lightly and correctly. | honorifics, sensei-title | term-match, multiple-choice, fill-the-gap, say-this |
| `fv-07` | Kawaii, moe and internet shorthand | Decode 'peak', 'mid', 'cooking' and 'moe' without cringing. | kawaii-moe, meme-shorthand | multiple-choice, say-this, fill-the-gap, term-match |
| `fv-08` | Spoilers, hot takes and the manga-reader flex | Keep spoiler etiquette and handle the manga-reader flex gracefully. | spoiler-etiquette, manga-reader-flex, tier-list | decision-scenario, multiple-choice, say-this, fill-the-gap |

**Unit `how-anime-is-made`: How Anime Is Made** (prereq: `what-anime-is`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hm-01` | The production committee | Explain why many companies fund one show and what that means for decisions. | production-committee, licensor | multiple-choice, sequence-order, term-match, say-this |
| `hm-02` | Studio, publisher, distributor | Tell who animates, who owns the story and who streams it. | animation-studio, publisher, distributor | term-match, multiple-choice, decision-scenario, fill-the-gap |
| `hm-03` | From storyboard to screen | Put the production pipeline in order. | storyboard-ekonte, key-animation, in-betweening, compositing-finishing | sequence-order, hotspot-tap, multiple-choice, fill-the-gap |
| `hm-04` | Who does what: director to key animator | Name the main creative roles and which ones fans track. | director-role, series-composition, character-designer, animation-director | term-match, multiple-choice, say-this, decision-scenario |
| `hm-05` | Limited animation and sakuga | Explain why anime saves drawings and why fans celebrate sakuga moments. | limited-animation, sakuga, animating-on-twos | multiple-choice, visual-id, say-this, fill-the-gap |
| `hm-06` | Seiyuu: Japan's voice actors | Explain the seiyuu scene and why fans follow them. | seiyuu, voice-casting | multiple-choice, say-this, term-match, fill-the-gap |
| `hm-07` | Composers and theme songs | Talk about anime music by who made it and how tie-ins work, without quoting lyrics. | composer, theme-song-tie-in | multiple-choice, term-match, say-this, decision-scenario |

### Layer 2: Intermediate (4 units, 27 lessons)

**Unit `studios-and-directors`: Studios and Directors** (prereq: `how-anime-is-made`). 9 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `st-01` | Studio brand or director brand? | Explain when fans follow a studio and when they follow a person. | studio-vs-director-brand, credits-reading | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `st-02` | Studio Ghibli | Describe Ghibli's identity, founders and why it is a category of its own. | studio-ghibli, hand-drawn-tradition | multiple-choice, term-match, say-this, sequence-order |
| `st-03` | Kyoto Animation | Describe KyoAni's in-house craft reputation, with care about its history. | kyoto-animation, in-house-studio-model | multiple-choice, visual-id, say-this, fill-the-gap |
| `st-04` | MAPPA | Place MAPPA in the modern boom and the workload conversation around it. | mappa, studio-workload | multiple-choice, term-match, say-this, decision-scenario |
| `st-05` | ufotable | Recognise ufotable's digital-compositing look and its in-house model. | ufotable, digital-compositing-look | multiple-choice, visual-id, say-this, fill-the-gap |
| `st-06` | Legacy studios: Toei, Sunrise, Madhouse, Bones | Sort the long-standing studios by what each is known for. | legacy-studios, toei-animation | term-match, multiple-choice, say-this, sequence-order |
| `st-07` | Newer studios: Trigger, Wit, CloverWorks, Science SARU | Sort the newer names and what they signal. | modern-studios, studio-house-style | term-match, multiple-choice, say-this, fill-the-gap |
| `st-08` | Directors people follow | Name directors fans follow and what each is known for. | anime-auteur, film-directors-anime | term-match, multiple-choice, say-this, decision-scenario |
| `st-09` | Outsourcing, CGI and 'who really animated it' | Understand subcontracting and CGI debates without treating them as scandals. | subcontracting, cgi-in-anime | multiple-choice, decision-scenario, say-this, fill-the-gap |

**Unit `seasons-and-simulcast`: Seasons and Simulcast Culture** (prereq: `what-anime-is`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ss-01` | Four seasons a year | Name the four anime seasons and when they start. | season-calendar | sequence-order, multiple-choice, estimate-slider, fill-the-gap |
| `ss-02` | Simulcast: same week as Japan | Explain simulcasting and why it changed fandom. | simulcast, licensed-region | multiple-choice, term-match, say-this, fill-the-gap |
| `ss-03` | Reading a season chart | Read a seasonal chart: new, sequel, returning, which service. | season-chart, sequel-vs-new | decision-scenario, multiple-choice, term-match, fill-the-gap |
| `ss-04` | Announcements: visuals, PVs and casting news | Explain how a series is announced and what fans read into each step. | key-visual-pv, announcement-cycle | sequence-order, multiple-choice, say-this, fill-the-gap |
| `ss-05` | Weekly episode culture | Explain why weekly release creates shared discussion, memes and spoiler rules. | weekly-discourse, episode-thread | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `ss-06` | Delays, hiatuses and the money side | Explain production delays, hiatuses and why disc sales still matter. | production-delay, bd-sales-economy | multiple-choice, decision-scenario, say-this, estimate-slider |

**Unit `sub-dub-and-language`: Sub, Dub and Language** (prereq: `fandom-vocabulary`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sd-01` | Sub vs dub, honestly | Explain both sides of the sub/dub choice and why it is personal. | sub-vs-dub, simuldub | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `sd-02` | How dubs grew up | Sketch the shift from heavily edited localisation to faithful dubs. | localization-history, edited-dub-era | sequence-order, multiple-choice, say-this, fill-the-gap |
| `sd-03` | What subtitles carry and lose | Give examples of puns, register and honorifics and how translators handle them. | translation-nuance, register-and-puns | multiple-choice, decision-scenario, say-this, term-match |
| `sd-04` | Titles, names and romaji | Explain why one show has several titles and how romanisation works. | romaji-vs-english-titles, title-localisation | term-match, multiple-choice, fill-the-gap, say-this |
| `sd-05` | Keeping the peace | Handle a sub/dub argument without picking a fight. | dub-debate-etiquette, casting-choice | decision-scenario, multiple-choice, say-this, fill-the-gap |

**Unit `manga-and-adaptation`: Manga and Adaptation** (prereq: `what-anime-is`, `fandom-vocabulary`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ma-01` | How manga is published | Explain serialisation, chapters, tankobon volumes and reading direction. | serialization, tankobon, right-to-left-reading | term-match, multiple-choice, sequence-order, fill-the-gap |
| `ma-02` | The weekly magazine engine | Explain the weekly magazine model and why cancellations and hiatuses happen. | weekly-magazine-model, reader-ranking | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `ma-03` | Light and web novels: the isekai pipeline | Explain how web-novel popularity turns into light novels and anime. | web-novel-pipeline, light-novel-adaptation | sequence-order, multiple-choice, term-match, say-this |
| `ma-04` | What adaptations change | Spot common adaptation choices: cuts, reordering, added scenes. | adaptation-faithfulness, pacing-cuts | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `ma-05` | When the anime catches up | Explain anime-original endings and why a remake can follow. | anime-overtakes-source, anime-original-ending | multiple-choice, binary-call, say-this, fill-the-gap |
| `ma-06` | Anime-only or manga reader? | Handle the anime-only versus manga-reader divide kindly. | anime-only, source-reader-etiquette | decision-scenario, multiple-choice, say-this, term-match |
| `ma-07` | Live-action adaptations | Understand why live-action adaptations spark so much debate. | live-action-debate, adaptation-expectations | multiple-choice, decision-scenario, say-this, fill-the-gap |

### Layer 3: Enthusiast depth (5 units, 27 lessons)

**Unit `history-and-eras`: History and Eras** (prereq: `studios-and-directors`, `manga-and-adaptation`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hi-01` | Tezuka and the TV model | Explain how early TV anime shaped the limited-animation model. | tezuka, tv-anime-origin | sequence-order, multiple-choice, say-this, fill-the-gap |
| `hi-02` | Robots, space and the OVA boom | Place the 1970s-80s mecha boom and the home-video OVA era. | mecha-boom, ova-boom | sequence-order, multiple-choice, term-match, say-this |
| `hi-03` | Late night and the 1990s canon | Explain late-night anime and the 1990s shows fans still cite. | late-night-anime, evangelion-era | multiple-choice, term-match, say-this, fill-the-gap |
| `hi-04` | The digital era and moe | Explain digital production and the moe boom of the 2000s. | digital-era, moe-boom | multiple-choice, sequence-order, say-this, fill-the-gap |
| `hi-05` | Streaming and the global boom | Explain how streaming turned a niche into a global mainstream. | global-boom, streaming-era | multiple-choice, decision-scenario, say-this, estimate-slider |
| `hi-06` | The must-watch list debate | Talk about canon films and why every 'best ever' list starts an argument. | canon-films, canon-list-debate | multiple-choice, term-match, say-this, decision-scenario |

**Unit `craft-and-critique`: Craft and Critique** (prereq: `history-and-eras`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cr-01` | What sakuga fans see | Describe what makes a moment of animation stand out to a fan. | sakuga-fandom, key-animator-style | visual-id, multiple-choice, say-this, fill-the-gap |
| `cr-02` | Backgrounds, colour and light | Explain art direction and why anime backgrounds get their own fans. | art-direction, background-art | visual-id, hotspot-tap, multiple-choice, say-this |
| `cr-03` | Direction and the frame | Apply film language (see the movies course) to anime: layout, framing, cutting. | anime-cinematography, layout | visual-id, multiple-choice, say-this, fill-the-gap |
| `cr-04` | Sound, score and silence | Talk about sound design and score by craft, not by quoting. | sound-design, bgm-vs-insert-song | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `cr-05` | Talking about themes | Discuss what a series is about using questions, not verdicts. | theme-talk, subtext | decision-scenario, multiple-choice, say-this, term-match |
| `cr-06` | Mature themes, gently | Discuss war, loss, violence or cruelty at survey depth with care. | mature-themes-discussion, content-warning-habit | decision-scenario, multiple-choice, say-this, fill-the-gap |

**Unit `debates-and-discourse`: Debates and Discourse** (prereq: `craft-and-critique`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `db-01` | Who would win? Power scaling | Understand power-scaling debates as a game, not a fight. | power-scaling-debate, plot-armor | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `db-02` | The Big Three and their successors | Explain the 'Big Three' label, why it is contested, and what 'new big three' means. | big-three, new-big-three | multiple-choice, term-match, say-this, decision-scenario |
| `db-03` | Overrated, underrated, mid | Read hype cycles and disagree without dismissing. | hype-cycle, overrated-discourse | decision-scenario, multiple-choice, say-this, fill-the-gap |
| `db-04` | Fanservice and taste | Talk about fanservice as a taste debate at a non-explicit, survey level. | fanservice, taste-boundaries | decision-scenario, multiple-choice, say-this, fill-the-gap |
| `db-05` | Pay, AI and disagreeing well | Explain industry pay and generative-AI debates neutrally and practise kind disagreement. | industry-labour, generative-ai-debate, kind-disagreement | decision-scenario, multiple-choice, say-this, term-match |

**Unit `conventions-and-cosplay`: Conventions and Cosplay** (prereq: `fandom-vocabulary`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cc-01` | What a convention is | Describe what happens at an anime convention and name the big ones. | anime-convention, comiket | multiple-choice, term-match, hotspot-tap, say-this |
| `cc-02` | Cosplay basics and etiquette | Explain cosplay and its golden rule: a costume is not consent. | cosplay, cosplay-etiquette | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `cc-03` | Artist alley, doujin and fan art | Understand doujinshi, artist alley and fan-art norms. | doujinshi, artist-alley | multiple-choice, term-match, say-this, fill-the-gap |
| `cc-04` | Merch: figures, Nendoroids and blind boxes | Read merch culture: scale figures, blind boxes, gacha crossovers. | scale-figure, blind-box-gacha | multiple-choice, term-match, decision-scenario, estimate-slider |
| `cc-05` | Pilgrimage and going together | Explain seichi junrei and how to attend an event with someone. | seichi-junrei, attend-together | decision-scenario, multiple-choice, say-this, fill-the-gap |

**Unit `streaming-landscape`: The Streaming Landscape** (prereq: `seasons-and-simulcast`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sl-01` | Who streams what | Sort the main services by what they are known for (dated). | streaming-landscape, exclusive-vs-licensed | term-match, multiple-choice, decision-scenario, fill-the-gap |
| `sl-02` | Regions, windows and delays | Explain why a show is missing in your country or arrives late. | region-lock, simulcast-window | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `sl-03` | Legal watching and why it matters | Explain how legal viewing supports the people who make the show. | legal-streaming, creator-pay | decision-scenario, multiple-choice, say-this, fill-the-gap |
| `sl-04` | Trackers and watchlists | Explain anime trackers, lists and how to read someone's profile kindly. | anime-tracker, watchlist-etiquette | multiple-choice, term-match, say-this, fill-the-gap |
| `sl-05` | Physical media and collecting | Explain limited editions, box sets and why some fans still buy discs. | physical-media, limited-edition-bd | multiple-choice, decision-scenario, estimate-slider, fill-the-gap |

### Layer 4: Branches / personalization (4 units, 16 lessons)

**Unit `branch-shonen-battle`: Branch: Shonen and Long-Runners** (prereq: `genres-and-tropes`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bs-01` | Long-runner literacy | Explain what it means to be caught up on a hundreds-of-episodes series. | long-runner-literacy | multiple-choice, estimate-slider, say-this, fill-the-gap |
| `bs-02` | Arcs as chapters | Use arcs as the natural unit of conversation. | arc-structure | sequence-order, multiple-choice, say-this, fill-the-gap |
| `bs-03` | Rivals, mentors and found family | Recognise the relationship patterns fans love in shonen. | shonen-mentor-rival | multiple-choice, term-match, say-this, decision-scenario |
| `bs-04` | Tie-in films and events | Understand tie-in films and how they relate to canon. | tie-in-film | multiple-choice, decision-scenario, say-this, fill-the-gap |

**Unit `branch-seinen-prestige`: Branch: Seinen and Prestige** (prereq: `genres-and-tropes`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sp-01` | Moral grey and adult drama | Discuss morally grey adult drama at survey depth. | moral-grey-storytelling | decision-scenario, multiple-choice, say-this, fill-the-gap |
| `sp-02` | Mystery and thriller structure | Explain how mystery and thriller anime build tension. | mystery-structure | multiple-choice, sequence-order, say-this, fill-the-gap |
| `sp-03` | Sci-fi and cyberpunk canon | Place the classic sci-fi and cyberpunk works in context. | scifi-cyberpunk-canon | multiple-choice, term-match, say-this, decision-scenario |
| `sp-04` | Talking about heavy stories | Practise asking about a heavy story kindly. | heavy-story-conversation | decision-scenario, multiple-choice, say-this, talk-track |

**Unit `branch-slice-romance`: Branch: Slice of Life and Romance** (prereq: `genres-and-tropes`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sr-01` | Comfort shows | Explain comfort-watch culture and what people get from it. | comfort-watch | multiple-choice, say-this, fill-the-gap, decision-scenario |
| `sr-02` | Romance beats | Recognise the confession, misunderstanding and slow-burn beats. | romance-beats | multiple-choice, term-match, say-this, sequence-order |
| `sr-03` | Music, club and school life | Place school-life and music-club anime. | school-life-genre | multiple-choice, term-match, say-this, fill-the-gap |
| `sr-04` | Shojo and josei classics | Name landmark shojo and josei works as conversation starters. | shojo-josei-canon | multiple-choice, term-match, say-this, decision-scenario |

**Unit `branch-studio-film`: Branch: Studios and Films** (prereq: `studios-and-directors`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sf-01` | Ghibli-fan vocabulary | Speak the shared vocabulary of Ghibli fans. | ghibli-fan-vocab | multiple-choice, term-match, say-this, fill-the-gap |
| `sf-02` | Theatrical anime and the box office | Explain why anime films are event releases and how their success is discussed. | theatrical-anime | multiple-choice, estimate-slider, say-this, decision-scenario |
| `sf-03` | Auteur film language | Apply film-language terms to anime auteurs (cross-link movies). | auteur-film-language | visual-id, multiple-choice, say-this, fill-the-gap |
| `sf-04` | Festivals and the Oscars | Explain how anime films reach festivals and animated-feature awards. | festival-and-oscar-path | multiple-choice, decision-scenario, say-this, fill-the-gap |

### Layer 5: Current-season / live layer (1 units, 5 lessons)

**Unit `this-season`: This Season (live layer)** (prereq: `seasons-and-simulcast`, `streaming-landscape`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cx-01` | This season at a glance | Read this season's chart and name three things people are watching. | current-season-read | multiple-choice, decision-scenario, say-this, fill-the-gap |
| `cx-02` | Why is everyone talking about this? | Turn a trending show into a question you can ask. | buzz-explainer | say-this, decision-scenario, multiple-choice, talk-track |
| `cx-03` | Sequels and returns | Explain why a returning series matters to its fans. | returning-series | multiple-choice, say-this, fill-the-gap, decision-scenario |
| `cx-04` | Films, festivals and awards | Follow an anime film release or awards moment. | awards-literacy | multiple-choice, say-this, decision-scenario, fill-the-gap |
| `cx-05` | Industry news, explained | Understand a current industry story without the drama. | industry-news-literacy | multiple-choice, decision-scenario, say-this, fill-the-gap |

### Layer 6a: Conversation practice (1 units, 5 lessons)

**Unit `conversation-lab`: Conversation Lab** (prereq: `fandom-vocabulary`, `genres-and-tropes`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cl-01` | Texting about a favourite | Ask an open, curious question about a favourite series. | open-question | talk-track, say-this, multiple-choice, decision-scenario |
| `cl-02` | The sub or dub question | Handle the sub/dub question in chat. | dub-debate-etiquette | talk-track, say-this, multiple-choice, decision-scenario |
| `cl-03` | Season night | Join a weekly-episode conversation without spoilers. | spoiler-etiquette | talk-track, say-this, multiple-choice, decision-scenario |
| `cl-04` | At the convention | Chat with someone in cosplay respectfully. | cosplay-etiquette | talk-track, say-this, multiple-choice, decision-scenario |
| `cl-05` | When the adaptation disappoints | Support someone upset about an adaptation without arguing. | adaptation-faithfulness | talk-track, say-this, multiple-choice, decision-scenario |

### Layer 6b: Perpetual review (1 units, 2 lessons)

**Unit `spaced-review`: Spaced Review** (prereq: `what-anime-is`). 2 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rv-01` | Term blitz | Recall core terms fast on the Leitner schedule. | anime-as-medium, cour, op-ed | term-match, fill-the-gap, multiple-choice, say-this |
| `rv-02` | Decode the message | Interpret fan messages using mastered concepts. | demographic-marketing, filler, simulcast | say-this, multiple-choice, fill-the-gap, talk-track |

### Review policy

Leitner boxes at 1, 3, 7, 14, 30 days; max 12 review items per session; lapsed concepts return to box 1; concepts tagged `live` refresh on the seasonal cycle. Mastery pass threshold 0.8.

### Also

- **Concept count target (Playbook):** 225 concept ids across the map (see the unique total above); plus 76 Playbook terms in `exercises.md`.
- **Personalization slots:** `{{franchise}}`, `{{genre}}`, `{{platform}}`, `{{region}}`, `{{studio}}`.
- **Release plan.** Launch: all foundations, intermediate, enthusiast, four branches, conversation lab and review; `this-season` ships with the first live season and regenerates quarterly. Later: new season templates, more branch depth (mecha, idols, sports), film awards cycle updates, Wave 3 cross-links (K-pop).

---

## 12. Interaction plan

| Lesson / activity family | Concepts | Type | Justification | Tier | Est. count |
|---|---|---|---|---|---|
| Definitions, which-is-true checks (all units) | most | [`multiple-choice`](../../native-exercises/CATALOG.md) | Default knowledge check; distractors from the section 2 misconceptions. | B | ~260 |
| Canon vs filler, simulcast or not | canon, filler, simulcast | [`binary-call`](../../native-exercises/CATALOG.md) | Two-way call on text; no scene needed. | B | ~30 |
| Shelves, isekai types, studios | demographics, genres, studios | `term-match` | Recognition of a small set of terms. | B | ~45 |
| Production pipeline, seasons, eras | pipeline, calendar, eras | `sequence-order` | Order is the concept. | B | ~30 |
| Visual shorthand, sakuga | shojo visual language, sakuga | `visual-id` | Original illustrations; recognition is visual. | B | ~40 |
| Shared watch, piracy, cosplay, heavy stories | etiquette, ratings | `decision-scenario` | Judgment with consequences. | B | ~45 |
| Fan messages | all | `say-this` | The product's core skill. | B | ~90 |
| Talk tracks | conversation | `talk-track` | Conversation practice. | B | ~24 |
| Vocabulary in context | terms | `fill-the-gap` | Quick review. | B | ~55 |
| Honorifics, score moods | honorifics, bgm | `listening-id` | Original audio only; skippable; text twin. | B | ~14 |
| Magnitudes | cour length, twos | `estimate-slider` | Numbers. | B | ~14 |
| Manga page, season chart, credits | manga reading, season chart, credits | `hotspot-tap` | Static diagrams. | B | ~30 |
| `timing-tap` | none | not used | No 1D timing concept. | - | 0 |

**Unity verdict: zero Tier A sims.** Applying the CLAUDE.md rubric: does anything require the learner to *see things move over time in space*, *perspective*, or *physics*? The only candidate is the animation-technique family (on twos, smear frames, sakuga timing). A labelled static diagram with an original short loop teaches each clearly, and a "fake game" would teach it worse than a diagram; the concept is how to *watch*, not how to simulate. Manga reading order is a static page. Seasonal charts are lists. Nothing in fandom culture (etiquette, vocabulary, debate) is spatial. No sim specs are written; `sims/` is empty by design; `unitySimulations` is `[]`.

---

## 13. Licensing and safety

- **Imagery.** No stills, frame grabs, key art, posters, character art, mascot art or screenshots. Original Swoon'd illustrations only (`original-swoond`). Titles as text. Fan art is never used.
- **Audio.** No OP/ED, soundtracks, sound effects or voice clips from any show. Listening items use original recorded or synthesised audio.
- **Lyrics.** Never quoted or summarised at length.
- **Video.** No trailers or clips hosted; link-out to official channels only, no autoplay.
- **Article text.** Never copy publisher, synopsis or review text; explain in our words and link.
- **Data providers.**
  - **AniList API:** free for non-commercial use; apps under about $150 per month revenue may use it without permission; above that a commercial licence is required (contact AniList); no mass data collection, no use as storage or backup, and no use in competing tracker services. Checked 2026-09-30 **[verify at release]**: https://docs.anilist.co/guide/terms-of-use.
  - **MyAnimeList and Jikan:** the MAL API licence allows non-commercial apps and forbids scraping; Jikan is an *unofficial* scraper and breaches MAL's terms. Do **not** use Jikan in production (same principle as spec section 39 on unofficial APIs). A licence request to MAL is an open question.
  - **Kitsu:** Apache-2.0 API docs, but the data terms for commercial use are unclear; contact Kitsu before use.
  - **Wikidata (CC0) and Wikipedia (CC BY-SA)** allowed with attribution.
  - Swoon'd curates its own editorial season chart to stay independent of any single provider.
- **Logos and trademarks.** Studio, publisher, service and franchise logos are text-only mentions.
- **People.** Names of creators and voice actors appear as public professional facts only. No likeness, no fabricated quotes.
- **Piracy.** Never link to unlicensed sources; `fv-05` and `sl-03` teach why official releases matter without lecturing.
- **Safety and content.** Mature themes (war, loss, violence, suicide, abuse) appear only as topic names with a content-note line before lesson `cr-06`, `gt-08`, `sp-04`; non-graphic; skippable without loss. Fanservice appears only as a taste-debate topic, never described. Never push mature titles at a learner of unknown age. Discuss Kyoto Animation's history with care (`st-03`). No dramatisation of real events.

---

## 14. Content assets

| Asset | Source | License |
|---|---|---|
| Visual shorthand, sakuga, chibi, pipeline illustrations | Original Swoon'd vector art | `original-swoond` |
| Manga page, season chart card, credits roll diagrams | Procedural diagrams | `original-swoond` |
| Honorific pronunciation clips | Commissioned studio recordings | `original-swoond` |
| Score-mood cues | Original synthesised audio | `original-swoond` |

No photographs, stills or show imagery. Every image and audio asset has a licence id.

---

## 15. Section 47 quality checklist (must be all answered before release)

- [x] 1. **What does a beginner need to understand?** That anime is a medium, where stories come from, what a cour and a demographic mean, genre grammar, production, and fandom vocabulary (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Seasons, studios, adaptations, sakuga, sub/dub, debates, conventions (section 4).
- [x] 3. **What current information matters?** What is airing, where it streams, sequels, films, awards, industry news (section 6).
- [x] 4. **What should be interactive?** Sorting, ordering, decoding messages, etiquette scenarios, talk tracks (section 5).
- [x] 5. **What should NOT be gamified?** Taste, volume watched, mature content, piracy, rankings of people (section 5).
- [x] 6. **How should it personalize?** Franchise, genre, platform, region, studio (section 8).
- [x] 7. **What does conversational competence look like?** Section 9 and the useful competence statement (section 10).
- [x] 8. **What data providers are needed?** Curated season chart, availability API, Wikidata; AniList only under licence; no Jikan (section 13, `live-data.md`).
- [x] 9. **What licensing constraints apply?** Section 13.
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, say-this decoding, conversation scenarios (section 10).

Additional gates: [x] manifest validates (see report); [ ] curriculum validates (curriculum not yet authored); [x] every Unity sim has an approved spec (none exist); [ ] every image/audio asset has a licence id (assets not yet produced); [ ] voice review; [x] no copied publisher text.

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Is a commercial licence for AniList (or a MAL licence) wanted for titles/metadata, or do we stay on curated editorial data plus Wikidata? | Product owner | No, launch is editorial |
| 2 | News provider for the live layer (OPEN_QUESTIONS L-01). | Product owner | Live layer |
| 3 | Streaming availability provider (Watchmode, Movie of the Night, JustWatch) and commercial terms. | Product owner | Availability cards |
| 4 | Sensitive-topic review (mature themes, Kyoto Animation history) by a human reviewer. | Product owner | Before release |
| 5 | Re-verify the streaming landscape, fall 2026 lineup and studio facts at release. | Content | Release |
