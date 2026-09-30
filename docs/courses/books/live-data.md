# Dynamic Data and Editorial Plan: Books (`books`)

Implements product spec sections 10-12, 32-37 and **section 40 (media courses)**. Facts were checked by web search on **2026-09-30** and are tagged **[verify at release]**. Calendar facts are stored as data with source URL and `verifiedAt`, never as lesson copy.

## 1. Verdict: is there meaningful live data?

**Yes, modestly, as conversation starters, not a feed.** Books have no scores or standings (spec section 10). Three things do change and give the learner something real to say: **what came out this week** (US publication day is Tuesday; UK usually Thursday), **the prize calendar** (longlists, shortlists, winners, the Nobel announcement), and **what people are arguing about** (an adaptation announcement, a cover redesign, a BookTok surge, a challenge or ban).

**Section 40, applied strictly.** Swoon'd talks *about* works (title, author, year, genre, cultural context, our own one-line description) and links out to a library, publisher or retailer. It does **not** distribute or store covers, publisher blurbs, jacket copy, excerpts, review text, reader-review text, rating aggregates, author photos, or audiobook audio. Every card carries a source link and a `verifiedAt` date, and every card type has an evergreen fallback so the course still works if a provider disappears.

## 2. Current-context layers

| Layer | Who sees it | What it is |
|---|---|---|
| Release-week card | Everyone; sharper with `author`/`genre` | "New this week": title, author, date, format, our one-sentence "what it is like" (never the blurb), a "why readers are excited" note, link out. |
| Prize-season card | Everyone, seasonal | Where we are in the prize year, what a longlist/shortlist/winner means, "what a surprise looks like", with dates. |
| Bestseller and moment card | Everyone | Why a book is everywhere (a list, BookTok, an adaptation); what a list measures. Link only; no list mirrored. |
| Screen and author-news card | `author`/`franchise` set | Adaptation announcements, author events and tours, as facts with a link. |
| Evergreen fallback | Always | "How release week works", "How to read a longlist", "How to talk about an adaptation". |

## 3. Data kinds, providers, refresh

Provider -> **Swoon'd adapter** -> normalized entity -> course interpretation -> UI (spec section 32). Each adapter has a kill switch and a fallback. Book metadata is the licensing-sensitive part, so the three requested candidates are reviewed in section 4.

| Kind | Why | Provider candidates | Approach and licensing | Refresh | Fallback |
|---|---|---|---|---|---|
| `releases` | Release-week conversation starter | Curated editorial calendar; Open Library monthly data dumps (our own snapshot); Wikidata (CC0); Hardcover API (terms to confirm); ISBNdb (paid) | Adapter to normalized `Work`/`Edition`/`Release`. Store ids, titles, authors, dates. **No covers, descriptions or excerpts.** Editors write the one-line description. | weekly | Evergreen card |
| `events` | Prize and readathon calendar | Official prize sites (curated); Wikidata (CC0); Wikipedia (CC BY-SA, attribution) | Curated ingest with source URL; editors verify. | daily in prize weeks | Evergreen card |
| `rankings` | Explain lists | NYT Books API (commercial terms to confirm); Publishers Weekly (link-only) | Do not mirror. Weekly editor note with link. | weekly | "How lists work" |
| `news` | "Why is everyone talking about this?" | Trade press headlines (link-only) | Metadata only; Swoon'd writes the explainer. Editorial provider is open (DECISIONS Q-3, L-01). | daily | Evergreen |
| `new-media` | Adaptation news | Studio/streamer press pages (link-only) | Curated; no stills or trailers hosted. | weekly | Hidden |
| `statistics` | Industry snapshots | Curated dated facts | Only hand-verified, dated sentences; no licensed sales tables. | seasonal | Skip |
| Ratings / reviews | **Never** | (Goodreads, StoryGraph, Amazon) | Link-out only. | n/a | n/a |
| Cover art / blurbs | **Never** | (publishers, Open Library Covers, Google Books thumbnails) | Not a licence for a paid app. | n/a | n/a |
| Audiobook audio | **Never** | (Audible, publishers) | Link-out only. | n/a | n/a |

## 4. Book metadata provider terms (commercial-use check, 2026-09-30)

Swoon'd is a **paid app**, so "free to use" is not enough. Conclusions are working assessments, **not legal advice**; each needs a written legal read before it becomes a dependency (NOTES L-13).

