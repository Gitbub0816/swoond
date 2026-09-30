# Course Design Specification: <Display name> (`<course-id>`)

Template implementing product spec section 8 plus curriculum planning and the section 47 quality gate. Copy to `docs/courses/<course-id>/CDS.md`. Every section must be answered specifically for this interest; do not paste generic text. Unknowns go in "Open questions".

| Field | Value |
|---|---|
| Status | draft / approved |
| Wave | 1 / 2 / 3 |
| Author / date | |
| Manifest | `manifest.json` |

---

## 1. Identity
- **Course ID:** `<kebab-case>` (immutable)
- **Display name:**
- **Category / family:** (one of the 19 families; category path)
- **Simulation prefix:** (for sim IDs)
- **Related courses & boundary test (spec section 6):** for each related interest: "If someone learns A, are they meaningfully conversationally competent about B?" Answer, verdict (shares foundation / adjacent / independent), consequence for course structure.
- **Branches:** id, name, what changes (rules, data, culture).

## 2. Beginner model
- What does a complete beginner typically know?
- What terminology will initially confuse them?
- Common misconceptions.
- Concepts that unlock the rest of the subject (these become foundation units).

## 3. Foundational knowledge
As applicable: rules, terminology, concepts, strategy, history, culture, equipment, techniques, participants, organizations. Group into modules (these become `foundationalModules[]` and foundation units).

## 4. Enthusiast model
- What do actual enthusiasts talk about?
- Distinctions that matter to them.
- Knowledge that signals genuine understanding.
- Beginner statements that sound obviously uninformed.
- Common controversies and debates.

## 5. Interaction model
- What should the learner EXPERIENCE instead of reading?
- Does the course warrant a Unity simulation? Would native interactions be more effective? Would visual identification, decision scenarios, sequencing or listening help?
- What should NOT be gamified?
- Summarize the chosen mix; details in section 12 (Interaction plan).

## 6. Dynamic information requirements
For each of scores, schedules, standings, statistics, rankings, events, releases, conditions, news, weather, closures, new products, new media: needed? why? (Do not invent live data needs; spec section 10.) Provider candidates, refresh frequency, adapter notes, fallback when the provider is down. Structured data and editorial data are separate systems.

## 7. Editorial context
- What commentary helps the learner understand current discussion?
- Appropriate external sources; licensing restrictions.
- Summarize, explain, or simply link? (default: explain in our own words and link; never copy publisher text.)
- Example prompts ("Why are fans talking about this today?").

## 8. Personalization
Dimensions (team, player, driver, league, series, artist, genre, author, region, equipment, destination, franchise, platform...), how each changes examples and live context, the default value used when unset, and which units use `{{tokens}}`.

## 9. Conversation model
- What might an enthusiast naturally say? (list 10+ example lines with translation)
- What does each statement mean and what terminology is implied?
- What could the learner meaningfully ask next?
- How does Swoon'd help without encouraging fake expertise?
- Target number of talk tracks and say-this items.

## 10. Assessment
- How is useful competence determined?
- What should the learner recognize / understand / explain / correctly interpret?
- Mastery model: pass threshold; the one-sentence "useful competence statement".

## 11. Curriculum map (ongoing course)
Designed as an ONGOING course, not a deck. Table per layer: `unit id | unit title | prerequisites | lessons (count + titles) | main concepts`. Every layer must be present or explicitly N/A with reason.

| Layer | Purpose | Minimum expectation |
|---|---|---|
| Foundations | Terms, rules, how it works | 4+ units, ~20+ lessons |
| Intermediate | Strategy, distinctions, context | 4+ units |
| Enthusiast depth | What fans debate; nuance; history/culture | 3+ units |
| Current-season / live layer | Ongoing, refreshed from live data and editorial | Templates + `live` hooks; new items weekly/seasonally |
| Conversation practice | Talk tracks, say-this, "what is she talking about?" | Continuous; 10+ tracks |
| Perpetual review | Spaced review of mastered concepts | Review policy defined (intervals, max items) |

Also list: concept count target (Playbook), personalization slots, release plan (what ships at launch vs later updates).

## 12. Interaction plan
Every activity family maps to a native type or Unity sim with justification. Add one row per activity family (individual items are in curriculum JSON).

| Lesson / activity family | Concepts | Type (native exercise or `unity-sim`) | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| | | | | A/B | |

For each Unity row, the Tier rubric answer and the sim spec path (`sims/<simulationId>.md`). Native rows link to the type in `docs/native-exercises/CATALOG.md`.

## 13. Licensing & safety
Media rights (imagery, audio, logos/trademarks, lyrics, video, player likeness, data terms) and how each is handled (spec sections 39-40 and rule 10). Safety constraints (e.g. real-world risk in outdoors, cooking, climbing).

## 14. Content assets
Images/audio/diagrams needed, procedural vs licensed, sources.

## 15. Section 47 quality checklist (must be all answered before release)

- [ ] 1. What does a beginner need to understand?
- [ ] 2. What do enthusiasts care about?
- [ ] 3. What current information matters?
- [ ] 4. What should be interactive?
- [ ] 5. What should NOT be gamified?
- [ ] 6. How should it personalize?
- [ ] 7. What does conversational competence look like?
- [ ] 8. What data providers are needed?
- [ ] 9. What licensing constraints apply?
- [ ] 10. How will Swoon'd measure useful understanding?

Additional gates: [ ] manifest validates; [ ] curriculum validates; [ ] every Unity sim has an approved spec; [ ] every image/audio asset has a license id; [ ] voice review (cheeky coach, never mean, never about the crush); [ ] no copied publisher text.

## 16. Open questions
| # | Question | Owner | Blocking? |
|---|---|---|---|
