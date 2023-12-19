//
//  ReadFilePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/7/18.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON

class CSReadFilePage: UIViewController {
    
    let progressTable = ProgressTable()
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        let fileToString = CSFileManager.readFileAsString(fileNameStr: "index", type: "html") ?? ""
        print("fileToString \(fileToString)")
        
        
//        let csv = CSFileManager.readFileAsCsv(fileNameStr: "progress", type: "csv")!
//        let data = csv.namedRows
//        for i in 0..<data.count {
//            let row: [String: String] = data[i]
//            let result: [String: Any] = [
//                "id": Int(row["id"] ?? "")!,
//                "currentProgress": Int(row["currentProgress"] ?? "")!,
//                "startTime": Int(row["startTime"] ?? "")!,
//                "endTime": Int(row["endTime"] ?? "")!,
//                "itemId": Int(row["itemId"] ?? "")!
//            ]
//            progressTable.insert(item: JSON(result))
//        }
//        let json = progressTable.getJSON()
//        let model = CSProgressModel.init(jsonData: json)
//        let idArray = model.id
//        let currentProgress = model.currentProgress
//        print("idArray \(idArray)")
//        print("currentProgress \(currentProgress)")
        
    }
    
    
}

