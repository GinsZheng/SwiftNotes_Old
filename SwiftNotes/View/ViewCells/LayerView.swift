//
//  LayerView.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/4/8.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit

class CSLayerView: UIViewController {
    
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        label.set(superview: view, text: "subview")
        label.setFrame(centerX: view.centerX, top: 20)
        
        // 获取子对象
        for subview in view.subviews {
            print(subview)
        }
    }
    
    
}
