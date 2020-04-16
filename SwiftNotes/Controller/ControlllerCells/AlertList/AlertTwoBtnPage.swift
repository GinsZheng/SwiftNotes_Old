//
//  AlertTwoBtn.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSAlertTwoBtnPage: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        
        alertTwoBtn(title: "两个按钮", okBtnTitle: "确定") { (action) in
            print("点击了确定")
            self.dismiss()
        }
    }
    
    
}

