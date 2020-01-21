//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestTab: UIViewController {

    let myView = UIView()
    let header = UILabel()
    let subtitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        self.title = "Test"
        
        myView.set(superview: view, backgroundColor: cFFF)
        myView.setShadow(color: "40133660", x: 0, y: 4, radius: 20)
        myView.setCornerRadiusWithoutMask(radius: 8)
        myView.setFrame(centerX: view.centerX, top: 100, width: 180, height: 58)
        
        header.set(superview: myView, text: "iOS投影扩散值: 20")
        header.setFontStyle(size: 15, color: c222, weight: .medium)
        header.setFrame(left: 10, top: 8)
        
        subtitle.set(superview: myView, text: "ShadowRadius：20")
        subtitle.setFontStyle(size: 12, color: c999)
        subtitle.setFrame(left: 10, top: 34)
    }

}
