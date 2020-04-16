//
//  AlertOneBtn.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSAlertOneBtnPage: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .white
        
        alertOneBtn(title: "单个按钮", message: "随便的消息", btnTitle: "我知道了", btnStyle: .default) { (action) in
            print("点击了❲我知道了❳")
        }
    }
    
    
}

