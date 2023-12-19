//
//  DisablePopGesturePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/19.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSDisablePopGesturePage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 禁用侧滑返回
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
}

