# Course Design Specification: Video Games (`video-games`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 2 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/games.controls.aim-assist.v1.md`, `NOTES_FOR_ORCHESTRATOR.md` |

Time-sensitive facts (release dates, prices, event results) were checked by web search on 2026-09-30 and are tagged **[verify at release]**. Several price and hardware figures came from secondary aggregator sites, not first-party pages; treat them as unconfirmed until re-checked. Lesson copy never hard-codes them: dated facts live in `live-data.md` cards and versioned tokens, and evergreen lessons teach the durable idea (for example "console prices moved up in 2026" is a live card, not a lesson fact).

---

## 1. Identity

- **Course ID:** `video-games` (immutable)
- **Display name:** Video Games
- **Category / family:** Gaming > Video games (family `Gaming`)
- **Simulation prefix:** `games`
- **What kind of course this is.** "Video games" is not a sport with one rulebook. It is a *media and hobby ecosystem*: thousands of works, a handful of platforms, several culturally distinct genre communities, a spectator layer (esports and streaming), and a very active discourse. The person she is learning for might be a Switch-and-cozy-games person, a ranked-Valorant person, a Souls-boss person or a "long RPG on a weekend" person. Those people barely share a vocabulary beyond the basics. So the course has a **wide shared trunk** (platforms, anatomy of a game, genre map, modes and business, gamer vocabulary, mechanics you can feel, how to play *with* someone) and **genre branches** that carry the depth. Franchise and platform personalize examples and the live layer.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Movies (`movies`, wave 2), Anime (`anime`), Books | Share the *media* frame (talk about works, spoilers, recommendations, franchises, fandom) but not the substance: games are played, and the conversation is about mechanics, progression, difficulty and multiplayer social life. Story-heavy games overlap with film talk only for cutscenes and writing. | Adjacent, independent | Cross-link `franchise`, `spoiler-etiquette` and adaptation talk (a game becoming a show). No shared units. |
| Soccer, Basketball, American Football, Hockey, NASCAR, Formula 1 | Sports *video games* (Madden, EA Sports FC, NBA 2K, F1 game) are games first: modes (career, ultimate team), controls, monetization. Knowing the sport does not tell you what "Ultimate Team packs" or "sweaty online" mean. The reverse also holds. | Adjacent, independent | Sports and racing games are a lighter tour inside `genre-map` and a v1.1 branch candidate (`sports-racing`); cross-link to the sport course for the sport itself. |
| Esports as a *sport* | Esports is spectating games at a pro level. It needs game literacy first (roles, drafts, maps) and then its own structure (leagues, splits, tentpoles). | Shares foundation | One unit `esports-awareness` inside this course plus per-branch depth (MOBA, shooters, fighting). Not a separate course at launch; revisit if demand is large (open question 6). |
| Anime, K-pop, Music | Share fandom culture and many crossovers (rhythm games, gacha tie-ins, game soundtracks). | Adjacent, independent | Mention crossovers as culture lessons only. |
| Tech / PC building (future course) | PC gaming leans on hardware talk (GPU, frame rate). | Adjacent | Only the *decode-the-spec-talk* lesson `plat-07`; no build content. |

- **Branches (genres as branches).** A branch is a genre community whose vocabulary and debates a learner meets when the person she cares about lives there. A learner can select more than one branch; branch lessons appear only for selected branches (see open question 1).

| id | Name | What changes |
|---|---|---|
| `shooters` | Shooters | FPS, tactical shooters, battle royale, hero and extraction shooters. Recoil, time-to-kill, round economy, aim assist, ranked. Links to the aim-assist sim. |
| `action-adventure` | Action and adventure | Boss-pattern games (Souls-likes), open worlds, platformers, Metroidvanias, story-driven adventures. "Learning by dying", i-frames, exploration design. |
| `rpg` | Role-playing games | CRPG, JRPG, action RPG, MMO. Builds, party composition, turn-based vs real-time, raids, gear score, gacha pity. |
| `strategy-moba` | Strategy and MOBA | MOBAs, RTS, 4X, auto-battlers, deckbuilders. Lanes, farming, build orders, drafts, patch and balance culture. Feeds `esports-awareness`. |
| `fighting` | Fighting games | 1v1 fighters and the FGC. Frame data, neutral, combos, rollback netcode, tournament sets. |
| `cozy-sim` | Cozy, sim and sandbox | Farming and life sims, building and survival sandboxes, decorating. Routines, community, sharing worlds. Lowest-pressure branch and the friendliest entry for a beginner playing *with* her. |

Personalization dimension set when a branch is chosen: `genre`. Branch default when none is selected: no branch units are shown and the learner sees the `genre-map` tour; onboarding asks "What does she play most?" (multi-select).

---

## 2. Beginner model

**What a complete beginner knows.** Mario, Minecraft, Fortnite (maybe as a dance), Call of Duty (as "the shooting one"), that "gamer" is an identity, that headsets and screaming exist, that games cost money, and that a phone game is not the same as "real" gaming (a live debate, not a fact). Some have played Wii Sports, Candy Crush or a childhood console, so they know a controller has buttons. Almost nobody knows why a person would replay one boss forty times, why two people who both "play games" cannot discuss each other's games, or why a $70 price tag started an argument.

**Terminology that confuses:** console vs PC vs "rig", Steam, Game Pass, crossplay, cross-save, FPS (the genre) vs fps (the frame rate), tank / healer / DPS, nerf, buff, meta, RNG, grind, farm, carry, tilt, smurf, ranked, MMR, "-like", "-vania", roguelike vs roguelite, live service, battle pass, gacha, pity, DLC, early access, patch, i-frames, hitbox, aim assist, deadzone, tick rate, netcode, rollback, frame data, cooldown, aggro, "the lobby", GG, AFK, LFG, GOTY, "cracked", "sweaty", backlog.

