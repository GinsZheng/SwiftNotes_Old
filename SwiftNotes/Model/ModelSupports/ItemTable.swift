//
//  Model.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class CSItemTable: SQLiteManager {
    // 模型只需修改字段名、数据类型，及表名
    let tableName = "item"
    let id = Expression<Int>("id")
    let itemName = Expression<String>("itemName")
    let resume = Expression<String>("resume")
    let totalProgress = Expression<Int>("totalProgress")
    let color = Expression<Int>("color")
    
    @discardableResult
    func getTable() -> Table {
        let table = super.getTable(tableName: tableName) { (t) in
            t.column(id, primaryKey: true)
            t.column(itemName)
            t.column(resume)
            t.column(totalProgress)
            t.column(color)
        }
        return table
    }
    
    
    // 增
    func insert(item: JSON) {
        
        let values = getTable().insert(
            id <- item["id"].intValue,
            itemName <- item["itemName"].stringValue,
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
        // Expression<Bool> 比如：Expression<String>("itemName")
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
            itemName <- item["itemName"].stringValue,
            resume <- item["resume"].stringValue,
            totalProgress <- item["totalProgress"].intValue,
            color <- item["color"].intValue
        )
        super.update(values)
    }
    
    
    // 查
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [
        Expression<Int>("id"),
        Expression<String>("itemName"),
        Expression<String>("resume"),
        Expression<Int>("totalProgress"),
        Expression<Int>("color")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    
    
    // SQL语句查询
    func searchInSQL() {
        let stmt = try! getDB().prepare("SELECT id, itemName, totalProgress FROM item")
        for row in stmt {
            for (index, columnName) in stmt.columnNames.enumerated() {
                print ("\(columnName):\(row[index]!)")
            }
        }
    }
    
}


extension CSItemTable {
    
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
    
    // 获取一个值(scalar)
    func getCount() -> Binding {
        let result = try! getDB().scalar("SELECT count(*) FROM \(tableName)")
        return result ?? 0
    }
    
    // 获取数组+字典
    func getJSON() -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName)")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            let rowDict: [String: Any] = [
                "id": jsonRow[0],
                "itemName": jsonRow[1],
                "resume": jsonRow[2],
                "totalProgress": jsonRow[3],
                "color": jsonRow[4]
            ]
            let jsonDict = JSON(rowDict)
            jsonArray.append(jsonDict)
        }
        return JSON(jsonArray)
    }
    
    // 获取字典
    func getJSONOneRow(id: Int) -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName) WHERE id = \(id)")
        var rowDict: [String: Any] = [:]
        
        for row in result {
            let jsonRow = JSON(row)
            rowDict = [
                "id": jsonRow[0],
                "itemName": jsonRow[1],
                "resume": jsonRow[2],
                "totalProgress": jsonRow[3],
                "color": jsonRow[4]
            ]
        }
        return JSON(rowDict)
    }
    
    // 获取数组
    func getArray() -> JSON {
        let result = try! getDB().prepare("SELECT itemName FROM \(tableName)")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            jsonArray.append(jsonRow[0])
        }
        return JSON(jsonArray)
    }

    func getNextId() -> Int64 {
        let result = try! getDB().scalar("SELECT MAX(id) FROM \(tableName)")
        if result == nil {
            return 0
        }
        return result as! Int64 + 1
    }
    
    func getFirstName() -> Binding {
        let result = try! getDB().scalar("SELECT itemName FROM item, progress ORDER BY progress.startTime DESC LIMIT 1")
        return result ?? ""
    }
    
    
    func getJoinedTablesJSON() -> JSON {
        // 联结表时，如果两个表的字段一致(如id，需要指明表名，如：item.id)
        let result = try! getDB().prepare("SELECT item.id, itemName FROM item, progress WHERE item.id = progress.id ORDER BY progress.startTime DESC")
        var jsonArray: [Any] = []
        
        for row in result {
            let jsonRow = JSON(row)
            let rowDict: [String: Any] = [
                "id": jsonRow[0],
                "itemName": jsonRow[1],
            ]
            let jsonDict = JSON(rowDict)
            jsonArray.append(jsonDict)
        }
        return JSON(jsonArray)
    }
    
    func getJoinedTablesJSONOneLine() -> JSON {
        
        let result = try! getDB().prepare("SELECT item.id, itemName FROM item, progress WHERE item.id = progress.id ORDER BY progress.startTime DESC LIMIT 1")
        
        var rowDict: [String: Any] = [:]
        
        for row in result {
            let jsonRow = JSON(row)
            rowDict = [
                "id": jsonRow[0],
                "itemName": jsonRow[1],
            ]
        }
        return JSON(rowDict)
    }
    

}



// 建模
struct CSItemModel {
    var id: [Int]
    var itemName: [String]
    var resume: [String]
    var totalProgress: [Int]
    var color: [Int]
    
    init(jsonData: JSON) {
        id = jsonData.arrayValue.map {$0["id"].intValue}
        itemName = jsonData.arrayValue.map {$0["itemName"].stringValue}
        resume = jsonData.arrayValue.map {$0["resume"].stringValue}
        totalProgress = jsonData.arrayValue.map {$0["totalProgress"].intValue}
        color = jsonData.arrayValue.map {$0["color"].intValue}
    }
}

/*
 新增字段后，可能出问题，尝试删除APP看看，后续再看处理
 */
