# Native Exercise Catalog (Tier B)

Native exercises are built by Claude Code in Swift/SwiftUI. Pure logic (validation, scoring, session state) lives in `SwoondCore/Exercises`; rendering lives in `SwoondApp/Exercises`. Payload contracts: `docs/contracts/native-exercises/v1/<type>.schema.json` (+ `examples/`).

Use a native exercise when a game engine gives no meaningful advantage (spec rule 6). If the concept needs spatial reasoning, movement, physics, camera or continuous timing in a scene, use a Unity sim instead (see the rubric in `CLAUDE.md`).

## Shared behavior (applies to every type unless noted)

- **Loop:** prompt -> one decisive interaction -> instant explanation -> a line you could say out loud (`docs/design/DESIGN_SPEC.md` section 8). Prompt is a Display M serif line (12 words or fewer, schema max 120 chars).
- **Feedback panel:** appears immediately; input disabled until Continue. Title "Nice read." (correct, `reward-tint` background, gold pulse 250 ms + light success haptic) or "Not quite." (wrong, `accent-tint`, 6 px horizontal shake + warning haptic), then a 13/1.45 explanation. Color is never the only signal.
- **XP:** +10 per correct answer (+40 when a 3-round session finishes; +10 Daily Bite). **Hearts:** wrong answer = -1 heart (5 max; Swoon'd+ unlimited). Exceptions stated per type.
- **Session:** three rounds, about three minutes; UI groups three activities.
- **Mastery:** each activity's `conceptIds` get +0.20 (correct) or -0.15 (wrong), see ARCHITECTURE section 6.1.
- **Accessibility:** all targets >= 44 pt; VoiceOver labels from payload (`alt`, `label`); Dynamic Type up to accessibility sizes (layouts reflow, no truncation of explanations); Reduce Motion replaces sweeps/shakes with cross-fades (feedback via gold/rose tint + text); no red/green-only meaning; haptics respect the Sounds & haptics setting.
- **Tokens:** `court` for playing surfaces, `accent` for the learner's selection, `reward` for correctness/XP, `surface` cards with 20-22 radius, pill buttons, one filled accent button per screen (Continue is the primary `ink` button; game CTA uses `accent`).
- **Metal / C++:** "Optional" below means the type can be built plain SwiftUI first; Metal (via MetalKit + Swift/C++ interop) is an upgrade for richer visuals only, never a functional requirement.

---

## 1. multiple-choice
- **Purpose:** Check recall or understanding with 2-5 text options.
- **When to use:** Terms, rules, "which is true", quick knowledge checks; the default review card.
- **UI sketch:** Display M prompt at top; option rows (`surface`, radius 16, 56 pt) stacked; selected row gets `accent` border + `accent-tint`; feedback panel slides up (250 ms) under the options; Continue (primary) pinned 28-34 pt above the safe area.
- **Payload:** `multiple-choice.schema.json` (`options`, `correctOptionIds`, `allowMultiple`, `explanation`).
- **Scoring:** Correct if selected set equals `correctOptionIds`. Multi-select: no partial credit in v1.
- **Hearts/XP:** Wrong = -1 heart; correct = +10.
- **Accessibility:** Options are buttons with selected trait; order shuffled unless `shuffle:false`, VoiceOver reads position ("2 of 4").
- **Metal:** No.

## 2. binary-call
- **Purpose:** A two-way judgment (Volley it / Let it bounce; In / Out; Penalty / No penalty). Design's pickleball game.
- **When to use:** A rule with a clear yes/no in a situation, best illustrated by a diagram.
- **UI sketch:** `court` diagram card with a rose player dot and gold ball (markers normalized 0-1); two large pill buttons; feedback panel and "Next rally" button.
- **Payload:** `binary-call.schema.json` (`scene`, `choices[2]`, `correctChoiceId`, `ruleTag`, `explanation`).
- **Scoring:** Right/wrong.
- **Hearts/XP:** Wrong = -1 heart; correct = +10.
- **Accessibility:** Diagram has `alt` describing the situation; choices are labelled buttons; no reliance on dot color alone (shapes differ: ball circle, player ring).
- **Metal:** Optional (animated ball trajectory and court perspective).

## 3. term-match
- **Purpose:** Connect terms to plain-English definitions.
- **When to use:** Introducing 3-6 terms of one topic (positions, flags, glazes).
- **UI sketch:** Two columns (terms left, definitions right) on wide layouts; on phone, tap a term then a definition, matched pairs lock with a gold outline and a connecting line.
- **Payload:** `term-match.schema.json` (`pairs`, `distractorDefinitions`).
- **Scoring:** Score = correct pairs on first attempt / total. Each wrong pairing attempt is counted as a mistake but does not cost a heart until 2 wrong attempts on one term.
- **Hearts/XP:** -1 heart per 2 wrong attempts (max -1 per exercise); +10 if all matched with at most 1 wrong attempt, else +5.
- **Accessibility:** Alternative to drag: tap-tap only; VoiceOver announces "matched".
- **Metal:** No.

## 4. sequence-order
- **Purpose:** Teach a process or ordering (pottery steps, race weekend flow, cooking order).
- **When to use:** Crafts, cooking, brewing, race-format concepts where order matters.
- **UI sketch:** Vertical list of cards with drag handles; "Check" button; correct order revealed with numbered gold badges and per-step `why` text.
- **Payload:** `sequence-order.schema.json` (`items` authored in correct order, `partialCredit`).
- **Scoring:** With `partialCredit`: fraction of items in correct position (longest-common-subsequence based for fairness). Correct = 100%.
- **Hearts/XP:** -1 heart if < 60% positions correct; +10 if 100%, +5 if >= 60%.
- **Accessibility:** Reorder via "Move up/down" accessibility actions, not drag only.
- **Metal:** No.

## 5. visual-id
- **Purpose:** Recognize something by sight (car model, bird, tool, garment).
- **When to use:** Recognition is the skill; image licensing is cleared.
- **UI sketch:** Large image card (radius 20) with a photo scrim only if text overlays; 2-6 text options (or image options for "which one is X").
- **Payload:** `visual-id.schema.json` (`image{asset,alt,license}`, `options`, `correctOptionId`, `cues`).
- **Scoring:** Right/wrong.
- **Hearts/XP:** Standard.
- **Accessibility:** `alt` must describe the distinguishing features without giving away the answer; `cues` are read in feedback.
- **Licensing:** Every image carries a `license` id; no unlicensed logos or photos (spec rule 10).
- **Metal:** Optional (zoom/pan with high-res detail).

## 6. decision-scenario
- **Purpose:** Teach judgment: given facts, choose an action (spec section 17 hiking example).
- **When to use:** Hiking, camping, travel, cooking, photography: judgment over simulation.
- **UI sketch:** Fact sheet card (label/value rows, warnings flagged with `accent-soft` text and an icon), 2-4 action options, then a consequence panel and "what an experienced person weighs" note (serif italic).
- **Payload:** `decision-scenario.schema.json` (`situation.facts`, `options[{verdict,consequence,considerations}]`, `expertNote`, `safetyNote`).
- **Scoring:** best = 100, acceptable = 50, poor = 0.
- **Hearts/XP:** poor = -1 heart; best = +10; acceptable = +5, no heart lost.
- **Accessibility:** Facts read as a list; warnings announced with "Warning".
- **Safety:** Safety-relevant courses must fill `safetyNote`; scenarios are learning aids, not navigation/safety training.
- **Metal:** No.

## 7. talk-track
- **Purpose:** Conversation practice: reply to messages from someone who loves the interest. Design's hockey chat.
- **When to use:** Every course; Talk tab and end-of-unit conversation lessons.
- **UI sketch:** Chat bubbles (max width 260; yours `accent` radius 20/20/6/20; theirs `#1F1E24` 20/20/20/6); 2-4 reply chips beneath; "Smooth" meter (starts at 50); gold italic coach note (16 px) after each pick; restart at the end.
- **Payload:** `talk-track.schema.json` (`exchanges[].replies[{smoothDelta -20..30, theirResponse, coachNote}]`).
- **Scoring:** Smooth = clamp(start + sum of deltas, 0, 100). "Success" if Smooth >= 60 at the end.
- **Hearts/XP:** No hearts (conversation practice is forgiving). XP +40 on completion, +10 bonus if Smooth >= 80.
- **Accessibility:** Bubbles are announced as "You said" / "They said"; meter has value text.
- **Note:** Teaches understanding, never canned expert impersonation (spec section 13).
- **Metal:** No.

## 8. timing-tap
- **Purpose:** One-dimensional timing feel (pit stop window, serve toss, perfect brew time). Design's Pit Stop.
- **When to use:** Timing is the concept and a 1D bar is enough. If timing depends on a 3D scene, use Unity.
- **UI sketch:** 44 pt bar with a gold zone; a marker sweeps back and forth; tap to stop; tire/round indicators turn gold; readout in Numeral serif; zone shrinks and speed rises per round.
- **Payload:** `timing-tap.schema.json` (`rounds[{zoneStartPct, zoneEndPct, sweepSeconds}]`, `theme`).
- **Scoring:** Hit = 100. Miss = `max(0, 60 - off*3)` where `off` = percentage-point distance to the nearest zone edge. Display clock (pit-stop theme) = `11.2 + off*0.12` s. Session score = mean of rounds.
- **Hearts/XP:** Round score < 40 = -1 heart (at most 1 per session); +10 per hit round; +40 on finishing.
- **Accessibility:** Reduce Motion or Switch Control -> `tap-to-stop-slow` (slower sweep, larger zone x1.5) or `hold-and-release`; haptic tick at the zone edge; VoiceOver: "Tap to stop" with audible rising tone.
- **Metal:** Optional (fluid marker trail, glow).

## 9. say-this
- **Purpose:** Conversation interpretation: "What is she talking about?" (spec section 13).
- **When to use:** Every course, especially enthusiast-depth and current-season lessons where fan slang appears.
- **UI sketch:** Quote card in Display S serif with speaker name (italic); multi-select concept chips (`accent-tint` when selected); after Check, translation panel and 1-3 follow-up lines in serif with a "why it works" caption.
- **Payload:** `say-this.schema.json` (`statement`, `options[{isCorrect}]`, `translation`, `followUps`, `noFakeExpertNote`).
- **Scoring:** F-measure of selected vs correct set; >= 0.75 counts as correct.
- **Hearts/XP:** Below 0.5 = -1 heart; correct = +10.
- **Accessibility:** Multi-select announced; all copy in text.
- **Metal:** No.

## 10. fill-the-gap
- **Purpose:** Complete a sentence to reinforce terms in context.
- **When to use:** Vocabulary in context; quick review card.
- **UI sketch:** Display S sentence with inline gap chips; tapping a gap opens 2-5 option chips; filled gaps show `accent` outline.
- **Payload:** `fill-the-gap.schema.json` (`template` with `{{gap}}` tokens, `gaps[{options, correct}]`).
- **Scoring:** All gaps correct = correct; otherwise wrong (v1).
- **Hearts/XP:** Standard.
- **Accessibility:** Gaps are labelled "blank 1 of 2".
- **Metal:** No.

## 11. listening-id
- **Purpose:** Recognize a sound (instrument, genre cue, bird call).
- **When to use:** Music, birding, instruments. Only with licensed or original audio (spec section 20).
- **UI sketch:** Large play button with waveform, plays counter (`maxPlays`), 2-5 options; feedback lists `listenFor` cues.
- **Payload:** `listening-id.schema.json` (`audio{asset,durationMs,license,description,maxPlays}`, `options`, `correctOptionId`, `listenFor`).
- **Scoring:** Right/wrong.
- **Hearts/XP:** Standard.
- **Accessibility:** `audio.description` is shown as a text alternative on request and always in feedback; provide "Skip" that awards no XP and no heart loss for learners who cannot hear audio.
- **Licensing:** `license` is mandatory; recordings without a licensing basis are rejected in review.
- **Metal:** Optional (spectrogram visualization).

## 12. estimate-slider
- **Purpose:** Build intuition for magnitudes (game length, tire pressure, trail elevation).
- **When to use:** A number is the lesson and closeness matters more than exactness.
- **UI sketch:** Numeral serif value above a slider (`step`), min/max labels; after lock-in, correct value shown as a gold marker on the track.
- **Payload:** `estimate-slider.schema.json` (`min,max,step,unit,correctValue,tolerance{full,partial}`).
- **Scoring:** within `full` = 100; within `partial` = 50; else 0.
- **Hearts/XP:** 0 = -1 heart; 100 = +10; 50 = +5.
- **Accessibility:** Slider supports adjustable trait with step increments; value spoken with unit.
- **Metal:** No.

## 13. hotspot-tap
- **Purpose:** Tap a region on a static or procedural diagram (where a safety lines up, which part of a pot is the foot).
- **When to use:** Spatial knowledge on a fixed diagram without motion. If players move, use Unity.
- **UI sketch:** Diagram card (`court` background when a playing surface) with invisible hotspots; on answer, correct region outlined gold, tapped wrong region rose.
- **Payload:** `hotspot-tap.schema.json` (`diagram{asset|diagramId,alt,aspectRatio}`, `hotspots[{id,label,shape}]`, `correctHotspotIds`).
- **Scoring:** Right/wrong (tap inside any correct hotspot).
- **Hearts/XP:** Standard.
- **Accessibility:** Hotspots exposed as an accessibility list ("Strong safety, button"); tap targets expanded to at least 44 pt.
- **Metal:** Optional (procedural diagram rendering).

---

## Type-to-course guidance (starting point)

| Need | Preferred type |
|---|---|
| Terms & rules | multiple-choice, term-match, fill-the-gap |
| Process | sequence-order |
| Recognition | visual-id, listening-id, hotspot-tap |
| Judgment | decision-scenario |
| Conversation | talk-track, say-this |
| Timing / magnitude | timing-tap, estimate-slider |
| Yes/no situational rule | binary-call |

## Adding a new native type

1. Propose in a DECISIONS entry. 2. Add `<type>.schema.json` + example in `docs/contracts/native-exercises/v1/` and add the type to the enums in `course-manifest.schema.json` and `curriculum.schema.json`. 3. Add a section here. 4. Implement Core logic + tests, then the SwiftUI renderer.
