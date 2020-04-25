//
//  CSItemUpdatePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite

class CSItemUpdatePage: UIViewController, UITextFieldDelegate {
    
    // 从父页面获取编辑数据的id
    public var updatedId = 0
    
    let navPresent = CSPresentNav()
    
    let nameTextField = UITextField()
    let resumeTextField = UITextField()
    let totalProgressTextField = UITextField()
    let colorTextField = UITextField()
    let updateButton = UIButton()
    // 删除按钮
    let deleteButton = UIButton(type: .system)
    
    let itemTable = CSItemTable()
    
    weak var delegate: CSReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // 从本地数据库取JSON值(以赋值给相应控件)、建模
        let result = itemTable.getJSONOneRow(id: updatedId)
        let model = CSItemUpdateModel(jsonData: result)
        
        navPresent.setTitleLabel(superview: view, title: "Update")
        navPresent.setCloseButton(superview: view, target: self, action: #selector(dismissPage))
        
        nameTextField.set(superview: view, placeholder: "itemName", delegate: self, text: model.itemName)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: navPresent.titleLabel.bottom + 20, right: 20, height: 48)
        
        resumeTextField.set(superview: view, placeholder: "resume", delegate: self, text: model.resume)
        resumeTextField.setStyleOneLineTextField()
        resumeTextField.setFrame(left: 20, top: nameTextField.bottom + 20, right: 20, height: 48)
        
        totalProgressTextField.set(superview: view, placeholder: "totalProgress", delegate: self, text: "\(model.totalProgress)")
        totalProgressTextField.setStyleOneLineTextField()
        totalProgressTextField.setFrame(left: 20, top: resumeTextField.bottom + 20, right: 20, height: 48)
        
        colorTextField.set(superview: view, placeholder: "color(Int)", delegate: self, text: "\(model.color)")
        colorTextField.setStyleOneLineTextField()
        colorTextField.setFrame(left: 20, top: totalProgressTextField.bottom + 20, right: 20, height: 48)
        
        updateButton.set(superview: view, target: self, action: #selector(updateItem))
        updateButton.setStyleSolidBtn(title: "Update")
        updateButton.setFrame(left: 20, top: colorTextField.bottom + 20, right: 20, height: 48)
        
        
        
        // 删除
        deleteButton.set(superview: view, target: self, action: #selector(deleteItem))
        deleteButton.setStyleWordButton(title: "Delete", titleColor: cRed_FF635A)
        deleteButton.setFrame(centerX: view.centerX, top: updateButton.bottom + 10, width: 80, height: 44)
        
    }
    
    
    @objc func dismissPage() {
        self.dismiss()
    }
    
    @objc func updateItem() {
        let updateValue: [String: Any] = [
            "itemName": nameTextField.text ?? "",
            "resume": resumeTextField.text ?? "",
            "totalProgress": Int(totalProgressTextField.text ?? "") ?? 100,
            "color": Int(colorTextField.text ?? "") ?? 0
        ]
        print(updateValue)
        let updateJson = JSON(updateValue)
        itemTable.update(id: updatedId, item: updateJson)
        
        if delegate != nil {
            delegate!.reloadData()
        }
        
        self.dismiss()
    }
    
    @objc func deleteItem() {
        itemTable.delete(id: updatedId)
        
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
struct CSItemUpdateModel {
    var id: Int
    var itemName: String
    var resume: String
    var totalProgress: Int
    var color: Int
    
    init(jsonData: JSON) {
        id = jsonData["id"].intValue
        itemName = jsonData["itemName"].stringValue
        resume = jsonData["resume"].stringValue
        totalProgress = jsonData["totalProgress"].intValue
        color = jsonData["color"].intValue
    }
}
