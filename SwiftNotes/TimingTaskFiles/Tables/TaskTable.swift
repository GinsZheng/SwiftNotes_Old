//
//  TaskTable.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/31.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import SQLite

extension Models {
    struct Task {
        var id: Int = 0
        var taskType: Int
        var taskTitle: String
        var taskContent: String?
        var isDone: Bool
        var isReminded: Bool
        var isTimeSet: Bool?
        var nextReminderTimestamp: Int?
        var reminderOccasions: [Int]
        var isRepeating: Bool?
        var repeatCycle: Int?
        var repeatInterval: Int?
        var repeatDays: [Int]
        var repeatType: Int?
        var repeatDates: [Int]
        var whichWeek: Int?
        var dayOfWeek: Int?
        var months: [Int]
        var endRepeatTimestamp: Int?
        var hasProgress: Bool
        var progressType: Int?
        var totalProgress: Int?
        var color: Int
        var priority: Int
        var subtaskIds: [Int]
        var creationTimestamp: Int
        var updateTimestamp: Int
        var groupId: Int
        var isProgressSummaryHidden: Bool
        var manualSorting: Int
        var isInTrash: Bool
    }
}


class TaskDataManager {
    private let taskTable = TaskTable()
    
    func insertTask(model: Models.Task) {
        DB.shared.insert(table: taskTable, model: model)
    }
    
    func deleteTask(id: Int) {
        DB.shared.delete(table: taskTable, id: id)
    }
    
    func updateTask(id: Int, model: Models.Task) {
        DB.shared.update(table: taskTable, id: id, model: model)
    }
    
    // 获取所有数据
    func fetchAllTasks() -> [Models.Task] {
        return taskTable.fetchAllData()
    }
    
}


// MARK: - 表类
class TaskTable: TableProtocol {
    typealias ModelType = Models.Task
    var tableName: String { return DBTable.task }
    
    private let id = Expression<Int>("id")
    private let taskType = Expression<Int>("taskType")
    private let taskTitle = Expression<String>("taskTitle")
    private let taskContent = Expression<String?>("taskContent")
    private let isDone = Expression<Bool>("isDone")
    private let isReminded = Expression<Bool>("isReminded")
    private let isTimeSet = Expression<Bool?>("isTimeSet")
    private let nextReminderTimestamp = Expression<Int?>("nextReminderTimestamp")
    private let reminderOccasions = Expression<String>("reminderOccasions")
    private let isRepeating = Expression<Bool?>("isRepeating")
    private let repeatCycle = Expression<Int?>("repeatCycle")
    private let repeatInterval = Expression<Int?>("repeatInterval")
    private let repeatDays = Expression<String>("repeatDays")
    private let repeatType = Expression<Int?>("repeatType")
    private let repeatDates = Expression<String>("repeatDates")
    private let whichWeek = Expression<Int?>("whichWeek")
    private let dayOfWeek = Expression<Int?>("dayOfWeek")
    private let months = Expression<String>("months")
    private let endRepeatTimestamp = Expression<Int?>("endRepeatTimestamp")
    private let hasProgress = Expression<Bool>("hasProgress")
    private let progressType = Expression<Int?>("progressType")
    private let totalProgress = Expression<Int?>("totalProgress")
    private let color = Expression<Int>("color")
    private let priority = Expression<Int>("priority")
    private let subtaskIds = Expression<String>("subtaskIds")
    private let creationTimestamp = Expression<Int>("creationTimestamp")
    private let updateTimestamp = Expression<Int>("updateTimestamp")
    private let groupId = Expression<Int>("groupId")
    private let isProgressSummaryHidden = Expression<Bool>("isProgressSummaryHidden")
    private let manualSorting = Expression<Int>("manualSorting")
    private let isInTrash = Expression<Bool>("isInTrash")

    // MARK: - 初始化与通用协议方法
    required init() {
        DB.shared.createTable(self)
    }
    
