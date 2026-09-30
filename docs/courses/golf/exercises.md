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
{"prompt":"The flag is tucked by the bunker. Where do you aim?","situation":{"narrative":"A 150-yard approach, and the pin is close to the right edge.","facts":[{"label":"Pin position","value":"5 yards from the right edge"},{"label":"Trouble","value":"Bunker right, water long","emphasis":"warning"},{"label":"Green shape","value":"Wide, sloping left to right"},{"label":"Your typical miss","value":"A little right"},{"label":"Your handicap","value":"About 15"}],"narrative":"A 150-yard approach, and the pin is close to the right edge."},"options":[{"id":"flag","label":"Straight at the flag","verdict":"poor","consequence":"A normal miss finds the bunker or worse. Short-sided, the up-and-down is tough.","considerations":["Your miss leans right","No room on that side"]},{"id":"middle","label":"The middle of the green","verdict":"best","consequence":"You have a long putt, but a miss is still on the green or in a fine spot.","considerations":["Two putts is a good result","Keeps the bunker out of play"]},{"id":"left","label":"Well left of the green","verdict":"acceptable","consequence":"Safe from the bunker but leaves a tricky chip back over the slope.","considerations":["Safe but wasteful","Not needed when the middle is available"]}],"expertNote":"Good players aim at the fat part of the green when the flag is tucked. A fifteen-foot putt beats a bunker shot every time.","sayThisLine":"I'm not going after that flag; middle of the green is fine."}
```

**Sample 2** (lesson `rule-06`)

```json
{"prompt":"A faster group is right behind you. What now?","situation":{"narrative":"You are playing a relaxed round and the group behind is waiting on every shot.","facts":[{"label":"Your pace","value":"About 4 hours 30 minutes"},{"label":"Group behind","value":"Waiting on every tee"},{"label":"Open hole ahead","value":"Yes, a full hole gap","emphasis":"warning"},{"label":"Course rule","value":"Pace of play posted at the first tee"}],"narrative":"You are playing a relaxed round and the group behind is waiting on every shot."},"options":[{"id":"ignore","label":"Keep going and ignore them","verdict":"poor","consequence":"The group behind gets frustrated and the whole course backs up.","considerations":["Rounds that back up hurt everyone","A gap ahead means you are the problem"]},{"id":"through","label":"Wave them through when convenient","verdict":"best","consequence":"They pass smoothly, thank you, and you relax and enjoy your round.","considerations":["Let faster groups play through","Do it at a tee or a safe spot"]},{"id":"rush","label":"Speed up and skip the rest of your routine","verdict":"acceptable","consequence":"It helps a little, but rushing makes shots worse and still leaves the group behind you.","considerations":["Ready golf helps","Rushing can lead to errors"]}],"expertNote":"Letting a faster group play through is good manners, not an insult. Everyone plays better with space around them.","sayThisLine":"Go ahead and play through, we're taking our time."}
```

**Sample 3** (lesson `rule-07`)

```json
{"prompt":"You are unsure of a ruling in stroke play. What do you do?","situation":{"narrative":"Your ball is near a drainage cover and you are not sure if you get relief. No official is nearby.","facts":[{"label":"Format","value":"Stroke play, counting"},{"label":"Official nearby","value":"No"},{"label":"Your partners","value":"Also unsure"},{"label":"Stakes","value":"Club championship round"}],"narrative":"Your ball is near a drainage cover and you are not sure if you get relief. No official is nearby."},"options":[{"id":"guess","label":"Guess and play on, sign the card","verdict":"poor","consequence":"A wrong guess can mean a penalty or disqualification for a wrong score.","considerations":["A wrong ruling can bring penalties","You are responsible for your card"]},{"id":"two","label":"Play two balls and report to the committee","verdict":"best","consequence":"Stroke play allows two balls when unsure. The committee decides which counts afterward.","considerations":["Announce which ball you will count","Report the situation before signing your card"]},{"id":"partners","label":"Take the group's best guess","verdict":"acceptable","consequence":"It might be right, but friends can be wrong too.","considerations":["Better than a solo guess","Not the same as checking"]}],"expertNote":"When you honestly do not know, the rules allow you to play two balls in stroke play and let the committee sort it out. Asking beats guessing.","sayThisLine":"I'm not sure, so I'll play two balls and check afterward."}
```

**Sample 4** (lesson `cond-05`)

```json
{"prompt":"Thunder rumbles and the course horn sounds. What now?","situation":{"narrative":"You are on the 14th fairway when the course sounds its horn.","facts":[{"label":"Sound","value":"Thunder in the distance","emphasis":"warning"},{"label":"Course signal","value":"Horn: suspend play","emphasis":"warning"},{"label":"Nearest shelter","value":"Clubhouse, half a mile"},{"label":"Nearest trees","value":"A big oak, 40 yards away"}],"narrative":"You are on the 14th fairway when the course sounds its horn."},"options":[{"id":"finish","label":"Finish the hole first","verdict":"poor","consequence":"Lightning can strike miles ahead of a storm. Finishing is not worth the risk.","considerations":["Stop when the horn sounds","Lightning does not wait for a putt"]},{"id":"tree","label":"Shelter under the big oak","verdict":"poor","consequence":"Tall isolated trees attract lightning and are among the most dangerous places to stand.","considerations":["Trees are not shelter","Do not stand near tall objects"]},{"id":"leave","label":"Leave the course now for a safe building or vehicle","verdict":"best","consequence":"You follow the course's procedure and get to a safe place quickly.","considerations":["Follow the course's own procedure","Take cart or walk directly to shelter"]}],"expertNote":"When the horn sounds, play stops. Leave the course and follow the club's procedure; do not wait for the next hole and do not shelter under trees.","safetyNote":"This is a learning scenario, not lightning safety training; follow your course's official procedure."}
```
