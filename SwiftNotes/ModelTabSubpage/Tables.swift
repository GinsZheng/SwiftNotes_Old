//
//  Tables.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/25.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite

class Tables: NSObject {
    static func getTable(db: Connection, tableName: String) -> Table {
        let users3 = Table("users3")
        let id = Expression<Int64>("id")
        let name = Expression<String?>("name")
        let email = Expression<String>("email")
        
        try! db.run(users3.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
            
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(email, unique: true)
            
        })
        )
        return users3
    }
}
