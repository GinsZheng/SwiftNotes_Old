//
//  HomeTableModels.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/28.
//  Copyright © 2024 GinsMac. All rights reserved.
//

extension Models {
    struct HomeCell {
        var id: Int
        var taskType: Int                       // 0：任务，1：子任务
        var taskTitle: String
        var isDone: Bool
        var isReminded: Bool
        var isTimeSet: Bool?
        var nextReminderTimestamp: Int?
        var isRepeating: Bool?
        var hasProgress: Bool
        var color: Int                          // 0:蓝色 | 1:紫 | 2:品红 | 3:红 | 4:橙 | 5:绿
        var priority: Int                       // 0:无 | 1:低 | 2:中 | 3:高
        var creationTimestamp: Int
        var updateTimestamp: Int
        var manualSorting: Int
        var progressPercentage: Int?
    }
    
}

