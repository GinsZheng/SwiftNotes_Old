import UIKit

class ViewController: UIViewController {
    let groupTable = GroupTable()
    
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

//        let data = CSFileManager.readCSVFile(csvFileName: "group")
//        print("csv文件", data ?? [:])
        
        
        CSFileManager.importCSVToSQLite(csvFileName: "group", tableName: "group")
        
        
        guard let data = CSFileManager.readCSVFile(csvFileName: "group") else { return }
//        let table
        
//        do {
//            let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//            let db = try Connection(dbPath)
//            let table = Table(tableName)
//
//            for row in data {
//                var setters: [Setter] = []
//                for (columnName, value) in row {
//                    setters.append(Expression<String>(columnName) <- value)
//                }
//                try db.run(table.insert(or: .replace, setters))
//            }
//        } catch {
//            print("导入数据到 \(tableName) 失败: \(error)")
//        }
        
    }
    
}

