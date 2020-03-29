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

let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height

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
