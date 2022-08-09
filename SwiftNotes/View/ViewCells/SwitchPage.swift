//
//  CSSwitchPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class CSSwitchPage: UIViewController {
    
    var boolTest = UserDefaults.standard.bool(forKey: "boolTest")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        print("boolTest", boolTest)
        
        let mySwitch = UISwitch()
        view.addSubview(mySwitch)
        mySwitch.setFrame(left: 20, top: 20, width: 50, height: 30)
        
        mySwitch.onTintColor = UIColor.hex(cBlue_5393FF)
        mySwitch.setOn(boolTest, animated: false)
        mySwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .touchUpInside)
        print("初始isOn", mySwitch.isOn)

    }
    
    @objc func switchChanged(_ mySwitch: UISwitch) {
        if boolTest == true {
            UserDefaults.standard.set(false, forKey: "boolTest")
            print("点了后 isOn应为关闭", mySwitch.isOn)
        } else {
            UserDefaults.standard.set(true, forKey: "boolTest")
            print("点了后 isOn应为打开", mySwitch.isOn)
        }

    }
    
    
}
