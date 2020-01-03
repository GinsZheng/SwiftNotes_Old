//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestTab: UIViewController {
    

    let label = UILabel()
    let textview = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        label.set(superview: view, text: "在在在在在在在在在")
        label.setFontStyle(size: 100, color: "222") // 文字要先设字号再布局
        label.numberOfLines = 0
        label.setLineHeight()
        label.setFrame(left: 20, top: 100, width: 374, height: label.getLabelHeight(withWidth: kScreenWidth - 40))
        label.setBackgroundColor(color: cCCC)
        
        
        print(label.getLabelHeight(withWidth: kScreenWidth - 40))
    }
    
    
}
