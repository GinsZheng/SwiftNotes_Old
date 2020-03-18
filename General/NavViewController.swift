//
//  BaserootNavController.swift
//  SnailProgress
//
//  Created by GinsMac on 2019/11/27.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSRootNavController: UINavigationController, UINavigationControllerDelegate {
    var popDelegate:UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        //navigationBar字体颜色设置
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.hex(c222)]
        //navigationBar颜色
        self.navigationBar.isTranslucent = false
        self.navigationBar.shadowImage = getImageWithColor(color: cNoColor)
        self.popDelegate = self.interactivePopGestureRecognizer?.delegate
        self.delegate = self
    }
    
    //MARK: - UIGestureRecognizerDelegate代理
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        //实现滑动返回的功能
        //清空滑动返回手势的代理就可以实现
        if viewController == self.viewControllers[0] {
            
            self.interactivePopGestureRecognizer?.delegate = self.popDelegate
            
        } else {
            
            self.interactivePopGestureRecognizer?.delegate = nil;
        }
    }
    
    //拦截跳转事件
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if self.children.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
            //添加图片
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "nav_back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftClick))
            
        }
        super.pushViewController(viewController, animated: animated)
        
    }
    
    //返回上一层控制器
    @objc func leftClick()  {
        
        popViewController(animated: true)
        
    }
}
