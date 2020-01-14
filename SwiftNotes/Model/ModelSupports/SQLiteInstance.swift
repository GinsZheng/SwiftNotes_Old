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
    
}

class ItemsSQL: SQLiteManager {
    
    private var itemsTable: Table?
    let rowid = Expression<Int>("id")
    let name = Expression<String>("name")
    let resume = Expression<String>("resume")
    let totalProgress = Expression<Int>("totalProgress")
    let color = Expression<Int>("color")
    
    func getItemsTable() -> Table {
        
        if itemsTable == nil {
            itemsTable = Table("items")
            
            try! getDB().run(itemsTable!.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
                t.column(rowid, primaryKey: true)
                t.column(name)
                t.column(resume)
                t.column(totalProgress)
                t.column(color)
            }))
        }
        return itemsTable!
    }
    
    //增
    func insert(item: JSON) {
        
        let insert = getItemsTable().insert(rowid <- item["id"].intValue, name <- item["name"].stringValue, resume <- item["resume"].stringValue, totalProgress <- item["totalProgress"].intValue, color <- item["color"].intValue)
        if let rowId = try? getDB().run(insert) {
            print("插入成功：\(rowId)")
        } else {
            print("插入失败")
        }
        
    }
    
    // 临时增
    func insert(tempId: Int, tempName: String, tempResume: String, tempTotalProgress: Int, tempColor: Int) {
        
        let insert = getItemsTable().insert(rowid <- tempId, name <- tempName, resume <- tempResume, totalProgress <- tempTotalProgress, color <- tempColor)
        if let rowId = try? getDB().run(insert) {
            print("插入成功：\(rowId)")
        } else {
            print("插入失败")
        }
        
    }
    
    //删单条
    func delete(id: Int) {
        delete(filter: rowid == id)
    }
    
    //根据条件删除
    func delete(filter: Expression<Bool>? = nil) {
        
        var query = getItemsTable()
        if let f = filter {
            query = query.filter(f)
        }
        if let count = try? getDB().run(query.delete()) {
            print("删除的条数为：\(count)")
        } else {
            print("删除失败")
        }
        
    }
    
    //改
    func update(id: Int, item: JSON) {
        
        let update = getItemsTable().filter(rowid == id)
        if let count = try? getDB().run(update.update(name <- item["name"].stringValue, resume <- item["resume"].stringValue, totalProgress <- item["totalProgress"].intValue, color <- item["color"].intValue)) {
            print("修改的结果为：\(count == 1)")
        } else {
            print("修改失败")
        }
        
    }
    
    //查
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [Expression<Int>("id"), Expression<String>("name"), Expression<String>("resume"), Expression<Int>("totalProgress"), Expression<Int>("color")], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        var query = getItemsTable().select(select).order(order)
        if let f = filter {
            query = query.filter(f)
        }
        if let l = limit {
            if let o = offset{
                query = query.limit(l, offset: o)
            }else {
                query = query.limit(l)
            }
        }
        
        let result = try! getDB().prepare(query)
        return Array(result)
        
    }
}
