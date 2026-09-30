# Dynamic Data and Editorial Plan: Horror Films (`horror-films`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-37 (provider isolation, news) and, above all, **section 40 (media courses: talk about works, never redistribute them)**. Provider terms shared with `movies` are in `docs/courses/movies/live-data.md`; this file covers only what is horror-specific. Facts were checked by web search on **2026-09-30** and are tagged **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Yes, lightly, and it is mostly editorial with a strong seasonal rhythm.** Horror has no scores or standings. What changes: what opens this weekend and what *kind* of scary it is, which low-budget film just over-performed, what a genre festival crowd loved, what is new on horror streamers, where horror sits in the awards race, and what the fandom is arguing about. Volume spikes in September-October ("spooky season"); a quieter baseline runs the rest of the year.

Do not invent more (spec section 10): no kill-count stats, no "scariest" rankings, no scare-meter scores, no per-actor data, no trending algorithm, no showtime scraping.

**Hard rule:** the live layer never stores or displays posters, key art, stills, trailers, clips, score, dialogue, synopses, review text or parents-guide text. Titles, names, dates, numbers and Swoon'd-authored sentences only, plus link-outs. **Comfort rule:** every live card carries an intensity line that obeys the comfort dial (`gentle` hides detail and frames the card as "talk about it"; `balanced` shows public rating and subgenre; `full` adds rating-reason link-out). Live cards are **non-graphic** and never describe violence beyond "a violent death".

## 2. Current-context layers

| Layer | Content | Unit / hook |
|---|---|---|
| Release calendar | Theatrical, streaming and Shudder premieres, each tagged by subgenre and "dread or shock" | `lv-01` `live.releases.horror` |
| Box office top line | Horror weekend story: budget, opening, legs, over/under-performance | `lv-02` `live.rankings.boxoffice` |
| Festivals | Fantasia (July), FrightFest (August), Fantastic Fest (September), Sitges (October), Sundance Midnight (January), SXSW Midnighters (March) [verify at release] | `lv-03` `live.events.festivals` |
| Streaming and gentle picks | Where to watch; a curated "gentle picks" list for lower comfort dials | `lv-04` `live.newmedia.streaming` |
| Awards | When horror is in the race: nominations, winners, the argument | `lv-05` `live.events.awards` |
| Editorial explainers | "Why is everyone talking about this?" | `lv-06` `live.news.explainer` |

## 3. Data kinds, providers, refresh

