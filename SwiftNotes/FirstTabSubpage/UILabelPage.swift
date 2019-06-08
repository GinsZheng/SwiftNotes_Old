//
//  UILabelPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class UILabelPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = createUILabel(parentView: view, text: "hello UILabel")
        label.makeConstraintsToLeftTop(left: 20, top: 100)
        label.setFontStyle(color: "222", size: 34)
    }
    
    
}
