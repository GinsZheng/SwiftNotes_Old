//
//  TextFieldPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TextFieldPage: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let textField = UITextField()
        textField.set(superview: view, placeholder: "Input something", delegate: self)
        textField.setFrame(left: 20, top: 20, width: kScreenWidth, height: 44)
        textField.addTarget(self, action: #selector(checkInputtedValue), for: .allEditingEvents)
        textField.becomeFirstResponder() // 获取焦点
        
        let textField2 = UITextField()
        textField2.set(superview: view, placeholder: "NumberPad", delegate: self)
        textField2.setFrame(left: 20, top: 160, width: kScreenWidth, height: 44)
        textField2.keyboardType = .numberPad
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        return true
    }
    
    @objc func checkInputtedValue(textField: UITextField) {

    }
}

