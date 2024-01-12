//
//  CSReloadDataPage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/2/17.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SQLite
import SwiftyJSON

// 写个委托，完成子VC切到父VC时的通信
// 如果不是 dismiss() 过场，直接在父VC用viewWillAppear()等即可刷新，不用委托
// 0.协议
protocol CSReloadDelegate: NSObjectProtocol {
    func reloadData()
}


// 1.委托类：继承协议类
class CSReloadDataPage: UIViewController, UITableViewDelegate, UITableViewDataSource, CSReloadDelegate {
    
    var nameArray = [String]()
    
    let table = ReloadDataTable()
    
    let addItemBtn = UIButton(type: .custom)
    let tableView = UITableView()
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json = table.getJSON()
        let model = ReloadDateModel.init(jsonData: json)
        nameArray = model.itemName
        
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        addItemBtn.setup(superview: view, target: self, action: #selector(presentAddItemVC))
        addItemBtn.setFrame(right: 20, top: 0, width: 25, height: 20)
        addItemBtn.setImage(UIImage(named: "progress_addItem"), for: .normal)
        
        tableView.setup(superview: view, delegate: self, dataSource: self, viewController: self)
        tableView.setFrame(left: 0, top: 20, right: 0, height: kWithoutNavAndTabBarHeight - 40)
    }
    
    
    // MARK: - tableView代理方法
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "itemList")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: 0)
        cell.textLabel?.text = nameArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    // 2.遵循协议的函数
    func reloadData() {
        //MARK:- 关键1：重新赋值数组
        let json = table.getJSON()
        let model = ReloadDateModel.init(jsonData: json)
        nameArray = model.itemName
        print("reloadData")
        // 关键2：reloadData()，刷新页面数据
        tableView.reloadData()
    }
    
    // MARK: - @objc func
    @objc func presentAddItemVC() {
        // 3.受托
        let addItemVc = AddItemVC()
        addItemVc.delegate = self
        self.present(targetVC: addItemVc)
    }
    
}



// 委托类
class AddItemVC: UIViewController, UITextFieldDelegate {
    
    let nameTextField = UITextField()
    let addingButton = UIButton()
    
    let table = ReloadDataTable()
    lazy var result = table.search()
    
    // 4.定义委托变量delegate
    weak var delegate: CSReloadDelegate?
    
    // MARK: - 初始化与生命周期方法
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - func
    func setupUI() {
        view.setBackgroundColor(color: cFFF)
        
        nameTextField.setup(superview: view, placeholder: "名称", delegate: self)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: 20, right: 20, height: 48)
        nameTextField.addTarget(self, action: #selector(checkInputtedValue), for: .allEditingEvents)
        
        addingButton.setup(superview: view, target: self, action: #selector(addItem))
        addingButton.setFrame(left: 20, top: 84, right: 20, height: 48)
        addingButton.setStyleSolid17ptFgWhiteThemeButton(title: "添加")
    }
    
    // MARK: - @objc func
    @objc func checkInputtedValue(textField: UITextField) {
        if nameTextField.text == "" {
            addingButton.isEnabled = false
        } else {
            addingButton.isEnabled = true
        }
    }
    
    @objc func addItem() {
        
        let id = table.getNextId()
        let insertRow: [String: Any] = [
            "id": id,
            "itemName": nameTextField.text ?? ""
        ]

        let insertJSON = JSON(insertRow)
        print(insertJSON)
        table.insert(item: insertJSON)
        table.printId()
        
        self.dismiss()
        
        // 5.委托
        if delegate != nil {
            delegate!.reloadData()
        }
    }

}
