// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Yada",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v14),
    ],
    products: [
        .library(
            name: "Core",
            targets: ["Core"]
        ),
        .library(
            name: "Services",
            targets: ["Services"]
        ),
    ],
    dependencies: [
        .package(name: "Firebase", url: "https://github.com/firebase/firebase-ios-sdk.git", from: "8.10.0"),
        .package(name: "CombineExpectations", url: "https://github.com/groue/CombineExpectations", from: "0.6.0"),
        .package(name: "swift-composable-architecture", url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.33.1")
    ],
    targets: [
        .target(
            name: "Core",
            dependencies: [.product(name: "ComposableArchitecture", package: "swift-composable-architecture")]
        ),
        .target(
            name: "Services",
            dependencies: [
                "Core",
                .product(name: "FirebaseAuth", package: "Firebase"),
            ]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["Core", .product(name: "CombineExpectations", package: "CombineExpectations")]
        ),
    ]
)
