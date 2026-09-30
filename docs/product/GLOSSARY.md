# Swoon'd Glossary

Shared vocabulary. Use these terms consistently in code, contracts and docs.

| Term | Meaning |
|---|---|
| **Person** | The human the learner is learning for (crush, partner, friend...). Primary object of the product (spec section 2). Display-only name and relationship. |
| **Learner** | The app user. |
| **Interest** | Something a Person cares about; maps to exactly one **Course** (or a branch of one). |
| **Category / Family** | Organizational grouping (Sports, Motorsports...). Not a course. |
| **Course** | An intentionally designed curriculum for one interest (`courseId`, kebab-case). |
| **Branch** | A sub-variant of a course sharing its foundation (NFL / College). Personalization layer. |
| **Personalization** | Person-specific values (favorite team, driver, artist) that tune examples and live context. |
| **CDS** | Course Design Specification (spec section 8). Written before any course content. |
| **Course Manifest** | Machine-readable coordination object per course (spec section 41). |
| **Curriculum** | The authored content: units, lessons, activities, concepts, talk tracks, review policy. |
| **Layer** | Unit category: foundations, intermediate, enthusiast, current-season, conversation, review. |
| **Unit / Lesson / Activity** | Curriculum hierarchy. An Activity is one interaction (native exercise or Unity sim). |
| **Concept** | A single teachable idea/term (`conceptId`). Mastery is tracked per concept. |
| **Playbook** | The learner-facing glossary of concepts (term, definition, example line). |
| **Common Ground %** | Weighted average of a Person's per-interest progress (design spec section 8). |
| **Mastery** | Per-concept value 0..1; "Mastered" at or above the course `passThreshold`. |
| **Spaced review** | Leitner-box scheduling of previously learned concepts (`reviewPolicy`). |
| **Talk Track** | Chat-style conversation practice. |
| **Daily Bite** | Short daily current-context card (+10 XP). |
| **Hearts** | Mistake budget. 5 max; a wrong answer costs 1; Swoon'd+ unlimited. |
| **XP** | Experience points. +10 correct, +40 finished game, +10 daily bite, +80 challenge win. |
| **Streak** | Consecutive local days with at least one XP-earning action. |
| **Native exercise** | Tier B activity implemented in Swift/SwiftUI. |
| **Unity sim / simulation** | Tier A activity implemented in Unity by Astra. |
| **Astra** | OpenAI ChatGPT Work agent that owns Unity and the Swoon Game Kit. |
| **Swoon Game Kit** | Astra's reusable Unity primitive library (spec section 23). |
| **Bridge** | The versioned native/Unity JSON interface (`docs/contracts/unity-bridge/v1/`). |
| **LaunchRequest / SimulationResult** | Bridge payloads native to Unity and Unity to native. |
| **SwoondCore** | Foundation-only Swift package: domain, engines, contracts. Builds on Linux. |
| **SwoondApp** | The SwiftUI iOS app target; depends on SwoondCore. |
| **Provider Adapter** | Class converting an external API to Swoon'd normalized data (spec section 32). |
| **Content pack** | Bundled folder of a course's curriculum JSON plus assets shipped in or downloaded by the app. |
| **Tier A / Tier B** | Unity / native game tiers (D-003). |
| **Kitchen / Pit stop / Talk track** | Design-file demo games; representative only (D-002). |
