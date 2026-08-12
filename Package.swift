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
            url: "https://github.com/swift-precompiled/jwt-kit/releases/download/4.13.5/CJWTKitBoringSSL-2eab8b8a1c2aae437b09ac23b47cfaa2365784f83b3c8b942cda8f36904c4a70.xcframework.zip",
            checksum: "2eab8b8a1c2aae437b09ac23b47cfaa2365784f83b3c8b942cda8f36904c4a70"
        ),
        .target(
            name: "JWTKit_Aggregation",
            dependencies: ["JWTKit"],
            swiftSettings: [.define("SCIPIO_PRECOMPILED_BINARY_WRAPPER")]
        ),
        .binaryTarget(
            name: "JWTKit",
            url: "https://github.com/swift-precompiled/jwt-kit/releases/download/4.13.5/JWTKit-b82f9702ae926caf4dd04b2f867d3c419d69b3e69e215bf0cecce16ba940ec99.xcframework.zip",
            checksum: "b82f9702ae926caf4dd04b2f867d3c419d69b3e69e215bf0cecce16ba940ec99"
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
            ]
        )
    ],
    cxxLanguageStandard: .cxx11
)