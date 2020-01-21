//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestTab: UIViewController {

    let textViewWitoutInteraction = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        self.title = "Test"
        
        
        textViewWitoutInteraction.set(superview: view, text: "在在在在在在在在在")
        textViewWitoutInteraction.numberOfLines = 0
        textViewWitoutInteraction.setLineHeight(multiple: 2.8)
        textViewWitoutInteraction.setFontStyle(size: 100, color: c222)
        textViewWitoutInteraction.setBackgroundColor(color: cBlue_2C9EFF_13)
    }

}
