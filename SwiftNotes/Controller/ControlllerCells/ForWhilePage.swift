//
//  ForWhilePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/18.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSForWhilePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // for 循环遍历数组的里的个数
        let numbers = [1,2,3,4,5,6,7,8,9,10]
        for i in 0 ..< numbers.count {
            print("Count is: \(i)")
        }
        /*
         可用于多个数组的计算，比如startTime数组和endTime数组，计算时间差
         for i in 0 ..< startTimeArray.count {
             let seconds = model.endTime[i] - model.startTime[i]
         }
         */
        
        // 值与索引
        for (index, value) in numbers.enumerated() {
            print("index is \(index), value is \(value)")
        }
        
        // 只需要索引
        for (index, _) in numbers.enumerated() {
            print("index is \(index)")
        }
    }
    
    
}

