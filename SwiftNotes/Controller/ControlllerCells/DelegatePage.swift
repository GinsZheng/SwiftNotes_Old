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
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)

        label.setup(superview: view, text: "这行文字将通过下个页面编辑")
        label.setFontStyle(size: 24, color: cBlue_5393FF)
        label.setFrame(left: 20, top: 20, width: kScreenWidth - 40, height: 60)

        button.setup(superview: view, target: self, action: #selector(editName))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "下一页")
        button.setFrame(left: 20, top: 84, width: kScreenWidth - 40, height: 44)
    }
    

    // MARK: - 代理方法
    
    // 2.遵循协议的函数，里面写了具体的类A要做的事
    func fetchName(name: String) {
        self.label.text = name
    }
    
    
    // MARK: - @objc func

    @objc func editName() {
        // 3.受托
        let nameEditorPage = CSNameEditorPage() // 类A，实例化委托人-类B
        nameEditorPage.delegate = self // 让类B实例.delegate = self，表示接受类B的委托
        self.push(targetVC: nameEditorPage)
        // Push的时候，toTarget参数后面跟的一定要是刚才实例化的nameEditorPage，
        // 而不是CSNameEditorPage(),是一个大坑
    }

}



// 委托人
class CSNameEditorPage: UIViewController, UITextFieldDelegate {

    var oldName: String?
    let nameTextField = UITextField()
    let button = UIButton()
    
    // 4.定义委托变量delegate
    weak var delegate: CSNameEditorDelegate?
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)

        nameTextField.setup(superview: view, placeholder: "请输入", delegate: self)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: 20, right: 20, height: 44)

        button.setup(superview: view, target: self, action: #selector(refreshSuperView))
        button.setStyleSolid17ptFgWhiteThemeButton(title: "返回")
        button.setFrame(left: 20, top: 84, right: 20, height: 44)

        if oldName != nil {
            nameTextField.text = oldName!
        }
    }
    
    
    // MARK: - @objc func

    @objc func refreshSuperView() {
        let name = nameTextField.text
        if name != "" {
            // 5.委托开始，委托的事为fetchName
            delegate?.fetchName(name: name!)
        }
        self.pop()
    }
    

}





/*
 几乎任何两个类之间都可以实现代理模式
 协议中，你可以放置以下内容:
    1. 属性 var someProperty: Int { get set }  需要提供这些属性，但不需要指定属性的具体实现
    2. 方法
    3. init
    4. 下标(暂不知场景)
    5. 关联类型： 协议可以定义关联类型。关联类型常用于定义与协议相关的泛型类型
 代理要素
 1. 一个协议
 2. 一个委托类 (传值/传递指令。传值是通过函数参数来传)
    1. 定义委托变量 var delegate: <协议名>?
    2. 在触发委托的时机，delegate调用协议方法，如：delegate?.fetchName(name: name!)
 3. 一个受托类 (执行动作/返回结果)
    1. 委托类继承协议，继承协议后会自己出现相应函数。在相应函数内写入需要实现的受托逻辑
    2. 在触发受托的时机，A 实例化委托类、B 委托类.delegate = self、(C 如有push，就push到刚刚实例化的类)
    
 
 设置代理步骤：以反向传值为例
 1.定义一个协议，以实现两个类的传值通信
 2.类A成为受托人，类B为委托人
 3.在接收值的类A，实例化传值的类B，让类B实例.delegate = self，实现类A的受托
 4.接收值的类A，遵循协议，这样可调用协议内的方法，实现值的获取、操作
 5.传值的类B，定义weak变量：delegate
 6.传值的类B，在某触发条件下，执行delegate的方法
 7.传值的类B，最后做内存管理和析构
 */

/* 什么时候要代理：
 要代理：写在viewDidLoad等中的present等页面，需要代理
 不要代理：写在viewWillAppear中的push页面
 不要代理：写在viewDidLoad之外的变量声明：直接实例化类，并赋值即可
 */



/*
 跨两级页面委托思路：
 假设页面A、B、C(B为弹窗)，A跳到B再跳到C，可如下处理：
 1. B页面先dismiss()，然后委托A页面跳到C页面
 2. 接下来就是A与C页面的常规委托，回避了跨两级页面
 具体代码可见项目SnailProgress的页面 HomwVC.swift / CSAddProgressPopupWindow.swift / AddProgress.swift
 */


