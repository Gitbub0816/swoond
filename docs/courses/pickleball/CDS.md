# Course Design Specification: Pickleball (`pickleball`)

| Field | Value |
|---|---|
| Status | draft |
| Wave | 1 |
| Author / date | Course design agent (Sonnet), 2026-09-30 |
| Manifest | `manifest.json` |
| Companion files | `exercises.md`, `live-data.md`, `sims/*.md` |

Time-sensitive facts in this document (rules, formats, calendars) were checked by web search on 2026-09-30 and are tagged **[verify at release]** where a re-check is needed before content ships. Lesson copy never hard-codes them; the live layer and versioned rule tokens carry them (see `live-data.md`).

---

## 1. Identity

- **Course ID:** `pickleball` (immutable)
- **Display name:** Pickleball
- **Category / family:** Sports > Racquet sports > Pickleball (family `Sports`)
- **Simulation prefix:** `pickleball`
- **Two lenses, one course.** Pickleball is unusual: the person you care about may (a) **play** it a few times a week at a local court (the far more common case), (b) **watch** it (PPA Tour, MLP, streams), or (c) both. The course is built around that split. Every foundation unit teaches the game as a *player* experiences it, because pro pickleball is only legible once you know the kitchen and the two-bounce rule. Branches then tilt examples and live context toward play or spectating.
- **Related courses & boundary test (spec section 6):**

| Related | "If someone learns A, are they conversationally competent about B?" | Verdict | Consequence |
|---|---|---|---|
| Tennis (`tennis`, wave 2) | Partly on the surface (a net, a racquet, a ball, "cross-court") but the rules that people actually argue about are different: kitchen, two-bounce, serve underhand, scoring only on serve, tiny court, doubles-first culture. Tennis knowledge even *misleads* ("hit it hard", "come to net whenever"). | Adjacent, independent | Cross-link concepts (`serve-diagonal`, `lob`, `overhead-smash`, `topspin-backspin`); never merge. Lesson `court-01` addresses "it's just small tennis" directly. |
| Padel, badminton, table tennis | Similar feel, different sports; not in catalog. | Adjacent (not scheduled) | Mention as analogies only; no course dependency. |
| Golf, hiking, fitness | Social-adjacent (she may talk about all of them), no knowledge transfer. | Independent | None. |
| Pro tour sub-worlds (PPA, MLP, APP) | Learning the shared game makes you competent about each tour's *play*; the *structures* (rosters, drafts, tour points, DreamBreaker) differ. | Shares foundation | Modelled as branches with tour-specific lessons and live data. |

- **Branches:**

| id | Name | What changes |
|---|---|---|
| `rec-play` | She plays (recreational) | Examples use open play, ratings (DUPR, 3.5/4.0), etiquette, round robins, local courts, gear buying, injuries. Live layer emphasises gear and rule news, not standings. Default branch. |
| `ppa-tour` | PPA Tour fan | Individual pro events, draws, slams, points, World Pickleball Rankings, player rivalries. |
| `mlp` | Major League Pickleball fan | Team fandom: franchises, roster/draft, four-game match + DreamBreaker, standings and playoffs. |
| `app-tour` | APP / amateur circuit | Association of Pickleball Players events, mixed pro-amateur brackets, tournament divisions; strongest bridge to "she plays in tournaments". |

Branch choice sets personalization dimension `league` (PPA / MLP / APP / none) for the three pro branches.

---

## 2. Beginner model

**What a complete beginner knows.** "It's the old-people tennis thing", a wiffle-ball-looking ball, that it is "very popular", maybe that it is loud (the pop) and that people argue about noise. Some know "the kitchen" is a word and that you can't do something there. Almost nobody knows why the score has three numbers.

**Terminology that confuses:** kitchen / non-volley zone (NVZ), dink, third-shot drop, Erne, ATP, Bert, stacking, side-out, "pickled", "banger", "reset", "hands battle", "transition zone", "poach", "DUPR", "3.5", "paddle stack", "ball on court", "bounce it", "let" (there are no service lets), "rally scoring".

**Common misconceptions (each is a lesson beat):**
1. "Pickleball is just small tennis." (Different serve, scoring, the kitchen, the two-bounce rule; power is a liability at the net.)
2. "The kitchen is a no-go zone." False: you may stand in it; you may not *volley* while in it (or touching its line, or carried in by momentum). You can enter to hit a ball that has bounced.
3. "The kitchen line is safe." The line counts as kitchen for the volley rule. (For a serve the line is *short*, i.e. a fault.)
4. "You can only score if you serve" is right for side-out scoring, but beginners think everyone always scores each rally, or that the score is two numbers (it is three in doubles).
5. "Serve must be hit hard / overhand." It is underhand; the ball is struck below the waist with an upward arc (volley serve) or dropped and hit after a bounce (drop serve). 2026 wording tightens "clearly".
6. "A ball touching the line is out." Lines are in (baseline, sidelines, centerline). Exception: the kitchen line is kitchen for volleys; on a serve it is short.
7. "The best players hit hardest." Amateurs win with soft game; pros mix speed-ups into patient dink rallies. Power is chosen, not constant.
8. "You have to let it bounce every time." Only the first two shots (serve and return) must bounce. After that you may volley, except in the kitchen.
9. "A ball that hits the net cord on a serve is replayed." No service lets: if it clears and lands in the correct box, play on.
10. "Pickleball is for older players only." Participation skews old but the pro game is young and athletic; the amateur base is broad. Careful, cheerful phrasing only; never mock.
11. "Paddle brand is everything." The rules approve paddles by test, not by brand; feel, weight and surface matter.

**Concepts that unlock the rest (become foundation units):** the court map (kitchen, service boxes), the serve rules, the two-bounce rule, the volley definition and kitchen rule, three-number scoring and side-out logic, and the shot vocabulary (dink, drop, drive, volley). With those six, almost everything she says at the dinner table becomes decodable.

---

## 3. Foundational knowledge

Grouped into modules (become `foundationalModules[]` and foundation units).

