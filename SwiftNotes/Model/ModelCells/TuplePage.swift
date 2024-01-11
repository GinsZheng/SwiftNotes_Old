//
//  TuplePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/6/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class TuplePage: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 作为元组可以以此方式遍历，但不能写能 for (x, y) in (num1, num2)
        let tuples = [(1, 1), (2, 2), (3, 6), (4, 9)]
        for (x, y) in tuples {
            print(x, y)
        }
        
            
    }
    
    
}

