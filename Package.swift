// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OneWayBenchmark",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "OneWayBenchmark",
            targets: ["OneWayBenchmark"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/DevYeom/OneWay", from: "0.4.0"),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.0.0"),
        .package(url: "https://github.com/ReSwift/ReSwift.git", from: "6.0.0"),
        .package(url: "https://github.com/spotify/Mobius.swift.git", from: "0.5.0"),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "0.37.0"),
    ],
    targets: [
        .target(
            name: "OneWayBenchmark",
            dependencies: []
        ),
        .testTarget(
            name: "OneWayBenchmarkTests",
            dependencies: [
                "OneWay",
                "ReactorKit",
                "ReSwift",
                .product(name: "MobiusCore", package: "Mobius.swift"),
                .product(name: "MobiusExtras", package: "Mobius.swift"),
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
    ]
)
