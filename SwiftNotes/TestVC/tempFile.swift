// 新 SQLiteManager

import Foundation
import SQLite

class SQLiteManager {
    static let shared = SQLiteManager()
    
    var database: Connection? { // 子类可以通过database访问只读的db
        return db
    }
    
    private var db: Connection? // 将db设为private，以只db只能在SQLiteManager 类内部被访问和修改 🐾1
    
    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            db = try Connection("\(path)/db.sqlite3")
        } catch {
            print("Unable to initialize database: \(error)")
        }
    }
    
    func insert(table: Table, values: [Setter]) {
        guard let db = getDatabaseConnection() else { return }
        do {
            let insert = table.insert(values)
            let id = try db.run(insert)
            print("插入成功, id：\(id)")
        } catch {
            print("插入失败: \(error)")
        }
    }
    
    func delete(table: Table, id: Int) {
        guard let db = getDatabaseConnection() else { return }
        do {
            let row = table.filter(Expression<Int>("id") == id)
            let delete = row.delete()
            if try db.run(delete) > 0 {
                print("删除成功, id: \(id)")
            } else {
                print("未找到id为 \(id) 的数据")
            }
        } catch {
            print("删除失败: \(error)")
        }
    }
    
    func update(table: Table, id: Int, values: [Setter]) {
        guard let db = getDatabaseConnection() else { return }
        do {
            let row = table.filter(Expression<Int>("id") == id)
            let update = row.update(values)
            if try db.run(update) > 0 {
                print("更新成功, id: \(id)")
            } else {
                print("未找到id为 \(id) 的数据")
            }
        } catch {
            print("更新失败: \(error)")
        }
    }
    
    func query(table: Table) -> [Row] {
        guard let db = getDatabaseConnection() else { return [] }
        do {
            return Array(try db.prepare(table))
        } catch {
            print("查询失败: \(error)")
            return []
        }
    }
    
    // 获取最新数据的id
    func getLastInsertedId(tableName: String) -> Int {
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


// MARK: - 私有方法
extension SQLiteManager {
    private func getDatabaseConnection() -> Connection? {
        guard let db = db else {
            print("连接数据库失败")
            return nil
        }
        return db
    }
}


/*
 为什么不直接将 db 声明为 internal（默认访问级别）而是使用私有属性和公开计算属性，原因在于封装和数据隐藏：
 1. 封装：通过使 db 私有，您确保了 SQLiteManager 类的所有数据库操作都通过类的方法来执行。这意味着您可以在这些方法中添加额外的逻辑，如错误处理、日志记录等，而不必担心外部代码会绕过这些逻辑直接操作数据库。
 2. 数据隐藏：通过提供一个只读的计算属性 database，您允许外部代码读取数据库连接，但不能修改它。这可以防止外部代码意外地改变数据库的状态，可能导致数据损坏或不一致。
 总结：这种设计模式提高了代码的安全性和健壮性
 */
