import UIKit

class ViewController: UIViewController {
    
    
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
        
        let titleVCView = DefaultViewOfCell(cornerType: .allCorners)
        titleVCView.setup(superview: view)
        titleVCView.setFrame(left: 0, top: 100, right: 0, height: k2LineCellHeight)
        titleVCView.configure(cellType: .titleMiddleIconRightIcon, title: "提醒", description: "kwkw", middleIconName: "mine_aboutAs")
        titleVCView.onTap = {
            self.push(targetVC: CSGeneralSubpage())
        }
        
        
    }
    
}
