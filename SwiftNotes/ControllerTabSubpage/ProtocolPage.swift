//
//  ProtocolPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/7/31.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ProtocolPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let studentA = Students()
        studentA.age = 18
        print(studentA.age)
    }
    
    
}


protocol PersonProtocol {
    
    static var personCount: Int {get}
    
    var name: String {
        get
        set
    }
    
    var birthPlace: String {get}
    
    var age: Int {get}
    
    static func play()
    
    func eat(food: String)
    
    mutating func changeName(newName: String)
}

class Students: PersonProtocol {
    
    static var personCount: Int = 10
    
    var name: String = ""
    
    let birthPlace: String = "Beijing"
    
    var age: Int = 10
    // 只读类型的属性也可以设置为var,这相当于是对其进行扩展，不仅遵循了原来的get，还增加了set
    
    static func play() {
        print("play")
    }
    
    func eat(food: String) {
        print("eat\(food)")
    }
    
    func changeName(newName: String) {
        self.name = newName
    }
}


