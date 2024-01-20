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
    // 查询所有行
    func getAll() -> [Models.Project] {
        return DB.shared.query(table: self).compactMap { row in
            Models.Project(
                id: row[id],
                itemName: row[itemName],
                resume: row[resume],
                totalProgress: row[totalProgress],
                color: row[color],
                startDate: row[startDate]
            )
        }
    }

    // 查询
    func getAllWithSQL() -> [Models.Project] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.query(withSQL: sql) { row -> Models.Project? in
            guard let id = row["id"] as? Int,
                  let itemName = row["itemName"] as? String,
                  let resume = row["resume"] as? String,
                  let totalProgress = row["totalProgress"] as? Int,
                  let color = row["color"] as? Int 
            else { return nil }
            let startDate = row["startDate"] as? Int
            
            return Models.Project(id: id, itemName: itemName, resume: resume, totalProgress: totalProgress, color: color, startDate: startDate)
        }
    }
    
}


// MARK: - 私有方法
extension ProjectsTable {
    // 新增字段
    private func addNewColumnIfNeeded() {
        DB.shared.addColumnIfNeeded(tableName: self.tableName, columnName: "startDate", dataType: "INT")
    }
}


/*
 以compactMap为例，这个函数遍历数组中的每个元素，对每个元素执行闭包中的代码，然后收集return返回的值组成一个新的数组。如果闭包中的return返回了nil，那么这个元素会被compactMap忽略，不会出现在新数组中。
 在guard语句中，如果任何条件不满足（即无法成功提取出所有必要的字段），则返回nil。这意味着当前的迭代会被compactMap忽略。
 如果成功提取了所有字段，那么会创建一个Models.Project实例，并用return返回这个实例。这个返回值将会被包含在compactMap生成的新数组中。
 */

/*
 getAllWithSQL中使用guard的说明：
 // 必填字段放入guard中来避免使用强制解包，以让失败时不会崩溃
 guard let id = row["id"] as? Int,
       let itemName = row["itemName"] as? String,
       let resume = row["resume"] as? String,
       let totalProgress = row["totalProgress"] as? Int,
       let color = row["color"] as? Int else {
     return nil
 }
 let startDate = row["startDate"] as? Int // 可选字段
 */
