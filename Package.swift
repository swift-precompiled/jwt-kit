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
            targets: ["JWTKit_PrecompiledProduct"]
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
            url: "https://github.com/swift-precompiled/jwt-kit/releases/download/4.13.5/CJWTKitBoringSSL-20eaba5bec79da2174f1aca7d33ccfa19d5b6c4cd9cba86c1272296b75d3e601.xcframework.zip",
            checksum: "20eaba5bec79da2174f1aca7d33ccfa19d5b6c4cd9cba86c1272296b75d3e601"
        ),
        .target(
            name: "JWTKit_Aggregation",
            dependencies: ["JWTKit"],
            swiftSettings: [.define("SCIPIO_PRECOMPILED_BINARY_WRAPPER")]
        ),
        .binaryTarget(
            name: "JWTKit",
            url: "https://github.com/swift-precompiled/jwt-kit/releases/download/4.13.5/JWTKit-647fefdfea19e79617b8a30ceaa843470a7d5a57669b2eab04c194fa8d6c0aaa.xcframework.zip",
            checksum: "647fefdfea19e79617b8a30ceaa843470a7d5a57669b2eab04c194fa8d6c0aaa"
        ),
        .target(
            name: "JWTKit_PrecompiledProduct",
            dependencies: [
                "JWTKit_Aggregation",
                "CJWTKitBoringSSL",
                .product(
                    name: "Crypto",
                    package: "swift-crypto"
                )
            ]
        )
    ],
    cxxLanguageStandard: .cxx11
)