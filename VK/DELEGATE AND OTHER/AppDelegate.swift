//
//  AppDelegate.swift
//  VK
//
//  Created by Алексей Россошанский on 08.10.17.
//  Copyright © 2017 Алексей Россошанский. All rights reserved.
//

import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let app = options[.sourceApplication] as? String
        VKSdk.processOpen(url, fromApplication: app)
        
        return true
    }

}