| Provider | What the terms say (as checked) | Commercial fit | Verdict |
|---|---|---|---|
| **Open Library** (Internet Archive) | Contributions are CC0; catalogue data is open and available as free monthly bulk dumps. The API docs state the APIs are "not intended to serve as a bulk data backend or high-traffic commercial infrastructure", ask that apps send a `User-Agent` with an app name and contact (identified requests get about 3 requests per second vs 1), forbid bulk harvesting through the API, and point bulk users to the dumps or openlibrary@archive.org. Cover images are a separate matter (per-image rights are not cleared by the data licence). | Data yes (open); **live API for production traffic no.** | **Use the monthly dumps into our own snapshot** (own DB, refresh monthly) for title/author/ISBN facts, with a User-Agent for the occasional lookup, attribution as courtesy. **Do not use Covers API images.** Confirm any commercial use of dumps and any non-CC0 parts with Internet Archive. |
| **Google Books API** | Terms bar charging users for an application without a separate agreement or written permission from Google; bar building databases or permanent copies of returned content; cached copies must respect cache headers; allegedly infringing content must be removed on request; developers must tell users that content they submit may be public on Google services. Google states the APIs are not meant to replace commercial services. | **No** for a paid app without a Google agreement. | **Do not use in production** unless Google signs a commercial agreement. Fine for an internal prototype or free-tier tinkering only; never for stored metadata. |
| **ISBNdb** | Paid API subscription only. Its FAQ permits commercial applications and permits downloading and caching the data locally **with a current subscription; data must be deleted if the subscription lapses**. Plan tiers differ by daily calls (for example 5,000 per day on Basic at 1 call per second), and some plans include cover-thumbnail data. Redistribution rights are not stated in the FAQ. | **Yes with a paid plan**, if the full Terms and Conditions allow our use. | **Best paid fallback** for ISBN-to-title/author lookups. Read the full T&C for redistribution and thumbnail display before use; do not display thumbnails (section 40). |
| **Goodreads** | Public API retired: no new keys since 8 Dec 2020, existing keys disabled. Scraping is not permitted. | No. | Link-out only; never build on it. |
| **The StoryGraph** | No public developer API found. | No. | Link-out only. |
| **Hardcover** | Free GraphQL API on its own catalog; terms not reviewed here. | Unknown. | Candidate; confirm commercial and caching terms before use (NOTES L-13). |
| **Wikidata** | CC0. | Yes. | Good for authors, works, prize winners and dates. |
| **NYT Books API** | Commercial-use terms not reviewed here. | Unknown. | Confirm before use; link-out is enough for launch. |

**Launch recommendation:** no automated third-party book-metadata dependency. The launch adapter reads a **curated editorial calendar** (weekly), with Wikidata (CC0) and an Open Library dump snapshot as optional enrichment for ids and dates. Add ISBNdb (paid) or a signed Hardcover agreement only when a feature needs bulk lookup (for example "look up any ISBN").

## 5. Normalized Swoon'd entities (illustrative)

| Entity | Key fields | Notes |
|---|---|---|
| `Author` | `id`, `displayName`, `wikidataId?`, `genres[]`, `links[]` | No photo. |
| `Work` | `id`, `title`, `authorIds[]`, `firstPublished`, `genres[]`, `form` (novel, collection, memoir...), `wikidataId?` | Work vs edition is a lesson concept (`edition-vs-printing`). |
| `Edition` | `id`, `workId`, `isbn13?`, `format`, `publisher`, `date`, `translatorIds[]?` | No cover. |
| `Release` | `id`, `workId`, `pubDate`, `region`, `sourceURL`, `verifiedAt` | Release-week feed. |
| `PrizeSeason` | `id`, `prize`, `longlistDate?`, `shortlistDate?`, `winnerDate?`, `sourceURL`, `verifiedAt` | Dated data, not lesson copy. |
| `ListNote` | `id`, `list`, `weekOf`, `headline`, `explainerKey`, `sourceURL` | Editor-written; no list table. |
| `EditorialCard` | `id`, `topic`, `conceptIds[]`, `explainer`, `links[]`, `publishedAt`, `expiresAt` | Curated. |

## 6. Season and facts snapshot (2026-09-30) **[verify at release]**

