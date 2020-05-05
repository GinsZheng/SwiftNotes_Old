//
//  GlobalFunction.swift
//  MySwift
//
//  Created by GinsMac on 2019/6/4.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import Foundation
import UIKit

func getImageFromView(view: UIView) -> UIImage{
    UIGraphicsBeginImageContextWithOptions(view.size, false, kScale) // 创建一个图形上下文
    view.layer.render(in: UIGraphicsGetCurrentContext()!) // 将视图的图层渲染到创建的图形上下文
    let image = UIGraphicsGetImageFromCurrentImageContext() // 从绘制到图形上下文中的内容创建一个UIImage对象
    UIGraphicsEndImageContext() // 清理图形上下文
    return image!
}

//func getImageOfScreenshot(uiView: UIView, opaque: Bool = true) -> UIImage {
//    UIGraphicsBeginImageContextWithOptions(uiView.layer.frame.size, opaque, kScale)
//    uiView.layer.render(in: UIGraphicsGetCurrentContext()!)
//    let tempImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    // Save it to the camera roll
//    // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
//    return image!
//}
/*
 目前暂不清楚怎么获取整个页面的截图，会缺状态栏、导航栏、标签栏
 去调取照片库是另一种思路
 */

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


// 时间戳转成字符串
func getTimeStrWithTimeStamp(timeStamp: Int, dateFormat:String = "yyyy/M/d HH:mm:ss") -> String {
    let date:NSDate = NSDate.init(timeIntervalSince1970: TimeInterval(timeStamp))
    let formatter = DateFormatter.init()
    formatter.dateFormat = dateFormat
    return formatter.string(from: date as Date)
}

// 字符串转时间戳
func getTimeStampWithTimeStr(timeStr: String, dateFormat:String) -> Int {
    let format = DateFormatter.init()
    format.dateStyle = .medium
    format.timeStyle = .short
    format.dateFormat = dateFormat
    let date = format.date(from: timeStr)
    return Int(date!.timeIntervalSince1970)
}

// date类型转时间戳
func getTimeStampWithDate(date: Date) -> Int {
    return Int(date.timeIntervalSince1970)
}

// 获取当前时间戮
func getTimeStampNow() -> Int {
    return Int(Date().timeIntervalSince1970)
}

// 获取当日零点时间戳
func getTimeStampOfTheBeginingToday() -> Int {
    let calendar = NSCalendar.current
    var componts = calendar.dateComponents([.weekday, .year, .month, .day], from: Date())
    componts.day = componts.day!
    let result = Int(calendar.date(from: componts)?.timeIntervalSince1970 ?? 0.0)
    return result
}

func round(_ value: Double, decimalPlaces: Int) -> Double {
    let divisor = pow(10.0, Double(decimalPlaces))
    return (value * divisor).rounded() / divisor
}

func floor(_ value: Double, decimalPlaces: Int = 0) -> Double {
    let divisor = pow(10.0, Double(decimalPlaces))
    return Double(Int(value * divisor)) / divisor
}
