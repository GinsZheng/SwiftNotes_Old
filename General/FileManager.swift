//
//  CSFileManager.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/11.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation

class CSFileManager: NSObject {
    static func readLocalFile(fileNameStr:String,type:String) -> Any? {
        //读取本地的文件
        let path = Bundle.main.path(forResource: fileNameStr, ofType: type)
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            return print("加载本地文件出错")
        }
    }
}


//class FileManager2: NSObject {
//    static func readLocalFile(fileNameStr:String,type:String) -> String? {
//        //读取本地的文件
//        let path = Bundle.main.path(forResource: fileNameStr, ofType: type)
//        let url = URL(fileURLWithPath: path!)
//        // 带throws的方法需要抛异常
//        do {
//            let data = try Data(contentsOf: url)
//            return data as String
//        } catch {
//            return print("加载本地文件出错")
//        }
//    }
//}
