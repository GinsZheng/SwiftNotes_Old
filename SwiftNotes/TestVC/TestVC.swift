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
        
        let item = Models.Item(id: 1, itemName: "Example", resume: "This is a resume", totalProgress: 100, color: 0xFFFFFF)
        item.printProperties()
        
    }
    
}

extension Models.Item {
    func printProperties() {
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            guard let propertyName = child.label else { continue }
            print("\(propertyName): \(child.value)")
        }
    }
}
