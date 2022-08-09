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
        
        
        
        // MARK: - 以下为新方法，简化UserDefault的表达
        
        // 存储数据
        Preference.isFirstLogin = true
        Preference.appTheme = .dark
        Preference.serverUrl = .developServer

        // 读取数据
        let value1 = Preference.isFirstLogin // true
        let value2 = Preference.appTheme == .dark // true
        let value3 = Preference.serverUrl.rawValue // url: developServer
        print(value1, value2, value3)

    }
}


struct Preference {
    /// bool
    static var isFirstLogin: Bool {
        get { return UserDefaults.standard[#function] ?? false }
        set { UserDefaults.standard[#function] = newValue }
    }

    /// string
    static var userName: String {
        get { return UserDefaults.standard[#function] ?? "yourDefaultValue" }
        set { UserDefaults.standard[#function] = newValue }
    }

    /// enum
    static var appTheme: Theme {
        get { return UserDefaults.standard[#function] ?? .light }
        set { UserDefaults.standard[#function] = newValue }
    }
    /// 测试服跟正式服之间的切换（默认正式服）
    static var serverUrl: ServerUrlType {
        get { return UserDefaults.standard[#function] ?? .distributeServer }
        set { UserDefaults.standard[#function] = newValue }
    }
    
    
}

enum Theme: Int {
    case light
    case dark
    case blue
}

enum ServerUrlType: String {
    case developServer = "url: developServer" // 测试服
    case distributeServer = "url: distributeServer" // 正式服
}



