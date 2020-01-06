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
        textField.set(superview: view, placeholder: "Input something")
        textField.setFrame(left: 20, top: 100, width: kScreenWidth, height: 44)
        textField.delegate = self
        textField.addTarget(self, action: #selector(checkInputtedValue), for: .allEditingEvents)
        
        let textField2 = UITextField()
        textField2.set(superview: view, placeholder: "NumberPad")
        textField2.setFrame(left: 20, top: 160, width: kScreenWidth, height: 44)
        textField2.delegate = self
        textField2.keyboardType = .numberPad
        
        // 交互事件
        // .allEditingEvents 所有编辑事件，用于表单检查(按钮禁用)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        return true
    }
    
    @objc func checkInputtedValue(textField: UITextField) {

    }
}

