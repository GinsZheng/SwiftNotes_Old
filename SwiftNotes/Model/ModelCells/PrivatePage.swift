//
//  PrivatePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/9/14.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class PrivatePage: UIViewController {
    
    private let weight = 65
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let person = Person()
        // let name = person.name // private时，其他类不同访问Person类的private属性
        let age = person.age // fileprivate时，在同一个.swift文件内，其他类可以访问Person类的fileprivate属性
        
        print(age)
    }
    
}



private class Person {
    private var name = "Gins"
    fileprivate var age = 23
}


/*
 作用域：
 1. 在class中的变量(如上面的weight)，作用域就是在class内部，即此变量的父层以内能访问
 2. class本身(如上面的private class Person)，作用域是这个swift文件，即class的父层以内能访问
 */
