# Course Design Specification: Horror Films (`horror-films`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 3 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity sims, justified in section 12) |

Time-sensitive facts (awards results, box office, festival dates, release slates, platform ownership) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Evergreen lessons never hard-code them; the live layer and `{{tokens}}` carry them (see `live-data.md`).

**Two design constraints shape this course.**

1. **Media licensing (spec section 40, rule 10).** Swoon'd talks *about* films; it never redistributes them. No posters, key art, stills, frame grabs, trailers, clips, score audio, dialogue quotes beyond a short factual phrase, or publisher/review text. Horror makes this easy to honour and even a strength: teaching images are original diagrams of a *technique* (a frame with negative space, a low-key lighting set-up, a sound-envelope drawing), and teaching sounds are original, synthesised and deliberately gentle. Details: section 13.
2. **Content comfort (product owner brief).** The learner may not like scary things. The person they care about does. The course must teach *appreciation and conversation* without forcing exposure. This is not a footnote; it is a personalization axis (the **comfort dial**, section 8) that changes how every lesson is delivered, and it sets a floor: violence and gore are always described at a non-graphic level, for every learner, at every dial setting.

---

## 1. Identity

- **Course ID:** `horror-films` (immutable)
- **Display name:** Horror Films
- **Category / family:** Film & Television > Movies > Horror (family `Film & Television`)
- **Simulation prefix:** `horror` (reserved; no sims are planned)
- **What "Horror Films" means here.** The person you care about might be a *slasher devotee* who owns every sequel, a *spooky-season* watcher who does thirty-one films every October, an *elevated-horror* festival-goer who says "dread" a lot, a *practical-effects nerd*, a *world-horror* explorer (giallo, J-horror, K-horror), or a *cozy* horror fan who loves the atmosphere and screams politely. The course teaches the shared language all of them use (how scares are built, the subgenre map, the canon, the fights, the fan culture) and tilts by branch. It covers feature films, with shorts, anthologies and adjacent media as context only. Television, games and books are cross-links (see boundary table).
- **Related courses and boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Movies (`movies`, wave 2) | **Only partly, and the reverse is also partial.** Movies gives film language (shot size, light, cut, sound, genre as promise) and one survey lesson on horror (`gn-06`), which ends in a hand-off card to this course. It does not give the subgenre taxonomy, the canon, franchise sagas, the elevated-horror fight, effects and gore culture, festival culture, or scare craft. This course does not re-teach general film language. | **Independent, adjacent, shares terms via cross-links** (recorded decision in movies CDS section 1 and NOTES item 1) | Every lesson that touches film language carries a "movies cross-link" (for example `movies:fr-06` Light, `movies:mc-07` What you hear, `movies:mc-08` Themes, silence and the mix, `movies:gn-01` Suspense vs surprise, `movies:fd-02` Practical vs CGI). The cross-link is a one-line refresher and a link, never a prerequisite. This course teaches the *horror use* of a technique (for example why low-key light hides the monster), not the technique. |
| Anime (`anime`, wave 3) | Partly. Anime horror (Junji Ito adaptations, Perfect Blue, Higurashi) and J-horror share themes, but anime fandom is a medium culture (seasons, studios, manga). | **Independent** | `wr-02` covers J-horror as *live-action cinema*; anime and manga horror get a cross-link only. |
| Video Games (`video-games`) | Survival horror (Resident Evil, Silent Hill, Alien: Isolation) shares moods and monsters; fandoms and vocabulary differ. | Adjacent | `ff-05` names game and series crossovers as context; no dependency. |
| Books (`books`) | Gothic and horror literature (Shelley, Stoker, Poe, King, Jackson) feeds horror film; "the book was scarier" is common. | Adjacent | `cs-01`, `gh-01`, `sf-01` name literary sources as facts; cross-link to `books`. |
| Music (`music`) | Horror scores are a craft of their own; overlap is one lesson (`sc-07`). | Adjacent | Cross-link only. |
| Photography / Movies craft | Low-key light, composition, colour. | Adjacent | Cross-link to `movies:fr-06`, `movies:fr-03`. |
| Television | Horror series (anthology and prestige) matter to fans, but TV is not taught in `movies` either. | **Independent** (candidate course) | One lesson (`ff-05`) names series as context and links to the future Television candidate (NOTES item 5). |
| Sub-worlds of horror: slasher/franchise, elevated/arthouse, practical-effects/body | Learning the shared foundation makes you competent about each *world*, but each has its own canon and talk. | **Shares foundation** | Modelled as three branches. World horror and festival culture are core enthusiast units. |

- **Branches** (the "what kind of horror person is she" lens; foundation is shared, branch units add depth; a learner may enable several). Choosing a branch **never** implies watching anything; branch units are talk-about units.

| id | Name | What changes |
|---|---|---|
| `slasher-franchise` (default) | Slashers and franchises | Franchise sagas, watch orders and tangled timelines, the "big names", legacy sequels, horror-con and box-office culture, kill-as-set-piece talk (non-graphic). |
| `elevated-dread` | Elevated dread | Slow burn, grief and family horror, ambiguity, A24/Neon/Shudder-festival culture, the "elevated" fight, how to *sit with* a slow film. |
| `practical-and-body` | Practical effects and the body | Makeup and creature-effects artists, how illusions are built, body-horror ideas, effects documentaries, "practical vs CGI" as craft appreciation. Craft angle only, never gore detail. |

---

## 2. Beginner model

**What a complete beginner typically knows.** They know horror exists and that it is "the scary genre". They know a few famous monsters and masks (a chainsaw guy, a hockey mask, a clown, a doll), maybe a few titles (*The Exorcist*, *Halloween*, *Scream*, *Get Out*, *The Conjuring*, *It*), and the word "jump scare". They know whether *they* like being scared, and most beginners here have decided "no". They may believe horror fans are into cruelty. They do not know why anyone would choose this.

**Terminology that will initially confuse them.**
- Subgenres: slasher vs psychological thriller vs supernatural vs "creature feature"; giallo; folk horror; body horror; found footage; "final girl"; "cosmic horror".
- Craft: jump scare vs dread, stinger, cold open, "cat scare", practical effects, prosthetics, animatronics, "the kills", "kill count".
- Culture: "spooky season", "elevated horror", "post-horror", "video nasties", "midnight movie", "Shudder", "Fangoria", "legacy sequel", "final-girl energy", "scream queen", "horror host".
- Business/festival: "Blumhouse model", "midnight madness", "Fantastic Fest", "Sitges", "unrated cut", "NC-17".

