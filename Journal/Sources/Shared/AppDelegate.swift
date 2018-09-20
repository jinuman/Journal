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
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        customizeNavigationBar()
        injectEnvironment()
        
        return true
    }
    
    private func customizeNavigationBar() {
        if let navViewController = window?.rootViewController as? UINavigationController {
            navViewController.navigationBar.prefersLargeTitles = true
            navViewController.navigationBar.barStyle = UIBarStyle.black
            navViewController.navigationBar.tintColor = UIColor.white    // 버튼색 변경
            
            let bgImage = UIImage.gradientImage(with: [.gradientStart, .gradientEnd],
                                                size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
            navViewController.navigationBar.barTintColor = UIColor(patternImage: bgImage!)
        }
    }
    
    private func injectEnvironment() {
        guard
            let navViewController = window?.rootViewController as? UINavigationController,
            let timelineViewController = navViewController.topViewController as? TimelineViewController
            else { return }
        let repo = InMemoryEntryRepository(entries: [])
        timelineViewController.environment = Environment(entryRepository: repo)
    }
    
}

