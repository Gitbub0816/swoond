# Dynamic Data and Editorial Plan: Music (`music`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-37 (provider isolation, data strategy, news) and **section 40 (media courses)**. Facts below were checked by web search on 2026-09-30 and are tagged **[verify at release]**; sources are secondary press and official announcements, listed in section 8. Calendar and industry facts are stored as data with source URLs and `verifiedAt` dates, never as lesson copy.

## 1. Verdict: is there meaningful live data?

**Yes, modestly, and only as metadata and context.** Music has no scores, standings or seasons in the sports sense; do not invent a leaderboard (spec section 10). But three things do change weekly and give the learner something real to say: **what came out this week** (release Fridays), **what is on sale or on tour** (announcements, on-sales, festival calendars) and **what people are arguing about** (chart movement, awards nominations, ticketing or AI stories). Each of these is an *entry point to a conversation*, not a feed to consume.

**Section 40 rule, applied strictly:** Swoon'd talks *about* works (titles, release dates, credits, genres, cultural context, recommendations). It **does not distribute** any recording, lyric, cover image, artist photo, video or review text. Every card links out to the artist's or platform's official page. Audio inside lessons is always original (`original-swoond`) or explicitly licensed.

Do not invent more: no real-time streaming counts, no lyric data, no per-listener analytics beyond what the learner themselves chooses to connect.

## 2. Current-context layers

| Layer | Who sees it | What it is |
|---|---|---|
| Release-week layer | Everyone with an `artist` or `genre` set; default pop | "This week's releases", "Your person's artist dropped X": title, date, format (single, EP, album, deluxe), credits from open data, a Swoon'd explainer and a link out. |
| Tours and festivals layer | Everyone; sharper with `region` and `artist` | Tour announcements, on-sale steps, presale explainers, festival calendars, and "how to plan the day" cards. |
| Awards and charts layer | Everyone during season | Nomination lists, ceremony dates, "nominations vs wins", chart-movement explainers. |
| Industry stories layer | Everyone | Ticketing, streaming pay, AI licensing, sampling disputes explained neutrally, updated quarterly. |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer ("How to read a release week", "How tickets go on sale"). |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

External providers never become the domain model (spec section 32): Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. Every candidate below sits behind a Swoon'd adapter, each with a kill switch and a documented fallback.

| Kind (manifest) | Why | Provider candidates | Access approach and licensing notes | Refresh | Fallback |
|---|---|---|---|---|---|
| `releases` | Release-week conversation starter | **MusicBrainz** (open metadata; core data CC0, some data CC BY-NC-SA; follow the rate limit and user-agent rules); **Apple Music API / MusicKit** (catalog metadata; developer terms; no bulk redistribution); **Spotify Web API** (terms restrict caching, ML use and some endpoints; several endpoints such as related artists, recommendations and audio-features were restricted for newer apps from late 2024, so do not build on them; dev-mode quotas apply **[verify at release]**); curated editorial | Adapter to normalized `Release`; store ids and dates, not art or previews; cover art via link only; no audio previews | weekly, daily on release Fridays | Evergreen card |
| `schedules` (tours) | Tour announcements, on-sales | **Ticketmaster Discovery API** (events, venues, dates; commercial terms and rate limits); **Bandsintown** (artist events; approval and terms); **Songkick** (API access restricted, verify); artist and venue sites (link-out); curated | Adapter to `TourDate`; store event ids and dates; **link out to buy** (never sell tickets); no price scraping | weekly | Evergreen card |
| `events` (festivals, awards) | Calendar and awards season | Festival official sites (curated dates); Recording Academy (curated awards calendar and nominations); Wikipedia/Wikidata (facts, CC BY-SA / CC0) | Curated ingest with source URLs; editors verify | seasonal, weekly in season | Evergreen card |
| `rankings` (charts) | Chart-movement explainers | **Billboard** and **Official Charts Company** (published chart pages: link-out and curated summaries only; the underlying data is licensed, e.g. via **Luminate**) | Do not scrape; hand-curated weekly "movers" note with link; consider a Luminate licence later | weekly | Static "how charts work" card |
| `news` | "Why is everyone talking about this?" | Press headlines (link-only), label and artist press pages | Metadata only; Swoon'd writes the explainer; editorial provider open (DECISIONS Q-3) | daily | Evergreen explainers |
| `statistics` (optional) | Industry snapshots | RIAA reports (curated dated facts) | Curated values with a report link and date | seasonal | Skip |
| `new-media` (optional) | New concert films, documentaries | Curated | Metadata and link only | monthly | Hidden |
| Setlists (optional, not in manifest) | Post-show "what did they play?" | **setlist.fm** API (crowd-sourced; terms restrict commercial use, verify) | Only after a legal check; otherwise link out | on demand | Hidden |
| Lyrics | **Never** | (Genius and others are not used) | No ingestion, no display | n/a | n/a |
| Artist images / cover art | **Never** without a licence | (Cover Art Archive is not a reuse licence) | Text and links only | n/a | n/a |

