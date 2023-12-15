import UIKit

class ViewController: UIViewController {
    
    let dimmedBackgroundView = UIView()
    let foregroundView = UIView()
    let textField = UITextField()
    let overlayButton = UIButton()
    var foregroundViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupNotifications()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        // 配置触发按钮
        overlayButton.setTitle("显示叠加层", for: .normal)
        overlayButton.backgroundColor = .blue
        view.addSubview(overlayButton)
        
        // 配置前景视图
        foregroundView.backgroundColor = .white
        view.addSubview(foregroundView)
        
        // 配置输入框
        textField.borderStyle = .roundedRect
        foregroundView.addSubview(textField)
        
        // 配置背景遮罩视图
        dimmedBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmedBackgroundView.alpha = 0
        view.addSubview(dimmedBackgroundView)
    }
    
    func setupConstraints() {
        overlayButton.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        foregroundView.translatesAutoresizingMaskIntoConstraints = false
        dimmedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        // 触发按钮的约束
        overlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        overlayButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        overlayButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        overlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // 前景视图的约束
        foregroundViewBottomConstraint = foregroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            foregroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            foregroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            foregroundViewBottomConstraint!,
            foregroundView.heightAnchor.constraint(equalToConstant: 300) // 假设前景层的高度是300
        ])
        
        // 输入框的约束
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: foregroundView.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: foregroundView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: foregroundView.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // 背景遮罩视图的约束
        NSLayoutConstraint.activate([
            dimmedBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func showOverlayView() {
        dimmedBackgroundView.alpha = 0
        foregroundView.alpha = 0
        foregroundViewBottomConstraint?.constant = 0
        
        // 按钮点击事件
        overlayButton.addTarget(self, action: #selector(toggleOverlay), for: .touchUpInside)
        
        UIView.animate(withDuration: 0.3) {
            self.dimmedBackgroundView.alpha = 1
            self.foregroundView.alpha = 1
        }
        
        textField.becomeFirstResponder()
    }
    
    @objc func toggleOverlay() {
        textField.becomeFirstResponder()
        showOverlayView()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            foregroundViewBottomConstraint?.constant = -keyboardHeight
            
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        foregroundViewBottomConstraint?.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.dimmedBackgroundView.alpha = 0
            self.foregroundView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
