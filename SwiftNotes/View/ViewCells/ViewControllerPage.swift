//
//  CSViewControllerPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2022/8/14.
//  Copyright © 2022 GinsMac. All rights reserved.
//

import UIKit

class CSViewControllerPage: UIViewController {
    
    
    // viewDidLoad: 只在从父页面进入时本页才加载，从子页面返回本页时不加载
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
    }
    
    // viewWillAppear：进入和返回都加载
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setBackgroundColor(color: cF5F6F8)
    }
    
}

/*
 viewDidLoad先于viewWillAppear执行。所以当二者同时存在且有冲突时(比如同时设置了背景色)，将以后执行的viewWillAppear为准
 */
