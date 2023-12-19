//
//  CSMaskPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/9.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSMaskPage: UIViewController {

    let mask = UIView()
    
    // MARK: - 生命周期方法

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.pop()
        mask.removeFromSuperview()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        // 把遮罩加到UIWindow上，才能覆盖导航栏，处于(除状态栏外的)最顶层
        UIApplication.shared.windows[0].addSubview(mask)
        mask.setBackgroundColor(color: c000309_40_mask)
        mask.isUserInteractionEnabled = false
        mask.setFrame(allEdges: 0)
    }
}

