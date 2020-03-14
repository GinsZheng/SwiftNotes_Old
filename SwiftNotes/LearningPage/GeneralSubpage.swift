//
//  GeneralSubpage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/16.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class GeneralSubpage: UIViewController {
    
    public var textStr = "General SubPage"
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
    }
    
    
}
