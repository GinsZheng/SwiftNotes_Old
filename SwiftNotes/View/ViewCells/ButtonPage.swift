//
//  ButtonPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/11.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ButtonPage: UIViewController {
    
    let testInt = "testInt"
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        print("sta", kNavBarHeight, kStatusBarHeight)
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        print("当前机型的逻辑分辨率：\(kScreenWidth) * \(kScreenHeight)")
        
        let wordButton = UIButton(type: .custom)
        wordButton.set(superview: view, target: self, action: #selector(changeSetting))
        wordButton.setStyleWord17ptThemeButton(title: "纯文")
        wordButton.setFrame(left: 20, top: 20, right: 20, height: 44)
        
        let IconButton = UIButton(type: .custom)
        IconButton.set(superview: view, target: self, action: #selector(changeSetting))
        IconButton.setStyleIconButton(imageName: "mine_item")
        IconButton.setFrame(centerX: view.centerX, top: wordButton.bottom + 20, width: 26, height: 26)
        
        let WordBgButton = UIButton(type: .custom)
        WordBgButton.set(superview: view, target: self, action: #selector(changeSetting))
        WordBgButton.setStyleSolid17ptFgWhiteThemeButton(title: "文字&背景")
        WordBgButton.setFrame(left: 20, top: IconButton.bottom + 20, right: 20, height: 44)
        
        let ghostButton = UIButton(type: .custom)
        ghostButton.set(superview: view, target: self, action: #selector(changeSetting))
        ghostButton.setStyleGhostButton(title: "幽灵", titleSize: 17, titleColor: cThemeWord, borderColor: cThemeWord, radius: 10)
        ghostButton.setFrame(left: 20, top: WordBgButton.bottom + 20, right: 20, height: 44)
        
        let wordIconButton = UIButton(type: .custom)
        wordIconButton.set(superview: view, target: self, action: #selector(changeSetting))
        wordIconButton.setStyleWordIconButton(title: "图文", titleSize: 17, titleColor: cThemeWord, imageName: "tickets_refund", imageLocation: .left, interval: 3)
        wordIconButton.setFrame(left: 20, top: ghostButton.bottom + 20, right: 20, height: 44)
        
        let WordIconBgButton = UIButton(type: .custom)
        WordIconBgButton.set(superview: view, target: self, action: #selector(changeSetting))
        WordIconBgButton.setStyleWordIconBgButton(title: "图文&背景", titleSize: 17, titleColor: cFgWhite, imageName: "general_adding_btn", imageLocation: .left, interval: 3, bgImage: getImageWithColor(color: cThemeFill), radius: 10)
        WordIconBgButton.setFrame(left: 20, top: wordIconButton.bottom + 20, right: 20, height: 44)
        
        // 测试UserDefualt内容(1)
        print("testInt初始值", kUserDefaults.integer(forKey: testInt))
        
        // 测试用，以后要删
//        let vv = UIView()
//        vv.set(superview: view, backgroundColor: cRed_FF635A)
//        vv.setFrame(left: 10, top: 100, right: 10, height: 500)
//        
//        let AButton = UIButton(type: .custom)
//        AButton.set(superview: vv, target: self, action: #selector(changeSetting))
//        AButton.setStyleSolid17ptFgWhiteThemeButton(title: "Here")
//        AButton.setFrame(left: 5, bottom: 5, right: 5, height: 44)
//        let bButton = UIButton(type: .custom)
//        bButton.set(superview: view, target: self, action: #selector(changeSetting))
//        bButton.setStyleSolid17ptFgWhiteThemeButton(title: "Here")
//        bButton.setFrame(left: 5, bottom: 5, right: 5, height: 44)
//
//        // view的高度是全屏高，但view的y值的0点却是导航栏底边
    }
    
    
    // MARK: - @objc func
    
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


//// 扩大响应区域辅助项
//var expandSizeKey = "expandSizeKey"
//
//extension UIButton {
//
//    /// 扩大响应区域 (把宽高44pt以下的部分扩大到44pt)
//    /// - Parameter size: size
//    open func kExpandSize() {
//        let size: CGFloat = 44 // 最小响应区域的宽/高
//        let padding = max((size - self.height) / 2, (size - self.width) / 2)
//        objc_setAssociatedObject(self, &expandSizeKey, padding,  objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
//    }
//    // 扩大响应区域辅助项
//    func expandRect() -> CGRect {
//        let expandSize = objc_getAssociatedObject(self, &expandSizeKey)
//        let size: CGFloat = 44  // 最小响应区域的宽/高
//         if (expandSize != nil) {
//             if self.height >= size {
//                 return CGRect(x: bounds.origin.x - (expandSize as! CGFloat), y: bounds.origin.y, width: bounds.size.width + 2*(expandSize as! CGFloat), height: bounds.size.height)
//             } else if self.width >= size {
//                 return CGRect(x: bounds.origin.x, y: bounds.origin.y - (expandSize as! CGFloat), width: bounds.size.width, height: bounds.size.height + 2*(expandSize as! CGFloat))
//             } else {
//                 return CGRect(x: bounds.origin.x - (expandSize as! CGFloat), y: bounds.origin.y - (expandSize as! CGFloat), width: bounds.size.width + 2*(expandSize as! CGFloat), height: bounds.size.height + 2*(expandSize as! CGFloat))
//             }
//         }
//         return bounds
//    }
//    // 扩大响应区域辅助项
//    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//         let buttonRect = expandRect()
//         if (buttonRect.equalTo(bounds)) {
//             return super.point(inside: point, with: event)
//         }
//         return buttonRect.contains(point)
//    }
//
//
//
//}