### Season and facts snapshot (as of 2026-09-30) **[verify at release]**

- **Grammy Awards 2027:** ceremony Sunday Feb 7, 2027 at Crypto.com Arena, Los Angeles, on ABC, Disney+ and Hulu; nominations announced Monday Nov 16, 2026; eligibility Aug 31, 2025 to Aug 28, 2026; first-round voting Oct 12 to 22, 2026; final-round voting Dec 10, 2026 to Jan 7, 2027. Previous ceremony (68th, Feb 1, 2026): Album of the Year went to Bad Bunny's *DeBI TIRAR MAS FOToS* (the first primarily Spanish-language album to win it), Record of the Year to "luther" (Kendrick Lamar and SZA), Best New Artist to Olivia Dean.
- **Billboard formulas:** since the charts dated Jan 17, 2026 (tracking Jan 2 to 8), one album unit equals 1,000 paid or 2,500 ad-supported on-demand streams (was 1,250 and 3,750); the Hot 100's paid-to-ad-supported ratio moved to 1:2.5; song-equivalent ratios of 100 premium, 250 ad-supported and 400 programmed streams per sale were cited.
- **Ticketing:** the DOJ and states' antitrust trial against Live Nation-Ticketmaster opened March 2, 2026 in Manhattan federal court; on April 15, 2026 a jury found Live Nation and Ticketmaster liable on every antitrust count submitted; the jury found an overcharge of $1.72 per ticket in 21 states plus DC; a tentative Justice Department settlement (about $280 million, a 15% service-fee cap and divestiture of some amphitheater booking) was rejected by 33 states plus DC, who went to trial. Remedies and appeals were pending. DC announced a separate $9.9 million payment over pricing practices on April 20, 2026. (Explained neutrally; not legal advice.)
- **Industry (RIAA mid-year 2026, published Sept 1, 2026):** US recorded-music revenue about $6.0 billion for H1, up 6.9%; streaming about $4.9 billion (82%); paid subscriptions 111.1 million; vinyl $554 million (up 17.7%); CDs $171 million (up 58.6%).
- **AI and licensing:** Universal settled with Udio (Oct 2025) and Warner with Suno (Nov 2025); Udio pivoted to a licensed "walled garden"; Spotify and Universal announced a licensed AI covers and remix tool for Premium (May 2026); Sony's case against Suno/Udio was still open with a ruling expected in summer 2026 (status unknown at check time).
- **Festivals:** Coachella 2027 is April 9-11 and April 16-18 (Empire Polo Club, Indio, California; lineup not announced at check time); Glastonbury took a fallow year in 2026 and returns June 23-27, 2027.

## 4. Normalized Swoon'd entities (provider-agnostic)

Illustrative shapes (names settled by the app team; value types with strongly typed ids):

