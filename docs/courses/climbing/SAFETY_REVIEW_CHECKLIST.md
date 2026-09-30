# Climbing curriculum: safety and accuracy review checklist

For authors and reviewers of `climbing` curriculum units and exercises. Modelled on `docs/courses/hiking/SAFETY_REVIEW.md` (its failure patterns: "keep going" rewarded, overstated absolutes, wrong answer keys, placeholder consequences). No units exist yet, so there is no findings table; this is the standard units must pass. A qualified human reviewer (certified climbing instructor or AMGA-certified guide, plus an Access Fund or Leave No Trace trainer for ethics) signs off before release (D-017, OPEN_QUESTIONS P-18).

Validator while authoring: `cd tools/validate && node validate.mjs --course climbing --partial`. Keep any one activity type at or below 40% of a unit (over 50% is a lint error). Every `decision-scenario` needs a `safetyNote`.

## A. The prime rule
Swoon'd teaches **appreciation and conversation**. It never teaches how to climb safely. Never write content that could be followed as instructions for:
belaying, lead climbing, clipping, falling or catching falls, placing or evaluating protection, building or checking anchors, rappelling or lowering, knots, tying in, harness or rope use, spotting, pad placement, reading outdoor routes for safety, free soloing, or treating injuries.
You may **name** these things (quickdraw, cam, belay device, rappel) and say why they matter. You may not say how.

## B. Every technique-adjacent lesson
1. States, or its explanation implies, "learn this from a certified instructor, a gym class, or a guide".
2. Uses names and ideas only (what a quickdraw is for, why a lead fall is bigger than a top-rope slip) with no steps, sequences, numbers, distances or checks.
3. Never includes a `sequence-order` of a safety procedure (no ordering "belay check" steps, rope setup, rappel, anchor or fall steps). Sequence-order is allowed for project life, wall angles, formats and history only.
4. Never includes a `hotspot-tap` or `visual-id` that depicts a correct safety configuration (tie-in, belay stance, anchor). Gear is recognised by name and purpose only.
5. Movement words (heel hook, drop knee, dyno, flagging) are recognition and conversation. No body-position coaching for a real climb, no "the right beta", no fall technique.

## C. Decision scenarios (safety)
6. The best answer is the cautious one: decline untrained belaying, ask gym staff, book a class or guide, stop and rest a painful finger, obey closures, retire doubtful gear, admire free soloing without imitating.
7. "Just do it", "copy what others do", "watch a video then belay", "your friend knows best" are never `best` and never `acceptable` when the action is a safety-critical skill.
8. `acceptable` is reserved for a cautious-but-incomplete step (for example "take a gym intro first" when a guide is best). Never mark a risky option `acceptable` to balance the set.
9. Emergencies and accidents are not scored, timed or turned into hearts; no timers, streak bonuses or speed rewards on any safety content.
10. Do not write a scenario that depicts a real accident with a named person or a recent real fatality. Famous ascents are told as achievements, with a note that such feats took years of preparation and are not models.
11. No scenario may imply a route, anchor, weather or condition is safe. Conditions are informational and link to the land manager.
12. Consequences are concrete and calm. No placeholders ("This affects your safety"); no gore.

## D. Facts and absolutes
13. Avoid "all", "always", "never", "safe", "guaranteed" unless an official body says so. "Crash pads reduce, not remove, risk." "Gear is checked and retired" (not "never fails").
14. Grades: say "graded" or "commonly graded"; conversions are approximate. Never give a conversion table as exact. V-scale began at Hueco Tanks; Font is Fontainebleau; YDS is 5.x with letters from 5.10.
15. Olympics: Tokyo 2020 one combined medal; Paris 2024 speed plus boulder-and-lead combined; LA28 separate boulder, lead and speed medals (approved 2025). Re-verify at build time.
16. Records and firsts (Silence 9c, Burden of Dreams V17, Dawn Wall 2015, Lynn Hill's 1993 Nose, Free Solo 2017, Honnold on Taipei 101 in January 2026, Margo Hayes 2017) must match a primary source; write "graded" and dates as verified in `NOTES_FOR_ORCHESTRATOR.md`.
17. IFSC scoring rules and speed records change; keep them out of static lessons or mark them `live`/dated.
18. Medical: only "rest, and see a clinician if pain persists". No doses, no taping protocols, no rehab plans.

## E. Culture, ethics and access
19. Leave No Trace uses the 7 principle names exactly: plan ahead and prepare; travel and camp on durable surfaces; dispose of waste properly; leave what you find; minimize campfire impacts; respect wildlife; be considerate of other visitors.
20. Seasonal and cultural closures are obeyed, always framed as protecting wildlife, rock and trust. Never teach "go anyway".
21. Chipping and unsanctioned bolting are condemned; bolting ethics are presented as a community debate with both camps fairly described and no how-to.
22. Never discourage calling for help, asking staff or saying "I don't know".

## F. Conversation and voice
23. Talk tracks reward honest lines ("I'm not belay-tested yet, can I take a class?") and never reward boasting, faking experience or giving gear or technique advice. A cringe reply is one that fakes expertise or downplays risk.
24. Never frame climbing as a way to impress or prove something to the crush. Cheeky coach, never mean, never about the crush, one joke per screen.
25. No athlete photos, likenesses or quoted text; no brand logos; route and athlete names as text only.

## G. Activity hygiene (from hiking's review)
26. Rework any arithmetic or answer key you write (wall heights, day counts, grade steps).
27. Each hotspot has a distinct position; multiple correct answers are marked; diagram assets must match the coordinates.
28. No placeholder text; no truncated follow-ups; no `safetyNote` text inside `expertNote`.
29. Multiple correct answers that could both be right must be reworded (for example flash vs onsight need the watching condition stated).
30. Sim scenario data stays within the sim spec scope: no climber figure, no movement, no falls; "usually" language for crux heuristics; set `decisionTimerSeconds` never.

## Review sign-off
- [ ] Automated: validator clean with `--partial`.
- [ ] Author self-check against A to G.
- [ ] Orchestrator spot-check of every `decision-scenario` for rule 6 to 9.
- [ ] Human reviewer (certified instructor or guide) sign-off, recorded in this file with name, credential, date and unit list.
