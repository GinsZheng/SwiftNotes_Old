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
    let doubleNum2 = 0.0001234
    let intNum = 66
    let intNum2 = 987654
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        let strA1 = String(format: "%.2f", doubleNum)
        print("保留2位小数：\(strA1)")
        
        let strB1 = String(format: "%4d", intNum)
        print("固定最小4位显示，不足的前面用空格补充：\(strB1)")
        
        let strB2 = String(format: "%4d", intNum2)
        print("固定最小4位显示，超出全部显示：\(strB2)")
        
        let strC1 = String(format: "%0.4d", intNum)
        print("固定最少4位显示，不足补0：\(strC1)")
        
        let strC2 = String(format: "%0.4d", intNum2)
        print("固定最小显示4位数，超出全部显示：\(strC2)")
        
        
    }
}


/*
 使用格式：
 -> %长度修饰符+格式化说明符
 
 常用格式化说明符：
 %d，%D  指Int32 (最大2147483647)
 %u，%U  指无符号的Int32 (最大4294967295)
 %f      64位float和double
 

 常用长度修饰符：
 
 h    代表short或者unsigned short
 l    代表long 或者unsiged short  (ll,q 表示long long或者unsigned long long) Int
 L    代表long double
 z    代表 size_t  （可能为正）
 t    代表 ptrdiff_t（可能为负）
 */
