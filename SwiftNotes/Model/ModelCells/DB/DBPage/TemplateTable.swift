//import SQLite
//
//extension Models {
//    struct %Variable%model% {
//        var id: Int = 0
//        <#T##String#>
//    }
//}
//
//
//// MARK: - 表类
//class %Variable%model%Table: TableProtocol {
//    typealias ModelType = Models.%Variable%model%
//    var tableName: String { return DBTable.%Variable%table% }
//    
//    private let id = Expression<Int>("id")
//    <#T##String#>
//    
//    // MARK: - 初始化与通用协议方法
//    required init() {
//        DB.shared.createTable(self)
//    }
//    
//    // 定义字段
//    func defineTable(t: TableBuilder) {
//        t.column(id, primaryKey: .autoincrement)
//        <#T##String#>
//    }
//    
//    // 定义Setter
//    func modelToSetters(model: Models.%Variable%model%) -> [Setter] {
//        var setters: [Setter] = [
//            <#T##String#>
//        ]
//        // 如果 id 非默认值(编辑时)，则添加
//        if model.id != 0 { setters.append(id <- model.id) }
//        return setters
//    }
//    
//}
//
//
//// MARK: - 查询方法
//extension %Variable%model%Table {
//    // 查询所有行
//    func getAll() -> [Models.%Variable%model%] {
//        return DB.shared.query(table: self).compactMap { row in
//            Models.%Variable%model%(
//                id: row[id],
//                <#T##String#>
//            )
//        }
//    }
//
//    // 查询
//    // func getAllWithSQL() -> [Models.%Variable%model%] {
//    //     let sql = "SELECT * FROM \(tableName)"
//    //     return DB.shared.query(withSQL: sql) { row -> Models.%Variable%model%? in
//    //         guard let id = row["id"] as? Int,
//    //               <#T##String#>
//    //         else { return nil }
//    //
//    //         return Models.%Variable%model%
//    //     }
//    // }
//    
//}
