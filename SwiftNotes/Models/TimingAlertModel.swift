//
//  TimingAlertModel.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/28.
//  Copyright © 2024 GinsMac. All rights reserved.
//

extension Models {
    struct TimingAlert {
        var id: Int
        var taskTitle: String?
        var startTimestamp: Int
        var duration: Int
    }
}
