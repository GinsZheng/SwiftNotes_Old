//
//  GroupModels.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/28.
//  Copyright © 2024 GinsMac. All rights reserved.
//

extension Models {
    struct GroupView {
        var id: Int
        var groupName: String
        var groupType: Int
        var groupSorting: Int
        var hideInSmartGroup: Bool?
        var hideGroup: Bool?
        var smartGroupPreset: Int?
    }
    
}
