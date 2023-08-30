//
//  Delegate3Page.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/8/30.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class CSDelegate3Page: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chatRoom = ChatRoom()
        let user1 = User(name: "Alice", chatRoom: chatRoom)
        let user2 = User(name: "Bob", chatRoom: chatRoom)

        user1.chatRoom.sendMessage("Hello, Bob!")
        user2.chatRoom.sendMessage("Hi, Alice!")
        user1.chatRoom.sendMessage("How's it going?")
        user2.chatRoom.sendMessage("Great!")

        print("Chat history:")
        for i in 0..<chatRoom.messages.count {
            print("\(i + 1). \(chatRoom[i])")
        }
    }
    
}


// 定义代理协议
protocol ChatDelegate: AnyObject {
    func newMessageReceived(_ message: String)
}


// 定义聊天室类(委托类)
class ChatRoom {
    weak var delegate: ChatDelegate?
    var messages: [String] = []
    
    init() {}
    
    func sendMessage(_ message: String) {
        messages.append(message)
        delegate?.newMessageReceived(message)
    }
    
    subscript(index: Int) -> String {
        return messages[index]
    }
}


// 定义用户类(受托类)
class User: ChatDelegate {
    var name: String
    var chatRoom: ChatRoom
    
    init(name: String, chatRoom: ChatRoom) {
        self.name = name
        self.chatRoom = chatRoom
        self.chatRoom.delegate = self
    }
    
    // ChatDelegate 方法
    func newMessageReceived(_ message: String) {
        print("\(name) received a new message: \(message)")
    }
}


