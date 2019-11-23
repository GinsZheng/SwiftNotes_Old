//
//  ViewPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/25.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class ViewPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let myView = UIView()
        myView.set(superview: view)
        myView.makeConstraints(left: 20, top: 100, width: 200, height: 100)
        
        myView.backgroundColor = UIColor.hex(cF5F6F8)
        
        
    }
    
    
}

