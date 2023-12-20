//
//  SwitchPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class SwitchPage: UIViewController {
    
    var boolValue1 = "boolValue1"
    var userDefaultsboolValue1 = kUserDefaults.bool(forKey: "boolValue1")
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        print("初始boolValue1", userDefaultsboolValue1)
        
        let switchControl = UISwitch()
        switchControl.setup(superview: view, setOn: userDefaultsboolValue1, target: self, action: #selector(switchChanged(_:)))
        switchControl.setFrame(right: 20, top: 20)
        
        switchControl.onTintColor = UIColor.hex(cBlue_5393FF)
        print("初始isOn", switchControl.isOn)
    }
    
    
    // MARK: - @objc func
    @objc func switchChanged(_ switchControl: UISwitch) {
        // 点击后，isOn已经转变，即isOn相当于是点击开关发生切换后的值
        if switchControl.isOn == true { //
            kUserDefaults.set(true, forKey: boolValue1)
        } else {
            kUserDefaults.set(false, forKey: boolValue1)
        }
        
    }
    
    
}
