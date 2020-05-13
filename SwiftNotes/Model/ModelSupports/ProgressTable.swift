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

class CSProgressTable: SQLiteManager {
    // 模型只需修改字段名、数据类型，及表名
    let tableName = "progress"
    let id = Expression<Int>("id")
    let currentProgress = Expression<Int>("currentProgress")
    let startTime = Expression<Int>("startTime")
    let endTime = Expression<Int>("endTime")
    let itemId = Expression<Int>("itemId")
    
    @discardableResult
    func getTable() -> Table {
        let table = super.getTable(tableName: tableName) { (t) in
            t.column(id, primaryKey: true)
            t.column(currentProgress)
            t.column(startTime)
            t.column(endTime)
            t.column(itemId)
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
        Expression<Int>("itemId")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    

}



extension CSProgressTable {
    
    func getId() -> [Int] {
        let result = try! getDB().prepare("SELECT id FROM \(tableName)")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            let rowDict: [String: Any] = [
                "id": jsonRow[0],
            ]
            let jsonData = JSON(rowDict)
            jsonArray.append(jsonData)
        }
        let arr = JSON(jsonArray).arrayValue.map {$0["id"].intValue}
        print(arr)
        return arr
    }
    
    func getJSON() -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName)")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            let rowDict: [String: Any] = [
                "id": jsonRow[0],
                "currentProgress": jsonRow[1],
                "startTime": jsonRow[2],
                "endTime": jsonRow[3],
                "itemId": jsonRow[4],
            ]
            let jsonDict = JSON(rowDict)
            jsonArray.append(jsonDict)
        }
        return JSON(jsonArray)
    }
    
    func getJSONOneRow(id: Int) -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName) WHERE id = \(id)")
        var rowDict: [String: Any] = [:]
        
        for row in result {
            let jsonRow = JSON(row)

            rowDict = [
                "id": jsonRow[0],
                "currentProgress": jsonRow[1],
                "startTime": jsonRow[2],
                "endTime": jsonRow[3],
                "itemId": jsonRow[4],
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
    
    // 获得计算数值
    func getDuration(itemId: Int) -> Int64 {
        let result =  try! getDB().scalar("SELECT SUM(endTime) - SUM(startTime) FROM \(tableName) WHERE itemId = \(itemId)")
        if result == nil {
            return 0
        }
        return result as! Int64
    }
    
    // 获取计算JSON
    func getCalJson() -> JSON {
        // 获取每个分组的第一行
        let result = try! getDB().prepare("SELECT * FROM ( SELECT progress.*, ROW_NUMBER () over (PARTITION BY itemId ORDER BY startTime DESC) AS rownum FROM progress) T WHERE T.rownum=1")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            let rowDict: [String: Any] = [
                "id": jsonRow[0],
                "currentProgress": jsonRow[1],
                "startTime": jsonRow[2],
                "endTime": jsonRow[3],
                "itemId": jsonRow[4],
            ]
            let jsonDict = JSON(rowDict)
            jsonArray.append(jsonDict)
        }
        return JSON(jsonArray)
    }
    
    // 获取数组
    func getArray() -> [Int] {
        // 获取每个分组的第一行，返回Array
        let result = try! getDB().prepare("SELECT currentProgress FROM ( SELECT progress.*, ROW_NUMBER () over (PARTITION BY itemId ORDER BY startTime DESC) AS rownum FROM progress) T WHERE T.rownum=1")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            let rowDict: [String: Any] = [
                "currentProgress": jsonRow[0],
            ]
            let jsonData = JSON(rowDict)
            jsonArray.append(jsonData)
        }
        let arr = JSON(jsonArray).arrayValue.map {$0["currentProgress"].intValue}
        
        return arr
    }

}



struct CSProgressModel {
    var id: [Int]
    var currentProgress: [Int]
    var startTime: [Int]
    var endTime: [Int]
    var itemId: [Int]

    init(jsonData: JSON) {
        id = jsonData.arrayValue.map {$0["id"].intValue}
        currentProgress = jsonData.arrayValue.map {$0["currentProgress"].intValue}
        startTime = jsonData.arrayValue.map {$0["startTime"].intValue}
        endTime = jsonData.arrayValue.map {$0["endTime"].intValue}
        itemId = jsonData.arrayValue.map {$0["itemId"].intValue}
    }
}

