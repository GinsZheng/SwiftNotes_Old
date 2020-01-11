//
//  LabelPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class LabelPage: UIViewController {
    
    let label = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        
        label.set(superview: view, text: "在在在在在在在在在在在在在在在在")
        label.setFontStyle(size: 24, color: c222)
        label.setFrame(left: 20, top: 100, width: 384)
        label.setBackgroundColor(color: cF0F1F3)
        label.backgroundColor = UIColor.hex(cBlue_2C9EFF)

        label2.set(superview: view, text: "在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在在")
        label2.setFontStyle(size: 12, color: c222)
        label2.setFrame(left: 20, top: 200, width: 384)
        label2.setBackgroundColor(color: cF0F1F3)
        
        label3.set(superview: view, text: "在在在在")
        label3.setFontStyle(size: 96, color: c222)
        label3.setFrame(left: 20, top: 300, width: 384)
        label3.setBackgroundColor(color: cF0F1F3)
    }
    
}

