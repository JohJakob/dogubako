// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "dogubako",
    platforms: [
        .macOS(.v12),
        .iOS(.v15),
        .watchOS(.v4),
        .tvOS(.v12),
        .visionOS(.v1)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "dogubako",
            targets: ["dogubako"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "dogubako"),
        .testTarget(
            name: "dogubakoTests",
            dependencies: ["dogubako"]
        ),
    ]
)
