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
        
        let stackBlock1 = UIView()
        stackBlock1.backgroundColor = UIColor.hex(cFF5349)
        
        let stackBlock2 = UIView()
        stackBlock2.backgroundColor = UIColor.hex(cF7AD18)
        
        let stackBlock3 = UIView()
        stackBlock3.backgroundColor = UIColor.hex(c2C9EFF)
        
        let stack = UIStackView(arrangedSubviews: [stackBlock1, stackBlock2, stackBlock3])
        stack.set(superview: view)
        stack.makeConstraints(left: 20, top: 100, width: kScreenWidth-40, height: 100)
        stack.backgroundColor = UIColor.hex(cF5F6F8)
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        let stackBlock4 = UIView()
        stackBlock4.backgroundColor = UIColor.hex(c25BE3C)
        stack.addArrangedSubview(stackBlock4)
    }
    
    
}

