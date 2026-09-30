# Dynamic Data and Editorial Plan: Coffee (`coffee`)

Implements product spec sections 10-12 (structured current data, editorial context, personalized context), 32-37 (provider isolation) and 38-40 (current-context layer, licensing, media). Facts below were checked by web search on **2026-09-30** and must be re-verified at each release **[verify at release]**.

## 1. Verdict: is there meaningful live data?

**A little, and that is the honest answer.** Coffee is an evergreen-knowledge course: why a sour shot needs a finer grind does not change with the news cycle. Spec section 10 says not to invent artificial live-data needs. There are no scores, standings or rosters. What *does* change, and what a coffee friend actually talks about, is:

1. **What is fresh now** (harvest and arrival windows by origin).
2. **The calendar** (championships, World of Coffee, trade events).
3. **Price and sourcing news** (why coffee costs what it costs; frost, drought, tariffs, regulations), as explainers with link-out.
4. **New releases** (roaster seasonals, gear launches) as talking points, never a shopping feed.

Do not add live café ratings, price comparison feeds, affiliate links, nutrition or caffeine-intake tracking, or "best coffee" rankings.

## 2. Current-context layers (spec section 38 spirit)

| Layer | Who sees it | What it is |
|---|---|---|
| Fresh this month | Everyone; sharper when `region` (origin) is set | Which origins are arriving or fresh now, one tasting tie-in |
| Price explainer | Opt-in card | What the C price is, why it moved, and what it does and does not mean for farmers; dated, link-out |
| Coffee in the news | Everyone (opt-in card) | A current story (frost, regulation, a record auction) in our own words, plus one question to ask her |
| Championships and releases | Learners with `style` = specialty nerd or a `brand` set | What is on this season and why fans care |
| Evergreen fallback | Always | If any provider is down or empty, cards fall back to an evergreen explainer ("How to read a harvest calendar") |

## 3. Data kinds, providers, refresh (spec sections 10, 32-37)

Provider -> **Adapter** -> Swoon'd normalized entity -> Course interpretation -> UI. No provider schema becomes the domain model. Candidates only; every one sits behind a Swoon'd adapter.

| Kind (manifest) | Why | Provider candidates | Access approach | Refresh | Fallback |
|---|---|---|---|---|---|
| `conditions` (harvest calendar) | "What's fresh now?" | Swoon'd editorial table curated from ICO and SCA public information | **Curated ingest** by origin and month; no live API | monthly | Static calendar |
| `events` | Championships, trade shows | Swoon'd editorial calendar; World Coffee Championships, World of Coffee, SCA Expo pages (link-only) | Curated | seasonal | Evergreen "what is a championship" |
| `statistics` (price explainer) | "Why is coffee pricey?" | ICO composite indicator price (public; verify reuse terms); editorial. **ICE futures data is licensed and not assumed.** | Curated monthly figure with attribution, or link-out | monthly | Evergreen `c-price` lesson |
| `regulations` | Sourcing rules (EUDR) | European Commission pages (link-out); Swoon'd explainer | Curated | weekly | Evergreen sustainability lesson |
| `news` | "Why is everyone talking about X?" | Trade publication headlines (link-only); ICO and SCA news (link-out) | Link-only ingestion where licence allows; Swoon'd explains | weekly | Evergreen explainers |
| `new-products` | Roaster seasonals, gear launches | Swoon'd editorial; roaster and manufacturer press pages (link-only) | Curated; no price feed, no affiliate | monthly | Hidden |

### Time-sensitive facts to keep dated **[verify at release]**

