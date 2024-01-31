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

//        CSFileManager.importCSVToSQLite(csvFileName: "taskGroup", tableName: "taskGroup")

//        let data = taskGroupTable.fetchAllData()
//        for row in data {
//            print("row", row)
//        }
        
//        let myImageView = UIImageView()
//        myImageView.setup(superview: view, imageName: "iPhone7")
////        myImageView.setFrame<#T##String#>
//        let height = myImageView.getScaledHeight(forWidth: 100)
//        print("iphone7", height)
//
//        let str = "1,3,4,6"
//        let parsedArray = str.split(separator: ",").compactMap { Int($0) }
//        print(parsedArray)
//        

    }
    
}
