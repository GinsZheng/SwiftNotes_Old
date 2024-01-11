import UIKit

class ViewController: UIViewController {
    
    private var groupListView: GroupListView!
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        groupListView = GroupListView(frame: .zero, viewController: self, showTrashButton: true)
        // 可以设置 groupListView 的其他属性或者约束
        groupListView.setup(superview: view)
        groupListView.setupUI()
    }
    
    // MARK: - @objc func
    
}


