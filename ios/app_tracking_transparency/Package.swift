// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "app_tracking_transparency",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(
            name: "app-tracking-transparency",
            targets: ["app_tracking_transparency"]
        )
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "app_tracking_transparency",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework")
            ],
            path: "Sources/app_tracking_transparency",
            resources: [
                .process("PrivacyInfo.xcprivacy")
            ]
        )
    ]
)
