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



//表述：
//我创建了一份协议，叫P，然后创建了一个类，叫C，现在，我让类C遵循协议P(class C: P {} 和写类的继承一样)。这么做有什么结果呢？比如协议P中有3个属性：姓名、性别、年龄。那么类C里面一定也要有姓名、性别、年龄。少了一个，就会报错，说你缺了一个东西。
//协议是定义一些规范(属性、功能方法)，然后由类、结构体或者枚举遵循并实现这些规范，这一过程被称为遵循了协议。
//协议可以要求遵循协议的类型提供特定的属性、方法，构造器。如果协议中的属性和方法没有实现，就会报错
