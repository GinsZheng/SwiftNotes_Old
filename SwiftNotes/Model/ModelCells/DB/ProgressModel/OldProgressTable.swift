////
////  JoindModelIns.swift
////  SwiftNotes
////
////  Created by GinsMac on 2020/1/17.
////  Copyright © 2020 GinsMac. All rights reserved.
////
//
////
////  Model.swift
////  SwiftNotes
////
////  Created by GinsMac on 2019/11/24.
////  Copyright © 2019 GinsMac. All rights reserved.
////
//
//
//
//extension ProgressTable {

//    // 获取计算JSON
//    func getCalJson() -> JSON {
//        // 获取每个分组的第一行
//        let result = try! getDB().prepare("SELECT * FROM ( SELECT progress.*, ROW_NUMBER () over (PARTITION BY itemId ORDER BY startTime DESC) AS rownum FROM progress) T WHERE T.rownum=1")
//        var jsonArray: [Any] = []
//        
//        for row in result {
//            let jsonRow = JSON(row)
//            let rowDict: [String: Any] = [
//                "id": jsonRow[0],
//                "currentProgress": jsonRow[1],
//                "startTime": jsonRow[2],
//                "endTime": jsonRow[3],
//                "itemId": jsonRow[4],
//            ]
//            let jsonDict = JSON(rowDict)
//            jsonArray.append(jsonDict)
//        }
//        return JSON(jsonArray)
//    }
//    
//    // 获取数组
//    func getArray() -> [Int] {
//        // 获取每个分组的第一行，返回Array
//        let result = try! getDB().prepare("SELECT currentProgress FROM ( SELECT progress.*, ROW_NUMBER () over (PARTITION BY itemId ORDER BY startTime DESC) AS rownum FROM progress) T WHERE T.rownum=1")
//        var jsonArray: [Any] = []
//        
//        for row in result {
//            let jsonRow = JSON(row)
//            let rowDict: [String: Any] = [
//                "currentProgress": jsonRow[0],
//            ]
//            let jsonData = JSON(rowDict)
//            jsonArray.append(jsonData)
//        }
//        let arr = JSON(jsonArray).arrayValue.map {$0["currentProgress"].intValue}
//        
//        return arr
//    }
//
//}
//
//
//
//struct CSProgressModel {
//    var id: [Int]
//    var currentProgress: [Int]
//    var startTime: [Int]
//    var endTime: [Int]
//    var itemId: [Int]
//
//    init(jsonData: JSON) {
//        id = jsonData.arrayValue.map {$0["id"].intValue}
//        currentProgress = jsonData.arrayValue.map {$0["currentProgress"].intValue}
//        startTime = jsonData.arrayValue.map {$0["startTime"].intValue}
//        endTime = jsonData.arrayValue.map {$0["endTime"].intValue}
//        itemId = jsonData.arrayValue.map {$0["itemId"].intValue}
//    }
//}
//
