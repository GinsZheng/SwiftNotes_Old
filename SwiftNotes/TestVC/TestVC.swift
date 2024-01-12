import UIKit

class ViewController: UIViewController {
    
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        
        let myView = DefaultViewOfCell()
        myView.setup(superview: view)
        myView.prepare(row: 0, cellCountInSection: 1)
        myView.configure(cellType: .title, title: "hey")
    }
    
    // MARK: - @objc func
    
    
}