| Entity | Key fields | Notes |
|---|---|---|
| `Artist` | `id`, `displayName`, `mbid?`, `genres[]`, `links[]` | No likeness; `mbid` (MusicBrainz id) for disambiguation. |
| `Release` | `id`, `artistId`, `title`, `format` (single/ep/album/deluxe/mixtape), `releaseDate`, `credits[]?`, `sourceURL`, `verifiedAt` | No art, no audio. |
| `TourDate` | `id`, `artistId`, `venue`, `city`, `country`, `date`, `onSaleDate?`, `ticketLinkURL`, `source`, `verifiedAt` | We never sell; link out. |
| `Festival` | `id`, `name`, `city`, `dates[]`, `announcedActs[]?`, `officialURL`, `verifiedAt` | Dates and acts are facts; no posters. |
| `AwardsSeason` | `id`, `body`, `ceremonyDate`, `nominationsDate`, `eligibilityStart/End`, `sourceURL`, `verifiedAt` | Dated data, not lesson copy. |
| `ChartNote` | `id`, `chart`, `weekOf`, `headline`, `explainerKey`, `sourceURL` | Editor-written; no chart table. |
| `IndustryFact` | `id`, `topic`, `statement`, `asOf`, `sourceURL`, `verifiedAt` | Feeds dated sentences ("as of ..."). |
| `EditorialCard` | `id`, `topic`, `conceptIds[]`, `explainer`, `links[]`, `publishedAt`, `expiresAt` | Curated; see section 5. |

## 5. Editorial plan (spec sections 11, 37, 40)

- **Process:** an editor picks 3 to 5 topics a week from headlines and artist announcements, writes a 60 to 120 word explainer in Swoon'd's voice tied to Playbook `conceptIds`, adds 1 to 2 links, sets `expiresAt`. Cards are learning hooks: "here is the story; here is the vocabulary; here is a good question to ask".
- **What we explain:** release context, chart mechanics, ticketing mechanics, awards mechanics, legal disputes in plain words (no verdict opinions), tour logistics, festival planning.
- **What we never do:** quote reviews or lyrics, judge artists, cover gossip or private lives, take sides in fandom feuds, rank fans, or scrape.
- **Tone check:** cheeky coach, warm, never mean; never about the crush.
- **Cadence:** weekly release-week card; on-sale cards as announced; awards cards Nov to Feb; festival cards Mar to Aug; quarterly industry refresh.
- **Failure mode:** stale cards show "as of <date>" and an expiry; expired cards fall back to evergreen.

## 6. Personalization hooks

| Dimension | Live effect | Default |
|---|---|---|
| `artist` | Release and tour cards for that artist; conversation openers reference the artist by name. | Fictional demo artists in evergreen copy; no live artist cards |
| `genre` (branch) | Which release/festival/awards cards rank first; branch-specific explainers (e.g. rave safety for electronic). | `pop` |
| `region` | Tour dates and festivals near her; on-sale times in her time zone. | Region-neutral |
| `platform` | Wording and deep links (open in Spotify, Apple Music, YouTube Music). | "your streaming app" |

Privacy: the artist and platform the learner connects are personal data; used only to pick cards; never shown to anyone else without consent; no OAuth login to the streaming platform is required for launch (manual choice only).

## 7. Reliability, caching and safety

- Cache normalized entities with `verifiedAt`; show the date; never present chart or on-sale info as real-time.
- Ticket links go to the official primary seller or the artist's site; the app never scrapes prices, never offers scalping advice and warns about resale scams.
- Kill switch per adapter; if a provider changes terms, the card type falls back to evergreen.
- Rate limits and terms recorded per provider in the adapter README (owned by the backend, not this spec).

## 8. Sources used for this document (checked 2026-09-30)

Grammy 2027 dates and 68th winners (Recording Academy and press coverage, e.g. Billboard, NPR, Hollywood Reporter); Billboard chart-methodology change coverage (Billboard Pro, Relix, Hypebeast); Live Nation antitrust verdict and settlement coverage (NPR, Time, Crowell & Moring, Regulatory Oversight); RIAA 2026 mid-year report coverage (Billboard); AI-music licensing coverage (Billboard, industry blogs); Coachella 2027 and Glastonbury dates (press). All are **[verify at release]**; none of their text is reproduced.
