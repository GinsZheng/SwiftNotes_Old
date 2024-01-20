// 通用的DBManager

import Foundation
import SQLite

// 所有表的类(如ProjectTable)都遵循此协议，以实现使用超类"DB"中的函数来增删改查表
protocol TableProtocol {
    associatedtype ModelType
    var tableName: String { get }
    func defineTable(t: TableBuilder) -> Void
    func modelToSetters(model: ModelType) -> [Setter]
    func rowToModel(_ row: Row) -> ModelType? // 可选，功能是将数据库中的一行（Row）转换为具体的模型，主要用于查询所有数据
    
    init() // 定义了子类一定有构造函数，一定可实例化
}

extension TableProtocol {
    func rowToModel(_ row: Row) -> ModelType? {
        // 默认实现可以返回 nil 或抛出错误
        return nil
    }
}


class DB {
    static let shared = DB()
    var database: Connection? { // 子类可以通过database访问只读的db
        return db
    }
    
    private var db: Connection? // 将db设为private，以只db只能在DB 类内部被访问和修改 🐾1
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/db.sqlite3")
        } catch {
            print("Unable to initialize database: \(error)")
        }
    }
    
    // 创建表
    func createTable<T: TableProtocol>(_ table: T) {
        guard let db = getDatabaseConnection() else { return }
        // 检查表是否已经存在
        let tableExists = (try? db.scalar("SELECT EXISTS(SELECT name FROM sqlite_master WHERE type='table' AND name='\(table.tableName)')") as? Int64) ?? 0
        
        // 如果表不存在，则创建表
        if tableExists == 0 {
            do {
                try db.run(Table(table.tableName).create(ifNotExists: true) { t in
                    table.defineTable(t: t)
                })
                print("表 \(table.tableName) 创建成功")
            } catch {
                print("创建表 \(table.tableName) 失败: \(error)")
            }
        }
    }
    
    // 新增
    func insert<T: TableProtocol>(table: T, model: T.ModelType) {
        guard let db = getDatabaseConnection() else { return }
        let insert = Table(table.tableName).insert(table.modelToSetters(model: model))
        do {
            let id = try db.run(insert)
            print("插入成功, id：\(id)")
        } catch {
            print("插入失败: \(error)")
        }
    }
    
    // 删除
    func delete<T: TableProtocol>(table: T, id: Int) {
        guard let db = getDatabaseConnection() else { return }
        let delete = Table(table.tableName).filter(Expression<Int>("id") == id).delete()
        do {
            if try db.run(delete) > 0 {
                print("删除成功, id: \(id)")
            } else {
                print("未找到id为 \(id) 的数据")
            }
        } catch {
            print("删除失败: \(error)")
        }
    }
    
    // 更新
    func update<T: TableProtocol>(table: T, id: Int, model: T.ModelType) {
        guard let db = getDatabaseConnection() else { return }
        let update = Table(table.tableName).filter(Expression<Int>("id") == id).update(table.modelToSetters(model: model))
        do {
            if try db.run(update) > 0 {
                print("更新成功, id: \(id)")
            } else {
                print("未找到id为 \(id) 的数据")
            }
        } catch {
            print("更新失败: \(error)")
        }
    }
    
    // 获取最新数据的id
    func getLastId(tableName: String) -> Int {
        guard let db = getDatabaseConnection() else { return 0 }
        let queryStatement = "SELECT MAX(id) FROM \(tableName)"
        do {
            for row in try db.prepare(queryStatement) {
                if let lastId = row[0] as? Int64 {
                    return Int(lastId)
                }
            }
        } catch {
            print("查询最新数据ID失败: \(error)")
        }
        return 0
    }
    
    // 添加字段
    func addColumn(to tableName: String, columnName: String, dataType: String) {
        guard let db = getDatabaseConnection() else { return }
        let alterTableStatement = "ALTER TABLE \(tableName) ADD COLUMN \(columnName) \(dataType)"
        do {
            try db.run(alterTableStatement)
            print("已成功添加字段: \(columnName)")
        } catch {
            print("添加字段失败: \(error)")
        }
    }
    
    // 检查字段是否存在
    func isColumnExists(in tableName: String, columnName: String) -> Bool {
        guard let db = getDatabaseConnection() else { return false }
        do {
            let pragmaStatement = "PRAGMA table_info(\(tableName))"
            for row in try db.prepare(pragmaStatement) {
                if row[1] as? String == columnName {
                    return true
                }
            }
        } catch {
            print("检查字段存在失败: \(error)")
        }
        return false
    }
    
    // 删除一张表 (谨慎使用)
    func deleteTable(tableName: String) {
        guard let db = getDatabaseConnection() else { return }
        let dropTableStatement = "DROP TABLE IF EXISTS \(tableName)"
        do {
            try db.run(dropTableStatement)
            print("已成功删除表: \(tableName)")
        } catch {
            print("删除表失败: \(error)")
        }
    }
    
}


// MARK: - 查询
extension DB {
    // 使用Table查询所有内容(Select *)
    func query<T: TableProtocol>(table: T) -> [Row] {
        // 参数 table： 一般填self，因为一般是表类调用些函数
        guard let db = getDatabaseConnection() else { return [] }
        do {
            return Array(try db.prepare(Table(table.tableName)))
        } catch {
            print("查询失败: \(error)")
            return []
        }
    }
    
    // 使用SQL查询，并输出字典
    func query(withSQL sql: String) -> [[String: Any]] {
        guard let db = getDatabaseConnection() else { return [] }
        var result: [[String: Any]] = []
        
        do {
            let statement = try db.prepare(sql)
            let columnNames = Array(statement.columnNames)
            for row in statement {
                var rowData: [String: Any] = [:]
                for (index, columnName) in columnNames.enumerated() {
                    let value = row[index]
                    // 如果是 Int64 类型，转换为 Int
                    if let intValue = value as? Int64 {
                        rowData[columnName] = Int(intValue)
                    } else {
                        rowData[columnName] = value
                    }
                }
                result.append(rowData)
            }
        } catch {
            print("执行查询失败: \(error)")
        }
        
        return result
    }
    
    // 使用SQL查询，并输出模型
    

}


// MARK: - 常用查询实例
extension DB {
    // 查询所有 (Select *)
    func getAll<T: TableProtocol>(of type: T.Type) -> [T.ModelType] where T.ModelType: Any {
        guard let db = getDatabaseConnection() else { return [] }
        var models: [T.ModelType] = []
        let table = T() // 创建 T 的实例
        do {
            for row in try db.prepare(Table(table.tableName)) {
                if let model = table.rowToModel(row) {
                    models.append(model)
                }
            }
        } catch {
            print("查询失败: \(error)")
        }
        return models
    }
}


// MARK: - 私有方法
extension DB {
    // 获取数据库连接
    private func getDatabaseConnection() -> Connection? {
        guard let db = db else {
            print("连接数据库失败")
            return nil
        }
        return db
    }
}




/*
 🐾1：为什么不直接将 db 声明为 internal（默认访问级别）而是使用私有属性和公开计算属性，原因在于封装和数据隐藏：
 1. 封装：通过使 db 私有，您确保了 DB 类的所有数据库操作都通过类的方法来执行。这意味着您可以在这些方法中添加额外的逻辑，如错误处理、日志记录等，而不必担心外部代码会绕过这些逻辑直接操作数据库。
 2. 数据隐藏：通过提供一个只读的计算属性 database，您允许外部代码读取数据库连接，但不能修改它。这可以防止外部代码意外地改变数据库的状态，可能导致数据损坏或不一致。
 总结：这种设计模式提高了代码的安全性和健壮性
 */