- **SCA Golden Cup Standard** (verified 2026-09-30): about 55 g/L of coffee (plus or minus 10 percent), water 200 F plus or minus 5 F (93 C plus or minus 3) at contact, TDS 1.15 to 1.35 percent, extraction yield 18 to 22 percent. The standard was developed for batch brewing; the course teaches it as a reference, not a law.
- **World Barista Championship:** 2025 champion Jack Simpson (Australia, Axil Coffee Roasters), held in Milan; 2026 WBC in Panama City, 22 to 25 October 2026 (first in Central America). Other 2026 championships (Brewers Cup, Roasting, Good Spirits in Brussels, June 2026; Latte Art in San Diego, April 2026; Cup Tasters in Bangkok, May 2026). Dated event cards only.
- **EU Deforestation Regulation (EUDR):** application postponed to 30 December 2026 (small and micro enterprises 30 June 2027); coffee is in scope. A later scope change concerning soluble coffee was reported and must be verified against the Official Journal before any card ships.
- **Prices:** arabica futures set an all-time record near 4.38 USD/lb in October 2025 and were near 2.88 USD/lb on 30 September 2026 per market reports. **Never hard-code prices** in evergreen lessons; price cards are dated explainers. Tariff and trade-policy claims (for example, US measures affecting Brazilian coffee) change frequently and must be verified at publication.
- **Brazil:** reports in September 2026 describe a large 2026 harvest; do not state volumes in static content.

## 4. Normalized entities (Swoon'd-owned)

| Entity | Fields | Source kind |
|---|---|---|
| `HarvestWindow` | `origin`, `hemisphere`, `harvestMonths[]`, `arrivalMonths[]`, `notes`, `lastVerified` | conditions |
| `CoffeeEvent` | `id`, `name`, `kind` (championship, trade-show, festival), `city`, `start`, `end`, `sourceUrl` | events |
| `PriceExplainer` | `asOf`, `indicator`, `value`, `unit`, `sourceName`, `sourceUrl`, `explainerId` | statistics |
| `RegulationNote` | `id`, `jurisdiction`, `effectiveDate`, `scope`, `sourceUrl`, `lastVerified` | regulations |
| `CoffeeStory` | `id`, `topic`, `headlineSource`, `url`, `swoondSummary`, `askHerQuestion` | news |
| `ReleaseNote` | `id`, `roasterOrMaker`, `title`, `sourceUrl`, `date` | new-products |

## 5. Editorial plan (spec sections 11, 39-40)

- Topics Swoon'd explains: the C price and why it moves; what it means when an origin is "in season"; how sourcing rules change what reaches shelves; what a championship judges; why anaerobic or other trends are debated; what a new gear category is.
- Every card: our own words, an attributed fact or two, a link-out, and one "ask her" line. Never copy publisher text, never reproduce competition routines or standards.
- Tone: curious, neutral on brands and certifications; no health or caffeine claims.
- Cadence: harvest card monthly; events seasonally; price explainer monthly; regulation and news weekly when relevant; a human reviews each dated card before publication.

## 6. Personalization hooks (spec section 12)

| Dimension | Hook |
|---|---|
| `region` (origin) | The harvest card highlights her origin; the news card picks stories mentioning it |
| `format` (brew method) | Gear and technique cards match her method (espresso vs pour-over) |
| `equipment` | Release notes filtered by gear category she has |
| `style` | Specialty nerds see championships and releases; daily-cup drinkers see the price explainer and menu tips |
| `brand` (roaster) | Only public event calendars of that roaster, if any; otherwise hidden |

Discreet mode: notifications never include the Person's name or relationship.

## 7. Failure modes

Provider down, empty or rate-limited: hide the card and show the evergreen explainer. Stale facts: every card carries `lastVerified`; cards older than their refresh window auto-hide. Unverifiable claim: do not publish. Licensing doubt: link out instead of summarizing.

## 8. Licensing summary

ICO public indicators need reuse-terms review at adapter build; ICE futures data is licensed and not assumed; European Commission pages are link-out; trade publications are link-only; SCA standards text and flavor wheel are cited and linked, not reproduced; no competition video or routine text; champions named as facts only. Media courses' spec section 40 rule (talk about works, never redistribute them) applies to books and documentaries if later added.
