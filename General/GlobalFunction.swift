//
//  GlobalFunction.swift
//  MySwift
//
//  Created by GinsMac on 2019/6/4.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import Foundation
import UIKit

func getImageWithColor(color: String) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context!.setFillColor(UIColor.hex(color).cgColor)
    context!.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}


// 按比例布局的因子
func s(_ number: CGFloat) -> CGFloat {
    return number / 375 * kScreenWidth
}

func u(_ number: CGFloat) -> CGFloat {
    return number / kScreenWidth * 375
}
