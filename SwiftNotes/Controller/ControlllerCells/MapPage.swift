//
//  MapPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/31.
//  Copyright © 2020 GinsMac. All rights reserved.
//

/*
 map / compactMap 函数作用：用于对集合（如数组或字典）中的每个元素执行同一个操作，并返回一个新的集合
 以下为一些具体应用与示例
 */

import UIKit

class CSMapPage: UIViewController {
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 转换元素类型：可以将集合中的元素从一种类型转换为另一种类型。例如，将 Int 数组转换为 String 数组
        let numbers = [1, 2, 3]
        let stringArray = numbers.map { "\($0)" }
        
        // 应用函数或闭包：对集合中的每个元素应用一个函数或闭包。这可以用来执行诸如计算、格式化等操作。
        
    }
    
    
}


/*
 map 和 comapctMap 对比：
 ▸ 共同点：二者语法相同，作用基本相同。对于非nil的可选值，都是返回可选值
 ▸ 差别：仅在处理nil时的行为不同
  ⎯► map：不会自动移除nil值，结果数组中的元素数量与原数组相同
  ⎯► compactMap：会自动移除nil值，所以结果数组中的元素数量可能少于原数组。但是
 ▸ 使用场景：
  ⎯► map：当你需要保留所有转换结果，包括nil值
  ⎯► compactMap：当你需要移除所有nil值
 */
