//临时，用于创建任务时的界面设置

//import Foundation
//import UIKit
//
//class ViewController: UIViewController {
//    
//    let dimmedBackgroundView = UIView()
//    let customView = UIView() // 这将是你的自定义视图
//    let textField = UITextField() // 输入框
//    let overlayButton = UIButton() // 这是触发叠加视图的按钮
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // 配置按钮
//        overlayButton.setTitle("显示叠加层", for: .normal)
//        overlayButton.backgroundColor = .blue
//        overlayButton.frame = CGRect(x: 50, y: 100, width: 200, height: 50) // 这里设置按钮的位置和大小
//        overlayButton.addTarget(self, action: #selector(showOverlayView), for: .touchUpInside)
//        self.view.addSubview(overlayButton)
//        
//        // 配置背景视图
//        dimmedBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
//        dimmedBackgroundView.frame = self.view.bounds
//        dimmedBackgroundView.alpha = 0
//        // 不直接将背景视图添加到self.view中，将在showOverlayView中添加
//    }
//    
//    @objc func showOverlayView() {
//        self.view.addSubview(dimmedBackgroundView)
//        self.view.addSubview(customView)
//        
//        // 配置自定义视图的其他UI组件
//        customview.setBackgroundColor(color: cFFF)
//        customView.frame = CGRect(x: 20, y: 200, width: self.view.frame.width - 40, height: 300) // 设置自定义视图的位置和大小
//        customView.layer.cornerRadius = 10
//        
//        // 添加输入框
//        textField.frame = CGRect(x: 10, y: 10, width: customView.frame.width - 20, height: 40)
//        textField.borderStyle = .roundedRect
//        customView.addSubview(textField)
//        
//        // 渐显背景视图和自定义视图
//        UIView.animate(withDuration: 0.3) {
//            self.dimmedBackgroundView.alpha = 1
//            self.customView.alpha = 1
//        }
//        
//        // 自动激活输入框
//        textField.becomeFirstResponder()
//    }
//    
//    // ... 其他代码，包括键盘的通知监听方法
//}
