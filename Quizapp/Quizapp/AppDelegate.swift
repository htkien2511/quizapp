//
//  AppDelegate.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/7/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let defaults = UserDefaults.standard
        if let _ = defaults.value(forKey: "idUser") as? String {
            initHomeApp()
        }
        else {
            initStartApp()
        }
        return true
    }
    
    func initStartApp() {
        let vc = LoginViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = window {
            UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: {
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }, completion: nil)
        }
    }
    
    func initHomeApp() {
        let vc = CustomTabBarController()
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        if let window = window {
            UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: {
                window.rootViewController = nav
                window.makeKeyAndVisible()
            }, completion: nil)
        }
    }
}

