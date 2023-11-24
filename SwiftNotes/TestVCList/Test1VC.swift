//
//  Test1VC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/24.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit
import Localize_Swift

class Test1VC: UIViewController {
    
    
    
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        let label = UILabel()
        label.set(superview: view, text: "已完成".localized())
        label.setStyle17pt222()
        label.setFrame(left: 20, top: 100, right: 20, height: 40)
    }
    
    
    // MARK: - 代理方法
    
    
    
    
    // MARK: - @objc func
    
    
    
    
}


