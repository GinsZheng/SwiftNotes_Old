//
//  ForthTab.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/6/10.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit
import SwiftCSV
import SwiftyJSON

class TestVC: UIViewController {

    let label = UILabel()
    
    let progressTable = CSProgressTable()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let csv = CSFileManager.readFileAsCsv(fileNameStr: "progress", type: "csv")!
        let data = csv.namedRows
        
        for i in 0..<data.count {
            let row: [String: String] = data[i]
            let result: [String: Any] = [
                "id": Int(row["id"] ?? "")!,
                "currentProgress": Int(row["currentProgress"] ?? "")!,
                "startTime": Int(row["startTime"] ?? "")!,
                "endTime": Int(row["endTime"] ?? "")!,
                "itemId": Int(row["itemId"] ?? "")!
            ]
            progressTable.insert(item: JSON(result))
        }
        
        let json = progressTable.getJSON()
        let model = CSProgressModel.init(jsonData: json)
        let idArray = model.id
        let currentProgress = model.currentProgress
        print("idArray \(idArray)")
        print("currentProgress \(currentProgress)")
        
    }
    
    
    
    
}


