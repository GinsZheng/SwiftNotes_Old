//
//  ModelInstance.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class ModelInstance: SQLiteManager {
    // 模型只需修改字段名及数据类型
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
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [
        Expression<Int>("id"),
        Expression<String>("name"),
        Expression<String>("resume"),
        Expression<Int>("totalProgress"),
        Expression<Int>("color")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        var query = getTable().select(select).order(order)
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




