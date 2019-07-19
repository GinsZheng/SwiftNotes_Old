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
        stackBlock1.backgroundColor = UIColor.red
        
        let stackBlock2 = UIView()
        stackBlock2.backgroundColor = UIColor.cyan
        
        let stackBlock3 = UIView()
        stackBlock3.backgroundColor = UIColor.blue
        
        let stack = UIStackView(arrangedSubviews: [stackBlock1, stackBlock2, stackBlock3])
        stack.set(parentView: view)
        stack.makeConstraintsToLeftTop(left: 20, top: 100, width: screenWidth-40, height: 100)
        stack.backgroundColor = UIColor.hex(gray1)
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        
        let stackBlock4 = UIView()
        stackBlock4.backgroundColor = UIColor.orange
        stack.addArrangedSubview(stackBlock4)
    }
    
    
}

