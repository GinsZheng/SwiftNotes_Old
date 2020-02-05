//
//  Model.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class BasicModel: SQLiteManager {
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
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    
    
    // ??联表查
    func searchJoinTable(_ table: SQLite.QueryType, on condition: SQLite.Expression<Bool>) {

        let query = getTable().join(table, on: condition)
        let result = try! getDB().prepare(query)
        print("联表查询：\(Array(result))")
        // 联表查询后得到什么类型的结果？
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


extension BasicModel {
    
    func searchInSQL() -> Statement? {
        let result = try! getDB().prepare("SELECT * FROM items")
        var ids = [Binding]()
        for row in result {
            ids.append(row[0] ?? 0)
            // 在转化上遇到问题，不知怎么把[Binding]类型转化为[Int]类型
        }
        print(ids)
        return result
    }
    
    func printId() {
        var idList: [Int] = []
        let result = self.search()
        for item in result {
            idList.append(item[self.id])
        }
        print("id列表：\(idList)")
    }
    
}

