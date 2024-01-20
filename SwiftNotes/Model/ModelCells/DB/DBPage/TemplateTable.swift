//
//  TemplateTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/20.
//  Copyright © 2024 GinsMac. All rights reserved.
//
//
//import SQLite
//
//// MARK: - 模型
//extension Models {
//    struct Project {
//        var id: Int = 0
//        <#T##String#>
//    }
//}
//
//
//// MARK: - 表类
//class ProjectTable: TableProtocol {
//    typealias ModelType = Models.Project
//    var tableName: String { return DBTable.project }
//    
//    private let id = Expression<Int>("id")
//    <#T##String#>
//    
//    // MARK: - 初始化与通用协议方法
//    required init() {
//        DB.shared.createTable(self)
//    }
//    
//    // 定义字段
//    func defineTable(t: TableBuilder) {
//        t.column(id, primaryKey: .autoincrement)
//        <#T##String#>
//    }
//    
//    // 定义Setter
//    func modelToSetters(model: Models.Project) -> [Setter] {
//        var setters: [Setter] = [
//            <#T##String#>
//        ]
//        // 如果 id 非默认值(编辑时)，则添加
//        if model.id != 0 { setters.append(id <- model.id) }
//        return setters
//    }
//    
//}
//
//
//// MARK: - 查询方法
//extension ProjectTable {
//    // 查询所有行
//    func getAll() -> [Models.Project] {
//        return DB.shared.query(table: self).compactMap { row in
//            Models.Project(
//                id: row[id],
//                <#T##String#>
//            )
//        }
//    }
//
//    // 查询
//    func getAllWithSQL() -> [Models.Project] {
//        let sql = "SELECT * FROM \(tableName)"
//        return DB.shared.query(withSQL: sql) { row -> Models.Project? in
//            guard let id = row["id"] as? Int,
//                  <#T##String#>
//            else { return nil }
//            let startDate = row["startDate"] as? Int
//            
//            return Models.Project(
//        }
//    }
//    
//}
