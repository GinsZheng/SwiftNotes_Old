//
//  DelegatePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/8/22.
//  Copyright © 2019 GinsMac. All rights reserved.
//

import UIKit

class DelegatePage: UIViewController, NameEditorDelegate {

    let label = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        label.set(superview: view, text: "这行文字将通过下个页面编辑")
        label.setFontStyle(color: c2C9EFF, size: 24)
        label.makeConstraints(left: 20, top: 100, width: kScreenWidth - 40, height: 60)

        button.set(superview: view)
        button.makeConstraints(left: 20, top: 164, width: kScreenWidth - 40, height: 44)
        button.backgroundColor = UIColor.hex(cF5F6F8)
        button.setCornerRadius(radius: 4)
        button.setTitle("下一页", for: .normal)
        button.setTitleColor(UIColor.hex(c222), for: .normal)
        button.addTarget(self, action: #selector(editName), for: .touchUpInside)

    }

    @objc func editName() {
        let nameEditorPage = NameEditorPage()
        nameEditorPage.delegate = self
        self.pushFromSecondaryPage(toTarget: nameEditorPage)
    }

    func fetchName(name: String) {
        self.label.text = name
    }

}



class NameEditorPage: UIViewController {

    var oldName: String?
    weak var delegate: NameEditorDelegate?
    let nameTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        nameTextField.set(superview: view, placeholder: "请输入")
        nameTextField.makeConstraints(left: 20, top: 100, right: 20, height: 44)
        nameTextField.setBackgroundColor(color: cF5F6F8)
        nameTextField.setCornerRadius(radius: 4)
        nameTextField.text = ""

        if oldName != nil {
            nameTextField.text = oldName!
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        let name = nameTextField.text
        if name != "" {
            if delegate != nil {
                delegate!.fetchName(name: name!)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        print("释放")
    }

}



protocol NameEditorDelegate: NSObjectProtocol {
    func fetchName(name: String)
}


// 设置代理步骤：以反向传值为例
// 定义一个协议，以实现两个类的传值通信
// 接收值的类A，实例化传值的类B，让类B实例.delegate = self，即类A成为受托人
// 接收值的类A，遵循协议，这样可调用协议内的方法，实现值的获取、操作
// 传值的类B，定义weak变量：delegate，遵循协议，以调用协议内的方法
// 传值的类B，在某触发条件下，执行delegate的方法
// 传值的类B，最后做内存管理和析构
