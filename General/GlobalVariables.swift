//
//  GlobalVariables.swift
//  MySwift
//
//  Created by GinsMac on 2019/6/2.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import Foundation
import UIKit

let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenWidth = UIScreen.main.bounds.size.width
let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let kNavBarHeight = kStatusBarHeight + 44
let kHeightWithoutNavBar = kScreenHeight - kNavBarHeight
let kTabBarHeight: CGFloat = 49

let kCellHeight: CGFloat = 56
let kSeparatorHeight = 1 / UIScreen.main.scale
let kSafeAreaInsets = UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero

let kMyGod = 44
