# Course Design Specification: Movies (`movies`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/*.md`, `NOTES_FOR_ORCHESTRATOR.md` |

Time-sensitive facts (awards dates and winners, box office, studio ownership, festival results, provider terms) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Evergreen lessons never hard-code them; the live layer and `{{tokens}}` carry them (see `live-data.md`).

**Media licensing is the design constraint of this course (spec section 40, rule 10).** Swoon'd talks *about* films; it never redistributes them. No posters, key art, stills, frame grabs, trailers, clips, score audio, dialogue quotes beyond a short factual phrase, or publisher review text. Every teaching image is an original Swoon'd diagram or illustration of a *technique* (a shot size, a lighting set-up, a camera axis), and every teaching sound is original or synthesised. Titles, names and facts are used as facts. Details: section 13.

---

## 1. Identity

- **Course ID:** `movies` (immutable)
- **Display name:** Movies
- **Category / family:** Film & Television > Movies (family `Film & Television`)
- **Simulation prefix:** `film`
- **What "Movies" means here.** The person you care about might be a *casual moviegoer* (opinions, favourites, date-night picks), a *franchise devotee*, a *Letterboxd cinephile* who logs everything, a *classic-film buff*, or an *awards-season obsessive* with a ballot spreadsheet. The course teaches the shared language all of them use (how films are made and read, genres, directors, eras, world cinema, awards, how cinephiles talk) and then tilts by branch. It covers feature films of every kind, including animation and documentary as forms. Television is out of scope (see boundary table).
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Horror Films (`horror-films`, wave 3) | **Only partly.** Movies gives film language (camera, cut, sound, genre as promise) and one survey lesson on horror. But horror fandom has its own canon (Universal monsters to the slasher cycle to J-horror to folk horror), subgenre taxonomy (slasher, final girl, found footage, body horror, giallo), franchise sagas, practical-effects and gore culture, festival circuit (Fantastic Fest, Sitges), the "elevated horror" fight and its own vocabulary ("jump scare vs dread", "kill count"). A learner who finishes Movies would still nod blankly at "it's a proper giallo, the kills are the point". | **Independent** (adjacent, shares terms via cross-links) | **Horror is NOT a branch of `movies`; it stays an independent Wave 3 course, `horror-films`.** Movies teaches horror as one genre at survey depth (`gn-06`, 1 lesson + 3 say-this items, ends with a hand-off card). `genre` personalization lets a horror fan's examples skew to horror in film-language lessons. `horror-films` may assume Movies foundations (units `reading-the-frame`, `motion-cut-and-sound`) but must not require them. Decision recorded in `NOTES_FOR_ORCHESTRATOR.md` item 1. |
| Anime (`anime`, wave 3) | Knowing Hollywood-centred film language helps a bit with anime *films* (Miyazaki, Kon), but anime fandom is a medium culture: seasons, studios, manga sources, simulcasts, fan terms (isekai, shonen, sub vs dub), conventions. | **Independent** | `wc-03` mentions Japanese cinema and Ghibli as *film*; anime series culture is left to `anime`. Cross-link only. |
| Television (not in catalog) | Film language transfers (framing, editing, sound), but TV conversation is about seasons, showrunners, episode arcs, renewals, binge culture, prestige-drama discourse, streaming schedules; the live data (episode air dates, ratings) differs. | **Independent** (candidate course) | Requested as a candidate in `NOTES_FOR_ORCHESTRATOR.md` item 6. Movies never teaches TV; it may mention a title as a one-liner cross-reference only. |
| Music (`music`) | Film scores are music; leitmotif and needle drops overlap slightly. Knowing music does not make you competent about film. | Adjacent | One cross-link from `mc-07`/`mc-08`. No dependency. |
| Video Games (`video-games`) | Cinematic language overlaps (cameras, cutscenes); fandoms and vocabulary differ. | Adjacent | No dependency. |
| Books (`books`) | Adaptation is a shared topic ("the book was better"). | Adjacent | `sg-06` (adaptation) cross-links to `books`; no dependency. |
| Photography (`photography`) | Shot composition, focal length, depth of field, light overlap strongly with cinematography. Photographers get `reading-the-frame` faster; the reverse holds partially. | Adjacent | Cross-link concepts (`focal-length`, `depth-of-field`, `three-point-lighting`); never merge. |
| Sub-worlds of Movies: franchise fandom, arthouse/festival cinema, classic Hollywood/repertory, awards watching | Learning the shared film language makes you competent about each *world*, but each has its own canon and talk. | **Shares foundation** | Modelled as three branches (below); awards watching is a core enthusiast unit plus the live layer, not a branch. |

- **Branches** (the "what kind of movie person is she" lens; foundation is shared, branch units add depth; a learner may enable several):

| id | Name | What changes |
|---|---|---|
| `mainstream-franchise` (default) | Blockbusters and franchises | Universe watch orders, box-office literacy, superhero and sequel grammar, post-credits culture, tentpole economics, "is it cinema?" discourse. |
| `auteur-arthouse` | Auteurs and arthouse | Festival circuit, A24/Neon culture, slow cinema, "elevated genre", Criterion habits, how to watch a difficult film. |
| `classic-repertory` | Classic Hollywood and repertory | Star-system icons, screwball/noir/musical classics, TCM and repertory-cinema culture, how to enjoy black-and-white and older pacing. |

---

## 2. Beginner model

**What a complete beginner typically knows.** They have watched hundreds of films and can say "I loved it / it was boring". They know famous actors, the biggest franchises, the word "Oscar" and that some directors are famous (Spielberg, Tarantino, Nolan). They know genres informally (funny, scary, action). They have opinions but not vocabulary for *why*.

**Terminology that will initially confuse them.**
- Crew roles: cinematographer vs director of photography, producer vs executive producer, "editor" (film editing, not a copy editor), production designer vs art director, "gaffer", "best boy" (credits gags).
- Image words: mise-en-scène, shot/reverse shot, depth of field, anamorphic, "the scope ratio", "Dutch angle", "cutting on action".
- Sound: diegetic vs non-diegetic, score vs soundtrack, needle drop, Foley, ADR.
- Structure and business: three-act, MacGuffin, tentpole, opening weekend vs worldwide gross, "for your consideration", "precursors", "sweep".
- Cinephile talk: "slow burn", "elevated horror", "a Criterion", "four stars on Letterboxd", "canon", "auteur", "very Wes Anderson".

