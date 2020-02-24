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

    static func getTabBar() -> ESTabBarController{
        let tabBarController = ESTabBarController()
        let v1 = ViewTab()
        let v2 = ControllerTab()
        let v3 = ModelTab()
        
        v1.tabBarItem = ESTabBarItem.init(title: "View", image: UIImage(named: "tab_discovery"), selectedImage: UIImage(named: "tab_discovery_s"))
        v2.tabBarItem = ESTabBarItem.init(title: "Controller", image: UIImage(named: "tab_saved"), selectedImage: UIImage(named: "tab_saved_s"))
        v3.tabBarItem = ESTabBarItem.init(title: "Model", image: UIImage(named: "tab_tickets"), selectedImage: UIImage(named: "tab_tickets_s"))

        tabBarController.tabBar.shadowImage = nil
            
        tabBarController.viewControllers = [v1, v2, v3]
        
        return tabBarController
        
    }
}
