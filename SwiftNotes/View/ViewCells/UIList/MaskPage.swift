//
//  MaskPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/9.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class MaskPage: UIViewController {

    let pickerView = UIPickerView()
    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let mask = UIView()
        // 把遮罩加到UIWindow上，才能覆盖导航栏，处于(除状态栏外的)最顶层
        UIApplication.shared.windows[0].addSubview(mask)
        mask.setBackgroundColor(color: cBlue_2C9EFF)
        mask.setFrame(allEdges: 0)
        
    }
}

