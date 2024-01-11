//
//  LayerView.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/8.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class LayerView: UIViewController {
    
    let label = UILabel()
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        label.setup(superview: view, text: "subview")
        label.setFrame(centerX: view.centerX, top: 20)
        
        // 获取子对象
        for subview in view.subviews {
            print(subview)
        }
    }
    
    
}