    // 定义字段
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(taskType)
        t.column(taskTitle)
        t.column(taskContent)
        t.column(isDone)
        t.column(isReminded)
        t.column(isTimeSet)
        t.column(nextReminderTimestamp)
        t.column(reminderOccasions)
        t.column(isRepeating)
        t.column(repeatCycle)
        t.column(repeatInterval)
        t.column(repeatDays)
        t.column(repeatType)
        t.column(repeatDates)
        t.column(whichWeek)
        t.column(dayOfWeek)
        t.column(months)
        t.column(endRepeatTimestamp)
        t.column(hasProgress)
        t.column(progressType)
        t.column(totalProgress)
        t.column(color)
        t.column(priority)
        t.column(subtaskIds)
        t.column(creationTimestamp)
        t.column(updateTimestamp)
        t.column(groupId)
        t.column(isProgressSummaryHidden)
        t.column(manualSorting)
        t.column(isInTrash)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.Task) -> [Setter] {
        var setters: [Setter] = [
            taskType <- model.taskType,
            taskTitle <- model.taskTitle,
            taskContent <- model.taskContent,
            isDone <- model.isDone,
            isReminded <- model.isReminded,
            isTimeSet <- model.isTimeSet,
            nextReminderTimestamp <- model.nextReminderTimestamp,
            reminderOccasions <- arrayToString(model.reminderOccasions),
            isRepeating <- model.isRepeating,
            repeatCycle <- model.repeatCycle,
            repeatInterval <- model.repeatInterval,
            repeatDays <- arrayToString(model.repeatDays),
            repeatType <- model.repeatType,
            repeatDates <- arrayToString(model.repeatDates),
            whichWeek <- model.whichWeek,
            dayOfWeek <- model.dayOfWeek,
            months <- arrayToString(model.months),
            endRepeatTimestamp <- model.endRepeatTimestamp,
            hasProgress <- model.hasProgress,
            progressType <- model.progressType,
            totalProgress <- model.totalProgress,
            color <- model.color,
            priority <- model.priority,
            subtaskIds <- arrayToString(model.subtaskIds),
            creationTimestamp <- model.creationTimestamp,
            updateTimestamp <- model.updateTimestamp,
            groupId <- model.groupId,
            isProgressSummaryHidden <- model.isProgressSummaryHidden,
            manualSorting <- model.manualSorting,
            isInTrash <- model.isInTrash
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func fetchAllData() -> [Models.Task] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.fetchArray(withSQL: sql) { row -> Models.Task? in
            guard let id: Int = extractOptValue(from: row, key: "id") else { return nil }
            let taskType: Int = extractValue(from: row, key: "taskType")
            let taskTitle: String = extractValue(from: row, key: "taskTitle")
            let taskContent: String? = extractOptValue(from: row, key: "taskContent")
            let isDone: Bool = extractValue(from: row, key: "isDone")
            let isReminded: Bool = extractValue(from: row, key: "isReminded")
            let isTimeSet: Bool? = extractOptValue(from: row, key: "isTimeSet")
            let nextReminderTimestamp: Int? = extractOptValue(from: row, key: "nextReminderTimestamp")
            let reminderOccasions: [Int] = extractArray(from: row, key: "reminderOccasions")
            let isRepeating: Bool? = extractOptValue(from: row, key: "isRepeating")
            let repeatCycle: Int? = extractOptValue(from: row, key: "repeatCycle")
            let repeatInterval: Int? = extractOptValue(from: row, key: "repeatInterval")
            let repeatDays: [Int] = extractArray(from: row, key: "repeatDays")
            let repeatType: Int? = extractOptValue(from: row, key: "repeatType")
            let repeatDates: [Int] = extractArray(from: row, key: "repeatDates")
            let whichWeek: Int? = extractOptValue(from: row, key: "whichWeek")
            let dayOfWeek: Int? = extractOptValue(from: row, key: "dayOfWeek")
            let months: [Int] = extractArray(from: row, key: "months")
            let endRepeatTimestamp: Int? = extractOptValue(from: row, key: "endRepeatTimestamp")
            let hasProgress: Bool = extractValue(from: row, key: "hasProgress")
            let progressType: Int? = extractOptValue(from: row, key: "progressType")
            let totalProgress: Int? = extractOptValue(from: row, key: "totalProgress")
            let color: Int = extractValue(from: row, key: "color")
            let priority: Int = extractValue(from: row, key: "priority")
            let subtaskIds: [Int] = extractArray(from: row, key: "subtaskIds")
            let creationTimestamp: Int = extractValue(from: row, key: "creationTimestamp")
            let updateTimestamp: Int = extractValue(from: row, key: "updateTimestamp")
            let groupId: Int = extractValue(from: row, key: "groupId")
            let isProgressSummaryHidden: Bool = extractValue(from: row, key: "isProgressSummaryHidden")
            let manualSorting: Int = extractValue(from: row, key: "manualSorting")
            let isInTrash: Bool = extractValue(from: row, key: "isInTrash")

            return Models.Task(id: id, taskType: taskType, taskTitle: taskTitle, taskContent: taskContent, isDone: isDone, isReminded: isReminded, isTimeSet: isTimeSet, nextReminderTimestamp: nextReminderTimestamp, reminderOccasions: reminderOccasions, isRepeating: isRepeating, repeatCycle: repeatCycle, repeatInterval: repeatInterval, repeatDays: repeatDays, repeatType: repeatType, repeatDates: repeatDates, whichWeek: whichWeek, dayOfWeek: dayOfWeek, months: months, endRepeatTimestamp: endRepeatTimestamp, hasProgress: hasProgress, progressType: progressType, totalProgress: totalProgress, color: color, priority: priority, subtaskIds: subtaskIds, creationTimestamp: creationTimestamp, updateTimestamp: updateTimestamp, groupId: groupId, isProgressSummaryHidden: isProgressSummaryHidden, manualSorting: manualSorting, isInTrash: isInTrash)
        }
    }
    
}


