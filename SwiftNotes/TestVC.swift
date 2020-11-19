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

    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        button.set(superview: view, target: self, action: #selector(presentNext))
        button.setStyleSolidBtn(title: "Test")
        button.setFrame(left: 20, top: 200, right: 20, height: 44)
        
        print("heheda")
        
        let activity = UIActivityIndicatorView()
        activity.style = .medium
        activity.setFrame(left: 100, top: 400, width: 20, height: 20)
        activity.hidesWhenStopped = false
        activity.color = .white
        activity.startAnimating()
        
    }
    
    @objc func presentNext() {
        print("pressed")
        
    }
    
    
}


