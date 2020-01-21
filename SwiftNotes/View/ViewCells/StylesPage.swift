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
        
        
        
        // 投影
        let shadowView = UIView()
        let header = UILabel()
        let subtitle = UILabel()
        
        shadowView.set(superview: view, backgroundColor: cFFF)
        shadowView.setShadow(color: "40133660", x: 0, y: 4, radius: 20)
        shadowView.setCornerRadiusWithoutMask(radius: 8)
        shadowView.setFrame(centerX: view.centerX, top: 100, width: 180, height: 58)
        
        header.set(superview: shadowView, text: "iOS投影扩散值: 20")
        header.setFontStyle(size: 15, color: c222, weight: .medium)
        header.setFrame(left: 10, top: 8)
        
        subtitle.set(superview: shadowView, text: "ShadowRadius：20")
        subtitle.setFontStyle(size: 12, color: c999)
        subtitle.setFrame(left: 10, top: 34)
    }
    
    
}


// 设置区块时(div)，应当把区块宽设置成屏幕宽，可以减少很多计算量，并统一数值
