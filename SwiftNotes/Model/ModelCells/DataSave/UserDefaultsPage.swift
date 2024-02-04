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


