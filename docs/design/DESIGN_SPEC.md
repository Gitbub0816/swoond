# Swoon'd — Design Spec

The rules that keep Swoon'd feeling premium. When in doubt: fewer elements, more space, serif for emotion, sans for information.

## 1. Brand & naming

- **Display name:** Swoon'd (curly apostrophe `’` in UI copy; ASCII `'` acceptable in code/metadata).
- **Wordmark:** "Swoon" in Instrument Serif regular + "'d" in Instrument Serif *italic*, colored `accent`. Premium adds a gold "+" (`reward`).
- **Search / discoverability — must match all of:** `Swoon'd`, `Swoon’d`, `Swoond`, `Swoon d`, `swoond`, `swoon`.
  - App Store (iOS): name `Swoon'd`; put `swoond, swoon` in the Keywords field; subtitle e.g. "Learn what your crush loves".
  - Google Play: title `Swoon'd`; include "Swoond" naturally in the short/long description (Play indexes description text, has no keyword field).
  - Web/domain/handles: use `swoond` (no apostrophe) — e.g. swoond.app, @swoond. Redirect `swoon-d` variants if purchased.
  - In-app search (Playbook, interests): normalize queries by stripping apostrophes/whitespace and lowercasing before matching.
  - Bundle IDs: `app.swoond.ios` / `app.swoond.android` (no apostrophes allowed).
- Before launch: verify name/trademark availability in App Store, Google Play and USPTO.

## 2. Voice

Cheeky coach. Playful roasts, never mean, never about the crush. Short sentences. One joke per screen max.
- Correct: "Four downs. Look at you, practically a commentator."
- Wrong: "Please do not say that out loud at the bar."
- Never: shaming, pickup-artist language, anything implying manipulation. The premise is *finding common ground*, not faking it.

## 3. Color tokens

| Token | Dark (default) | Light | Use |
|---|---|---|---|
| `bg` | `#111014` | `#F7F3EC` | App background |
| `bg-deep` | `#0D0C10` | `#EFE9DF` | Game screens |
| `surface` | `#1A191F` | `#FFFFFF` | Cards, list rows |
| `surface-2` | `#26242B` | `#EDE7DD` | Avatars, selected segment |
| `stroke` | `rgba(255,255,255,.07)` | `rgba(20,16,22,.08)` | Card borders |
| `stroke-strong` | `rgba(255,255,255,.14)` | `rgba(20,16,22,.16)` | Chips, secondary buttons |
| `ink` | `#F3EEE6` | `#17151A` | Primary text, primary button fill |
| `ink-2` | `#C9BFC4` | `#4A434C` | Body copy on cards |
| `ink-3` | `#A9A3AD` | `#6B646E` | Secondary text |
| `ink-4` | `#8D8791` | `#857E88` | Labels, eyebrows (large/uppercase only in light) |
| `ink-5` | `#6F6A74` | `#A39DA6` | Disabled, inactive tabs |
| `accent` | `#FF6F86` | `#D93F5E` | Rose. Primary game CTA, selection, "me" |
| `accent-soft` | `#FF9AAB` | `#B8324F` | Eyebrow text in accent contexts |
| `accent-tint` | `rgba(255,111,134,.14)` | `rgba(217,63,94,.10)` | Selected chip / wrong-answer bg |
| `on-accent` | `#1A0E12` | `#FFFFFF` | Text on accent fill |
| `reward` | `#E8C07A` | `#A87A1E` | Gold. XP, streaks, correct, premium, badges |
| `reward-tint` | `rgba(232,192,122,.14)` | `rgba(168,122,30,.10)` | Correct-answer bg |
| `court` | `#1D2A27` | `#D9E6DF` | Playing surfaces (courts/fields) |
| `hero-grad` | `#2A1820 → #1A1419` (160°) | `#FBE4E8 → #FFFFFF` (160°) | Featured card |

**Light-mode rules**
- Accent and reward are darkened in light mode so text reaches 4.5:1 on `bg`. Never use the dark-mode `#FF6F86` or `#E8C07A` as text on light backgrounds.
- The primary button inverts: dark `ink` fill with `bg` text.
- Shadows appear only in light mode: cards `0 1px 2px rgba(20,16,22,.06)`, sheets `0 12px 32px rgba(20,16,22,.12)`. Dark mode separates layers with `stroke` alone.
- Photos keep their dark gradient scrim in both modes. Daily Bite always renders dark.
- Game playing surfaces use `court` in both modes. Pieces, balls and markers keep their colors.
- The appearance setting offers Dark, Light and System. The default is Dark.

**Color rules**
- Rose means *act or you*: the primary action, your own selections, your chat bubbles. Gold means *earned*: XP, streaks, correct answers, badges, premium.
- Use at most one filled accent button per screen.
- Never rely on red or green alone for right and wrong. Always pair the color with a title ("Nice read." or "Not quite.") and an explanation.
- No gradients except `hero-grad`, the result/challenge radial glow (`accent` at 15% or less) and the premium radial glow (`reward` at 15% or less).

