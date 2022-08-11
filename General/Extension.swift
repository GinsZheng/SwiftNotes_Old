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



extension UIButton {
    func setStyleCloseBtn() {
        self.setImage(UIImage(named: "nav_close"), for: .normal)
    }
    
    func setStyleSolidAddingBtn(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cFEFEFE), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 0)
        self.setImage(UIImage(named: "general_adding_btn"), for: .normal)
        self.setImage(UIImage(named: "general_adding_btn"), for: .highlighted)
        self.setImage(UIImage(named: "general_adding_btn"), for: .disabled)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 3)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF_40), for: .disabled)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF_60), for: .highlighted)
        self.setCornerRadiusWithMask(radius: 8)
        
    }
    
    func setStyleSolidBtn(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cFEFEFE), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF_40), for: .disabled)
        self.setBackgroundImage(getImageWithColor(color: cBlue_5393FF_60), for: .highlighted)
        self.setCornerRadiusWithMask(radius: 8)
    }
    
    func setStyleGhostBtn(title: String) {
        self.setStyleGhostButton(title: title, borderWidth: 1, cornerRadius: 8)
    }
    
    func setStyleAddItemBarBtn(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(c999), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 18, weight: .medium)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        self.setImage(UIImage(named: "progress_adding"), for: .normal)
        self.setImage(UIImage(named: "progress_adding"), for: .highlighted)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 2)
        self.setBackgroundImage(getImageWithColor(color: cE6E7E9), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cDDDEE0), for: .highlighted)
        self.setCornerRadiusWithMask(radius: 8)
    }
    
    func setStyleCutsomCancelBtn(title: String) {
        self.setStyleWordButton(title: title, titleSize: 14, titleColor: c999, titleWeight: .regular)
    }
    
    func setStyleArrow(title: String, imageName: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cBlue_5393FF), for: .normal)
        self.setTitleColor(.hex(cBlue_5393FF_60), for: .highlighted)
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        self.contentHorizontalAlignment = .left  // 文本左对齐
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -18, bottom: 0, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.width - 1 - 18, bottom: 0, right: 0)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setImage(UIImage(named: imageName)?.withAlpha(0.6), for: .highlighted)
    }
    
    func setStyleTintTitleGrayBg(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(cBlue_5393FF), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        self.setBackgroundImage(getImageWithColor(color: cF0F1F3), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cDDDEE0), for: .highlighted)
        
        self.setCornerRadiusWithMask(radius: 14)
    }
    
}



extension UIStackView {
    func setStyleColorCircleStack(spacing: CGFloat) {
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = spacing
    }
}



// ————————————————
// SwiftNotes

extension UIButton {
    func setStyleWordButton(title: String, titleSize: CGFloat = 17, titleColor: String = cThemeWord, titleWeight: UIFont.Weight = .medium) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.hex(titleColor), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: titleSize, weight: titleWeight)
    }
    
    func setStyleGhostButton(title: String, titleSize: CGFloat = 17, titleColor: String = cThemeWord, titleWeight: UIFont.Weight = .medium, borderColor: String = cThemeBorder, borderWidth: CGFloat = 0.5, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(UIColor.hex(titleColor), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight) // 这里设置UILabel的颜色值将无效
        self.setBorder(color: cThemeBorder, borderWidth: borderWidth)
        self.setCornerRadius(radius: cornerRadius)
    }
    
    func setStyleSolidButton(title: String, titleSize: CGFloat = 17, titleColor: String = cFEFEFE, titleWeight: UIFont.Weight = .medium, fillColor: String = cThemeFill, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(titleColor), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight)
        self.setBackgroundImage(getImageWithColor(color: cThemeFill), for: .normal)
        self.setBackgroundImage(getImageWithColor(color: cThemeHightlightedFill), for: .highlighted)
        self.setBackgroundImage(getImageWithColor(color: cThemeDisabledFill), for: .disabled)
        self.setCornerRadiusWithMask(radius: cornerRadius)
    }
    
    func setStyleSolidButton2(title: String, titleSize: CGFloat = 17, titleColor: String = cFEFEFE, titleWeight: UIFont.Weight = .medium, fillColor: String = cThemeFill, cornerRadius: CGFloat = kButtonRadius) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.hex(titleColor), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: titleSize, weight: titleWeight)
        self.setBackgroundImage(getImageWithColor(color: cThemeFill), for: .normal)
        self.setCornerRadiusWithMask(radius: cornerRadius)
    }
    
    func setStyleSystemIconButton(imageName: String, backgroundImage: UIImage = getImageWithColor(color: cNoColor), cornerRadius: CGFloat = 0) {
        self.tintColor = .hex(c222)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.setBackgroundImage(backgroundImage, for: .normal)
        self.setCornerRadiusWithMask(radius: cornerRadius)
    }
    
    func setStyleCustomIconButton(imageName: String) {
        self.setImage(UIImage(named: imageName), for: .normal)
    }
}


extension UIImageView {
    func setStyleNote() {
        self.setStyleImageView(cornerRadius: 8)
        self.setBorder(color: cBlue_5393FF, borderWidth: 1)
    }
}


extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}



//// MARK:- 一、基本的扩展
//public extension UIImage {
//    // MARK: 1.1、设置图片的圆角
//    /// 设置图片的圆角
//    /// - Parameters:
//    ///   - radius: 圆角大小 (默认:3.0,图片大小)
//    ///   - corners: 切圆角的方式
//    ///   - imageSize: 图片的大小
//    /// - Returns: 剪切后的图片
//    func isRoundCorner(radius: CGFloat = 3, byRoundingCorners corners: UIRectCorner = .allCorners, imageSize: CGSize?) -> UIImage? {
//        let weakSize = imageSize ?? size
//        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: weakSize)
//        // 开始图形上下文
//        UIGraphicsBeginImageContextWithOptions(weakSize, false, UIScreen.main.scale)
//        guard let contentRef: CGContext = UIGraphicsGetCurrentContext() else {
//            // 关闭上下文
//            UIGraphicsEndImageContext();
//            return nil
//        }
//        // 绘制路线
//        contentRef.addPath(UIBezierPath(roundedRect: rect,
//                                    byRoundingCorners: UIRectCorner.allCorners,
//                                    cornerRadii: CGSize(width: radius, height: radius)).cgPath)
//        // 裁剪
//        contentRef.clip()
//        // 将原图片画到图形上下文
//        draw(in: rect)
//        contentRef.drawPath(using: .fillStroke)
//        guard let output = UIGraphicsGetImageFromCurrentImageContext() else {
//        // 关闭上下文
//            UIGraphicsEndImageContext();
//            return nil
//        }
//       // 关闭上下文
//        UIGraphicsEndImageContext();
//        return output
//    }
//    // MARK: 1.2、设置圆形图片
//    /// 设置圆形图片
//    /// - Returns: 圆形图片
//    func isCircleImage() -> UIImage? {
//        return isRoundCorner(radius: (self.size.width < self.size.height ? self.size.width : self.size.height) / 2.0, byRoundingCorners: .allCorners, imageSize: self.size)
//    }
//    // MARK: 1.4、layer 转 image
//    /// layer 转 image
//    /// - Parameters:
//    ///   - layer: layer 对象
//    ///   - scale: 缩放比例
//    /// - Returns: 返回转化后的 image
//    static func image(from layer: CALayer, scale: CGFloat = 0.0) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, scale)
//        defer {
//            UIGraphicsEndImageContext()
//        }
//        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
//        layer.render(in: ctx)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        return image
//    }
//    // MARK: 1.5、设置图片透明度
//    /// 设置图片透明度
//    /// alpha: 透明度
//    /// - Returns: newImage
//    func imageByApplayingAlpha(_ alpha: CGFloat) -> UIImage {
//        UIGraphicsBeginImageContext(size)
//        let context = UIGraphicsGetCurrentContext()
//        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        context?.scaleBy(x: 1, y: -1)
//        context?.translateBy(x: 0, y: -area.height)
//        context?.setBlendMode(.multiply)
//        context?.setAlpha(alpha)
//        context?.draw(self.cgImage!, in: area)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return newImage ?? self
//    }
//    // MARK: 1.6、裁剪给定区域
//    /// 裁剪给定区域
//    /// - Parameter crop: 裁剪区域
//    /// - Returns: 剪裁后的图片
//     func cropWithCropRect( _ crop: CGRect) -> UIImage? {
//        let cropRect = CGRect(x: crop.origin.x * self.scale, y: crop.origin.y * self.scale, width: crop.size.width * self.scale, height: crop.size.height *  self.scale)
//        if cropRect.size.width <= 0 || cropRect.size.height <= 0 {
//            return nil
//        }
//       var image:UIImage?
//        autoreleasepool{
//            let imageRef: CGImage?  = self.cgImage!.cropping(to: cropRect)
//            if let imageRef = imageRef {
//                image = UIImage(cgImage: imageRef)
//            }
//        }
//        return image
//    }
//    // MARK: 1.7、给图片添加文字水印
//    /// 给图片添加文字水印
//    /// - Parameters:
//    ///   - drawTextframe: 水印的 frame
//    ///   - drawText: 水印文字
//    ///   - withAttributes: 水印富文本
//    /// - Returns: 返回水印图片
//    func drawTextInImage(drawTextframe: CGRect, drawText: String, withAttributes: [NSAttributedString.Key : Any]? = nil) -> UIImage {
//        // 开启图片上下文
//        UIGraphicsBeginImageContext(self.size)
//        // 图形重绘
//        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
//        // 水印文字属性
//        let attributes = withAttributes
//        // 水印文字和大小
//        let text = NSString(string: drawText)
//        // 获取富文本的 size
//        // let size = text.size(withAttributes: attributes)
//        // 绘制文字
//        text.draw(in: drawTextframe, withAttributes: attributes)
//        // 从当前上下文获取图片
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        // 关闭上下文
//        UIGraphicsEndImageContext()
//
//        return image!
//    }
//}
