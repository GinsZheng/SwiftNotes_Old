//
//  ProgressTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/24.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import SQLite

extension Models {
    struct Progress {
        var id: Int = 0
        var currentProgress: Int
        var startTime: Int
        var endTime: Int
        var itemId: Int
    }
}


class ProgressDataManager {
    private let progressTable = ProgressTable()
    
    func insertProgress(model: Models.Progress) {
        DB.shared.insert(table: progressTable, model: model)
    }
    
    func deleteProgress(id: Int) {
        DB.shared.delete(table: progressTable, id: id)
    }
    
    func updateProgress(id: Int, model: Models.Progress) {
        DB.shared.update(table: progressTable, id: id, model: model)
    }
    
    // 获取所有数据
    func fetchAllProgresses() -> [Models.Progress] {
        return progressTable.fetchAllData()
    }
    
}


// MARK: - 表类
class ProgressTable: TableProtocol {
    typealias ModelType = Models.Progress
    var tableName: String { return DBTable.progress }
    
    private let id = Expression<Int>("id")
    private let currentProgress = Expression<Int>("currentProgress")
    private let startTime = Expression<Int>("startTime")
    private let endTime = Expression<Int>("endTime")
    private let itemId = Expression<Int>("itemId")

    // MARK: - 初始化与通用协议方法
    required init() {
        DB.shared.createTable(self)
    }
    
    // 定义字段
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(currentProgress)
        t.column(startTime)
        t.column(endTime)
        t.column(itemId)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.Progress) -> [Setter] {
        var setters: [Setter] = [
            currentProgress <- model.currentProgress,
            startTime <- model.startTime,
            endTime <- model.endTime,
            itemId <- model.itemId
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func fetchAllData() -> [Models.Progress] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.fetchArray(withSQL: sql) { row -> Models.Progress? in
            guard let id: Int = extractOptValue(from: row, key: "id") else { return nil }
            let currentProgress: Int = extractValue(from: row, key: "currentProgress")
            let startTime: Int = extractValue(from: row, key: "startTime")
            let endTime: Int = extractValue(from: row, key: "endTime")
            let itemId: Int = extractValue(from: row, key: "itemId")

            return Models.Progress(id: id, currentProgress: currentProgress, startTime: startTime, endTime: endTime, itemId: itemId)
        }
    }
    
}


// MARK: - 查询方法
extension ProgressTable {
    func fetchDuration(id: Int) -> Int {
        let sql = "SELECT SUM(endTime) - SUM(startTime) FROM \(tableName) WHERE id = \(id)"
        guard let duration: Int = DB.shared.fetchScalar(sql) else { return 0 }
        return duration
    }
    
}

