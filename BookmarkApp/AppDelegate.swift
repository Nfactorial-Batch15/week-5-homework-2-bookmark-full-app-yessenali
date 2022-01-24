//
//  AppDelegate.swift
//  BookmarkApp
//
//  Created by Yessenali Zhanaidar on 17.01.2022.
//

import UIKit

@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        

        
        window?.rootViewController = UINavigationController(rootViewController: FirstViewController())

        return true
    }

   


}

