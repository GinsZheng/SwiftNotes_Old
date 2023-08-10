//
//  TuplePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/6/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class TuplePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 作为元组可以以此方式遍历，但不能写能 for (x, y) in (num1, num2)
        let tuples = [(1, 1), (2, 2), (3, 6), (4, 9)]
        for (x, y) in tuples {
            print(x, y)
        }
        
        let list: [(String, UIViewController)] = [
            ("Animation", CSAnimationPage()),
            ("Button", CSButtonPage()),
            ("Camera and Photos", CSCameraAndPhotosPage()),
        ]
        
        let c1 = list[0].0
        print("c1", c1)
            
    }
    
    
}

