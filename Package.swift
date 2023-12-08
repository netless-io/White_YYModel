// swift-tools-version:5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "White_YYModel",
    products: [
        .library(name: "White_YYModel",
                 targets: ["White_YYModel"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "White_YYModel",
            dependencies: [],
            path: "White_YYModel",
            publicHeadersPath: ".",
            cSettings: [.headerSearchPath(".")])
    ]
)