**Common misconceptions (each is a lesson beat):**
1. "Gaming is one hobby." (A shooter player and a cozy-farming player may have no shared games.)
2. "Mobile isn't real gaming." (Mobile is the largest platform by players and revenue, and the person she loves may play there; the *debate* is cultural, not factual.)
3. "FPS means she plays shooters." (Two meanings: first-person shooter and frames per second.)
4. "Hard means good" or "easy means for babies". (Difficulty is a design choice and an accessibility topic; enthusiasts genuinely disagree.)
5. "She's just on her phone/console for hours." (Some genres are session-based, some are routines; length tells you little about engagement.)
6. "Buying her a game is easy." (Platform, edition, whether she already owns it, whether it is a pay-to-win live-service game.)
7. "Esports is just people playing games." (It has leagues, seasons, rosters, tentpole events, patches and metagames.)
8. "Microtransactions are always predatory." (Range from cosmetic-only to loot-box gambling mechanics; enthusiasts care about the difference.)
9. "Games are only for kids/boys." (Adult and mixed player base; keep phrasing careful and cheerful.)
10. "Having an opinion on the console war is required." (It is a running joke; loyalty is fun, not a test.)
11. "Backseat coaching helps." (Almost never.)
12. "Aim assist is cheating." (It is a designed compensation for stick-based input; whether it is *too strong* is the real debate. This is the sim's core lesson.)

**Concepts that unlock the rest (become foundation units):** platforms and ecosystems; what is on screen and what the controls do; the genre map and how genres get named; single-player vs multiplayer and how live games are sold; gamer vocabulary; and a working sense of *game feel* mechanics (cooldowns, i-frames, aim assist, lag). With those, most dinner-table talk is decodable.

---

## 3. Foundational knowledge

Grouped into modules (become `foundationalModules[]` and foundation units).

| Module (unit id) | Content |
|---|---|
| `platforms-and-ecosystems` | Console, PC, mobile, handheld, VR; Nintendo, Sony, Microsoft, Valve as platform holders; first-party vs third-party; exclusives, ports, timed exclusives; generations and mid-gen refreshes; storefronts, accounts and libraries; digital vs physical; crossplay, cross-progression, cross-save; spec talk (frame rate, resolution, performance/quality modes, ray tracing, refresh rate). |
| `game-anatomy` | Controllers (layout, sticks, triggers), keyboard and mouse, touch and motion; HUD; camera perspectives; core loop; saves, checkpoints, lives, permadeath; XP, loot, rarity, stats; bosses, enemies, NPCs, aggro, quests. |
| `genre-map` | What a genre is; the naming grammar (-like, -vania, hybrid); action/adventure, shooters, RPGs, strategy and MOBA, sims/sandbox/cozy, fighting, sports, racing, party, puzzle, horror, rhythm. |
| `modes-and-business` | Single-player campaign, co-op, PvP, PvE; lobbies, matchmaking, ranked, MMR, tiers; live service, seasons, battle passes, patch notes; premium vs free-to-play, DLC, expansions, early access, subscriptions; microtransactions, loot boxes, gacha, pay-to-win; betas, demos, delays, remakes/remasters. |
| `talking-gamer` | GG etiquette and chat shorthand; balance words (nerf/buff/OP/meta/tier list); skill words (clutch, carry, sweaty, cracked); luck and grind (RNG, drop rate, farming, min-max); progress words (backlog, completionist, platinum, NG+, speedrun); performance and connection (lag, ping, stutter, glitch, exploit); team talk (roles, callouts, rotate, ult); banter vs toxicity (tilt, smurf, griefing, "skill issue"). |
| `mechanics-you-feel` | Sensitivity and deadzone; **aim assist** (friction, magnetism, rotational, lock-on) in the Unity sim; cooldowns and resources; i-frames, dodge, parry, telegraphs; hitboxes and hit registration; netcode, tick rate, rollback; game feel (input buffers, coyote time, "juice"). |
| `playing-together` | Choosing games a beginner can enjoy with her; asking good questions; being the beginner gracefully; backseat gaming; party chat and invites; good sportsmanship; watching her play; setting up a shared session. |
| `buying-and-gifting` | Price tiers and sales; wishlists; subscriptions (Game Pass, PS Plus, Switch Online); gifting without mistakes (platform, edition, already-owned); collector's editions and physical; headsets, controllers, storage. |
| `esports-awareness` | What esports is; the big titles; splits, regionals and internationals; tentpole events (Worlds, The International, Valorant Champions, Esports World Cup, EVO); roles and drafts; orgs, transfers, fandom; where to watch; money and the debates. |
| `culture-and-history` | Eras (arcade to live service); franchises; console wars; reviews, scores, GOTY; streamers, YouTube and speedrunners; modding and fan communities; indie and the cozy wave. |
| `debates-and-discourse` | PC vs console vs handheld; controller vs mouse and the aim-assist fight; difficulty and accessibility; price, live-service fatigue and monetization; remakes and nostalgia; layoffs, crunch and how games get made. |

**State of the market as of 2026-09-30 (used only for editorial framing; all [verify at release]):** Nintendo Switch 2 launched 2025-06-05 and Nintendo reported about 23.7 million units by 2026-08-06; its US price rose to $499.99 on 2026-09-01. Console price increases hit PlayStation and Xbox in 2026 (US figures reported by secondary sources; not hard-coded). Valve's Steam Machine (about $1,049 at launch, 2026-06-30) and Steam Frame (2026-09-14) are new hardware in the PC-living-room conversation. Steam passed 42 million concurrent users in early 2026. Grand Theft Auto VI is dated 2026-11-19 (PS5 and Xbox Series only; no PC date). Call of Duty: Modern Warfare 4 is dated 2026-10-23 and includes Switch 2. Gears of War: E-Day is dated 2026-10-06 (Xbox and PC). A Zelda: Ocarina of Time remake for Switch 2 is dated 2026-11-05. Clair Obscur: Expedition 33 won Game of the Year at The Game Awards 2025; the 2026 show is on 2026-12-10. Battlefield 6 was the best-selling game in the US in 2025 per Circana.

---

## 4. Enthusiast model

**What enthusiasts talk about:**
- Last night's session: the boss they finally beat, the raid wipe, the ranked climb, the hilarious co-op fail.
- Backlog and what's next: what they're playing, what they're saving, what the sale is.
- Patches and balance: what got nerfed, what's broken, the new season.
- The build or loadout: stats, gear, min-maxing, a "meta" pick versus a fun pick.
- Games as craft: pacing, difficulty, art, music, the writing, the "feel".
- Who's winning (esports), what a streamer did, what a studio announced or delayed.
- Hardware: the new console, handheld, frame rate, "does it run well?".
- Friends: who they play with, party chat, inside jokes.

**Distinctions that matter to them:** premium vs free-to-play vs live service; singleplayer vs online; casual vs competitive vs "sweaty"; skill vs luck (RNG); hard vs unfair; remake vs remaster; roguelike vs roguelite; "game feel" vs graphics; cosmetic-only vs pay-to-win monetization; console-exclusive vs multiplatform; first-party vs third-party; ranked vs unranked; controller-input vs mouse-input lobbies.

**Knowledge that signals real understanding:** that an FPS is a genre and fps is frame rate; that a boss fight is a pattern to learn, not a fluke; that "the meta" changes with each patch; that aim assist compensates for the stick and the fight is about *strength*; that i-frames let you pass through attacks; that "pay to win" is about advantages, not cosmetics; that a "nerf" is a balance change, not an insult; that a live-service game will be different next season.

**Beginner statements that sound obviously uninformed:** "So it's like Fortnite?" (for every shooter); "Can you just pause?" (in an online game); "Why don't you just save?"; "Just dodge!"; "Can't you skip the boss?"; "Why are you yelling at a game?"; "Oh, you play on your phone?"; "Which one is the best console?" (asked as a genuine war); "Isn't it all violent?".

**Common controversies (each is an enthusiast-depth lesson beat):**
1. Console vs PC vs handheld; price/performance; Steam Deck vs Switch 2 vs the new Steam hardware.
2. Controller vs mouse-and-keyboard fairness and the strength of aim assist.
3. Difficulty and accessibility: "git gud" vs assist modes (the Souls "easy mode" argument).
4. Prices: the $70 to $80 tier, subscription math, "will it be on Game Pass?".
5. Live-service fatigue, battle passes, live-service shutdowns and "stop killing games".
6. Loot boxes, gacha and pay-to-win.
7. Remakes, remasters and nostalgia vs new IP; sequel fatigue.
8. Review scores, review bombing, embargoes and what "GOTY" means.
9. Layoffs, crunch and studio closures; how much the public should know.
10. Generative AI in games and art (a current, heated, unsettled topic; explain positions, take none) [verify at release].
11. Streaming and creator culture; who gets attention; "content" vs "gameplay".
12. Esports funding, tournaments in politically sensitive venues and player burnout.

---

## 5. Interaction model

**What she experiences instead of reading.** Most game literacy is *recognition, vocabulary and judgment*: what is on the HUD, what a term means, which genre this is, what to say back, what to gift, how to be a good co-op partner. Those are native. One mechanic family is genuinely *felt*: the way input becomes on-screen action (aim assist, sensitivity, dead zones), because the concept *is* a control loop. That gets a single small Unity sim (see 12).

**Native carries the rest:** vocabulary (term-match, fill-the-gap, say-this), HUD/controller/UI recognition (hotspot-tap, visual-id from **original** generic art), rules-of-thumb (binary-call, multiple-choice), order (sequence-order: core loop, match flow, bracket, battle-pass), magnitudes (estimate-slider: fps, hours, prices), judgment (decision-scenario: what game to pick for a beginner, gift choices, how to react to toxicity), timing feel in 1D (timing-tap: dodge windows, parry, cooldown rhythm), sound cues (listening-id with original synthesized cues), conversation (talk-track, say-this).

**Should NOT be gamified** (details in section 12): spending or gambling mechanics (no simulated loot boxes, gacha pulls or "spin to win"); harassment ("win the argument", clapping back at toxicity); ranking people as "real vs fake gamers"; addiction or mental-health claims; betting or skin-gambling; buying decisions framed as status; any quiz that gatekeeps her hobby. Also no fake "expertise" scripts.

---

## 6. Dynamic information requirements

The subject has a real but *thin* live layer and a strong editorial layer. Do not invent more. (Full plan in `live-data.md`.)

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| `releases` | Yes | "What's coming out, and why do people care?" (dated games, remasters, showcases). | IGDB (Twitch; free non-commercial only, commercial partner agreement needed) [verify]; RAWG (attribution; free commercial for small apps) [verify]; curated editorial calendar. | weekly | Evergreen "how to follow release dates" lesson. |
| `events` | Yes | Showcases, sales, esports tentpoles (Worlds, TI, Champions, EWC, EVO), The Game Awards. | Curated from official pages; Liquipedia (CC BY-SA; API free tier non-commercial only) [verify]; PandaScore (paid, per game). | weekly | Last verified calendar. |
| `schedules` | Light | Esports match calendars for the few titles a learner follows. | Curated; PandaScore (paid) if usage justifies. | daily on event weeks | Omit. |
| `scores` / `standings` | Very light | Finals and tentpole results only ("who won Worlds"). No live point-by-point. | Curated result cards; Liquipedia / PandaScore under licence. | daily on event weeks | Omit; keep explainer. |
| `news` | Yes | "Why is everyone talking about this?" | Publisher RSS headlines and official studio blogs (link-only); no licence yet (L-01). | daily | Evergreen explainers. |
| `new-products` | Yes | Hardware and price news (consoles, handhelds, subscription price moves). | Official platform-holder newsrooms (link-only); curated. | weekly | Evergreen buying lessons. |
| `regulations` | Light | Patch notes and season changes for a followed game (what changed, why fans argue). | Official patch notes pages (link-only, explained in own words). | weekly | Omit. |
| `statistics` / `rankings` | No at launch | Best-seller and player-count charts (Circana, SteamDB) are proprietary or unofficial; use only dated editorial cards. | n/a | n/a | n/a |
| `weather`, `closures`, `injuries`, `transactions`, `rosters` | No (rosters/transactions optional for esports later) | No educational value or unreliable data. | n/a | n/a | n/a |

Structured data and editorial are separate systems (spec sections 10-12, 37). No unofficial or reverse-engineered APIs (SteamDB scraping, HowLongToBeat, Metacritic scraping, store-page scraping) in production.

---

## 7. Editorial context

- **What helps:** why a release date moved and why fans care; what a patch changed; why an event is a big deal; why a price or subscription change is being argued about; what a controversy is *actually* about; what a genre trend is (extraction shooters, cozy wave, Souls-likes).
- **Sources (link-only, explained in Swoon'd's own words):** official studio and platform-holder newsrooms and blogs; esports organizers' official pages; independent games press headlines (link-out only, provider decision open: L-01).
- **Approach:** `explain-and-link`. Never copy publisher text, review text or wiki text (many wikis are CC BY-SA but Swoon'd still explains in its own words). No review scores are reproduced; we explain what a score system is and link.
- **Example prompts:** "Why is everyone talking about this delay?", "What did the patch change and why are fans mad?", "What is The International and who won?", "Why is the console more expensive now?", "Why do people argue about aim assist?"
- **Editorial safety:** no accusations about named developers or players; controversies are described as positions, not verdicts; cheeky but never mean; no gambling links or promotion.

---

## 8. Personalization

| Dimension | How it changes examples and live context | Default when unset | Tokens / units |
|---|---|---|---|
| `platform` (Switch/Switch 2, PlayStation, Xbox, PC, mobile, Steam Deck/handheld PC, VR) | Store and subscription names, controller glyph language (text only), "where to buy", spec examples, which cards lead the live feed. | Neutral wording ("your console or PC"); platform-agnostic examples; all subscriptions shown. | `{{platform}}` in `plat`, `buy`, `mech`, `live`. |
| `franchise` / current `game` | Examples and talk tracks draw from her named franchise; live feed prioritizes its news, patches and events. | Rotating well-known examples across genres (never one franchise as the default). | `{{franchise}}`, `{{game}}` in `anat`, `vocab`, `tog`, `conv`, `live`. |
| `genre` (branch) | Chooses branch units; tilts vocabulary examples. | `genre-map` tour only; no branch units until chosen. | Branch units (`shoot-*`, `aa-*`, `rpg-*`, `sm-*`, `fg-*`, `cz-*`). |
| `player` (streamer or pro she follows) | Esports and creator cards, "why they're famous" explainers (names as facts only). | Generic streamer and pro examples. | `{{creator}}` in `esp`, `cult`, `live`. |
| `team` (esports org) | Team results and event cards on the esports layer; talk tracks "her team lost". | Big-event cards without team focus. | `{{org}}` in `esp`, `live`. |
| `region` | Regional esports league naming, currency wording for prices; store availability caveats. | Global framing; USD examples marked as US. | Light use in `buy`, `esp`. |
| `skill-level` | Depth of explainers (novice vs "she plays ranked"), how much competitive vocabulary appears. | Novice. | Explainer selection only. |

Unset dimensions fall back to generic content; the feed is never blank.

---

## 9. Conversation model

Fifteen things a gamer might naturally say (translation, terms, and a meaningful next question):

| # | She says | Means | Terms implied | A good next question |
|---|---|---|---|---|
| 1 | "I finally beat that boss after like forty tries." | She learned the boss's attack pattern and executed. | boss-fight, telegraph, learning curve | "What was the move that finally got you?" |
| 2 | "Ranked was brutal, I'm stuck in Gold." | She's climbing a competitive ladder and plateaued. | ranked-play, rank-tiers, mmr-elo, tilt | "What's the thing that's holding you back in the lobbies?" |
| 3 | "They nerfed my main." | The developers weakened her favorite character. | nerf-buff, main, patch, meta | "What did they change about them?" |
| 4 | "That lobby was so sweaty." | Opponents were very try-hard or highly skilled. | sweaty, lobby, matchmaking | "Was that ranked or just casual?" |
| 5 | "My ping was awful, I got peeked." | Lag made her lose a fight; the enemy saw her first. | ping, latency, netcode, peekers-advantage | "Is it your connection, or the server?" |
| 6 | "I'm grinding for the drop." | Repeating content hoping a rare item drops. | grind, farm, drop-rate, rng | "How rare is it supposed to be?" |
| 7 | "The RNG hated me." | Random outcomes went against her. | rng, drop-rate | "Was it a boss drop or a loot box?" |
| 8 | "I'm doing a no-hit run." | Completing the game without taking damage. | challenge-run, i-frames, boss-fight | "What's the hardest boss for that?" |
| 9 | "Aim assist is broken in this game." | Controller assist is too strong for her taste. | aim-assist, crossplay, kbm, input-fairness-debate | "Are you on controller or mouse?" |
| 10 | "Wait for the next patch, it's unplayable." | Bugs or bad balance need a fix. | patch-notes, bug, live-service | "Do they patch often?" |
| 11 | "It's a Souls-like, but cozy." | Genre hybrid: hard-boss mechanics with soft themes. | soulslike, hybrid-genre, cozy-game | "What makes it cozy if there are bosses?" |
| 12 | "Season 4 starts Tuesday and I'm not ready." | A new live-service season: new content, new pass, new meta. | season, battle-pass, live-service | "What are you hoping they change?" |
| 13 | "I just need to clear my backlog." | She owns many unplayed games. | backlog, pile-of-shame | "What's next on the list?" |
| 14 | "I run a support build." | Her character's role is helping teammates. | tank-healer-dps, support-role, build | "Who do you like playing with?" |
| 15 | "That was a clutch." | She won when the odds were against her, usually last alive. | clutch | "What were the odds — how many were left?" |

**How Swoon'd helps without fake expertise.** Each say-this item ends with follow-ups that are honest curiosity ("What was the move that finally got you?"), never facts to bluff. Talk tracks reward listening and questions over repeating jargon. The `noFakeExpertNote` on say-this items reminds the learner that "I don't play that one, teach me" is a win.

**Targets:** 24 standalone talk tracks at launch plus 7 conversation-lab lessons; about 90 say-this items across units. See `exercises.md` for nine full sample tracks.

---

## 10. Assessment

- **Useful competence** is not memorizing games; it is being able to (a) decode what she says, (b) ask a good next question, (c) join a session without being a burden, (d) not embarrass yourself on the basics (platform, genre, vocabulary), and (e) know enough about the current landscape to say "did you see...?" honestly.
- **Recognize:** platform types, HUD elements, controller parts, genres by description, common terms in context.
- **Understand:** how a live game is sold and updated; why aim assist, cooldowns and i-frames exist; why difficulty and prices are debated; how an esports season is structured.
- **Explain (in one sentence):** what a nerf is; why controller players get aim assist; what a battle pass is; what a boss "pattern" is.
- **Interpret:** what she is saying about a match, a patch, a boss, a purchase or a session.
- **Mastery model:** `concept-mastery-v1`, pass threshold 0.8 per concept (mastered concepts enter the spaced review loop).
- **Useful competence statement:** "She can follow what I'm telling her about the games I play, ask about them without faking anything, pick something we can play together, and say 'okay, I get why you love this'."

---

## 11. Curriculum map (ongoing course)

Course is designed as an ongoing programme: **20 units, 122 lessons** across foundations, intermediate, enthusiast depth, branches, current layer, conversation practice and perpetual review. A learner sees about 14 to 16 units (only their selected branch units appear). Activity codes: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap, `us` unity-sim. Every lesson lists at least four activities (validator rule `thin-lesson`). Concept ids are the Playbook terms; the full concept list is in the appendix at the end of this section.

| Layer | Purpose | Units | Lessons |
|---|---|---|---|
| Foundations | Platforms, anatomy, genres, modes and business, vocabulary | 5 | 36 |
| Intermediate | Mechanics you feel, playing together, buying and gifting | 3 | 22 |
| Enthusiast depth | Esports, culture and history, debates | 3 | 21 |
| Branches | Genre communities | 6 | 28 |
| Current / live layer | Ongoing: releases, events, patches | 1 | 5 |
| Conversation practice | Talk tracks, say-this, decode her message | 1 | 7 |
| Perpetual review | Spaced review of mastered concepts | 1 | 3 |

### Layer 1: Foundations

**Unit `platforms-and-ecosystems`: Platforms and Ecosystems** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `plat-01` | Console, PC, phone, handheld | Name the main ways people play and what each is like. | platform-types, console, pc-gaming, mobile-gaming, handheld | mc, tm, vi, st |
| `plat-02` | The big three, plus Valve | Match Nintendo, Sony, Microsoft and Valve to what they are known for. | nintendo, playstation, xbox, steam-valve, first-party | tm, mc, st, fg |
| `plat-03` | Exclusives and ports | Explain exclusive, timed exclusive, multiplatform and port. | exclusive, timed-exclusive, multiplatform, port | mc, bc, st, ds |
| `plat-04` | Generations and refreshes | Explain what "current gen" and a mid-generation refresh mean. | console-generation, current-gen, mid-gen-refresh, backwards-compatibility | so, mc, es, st |
| `plat-05` | Storefronts, libraries, accounts | Say why her library lives on an account and what digital vs physical changes. | storefront, digital-library, physical-vs-digital, platform-account | tm, mc, ds, fg |
| `plat-06` | Crossplay and cross-save | Tell crossplay, cross-progression and cross-save apart. | crossplay, cross-progression, cross-save | bc, mc, ds, st |
| `plat-07` | Spec talk: fps, resolution, modes | Decode "60 fps", "4K", "performance mode" and "ray tracing". | frame-rate-fps, resolution-4k, performance-vs-quality-mode, ray-tracing, refresh-rate | es, mc, st, fg |

**Unit `game-anatomy`: How a Game Is Put Together** (prereq: none). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `anat-01` | The controller map | Locate sticks, triggers, bumpers, d-pad and face buttons. | controller-layout, analog-stick, triggers-bumpers, face-buttons, dpad | ht, tm, mc, st |
| `anat-02` | Keyboard, mouse, touch, motion | Explain what each input method is good at. | kbm, wasd, touch-controls, motion-controls | mc, bc, ds, st |
| `anat-03` | Reading the screen | Recognise health, minimap, ammo, objective and cooldown icons. | hud, health-bar, minimap, cooldown-icon, quest-marker | ht, vi, mc, st |
| `anat-04` | Camera and perspective | Tell first-person, third-person, isometric and side-scroller apart. | first-person, third-person, isometric-view, side-scroller | vi, mc, tm, st |
| `anat-05` | The core loop | Describe a game's loop and its win or lose condition. | core-loop, game-objective, win-lose-condition, progression | so, mc, ds, fg |
| `anat-06` | Saves, checkpoints, permadeath | Explain saves, checkpoints, lives and permadeath. | save-point, checkpoint, lives-continues, permadeath, autosave | mc, bc, ds, st |
| `anat-07` | XP, loot, and stats | Explain levelling, item rarity and builds. | xp-levels, loot, item-rarity, stats-build, inventory | tm, vi, mc, so |
| `anat-08` | Bosses, enemies, NPCs | Tell bosses, mobs, NPCs and quests apart and say what aggro is. | boss-fight, npc, mob-enemy, aggro, quest | tm, mc, st, so |

**Unit `genre-map`: The Genre Map** (prereq: `game-anatomy`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `genre-01` | Why genres are named like that | Decode "-like", "-vania" and hybrid genre names. | genre, subgenre, like-suffix, vania-suffix, hybrid-genre | tm, mc, st, fg |
| `genre-02` | Action and adventure | Place platformers, action-adventure and Metroidvanias. | action-game, adventure-game, platformer, action-adventure, metroidvania | vi, tm, mc, st |
| `genre-03` | Shooters | Tell FPS, third-person shooter, battle royale, hero and extraction shooters apart. | fps, third-person-shooter, battle-royale, hero-shooter, extraction-shooter | tm, mc, st, bc |
| `genre-04` | RPGs | Tell RPG, JRPG, CRPG, action RPG, MMO and Souls-like apart. | rpg, jrpg, crpg, action-rpg, mmo, soulslike | tm, mc, st, bc |
| `genre-05` | Strategy and MOBA | Tell RTS, turn-based, 4X, MOBA and auto-battler apart. | rts, turn-based-strategy, four-x, moba, auto-battler | tm, mc, st, so |
| `genre-06` | Sims, sandboxes, cozy | Place farming sims, sandboxes, survival and city-builders. | simulation-game, sandbox, survival-game, cozy-game, farming-sim, city-builder | tm, vi, mc, st |
| `genre-07` | Fighting, sports, racing, party, horror | Place the rest of the map and ask "what kind of game is it?". | fighting-game, sports-game, racing-game, party-game, puzzle-game, horror-game, rhythm-game | tm, mc, st, tk |

**Unit `modes-and-business`: Modes and How Games Are Sold** (prereq: `genre-map`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `mode-01` | Single-player, co-op, PvP | Tell campaign, co-op, PvP and PvE apart. | single-player, campaign, multiplayer, coop, pvp, pve | tm, mc, bc, st |
| `mode-02` | Lobbies, matchmaking, ranked | Explain matchmaking, ranked and rank tiers. | matchmaking, lobby, ranked-play, casual-mode, mmr-elo, rank-tiers | so, mc, st, fg |
| `mode-03` | Live service and seasons | Explain live service, seasons, battle passes and patch notes. | live-service, season, battle-pass, patch-notes | so, mc, ds, st |
| `mode-04` | How games are sold | Tell premium, free-to-play, DLC, expansion and early access apart. | premium-game, free-to-play, dlc, expansion, early-access, day-one-patch | tm, mc, bc, st |
| `mode-05` | Microtransactions and gacha | Explain cosmetic-only vs pay-to-win, loot boxes and gacha. | microtransaction, loot-box, gacha, pay-to-win, cosmetics-only | mc, bc, ds, st |
| `mode-06` | Betas, delays, remakes | Tell beta, demo, delay, remake and remaster apart. | beta, demo, release-window, delay, remake-vs-remaster, gold-status | tm, mc, st, fg |

**Unit `talking-gamer`: Talking Gamer** (prereq: none). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `vocab-01` | GG and other manners | Use and understand GG, GLHF, AFK, noob and LFG. | gg, glhf, afk, noob, lfg | tm, mc, st, fg |
| `vocab-02` | Balance words | Explain nerf, buff, OP, meta and tier list. | nerf-buff, op-overpowered, meta, tier-list, broken | tm, mc, bc, st |
| `vocab-03` | Skill words | Explain clutch, carry, sweaty, cracked and casual vs hardcore. | clutch, carry, sweaty, cracked, casual-vs-hardcore, skill-ceiling-floor | tm, mc, st, fg |
| `vocab-04` | Luck and grinding | Explain RNG, grind, farm, drop rate and min-maxing. | rng, grind, farm, drop-rate, min-max | tm, mc, st, es |
| `vocab-05` | Progress words | Explain backlog, completionist, platinum, New Game Plus, speedrun. | backlog, completionist, platinum-trophy, achievements, new-game-plus, speedrun | tm, mc, st, fg |
| `vocab-06` | Lag, glitches, exploits | Tell lag, stutter, ping, bugs, glitches and exploits apart. | lag, ping, stutter, bug-glitch, exploit | tm, mc, bc, st |
| `vocab-07` | Team talk | Decode tank/healer/DPS, support, callouts, rotate and ult. | tank-healer-dps, support-role, callouts, rotate, ult | tm, mc, st, so |
| `vocab-08` | Banter vs toxicity | Tell friendly trash talk from toxicity; know tilt, smurf, griefing. | tilt, smurf, griefing, toxicity, skill-issue | ds, mc, bc, st |

### Layer 2: Intermediate

**Unit `mechanics-you-feel`: Mechanics You Can Feel** (prereq: `game-anatomy`; `vocab-01`). 9 lessons (8 plus the native alternative for the sim).

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `mech-01` | Sensitivity and deadzone | Explain sensitivity, DPI and the stick deadzone. | sensitivity, deadzone, input-lag, dpi | mc, es, st, fg |
| `mech-02` | Aim assist, felt | Feel stick vs direct aim and tell four kinds of aim assist apart. | aim-assist, aim-friction, aim-magnetism, rotational-assist, lock-on-targeting, stick-vs-mouse | us, mc, st, bc |
| `mech-02-alt` | Aim assist, explained | Same objective, no motor control needed (accessible native alternative). | aim-assist, aim-friction, aim-magnetism, rotational-assist, lock-on-targeting, stick-vs-mouse | ht, so, mc, st, tt |
| `mech-03` | Cooldowns and resources | Explain cooldowns, mana/stamina and ult charge as timing tools. | cooldown, resource-management, ult-charge, global-cooldown | mc, so, ds, tt |
| `mech-04` | I-frames, dodge, parry | Explain invincibility frames, dodge rolls, parry and telegraphs. | i-frames, dodge-roll, parry, telegraph, stagger | tt, mc, bc, st |
| `mech-05` | Hitboxes and "that missed?!" | Explain hitbox vs hurtbox and why shots sometimes don't count. | hitbox, hurtbox, hit-registration, hitscan-vs-projectile | ht, mc, bc, st |
| `mech-06` | Netcode, tick rate, rollback | Explain latency, tick rate and rollback netcode in plain words. | netcode, tick-rate, latency-ms, rollback-netcode, peekers-advantage | es, mc, bc, so, st |
| `mech-07` | Game feel: buffers and juice | Explain input buffering, coyote time and "juice". | input-buffer, coyote-time, game-feel, animation-cancel | mc, tt, st, fg |
| `mech-08` | Difficulty as a design choice | Explain difficulty modes, adaptive difficulty and assists. | difficulty-select, adaptive-difficulty, accessibility-options, rubber-banding | mc, ds, bc, st |

**Unit `playing-together`: Playing With Them** (prereq: `talking-gamer`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `tog-01` | Choose a game you can share | Pick a beginner-friendly co-op or party game for two. | couch-coop, party-game-pick, difficulty-fit, drop-in-drop-out | ds, mc, bc, st |
| `tog-02` | Ask, don't quiz | Ask genuine questions about the game she's playing. | good-questions, spoiler-etiquette, ask-to-watch | tk, st, mc, ds |
| `tog-03` | The beginner in the room | Be a graceful beginner: assists, easy mode, tutorials. | assist-mode, learning-curve, tutorial-skip, let-her-lead | ds, mc, bc, st |
| `tog-04` | Backseat gaming is a trap | Know why not to backseat and what to do instead. | backseat-gaming, let-them-cook, help-request | bc, ds, tk, mc |
| `tog-05` | Party chat and invites | Use party chat, friend codes and invites politely. | party-chat, friend-code, invite-etiquette, mute-report | so, mc, ds, st |
| `tog-06` | Winning, losing, being a teammate | Be a good sport in wins and losses. | good-sport, carry-vs-be-carried, tilt-management, rematch | ds, tk, mc, st |
| `tog-07` | Watching her play | Watch a session well; know streaming and let's plays. | couch-spectating, twitch-streaming, lets-play, watching-etiquette | mc, st, ds, bc |
| `tog-08` | Set up a shared session | Plan controllers, accounts, guest profiles and time. | guest-profile, session-length, split-screen, controller-pairing | so, mc, ds, fg |

**Unit `buying-and-gifting`: Money, Deals, Gifts** (prereq: `plat-05`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `buy-01` | Prices, sales, wishlists | Explain price tiers, seasonal sales and wishlists. | price-tier, seasonal-sale, wishlist, price-history | es, mc, st, fg |
| `buy-02` | Subscriptions | Tell Game Pass, PS Plus and Switch Online apart. | game-pass, ps-plus, nintendo-switch-online, subscription-catalog | tm, mc, ds, st |
| `buy-03` | Gift-wise | Avoid gift mistakes: platform, edition, already-owned. | gift-card, platform-match, edition-confusion, wishlist-gifting | ds, mc, bc, st |
| `buy-04` | Collector's editions, physical | Explain collector's editions, limited runs and retro collecting. | collectors-edition, limited-run, physical-media, retro-collecting | mc, vi, st, ds |
| `buy-05` | Headsets, controllers, storage | Explain common accessories and what fits which platform. | gaming-headset, pro-controller, storage-expansion, accessory-fit | tm, mc, ds, st |

### Layer 3: Enthusiast depth

**Unit `esports-awareness`: Esports 101** (prereq: `talking-gamer`, `modes-and-business`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `esp-01` | What esports is | Explain what esports is and who plays it. | esports, pro-player, org-team, league-vs-tournament, prize-pool | mc, tm, st, fg |
| `esp-02` | The big titles | Match the major esports titles to their genres. | esports-title, moba-esports, tactical-shooter-esports, fgc-esports | tm, mc, vi, st |
| `esp-03` | How a season is built | Explain splits, regionals, internationals and brackets. | split, regional-league, international-event, qualification, bracket-formats | so, mc, bc, st |
| `esp-04` | The tentpoles | Place Worlds, The International, Valorant Champions, EVO, Esports World Cup. | worlds, the-international, valorant-champions, evo, esports-world-cup | tm, so, mc, st |
| `esp-05` | Roles, drafts, maps | Read a match: roles, pick/ban, map veto, casters. | esports-roles, draft-pick-ban, map-veto, casters, vod | mc, ht, st, so |
| `esp-06` | Orgs, players, fandom | Explain orgs, transfers, free agency and rivalries. | org-brand, free-agency-transfer, streamer-pro, fandom-culture, rivalry | mc, st, tk, ds |
| `esp-07` | Where to watch | Know where to watch and what a co-stream or watch party is. | twitch-youtube-stream, co-streaming, watch-party, vod-review | mc, ds, st, fg |
| `esp-08` | Money, burnout, the debates | Explain funding, prize pools and the burnout debate without taking sides. | esports-funding, burnout-retirement, prize-pool-debate, esports-venue-debate | mc, ds, bc, st |

**Unit `culture-and-history`: Game Culture and History** (prereq: `genre-map`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cult-01` | A short history of playing | Order the eras from arcade to live service. | game-history-eras, arcade-era, video-game-crash, indie-scene | so, mc, tm, st |
| `cult-02` | Franchises everyone knows | Match iconic franchises to their genre and studio. | franchise, iconic-franchises, mascot, ip-brand | tm, mc, st, fg |
| `cult-03` | Console wars and tribes | Explain console wars and platform loyalty as a joke. | console-wars, fanboy, platform-loyalty, exclusives-as-weapons | mc, bc, tk, st |
| `cult-04` | Reviews, scores, awards | Explain review scores, aggregators, GOTY and review bombing. | review-score, metacritic-opencritic, goty, game-awards, review-bombing | mc, bc, st, fg |
| `cult-05` | Streamers, YouTubers, speedrunners | Explain streamers, creators and speedrun events. | streamer, content-creator, speedrun-event, lets-play | mc, tm, st, ds |
| `cult-06` | Mods, fan games, communities | Explain mods, fan games, wikis and Discord servers. | mod, modding-scene, fan-game, community-wiki, discord-server | mc, tm, st, fg |
| `cult-07` | Indies and the cozy wave | Explain indie games, game jams and the cozy trend. | indie-game, cozy-wave, game-jam, crowdfunded-game | mc, vi, st, ds |

**Unit `debates-and-discourse`: What Fans Argue About** (prereq: `culture-and-history`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `deb-01` | PC vs console vs handheld | Explain the platform debate without picking a side. | platform-debate, pc-master-race-meme, price-performance | mc, bc, tk, st |
| `deb-02` | Controller vs mouse, aim assist | Explain the aim-assist fairness debate. | input-fairness-debate, aim-assist-strength, input-based-matchmaking | mc, bc, st, ds |
| `deb-03` | Difficulty, accessibility, "git gud" | Explain the difficulty and accessibility argument in its strongest forms. | difficulty-debate, git-gud, easy-mode-debate, accessibility-vs-challenge | mc, ds, st, tk |
| `deb-04` | Prices, live service, monetization | Explain price, live-service fatigue and monetization backlash. | price-debate, live-service-fatigue, monetization-backlash, engagement-loop | mc, bc, st, ds |
| `deb-05` | Remakes, remasters, nostalgia | Explain remake vs remaster, sequel fatigue and preservation. | sequel-fatigue, nostalgia-bait, preservation-debate, game-shutdown | mc, bc, st, ds |
| `deb-06` | Jobs, layoffs, how games get made | Explain crunch, layoffs and AA vs AAA neutrally. | crunch, layoffs, aa-vs-aaa, game-dev-pipeline | mc, ds, st, bc |

### Layer 4: Branches (genres)

**Unit `branch-shooters`: Shooters** (branch `shooters`; prereq: `genre-03`, `mech-02`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `shoot-01` | Aim, recoil, sensitivity | Explain recoil, spray patterns and time-to-kill; replay the aim-assist sim at higher difficulty. | recoil, spray-pattern, ttk-time-to-kill, movement-tech, aim-assist | us, mc, st, bc |
| `shoot-02` | Modes and maps | Explain team deathmatch, objective modes, map control and loadouts. | game-mode-tdm, objective-mode, map-control, loadout | tm, mc, ht, st |
| `shoot-03` | Battle royale rhythm | Explain the circle, drop spots, third-partying and loot tiers. | zone-circle, drop-spot, third-party, loot-tier | so, mc, ds, st |
| `shoot-04` | Tactical shooters and economy | Explain round economy, utility and eco rounds. | round-economy, utility-grenades, eco-round, agent-abilities | so, mc, bc, st |
| `shoot-05` | Reading a shooter clip | Decode what she says after a round or a match. | callouts, clutch, peekers-advantage, trade-kill | st, tk, mc, ds |

**Unit `branch-action-adventure`: Action and Adventure** (branch `action-adventure`; prereq: `genre-02`, `mech-04`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `aa-01` | Boss patterns and learning by dying | Explain why deaths are the game in a Souls-like. | boss-pattern, learning-by-dying, phase-change, bonfire-checkpoint | tt, mc, st, ds |
| `aa-02` | Open-world design tropes | Explain map icons, fast travel, side quests and "towers". | open-world, fast-travel, side-quest, map-icon-fatigue | vi, mc, bc, st |
| `aa-03` | Metroidvania and platformer talk | Explain ability gating, backtracking and precision platforming. | ability-gating, backtracking, precision-platforming, collectible | tm, mc, st, so |
| `aa-04` | Puzzle gates and item progression | Explain item gates, dungeons and the "one more key" loop. | dungeon-loop, item-gate, environmental-puzzle, progression-gate | so, mc, ds, st |
| `aa-05` | Story games and spoilers | Discuss story-driven games without spoiling and explain photo mode. | story-driven, cutscene, photo-mode, spoiler-etiquette | ds, mc, tk, st |

**Unit `branch-rpg`: Role-Playing Games** (branch `rpg`; prereq: `genre-04`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rpg-01` | Builds, classes, stats | Explain classes, builds, skill trees and respec. | class-build, skill-tree, respec, stat-scaling | tm, mc, ds, st |
| `rpg-02` | Turn-based vs real-time | Explain turn-based, action-time and real-time combat. | turn-based-combat, action-combat, party-battle, limit-break | mc, so, bc, st |
| `rpg-03` | Party, companions, choices | Explain party members, companions and branching choices. | party-composition, companion-quest, branching-choice, romance-option | mc, ds, st, tk |
| `rpg-04` | MMOs and raids | Explain raids, guilds, gear score and tank/healer/DPS in raids. | raid, guild, gear-score, wipe | tm, mc, so, st |
| `rpg-05` | Gacha RPGs and pity | Explain gacha banners, pity and why fans budget. | gacha-banner, pity-system, limited-banner, whale-f2p | mc, bc, ds, st |

**Unit `branch-strategy-moba`: Strategy and MOBA** (branch `strategy-moba`; prereq: `genre-05`). 5 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `sm-01` | MOBA anatomy | Explain lanes, creeps, towers, jungle and objectives. | lane, creep-minion, tower, jungle, nexus-objective | ht, tm, mc, st |
| `sm-02` | Farming, gold, items | Explain last-hitting, gold, items and snowballing. | last-hit, gold-economy, item-build, snowball | so, mc, bc, st |
| `sm-03` | RTS and 4X: economy and build orders | Explain build orders, APM, macro/micro and "one more turn". | build-order, apm, macro-micro, one-more-turn | so, mc, bc, st |
| `sm-04` | Auto-battlers and deckbuilders | Explain autobattlers, decks and synergies. | auto-battler-loop, deckbuilder, synergy, tempo | tm, mc, st, ds |
| `sm-05` | Drafts, patches, and the meta | Read a draft and a patch: pick/ban, counters, meta shifts. | pick-ban, counter-pick, patch-cycle, tier-shift | mc, bc, st, tk |

**Unit `branch-fighting`: Fighting Games** (branch `fighting`; prereq: `genre-07`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `fight-01` | Fighting game basics | Explain rounds, specials, combos and the health bar. | round-based, special-move, combo, super-meter | tm, mc, st, bc |
| `fight-02` | Frame data and neutral | Explain startup, active, recovery, frame advantage, neutral. | frame-data, startup-active-recovery, frame-advantage, neutral-game | so, tt, mc, st |
| `fight-03` | Netcode, tiers, and the FGC | Explain rollback netcode, tier lists and the community. | rollback-netcode, fgc, tier-list, offline-tournament | mc, bc, st, ds |
| `fight-04` | Watching a set | Follow a tournament set: bracket, best-of, momentum. | tournament-set, best-of, winners-losers-bracket, momentum-swing | mc, so, st, tk |

**Unit `branch-cozy-sim`: Cozy, Sim, Sandbox** (branch `cozy-sim`; prereq: `genre-06`). 4 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `cozy-01` | Cozy loops and routines | Explain daily loops, seasons in-game and "one more day". | daily-loop, in-game-calendar, decorating, comfort-game | mc, so, st, ds |
| `cozy-02` | Sandbox and survival talk | Explain crafting, base building, biomes and survival modes. | crafting, base-building, biome, survival-mode | tm, mc, st, so |
| `cozy-03` | Life sims and city-builders | Explain villagers, relationships, zoning and budgets. | villager-friendship, life-sim, zoning, city-budget | tm, mc, st, ds |
| `cozy-04` | Sharing a cozy game | Visit her world, gift villagers and co-op farm politely. | world-visit, coop-farm, shared-save, gift-etiquette | ds, mc, tk, st |

### Layer 5: Current / live layer

**Unit `season-now`: This Season in Games** (prereq: `talking-gamer`; live). 5 lesson templates instantiated from live cards and editorial (never hard-coded).

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `live-01` | This month in releases | Read what is coming out and why it matters. | release-window, delay, showcase-event | mc, st, fg, ds |
| `live-02` | Events on the calendar | Understand this month's events (showcases, sales, esports tentpoles). | showcase-event, seasonal-sale, esports-world-cup | mc, so, st, fg |
| `live-03` | Esports this week | Follow a tentpole or split without faking it. | bracket-formats, org-brand, esports-title | mc, st, tk, ds |
| `live-04` | What the patch changed | Explain a patch or season in her game. | patch-notes, nerf-buff, season | mc, bc, st, fg |
| `live-05` | Why is everyone talking about this? | Explain today's story in own words. | live-service, price-debate, remake-vs-remaster | mc, st, tk, ds |

`live` hooks: `live-01` releases, `live-02` events and new-products, `live-03` events and schedules, `live-04` regulations (patch notes), `live-05` news. Details in `live-data.md`.

### Layer 6: Conversation practice

**Unit `conversation-lab`: Conversation Lab** (prereq: `talking-gamer`, `genre-map`; continuous). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `conv-01` | She said "I ranked up" | Respond to a ranked story with curiosity. | ranked-play, rank-tiers, tilt | tk, st, mc, ds |
| `conv-02` | Recap of a raid or match | Follow a long recap and ask one good question. | raid, wipe, clutch, callouts | tk, st, mc, ds |
| `conv-03` | She's mad at a game | Listen when she's frustrated; don't fix. | tilt, rng, lag, skill-issue | tk, ds, st, mc |
| `conv-04` | Recommend me something | Ask for a recommendation and receive it well. | good-questions, difficulty-fit, backlog | tk, st, ds, mc |
| `conv-05` | Try it with me | Say yes to a co-op night honestly. | couch-coop, let-her-lead, good-sport | tk, ds, st, mc |
| `conv-06` | Her platform, her franchise | Talk about the specific game with personalization. | franchise, platform-debate, patch-notes | tk, st, mc, ds |
| `conv-07` | "I don't know that one" | Admit not knowing, gracefully. | good-questions, no-fake-expertise, spoiler-etiquette | tk, st, ds, mc |

### Layer 7: Perpetual review

**Unit `review-loop`: Review Loop** (prereq: none; spaced repetition over mastered concepts). 3 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rev-01` | Term blitz | Recall mastered vocabulary quickly. | (all `talking-gamer`, `genre-map` concepts) | tm, fg, mc, st |
| `rev-02` | Spot the genre | Classify a described game to a genre. | genre, subgenre, hybrid-genre, fps | mc, tm, vi, bc |
| `rev-03` | Decode her message | Mixed say-this and talk-track review. | (mixed) | st, tk, mc, ds |

**Review policy:** spaced repetition over mastered concepts (intervals 1, 3, 7, 14, 30, 60 days; correct advances, wrong resets to 1; wrong answers lower mastery by 0.15), Daily Bite draws 3 items from due concepts, maximum 12 review items per day, live-layer concepts are reviewed only while their season is current. Term Blitz and Genre Spotter sessions are available on demand.

**Concept count:** 300+ concept ids across the map (Playbook terms are a subset; ids are Playbook terms). Concept count target: **about 330 concepts**, of which 70 appear in `exercises.md` as Playbook entries.

**Personalization slots:** `{{platform}}` (plat, buy, mech, live), `{{franchise}}` and `{{game}}` (anat, vocab, tog, conv, live), `{{genre}}` (branch choice), `{{creator}}` (esp, cult, live), `{{org}}` (esp, live).

**Release plan.** Launch (v0.1): foundations, intermediate, enthusiast-depth and conversation units, three branches (`shooters`, `action-adventure`, `cozy-sim`), the aim-assist sim (built last, isolated, native alternative ships regardless), the evergreen part of `season-now` and 12 talk tracks. v0.2: `rpg`, `strategy-moba`, `fighting` branches; esports live cards; 12 more talk tracks. Later: per-season live templates (each month), a `sports-racing` branch (candidate), platform-specific packs, more personalization by franchise.

---

## 12. Interaction plan

Every activity family maps to a native type or the one Unity sim. The default is native.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| Vocabulary in `talking-gamer`, `genre-map`, `platforms` | term families | `term-match` | Introduces 3-6 related terms with plain definitions; a game would add nothing. | B | ~45 |
| Vocabulary in context, review | terms | `fill-the-gap` | Reinforces terms inside a sentence she might say. | B | ~55 |
| Knowledge and rule checks (all units) | all | `multiple-choice` | Default check card; distractors are the classic beginner errors from section 2. | B | ~230 |
| "Is this fair? / buff or nerf? / cosmetic or pay-to-win?" | mode, balance, monetization | `binary-call` | Two-way judgment with a plain-language rationale; scene `none` (text only) or a generic HUD diagram. | B | ~70 |
| Core loop, match flow, season, bracket, battle-pass order | loop, structure | `sequence-order` | Order is the concept; per-step `why` carries logic. | B | ~35 |
| HUD parts, genre camera views, controller layouts, accessories | HUD, genre, controls | `hotspot-tap` | Static labelled diagram; original generic art (no game screenshots). | B | ~45 |
| Recognising genres, camera types, rarity colors, generic UI | genres, HUD | `visual-id` | Recognition is the skill; **original abstract illustrations only** (spec section 40): generic HUD, genre mock-ups, controller silhouettes. | B | ~30 |
| Co-op picks, gifting, etiquette, toxicity, whether to buy | judgment | `decision-scenario` | Judgment with consequences and an expert note; a sim would be a worse teacher. | B | ~60 |
| Dodge windows, parry, cooldown rhythm, i-frame timing | i-frames, parry, cooldown | `timing-tap` | A 1D bar shows the concept: an invulnerable window that must overlap an attack window; per rubric, 1D timing is native. | B | ~14 |
| fps, hours, price tiers, tick rate, prize pools | magnitudes | `estimate-slider` | Magnitudes matter more than exact numbers; dated numbers appear as live cards, not lesson facts. | B | ~25 |
| Recognising generic audio cues (low health, loot chime, hit marker) | audio cues | `listening-id` | **Original synthesized cues only**; never game audio. Skip option always available. | B | ~10 |
| Decode what she says | all | `say-this` | The signature conversation-interpretation type; follow-ups are honest curiosity. | B | ~90 |
| Conversation practice | talk | `talk-track` | Every course; forgiving, no hearts; rewards listening. | B | 24 + micro-tracks |
| **Aim assist, felt** (`mech-02`, `shoot-01`) | `aim-assist`, `aim-friction`, `aim-magnetism`, `rotational-assist`, `lock-on-targeting`, `stick-vs-mouse` | `unity-sim`: `games.controls.aim-assist.v1` (spec: `sims/games.controls.aim-assist.v1.md`) | See the Unity decision record below. | A | 2 lessons (~6 sessions) |

### Unity decision record: does any game-mechanics sim genuinely beat native?

**Question.** The obvious candidates are the mechanics enthusiasts say she "just feels": aim assist, cooldowns, i-frames. Which, if any, is taught materially better by a small Unity sim than by the best native exercise? The rubric (CLAUDE.md section 4): Unity only when spatial reasoning, movement, physics, timing in a scene or camera perspective *materially improves learning* **and** a native exercise would teach it clearly worse. The default is native.

**Candidates evaluated.**

| Candidate | What learner must grasp | Best native alternative | Verdict |
|---|---|---|---|
| Cooldowns / resource pacing | An ability is unavailable for N seconds; timing plays around it. | `sequence-order` (ability timeline), `timing-tap`, `decision-scenario` (when to use ult). The concept is a number and a rhythm, not a scene. | **Native.** No spatial or continuous-control component. |
| I-frames / dodge / parry | An invulnerable window overlaps an attack's danger window. | `timing-tap` with a labelled bar (dodge window inside the attack's active window) plus a `hotspot-tap` on a timeline diagram. It is exactly a 1D timing overlap. | **Native.** A scene adds art, not understanding; rubric says a simple 1D timing bar is native. |
| Hitbox / hurtbox / hit registration | Damage is computed on boxes, not sprites. | `hotspot-tap` and `binary-call` on original diagrams: static geometry. | **Native.** No motion needed to see the boxes. |
| Netcode, tick rate, rollback, peeker's advantage | Two clients see time differently. | `sequence-order` (message timeline), `estimate-slider` (latency magnitudes), a static two-lane timeline diagram. Hard concept but a diagram teaches it; a sim would need a two-player network model for a marginal gain. | **Native.** Weigh again after playtests if learners still fail `mech-06` (open question 3). |
| Input latency, deadzone | Small numbers change feel. | `estimate-slider`, `fill-the-gap`. | **Native.** |
| Difficulty and adaptive difficulty | Design choice, opinionated. | `multiple-choice`, `decision-scenario`. | **Native.** |
| Genre camera perspectives | Recognition. | `visual-id` (original art). | **Native.** |
| **Aim assist and stick-vs-mouse** | Stick input sets *velocity*; direct (mouse/touch-drag) sets *position*. A moving target exposes the difference as tracking error. Assist types (friction, magnetism, rotational, lock-on) each change the *loop* in a different way. | See below. | **Unity (single sim, isolated).** |

**Why aim assist passes the rubric.**
1. **The concept is a closed control loop** (input mapping plus target motion plus feedback), not a fact. The reason aim assist exists (rate control from a thumbstick tracks a moving target worse than position control from a mouse) becomes obvious after ten seconds of tracking a strafing target with each scheme and would take several paragraphs of text to argue. Rubric signals met: *movement over time in space* and *timing in a scene*.
2. **The four assist types are distinguished by what they do to a moving reticle**, which is why fans use four different words. Native diagrams can label them; only running them shows that friction *slows* you, magnetism *pulls*, rotational *carries* your reticle with the target and lock-on *removes the aiming task*. The sim's freeze frame overlays input speed vs reticle speed (TraceChart) so learners see the same fingerprint they felt.
3. **The debate the enthusiast actually has is about strength**, and strength is felt. A learner who has tracked a target with and without assist can say "yeah, I get why controller players don't want it removed and why mouse players say it's too much" without faking a view.

**Why native is genuinely worse here.** The best native alternative (`hotspot-tap` of a diagram of reticle vs target plus `sequence-order`) presents the *result* of the control loop; it cannot make the learner *be* the controller. Building a tracking canvas in SwiftUI would be a fake game (the rule "never re-implement Unity simulation logic natively" and the catalog rule "if players or targets move, use Unity" apply).

**Honest weaknesses (and why the sim is still small and isolated).**
- A touch screen is not a thumbstick. The sim demonstrates rate vs position mapping on the same device using a virtual stick vs relative-drag direct aim; it does **not** claim to reproduce controller ergonomics or a mouse's precision. Copy says "a stick that steers speed" not "this is what a controller feels like".
- Motor-input activities are inaccessible to some learners; the sim ships with a **watch mode** (bot-driven tracking, learner only classifies) and a full native alternative lesson `mech-02-alt`.
- The concept is one lesson deep of a hundred-plus; it must be small: **one sim**, three rounds, about 3 minutes, all procedural art, no new hardware, built last in the roadmap (needs only a tiny `Controls` module and a `TrackingObjective`).

**Downgrade criterion (so this stays honest).** Before `spec-approved`: run a playtest of the sim against the native alternative (`mech-02-alt`) with 20+ novices, measured by post-lesson `aim-assist` and `stick-vs-mouse` concept checks a week later. If the sim group is not at least 8 points ahead on concept-check accuracy or self-reported "I get why people argue about it", **downgrade to native only** (`mech-02-alt` becomes `mech-02`; no Astra work). The same rule as football `routes.build` (P-09).

**Sim summary.** `games.controls.aim-assist.v1` ("Aim Assist, Felt"): 3 rounds of tracking a moving target with direct drag, then a virtual stick, then a virtual stick with a hidden assist; freeze-frame trace of input vs reticle speed; the learner names the assist type. Lessons `mech-02` and `shoot-01`. Native alternative `mech-02-alt`.

**What is not gamified.** No loot-box or gacha "pull" simulation (explained, never simulated); no toxic-chat "win the argument" game (`vocab-08` and `tog-06` teach de-escalation with `decision-scenario`); no ranking of "real gamers"; no purchase nudges; no health claims about play time beyond mainstream generic guidance; no betting or skin-gambling content.

---

## 13. Licensing & safety

**Media licensing (spec section 40: talk about works, do not redistribute them).** Games are copyrighted media. Swoon'd may discuss titles, genres, mechanics, franchises, creators, history, culture and recommendations. It may not redistribute the works.

| Area | Handling |
|---|---|
| Game imagery (screenshots, key art, box art, character renders, sprites, UI captures, fan art) | **None used.** All images are original Swoon'd illustrations (`original-swoond`): generic HUD, abstract genre mock-ups, controller silhouettes and schematic diagrams that resemble no specific game. No "fair use" reliance. Store deep links may open publishers' pages but Swoon'd does not embed their art. |
| Logos and trademarks (game titles, publisher and platform logos, controller glyph shapes) | Names as plain text facts only; no logos in art. Platform button shapes (for example Sony's four symbols) are trademarks/brand identity: teach layout by position and letter, mention the symbols in text only. |
| Audio (game music, sound effects, voice) | **None used.** Any `listening-id` clip is original synthesized audio (`original-swoond`); the licence note must say so. |
| Video (trailers, gameplay, esports broadcasts, clips) | **None embedded.** Link out to official channels only. No streamer clips. |
| Lyrics / text (dialogue, wiki, reviews, patch notes) | No copied text: explain patch notes, reviews and wiki articles in Swoon'd's words, cite the source and link. Fandom/wiki text is CC BY-SA but we still do not copy it. |
| Player and streamer likeness | Names as public facts only; no photos, avatars, quotes or endorsement implication. |
| Esports orgs, tournaments, teams | Names as plain text; no logos or broadcast footage; result cards as facts with source links. |
| Data terms | IGDB: free for non-commercial; commercial use needs a partner agreement. RAWG: attribution and active link; free commercial for small apps (under 100k MAU); no redistribution. Liquipedia: CC BY-SA 3.0 attribution; API free tier only for non-commercial open-source projects; commercial needs an agreement; rate limits. PandaScore: paid per game; betting-related use prohibited. Steam Web API: terms and rate limits apply. **All [verify at release]** and all accessed only through Swoon'd adapters. No unofficial or reverse-engineered APIs (spec section 39 spirit). |

**Safety and wellbeing.**
- Age ratings matter: the course never recommends mature-rated games to a learner who identifies as a minor and links to ESRB/PEGI-style ratings in plain text; recommendations describe content in Swoon'd's words.
- Gambling-like mechanics (loot boxes, gacha, skin gambling) are explained neutrally with consumer-protection framing; never simulated; never promoted.
- Online safety: mute/report/block, do not share personal info, party invites; toxicity handled by de-escalation, not retaliation (`vocab-08`, `tog-05`, `tog-06`).
- Health: generic mainstream guidance only (take breaks, sleep, posture); no medical or addiction claims; no promotion of long sessions; "she plays a lot" is never framed as a problem.
- Never encourage the learner to fake skill or ownership of a game.

---

## 14. Content assets

| Asset | Procedural vs original | Source | Notes |
|---|---|---|---|
| Generic HUD, minimap, health bar, cooldown ring diagrams | Original vector | in-house, `original-swoond` | Named diagram ids for `hotspot-tap` (`hud-generic-shooter`, `hud-generic-rpg`). |
| Controller layout silhouettes (generic twin-stick, Switch-style handheld, keyboard and mouse) | Original vector | in-house | Position labels (top/right/bottom/left), never platform symbols. |
| Genre mock-ups (first-person, third-person, isometric, side-scroller, top-down, turn-based menu) | Original abstract illustrations | in-house | Deliberately look like no real game. |
| Item rarity swatches | Original | in-house | Shape plus text (not color alone). |
| Timing bars, timeline diagrams (i-frames, cooldowns, netcode) | Procedural native | in-house | Rendered by the app. |
| Audio cues (low-health alarm, loot chime, hit marker tick) | Original synthesized | in-house, `original-swoond` | Documented synthesis recipe; no sampled game audio. |
| Aim-assist sim visuals | Procedural (Unity) | generated | Range backdrop, reticle, target, overlays. |

---

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Platforms, what's on screen, the genre map, modes and business, gamer vocabulary, and mechanics that explain what she is describing (section 2, 3).
- [x] 2. **What do enthusiasts care about?** Boss patterns, ranked and meta, patches, builds, backlog, hardware, esports, and the running debates (section 4).
- [x] 3. **What current information matters?** Releases, events, platform and price news, esports tentpoles, patches (section 6, `live-data.md`).
- [x] 4. **What should be interactive?** Recognition, vocabulary, judgment and conversation natively; one sim for the felt control loop (section 12).
- [x] 5. **What should NOT be gamified?** Spending and gambling mechanics, toxicity, gatekeeping, health claims, betting (section 12).
- [x] 6. **How should it personalize?** Platform, franchise/game, genre branch, creator, org, region, skill level; defaults specified (section 8).
- [x] 7. **What does conversational competence look like?** Decoding fifteen typical lines and asking one honest follow-up; 24 talk tracks (section 9).
- [x] 8. **What data providers are needed?** IGDB/RAWG for release data under licence, curated calendars, Liquipedia/PandaScore for esports under licence, official newsrooms link-only (section 6).
- [x] 9. **What licensing constraints apply?** No game imagery, audio, video, logos or copied text; original art only; provider terms (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8 per concept, say-this decoding accuracy, talk-track Smooth score, sim concept checks (section 10).

Additional gates: [x] manifest validates; [ ] curriculum validates (not authored yet); [x] the one Unity sim has a draft spec; [x] every image/audio asset planned with licence id `original-swoond`; [ ] voice review pending; [x] no copied publisher text.

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Can a Person have multiple genre branches (recommended: multi-select), and does the branch model support it? | Product / Claude Code | Yes (branch UI) |
| 2 | Sports and racing games (Madden, EA Sports FC, NBA 2K, racing) as a v1.1 branch or only via cross-links? | Product | No |
| 3 | Is `mech-06` (netcode) learnable natively, or does it earn a second Tier A sim after playtests? Current verdict: native. | Product / Astra | No |
| 4 | Aim-assist sim playtest against `mech-02-alt` (downgrade criterion in section 12). | Product | Before spec approval |
| 5 | Esports as a separate course later; per-title esports branches? | Product | No |
| 6 | Editorial provider for the news layer (L-01) and release-data provider licence (IGDB commercial agreement vs RAWG). | Product | Blocks live layer |
| 7 | Generative-AI-in-games discourse: include a `deb` lesson at launch or wait? Wording risk. | Product | No |
| 8 | Voice review: which lesson copy may joke about console wars and "gatekeeping" without punching down? | Product | No |

---

### Appendix: concept ids (from the curriculum map)

Concept ids are listed by unit in the tables above; the authoritative list is generated when curriculum JSON is authored. The Playbook terms in `exercises.md` (70 entries) use the same ids where a term exists in the map.
