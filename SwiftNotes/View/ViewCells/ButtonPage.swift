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
        
        let withIconButton = UIButton(type: .custom)
        withIconButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        withIconButton.setStyleSolidWithIconButton(title: "Solid Button3")
        let btnWidth = withIconButton.titleLabel?.getLabelWidth() ?? 0
        withIconButton.setFrame(centerX: view.centerX, top: solidButton2.bottom + 20, width: btnWidth + 24 + 3, height: 44)
        
        let systemIconButton = UIButton(type: .system)
        systemIconButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        systemIconButton.setStyleSystemIconButton(imageName: "mine_item")
        systemIconButton.setFrame(centerX: view.centerX, top: withIconButton.bottom + 20, width: 44, height: 44)

        let customIconButton = UIButton(type: .custom)
        customIconButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        customIconButton.setStyleCustomIconButton(imageName: "mine_item")
        customIconButton.setFrame(centerX: view.centerX, top: systemIconButton.bottom + 20, width: 44, height: 44)
        
        let smallButton = UIButton(type: .custom)
        smallButton.set(superview: view, target: self, action: #selector(pushToGeneralSubpage))
        smallButton.setStyleTintTitleGrayBg(title: "小按钮")
        smallButton.setFrame(centerX: view.centerX, top: customIconButton.bottom + 20, width: 58, height: 28)
        smallButton.expendTouchArea()
        
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




