//
//  Arrays.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/4.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class ArrayPage: UIViewController {
    
    // 多参数遍历
    var multipleElementArray: [(Int, String)] = [(1001, "Gins"), (1002, "Jack"), (1002, "Jane")]
    
    // 带着下标遍历
    var arrayWithSubscript = ["a", "b", "c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // 多参数遍历
        for (id, name) in multipleElementArray {
            print("\(name)的学号是\(id)")
        }
        
        // 带着下标遍历
        for (index, char) in arrayWithSubscript.enumerated() {
            print("第\(index)个元素对应的值是\(char)")
        }
    }
    
    
}

