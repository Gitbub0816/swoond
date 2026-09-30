# Course Design Specification: Music (`music`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `NOTES_FOR_ORCHESTRATOR.md` (no `sims/`: zero Unity sims, see section 12) |

Time-sensitive facts (chart formulas, awards dates, ticketing litigation, AI licensing, industry revenue) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Lesson copy never hard-codes them; the live layer (`live-data.md`) and dated data tokens carry them. Sources are secondary press and official announcements; each is recorded in `live-data.md` with a `verifiedAt` date.

**Rights rule for this whole course (spec sections 20 and 40).** Swoon'd *talks about* music; it does not distribute it. Every sound the learner hears in the app is either (a) original audio produced or synthesised by Swoon'd (`original-swoond`) or (b) audio under an explicit licence recorded in the asset registry. No lyrics are reproduced, no commercial recordings are embedded or redistributed, no album art, artist photos or logos are used without a written licence. Music theory taught "by ear" uses only synthesised audio.

---

## 1. Identity

- **Course ID:** `music` (immutable)
- **Display name:** Music
- **Category / family:** Music > Music (family `Music`)
- **Simulation prefix:** `music` (reserved; **no simulations are planned**, see section 12)
- **What this course is.** Music is the most personal interest in the catalog and the least "rules-based". The person you care about does not have a rulebook; she has a *taste*, a set of artists, a few songs that were the soundtrack to hard years, and (probably) a concert memory she retells. So the course teaches three things at once: **how music is built** (rhythm, harmony, sound), **the vocabulary of the scene** (production, releases, charts, live culture, fandom), and **how to talk about it kindly** (asking what she hears, admitting what you don't know). Depth is measured in listening, not memorising.
- **Two lenses, one course.** People relate to music as *listeners* (playlists, albums, favourite songs), as *concert-goers* (tickets, venues, festivals) and as *fans* (eras, fandoms, collecting). The foundation units serve all three; the genre lens (a branch) tilts the examples toward what she actually plays.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| K-pop (`k-pop`, wave 3) | Music literacy (beats, hooks, charts, concerts) transfers, but K-pop's fandom culture (light sticks, comebacks, group and unit structure, trainee system, fan clubs, fan chants, streaming parties) is a distinct world with its own vocabulary and etiquette. Someone fluent in music basics is *not* competent in K-pop fandom talk. | Sibling, independent | No shared units. `k-pop` can cross-link concepts (`hook`, `charts`, `concert-flow`, `presale-verified-fan`). This course stays neutral on K-pop except for neutral genre facts. |
| Movies (`movies`) and TV | Soundtracks and scores overlap on melody and mood, but film language (shots, editing, genre) is separate. | Adjacent, independent | Cross-link `arrangement`, `build-and-release`; no dependency. |
| Video games (`video-games`) | Game music is adjacent (loops, adaptive scores) but the fan culture differs. | Adjacent, independent | None at launch. |
| Jazz, classical/orchestral (candidate courses) | The music-literacy foundation helps, but their repertoires, performance traditions and critical vocabulary are not covered by pop-literacy. Someone could finish this course and still be lost at a jazz club or a symphony hall. | Independent (candidate future courses) | Listed under "Not in the catalog yet". Branch `jazz-classical` deliberately **not** created here; only history and taste units name them fairly. |
| Learning an instrument | A different goal: skill acquisition rather than social understanding. | Out of scope | Never a course goal; lessons say "if you want to play, a teacher beats an app". |
| Concerts as a course | Live music is *inside* this course (unit `live-music`, branches). | Shares foundation | One course; the live layer is a unit, not a separate course. |

- **Branches (genre lenses).** A branch tilts examples, terms, current context and branch-only lessons; the foundation is shared. Choosing a branch sets the personalization dimension `genre`.

| id | Name | What changes |
|---|---|---|
| `pop` | Pop (default) | Hit-making, writing camps, eras, big-tent fandoms, tours. Default when nothing is set. |
| `hip-hop` | Hip-hop | Bars, flow, beats and producers, samples, features, mixtapes, regions and rivalries as culture. |
| `rock-alt` | Rock and alt | Riffs, power chords, solos, subgenres (punk, metal, indie, emo, shoegaze), pit etiquette. |
| `country-folk` | Country and folk | Story songs, twang, Nashville writing culture, crossover debates. |
| `electronic` | Electronic and dance | DJ vs producer vs live act, beatmatching, genre map by tempo, rave and festival culture. |
| `rnb-soul` | R&B and soul | Melisma and stacked vocals, slow jams, neo-soul, live band vs track. |
| `latin` | Latin | Dembow, clave, cumbia; reggaeton, salsa, bachata, regional Mexican, Latin trap; Spanish-language success on global charts. |

Branches not launched yet (added later): `jazz-classical` (only once an independent jazz or classical course exists), `gospel-worship`, `k-pop` (never: independent course), `metal` (may split from `rock-alt`), `afrobeats`, `indie-folk`. Each new branch is a 3-lesson unit plus a facts container.

---

## 2. Beginner model

**What a complete beginner knows.** She (or he) listens every day (music is ambient for almost everyone), has favourite songs, can hum a chorus, knows a few famous artists, has probably been to a concert or a party with a DJ, and knows what "streaming" and "a playlist" mean. What is missing is not exposure; it is **vocabulary and structure**: there are no words for what they hear ("it just sounds good"), no map of genres beyond radio labels, and no sense of how the industry around the music works (why an album "drops", why tickets are a saga, why fans argue about masters).

**Terminology that confuses:** hook, bridge, pre-chorus, drop, BPM, time signature, backbeat, groove, pocket, key change, topline, stems, mixing vs mastering, EQ, compression, reverb, Auto-Tune (as a brand and as an effect), sample vs interpolation vs cover vs remix, lead single, deluxe edition, album cycle, era, deep cut, B-side, presale, verified fan, dynamic pricing, GA, pit, set clash, encore, first week, streaming units, certification (gold, platinum), masters, stan, "it's giving...".

**Common misconceptions (each is a lesson beat):**
1. "A song is just words." (Melody, rhythm, harmony and sound design carry most of the feeling; lyrics are one layer.)
2. "The singer writes everything." (Many hits have several credited writers and producers; credits are readable.)
3. "Major is happy and minor is sad." (A tendency, not a law: many sad songs are in major, many joyful ones in minor.)
4. "Auto-Tune is cheating." (It is both a repair tool and, at hard settings, a deliberate sound; the debate is real but the tool is not new.)
5. "Loud means better." (Loudness was a mastering arms race; dynamics are a feature.)
6. "Live is the same as the record." (Different mixes, backing tracks, tempo, keys and crowd.)
7. "Streams and sales are the same thing." (Charts convert streams to units by a formula that changes.)
8. "An album is the same as a playlist." (Sequencing is composition to album fans; playlists are curation.)
9. "Genres are strict boxes." (They are habits and scenes; most artists cross them.)
10. "Sampling is stealing." (It is licensed; the debate is about what "inspired by" means.)
11. "Vinyl always sounds better." (It sounds different; loved for ritual and artwork as much as fidelity.)
12. "If I don't know the old stuff, I'm not a real fan." (Gatekeeping; everyone starts somewhere.)
13. "The opener doesn't matter." (Openers are where many fans discover their next favourite.)
14. "Loud concerts don't hurt if it doesn't hurt." (Hearing damage is cumulative and can be painless.)

**Concepts that unlock the rest (foundation units):** the song map (verse, chorus, bridge, drop), beat and backbeat, major vs minor and the chord/key idea, the rhythm section and timbre, and who makes a record (songwriter, producer, engineer) with the mix/master pipeline. With those, most of what she says about a song becomes decodable; the industry and live layers then make the *conversations around* the song legible.

---

## 3. Foundational knowledge

Grouped into modules (become `foundationalModules[]` and foundation units). Everything is taught by ear where possible, using synthesised examples; terminology is introduced *after* the listener has experienced the thing.

| Module (unit id) | Content |
|---|---|
| `song-anatomy` | Intro, verse, pre-chorus, chorus, bridge, outro; hook vs chorus; earworm; build and release; drops and breakdowns; mapping a whole song. |
| `rhythm` | Beat, tempo (BPM), bar, time signature (4/4, 3/4, 6/8 named), downbeat, backbeat, four on the floor, syncopation, swing and shuffle, groove and pocket, half-time, fills; tap-along timing. |
| `melody-harmony` | Pitch, octave, melody, major and minor scales (by ear), chords (triads), key and tonic, progressions and the four-chord song, tension and resolution (cadence), key change, harmony vocals. No notation required; a keyboard diagram is used for orientation only. |
| `instruments-sound` | Rhythm section (drums, bass, guitar or keys), electric vs acoustic vs synthesised, vocal roles and ranges (lead, backing, falsetto), timbre and attack/decay, dynamics and layers. |
| `how-records-are-made` | Writers, producers, engineers, session musicians; demo, multitrack, stems; mixing (balance, EQ, pan), compression, reverb and delay, mastering and the loudness war, pitch correction, samples/interpolations/covers/remixes. |

Intermediate and enthusiast content: genre map, songwriting and arrangement, releases/labels/charts, live culture, fandom; listening close, history/eras, debates and taste (see section 11).

---

## 4. Enthusiast model

**What enthusiasts talk about:** the *last* thing they heard and how it made them feel; specific moments (a bridge, a key change, an ad-lib) more than whole songs; albums as sequences; eras and reinventions; who produced or wrote what; the setlist of last night's show; the ticket saga; fan theories and easter eggs; deep cuts vs singles; which pressing or variant they got; live vs studio; charts and first-week numbers (for the chart-watching sub-culture); the state of the industry (streaming pay, AI, ticketing).

**Distinctions that matter to them:** single vs album track; studio vs live; original vs cover/remix; sample vs interpolation; label vs independent; major vs indie scene; album vs playlist listening; casual vs "real" fan (contested); era vs album; opener vs headliner; standing (GA/pit) vs seated; festival day-planning.

**Knowledge that signals genuine understanding:** naming *one specific moment* and why it works ("the last chorus goes up a key"); reading credits ("she co-wrote and produced it"); knowing that first-week numbers include variants and bundles; knowing the difference between a remaster and a re-recording; planning a festival day around clashes; describing a mix ("the vocals are dry and close, the drums are huge"); asking a good follow-up instead of naming names.

**Beginner statements that sound obviously uninformed (gently corrected in lessons):** "All rap sounds the same", "Country is all about trucks", "She didn't write that", "It's just a sample, no skill", "I only like real instruments", "Nobody buys albums anymore", "The opener is a waste of time", "Vinyl is just a fad", "K-pop is just pop" (redirect to the K-pop course), "Auto-Tune is lazy".

**Common controversies and debates (dated where needed):**
- **Authenticity and gatekeeping** ("real music", "real fan").
- **Auto-Tune, backing tracks and lip-sync** vs live vocals.
- **Streaming pay** and who benefits (artists, labels, songwriters, platforms).
- **Album vs playlist** listening and the "album is dead" line.
- **Sampling, interpolation and lawsuits** (what counts as "sounds like").
- **AI-generated music**: label settlements and licensing deals with AI companies in late 2025 and 2026; Spotify and Universal announced an AI covers/remix tool in 2026 **[verify at release]**; the fair-use fight with at least one major label was still open when checked.
- **Ticketing:** a federal jury found Live Nation and Ticketmaster liable on antitrust counts in April 2026; the government-side settlement (about $280M with fee-cap terms) was rejected by 33 states plus DC, who went to trial **[verify at release]**; dynamic pricing controversies (e.g. Oasis reunion 2024) and fee transparency.
- **Nostalgia:** "music was better back then" (nostalgia bias) and reissue culture.
- **Vinyl and physical:** collectability, variant marketing, fidelity claims.
- **Chart formulas:** how bundles, variants and streaming weights shape "number one" (Billboard changed its streaming ratios in January 2026 **[verify at release]**).

---

## 5. Interaction model

- **What the learner should EXPERIENCE rather than read:** *hear* a backbeat (then tap it), *hear* major vs minor, *hear* a build and a drop, *hear* what a bass line does, *see* a song map and tap the chorus, *decide* how to buy tickets or plan a festival day, *choose* what to say. The course is listening-forward: `listening-id` and `timing-tap` carry the theory; `decision-scenario` carries live culture; `say-this` and `talk-track` carry fandom conversation.
- **Unity?** No. Nothing in music requires a 3D scene, physics or camera. The only movement-over-time concepts (a beat, a build) are *time* not *space*, and are taught with audio and a 1D timing bar (rubric row: "Simple 1D timing bar: native"). Justification in section 12.
- **Native mix:** `listening-id` (the star, using original synthesised audio only), `timing-tap` (tap-along rhythm), `hotspot-tap` (song maps, venue floor plans, mixer strips, keyboard), `visual-id` (instruments, vinyl variants, venue types via original illustrations), `estimate-slider` (BPM, decibels, stream counts), `sequence-order` (song structure, concert flow, how a record is made), `decision-scenario` (tickets, festivals, hearing safety), `term-match`, `fill-the-gap`, `multiple-choice`, `binary-call`, `say-this`, `talk-track`.
- **What should NOT be gamified:** taste (never "score" a favourite artist), fandom identity (no ranking of fans), grief or mental-health uses of music, artists' private lives, ticket-scalping "hacks", hearing damage beyond safe advice, chart rivalry as a toy. Never grade a learner's taste; grade *understanding and kindness*.
- **Audio-first accessibility:** every `listening-id` has a text description, a "Skip" path and a captioned alternative; a learner who cannot hear is offered `visual-id`/`hotspot-tap` versions of the same concept.

---

## 6. Dynamic information requirements

Music is a **media** course (spec section 40): dynamic data is *metadata and context*, never the works. It is modest, mostly weekly, and never on the critical path of a lesson.

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| `releases` | Yes | "What just came out?" is the most-asked conversation starter; release Fridays. | MusicBrainz (open metadata), Apple Music API / MusicKit, Spotify Web API (terms apply), curated editorial | weekly (daily on release Fridays) | Evergreen "how to read a release week" card |
| `schedules` (tours) | Yes, light | Tour announcements and on-sales are the live layer. | Ticketmaster Discovery API, Bandsintown / Songkick (partner terms), artist sites (link-out), curated | weekly | Evergreen "how tours are announced" card |
| `events` (festivals, awards) | Yes | Festival calendars, awards nominations and ceremony dates. | Festival official sites (curated), Recording Academy (curated), Wikipedia/Wikidata for facts (CC licence) | seasonal / weekly | Evergreen explainers |
| `rankings` (charts) | Yes, light | Chart movement context; not a live board. | Billboard and Official Charts (link-out and curated summaries only), Luminate (licence) | weekly | Static "how charts work" card |
| `news` | Yes | "Why is everyone talking about this?" | Music press RSS/headlines (link-only), label press pages | daily | Evergreen explainers |
| `statistics` | Optional | Industry snapshots (RIAA revenue, subscribers, vinyl growth). | RIAA reports (curated facts with dates) | seasonal (mid-year, annual) | Skip |
| `new-media` | Optional | New videos, documentaries, concert films (metadata only). | Curated | monthly | Hidden |
| Scores, standings, rosters | **No** | Music has no scores; do not invent a leaderboard. | n/a | n/a | n/a |
| Lyrics | **No, never** | Copyrighted; not reproduced or ingested. | n/a | n/a | n/a |

**Structured data and editorial are separate systems** (spec section 11): the release/tour/chart cards are structured; the "why does it matter" cards are editorial, written by Swoon'd in its own words with links out.

---

## 7. Editorial context

- **What commentary helps:** why an album is being discussed, what a chart change means, why a tour on-sale is controversial, what a ceremony's nominations imply, what a lawsuit is about (in plain terms), why fans are upset/excited. Also *taste-neutral* explainers: "how to read a credits list", "why this genre sounds like that".
- **Appropriate sources:** the artist's own announcements, label press pages, Recording Academy and festival official sites, established music press (headlines only), public-interest reporting (e.g. NPR, court dockets for legal matters), academic sources for history.
- **Licensing:** publisher article text is never copied; headlines and a link are fine; reviews are never quoted at length.
- **Summarize, explain or link?** Default **explain in our own words and link** (`explain-and-link`). We may summarise *facts* (a release date, a nomination list) but not reproduce reviews or lyrics. For opinions, we describe the *debate*, not the take.
- **Example prompts:** "Why are fans upset about the ticket prices?", "What does a re-recording change?", "What does 'first-week' mean for this release?", "Why did the album drop on a Friday?", "What is a key change and why do fans love it?", "What is the lawsuit about, in plain words?".
- **Tone:** never take sides in fandom rivalries or political fights; explain that people disagree and why. No content about artists' private lives, rumours, or health.

---

## 8. Personalization

| Dimension | How it changes examples and live context | Default when unset | Tokens (units) |
|---|---|---|---|
| `genre` (set by branch) | Which branch unit opens; which examples (drums, instruments, tempos) appear; which live cards are prioritised. | `pop` | `{{genre}}` in `genre-map`, `branch-*`, `music-now` |
| `artist` | Examples and current-context cards reference her favourite artist(s) (release news, tour, era); talk tracks mention "{{artist}}". | Fictional demo artists in evergreen copy (never real names as invented quotes) | `{{artist}}` in `fandom-culture`, `music-now`, `conversation-lab` |
| `region` | Local venues, festival dates nearby, on-sale times in local time zone. | Region-neutral examples | `{{region}}` in `live-music`, `music-now` |
| `platform` | Wording for playlists, Wrapped, and "open in app" links (Spotify, Apple Music, YouTube Music, other). | "your streaming app" | `{{platform}}` in `releases-industry`, `fandom-culture` |
| `skill-level` (not a dimension we surface as a test) | Not used to rate her taste; only sets lesson depth. | beginner | none |

Personalization never *quizzes* her taste. When an artist is set, evergreen lessons keep working with generic fictional examples; current-context cards and talk-track intros add the artist.

---

## 9. Conversation model

Enthusiast lines (invented, paraphrase-style; no lyrics) with meaning and a good next question. The `Concepts` column ties to Playbook ids.

| # | She says | Meaning | Concepts | A good follow-up |
|---|---|---|---|---|
| 1 | "The bridge on track seven wrecked me." | The contrast section of that song hit her emotionally; track seven is likely her favourite. | bridge, song-structure | "What does the bridge do that the rest doesn't?" |
| 2 | "It's giving 2016 era." | Nostalgic shorthand: the sound/look resembles that period of an artist's or scene's output. | era | "What was so special about that era?" |
| 3 | "The mix is so clean; you can hear every layer." | The balance and separation of sounds is good. | mixing, stereo-image | "Which layer do you love most?" |
| 4 | "Verified fan code didn't work, I'm shaking." | Presale access failed; she is anxious about tickets. | presale-verified-fan, dynamic-pricing | "Do you want a hand with backup options?" |
| 5 | "The bass line carries the whole thing." | The low melody is the engine of the song. | bass-line, groove-pocket | "Can you hum it for me?" |
| 6 | "She's in her reinvention era." | The artist is changing sound or look on purpose. | era | "What's the new sound like?" |
| 7 | "Skip the singles, listen to the deep cuts." | Non-single album tracks are where the good stuff is. | deep-cut | "Which deep cut should I start with?" |
| 8 | "They re-recorded it to own the masters." | The artist re-made older songs to control the recordings. | publishing-vs-master, streaming-royalties | "Does the re-recording sound different?" |
| 9 | "GA or seats?" | Standing on the floor or reserved seating for a show. | ga-pit-reserved | "What do you prefer, the crowd or a clear view?" |
| 10 | "There's a clash at seven; I need to pick." | Two sets overlap at a festival. | set-clash | "Which one can't you miss?" |
| 11 | "The lead single is fine, but the album is a masterpiece." | The first song does not represent the whole record. | lead-single, album-cycle | "Is there a track that shows the whole album?" |
| 12 | "It debuted at number one on variants alone." | Many editions (colours, signed) drove first-week numbers. | first-week, variants-pressings | "Do you think chart formulas are fair?" |
| 13 | "The key change at the end got me." | The last chorus modulates up for a lift. | key-change | "Do you notice it every time?" |
| 14 | "It's so Auto-Tuned, and I love it." | She enjoys hard-tuned vocals as a sound. | pitch-correction | "What do you like about that sound?" |
| 15 | "That's an interpolation of an old song." | They re-recorded a melody rather than sampling the master. | interpolation, sample | "Do you know the original?" |
| 16 | "My Wrapped is 90% one band, don't judge." | Streaming recap shows heavy listening to one act. | year-end-recap, stan | "What do you play on repeat?" |
| 17 | "The opener was better than the headliner." | The first act impressed her more. | concert-flow | "Who was the opener?" |
| 18 | "The variant sold out in ten minutes." | A limited vinyl edition sold out quickly. | variants-pressings | "Did you get one?" |
| 19 | "Live it's so different; the drummer goes wild." | The stage version differs from the record. | live-vs-studio | "What changed most?" |
| 20 | "They did a surprise song, I lost it." | An unexpected song added to the setlist. | surprise-song, setlist | "Was it a deep cut?" |

**How Swoon'd helps without encouraging fake expertise:** every talk track and say-this includes `noFakeExpertNote` and follow-ups that are honest curiosity ("what do you hear in it?"), never pretend analysis. Coach notes reward asking her to teach you and admitting "I only know the singles". *Cringe* replies are the ones that fake authority ("that's objectively bad"), argue about taste, or steal the moment ("I saw that on YouTube"). Swoon'd never scripts opinions about her favourite artist.

**Targets:** 20 talk tracks at launch (see `exercises.md` roster), 90+ say-this items, 50+ fill-the-gap items.

---

## 10. Assessment

- **Useful competence** = she can (1) decode what her person says about a song or a show, (2) follow the conversation about a release, tour or chart, (3) hear the basics for herself (beat, major vs minor, a build, a hook), (4) ask two honest, informed follow-up questions, and (5) plan or share a live-music day without being lost.
- **Recognise:** parts of a song, backbeat vs four-on-the-floor, major vs minor, common instruments and vocal roles, genre signifiers, credits, release formats, ticket terms, venue types, festival scheduling.
- **Understand:** why hooks and builds work, why the mix/master exist, why charts use formulas, why ticket prices spike, why fans argue about Auto-Tune, streaming pay, AI and ticketing.
- **Explain:** in her own words, "what is a bridge", "what is the difference between a sample and an interpolation", "what is dynamic pricing".
- **Correctly interpret:** a credits list, a chart headline, a tour poster, a festival timetable, a vinyl listing.
- **Mastery model:** `concept-mastery-v1`, pass threshold **0.8** (foundations concepts held to 0.8; enthusiast-depth concepts count as Familiar at 0.6 for reporting). Review ladder: 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per daily session; below 0.6 re-enters at 1d.
- **Ear-mastery check (`review-03`)**: five synthesised clips (tempo band, meter, major/minor, backbeat placement, genre sketch); pass at 4 of 5. Never used to rate taste.
- **Useful competence statement:** "She can follow a conversation about a song, an album or a show, hear a beat, a build and the major-or-minor colour for herself, ask a couple of genuinely curious questions about a favourite artist, and say 'okay, I see why this matters to you' without faking it."

## 11. Curriculum map (ongoing course)

Course version target at launch: `curriculumVersion 0.1.0` (structure plus first units); see release plan. **23 units, 119 lessons, 216 Playbook concepts** across all six layers (foundations 5u/30l, intermediate 5u/31l, enthusiast 3u/21l, branch 7u/21l, current-season 1u/5l, conversation 1u/7l, review 1u/4l). Activity legend: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap. There are no `unity-sim` activities in this course. Each lesson lists four planned activity families (curriculum JSON adds several items per family; thin-lesson lint needs at least four).

Every lesson ends with a "line you could say out loud" and 1 to 3 Playbook additions. Every unit's final lesson is a mixed-review capstone including one `tk` or `st` conversation beat. Every `li` activity has a paired non-audio activity in the same unit for Deaf or hard-of-hearing learners. Branch units are small (3 lessons each) and appear only for learners whose `genre` is set to that branch; the first-run experience shows `branch-pop` by default.

Dependency shape (not a straight line): `song-anatomy` opens everything; `rhythm`, `melody-harmony` and `instruments-sound` can be done in any order; `how-records-are-made` follows sound; intermediate units unlock as prerequisites are mastered; enthusiast units need the matching foundations; branch units need `releases-industry`.

### Layer 1: Foundations

**Unit `song-anatomy`: What a Song Is Made Of** (prereq: none). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `song-01` | The map of a song | Name intro, verse, chorus, bridge and outro when someone talks about "the part where...". | song-structure, verse, chorus, intro-outro | tm, ht, mc, fg |
| `song-02` | The hook and the earworm | Tell a hook from a chorus and say why some melodies will not leave your head. | hook, earworm, chorus | mc, bc, st, fg |
| `song-03` | The pre-chorus and the build | Hear how a pre-chorus stacks tension so the chorus feels like a release. | pre-chorus, build-and-release | li, mc, so, bc |
| `song-04` | Where the bridge takes you | Explain what a bridge is for: a change of view before the last chorus. | bridge, song-structure | mc, so, bc, st |
| `song-05` | Drops and breakdowns | Recognise the drop and the breakdown in dance-leaning songs and say why crowds react. | drop, breakdown, build-and-release | li, mc, bc, fg |
| `song-06` | Map a whole song | Label a full song map and describe where the biggest moment lands. | song-structure, verse, chorus, bridge, drop | ht, so, st, tk |

**Unit `rhythm`: Rhythm and Groove** (prereq: `song-anatomy`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rhythm-01` | Find the beat | Tap along to a steady pulse and say what BPM means. | beat, tempo-bpm | tt, es, mc, li |
| `rhythm-02` | Bars and time signatures | Count in fours and threes and tell 4/4 from 3/4 by feel. | bar-measure, time-signature | li, mc, tm, bc |
| `rhythm-03` | The backbeat | Find beats two and four and know why they make you clap. | backbeat, four-on-the-floor | tt, li, mc, bc |
| `rhythm-04` | Syncopation and swing | Hear notes that sit between the beats and the lilt of swing versus straight time. | syncopation, swing-shuffle | li, mc, bc, fg |
| `rhythm-05` | Groove and the pocket | Explain what people mean when a band "sits in the pocket". | groove-pocket, fill, half-time | mc, li, tm, st |
| `rhythm-06` | Tap it out | Combine tempo, meter and backbeat to describe a groove in plain words. | beat, backbeat, tempo-bpm, time-signature, groove-pocket | tt, li, st, tk |

**Unit `melody-harmony`: Melody, Harmony and Key** (prereq: `song-anatomy`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `harm-01` | Pitch and melody | Say what pitch is and follow a melody as a shape that goes up and down. | pitch, melody, octave | li, ht, mc, fg |
| `harm-02` | Major sounds bright, minor sounds shadowed | Tell major from minor by ear and by description. | major-scale, minor-scale | li, mc, bc, fg |
| `harm-03` | Chords: notes stacked | Define a chord and hear a major chord against a minor one. | chord, triad-major-minor | ht, li, mc, tm |
| `harm-04` | Home base: the key | Explain what "in the key of" means and why a song feels like it has home. | key-tonic | mc, li, fg, bc |
| `harm-05` | Progressions and the four-chord song | Recognise that many hits share the same handful of chords. | chord-progression, four-chord-song | li, mc, st, so |
| `harm-06` | Tension and release | Hear a chord that wants to move and the one that settles. | tension-resolution, cadence | li, mc, bc, fg |
| `harm-07` | The key change | Spot a key change and explain why the last chorus lifts. | key-change, harmony-vocals | li, mc, st, bc |

**Unit `instruments-sound`: Instruments, Voices and Sound** (prereq: `song-anatomy`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sound-01` | The rhythm section | Name what drums, bass and rhythm guitar or keys each do. | rhythm-section, bass-line, drum-kit | vi, tm, mc, li |
| `sound-02` | Guitars, keys and synths | Tell acoustic, electric and synthesised sounds apart. | electric-vs-acoustic, synthesizer | li, vi, mc, tm |
| `sound-03` | Voices | Describe lead vocals, backing vocals, range and falsetto. | lead-vocal, backing-vocals, vocal-range, falsetto | li, mc, tm, st |
| `sound-04` | Timbre: why a note has a colour | Explain why the same note on two instruments sounds different. | timbre, attack-decay | li, mc, bc, fg |
| `sound-05` | Loud, soft and layered | Hear dynamics and layers and say how they shape a song. | dynamics, texture-layers | li, es, mc, st |

**Unit `how-records-are-made`: How a Record Gets Made** (prereq: `instruments-sound`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `prod-01` | Who does what | Tell songwriter, producer, audio engineer and session musician apart. | songwriter, producer, audio-engineer, session-musician | tm, mc, st, ds |
| `prod-02` | Demos, takes, tracks and stems | Follow a song from demo to tracked parts to stems. | demo, multitrack, stems | so, mc, fg, bc |
| `prod-03` | Mixing basics | Explain mixing as balance, EQ and placement in the stereo field. | mixing, eq, panning-stereo | ht, li, mc, tm |
| `prod-04` | Compression, reverb and delay | Hear what compression, reverb and delay do to a sound. | compression, reverb-delay | li, mc, vi, fg |
| `prod-05` | Mastering and loudness | Say what mastering adds and why loudness became a fight. | mastering, loudness | mc, bc, es, st |
| `prod-06` | Samples, loops and pitch correction | Separate a sample from an interpolation, a cover and a remix, and know what pitch correction is. | sample, interpolation, cover-version, remix, pitch-correction | tm, mc, bc, st |

### Layer 2: Intermediate

**Unit `genre-map`: The Genre Map** (prereq: `rhythm`, `melody-harmony`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `genre-01` | What a genre really is | Define genre and subgenre as a set of habits, not a box. | genre, subgenre | mc, tm, bc, st |
| `genre-02` | The family tree | Trace how blues and gospel fed rock, R&B, country, jazz and hip-hop. | blues-roots, genre-family-tree | so, mc, tm, bc |
| `genre-03` | Pop is a moving target | Explain why "pop" means both popular and a sound. | pop-music, genre-blend | mc, bc, st, fg |
| `genre-04` | Same song, different genre | List the signifiers (tempo, drums, instruments, vocals) that make a genre recognisable. | genre-signifiers, tempo-bpm | li, mc, tm, es |
| `genre-05` | Subgenre words and scenes | Decode tags like indie, alt, lo-fi, bedroom pop and what a scene is. | indie-alt, scene-movement, subgenre | tm, mc, st, fg |
| `genre-06` | Genre by ear | Identify original genre sketches by tempo, drums and instruments. | genre-signifiers, backbeat, four-on-the-floor | li, mc, st, tk |

**Unit `songwriting-arrangement`: Songwriting and Arrangement** (prereq: `melody-harmony`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `write-01` | Topline, beat and lyric | Separate who wrote the melody and words from who made the track. | topline, writing-credits | tm, mc, st, bc |
| `write-02` | Hooks by design | Explain the tricks that make a hook stick: repetition, contour, a surprise. | hook-craft, earworm | li, mc, fg, st |
| `write-03` | A story in three minutes | Describe narrative songwriting and imagery without quoting a line. | narrative-lyric, imagery-metaphor | mc, ds, st, fg |
| `write-04` | Rhyme and how words fit | Understand rhyme scheme and why words are shaped to the rhythm. | rhyme-scheme, prosody | mc, tm, bc, st |
| `write-05` | Arrangement: adding and removing | Hear how layers arrive and leave to steer emotion. | arrangement, texture-layers | li, so, mc, bc |
| `write-06` | Co-writing, credits and covers | Read a credit list and know why songs often have many writers. | co-writing, writing-credits, cover-version, singer-songwriter | mc, ds, st, fg |

**Unit `releases-industry`: Releases, Labels and Charts** (prereq: `genre-map`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rel-01` | Single, EP, album, mixtape | Tell the release formats apart and why each exists. | release-formats, mixtape | tm, mc, bc, fg |
| `rel-02` | Release Friday and the album cycle | Describe a lead single, an album rollout and a deluxe edition. | release-friday, album-cycle, lead-single, deluxe-edition | so, mc, st, bc |
| `rel-03` | Labels, indies and distributors | Say what a label does and how an independent artist gets on streaming. | record-label, independent-artist, distributor | tm, mc, ds, bc |
| `rel-04` | Who gets paid when you stream | Separate master rights from publishing and know why payouts are debated. | streaming-royalties, publishing-vs-master | mc, bc, es, st |
| `rel-05` | How charts work | Explain streaming units, first week and why chart formulas change. | charts, streaming-units, first-week, certification | es, mc, bc, st |
| `rel-06` | Playlists, algorithms and Wrapped | Understand playlist curation, algorithmic discovery and the year-end recap ritual. | playlist-curation, algorithmic-discovery, year-end-recap | mc, ds, st, fg |
| `rel-07` | Vinyl, CDs and collecting | Read a vinyl listing (variants, pressings) and why physical is growing. | vinyl-basics, variants-pressings, physical-resurgence | vi, mc, tm, es |

**Unit `live-music`: Live Music and Concert Culture** (prereq: `song-anatomy`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `live-01` | Anatomy of a show | Follow opener, changeover, headliner, setlist and encore. | concert-flow, setlist, encore | so, mc, tm, st |
| `live-02` | Venues from bar to stadium | Match venue types to capacities and what to expect there. | venue-types, venue-capacity | vi, es, mc, bc |
| `live-03` | Buying tickets without tears | Decode presale, verified fan, dynamic pricing, fees and resale. | presale-verified-fan, dynamic-pricing, ticket-fees, resale-face-value | ds, mc, tm, bc |
| `live-04` | General admission, pit and seats | Pick a spot on a venue map for the kind of night you want. | ga-pit-reserved, sightlines | ht, ds, mc, bc |
| `live-05` | Festivals decoded | Read a festival poster and schedule and plan around set clashes. | festival-basics, set-clash, stages-sets | ds, ht, mc, so |
| `live-06` | Etiquette, hearing and crowd safety | Know the conservative basics: earplugs, hydration, exits and crowd care. | concert-etiquette, hearing-protection, crowd-safety | es, ds, mc, bc |
| `live-07` | Tour talk | Decode legs, residencies, surprise songs, merch lines and tour posters. | tour-leg, residency, surprise-song, merch | tm, mc, st, fg |

**Unit `fandom-culture`: Fandom and Community** (prereq: `releases-industry`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fan-01` | Why fandom feels like family | Explain fandom, stan culture and the one-sided closeness people call parasocial. | fandom, stan, parasocial | mc, st, bc, fg |
| `fan-02` | Eras, easter eggs and lore | Decode "eras", hidden clues and fan theories. | era, easter-egg, fan-theory | tm, mc, st, bc |
| `fan-03` | Deep cuts and B-sides | Say what a deep cut and a B-side are and why fans prize them. | deep-cut, b-side, album-track | tm, mc, st, fg |
| `fan-04` | Fan rituals | Recognise rituals: friendship bracelets, sing-alongs, setlist tracking, fan projects. | fan-ritual, fan-project | mc, ds, st, bc |
| `fan-05` | Being a good guest in a fandom | Avoid gatekeeping traps and respect artists' boundaries. | gatekeeping, fan-boundaries | ds, mc, tk, bc |

### Layer 3: Enthusiast depth

**Unit `listening-like-a-fan`: Listening Like a Fan** (prereq: `rhythm`, `melody-harmony`, `how-records-are-made`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `ear-01` | What to listen for | Pick one layer (bass, drums, vocal, space) and follow it through a track. | active-listening, sonic-signature | li, mc, st, bc |
| `ear-02` | Follow the bass | Hear the bass line as its own song inside the song. | bass-line, groove-pocket | li, mc, tt, bc |
| `ear-03` | Hear the harmony | Tell major, minor and suspended colours by ear. | chord-quality, triad-major-minor, tension-resolution | li, mc, bc, fg |
| `ear-04` | Space and stereo | Describe a mix as wide or narrow, dry or roomy. | stereo-image, reverb-delay | li, ht, mc, st |
| `ear-05` | Build a track by ear | Hear how layers are added in order to make a section bigger. | arrangement, build-and-release, texture-layers | li, so, mc, bc |
| `ear-06` | Live versus studio | Say what changes on stage: backing tracks, tempo, keys, crowd. | live-vs-studio, backing-tracks | mc, bc, ds, st |

**Unit `history-eras`: How We Got Here** (prereq: `genre-map`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hist-01` | Roots: blues, gospel, folk | Name the roots and what each gave later genres. | blues-roots, gospel-roots, folk-tradition | so, mc, tm, st |
| `hist-02` | Rock and roll to the British invasion | Place rock and roll, the electric guitar and the album era. | rock-and-roll, album-era | so, mc, bc, st |
| `hist-03` | Soul, funk, disco | Link groove-based genres and why dance floors mattered. | soul-funk, disco | tm, mc, li, bc |
| `hist-04` | Punk, hip-hop and the synth | Place punk, hip-hop's birth and the MTV synth era. | punk, hip-hop-origins, mtv-era | so, mc, tm, st |
| `hist-05` | The 90s and 2000s | Sketch grunge, golden-age hip-hop, boy bands, the iPod and downloading. | grunge-alt-90s, digital-download-era | tm, mc, bc, st |
| `hist-06` | Streaming, TikTok and how tech shapes sound | Explain how each new technology changed how songs are made and found. | tech-shapes-music, streaming-era, viral-discovery | so, mc, ds, st |

**Unit `debates-taste`: Debates and Taste** (prereq: `releases-industry`). 9 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `debate-01` | "Is that real music?" | Understand authenticity arguments without joining the gatekeeping. | debate-authenticity, gatekeeping | ds, mc, st, tk |
| `debate-02` | Auto-Tune, backing tracks and live vocals | Explain the pitch-correction and lip-sync debates fairly. | pitch-correction, backing-tracks, debate-live-vocals | mc, bc, ds, st |
| `debate-03` | Album or playlist? | Explain why some fans think in albums and others in playlists. | debate-album-vs-playlist, album-era | mc, bc, st, fg |
| `debate-04` | Streaming pay | Lay out why artists and platforms disagree about payouts. | debate-streaming-pay, streaming-royalties | mc, ds, st, bc |
| `debate-05` | Sampling, lawsuits and "sounds like" | Separate inspiration, interpolation and copying at a high level. | copyright-sampling, interpolation, sample | mc, bc, ds, st |
| `debate-06` | AI and music | Summarise the AI music debate and where licensing stands (dated). | ai-music | mc, ds, st, bc |
| `debate-07` | Ticket prices and the monopoly fight | Explain why ticketing is contentious and what the 2026 rulings were about (dated). | debate-ticketing, dynamic-pricing | mc, ds, st, bc |
| `debate-08` | Nostalgia and "music was better then" | Recognise nostalgia bias and answer kindly. | nostalgia-bias | mc, ds, st, tk |
| `debate-09` | Talking about taste | Describe what you hear without snobbery and ask what they hear. | taste-vocabulary, convo-taste-without-snobbery | mc, st, tk, fg |

### Layer 4: Branches and personalization

Seven genre lenses; choosing a branch sets `genre` (and `branchId` on the unit). Layer `branch` units require the unit-level `branchId`; activities inside a shared lesson can also carry `branchId`. Each branch has a facts container in the curriculum root (`branches[]`) with `lastVerified` on time-sensitive facts.

**Unit `branch-pop`: Pop Lens** (prereq: `releases-industry`; branch `pop`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `pop-01` | The pop hit machine | Explain how pop hits are built: hooks, writing camps, tight structure. | pop-songwriting-machine, hook-craft | mc, st, bc, fg |
| `pop-02` | Eras, tours and reinvention | Read a pop star's eras and why reinventions are a strategy. | era, pop-era-tour | tm, mc, st, bc |
| `pop-03` | Pop fandom | Understand big-tent pop fandoms and what "the fandom" does. | pop-fandom, fandom | ds, mc, st, tk |

**Unit `branch-hip-hop`: Hip-Hop Lens** (prereq: `releases-industry`; branch `hip-hop`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `hh-01` | Beats, bars and flow | Say what bars, flow, cadence and a producer's beat are. | bars-flow, beat-producer | li, tm, mc, st |
| `hh-02` | Samples, features and mixtapes | Explain sample culture, guest verses and the mixtape tradition. | sampling-culture, feature-verse, mixtape | tm, mc, bc, st |
| `hh-03` | Regions, eras and rivalries | Place regional scenes and treat rivalries as culture, not gossip. | regional-scenes, diss-track | so, mc, ds, st |

**Unit `branch-rock-alt`: Rock and Alt Lens** (prereq: `releases-industry`; branch `rock-alt`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rock-01` | Riffs, power chords, solos | Recognise a riff, a power chord and a solo by name. | riff, power-chord, guitar-solo | li, tm, mc, st |
| `rock-02` | Subgenre map | Sketch punk, metal, indie, emo and shoegaze in a sentence each. | rock-subgenres, indie-alt | tm, mc, st, bc |
| `rock-03` | Live rock culture | Know mosh pit etiquette and why band-merch shirts matter. | mosh-etiquette, merch | ds, mc, bc, st |

**Unit `branch-country-folk`: Country and Folk Lens** (prereq: `releases-industry`; branch `country-folk`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `country-01` | Story songs and twang | Hear pedal steel, fiddle and storytelling as country's signature. | storytelling-song, twang-instruments | li, vi, mc, st |
| `country-02` | Nashville and the songwriter culture | Explain why the writer often matters as much as the singer. | nashville-songwriting, singer-songwriter | mc, tm, st, bc |
| `country-03` | Country crossover and its debates | Understand crossover, festivals and "is it really country?". | country-crossover, debate-authenticity | ds, mc, st, tk |

**Unit `branch-electronic`: Electronic and Dance Lens** (prereq: `releases-industry`; branch `electronic`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `edm-01` | DJ, producer, live act | Tell a DJ, a producer and a live electronic act apart. | dj-basics, beatmatching | tm, mc, tt, st |
| `edm-02` | House, techno, trance, dubstep, drum and bass | Map the big families by tempo and feel. | electronic-genre-map, four-on-the-floor | li, es, tm, mc |
| `edm-03` | Rave and festival culture | Know set-time culture, and conservative safety around heat, water and sound. | rave-culture, hearing-protection | ds, mc, bc, st |

**Unit `branch-rnb-soul`: R&B and Soul Lens** (prereq: `releases-industry`; branch `rnb-soul`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rnb-01` | Vocals, runs and stacks | Hear melisma and stacked harmonies as R&B's hallmark. | melisma, harmony-vocals | li, mc, tm, st |
| `rnb-02` | Slow jams, neo-soul and groove | Distinguish slow jam, neo-soul and contemporary R&B feels. | slow-jam, neo-soul | li, tm, mc, bc |
| `rnb-03` | Live band versus track | Understand why many fans prize live-band soul and vocal chops. | live-vs-studio, rnb-eras | mc, ds, st, bc |

**Unit `branch-latin`: Latin Lens** (prereq: `releases-industry`; branch `latin`). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `latin-01` | Rhythms: dembow, clave, cumbia | Recognise the dembow, the clave idea and cumbia's gait by ear. | dembow, clave, latin-rhythms | li, tm, mc, tt |
| `latin-02` | A map of Latin genres | Place reggaeton, salsa, bachata, regional Mexican and Latin trap. | latin-genres-map | tm, mc, so, st |
| `latin-03` | Spanish-language and the global charts | Explain why language is not a barrier to global success and how to ask about lyrics respectfully. | crossover-language, debate-album-vs-playlist | mc, ds, st, tk |

### Layer 5: Current season / live

Templates plus a `live` block; no hard-coded release news. New cards weekly (release week), seasonally (awards, festivals, tours). The unit `live` hook names the primary feed (`live.releases.week`); lesson hooks refine it (`live.tours.onsale`, `live.awards.season`, `live.charts.week`, `live.festivals.calendar`). If a provider is empty, lessons fall back to evergreen explainers.

**Unit `music-now`: Music Right Now** (prereq: `releases-industry`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `now-01` | This week's releases | Read a release-week card: who dropped what and why it matters. | release-context, release-friday | mc, st, ds, bc |
| `now-02` | Awards season, explained | Read nominations versus wins and how voting seasons run. | awards-basics, nominations-vs-wins | mc, bc, st, fg |
| `now-03` | Tour announcements and on-sales | Decode a tour announcement and its on-sale steps. | tour-announcement, presale-verified-fan | ds, mc, st, bc |
| `now-04` | Chart movement | Read a chart move: debut, climb, re-entry. | chart-movement, charts | mc, es, st, bc |
| `now-05` | Festival season | Read this season's festival calendar and headliner buzz. | festival-calendar, festival-basics | ds, mc, st, bc |

### Layer 6a: Conversation practice

**Unit `conversation-lab`: Conversation Lab** (prereq: `song-anatomy`, `rhythm`, `melody-harmony`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | "Have you heard the new album?" | Respond with real curiosity about an album she loves. | convo-follow-up-questions, album-cycle | tk, st, mc, fg |
| `talk-02` | Her playlist | React to a playlist she made without faking knowledge. | convo-playlist-share, playlist-curation | tk, st, mc, bc |
| `talk-03` | "I got tickets!" | Get excited and ask practical, kind questions. | convo-concert-plans, presale-verified-fan | tk, st, ds, mc |
| `talk-04` | After the show | Ask about the setlist and the moment she loved. | convo-after-show, setlist | tk, st, mc, fg |
| `talk-05` | What is your favourite song? | Answer honestly and ask theirs back. | convo-favorite-song, convo-taste-without-snobbery | tk, st, mc, bc |
| `talk-06` | Swapping recommendations | Offer a song and receive one gracefully. | convo-recommendation-swap, convo-admit-what-you-dont-know | tk, st, ds, mc |
| `talk-07` | Say-this gauntlet | Decode five lines in a row across genres. | convo-follow-up-questions, convo-admit-what-you-dont-know | st, st, st, st |

### Layer 6b: Perpetual review

**Review policy (`leitner-boxes-v1`):** intervals 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; concept below 0.6 re-enters at 1d. `review-03` (Ear check) is a mastery check for the listening concepts.

**Unit `review-loop`: Perpetual Review** (prereq: `song-anatomy`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Daily Bite | One due card from mastered concepts. | (due concepts) | mc, fg, tm, bc |
| `review-02` | Weekly mix | A three-round session sampled from weak concepts. | (due concepts) | mc, bc, ds, tk |
| `review-03` | Ear check | A listening boss: tempo, meter, major or minor, backbeat and genre sketch by ear. | tempo-bpm, time-signature, major-scale, minor-scale, backbeat, genre-signifiers | li, li, li, mc |
| `review-04` | Term blitz | A Playbook term drill. | (due concepts) | tm, fg, mc, tm |

### Concept targets, personalization slots, release plan

- **Concept count target:** 216 Playbook concepts in this map (88 with full definition and an enthusiast example line in `exercises.md`; the rest are authored in curriculum JSON). Appendix below.
- **Personalization slots:** `{{genre}}`, `{{artist}}`, `{{region}}`, `{{platform}}` (section 8).
- **Release plan:**
  - **Launch (v0.1 to 1.0):** `song-anatomy`, `rhythm`, `melody-harmony`, `instruments-sound`, `how-records-are-made`, `genre-map`, `releases-industry`, `live-music`, `conversation-lab`, `review-loop`; branch `pop` complete; listening clips for foundations. (Content that needs the ~110 audio clips ships in this order: rhythm, harmony, genre.)
  - **Fast follow (1.1):** `songwriting-arrangement`, `fandom-culture`, `music-now` (release, tours, awards, chart cards), branches `hip-hop`, `rock-alt`, `latin`.
  - **Ongoing:** `listening-like-a-fan`, `history-eras`, `debates-taste`, branches `country-folk`, `electronic`, `rnb-soul`; new talk tracks weekly during release/awards/festival seasons; refresh dated facts (chart formulas, ticketing, AI) every quarter; candidate branches later (see section 1).

### Appendix: Playbook concepts (ids by unit of first appearance)

What a Song Is Made Of: `song-structure`, `verse`, `chorus`, `intro-outro`, `hook`, `earworm`, `pre-chorus`, `build-and-release`, `bridge`, `drop`, `breakdown`.

Rhythm and Groove: `beat`, `tempo-bpm`, `bar-measure`, `time-signature`, `backbeat`, `four-on-the-floor`, `syncopation`, `swing-shuffle`, `groove-pocket`, `fill`, `half-time`.

Melody, Harmony and Key: `pitch`, `melody`, `octave`, `major-scale`, `minor-scale`, `chord`, `triad-major-minor`, `key-tonic`, `chord-progression`, `four-chord-song`, `tension-resolution`, `cadence`, `key-change`, `harmony-vocals`.

Instruments, Voices and Sound: `rhythm-section`, `bass-line`, `drum-kit`, `electric-vs-acoustic`, `synthesizer`, `lead-vocal`, `backing-vocals`, `vocal-range`, `falsetto`, `timbre`, `attack-decay`, `dynamics`, `texture-layers`.

How a Record Gets Made: `songwriter`, `producer`, `audio-engineer`, `session-musician`, `demo`, `multitrack`, `stems`, `mixing`, `eq`, `panning-stereo`, `compression`, `reverb-delay`, `mastering`, `loudness`, `sample`, `interpolation`, `cover-version`, `remix`, `pitch-correction`.

The Genre Map: `genre`, `subgenre`, `blues-roots`, `genre-family-tree`, `pop-music`, `genre-blend`, `genre-signifiers`, `indie-alt`, `scene-movement`.

Songwriting and Arrangement: `topline`, `writing-credits`, `hook-craft`, `narrative-lyric`, `imagery-metaphor`, `rhyme-scheme`, `prosody`, `arrangement`, `co-writing`, `singer-songwriter`.

Releases, Labels and Charts: `release-formats`, `mixtape`, `release-friday`, `album-cycle`, `lead-single`, `deluxe-edition`, `record-label`, `independent-artist`, `distributor`, `streaming-royalties`, `publishing-vs-master`, `charts`, `streaming-units`, `first-week`, `certification`, `playlist-curation`, `algorithmic-discovery`, `year-end-recap`, `vinyl-basics`, `variants-pressings`, `physical-resurgence`.

Live Music and Concert Culture: `concert-flow`, `setlist`, `encore`, `venue-types`, `venue-capacity`, `presale-verified-fan`, `dynamic-pricing`, `ticket-fees`, `resale-face-value`, `ga-pit-reserved`, `sightlines`, `festival-basics`, `set-clash`, `stages-sets`, `concert-etiquette`, `hearing-protection`, `crowd-safety`, `tour-leg`, `residency`, `surprise-song`, `merch`.

Fandom and Community: `fandom`, `stan`, `parasocial`, `era`, `easter-egg`, `fan-theory`, `deep-cut`, `b-side`, `album-track`, `fan-ritual`, `fan-project`, `gatekeeping`, `fan-boundaries`.

Listening Like a Fan: `active-listening`, `sonic-signature`, `chord-quality`, `stereo-image`, `live-vs-studio`, `backing-tracks`.

How We Got Here: `gospel-roots`, `folk-tradition`, `rock-and-roll`, `album-era`, `soul-funk`, `disco`, `punk`, `hip-hop-origins`, `mtv-era`, `grunge-alt-90s`, `digital-download-era`, `tech-shapes-music`, `streaming-era`, `viral-discovery`.

Debates and Taste: `debate-authenticity`, `debate-live-vocals`, `debate-album-vs-playlist`, `debate-streaming-pay`, `copyright-sampling`, `ai-music`, `debate-ticketing`, `nostalgia-bias`, `taste-vocabulary`, `convo-taste-without-snobbery`.

Pop Lens: `pop-songwriting-machine`, `pop-era-tour`, `pop-fandom`.

Hip-Hop Lens: `bars-flow`, `beat-producer`, `sampling-culture`, `feature-verse`, `regional-scenes`, `diss-track`.

Rock and Alt Lens: `riff`, `power-chord`, `guitar-solo`, `rock-subgenres`, `mosh-etiquette`.

Country and Folk Lens: `storytelling-song`, `twang-instruments`, `nashville-songwriting`, `country-crossover`.

Electronic and Dance Lens: `dj-basics`, `beatmatching`, `electronic-genre-map`, `rave-culture`.

R&B and Soul Lens: `melisma`, `slow-jam`, `neo-soul`, `rnb-eras`.

Latin Lens: `dembow`, `clave`, `latin-rhythms`, `latin-genres-map`, `crossover-language`.

Music Right Now: `release-context`, `awards-basics`, `nominations-vs-wins`, `tour-announcement`, `chart-movement`, `festival-calendar`.

Conversation Lab: `convo-follow-up-questions`, `convo-playlist-share`, `convo-concert-plans`, `convo-after-show`, `convo-favorite-song`, `convo-recommendation-swap`, `convo-admit-what-you-dont-know`.

Conversation ids used by the review loop are pseudo-references (`review-*` lessons draw from due concepts) and are not Playbook entries.

---

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4): Unity only where spatial reasoning, movement, physics, timing *in a scene* or camera perspective materially improves learning and a native exercise would teach it clearly worse. **This course has zero Unity sims.** Music unfolds in *time and sound*, not in a 3D scene; the concepts that feel "like movement" (a build, a groove, a drop) are experienced better through audio plus a 1D timing bar than through any scene. Native audio, diagrams and judgment exercises are strictly better tools here.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Rhythm and harmony by ear (tempo, meter, backbeat, swing, major/minor, chord colour) | tempo-bpm, time-signature, backbeat, swing-shuffle, major-scale, minor-scale, chord-quality | `listening-id` (`original-swoond` synthesised clips; A/B pairs are packed in one clip with a spoken-free click marker) | The concept *is* the sound. Reading "swing" teaches nothing; hearing it does. Synthesised audio keeps everything licensed (spec section 20/40). Closest alternative: `multiple-choice` with a text description, which cannot teach hearing. | B | ~80 |
| Genre sketches by ear | genre-signifiers, four-on-the-floor, dembow, backbeat | `listening-id` | Original 12 s sketches "in the style of" (tempo, drum pattern, instruments) that imitate genre habits, never a real song. | B | ~30 (in the 80) |
| Tap-along rhythm (backbeat, dembow, beatmatch) | beat, backbeat, tempo-bpm, groove-pocket, dembow, beatmatching | `timing-tap` | Rubric row "Simple 1D timing bar: native". Each sweep equals one bar; the gold zone marks the beat. Audio latency is a native concern, no scene needed. | B | ~14 |
| Song maps, venue floor plans, mixer strips, keyboard | song-structure, ga-pit-reserved, panning-stereo, pitch | `hotspot-tap` (procedural diagrams) | Static diagram; the answer is *where*, not *when*. | B | ~20 |
| Recognising instruments, vinyl variants, venue types | rhythm-section, variants-pressings, venue-types | `visual-id` (original illustrations, `original-swoond`) | Recognition; no third-party photos or logos. | B | ~30 |
| Magnitudes (BPM, decibels, stream counts, capacities) | tempo-bpm, hearing-protection, streaming-units, venue-capacity | `estimate-slider` | Numeric intuition; dated numbers are release-checked. | B | ~20 |
| Sequences (song form, concert flow, how a record is made, album rollout) | song-structure, concert-flow, demo, album-cycle | `sequence-order` | Order is the concept; per-step `why` carries the logic. | B | ~30 |
| Tickets, festival planning, hearing safety, fandom etiquette | dynamic-pricing, set-clash, hearing-protection, gatekeeping | `decision-scenario` | Judgment with consequences and an expert note; `safetyNote` where needed (hearing, crowds). | B | ~60 |
| Vocabulary and quick checks | all | `term-match`, `fill-the-gap`, `multiple-choice`, `binary-call` | Recall and recognition; binary rule calls (master vs publishing, sample vs interpolation). | B | ~450 combined |
| Conversation | all | `say-this`, `talk-track` | Native conversation practice; Talk tab and unit ends. | B | ~150 say-this + 20 talk tracks |

**Unity considered and rejected (recorded so the question does not reopen):**

| Idea | Why not Unity |
|---|---|
| Virtual mixing desk with faders and pan | A static `hotspot-tap` plus `listening-id` with an already-mixed clip teaches the concept; a live sim needs an audio engine and adds nothing but polish. |
| Rhythm game (Guitar Hero-style) | Would teach playing, not understanding; duplicates `timing-tap` in a costlier form; latency problems. |
| 3D concert venue with a crowd | Judgment ("GA or seats") is taught by `decision-scenario` and `hotspot-tap`; a scene invites entertainment instead of learning and crowd-safety framing risks. |
| Spatial-audio stage demo | Requires headphone-specific rendering; a native `listening-id` describing stereo width is enough. |
| Chord or scale visualiser | Diagrams and audio suffice; Game Kit has no music primitives (see `NOTES_FOR_ORCHESTRATOR.md`). |

**Native types used:** all 13 native types appear (see `exercises.md`). `unity-sim` is not in `interactionTypes`.

**Accessibility:** each `listening-id` has a written description (schema-required) and a paired non-audio exercise elsewhere in the lesson (`visual-id`/`hotspot-tap`) so a Deaf or hard-of-hearing learner can master the same concept. Reduce Motion replaces sweeps with the `tap-to-stop-slow` alternative.

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| Audio | **Only original synthesised or produced audio (`original-swoond`), or audio under an explicit registered licence.** No commercial recordings, no snippets of hits, no covers of copyrighted songs, no "in the style of [named song]" clones that imitate a specific work. Genre sketches are generic. Any third-party audio (e.g. Creative Commons or a commissioned artist track) requires a licence id, attribution text and a written check that the licence allows in-app redistribution; the default is *none at launch*. Streaming a real song happens only via the platform's official app or embed (deep link / MusicKit / platform SDK) under its terms, never through Swoon'd's own audio files. |
| Lyrics | **Never reproduced or ingested**, not even short quotes in lessons. Talk about themes, structure and effect in our own words. Example lines in conversation items are *invented*, not quoted. |
| Album art, artist photos, posters | Not used without a written licence. Text and original illustrations only. Cover-art databases (Cover Art Archive etc.) are **not** a licence to reuse the images. |
| Logos / trademarks | Label, tour, festival, platform (Spotify, Apple Music, YouTube, Ticketmaster) and awards marks: text mentions and link-outs only. |
| Video | No embedded concert or music-video footage; deep-link to official channels. |
| Article / review text | Never copied; headlines with link only; explain in our own words. |
| Data terms | MusicBrainz core data is open (CC0) but check per-dataset terms; Spotify/Apple/Ticketmaster/Bandsintown APIs have restrictive terms (no caching beyond terms, no ML training, attribution). Billboard/Luminate chart data is licensed: link-out and curated summaries only. Setlist.fm terms restrict commercial use. Every provider sits behind an adapter (spec section 32). |
| Artist likeness | Names as facts only; no fabricated quotes; no implied endorsement. |
| Privacy | The learner's chosen artist and listening notes are personal data; never sold, never shown to the other person without consent. |
| **Safety: hearing** | Conservative mainstream guidance: loud music can cause cumulative hearing damage; use music earplugs, stand away from speakers, take breaks, see a professional for persistent ringing. General information, not medical advice. |
| **Safety: crowds** | Note exits, keep water, know where friends are, step out of crowds that feel unsafe; teach de-escalation not confrontation. Mosh-pit and rave content is descriptive and safety-first; never encourages risk. |
| **Safety: substances, driving, alcohol** | Not encouraged, not depicted; festival lessons say "look after yourself and each other" and leave it there. |
| **Safety: stalking and privacy** | Never coach chasing an artist, finding home addresses or approaching artists off-stage; fan-boundary lessons teach respect. |
| **Safety: scams** | Ticket scams and "too good" resale offers are taught as a hazard; recommend official resale channels. |
| **Safety: mental health** | Music can be tied to grief or hard times. Lessons never make light of it; no diagnoses; the coach voice stays warm and points to real people, not the app. |
| Voice / people | Never mock a genre, an artist or a fandom; jokes target our learner's ignorance, never the crush or her taste. K-pop is left to its own course. |

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Listening clips (~110 at launch; 6 to 14 s each; AAC; ~100 to 220 KB) covering tempo, meter, backbeat, swing, mood, chord colour, timbre, genre sketches, stereo width, builds and drops | Original synthesised/produced audio, MIDI written by Swoon'd staff (not derived from any existing work), rendered with own patches/samples or royalty-free instruments with a commercial licence recorded in the registry | Swoon'd audio design (or a commissioned composer under a work-for-hire agreement) | `original-swoond` |
| Song-map, venue floor plan, mixer strip, keyboard diagrams | Procedural SVG/SwiftUI | Generated | `original-swoond` |
| Instrument, vinyl-variant and venue-type illustrations | Original vector art | Swoon'd | `original-swoond` |
| Playbook glossary cards | Text | Authored | n/a |
| Live cards (release week, tours, awards) | Structured metadata + editorial text | Adapters and editors | n/a (no images) |
| Artist and release pages | Text and links only (MusicBrainz ids for disambiguation) | Adapters | n/a |

No third-party imagery or audio at launch.

---

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** The song map, beat and backbeat, major vs minor, key and chords in plain words, the rhythm section and timbre, who makes a record, and the mix/master pipeline (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Specific moments, eras, credits, deep cuts, live vs studio, releases and charts, the ticket saga, debates (section 4).
- [x] 3. **What current information matters?** Release weeks, tour announcements and on-sales, festival and awards calendars, chart moves, the ticketing and AI stories (section 6).
- [x] 4. **What should be interactive?** Listening (synthesised audio), tap-along rhythm, song maps and floor plans, decision scenarios for tickets and safety, and conversation practice. **Zero Unity sims** (section 12).
- [x] 5. **What should NOT be gamified?** Taste, fandom identity, grief, artists' private lives, ticket-scalping hacks, hearing risk, chart rivalry (section 5).
- [x] 6. **How should it personalize?** Genre (branch), artist, region, platform (section 8).
- [x] 7. **What does conversational competence look like?** Decode her line, ask an honest question about a moment, admit what you do not know, swap songs kindly (sections 9, 10).
- [x] 8. **What data providers are needed?** MusicBrainz, Apple Music/MusicKit, Spotify Web API (terms), Ticketmaster Discovery, Bandsintown/Songkick, curated festival/awards pages, chart link-outs, press headlines (`live-data.md`).
- [x] 9. **What licensing constraints apply?** Audio, lyrics, art, logos, video, article text, data terms, likeness (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, review ladder, ear check (`review-03`), talk-track Smooth score >= 60, competence statement (section 10).

Additional gates: [ ] manifest validates (run `tools/validate`); [ ] curriculum validates (not yet authored); [x] every Unity sim has an approved spec (vacuous: zero sims); [ ] every image/audio asset has a license id (assets not yet produced; ids defined: `original-swoond`); [ ] voice review; [x] no copied publisher text or lyrics (all copy and example lines are original).

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Who produces the ~110 listening clips (in-house sound designer, commissioned composer, or a licensed royalty-free instrument pack), and what is the work-for-hire terms? Is a lightweight synthesiser pipeline acceptable? | Product | Yes for `listening-id` content, no for the rest |
| 2 | Legal review: can the app play platform-licensed audio (Apple MusicKit, Spotify SDK) inside lessons for "listen to the song she loves", or must it only deep-link out? | Product/Legal | No (default: deep-link out) |
| 3 | Confirm the Billboard streaming ratios (Jan 2026 change: 1,000 paid or 2,500 ad-supported streams per album unit; Hot 100 song ratios) before `rel-05` ships. | Content | No |
| 4 | Ticketing litigation: the April 2026 jury verdict and the state-level remedies are unresolved; confirm status before `debate-07` and `talk` items ship; keep phrasing neutral. | Content/Legal | No |
| 5 | AI music: confirm Suno/Udio/label settlements and the Spotify-Universal tool status; the Sony case status; edit `debate-06`. | Content | No |
| 6 | Grammy 2027 dates (ceremony Feb 7, 2027; nominations Nov 16, 2026; eligibility Aug 31, 2025 to Aug 28, 2026) are from press; verify against the Recording Academy site. | Content | No |
| 7 | Is a `tap-along` audio-synchronised exercise worth a native type, or is `timing-tap` with sweeps enough? | Claude/Product | No |
| 8 | A/B compare clips: propose adding an optional second audio field to `listening-id`? Workaround is one clip with two segments. | Claude | No |
| 9 | Should `jazz` and `classical` be separate catalog entries? | Product | No |
| 10 | Which licensing route for the Spotify Web API, given restricted endpoints and dev-mode limits for new apps? | Product/Data | No |
| 11 | Editorial provider choice for music news (DECISIONS Q-3). | Product | No |
