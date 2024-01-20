import UIKit
import Foundation
import SQLite

class ViewController: UIViewController {
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
extension ViewController {
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
            let updatedProject = Models.Project(id: lastId, itemName: "项目1", resume: "项目简介", totalProgress: 80, color: 1, startDate: 1596124801)
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
        queryButton.setStyleGhost17ptThemeThemeButton(title: "查询 (表特有方法)")
        queryButton.setFrame(left: kEdgeMargin, top: deleteButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        queryButton.setEvent {
            let projects = self.projectsTable.getAllProjects()
            for project in projects {
                print("项目 ID: \(project.id), 名称: \(project.itemName), 进度: \(project.totalProgress), 颜色: \(project.color), 时间：\(project.startDate ?? 0)")
            }
        }
        
        // 使用DB类的通用查询
        queryFromDBButton.setup(superview: view)
        queryFromDBButton.setStyleGhost17ptThemeThemeButton(title: "查询 (DB通用方法)")
        queryFromDBButton.setFrame(left: kEdgeMargin, top: queryButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        queryFromDBButton.setEvent {
            let projects = DB.shared.getAll(of: ProjectsTable.self)
            for project in projects {
                print("项目 ID: \(project.id), 名称: \(project.itemName), 进度: \(project.totalProgress), 颜色: \(project.color), 时间：\(project.startDate ?? 0)")
            }
        }
        
        queryFromSQLButton.setup(superview: view)
        queryFromSQLButton.setStyleGhost17ptThemeThemeButton(title: "查询 (SQL)")
        queryFromSQLButton.setFrame(left: kEdgeMargin, top: queryFromDBButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        queryFromSQLButton.setEvent {
            let projects = self.projectsTable.getAllProjectsUsingRawQuery()
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


// MARK: - 模型
extension Models {
    struct Project {
        var id: Int = 0
        var itemName: String
        var resume: String
        var totalProgress: Int
        var color: Int
        var startDate: Int?
    }
}


// MARK: - 表
class ProjectsTable: TableProtocol {
    typealias ModelType = Models.Project
    
    var tableName: String {
        return DBTable.project
    }
    
    // 定义与数据库字段对应的表达式
    private let id = Expression<Int>("id")
    private let itemName = Expression<String>("itemName")
    private let resume = Expression<String>("resume")
    private let totalProgress = Expression<Int>("totalProgress")
    private let color = Expression<Int>("color")
    private let startDate = Expression<Int?>("startDate")
    
    required init() {
        DB.shared.createTable(self)
    }
    
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(itemName)
        t.column(resume)
        t.column(totalProgress)
        t.column(color)
        t.column(startDate)
    }
    
    func modelToSetters(model: Models.Project) -> [Setter] {
        var setters: [Setter] = [
            itemName <- model.itemName,
            resume <- model.resume,
            totalProgress <- model.totalProgress,
            color <- model.color,
            startDate <- model.startDate
        ]
        // 如果 id 非默认值，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
}


extension ProjectsTable {
    // 查询所有行：通过DB实现
    func rowToModel(_ row: Row) -> Models.Project? {
        return Models.Project(
            id: row[id],
            itemName: row[itemName],
            resume: row[resume],
            totalProgress: row[totalProgress],
            color: row[color],
            startDate: row[startDate]
        )
    }
    
    // 查询所有行：在表内实现
    func getAllProjects() -> [Models.Project] {
        let rows = DB.shared.query(table: self)
        var projects = [Models.Project]()
        for row in rows {
            let project = Models.Project(
                id: row[id],
                itemName: row[itemName],
                resume: row[resume],
                totalProgress: row[totalProgress],
                color: row[color],
                startDate: row[startDate]
            )
            projects.append(project)
        }
        return projects
    }
    
    func getAllProjectsUsingRawQuery() -> [Models.Project] {
        let sql = "SELECT * FROM \(tableName)"
        let rows = DB.shared.executeQuery(with: sql)
        var projects: [Models.Project] = []
        
        for row in rows {
            guard let id = row["id"] as? Int,
                  let itemName = row["itemName"] as? String,
                  let resume = row["resume"] as? String,
                  let totalProgress = row["totalProgress"] as? Int,
                  let color = row["color"] as? Int else {
                continue // 如果任何必需字段缺失或类型不匹配，跳过这行
            }
            
            let startDate = row["startDate"] as? Int // startDate 是可选的
            
            let project = Models.Project(
                id: id,
                itemName: itemName,
                resume: resume,
                totalProgress: totalProgress,
                color: color,
                startDate: startDate
            )
            projects.append(project)
            
        }
        
        return projects
    }
    
    //    func getAllProjectsUsingRawQuery() -> [Models.Project] {
    //        let sql = "SELECT * FROM \(tableName)"
    //        let rows = DB.shared.executeQuery(with: sql)
    //        var projects: [Models.Project] = []
    //
    //        for row in rows {
    //            // 处理每个字段，确保类型匹配和正确处理 Optional
    //            if let id = row["id"] as? Int64, // id 通常是 Int64
    //               let itemName = row["itemName"] as? String,
    //               let resume = row["resume"] as? String,
    //               let totalProgress = row["totalProgress"] as? Int64, // 假设 totalProgress 也是 Int64
    //               let color = row["color"] as? Int64 { // 假设 color 也是 Int64
    //
    //                let startDateValue = row["startDate"] as? Int64
    //                let startDate = startDateValue != nil ? Int(startDateValue!) : nil // 处理可选的 startDate
    //
    //                let project = Models.Project(
    //                    id: Int(id),
    //                    itemName: itemName,
    //                    resume: resume,
    //                    totalProgress: Int(totalProgress),
    //                    color: Int(color),
    //                    startDate: startDate
    //                )
    //                projects.append(project)
    //            }
    //        }
    //        return projects
    //    }
    //
    
    
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


