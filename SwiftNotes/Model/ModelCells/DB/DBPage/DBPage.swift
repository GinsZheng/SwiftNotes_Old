//
//  DBPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/20.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import UIKit
import SQLite

private class DataManager {
    private let table = ProjectTable()
    
    // ⚠️下一步
}

class DBPage: UIViewController {
    var projectTable = ProjectTable() // 1.初始化
    
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
extension DBPage {
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
extension DBPage {
    // 2A：新增
    @objc func handleAdding() {
        let newProject = Models.Project(itemName: "项目1", totalProgress: 50)
        DB.shared.insert(table: projectTable, model: newProject)
    }
    
    // 2B：删除
    @objc func handleDelete() {
        let lastId = DB.shared.getLastId(tableName: DBTable.project)
        DB.shared.delete(table: projectTable, id: lastId)
    }
    
    // 2C：更新
    @objc func handleUpdate() {
        let lastId = DB.shared.getLastId(tableName: DBTable.project)
        let updatedProject = Models.Project(id: lastId, itemName: "项目2", totalProgress: 80)
        DB.shared.update(table: projectTable, id: lastId, model: updatedProject)
    }

    // 2D：查询(SQL)
    @objc func handleQuery() {
        let projects = projectTable.getAll()
        for project in projects {
            print("项目 ID: \(project.id), 名称: \(project.itemName), 进度: \(project.totalProgress)")
        }
    }
    
    @objc func handleCreateTable() {
        projectTable = ProjectTable()
    }
    
    @objc func handleDeleteTable() {
        DB.shared.deleteTable(tableName: DBTable.project)
    }
    
}
