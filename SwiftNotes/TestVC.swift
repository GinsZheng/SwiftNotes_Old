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
    
    override func viewDidAppear(_ animated: Bool) {

        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        self.title = "Test"
        
        myView.setGradientLayer(colors: [UIColor.hex(cBlue_2C9EFF).cgColor, UIColor.hex(cBlue_2C9EFF_90).cgColor], locations: [0, 1], startPoint: CGPoint.init(x: 0, y: 0), endPoint: CGPoint.init(x: 0, y: 1))
    }
}

