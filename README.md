# Swoon'd

*Get into what they're into.* An iOS-first (Android later) app that teaches you the interests of someone you care about, through native exercises and Unity simulations, so you can genuinely understand and join the conversation.

- Native app (Swift 6 / SwiftUI) by Claude Code; Unity simulations by Astra; shared, versioned contracts in `docs/contracts/`.
- Start with [`CLAUDE.md`](CLAUDE.md), then [`docs/product/SWOOND_PRODUCT_SPEC.md`](docs/product/SWOOND_PRODUCT_SPEC.md) and [`docs/product/DECISIONS.md`](docs/product/DECISIONS.md).
- Architecture: [`docs/architecture/ARCHITECTURE.md`](docs/architecture/ARCHITECTURE.md). Design: [`docs/design/`](docs/design/). Astra handoff: [`docs/astra/`](docs/astra/). Courses: [`docs/courses/`](docs/courses/).

Validate contracts and course content:

```
cd tools/validate && npm install && node validate.mjs
```
