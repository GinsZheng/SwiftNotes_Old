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
        
        let selectedIndex = 1
        
        let tabBarController = ESTabBarController()
        let v1 = ViewListVC()
        let v2 = CSControllerListVC()
        let v3 = CSModelListVC()
        let v4 = TestVC()
        
        v1.tabBarItem = ESTabBarItem.init(title: "View", image: UIImage(named: "tab_discovery"), selectedImage: UIImage(named: "tab_discovery_s"))
        v2.tabBarItem = ESTabBarItem.init(title: "Controller", image: UIImage(named: "tab_saved"), selectedImage: UIImage(named: "tab_saved_s"))
        v3.tabBarItem = ESTabBarItem.init(title: "Model", image: UIImage(named: "tab_tickets"), selectedImage: UIImage(named: "tab_tickets_s"))
        v4.tabBarItem = ESTabBarItem.init(title: "Test", image: UIImage(named: "tab_mine"), selectedImage: UIImage(named: "tab_mine_s"))
        
        tabBarController.tabBar.shadowImage = nil
        
        let v1Nav = CSRootNavController(rootViewController: v1)
        let v2Nav = CSRootNavController(rootViewController: v2)
        let v3Nav = CSRootNavController(rootViewController: v3)
        let v4Nav = CSRootNavController(rootViewController: v4)
        
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
        tabBarController.selectedIndex = selectedIndex
        
        
        return tabBarController
        
    }
    
    
    // 带中央按钮的tabBar
    static func getTabBarWithButton(delegate: UITabBarControllerDelegate) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.barTintColor = UIColor.white
        tabBarController.tabBar.shadowImage = nil
        
        let tabShadow = UIImageView()
        tabShadow.set(superview: tabBarController.tabBar, imageName: "tab_shadow")
        tabShadow.setFrame(left: 0, top: -10, right: 0, height: 10)

        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                tabBarController?.present(toTarget: CSGeneralSubpage())
            }
        }
        
        let v1 = ViewListVC()
        let v2 = CSControllerListVC()
        let v3 = CSModelListVC()
        let v4 = TestVC()
        let v0 = CSGeneralSubpage()
        
        v1.tabBarItem = ESTabBarItem.init(title: "View", image: UIImage(named: "tab_discovery"), selectedImage: UIImage(named: "tab_discovery_s"))
        v2.tabBarItem = ESTabBarItem.init(title: "Controller", image: UIImage(named: "tab_saved"), selectedImage: UIImage(named: "tab_saved_s"))
        v3.tabBarItem = ESTabBarItem.init(title: "Model", image: UIImage(named: "tab_tickets"), selectedImage: UIImage(named: "tab_tickets_s"))
        v4.tabBarItem = ESTabBarItem.init(title: "Test", image: UIImage(named: "tab_mine"), selectedImage: UIImage(named: "tab_mine_s"))
        v0.tabBarItem = ESTabBarItem.init(title: nil, image: nil, selectedImage: nil)
        
        let v1Nav = CSRootNavController(rootViewController: v1)
        let v2Nav = CSRootNavController(rootViewController: v2)
        let v3Nav = CSRootNavController(rootViewController: v3)
        let v4Nav = CSRootNavController(rootViewController: v4)
        let v0Nav = CSRootNavController(rootViewController: v0)
        
        tabBarController.viewControllers = [v1Nav, v2Nav, v0Nav, v3Nav, v4Nav]
        
        // 中间的+按钮
        let addingBtn = UIButton()
        addingBtn.set(superview: tabBarController.tabBar)
        addingBtn.setFrame(centerX: tabBarController.tabBar.centerX, top: -4, width: kScreenWidth/3 + 2, height: 48)
        addingBtn.setImage(UIImage(named: "tab_adding"), for: .normal)
        addingBtn.isUserInteractionEnabled = false

        // 设置启动时显示的tab
        tabBarController.selectedIndex = 0
        
        
        return tabBarController
        
    }
}

