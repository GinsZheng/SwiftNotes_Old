//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let model = CSBasicModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let result = model.getJSONOneRow(id: 0)
//        let results = model.getJSON()
        
    }
    
    @objc func pushNext() {
        let subpage = CSGeneralSubpage()
        subpage.textStr = "传值"
        self.push(toTarget: subpage)
    }
    
}

