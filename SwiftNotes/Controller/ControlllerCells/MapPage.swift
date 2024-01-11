//
//  MapPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/31.
//  Copyright © 2020 GinsMac. All rights reserved.
//

/*
 map 函数作用：用于对集合（如数组或字典）中的每个元素执行同一个操作，并返回一个新的集合
 以下为一些具体应用与示例
 */

import UIKit

class CSMapPage: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 转换元素类型：可以将集合中的元素从一种类型转换为另一种类型。例如，将 Int 数组转换为 String 数组
        let numbers = [1, 2, 3]
        let stringArray = numbers.map { "\($0)" }
        
        // 应用函数或闭包：对集合中的每个元素应用一个函数或闭包。这可以用来执行诸如计算、格式化等操作。

    }
    
    
}

