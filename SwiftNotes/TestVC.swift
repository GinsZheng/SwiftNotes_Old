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
        
        print(joinedTable.getCalArray())
        
        let json = joinedTable.getJSON()
        print(json)
        let model = CSJoinedModel.init(jsonData: json)
        print(model.id)
        print(model.currentProgress)
        
        
    }
    
    @objc func pushNext() {
        let subpage = CSGeneralSubpage()
        subpage.textStr = "传值"
        self.push(toTarget: subpage)
    }
    
}

