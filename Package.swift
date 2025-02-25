// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ccPositionManager",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "ccPositionManager",
            targets: ["ccPositionManager"]),
    ],
    // dependencies: [
    //     // .package(name: "Testing", url: "https://github.com/your-repo/Testing.git", from: "1.0.0")
    //     .package(url: "https://github.com/swiftlang/swift-testing.git", branch: "main")
    // ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "ccPositionManager"),
        // .testTarget(
        //     name: "ccPositionManagerTests",
        //     dependencies: ["ccPositionManager"],
        //     .product(name: "Testing", package: "swift-testing")
        // ),
    ],
    swiftLanguageVersions: [.v5]

)
