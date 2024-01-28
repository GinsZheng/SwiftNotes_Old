//
//  TimingHistoryModel.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/28.
//  Copyright © 2024 GinsMac. All rights reserved.
//

extension Models {
    struct TimingHistory {
        var id: Int
        var progressPercentage: Int?
        var startTimestamp: Int
        var progressDuration: Int
        var endTimestamp: Int
        var timingDescription: String?
    }
}
