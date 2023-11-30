//
//  ClosureEnumVC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/30.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class ClosureEnumVC: UIViewController {
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let myView = ClosureEnumCustomView(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        view.addSubview(myView)
        
        // 1. 设置闭包
        myView.fetchDataClosure = {
            return "Hello"
        }
        myView.updateData()
    }
    
    
}


class ClosureEnumCustomView: UIView {
    
    // MARK: - 0. 定义闭包
    
    // A 可选与非可选
    // 非可选类型闭包
    var normalClosure: () -> Void = {
        print("optionalValueColsure")
    }
    // 实际应用中，闭包在很多时候都是定义为可选的，非可选的有以下场景：1. 作为函数参数、2. 确保总是有值的属性、3. 在定义时就被初始化
    // 此外，() -> Void 与 (() -> Void) 实际上是等价的，只不过当闭包比较复杂时，多个括号比较易读
    
    // 可选类型闭包
    var optionalClosure: (() -> String)?
    
    // 非可选类型闭包(返回值为可选)
    var optionalValueColsure: () -> String? = {
        return "optionalValueColsure"
    }
    // 注意这里的写法：(() -> String)? 这么写是可选类型闭包，() -> String?是非可选类型闭包(返回值是可选的)
    
    
    // B 参数与返回值
    // 无参数闭包
    var noVarClosure: (() -> String)?
    
    // 1个参数闭包
    var oneVarClosure: ((Int) -> String)?
    
    // 多个参数闭包
    var multiVarClosure: (String, Int, Double) -> String = { name, age, height in
        let resume = "My name is \(name). \(age) years old. \(height)m height "
        print(resume)
        return resume
    }
    
    // 函数参数闭包
    
    
    
    // 定义没有参数的闭包
    var fetchDataClosure: (() -> String)?
    
    
    // MARK: - 这一块可忽略
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
    
    
    // MARK: - 2. 调用闭包
    func updateData() {
        let data = fetchDataClosure?() ?? "No data"
        dataLabel.text = data
        
        multiVarClosure("Gin", 18, 1.77)
    }
}
