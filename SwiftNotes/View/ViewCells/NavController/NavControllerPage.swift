//
//  CSNavControllerPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSNavControllerPage: UIViewController {
    
    let button = UIButton()
    let button2 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 设置导航栏左按钮
        let editButton = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(pushToGeneralSubpage))
        editButton.tintColor = .hex(cBlue_5393FF)
        self.navigationItem.rightBarButtonItem = editButton
        // 用图片撑起Frame
        
        // 跳转并传值
        button.set(superview: view, target: self, action: #selector(pushWithValue))
        button.setStyleSolidBtn(title: "传值")
        button.setFrame(left: 20, top: 20, right: 20, height: 48)
        
        button2.set(superview: view, target: self, action: #selector(hideNavBarBackBtn))
        button2.setStyleSolidBtn(title: "隐藏导航栏")
        button2.setFrame(left: 20, top: button.bottom + 12, right: 20, height: 48)
        
    }
    
    @objc func pushToGeneralSubpage() {
        self.push(toTarget: CSGeneralSubpage())
    }
    
    @objc func pushWithValue() {
        let subpage = CSGeneralSubpage()
        subpage.textStr = "传值"
        self.push(toTarget: subpage)
    }
    
    @objc func hideNavBarBackBtn() {
        self.push(toTarget: CSHideBackBtnPage())
    }
    
}