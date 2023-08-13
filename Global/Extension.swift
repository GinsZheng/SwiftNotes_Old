//
//  Extension.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/25.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func removeFirstCharacter() -> String {
        return String(self[self.index(after: self.startIndex)...])
    }
    
    func removeFrontCharacters(length: Int) -> String {
        return String(self[self.index(self.startIndex, offsetBy: length-1)])
    }
    
    func isEmptyAfterTrimming(characterSet: CharacterSet = .whitespaces) -> Bool {
        if self.trimmingCharacters(in: characterSet) == "" {
            return true
        } else {
            return false
        }
    }
    
}


extension UserDefaults {
    //应用第一次启动
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunched = "hasBeenLaunched"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunched)
        if isFirstLaunch {
            UserDefaults.standard.set(true, forKey: hasBeenLaunched)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    //当前版本第一次启动
    static func isFirstLaunchOfNewVersion() -> Bool {
        //主程序版本号
        let infoDictionary = Bundle.main.infoDictionary!
        let majorVersion = infoDictionary["CFBundleShortVersionString"] as! String
        
        //上次启动的版本号
        let hasBeenLaunchedOfNewVersion = "hasBeenLaunchedOfNewVersion"
        let lastLaunchVersion = kUserDefaults.string(forKey:
            hasBeenLaunchedOfNewVersion)
         
        //版本号比较
        let isFirstLaunchOfNewVersion = majorVersion != lastLaunchVersion
        if isFirstLaunchOfNewVersion {
            kUserDefaults.set(majorVersion, forKey:
                hasBeenLaunchedOfNewVersion)
            kUserDefaults.synchronize()
        }
        return isFirstLaunchOfNewVersion
    }
    
    /// 通过下标使用枚举
    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = value(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set { set(newValue?.rawValue, forKey: key) }
    }
    
    subscript<T>(key: String) -> T? {
        get { return value(forKey: key) as? T }
        set { set(newValue, forKey: key) }
    }
    
}


