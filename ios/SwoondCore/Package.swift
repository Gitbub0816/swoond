// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SwoondCore",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "SwoondCore", targets: ["SwoondCore"]),
    ],
    targets: [
        .target(name: "SwoondCore"),
        .testTarget(name: "SwoondCoreTests", dependencies: ["SwoondCore"]),
    ],
    swiftLanguageModes: [.v6]
)
