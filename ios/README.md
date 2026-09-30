# ios/

Native iOS work for Swoon'd (Claude Code owns this; see `CLAUDE.md` section 3).

| Path | What | Verified where |
|---|---|---|
| `SwoondCore/` | Swift package: all platform-independent logic (domain, content, progression, native exercise engines, Unity bridge types, repositories, providers, learning session). Foundation-only. | `cd SwoondCore && swift test` (Linux or macOS) |
| `SwoondApp/` | (not created yet) Xcode project: SwiftUI views, design system, Unity host, on-device persistence. Depends on `SwoondCore`. | Xcode 27 on a Mac |

Rule of thumb: if it does not need UIKit/SwiftUI/UnityFramework, it belongs in `SwoondCore`, where it is unit-tested on Linux.

Toolchain: Swift 6 language mode, `swift-tools-version: 6.0`, iOS 18 / macOS 15 deployment targets.
