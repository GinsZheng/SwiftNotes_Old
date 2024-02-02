//
//  ItemTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/22.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import SQLite

extension Models {
    struct Item {
        var id: Int = 0
        var itemName: String
        var resume: String
        var totalProgress: Int
        var color: Int
    }
}


class ItemDataManager {
    private let itemTable = ItemTable()
    
    func insertItem(model: Models.Item) {
        DB.shared.insert(table: itemTable, model: model)
    }
    
    func deleteItem(id: Int) {
        DB.shared.delete(table: itemTable, id: id)
    }
    
    func updateItem(id: Int, model: Models.Item) {
        DB.shared.update(table: itemTable, id: id, model: model)
    }
    
    // 获取所有数据
    func fetchAllItems() -> [Models.Item] {
        return itemTable.fetchAllData()
    }
    
}


// MARK: - 表类
class ItemTable: TableProtocol {
    typealias ModelType = Models.Item
    var tableName: String { return DBTable.item }
    
    private let id = Expression<Int>("id")
    private let itemName = Expression<String>("itemName")
    private let resume = Expression<String>("resume")
    private let totalProgress = Expression<Int>("totalProgress")
    private let color = Expression<Int>("color")

    // MARK: - 初始化与通用协议方法
    required init() {
        DB.shared.createTable(self)
    }
    
    // 定义字段
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(itemName)
        t.column(resume)
        t.column(totalProgress)
        t.column(color)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.Item) -> [Setter] {
        var setters: [Setter] = [
            itemName <- model.itemName,
            resume <- model.resume,
            totalProgress <- model.totalProgress,
            color <- model.color
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func fetchAllData() -> [Models.Item] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.fetchArray(withSQL: sql) { row -> Models.Item? in
            guard let id: Int = extractOptValue(from: row, key: "id") else { return nil }
            let itemName: String = extractValue(from: row, key: "itemName")
            let resume: String = extractValue(from: row, key: "resume")
            let totalProgress: Int = extractValue(from: row, key: "totalProgress")
            let color: Int = extractValue(from: row, key: "color")

            return Models.Item(id: id, itemName: itemName, resume: resume, totalProgress: totalProgress, color: color)
        }
    }
    
}


// MARK: - 查询方法
extension ItemTable {
    func fetchSingleItem(id: Int) -> Models.Item {
        let sql = "SELECT * FROM \(tableName) WHERE id = \(id)"
        return DB.shared.fetchSingle(withSQL: sql) { row -> Models.Item in
            if row["id"] == nil { print("错误：未找到指定的 ID")}
            let id = row["id"] as? Int ?? 0
            let itemName = row["itemName"] as? String ?? ""
            let resume = row["resume"] as? String ?? ""
            let totalProgress = row["totalProgress"] as? Int ?? 0
            let color = row["color"] as? Int ?? 0
            
            return Models.Item(id: id, itemName: itemName, resume: resume, totalProgress: totalProgress, color: color)
        }
    }
    
    func fetchFirstItemName() -> String {
        let sql = "SELECT itemName FROM item, progress ORDER BY progress.startTime DESC LIMIT 1"
        guard let firstName: String = DB.shared.fetchScalar(sql) else { return "" }
        return firstName
    }
    
}

