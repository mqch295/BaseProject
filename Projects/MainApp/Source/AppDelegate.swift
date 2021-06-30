//
//  AppDelegate.swift
//  Main
//
//  Created by Mqch on 2021/6/30.
//  Copyright © 2021 com.mqch. All rights reserved.
//

import UIKit
import BPNetKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVc = UIViewController()
        rootVc.view.backgroundColor = .white
        rootVc.title = "Main"
        let root = UINavigationController(rootViewController: rootVc)
        window?.rootViewController = root
        window?.makeKeyAndVisible()
        return true
    }
}
extension AppDelegate {
    func setupConfig(){
        BPNetConfig.shared.authType = .bearer
        BPNetConfig.shared.defaultHeaders = ["ver": "1.0.0"]
        BPNetConfig.shared.defaultTimeOut = 30.0
        BPNetConfig.shared.logCloure = { msgs in
            print(msgs)
        }
        BPNetConfig.shared.tokenCloure = {
            return "123456"
        }
    }
}
