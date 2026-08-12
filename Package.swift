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
            url: "https://github.com/swift-precompiled/jwt-kit/releases/download/4.13.5/CJWTKitBoringSSL-26b0d98d8ca2804ceeecea25983cb10f9a8ed77a8818af817072a84ff1ae49c7.xcframework.zip",
            checksum: "26b0d98d8ca2804ceeecea25983cb10f9a8ed77a8818af817072a84ff1ae49c7"
        ),
        .target(
            name: "JWTKit_Aggregation",
            dependencies: ["JWTKit"],
            packageAccess: false,
            swiftSettings: [.define("SCIPIO_PRECOMPILED_BINARY_WRAPPER")]
        ),
        .binaryTarget(
            name: "JWTKit",
            url: "https://github.com/swift-precompiled/jwt-kit/releases/download/4.13.5/JWTKit-15473e9fde3b083475919b5502a9ec6015bdc4a7c6b07c3e688f4153a4f020c5.xcframework.zip",
            checksum: "15473e9fde3b083475919b5502a9ec6015bdc4a7c6b07c3e688f4153a4f020c5"
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