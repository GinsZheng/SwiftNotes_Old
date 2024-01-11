//
//  Try.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import Foundation
import UIKit
import SQLite

class CSTryPage: UIViewController {
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
    }
    
}

/*
 throws抛出异常，必须通过try来处理
 try: 必须结合 do catch 来处理
 try? : 有错返回nil，无错返回可选值。相当于忽略错误
 try! ：告诉系统一定没错，有错直接崩溃，不推荐使用
 */



// example
class TryTable: SQLiteManager {
    
    private var tbl: Table?
    let rowid = Expression<Int>("id")
    let itemName = Expression<String>("itemName")
    let resume = Expression<String>("resume")
    
    // 使用 Try!
    func getTable() -> Table {
        if tbl == nil {
            tbl = Table("item")
            // 使用try!之前，应判断了是否为nil，以避免崩溃
            try! getDB().run(tbl!.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (t) in
                t.column(rowid, primaryKey: true)
                t.column(itemName)
                t.column(resume)
            }))
        }
        return tbl!
    }
        
        
    // 使用try
    func getIdList() -> [Int] {
        
        let query = getTable()
        var data = [Int]()
        // 最常用，使用trys配合do catch来捕获异常
        do {
            for user in try getDB().prepare(query) {
                print(user[rowid])
                data.append(user[rowid])
            }
        } catch {
            print("Wrong")
        }
        
        return data
    }
    
    
    // 使用try?
    func delete(filter: Expression<Bool>? = nil) {
        
        var query = getTable()
        if let f = filter {
            query = query.filter(f)
        }
        // 由于错误时返回nil，所以可用于if语句中，相当于catch，
        // 写法简单，适用于无返回值的函数(因为会返回可选值)
        if let count = try? getDB().run(query.delete()) {
            print("删除的条数为：\(count)")
        } else {
            print("删除失败")
        }
        
    }
    
}
