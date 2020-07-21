//
//  PanGesturePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/15.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSPanGesturePage: UIViewController {
    
    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panGes))
        view.addGestureRecognizer(pan)
    }
    
    @objc func panGes() {
        print("pan")
    }
    
}

/*
 pan 有高优先级，可以屏幕掉其他滑动手势
 swipe手势被屏蔽，而pan手势有效且覆盖下滑关闭
 */
