//
//  StylesPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/30.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class StylesPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 设置部分圆角
        let myView = UIView()
        myView.setBackgroundColor(color: cBlue_2C9EFF)
        myView.set(superview: view)
        myView.setFrame(left: 20, top: 20, width: 200, height: 66)
        myView.setCornerRadius(radius: 16, corners: [.topRight, .bottomRight])
        // 关键点：setCornerRadius一定要在setFrame之后
    }
    
    
}

