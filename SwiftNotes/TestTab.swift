//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import CocoaAsyncSocket

class TestTab: UIViewController, GCDAsyncSocketDelegate {
    
    let iPAddTextField = UITextField()
    let portTextField = UITextField()
    let sendMessage = UITextView()
    let messageTextView = UITextView()
    let connectButton = UIButton(type: .system)
    let closeButton = UIButton(type: .system)
    let sendButton = UIButton(type: .system)
    
    var socket: GCDAsyncSocket?
    
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
        
        connectButton.set(superview: view)
        connectButton.makeConstraints(left: 50, top: 220, width: 100, height: 44)
        connectButton.setTitle("连接", for: .normal)
        connectButton.addTarget(self, action: #selector(connectAction(_:)), for: .touchUpInside)
        
        closeButton.set(superview: view)
        closeButton.makeConstraints(left: 150, top: 220, width: 100, height: 44)
        closeButton.setTitle("断开", for: .normal)
        closeButton.addTarget(self, action: #selector(closeAction(_:)), for: .touchUpInside)
        
        sendButton.set(superview: view)
        sendButton.makeConstraints(left: 250, top: 220, width: 100, height: 44)
        sendButton.setTitle("发送", for: .normal)
        sendButton.addTarget(self, action: #selector(sendAction(_:)), for: .touchUpInside)
        
    }
    
    @objc func closeAction(_ sender: UIButton) {
        socket?.disconnect()
        addMessage(message: "断开连接")
    }
    /// 连接
    @objc func connectAction(_ sender: UIButton) {
        socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
        do {
            try socket?.connect(toHost: self.iPAddTextField.text!, onPort: UInt16(self.portTextField.text!)!)
            addMessage(message: "连接已发出")
        } catch _ {
            addMessage(message: "连接未发出")
        }
    }
    /// 发送消息
    @objc func sendAction(_ sender: UIButton) {
        socket?.write(sendMessage.text.data(using: String.Encoding.utf8)!, withTimeout: -1, tag: 0)
    }
    
    /// 已连接
    func socket(_ sock: GCDAsyncSocket, didConnectToHost host: String, port: UInt16) {
        addMessage(message: "连接服务器 \(host):\(port)")
        socket?.readData(withTimeout: -1, tag: 0)
    }
    /// 返回数据
    func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        let msg = String(data: data, encoding: String.Encoding.utf8)
        addMessage(message: msg!)
        socket?.readData(withTimeout: -1, tag: 0)
    }
    
    func addMessage(message: String){
        messageTextView.text = messageTextView.text.appendingFormat("%@\n", message)
    }
    
}
