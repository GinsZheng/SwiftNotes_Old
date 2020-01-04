//
//  Arrays.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/4.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class ArraysPage: UIViewController {
    
    // 多元素数组，用于多参数遍历
    var multipleElementArray: [(UIButton, UIImageView)] = []
    
    // 带着下标遍历
    var arrayWithSubscript = ["a", "b", "c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        for (index, char) in arrayWithSubscript.enumerated() {
            print("第\(index)个元素对应的值是\(char)")
        }
    }
    
    
}

