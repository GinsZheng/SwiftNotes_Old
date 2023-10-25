//
//  AppDelegate.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/8.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let tabBarController = TabBarController.getTabBar()
        // 将window的一级页面设置为tabBar
        self.window?.rootViewController = tabBarController

        ItemTable().getTable()
        ProgressTable().getTable()
        ReloadDataTable().getTable()
        
        //是否第一次启动（两个都是第一次则以这个为准）
        if UserDefaults.isFirstLaunch() {
            print("应用第一次启动")
        } else {
            print("非也")
        }
        
        //当前版本是否第一次启动
        if UserDefaults.isFirstLaunchOfNewVersion() {
            print("当前版本第一次启动")
        } else {
            print("非也")
        }
        
        // MARK: - 设置长按图标出现快捷功能列表
        // 创建一个快捷功能项
        let shortcutItem = UIApplicationShortcutItem(type: "com.example.myapp.shortcut", localizedTitle: "快捷功能", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(systemImageName: "star.fill"), userInfo: nil)
        
        // 将快捷功能项添加到应用程序的快捷功能列表中
        application.shortcutItems = [shortcutItem]
        
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

