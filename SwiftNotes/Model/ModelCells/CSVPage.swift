//
//  CSVPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2022/7/17.
//  Copyright © 2022 GinsMac. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftCSV

import UIKit

class CSVPage: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // MARK: -读取CSV文件
        
        let itemTable = CSItemTable()
        itemTable.getTable()
        let progressTable = CSProgressTable()
        progressTable.getTable()
        
        // 读取csv文件⌜item⌟。⌜item.csv⌟在项目中即可，不能有重名的文件
//        let itemCsv = CSFileManager.readFileAsCsv(fileNameStr: "item", type: "csv")!
//        // 把csv文件逐行转为字典数据
//        let itemData = itemCsv.namedRows
//        
//        // 将csv字典数据插入数据库
//        for i in 0..<itemData.count {
//            let row: [String: String] = itemData[i]
//            let result: [String: Any] = [
//                "id": Int(row["id"] ?? "") ?? 0,
//                "itemName": row["itemName"] ?? "",
//                "resume": row["resume"] ?? "",
//                "totalProgress": Int(row["totalProgress"] ?? "") ?? 100,
//                "color": Int(row["color"] ?? "") ?? 0,
//                "modifiedDate": Int(row["modifiedDate"] ?? "") ?? 1596124800,
//            ]
//            itemTable.insert(item: JSON(result))
//        }
//        
//        // 读取csv文件⌜progress⌟，下同
//        let progressCsv = CSFileManager.readFileAsCsv(fileNameStr: "progress", type: "csv")!
//        let progressData = progressCsv.namedRows
//        
//        for i in 0..<progressData.count {
//            let row: [String: String] = progressData[i]
//            let result: [String: Any] = [
//                "id": Int(row["id"] ?? "") ?? 0,
//                "currentProgress": Int(row["currentProgress"] ?? "") ?? 1,
//                "startTime": Int(row["startTime"] ?? "") ?? 1596124800,
//                "endTime": Int(row["endTime"] ?? "") ?? 1596124800,
//                "itemId": Int(row["itemId"] ?? "") ?? 0
//            ]
//            progressTable.insert(item: JSON(result))
//        }
        
        // MARK: - 导出CSV
        
        
    } // viewDidLoad
    
    
}

