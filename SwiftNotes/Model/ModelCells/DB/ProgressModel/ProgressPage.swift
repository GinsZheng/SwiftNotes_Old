//
//  SQLiteJoinTablesPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/1/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SQLite

private class DataManager {
    private var progressTable = ProgressTable()
    
    func insertProgress(model: Models.Progress) {
        DB.shared.insert(table: progressTable, model: model)
    }
    
    func deleteProgress(id: Int) {
        DB.shared.delete(table: progressTable, id: id)
    }
    
    func updateProgress(id: Int, model: Models.Progress) {
        DB.shared.update(table: progressTable, id: id, model: model)
    }
    
    // 获取所有数据
    func getAllProgresses() -> [Models.Progress] {
        return progressTable.getAll()
    }
    
}

class ProgressPage: UIViewController {
    private let dataManager = DataManager()
    
    let insertButton = UIButton(type: .custom)
    let updateButton = UIButton(type: .custom)
    let deleteButton = UIButton(type: .custom)
    let queryButton = UIButton(type: .custom)
    let queryFromDBButton = UIButton(type: .custom)
    let queryFromSQLButton = UIButton(type: .custom)
    let createTableButton = UIButton(type: .custom)
    let deleteTableButton = UIButton(type: .custom)
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - 私有方法
extension ProgressPage {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        
        insertButton.setup(superview: view, target: self, action: #selector(handleAdding))
        insertButton.setStyleSolid17ptFgWhiteThemeButton(title: "添加")
        insertButton.setFrame(left: kEdgeMargin, top: 0, right: kEdgeMargin, height: kButtonHeight)
        
        deleteButton.setup(superview: view, target: self, action: #selector(handleDelete))
        deleteButton.setStyleSolid17ptFgWhiteRedButton(title: "删除")
        deleteButton.setFrame(left: kEdgeMargin, top: insertButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        
        updateButton.setup(superview: view, target: self, action: #selector(handleUpdate))
        updateButton.setStyleGhost17ptThemeThemeButton(title: "更新")
        updateButton.setFrame(left: kEdgeMargin, top: deleteButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        
        queryButton.setup(superview: view, target: self, action: #selector(handleQuery))
        queryButton.setStyleSolid17ptThemeWhiteButton(title: "查询")
        queryButton.setFrame(left: kEdgeMargin, top: updateButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        
        createTableButton.setup(superview: view, target: self, action: #selector(handleCreateTable))
        createTableButton.setStyleSolid17ptFgWhiteThemeButton(title: "创建一张表")
        createTableButton.setFrame(left: kEdgeMargin, top: queryButton.bottom + 44, right: kEdgeMargin, height: kButtonHeight)
        
        deleteTableButton.setup(superview: view, target: self, action: #selector(handleDeleteTable))
        deleteTableButton.setStyleSolid17ptFgWhiteRedButton(title: "删除一张表")
        deleteTableButton.setFrame(left: kEdgeMargin, top: createTableButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
    }
    
}


// MARK: - @objc方法
extension ProgressPage {
    // 2A：新增
    @objc func handleAdding() {
        let newProgress = Models.Progress(currentProgress: 7, startTime: 1596122800, endTime: 1596124800, itemId: 1)
        dataManager.insertProgress(model: newProgress)
    }
    
    // 2B：删除
    @objc func handleDelete() {
        let lastId = DB.shared.getLastId(tableName: DBTable.progress)
        dataManager.deleteProgress(id: lastId)
    }
    
    // 2C：更新
    @objc func handleUpdate() {
        let lastId = DB.shared.getLastId(tableName: DBTable.progress)
        let updatedProgress = Models.Progress(id: lastId, currentProgress: 20, startTime: 1596122800, endTime: 1596124800, itemId: 2)
        dataManager.updateProgress(id: lastId, model: updatedProgress)
    }
    
    // 2D：查询(SQL)
    @objc func handleQuery() {
        let progresses = dataManager.getAllProgresses()
        for progress in progresses {
            print("ID: \(progress.id), 进度: \(progress.currentProgress), 项目 ID: \(progress.id)")
        }
    }
    
    @objc func handleCreateTable() {
        dataManager.createTable()
    }
    
    @objc func handleDeleteTable() {
        dataManager.deleteTable()
    }
    
}


// MARK: - 不常见的逻辑，为方便测试而写
extension DataManager {
    // 创建表
    func createTable() {
        progressTable = ProgressTable()
    }
    
    // 删除表
    func deleteTable() {
        DB.shared.deleteTable(tableName: DBTable.progress)
    }
    
}

