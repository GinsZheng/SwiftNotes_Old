//
//  SQLInstance.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class SQLiteManager: NSObject {
    
    private var db: Connection?
    var table: Table?

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
            print("插入成功：\(id)")
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
    
    func search(filter: Expression<Bool>? = nil, select: [Expressible], order: [Expressible], limit: Int?, offset: Int?) -> [Row] {
        
        var query = table!.select(select).order(order)
        if let f = filter {
            query = query.filter(f)
        }
        if let l = limit {
            if let o = offset{
                query = query.limit(l, offset: o)
            } else {
                query = query.limit(l)
            }
        }

        let result = try! getDB().prepare(query)
        return Array(result)
    }
    
    
}

class ItemsTable: SQLiteManager {
    
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let resume = Expression<String>("resume")
    let totalProgress = Expression<Int>("totalProgress")
    let color = Expression<Int>("color")
    
    func getTable() -> Table {
        table = super.getTable(tableName: "items") { (t) in
            t.column(id, primaryKey: true)
            t.column(name)
            t.column(resume)
            t.column(totalProgress)
            t.column(color)
        }
        return table!
    }

    
    // 增
    func insert(item: JSON) {
        
        let values = getTable().insert(
            id <- item["id"].intValue,
            name <- item["name"].stringValue,
            resume <- item["resume"].stringValue,
            totalProgress <- item["totalProgress"].intValue,
            color <- item["color"].intValue
        )
        super.insert(values)
    }
    
    // 删单条
    func delete(id rowid: Int) {
        delete(filter: id == rowid)
    }
    
    // 按条件删除
    func delete(filter: Expression<Bool>? = nil) {
        var deletedData = getTable()
        if let f = filter {
            deletedData = deletedData.filter(f)
        }
        let deleteRows = deletedData.delete()
        super.delete(deleteRows)
        // filter为nil时，全部删除
    }
    
    // 改
    func update(id rowid: Int, item: JSON) {
        
        let updatedData = getTable().filter(id == rowid)
        let values = updatedData.update(
            name <- item["name"].stringValue,
            resume <- item["resume"].stringValue,
            totalProgress <- item["totalProgress"].intValue,
            color <- item["color"].intValue
        )
        super.update(values)
    }
    
    // 查
    override func search(filter: Expression<Bool>? = nil, select: [Expressible] = [
        Expression<Int>("id"),
        Expression<String>("name"),
        Expression<String>("resume"),
        Expression<Int>("totalProgress"),
        Expression<Int>("color")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        let result = super.search(select: select, order: order, limit: limit, offset: offset)
        return Array(result)
    }
    
}