| Module (unit id) | Content |
|---|---|
| `court-and-game` | Objective; court 20 x 44 ft (same as doubles badminton); net 36 in at posts, 34 in at center; kitchen/NVZ 7 ft from the net each side; service boxes; centerline; lines are in; paddle (max combined length+width 24 in; length max 17 in) and perforated plastic ball (roughly 26 to 40 holes; indoor holes larger and fewer than outdoor); doubles vs singles; origin story (1965, Bainbridge Island, Washington: Joel Pritchard, Bill Bell, Barney McCallum) [verify at release]. |
| `serve-and-return` | Underhand serve, diagonal, behind the baseline; volley serve rules (upward arc, paddle head not above wrist, contact below waist; 2026 wording: "clearly"; borderline serves are faults for officiated play); drop serve (any height, no propulsion); must clear the kitchen including line; lands in the diagonal service box (lines in); no service lets; return must bounce; two-bounce rule. |
| `the-kitchen` | Definition of a volley; no volley in the NVZ or on its line; momentum rule; may enter to play a bounced ball; must exit before volleying; paddle reaching over is fine when your feet are outside; the point of the zone. |
| `scoring-and-rotation` | Side-out scoring (only the serving side scores), 11 win by 2, three-number call (server score, receiver score, server number), first-server exception (0-0-2), even score = right side, odd = left; rally scoring (now formalized in the 2026 rulebook; optional, restricted for some championship-qualifying formats); best-of-three matches. |
| `shots-and-paddle-talk` | Dink, drop, drive, volley/block, overhead, lob, ATP, Erne, Bert; spin; grips; ready position; split step; the sounds of the game; slang (pickled). |
| `soft-game` | Why dinking; cross-court vs straight; attackable balls; reset; pop-ups; counterattacks; hands battle; speed-up. |
| `doubles-strategy` | Two-up positioning, the third shot (drop vs drive), transition zone, advancing to the line, moving as a team, the middle, communication, stacking, switching, poaching, targeting. |
| `rec-life` | Open play and the paddle stack, calling your own lines, benefit of the doubt, prompt out calls (2026), etiquette, levels (3.0 to 5.0+), DUPR, sandbagging, formats, injuries, singles/mixed. |
| `gear-and-paddle-science` | Materials (fiberglass, carbon, composite), polymer cores, thermoformed "Gen 3" construction, shape and swing weight, approved-paddle list, surface roughness and the USA Pickleball spin rate test (implementation date announced as Oct 1, 2026) **[verify at release]**, balls, shoes. |
| `pro-game` | Tours (PPA, MLP, APP) and the United Pickleball Association (UPA) umbrella; event formats; MLP team format and DreamBreaker; world rankings; pro styles; reading a pro point. |
| `debates-and-culture` | History and growth; rally vs side-out; paddle tech arms race; bangers vs dinkers; noise and court conversion; rating integrity; tour fragmentation; Olympic ambitions. |

**Rules state as of 2026 (verified by search 2026-09-30) [verify at release]:**
- USA Pickleball 2026 rulebook (effective Jan 1, 2026): "clear/clearly" language in all three volley-serve requirements (unclear = fault when officiated); rally scoring formalized (rule 2242: the rally winner scores; optional; restricted for certain qualifying formats); prompt out-call timing (rule 2221); net-post clarification (rule 2070); penalties before a match starts (rule 2093); ejection authority for violence/property damage (2090, 2091); adaptive standing division rules (2330-2334; e.g. two-bounce allowance for eligible players); a visible second ball during a rally reported as a fault (**verify wording in the rulebook itself before writing copy**).
- No service lets. Drop serve remains legal (no significant 2026 change). Kitchen rules unchanged.
- Pro calendar: Carvana PPA Tour 2026-27 season opened with the Veolia Pickleball National Championships (Cary, NC, Aug 31 to Sep 6, 2026, a "Slam"); the 2026-27 schedule has 20 US events plus 25+ international; **World Pickleball Rankings** launched with this season; Pickleball World Championships in Dallas in November; PPA Finals return to San Clemente, CA in May. PPA Tour offers rally scoring as a provisional option in 2026; APP stays with traditional side-out, games to 11.
- MLP 2026: May to August, nine regular-season events plus a mid-season tournament (with the Beer City Open, Grand Rapids), 20 teams at one competitive level, playoffs expanded to three weeks and 12 teams; full-roster usage (no starter/sub distinction); match = four games (women's doubles, men's doubles, two mixed) with a DreamBreaker rally-scoring tiebreak to 21 at 2-2. New Jersey Fives won the 2026 title over St. Louis Shock in Central Park, NYC (Aug 30, 2026).

---

## 4. Enthusiast model

**What enthusiasts talk about:**
- Last night's league/open play: who they partnered with, "the guy who bangs everything", a wild dink rally, a line call dispute.
- Level and ratings: "I'm a 3.5 trying to get to 4.0", DUPR movement, sandbagging in tournaments.
- Paddles: new paddle, raw carbon vs fiberglass, "gritty" surface, swing weight, the incoming spin test, "is my paddle about to be banned?"
- Strategy: third-shot drop reliability, resets, staying patient in the dink game, when to speed up, stacking.
- Watching: PPA finals, who's on a hot streak, MLP team allegiance, "did you see that Erne?"
- Courts: crowded courts, reservation apps, tennis courts converted, noise complaints.

**Distinctions that matter:** drop vs drive; dink vs reset vs block; attackable vs not attackable; kitchen vs "no man's land"; side-out vs rally scoring; volley serve vs drop serve; fiberglass vs carbon; indoor vs outdoor ball; 3.5 vs 4.0 ("my 3.5 game is still dinking into the net"); "get to the kitchen line".

**Knowledge that signals real understanding:** knowing why you dink (you cannot attack a ball that is below net height without popping it up), why the third shot is a drop (the serving team starts behind the baseline and needs time to reach the kitchen line), why the kitchen exists (to stop smashes from the net), the meaning of "attackable", and that patience wins amateur points.

**Beginner statements that sound obviously uninformed:** "Why don't they just hit it harder?"; "It's basically tennis, right?"; "Wait, the line is out?"; "So you score on every point?"; "The kitchen is where you can't stand"; "Can't you just smash everything?"; "Is it 15-love?" (tennis scoring).

**Common controversies:**
1. **Rally vs side-out scoring** for recreation and pro events.
2. **Paddle technology**: surface texture and spin, "illegal paddles", the USA Pickleball spin-rate testing regime; equipment approval politics.
3. **Tour fragmentation and player contracts** (PPA, MLP, APP; the UPA umbrella; who plays where; exclusivity).
4. **Bangers vs dinkers**: is the pro game too aggressive, is patience the "real" skill?
5. **Noise and conversion of tennis courts**; local ordinances; dedicated facilities.
6. **Rating integrity**: DUPR, sandbagging, reliability of self-rating, "rating-locked" tournaments.
7. **Olympics**: whether/when pickleball belongs; unresolved as of this writing **[verify at release]**.
8. **Serve rules** (drop vs volley; spin serves; "borderline is a fault" in 2026).
9. **Doubles vs singles**: pro singles is under-emphasised; the sport is doubles-first.
10. **Line calls**: self-officiating culture and prompt-out-call rule.

---

## 5. Interaction model

**What she experiences instead of reading.** Pickleball is learned through space and rhythm: where the kitchen is, where the ball lands, when to hit and when to wait. Most of that fits native exercises well because the court is a small, static diagram and the rules are yes/no. A few concepts are genuinely **spatial or dynamic** and are taught with Unity:

1. **The momentum fault** (a volley from outside the kitchen followed by a foot crossing in): needs motion over time; a static diagram cannot show "after".
2. **Serve aim and landing** (ball arc, diagonal box, the short line): ball flight over a net to a landing zone.
3. **Third-shot drop and advance** (arc height, landing in the kitchen, time to advance): the *why* of the drop is time and arc.
4. **Attack or reset** (read ball height relative to the net at the moment of contact): reading a dynamic scene.
5. **Doubles court coverage** (moving as a unit, the middle): movement of two agents against a shifting ball.

