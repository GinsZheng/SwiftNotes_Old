//
//  SQLInstance.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SQLite

class SQLInstance: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        
        // 把表集中到单独的一个文件，留下表名作为读取数据库的参数
        
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
        
        
//        // 增
//        let insert = users.insert(name <- "Alice", email <- "alice@mac222.com")
//        if let rowId = try? db.run(insert) {
//            print("插入成功：\(rowId)")
//        } else {
//            print("插入失败")
//        }
//
//
//        // 查
//        for user in try! db.prepare(users) {
//            print("id: \(user[id]), name: \(user[name] ?? ""), email: \(user[email])")
//        }
        
        
        // ———— 
        // 封装创建
        let users3 = SQLiteManager().getTable(tableName: "users3")
        
        // 增
        let insert3 = users3.insert(name <- "Alice", email <- "alice@mac222.com")
        if let rowId = try? db.run(insert3) {
            print("插入成功：\(rowId)")
        } else {
            print("插入失败")
        }
        
        for user in try! db.prepare(users3) {
            print("id: \(user[id]), name: \(user[name] ?? ""), email: \(user[email])")
        }
    }
    
}

