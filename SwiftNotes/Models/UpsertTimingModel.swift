//
//  UpsertTimingModel.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/28.
//  Copyright © 2024 GinsMac. All rights reserved.
//

extension Models {
    struct UpsertTiming {
        var id: Int
        var taskId: Int?
        var taskColor: Int?
        var taskTitle: String?
        var totalProgress: Int?
        var progressRecord: Int?
        var progressSummary: String?
        var startTimestamp: Int
        var endTimestamp: Int
        var pauseDuration: Int?
        var progressDuration: Int
        var previousProgress: Int?
    }
    
}
