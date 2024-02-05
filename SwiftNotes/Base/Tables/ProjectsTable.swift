import SQLite

extension Models {
    struct Project {
        var id: Int = 0
        var itemName: String
        var totalProgress: Int
    }
}


class ProjectDataManager {
    private let projectTable = ProjectTable()
    
    func insertProject(model: Models.Project) {
        DB.shared.insert(table: projectTable, model: model)
    }
    
    func deleteProject(id: Int) {
        DB.shared.delete(table: projectTable, id: id)
    }
    
    func updateProject(id: Int, model: Models.Project) {
        DB.shared.update(table: projectTable, id: id, model: model)
    }
    
    // 获取所有数据
    func fetchAllProjects() -> [Models.Project] {
        return projectTable.fetchAllData()
    }
    
}


// MARK: - 表类
class ProjectTable: TableProtocol {
    typealias ModelType = Models.Project
    var tableName: String { return DBTable.project }
    
    private let id = Expression<Int>("id")
    private let itemName = Expression<String>("itemName")
    private let totalProgress = Expression<Int>("totalProgress")
    
    // MARK: - 初始化与通用协议方法
    required init() {
        DB.shared.createTable(self)
    }
    
    // 定义字段
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(itemName)
        t.column(totalProgress)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.Project) -> [Setter] {
        var setters: [Setter] = [
            itemName <- model.itemName,
            totalProgress <- model.totalProgress,
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func fetchAllData() -> [Models.Project] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.fetchArray(withSQL: sql) { row -> Models.Project? in
            guard let id: Int = extractOptValue(from: row, key: "id") else { return nil }
            let itemName: String = extractValue(from: row, key: "itemName")
            let totalProgress: Int = extractValue(from: row, key: "totalProgress")
            
            return Models.Project(id: id, itemName: itemName, totalProgress: totalProgress)
        }
    }
    
}


// MARK: - 查询方法
extension ProjectTable {
    
}