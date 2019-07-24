//
//  SwitchPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/14.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class SwitchPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let mySwitch = UISwitch()
        view.addSubview(mySwitch)
        mySwitch.makeConstraints(left: 20, top: 100, width: 50, height: 30)
        
        mySwitch.onTintColor = UIColor.hex("2c9eff")
        mySwitch.setOn(true, animated: false)
    }
    
    
}
