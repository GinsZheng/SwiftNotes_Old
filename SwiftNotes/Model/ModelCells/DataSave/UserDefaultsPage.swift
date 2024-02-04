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
        
        print("初始isFirstLogin值", Preferences.isFirstLogin)
        print("初始appTheme值", Preferences.appTheme)
        
        // 存储数据
        Preferences.isFirstLogin = false
        Preferences.appTheme = 1
        Preferences.serverUrl = 1
        
        // 读取数据
        print("更新后isFirstLogin值", Preferences.isFirstLogin)
        print("更新后appTheme值", Preferences.appTheme)
        
    }
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

