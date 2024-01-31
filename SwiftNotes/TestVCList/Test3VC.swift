//import SQLite
//
//extension Models {
//    struct User {
//        var id: Int = 0
//        var taskType: Int
//        var taskTitle: String
//        var taskContent: String?
//        var isDone: Bool
//        var isReminded: Bool
//        var isTimeSet: Bool?
//        var nextReminderTimestamp: Int?
//        var reminderOccasions: [Int]
//        var isRepeating: Bool?
//        var repeatCycle: Int?
//        var repeatInterval: Int?
//        var repeatDays: [Int]
//        var repeatType: Int?
//        var repeatDates: [Int]
//        var whichWeek: Int?
//        var dayOfWeek: Int?
//        var months: [Int]
//        var endRepeatTimestamp: Int?
//        var hasProgress: Bool
//        var progressType: Int?
//        var totalProgress: Int?
//        var color: Int
//        var priority: Int
//        var subtaskIds: [Int]
//        var creationTimestamp: Int
//        var updateTimestamp: Int
//        var groupId: Int
//        var isProgressSummaryHidden: Bool
//        var manualSorting: Int
//        var isInTrash: Bool
//    }
//}
//
//
//// MARK: - 表类
//class UserTable: TableProtocol {
//    typealias ModelType = Models.User
//    var tableName: String { return DBTable.user }
//    
//    private let id = Expression<Int>("id")
//    private let taskType = Expression<Int>("taskType")
//    private let taskTitle = Expression<String>("taskTitle")
//    private let taskContent = Expression<String?>("taskContent")
//    private let isDone = Expression<Bool>("isDone")
//    private let isReminded = Expression<Bool>("isReminded")
//    private let isTimeSet = Expression<Bool?>("isTimeSet")
//    private let nextReminderTimestamp = Expression<Int?>("nextReminderTimestamp")
//    private let reminderOccasions = Expression<String>("reminderOccasions")
//    private let isRepeating = Expression<Bool?>("isRepeating")
//    private let repeatCycle = Expression<Int?>("repeatCycle")
//    private let repeatInterval = Expression<Int?>("repeatInterval")
//    private let repeatDays = Expression<String>("repeatDays")
//    private let repeatType = Expression<Int?>("repeatType")
//    private let repeatDates = Expression<String>("repeatDates")
//    private let whichWeek = Expression<Int?>("whichWeek")
//    private let dayOfWeek = Expression<Int?>("dayOfWeek")
//    private let months = Expression<String>("months")
//    private let endRepeatTimestamp = Expression<Int?>("endRepeatTimestamp")
//    private let hasProgress = Expression<Bool>("hasProgress")
//    private let progressType = Expression<Int?>("progressType")
//    private let totalProgress = Expression<Int?>("totalProgress")
//    private let color = Expression<Int>("color")
//    private let priority = Expression<Int>("priority")
//    private let subtaskIds = Expression<String>("subtaskIds")
//    private let creationTimestamp = Expression<Int>("creationTimestamp")
//    private let updateTimestamp = Expression<Int>("updateTimestamp")
//    private let groupId = Expression<Int>("groupId")
//    private let isProgressSummaryHidden = Expression<Bool>("isProgressSummaryHidden")
//    private let manualSorting = Expression<Int>("manualSorting")
//    private let isInTrash = Expression<Bool>("isInTrash")
//
//    // MARK: - 初始化与通用协议方法
//    required init() {
//        DB.shared.createTable(self)
//    }
//    
//    // 定义字段
//    func defineTable(t: TableBuilder) {
//        t.column(id, primaryKey: .autoincrement)
//        t.column(taskType)
//        t.column(taskTitle)
//        t.column(taskContent)
//        t.column(isDone)
//        t.column(isReminded)
//        t.column(isTimeSet)
//        t.column(nextReminderTimestamp)
//        t.column(reminderOccasions)
//        t.column(isRepeating)
//        t.column(repeatCycle)
//        t.column(repeatInterval)
//        t.column(repeatDays)
//        t.column(repeatType)
//        t.column(repeatDates)
//        t.column(whichWeek)
//        t.column(dayOfWeek)
//        t.column(months)
//        t.column(endRepeatTimestamp)
//        t.column(hasProgress)
//        t.column(progressType)
//        t.column(totalProgress)
//        t.column(color)
//        t.column(priority)
//        t.column(subtaskIds)
//        t.column(creationTimestamp)
//        t.column(updateTimestamp)
//        t.column(groupId)
//        t.column(isProgressSummaryHidden)
//        t.column(manualSorting)
//        t.column(isInTrash)
//    }
//    
//    // 定义Setter
//    func modelToSetters(model: Models.User) -> [Setter] {
//        var setters: [Setter] = [
//            taskType <- model.taskType,
//            taskTitle <- model.taskTitle,
//            taskContent <- model.taskContent,
//            isDone <- model.isDone,
//            isReminded <- model.isReminded,
//            isTimeSet <- model.isTimeSet,
//            nextReminderTimestamp <- model.nextReminderTimestamp,
//            reminderOccasions <- arrayToString(model.reminderOccasions),
//            isRepeating <- model.isRepeating,
//            repeatCycle <- model.repeatCycle,
//            repeatInterval <- model.repeatInterval,
//            repeatDays <- arrayToString(model.repeatDays),
//            repeatType <- model.repeatType,
//            repeatDates <- arrayToString(model.repeatDates),
//            whichWeek <- model.whichWeek,
//            dayOfWeek <- model.dayOfWeek,
//            months <- arrayToString(model.months),
//            endRepeatTimestamp <- model.endRepeatTimestamp,
//            hasProgress <- model.hasProgress,
//            progressType <- model.progressType,
//            totalProgress <- model.totalProgress,
//            color <- model.color,
//            priority <- model.priority,
//            subtaskIds <- arrayToString(model.subtaskIds),
//            creationTimestamp <- model.creationTimestamp,
//            updateTimestamp <- model.updateTimestamp,
//            groupId <- model.groupId,
//            isProgressSummaryHidden <- model.isProgressSummaryHidden,
//            manualSorting <- model.manualSorting,
//            isInTrash <- model.isInTrash
//        ]
//        // 如果 id 非默认值(编辑时)，则添加
//        if model.id != 0 { setters.append(id <- model.id) }
//        return setters
//    }
//    
//    // 查询所有行
//    func fetchAllData() -> [Models.User] {
//        let sql = "SELECT * FROM \(tableName)"
//        return DB.shared.fetchArray(withSQL: sql) { row -> Models.User? in
//            guard let id = row["id"] as? Int else { return nil }
//            let taskType = row["taskType"] as? Int ?? 0
//            let taskTitle = row["taskTitle"] as? String ?? ""
//            let taskContent = row["taskContent"] as? String
//            let isDone = row["isDone"] as? Bool ?? false
//            let isReminded = row["isReminded"] as? Bool ?? false
//            let isTimeSet = row["isTimeSet"] as? Bool
//            let nextReminderTimestamp = row["nextReminderTimestamp"] as? Int
//            let reminderOccasions = row["reminderOccasions"] as? [Int]
//            let isRepeating = row["isRepeating"] as? Bool
//            let repeatCycle = row["repeatCycle"] as? Int
//            let repeatInterval = row["repeatInterval"] as? Int
//            let repeatDays = row["repeatDays"] as? [Int]
//            let repeatType = row["repeatType"] as? Int
//            let repeatDates = row["repeatDates"] as? [Int]
//            let whichWeek = row["whichWeek"] as? Int
//            let dayOfWeek = row["dayOfWeek"] as? Int
//            let months = row["months"] as? [Int]
//            let endRepeatTimestamp = row["endRepeatTimestamp"] as? Int
//            let hasProgress = row["hasProgress"] as? Bool ?? false
//            let progressType = row["progressType"] as? Int
//            let totalProgress = row["totalProgress"] as? Int
//            let color = row["color"] as? Int ?? 0
//            let priority = row["priority"] as? Int ?? 0
//            let subtaskIds = row["subtaskIds"] as? [Int]
//            let creationTimestamp = row["creationTimestamp"] as? Int ?? 0
//            let updateTimestamp = row["updateTimestamp"] as? Int ?? 0
//            let groupId = row["groupId"] as? Int ?? 0
//            let isProgressSummaryHidden = row["isProgressSummaryHidden"] as? Bool ?? false
//            let manualSorting = row["manualSorting"] as? Int ?? 0
//            let isInTrash = row["isInTrash"] as? Bool ?? false
//
//            return Models.User(id: id, taskType: taskType, taskTitle: taskTitle, taskContent: taskContent, isDone: isDone, isReminded: isReminded, isTimeSet: isTimeSet, nextReminderTimestamp: nextReminderTimestamp, reminderOccasions: reminderOccasions, isRepeating: isRepeating, repeatCycle: repeatCycle, repeatInterval: repeatInterval, repeatDays: repeatDays, repeatType: repeatType, repeatDates: repeatDates, whichWeek: whichWeek, dayOfWeek: dayOfWeek, months: months, endRepeatTimestamp: endRepeatTimestamp, hasProgress: hasProgress, progressType: progressType, totalProgress: totalProgress, color: color, priority: priority, subtaskIds: subtaskIds, creationTimestamp: creationTimestamp, updateTimestamp: updateTimestamp, groupId: groupId, isProgressSummaryHidden: isProgressSummaryHidden, manualSorting: manualSorting, isInTrash: isInTrash)
//        }
//    }
//    
//}
//
//
//// MARK: - 查询方法
//extension UserTable {
//    
//}
//
