//
//  GlobalVariables.swift
//  MySwift
//
//  Created by GinsMac on 2019/6/2.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import Foundation
import UIKit

// 通用参数
let kScreenHeight = UIScreen.main.bounds.size.height

let kScreenWidth = UIScreen.main.bounds.size.width

//let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
var kStatusBarHeight: CGFloat {
    get {
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            print("高度？", window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 48)
            return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 88
        } else {
            return UIApplication.shared.statusBarFrame.size.height
        }
    }
}

let kNavBarHeight = kStatusBarHeight + 44

var kBottomBarHeight: CGFloat {
    get {
        if kScreenHeight > 800 {
            return 34
        } else {
            return 0
        }
    }
}

var kCardStackBarHeight: CGFloat {
    get {
        if kScreenHeight > 800 {
            return 54
        } else {
            return 40
        }
    }
}

let kTabBarHeight = kBottomBarHeight + 49

let kWithoutStatusBarHeight = kScreenHeight - kStatusBarHeight

let kWithoutNavBarHeight = kScreenHeight - kNavBarHeight

// 安全区域 = 除去状态栏与34高的底栏
let kWithoutStatusAndBottomBarHeight = kScreenHeight - kStatusBarHeight - kBottomBarHeight

var kWithoutNavAndBottomBarHeight = kScreenHeight - kNavBarHeight - kBottomBarHeight

var kWithoutNavAndTabBarHeight = kScreenHeight - kNavBarHeight - kTabBarHeight

let kScale = UIScreen.main.scale

let kSeparatorHeight = 1 / UIScreen.main.scale

// APP范围UI参数
let kButtonRadius: CGFloat = 4

let kCellHeight: CGFloat = 56

// 简称
let kUserDefaults = UserDefaults.standard
