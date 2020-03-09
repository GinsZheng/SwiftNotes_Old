//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let pickerView = UIPickerView()
    let myView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let mask = UIView()
        UIApplication.shared.keyWindow?.addSubview(mask)
        mask.setBackgroundColor(color: cBlue_2C9EFF)
        mask.setFrame(allEdges: 0)
        
    }
}