// MARK: - 查询方法
extension TaskTable {
    // 返回首页Section数据
    func fetchHomeSectionsData() -> [Models.HomeSection] {
        // 获取所有任务数据
        let allTasks = fetchHomeCellsData()
        // 获取每个section任务数量
        let taskCounts = fetchTaskCountsByIsDone()

        // 分类任务：isDone 为 0 和 1
        let tasksIsDone0 = allTasks.filter { !$0.isDone }
        let tasksIsDone1 = allTasks.filter { $0.isDone }
        
        // 创建两个 section
        let sectionForIsDone0 = Models.HomeSection(cells: tasksIsDone0)
        let sectionForIsDone1 = Models.HomeSection(header: .titleDescFoldBg(title: "已完成", titleType: .small, description: "\(taskCounts[true, default: 0])", isFolded: false), cells: tasksIsDone1)
        
        // 返回包含这两个 section 的数组
        return [sectionForIsDone0, sectionForIsDone1]
    }
    
}


// MARK: - 私有方法
extension TaskTable {
    // 返回首页cell数据
    private func fetchHomeCellsData() -> [Models.HomeCell] {
        let sql = """
        SELECT task.id, task.taskType, task.taskTitle, task.isDone, task.isReminded, task.isTimeSet,
               task.nextReminderTimestamp, task.isRepeating, task.hasProgress, task.totalProgress,
               task.color, task.priority, task.creationTimestamp, task.updateTimestamp, task.manualSorting,
               IFNULL(ss.progressRecord, 0) as currentProgress
        FROM task
        LEFT JOIN (
            SELECT taskId, progressRecord
            FROM (
                SELECT ROW_NUMBER() OVER (PARTITION BY taskId ORDER BY startTimestamp DESC) AS rownum, timing.*
                FROM timing
            ) T
            WHERE T.rownum = 1
        ) ss ON task.id = ss.taskId
        ORDER BY task.updateTimestamp DESC
        """
        
        return DB.shared.fetchArray(withSQL: sql) { row in
            guard let id: Int = extractOptValue(from: row, key: "id") else { return nil }
            let taskType: Int = extractValue(from: row, key: "taskType")
            let taskTitle: String = extractValue(from: row, key: "taskTitle")
            let isDone: Bool = extractValue(from: row, key: "isDone")
            let isReminded: Bool = extractValue(from: row, key: "isReminded")
            let isTimeSet: Bool? = extractOptValue(from: row, key: "isTimeSet")
            let nextReminderTimestamp: Int? = extractOptValue(from: row, key: "nextReminderTimestamp")
            let isRepeating: Bool? = extractOptValue(from: row, key: "isRepeating")
            let hasProgress: Bool = extractValue(from: row, key: "hasProgress")
            let totalProgress: Int = extractValue(from: row, key: "totalProgress")
            let color: Int = extractValue(from: row, key: "color")
            let priority: Int = extractValue(from: row, key: "priority")
            let creationTimestamp: Int = extractValue(from: row, key: "creationTimestamp")
            let updateTimestamp: Int = extractValue(from: row, key: "updateTimestamp")
            let manualSorting: Int = extractValue(from: row, key: "manualSorting")
            let currentProgress: Int = extractValue(from: row, key: "currentProgress")
            let progressPercentage: Int = totalProgress != 0 ? (currentProgress * 100 / totalProgress) : 0

            return Models.HomeCell(id: id, taskType: taskType, taskTitle: taskTitle, isDone: isDone, isReminded: isReminded, isTimeSet: isTimeSet, nextReminderTimestamp: nextReminderTimestamp, isRepeating: isRepeating, hasProgress: hasProgress, color: color, priority: priority, creationTimestamp: creationTimestamp, updateTimestamp: updateTimestamp, manualSorting: manualSorting, progressPercentage: progressPercentage)
        }
        
    }
    
    // 返回未完成和已完成的cell数量
    private func fetchTaskCountsByIsDone() -> [Bool: Int] {
        let sql = "SELECT isDone, COUNT(*) as count FROM task GROUP BY isDone ORDER BY isDone"
        return DB.shared.fetchDictionary(withSQL: sql) { row in
            let isDone: Bool = extractValue(from: row, key: "isDone")
            let count: Int = extractValue(from: row, key: "COUNT(*)")
            return (isDone, count)
        }
    }
    
}
