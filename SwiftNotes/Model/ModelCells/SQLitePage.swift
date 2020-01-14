//
//  SQLite.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SQLite
import HandyJSON

class SQLitePage: UIViewController {
    
    let itemsTable = ItemsTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        itemsTable.insert(tempId: 3, tempName: "name3", tempResume: "", tempTotalProgress: 500, tempColor: 1)

//        let result = itemsTable.getId(select: [itemsTable.rowid])
        let result = itemsTable.search() // Select * From table
        for item in result {
            print(item[itemsTable.rowid])
            print(item[itemsTable.name])
        }
        
        
        
    }
    
    
}
