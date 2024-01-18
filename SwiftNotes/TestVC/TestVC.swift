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
//            self.projectsTable.addProject(name: "项目1", resume: "项目简介", progress: 50, color: 0)
            let lastId = DB.shared.getLastId(tableName: DBTable.project)
            let newProject = Project(id: lastId+1, itemName: "项目1", resume: "项目简介", totalProgress: 50, color: 0, startDate: "2024-01-18")
//            DB.shared.insert(table: self.projectsTable, model: newProject)
            DB.shared.insert(table: self.projectsTable, model: newProject)
        }
        
        updateButton.setup(superview: view)
        updateButton.setStyleSolid17ptThemeWhiteButton(title: "更新")
        updateButton.setFrame(left: kEdgeMargin, top: addButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        updateButton.setEvent {
            let lastId = DB.shared.getLastId(tableName: DBTable.project)
            let updatedProject = Project(id: lastId, itemName: "项目1", resume: "项目简介", totalProgress: 50, color: 0, startDate: "2024-01-18")
            DB.shared.update(table: self.projectsTable, id: lastId, model: updatedProject)
//            self.projectsTable.updateProject(projectId: lastId, name: "更新后的项目名", resume: nil, progress: 75, color: nil)
        }
        
        deleteButton.setup(superview: view)
        deleteButton.setStyleSolid17ptFgWhiteRedButton(title: "删除")
        deleteButton.setFrame(left: kEdgeMargin, top: updateButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        deleteButton.setEvent {
//            let lastId = DB.shared.getLastId(tableName: DBTable.project)
//            self.projectsTable.deleteProject(projectId: lastId)
            let lastId = DB.shared.getLastId(tableName: DBTable.project)
            DB.shared.delete(table: self.projectsTable, id: lastId)
        }
        
        queryButton.setup(superview: view)
        queryButton.setStyleGhost17ptThemeThemeButton(title: "查询")
        queryButton.setFrame(left: kEdgeMargin, top: deleteButton.bottom + kVertMargin, right: kEdgeMargin, height: kButtonHeight)
        queryButton.setEvent {
//            let projects = self.projectsTable.getAllProjects()
//            for project in projects {
//                print("项目 ID: \(project.id), 名称: \(project.itemName), 进度: \(project.totalProgress), 颜色: \(project.color)")
//            }
            
            let projects = DB.shared.query(table: self.projectsTable)
            // 遍历每一行并打印 "id" 和 "itemName"
            for row in projects {
                let id = row[Expression<Int>("id")]
                let itemName = row[Expression<String>("itemName")]
                print("id: \(id), itemName: \(itemName)")
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

    func toSetters(model: Project) -> [Setter] {
        return [
            Expression<String>("itemName") <- model.itemName,
            Expression<String>("resume") <- model.resume,
            Expression<Int>("totalProgress") <- model.totalProgress,
            Expression<Int>("color") <- model.color,
            Expression<String?>("startDate") <- model.startDate
        ]
    }

}


//class ProjectsTable {
//    // 定义表名与字段
//    private let tableName: String = DBTable.project
//    private let id = Expression<Int>("id")
//    private let itemName = Expression<String>("itemName")
//    private let resume = Expression<String>("resume")
//    private let totalProgress = Expression<Int>("totalProgress")
//    private let color = Expression<Int>("color")
//    private let startDate = Expression<String?>("startDate") // 后添加新字段 startDate
//    
//    private let table: Table
//    
//    init() {
//        table = Table(tableName)
//        createTable()
//        addNewColumnIfNeeded()
//    }
//    
//    func addProject(name: String, resume: String, progress: Int, color: Int) {
//        DB.shared.insert(table: table, values: [
//            self.itemName <- name,
//            self.resume <- resume,
//            self.totalProgress <- progress,
//            self.color <- color
//        ])
//    }
//    
//    func deleteProject(projectId: Int) {
//        DB.shared.delete(table: table, id: projectId)
//    }
//    
//    func updateProject(projectId: Int, name: String?, resume: String?, progress: Int?, color: Int?) {
//        var setters: [Setter] = []
//        if let name = name { setters.append(self.itemName <- name) }
//        if let resume = resume { setters.append(self.resume <- resume) }
//        if let progress = progress { setters.append(self.totalProgress <- progress) }
//        if let color = color { setters.append(self.color <- color) }
//        DB.shared.update(table: table, id: projectId, values: setters)
//    }
//    
//    func getAllProjects() -> [Project] {
//        let rows = DB.shared.query(table: table)
//        var projects = [Project]()
//        for row in rows {
//            let project = Project(id: row[id],
//                                  itemName: row[itemName],
//                                  resume: row[resume],
//                                  totalProgress: row[totalProgress],
//                                  color: row[color])
//            projects.append(project)
//        }
//        return projects
//    }
//}


// MARK: - 私有方法
extension ProjectsTable {
//    private func createTable() {
//        guard let db = DB.shared.database else { return }
//        do {
//            try db.run(table.create(ifNotExists: true) { t in
//                t.column(id, primaryKey: .autoincrement)
//                t.column(itemName)
//                t.column(resume)
//                t.column(totalProgress)
//                t.column(color)
//                t.column(startDate) // 后加的字段
//            })
//        } catch {
//            print("创建表失败: \(error)")
//        }
//    }
    
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
