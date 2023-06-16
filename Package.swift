// swift-tools-version: 5.9

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "JSON",
    platforms: [
      .iOS("13.0"),
      .macOS("10.15")
    ],
    products: [
        .library(
            name: "JSON",
            targets: ["JSON"]),
    ],
    dependencies: [
      .package(url: "https://github.com/apple/swift-syntax.git", branch: "main"),
    ],
    targets: [

        .target(
            name: "JSON",
            dependencies: ["JSONMacros"]),

        .testTarget(
            name: "JSONTests",
            dependencies: ["JSON"]),

        .target(
            name: "JSONMacros",
            dependencies: ["JSONMacrosPlugin"]),

        .macro(
            name: "JSONMacrosPlugin",
            dependencies: [
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
                .product(name: "SwiftSyntax", package: "swift-syntax"),
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            ]
        ),
    ]
)
