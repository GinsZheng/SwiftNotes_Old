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
let kHeightUnderNavBar = kScreenHeight - kNavBarHeight
let kScale = UIScreen.main.scale
let kSeparatorHeight = 1 / UIScreen.main.scale
let kSafeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero



// APP范围UI参数
let kButtonRadius: CGFloat = 4
let kCellHeight: CGFloat = 56
