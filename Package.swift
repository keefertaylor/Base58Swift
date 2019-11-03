// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Base58Swift",
    products: [
        .library(
            name: "Base58Swift",
            targets: ["Base58Swift"])
    ],
    dependencies: [
      .package(url: "https://github.com/attaswift/BigInt.git", from: "3.1.0")
    ],
    targets: [
        .target(
            name: "Base58Swift",
            dependencies: ["BigInt"],
            path: "Base58Swift"),
        .testTarget(
            name: "base58swiftTests",
            dependencies: ["Base58Swift"],
            path: "Base58SwiftTests")
    ]
)
