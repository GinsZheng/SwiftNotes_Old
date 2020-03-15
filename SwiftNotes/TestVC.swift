//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let itemTable = CSBasicTable()
    let joinedTable = CSJoinedTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
//        print(joinedTable.getCount())
//        print(itemTable.getCount())
//
//        print(joinedTable.delete())
//        print(itemTable.delete())
        print(joinedTable.createTime)
    }
    
    @objc func pushNext() {
        let subpage = CSGeneralSubpage()
        subpage.textStr = "传值"
        self.push(toTarget: subpage)
    }
    
}

