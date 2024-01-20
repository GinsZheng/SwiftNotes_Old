//
//  DBPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2024/1/20.
//  Copyright © 2024 GinsMac. All rights reserved.
//

import UIKit
import SQLite

class DBPage: UIViewController {
    var projectsTable = ProjectsTable()
    
    let addButton = UIButton(type: .custom)
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
        
        addButton.setup(superview: view)
        addButton.setStyleSolid17ptFgWhiteThemeButton(title: "添加")
        addButton.setFrame(left: kEdgeMargin, top: 0, right: kEdgeMargin, height: kButtonHeight)
        addButton.setEvent {
            let newProject = Models.Project(itemName: "项目1", resume: "项目简介", totalProgress: 50, color: 0, startDate: 1596124800)
            DB.shared.insert(table: self.projectsTable, model: newProject)
        }
        
        updateButton.setup(superview: view)
        updateButton.setStyleSolid17ptThemeWhiteButton(title: "更新")
        updateButton.setFrame(left: kEdgeMargin, top: addButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        updateButton.setEvent {
            let lastId = DB.shared.getLastId(tableName: DBTable.project)
            let updatedProject = Models.Project(id: lastId, itemName: "项目2", resume: "项目简介", totalProgress: 80, color: 1, startDate: 1596124801)
            DB.shared.update(table: self.projectsTable, id: lastId, model: updatedProject)
        }
        
        deleteButton.setup(superview: view)
        deleteButton.setStyleSolid17ptFgWhiteRedButton(title: "删除")
        deleteButton.setFrame(left: kEdgeMargin, top: updateButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        deleteButton.setEvent {
            let lastId = DB.shared.getLastId(tableName: DBTable.project)
            DB.shared.delete(table: self.projectsTable, id: lastId)
        }
        
        queryButton.setup(superview: view)
        queryButton.setStyleGhost17ptThemeThemeButton(title: "查询 (表)")
        queryButton.setFrame(left: kEdgeMargin, top: deleteButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        queryButton.setEvent {
            let projects = self.projectsTable.getAll()
            for project in projects {
                print("项目 ID: \(project.id), 名称: \(project.itemName), 进度: \(project.totalProgress), 颜色: \(project.color), 时间：\(project.startDate ?? 0)")
            }
        }
        
        queryFromSQLButton.setup(superview: view)
        queryFromSQLButton.setStyleGhost17ptThemeThemeButton(title: "查询 (SQL)")
        queryFromSQLButton.setFrame(left: kEdgeMargin, top: queryButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        queryFromSQLButton.setEvent {
            let projects = self.projectsTable.getAllWithSQL()
            for project in projects {
                print("项目 ID: \(project.id), 名称: \(project.itemName), 进度: \(project.totalProgress), 颜色: \(project.color), 时间：\(project.startDate ?? 0)")
            }
        }
        
        createTableButton.setup(superview: view)
        createTableButton.setStyleSolid17ptFgWhiteThemeButton(title: "创建一张表")
        createTableButton.setFrame(left: kEdgeMargin, top: queryFromSQLButton.bottom + 44, right: kEdgeMargin, height: kButtonHeight)
        createTableButton.setEvent {
            self.projectsTable = ProjectsTable()
        }
        
        deleteTableButton.setup(superview: view)
        deleteTableButton.setStyleSolid17ptFgWhiteRedButton(title: "删除一张表")
        deleteTableButton.setFrame(left: kEdgeMargin, top: createTableButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        deleteTableButton.setEvent {
            DB.shared.deleteTable(tableName: DBTable.project)
        }
        
    }
    
}

