import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
    name: "BPNetKit",
    organizationName: "com.mqch",
    packages: [
        Package.package(url: "https://github.com/mqch295/Moya", Package.Requirement.branch("master"))
    ],
    targets: [
        Target(
            name: "BPNetKit",
            platform: .iOS,
            product: .framework,
            bundleId: "com.mqch.bpnetkit",
            deploymentTarget: .iOS(targetVersion: "10.0", devices: .iphone),
            infoPlist: .default,
            sources: ["Sources/**"],
            dependencies: [
                .package(product: "RxMoya")
            ]
        )
    ]
)
