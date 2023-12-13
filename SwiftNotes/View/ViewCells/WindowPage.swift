//
//  windowPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/2.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class WindowPage: UIViewController {
    
    // windows[0]表示UIWindow的最底一层，有最长的生命周期
    let window = UIApplication.shared.windows[0]
    let myview = UIView()
    
    // 最后一个Window，即栈的最上层，退出页面时，lastWindow即释放
    let lastWindow = UIApplication.shared.windows.last!
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        myview.removeFromSuperview()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.backgroundColor = .white
        
        myview.setup(superview: window, backgroundColor: cBlue_5393FF)
        myview.setFrame(left: 20, top: 20, width: 100, height: 100)
    }
}

