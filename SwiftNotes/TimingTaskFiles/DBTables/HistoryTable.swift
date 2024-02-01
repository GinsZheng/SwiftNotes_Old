//
//  HistoryTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/30.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import SQLite

extension Models {
    struct History {
        var id: Int = 0
        var reminderTimestamp: Int
        var isTimeSet: Bool
        var taskId: Int
    }
}


// MARK: - 表类
class HistoryTable: TableProtocol {
    typealias ModelType = Models.History
    var tableName: String { return DBTable.history }
    
    private let id = Expression<Int>("id")
    private let reminderTimestamp = Expression<Int>("reminderTimestamp")
    private let isTimeSet = Expression<Bool>("isTimeSet")
    private let taskId = Expression<Int>("taskId")

    // MARK: - 初始化与通用协议方法
    required init() {
        DB.shared.createTable(self)
    }
    
    // 定义字段
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(reminderTimestamp)
        t.column(isTimeSet)
        t.column(taskId)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.History) -> [Setter] {
        var setters: [Setter] = [
            reminderTimestamp <- model.reminderTimestamp,
            isTimeSet <- model.isTimeSet,
            taskId <- model.taskId
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func fetchAllData() -> [Models.History] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.fetchArray(withSQL: sql) { row -> Models.History? in
            guard let id: Int = extractOptValue(from: row, key: "id") else { return nil }
            let reminderTimestamp: Int = extractValue(from: row, key: "reminderTimestamp")
            let isTimeSet: Bool = extractValue(from: row, key: "isTimeSet")
            let taskId: Int = extractValue(from: row, key: "taskId")

            return Models.History(id: id, reminderTimestamp: reminderTimestamp, isTimeSet: isTimeSet, taskId: taskId)
        }
    }
    
}


// MARK: - 查询方法
extension HistoryTable {
    
}


