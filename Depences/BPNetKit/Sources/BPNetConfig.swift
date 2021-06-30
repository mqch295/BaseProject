//
//  BPNetConfig.swift
//  BPNetKit
//
//  Created by Mqch on 2021/6/30.
//  Copyright © 2021 com.mqch. All rights reserved.
//
import Foundation
import Moya
public class BPNetConfig {
    public static let shared = BPNetConfig()
    public var defaultHeaders: [String: String] = [:]
    public var authType: BFNetAuthType = .bearer
    public var defaultTimeOut: TimeInterval = 10.0
    public typealias LogCloure = (_ msgs: [String]) -> Void
    public typealias TokenCloure = () -> String
    public var logCloure: LogCloure = { (msgs: [String]) in
        print(msgs.joined(separator: "\n"))
    }
    public var tokenCloure: TokenCloure = { "" }
    var plugins: [PluginType] {
        let logPlugin: NetworkLoggerPlugin = NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(output: { _, infos in
            self.logCloure(infos)
        }, logOptions: .verbose))
        let tokenPlugin: AccessTokenPlugin = AccessTokenPlugin { _ in
            return self.tokenCloure()
        }
        return [logPlugin, tokenPlugin]
    }
    private init() { }
}
