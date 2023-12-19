//
//  DataHandle.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/20.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSDataOperate: UIViewController {
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // trim
        let trimingText = "  123  ".trimmingCharacters(in: .whitespaces)
        print(trimingText)
        
        
        // Int运算
        let str1 = "abc"
        print("abc: \(Int(str1) ?? 0)")
        
        let str2 = "123abc"
        print("123abc: \(Int(str2) ?? 0)")
        
        let str3 = "abc123"
        print("abc123: \(Int(str3) ?? 0)")
        
        let str4 = "123"
        print("123", Int(str4) ?? 0)
        
        let str5 = ""
        print("Empty String", Int(str5) ?? 0)
        
        let strD1 = "123.45"
        print("123.45", Double(strD1) ?? 0)
        
        let strD2 = "123.4a"
        print("123.4a", Double(strD2) ?? 0)
        
        // 四舍五入并转为Int
        let intValue = lround(23.50)
        print("lround 23.50: \(intValue)")
    }
    
    
}

/*
 Int(x):
 如果x为纯数字，可转化为可选值 Int?
 如果x非纯数字(包括空串)，转化为nil
 
 Double(x)同上
 */
