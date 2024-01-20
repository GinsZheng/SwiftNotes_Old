//
//  ProjectsTablePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/20.
//  Copyright © 2024 GinsMac. All rights reserved.
//

/// DBPage 中的示例表
import SQLite

// MARK: - 模型
extension Models {
    struct Project {
        var id: Int = 0
        var itemName: String
        var resume: String
        var totalProgress: Int
        var color: Int
        var startDate: Int?
    }
}


// MARK: - 表类
class ProjectsTable: TableProtocol {
    typealias ModelType = Models.Project
    var tableName: String { return DBTable.project }
    
    private let id = Expression<Int>("id")
    private let itemName = Expression<String>("itemName")
    private let resume = Expression<String>("resume")
    private let totalProgress = Expression<Int>("totalProgress")
    private let color = Expression<Int>("color")
    private let startDate = Expression<Int?>("startDate")
    
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
        t.column(startDate)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.Project) -> [Setter] {
        var setters: [Setter] = [
            itemName <- model.itemName,
            resume <- model.resume,
            totalProgress <- model.totalProgress,
            color <- model.color,
            startDate <- model.startDate
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
}


// MARK: - 查询方法
extension ProjectsTable {
    // 查询所有行
    func getAll() -> [Models.Project] {
        return DB.shared.query(table: self).compactMap { row in
            Models.Project(
                id: row[id],
                itemName: row[itemName],
                resume: row[resume],
                totalProgress: row[totalProgress],
                color: row[color],
                startDate: row[startDate]
            )
        }
    }

    // 查询
    func getAllWithSQL() -> [Models.Project] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.query(withSQL: sql) { row -> Models.Project? in
            guard let id = row["id"] as? Int,
                  let itemName = row["itemName"] as? String,
                  let resume = row["resume"] as? String,
                  let totalProgress = row["totalProgress"] as? Int,
                  let color = row["color"] as? Int
            else { return nil }
            let startDate = row["startDate"] as? Int
            
            return Models.Project(id: id, itemName: itemName, resume: resume, totalProgress: totalProgress, color: color, startDate: startDate)
        }
    }
    
}


/*
 getAllWithSQL中使用guard的说明：
 // 必填字段放入guard中来避免使用强制解包，以让失败时不会崩溃
 guard let id = row["id"] as? Int,
       let itemName = row["itemName"] as? String,
       let resume = row["resume"] as? String,
       let totalProgress = row["totalProgress"] as? Int,
       let color = row["color"] as? Int else {
     return nil
 }
 let startDate = row["startDate"] as? Int // 可选字段
 */
