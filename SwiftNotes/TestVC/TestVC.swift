import UIKit

class ViewController: UIViewController {
    
    private var customTaskListView: CustomTaskListView!
    
    // MARK: - 生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        customTaskListView = CustomTaskListView(frame: .zero, viewController: self)
        // 可以设置 customTaskListView 的其他属性或者约束
        customTaskListView.setup(superview: view, backgroundColor: cRed_FF635A)
        customTaskListView.setupUI()
    }
    
    // MARK: - @objc func
    
    
}


