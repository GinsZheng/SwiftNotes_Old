//
//  IntPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/7/22.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSIntPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let strValue = "heheda"
        let intValue = Int(strValue)
        print("纯字符串转Int \(intValue)") // nil
        
        let strValue2 = "123.45"
        let intValue2 = Int(strValue2)
        print("浮点数型字符串转Int \(intValue2)") // nil
        
        let strValue3 = "-1234"
        let intValue3 = Int(strValue3)
        print("整数型字符串转Int \(intValue3)") // Optional(-1234)
        
        let strValue4 = "123abc"
        let intValue4 = Int(strValue4)
        print("整数与字符串混合型字符串转Int \(intValue4)") // nil
    }
    
    
}

