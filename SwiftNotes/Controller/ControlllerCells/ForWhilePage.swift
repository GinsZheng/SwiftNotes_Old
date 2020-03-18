//
//  ForWhilePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/18.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class ForWhilePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // for 循环遍历数组的里的个数
        let numbers = [1,2,3,4,5,6,7,8,9,10]
        for i in 0 ..< numbers.count {
            print("Count is: \(i)")
        }
        
        
    }
    
    
}

