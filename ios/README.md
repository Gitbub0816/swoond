# ios/

Native iOS work for Swoon'd (Claude Code owns this; see `CLAUDE.md` section 3).

| Path | What | Verified where |
|---|---|---|
| `SwoondCore/` | Swift package: all platform-independent logic (domain, content, progression, native exercise engines, Unity bridge types, repositories, providers, learning session, onboarding/playbook/league/settings models). Foundation-only. | `cd SwoondCore && swift test` (Linux or macOS) |
| `Swoond/` | The SwiftUI app: design system, screens, native exercise views, Unity host seam, dependency container. Depends on `SwoondCore`. | Xcode on a Mac (not buildable in the cloud container) |
| `SwoondTests/` | App unit tests (swift-testing): view models, the full lesson flow, design-system helpers. | Xcode on a Mac |
| `project.yml`, `Makefile` | XcodeGen spec and shortcuts. `Swoond.xcodeproj` is generated, not committed. | Mac |

Rule of thumb: if it does not need UIKit/SwiftUI/UnityFramework, it belongs in `SwoondCore`, where it is unit-tested on Linux.

Toolchain: Swift 6 language mode (strict concurrency), iOS 18.0 deployment target, `swift-tools-version: 6.0`.

## Build and run (Mac)

```
brew install xcodegen
cd ios && xcodegen && open Swoond.xcodeproj
```

or `make -C ios open` (see `make help`: `project`, `build`, `test`, `core-test`). Pick an iPhone simulator and run the
`Swoond` scheme. Set your signing team in Xcode for a device build. Every screen has a `#Preview` with seeded data.

The app opens straight into onboarding (no saved people). It bundles a small original preview seed (`Swoond/Resources/ContentPacks`:
nascar, pickleball, hockey) so all three design demo games are playable: Pit Stop (timing-tap), Pickleball kitchen (binary-call)
and the Hockey Talk Track. When the repo has `content/courses/<courseId>/{manifest.json,curriculum/*.json}`, `project.yml` adds it as an
optional folder reference and those packs win over the seed for the same course id (`ContentBootstrap`).

## App layout (`Swoond/`)

| Folder | Contents |
|---|---|
| `App/` | `AppEnvironment` (dependency container: content, `FileProgressRepository` in Application Support, mock live/editorial providers, `ProgressEngine`, StoreKit, reminders, simulation host), `AppModel` (`@Observable`: people, active person, settings, learner snapshot), routes, `RootView` (onboarding -> `TabView`: Learn, Games, Talk, Live, Me) |
| `DesignSystem/` | Color tokens (dark default + light, asset-free dynamic `UIColor`), typography (Instrument Serif + Geist), spacing/radii/sizes, motion, `Haptics`, components: `Pill`, buttons (Primary/Game/Gold/Secondary), `Card`, `Eyebrow`, `SWProgressBar`, `CommonGroundRing`, `Chip`, `FlowLayout`, `SWSegmentedControl`, `ToggleRow`, `Avatar`, `BadgeTile`, `StatTile`, tab bar styling, `FeedbackPanel` |
| `Features/` | Onboarding, Home, Games (hub, shell, results, simulation screen), Exercises (one view per catalog type), Talk, Live, Playbook, League, Profile, Challenge, DailyBite, Paywall (+ hearts sheet), Settings (+ people) |
| `Unity/` | `UnitySimulationHost` (`#if canImport(UnityFramework)`) |
| `Services/` | StoreKit 2 (`PurchaseService`) and local notifications (`ReminderScheduling`) |
| `Previews/` | Seeded preview data and the embedded exercise examples |
| `Resources/` | Fonts, content seed, asset catalog (launch color, accent; add an AppIcon image) |

Person-centered: Home shows "Learning for {person}" and the Common Ground ring; Games, Talk, Live, Playbook and Profile all follow the active person.
Branches (curriculum contract 1.2) are honored: onboarding lets you pick a branch for courses that declare them, and Core filters units,
activities, reviews, Common Ground and the Playbook by `PersonInterest.branchId`.

## Native exercises

`Features/Exercises/` has one SwiftUI view per type in `docs/native-exercises/CATALOG.md`, each driven by its SwoondCore engine.
A view applies every answer to its own engine copy for instant feedback (and for the Timing marker, Talk-track flow, etc.) and forwards the
same answer to `LearningSession.submit`, which persists XP, hearts, streak and mastery. Engines are deterministic, so both copies agree.
Notable pieces:

- **timing-tap**: `TimelineView(.animation)` + `Canvas` marker (display-refresh, 120 Hz with `CADisableMinimumFrameDurationOnPhone`); positions come from
  `TimingTapEngine.markerPct`. Reduce Motion / Switch Control select the engine's `tapToStopSlow` mode. *Metal is not required; a Metal marker trail/glow
  is an optional later upgrade.*
- **talk-track**: chat UI with bubbles (max width 260, 20/20/6 radii), the Smooth meter and a serif gold coach note.
- **binary-call / hotspot-tap**: `Canvas` court and field diagrams (`DiagramBackground`), shape-coded markers (ring / dot / disc).
- **sequence-order**: drag and drop plus Move up/down buttons and VoiceOver actions. **visual-id / listening-id**: bundled assets are looked up in the
  content packs (`AssetLocator`); missing assets show a placeholder and listening has a no-penalty Skip.
- Accessibility: Dynamic Type via `relativeTo:` fonts, VoiceOver labels on every control, 44 pt targets, Reduce Motion cross-fades, correctness
  never conveyed by color alone (icon + title + text).

## Unity host seam

`SimulationHostFactory.default` returns `UnitySimulationHost` when `UnityFramework` links, else `MockSimulationHost` and a full-screen "Simulation
coming soon" placeholder that still shows the lesson objective and launch configuration, with a no-penalty Skip (and a DEBUG "Run mock simulation" that
exercises the result pipeline). The host follows `docs/contracts/unity-bridge/v1/README.md`: lazy load, `launch` -> `ready` (8 s) -> `result` -> `requestExit`
-> unload, native `abort` timers (3 s / 5 s), `sendMessageToGO("SwoondBridge", "Receive", json)` out and `NativeCallProxy` in. Two names to agree with Astra:
the scene GameObject `SwoondBridge` (`Receive(string)`) and `NativeCallsProtocol.onUnityMessage:`. To enable, add `UnityFramework.framework` under the target
dependencies in `project.yml` (commented example there).

## Fonts

Instrument Serif (Regular, Italic) and Geist (one variable font, weights via `wght`) are SIL OFL 1.1 and downloaded from `github.com/google/fonts` into
`Swoond/Resources/Fonts/` with their license files (`OFL-*.txt`); they are registered through `UIAppFonts`. `SWFont` falls back to the system serif/sans
(scaled with `UIFontMetrics`) only if a font fails to register. Needs Mac verification: that `Font.custom("Geist", ...).weight(...)` selects the variable-font weights as
intended on device (if not, switch to the named instances "Geist-Medium"/"Geist-SemiBold").

## Status

Done: everything listed above. Stubs: StoreKit product ids are placeholders (paywall shows placeholder prices, purchase reports "not set up yet"); live
scores and Daily Bites come from mock providers; league rivals and the friend challenge are canned; the Daily Bite photo is a placeholder; no app icon image;
Unity needs Astra's framework. **All SwiftUI code is unverified on a Mac** (no Xcode in the cloud container); Core logic and the app view models are
type-checked and tested on Linux.
