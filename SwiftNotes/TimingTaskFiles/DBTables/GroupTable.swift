//
//  GroupTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/30.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import SQLite

extension Models {
    struct Group {
        var id: Int = 0
        var groupName: String
        var groupType: Int
        var groupSorting: Int
        var hideInSmartGroup: Bool?
        var hideGroup: Bool?
        var smartGroupPreset: Int?
    }
}


// MARK: - 表类
class GroupTable: TableProtocol {
    typealias ModelType = Models.Group
    var tableName: String { return DBTable.group }
    
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
    func modelToSetters(model: Models.Group) -> [Setter] {
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
    func fetchAllData() -> [Models.Group] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.fetchArray(withSQL: sql) { row -> Models.Group? in
            guard let id = row["id"] as? Int,
                  let groupName = row["groupName"] as? String,
                  let groupType = row["groupType"] as? Int,
                  let groupSorting = row["groupSorting"] as? Int,
                  let hideInSmartGroup = row["hideInSmartGroup"] as? Bool?,
                  let hideGroup = row["hideGroup"] as? Bool?,
                  let smartGroupPreset = row["smartGroupPreset"] as? Int?
            else { return nil }
            
            return Models.Group(id: id, groupName: groupName, groupType: groupType, groupSorting: groupSorting, hideInSmartGroup: hideInSmartGroup, hideGroup: hideGroup, smartGroupPreset: smartGroupPreset)
        }
    }
    
}


// MARK: - 查询方法
extension GroupTable {
    
}

