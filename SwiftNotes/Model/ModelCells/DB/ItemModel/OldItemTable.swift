////
////  Model.swift
////  SwiftNotes
////
////  Created by GinsMac on 2019/11/24.
////  Copyright © 2019 GinsMac. All rights reserved.
////
//
//// ⚠️在完成所有查询内容的迁移前，不删
//import SQLite
//import SwiftyJSON
//
//extension ItemTable {
//    
//    // 获取字典
//    func getJSONOneRow(id: Int) -> JSON {
//        let result = try! getDB().prepare("SELECT * FROM \(tableName) WHERE id = \(id)")
//        var rowDict: [String: Any] = [:]
//        
//        for row in result {
//            let jsonRow = JSON(row)
//            rowDict = [
//                "id": jsonRow[0],
//                "itemName": jsonRow[1],
//                "resume": jsonRow[2],
//                "totalProgress": jsonRow[3],
//                "color": jsonRow[4]
//            ]
//        }
//        return JSON(rowDict)
//    }

//    func getFirstName() -> Binding {
//        let result = try! getDB().scalar("SELECT itemName FROM item, progress ORDER BY progress.startTime DESC LIMIT 1")
//        return result ?? ""
//    }
//    
//    
//    func getJoinedTablesJSON() -> JSON {
//        // 联结表时，如果两个表的字段一致(如id，需要指明表名，如：item.id)
//        let result = try! getDB().prepare("SELECT item.id, itemName FROM item, progress WHERE item.id = progress.id ORDER BY progress.startTime DESC")
//        var jsonArray: [Any] = []
//        
//        for row in result {
//            let jsonRow = JSON(row)
//            let rowDict: [String: Any] = [
//                "id": jsonRow[0],
//                "itemName": jsonRow[1],
//            ]
//            let jsonDict = JSON(rowDict)
//            jsonArray.append(jsonDict)
//        }
//        return JSON(jsonArray)
//    }
//    
//    func getJoinedTablesJSONOneLine() -> JSON {
//        
//        let result = try! getDB().prepare("SELECT item.id, itemName FROM item, progress WHERE item.id = progress.id ORDER BY progress.startTime DESC LIMIT 1")
//        
//        var rowDict: [String: Any] = [:]
//        
//        for row in result {
//            let jsonRow = JSON(row)
//            rowDict = [
//                "id": jsonRow[0],
//                "itemName": jsonRow[1],
//            ]
//        }
//        return JSON(rowDict)
//    }
//    
//
//}
//
