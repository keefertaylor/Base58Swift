// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Base58Swift",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "Base58Swift",
            targets: ["Base58Swift"])
    ],
    dependencies: [
      .package(url: "https://github.com/attaswift/BigInt.git", from: "5.0.0"),
      .package(url: "https://github.com/apple/swift-crypto.git", from: "3.0.0"),
    ],
    targets: [
        .target(
            name: "Base58Swift",
            dependencies: [
                "BigInt",
                .product(name: "Crypto", package: "swift-crypto")
            ],
            path: "Base58Swift"),
        .testTarget(
            name: "base58swiftTests",
            dependencies: ["Base58Swift"],
            path: "Base58SwiftTests")
    ]
)
