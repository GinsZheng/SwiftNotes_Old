import UIKit

enum UIForm {
    case form0
    case form1
}


class ViewController: UIViewController {
    
    var currentUIForm = UIForm.form0

    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCommonUI()
        setupForm0()
    }
    
    
    // MARK: - func
    
    func setupCommonUI() {
        view.setBackgroundColor(color: cF2F3F6)
    }
    
    func setupForm0() {
        view.removeAllSubviews()
        
        let bgView = UIView()
        bgView.set(superview: view, backgroundColor: cFFF)
        bgView.setFrame(left: 20, top: 20, right: 20, height: 48)
        bgView.setCornerRadius(radius: 10)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: bgView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: 12, centerY: bgView.height / 2, width: 28, height: 28)
        
    }
    
    func setupForm1() {
        view.removeAllSubviews()
        
        let bgView = UIView()
        bgView.set(superview: view, backgroundColor: cFFF)
        bgView.setFrame(left: 20, top: 20, right: 20, height: 200)
        bgView.setCornerRadius(radius: 10)

        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: bgView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
        switchButton.setFrame(right: 12, bottom: 12, width: 28, height: 28)
    }
    
    func setupUI() {
        switch currentUIForm {
        case .form0:
            setupForm0()
        case .form1:
            setupForm1()
        }
    }
    
    
    // MARK: - 代理方法
    
    
    // MARK: - @objc func
    
    @objc func switchView() {
        currentUIForm = currentUIForm == .form0 ? .form1 : .form0
        setupUI()
    }
    
}


