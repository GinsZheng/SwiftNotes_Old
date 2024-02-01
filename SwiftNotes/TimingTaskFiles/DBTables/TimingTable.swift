//
//  TimingTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/31.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import SQLite

extension Models {
    struct Timing {
        var id: Int = 0
        var progressRecord: Int?
        var progressSummary: String?
        var startTimestamp: Int
        var endTimestamp: Int
        var pauseDuration: Int?
        var taskId: Int
    }
}


// MARK: - 表类
class TimingTable: TableProtocol {
    typealias ModelType = Models.Timing
    var tableName: String { return DBTable.timing }
    
    private let id = Expression<Int>("id")
    private let progressRecord = Expression<Int?>("progressRecord")
    private let progressSummary = Expression<String?>("progressSummary")
    private let startTimestamp = Expression<Int>("startTimestamp")
    private let endTimestamp = Expression<Int>("endTimestamp")
    private let pauseDuration = Expression<Int?>("pauseDuration")
    private let taskId = Expression<Int>("taskId")

    // MARK: - 初始化与通用协议方法
    required init() {
        DB.shared.createTable(self)
    }
    
    // 定义字段
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(progressRecord)
        t.column(progressSummary)
        t.column(startTimestamp)
        t.column(endTimestamp)
        t.column(pauseDuration)
        t.column(taskId)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.Timing) -> [Setter] {
        var setters: [Setter] = [
            progressRecord <- model.progressRecord,
            progressSummary <- model.progressSummary,
            startTimestamp <- model.startTimestamp,
            endTimestamp <- model.endTimestamp,
            pauseDuration <- model.pauseDuration,
            taskId <- model.taskId
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func fetchAllData() -> [Models.Timing] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.fetchArray(withSQL: sql) { row -> Models.Timing? in
            guard let id: Int = extractOptValue(from: row, key: "id") else { return nil }
            let progressRecord: Int? = extractOptValue(from: row, key: "progressRecord")
            let progressSummary: String? = extractOptValue(from: row, key: "progressSummary")
            let startTimestamp: Int = extractValue(from: row, key: "startTimestamp")
            let endTimestamp: Int = extractValue(from: row, key: "endTimestamp")
            let pauseDuration: Int? = extractOptValue(from: row, key: "pauseDuration")
            let taskId: Int = extractValue(from: row, key: "taskId")

            return Models.Timing(id: id, progressRecord: progressRecord, progressSummary: progressSummary, startTimestamp: startTimestamp, endTimestamp: endTimestamp, pauseDuration: pauseDuration, taskId: taskId)
        }
    }
    
}


// MARK: - 查询方法
extension TimingTable {
    
}


