import ProjectDescription
import ProjectDescriptionHelpers
let infoPlist: [String: InfoPlist.Value] = [
    "UILaunchScreen": [:]
]
let project = Project(
    name: "MainApp",
    organizationName: "com.mqch",
    targets: [
        Target(
            name: "Main",
            platform: .iOS,
            product: .app,
            productName: "主APP",
            bundleId: "com.mqch.baseproject.main",
            deploymentTarget: DeploymentTarget.iOS(targetVersion: "10.0", devices: DeploymentDevice.iphone),
            infoPlist: .extendingDefault(with: infoPlist),
            sources: ["Source/**"],
            resources: ["Resource/**"],
            dependencies: [
                .netkit
            ]
        )
    ],
    schemes: [
        Scheme(name: "debug"),
        Scheme(name: "uat"),
        Scheme(name: "reales")
    ]
)
