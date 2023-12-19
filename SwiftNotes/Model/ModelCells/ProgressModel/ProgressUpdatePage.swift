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

class CSProgressUpdatePage: UIViewController, UITextFieldDelegate {
    
    // 从父页面获取编辑数据的id
    public var updatedId = 0
    
    
    let table = ProgressTable()
    
    let navPresent = CSPresentNav()
    
    let currentProgressTextField = UITextField()
    let startTimeTextField = UITextField()
    let endTimeTextField = UITextField()
    let itemIdTextField = UITextField()
    let updateButton = UIButton()
    // 删除按钮
    let deleteButton = UIButton(type: .system)
    
    weak var delegate: CSReloadDelegate?
    
    
    // MARK: - 生命周期方法

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackgroundColor(color: cFFF)
        
        // 从本地数据库取JSON值(以赋值给相应控件)、建模
        let result = table.getJSONOneRow(id: updatedId)
        let model = CSProgressUpdateModel(jsonData: result)
        let currentProgressNum = model.currentProgress
        let startTimeNum = model.startTime
        let endTimeNum = model.endTime
        let itemIdNum = model.itemId
        print("currentProgressNum \(currentProgressNum)")
        print(startTimeNum)
        
        navPresent.setTitleLabel(superview: view, title: "Update")
        navPresent.setCloseButton(superview: view, target: self, action: #selector(dismissPage))
        
        currentProgressTextField.setup(superview: view, placeholder: "currentProgress", delegate: self, text: String(currentProgressNum))
        currentProgressTextField.setStyleOneLineTextField()
        currentProgressTextField.setFrame(left: 20, top: navPresent.titleLabel.bottom + 20, right: 20, height: 48)
        
        startTimeTextField.setup(superview: view, placeholder: "startTime", delegate: self, text: String(startTimeNum))
        startTimeTextField.setStyleOneLineTextField()
        startTimeTextField.setFrame(left: 20, top: currentProgressTextField.bottom + 20, right: 20, height: 48)
        
        endTimeTextField.setup(superview: view, placeholder: "entTime", delegate: self, text: String(endTimeNum))
        endTimeTextField.setStyleOneLineTextField()
        endTimeTextField.setFrame(left: 20, top: startTimeTextField.bottom + 20, right: 20, height: 48)
        
        itemIdTextField.setup(superview: view, placeholder: "itemId", delegate: self, text: String(itemIdNum))
        itemIdTextField.setStyleOneLineTextField()
        itemIdTextField.setFrame(left: 20, top: endTimeTextField.bottom + 20, right: 20, height: 48)
        
        updateButton.setup(superview: view, target: self, action: #selector(updateProgress))
        updateButton.setStyleSolid17ptFgWhiteThemeButton(title: "update")
        updateButton.setFrame(left: 20, top: itemIdTextField.bottom + 20, right: 20, height: 48)
        
        // 删除
        deleteButton.setup(superview: view, target: self, action: #selector(deleteProgress))
        deleteButton.setStyleWord17ptRedButton(title: "Delete")
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
        
        let result = table.getJSONOneRow(id: updatedId)
        let model = CSProgressUpdateModel(jsonData: result)
        let currentProgressNum = model.currentProgress
        print("updated currentProgressNum \(currentProgressNum)")
        
        if delegate != nil {
            delegate!.reloadData()
        }
        
        self.dismiss()
    }
    
    @objc func deleteProgress() {
        table.delete(id: updatedId)
        
        if delegate != nil {
            delegate!.reloadData()
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
struct CSProgressUpdateModel {
    var id: Int
    var currentProgress: Int
    var startTime: Int
    var endTime: Int
    var itemId: Int
    
    init(jsonData: JSON) {
        id = jsonData["id"].intValue
        currentProgress = jsonData["currentProgress"].intValue
        startTime = jsonData["startTime"].intValue
        endTime = jsonData["endTime"].intValue
        itemId = jsonData["itemId"].intValue
    }
}
