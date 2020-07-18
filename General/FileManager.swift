//
//  CSFileManager.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/11.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import SwiftCSV

class CSFileManager: NSObject {
    static func readFileAsData(fileNameStr: String,type: String) -> Data? {
        // 读取本地的文件
        // 只要名称是对的，无论在哪个文件夹下，都能读取到
        // 如果有两个名称及类型一致的文件，会有未知错误
        let path = Bundle.main.path(forResource: fileNameStr, ofType: type)
        let url = URL(fileURLWithPath: path!)
        // 带throws的方法需要抛异常
        do {
            let data = try Data(contentsOf: url)
            return data
        } catch {
            print("加载本地文件出错")
            return nil
        }
    }
    
    static func readFileAsString(fileNameStr: String, type:String) -> String? {
        print("hehe")
        //读取本地的文件
        let path = Bundle.main.path(forResource: fileNameStr, ofType: type)
        // 带throws的方法需要抛异常
        do {
            let str = try String(contentsOfFile: path ?? "加载本地文件出错")
            return str
        } catch {
            print("加载本地文件出错")
            return nil
        }
    }
    
    static func readFileAsCsv(fileNameStr: String, type:String) -> CSV? {
        let path = Bundle.main.path(forResource: fileNameStr, ofType: type)
        let url = URL(fileURLWithPath: path!)
        do {
            let csvFile: CSV = try CSV(url: url)
            return csvFile
        } catch {
            print("加载本地文件出错")
            return nil
        }
    }
    
}

