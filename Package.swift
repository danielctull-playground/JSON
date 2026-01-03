// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "JSON",
  products: [
    .library(
      name: "JSON",
      targets: ["JSON"]
    )
  ],
  targets: [
    .target(
      name: "JSON"
    ),
    .testTarget(
      name: "JSONTests",
      dependencies: ["JSON"]
    ),
  ]
)
