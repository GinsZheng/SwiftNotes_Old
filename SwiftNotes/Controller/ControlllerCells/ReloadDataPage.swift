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
// 如果不是 dismiss() 过场，直接在父VC用viewDidLoad()即可刷新，不用委托
protocol CSReloadDelegate: NSObjectProtocol {
    func reloadItemsList()
}

class CSReloadDataPage: UIViewController, UITableViewDelegate, UITableViewDataSource, CSReloadDelegate {

    var itemName = [String]()
    
    let itemTable = CSReloadDataModel()
    
    let addItemBtn = UIButton(type: .custom)
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        for name in itemTable.search() {
            itemName.append(name[itemTable.name])
        }
        
        addItemBtn.set(superview: view, target: self, action: #selector(presentAddItemVC))
        addItemBtn.setFrame(right: 20, top: 0, width: 25, height: 20)
        addItemBtn.setImage(UIImage(named: "progress_addItem"), for: .normal)
        
        tableView.set(superview: view, delegate: self, dataSource: self)
        tableView.setFrame(left: 0, top: 20, right: 0, height: self.getSafeAreaHeight(inset: 40))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "itemList")
        cell.setFrame(left: 0, top: 0, width: kScreenWidth, height: 0)
        cell.textLabel?.text = itemName[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    
    @objc func presentAddItemVC() {
        
        let addItemVc = AddItemVC()
        addItemVc.delegate = self
        self.present(toTarget: addItemVc)
    }
    
    func reloadItemsList() {
        // 如果不需要把已加载的清除，则不用把itemName清空，直接再遍历
        itemName = []
        
        for name in itemTable.search() {
            itemName.append(name[itemTable.name])
        }
        print("reloadData")
        // 关键：reloadData()，刷新页面数据
        tableView.reloadData()
    }
}



class AddItemVC: UIViewController, UITextFieldDelegate {
    
    let nameTextField = UITextField()
    let addingButton = UIButton()
    
    let itemTable = CSReloadDataModel()
    lazy var result = itemTable.search()
    
    weak var delegate: CSReloadDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        nameTextField.set(superview: view, placeholder: "名称", delegate: self)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: 20, right: 20, height: 48)
        nameTextField.addTarget(self, action: #selector(checkInputtedValue), for: .allEditingEvents)
        
        addingButton.set(superview: view, target: self, action: #selector(addItem))
        addingButton.setFrame(left: 20, top: 84, right: 20, height: 48)
        addingButton.setStyleSolidBtn(title: "添加")
    }
    
    @objc func checkInputtedValue(textField: UITextField) {
        if nameTextField.text == "" {
            addingButton.isEnabled = false
        } else {
            addingButton.isEnabled = true
        }
    }
    
    @objc func addItem() {
        
        let autoId = itemTable.getCount()
        print(autoId)
        let insertRow: [String: Any] = [
            "id": autoId,
            "name": nameTextField.text ?? ""
        ]

        let insertJSON = JSON(insertRow)
        print(insertJSON)
        itemTable.insert(item: insertJSON)
        itemTable.printId()
        
        self.dismiss()
        
        if delegate != nil {
            delegate!.reloadItemsList()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        print("释放")
    }
}
