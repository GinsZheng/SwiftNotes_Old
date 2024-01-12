//
//  SwitchView1Page.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/10/20.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

class SwitchView1Page: UIViewController {

    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cBgGray)
        
        let formView = FormView()
        formView.setup(superview: view)
        formView.setupCommonUI()
        formView.setupUI()
    }
    
}


class FormView: UIView {
    
    var currentUIForm: UIForm = .form0
    
    func setupCommonUI() {
        self.setBackgroundColor(color: cBgGray)
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
        bgView.setup(superview: self, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setCornerRadius(radius: 10)
        
        let switchButton = UIButton(type: .custom)
        switchButton.setup(superview: bgView, target: self, action: #selector(switchView))
        switchButton.setStyleIconButton(imageName: "groupBar_fold")
        switchButton.setFrame(right: 12, centerY: bgView.height / 2, width: 28, height: 28)
        
    }
    
    func setupForm1() {
        self.removeAllSubviews()
        self.setFrame(left: 20, top: 20, right: 20, height: 200)
        
        let bgView = UIView()
        bgView.setup(superview: self, backgroundColor: cFFF)
        bgView.setFrame(allEdges: 0)
        bgView.setCornerRadius(radius: 10)

        let switchButton = UIButton(type: .custom)
        switchButton.setup(superview: bgView, target: self, action: #selector(switchView))
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
