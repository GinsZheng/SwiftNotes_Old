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

        let titleVCView = DefaultViewOfCell(cornerType: .allCorners)
        titleVCView.setup(superview: view)
        titleVCView.setFrame(left: 0, top: 100, right: 0, height: kCellHeight)
        titleVCView.configure(cellType: .titleRightIcon, title: "提醒")
        titleVCView.onTap = {
            self.push(targetVC: CSGeneralSubpage())
        }
    }
    
    
}


