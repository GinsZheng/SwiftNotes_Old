//
//  SQLite.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SQLite

class SQLiteBasic: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        print("Success")
        
        // 创建数据库|读取数据库
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        let db = try! Connection("\(path)/db.sqlite3")
        db.busyTimeout = 5.0 // 线程安全设置
        
        
        // 创建表
        let users = Table("users")
        let id = Expression<Int64>("id")
        let name = Expression<String?>("name")
        let email = Expression<String>("email")

        try! db.run(users.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
            
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(email, unique: true)
            
            })
        )
 
        
        // 增
        let insert = users.insert(name <- "Alice", email <- "alice@mac.com")
        if let rowId = try? db.run(insert) {
            print("插入成功：\(rowId)")
        } else {
            print("插入失败")
        }
        // INSERT INTO "users" ("name", "email") VALUES ('Alice', 'alice@mac.com')
        
        
        // 改
        let filter = users.filter(id == rowid)
        if let count = try? db.run(filter.update(email <- email.replace("mac.com", with: "me.com"))) {
            print("修改的条数为：\(count)")
        } else {
            print("修改失败")
        }
        
        
        // 查
        for user in try! db.prepare(users) {
            print("id: \(user[id]), name: \(user[name]), email: \(user[email])")
            // id: 1, name: Optional("Alice"), email: alice@mac.com
        }
        // SELECT * FROM "users"
        
        
        // 删
        let filter2 = users.filter(id == rowid)
        if let count = try? db.run(filter2.delete()) {
            print("删除的条数为：\(count)")
        } else {
            print("删除失败")
        }
        
        
        // SQL语句编写
        let stmt = try! db.prepare("INSERT INTO users (email) VALUES (?)")
        for email in ["betty@icloud.com", "cathy@icloud.com"] {
            try! stmt.run(email)
        }
        
        db.totalChanges    // 3
        db.changes         // 1
        db.lastInsertRowid // 3
        
        for row in try! db.prepare("SELECT id, email FROM users") {
            print("id: \(row[0]), email: \(row[1])")
            // id: Optional(2), email: Optional("betty@icloud.com")
            // id: Optional(3), email: Optional("cathy@icloud.com")
        }
        
        // 返回单个值
        let SQLTest = try! db.scalar("SELECT count(*) FROM users")
        print(SQLTest ?? 0)
    }
    
    
}

