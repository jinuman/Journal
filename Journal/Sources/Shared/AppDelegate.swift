//
//  AppDelegate.swift
//  Journal
//
//  Created by 김진우 on 2018. 8. 13..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.navigationBar.prefersLargeTitles = true
            navigationController.navigationBar.barStyle = UIBarStyle.black
            navigationController.navigationBar.barTintColor = UIColor.brown
        }
        
        return true
    }
}

