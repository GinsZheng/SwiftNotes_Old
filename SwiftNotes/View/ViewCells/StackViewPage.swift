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
        stackBlock1.backgroundColor = .hex(cRed_FF5349)
        
        let stackBlock2 = UIView()
        stackBlock2.backgroundColor = .hex(cOrange_F9AD18)
        
        let stackBlock3 = UIView()
        stackBlock3.backgroundColor = .hex(cBlue_2C9EFF)
        
        let stack = UIStackView(arrangedSubviews: [stackBlock1, stackBlock2, stackBlock3])
        stack.set(superview: view)
        stack.setStyleStackView(spacing: 20)
        stack.setFrame(left: 20, top: 20, width: kScreenWidth-40, height: 100)
        
        // 使用UIStackView时，放在其中的UIView的frame信息无效，UILabel有效
        
        let stackBlock4 = UIView()
        stackBlock4.backgroundColor = UIColor.hex(cGreen_25BE3C)
        stack.addArrangedSubview(stackBlock4)
    }
    
    
}

