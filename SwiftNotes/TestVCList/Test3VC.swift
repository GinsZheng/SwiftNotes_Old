import SQLite

extension Models {
    struct User {
        var id: Int = 0
        var itemName: String
        var resume: String
        var totalProgress: Int
        var color: Int
        var title: String
        var date: Int
    }
}


// MARK: - 表类
class UserTable: TableProtocol {
    typealias ModelType = Models.User
    var tableName: String { return DBTable.user }
    
    private let id = Expression<Int>("id")
    private let itemName = Expression<String>("itemName")
    private let resume = Expression<String>("resume")
    private let totalProgress = Expression<Int>("totalProgress")
    private let color = Expression<Int>("color")
    private let title = Expression<String>("title")
    private let date = Expression<Int>("date")

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
        t.column(title)
        t.column(date)
    }
    
    // 定义Setter
    func modelToSetters(model: Models.User) -> [Setter] {
        var setters: [Setter] = [
            itemName <- model.itemName,
            resume <- model.resume,
            totalProgress <- model.totalProgress,
            color <- model.color,
            title <- model.title,
            date <- model.date
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
    // 查询所有行
    func getAll() -> [Models.User] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.query(withSQL: sql) { row -> Models.User? in
            guard let id = row["id"] as? Int,
                  let itemName = row["itemName"] as? String,
                  let resume = row["resume"] as? String,
                  let totalProgress = row["totalProgress"] as? Int,
                  let color = row["color"] as? Int,
                  let title = row["title"] as? String,
                  let date = row["date"] as? Int
            else { return nil }
            
            return Models.User(id: id, itemName: itemName, resume: resume, totalProgress: totalProgress, color: color, title: title, date: date)
        }
    }
    
}


// MARK: - 查询方法
extension UserTable {
    
}

