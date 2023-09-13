//
//  popAndDismissPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/1.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
// 这是从List的PopAndDismissPage项进入后的最后一个页面
class CSPopAndDismissPage3: UIViewController {
    
    public var textStr = "Pop and dismiss page"
    let label = UILabel()
    let button = UIButton()

    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
        button.set(superview: view, target: self, action: #selector(presentAgain))
        button.setStyleWord17ptThemeButton(title: "Pop and dismiss")
        button.setFrame(centerX: view.centerX, top: label.bottom, width: 200, height: 44)
    }

    @objc func presentAgain() {
        self.dismiss()
        self.popToControllerListVC()
    }

}



// 这是从List的PopAndDismissPage项进入后的第一个页面
class CSPopAndDismissPage1: UIViewController {
    
    public var textStr = "Push First"
    let label = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
        button.set(superview: view, target: self, action: #selector(pushFirst))
        button.setStyleWord17ptThemeButton(title: "Push First")
        button.setFrame(centerX: view.centerX, top: label.bottom, width: 200, height: 44)
    }

    @objc func pushFirst() {
        self.push(toTarget: CSPopAndDismissPage2())
    }

}



class CSPopAndDismissPage2: UIViewController {
    
    public var textStr = "Present then"
    let label = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        label.set(superview: view, text: textStr)
        label.setFontStyle(size: 34, color: "222")
        label.setFrame(centerX: view.centerX, top: 200)
        
        button.set(superview: view, target: self, action: #selector(presentThen))
        button.setStyleWord17ptThemeButton(title: "Present then")
        button.setFrame(centerX: view.centerX, top: label.bottom, width: 200, height: 44)
    }

    @objc func presentThen() {
        self.present(toTarget: CSPopAndDismissPage3())
    }

}
