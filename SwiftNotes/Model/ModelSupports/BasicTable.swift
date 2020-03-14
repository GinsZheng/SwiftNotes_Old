//
//  Model.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class CSBasicTable: SQLiteManager {
    // 模型只需修改字段名、数据类型，及表名
    let tableName = "items"
    let id = Expression<Int>("id")
    let name = Expression<String>("name")
    let resume = Expression<String>("resume")
    let totalProgress = Expression<Int>("totalProgress")
    let color = Expression<Int>("color")
    
    func getTable() -> Table {
        let table = super.getTable(tableName: tableName) { (t) in
            t.column(id, primaryKey: true)
            t.column(name)
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
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    
    
    // SQL语句查询
    func searchInSQL() {
        let stmt = try! getDB().prepare("SELECT id, name, totalProgress FROM items")
        for row in stmt {
            for (index, columnName) in stmt.columnNames.enumerated() {
                print ("\(columnName):\(row[index]!)")
            }
        }
    }
    
}


extension CSBasicTable {
    
    func printId() {
        var idList: [Int] = []
        let result = self.search()
        for item in result {
            idList.append(item[self.id])
        }
        print("id列表：\(idList)")
    }
    
    // scalar 可获取一个值
    func getCount() -> Binding {
        // self.getTable() // 以下函数如果有报错，则尝试加上这条
        let result = try! getDB().scalar("SELECT count(*) FROM \(tableName)")
        return result ?? 0
    }
    
    func getNextId() -> Int64 {
        let result = try! getDB().scalar("SELECT MAX(id) FROM \(tableName)")
        if result == nil {
            return 0
        }
        return result as! Int64 + 1
    }
    
    func getJoindTableValue() -> Binding {
        let result = try! getDB().scalar("SELECT name FROM items, progress WHERE items.id = progress.itemId")
        return result ?? ""
    }
    
    // prepare 可获取数组
    func getJSONOneRow(id: Int) -> JSON {
        let result = try! getDB().prepare("SELECT * FROM items WHERE id = \(id)")
        var rowDict: [String: Any] = [:]
        
        for row in result {
            let jsonRow = JSON(row)
            let id = jsonRow[0]
            let name = jsonRow[1]
            let resume = jsonRow[2]
            let totalProgress = jsonRow[3]
            let color = jsonRow[4]
            
            rowDict = [
                "id": id,
                "name": name,
                "resume": resume,
                "totalProgress": totalProgress,
                "color": color
            ]
        }
        let jsonDict = JSON(rowDict)
        return jsonDict
    }
    
    func getJSON() -> JSON {
        let result = try! getDB().prepare("SELECT * FROM items")
        var jsonArray: [Any] = []
        let jsonResult: JSON
        
        for row in result {
            let jsonRow = JSON(row)
            let id = jsonRow[0]
            let name = jsonRow[1]
            let resume = jsonRow[2]
            let totalProgress = jsonRow[3]
            let color = jsonRow[4]
            
            let rowDict: [String: Any] = [
                "id": id,
                "name": name,
                "resume": resume,
                "totalProgress": totalProgress,
                "color": color
            ]
            let jsonDict = JSON(rowDict)
            jsonArray.append(jsonDict)
        }
        jsonResult = JSON(jsonArray)
        return jsonResult
    }
}
