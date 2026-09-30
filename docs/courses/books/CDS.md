# Course Design Specification: Books (`books`)

Implements `docs/courses/CDS_TEMPLATE.md` (product spec section 8 plus curriculum planning and the section 47 quality gate). Time-sensitive facts were checked by web search on **2026-09-30** and are tagged **[verify at release]**; none of them is hard-coded in evergreen lessons (they live in `live-data.md` as dated data).

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Claude (Sonnet 5.5) / 2026-09-30 |
| Manifest | `manifest.json` |

---

## 1. Identity
- **Course ID:** `books` (immutable)
- **Display name:** Books
- **Category / family:** Books & Literature > Books
- **Simulation prefix:** `books` (reserved; no sims, see section 12)
- **Related courses & boundary test (spec section 6):**

| Related interest | "If someone learns Books, are they conversationally competent about it?" | Verdict | Consequence |
|---|---|---|---|
| Movies (`movies`) | Partly. They can discuss the source novel, the adaptation debate and "the book was better", but not film language (shots, cuts, score). | adjacent | `series-and-adaptations` teaches the adaptation conversation only; cross-link to `movies` for film craft. |
| Video Games (`video-games`) | Partly. Fantasy and sci-fi shelves share worldbuilding and franchise talk (a reader of a fantasy series often plays its game). Game mechanics, platforms and genres do not transfer. | adjacent | Shared concept ids for `worldbuilding`, `shared-universe`, `retelling` may be cross-linked; no merge. |
| Music (`music`) | No. Fandom rhythms look similar (eras, releases, tours vs book tours) but knowledge does not transfer. | adjacent | Cross-link on "release-week" habits only. |
| Anime (`anime`, Wave 3) | Partly for light novels and manga readers. Manga and comics have their own formats (volumes, chapters, publishing cycles). | sibling-independent | Books teaches prose reading culture; comics and manga get their own course. |
| Poetry, comics, manga, textbooks (not catalogued) | No. Different forms, canons and communities. | independent | Out of scope; mention as "the shelf next door" in `books-and-editions` only. Candidate future courses (see NOTES). |
| Writing / creative writing | Partly. Story craft vocabulary transfers; workshop culture and craft practice do not. | independent | `story-craft` teaches the reader's vocabulary, not how to write. |
| Individual genres (romance, fantasy, mystery...) | Learning "Books" does give a person genre-map literacy. It does not make them a romance-community insider or a fantasy-lore fan. | shares foundation | Six genre **branches** (below) that go deeper on culture and vocabulary. A deep single-genre reader with an ultra-specific interest (for example one long fantasy series) is served by the `franchise` and `author` personalization, not a new course. |

- **Branches** (choosing one sets the `genre` personalization dimension; units of layer `branch`):

| Branch id | Name | What changes (rules, data, culture) |
|---|---|---|
| `literary-fiction` | Literary fiction | Style, interiority and ambiguity valued over plot; prize culture; translated fiction; MFA and short-story world; the "literary vs genre" debate. |
| `romance-romantasy` | Romance and romantasy | The genre contract (HEA / HFN), tropes as pleasure, heat levels, BookTok economy, romantasy boom, a fiercely loyal community with a "respect gap". |
| `fantasy-scifi` | Fantasy and science fiction | Subgenre maps, magic systems, worldbuilding, doorstop series and the wait, fandom canon, Hugo/Nebula. |
| `thriller-mystery` | Thriller and mystery | Whodunit vs thriller vs howcatchem, fair play, twists, cozy vs noir, the psychological-thriller wave, crime awards. |
| `nonfiction` | Nonfiction | Memoir ethics, narrative nonfiction, popular science and history, self-help, essays; reading claims critically. |
| `classics` | Classics | What earns "classic", editions and translations, public domain, reading strategies, retellings, dark academia, canon debates. |

