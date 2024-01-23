import SQLite

extension Models {
    struct Project {
        var id: Int = 0
        var itemName: String
        var resume: String
        var totalProgress: Int
        var color: Int
        var startDate: Int
    }
}


// MARK: - 表类
class ProjectTable: TableProtocol {
    typealias ModelType = Models.Project
    var tableName: String { return DBTable.project }
    
    private let id = Expression<Int>("id")
    private let itemName = Expression<String>("itemName")
    private let resume = Expression<String>("resume")
    private let totalProgress = Expression<Int>("totalProgress")
    private let color = Expression<Int>("color")
    private let startDate = Expression<Int>("startDate")
    
    // MARK: - 初始化与通用协议方法
    required init() {
        DB.shared.createTable(self)
    }
    
    // 定义字段
    func defineTable(t: TableBuilder) {
        t.column(id, primaryKey: .autoincrement)
        t.column(itemName)
        t.column(resume)
        t.column(totalProgress)
        t.column(color)
        t.column(startDate)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.Project) -> [Setter] {
        var setters: [Setter] = [
            itemName <- model.itemName,
            resume <- model.resume,
            totalProgress <- model.totalProgress,
            color <- model.color,
            startDate <- model.startDate
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func getAll() -> [Models.Project] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.query(withSQL: sql) { row -> Models.Project? in
            guard let id = row["id"] as? Int,
                  let itemName = row["itemName"] as? String,
                  let resume = row["resume"] as? String,
                  let totalProgress = row["totalProgress"] as? Int,
                  let color = row["color"] as? Int,
                  let startDate = row["startDate"] as? Int
            else { return nil }
            
            return Models.Project(id: id, itemName: itemName, resume: resume, totalProgress: totalProgress, color: color, startDate: startDate)
        }
    }
    
}


// MARK: - 查询方法
extension ProjectTable {
    
}
