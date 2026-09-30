# Native Exercise Plan: Golf (`golf`)

Tier B plan for `docs/courses/golf/`. All 13 native exercise types are used; Tier A sims are in `sims/`. All sample payloads below validate against `docs/contracts/native-exercises/v1/*.schema.json` (checked with the repo's ajv setup when this file was written). Conventions: prompts <= 12 words; every answer explained; `license` ids are `original-swoond` (procedural or original recordings); no unlicensed marks or photos. Rules are paraphrased, never copied from the Rules of Golf (R&A and USGA). Time-sensitive items (tour formats, results, the next rules cycle) are tagged for the live layer rather than hard-coded in evergreen lessons.

## 1. Plan summary

| Type | How it is used in this course | Est. count at launch |
|---|---|---|
| `multiple-choice` | The default knowledge check and Daily Bite card: par and scoring, clubs, formats, majors and cups, handicaps. Distractors are the classic beginner errors from CDS section 2. | ~240 |
| `binary-call` | Yes/no rule calls on a hole diagram: relief allowed or not, penalty or no penalty, which stroke is next. `ruleTag` names the rule area ("Penalty area", "Play it as it lies"). Dynamic questions (shape, break) are Unity, not here. | ~60 |
| `term-match` | Introduce 3 to 6 terms of one topic (score names, shot shapes, formats, clubs) and Term Blitz reviews. | ~40 |
| `sequence-order` | Order of a round, the swing, handicap steps, tour pathways, relief steps. Order is the concept; per-step `why` carries the logic. | ~30 |
| `visual-id` | Recognising clubs, course types, putter styles, ball cutaways from original vector art (`original-swoond`). No photographs, no brand marks. | ~30 |
| `decision-scenario` | Judgment: short-sided pins, etiquette dilemmas, unsure rulings, club choice, weather and lightning safety, playing-partner situations. Facts table plus consequences; `expertNote` and `safetyNote` where relevant. | ~70 |
| `talk-track` | 18 tracks at launch (10 standalone, 8 unit-end beats), see sections 4 and 5. Smooth meter; replies reward curiosity over expertise. | 18 |
| `timing-tap` | Only 1D rhythm: swing tempo, the putting stroke, bunker splash rhythm. Anything scene-dependent (curve, roll, dispersion) is a Unity sim. | ~8 |
| `say-this` | Decode what she just said: round recaps, gear talk, leaderboard lines, match results, tour news. Every item has a `noFakeExpertNote`. | ~80 |
| `fill-the-gap` | Vocabulary in context and rule sentences: par names, penalties, match play, handicap steps. | ~50 |
| `listening-id` | A short original set: pure iron versus thin shot, putt in the cup versus a lip-out, sand splash versus a fat shot. Original or synthesised audio only; "Skip" always available. | ~10 |
| `estimate-slider` | Magnitudes: cup width, clubs allowed, round length, Stimp, maximum handicap, par lengths, typical carries. | ~25 |
| `hotspot-tap` | Static diagrams: hole anatomy, relief areas, the high side of a green, scorecard columns, safe side of a green. Anything that moves is Unity. | ~35 |

Estimated totals: about 680 native items across 116 lessons and the review loop (density about 5 to 8 per lesson including review pools). Cross-type rules: each lesson ends with one item that includes a "say this" line; each unit ends with a `talk-track` or `say-this` beat; Daily Bite draws from `multiple-choice`, `fill-the-gap` and `term-match`.

## 2. Sample items by type

Each sample has a planned lesson id. Payloads are the exact contract shape.

### 2.1 `multiple-choice`

**Sample 1** (lesson `game-03`)

```json
{"prompt":"What does par tell you about a hole?","options":[{"id":"a","text":"The score an expert is expected to make"},{"id":"b","text":"The number of players allowed on the hole"},{"id":"c","text":"The length of the fairway in yards"},{"id":"d","text":"The lowest score anyone has made there"}],"correctOptionIds":["a"],"explanation":{"correct":"Par is the benchmark: what a skilled golfer is expected to take, including two putts. It is tied to the hole's length.","incorrect":"Par is a benchmark for the hole, not a limit or a length. It is the score a skilled player is expected to make, two putts included.","sayThisLine":"Par is what you're supposed to make."}}
```

**Sample 2** (lesson `score-02`)

```json
{"prompt":"Two strokes under par on a hole is called what?","options":[{"id":"a","text":"Birdie"},{"id":"b","text":"Eagle"},{"id":"c","text":"Albatross"},{"id":"d","text":"Bogey"}],"correctOptionIds":["b"],"explanation":{"correct":"One under is a birdie, two under is an eagle, three under is an albatross. Bogey is one over par.","incorrect":"Eagle is two under par. Birdie is one under, albatross is three under and bogey is one over.","sayThisLine":"She eagled the par 5 on Sunday."}}
```

**Sample 3** (lesson `rule-02`)

```json
{"prompt":"You think your tee shot may be lost. What can you play?","options":[{"id":"a","text":"A provisional ball, after announcing it"},{"id":"b","text":"A mulligan from the same spot, no penalty"},{"id":"c","text":"Nothing, wait for the group behind"},{"id":"d","text":"Any ball, dropped where you think it went"}],"correctOptionIds":["a"],"explanation":{"correct":"Announce and play a provisional ball from the tee. If the first ball is found in bounds, you play it and abandon the provisional.","incorrect":"The rules answer is a provisional ball. It saves a walk back to the tee if the first ball turns out to be lost or out of bounds. Mulligans are casual, not official.","sayThisLine":"I'll hit a provisional, just in case."}}
```

**Sample 4** (lesson `fmt-07`)

```json
{"prompt":"What does a higher slope rating tell you about a course?","options":[{"id":"a","text":"It is relatively harder for a bogey golfer"},{"id":"b","text":"It is longer from the back tees"},{"id":"c","text":"It has more water hazards"},{"id":"d","text":"It costs more to play"}],"correctOptionIds":["a"],"explanation":{"correct":"Slope compares how hard a course plays for a bogey golfer versus a scratch golfer. Higher slope means a bigger jump in difficulty for the average player.","incorrect":"Slope is about relative difficulty for a bogey golfer compared with a scratch golfer, not length, hazards or price. The neutral value is 113.","sayThisLine":"That course has a big slope, so my handicap goes up there."}}
```

### 2.2 `binary-call`

**Sample 1** (lesson `rule-03`)

```json
{"prompt":"Ball in a red-staked penalty area. Lateral relief allowed?","scene":{"kind":"field-diagram","diagramId":"golf-hole-penalty-area-red","markers":[{"role":"ball","x":0.36,"y":0.5},{"role":"player","x":0.2,"y":0.8},{"role":"target","x":0.85,"y":0.12}],"alt":"Top-down golf hole with a pond marked by red stakes beside the fairway. The ball lies in the pond near its edge; the green is far upper right."},"choices":[{"id":"yes","label":"Yes, lateral relief"},{"id":"no","label":"No, only back-and-drop"}],"correctChoiceId":"yes","explanation":{"correct":"Red penalty areas add lateral relief: drop within two club-lengths of where the ball crossed the edge, no nearer the hole, for one penalty stroke.","incorrect":"Red stakes allow lateral relief for one penalty stroke, within two club-lengths of where the ball crossed the edge and no nearer the hole. Yellow stakes do not.","sayThisLine":"Red stakes mean I can drop it to the side."},"ruleTag":"Penalty area"}
```

**Sample 2** (lesson `rule-05`)

```json
{"prompt":"A leaf lies next to your ball in a bunker. Remove it?","scene":{"kind":"field-diagram","diagramId":"golf-bunker-loose-leaf","markers":[{"role":"ball","x":0.5,"y":0.55},{"role":"player","x":0.5,"y":0.85}],"alt":"Close top-down view of a greenside bunker. A ball sits in the sand with a leaf beside it, and the player stands behind."},"choices":[{"id":"remove","label":"Yes, remove it"},{"id":"leave","label":"No, leave it"}],"correctChoiceId":"remove","explanation":{"correct":"Loose impediments such as leaves and twigs may be removed anywhere, including bunkers, since the 2019 rules, as long as the ball does not move.","incorrect":"You may remove loose impediments, even in a bunker, if your ball does not move. What you may not do is touch the sand with your club right before the stroke.","sayThisLine":"Loose leaves can come out, even in the sand."},"ruleTag":"Bunker rules"}
```

**Sample 3** (lesson `rule-01`)

```json
{"prompt":"Your ball sits in a fairway divot. What is the default?","scene":{"kind":"field-diagram","diagramId":"golf-fairway-divot","markers":[{"role":"ball","x":0.5,"y":0.6},{"role":"player","x":0.5,"y":0.9}],"alt":"Close top-down view of a fairway. A ball rests inside a small scuffed divot, and the player stands behind it."},"choices":[{"id":"as-it-lies","label":"Play it as it lies"},{"id":"move","label":"Move it to a clean lie"}],"correctChoiceId":"as-it-lies","explanation":{"correct":"Golf's central rule is to play the ball as it lies. A divot is part of the course, so you play it, unless a local rule gives relief.","incorrect":"You do not get free relief from a fairway divot under the standard rules. Play it as it lies unless the course posts a local rule.","sayThisLine":"Bad lie, play it as it lies."},"ruleTag":"Play it as it lies"}
```

**Sample 4** (lesson `rule-02`)

```json
{"prompt":"Your tee shot is out of bounds. Your next shot is number what?","scene":{"kind":"field-diagram","diagramId":"golf-hole-out-of-bounds","markers":[{"role":"player","x":0.2,"y":0.85},{"role":"ball","x":0.05,"y":0.4}],"alt":"Top-down hole with white stakes along the left side. The tee shot finishes beyond the white stakes in the out-of-bounds area."},"choices":[{"id":"two","label":"Your second shot"},{"id":"three","label":"Your third shot"}],"correctChoiceId":"three","explanation":{"correct":"Out of bounds costs stroke and distance: one penalty stroke and you replay from the tee. The first shot counts, the penalty adds one, so the next is your third.","incorrect":"Stroke and distance means one penalty stroke and replaying from the previous spot. Stroke one, penalty stroke two, so the replay is your third shot.","sayThisLine":"Out of bounds: I'm hitting three off the tee."},"ruleTag":"Out of bounds"}
```

### 2.3 `term-match`

**Sample 1** (lesson `score-02`)

```json
{"prompt":"Match the score name to what it means.","pairs":[{"id":"birdie","term":"Birdie","definition":"One stroke under par on a hole"},{"id":"eagle","term":"Eagle","definition":"Two strokes under par on a hole"},{"id":"bogey","term":"Bogey","definition":"One stroke over par on a hole"},{"id":"double","term":"Double bogey","definition":"Two strokes over par on a hole"}],"explanation":{"summary":"Under par is a bird name and over par is a bogey. Every one is measured against the hole's par, not against your last hole.","sayThisLine":"I made bogey, then a birdie on the next."}}
```

**Sample 2** (lesson `club-05`)

```json
{"prompt":"Match each shot shape to its description.","pairs":[{"id":"draw","term":"Draw","definition":"Gentle curve from right to left for a right-hander"},{"id":"fade","term":"Fade","definition":"Gentle curve from left to right for a right-hander"},{"id":"slice","term":"Slice","definition":"Big curve to the right for a right-hander"},{"id":"hook","term":"Hook","definition":"Big curve to the left for a right-hander"}],"distractorDefinitions":["A shot that flies very high and lands softly"],"explanation":{"summary":"Small curves are chosen: draw and fade. Big curves are usually accidents: slice and hook. Left-handers mirror the directions.","sayThisLine":"I'm fighting a slice today."}}
```

**Sample 3** (lesson `fmt-04`)

```json
{"prompt":"Match the team format to how it is played.","pairs":[{"id":"scramble","term":"Scramble","definition":"Everyone hits, the team picks the best ball, all play from there"},{"id":"fourball","term":"Four-ball","definition":"Each player plays their own ball; the better score counts"},{"id":"foursomes","term":"Foursomes","definition":"Partners alternate shots with a single ball"},{"id":"skins","term":"Skins","definition":"Each hole is a prize won outright, or it carries over"}],"explanation":{"summary":"Scramble is one team ball, four-ball is two balls per side with the best counting, foursomes is alternate shot, skins is hole by hole.","sayThisLine":"We're playing four-ball, so just play your own ball."}}
```

**Sample 4** (lesson `club-01`)

```json
{"prompt":"Match each club to what it is mostly used for.","pairs":[{"id":"driver","term":"Driver","definition":"Longest club, used off the tee on longer holes"},{"id":"iron","term":"Iron","definition":"Numbered clubs for approach shots to the green"},{"id":"wedge","term":"Wedge","definition":"High-lofted club for short shots and sand"},{"id":"putter","term":"Putter","definition":"Rolls the ball along the green toward the hole"},{"id":"hybrid","term":"Hybrid","definition":"Forgiving cross between a wood and an iron"}],"explanation":{"summary":"You carry up to fourteen clubs. Longer clubs go further, higher-lofted clubs go higher and shorter, and the putter is for the green.","sayThisLine":"I hit a hybrid instead of a long iron."}}
```

### 2.4 `sequence-order`

**Sample 1** (lesson `game-06`)

```json
{"prompt":"Put the start of a round in order.","items":[{"id":"checkin","text":"Check in at the pro shop","why":"Pay, get a cart if you want one, and confirm your tee time."},{"id":"warmup","text":"Warm up on the range and putting green","why":"Loosen up and feel the greens before you start."},{"id":"tee","text":"Tee off on the first hole","why":"The round officially starts when you play from the first tee."},{"id":"turn","text":"Play the front nine and make the turn","why":"Nine holes, then the turn, often with a quick snack."},{"id":"card","text":"Sign and return the scorecard","why":"The scorecard is signed at the end and handed in."}],"explanation":{"correct":"Check in, warm up, tee off, play through the turn, then sign the card. Casual rounds skip the range, but the order holds.","incorrect":"The order follows the day: arrive and check in, warm up, tee off, play nine and turn, then sign the card at the end.","sayThisLine":"We warmed up, teed off, made the turn and had a hot dog."}}
```

**Sample 2** (lesson `club-04`)

```json
{"prompt":"Put the phases of a golf swing in order.","items":[{"id":"address","text":"Address (set up over the ball)","why":"Grip, stance and alignment come first."},{"id":"backswing","text":"Backswing","why":"The club goes back and up, storing energy."},{"id":"transition","text":"Transition at the top","why":"The change of direction from backswing to downswing."},{"id":"impact","text":"Downswing and impact","why":"The club meets the ball; face and path are set here."},{"id":"finish","text":"Follow-through and finish","why":"A balanced finish shows the swing stayed under control."}],"explanation":{"correct":"Address, backswing, transition, downswing and impact, then the follow-through. Impact is one instant inside the downswing.","incorrect":"The swing runs from setup to finish: address, backswing, transition, downswing and impact, then follow-through.","sayThisLine":"My tempo falls apart at the top."}}
```

**Sample 3** (lesson `fmt-06`)

```json
{"prompt":"Order how a Handicap Index gets updated.","items":[{"id":"play","text":"Play a round and record every hole score","why":"You need the gross scores for the round."},{"id":"post","text":"Post the score to your handicap system","why":"A score must be posted to count."},{"id":"diff","text":"The system turns it into a score differential","why":"The differential adjusts for course rating and slope."},{"id":"best","text":"It averages the best 8 of your latest 20 differentials","why":"Using the best eight reflects potential, not your worst days."},{"id":"index","text":"Your Handicap Index updates","why":"The new index is what you carry to the next course."}],"explanation":{"correct":"Play, post, convert to a differential, average the best 8 of your latest 20, and the index updates.","incorrect":"The handicap flows: round, posted score, differential, best 8 of the last 20, updated index.","sayThisLine":"I posted my score, and my index dropped a point."}}
```

**Sample 4** (lesson `short-03`)

```json
{"prompt":"Order a sensible putting routine.","items":[{"id":"read","text":"Read the slope from behind the ball"},{"id":"aim","text":"Choose an aim point on the high side"},{"id":"speed","text":"Decide on your pace"},{"id":"rehearse","text":"Take a practice stroke at that pace"},{"id":"putt","text":"Set up and putt"}],"explanation":{"correct":"Read, choose the aim point, feel the pace, rehearse, then putt. A routine keeps the decision before the stroke.","incorrect":"Good putters decide first, then stroke: read the slope, pick an aim point, choose the pace, rehearse, then set up and putt.","sayThisLine":"I read it, picked a spot and just rolled it."}}
```

### 2.5 `visual-id`

**Sample 1** (lesson `club-01`)

```json
{"prompt":"Which club family is this silhouette?","image":{"asset":"images/golf/club-hybrid-silhouette.svg","alt":"Side view of a golf club with a compact rounded head, larger than an iron head, on a slim shaft.","license":"original-swoond"},"options":[{"id":"a","text":"Hybrid"},{"id":"b","text":"Driver"},{"id":"c","text":"Wedge"},{"id":"d","text":"Putter"}],"correctOptionId":"a","explanation":{"correct":"A hybrid has a compact rounded head that looks like a small wood, built to replace a hard-to-hit long iron.","incorrect":"The rounded, compact head between a wood and an iron is the hybrid. A driver's head is much larger; a wedge is angled and flat-faced.","sayThisLine":"I swapped my 4-iron for a hybrid."},"cues":["Compact rounded head","Shorter than a fairway wood","Replaces long irons"]}
```

**Sample 2** (lesson `cond-01`)

```json
{"prompt":"What type of course does this schematic show?","image":{"asset":"images/golf/course-links-schematic.svg","alt":"Top-down schematic of a coastal course with no trees, rolling dunes, small round pot bunkers and firm brown fairways beside the sea.","license":"original-swoond"},"options":[{"id":"a","text":"Links"},{"id":"b","text":"Parkland"},{"id":"c","text":"Desert"},{"id":"d","text":"Heathland"}],"correctOptionId":"a","explanation":{"correct":"Treeless, dune-lined, coastal and firm with small deep pot bunkers: that is links golf, the original style, played in Scotland and Ireland.","incorrect":"A treeless coastal course with dunes and pot bunkers is a links. Parkland has trees, desert has sand and cactus, heathland has heather and gorse.","sayThisLine":"I'd love to play a real links someday."},"cues":["No trees","Dunes","Pot bunkers","Firm ground"]}
```

**Sample 3** (lesson `gear-05`)

```json
{"prompt":"Which putter style is this?","image":{"asset":"images/golf/putter-mallet-silhouette.svg","alt":"Top view of a putter with a wide, deep head extending well behind the face, with two alignment lines painted on top.","license":"original-swoond"},"options":[{"id":"a","text":"Blade"},{"id":"b","text":"Mallet"},{"id":"c","text":"Wedge-style chipper"}],"correctOptionId":"b","explanation":{"correct":"A mallet has a big, deep head with more weight around the edges for stability, and alignment lines to help aim.","incorrect":"The wide, deep head is a mallet. A blade is thin and compact with a single line.","sayThisLine":"I switched to a mallet; it keeps the face steady."},"cues":["Wide deep head","Alignment lines","Extra stability"]}
```

### 2.6 `decision-scenario`

**Sample 1** (lesson `mgmt-04`)

```json
{"prompt":"The flag is tucked by the bunker. Where do you aim?","situation":{"narrative":"A 150-yard approach, and the pin is close to the right edge.","facts":[{"label":"Pin position","value":"5 yards from the right edge"},{"label":"Trouble","value":"Bunker right, water long","emphasis":"warning"},{"label":"Green shape","value":"Wide, sloping left to right"},{"label":"Your typical miss","value":"A little right"},{"label":"Your handicap","value":"About 15"}]},"options":[{"id":"flag","label":"Straight at the flag","verdict":"poor","consequence":"A normal miss finds the bunker or worse. Short-sided, the up-and-down is tough.","considerations":["Your miss leans right","No room on that side"]},{"id":"middle","label":"The middle of the green","verdict":"best","consequence":"You have a long putt, but a miss is still on the green or in a fine spot.","considerations":["Two putts is a good result","Keeps the bunker out of play"]},{"id":"left","label":"Well left of the green","verdict":"acceptable","consequence":"Safe from the bunker but leaves a tricky chip back over the slope.","considerations":["Safe but wasteful","Not needed when the middle is available"]}],"expertNote":"Good players aim at the fat part of the green when the flag is tucked. A fifteen-foot putt beats a bunker shot every time.","sayThisLine":"I'm not going after that flag; middle of the green is fine."}
```

**Sample 2** (lesson `rule-06`)

```json
{"prompt":"A faster group is right behind you. What now?","situation":{"narrative":"You are playing a relaxed round and the group behind is waiting on every shot.","facts":[{"label":"Your pace","value":"About 4 hours 30 minutes"},{"label":"Group behind","value":"Waiting on every tee"},{"label":"Open hole ahead","value":"Yes, a full hole gap","emphasis":"warning"},{"label":"Course rule","value":"Pace of play posted at the first tee"}]},"options":[{"id":"ignore","label":"Keep going and ignore them","verdict":"poor","consequence":"The group behind gets frustrated and the whole course backs up.","considerations":["Rounds that back up hurt everyone","A gap ahead means you are the problem"]},{"id":"through","label":"Wave them through when convenient","verdict":"best","consequence":"They pass smoothly, thank you, and you relax and enjoy your round.","considerations":["Let faster groups play through","Do it at a tee or a safe spot"]},{"id":"rush","label":"Speed up and skip the rest of your routine","verdict":"acceptable","consequence":"It helps a little, but rushing makes shots worse and still leaves the group behind you.","considerations":["Ready golf helps","Rushing can lead to errors"]}],"expertNote":"Letting a faster group play through is good manners, not an insult. Everyone plays better with space around them.","sayThisLine":"Go ahead and play through, we're taking our time."}
```

**Sample 3** (lesson `rule-07`)

```json
{"prompt":"You are unsure of a ruling in stroke play. What do you do?","situation":{"narrative":"Your ball is near a drainage cover and you are not sure if you get relief. No official is nearby.","facts":[{"label":"Format","value":"Stroke play, counting"},{"label":"Official nearby","value":"No"},{"label":"Your partners","value":"Also unsure"},{"label":"Stakes","value":"Club championship round"}]},"options":[{"id":"guess","label":"Guess and play on, sign the card","verdict":"poor","consequence":"A wrong guess can mean a penalty or disqualification for a wrong score.","considerations":["A wrong ruling can bring penalties","You are responsible for your card"]},{"id":"two","label":"Play two balls and report to the committee","verdict":"best","consequence":"Stroke play allows two balls when unsure. The committee decides which counts afterward.","considerations":["Announce which ball you will count","Report the situation before signing your card"]},{"id":"partners","label":"Take the group's best guess","verdict":"acceptable","consequence":"It might be right, but friends can be wrong too.","considerations":["Better than a solo guess","Not the same as checking"]}],"expertNote":"When you honestly do not know, the rules allow you to play two balls in stroke play and let the committee sort it out. Asking beats guessing.","sayThisLine":"I'm not sure, so I'll play two balls and check afterward."}
```

**Sample 4** (lesson `cond-05`)

```json
{"prompt":"Thunder rumbles and the course horn sounds. What now?","situation":{"narrative":"You are on the 14th fairway when the course sounds its horn.","facts":[{"label":"Sound","value":"Thunder in the distance","emphasis":"warning"},{"label":"Course signal","value":"Horn: suspend play","emphasis":"warning"},{"label":"Nearest shelter","value":"Clubhouse, half a mile"},{"label":"Nearest trees","value":"A big oak, 40 yards away"}]},"options":[{"id":"finish","label":"Finish the hole first","verdict":"poor","consequence":"Lightning can strike miles ahead of a storm. Finishing is not worth the risk.","considerations":["Stop when the horn sounds","Lightning does not wait for a putt"]},{"id":"tree","label":"Shelter under the big oak","verdict":"poor","consequence":"Tall isolated trees attract lightning and are among the most dangerous places to stand.","considerations":["Trees are not shelter","Do not stand near tall objects"]},{"id":"leave","label":"Leave the course now for a safe building or vehicle","verdict":"best","consequence":"You follow the course's procedure and get to a safe place quickly.","considerations":["Follow the course's own procedure","Take cart or walk directly to shelter"]}],"expertNote":"When the horn sounds, play stops. Leave the course and follow the club's procedure; do not wait for the next hole and do not shelter under trees.","safetyNote":"This is a learning scenario, not lightning safety training; follow your course's official procedure."}
```

### 2.7 `talk-track`

Full launch tracks are in section 4; these three short samples show the payload shape for other lessons.

**Sample 1** (lesson `talk-01`)

```json
{"title":"She broke 90","setting":"She texts after her round on Saturday.","startingSmooth":50,"exchanges":[{"theirMessage":"I finally broke 90!! 88. I've been chasing that all summer.","replies":[{"id":"a","text":"That's huge. What finally clicked?","smoothDelta":25,"theirResponse":"Honestly, the short game. I stopped chunking my chips.","coachNote":"Celebrates and asks for the story. Curiosity beats stats."},{"id":"b","text":"Nice. Is 88 good?","smoothDelta":0,"theirResponse":"For me it is! Par is 72 though, so we'll see.","coachNote":"Honest, but it slightly shrinks her moment. Celebrate first."},{"id":"c","text":"Cool. You should aim for scratch next.","smoothDelta":-15,"theirResponse":"Ha. Sure. Let me enjoy this one.","coachNote":"Moving the goalposts. Let her enjoy the milestone."}]}],"closingNote":"Breaking 90 means finishing 18 holes in fewer than 90 strokes. For many golfers it is a real milestone."}
```

**Sample 2** (lesson `talk-04`)

```json
{"title":"The new driver","setting":"She shows you a new driver at the range.","startingSmooth":50,"exchanges":[{"theirMessage":"Got fitted for a new driver. Lower loft, stiffer shaft. My slice might finally be over.","replies":[{"id":"a","text":"What did the fitter see in your swing?","smoothDelta":25,"theirResponse":"My ball speed was fine, but my spin was way too high.","coachNote":"Asks about the why. Fitting is about data and feel."},{"id":"b","text":"Nice. What does it cost?","smoothDelta":-5,"theirResponse":"Too much. Let's not talk about it.","coachNote":"Price is a fair curiosity, but not the first question."},{"id":"c","text":"Buying a driver fixes a slice? Amazing.","smoothDelta":-15,"theirResponse":"...It helps. Technique still matters.","coachNote":"Sounds dismissive. A fitting helps; it does not magically fix a swing."}]}],"closingNote":"Loft, shaft flex and lie are the main fitting variables. A fitting matches gear to the swing; it does not replace it."}
```

**Sample 3** (lesson `talk-06`)

```json
{"title":"Major Sunday","setting":"You watch the last round of a major together.","startingSmooth":50,"exchanges":[{"theirMessage":"He's two back thru 14, and the par 5s are still coming. This isn't over.","replies":[{"id":"a","text":"So he needs a birdie on 15 or 16?","smoothDelta":25,"theirResponse":"Exactly. Two par 5s left, and that's where you make a move.","coachNote":"Reads the leaderboard language and asks a simple follow-up."},{"id":"b","text":"What does thru 14 mean?","smoothDelta":10,"theirResponse":"He's played 14 of 18 holes. Four to go.","coachNote":"An honest question is fine. Better to ask once than to fake it."},{"id":"c","text":"He should just hit it closer.","smoothDelta":-20,"theirResponse":"Sure. Genius.","coachNote":"A joke that sounds like you don't get the game."}]}],"closingNote":"Thru 14 means 14 holes played. A par 5 is the best birdie chance on many courses."}
```

### 2.8 `timing-tap`

**Sample 1** (lesson `club-04`)

```json
{"prompt":"Tap when the marker reaches the top of the swing.","theme":{"label":"Swing tempo","resultUnit":"points"},"rounds":[{"zoneStartPct":60,"zoneEndPct":76,"sweepSeconds":1.8},{"zoneStartPct":64,"zoneEndPct":76,"sweepSeconds":1.5},{"zoneStartPct":68,"zoneEndPct":78,"sweepSeconds":1.3}],"explanation":{"correct":"Good tempo is a smooth backswing about three times as long as the downswing, with a pause of no hurry at the top.","incorrect":"Rushing the transition is the classic error. Tempo is smooth: a longer backswing, then an unhurried change of direction.","sayThisLine":"My tempo goes when I rush the top."},"accessibilityAlternative":"tap-to-stop-slow"}
```

**Sample 2** (lesson `short-02`)

```json
{"prompt":"Tap at the end of a smooth putting stroke.","theme":{"label":"Putting rhythm","resultUnit":"points"},"rounds":[{"zoneStartPct":45,"zoneEndPct":62,"sweepSeconds":2.0},{"zoneStartPct":50,"zoneEndPct":62,"sweepSeconds":1.7}],"explanation":{"correct":"Putting is about a steady rhythm, the same tempo back and through, and letting the length of the stroke set the pace.","incorrect":"Jabbing at a putt is common under pressure. Keep the tempo the same and let the length of the stroke set the distance.","sayThisLine":"I just tried to keep the same rhythm."}}
```

**Sample 3** (lesson `short-06`)

```json
{"prompt":"Tap when the club enters the sand behind the ball.","theme":{"label":"Bunker splash","resultUnit":"points"},"rounds":[{"zoneStartPct":55,"zoneEndPct":70,"sweepSeconds":1.6},{"zoneStartPct":58,"zoneEndPct":68,"sweepSeconds":1.4},{"zoneStartPct":60,"zoneEndPct":68,"sweepSeconds":1.2}],"explanation":{"correct":"In a splash shot the club enters the sand behind the ball, and the sand carries the ball out. The ball is never hit directly.","incorrect":"Hitting the ball first sends it too far or thin. Enter the sand a couple of inches behind the ball and let the sand lift it.","sayThisLine":"Hit the sand, not the ball."}}
```

### 2.9 `say-this`

**Sample 1** (lesson `talk-01`)

```json
{"statement":{"speaker":"Maya","text":"I three-jacked four times today and lipped out two more. My putter hates me."},"question":"What is she talking about?","options":[{"id":"a","text":"She took three putts on four different greens","isCorrect":true},{"id":"b","text":"Two putts caught the edge of the cup and stayed out","isCorrect":true},{"id":"c","text":"She lost four golf balls","isCorrect":false},{"id":"d","text":"Her putter broke twice","isCorrect":false}],"translation":"On four greens she needed three putts, and two more putts touched the rim of the hole without dropping. A frustrating day of putting.","followUps":[{"line":"Were the three-putts from long range or short ones?","why":"Shows you know three-putts come from poor pace or missed short putts."},{"line":"That lip-out on 12 sounds painful.","why":"Uses her word and shows sympathy without pretending expertise."}],"noFakeExpertNote":"You don't need to fix her stroke. Ask what happened and listen."}
```

**Sample 2** (lesson `live-02`)

```json
{"statement":{"speaker":"Sam","text":"He's four back but only thru 12, and the par 5s are all on the back nine."},"question":"What is he saying?","options":[{"id":"a","text":"The player trails by four strokes","isCorrect":true},{"id":"b","text":"The player has played 12 holes so far","isCorrect":true},{"id":"c","text":"He still has good birdie chances ahead","isCorrect":true},{"id":"d","text":"The player is four holes ahead","isCorrect":false}],"translation":"The player is four strokes behind the leader, has six holes left, and the par 5s (easier for birdies) are still to come, so he can still win.","followUps":[{"line":"Which of the par 5s is the easiest?","why":"Shows you understand par 5s are birdie holes."},{"line":"How many strokes back is the leader?","why":"A simple honest question that keeps the conversation going."}],"noFakeExpertNote":"It's fine to ask what 'thru 12' means. Nobody minds an honest question."}
```

**Sample 3** (lesson `fmt-02`)

```json
{"statement":{"speaker":"Jordan","text":"We got 3 and 2'd in fourballs, but we'd have won it if my partner made that putt on 15."},"question":"What happened?","options":[{"id":"a","text":"They lost the match with two holes left","isCorrect":true},{"id":"b","text":"They were three holes behind when it ended","isCorrect":true},{"id":"c","text":"They lost by three strokes total","isCorrect":false},{"id":"d","text":"They lost by two holes on the last green","isCorrect":false}],"translation":"Their opponents were three holes up with only two to play, so the match ended early. Fourball means each player plays their own ball and the better score on each hole counts.","followUps":[{"line":"Was it close until the 15th?","why":"Shows you understand a match is decided hole by hole."},{"line":"Who was the other side, a couple you know?","why":"Curious, low-stakes, and about the people."}],"noFakeExpertNote":"Match play scores are just holes up or down. Ask her to explain the ending."}
```

**Sample 4** (lesson `talk-04`)

```json
{"statement":{"speaker":"Riley","text":"I put in a 56 with more bounce and the sand shots have been so much easier."},"question":"What did she change?","options":[{"id":"a","text":"Her sand wedge","isCorrect":true},{"id":"b","text":"A wedge with 56 degrees of loft","isCorrect":true},{"id":"c","text":"A wedge with a sole that helps it glide through sand","isCorrect":true},{"id":"d","text":"Her driver","isCorrect":false}],"translation":"She has a wedge with 56 degrees of loft and more bounce, the angled sole that helps the club glide through the sand instead of digging, which makes bunker shots easier.","followUps":[{"line":"Is the sand soft or firm where you play?","why":"Bounce matters more for soft sand, so this is a smart question."},{"line":"Did it change your distance gap to the pitching wedge?","why":"Shows you know wedges are chosen to fill distance gaps."}],"noFakeExpertNote":"You don't need to know grinds. Ask what feels different."}
```

### 2.10 `fill-the-gap`

**Sample 1** (lesson `score-02`)

```json
{"prompt":"Complete the sentence about aces.","template":"A hole in one on a par {{par}} is an {{name}}.","gaps":[{"id":"par","options":["3","4","5"],"correct":"3"},{"id":"name","options":["eagle","albatross","birdie"],"correct":"eagle"}],"explanation":{"correct":"An ace on a par 3 is two under par, an eagle. On a par 4 it would be an albatross, and on a par 5 a condor.","incorrect":"Count under par: one shot on a par 3 is two under, which is an eagle. Longer holes make the same ace a rarer score.","sayThisLine":"Her ace on the par 3 was an eagle."}}
```

**Sample 2** (lesson `fmt-01`)

```json
{"prompt":"Complete the sentence about match play.","template":"In match play you win a {{unit}} by taking fewer strokes on it, and the match goes to whoever wins more {{unit2}}.","gaps":[{"id":"unit","options":["hole","round","shot"],"correct":"hole"},{"id":"unit2","options":["holes","strokes","rounds"],"correct":"holes"}],"explanation":{"correct":"Match play is hole by hole: whoever takes fewer strokes wins that hole, and whoever wins more holes wins the match. Total strokes do not matter.","incorrect":"In match play the hole is the unit. Win more holes than your opponent and you win the match, however many total strokes you took."}}
```

**Sample 3** (lesson `rule-02`)

```json
{"prompt":"Complete the out-of-bounds rule.","template":"Out of bounds costs {{penalty}} penalty stroke and you play again from {{where}}.","gaps":[{"id":"penalty","options":["one","two","no"],"correct":"one"},{"id":"where","options":["the previous spot","the fairway","the green"],"correct":"the previous spot"}],"explanation":{"correct":"Stroke and distance: one penalty stroke, and you replay from where you last played. Some courses offer a local rule with a faster option.","incorrect":"It is one penalty stroke and a replay from the previous spot, called stroke and distance. Ask the pro shop about local alternatives for casual rounds.","sayThisLine":"OB, so stroke and distance."}}
```

**Sample 4** (lesson `fmt-08`)

```json
{"prompt":"Complete the handicap sentence.","template":"A net score is your {{gross}} score minus your {{hcp}}.","gaps":[{"id":"gross","options":["gross","best","par"],"correct":"gross"},{"id":"hcp","options":["course handicap","slope","handicap max"],"correct":"course handicap"}],"explanation":{"correct":"Net score equals the gross score you actually took minus your course handicap. It lets golfers of different skill compete fairly.","incorrect":"Take the gross score (what you actually shot) and subtract your course handicap. That is your net score for the round.","sayThisLine":"I shot 95, but with my handicap that's a net 80."}}
```

### 2.11 `listening-id`

**Sample 1** (lesson `club-06`)

```json
{"prompt":"Which strike does this sound like?","audio":{"asset":"audio/golf/iron-strike-pure.m4a","durationMs":2500,"license":"original-swoond","description":"A crisp, compressed click with a short, clean thump, like a ball squeezed against the ground.","maxPlays":3},"options":[{"id":"a","text":"Pure iron strike"},{"id":"b","text":"Thin shot (hit near the equator)"},{"id":"c","text":"Fat shot (turf first)"}],"correctOptionId":"a","explanation":{"correct":"A pure iron sounds crisp and solid. The club compresses the ball against the turf and takes a small divot after the ball.","incorrect":"A pure strike is a clean click. A thin shot is a hard, high-pitched ting; a fat shot is a dull thud."},"listenFor":["Crisp click","Short thump","No ringing"]}
```

**Sample 2** (lesson `short-02`)

```json
{"prompt":"Did the putt drop or lip out?","audio":{"asset":"audio/golf/putt-in-cup.m4a","durationMs":3000,"license":"original-swoond","description":"A soft roll ending in a distinct rattle as a ball drops to the bottom of a cup.","maxPlays":3},"options":[{"id":"a","text":"Dropped in the cup"},{"id":"b","text":"Lipped out"},{"id":"c","text":"Stopped short"}],"correctOptionId":"a","explanation":{"correct":"The soft roll ending in a low rattle is the ball dropping and hitting the bottom of the cup. Golfers love that sound.","incorrect":"A drop ends with a rattle inside the cup. A lip-out is a soft tick at the rim followed by silence; a short putt just rolls out."},"listenFor":["Low rattle","Drop into the cup","No further roll"]}
```

**Sample 3** (lesson `short-06`)

```json
{"prompt":"Which sand shot does this sound like?","audio":{"asset":"audio/golf/bunker-splash.m4a","durationMs":2500,"license":"original-swoond","description":"A soft, muffled whoosh of sand thrown up, with no sharp click of a ball being struck.","maxPlays":3},"options":[{"id":"a","text":"A clean splash (sand first)"},{"id":"b","text":"A thin blade across the ball"},{"id":"c","text":"A skulled shot over the green"}],"correctOptionId":"a","explanation":{"correct":"A soft whoosh with no sharp click means the club went through the sand and threw the ball out on a cushion. That is a good bunker shot.","incorrect":"A sharp click means the club hit the ball itself, which in a bunker usually sends it flying. The soft whoosh is the good sound."},"listenFor":["Soft whoosh","No sharp click","Sand spray"]}
```

### 2.12 `estimate-slider`

**Sample 1** (lesson `game-02`)

```json
{"prompt":"How wide is the hole (the cup)?","unit":"inches","min":2,"max":8,"step":0.25,"correctValue":4.25,"tolerance":{"full":0.25,"partial":1},"explanation":{"correct":"The cup is 4.25 inches across, only a little bigger than a golf ball. That is why putts are so hard.","incorrect":"The cup is 4.25 inches wide, about two and a half times the width of the ball.","sayThisLine":"The hole is only 4.25 inches wide."}}
```

**Sample 2** (lesson `club-01`)

```json
{"prompt":"How many clubs may you carry in a round?","unit":"clubs","min":8,"max":20,"step":1,"correctValue":14,"tolerance":{"full":0,"partial":2},"explanation":{"correct":"Fourteen clubs is the limit. Going over gives a penalty of two strokes per hole, up to four in stroke play.","incorrect":"The limit is fourteen clubs. Most golfers carry about that many: a driver, woods or hybrids, irons, wedges and a putter.","sayThisLine":"You can carry at most fourteen clubs."}}
```

**Sample 3** (lesson `cond-03`)

```json
{"prompt":"A Stimp of 10: how far does the ball roll?","unit":"feet","min":4,"max":16,"step":1,"correctValue":10,"tolerance":{"full":0,"partial":2},"explanation":{"correct":"The Stimpmeter releases a ball down a ramp, and the distance it rolls on a flat green, in feet, is the Stimp. So a 10 rolls about ten feet.","incorrect":"The Stimp number is simply how many feet the ball rolls after leaving the ramp. Higher means faster greens, which break more.","sayThisLine":"The greens are running at about a 10 today."}}
```

**Sample 4** (lesson `fmt-06`)

```json
{"prompt":"What is the highest Handicap Index in the system?","unit":"strokes","min":20,"max":60,"step":1,"correctValue":54,"tolerance":{"full":0,"partial":5},"explanation":{"correct":"The World Handicap System caps the Handicap Index at 54.0, so almost anyone can get a handicap and play in fair competition.","incorrect":"The maximum Handicap Index is 54.0. It lets beginners join events and compete fairly with better players.","sayThisLine":"You can get a handicap even as a beginner."}}
```

### 2.13 `hotspot-tap`

**Sample 1** (lesson `game-02`)

```json
{"prompt":"Tap the putting green.","diagram":{"diagramId":"golf-hole-anatomy","aspectRatio":0.75,"alt":"Top-down par-4 hole. A tee box at the bottom, a long fairway with rough on both sides, a bunker on the left, a pond on the right, and a round green with a flag at the top."},"hotspots":[{"id":"tee","label":"Tee box","shape":{"kind":"rect","x":0.38,"y":0.85,"w":0.24,"h":0.1}},{"id":"fairway","label":"Fairway","shape":{"kind":"rect","x":0.34,"y":0.3,"w":0.32,"h":0.5}},{"id":"bunker","label":"Bunker","shape":{"kind":"circle","cx":0.24,"cy":0.2,"r":0.07}},{"id":"pond","label":"Pond","shape":{"kind":"circle","cx":0.78,"cy":0.55,"r":0.1}},{"id":"green","label":"Green","shape":{"kind":"circle","cx":0.5,"cy":0.1,"r":0.09}}],"correctHotspotIds":["green"],"explanation":{"correct":"The green is the short, smooth grass around the hole where you putt, at the top of the diagram with the flag.","incorrect":"The green is the smooth, round putting surface around the flag. The fairway is the longer mown lane, and the bunker and pond are hazards.","sayThisLine":"I hit the green in regulation."}}
```

**Sample 2** (lesson `rule-03`)

```json
{"prompt":"Ball crossed the red stakes here. Tap a legal lateral drop area.","diagram":{"diagramId":"golf-relief-red-lateral","aspectRatio":1,"alt":"Top-down pond edge with red stakes and a marked entry point. Four areas: beside the entry point within two club-lengths, closer to the flag across the water, behind the pond on the line, and far back on the fairway."},"hotspots":[{"id":"side","label":"Beside the entry point, within two club-lengths","shape":{"kind":"circle","cx":0.3,"cy":0.55,"r":0.08}},{"id":"closer","label":"Closer to the flag across the water","shape":{"kind":"circle","cx":0.7,"cy":0.2,"r":0.08}},{"id":"behind","label":"Behind the pond on the line","shape":{"kind":"circle","cx":0.5,"cy":0.85,"r":0.08}},{"id":"far","label":"Far back on the fairway","shape":{"kind":"circle","cx":0.15,"cy":0.9,"r":0.07}}],"correctHotspotIds":["side"],"explanation":{"correct":"Lateral relief is within two club-lengths of where the ball crossed the edge, and never nearer the hole. That is the area beside the entry point.","incorrect":"Relief must be within two club-lengths of the crossing point and no nearer the hole. Closer to the flag is not allowed, and far back is not within two club-lengths.","sayThisLine":"I dropped within two club-lengths, no closer to the hole."}}
```

**Sample 3** (lesson `short-03`)

```json
{"prompt":"This putt falls left. Tap the high side to aim.","diagram":{"diagramId":"golf-green-cross-slope","aspectRatio":1,"alt":"Top-down green with the ball at the bottom, the hole near the top, and gentle contour lines showing the surface falling from the right side down to the left."},"hotspots":[{"id":"high","label":"High side, right of the hole","shape":{"kind":"circle","cx":0.62,"cy":0.25,"r":0.09}},{"id":"low","label":"Low side, left of the hole","shape":{"kind":"circle","cx":0.36,"cy":0.25,"r":0.09}},{"id":"cup","label":"Straight at the hole","shape":{"kind":"circle","cx":0.5,"cy":0.2,"r":0.05}}],"correctHotspotIds":["high"],"explanation":{"correct":"Water runs downhill, so a putt on a left-falling slope drifts left. Start it on the high side, to the right, and let the slope bring it back.","incorrect":"On a green that falls left the ball drifts left, so aiming at the hole or left of it misses low. Aim on the high side, right of the hole.","sayThisLine":"Play it out to the high side and let it feed in."}}
```

**Sample 4** (lesson `score-04`)

```json
{"prompt":"Tap the column that tells you the hardest holes.","diagram":{"diagramId":"golf-scorecard-columns","aspectRatio":1.6,"alt":"A scorecard with rows for holes one to nine and columns labelled Hole, Yards, Par, and Handicap or Stroke Index."},"hotspots":[{"id":"hole","label":"Hole","shape":{"kind":"rect","x":0.04,"y":0.1,"w":0.14,"h":0.8}},{"id":"yards","label":"Yards","shape":{"kind":"rect","x":0.22,"y":0.1,"w":0.2,"h":0.8}},{"id":"par","label":"Par","shape":{"kind":"rect","x":0.46,"y":0.1,"w":0.14,"h":0.8}},{"id":"si","label":"Handicap (stroke index)","shape":{"kind":"rect","x":0.64,"y":0.1,"w":0.3,"h":0.8}}],"correctHotspotIds":["si"],"explanation":{"correct":"The handicap or stroke index column ranks holes by difficulty; 1 is the hardest. It also tells you where handicap strokes are given.","incorrect":"Yards is length and par is the expected score. The handicap (stroke index) column ranks the holes from hardest (1) to easiest.","sayThisLine":"I get a stroke on the hardest hole, number 1."}}
```
