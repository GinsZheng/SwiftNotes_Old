//
//  DismissPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/5/15.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSDismissPage1: UIViewController {
    
    public var textStr = "Present"
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
        button.set(superview: view, target: self, action: #selector(presentPage))
        button.setStyleWord17ptThemeButton(title: "Present")
        button.setFrame(centerX: view.centerX, top: label.bottom, width: 200, height: 44)
    }
    
    @objc func presentPage() {
        self.present(toTarget: CSDismissPage2()) {
            print("heheda")
        }
    }
}



class CSDismissPage2: UIViewController {
    
    public var textStr = "Dismiss"
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
        button.set(superview: view, target: self, action: #selector(dismissAllPage))
        button.setStyleWord17ptThemeButton(title: "dismiss")
        button.setFrame(centerX: view.centerX, top: label.bottom, width: 200, height: 44)
        
        // present取消下滑返回 | 下滑关闭 | 模态
        self.isModalInPresentation = true
    }
    
    @objc func dismissAllPage() {
        self.dismissAll()
    }
}
