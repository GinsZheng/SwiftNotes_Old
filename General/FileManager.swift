//
//  FileManager.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/11.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation

class FileManager: NSObject {
    static func readLocalFile(fileNameStr:String,type:String) -> Any? {
        //读取本地的文件
        let path = Bundle.main.path(forResource: fileNameStr, ofType: type)
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            // 待验证后删除
            // let jsonData:Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
            // return jsonData
            return data
        } catch {
            return print("加载本地文件出错")
        }
    }
}