**Common misconceptions.**
1. "The director does everything." (Films are collaborative: cinematographer, editor, production designer, composer, writers.)
2. "The Oscars pick the *best* film." (They reflect a voting body's taste, campaigns and timing; nominations are voted by craft branches, winners by the whole Academy.)
3. "A high opening weekend means a good movie / a low one means a flop." (Budget, marketing, legs, worldwide totals and streaming windows matter.)
4. "Rotten Tomatoes score is the average rating." (It is the percentage of reviews that are positive; a 90% film can be a solid 7/10 everywhere.)
5. "Old / black-and-white / subtitled films are homework." (They are often paced differently, not harder; a good entry point matters.)
6. "Remake" = "reboot" = "sequel"; "prequel" and "spin-off" get muddled.
7. "The book was better" is always insight; adaptation is translation, not copying.
8. "CGI vs practical" is binary (most big films blend; the debate is about *seams*).
9. "A 4K screen = cinematic". (Aspect ratio, sound, and theatrical projection matter to enthusiasts.)
10. "Cinephiles only like obscure films." (Most love populist films too; snobbery is a stereotype and the learner should not perform it.)

**Concepts that unlock the rest (become foundation units).** (1) Film is a collaboration with named crafts. (2) Every shot is a choice: size, angle, lens, light, colour. (3) Editing creates meaning and continuity has rules (the 180-degree rule). (4) Sound is half the movie. (5) Genre is a promise with conventions. Once these land, directors, eras and awards become conversation, not trivia.

---

## 3. Foundational knowledge

Modules (become `foundationalModules[]` and foundation units):

| Module (unit id) | Contents |
|---|---|
| `how-movies-get-made` | Feature vs short, runtime norms, crew roles, five production stages, studios/mini-majors/indies/streamers, budget tiers, box-office literacy, release windows and festivals. |
| `reading-the-frame` | Shot sizes, camera angles, composition, focal length and depth of field, aspect ratio, lighting (three-point, low-key), colour, mise-en-scène. |
| `motion-cut-and-sound` | Camera movement (dolly, tracking, crane, handheld, Steadicam, the dolly zoom), cuts and continuity (180-degree rule, eyeline match), montage, long takes, sound (diegetic, score, needle drop, Foley), leitmotif. |
| `story-and-genre` | Three acts, character arc, devices (MacGuffin, twist, unreliable narrator), genre as promise, the big genre map, adaptation/sequel/remake/reboot, franchise and shared universe, spoiler etiquette. |

Intermediate and enthusiast content: genres up close (with horror survey), directors and auteurs, eras of cinema, world cinema, awards season, cinephile talk, format debates. Reference facts are stated in evergreen form (ratios, rules, definitions); named-title examples are chosen from long-settled canon and dated where they depend on the season.

---

## 4. Enthusiast model

**What enthusiasts actually talk about.**
- What they watched last night, how they rated it (Letterboxd stars), and what they logged in the diary.
- Directors as brands ("new Villeneuve", "PTA", "Ari Aster's whole deal"), and how a film *fits* a filmography.
- Craft: the cinematography, the score, the editing, the sound design ("did you hear that mix?"), the production design.
- Format and viewing conditions: IMAX 70mm, 35mm print, Dolby, "seen it in theatres", the theatre's sound.
- Rankings and lists: "top four directors", "best year for movies" (1999, 1994, 1939, 2007), "favourite of the decade".
- Awards season: predictions, snubs, upsets, who is "overdue", the precursor path.
- Industry news: mergers, streaming windows, box-office weekends, release-date shuffles, strikes, AI.
- Recommendations: "you have to see X", "start with Y", "skip the sequel".

**Distinctions that matter to them.**
- Critic score vs audience score vs *my* score. Tomatometer (percent positive) vs Metascore (weighted average) vs CinemaScore (opening-night audience grade) vs Letterboxd average.
- Theatrical cut vs director's cut vs extended edition; film vs digital capture; scope vs flat; 35mm vs 70mm vs IMAX.
- Sequel vs remake vs reboot vs legacy sequel ("legacyquel").
- "Slow" vs "boring"; "elevated" (a genre film treated as art, a contested label) vs genre film.
- Genre vs tone vs mode (animation and documentary are not genres).
- Original vs IP; auteur vs studio film; "made by committee".

**Knowledge that signals genuine understanding.** Being able to say *why* a scene works ("the long take keeps you in the room"), naming a director's habits, knowing where a film sits in film history, knowing what "screen direction" or "cutting on action" means, and asking what someone saw *in* a film rather than repeating a rating.

**Beginner statements that sound obviously uninformed.**
- "The Oscars are basically the best movies of the year."
- "It got 92% so it's a 9.2/10."
- "I don't watch anything with subtitles / black and white."
- "The director shot the whole thing." / "The director wrote the music."
- "Who was the cameraman?" (Cinematographer/DP is the term.)
- "The score is the songs in the movie." (Score is the composed underscore.)
- "It's a remake of the sequel" nonsense; "reboot" for any sequel.
- "That's just Marvel" as a synonym for all big movies; or "Marvel isn't cinema" repeated without any view of the argument.
- Confident spoilers, or asking "so what happens at the end?" of a film she loves.

**Common controversies and debates.** Is Marvel/superhero output "cinema" (Scorsese, 2019, and the reaction)? Streaming vs theatrical windows; the Oscars' Best Picture expansion and preferential ballot; "Oscar bait" and snubs; film vs digital; practical effects vs CGI; sequel/remake fatigue vs originality; runtime creep; can you hear the dialogue (sound mix); is a genre film ever "elevated"; whether AI belongs in film (2023 strikes and later Academy rules); auteur theory vs collaboration; colourisation and "improved" restorations; spoilers and trailers that give away too much; "best film of all time" polls (Sight and Sound 2022 put *Jeanne Dielman* first; the 2012 winner was *Vertigo*) and what they say about canon-making.

---

## 5. Interaction model

**What the learner should experience instead of reading.**
- *See how images are built*, not read about them: identifying shot sizes, angles, lighting and aspect ratios on original diagrams (`visual-id`, `hotspot-tap`); sorting the **production process** and **awards calendar** (`sequence-order`).
- *Feel camera perspective*: the difference between moving the camera and zooming the lens, and what a dolly zoom does, and why crossing the axis line makes a conversation feel wrong. This is the one place a moving 3D scene teaches materially better than a still (Tier A, two sims).
- *Hear film sound* with **original** cues: diegetic vs non-diegetic, score vs needle drop, leitmotif, silence (`listening-id`, original or synthesised only).
- *Decide*: what to say after the credits roll, which film to pick for a date night, how to disagree kindly (`decision-scenario`, `talk-track`).
- *Decode*: what she means by "it's a slow burn", "very A24", "peak Nolan", "the snub is criminal" (`say-this`).

**Unity?** Yes, but sparingly: two sims (`film.camera.axis-line.v1`, `film.camera.lens-and-move.v1`) where **camera perspective and movement in space** are the concept and any static image would either be a licensed still (forbidden) or a poor substitute. Everything else is native. The rest of the course legitimately needs no engine: recall, recognition, order, estimation and conversation.

**Visual identification without stills.** Because we cannot show frames from films, `visual-id` uses **original illustrated technique cards** ("which shot size is this figure?", "which lighting set-up made this face?", "is this a 1.33 or a 2.39 frame?"). This is a deliberate strength: learners learn to see technique across all films rather than memorising a screenshot.

**What should NOT be gamified.**
- Taste. No leaderboards of "best films", no scoring a learner's opinion, no penalties for liking things.
- Sensitive history (representation, racist films of the silent and studio eras such as *The Birth of a Nation*'s legacy): taught in plain factual text with context, never as points or streak fodder.
- Awards as gambling: no predictions with stakes, no odds display beyond linking to public forecasts; a "make your ballot" tool is a private notebook, never a wager.
- Real people's health or private lives; trivia about actors' personal scandals. Public professional record only.
- Piracy: never suggest illegal sources; where to watch is via legitimate availability data only.

Details of the chosen mix are in section 12.

---

## 6. Dynamic information requirements

Movies is a **moderate** live-data subject: no scores or live play-by-play, but a steady weekly rhythm (new releases, box office, awards season, festivals, streaming arrivals). Structured data (release dates, cast/crew facts, ratings snapshots, awards calendar) and editorial data (why is this film being talked about) are separate systems. Full plan in `live-data.md`.

| Kind | Needed? | Why | Provider candidates (behind adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules` | Yes | Release calendar ("what opens Friday"), festival and awards calendar | Curated Swoon'd editorial calendar seeded from public studio/festival announcements; TMDB (only under a commercial agreement); Wikidata for structured dates | weekly | Last published calendar, dated |
| `releases` | Yes | New wide releases and streaming premieres; the "what are people going to talk about this weekend" card | Editorial curation + licensed provider (candidates below); link-out to official trailers pages only | weekly | Evergreen "how to pick a movie" card |
| `rankings` | Light | Weekend box office top 10, awards-race odds *as a link*, "best of year" lists as link-outs | The Numbers / Box Office Mojo-class data need a licence (no public API); Comscore (enterprise); curated top-line facts with attribution | weekly (Mon) | Static "how to read a box-office chart" |
| `events` | Yes | Awards season: nominations, ceremonies, winners; festivals (Cannes, Venice, TIFF, Sundance) and their prizes | Official award bodies' announcements (curated), Wikidata (CC0), Wikipedia (CC BY-SA, with attribution) | daily in awards weeks, weekly otherwise | Last season's winners as evergreen history |
| `new-media` | Yes | Streaming availability ("where can I watch this") and a small "new to streaming" list | Watchmode (commercial plans), Streaming Availability API (Movie of the Night), JustWatch partner API, TMDB watch providers only with a commercial licence and JustWatch attribution | daily | Hide availability; keep the lesson |
| `news` | Yes (editorial) | Why a merger, strike, snub or box-office result matters | Link-only headlines from publisher RSS where the licence allows; Swoon'd writes the explainer (L-01) | daily | Evergreen explainers |
| `statistics` | No (except box-office top lines) | Do not invent stats dashboards | - | - | - |
| `standings`, `rosters`, `injuries`, `weather`, `closures`, `alerts`, `regulations`, `transactions`, `new-products` | **No** | Not meaningful for movies (spec section 10: no artificial live data). Academy rule changes are editorial `events`, not `regulations`. | - | - | - |

Provider terms checked 2026-09-30 (summary; full table in `live-data.md`): **TMDB** API is free only for non-commercial use with mandatory attribution; commercial use needs a written agreement; caching beyond 6 months prohibited; AI/ML use prohibited; watch-provider data must credit JustWatch. **OMDb** is CC BY-NC (no commercial use). **IMDb** datasets are non-commercial only. **Letterboxd** API is by request and currently not granted for recommendation, LLM or personal projects. Therefore the launch plan uses **no automated third-party film-metadata dependency**: the evergreen course carries facts in Swoon'd's own content, and the live layer starts with **curated editorial + Wikidata (CC0)**, adding a licensed metadata/availability provider only after a commercial agreement (L-13, L-14).

---

## 7. Editorial context

- **What commentary helps.** Explaining the current conversation: why a director's new film is being talked about, what a box-office number means, why an awards frontrunner is in or out of favour, what a studio merger changes for theatres, why a trailer or casting choice provoked debate, how a festival premiere becomes an Oscar narrative.
- **Sources.** Trade press and critics as *link-outs* (Variety, The Hollywood Reporter, Deadline, IndieWire, Screen Daily, Sight and Sound, Letterboxd's own editorial, official Academy/festival/BFI pages). Awards bodies' official announcements as factual sources.
- **Licensing.** Publisher text, review text, critic pull quotes, Tomatometer blurbs and Metacritic excerpts are copyrighted: never copied or quoted beyond a title and link. Review *scores* are facts but their compilation is the provider's database; link out rather than mirror. Poster/key art and stills are rights-holders' works: never displayed.
- **Approach: explain in our own words, and link.** Manifest `editorial.approach = explain-and-link`.
- **Example prompts.** "Why are people saying this was the snub of the year?" "Why does everyone care about the theatrical window?" "What does 'Oscar frontrunner' actually mean this week?" "Why did that film open big and then vanish?" "What did the festival crowd love and why does it matter in January?"
- **Editorial cadence.** A weekly Swoon'd editor writes 3-5 "Why is everyone talking about this?" cards; on awards days extra cards; each card cites two link-outs and has a generated-or-authored "say this" line.

---

## 8. Personalization

| Dimension | How it changes examples and live context | Default when unset | Units using `{{tokens}}` |
|---|---|---|---|
| `director` | Adjective-test lessons, style examples and "start here" suggestions lead with her director; live layer flags new releases and interviews by them (link-out) | Curated rotation: a Hitchcock/Spielberg/Tarantino/Nolan/Wes Anderson set | `directors-and-auteurs`, `conversation-lab`, `now-in-cinemas` |
| `genre` | Genre examples skew (horror, sci-fi, rom-com, western...); **horror selects the hand-off card to `horror-films`** | "drama" for prose examples; genre-neutral for exercises | `story-and-genre`, `genres-up-close`, `now-in-cinemas` |
| `franchise` | Franchise units and live cards emphasise her universe (Marvel, Star Wars, Fast, Harry Potter, Dune, John Wick, Pixar...) | none; `branch-franchise` uses a neutral "the big universes" set | `branch-franchise`, `now-in-cinemas`, `conversation-lab` |
| `platform` | "Where to watch" cards and streaming-era lessons (Netflix, Max/HBO, Disney+, Prime Video, Apple TV+, Criterion Channel, Mubi, Tubi, theatres) | "in theatres or on a streaming service" | `now-in-cinemas`, `how-movies-get-made` (`mk-07`) |
| `region` | Local repertory/arthouse theatres (curated, not scraped), regional cinema focus (Korean, Indian, Nigerian...), and dubbing/subtitle norms | US | `world-cinema`, `now-in-cinemas` |

Personalization is optional; the foundation is unchanged. All token use falls back to the defaults. The `skill-level` dimension is not used; `branch` handles depth.

---

## 9. Conversation model

**What she might naturally say (with translation).**

| # | She says | Means | Implied terms | Good follow-up (genuine) |
|---|---|---|---|---|
| 1 | "The cinematography was unreal, I could screenshot every frame." | The way it was photographed (light, framing, colour) was striking. | cinematographer, composition, colour grading | "Was it the light or the framing that got you?" |
| 2 | "It's a slow burn, but the payoff is worth it." | Deliberate pace with tension building; not much happens early. | pacing, slow burn, payoff | "What made you stay with the slow part?" |
| 3 | "Very Wes Anderson." | Symmetry, pastel palettes, deadpan staging, dollhouse sets. | signature style, mise-en-scène | "Is it his best or just the most himself?" |
| 4 | "I saw it on 70mm and it ruined every other screen for me." | Projected on 70mm film (or IMAX 70mm), so sharper, larger, warmer. | film vs digital, IMAX, aspect ratio | "What was the biggest difference you noticed?" |
| 5 | "It got snubbed for Best Director, criminal." | The Academy did not nominate the director; she believes it should have. | nominations, branches, snub | "Who got in instead that annoyed you?" |
| 6 | "Rotten Tomatoes says 78% but audiences hated it." | 78% of critics gave a positive review; audience scores diverged (CinemaScore/Popcornmeter). | Tomatometer, audience score | "Which side do you land on?" |
| 7 | "The sound mix was so bad I turned on subtitles." | Dialogue was hard to hear against music/effects. | sound mix, ADR, dynamic range | "Was that at home or in the theatre?" |
| 8 | "Honestly the third act fell apart." | Structure weakened near the end (resolution, pacing, logic). | three-act structure | "What would you have done with the ending?" |
| 9 | "They cut it on action so smoothly you never notice." | Edits hidden inside a movement so they feel invisible. | continuity editing, cutting on action | "Did it feel like one take?" |
| 10 | "It's a legacy sequel, so it's a lot of fan service." | A late sequel aimed at old fans, full of callbacks. | legacy sequel, fan service | "Did you need the original to enjoy it?" |
| 11 | "Is Criterion having a sale? I need the 4K." | A high-end home-video label known for restored classics is discounting. | Criterion Collection, restoration | "What's the next one on your wall?" |
| 12 | "I'm doing a director run: every Kurosawa, in order." | A chronological personal marathon of one director's films. | filmography, auteur | "Which one made you want to keep going?" |
| 13 | "That one's a hidden gem, nobody saw it in theatres." | Good film that underperformed or was overlooked. | opening weekend, cult classic | "What should I watch first from that filmmaker?" |
| 14 | "Best Picture is a preferential ballot, so it's the consensus pick not the favourite." | The winner is ranked-choice; broadly liked films beat divisive ones. | preferential ballot | "So a film everyone ranks second can win?" |
| 15 | "Rewatched it for the fifth time, the long take in the opening still gets me." | An uninterrupted, unedited shot that builds immersion. | long take | "Is it one shot or hidden cuts?" |
| 16 | "It opened huge but had no legs." | Big first weekend, steep drop after word of mouth. | opening weekend, legs | "Do you think the trailers oversold it?" |
| 17 | "I prefer the director's cut." | A version closer to the director's preference than the release version. | director's cut, theatrical cut | "What does the longer cut add?" |
| 18 | "It's not a horror film, it's elevated." | A contested label for dread-driven, prestige-coded horror. | elevated horror, genre | "Do you like the label or does it bug you?" |

These are the seeds for ~90 `say-this` items; `exercises.md` writes 10+ in full.

**How Swoon'd helps without encouraging fake expertise.** Every `say-this` and `talk-track` rewards *curiosity and honest gaps* ("I haven't seen that one, what should I know going in?") over bluffing. Lines to say are follow-up questions and personal reactions, never opinions about films the learner has not seen. The coach note repeatedly models: "You don't need a take; you need a question." The Playbook avoids "canon checklist" pressure. Spoiler etiquette is a taught skill (`sg-08`).

**Targets.** 24 talk tracks at launch (10+ in `talk-tracks` bank across units plus the Conversation Lab), ~90 `say-this` items, 12 conversation lessons.

---

## 10. Assessment

- **How useful competence is determined.** Concept mastery (0-1 per concept; pass 0.8) from exercise outcomes and sim `masterySignals`, spaced review resurfacing, talk-track Smooth >= 60 at the end of each unit conversation lesson, and a **Say-It check** at unit ends (a `say-this` the learner must decode without hints).
- **Recognize.** Shot sizes and angles, lighting styles, aspect ratios, crew roles, genre conventions, eras and their signature shifts, awards and festival names, major directors' habits, common critical vocabulary.
- **Understand.** Why a cut is invisible; what the 180-degree rule protects; why the dolly zoom feels uneasy; how the Oscars' two voting systems differ; why box office is misread; what "auteur" means; what the streaming era changed.
- **Explain.** In one sentence, what makes something "cinematic"; why a film's ending "doesn't work"; why she loves her favourite director.
- **Correctly interpret.** A cinephile's line ("It's a slow burn, elevated, very A24") into plain meaning and a good follow-up.
- **Mastery model.** `concept-mastery-v1`, `passThreshold` 0.8.
- **Useful competence statement:** *"I can follow and join a conversation about movies: I understand what people mean when they talk about how a film looks, sounds, is cut and is made, place a film and its director in a genre and era, understand how awards season and box office work, and ask honest, interested follow-up questions without pretending to have seen everything."*

---

## 11. Curriculum map (ongoing course)

Course version target at launch: `curriculumVersion 0.1.0`. **17 units, 117 lessons, ~340 concepts** across all six layers. (Unit count exceeds the 8-14 guidance for the same reason as football/soccer: three branch units and a live unit; a learner sees about 15 (matching branches only). Approval requested: NOTES item 3.)

Activity legend: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap (unused), `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap, SIM = Unity.

Every lesson ends with a "line you could say out loud" and 1-2 Playbook additions. Every unit's final lesson is a mixed-review capstone that includes one `tk` or `st` beat.

### Layer 1: Foundations (4 units, 31 lessons)

**Unit `how-movies-get-made`: How a Movie Gets Made** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `mk-01` | What counts as "a movie" | Tell a feature from a short and know typical runtimes. | feature-film, short-film, runtime-norms | mc, es |
| `mk-02` | Who does what | Match the eight big crew roles to what they actually do. | film-crew-roles, director-role, producer-role, cinematographer-role, editor-role | tm, mc |
| `mk-03` | The five stages | Order development to release. | production-stages, pre-production, post-production | so, fg |
| `mk-04` | Studios, indies and streamers | Sort major studios, indies and streamers and what each is known for. | major-studio, indie-film, streamer-original | tm, mc |
| `mk-05` | Budget in plain English | Place a film in a budget tier and know why it matters. | budget-tiers, tentpole | es, mc |
| `mk-06` | Box office decoded | Read opening weekend, worldwide gross and legs without being fooled. | opening-weekend, worldwide-gross, box-office-legs | mc, bc |
| `mk-07` | Windows and festivals | Explain theatrical window, streaming and festival premieres; capstone. | release-window, film-festival-premiere, pvod | so, st, tk |

**Unit `reading-the-frame`: Reading the Frame** (prereq: `how-movies-get-made`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fr-01` | Shot sizes | Name wide, medium, close-up and extreme close-up. | shot-sizes, establishing-shot, close-up | vi, mc |
| `fr-02` | Camera angles | Name eye-level, low, high, Dutch, over-the-shoulder, POV and what each suggests. | camera-angles, low-angle, high-angle, dutch-angle, pov-shot | vi, tm |
| `fr-03` | Composition | Spot rule of thirds, leading lines, symmetry and depth. | rule-of-thirds, leading-lines, symmetry-composition, frame-within-frame | ht, mc |
| `fr-04` | Lenses and focus | Say what a wide vs long lens does to space and what shallow focus does. | focal-length, depth-of-field, deep-focus, perspective-compression | SIM `film.camera.lens-and-move.v1`, mc |
| `fr-05` | The shape of the frame | Tell 1.33, 1.85 and 2.39 apart and why filmmakers choose. | aspect-ratio, widescreen-anamorphic, imax-ratio | vi, es |
| `fr-06` | Light | Recognise three-point, high-key and low-key lighting. | three-point-lighting, high-key-lighting, low-key-lighting, chiaroscuro, magic-hour | vi, mc |
| `fr-07` | Colour | Explain grading, palettes and colour motifs. | color-grading, color-palette-motif, desaturation | mc, st |
| `fr-08` | Everything in frame is a choice | Read costume, set and blocking as storytelling; capstone. | mise-en-scene, production-design, blocking, costume-design | ds, st |

**Unit `motion-cut-and-sound`: Movement, Cuts and Sound** (prereq: `reading-the-frame`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `mc-01` | Moving the camera | Name pan, tilt, dolly, tracking, crane, handheld, Steadicam. | camera-movement, pan-tilt, dolly-shot, tracking-shot, crane-shot, handheld-camera, steadicam | SIM `film.camera.lens-and-move.v1`, tm |
| `mc-02` | The dolly zoom | Explain the Vertigo effect and why it feels uneasy. | dolly-zoom, dolly-vs-zoom | SIM `film.camera.lens-and-move.v1`, bc |
| `mc-03` | What a cut does | Name cut, dissolve, fade, wipe and shot/reverse shot. | cut-types, shot-reverse-shot, transition-types | mc, tm |
| `mc-04` | The 180-degree rule | Keep two people on the right sides of the screen across cuts. | 180-degree-rule, screen-direction, eyeline-match, continuity-editing | SIM `film.camera.axis-line.v1`, bc |
| `mc-05` | Editing as meaning | Tell montage, match cut, jump cut, cross-cutting and cutting on action apart. | montage, match-cut, jump-cut, cross-cutting, cutting-on-action, kuleshov-effect | tm, mc |
| `mc-06` | The long take and the pulse of a film | Explain the long take and average shot length. | long-take, average-shot-length | es, st |
| `mc-07` | What you hear | Sort diegetic from non-diegetic and score from soundtrack. | diegetic-sound, score-vs-soundtrack, needle-drop, sound-design, foley, adr | li, mc |
| `mc-08` | Themes, silence and the mix | Explain leitmotif, silence and why dialogue can be hard to hear; capstone. | leitmotif, sound-mix, silence-as-sound | li, st, tk |

**Unit `story-and-genre`: Story, Structure and Genre** (prereq: `how-movies-get-made`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sg-01` | Three acts and a few beats | Point to setup, confrontation, resolution and the inciting incident. | three-act-structure, inciting-incident, set-piece, climax | so, mc |
| `sg-02` | Who wants what | Name protagonist, antagonist and character arc. | protagonist-antagonist, character-arc, stakes | mc, st |
| `sg-03` | Storytelling devices | Use MacGuffin, red herring, Chekhov's gun, twist, flashback correctly. | macguffin, red-herring, chekhovs-gun, plot-twist, flashback, unreliable-narrator, in-medias-res | tm, fg |
| `sg-04` | Genre is a promise | Say what a genre promises and how tone differs. | genre-conventions, genre-vs-tone, iconography | mc, st |
| `sg-05` | The genre map | Place drama, comedy, action, thriller, sci-fi, romance, crime, western, war, musical, animation, documentary. | genre-map, action-film, drama-film, romance-film | tm, mc |
| `sg-06` | Adapted, sequelled, remade | Tell adaptation, sequel, prequel, remake, reboot, spin-off apart. | adaptation, sequel-remake-reboot, prequel-spinoff, legacy-sequel | tm, fg |
| `sg-07` | Franchises and universes | Explain franchise, shared universe and post-credits scenes. | franchise, shared-universe, post-credits-scene, ip-driven-film | mc, bc |
| `sg-08` | Talking after the credits | Practise spoiler etiquette and good first questions; capstone. | spoiler-etiquette, post-movie-questions | ds, tk |

### Layer 2: Intermediate (4 units, 30 lessons)

**Unit `genres-up-close`: Genres Up Close** (prereq: `story-and-genre`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `gn-01` | Thriller, mystery, suspense | Explain suspense vs surprise (the bomb under the table). | suspense-vs-surprise, thriller-genre, whodunit | mc, bc |
| `gn-02` | Noir and crime | Recognise film noir, neo-noir and the heist film. | film-noir, neo-noir, heist-film, gangster-film | vi, tm |
| `gn-03` | Science fiction | Tell hard from soft sci-fi and dystopia from space opera. | hard-sci-fi, soft-sci-fi, dystopian-film, space-opera, cyberpunk | tm, mc |
| `gn-04` | Comedy in its many forms | Sort screwball, rom-com, satire, parody, mockumentary, dark comedy. | screwball-comedy, rom-com, satire-film, parody, mockumentary | tm, st |
| `gn-05` | Westerns, war films and musicals | Explain the western, the revisionist western, the war film and the musical. | western-genre, revisionist-western, war-film, musical-genre | mc, so |
| `gn-06` | Horror in one lesson | Sort slasher, supernatural, psychological, body horror, folk horror, found footage and the "elevated" debate; get a hand-off to `horror-films`. | horror-survey, slasher, elevated-horror, jump-scare-vs-dread | tm, st |
| `gn-07` | Animation and documentary are not genres | Say why animation is a medium and documentary a mode. | animation-medium, stop-motion, documentary-mode, hybrid-genres | mc, st, tk |

**Unit `directors-and-auteurs`: Directors and Auteurs** (prereq: `story-and-genre`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `dr-01` | What "auteur" means | Explain auteur theory and its critics. | auteur-theory, signature-style, cahiers-du-cinema | mc, st |
| `dr-02` | The adjective test | Use "very Wes Anderson" style adjectives correctly for 6 directors. | director-style-adjectives, wes-anderson-style, tarantino-style, nolan-style, hitchcock-style, kubrick-style | tm, st |
| `dr-03` | New Hollywood and the blockbuster makers | Place Spielberg, Scorsese, Coppola, Lucas in their moment. | spielberg-career, scorsese-career, coppola-career, movie-brat-generation | mc, so |
| `dr-04` | Filmmakers people talk about now | Name what is distinctive about six contemporary directors. | villeneuve-style, gerwig-style, peele-style, coogler-style, pta-style, fincher-style | tm, st |
| `dr-05` | Directors from around the world | Match Kurosawa, Bergman, Ozu, Miyazaki, Bong, Wong Kar-wai, Almodovar to one idea each. | kurosawa-legacy, bergman-legacy, ozu-legacy, miyazaki-legacy, bong-joon-ho-style, wong-kar-wai-style | tm, mc |
| `dr-06` | Women directors and who won when | Know Bigelow, Zhao, Campion, Coppola, Akerman and where they sit in awards history. | women-directors-history, oscar-best-director-women, akerman-jeanne-dielman | mc, so |
| `dr-07` | Stars, actors and how acting is discussed | Distinguish movie star, character actor, ensemble, method. | movie-star-vs-actor, method-acting, ensemble-cast, casting-director | mc, tm |
| `dr-08` | Creative partnerships | Name director-collaborator pairs (Spielberg-Williams, Scorsese-Schoonmaker, Villeneuve-Deakins, Burton-Elfman); capstone. | creative-partnerships, cinematographer-collaborations, composer-collaborations | tm, tk |

**Unit `eras-of-cinema`: Eras of Cinema** (prereq: `story-and-genre`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `er-01` | The silent era | Say what silent film was and name Lumiere, Melies, Chaplin, Keaton and German Expressionism. | silent-era, german-expressionism, slapstick, early-cinema | mc, so |
| `er-02` | The studio system and the Hays Code | Explain vertical integration, contract players and the Production Code. | studio-system, hays-code, contract-player, paramount-decree | mc, tm |
| `er-03` | After the war | Explain television's threat, widescreen and Italian neorealism. | post-war-cinema, widescreen-race, italian-neorealism | mc, so |
| `er-04` | New Hollywood | Explain why 1967-1980 changed American film. | new-hollywood, director-driven-cinema, ratings-system | mc, st |
| `er-05` | The blockbuster is born | Explain Jaws, Star Wars and the summer tentpole. | summer-blockbuster, high-concept, merchandising-era | mc, so |
| `er-06` | VHS, indies and the 90s | Explain home video, the indie boom, Sundance and Miramax. | home-video-era, indie-boom, sundance-festival | mc, tm |
| `er-07` | The digital revolution | Explain CGI, digital cinematography and the franchise-era turn. | cgi-era, digital-cinematography, cinematic-universe-era | mc, tm |
| `er-08` | Streaming and after | Explain streaming's arrival, the pandemic shift, 2023 strikes and windows; capstone. | streaming-era, pandemic-release-shift, hollywood-strikes-2023, theatrical-window-debate | mc, st, tk |

**Unit `world-cinema`: World Cinema** (prereq: `story-and-genre`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `wc-01` | Subtitles, dubbing and the one-inch barrier | Explain why subtitles are fine and what the "one-inch barrier" quip meant. | subtitles-vs-dubbing, one-inch-barrier, international-feature-oscar | mc, st |
| `wc-02` | France and Italy | Explain the French New Wave and Italian neorealism. | french-new-wave, italian-neorealism-legacy, cinema-verite | tm, mc |
| `wc-03` | Japan | Explain jidaigeki, Ozu's stillness, Ghibli and Godzilla as film. | jidaigeki, japanese-golden-age, studio-ghibli, kaiju-film | tm, mc |
| `wc-04` | South Korea | Explain the Korean wave in film (Bong, Park). | korean-cinema-wave, social-thriller | mc, st |
| `wc-05` | India | Explain Bollywood, regional industries and Ray. | bollywood, regional-indian-cinema, satyajit-ray, masala-film | tm, mc |
| `wc-06` | More of the map | Place Hong Kong action, Mexican cinema's "Three Amigos", Nollywood, Iranian cinema. | hong-kong-cinema, three-amigos-mexico, nollywood, iranian-new-wave | tm, mc |
| `wc-07` | How to start | Pick a first foreign film and talk about it; capstone. | foreign-film-entry-points, world-cinema-conversation | ds, tk |

### Layer 3: Enthusiast depth (3 units, 22 lessons)

**Unit `awards-season`: Awards Season** (prereq: `story-and-genre`; `eras-of-cinema` helpful). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `aw-01` | The calendar | Order festivals, precursors, nominations, ceremony. | awards-season-calendar, fall-festival-circuit | so, mc |
| `aw-02` | Who votes | Explain the Academy, branches, and nominations vs winners. | academy-membership, branch-nominations, oscar-voting | mc, bc |
| `aw-03` | The preferential ballot | Explain ranked-choice Best Picture and why "consensus" wins. | preferential-ballot, best-picture-expansion | mc, es |
| `aw-04` | The categories decoded | Sort acting, craft, writing, international, animated, documentary, shorts, casting. | oscar-categories, craft-categories, casting-category | tm, mc |
| `aw-05` | Precursors | Explain what Globes, Critics Choice, guilds and BAFTA predict. | precursor-awards, guild-awards, actor-awards-sag | tm, mc |
| `aw-06` | Festival prizes | Tell Palme d'Or, Golden Lion, Golden Bear, People's Choice apart. | cannes-palme-dor, venice-golden-lion, berlin-golden-bear, tiff-peoples-choice | tm, mc |
| `aw-07` | Campaigns, bait and snubs | Explain FYC, "Oscar bait", "overdue" narratives, upsets and snubs. | for-your-consideration, oscar-bait, snub, due-narrative | mc, st |
| `aw-08` | Talking Oscar pools | Talk predictions honestly (frontrunner, split, upset); capstone. | frontrunner, picture-director-split, oscar-pool-talk | st, tk |

**Unit `cinephile-talk`: How Cinephiles Talk** (prereq: `reading-the-frame`, `story-and-genre`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ct-01` | Four kinds of score | Tell Tomatometer, Metacritic, CinemaScore and Letterboxd apart. | tomatometer, metacritic, cinemascore, letterboxd-average | tm, mc |
| `ct-02` | Letterboxd literacy | Read a diary, half-stars, lists and "watchlist". | letterboxd, diary-log, star-rating-culture, watchlist | mc, st |
| `ct-03` | The canon and its lists | Say what AFI, Sight and Sound, Criterion, IMDb Top 250 are and aren't. | film-canon, sight-and-sound-poll, afi-lists, criterion-collection, imdb-top-250 | tm, mc |
| `ct-04` | Review vocabulary | Decode slow burn, vibes, "lived-in", "operatic", "messy". | slow-burn, review-vocabulary, lived-in-world | st, mc |
| `ct-05` | Cult, hidden gem, overrated | Use cult classic, hidden gem, guilty pleasure, so-bad-its-good. | cult-classic, hidden-gem, guilty-pleasure, so-bad-its-good | tm, st |
| `ct-06` | History nerd talk | Explain restoration, director's cut, Film Foundation, home-video labels. | film-restoration, directors-cut, home-video-labels | mc, fg |
| `ct-07` | Having an opinion honestly | Give specific praise and admit gaps. | specific-praise, honest-gaps | ds, st |
| `ct-08` | Recommendation etiquette | Recommend without gatekeeping; capstone. | recommendation-etiquette, first-film-picks | ds, tk |

**Unit `formats-and-debates`: Formats and Debates** (prereq: `motion-cut-and-sound`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fd-01` | Film, digital, 70mm, IMAX | Explain what each is and why fans care. | film-vs-digital, 70mm-film, imax-format, dolby-cinema | mc, tm |
| `fd-02` | Practical vs CGI | Explain the real debate is about seams. | practical-effects, cgi-vs-practical, virtual-production | mc, bc |
| `fd-03` | The theatre vs the couch | Explain the theatrical experience and windows. | theatrical-experience, theatrical-window, premium-formats | ds, mc |
| `fd-04` | Versions and runtime | Explain theatrical cut, director's cut, extended cut, runtime creep. | theatrical-vs-directors-cut, extended-edition, runtime-creep | mc, es |
| `fd-05` | Sequel fatigue and originality | Explain the originality debate and "is it cinema". | sequel-fatigue, originality-debate, cinema-definition-debate | st, tk |
| `fd-06` | AI and the industry | Explain what the 2023 strikes and the Academy rules say about AI, in plain, dated terms. | ai-in-film-debate, guild-agreements-ai | mc, st |

### Layer 4: Branches / personalization (3 branch-layer units, 15 lessons)

Branch units set `branchId`; a learner sees the ones matching their chosen branches (default `mainstream-franchise`).

**Unit `branch-franchise`: Blockbusters and Franchises** (branch `mainstream-franchise`; prereq: `story-and-genre`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bf-01` | Which order do I watch? | Tell release order from chronological order and when each is right. | watch-order, release-vs-chronological | ds, mc |
| `bf-02` | How a shared universe works | Explain phases, crossovers, post-credits and why they exist. | phases-and-slates, crossover-event, universe-fatigue | mc, so |
| `bf-03` | Box office for the franchise fan | Read global vs domestic, China, budgets vs marketing, "billion-dollar club". | billion-dollar-club, global-vs-domestic, marketing-spend | mc, es |
| `bf-04` | Superhero grammar | Explain origin stories, team-ups, multiverse, third-act CGI critique. | origin-story, multiverse-device, third-act-spectacle | st, mc |
| `bf-05` | Fan talk | Decode fan theories, "canon", "retcon", "fan service"; capstone. | fan-theory, canon-vs-retcon, fan-service | st, tk |

**Unit `branch-auteur-arthouse`: Auteurs and Arthouse** (branch `auteur-arthouse`; prereq: `directors-and-auteurs`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ba-01` | The festival circuit as a map | Explain Sundance, Cannes sidebars, Venice, TIFF, Telluride, Locarno. | festival-circuit-map, sales-and-acquisitions | mc, so |
| `ba-02` | A24, Neon and the label as a brand | Explain distributors as taste brands. | distributor-brand, a24-effect | mc, st |
| `ba-03` | Slow cinema and difficult films | Explain slow cinema, long silences, ambiguity; how to watch one. | slow-cinema, ambiguity-in-film, how-to-watch-difficult-film | ds, mc |
| `ba-04` | "Elevated genre" | Explain the term and the fight around it. | elevated-genre-debate | st, mc |
| `ba-05` | The Criterion habit | Explain spine numbers, essays, restorations; capstone. | criterion-spine, essay-and-extras-culture | mc, tk |

**Unit `branch-classic-repertory`: Classic Hollywood and Repertory** (branch `classic-repertory`; prereq: `eras-of-cinema`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bc-01` | The star-system icons | Name the eras' stars and what made "a star". | classic-star-system, screen-persona | mc, tm |
| `bc-02` | Screwball, noir, melodrama, musicals | Recognise the classic genres of the 1930s-50s. | screwball-classics, noir-classics, melodrama-classic, golden-age-musical | tm, vi |
| `bc-03` | Watching a classic | Explain black-and-white, Academy ratio and older pacing; how to ease in. | academy-ratio, black-and-white-cinematography, classic-pacing | mc, ds |
| `bc-04` | Repertory cinemas and TCM | Explain repertory programming and classic-movie channels. | repertory-cinema, classic-movie-culture | mc, st |
| `bc-05` | Restorations and reissues | Explain 4K restorations, reissues and archives; capstone. | restoration-reissue, film-archives | mc, tk |

### Layer 5: Current-season / live layer (1 unit, 6 lesson templates)

**Unit `now-in-cinemas`: Now in Cinemas** (prereq: `how-movies-get-made`; never locked behind other units). 6 templated lessons refreshed weekly/seasonally through `live` hooks; new cards ship without an app release.

| Lesson id | Title | Objective | conceptIds | Activities | `live` hook |
|---|---|---|---|---|---|
| `lv-01` | This weekend at the box office | Read the top-ten in plain English. | opening-weekend, box-office-legs | mc, st | `live.rankings.boxoffice` |
| `lv-02` | New in cinemas | Know what opens and what people will ask about it. | release-calendar-literacy | mc, st | `live.releases.wide` |
| `lv-03` | The awards race this week | Explain who is being talked about and why. | awards-season-calendar, frontrunner | mc, st | `live.events.awards` |
| `lv-04` | What is everyone streaming? | Explain what the "new to streaming" titles are and where they are. | streamer-original, release-window | mc, st | `live.newmedia.streaming` |
| `lv-05` | Festival dispatch | Explain what the latest festival won and why it matters. | fall-festival-circuit, festival-prizes-now | mc, st | `live.events.festivals` |
| `lv-06` | Why is everyone talking about this? | Decode the week's biggest film conversation. | editorial-context | st, tk | `live.news.explainer` |

### Layer 6: Conversation practice and perpetual review (2 units, 13 lessons)

**Unit `conversation-lab`: Conversation Lab** (prereq: any foundation unit; unlocks progressively). 8 lessons. Continuous: new talk tracks added seasonally; also surfaces in the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cl-01` | After the credits | First ten minutes after a movie: ask, don't quiz. | post-movie-questions, spoiler-etiquette | tk, st |
| `cl-02` | Picking the movie | Suggest a film for her taste without faking. | recommendation-etiquette, first-film-picks | tk, ds |
| `cl-03` | When she gushes about a director | Ask about the filmography, not the trivia. | signature-style, honest-gaps | tk, st |
| `cl-04` | You haven't seen it?! | Handle the gap gracefully. | honest-gaps | tk, st |
| `cl-05` | Awards night | Watch-party chat without bluffing. | frontrunner, snub | tk, st |
| `cl-06` | She loves a franchise | Ask about the universe you have not seen. | franchise, fan-theory | tk, st |
| `cl-07` | Disagree kindly | Disagree about a film without a fight. | specific-praise, honest-gaps | tk, ds |
| `cl-08` | Mixed conversation review | Decode five mixed lines. | mixed | st, tk |

**Unit `reel-review`: Reel Review (perpetual review)** (prereq: none; auto-populates). 5 lessons of mixed sets drawn by the review policy from mastered concepts.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rv-01` | Term blitz | Rapid recall of film terms. | mixed | tm, fg, mc |
| `rv-02` | Name that shot | Recognition of shot size, angle, light, ratio. | shot-sizes, camera-angles, aspect-ratio, three-point-lighting | vi, ht |
| `rv-03` | Camera moves refresher | Refresh camera moves and the 180-degree rule. | camera-movement, dolly-zoom, 180-degree-rule | SIM (either camera sim), bc |
| `rv-04` | Eras and awards timeline | Reorder eras and awards calendar. | mixed | so, mc |
| `rv-05` | Director adjectives | Match adjectives to directors and decode a line. | director-style-adjectives | tm, st |

### Review policy

Spaced review: intervals 1, 3, 7, 21, 60 days; a concept enters the pool when mastery first reaches 0.8; decays -0.15 on a miss; maximum 12 review items per session; time-sensitive concepts (awards facts, current winners) have a 90-day freshness flag and are re-verified before appearing.

### Also

- **Concept count target (Playbook):** ~340 concept ids (many are single-idea items grouped in the Playbook by unit); Playbook terms shown in the app grouped by unit; 60+ terms authored as samples (`exercises.md`).
- **Personalization slots:** `{{director}}`, `{{genre}}`, `{{franchise}}`, `{{platform}}`, `{{region}}` (section 8).
- **Release plan:** *v0.1.0 launch:* all four foundation units, `genres-up-close`, `directors-and-auteurs`, `eras-of-cinema`, `awards-season`, `cinephile-talk`, conversation lab (first 12 tracks), review. *v0.2:* `world-cinema`, `formats-and-debates`, `branch-franchise`, live unit with curated cards. *v0.3:* other branch units, sims (see below), licensed availability provider. Seasonal updates: awards cards each January-March, festival cards each September and May, summer box-office cards, and a yearly refresh of the "eras/now" lessons.

---

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4). **Two Unity sims, both about camera perspective**; everything else native. Native `hotspot-tap` and `visual-id` on original diagrams teach recognition; the sims teach what a camera *does* to a scene over time.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| `fr-04`, `mc-01`, `mc-02`, `rv-03`: Lens and move | focal-length, depth-of-field, perspective-compression, camera-movement, dolly-shot, dolly-zoom, dolly-vs-zoom | `unity-sim` `film.camera.lens-and-move.v1` (spec `sims/film.camera.lens-and-move.v1.md`) | Rubric: **camera perspective + movement in space is the concept.** The learner adjusts focal length and camera distance and sees perspective compress or stretch a *procedural* scene, and sees a dolly-in differ from a zoom-in. A static illustration cannot show that background size changes with distance but not with focal length; real stills would be unlicensed. Closest native: `hotspot-tap`/`visual-id` (used for the *recognition* of shot sizes only); `timing-tap` (1D) cannot carry it. | A | 1 sim, 24 scenarios |
| `mc-04`, `rv-03`: The axis line | 180-degree-rule, screen-direction, eyeline-match, shot-reverse-shot, continuity-editing | `unity-sim` `film.camera.axis-line.v1` (spec `sims/film.camera.axis-line.v1.md`) | Rubric: **spatial reasoning + camera perspective.** Learner places or picks a camera position around two moving characters, and the sim *plays the cut* so they see screen direction flip when the line is crossed. Static top-down diagram + `binary-call` (used as the native fallback and for review) shows the geometry but not the disorientation, which is the lesson. | A | 1 sim, 16 scenarios |
| Crew roles, studios, stages | film-crew-roles, production-stages, major-studio | `term-match`, `sequence-order`, `multiple-choice` | Recall, sorting and order; text is optimal (rubric "Recall, terms, order: native"). | B | ~90 |
| Shot sizes, angles, lighting, ratios | shot-sizes, camera-angles, three-point-lighting, aspect-ratio | `visual-id` (original technique illustrations, `original-swoond`) | Recognition is the skill; illustrations avoid unlicensed stills. | B | ~80 |
| Composition and frame geometry | rule-of-thirds, leading-lines, symmetry-composition | `hotspot-tap` (procedural diagram) | Tap where the subject sits on a thirds grid; static diagram, no motion. | B | ~35 |
| Aspect ratio, runtime, budget, ASL | aspect-ratio, runtime-norms, budget-tiers, average-shot-length | `estimate-slider` | A number is the lesson; closeness matters. | B | ~30 |
| Film sound (original cues) | diegetic-sound, score-vs-soundtrack, foley, leitmotif, silence-as-sound | `listening-id` (original or synthesised audio only) | Audio is the concept; original cues avoid score licensing (spec section 20). Always with skip and text alternative. | B | ~24 |
| Genre, era and director vocabulary | genre-map, silent-era, studio-system, director-style-adjectives | `term-match`, `fill-the-gap`, `multiple-choice` | Terms in context. | B | ~260 |
| Rule calls on continuity and structure | 180-degree-rule (static), three-act-structure | `binary-call` | Two-way call on a static diagram (also the sim's native fallback). | B | ~30 |
| Timelines and processes | production-stages, awards-season-calendar, eras | `sequence-order` | Order is the concept. | B | ~35 |
| Judgment: what to say/recommend/watch | spoiler-etiquette, recommendation-etiquette, first-film-picks | `decision-scenario` | Judgment with consequences and an expert note. | B | ~40 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice. | B | 24 talk tracks + ~90 say-this |
| Timing | - | `timing-tap` | **Not used.** Editing rhythm would be a contrived 1D game; a `estimate-slider` on ASL and the long-take listening cover it. | B | 0 |

Considered and rejected for Unity (recorded so Astra is not asked again): **lighting set-up sandbox** (moving a light around a head; native `visual-id` on original pre-rendered technique cards is adequate and the concept is recognition), **editing rhythm/timing game** (1D, `timing-tap` rejected as contrived), **virtual set blocking** (needs animation authoring for low payoff), **film-history timeline scene** (static text and `sequence-order`). If playtest shows `axis-line` is no better than `binary-call` + a 3-frame diagram, downgrade it (open question 2).

Accessibility fallbacks for both sims are designed native lessons (`fr-04n`, `mc-04n` named in each spec, section 16).

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| **Posters / key art / stills / frames / screenshots** | **Never used.** They are the copyright of studios and artists; even "public" images are not redistributable (rule 10). Deep-links to official pages only. All illustrations are original technique art (`original-swoond`). Film titles appear as text. |
| **Trailers / clips / video** | Never embedded, hosted or re-cut. "Watch the trailer" is a link-out to the studio's official channel; no autoplay. Educational fair-use claims are **not** relied upon (a commercial app). |
| **Score / soundtrack audio, needle drops** | Never used. Listening exercises use original or synthesised cues written for Swoon'd to demonstrate a *concept*. Cues never imitate a specific famous theme so closely as to be derivative (no "sounds like the Jaws theme" recordings). Song and score titles as text only. |
| **Dialogue and quotes** | No script or subtitle text. Famous lines are referenced by film title and a short factual paraphrase only. |
| **Publisher text and review text** | Never copied. Critic review snippets, Tomatometer blurbs, publisher plot synopses (including TMDB/IMDb synopsis fields) are copyrighted database/works: Swoon'd writes its own one-sentence descriptions. |
| **Ratings data** | Rotten Tomatoes, Metacritic, CinemaScore, IMDb and Letterboxd figures are provider-owned; no scraping and no mirrored tables. At most a hand-verified snapshot number dated and attributed as fact; otherwise link-out. |
| **Names, likeness, trademarks** | Actor/director names as facts; no likeness, no implied endorsement, no fabricated quotes. Studio and distributor logos (Disney, Warner Bros., A24, Neon, Criterion) are trademarks: text-only. "Oscar", "Academy Award", "Golden Globe", "SAG Awards/Actor Awards", "BAFTA", "Palme d'Or", "Sundance" are proper names used descriptively; store copy uses "the Academy Awards" or "the Oscars" descriptively (open question L-15). |
| **Data provider terms** | TMDB (non-commercial free; commercial by agreement; 6-month caching cap; no AI/ML use; JustWatch credit), OMDb (CC BY-NC), IMDb datasets (non-commercial), Letterboxd (API by request; not for recommendation/LLM/personal projects): **none used in production before a licence**. Wikidata (CC0) and Wikipedia (CC BY-SA, attribute) are fine for facts. See `live-data.md`. |
| **Legal viewing** | Never suggest piracy; "where to watch" only from licensed availability data or a "check your services" fallback. |
| **Sensitive content** | Some films discussed contain violence, sexual content or discriminatory history. Lessons name and contextualise (e.g. silent-era and studio-era racism, the Hays Code) without depicting; content-rating literacy (MPA G to NC-17, plain-language) is taught; no graphic descriptions; horror/violence discussed at survey depth. |
| **Safety** | No physical risk. Photosensitivity: sim scenes avoid flashing above 3 Hz (reduced-motion cuts); no strobe lighting. Age: some films are R-rated; recommendation lessons never push mature titles at an unknown-age reader and mention ratings. |
| **Voice/people** | Jokes target the learner's ignorance, never the crush; never mock a fandom or taste; never gatekeep ("real cinephiles"). |

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Shot-size, angle, composition and lighting illustrations (figures, top-down diagrams) | Original vector art / procedural SwiftUI | Swoon'd | `original-swoond` |
| Aspect-ratio frames (1.33 / 1.85 / 2.39 / 1.43 / 1.90) with neutral placeholder scenes | Procedural | Swoon'd | `original-swoond` |
| Camera-axis and blocking diagrams (top-down) | Procedural | Swoon'd | `original-swoond` |
| Film-sound cues (diegetic vs score, leitmotif, Foley, silence, mix) | Original composition/synthesis | Swoon'd | `original-swoond` |
| Timeline art (eras, awards calendar) | Procedural typography | Swoon'd | `original-swoond` |
| Sim scenes: procedural low-poly room/street set, two characters, a camera rig with lens cone, prop | Procedural | Astra | `original-swoond` |
| Film posters, stills, trailers, clips, score, dialogue | **Not used** | - | - |

---

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Crew roles, how a shot is built, how cuts and sound make meaning, genre as a promise, the vocabulary above (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Craft, directors as brands, formats, ratings culture, awards, industry news, recommendation (section 4).
- [x] 3. **What current information matters?** Release calendar, box office, awards season, festivals, streaming availability, editorial explainers (section 6).
- [x] 4. **What should be interactive?** Two camera-perspective sims; native recognition, order, listening, decision, conversation (section 12).
- [x] 5. **What should NOT be gamified?** Taste, sensitive history, awards as gambling, private lives, piracy (section 5).
- [x] 6. **How should it personalize?** director, genre, franchise, platform, region; three branches (sections 1, 8).
- [x] 7. **What does conversational competence look like?** Decode her lines, ask honest follow-ups, admit gaps, no spoilers (sections 9, 10).
- [x] 8. **What data providers are needed?** Curated editorial + Wikidata at launch; licensed availability and metadata providers only after agreement (`live-data.md`).
- [x] 9. **What licensing constraints apply?** No posters/stills/clips/score/quotes/review text; provider terms checked (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, review ladder, talk-track Smooth >= 60, Say-It check, sim masterySignals, competence statement (section 10).

Additional gates: [ ] manifest validates (run `tools/validate`); [ ] curriculum validates (not yet authored); [x] every Unity sim has a draft spec (`sims/`); [ ] every image/audio asset has a license id (assets not yet produced; id `original-swoond`); [ ] voice review; [x] no copied publisher text.

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | **Horror: branch or independent?** Decided independent (section 1). Product owner to confirm so `horror-films` (wave 3) is planned as its own CDS. | Product | No |
| 2 | Is `film.camera.axis-line.v1` clearly better than native `binary-call` + a 3-panel diagram? Keep Tier A only if playtest shows it. `lens-and-move` is the stronger case. | Product / Astra | No |
| 3 | Unit count 17 (three branch units, live unit) vs 8-14 guidance. Approve or fold `world-cinema` into `directors-and-auteurs`? | Product | No |
| 4 | Licensed metadata/availability provider: TMDB commercial agreement vs Watchmode vs JustWatch partner API vs Streaming Availability API; and box-office data licence. Launch is curated-only until decided. | Product / Legal | Blocks automated live cards |
| 5 | Store-copy wording of "Oscars"/"Academy Awards" and "Actor Awards". | Legal | No |
| 6 | News/editorial provider licence (all courses' L-01). Movies default: link-only headlines. | Product | Blocks automation |
| 7 | Original-audio production for `listening-id` (compose in-house vs synthesise vs commission). | Product | No (native fallback: skip) |
| 8 | Facts to re-verify before release: 2026 awards results (98th Oscars: Best Picture *One Battle After Another*; Golden Globes Drama *Hamnet*; Cannes 2026 Palme d'Or *Fjord*; Venice 2026 Golden Lion *Woman Unknown*), 99th Oscars date 14 Mar 2027 with nominations 21 Jan 2027, Warner Bros. Discovery / Paramount status, box-office leaders. | Content | No (live layer only) |
| 9 | Should awards-watcher become a branch (currently: core `awards-season` + live cards)? | Product | No |
