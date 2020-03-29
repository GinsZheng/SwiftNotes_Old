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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 设置导航栏左按钮
        let editButton = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(pushToGeneralSubpage))
        editButton.tintColor = .hex(cBlue_2C9EFF)
        self.navigationItem.rightBarButtonItem = editButton
        // 用图片撑起Frame
        
        // 跳转并传值
        button.set(superview: view, target: self, action: #selector(pushWithValue))
        button.setStyleSolidBtn(title: "Push with Value")
        button.setFrame(left: 20, top: 20, right: 20, height: 48)
        
    }
    
    @objc func pushToGeneralSubpage() {
        self.push(toTarget: CSGeneralSubpage())
    }
    
    @objc func pushWithValue() {
        let subpage = CSGeneralSubpage()
        subpage.textStr = "传值"
        self.push(toTarget: subpage)
    }

}
