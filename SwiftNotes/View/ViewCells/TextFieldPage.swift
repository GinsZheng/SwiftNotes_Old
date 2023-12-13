//
//  TextFieldPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TextFieldPage: UIViewController, UITextFieldDelegate {
    
    let textField = UITextField()
    let textField2 = UITextField()
    let textField3 = UITextField()
    let button = UIButton()
    let myView = UIView()
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // 点击空白位置，收起键盘
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resignFirstResponders()
    }
    
    /*
     空白位置指：无点击事件的控件。
     无点击事件控件：比如默认的UIView，点了无事件但不穿透， 即如果此控件下层有可点击的彼控件，则彼控件点击事件不触发
     不可交互控件：比如默认的UILabel，点了无效且被穿透， 即如果此控件下层有可点击的彼控件，则彼控件点击事件被触发
     可点击控件：比如默认的Button，点了有事件。 点击可点击控件，不会收起键盘， 如果需要，就要写上：textField.resignFirstResponder()
     如果需要，就要写上：textField.resignFirstResponder()
     
     注：实际上，无交互控件也会被触发收起键盘， 是因为无交互控件的底下还有一个❲无点击事件的控件❳：view。 点击不可交互控件，就点击了view，所以收起键盘
     */
    
    /*
     键盘类型：
     小数键盘：.decimalPad
     整数键盘：.numberPad
     */
    
    
    // MARK: - func
    func setupUI() {
        view.backgroundColor = UIColor.white

        textField.setup(superview: view, placeholder: "Input something", delegate: self)
        textField.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 44)
        textField.addTarget(self, action: #selector(checkInputtedValue), for: .allEditingEvents)
        textField.becomeFirstResponder() // 获取焦点
        textField.delegate = self
        
        textField2.setup(superview: view, placeholder: "NumberPad", delegate: self)
        textField2.setFrame(left: 20, top: textField.bottom + 20, width: kScreenWidth - 40, height: 44)
        textField2.keyboardType = .numberPad
        
        textField3.setup(superview: view, placeholder: "Scale", delegate: self)
        textField3.setFrame(left: 20, top: textField2.bottom + 20, width: kScreenWidth - 40, height: 44)
        textField3.adjustsFontSizeToFitWidth = true
        textField3.minimumFontSize = 12
        

        button.setup(superview: view, target: self, action: #selector(resign))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "hehe")
        button.setFrame(left: 20, top: textField3.bottom + 20, right: 20, height: 48)
        
        myView.setup(superview: view, backgroundColor: cF0F1F3)
        myView.setFrame(left: 20, top: button.bottom + 20, right: 20, height: 100)
    }
    
    func resignFirstResponders() {
        textField.resignFirstResponder()
        textField2.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        return true
    }
    
    // MARK: -  UITextFieldDelegate 代理方法
    
    // 限制输入字数 (先设置textField.delegate = self)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let textLength = text.count + string.count - range.length
        return textLength <= 80
    }
    
    
    // MARK: - @objc func
    @objc func checkInputtedValue(textField: UITextField) {
        
    }
    
    @objc func resign() {
        resignFirstResponders()
        print("resign already")
    }

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

