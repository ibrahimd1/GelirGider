//
//  AppDelegate.swift
//  GelirGiderApp
//
//  Created by İbrahim Darakçılar on 29.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        app.router.start()        
        return true
    }
}

