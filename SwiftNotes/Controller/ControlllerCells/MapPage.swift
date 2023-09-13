//
//  MapPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/31.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSMapPage: UIViewController {
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let arr = [1, 2, 3, 4]
        let squ = arr.map {$0 * $0}
        print(squ)
        
        let arr2 = ["a", "b", "c"]
        let indexAndNum = arr2.enumerated().map {(index, element) in
            return "\(index): \(element)"
        }
        print(indexAndNum)
        
        let arr3 = ["a", "b", "c", "d"]
        let indexAndNum2 = arr3.enumerated().map {"\($0): \($1)"}
        print(indexAndNum2)
        
        let arr4 = [("a", 100), ("b", 200), ("c", 255)]
        let tuples = arr4.enumerated().map {
            "index: \($0), t0: \($1.0), t1: \($1.1)"
        }
        print(tuples)
    }
    
    
    
    
    
    
    
    
    
}

