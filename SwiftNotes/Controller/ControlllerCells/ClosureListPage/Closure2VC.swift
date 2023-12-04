//
//  Closure2VC.swift
//  SwiftNotes
//
//  Created by GinsMac on 2023/11/30.
//  Copyright © 2023 GinsMac. All rights reserved.
//

import UIKit

// 主页面(相当于受托人)
class Closure2VC: UIViewController {

    let label = UILabel()
    let button = UIButton()

    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white

        label.set(superview: view, text: "这行文字将通过下个页面编辑")
        label.setFontStyle(size: 24, color: cBlue_5393FF)
        label.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 60)

        button.set(superview: view, target: self, action: #selector(editName))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "下一页")
        button.setFrame(left: 20, top: 84, width: kScreenWidth - 40, height: 44)
    }
    
    
    // MARK: - @objc func
    
    @objc func editName() {
        let nameEditorPage = Closure2SubVC()
        // 1.设置闭包 (闭包内写明拿到传递的值后要做的事)
        nameEditorPage.nameClosure = { [weak self] name in // 使用[weak self]来避免潜在的强引用循环
            self?.label.text = name
        }
        self.push(toTarget: nameEditorPage)
    }
}


// 编辑页面(相当于委托人)
class Closure2SubVC: UIViewController, UITextFieldDelegate {

    var oldName: String?
    let nameTextField = UITextField()
    let button = UIButton()
    
    // 2. 定义闭包属性
    var nameClosure: ((String) -> Void)?

    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    
    func setupUI() {
        view.backgroundColor = UIColor.white

        nameTextField.set(superview: view, placeholder: "请输入", delegate: self)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: 20, right: 20, height: 44)

        button.set(superview: view, target: self, action: #selector(refreshSuperView))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "返回")
        button.setFrame(left: 20, top: 84, right: 20, height: 44)

        if oldName != nil {
            nameTextField.text = oldName!
        }
    }

    @objc func refreshSuperView() {
        let name = nameTextField.text
        if name != "" {
            // 3. 调用闭包
            nameClosure?(name!) // 这里的格式类似于函数
        }
        self.pop()
    }
}
