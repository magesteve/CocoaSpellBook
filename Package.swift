// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CocoaSpellBook",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "CocoaSpellBook",
            targets: ["CocoaSpellBook"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "CocoaSpellBook",
            dependencies: []),
        .testTarget(
            name: "CocoaSpellBookTests",
            dependencies: ["CocoaSpellBook"]),
    ]
)
