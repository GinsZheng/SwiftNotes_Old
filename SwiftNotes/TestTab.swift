//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit


class TestTab: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        let myView = UIView()
//        myView.makeConstraintsToLeftTop(left: 20, top: 100, width: 100, height: 100)
//        myView.set(parentView: view)
//        myView.backgroundColor = UIColor.hex("2c9eff")
//        myView.centerX = 100
        let myLabel = UILabel()
        myLabel.set(parentView: view, text: "hehedahehedaheheda")
//        myLabel.makeConstraintsToLeftTop(left: 20, top: 200)
        myLabel.makeConstraintsToLeftCenterY(left: 20, centerY: view)
        myLabel.backgroundColor = UIColor.hex("ccc")

    }

}

