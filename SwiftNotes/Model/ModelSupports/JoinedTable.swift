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

class CSJoinedTable: SQLiteManager {
    // 模型只需修改字段名、数据类型，及表名
    let tableName = "progress"
    let id = Expression<Int>("id")
    let currentProgress = Expression<Int>("currentProgress")
    let startTime = Expression<Int>("startTime")
    let endTime = Expression<Int>("endTime")
    let itemId = Expression<Int>("itemId")
    let createTime = Expression<Int>("createTime")
    
    func getTable() -> Table {
        let table = super.getTable(tableName: tableName) { (t) in
            t.column(id, primaryKey: true)
            t.column(currentProgress)
            t.column(startTime)
            t.column(endTime)
            t.column(itemId)
            t.column(createTime)
        }
        return table
    }
    
    // 增
    func insert(item: JSON) {
        
        let values = getTable().insert(
            id <- item["id"].intValue,
            currentProgress <- item["currentProgress"].intValue,
            startTime <- item["startTime"].intValue,
            endTime <- item["endTime"].intValue,
            itemId <- item["itemId"].intValue,
            createTime <- item["createTime"].intValue
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
            startTime <- item["startTime"].intValue,
            endTime <- item["endTime"].intValue,
            itemId <- item["itemId"].intValue
        )
        super.update(values)
    }
    
    // 查
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [
        Expression<Int>("id"),
        Expression<Int>("currentProgress"),
        Expression<Int>("startTime"),
        Expression<Int>("endTime"),
        Expression<Int>("itemId"),
        Expression<Int>("createTime")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    

    
}

extension CSJoinedTable {
    
    func getJSON() -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName)")
        var jsonArray: [Any] = []
        let jsonResult: JSON
        
        for row in result {
            let jsonRow = JSON(row)
            let id = jsonRow[0]
            let currentProgress = jsonRow[1]
            let startTime = jsonRow[2]
            let endTime = jsonRow[3]
            let itemId = jsonRow[4]
            let createTime = jsonRow[5]
            
            let rowDict: [String: Any] = [
                "id": id,
                "currentProgress": currentProgress,
                "startTime": startTime,
                "endTime": endTime,
                "itemId": itemId,
                "createTime": createTime
            ]
            let jsonDict = JSON(rowDict)
            jsonArray.append(jsonDict)
        }
        jsonResult = JSON(jsonArray)
        return jsonResult
    }
    
    func getJSONOneRow(id: Int) -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName) WHERE id = \(id)")
        var rowDict: [String: Any] = [:]
        
        for row in result {
            let jsonRow = JSON(row)
            let id = jsonRow[0]
            let currentProgress = jsonRow[1]
            let startTime = jsonRow[2]
            let endTime = jsonRow[3]
            let itemId = jsonRow[4]
            let createTime = jsonRow[5]
            
            rowDict = [
                "id": id,
                "currentProgress": currentProgress,
                "startTime": startTime,
                "endTime": endTime,
                "itemId": itemId,
                "createTime": createTime
            ]
        }
        let jsonDict = JSON(rowDict)
        return jsonDict
    }
    
    func getNextId() -> Int64 {
        let result = try! getDB().scalar("SELECT MAX(id) FROM \(tableName)")
        if result == nil {
            return 0
        }
        return result as! Int64 + 1
    }
    
    func getCount() -> Binding {
        let result = try! getDB().scalar("SELECT count(*) FROM \(tableName)")
        return result ?? 0
    }
}



struct CSJoinedModel {
    var id: [Int]
    var currentProgress: [Int]
    var startTime: [Int]
    var endTime: [Int]
    var itemId: [Int]
    var createTime: [Int]

    init(jsonData: JSON) {
        id = jsonData.arrayValue.map {$0["id"].intValue}
        currentProgress = jsonData.arrayValue.map {$0["currentProgress"].intValue}
        startTime = jsonData.arrayValue.map {$0["startTime"].intValue}
        endTime = jsonData.arrayValue.map {$0["endTime"].intValue}
        itemId = jsonData.arrayValue.map {$0["itemId"].intValue}
        createTime = jsonData.arrayValue.map {$0["createTime"].intValue}
    }
}
