//
//  CSUpdatePage.swift
//  SwiftNotes
//
//  Created by GinsMac on 2020/3/14.
//  Copyright © 2020 GinsMac. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite

class CSUpdatePage: UIViewController, UITextFieldDelegate {
    
    public var updatedId = 0
    
    let navPresent = UIPresentNav()
    
    let nameTextField = UITextField()
    let resumeTextField = UITextField()
    let totalProgressTextField = UITextField()
    let colorTextField = UITextField()
    let updateButton = UIButton()
    // 删除按钮
    let deleteButton = UIButton(type: .system)
    
    let itemTable = CSBasicTable()
    
    weak var delegate: CSReloadDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let result = itemTable.getJSONOneRow(id: updatedId)
        let itemTable = CSUpdateItemModel(jsonData: result)
        print("itemTable name \(itemTable.name)")
        
        navPresent.setTitleLabel(superview: view, title: "Update")
        navPresent.setCloseButton(superview: view, target: self, action: #selector(dismissPage))
        
        nameTextField.set(superview: view, placeholder: "name", delegate: self, text: itemTable.name)
        nameTextField.setStyleOneLineTextField()
        nameTextField.setFrame(left: 20, top: navPresent.titleLabel.bottom + 20, right: 20, height: 48)
        
        resumeTextField.set(superview: view, placeholder: "resume", delegate: self, text: itemTable.resume)
        resumeTextField.setStyleOneLineTextField()
        resumeTextField.setFrame(left: 20, top: nameTextField.bottom + 20, right: 20, height: 48)
        
        totalProgressTextField.set(superview: view, placeholder: "totalProgress", delegate: self, text: "\(itemTable.totalProgress)")
        totalProgressTextField.setStyleOneLineTextField()
        totalProgressTextField.setFrame(left: 20, top: resumeTextField.bottom + 20, right: 20, height: 48)
        
        colorTextField.set(superview: view, placeholder: "color(Int)", delegate: self, text: "\(itemTable.color)")
        colorTextField.setStyleOneLineTextField()
        colorTextField.setFrame(left: 20, top: totalProgressTextField.bottom + 20, right: 20, height: 48)
        
        updateButton.set(superview: view, target: self, action: #selector(updateItem))
        updateButton.setStyleSolidBtn(title: "Update")
        updateButton.setFrame(left: 20, top: colorTextField.bottom + 20, right: 20, height: 48)
        
        
        
        // 删除
        deleteButton.set(superview: view, target: self, action: #selector(deleteItem))
        deleteButton.setStyleWordButton(title: "Delete", titleColor: cRed_FF5349)
        deleteButton.setFrame(centerX: view.centerX, top: updateButton.bottom + 10, width: 80, height: 44)
        
    }
    
    
    @objc func dismissPage() {
        self.dismiss()
    }
    
    @objc func updateItem() {
        let updateValue: [String: Any] = [
            "name": nameTextField.text ?? "",
            "resume": resumeTextField.text ?? "",
            "totalProgress": Int(totalProgressTextField.text ?? "") ?? 100,
            "color": Int(colorTextField.text ?? "") ?? 0
        ]
        print(updateValue)
        let updateJson = JSON(updateValue)
        itemTable.update(id: updatedId, item: updateJson)
        
        if delegate != nil {
            delegate!.reloadItemsList()
        }
        
        self.dismiss()
    }
    
    @objc func deleteItem() {
        itemTable.delete(id: updatedId)
        
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
struct CSUpdateItemModel {
    var id: Int
    var name: String
    var resume: String
    var totalProgress: Int
    var color: Int
    
    init(jsonData: JSON) {
        id = jsonData["id"].intValue
        name = jsonData["name"].stringValue
        resume = jsonData["resume"].stringValue
        totalProgress = jsonData["totalProgress"].intValue
        color = jsonData["color"].intValue
    }
}
