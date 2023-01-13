// swift-tools-version: 5.7

import PackageDescription

let excludes = ["inputs", "README.md"]

let package = Package(
    name: "advent2022",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.2.0"),
        .package(url: "https://github.com/pointfreeco/swift-parsing", from: "0.11.0")
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
            exclude: excludes),
        .executableTarget(
            name: "day2",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day3",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day4",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day5",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Parsing", package: "swift-parsing")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day6",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day7",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Parsing", package: "swift-parsing")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day8",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day9",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Parsing", package: "swift-parsing")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day10",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Parsing", package: "swift-parsing")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day11",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Parsing", package: "swift-parsing")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day12",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day13",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Parsing", package: "swift-parsing")
            ],
            exclude: excludes),
        .executableTarget(
            name: "day14",
            dependencies: [
                "Util",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Parsing", package: "swift-parsing")
            ],
            exclude: excludes),
        // <#day#>
    ]
)
