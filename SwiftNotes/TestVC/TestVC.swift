import UIKit
import SwiftCSV
import SQLite

class ViewController: UIViewController {
    let taskGroupTable = TaskGroupTable()
    
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

        CSFileManager.importCSVToSQLite(csvFileName: "taskGroup", tableName: "taskGroup")

        let data = taskGroupTable.fetchAllData()
        for row in data {
            print("row", row)
        }
    }
    
}
