/////
////  plugin.swift
///   Copyright © 2024 Dmitriy Borovikov. All rights reserved.
//

import PackagePlugin
import Foundation

@main
struct PackageBuildInfoPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) throws -> [Command] {
        guard let target = target as? SourceModuleTarget else {
            print("Target is \(String(describing: target.self))")
            return []
        }
        let outputFileURL = context.pluginWorkDirectoryURL.appending(path: "packageBuildInfo.swift")

        let command: Command = .prebuildCommand(
            displayName:
                "Generating \(outputFileURL.lastPathComponent) for \(target.directoryURL)",
            executable:
                try context.tool(named: "PackageBuildInfo").url,
            arguments: [ "\(target.directoryURL.path(percentEncoded: false))", "\(outputFileURL.path(percentEncoded: false))" ],
            outputFilesDirectory: context.pluginWorkDirectoryURL
        )
        return [command]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin
extension PackageBuildInfoPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodeProjectPlugin.XcodePluginContext, target: XcodeProjectPlugin.XcodeTarget) throws -> [PackagePlugin.Command] {
        let outputFileURL = context.pluginWorkDirectoryURL.appending(path: "packageBuildInfo.swift")
        let command: Command = .prebuildCommand(
            displayName:
                "Generating \(outputFileURL.lastPathComponent) for \(context.xcodeProject.directoryURL)",
            executable:
                try context.tool(named: "PackageBuildInfo").url,
            arguments: [ "\(context.xcodeProject.directoryURL.path(percentEncoded: false))", "\(outputFileURL.path(percentEncoded: false))" ],
            outputFilesDirectory: context.pluginWorkDirectoryURL
        )
        return [command]
    }
}
#endif

