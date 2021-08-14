// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChainAgnostic",
    products: [
        .library(
            name: "ChainAgnostic",
            targets: ["ChainAgnostic"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ChainAgnostic",
            dependencies: []),
        .testTarget(
            name: "ChainAgnosticTests",
            dependencies: ["ChainAgnostic"]),
    ]
)
