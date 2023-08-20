//
//  DismissPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/1.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

// 这是从List的Dismiss项进入后的第一个页面
class CSDismissAllPage1: UIViewController {
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
        self.present(toTarget: CSDismissAllPage2()) {
            print("heheda")
        }
    }
}



class CSDismissAllPage2: UIViewController {
    
    public var textStr = "Present again"
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
        button.set(superview: view, target: self, action: #selector(presentAgain))
        button.setStyleWord17ptThemeButton(title: "Present again")
        button.setFrame(centerX: view.centerX, top: label.bottom, width: 200, height: 44)
    }
    
    @objc func presentAgain() {
        self.present(toTarget: CSDismissAllPage3())
    }
}



// 这是从List的Dismiss项进入后的最后一个页面
class CSDismissAllPage3: UIViewController {
    
    public var textStr = "Dismiss all"
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
        button.set(superview: view, target: self, action: #selector(dismissAllPage))
        button.setStyleWord17ptThemeButton(title: "dismiss all")
        button.setFrame(centerX: view.centerX, top: label.bottom, width: 200, height: 44)
    }
    
    @objc func dismissAllPage() {
        self.dismissAll()
    }
}

/*
 present的回调是在present完成之后立即执行，而不是dismiss后执行
 */

