// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "advent2022",
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0")
    ],
    targets: [
        .target(
            name: "Util", 
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .executableTarget(
            name: "day1",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: ["inputs", "README.md"]),
        .executableTarget(
            name: "day8",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: ["inputs"]),
    ]
)
