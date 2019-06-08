//
//  AppDelegate.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 创建 tabBar 实例
        let firstTab = FirstTab()
        let secondTab = SecondTab()
        let thirdTab = ThirdTab()
        let forthTab = ForthTab()
        
        // 创建导航控制器
        let firstNav = UINavigationController(rootViewController: firstTab)
        let secondNav = UINavigationController(rootViewController: secondTab)
        let thirdNav = UINavigationController(rootViewController: thirdTab)
        let forthNav = UINavigationController(rootViewController: forthTab)
        
        // 设置tabBar各图标
        firstTab.tabBarItem.image = UIImage(named: "tab-discovery")
        secondTab.tabBarItem.image = UIImage(named: "tab-saved")
        thirdTab.tabBarItem.image = UIImage(named: "tab-tickets")
        forthTab.tabBarItem.image = UIImage(named: "tab-mine")
        
        // 设置tatabBar各标题
        firstTab.tabBarItem.title = "基本元素"
        secondTab.tabBarItem.title = "未知"
        thirdTab.tabBarItem.title = "待定"
        forthTab.tabBarItem.title = "试验区"
        
        // 把tabBar实例添加到UITabBarController，并设置样式
        let tabBar = UITabBarController()
        tabBar.viewControllers = [firstNav, secondNav, thirdNav, forthNav]
        tabBar.tabBar.isTranslucent = false
        tabBar.tabBar.barTintColor = UIColor.white
        tabBar.tabBar.shadowImage = getImageWithColor(color: "f5f6f8")
        
        // 将window的一级页面设置为tabBar
        self.window?.rootViewController = tabBar
        self.window?.backgroundColor = UIColor.white
        
        // 设置启动时显示的tab
        tabBar.selectedIndex = 0
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

