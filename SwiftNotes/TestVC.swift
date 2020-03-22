//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let itemTable = CSItemsTable()
    let progressTable = CSProgressTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        print("progressTable.getCalArray2() \(progressTable.getCalArray2())")
//        let json = progressTable.g
    }
    
    @objc func pushNext() {
        let subpage = CSGeneralSubpage()
        subpage.textStr = "传值"
        self.push(toTarget: subpage)
    }
    
}

