//
//  ReloadDataModel.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/11/24.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import SQLite
import SwiftyJSON

class ReloadDataModel: SQLiteManager {
    // 模型只需修改字段名及数据类型，及表名
    let id = Expression<Int>("id")
    let name = Expression<String>("name")

    func getTable() -> Table {
        table = super.getTable(tableName: "reloadData") { (t) in
            t.column(id, primaryKey: true)
            t.column(name)
        }
        return table!
    }
    
    // 增
    func insert(item: JSON) {
        
        let values = getTable().insert(
            id <- item["id"].intValue,
            name <- item["name"].stringValue
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
            name <- item["name"].stringValue
        )
        super.update(values)
    }
    
    // 查
    func search(filter: Expression<Bool>? = nil, select: [Expressible] = [
        Expression<Int>("id"),
        Expression<String>("name")
        ], order: [Expressible] = [Expression<Int>("id").asc], limit: Int? = nil, offset: Int? = nil) -> [Row] {
        
        let query = getTable().select(select).order(order)
        return super.search(query, filter: filter, select: select, order: order, limit: limit, offset: offset)
    }
    
}


extension ReloadDataModel {
    
    func printId() {
        var idList: [Int] = []
        let result = self.search()
        for item in result {
            idList.append(item[self.id])
        }
        print("id列表：\(idList)")
    }
    
}

