# SwoondCore

Platform-independent Swift core for the Swoon'd iOS app (D-001). Foundation-only (no SwiftUI/UIKit/Combine), no third-party dependencies, Swift 6 language mode with strict concurrency, `swift-tools-version: 6.0`, platforms iOS 18 / macOS 15. Builds and tests on Linux.

```
swift build
swift test          # swift-testing, ~226 tests
```

One library product, `SwoondCore`, organized by folder (`Sources/SwoondCore/`):

| Folder | Contents |
|---|---|
| `Domain/` | `Person`, `PersonInterest`, `Relationship`, `LearnerProfile`, `AccessibilityPreferences`; `Curriculum`/`Unit`/`Lesson`/`Activity`/`Concept`/`TalkTrack`/`ReviewPolicy` (mirror curriculum v1); `CourseManifest` (mirror course-manifest v1); `JSONValue` (lossless schema-open JSON) |
| `Bridge/` | `LaunchRequest`, `SimulationResult`, `BridgeEvent` envelope + payload types (mirror unity-bridge v1); `SimulationHost` protocol, `MockSimulationHost`; `SimulationResultMapper` (validates and clamps a Unity result, D-009) |
| `Exercises/` | Payload Codables and a pure state machine per native type (`MultipleChoiceEngine`, `BinaryCallEngine`, `TermMatchEngine`, `SequenceOrderEngine`, `VisualIDEngine`, `DecisionScenarioEngine`, `TalkTrackEngine`, `TimingTapEngine`, `SayThisEngine`, `FillTheGapEngine`, `ListeningIDEngine`, `EstimateSliderEngine`, `HotspotTapEngine`); `ExerciseSession` protocol, `ExerciseAnswer`, `ExerciseEvaluation`, `ExerciseSessionFactory` |
| `Progress/` | `Clock` (+ `SystemClock`, `FixedClock`, `ManualClock`), `ProgressRules`, `DayKey`, `LearnerState` (XP, level, hearts, streak, weekly XP), `CourseMastery` (mastery + Leitner + decay), `ExerciseOutcome`, `ProgressEngine` (actor), `CommonGround`, `League` |
| `Content/` | `ContentRepository`, `BundledContentRepository` (loads `<root>/<courseId>/manifest.json` + `curriculum/*.json`), `StaticContentRepository`, `ContentValidator`, `PersonalizationResolver` |
| `Repositories/` | `ProgressRepository` / `PersonRepository` protocols; in-memory and JSON-file implementations (atomic writes) |
| `Providers/` | `LiveDataProvider` + normalized `Fixture`/`Standings`/`LiveContext` + `MockLiveDataProvider`; `EditorialProvider` + `DailyBite` + `MockEditorialProvider` |
| `Session/` | `LessonPlanner` (pure), `LearningSession` (actor): today's plan, run activities, apply native and Unity results, finish |

## How the pieces connect

```
Content JSON -> BundledContentRepository -> Curriculum
Activity --ExerciseSessionFactory--> ExerciseSession --submit(ExerciseAnswer)--> ExerciseEvaluation --.outcome()--> ExerciseOutcome
Unity SimulationResult --SimulationResultMapper (clamp)--> ExerciseOutcome
ExerciseOutcome --ProgressEngine.apply--> XP / streak / hearts / mastery / Leitner --ProgressRepository
LearningSession wires all of the above for one Person + interest.
```

## Conventions

- All time comes from an injected `Clock`; streak/week/day logic takes an injected `TimeZone` and works on `DayKey` (calendar days, DST-safe).
- Engines are value types: hold one in view state and call `submit`. Timing-tap takes elapsed seconds or a marker position; no timers inside Core.
- Contract types decode exactly the JSON in `docs/contracts/**` (tests re-encode typed models and compare with the authored examples). Unknown JSON keys are ignored.
- Nothing here re-implements a Unity sim: the app only validates and applies `SimulationResult`s.

## Tests

`Tests/SwoondCoreTests` loads every JSON file under `docs/contracts/unity-bridge/v1/examples` and `docs/contracts/native-exercises/v1/examples`, plus the curriculum and manifest samples, via paths relative to `#filePath` (so run `swift test` from a full repo checkout).
