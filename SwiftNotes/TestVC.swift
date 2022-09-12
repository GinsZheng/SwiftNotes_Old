//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON

class TestVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let myView = CSEditableTextView()
        myView.set(superview: view, placeholder: "在在在在在在在在在在在在在在在在在在在iiiii")
        myView.setFrame(left: 20, top: 20, right: 20, height: 100)
        myView.setBackgroundColor(color: cF0F1F3)
        
    }
    
    @objc func presentNext() {
        print("pressed")
    }
    
}

