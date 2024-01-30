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
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 读取文件为字符串
        let fileToString = CSFileManager.readFileAsString(fileNameStr: "index", type: "html") ?? ""
        print("fileToString \(fileToString)")
        
        // 读取csv文件并转为 [[String: String]]?
        let csvFileData = CSFileManager.readCSVFile(csvFileName: CSVFile.taskGroup)
        print("csv文件数据:", csvFileData ?? [:])
        
        // 读取csv文件并插入数据库
        CSFileManager.importCSVToSQLite(csvFileName: CSVFile.taskGroup, tableName: DBTable.taskGroup)
        
    }
    
    
}

