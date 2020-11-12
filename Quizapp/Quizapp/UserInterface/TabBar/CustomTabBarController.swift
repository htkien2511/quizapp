//
//  CustomTabBarController.swift
//  Quizapp
//
//  Created by Hoang Trong Kien on 11/7/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var homeViewController = UINavigationController(rootViewController: HomeViewController())
    var historyViewController = UINavigationController(rootViewController: HistoryViewController())
    var accountViewController = UINavigationController(rootViewController: AccountViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTabBar()
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Futura-CondensedMedium", size: 10)!], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Futura-CondensedMedium", size: 10)!], for: .selected)
    }
    
    func setUpTabBar() {
        homeViewController.tabBarItem = UITabBarItem(title: "Trang chủ",
                                                     image: UIImage(named: "icons8-quiz-65"),
                                                     tag: 0)
        
        historyViewController.tabBarItem = UITabBarItem(title: "Lịch sử",
                                                        image: UIImage(named: "icons8-test-65"),
                                                        tag: 0)
        accountViewController.tabBarItem = UITabBarItem(title: "Tài khoản",
                                                        image: UIImage(named: "icons8-services-65"),
                                                        tag: 0)
        
        self.delegate = self
        
        viewControllers = [homeViewController, historyViewController, accountViewController]
    }
}
