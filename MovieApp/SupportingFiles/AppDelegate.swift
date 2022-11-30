//
//  AppDelegate.swift
//  MovieApp
//
//  Created by Indra Permana on 26/11/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.backgroundColor = .white
        window?.rootViewController = HomeRouter.createModule()
        window?.makeKeyAndVisible()
        
        return true
    }
}

