//
//  CSButtonPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/11.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSButtonPage: UIViewController {
    
    let testInt = "testInt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        print("当前机型的逻辑分辨率：\(kScreenWidth) * \(kScreenHeight)")
        
        let wordButton = UIButton(type: .system)
        wordButton.set(superview: view, target: self, action: #selector(changeSetting))
        wordButton.setStyleWordButton(title: "Word Button")
        wordButton.setFrame(left: 20, top: 20, right: 20, height: 44)
        
        let ghostButton = UIButton(type: .system)
        ghostButton.set(superview: view, target: self, action: #selector(pushWithParameter(_:)))
        ghostButton.setStyleGhostButton(title: "Ghost Button")
        ghostButton.setFrame(left: 20, top: wordButton.bottom + 20, right: 20, height: 44)
        
        let solidButton = UIButton(type: .custom)
        solidButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        solidButton.setStyleSolidButton(title: "Solid Button")
        solidButton.setFrame(left: 20, top: ghostButton.bottom + 20, right: 20, height: 44)
        
        let solidButton2 = UIButton(type: .system)
        solidButton2.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        solidButton2.setStyleSolidButton2(title: "Solid Button2")
        solidButton2.setFrame(left: 20, top: solidButton.bottom + 20, right: 20, height: 44)
        
        let systemIconButton = UIButton(type: .system)
        systemIconButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        systemIconButton.setStyleSystemIconButton(imageName: "mine_item")
        systemIconButton.setFrame(centerX: view.centerX, top: solidButton2.bottom + 20, width: 44, height: 44)
        
        let customIconButton = UIButton(type: .custom)
        customIconButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        customIconButton.setStyleCustomIconButton(imageName: "mine_item")
        customIconButton.setFrame(centerX: view.centerX, top: systemIconButton.bottom + 20, width: 44, height: 44)
        
        let smallButton = UIButton(type: .custom)
        smallButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        smallButton.setStyleTintTitleGrayBg(title: "小按钮")
        smallButton.setFrame(centerX: view.centerX, top: customIconButton.bottom + 20, width: 58, height: 28)
        smallButton.kExpandSize()
        
        // 测试UserDefualt内容(1)
        print("testInt初始值", kUserDefaults.integer(forKey: testInt))
        
    }
    
    // 测试UserDefualt内容(2)
    @objc func changeSetting() {
        if kUserDefaults.integer(forKey: testInt) == 0 {
            kUserDefaults.set(1, forKey: testInt)
            print("testInt已改为：", kUserDefaults.integer(forKey: testInt))
        } else if kUserDefaults.integer(forKey: testInt) == 1 {
            kUserDefaults.set(0, forKey: testInt)
            print("testInt已改为：", kUserDefaults.integer(forKey: testInt))
        } else {
            print("错误")
        }
    }
    
    @objc func pushToGeneralSubpage() {
        self.pushFromSecondaryPage(toTarget: CSGeneralSubpage())
    }
    
    @objc func pushWithParameter(_ button: UIButton) {
        self.pushFromSecondaryPage(toTarget: CSGeneralSubpage())
    }
    

    
    
}


// 扩大响应区域辅助项
var expandSizeKey = "expandSizeKey"

extension UIButton {

    /// 扩大响应区域
    /// - Parameter size: size
    open func kExpandSize(size: CGFloat = 44) {
        let padding = max((size - self.height) / 2, (size - self.width) / 2)
        
         objc_setAssociatedObject(self, &expandSizeKey, padding,  objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
    }
    // 扩大响应区域辅助项
    func expandRect() -> CGRect {
         let expandSize = objc_getAssociatedObject(self, &expandSizeKey)
         if (expandSize != nil) {
              return CGRect(x: bounds.origin.x - (expandSize as! CGFloat), y: bounds.origin.y - (expandSize as! CGFloat), width: bounds.size.width + 2*(expandSize as! CGFloat), height: bounds.size.height + 2*(expandSize as! CGFloat))
         }
         return bounds
    }
    // 扩大响应区域辅助项
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
         let buttonRect = expandRect()
         if (buttonRect.equalTo(bounds)) {
             return super.point(inside: point, with: event)
         }
         return buttonRect.contains(point)
    }
    
}








//extension UIButton {
//
////    func setEnlargeEdge(top: Float, bottom: Float, left: Float, right: Float) -> Void {
////        self.top = CGFloat(NSNumber.init(value: top))
////        self.bottom = NSNumber.init(value: bottom)
////        self.left = NSNumber.init(value: left)
////        self.right = NSNumber.init(value: right)
////    }
//
//    func enlargedRect() -> CGRect {
//        let top = self.top
//        let bottom = self.bottom
//        let left = self.left
//        let right = self.right
//        if top.floatValue >= 0, bottom.floatValue >= 0, left.floatValue >= 0, right.floatValue >= 0 {
//            return CGRect.init(x: self.bounds.origin.x - CGFloat(left.floatValue),
//                               y: self.bounds.origin.y - CGFloat(top.floatValue),
//                               width: self.bounds.size.width + CGFloat(left.floatValue) + CGFloat(right.floatValue),
//                               height: self.bounds.size.height + CGFloat(top.floatValue) + CGFloat(bottom.floatValue))
//        }
//        else {
//            return self.bounds
//        }
//    }
//
//    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        let rect = self.enlargedRect()
//        if rect.equalTo(self.bounds) {
//            return super.point(inside: point, with: event)
//        }
//        return rect.contains(point) ? true : false
//    }
//}

//
//fileprivate let minimumHitArea = CGSize(width: 100, height: 100)
//
//extension UIButton {
//    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        // if the button is hidden/disabled/transparent it can't be hit
//        if self.isHidden || !self.isUserInteractionEnabled || self.alpha < 0.01 { return nil }
//
//        // increase the hit frame to be at least as big as `minimumHitArea`
//        let buttonSize = self.bounds.size
//        let widthToAdd = max(minimumHitArea.width - buttonSize.width, 0)
//        let heightToAdd = max(minimumHitArea.height - buttonSize.height, 0)
//        let largerFrame = self.bounds.insetBy(dx: -widthToAdd / 2, dy: -heightToAdd / 2)
//
//        // perform hit test on larger frame
//        return (largerFrame.contains(point)) ? self : nil
//    }
//}
////但是当我使用它时，我应用程序中的每个按钮都有较大的点击区域.我只想将其增加到一个specialButton-我该怎么做?
////
////推荐答案
////请勿扩展点击范围；缩小绘图区域.将按钮设为UIButton的子类，然后在该子类中实现rect方法，如下所示:
//
//class MyButton : UIButton {
//    override func contentRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: 30, dy: 30)
//    }
//    override func backgroundRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.insetBy(dx: 30, dy: 30)
//    }
//}
////现在该按钮可以在其可见背景之外点击30点.
////
////这篇关于如何在Swift中扩展特定UIButton的点击区域?的文章就介绍到这了，希望我们推荐的答案对大家有所帮助，也希望大家多多支持IT屋！
////
