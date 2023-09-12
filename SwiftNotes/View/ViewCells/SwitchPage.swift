//
//  CSSwitchPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSSwitchPage: UIViewController {
    
    var boolValue1 = "boolValue1"
    var userDefaultsboolValue1 = kUserDefaults.bool(forKey: "boolValue1")
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white
        
        print("初始boolValue1", userDefaultsboolValue1)
        
        let mySwitch = UISwitch()
        mySwitch.set(superview: view, setOn: userDefaultsboolValue1, target: self, action: #selector(switchChanged(_:)))
        mySwitch.setFrame(left: 20, top: 20, width: 50, height: 30)
        
        mySwitch.onTintColor = UIColor.hex(cBlue_5393FF)
        print("初始isOn", mySwitch.isOn)
    }
    
    
    // MARK: - @objc func
    
    @objc func switchChanged(_ mySwitch: UISwitch) {
        // 点击后，isOn已经转变，即isOn相当于是点击开关发生切换后的值
        if mySwitch.isOn == true { //
            kUserDefaults.set(true, forKey: boolValue1)
        } else {
            kUserDefaults.set(false, forKey: boolValue1)
        }
        
    }
    
    
}
