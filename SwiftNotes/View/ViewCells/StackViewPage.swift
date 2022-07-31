//
//  CSStackViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/19.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSStackViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let stackBlock1 = UIView()
        stackBlock1.backgroundColor = .hex(cRed_FF635A)
        
        let stackBlock2 = UIView()
        stackBlock2.backgroundColor = .hex(cOrange_F9AD18)
        
        let stackBlock3 = UIView()
        stackBlock3.backgroundColor = .hex(cBlue_5393FF)
        
        let stack = UIStackView(arrangedSubviews: [stackBlock1, stackBlock2, stackBlock3])
        stack.set(superview: view)
        stack.setStyleStackView(spacing: 20)
        stack.setFrame(left: 20, top: 20, width: kScreenWidth-40, height: 100)
        
        // 使用UIStackView时，放在其中的UIView的frame信息无效，UILabel有效
        
        let stackBlock4 = UIView()
        stackBlock4.backgroundColor = UIColor.hex(cGreen_25BE3C)
        stack.addArrangedSubview(stackBlock4)
        
        
        // 3等分的次像素处理调研
        var stackBlockBArray: [UIView] = []
        
        for i in 0..<3 {
            let stackBlockB = UIView()
            stackBlockBArray.append(stackBlockB)
            
            let separator = UIView()
            separator.set(superview: stackBlockBArray[i])
            separator.setBackgroundColor(color: c222)
            separator.setFrame(right: 0, top: 0, width: kSeparatorHeight, height: 100)
        }

        let stackB = UIStackView(arrangedSubviews: [stackBlockBArray[0], stackBlockBArray[1], stackBlockBArray[2]])
        stackB.set(superview: view)
        stackB.setStyleStackView(spacing: 0)
        stackB.setFrame(left: 0, top: stack.bottom + 20, width: kScreenWidth, height: 100)
    }
    
    
}

