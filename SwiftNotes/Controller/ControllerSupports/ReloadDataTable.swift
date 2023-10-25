//
//  ReloadDataTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class ReloadDataTable: SQLiteManager {
    // 模型只需修改字段名及数据类型，及表名
    let tableName = "reloadData"
    let id = Expression<Int>("id")
    let itemName = Expression<String>("itemName")

    @discardableResult
    func getTable() -> Table {
        let table = super.getTable(tableName: tableName) { (t) in
            t.column(id, primaryKey: true)
            t.column(itemName)
        }
        return table
    }
    
    // 增
    func insert(item: JSON) {
        
        let values = getTable().insert(
            id <- item["id"].intValue,
            itemName <- item["itemName"].stringValue
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
            itemName <- item["itemName"].stringValue
        )
        super.update(values)
    }
    
    // 查
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [
        Expression<Int>("id"),
        Expression<String>("itemName")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    
}


extension ReloadDataTable {
    
    func printId() {
        var idList: [Int] = []
        let result = self.search()
        for item in result {
            idList.append(item[self.id])
        }
        print("id列表：\(idList)")
    }
    
    func getCount() -> Binding {
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
    
    func getJSON() -> JSON {
        let result = try! getDB().prepare("SELECT * FROM \(tableName)")
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
    
}



struct ReloadDateModel {
    var id: [Int]
    var itemName: [String]
    
    init(jsonData: JSON) {
        id = jsonData.arrayValue.map {$0["id"].intValue}
        itemName = jsonData.arrayValue.map {$0["itemName"].stringValue}
    }
}
