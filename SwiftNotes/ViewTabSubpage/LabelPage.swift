//
//  LabelPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class LabelPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.set(superview: view, text: "hello UILabel")
        label.setFontStyle(size: 34, color: "222") // 文字要先设字号再布局
        label.setFrame(left: 20, top: 100)
        
        label.backgroundColor = UIColor.hex(c2C9EFF)
        
    }
    
}

