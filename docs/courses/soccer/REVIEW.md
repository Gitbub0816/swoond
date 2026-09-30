
## Units 11-20

Accuracy and conformance review. Validator status at finish: 0 schema errors, 0 lint errors, 0 warnings for units 11-20.

Schema fixes: unit 19 `talk-02-ds-reaction` and `talk-05-ds-news` (invented `options[].text/grade`, `explanation`, `coachNote` replaced with `situation`, `label/verdict/consequence/considerations`, `expertNote`); `talk-02-tt-loss` smoothDelta -22 to -20; unit 20 `review-02-bc-pressing-trigger` prompt over 120 characters. Multi-answer multiple-choice items now set `allowMultiple` (11, 19).

Type monoculture: unit 12 multiple-choice 60% to 33% (four items converted to term-match and fill-the-gap); unit 16 41% to 35%; unit 20 say-this 45% to 36%; unit 19 (hidden behind schema errors) 42% to 35%; unit 11 46% to 36%.

Factual corrections (answer keys or claims that were wrong):
- 11: Brazil "nobody else has more than two" (Germany and Italy have four); "only one other player has won three World Cups" (Pele is the only one); Ballon d'Or "voted by coaches, players and fans" (journalists vote); "first time third place could qualify" (best third-placed teams also existed in 1986-94); Real Madrid "nine" European Cups (record is 15); Wembley 2022 Euros crowd; era matcher rebuilt.
- 12: {{team}} token leaked into a static explanation; invented PSR figures in the decision scenario removed; spending rules described without hard limits (rules are changing); 2026/27 VAR corner review aligned with CDS (immediate review only); "cup magic" wrongly keyed the guaranteed-fun option as correct; fifth Champions League place explained via the European Performance Spot.
- 14: MLS described as "single-entity, league owns all franchises" (contested and dated) replaced with "closed league"; per-team Designated Player count ("3-4") and allocation-money description made generic and accurate; the salary cap is a club limit, not a per-player one.
- 15: Gotham 2025 claim aligned to CDS ("lowest seed ever"); an off-brand career-advice scenario replaced with a warm conversation scenario; "NWSL crowds rival men's" overclaim softened.
- 16: "everyone plays everyone" in the league phase (each club plays eight different opponents); positions 25-36 "drop to the Europa League" (they are eliminated); aggregate 3-3 item keyed wrong; 2-1 away/0-1 home arithmetic wrong (aggregate was level); playoff described as "outside the top eight" (it is 9th-24th).
- 17: "top two advance" now includes the eight best third-placed teams; "each group plays 3 matches" now asks about each team; "1950 with 13 teams" and "32 teams for decades" corrected (32 from 1998-2022); a subjective binary-call replaced with a factual one (hosts qualify automatically).
- 18: bogus points arithmetic in several items (points needed, gap maths, survival line, six-pointer logic) rewritten; 36-point survival line changed to the usual 40-point rule of thumb, flagged as a rule of thumb; title pace of 2.0 ppg was keyed as title pace (it is not); tiebreak item now names the Premier League (La Liga uses head-to-head first); incoherent decision scenarios rewritten. Lessons stay evergreen: no live-season facts are stated.
- 19: offside item keyed "only if deliberately touches the ball" as true; "Romano tweeted" updated; unclear multi-answer items fixed.
- 20: title-race tiebreak keyed wrong; xG gap options all fit; offside "completely ahead" explanation; nutmeg distractor keyed as correct.

Award winners: no Golden Boot, Golden Ball, Golden Glove or Young Player names are stated anywhere in units 11-20 (live-data.md flags them "re-verify"). Verified facts used as stated: Spain 1-0 Argentina (Ferran Torres, 106th minute), Arsenal 2025-26 title on 85 points (City 78, United 71), PSG beat Arsenal 4-3 on penalties after 1-1 in the 2026 Champions League final, Inter Miami 2025 MLS Cup 3-1 over Vancouver, MLS 2027 transition season then August-May from 2027-28, IFAB 2026/27 restart countdown and VAR corner review.

Open items for the orchestrator: none of my units needs a new concept id. Messi as a current MLS Designated Player (14) and "Romano" as the well-known "here we go" source (18, 19) are date-sensitive references worth re-checking each August.
