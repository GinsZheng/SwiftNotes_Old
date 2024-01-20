import UIKit

class ViewController: UIViewController {
    var itemTable = ItemTable()
    
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
        
        let addButton = UIButton(type: .custom)
        addButton.setup(superview: view)
        addButton.setStyleSolid17ptFgWhiteThemeButton(title: "新增")
        addButton.setFrame(left: 0, top: 0, right: 0, height: 44)
        addButton.setEvent {
            let newData = Models.Item(itemName: "名称1", resume: "好", totalProgress: 100, color: 0)
            DB.shared.insert(table: self.itemTable, model: newData)
        }
        
        let queryButton = UIButton(type: .custom)
        queryButton.setup(superview: view)
        queryButton.setStyleSolid17ptThemeWhiteButton(title: "查询")
        queryButton.setFrame(left: 0, top: 55, right: 0, height: 44)
        queryButton.setEvent {
            let data = self.itemTable.getAll()
            for da in data {
                print("id:", da.id, "itemName:", da.itemName, "progress:", da.totalProgress, "color:", da.color)
            }
        }
        
    }
    
}

