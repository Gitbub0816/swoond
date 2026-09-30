# Dynamic Data and Editorial Plan: Fashion (`fashion`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context) and 32-40 (provider isolation, news, media courses). Facts below were checked by web search on 2026-09-30 and must be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**Yes, modestly.** Fashion is not a scores-first subject and Swoon'd is not a trend-tracking service (spec section 10: do not invent artificial live-data needs). Most of the course is evergreen (silhouettes, fabrics, construction, fit vocabulary). The current layer is thin and curated: what is on the calendar this month, who leads which house, what is dropping, and what fashion regulation is changing, plus editorial "why are people talking about this?" explainers. It is **media-adjacent** (spec section 40): Swoon'd talks about collections and shows and links out; it never redistributes runway photos, video, reviews or press text.

Explicitly **not** planned: prices or resale market data (licensing risk, invites budget-shaming), trend-popularity scores, "what to wear today" weather styling, celebrity outfit tracking, or any body/size data.

## 2. Current-context layers

| Layer | Who sees it | What it is |
|---|---|---|
| Fashion calendar | Everyone; `luxury-runway` branch emphasized; `region` picks the home city | This month's shows, couture weeks, events; "why it matters" cards |
| Who's where | `luxury-runway` branch and anyone who sets a `brand` | Dated creative-director and leadership facts cards |
| Drop and release watch | `streetwear` branch | Upcoming official collab and release dates (link-out), explainer of why they matter |
| Rules pulse | Everyone (sustainability unit); optional | Dated explainers of EU/French/other textile rules |
| Evergreen fallback | Always | If any card is missing, show an evergreen explainer ("What happens at a fashion show?") |

## 3. Data kinds, providers, refresh

External providers never become the domain model (spec section 32): Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `schedules`, `events` | "What's on this week?" | CFDA Fashion Calendar, Fédération de la Haute Couture et de la Mode (Paris), CNMI (Milan), British Fashion Council (London): official pages | **Curated ingest** by editors with source links; no known open API | weekly; daily in show weeks | Last verified calendar with "check the official calendar" link |
| `transactions` (appointments/departures) | Creative-director news is the top conversation refresh | House press releases (primary), trade media headlines (link-only) | Curated dated facts cards with source; each card shows "as of" date | weekly review | Dated card |
| `releases`, `new-products` | Collab and drop dates | Official brand release pages | Link-out only; store dates as facts; never scrape retailers or resale platforms | weekly | Hide card |
| `news` | Why people are talking about X | Fashion trade and mainstream media | **Link-only** headlines/metadata where licence allows; Swoon'd writes the explainer | daily | Evergreen explainer |
| `regulations` | Sustainability rule changes | EUR-Lex / European Commission (Ecodesign for Sustainable Products Regulation, Digital Product Passport), French ministries (anti-fast-fashion law) | Curated dated explainer cards from official texts | monthly | Dated card |

### Snapshot as of 2026-09-30 (illustrative; not hard-coded in lessons) [verify at release]
- **Spring/Summer 2027 fashion month:** New York Sep 10-15; London Sep 17-21; Milan Sep 22-28; Paris Sep 28 - Oct 6, 2026 (about 68 shows plus presentations on the Paris calendar). Dates are as reported by trade/calendar sources.
- **Who's where (reported):** Chanel: Matthieu Blazy; Dior: Jonathan Anderson; Gucci: Demna; Balenciaga: Pierpaolo Piccioli; Bottega Veneta: Louise Trotter; Versace: Pieter Mulier (Versace was acquired by Prada, completed December 2025); Courrèges: Drew Henry; Rabanne: Olivier Rousteing (debut planned for March); McQueen returning to London under Seán McGirr. Appointments change frequently; this list is the reason the "who's where" card is dated and curated.
- **Regulation pulse:** The EU Ecodesign for Sustainable Products Regulation (ESPR) sets up a Digital Product Passport; the textile delegated act is expected around 2027 with an implementation lead time; a ban on destroying unsold apparel and footwear for large companies is reported to apply from 19 July 2026; France has adopted an anti-ultra-fast-fashion law. Statuses and details must be checked against official sources before any card ships.

## 4. Editorial approach

- **Explain and link.** Swoon'd's own words; link to the original publisher. Never copy review, article or press-release text.
- **Topics we explain:** why a creative-director change matters; what a collection references; why a collab sold out; what a trend term means; why a sustainability claim is contested; what a regulation changes.
- **Sources (link-only, licence to be confirmed, open item L-01):** Business of Fashion, WWD, Vogue, Fashionista, Highsnobiety, Hypebeast, The Cut; official house, calendar and regulator sites. Many are paywalled: metadata and headline link-out only.
- **Example prompts:** "Why are people talking about this appointment?" "What was that show referencing?" "Why does everyone say this collab sold out?"

## 5. Licensing and spec section 40 posture

| Asset | Posture |
|---|---|
| Runway and editorial photography | Never bundled or hotlinked; agency-licensed; link-out only |
| Runway video | Link-out to official streams; no embeds by default |
| Logos, monograms, trade dress | Not reproduced; text mentions only |
| Designer names and facts | Facts only; no likeness, no fabricated quotes |
| Reviews and articles | Paraphrase and link; no copying |
| Illustrations | All original (`original-swoond`) |
| Data | Curated facts with attribution; no scraping of paywalled/restricted sites; no unofficial APIs |

## 6. Personalization hooks

- `brand`: prioritize appointment/release/news cards for her favorite house or label; default none.
- `style`: pick which evergreen and editorial explainers to surface (e.g. tailoring news for `menswear-tailoring`); default `everyday-style`.
- `region`: home fashion-week city and local thrift/vintage market context; default none, hidden when unset.

## 7. Failure modes

Provider or curation gaps never block lessons: every live hook has an evergreen fallback; every fact card carries its "as of" date; no card is shown past its staleness limit (calendar 14 days, who's-where 60 days, regulation 120 days) without a "check the source" notice.
