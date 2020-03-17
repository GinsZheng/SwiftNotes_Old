//
//  JoinedUpdatePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/15.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite

class CSJoinedUpdatePage: UIViewController, UITextFieldDelegate {
    
    // 从父页面获取编辑数据的id
    public var updatedId = 0
    
    let navPresent = UIPresentNav()
    
    let currentProgressTextField = UITextField()
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let itemIdTextField = UITextField()
    let updateButton = UIButton()
    // 删除按钮
    let deleteButton = UIButton(type: .system)
    
    let table = CSJoinedTable()
    
    weak var delegate: CSReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 从本地数据库取JSON值(以赋值给相应控件)、建模
        let result = table.getJSONOneRow(id: updatedId)
        let model = CSJoinedUpdateModel(jsonData: result)
        
        navPresent.setTitleLabel(superview: view, title: "Update")
        navPresent.setCloseButton(superview: view, target: self, action: #selector(dismissPage))
        
        currentProgressTextField.set(superview: view, placeholder: "currentProgress", delegate: self, text: String(model.currentProgress))
        currentProgressTextField.setStyleOneLineTextField()
        currentProgressTextField.setFrame(left: 20, top: navPresent.titleLabel.bottom + 20, right: 20, height: 48)
        
        startTimeTextField.set(superview: view, placeholder: "startTime", delegate: self, text: String(model.startTime))
        startTimeTextField.setStyleOneLineTextField()
        startTimeTextField.setFrame(left: 20, top: currentProgressTextField.bottom + 20, right: 20, height: 48)
        
        endTimeTextField.set(superview: view, placeholder: "entTime", delegate: self, text: String(model.endTime))
        endTimeTextField.setStyleOneLineTextField()
        endTimeTextField.setFrame(left: 20, top: startTimeTextField.bottom + 20, right: 20, height: 48)
        
        itemIdTextField.set(superview: view, placeholder: "itemId", delegate: self, text: String(model.itemId))
        itemIdTextField.setStyleOneLineTextField()
        itemIdTextField.setFrame(left: 20, top: endTimeTextField.bottom + 20, right: 20, height: 48)
        
        updateButton.set(superview: view, target: self, action: #selector(updateProgress))
        updateButton.setStyleSolidBtn(title: "update")
        updateButton.setFrame(left: 20, top: itemIdTextField.bottom + 20, right: 20, height: 48)
        
        // 删除
        deleteButton.set(superview: view, target: self, action: #selector(deleteProgress))
        deleteButton.setStyleWordButton(title: "Delete", titleColor: cRed_FF5349)
        deleteButton.setFrame(centerX: view.centerX, top: updateButton.bottom + 10, width: 80, height: 44)
    }
    
    
    @objc func dismissPage() {
        self.dismiss()
    }
    
    @objc func updateProgress() {
        let updateValue: [String: Any] = [
            "currentProgress": Int(currentProgressTextField.text ?? "") ?? 0,
            "startTime": Int(startTimeTextField.text ?? "") ?? 0,
            "endTime": Int(endTimeTextField.text ?? "") ?? 100,
            "itemId": Int(itemIdTextField.text ?? "") ?? 0
        ]
        let updateJson = JSON(updateValue)
        table.update(id: updatedId, item: updateJson)
        
        if delegate != nil {
            delegate!.reloadItemsList()
        }
        
        self.dismiss()
    }
    
    @objc func deleteProgress() {
        table.delete(id: updatedId)
        
        if delegate != nil {
            delegate!.reloadItemsList()
        }
        
        self.dismiss()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        print("释放")
    }
    
}


// 建模
struct CSJoinedUpdateModel {
    var id: Int
    var currentProgress: Int
    var startTime: Int
    var endTime: Int
    var itemId: Int
    var createTime: Int
    
    init(jsonData: JSON) {
        id = jsonData["id"].intValue
        currentProgress = jsonData["currentProgress"].intValue
        startTime = jsonData["startTime"].intValue
        endTime = jsonData["endTime"].intValue
        itemId = jsonData["itemId"].intValue
        createTime = jsonData["createTime"].intValue
    }
}