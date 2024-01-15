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
        
        let myView = UIView()
        myView.setup(superview: view, backgroundColor: cRed_FF635A)
        myView.setFrame(left: 30, top: 200, right: 30, bottom: 300)
        
        let titleVCView = DefaultViewOfCell(cornerType: .allCorners)
        titleVCView.setup(superview: myView)
        titleVCView.setFrame(left: 0, top: 100, right: 0, height: k2LineCellHeight)
        titleVCView.configure(cellType: .titleMiddleIconRightIcon, title: "提醒", description: "kwkw", middleIconName: "mine_aboutAs")
        titleVCView.onTap = {
            let customActionSheetVC = CustomActionSheetViewController(viewFrameInWindow: titleVCView.getFrameInWindow())
            self.present(customActionSheetVC, animated: true, completion: nil)
        }
        
    }
    
}


class CustomActionSheetViewController: UIViewController {
    var viewFrameInWindow: CGRect
    
    // MARK: - 初始化与生命周期方法
    init(viewFrameInWindow: CGRect) {
        self.viewFrameInWindow = viewFrameInWindow
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 创建菜单视图
        let menuView = UIView()
        menuView.backgroundColor = .white
        menuView.layer.cornerRadius = 12
        menuView.layer.masksToBounds = true
        
        // 假设我们在屏幕底部有一个固定高度的菜单
        let menuHeight: CGFloat = 250
        let screenWidth = UIScreen.main.bounds.width
        menuView.frame = CGRect(x: 0, y: view.bounds.height - menuHeight, width: screenWidth, height: menuHeight)
        view.addSubview(menuView)
        
        // 添加一个按钮
        let button = UIButton(type: .system)
        button.setTitle("选项1", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        // 假设按钮在菜单视图中居中显示
        button.frame = CGRect(x: 20, y: (menuHeight - 44) / 2, width: screenWidth - 40, height: 44)
        menuView.addSubview(button)
        
        // 添加点击关闭视图的手势
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func buttonTapped() {
        // 处理按钮点击事件
        print("按钮被点击")
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissSelf() {
        // 点击背景关闭菜单
        dismiss(animated: true, completion: nil)
    }
}
