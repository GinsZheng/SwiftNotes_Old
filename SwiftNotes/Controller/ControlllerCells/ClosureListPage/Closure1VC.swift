//
//  ClosurePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/30.
//  Copyright © 2023 GinsMac. All rights reserved.
//


/// 本页是一个闭包的简单示例，页末有对闭包相对于直接传值更强大之处的说明
/// 本页为使用闭包在Closure1VC和ClosureCustomView之前传递数据的示例
/// 视图控制器 (Closure1VC): 主要的控制器，它包含一个自定义视图
/// 自定义视图 (ClosureCustomView): 一个简单的视图，它有一个方法updateData，用于更新其显示的数据
/// 数据传递：ClosureCustomView使用闭包从ViewController获取数据

import UIKit

class Closure1VC: UIViewController {
    
    let value = "这是一个Closure1VC中的值"
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let ClosureCustomView = ClosureCustomView(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        view.addSubview(ClosureCustomView)
        
        // 1. 设置闭包
        ClosureCustomView.fetchDataClosure = {
            return self.value
        } // 由于需要把类ClosureEnumVC中的值传递给类ClosureEnumCustomView，所以才要在类ClosureEnumVC来设置闭包
    }
    
}


// MARK: - 自定义视图
class ClosureCustomView: UIView {
    // 0. 定义闭包
    var fetchDataClosure: (() -> String)? {
        didSet {
            updateData()
        }
    }

    private let dataLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dataLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        dataLabel.frame = bounds
    }

    func updateData() {
        // 2. 调用闭包
        let data = fetchDataClosure?() ?? "No data"
        dataLabel.text = data
    }
}


/*
 闭包的使用通常涉及三个主要步骤(当前也可能有2步或≥4步)：1. 定义闭包 2. 设置闭包 3. 调用闭包
 1. 定义闭包：声明闭包变量。你需要指定闭包的类型，这包括它接受的参数和它返回的值的类型。
    例如，一个接受两个Int类型参数并返回Int类型的闭包可以这样定义：
    var myClosure: (Int, Int) -> Int
 2. 设置闭包：将具体的闭包函数赋值给之前定义的闭包变量。
    这可以在闭包被定义的同一个上下文中完成，也可以在其他地方完成，例如传递闭包作为函数参数或者设置为某个类的属性。
    myClosure = { (number1: Int, number2: Int) -> Int in
    return number1 + number2
    }
 3. 调用闭包：一旦闭包被设置，你就可以像调用普通函数那样调用它。使用闭包变量名称并传入适当的参数即可执行闭包中的代码
    let result = myClosure(5, 10)
 ————
 两步闭包：有 1.定义闭包(的类型) 2.调用闭包 。例如，如果你有一个接受闭包作为参数的函数，你可能会直接在调用该函数时提供一个闭包
 四步闭包：有 1.定义闭包 2.设置 3.传递 4.调用
 */


/*
 本例中，其实可以直接把fetchDataClosure设为变量，并在ViewController中赋值即可
 不过闭包强大的直接赋值所做不到的地方在于：
 1. 异步操作：当涉及异步操作（如网络请求）时，闭包特别有用。你可以使用闭包来处理异步回调，这在直接赋值无法轻易实现的。
    例如，当一个网络请求完成时，你可以使用闭包来更新UI或处理数据，而不是等待数据返回后直接赋值。
 2. 封装复杂逻辑：当你需要封装复杂的逻辑或一系列操作时，闭包是一个好选择。你可以定义一个接受闭包作为参数的函数，然后在闭包内部实现详细的操作。
    比如，你可以创建一个接受闭包的动画函数，闭包中包含了动画结束后需要执行的一系列操作。
 3. 高阶函数：Swift中的高阶函数（如map、filter、reduce等）广泛使用闭包。
    这些函数通过闭包参数实现强大的集合操作，通常这些操作用传统方法很难实现或者需要更多的代码
 4. 作为回调和监听器：在处理用户界面事件或某些响应式编程模式时，闭包作为回调或事件监听器非常有用。
    你可以定义一个闭包来响应特定事件，而不是使用传统的委托或通知模式。
 */


/*
 闭包的捕获：
 1 使用场景：
   1. 异步操作：在进行异步网络请求时，你可能需要在请求完成后处理数据。闭包可以捕获并使用在异步操作开始前存在的数据。
   2. 回调和事件处理：在UI编程中，闭包通常用于响应事件或者处理回调。
   3. 定时器：使用定时器时，闭包可以捕获必要的上下文信息，以便在定时器触发时使用。
   4. 高阶函数：在使用诸如map、filter等高阶函数时，闭包可以捕获外部变量以在操作数组或集合时使用。
 2 示例：
 func someFunction() {
     let outsideVariable = "Hello"

     let closure = { print(outsideVariable) }
     closure()
 }
 在这个示例中，closure 是一个闭包，它在其内部使用了someFunction作用域内定义的变量outsideVariable。这就是一个捕获的例子。
 要判断一个闭包是否进行了捕获，主要看它是否引用了定义在其外部作用域的变量或常量
 */