## 4. Typography

Fonts: **Instrument Serif** (display, regular and italic) and **Geist** (UI, 400/500/600). Both are on Google Fonts, SIL OFL. On native platforms, bundle both fonts. Never fall back to Inter or Roboto on purpose.

| Style | Font | Size/Line | Notes |
|---|---|---|---|
| Display XL | Instrument Serif | 52/0.95 | Results headline |
| Display L | Instrument Serif | 40–46/1.0 | Screen titles, onboarding |
| Display M | Instrument Serif | 30–34/1.05 | Game prompts, card titles |
| Display S | Instrument Serif | 20–26/1.2 | Quotable lines, glossary terms |
| Numeral | Instrument Serif | 30–52 | Stats, scores, meter |
| Body L | Geist 500–600 | 15–16/1.35 | Buttons, list titles |
| Body | Geist 400 | 14/1.45 | Explanations |
| Caption | Geist 400 | 12–13/1.4 | Metadata |
| Eyebrow | Geist 400–600 | 11, +0.14em, UPPERCASE | Section labels |

Rules:
- Use serif for feelings, headlines and the lines you'd say out loud. Use sans for anything you have to read or tap.
- Use *italic* serif for one or two words of emphasis per headline, colored `accent`. The crush's name is always italic in headlines.
- Lines to say out loud are always serif and wrapped in quotation marks.
- The minimum text size is 11px, and only for uppercase eyebrows. Body text is 13px or larger.

## 5. Layout & shape

- Base frame: 375×812 (iOS) / 360×800 (Android). Screen gutters are 16px for cards and 22–24px for text.
- Spacing scale: 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28, 32.
- Radii: chip and button 999 (pill); input 14; list row 16–18; card 20–22; hero card 26; segmented control 14 outer and 10 inner; badge 50%.
- Hit targets are at least 44pt. Primary buttons are 56–58pt tall and secondary buttons 50pt.
- The bottom tab bar is 82pt (including the safe area) with tabs Learn, Games, Talk, Live and Me. The active tab uses `ink` at weight 600; inactive tabs use `ink-5`. The bar is 92% opaque `bg` with a top `stroke`.
- The primary CTA is pinned 28–34pt above the bottom safe area on game, onboarding and results screens.

## 6. Components

- **Chip:** 40pt tall, 16pt horizontal padding. Off: `stroke-strong` border. On: `accent` border, `accent-tint` fill, light rose text.
- **Primary button:** pill with `ink` fill and `bg` text. Game button: `accent` fill with `on-accent` text. Premium button: `reward` fill.
- **Secondary button:** pill, transparent, with a 1px `stroke-strong` border.
- **Progress bar:** 3–4pt tall with a rounded `ink` fill on a `rgba(ink,.08)` track.
- **Answer feedback panel:** 18 radius. The title is 15/600, followed by a 13/1.45 explanation. The background is `reward-tint` when correct and `accent-tint` when wrong.
- **Chat bubble:** max width 260. Yours: `accent` fill with the corner radius 20/20/6/20. Theirs: `#1F1E24` fill with 20/20/20/6.
- **Coach note:** centered italic serif in `reward` color, 16px.
- **Toggle:** 46×28 track, `accent` when on, 22pt knob.
- **Common-ground meter:** a conic ring, 104pt outside and 88pt inside, filled in `accent`.

## 7. Motion

- Default easing is `cubic-bezier(.2,.8,.2,1)`. Durations: 150ms for taps and selection, 250ms for panels, 400ms for game pieces.
- Correct answer: a gold pulse on the feedback panel plus a light success haptic. Wrong answer: a 6px horizontal shake plus a warning haptic.
- Results: count the numerals up over 600ms. No confetti; the finish comes from type and gold.
- Respect Reduce Motion by replacing movement with cross-fades.

## 8. Game design rules

Every game follows the same loop: **prompt → one decisive interaction → instant explanation → a line you could say out loud.**
- The prompt is a Display M serif line, 12 words or fewer.
- Use one mechanic per game: timing (Pit Stop), binary call (Pickleball), tap a spot (field), pick a reply (Talk Track), or ref the clip.
- Explain every answer, right or wrong. The explanation teaches how the sport works, not just the rule's name.
- A session is 3 rounds and about 3 minutes. Wrong answers cost 1 heart (5 max; Swoon'd+ gets unlimited).
- XP: +10 per correct answer, +40 for a finished game, +10 for a daily bite, +80 for winning a challenge.
- Common Ground % = the weighted average of the crush's per-interest progress.

## 9. Content scale

Launch interests (20): Football, Hockey, NASCAR, Pickleball, Video games, Basketball, Soccer, F1, Tennis, Golf, Baseball, Anime, K-pop, Climbing, Wine, Fashion, Skincare, Coffee, Horror films, Hiking. Each interest needs: 3+ units, 2+ game types, a Playbook term list, 1+ Talk Track and a daily bite feed. Every interest uses the same visual system, with no per-interest color themes.
