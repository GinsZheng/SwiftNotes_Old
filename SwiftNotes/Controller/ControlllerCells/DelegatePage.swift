//
//  CSDelegatePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2019/8/22.
//  Copyright © 2019 GinsMac. All rights reserved.
//


import UIKit

// 0.协议
protocol CSNameEditorDelegate: NSObjectProtocol {
    func fetchName(name: String)
}

// 受托人
// 1.继承协议类A
class CSDelegatePage: UIViewController, CSNameEditorDelegate {

    let label = UILabel()
    let button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        label.set(superview: view, text: "这行文字将通过下个页面编辑")
        label.setFontStyle(size: 24, color: cBlue_2C9EFF)
        label.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 60)

        // 2.受托的触发条件
        button.set(superview: view, target: self, action: #selector(editName))
        button.setStyleSolidBtn(title: "下一页")
        button.setFrame(left: 20, top: 84, width: kScreenWidth - 40, height: 44)
        
    }

    // 受托
    @objc func editName() {
        let nameEditorPage = CSNameEditorPage() // 3.类A，实例化委托人-类B
        nameEditorPage.delegate = self // 4.让类B实例.delegate = self，表示接受类B的委托
        self.pushFromSecondaryPage(toTarget: nameEditorPage) // 5.Push的时候，
        // toTarget参数后面跟的一定要是刚才实例化的nameEditorPage，
        // 而不是CSNameEditorPage(),是一个大坑
    }
    // 6.遵循协议的函数，里面写了具体的类A要做的事
    func fetchName(name: String) {
        self.label.text = name
    }

}


// 委托人
class CSNameEditorPage: UIViewController, UITextFieldDelegate {

    var oldName: String?
    let nameTextField = UITextField()
    let button = UIButton()
    // 7.定义委托变量delegate
    weak var delegate: CSNameEditorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white

        nameTextField.set(superview: view, placeholder: "请输入", delegate: self)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: 20, right: 20, height: 44)

        // 8.委托的触发条件
        button.set(superview: view, target: self, action: #selector(refreshSuperView))
        button.setStyleSolidBtn(title: "返回")
        button.setFrame(left: 20, top: 84, right: 20, height: 44)

        if oldName != nil {
            nameTextField.text = oldName!
        }
    }
    
    @objc func refreshSuperView() {
        let name = nameTextField.text
        if name != "" {
            // 9.委托开始，委托的事为fetchName
            if delegate != nil {
                delegate!.fetchName(name: name!)
            }
        }
        self.pop()
    }
    
    // 本函数与 refreshSuperView 做一样的事，二者选一个即可
    override func viewWillDisappear(_ animated: Bool) {
        let name = nameTextField.text
        if name != "" {
            if delegate != nil {
                delegate!.fetchName(name: name!)
            }
        }
    }

    // 10.内存管理
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // 11.析构
    deinit {
        print("释放")
    }

}





// 设置代理步骤：以反向传值为例
// 定义一个协议，以实现两个类的传值通信
// 类A成为受托人，类B为委托人
// 在接收值的类A，实例化传值的类B，让类B实例.delegate = self，实现类A的受托
// 接收值的类A，遵循协议，这样可调用协议内的方法，实现值的获取、操作
// 传值的类B，定义weak变量：delegate
// 传值的类B，在某触发条件下，执行delegate的方法
// 传值的类B，最后做内存管理和析构
