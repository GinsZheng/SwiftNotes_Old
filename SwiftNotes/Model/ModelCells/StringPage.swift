//
//  StringPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/6.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSStringPage: UIViewController {
    
    let doubleNum = 1234.5678
    let intNum = 66
    let intNum2 = 987654
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let str1 = String(format: "%.2f", doubleNum)
        print("保留2位小数 \(str1)")
        
        let str2 = String(format: "%4d", intNum)
        print("固定最小显示4位数，不足4位的前面用空格补充 \(str2)")
        
        let str3 = String(format: "%4d", intNum2)
        print("固定最小显示4位数，超出4位的全部显示 \(str3)")
        
        let str4 = String(format: "%4d", doubleNum)
        print("谎 \(str4)")
    }
    
    
}

