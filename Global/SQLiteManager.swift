//
//  SQLiteManager.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/15.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import SQLite
import SwiftyJSON

class SQLiteManager: NSObject {
    
    var db: Connection?
    private var table: Table?

    func getDB() -> Connection {

        if db == nil {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
                ).first!
            db = try! Connection("\(path)/db.sqlite3")
            db?.busyTimeout = 5.0
            print("已连接数据库")
        }
        return db!
    }
    
    func getTable(tableName: String, temporary: Bool = false, ifNotExists: Bool = true, withoutRowid: Bool = false, block: (TableBuilder) -> Void) -> Table {
        
        if table == nil {
            table = Table(tableName)
            
            try! getDB().run(table!.create(temporary: temporary, ifNotExists: ifNotExists, withoutRowid: withoutRowid, block: block))
        }
        return table!
    }
    
    func insert(_ values: Insert) {
        if let id = try? getDB().run(values) {
            print("插入成功：id=\(id)")
        } else {
            print("插入失败")
        }
    }
    
    func delete(_ deleteRows: Delete) {
        if let count = try? getDB().run(deleteRows) {
            print("删除的条数为：\(count)")
        } else {
            print("删除失败")
        }
    }
    
    func update(_ values: Update) {
        if let query = try? getDB().run(values) {
            print("修改的结果为：\(query == 1)")
        } else {
            print("修改失败")
        }
    }
    
    func search(_ query: QueryType, filter: Expression<Bool>? = nil, select: [Expressible], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        var filtratedQuery = query
        if let f = filter {
            filtratedQuery = filtratedQuery.filter(f)
        }
        if let l = limit {
            if let o = offset{
                filtratedQuery = filtratedQuery.limit(l, offset: o)
            } else {
                filtratedQuery = filtratedQuery.limit(l)
            }
        }
        let result = try! getDB().prepare(filtratedQuery)
        print("查询结果：")
        return Array(result)
    }
    
    func addColumn<V:Value>(table: Table, columnName: String, column:Expression<V>, defaultValue:V) {
        do {
            var isExist = false
            let expression = table.expression
            let colunmnNames = try getDB().prepare(expression.template,expression.bindings).columnNames
            for colName in colunmnNames {
                if colName == columnName {
                    isExist = true
                    print("已添加过字段 \(columnName)")
                    break
                }
            }
            
            if !isExist {
                do {
                    try getDB().run(table.addColumn(column, defaultValue:defaultValue))
                    print("成功新增字段 \(columnName)")
                } catch {
                    print("addError")
                }
            }
        } catch {
            
        }
    }

    
}


//class SQLiteOperation {
//    class func addColumn<V: Value>(table:Table, db: Connection, columnName:String, column:Expression<V>, defaultValue:V) {
//        do {
//            var isExist = false
//            let expression = table.expression
//            let colunmnNames = try db.prepare(expression.template,expression.bindings).columnNames
//            for colName in colunmnNames {
//                if colName == columnName {
//                    isExist = true
//                    print("已存在字段 \(columnName)")
//                    break
//                }
//            }
//
//            if !isExist {
//                do {
//                    try db.run(table.addColumn(column, defaultValue: defaultValue))
//                    print("新增字段 \(columnName)")
//                } catch {
//                    print("addError")
//                }
//            }
//
//        } catch {
//            print("出错")
//        }
//
//    }
//}
//
