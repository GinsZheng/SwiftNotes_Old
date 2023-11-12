import UIKit

class ViewController: UIViewController {

    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
        let switchFormView = SwitchFormView()
        switchFormView.set(superview: view)
        switchFormView.setupCommonUI()
        switchFormView.setupUI()
    }
    
}


class SwitchFormView: UIView {
    
    var currentUIForm: UIForm = .form0
    
    func setupCommonUI() {
        self.setBackgroundColor(color: cF2F3F6)
    }
    
    func setupUI() {
        switch currentUIForm {
        case .form0:
            setupForm0()
        case .form1:
            setupForm1()
        }
    }
    
    func setupForm0() {
        self.removeAllSubviews()
        self.setFrame(left: 20, top: 20, right: 20, height: 48)

        let bgView = UIView()
        bgView.set(superview: self, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setCornerRadius(radius: 10)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: bgView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: 12, centerY: bgView.height / 2, width: 28, height: 28)
        
    }
    
    func setupForm1() {
        self.removeAllSubviews()
        self.setFrame(left: 20, top: 20, right: 20, height: 200)
        
        let bgView = UIView()
        bgView.set(superview: self, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setCornerRadius(radius: 10)

        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: bgView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_unfold")
        switchButton.setFrame(right: 12, bottom: 12, width: 28, height: 28)
    }
    
    
    // MARK: - 代理方法
    
    
    // MARK: - @objc func
    
    @objc func switchView() {
        currentUIForm = currentUIForm == .form0 ? .form1 : .form0
        setupUI()
    }
    
}



