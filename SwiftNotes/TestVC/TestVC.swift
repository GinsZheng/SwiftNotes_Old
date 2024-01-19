import UIKit
import Foundation
import SQLite

class ViewController: UIViewController {
    var projectsTable = ProjectsTable()
    
    let addButton = UIButton(type: .custom)
    let updateButton = UIButton(type: .custom)
    let deleteButton = UIButton(type: .custom)
    let queryButton = UIButton(type: .custom)
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}


// MARK: - 私有方法
extension ViewController {
    private func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        
        addButton.setup(superview: view)
        addButton.setStyleSolid17ptFgWhiteThemeButton(title: "添加")
        addButton.setFrame(left: kEdgeMargin, top: 0, right: kEdgeMargin, height: kButtonHeight)
        addButton.setEvent {
            let lastId = DB.shared.getLastId(tableName: DBTable.project)
            let newProject = Project(id: lastId+1, itemName: "项目1", resume: "项目简介", totalProgress: 50, color: 0, startDate: "2024-01-18")
            DB.shared.insert(table: self.projectsTable, model: newProject)
        }
        
        updateButton.setup(superview: view)
        updateButton.setStyleSolid17ptThemeWhiteButton(title: "更新")
        updateButton.setFrame(left: kEdgeMargin, top: addButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        updateButton.setEvent {
            let lastId = DB.shared.getLastId(tableName: DBTable.project)
            let updatedProject = Project(id: lastId, itemName: "项目1", resume: "项目简介", totalProgress: 50, color: 0, startDate: "2024-01-18")
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
        queryButton.setStyleGhost17ptThemeThemeButton(title: "查询")
        queryButton.setFrame(left: kEdgeMargin, top: deleteButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        queryButton.setEvent {
            let projects = self.projectsTable.getAllProjects()
            for project in projects {
                print("项目 ID: \(project.id), 名称: \(project.itemName), 进度: \(project.totalProgress), 颜色: \(project.color)")
            }
        }
        
        let createTableButton = UIButton(type: .custom)
        createTableButton.setup(superview: view)
        createTableButton.setStyleSolid17ptFgWhiteThemeButton(title: "创建一张表")
        createTableButton.setFrame(left: kEdgeMargin, top: queryButton.bottom + 44, right: kEdgeMargin, height: kButtonHeight)
        createTableButton.setEvent {
            self.projectsTable = ProjectsTable()
        }
        
        let deleteTableButton = UIButton(type: .custom)
        deleteTableButton.setup(superview: view)
        deleteTableButton.setStyleSolid17ptFgWhiteRedButton(title: "删除一张表")
        deleteTableButton.setFrame(left: kEdgeMargin, top: createTableButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        deleteTableButton.setEvent {
            DB.shared.deleteTable(tableName: DBTable.project)
        }
        
    }
    
}



// MARK: - 表
class ProjectsTable: TableProtocol {
    typealias ModelType = Project
    
    var tableName: String {
        return "project"
    }
    
    // 定义与数据库字段对应的表达式
    private let id = Expression<Int>("id")
    private let itemName = Expression<String>("itemName")
    private let resume = Expression<String>("resume")
    private let totalProgress = Expression<Int>("totalProgress")
    private let color = Expression<Int>("color")
    private let startDate = Expression<String?>("startDate")
    
    func toSetters(model: Project) -> [Setter] {
        return [
            itemName <- model.itemName,
            resume <- model.resume,
            totalProgress <- model.totalProgress,
            color <- model.color,
            startDate <- model.startDate
        ]
    }
}


extension ProjectsTable {
    func getAllProjects() -> [Project] {
        let rows = DB.shared.query(table: self)
        var projects = [Project]()
        for row in rows {
            let project = Project(
                id: row[id], // id 应该是 Int 类型
                itemName: row[itemName], // itemName 应该是 String 类型
                resume: row[resume], // resume 应该是 String 类型
                totalProgress: row[totalProgress], // totalProgress 应该是 Int 类型
                color: row[color], // color 应该是 Int 类型
                startDate: row[startDate] // startDate 可能是 String? 类型
            )
            projects.append(project)
        }
        return projects
    }
}


// MARK: - 私有方法
extension ProjectsTable {
    // 新增字段
    private func addNewColumnIfNeeded() {
        // 检查字段“startDate”是否存在，不存在时添加此字段
        if !DB.shared.isColumnExists(in: tableName, columnName: "startDate") {
            DB.shared.addColumn(to: tableName, columnName: "startDate", dataType: "TEXT")
        }
    }
}


// MARK: - Project 模型
struct Project {
    var id: Int
    var itemName: String
    var resume: String
    var totalProgress: Int
    var color: Int
    var startDate: String?
}

