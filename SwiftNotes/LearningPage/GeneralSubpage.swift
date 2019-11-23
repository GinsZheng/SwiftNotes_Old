//
//  GeneralSubpage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/16.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class GeneralSubpage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.set(superview: view, text: "General SubPage")
        label.setFontStyle(color: "222", size: 34)
        label.makeConstraints(center: view)
        
    }
    
    
}