| Kind | Provider candidates (behind Swoon'd-owned adapters) | Refresh | Fallback |
|---|---|---|---|
| `releases` / `schedules` | **Launch: curated Swoon'd editorial calendar** from public studio and festival announcements; Wikidata (CC0) for structured dates. Later: licensed metadata provider (see movies L-13) | Weekly; daily Sep-Oct | Last published calendar with its date; evergreen "how to pick a first horror film" card |
| `rankings` (box office) | Curated attributed top line. The Numbers / Comscore only under a licence; Box Office Mojo has no API | Weekly (Monday) | Static "how to read a horror box office" card |
| `events` | Official festival and awards announcements (curated); Wikidata (CC0); Wikipedia (CC BY-SA, attribute) | Daily in festival and awards weeks | Last season's results as history |
| `new-media` (availability) | Watchmode, Streaming Availability API, JustWatch partner API, TMDB watch providers (all need commercial licences; TMDB is non-commercial without agreement) | Daily | Hide availability, keep the lesson; "check your services" text |
| `news` | Publisher RSS headlines as link-only (Bloody Disgusting, Dread Central, Fangoria, Variety, THR, Deadline, IndieWire, Screen Daily, Sight and Sound); Swoon'd writes its own explainers (movies L-01) | Daily | Evergreen explainers |
| Not used | `statistics`, `standings`, `scores`, `rosters`, `injuries`, `weather`, `closures`, `alerts`, `regulations`, `transactions`, `new-products` | - | - |

**No provider is a production dependency before its licence is confirmed.** Launch runs on curated editorial plus Wikidata.

## 4. Content-intensity data (unique to this course)

| Question | Answer |
|---|---|
| Source | Official public rating and rating-reason text (MPA, BBFC, IFCO-class boards) as a **factual link-out**, plus a Swoon'd-authored one-line "kind of scary" note (subgenre, dread or shock, pacing). |
| Not used | Common Sense Media, IMDb parents guide, "does the dog die"-style sites, Letterboxd and Reddit threads: user-generated or copyrighted; link-out at most, no scraping or mirroring. |
| Display by dial | `gentle`: no intensity detail, "talk about it" framing. `balanced`: rating plus subgenre. `full`: adds the rating-reasons link-out. |
| Never | Content-warning text that describes violence, sexual violence, self-harm, child harm or animal harm in detail. Topic names only, as literacy. |
| Open | Is own-words plus link-out enough, or is a licensed content-advisory provider desirable? (CDS open question 7; NOTES item 6.) |

## 5. Normalized entities (Swoon'd-owned; no provider schema leaks)

| Entity | Fields |
|---|---|
| `HorrorTitle` | `id`, `title` (text), `year`, `subgenres[]` (ids from the map), `kindOfScary` (`dread`, `shock`, `gross-out`, `uncanny`, `thrill`, `comedy`), `ratingLabel`, `ratingBoard`, `ratingReasonsURL`, `directorIds[]`, `franchiseId?`, `wikidataId?` |
| `ReleaseEvent` | `titleId`, `kind` (`theatrical`, `streaming`, `festival`, `physical`), `date`, `region`, `platformId?`, `officialURL` |
| `FestivalEdition` | `festivalId`, `year`, `startDate`, `endDate`, `city`, `prizeWinnerTitleIds[]` |
| `BoxOfficeNote` | `weekendOf`, `titleId`, `openingUSD?`, `budgetUSD?`, `source`, `sourceURL`, `swoondLine` |
| `AvailabilityCard` | `titleId`, `platformId`, `region`, `kind`, `checkedAt`, `sourceId` |
| `ExplainerCard` | `id`, `swoondText`, `linkOuts[2]`, `sayThisLine`, `intensityNote`, `publishedAt`, `expiresAt` |
| `GentlePick` | `titleId`, `whyGentle` (Swoon'd text), `ratingLabel`, `reviewedAt` |

No image, poster URL, trailer URL (except an official-channel link-out) or quotation field exists in any entity.

## 6. Refresh cadence and freshness

| Cadence | Applies to |
|---|---|
| Daily (Sep-Oct) | Releases, new-on-streaming, editorial cards |
| Weekly | Release calendar, box-office line, gentle picks |
| Event-driven | Festival editions, awards nominations and winners, Friday-the-13th card, anniversary moments |
| Seasonal | Spooky-season collection (1 Sep - 1 Nov), festival dispatches each July, September, October; awards cards each January-March |
| Freshness | Time-sensitive concepts carry a 90-day freshness flag; cards show "as of" dates; stale cards hide rather than mislead |

## 7. Editorial plan (spec sections 11, 37)

- **Approach:** `explain-and-link`. Swoon'd writes 3-5 "Why is everyone talking about this?" cards weekly (daily in October); each cites two link-outs, carries a `say-this` line and an intensity note.
- **Voice:** cheeky coach, never mocking a fandom or a low tolerance, never gatekeeping, never about the crush.
- **Examples:** "Why did a small horror film beat a tentpole this weekend?" "What does 'legacy sequel' promise this time?" "Why are people arguing about the label 'elevated'?" "What did the midnight crowd love?"
- **Never:** copied publisher text, critic quotes, synopses, "scariest scene" write-ups, real-crime dramatisation, pirate sources.

## 8. Time-sensitive facts snapshot (2026-09-30) [verify at release]

| Fact | Status |
|---|---|
| 98th Oscars (15 Mar 2026) | *Sinners* record 16 nominations, four wins (Best Actor, Original Screenplay, Original Score, Cinematography); *Weapons* Best Supporting Actress; *Frankenstein* three craft wins; Best Picture went to *One Battle After Another* [verify] |
| Festivals 2026 | Sitges 8-18 Oct 2026; Fantastic Fest 2026 dates to confirm [verify] |
| 2025 horror box office | *The Conjuring: Last Rites* the year's top horror by most counts; figures differ by source [verify] |
| Fall 2026 slate | Resident Evil, Clayface, V/H/S/Mixtape and others [verify] |
| Platform ownership | Shudder under AMC Networks [verify] |
| "Elevated horror" term | Coined by Steve Rose in *The Guardian*, July 2017 (evergreen) |

None of these is hard-coded into evergreen lessons; they reach the learner through `live` hooks and `{{tokens}}`.

## 9. Personalization hooks

| Dimension | Live effect |
|---|---|
| `genre` | Flag releases by subgenre; subgenre-matched gentle picks |
| `director` | New releases and interviews for her director |
| `franchise` | Sequel, legacy sequel and anniversary cards for her saga |
| `platform` | Availability on her services; Shudder cards only if she uses it |
| `region` | Regional horror festivals, dub and sub norms, local availability |
| Comfort dial | Intensity line detail, audio previews, "talk about it" framing (private; never sent to analytics in a way that reveals it; discreet-mode rules apply) |

Notifications never name the Person (discreet mode); an example: "A new festival favourite is out this week. Want the 20-second version?".

## 10. Adapter and fallback notes

- Adapter protocols live in SwoondCore; provider DTOs stay internal to their adapters (D-004).
- Each adapter returns normalized entities plus `checkedAt`. On failure the UI shows the last good card with its date, or the evergreen fallback.
- Availability is the only entity that may be region-specific; unknown availability hides the card and never suggests unlicensed sources.
- Wikidata and Wikipedia reuse: attribute CC BY-SA text; never mirror images.

## 11. Open items

1. Which availability provider and licence (movies L-13).
2. Box-office source licence (movies L-14); default curated top line only.
3. Whether to license a content-advisory provider for the intensity line.
4. Wording of festival, awards and platform names in store copy (movies L-15).
5. A dedicated spooky-season surface (CDS open question 9).