**Native carries the rest:** rules (binary-call, multiple-choice), scoring logic (decision-scenario, sequence-order, estimate-slider), vocabulary (term-match, fill-the-gap, say-this), diagrams (hotspot-tap), gear (visual-id, decision-scenario, term-match), etiquette (decision-scenario), pro formats (sequence-order, multiple-choice), conversation (talk-track, say-this), sound of the game (listening-id with original audio).

**Should NOT be gamified:** injury advice beyond generic caution (link to professionals; no medical claims); line-call disputes as a "win the argument" game (the lesson is de-escalation and understanding); ratings as status symbols; "who is best" pro rankings as a competitive toy. Nothing that encourages faking a level she doesn't have. Details in section 12.

---

## 6. Dynamic information requirements

Pickleball has a **modest but real** live layer. It is not ESPN-scale; a few hours of lag is fine (spec section 33). Detail in `live-data.md`.

| Kind | Needed? | Why | Provider candidates | Refresh | Fallback |
|---|---|---|---|---|---|
| schedules | Yes | "Is there a tournament this weekend?" starts most pro conversations | PPA Tour / MLP official calendars (editorial ingest, hand-curated at first); PickleballTournaments.com (link) | weekly | Last known calendar + "check the official site" link |
| events | Yes | Event context: slam, cup, open, MLP week | same | weekly | same |
| scores / results | Light | Who won gold, MLP match results | Official tour result pages (no known open API) via curated ingest; TheSportsDB only if coverage confirmed | minutes-during-events (pilot: daily) | Result card omitted; editorial explainer remains |
| standings | Yes (MLP) | Team standings/playoff picture | MLP official standings (curated) | daily during season | Static "how standings work" card |
| rankings | Yes | World Pickleball Rankings; player ranking movement | PPA Tour rankings page (curated), DUPR (partner API if licensed) | weekly | Last snapshot with date shown |
| rosters | Yes (MLP) | Who plays for whom; drafts/waivers | MLP official rosters (curated) | monthly / event-driven | Snapshot |
| news | Yes | Rule changes, paddle news, retirements, feuds | Link-only from pickleball media; editorial explainers by Swoon'd | daily | Evergreen explainer cards |
| new-products | Light | Paddle releases, spin-test approvals | USA Pickleball approved-paddle list (link), brand press (link) | monthly | Skip |
| conditions / weather / closures | Optional (rec branch) | "Can we play tonight?" court closures, weather | National Weather Service (public), municipal closure notices (none uniform) | hourly if enabled | Hidden |
| local courts | Optional | Personalization: her home court | OpenStreetMap (`sport=pickleball`, ODbL), Places2Play (USA Pickleball, link-out) | monthly | Hidden |

Structured data and editorial data are separate systems (spec section 11, 37).

---

## 7. Editorial context

- **What helps:** why a rule/equipment change matters (e.g. the spin-rate test and what it does to "gritty" paddles), why a tour move is controversial, why a player streak is notable, why fans argue about rally scoring, why a pro line call went viral.
- **Sources:** USA Pickleball rulebook and news (link + own-words explanation; rules are facts, but do not copy rulebook text wholesale), PPA Tour and MLP official sites (link), independent pickleball media (link-only). Sources listed in the manifest.
- **Treatment:** explain-and-link (default). Never copy publisher text; rulebook paraphrased in Swoon'd's words with rule numbers cited.
- **Example prompts (Ask card):** "Why are pickleball fans talking about paddles today?", "Why did that pro match end in a DreamBreaker?", "Why is rally scoring controversial?", "What does the spin-rate test change for someone who just bought a paddle?", "Why does everybody complain about the noise?"

---

## 8. Personalization

| Dimension | Values | Effects | Default | Units using tokens |
|---|---|---|---|---|
| `skill-level` | Never played, 2.5-3.0, 3.5, 4.0, 4.5+ (her level) | Which strategic lessons appear first; examples "at her level"; conversation lines ("that's a great 3.5 goal") | 3.5 | `rec-life`, `soft-game`, `doubles-strategy`, `branches` |
| `player` | Any pro (e.g. Ben Johns, Anna Leigh Waters, Federico Staksrud, Anna Bright, JW Johnson; from the live roster) | Player spotlight cards, talk tracks ("did you see {{player}}'s Erne?"), live feed prioritisation | None (generic) | `pro-game`, `branches`, `season-now`, `conversation-lab` |
| `team` | MLP franchise | Team feed, roster/standings, fandom talk tracks | None | `mlp` branch, `season-now`, `conversation-lab` |
| `league` | PPA / MLP / APP / none | Chooses branch emphasis and which live cards show | none = `rec-play` | `pro-game`, `branches`, `season-now` |
| `equipment` | Paddle brand/type (optional free text -> normalized) | Gear talk, spin-test relevance card | None | `gear-and-paddle-science`, `season-now` |
| `region` | Home court/city | Court/weather/closure context, local tournament link-outs | None | `rec-life`, `season-now` |

Tokens: `{{skillLevel}}`, `{{player}}`, `{{team}}`, `{{league}}`, `{{equipment}}`, `{{region}}`. Unset tokens fall back to generic phrasing ("your person's favorite pro"), never blank text. The foundation curriculum is unchanged by personalization.

---

## 9. Conversation model

**Ten-plus things an enthusiast might say, with translations** (each becomes a say-this or talk-track):

| # | Line | Meaning | Terms implied | Good next question |
|---|---|---|---|---|
| 1 | "I got pickled last night." | Lost 11-0 (shut out). | pickled, game-to-11 | "Ouch. Was it a tough partner matchup or just an off night?" |
| 2 | "My third-shot drop was on fire." | The soft arcing shot from the back that lands in the kitchen worked well. | third-shot-drop, transition-zone | "Did it get you to the kitchen line?" |
| 3 | "We kept getting stuck in dink wars." | Long soft rallies at the kitchen. | dink, soft-game | "Who blinks first?" |
| 4 | "He banged everything and it worked." | A player hit hard at everything and won points with it. | banger, drive, speed-up | "Did you just have to reset those?" |
| 5 | "I went for an Erne and it was glorious." | She leapt outside the kitchen to volley near the net post. | erne, kitchen, volley | "Did the opponent see it coming?" |
| 6 | "Foot fault on the kitchen!" | Volleyed with foot in or on the kitchen line, or momentum carried her in. | kitchen-nvz, momentum | "Was it the line or the momentum?" |
| 7 | "We stacked and it confused them." | Partners started on the same side to keep strengths where they want them. | stacking | "Who takes the middle?" |
| 8 | "I'm a 3.5 trying to break into 4.0." | Self-rating; wants to reach the next level. | skill-ratings, DUPR | "What's the biggest thing holding you back?" |
| 9 | "Total sandbagger. 3.0 my foot." | Someone under-rated themselves to win a bracket. | sandbagging | "Is that common at your tournaments?" |
| 10 | "New paddle, raw carbon, incredible spin." | Textured carbon face gives grip on the ball. | surface-roughness-spin | "Are you worried about the spin-rate testing?" |
| 11 | "They ran the table in the DreamBreaker." | MLP tiebreaker at 2-2 won decisively. | dreambreaker, mlp-team-format | "Did the team send its best DreamBreaker specialists?" |
| 12 | "Our team can't win on the road." | MLP team form, home/away events. | mlp-league | "Do they have an easier bracket next week?" |
| 13 | "Rally scoring ruins the comeback." | Debate: every rally scores, fewer long runs on serve. | rally-scoring | "Do you prefer side-out for rec play?" |
| 14 | "That was a hands battle." | Fast exchange of volleys at the kitchen. | hands-battle, block | "Who won that exchange?" |
| 15 | "Ball on court!" | Warning to stop play because a loose ball entered your court. | etiquette | none (safety call; learn to respond) |

