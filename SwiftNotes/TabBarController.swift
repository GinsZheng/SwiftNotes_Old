//
//  TabBarController.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/2/24.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import ESTabBarController
import pop

class TabBarController {

    static func getTabBar() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        let v1 = ViewTab()
        let v2 = ControllerTab()
        let v3 = ModelTab()
        let v4 = TestTab()
        
        v1.tabBarItem = ESTabBarItem.init(title: "View", image: UIImage(named: "tab_discovery"), selectedImage: UIImage(named: "tab_discovery_s"))
        v2.tabBarItem = ESTabBarItem.init(title: "Controller", image: UIImage(named: "tab_saved"), selectedImage: UIImage(named: "tab_saved_s"))
        v3.tabBarItem = ESTabBarItem.init(title: "Model", image: UIImage(named: "tab_tickets"), selectedImage: UIImage(named: "tab_tickets_s"))
        v4.tabBarItem = ESTabBarItem.init(title: "Test", image: UIImage(named: "tab_mine"), selectedImage: UIImage(named: "tab_mine_s"))
        
        tabBarController.tabBar.shadowImage = nil
        
        let v1Nav = rootNavController(rootViewController: v1)
        let v2Nav = rootNavController(rootViewController: v2)
        let v3Nav = rootNavController(rootViewController: v3)
        let v4Nav = rootNavController(rootViewController: v4)
        
        tabBarController.viewControllers = [v1Nav, v2Nav, v3Nav, v4Nav]
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = UIColor.white
        tabBarController.tabBar.shadowImage = getImageWithColor(color: cF5F6F8)
        
        let tabShadow = UIImageView()
        tabShadow.set(superview: tabBarController.tabBar, imageName: "tab_shadow")
        tabShadow.setFrame(left: 0, top: -10, right: 0, height: 10)
        // 标签栏为49pt高，49pt之上加1px分隔线。所以：
        // 如果想遮住标签栏，应当把标签栏实际高度设置为50pt
        
        // 设置启动时显示的tab
        tabBarController.selectedIndex = 0
        
        return tabBarController
        
    }
    
    static func getTabBarWithButton() -> ESTabBarController {
        let tabBarController = ESTabBarController()
        let v1 = ViewTab()
        let v2 = ControllerTab()
        let v3 = ModelTab()
        let v4 = TestTab()
        
        v1.tabBarItem = ESTabBarItem.init(title: "View", image: UIImage(named: "tab_discovery"), selectedImage: UIImage(named: "tab_discovery_s"))
        v2.tabBarItem = ESTabBarItem.init(title: "Controller", image: UIImage(named: "tab_saved"), selectedImage: UIImage(named: "tab_saved_s"))
        v3.tabBarItem = ESTabBarItem.init(title: "Model", image: UIImage(named: "tab_tickets"), selectedImage: UIImage(named: "tab_tickets_s"))
        v4.tabBarItem = ESTabBarItem.init(title: "Test", image: UIImage(named: "tab_mine"), selectedImage: UIImage(named: "tab_mine_s"))
        
        tabBarController.tabBar.shadowImage = nil
        
        let v1Nav = rootNavController(rootViewController: v1)
        let v2Nav = rootNavController(rootViewController: v2)
        let v3Nav = rootNavController(rootViewController: v3)
        let v4Nav = rootNavController(rootViewController: v4)
        
        tabBarController.viewControllers = [v1Nav, v2Nav, v3Nav, v4Nav]
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = UIColor.white
        tabBarController.tabBar.shadowImage = getImageWithColor(color: cF5F6F8)
        
        let tabShadow = UIImageView()
        tabShadow.set(superview: tabBarController.tabBar, imageName: "tab_shadow")
        tabShadow.setFrame(left: 0, top: -10, right: 0, height: 10)
        // 标签栏为49pt高，49pt之上加1px分隔线。所以：
        // 如果想遮住标签栏，应当把标签栏实际高度设置为50pt
        
        // 设置启动时显示的tab
        tabBarController.selectedIndex = 0
        
        return tabBarController
        
    }
}
