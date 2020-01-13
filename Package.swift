// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BinarySwift",
    platforms: [
        .macOS("10.9"),
        .iOS("8.0"),
    ],
    products: [
        .library(name: "BinarySwift", targets: ["BinarySwift"]),
    ],
    targets: [
        .target(name: "BinarySwift", dependencies: []),
        .testTarget(name: "BinarySwiftTests", dependencies: ["BinarySwift"]),
    ]
)