**How Swoon'd helps without encouraging fake expertise:** every conversation item includes a `noFakeExpertNote` and follow-ups that are honest curiosity ("What made that drop work?"), never pretend analysis. Coach notes reward asking genuine questions and admitting "I'm still learning; teach me?". Cringe replies are the ones that fake authority or correct her ("Actually, it's spelled kitchen") or troll ("It's tennis for grandparents").

**Targets:** 18 talk tracks at launch (all `conversation-lab` plus one per unit end, plus 4 per branch over time), 60+ say-this items, 40+ fill-the-gap items.

---

## 10. Assessment

- **Useful competence** = she can (1) decode what her person says about a game in progress, (2) follow a match on court or screen and know what just happened and why it mattered, (3) ask two honest, informed follow-up questions, and (4) join a casual game or a viewing party without being lost.
- **Recognise:** court map, kitchen violations, serve legality, score calls, shots by name and by sound, paddle/ball types, pro formats and tours.
- **Understand:** why the kitchen and two-bounce rule exist; why the third shot is a drop; why dinking is patience not weakness; why side-out scoring makes serving valuable; why rally scoring is debated; what a rating represents.
- **Explain:** in her own words, "what is the kitchen", "how does the score work", "why did the pros go to a DreamBreaker".
- **Correctly interpret:** score calls (three numbers), a line call dispute, a scoreboard for MLP match (2-2 -> DreamBreaker), ranking movement, gear headlines.
- **Mastery model:** `concept-mastery-v1`, pass threshold **0.8** (foundations concepts held to 0.8; enthusiast-depth concepts count as Familiar at 0.6 for reporting). Review interval ladder: 1d, 3d, 7d, 14d, 30d, 60d (Playbook Review); max 12 items per daily session; a concept slipping below 0.6 re-enters the ladder at 1d.
- **Useful competence statement:** "She can follow a pickleball game or a pro match, understand the kitchen, the serve and the score, ask a couple of good questions about a shot or a paddle, and say 'okay, I get why you love this' without faking it."

---

## 11. Curriculum map (ongoing course)

Course version target at launch: `curriculumVersion 0.1.0` (structure + first units); see release plan. **15 units, 107 lessons, ~150 concepts** across all six layers. Activity legend: `mc` multiple-choice, `bc` binary-call, `tm` term-match, `so` sequence-order, `vi` visual-id, `ds` decision-scenario, `tk` talk-track, `tt` timing-tap, `st` say-this, `fg` fill-the-gap, `li` listening-id, `es` estimate-slider, `ht` hotspot-tap, `SIM` = Unity sim (id given). Lesson ids are stable kebab-case.

Every lesson ends with a "line you could say out loud" and 1-2 Playbook additions. Every unit's final lesson is a mixed-review capstone that includes one `tk` or `st` conversation beat.

### Layer 1: Foundations

**Unit `court-and-game`: The Court and the Game** (prereq: none). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `court-01` | So what is pickleball? | Say in one breath what pickleball is and why it isn't small tennis. | game-objective, pickleball-vs-tennis, pickleball-origin | mc, st |
| `court-02` | The court, measured | Locate the net, baselines, sidelines and centerline; know the size. | court-dimensions, net-height, centerline | ht, es |
| `court-03` | Kitchen and service boxes | Map the kitchen and the four service boxes. | kitchen-nvz, service-courts, kitchen-line | ht, tm |
| `court-04` | Lines are in | Know that baseline, sideline, centerline count as in. | lines-are-in | bc, mc |
| `court-05` | Paddle and ball | Recognize a legal paddle and ball and why the ball has holes. | paddle-basics, ball-basics | vi, mc |
| `court-06` | Singles or doubles | Explain why doubles dominates and what changes in singles. | doubles-vs-singles | mc, bc |
| `court-07` | How a point plays out | Order a rally: serve, return, third shot, then free play. | rally-flow, two-bounce-rule | so, tk |

