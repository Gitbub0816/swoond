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

