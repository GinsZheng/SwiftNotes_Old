//
//  TaskGroupTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/30.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import SQLite

extension Models {
    struct TaskGroup {
        var id: Int = 0
        var groupName: String
        var groupType: Int
        var groupSorting: Int
        var hideInSmartGroup: Bool?
        var hideGroup: Bool?
        var smartGroupPreset: Int?
    }
}


class TaskGroupDataManager {
    private let taskGroupTable = TaskGroupTable()
    
    func insertTaskGroup(model: Models.TaskGroup) {
        DB.shared.insert(table: taskGroupTable, model: model)
    }
    
    func deleteTaskGroup(id: Int) {
        DB.shared.delete(table: taskGroupTable, id: id)
    }
    
    func updateTaskGroup(id: Int, model: Models.TaskGroup) {
        DB.shared.update(table: taskGroupTable, id: id, model: model)
    }
    
    // 获取所有数据
    func fetchAllTaskGroups() -> [Models.TaskGroup] {
        return taskGroupTable.fetchAllData()
    }
    
}


// MARK: - 表类
class TaskGroupTable: TableProtocol {
    typealias ModelType = Models.TaskGroup
    var tableName: String { return DBTable.taskGroup }
    
    private let id = Expression<Int>("id")
    private let groupName = Expression<String>("groupName")
    private let groupType = Expression<Int>("groupType")
    private let groupSorting = Expression<Int>("groupSorting")
    private let hideInSmartGroup = Expression<Bool?>("hideInSmartGroup")
    private let hideGroup = Expression<Bool?>("hideGroup")
    private let smartGroupPreset = Expression<Int?>("smartGroupPreset")

    // MARK: - 初始化与通用协议方法
    required init() {
        DB.shared.createTable(self)
    }
    
    // 定义字段
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(groupName)
        t.column(groupType)
        t.column(groupSorting)
        t.column(hideInSmartGroup)
        t.column(hideGroup)
        t.column(smartGroupPreset)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.TaskGroup) -> [Setter] {
        var setters: [Setter] = [
            groupName <- model.groupName,
            groupType <- model.groupType,
            groupSorting <- model.groupSorting,
            hideInSmartGroup <- model.hideInSmartGroup,
            hideGroup <- model.hideGroup,
            smartGroupPreset <- model.smartGroupPreset
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func fetchAllData() -> [Models.TaskGroup] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.fetchArray(withSQL: sql) { row -> Models.TaskGroup? in
            guard let id: Int = extractOptValue(from: row, key: "id") else { return nil }
            let groupName: String = extractValue(from: row, key: "groupName")
            let groupType: Int = extractValue(from: row, key: "groupType")
            let groupSorting: Int = extractValue(from: row, key: "groupSorting")
            let hideInSmartGroup: Bool? = extractOptValue(from: row, key: "hideInSmartGroup")
            let hideGroup: Bool? = extractOptValue(from: row, key: "hideGroup")
            let smartGroupPreset: Int? = extractOptValue(from: row, key: "smartGroupPreset")

            return Models.TaskGroup(id: id, groupName: groupName, groupType: groupType, groupSorting: groupSorting, hideInSmartGroup: hideInSmartGroup, hideGroup: hideGroup, smartGroupPreset: smartGroupPreset)
        }
    }
    
}


// MARK: - 查询方法
extension TaskGroupTable {
    
}
