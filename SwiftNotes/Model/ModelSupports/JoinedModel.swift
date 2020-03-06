//
//  JoindModelIns.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

//
//  Model.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class JoinedModel: SQLiteManager {
    // 模型只需修改字段名、数据类型，及表名
    let tableName = "progress"
    let id = Expression<Int>("id")
    let currentProgress = Expression<Int>("currentProgress")
    let startTime = Expression<String>("startTime")
    let endTime = Expression<String>("endTime")
    let itemId = Expression<Int>("itemId")
    
    func getTable() -> Table {
        table = super.getTable(tableName: tableName) { (t) in
            t.column(id, primaryKey: true)
            t.column(currentProgress)
            t.column(startTime)
            t.column(endTime)
            t.column(itemId)
        }
        return table!
    }
    
    // 增
    func insert(item: JSON) {
        
        let values = getTable().insert(
            id <- item["id"].intValue,
            currentProgress <- item["currentProgress"].intValue,
            startTime <- item["startTime"].stringValue,
            endTime <- item["endTime"].stringValue,
            itemId <- item["itemId"].intValue
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
            currentProgress <- item["currentProgress"].intValue,
            startTime <- item["startTime"].stringValue,
            endTime <- item["endTime"].stringValue,
            itemId <- item["itemId"].intValue
        )
        super.update(values)
    }
    
    // 查
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [
        Expression<Int>("id"),
        Expression<String>("currentProgress"),
        Expression<String>("startTime"),
        Expression<Int>("endTime"),
        Expression<Int>("itemId")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    

    
}

