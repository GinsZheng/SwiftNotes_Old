//
//  windowPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/2.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSWindowPage: UIViewController {
    
    // windows[0]表示UIWindow的最底一层，有最长的生命周期
    let window = UIApplication.shared.windows[0]
    let myview = UIView()
    
    // 最后一个Window，即栈的最上层，退出页面时，lastWindow即释放
    let lastWindow = UIApplication.shared.windows.last!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        

        myview.set(superview: window, backgroundColor: cBlue_5393FF)
        myview.setFrame(left: 20, top: 20, width: 100, height: 100)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        myview.removeFromSuperview()
    }
}

