//
//  TargetDependencyExtension.swift
//  ProjectDescriptionHelpers
//
//  Created by Mqch on 2021/6/30.
//

import Foundation
import ProjectDescription

// MARK: Project
public extension TargetDependency {
  static let netkit: TargetDependency = .project(target: "BPNetKit",
                                                             path: .relativeToRoot("Depences/BPNetKit/"))
}