**Common misconceptions.**
1. "Horror fans like blood and cruelty." (Most love atmosphere, suspense, craft, community and the thrill of a controlled scare; many favourite films are nearly bloodless.)
2. "Horror is just jump scares." (Jump scares are one tool; dread, uncanny imagery and implication do more of the work in the best-loved films.)
3. "It's all the same: someone gets chased." (The subgenre map is huge: folk, cosmic, domestic, comedy, grief, satire.)
4. "Horror is low-brow / not real film." (Awards recognition, festival prizes and film-history canon disagree; the genre also has a real trash-cinema tradition that fans love without embarrassment. Both are true.)
5. "If it scares you, it's good; if it doesn't, it's bad." (Scariness is personal and not the only measure; fans separate "scary", "good", "fun" and "important".)
6. "You have to watch scary stuff to understand it." (You can learn what a scare *does* from how it is built, and from what fans say about it.)
7. "Slasher = all horror." (Slashers are one 1978-onward cycle, with a specific template.)
8. "Older horror isn't scary." (It scares differently; implication vs shock. Learning the difference is the point.)
9. "Based on a true story means it happened." (It is marketing; the phrase ranges from a loose inspiration to fully invented.)
10. "Horror is a guy thing / a young-people thing." (Audience and creators are broad; women directors and fans are central to the genre's history.)

**Concepts that unlock the rest (become foundation units).** (1) Horror is a *feeling* (dread, shock, revulsion, the uncanny), and different films aim at different feelings. (2) Scares are *built*: expectation, timing, what is withheld, sound. (3) The subgenre map: know which promise a film makes. (4) The horror vocabulary and its rules (final girl, cold open, monster's shape). (5) *Your comfort dial* is a legitimate way to engage: you can love the craft and the community without watching the frightening bits.

---

## 3. Foundational knowledge

Modules (become `foundationalModules[]` and foundation units):

| Module (unit id) | Contents |
|---|---|
| `what-is-horror` | Fear vs terror vs revulsion; why people enjoy controlled fear; the comfort dial; appreciating without watching; rating and content-note literacy; horror's promises; the taxonomy at a glance. |
| `scare-craft` | Dread vs jump scare; anatomy of a jump scare; slow dread; what you do not see; light and shadow in horror; sound design; music and its absence; horror's pacing beats. |
| `the-subgenre-map` | Slasher, ghost/haunted house, possession, creature, zombie/infection, psychological, folk/cosmic/gothic; sorting a real film into its promise. |
| `horror-vocabulary` | Final girl, "the rules", the monster's shape, haunted spaces, sequel logic, kills as set pieces (non-graphic), spoiler etiquette in horror. |

Intermediate and enthusiast content: history, slashers, the supernatural, folk/body/cosmic/undead, found footage and formats, world horror; the debates (elevated, allegory, censorship, remakes, representation, "torture porn"); effects and craft; festival and fan culture. Reference facts are stated in evergreen form; named titles are chosen from settled canon and dated where they depend on the season.

---

## 4. Enthusiast model

**What enthusiasts actually talk about.**
- What they watched last night, whether it was *scary*, and what *kind* of scary ("more dread than jump scares", "the sound design got me").
- Kills, set pieces and effects ("the practical work is unreal") and the *craft* behind them.
- Directors as brands (Carpenter, Craven, Argento, Cronenberg, Romero, Raimi, Hooper, Aster, Eggers, Peele, Flanagan, Wan, del Toro, Kurosawa Kiyoshi, Bong, Fargeat).
- Franchises: rankings ("worst Friday the 13th", "which Halloween timeline"), watch orders, legacy sequels.
- Lists and calendars: "31 days of horror", best-of-year, "underrated", "hidden gems", the October marathon.
- The fights: elevated horror, remakes, CGI vs practical, "is it a slasher?", who counts as a final girl, jump scares good or bad.
- Festivals, boutique labels, Shudder, conventions, midnight screenings, horror hosts.
- Comfort horror: rewatches that feel like a cozy blanket ("I put on Halloween every October").

**Distinctions that matter to them.**
- Jump scare vs dread vs shock vs gross-out vs the uncanny.
- Slasher vs giallo vs psychological thriller; supernatural vs psychological; possession vs haunting; creature feature vs monster movie; found footage vs mockumentary vs screenlife.
- Folk horror vs occult horror; body horror vs gore; cosmic horror vs monster movie.
- Remake vs reboot vs legacy sequel vs requel.
- Scary vs good vs fun vs important; "elevated" vs "genre"; "trauma horror" vs "grief horror"; "cozy horror".
- Theatrical vs unrated vs director's cut; practical vs digital; "video nasty" (a UK legal category) vs "exploitation" (a marketing tradition).

**Knowledge that signals genuine understanding.** Being able to say *why* a scene works ("nothing happens for a full minute and you can't breathe"), naming what a film borrows, placing it in the map, knowing what a "final girl" is and that scholars argue about it, asking what someone loves about a scary film rather than saying "I could never watch that", and honouring a friend's comfort limits.

**Beginner statements that sound obviously uninformed.**
- "Isn't it all just blood and screaming?"
- "Why would anyone want to be scared?" (a genuine question, but asked as a dismissal it lands badly; Swoon'd teaches the curious version)
- "Horror isn't real cinema."
- "It's a horror because it has a killer." (thriller or slasher?)
- "Jump scares are the only scares."
- "The Oscars never nominate horror." (Increasingly wrong; see `live-data.md`.)
- "Scream is a serious slasher." (It is a meta-slasher.)
- "You have to watch it to love it."

**Common controversies and debates.** Elevated / "post-horror" (term coined by Steve Rose in *The Guardian*, July 2017): insight or snobbery? Remakes and legacy sequels; practical vs CGI; jump scares: cheap or a legitimate tool; horror and representation (who lives, who dies, who writes); "torture porn" as a critical label and whether it was fair; the "video nasties" censorship panic (UK, 1980s); the extremity of some subgenres and where taste stops; horror as allegory vs "it's just fun"; scary vs good; the Oscars' relationship with horror (*The Silence of the Lambs*, 1991, remains the only horror-adjacent Best Picture winner by many counts, itself contested as "thriller"; 2026's record nominations for *Sinners* revived the argument [verify at release]); horror and mental-health portrayals; and the ethics of "based on a true story" and real-life hauntings marketing.

---

## 5. Interaction model

**What the learner should experience instead of reading.**
- *See how a scare is built*, without being scared: original technique diagrams (a timeline of a jump-scare's setup, quiet, stinger; a frame with negative space; a low-key lighting set-up) via `visual-id`, `hotspot-tap`, `sequence-order`.
- *Hear how sound works*, gently: short original synthesised cues (a drone, a silence, a sting drawn as a waveform first) via `listening-id`. Each has a preview of intensity, a skip button without penalty, and a text twin. Comfort dial setting "gentle" replaces audio with a described version.
- *Sort the map*: `term-match`, `multiple-choice` and `visual-id` on original subgenre "promise cards" (what each promises the audience).
- *Decide*: what to say after a scary movie, how to say no kindly, what to suggest for a first shared watch (`decision-scenario`, `talk-track`).
- *Decode*: "it's a slow burn", "the kills are the point", "very folk horror", "final-girl energy" (`say-this`).

**Unity?** No, and that is the recommendation, not an omission. See section 12: film-language simulations already live in `movies` (`film.camera.lens-and-move.v1`, `film.camera.axis-line.v1`) and horror lessons link to them. The one horror-specific candidate ("a jump-scare timing game") was rejected because it would *frighten the learner as gameplay*, which contradicts the comfort principle, and because timing of a scare is teachable by diagram plus optional audio.

**What should NOT be gamified.**
- **Courage.** No "brave" badges, no streaks for watching scary things, no dares, no leaderboards, no XP for sitting through intense audio. Skipping an intense item never costs mastery, streak or XP (a text twin awards equal mastery).
- **Gore and cruelty.** No scoring of kill counts, no "guess the kill", no gore trivia, no ranking of "most disturbing". Kills are discussed as craft and choreography, never as spectacle.
- **Taste.** No score for what the learner likes; no scary-tolerance quizzes that shame low tolerance.
- **Real crimes and real victims.** Films "based on true stories" and real-life haunting claims are taught as marketing and folklore; no games with real killers, real cases or real victims.
- **Sensitive history and portrayals** (racist tropes in the genre's history, the treatment of women, mental illness, disability): taught in plain factual text with context, never as points.
- **Piracy.** Never suggest illegal sources; where to watch is via licensed availability data only.
- **Awards as gambling.** As in `movies`: private notebook, no wagers.

Details of the chosen mix are in section 12.

---

## 6. Dynamic information requirements

Horror is a **light-to-moderate** live-data subject with a strong *seasonal* rhythm: a huge spike September-October ("spooky season"), plus year-round releases, festivals (Fantasia July, Fantastic Fest September, Sitges October, Sundance Midnight January), Shudder premieres, and Friday-the-13th and anniversary moments. Structured data and editorial data are separate systems. Full plan in `live-data.md`.

| Kind | Needed? | Why | Provider candidates (behind adapters) | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules` | Yes | Horror release calendar (theatrical, streaming, Shudder), festival dates, anniversary reissues | Curated Swoon'd editorial calendar from public studio/festival announcements; Wikidata (CC0) for structured dates; TMDB only under a commercial agreement | weekly (daily in Sep-Oct) | Last published calendar, dated |
| `releases` | Yes | "What opens this weekend", "new on Shudder", an intensity-aware card | Editorial curation; licensed metadata provider later (see movies L-13); link out to official trailers pages only | weekly (daily in Oct) | Evergreen "how to pick a first horror film" card |
| `rankings` | Light | Weekend box-office top-line story (horror over- and under-performers) | Curated attributed top line; The Numbers/Comscore need a licence | weekly (Mon) | Static "how to read a horror box office" card |
| `events` | Yes | Festivals and their prizes; awards nominations and winners when horror is in the race; Bram Stoker/Saturn-class genre awards | Official announcements (curated); Wikidata (CC0); Wikipedia (CC BY-SA, attribute) | daily in festival and awards weeks | Last season's results as history |
| `new-media` | Yes | Streaming availability ("where can I watch this"), Shudder/AMC+/Screambox/Tubi arrivals | Watchmode, Streaming Availability API, JustWatch partner API, TMDB watch providers (commercial licence only) | daily | Hide availability, keep the lesson |
| `news` | Yes (editorial) | Why a sequel is announced, why a film is being talked about, why a festival crowd reacted | Publisher RSS headlines, link-only; Swoon'd writes explainers (L-01) | daily | Evergreen explainers |
| `statistics`, `standings`, `scores`, `rosters`, `injuries`, `weather`, `closures`, `alerts`, `regulations`, `transactions`, `new-products` | **No** | Not meaningful (spec section 10: no artificial live data). Ratings-board changes are editorial `events`. | - | - | - |

**Content-intensity data (unique to this course).** Availability cards carry an *intensity line* built from official **public rating and rating-reason text as a factual, link-out** (MPA, BBFC, IFCO-class board pages), never a copy of a third-party "parents guide". Providers such as Common Sense Media, IMDb parents guides and "does the dog die"-type sites are **user-content or copyrighted databases**: link-out only, no scraping, no mirroring (see `live-data.md` section 5).

Provider terms (TMDB non-commercial-only without agreement, OMDb CC BY-NC, IMDb datasets non-commercial, Letterboxd API refused for recommendation/LLM use) are the same as movies (`movies/live-data.md`); **none is a production dependency before a licence**. The launch plan is curated editorial + Wikidata (CC0).

---

## 7. Editorial context

- **What commentary helps.** Why a horror film is being talked about (a festival reaction, a viral marketing moment, a surprise box-office run); what a sequel announcement means for a franchise; why a remake is contested; why the genre keeps overperforming at low budgets; what the "elevated" label does to a film's reception; why an anniversary re-release matters; and, always, a plain-language *what kind of scary is it* card for the current week's titles.
- **Sources.** Genre press and trade press as **link-outs** (Bloody Disgusting, Dread Central, Fangoria, Variety, The Hollywood Reporter, Deadline, IndieWire, Screen Daily, Sight and Sound, Shudder's own editorial), plus official festival, ratings-board and studio pages as factual sources.
- **Licensing.** Publisher text, review text, critic quotes, plot synopses and "scariest scene" write-ups are copyrighted: never copied. Swoon'd writes its own one-sentence descriptions.
- **Approach: explain in our own words, and link.** Manifest `editorial.approach = explain-and-link`.
- **Example prompts.** "Why is everyone saying this one is the scariest of the year?" "What does 'legacy sequel' promise this time?" "Why did a small horror film beat a tentpole this weekend?" "What did the midnight crowd at the festival love?" "How intense is this one, really, and what should I ask her?"
- **Editorial cadence.** A weekly Swoon'd editor writes 3-5 "Why is everyone talking about this?" cards (daily in October); each cites two link-outs, includes a `say-this` line and an intensity note (rating, subgenre, "dread or shock", link to public rating reasons). Comfort dial "gentle" hides the intensity-detail line and shows "talk about it, don't watch it" framing.

---

## 8. Personalization

| Dimension | How it changes examples and live context | Default when unset | Units using `{{tokens}}` |
|---|---|---|---|
| `genre` (subgenre: slasher, supernatural, folk, body, found footage, giallo, J-horror, K-horror, creature, zombie, psychological, comedy-horror) | Examples skew to her subgenre; live layer flags releases by subgenre; branch suggestions | "supernatural" for prose examples; subgenre-neutral for exercises | `the-subgenre-map`, `horror-vocabulary`, `now-in-horror`, `conversation-lab` |
| `director` | Adjective-test and "start here" lines lead with her director (Carpenter, Craven, Argento, Cronenberg, Aster, Eggers, Peele, Flanagan, Wan, del Toro...); live layer flags new releases and interviews | Curated rotation: Carpenter, Craven, Peele, Aster, del Toro | `century-of-scares`, `horror-debates`, `conversation-lab`, `now-in-horror` |
| `franchise` | Franchise units and live cards emphasise her saga (Halloween, Friday the 13th, Nightmare on Elm Street, Scream, Saw, The Conjuring, Evil Dead, Final Destination, Child's Play...) | none; `branch-slasher-franchise` uses a neutral "the big sagas" set | `slashers-and-final-girls`, `branch-slasher-franchise`, `now-in-horror`, `conversation-lab` |
| `platform` | "Where to watch" cards (theatres, Shudder, Screambox, Netflix, Max, Prime Video, Tubi, boutique physical media) | "in theatres or on a streaming service" | `horror-culture`, `now-in-horror` |
| `region` | Regional horror focus (Japan, Korea, Spain, Thailand, Nigeria, Italy...), dub/sub norms, local festival dates | US | `world-horror`, `now-in-horror` |
| **Content comfort (the comfort dial)** — *cross-cutting personalization, a requested new profile field (NOTES item 2); not a manifest dimension yet* | See below. | `balanced` | **Every unit** |

**The comfort dial.** Set once (`wi-03` "Set your comfort dial"), changeable at any time from Settings, never asked twice, never gated. Three levels; every lesson is authored so the base version is safe for all three, and higher levels only *add optional depth*.

| Level | Name in the app | Meaning | What changes |
|---|---|---|---|
| `gentle` | "Talk about it, don't watch it" | The learner does not want intensity, ever. | No scary audio (listening items are replaced by a described-version `multiple-choice`, same conceptIds and mastery); no film-specific intensity detail; film examples use craft-and-context framing ("what the scene is *for*") rather than events; live intensity line is hidden; conversation labs include "I don't watch these but I want to hear about it" tracks. |
| `balanced` (default) | "A little peek" | Comfortable with mild intensity in a controlled way. | Original, quiet audio demos with a preview line ("calm, no sudden sounds") and skip; subgenre cards state what the promise *feels* like without describing events; live intensity line shows public rating and subgenre. |
| `full` | "Bring on the craft" | Enjoys or tolerates scary craft. | Adds optional mild synthesised stingers (loudness-capped, warning + confirm before play), more detail on how specific scenes are staged (still non-graphic), watch-along suggestions for a first shared watch. |

**Rules that hold at every level (the floor).** (a) Gore and violence are described at a non-graphic level: words like "a violent death", never method or injury detail. (b) No images depicting horror; the course has no stills anyway. (c) Every audio item has a skip, a text twin and equal mastery credit. (d) No penalty, guilt or nudge for choosing a lower level; "gentle" learners reach the same mastery and the same useful-competence statement. (e) Sensitive topics (suicide, child harm, sexual violence, self-harm) appear only as *topic names* in content-note literacy ("a film may include..."), never depicted, and are flagged with a content-note line before lessons that name them; they can be skipped without loss. (f) The dial is a private profile setting and is never sent to analytics in a way that reveals it (discreet-mode rules apply).

Personalization is optional; the foundation is unchanged. All token use falls back to the defaults. The `skill-level` dimension is not used; `branch` handles depth.

---

## 9. Conversation model

**What she might naturally say (with translation).**

| # | She says | Means | Implied terms | Good follow-up (genuine) |
|---|---|---|---|---|
| 1 | "It's not really scary, it's more dread." | It builds unease slowly instead of using shocks. | dread, slow burn, jump scare | "What was the moment the dread kicked in?" |
| 2 | "The kills are the point." | In this film, the set-piece deaths are the entertainment, staged with craft. | slasher, set piece, kills | "Was there a favourite one for the staging?" |
| 3 | "Very final-girl energy." | The survivor protagonist is resourceful and ends up confronting the killer. | final girl, slasher | "Do you think she earns it or is it a trope?" |
| 4 | "It's a proper giallo." | Stylish Italian murder-mystery-thriller with a gloved killer, colour and choreography. | giallo, Argento, Bava | "Is it more about the mystery or the style?" |
| 5 | "It's elevated horror. Don't call it a scary movie." | Prestige-coded, dread-driven film; the label is contested. | elevated horror, post-horror | "Do you like the label or does it bug you?" |
| 6 | "Practical effects, no CGI." | Physical makeup, prosthetics or puppets rather than digital effects. | practical effects, prosthetics, animatronics | "Which effect made you go, how did they do that?" |
| 7 | "The sound design did all the work." | The audio (drones, silence, small noises) created the fear. | sound design, silence | "Did you feel it more in the theatre?" |
| 8 | "That's a legacy sequel, so a lot of callbacks." | A late sequel aimed at old fans with returning characters. | legacy sequel, requel | "Do you need the original for it to land?" |
| 9 | "I do a thirty-one-day October marathon." | A yearly Halloween-season watch-a-film-a-day tradition. | spooky season, marathon | "What's on the list for the first night?" |
| 10 | "It's found footage, but a good one." | Presented as recovered camera recordings; it earns its shaky camera. | found footage, POV | "Did it feel real or staged?" |
| 11 | "Honestly the ending was ambiguous and I love that." | The film does not explain what was real; she enjoys interpreting it. | ambiguity, unreliable narrator | "What's your read on what happened?" |
| 12 | "It's folk horror: the landscape is the villain." | Rural setting and old beliefs create the threat. | folk horror, isolation | "Is it the community or the place that gets you?" |
| 13 | "J-horror is all about the slow crawl of a ghost." | Japanese ghost films emphasise stillness and technology-vengeance. | J-horror, onryo | "Do you prefer the original or the remake?" |
| 14 | "I watched it through my fingers." | She was scared and still loved it. | comfort, scare tolerance | "Was that scary in a good way?" |
| 15 | "It's a comfort movie. I rewatch it every Halloween." | A familiar scary film that feels cozy. | cozy horror, comfort rewatch | "What is it about that one that feels like home?" |
| 16 | "It won on the festival midnight circuit." | It played in the late-night genre strand of a festival. | midnight madness, festival | "What did the audience do at the big moment?" |
| 17 | "Which Halloween timeline are we in?" | The series has several parallel continuities after sequels. | timeline, continuity, franchise | "Which timeline do you count?" |
| 18 | "It's got a good creature design." | The monster looks original and is well-realised. | creature design, monster reveal | "Do you like it better hidden or shown?" |

These are seeds for ~90 `say-this` items; `exercises.md` writes 10+ in full.

**How Swoon'd helps without encouraging fake expertise.** Every `say-this` and `talk-track` rewards *curiosity and honest gaps* ("I haven't seen it, can you tell me what you love about it?") over bluffing. The learner never has to claim to have watched something. Talk tracks explicitly include the gentle-dial stance: "I'm not a scary-movie person, but I love that you are. What is it about them?" The coach note repeats: "You don't need to have watched it; you need to be curious about why she did." The Playbook avoids "canon checklist" pressure and never lists must-see films as homework.

**Targets.** 24 talk tracks at launch (10 sampled in `exercises.md`), ~90 `say-this` items, 12 conversation lessons (8 in the Conversation Lab plus the capstone beats).

---

## 10. Assessment

- **How useful competence is determined.** Concept mastery (0-1; pass 0.8) from exercise outcomes, spaced review resurfacing, talk-track Smooth >= 60 at the end of each unit conversation lesson, and a Say-It check at unit ends. **Audio and intensity-flagged items have a native text twin that awards identical mastery**, so comfort choices never change mastery.
- **Recognize.** Subgenres and their promises; scare-craft terms; canon markers per era; major franchises and their basic shape; effects vocabulary; festival and fan-culture names.
- **Understand.** Why dread and jump scares differ; why implication works; how sound and light hide and reveal; why the slasher template exists; what "elevated" claims and why people push back; why practical effects are prized; why horror over-performs at the box office; what a comfort dial is for.
- **Explain.** In one sentence, what a specific subgenre promises; why a film "works" in craft terms; why she loves her favourite scary film.
- **Correctly interpret.** A fan's line ("Elevated, slow burn, very folk horror") into plain meaning and a good follow-up; a rating-reason line into "how intense is this".
- **Mastery model.** `concept-mastery-v1`, `passThreshold` 0.8.
- **Useful competence statement:** *"I can follow and join a conversation about horror films, whatever my own scare tolerance: I understand what people mean when they talk about how a scare is built, which kind of horror a film is, where it sits in the genre's history and fights, and how horror fans share it, and I can ask honest, curious questions and honour comfort limits without pretending to have watched everything."*

---

## 11. Curriculum map (ongoing course)

Course version target at launch: `curriculumVersion 0.1.0`. **19 units, 118 lessons, about 354 concepts** across all six layers. A learner sees about 17 (matching branches only). Unit count exceeds the 8-14 guidance for the same reasons as `movies` (three branch units and a live unit) plus a deep intermediate layer because horror has more distinct subgenre cultures than most subjects (approval requested: NOTES item 3, with a proposed fold).

Activity legend: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap. **No Unity sims.** Lessons marked **(C)** contain an intensity-flagged item (calm audio or a described scene) that has a text twin under `gentle`. Cross-links to `movies` are written `-> movies:<lessonId>` (one-line refresher and link, never a prerequisite).

Every lesson ends with a "line you could say out loud" and 1-2 Playbook additions. Every unit's final lesson is a mixed-review capstone that includes one `tk` or `st` beat. Every lesson has at least 4 activities in the authored curriculum.

### Layer 1: Foundations (4 units, 27 lessons)

**Unit `what-is-horror`: What Horror Is (and Your Comfort Dial)** (prereq: none). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `wi-01` | A feeling, not a body count | Tell fear, terror, horror, dread and revulsion apart. | horror-feelings, terror-vs-horror, dread, uncanny | mc, tm |
| `wi-02` | Why anyone enjoys this | Explain controlled fear, the safe threat and shared screams. | controlled-fear, excitation-transfer, catharsis, shared-scare | mc, st |
| `wi-03` | Set your comfort dial | Choose a comfort level and know it changes only *how* you learn. | comfort-dial, scare-tolerance, no-shame-rule | ds, mc |
| `wi-04` | Appreciating without watching | Name four ways to love horror from a distance (craft, history, community, reading). | appreciate-not-watch, craft-first-appreciation, daylight-watching, watch-with-friends | ds, st |
| `wi-05` | Ratings and content notes | Read MPA/BBFC-class ratings and rating reasons as "how intense is it". | film-ratings-literacy, content-notes, r-rated-vs-nc17, unrated-cut | mc, tm, es |
| `wi-06` | Horror's promises; capstone | Sort horror into promises (dread, shock, gross-out, thrill, uncanny) and the taxonomy at a glance. | horror-promises, subgenre-overview, tone-map | tm, mc, st, tk |

**Unit `scare-craft`: How a Scare Is Built** (prereq: `what-is-horror`; `movies:motion-cut-and-sound` helpful). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sc-01` | Dread vs jump scare | Explain anticipation vs startle (-> movies:gn-01 suspense vs surprise). | jump-scare, dread-vs-jump-scare, anticipation, startle-reflex | mc, bc |
| `sc-02` | Anatomy of a jump scare | Order setup, quiet, misdirection and stinger. **(C)** | jump-scare-anatomy, stinger, cat-scare, earned-vs-cheap-scare | so, vi, li |
| `sc-03` | Slow dread | Explain long takes, stillness and waiting (-> movies:mc-06 long take). | slow-burn, negative-space, long-take-horror, wide-frame-dread | ht, mc |
| `sc-04` | What you don't see | Explain implication, off-screen threat and the reveal timing. | implication, off-screen-threat, monster-reveal-timing, less-is-more | mc, bc, st |
| `sc-05` | Light and shadow | Explain how low-key light, silhouette and darkness hide and reveal (-> movies:fr-06). | low-key-horror, silhouette, darkness-as-tool, night-photography | vi, mc |
| `sc-06` | Sound is more than half | Explain drones, silence, low frequencies and sound design (-> movies:mc-07). **(C)** | horror-sound-design, drone, silence-in-horror, infrasound-myth | li, mc |
| `sc-07` | Music and its absence | Explain dissonance, string techniques, lullabies gone wrong and no-score horror (-> movies:mc-08). **(C)** | horror-score, dissonance, wrong-lullaby, no-score-horror | li, st |
| `sc-08` | Pacing and the horror beat sheet; capstone | Name cold open, false safety, escalation, last scare. | cold-open, false-safety, escalation, final-scare, horror-pacing | so, mc, st, tk |

**Unit `the-subgenre-map`: The Subgenre Map** (prereq: `what-is-horror`). 7 lessons. Each lesson describes the *promise*, not events.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sm-01` | Slashers | State the slasher promise and its template. | slasher-film, slasher-template, masked-killer | tm, mc |
| `sm-02` | Ghosts and haunted houses | Tell ghost story, haunting and haunted-object films apart. | ghost-film, haunted-house, haunted-object | tm, mc |
| `sm-03` | Possession and the occult | Explain possession, exorcism, demonic and occult horror, with faith context. | possession-film, exorcism-film, occult-horror, faith-and-horror | mc, st |
| `sm-04` | Creatures and monsters | Explain creature feature vs monster movie vs kaiju (-> movies:wc-03). | creature-feature, monster-movie, animal-attack, creature-design | tm, mc |
| `sm-05` | Zombies and infection | Explain undead, infection and apocalypse horror. | zombie-film, infection-horror, apocalypse-horror, slow-vs-fast-zombie | mc, bc |
| `sm-06` | Psychological horror and thrillers | Tell psychological horror from a thriller. | psychological-horror, horror-vs-thriller, unreliable-perception | tm, mc |
| `sm-07` | Sorting a real film; capstone | Place a described film into the map with two clues. | genre-blend, subgenre-sorting, hybrid-horror | ds, tm, st |

**Unit `horror-vocabulary`: Horror Vocabulary and Rules** (prereq: `the-subgenre-map`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hv-01` | The final girl | Explain the final girl and why scholars argue about it. | final-girl, final-girl-debate, scream-queen | mc, st |
| `hv-02` | The rules | Explain the "rules of horror" and meta-horror. | horror-rules, meta-horror, trope-awareness | mc, fg |
| `hv-03` | The monster's shape | Explain the uncanny, the double and the monster as metaphor. | uncanny-valley, doppelganger, monster-as-metaphor, the-other | mc, tm |
| `hv-04` | The haunted place | Explain why houses, woods, hospitals, cabins and hotels work. | haunted-place, cabin-in-woods, isolation, liminal-space | mc, tm |
| `hv-05` | Kills as set pieces | Explain "the kills are the point" as staging and choreography, non-graphically. | kill-as-set-piece, kill-count-culture, gore-vs-suspense | mc, st, ds |
| `hv-06` | Sequel logic and spoilers; capstone | Explain sequel bait and spoiler etiquette in horror. | sequel-bait, twist-ending, horror-spoiler-etiquette | mc, ds, st, tk |

### Layer 2: Intermediate (6 units, 39 lessons)

**Unit `century-of-scares`: A Century of Scares** (prereq: `the-subgenre-map`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cs-01` | Gothic roots and silent shadows | Explain gothic literature's influence and German Expressionist horror. | gothic-literature, expressionist-horror, silent-horror | mc, so |
| `cs-02` | Universal monsters | Explain the 1930s monster cycle and why the monsters are icons. | universal-monsters, monster-kid, dracula-frankenstein-cycle | mc, tm |
| `cs-03` | Implication and atomic monsters | Explain the 1940s-50s: implied horror, sci-fi monsters, Hammer's colour Gothic. | val-lewton-implication, atomic-age-monsters, hammer-horror | mc, so |
| `cs-04` | The 1960s break | Explain how 1960-68 shifted horror to modern settings and the everyday. | modern-horror-turn, psycho-shift, night-of-the-living-dead-1968, code-breakdown | mc, st |
| `cs-05` | The 1970s golden age | Explain the decade's big cycle: possession, occult, slasher seeds, sci-fi horror. | seventies-horror, exorcist-phenomenon, halloween-1978, alien-and-sci-fi-horror | mc, so |
| `cs-06` | The 80s boom and video nasties | Explain the slasher boom, VHS and the UK censorship panic. | eighties-slasher-boom, vhs-horror, video-nasties, satanic-panic | mc, st |
| `cs-07` | Scream and the 90s lull | Explain the meta turn, the 1999 found-footage breakout and the J-horror wave. | scream-1996, blair-witch-1999, ringu-wave, nineties-lull | mc, so |
| `cs-08` | 2000s to now; capstone | Explain remakes, extremity, the Blumhouse model, and the current wave. | remake-cycle, torture-horror-label, blumhouse-model, current-horror-wave | mc, so, st, tk |

**Unit `slashers-and-final-girls`: Slashers and Final Girls** (prereq: `horror-vocabulary`). 6 lessons. (Non-graphic throughout.)

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sf-01` | Where slashers come from | Explain giallo, Psycho and the 1974-78 seeds. | slasher-origins, psycho-influence, black-christmas, halloween-template | mc, so |
| `sf-02` | The template | Name masks, places, holidays, groups and "the rules". | slasher-mask, slasher-setting, holiday-horror, teen-victims | tm, mc |
| `sf-03` | The big names | Match the icons to one idea each. | slasher-icons, michael-myers, jason-voorhees, freddy-krueger, leatherface, ghostface | tm, mc |
| `sf-04` | The final girl debate | Explain Clover's argument, its critics and subversions. | clover-final-girl-thesis, final-girl-subversions, women-in-slashers | mc, st |
| `sf-05` | Meta and subversion | Explain Scream, Cabin in the Woods and self-aware slashers. | meta-slasher, cabin-in-the-woods, self-aware-horror | mc, st |
| `sf-06` | Why slashers stick; capstone | Explain the ritual, the comfort and the franchise appeal. | slasher-ritual, comfort-horror, slasher-revival | mc, st, tk |

**Unit `ghosts-haunts-possession`: Ghosts, Haunts and Possession** (prereq: `the-subgenre-map`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `gh-01` | The haunted house grammar | Explain the haunted-house film and its rules (-> movies:fr-08 mise-en-scene). | haunted-house-grammar, the-house-as-character, ghost-rules | mc, tm |
| `gh-02` | Ghost story vs haunting | Tell a ghost story (a person) from a haunting (a place). | ghost-story-film, haunting-film, revenant | mc, tm |
| `gh-03` | Possession and exorcism | Explain the possession cycle and its faith context, non-graphically. | possession-cycle, exorcist-legacy, faith-tension | mc, st |
| `gh-04` | Occult and satanic panic | Explain the 1970s occult wave and the 1980s panic. | occult-wave, satanic-panic-films, devil-film | mc, so |
| `gh-05` | "Based on a true story" | Explain what the label means, and the Conjuring universe as a franchise. | true-story-marketing, conjuring-universe, paranormal-investigators-trope | mc, st |
| `gh-06` | Quiet ghost stories; capstone | Explain grief-and-ghost films and why quiet ones linger. | grief-ghost-story, quiet-horror, ambiguous-ghost | mc, st, tk |

**Unit `folk-body-and-beyond`: Folk, Body, Cosmic and Undead** (prereq: `the-subgenre-map`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fb-01` | What folk horror is | Explain folk horror: landscape, community, old belief. | folk-horror, rural-isolation, pagan-motif, community-menace | tm, mc |
| `fb-02` | The British trinity and the modern wave | Name the 1968-73 UK trio and the modern folk revival. | unholy-trinity-folk, wicker-man, modern-folk-horror | mc, so |
| `fb-03` | Body horror: fear of the body | Explain body horror as metaphor for illness, change, ageing (non-graphic). | body-horror, cronenberg-ideas, transformation-metaphor, body-anxiety | mc, st |
| `fb-04` | Body horror today | Explain the recent body-horror wave and why it is talked about. | body-horror-revival, ageing-and-body-image, festival-body-horror | mc, tm |
| `fb-05` | Cosmic horror | Explain cosmic horror, Lovecraft (and his racism) and the fear of the unknowable. | cosmic-horror, lovecraft-legacy, lovecraft-racism-context, the-unknowable | mc, st |
| `fb-06` | Zombies, infection and the apocalypse | Explain Romero's satire, 28 Days Later's rage and the Korean train. | romero-satire, rage-virus, zombie-metaphor, apocalypse-horror-modern | mc, so |
| `fb-07` | Mixed: sort five films; capstone | Sort described films into folk/body/cosmic/undead. | subgenre-sorting-advanced, horror-and-metaphor | tm, ds, st, tk |

**Unit `found-footage-and-formats`: Found Footage and Formats** (prereq: `scare-craft`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ff-01` | What found footage promises | Explain the "authentic recording" promise and its critics (-> movies:mc-01 handheld). | found-footage, pov-horror, authenticity-promise, shaky-cam-critique | mc, bc |
| `ff-02` | The lineage | Explain the milestones: 1980 origin, 1999 breakout, 2007 franchise, 2008 monster, screenlife. | ff-milestones, screenlife-horror, mockumentary-horror | so, mc |
| `ff-03` | Anthologies and shorts | Explain the anthology form and the short-film pipeline. | anthology-horror, horror-shorts, short-to-feature | mc, tm |
| `ff-04` | Horror comedy | Explain horror-comedy, parody and camp, and the line between them. | horror-comedy, parody-horror, camp-horror | mc, st |
| `ff-05` | Beyond the feature; capstone | Place series, games and books as context (cross-links). | horror-series-context, survival-horror-games, horror-fiction-context | mc, st, tk |

**Unit `world-horror`: Horror Around the World** (prereq: `the-subgenre-map`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `wr-01` | Giallo | Explain the giallo: mystery, style, gloved killer, the score. | giallo, argento-style, bava-influence, giallo-vs-slasher | tm, mc |
| `wr-02` | J-horror | Explain the long-haired ghost, technology, quiet dread (-> movies:wc-03). | j-horror, onryo, tech-haunting, kwaidan-roots | tm, mc |
| `wr-03` | K-horror and East Asia | Explain the Korean wave in horror and the wider region. | k-horror, korean-social-horror, east-asian-horror | mc, st |
| `wr-04` | Southeast Asia | Explain Thai, Indonesian and Filipino horror and its folklore. | thai-horror, indonesian-horror, folklore-horror, pontianak-ghost | tm, mc |
| `wr-05` | Spain, Latin America and Europe | Explain the Spanish and Latin American wave and the European scene. | spanish-horror, latin-american-horror, nordic-horror, del-toro-gothic | mc, tm |
| `wr-06` | Africa, the Middle East and the diaspora | Explain Nollywood horror, Iranian ghost cinema and diaspora horror. | african-horror, iranian-horror, diaspora-horror | mc, st |
| `wr-07` | How to start; capstone | Pick an entry point in translation and talk about it (subs vs dubs). | subs-vs-dubs-horror, world-horror-entry-points, world-horror-conversation | ds, tk |

### Layer 3: Enthusiast depth (3 units, 18 lessons)

**Unit `horror-debates`: The Big Arguments** (prereq: `century-of-scares`, `the-subgenre-map`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hd-01` | Elevated horror | Explain the term (coined 2017), who likes it and who bristles. | elevated-horror-debate, post-horror-term, prestige-horror-critique | mc, st |
| `hd-02` | Horror as allegory | Explain "horror is always about something" and its limits. | social-horror, allegory-debate, get-out-as-social-horror | mc, st |
| `hd-03` | Censorship and ratings fights | Explain video nasties, MPA fights and ratings lobbying (non-graphic). | video-nasty-history, mpa-horror-fights, censorship-debate | mc, so |
| `hd-04` | Remakes and legacy sequels | Explain the remake cycle, requels and fan reaction. | remake-debate, requel, nostalgia-horror | mc, st |
| `hd-05` | Who lives, who dies | Explain representation: tropes, subversions and creators. | representation-in-horror, dies-first-trope, women-directors-horror, queer-horror-reading | mc, st |
| `hd-06` | "Torture porn" and extremity | Explain the label, the critique and the debate (no descriptions of content). | torture-porn-label, extremity-debate, taste-limits | mc, st |
| `hd-07` | Scary vs good; capstone | Separate scary, good, fun and important. | scary-vs-good, guilty-pleasure-horror, best-of-lists | ds, st, tk |

**Unit `effects-and-craft`: Effects and Craft** (prereq: `scare-craft`; `movies:formats-and-debates` helpful). 5 lessons. Craft angle only.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ec-01` | Practical effects, explained | Explain prosthetics, makeup, animatronics, puppets (-> movies:fd-02). | practical-effects-horror, prosthetic-makeup, animatronics, puppetry | mc, tm |
| `ec-02` | The golden age of makeup effects | Name the 1980s effects renaissance and why "seams" matter. | effects-renaissance, creature-effects-legacy, visible-seams | mc, so |
| `ec-03` | CGI, hybrid and virtual | Explain when digital helps or hurts horror. | cgi-horror, hybrid-effects, digital-de-aging-horror | mc, bc |
| `ec-04` | Sound and score craft | Name Foley, sound designers and horror composers as craft roles. | foley-horror, sound-designer-role, horror-composer-role | mc, li |
| `ec-05` | Production design and creature design; capstone | Explain set design, creature design and the reveal. | horror-production-design, creature-design-process, reveal-craft | mc, st, tk |

**Unit `horror-culture`: Fans, Festivals and Spooky Season** (prereq: `what-is-horror`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hc-01` | The fan world | Name Fangoria, Shudder, fan sites, conventions, horror hosts. | horror-fan-culture, fangoria, shudder-platform, horror-host | mc, tm |
| `hc-02` | Festivals | Tell Fantasia, Fantastic Fest, Sitges, FrightFest, Midnight Madness apart. | fantastic-fest, sitges, fantasia-festival, frightfest, midnight-madness | tm, mc |
| `hc-03` | Spooky season | Explain the October marathon and the calendar (Friday the 13th, anniversaries). | spooky-season, october-marathon, friday-13th-culture, cozy-horror | mc, ds |
| `hc-04` | Physical media and collecting | Explain boutique labels, VHS revival and steelbooks. | boutique-labels, vhs-revival, horror-collecting | mc, st |
| `hc-05` | Horror and awards | Explain how the Oscars treat horror and the exceptions. | oscars-and-horror, silence-of-the-lambs-1991, horror-awards-circuit | mc, so |
| `hc-06` | The business of low budgets; capstone | Explain why horror is cheap, profitable and risky. | horror-economics, micro-budget-horror, box-office-overperformance | mc, es, st, tk |

### Layer 4: Branches / personalization (3 branch-layer units, 15 lessons)

Branch units set `branchId`; a learner sees the ones matching their chosen branches (default `slasher-franchise`). Branch units are talk-about units: they never require watching.

**Unit `branch-slasher-franchise`: Slashers and Franchises** (branch `slasher-franchise`; prereq: `slashers-and-final-girls`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bs-01` | Why horror loves sequels | Explain why franchises are cheap and durable. | horror-sequel-economics, franchise-brand, sequel-numbering | mc, bc |
| `bs-02` | Which order do I watch? | Explain release vs chronological vs "skip these" and timelines. | horror-watch-order, timeline-branches, retcon-horror | ds, mc |
| `bs-03` | The big sagas | Match the sagas to one idea each (Halloween, Friday the 13th, Nightmare, Scream, Saw, Final Destination, Child's Play, Evil Dead). | saga-identities, saw-franchise, final-destination-premise, evil-dead-saga | tm, mc |
| `bs-04` | Building universes | Explain shared universes in horror (Conjuring, Universal's monsters, crossovers). | horror-universe, monsterverse-context, crossover-horror | mc, st |
| `bs-05` | Fan talk; capstone | Decode "legacy sequel", "requel", "retcon", "best entry". | fan-ranking-culture, requel-vs-reboot, best-entry-debate | st, tk |

**Unit `branch-elevated-dread`: Elevated Dread** (branch `elevated-dread`; prereq: `horror-debates`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `be-01` | How to sit with a slow film | Explain pacing, patience and where to look. | slow-film-viewing, patience-in-viewing, sound-first-viewing | ds, mc |
| `be-02` | Directors of dread | Name what is distinctive about six modern directors. | dread-directors, aster-style, eggers-style, peele-style, flanagan-style, cregger-style | tm, st |
| `be-03` | Grief, trauma and family horror | Explain how grief and family are used as horror engines. | grief-horror, family-horror, trauma-horror-label | mc, st |
| `be-04` | Ambiguity and endings | Explain ambiguous endings and reading them. | ambiguous-ending, reading-endings, unresolved-horror | ds, mc |
| `be-05` | The label map; capstone | Explain A24, Neon, Shudder, Blumhouse as taste brands. | a24-horror, neon-horror, blumhouse-brand, distributor-brand-horror | mc, tk |

**Unit `branch-practical-and-body`: Practical Effects and the Body** (branch `practical-and-body`; prereq: `effects-and-craft`). 5 lessons. Craft angle only.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `bp-01` | The artists | Name key effects artists and what each was known for. | effects-artists, savini-savini-legacy, baker-bottin-winston, modern-effects-houses | tm, mc |
| `bp-02` | How an illusion is built | Explain sculpt, mould, cast, paint, puppeteer as a pipeline. | effects-pipeline, sculpt-mould-cast, puppeteering | so, mc |
| `bp-03` | The Thing and other benchmarks | Explain why a 1982 creature film is a benchmark and what makes a creature "read". | creature-benchmark, transformation-effects, shot-vs-hidden-effects | mc, st |
| `bp-04` | Body horror as metaphor and craft | Explain body horror as idea and technique. | body-horror-craft, prosthetic-transformations, metaphor-and-technique | mc, st |
| `bp-05` | Documentaries and fan talk; capstone | Explain making-of culture and effects fandom. | making-of-culture, effects-fandom, behind-the-scenes-talk | mc, tk |

### Layer 5: Current-season / live layer (1 unit, 6 lesson templates)

**Unit `now-in-horror`: Now in Horror** (prereq: `what-is-horror`; never locked behind other units). 6 templated lessons refreshed weekly/seasonally (daily in October) through `live` hooks; new cards ship without an app release. Every card has an intensity line that respects the comfort dial.

| Lesson id | Title | Objective | conceptIds | Activities | `live` hook |
|---|---|---|---|---|---|
| `lv-01` | New in horror this week | Know what opens and what kind of scary each promises. | horror-release-literacy, subgenre-sorting | mc, st | `live.releases.horror` |
| `lv-02` | The horror box office | Read a horror weekend: budget, opening, legs. | horror-economics, box-office-overperformance | mc, st | `live.rankings.boxoffice` |
| `lv-03` | Festival dispatch | Explain what the latest horror festival buzz means. | fantastic-fest, sitges, midnight-madness | mc, st | `live.events.festivals` |
| `lv-04` | What to stream this spooky season | Explain the platforms and the "gentle picks" list. | shudder-platform, spooky-season | mc, st | `live.newmedia.streaming` |
| `lv-05` | Horror in awards season | Explain who is being talked about and why. | oscars-and-horror, horror-awards-circuit | mc, st | `live.events.awards` |
| `lv-06` | Why is everyone talking about this? | Decode the week's biggest horror conversation. | editorial-context | st, tk | `live.news.explainer` |

### Layer 6: Conversation practice and perpetual review (2 units, 13 lessons)

**Unit `conversation-lab`: Conversation Lab** (prereq: any foundation unit; unlocks progressively). 8 lessons. Continuous: new talk tracks added seasonally; also surfaces in the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cl-01` | After the credits | Ask how she felt, not what happened. | post-scary-movie-questions, horror-spoiler-etiquette | tk, st |
| `cl-02` | "I don't watch these, but tell me" | Show curiosity without watching. | appreciate-not-watch, comfort-dial, no-shame-rule | tk, st |
| `cl-03` | Picking a first shared watch | Suggest something gentle and honest, with a rating check. | first-shared-watch, gentle-horror-picks, film-ratings-literacy | tk, ds |
| `cl-04` | You screamed? | Handle your own scare and hers, kindly. | scare-etiquette, humour-and-fear | tk, st |
| `cl-05` | When she gushes about a director | Ask about the filmography, not the gore. | dread-directors, signature-style-horror | tk, st |
| `cl-06` | Spooky season plans | Join an October marathon without faking. | spooky-season, october-marathon | tk, ds |
| `cl-07` | Disagree kindly | Disagree about "scary vs good" without a fight. | scary-vs-good, specific-praise-horror | tk, ds |
| `cl-08` | Mixed conversation review | Decode five mixed lines. | mixed | st, tk |

**Unit `fright-review`: Fright Review (perpetual review)** (prereq: none; auto-populates). 5 lessons of mixed sets drawn by the review policy from mastered concepts; audio items appear only for levels that allow them, else their text twins.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rv-01` | Term blitz | Rapid recall of horror terms. | mixed | tm, fg, mc |
| `rv-02` | Sort the subgenre | Recognise subgenre promises from a description. | subgenre-sorting, horror-promises | tm, mc, vi |
| `rv-03` | Scare-craft refresher | Refresh dread, implication, light and sound. | dread-vs-jump-scare, implication, low-key-horror | vi, ht, bc |
| `rv-04` | Eras and festivals timeline | Reorder eras and the festival calendar. | mixed | so, mc |
| `rv-05` | Director and franchise adjectives | Match adjectives to directors and sagas, and decode a line. | dread-directors, saga-identities | tm, st |

### Review policy

Spaced review: intervals 1, 3, 7, 21, 60 days; a concept enters the pool when mastery first reaches 0.8; decays -0.15 on a miss; maximum 12 review items per session; time-sensitive concepts (awards facts, current release slates, festival results) have a 90-day freshness flag and are re-verified before appearing; **intensity-flagged items are served as their text twin whenever the comfort dial is `gentle`, and are never re-served after a learner skips them twice**.

### Also

- **Concept count target (Playbook):** ~354 concept ids (many single-idea items grouped in the Playbook by unit); Playbook terms shown in the app grouped by unit; 60+ terms authored as samples (`exercises.md`).
- **Personalization slots:** `{{genre}}`, `{{director}}`, `{{franchise}}`, `{{platform}}`, `{{region}}` plus the comfort dial (section 8).
- **Release plan:** *v0.1.0 launch:* `what-is-horror`, `scare-craft`, `the-subgenre-map`, `horror-vocabulary`, `century-of-scares`, `slashers-and-final-girls`, `horror-debates`, conversation lab (first 12 tracks), review. *v0.2:* `ghosts-haunts-possession`, `folk-body-and-beyond`, `world-horror`, `horror-culture`, `branch-slasher-franchise`, live unit (curated cards, first seasonal run in September-October). *v0.3:* `found-footage-and-formats`, `effects-and-craft`, the other two branch units, licensed availability provider. **Seasonal:** intensive live updates each September-October (spooky season), festival cards each July (Fantasia), September (Fantastic Fest) and October (Sitges), awards cards each January-March, a Friday-the-13th card whenever one falls.

---

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4). **Zero Unity sims. Everything is native.**

| Lesson / activity family | Concepts | Type (native exercise or `unity-sim`) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Subgenre map, promises, eras, franchises, festivals, vocabulary | subgenre-overview, slasher-film, giallo, j-horror, final-girl, saga-identities | `multiple-choice`, `term-match`, `fill-the-gap` | Recall and sorting; text is optimal (rubric "Recall, terms, order: native"). | B | ~300 |
| Eras, jump-scare timeline, production of an illusion, awards and festival calendar | jump-scare-anatomy, cold-open, effects-pipeline, hc festivals | `sequence-order` | Order is the concept. | B | ~35 |
| Scare-craft recognition: negative space, silhouette, low-key, wide-frame dread | negative-space, low-key-horror, silhouette, wide-frame-dread | `visual-id` on **original technique illustrations** (`original-swoond`) | Recognition is the skill; original abstract figures avoid unlicensed stills and, importantly, **avoid frightening imagery entirely**. | B | ~50 |
| Frame anatomy | negative-space, off-screen-threat | `hotspot-tap` (procedural diagram) | Tap where the viewer's eye is *not* being guided; static diagram, no motion. | B | ~25 |
| Two-way calls | dread-vs-jump-scare, horror-vs-thriller, remake-vs-requel | `binary-call` (scene kind `none`) | Two-way call, no scene needed. | B | ~30 |
| Horror sound and score demos (original, synthesised, calm) | drone, silence-in-horror, dissonance, wrong-lullaby | `listening-id` | Audio is the concept (spec section 20). **Comfort-gated**: skip anytime, text twin, intensity preview, `gentle` replaces with described version. No sudden loud sounds in `balanced`; capped mild stingers only in `full`, with confirm. | B | ~18 |
| Runtimes, budgets, box-office multiples, year counts | horror-economics, box-office-overperformance, ratings-literacy | `estimate-slider` | A number is the lesson. | B | ~20 |
| Judgment: what to say, what to suggest, how to say no | comfort-dial, first-shared-watch, horror-spoiler-etiquette, appreciate-not-watch | `decision-scenario` | Judgment with consequences and an expert note. This is the course's core social skill. | B | ~40 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice. | B | 24 talk tracks + ~90 say-this |
| Timing | - | `timing-tap` | **Not used.** A scare-timing bar would frighten the learner as gameplay. | B | 0 |

**Why no Unity (the honest justification).** Rubric test: does spatial reasoning, movement, physics, timing in a scene or camera perspective *materially* improve learning, and would a native exercise teach it clearly worse? For horror, the answer is no.

- The concepts that need camera perspective and movement (lens compression, dolly zoom, the 180-degree rule) are already taught in `movies` by `film.camera.lens-and-move.v1` and `film.camera.axis-line.v1`; horror lessons link to them (`sc-03`, `sc-05`, `ff-01`). Duplicating them would violate the "don't re-teach film language" hand-off.
- Horror's own concepts are perceptual (dread, implication, sound, light) or cultural (canon, fights, fandom). Perception of a scare's *structure* is taught adequately by a labelled timeline (`sequence-order`), an original diagram (`visual-id`, `hotspot-tap`) and an optional calm audio cue (`listening-id`).
- The one horror-native sim idea, "a jump-scare timing or stealth sim", is rejected on a **comfort ground stronger than the rubric**: a simulation that *scares the learner as gameplay* forces exposure to the thing the course promises not to force. It also tempts kill-count gamification (section 5).

Considered and rejected for Unity (recorded so Astra is not asked again): **jump-scare timing sim** (comfort and gamification), **haunted-house floor-plan explorer** (spatial, but recognition of house grammar is served by a static plan `hotspot-tap` and the concept is cultural), **light-and-shadow sandbox** (already rejected in `movies` for the same reason: `visual-id` on original technique cards is adequate), **found-footage camera-shake demo** (motion sickness risk; `mc` on shaky-cam critique is enough), **spatial-audio sound-design lab** (would need scary audio; `listening-id` covers it gently). Native accessibility fallbacks are not needed for sims; instead the **text twin** convention (section 8) is the equivalent commitment for `listening-id`.

---

## 13. Licensing and safety

| Area | Handling |
|---|---|
| **Posters / key art / stills / frames / screenshots / mask or monster images** | **Never used.** Rights-holders' works; even "public" images are not redistributable (rule 10). All illustrations are original technique art (`original-swoond`); none depicts a monster, injury or frightening scene. Film titles appear as text. |
| **Trailers / clips / video** | Never embedded, hosted or re-cut; "watch the trailer" is a link-out to an official channel, never autoplay, and **not surfaced at all at `gentle`**. |
| **Score / soundtrack / sound effects from films** | Never used. Listening exercises use original or synthesised cues written to demonstrate a *concept* (a drone, a silence, a dissonant cluster, a lullaby played wrong), never imitating a specific famous theme or stinger. Score and composer names as text only. Public-domain works (for example 1920s silent films) are still linked, not hosted. |
| **Dialogue and quotes** | No script or subtitle text. Famous lines are referenced by film title and a short factual paraphrase only. |
| **Publisher, review and "parents guide" text** | Never copied. Swoon'd writes its own one-sentence descriptions; content-intensity notes are our own words plus a link-out to the official ratings board. |
| **Ratings data** | Rotten Tomatoes, Metacritic, CinemaScore, IMDb, Letterboxd and parents-guide sites are provider-owned or user-generated: no scraping or mirrored tables. |
| **Names, likeness, trademarks** | Actor/director names as facts; no likeness; no endorsement. Franchise names, studio and label logos (A24, Neon, Blumhouse, Shudder, Fangoria, Arrow, Scream Factory) are trademarks: text-only. "Halloween", "Friday the 13th" as titles are used descriptively. |
| **Data provider terms** | As `movies/live-data.md`: TMDB non-commercial without agreement, OMDb CC BY-NC, IMDb datasets non-commercial, Letterboxd refused for recommendation/LLM. None used before a licence. Wikidata (CC0) and Wikipedia (CC BY-SA, attribute) fine. |
| **Legal viewing** | Never suggest piracy. "Where to watch" only from licensed availability data or a "check your services" fallback. |
| **Violence and gore** | **Always non-graphic**, at every comfort level: "a violent death", never method, wound or injury detail. Kill scenes are taught as staging, timing and craft (`hv-05`). No gore images, ever. |
| **Sensitive topics** | Suicide, self-harm, child harm, sexual violence, animal harm and mental illness appear only as *topic names* in content-note literacy; each lesson naming one carries a content-note line and can be skipped without loss. Portrayals of mental illness, disability, race and gender in genre history are taught in plain factual text with context. *Cannibal Holocaust* and other films with real-animal-harm histories are named only as milestones with a factual one-line note. |
| **Real crimes and hauntings** | "Based on a true story" is taught as marketing; no dramatisation of real victims or real cases; the Warrens/Conjuring lesson describes claims as claims. |
| **Comfort and wellbeing** | Comfort dial, skip-without-penalty, text twins, no courage rewards (section 5, 8). Audio: loudness-capped (normalised, peak below -6 dBFS in `balanced`), no sudden peaks in `balanced`, no infrasound content. Photosensitivity: no flashing; no strobe. Age: R-rated titles are not pushed at readers of unknown age; ratings literacy is taught. **If a learner indicates distress in free-text (future feature), the app links to general support resources; horror teaching is never a substitute for care.** |
| **Voice/people** | Jokes target the learner's own squeamishness affectionately or their ignorance, never the crush; never mock a fandom, a taste or a low tolerance; never gatekeep ("real horror fans"). |

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Scare-craft technique illustrations (negative space frames, silhouette, low-key/high-key diagrams, wide-frame dread, sightline diagrams) | Original vector art (abstract, non-frightening) | Swoon'd | `original-swoond` |
| Subgenre "promise cards" (icon-and-label cards, no monsters) | Original vector | Swoon'd | `original-swoond` |
| Timeline art (eras, jump-scare anatomy, festival calendar) | Procedural typography | Swoon'd | `original-swoond` |
| Original calm audio cues: drone, silence, wrong-lullaby, dissonant strings (synthesised) plus a few capped mild stingers for `full` | Original composition/synthesis | Swoon'd | `original-swoond` |
| Haunted-house floor plan, cabin-in-woods map (top-down) | Procedural | Swoon'd | `original-swoond` |
| Film posters, stills, trailers, clips, score, monster imagery, dialogue | **Not used** | - | - |

---

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Horror as feelings; how scares are built; the subgenre map; vocabulary and rules; that comfort is a legitimate way in (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Craft, subgenres, directors, franchises, effects, fights (elevated, remakes, representation), festivals, fan culture (section 4).
- [x] 3. **What current information matters?** Release slate, box office, festivals, awards, streaming, editorial explainers, intensity lines (section 6).
- [x] 4. **What should be interactive?** Native recognition on original diagrams, order, gentle listening, decision, conversation; zero Unity (section 12).
- [x] 5. **What should NOT be gamified?** Courage, gore, taste, real crimes, sensitive portrayals, piracy, awards gambling (section 5).
- [x] 6. **How should it personalize?** genre, director, franchise, platform, region, comfort dial; three branches (sections 1, 8).
- [x] 7. **What does conversational competence look like?** Decode her lines, ask curious follow-ups, admit gaps, honour comfort (sections 9, 10).
- [x] 8. **What data providers are needed?** Curated editorial + Wikidata at launch; licensed availability later (`live-data.md`).
- [x] 9. **What licensing constraints apply?** No posters/stills/clips/score/quotes/review text; non-graphic rule; provider terms (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, text-twin equivalence, review ladder, talk-track Smooth >= 60, Say-It check, competence statement (section 10).

Additional gates: [ ] manifest validates (run `tools/validate`); [ ] curriculum validates (not yet authored); [x] no Unity sims, none required; [ ] every image/audio asset has a license id (assets not yet produced; id `original-swoond`); [ ] voice review; [x] no copied publisher text; [ ] content-comfort review by a sensitivity reader (NOTES item 4).

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Confirm horror stays independent of `movies` (recorded in the movies CDS); this CDS proceeds on that basis. | Product | No |
| 2 | **Comfort dial as a profile field**: where does it live (Person-interest profile), and what does the curriculum contract need (an activity-level `intensity`/`comfortTier` tag plus a `textTwinOf` reference)? Both need a schema change (NOTES item 2). | Product / Architecture | Blocks authoring of `gentle` twins |
| 3 | Unit count 19 vs 8-14 guidance. Proposed fold if wanted: `found-footage-and-formats` into `folk-body-and-beyond`, `effects-and-craft` into `horror-culture` (17 units). | Product | No |
| 4 | Sensitivity read (S-series): wording of content notes, the true-story lesson, the representation and extremity lessons, and the "gentle" copy. | Content / SME | No |
| 5 | Television candidate course (shared with movies NOTES item 6). | Product | No |
| 6 | Original-audio production for `listening-id` (~18 cues, calm; capped mild stingers optional): compose in-house vs synthesise vs commission; loudness spec. | Product | No (fallback: text twins only) |
| 7 | Intensity line source: only own words plus official ratings-board link-out; is that enough for a useful "how intense" signal, or is a licensed content-advisory provider desirable? | Product / Legal | Blocks automation |
| 8 | Facts to re-verify before release: 98th Oscars (15 Mar 2026) horror results (*Sinners* record 16 nominations, four wins: Best Actor, Original Screenplay, Original Score, Cinematography; *Weapons* Best Supporting Actress; *Frankenstein* three craft wins; Best Picture went to *One Battle After Another*), Sitges 8-18 Oct 2026, Fantastic Fest 2026 dates, 2025 horror box-office leaders (*The Conjuring: Last Rites* the year's top horror by most counts; figures differ by source), fall 2026 slate (Resident Evil, Clayface, V/H/S/Mixtape...), platform ownership (Shudder/AMC Networks). | Content | No (live layer only) |
| 9 | Should "spooky season" content run a dedicated seasonal collection surface (Sept 1 - Nov 1)? | Product | No |
