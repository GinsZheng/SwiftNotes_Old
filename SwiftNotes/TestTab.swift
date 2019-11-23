//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestTab: UIViewController {
    
    let iPAddTextField = UITextField()
    let portTextField = UITextField()
    let sendMessage = UITextView()
    let messageTextView = UITextView()
    let connectButton = UIButton(type: .system)
    let closeButton = UIButton(type: .system)
    let sendButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        iPAddTextField.set(superview: view, placeholder: "sendMsg")
        iPAddTextField.makeConstraints(left: 20, top: 100, right: 20, height: 44)
        iPAddTextField.text = "49.235.144.204"
        
        portTextField.set(superview: view, placeholder: "port")
        portTextField.makeConstraints(left: 20, top: 160, right: 20, height: 44)
        portTextField.text = "5000"
        
        sendMessage.set(superview: view, text: "Type assage here to send")
        sendMessage.makeConstraints(left: 20, top: 300, right: 20, height: 44)
        
        messageTextView.set(superview: view, text: "Receiving Massage")
        messageTextView.makeConstraints(left: 20, top: 350, right: 20, height: 500)
        
    }
    
    
}
