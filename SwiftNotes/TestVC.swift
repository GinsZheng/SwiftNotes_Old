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
        
        textField2.set(superview: view, placeholder: "请输入", delegate: self)
        textField2.setStyleOneLineTextField()
        textField2.setFrame(left: 20, top: 100, right: 20, height: 56)
        
        textField2.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        textField2.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        textField2.addTarget(self, action: #selector(editingChanged), for: .editingDidEndOnExit)
        textField2.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField2.resignFirstResponder()
    }
     
//    override func viewDidAppear(_ animated: Bool){
//        super.viewDidAppear(animated)
//
//    }
    
    @objc func editingDidBegin() {
        print("editingDidBegin")
    }
    
    @objc func editingChanged() {
        print("editingChanged", textField2.text ?? "")
    }

    @objc func editingDidEnd() {
        print("editingDidEnd")
    }
    
    @objc func editingDidEndOnExit() {
        print("editingDidEndOnExit")
    }
    
    /*
     UIControl.Event
     .editingDidBegin 拉起键盘时触发
     .editingChanged 编辑之后，text值也为编辑之后的值
     .editingDidEnd 退出编辑时触发
     .editingDidEndOnExit 指点击键盘的返回键（Return Key）时触发，此时不存在焦点
     */
    
}
                    
