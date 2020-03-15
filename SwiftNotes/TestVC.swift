//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    let basicTable = CSBasicTable()
    let joinedTable = CSJoinedTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        print("getLastest \(basicTable.getJoinedTablesJSONOneLine())")
//        print("getLastest \(basicTable.getJoinedTablesJSONOneLine())")
        
        
    }
    
    @objc func pushNext() {
        let subpage = CSGeneralSubpage()
        subpage.textStr = "传值"
        self.push(toTarget: subpage)
    }
    
}

