//
//  UserDefaultsPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/7.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSUserDefaultsPage: UIViewController {
    
    // 创建UserDefaults。存储目录：Library/Preference
    var userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 保存值
        userDefault.set(12345, forKey: "Int")
        // 读取值
        let intValue = userDefault.integer(forKey: "Int")
        print("intValue \(intValue)")
        
        let defaultName = userDefault.string(forKey: "defaultName") ?? "a"
        print("defaultName \(defaultName)")
        
        // 与「integer」等位的有：
        userDefault.object(forKey: "O")
        userDefault.float(forKey: "F")
        userDefault.double(forKey: "D")
        userDefault.bool(forKey: "B")
        userDefault.url(forKey: "U")
        userDefault.string(forKey: "S")
        userDefault.array(forKey: "A")
        userDefault.dictionary(forKey: "Dict")
        userDefault.data(forKey: "Data")
        
        /*
         未存储值时：
         -> 读取int值会返回：0
         -> 读取string返回：nil
         */
    }
}

