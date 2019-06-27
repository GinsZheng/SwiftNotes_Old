//
//  StackViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class StackViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let stack = UIStackView()
        view.addSubview(stack)
        stack.makeConstraintsToLeftTopRight(left: 20, top: 100, right: 20, height: 100)
        stack.backgroundColor = UIColor.hex(gray1)
        
    }
    
    
}

