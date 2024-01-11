//
//  EnumPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/13.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSEnumPage: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 基本调用，值为枚举名称
        let r1 = CompassPoint.north
        print(r1)
        
        // 已知枚举类型时，可简写：
        let r2: CompassPoint
        r2 = .east
        print(r2)
        
        let r3 = Result.success
        print(r3)
        
        
    }
    
    
}

// 定义
enum CompassPoint {
    case north
    case south
    case east
    case west
}

enum Weight {
    case light
    case regular
    case medium
}

// 另一种语法
enum Result {
    case success, failure
}

/*
 枚举基本：
 -> 枚举也是一种类型，大写字母形头
 -> 应用单数名字
 */

