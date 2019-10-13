//
//  AppDelegate.swift
//  RSSNews
//
//  Created by Александр Дергилёв on 11/10/2019.
//  Copyright © 2019 Александр Дергилёв. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        let nc = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nc
        
        return true
    }
}

