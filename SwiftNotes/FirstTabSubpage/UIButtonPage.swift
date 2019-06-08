//
//  UIButtonPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/11.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class UIButtonPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let button = UIButton()
        view.addSubview(button)
        button.makeConstraintsToLeftTopRight(left: 20, top: 200, right: 20, height: 44)
        
    }
    
    
}

