//
//  ConvertTypePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/31.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import UIKit

class ConvertTypePage: UIViewController {
    
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - 私有方法
extension ConvertTypePage {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        
        // [Int]转String
        let intArray = [1, 2, 3, 4]
        let intString = arrayToString(intArray)
        print("intString:", intString)
        
        // [Double]转String
        let doubleArray = [1.3, 20, 3.33]
        let doubleString = arrayToString(doubleArray)
        print("doubleString:", doubleString)
        
        // String转[Int]
        let stringValue = "1,2,3,4"
        let parsedIntArray = stringToArray(stringValue, type: Int.self)
        print("parsedIntArray", parsedIntArray)
        
        // String转[Double]
        let stringValue2 = "1.3, 20, 3.33"
        let parsedDoubleArray = stringToArray(stringValue2, type: Double.self)
        print("parsedDoubleArray", parsedDoubleArray)
        
    }
    
}


// MARK: - @objc方法
extension ConvertTypePage {
    
}