**Unit `serve-and-return`: Serve, Return, Two Bounces** (prereq: `court-and-game`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `serve-01` | Underhand, diagonal, behind the line | Describe a legal serve position and target. | underhand-serve, serve-diagonal, serve-foot-fault | ht, bc |
| `serve-02` | The volley serve, in detail | State the three volley-serve requirements incl. 2026 "clearly". | volley-serve-rule | mc, fg |
| `serve-03` | The drop serve | Explain why the drop serve is allowed at any height and what changes. | drop-serve | tt, mc |
| `serve-04` | Aim it, land it | Land a serve in the correct diagonal box past the kitchen line. | serve-must-clear-kitchen, serve-lands-in-box, serve-diagonal, no-service-let | SIM `pickleball.serve.aim-and-land.v1`, bc |
| `serve-05` | Return of serve | Know the return must bounce and why deep is smart. | return-of-serve, return-deep | mc, ds |
| `serve-06` | The two-bounce rule | Decide who may volley when. | two-bounce-rule | bc, so |
| `serve-07` | Serve faults, sorted | Sort serve faults from legal serves; hear "fault!" and know why. | serve-fault-list, no-service-let | mc, st |

**Unit `the-kitchen`: The Kitchen** (prereq: `serve-and-return`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `kit-01` | What the kitchen is | Define the non-volley zone and its line. | kitchen-nvz, kitchen-line | tm, mc |
| `kit-02` | What is a volley? | Distinguish a volley from a groundstroke. | volley | mc, bc |
| `kit-03` | No volleys in the kitchen | Call fair vs faulty volleys with feet on court. | volley-in-kitchen-fault | bc, mc |
| `kit-04` | The line counts as kitchen | Recognize a toe on the line as in the kitchen. | kitchen-line-is-kitchen | ht, bc |
| `kit-05` | The momentum trap | Judge a volley followed by momentum into the zone. | kitchen-momentum, volley-in-kitchen-fault | SIM `pickleball.kitchen.momentum-call.v1`, bc |
| `kit-06` | When you can go in | Know you may enter to hit a bounced ball; must exit before volleying. | bounce-in-kitchen-ok, leave-kitchen-before-volley | ds, bc |
| `kit-07` | Reaching over | Know paddle over the zone is fine if feet are outside. | paddle-over-kitchen-ok | bc, mc |
| `kit-08` | Why the kitchen exists | Explain the zone's purpose (no smashes at the net). | kitchen-purpose, kitchen-nvz | fg, st |

**Unit `scoring-and-rotation`: Scoring and Who Serves** (prereq: `serve-and-return`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `score-01` | Only the server scores | Explain side-out scoring. | side-out-scoring, only-server-scores | mc, fg |
| `score-02` | The three-number call | Read a doubles call like "4-2-1". | score-call-three-numbers | mc, st |
| `score-03` | Server one, server two, side out | Follow the serve through both partners. | server-number, side-out | so, bc |
| `score-04` | The 0-0-2 start | Know why the first serving team gets one server. | first-server-exception | mc, ds |
| `score-05` | Even right, odd left | Pick the service side from the score. | serving-side-even-odd | ht, bc |
| `score-06` | Eleven, win by two | Know game and match lengths. | game-to-11-win-by-2, match-format | es, mc |
| `score-07` | Rally scoring | Explain rally scoring and where it is used (2026). | rally-scoring | mc, tm |
| `score-08` | Keep the score, keep the peace | Track a full game and settle a "what's the score" moment. | score-call-three-numbers, server-number, first-server-exception | ds, tk |

**Unit `shots-and-paddle-talk`: Shots and Paddle Talk** (prereq: `the-kitchen`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `shot-01` | Dink, drop, drive | Name the three core shots by flight and purpose. | dink, drop-shot, drive | tm, mc |
| `shot-02` | Volley, block, overhead | Tell volleys, blocks and smashes apart. | volley-shot, block, overhead-smash | tm, fg |
| `shot-03` | Lob, ATP, Erne, Bert | Decode the showy shots. | lob, atp, erne, bert | tm, vi |
| `shot-04` | Spin talk | Understand topspin and backspin (slice). | topspin-backspin | mc, li |
| `shot-05` | Grip, ready, split | Recognise the ready position and split step. | continental-grip, ready-position, split-step | tt, so |
| `shot-06` | The sounds of pickleball | Recognise shot types by sound. | shot-sounds, dink, drive | li, mc |
| `shot-07` | Say it like a player | Decode slang (pickled, banger, dinker). | pickled, player-slang | st, fg |

### Layer 2: Intermediate

**Unit `soft-game`: The Soft Game** (prereq: `shots-and-paddle-talk`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `soft-01` | Why we dink | Explain why patience is a weapon. | soft-game, dink | mc, st |
| `soft-02` | Cross-court and straight | Read dink patterns and where they go. | dink-cross-court, dink-patterns | ht, ds |
| `soft-03` | The attackable ball | Spot a ball high enough to attack. | attackable-ball | SIM `pickleball.soft-game.attack-or-reset.v1`, bc |
| `soft-04` | Reset | Explain the reset as a defensive soft shot. | reset | ds, mc |
| `soft-05` | Pop-ups and counters | Know why a pop-up loses the point and what a counter is. | pop-up, counter-attack | bc, st |
| `soft-06` | The hands battle | Understand the fast volley exchange at the line. | hands-battle, block | tt, tm |
| `soft-07` | When to speed up | Decide when a speed-up is smart. | speed-up, attackable-ball | ds, ht |
| `soft-08` | Dink-war review | Hold a dink-war conversation. | soft-game, dink-patterns, reset | mc, tk |

**Unit `doubles-strategy`: Doubles Strategy** (prereq: `soft-game`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `dbl-01` | Two up, two back | Explain the standard court positions. | court-positioning | ht, mc |
| `dbl-02` | The third shot | Contrast third-shot drop and drive. | third-shot-drop, third-shot-drive | mc, ds |
| `dbl-03` | Drop it, then move up | Understand why the drop buys time to reach the line. | third-shot-drop, transition-zone, advance-to-kitchen-line | SIM `pickleball.third-shot.drop-and-advance.v1`, bc |
| `dbl-04` | The transition zone | Identify no-man's-land and how to cross it. | transition-zone, split-step | ht, so |
| `dbl-05` | Move as a team | Cover the court together. | moving-as-a-team, court-positioning | SIM `pickleball.doubles.court-coverage.v1`, mc |
| `dbl-06` | Down the middle | Decide who takes the middle and how to call it. | middle-ball, forehand-in-the-middle, communication-calls | bc, ds |
| `dbl-07` | Stacking and switching | Decode stacking and switching. | stacking, switching | ht, so |
| `dbl-08` | Poach and target | Understand poaching and targeting the weaker side. | poaching, target-weak-side | ds, st |

**Unit `rec-life`: Life at the Courts** (prereq: `scoring-and-rotation`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `rec-01` | Open play and the paddle stack | Know how you get on a court. | open-play-rotation, paddle-stack | mc, so |
| `rec-02` | Call your own lines | Handle line calls fairly, incl. prompt out calls. | line-calls, benefit-of-the-doubt, prompt-out-call | ds, bc |
| `rec-03` | Court etiquette | Know "ball on court", warm-ups, gracious wins. | court-etiquette | ds, mc |
| `rec-04` | What 3.5 means | Read skill levels. | skill-ratings | tm, mc |
| `rec-05` | DUPR and sandbaggers | Understand ratings and their controversies. | dupr, sandbagging | mc, st |
| `rec-06` | Round robins, ladders, tournaments | Recognise formats and divisions. | rec-formats, tournament-divisions | so, mc |
| `rec-07` | Bodies, shoes, common sense | Know common injuries and prevention at a very general level. | injury-prevention | ds, mc |
| `rec-08` | Singles, mixed, skinny singles | Recognise the other formats. | singles-strategy, mixed-doubles | mc, st |

### Layer 3: Enthusiast depth

**Unit `gear-and-paddle-science`: Gear and Paddle Science** (prereq: `shots-and-paddle-talk`). 6 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `gear-01` | What paddles are made of | Contrast fiberglass, carbon, composite; core types. | paddle-materials, paddle-core | tm, vi |
| `gear-02` | Shape and swing weight | Understand elongated vs standard, weight and balance. | paddle-shape, swing-weight | mc, es |
| `gear-03` | Fit the player | Match a paddle style to a described player. | paddle-fit | ds |
| `gear-04` | Approved paddles and the spin test | Explain approval, roughness limits and the spin-rate test. | usap-approved-paddle, surface-roughness-spin, spin-rate-test | mc, st |
| `gear-05` | Balls, indoor and outdoor | Tell them apart and why they play differently. | indoor-vs-outdoor-ball, ball-approved | vi, li |
| `gear-06` | Shoes and the rest | Court shoes, eyewear, grips, bags. | gear-basics | ds, mc |

**Unit `pro-game`: The Pro Game** (prereq: `doubles-strategy`). 8 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `pro-01` | PPA, MLP, APP, UPA | Untangle the tours. | ppa-tour, mlp-league, app-tour, upa-merger | tm, mc |
| `pro-02` | How a pro event works | Follow a bracket, a slam and points. | pro-event-format, tour-points-slams | so, mc |
| `pro-03` | MLP: teams and DreamBreaker | Follow the four-game match and DreamBreaker. | mlp-team-format, dreambreaker | so, mc |
| `pro-04` | Scoring at the pro level | Know when pros use side-out vs rally. | rally-scoring-pro, side-out-scoring | mc, bc |
| `pro-05` | Bangers and dinkers | Read pro styles. | pro-styles | st, ds |
| `pro-06` | Pro singles | Understand singles at pro level. | pro-singles | mc, ht |
| `pro-07` | Read a pro point | Name what happened in a rally. | broadcast-reading, third-shot-drop, reset | ht, bc |
| `pro-08` | World rankings | Read the rankings. | world-rankings | mc, es |

**Unit `debates-and-culture`: Debates and Culture** (prereq: `rec-life` or `pro-game`). 7 lessons.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `deb-01` | Where it came from, why it exploded | Tell the origin story and growth. | pickleball-origin, pickleball-growth | so, mc |
| `deb-02` | Rally scoring or side-out? | Represent both sides of the debate. | debate-rally-vs-side-out, rally-scoring | st, ds |
| `deb-03` | The paddle arms race | Explain why gear is contested. | debate-paddle-tech, spin-rate-test | st, mc |
| `deb-04` | Bangers vs dinkers | Explain the style argument. | debate-banger-vs-dinker, pro-styles | st, ds |
| `deb-05` | Noise and courts | Understand neighbour disputes and court conversion. | debate-noise-and-courts | ds, mc |
| `deb-06` | Ratings and integrity | Explain sandbagging and rating debates. | debate-rating-integrity, dupr | st, ds |
| `deb-07` | Tours, contracts, the Olympics | Understand the business-side debates. | debate-pro-fragmentation, debate-olympics | st, mc |

### Layer 4: Branches and personalization

**Unit `branches`: Your Person's Pickleball World** (prereq: `court-and-game`, `serve-and-return`, `the-kitchen`, `scoring-and-rotation`). Branch-gated lessons; each lesson tagged with branch. 7 lessons.

| Lesson id | Title | Branch | Objective | conceptIds | Activities |
|---|---|---|---|---|---|
| `br-01` | A week at her courts | `rec-play` | Picture the routine: open play, leagues, drop-ins. | rec-branch-week, open-play-rotation | mc, tk |
| `br-02` | Her level, her struggle | `rec-play` | Recognise what each level struggles with. | level-progression, skill-ratings | tm, ds |
| `br-03` | Watching the PPA Tour | `ppa-tour` | Read a PPA event week. | ppa-watching, pro-event-format | mc, st |
| `br-04` | Being an MLP fan | `mlp` | Team fandom, roster, standings. | mlp-team-fandom, mlp-team-format | mc, tk |
| `br-05` | APP and amateur tournaments | `app-tour` | Know the amateur circuit and divisions. | amateur-tournaments, tournament-divisions | so, mc |
| `br-06` | Her favorite player | any pro branch | Profile `{{player}}`: style, rivalry, signature shot. | favorite-player-profile, pro-styles | st, mc |
| `br-07` | Her home court | `rec-play` | Understand her local scene: courts, clubs, hours. | local-scene | mc, ds |

### Layer 5: Current season / live

**Unit `season-now`: Season Now** (prereq: `pro-game` or `rec-life`). Templated; content refreshed by `live` hooks and editorial cards. 6 lesson templates (each instantiated per event/week).

| Lesson id | Title | Objective | conceptIds | Activities | Live hook |
|---|---|---|---|---|---|
| `live-01` | This week in pickleball | Know what's on and why it matters. | live-weekly-context | mc, st | schedules, events |
| `live-02` | Read the draw | Follow the current event's bracket. | draw-reading | mc, ht | events, results |
| `live-03` | Rankings movers | Interpret who moved and why. | ranking-movement, world-rankings | mc, es | rankings |
| `live-04` | MLP standings | Read the current MLP table and playoff picture. | mlp-standings | mc, tk | standings |
| `live-05` | The news explainer | Why is a headline a big deal? | rule-news-explainer | st, mc | news, new-products |
| `live-06` | New season primer | Reset for a new season/rulebook. | season-rollover | mc, so | seasonal |

### Layer 6: Conversation practice and perpetual review

**Unit `conversation-lab`: Conversation Lab** (prereq: any three foundation units; content grows with mastery). 8 lessons; also feeds the Talk tab.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `talk-01` | After her league night | Respond with curiosity to a play recap. | convo-follow-up-questions, dink, pickled | tk, st |
| `talk-02` | The line call story | Listen to a dispute without taking sides. | convo-line-call-story, line-calls | tk, st |
| `talk-03` | The new paddle | Ask smart gear questions. | convo-gear-talk, surface-roughness-spin | tk, st |
| `talk-04` | Watching the finals together | Follow along with someone. | convo-watching-together, broadcast-reading | tk, st |
| `talk-05` | Rating talk | Handle "I'm a 3.5" conversations. | convo-rating-talk, skill-ratings | tk, st |
| `talk-06` | Her team lost | Handle MLP fandom moods. | convo-team-talk, mlp-league | tk, st |
| `talk-07` | "You should come play" | Accept an invitation honestly. | convo-invitation-to-play, convo-admit-what-you-dont-know | tk, ds |
| `talk-08` | Say-this gauntlet | Decode five lines in a row. | (all layers, sampled) | st |

**Unit `review-loop`: Perpetual Review** (always available after first lesson). 4 lesson templates driven by the review policy.

| Lesson id | Title | Objective | conceptIds | Activities |
|---|---|---|---|---|
| `review-01` | Daily Bite | 1 card (mc/fg/tm) from due concepts. | (due concepts) | mc, fg |
| `review-02` | Weekly mix | 3-round session sampled by weakness. | (weak concepts) | mc, bc, ds, tk |
| `review-03` | Kitchen and score boss | Timed-free mastery check on the two most-misunderstood areas. | kitchen-momentum, first-server-exception, two-bounce-rule | SIM `pickleball.kitchen.momentum-call.v1` (hard), bc, ds |
| `review-04` | Term blitz | Playbook term drill. | (terms) | tm, fg |

**Review policy:** intervals 1d, 3d, 7d, 14d, 30d, 60d; max 12 items per session; new concepts enter after first correct use; concept below 0.6 re-enters at 1d. Sim results contribute masterySignals with the same weights as native (halved when hints used).

### Concept targets, personalization slots, release plan

- **Concept count target:** ~150 Playbook concepts (listed in the Appendix below).
- **Personalization slots:** `{{player}}`, `{{team}}`, `{{league}}`, `{{skillLevel}}`, `{{equipment}}`, `{{region}}` (section 8).
- **Release plan:**
  - **Launch (v0.1-1.0):** units `court-and-game`, `serve-and-return`, `the-kitchen`, `scoring-and-rotation`, `shots-and-paddle-talk`, `soft-game`, `doubles-strategy`, `rec-life`, `conversation-lab`, `review-loop`; sims 1, 2, 4 (serve aim, momentum, attack-or-reset) first; branch `rec-play` complete.
  - **Fast follow (1.1):** `pro-game`, `branches` (`ppa-tour`, `mlp`), sims 3 and 5, `season-now` with schedule/rankings/news cards.
  - **Ongoing:** `gear-and-paddle-science`, `debates-and-culture`, `app-tour` branch, new lessons per season (new rulebook each January, PPA season starting Aug/Sep, MLP season May-Aug), new talk tracks weekly during season.

### Appendix: Playbook concepts (ids)

Court: `game-objective`, `pickleball-origin`, `pickleball-vs-tennis`, `court-dimensions`, `net-height`, `centerline`, `kitchen-nvz`, `service-courts`, `kitchen-line`, `lines-are-in`, `paddle-basics`, `ball-basics`, `doubles-vs-singles`, `rally-flow`.
Serve: `underhand-serve`, `serve-diagonal`, `serve-foot-fault`, `volley-serve-rule`, `drop-serve`, `serve-must-clear-kitchen`, `serve-lands-in-box`, `no-service-let`, `return-of-serve`, `return-deep`, `two-bounce-rule`, `serve-fault-list`.
Kitchen: `volley`, `volley-in-kitchen-fault`, `kitchen-line-is-kitchen`, `kitchen-momentum`, `bounce-in-kitchen-ok`, `leave-kitchen-before-volley`, `paddle-over-kitchen-ok`, `kitchen-purpose`.
Scoring: `side-out-scoring`, `only-server-scores`, `score-call-three-numbers`, `server-number`, `side-out`, `first-server-exception`, `serving-side-even-odd`, `game-to-11-win-by-2`, `match-format`, `rally-scoring`.
Shots: `dink`, `drop-shot`, `drive`, `volley-shot`, `block`, `overhead-smash`, `lob`, `atp`, `erne`, `bert`, `topspin-backspin`, `continental-grip`, `ready-position`, `split-step`, `pickled`, `player-slang`, `shot-sounds`.
Soft game: `soft-game`, `dink-cross-court`, `dink-patterns`, `attackable-ball`, `reset`, `pop-up`, `counter-attack`, `hands-battle`, `speed-up`.
Doubles: `court-positioning`, `third-shot-drop`, `third-shot-drive`, `transition-zone`, `advance-to-kitchen-line`, `moving-as-a-team`, `middle-ball`, `forehand-in-the-middle`, `communication-calls`, `stacking`, `switching`, `poaching`, `target-weak-side`.
Rec: `open-play-rotation`, `paddle-stack`, `line-calls`, `benefit-of-the-doubt`, `prompt-out-call`, `court-etiquette`, `skill-ratings`, `dupr`, `sandbagging`, `rec-formats`, `tournament-divisions`, `injury-prevention`, `singles-strategy`, `mixed-doubles`.
Gear: `paddle-materials`, `paddle-core`, `paddle-shape`, `swing-weight`, `paddle-fit`, `usap-approved-paddle`, `surface-roughness-spin`, `spin-rate-test`, `indoor-vs-outdoor-ball`, `ball-approved`, `gear-basics`.
Pro: `ppa-tour`, `mlp-league`, `app-tour`, `upa-merger`, `pro-event-format`, `tour-points-slams`, `mlp-team-format`, `dreambreaker`, `rally-scoring-pro`, `pro-styles`, `pro-singles`, `broadcast-reading`, `world-rankings`.
Debates: `pickleball-growth`, `debate-rally-vs-side-out`, `debate-paddle-tech`, `debate-banger-vs-dinker`, `debate-noise-and-courts`, `debate-rating-integrity`, `debate-pro-fragmentation`, `debate-olympics`.
Branches / live / convo: `rec-branch-week`, `level-progression`, `ppa-watching`, `mlp-team-fandom`, `amateur-tournaments`, `favorite-player-profile`, `local-scene`, `live-weekly-context`, `draw-reading`, `ranking-movement`, `mlp-standings`, `rule-news-explainer`, `season-rollover`, `convo-follow-up-questions`, `convo-line-call-story`, `convo-gear-talk`, `convo-watching-together`, `convo-rating-talk`, `convo-team-talk`, `convo-invitation-to-play`, `convo-admit-what-you-dont-know`.

---

## 12. Interaction plan

Tier rubric (CLAUDE.md section 4): Unity only where spatial reasoning, movement, physics, timing in a scene, or camera perspective materially improves learning and a native exercise would teach it clearly worse. The design prototype's Pickleball kitchen game is a native `binary-call` (D-002) and stays native for the *static* rule; the *momentum* rule is a movement-over-time concept and is the one kitchen concept promoted to Unity.

| Lesson / activity family | Concepts | Type | Justification (why this and not the alternative) | Tier | Est. count |
|---|---|---|---|---|---|
| `kit-05`, `review-03`: Kitchen momentum call | kitchen-momentum, volley-in-kitchen-fault, kitchen-line-is-kitchen, bounce-in-kitchen-ok, paddle-over-kitchen-ok | `unity-sim` `pickleball.kitchen.momentum-call.v1` (spec `sims/pickleball.kitchen.momentum-call.v1.md`) | Rubric: **movement over time + camera perspective** (side-on view of feet vs line at the instant of contact and afterwards; slow-mo replay). Closest native: `binary-call` with a static diagram, which cannot show the *after* (follow-through) that makes momentum a fault. Weak alternative rejected. | A | 1 sim, 12+ scenarios |
| `serve-04`: Serve aim and land | underhand-serve, serve-diagonal, serve-must-clear-kitchen, serve-lands-in-box, no-service-let | `unity-sim` `pickleball.serve.aim-and-land.v1` | Rubric: **physics (ball flight) + spatial reasoning** (arc over net, bounce, correct diagonal box, short line). Closest native: `hotspot-tap` (teaches the boxes, not why a flat serve lands long or a soft one lands short). Native `hotspot-tap` still used in `serve-01` for the static map. | A | 1 sim, 12+ scenarios |
| `dbl-03`: Third shot drop and advance | third-shot-drop, third-shot-drive, transition-zone, advance-to-kitchen-line | `unity-sim` `pickleball.third-shot.drop-and-advance.v1` | Rubric: **ball flight + movement + timing**: the drop is only meaningful because its arc buys the team time to advance. Native `decision-scenario`/`binary-call` cannot show time-to-advance vs incoming counter-drive. | A | 1 sim, 12+ scenarios |
| `soft-03`, `soft-07`: Attack or reset | attackable-ball, reset, speed-up, pop-up, counter-attack | `unity-sim` `pickleball.soft-game.attack-or-reset.v1` | Rubric: **reading a dynamic scene** (ball height vs net at the bounce apex). Native cannot present a moving ball whose height decides the decision. | A | 1 sim, 15+ scenarios |
| `dbl-05`: Doubles court coverage | moving-as-a-team, court-positioning, middle-ball, forehand-in-the-middle, communication-calls | `unity-sim` `pickleball.doubles.court-coverage.v1` | Rubric: **spatial reasoning + movement** of two agents against a moving target; coverage is the concept (like football coverage). Native `hotspot-tap` shows a static position; it cannot show gaps opening as the ball moves. | A | 1 sim, 12+ scenarios |
| Court map, kitchen, service boxes, score positions | court-dimensions, kitchen-nvz, service-courts, serving-side-even-odd | `hotspot-tap` | Fixed diagram, no motion; hotspots are ideal (`docs/native-exercises/CATALOG.md` #13). | B | ~40 |
| Rule calls (lines are in, kitchen static, two-bounce) | lines-are-in, volley-in-kitchen-fault, two-bounce-rule, serve legality | `binary-call` | Two-way judgment on a static situation; the design's kitchen game. | B | ~70 |
| Scoring situations and rotation | score-call-three-numbers, server-number, first-server-exception | `decision-scenario`, `multiple-choice`, `sequence-order` | Logic of state (who serves next); text + facts table teaches better than an animation. | B | ~80 |
| Vocabulary and terms | dink, drop-shot, drive, block, erne... | `term-match`, `fill-the-gap`, `multiple-choice` | Recall and recognition. | B | ~150 |
| Gear recognition | paddle-materials, ball-basics | `visual-id` (procedural/original illustrations, `original-swoond` license) | Recognition; no third-party imagery. | B | ~25 |
| Sounds of the game | shot-sounds, indoor-vs-outdoor-ball | `listening-id` (original recordings/synthesised audio) | The pop and the dink sound are what people notice first; audio is the concept. | B | ~12 |
| Magnitudes (court size, bounce height, weights, score length) | court-dimensions, game-to-11-win-by-2 | `estimate-slider` | Numeric intuition. | B | ~20 |
| Drop-serve / split-step rhythm | drop-serve, split-step | `timing-tap` | 1D timing bar is enough (rubric row "Simple 1D timing bar: No Unity"). | B | ~12 |
| Etiquette, line call disputes, gear choice, rec dilemmas | line-calls, court-etiquette, paddle-fit | `decision-scenario` | Judgment with consequences and an expert note. | B | ~50 |
| Conversation | all | `talk-track`, `say-this` | Native conversation practice (Talk tab and unit ends). | B | 18 talk tracks + ~80 say-this |
| Pro-format sequencing (bracket flow, MLP match order) | mlp-team-format, dreambreaker | `sequence-order` | Order matters; text list suffices. | B | ~15 |

**Not used:** none of the 13 native types is unused; all appear. Accessibility fallback: each sim has a native fallback lesson (a designed `binary-call`/`decision-scenario` set) named in its spec section 16.

---

## 13. Licensing & safety

| Area | Handling |
|---|---|
| Imagery | No third-party photos at launch. Procedural/original illustrations only (`license: original-swoond`). Player photos not used without a written license; "player spotlight" cards use name + text only. |
| Audio | Only original recordings of paddle/ball sounds (foley) or synthesised audio (`original-swoond`). No broadcast audio. |
| Logos / trademarks | Tour logos (PPA, MLP, APP, UPA, team marks) and paddle brand marks are trademarks: text-only mentions, link-outs, no logos in lesson art without permission. Paddle brands appear as text in gear lessons only where needed. |
| Video | No embedded broadcast video; deep-link to official streams. Any highlight embeds only via official embed (YouTube) with tour permission. |
| Rulebook | USA Pickleball rulebook is copyrighted: paraphrase rules in Swoon'd words with rule numbers; link to the official PDF; never republish text. |
| Data terms | No official public pro API known; curated ingest of public facts (dates, names, results) from official pages with attribution/links, licensing reviewed before any automated scraping; DUPR requires a partner agreement; OpenStreetMap ODbL attribution. |
| Player likeness | Names as facts only; no likeness or endorsements implied; no fabricated quotes. |
| News text | Never copied; explain and link (spec section 11). |
| Safety | Injury/health content generic ("warm up, wear court shoes, stop if it hurts, see a professional"); no medical claims. Court etiquette and line-call scenarios avoid encouraging confrontation. Heat/hydration mentions generic. No claims about age or fitness. |
| Voice/people | Never mock older players, beginners, or "pickleball people"; jokes target our learner's ignorance, never the crush. |

---

## 14. Content assets

| Asset | Type | Source | License id |
|---|---|---|---|
| Court diagrams (top-down, side-on) | Procedural (SVG/SwiftUI/Unity) | Generated | `original-swoond` |
| Shot flight diagrams (dink/drop/drive arcs) | Procedural | Generated | `original-swoond` |
| Paddle/ball illustrations (materials, shapes, holes) | Original vector art | Swoon'd | `original-swoond` |
| Shot sounds (dink, drive, volley, indoor vs outdoor ball) | Original foley recordings | Swoon'd | `original-swoond` |
| Player spotlight cards | Text + stats from curated data | Curated | n/a (no images) |
| Sim scenes | Procedural low-poly court, characters, ball | Astra | `original-swoond` |

---

## 15. Section 47 quality checklist

- [x] 1. **What does a beginner need to understand?** Court map, serve, two-bounce, kitchen rule (and its momentum trap), three-number scoring, shot vocabulary (sections 2, 3).
- [x] 2. **What do enthusiasts care about?** Levels, paddles, third-shot drop, dink patience, rally vs side-out, pro formats, noise (section 4).
- [x] 3. **What current information matters?** Tour calendar, results, MLP standings, rankings, rule/equipment news (section 6).
- [x] 4. **What should be interactive?** Five Unity sims (kitchen momentum, serve aim, third-shot drop, attack or reset, court coverage) plus native rules, scoring, gear, conversation (section 12).
- [x] 5. **What should NOT be gamified?** Injury advice, line-call disputes as contests, rating status, pro rankings as a toy (section 5).
- [x] 6. **How should it personalize?** skill level, player, team, league, equipment, region (section 8).
- [x] 7. **What does conversational competence look like?** Decode her recaps, ask honest follow-ups, admit gaps, invite/accept play (sections 9, 10).
- [x] 8. **What data providers are needed?** Curated official tour calendars/results/standings, DUPR (partner), OSM, NWS, editorial link sources (section 6; `live-data.md`).
- [x] 9. **What licensing constraints apply?** Trademarks, rulebook, broadcast, player likeness, data terms (section 13).
- [x] 10. **How will Swoon'd measure useful understanding?** Concept mastery 0.8, review ladder, talk-track Smooth >= 60, sim masterySignals, competence statement (section 10).

Additional gates: [ ] manifest validates (run `tools/validate`); [ ] curriculum validates (not yet authored); [x] every Unity sim has a draft spec (`sims/`); [ ] every image/audio asset has a license id (assets not yet produced; ids defined); [ ] voice review; [x] no copied publisher text (all copy original).

---

## 16. Open questions

| # | Question | Owner | Blocking? |
|---|---|---|---|
| 1 | Confirm the "visible second ball is a fault" wording and rule number in the 2026 rulebook before writing any lesson on it. | Content | No |
| 2 | Spin-rate test: confirm the effective date, RPM threshold and grandfathering after Oct 1, 2026; update `gear-04` and the `season-now` news card. | Content | No |
| 3 | Olympic status of pickleball (LA 2028 / later): re-verify before `deb-07` ships. | Content | No |
| 4 | Any official/licensable pro results API? Until then live results are curated. | Product/Data | No (launch uses curated) |
| 5 | DUPR partner API licensing for rankings/rating cards. | Product | No |
| 6 | Can we license original foley from a recordist, or record in-house? (Listening exercises.) | Product | No (synthesise for MVP) |
| 7 | Should `tennis` cross-link lessons be authored when that course ships? | Product | No |
| 8 | Astra: confirm Game Kit additions requested in sim specs (`Court`, `Serve`, `BounceRule` module names reserved in GAME_KIT.md section 2). | Astra | Yes for sim build |
