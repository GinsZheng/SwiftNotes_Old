//
//  NavControllerPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class NavControllerPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 设置导航栏左按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "adding"), style: .plain, target: self, action: #selector(pushToGeneralSubpage))
        // 用图片撑起Frame
    }
    
    @objc func pushToGeneralSubpage() {
        self.push(toTarget: GeneralSubpage())
    }
}

