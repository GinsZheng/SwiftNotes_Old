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
    
    let itemsSQL = ItemsSQL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
//        let itemsModel = ItemsModel()
//        itemsModel.rowid = 
        
        itemsSQL.insert(tempId: 1, tempName: "name1", tempResume: "", tempTotalProgress: 500, tempColor: 1)
        
        let result = itemsSQL.search(select: [itemsSQL.rowid])
        // let result = itemsSQL.search() // Select * From table
        print(result)
        
    }
    
    
}

class ItemsModel: HandyJSON {
    var rowid: [Int] = []
    var name: [String] = []
    var resume: [String] = []
    var totalProgress: [Int] = []
    var color: [Int] = []

    required init() {}
}
