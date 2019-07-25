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

        let myLabel = UILabel()
        myLabel.set(superview: view, text: "hehedahehedaheheda")
        myLabel.makeConstraints(left: 20, top: 200)
        myLabel.backgroundColor = UIColor.hex("ccc")

    }

}

