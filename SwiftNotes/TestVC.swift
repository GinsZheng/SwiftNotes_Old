//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
 
class TestVC: UIViewController, UITextFieldDelegate {
    
    let textField2 = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        textField2.set(superview: view, placeholder: "请输入", delegate: self)
//        textField2.setStyleOneLineTextField()
//        textField2.setFrame(left: 20, top: 100, right: 20, height: 56)
//        textField2.keyboardType = .numberPad
//
//        XHToast.showCenterWithText("双行双行双行双行双行双行双行双行双行双行双行双行")
        
        CSToast.showCenterWithText("双行双行双行双行双行双行双行双行双行双行双行双行双行双行双行双行双行")
        
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        textField2.resignFirstResponder()
//        textField2.text = textField2.text?.trimmingCharacters(in: .whitespaces)
//    }

    

    
}
                    
