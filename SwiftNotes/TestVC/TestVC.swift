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

//        let updateButton = UIButton(type: .custom)
//        updateButton.setup(superview: view, target: self, action: #selector(handleUpdate))
//        updateButton.setStyleSolid14pt666GrayButton(title: <#T##String#>)
//        updateButton.setFrame(left: 0, top: 0, right: 0, height: 33)
//        
//        @objc func handleUpdate() {
//            
//        }
        
    }
    
}
