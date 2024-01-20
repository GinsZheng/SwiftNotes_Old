import SQLite

extension Models {
    struct Item {
        var id: Int = 0
        var itemName: String
        var resume: String
        var totalProgress: Int
        var color: Int
    }
}


// MARK: - 表类
class ItemTable: TableProtocol {
    typealias ModelType = Models.Item
    var tableName: String { return DBTable.item }
    
    private let id = Expression<Int>("id")
    private let itemName = Expression<String>("itemName")
    private let resume = Expression<String>("resume")
    private let totalProgress = Expression<Int>("totalProgress")
    private let color = Expression<Int>("color")
    
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
    }
    
    // 定义Setter
    func modelToSetters(model: Models.Item) -> [Setter] {
        var setters: [Setter] = [
            itemName <- model.itemName,
            resume <- model.resume,
            totalProgress <- model.totalProgress,
            color <- model.color,
        ]
        // 如果 id 非默认值(编辑时)，则添加
        if model.id != 0 { setters.append(id <- model.id) }
        return setters
    }
    
}


// MARK: - 查询方法
extension ItemTable {
    // 查询所有行
    func getAll() -> [Models.Item] {
        return DB.shared.query(table: self).compactMap { row in
            Models.Item(
                id: row[id],
                itemName: row[itemName],
                resume: row[resume],
                totalProgress: row[totalProgress],
                color: row[color]
            )
        }
    }

    // 查询
    func getAllWithSQL() -> [Models.Item] {
        let sql = "SELECT * FROM \(tableName)"
        return DB.shared.query(withSQL: sql) { row -> Models.Item? in
            guard let id = row["id"] as? Int,
                  let itemName = row["itemName"] as? String,
                    let resume = row["resume"] as? String,
                    let totalProgress = row["totalProgress"] as? Int,
                    let color = row["color"] as? Int
            else { return nil }
            
            return Models.Item(id: id, itemName: itemName, resume: resume, totalProgress: totalProgress, color: color)
        }
    }
    
}

