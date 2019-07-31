//
//  GeneralSubpage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/16.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class GeneralSubpage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let label = UILabel()
        label.set(superview: view, text: "General SubPage")
        label.setFontStyle(color: "222", size: 34)
        label.makeConstraints(center: view)
        
        let myView = UIView()
        myView.set(superview: view)
        myView.makeConstraints(left: 0, bottom: kSafeAreaInsets.bottom, width: kScreenWidth, height: 300)
        myView.backgroundColor = UIColor.hex("2c9eff")
        print(kSafeAreaInsets.bottom)
    }
    
    
}
