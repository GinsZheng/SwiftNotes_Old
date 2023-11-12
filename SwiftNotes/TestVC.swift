import UIKit

class ViewController: UIViewController {

    var currentUIForm: UIForm = .form0
    
    // MARK: - 生命周期方法
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - func
    
    func setupUI() {
        view.setBackgroundColor(color: cF2F3F6)
        
        setupCommonUI()
        setupFormViewUI()
    }
    
    
    func setupCommonUI() {
        view.setBackgroundColor(color: cF2F3F6)
    }
    
    func setupFormViewUI() {
        switch currentUIForm {
        case .form0:
            setupForm0()
        case .form1:
            setupForm1()
        }
    }
    
    func setupForm0() {
        view.removeAllSubviews()
        
        let contentView = UIView()
        contentView.set(superview: view)
        contentView.setFrame(left: 20, top: 20, right: 20, height: 48)

        let bgView = UIView()
        bgView.set(superview: contentView, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setCornerRadius(radius: 10)
        
        let switchButton = UIButton(type: .custom)
        switchButton.set(superview: bgView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: 12, centerY: bgView.height / 2, width: 28, height: 28)
        
    }
    
    func setupForm1() {
        view.removeAllSubviews()
        
        let contentView = UIView()
        contentView.set(superview: view)
        contentView.setFrame(left: 20, top: 20, right: 20, height: 200)
        
        let bgView = UIView()
        bgView.set(superview: contentView, backgroundColor: cFFF)
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


class SwitchFormView: UIView {
    
    var currentUIForm: UIForm = .form0
    
}
