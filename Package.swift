// swift-tools-version:5.9.0

import PackageDescription
import Foundation

let package = Package(
    name: "jwt-kit",
    platforms: [
        .macOS("10.15"),
        .iOS("13.0"),
        .tvOS("13.0"),
        .watchOS("6.0")
    ],
    products: [
        .library(
            name: "JWTKit",
            targets: [
                "JWTKit",
                "CJWTKitBoringSSL",
                "JWTKit_PrecompiledProduct"
            ]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-precompiled/swift-crypto",
            exact: "3.15.1"
        )
    ],
    targets: [
        .binaryTarget(
            name: "CJWTKitBoringSSL",
            url: "https://github.com/swift-precompiled/jwt-kit/releases/download/4.13.5/CJWTKitBoringSSL-cfa902eee48a4790ba730a1a668561020640ebda798a2041dacc8ac35c15af85.xcframework.zip",
            checksum: "cfa902eee48a4790ba730a1a668561020640ebda798a2041dacc8ac35c15af85"
        ),
        .target(
            name: "JWTKit_Aggregation",
            dependencies: ["JWTKit"],
            packageAccess: false,
            swiftSettings: [.define("SCIPIO_PRECOMPILED_BINARY_WRAPPER")]
        ),
        .binaryTarget(
            name: "JWTKit",
            url: "https://github.com/swift-precompiled/jwt-kit/releases/download/4.13.5/JWTKit-bb530786dd271d2f70df4b7b0676c6339a8e5afc93f837caebbd591c8b579db9.xcframework.zip",
            checksum: "bb530786dd271d2f70df4b7b0676c6339a8e5afc93f837caebbd591c8b579db9"
        ),
        .target(
            name: "JWTKit_PrecompiledProduct",
            dependencies: [
                "JWTKit_Aggregation",
                .product(
                    name: "Crypto",
                    package: "swift-crypto"
                ),
                "CJWTKitBoringSSL"
            ],
            packageAccess: false
        )
    ],
    cxxLanguageStandard: .cxx11
)