// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "PackageBuildInfo",
    products: [
        .plugin(name: "PackageBuildInfoPlugin", targets: ["PackageBuildInfoPlugin"]),
    ],
    targets: [
        .plugin(
            name: "PackageBuildInfoPlugin",
            capability: .command(
	      intent: .custom(verb: "generate-version", description: "Generates git version info")
//	      intent: .sourceCodeFormatting(),
//                 permissions: [
//                     .writeToPackageDirectory(reason: "Generates git version info")
//                 ]
            ),
            dependencies: ["PackageBuildInfo"]
        ),
        .binaryTarget(name: "PackageBuildInfo", path: "Binaries/PackageBuildInfo.artifactbundle"),
    ]
)
