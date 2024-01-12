//
//  UserDefaultsPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/7.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSUserDefaultsPage: UIViewController {
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // MARK: - 优雅的做法

        print("初始isFirstLogin值", Preference.isFirstLogin)
        print("初始appTheme值", Preference.appTheme)

        // 存储数据
        Preference.isFirstLogin = false
        Preference.appTheme = .light
        Preference.serverUrl = .developServer
        
        // 读取数据
        print("更新后isFirstLogin值", Preference.isFirstLogin)
        print("更新后appTheme值", Preference.appTheme)

        
        // MARK: - 最原始的做法
        
        // 保存值
        kUserDefaults.set(12345, forKey: "Int")
        // 读取值
        let intValue = kUserDefaults.integer(forKey: "Int")
        print("intValue \(intValue)")
        
        let defaultName = kUserDefaults.string(forKey: "defaultName") ?? "a"
        print("defaultName \(defaultName)")
        
        // 与「integer」等位的有：
        kUserDefaults.object(forKey: "O")
        kUserDefaults.float(forKey: "F")
        kUserDefaults.double(forKey: "D")
        kUserDefaults.bool(forKey: "B")
        kUserDefaults.url(forKey: "U")
        kUserDefaults.string(forKey: "S")
        kUserDefaults.array(forKey: "A")
        kUserDefaults.dictionary(forKey: "Dict")
        kUserDefaults.data(forKey: "Data")
        
        // 设置默认值
        UserDefaults.standard.register(defaults: ["isDefaultlyHiddenProgressResume": true])
        
    }
}


// 优雅的做法
struct Preference {
    // bool
    static var isFirstLogin: Bool {
        get { return kUserDefaults[#function] ?? true }
        set { kUserDefaults[#function] = newValue }
        /*
         注：虽然以下代码也行，但明显以上代码更牛，虽然不清楚实现方式
         get { return kUserDefaults.bool(forKey: "isFirstLogin") }
         set { kUserDefaults.set(newValue, forKey: "isFirstLogin") }
         */
    }

    // string
    static var userName: String {
        get { return kUserDefaults[#function] ?? "" }
        set { kUserDefaults[#function] = newValue }
    }

    // enum
    static var appTheme: Theme {
        get { return kUserDefaults[#function] ?? .light }
        set { kUserDefaults[#function] = newValue }
    }
    
    // 测试服跟正式服之间的切换（默认正式服）
    static var serverUrl: ServerUrlType {
        get { return kUserDefaults[#function] ?? .distributeServer }
        set { kUserDefaults[#function] = newValue }
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



/*
 使用 UserDefaults 读取时，如果key不存在，则会返回一个默认值：

 integer(forKey:): 不存在则返回 0
 bool(forKey:): 不存在则返回 false
 String：不存在返回 nil
 float(forKey:) | double(forKey:): 如果不存在则返回 0.0
 object(forKey): 会返回 AnyObject?, 因此你需要自定义转换为你想要的返回类型，比如上面的 kUserDefaults.object(forKey: "INFO"), 自定义返回类型为 [String: String], 如果 INFO key 不存在，则给一个默认的空字符串字典 [String:String]()

 ⚠️不知为啥，在模拟器中，切换UserDefaults的值时，如果在较短时间内杀进程，会出现不保存的情况。在正常设备中又不会
 */
