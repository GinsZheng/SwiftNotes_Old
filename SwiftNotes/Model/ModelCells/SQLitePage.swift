//
//  SQLite.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SQLite

class SQLitePage: UIViewController {
    
    let itemsModel = ItemsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        itemsModel.insert(tempId: 2, tempName: "name2", tempResume: "", tempTotalProgress: 500, tempColor: 1)
        let result = itemsModel.search(select: [itemsModel.rowid, itemsModel.name])
        // let result = itemsModel.search() // Select * From table
        print(result)
        
    }
    
    
}