- **Booker Prize 2026:** shortlist announced 22 Sept 2026 at the Southbank Centre, London; winner to be announced 9 Nov 2026 at Old Billingsgate. Judges chaired by Mary Beard. Shortlist: *The Disappearers* (Marlon James), *John of John* (Douglas Stuart), *The Things We Never Say* (Elizabeth Strout), *The End of Everything* (M. John Harrison), *Black Bag* (Luke Kennard), *May We Feed the King* (Rebecca Perry). 2025 winner: *Flesh* by David Szalay (first Hungarian-British winner). International Booker 2026: press listing shows *Taiwan Travelogue* by Yang Shuang-zi, translated by Lin King, as the winner (confirm at release).
- **Pulitzer Prize for Fiction 2026:** *Angel Down* by Daniel Kraus; finalists *Audition* (Katie Kitamura) and *Stag Dance: A Quartet* (Torrey Peters). Announced May 2026.
- **National Book Awards 2026:** longlists announced September; finalists 6 Oct 2026; ceremony (77th) 18 Nov 2026. Fiction longlist includes *The Disappearers*, *Python's Kiss* (Louise Erdrich), *Beginning Middle End* (Valeria Luiselli), among others.
- **Nobel Prize in Literature:** 2025 to Laszlo Krasznahorkai. 2026 announcement expected **8 Oct 2026** (13:00 CEST at the earliest).
- **Women's Prize for Fiction 2026:** winner *The Correspondent* by Virginia Evans.
- **Hugo Awards 2026:** presented at LAcon V (84th Worldcon, Anaheim, 27-31 Aug 2026). Best Novel: *The Everlasting* by Alix E. Harrow. **Nebula 2026 Best Novel:** *The Buffalo Hunter Hunters* by Stephen Graham Jones (awarded 6 June 2026).
- Not verified at check time: Goodreads Choice Awards 2026 timing (historically nominations in autumn, voting in November-December), Edgar and other genre-award dates, current Big Five ownership details, romantasy sales figures. None appear in lessons; add to cards only with a dated, sourced check.

## 7. Editorial plan (spec sections 11, 37, 40)

- **Process:** an editor picks 3-5 topics a week, writes a 60-120 word explainer in Swoon'd's voice tied to Playbook `conceptIds`, adds 1-2 links, sets `expiresAt`. Cards are learning hooks: "here is the story, here is the vocabulary, here is a good question to ask".
- **We explain:** release context, prize mechanics, list mechanics, adaptation mechanics, why a trope is trending, challenges and bans in plain facts.
- **We never:** quote reviews or blurbs, rank readers, judge an author, take sides in fandom or political disputes, use publisher marketing text, or scrape.
- **Cadence:** weekly release card; prize cards Sep-Nov (Booker, National Book, Nobel), Jan-Mar (award shortlists), May (Pulitzer), Aug (Hugo); quarterly review of evergreen cards.
- **Failure mode:** stale cards show "as of <date>" and expire to an evergreen card.

## 8. Personalization hooks

| Dimension | Live effect | Default |
|---|---|---|
| `author` | Release/news/event cards for that author; openers reference the author by name. | Fictional demo author in evergreen copy |
| `genre` | Ranks release and prize cards; branch explainers. | Mixed |
| `franchise` | Series and adaptation cards. | None |
| `platform` | Wording and links (library app, Kindle, Audible, Bookshop.org, print). | "your library app or bookstore" |
| `region` | US Tuesday vs UK Thursday pub dates; regional prizes; nearby indie bookstores. | Region-neutral |

## 9. Reliability, caching and safety
- Cache normalized entities with `verifiedAt`; always show the date.
- Links go to libraries, publishers and legitimate retailers; never pirated copies; no affiliate links without a policy decision (NOTES).
- Kill switch per adapter; changed terms degrade the card to evergreen.
- Provider rate limits and terms are recorded in adapter READMEs (backend-owned).

## 10. Sources checked (2026-09-30)
Booker Prizes (2026 shortlist coverage: NPR, Publishers Weekly, Lit Hub), Pulitzer Prizes 2026 (Locus, Pulitzer.org), Hugo Awards 2026 (thehugoawards.org, Locus, Lit Hub), Nebula 2026 (SFWA coverage), Women's Prize 2026 (Lit Hub), National Book Foundation 2026 longlist, NobelPrize.org announcement dates, Open Library developer pages and FAQ, Google Books API Terms of Service, ISBNdb FAQ, coverage of the Goodreads API retirement (Dec 2020). Secondary press summaries are marked; primary pages should be re-read at release. None of their text is reproduced.