Default when unset: no branch unit is shown until the learner picks one (or the Person's `genre` is set); core units use examples across all six shelves.

## 2. Beginner model
- **What a complete beginner (a non-reader, or a reader of one shelf) knows:** books exist, some are famous ("Harry Potter", "Pride and Prejudice"), movies are made from them, the school reading list, maybe the words "bestseller" and "Kindle". They may have read for school and formed the belief that reading is homework, or they read one genre (thrillers at the airport) and assume that is "reading".
- **Terminology that initially confuses:** TBR, DNF, ARC, "spicy", "open door", trope, "enemies-to-lovers", HEA, romantasy, cozy, grimdark, "literary", "the discourse", "book hangover", "reading slump", "tabbing", "buddy read", "comp title", "backlist", "shortlist vs longlist", "unreliable narrator", "close third", "dual timeline", "standalone", "duology", "hardcover vs trade paperback", "special edition", "sprayed edges", "Booker".
- **Common misconceptions (each becomes distractors and a myth-buster lesson):**
  1. "Literary fiction is just good books and genre fiction is bad books" (it is a shelving and emphasis distinction, and the best books blur it).
  2. "A real reader finishes every book" (DNF is a normal, healthy practice for most enthusiasts).
  3. "Audiobooks do not count as reading" (a live debate; most readers say they do).
  4. "Romance is one formula, so all romance is the same" (the HEA contract is the constant; subgenre, heat, trope and voice vary enormously).
  5. "Number of books read is the score" (challenges are fun, but reading count is not quality).
  6. "The Booker or Pulitzer means it is the best book of the year" (prizes are judged by a small panel, with eligibility rules and taste).
  7. "A movie adaptation replaces the book" / "the book is always better" (an adaptation is a different medium doing different work).
  8. "Goodreads stars are objective" (ratings are skewed by fandom, release-week pile-ons and different star philosophies).
  9. "Romantasy is just fantasy with a love story" (it puts the romance arc at the structural centre; the fantasy world serves it).
  10. "You should recommend the best book you know" (the best rec fits her taste and mood, not the book's reputation).
  11. "A classic must be a slog" (many classics are page-turners; edition and translation change the experience).
- **Concepts that unlock the rest (foundation units):** book formats and editions; reader shorthand (TBR, DNF, tropes); story craft vocabulary (POV, unreliable narrator, structure, pacing); genre as a promise; how readers find books together (book clubs, BookTok, tracking apps).

## 3. Foundational knowledge
Grouped into modules (`foundationalModules[]` and foundation units).

1. **`books-and-editions` - How Books Work.** Formats (hardcover, trade paperback, mass-market paperback, ebook, audiobook), book anatomy (dust jacket, spine, title page, colophon, epigraph, acknowledgements), editions vs printings, ISBN, length categories (novel, novella, short story, collection, omnibus), series vs standalone and reading order, where books live (libraries, indies, chains, online), and the fiction/nonfiction line and its fuzzy middle.
2. **`reader-language` - How Readers Talk.** TBR/TBR pile, DNF, ARC, reading slump, book hangover, mood reading, rereading and comfort reads, star ratings and what a 3 means, spoiler etiquette and content warnings, annotating and tabbing, reading challenges and readathons.
3. **`story-craft` - The Craft Vocabulary.** Plot vs story vs theme, character and arc, point of view (first, close third, omniscient, second), tense and voice, the unreliable narrator, structure (acts, dual timeline, frame story, nonlinear), setting and worldbuilding, pacing/hooks/cliffhangers, show-don't-tell and prose style.
4. **`genre-map` - Genre as a Promise.** Genre vs category vs shelf, the fiction genre map and subgenres, age categories (middle grade, YA, new adult, adult), tropes and how they differ from clichés, cross-genre and shelving, and the literary vs genre debate.
5. **`reading-life` - How Readers Find Each Other.** Book clubs (formats, discussion questions), celebrity and media book clubs, BookTok/Bookstagram/BookTube and the influencer effect, tracking apps (Goodreads, The StoryGraph, Hardcover, Fable), buddy reads, libraries as culture (holds, Libby).

## 4. Enthusiast model
- **What enthusiasts talk about:** what they are reading now, what they DNF'd and why, their TBR guilt, tropes they will follow anywhere (and ones they will not), favourite authors and "auto-buy" authors, series they are waiting on, prize lists and predictions, adaptation casting, cover redesigns, special editions, reading stats (StoryGraph year-in-review), library holds, the book that "ruined" them, favorite characters and ships, and which bookstore has the best staff picks.
- **Distinctions that matter to them:** plot-driven vs character-driven; standalone vs series; closed-door vs open-door; hard vs soft magic; cozy vs grimdark; fair-play mystery vs twist-for-twist's-sake; first vs third person; single vs dual POV; translated vs original; ebook vs audio vs print; hardcover vs paperback; ARC vs finished copy; "read" vs "skimmed" vs "DNF at 40 percent".
- **Knowledge that signals genuine understanding:** naming what a book *does* (its promise) rather than summarising it; knowing why a trope satisfies (not just its name); mood-matching recs; knowing that a longlist is not a shortlist; understanding that an author's debut, sophomore and backlist have different marketing lives; knowing what "auto-buy" and "comp title" mean; separating the author from the narrator.
- **Beginner statements that sound uninformed:** "I don't really read, but I saw the movie"; "Isn't that just a trashy romance?"; "I only read real literature"; "I never finish books"; "Fantasy is for kids"; "I'll just read the Wikipedia summary"; "Is that the one with the guy from the movie?"; "I love reading, I read 100 books a year" (said as a brag); "Audiobooks are cheating"; "The movie was better" said to a book person mid-sentence; "Which is the best book ever?"
- **Controversies and debates (explained neutrally, no verdicts):** does an audiobook count; is DNF fine; spice content on shelves and in reviews; "BookTok made me buy it" and algorithm-driven sales; illustrated "cartoon covers" for adult romance; authors and AI training/AI-generated books; book banning and challenges; prize politics and canon; whether "literary" is a genre; sequels that never arrive; adaptations diverging; star-rating inflation and review-bombing; Amazon's role (Goodreads owner, Kindle Unlimited, the Big Five squeeze); reading "on the schedule" vs a slow read.

## 5. Interaction model
- **What the learner EXPERIENCES:** decoding an enthusiast line ("I DNF'd it at 40 percent, the pacing killed me"), matching a trope to its promise, sorting a shelf into genres, mapping a story's structure, spotting the POV or the unreliable narrator in an *original* short passage written by Swoon'd, deciding what to recommend, ordering the steps of how a book is published, and practising the conversation.
- **Unity?** **No. Zero sims.** Spatial reasoning, movement, physics and camera perspective are not concepts in this subject; reading culture is vocabulary, taste, judgment and conversation, which native exercises teach best (rubric in `CLAUDE.md`). Five ideas were considered and rejected, see section 12.
- **Native mix:** say-this and talk-track (the heart of the course), term-match and fill-the-gap for vocabulary, multiple-choice and binary-call for distinctions, decision-scenario for recommendation and etiquette judgment, sequence-order for publishing and story structure, hotspot-tap and visual-id on *original* diagrams and illustrations (book anatomy, shelf, shelving), estimate-slider for magnitudes (book lengths, print runs, prize money). No listening-id (audiobook and narration audio is copyrighted; see section 13).
- **What should NOT be gamified:** taste (there is no right favourite book), what a person "should" read, the reading count, sensitive content (censorship, sexual content is taught as labelling and preference, never scored), the emotional weight of memoir and grief lit, and any "reading level" ranking of a person. Never grade a learner's opinion of a book.

## 6. Dynamic information requirements
Books have no scores or standings (spec section 10: do not invent live needs). There **is** a modest but real current-context layer:

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| `releases` | Yes | "What is out this Tuesday" (US pub day) is a natural conversation starter; her favourite author's next book | Swoon'd curated calendar (editorial); Open Library (bulk dumps, own snapshot); Hardcover API (terms to confirm); Wikidata (CC0) | weekly | Evergreen "how release week works" card |
| `events` | Yes | Prize seasons (Booker, Nobel, National Book, Hugo, Pulitzer, Women's Prize), festivals, readathons | Official prize sites (curated dates); Wikidata (CC0) | daily in prize weeks, else weekly | Evergreen prize-mechanics card |
| `rankings` | Light | Bestseller lists explained (what a list measures); link-out only | NYT Books API (commercial terms to confirm), Publishers Weekly, Amazon charts (link only) | weekly | "How to read a bestseller list" |
| `news` | Yes | "Why is everyone talking about this book today?" (adaptation casting, prize upsets, bans) | Publisher/trade RSS headlines (link-only); Swoon'd writes the explainer | daily | Evergreen explainers |
| `new-media` | Optional | Book-to-screen adaptation announcements and release dates | Curated; official studio announcements (link-only) | weekly | Hidden |
| `statistics` | Optional | Industry snapshots (print sales, format share) as dated facts | Curated with source and date (Circana/NPD data is licensed; do not mirror) | seasonal | Skip |

Structured data (release dates, prize dates) and editorial data (explainers) are separate systems. Full plan, licensing and the three book-metadata providers (Open Library, Google Books API, ISBNdb) in `live-data.md`.

## 7. Editorial context
- **What commentary helps:** why a book is being discussed now (prize longlist, adaptation trailer, BookTok surge, author news, challenge or ban), what a prize shortlist tells you (and does not), what a bestseller list measures, why a trope is having a moment, and how to talk about a book you have not read.
- **Sources and rights:** trade press (Publishers Weekly, Publishers Lunch, Shelf Awareness, Kirkus, Locus for SFF, Lit Hub, The Guardian books) and official prize sites, **link-only**. **Publisher blurbs, jacket copy, excerpts, reviews and cover images are never reproduced** (spec section 40).
- **Approach:** `explain-and-link`. Swoon'd writes 60-120 words in its own voice tied to concept ids; links out to the original.
- **Example prompts:** "Why are readers arguing about this cover?", "What is a longlist and why does this one matter?", "Why is everyone reading romantasy?", "What does 'adapted from a novel' change?", "Why did this book get challenged?".

## 8. Personalization
| Dimension | How it changes examples and live context | Default | Tokens / units |
|---|---|---|---|
| `genre` (branch) | Which branch units are shown; which release/prize cards rank first; examples in shared units lean toward this shelf. | none (mixed shelves) | `{{genre}}` in `reader-language`, `taste-and-recs`, `book-talk-lab`, live cards |
| `author` | Release/news cards for that author; conversation openers ("I heard {{author}} has a new one out"); "first book to try" lessons. Never fabricates opinions about the author. | a fictional demo author in evergreen copy | `{{author}}` in `taste-and-recs`, `series-and-adaptations`, `book-talk-lab`, `on-the-shelf-now` |
| `franchise` (series or universe) | Series reading-order and wait-culture examples; adaptation cards. | none | `{{franchise}}` in `series-and-adaptations`, live cards |
| `platform` (print, Kindle, Kobo, Libby, Audible, Bookshop.org) | Wording and link-outs ("place a hold in Libby"); lesson on format choices. | "your library app or bookstore" | `{{platform}}` in `books-and-editions`, `reading-life` |
| `region` | Release dates (US Tuesday vs UK Thursday), prize eligibility (Booker vs Pulitzer), local indie bookstores and library systems. | region-neutral, US publication-day wording with a UK note | `{{region}}` in `publishing-101`, live cards |

Privacy: the author, genre and platform the learner connects are personal data; used only to choose cards and examples; no login to Goodreads/StoryGraph/Audible is needed at launch (manual choice only).

## 9. Conversation model
**Ten-plus enthusiast lines** (each with meaning, terminology, and a genuine follow-up):

| # | She says | Means | Implied terms | A good next question |
|---|---|---|---|---|
| 1 | "I DNF'd it at 40 percent." | She gave it a fair chance and stopped reading. Not an insult to you. | DNF, pacing | "What lost you, the pacing or the characters?" |
| 2 | "My TBR is out of control." | She owns far more unread books than she can read soon. Affectionate guilt. | TBR pile, book buying | "What is at the top of the pile right now?" |
| 3 | "It's enemies-to-lovers with a forced-proximity twist." | Two people who dislike each other are stuck together and fall in love. She is describing the *pleasure*. | trope, enemies-to-lovers, forced proximity | "Is it the slow-burn kind or the banter-fast kind?" |
| 4 | "The narrator is so unreliable, I had to reread the first chapter." | The narrator's account cannot be trusted; the pleasure is catching it. | unreliable narrator, reread | "When did you first suspect?" |
| 5 | "Book hangover. I can't start anything else." | She just finished something big and nothing else feels good yet. | book hangover, reading slump | "How long did it take to get over the last one?" |
| 6 | "It's a Booker longlist thing, so, dense but rewarding." | A prize longlist book; she expects literary, demanding prose. | longlist, literary fiction | "Is it one you'd hand to someone new to literary fiction?" |
| 7 | "I'm three books into a series and the fourth isn't out for two years." | Series wait culture; a bit of grief. | series, sequel wait | "Do you reread the earlier ones while you wait?" |
| 8 | "I buy the special edition even though I own the paperback." | Sprayed edges, art, extras; collecting as pleasure. | special edition, sprayed edges | "What is it about the edition that gets you?" |
| 9 | "The movie cut the entire second half." | She is disappointed in an adaptation. | adaptation | "What is the one scene you wish they had kept?" |
| 10 | "We do a book club: wine, one book, no homework guilt." | Social reading; a monthly ritual. | book club | "What did the group pick last?" |
| 11 | "I read it on audio at 1.5x." | She listened to the audiobook, sped up. Audiobooks are reading to most readers. | audiobook, narrator | "Was the narrator good? Narrators can make or break one." |
| 12 | "Cozy fantasy, low stakes, big feelings, dragons optional." | A subgenre: fantasy without world-ending; comfort. | cozy fantasy, stakes | "Is it a comfort re-read for bad weeks?" |
| 13 | "It is very dual-timeline, past and present, and both are good, which never happens." | She noticed the classic risk that one timeline is weaker. | dual timeline | "Which timeline did you want more of?" |

- **How Swoon'd helps without fake expertise:** every `say-this` includes follow-ups that are honest curiosity and a `noFakeExpertNote` where useful ("Ask what she liked. You do not need to have read it."). The course teaches how to ask and how to say "I haven't read it, but tell me about it" gracefully. It never scripts opinions about specific books.
- **Targets:** 30 standalone talk tracks (20 at launch), 150 say-this items.

## 10. Assessment
- **Useful competence is determined by:** concept mastery 0..1 (pass 0.80) across recognition (what does "DNF" mean), interpretation (what is she actually saying), distinction (POV vs narrator; longlist vs shortlist), judgment (what to recommend; how to respond to a spoiler), and conversation (talk tracks Smooth >= 60).
- **The learner should recognize** book-culture terms, trope names, genre labels and prize names; **understand** why readers love what they love; **explain** POV, unreliable narrator, structure and genre promise in one plain sentence; **correctly interpret** enthusiast lines; **ask** good follow-ups.
- **Mastery model:** `concept-mastery-v1`, pass threshold 0.80.
- **Useful competence statement:** "I can follow and join a conversation about books: I understand what readers mean by tropes, DNF, TBR and POV, place a book on the genre map, know how prizes and publishing work at a conversational level, recommend without spoiling or faking expertise, and ask honest, interested follow-up questions about what someone loves to read."

## 11. Curriculum map (ongoing course)

20 units, 119 lessons. Layers: Foundations (5 units, 35 lessons), Intermediate (4 units, 23), Enthusiast depth (2 units, 12), Branches (6 units, 35), Live (1 unit, 4), Conversation practice (1 unit, 7), Perpetual review (1 unit, 3). A learner sees about 15 units (core plus the branches that match their `genre`). Unit count exceeds the 8-14 guidance like music/football (OPEN_QUESTIONS P-04); proposed folds are in NOTES.

Activities: `MC` multiple-choice, `BC` binary-call, `TM` term-match, `SO` sequence-order, `VI` visual-id (original art only), `DS` decision-scenario, `TT` talk-track, `ST` say-this, `FG` fill-the-gap, `ES` estimate-slider, `HT` hotspot-tap. No lesson uses Unity.

### Layer: Foundations

**Unit 1 - `books-and-editions` (How Books Work).** Prerequisites: none.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| be-01 | Hardcover, paperback, ebook, audio | Tell formats apart and why readers choose each | `book-formats`, `hardcover-vs-paperback`, `mass-market-paperback` | TM, VI, MC, ST |
| be-02 | Anatomy of a book | Name the parts of a physical book | `book-anatomy`, `dust-jacket`, `colophon` | HT, TM, FG |
| be-03 | Editions, printings and ISBNs | Explain edition vs printing and what an ISBN is for | `edition-vs-printing`, `isbn`, `translation-edition` | MC, BC, ES |
| be-04 | Novel, novella, short story, collection | Place a work by length and shape | `novel-novella-short-story`, `story-collection`, `word-count` | ES, MC, TM |
| be-05 | Series or standalone, and reading order | Decide where to start a series | `series-vs-standalone`, `reading-order`, `duology-trilogy` | DS, BC, ST |
| be-06 | Where books live | Understand libraries, indie stores, chains, online | `library-borrowing`, `indie-bookstore`, `ebook-lending` | MC, DS, ST |
| be-07 | Fiction, nonfiction, and the fuzzy middle | Recognise memoir, autofiction, historical fiction | `fiction-vs-nonfiction`, `autofiction`, `historical-fiction` | BC, MC, ST |

**Unit 2 - `reader-language` (How Readers Talk).** Prerequisites: `books-and-editions`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| rl-01 | TBR, DNF, ARC and friends | Decode reader shorthand | `tbr`, `dnf`, `arc` | TM, ST, FG |
| rl-02 | Slumps, hangovers and moods | Understand reading moods | `reading-slump`, `book-hangover`, `mood-reading` | ST, MC, DS |
| rl-03 | Rereading and comfort reads | Get why people reread | `reread`, `comfort-read` | ST, MC |
| rl-04 | What a 3-star review means | Read star ratings with judgment | `star-rating`, `half-stars`, `rating-culture` | ES, MC, BC |
| rl-05 | Spoilers and content warnings | Handle spoilers and CWs gracefully | `spoiler-etiquette`, `content-warning` | DS, BC, ST |
| rl-06 | Annotating and tabbing | Understand the etiquette of marking books | `annotating`, `tabbing`, `book-borrowing-etiquette` | ST, DS |
| rl-07 | Challenges and readathons | Read reading-count culture without pressure | `reading-challenge`, `readathon`, `books-per-year-myth` | MC, ES, ST |

**Unit 3 - `story-craft` (The Craft Vocabulary).** Prerequisites: `reader-language`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| sc-01 | Plot, story and theme | Separate what happens from what it is about | `plot`, `theme`, `premise` | MC, TM, ST |
| sc-02 | Character and arc | Name protagonist, antagonist, arc, round vs flat | `protagonist`, `character-arc`, `round-vs-flat-character` | MC, ST, FG |
| sc-03 | Point of view | Identify first, close third, omniscient, second | `pov-first-person`, `pov-third-limited`, `pov-omniscient`, `pov-second-person` | MC, ST, HT |
| sc-04 | Tense and voice | Notice past vs present tense and voice | `past-vs-present-tense`, `narrative-voice` | BC, MC |
| sc-05 | The unreliable narrator | Explain and spot an unreliable narrator | `unreliable-narrator`, `narrator-vs-author` | ST, DS, MC |
| sc-06 | Structure | Recognise acts, dual timelines, frames | `three-act-structure`, `dual-timeline`, `frame-narrative`, `nonlinear-narrative` | SO, MC, ST |
| sc-07 | Setting and worldbuilding | See how place shapes story | `setting`, `worldbuilding`, `sense-of-place` | MC, ST |
| sc-08 | Pacing, hooks and cliffhangers | Understand the page-turner machinery | `pacing`, `hook`, `cliffhanger`, `page-turner` | SO, MC, ST |
| sc-09 | Show, don't tell, and prose style | Hear the difference in style | `show-dont-tell`, `prose-style`, `dialogue` | BC, MC |

**Unit 4 - `genre-map` (Genre as a Promise).** Prerequisites: `reader-language`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| gm-01 | Genre as a promise | Explain genre as what the reader is promised | `genre-promise`, `genre-vs-category`, `shelving` | MC, ST, TM |
| gm-02 | The fiction map | Place books in the main genres and subgenres | `genre-map`, `subgenre`, `speculative-fiction` | VI, MC, TM |
| gm-03 | Middle grade, YA, new adult, adult | Know age categories and crossover | `middle-grade`, `young-adult`, `new-adult`, `crossover-book` | MC, BC, ST |
| gm-04 | Tropes | Explain what a trope is and why it satisfies | `trope`, `trope-vs-cliche`, `trope-as-promise` | TM, ST, FG |
| gm-05 | Cross-genre and shelving | Understand blended genres and shelf placement | `cross-genre`, `genre-blending`, `bookstore-section` | DS, MC |
| gm-06 | Literary vs genre | Hold the debate without picking a side rudely | `literary-vs-genre`, `commercial-fiction`, `book-snobbery` | BC, ST, TT |

**Unit 5 - `reading-life` (How Readers Find Each Other).** Prerequisites: `reader-language`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| rlf-01 | How a book club runs | Know club formats and discussion styles | `book-club`, `discussion-questions`, `club-pick` | SO, DS, ST |
| rlf-02 | Celebrity and media book clubs | Understand the "pick" effect | `celebrity-book-club`, `pick-effect` | MC, ST |
| rlf-03 | BookTok, Bookstagram, BookTube | Understand social reading and its effect on sales | `booktok`, `bookstagram`, `booktube`, `influencer-effect` | TM, MC, ST |
| rlf-04 | Goodreads, StoryGraph, Hardcover | Tell reading trackers apart | `goodreads`, `storygraph`, `reading-tracker`, `year-in-review` | TM, MC, DS |
| rlf-05 | Buddy reads and reading together | Read together without spoiling | `buddy-read`, `read-aloud`, `reading-pace-etiquette` | DS, ST |
| rlf-06 | Libraries as culture | Understand holds, waitlists, library apps | `library-holds`, `libby`, `library-card` | SO, MC, ST |

### Layer: Intermediate

**Unit 6 - `publishing-101`.** Prerequisites: `books-and-editions`, `genre-map`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| pb-01 | From manuscript to shelf | Order the steps of traditional publishing | `literary-agent`, `acquiring-editor`, `advance`, `publishing-pipeline` | SO, MC, ST |
| pb-02 | The Big Five and indies | Know the landscape at a conversational level | `big-five`, `imprint`, `independent-press` | TM, MC |
| pb-03 | Self-publishing and Kindle Unlimited | Understand indie authors and subscription reading | `self-publishing`, `kindle-unlimited`, `hybrid-author` | MC, ST, BC |
| pb-04 | Release day and bestseller lists | Read pub dates, preorders, lists | `pub-date`, `preorder`, `bestseller-list`, `first-week-sales` | ES, MC, ST |
| pb-05 | Translation and who is "the author" | Credit translators and understand translated fiction | `translated-fiction`, `translator-credit` | MC, BC, ST |
| pb-06 | Backlist, frontlist, out of print | Understand a book's marketing life | `backlist`, `frontlist`, `out-of-print` | TM, MC |

**Unit 7 - `taste-and-recs`.** Prerequisites: `reader-language`, `genre-map`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| tr-01 | Plot-driven or character-driven | Name what a reader values | `plot-driven-vs-character-driven`, `pace-preference`, `mood-match` | BC, ST, MC |
| tr-02 | Comp titles | Decode "X meets Y" | `comp-titles`, `if-you-liked` | ST, TM, FG |
| tr-03 | Recommending without spoiling | Pitch a book spoiler-free | `spoiler-free-pitch`, `rec-etiquette` | DS, TT |
| tr-04 | What a shelf tells you | Read taste from what someone owns | `taste-signals`, `auto-buy-author`, `shelf-reading` | ST, DS |
| tr-05 | Gifting a book | Choose a gift that fits | `book-gift`, `gift-fit`, `already-owns-it` | DS, ST |
| tr-06 | Reading outside your lane | Try a new shelf gracefully | `genre-stretch`, `gateway-book` | DS, ST |

**Unit 8 - `series-and-adaptations`.** Prerequisites: `books-and-editions`, `story-craft`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| sa-01 | Series shapes | Tell episodic, serial, saga, shared universe apart | `serial-vs-episodic`, `saga`, `shared-universe` | TM, MC |
| sa-02 | The wait | Understand sequel waits and unfinished series | `sequel-wait`, `unfinished-series` | ST, TT |
| sa-03 | Book vs screen | Discuss adaptations fairly | `adaptation`, `adaptation-discourse`, `faithfulness` | BC, ST, TT |
| sa-04 | Fandom, fanfiction, shipping | Understand fan practices without mockery | `fanfiction`, `shipping`, `fandom` | TM, ST |
| sa-05 | Retellings and reimaginings | Distinguish retelling, reimagining, homage | `retelling`, `reimagining`, `homage` | MC, TM |

**Unit 9 - `reading-closely`.** Prerequisites: `story-craft`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| rc-01 | Theme, motif, symbol | Name what recurs and why it matters | `motif`, `symbol`, `theme-vs-motif` | MC, ST |
| rc-02 | Allusion and intertextuality | Notice a book talking to other books | `allusion`, `intertextuality`, `epigraph` | MC, ST |
| rc-03 | Endings: ambiguous and open | Talk about endings that will not resolve | `ambiguous-ending`, `open-ending`, `epilogue` | ST, MC, TT |
| rc-04 | Translation choices | Understand why translations differ | `translation-choices`, `retranslation` | MC, ST |
| rc-05 | Banned and challenged books | Explain challenges vs bans factually | `book-banning`, `challenged-book`, `banned-books-week` | MC, DS |
| rc-06 | Author, narrator, and "the book says" | Keep author and narrator apart | `authorial-intent`, `author-narrator-distinction`, `ambiguity-reading` | BC, ST |

### Layer: Enthusiast depth

**Unit 10 - `prizes-and-canon`.** Prerequisites: `publishing-101`, `reading-closely`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| pc-01 | How literary prizes work | Understand panels, eligibility, longlist to shortlist | `longlist-shortlist`, `judging-panel`, `prize-eligibility` | SO, MC, ES |
| pc-02 | The Booker family | Explain Booker and International Booker | `booker-prize`, `international-booker` | MC, TM, ST |
| pc-03 | Pulitzer, National Book Award, Nobel | Tell the big three apart | `pulitzer-prize`, `national-book-award`, `nobel-literature` | TM, MC, ES |
| pc-04 | Women's Prize and other honors | Know a handful of other prizes | `womens-prize`, `carnegie-medal`, `debut-prize` | MC, ST |
| pc-05 | Genre awards | Hugo, Nebula, Edgar, Goodreads Choice | `hugo-award`, `nebula-award`, `edgar-award`, `goodreads-choice` | TM, MC, BC |
| pc-06 | The canon and its critics | Discuss what "canon" means without gatekeeping | `canon`, `canon-debate`, `prize-buzz` | ST, TT |

**Unit 11 - `discourse-and-collecting`.** Prerequisites: `reading-life`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| dc-01 | DNF shame and reading virtue | Explain the DNF debate | `dnf-discourse`, `reading-virtue` | BC, ST, TT |
| dc-02 | Do audiobooks count? | Hold the audio debate kindly | `audiobook-discourse`, `narrator-performance` | ST, DS |
| dc-03 | Spice and content ratings | Understand heat labels neutrally | `spice-rating`, `open-door-closed-door` | TM, ST |
| dc-04 | Illustrated covers, special editions | Explain cover trends and collectible editions | `special-edition`, `sprayed-edges`, `cover-trend` | VI, MC, ST |
| dc-05 | Boxes, signed copies, first editions | Understand book collecting | `subscription-box`, `signed-copy`, `first-edition` | MC, ES, ST |
| dc-06 | AI, authors' rights, and the industry | Explain the AI debate neutrally | `ai-and-books`, `author-rights` | MC, ST |

### Layer: Branches (`branch` units; each sets `branchId`)

**Unit 12 - `branch-literary-fiction`.** Prerequisites: `story-craft`, `genre-map`. Branch `literary-fiction`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| lf-01 | What "literary" signals | Name the emphasis on style, interiority, ambiguity | `literary-fiction`, `interiority`, `stylist-vs-storyteller` | MC, ST |
| lf-02 | Autofiction, short stories, the MFA world | Know the form landscape | `autofiction-form`, `short-story-scene`, `mfa-workshop` | MC, TM |
| lf-03 | Translated fiction and world literature | Approach translated books | `world-literature`, `women-in-translation` | MC, ST |
| lf-04 | Reading the prize shortlists | Use shortlists as reading maps | `shortlist-reading`, `slow-burn-lit` | DS, ST |
| lf-05 | Talking about a literary novel | Discuss it without pretension | `literary-small-talk`, `sentence-level-praise` | TT, ST |

**Unit 13 - `branch-romance-romantasy`.** Prerequisites: `genre-map`, `reader-language`. Branch `romance-romantasy`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| rm-01 | The genre contract: HEA and HFN | Explain the ending promise | `hea`, `hfn`, `romance-contract` | MC, BC, ST |
| rm-02 | The trope map | Recognise the popular tropes and why they land | `enemies-to-lovers`, `friends-to-lovers`, `forced-proximity`, `fake-dating`, `slow-burn`, `grumpy-sunshine` | TM, ST, FG |
| rm-03 | Heat levels | Read heat labels | `heat-level`, `closed-door`, `open-door` | TM, MC |
| rm-04 | Romantasy | Explain romantasy and its boom | `romantasy`, `romance-arc-centered`, `fae-romance` | ST, MC |
| rm-05 | Subgenres | Contemporary, historical, paranormal, sports, rom-com | `contemporary-romance`, `historical-romance`, `sports-romance`, `rom-com` | VI, TM |
| rm-06 | The community and the respect gap | Understand the community and be respectful | `romance-community`, `romance-respect-gap` | ST, TT |

**Unit 14 - `branch-fantasy-scifi`.** Prerequisites: `story-craft`, `genre-map`. Branch `fantasy-scifi`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| fs-01 | The fantasy map | Epic, urban, cozy, grimdark, portal | `epic-fantasy`, `urban-fantasy`, `cozy-fantasy`, `grimdark` | VI, TM, ST |
| fs-02 | Magic systems | Hard vs soft magic | `hard-magic`, `soft-magic`, `magic-cost` | BC, MC, ST |
| fs-03 | The sci-fi map | Hard SF, space opera, cyberpunk, dystopia | `hard-sf`, `space-opera`, `cyberpunk`, `dystopian-fiction` | TM, MC |
| fs-04 | Worldbuilding and infodumps | Talk about worldbuilding well | `infodump`, `worldbuilding-craft`, `lore` | ST, DS |
| fs-05 | Doorstops, series and the long wait | Read series culture | `doorstop`, `series-fatigue`, `long-wait` | ES, ST |
| fs-06 | Canon of the genre | Know the touchstones and how fans use them | `genre-touchstones`, `chosen-one` | MC, ST |

**Unit 15 - `branch-thriller-mystery`.** Prerequisites: `story-craft`, `genre-map`. Branch `thriller-mystery`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| tm-01 | Whodunit, howcatchem, thriller | Tell the shapes apart | `whodunit`, `howcatchem`, `thriller-vs-mystery` | MC, TM, ST |
| tm-02 | Cozy, noir, procedural | Place subgenres by mood | `cozy-mystery`, `noir`, `police-procedural` | VI, TM |
| tm-03 | Twists, red herrings, fair play | Explain what makes a twist satisfying | `red-herring`, `fair-play-mystery`, `plot-twist` | MC, DS, ST |
| tm-04 | The psychological thriller wave | Recognise the domestic/psychological thriller | `psychological-thriller`, `domestic-thriller`, `twist-fatigue` | MC, ST |
| tm-05 | Golden Age and series detectives | Know the series-detective tradition | `golden-age-mystery`, `series-detective` | MC, ST |
| tm-06 | Crime awards and true crime adjacency | Know Edgars, Daggers, Agathas | `crime-awards`, `true-crime-books` | TM, MC |

**Unit 16 - `branch-nonfiction`.** Prerequisites: `books-and-editions`, `reader-language`. Branch `nonfiction`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| nf-01 | The nonfiction map | Memoir, biography, history, science, essays, self-help | `nonfiction-map`, `biography`, `popular-history` | TM, MC |
| nf-02 | Memoir and its ethics | Discuss memoir with care | `memoir`, `memoir-ethics`, `ghostwritten` | DS, ST |
| nf-03 | Narrative nonfiction and popular science | Explain the storytelling-with-facts approach | `narrative-nonfiction`, `popular-science` | MC, ST |
| nf-04 | Self-help and the productivity shelf | Understand the shelf without cynicism | `self-help`, `productivity-books` | MC, ST |
| nf-05 | Reading nonfiction critically | Notes, sources, claims | `sources-and-notes`, `claim-vs-evidence`, `index-and-bibliography` | DS, MC |
| nf-06 | Essays | Know the essay and the collection | `essay-collection`, `personal-essay` | MC, ST |

**Unit 17 - `branch-classics`.** Prerequisites: `books-and-editions`, `reading-closely`. Branch `classics`.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| cl-01 | What makes a classic | Explain the label | `classic-book`, `canon-vs-classic` | MC, ST |
| cl-02 | Editions and translations of classics | Choose an edition | `annotated-edition`, `classics-imprints`, `translation-choice-classics` | DS, MC |
| cl-03 | How to read a classic | Strategies that help | `reading-strategy-classics`, `historical-context` | DS, ST |
| cl-04 | Public domain and free reading | Explain public domain and where free books come from | `public-domain`, `project-gutenberg`, `copyright-term` | MC, BC |
| cl-05 | Retellings, dark academia and the return | Why classics keep coming back | `dark-academia`, `classics-retelling` | ST, MC |
| cl-06 | Classics small talk | Chat without bluffing | `classics-small-talk`, `the-school-book` | TT, ST |

### Layer: Current-context (live)

**Unit 18 - `on-the-shelf-now`.** Prerequisites: `reader-language`. Live hooks: `releases`, `events`, `news`, `rankings`, `new-media`; every card has an evergreen fallback.

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| ln-01 | This week's releases | Read a release-week card | `release-week`, `pub-day-tuesday` | ST, MC |
| ln-02 | Prize season explained | Understand where in the prize year we are | `prize-calendar`, `prize-season-buzz` | ST, MC |
| ln-03 | Bestsellers and BookTok moments | Explain why a book is everywhere | `bestseller-list-reading`, `viral-book` | ST, MC |
| ln-04 | Book-to-screen and author news | Follow adaptation and author news | `adaptation-news`, `author-event` | ST, TT |

### Layer: Conversation practice

**Unit 19 - `book-talk-lab`.** Prerequisites: `reader-language`, `story-craft` (any two units of your choice for the later lessons).

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| bt-01 | "What are you reading?" | Open the conversation | `book-opener`, `curious-follow-up` | TT, ST |
| bt-02 | Her favourite book | Ask about it without quizzing | `favorite-book-question` | TT, ST |
| bt-03 | When you have not read it | Say it honestly and warmly | `honest-not-read`, `no-fake-expertise` | TT, DS |
| bt-04 | Disagreeing kindly | Handle a different opinion about a book | `kind-disagreement`, `star-rating-talk` | TT, DS |
| bt-05 | Book club night | Join a group discussion | `club-participation`, `discussion-question-ask` | TT, ST |
| bt-06 | The bookstore date | Browse and chat | `bookstore-browsing`, `staff-picks` | TT, DS |
| bt-07 | The gift conversation | Give and receive a book | `gift-conversation` | TT, ST |

### Layer: Perpetual review

**Unit 20 - `reading-review`.** Prerequisites: none (unlocks after Unit 2).

| Lesson | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| rv-01 | Daily bite | Spaced review of mastered concepts | (drawn from all mastered concepts) | MC, FG, TM |
| rv-02 | Decode the line | Mixed say-this review | (drawn) | ST |
| rv-03 | Genre-map refresher | Re-place books and tropes | `genre-map`, `trope`, `subgenre` | TM, VI, MC |

**Review policy:** intervals 1, 3, 7, 14, 30, 60 days after mastery; max 12 items per review session; concepts below 0.6 mastery re-enter the queue; seasonal live concepts (prize calendar) are excluded from review once expired.

### Concept count, personalization slots, release plan
- **Concept target (Playbook):** counted from the tables above (320 unique ids) plus ~40 review-only synonyms; Playbook terms listed in `exercises.md` (80 authored).
- **Personalization slots:** `{{author}}`, `{{genre}}`, `{{franchise}}`, `{{platform}}`, `{{region}}` as in section 8.
- **Release plan:** **Launch (0.1):** Units 1-11 plus review, live card fallbacks, conversation lab; branch units `literary-fiction`, `romance-romantasy`, `fantasy-scifi`, `thriller-mystery`. **0.2:** `nonfiction`, `classics`. **Weekly:** live cards. **Seasonal:** prize-season cards (Sep-Nov: Booker, National Book, Nobel; Jan-Mar: Pulitzer/Women's shortlists announced; Aug: Hugo). **Yearly:** re-verify prize facts.

## 12. Interaction plan

Every activity family maps to a native type (`docs/native-exercises/CATALOG.md`). **There are zero Unity (Tier A) rows, on purpose.** Rubric answer for the whole course: nothing in reading culture requires the learner to watch something move through space, feel physics, or read a dynamic scene; the concepts are vocabulary, distinction, judgment and conversation, which a game engine does not teach better than a clear text exercise. "Would a fake game be a worse teacher than clear text?" Yes for every idea below.

| Lesson / activity family | Concepts | Type | Justification (why this, not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Reader-shorthand and craft vocabulary | `tbr`, `dnf`, `pov-*`, `hook` | `term-match`, `fill-the-gap` | Vocabulary needs low-friction repetition; connect-term-to-plain-English is the exact shape. | B | 120 |
| "What is she talking about?" | all conversation concepts | `say-this` | The core skill: decode a real reader line, then a follow-up question. | B | 160 |
| Conversation practice | conversation concepts | `talk-track` | Practise asking, not bluffing; Smooth meter rewards curiosity. | B | 30 |
| Distinctions (POV, plot vs character-driven, longlist vs shortlist) | craft, prizes | `multiple-choice`, `binary-call` | Two-to-five-way choices with per-option explanation; a diagram adds nothing. | B | 320 |
| Recommend / gift / etiquette | `rec-etiquette`, `book-gift`, `spoiler-etiquette` | `decision-scenario` | Judgment from facts; consequences are conversational, not spatial. | B | 60 |
| Publishing pipeline, story structure, how a club runs | `publishing-pipeline`, `three-act-structure`, `book-club` | `sequence-order` | Order is the concept; per-step `why`. Not spatial. | B | 30 |
| Anatomy and shelf layout | `book-anatomy`, `bookstore-section` | `hotspot-tap` on original diagrams | Static labelled diagram; where, not when. | B | 20 |
| Format and genre-convention recognition | `book-formats`, `genre-map` | `visual-id` on original Swoon'd illustrations (no real covers) | Recognition by shape and typography convention; covers are copyrighted, so original stand-ins. | B | 40 |
| Magnitudes (lengths, prize money, print runs) | `word-count`, `longlist-shortlist` | `estimate-slider` | Gut-feel numbers; dated where live. | B | 20 |

**Unity ideas considered and rejected:**
1. *Story-structure "roller coaster" sim* (watch tension curve as a 3D track): a `sequence-order` plus a static diagram teaches acts more clearly; no physics concept.
2. *Bookstore walk-through* (navigate a 3D store to shelve books): shelving logic is a category decision; `sequence-order`/`term-match`/`hotspot-tap` teach it without a scene.
3. *Reading-pace "page turner" timer*: a 1D timing bar at most; not a real skill, and gamifying reading speed contradicts the course's stance (section 5).
4. *Unreliable narrator "spot the lie" scene*: this is text comprehension; a written original passage in `say-this` is the natural medium (and avoids quoting real books).
5. *Library holds queue simulator*: numbers and waits are `estimate-slider` and `decision-scenario`.

**Native fallback and accessibility:** every exercise is text-first with `alt` for original diagrams. `listening-id` and `timing-tap` are not used (audiobook clips are copyrighted; original synthesised narration would misrepresent, and rhythm is not a book concept).

## 13. Licensing & safety
Spec section 40: **talk about works; never redistribute material from them.** This course discusses titles, authors, genres, prizes, history and craft, and links out.

| Area | Handling |
|---|---|
| Cover art | **Never displayed.** Publisher cover images are copyrighted (and some have separate illustrator rights). `visual-id` uses original Swoon'd illustrations of *conventions* (`original-swoond`), never real jackets. Open Library's Covers API and Google Books thumbnails are also not a licence for a commercial paid app; not used. Link-outs only. |
| Publisher descriptions / blurbs / jacket copy | Never copied or stored. Swoon'd writes its own one-line description of what a book is like (never a paraphrase of the blurb) and links to the publisher/library page. |
| Excerpts and quotes | No passages from real books. Illustrative passages are **original, written by Swoon'd** (`original-swoond` text licence id in the content-pack registry). No long quotations. Public-domain text may be used only if verified public domain in the US and cited; default is not to. |
| Reviews / ratings text | Never copied; star aggregates (Goodreads etc.) are not mirrored; link-outs only. |
| Audio | No audiobook clips. |
| Author names, titles | Facts (name, title, year). No likeness or endorsement, no fabricated quotes. Author photos are not used. |
| Logos / trademarks | Text-only mentions of Goodreads, StoryGraph, Amazon, prizes, imprints. Prize names used descriptively; store copy wording pending legal read (like L-08). |
| Data provider terms | See `live-data.md` sections 3-4: Open Library (open data, not a high-traffic commercial API), Google Books API (no charging users without Google agreement; no permanent copies), ISBNdb (paid; may cache while subscribed), Goodreads API (retired), StoryGraph (no public API). |
| Sensitive content | Romance heat, violence in thrillers and sexual content are taught as *labelling literacy*; lessons are at survey depth with no explicit text; content warnings are taught as a courtesy. Banned-books lessons state facts and never push a mature title at a reader of unknown age. |
| AI | Course text and exercises are Swoon'd-authored; no AI-generated "book summaries" of real works are shipped. |

**Safety:** none of the physical-risk kind. Care areas: memoir and grief lit (no gamified scoring), mental health in nonfiction and self-help (teach critical reading, never give medical advice), and respectful handling of sexual content and censorship.

## 14. Content assets
- **Original illustration set (`original-swoond`):** book formats (hardcover, trade paperback, mass-market, ebook reader, audiobook headphones), book anatomy diagram, shelf with sections (procedural), genre-convention stand-ins (type-only abstract mockups: a big-serif "literary" style, an illustrated cartoon "rom-com" style, a dark-spine "thriller" style; no real titles), special-edition edge details, library card and holds queue, book club circle. ~40 illustrations, in-house.
- **Procedural diagrams:** `book-anatomy-diagram`, `bookstore-floor-plan`, `story-structure-arc`, `dual-timeline-diagram`, `pov-camera-diagram`.
- **Audio:** none.
- **Editorial cards:** original text, weekly.

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Formats and editions, reader shorthand, craft vocabulary (POV, unreliable narrator, structure), genre as a promise, and how readers find each other (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Tropes, DNF culture, TBR, series waits, editions, adaptations, prizes, BookTok and tracking apps (section 4).
- [x] 3. **What current information matters?** Release week, prize season, bestseller stories, adaptation news, BookTok moments (sections 6, 7; `live-data.md`).
- [x] 4. **What should be interactive?** Decode-the-line (say-this), talk tracks, genre and trope sorting, recommendation scenarios (section 12).
- [x] 5. **What should NOT be gamified?** Taste, reading count, sexual content and censorship, memoir and grief, "reading level" (section 5).
- [x] 6. **How should it personalize?** Genre, author, franchise, platform, region (section 8).
- [x] 7. **What does conversational competence look like?** Asking honest, interested follow-ups; not bluffing; matching a rec to her taste (sections 9, 10).
- [x] 8. **What data providers are needed?** Curated calendar, Open Library dumps, Wikidata, possibly NYT Books API and Hardcover API after terms review; Google Books and ISBNdb reviewed (section 6; `live-data.md`).
- [x] 9. **What licensing constraints apply?** No covers, blurbs, excerpts, review text, audio; original assets only (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.80 across recognition, interpretation, judgment, conversation, plus talk-track Smooth >= 60 (section 10).

Additional gates: [ ] manifest validates (see report); [ ] curriculum validates (not yet authored); [x] every Unity sim has an approved spec (none exist); [ ] every image/audio asset has a license id (assets not yet produced; all `original-swoond`); [ ] voice review (pending); [x] no copied publisher text.

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Book metadata provider for any "book card" (title, author, year): Open Library data dumps only, or a paid provider (ISBNdb) or Hardcover API? Google Books API is unsuitable for a paid app (no charging users without a Google agreement). | Product + backend | Blocks `releases` adapter, not lessons |
| 2 | Are prize names ("Booker", "Pulitzer", "Hugo", "Goodreads Choice") ok in lesson titles and store copy? | Legal | Store copy only |
| 3 | Should nonfiction and classics ship at launch, or 0.2 (proposed)? | Product | No |
| 4 | Proposed folds if 20 units is too many: merge `discourse-and-collecting` into `prizes-and-canon`; merge `series-and-adaptations` into `taste-and-recs`; merge `reading-closely` into `story-craft` (17 units). | Product | No |
| 5 | Poetry, comics/manga, and children's/picture books: candidate separate courses? | Product | No |
| 6 | Sexual-content policy for a general-audience app: teach heat labels and tropes at survey depth (proposed) vs omit; age gating. | Product + legal | Blocks `rm-03`, `dc-03` copy |
| 7 | Prize facts and results must be re-verified at release (see NOTES). | Content | Before release |
