# Handoff: Swoon'd (mobile app, iOS + Android)

## Overview
Swoon'd teaches you the interests of someone you have a crush on (sports, games, hobbies) through short playable games and conversation practice, so you can find common ground. This package covers onboarding, home, 3 playable game types, the results screen, live companion, playbook, league, profile, friend challenges, daily bite, the paywall and settings.

## About the design files
`Swoond.dc.html` contains **design references built in HTML**. They are prototypes showing the intended look and behavior, not production code. Recreate them in the target stack. There's no existing codebase, so we recommend **React Native + Expo** (one codebase for iOS and Android, with haptics and custom fonts) or SwiftUI and Jetpack Compose if you go native. To view the file, open `Swoond.dc.html` in a browser (it needs `support.js` next to it).

## Fidelity
**High fidelity.** Colors, type, spacing, copy and interactions are final. Recreate them pixel-accurately. **`DESIGN_SPEC.md` is the source of truth** for tokens (dark and light), type, components, motion, naming/search and game rules. Light mode is specified only as tokens; build it from the token table.

## Screens
Each ID matches the badge in the HTML. The frame is 375×780 (render at 375×812 on device, adding the safe area).

| ID | Screen | Purpose / key contents |
|---|---|---|
| 2a | Onboarding · Interests | Step 2 of 3 (step 1 = crush's name, step 3 = your goal). The title is "What's *{name}* into?", followed by a wrapping grid of 20 toggle chips, a live count ("N interests selected") and a "Build my plan" button. |
| 2b | Home (Learn tab) | Wordmark, streak pill (gold) and hearts pill. Common-ground ring (%) plus the crush's name. "Today's game" hero card (hero-grad, rose border, Play pill). A list of their interests, each with a progress bar. |
| 2c | Game · NASCAR Pit Stop | A timing game with 3 rounds. A marker sweeps back and forth across a 44pt bar; the player taps when it's inside the gold zone. The zone shrinks each round (58–74%, 64–76%, 70–79%) and the speed rises. A hit scores 100 points; a miss scores `max(0, 60 − off×3)`. The clock shows `11.2 + off×0.12` seconds, and tires turn gold as rounds complete. |
| 2d | Game · Pickleball Kitchen | Binary calls ("Volley it" or "Let it bounce") over 3 rallies on a court diagram with a rose player dot and a gold ball. Rules taught: two-bounce rule, volleying outside the kitchen, no volleys in the kitchen. A wrong answer costs 1 heart. A feedback panel and "Next rally" button follow each call. |
| 2e | Talk Track · Hockey | A chat simulation. The crush's message appears, followed by 3 reply options. Each pick adds its reply and the crush's response, adjusts the "Smooth" score (starts at 50, deltas range −20 to +30) and shows a coach note. There are 2 exchanges, then a restart. |
| 2f | Results | Eyebrow, "You can now *hang*.", 3 stats (XP, accuracy, common ground in gold), a list of unlocked lines in serif and quotation marks, a league position row, and Share and Continue buttons. |
| 3a | Live companion | A live score card, a "Say this now" hero line, and a "What just happened" feed that translates each event into plain English. The crush's team is labeled. |
| 3b | Playbook | Title and count, search field, interest filter chips, and term cards (term in serif, status Mastered/Learning/New, definition, example line in italics). |
| 3c | League | League crest, name ("Crushing League", next tier "Smitten"), days left, and 8 ranked rows. The top 5 get gold rank numbers, with a dashed promotion line after #5. Your row is highlighted in rose. |
| 3d | Profile | Avatar, name, level, 3 stat tiles and a 3-column badge grid. Locked badges are shown at 40% opacity with a grey ring. |
| 3e | Friend challenge | The "Challenge received" headline names the interest, followed by You vs Jordan avatars, a details card (format, opponent's score, prize) and Accept / Not now buttons. |
| 3f | Daily bite | A full-bleed photo with a scrim and story-style progress bars at the top. Headline, "why it matters" paragraph, a "Say this today" rose card, and a "Got it · +10 XP" button. |
| 3g | Swoon'd+ paywall | Wordmark with gold +, 5 benefit rows, a plan picker (Yearly $59.99, selected by default, "Save 40%"; Monthly $7.99), a gold "Start 7-day free trial" button, and cancel/restore links. Prices are placeholders. |
| 3h | Settings | Crush list (active crush plus "Add another crush"), Appearance segmented control (Dark/Light/System), and toggles: Discreet mode (hides the crush's name in notifications), Daily reminder, Sounds & haptics. |

Future game mechanics to add (not yet designed): "tap the field" (tap where the ball needs to reach) and "Ref it" (watch a clip, make the call). Style them with Swoon'd tokens.

## Interactions and behavior
- Navigation: onboarding steps 1→2→3 lead to Home. Home's Play opens the game, then Results, then back to Home. The tab bar holds Learn (Home + Playbook), Games, Talk, Live and Me (Profile, League, Settings). The paywall appears when hearts run out, when a user taps a locked interest, or from Settings.
- Answer feedback: show the panel immediately and disable input until Continue. Feedback titles are "Nice read." or "Not quite."
- Hearts: when they reach 0, show a sheet with "Wait 4h", "Practice to earn one" or "Go unlimited", which leads to the paywall.
- Streak: increments on the first XP of each local day. The daily reminder notification is sent at 8 PM by default.
- Discreet mode is ON by default. Notifications then say "Your daily game is ready" and never include the crush's name.
- Motion and haptics are covered in DESIGN_SPEC §7.

## State (suggested)
```
user { id, name, level, xp, streak, hearts, premium, theme: 'dark'|'light'|'system', settings { discreet, remind, sound } }
crush { id, name, interests: InterestId[], active }
progress[crushId][interestId] { pct, unitsDone, termsMastered[] }
commonGround(crush) = weighted avg of progress pct across crush.interests
game session { type, interestId, round, score, heartsLost, answers[] }
league { tier, members[{userId, weeklyXp}], endsAt }
challenge { from, to, interestId, questionSetId, fromScore, toScore, status }
```
Content (units, games, terms, talk tracks, daily bites) should be data-driven JSON per interest so that new interests can be added without code changes.

## Design tokens
All tokens are in `DESIGN_SPEC.md` §3–5 (color for dark and light, type scale, spacing, radii, shadows).

## Assets
- Fonts: Instrument Serif and Geist (Google Fonts, OFL). Bundle both in the app.
- Photos: the Daily Bite needs licensed sports editorial imagery (placeholder in the design).
- Icons: the tab bar is shown as text labels only. Add a thin 1.5px line icon set (for example Phosphor Light or Lucide) in the `ink`/`ink-5` colors. No emoji.
- Badges: the serif monograms are placeholders and could become custom illustrated medallions later.

## Files
- `Swoond.dc.html`: all screens (turn 3 on top, turn 2 below). Open in a browser.
- `support.js`: the runtime needed to open the HTML.
- `DESIGN_SPEC.md`: design rules, light mode, and naming/search requirements.
