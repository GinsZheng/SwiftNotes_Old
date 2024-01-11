//
//  Arrays.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/4.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSArrayPage: UIViewController {
    
    // 创建数组
    var arr1 = [String]() // 写法1
    var arr2:[String] = [] // 写法2
    var arr3 = Array(repeating: 1, count: 5) // 写法3

    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 调用
        let firstElement = arr3[0]
        print("firstElement: \(firstElement)")
        
        // 多参数遍历
        let arr4: [(Int, String)] = [(1001, "Gins"), (1002, "Jack"), (1002, "Jane")]
        for (id, name) in arr4 {
            print("\(name)的学号是\(id)")
        }
        
        // 带着下标遍历
        let arr5 = ["a", "b", "c"]
        for (index, char) in arr5.enumerated() {
            print("第\(index)个元素对应的值是\(char)")
        }
        
        // 只需要索引的遍历
        for i in 0...6 {
            print("索引为 \(i)")
        }
        
        // 只需要索引的遍历(非零开始)
        for i in 3...5 {
            print("非零开始的索引为 \(i)")
        }
        
        // map遍历
        let arr6 = (1...20).map {$0*2}
        print("所有元素乘2: \(arr6)")
        
        // 数组元素求和
        let arr7 = [1, 3, 5, 7, 9]
        let sumValue = arr7.reduce(0, +)
        print("数组求和：\(sumValue)")
        
        // 生成重复元素
        let arr8 = Array(repeating: "T", count: 3)
        print("生成重复元素", arr8)
        
        // 字符串数组转为字符串(方便上传到后端)
        let arr9 = ["a", "b", "c"]
        let result9 = arr9.joined(separator: ",\n")
        print("字符串数组转为字符串", result9)
        
        // 数字数组转为字符串
        let arr10 = [1, 3, 5, 7, 9]
        let stringArray = arr10.map { String($0) }
        let result10 = stringArray.joined(separator: ",\n")
        print("数字数组转为字符串", result10)
    }
    
    
}

