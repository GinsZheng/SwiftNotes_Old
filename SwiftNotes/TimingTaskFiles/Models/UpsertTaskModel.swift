//
//  UpsertTaskModel.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/28.
//  Copyright © 2024 GinsMac. All rights reserved.
//

extension Models {
    struct UpsertTask {
        var id: Int
        var taskType: Int
        var taskTitle: String
        var taskContent: String?
        var isDone: Bool
        var isReminded: Bool
        var isTimeSet: Bool?
        var nextReminderTimestamp: Int?
        var reminderOccasions: [Int]?
        var isRepeating: Bool?
        var repeatCycle: Int?
        var repeatInterval: Int?
        var repeatDays: [Int]?
        var repeatType: Int?
        var repeatDates: [Int]?
        var whichWeek: Int?
        var dayOfWeek: Int?
        var months: [Int]?
        var endRepeatTimestamp: Int?
        var hasProgress: Bool
        var progressType: Int?
        var totalProgress: Int?
        var color: Int
        var priority: Int
        var subtaskIds: [Int]?
        var creationTimestamp: Int
        var updateTimestamp: Int
        var groupId: Int
        var isProgressSummaryHidden: Bool
        var manualSorting: Int
        var isInTrash: Bool
    }
}