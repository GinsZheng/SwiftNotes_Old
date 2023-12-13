//
//  ClosureEnumVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/30.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class ClosureEnumVC: UIViewController {
    
    let optionalClosureValue = "optionalClosure"
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let myView = ClosureEnumCustomView(frame: .zero)
        
        // MARK: - 1. 设置闭包
        
        // MARK: - A 可选与非可选
        // A1 非可选类型闭包：
        // 非可选已经在定义时同时已经设置了闭包，无须设置直接调用
        
        // A2 可选类型闭包
        myView.optionalClosure = {
            return self.optionalClosureValue
        }
        
        // A3 非可选类型闭包(返回值为可选)：已初始化
        
        
        // MARK: - B 参数与返回值
        // B1 无参数闭包
        myView.noVarClosure = {
            return "这是一个无参数闭包"
        }
        
        // B2 1个参数闭包
        myView.oneVarClosure = { number in
            return "传入的数字是 \(number)"
        }
        
        // B3 多个参数闭包：已初始化
        
        
        // MARK: - C 函数参数闭包：已初始化

        
        
        
        
        
        // 调用了调用闭包的函数
        myView.updateData()
    }
    
    
}


class ClosureEnumCustomView: UIView {
    
    // MARK: - 0. 定义闭包
    
    // MARK: - A 可选与非可选
    // A1 非可选类型闭包
    var normalClosure: () -> Void = {
        print("normalClosure")
    }
    // 实际应用中，闭包在很多时候都是定义为可选的，非可选的有以下场景：1. 作为函数参数、2. 确保总是有值的属性、3. 在定义时就被初始化
    // 此外，() -> Void 与 (() -> Void) 实际上是等价的，只不过当闭包比较复杂时，多个括号比较易读
    
    // A2 可选类型闭包
    var optionalClosure: (() -> String)?
    
    // A3 非可选类型闭包(返回值为可选)
    var optionalValueClosure: () -> String? = {
        return "optionalValueClosure"
    }
    // 注意这里的写法：(() -> String)? 这么写是可选类型闭包，() -> String?是非可选类型闭包(返回值是可选的)
    
    
    // MARK: - B 参数与返回值
    // B1 无参数闭包
    var noVarClosure: (() -> String)?
    
    // B2 1个参数闭包
    var oneVarClosure: ((Int) -> String)?
    
    // B3 多个参数闭包
    var multiVarClosure: (String, Int, Double) -> String = { name, age, height in
        let resume = "My name is \(name). \(age) years old. \(height)m height "
        return resume
    }
    
    
    // MARK: - C 函数参数闭包
    // C1 1个闭包参数函数
    func closureFunc1(closure: (Int) -> String) {
        let result = closure(10)
        print("结果是: \(result)")
    }
    
    
    // C2 3个闭包参数函数
    func closureFunc2(firstClosure: () -> Void,
                      secondClosure: (String) -> Void,
                      thirdClosure: (Int) -> Bool) {
        firstClosure()
        secondClosure("测试字符串")
        let result = thirdClosure(5)
        print("第三个闭包的结果是: \(result)")
    }
    
    
    // MARK: - D 带self的闭包 ⚠️待完善。大概是说：如果我所在
//    layout.fetchTitleWidthsClosure = { [weak self] in
//        guard let self = self else { return [] }
//        return self.calculateTitleWidths()
//    }
    
    
    
    // MARK: - 这一块可忽略
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func updateData() {
        
        // MARK: - 2. 调用闭包
        
        // MARK: - A 可选与非可选
        // A1 非可选类型闭包
        normalClosure()
        
        // A2 可选类型闭包
        if let closure = optionalClosure {
            let result = closure()
            print(result) // 这将打印 "这是可选闭包的返回值"
        }
        
        // A3 非可选类型闭包(返回值为可选)
        let a3Result = optionalValueClosure() ?? "没有返回值"
        print(a3Result) // 这将打印 "optionalValueClosure"，或者如果闭包返回 nil，将打印 "没有返回值"
        
        
        // MARK: - B 参数与返回值
        // B1 无参数闭包
        if let closure = noVarClosure {
            let result = closure()
            print(result) // 将打印 "这是一个无参数闭包"
        }
        
        // B2 1个参数闭包
        if let closure = oneVarClosure {
            let result = closure(10)
            print(result) // 将打印 "传入的数字是 10"
        }
        
        // B3 多个参数闭包
        let b3Result = multiVarClosure("Alice", 30, 1.75)
        print(b3Result) // 将打印 "My name is Alice. 30 years old. 1.75m height"
        
        
        // MARK: - C 函数参数闭包
        // C1 1个闭包参数函数
        closureFunc1 { number in
            return "数字是 \(number)"
        } // 这个是一种平常相对少见的函数，因为函数名称后面没有括号，而是一个尾随闭包
        
        // C2 3个闭包参数函数
        closureFunc2(
            firstClosure: {
                print("执行第一个闭包")
            },
            secondClosure: { text in
                print("第二个闭包接收到的文本是: \(text)")
            },
            thirdClosure: { number in
                return number > 3
            }
        )
        
        // C2 3个闭包参数函数(另一种呈现形式，选中参数并敲回车时自动展开成以下形式)
        closureFunc2 {
            print("执行第一个闭包")
        } secondClosure: { text in
            print("第二个闭包接收到的文本是: \(text)")
        } thirdClosure: { number in
            return number > 3
        } // 特点是：第一个闭包不会有名字，后面的闭包也无需用逗号隔开
        
        
    }
}
