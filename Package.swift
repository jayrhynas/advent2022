// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "advent2022",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0")
    ],
    targets: [
        .executableTarget(
            name: "day8",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: ["inputs"]),
    ]
)
