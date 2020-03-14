//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        button.set(superview: view, target: self, action: #selector(pushNext))
        button.setStyleSolidBtn(title: "test")
        button.setFrame(left: 20, top: 20, right: 20, height: 48)
    }
    
    @objc func pushNext() {
        let subpage = GeneralSubpage()
        subpage.textStr = "传值"
        self.push(toTarget: subpage)
    }
    
}

