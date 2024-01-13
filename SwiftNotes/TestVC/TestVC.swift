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
        
//        let titleView = DefaultViewOfCell()
//        titleView.setup(superview: view)
//        titleView.prepare(row: 0, cellCountInSection: 1)
//        titleView.configure(cellType: .title, title: "时间")
//
        let titleVCView = DefaultViewOfCell()
        titleVCView.setup(superview: view)
        titleVCView.setFrame(left: 0, top: 100, right: 0, height: kCellHeight)
        titleVCView.prepare(row: 0, cellCountInSection: 1)
        titleVCView.configure(cellType: .titleRightIcon, title: "提醒")
    }
    
    // MARK: - @objc func
    
    
}


