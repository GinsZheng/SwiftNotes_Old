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
        myView.set(superview: view, backgroundColor: cF5F6F8)
        myView.setFrame(left: 20, top: 20, width: 200, height: 100)
        
        
        let myView2 = UIView()
        myView2.setBackgroundColor(color: cBlue_2C9EFF)
        myView2.set(superview: view)
        myView2.setFrame(left: 20, top: 220, width: 200, height: 66)
        myView2.setCornerRadius(radius: 16, corners: [.topRight, .bottomRight])
        
        
        
    }
    
    
}

